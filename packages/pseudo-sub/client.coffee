class PseudoSub
  constructor: (store) ->
    @status = new ReactiveVar(loaded: true)
    @store = store
    @_storeIds = []
    @_arguments = null

  ready: -> @status.get().loaded
  stop: -> @_updateStore([])

  _handleData: (err, data) ->
    if err
      @status.set(error: true)
      throw err
    else
      console.log("handle data!")
      data = [data] if !_.isArray(data)
      @_updateStore(data)
      @status.set(loaded: true)

  _subscribe: (methodName, args...) ->
    return if _.isEqual(args, @_arguments)
    @status.set(loading: true)
    @_arguments = _.clone(args)
    Meteor.call("pesudo.subscribe", methodName, args, @_handleData.bind(this))
    this

  _updateStore: (data) ->
    self = this
    currentIds = []
    data.forEach((item) ->
      currentIds.push(item._id)
      console.log("updating", item)
      self.store.update(item._id, item, upsert: true)
    )

    removedItem = _.difference(@_storeIds, currentIds)
    removedItem.forEach((id) ->
      console.log("removing", id)
      self.store.remove(id)
    )
    @_storeIds = currentIds
    console.log("done")

PseudoSub.subscribe = (store, methodName, args...) ->
  (new PseudoSub(store))._subscribe(methodName, args)
