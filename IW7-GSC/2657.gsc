/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2657.gsc
***************************************/

init() {
  scripts\engine\utility::flag_init("vo_system_setup_done");
  scripts\engine\utility::flag_init("dialogue_done");
  scripts\cp\cp_vo::initcpvosystem();
  level thread onplayerconnect();
  level thread scriptable_vo_handler();

  if(!isDefined(level.vo_functions)) {
    level.vo_functions = [];
  }

  if(isDefined(level.level_specific_vo_callouts)) {
    level.vo_functions = [[level.level_specific_vo_callouts]](level.vo_functions);
  }

  level.var_18E8 = ::func_9D12;
}

blank() {}

can_play_dialogue_system() {
  if(level.players.size != 4) {
    return 0;
  }

  if(scripts\cp\cp_vo::is_vo_system_busy()) {
    return 0;
  }

  foreach(var_1 in level.players) {
    if(var_1.vo_prefix == "p5_") {
      return 0;
    }
  }

  return 1;
}

vo_is_playing() {
  if(level.announcer_vo_playing || scripts\engine\utility::is_true(level.elvira_playing)) {
    return 1;
  } else if(level.player_vo_playing) {
    return 1;
  } else {
    foreach(var_1 in level.players) {
      if(scripts\engine\utility::is_true(var_1.vo_system_playing_vo)) {
        return 1;
      }
    }
  }

  return 0;
}

getlengthofconversation(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = level.vo_dialogue_prefix[var_0[var_2]];
    var_1 = var_1 + scripts\cp\cp_vo::get_sound_length(var_3 + var_0[var_2]);
  }

  return var_1;
}

getarrayofdialoguealiases(var_0, var_1) {
  var_2 = [var_0];
  var_3 = var_0;

  for(;;) {
    if(var_1 && isDefined(level.vo_alias_data[var_3].nextdialogue)) {
      var_2[var_2.size] = level.vo_alias_data[var_3].nextdialogue;
      var_3 = level.vo_alias_data[var_3].nextdialogue;
      continue;
    }

    break;
  }

  return var_2;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawned();
  }
}

func_9D12(var_0) {
  if(isDefined(level.vo_alias_data[var_0].var_18E3)) {
    if(int(level.vo_alias_data[var_0].var_18E3) == 1) {
      return 1;
    } else {
      return 0;
    }
  }
}

onplayerspawned() {
  self endon("disconnect");
  self waittill("spawned_player");

  if(!level.splitscreen || level.splitscreen && !isDefined(level.playedstartingmusic)) {
    if(level.splitscreen) {
      level.playedstartingmusic = 1;
    }
  }

  if(!scripts\engine\utility::flag("vo_system_setup_done")) {
    scripts\engine\utility::flag_set("vo_system_setup_done");
  }
}

playvofordowned(var_0, var_1) {
  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    return;
  }
  var_2 = var_0.vo_prefix + "laststand";
  var_0 thread scripts\cp\cp_vo::play_vo_on_player(var_2);
}

playvoforrevived(var_0, var_1) {
  var_2 = var_0.vo_prefix + "reviving";
  var_0 thread scripts\cp\cp_vo::play_vo_on_player(var_2);
}

playvoforscriptable(var_0) {
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
  }
}

scriptable_vo_handler() {
  level endon("game_ended");
  level.scriptable_vo_played = [];

  for(;;) {
    level waittill("scriptable", var_0);
    level thread playvoforscriptable(var_0);
  }
}

func_6A20(var_0) {
  var_0 playlocalsound("mantle_cloth_plr_24_up");
  wait 0.65;

  if(var_0.vo_prefix == "p1_") {
    var_0 playlocalsound("p1_breathing_better");
  } else if(var_0.vo_prefix == "p2_") {
    var_0 playlocalsound("p2_breathing_better");
  } else if(var_0.vo_prefix == "p3_") {
    var_0 playlocalsound("p3_breathing_better");
  } else if(var_0.vo_prefix == "p4_") {
    var_0 playlocalsound("p4_breathing_better");
  } else if(var_0.vo_prefix == "p5_") {
    var_0 playlocalsound("p5_breathing_better");
  } else {
    var_0 playlocalsound("p3_breathing_better");
  }
}

