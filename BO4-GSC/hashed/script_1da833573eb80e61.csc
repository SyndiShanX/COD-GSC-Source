/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_1da833573eb80e61.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace initial_black;

class cinitial_black: cluielem {
  function open(localclientnum) {
    cluielem::open(localclientnum, # "initial_black");
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
  elem = new cinitial_black();
  [[elem]] - > setup_clientfields(uid);
  return elem;
}

register_clientside(uid) {
  elem = new cinitial_black();
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