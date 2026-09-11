/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\chopper_gunner_mp.gsc
********************************************************/

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("chopper_gunner", &scripts\cp_mp\killstreaks\chopper_gunner::tryusechoppergunnerfromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_gunner", "set_vehicle_hit_damage_data", &chopper_gunner_set_vehicle_hit_damage_data);
  scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_gunner", "findTargetStruct", &chopper_gunner_findtargetstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_gunner", "assignTargetMarkers", &givephteamscore);
}

function chopper_gunner_set_vehicle_hit_damage_data(var_0, var_1) {
  scripts\mp\vehicles\damage::set_vehicle_hit_damage_data(var_0, var_1);
}

function chopper_gunner_findtargetStruct(var_0, var_1) {
  return scripts\cp_mp\killstreaks\chopper_support::choppersupport_findtargetStruct(var_0, var_1);
}

function givephteamscore() {
  var_0 = [];
  var_1 = [];
  var_2 = level.players;

  foreach(var_4 in var_2) {
    if(level.teambased && var_4.team == self.team || var_4 == self.owner) {
      var_1 = var_4;
      continue;
    }

    if(var_4 scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline")) {
      continue;
    }

    var_0 = var_4;
  }

  self.enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionenemydefault", self.owner, var_0, self.owner, 0, 1, 1);
  self.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionfriendlydefault", self.owner, var_1, self.owner, 1, 1);
}