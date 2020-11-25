class PermissionDisplay extends Component {
	private UserBubble selected_user;
	private TextLabel lbl;
	private String txt;
	private Rect full_pos;
	private Rect collapsed_pos;

	PermissionDisplay(){

	}

	public void SetUser(UIElement user){
		selected_user = (UserBubble)user.GetComponent("UserBubble");
	}

	public void Start(){
		UIElement puie = GetUIElement();
		PApplet pa = puie.applet;

		UIElement text_display = new UIElement(pa, puie.transform, new Rect(0, 0, 1, 1));
		text_display.AddComponent(new Panel(#121212, 48));
		lbl = new TextLabel("", #ffffff, 16, LEFT, TOP);
		text_display.AddComponent(lbl);

		full_pos = puie.transform.position;
		collapsed_pos = new Rect(full_pos.left, full_pos.top, full_pos.left + 256,full_pos.top + 72);
	}

	public void Update(){
		if(selected_user == null) return;
		int lvl = selected_user.GetLvl();

		txt = "\n\n  " + selected_user.GetName() +" has the following premissions: \n";
		if(lvl >= 10) txt += "  - Face Cam \n";
		// if(lvl >= 20) txt += "  - Download Files \n";
		// if(lvl >= 30) txt += "  - Upload Files \n";
		// if(lvl >= 40) txt += "  - Create Folder \n";
		if(lvl >= 50) txt += "  - Screen Sharing \n";
		if(lvl >= 60) txt += "  - Breakout Room Manipulation \n";
		if(lvl >= 70) txt += "  - Mute People \n";
		if(lvl >= 80) txt += "  - Kick People \n";
		if(lvl >= 90) txt += "  - Change Levels \n";
		if(lvl >= 100) txt += "  - Everything \n";
	}

	public void Render() {
		UIElement puie = GetUIElement();


		if(selected_user == null) {
			puie.transform.position = collapsed_pos;
			lbl.SetLabel("\n  Permission Helper");
		}else{
			puie.transform.position = full_pos;
			lbl.SetLabel(txt);
		}
	}
}