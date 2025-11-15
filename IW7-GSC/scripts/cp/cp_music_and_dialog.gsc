/**********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\cp_music_and_dialog.gsc
**********************************************/

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

  foreach(var_01 in level.players) {
    if(var_01.vo_prefix == "p5_") {
      return 0;
    }

    if(var_01.vo_prefix == "p6_") {
      return 0;
    }
  }

  return 1;
}

vo_is_playing() {
  if(level.announcer_vo_playing || scripts\engine\utility::istrue(level.elvira_playing)) {
    return 1;
  } else if(level.player_vo_playing) {
    return 1;
  } else {
    foreach(var_01 in level.players) {
      if(scripts\engine\utility::istrue(var_01.vo_system_playing_vo)) {
        return 1;
      }
    }
  }

  return 0;
}

getlengthofconversation(param_00) {
  var_01 = 0;
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    var_03 = level.vo_dialogue_prefix[param_00[var_02]];
    var_01 = var_01 + scripts\cp\cp_vo::get_sound_length(var_03 + param_00[var_02]);
  }

  return var_01;
}

getarrayofdialoguealiases(param_00, param_01) {
  var_02 = [param_00];
  var_03 = param_00;
  for(;;) {
    if(param_01 && isDefined(level.vo_alias_data[var_03].nextdialogue)) {
      var_02[var_02.size] = level.vo_alias_data[var_03].nextdialogue;
      var_03 = level.vo_alias_data[var_03].nextdialogue;
      continue;
    }

    break;
  }

  return var_02;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread onplayerspawned();
  }
}

func_9D12(param_00) {
  if(isDefined(level.vo_alias_data[param_00].var_18E3)) {
    if(int(level.vo_alias_data[param_00].var_18E3) == 1) {
      return 1;
    }

    return 0;
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

playvofordowned(param_00, param_01) {
  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    return;
  }

  var_02 = param_00.vo_prefix + "laststand";
  param_00 thread scripts\cp\cp_vo::play_vo_on_player(var_02);
}

playvoforrevived(param_00, param_01) {
  var_02 = param_00.vo_prefix + "reviving";
  param_00 thread scripts\cp\cp_vo::play_vo_on_player(var_02);
}

playvoforscriptable(param_00) {
  var_01 = -20536;
  var_02 = gettime();
  if(!isDefined(level.next_scriptable_vo_time) || level.next_scriptable_vo_time < var_02) {
    if(isDefined(level.next_scriptable_vo_time)) {
      if(randomint(100) < 60) {
        return;
      }
    }

    level.next_scriptable_vo_time = var_02 + randomintrange(var_01, var_01 + 5000);
    var_03 = scripts\cp\utility::get_array_of_valid_players();
    var_04 = scripts\engine\utility::random(var_03);
    if(!isDefined(var_04)) {
      return;
    }

    switch (param_00) {
      case "scriptable_alien_lynx_jump":
      case "scriptable_alien_tatra_t815_jump":
        var_05 = var_04.vo_prefix + "alien_approach_truck";
        var_04 scripts\cp\cp_vo::play_vo_on_player(var_05);
        break;
    }
  }
}

scriptable_vo_handler() {
  level endon("game_ended");
  level.scriptable_vo_played = [];
  for(;;) {
    level waittill("scriptable", var_00);
    level thread playvoforscriptable(var_00);
  }
}

func_6A20(param_00) {
  param_00 playlocalsound("mantle_cloth_plr_24_up");
  wait(0.65);
  if(param_00.vo_prefix == "p1_") {
    param_00 playlocalsound("p1_breathing_better");
    return;
  }

  if(param_00.vo_prefix == "p2_") {
    param_00 playlocalsound("p2_breathing_better");
    return;
  }

  if(param_00.vo_prefix == "p3_") {
    param_00 playlocalsound("p3_breathing_better");
    return;
  }

  if(param_00.vo_prefix == "p4_") {
    param_00 playlocalsound("p4_breathing_better");
    return;
  }

  if(param_00.vo_prefix == "p5_") {
    param_00 playlocalsound("p5_breathing_better");
    return;
  }

  if(param_00.vo_prefix == "p6_") {
    param_00 playlocalsound("p5_breathing_better");
    return;
  }

  param_00 playlocalsound("p3_breathing_better");
}

play_solo_vo(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = param_00 + "_solo";
  if(soundexists(var_06)) {
    scripts\cp\cp_vo::play_vo_on_player(var_06);
  }
}

playsoundonplayers(param_00, param_01, param_02) {
  if(level.splitscreen) {
    if(isDefined(level.players[0])) {
      level.players[0] playlocalsound(param_00);
      return;
    }

    return;
  }

  if(isDefined(param_01)) {
    if(isDefined(param_02)) {
      for(var_03 = 0; var_03 < level.players.size; var_03++) {
        var_04 = level.players[var_03];
        if(var_04 issplitscreenplayer() && !var_04 issplitscreenplayerprimary()) {
          continue;
        }

        if(isDefined(var_04.pers["team"]) && var_04.pers["team"] == param_01 && !isexcluded(var_04, param_02)) {
          var_04 playlocalsound(param_00);
        }
      }

      return;
    }

    for(var_03 = 0; var_03 < level.players.size; var_03++) {
      var_04 = level.players[var_03];
      if(var_04 issplitscreenplayer() && !var_04 issplitscreenplayerprimary()) {
        continue;
      }

      if(isDefined(var_04.pers["team"]) && var_04.pers["team"] == param_01) {
        var_04 playlocalsound(param_00);
      }
    }

    return;
  }

  if(isDefined(var_03)) {
    for(var_03 = 0; var_03 < level.players.size; var_03++) {
      if(level.players[var_03] issplitscreenplayer() && !level.players[var_03] issplitscreenplayerprimary()) {
        continue;
      }

      if(!isexcluded(level.players[var_03], param_02)) {
        level.players[var_03] playlocalsound(param_00);
      }
    }

    return;
  }

  for(var_03 = 0; var_03 < level.players.size; var_03++) {
    if(level.players[var_03] issplitscreenplayer() && !level.players[var_03] issplitscreenplayerprimary()) {
      continue;
    }

    level.players[var_03] playlocalsound(param_00);
  }
}

isexcluded(param_00, param_01) {
  for(var_02 = 0; var_02 < param_01.size; var_02++) {
    if(param_00 == param_01[var_02]) {
      return 1;
    }
  }

  return 0;
}

playeventvo(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = scripts\cp\utility::get_array_of_valid_players();
  if(var_07.size < 1) {
    return;
  }

  var_08 = scripts\engine\utility::random(var_07);
  var_09 = var_08.vo_prefix + param_00;
  var_08 scripts\cp\cp_vo::play_vo_on_player(var_09);
}

play_vo_for_trap_kills(param_00, param_01) {
  var_02 = param_00.vo_prefix + param_01;
  param_00 thread scripts\cp\cp_vo::play_vo_on_player(var_02, undefined, 2);
}

playvoforlaststand(param_00, param_01) {
  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    return;
  }

  var_02 = param_00.vo_prefix + "last_stand";
  param_00 thread scripts\cp\cp_vo::play_vo_on_player(var_02, undefined, 1);
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
    level waittill("drill_planted", var_00);
    level notify("vo_notify", "drill_planted", "drill_planted", var_00);
  }
}

