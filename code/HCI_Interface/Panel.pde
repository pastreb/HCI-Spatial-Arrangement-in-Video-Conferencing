/* 
 A panel is a component that renders the UIElement as a rectangle with a solid color
 */

class Panel extends Component {
  public color c;

  private float round_factor = 0;

  Panel(color c, float round_factor) {
    this.c = c;
    this.round_factor = round_factor;
  }

  Panel(color c) {
    this(c, 0);
  }

  public void SetColor(color c){
    this.c = c;
  }

  public void Render() {
    Transform t = GetUIElement().transform;
    Rect bbox = t.GlobalBounds();
    PApplet pa = GetUIElement().applet;

    pa.fill(c);
    pa.noStroke();
    pa.rect(bbox.left, bbox.top, bbox.right-bbox.left, bbox.bot-bbox.top, round_factor);
  }
}