/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_achievement.gsc
******************************************/

#include common_scripts\utility;

GOAL_KILL_WITH_TRAP = 50;
GOAL_ESCAPE_IN_TIME = 90000;
GOAL_ESCAPE_1ST_TIME = 1;
GOAL_ESCAPE_ALL_CHALLENGE = 1;
GOAL_ESCAPE_ALL_PLAYERS = 4;
GOAL_ESCAPE_WITH_NERF_ON = 1;
GOAL_SCAVENGE_ITEM = 40;

init_player_achievement() {
  self.achievement_list = [];

  if(isDefined(level.achievement_registration_func)) {
    [[level.achievement_registration_func]]();
  }

  if(maps\mp\alien\_utility::is_true(level.include_default_achievements)) {
    register_default_achievements();
  }
}

register_default_achievements() {
  register_achievement("KILL_WITH_TRAP", GOAL_KILL_WITH_TRAP, ::default_init, ::should_update_kill_with_trap, ::equal_to_goal);
  register_achievement("ESCAPE_ALL_PLAYERS", GOAL_ESCAPE_ALL_PLAYERS, ::default_init, ::default_should_update, ::at_least_goal);
  register_achievement("ESCAPE_IN_TIME", GOAL_ESCAPE_IN_TIME, ::default_init, ::default_should_update, ::at_least_goal);
  register_achievement("ESCAPE_1ST_TIME", GOAL_ESCAPE_1ST_TIME, ::default_init, ::default_should_update, ::at_least_goal);
  register_achievement("ESCAPE_ALL_CHALLENGE", GOAL_ESCAPE_ALL_CHALLENGE, ::default_init, ::should_update_all_challenge, ::at_least_goal);
  register_achievement("ESCAPE_WITH_NERF_ON", GOAL_ESCAPE_WITH_NERF_ON, ::default_init, ::default_should_update, ::at_least_goal);
  register_achievement("REACH_CITY", 1, ::default_init, ::default_should_update, ::at_least_goal);
  register_achievement("REACH_CABIN", 1, ::default_init, ::default_should_update, ::at_least_goal);
  register_achievement("SCAVENGE_ITEM", GOAL_SCAVENGE_ITEM, ::default_init, ::default_should_update, ::equal_to_goal);
}

register_achievement(reference, goal, init_func, should_update_func, is_goal_reached_func, complete_in_casual) {
  achievement = spawnStruct();
  achievement[[init_func]](goal, should_update_func, is_goal_reached_func, complete_in_casual);
  self.achievement_list[reference] = achievement;
}

default_init(goal, should_update_func, is_goal_reached_func, complete_in_casual) {
  self.progress = 0;
  self.goal = goal;
  self.should_update_func = should_update_func;
  self.is_goal_reached_func = is_goal_reached_func;
  self.achievement_completed = false;
  if(isDefined(complete_in_casual)) {
    self.complete_in_casual = complete_in_casual;
  }
}

default_should_update(unused_1, unused_2, unused_3, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9, unused_10) {
  return true;
}

update_progress(progress_amount) {
  self.progress += progress_amount;
}

at_least_goal() {
  return (self.progress >= self.goal);
}

equal_to_goal() {
  return (self.progress == self.goal);
}

is_completed() {
  return (self.achievement_completed);
}

can_complete_in_causal() {
  return (maps\mp\alien\_utility::is_true(self.complete_in_casual));
}

mark_completed() {
  self.achievement_completed = true;
}

is_valid_achievement(achievement) {
  return (isDefined(achievement));
}

update_achievement(reference, progress_amt, param_1, param_2, param_3, param_4, param_5, param_6, param_7, param_8, param_9, param_10) {
  achievement = self.achievement_list[reference];

  /#/ / < TODO J.C. > Move this back into release build
  if(maps\mp\alien\_utility::is_chaos_mode()) {
    return;
  }
  if(!is_valid_achievement(achievement)) {
    return;
  }
  if(achievement is_completed()) {
    return;
  }
  if(maps\mp\alien\_utility::is_casual_mode() && !achievement can_complete_in_causal()) {
    return;
  }
  if(achievement[[achievement.should_update_func]](param_1, param_2, param_3, param_4, param_5, param_6, param_7, param_8, param_9, param_10)) {
    achievement update_progress(progress_amt);

    if(achievement[[achievement.is_goal_reached_func]]()) {
      maps\mp\alien\_debug::debug_print_achievement_unlocked(reference, progress_amt);

      self giveAchievement(reference);

      achievement mark_completed();
    }
  }
}

update_alien_kill_achievements(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration) {
  if(isDefined(level.update_alien_kill_achievements_func)) {
    [[level.update_alien_kill_achievements_func]](eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration);
  }

  if(!isDefined(eAttacker) || !isPlayer(eAttacker)) {
    return;
  }
  eAttacker update_achievement("KILL_WITH_TRAP", 1, eInflictor);
}

