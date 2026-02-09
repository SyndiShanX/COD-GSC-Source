/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_debug.gsc
*****************************************************/

#include maps\mp\agents\_agent_utility;
#include common_scripts\utility;

ESCAPE_CYCLE_NUMBER = 20;

debugDvars() {
  level thread debugDvar_Internal("debug_nuke", ::debug_nuke);
  level thread debugDvar_Internal("debug_give_currency", ::debug_give_currency);
  level thread debugDvar_Internal("debug_give_point", ::debug_give_point);
  level thread debugDvar_Internal("debug_beat_current_encounter", ::debug_beat_current_encounter);
  level thread debugDvar_Internal("debug_aliens_unlock_all_intel", ::debug_aliens_unlock_all_intel);
  level thread debugDvar_Internal("debug_aliens_clear_all_intel", ::debug_aliens_clear_all_intel);
  level thread debugDvar_Internal("debug_aliens_last_increase_cortex_charge", ::debug_aliens_last_increase_cortex_charge);
  level thread devgui_giveskillpoints();
  level thread devgui_SetPrestigeNerf();
}

debugDvar_Internal(dvar, action_func) {
  level endon("host_migration_begin");
  setDvar(dvar, "off");

  while(true) {
    if(getDvar(dvar) != "off") {
      [[action_func]]();
      wait(0.05);
      setDvar(dvar, "off");
    }

    wait 0.2;
  }
}

debug_nuke() {
  if(isDefined(level.hostMigrationTimer)) {
    return;
  }
  aliens = getActiveAgentsOfType("alien");

  currency_reward = 0;
  foreach(alien in aliens) {
    amount = 60;
    alien_type = alien maps\mp\alien\_utility::get_alien_type();

    if(isDefined(alien_type)) {
      amount = level.alien_types[alien_type].attributes["reward"];
    }

    currency_reward += amount * level.cycle_reward_scalar;

    if(common_scripts\utility::flag_exist("cortex_started") && common_scripts\utility::flag("cortex_started")) {
      if(isDefined(level.add_cortex_charge_func)) {
        [[level.add_cortex_charge_func]](amount);
      }
    }

    alien suicide();
  }

  if(currency_reward > 0) {
    level.players[0] maps\mp\alien\_persistence::give_player_currency(currency_reward);
  }

  if(isDefined(level.dlc_get_non_agent_enemies)) {
    alive_non_agents = [[level.dlc_get_non_agent_enemies]]();
    foreach(alive_enemy in alive_non_agents) {
      alive_enemy notify("death");
    }
  }
}

debug_give_currency() {
  DEBUD_ADDITIONAL_CURRENCY = 1000;

  foreach(player in level.players) {
    player maps\mp\alien\_persistence::give_player_currency(DEBUD_ADDITIONAL_CURRENCY);
  }
}

debug_give_point() {
  DEBUD_ADDITIONAL_POINT = 1;

  foreach(player in level.players) {
    player maps\mp\alien\_persistence::give_player_points(DEBUD_ADDITIONAL_POINT);
  }
}

debug_beat_current_encounter() {
  if(!isDefined(level.current_encounter_info)) {
    iprintlnBold("No current encounter found");
    return;
  }

  if(!isDefined(level.current_encounter_info.force_end_func)) {
    iprintlnBold("The current encounter does not have a force end function");
    return;
  }

  [[level.current_encounter_info.force_end_func]]();
}

alienDebugVelocity() {
  self endon("death");
  self.average_velocity = [];
  self.max_vel = 0;
  while(1) {
    average_vel = get_average_velocity();
    if(average_vel > self.max_vel) {
      self.max_vel = average_vel;
    }

    text = "Vel: " + average_vel;
    print3d(self.origin + (0, 0, 64), text, (.9, .5, .3), 1.5, 1.0);
    text = "Max Vel: " + self.max_vel;
    print3d(self.origin + (0, 0, 32), text, (.9, .5, .3), 1.5, 1.0);
    wait 0.05;
  }
}

