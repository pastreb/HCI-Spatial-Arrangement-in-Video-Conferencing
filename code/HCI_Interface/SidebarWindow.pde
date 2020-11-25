class SidebarWindow {
  private UIElement root;
  public boolean debug = false;  // Disable this if you don't want the green boundary rectangles.
  private String path;

  SidebarWindow(UIElement root){
    this.root = root;

    Button b;

    root.AddComponent(new Panel(#292929));

    UIElement profile_div = new UIElement(root.applet, root.transform, new Rect(0.05, 0.02, 0.95, 0.08)); 
    UIElement your_rooms_div = new UIElement(root.applet, root.transform, new Rect(0.05, 0.1, 0.95, 0.7)); 
    UIElement join_room_div = new UIElement(root.applet, root.transform, new Rect(0.05, 0.72, 0.95, 0.86)); 
    UIElement footer = new UIElement(root.applet, root.transform, new Rect(0, -88, 0, 0), new Rect(0, 1, 1, 1));
    footer.AddComponent(new Panel(#121212));

    UIElement profile_label = new UIElement(root.applet, profile_div.transform, new Rect(0, 0.1, 0.3, 0.4));
    profile_label.AddComponent(new TextLabel("PROFILE", #BB86FC, 10));

    UIElement profile_name = new UIElement(root.applet, profile_div.transform, new Rect(0, 0.4, 0.7, 1));
    profile_name.AddComponent(new TextLabel("Max Mustermann", #FFFFFF, 20));

    UIElement your_rooms_label = new UIElement(root.applet, your_rooms_div.transform, new Rect(0.05, 0, 0.95, 0.1));
    your_rooms_label.AddComponent(new TextLabel("Your Rooms", #DBB2FF, 16));

    UIElement your_rooms_list = new UIElement(root.applet, your_rooms_div.transform, new Rect(0.05, 0.12, 0.95, 0.95));
    your_rooms_list.AddComponent(new ImagePanel(loadImage("images/room_list_mockup.png")));
    // your_rooms_list.AddComponent(new Panel(#313131));

    UIElement join_room_label = new UIElement(root.applet, join_room_div.transform, new Rect(0.05, 0, 0.95, 0.4));
    join_room_label.AddComponent(new TextLabel("Join Room", #DBB2FF, 16));

    UIElement join_room_input = new UIElement(root.applet, join_room_div.transform, new Rect(0, 24, 0, -24), new Rect(0.05, .7, 0.95, 0.7));
    join_room_input.AddComponent(new Panel(#121212));

    UIElement enter_room_id_label = new UIElement(root.applet, join_room_input.transform, new Rect(16, 0, 16, 0), new Rect(0, 0.3, 0.7, 0.7));
    enter_room_id_label.AddComponent(new TextLabel("Enter Room ID...", #707070, 14));

    UIElement join_room_join = new UIElement(root.applet, join_room_input.transform, new Rect(-50, 0, 0, 0), new Rect(1, 0.3, 1, 0.7));
    join_room_join.AddComponent(new TextLabel("JOIN", #BB86FC, 14));

    UIElement create_room_button = new UIElement(root.applet, footer.transform, new Rect(16, -24, 191, 24), new Rect(0, 0, 0, 0));
    b = new Button("CREATE ROOM");
    b.SetReleaseMessage(create_room_button, "CreateRoom");
    create_room_button.AddComponent(b);

    create_room_button.AddComponent(new Collider());
    create_room_button.AddComponent(new UtilFunctions());

    // Button that opens the settings
    UIElement settings_button = new UIElement(root.applet, footer.transform, new Rect(-66, -66, -22, -22), new Rect(1, 1, 1, 1));
    // settings_button.AddComponent(new Panel(#ff0000)); Use for debugging: Highlights the location of the settings button
    b = new Button("", null, "", loadImage("images/settings_default.png"), loadImage("images/settings_click.png"), loadImage("images/settings_hover.png"));
    b.SetReleaseMessage(settings_button, "OpenSettings");
    settings_button.AddComponent(b);
    settings_button.AddComponent(new Collider());
    settings_button.AddComponent(new UtilFunctions());

    println("initialized sidebar UI");
  }
}