/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2666.gsc
***************************************/

initcpvosystem() {
  level.vo_priority_level = ["highest", "high", "medium", "low"];
  level.vo_alias_data = [];
  level.func_134BF = [];
  level.func_134C0 = [];
  level.vo_dialogue_prefix = [];
  level.func_13519 = "cp\" + getdvar("
  ui_mapname ") + "
  _vo_table.csv ";
  level thread func_C904();
  level thread func_BE3E();
}

func_97CC() {
  func_97A1();
  thread func_10D5B();
  level thread game_ended_vo_watcher();
}

func_97A1() {
  var_00 = spawnStruct();
  var_0.vo_currently_playing = undefined;
  var_0.func_9A89 = undefined;
  var_0.is_playing = 0;
  var_01 = [];

  foreach(var_04, var_03 in level.vo_priority_level)
  var_1[var_03] = [];

  var_0.vo_queue = var_01;
  self.vo_system = var_00;
  scripts\engine\utility::flag_init("vo_system_busy");
}

func_C904() {
  var_00 = level.func_13519;
  var_01 = 1;

  for(;;) {
    var_02 = tablelookupbyrow(var_00, var_01, 0);

    if(var_02 == "") {
      break;
    }
    var_03 = tablelookupbyrow(var_00, var_01, 1);
    var_04 = int(tablelookupbyrow(var_00, var_01, 2));
    var_05 = int(tablelookupbyrow(var_00, var_01, 3));
    var_06 = int(tablelookupbyrow(var_00, var_01, 4));
    var_07 = tablelookupbyrow(var_00, var_01, 5);
    var_08 = tablelookupbyrow(var_00, var_01, 6);
    var_09 = tablelookupbyrow(var_00, var_01, 7);
    var_10 = tablelookupbyrow(var_00, var_01, 8);
    var_11 = tablelookupbyrow(var_00, var_01, 9);
    var_12 = int(tablelookupbyrow(var_00, var_01, 10));
    var_13 = int(tablelookupbyrow(var_00, var_01, 11));
    var_14 = tablelookupbyrow(var_00, var_01, 12);
    var_15 = int(tablelookupbyrow(var_00, var_01, 13));
    var_16 = tablelookupbyrow(var_00, var_01, 15);
    var_17 = int(tablelookupbyrow(var_00, var_01, 16));
    var_18 = int(tablelookupbyrow(var_00, var_01, 17));
    func_DEDE(var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18);

    if(var_01 % 5 == 1)
      wait 0.05;

    var_1++;
  }
}

func_DEDE(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13, var_14, var_15, var_16) {
  var_17 = spawnStruct();

  if(isDefined(var_02) && var_02 > 0) {
    var_17.cooldown = var_02;
    var_17.func_A9CE = 0;
  }

  if(isDefined(var_13) && var_13 > 0)
    var_17.func_C9CA = var_13;

  if(scripts\engine\utility::is_true(var_10))
    var_17.func_C555 = 1;
  else
    var_17.func_C555 = 0;

  if(isDefined(var_11) && var_11 > 0)
    var_17.func_32A0 = var_11;

  if(isDefined(var_12))
    var_17.priority = var_12;

  if(isDefined(var_04) && var_04 > 0)
    var_17.func_B44F = var_04;

  if(isDefined(var_03) && var_03 > 0)
    var_17.chance_to_play = var_03;

  if(isDefined(var_07) && var_07 != "")
    var_17.func_1383B = var_07;

  if(isDefined(var_05) && var_05 != "") {
    if(!isDefined(level.func_134BF[var_05]))
      level.func_134BF[var_05] = [];

    var_17.func_3B96 = var_05;
    level.func_134BF[var_05][level.func_134BF[var_05].size] = var_01;

    if(!isDefined(level.func_134C0[var_05]))
      level.func_134C0[var_05] = 0;
  }

  if(isDefined(var_06) && var_06 != "") {
    if(!isDefined(level.func_134BF[var_06]))
      level.func_134BF[var_06] = [];

    var_17.func_3B97 = var_06;
    level.func_134BF[var_06][level.func_134BF[var_06].size] = var_01;

    if(!isDefined(level.func_134C0[var_06]))
      level.func_134C0[var_06] = 0;
  }

  if(isDefined(var_08) && var_08 != "") {
    if(!isDefined(level.vo_dialogue_prefix[var_08]))
      level.vo_dialogue_prefix[var_08] = [];

    var_17.dialogueprefix = var_08;
    level.vo_dialogue_prefix[var_01] = var_08;
  }

  if(isDefined(var_09) && var_09 != "")
    var_17.nextdialogue = var_09;

  if(isDefined(var_14))
    var_17.func_18E3 = var_14;

  if(isDefined(var_15))
    var_17.pap_approval = var_15;

  if(isDefined(var_16))
    var_17.rave_approval = var_16;

  level.vo_alias_data[var_01] = var_17;
}

