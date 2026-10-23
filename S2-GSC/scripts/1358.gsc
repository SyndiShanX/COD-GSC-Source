/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1358.gsc
**************************************/

init() {
  level _id_AB19();
  level thread _id_0554::init();

  if(isDefined(level._id_0793)) {
    level thread[[level._id_0793]]();
  }

  if(isDefined(level._id_0792)) {
    level thread[[level._id_0792]]();
  }

  if(!isDefined(level.zmbsoundlengthpath)) {
    level.zmbsoundlengthpath = "mp/sound/soundlength_zm_mp.csv";
  }

  level.zmbglobalpriorityvoonly = 0;
}

_id_AB19() {
  level.vox = zmbvoxcreate();
  level.vox zmbvoxadd("player", "ability", "special_camo", "camouflage", undefined);
  level.vox zmbvoxadd("player", "ability", "special_mad", "freefire", undefined);
  level.vox zmbvoxadd("player", "ability", "special_taunt", "frontline", undefined);
  level.vox zmbvoxadd("player", "ability", "special_burst", "shellshock", undefined);
  level.vox zmbvoxadd("player", "mod_use", "mod_supplyammo", "supplyammomod", "thanks");
  level.vox zmbvoxadd("player", "mod_use", "mod_headshot", "headshotmod", "mod_headshot_reply");
  level.vox zmbvoxadd("player", "mod_use", "mod_headshot_reply", "headshot_reply", undefined);
  level.vox zmbvoxadd("player", "mod_use", "mod_serratededge", "serreatededgemod", undefined);
  level.vox zmbvoxadd("player", "mod_use", "mod_enhancedspeed", "enhancedspeedmod", undefined);
  level.vox zmbvoxadd("player", "mod_use", "mod_covertexfiltration", "covertexfilration", "revived");
  level.vox zmbvoxadd("player", "mod_use", "mod_saboteur", "saboteur", undefined);
  level.vox zmbvoxadd("player", "mod_use", "mod_fieryburst", "fieryburstmod", undefined);
  level.vox zmbvoxadd("player", "mod_use", "mod_exploitweakness", "exploitweaknessmod", undefined);
  level.vox zmbvoxadd("player", "mod_use", "mod_supplyarmor", "givearmormod", "thanks2");
  level.vox zmbvoxadd("player", "mod_use", "mod_comeandgetit", "comeandgetitmod", undefined);
  level.vox zmbvoxadd("player", "mod_use", "mod_counteroffensive", "counteroffensivemod", undefined);
  level.vox zmbvoxadd("player", "mod_use", "mod_teameffort", "teameffort", undefined);
  level.vox zmbvoxadd("player", "general", "revive_ally", "modrevived", "revived");
  level.vox zmbvoxadd("player", "general", "revived", "modrevived_reply", undefined);
  level.vox zmbvoxadd("player", "general", "give_money", "givemoney", undefined, 25);
  level.vox zmbvoxadd("player", "general", "needmoney", "givemoneyv1", undefined);
  level.vox zmbvoxadd("player", "general", "nag_stop_killing", "nagstopkilling", undefined);
  level.vox zmbvoxadd("player", "general", "thanks", "supplyammod_reply", undefined);
  level.vox zmbvoxadd("player", "general", "thanks2", "givearmormod_reply", undefined);
  level.vox zmbvoxadd("player", "general", "got_item", "explosivehandler_reply", undefined);
  level.vox zmbvoxadd("player", "general", "got_item2", "givemoney_reply", undefined);
  level.vox zmbvoxadd("player", "enemy", "treasurezombieseen", "treasurezombieseen", undefined);
  level.vox zmbvoxadd("player", "enemy", "treasurezombiemove", "treasurezombiemove", undefined);
  level.vox zmbvoxadd("player", "enemy", "treasurezombiefail", "treasurezombiefail", undefined);
  level.vox zmbvoxadd("player", "enemy", "treasurezombiewarn", "treasurezombiewarn", undefined);
  level.vox zmbvoxadd("player", "enemy", "treasurezombiewin", "treasurezombiewin", undefined);
  level.vox zmbvoxadd("player", "enemy", "bombersee", "bombersee", undefined, 5);
  level.vox zmbvoxadd("player", "enemy", "bomberkillshot", "bomberskillshot", undefined, 25);
  level.vox zmbvoxadd("player", "enemy", "sprintersee", "sprintersee", undefined, 1);
  level.vox zmbvoxadd("player", "enemy", "followersurpise", "followersurpise", undefined, 25);
  level.vox zmbvoxadd("player", "enemy", "followeranger", "lookout", undefined, 25);
  level.vox zmbvoxadd("player", "enemy", "firemansee", "firemanfearreact", undefined, 100);
  level.vox zmbvoxadd("player", "perk", "perk_first", "vendingfirsttime", undefined);
  level.vox zmbvoxadd("player", "perk", "perk_ouch", "plr_scripted_pain_lev3_", undefined);
  level.vox zmbvoxadd("player", "perk", "perk_shock", "blitzshock", undefined);
  level.vox zmbvoxadd("player", "perk", "perk_punch", "blitzpunch", undefined);
  level.vox zmbvoxadd("player", "general", "zmb_char_callout", "zmb_char_callout", undefined);
  level._id_AB0E = [];
  level._id_AB0E["prefix"] = "zmb_";
  level._id_AB0E["zombie_generic"] = [];
  level._id_AB0E["zombie_generic"]["idle_low"] = "gen_idle_low";
  level._id_AB0E["zombie_generic"]["idle_high"] = "gen_idle_high";
  level._id_AB0E["zombie_generic"]["move"] = "gen_scream";
  level._id_AB0E["zombie_generic"]["attack"] = "gen_scream";
  level._id_AB0E["zombie_generic"]["spawn"] = "gen_spawn";
  level._id_AB0E["zombie_generic"]["taunt"] = "gen_scream";
  level._id_AB0E["zombie_generic"]["behind"] = "gen_behind";
  level._id_AB0E["zombie_generic"]["pain"] = "gen_pain";
  level._id_AB0E["zombie_dog"] = [];
  level._id_AB0E["zombie_dog"]["idle"] = "dog_idle";
  level._id_AB0E["zombie_dog"]["attack"] = "dog_bite";
  level._id_AB0E["zombie_dog"]["spawn"] = "dog_spawn";
  level._id_AB0E["zombie_dog"]["behind"] = "dog_behind";
  level._id_AB0E["zombie_dog"]["pain"] = "dog_pain";
  level._id_AB0E["zombie_host"] = [];
  level._id_AB0E["zombie_host"]["idle_low"] = "hst_scream";
  level._id_AB0E["zombie_host"]["idle_high"] = "hst_scream";
  level._id_AB0E["zombie_host"]["move"] = "hst_scream";
  level._id_AB0E["zombie_host"]["attack"] = "hst_attack_scream";
  level._id_AB0E["zombie_host"]["spawn"] = "hst_scream";
  level._id_AB0E["zombie_host"]["taunt"] = "hst_scream";
  level._id_AB0E["zombie_host"]["behind"] = "hst_behind";
  level._id_AB0E["zombie_host"]["pain"] = "hst_scream";
}

