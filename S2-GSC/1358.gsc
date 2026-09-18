/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1358.gsc
*********************************************/

init() {
  level func_AB19();
  level thread lib_0554::init();
  if(isDefined(level.var_793)) {
    level thread[[level.var_793]]();
  }

  if(isDefined(level.var_792)) {
    level thread[[level.var_792]]();
  }

  if(!isDefined(level.var_AB17)) {
    level.var_AB17 = "mp/sound/soundlength_zm_mp.csv";
  }

  level.var_AB13 = 0;
}

func_AB19() {
  level.var_A62B = func_AB1B();
  level.var_A62B func_AB1A("player", "ability", "special_camo", "camouflage", undefined);
  level.var_A62B func_AB1A("player", "ability", "special_mad", "freefire", undefined);
  level.var_A62B func_AB1A("player", "ability", "special_taunt", "frontline", undefined);
  level.var_A62B func_AB1A("player", "ability", "special_burst", "shellshock", undefined);
  level.var_A62B func_AB1A("player", "mod_use", "mod_supplyammo", "supplyammomod", "thanks");
  level.var_A62B func_AB1A("player", "mod_use", "mod_headshot", "headshotmod", "mod_headshot_reply");
  level.var_A62B func_AB1A("player", "mod_use", "mod_headshot_reply", "headshot_reply", undefined);
  level.var_A62B func_AB1A("player", "mod_use", "mod_serratededge", "serreatededgemod", undefined);
  level.var_A62B func_AB1A("player", "mod_use", "mod_enhancedspeed", "enhancedspeedmod", undefined);
  level.var_A62B func_AB1A("player", "mod_use", "mod_covertexfiltration", "covertexfilration", "revived");
  level.var_A62B func_AB1A("player", "mod_use", "mod_saboteur", "saboteur", undefined);
  level.var_A62B func_AB1A("player", "mod_use", "mod_fieryburst", "fieryburstmod", undefined);
  level.var_A62B func_AB1A("player", "mod_use", "mod_exploitweakness", "exploitweaknessmod", undefined);
  level.var_A62B func_AB1A("player", "mod_use", "mod_supplyarmor", "givearmormod", "thanks2");
  level.var_A62B func_AB1A("player", "mod_use", "mod_comeandgetit", "comeandgetitmod", undefined);
  level.var_A62B func_AB1A("player", "mod_use", "mod_counteroffensive", "counteroffensivemod", undefined);
  level.var_A62B func_AB1A("player", "mod_use", "mod_teameffort", "teameffort", undefined);
  level.var_A62B func_AB1A("player", "general", "revive_ally", "modrevived", "revived");
  level.var_A62B func_AB1A("player", "general", "revived", "modrevived_reply", undefined);
  level.var_A62B func_AB1A("player", "general", "give_money", "givemoney", undefined, 25);
  level.var_A62B func_AB1A("player", "general", "needmoney", "givemoneyv1", undefined);
  level.var_A62B func_AB1A("player", "general", "nag_stop_killing", "nagstopkilling", undefined);
  level.var_A62B func_AB1A("player", "general", "thanks", "supplyammod_reply", undefined);
  level.var_A62B func_AB1A("player", "general", "thanks2", "givearmormod_reply", undefined);
  level.var_A62B func_AB1A("player", "general", "got_item", "explosivehandler_reply", undefined);
  level.var_A62B func_AB1A("player", "general", "got_item2", "givemoney_reply", undefined);
  level.var_A62B func_AB1A("player", "enemy", "treasurezombieseen", "treasurezombieseen", undefined);
  level.var_A62B func_AB1A("player", "enemy", "treasurezombiemove", "treasurezombiemove", undefined);
  level.var_A62B func_AB1A("player", "enemy", "treasurezombiefail", "treasurezombiefail", undefined);
  level.var_A62B func_AB1A("player", "enemy", "treasurezombiewarn", "treasurezombiewarn", undefined);
  level.var_A62B func_AB1A("player", "enemy", "treasurezombiewin", "treasurezombiewin", undefined);
  level.var_A62B func_AB1A("player", "enemy", "bombersee", "bombersee", undefined, 5);
  level.var_A62B func_AB1A("player", "enemy", "bomberkillshot", "bomberskillshot", undefined, 25);
  level.var_A62B func_AB1A("player", "enemy", "sprintersee", "sprintersee", undefined, 1);
  level.var_A62B func_AB1A("player", "enemy", "followersurpise", "followersurpise", undefined, 25);
  level.var_A62B func_AB1A("player", "enemy", "followeranger", "lookout", undefined, 25);
  level.var_A62B func_AB1A("player", "enemy", "firemansee", "firemanfearreact", undefined, 100);
  level.var_A62B func_AB1A("player", "perk", "perk_first", "vendingfirsttime", undefined);
  level.var_A62B func_AB1A("player", "perk", "perk_ouch", "plr_scripted_pain_lev3_", undefined);
  level.var_A62B func_AB1A("player", "perk", "perk_shock", "blitzshock", undefined);
  level.var_A62B func_AB1A("player", "perk", "perk_punch", "blitzpunch", undefined);
  level.var_A62B func_AB1A("player", "general", "zmb_char_callout", "zmb_char_callout", undefined);
  level.var_AB0E = [];
  level.var_AB0E["prefix"] = "zmb_";
  level.var_AB0E["zombie_generic"] = [];
  level.var_AB0E["zombie_generic"]["idle_low"] = "gen_idle_low";
  level.var_AB0E["zombie_generic"]["idle_high"] = "gen_idle_high";
  level.var_AB0E["zombie_generic"]["move"] = "gen_scream";
  level.var_AB0E["zombie_generic"]["attack"] = "gen_scream";
  level.var_AB0E["zombie_generic"]["spawn"] = "gen_spawn";
  level.var_AB0E["zombie_generic"]["taunt"] = "gen_scream";
  level.var_AB0E["zombie_generic"]["behind"] = "gen_behind";
  level.var_AB0E["zombie_generic"]["pain"] = "gen_pain";
  level.var_AB0E["zombie_dog"] = [];
  level.var_AB0E["zombie_dog"]["idle"] = "dog_idle";
  level.var_AB0E["zombie_dog"]["attack"] = "dog_bite";
  level.var_AB0E["zombie_dog"]["spawn"] = "dog_spawn";
  level.var_AB0E["zombie_dog"]["behind"] = "dog_behind";
  level.var_AB0E["zombie_dog"]["pain"] = "dog_pain";
  level.var_AB0E["zombie_host"] = [];
  level.var_AB0E["zombie_host"]["idle_low"] = "hst_scream";
  level.var_AB0E["zombie_host"]["idle_high"] = "hst_scream";
  level.var_AB0E["zombie_host"]["move"] = "hst_scream";
  level.var_AB0E["zombie_host"]["attack"] = "hst_attack_scream";
  level.var_AB0E["zombie_host"]["spawn"] = "hst_scream";
  level.var_AB0E["zombie_host"]["taunt"] = "hst_scream";
  level.var_AB0E["zombie_host"]["behind"] = "hst_behind";
  level.var_AB0E["zombie_host"]["pain"] = "hst_scream";
}

