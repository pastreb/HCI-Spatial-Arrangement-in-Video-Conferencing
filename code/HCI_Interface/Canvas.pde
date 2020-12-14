/*
  A canvas is basically just a UIElement that scales to the size of the screen.
 It is meant to be the root of the UIElement hierarchy
 */

class Canvas extends UIElement {
  private color bg_color;
  private ArrayList<UIElement> elements;

  Canvas(PApplet applet, color c) {
    super(applet, "canvas");

    bg_color = c;
    elements = new ArrayList<UIElement>();
    this.transform.position = new Rect(0, 0, applet.width, applet.height);
    applet.getSurface().setResizable(true);
  }

  public void Run(boolean debug_render) {
    elements = new ArrayList<UIElement>();
    GetAllChildren(elements);

    for (UIElement e : elements) {
      if (e.delete_flag) {
        e.transform.SetParent(null);
      }
    }

    for (int i = elements.size() - 1; i>=0; i--) { 
      elements.get(i).CollisionUpdate();
    }

    for (UIElement e : elements) {
      e.Update();
    }

    for (UIElement e : elements) {
      e.Render(debug_render);
    }
  }

  public void Render(boolean debug_render) {
    applet.background(bg_color);
    transform.position = new Rect(0, 0, applet.width, applet.height);
  }
}