get_average_velocity() {
  cur_vel = Length(self GetVelocity());
  if(self.average_velocity.size < 10) {
    self.average_velocity[self.average_velocity.size] = cur_vel;
  } else {
    for(i = self.average_velocity.size - 1; i >= 0; i--) {
      self.average_velocity[i + 1] = self.average_velocity[i];
    }
    self.average_velocity[0] = cur_vel;
  }

  total_vel = 0;
  foreach(vel in self.average_velocity) {
    total_vel += vel;
  }

  return total_vel / self.average_velocity.size;
}

alienNavTest() {
  while(!isDefined(level.players) || level.players.size == 0) {
    wait 0.05;
  }
  level.players[0] thread alienNavTest_watchBullets();
  level.testalien = undefined;
  while(1) {
    dvar = GetDvarInt("scr_aliennavtest");
    while(dvar == 0) {
      wait 0.05;
      dvar = GetDvarInt("scr_aliennavtest");
    }

    while(!isAlive(level.testAlien)) {
      level.testAlien = maps\mp\gametypes\aliens::addAlienAgent("axis", level.players[0].origin, level.players[0].angles);
    }

    if(isAlive(level.testAlien)) {
      alien = level.testalien;
      alien maps\mp\alien\_utility::enable_alien_scripted();
      if(!isDefined(level.goalposition)) {
        while(!isDefined(level.goalposition)) {
          wait 0.05;
        }
      } else {
        alien ScrAgentSetGoalPos(level.goalposition);
        alien ScrAgentSetGoalRadius(64);
        alien common_scripts\utility::waittill_any("goal_reached", "death");
      }
    }
    wait 0.05;
  }
}

alienNavTest_watchBullets() {
  while(1) {
    self waittill("weapon_fired");
    level.goalposition = get_bullet_hit_location(self);
    self thread alienNavTest_showGoal(level.goalposition);
    if(isAlive(level.testAlien)) {
      level.testAlien ScrAgentSetGoalPos(level.goalposition);
    }
  }
}

alienNavTest_showGoal(pos) {
  self notify("stop_show_goal");
  self endon("stop_show_goal");
  while(1) {
    line(pos, pos + (0, 0, 64), (0, 1, 0), 1, 0, 2);
    wait 0.05;
  }
}

NUM_LOC_PER_START_POINT = 4;
runStartPoint() {
  if(!startPointEnabled()) {
    return;
  }
  startPoint_input = getDvar("alien_start_point");
  processStartPoint_input(startPoint_input);
  register_debug_loadout();

  level thread startPointWatchPlayerspawn();
}

register_debug_loadout() {
  level.debug_alien_loadout = [];

  for(i = 1; i <= NUM_LOC_PER_START_POINT; i++) {
    loadout_string = getDvar("debug_alien_loadout_" + i);
    level.debug_alien_loadout[level.debug_alien_loadout.size] = parse_loadout(loadout_string);
  }
}

parse_loadout(loadout_string) {
  weapon_array = [];

  token_array = StrTok(loadout_string, " ");

  foreach(token in token_array) {
    weapon_array[weapon_array.size] = token;
  }

  return weapon_array;
}

adjust_drill_loc(drop_loc) {
  if(isDefined(level.debug_drill_loc))
    return level.debug_drill_loc;
  else
    return drop_loc;
}

startPointEnabled() {
  if(getDvar("alien_start_point") == "")
    return false;

  return true;
}

startPointWatchPlayerspawn() {
  level endon("game_ended");

  StartPointCounter = 0;

  while(true) {
    level waittill("player_spawned", player);
    player thread moveToStartPoint(StartPointCounter);
    player thread giveDebugLoadout(StartPointCounter);
    StartPointCounter++;
  }
}

moveToStartPoint(counter) {
  locationIndex = counter % NUM_LOC_PER_START_POINT;
  startPointLoc = level.debug_startPointLocations[locationIndex];
  self setOrigin(startPointLoc);
}

giveDebugLoadout(index) {
  loadoutIndex = index % NUM_LOC_PER_START_POINT;
  loadoutArray = level.debug_alien_loadout[loadoutIndex];

  if(loadoutArray.size == 0) {
    return;
  }
  self TakeAllWeapons();

  foreach(index, weapon in loadoutArray) {
    self giveWeapon(weapon);
    self giveMaxAmmo(weapon);
  }

  self switchToWeapon(loadoutArray[0]);
}

