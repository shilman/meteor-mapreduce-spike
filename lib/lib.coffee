Meteor.methods(
  testing: ->
    console.log "testing", Meteor.isClient, Meteor.isServer
    [{_id: "foo", key: "val"}]
)
