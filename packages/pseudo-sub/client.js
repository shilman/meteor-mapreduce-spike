PseudoSub = function PseudoSub(store) {
  this.store = store;
  this.status = new ReactiveVar({loaded: true});
  this._storeIds = [];
  this._arguments = null;
  this._currentVersion = 0;
  this._loadedVersion = 0;
}

PseudoSub.subscribe = function(store, methodName /*varargs*/) {
  return (new PseudoSub(store))._subscribe(arguments.slice(1));
}

PseudoSub.prototype.ready = function() {
  return this.status.get().loaded;
}

PseudoSub.prototype.stop = function() {
  this._updateStore([]);
}

PseudoSub.prototype._subscribe = function(methodName /* varargs */) {
  if(_.isEqual(arguments, this._arguments)) return;

  var self = this;
  function handleData(err, data) {
    if(err) {
      self.status.set({error: err});
      throw err;
    } else {
      console.log("handle data!");
      if(!(data instanceof Array)) {
        data = [data];
      }
      self._updateStore(data);
      self.status.set({loaded: true});
      // if(version > self._loadedVersion) {
      //   self._updateStore(data);
      //   self._loadedVersion = version;
      // }
      // if(version == self._currentVersion) {
      //}
    }
  }

  this._arguments = _.clone(arguments);
  this.status.set({loading: true});
  var version = ++this._currentVersion;
  var zargs = new Array(arguments);
  zargs.push(handleData);
  //Meteor.call.apply(Meteor.call, zargs);
  Meteor.call("testing", handleData);
  return this;
};

PseudoSub.prototype._updateStore = function(data) {
  var self = this;
  var currentIds = [];
  data.forEach(function(item) {
    currentIds.push(item._id);
    console.log("updating", item);
    self.store.update(item._id, item, {upsert: true});
  });

  var removedItem = _.difference(this._storeIds, currentIds);
  removedItem.forEach(function(id) {
    console.log("removing", id);
    self.store.remove(id);
  });
  this._storeIds = currentIds;
  console.log("done");
};
