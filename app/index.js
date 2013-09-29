'use strict';
var util = require('util');
var colors = require('colors');
var path = require('path');
var yeoman = require('yeoman-generator');

var FluidityGenerator = module.exports = function FluidityGenerator(args, options, config) {
  yeoman.generators.Base.apply(this, arguments);

  this.on('end', function () {
    this.installDependencies({ skipInstall: options['skip-install'] });
  });

  this.pkg = JSON.parse(this.readFileAsString(path.join(__dirname, '../package.json')));
};

util.inherits(FluidityGenerator, yeoman.generators.Base);

FluidityGenerator.prototype.askFor = function askFor() {
  var cb = this.async();
  console.log("\n\n                                 \u2591\u2591\u2591\u2591\u2591\u2591\u2591".grey);
  console.log("                                 \u2591\u2591".grey);
  console.log("                                 \u2591\u2591\u2591\u2591\u2591\u2591".grey);
  console.log("                                 \u2591\u2591".grey);
  console.log("                                 \u2591\u2591".grey);
  console.log("                                 \u2591\u2591".grey);
  console.log('\n                      ' + 'Fluidity Design Environment.\n\n'.bold.underline.white);

  console.log("This generator will create a front-end development environment using Express,\nCoffeescript, and Stylus with Fluidity. It will create a base app and file structure.\n\nUsing the 'grunt dev' task you'll have features like live-reload on both the\nclient-side and server-side changes to view files and coffee-hinting throughout the entire app.\n\nUsing the 'grunt build' task will concat/compress/minify/lint/hint client-side js/css\nand dynamically generate documentation using docco and a generated styleguide\nwith styldocco.\n".grey);

  var prompts = [{
    name: 'appName',
    message: "Name for your project?",
    default: 'application-name'
  },
  {
    name: 'versionNum',
    message: "Version number of your project?\n",
    default: "0.0.1"
}];
  this.prompt(prompts, function (err, props) {
    if (err) {
      return this.emit('error', err);
    }
    this.appName = props.appName;
    this.versionNum = props.versionNum;
    cb();
  }.bind(this));
};

FluidityGenerator.prototype.app = function app() {
  this.mkdir('app');
  this.mkdir('app/controllers');
  this.mkdir('app/models');
  this.mkdir('app/public');
  this.mkdir('app/public/components');
  this.mkdir('app/public/css');
  this.mkdir('app/public/js');
  this.mkdir('app/public/images');
  this.mkdir('app/public/docs');
  this.mkdir('app/public/styleguide');
  this.mkdir('src/models');
  this.mkdir('src/views');
  this.mkdir('src/controllers');
  this.mkdir('src/assets');
  this.mkdir('src/assets/coffee');
  this.mkdir('src/assets/stylus');
  this.mkdir('tmp');

  this.copy('src/application.coffee', 'src/application.coffee');
  this.copy('src/controllers/index.coffee', 'src/controllers/index.coffee');
  this.copy('src/controllers/home.coffee', 'src/controllers/home.coffee');
  this.copy('src/controllers/features.coffee', 'src/controllers/features.coffee');
  this.copy('src/models/feature.coffee', 'src/models/feature.coffee');
  this.copy('src/views/layout.jade', 'src/views/layout.jade');
  this.copy('src/views/index.jade', 'src/views/index.jade');
  this.copy('src/assets/coffee/client.coffee', 'src/assets/coffee/client.coffee');
  this.copy('src/assets/stylus/app.styl', 'src/assets/stylus/app.styl');
  this.copy('app/public/docs/docstemplate/mydocco.jst', 'app/public/docs/docstemplate/mydocco.jst');
  this.copy('app/public/docs/docstemplate/mydocco.css', 'app/public/docs/docstemplate/mydocco.css');
};

FluidityGenerator.prototype.projectfiles = function projectfiles() {
  this.template('_package.json', 'package.json');
  this.template('_bower.json', 'bower.json');
  this.template('_bowerrc', '.bowerrc');
  this.copy('_Gruntfile.coffee', 'Gruntfile.coffee');
  this.copy('_bowerrc', '.bowerrc');
  this.copy('_editorconfig', '.editorconfig');
  this.copy('_server.js', 'server.js');
};
