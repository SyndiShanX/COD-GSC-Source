/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_1e43d05a138e08b9.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace wz_wingsuit_hud;

class cwz_wingsuit_hud: cluielem {
  function open(localclientnum) {
    cluielem::open(localclientnum, # "wz_wingsuit_hud");
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
  elem = new cwz_wingsuit_hud();
  [[elem]] - > setup_clientfields(uid);
  return elem;
}

register_clientside(uid) {
  elem = new cwz_wingsuit_hud();
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