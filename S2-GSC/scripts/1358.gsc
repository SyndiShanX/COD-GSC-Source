/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1358.gsc
**************************************/

init() {
  level _id_AB19();
  level thread _id_0554::init();

  if(isDefined(level._id_0793))
    level thread[[level._id_0793]]();

  if(isDefined(level._id_0792))
    level thread[[level._id_0792]]();

  if(!isDefined(level._id_AB17))
    level._id_AB17 = "mp/sound/soundlength_zm_mp.csv";

  level._id_AB13 = 0;
}

_id_AB19() {
  level._id_A62B = _id_AB1B();
  level._id_A62B _id_AB1A("player", "ability", "special_camo", "camouflage", undefined);
  level._id_A62B _id_AB1A("player", "ability", "special_mad", "freefire", undefined);
  level._id_A62B _id_AB1A("player", "ability", "special_taunt", "frontline", undefined);
  level._id_A62B _id_AB1A("player", "ability", "special_burst", "shellshock", undefined);
  level._id_A62B _id_AB1A("player", "mod_use", "mod_supplyammo", "supplyammomod", "thanks");
  level._id_A62B _id_AB1A("player", "mod_use", "mod_headshot", "headshotmod", "mod_headshot_reply");
  level._id_A62B _id_AB1A("player", "mod_use", "mod_headshot_reply", "headshot_reply", undefined);
  level._id_A62B _id_AB1A("player", "mod_use", "mod_serratededge", "serreatededgemod", undefined);
  level._id_A62B _id_AB1A("player", "mod_use", "mod_enhancedspeed", "enhancedspeedmod", undefined);
  level._id_A62B _id_AB1A("player", "mod_use", "mod_covertexfiltration", "covertexfilration", "revived");
  level._id_A62B _id_AB1A("player", "mod_use", "mod_saboteur", "saboteur", undefined);
  level._id_A62B _id_AB1A("player", "mod_use", "mod_fieryburst", "fieryburstmod", undefined);
  level._id_A62B _id_AB1A("player", "mod_use", "mod_exploitweakness", "exploitweaknessmod", undefined);
  level._id_A62B _id_AB1A("player", "mod_use", "mod_supplyarmor", "givearmormod", "thanks2");
  level._id_A62B _id_AB1A("player", "mod_use", "mod_comeandgetit", "comeandgetitmod", undefined);
  level._id_A62B _id_AB1A("player", "mod_use", "mod_counteroffensive", "counteroffensivemod", undefined);
  level._id_A62B _id_AB1A("player", "mod_use", "mod_teameffort", "teameffort", undefined);
  level._id_A62B _id_AB1A("player", "general", "revive_ally", "modrevived", "revived");
  level._id_A62B _id_AB1A("player", "general", "revived", "modrevived_reply", undefined);
  level._id_A62B _id_AB1A("player", "general", "give_money", "givemoney", undefined, 25);
  level._id_A62B _id_AB1A("player", "general", "needmoney", "givemoneyv1", undefined);
  level._id_A62B _id_AB1A("player", "general", "nag_stop_killing", "nagstopkilling", undefined);
  level._id_A62B _id_AB1A("player", "general", "thanks", "supplyammod_reply", undefined);
  level._id_A62B _id_AB1A("player", "general", "thanks2", "givearmormod_reply", undefined);
  level._id_A62B _id_AB1A("player", "general", "got_item", "explosivehandler_reply", undefined);
  level._id_A62B _id_AB1A("player", "general", "got_item2", "givemoney_reply", undefined);
  level._id_A62B _id_AB1A("player", "enemy", "treasurezombieseen", "treasurezombieseen", undefined);
  level._id_A62B _id_AB1A("player", "enemy", "treasurezombiemove", "treasurezombiemove", undefined);
  level._id_A62B _id_AB1A("player", "enemy", "treasurezombiefail", "treasurezombiefail", undefined);
  level._id_A62B _id_AB1A("player", "enemy", "treasurezombiewarn", "treasurezombiewarn", undefined);
  level._id_A62B _id_AB1A("player", "enemy", "treasurezombiewin", "treasurezombiewin", undefined);
  level._id_A62B _id_AB1A("player", "enemy", "bombersee", "bombersee", undefined, 5);
  level._id_A62B _id_AB1A("player", "enemy", "bomberkillshot", "bomberskillshot", undefined, 25);
  level._id_A62B _id_AB1A("player", "enemy", "sprintersee", "sprintersee", undefined, 1);
  level._id_A62B _id_AB1A("player", "enemy", "followersurpise", "followersurpise", undefined, 25);
  level._id_A62B _id_AB1A("player", "enemy", "followeranger", "lookout", undefined, 25);
  level._id_A62B _id_AB1A("player", "enemy", "firemansee", "firemanfearreact", undefined, 100);
  level._id_A62B _id_AB1A("player", "perk", "perk_first", "vendingfirsttime", undefined);
  level._id_A62B _id_AB1A("player", "perk", "perk_ouch", "plr_scripted_pain_lev3_", undefined);
  level._id_A62B _id_AB1A("player", "perk", "perk_shock", "blitzshock", undefined);
  level._id_A62B _id_AB1A("player", "perk", "perk_punch", "blitzpunch", undefined);
  level._id_A62B _id_AB1A("player", "general", "zmb_char_callout", "zmb_char_callout", undefined);
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
  self._id_90C4 = var_0;
  self._id_57DE = 1;
  self notify("speaking");
  var_6 = undefined;

  if(isDefined(var_3))
    var_6 = level.players;

  if(var_2 == "zmb_char_callout")
    _id_0378::_id_307E("plr_zom_zde_callout", var_6);
  else if(var_2 == "perk_ouch")
    _id_0378::_id_307E(var_0 + _id_0378::_id_307B(self._id_20D8), var_6);
  else if(common_scripts\utility::_id_562E(var_4)) {
    var_7 = _id_0367::_id_8EA0();
    var_8 = var_0 + var_7;

    if(_soundexists(var_8))
      _id_0378::_id_307E(var_8, var_6);
    else if(_soundexists(var_0))
      _id_0378::_id_307E(var_0, var_6);
  } else
    _id_0367::_id_8E3C(var_0, var_6);

  if(var_5 > 0)
    wait(var_5);

  self notify("done_speaking");
  level notify("done_speaking");
  self._id_57DE = 0;

  if(isDefined(level._id_A62B._id_90BE[self._id_AB1D]._id_7DB9) && isDefined(level._id_A62B._id_90BE[self._id_AB1D]._id_7DB9[var_1]) && isDefined(level._id_A62B._id_90BE[self._id_AB1D]._id_7DB9[var_1][var_2]))
    level thread _id_89B1(self, var_1, var_2, var_3);
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

  if(!isDefined(self._id_AB1D))
    return 0;

  if(common_scripts\utility::_id_562E(self._id_324E))
    return 0;

  if(!isDefined(self._id_57DE))
    self._id_57DE = 0;

  if(common_scripts\utility::_id_562E(self._id_57DE))
    return 0;

  if(!isDefined(var_3))
    var_3 = 0;

  if(!var_3 && !_id_1F13(self._id_AB1D, var_0, var_1))
    return 0;

  var_5 = "player";
  var_6 = undefined;
  var_7 = undefined;
  var_8 = 0;

  if(isshipzombiesmap()) {
    var_9 = _id_0367::_id_8E9F();

    if(!isDefined(var_9))
      return 0;

    var_7 = level._id_A62B._id_90BE[var_5]._id_0BB4[var_0][var_1];
    var_6 = var_9 + var_7;

    if(_soundexists(var_6 + "_lo") || _soundexists(var_6 + "_md") || _soundexists(var_6 + "_hi"))
      var_10 = 1;
  } else {
    var_11 = get_viable_gbl_aliases(var_5, var_0, var_1, self);

    if(var_11.size > 0) {
      var_7 = common_scripts\utility::random(var_11);
      var_8 = 1;
    } else if(var_1 == "perk_ouch")
      var_7 = level._id_A62B._id_90BE[var_5]._id_0BB4[var_0][var_1];
    else if(!_id_0547::_id_5565(self._id_20D8, 39))
      return 0;
  }

  if(isDefined(var_7)) {
    if(_id_0547::_id_5565(self._id_20D8, 39))
      thread _id_717E(var_7, var_0, "zmb_char_callout", var_4, var_8);
    else
      thread _id_717E(var_7, var_0, var_1, var_4, var_8);
  } else if(_id_0547::_id_5565(self._id_20D8, 39))
    thread _id_717E(var_7, var_0, "zmb_char_callout", var_4, var_8);

  return 1;
}

