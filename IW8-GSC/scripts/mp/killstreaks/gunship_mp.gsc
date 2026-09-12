/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\gunship_mp.gsc
*************************************************/

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("gunship", &scripts\cp_mp\killstreaks\gunship::tryusegunshipfromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "findBoxCenter", &gunship_findboxcenter);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "getBombingPoint", &set_unloadtype_at_end_path);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "assignTargetMarkers", &gunship_assigntargetmarkers);
}

function gunship_findboxcenter(var_0, var_1) {
  return scripts\mp\spawnlogic::findboxcenter(var_0, var_1);
}

function set_unloadtype_at_end_path(var_0, var_1) {
  var_2 = scripts\cp_mp\killstreaks\toma_strike::ref_13BD6(var_0, var_1);
  return var_2.point;
}

function gunship_assigntargetmarkers(var_0) {
  var_1 = [];
  var_2 = [];

  foreach(var_4 in level.players) {
    if(level.teambased && var_4.team == self.team || var_4 == self.owner) {
      var_2 = var_4;
      continue;
    }

    if(var_4 scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline")) {
      continue;
    }

    var_1 = var_4;
  }

  self.enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionenemydefault", self.owner, var_1, self.owner, 0, 1, 1);
  self.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionfriendlydefault", self.owner, var_2, self.owner, 1, 1);
}