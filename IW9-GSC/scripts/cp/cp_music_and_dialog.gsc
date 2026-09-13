/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_music_and_dialog.gsc
***********************************************/

init() {
  scripts\engine\utility::flag_init("vo_system_setup_done");
  scripts\engine\utility::flag_init("dialogue_done");
  _id_166B4F052DA169A7::_id_83B8144A47850CDD();
  level thread onplayerconnect();
  level thread scriptable_vo_handler();

  if(!isDefined(game["music"])) {
    game["music"]["cp_heli_infil"] = [];
    game["music"]["spawn_player"] = [];
    _id_21168B5CD3F92925();
  }

  if(!isDefined(level.vo_functions))
    level.vo_functions = [];

  if(isDefined(level.level_specific_vo_callouts))
    level.vo_functions = [[level.level_specific_vo_callouts]](level.vo_functions);
}

_id_21168B5CD3F92925() {
  _id_166B4F052DA169A7::_id_83B8144A47850CDD();
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

  if(!isDefined(level.vo_functions))
    level.vo_functions = [];

  if(isDefined(level.level_specific_vo_callouts))
    level.vo_functions = [[level.level_specific_vo_callouts]](level.vo_functions);
}

blank() {}

can_play_dialogue_system() {
  if(level.players.size != 4)
    return 0;

  if(_id_166B4F052DA169A7::is_vo_system_busy())
    return 0;

  return 1;
}

vo_is_playing() {
  if(istrue(level.announcer_vo_playing))
    return 1;
  else if(istrue(level.player_vo_playing))
    return 1;
  else {
    foreach(player in level.players) {
      if(istrue(player.vo_system_playing_vo))
        return 1;
    }
  }

  return 0;
}

getlengthofconversation(_id_2463023B7A8FD31C) {
  time = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2463023B7A8FD31C.size; _id_AC0E594AC96AA3A8++) {
    _id_A2306FC3519E2472 = level.vo_dialogue_prefix[_id_2463023B7A8FD31C[_id_AC0E594AC96AA3A8]];
    time = time + _id_166B4F052DA169A7::get_sound_length(_id_A2306FC3519E2472 + _id_2463023B7A8FD31C[_id_AC0E594AC96AA3A8]);
  }

  return time;
}

getarrayofdialoguealiases(_id_D35946B8550701A5, _id_42547671DF42D8DB) {
  _id_50F783A5617F8940 = [_id_D35946B8550701A5];
  _id_7B429D357ACF4247 = _id_D35946B8550701A5;

  for(;;) {
    if(_id_42547671DF42D8DB && isDefined(level.vo_alias_data[_id_7B429D357ACF4247].nextdialogue)) {
      _id_50F783A5617F8940[_id_50F783A5617F8940.size] = level.vo_alias_data[_id_7B429D357ACF4247].nextdialogue;
      _id_7B429D357ACF4247 = level.vo_alias_data[_id_7B429D357ACF4247].nextdialogue;
      continue;
    }

    break;
  }

  return _id_50F783A5617F8940;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", player);
    player thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");
  self waittill("spawned_player");
  scripts\engine\utility::ent_flag_wait("intro_binks_complete");

  if(!level.splitscreen || level.splitscreen && !isDefined(level.playedstartingmusic)) {
    if(level.splitscreen)
      level.playedstartingmusic = 1;

    _id_14C1526A25B2B2DF = game["music"]["spawn_player"].size;
    _id_D2E335568DFFE831 = randomint(_id_14C1526A25B2B2DF);
    self setplayermusicstate(game["music"]["spawn_player"][_id_D2E335568DFFE831]);
  }

  if(!scripts\engine\utility::flag("vo_system_setup_done"))
    scripts\engine\utility::flag_set("vo_system_setup_done");
}

playvofordowned(player, _id_D35946B8550701A5) {
  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    return;
  }
  line = player.vo_prefix + "laststand";
  player thread _id_166B4F052DA169A7::play_vo_on_player(line);
}