func_10D5B() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    if(is_vo_system_busy()) {
      if(scripts\engine\utility::flag_exist("vo_system_busy"))
        scripts\engine\utility::flag_waitopen("vo_system_busy");
    }

    var_00 = func_7D4E();

    if(!isDefined(var_00)) {
      set_vo_system_playing(0);
      self waittill("play_VO_system");

      if(func_9D14())
        self waittill("unpause_VO_system");

      continue;
    }

    play_vo_system(var_00);
  }
}

play_vo_system(var_00, var_01) {
  self endon("disconnect");
  set_vo_system_playing(1);
  set_vo_currently_playing(var_00);
  play_vo(var_00, var_01);
  pause_between_vo(var_00);
  unset_vo_currently_playing();
}

func_7D4E() {
  var_00 = func_E409();

  if(isDefined(var_00))
    return var_00;

  foreach(var_03, var_02 in level.vo_priority_level) {
    var_00 = func_E40A(var_02);

    if(isDefined(var_00))
      return var_00;
  }

  return undefined;
}

func_E409() {
  var_00 = self.vo_system.func_9A89;
  func_E1F9();
  return var_00;
}

func_E1F9() {
  self.vo_system.func_9A89 = undefined;
}

func_E40A(var_00) {
  func_E009(var_00);
  return func_D659(var_00);
}

func_D659(var_00) {
  var_01 = self.vo_system.vo_queue[var_00][0];

  if(!isDefined(var_01))
    return var_01;

  var_02 = [];

  for(var_03 = 1; var_03 < self.vo_system.vo_queue[var_00].size; var_3++) {
    if(!isDefined(self.vo_system.vo_queue[var_00][var_03])) {
      break;
    }
    var_2[var_03 - 1] = self.vo_system.vo_queue[var_00][var_03];
  }

  self.vo_system.vo_queue[var_00] = var_02;
  return var_01;
}

func_E009(var_00) {
  var_01 = gettime();
  var_02 = [];

  foreach(var_05, var_04 in self.vo_system.vo_queue[var_00]) {
    if(!func_134D5(var_04, var_01)) {
      var_2[var_2.size] = self.vo_system.vo_queue[var_00][var_05];
      continue;
    }
  }

  self.vo_system.vo_queue[var_00] = var_02;
}

func_134D5(var_00, var_01) {
  return var_01 > var_0.func_698A;
}

set_vo_system_playing(var_00) {
  self.vo_system.is_playing = var_00;
}

func_9D14() {
  return scripts\engine\utility::is_true(self.func_C9CB);
}

is_vo_system_busy() {
  return scripts\engine\utility::flag("vo_system_busy");
}

set_vo_system_busy(var_00) {
  level.vo_system_busy = var_00;

  if(!var_00)
    scripts\engine\utility::flag_clear("vo_system_busy");
  else
    scripts\engine\utility::flag_set("vo_system_busy");
}

set_vo_currently_playing(var_00) {
  self.vo_system.vo_currently_playing = var_00;
}

