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

function chopper_gunner_set_vehicle_hit_damage_data(var0, var1) {
  scripts\cp\vehicles\damage_cp::set_vehicle_hit_damage_data(var0, var1);
}

function chopper_gunner_findtargetStruct(var0, var1) {
  return scripts\cp_mp\killstreaks\chopper_support::choppersupport_findtargetStruct(var0, var1);
}

function givephteamscore() {
  var0 = [];
  var1 = [];
  var2 = [];
  var3 = scripts\cp\cp_agent_utils::getactiveenemyagents("allies");
  var4 = level.players;
  var5 = [];

  if(isDefined(level.vo_paratroopers)) {
    foreach(var7 in level.vo_paratroopers) {
      var5 = scripts\engine\utility::array_add(var5, var7);
    }
  }

  var2 = scripts\engine\utility::array_combine(var5, var3, var4);

  foreach(var10 in var2) {
    if(!isDefined(var10.team)) {
      continue;
    }

    if(level.teambased && var10.team == self.team) {
      continue;
    }

    if(var10 == self.owner) {
      continue;
    }

    if(var10 scripts\cp\utility::_hasperk("specialty_noscopeoutline")) {
      continue;
    }

    var0 = var10;
  }

  foreach(var13 in var4) {
    if(level.teambased && var13.team != self.team) {
      continue;
    }

    var1 = var13;
  }

  self.enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionenemydefault", self.owner, var0, self.owner, 0, 1, 1);
  self.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionfriendlydefault", self.owner, var1, self.owner, 1, 1);
  thread given_achievement(level, self.enemytargetmarkergroup);
}

function given_achievement(var0, var1) {
  level endon("game_ended ");
  level endon("removed_targetMarkerGroup_" + var0);

  for(;;) {
    level waittill("spawned_group_soldier", var2);
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(var2, var0, var1);
  }
}