playvoforrevived(player, _id_D35946B8550701A5) {
  line = player.vo_prefix + "reviving";
  player thread _id_166B4F052DA169A7::play_vo_on_player(line);
}

playvoforscriptable(_id_91839BABD32261F4) {
  _id_E3C20A88291CF3AF = 45000;
  current_time = gettime();

  if(!isDefined(level.next_scriptable_vo_time) || level.next_scriptable_vo_time < current_time) {
    if(isDefined(level.next_scriptable_vo_time)) {
      if(randomint(100) < 60)
        return;
    }

    level.next_scriptable_vo_time = current_time + randomintrange(_id_E3C20A88291CF3AF, _id_E3C20A88291CF3AF + 5000);
    players = scripts\cp\utility::get_array_of_valid_players();
    player = scripts\engine\utility::random(players);

    if(!isDefined(player)) {
      return;
    }
    switch (_id_91839BABD32261F4) {
      case "scriptable_alien_lynx_jump":
      case "scriptable_alien_tatra_t815_jump":
        line = player.vo_prefix + "alien_approach_truck";
        player _id_166B4F052DA169A7::play_vo_on_player(line);
        break;
    }
  }
}

scriptable_vo_handler() {
  level endon("game_ended");
  level.scriptable_vo_played = [];

  for(;;) {
    level waittill("scriptable", _id_91839BABD32261F4);
    level thread playvoforscriptable(_id_91839BABD32261F4);
  }
}

play_solo_vo(line, priority, timeout, _id_3D84B5D3F727E22C, pause_time, only_local) {
  _id_B1B1FF3F53F08719 = line + "_solo";

  if(soundexists(_id_B1B1FF3F53F08719))
    _id_166B4F052DA169A7::play_vo_on_player(_id_B1B1FF3F53F08719);
}

playsoundonplayers(sound, team, _id_21D6D994B0F4FAF1) {
  if(level.splitscreen) {
    if(isDefined(level.players[0]))
      level.players[0] playlocalsound(sound);
  } else if(isDefined(team)) {
    if(isDefined(_id_21D6D994B0F4FAF1)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
        player = level.players[_id_AC0E594AC96AA3A8];

        if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
          continue;
        }
        if(isDefined(player.pers["team"]) && player.pers["team"] == team && !isexcluded(player, _id_21D6D994B0F4FAF1))
          player playlocalsound(sound);
      }

      return;
    }

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      player = level.players[_id_AC0E594AC96AA3A8];

      if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
        continue;
      }
      if(isDefined(player.pers["team"]) && player.pers["team"] == team)
        player playlocalsound(sound);
    }

    return;
  } else if(isDefined(_id_21D6D994B0F4FAF1)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      if(level.players[_id_AC0E594AC96AA3A8] issplitscreenplayer() && !level.players[_id_AC0E594AC96AA3A8] issplitscreenplayerprimary()) {
        continue;
      }
      if(!isexcluded(level.players[_id_AC0E594AC96AA3A8], _id_21D6D994B0F4FAF1))
        level.players[_id_AC0E594AC96AA3A8] playlocalsound(sound);
    }
  } else {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      if(level.players[_id_AC0E594AC96AA3A8] issplitscreenplayer() && !level.players[_id_AC0E594AC96AA3A8] issplitscreenplayerprimary()) {
        continue;
      }
      level.players[_id_AC0E594AC96AA3A8] playlocalsound(sound);
    }
  }
}

isexcluded(entity, _id_DCB5FD0CC07E40A2) {
  for(index = 0; index < _id_DCB5FD0CC07E40A2.size; index++) {
    if(entity == _id_DCB5FD0CC07E40A2[index])
      return 1;
  }

  return 0;
}

playeventvo(_id_D35946B8550701A5, vo_type, priority, timeout, _id_3D84B5D3F727E22C, pause_time, only_local) {
  players = scripts\cp\utility::get_array_of_valid_players();

  if(players.size < 1) {
    return;
  }
  player = scripts\engine\utility::random(players);
  alias = player.vo_prefix + _id_D35946B8550701A5;
  player _id_166B4F052DA169A7::play_vo_on_player(alias);
}