get_viable_gbl_aliases(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_5 = [];
  var_6 = [var_2, var_2 + "1", var_2 + "2", var_2 + "3", var_2 + "4", var_2 + "5"];
  var_7 = var_3._id_20D8;
  [var_9, var_10, var_11] = generate_possible_prefixes(var_7);

  foreach(var_13 in var_6) {
    if(isDefined(level._id_A62B._id_90BE[var_0]._id_0BB4[var_1][var_13])) {
      var_14 = level._id_A62B._id_90BE[var_0]._id_0BB4[var_1][var_13];

      if(isDefined(var_10) && var_11.size > 0) {
        foreach(var_16 in var_11) {
          if(_soundexists(var_16 + var_14) || _soundexists(var_16 + var_14 + "_lo") || _soundexists(var_16 + var_14 + "_md") || _soundexists(var_16 + var_14 + "_hi"))
            var_5[var_5.size] = var_16 + var_14;
        }
      }

      foreach(var_16 in var_9) {
        if(_soundexists(var_16 + var_14) || _soundexists(var_16 + var_14 + "_lo") || _soundexists(var_16 + var_14 + "_md") || _soundexists(var_16 + var_14 + "_hi"))
          var_4[var_4.size] = var_16 + var_14;
      }
    }
  }

  if(var_5.size > 0)
    return var_5;
  else
    return var_4;
}

generate_possible_prefixes(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = [];
  var_4 = ["zmb_ship_gbl_", "zmb_dlc_gbl_", "zmb_dlc_gbl2_"];
  var_5 = _id_0378::dlg_get_char_name_callouts_from_index(var_0);

  if(_isarray(var_5))
    var_1 = var_5;
  else
    var_1 = [var_5];

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

      if(_id_0547::_id_5565(var_0, 7))
        var_3 = common_scripts\utility::_id_0F6F(var_3, var_8 + "feml" + "_");
    }
  }

  return [var_2, var_6, var_3];
}

