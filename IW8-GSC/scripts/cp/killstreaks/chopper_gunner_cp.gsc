/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\chopper_gunner_cp.gsc
********************************************************/

function init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_gunner", "set_vehicle_hit_damage_data", &chopper_gunner_set_vehicle_hit_damage_data);
  scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_gunner", "findTargetStruct", &chopper_gunner_findtargetstruct);

  if(!scripts\cp\utility::tryingtoleave()) {
    scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_gunner", "assignTargetMarkers", &givephteamscore);
    return;
  }
}

function chopper_gunner_set_vehicle_hit_damage_data(var_0, var_1) {
  scripts\cp\vehicles\damage_cp::set_vehicle_hit_damage_data(var_0, var_1);
}

function chopper_gunner_findtargetStruct(var_0, var_1) {
  return scripts\cp_mp\killstreaks\chopper_support::choppersupport_findtargetStruct(var_0, var_1);
}

function givephteamscore() {
  var_0 = [];
  var_1 = [];
  var_2 = [];
  var_3 = scripts\cp\cp_agent_utils::getactiveenemyagents("allies");
  var_4 = level.players;
  var_5 = [];

  if(isDefined(level.vo_paratroopers)) {
    foreach(var_7 in level.vo_paratroopers) {
      var_5 = scripts\engine\utility::array_add(var_5, var_7);
    }
  }

  var_2 = scripts\engine\utility::array_combine(var_5, var_3, var_4);

  foreach(var_10 in var_2) {
    if(!isDefined(var_10.team)) {
      continue;
    }

    if(level.teambased && var_10.team == self.team) {
      continue;
    }

    if(var_10 == self.owner) {
      continue;
    }

    if(var_10 scripts\cp\utility::_hasperk("specialty_noscopeoutline")) {
      continue;
    }

    var_0 = var_10;
  }

  foreach(var_13 in var_4) {
    if(level.teambased && var_13.team != self.team) {
      continue;
    }

    var_1 = var_13;
  }

  self.enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionenemydefault", self.owner, var_0, self.owner, 0, 1, 1);
  self.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionfriendlydefault", self.owner, var_1, self.owner, 1, 1);
  thread given_achievement(level, self.enemytargetmarkergroup);
}

function given_achievement(var_0, var_1) {
  level endon("game_ended ");
  level endon("removed_targetMarkerGroup_" + var_0);

  for(;;) {
    level waittill("spawned_group_soldier", var_2);
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(var_2, var_0, var_1);
  }
}