func_5165() {
  thread func_73AA();
  thread player_zombie_char_ambient_noises();
}

func_717E(param_00, param_01, param_02, param_03, param_04) {
  self endon("disconnect");
  self endon("stopSpeaking");
  var_05 = 0.25;
  self.var_90C4 = param_00;
  self.var_57DE = 1;
  self notify("speaking");
  var_06 = undefined;
  if(isDefined(param_03)) {
    var_06 = level.players;
  }

  if(param_02 == "zmb_char_callout") {
    lib_0378::func_307E("plr_zom_zde_callout", var_06);
  } else if(param_02 == "perk_ouch") {
    lib_0378::func_307E(param_00 + lib_0378::func_307B(self.var_20D8), var_06);
  } else if(common_scripts\utility::func_562E(param_04)) {
    var_07 = lib_0367::func_8EA0();
    var_08 = param_00 + var_07;
    if(function_0344(var_08)) {
      lib_0378::func_307E(var_08, var_06);
    } else if(function_0344(param_00)) {
      lib_0378::func_307E(param_00, var_06);
    }
  } else {
    lib_0367::func_8E3C(param_00, var_06);
  }

  if(var_05 > 0) {
    wait(var_05);
  }

  self notify("done_speaking");
  level notify("done_speaking");
  self.var_57DE = 0;
  if(isDefined(level.var_A62B.var_90BE[self.var_AB1D].var_7DB9) && isDefined(level.var_A62B.var_90BE[self.var_AB1D].var_7DB9[param_01]) && isDefined(level.var_A62B.var_90BE[self.var_AB1D].var_7DB9[param_01][param_02])) {
    level thread func_89B1(self, param_01, param_02, param_03);
  }
}

func_2780(param_00, param_01, param_02, param_03, param_04, param_05) {
  self endon("death");
  self endon("disconnect");
  wait(param_00);
  thread func_277F(param_01, param_02, param_03, param_04, param_05);
}

