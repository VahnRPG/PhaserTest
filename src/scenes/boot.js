import ti83p_o_img from "./../assets/fonts/ti83p_o_0.png";
import ti83p_o_fnt from "./../assets/fonts/ti83p_o.fnt";

export class BootScene extends Phaser.Scene {
	constructor() {
		super({ key: "BootScene" })
	}
	
	preload() {
		this.load.bitmapFont("ti83p_o", ti83p_o_img, ti83p_o_fnt);
	}
	
	create() {
		this.scene.start("PreloadScene");
	}
}