/*
  
 */
public String version = "0.1.a";

void settings() {
  println("version:", version);
}

void setup() {
  surface.setVisible(false);

  String[] args = {"SideBar", sketchPath()};
  SideBar sb = new SideBar();
  PApplet.runSketch(args, sb);
}

void draw() {
}
