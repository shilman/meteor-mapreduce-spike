Items = new Mongo.Collection("items")

Meteor.startup(->
  if not Items.find({}).count()
    _.each(["A", "B", "C"], (key) ->
      _.each(_.range(20), (idx) ->
        Items.insert(key: key, value: Math.random())
      )
    )
)

Meteor.publish('simpleGroups', ->
  @added("groups", "foo", {key: "foo", value: 10})
  @added("groups", "bar", {key: "bar", value: 10})
  @ready()
)

Meteor.publish('aggregateGroups', ->
  groups = Items.aggregate([
    {$group: {_id: "$key", value: {$avg: "$value"}, count: { $sum: 1 }}}
  ])
  _.each(groups, (group) =>
    @added("groups", group._id, {key: group._id, value: group.value})
  )
  @ready()
)

Meteor.publish('mapreduceGroups', ->
  map = ->
    bucket = if @value < .3 then "a" else "b"
    emit(bucket, @value)
  reduce = (key, values) -> values.length
  options =
    query: {}
    out: {inline: 1}

  coll = Items._getCollection()
  groups = Meteor.wrapAsync(coll.mapReduce.bind(coll))(map, reduce, options)
  console.log "groups", groups

  _.each(groups, (group) =>
    @added("groups", group._id, {key: group._id, value: group.value})
  )
  @ready()
)

Meteor.methods(
  methodGroups: ->
    groups = Items.aggregate([
      {$group: {_id: "$key", value: {$avg: "$value"}, count: { $sum: 1 }}}
    ])
    _.map(groups, (group) => {_id: group._id, key: group._id, value: group.value})
)


PseudoSub.publish("method1", ->
  {test: "test"}
)