debug_collectible(item) {
  string = maps\mp\alien\_collectibles::get_item_name(item.item_ref);
  string = "[LOOT] " + GetSubStr(string, 6);
  color = (1, 1, 0.25);
  alpha = 1;
  scale = 3;
  ent_endon_msg = "death";
  ent = item.item_ent;

  thread debug_print3d(string, color, alpha, scale, ent, ent_endon_msg);
}

debug_print3d(string, color, alpha, scale, ent, endon_msg) {
  ent endon(endon_msg);
  level endon("game_ended");

  while(1) {
    Print3d(ent.origin, string, color, alpha, scale, 1);
    wait(0.05);
  }
}

DPS_MS_TO_TRACK = 10000;

debugTrackDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset) {
  if(!GetDvarInt("scr_debugdps", 0)) {
    return;
  }

  if(isPlayer(eAttacker) && eAttacker GetCurrentPrimaryWeapon() == sWeapon) {
    iprintlnBold("Damage: " + iDamage);

    if(!isDefined(eAttacker.dps)) {
      eAttacker init_debug_dps();
    }

    new_dps_struct = spawnStruct();
    new_dps_struct.damage = iDamage;
    new_dps_struct.time = gettime();

    dps_array = [];
    foreach(dps_struct in eAttacker.dps_array) {
      if(dps_struct.time + DPS_MS_TO_TRACK < new_dps_struct.time) {
        continue;
      }
      dps_array[dps_array.size] = dps_struct;
    }
    dps_array[dps_array.size] = new_dps_struct;

    eAttacker.dps_array = dps_array;
  }
}

calc_dps() {
  total_damage = 0;
  current_time = gettime();
  foreach(dps_struct in self.dps_array) {
    if(dps_struct.time + DPS_MS_TO_TRACK < current_time) {
      continue;
    }
    total_damage += dps_struct.damage;
  }

  currently_tracked_ms = min(current_time - self.first_dps_time, DPS_MS_TO_TRACK);
  dps_seconds_to_track = currently_tracked_ms / 1000;

  if(dps_seconds_to_track > 0) {
    self.dps = total_damage / dps_seconds_to_track;
  } else {
    self.dps = 0;
  }
}

init_debug_dps() {
  self.dps_array = [];
  self.dps = 0;
  self.first_dps_time = gettime();

  create_dps_hud();
  self thread update_dps();
}

update_dps() {
  while(1) {
    if(!GetDvarInt("scr_debugdps", 0)) {
      return;
    }

    self calc_dps();
    self.dps_hud setValue(self.dps);
    self.dps_hud.alpha = 1;
    wait 0.2;
  }
}

create_dps_hud() {
  hud_counter = self maps\mp\gametypes\_hud_util::createFontString("objective", 1.25);
  hud_counter maps\mp\gametypes\_hud_util::setPoint("LEFT", "TOP", 180, 44);
  hud_counter.alpha = 0;
  hud_counter.color = (1, 1, 1);
  hud_counter.glowAlpha = 1;
  hud_counter.sort = 1;
  hud_counter.hideWhenInMenu = true;
  hud_counter.archived = true;

  self.dps_hud = hud_counter;
}

shouldSelfRevive() {
  if(maps\mp\alien\_utility::alien_mode_has("nogame"))
    return true;

  if(self_revive_activated())
    return true;

  return false;
}

self_revive_activated() {
  return (getdvarint("scr_alien_autorevive") > 0);
}

devgui_giveskillpoints() {
  while(1) {
    if(getDvar("scr_giveabilitypoint") == "") {
      wait .05;
      continue;
    }

    foreach(player in level.players) {
      player maps\mp\alien\_persistence::give_player_points(1);
    }

    SetDevDvar("scr_giveabilitypoint", "");

    wait(.05);
  }
}

debug_print_encounter_performance(player) {
  if(!debug_score_enabled()) {
    return;
  }
  println("===================== Encounter Performance ======================");
  println("========== Encounter performance for player " + player getEntityNumber() + " ==========");

  println("------ Team -------");
  foreach(key, score_component in level.encounter_score_components) {
    if(isDefined(score_component.team_encounter_performance)) {
      foreach(performance_item, value in score_component.team_encounter_performance)
      println(performance_item + ": " + value);
    }
  }

  println("---- Personal ----");
  foreach(key, value in player.encounter_performance)
  println(key + ": " + value);

  println("==============================================================================");
}

