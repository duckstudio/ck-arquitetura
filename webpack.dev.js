/*********************************
 * Imports
 *********************************/
const merge = require('webpack-merge');
const common = require('./webpack.common.js');

/*********************************
 * Exports
 *********************************/
module.exports = merge(common, {
  devtool: 'source-map'
});
