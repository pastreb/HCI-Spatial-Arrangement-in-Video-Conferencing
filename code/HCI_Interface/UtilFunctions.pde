// Utility comonent that defines the functionality when pressing the "CREATE ROOM" button.
class UtilFunctions extends Component {
  public void CreateRoom() {
    // String path = GetUIElement().applet.args[0];

    // String[] args = {"SideBar", path};
    // RoomWindow sb = new RoomWindow();
    // PApplet.runSketch(args, sb);
    // println("Opening Room window");
    frame.setSize(1760, 1000);

    rw_root.SetActive(true);
    sbw_root.transform.anchor.Set(0, 0, .2, 1);
    sw_root.transform.anchor.Set(0, 0, .2, 1);
    rw_root.transform.anchor.Set(.201, 0, 1, 1);
  }

  public void OpenSettings() {
    sbw_root.SetActive(false);
    sw_root.SetActive(true);
    println("Opening Settings");
  }

  public void CreateBreakoutWindow(UIElement parent) {


    UIElement b_room_1 = new UIElement(parent.applet, "breakout room 1", parent.transform, new Rect(-48, -96, 48, 96), new Rect(.7, .3, .9, .7));
    b_room_1.AddComponent(new BreakoutWindow());
    println("Creating Breakout room UIElement");
  }

  public void CloseSettings(){
    sbw_root.SetActive(true);
    sw_root.SetActive(false);
    println("Closing Settings");
  }

  private String[] name_list = {"Hugo", "Max", "Veronica", "Marc", "Jessica", "Alice", "Bob", "Charlie", "Sarah", "Anton", "Will", "Jake", "Monica", "Karen"};
  private String[] img_list = {"pepe.png", "fish.png", "geko.png", "hamster.png", "harold.jpg", "kermit.jpg", "rick.png", "squidward.png", "clint.png", "leo.png"};
  public void CreateUser(RoomWindow rw){
    rw.UserJoin(new User(name_list[(int)random(name_list.length)], "images/profiles/" + img_list[(int)random(img_list.length)]), 100);
  }
}