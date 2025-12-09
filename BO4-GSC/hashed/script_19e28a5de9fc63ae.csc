/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_19e28a5de9fc63ae.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace fail_screen;

class cfail_screen: cluielem {
  function open(localclientnum) {
    cluielem::open(localclientnum, # "fail_screen");
  }

  function function_cf9c4603(localclientnum) {
    cluielem::function_cf9c4603(localclientnum);
  }

  function register_clientside(uid) {
    cluielem::register_clientside(uid);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
  }

}

register(uid) {
  elem = new cfail_screen();
  [[elem]] - > setup_clientfields(uid);
  return elem;
}

register_clientside(uid) {
  elem = new cfail_screen();
  [[elem]] - > register_clientside(uid);
  return elem;
}

open(player) {
  [[self]] - > open(player);
}

close(player) {
  [[self]] - > close(player);
}

is_open(localclientnum) {
  return [[self]] - > is_open(localclientnum);
}