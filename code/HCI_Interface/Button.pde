/*
  The button class is a component that displays a button. When clicked, it sends a message to a target UIElement.
 NOTE: THE BUTTON ONLY WORKS PROPERLY IF THE UIELEMENT ALSO HAS A COLLIDER ATTACHED!
 The button also changes color depending on if it is idle, hovered, pressed.
 */

class Button extends Component {
  // Functionality fields
  private boolean is_hovered;
  private boolean is_clicked;
  private UIElement click_target_uie;
  private UIElement hold_target_uie;
  private UIElement release_target_uie;
  private String click_message;
  private String hold_message;
  private String release_message;
  private Object[] click_args;
  private Object[] hold_args;
  private Object[] release_args;


  // Styling fields
  private String label;
  private color default_color = #bb86fc;
  private color click_color = #985eff;
  private color hover_color = #dbb2ff;
  private color text_color = #000000;
  private int text_size = 14;
  private float round_factor = 96;

  // Additional Functionalities to use an image for a button (instead of text)
  private PImage default_image = null;
  private PImage click_image = null;
  private PImage hover_image = null;

  private UIElement button_panel;
  private UIElement button_label;
  private UIElement button_image;

  Button(String label, UIElement target_uie, String message, PImage default_image, PImage click_image, PImage hover_image) {
    this.label = label;
    this.is_hovered = false;
    this.is_clicked = false;
    this.click_target_uie = target_uie;
    this.click_message = message;
    this.click_args = new Object[0];
    this.default_image = default_image;
    this.hover_image = hover_image;
    this.click_image = click_image;
  }

  Button(String label) {
    this(label, null, "", null, null, null);
  }

  // Creates a button that displays an image instead of text
  Button(String label, UIElement target_uie, String message) {
    this(label, target_uie, message, null, null, null);
  }

  Button() {
    this("", null, "", null, null, null);
  }

  public void set_textsize(int x) {
    this.text_size = x;
  }

  public void SetClickMessage(UIElement target_uie, String message, Object... args) {
    this.click_target_uie = target_uie;
    this.click_message = message;
    this.click_args = args;
  }

  public void SetHoldMessage(UIElement target_uie, String message, Object... args) {
    this.hold_target_uie = target_uie;
    this.hold_message = message;
    this.hold_args = args;
  }

  public void SetReleaseMessage(UIElement target_uie, String message, Object... args) {
    this.release_target_uie = target_uie;
    this.release_message = message;
    this.release_args = args;
  }

  public void Start(){
    Transform t = GetUIElement().transform;
    Rect bbox = t.GlobalBounds();
    PApplet pa = GetUIElement().applet;

    button_panel = new UIElement(pa, t, new Rect(0, 0, 0, 0), new Rect(0, 0, 1, 1));
    button_panel.AddComponent(new Panel(default_color, round_factor));

    button_label = new UIElement(pa, t, new Rect(0, 0, 0, 0), new Rect(.3, 0, 1, 1));
    button_label.AddComponent(new TextLabel(label, text_color, text_size, CENTER, CENTER));

    button_image = new UIElement(pa, t, new Rect(0, 0, 0, 0), new Rect(0, 0, .3, 1));
    button_image.AddComponent(new ImagePanel(default_image));

    Update();
  }

  public void Update() {
    PImage img;
    color clr;

    if (is_hovered){
      img = hover_image;
      clr = hover_color;
    } else {
      img = default_image;
      clr = default_color;
    }

    if(img == null && label == ""){
      button_panel.SetActive(false);
    } else if(img != null && label == ""){
      button_image.transform.anchor.Set(0, 0, 1, 1);
      button_panel.SetActive(false);
    } else if(img == null && label != ""){
      button_label.transform.anchor.Set(0, 0, 1, 1);
      button_panel.SetActive(true);
    } else {
      button_label.transform.anchor.Set(0, 0, .3, 1);
      button_image.transform.anchor.Set(.3, 0, 1, 1);
      button_panel.SetActive(true);
    }

    ((ImagePanel)button_image.GetComponent("ImagePanel")).SetImage(img);
    ((Panel)button_panel.GetComponent("Panel")).SetColor(clr);
    ((TextLabel)button_label.GetComponent("TextLabel")).SetLabel(label);


  }

  void OnClickEnter() {
    println("Clicked button", label);
    is_clicked = true;
    if (click_target_uie != null) {
      click_target_uie.SendMessage(click_message, click_args);
    }
  }

  void OnClickUpdate() {
    if (hold_target_uie != null) {
      // println("Holding button", label);
      hold_target_uie.SendMessage(hold_message, hold_args);
    }
  }

  void OnClickExit() {
    is_clicked = false;
    if (release_target_uie != null) {
      println("Released button", label);
      release_target_uie.SendMessage(release_message, release_args);
    }
  }

  void OnHoverEnter() {
    is_hovered = true;
  }

  void OnHoverExit() {
    is_hovered = false;
  }
}