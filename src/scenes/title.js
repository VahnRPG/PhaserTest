export class TitleScene extends Phaser.Scene {
	constructor() {
		super({ key: "TitleScene" })
		
		this.ready = false;
		this.space = null;
	}
	
	create() {
		this.add.bitmapText(400, 300, "ti83p_o", "GAME TITLE!").setOrigin(0.5, 0.5);
		this.add.bitmapText(400, 548, "ti83p_o", "Press Space...").setOrigin(0.5, 1);
		
		this.space = this.input.keyboard.addKey(Phaser.Input.Keyboard.KeyCodes.SPACE, true);
		
		this.cameras.main.fadeIn(2000, 0, 0, 0, this._fadeCheck, this);
	}
	
	update() {
		if (this.ready === true && this.space.isDown) {
			this.scene.start("GameScene");
		}
	}
	
	_fadeCheck(camera, progress) {
		if (progress === 1) {
			this.ready = true;
		}
	}
}