/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_442f1042340e6bf1.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace zm_zod_wonderweapon_quest;

class czm_zod_wonderweapon_quest: cluielem {
  function set_decay(localclientnum, value) {
    set_data(localclientnum, "decay", value);
  }

  function set_purity(localclientnum, value) {
    set_data(localclientnum, "purity", value);
  }

  function set_plasma(localclientnum, value) {
    set_data(localclientnum, "plasma", value);
  }

  function set_radiance(localclientnum, value) {
    set_data(localclientnum, "radiance", value);
  }

  function open(localclientnum) {
    cluielem::open(localclientnum, # "zm_zod_wonderweapon_quest");
  }

  function function_cf9c4603(localclientnum) {
    cluielem::function_cf9c4603(localclientnum);
    set_data(localclientnum, "radiance", 0);
    set_data(localclientnum, "plasma", 0);
    set_data(localclientnum, "purity", 0);
    set_data(localclientnum, "decay", 0);
  }

  function register_clientside(uid) {
    cluielem::register_clientside(uid);
  }

  function setup_clientfields(uid, var_6e57dcc7, var_c783da62, var_87c1afe3, var_8517a7c0) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("radiance", 1, 1, "int", var_6e57dcc7);
    cluielem::add_clientfield("plasma", 1, 1, "int", var_c783da62);
    cluielem::add_clientfield("purity", 1, 1, "int", var_87c1afe3);
    cluielem::add_clientfield("decay", 1, 1, "int", var_8517a7c0);
  }

}

register(uid, var_6e57dcc7, var_c783da62, var_87c1afe3, var_8517a7c0) {
  elem = new czm_zod_wonderweapon_quest();
  [[elem]] - > setup_clientfields(uid, var_6e57dcc7, var_c783da62, var_87c1afe3, var_8517a7c0);
  return elem;
}

register_clientside(uid) {
  elem = new czm_zod_wonderweapon_quest();
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

set_radiance(localclientnum, value) {
  [[self]] - > set_radiance(localclientnum, value);
}

set_plasma(localclientnum, value) {
  [[self]] - > set_plasma(localclientnum, value);
}

set_purity(localclientnum, value) {
  [[self]] - > set_purity(localclientnum, value);
}

set_decay(localclientnum, value) {
  [[self]] - > set_decay(localclientnum, value);
}