_id_89B1(var_0, var_1, var_2, var_3) {
  if(level.players.size == 1) {
    return;
  }
  if(!isDefined(var_3))
    var_3 = _id_464B(var_0);

  if(isDefined(var_3) && isDefined(var_3._id_AB1D)) {
    var_4 = level._id_A62B._id_90BE[var_3._id_AB1D]._id_7DB9[var_1][var_2];

    if(isDefined(var_4))
      var_3 _id_277F(var_1, var_4);
  }
}

_id_73AA() {
  self endon("disconnect");

  if(!isDefined(level._id_7337)) {
    level._id_7337 = 0;
    level._id_05AC = _id_0547::_id_4309();
  }

  for(;;) {
    waitframe();
    var_0 = gettime();

    if(var_0 > level._id_7337 + 1000) {
      level._id_7337 = var_0;
      level._id_05AC = _id_0547::_id_4309();
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
        var_6 = _id_4742(var_1[var_3].origin);
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

          if(isDefined(var_8))
            var_2 = _id_277F("enemy", var_8);

          break;
        }
      }
    }

    if(var_2)
      wait 15;
  }
}

player_zombie_char_ambient_noises() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    if(_id_0547::_id_5565(self._id_20D8, 39) && !common_scripts\utility::_id_562E(self._id_57DE)) {
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

_id_A60C(var_0, var_1) {
  var_2 = tablelookup(level._id_AB17, 0, var_0, 1);

  if(!isDefined(var_2) || var_2 == "") {
    if(isDefined(var_1) && var_1 == "exert")
      return 0.5;
    else if(isDefined(var_1) && var_1 == "conversation")
      return 3;
    else
      return 2;
  }

  var_2 = int(var_2);
  var_2 = var_2 * 0.001;
  return var_2;
}

_id_4742(var_0) {
  var_1 = var_0;
  var_2 = self.angles[1] - _id_4740(var_1);
  var_2 = _angleclamp180(var_2);
  return var_2;
}

_id_4740(var_0) {
  var_1 = vectortoangles(var_0 - self.origin);
  return var_1[1];
}

_id_3102(var_0, var_1, var_2) {
  _id_0366::_id_8E4B(var_0);
}

_id_55AE() {
  if(_id_056D::_id_45C2() <= 1)
    return 1;

  return 0;
}

_id_AB16(var_0) {
  if(var_0)
    level._id_AB13++;
  else
    level._id_AB13--;

  if(level._id_AB13 < 0)
    level._id_AB13 = 0;
}

_id_277E(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");
  self endon("disconnect");
  wait(var_5);
  thread _id_277D(var_0, var_1, var_2, var_3, var_4, var_6);
}

_id_277D(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(self._id_AB1D))
    return 0;

  if(level._id_AB13 > 0 && var_0 != "global_priority")
    return 0;

  if(common_scripts\utility::_id_562E(self._id_324E))
    return 0;

  if(_id_0547::_id_577D(self) && var_1 != "infected" && var_1 != "sq")
    return 0;

  if(!isDefined(self._id_57DE))
    self._id_57DE = 0;

  if(common_scripts\utility::_id_562E(self._id_57DE))
    return 0;

  if(_id_0F55(var_0))
    return 0;

  var_7 = isDefined(var_2);
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;

  if(!isDefined(level._id_A62B._id_90BE[self._id_AB1D]._id_0BB4[var_0]) || !isDefined(level._id_A62B._id_90BE[self._id_AB1D]._id_0BB4[var_0][var_1]))
    return 0;

  if(!isDefined(var_4))
    var_4 = 0;

  if(!var_4 && !_id_1F13(self._id_AB1D, var_0, var_1))
    return 0;

  var_11 = getarraykeys(level._id_A62B._id_90BE[self._id_AB1D]._id_7677);
  var_10 = level._id_A62B._id_90BE[self._id_AB1D]._id_7677[var_11[0]];
  var_8 = level._id_A62B._id_90BE[self._id_AB1D]._id_0BB4[var_0][var_1];

  if(isPlayer(self)) {
    if(self.sessionstate != "playing")
      return 0;

    if(_id_0547::_id_577E(self) && var_1 != "revive_down" && var_1 != "revive_up" && var_1 != "bonus_line_over")
      return 0;

    var_9 = _id_0547::_id_429D(self);
    var_10 = level._id_A62B._id_90BE[self._id_AB1D]._id_7677[var_9];
  }

  var_12 = "";

  if(var_0 == "conversation") {
    if(!isDefined(var_3))
      var_3 = 1;

    var_12 = _id_1D05("", var_8, var_3);

    if(!_soundexists(var_12))
      return 0;
  } else {
    if(var_7) {
      var_13 = var_2 + var_8;
      var_14 = "any_" + var_8;
      var_15 = _id_AB1C(var_10, var_14, var_3);

      if(isDefined(var_15) && _soundexists(var_15) && randomint(100) > 50)
        var_8 = var_14;
      else
        var_8 = var_13;
    }

    var_12 = _id_AB1C(var_10, var_8, var_3);

    if(!isDefined(var_12) && _soundexists(var_10 + var_8))
      var_12 = var_10 + var_8;
  }

  if(isDefined(var_12)) {
    if(!_soundexists(var_12))
      return 0;

    thread _id_30DC(var_10, var_9, var_12, var_0, var_1, var_7, var_5, var_3, var_6);
  } else
    return 0;

  return 1;
}

