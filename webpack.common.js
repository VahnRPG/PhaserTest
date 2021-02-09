const path = require("path");
const webpack = require("webpack");

module.exports = {
	entry: "./src/index.js",
	output: {
		filename: "bundle.js",
		path: path.resolve(__dirname, "dist-0")
	},
	resolve: {
		extensions: [".js"]
	},
	module: {
		rules: [
			{
				test: /\.(png|jpg|gif)$/,
				use: [
					{
						loader: "file-loader",
						options: {
							outputPath: "assets/images",
							name: "[name].[ext]"
						}
					}
				],
			},
			{
				test: /\.(css)$/,
				use: [
					{
						loader: "file-loader",
						options: {
							outputPath: "assets/styles",
							name: "[name].[ext]"
						}
					}
				],
			},
			{
				test: /\.(xml|fnt)$/,
				use: [
					{
						loader: "file-loader",
						options: {
							outputPath: "assets/fonts",
							name: "[name].[ext]"
						}
					}
				],
			},
			{
				test: /\.(wav)$/,
				use:[
					{
						loader: "file-loader",
						options: {
							outputPath: "assets/audio",
							name: "[name].[ext]"
						}
					}
				]
			},
			{
				test: /\.(html)$/,
				use: [
					{
						loader: "file-loader",
						options: {
							name: "[name].[ext]"
						}
					},
				]
			}
		]
	}
};