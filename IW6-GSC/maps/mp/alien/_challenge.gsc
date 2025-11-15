/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_challenge.gsc
****************************************/

#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\_utility;
#include maps\mp\alien\_utility;
#include maps\mp\alien\_challenge_function;

init_challenge() {
  map_name = getdvar("ui_mapname");
  level.alien_challenge_table = "mp/alien/" + map_name + "_challenges.csv";

  if(maps\mp\alien\_utility::is_hardcore_mode()) {
    level.alien_challenge_table = "mp/alien/" + map_name + "_hardcore_challenges.csv";
    if(!TableExists(level.alien_challenge_table))
      level.alien_challenge_table = "mp/alien/" + map_name + "_challenges.csv";
  }

  init_challenge_type();
}

spawn_challenge() {
  if(!alien_mode_has("challenge")) {
    return;
  }
  level.current_challenge_index = undefined;
  level thread spawn_challenge_internal();
}

spawn_challenge_internal() {
  challenge = get_valid_challenge();
  if(!isDefined(challenge)) {
    println("***CHALLENGE_ERROR*** - no challenge found");
    return;
  }

  if(GetDvar("scr_setactivechallenge") != "") {
    challenge = GetDvar("scr_setactivechallenge");
    SetDvar("scr_setactivechallenge", "");
  }

  activate_new_challenge(challenge);
}

update_challenge(challenge_name, param_1, param_2, param_3, param_4, param_5, param_6, param_7, param_8, param_9) {
  if(!current_challenge_is(challenge_name) || !alien_mode_has("challenge")) {
    return;
  }
  if(level.pre_challenge_active) {
    return;
  }
  current_challenge = level.challenge_data[level.current_challenge];
  current_challenge[[current_challenge.updateFunc]](param_1, param_2, param_3, param_4, param_5, param_6, param_7, param_8, param_9);
}

end_current_challenge() {
  if(current_challenge_exist() && alien_mode_has("challenge"))
    deactivate_current_challenge();
}

remove_all_challenge_cases() {
  level notify("remove_all_challenge_case");
}

get_valid_challenge() {
  valid_challenges = [];

  foreach(challenge in level.challenge_data) {
    if(isDefined(challenge.already_issued))
      continue;
    if(level.players.size == 1 && !is_true(challenge.allowedinsolo)) {
      continue;
    }
    if(!isDefined(challenge.allowed_cycles)) {
      continue;
    }
    allowed_cycles = strTok(challenge.allowed_cycles, " ");

    foreach(cycle in allowed_cycles) {
      if(level.cycle_count - 1 == int(cycle)) {
        current_hive = maps\mp\alien\_spawn_director::get_current_encounter();
        if(!isDefined(current_hive)) {
          println("***CHALLENGE ERROR*** - no current hive found");
          continue;
        }

        if(should_skip_challenge(challenge)) {
          continue;
        }
        allowed_hives = StrTok(challenge.allowed_hives, " ");
        foreach(hive in allowed_hives) {
          if(hive == current_hive) {
            valid_challenges[valid_challenges.size] = challenge;
            break;
          }
        }

        break;
      }
    }
  }

  if(valid_challenges.size > 0) {
    valid_challenge = valid_challenges[randomint(valid_challenges.size)];
    valid_challenge.already_issued = true;

    return valid_challenge.ref;
  }

  return undefined;
}

should_skip_challenge(challenge) {
  is_weapon_challenge = (challenge.ref == "ar_only" ||
    challenge.ref == "smg_only" ||
    challenge.ref == "lmgs_only" ||
    challenge.ref == "shotguns_only" ||
    challenge.ref == "2_weapons_only" ||
    challenge.ref == "semi_autos_only" ||
    challenge.ref == "new_weapon" ||
    challenge.ref == "snipers_only");

  if(!is_weapon_challenge)
    return false;

  num_pistol_prestige_players = 0;
  foreach(player in level.players) {
    if(player maps\mp\alien\_prestige::prestige_getPistolsOnly() == 1)
      num_pistol_prestige_players++;
  }

  if(challenge.ref == "new_weapon" && num_pistol_prestige_players > 0)
    return true;

  if(num_pistol_prestige_players >= level.players.size - 1)
    return true;
  else
    return false;
}