func_277F(param_00, param_01, param_02, param_03, param_04) {
  self endon("death");
  self endon("disconnect");
  if(!isDefined(self.var_AB1D)) {
    return 0;
  }

  if(common_scripts\utility::func_562E(self.var_324E)) {
    return 0;
  }

  if(!isDefined(self.var_57DE)) {
    self.var_57DE = 0;
  }

  if(common_scripts\utility::func_562E(self.var_57DE)) {
    return 0;
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  if(!param_03 && !func_1F13(self.var_AB1D, param_00, param_01)) {
    return 0;
  }

  var_05 = "player";
  var_06 = undefined;
  var_07 = undefined;
  var_08 = 0;
  if(isshipzombiesmap()) {
    var_09 = lib_0367::func_8E9F();
    if(!isDefined(var_09)) {
      return 0;
    }

    var_07 = level.var_A62B.var_90BE[var_05].var_BB4[param_00][param_01];
    var_06 = var_09 + var_07;
    if(function_0344(var_06 + "_lo") || function_0344(var_06 + "_md") || function_0344(var_06 + "_hi")) {
      var_0A = 1;
    }
  } else {
    var_0B = get_viable_gbl_aliases(var_05, param_00, param_01, self);
    if(var_0B.size > 0) {
      var_07 = common_scripts\utility::random(var_0B);
      var_08 = 1;
    } else if(param_01 == "perk_ouch") {
      var_07 = level.var_A62B.var_90BE[var_05].var_BB4[param_00][param_01];
    } else if(!lib_0547::func_5565(self.var_20D8, 39)) {
      return 0;
    }
  }

  if(isDefined(var_07)) {
    if(lib_0547::func_5565(self.var_20D8, 39)) {
      thread func_717E(var_07, param_00, "zmb_char_callout", param_04, var_08);
    } else {
      thread func_717E(var_07, param_00, param_01, param_04, var_08);
    }
  } else if(lib_0547::func_5565(self.var_20D8, 39)) {
    thread func_717E(var_07, param_00, "zmb_char_callout", param_04, var_08);
  }

  return 1;
}

get_viable_gbl_aliases(param_00, param_01, param_02, param_03) {
  var_04 = [];
  var_05 = [];
  var_06 = [param_02, param_02 + "1", param_02 + "2", param_02 + "3", param_02 + "4", param_02 + "5"];
  var_07 = param_03.var_20D8;
  var_08 = generate_possible_prefixes(var_07);
  var_09 = var_08[0];
  var_0A = var_08[1];
  var_0B = var_08[2];
  foreach(var_0D in var_06) {
    if(isDefined(level.var_A62B.var_90BE[param_00].var_BB4[param_01][var_0D])) {
      var_0E = level.var_A62B.var_90BE[param_00].var_BB4[param_01][var_0D];
      if(isDefined(var_0A) && var_0B.size > 0) {
        foreach(var_10 in var_0B) {
          if(function_0344(var_10 + var_0E) || function_0344(var_10 + var_0E + "_lo") || function_0344(var_10 + var_0E + "_md") || function_0344(var_10 + var_0E + "_hi")) {
            var_05[var_05.size] = var_10 + var_0E;
          }
        }
      }

      foreach(var_10 in var_09) {
        if(function_0344(var_10 + var_0E) || function_0344(var_10 + var_0E + "_lo") || function_0344(var_10 + var_0E + "_md") || function_0344(var_10 + var_0E + "_hi")) {
          var_04[var_04.size] = var_10 + var_0E;
        }
      }
    }
  }

  if(var_05.size > 0) {
    return var_05;
  }

  return var_04;
}

generate_possible_prefixes(param_00) {
  var_01 = [];
  var_02 = [];
  var_03 = [];
  var_04 = ["zmb_ship_gbl_", "zmb_dlc_gbl_", "zmb_dlc_gbl2_"];
  var_05 = lib_0378::dlg_get_char_name_callouts_from_index(param_00);
  if(isarray(var_05)) {
    var_01 = var_05;
  } else {
    var_01 = [var_05];
  }

  var_06 = lib_0378::dlg_get_char_name_override_from_index(param_00);
  foreach(var_08 in var_04) {
    foreach(var_0A in var_01) {
      var_0B = var_08 + var_0A + "_";
      var_02 = common_scripts\utility::func_F6F(var_02, var_0B);
    }

    if(isDefined(var_06)) {
      var_0D = var_08 + var_06 + "_";
      var_02 = common_scripts\utility::func_F6F(var_02, var_0D);
      var_03 = common_scripts\utility::func_F6F(var_03, var_0D);
      if(lib_0547::func_5565(param_00, 7)) {
        var_03 = common_scripts\utility::func_F6F(var_03, var_08 + "feml" + "_");
      }
    }
  }

  return [var_02, var_06, var_03];
}

func_89B1(param_00, param_01, param_02, param_03) {
  if(level.players.size == 1) {
    return;
  }

  if(!isDefined(param_03)) {
    param_03 = func_464B(param_00);
  }

  if(isDefined(param_03) && isDefined(param_03.var_AB1D)) {
    var_04 = level.var_A62B.var_90BE[param_03.var_AB1D].var_7DB9[param_01][param_02];
    if(isDefined(var_04)) {
      param_03 func_277F(param_01, var_04);
    }
  }
}

func_73AA() {
  self endon("disconnect");
  if(!isDefined(level.var_7337)) {
    level.var_7337 = 0;
    level.var_5AC = lib_0547::func_4309();
  }

  for(;;) {
    wait 0.05;
    var_00 = gettime();
    if(var_00 > level.var_7337 + 1000) {
      level.var_7337 = var_00;
      level.var_5AC = lib_0547::func_4309();
    }

    var_01 = level.var_5AC;
    var_02 = 0;
    for(var_03 = 0; var_03 < var_01.size; var_03++) {
      if(!isDefined(var_01[var_03]) || !isDefined(var_01[var_03].var_A4B) || !isDefined(var_01[var_03].enemy) || var_01[var_03].enemy != self || common_scripts\utility::func_562E(var_01[var_03].var_8385)) {
        continue;
      }

      var_04 = 200;
      var_05 = 50;
      if(isDefined(var_01[var_03].var_ABDF)) {
        switch (var_01[var_03].var_ABDF) {
          case "walk":
            var_04 = 200;
            break;

          case "run":
            var_04 = 250;
            break;

          case "sprint":
            var_04 = 275;
            break;
        }
      }

      if(distancesquared(var_01[var_03].origin, self.origin) < var_04 * var_04) {
        var_06 = func_4742(var_01[var_03].origin);
        var_07 = self.origin[2] - var_01[var_03].origin[2];
        if(var_06 > -95 && var_06 < 95 && abs(var_07) < 50) {
          var_01[var_03].var_8385 = 1;
          var_08 = undefined;
          switch (var_01[var_03].var_A4B) {
            case "zombie_fireman":
              var_08 = "firemansee";
              break;

            case "zombie_exploder":
              var_08 = "bombersee";
              break;

            case "zombie_berserker":
              var_08 = "sprintersee";
              break;
          }

          if(isDefined(var_08)) {
            var_02 = func_277F("enemy", var_08);
          }

          break;
        }
      }
    }

    if(var_02) {
      wait(15);
    }
  }
}

player_zombie_char_ambient_noises() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    if(lib_0547::func_5565(self.var_20D8, 39) && !common_scripts\utility::func_562E(self.var_57DE)) {
      switch (randomint(7)) {
        case 0:
          self playSound("zvox_gen_growl_lev1");
          break;

        default:
          break;
      }
    }

    wait(randomfloatrange(6, 10));
  }
}

func_A60C(param_00, param_01) {
  var_02 = tablelookup(level.var_AB17, 0, param_00, 1);
  if(!isDefined(var_02) || var_02 == "") {
    if(isDefined(param_01) && param_01 == "exert") {
      return 0.5;
    } else if(isDefined(param_01) && param_01 == "conversation") {
      return 3;
    } else {
      return 2;
    }
  }

  var_02 = int(var_02);
  var_02 = var_02 * 0.001;
  return var_02;
}

func_4742(param_00) {
  var_01 = param_00;
  var_02 = self.angles[1] - func_4740(var_01);
  var_02 = angleclamp180(var_02);
  return var_02;
}

func_4740(param_00) {
  var_01 = vectortoangles(param_00 - self.origin);
  return var_01[1];
}

func_3102(param_00, param_01, param_02) {
  lib_0366::func_8E4B(param_00);
}

func_55AE() {
  if(lib_056D::func_45C2() <= 1) {
    return 1;
  }

  return 0;
}

func_AB16(param_00) {
  if(param_00) {
    level.var_AB13++;
  } else {
    level.var_AB13--;
  }

  if(level.var_AB13 < 0) {
    level.var_AB13 = 0;
  }
}

func_277E(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  self endon("death");
  self endon("disconnect");
  wait(param_05);
  thread func_277D(param_00, param_01, param_02, param_03, param_04, param_06);
}

