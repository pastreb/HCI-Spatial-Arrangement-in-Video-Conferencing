class SidebarWindow extends PApplet {
  private UIElement root;
  public boolean debug = false;  // Disable this if you don't want the green boundary rectangles.
  private String path;
  
  public void settings() {
    size(360, 1000);
    path = args[0];
  }

  public void setup() {
    root = new Canvas(this, #292929);
    

    UIElement profile_div = new UIElement(this, root.transform, new Rect(0.05, 0.02, 0.95, 0.08)); 
    UIElement your_rooms_div = new UIElement(this, root.transform, new Rect(0.05, 0.1, 0.95, 0.7)); 
    UIElement join_room_div = new UIElement(this, root.transform, new Rect(0.05, 0.72, 0.95, 0.86)); 
    UIElement footer = new UIElement(this, root.transform, new Rect(0, -88, 0, 0), new Rect(0, 1, 1, 1));
    footer.AddComponent(new Panel(#121212));

    UIElement profile_label = new UIElement(this, profile_div.transform, new Rect(0, 0.1, 0.3, 0.4));
    profile_label.AddComponent(new TextLabel("PROFILE", #BB86FC, 10));

    UIElement profile_name = new UIElement(this, profile_div.transform, new Rect(0, 0.4, 0.7, 1));
    profile_name.AddComponent(new TextLabel("Max Mustermann", #FFFFFF, 20));

    UIElement your_rooms_label = new UIElement(this, your_rooms_div.transform, new Rect(0.05, 0, 0.95, 0.1));
    your_rooms_label.AddComponent(new TextLabel("Your Rooms", #DBB2FF, 16));

    UIElement your_rooms_list = new UIElement(this, your_rooms_div.transform, new Rect(0.05, 0.12, 0.95, 0.95));
    your_rooms_list.AddComponent(new Panel(#313131));

    UIElement join_room_label = new UIElement(this, join_room_div.transform, new Rect(0.05, 0, 0.95, 0.4));
    join_room_label.AddComponent(new TextLabel("Join Room", #DBB2FF, 16));

    UIElement join_room_input = new UIElement(this, join_room_div.transform, new Rect(0, 24, 0, -24), new Rect(0.05, .7, 0.95, 0.7));
    join_room_input.AddComponent(new Panel(#121212));

    UIElement enter_room_id_label = new UIElement(this, join_room_input.transform, new Rect(16, 0, 16, 0), new Rect(0, 0.3, 0.7, 0.7));
    enter_room_id_label.AddComponent(new TextLabel("Enter Room ID...", #707070, 14));

    UIElement join_room_join = new UIElement(this, join_room_input.transform, new Rect(-50, 0, 0, 0), new Rect(1, 0.3, 1, 0.7));
    join_room_join.AddComponent(new TextLabel("JOIN", #BB86FC, 14));

    UIElement create_room_button = new UIElement(this, footer.transform, new Rect(16, -24, 191, 24), new Rect(0, 0, 0, 0));
    create_room_button.AddComponent(new Button("CREATE ROOM", create_room_button, "Create"));
    create_room_button.AddComponent(new Collider());
    create_room_button.AddComponent(new CreateRoom());
    
    println("initialized sidebar UI");
  }

  public void draw() {
    root.Update(debug);
  }
}

// -----------------------------------------------------------------------------------------------------------------------------------------

class RoomWindow extends PApplet {
  private UIElement root;
  public boolean debug = true;  // Disable this if you don't want the green boundary rectangles
  private String path;

  public void settings() {
    size(1400, 1000);
    path = args[0];
  }

  public void setup() {
    root = new Canvas(this, #292929);

    UIElement footer = new UIElement(this, root.transform, new Rect(0, -88, 0, 0), new Rect(0, 1, 1, 1));
    footer.AddComponent(new Panel(#121212));

    UIElement room_name_label = new UIElement(this, footer.transform, new Rect(16, 0, 260, 0), new Rect(0, 0.6, 0, 0.9));
    room_name_label.AddComponent(new TextLabel("Human Computer Interaction", #FFFFFF, 16));

    UIElement room_id_label = new UIElement(this, footer.transform, new Rect(16, 0, 260, 0), new Rect(0, 0.4, 0, 0.6));
    room_id_label.AddComponent(new TextLabel("ROOM ID: 1234", #707070, 10));

    UIElement create_b_room_button = new UIElement(this, footer.transform, new Rect(16, -24, 260, 24), new Rect(0, 0, 0, 0));
    create_b_room_button.AddComponent(new Button("CREATE BREAKOUT ROOM"));
    create_b_room_button.AddComponent(new Collider());
    
    UIElement user_canvas = new UIElement(this, root.transform, new Rect(0, 0, 0, -88), new Rect(0, 0, 1, 1));
    
    UIElement user_a = new UIElement(this, "max", user_canvas.transform, new Rect(-48, -48, 48, 48), new Rect(.5, .5, .5, .5));
    user_a.AddComponent(new UserBubble("Max Mustermann"));
    user_a.AddComponent(new Collider());

    UIElement user_b = new UIElement(this, "pepe", user_canvas.transform, new Rect(-48, -48, 48, 48), new Rect(.3, .5, .3, .5));
    user_b.AddComponent(new UserBubble("Pepe the frog", loadImage(path + "/images/pepe.png"), 100));
    user_b.AddComponent(new Collider());
    // Note: If you load an image from disk, take the absolute path, not the relative path. PApplet messes with the relative path in Processing 3.
    
    UIElement b_room_1 = new UIElement(this, "breakout room 1", user_canvas.transform, new Rect(-48, -96, 48, 96), new Rect(.7, .3, .9, .7));
    b_room_1.AddComponent(new BreakoutWindow());
    
    println("initialized room UI");

  }

  public void draw() {
    root.Update(debug);
  }

  public void exit() {
    dispose();
  }
}
