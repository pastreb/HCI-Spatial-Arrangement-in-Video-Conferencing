
/*
  Components are what gives UIElements functionality. 
 i.e. Render the UIElement as a button, text, ... but also detecting the mouse pointer, moving UIElements...
 So UIElements are basically containers for multiple components. This collection of components forms the behaviour of the UIElement.
 
 So when creating a button as an example, do the following
 - Create an instance of UIElement and position it somewhere
 - Add the Button component (this renders the UIElement as a button)
 - Add a Collider component (so that the UIElement can detect the mouse and so that other components may use it)
 */

class Component {
  public UIElement ui_element;

  public void Start() {
  }

  public void Update() {
  }

  public void CollisionUpdate() {
  }

  public void Render() {
  }

  public UIElement GetUIElement() {
    return ui_element;
  }
}