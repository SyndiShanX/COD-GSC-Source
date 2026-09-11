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
    foreach(var1 in level.players) {
      if(istrue(var1.vo_system_playing_vo)) {
        return true;
      }
    }
  }

  return false;
}

function getlengthofconversation(var0) {
  var1 = 0;

  for(var2 = 0; var2 < var0.size; var2++) {
    var3 = level.vo_dialogue_prefix[var0[var2]];
    var1 += scripts\cp\cp_vo::get_sound_length(var3 + var0[var2]);
  }

  return var1;
}

function getarrayofdialoguealiases(var0, var1) {
  var2 = [var0];
  var3 = var0;

  for(;;) {
    if(var1 && isDefined(level.vo_alias_data[var3].nextdialogue)) {
      var2 = level.vo_alias_data[var3].nextdialogue;
      var3 = level.vo_alias_data[var3].nextdialogue;
      continue;
    }

    break;
  }

  return var2;
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var0);
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

    var0 = game["music"]["spawn_player"].size;
    var1 = randomint(var0);
    self setplayermusicstate(game["music"]["spawn_player"][var1]);
  }

  if(!scripts\engine\utility::flag("vo_system_setup_done")) {
    scripts\engine\utility::flag_set("vo_system_setup_done");
    return;
  }
}

function playvofordowned(var0, var1) {
  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    return;
  }

  var2 = var0.vo_prefix + "laststand";
  var0 thread scripts\cp\cp_vo::play_vo_on_player(var2);
}

function playvoforrevived(var0, var1) {
  var2 = var0.vo_prefix + "reviving";
  var0 thread scripts\cp\cp_vo::play_vo_on_player(var2);
}

function playvoforscriptable(var0) {
  var1 = 45000;
  var2 = gettime();

  if(!isDefined(level.next_scriptable_vo_time) || level.next_scriptable_vo_time < var2) {
    if(isDefined(level.next_scriptable_vo_time)) {
      if(randomint(100) < 60) {
        return;
      }
    }

    level.next_scriptable_vo_time = var2 + randomintrange(var1, var1 + 5000);
    var3 = scripts\cp\utility::get_array_of_valid_players();
    var4 = scripts\engine\utility::random(var3);

    if(!isDefined(var4)) {
      return;
    }

    switch (var0) {
      case "scriptable_alien_lynx_jump":
      case "scriptable_alien_tatra_t815_jump":
        var5 = var4.vo_prefix + "alien_approach_truck";
        var4 scripts\cp\cp_vo::play_vo_on_player(var5);
        break;
    }

    return;
  }
}

function scriptable_vo_handler() {
  level endon("game_ended");
  level.scriptable_vo_played = [];

  for(;;) {
    level waittill("scriptable", var0);
    thread playvoforscriptable(level);
  }
}

function play_solo_vo(var0, var1, var2, var3, var4, var5) {
  var6 = var0 + "_solo";

  if(soundexists(var6)) {
    scripts\cp\cp_vo::play_vo_on_player(var6);
    return;
  }
}

function playsoundonplayers(var0, var1, var2) {
  if(level.splitscreen) {
    if(isDefined(level.players[0])) {
      level.players[0] playlocalsound(var0);
      return;
    }

    return;
  }

  if(isDefined(var1)) {
    if(isDefined(var2)) {
      for(var3 = 0; var3 < level.players.size; var3++) {
        var4 = level.players[var3];

        if(var4 issplitscreenplayer() && !var4 issplitscreenplayerprimary()) {
          continue;
        }

        if(isDefined(var4.pers["team"]) && var4.pers["team"] == var1 && !isexcluded(var4, var2)) {
          var4 playlocalsound(var0);
        }
      }

      return;
    }

    for(var3 = 0; var3 < level.players.size; var3++) {
      var4 = level.players[var3];

      if(var4 issplitscreenplayer() && !var4 issplitscreenplayerprimary()) {
        continue;
      }

      if(isDefined(var4.pers["team"]) && var4.pers["team"] == var3) {
        var4 playlocalsound(var2);
      }
    }

    return;
  }

  if(isDefined(var3)) {
    for(var3 = 0; var3 < level.players.size; var3++) {
      if(level.players[var3] issplitscreenplayer() && !level.players[var3] issplitscreenplayerprimary()) {
        continue;
      }

      if(!isexcluded(level.players[var3], var3)) {
        level.players[var3] playlocalsound(var3);
      }
    }

    return;
  }

  for(var3 = 0; var3 < level.players.size; var3++) {
    if(level.players[var3] issplitscreenplayer() && !level.players[var3] issplitscreenplayerprimary()) {
      continue;
    }

    level.players[var3] playlocalsound(var4);
  }
}

