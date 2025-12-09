/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_38fc161ed29156c7.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace success_screen;

class csuccess_screen: cluielem {
  function open(localclientnum) {
    cluielem::open(localclientnum, # "success_screen");
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
  elem = new csuccess_screen();
  [[elem]] - > setup_clientfields(uid);
  return elem;
}

register_clientside(uid) {
  elem = new csuccess_screen();
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