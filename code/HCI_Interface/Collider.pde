/*
  The collider is a component that detects when the mouse hovers over it or clicks it.
 It sends the according messages to its UIElement.
 
 The messages are:
 - void OnClickEnter()  ==> The first frame that the UIElement is clicked.
 - void OnClickUpdate() ==> Every frame while the UIElement is "kept pressed".
 - void OnClickUpdate() ==> The first frame where UIElement is not clicked anymore.
 - void OnHoverEnter()  ==> The first frame that the UIElement is hovered on.
 - void OnHoverUpdate() ==> Every frame where the mouse pointer is positioned on the UIElement.
 - void OnHoverExit()   ==> The first frame where the mouse pointer is not positioned on the UIElement anymore.
 
 */
boolean c_lock = false;  // This lock ensures that only one collider at a time can be clicked, grabbed, etc

class Collider extends Component {
  private boolean is_hovered;
  private boolean is_clicked;
  private boolean is_dragged;  // TODO: Implement

  private ArrayList<Transform> collisions;

  Collider() {
    is_hovered = false;
    is_clicked = false;
    is_dragged = false;

    collisions  = new ArrayList<Transform>();
  }


  public void CollisionUpdate() {
    Transform t = GetUIElement().transform;
    Rect bbox = t.GlobalBounds();
    PApplet pa = GetUIElement().applet;
    if (pa.mouseX > bbox.left && pa.mouseX < bbox.right && pa.mouseY > bbox.top && pa.mouseY < bbox.bot && !c_lock)
    {
      if (is_hovered) {
        ui_element.SendMessage("OnHoverUpdate");
      } else
      {
        is_hovered = true;
        ui_element.SendMessage("OnHoverEnter");
      }

      if (pa.mousePressed) {
        if (is_clicked) {
          ui_element.SendMessage("OnClickUpdate");
        } else
        {
          is_clicked = true;
          c_lock = true;
          ui_element.SendMessage("OnClickEnter");
        }
      } else
      {
        if (is_clicked) {          
          ui_element.SendMessage("OnClickExit");

          is_clicked = false;
          c_lock = false;
        }
      }
    } else 
    {
      if (is_hovered) {
        is_hovered = false;
        ui_element.SendMessage("OnHoverExit");
      }

      if (is_clicked) {
        if (pa.mousePressed) {
          ui_element.SendMessage("OnClickUpdate");
        } else {
          ui_element.SendMessage("OnClickExit");

          is_clicked = false;
          c_lock = false;
        }
      }
    }

    for (Transform t2 : t.parent.children) {
      if (!t2.GetUIElement().delete_flag) {
        Rect bbox2 = t2.GlobalBounds();
        Collider col = (Collider)t2.GetUIElement().GetComponent("Collider");
        boolean is_in = collisions.contains(t2);

        if (t != t2 && col != null && bbox.top <= bbox2.bot && bbox.bot >= bbox2.top && bbox.left <= bbox2.right && bbox.right >= bbox2.left) {
          if (!is_in) {
            // println(t.GetUIElement().name, "collided with", t2.GetUIElement().name);
            ui_element.SendMessage("OnCollisionEnter", t2);
            collisions.add(t2);
          } else {
            ui_element.SendMessage("OnCollisionUpdate", t2);
          }
        } else if (is_in) {
          // println(t.GetUIElement().name, "decoupled from", t2.GetUIElement().name);
          ui_element.SendMessage("OnCollisionExit", t2);
          collisions.remove(t2);
        }
      }
    }
  }
}