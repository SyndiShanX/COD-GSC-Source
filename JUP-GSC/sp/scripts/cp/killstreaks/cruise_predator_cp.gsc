/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\killstreaks\cruise_predator_cp.gsc
************************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#using scripts\killstreaks\killstreak_shared;
#namespace cruise_predator_cp;

function init() {
  cruisepredator_createbackupheight();
  scripts\engine\utility::registersharedfunc("cruise_predator", "directionOverride", &cruisepredator_directionoverride);
  scripts\engine\utility::registersharedfunc("cruise_predator", "aICharacterChecks", &cruisepredator_aicharacterchecks);
  scripts\engine\utility::registersharedfunc("cruise_predator", "CPMarkEnemies", &cruisepredator_cpmarkenemies);
  scripts\engine\utility::registersharedfunc("cruise_predator", "CPUnMarkEnemies", &cruisepredator_cpunmarkenemies);
  scripts\engine\utility::registersharedfunc("cruise_predator", "removeItemFromSlot", &cruisepredator_removeitemfromslot);
  scripts\engine\utility::registersharedfunc("cruise_predator", "assignTargetMarkers", &cruisepredator_assigntargetmarkers);
}

function cruisepredator_directionoverride(forwardvector) {
  assertex(isPlayer(self), "self that's passed into the function isn't a player. Recheck Script");
  assertex(isDefined(forwardvector), "Param: forwardVector isn't defined. Recheck Script");

  if(isDefined(self.drone_strike_dir_override)) {
    assertex(isDefined(self.drone_strike_dir_override.angles), ".drone_strike_dir_override.angles should be defined. Recheck Script");
    forwardvector = anglesToForward(self.drone_strike_dir_override.angles);
    forwardvector = vectorNormalize(forwardvector);
    forwardvector *= (1, 1, 0);
  }

  return forwardvector;
}

function cruisepredator_aicharacterchecks(ai) {
  if(isai(ai) || isPlayer(ai)) {
    return 1;
  }

  return 0;
}

function cruisepredator_createbackupheight() {
  vdronestrikeheight = spawn("script_origin", level.mapcenter + (0, 0, 2576));
  vdronestrikeheight.angles = (0, 0, 0);
  vdronestrikeheight.targetname = "drone_strike_height";
  level.vdronestrikeheight = vdronestrikeheight;
}

function cruisepredator_assigntargetmarkers(user) {
  var_2cd52bbc2a67b7cf = [];
  var_ff93381949523976 = [];
  var_22ccb4186bd27179 = level.characters;
  var_eba1c5743194000d = [];
  all_players = level.players;
  groupsstruct = spawnStruct();

  if(isDefined(level.remote_tanks)) {
    foreach(tank in level.remote_tanks) {
      if(isDefined(tank)) {
        var_eba1c5743194000d = array_add(var_eba1c5743194000d, tank);
      }
    }
  }

  if(isDefined(level.mark_heli) && isDefined(level.heli)) {
    var_eba1c5743194000d = array_add(var_eba1c5743194000d, level.heli);
  }

  if(isDefined(level.killstreak_additional_targets)) {
    foreach(target in level.killstreak_additional_targets) {
      var_eba1c5743194000d = array_add(var_eba1c5743194000d, target);
    }
  }

  foreach(player in var_22ccb4186bd27179) {
    if(level.teambased && player.team == user.team || player == user) {
      var_ff93381949523976[var_ff93381949523976.size] = player;
      continue;
    }

    if(cruisepredator_aicharacterchecks(player)) {
      var_2cd52bbc2a67b7cf[var_2cd52bbc2a67b7cf.size] = player;
    }
  }

  var_4496855dec276732 = array_combine(var_eba1c5743194000d, var_2cd52bbc2a67b7cf);

  foreach(player in all_players) {
    if(level.teambased && player.team != user.team) {
      continue;
    }

    var_ff93381949523976[var_ff93381949523976.size] = player;
  }

  groupsstruct.enemytargetmarkergroup = var_4496855dec276732;
  groupsstruct.friendlytargetmarkergroup = var_ff93381949523976;
  return groupsstruct;
}

function cruisepredator_cpmarkenemies(player) {
  assertex(isPlayer(player), "player variable that's passed into the function isn't of player type. Recheck Script");
  player.enemy_list = [];

  if(isDefined(level.spawned_enemies)) {
    for(i = 0; i < level.spawned_enemies.size; i++) {
      level.spawned_enemies[i] hudoutlineenableforclient(player, "outlinefill_depth_red");
      player.enemy_list[player.enemy_list.size] = level.spawned_enemies[i];
    }
  }

  if(isDefined(level.remote_tanks)) {
    foreach(tank in level.remote_tanks) {
      if(isDefined(tank)) {
        tank hudoutlineenableforclient(player, "outlinefill_depth_red");
        player.enemy_list[player.enemy_list.size] = tank;
      }
    }
  }

  if(isDefined(level.mark_heli) && isDefined(level.heli)) {
    level.heli hudoutlineenableforclient(player, "outlinefill_depth_red");
    player.enemy_list[player.enemy_list.size] = level.heli;
  }

  return player.enemy_list;
}

function cruisepredator_cpunmarkenemies(player) {
  assertex(isPlayer(player), "player variable that's passed into the function isn't of player type. Recheck Script");

  if(isDefined(player.enemy_list)) {
    foreach(enemy in player.enemy_list) {
      if(isDefined(enemy)) {
        enemy hudoutlinedisableforclient(player);
      }
    }
  }
}

function cruisepredator_removeitemfromslot(rider) {
  assertex(isPlayer(rider), "rider variable that's passed into the function isn't of player type. Recheck Script");
}

function function_8a023375b0197bdc(missile) {
  self endon("death");
  missile endon("cruise_missile_force_eject");
  missile scripts\killstreaks\killstreak_shared::function_51afe751c1e36723("collision", "explode", "death", "disowned", "emp_defused", "trophy_blocked");
  flag_clear("player_demigod");
}