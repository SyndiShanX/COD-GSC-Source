/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_music_and_dialog.gsc
***********************************************/

function init() {
  scripts\engine\utility::flag_init("vo_system_setup_done");
  scripts\engine\utility::flag_init("dialogue_done");
  scripts\cp\cp_vo::initcpvosystem();
  thread onplayerconnect();
  thread scriptable_vo_handler();

  if(!isDefined(game["music"])) {
    game["music"]["cp_heli_infil"] = [];
    game["music"]["cp_heli_infil"][game["music"]["cp_heli_infil"].size] = "mus_infil_easterneurope_animated_1";
    game["music"]["cp_heli_infil"][game["music"]["cp_heli_infil"].size] = "mus_infil_easterneurope_static_1";
    game["music"]["cp_heli_infil"][game["music"]["cp_heli_infil"].size] = "mus_infil_england_animated_1";
    game["music"]["cp_heli_infil"][game["music"]["cp_heli_infil"].size] = "mus_infil_england_static_1";
    game["music"]["spawn_player"] = [];

    if(isDefined(level.music_style) && level.music_style == "eastern_europe") {
      game["music"]["spawn_player"][game["music"]["spawn_player"].size] = "mus_infil_easterneurope_east_static_1";
      game["music"]["spawn_player"][game["music"]["spawn_player"].size] = "mus_infil_easterneurope_east_static_2";
      game["music"]["spawn_player"][game["music"]["spawn_player"].size] = "mus_infil_easterneurope_east_static_3";
      game["music"]["spawn_player"][game["music"]["spawn_player"].size] = "mus_infil_easterneurope_east_static_4";
    } else if(isDefined(level.music_style) && level.music_style == "middle_east") {
      game["music"]["spawn_player"][game["music"]["spawn_player"].size] = "mus_infil_middleeast_east_static_1";
      game["music"]["spawn_player"][game["music"]["spawn_player"].size] = "mus_infil_middleeast_east_static_2";
      game["music"]["spawn_player"][game["music"]["spawn_player"].size] = "mus_infil_middleeast_east_static_3";
    } else {
      game["music"]["spawn_player"][game["music"]["spawn_player"].size] = "mus_infil_england_east_static_1";
      game["music"]["spawn_player"][game["music"]["spawn_player"].size] = "mus_infil_england_east_static_2";
      game["music"]["spawn_player"][game["music"]["spawn_player"].size] = "mus_infil_england_east_static_3";
      game["music"]["spawn_player"][game["music"]["spawn_player"].size] = "mus_infil_england_east_static_4";
    }

    game["music"]["cp_roundloss"] = [];
    game["music"]["cp_roundloss"][game["music"]["cp_roundloss"].size] = "cp_roundloss_sas";
    game["music"]["cp_roundloss"][game["music"]["cp_roundloss"].size] = "cp_roundloss_sas2";
    game["music"]["cp_roundloss"][game["music"]["cp_roundloss"].size] = "cp_roundloss_sas3";
    game["music"]["cp_roundloss"][game["music"]["cp_roundloss"].size] = "cp_roundloss_aq";
    game["music"]["cp_roundloss"][game["music"]["cp_roundloss"].size] = "cp_roundloss_aq2";
    game["music"]["cp_roundloss"][game["music"]["cp_roundloss"].size] = "cp_roundloss_aq3";
    game["music"]["cp_roundloss"][game["music"]["cp_roundloss"].size] = "cp_roundloss_aq4";
    game["music"]["cp_roundloss"][game["music"]["cp_roundloss"].size] = "cp_roundloss_aq5";
    game["music"]["cp_roundloss"][game["music"]["cp_roundloss"].size] = "cp_roundloss_aq6";
  }

  game["dialogue"]["axis_male_cough"] = [];
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_1";
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_2";
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_3";
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_4";
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_5";
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_6";
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_7";
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_8";
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_1";
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_2";
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_3";
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_4";
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_5";
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_6";
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_7";
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_8";
  game["dialogue"]["axis_female_cough"] = [];
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_1";
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_2";
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_3";
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_4";
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_5";
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_6";
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_7";
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_8";
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_1";
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_2";
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_3";
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_4";
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_5";
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_6";
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_7";
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_8";
  game["dialogue"]["allies_male_cough"] = [];
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_1";
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_2";
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_3";
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_4";
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_5";
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_6";
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_7";
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_8";
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_1";
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_2";
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_3";
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_4";
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_5";
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_6";
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_7";
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_8";
  game["dialogue"]["allies_female_cough"] = [];
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_1";
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_2";
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_3";
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_4";
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_5";
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_6";
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_7";
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_8";
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_1";
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_2";
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_3";
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_4";
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_5";
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_6";
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_7";
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_8";

  if(!isDefined(level.vo_functions)) {
    level.vo_functions = [];
  }

  if(isDefined(level.level_specific_vo_callouts)) {
    level.vo_functions = [[level.level_specific_vo_callouts]](level.vo_functions);
    return;
  }
}

