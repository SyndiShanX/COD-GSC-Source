/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_golden_bunker.gsc
*****************************************************/

function init() {
  initgoldbunkers();
}

function initgoldbunkers() {
  level.goldbunkers = [];

  for(var_0 = 1; var_0 <= 7; var_0++) {
    var_1 = getentitylessscriptablearrayinradius("bunker" + var_0, "targetname");
    var_2 = [];
    var_3 = [];

    foreach(var_5 in var_1) {
      if(issubstr(var_5.script_noteworthy, "door")) {
        var_2 = var_5;
        continue;
      }

      var_3 = var_5;
    }

    level.goldbunkers[level.goldbunkers.size] = creategoldbunker(var_3, var_2);
  }

  scripts\engine\scriptable::ref_12f5b("bunker_keypad", &keypadused);
}

function creategoldbunker(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.keypads = var_0;
  var_2.bunkerdoors = var_1;
  return var_2;
}

function keypadused(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getdvarint("scr_golden_bunker_skip_card", 0) == 1;

  if(var_5 || var_3 scripts\mp\gametypes\br_public::should_damage_pavelow_boss("brloot_access_card_gold_island_bunker")) {
    var_6 = getgoldbunkerfromkeypad(var_0);
    thread openbunker(var_6);
    var_3 scripts\cp\vehicles\vehicle_compass_cp::ref_120a4("golden_vault_opened");

    if(!var_5) {
      var_3 scripts\mp\gametypes\br_pickups::ref_12bfc();
      return;
    }

    return;
  }
}

function getgoldbunkerfromkeypad(var_0) {
  foreach(var_2 in level.goldbunkers) {
    foreach(var_4 in var_2.keypads) {
      if(var_4.index == var_0.index) {
        return var_2;
      }
    }
  }
}

function openbunker(var_0) {
  level endon("game_ended");

  foreach(var_2 in var_0.keypads) {
    var_2 setscriptablepartstate("bunker_keypad", "used");
  }

  wait 2;

  foreach(var_5 in var_0.bunkerdoors) {
    var_5 setscriptablepartstate("lm_door_bunker", "open");
  }
}