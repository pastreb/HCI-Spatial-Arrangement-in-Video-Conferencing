/*
  Components are what gives UIElements functionality. 
  i.e. Render the UIElement as a button, text, ... but also detecting the mouse pointer, moving UIElements...
  So UIElements are basically containers for multiple components. This collection of components forms the behaviour of the UIElement.
  
  So when creating a button as an example, do the following
  - Create an instance of UIElement and position it somewhere
  - Add the Button component (this renders the UIElement as a button)
  - Add a Collider component (so that the UIElement can detect the mouse and so that other components may use it)
*/

class Component{
  public UIElement ui_element;
  
  public void Update(){}
  
  public UIElement GetUIElement(){
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
  
  public PVector getPosition(){
    Rect r = GlobalBounds();
    return new PVector(r.left, r.top);
  }
  
  public PVector getSize(){
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
        );
    }
  }
  
  // Draws a green rectangle around the bounds of the transform. Hand for debugging UIElements that don't render anything else.
  public void DebugRender() {
    Rect r = GlobalBounds();
    PApplet pa = GetUIElement().applet;
    
    pa.noFill();
    pa.stroke(#00ff00);
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

  Panel(color c) {
    this.c = c;
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

class Collider extends Component {
  private boolean is_hovered;
  private boolean is_clicked;
  private boolean is_dragged;

  Collider() {
    is_hovered = false;
    is_clicked = false;
    is_dragged = false;
  }


  public void Update() {
    Transform t = GetUIElement().transform;
    Rect bbox = t.GlobalBounds();
    PApplet pa = GetUIElement().applet;

    if (pa.mouseX > bbox.left && pa.mouseX < bbox.right && pa.mouseY > bbox.top && pa.mouseY < bbox.bot)
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
          ui_element.SendMessage("OnClickEnter");
        }
      } else
      {
        if (is_clicked) {
          is_clicked = false;
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
        is_clicked = false;
        ui_element.SendMessage("OnClickExit");
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
  private UIElement target_uie;
  private String message;

  // Styling fields
  private String label;
  private color default_color = #bb86fc;
  private color click_color = #985eff;
  private color hover_color = #dbb2ff;
  private color text_color = #000000;
  private int text_size = 14;
  private float round_factor = 48;
  
  Button(String label, UIElement target_uie, String message){
    this.label = label;
    this.is_hovered = false;
    this.is_clicked = false;
    this.target_uie = target_uie;
    this.message = message;
  }
  
  Button(String label) {
    this(label, null, "");
  }

  public void Update() {
    Transform t = GetUIElement().transform;
    Rect bbox = t.GlobalBounds();
    PApplet pa = GetUIElement().applet;

    if (is_clicked) {
      pa.fill(click_color);
    } else if (is_hovered) {
      pa.fill(hover_color);
    } else {
      pa.fill(default_color);
    }
    
    pa.noStroke();
    pa.rect(bbox.left, bbox.top, bbox.right-bbox.left, bbox.bot-bbox.top, round_factor);

    pa.fill(text_color);
    pa.textSize(text_size);
    pa.textAlign(CENTER, CENTER);
    pa.text(label, (bbox.left + bbox.right) / 2, (bbox.top + bbox.bot) / 2);
  }

  void OnClickEnter() {
    println("Clicked button",label);
    is_clicked = true;
    if(target_uie != null){
      target_uie.SendMessage(message);
    }
  }

  void OnClickExit() {
    is_clicked = false;
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

  TextLabel(String label, color text_color, int text_size) {
    this.label = label;
    this.text_color = text_color;
    this.text_size = text_size;
  }

  TextLabel(String label, color text_color) {
    this(label, text_color, 12);
  }

  public void Update() {
    Transform t = GetUIElement().transform;
    Rect bbox = t.GlobalBounds();
    PApplet pa = GetUIElement().applet;

    pa.fill(text_color);
    pa.textSize(text_size);
    pa.textAlign(LEFT, CENTER);
    pa.text(label, bbox.left, (bbox.top + bbox.bot) / 2);
  }
}