play_solo_vo(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_0 + "_solo";

  if(soundexists(var_6)) {
    scripts\cp\cp_vo::play_vo_on_player(var_6);
  }
}

playsoundonplayers(var_0, var_1, var_2) {
  if(level.splitscreen) {
    if(isDefined(level.players[0])) {
      level.players[0] playlocalsound(var_0);
    }
  } else if(isDefined(var_1)) {
    if(isDefined(var_2)) {
      for(var_3 = 0; var_3 < level.players.size; var_3++) {
        var_4 = level.players[var_3];

        if(var_4 issplitscreenplayer() && !var_4 isreloading()) {
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

      if(var_4 issplitscreenplayer() && !var_4 isreloading()) {
        continue;
      }
      if(isDefined(var_4.pers["team"]) && var_4.pers["team"] == var_1) {
        var_4 playlocalsound(var_0);
      }
    }

    return;
  } else if(isDefined(var_2)) {
    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      if(level.players[var_3] issplitscreenplayer() && !level.players[var_3] isreloading()) {
        continue;
      }
      if(!isexcluded(level.players[var_3], var_2)) {
        level.players[var_3] playlocalsound(var_0);
      }
    }
  } else {
    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      if(level.players[var_3] issplitscreenplayer() && !level.players[var_3] isreloading()) {
        continue;
      }
      level.players[var_3] playlocalsound(var_0);
    }
  }
}

isexcluded(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_0 == var_1[var_2]) {
      return 1;
    }
  }

  return 0;
}

playeventvo(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\cp\utility::get_array_of_valid_players();

  if(var_7.size < 1) {
    return;
  }
  var_8 = scripts\engine\utility::random(var_7);
  var_9 = var_8.vo_prefix + var_0;
  var_8 scripts\cp\cp_vo::play_vo_on_player(var_9);
}

play_vo_for_trap_kills(var_0, var_1) {
  var_2 = var_0.vo_prefix + var_1;
  var_0 thread scripts\cp\cp_vo::play_vo_on_player(var_2, undefined, 2);
}

playvoforlaststand(var_0, var_1) {
  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    return;
  }
  var_2 = var_0.vo_prefix + "last_stand";
  var_0 thread scripts\cp\cp_vo::play_vo_on_player(var_2, undefined, 1);
}

func_3D8A() {
  self endon("disconnect");
  self endon("death");

  for(;;) {
    self waittill("last_stand");
    func_5AF8();
  }
}

func_3D80() {
  for(;;) {
    level waittill("drill_planted", var_0);
    level notify("vo_notify", "drill_planted", "drill_planted", var_0);
  }
}

func_5AF8() {
  self endon("disconnect");
  self endon("death");
  self endon("revive");
  wait 4.0;
  level notify("vo_notify", "reaction_casualty_generic", "reaction_casualty_generic", self);
  wait 10.0;

  while(self.being_revived) {
    wait 0.1;
  }

  self notify("vo_notify", "bleeding_out", "bleeding_out", self);
  wait 8.0;

  while(self.being_revived) {
    wait 0.1;
  }

  self notify("vo_notify", "bleeding_out", "bleeding_out", self);
}

player_casualty_vo(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isplayer(self)) {
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

is_in_array(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2] == var_1) {
      return 1;
    }
  }

  return 0;
}

debug_change_vo_prefix_watcher() {
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
        case 5:
          self.vo_prefix = "p5_";
          break;
        default:
          break;
      }

      setdvar("scr_player_vo_prefix", 0);
    }

    wait 1;
  }
}

add_to_ambient_sound_queue(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(level.ambient_sound_queue)) {
    level.ambient_sound_queue = [];
    level thread ambient_sound_queue();
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

  level.ambient_sound_queue = scripts\engine\utility::add_to_array(level.ambient_sound_queue, var_7);
}

ambient_sound_queue() {
  for(;;) {
    while(level.ambient_sound_queue.size == 0) {
      wait 1;
    }

    var_0 = scripts\engine\utility::array_randomize(level.ambient_sound_queue);

    foreach(var_2 in var_0) {
      if(gettime() < var_2.next_play_time || isDefined(level.dj_broadcasting)) {
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
        playLoopSound(var_2.play_origin, var_6);
      }

      var_2.next_play_time = gettime() + var_3 * 1000;
      wait 1;
    }

    wait 1;
  }
}