func_277D(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(!isDefined(self.var_AB1D)) {
    return 0;
  }

  if(level.var_AB13 > 0 && param_00 != "global_priority") {
    return 0;
  }

  if(common_scripts\utility::func_562E(self.var_324E)) {
    return 0;
  }

  if(lib_0547::func_577D(self) && param_01 != "infected" && param_01 != "sq") {
    return 0;
  }

  if(!isDefined(self.var_57DE)) {
    self.var_57DE = 0;
  }

  if(common_scripts\utility::func_562E(self.var_57DE)) {
    return 0;
  }

  if(func_0F55(param_00)) {
    return 0;
  }

  var_07 = isDefined(param_02);
  var_08 = undefined;
  var_09 = undefined;
  var_0A = undefined;
  if(!isDefined(level.var_A62B.var_90BE[self.var_AB1D].var_BB4[param_00]) || !isDefined(level.var_A62B.var_90BE[self.var_AB1D].var_BB4[param_00][param_01])) {
    return 0;
  }

  if(!isDefined(param_04)) {
    param_04 = 0;
  }

  if(!param_04 && !func_1F13(self.var_AB1D, param_00, param_01)) {
    return 0;
  }

  var_0B = getarraykeys(level.var_A62B.var_90BE[self.var_AB1D].var_7677);
  var_0A = level.var_A62B.var_90BE[self.var_AB1D].var_7677[var_0B[0]];
  var_08 = level.var_A62B.var_90BE[self.var_AB1D].var_BB4[param_00][param_01];
  if(isPlayer(self)) {
    if(self.sessionstate != "playing") {
      return 0;
    }

    if(lib_0547::func_577E(self) && param_01 != "revive_down" && param_01 != "revive_up" && param_01 != "bonus_line_over") {
      return 0;
    }

    var_09 = lib_0547::func_429D(self);
    var_0A = level.var_A62B.var_90BE[self.var_AB1D].var_7677[var_09];
  }

  var_0C = "";
  if(param_00 == "conversation") {
    if(!isDefined(param_03)) {
      param_03 = 1;
    }

    var_0C = func_1D05("", var_08, param_03);
    if(!function_0344(var_0C)) {
      return 0;
    }
  } else {
    if(var_07) {
      var_0D = param_02 + var_08;
      var_0E = "any_" + var_08;
      var_0F = func_AB1C(var_0A, var_0E, param_03);
      if(isDefined(var_0F) && function_0344(var_0F) && randomint(100) > 50) {
        var_08 = var_0E;
      } else {
        var_08 = var_0D;
      }
    }

    var_0C = func_AB1C(var_0A, var_08, param_03);
    if(!isDefined(var_0C) && function_0344(var_0A + var_08)) {
      var_0C = var_0A + var_08;
    }
  }

  if(isDefined(var_0C)) {
    if(!function_0344(var_0C)) {
      return 0;
    }

    thread func_30DC(var_0A, var_09, var_0C, param_00, param_01, var_07, param_05, param_03, param_06);
  } else {
    return 0;
  }

  return 1;
}

func_30DC(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  self endon("disconnect");
  self endon("stopSpeaking");
  var_09 = 0.25;
  if(param_03 == "exert") {
    var_09 = 0;
  }

  self.var_90C4 = param_02;
  self.var_57DE = 1;
  self notify("speaking");
  func_74DB(param_02, param_03, param_04, param_08);
  if(var_09 > 0) {
    wait(var_09);
  }

  self notify("done_speaking");
  level notify("done_speaking");
  self.var_57DE = 0;
  if(param_03 == "conversation") {
    level thread func_87BB(self, param_01, param_03, param_04, param_06, param_07);
    return;
  }

  if(isDefined(level.var_A62B.var_90BE[self.var_AB1D].var_7DB9) && isDefined(level.var_A62B.var_90BE[self.var_AB1D].var_7DB9[param_03]) && isDefined(level.var_A62B.var_90BE[self.var_AB1D].var_7DB9[param_03][param_04])) {
    if(isDefined(level.var_5A7)) {
      level thread[[level.var_5A7]](self, param_01, param_03, param_04, param_06);
      return;
    }

    level thread func_89A9(self, param_01, param_03, param_04, param_06);
    return;
  }
}

func_0F55(param_00) {
  return func_0F5A() && !common_scripts\utility::func_562E(self.var_509E) && param_00 != "global_priority" && param_00 != "exert" && param_00 != "conversation" && param_00 != "ignore_nearby" && param_00 != "sq";
}

func_A7A1(param_00, param_01) {
  while(param_00 func_0F5A()) {
    wait 0.05;
  }
}

func_734D() {
  self notify("stopSpeaking");
  if(common_scripts\utility::func_562E(self.var_57DE) && isDefined(self.var_90C4)) {
    self method_8613(self.var_90C4);
    self.var_57DE = 0;
  }
}

func_464B(param_00) {
  var_01 = 250000;
  var_02 = [];
  foreach(var_04 in level.players) {
    if(!isDefined(var_04) || var_04 == param_00) {
      continue;
    }

    var_05 = distancesquared(param_00.origin, var_04.origin) < var_01;
    if(var_05) {
      var_02[var_02.size] = var_04;
    }
  }

  if(var_02.size == 1) {
    return var_02[0];
  }

  if(var_02.size > 1) {
    var_07 = randomintrange(0, var_02.size);
    return var_02[var_07];
  }
}

func_89A9(param_00, param_01, param_02, param_03, param_04) {
  if(level.players.size == 1) {
    return;
  }

  if(!isDefined(param_04)) {
    param_04 = func_464B(param_00);
  }

  if(isDefined(param_04)) {
    var_05 = level.var_A62B.var_90BE[param_04.var_AB1D].var_7DB9[param_02][param_03];
    if(isDefined(var_05)) {
      var_06 = level.var_A62B.var_90BE[param_00.var_AB1D].var_7677[param_01];
      param_04 func_277D(param_02, var_05, var_06);
    }
  }
}

func_87BB(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(isDefined(param_04) && isalive(param_04)) {
    param_04 func_277D(param_02, param_03, undefined, param_05 + 1, undefined, param_00);
  }
}

func_72D2(param_00, param_01, param_02, param_03) {
  thread func_73A9(param_00, param_01, param_02, param_03);
}

func_73A9(param_00, param_01, param_02, param_03) {
  self endon("disconnect");
  if(!isDefined(param_03) || common_scripts\utility::func_562E(self.var_3E09)) {
    return;
  }

  param_02 = getweapondisplayname(param_02);
  var_04 = func_7479(param_00, param_01, param_02, param_03);
  if(isDefined(var_04)) {
    self.var_3E09 = 1;
    wait(2);
    self.var_3E09 = 0;
  }
}

func_1F13(param_00, param_01, param_02) {
  var_03 = func_417C(param_00, param_01, param_02);
  return var_03 > randomintrange(1, 100);
}

func_417C(param_00, param_01, param_02) {
  if(!isDefined(level.var_A62B.var_90BE[param_00]) || !isDefined(level.var_A62B.var_90BE[param_00].var_20AD) || !isDefined(level.var_A62B.var_90BE[param_00].var_20AD[param_01]) || !isDefined(level.var_A62B.var_90BE[param_00].var_20AD[param_01][param_02])) {
    return 0;
  }

  return level.var_A62B.var_90BE[param_00].var_20AD[param_01][param_02];
}

func_7479(param_00, param_01, param_02, param_03) {
  var_04 = "kill";
  if(lib_0547::func_580B(param_02)) {
    return;
  }

  if(isDefined(param_03.var_A4B) && param_03.var_A4B == "zombie_treasurer") {
    func_277F("enemy", "treasurezombiewin");
  }
}