_id_5165() {
  thread _id_73AA();
  thread player_zombie_char_ambient_noises();
}

_id_717E(var_0, var_1, var_2, var_3, var_4) {
  self endon("disconnect");
  self endon("stopSpeaking");
  var_5 = 0.25;
  self.speakingline = var_0;
  self.isspeaking = 1;
  self notify("speaking");
  var_6 = undefined;

  if(isDefined(var_3)) {
    var_6 = level.players;
  }

  if(var_2 == "zmb_char_callout") {
    _id_0378::_id_307E("plr_zom_zde_callout", var_6);
  } else if(var_2 == "perk_ouch") {
    _id_0378::_id_307E(var_0 + _id_0378::_id_307B(self.characterindex), var_6);
  } else if(common_scripts\utility::_id_562E(var_4)) {
    var_7 = _id_0367::_id_8EA0();
    var_8 = var_0 + var_7;

    if(_soundexists(var_8)) {
      _id_0378::_id_307E(var_8, var_6);
    } else if(_soundexists(var_0)) {
      _id_0378::_id_307E(var_0, var_6);
    }
  } else
    _id_0367::_id_8E3C(var_0, var_6);

  if(var_5 > 0) {
    wait(var_5);
  }

  self notify("done_speaking");
  level notify("done_speaking");
  self.isspeaking = 0;

  if(isDefined(level.vox.speaker[self.zmbvoxid].response) && isDefined(level.vox.speaker[self.zmbvoxid].response[var_1]) && isDefined(level.vox.speaker[self.zmbvoxid].response[var_1][var_2])) {
    level thread _id_89B1(self, var_1, var_2, var_3);
  }
}

_id_2780(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  self endon("disconnect");
  wait(var_0);
  thread _id_277F(var_1, var_2, var_3, var_4, var_5);
}

_id_277F(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("disconnect");

  if(!isDefined(self.zmbvoxid)) {
    return 0;
  }

  if(common_scripts\utility::_id_562E(self.dontspeak)) {
    return 0;
  }

  if(!isDefined(self.isspeaking)) {
    self.isspeaking = 0;
  }

  if(common_scripts\utility::_id_562E(self.isspeaking)) {
    return 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!var_3 && !can_event_play(self.zmbvoxid, var_0, var_1)) {
    return 0;
  }

  var_5 = "player";
  var_6 = undefined;
  var_7 = undefined;
  var_8 = 0;

  if(isshipzombiesmap()) {
    var_9 = _id_0367::_id_8E9F();

    if(!isDefined(var_9)) {
      return 0;
    }

    var_7 = level.vox.speaker[var_5]._id_0BB4[var_0][var_1];
    var_6 = var_9 + var_7;

    if(_soundexists(var_6 + "_lo") || _soundexists(var_6 + "_md") || _soundexists(var_6 + "_hi")) {
      var_10 = 1;
    }
  } else {
    var_11 = get_viable_gbl_aliases(var_5, var_0, var_1, self);

    if(var_11.size > 0) {
      var_7 = common_scripts\utility::random(var_11);
      var_8 = 1;
    } else if(var_1 == "perk_ouch")
      var_7 = level.vox.speaker[var_5]._id_0BB4[var_0][var_1];
    else if(!_id_0547::_id_5565(self.characterindex, 39)) {
      return 0;
    }
  }

  if(isDefined(var_7)) {
    if(_id_0547::_id_5565(self.characterindex, 39)) {
      thread _id_717E(var_7, var_0, "zmb_char_callout", var_4, var_8);
    } else {
      thread _id_717E(var_7, var_0, var_1, var_4, var_8);
    }
  } else if(_id_0547::_id_5565(self.characterindex, 39))
    thread _id_717E(var_7, var_0, "zmb_char_callout", var_4, var_8);

  return 1;
}

get_viable_gbl_aliases(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_5 = [];
  var_6 = [var_2, var_2 + "1", var_2 + "2", var_2 + "3", var_2 + "4", var_2 + "5"];
  var_7 = var_3.characterindex;
  [var_9, var_10, var_11] = generate_possible_prefixes(var_7);

  foreach(var_13 in var_6) {
    if(isDefined(level.vox.speaker[var_0]._id_0BB4[var_1][var_13])) {
      var_14 = level.vox.speaker[var_0]._id_0BB4[var_1][var_13];

      if(isDefined(var_10) && var_11.size > 0) {
        foreach(var_16 in var_11) {
          if(_soundexists(var_16 + var_14) || _soundexists(var_16 + var_14 + "_lo") || _soundexists(var_16 + var_14 + "_md") || _soundexists(var_16 + var_14 + "_hi")) {
            var_5[var_5.size] = var_16 + var_14;
          }
        }
      }

      foreach(var_16 in var_9) {
        if(_soundexists(var_16 + var_14) || _soundexists(var_16 + var_14 + "_lo") || _soundexists(var_16 + var_14 + "_md") || _soundexists(var_16 + var_14 + "_hi")) {
          var_4[var_4.size] = var_16 + var_14;
        }
      }
    }
  }

  if(var_5.size > 0) {
    return var_5;
  } else {
    return var_4;
  }
}