should_update_kill_with_trap(eInflictor, unused_2, unused_3, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9, unused_10) {
  if(maps\mp\alien\_utility::is_trap(eInflictor)) {
    return true;
  }

  return false;
}

update_escape_achievements(players_escaped, escape_time_remains) {
  escape_player_count = players_escaped.size;

  foreach(player in players_escaped) {
    times_escaped = player maps\mp\alien\_persistence::get_player_escaped();
    num_nerf_selected = player maps\mp\alien\_prestige::get_num_nerf_selected();
    player update_personal_escape_achievements(escape_player_count, escape_time_remains, times_escaped, num_nerf_selected);
  }
}

update_personal_escape_achievements(escape_player_count, escape_time_remains, times_escaped, num_nerf_selected) {
  self update_achievement("ESCAPE_ALL_PLAYERS", escape_player_count);
  self update_achievement("ESCAPE_IN_TIME", escape_time_remains);
  self update_achievement("ESCAPE_1ST_TIME", times_escaped);
  self update_achievement("ESCAPE_ALL_CHALLENGE", 1);
  self update_achievement("ESCAPE_WITH_NERF_ON", num_nerf_selected);
}

should_update_all_challenge(unused_1, unused_2, unused_3, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9, unused_10) {
  return level.all_challenge_completed;
}

update_blocker_hive_achievements(hive_name) {
  switch (hive_name) {
    case "lodge_lung_3":
      update_achievement_all_players("REACH_CITY", 1);
      break;

    case "city_lung_5":
      update_achievement_all_players("REACH_CABIN", 1);
      break;

    default:
      break;
  }
}

update_achievement_all_players(reference, progress_amt) {
  foreach(player in level.players) {
    player update_achievement(reference, progress_amt);
  }

}

update_scavenge_achievement() {
  self update_achievement("SCAVENGE_ITEM", 1);
}

update_achievement_damage_weapon(sWeapon) {
  if(isDefined(level.update_achievement_damage_weapon_func)) {
    self[[level.update_achievement_damage_weapon_func]](sWeapon);
  }
}

eggAllFoundForPack(packNum) {
  self endon("disconnect");
  level endon("game_ended");

  println("calculating eggstra xp...");

  level waittill_any("regular_hive_destroyed", "obelisk_destroyed", "outpost_encounter_completed");

  legacyState = self GetCoopPlayerData("alienPlayerStats", "deaths");

  eggState = self GetCoopPlayerDataReservedInt("eggstra_state_flags");
  packEggState = (eggState >> (packnum * 4)) & 15;

  if(packEggstate == 15) {
    eggstra_award_flags = self GetCoopPlayerDataReservedInt("eggstra_award_flags");
    hasModifiedFlags = false;

    if(legacyState == 1015 && ((eggstra_award_flags &(1 << 0)) != 1)) {
      eggstra_award_flags |= (1 << 0);
      hasModifiedFlags = true;
    }

    if((eggstra_award_flags &(1 << packNum)) == 0) {
      eggstra_award_flags |= (1 << packNum);
      hasModifiedFlags = true;

      self SetClientOmnvar("ui_alien_eggstra_xp", true);
      self thread maps\mp\alien\_persistence::wait_and_give_player_xp(10000, 5.0);

    }

    if(hasModifiedFlags == true) {
      self SetCoopPlayerDataReservedInt("eggstra_award_flags", eggstra_award_flags);
    }

    self update_mp_eggs_achievement(packnum);
  }
}

update_mp_eggs_achievement(dlc_num) {
  switch (dlc_num) {
    case 0:
      self update_achievement("GOT_THEEGGSTRA_XP", 1);
      break;
    case 1:
      self update_achievement("GOT_THEEGGSTRA_XP_DLC2", 1);
      break;
    case 2:
      self update_achievement("GOT_THEEGGSTRA_XP_DLC3", 1);
      break;
    case 3:
      self update_achievement("GOT_THEEGGSTRA_XP_DLC4", 1);
      break;
    default:
      break;
  }
}

update_intel_achievement(dlc_num) {
  dlc_num = 0;
  map_name = getdvar("ui_mapname");
  if(map_name == "mp_alien_armory") {
    dlc_num = 1;
  }
  if(map_name == "mp_alien_beacon") {
    dlc_num = 2;
  }
  if(map_name == "mp_alien_dlc3") {
    dlc_num = 3;
  }
  if(map_name == "mp_alien_last") {
    dlc_num = 4;
  }
  switch (dlc_num) {
    case 1:
      self update_achievement("FOUND_ALL_INTELS", 1);
      break;
    case 2:
      self update_achievement("FOUND_ALL_INTELS_MAYDAY", 1);
      break;
    case 3:
      self update_achievement("AWAKENING_ALL_INTEL", 1);
      break;
    case 4:
      self update_achievement("LAST_ALL_INTEL", 1);
    default:
      break;
  }

}