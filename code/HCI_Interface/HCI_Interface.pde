/*
  
 */
public String version = "0.1.a";

void settings() {
  println("version:", version);
}

void setup() {
  surface.setVisible(false);

  String[] args = {"SideBar"};
  SideBar sb = new SideBar();
  sb.debug = true;
  PApplet.runSketch(args, sb);
}

void draw() {
}
