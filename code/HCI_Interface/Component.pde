
/*
  Components are what gives UIElements functionality. 
 i.e. Render the UIElement as a button, text, ... but also detecting the mouse pointer, moving UIElements...
 So UIElements are basically containers for multiple components. This collection of components forms the behaviour of the UIElement.
 
 So when creating a button as an example, do the following
 - Create an instance of UIElement and position it somewhere
 - Add the Button component (this renders the UIElement as a button)
 - Add a Collider component (so that the UIElement can detect the mouse and so that other components may use it)
 */

class Component {
  public UIElement ui_element;

  public void Start() {
  }

  public void Update() {
  }

  public UIElement GetUIElement() {
    return ui_element;
  }
}

// -------------------------------------------------------------------------------------------------------------------

/*
  A rect is used to describe the shape of a rectangle. 
 The first two values are the coordinates of the top-left corner. The last two values are the coordinates of the bottom-right corner.
 Consider the following rectangle:
 
     1  2  3  4  5  6  7  8  9
 1
 2   ----------------------
 3   |                    |
 4   |                    |
 5   |                    |
 6   |                    |
 7   ----------------------
 8
 9
 
 This would translate to the following rectangle:
 Rect r {
 top = 2
 bot = 7
 left = 1
 right = 8
 }
 
 The rectangle is meant to be used for describing the position of UIElements
 
 */

class Rect {
  public float top;
  public float bot;
  public float left;
  public float right;

  Rect(float left, float top, float right, float bot) {
    this.top = top;
    this.bot = bot;
    this.left = left;
    this.right = right;
  }

  String toString() {
    return "[" + left + ", " + top + ", " + right + ", " + bot + "]";
  }

  public void Translate(PVector x) {
    top += x.y;
    bot += x.y;
    left += x.x;
    right += x.x;
  }

  public void Scale(float x) {
    float mx = (left + right) / 2;
    float my = (top + bot) / 2;

    top = (top - my) * x + my;
    bot = (bot - my) * x + my;
    left = (left - mx) * x + mx;
    right = (right - mx) * x + mx;
  }

  public void ClampRect(Rect r) {
    top = min(max(top, r.top), r.bot);
    bot = min(max(bot, r.top), r.bot);
    left = min(max(left, r.left), r.right);
    right = min(max(right, r.left), r.right);
  }

  public void Clamp(float minimum, float maximum) {
    top = min(max(top, minimum), maximum);
    bot = min(max(bot, minimum), maximum);
    left = min(max(left, minimum), maximum);
    right = min(max(right, minimum), maximum);
  }

  public void Clamp01() {
    Clamp(0, 1);
  }
}

/*
  Transform is probably the most complex and most important component.
 It describes the position of a UIElement SPACIALLY AND IN THE HIERARCHY.
 It is also the only component that is automatically bound to every UIElement by default.
 
 What is the hierarchy?
 Every UI has a hierarchy of some sort. For example:
 - A login window usually has a username-field, a password-field and a login-button that are grouped together.
 - When opening any social media website, there is usually a navigation header (with multiple buttons), a feed with multiple text sections, a list of friends
 and all those elements are different from each other and they contain multiple other elements (e.g. multiple buttons, images, texts, ...)
 
 The UI for this program is grouped in a similar manner
 - Each object/UIElement has a parent.
 - UIElements can have multiple children (or just one, or none)
 - This means that all UIElements together form a tree of parents/children
 - The root of this tree is also a UIElement, usually an instance of class Canvas
 
 Now for spatial positioning of UIElements
 - The position of an UIElement is always defined relative to its parent.
 - The position is of type rect which basically defines the position of the top-left and the bottom-right corner of a UIElement.
 - position describes the pixel-position and pixel-size to its parent, so it is not relative to size.
 - the anchor is relative to the size of the parent. basically 
 - anchor = (0,0,0,0) means that "position" relates to the pixel position of the top-left corner of the parent
 - anchor = (0.5, 0.5, 0.5, 0.5) means that "position" relates to the pixel position relative to the center of the parent
 - anchor = (0, 0, 1, 0) means that "position" stretches the whole x-axis at the top of the parent
 - anchor = (0, 0, 1, 1) means that "position" fills the whole space the parent occupies.
 To get a feel for this it is best to look at the code of the function GlobalBounds().
 
 Why so complicated?
 - There has to be some sort of hierarchy to create a structured UI. Everything else would be a mess.
 - There has to be some notion of position and size
 - Since users can move some stuff around freely, they should be able to decide how large the "canvas" is on which they move stuff around.
 - To make UI resizable, relative size/position (to the parent) should be used instead of pixel
 - But making everythig purely relative to the parent size is also bad because i.e. buttons should be of a fixed size. 
 - To work with relative sizes exclusively can also be kind of a hassle. With pixels you know exactly what you get.
 
 */