function blank() {}

function can_play_dialogue_system() {
  if(level.players.size != 4) {
    return false;
  }

  if(scripts\cp\cp_vo::is_vo_system_busy()) {
    return false;
  }

  return true;
}

function vo_is_playing() {
  if(istrue(level.announcer_vo_playing)) {
    return true;
  } else if(istrue(level.player_vo_playing)) {
    return true;
  } else {
    foreach(var_1 in level.players) {
      if(istrue(var_1.vo_system_playing_vo)) {
        return true;
      }
    }
  }

  return false;
}

function getlengthofconversation(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = level.vo_dialogue_prefix[var_0[var_2]];
    var_1 += scripts\cp\cp_vo::get_sound_length(var_3 + var_0[var_2]);
  }

  return var_1;
}

function getarrayofdialoguealiases(var_0, var_1) {
  var_2 = [var_0];
  var_3 = var_0;

  for(;;) {
    if(var_1 && isDefined(level.vo_alias_data[var_3].nextdialogue)) {
      var_2 = level.vo_alias_data[var_3].nextdialogue;
      var_3 = level.vo_alias_data[var_3].nextdialogue;
      continue;
    }

    break;
  }

  return var_2;
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    thread onplayerspawned();
  }
}

function onplayerspawned() {
  self endon("disconnect");
  self waittill("spawned_player");

  if(!level.splitscreen || level.splitscreen && !isDefined(level.playedstartingmusic)) {
    if(level.splitscreen) {
      level.playedstartingmusic = 1;
    }

    var_0 = game["music"]["spawn_player"].size;
    var_1 = randomint(var_0);
    self setplayermusicstate(game["music"]["spawn_player"][var_1]);
  }

  if(!scripts\engine\utility::flag("vo_system_setup_done")) {
    scripts\engine\utility::flag_set("vo_system_setup_done");
    return;
  }
}

function playvofordowned(var_0, var_1) {
  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    return;
  }

  var_2 = var_0.vo_prefix + "laststand";
  var_0 thread scripts\cp\cp_vo::play_vo_on_player(var_2);
}

function playvoforrevived(var_0, var_1) {
  var_2 = var_0.vo_prefix + "reviving";
  var_0 thread scripts\cp\cp_vo::play_vo_on_player(var_2);
}

function playvoforscriptable(var_0) {
  var_1 = 45000;
  var_2 = gettime();

  if(!isDefined(level.next_scriptable_vo_time) || level.next_scriptable_vo_time < var_2) {
    if(isDefined(level.next_scriptable_vo_time)) {
      if(randomint(100) < 60) {
        return;
      }
    }

    level.next_scriptable_vo_time = var_2 + randomintrange(var_1, var_1 + 5000);
    var_3 = scripts\cp\utility::get_array_of_valid_players();
    var_4 = scripts\engine\utility::random(var_3);

    if(!isDefined(var_4)) {
      return;
    }

    switch (var_0) {
      case "scriptable_alien_lynx_jump":
      case "scriptable_alien_tatra_t815_jump":
        var_5 = var_4.vo_prefix + "alien_approach_truck";
        var_4 scripts\cp\cp_vo::play_vo_on_player(var_5);
        break;
    }

    return;
  }
}

function scriptable_vo_handler() {
  level endon("game_ended");
  level.scriptable_vo_played = [];

  for(;;) {
    level waittill("scriptable", var_0);
    thread playvoforscriptable(level);
  }
}

function play_solo_vo(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_0 + "_solo";

  if(soundexists(var_6)) {
    scripts\cp\cp_vo::play_vo_on_player(var_6);
    return;
  }
}

