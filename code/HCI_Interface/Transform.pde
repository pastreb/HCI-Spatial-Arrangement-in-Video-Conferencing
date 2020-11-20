/*
  Transform is probably the most complex and most important component.
 It describes the position of a UIElement SPACIALLY AND IN THE HIERARCHY.
 It is also the only component that is automatically bound to every UIElement by default.
 
 What is the hierarchy?
 Every UI has a hierarchy of some sort. For example:
 - A login window usually has a username-field, a password-field and a login-button that are grouped together.
 - When opening any social media website, there is usually a navigation header (with multiple buttons), a feed with multiple text sections, a list of friends
 and all those elements are different from each other and they contain multiple other elements (e.g. multiple buttons, images, texts, ...)
 
 The UI for this program is grouped in a similar manner
 - Each object/UIElement has a parent.
 - UIElements can have multiple children (or just one, or none)
 - This means that all UIElements together form a tree of parents/children
 - The root of this tree is also a UIElement, usually an instance of class Canvas
 
 Now for spatial positioning of UIElements
 - The position of an UIElement is always defined relative to its parent.
 - The position is of type rect which basically defines the position of the top-left and the bottom-right corner of a UIElement.
 - position describes the pixel-position and pixel-size to its parent, so it is not relative to size.
 - the anchor is relative to the size of the parent. basically 
 - anchor = (0,0,0,0) means that "position" relates to the pixel position of the top-left corner of the parent
 - anchor = (0.5, 0.5, 0.5, 0.5) means that "position" relates to the pixel position relative to the center of the parent
 - anchor = (0, 0, 1, 0) means that "position" stretches the whole x-axis at the top of the parent
 - anchor = (0, 0, 1, 1) means that "position" fills the whole space the parent occupies.
 To get a feel for this it is best to look at the code of the function GlobalBounds().
 
 Why so complicated?
 - There has to be some sort of hierarchy to create a structured UI. Everything else would be a mess.
 - There has to be some notion of position and size
 - Since users can move some stuff around freely, they should be able to decide how large the "canvas" is on which they move stuff around.
 - To make UI resizable, relative size/position (to the parent) should be used instead of pixel
 - But making everythig purely relative to the parent size is also bad because i.e. buttons should be of a fixed size. 
 - To work with relative sizes exclusively can also be kind of a hassle. With pixels you know exactly what you get.
 
 */

class Transform extends Component {

  public Transform parent;
  public ArrayList<Transform> children;

  public Rect position;
  public Rect anchor;

  Transform(Transform p, int x, int y, int sx, int sy) {
    this.children = new ArrayList<Transform>();

    this.position = new Rect(x, y, sx, sy);
    this.anchor = new Rect(0, 0, 0, 0);

    SetParent(p);
  }

  Transform() {
    this(null, 0, 0, 100, 100);
  }

  Transform(Transform p) {
    this(p, 0, 0, 100, 100);
  }

  public void SetParent(Transform p) {
    if (parent != null) {
      parent.children.remove(this);
    }
    if (p != null) {
      p.children.add(this);
    }
    parent = p;
  }

  public void SetAnchor(Rect anchor) {
    this.anchor = anchor;
  }

  public PVector getPosition() {
    Rect r = GlobalBounds();
    return new PVector(r.left, r.top);
  }

  public PVector getSize() {
    Rect r = GlobalBounds();
    return new PVector(r.right - r.left, r.bot - r.top);
  }

  public Rect GlobalBounds() {
    if (parent == null) {
      return position;
    } else {
      Rect r = parent.GlobalBounds();
      return new Rect(
        lerp(r.left, r.right, anchor.left) + position.left, 
        lerp(r.top, r.bot, anchor.top) + position.top, 
        lerp(r.left, r.right, anchor.right) + position.right, 
        lerp(r.top, r.bot, anchor.bot) + position.bot
        // lerp(start,stop,amt) calculates a number between start and stop at a specific increment. 
        // The amt parameter is the amount to interpolate between the two values where 0.0 is equal to the first point, 0.1 is very near 
        // to the first point, 0.5 is half-way in between and so on.
        );
    }
  }

  public PVector RelativeFromAbsolute(PVector pos) {
    Rect r = GlobalBounds();
    return new PVector((pos.x - r.left) / (r.right - r.left), (pos.y - r.top) / (r.bot - r.top));
  }

  // Draws a green rectangle around the bounds of the transform. Hand for debugging UIElements that don't render anything else.
  public void DebugRender() {
    Rect r = GlobalBounds();
    PApplet pa = GetUIElement().applet;

    pa.noFill();
    pa.stroke(#00ff00);
    pa.strokeWeight(1);
    pa.rect(r.left, r.top, r.right - r.left, r.bot - r.top);
    pa.noStroke();
  }
}