generate_possible_prefixes(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = [];
  var_4 = ["zmb_ship_gbl_", "zmb_dlc_gbl_", "zmb_dlc_gbl2_"];
  var_5 = _id_0378::dlg_get_char_name_callouts_from_index(var_0);

  if(_isarray(var_5)) {
    var_1 = var_5;
  } else {
    var_1 = [var_5];
  }

  var_6 = _id_0378::dlg_get_char_name_override_from_index(var_0);

  foreach(var_8 in var_4) {
    foreach(var_10 in var_1) {
      var_11 = var_8 + var_10 + "_";
      var_2 = common_scripts\utility::_id_0F6F(var_2, var_11);
    }

    if(isDefined(var_6)) {
      var_13 = var_8 + var_6 + "_";
      var_2 = common_scripts\utility::_id_0F6F(var_2, var_13);
      var_3 = common_scripts\utility::_id_0F6F(var_3, var_13);

      if(_id_0547::_id_5565(var_0, 7)) {
        var_3 = common_scripts\utility::_id_0F6F(var_3, var_8 + "feml" + "_");
      }
    }
  }

  return [var_2, var_6, var_3];
}

_id_89B1(var_0, var_1, var_2, var_3) {
  if(level.players.size == 1) {
    return;
  }
  if(!isDefined(var_3)) {
    var_3 = getrandomcharacterinrange(var_0);
  }

  if(isDefined(var_3) && isDefined(var_3.zmbvoxid)) {
    var_4 = level.vox.speaker[var_3.zmbvoxid].response[var_1][var_2];

    if(isDefined(var_4)) {
      var_3 _id_277F(var_1, var_4);
    }
  }
}

_id_73AA() {
  self endon("disconnect");

  if(!isDefined(level._id_7337)) {
    level._id_7337 = 0;
    level._id_05AC = _id_0547::get_round_enemy_array();
  }

  for(;;) {
    waitframe();
    var_0 = gettime();

    if(var_0 > level._id_7337 + 1000) {
      level._id_7337 = var_0;
      level._id_05AC = _id_0547::get_round_enemy_array();
    }

    var_1 = level._id_05AC;
    var_2 = 0;

    for(var_3 = 0; var_3 < var_1.size; var_3++) {
      if(!isDefined(var_1[var_3]) || !isDefined(var_1[var_3]._id_0A4B) || !isDefined(var_1[var_3]._id_0088) || var_1[var_3]._id_0088 != self || common_scripts\utility::_id_562E(var_1[var_3].setotherent)) {
        continue;
      }
      var_4 = 200;
      var_5 = 50;

      if(isDefined(var_1[var_3]._id_ABDF)) {
        switch (var_1[var_3]._id_ABDF) {
          case "walk":
            var_4 = 200;
            break;
          case "run":
            var_4 = 250;
            break;
          case "sprint":
            var_4 = 275;
            break;
        }
      }

      if(distancesquared(var_1[var_3].origin, self.origin) < var_4 * var_4) {
        var_6 = getyawtospot(var_1[var_3].origin);
        var_7 = self.origin[2] - var_1[var_3].origin[2];

        if(var_6 > -95 && var_6 < 95 && _abs(var_7) < 50) {
          var_1[var_3].setotherent = 1;
          var_8 = undefined;

          switch (var_1[var_3]._id_0A4B) {
            case "zombie_fireman":
              var_8 = "firemansee";
              break;
            case "zombie_exploder":
              var_8 = "bombersee";
              break;
            case "zombie_berserker":
              var_8 = "sprintersee";
              break;
          }

          if(isDefined(var_8)) {
            var_2 = _id_277F("enemy", var_8);
          }

          break;
        }
      }
    }

    if(var_2) {
      wait 15;
    }
  }
}

player_zombie_char_ambient_noises() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    if(_id_0547::_id_5565(self.characterindex, 39) && !common_scripts\utility::_id_562E(self.isspeaking)) {
      switch (randomint(7)) {
        case 0:
          self playSound("zvox_gen_growl_lev1");
          break;
        default:
          break;
      }
    }

    wait(_randomfloatrange(6, 10));
  }
}

volength(var_0, var_1) {
  var_2 = tablelookup(level.zmbsoundlengthpath, 0, var_0, 1);

  if(!isDefined(var_2) || var_2 == "") {
    if(isDefined(var_1) && var_1 == "exert") {
      return 0.5;
    } else if(isDefined(var_1) && var_1 == "conversation") {
      return 3;
    } else {
      return 2;
    }
  }

  var_2 = int(var_2);
  var_2 = var_2 * 0.001;
  return var_2;
}

getyawtospot(var_0) {
  var_1 = var_0;
  var_2 = self.angles[1] - getyaw(var_1);
  var_2 = _angleclamp180(var_2);
  return var_2;
}

getyaw(var_0) {
  var_1 = vectortoangles(var_0 - self.origin);
  return var_1[1];
}

_id_3102(var_0, var_1, var_2) {
  _id_0366::_id_8E4B(var_0);
}

is_last_zombie() {
  if(_id_056D::_id_45C2() <= 1) {
    return 1;
  }

  return 0;
}

zmbsetglobalpriorityonly(var_0) {
  if(var_0) {
    level.zmbglobalpriorityvoonly++;
  } else {
    level.zmbglobalpriorityvoonly--;
  }

  if(level.zmbglobalpriorityvoonly < 0) {
    level.zmbglobalpriorityvoonly = 0;
  }
}

create_and_play_dialog_delay(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");
  self endon("disconnect");
  wait(var_5);
  thread create_and_play_dialog(var_0, var_1, var_2, var_3, var_4, var_6);
}

