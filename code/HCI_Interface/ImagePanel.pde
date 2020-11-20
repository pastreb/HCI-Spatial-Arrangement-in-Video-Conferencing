public enum ImageDisplayMode{
	RECT,
	CIRCLE,
	ROUNDRECT,
	NOMASK
} 

class ImagePanel extends Component{
	private PImage img;
	private ImageDisplayMode mode;
	final private float rounding_factor = 24;

	ImagePanel(PImage img, ImageDisplayMode mode){
		this.img = img;
		this.mode = mode;
	}

	ImagePanel(PImage img){
		this(img, ImageDisplayMode.NOMASK);
	}

	public void SetMode(ImageDisplayMode mode){
		this.mode = mode;
	}

	public void SetImage(PImage img){
		if(this.img != img){
			this.img = img;
			// img.filter(BLUR, 2);
		}
	}

	public void Render() {
		if(img == null){
			return;
		}

		Transform t = GetUIElement().transform;
    	Rect bbox = t.GlobalBounds();
    	PApplet pa = GetUIElement().applet;
	    PGraphics mask = createGraphics(img.width, img.height);

		switch (mode) {
			case RECT :
				mask.beginDraw();
				mask.background(255);
				mask.endDraw();
				img.mask(mask);

			break;	
			case CIRCLE :
			    mask.beginDraw();
			    mask.background(0);
			    mask.fill(255);
			    mask.ellipse(mask.width/2, mask.height/2, mask.width, mask.height);
			    mask.endDraw();
			    img.mask(mask);
			break;	
			case ROUNDRECT :
							    mask.beginDraw();
			    mask.background(0);
			    mask.fill(255);
			    mask.rect(0, 0, mask.width, mask.height, rounding_factor);
			    mask.endDraw();
			    img.mask(mask);
			break;
			default :
					
				break;		
		}

		pa.image(img, bbox.left, bbox.top, bbox.right - bbox.left, bbox.bot - bbox.top);
	}
}