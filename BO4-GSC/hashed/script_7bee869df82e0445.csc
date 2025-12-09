/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_7bee869df82e0445.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace remote_missile_targets;

class cremote_missile_targets: cluielem {
  function set_extra_target_3(localclientnum, value) {
    set_data(localclientnum, "extra_target_3", value);
  }

  function set_extra_target_2(localclientnum, value) {
    set_data(localclientnum, "extra_target_2", value);
  }

  function set_extra_target_1(localclientnum, value) {
    set_data(localclientnum, "extra_target_1", value);
  }

  function set_player_target_active(localclientnum, value) {
    set_data(localclientnum, "player_target_active", value);
  }

  function open(localclientnum) {
    cluielem::open(localclientnum, # "remote_missile_targets");
  }

  function function_cf9c4603(localclientnum) {
    cluielem::function_cf9c4603(localclientnum);
    set_data(localclientnum, "player_target_active", 0);
    set_data(localclientnum, "extra_target_1", 0);
    set_data(localclientnum, "extra_target_2", 0);
    set_data(localclientnum, "extra_target_3", 0);
  }

  function register_clientside(uid) {
    cluielem::register_clientside(uid);
  }

  function setup_clientfields(uid, var_e06994a2, var_aecd9fd2, var_79bd7b45, var_9feff018) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("player_target_active", 1, 16, "int", var_e06994a2);
    cluielem::add_clientfield("extra_target_1", 1, 10, "int", var_aecd9fd2);
    cluielem::add_clientfield("extra_target_2", 1, 10, "int", var_79bd7b45);
    cluielem::add_clientfield("extra_target_3", 1, 10, "int", var_9feff018);
  }

}

register(uid, var_e06994a2, var_aecd9fd2, var_79bd7b45, var_9feff018) {
  elem = new cremote_missile_targets();
  [[elem]] - > setup_clientfields(uid, var_e06994a2, var_aecd9fd2, var_79bd7b45, var_9feff018);
  return elem;
}

register_clientside(uid) {
  elem = new cremote_missile_targets();
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

set_player_target_active(localclientnum, value) {
  [[self]] - > set_player_target_active(localclientnum, value);
}

set_extra_target_1(localclientnum, value) {
  [[self]] - > set_extra_target_1(localclientnum, value);
}

set_extra_target_2(localclientnum, value) {
  [[self]] - > set_extra_target_2(localclientnum, value);
}

set_extra_target_3(localclientnum, value) {
  [[self]] - > set_extra_target_3(localclientnum, value);
}