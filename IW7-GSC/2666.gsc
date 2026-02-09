/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2666.gsc
**************************************/

initcpvosystem() {
  level.vo_priority_level = ["highest", "high", "medium", "low"];
  level.vo_alias_data = [];
  level.var_134BF = [];
  level.var_134C0 = [];
  level.vo_dialogue_prefix = [];
  level.var_13519 = "cp\" + getDvar("ui_mapname") + "_vo_table.csv";
  level thread func_C904();
  level thread func_BE3E();
}

func_97CC() {
  func_97A1();
  thread func_10D5B();
  level thread game_ended_vo_watcher();
}

func_97A1() {
  var_0 = spawnStruct();
  var_0.vo_currently_playing = undefined;
  var_0.var_9A89 = undefined;
  var_0.is_playing = 0;
  var_1 = [];

  foreach(var_4, var_3 in level.vo_priority_level) {
    var_1[var_3] = [];
  }

  var_0.vo_queue = var_1;
  self.vo_system = var_0;
  scripts\engine\utility::flag_init("vo_system_busy");
}

func_C904() {
  var_0 = level.var_13519;
  var_1 = 1;

  for(;;) {
    var_2 = tablelookupbyrow(var_0, var_1, 0);

    if(var_2 == "") {
      break;
    }
    var_3 = tablelookupbyrow(var_0, var_1, 1);
    var_4 = int(tablelookupbyrow(var_0, var_1, 2));
    var_5 = int(tablelookupbyrow(var_0, var_1, 3));
    var_6 = int(tablelookupbyrow(var_0, var_1, 4));
    var_7 = tablelookupbyrow(var_0, var_1, 5);
    var_8 = tablelookupbyrow(var_0, var_1, 6);
    var_9 = tablelookupbyrow(var_0, var_1, 7);
    var_10 = tablelookupbyrow(var_0, var_1, 8);
    var_11 = tablelookupbyrow(var_0, var_1, 9);
    var_12 = int(tablelookupbyrow(var_0, var_1, 10));
    var_13 = int(tablelookupbyrow(var_0, var_1, 11));
    var_14 = tablelookupbyrow(var_0, var_1, 12);
    var_15 = int(tablelookupbyrow(var_0, var_1, 13));
    var_16 = tablelookupbyrow(var_0, var_1, 15);
    var_17 = int(tablelookupbyrow(var_0, var_1, 16));
    var_18 = int(tablelookupbyrow(var_0, var_1, 17));
    func_DEDE(var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18);

    if(var_1 % 5 == 1) {
      wait 0.05;
    }

    var_1++;
  }
}

func_DEDE(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16) {
  var_17 = spawnStruct();

  if(isDefined(var_2) && var_2 > 0) {
    var_17.cooldown = var_2;
    var_17.var_A9CE = 0;
  }

  if(isDefined(var_13) && var_13 > 0) {
    var_17.var_C9CA = var_13;
  }

  if(scripts\engine\utility::is_true(var_10)) {
    var_17.var_C555 = 1;
  } else {
    var_17.var_C555 = 0;
  }

  if(isDefined(var_11) && var_11 > 0) {
    var_17.var_32A0 = var_11;
  }

  if(isDefined(var_12)) {
    var_17.priority = var_12;
  }

  if(isDefined(var_4) && var_4 > 0) {
    var_17.var_B44F = var_4;
  }

  if(isDefined(var_3) && var_3 > 0) {
    var_17.chance_to_play = var_3;
  }

  if(isDefined(var_7) && var_7 != "") {
    var_17.var_1383B = var_7;
  }

  if(isDefined(var_5) && var_5 != "") {
    if(!isDefined(level.var_134BF[var_5])) {
      level.var_134BF[var_5] = [];
    }

    var_17.var_3B96 = var_5;
    level.var_134BF[var_5][level.var_134BF[var_5].size] = var_1;

    if(!isDefined(level.var_134C0[var_5])) {
      level.var_134C0[var_5] = 0;
    }
  }

  if(isDefined(var_6) && var_6 != "") {
    if(!isDefined(level.var_134BF[var_6])) {
      level.var_134BF[var_6] = [];
    }

    var_17.var_3B97 = var_6;
    level.var_134BF[var_6][level.var_134BF[var_6].size] = var_1;

    if(!isDefined(level.var_134C0[var_6])) {
      level.var_134C0[var_6] = 0;
    }
  }

  if(isDefined(var_8) && var_8 != "") {
    if(!isDefined(level.vo_dialogue_prefix[var_8])) {
      level.vo_dialogue_prefix[var_8] = [];
    }

    var_17.dialogueprefix = var_8;
    level.vo_dialogue_prefix[var_1] = var_8;
  }

  if(isDefined(var_9) && var_9 != "") {
    var_17.nextdialogue = var_9;
  }

  if(isDefined(var_14)) {
    var_17.var_18E3 = var_14;
  }

  if(isDefined(var_15)) {
    var_17.pap_approval = var_15;
  }

  if(isDefined(var_16)) {
    var_17.rave_approval = var_16;
  }

  level.vo_alias_data[var_1] = var_17;
}