create_and_play_dialog(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(self.zmbvoxid)) {
    return 0;
  }

  if(level.zmbglobalpriorityvoonly > 0 && var_0 != "global_priority") {
    return 0;
  }

  if(common_scripts\utility::_id_562E(self.dontspeak)) {
    return 0;
  }

  if(_id_0547::isplayerinfected(self) && var_1 != "infected" && var_1 != "sq") {
    return 0;
  }

  if(!isDefined(self.isspeaking)) {
    self.isspeaking = 0;
  }

  if(common_scripts\utility::_id_562E(self.isspeaking)) {
    return 0;
  }

  if(_id_0F55(var_0)) {
    return 0;
  }

  var_7 = isDefined(var_2);
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;

  if(!isDefined(level.vox.speaker[self.zmbvoxid]._id_0BB4[var_0]) || !isDefined(level.vox.speaker[self.zmbvoxid]._id_0BB4[var_0][var_1])) {
    return 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if(!var_4 && !can_event_play(self.zmbvoxid, var_0, var_1)) {
    return 0;
  }

  var_11 = getarraykeys(level.vox.speaker[self.zmbvoxid].prefixes);
  var_10 = level.vox.speaker[self.zmbvoxid].prefixes[var_11[0]];
  var_8 = level.vox.speaker[self.zmbvoxid]._id_0BB4[var_0][var_1];

  if(isPlayer(self)) {
    if(self.sessionstate != "playing") {
      return 0;
    }

    if(_id_0547::isplayerinlaststand(self) && var_1 != "revive_down" && var_1 != "revive_up" && var_1 != "bonus_line_over") {
      return 0;
    }

    var_9 = _id_0547::get_player_index(self);
    var_10 = level.vox.speaker[self.zmbvoxid].prefixes[var_9];
  }

  var_12 = "";

  if(var_0 == "conversation") {
    if(!isDefined(var_3)) {
      var_3 = 1;
    }

    var_12 = build_dialog_line("", var_8, var_3);

    if(!_soundexists(var_12)) {
      return 0;
    }
  } else {
    if(var_7) {
      var_13 = var_2 + var_8;
      var_14 = "any_" + var_8;
      var_15 = zmbvoxgetlinevariant(var_10, var_14, var_3);

      if(isDefined(var_15) && _soundexists(var_15) && randomint(100) > 50) {
        var_8 = var_14;
      } else {
        var_8 = var_13;
      }
    }

    var_12 = zmbvoxgetlinevariant(var_10, var_8, var_3);

    if(!isDefined(var_12) && _soundexists(var_10 + var_8)) {
      var_12 = var_10 + var_8;
    }
  }

  if(isDefined(var_12)) {
    if(!_soundexists(var_12)) {
      return 0;
    }

    thread do_player_or_npc_playvox(var_10, var_9, var_12, var_0, var_1, var_7, var_5, var_3, var_6);
  } else
    return 0;

  return 1;
}

do_player_or_npc_playvox(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("disconnect");
  self endon("stopSpeaking");
  var_9 = 0.25;

  if(var_3 == "exert") {
    var_9 = 0;
  }

  self.speakingline = var_2;
  self.isspeaking = 1;
  self notify("speaking");
  playsoundwaituntildone(var_2, var_3, var_4, var_8);

  if(var_9 > 0) {
    wait(var_9);
  }

  self notify("done_speaking");
  level notify("done_speaking");
  self.isspeaking = 0;

  if(var_3 == "conversation") {
    level thread setup_conversation_response_line(self, var_1, var_3, var_4, var_6, var_7);
  } else if(isDefined(level.vox.speaker[self.zmbvoxid].response) && isDefined(level.vox.speaker[self.zmbvoxid].response[var_3]) && isDefined(level.vox.speaker[self.zmbvoxid].response[var_3][var_4])) {
    if(isDefined(level._id_05A7)) {
      level thread[[level._id_05A7]](self, var_1, var_3, var_4, var_6);
    } else {
      level thread setup_response_line(self, var_1, var_3, var_4, var_6);
    }
  }
}

_id_0F55(var_0) {
  return _id_0F5A() && !common_scripts\utility::_id_562E(self.ignorenearbyspkrs) && var_0 != "global_priority" && var_0 != "exert" && var_0 != "conversation" && var_0 != "ignore_nearby" && var_0 != "sq";
}

_id_A7A1(var_0, var_1) {
  while(var_0 _id_0F5A()) {
    waitframe();
  }
}

player_stop_speaking() {
  self notify("stopSpeaking");

  if(common_scripts\utility::_id_562E(self.isspeaking) && isDefined(self.speakingline)) {
    self stopsound(self.speakingline);
    self.isspeaking = 0;
  }
}

getrandomcharacterinrange(var_0) {
  var_1 = 250000;
  var_2 = [];

  foreach(var_4 in level.players) {
    if(!isDefined(var_4) || var_4 == var_0) {
      continue;
    }
    var_5 = distancesquared(var_0.origin, var_4.origin) < var_1;

    if(var_5) {
      var_2[var_2.size] = var_4;
    }
  }

  if(var_2.size == 1) {
    return var_2[0];
  } else if(var_2.size > 1) {
    var_7 = _randomintrange(0, var_2.size);
    return var_2[var_7];
  }
}

setup_response_line(var_0, var_1, var_2, var_3, var_4) {
  if(level.players.size == 1) {
    return;
  }
  if(!isDefined(var_4)) {
    var_4 = getrandomcharacterinrange(var_0);
  }

  if(isDefined(var_4)) {
    var_5 = level.vox.speaker[var_4.zmbvoxid].response[var_2][var_3];

    if(isDefined(var_5)) {
      var_6 = level.vox.speaker[var_0.zmbvoxid].prefixes[var_1];
      var_4 create_and_play_dialog(var_2, var_5, var_6);
    }
  }
}

setup_conversation_response_line(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_4) && isalive(var_4)) {
    var_4 create_and_play_dialog(var_2, var_3, undefined, var_5 + 1, undefined, var_0);
  }
}

player_kill_zombie(var_0, var_1, var_2, var_3) {
  thread player_zombie_kill_vox(var_0, var_1, var_2, var_3);
}

player_zombie_kill_vox(var_0, var_1, var_2, var_3) {
  self endon("disconnect");

  if(!isDefined(var_3) || common_scripts\utility::_id_562E(self.force_wait_on_kill_line)) {
    return;
  }
  var_2 = _getweaponbasename(var_2);
  var_4 = playertryzombiekillvo(var_0, var_1, var_2, var_3);

  if(isDefined(var_4)) {
    self.force_wait_on_kill_line = 1;
    wait 2;
    self.force_wait_on_kill_line = 0;
  }
}

can_event_play(var_0, var_1, var_2) {
  var_3 = get_event_chance(var_0, var_1, var_2);
  return var_3 > _randomintrange(1, 100);
}

get_event_chance(var_0, var_1, var_2) {
  if(!isDefined(level.vox.speaker[var_0]) || !isDefined(level.vox.speaker[var_0].chance) || !isDefined(level.vox.speaker[var_0].chance[var_1]) || !isDefined(level.vox.speaker[var_0].chance[var_1][var_2])) {
    return 0;
  }

  return level.vox.speaker[var_0].chance[var_1][var_2];
}

playertryzombiekillvo(var_0, var_1, var_2, var_3) {
  var_4 = "kill";

  if(_id_0547::istrapweapon(var_2)) {
    return;
  }
  if(isDefined(var_3._id_0A4B) && var_3._id_0A4B == "zombie_treasurer") {
    _id_277F("enemy", "treasurezombiewin");
  }
}

