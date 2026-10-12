/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_music_and_dialog.gsc
***********************************************/



#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\cp\vo;
#using scripts\engine\utility;
#namespace cp_music_and_dialog;

function init() {
  flag_init("vo_system_setup_done");
  flag_init("dialogue_done");
  function_83b8144a47850cdd();
  level thread onplayerconnect();
  level thread scriptable_vo_handler();

  if(!isDefined(game["music"])) {
    game["music"]["cp_heli_infil"] = [];
    game["music"]["spawn_player"] = [];
    function_21168b5cd3f92925();
  }

  if(!isDefined(level.vo_functions)) {
    level.vo_functions = [];
  }

  if(isDefined(level.level_specific_vo_callouts)) {
    level.vo_functions = [[level.level_specific_vo_callouts]](level.vo_functions);
  }
}

function function_21168b5cd3f92925() {
  function_83b8144a47850cdd();
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
  }
}

function blank() {}

function can_play_dialogue_system() {
  if(getdvarint(@ "hash_f3a851c7e7a172af", 0) == 1) {
    return true;
  }

  if(level.players.size != 4) {
    return false;
  }

  if(is_vo_system_busy()) {
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
    foreach(player in level.players) {
      if(istrue(player.vo_system_playing_vo)) {
        return true;
      }
    }
  }

  return false;
}

function getlengthofconversation(var_2463023b7a8fd31c) {
  time = 0;

  for(i = 0; i < var_2463023b7a8fd31c.size; i++) {
    voprefix = level.vo_dialogue_prefix[var_2463023b7a8fd31c[i]];
    time += scripts\cp\vo::get_sound_length(voprefix + var_2463023b7a8fd31c[i]);
  }

  return time;
}

function getarrayofdialoguealiases(alias_string, aliasdata) {
  temparray = [alias_string];
  var_7b429d357acf4247 = alias_string;

  while(true) {
    if(aliasdata && isDefined(level.vo_alias_data[var_7b429d357acf4247].nextdialogue)) {
      temparray[temparray.size] = level.vo_alias_data[var_7b429d357acf4247].nextdialogue;
      var_7b429d357acf4247 = level.vo_alias_data[var_7b429d357acf4247].nextdialogue;
      continue;
    }

    break;
  }

  return temparray;
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", player);
    player thread onplayerspawned();
  }
}

function onplayerspawned() {
  self endon("disconnect");
  self waittill("spawned_player");
  scripts\engine\utility::ent_flag_wait("intro_binks_complete");

  if(!level.splitscreen || level.splitscreen && !isDefined(level.playedstartingmusic)) {
    if(level.splitscreen) {
      level.playedstartingmusic = 1;
    }

    var_14c1526a25b2b2df = game["music"]["spawn_player"].size;
    var_d2e335568dffe831 = randomint(var_14c1526a25b2b2df);
    self setplayermusicstate(game["music"]["spawn_player"][var_d2e335568dffe831]);
  }

  if(!flag("vo_system_setup_done")) {
    flag_set("vo_system_setup_done");
  }
}

function playvofordowned(player, alias_string) {
  if(isplayingsolo() || level.only_one_player) {
    return;
  }

  line = player.vo_prefix + "laststand";
  player thread play_vo_on_player(line);
}

function playvoforrevived(player, alias_string) {
  line = player.vo_prefix + "reviving";
  player thread play_vo_on_player(line);
}

function playvoforscriptable(scriptable_name) {
  var_e3c20a88291cf3af = 45000;
  current_time = gettime();

  if(!isDefined(level.next_scriptable_vo_time) || level.next_scriptable_vo_time < current_time) {
    if(isDefined(level.next_scriptable_vo_time)) {
      if(randomint(100) < 60) {
        return;
      }
    }

    level.next_scriptable_vo_time = current_time + randomintrange(var_e3c20a88291cf3af, var_e3c20a88291cf3af + 5000);
    players = get_array_of_valid_players();
    player = random(players);

    if(!isDefined(player)) {
      return;
    }

    switch (scriptable_name) {
      case #"hash_14d8cee9efde6d97":
      case #"hash_2b9bfba8d9b531a5":
        line = player.vo_prefix + "alien_approach_truck";
        player play_vo_on_player(line);
        break;
    }
  }
}

function scriptable_vo_handler() {
  level endon("game_ended");
  level.scriptable_vo_played = [];

  while(true) {
    level waittill("scriptable", scriptable_name);
    level thread playvoforscriptable(scriptable_name);
  }
}

function play_solo_vo(line, priority, timeout, interrupt, pause_time, only_local) {
  solo_line = line + "_solo";

  if(soundexists(solo_line)) {
    play_vo_on_player(solo_line);
  }
}