deactivate_current_challenge() {
  if(!current_challenge_exist()) {
    return;
  }
  current_challenge = level.challenge_data[level.current_challenge];

  unset_current_challenge();
  if(current_challenge[[current_challenge.isSuccessFunc]]()) {
    display_challenge_message("challenge_success", false);
    current_challenge[[current_challenge.rewardFunc]]();
    maps\mp\alien\_gamescore::update_players_encounter_performance(maps\mp\alien\_gamescore::get_challenge_score_component_name(), "challenge_complete");
    maps\mp\alien\_persistence::update_LB_alienSession_challenge(true);
    maps\mp\alien\_alien_matchdata::update_challenges_status(current_challenge.ref, true);
    level.num_challenge_completed++;

    if(!is_casual_mode()) {
      if(level.num_challenge_completed == 10) {
        foreach(player in level.players)
        player maps\mp\alien\_persistence::give_player_tokens(2, true);
      }
    }
  } else {
    display_challenge_message("challenge_failed", false);
    current_challenge[[current_challenge.failFunc]]();
    level.all_challenge_completed = false;
    maps\mp\alien\_persistence::update_LB_alienSession_challenge(false);
    maps\mp\alien\_alien_matchdata::update_challenges_status(current_challenge.ref, false);
  }

  current_challenge[[current_challenge.deactivateFunc]]();
}

activate_new_challenge(challenge_name) {
  assert(isDefined(challenge_name) && isDefined(level.challenge_data[challenge_name]));

  new_challenge = level.challenge_data[challenge_name];

  if(new_challenge[[new_challenge.canActivateFunc]]()) {
    scalar = get_challenge_scalar(challenge_name);
    if(isDefined(scalar)) {
      level.challenge_data[challenge_name].goal = scalar;
      level.current_challenge_scalar = scalar;
    } else
      level.current_challenge_scalar = -1;

    display_challenge_message(challenge_name, true, scalar);
    set_current_challenge(challenge_name);

    level.pre_challenge_active = true;
    challenge_countdown();
    level.pre_challenge_active = false;

    foreach(player in level.players) {
      player setClientOmnvar("ui_intel_prechallenge", 0);
    }

    level.current_challenge_pre_challenge = 0;
    new_challenge[[new_challenge.activateFunc]]();
  } else {
    new_challenge[[new_challenge.failActivateFunc]]();
  }
}

challenge_countdown() {
  level endon("game_ended");

  new_challenge_time = int(gettime() + 5000);
  foreach(player in level.players) {
    player SetClientOmnvar("ui_intel_timer", new_challenge_time);
    player SetClientOmnvar("ui_intel_title", 1);
  }
  level.current_challenge_title = 1;
  wait(5);

  foreach(player in level.players) {
    player SetClientOmnvar("ui_intel_timer", -1);
    player SetClientOmnvar("ui_intel_title", -1);
  }
  level.current_challenge_title = -1;
  wait(.5);
}

can_pick_up_challenge(player) {
  if(!IsPlayer(player))
    return false;

  if(isAI(player))
    return false;

  if(!isAlive(player) || (isDefined(player.fauxDead) && player.fauxDead))
    return false;

  return true;
}

