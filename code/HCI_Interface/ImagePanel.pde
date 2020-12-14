public enum ImageDisplayMode{
	RECT,
	CIRCLE,
	ROUNDRECT,
	NOMASK
} 

public enum ImageContentType{
	IMAGE,
	VIDEO,
	CAMERA
}

class ImagePanel extends Component{
	private Movie vid;
	private Movie cam;
	private PImage img;
	private ImageDisplayMode mode;
	public ImageContentType content;
	final private float rounding_factor = 24;

	ImagePanel(PImage img, ImageDisplayMode mode){
		this.img = img;
		this.mode = mode;
		this.content = ImageContentType.IMAGE;
	}

	ImagePanel(PImage img){
		this(img, ImageDisplayMode.NOMASK);
	}

	public void SetMode(ImageDisplayMode mode){
		this.mode = mode;
	}

	public void SetImage(PImage img){
		this.content = ImageContentType.IMAGE;
		if(this.img != img){
			this.img = img;
			// img.filter(BLUR, 2);
		}
	}

	public void SetVideo(Movie vid){
		this.content = ImageContentType.VIDEO;
		if(this.vid != vid){
			this.vid = vid;
		}
	}

	public void SetCam(Movie cam){
		this.content = ImageContentType.CAMERA;
		if(this.cam != cam){
			this.cam = cam;
		}
	}

	public void Render() {
		if(img == null && content == ImageContentType.IMAGE) return;
		if(cam == null && content == ImageContentType.CAMERA) return;
		if(vid == null && content == ImageContentType.VIDEO) return;

		Transform t = GetUIElement().transform;
    	Rect bbox = t.GlobalBounds();
    	PApplet pa = GetUIElement().applet;

		if(content == ImageContentType.IMAGE){
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
		}

		switch (content) {
			case IMAGE :
				if(img != null) pa.image(img, bbox.left, bbox.top, bbox.right - bbox.left, bbox.bot - bbox.top);
				else println("no img found");
			break;	
			case VIDEO :
				if(vid != null) pa.image(vid, bbox.left, bbox.top, bbox.right - bbox.left, bbox.bot - bbox.top);
				else println("no vid found");
			break;	
			case CAMERA :
				if(cam != null) pa.image(cam, bbox.left, bbox.top, bbox.right - bbox.left, bbox.bot - bbox.top);
				else println("no cam feed found");
			break;	
		}
	}
}