function playsoundonplayers(sound, team, excludelist) {
  assert(isDefined(level.players));

  if(level.splitscreen) {
    if(isDefined(level.players[0])) {
      level.players[0] playlocalsound(sound);
    }

    return;
  }

  if(isDefined(team)) {
    if(isDefined(excludelist)) {
      for(i = 0; i < level.players.size; i++) {
        player = level.players[i];

        if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
          continue;
        }

        if(isDefined(player.pers["team"]) && player.pers["team"] == team && !isexcluded(player, excludelist)) {
          player playlocalsound(sound);
        }
      }
    } else {
      for(i = 0; i < level.players.size; i++) {
        player = level.players[i];

        if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
          continue;
        }

        if(isDefined(player.pers["team"]) && player.pers["team"] == team) {
          player playlocalsound(sound);
        }
      }
    }

    return;
  }

  if(isDefined(excludelist)) {
    for(i = 0; i < level.players.size; i++) {
      if(level.players[i] issplitscreenplayer() && !level.players[i] issplitscreenplayerprimary()) {
        continue;
      }

      if(!isexcluded(level.players[i], excludelist)) {
        level.players[i] playlocalsound(sound);
      }
    }

    return;
  }

  for(i = 0; i < level.players.size; i++) {
    if(level.players[i] issplitscreenplayer() && !level.players[i] issplitscreenplayerprimary()) {
      continue;
    }

    level.players[i] playlocalsound(sound);
  }
}

function isexcluded(entity, entitylist) {
  for(index = 0; index < entitylist.size; index++) {
    if(entity == entitylist[index]) {
      return true;
    }
  }

  return false;
}

function playeventvo(alias_string, vo_type, priority, timeout, interrupt, pause_time, only_local) {
  players = get_array_of_valid_players();

  if(players.size < 1) {
    return;
  }

  player = random(players);
  alias = player.vo_prefix + alias_string;
  player play_vo_on_player(alias);
}

function playvoforlaststand(player, alias_string) {
  if(isplayingsolo() || level.only_one_player) {
    return;
  }

  line = player.vo_prefix + "last_stand";
  player thread play_vo_on_player(line, undefined, 1);
}

function player_casualty_vo(alias_string, vo_type, priority, timeout, interrupt, pause_time, only_local) {
  if(!isPlayer(self)) {
    return;
  }

  players = get_array_of_valid_players();
  players = array_remove(players, self);

  if(players.size < 1) {
    return;
  }

  player = players[0];
  line = player.vo_prefix + "reaction_casualty_generic";
  player play_vo_on_player(line, undefined, 1);
}

function is_in_array(aecollection, efindee) {
  for(i = 0; i < aecollection.size; i++) {
    if(aecollection[i] == efindee) {
      return true;
    }
  }

  return false;
}

function debug_change_vo_prefix_watcher() {
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    vo_prefix = getdvarint(@ "hash_c62b3fa19dc0eed5", 0);

    if(vo_prefix != 0) {
      switch (vo_prefix) {
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

      setDvar(@ "hash_c62b3fa19dc0eed5", 0);
    }

    wait 1;
  }
}

function add_to_ambient_sound_queue(alias, play_origin, min_delay, max_delay, max_player_distance, chance_to_play, predelay) {
  if(!isDefined(level.ambient_sound_queue)) {
    level.ambient_sound_queue = [];
    level thread ambient_sound_queue();
  }

  new_sound = spawnStruct();
  new_sound.alias = alias;
  new_sound.play_origin = play_origin;
  new_sound.min_delay = min_delay;
  new_sound.max_delay = max_delay;
  new_sound.next_play_time = 0;
  new_sound.chance_to_play = chance_to_play;
  new_sound.max_player_distance = max_player_distance;

  if(isDefined(predelay)) {
    new_sound.next_play_time = gettime() + predelay * 1000;
  }

  level.ambient_sound_queue = array_add_safe(level.ambient_sound_queue, new_sound);
}

function ambient_sound_queue() {
  while(true) {
    while(level.ambient_sound_queue.size == 0) {
      wait 1;
    }

    ambient_sound_queue = array_randomize(level.ambient_sound_queue);

    foreach(sound in ambient_sound_queue) {
      if(gettime() < sound.next_play_time) {
        continue;
      }

      pause_time = randomintrange(sound.min_delay, sound.max_delay + 1);
      chance_to_play = sound.chance_to_play;

      if(any_player_nearby(sound.play_origin, 4096)) {
        wait 1;
        continue;
      }

      player_near = any_player_nearby(sound.play_origin, sound.max_player_distance);

      if(!player_near || randomint(100) > chance_to_play) {
        wait 1;
        continue;
      }

      alias = sound.alias;

      if(isarray(sound.alias)) {
        alias = random(sound.alias);
      }

      if(soundexists(alias)) {
        playsoundatpos(sound.play_origin, alias);
      }

      sound.next_play_time = gettime() + pause_time * 1000;
      wait 1;
    }

    wait 1;
  }
}