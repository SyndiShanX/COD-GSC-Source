/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\location.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#namespace location;

function private autoexec __init__system__() {
  system::register(#"location", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.var_1383915 = getEntArray(0, "location_zone", "targetname");
  level.var_b6d0f0ba = getmapfields().destinationlabellist;
  level.var_d6c4af7f = &function_5f3b1735;
  callback::on_localplayer_spawned(&on_player_spawned);
}

function function_ab7f70b9(str_zone) {
  if(!isDefined(str_zone) || !isDefined(level.var_b6d0f0ba)) {
    return undefined;
  }

  foreach(var_87ce7586 in level.var_b6d0f0ba) {
    if(var_87ce7586.zonename === hash(str_zone)) {
      return var_87ce7586.displayname;
    }
  }
}

function get_current_zone() {
  player = self;

  if(!isalive(player)) {
    return;
  }

  foreach(zone in level.var_1383915) {
    if(isalive(player) && player istouching(zone)) {
      return zone.script_location;
    }

    waitframe(1);
  }
}

function function_5f3b1735(point) {
  foreach(zone in level.var_1383915) {
    if(istouching(point, zone)) {
      return function_ab7f70b9(zone.script_location);
    }
  }

  return undefined;
}

function function_f6ad2be6(localclientnum) {
  self endon(#"death");
  uimodel = getuimodel(function_1df4c3b0(localclientnum, #"hud_items"), "locationText");

  while(true) {
    if(isDefined(self)) {
      str_location = get_current_zone();
      str_location = function_ab7f70b9(str_location);
      setuimodelvalue(uimodel, isDefined(str_location) ? str_location : # "");
    }

    waitframe(1);
  }
}

function on_player_spawned(localclientnum) {
  if(is_true(level.var_36a81b25)) {
    return;
  }

  if(!self function_21c0fa55()) {
    return;
  }

  if(!isDefined(level.var_1383915[0])) {
    return;
  }

  self thread function_f6ad2be6(localclientnum);
}