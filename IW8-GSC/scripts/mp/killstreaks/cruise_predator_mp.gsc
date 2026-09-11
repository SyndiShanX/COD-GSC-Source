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

function cruisepredator_eventrecord(var_0) {
  if(isDefined(var_0)) {
    scripts\mp\events::predatormissileimpact(var_0);
    return;
  }
}

function initbattleroyalec130airdropcratedata(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = level.players;
  var_4 = spawnStruct();

  foreach(var_6 in var_3) {
    if(level.teambased && var_6.team == var_0.team || var_6 == var_0) {
      var_2 = var_6;
      continue;
    }

    if(var_6 scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline")) {
      continue;
    }

    var_1 = var_6;
  }

  var_4.enemytargetmarkergroup = var_1;
  var_4.friendlytargetmarkergroup = var_2;
  return var_4;
}