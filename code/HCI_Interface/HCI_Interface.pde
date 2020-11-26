/*
	This represents the starting point of the frontent program.
	Creates windows withing a single PApplet instance. Additionally, it provides
	those windows with a root UIElement. It is also responsible for calling the 
	update functions of all children UIElements.

 */
public String version = "0.1.d";
private boolean debug = false;

private boolean start_flag = false;

private Canvas root;
private UIElement sbw_root;
private UIElement sw_root;
private UIElement rw_root;

private SidebarWindow sbw;
private SettingsWindow sw;
private RoomWindow rw;

void settings() {
	println("version:", version);
		size(360, 1000);

}

void setup() {
  	// surface.setVisible(false);
  
  	// String[] args = {"SideBar", sketchPath()};
  	root = new Canvas(this, #121212);
  	sbw_root = new UIElement(this, root.transform, new Rect(0, 0, 1, 1));
  	sw_root = new UIElement(this, root.transform, new Rect(0, 0, 1, 1));
  	rw_root = new UIElement(this, root.transform, new Rect(0, 0, 1, 1));

  	sbw = new SidebarWindow(sbw_root);
  	sw = new SettingsWindow(sw_root);
  	rw = new RoomWindow(rw_root);
  	// PApplet.runSketch(args, sb);

  	rw_root.SetActive(false);
  	sw_root.SetActive(false);
}

void draw() {
	root.Run(debug);
}

// This method is needed by the processing video library. If a new video frame is available, it reads it.
void movieEvent(Movie m){
	if(m.available()){
	  m.read();
	}
}