_id_30DC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("disconnect");
  self endon("stopSpeaking");
  var_9 = 0.25;

  if(var_3 == "exert")
    var_9 = 0;

  self._id_90C4 = var_2;
  self._id_57DE = 1;
  self notify("speaking");
  _id_74DB(var_2, var_3, var_4, var_8);

  if(var_9 > 0)
    wait(var_9);

  self notify("done_speaking");
  level notify("done_speaking");
  self._id_57DE = 0;

  if(var_3 == "conversation")
    level thread _id_87BB(self, var_1, var_3, var_4, var_6, var_7);
  else if(isDefined(level._id_A62B._id_90BE[self._id_AB1D]._id_7DB9) && isDefined(level._id_A62B._id_90BE[self._id_AB1D]._id_7DB9[var_3]) && isDefined(level._id_A62B._id_90BE[self._id_AB1D]._id_7DB9[var_3][var_4])) {
    if(isDefined(level._id_05A7))
      level thread[[level._id_05A7]](self, var_1, var_3, var_4, var_6);
    else
      level thread _id_89A9(self, var_1, var_3, var_4, var_6);
  }
}

_id_0F55(var_0) {
  return _id_0F5A() && !common_scripts\utility::_id_562E(self._id_509E) && var_0 != "global_priority" && var_0 != "exert" && var_0 != "conversation" && var_0 != "ignore_nearby" && var_0 != "sq";
}

_id_A7A1(var_0, var_1) {
  while(var_0 _id_0F5A())
    waitframe();
}

_id_734D() {
  self notify("stopSpeaking");

  if(common_scripts\utility::_id_562E(self._id_57DE) && isDefined(self._id_90C4)) {
    self stopsound(self._id_90C4);
    self._id_57DE = 0;
  }
}

_id_464B(var_0) {
  var_1 = 250000;
  var_2 = [];

  foreach(var_4 in level.players) {
    if(!isDefined(var_4) || var_4 == var_0) {
      continue;
    }
    var_5 = distancesquared(var_0.origin, var_4.origin) < var_1;

    if(var_5)
      var_2[var_2.size] = var_4;
  }

  if(var_2.size == 1)
    return var_2[0];
  else if(var_2.size > 1) {
    var_7 = _randomintrange(0, var_2.size);
    return var_2[var_7];
  }
}

_id_89A9(var_0, var_1, var_2, var_3, var_4) {
  if(level.players.size == 1) {
    return;
  }
  if(!isDefined(var_4))
    var_4 = _id_464B(var_0);

  if(isDefined(var_4)) {
    var_5 = level._id_A62B._id_90BE[var_4._id_AB1D]._id_7DB9[var_2][var_3];

    if(isDefined(var_5)) {
      var_6 = level._id_A62B._id_90BE[var_0._id_AB1D]._id_7677[var_1];
      var_4 _id_277D(var_2, var_5, var_6);
    }
  }
}

_id_87BB(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_4) && isalive(var_4))
    var_4 _id_277D(var_2, var_3, undefined, var_5 + 1, undefined, var_0);
}

_id_72D2(var_0, var_1, var_2, var_3) {
  thread _id_73A9(var_0, var_1, var_2, var_3);
}

_id_73A9(var_0, var_1, var_2, var_3) {
  self endon("disconnect");

  if(!isDefined(var_3) || common_scripts\utility::_id_562E(self._id_3E09)) {
    return;
  }
  var_2 = _getweaponbasename(var_2);
  var_4 = _id_7479(var_0, var_1, var_2, var_3);

  if(isDefined(var_4)) {
    self._id_3E09 = 1;
    wait 2;
    self._id_3E09 = 0;
  }
}

_id_1F13(var_0, var_1, var_2) {
  var_3 = _id_417C(var_0, var_1, var_2);
  return var_3 > _randomintrange(1, 100);
}

_id_417C(var_0, var_1, var_2) {
  if(!isDefined(level._id_A62B._id_90BE[var_0]) || !isDefined(level._id_A62B._id_90BE[var_0]._id_20AD) || !isDefined(level._id_A62B._id_90BE[var_0]._id_20AD[var_1]) || !isDefined(level._id_A62B._id_90BE[var_0]._id_20AD[var_1][var_2]))
    return 0;

  return level._id_A62B._id_90BE[var_0]._id_20AD[var_1][var_2];
}

_id_7479(var_0, var_1, var_2, var_3) {
  var_4 = "kill";

  if(_id_0547::_id_580B(var_2)) {
    return;
  }
  if(isDefined(var_3._id_0A4B) && var_3._id_0A4B == "zombie_treasurer")
    _id_277F("enemy", "treasurezombiewin");
}

_id_9A08(var_0, var_1) {
  self endon("disconnect");
  self endon("death");
  var_2 = gettime() + var_1 * 1000;

  while(gettime() < var_2) {
    if(self._id_5A36 > var_0) {
      thread _id_277E("kill", "streak", undefined, undefined, undefined, 1);
      wait 2;
      self._id_5A36 = 0;
      var_2 = -2;
    }

    wait 0.1;
  }

  wait 10;
  self._id_5A36 = 0;
  self._id_9A10 = 0;
}