debug_print_drill_protection_score(damage_score_earned) {
  if(!debug_score_enabled()) {
    return;
  }
  println("========= Drill protection Score =========");
  println("damage_score_earned: " + damage_score_earned);
  println("==========================================");
}

debug_print_teamwork_score(deploy_supply_score_earned, revive_teammate_score_earned, damage_done_score_earned) {
  if(!debug_score_enabled()) {
    return;
  }
  println("============= Teamwork Skill =============");
  println("deploy_supply_score_earned: " + deploy_supply_score_earned);
  println("revive_teammate_score_earned: " + revive_teammate_score_earned);
  println("damage_done_score_earned: " + damage_done_score_earned);
  println("==========================================");
}

debug_print_personal_skill_score(damage_score_earned, accuracy_score_earned) {
  if(!debug_score_enabled()) {
    return;
  }
  println("============= Personal Skill =============");
  println("damage_score_earned: " + damage_score_earned);
  println("accuracy_score_earned: " + accuracy_score_earned);
  println("==========================================");
}

debug_score_enabled() {
  return (getDvar("alien_debug_score") == "1");
}

debug_print_achievement_unlocked(unlock_id, progress) {
  if(getDvarInt("debug_alien_achievement", 0) == 1) {
    if(isDefined(progress))
      println("(DEBUG) Achievement unlock: " + unlock_id + "(" + progress + ")");
    else
      println("(DEBUG) Achievement unlock: " + unlock_id);
  }
}

debug_print_item_unlocked(item_reference, item_type) {
  if(getDvarInt("debug_alien_item_unlock", 0) == 1)
    println("(DEBUG) Item unlock: " + item_reference + " for type: " + item_type);
}

debug_print_weapon_hits(weapon_ref, sMeansOfDeath) {
  if(getDvarInt("debug_alien_weapon_stats", 0) == 1)
    println("(DEBUG) Weapon hit: " + weapon_ref + " sMeansOfDeath: " + sMeansOfDeath);
}

debug_print_weapon_shots(weapon_ref) {
  if(getDvarInt("debug_alien_weapon_stats", 0) == 1)
    println("(DEBUG) Weapon fired: " + weapon_ref);
}

devgui_SetPrestigeNerf() {
  while(true) {
    if(getDvar("scr_setprestigenerf") == "") {
      waitframe();
      continue;
    }

    nerf_reference = getDvar("scr_setprestigenerf");

    foreach(player in level.players)
    player maps\mp\alien\_prestige::activate_nerf(nerf_reference);

    if(nerf_reference == "nerf_smaller_wallet")
      set_playerWalletToSmallerSize();

    if(nerf_reference == "nerf_higher_threatbias")
      set_playerToHigherThreatbias();

    SetDevDvar("scr_setprestigenerf", "");

    waitframe();
  }
}

set_playerWalletToSmallerSize() {
  foreach(player in level.players) {
    current_wallet_size = player.maxCurrency;
    smaller_wallet_size = current_wallet_size * player maps\mp\alien\_prestige::prestige_getWalletSizeScalar();
    player maps\mp\alien\_persistence::set_player_max_currency(smaller_wallet_size);
  }
}

set_playerToHigherThreatbias() {
  foreach(player in level.players)
  player.threatbias = player maps\mp\alien\_prestige::prestige_getThreatbiasScalar();
}

runAliens() {
  level endon("game_ended");

  wait(3);

  level.current_cycle_num = 1;
  level.current_cycle = 1;
  level.current_intensity_level = 0;

  while(true) {
    if(notEnoughDebugAliens()) {
      addAlienAgentWithOverride();
    }
    wait 0.5;
  }
}

notEnoughDebugAliens() {
  desired_count = GetDvarInt("mp_alien_count", 0);
  current_count = getNumActiveAgents("alien");

  if(desired_count > current_count) {
    return true;
  }

  return false;
}

addAlienAgentWithOverride() {
  alien_type_override = getDvar("alien_type_override");

  if(alien_type_override != "") {
    alien = maps\mp\gametypes\aliens::addAlienAgent("axis", undefined, undefined, alien_type_override);
  } else {
    alien = maps\mp\gametypes\aliens::addAlienAgent("axis");
  }

  return alien;
}

