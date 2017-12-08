whitelisted = new Mongo.Collection 'white'
blacklisted = new Mongo.Collection 'black'

if Meteor.isServer
  whitelisted.limitUpdateOperators ['$set', '$unset']
  whitelisted.allow update: -> true
  whitelisted.remove {}
  whitelisted.insert _id: 'white'

  blacklisted.limitUpdateOperators blacklist: ['$unset']
  blacklisted.allow update: -> true
  blacklisted.remove {}
  blacklisted.insert _id: 'black'

  Meteor.publish 'all', -> [whitelisted.find(), blacklisted.find()]
else
  Meteor.subscribe 'all', onReady: ->
    Tinytest.addAsync 'whitelist', (test, next) ->
      counter = 2

      whitelisted.update {_id: 'white'}, {$set: test: true}, (err) ->
        test.isUndefined err
        next() unless --counter

      whitelisted.update {_id: 'white'}, {$push: test1: 'evil'}, (err) ->
        test.isNotNull err
        next() unless --counter

    Tinytest.addAsync 'blacklist', (test, next) ->
      counter = 2

      blacklisted.update {_id: 'black'}, {$set: test: true}, (err) ->
        test.isUndefined err
        next() unless --counter

      blacklisted.update {_id: 'black'}, {$unset: test: 1}, (err) ->
        test.isNotNull err
        next() unless --counter
