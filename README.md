# Generator-fluidity
This generator will create a front-end development environment using Express, Coffeescript, and Stylus with Fluidity. It will create a base app and file structure.

Using the 'grunt dev' task you'll have features like live-reload on both the client-side and server-side changes to view files and coffee-hinting throughout the entire app.

Using the 'grunt build' task will concat/compress/minify/lint/hint client-side js/css and dynamically generate documentation using docco and a generated styleguide with styldocco. A generator for Yeoman

## Getting started

- Make sure you have [yo](https://github.com/yeoman/yo) installed:
    `npm install -g yo`
- Install the generator: `npm install -g generator-fluidity`
- Run: `yo fluidity`

## Other Prerequesites

Docco requires the python library Pygments for syntax highlighting in code.

- Install Pygments: `sudo easy_install Pygments`

## License
[MIT License](http://en.wikipedia.org/wiki/MIT_License)
