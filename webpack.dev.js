const path = require("path");
const { merge } = require("webpack-merge");

const common = require("./webpack.common.js");

module.exports = merge(common, {
	devtool: "inline-source-map",
	devServer: {
		contentBase: path.join(__dirname, "dist-0"),
		compress: true,
		port: 9000,
		overlay: true,
		open: true
	}
});