timer_actual(var_0, var_1) {
  self endon("disconnect");
  self endon("death");
  var_2 = gettime() + var_1 * 1000;

  while(gettime() < var_2) {
    if(self.killcounter > var_0) {
      thread create_and_play_dialog_delay("kill", "streak", undefined, undefined, undefined, 1);
      wait 2;
      self.killcounter = 0;
      var_2 = -2;
    }

    wait 0.1;
  }

  wait 10;
  self.killcounter = 0;
  self.timerisrunning = 0;
}

_id_72A3(var_0, var_1, var_2) {}

zombie_hurt(var_0, var_1) {}

playerlaugh() {
  if(!isDefined(self.nextlaughtime) || gettime() > self.nextlaughtime) {
    var_0 = playerexert("laugh");

    if(var_0) {
      self.nextlaughtime = gettime() + 15000;
    }
  }
}

player_hurt_zombie_vox(var_0) {
  thread create_and_play_dialog_delay("general", var_0, undefined, undefined, undefined, 1);
}

_id_0998(var_0) {
  if(!isDefined(level.npcs)) {
    level.npcs = [];
  }

  if(common_scripts\utility::_id_562E(var_0)) {
    self.ignorenearbyspkrs = 1;
  } else {
    self.ignorenearbyspkrs = 0;
  }

  self.isnpc = 1;
  level.npcs[level.npcs.size] = self;
}

_id_0F5A() {
  var_0 = 1000000;
  var_1 = 0;
  var_2 = level.players;

  if(isDefined(level.npcs)) {
    var_2 = common_scripts\utility::_id_0F73(var_2, level.npcs);
  }

  foreach(var_4 in var_2) {
    if(self == var_4) {
      continue;
    }
    if(isPlayer(var_4)) {
      if(var_4.sessionstate != "playing" || _id_0547::isplayerinlaststand(var_4)) {
        continue;
      }
    } else {}

    if(common_scripts\utility::_id_562E(var_4.isspeaking) && !common_scripts\utility::_id_562E(var_4.ignorenearbyspkrs)) {
      if(distancesquared(self.origin, var_4.origin) < var_0) {
        var_1 = 1;
        break;
      }
    }
  }

  return var_1;
}

zmbvoxcreate() {
  var_0 = spawnStruct();
  var_0.speaker = [];
  return var_0;
}

zmbvoxinitspeaker(var_0, var_1, var_2, var_3) {
  var_2.zmbvoxid = var_0;

  if(!isDefined(self.speaker[var_0])) {
    self.speaker[var_0] = spawnStruct();
    self.speaker[var_0]._id_0BB4 = [];
    self.speaker[var_0].prefixes = [];
    self.speaker[var_0].ents = [];
  }

  self.speaker[var_0].ents[var_3] = var_2;
  self.speaker[var_0].prefixes[var_3] = var_1;
}

zmbvoxadd(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(self.speaker[var_0])) {
    self.speaker[var_0] = spawnStruct();
    self.speaker[var_0]._id_0BB4 = [];
    self.speaker[var_0].prefixes = [];
    self.speaker[var_0].ents = [];
  }

  if(!isDefined(self.speaker[var_0]._id_0BB4[var_1])) {
    self.speaker[var_0]._id_0BB4[var_1] = [];
  }

  self.speaker[var_0]._id_0BB4[var_1][var_2] = var_3;

  if(isDefined(var_4)) {
    if(!isDefined(self.speaker[var_0].response)) {
      self.speaker[var_0].response = [];
    }

    if(!isDefined(self.speaker[var_0].response[var_1])) {
      self.speaker[var_0].response[var_1] = [];
    }

    self.speaker[var_0].response[var_1][var_2] = var_4;
  }

  if(!isDefined(var_5)) {
    var_5 = 100;
  }

  if(!isDefined(self.speaker[var_0].chance)) {
    self.speaker[var_0].chance = [];
  }

  if(!isDefined(self.speaker[var_0].chance[var_1])) {
    self.speaker[var_0].chance[var_1] = [];
  }

  self.speaker[var_0].chance[var_1][var_2] = var_5;
}

build_dialog_line(var_0, var_1, var_2) {
  if(var_2 < 10) {
    return var_0 + var_1 + "_0" + var_2;
  } else {
    return var_0 + var_1 + "_" + var_2;
  }
}

zmbvoxgetlinevariant(var_0, var_1, var_2) {
  if(!isDefined(self.sound_dialog)) {
    self.sound_dialog = [];
    self.sound_dialog_available = [];
  }

  if(!isDefined(self.sound_dialog[var_1])) {
    var_3 = get_number_variants(var_0, var_1);

    if(var_3 <= 0) {
      return undefined;
    }

    for(var_4 = 0; var_4 < var_3; var_4++) {
      self.sound_dialog[var_1][var_4] = var_4 + 1;
    }

    self.sound_dialog_available[var_1] = [];
  }

  if(self.sound_dialog_available[var_1].size <= 0) {
    for(var_4 = 0; var_4 < self.sound_dialog[var_1].size; var_4++) {
      self.sound_dialog_available[var_1][var_4] = self.sound_dialog[var_1][var_4];
    }
  }

  var_5 = common_scripts\utility::random(self.sound_dialog_available[var_1]);
  self.sound_dialog_available[var_1] = common_scripts\utility::_id_0F93(self.sound_dialog_available[var_1], var_5);

  if(isDefined(var_2)) {
    var_5 = var_2;
  }

  return build_dialog_line(var_0, var_1, var_5);
}

playsoundwaituntildone(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1) && var_1 == "monologue") {
    self playlocalsound(var_0);
  } else if(isDefined(var_3) && var_3.size > 0) {
    foreach(var_5 in var_3) {
      if(isDefined(var_5)) {
        self playsoundtoplayer(var_0, var_5, 1);
      }
    }
  } else
    self playsoundonmovingent(var_0);

  var_7 = volength(var_0, var_1);
  wait(var_7);
}

get_number_variants(var_0, var_1) {
  for(var_2 = 1; var_2 < 30; var_2++) {
    if(!_soundexists(build_dialog_line(var_0, var_1, var_2))) {
      return var_2 - 1;
    }
  }
}

