/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\cruise_predator_cp.gsc
*********************************************************/

init() {
  cruisepredator_createbackupheight();
  scripts\cp_mp\utility\script_utility::registersharedfunc("cruise_predator", "directionOverride", ::cruisepredator_directionoverride);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cruise_predator", "aICharacterChecks", ::cruisepredator_aicharacterchecks);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cruise_predator", "CPMarkEnemies", ::cruisepredator_cpmarkenemies);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cruise_predator", "CPUnMarkEnemies", ::cruisepredator_cpunmarkenemies);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cruise_predator", "removeItemFromSlot", ::cruisepredator_removeitemfromslot);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cruise_predator", "assignTargetMarkers", ::cruisepredator_assigntargetmarkers);
}

cruisepredator_directionoverride(_id_90B08876A946FDF5) {
  if(isDefined(self.drone_strike_dir_override)) {
    _id_90B08876A946FDF5 = anglesToForward(self.drone_strike_dir_override.angles);
    _id_90B08876A946FDF5 = vectorNormalize(_id_90B08876A946FDF5);
    _id_90B08876A946FDF5 = _id_90B08876A946FDF5 * (1, 1, 0);
  }

  return _id_90B08876A946FDF5;
}

cruisepredator_aicharacterchecks(ai) {
  if(isai(ai) || isPlayer(ai))
    return 1;
  else
    return 0;
}

cruisepredator_createbackupheight() {
  vdronestrikeheight = spawn("script_origin", level.mapcenter + (0, 0, 2576));
  vdronestrikeheight.angles = (0, 0, 0);
  vdronestrikeheight.targetname = "drone_strike_height";
  level.vdronestrikeheight = vdronestrikeheight;
}

cruisepredator_assigntargetmarkers(_id_EEE718E33217DC9E) {
  _id_2CD52BBC2A67B7CF = [];
  _id_FF93381949523976 = [];
  _id_22CCB4186BD27179 = level.characters;
  _id_EBA1C5743194000D = [];
  _id_45D25409ACB2D4F9 = level.players;
  _id_2395B77BDD5F9CA4 = spawnStruct();

  if(isDefined(level.remote_tanks)) {
    foreach(tank in level.remote_tanks) {
      if(isDefined(tank))
        _id_EBA1C5743194000D = scripts\engine\utility::array_add(_id_EBA1C5743194000D, tank);
    }
  }

  if(isDefined(level.mark_heli) && isDefined(level.heli))
    _id_EBA1C5743194000D = scripts\engine\utility::array_add(_id_EBA1C5743194000D, level.heli);

  if(isDefined(level.killstreak_additional_targets)) {
    foreach(target in level.killstreak_additional_targets)
    _id_EBA1C5743194000D = scripts\engine\utility::array_add(_id_EBA1C5743194000D, target);
  }

  foreach(player in _id_22CCB4186BD27179) {
    if(level.teambased && player.team == _id_EEE718E33217DC9E.team || player == _id_EEE718E33217DC9E) {
      _id_FF93381949523976[_id_FF93381949523976.size] = player;
      continue;
    }

    if(cruisepredator_aicharacterchecks(player))
      _id_2CD52BBC2A67B7CF[_id_2CD52BBC2A67B7CF.size] = player;
  }

  _id_4496855DEC276732 = scripts\engine\utility::array_combine(_id_EBA1C5743194000D, _id_2CD52BBC2A67B7CF);

  foreach(player in _id_45D25409ACB2D4F9) {
    if(level.teambased && player.team != _id_EEE718E33217DC9E.team) {
      continue;
    }
    _id_FF93381949523976[_id_FF93381949523976.size] = player;
  }

  _id_2395B77BDD5F9CA4.enemytargetmarkergroup = _id_4496855DEC276732;
  _id_2395B77BDD5F9CA4.friendlytargetmarkergroup = _id_FF93381949523976;
  return _id_2395B77BDD5F9CA4;
}

cruisepredator_cpmarkenemies(player) {
  player.enemy_list = [];

  if(isDefined(level.spawned_enemies)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.spawned_enemies.size; _id_AC0E594AC96AA3A8++) {
      level.spawned_enemies[_id_AC0E594AC96AA3A8] hudoutlineenableforclient(player, "outlinefill_depth_red");
      player.enemy_list[player.enemy_list.size] = level.spawned_enemies[_id_AC0E594AC96AA3A8];
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

cruisepredator_cpunmarkenemies(player) {
  if(isDefined(player.enemy_list)) {
    foreach(enemy in player.enemy_list) {
      if(isDefined(enemy))
        enemy hudoutlinedisableforclient(player);
    }
  }
}

cruisepredator_removeitemfromslot(rider) {}