class Transform extends Component {

  public Transform parent;
  public ArrayList<Transform> children;

  public Rect position;
  public Rect anchor;

  Transform(Transform p, int x, int y, int sx, int sy) {
    this.children = new ArrayList<Transform>();

    this.position = new Rect(x, y, sx, sy);
    this.anchor = new Rect(0, 0, 0, 0);

    SetParent(p);
  }

  Transform() {
    this(null, 0, 0, 100, 100);
  }

  Transform(Transform p) {
    this(p, 0, 0, 100, 100);
  }

  public void SetParent(Transform p) {
    if (parent != null) {
      parent.children.remove(this);
    }
    if (p != null) {
      p.children.add(this);
    }
    parent = p;
  }

  public void SetAnchor(Rect anchor) {
    this.anchor = anchor;
  }

  public PVector getPosition() {
    Rect r = GlobalBounds();
    return new PVector(r.left, r.top);
  }

  public PVector getSize() {
    Rect r = GlobalBounds();
    return new PVector(r.right - r.left, r.bot - r.top);
  }

  public Rect GlobalBounds() {
    if (parent == null) {
      return position;
    } else {
      Rect r = parent.GlobalBounds();
      return new Rect(
        lerp(r.left, r.right, anchor.left) + position.left, 
        lerp(r.top, r.bot, anchor.top) + position.top, 
        lerp(r.left, r.right, anchor.right) + position.right, 
        lerp(r.top, r.bot, anchor.bot) + position.bot
        // lerp(start,stop,amt) calculates a number between start and stop at a specific increment. 
        // The amt parameter is the amount to interpolate between the two values where 0.0 is equal to the first point, 0.1 is very near 
        // to the first point, 0.5 is half-way in between and so on.
        );
    }
  }

  public PVector RelativeFromAbsolute(PVector pos) {
    Rect r = GlobalBounds();
    return new PVector((pos.x - r.left) / (r.right - r.left), (pos.y - r.top) / (r.bot - r.top));
  }

  // Draws a green rectangle around the bounds of the transform. Hand for debugging UIElements that don't render anything else.
  public void DebugRender() {
    Rect r = GlobalBounds();
    PApplet pa = GetUIElement().applet;

    pa.noFill();
    pa.stroke(#00ff00);
    pa.strokeWeight(1);
    pa.rect(r.left, r.top, r.right - r.left, r.bot - r.top);
    pa.noStroke();
  }
}

// -------------------------------------------------------------------------------------------------------------------

/* 
 A panel is a component that renders the UIElement as a rectangle with a solid color
 */

class Panel extends Component {
  public color c;

  private float round_factor = 0;

  Panel(color c, float round_factor) {
    this.c = c;
    this.round_factor = round_factor;
  }

  Panel(color c) {
    this(c, 0);
  }

