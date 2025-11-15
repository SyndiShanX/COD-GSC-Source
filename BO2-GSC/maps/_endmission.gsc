/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_endmission.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_laststand;
#include maps\_endmission;
#include maps\_hud_message;
#include maps\_cooplogic;
#include maps\_cheat;

main() {
  thread restartmissionlistener();
}

restartmissionluilistener() {
  while(true) {
    level.player waittill("menuresponse", menu_action, action_arg);

    if(menu_action == "rts_action" && action_arg == "rts_restart_mission") {
      maps\_endmission::strikeforce_decrement_unit_tokens();
      luinotifyevent(&"rts_restart_mission");
      break;
    }
  }
}

restartmissionlistener() {
  while(true) {
    level waittill("restartmission");
    root_level = get_root_level(level.script);
    initchallengestats(level.script);

    if(root_level == level.script)
      fastrestart();
    else
      changelevel(root_level, 0, 0);
  }
}

get_root_level(cur_level) {
  root_level_index = tablelookup("sp/levelLookup.csv", 1, cur_level, 11);
  return tablelookup("sp/levelLookup.csv", 0, root_level_index, 1);
}

_nextmission() {
  level.nextmission = 1;
  level notify("nextmission");
  players = get_players();

  for(i = 0; i < players.size; i++) {
    players[i] notify("check_challenge");

    if(players[i] player_is_in_laststand()) {
      players[i] notify("player_revived");
      setclientsysstate("lsm", "0", players[i]);
    }

    players[i] enableinvulnerability();
  }

  cur_level = int(tablelookup("sp/levelLookup.csv", 1, level.script, 0));
  maps\_hud_message::waittillnotifiesdone();
  setdvar("skipto", "default");

  if(!isDefined(cur_level)) {
    maps\_cooplogic::endgame();
    return;
  }

  dostat = int(tablelookup("sp/levelLookup.csv", 0, cur_level, 16));
  complete_level(cur_level, dostat);
  set_next_level(cur_level, dostat);
  updategamerprofile();
}

