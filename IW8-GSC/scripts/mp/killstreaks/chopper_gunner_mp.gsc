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

function chopper_gunner_set_vehicle_hit_damage_data(var0, var1) {
  scripts\mp\vehicles\damage::set_vehicle_hit_damage_data(var0, var1);
}

function chopper_gunner_findtargetStruct(var0, var1) {
  return scripts\cp_mp\killstreaks\chopper_support::choppersupport_findtargetStruct(var0, var1);
}

function givephteamscore() {
  var0 = [];
  var1 = [];
  var2 = level.players;

  foreach(var4 in var2) {
    if(level.teambased && var4.team == self.team || var4 == self.owner) {
      var1 = var4;
      continue;
    }

    if(var4 scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline")) {
      continue;
    }

    var0 = var4;
  }

  self.enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionenemydefault", self.owner, var0, self.owner, 0, 1, 1);
  self.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionfriendlydefault", self.owner, var1, self.owner, 1, 1);
}