debug_LB_enabled() {
  return (getDvar("alien_debug_LB") == "1");
}

print_hive_XP_earned(xp_earned) {
  if(getDvarInt("debug_hive_xp", 0) == 1)
    println("(DEBUG) Hive XP earned: " + xp_earned);
}

processStartPoint_input(input_string) {
  token_array = StrTok(input_string, " ");

  if(isDefined(token_array[1]))
    level.debug_starting_currency = int(token_array[1]);

  if(isDefined(token_array[2]))
    level.debug_starting_skill_point = int(token_array[2]);
}

jumpTo_registerPlayerSpawnPos(player_spawn_pos_list) {
  level.debug_startPointLocations = [];

  foreach(pos in player_spawn_pos_list)
  level.debug_startPointLocations[level.debug_startPointLocations.size] = drop_to_ground(pos, 100, -250);
}

jumpTo_registerDrillSpawnPos(drill_spawn_pos) {
  drill_spawn_pos = drop_to_ground(drill_spawn_pos, 100, -250);
  level.debug_drill_loc = drill_spawn_pos;
}

wait_spawn_drill_and_remove_hives(hives_name_list) {
  CONST_WAIT_NONDETERMINISTIC_ENTITIES = 5.0;
  wait CONST_WAIT_NONDETERMINISTIC_ENTITIES;

  maps\mp\gametypes\aliens::handle_nondeterministic_entities_internal();
  level notify("spawn_intro_drill");
  remove_hives(hives_name_list);
}

remove_hives(hives_name_list) {
  hives_name_list = delete_already_removed_hives(hives_name_list);

  foreach(hive_name in hives_name_list) {
    location_ent = getent(hive_name, "target");
    level.stronghold_hive_locs = array_remove(level.stronghold_hive_locs, location_ent);
  }

  maps\mp\alien\_hive::remove_unused_hives(hives_name_list);
}

delete_already_removed_hives(hives_name_list) {
  new_list = [];
  foreach(hive_name in hives_name_list) {
    location_ent = getent(hive_name, "target");
    if(isDefined(location_ent))
      new_list[new_list.size] = hive_name;
  }
  return new_list;
}

getStartPointIndex() {
  start_point_input = getDvar("alien_start_point");
  token_array = StrTok(start_point_input, " ");
  return int(token_array[0]);
}

delete_intro_heli_collision() {
  helibrush = GetEnt("helicoptercoll", "targetname");
  helibrush delete();
}

common_hive_drill_jump_to(player_spawn_pos_list, drill_spawn_pos, hives_name_list) {
  jumpTo_registerPlayerSpawnPos(player_spawn_pos_list);
  jumpTo_registerDrillSpawnPos(drill_spawn_pos);
  wait_spawn_drill_and_remove_hives(hives_name_list);
}

common_hive_drillbot_jump_to(player_spawn_pos_list, drill_spawn_pos, drill_attach_node, hives_name_list) {
  jumpTo_registerPlayerSpawnPos(player_spawn_pos_list);
  wait_spawn_drill_and_remove_hives(hives_name_list);
  jumpTo_registerDrillbotSpawnPos(drill_spawn_pos, drill_attach_node);
}

jumpTo_registerDrillbotSpawnPos(drill_spawn_pos, drill_attach_node) {
  if(!isDefined(level.drill)) {
    iprintln("Error: level.drill undefined for jumpTo_registerDrillbotSpawnPos");
    return;
  }

  if(isDefined(drill_attach_node)) {
    node = GetVehicleNode(drill_attach_node, "targetname");
    level.drill notify("drillbot_jumpto_attach", node);
  }

  level.debug_drill_loc = drill_spawn_pos;
}