complete_level(cur_level, dostat) {
  mission = tablelookup("sp/levelLookup.csv", 0, cur_level, 2);
  level_complete_achievement = tablelookup("sp/levelLookup.csv", 0, cur_level, 10);
  update_level_completed(mission);

  if(isDefined(level_complete_achievement) && level_complete_achievement != "") {
    players = get_players();
    players[0] giveachievement_wrapper(level_complete_achievement);
  }

  level_veteran_achievement = tablelookup("sp/levelLookup.csv", 0, cur_level, 12);

  if(isDefined(level_veteran_achievement) && level_veteran_achievement != "" && level.gameskill == 3 && check_other_haslevelveteranachievement(cur_level)) {
    players = get_players();
    players[0] giveachievement_wrapper(level_veteran_achievement);

    if(check_other_veterancompletion(cur_level))
      players[0] giveachievement_wrapper("SP_RTS_CARRIER");
  }

  level.posttutmission = getdvar(#"_id_D614D075");
  setdvar("ui_aarmapname", level.script);

  if(dostat != 0) {
    if(getdvarint(#"_id_0F241E06") == 0)
      setdvarint("ui_dofrontendsave", 1);

    if(!maps\_cheat::is_cheating() && !flag("has_cheated") && getdvar(#"_id_EB5692B2") != "1") {
      check_for_achievements(mission);
      dosplevelwrapup();
    }
  }
}

check_for_achievements(mission) {
  player = get_players()[0];
  cur_level_type = tablelookup("sp/levelLookup.csv", 2, mission, 8);

  if(!player isstartingclassdefault(mission) && cur_level_type != "RTS" && cur_level_type != "TUT")
    player giveachievement_wrapper("SP_MISC_WEAPONS");

  if(!player isstartingclasseraappropriate() && cur_level_type != "RTS" && cur_level_type != "TUT")
    player giveachievement_wrapper("SP_BACK_TO_FUTURE");
}

check_for_achievements_frontend(levelname) {
  player = get_players()[0];
  mission = tablelookup("sp/levelLookup.csv", 1, levelname, 2);
  cur_level_type = tablelookup("sp/levelLookup.csv", 2, mission, 8);

  if(cur_level_type == "TUT") {
    return;
  }
  if(player areallmissionsatscore(10000))
    player giveachievement_wrapper("SP_MISC_10K_SCORE_ALL");

  currchallenges = player getnumchallengescomplete(mission);

  if(currchallenges > 0)
    player giveachievement_wrapper("SP_ONE_CHALLENGE");

  if(currchallenges == 10) {
    player giveachievement_wrapper("SP_ALL_CHALLENGES_IN_LEVEL");

    if(player hascompletedallgamechallenges())
      player giveachievement_wrapper("SP_ALL_CHALLENGES_IN_GAME");
  }

  if(player hasallintel() && cur_level_type != "RTS")
    player giveachievement_wrapper("SP_MISC_ALL_INTEL");
}

get_strikeforce_tokens_remaining() {
  saved_num = level.player getdstat("PlayerCareerStats", "unitsAvailable");
  return saved_num;
}

strikeforce_decrement_unit_tokens() {
  saved_num = get_strikeforce_tokens_remaining();
  saved_num = saved_num - 1;
  level.player setdstat("PlayerCareerStats", "unitsAvailable", saved_num);
  return saved_num;
}

strikeforce_increment_unit_tokens() {
  saved_num = get_strikeforce_tokens_remaining();
  saved_num = saved_num + 1;
  level.player setdstat("PlayerCareerStats", "unitsAvailable", saved_num);
  return saved_num;
}

is_any_new_strikeforce_maps(cur_level) {
  m_rts_map_list = [];
  level_index = 1;
  max_index = int(tablelookup("sp/levelLookup.csv", 0, "map_count", 1));
  num_territories_claimed = 0;

  while(level_index < max_index) {
    if(tablelookup("sp/levelLookup.csv", 0, level_index, 8) == "RTS") {
      start_index = int(tablelookup("sp/levelLookup.csv", 0, level_index, 13));

      if(cur_level == start_index + 1) {
        if(!level.player get_story_stat(tablelookup("sp/levelLookup.csv", 0, level_index, 15)))
          m_rts_map_list[m_rts_map_list.size] = tablelookup("sp/levelLookup.csv", 0, level_index, 1);
      }

      territory = tablelookup("sp/levelLookup.csv", 0, level_index, 18);

      if(territory != "") {
        if(level.player get_story_stat(tablelookup("sp/levelLookup.csv", 0, level_index, 15)) != 0)
          num_territories_claimed++;
      }
    }

    level_index++;
  }

  karma_captured = level.player get_story_stat("KARMA_CAPTURED");

  if(karma_captured == 0)
    arrayremovevalue(m_rts_map_list, "so_rts_mp_socotra");

  if(num_territories_claimed < 3)
    arrayremovevalue(m_rts_map_list, "so_rts_mp_overflow");

  if(m_rts_map_list.size > 0)
    return true;

  return false;
}

get_strikeforce_available_level_list(cur_level) {
  level.m_rts_map_list = [];

  if(isDefined(level.m_strikeforce_override_list)) {
    level.m_rts_map_list = level.m_strikeforce_override_list;
    return level.m_strikeforce_override_list;
  }

  tokens_remaining = get_strikeforce_tokens_remaining();

  if(tokens_remaining <= 0)
    return level.m_rts_map_list;

  level_index = 1;
  max_index = int(tablelookup("sp/levelLookup.csv", 0, "map_count", 1));
  num_territories_claimed = 0;

  while(level_index < max_index) {
    if(tablelookup("sp/levelLookup.csv", 0, level_index, 8) == "RTS") {
      start_index = int(tablelookup("sp/levelLookup.csv", 0, level_index, 13));
      end_index = int(tablelookup("sp/levelLookup.csv", 0, level_index, 14));

      if(is_true(level.m_strikeforce_open_all)) {
        level.m_rts_map_list[level.m_rts_map_list.size] = tablelookup("sp/levelLookup.csv", 0, level_index, 1);
        level_index++;
        continue;
      }

      if(cur_level > start_index && cur_level < end_index) {
        if(!level.player get_story_stat(tablelookup("sp/levelLookup.csv", 0, level_index, 15)))
          level.m_rts_map_list[level.m_rts_map_list.size] = tablelookup("sp/levelLookup.csv", 0, level_index, 1);
      }

      territory = tablelookup("sp/levelLookup.csv", 0, level_index, 18);

      if(territory != "") {
        if(level.player get_story_stat(tablelookup("sp/levelLookup.csv", 0, level_index, 15)) != 0)
          num_territories_claimed++;
      }
    }

    level_index++;
  }

  if(is_true(level.m_strikeforce_open_all))
    return level.m_rts_map_list;

  karma_captured = level.player get_story_stat("KARMA_CAPTURED");

  if(karma_captured == 0)
    arrayremovevalue(level.m_rts_map_list, "so_rts_mp_socotra");

  if(num_territories_claimed < 3)
    arrayremovevalue(level.m_rts_map_list, "so_rts_mp_overflow");

  prev_map = tablelookup("sp/levelLookup.csv", 0, cur_level, 1);

  if(prev_map != "") {
    last_map_index = undefined;

    for(i = 0; i < level.m_rts_map_list.size; i++) {
      if(level.m_rts_map_list[i] == prev_map) {
        last_map_index = i;
        break;
      }
    }

    if(isDefined(last_map_index)) {
      level.m_rts_map_list[i] = level.m_rts_map_list[0];
      level.m_rts_map_list[0] = prev_map;
    }
  }

  return level.m_rts_map_list;
}

set_next_level(cur_level, dostat) {
  curr_map_type = tablelookup("sp/levelLookup.csv", 0, cur_level, 8);

  if(curr_map_type == "RTS")
    cur_level = level.player getdstat("PlayerStatsList", "HIGHESTLEVELCOMPLETED", "statValue");

  next_level = cur_level + 1;
  map_type = tablelookup("sp/levelLookup.csv", 0, next_level, 8);

  if(map_type != "CMP" && map_type != "DEV")
    next_level = cur_level;

  next_level_name = tablelookup("sp/levelLookup.csv", 0, next_level, 1);
  map_type = tablelookup("sp/levelLookup.csv", 0, next_level, 8);

  if(map_type == "CMP" && curr_map_type != "RTS" && curr_map_type != "TUT" && getdvarint(#"_id_0F241E06") == 0)
    strikeforce_increment_unit_tokens();

  rts_array = get_strikeforce_available_level_list(next_level);

  if(getdvarint(#"_id_0F241E06") != 0 && map_type != "DEV") {
    root_level = tablelookup("sp/levelLookup.csv", 0, cur_level, 11);
    next_level_name = tablelookup("sp/levelLookup.csv", 0, root_level, 1);
  }

  setuinextlevel(next_level_name);

  if(map_type == "TUT") {
    setdvar("ui_aarmapname", level.posttutmission);
    setuinextlevel(level.posttutmission);
    changelevel(level.posttutmission, 0);
  } else if(getdvarint(#"_id_0F241E06") == 0 && next_level == cur_level) {
    setuinextlevel("credits");
    changelevel("");
  } else if(map_type == "DEV")
    changelevel(next_level_name, !dostat);
  else
    changelevel("", !dostat);
}

get_level_completed(mission_name) {
  players = get_players();
  return players[0] getdstat("PlayerLevelStats", mission_name, "highestDifficulty");
}

update_level_completed(mission_name) {
  if(issubstr(mission_name, "tutorial")) {
    return;
  }
  if(get_level_completed(mission_name) > level.gameskill) {
    return;
  }
  players = get_players();
  players[0] setsessstat("PlayerSessionStats", "difficulty", level.gameskill);
}

check_other_haslevelveteranachievement(level_index) {
  count = int(tablelookup("sp/levelLookup.csv", 0, "map_count", 1));
  veteran_achievement = tablelookup("sp/levelLookup.csv", 0, level_index, 12);

  for(i = 0; i < count; i++) {
    if(i == level_index) {
      continue;
    }
    level_vet_achievement = tablelookup("sp/levelLookup.csv", 0, i, 12);

    if(!isDefined(level_vet_achievement)) {
      continue;
    }
    if(veteran_achievement == level_vet_achievement) {
      mission_name = tablelookup("sp/levelLookup.csv", 0, i, 2);

      if(!isDefined(mission_name) || mission_name == "") {
        continue;
      }
      if(get_level_completed(mission_name) < 3)
        return false;
    }
  }

  return true;
}

check_other_veterancompletion(level_index) {
  count = int(tablelookup("sp/levelLookup.csv", 0, "map_count", 1));

  for(i = 0; i < count; i++) {
    if(i == level_index) {
      continue;
    }
    level_vet_achievement = tablelookup("sp/levelLookup.csv", 0, i, 12);

    if(!isDefined(level_vet_achievement) || level_vet_achievement == "") {
      continue;
    }
    mission_name = tablelookup("sp/levelLookup.csv", 0, i, 2);

    if(!isDefined(mission_name) || mission_name == "") {
      continue;
    }
    if(get_level_completed(mission_name) < 3)
      return false;
  }

  return true;
}

force_all_complete() {
  println("tada!");

  count = int(tablelookup("sp/levelLookup.csv", 0, "map_count", 1));

  for(i = 0; i < count; i++) {
    mission_name = tablelookup("sp/levelLookup.csv", 0, i, 2);
    update_level_completed(mission_name);
  }
}

clearall() {
  players = get_players();
  players[0] setdstat("PlayerStatsList", "HIGHESTLEVELCOMPLETED", "statValue", 0);
}