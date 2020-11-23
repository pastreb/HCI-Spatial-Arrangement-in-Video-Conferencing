/*
  
 */
public String version = "0.1.d";

void settings() {
  println("version:", version);
}

void setup() {
  surface.setVisible(false);
  
  String[] args = {"SideBar", sketchPath()};
  SidebarWindow sb = new SidebarWindow();

  PApplet.runSketch(args, sb);
}

void draw() {
}