debug_aliens_unlock_all_intel() {
  level.players[0] SetCoopPlayerDataReservedInt("intel_episode_1_location_1", 1);
  level.players[0] SetCoopPlayerDataReservedInt("intel_episode_1_location_2", 1);
  level.players[0] SetCoopPlayerDataReservedInt("intel_episode_1_location_3", 1);
  level.players[0] SetCoopPlayerDataReservedInt("intel_episode_1_location_4", 1);
  level.players[0] SetCoopPlayerDataReservedInt("intel_episode_1_location_5", 1);
  level.players[0] SetCoopPlayerDataReservedInt("intel_episode_1_location_6", 1);
  level.players[0] SetCoopPlayerDataReservedInt("intel_episode_1_sequenced_count", 6);

  level.players[0] SetCoopPlayerDataReservedInt("intel_episode_2_location_1", 1);
  level.players[0] SetCoopPlayerDataReservedInt("intel_episode_2_location_2", 1);
  level.players[0] SetCoopPlayerDataReservedInt("intel_episode_2_location_3", 1);
  level.players[0] SetCoopPlayerDataReservedInt("intel_episode_2_location_4", 1);
  level.players[0] SetCoopPlayerDataReservedInt("intel_episode_2_location_5", 1);
  level.players[0] SetCoopPlayerDataReservedInt("intel_episode_2_location_6", 1);
  level.players[0] SetCoopPlayerDataReservedInt("intel_episode_2_sequenced_count", 4);

  level.players[0] SetCoopPlayerDataReservedInt("intel_episode_3_location_1", 1);
  level.players[0] SetCoopPlayerDataReservedInt("intel_episode_3_location_2", 1);
  level.players[0] SetCoopPlayerDataReservedInt("intel_episode_3_location_3", 1);
  level.players[0] SetCoopPlayerDataReservedInt("intel_episode_3_location_4", 1);
  level.players[0] SetCoopPlayerDataReservedInt("intel_episode_3_location_5", 1);
  level.players[0] SetCoopPlayerDataReservedInt("intel_episode_3_location_6", 1);
  level.players[0] SetCoopPlayerDataReservedInt("intel_episode_3_sequenced_count", 6);

  level.players[0] SetCoopPlayerDataReservedInt("intel_episode_4_location_1", 1);
  level.players[0] SetCoopPlayerDataReservedInt("intel_episode_4_location_2", 1);
  level.players[0] SetCoopPlayerDataReservedInt("intel_episode_4_location_3", 1);
  level.players[0] SetCoopPlayerDataReservedInt("intel_episode_4_location_4", 1);
  level.players[0] SetCoopPlayerDataReservedInt("intel_episode_4_location_5", 1);
  level.players[0] SetCoopPlayerDataReservedInt("intel_episode_4_location_6", 1);
  level.players[0] SetCoopPlayerDataReservedInt("intel_episode_4_sequenced_count", 6);
}

debug_aliens_clear_all_intel(player) {
  if(!isDefined(player)) {
    player = level.players[0];
  }

  player SetClientOmnvar("ui_alien_intel_num_collected", 0);

  player SetCoopPlayerDataReservedInt("intel_episode_1_location_1", 0);
  player SetCoopPlayerDataReservedInt("intel_episode_1_location_2", 0);
  player SetCoopPlayerDataReservedInt("intel_episode_1_location_3", 0);
  player SetCoopPlayerDataReservedInt("intel_episode_1_location_4", 0);
  player SetCoopPlayerDataReservedInt("intel_episode_1_location_5", 0);
  player SetCoopPlayerDataReservedInt("intel_episode_1_location_6", 0);
  player SetCoopPlayerDataReservedInt("intel_episode_1_sequenced_count", 0);

  player SetCoopPlayerDataReservedInt("intel_episode_2_location_1", 0);
  player SetCoopPlayerDataReservedInt("intel_episode_2_location_2", 0);
  player SetCoopPlayerDataReservedInt("intel_episode_2_location_3", 0);
  player SetCoopPlayerDataReservedInt("intel_episode_2_location_4", 0);
  player SetCoopPlayerDataReservedInt("intel_episode_2_location_5", 0);
  player SetCoopPlayerDataReservedInt("intel_episode_2_location_6", 0);
  player SetCoopPlayerDataReservedInt("intel_episode_2_sequenced_count", 0);

  player SetCoopPlayerDataReservedInt("intel_episode_3_location_1", 0);
  player SetCoopPlayerDataReservedInt("intel_episode_3_location_2", 0);
  player SetCoopPlayerDataReservedInt("intel_episode_3_location_3", 0);
  player SetCoopPlayerDataReservedInt("intel_episode_3_location_4", 0);
  player SetCoopPlayerDataReservedInt("intel_episode_3_location_5", 0);
  player SetCoopPlayerDataReservedInt("intel_episode_3_location_6", 0);
  player SetCoopPlayerDataReservedInt("intel_episode_3_sequenced_count", 0);

  player SetCoopPlayerDataReservedInt("intel_episode_4_location_1", 0);
  player SetCoopPlayerDataReservedInt("intel_episode_4_location_2", 0);
  player SetCoopPlayerDataReservedInt("intel_episode_4_location_3", 0);
  player SetCoopPlayerDataReservedInt("intel_episode_4_location_4", 0);
  player SetCoopPlayerDataReservedInt("intel_episode_4_location_5", 0);
  player SetCoopPlayerDataReservedInt("intel_episode_4_location_6", 0);
  player SetCoopPlayerDataReservedInt("intel_episode_4_sequenced_count", 0);
}

