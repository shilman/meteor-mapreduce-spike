@Groups = new Mongo.Collection("groups")

Template.home.created = ->
  @sub = PseudoSub.subscribe(Groups, "testing")

Template.home.destroyed = ->
  @sub and @sub.stop()

Template.home.helpers(
  ready: ->
    template = Template.instance()
    template.sub.ready()
  groups: ->
    Groups.find({})
)
