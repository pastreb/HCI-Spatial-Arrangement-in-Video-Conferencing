import java.util.Map;
import oscP5.*;
import netP5.*;

public class RoomWindow {
  private UIElement root;
  private UIElement user_canvas;
  public boolean debug = false;  // Disable this if you don't want the green boundary rectangles
  private String path;

  private Room room;
  HashMap<String, UIElement> bubbles;
  private PermissionDisplay pdp;

  private OscP5 oscP5;
  private NetAddress remote_loc;
  private User usr_buf;
  private int lvl_buf;
  private boolean buf_lock;
  private OscMessage buf_m;

  public void settings() {
    // size(1400, 1000);
    // path = args[0];
  }

  RoomWindow(UIElement root){
    this.root = root;

    buf_lock = false;
    oscP5 = new OscP5(this, 12001);
    remote_loc = new NetAddress("127.0.0.1", 12000);

    root.AddComponent(new Panel(#292929));

    Button b;
    UserBubble ub;

    room = new Room();
    bubbles = new HashMap<String, UIElement>();

    user_canvas = new UIElement(root.applet, root.transform, new Rect(0, 0, 0, -88), new Rect(0, 0, 1, 1));


    UIElement footer = new UIElement(root.applet, root.transform, new Rect(0, -88, 0, 0), new Rect(0, 1, 1, 1));
    footer.AddComponent(new Panel(#121212));

    UIElement permission_display = new UIElement(root.applet, user_canvas.transform, new Rect(48, 48, 512, 360), new Rect(0, 0, 0, 0));
    pdp = new PermissionDisplay();
    permission_display.AddComponent(pdp);

    UIElement room_name_label = new UIElement(root.applet, footer.transform, new Rect(16, 0, 260, 0), new Rect(0, 0.6, 0, 0.9));
    room_name_label.AddComponent(new TextLabel("Human Computer Interaction", #FFFFFF, 16));

    UIElement room_id_label = new UIElement(root.applet, footer.transform, new Rect(16, 0, 260, 0), new Rect(0, 0.4, 0, 0.6));
    room_id_label.AddComponent(new TextLabel("ROOM ID: 1234", #707070, 10));

    UIElement create_b_room_button = new UIElement(root.applet, footer.transform, new Rect(16, -24, 260, 24), new Rect(0, 0, 0, 0));
    b = new Button("CREATE BREAKOUT ROOM");
    b.SetClickMessage(create_b_room_button, "CreateBreakoutWindow",  user_canvas);
    create_b_room_button.AddComponent(b);
    create_b_room_button.AddComponent(new Collider());
    create_b_room_button.AddComponent(new UtilFunctions());

    UIElement create_user_button = new UIElement(root.applet, footer.transform, new Rect(-140, -24, -16, 24), new Rect(1, 0, 1, 0));
    b = new Button("CREATE USER");
    b.SetReleaseMessage(create_user_button, "CreateUser", this);
    create_user_button.AddComponent(b);
    create_user_button.AddComponent(new Collider());
    create_user_button.AddComponent(new UtilFunctions());

    // UserJoin(new User("Max Mustermann"), 1, new PVector(.5, .5), 96);
    // UserJoin(new User("Pepe the frog", "images/pepe.png"), 100, new PVector(.7, .5), 96);
    // UserJoin(new User("Olivia Davis"), 50, new PVector(.3, .5), 96);

    // Note: If you load an image from disk, take the absolute path, not the relative path. PApplet messes with the relative path in Processing 3.
    // ub.StartCam();

    println("initialized room UI");
  }

  public void UserJoin(User u, int level){
    // if(buf_lock) return;

    buf_lock = true;
    usr_buf = u;
    lvl_buf = level;

    Table table = new Table();
    table.addColumn("xpos");
    table.addColumn("ypos");
    table.addColumn("radius");

    Rect canvas_bounds = user_canvas.transform.GlobalBounds();
    float c_height = canvas_bounds.bot - canvas_bounds.top;
    float c_width = canvas_bounds.right - canvas_bounds.left;

    for(UIElement uie : bubbles.values()){
      TableRow r = table.addRow();
      r.setInt("xpos", (int)(uie.transform.anchor.left * c_width));
      r.setInt("ypos", (int)(uie.transform.anchor.top * c_height));
      r.setInt("radius", (int)(uie.transform.position.bot) + 16);
    }

    saveTable(table, "userpositions.csv");

    OscMessage m = new OscMessage("/filter");
    m.add("user_joined");
    m.add("width: " + (int)c_width);
    m.add("height: " + (int)c_height);
    m.add("user_radius: 64");
    oscP5.send(m, remote_loc);
  }


  private void UserJoin(User u, int level, PVector pos, float rad){
    UIElement uie = new UIElement(this.root.applet, u.getName(), user_canvas.transform, new Rect(-rad, -rad, rad, rad), new Rect(pos.x, pos.y, pos.x, pos.y));
    UserBubble ub;
    if(u.getPic() != null){
      println(u.getPic());
      ub  = new UserBubble(u.getName(), loadImage(u.getPic()), level);
    }else{
      ub = new UserBubble(u.getName(), null, level);
    }
    ub.SetPermissionDisplay(pdp);
    uie.AddComponent(ub);
    uie.AddComponent(new Collider());

    room.addUser(u, level);
    bubbles.put(u.getUserID(), uie);
  }

  /* incoming osc message are forwarded to the oscEvent method. */
  void oscEvent(OscMessage theOscMessage) {
    buf_m = theOscMessage;

    buf_lock = false;
  }

  public void Finalize(){
    if(buf_m == null) return;

    /* print the address pattern and the typetag of the received OscMessage */
    println("typetag: " + buf_m.typetag()); 
    println(buf_m.get(0).stringValue());
    println(buf_m.get(1).stringValue());
    //Get canvas size
    Rect canvas_bounds = user_canvas.transform.GlobalBounds();
    float c_height = canvas_bounds.bot - canvas_bounds.top;
    float c_width = canvas_bounds.right - canvas_bounds.left;
    float new_x = Float.valueOf(buf_m.get(0).stringValue()); //absolute values
    float new_y = Float.valueOf(buf_m.get(1).stringValue());

    UserJoin(usr_buf, lvl_buf, new PVector(new_x/c_width, new_y/c_height), 48);

    buf_m = null;
  }
}
