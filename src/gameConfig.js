import { BootScene } from "./scenes/boot";
import { PreloadScene } from "./scenes/preload";
import { TitleScene } from "./scenes/title";
import { GameScene } from "./scenes/game";

export const PhaserGameConfig = {
	type: Phaser.AUTO,
	width: 800,
	height: 600,
	physics: {
		default: "arcade",
		arcade: {
			gravity: { y: 300 },
			debug: false
		}
	},
	//use class def instead of instance when/if #4522 is resolved
	scene: [
		new BootScene(),
		new PreloadScene(),
		new TitleScene(),
		new GameScene()
	],
	parent: "game-parent",
	render: {
		antialias: false
	}
};