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

function gunship_findboxcenter(var0, var1) {
  return scripts\mp\spawnlogic::findboxcenter(var0, var1);
}

function set_unloadtype_at_end_path(var0, var1) {
  var2 = scripts\cp_mp\killstreaks\toma_strike::ref_13bd6(var0, var1);
  return var2.point;
}

function gunship_assigntargetmarkers(var0) {
  var1 = [];
  var2 = [];

  foreach(var4 in level.players) {
    if(level.teambased && var4.team == self.team || var4 == self.owner) {
      var2 = var4;
      continue;
    }

    if(var4 scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline")) {
      continue;
    }

    var1 = var4;
  }

  self.enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionenemydefault", self.owner, var1, self.owner, 0, 1, 1);
  self.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionfriendlydefault", self.owner, var2, self.owner, 1, 1);
}