play_level_start_vox() {
  level thread setupwaveintermissiondialog();
  wait 1;

  if(isDefined(level.zmbaudiowave1vo)) {
    level thread[[level.zmbaudiowave1vo]]();
  } else if(level.players.size == 1) {
    var_0 = _randomintrange(0, level.players.size);
    level.players[var_0] thread create_and_play_dialog("general", "intro");
  } else
    level thread playwavenumintrodialog("wave1", 1, 2, 0, 3);

  level.zmplayedearlywavevo = 0;

  for(;;) {
    level waittill("zombie_wave_started");
    wait 1;
    var_1 = 1;

    if(isDefined(level.zmbaudiowavestartvo)) {
      var_1 = [[level.zmbaudiowavestartvo]](var_1);
    } else {
      if(!var_1 && level.wavecounter == 2) {
        playwavenumintrodialog("wave2", 2, 0, 1, 3);
        var_1 = 1;
      } else if(!var_1 && (level.wavecounter == 5 || level.wavecounter == 10 || level.wavecounter == 20 || level.wavecounter == 35 || level.wavecounter == 50)) {
        var_0 = _randomintrange(0, level.players.size);
        level.players[var_0] create_and_play_dialog("general", "round_" + level.wavecounter);
        var_1 = 1;
      }

      if(!var_1 && level.wavecounter > 2 && !level.zmplayedearlywavevo) {
        var_2 = _randomintrange(0, 100);

        if(var_2 < 30) {
          playwavenumintrodialog("wave_early", 0, 2, 1, 3);
          level.zmplayedearlywavevo = 0;
          var_1 = 1;
        }
      }
    }

    if(!var_1 && level.wavecounter > 1) {
      var_0 = _randomintrange(0, level.players.size);
      level.players[var_0] create_and_play_dialog("general", "wave_start");
      var_1 = 1;
    }

    level waittill("zombie_wave_ended");
    var_3 = 1;
    var_4 = 0;

    if(isDefined(level.zmbdowaveendvo)) {
      var_3 = [[level.zmbdowaveendvo]]();
    }

    if(var_3) {
      wait 1;
      var_0 = _randomintrange(0, level.players.size);
      var_4 = level.players[var_0] create_and_play_dialog("general", "wave_end");

      if(var_4) {
        level.players[var_0] common_scripts\utility::waittill_notify_or_timeout("done_speaking", 6);
        wait 1;
      }
    }

    if(isDefined(level.zmbwaveintermissionvo)) {
      var_4 = [[level.zmbwaveintermissionvo]](var_4);
    }

    if(!playweaponremindervo() && !var_4) {
      playwaveintermissiondialog();
    }
  }
}

playwavenumintrodialog(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5)) {
    var_5 = "general";
  }

  var_6 = getcharacterbyindex(var_1);

  if(isDefined(var_6) && var_6 create_and_play_dialog(var_5, var_0)) {
    level common_scripts\utility::waittill_notify_or_timeout("done_speaking", 6);
  }

  var_6 = getcharacterbyindex(var_2);

  if(isDefined(var_6) && var_6 create_and_play_dialog(var_5, var_0)) {
    level common_scripts\utility::waittill_notify_or_timeout("done_speaking", 6);
  }

  var_6 = getcharacterbyindex(var_3);

  if(isDefined(var_6) && var_6 create_and_play_dialog(var_5, var_0)) {
    level common_scripts\utility::waittill_notify_or_timeout("done_speaking", 6);
  }

  var_6 = getcharacterbyindex(var_4);

  if(isDefined(var_6) && var_6 create_and_play_dialog(var_5, var_0)) {
    level common_scripts\utility::waittill_notify_or_timeout("done_speaking", 6);
  }
}

playweaponremindervo() {
  if(level.wavecounter == 2) {
    var_0 = getplayerwhoonlyhaspistol();

    if(isDefined(var_0)) {
      return var_0 create_and_play_dialog("general", "weapon_reminder", undefined, 1);
    }
  } else if(level.wavecounter == 10) {
    var_0 = getplayerwhohasnotupgraded();

    if(isDefined(var_0)) {
      return var_0 create_and_play_dialog("general", "weapon_reminder", undefined, 2);
    }
  }

  return 0;
}

getplayerwhoonlyhaspistol() {
  foreach(var_1 in level.players) {
    var_2 = var_1 getweaponlistprimaries();

    if(var_2.size == 1 && var_2[0] == "iw5_titan45zm_mp") {
      return var_1;
    }
  }
}

_id_7449(var_0) {
  foreach(var_2 in level.players) {
    var_2 _id_277F("general", var_0);
  }
}

_id_9D3A(var_0, var_1) {
  if(var_1) {
    _id_277F("enemy", "treasurezombiewin");
  } else {
    _id_277F("enemy", "treasurezombiefail");
  }
}

_id_9D39() {
  _id_277F("enemy", "treasurezombiewarn");
}

_id_7465() {
  _id_277F("enemy", "treasurezombieseen");
  _id_277F("enemy", "treasurezombiemove");
}

_id_18EC() {
  _id_277F("enemy", "bomberkillshot");
}

_id_73B3() {
  _id_2780(1, "enemy", "followeranger");
}

getplayerwhohasnotupgraded() {
  foreach(var_1 in level.players) {
    var_2 = var_1 getweaponlistprimaries();

    foreach(var_4 in var_2) {
      if(_id_0547::getzombieweaponlevel(var_1, var_4) < 1) {
        return var_1;
      }
    }
  }
}

setupwaveintermissiondialog() {
  level.zmwaveintermissiondialog = [];
  level.zmwaveintermissiondialog[0] = newwaveintermissionstruct();
  level.zmwaveintermissiondialog[1] = newwaveintermissionstruct();
}

newwaveintermissionstruct() {
  var_0 = spawnStruct();
  var_0.characters = [];
  var_0.prefixes = [];
  var_0.aiphysicstrace = 1;
  var_0._id_08BE = 0;
  var_0.completed = 0;
  var_0.nextround = 1;
  return var_0;
}

playwaveintermissiondialog() {
  if(level.players.size == 1 || !isDefined(level.vox.speaker["player"]._id_0BB4["conversation"])) {
    return 0;
  }

  foreach(var_1 in level.zmwaveintermissiondialog) {
    if(dialogcanplay(var_1) && playdialog(var_1)) {
      dialogincrement(var_1);
      return 1;
    }
  }

  foreach(var_1 in level.zmwaveintermissiondialog) {
    if(!var_1._id_08BE && createdialog(var_1)) {
      if(playdialog(var_1)) {
        dialogincrement(var_1);
        return 1;
      } else
        return 0;
    }
  }

  return 0;
}

