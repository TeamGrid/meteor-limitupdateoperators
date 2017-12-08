CollectionExtensions.addPrototype 'limitUpdateOperators', (opts) ->
  options =
    whitelist: opts.whitelist or []
    blacklist: opts.blacklist or []
  options.whitelist = opts unless options.whitelist.length or options.blacklist.length
  check options,
    whitelist: [String]
    blacklist: [String]

  throw new Meteor.Error 'please provide whitelist OR blacklist' if options.whitelist.length and options.blacklist.length

  @deny
    update: (userId, doc, fieldNames, modifier) ->
      keys = _.keys modifier
      if options.whitelist.length
        args = [keys].concat options.whitelist
        # if keys length without whitelist is greater than zero
        return _.without.apply(_, args).length > 0
      else
        for key in options.blacklist when key in keys
          return true
        return false