game_ended_vo_watcher() {
  var_00 = "";
  level scripts\engine\utility::waittill_any("game_ended");

  foreach(var_02 in level.players) {
    foreach(var_04 in level.vo_priority_level) {
      if(isDefined(var_2.vo_system.vo_queue[var_04]) && var_2.vo_system.vo_queue[var_04].size > 0) {
        foreach(var_06 in var_2.vo_system.vo_queue[var_04]) {
          if(isDefined(var_06)) {
            if(soundexists(var_6.alias))
              var_02 stopolcalsound(var_6.alias);
          }
        }

        var_2.vo_system.vo_queue[var_04] = [];
      }
    }

    if(isDefined(level.dialogue_arr) && level.dialogue_arr.size > 0) {
      foreach(var_10 in level.dialogue_arr) {
        if(issubstr(var_10, "pg_"))
          var_02 stopolcalsound(var_10);

        if(soundexists(var_2.vo_prefix + var_10))
          var_02 stopolcalsound(var_2.vo_prefix + var_10);

        if(soundexists(var_2.vo_prefix + "plr_" + var_10))
          var_02 stopolcalsound(var_2.vo_prefix + "plr_" + var_10);
      }
    }

    if(isDefined(var_2.current_vo_queue) && var_2.current_vo_queue.size > 0) {
      foreach(var_13 in var_2.current_vo_queue) {
        if(isDefined(var_13)) {
          if(soundexists(var_13)) {
            var_02 stopolcalsound(var_13);
            continue;
          }

          if(soundexists(var_2.vo_prefix + var_13)) {
            var_02 stopolcalsound(var_2.vo_prefix + var_13);
            continue;
          }

          if(soundexists(var_2.vo_prefix + "plr_" + var_13))
            var_02 stopolcalsound(var_2.vo_prefix + "plr_" + var_13);
        }
      }
    }

    if(!isDefined(var_2.vo_prefix)) {
      return;
    }
    switch (var_2.vo_prefix) {
      case "p1_":
        var_00 = "_valley_girl";
        break;
      case "p2_":
        var_00 = "_nerd";
        break;
      case "p3_":
        var_00 = "_rapper";
        break;
      case "p4_":
        var_00 = "_jock";
        break;
      case "p5_":
        var_00 = "_jock";
        break;
    }

    var_02 stopolcalsound("mus_zombies" + var_00);
    var_02 stopolcalsound("mus_zombies" + var_00 + "_lsrs");
  }
}

play_vo(var_00, var_01) {
  self endon("interrupt_current_VO");
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  if(self.sessionstate != "playing") {
    return;
  }
  var_02 = var_0.alias;

  if(!soundexists(var_02)) {
    wait 0.1;
    return;
  }

  self.vo_system_playing_vo = 1;

  if(scripts\cp\utility::is_playing_pain_breathing_sfx(self)) {
    var_03 = scripts\cp\utility::get_pain_breathing_sfx_alias(self);

    if(isDefined(var_03))
      self stopolcalsound(var_03);
  }

  if(isDefined(var_0.func_2896))
    var_04 = var_0.func_2896;
  else
    var_04 = var_02;

  foreach(var_06 in level.players) {
    if(var_06 issplitscreenplayer() && !var_06 isreloading()) {
      continue;
    }
    if(isDefined(var_6.current_vo_queue))
      var_6.current_vo_queue = scripts\engine\utility::array_add(var_6.current_vo_queue, var_04);

    if(var_06 == self) {
      if(isDefined(level.get_alias_2d_func))
        var_07 = [
          [level.get_alias_2d_func]
        ](var_06, var_02, var_04);
      else
        var_07 = get_alias_2d_version(var_06, var_02, var_04);

      if(isDefined(var_07))
        var_06 playlocalsound(var_07);
      else
        var_06 playlocalsound(var_02);

      if(scripts\engine\utility::is_true(var_01)) {
        var_08 = var_07 + var_6.vo_suffix;
        var_06 thread alias_specific_vo(var_08);
      }

      continue;
    }

    if(!scripts\engine\utility::is_true(var_0.func_C551))
      self playsoundtoplayer(var_02, var_06);
  }

  foreach(var_11 in var_0.func_3B94)
  level.func_134C0[var_11] = gettime();

  if(!isDefined(self.func_C1F6[var_04]))
    self.func_C1F6[var_04] = 1;
  else
    self.func_C1F6[var_04]++;

  wait(get_sound_length(var_02));
  self notify("play_char_specific_intro");
  self.vo_system_playing_vo = 0;
}

alias_specific_vo(var_00) {
  self endon("disconnected");
  level endon("game_ended");
  self endon("death");
  self waittill("play_char_specific_intro");
  self playlocalsound(var_00);
}

alias_2d_version_exists(var_00, var_01) {
  var_02 = get_alias_2d_version(var_00, var_01);
  return soundexists(var_02);
}

get_alias_2d_version(var_00, var_01, var_02) {
  var_03 = strtok(var_01, "_");

  if(var_3[0] == "ww" || var_3[0] == "dj" || var_3[0] == "ks" || var_3[0] == "el")
    return var_01;
  else {
    var_04 = var_0.vo_prefix + "plr_" + var_02;

    if(soundexists(var_04))
      return var_04;

    return undefined;
  }
}

