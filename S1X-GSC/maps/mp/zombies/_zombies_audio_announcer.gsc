/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\_zombies_audio_announcer.gsc
********************************************************/

initannouncer() {
  var_0 = spawn("script_model", (0, 0, 0));
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("announcer", "comp_", var_0, 0);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "exo_suit_avail", "exo_suit_avail", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "exo_online", "exo_online", "general,thanks");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "hyper_dmg", "hyper_dmg", "powerup,insta_kill");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "dna_bomb", "dna_bomb", "powerup,apocalypse");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "pow_surge", "pow_surge", "powerup,pow_surge");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "full_reload", "full_reload", "powerup,max_ammo");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "multiplier", "multiplier", "powerup,2x_pts");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "security", "security", "powerup,traps");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "zombie_dog", "mongrel", "general,dog_round");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "zombie_host", "host", "general,host_round");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "host_turn", "host_turn", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global", "door", "door", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global", "printer", "printer_bk", "general,printer_moved");

  if(maps\mp\zombies\_util::getzombieslevelnum() == 1) {
    level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global", "power_labs_01", "pow_mg", "general,power_on");
    level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global", "power_roundabout_01", "pow_mh", "general,power_on");
    level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global", "power_barracks_01", "pow_ha", "general,power_on");
    level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global", "power_admin_01", "pow_am", "general,power_on");
  }

  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "machine_all_players", "host_cure", "cure", "general,cured");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "machine_all_players", "host_cure2", "cure2", undefined, 30);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "machine_all_players", "laser_trap", "trap", "general,laser_traps", 40);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "machine_all_players", "jackpot", "cash_ee", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "machine_per_player", "specialty_fastreload", "exo_reload", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "machine_per_player", "exo_health", "exo_health", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "machine_per_player", "exo_revive", "exo_medic", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "machine_per_player", "exo_stabilizer", "exo_soldier", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "machine_per_player", "exo_slam", "exo_slam", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "machine_per_player", "wallbuy", "wallbuy", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "machine_per_player", "printer", "printer", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "machine_per_player", "weapon_upgrade", "wpn_upgd", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "machine_per_player", "power_switch", "pwr_swtich", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "an_conv", "an_conv_1", "an_conv_1a", "an_conv,an_conv_1b");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "an_conv", "an_conv_1c", "an_conv_1c", "an_conv,an_conv_1d");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "an_conv", "an_conv_2b", "an_conv_2b", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "an_conv", "an_conv_3b", "an_conv_3b", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "an_conv", "an_conv_4b", "an_conv_4b", "an_conv,an_conv_4c");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "an_conv", "an_conv_4d", "an_conv_4d", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "an_conv", "an_conv_5b", "an_conv_5b", "an_conv,an_conv_5c");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "an_conv", "an_conv_5d", "an_conv_5d", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "an_conv", "an_conv_6", "an_conv_6a", "an_conv,an_conv_6b");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "an_conv", "an_conv_6c", "an_conv_6c", "an_conv,an_conv_6d");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "an_conv", "an_conv_7b", "an_conv_7b", "an_conv,an_conv_7c");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "an_conv", "an_conv_7d", "an_conv_7d", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "an_conv", "an_conv_8", "an_conv_8a", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "an_conv", "an_conv_9", "an_conv_9a", "an_conv,an_conv_9b");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "an_conv", "an_conv_9c", "an_conv_9c", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "an_conv", "an_conv_10", "an_conv_10a", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "an_conv", "an_conv_11", "an_conv_11a", "an_conv,an_conv_11b");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "an_conv_repeat", "an_conv_12", "an_conv_12a", "an_conv_12b");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "an_conv_repeat", "an_conv_12b", "an_conv_12b", undefined);
  level.allowzmbannouncer = 1;
  level thread terminalsactivatedmonitor();
  level thread terminalattractormonitor();
  level thread monitorkiting();
}

isannouncer(var_0) {
  return issubstr(var_0.zmbvoxid, "announcer");
}

getannouncer() {
  return level.vox.speaker["announcer"].ents[0];
}

