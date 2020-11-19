class SidebarWindow extends PApplet {
  private Canvas root;
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
    create_room_button.AddComponent(new UtilFunctions());

    // Button that opens the settings
    UIElement settings_button = new UIElement(this, footer.transform, new Rect(-66, -66, -22, -22), new Rect(1, 1, 1, 1));
    // settings_button.AddComponent(new Panel(#ff0000)); Use for debugging: Highlights the location of the settings button
    settings_button.AddComponent(new Button("SETTINGS", settings_button, "Settings", loadImage(path + "/images/settings_default.png"), loadImage(path + "/images/settings_click.png"), loadImage(path + "/images/settings_hover.png")));
    settings_button.AddComponent(new Collider());
    settings_button.AddComponent(new UtilFunctions());

    loadImage(path + "/images/baseline_account.png");


    println("initialized sidebar UI");
  }

  public void draw() {
    root.Run(debug);
  }
}

// -----------------------------------------------------------------------------------------------------------------------------------------

class SettingsWindow extends PApplet {
  private Canvas root;
  public boolean debug = false;  // Disable this if you don't want the green boundary rectangles.
  private String path;

  public void settings() {
    size(360, 1000);
    path = args[0];
  }

  public void setup() {
    root = new Canvas(this, #292929); // #292929 is corresponds to some black color

    // --------------------------------------------------
    // --- PROFILE --- 
    // Profile settings
    UIElement profile_div = new UIElement(this, root.transform, new Rect(0.05, 0.02, 0.95, 0.04));
    UIElement profile_label = new UIElement(this, profile_div.transform, new Rect(0, 0, 1, 1));
    profile_label.AddComponent(new TextLabel("PROFILE SETTINGS", #BB86FC, 10));

    // STRICH
    UIElement strich1_div = new UIElement(this, root.transform, new Rect(0.05, 0.04, 0.95, 0.05));
    UIElement strich1 = new UIElement(this, strich1_div.transform, new Rect(0, 0.4, 1, 0.6));
    strich1.AddComponent(new Panel(#A8A8A8));

    // Profile name
    UIElement name_div = new UIElement(this, root.transform, new Rect(0.05, 0.05, 0.95, 0.09));
    UIElement profile_name = new UIElement(this, name_div.transform, new Rect(0.05, 0, 0.6, 1));
    profile_name.AddComponent(new TextLabel("Max Mustermann", #FFFFFF, 20)); 
    UIElement change_name_button = new UIElement(this, name_div.transform, new Rect(0.6, 0.1, 0.95, 0.9));
    Button name_changer = new Button("CHANGE NAME", change_name_button, "Name");
    name_changer.set_textsize(10);
    change_name_button.AddComponent(name_changer);
    change_name_button.AddComponent(new Collider());
    // TO DO: IMPLEMENT NAME() IN CREATEROOM CLASS OF COMPONENT

    // Profile picture
    UIElement picture_div = new UIElement(this, root.transform, new Rect(0.05, 0.09, 0.95, 0.3));
    UIElement picture_button = new UIElement(this, picture_div.transform, new Rect(-100, 0, 100, 200), new Rect(0.5, 0, 0.5, 0));
    PImage img = loadImage(path + "/images/baseline_account.png");
    picture_button.AddComponent(new Button("PROFILE PICTURE", picture_button, "Picture", img, img, img));
    picture_button.AddComponent(new Collider());
    // TO DO: IMPLEMENT PICTURE() IN CREATEROOM CLASS OF COMPONENT

    // Button for changing picture
    UIElement change_picture_div = new UIElement(this, root.transform, new Rect(0.05, 0.3, 0.95, 0.34));
    UIElement change_picture_button = new UIElement(this, change_picture_div.transform, new Rect(0.6, 0.1, 0.95, 0.9));
    Button picture_changer = new Button("CHANGE PICTURE", change_picture_button, "Picture");
    picture_changer.set_textsize(10);
    change_picture_button.AddComponent(picture_changer);
    change_picture_button.AddComponent(new Collider());
    /// TO DO: IMPLEMENT PICTURE() IN CREATEROOM CLASS OF COMPONENT

    // --------------------------------------------------
    // --- MICROPHONE --- 
    // Microphone settings
    UIElement microphone_title_div = new UIElement(this, root.transform, new Rect(0.05, 0.4, 0.95, 0.42));
    UIElement microphone_label = new UIElement(this, microphone_title_div.transform, new Rect(0, 0, 1, 1));
    microphone_label.AddComponent(new TextLabel("MICROPHONE SETTINGS", #BB86FC, 10));

    // STRICH
    UIElement strich2_div = new UIElement(this, root.transform, new Rect(0.05, 0.42, 0.95, 0.43));
    UIElement strich2 = new UIElement(this, strich2_div.transform, new Rect(0, 0.4, 1, 0.6));
    strich2.AddComponent(new Panel(#A8A8A8));

    // Microphone
    UIElement mic_div = new UIElement(this, root.transform, new Rect(0.05, 0.43, 0.95, 0.47));
    mic_div.AddComponent(new Panel(#313131));
    UIElement microphone = new UIElement(this, mic_div.transform, new Rect(0.05, 0, 0.6, 1));
    microphone.AddComponent(new TextLabel("Default Microphone", #FFFFFF, 14)); 

    // Microphone Button
    UIElement microphone_button = new UIElement(this, mic_div.transform, new Rect(-45, -40, -10, -5), new Rect(1, 1, 1, 1));
    microphone_button.AddComponent(new Button("DROPDOWN", microphone_button, "Microphone", loadImage(path + "/images/dropdown_default.png"), loadImage(path + "/images/dropdown_click.png"), loadImage(path + "/images/dropdown_hover.png")));
    microphone_button.AddComponent(new Collider());
    // TO DO: IMPLEMENT MICROPHONE() IN CREATEROOM CLASS OF COMPONENT

    // --------------------------------------------------
    // --- SPEAKER --- 
    // Speaker settings
    UIElement speaker_title_div = new UIElement(this, root.transform, new Rect(0.05, 0.5, 0.95, 0.52));
    UIElement speaker_label = new UIElement(this, speaker_title_div.transform, new Rect(0, 0, 1, 1));
    speaker_label.AddComponent(new TextLabel("SPEAKER SETTINGS", #BB86FC, 10));

    // STRICH
    UIElement strich3_div = new UIElement(this, root.transform, new Rect(0.05, 0.52, 0.95, 0.53));
    UIElement strich3 = new UIElement(this, strich3_div.transform, new Rect(0, 0.4, 1, 0.6));
    strich3.AddComponent(new Panel(#A8A8A8));

    // Speaker
    UIElement speaker_div = new UIElement(this, root.transform, new Rect(0.05, 0.53, 0.95, 0.57));
    speaker_div.AddComponent(new Panel(#313131));
    UIElement speaker = new UIElement(this, speaker_div.transform, new Rect(0.05, 0, 0.6, 1));
    speaker.AddComponent(new TextLabel("Stereo Headphones", #FFFFFF, 14)); 

    // Speaker Button
    UIElement speaker_button = new UIElement(this, speaker_div.transform, new Rect(-45, -40, -10, -5), new Rect(1, 1, 1, 1));
    speaker_button.AddComponent(new Button("DROPDOWN", speaker_button, "Speaker", loadImage(path + "/images/dropdown_default.png"), loadImage(path + "/images/dropdown_click.png"), loadImage(path + "/images/dropdown_hover.png")));
    speaker_button.AddComponent(new Collider());
    // TO DO: IMPLEMENT SPEAKER() IN CREATEROOM CLASS OF COMPONENT

    // --------------------------------------------------
    // --- VIDEO --- 
    // Video settings
    UIElement video_title_div = new UIElement(this, root.transform, new Rect(0.05, 0.6, 0.95, 0.62));
    UIElement video_label = new UIElement(this, video_title_div.transform, new Rect(0, 0, 1, 1));
    video_label.AddComponent(new TextLabel("VIDEO SETTINGS", #BB86FC, 10));

    // STRICH
    UIElement strich4_div = new UIElement(this, root.transform, new Rect(0.05, 0.62, 0.95, 0.63));
    UIElement strich4 = new UIElement(this, strich4_div.transform, new Rect(0, 0.4, 1, 0.6));
    strich4.AddComponent(new Panel(#A8A8A8));

    // Video
    UIElement video_div = new UIElement(this, root.transform, new Rect(0.05, 0.63, 0.95, 0.67));
    video_div.AddComponent(new Panel(#313131));
    UIElement video = new UIElement(this, video_div.transform, new Rect(0.05, 0, 0.6, 1));
    video.AddComponent(new TextLabel("Webcam (1080p)", #FFFFFF, 14)); 

    // Video Button
    UIElement video_button = new UIElement(this, video_div.transform, new Rect(-45, -40, -10, -5), new Rect(1, 1, 1, 1));
    video_button.AddComponent(new Button("DROPDOWN", video_button, "Video", loadImage(path + "/images/dropdown_default.png"), loadImage(path + "/images/dropdown_click.png"), loadImage(path + "/images/dropdown_hover.png")));
    video_button.AddComponent(new Collider());
    // TO DO: IMPLEMENT VIDEO() IN CREATEROOM CLASS OF COMPONENT

    // --------------------------------------------------
    // --- FOOTER --- 
    UIElement footer = new UIElement(this, root.transform, new Rect(0, -88, 0, 0), new Rect(0, 1, 1, 1));
    footer.AddComponent(new Panel(#121212));

    // Button that saves the changed settings
    UIElement save_button = new UIElement(this, footer.transform, new Rect(-130, -66, -86, -22), new Rect(1, 1, 1, 1));
    save_button.AddComponent(new Button("SAVE CHANGES", save_button, "Save", loadImage(path + "/images/save_default.png"), loadImage(path + "/images/save_click.png"), loadImage(path + "/images/save_hover.png")));
    save_button.AddComponent(new Collider());
    // TO DO: IMPLEMENT SAVE() IN CREATEROOM CLASS OF COMPONENT

    // Button that closes the settings
    UIElement close_button = new UIElement(this, footer.transform, new Rect(-66, -66, -22, -22), new Rect(1, 1, 1, 1));
    close_button.AddComponent(new Button("CLOSE SETTINGS", close_button, "Close", loadImage(path + "/images/back_default.png"), loadImage(path + "/images/back_click.png"), loadImage(path + "/images/back_hover.png")));
    close_button.AddComponent(new Collider());
    // TO DO: IMPLEMENT CLOSE() IN CREATEROOM CLASS OF COMPONENT
  }

  public void draw() {
    root.Run(debug);
  }

  public void exit() {
    dispose();
  }
}

// -----------------------------------------------------------------------------------------------------------------------------------------

class RoomWindow extends PApplet {
  private Canvas root;
  public boolean debug = false;  // Disable this if you don't want the green boundary rectangles
  private String path;

  public void settings() {
    size(1400, 1000);
    path = args[0];
  }

  public void setup() {
    root = new Canvas(this, #292929);
    Button b;

    UIElement footer = new UIElement(this, root.transform, new Rect(0, -88, 0, 0), new Rect(0, 1, 1, 1));
    footer.AddComponent(new Panel(#121212));

    UIElement user_canvas = new UIElement(this, root.transform, new Rect(0, 0, 0, -88), new Rect(0, 0, 1, 1));

    UIElement room_name_label = new UIElement(this, footer.transform, new Rect(16, 0, 260, 0), new Rect(0, 0.6, 0, 0.9));
    room_name_label.AddComponent(new TextLabel("Human Computer Interaction", #FFFFFF, 16));

    UIElement room_id_label = new UIElement(this, footer.transform, new Rect(16, 0, 260, 0), new Rect(0, 0.4, 0, 0.6));
    room_id_label.AddComponent(new TextLabel("ROOM ID: 1234", #707070, 10));

    UIElement create_b_room_button = new UIElement(this, footer.transform, new Rect(16, -24, 260, 24), new Rect(0, 0, 0, 0));
    b = new Button("CREATE BREAKOUT ROOM");
    b.SetClickMessage(create_b_room_button, "CreateBreakoutWindow", (PApplet)this, user_canvas);
    create_b_room_button.AddComponent(b);
    create_b_room_button.AddComponent(new Collider());
    create_b_room_button.AddComponent(new UtilFunctions());



    UIElement user_a = new UIElement(this, "max", user_canvas.transform, new Rect(-48, -48, 48, 48), new Rect(.5, .5, .5, .5));
    user_a.AddComponent(new UserBubble("Max Mustermann"));
    user_a.AddComponent(new Collider());

    UIElement user_b = new UIElement(this, "pepe", user_canvas.transform, new Rect(-48, -48, 48, 48), new Rect(.3, .5, .3, .5));
    user_b.AddComponent(new UserBubble("Pepe the frog", loadImage(path + "/images/pepe.png"), 100));
    user_b.AddComponent(new Collider());
    // Note: If you load an image from disk, take the absolute path, not the relative path. PApplet messes with the relative path in Processing 3.

    println("initialized room UI");
  }

  public void draw() {
    root.Run(debug);
  }

  public void exit() {
    dispose();
  }
}
