/* eslint-disable */
Package.describe({
  name: 'teamgrid:limit-update-operators',
  version: '0.2.0',
  summary: 'Easy limiting of mongo update operators (deny rule)',
  git: 'https://github.com/TeamGrid/meteor-limitupdateoperators.git',
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.6.1');
  api.use('coffeescript@2.0.0');
  api.use('underscore');
  api.use('check');
  api.use('lai:collection-extensions@0.2.1_1');
  api.addFiles('limit-update-operators.coffee', 'server');
});

Package.onTest(function(api) {
  api.use('coffeescript');
  api.use('tinytest');
  api.use('mongo');
  api.use('teamgrid:limit-update-operators');
  api.addFiles('limit-update-operators-tests.coffee');
});