func_77EE(var_00, var_01) {
  if(issubstr(var_01, "ww_") || issubstr(var_01, "dj_") || issubstr(var_01, "p1_") || issubstr(var_01, "p2_") || issubstr(var_01, "p3_") || issubstr(var_01, "p4_") || issubstr(var_01, "jaroslav_anc"))
    return var_01;

  var_02 = getsubstr(var_01, var_0.vo_prefix.size);
  return var_0.vo_prefix + var_02;
}

get_sound_length(var_00) {
  return lookupsoundlength(var_00) / 1000;
}

pause_between_vo(var_00) {
  if(func_9D14())
    self waittill("unpause_VO_system");

  if(var_0.func_C9CA > 0)
    wait(var_0.func_C9CA);
}

unset_vo_currently_playing() {
  self.vo_system.vo_currently_playing = undefined;
}

try_to_play_vo_on_all_players(var_00, var_01) {
  if(!isDefined(var_00)) {
    return;
  }
  if(!isDefined(level.players)) {
    return;
  }
  if(!scripts\engine\utility::is_true(var_01)) {
    foreach(var_03 in level.players)
    var_03 thread try_to_play_vo(var_00, "zmb_comment_vo", "highest", 10, 0, 0, 1, 100);
  } else {
    foreach(var_03 in level.players)
    var_03 thread add_to_nag_vo(var_00, "zmb_comment_vo", 60, 45, 6, 1);
  }
}

try_to_play_vo(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  var_09 = isDefined(level.vo_alias_data[var_00]);

  if(var_09) {
    if(isDefined(level.vo_alias_data[var_00].chance_to_play))
      var_07 = level.vo_alias_data[var_00].chance_to_play;
  }

  if(!isDefined(var_07))
    var_07 = 100;

  if(randomint(100) > var_07) {
    return;
  }
  if(func_FF79(var_00, var_01, var_02, var_03, var_04, var_05, var_06)) {
    if(var_09 && isDefined(level.vo_alias_data[var_00].func_C9CA))
      var_05 = level.vo_alias_data[var_00].func_C9CA;

    if(var_09 && isDefined(level.vo_alias_data[var_00].func_C555))
      var_06 = level.vo_alias_data[var_00].func_C555;

    var_10 = func_788D(var_00);

    foreach(var_12 in var_10)
    level.func_134C0[var_12] = gettime();

    if(var_09 && isDefined(level.vo_alias_data[var_00].func_32A0))
      var_03 = level.vo_alias_data[var_00].func_32A0;

    if(var_09 && isDefined(level.vo_alias_data[var_00].priority))
      var_02 = level.vo_alias_data[var_00].priority;

    if(var_09 && isDefined(level.vo_alias_data[var_00].func_A9CE))
      level.vo_alias_data[var_00].func_A9CE = gettime();

    thread func_1781(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_08);
  }
}

func_FF79(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(!isDefined(level.vo_alias_data[var_00]))
    return 1;

  if(scripts\cp\zombies\zombie_afterlife_arcade::is_in_afterlife_arcade(self)) {
    if(isDefined(level.func_18E8)) {
      if(![
          [level.func_18E8]
        ](var_00))
        return 0;
    }
  }

  if(scripts\engine\utility::is_true(self.rave_mode)) {
    if(isDefined(level.rave_vo_approve_func)) {
      if(isplayer(self)) {
        if(!self[[level.rave_vo_approve_func]](var_00))
          return 0;
      }
    }
  }

  if(isDefined(level.pap_vo_approve_func)) {
    if(isplayer(self)) {
      if(!self[[level.pap_vo_approve_func]](var_00))
        return 0;
    }
  }

  var_07 = gettime();

  if(isDefined(level.vo_alias_data[var_00].cooldown) && isDefined(level.vo_alias_data[var_00].func_A9CE)) {
    if(var_07 < level.vo_alias_data[var_00].func_A9CE + level.vo_alias_data[var_00].cooldown * 1000)
      return 0;
  }

  var_08 = func_788D(var_00);

  foreach(var_10 in var_08) {
    var_11 = scripts\engine\utility::ter_op(isDefined(level.vo_alias_data[var_00].cooldown), level.vo_alias_data[var_00].cooldown, 30);

    if(var_07 < level.func_134C0[var_10] + var_11 * 1000)
      return 0;
  }

  if(isDefined(level.vo_alias_data[var_00].func_B44F)) {
    if(!isDefined(self.func_C1F6))
      self.func_C1F6 = [];

    if(!isDefined(self.func_C1F6[var_00]))
      self.func_C1F6[var_00] = 0;

    if(self.func_C1F6[var_00] < level.vo_alias_data[var_00].func_B44F)
      return 1;
    else
      return 0;
  } else
    return 1;
}