debug_aliens_last_increase_cortex_charge() {
  if(common_scripts\utility::flag_exist("cortex_started") && common_scripts\utility::flag("cortex_started")) {
    if(isDefined(level.add_cortex_charge_func)) {
      [[level.add_cortex_charge_func]](1000);
    }
  }
}

debug_aliens_clear_intel_saved_data(no_wait) {
  player = undefined;

  while(1) {
    level waittill("player_spawned", player);

    debug_aliens_clear_all_intel(player);
  }
}

get_bullet_hit_location(player) {
  eye_pos = player getEye();
  player_angles = player GetPlayerAngles();
  aim_dir = anglesToForward(player_angles);
  aim_dir *= 1000;
  trace = bulletTrace(eye_pos, eye_pos + aim_dir, false, player, false);

  return (trace["position"] + (0, 0, 6));
}

CONST_GOAL_POS_READY = "spawngoalposition is set";
CONST_RED_COLOR = (1, 0, 0);
CONST_RED_BLUE = (0, 0, 1);

spawn_test_enable() {
  return (getDvarInt("scr_alienspawntest", 0) == 1);
}

player_spawn_test_enable() {
  return (getDvarInt("scr_alienplayerspawntest", 0) == 1);
}

player_spawn_test() {
  level endon("game_ended");
  show_test = 2500 * 2500;
  level waittill("prematch_over");
  alien = undefined;
  while(true) {
    spawn_node = GetNodeClosestToPlayer();
    if(!isDefined(spawn_node)) {
      wait .05;
      continue;
    }

    alien_type = GetActualAlienSpawnType(spawn_node.script_noteworthy);

    intro_vignette_anim = get_intro_vignette_anim(spawn_node.script_noteworthy, alien_type);
    level.spawngoalposition = level.players[0].origin;
    level thread show_all_nearby_spawn_nodes(spawn_node, 5, show_test);
    level thread draw_debug_box_on(spawn_node, CONST_RED_COLOR, 5);
    if(isDefined(spawn_node.script_noteworthy))
      print3d(spawn_node.origin + (0, 0, 12), spawn_node.script_noteworthy, (0, 1, 0), 1, 1, 20);
    if(level.players[0] UseButtonPressed()) {
      alien = maps\mp\alien\_spawn_director::process_spawn(alien_type, spawn_node, intro_vignette_anim);
      while(level.players[0] UseButtonPressed())
        wait 0.05;
    }
    wait 0.05;
  }
}

GetActualAlienSpawnType(spawn_node) {
  if(!isDefined(spawn_node))
    return random(["goon", "spitter", "locust", "brute", "elite", "mammoth"]);

  switch (spawn_node) {
    case "chen_test":
    case "crawl_space":
    case "queen_dirt_11":
      return random(["goon", "spitter", "locust", "brute", "elite", "mammoth"]);

    case "intro_bomber_spawner_01":
    case "intro_bomber_spawner_02":
    case "intro_bomber_spawner_03":
    case "intro_bomber_spawner_04":
    case "triggered_bomber_01":
    case "triggered_bomber_02":
    case "triggered_bomber_03":
    case "triggered_bomber_04":
    case "bomber_spawner":
      return "bomber";
    case "gargoyle_spawner":
      return "gargoyle";

    case "pillage_event_02_spawner_01":
    case "pillage_event_03_spawner_01":
    case "pillage_event_04_spawner_01":
    case "pillage_spawner_01":
    case "rhino_cave_spawn":
      return "elite";
    case "pillage_spawner_02":
      return "spitter";
  }
  return "goon";
}