dialogcanplay(var_0) {
  return var_0._id_08BE && var_0.nextround <= level.wavecounter && dialogcharactersactive(var_0);
}

dialogcharactersactive(var_0) {
  if(var_0.characters.size != 2) {
    return 0;
  }

  foreach(var_2 in var_0.characters) {
    if(!isDefined(var_2) || !maps\mp\_utility::isreallyalive(var_2)) {
      return 0;
    }
  }

  return 1;
}

dialogincrement(var_0) {
  var_0.nextround = var_0.nextround + _randomintrange(2, 4);
  var_0.aiphysicstrace++;
}

playerinanydialog() {
  foreach(var_1 in level.zmwaveintermissiondialog) {
    if(common_scripts\utility::_id_0F79(var_1.characters, self)) {
      return 1;
    }
  }

  return 0;
}

createdialog(var_0) {
  var_1 = common_scripts\utility::array_randomize(level.players);
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in var_1) {
    if(!var_5 playerinanydialog()) {
      if(!isDefined(var_2)) {
        var_2 = var_5;
      } else {
        var_3 = var_5;
      }
    }

    if(isDefined(var_2) && isDefined(var_3)) {
      break;
    }
  }

  if(!isDefined(var_2) || !isDefined(var_3)) {
    return 0;
  }

  var_0.characters[0] = var_2;
  var_0.characters[1] = var_3;
  var_0.prefixes[0] = level.vox.speaker[var_2.zmbvoxid].prefixes[_id_0547::get_player_index(var_2)];
  var_0.prefixes[1] = level.vox.speaker[var_3.zmbvoxid].prefixes[_id_0547::get_player_index(var_3)];
  var_0._id_08BE = 1;
  var_0.completed = 0;
  return 1;
}

playdialog(var_0) {
  var_1 = "" + var_0.prefixes[0] + var_0.prefixes[1] + var_0.aiphysicstrace;
  var_2 = var_0.characters[0];
  var_3 = var_0.characters[1];

  if(!isDefined(level.vox.speaker["player"]._id_0BB4["conversation"][var_1])) {
    var_1 = "" + var_0.prefixes[1] + var_0.prefixes[0] + var_0.aiphysicstrace;
    var_2 = var_0.characters[1];
    var_3 = var_0.characters[0];

    if(!isDefined(level.vox.speaker["player"]._id_0BB4["conversation"][var_1])) {
      var_0.completed = 1;
      return 0;
    }
  }

  return var_2 create_and_play_dialog("conversation", var_1, undefined, undefined, undefined, var_3);
}

getcharacterbyindex(var_0) {
  foreach(var_2 in level.players) {
    if(var_2.characterindex == var_0) {
      return var_2;
    }
  }
}

getcharacterindexbyprefix(var_0) {
  switch (var_0) {
    case "jeff":
      return 0;
    case "dros":
      return 1;
    case "mari":
      return 2;
    case "oliv":
      return 3;
  }
}

getcharacterbyprefix(var_0) {
  return getcharacterbyindex(getcharacterindexbyprefix(var_0));
}

getanycharacterbyprefixexcept(var_0) {
  var_1 = getcharacterbyprefix(var_0);

  if(!isDefined(var_1)) {
    return level.players[randomint(level.players.size)];
  } else {
    var_2 = common_scripts\utility::array_randomize(level.players);

    foreach(var_4 in level.players) {
      if(var_4 != var_1) {
        return var_4;
      }
    }
  }
}

_id_AB3D() {
  var_0 = _randomintrange(0, 3);
  player_stop_speaking();
  playerstopexerting();
  playerexert("death" + var_0);
}

_id_AB3C(var_0) {
  if(isDefined(self.damage_sound_time) && self.damage_sound_time + 5000 > var_0) {
    return;
  }
  if(!common_scripts\utility::_id_562E(self.isexerting)) {
    self.damage_sound_time = var_0;
    var_1 = _randomintrange(0, 3);
    player_stop_speaking();
    playerexert("pain" + var_1);
  }
}

playerexert(var_0) {
  return 0;
}

playerstopexerting() {
  self notify("stopExerting");
  self.isexerting = undefined;
}

exert_timer() {
  self endon("disconnect");
  self endon("stopExerting");
  wait 1;
  self.isexerting = 1;
  wait(_randomfloatrange(1.5, 3));
  self.isexerting = undefined;
}

_id_743B() {}

_id_743A() {}

_id_7448(var_0) {
  wait 1;

  if(self == var_0) {
    return;
  }
  if(var_0 _id_0547::_id_4BA7("specialty_class_covert_exfiltration_zm") && common_scripts\utility::_id_562E(var_0._id_569F)) {
    var_1 = var_0 _id_277F("mod_use", "mod_covertexfiltration", undefined, undefined, self);
  } else {
    var_1 = var_0 _id_277F("general", "revive_ally", undefined, undefined, self);
  }
}

_id_741A() {
  wait 1;
}

_id_7486(var_0) {
  var_1 = "";
  var_2 = "ability";

  switch (var_0) {
    case "role_ability_mad_minute_zm":
      var_1 = "special_mad";
      break;
    case "role_ability_camo_zm":
      var_1 = "special_camo";
      break;
    case "role_ability_stunning_burst_zm":
      var_1 = "special_burst";
      break;
    case "role_ability_taunt_zm":
      var_1 = "special_taunt";
      break;
    case "role_ability_melee_frenzy_zm":
      var_1 = "special_mad";
      break;
  }

  [var_2, var_1] = _id_73C4(var_2, var_1);
  _id_277F(var_2, var_1);
}