getannouncers(var_0) {
  var_1 = [];
  var_2 = getarraykeys(level.vox.speaker);

  foreach(var_4 in var_2) {
    if(isDefined(var_0) && !issubstr(var_4, var_0)) {
      continue;
    }
    if(issubstr(var_4, "announcer")) {
      var_1[var_1.size] = level.vox.speaker[var_4].ents[0];
    }
  }

  return var_1;
}

isannouncerspeaking() {
  var_0 = getannouncer();
  return maps\mp\zombies\_util::is_true(var_0.isspeaking);
}

isannouncinground() {
  var_0 = getannouncer();
  return maps\mp\zombies\_util::is_true(var_0.isspeaking) && isDefined(var_0.speakingline) && issubstr(var_0.speakingtype, "zombie_");
}

waittillannouncerdonespeaking() {
  if(isannouncerspeaking()) {
    var_0 = getannouncer();
    var_0 waittill("done_speaking");
  }
}

isanyannouncerspeaking() {
  var_0 = getannouncers();

  foreach(var_2 in var_0) {
    if(maps\mp\zombies\_util::is_true(var_2.isspeaking)) {
      return 1;
    }
  }

  return 0;
}

waittillallannouncersdonespeaking() {
  var_0 = getannouncers();

  for(;;) {
    var_1 = 0;

    foreach(var_3 in var_0) {
      if(maps\mp\zombies\_util::is_true(var_3.isspeaking)) {
        var_1 = 1;
        break;
      }
    }

    if(!var_1) {
      break;
    }

    waitframe();
  }
}

announcerglobaldialogdelay(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  wait(var_2);
  return announcerglobaldialog(var_0, var_1, var_3, var_4, var_5, var_6, var_7);
}

