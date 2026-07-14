/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\unittest\callback.gsc
*****************************************/

#namespace callback;

function exec_callback(func, data) {
  if(isDefined(data)) {
    [[func]](data);
    return;
  }

  [[func]]();
}