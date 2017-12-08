# teamgrid:limit-update-operators [![Build Status](https://travis-ci.org/teamgrid/meteor-limitupdateoperators.svg)](https://travis-ci.org/teamgrid/meteor-limitupdateoperators)
Easy limiting of mongo update operators (deny rule)

## What it does

If you're using allow/deny rules in your app, in the most cases you're blocking specific mongo update operators (e.g. `$rename`). With this package, you can easily limit the update operators per collection


## Installation
```
    meteor add teamgrid:limit-update-operators
```

## Usage

````javascript
  var Posts = new Mongo.Collection('posts');


  Posts.limitUpdateOperators(['$set', '$unset']); // whitelisting

  Posts.limitUpdateOperators({ // blacklisting
    blacklist: ['$rename']
  });
````