function isexcluded(var0, var1) {
  for(var2 = 0; var2 < var1.size; var2++) {
    if(var0 == var1[var2]) {
      return true;
    }
  }

  return false;
}

function playeventvo(var0, var1, var2, var3, var4, var5, var6) {
  var7 = scripts\cp\utility::get_array_of_valid_players();

  if(var7.size < 1) {
    return;
  }

  var8 = scripts\engine\utility::random(var7);
  var9 = var8.vo_prefix + var0;
  var8 scripts\cp\cp_vo::play_vo_on_player(var9);
}

function play_vo_for_trap_kills(var0, var1) {
  var2 = var0.vo_prefix + var1;
  var0 thread scripts\cp\cp_vo::play_vo_on_player(var2, undefined, 2);
}

function playvoforlaststand(var0, var1) {
  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    return;
  }

  var2 = var0.vo_prefix + "last_stand";
  var0 thread scripts\cp\cp_vo::play_vo_on_player(var2, undefined, 1);
}

function player_casualty_vo(var0, var1, var2, var3, var4, var5, var6) {
  if(!isPlayer(self)) {
    return;
  }

  var7 = scripts\cp\utility::get_array_of_valid_players();
  var7 = scripts\engine\utility::array_remove(var7, self);

  if(var7.size < 1) {
    return;
  }

  var8 = var7[0];
  var9 = var8.vo_prefix + "reaction_casualty_generic";
  var8 scripts\cp\cp_vo::play_vo_on_player(var9, undefined, 1);
}

function is_in_array(var0, var1) {
  for(var2 = 0; var2 < var0.size; var2++) {
    if(var0[var2] == var1) {
      return true;
    }
  }

  return false;
}

function debug_change_vo_prefix_watcher() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    var0 = getdvarint("scr_player_vo_prefix", 0);

    if(var0 != 0) {
      switch (var0) {
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

function add_to_ambient_sound_queue(var0, var1, var2, var3, var4, var5, var6) {
  if(!isDefined(level.ambient_sound_queue)) {
    level.ambient_sound_queue = [];
    thread ambient_sound_queue();
  }

  var7 = spawnStruct();
  var7.alias = var0;
  var7.play_origin = var1;
  var7.min_delay = var2;
  var7.max_delay = var3;
  var7.next_play_time = 0;
  var7.chance_to_play = var5;
  var7.max_player_distance = var4;

  if(isDefined(var6)) {
    var7.next_play_time = gettime() + var6 * 1000;
  }

  level.ambient_sound_queue = scripts\engine\utility::array_add_safe(level.ambient_sound_queue, var7);
}

function ambient_sound_queue() {
  for(;;) {
    while(level.ambient_sound_queue.size == 0) {
      wait 1;
    }

    var0 = scripts\engine\utility::array_randomize(level.ambient_sound_queue);

    foreach(var2 in var0) {
      if(gettime() < var2.next_play_time) {
        continue;
      }

      var3 = randomintrange(var2.min_delay, var2.max_delay + 1);
      var4 = var2.chance_to_play;

      if(scripts\cp\utility::any_player_nearby(var2.play_origin, 4096)) {
        wait 1;
        continue;
      }

      var5 = scripts\cp\utility::any_player_nearby(var2.play_origin, var2.max_player_distance);

      if(!var5 || randomint(100) > var4) {
        wait 1;
        continue;
      }

      var6 = var2.alias;

      if(isarray(var2.alias)) {
        var6 = scripts\engine\utility::random(var2.alias);
      }

      if(soundexists(var6)) {
        playsoundatpos(var2.play_origin, var6);
      }

      var2.next_play_time = gettime() + var3 * 1000;
      wait 1;
    }

    wait 1;
  }
}