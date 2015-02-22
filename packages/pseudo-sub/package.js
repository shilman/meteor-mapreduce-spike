Package.describe({
  "summary": "Fast drop-in pseudo-subscriptions using Meteor methods",
  "version": "0.0.1",
  "git": "https://github.com/lab80/pseudo-sub.git",
  "name": "lab80:pseudo-sub"
});

Package.onUse(function(api) {
  configurePackage(api);
  api.export(['PseudoSub']);
});

//Package.onTest(function(api) {
//  configurePackage(api);
//
//  api.use(['tinytest', 'mongo-livedata'], ['client', 'server']);
//});

function configurePackage(api) {
  api.versionsFrom('METEOR@0.9.2');
  api.use([
    'tracker', 'underscore', 'mongo', 'reactive-var', 'http'
  ], ['client']);

  api.add_files([
    'client.js',
  ], ['client']);
}
