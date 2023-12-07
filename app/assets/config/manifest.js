//= link_tree ../images
//= link_directory ../stylesheets .css
//= link_tree ../../javascript .js
//= link_tree ../../../vendor/javascript .js
//= link popper.js
//= link bootstrap.min.js
//= link manifest.json

const serviceWorkerFile = '/manifest.js';
if ('manifest' in navigator) {
  navigator.serviceWorker.register(serviceWorkerFile, { scope: '/' })
    .then((registration) => {
      console.log('Service Worker registered with scope:', registration.scope);
    })
    .catch((error) => {
      console.error('Service Worker registration failed:', error);
    });
}
