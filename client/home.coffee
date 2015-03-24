@Groups = new Mongo.Collection(null)

Template.home.created = ->
  @sub = PseudoSub.subscribe(Groups, "method1")

Template.home.destroyed = ->
  @sub and @sub.stop()

Template.home.helpers(
  ready: ->
    template = Template.instance()
    template.sub.ready()
  groups: ->
    Groups.find({})
)