function playsoundonplayers(var_0, var_1, var_2) {
  if(level.splitscreen) {
    if(isDefined(level.players[0])) {
      level.players[0] playlocalsound(var_0);
      return;
    }

    return;
  }

  if(isDefined(var_1)) {
    if(isDefined(var_2)) {
      for(var_3 = 0; var_3 < level.players.size; var_3++) {
        var_4 = level.players[var_3];

        if(var_4 issplitscreenplayer() && !var_4 issplitscreenplayerprimary()) {
          continue;
        }

        if(isDefined(var_4.pers["team"]) && var_4.pers["team"] == var_1 && !isexcluded(var_4, var_2)) {
          var_4 playlocalsound(var_0);
        }
      }

      return;
    }

    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      var_4 = level.players[var_3];

      if(var_4 issplitscreenplayer() && !var_4 issplitscreenplayerprimary()) {
        continue;
      }

      if(isDefined(var_4.pers["team"]) && var_4.pers["team"] == var_3) {
        var_4 playlocalsound(var_2);
      }
    }

    return;
  }

  if(isDefined(var_3)) {
    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      if(level.players[var_3] issplitscreenplayer() && !level.players[var_3] issplitscreenplayerprimary()) {
        continue;
      }

      if(!isexcluded(level.players[var_3], var_3)) {
        level.players[var_3] playlocalsound(var_3);
      }
    }

    return;
  }

  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    if(level.players[var_3] issplitscreenplayer() && !level.players[var_3] issplitscreenplayerprimary()) {
      continue;
    }

    level.players[var_3] playlocalsound(var_4);
  }
}

function isexcluded(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_0 == var_1[var_2]) {
      return true;
    }
  }

  return false;
}

function playeventvo(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\cp\utility::get_array_of_valid_players();

  if(var_7.size < 1) {
    return;
  }

  var_8 = scripts\engine\utility::random(var_7);
  var_9 = var_8.vo_prefix + var_0;
  var_8 scripts\cp\cp_vo::play_vo_on_player(var_9);
}

function play_vo_for_trap_kills(var_0, var_1) {
  var_2 = var_0.vo_prefix + var_1;
  var_0 thread scripts\cp\cp_vo::play_vo_on_player(var_2, undefined, 2);
}

function playvoforlaststand(var_0, var_1) {
  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    return;
  }

  var_2 = var_0.vo_prefix + "last_stand";
  var_0 thread scripts\cp\cp_vo::play_vo_on_player(var_2, undefined, 1);
}

function player_casualty_vo(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isPlayer(self)) {
    return;
  }

  var_7 = scripts\cp\utility::get_array_of_valid_players();
  var_7 = scripts\engine\utility::array_remove(var_7, self);

  if(var_7.size < 1) {
    return;
  }

  var_8 = var_7[0];
  var_9 = var_8.vo_prefix + "reaction_casualty_generic";
  var_8 scripts\cp\cp_vo::play_vo_on_player(var_9, undefined, 1);
}

function is_in_array(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2] == var_1) {
      return true;
    }
  }

  return false;
}

function debug_change_vo_prefix_watcher() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    var_0 = getdvarint("scr_player_vo_prefix", 0);

    if(var_0 != 0) {
      switch (var_0) {
        case 1:
          self.vo_prefix = "p1_";
          break;
        case 2:
          self.vo_prefix = "p2_";
          break;
        case 3:
          self.vo_prefix = "p3_";
          break;
        case 4:
          self.vo_prefix = "p4_";
          break;
        default:
          break;
      }

      setDvar("scr_player_vo_prefix", 0);
    }

    wait 1;
  }
}

function add_to_ambient_sound_queue(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(level.ambient_sound_queue)) {
    level.ambient_sound_queue = [];
    thread ambient_sound_queue();
  }

  var_7 = spawnStruct();
  var_7.alias = var_0;
  var_7.play_origin = var_1;
  var_7.min_delay = var_2;
  var_7.max_delay = var_3;
  var_7.next_play_time = 0;
  var_7.chance_to_play = var_5;
  var_7.max_player_distance = var_4;

  if(isDefined(var_6)) {
    var_7.next_play_time = gettime() + var_6 * 1000;
  }

  level.ambient_sound_queue = scripts\engine\utility::array_add_safe(level.ambient_sound_queue, var_7);
}

function ambient_sound_queue() {
  for(;;) {
    while(level.ambient_sound_queue.size == 0) {
      wait 1;
    }

    var_0 = scripts\engine\utility::array_randomize(level.ambient_sound_queue);

    foreach(var_2 in var_0) {
      if(gettime() < var_2.next_play_time) {
        continue;
      }

      var_3 = randomintrange(var_2.min_delay, var_2.max_delay + 1);
      var_4 = var_2.chance_to_play;

      if(scripts\cp\utility::any_player_nearby(var_2.play_origin, 4096)) {
        wait 1;
        continue;
      }

      var_5 = scripts\cp\utility::any_player_nearby(var_2.play_origin, var_2.max_player_distance);

      if(!var_5 || randomint(100) > var_4) {
        wait 1;
        continue;
      }

      var_6 = var_2.alias;

      if(isarray(var_2.alias)) {
        var_6 = scripts\engine\utility::random(var_2.alias);
      }

      if(soundexists(var_6)) {
        playsoundatpos(var_2.play_origin, var_6);
      }

      var_2.next_play_time = gettime() + var_3 * 1000;
      wait 1;
    }

    wait 1;
  }
}