func_9A08(param_00, param_01) {
  self endon("disconnect");
  self endon("death");
  var_02 = gettime() + param_01 * 1000;
  while(gettime() < var_02) {
    if(self.var_5A36 > param_00) {
      thread func_277E("kill", "streak", undefined, undefined, undefined, 1);
      wait(2);
      self.var_5A36 = 0;
      var_02 = -2;
    }

    wait(0.1);
  }

  wait(10);
  self.var_5A36 = 0;
  self.var_9A10 = 0;
}

func_72A3(param_00, param_01, param_02) {}

func_ABCD(param_00, param_01) {}

func_741B() {
  if(!isDefined(self.var_66C3) || gettime() > self.var_66C3) {
    var_00 = func_73DF("laugh");
    if(var_00) {
      self.var_66C3 = gettime() + 15000;
    }
  }
}

func_72A4(param_00) {
  thread func_277E("general", param_00, undefined, undefined, undefined, 1);
}

destroyelem(param_00) {
  if(!isDefined(level.var_683F)) {
    level.var_683F = [];
  }

  if(common_scripts\utility::func_562E(param_00)) {
    self.var_509E = 1;
  } else {
    self.var_509E = 0;
  }

  self.var_575E = 1;
  level.var_683F[level.var_683F.size] = self;
}

func_0F5A() {
  var_00 = 1000000;
  var_01 = 0;
  var_02 = level.players;
  if(isDefined(level.var_683F)) {
    var_02 = common_scripts\utility::func_F73(var_02, level.var_683F);
  }

  foreach(var_04 in var_02) {
    if(self == var_04) {
      continue;
    }

    if(isPlayer(var_04)) {
      if(var_04.sessionstate != "playing" || lib_0547::func_577E(var_04)) {
        continue;
      }
    } else {}

    if(common_scripts\utility::func_562E(var_04.var_57DE) && !common_scripts\utility::func_562E(var_04.var_509E)) {
      if(distancesquared(self.origin, var_04.origin) < var_00) {
        var_01 = 1;
        break;
      }
    }
  }

  return var_01;
}

func_AB1B() {
  var_00 = spawnStruct();
  var_00.var_90BE = [];
  return var_00;
}

func_AB1E(param_00, param_01, param_02, param_03) {
  param_02.var_AB1D = param_00;
  if(!isDefined(self.var_90BE[param_00])) {
    self.var_90BE[param_00] = spawnStruct();
    self.var_90BE[param_00].var_BB4 = [];
    self.var_90BE[param_00].var_7677 = [];
    self.var_90BE[param_00].var_37E4 = [];
  }

  self.var_90BE[param_00].var_37E4[param_03] = param_02;
  self.var_90BE[param_00].var_7677[param_03] = param_01;
}

func_AB1A(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(self.var_90BE[param_00])) {
    self.var_90BE[param_00] = spawnStruct();
    self.var_90BE[param_00].var_BB4 = [];
    self.var_90BE[param_00].var_7677 = [];
    self.var_90BE[param_00].var_37E4 = [];
  }

  if(!isDefined(self.var_90BE[param_00].var_BB4[param_01])) {
    self.var_90BE[param_00].var_BB4[param_01] = [];
  }

  self.var_90BE[param_00].var_BB4[param_01][param_02] = param_03;
  if(isDefined(param_04)) {
    if(!isDefined(self.var_90BE[param_00].var_7DB9)) {
      self.var_90BE[param_00].var_7DB9 = [];
    }

    if(!isDefined(self.var_90BE[param_00].var_7DB9[param_01])) {
      self.var_90BE[param_00].var_7DB9[param_01] = [];
    }

    self.var_90BE[param_00].var_7DB9[param_01][param_02] = param_04;
  }

  if(!isDefined(param_05)) {
    param_05 = 100;
  }

  if(!isDefined(self.var_90BE[param_00].var_20AD)) {
    self.var_90BE[param_00].var_20AD = [];
  }

  if(!isDefined(self.var_90BE[param_00].var_20AD[param_01])) {
    self.var_90BE[param_00].var_20AD[param_01] = [];
  }

  self.var_90BE[param_00].var_20AD[param_01][param_02] = param_05;
}

func_1D05(param_00, param_01, param_02) {
  if(param_02 < 10) {
    return param_00 + param_01 + "_0" + param_02;
  }

  return param_00 + param_01 + "_" + param_02;
}

func_AB1C(param_00, param_01, param_02) {
  if(!isDefined(self.var_8F2E)) {
    self.var_8F2E = [];
    self.var_8F2F = [];
  }

  if(!isDefined(self.var_8F2E[param_01])) {
    var_03 = func_4255(param_00, param_01);
    if(var_03 <= 0) {
      return undefined;
    }

    for(var_04 = 0; var_04 < var_03; var_04++) {
      self.var_8F2E[param_01][var_04] = var_04 + 1;
    }

    self.var_8F2F[param_01] = [];
  }

  if(self.var_8F2F[param_01].size <= 0) {
    for(var_04 = 0; var_04 < self.var_8F2E[param_01].size; var_04++) {
      self.var_8F2F[param_01][var_04] = self.var_8F2E[param_01][var_04];
    }
  }

  var_05 = common_scripts\utility::random(self.var_8F2F[param_01]);
  self.var_8F2F[param_01] = common_scripts\utility::func_F93(self.var_8F2F[param_01], var_05);
  if(isDefined(param_02)) {
    var_05 = param_02;
  }

  return func_1D05(param_00, param_01, var_05);
}

func_74DB(param_00, param_01, param_02, param_03) {
  if(isDefined(param_01) && param_01 == "monologue") {
    self playlocalsound(param_00);
  } else if(isDefined(param_03) && param_03.size > 0) {
    foreach(var_05 in param_03) {
      if(isDefined(var_05)) {
        self method_860F(param_00, var_05, 1);
      }
    }
  } else {
    self playsoundonmovingent(param_00);
  }

  var_07 = func_A60C(param_00, param_01);
  wait(var_07);
}

func_4255(param_00, param_01) {
  for(var_02 = 1; var_02 < 30; var_02++) {
    if(!function_0344(func_1D05(param_00, param_01, var_02))) {
      return var_02 - 1;
    }
  }
}