func_10D5B() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    if(is_vo_system_busy()) {
      if(scripts\engine\utility::flag_exist("vo_system_busy")) {
        scripts\engine\utility::flag_waitopen("vo_system_busy");
      }
    }

    var_0 = func_7D4E();

    if(!isDefined(var_0)) {
      set_vo_system_playing(0);
      self waittill("play_VO_system");

      if(func_9D14()) {
        self waittill("unpause_VO_system");
      }

      continue;
    }

    play_vo_system(var_0);
  }
}

play_vo_system(var_0, var_1) {
  self endon("disconnect");
  set_vo_system_playing(1);
  set_vo_currently_playing(var_0);
  play_vo(var_0, var_1);
  pause_between_vo(var_0);
  unset_vo_currently_playing();
}

func_7D4E() {
  var_0 = func_E409();

  if(isDefined(var_0)) {
    return var_0;
  }

  foreach(var_3, var_2 in level.vo_priority_level) {
    var_0 = func_E40A(var_2);

    if(isDefined(var_0)) {
      return var_0;
    }
  }

  return undefined;
}

func_E409() {
  var_0 = self.vo_system.var_9A89;
  func_E1F9();
  return var_0;
}

func_E1F9() {
  self.vo_system.var_9A89 = undefined;
}

func_E40A(var_0) {
  func_E009(var_0);
  return func_D659(var_0);
}

func_D659(var_0) {
  var_1 = self.vo_system.vo_queue[var_0][0];

  if(!isDefined(var_1)) {
    return var_1;
  }

  var_2 = [];

  for(var_3 = 1; var_3 < self.vo_system.vo_queue[var_0].size; var_3++) {
    if(!isDefined(self.vo_system.vo_queue[var_0][var_3])) {
      break;
    }
    var_2[var_3 - 1] = self.vo_system.vo_queue[var_0][var_3];
  }

  self.vo_system.vo_queue[var_0] = var_2;
  return var_1;
}

func_E009(var_0) {
  var_1 = gettime();
  var_2 = [];

  foreach(var_5, var_4 in self.vo_system.vo_queue[var_0]) {
    if(!func_134D5(var_4, var_1)) {
      var_2[var_2.size] = self.vo_system.vo_queue[var_0][var_5];
      continue;
    }
  }

  self.vo_system.vo_queue[var_0] = var_2;
}

func_134D5(var_0, var_1) {
  return var_1 > var_0.var_698A;
}

set_vo_system_playing(var_0) {
  self.vo_system.is_playing = var_0;
}

func_9D14() {
  return scripts\engine\utility::is_true(self.var_C9CB);
}

is_vo_system_busy() {
  return scripts\engine\utility::flag("vo_system_busy");
}

set_vo_system_busy(var_0) {
  level.vo_system_busy = var_0;

  if(!var_0) {
    scripts\engine\utility::flag_clear("vo_system_busy");
  } else {
    scripts\engine\utility::flag_set("vo_system_busy");
  }
}

set_vo_currently_playing(var_0) {
  self.vo_system.vo_currently_playing = var_0;
}

