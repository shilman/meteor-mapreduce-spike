PseudoSub = {}
PseudoSub._sources = {}

PseudoSub.publish = (methodName, callback) ->
  PseudoSub._sources[methodName] = callback

Meteor.methods({
  "pesudo.subscribe": (methodName, args) ->
    check(methodName, String)
    check(args, Array)
    @unblock()

    getDataFromPublication(methodName, args)
})

getDataFromPublication = (methodName, args) ->
  callback = PseudoSub._sources[methodName]
  if callback
    callback.apply(PseudoSub, args)
  else
    throw new Meteor.Error(404, "No such publication: " + name)
