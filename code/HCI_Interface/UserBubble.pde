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
  private boolean is_screensharing;
  public boolean is_speaking;
  public boolean show_buttons;

  private color not_speaking_color = #FFFFFF;
  private color speaking_color = #44FF44;
  private int speech_ring_weight = 5;

  private UIElement potential_b_room;
  private UIElement current_b_room;

  private UIElement name_bubble;
  private UIElement level_bubble;
  private UIElement image_panel;

  private UIElement mute_button;
  private UIElement level_button;
  private UIElement resize_button;
  private UIElement move_button;

  UserBubble(String name, PImage image, int level) {
    this.name = name;
    this.image = image;
    this.level = level;

    this.is_speaking = false;
    this.is_screensharing = false;
    this.show_buttons = true;

    this.potential_b_room = null;
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

  public void BeginScreenshare(){
    this.is_screensharing = true;
    ((ImagePanel)image_panel.GetComponent("ImagePanel")).SetMode(ImageDisplayMode.ROUNDRECT);
  }

  public void EndScreenshare() {
    this.is_screensharing = false;
    ((ImagePanel)image_panel.GetComponent("ImagePanel")).SetMode(ImageDisplayMode.CIRCLE);

  }

  public void SetButtonsActive(boolean active) {
    show_buttons = active;

    mute_button.SetActive(show_buttons);
    level_button.SetActive(show_buttons);
    resize_button.SetActive(show_buttons);
    move_button.SetActive(show_buttons);
  }

  // Code for updating/rendering. Ignore this code if you only want to change the appearance of the UIElement
  public void Start() {
    UIElement puie = GetUIElement();
    Button b;

    image_panel = new UIElement(puie.applet, puie.transform, new Rect(7, 7, -7, -7), new Rect(0, 0, 1, 1));
    image_panel.AddComponent(new ImagePanel(null, ImageDisplayMode.CIRCLE));

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

    SetButtonsActive(false);
  }

  public void Update() {
    if (image == null) {
      image = loadImage("images/baseline_account.png");
    }

    ((ImagePanel)image_panel.GetComponent("ImagePanel")).SetImage(image);
    ((TextLabel)name_bubble.GetComponent("TextLabel")).SetLabel(name);
    ((TextLabel)level_bubble.GetComponent("TextLabel")).SetLabel(str(level));
  }

  public void Render() {
    Transform t = GetUIElement().transform;
    Rect bbox = t.GlobalBounds();
    PApplet pa = GetUIElement().applet;

    pa.noFill();
    pa.strokeWeight(speech_ring_weight);
    if (is_speaking) {
      pa.stroke(speaking_color);
    } else {
      pa.stroke(not_speaking_color);
    }

    if(is_screensharing){
      pa.rect(bbox.left, bbox.top, bbox.right - bbox.left, bbox.bot - bbox.top);
    }else{
      pa.ellipse((bbox.left + bbox.right) / 2, (bbox.top + bbox.bot) / 2, bbox.right - bbox.left, bbox.bot - bbox.top);
    }
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
    PVector o = PVector.sub(t.parent.RelativeFromAbsolute(new PVector(pa.mouseX, pa.mouseY)), t.parent.RelativeFromAbsolute(new PVector(pa.pmouseX, pa.pmouseY)));
    ca.Translate(o);
    // ca.ClampRect(new Rect(0.05, 0.05, 0.95, 0.85));
  }

  public void OnClickEnter() {
    SetButtonsActive(!show_buttons);
  }

  public void OnClickUpdate() {
    Move();
  }

  public void OnClickExit() {

    PApplet pa = GetUIElement().applet;

    if (current_b_room != null) {
      Rect bbox = current_b_room.transform.GlobalBounds();

      if ((pa.mouseX < bbox.left || pa.mouseX > bbox.right || pa.mouseY < bbox.top || pa.mouseY > bbox.bot)) {
        ((BreakoutWindow)current_b_room.GetComponent("BreakoutWindow")).RemoveUser(GetUIElement());
        current_b_room = null;
      }
    }

    if (potential_b_room != null) {
      ((BreakoutWindow)potential_b_room.GetComponent("BreakoutWindow")).AddUser(GetUIElement());
      current_b_room = potential_b_room;
      potential_b_room = null;
    }
  }

  public void OnCollisionEnter(Transform other) {
    if (other.GetUIElement().GetComponent("BreakoutWindow") != null) {
      potential_b_room = other.GetUIElement();
    }
  }

  public void OnCollisionExit(Transform other) {
    if (other.GetUIElement() == potential_b_room) {
      potential_b_room = null;
    }
  }
}