/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\vehicle_compass.gsc
**********************************************/

#using scripts\common\utility;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_spawn;
#using scripts\common\vehicle_tracking;
#using scripts\engine\utility;
#namespace vehicle_compass;

function register_instance(vehicle) {
  leveldata = get_level_data();
  leveldata.instances[vehicle getentitynumber()] = vehicle;
  vehicle_show(vehicle);

  if(vehicle vehicle_tracking::function_d2bad728e2163c17() vehicle_spawn::has_flag(7)) {
    vehicle_hide(vehicle);
  }
}

function deregister_instance(vehicle) {
  leveldata = get_level_data();
  leveldata.instances[vehicle getentitynumber()] = undefined;
}

function instance_is_registered(vehicle) {
  leveldata = get_level_data();
  return leveldata.instances[vehicle getentitynumber()] == vehicle;
}

function function_484c1142d4f4e710(vehicle, player, var_e6c819f806ce2c86) {
  if(!player.hasspawned) {
    return;
  }

  if(!function_461bc9a9504d10ed(vehicle, var_e6c819f806ce2c86)) {
    return;
  }

  vehicle builtin[[level.sharedfuncs[#"vehicle"][#"vehicleshowonminimapforclient"]]](player, 1);
}

function function_f43158fa5698deb9(vehicle, players, var_e6c819f806ce2c86) {
  if(!function_461bc9a9504d10ed(vehicle, var_e6c819f806ce2c86)) {
    return;
  }

  foreach(player in players) {
    if(!player.hasspawned) {
      continue;
    }

    vehicle builtin[[level.sharedfuncs[#"vehicle"][#"vehicleshowonminimapforclient"]]](player, 1);
  }
}

function private function_461bc9a9504d10ed(vehicle, var_e6c819f806ce2c86) {
  leveldata = get_level_data();

  if(!leveldata.visibilityisscriptcontrolled) {
    return false;
  }

  if(!isDefined(vehicle)) {
    return false;
  }

  if(!instance_is_registered(vehicle)) {
    if(!var_e6c819f806ce2c86) {
      assertmsg("<dev string:x24>");
    }

    return false;
  }

  if(!isDefined(level.sharedfuncs[#"vehicle"][#"vehicleshowonminimapforclient"])) {
    return false;
  }

  return true;
}

function function_875431dd0d57f2fd(vehicle, var_e6c819f806ce2c86) {
  if(!function_461bc9a9504d10ed(vehicle)) {
    return;
  }

  var_cbaf02c53ccec36d = level.sharedfuncs[#"vehicle"][#"vehicleshowonminimapforclient"];

  foreach(player in level.players) {
    if(!player.hasspawned) {
      continue;
    }

    vehicle builtin[[var_cbaf02c53ccec36d]](player, 1);
  }
}

function function_3e3244741bc2a2ec(player, var_e6c819f806ce2c86) {
  if(!isDefined(player)) {
    return;
  }

  leveldata = get_level_data();

  if(!leveldata.visibilityisscriptcontrolled) {
    return;
  }

  if(!leveldata.instances.size) {
    return;
  }

  var_cbaf02c53ccec36d = level.sharedfuncs[#"vehicle"][#"vehicleshowonminimapforclient"];

  if(!isDefined(var_cbaf02c53ccec36d)) {
    return;
  }

  foreach(instance in leveldata.instances) {
    if(!isDefined(instance)) {
      continue;
    }

    instance builtin[[var_cbaf02c53ccec36d]](player, 1);
  }
}

function vehicle_show(vehicle) {
  leveldata = get_level_data();

  if(leveldata.visibilityisscriptcontrolled) {
    vehicle utility::callsharedfunc(#"vehicle", #"vehicleshowonminimap", 1);
  }

  if(isDefined(leveldata.instances[vehicle getentitynumber()])) {
    if(level.teambased) {
      function_e527b9d6ae381350(vehicle, vehicle_occupancy::function_88fc32afbd317644(vehicle));
    } else {
      function_df8b8a691bf004f8(vehicle, vehicle_occupancy::function_e3f715e42f7b96c4(vehicle));
    }

    function_875431dd0d57f2fd(vehicle, 1);
  }
}

function vehicle_hide(vehicle) {
  leveldata = get_level_data();
  leveldata.instances[vehicle getentitynumber()] = undefined;

  if(leveldata.visibilityisscriptcontrolled) {
    vehicle utility::callsharedfunc(#"vehicle", #"vehicleshowonminimap", 0);
  }
}

function function_e527b9d6ae381350(vehicle, team) {
  if(!isDefined(team) || team == "neutral" || team == "none") {
    team = utility::issp() ? "neutral" : "none";
  }

  vehicle setvehicleteam(team);
}

function function_df8b8a691bf004f8(vehicle, player) {
  vehicle setentityowner(undefined);
}

function init() {
  assert(isDefined(level.vehicle), "<dev string:x76>");
  assert(!isDefined(level.vehicle.compass), "<dev string:xaf>");
  leveldata = spawnStruct();
  level.vehicle.compass = leveldata;
  leveldata.instances = [];
  runleanthreadmode = 0;

  if(utility::issharedfuncdefined(#"game", #"runleanthreadmode")) {
    runleanthreadmode = [[utility::getsharedfunc(#"game", #"runleanthreadmode")]]();
  }

  leveldata.visibilityisscriptcontrolled = !runleanthreadmode || getdvarint(@ "hash_61d6ab22f59b15a6", 1) > 0;

  if(utility::issharedfuncdefined(#"vehicle_compass", #"init")) {
    [[utility::getsharedfunc(#"vehicle_compass", #"init")]]();
  }
}

function get_level_data() {
  assert(isDefined(level.vehicle.compass), "<dev string:xe6>");
  return level.vehicle.compass;
}

function function_863cca296c26ac67(vehicle, var_82e6ae7a41cd7ff8, var_e56f1d76e18cd597) {
  leveldata = get_level_data();
  isregistered = isDefined(leveldata.instances[vehicle getentitynumber()]) && leveldata.instances[vehicle getentitynumber()] == vehicle;

  if(!isregistered) {
    return;
  }

  if(level.teambased) {
    function_e527b9d6ae381350(vehicle, var_e56f1d76e18cd597);
  } else {
    function_df8b8a691bf004f8(vehicle, var_e56f1d76e18cd597);
  }

  function_875431dd0d57f2fd(vehicle);
}

function player_joined_team_callback(player) {
  if(!level.teambased) {
    return;
  }

  function_3e3244741bc2a2ec(player);
}

function player_spawned_callback(params) {
  function_3e3244741bc2a2ec(self);
}