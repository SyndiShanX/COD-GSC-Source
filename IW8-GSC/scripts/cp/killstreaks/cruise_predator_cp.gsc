/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\cruise_predator_cp.gsc
*********************************************************/

function init() {
  cruisepredator_createbackupheight();
  scripts\cp_mp\utility\script_utility::registersharedfunc("cruise_predator", "directionOverride", &cruisepredator_directionoverride);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cruise_predator", "aICharacterChecks", &cruisepredator_aicharacterchecks);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cruise_predator", "CPMarkEnemies", &cruisepredator_cpmarkenemies);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cruise_predator", "CPUnMarkEnemies", &cruisepredator_cpunmarkenemies);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cruise_predator", "removeItemFromSlot", &cruisepredator_removeitemfromslot);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cruise_predator", "assignTargetMarkers", &initbattleroyalec130airdropcratedata);
}

function cruisepredator_directionoverride(var_0) {
  if(isDefined(self.drone_strike_dir_override)) {
    var_0 = anglesToForward(self.drone_strike_dir_override.angles);
    var_0 = vectorNormalize(var_0);
    var_0 *= (1, 1, 0);
  }

  return var_0;
}

function cruisepredator_aicharacterchecks(var_0) {
  if(isai(var_0) || isPlayer(var_0)) {
    return 1;
  }

  return 0;
}

function cruisepredator_createbackupheight() {
  var_0 = spawn("script_origin", level.mapcenter + (0, 0, 2576));
  var_0.angles = (0, 0, 0);
  var_0.targetname = "drone_strike_height";
  level.vdronestrikeheight = var_0;
}

function initbattleroyalec130airdropcratedata(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = level.characters;
  var_4 = [];
  var_5 = level.players;
  var_6 = spawnStruct();

  if(isDefined(level.remote_tanks)) {
    foreach(var_8 in level.remote_tanks) {
      if(isDefined(var_8)) {
        var_4 = scripts\engine\utility::array_add(var_4, var_8);
      }
    }
  }

  if(isDefined(level.mark_heli) && isDefined(level.heli)) {
    var_4 = scripts\engine\utility::array_add(var_4, level.heli);
  }

  if(isDefined(level.vo_paratroopers)) {
    foreach(var_11 in level.vo_paratroopers) {
      var_4 = scripts\engine\utility::array_add(var_4, var_11);
    }
  }

  foreach(var_14 in var_3) {
    if(level.teambased && var_14.team == var_0.team || var_14 == var_0) {
      var_2 = var_14;
      continue;
    }

    if(cruisepredator_aicharacterchecks(var_14)) {
      var_1 = var_14;
    }
  }

  var_16 = scripts\engine\utility::array_combine(var_4, var_1);

  foreach(var_14 in var_5) {
    if(level.teambased && var_14.team != var_0.team) {
      continue;
    }

    var_2 = var_14;
  }

  var_6.enemytargetmarkergroup = var_16;
  var_6.friendlytargetmarkergroup = var_2;
  return var_6;
}

function cruisepredator_cpmarkenemies(var_0) {
  var_0.enemy_list = [];

  if(isDefined(level.spawned_enemies)) {
    for(var_1 = 0; var_1 < level.spawned_enemies.size; var_1++) {
      level.spawned_enemies[var_1] hudoutlineenableforclient(var_0, "outlinefill_depth_red");
      var_0.enemy_list[var_0.enemy_list.size] = level.spawned_enemies[var_1];
    }
  }

  if(isDefined(level.remote_tanks)) {
    foreach(var_3 in level.remote_tanks) {
      if(isDefined(var_3)) {
        var_3 hudoutlineenableforclient(var_0, "outlinefill_depth_red");
        var_0.enemy_list[var_0.enemy_list.size] = var_3;
      }
    }
  }

  if(isDefined(level.mark_heli) && isDefined(level.heli)) {
    level.heli hudoutlineenableforclient(var_0, "outlinefill_depth_red");
    var_0.enemy_list[var_0.enemy_list.size] = level.heli;
  }

  return var_0.enemy_list;
}

function cruisepredator_cpunmarkenemies(var_0) {
  if(isDefined(var_0.enemy_list)) {
    foreach(var_2 in var_0.enemy_list) {
      if(isDefined(var_2)) {
        var_2 hudoutlinedisableforclient(var_0);
      }
    }

    return;
  }
}

function cruisepredator_removeitemfromslot(var_0) {
  var_0 scripts\cp\crafting_system::remove_crafted_item_from_slot(scripts\cp\crafting_system::getitemslot("drone_strike"));
}