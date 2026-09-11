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

function cruisepredator_directionoverride(var0) {
  if(isDefined(self.drone_strike_dir_override)) {
    var0 = anglesToForward(self.drone_strike_dir_override.angles);
    var0 = vectorNormalize(var0);
    var0 *= (1, 1, 0);
  }

  return var0;
}

function cruisepredator_aicharacterchecks(var0) {
  if(isai(var0) || isPlayer(var0)) {
    return 1;
  }

  return 0;
}

function cruisepredator_createbackupheight() {
  var0 = spawn("script_origin", level.mapcenter + (0, 0, 2576));
  var0.angles = (0, 0, 0);
  var0.targetname = "drone_strike_height";
  level.vdronestrikeheight = var0;
}

function initbattleroyalec130airdropcratedata(var0) {
  var1 = [];
  var2 = [];
  var3 = level.characters;
  var4 = [];
  var5 = level.players;
  var6 = spawnStruct();

  if(isDefined(level.remote_tanks)) {
    foreach(var8 in level.remote_tanks) {
      if(isDefined(var8)) {
        var4 = scripts\engine\utility::array_add(var4, var8);
      }
    }
  }

  if(isDefined(level.mark_heli) && isDefined(level.heli)) {
    var4 = scripts\engine\utility::array_add(var4, level.heli);
  }

  if(isDefined(level.vo_paratroopers)) {
    foreach(var11 in level.vo_paratroopers) {
      var4 = scripts\engine\utility::array_add(var4, var11);
    }
  }

  foreach(var14 in var3) {
    if(level.teambased && var14.team == var0.team || var14 == var0) {
      var2 = var14;
      continue;
    }

    if(cruisepredator_aicharacterchecks(var14)) {
      var1 = var14;
    }
  }

  var16 = scripts\engine\utility::array_combine(var4, var1);

  foreach(var14 in var5) {
    if(level.teambased && var14.team != var0.team) {
      continue;
    }

    var2 = var14;
  }

  var6.enemytargetmarkergroup = var16;
  var6.friendlytargetmarkergroup = var2;
  return var6;
}

function cruisepredator_cpmarkenemies(var0) {
  var0.enemy_list = [];

  if(isDefined(level.spawned_enemies)) {
    for(var1 = 0; var1 < level.spawned_enemies.size; var1++) {
      level.spawned_enemies[var1] hudoutlineenableforclient(var0, "outlinefill_depth_red");
      var0.enemy_list[var0.enemy_list.size] = level.spawned_enemies[var1];
    }
  }

  if(isDefined(level.remote_tanks)) {
    foreach(var3 in level.remote_tanks) {
      if(isDefined(var3)) {
        var3 hudoutlineenableforclient(var0, "outlinefill_depth_red");
        var0.enemy_list[var0.enemy_list.size] = var3;
      }
    }
  }

  if(isDefined(level.mark_heli) && isDefined(level.heli)) {
    level.heli hudoutlineenableforclient(var0, "outlinefill_depth_red");
    var0.enemy_list[var0.enemy_list.size] = level.heli;
  }

  return var0.enemy_list;
}

function cruisepredator_cpunmarkenemies(var0) {
  if(isDefined(var0.enemy_list)) {
    foreach(var2 in var0.enemy_list) {
      if(isDefined(var2)) {
        var2 hudoutlinedisableforclient(var0);
      }
    }

    return;
  }
}

function cruisepredator_removeitemfromslot(var0) {
  var0 scripts\cp\crafting_system::remove_crafted_item_from_slot(scripts\cp\crafting_system::getitemslot("drone_strike"));
}