  public void Update() {
    Transform t = GetUIElement().transform;
    Rect bbox = t.GlobalBounds();
    PApplet pa = GetUIElement().applet;

    pa.fill(c);
    pa.noStroke();
    pa.rect(bbox.left, bbox.top, bbox.right-bbox.left, bbox.bot-bbox.top, round_factor);
  }
}

// -------------------------------------------------------------------------------------------------------------------

/*
  The collider is a component that detects when the mouse hovers over it or clicks it.
 It sends the according messages to its UIElement.
 
 The messages are:
 - void OnClickEnter()  ==> The first frame that the UIElement is clicked.
 - void OnClickUpdate() ==> Every frame while the UIElement is "kept pressed".
 - void OnClickUpdate() ==> The first frame where UIElement is not clicked anymore.
 - void OnHoverEnter()  ==> The first frame that the UIElement is hovered on.
 - void OnHoverUpdate() ==> Every frame where the mouse pointer is positioned on the UIElement.
 - void OnHoverExit()   ==> The first frame where the mouse pointer is not positioned on the UIElement anymore.
 
 */
static boolean c_lock = false;  // This lock ensures that only one collider at a time can be clicked, grabbed, etc

class Collider extends Component {
  private boolean is_hovered;
  private boolean is_clicked;
  private boolean is_dragged;  // TODO: Implement


  Collider() {
    is_hovered = false;
    is_clicked = false;
    is_dragged = false;
  }


  public void Update() {
    Transform t = GetUIElement().transform;
    Rect bbox = t.GlobalBounds();
    PApplet pa = GetUIElement().applet;

    if (pa.mouseX > bbox.left && pa.mouseX < bbox.right && pa.mouseY > bbox.top && pa.mouseY < bbox.bot && !c_lock)
    {
      if (is_hovered) {
        ui_element.SendMessage("OnHoverUpdate");
      } else
      {
        is_hovered = true;
        ui_element.SendMessage("OnHoverEnter");
      }

      if (pa.mousePressed) {
        if (is_clicked) {
          ui_element.SendMessage("OnClickUpdate");
        } else
        {
          is_clicked = true;
          c_lock = true;
          ui_element.SendMessage("OnClickEnter");
        }
      } else
      {
        if (is_clicked) {
          is_clicked = false;
          c_lock = false;
          ui_element.SendMessage("OnClickExit");
        }
      }
    } else 
    {
      if (is_hovered) {
        is_hovered = false;
        ui_element.SendMessage("OnHoverExit");
      }

      if (is_clicked) {
        if (pa.mousePressed) {
          ui_element.SendMessage("OnClickUpdate");
        } else {
          is_clicked = false;
          c_lock = false;
          ui_element.SendMessage("OnClickExit");
        }
      }
    }
  }
}

// -------------------------------------------------------------------------------------------------------------------

/*
  The button class is a component that displays a button. When clicked, it sends a message to a target UIElement.
 NOTE: THE BUTTON ONLY WORKS PROPERLY IF THE UIELEMENT ALSO HAS A COLLIDER ATTACHED!
 The button also changes color depending on if it is idle, hovered, pressed.
 */

class Button extends Component {
  // Functionality fields
  private boolean is_hovered;
  private boolean is_clicked;
  private UIElement click_target_uie;
  private UIElement hold_target_uie;
  private UIElement release_target_uie;
  private String click_message;
  private String hold_message;
  private String release_message;

  // Styling fields
  private String label;
  private color default_color = #bb86fc;
  private color click_color = #985eff;
  private color hover_color = #dbb2ff;
  private color text_color = #000000;
  private int text_size = 14;
  private float round_factor = 48;
  
  public void set_textsize(int x) {
    this.text_size = x;
  }
  
  // Additional Functionalities to use an image for a button (instead of text)
  public boolean is_image = false;
  public PImage default_image = null;
  public PImage click_image = null;
  public PImage hover_image = null;

  Button(String label, UIElement target_uie, String message) {
    this.label = label;
    this.is_hovered = false;
    this.is_clicked = false;
    this.click_target_uie = target_uie;
    this.click_message = message;
  }

