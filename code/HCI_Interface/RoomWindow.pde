public class RoomWindow {
  private UIElement root;
  public boolean debug = false;  // Disable this if you don't want the green boundary rectangles
  private String path;

  public void settings() {
    // size(1400, 1000);
    // path = args[0];
  }

  RoomWindow(UIElement root){
    this.root = root;
    root.AddComponent(new Panel(#292929));

    Button b;
    UserBubble ub;

    UIElement user_canvas = new UIElement(root.applet, root.transform, new Rect(0, 0, 0, -88), new Rect(0, 0, 1, 1));


    UIElement footer = new UIElement(root.applet, root.transform, new Rect(0, -88, 0, 0), new Rect(0, 1, 1, 1));
    footer.AddComponent(new Panel(#121212));

    UIElement permission_display = new UIElement(root.applet, user_canvas.transform, new Rect(48, 48, 512, 360), new Rect(0, 0, 0, 0));
    PermissionDisplay pdp = new PermissionDisplay();
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

    UIElement user_a = new UIElement(root.applet, "max", user_canvas.transform, new Rect(-48, -48, 48, 48), new Rect(.5, .5, .5, .5));
    ub = new UserBubble("Max Mustermann");
    ub.SetPermissionDisplay(pdp);
    user_a.AddComponent(ub);
    user_a.AddComponent(new Collider());

    UIElement user_b = new UIElement(root.applet, "pepe", user_canvas.transform, new Rect(-48, -48, 48, 48), new Rect(.3, .5, .3, .5));
    ub = new UserBubble("Pepe the frog", loadImage("images/pepe.png"), 100);
    user_b.AddComponent(ub);
    ub.SetPermissionDisplay(pdp);
    user_b.AddComponent(new Collider());

    UIElement user_c = new UIElement(root.applet, "barnabus", user_canvas.transform, new Rect(-48, -48, 48, 48), new Rect(.7, .5, .7, .5));
    ub = new UserBubble("Barnabus Stinson", null, 50);
    ub.SetPermissionDisplay(pdp);
    user_c.AddComponent(ub);
    user_c.AddComponent(new Collider());
    // Note: If you load an image from disk, take the absolute path, not the relative path. PApplet messes with the relative path in Processing 3.
    ub.StartCam();

    println("initialized room UI");
  }
}