func_714C() {
  level thread func_8A52();
  wait(1);
  if(isDefined(level.var_AB0F)) {
    level thread[[level.var_AB0F]]();
  } else if(level.players.size == 1) {
    var_00 = randomintrange(0, level.players.size);
    level.players[var_00] thread func_277D("general", "intro");
  } else {
    level thread func_74EA("wave1", 1, 2, 0, 3);
  }

  level.var_AB3E = 0;
  for(;;) {
    level waittill("zombie_wave_started");
    wait(1);
    var_01 = 1;
    if(isDefined(level.var_AB10)) {
      var_01 = [[level.var_AB10]](var_01);
    } else {
      if(!var_01 && level.var_A980 == 2) {
        func_74EA("wave2", 2, 0, 1, 3);
        var_01 = 1;
      } else if(!var_01 && level.var_A980 == 5 || level.var_A980 == 10 || level.var_A980 == 20 || level.var_A980 == 35 || level.var_A980 == 50) {
        var_00 = randomintrange(0, level.players.size);
        level.players[var_00] func_277D("general", "round_" + level.var_A980);
        var_01 = 1;
      }

      if(!var_01 && level.var_A980 > 2 && !level.var_AB3E) {
        var_02 = randomintrange(0, 100);
        if(var_02 < 30) {
          func_74EA("wave_early", 0, 2, 1, 3);
          level.var_AB3E = 0;
          var_01 = 1;
        }
      }
    }

    if(!var_01 && level.var_A980 > 1) {
      var_00 = randomintrange(0, level.players.size);
      level.players[var_00] func_277D("general", "wave_start");
      var_01 = 1;
    }

    level waittill("zombie_wave_ended");
    var_03 = 1;
    var_04 = 0;
    if(isDefined(level.var_AB12)) {
      var_03 = [[level.var_AB12]]();
    }

    if(var_03) {
      wait(1);
      var_00 = randomintrange(0, level.players.size);
      var_04 = level.players[var_00] func_277D("general", "wave_end");
      if(var_04) {
        level.players[var_00] common_scripts\utility::waittill_notify_or_timeout("done_speaking", 6);
        wait(1);
      }
    }

    if(isDefined(level.var_AB1F)) {
      var_04 = [[level.var_AB1F]](var_04);
    }

    if(!func_74ED() && !var_04) {
      func_74E9();
    }
  }
}

func_74EA(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(param_05)) {
    param_05 = "general";
  }

  var_06 = func_4454(param_01);
  if(isDefined(var_06) && var_06 func_277D(param_05, param_00)) {
    level common_scripts\utility::waittill_notify_or_timeout("done_speaking", 6);
  }

  var_06 = func_4454(param_02);
  if(isDefined(var_06) && var_06 func_277D(param_05, param_00)) {
    level common_scripts\utility::waittill_notify_or_timeout("done_speaking", 6);
  }

  var_06 = func_4454(param_03);
  if(isDefined(var_06) && var_06 func_277D(param_05, param_00)) {
    level common_scripts\utility::waittill_notify_or_timeout("done_speaking", 6);
  }

  var_06 = func_4454(param_04);
  if(isDefined(var_06) && var_06 func_277D(param_05, param_00)) {
    level common_scripts\utility::waittill_notify_or_timeout("done_speaking", 6);
  }
}

func_74ED() {
  if(level.var_A980 == 2) {
    var_00 = func_462C();
    if(isDefined(var_00)) {
      return var_00 func_277D("general", "weapon_reminder", undefined, 1);
    }
  } else if(level.var_A980 == 10) {
    var_00 = func_462B();
    if(isDefined(var_00)) {
      return var_00 func_277D("general", "weapon_reminder", undefined, 2);
    }
  }

  return 0;
}

func_462C() {
  foreach(var_01 in level.players) {
    var_02 = var_01 getweaponslistprimaries();
    if(var_02.size == 1 && var_02[0] == "iw5_titan45zm_mp") {
      return var_01;
    }
  }
}

func_7449(param_00) {
  foreach(var_02 in level.players) {
    var_02 func_277F("general", param_00);
  }
}

func_9D3A(param_00, param_01) {
  if(param_01) {
    func_277F("enemy", "treasurezombiewin");
    return;
  }

  func_277F("enemy", "treasurezombiefail");
}

func_9D39() {
  func_277F("enemy", "treasurezombiewarn");
}

func_7465() {
  func_277F("enemy", "treasurezombieseen");
  func_277F("enemy", "treasurezombiemove");
}

func_18EC() {
  func_277F("enemy", "bomberkillshot");
}

func_73B3() {
  func_2780(1, "enemy", "followeranger");
}

func_462B() {
  foreach(var_01 in level.players) {
    var_02 = var_01 getweaponslistprimaries();
    foreach(var_04 in var_02) {
      if(lib_0547::func_4747(var_01, var_04) < 1) {
        return var_01;
      }
    }
  }
}

func_8A52() {
  level.var_AB49 = [];
  level.var_AB49[0] = func_66A0();
  level.var_AB49[1] = func_66A0();
}

func_66A0() {
  var_00 = spawnStruct();
  var_00.var_20D9 = [];
  var_00.var_7677 = [];
  var_00.var_83EB = 1;
  var_00.var_8BE = 0;
  var_00.var_2566 = 0;
  var_00.var_66CB = 1;
  return var_00;
}

func_74E9() {
  if(level.players.size == 1 || !isDefined(level.var_A62B.var_90BE["player"].var_BB4["conversation"])) {
    return 0;
  }

  foreach(var_01 in level.var_AB49) {
    if(func_2EBF(var_01) && func_7211(var_01)) {
      func_2EC1(var_01);
      return 1;
    }
  }

  foreach(var_01 in level.var_AB49) {
    if(!var_01.var_8BE && func_27E1(var_01)) {
      if(func_7211(var_01)) {
        func_2EC1(var_01);
        return 1;
      } else {
        return 0;
      }
    }
  }

  return 0;
}

func_2EBF(param_00) {
  return param_00.var_8BE && param_00.var_66CB <= level.var_A980 && func_2EC0(param_00);
}

func_2EC0(param_00) {
  if(param_00.var_20D9.size != 2) {
    return 0;
  }

  foreach(var_02 in param_00.var_20D9) {
    if(!isDefined(var_02) || !maps\mp\_utility::isreallyalive(var_02)) {
      return 0;
    }
  }

  return 1;
}

func_2EC1(param_00) {
  param_00.var_66CB = param_00.var_66CB + randomintrange(2, 4);
  param_00.var_83EB++;
}

