/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_6ae78a9592670fa2.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace multi_stage_target_lockon;

class cmulti_stage_target_lockon: cluielem {
  function set_targetstate(localclientnum, value) {
    set_data(localclientnum, "targetState", value);
  }

  function set_entnum(localclientnum, value) {
    set_data(localclientnum, "entNum", value);
  }

  function open(localclientnum) {
    cluielem::open(localclientnum, # "multi_stage_target_lockon");
  }

  function function_cf9c4603(localclientnum) {
    cluielem::function_cf9c4603(localclientnum);
    set_data(localclientnum, "entNum", 0);
    set_data(localclientnum, "targetState", 0);
  }

  function register_clientside(uid) {
    cluielem::register_clientside(uid);
  }

  function setup_clientfields(uid, var_f2b103c5, var_5668fa70) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("entNum", 1, 6, "int", var_f2b103c5);
    cluielem::add_clientfield("targetState", 1, 3, "int", var_5668fa70);
  }

}

register(uid, var_f2b103c5, var_5668fa70) {
  elem = new cmulti_stage_target_lockon();
  [[elem]] - > setup_clientfields(uid, var_f2b103c5, var_5668fa70);
  return elem;
}

register_clientside(uid) {
  elem = new cmulti_stage_target_lockon();
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

set_entnum(localclientnum, value) {
  [[self]] - > set_entnum(localclientnum, value);
}

set_targetstate(localclientnum, value) {
  [[self]] - > set_targetstate(localclientnum, value);
}