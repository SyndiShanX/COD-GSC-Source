/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\cruise_predator_mp.gsc
*********************************************************/

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("cruise_predator", &scripts\cp_mp\killstreaks\cruise_predator::tryusecruisepredatorfromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cruise_predator", "registerVO", &cruisepredator_registervo);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cruise_predator", "eventRecord", &cruisepredator_eventrecord);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cruise_predator", "assignTargetMarkers", &initbattleroyalec130airdropcratedata);
}

function cruisepredator_registervo() {
  game["dialog"]["cruise_separation_1"] = "flavor_predator20";
  game["dialog"]["cruise_separation_2"] = "flavor_predator30";
  game["dialog"]["cruise_control_1"] = "flavor_predator40";
  game["dialog"]["cruise_control_2"] = "flavor_predator50";
  game["dialog"]["cruise_control_3"] = "flavor_predator60";
  game["dialog"]["cruise_kill"] = "cruise_predator_hit";
  game["dialog"]["cruise_miss"] = "cruise_predator_miss";
}

function cruisepredator_eventrecord(var0) {
  if(isDefined(var0)) {
    scripts\mp\events::predatormissileimpact(var0);
    return;
  }
}

function initbattleroyalec130airdropcratedata(var0) {
  var1 = [];
  var2 = [];
  var3 = level.players;
  var4 = spawnStruct();

  foreach(var6 in var3) {
    if(level.teambased && var6.team == var0.team || var6 == var0) {
      var2 = var6;
      continue;
    }

    if(var6 scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline")) {
      continue;
    }

    var1 = var6;
  }

  var4.enemytargetmarkergroup = var1;
  var4.friendlytargetmarkergroup = var2;
  return var4;
}