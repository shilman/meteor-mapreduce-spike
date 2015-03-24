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

function configurePackage(api) {
  api.versionsFrom('METEOR@0.9.2');
  api.use([
    'coffeescript', 'underscore', 'reactive-var'
  ]);

  api.add_files([
    'client.coffee',
  ], ['client']);

  api.add_files([
    'server.coffee',
  ], ['server']);
}