game_ended_vo_watcher() {
  var_0 = "";
  level scripts\engine\utility::waittill_any("game_ended");

  foreach(var_2 in level.players) {
    foreach(var_4 in level.vo_priority_level) {
      if(isDefined(var_2.vo_system.vo_queue[var_4]) && var_2.vo_system.vo_queue[var_4].size > 0) {
        foreach(var_6 in var_2.vo_system.vo_queue[var_4]) {
          if(isDefined(var_6)) {
            if(soundexists(var_6.alias)) {
              var_2 stopolcalsound(var_6.alias);
            }
          }
        }

        var_2.vo_system.vo_queue[var_4] = [];
      }
    }

    if(isDefined(level.dialogue_arr) && level.dialogue_arr.size > 0) {
      foreach(var_10 in level.dialogue_arr) {
        if(issubstr(var_10, "pg_")) {
          var_2 stopolcalsound(var_10);
        }

        if(soundexists(var_2.vo_prefix + var_10)) {
          var_2 stopolcalsound(var_2.vo_prefix + var_10);
        }

        if(soundexists(var_2.vo_prefix + "plr_" + var_10)) {
          var_2 stopolcalsound(var_2.vo_prefix + "plr_" + var_10);
        }
      }
    }

    if(isDefined(var_2.current_vo_queue) && var_2.current_vo_queue.size > 0) {
      foreach(var_13 in var_2.current_vo_queue) {
        if(isDefined(var_13)) {
          if(soundexists(var_13)) {
            var_2 stopolcalsound(var_13);
            continue;
          }

          if(soundexists(var_2.vo_prefix + var_13)) {
            var_2 stopolcalsound(var_2.vo_prefix + var_13);
            continue;
          }

          if(soundexists(var_2.vo_prefix + "plr_" + var_13)) {
            var_2 stopolcalsound(var_2.vo_prefix + "plr_" + var_13);
          }
        }
      }
    }

    if(!isDefined(var_2.vo_prefix)) {
      return;
    }
    switch (var_2.vo_prefix) {
      case "p1_":
        var_0 = "_valley_girl";
        break;
      case "p2_":
        var_0 = "_nerd";
        break;
      case "p3_":
        var_0 = "_rapper";
        break;
      case "p4_":
        var_0 = "_jock";
        break;
      case "p5_":
        var_0 = "_jock";
        break;
    }

    var_2 stopolcalsound("mus_zombies" + var_0);
    var_2 stopolcalsound("mus_zombies" + var_0 + "_lsrs");
  }
}

play_vo(var_0, var_1) {
  self endon("interrupt_current_VO");
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  if(self.sessionstate != "playing") {
    return;
  }
  var_2 = var_0.alias;

  if(!soundexists(var_2)) {
    wait 0.1;
    return;
  }

  self.vo_system_playing_vo = 1;

  if(scripts\cp\utility::is_playing_pain_breathing_sfx(self)) {
    var_3 = scripts\cp\utility::get_pain_breathing_sfx_alias(self);

    if(isDefined(var_3)) {
      self stopolcalsound(var_3);
    }
  }

  if(isDefined(var_0.var_2896)) {
    var_4 = var_0.var_2896;
  } else {
    var_4 = var_2;
  }

  foreach(var_6 in level.players) {
    if(var_6 issplitscreenplayer() && !var_6 isreloading()) {
      continue;
    }
    if(isDefined(var_6.current_vo_queue)) {
      var_6.current_vo_queue = scripts\engine\utility::array_add(var_6.current_vo_queue, var_4);
    }

    if(var_6 == self) {
      if(isDefined(level.get_alias_2d_func)) {
        var_7 = [}
          [level.get_alias_2d_func]](var_6, var_2, var_4);
      else {
        var_7 = get_alias_2d_version(var_6, var_2, var_4);
      }

      if(isDefined(var_7)) {
        var_6 playlocalsound(var_7);
      } else {
        var_6 playlocalsound(var_2);
      }

      if(scripts\engine\utility::is_true(var_1)) {
        var_8 = var_7 + var_6.vo_suffix;
        var_6 thread alias_specific_vo(var_8);
      }

      continue;
    }

    if(!scripts\engine\utility::is_true(var_0.var_C551)) {
      self playsoundtoplayer(var_2, var_6);
    }
  }

  foreach(var_11 in var_0.var_3B94) {
    level.var_134C0[var_11] = gettime();
  }

  if(!isDefined(self.var_C1F6[var_4])) {
    self.var_C1F6[var_4] = 1;
  } else {
    self.var_C1F6[var_4]++;
  }

  wait(get_sound_length(var_2));
  self notify("play_char_specific_intro");
  self.vo_system_playing_vo = 0;
}

alias_specific_vo(var_0) {
  self endon("disconnected");
  level endon("game_ended");
  self endon("death");
  self waittill("play_char_specific_intro");
  self playlocalsound(var_0);
}

alias_2d_version_exists(var_0, var_1) {
  var_2 = get_alias_2d_version(var_0, var_1);
  return soundexists(var_2);
}

