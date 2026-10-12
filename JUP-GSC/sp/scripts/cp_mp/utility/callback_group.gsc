/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\callback_group.gsc
****************************************************/



#using scripts\engine\utility;
#namespace callback_group;

function callback_create() {
  group = spawnStruct();
  group.subscriptions = [];
  return group;
}

function callback_subscribe(callback, target) {
  assertex(isDefined(callback), "Called without a callback.");
  assertex(isDefined(target), "Called without a target.");

  foreach(sub in self.subscriptions) {
    if(sub.callback == callback) {
      if(isDefined(sub.target) && sub.target == target) {
        if(sub.target == target) {
          assertex("<dev string:x1c>" + target + "<dev string:x25>");
        }
      }
    }
  }

  sub = spawnStruct();
  sub.target = target;
  sub.callback = callback;
  self.subscriptions = array_removeundefined(self.subscriptions);
  self.subscriptions[self.subscriptions.size] = sub;
}

function callback_unsubscribe(callback, target) {
  assertex(isDefined(callback), "Called without a callback.");
  assertex(isDefined(target), "Called without a target.");
  foundsub = 0;

  foreach(sub in self.subscriptions) {
    if(sub.callback == callback) {
      if(sub.target == target) {
        self.subscriptions[index] = undefined;
        return;
      }
    }
  }

  assertmsg("Target \"" + target + "\" has not been subscribed.");
}

function callback_trigger(param1, param2, param3, param4) {
  foreach(sub in self.subscriptions) {
    if(!isDefined(sub.target)) {
      self.subscriptions[index] = undefined;
    }
  }

  subscriptions = self.subscriptions;

  if(isDefined(param4)) {
    foreach(sub in subscriptions) {
      sub.target[[sub.callback]](param1, param2, param3, param4);
    }

    return;
  }

  if(isDefined(param3)) {
    foreach(sub in subscriptions) {
      sub.target[[sub.callback]](param1, param2, param3);
    }

    return;
  }

  if(isDefined(param2)) {
    foreach(sub in subscriptions) {
      sub.target[[sub.callback]](param1, param2);
    }

    return;
  }

  if(isDefined(param1)) {
    foreach(sub in subscriptions) {
      sub.target[[sub.callback]](param1);
    }

    return;
  }

  foreach(sub in subscriptions) {
    sub.target[[sub.callback]]();
  }
}

function callback_test() {
  function_9c4673bb50e9f9af();
  function_63620b8d0b5c4b58();
  function_c1ab3afb487441e9();
  function_9523fb0936127d3b();
}

function function_9c4673bb50e9f9af() {
  teststruct = spawnStruct();
  teststruct.num = 0;
  cba = callback_create();
  cba callback_subscribe(&function_d343abc5b21ce372, teststruct);
  cba callback_trigger(1);
  assertex(teststruct.num == 1, "<dev string:x44>");
  cbb = callback_create();
  cbb callback_subscribe(&function_d343abc5b21ce372, teststruct);
  cbb callback_trigger(1);
  assertex(teststruct.num == 2, "<dev string:x6f>");
}

function function_63620b8d0b5c4b58() {
  teststruct = spawnStruct();
  teststruct.num = 0;
  cb = callback_create();
  cb callback_subscribe(&function_d343abc5b21ce372, teststruct);
  cb callback_trigger(2);
  assertex(teststruct.num == 2, "<dev string:x9a>");
}

function function_c1ab3afb487441e9() {
  teststruct = spawnStruct();
  teststruct.num = 0;
  cba = callback_create();
  cba callback_subscribe(&function_d343abc5b21ce372, teststruct);
  cba callback_unsubscribe(&function_d343abc5b21ce372, teststruct);
  cba callback_trigger(1);
  assertex(teststruct.num == 0, "<dev string:xbb>");
  var_cb2a366e3233b7e7 = spawnStruct();
  var_cb2a366e3233b7e7.num = 0;
  var_cb2a376e3233ba1a = spawnStruct();
  var_cb2a376e3233ba1a.num = 0;
  var_cb2a386e3233bc4d = spawnStruct();
  var_cb2a386e3233bc4d.num = 0;
  cbb = callback_create();
  cbb callback_subscribe(&function_d343abc5b21ce372, var_cb2a366e3233b7e7);
  cbb callback_subscribe(&function_d343abc5b21ce372, var_cb2a376e3233ba1a);
  cbb callback_unsubscribe(&function_d343abc5b21ce372, var_cb2a366e3233b7e7);
  cbb callback_subscribe(&function_d343abc5b21ce372, var_cb2a386e3233bc4d);
  cbb callback_trigger(1);
  assertex(var_cb2a366e3233b7e7.num == 0, "<dev string:xdc>");
  assertex(var_cb2a376e3233ba1a.num == 1, "<dev string:xdc>");
  assertex(var_cb2a386e3233bc4d.num == 1, "<dev string:x125>");
}

function function_9523fb0936127d3b() {
  testent = spawn("<dev string:x16e>", (0, 0, 0));
  level.var_1c31a95f0eba8516 = 0;
  cb = callback_create();
  cb callback_subscribe(&function_94a324eb8b53ec6d, testent);
  testent delete();
  cb callback_trigger(1);
  assertex(level.var_1c31a95f0eba8516 == 0, "<dev string:x17c>");
  level.var_1c31a95f0eba8516 = undefined;
}

function function_d343abc5b21ce372(increment) {
  self.num += increment;
}

function function_94a324eb8b53ec6d(increment) {
  level.var_1c31a95f0eba8516 += increment;
}

# /