_id_72A3(var_0, var_1, var_2) {}

_id_ABCD(var_0, var_1) {}

_id_741B() {
  if(!isDefined(self._id_66C3) || gettime() > self._id_66C3) {
    var_0 = _id_73DF("laugh");

    if(var_0)
      self._id_66C3 = gettime() + 15000;
  }
}

_id_72A4(var_0) {
  thread _id_277E("general", var_0, undefined, undefined, undefined, 1);
}

_id_0998(var_0) {
  if(!isDefined(level._id_683F))
    level._id_683F = [];

  if(common_scripts\utility::_id_562E(var_0))
    self._id_509E = 1;
  else
    self._id_509E = 0;

  self._id_575E = 1;
  level._id_683F[level._id_683F.size] = self;
}

_id_0F5A() {
  var_0 = 1000000;
  var_1 = 0;
  var_2 = level.players;

  if(isDefined(level._id_683F))
    var_2 = common_scripts\utility::_id_0F73(var_2, level._id_683F);

  foreach(var_4 in var_2) {
    if(self == var_4) {
      continue;
    }
    if(isPlayer(var_4)) {
      if(var_4.sessionstate != "playing" || _id_0547::_id_577E(var_4))
        continue;
    } else {}

    if(common_scripts\utility::_id_562E(var_4._id_57DE) && !common_scripts\utility::_id_562E(var_4._id_509E)) {
      if(distancesquared(self.origin, var_4.origin) < var_0) {
        var_1 = 1;
        break;
      }
    }
  }

  return var_1;
}

_id_AB1B() {
  var_0 = spawnStruct();
  var_0._id_90BE = [];
  return var_0;
}

_id_AB1E(var_0, var_1, var_2, var_3) {
  var_2._id_AB1D = var_0;

  if(!isDefined(self._id_90BE[var_0])) {
    self._id_90BE[var_0] = spawnStruct();
    self._id_90BE[var_0]._id_0BB4 = [];
    self._id_90BE[var_0]._id_7677 = [];
    self._id_90BE[var_0]._id_37E4 = [];
  }

  self._id_90BE[var_0]._id_37E4[var_3] = var_2;
  self._id_90BE[var_0]._id_7677[var_3] = var_1;
}

_id_AB1A(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(self._id_90BE[var_0])) {
    self._id_90BE[var_0] = spawnStruct();
    self._id_90BE[var_0]._id_0BB4 = [];
    self._id_90BE[var_0]._id_7677 = [];
    self._id_90BE[var_0]._id_37E4 = [];
  }

  if(!isDefined(self._id_90BE[var_0]._id_0BB4[var_1]))
    self._id_90BE[var_0]._id_0BB4[var_1] = [];

  self._id_90BE[var_0]._id_0BB4[var_1][var_2] = var_3;

  if(isDefined(var_4)) {
    if(!isDefined(self._id_90BE[var_0]._id_7DB9))
      self._id_90BE[var_0]._id_7DB9 = [];

    if(!isDefined(self._id_90BE[var_0]._id_7DB9[var_1]))
      self._id_90BE[var_0]._id_7DB9[var_1] = [];

    self._id_90BE[var_0]._id_7DB9[var_1][var_2] = var_4;
  }

  if(!isDefined(var_5))
    var_5 = 100;

  if(!isDefined(self._id_90BE[var_0]._id_20AD))
    self._id_90BE[var_0]._id_20AD = [];

  if(!isDefined(self._id_90BE[var_0]._id_20AD[var_1]))
    self._id_90BE[var_0]._id_20AD[var_1] = [];

  self._id_90BE[var_0]._id_20AD[var_1][var_2] = var_5;
}

_id_1D05(var_0, var_1, var_2) {
  if(var_2 < 10)
    return var_0 + var_1 + "_0" + var_2;
  else
    return var_0 + var_1 + "_" + var_2;
}

_id_AB1C(var_0, var_1, var_2) {
  if(!isDefined(self._id_8F2E)) {
    self._id_8F2E = [];
    self._id_8F2F = [];
  }

  if(!isDefined(self._id_8F2E[var_1])) {
    var_3 = _id_4255(var_0, var_1);

    if(var_3 <= 0)
      return undefined;

    for(var_4 = 0; var_4 < var_3; var_4++)
      self._id_8F2E[var_1][var_4] = var_4 + 1;

    self._id_8F2F[var_1] = [];
  }

  if(self._id_8F2F[var_1].size <= 0) {
    for(var_4 = 0; var_4 < self._id_8F2E[var_1].size; var_4++)
      self._id_8F2F[var_1][var_4] = self._id_8F2E[var_1][var_4];
  }

  var_5 = common_scripts\utility::random(self._id_8F2F[var_1]);
  self._id_8F2F[var_1] = common_scripts\utility::_id_0F93(self._id_8F2F[var_1], var_5);

  if(isDefined(var_2))
    var_5 = var_2;

  return _id_1D05(var_0, var_1, var_5);
}

_id_74DB(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1) && var_1 == "monologue")
    self playlocalsound(var_0);
  else if(isDefined(var_3) && var_3.size > 0) {
    foreach(var_5 in var_3) {
      if(isDefined(var_5))
        self playsoundtoplayer(var_0, var_5, 1);
    }
  } else
    self playsoundonmovingent(var_0);

  var_7 = _id_A60C(var_0, var_1);
  wait(var_7);
}

