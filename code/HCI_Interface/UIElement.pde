import java.util.Collections;

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
  private String name;
  public PApplet applet;
  public boolean is_active;
  private boolean delete_flag;
  public Transform transform;
  public ArrayList<Component> components;

  public UIElement(PApplet applet, Transform parent, Rect rect, Rect anchor) {
    this(applet, "myUIElement", parent, rect, anchor);
  }

  public UIElement(PApplet applet, String name, Transform parent, Rect rect, Rect anchor) {
    this(applet, name);
    transform.SetParent(parent);
    transform.position = rect;
    transform.anchor = anchor;
  }

  public UIElement(PApplet applet, Transform parent, Rect anchor) {
    this(applet, parent, new Rect(0, 0, 0, 0), anchor);
  }

  public UIElement(PApplet applet, String name) {
    this.name = name;
    this.applet = applet;
    this.is_active = true;
    this.transform = new Transform();
    this.components = new ArrayList<Component>();
    this.AddComponent(transform);
    this.delete_flag = false;
  }

  public void AddComponent(Component c) {
    if (c != null) {
      this.components.add(c);
      c.ui_element = this;

      c.Start();
    }
  }

  public Component GetComponent(String class_name) {
    for (Component c : components) {
      if (c.getClass().getName().contains(class_name)) {
        return c;
      }
    }
    return null;
  }

  public void SendMessage(String message, Object... args) {
    for (Component c : components) {
      CallByName(c, message, args);
    }
  }

  public void SetActive(boolean active) {
    this.is_active = active;
    for(Transform c : transform.children){
      c.GetUIElement().SetActive(active);
    }
  }

  public ArrayList<UIElement> GetChildren(ArrayList<UIElement> buf) {
    for (Transform t : transform.children) {
      buf.add(t.GetUIElement());
    }
    return buf;
  }

  public ArrayList<UIElement> GetAllChildren(ArrayList<UIElement> buf) {
    if (!delete_flag) {
      buf.add(this);

      for (Transform t : transform.children) {
        t.GetUIElement().GetAllChildren(buf);
      }
    }

    return buf;
  }

  public void Update() {
    if (!is_active) {
      return;
    }

    for (Component c : components) {
      if (c != null) {
        c.Update();
      }
    }
  }

  public void CollisionUpdate() {
    if (!is_active) {
      return;
    }

    for (Component c : components) {
      if (c != null) {
        c.CollisionUpdate();
      }
    }
  }

  public void Render(boolean draw_debug) {
    if (!is_active) {
      return;
    }

    for (Component c : components) {
      if (c != null) {
        c.Render();
      }
    }

    if (draw_debug) {
      transform.DebugRender();
    }
  }

  public void Delete() {
    delete_flag = true;
    Transform p = transform.parent;

    for (Transform c : transform.children) {
      // c.GetUIElement().Delete();

    }
  }
}

// -------------------------------------------------------------------------------------------------------------------

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

// -------------------------------------------------------------------------------------------------------------------

/*
  The EventHandler is a collection of helper functions. What they do is when given an object and a string X is
 - Find a method of name X in the object
 - call the method. (It may have arguments/return value)
 */

public Object CallByName(Object obj, String method_name, Object[] args) {
  try {
    Class[] t = new Class[args.length];
    for (int i=0; i<args.length; i++) {
      t[i] = args[i].getClass();
    }

    java.lang.reflect.Method m = obj.getClass().getMethod(method_name, t);

    return m.invoke(obj, args);
  }
  catch (NoSuchMethodException e) {
    return null;
  }
  catch (IllegalAccessException e) {
    return null;

  }
  catch (java.lang.reflect.InvocationTargetException e) {
    return null;
  }
}