get_alias_2d_version(var_0, var_1, var_2) {
  var_3 = strtok(var_1, "_");

  if(var_3[0] == "ww" || var_3[0] == "dj" || var_3[0] == "ks" || var_3[0] == "el") {
    return var_1;
  } else {
    var_4 = var_0.vo_prefix + "plr_" + var_2;

    if(soundexists(var_4)) {
      return var_4;
    }

    return undefined;
  }
}

func_77EE(var_0, var_1) {
  if(issubstr(var_1, "ww_") || issubstr(var_1, "dj_") || issubstr(var_1, "p1_") || issubstr(var_1, "p2_") || issubstr(var_1, "p3_") || issubstr(var_1, "p4_") || issubstr(var_1, "jaroslav_anc")) {
    return var_1;
  }

  var_2 = getsubstr(var_1, var_0.vo_prefix.size);
  return var_0.vo_prefix + var_2;
}

get_sound_length(var_0) {
  return lookupsoundlength(var_0) / 1000;
}

pause_between_vo(var_0) {
  if(func_9D14()) {
    self waittill("unpause_VO_system");
  }

  if(var_0.var_C9CA > 0) {
    wait(var_0.var_C9CA);
  }
}

unset_vo_currently_playing() {
  self.vo_system.vo_currently_playing = undefined;
}

try_to_play_vo_on_all_players(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(level.players)) {
    return;
  }
  if(!scripts\engine\utility::is_true(var_1)) {
    foreach(var_3 in level.players) {
      var_3 thread try_to_play_vo(var_0, "zmb_comment_vo", "highest", 10, 0, 0, 1, 100);
    }
  } else {
    foreach(var_3 in level.players) {
      var_3 thread add_to_nag_vo(var_0, "zmb_comment_vo", 60, 45, 6, 1);
    }
  }
}

try_to_play_vo(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  var_9 = isDefined(level.vo_alias_data[var_0]);

  if(var_9) {
    if(isDefined(level.vo_alias_data[var_0].chance_to_play)) {
      var_7 = level.vo_alias_data[var_0].chance_to_play;
    }
  }

  if(!isDefined(var_7)) {
    var_7 = 100;
  }

  if(randomint(100) > var_7) {
    return;
  }
  if(func_FF79(var_0, var_1, var_2, var_3, var_4, var_5, var_6)) {
    if(var_9 && isDefined(level.vo_alias_data[var_0].var_C9CA)) {
      var_5 = level.vo_alias_data[var_0].var_C9CA;
    }

    if(var_9 && isDefined(level.vo_alias_data[var_0].var_C555)) {
      var_6 = level.vo_alias_data[var_0].var_C555;
    }

    var_10 = func_788D(var_0);

    foreach(var_12 in var_10) {
      level.var_134C0[var_12] = gettime();
    }

    if(var_9 && isDefined(level.vo_alias_data[var_0].var_32A0)) {
      var_3 = level.vo_alias_data[var_0].var_32A0;
    }

    if(var_9 && isDefined(level.vo_alias_data[var_0].priority)) {
      var_2 = level.vo_alias_data[var_0].priority;
    }

    if(var_9 && isDefined(level.vo_alias_data[var_0].var_A9CE)) {
      level.vo_alias_data[var_0].var_A9CE = gettime();
    }

    thread func_1781(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_8);
  }
}

func_FF79(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(level.vo_alias_data[var_0])) {
    return 1;
  }

  if(scripts\cp\zombies\zombie_afterlife_arcade::is_in_afterlife_arcade(self)) {
    if(isDefined(level.var_18E8)) {
      if(![[level.var_18E8]](var_0)) {
        return 0;
      }
    }
  }

  if(scripts\engine\utility::is_true(self.rave_mode)) {
    if(isDefined(level.rave_vo_approve_func)) {
      if(isPlayer(self)) {
        if(!self[[level.rave_vo_approve_func]](var_0)) {
          return 0;
        }
      }
    }
  }

  if(isDefined(level.pap_vo_approve_func)) {
    if(isPlayer(self)) {
      if(!self[[level.pap_vo_approve_func]](var_0)) {
        return 0;
      }
    }
  }

  var_7 = gettime();

  if(isDefined(level.vo_alias_data[var_0].cooldown) && isDefined(level.vo_alias_data[var_0].var_A9CE)) {
    if(var_7 < level.vo_alias_data[var_0].var_A9CE + level.vo_alias_data[var_0].cooldown * 1000) {
      return 0;
    }
  }

  var_8 = func_788D(var_0);

  foreach(var_10 in var_8) {
    var_11 = scripts\engine\utility::ter_op(isDefined(level.vo_alias_data[var_0].cooldown), level.vo_alias_data[var_0].cooldown, 30);

    if(var_7 < level.var_134C0[var_10] + var_11 * 1000) {
      return 0;
    }
  }

  if(isDefined(level.vo_alias_data[var_0].var_B44F)) {
    if(!isDefined(self.var_C1F6)) {
      self.var_C1F6 = [];
    }

    if(!isDefined(self.var_C1F6[var_0])) {
      self.var_C1F6[var_0] = 0;
    }

    if(self.var_C1F6[var_0] < level.vo_alias_data[var_0].var_B44F) {
      return 1;
    } else {
      return 0;
    }
  } else {
    return 1;
  }
}

