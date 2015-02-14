@Groups = new Mongo.Collection("groups")

Template.home.created = ->
  @sub = Meteor.subscribe("mapreduceGroups")

Template.home.destroyed = ->
  @sub and @sub.stop()

Template.home.helpers(
  ready: ->
    template = Template.instance()
    template.sub.ready()
  groups: ->
    Groups.find({})
)