  Button(String label) {
    this(label, null, "");
  }
  
  // Creates a button that displays an image instead of text
  Button(String label, UIElement target_uie, String message, PImage default_image, PImage click_image, PImage hover_image) {
    this(label, target_uie, message);
    this.is_image = true;
    this.default_image = default_image;
    this.hover_image = hover_image;
    this.click_image = click_image;
  }

  public void SetHoldMessage(UIElement target_uie, String message) {
    this.hold_target_uie = target_uie;
    this.hold_message = message;
  }

  public void SetReleaseMessage(UIElement target_uie, String message) {
    this.release_target_uie = target_uie;
    this.release_message = message;
  }

  public void Update() {
    Transform t = GetUIElement().transform;
    Rect bbox = t.GlobalBounds();
    PApplet pa = GetUIElement().applet;
    
    if(!is_image) {
      if (is_clicked) {
          pa.fill(click_color);} 
      else if (is_hovered) {
          pa.fill(hover_color);} 
      else {
          pa.fill(default_color);}
      pa.noStroke();
      pa.rect(bbox.left, bbox.top, bbox.right-bbox.left, bbox.bot-bbox.top, round_factor);
  
      pa.fill(text_color);
      pa.textSize(text_size);
      pa.textAlign(CENTER, CENTER);
      pa.text(label, (bbox.left + bbox.right) / 2, (bbox.top + bbox.bot) / 2);
    }
    else { // Button is an image
      if (is_clicked) {
          pa.image(click_image, bbox.left, bbox.top, bbox.right - bbox.left, bbox.bot - bbox.top);} 
      else if (is_hovered) {
          pa.image(hover_image, bbox.left, bbox.top, bbox.right - bbox.left, bbox.bot - bbox.top);} 
      else {
          pa.image(default_image, bbox.left, bbox.top, bbox.right - bbox.left, bbox.bot - bbox.top);}
    }

    
  }

  void OnClickEnter() {
    println("Clicked button", label);
    is_clicked = true;
    if (click_target_uie != null) {
      click_target_uie.SendMessage(click_message);
    }
  }

  void OnClickUpdate() {
    if (hold_target_uie != null) {
      hold_target_uie.SendMessage(hold_message);
    }
  }

  void OnClickExit() {
    is_clicked = false;
    if (release_target_uie != null) {
      release_target_uie.SendMessage(release_message);
    }
  }

  void OnHoverEnter() {
    is_hovered = true;
  }

  void OnHoverExit() {
    is_hovered = false;
  }
}

// -------------------------------------------------------------------------------------------------------------------

/*
  A component that renders a text label
 */

class TextLabel extends Component {
  public String label;
  public color text_color;
  public int text_size;
  public int v_align;
  public int h_align;

  TextLabel(String label, color text_color, int text_size, int h_align, int v_align) {
    this.label = label;
    this.text_color = text_color;
    this.text_size = text_size;
    this.h_align = h_align;
    this.v_align = v_align;
  }

  TextLabel(String label, color text_color, int text_size) {
    this(label, text_color, text_size, LEFT, CENTER);
  }


  TextLabel(String label, color text_color) {
    this(label, text_color, 12, LEFT, CENTER);
  }

  public void SetLabel(String label) {
    this.label = label;
  }

  public void Update() {
    Transform t = GetUIElement().transform;
    Rect bbox = t.GlobalBounds();
    PApplet pa = GetUIElement().applet;

    pa.fill(text_color);
    pa.textSize(text_size);
    pa.textAlign(h_align, v_align);
    pa.text(label, bbox.left, bbox.top, bbox.right-bbox.left, bbox.bot-bbox.top);
  }
}

// -------------------------------------------------------------------------------------------------------------------

// Displays a user as a bubble
// Can be moved around when clicked
// NOTE: fOR THIS COMPONENT TO WORK PROPERLY, ADD A COLLIDER TO THE UIELEMENT!!!
// To see how to actually use this component, refer to the example in the "Room" tab

// TODO: Add buttons for size, level, mute and expose their functionality.

// If you want to change the name of picture, use SetName(String) and SetPicture(PImage)

class UserBubble extends Component {
  public PImage image;
  public String name;
  public int level;
  public boolean is_speaking;
  public boolean show_buttons;