run_spawn_test() {
  level endon("game_ended");

  level waittill("prematch_over");

  level childthread weapon_fire_monitor(level.players[0]);
  level waittill(CONST_GOAL_POS_READY);

  level childthread drawLineAtSpawnTargetLoc();

  while(true) {
    spawn_node = GetNodeClosestToTarget();
    if(!isDefined(spawn_node)) {
      wait .1;
      continue;
    }
    alien_type = GetAlienSpawnType();
    intro_vignette_anim = get_intro_vignette_anim(spawn_node.script_noteworthy, alien_type);

    show_all_nearby_spawn_nodes(spawn_node, 60);
    draw_debug_box_on(spawn_node, CONST_RED_COLOR, 60);

    alien = maps\mp\alien\_spawn_director::process_spawn(alien_type, spawn_node, intro_vignette_anim);
    alien waittill("death");

    wait 0.5;
  }
}

get_intro_vignette_anim(spawn_node_id, alien_type) {
  if(isDefined(spawn_node_id)) {
    intro_vignette_alien_type = maps\mp\alien\_spawn_director::process_intro_vignette_ai_type(alien_type);
    return (level.cycle_data.spawn_node_info[spawn_node_id].vignetteInfo[intro_vignette_alien_type]);
  } else {
    return undefined;
  }
}

weapon_fire_monitor(player) {
  while(true) {
    player waittill("weapon_fired");
    level.spawngoalposition = get_bullet_hit_location(player);
    level notify(CONST_GOAL_POS_READY);
  }
}

drawLineAtSpawnTargetLoc() {
  while(true) {
    line(level.spawngoalposition, level.spawngoalposition + (0, 0, 64), (0, 1, 0), 1, false, 10);
    wait 0.5;
  }
}

GetAlienSpawnType() {
  spawn_type = getDvar("alien_type_override", "wave goon");
  spawn_type = StrTok(spawn_type, " ");
  return (spawn_type[1]);
}

GetNodeClosestToPlayer() {
  maxdist = 500000;

  node = undefined;

  for(nodeIndex = 0; nodeIndex < level.cycle_data.spawner_list.size; nodeIndex++) {
    newdist = DistanceSquared(level.players[0].origin, level.cycle_data.spawner_list[nodeIndex]["location"].origin);
    if(newdist >= maxdist)
      continue;
    maxdist = newdist;
    node = level.cycle_data.spawner_list[nodeIndex]["location"];
  }

  return node;
}

GetNodeClosestToTarget() {
  maxdist = 500000;

  node = undefined;

  for(nodeIndex = 0; nodeIndex < level.cycle_data.spawner_list.size; nodeIndex++) {
    newdist = DistanceSquared(level.spawngoalposition, level.cycle_data.spawner_list[nodeIndex]["location"].origin);
    if(newdist >= maxdist)
      continue;
    maxdist = newdist;
    node = level.cycle_data.spawner_list[nodeIndex]["location"];
  }

  return node;
}

show_all_nearby_spawn_nodes(selected_spawn_node, time, dist) {
  if(!isDefined(time))
    time = 60;

  DISTANCE_SQAD_SHOW_SPAWN_NODES = 1000000;
  if(isDefined(dist))
    DISTANCE_SQAD_SHOW_SPAWN_NODES = dist;

  for(nodeIndex = 0; nodeIndex < level.cycle_data.spawner_list.size; nodeIndex++) {
    if(DistanceSquared(level.spawngoalposition, level.cycle_data.spawner_list[nodeIndex]["location"].origin) < DISTANCE_SQAD_SHOW_SPAWN_NODES && level.cycle_data.spawner_list[nodeIndex]["location"] != selected_spawn_node)
      draw_debug_box_on(level.cycle_data.spawner_list[nodeIndex]["location"], CONST_RED_BLUE, time);
  }
}

draw_debug_box_on(spawn_node, color, time) {
  if(isDefined(spawn_node.angles))
    angles = spawn_node.angles;
  else
    angles = (0, 0, 0);

  yaw = vectorToYaw(angles);
  box(spawn_node.origin, yaw, color, false, time);
}
# /