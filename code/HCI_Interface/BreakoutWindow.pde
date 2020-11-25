import processing.video.*;

class BreakoutWindow extends Component {
  private UIElement background_panel;
  private UIElement room_name;
  private UIElement close_button;
  private UIElement resize_button;
  private UIElement screen_share_button;

  private color background_color;
  private String name;
  private float rounding_factor = 0;
  private boolean close_flag;

  private ArrayList<UIElement> users;

  BreakoutWindow(String name, color c) {
    this.background_color = c;
    this.name = name;

    this.users = new ArrayList<UIElement>();
    this.close_flag = false;
  }

  BreakoutWindow() {
    this("New Room", #121212);
  }

  public void Start() {
    UIElement puie = GetUIElement();
    Button b;
    // String path = ((RoomWindow)puie.applet).path;

    puie.AddComponent(new Collider());

    background_panel = new UIElement(puie.applet, puie.transform, new Rect(0, 0, 1, 1));
    background_panel.AddComponent(new Panel(background_color, rounding_factor));

    room_name = new UIElement(puie.applet, background_panel.transform, new Rect(16, 0, 0, 64), new Rect(0, 0, .8, 0));
    room_name.AddComponent(new TextLabel(name, #DBB2FF, 16, LEFT, CENTER));
    b = new Button();
    b.SetHoldMessage(puie, "Move");
    room_name.AddComponent(b);
    room_name.AddComponent(new Collider());

    close_button = new UIElement(puie.applet, background_panel.transform, new Rect(-32, 0, 0, 32), new Rect(1, 0, 1, 0));
    b = new Button("X");
    b.SetReleaseMessage(puie, "Close");
    close_button.AddComponent(b);
    close_button.AddComponent(new Collider());

    resize_button = new UIElement(puie.applet, background_panel.transform, new Rect(-64, 0, -32, 32), new Rect(1, 0, 1, 0));
    resize_button.AddComponent(new Collider());
    b = new Button();
    b.SetDefaultImage(loadImage("images/resize_default.png"));
    b.SetHoldMessage(puie, "Resize");
    resize_button.AddComponent(b);


    screen_share_button = new UIElement(puie.applet, background_panel.transform, new Rect(4, -52, 188, -4), new Rect(0, 1, 0, 1));
    screen_share_button.AddComponent(new Collider());
    screen_share_button.AddComponent(new Button("SHARE SCREEN", puie, "Screenshare"));
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

    public void Resize() {
    Transform t = GetUIElement().transform;
    Rect bbox = t.GlobalBounds();
    PApplet pa = GetUIElement().applet;

    float sensitivity = 2;
    PVector o = PVector.sub(t.parent.RelativeFromAbsolute(new PVector(pa.mouseX, pa.mouseY)), t.parent.RelativeFromAbsolute(new PVector(pa.pmouseX, pa.pmouseY)));

    t.anchor.Scale((new PVector(1, 1)).add(o.mult(sensitivity)));
  }

  public void Close() {
    Transform p = GetUIElement().transform.parent;
    println("Closing breakout room", GetUIElement().name);
    for (UIElement user : users) {
      Rect bbox = user.transform.GlobalBounds();
      PVector pos = p.RelativeFromAbsolute(new PVector((bbox.left + bbox.right)/2, (bbox.top + bbox.bot)/2));
      user.transform.SetParent(p);
      user.transform.anchor = new Rect(pos.x, pos.y, pos.x, pos.y);
      ((UserBubble)user.GetComponent("UserBubble")).EndScreenshare();
    }
    close_flag = true;
  }

  public void Screenshare(){
    if(users.size() == 0){
      return;
    }

    // Temporary code for screenshare
    UserBubble ub = (UserBubble)users.get(0).GetComponent("UserBubble");
    ub.BeginScreenshare();
  }

  public void AddUser(UIElement user) {
    Transform t = GetUIElement().transform;
    PApplet pa = GetUIElement().applet;

    user.transform.SetParent(GetUIElement().transform);
    users.add(user);
    // t.anchor = new Rect(.5, .5, .5, .5);

    PVector p = t.RelativeFromAbsolute(new PVector(pa.mouseX, pa.mouseY));
    user.transform.anchor = new Rect(p.x, p.y, p.x, p.y);
    println(user.name, "entered", GetUIElement().name);
  }

  public void RemoveUser(UIElement user) {
    Transform t = GetUIElement().transform.parent;
    PApplet pa = GetUIElement().applet;

    ((UserBubble)user.GetComponent("UserBubble")).EndScreenshare();
    user.transform.SetParent(t);
    users.remove(user);
    // t.anchor = new Rect(.5, .5, .5, .5);

    PVector p = t.RelativeFromAbsolute(new PVector(pa.mouseX, pa.mouseY));
    user.transform.anchor = new Rect(p.x, p.y, p.x, p.y);
    println(user.name, "entered", t.GetUIElement().name);
  }

  public void Update() {
    if (close_flag) {
      GetUIElement().Delete();
    }
  }
}