display_challenge_message(message, activate, scalar) {
  index = TableLookup(level.alien_challenge_table, 1, message, 0);

  foreach(player in level.players) {
    if(activate) {
      if(isDefined(scalar)) {
        player SetClientOmnvar("ui_intel_challenge_scalar", scalar);
      } else {
        player SetClientOmnvar("ui_intel_challenge_scalar", -1);
      }
      player setClientOmnvar("ui_intel_prechallenge", 1);
      player SetClientOmnvar("ui_intel_active_index", int(index));
      level.current_challenge_index = int(index);
      level.current_challenge_pre_challenge = 1;
      player PlayLocalSound("mp_intel_received");

    } else {
      player SetClientOmnvar("ui_intel_active_index", -1);
      player SetClientOmnvar("ui_intel_progress_current", -1);
      player setClientOmnvar("ui_intel_progress_max", -1);
      player setClientOmnvar("ui_intel_percent", -1);
      player SetClientOmnvar("ui_intel_target_player", -1);
      player setClientOmnvar("ui_intel_prechallenge", 0);
      player SetClientOmnvar("ui_intel_timer", -1);
      player SetClientOmnvar("ui_intel_challenge_scalar", -1);

      level.current_challenge_index = -1;
      level.current_challenge_progress_max = -1;
      level.current_challenge_progress_current = -1;
      level.current_challenge_percent = -1;
      level.current_challenge_target_player = -1;
      level.current_challenge_timer = -1;
      level.current_challenge_scalar = -1;
      level.current_challenge_pre_challenge = 0;
    }
  }
  if(activate) {
    return;
  }
  level thread show_challenge_outcome(message, index);
}

show_challenge_outcome(message, challenge_message_index) {
  level endon("game_ended");
  wait(1);
  foreach(player in level.players) {
    if(message == "challenge_failed") {
      player SetClientOmnvar("ui_intel_active_index", int(challenge_message_index));
      player PlayLocalSound("mp_intel_fail");
    } else {
      player SetClientOmnvar("ui_intel_active_index", int(challenge_message_index));
      player PlayLocalSound("mp_intel_success");
    }
  }
  wait(4);
  foreach(player in level.players) {
    player SetClientOmnvar("ui_intel_active_index", -1);
  }
}

current_challenge_exist() {
  return isDefined(level.current_challenge);
}
current_challenge_is(challenge_name) {
  return (current_challenge_exist() && level.current_challenge == challenge_name);
}
unset_current_challenge() {
  level.current_challenge = undefined;
}
set_current_challenge(challenge_name) {
  level.current_challenge = challenge_name;
}

handle_challenge_hotjoin() {
  self endon("disconnect");

  self setClientOmnvar("ui_intel_prechallenge", level.current_challenge_pre_challenge);

  if(current_challenge_exist()) {
    self SetClientOmnvar("ui_intel_active_index", int(level.current_challenge_index));
    self SetClientOmnvar("ui_intel_progress_current", int(level.current_challenge_progress_current));
    self setClientOmnvar("ui_intel_progress_max", int(level.current_challenge_progress_max));
    self setClientOmnvar("ui_intel_percent", int(level.current_challenge_percent));
    self SetClientOmnvar("ui_intel_target_player", int(level.current_challenge_target_player));
    self setclientOmnvar("ui_intel_title", int(level.current_challenge_title));
    if(level.current_challenge_timer > 0)
      self SetClientOmnvar("ui_intel_timer", int(gettime() + (level.current_challenge_timer * 1000)));

    self SetClientOmnvar("ui_intel_challenge_scalar", level.current_challenge_scalar);
  }

  if(level.current_challenge == "50_percent_accuracy" || level.current_challenge == "75_percent_accuracy") {
    challenge = level.challenge_data[level.current_challenge];
    self thread track_percent_accuracy_shots_fired_internal(challenge);
  } else if(level.current_challenge == "no_reloads") {
    self thread wait_for_reload();
  } else if(level.current_challenge == "no_abilities") {
    self thread wait_for_ability_use();
  }

  if(isDefined(level.current_drill_health)) {
    SetOmnvar("ui_alien_drill_health_text", int(level.current_drill_health));
  }
  if(isDefined(level.current_drill_time)) {
    SetOmnvar("ui_alien_drill_end_milliseconds", int(level.current_drill_time));
  }
}

get_num_challenge_completed() {
  if(!isDefined(level.num_challenge_completed))
    return 0;
  else
    return level.num_challenge_completed;
}