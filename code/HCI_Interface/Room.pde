class Room extends PApplet {
  private UIElement root;
  public boolean debug;


  public void settings() {
    size(1400, 1000);
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

    UIElement user_a = new UIElement(this, root.transform, new Rect(-48, -48, 48, 48), new Rect(.5, .5, .5, .5));
    user_a.AddComponent(new UserBubble("Max Mustermann"));
    user_a.AddComponent(new Collider());

    UIElement user_b = new UIElement(this, root.transform, new Rect(-48, -48, 48, 48), new Rect(.3, .5, .3, .5));
    user_b.AddComponent(new UserBubble("Vladimir Putin"));
    user_b.AddComponent(new Collider());

    println("initialized room UI");
  }

  public void draw() {
    root.Update(debug);
  }

  public void exit() {
    dispose();
  }
}