  private color not_speaking_color = #FFFFFF;
  private color speaking_color = #44FF44;
  private int speech_ring_weight = 5;

  private UIElement name_bubble;
  private UIElement level_bubble;

  private UIElement mute_button;
  private UIElement level_button;
  private UIElement resize_button;
  private UIElement move_button;

  UserBubble(String name, PImage image, int level) {
    this.name = name;
    this.image = image;
    this.level = level;

    this.is_speaking = false;
    this.show_buttons = true;
  }

  UserBubble(String name) {
    this(name, null, 1);
  }

  // Manipulate the UIElement with the following methods
  public void SetName(String name) {
    this.name = name;
  }

  public void SetImage(PImage image) {
    this.image = image;
  }

  public void ToggleButtons() {
    show_buttons = !show_buttons;

    mute_button.SetActive(show_buttons);
    level_button.SetActive(show_buttons);
    resize_button.SetActive(show_buttons);
    move_button.SetActive(show_buttons);
  }

  // Code for updating/rendering. Ignore this code if you only want to change the appearance of the UIElement
  public void Start() {
    UIElement puie = GetUIElement();
    Button b;

    name_bubble = new UIElement(puie.applet, puie.transform, new Rect(-50, 5, 50, 30), new Rect(.3, 1, .7, 1));
    name_bubble.AddComponent(new Panel(#292929, 24));
    name_bubble.AddComponent(new TextLabel(name, #FFFFFF, 14, CENTER, CENTER));

    level_bubble = new UIElement(puie.applet, puie.transform, new Rect(-20, -15, 15, 20), new Rect(.9, .9, .9, .9));
    level_bubble.AddComponent(new Panel(#bb86fc, 48));
    level_bubble.AddComponent(new TextLabel(str(level), #FFFFFF, 14, CENTER, CENTER));

    mute_button = new UIElement(puie.applet, puie.transform, new Rect(-96, -72, -4, -40), new Rect(0, .5, 0, .5));
    mute_button.AddComponent(new Collider());
    mute_button.AddComponent(new Button("MUTE"));

    level_button = new UIElement(puie.applet, puie.transform, new Rect(-96, -32, -4, 0), new Rect(0, .5, 0, .5));
    level_button.AddComponent(new Collider());
    level_button.AddComponent(new Button("LEVEL"));

    resize_button = new UIElement(puie.applet, puie.transform, new Rect(-96, 8, -4, 40), new Rect(0, .5, 0, .5));
    resize_button.AddComponent(new Collider());
    b = new Button("RESIZE");
    b.SetHoldMessage(puie, "Resize");
    resize_button.AddComponent(b);

    move_button = new UIElement(puie.applet, puie.transform, new Rect(-96, 48, -4, 80), new Rect(0, .5, 0, .5));
    move_button.AddComponent(new Collider());
    b = new Button("MOVE");
    b.SetHoldMessage(puie, "Move");
    move_button.AddComponent(b);

    ToggleButtons();
  }

  public void Update() {
    Transform t = GetUIElement().transform;
    Rect bbox = t.GlobalBounds();
    PApplet pa = GetUIElement().applet;

    ((TextLabel)name_bubble.GetComponent("TextLabel")).SetLabel(name);
    ((TextLabel)level_bubble.GetComponent("TextLabel")).SetLabel(str(level));

    if (image != null) {
      PGraphics mask = createGraphics(image.width, image.height);
      mask.beginDraw();
      mask.background(0);
      mask.fill(255);
      mask.ellipse(image.width/2, image.height/2, image.width * 0.85, image.height * 0.85);
      mask.endDraw();

      image.mask(mask);
      pa.image(image, bbox.left, bbox.top, bbox.right - bbox.left, bbox.bot - bbox.top);
    } else {
      pa.image(loadImage("images/baseline_account.png"), bbox.left, bbox.top, bbox.right - bbox.left, bbox.bot - bbox.top);
    }    
    pa.noFill();
    pa.strokeWeight(speech_ring_weight);
    if (is_speaking) {
      pa.stroke(speaking_color);
    } else {
      pa.stroke(not_speaking_color);
    }
    pa.ellipse((bbox.left + bbox.right) / 2, (bbox.top + bbox.bot) / 2, bbox.right - bbox.left, bbox.bot - bbox.top);
    pa.noStroke();
  }

  public void Resize() {
    Transform t = GetUIElement().transform;
    Rect bbox = t.GlobalBounds();
    PApplet pa = GetUIElement().applet;

    float sensitivity = 0.004;
    float delta = pa.pmouseY - pa.mouseY;

    t.position.Scale(1 + delta * sensitivity);
  }

  public void Move() {
    Transform t = GetUIElement().transform;
    Rect bbox = t.GlobalBounds();
    PApplet pa = GetUIElement().applet;

    Rect ca = t.anchor;
    PVector o = t.parent.RelativeFromAbsolute(new PVector(pa.mouseX - pa.pmouseX, pa.mouseY - pa.pmouseY));
    ca.Translate(o);
    ca.ClampRect(new Rect(0.05, 0.05, 0.95, 0.85));
  }

  public void OnClickEnter() {
    ToggleButtons();
  }

  public void OnClickUpdate() {
    Move();
  }
}

// -----------------------------------------------------------------------------------------------------------------------------------------

// Utility comonent that defines the functionality when pressing the "CREATE ROOM" button.
class CreateRoom extends Component {
  public void Create() {
    String path = GetUIElement().applet.args[0];

    String[] args = {"SideBar", path};
    RoomWindow sb = new RoomWindow();
    PApplet.runSketch(args, sb);
  }
  
  public void Settings() {
    String path = GetUIElement().applet.args[0];

    String[] args = {"SideBar", path};
    SettingsWindow sb = new SettingsWindow();
    PApplet.runSketch(args, sb);
  }
  
}

// -----------------------------------------------------------------------------------------------------------------------------------------

class BreakoutWindow extends Component {
  private UIElement background_panel;
  private UIElement room_name;
  private UIElement close_button;
  private UIElement screen_share_button;

  private color background_color;
  private String name;
  private float rounding_factor = 0;

  BreakoutWindow(String name, color c) {
    this.background_color = c;
    this.name = name;
  }

  BreakoutWindow() {
    this("New Room", #121212);
  }

  public void Start() {
    UIElement puie = GetUIElement();
    Button b;

    background_panel = new UIElement(puie.applet, puie.transform, new Rect(0, 0, 1, 1));
    background_panel.AddComponent(new Panel(background_color, rounding_factor));

    room_name = new UIElement(puie.applet, background_panel.transform, new Rect(16, 0, 0, 64), new Rect(0, 0, .8, 0));
    room_name.AddComponent(new TextLabel(name, #DBB2FF, 16, LEFT, CENTER));

    close_button = new UIElement(puie.applet, background_panel.transform, new Rect(-32, 0, 0, 32), new Rect(1, 0, 1, 0));
    close_button.AddComponent(new TextLabel("X", #DBB2FF, 16, CENTER, CENTER));


    screen_share_button = new UIElement(puie.applet, background_panel.transform, new Rect(4, -52, 188, -4), new Rect(0, 1, 0, 1));
    screen_share_button.AddComponent(new Collider());
    screen_share_button.AddComponent(new Button("SHARE SCREEN"));
  }

  public void Update() {
  }
}
