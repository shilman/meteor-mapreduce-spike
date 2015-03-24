lab80:pseudo-sub
=============

Fast drop-in pseudo-subscriptions using Meteor methods, inspired by [meteorhacks:search-source](https://meteorhacks.com/implementing-an-instant-search-solution-with-meteor.html).

## Installation

```
meteor add lab80:pseudo-sub
```

## Client Pseudo-Subscription

```coffee
subscription = PseudoSub.subscribe(collection, "methodName", arguments);
if subscription.ready()
  ...
```

Notes:
 - `collection` should be a client-side collection
 - `generator` should be an asynchronous function that returns a list of documents, such as a Meteor method


### Define the data source on the server

In the server, get data from any backend and send those data to the client as shown below. You need to return an array of documents where each of those object consists of `_id` field.
