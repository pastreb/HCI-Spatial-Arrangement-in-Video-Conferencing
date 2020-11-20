// Utility comonent that defines the functionality when pressing the "CREATE ROOM" button.
class UtilFunctions extends Component {
  public void Create() {
    String path = GetUIElement().applet.args[0];

    String[] args = {"SideBar", path};
    RoomWindow sb = new RoomWindow();
    PApplet.runSketch(args, sb);
    println("Opening Room window");
  }

  public void Settings() {
    String path = GetUIElement().applet.args[0];

    String[] args = {"SideBar", path};
    SettingsWindow sb = new SettingsWindow();
    PApplet.runSketch(args, sb);
    println("Opening Settings");
  }

  public void CreateBreakoutWindow(RoomWindow applet, UIElement parent) {
    UIElement b_room_1 = new UIElement(applet, "breakout room 1", parent.transform, new Rect(-48, -96, 48, 96), new Rect(.7, .3, .9, .7));
    b_room_1.AddComponent(new BreakoutWindow());
    println("Creating Breakout room UIElement");
  }
}