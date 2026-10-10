/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\unittest\callback.gsc
***********************************************/

#namespace callback;

function exec_callback(func, data) {
  if(isDefined(data)) {
    [[func]](data);
    return;
  }

  [[func]]();
}