func_788D(var_0) {
  if(!isDefined(level.var_134BF)) {
    return [];
  }

  var_1 = getarraykeys(level.var_134BF);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(scripts\engine\utility::array_contains(level.var_134BF[var_4], var_0)) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

should_append_player_prefix(var_0) {
  if(issubstr(var_0, "ww_") || issubstr(var_0, "dj_") || issubstr(var_0, "jaroslav_anc")) {
    return 0;
  } else {
    return 1;
  }
}

should_append_player_suffix(var_0, var_1) {
  if(scripts\engine\utility::is_true(var_1)) {
    if(issubstr(var_0, "ww_") && issubstr(var_0, "_p")) {
      return 1;
    } else {
      return 0;
    }
  }

  return 0;
}

func_1781(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  if(isPlayer(self)) {
    if(isDefined(var_1) && isDefined(level.vo_functions[var_1])) {
      if(isDefined(var_7)) {
        self thread[[level.vo_functions[var_1]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
      } else {
        self thread[[level.vo_functions[var_1]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);
      }

      return;
    } else {
      var_8 = self.vo_prefix + var_0;
      thread play_vo_on_player(var_8, var_2, var_3, var_4, var_5, var_6, var_0);
    }
  } else if(isDefined(var_1) && isDefined(level.vo_functions[var_1])) {
    if(isDefined(var_7)) {
      self thread[[level.vo_functions[var_1]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
    } else {
      self thread[[level.vo_functions[var_1]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);
    }

    return;
  } else {
    var_8 = var_0;
    level thread func_CE89(var_8, var_2, var_3, var_4, var_5, var_6, var_0);
  }
}

func_CE89(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  foreach(var_8 in level.players) {
    var_8 func_1782(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  }
}

play_vo_on_player(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  func_1782(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

func_1782(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(self.current_vo_queue)) {
    self.current_vo_queue = [];
  }

  thread func_1783(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

func_1783(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_1 = func_7D3E(var_1);
  var_7 = create_vo_data(var_0, var_2, var_4, var_5, var_6);

  if(func_FF5B(var_3)) {
    func_1767(var_7);

    if(func_9D15()) {
      func_9A85();
    }
  } else {
    func_1777(var_7, var_1);
  }

  if(!func_9D15()) {
    func_C14E();
  }
}

func_7D3E(var_0) {
  if(!isDefined(var_0)) {
    return level.vo_priority_level[level.vo_priority_level.size - 1];
  }

  return var_0;
}

create_vo_data(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 999;
  var_6 = 1.5;
  var_7 = 3;
  var_8 = spawnStruct();
  var_8.alias = var_0;
  var_8.var_3B94 = func_788D(var_0);
  var_8.var_2896 = var_4;

  if(!isDefined(var_1)) {
    var_1 = var_5;
  }

  var_8.var_698A = gettime() + var_1 * 1000;

  if(!isDefined(var_2)) {
    var_2 = randomfloatrange(var_6, var_7);
  }

  var_8.var_C9CA = var_2;

  if(scripts\engine\utility::is_true(var_3)) {
    var_8.var_C551 = 1;
  } else {
    var_8.var_C551 = 0;
  }

  return var_8;
}

func_FF5B(var_0) {
  return isDefined(var_0) && var_0;
}

func_1767(var_0) {
  self.vo_system.var_9A89 = var_0;
}

func_9D15() {
  return scripts\engine\utility::is_true(self.vo_system.is_playing);
}

func_9A85() {
  var_0 = func_790D();

  if(isDefined(var_0)) {
    self stopolcalsound(var_0);
  }

  self notify("interrupt_current_VO");
}

func_790D() {
  if(isDefined(self.vo_system)) {
    if(isDefined(self.vo_system.vo_currently_playing)) {
      if(isDefined(self.vo_system.vo_currently_playing.alias)) {
        return self.vo_system.vo_currently_playing.alias;
      }
    }
  }

  return undefined;
}

func_1777(var_0, var_1) {
  self.vo_system.vo_queue[var_1][self.vo_system.vo_queue[var_1].size] = var_0;
}

func_C14E() {
  self notify("play_VO_system");
}

func_E0A9(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in self.vo_system.vo_queue[var_1]) {
    if(!(var_4.alias == self.vo_prefix + var_0 || var_4.alias == self.vo_prefix + "plr_" + var_0)) {
      var_2[var_2.size] = self.vo_system.vo_queue[var_1][var_5];
    }
  }

  self.vo_system.vo_queue[var_1] = var_2;
}

func_C9CB(var_0) {
  if(var_0.size == 1) {
    var_0[0].var_C9CB = 1;
  } else {
    foreach(var_2 in var_0) {
      var_2.var_C9CB = 1;
    }
  }
}

func_12BE3(var_0) {
  foreach(var_2 in var_0) {
    var_2.var_C9CB = 0;
  }

  foreach(var_2 in var_0) {
    var_2 notify("unpause_VO_system");
  }
}

func_BE3E() {
  level endon("game_ended");

  if(!isDefined(level.var_BE3D)) {
    level.var_BE3D = [];
    level.var_BE3F = [];
    level.pause_nag_vo = 0;
  }

  var_0 = 60;

  for(;;) {
    while(level.pause_nag_vo) {
      wait 0.1;
    }

    var_1 = gettime();

    foreach(var_4, var_3 in level.var_BE3D) {
      if(var_1 > var_3.next_play_time) {
        if(isDefined(var_3.var_EC12)) {
          var_3.var_EC12 try_to_play_vo(var_4, var_3.var_1351C, "low", 3, 0, 0, var_3.var_C551);
        } else {
          level try_to_play_vo(var_4, var_3.var_1351C, "low", 3, 0, 0, var_3.var_C551);
        }

        var_3.var_11923++;

        if(var_3.var_B468 != -1 && var_3.var_B468 <= var_3.var_11923) {
          remove_from_nag_vo(var_4);
        }

        var_3.next_play_time = var_1 + var_3.cooldown * min(var_3.var_11923, 3) * 1000;
        wait(var_0);
      }
    }

    wait 1;
  }
}

add_to_nag_vo(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.var_BE3D)) {
    level.var_BE3D = [];
    level.var_BE3F = [];
    level.pause_nag_vo = 0;
  }

  if(isDefined(level.var_BE3D[var_0])) {
    return;
  }
  if(isDefined(level.var_BE3F[var_0])) {
    return;
  }
  if(!isDefined(var_2)) {
    var_2 = 60;
  }

  if(!isDefined(var_1)) {
    var_1 = "zmb_comment_vo";
  }

  var_6 = undefined;

  if(isPlayer(self)) {
    var_6 = self;
  }

  var_7 = spawnStruct();
  var_7.var_11923 = 0;
  var_7.cooldown = var_2;
  var_7.var_1351C = var_1;

  if(isDefined(var_6)) {
    var_7.var_EC12 = var_6;
  }

  if(isDefined(var_5)) {
    var_7.var_C551 = var_5;
  } else {
    var_7.var_C551 = 0;
  }

  if(isDefined(var_3)) {
    var_7.next_play_time = gettime() + var_3 * 1000;
  } else {
    var_7.next_play_time = 0;
  }

  if(isDefined(var_4)) {
    var_7.var_B468 = var_4;
  } else {
    var_7.var_B468 = -1;
  }

  level.var_BE3D[var_0] = var_7;
}

remove_from_nag_vo(var_0, var_1) {
  level.var_BE3D = scripts\cp\utility::array_remove_index(level.var_BE3D, var_0, 1);

  if(scripts\engine\utility::is_true(var_1)) {
    level.var_BE3F[var_0] = 1;
  }
}

timeoutvofunction(var_0, var_1) {
  level endon(var_0 + "_about_to_play");
  wait(var_1);
  level.announcer_vo_playing = 0;
  level notify(var_0 + "_timed_out");
}