_id_73C4(var_0, var_1) {
  var_2 = var_1;

  if(var_1 == "special_camo") {
    if(_id_0547::_id_4BA7("specialty_class_serrated_edge_zm")) {
      var_1 = "mod_serratededge";
    } else if(_id_0547::_id_4BA7("specialty_class_saboteur_zm") && playerismaincast()) {
      var_1 = "mod_saboteur";
    } else if(_id_0547::_id_4BA7("specialty_class_mobilization_zm") && (playerismaincast() || _id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self.characterindex), "slay") || _id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self.characterindex), "mount") || _id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self.characterindex), "hunt") || _id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self.characterindex), "surv"))) {
      var_1 = "mod_enhancedspeed";
    }
  } else if(var_1 == "special_mad") {
    if(_id_0547::_id_4BA7("specialty_class_ammo_carrier_zm") && level.players.size > 1) {
      var_1 = "mod_supplyammo";
    } else if(_id_0547::_id_4BA7("specialty_class_squad_tactics_zm")) {
      var_1 = "mod_headshot";
    }
  } else if(var_1 == "special_burst") {
    if(_id_0547::_id_4BA7("specialty_class_bolster_morale_zm") && level.players.size > 1 && _id_73C3() && playerismaincast()) {
      var_1 = "mod_supplyarmor";
    } else if(_id_0547::_id_4BA7("specialty_class_fiery_burst_zm")) {
      var_1 = "mod_fieryburst";
    } else if(_id_0547::_id_4BA7("specialty_class_exploit_weakness_zm") && (playerismaincast() || _id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self.characterindex), "slay") || _id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self.characterindex), "mount") || _id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self.characterindex), "hunt") || _id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self.characterindex), "surv"))) {
      var_1 = "mod_exploitweakness";
    }
  } else if(var_1 == "special_taunt") {
    if(_id_0547::_id_4BA7("specialty_class_team_effort_zm") && level.players.size > 1) {
      var_1 = "mod_teameffort";
    } else if(_id_0547::_id_4BA7("specialty_class_come_get_zm")) {
      var_1 = "mod_comeandgetit";
    } else if(_id_0547::_id_4BA7("specialty_class_counter_offensive_zm") && (playerismaincast() || _id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self.characterindex), "slay") || _id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self.characterindex), "mount") || _id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self.characterindex), "hunt") || _id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self.characterindex), "surv"))) {
      var_1 = "mod_counteroffensive";
    }
  } else if(var_1 == "special_melee") {}

  if(var_1 != var_2) {
    var_0 = "mod_use";
  }

  return [var_0, var_1];
}

playerismaincast() {
  if(_id_0547::_id_5565(_id_0378::_id_307B(self.characterindex), "dros") || _id_0547::_id_5565(_id_0378::_id_307B(self.characterindex), "jeff") || _id_0547::_id_5565(_id_0378::_id_307B(self.characterindex), "mari") || _id_0547::_id_5565(_id_0378::_id_307B(self.characterindex), "oliv")) {
    return 1;
  } else {
    return 0;
  }
}

_id_73C3() {
  var_0 = 0;
  var_1 = 518400;

  if(common_scripts\utility::_id_562E(_id_0547::_id_4BA7("specialty_class_breathing_room_zm")) && !common_scripts\utility::_id_562E(_id_0547::_id_4BA7("specialty_class_sustain_zone_zm"))) {
    var_1 = var_1 * 2.25;
  } else if(!common_scripts\utility::_id_562E(_id_0547::_id_4BA7("specialty_class_breathing_room_zm")) && common_scripts\utility::_id_562E(_id_0547::_id_4BA7("specialty_class_sustain_zone_zm"))) {
    var_1 = var_1 * 0.25;
  }

  foreach(var_3 in level.players) {
    if(var_3 == self) {
      continue;
    }
    if(_id_0547::isplayerinlaststand(var_3)) {
      continue;
    }
    if(distancesquared(self.origin, var_3.origin) < var_1) {
      if(_bullettracepassed(var_3 getEye(), self getEye(), 0, undefined)) {
        var_0 = 1;
      }
    }
  }

  return var_0;
}

_id_0695(var_0) {
  if(!common_scripts\utility::_id_562E(self._id_3E08)) {
    self._id_3E08 = 1;
    _id_277F("general", var_0);
    wait 10;
    self._id_3E08 = undefined;
  }
}

_id_745A(var_0) {
  if(level.players.size > 1) {
    _id_277F("general", var_0);
  }
}

_id_73B9(var_0, var_1) {
  var_2 = "perk_ouch";

  if(isshipzombiesmap()) {
    if(common_scripts\utility::_id_562E(var_1)) {
      var_2 = "perk_first";

      if(var_0 == "electriccherry" && (_id_0547::_id_5565(_id_0378::_id_307B(self.characterindex), "jeff") || _id_0547::_id_5565(_id_0378::_id_307B(self.characterindex), "mari"))) {
        var_2 = "perk_shock";
      } else if(var_0 == "punchperk" && _id_0547::_id_5565(_id_0378::_id_307B(self.characterindex), "jeff")) {
        var_2 = "perk_punch";
      }
    }
  } else if(common_scripts\utility::_id_562E(var_1))
    var_2 = "perk_first";
  else {
    switch (var_0) {
      case "electriccherry":
        var_2 = "perk_shock";
        break;
      case "punchperk":
        var_2 = "perk_punch";
        break;
      case "fastreload":
        var_2 = "perk_reload";
        break;
      case "runperk":
        var_2 = "perk_run";
        break;
      case "quickrevive":
        if(_id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self.characterindex), "slay") || _id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self.characterindex), "mount") || _id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self.characterindex), "hunt") || _id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self.characterindex), "surv")) {
          var_2 = "perk_ouch";
        } else {
          var_2 = "perk_revive";
        }

        break;
      case "doubletap":
        var_2 = "perk_damage";
        break;
    }
  }

  _id_277F("perk", var_2);
}

playeruselostandfound() {
  if(isshipzombiesmap()) {
    return;
  }
  _id_277F("general", "lost_and_found");
  return;
}

playerbuyweapon(var_0) {
  if(isshipzombiesmap()) {
    return;
  }
  if(common_scripts\utility::_id_562E(var_0)) {
    _id_277F("general", "newpackweapon");
  } else {
    _id_277F("general", "newweapon");
    return;
  }
}

playeruseconsumableweapon() {
  if(isshipzombiesmap()) {
    return;
  }
  _id_277F("general", "consumableweapon");
  return;
}

isshipzombiesmap() {
  var_0 = maps\mp\_utility::getmapname();

  if(var_0 == "mp_zombie_nest_01" || var_0 == "mp_zombie_house" || var_0 == "mp_zombie_training") {
    return 1;
  } else {
    return 0;
  }
}

_id_7491(var_0, var_1) {}

_id_73E4() {}

moneyspend() {
  self playlocalsound("interact_purchase");
  _id_0378::snd_message("money_spend");
}