playvoforlaststand(player, _id_D35946B8550701A5) {
  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    return;
  }
  line = player.vo_prefix + "last_stand";
  player thread _id_166B4F052DA169A7::play_vo_on_player(line, undefined, 1);
}

player_casualty_vo(_id_D35946B8550701A5, vo_type, priority, timeout, _id_3D84B5D3F727E22C, pause_time, only_local) {
  if(!isPlayer(self)) {
    return;
  }
  players = scripts\cp\utility::get_array_of_valid_players();
  players = scripts\engine\utility::array_remove(players, self);

  if(players.size < 1) {
    return;
  }
  player = players[0];
  line = player.vo_prefix + "reaction_casualty_generic";
  player _id_166B4F052DA169A7::play_vo_on_player(line, undefined, 1);
}

is_in_array(_id_FD434D3DFD963ECF, _id_A9782C100E40DA81) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FD434D3DFD963ECF.size; _id_AC0E594AC96AA3A8++) {
    if(_id_FD434D3DFD963ECF[_id_AC0E594AC96AA3A8] == _id_A9782C100E40DA81)
      return 1;
  }

  return 0;
}

debug_change_vo_prefix_watcher() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    vo_prefix = getdvarint("scr_player_vo_prefix", 0);

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

      setDvar("scr_player_vo_prefix", 0);
    }

    wait 1;
  }
}

add_to_ambient_sound_queue(alias, play_origin, min_delay, max_delay, max_player_distance, chance_to_play, _id_6F81975C2B48BE15) {
  if(!isDefined(level.ambient_sound_queue)) {
    level.ambient_sound_queue = [];
    level thread ambient_sound_queue();
  }

  _id_85790F5A5B2BCB95 = spawnStruct();
  _id_85790F5A5B2BCB95.alias = alias;
  _id_85790F5A5B2BCB95.play_origin = play_origin;
  _id_85790F5A5B2BCB95.min_delay = min_delay;
  _id_85790F5A5B2BCB95.max_delay = max_delay;
  _id_85790F5A5B2BCB95.next_play_time = 0;
  _id_85790F5A5B2BCB95.chance_to_play = chance_to_play;
  _id_85790F5A5B2BCB95.max_player_distance = max_player_distance;

  if(isDefined(_id_6F81975C2B48BE15))
    _id_85790F5A5B2BCB95.next_play_time = gettime() + _id_6F81975C2B48BE15 * 1000;

  level.ambient_sound_queue = scripts\engine\utility::array_add_safe(level.ambient_sound_queue, _id_85790F5A5B2BCB95);
}

ambient_sound_queue() {
  for(;;) {
    while(level.ambient_sound_queue.size == 0)
      wait 1;

    ambient_sound_queue = scripts\engine\utility::array_randomize(level.ambient_sound_queue);

    foreach(sound in ambient_sound_queue) {
      if(gettime() < sound.next_play_time) {
        continue;
      }
      pause_time = randomintrange(sound.min_delay, sound.max_delay + 1);
      chance_to_play = sound.chance_to_play;

      if(scripts\cp\utility::any_player_nearby(sound.play_origin, 4096)) {
        wait 1;
        continue;
      }

      _id_1E1D3C697A810903 = scripts\cp\utility::any_player_nearby(sound.play_origin, sound.max_player_distance);

      if(!_id_1E1D3C697A810903 || randomint(100) > chance_to_play) {
        wait 1;
        continue;
      }

      alias = sound.alias;

      if(isarray(sound.alias))
        alias = scripts\engine\utility::random(sound.alias);

      if(soundexists(alias))
        playsoundatpos(sound.play_origin, alias);

      sound.next_play_time = gettime() + pause_time * 1000;
      wait 1;
    }

    wait 1;
  }
}