_id_4255(var_0, var_1) {
  for(var_2 = 1; var_2 < 30; var_2++) {
    if(!_soundexists(_id_1D05(var_0, var_1, var_2)))
      return var_2 - 1;
  }
}

_id_714C() {
  level thread _id_8A52();
  wait 1;

  if(isDefined(level._id_AB0F))
    level thread[[level._id_AB0F]]();
  else if(level.players.size == 1) {
    var_0 = _randomintrange(0, level.players.size);
    level.players[var_0] thread _id_277D("general", "intro");
  } else
    level thread _id_74EA("wave1", 1, 2, 0, 3);

  level._id_AB3E = 0;

  for(;;) {
    level waittill("zombie_wave_started");
    wait 1;
    var_1 = 1;

    if(isDefined(level._id_AB10))
      var_1 = [[level._id_AB10]](var_1);
    else {
      if(!var_1 && level._id_A980 == 2) {
        _id_74EA("wave2", 2, 0, 1, 3);
        var_1 = 1;
      } else if(!var_1 && (level._id_A980 == 5 || level._id_A980 == 10 || level._id_A980 == 20 || level._id_A980 == 35 || level._id_A980 == 50)) {
        var_0 = _randomintrange(0, level.players.size);
        level.players[var_0] _id_277D("general", "round_" + level._id_A980);
        var_1 = 1;
      }

      if(!var_1 && level._id_A980 > 2 && !level._id_AB3E) {
        var_2 = _randomintrange(0, 100);

        if(var_2 < 30) {
          _id_74EA("wave_early", 0, 2, 1, 3);
          level._id_AB3E = 0;
          var_1 = 1;
        }
      }
    }

    if(!var_1 && level._id_A980 > 1) {
      var_0 = _randomintrange(0, level.players.size);
      level.players[var_0] _id_277D("general", "wave_start");
      var_1 = 1;
    }

    level waittill("zombie_wave_ended");
    var_3 = 1;
    var_4 = 0;

    if(isDefined(level._id_AB12))
      var_3 = [[level._id_AB12]]();

    if(var_3) {
      wait 1;
      var_0 = _randomintrange(0, level.players.size);
      var_4 = level.players[var_0] _id_277D("general", "wave_end");

      if(var_4) {
        level.players[var_0] common_scripts\utility::waittill_notify_or_timeout("done_speaking", 6);
        wait 1;
      }
    }

    if(isDefined(level._id_AB1F))
      var_4 = [[level._id_AB1F]](var_4);

    if(!_id_74ED() && !var_4)
      _id_74E9();
  }
}

_id_74EA(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5))
    var_5 = "general";

  var_6 = _id_4454(var_1);

  if(isDefined(var_6) && var_6 _id_277D(var_5, var_0))
    level common_scripts\utility::waittill_notify_or_timeout("done_speaking", 6);

  var_6 = _id_4454(var_2);

  if(isDefined(var_6) && var_6 _id_277D(var_5, var_0))
    level common_scripts\utility::waittill_notify_or_timeout("done_speaking", 6);

  var_6 = _id_4454(var_3);

  if(isDefined(var_6) && var_6 _id_277D(var_5, var_0))
    level common_scripts\utility::waittill_notify_or_timeout("done_speaking", 6);

  var_6 = _id_4454(var_4);

  if(isDefined(var_6) && var_6 _id_277D(var_5, var_0))
    level common_scripts\utility::waittill_notify_or_timeout("done_speaking", 6);
}

_id_74ED() {
  if(level._id_A980 == 2) {
    var_0 = _id_462C();

    if(isDefined(var_0))
      return var_0 _id_277D("general", "weapon_reminder", undefined, 1);
  } else if(level._id_A980 == 10) {
    var_0 = _id_462B();

    if(isDefined(var_0))
      return var_0 _id_277D("general", "weapon_reminder", undefined, 2);
  }

  return 0;
}

_id_462C() {
  foreach(var_1 in level.players) {
    var_2 = var_1 getweaponlistprimaries();

    if(var_2.size == 1 && var_2[0] == "iw5_titan45zm_mp")
      return var_1;
  }
}

_id_7449(var_0) {
  foreach(var_2 in level.players)
  var_2 _id_277F("general", var_0);
}

