/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_achievement_dlc4.gsc
***********************************************/

register_achievements_dlc4() {
  maps\mp\alien\_achievement::register_achievement("LAST_COMPLETED", 1, maps\mp\alien\_achievement::default_init, ::did_player_escape, maps\mp\alien\_achievement::at_least_goal);
  maps\mp\alien\_achievement::register_achievement("LAST_RELIC_COMPLETED", 1, maps\mp\alien\_achievement::default_init, ::escaped_with_relic, maps\mp\alien\_achievement::at_least_goal);
  maps\mp\alien\_achievement::register_achievement("LAST_ALL_CHALLENGES_COMPLETED", 1, maps\mp\alien\_achievement::default_init, ::escaped_with_all_challenges, maps\mp\alien\_achievement::at_least_goal);
  maps\mp\alien\_achievement::register_achievement("LAST_ALL_INTEL", 7, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::at_least_goal, 1);
  maps\mp\alien\_achievement::register_achievement("LAST_COMPLETE_AN_OUTPOST", 1, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::at_least_goal);
  maps\mp\alien\_achievement::register_achievement("GOT_THEEGGSTRA_XP_DLC4", 1, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::at_least_goal, 1);
  maps\mp\alien\_achievement::register_achievement("TIMING_IS_EVERYTHING", 1, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::at_least_goal);
  maps\mp\alien\_achievement::register_achievement("YOU_WISH", 1, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::at_least_goal);
  maps\mp\alien\_achievement::register_achievement("ALWAYS_HARD", 1, maps\mp\alien\_achievement::default_init, ::hardcore_escaped_with_relic, maps\mp\alien\_achievement::at_least_goal);
  maps\mp\alien\_achievement::register_achievement("HAT_TRICK", 1, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::at_least_goal);
  thread init_one_shot_kills();
  thread maps\mp\alien\_pillage_intel::init_player_intel_total();
}

did_player_escape(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  return maps\mp\alien\_utility::is_true(var_0.dlc4_escaped);
}

escaped_with_relic(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  return did_player_escape(var_0) && var_0 maps\mp\alien\_prestige::get_num_nerf_selected() != 0;
}

escaped_with_all_challenges(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  return did_player_escape(var_0) && level.all_challenge_completed;
}

hardcore_escaped_with_relic(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  return escaped_with_relic(var_0) && maps\mp\alien\_utility::is_hardcore_mode();
}

update_timing_is_everything() {
  var_0 = common_scripts\utility::flag_exist("cortex_started") && common_scripts\utility::flag("cortex_started");

  if(var_0) {
    if(!isDefined(level.timing_is_everything_cnt)) {
      level.timing_is_everything_cnt = 0;
      level.timing_is_everything_start_time = gettime();
    }

    level.timing_is_everything_cnt++;

    if(level.timing_is_everything_cnt == 3) {
      var_1 = gettime() - level.timing_is_everything_start_time;

      if(var_1 < 10000)
        maps\mp\alien\_achievement::update_achievement_all_players("TIMING_IS_EVERYTHING", 1);
    }
  }
}

award_you_wish() {
  maps\mp\alien\_achievement::update_achievement("YOU_WISH", 1, self);
}

update_progression_achievements(var_0) {
  switch (var_0) {
    case "outpost_rooftops_done":
    case "outpost_garage_done":
    case "outpost_gas_station_done":
      maps\mp\alien\_achievement::update_achievement_all_players("LAST_COMPLETE_AN_OUTPOST", 1);
      break;
    case "last_completed":
      foreach(var_2 in level.players) {
        var_2 maps\mp\alien\_achievement::update_achievement("LAST_COMPLETED", 1, var_2);
        var_2 maps\mp\alien\_achievement::update_achievement("LAST_RELIC_COMPLETED", 1, var_2);
        var_2 maps\mp\alien\_achievement::update_achievement("LAST_ALL_CHALLENGES_COMPLETED", 1, var_2);
        var_2 maps\mp\alien\_achievement::update_achievement("ALWAYS_HARD", 1, var_2);
      }

      break;
    default:
      break;
  }
}

init_one_shot_kills() {
  level endon("game_ended");
  self endon("disconnect");

  while(!isDefined(self.pers))
    wait 1;

  self.pers["one_shot_kills_tracker"] = spawnStruct();
  self.pers["one_shot_kills_tracker"].time = 0;
  self.pers["one_shot_kills_tracker"].cnt = 0;
}

update_one_shot_kills() {
  if(isDefined(self.pers["one_shot_kills_tracker"].time)) {
    var_0 = gettime();

    if(var_0 == self.pers["one_shot_kills_tracker"].time) {
      self.pers["one_shot_kills_tracker"].cnt++;

      if(self.pers["one_shot_kills_tracker"].cnt >= 3)
        maps\mp\alien\_achievement::update_achievement("HAT_TRICK", 1, self);
    } else {
      self.pers["one_shot_kills_tracker"].time = var_0;
      self.pers["one_shot_kills_tracker"].cnt = 1;
    }
  }
}

update_alien_kill_achievements_dlc4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(maps\mp\alien\_utility::is_chaos_mode()) {
    return;
  }
  var_9 = isDefined(var_1) && isPlayer(var_1);

  if(var_9) {
    if(isDefined(var_4) && (var_4 == "iw6_aliendlc42_mp" || var_4 == "iw6_aliendlc41_mp"))
      var_1 update_one_shot_kills();
  }
}