announcerglobaldialog(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = getannouncer();
  return var_7 maps\mp\zombies\_zombies_audio::create_and_play_dialog(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

announcerinworlddialogdelay(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  wait(var_3);
  return announcerinworlddialog(var_0, var_1, var_2, var_4, var_5, var_6, var_7, var_8);
}

announcerinworlddialog(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = getannouncer();
  var_8.origin = var_2;
  return var_8 maps\mp\zombies\_zombies_audio::create_and_play_dialog(var_0, var_1, var_3, var_4, var_5, var_6, var_7);
}

playannouncerdialog(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("stopSpeaking");
  self endon("death");
  self.speakingline = var_2;
  self.speakingcategory = var_3;
  self.speakingtype = var_4;
  self.isspeaking = 1;
  self notify("speaking");
  playannouncementwaituntildone(var_2, var_3, var_8);

  if(var_0 == "beauford_" || var_0 == "zombie_") {
    wait 1;
  }

  self notify("done_speaking");
  level notify("done_speaking");

  if(isDefined(self.classname)) {
    self stopsounds();
  }

  self.isspeaking = 0;

  if(maps\mp\zombies\_util::is_true(var_5)) {
    return;
  }
  if(isDefined(level.vox.speaker[self.zmbvoxid].response) && isDefined(level.vox.speaker[self.zmbvoxid].response[var_3]) && isDefined(level.vox.speaker[self.zmbvoxid].response[var_3][var_4])) {
    level thread setup_response_line_to_announcer(self, var_6, var_3, var_4);
  } else if(isDefined(level.zmbcustomresponsetoannouncer)) {
    level thread[[level.zmbcustomresponsetoannouncer]](self, var_6, var_3, var_4, var_8);
  }
}

announcercategoryisplaylocal(var_0) {
  return var_0 == "global_priority" || issubstr(var_0, "an_conv") || var_0 == "global";
}

playannouncementwaituntildone(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = level.players;
  }

  var_2 = common_scripts\utility::array_removeundefined(var_2);

  if(announcercategoryisplaylocal(var_1)) {
    foreach(var_4 in var_2) {
      var_4 playlocalsound(var_0);
    }
  } else {
    if(var_2.size > 0 && var_2.size < level.players.size) {
      self hide();

      foreach(var_4 in var_2) {
        self showtoplayer(var_4);
      }
    } else {
      self show();
    }

    self playsoundonmovingent(var_0);
  }

  var_8 = maps\mp\zombies\_zombies_audio::volength(var_0, var_1);
  wait(var_8);
}

setup_response_line_to_announcer(var_0, var_1, var_2, var_3) {
  if(var_2 == "an_conv_repeat") {
    var_3 = level.vox.speaker[var_0.zmbvoxid].response[var_2][var_3];
    var_0 maps\mp\zombies\_zombies_audio::create_and_play_dialog(var_2, var_3, "");
    return;
  }

  if(!isDefined(var_1)) {
    if(announcercategoryisplaylocal(var_2)) {
      var_1 = level.players[randomintrange(0, level.players.size)];
    } else {
      var_1 = maps\mp\zombies\_zombies_audio::getrandomcharacterinrange(var_0);
    }
  }

  if(isDefined(level.zmbaudioresponsetoannounceroverridefunc) && [[level.zmbaudioresponsetoannounceroverridefunc]](var_0, var_1, var_2, var_3)) {
    return;
  }
  if(isDefined(var_1)) {
    var_4 = level.vox.speaker[var_0.zmbvoxid].response[var_2][var_3];
    var_5 = strtok(var_4, ",");

    if(var_5.size == 2) {
      var_2 = var_5[0];
      var_3 = var_5[1];

      if(var_2 == "an_conv") {
        var_6 = common_scripts\utility::array_randomize(level.players);

        foreach(var_1 in var_6) {
          var_8 = var_1 maps\mp\zombies\_zombies_audio::create_and_play_dialog(var_2, var_3, "");

          if(var_8) {
            break;
          }
        }
      } else {
        var_1 maps\mp\zombies\_zombies_audio::create_and_play_dialog(var_2, var_3, "");
      }
    }
  }
}

announcerexoonlinedialog() {
  thread announcerglobaldialog("global_priority", "exo_online", undefined, undefined, undefined, undefined, level.players);
}

announcerglobalattractordialog(var_0, var_1) {
  thread announcerglobaldialog("global_priority", var_0, undefined, undefined, undefined, undefined, var_1);
}

announcerpickupdialog(var_0, var_1) {
  thread announcerglobaldialogdelay("global_priority", var_0, 0.5, undefined, undefined, undefined, var_1, level.players);
}

announcerrounddialog(var_0) {
  thread announcerglobaldialogdelay("global_priority", var_0, 0.5, undefined, undefined, undefined, undefined, level.players);
}

announcerhostturndialog() {
  thread announcerglobaldialogdelay("global_priority", "host_turn", 1, undefined, undefined, undefined, undefined, level.players);
}

announcerdoordialog() {
  thread announcerglobaldialogdelay("global", "door", 1, undefined, undefined, undefined, undefined, level.players);
}

announcerprintermoveddialog() {
  thread announcerglobaldialogdelay("global", "printer", 0.5, undefined, undefined, undefined, undefined, level.players);
}

announcerpoweronlinedialog(var_0) {
  thread announcerglobaldialogdelay("global", var_0, 0.5, undefined, undefined, undefined, undefined, level.players);
}

terminalsactivatedmonitor() {
  level.zmannouncerhostcuredebounce = 0;

  for(;;) {
    var_0 = level common_scripts\utility::waittill_any_return_parms("terminal_player", "terminal_complete");

    if(!isDefined(var_0) || var_0.size < 2) {
      continue;
    }
    var_1 = var_0[0];
    var_2 = var_0[1];
    var_3 = var_0[2];

    if(var_1 == "terminal_player") {
      var_4 = var_0[2];

      if(var_2 == "host_cure") {
        if(gettime() < level.zmannouncerhostcuredebounce) {
          continue;
        }
        var_5 = announcerinworlddialogdelay("machine_all_players", var_2, var_3, 1.5);

        if(var_5) {
          level.zmannouncerhostcuredebounce = gettime() + 15000;
        }
      }

      continue;
    }

    if(var_1 == "terminal_complete") {
      if(var_2 == "host_cure") {
        if(gettime() < level.zmannouncerhostcuredebounce) {
          continue;
        }
        var_5 = announcerinworlddialogdelay("machine_all_players", var_2 + "2", var_3, 1.5);

        if(var_5) {
          level.zmannouncerhostcuredebounce = gettime() + 15000;
        }
      }
    }
  }
}

announcertrapstarteddialog(var_0) {
  if(isDefined(level.zmannouncertrapdebounce) && gettime() < level.zmannouncertrapdebounce) {
    return;
  }
  var_1 = announcerinworlddialogdelay("machine_all_players", "laser_trap", var_0, 0.5);

  if(var_1) {
    level.zmannouncertrapdebounce = gettime() + 30000;
  }
}

announcerjackpotdialog(var_0) {
  thread announcerinworlddialogdelay("machine_all_players", "jackpot", var_0, 0.5);
}

terminalattractormonitor() {
  if(isDefined(level.zmbaudioattractorwait)) {
    wait(level.zmbaudioattractorwait);
  }

  var_0 = getEntArray("perk_terminal", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread _terminalattractormonitor(var_2.itemtype, 300, 80);
  }

  var_4 = getEntArray("wallbuy", "targetname");

  foreach(var_6 in var_4) {
    var_6 thread _terminalattractormonitor("wallbuy", 150, 80);
  }

  var_8 = getEntArray("magic_box", "targetname");

  foreach(var_6 in var_8) {
    var_6 thread _terminalattractormonitor("printer", 250, 80);
  }

  var_11 = getEntArray("weapon_level_box", "targetname");

  foreach(var_6 in var_11) {
    var_6 thread _terminalattractormonitor("weapon_upgrade", 300, 80);
  }

  var_14 = common_scripts\utility::getStructArray("power_switch", "targetname");

  foreach(var_16 in var_14) {
    var_16 thread _terminalattractormonitor("power_switch", 150, 80);
  }
}

_terminalattractormonitor(var_0, var_1, var_2) {
  if(maps\mp\zombies\_util::is_true(self.noattract)) {
    return;
  }
  var_3 = cos(var_2);
  var_4 = var_1 * var_1;

  if(var_0 == "host_cure") {
    return;
  }
  if(maps\mp\zombies\_util::getzombieslevelnum() == 3 && var_0 == "exo_tacticalArmor") {
    return;
  }
  level waittill("player_spawned");

  if(var_0 == "power_switch") {
    wait 8;
  }

  for(;;) {
    waitframe();

    if(isDefined(self.script_flag_true)) {
      common_scripts\utility::flag_wait(self.script_flag_true);

      if(isDefined(self.postpowerattractorwait)) {
        wait(self.postpowerattractorwait);
        self.postpowerattractorwait = undefined;
      }
    }

    if(maps\mp\zombies\_util::is_true(self.trigger_off)) {
      if(isDefined(self.claimed) && !self.claimed) {
        self waittill("claimed");
      }

      continue;
    }

    if(var_0 == "printer" && (!isDefined(self.active) || !self.active)) {
      wait 1;
      continue;
    }

    if(isannouncerspeaking()) {
      waittillannouncerdonespeaking();
      wait 1;
      continue;
    }

    var_5 = _getplayerlistforattractor(self, var_0);

    if(var_5.size == 0) {
      return;
    }
    var_6 = _getplayersinattractorrange(self, var_5, var_4, var_3);

    if(var_6.size == 0) {
      continue;
    }
    if(isDefined(self.firsttimeattractorwait)) {
      wait(self.firsttimeattractorwait);
      self.firsttimeattractorwait = undefined;
    }

    var_7 = announcerinworlddialog("machine_per_player", var_0, self.origin, undefined, undefined, undefined, undefined, var_6);

    if(var_7) {
      foreach(var_9 in var_6) {
        var_9 _playersetattractor(var_0);
      }
    }
  }
}

_getplayerlistforattractor(var_0, var_1) {
  var_2 = [];

  if(isDefined(var_0.claimed)) {
    if(var_0.claimed && isDefined(var_0.claimedby) && !var_0.claimedby _playerplayedattractor(var_1)) {
      var_2[0] = var_0.claimedby;
    }
  } else {
    foreach(var_4 in level.players) {
      if(!var_4 _playerplayedattractor(var_1)) {
        var_2[var_2.size] = var_4;
      }
    }
  }

  return var_2;
}

_getplayersinattractorrange(var_0, var_1, var_2, var_3) {
  var_4 = [];

  if(level.nextgen) {} else {}

  foreach(var_6 in var_1) {
    var_7 = abs(var_6.origin[2] - var_0.origin[2]);

    if(!maps\mp\zombies\_util::isplayerinfected(var_6) && var_7 < 100 && distancesquared(var_6.origin, var_0.origin) < var_2) {
      if(level.nextgen) {
        var_8 = anglesToForward(var_0.modelent.angles);
        var_9 = vectornormalize(var_6.origin - var_0.modelent.origin);
        var_10 = vectordot(var_8, var_9);

        if(var_10 > var_3) {
          var_4[var_4.size] = var_6;
        }

        continue;
      }

      var_4[var_4.size] = var_6;
    }
  }

  return var_4;
}

_playersetattractor(var_0) {
  if(!isDefined(self.attractorsvo)) {
    self.attractorsvo = [];
  }

  self.attractorsvo[var_0] = 1;
}

_playerplayedattractor(var_0) {
  return isDefined(self.attractorsvo) && isDefined(self.attractorsvo[var_0]) && self.attractorsvo[var_0];
}

monitorkiting() {
  if(!isDefined(level.numkitingconversations)) {
    level.numkitingconversations = 12;
  }

  if(level.numkitingconversations == 0) {
    return;
  }
  level.kitingconversations = [];

  for(var_0 = 1; var_0 <= level.numkitingconversations; var_0++) {
    level.kitingconversations[level.kitingconversations.size] = var_0;
  }

  if(!maps\mp\zombies\_util::is_true(level.zmbaudioskiprandomizingkitingvo)) {
    level.kitingconversations = common_scripts\utility::array_randomize(level.kitingconversations);
  }

  if(!isDefined(level.zmbaudiokitingstartwave)) {
    level.zmbaudiokitingstartwave = 4;
  }

  for(;;) {
    level waittill("zombie_wave_started");

    if(level.kitingconversations.size == 0) {
      return;
    }
    if(level.wavecounter < level.zmbaudiokitingstartwave) {
      continue;
    }
    waitframe();

    while(level.zombie_spawning_active) {
      wait 1;
    }

    var_1 = maps\mp\zombies\zombies_spawn_manager::getnumberofzombies();

    for(;;) {
      if(var_1 == 0) {
        break;
      } else if(var_1 == 1) {
        if(isDefined(level.zmbaudiokitingcustom)) {
          thread[[level.zmbaudiokitingcustom]]();
        } else {
          thread _kitingplayrandomvo();
        }

        break;
      }

      var_1 = maps\mp\zombies\zombies_spawn_manager::getnumberofzombies();
      waitframe();
    }
  }
}

_kitingplayrandomvo() {
  level endon("zombie_wave_ended");
  wait(randomintrange(15, 30));
  var_0 = level.kitingconversations.size - 1;
  var_1 = level.kitingconversations[var_0];
  var_2 = "an_conv";
  var_3 = "an_conv_" + var_1;
  var_4 = 0;

  if(isDefined(level.vox.speaker["player"].alias[var_2]) && isDefined(level.vox.speaker["player"].alias[var_2][var_3])) {
    var_5 = common_scripts\utility::array_randomize(level.players);

    foreach(var_7 in var_5) {
      maps\mp\zombies\_zombies_audio::waituntilquietnearby(var_7, var_2);
      var_8 = var_7 maps\mp\zombies\_zombies_audio::create_and_play_dialog(var_2, var_3);

      if(var_8) {
        break;
      }
    }
  } else if(isDefined(level.vox.speaker["announcer"].alias[var_2]) && isDefined(level.vox.speaker["announcer"].alias[var_2][var_3])) {
    var_10 = getannouncer();
    maps\mp\zombies\_zombies_audio::waituntilquietnearby(var_10, var_2);
    var_10 maps\mp\zombies\_zombies_audio::create_and_play_dialog(var_2, var_3, undefined, undefined, undefined, level.player, level.players);
  } else {}

  level.kitingconversations[var_0] = undefined;
}