func_7401() {
  foreach(var_01 in level.var_AB49) {
    if(common_scripts\utility::func_F79(var_01.var_20D9, self)) {
      return 1;
    }
  }

  return 0;
}

func_27E1(param_00) {
  var_01 = common_scripts\utility::array_randomize(level.players);
  var_02 = undefined;
  var_03 = undefined;
  foreach(var_05 in var_01) {
    if(!var_05 func_7401()) {
      if(!isDefined(var_02)) {
        var_02 = var_05;
      } else {
        var_03 = var_05;
      }
    }

    if(isDefined(var_02) && isDefined(var_03)) {
      break;
    }
  }

  if(!isDefined(var_02) || !isDefined(var_03)) {
    return 0;
  }

  param_00.var_20D9[0] = var_02;
  param_00.var_20D9[1] = var_03;
  param_00.var_7677[0] = level.var_A62B.var_90BE[var_02.var_AB1D].var_7677[lib_0547::func_429D(var_02)];
  param_00.var_7677[1] = level.var_A62B.var_90BE[var_03.var_AB1D].var_7677[lib_0547::func_429D(var_03)];
  param_00.var_8BE = 1;
  param_00.var_2566 = 0;
  return 1;
}

func_7211(param_00) {
  var_01 = "" + param_00.var_7677[0] + param_00.var_7677[1] + param_00.var_83EB;
  var_02 = param_00.var_20D9[0];
  var_03 = param_00.var_20D9[1];
  if(!isDefined(level.var_A62B.var_90BE["player"].var_BB4["conversation"][var_01])) {
    var_01 = "" + param_00.var_7677[1] + param_00.var_7677[0] + param_00.var_83EB;
    var_02 = param_00.var_20D9[1];
    var_03 = param_00.var_20D9[0];
    if(!isDefined(level.var_A62B.var_90BE["player"].var_BB4["conversation"][var_01])) {
      param_00.var_2566 = 1;
      return 0;
    }
  }

  return var_02 func_277D("conversation", var_01, undefined, undefined, undefined, var_03);
}

func_4454(param_00) {
  foreach(var_02 in level.players) {
    if(var_02.var_20D8 == param_00) {
      return var_02;
    }
  }
}

