/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_23789ec11f581cd0.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace multi_stage_friendly_lockon;

class cmulti_stage_friendly_lockon: cluielem {
  var var_57a3d576;

  function set_targetstate(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "targetState", value);
  }

  function set_entnum(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "entNum", value);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "multi_stage_friendly_lockon", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("entNum", 1, 10, "int");
    cluielem::add_clientfield("targetState", 1, 3, "int");
  }

}

register(uid) {
  elem = new cmulti_stage_friendly_lockon();
  [[elem]] - > setup_clientfields(uid);
  return elem;
}

open(player, persistent = 0) {
  [[self]] - > open(player, persistent);
}

close(player) {
  [[self]] - > close(player);
}

is_open(player) {
  return [[self]] - > function_76692f88(player);
}

set_entnum(player, value) {
  [[self]] - > set_entnum(player, value);
}

set_targetstate(player, value) {
  [[self]] - > set_targetstate(player, value);
}