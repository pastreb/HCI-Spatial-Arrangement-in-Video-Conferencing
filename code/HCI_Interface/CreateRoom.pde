class CreateRoom extends Component {
  public void Create() {
    String[] args = {"SideBar"};
    Room sb = new Room();
    sb.debug = true;
    PApplet.runSketch(args, sb);
  }
}