func_5AF8() {
  self endon("disconnect");
  self endon("death");
  self endon("revive");
  wait(4);
  level notify("vo_notify", "reaction_casualty_generic", "reaction_casualty_generic", self);
  wait(10);
  while(self.being_revived) {
    wait(0.1);
  }

  self notify("vo_notify", "bleeding_out", "bleeding_out", self);
  wait(8);
  while(self.being_revived) {
    wait(0.1);
  }

  self notify("vo_notify", "bleeding_out", "bleeding_out", self);
}

player_casualty_vo(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(!isplayer(self)) {
    return;
  }

  var_07 = scripts\cp\utility::get_array_of_valid_players();
  var_07 = scripts\engine\utility::array_remove(var_07, self);
  if(var_07.size < 1) {
    return;
  }

  var_08 = var_07[0];
  var_09 = var_08.vo_prefix + "reaction_casualty_generic";
  var_08 scripts\cp\cp_vo::play_vo_on_player(var_09, undefined, 1);
}

is_in_array(param_00, param_01) {
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    if(param_00[var_02] == param_01) {
      return 1;
    }
  }

  return 0;
}

debug_change_vo_prefix_watcher() {
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    var_00 = getdvarint("scr_player_vo_prefix", 0);
    if(var_00 != 0) {
      switch (var_00) {
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

        case 6:
          self.vo_prefix = "p6_";
          break;

        default:
          break;
      }

      setdvar("scr_player_vo_prefix", 0);
    }

    wait(1);
  }
}

add_to_ambient_sound_queue(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(!isDefined(level.ambient_sound_queue)) {
    level.ambient_sound_queue = [];
    level thread ambient_sound_queue();
  }

  var_07 = spawnStruct();
  var_07.alias = param_00;
  var_07.play_origin = param_01;
  var_07.min_delay = param_02;
  var_07.max_delay = param_03;
  var_07.next_play_time = 0;
  var_07.chance_to_play = param_05;
  var_07.max_player_distance = param_04;
  if(isDefined(param_06)) {
    var_07.next_play_time = gettime() + param_06 * 1000;
  }

  level.ambient_sound_queue = scripts\engine\utility::array_add_safe(level.ambient_sound_queue, var_07);
}

ambient_sound_queue() {
  for(;;) {
    while(level.ambient_sound_queue.size == 0) {
      wait(1);
    }

    var_00 = scripts\engine\utility::array_randomize(level.ambient_sound_queue);
    foreach(var_02 in var_00) {
      if(gettime() < var_02.next_play_time || isDefined(level.dj_broadcasting)) {
        continue;
      }

      var_03 = randomintrange(var_02.min_delay, var_02.max_delay + 1);
      var_04 = var_02.chance_to_play;
      if(scripts\cp\utility::any_player_nearby(var_02.play_origin, 4096)) {
        wait(1);
        continue;
      }

      var_05 = scripts\cp\utility::any_player_nearby(var_02.play_origin, var_02.max_player_distance);
      if(!var_05 || randomint(100) > var_04) {
        wait(1);
        continue;
      }

      var_06 = var_02.alias;
      if(isarray(var_02.alias)) {
        var_06 = scripts\engine\utility::random(var_02.alias);
      }

      if(soundexists(var_06)) {
        playsoundatpos(var_02.play_origin, var_06);
      }

      var_02.next_play_time = gettime() + var_03 * 1000;
      wait(1);
    }

    wait(1);
  }
}