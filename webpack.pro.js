/*********************************
 * Imports
 *********************************/
const merge = require('webpack-merge');
const common = require('./webpack.common.js');
const UglifyJSPlugin = require('uglifyjs-webpack-plugin');
const OptimizeCssAssetsPlugin = require('optimize-css-assets-webpack-plugin');

/*********************************
 * Plugins
 *********************************/
const _plugins = [new UglifyJSPlugin(), new OptimizeCssAssetsPlugin()];

/*********************************
 * Exports
 *********************************/
module.exports = merge(common, {
  plugins: _plugins
});