_id_9D3A(var_0, var_1) {
  if(var_1)
    _id_277F("enemy", "treasurezombiewin");
  else
    _id_277F("enemy", "treasurezombiefail");
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

_id_462B() {
  foreach(var_1 in level.players) {
    var_2 = var_1 getweaponlistprimaries();

    foreach(var_4 in var_2) {
      if(_id_0547::_id_4747(var_1, var_4) < 1)
        return var_1;
    }
  }
}

_id_8A52() {
  level._id_AB49 = [];
  level._id_AB49[0] = _id_66A0();
  level._id_AB49[1] = _id_66A0();
}

_id_66A0() {
  var_0 = spawnStruct();
  var_0._id_20D9 = [];
  var_0._id_7677 = [];
  var_0.aiphysicstrace = 1;
  var_0._id_08BE = 0;
  var_0._id_2566 = 0;
  var_0._id_66CB = 1;
  return var_0;
}

_id_74E9() {
  if(level.players.size == 1 || !isDefined(level._id_A62B._id_90BE["player"]._id_0BB4["conversation"]))
    return 0;

  foreach(var_1 in level._id_AB49) {
    if(_id_2EBF(var_1) && _id_7211(var_1)) {
      _id_2EC1(var_1);
      return 1;
    }
  }

  foreach(var_1 in level._id_AB49) {
    if(!var_1._id_08BE && _id_27E1(var_1)) {
      if(_id_7211(var_1)) {
        _id_2EC1(var_1);
        return 1;
      } else
        return 0;
    }
  }

  return 0;
}

_id_2EBF(var_0) {
  return var_0._id_08BE && var_0._id_66CB <= level._id_A980 && _id_2EC0(var_0);
}

_id_2EC0(var_0) {
  if(var_0._id_20D9.size != 2)
    return 0;

  foreach(var_2 in var_0._id_20D9) {
    if(!isDefined(var_2) || !maps\mp\_utility::isreallyalive(var_2))
      return 0;
  }

  return 1;
}

_id_2EC1(var_0) {
  var_0._id_66CB = var_0._id_66CB + _randomintrange(2, 4);
  var_0.aiphysicstrace++;
}

_id_7401() {
  foreach(var_1 in level._id_AB49) {
    if(common_scripts\utility::_id_0F79(var_1._id_20D9, self))
      return 1;
  }

  return 0;
}

_id_27E1(var_0) {
  var_1 = common_scripts\utility::array_randomize(level.players);
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in var_1) {
    if(!var_5 _id_7401()) {
      if(!isDefined(var_2))
        var_2 = var_5;
      else
        var_3 = var_5;
    }

    if(isDefined(var_2) && isDefined(var_3)) {
      break;
    }
  }

  if(!isDefined(var_2) || !isDefined(var_3))
    return 0;

  var_0._id_20D9[0] = var_2;
  var_0._id_20D9[1] = var_3;
  var_0._id_7677[0] = level._id_A62B._id_90BE[var_2._id_AB1D]._id_7677[_id_0547::_id_429D(var_2)];
  var_0._id_7677[1] = level._id_A62B._id_90BE[var_3._id_AB1D]._id_7677[_id_0547::_id_429D(var_3)];
  var_0._id_08BE = 1;
  var_0._id_2566 = 0;
  return 1;
}

_id_7211(var_0) {
  var_1 = "" + var_0._id_7677[0] + var_0._id_7677[1] + var_0.aiphysicstrace;
  var_2 = var_0._id_20D9[0];
  var_3 = var_0._id_20D9[1];

  if(!isDefined(level._id_A62B._id_90BE["player"]._id_0BB4["conversation"][var_1])) {
    var_1 = "" + var_0._id_7677[1] + var_0._id_7677[0] + var_0.aiphysicstrace;
    var_2 = var_0._id_20D9[1];
    var_3 = var_0._id_20D9[0];

    if(!isDefined(level._id_A62B._id_90BE["player"]._id_0BB4["conversation"][var_1])) {
      var_0._id_2566 = 1;
      return 0;
    }
  }

  return var_2 _id_277D("conversation", var_1, undefined, undefined, undefined, var_3);
}

_id_4454(var_0) {
  foreach(var_2 in level.players) {
    if(var_2._id_20D8 == var_0)
      return var_2;
  }
}

