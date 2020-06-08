/*********************************
 * Imports & path
 *********************************/
const path = require('path');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const webpack = require('webpack');

/*********************************
 * Entry
 *********************************/
const _entry = [
  './source/assets/javascripts/application.js',
  './source/assets/stylesheets/application.scss'
];

/*********************************
 * Output
 *********************************/
const _output = {
  path: path.resolve(__dirname, '.tmp/dist/assets'),
  filename: 'javascripts/application.js'
};

/*********************************
 * Module
 *********************************/
const _module = {
  rules: [
    {
      test: /\.js$/,
      exclude: /node_modules/,
      use: {
        loader: 'babel-loader'
      }
    },
    {
      test: /\.(sa|sc|c)ss$/,
      use: [
        MiniCssExtractPlugin.loader,
        {
          loader: 'css-loader',
          options: {
            url: false,
            sourceMap: true
          }
        },
        {
          loader: 'postcss-loader',
          options: {
            sourceMap: true
          }
        },
        {
          loader: 'sass-loader',
          options: {
            sourceMap: true
          }
        }
      ]
    },
    {
      test: require.resolve('jquery'),
      use: [{
          loader: 'expose-loader',
          options: '$'
      }]
    }
  ]
};

/*********************************
 * Plugins
 *********************************/
const _plugins = [
  new MiniCssExtractPlugin({
    filename: 'stylesheets/application.css',
    allChunks: true
  }),
  new CopyWebpackPlugin([
    {
      from: './source/assets/images',
      to: 'images',
      ignore: '.*'
    }
  ]),
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery'
  })
];

/*********************************
 * Exports
 *********************************/
module.exports = {
  entry: _entry,
  output: _output,
  module: _module,
  plugins: _plugins
};
