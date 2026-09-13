/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\callback_group.gsc
****************************************************/

callback_create() {
  group = spawnStruct();
  group.subscriptions = [];
  return group;
}

callback_subscribe(callback, target) {
  _id_BE66E5030B255FF1 = spawnStruct();
  _id_BE66E5030B255FF1.target = target;
  _id_BE66E5030B255FF1.callback = callback;
  self.subscriptions = scripts\engine\utility::array_removeundefined(self.subscriptions);
  self.subscriptions[self.subscriptions.size] = _id_BE66E5030B255FF1;
}

callback_unsubscribe(callback, target) {
  _id_9B1824B62FC47BAF = 0;

  foreach(index, _id_BE66E5030B255FF1 in self.subscriptions) {
    if(_id_BE66E5030B255FF1.callback == callback) {
      if(_id_BE66E5030B255FF1.target == target) {
        self.subscriptions[index] = undefined;
        return;
      }
    }
  }
}

callback_trigger(param1, param2, param3, param4) {
  foreach(index, _id_BE66E5030B255FF1 in self.subscriptions) {
    if(!isDefined(_id_BE66E5030B255FF1.target))
      self.subscriptions[index] = undefined;
  }

  subscriptions = self.subscriptions;

  if(isDefined(param4)) {
    foreach(_id_BE66E5030B255FF1 in subscriptions)
    _id_BE66E5030B255FF1.target[[_id_BE66E5030B255FF1.callback]](param1, param2, param3, param4);
  } else if(isDefined(param3)) {
    foreach(_id_BE66E5030B255FF1 in subscriptions)
    _id_BE66E5030B255FF1.target[[_id_BE66E5030B255FF1.callback]](param1, param2, param3);
  } else if(isDefined(param2)) {
    foreach(_id_BE66E5030B255FF1 in subscriptions)
    _id_BE66E5030B255FF1.target[[_id_BE66E5030B255FF1.callback]](param1, param2);
  } else if(isDefined(param1)) {
    foreach(_id_BE66E5030B255FF1 in subscriptions)
    _id_BE66E5030B255FF1.target[[_id_BE66E5030B255FF1.callback]](param1);
  } else {
    foreach(_id_BE66E5030B255FF1 in subscriptions)
    _id_BE66E5030B255FF1.target[[_id_BE66E5030B255FF1.callback]]();
  }
}