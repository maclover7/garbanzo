exports.config = {
  // See http://brunch.io/#documentation for docs.
  files: {
    javascripts: {
      joinTo: 'js/app.js'
    },
    stylesheets: {
      joinTo: 'css/app.css'
    },
    templates: {
      joinTo: 'js/app.js'
    }
  },

  npm: {
    enabled: true
  },

  // Phoenix paths configuration
  paths: {
    // Which directories to watch
    watched: ["assets", "assets"],

    // Where to compile files to
    public: "compiled-assets"
  },

  // Configure your plugins
  plugins: {
    ES6to5: {
      // Do not use ES6 compiler in vendor code
      ignore: [/^(assets\/vendor)/]
    }
  }
};