func_788D(var_00) {
  if(!isDefined(level.func_134BF))
    return [];

  var_01 = getarraykeys(level.func_134BF);
  var_02 = [];

  foreach(var_04 in var_01) {
    if(scripts\engine\utility::array_contains(level.func_134BF[var_04], var_00))
      var_2[var_2.size] = var_04;
  }

  return var_02;
}

should_append_player_prefix(var_00) {
  if(issubstr(var_00, "ww_") || issubstr(var_00, "dj_") || issubstr(var_00, "jaroslav_anc"))
    return 0;
  else
    return 1;
}

should_append_player_suffix(var_00, var_01) {
  if(scripts\engine\utility::is_true(var_01)) {
    if(issubstr(var_00, "ww_") && issubstr(var_00, "_p"))
      return 1;
    else
      return 0;
  }

  return 0;
}

func_1781(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  if(isplayer(self)) {
    if(isDefined(var_01) && isDefined(level.vo_functions[var_01])) {
      if(isDefined(var_07))
        self thread[[level.vo_functions[var_01]]](var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07);
      else
        self thread[[level.vo_functions[var_01]]](var_00, var_01, var_02, var_03, var_04, var_05, var_06);

      return;
    } else {
      var_08 = self.vo_prefix + var_00;
      thread play_vo_on_player(var_08, var_02, var_03, var_04, var_05, var_06, var_00);
    }
  } else if(isDefined(var_01) && isDefined(level.vo_functions[var_01])) {
    if(isDefined(var_07))
      self thread[[level.vo_functions[var_01]]](var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07);
    else
      self thread[[level.vo_functions[var_01]]](var_00, var_01, var_02, var_03, var_04, var_05, var_06);

    return;
  } else {
    var_08 = var_00;
    level thread func_CE89(var_08, var_02, var_03, var_04, var_05, var_06, var_00);
  }
}

func_CE89(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  foreach(var_08 in level.players)
  var_08 func_1782(var_00, var_01, var_02, var_03, var_04, var_05, var_06);
}

play_vo_on_player(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  func_1782(var_00, var_01, var_02, var_03, var_04, var_05, var_06);
}

func_1782(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(!isDefined(self.current_vo_queue))
    self.current_vo_queue = [];

  thread func_1783(var_00, var_01, var_02, var_03, var_04, var_05, var_06);
}

func_1783(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  var_01 = func_7D3E(var_01);
  var_07 = create_vo_data(var_00, var_02, var_04, var_05, var_06);

  if(func_FF5B(var_03)) {
    func_1767(var_07);

    if(func_9D15())
      func_9A85();
  } else
    func_1777(var_07, var_01);

  if(!func_9D15())
    func_C14E();
}

func_7D3E(var_00) {
  if(!isDefined(var_00))
    return level.vo_priority_level[level.vo_priority_level.size - 1];

  return var_00;
}

create_vo_data(var_00, var_01, var_02, var_03, var_04) {
  var_05 = 999;
  var_06 = 1.5;
  var_07 = 3;
  var_08 = spawnStruct();
  var_8.alias = var_00;
  var_8.func_3B94 = func_788D(var_00);
  var_8.func_2896 = var_04;

  if(!isDefined(var_01))
    var_01 = var_05;

  var_8.func_698A = gettime() + var_01 * 1000;

  if(!isDefined(var_02))
    var_02 = randomfloatrange(var_06, var_07);

  var_8.func_C9CA = var_02;

  if(scripts\engine\utility::is_true(var_03))
    var_8.func_C551 = 1;
  else
    var_8.func_C551 = 0;

  return var_08;
}

func_FF5B(var_00) {
  return isDefined(var_00) && var_00;
}

func_1767(var_00) {
  self.vo_system.func_9A89 = var_00;
}

func_9D15() {
  return scripts\engine\utility::is_true(self.vo_system.is_playing);
}