_id_4456(var_0) {
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

_id_4455(var_0) {
  return _id_4454(_id_4456(var_0));
}

_id_441D(var_0) {
  var_1 = _id_4455(var_0);

  if(!isDefined(var_1))
    return level.players[randomint(level.players.size)];
  else {
    var_2 = common_scripts\utility::array_randomize(level.players);

    foreach(var_4 in level.players) {
      if(var_4 != var_1)
        return var_4;
    }
  }
}

_id_AB3D() {
  var_0 = _randomintrange(0, 3);
  _id_734D();
  _id_746A();
  _id_73DF("death" + var_0);
}

_id_AB3C(var_0) {
  if(isDefined(self._id_29AB) && self._id_29AB + 5000 > var_0) {
    return;
  }
  if(!common_scripts\utility::_id_562E(self._id_56E2)) {
    self._id_29AB = var_0;
    var_1 = _randomintrange(0, 3);
    _id_734D();
    _id_73DF("pain" + var_1);
  }
}

_id_73DF(var_0) {
  return 0;
}

_id_746A() {
  self notify("stopExerting");
  self._id_56E2 = undefined;
}

_id_38E0() {
  self endon("disconnect");
  self endon("stopExerting");
  wait 1;
  self._id_56E2 = 1;
  wait(_randomfloatrange(1.5, 3));
  self._id_56E2 = undefined;
}

_id_743B() {}

_id_743A() {}

_id_7448(var_0) {
  wait 1;

  if(self == var_0) {
    return;
  }
  if(var_0 _id_0547::_id_4BA7("specialty_class_covert_exfiltration_zm") && common_scripts\utility::_id_562E(var_0._id_569F))
    var_1 = var_0 _id_277F("mod_use", "mod_covertexfiltration", undefined, undefined, self);
  else
    var_1 = var_0 _id_277F("general", "revive_ally", undefined, undefined, self);
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
    if(_id_0547::_id_4BA7("specialty_class_serrated_edge_zm"))
      var_1 = "mod_serratededge";
    else if(_id_0547::_id_4BA7("specialty_class_saboteur_zm") && playerismaincast())
      var_1 = "mod_saboteur";
    else if(_id_0547::_id_4BA7("specialty_class_mobilization_zm") && (playerismaincast() || _id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self._id_20D8), "slay") || _id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self._id_20D8), "mount") || _id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self._id_20D8), "hunt") || _id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self._id_20D8), "surv")))
      var_1 = "mod_enhancedspeed";
  } else if(var_1 == "special_mad") {
    if(_id_0547::_id_4BA7("specialty_class_ammo_carrier_zm") && level.players.size > 1)
      var_1 = "mod_supplyammo";
    else if(_id_0547::_id_4BA7("specialty_class_squad_tactics_zm"))
      var_1 = "mod_headshot";
  } else if(var_1 == "special_burst") {
    if(_id_0547::_id_4BA7("specialty_class_bolster_morale_zm") && level.players.size > 1 && _id_73C3() && playerismaincast())
      var_1 = "mod_supplyarmor";
    else if(_id_0547::_id_4BA7("specialty_class_fiery_burst_zm"))
      var_1 = "mod_fieryburst";
    else if(_id_0547::_id_4BA7("specialty_class_exploit_weakness_zm") && (playerismaincast() || _id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self._id_20D8), "slay") || _id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self._id_20D8), "mount") || _id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self._id_20D8), "hunt") || _id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self._id_20D8), "surv")))
      var_1 = "mod_exploitweakness";
  } else if(var_1 == "special_taunt") {
    if(_id_0547::_id_4BA7("specialty_class_team_effort_zm") && level.players.size > 1)
      var_1 = "mod_teameffort";
    else if(_id_0547::_id_4BA7("specialty_class_come_get_zm"))
      var_1 = "mod_comeandgetit";
    else if(_id_0547::_id_4BA7("specialty_class_counter_offensive_zm") && (playerismaincast() || _id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self._id_20D8), "slay") || _id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self._id_20D8), "mount") || _id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self._id_20D8), "hunt") || _id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self._id_20D8), "surv")))
      var_1 = "mod_counteroffensive";
  } else if(var_1 == "special_melee") {}

  if(var_1 != var_2)
    var_0 = "mod_use";

  return [var_0, var_1];
}

playerismaincast() {
  if(_id_0547::_id_5565(_id_0378::_id_307B(self._id_20D8), "dros") || _id_0547::_id_5565(_id_0378::_id_307B(self._id_20D8), "jeff") || _id_0547::_id_5565(_id_0378::_id_307B(self._id_20D8), "mari") || _id_0547::_id_5565(_id_0378::_id_307B(self._id_20D8), "oliv"))
    return 1;
  else
    return 0;
}

_id_73C3() {
  var_0 = 0;
  var_1 = 518400;

  if(common_scripts\utility::_id_562E(_id_0547::_id_4BA7("specialty_class_breathing_room_zm")) && !common_scripts\utility::_id_562E(_id_0547::_id_4BA7("specialty_class_sustain_zone_zm")))
    var_1 = var_1 * 2.25;
  else if(!common_scripts\utility::_id_562E(_id_0547::_id_4BA7("specialty_class_breathing_room_zm")) && common_scripts\utility::_id_562E(_id_0547::_id_4BA7("specialty_class_sustain_zone_zm")))
    var_1 = var_1 * 0.25;

  foreach(var_3 in level.players) {
    if(var_3 == self) {
      continue;
    }
    if(_id_0547::_id_577E(var_3)) {
      continue;
    }
    if(distancesquared(self.origin, var_3.origin) < var_1) {
      if(_bullettracepassed(var_3 getEye(), self getEye(), 0, undefined))
        var_0 = 1;
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
  if(level.players.size > 1)
    _id_277F("general", var_0);
}

_id_73B9(var_0, var_1) {
  var_2 = "perk_ouch";

  if(isshipzombiesmap()) {
    if(common_scripts\utility::_id_562E(var_1)) {
      var_2 = "perk_first";

      if(var_0 == "electriccherry" && (_id_0547::_id_5565(_id_0378::_id_307B(self._id_20D8), "jeff") || _id_0547::_id_5565(_id_0378::_id_307B(self._id_20D8), "mari")))
        var_2 = "perk_shock";
      else if(var_0 == "punchperk" && _id_0547::_id_5565(_id_0378::_id_307B(self._id_20D8), "jeff"))
        var_2 = "perk_punch";
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
        if(_id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self._id_20D8), "slay") || _id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self._id_20D8), "mount") || _id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self._id_20D8), "hunt") || _id_0547::_id_5565(_id_0378::dlg_get_char_name_override_from_index(self._id_20D8), "surv"))
          var_2 = "perk_ouch";
        else
          var_2 = "perk_revive";

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
  if(common_scripts\utility::_id_562E(var_0))
    _id_277F("general", "newpackweapon");
  else {
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
  var_0 = maps\mp\_utility::_id_4571();

  if(var_0 == "mp_zombie_nest_01" || var_0 == "mp_zombie_house" || var_0 == "mp_zombie_training")
    return 1;
  else
    return 0;
}

_id_7491(var_0, var_1) {}

_id_73E4() {}

_id_62D9() {
  self playlocalsound("interact_purchase");
  _id_0378::_id_8D74("money_spend");
}