func_4456(param_00) {
  switch (param_00) {
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

func_4455(param_00) {
  return func_4454(func_4456(param_00));
}

func_441D(param_00) {
  var_01 = func_4455(param_00);
  if(!isDefined(var_01)) {
    return level.players[randomint(level.players.size)];
  }

  var_02 = common_scripts\utility::array_randomize(level.players);
  foreach(var_04 in level.players) {
    if(var_04 != var_01) {
      return var_04;
    }
  }
}

func_AB3D() {
  var_00 = randomintrange(0, 3);
  func_734D();
  func_746A();
  func_73DF("death" + var_00);
}

func_AB3C(param_00) {
  if(isDefined(self.var_29AB) && self.var_29AB + 5000 > param_00) {
    return;
  }

  if(!common_scripts\utility::func_562E(self.var_56E2)) {
    self.var_29AB = param_00;
    var_01 = randomintrange(0, 3);
    func_734D();
    func_73DF("pain" + var_01);
  }
}

func_73DF(param_00) {
  return 0;
}

func_746A() {
  self notify("stopExerting");
  self.var_56E2 = undefined;
}

func_38E0() {
  self endon("disconnect");
  self endon("stopExerting");
  wait(1);
  self.var_56E2 = 1;
  wait(randomfloatrange(1.5, 3));
  self.var_56E2 = undefined;
}

func_743B() {}

func_743A() {}

func_7448(param_00) {
  wait(1);
  if(self == param_00) {
    return;
  }

  if(param_00 lib_0547::func_4BA7("specialty_class_covert_exfiltration_zm") && common_scripts\utility::func_562E(param_00.var_569F)) {
    var_01 = param_00 func_277F("mod_use", "mod_covertexfiltration", undefined, undefined, self);
    return;
  }

  var_01 = var_01 func_277F("general", "revive_ally", undefined, undefined, self);
}

func_741A() {
  wait(1);
}

func_7486(param_00) {
  var_01 = "";
  var_02 = "ability";
  switch (param_00) {
    case "role_ability_mad_minute_zm":
      var_01 = "special_mad";
      break;

    case "role_ability_camo_zm":
      var_01 = "special_camo";
      break;

    case "role_ability_stunning_burst_zm":
      var_01 = "special_burst";
      break;

    case "role_ability_taunt_zm":
      var_01 = "special_taunt";
      break;

    case "role_ability_melee_frenzy_zm":
      var_01 = "special_mad";
      break;
  }

  var_03 = func_73C4(var_02, var_01);
  var_02 = var_03[0];
  var_01 = var_03[1];
  func_277F(var_02, var_01);
}

func_73C4(param_00, param_01) {
  var_02 = param_01;
  if(param_01 == "special_camo") {
    if(lib_0547::func_4BA7("specialty_class_serrated_edge_zm")) {
      param_01 = "mod_serratededge";
    } else if(lib_0547::func_4BA7("specialty_class_saboteur_zm") && playerismaincast()) {
      param_01 = "mod_saboteur";
    } else if(lib_0547::func_4BA7("specialty_class_mobilization_zm") && playerismaincast() || lib_0547::func_5565(lib_0378::dlg_get_char_name_override_from_index(self.var_20D8), "slay") || lib_0547::func_5565(lib_0378::dlg_get_char_name_override_from_index(self.var_20D8), "mount") || lib_0547::func_5565(lib_0378::dlg_get_char_name_override_from_index(self.var_20D8), "hunt") || lib_0547::func_5565(lib_0378::dlg_get_char_name_override_from_index(self.var_20D8), "surv")) {
      param_01 = "mod_enhancedspeed";
    }
  } else if(param_01 == "special_mad") {
    if(lib_0547::func_4BA7("specialty_class_ammo_carrier_zm") && level.players.size > 1) {
      param_01 = "mod_supplyammo";
    } else if(lib_0547::func_4BA7("specialty_class_squad_tactics_zm")) {
      param_01 = "mod_headshot";
    }
  } else if(param_01 == "special_burst") {
    if(lib_0547::func_4BA7("specialty_class_bolster_morale_zm") && level.players.size > 1 && func_73C3() && playerismaincast()) {
      param_01 = "mod_supplyarmor";
    } else if(lib_0547::func_4BA7("specialty_class_fiery_burst_zm")) {
      param_01 = "mod_fieryburst";
    } else if(lib_0547::func_4BA7("specialty_class_exploit_weakness_zm") && playerismaincast() || lib_0547::func_5565(lib_0378::dlg_get_char_name_override_from_index(self.var_20D8), "slay") || lib_0547::func_5565(lib_0378::dlg_get_char_name_override_from_index(self.var_20D8), "mount") || lib_0547::func_5565(lib_0378::dlg_get_char_name_override_from_index(self.var_20D8), "hunt") || lib_0547::func_5565(lib_0378::dlg_get_char_name_override_from_index(self.var_20D8), "surv")) {
      param_01 = "mod_exploitweakness";
    }
  } else if(param_01 == "special_taunt") {
    if(lib_0547::func_4BA7("specialty_class_team_effort_zm") && level.players.size > 1) {
      param_01 = "mod_teameffort";
    } else if(lib_0547::func_4BA7("specialty_class_come_get_zm")) {
      param_01 = "mod_comeandgetit";
    } else if(lib_0547::func_4BA7("specialty_class_counter_offensive_zm") && playerismaincast() || lib_0547::func_5565(lib_0378::dlg_get_char_name_override_from_index(self.var_20D8), "slay") || lib_0547::func_5565(lib_0378::dlg_get_char_name_override_from_index(self.var_20D8), "mount") || lib_0547::func_5565(lib_0378::dlg_get_char_name_override_from_index(self.var_20D8), "hunt") || lib_0547::func_5565(lib_0378::dlg_get_char_name_override_from_index(self.var_20D8), "surv")) {
      param_01 = "mod_counteroffensive";
    }
  } else if(param_01 == "special_melee") {}

  if(param_01 != var_02) {
    param_00 = "mod_use";
  }

  return [param_00, param_01];
}

playerismaincast() {
  if(lib_0547::func_5565(lib_0378::func_307B(self.var_20D8), "dros") || lib_0547::func_5565(lib_0378::func_307B(self.var_20D8), "jeff") || lib_0547::func_5565(lib_0378::func_307B(self.var_20D8), "mari") || lib_0547::func_5565(lib_0378::func_307B(self.var_20D8), "oliv")) {
    return 1;
  }

  return 0;
}

func_73C3() {
  var_00 = 0;
  var_01 = 518400;
  if(common_scripts\utility::func_562E(lib_0547::func_4BA7("specialty_class_breathing_room_zm")) && !common_scripts\utility::func_562E(lib_0547::func_4BA7("specialty_class_sustain_zone_zm"))) {
    var_01 = var_01 * 2.25;
  } else if(!common_scripts\utility::func_562E(lib_0547::func_4BA7("specialty_class_breathing_room_zm")) && common_scripts\utility::func_562E(lib_0547::func_4BA7("specialty_class_sustain_zone_zm"))) {
    var_01 = var_01 * 0.25;
  }

  foreach(var_03 in level.players) {
    if(var_03 == self) {
      continue;
    }

    if(lib_0547::func_577E(var_03)) {
      continue;
    }

    if(distancesquared(self.origin, var_03.origin) < var_01) {
      if(bullettracepassed(var_03 getEye(), self getEye(), 0, undefined)) {
        var_00 = 1;
      }
    }
  }

  return var_00;
}

func_0695(param_00) {
  if(!common_scripts\utility::func_562E(self.var_3E08)) {
    self.var_3E08 = 1;
    func_277F("general", param_00);
    wait(10);
    self.var_3E08 = undefined;
  }
}

func_745A(param_00) {
  if(level.players.size > 1) {
    func_277F("general", param_00);
  }
}

func_73B9(param_00, param_01) {
  var_02 = "perk_ouch";
  if(isshipzombiesmap()) {
    if(common_scripts\utility::func_562E(param_01)) {
      var_02 = "perk_first";
      if(param_00 == "electriccherry" && lib_0547::func_5565(lib_0378::func_307B(self.var_20D8), "jeff") || lib_0547::func_5565(lib_0378::func_307B(self.var_20D8), "mari")) {
        var_02 = "perk_shock";
      } else if(param_00 == "punchperk" && lib_0547::func_5565(lib_0378::func_307B(self.var_20D8), "jeff")) {
        var_02 = "perk_punch";
      }
    }
  } else if(common_scripts\utility::func_562E(param_01)) {
    var_02 = "perk_first";
  } else {
    switch (param_00) {
      case "electriccherry":
        var_02 = "perk_shock";
        break;

      case "punchperk":
        var_02 = "perk_punch";
        break;

      case "fastreload":
        var_02 = "perk_reload";
        break;

      case "runperk":
        var_02 = "perk_run";
        break;

      case "quickrevive":
        if(lib_0547::func_5565(lib_0378::dlg_get_char_name_override_from_index(self.var_20D8), "slay") || lib_0547::func_5565(lib_0378::dlg_get_char_name_override_from_index(self.var_20D8), "mount") || lib_0547::func_5565(lib_0378::dlg_get_char_name_override_from_index(self.var_20D8), "hunt") || lib_0547::func_5565(lib_0378::dlg_get_char_name_override_from_index(self.var_20D8), "surv")) {
          var_02 = "perk_ouch";
        } else {
          var_02 = "perk_revive";
        }
        break;

      case "doubletap":
        var_02 = "perk_damage";
        break;
    }
  }

  func_277F("perk", var_02);
}

playeruselostandfound() {
  if(isshipzombiesmap()) {
    return;
  }

  func_277F("general", "lost_and_found");
}

playerbuyweapon(param_00) {
  if(isshipzombiesmap()) {
    return;
  }

  if(common_scripts\utility::func_562E(param_00)) {
    func_277F("general", "newpackweapon");
    return;
  }

  func_277F("general", "newweapon");
}

playeruseconsumableweapon() {
  if(isshipzombiesmap()) {
    return;
  }

  func_277F("general", "consumableweapon");
}

isshipzombiesmap() {
  var_00 = maps\mp\_utility::func_4571();
  if(var_00 == "mp_zombie_nest_01" || var_00 == "mp_zombie_house" || var_00 == "mp_zombie_training") {
    return 1;
  }

  return 0;
}

func_7491(param_00, param_01) {}

func_73E4() {}

func_62D9() {
  self playlocalsound("interact_purchase");
  lib_0378::func_8D74("money_spend");
}