func_9A85() {
  var_00 = func_790D();

  if(isDefined(var_00))
    self stopolcalsound(var_00);

  self notify("interrupt_current_VO");
}

func_790D() {
  if(isDefined(self.vo_system)) {
    if(isDefined(self.vo_system.vo_currently_playing)) {
      if(isDefined(self.vo_system.vo_currently_playing.alias))
        return self.vo_system.vo_currently_playing.alias;
    }
  }

  return undefined;
}

func_1777(var_00, var_01) {
  self.vo_system.vo_queue[var_01][self.vo_system.vo_queue[var_01].size] = var_00;
}

func_C14E() {
  self notify("play_VO_system");
}

func_E0A9(var_00, var_01) {
  var_02 = [];

  foreach(var_05, var_04 in self.vo_system.vo_queue[var_01]) {
    if(!(var_4.alias == self.vo_prefix + var_00 || var_4.alias == self.vo_prefix + "plr_" + var_00))
      var_2[var_2.size] = self.vo_system.vo_queue[var_01][var_05];
  }

  self.vo_system.vo_queue[var_01] = var_02;
}

func_C9CB(var_00) {
  if(var_0.size == 1)
    var_0[0].func_C9CB = 1;
  else {
    foreach(var_02 in var_00)
    var_2.func_C9CB = 1;
  }
}

func_12BE3(var_00) {
  foreach(var_02 in var_00)
  var_2.func_C9CB = 0;

  foreach(var_02 in var_00)
  var_02 notify("unpause_VO_system");
}

func_BE3E() {
  level endon("game_ended");

  if(!isDefined(level.func_BE3D)) {
    level.func_BE3D = [];
    level.func_BE3F = [];
    level.pause_nag_vo = 0;
  }

  var_00 = 60;

  for(;;) {
    while(level.pause_nag_vo)
      wait 0.1;

    var_01 = gettime();

    foreach(var_04, var_03 in level.func_BE3D) {
      if(var_01 > var_3.next_play_time) {
        if(isDefined(var_3.func_EC12))
          var_3.func_EC12 try_to_play_vo(var_04, var_3.func_1351C, "low", 3, 0, 0, var_3.func_C551);
        else
          level try_to_play_vo(var_04, var_3.func_1351C, "low", 3, 0, 0, var_3.func_C551);

        var_3.func_11923++;

        if(var_3.func_B468 != -1 && var_3.func_B468 <= var_3.func_11923)
          remove_from_nag_vo(var_04);

        var_3.next_play_time = var_01 + var_3.cooldown * min(var_3.func_11923, 3) * 1000;
        wait(var_00);
      }
    }

    wait 1;
  }
}

add_to_nag_vo(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(!isDefined(level.func_BE3D)) {
    level.func_BE3D = [];
    level.func_BE3F = [];
    level.pause_nag_vo = 0;
  }

  if(isDefined(level.func_BE3D[var_00])) {
    return;
  }
  if(isDefined(level.func_BE3F[var_00])) {
    return;
  }
  if(!isDefined(var_02))
    var_02 = 60;

  if(!isDefined(var_01))
    var_01 = "zmb_comment_vo";

  var_06 = undefined;

  if(isplayer(self))
    var_06 = self;

  var_07 = spawnStruct();
  var_7.func_11923 = 0;
  var_7.cooldown = var_02;
  var_7.func_1351C = var_01;

  if(isDefined(var_06))
    var_7.func_EC12 = var_06;

  if(isDefined(var_05))
    var_7.func_C551 = var_05;
  else
    var_7.func_C551 = 0;

  if(isDefined(var_03))
    var_7.next_play_time = gettime() + var_03 * 1000;
  else
    var_7.next_play_time = 0;

  if(isDefined(var_04))
    var_7.func_B468 = var_04;
  else
    var_7.func_B468 = -1;

  level.func_BE3D[var_00] = var_07;
}

remove_from_nag_vo(var_00, var_01) {
  level.func_BE3D = scripts\cp\utility::array_remove_index(level.func_BE3D, var_00, 1);

  if(scripts\engine\utility::is_true(var_01))
    level.func_BE3F[var_00] = 1;
}

timeoutvofunction(var_00, var_01) {
  level endon(var_00 + "_about_to_play");
  wait(var_01);
  level.announcer_vo_playing = 0;
  level notify(var_00 + "_timed_out");
}