/*
  A component that renders a text label
 */

class TextLabel extends Component {
  public String label;
  public color text_color;
  public int text_size;
  public int v_align;
  public int h_align;

  TextLabel(String label, color text_color, int text_size, int h_align, int v_align) {
    this.label = label;
    this.text_color = text_color;
    this.text_size = text_size;
    this.h_align = h_align;
    this.v_align = v_align;
  }

  TextLabel(String label, color text_color, int text_size) {
    this(label, text_color, text_size, LEFT, CENTER);
  }


  TextLabel(String label, color text_color) {
    this(label, text_color, 12, LEFT, CENTER);
  }

  public void SetLabel(String label) {
    this.label = label;
  }

  public void Render() {
    Transform t = GetUIElement().transform;
    Rect bbox = t.GlobalBounds();
    PApplet pa = GetUIElement().applet;

    pa.fill(text_color);
    pa.textSize(text_size);
    pa.textAlign(h_align, v_align);
    pa.text(label, bbox.left, bbox.top, bbox.right-bbox.left, bbox.bot-bbox.top);
  }
}