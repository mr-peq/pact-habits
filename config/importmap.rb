# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true
pin "flatpickr", to: "https://ga.jspm.io/npm:flatpickr@4.6.13/dist/esm/index.js"
pin "typedjs", to: "https://ga.jspm.io/npm:typedjs@0.2.2/lib/index.js"
pin "assert", to: "https://ga.jspm.io/npm:@jspm/core@2.0.1/nodelibs/browser/assert.js"
pin "dune", to: "https://ga.jspm.io/npm:dune@0.2.1/lib/dune2.js"
pin "esprima", to: "https://ga.jspm.io/npm:esprima@4.0.1/dist/esprima.js"
pin "events", to: "https://ga.jspm.io/npm:@jspm/core@2.0.1/nodelibs/browser/events.js"
pin "fs", to: "https://ga.jspm.io/npm:@jspm/core@2.0.1/nodelibs/browser/fs.js"
pin "fu", to: "https://ga.jspm.io/npm:fu@0.1.0/fu.js"
pin "module", to: "https://ga.jspm.io/npm:@jspm/core@2.0.1/nodelibs/browser/module.js"
pin "parser", to: "https://ga.jspm.io/npm:parser@0.1.4/lib/Parser.js"
pin "path", to: "https://ga.jspm.io/npm:@jspm/core@2.0.1/nodelibs/browser/path.js"
pin "process", to: "https://ga.jspm.io/npm:@jspm/core@2.0.1/nodelibs/browser/process-production.js"
pin "tg", to: "https://ga.jspm.io/npm:tg@0.0.7/tg.js"
pin "util", to: "https://ga.jspm.io/npm:@jspm/core@2.0.1/nodelibs/browser/util.js"
pin "vm", to: "https://ga.jspm.io/npm:@jspm/core@2.0.1/nodelibs/browser/vm.js"
