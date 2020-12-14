import processing.video.*;

// Displays a user as a bubble
// Can be moved around when clicked
// NOTE: fOR THIS COMPONENT TO WORK PROPERLY, ADD A COLLIDER TO THE UIELEMENT!!!
// To see how to actually use this component, refer to the example in the "Room" tab

// TODO: Add buttons for size, level, mute and expose their functionality.

// If you want to change the name of picture, use SetName(String) and SetPicture(PImage)

class UserBubble extends Component {
  public PImage image;
  public Movie video;
  public Movie cam;

  public String name;
  public float level;
  private boolean is_screensharing;
  private boolean has_cam;
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

  private float inactive_start;
  private float inactive_threshold = 3000;

  private PermissionDisplay pdp;

  UserBubble(String name, PImage image, int level) {
    this.name = name;
    this.image = image;
    this.level = level;

    this.is_speaking = false;
    this.is_screensharing = false;
    this.has_cam = false;
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

  public void SetVideo(Movie video){
    this.video = video;
  }

  public void SetCam(Movie cam){
    this.cam = cam;
  }

  public int GetLvl(){
    return (int)level;
  }

  public String GetName(){
    return name;
  }

  public void SetPermissionDisplay(PermissionDisplay pdp){
    this.pdp = pdp;
  }

  public void BeginScreenshare(){
    if(is_screensharing) return;

    Rect pos = GetUIElement().transform.position;

    EndCam();
    this.is_screensharing = true;
    ((ImagePanel)image_panel.GetComponent("ImagePanel")).SetMode(ImageDisplayMode.ROUNDRECT);
    pos.Set(pos.left * 32/25, pos.top * 18/25, pos.right * 32/25, pos.bot * 18/25);

    // Temp screen sharing code for mockup
    video = new Movie(GetUIElement().applet, GetUIElement().applet.sketchPath() + "/videos/screen_capture_lecture.mp4");
    if(video != null){
      video.play();
    }
    is_speaking = true;
  }

  public void EndScreenshare() {
    if(!is_screensharing) return;

    Rect pos = GetUIElement().transform.position;

    this.is_screensharing = false;
    ((ImagePanel)image_panel.GetComponent("ImagePanel")).SetMode(ImageDisplayMode.CIRCLE);
    float x = sqrt(pos.left * pos.top);
    pos.Set(-x, -x, x, x);

    // Temp screen sharing code for mockup
    if(video != null){
      video.stop();
    }

    if(cam != null){
      cam.stop();
    }

    is_speaking = false;

  }

  public void StartCam(){
    if(has_cam || is_screensharing) return;

    Rect pos = GetUIElement().transform.position;

    this.has_cam = true;
    ((ImagePanel)image_panel.GetComponent("ImagePanel")).SetMode(ImageDisplayMode.ROUNDRECT);
    pos.Set(pos.left * 32/25, pos.top * 18/25, pos.right * 32/25, pos.bot * 18/25);

    // Temp screen sharing code for mockup
    cam = new Movie(GetUIElement().applet, GetUIElement().applet.sketchPath() + "/videos/woman_talking_videocall.mp4");

    if(cam != null){
      cam.play();
      cam.loop();
    }

    is_speaking = true;
  }

  public void EndCam(){
    if(!has_cam) return;

    Rect pos = GetUIElement().transform.position;

    has_cam = false;
    ((ImagePanel)image_panel.GetComponent("ImagePanel")).SetMode(ImageDisplayMode.CIRCLE);
    float x = sqrt(pos.left * pos.top);
    pos.Set(-x, -x, x, x);

    // Temp screen sharing code for mockup
    if(cam != null){
      cam.stop();
    }

    is_speaking = false;
  }

  public void SetButtonsActive(boolean active) {
    show_buttons = active;

    mute_button.SetActive(show_buttons);
    level_button.SetActive(show_buttons);
    resize_button.SetActive(show_buttons);
    move_button.SetActive(show_buttons);
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

  public void UpdateLevel(){
    Transform t = GetUIElement().transform;
    Rect bbox = t.GlobalBounds();
    PApplet pa = GetUIElement().applet;

    float sensitivity = 0.04;
    float delta = pa.pmouseY - pa.mouseY;
    this.level = min(max(level + sensitivity * delta, 0), 100);
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
    level_bubble.AddComponent(new TextLabel(str(level), #121212, 14, CENTER, CENTER));

    mute_button = new UIElement(puie.applet, puie.transform, new Rect(-96, -72, -4, -40), new Rect(0, .5, 0, .5));
    mute_button.AddComponent(new Collider());
    mute_button.AddComponent(new Button("MUTE"));

    level_button = new UIElement(puie.applet, puie.transform, new Rect(-96, -32, -4, 0), new Rect(0, .5, 0, .5));
    level_button.AddComponent(new Collider());
    b = new Button("LEVEL");
    b.SetHoldMessage(puie, "UpdateLevel");
    level_button.AddComponent(b);

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

    if(is_screensharing){
      ((ImagePanel)image_panel.GetComponent("ImagePanel")).SetVideo(video);
    } else if(has_cam){
      ((ImagePanel)image_panel.GetComponent("ImagePanel")).SetCam(cam);
    } else {
      ((ImagePanel)image_panel.GetComponent("ImagePanel")).SetImage(image);

    }
    ((TextLabel)name_bubble.GetComponent("TextLabel")).SetLabel(name);
    ((TextLabel)level_bubble.GetComponent("TextLabel")).SetLabel(str((int)level));

    if(GetUIElement().applet.millis() - inactive_start > inactive_threshold){
      // SetButtonsActive(false);
    }

    SetButtonsActive(show_buttons);
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

    if(is_screensharing || has_cam){
      pa.rect(bbox.left, bbox.top, bbox.right - bbox.left, bbox.bot - bbox.top);
    }else{
      pa.ellipse((bbox.left + bbox.right) / 2, (bbox.top + bbox.bot) / 2, bbox.right - bbox.left, bbox.bot - bbox.top);
    }
    pa.noStroke();
  }

  public void OnClickEnter() {
    SetButtonsActive(!show_buttons);

    if(pdp != null){
      pdp.SetUser(GetUIElement());
    }
  }

  public void OnClickUpdate() {
    Move();
  }

  public void OnHoverUpdate(){
    inactive_start = GetUIElement().applet.millis();
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