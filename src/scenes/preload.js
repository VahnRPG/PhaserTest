import sky_img from "./../assets/images/sky.png";
import platform_img from "./../assets/images/platform.png";
import star_img from "./../assets/images/star.png";
import bomb_img from "./../assets/images/bomb.png";
import dude_img from "./../assets/images/dude.png";

export class PreloadScene extends Phaser.Scene {
	constructor() {
		super({ key: "PreloadScene" })
		
		this.bmtLoading = null;
	}
	
	preload() {
		//bitmap text resource already loaded, safe to use
		this.bmtLoading = this.add.bitmapText(400, 400, "ti83p_o", "Loading...").setOrigin(0.5, 0.5);
		
		// load all resources here
		this.load.image("sky", sky_img);
		this.load.image("ground", platform_img);
		this.load.image("star", star_img);
		this.load.image("bomb", bomb_img);
		this.load.spritesheet("dude", dude_img, { frameWidth: 32, frameHeight: 48 });
	}
	
	create() {
		this.scene.start("TitleScene");
	}
}