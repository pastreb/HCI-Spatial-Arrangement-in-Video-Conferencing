/*
  UIElements are the building blocks of the UI. They describe anything from buttons to images to the background...
 Every UIElement has a transform component by default, so it always has a position in the hierarchy and in space.
 The way in which UIElements get functionality (e.g. You should be able to type something into text input fields)
 is by having a set of components. Components define all UIElement behaviour ranging from "what to render" to "what to do when X happens".
 
 They also provide a basic framework for message passing. Messages look something like this
 - If object X has a method Y, do X.Y()
 
 // TODO: 
 - Add support for message arguments/return values.
 - Add something like an "OnEnable()" and "OnDisable()" method. Could be helpful when changing the UI by enabling/disabling UIElements.
 */

class UIElement {
  public PApplet applet;
  public boolean is_active;
  public Transform transform;
  public ArrayList<Component> components;

  public UIElement(PApplet applet, Transform parent, Rect rect, Rect anchor) {
    this(applet);
    transform.SetParent(parent);
    transform.position = rect;
    transform.anchor = anchor;
  }

  public UIElement(PApplet applet, Transform parent, Rect anchor) {
    this(applet, parent, new Rect(0, 0, 0, 0), anchor);
  }

  public UIElement(PApplet applet) {
    this.applet = applet;
    this.is_active = true;
    this.transform = new Transform();
    this.components = new ArrayList<Component>();
    this.AddComponent(transform);
  }

  public void AddComponent(Component c) {
    if (c != null) {
      this.components.add(c);
      c.ui_element = this;
      
      c.Start();
    }
  }

  public void SendMessage(String message) {
    for (Component c : components) {
      CallByName(c, message);
    }
  }

  public void DebugRender() {
    transform.DebugRender();
  }

  public void Update(boolean draw_debug) {    
    if (!is_active) {
      return;
    }

    for (Component c : components) {
      if (c != null) {
        c.Update();
      }
    }

    if (draw_debug) {
      DebugRender();
    }

    for (Transform c : transform.children) {
      c.ui_element.Update(draw_debug);
    }
  }

  public void Update() {
    Update(false);
  }
}

// -------------------------------------------------------------------------------------------------------------------

/*
  A canvas is basically just a UIElement that scales to the size of the screen.
 It is meant to be the root of the UIElement hierarchy
 */
class Canvas extends UIElement {
  private color bg_color;

  Canvas(PApplet applet, color c) {
    super(applet);

    bg_color = c;
    this.transform.position = new Rect(0, 0, applet.width, applet.height);
    applet.getSurface().setResizable(true);
  }

  public void Update(boolean draw_debug) {
    applet.background(bg_color);
    transform.position = new Rect(0, 0, applet.width, applet.height);

    super.Update(draw_debug);
  }

  public void Update() {
    Update(false);
  }
}

// -------------------------------------------------------------------------------------------------------------------

/*
  The EventHandler is a collection of helper functions. What they do is when given an object and a string X is
  - Find a method of name X in the object
  - call the method. (It may have arguments/return value)
*/

public Object CallByName(Object obj, String method_name, Object[] args, boolean require_receiver) {
  try {
    java.lang.reflect.Method m = obj.getClass().getMethod(method_name);
    return m.invoke(obj, args);
  }
  catch (Exception e) {
    if(require_receiver) {
      print("Exception:", obj.getClass(), "does not contain a definition for", method_name);
    }
    return null;
  }
}

public Object CallByName(Object obj, String method_name) {
  return CallByName(obj, method_name, new Object[0], false);
}
