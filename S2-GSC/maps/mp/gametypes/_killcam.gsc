/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_killcam.gsc
*********************************************/

func_00D5() {
  level.var_5A29 = maps\mp\gametypes\_tweakables::func_46F7("game", "allowkillcam");
  setDvar("5364", 8);
}

func_8649(param_00, param_01, param_02, param_03, param_04) {
  self setclientomnvar("cam_scene_name", param_00);
  self setclientomnvar("cam_scene_lead", param_01);
  self setclientomnvar("cam_scene_support", param_02);
  if(isDefined(param_03)) {
    self setclientomnvar("cam_scene_lead_alt", param_03);
  } else {
    self setclientomnvar("cam_scene_lead_alt", param_01);
  }

  if(isDefined(param_04)) {
    self setclientomnvar("cam_scene_support_alt", param_04);
    return;
  }

  self setclientomnvar("cam_scene_support_alt", param_02);
}

func_86B7(param_00, param_01, param_02, param_03, param_04) {
  self setclientomnvar("ui_killcam_drawTargetBox", 0);
  if(isDefined(param_03.var_1187) && param_01 >= 0) {
    if(param_03.var_1187 == "dog") {
      func_8649("killcam_dog", param_01, self getentitynumber());
    } else if(param_03.var_1187 == "paratroopers") {
      func_8649("killcam_agent", param_03.var_1186, self getentitynumber());
    } else {
      func_8649("killcam_agent", param_01, self getentitynumber());
    }
  } else if(param_02 == "agent_mp" && isDefined(param_03.var_1186)) {
    func_8649("killcam_agent", param_03.var_1186, self getentitynumber());
  } else if(isDefined(param_03) && isDefined(param_02) && param_02 == "turretweapon_plane_gunner_turret_mp" || param_02 == "turretweapon_plane_gunner_turret_grenadier_mp") {
    func_8649("unknown", -1, -1);
    self setclientomnvar("ui_killcam_drawTargetBox", 1);
    return 1;
  } else if(param_01 >= 0) {
    func_8649("unknown", -1, -1);
    return 0;
  } else if(level.var_8C03) {
    func_8649("unknown", param_00, self getentitynumber());
  } else {
    func_8649("unknown", param_00, -1);
  }

  return 1;
}

func_585A(param_00, param_01, param_02) {
  if(isDefined(param_00) && param_00 getentitynumber() == worldentnumber() && isDefined(param_01) && isDefined(param_01.var_5A2C)) {
    return 1;
  }

  if(isDefined(param_02) && param_02 == "turretweapon_tank_panzer_cannon_mp_left" || param_02 == "turretweapon_tank_panzer_cannon_mp_right" || param_02 == "magnifying_glass_mp") {
    return 1;
  }

  return 0;
}

func_7681(param_00, param_01, param_02, param_03) {
  if(isPlayer(self) && isDefined(param_01) && isPlayer(param_01)) {
    var_04 = maps\mp\gametypes\_playerlogic::func_4006();
    var_05 = gettime();
    waittillframeend;
    if(isPlayer(self) && isDefined(param_01) && isPlayer(param_01)) {
      var_05 = gettime() - var_05 / 1000;
      self.var_9459 = self method_8423(param_01, param_02 + var_05, param_03, var_04);
      self method_8534(param_03);
    }
  }
}

func_5A33(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(getDvar("scr_killcam_time") == "") {
    if(!isDefined(param_01)) {
      param_01 = "";
    }

    if(isDefined(param_07) && param_07 == "replay") {
      var_08 = 5;
    } else if(isDefined(var_08) && var_08 == "playofthegame") {
      var_08 = maps\mp\gametypes\_potg::func_4632();
    } else if(param_06 || param_02 == "artillery_mp" || param_02 == "firebomb_bomb_mp" || param_02 == "firebomb_bomb_axis_mp" || param_02 == "firebomb_bomb_grenadier_mp" || param_02 == "firebomb_bomb_axis_grenadier_mp" || param_02 == "airstrike_bomb_mp" || param_02 == "airstrike_bomb_axis_mp" || param_02 == "turretweapon_plane_gunner_turret_mp" || param_02 == "turretweapon_plane_gunner_turret_grenadier_mp" || param_02 == "fighter_strike_gun_mp") {
      var_08 = gettime() - param_01 / 1000 - param_03 - 0.1;
      if((param_01 == "turretweapon_plane_gunner_turret_mp" || param_01 == "turretweapon_plane_gunner_turret_grenadier_mp") && var_08 > 5) {
        var_08 = 5;
      }
    } else if(param_02 == "missile_strike_projectile_mp" || param_02 == "missile_strike_projectile_axis_mp" || param_02 == "mortar_strike_projectile_mp" || param_02 == "mortar_strike_projectile_axis_mp") {
      var_08 = gettime() - param_01 / 1000 - param_03 - 0.35;
      if(maps\mp\_utility::func_4571() == "mp_gibraltar_02") {
        var_08 = var_08 - 0.35;
      }
    } else if(param_02 == "magnifying_glass_mp") {
      var_08 = 3;
    } else if(param_07 || param_02 == "agent_mp" || param_02 == "agent_raid_fighters_mp") {
      var_08 = 4;
    } else if(issubstr(param_02, "remotemissile_")) {
      var_08 = 5;
    } else if(!param_04 || param_04 > 5) {
      var_08 = 5;
    } else if(param_02 == "frag_grenade_mp" || param_02 == "frag_grenade_german_mp" || param_02 == "frag_grenade_short_mp" || param_02 == "semtex_mp" || param_02 == "semtexproj_mp" || param_02 == "thermobaric_grenade_mp") {
      var_08 = 4.25;
    } else {
      var_08 = 2.5;
    }
  } else {
    var_08 = getdvarfloat("scr_killcam_time");
  }

  if(param_05 && var_08 > 5) {
    var_08 = 5;
  }

  if(isDefined(param_04)) {
    if(var_08 > param_04) {
      var_08 = param_04;
    }

    if(var_08 < 0.05) {
      var_08 = 0.05;
    }
  }

  return var_08;
}

func_5A2A(param_00, param_01, param_02, param_03) {
  if(param_00 > param_01) {
    param_00 = param_01;
  }

  var_04 = param_00 + param_02 + param_03;
  return var_04;
}

func_5A34(param_00, param_01) {
  var_02 = 0;
  return param_01 && level.var_5A29 && !isDefined(param_00.var_1F3F) && param_00.var_1F3F && game["state"] == "playing" && !param_00 maps\mp\_utility::func_581D() && !level.var_8C03 && !function_01EF(param_00) || var_02;
}

func_74C9() {
  self endon("disconnect");
  self endon("spawned");
  level endon("game_ended");
  level.var_689A++;
  self.var_5A29 = 1;
  var_00 = level.var_689A * 0.05;
  if(level.var_689A > 1) {
    wait(0.05 * level.var_689A - 1);
  }

  wait 0.05;
  level.var_689A--;
  var_01 = 0.05;
  var_02 = maps\mp\gametypes\_potg::func_4632();
  var_03 = "playofthegame";
  self setclientomnvar("ui_killcam_end_milliseconds", 0);
  self setclientomnvar("ui_killcam_killedby_weapon", -1);
  self setclientomnvar("ui_killcam_killedby_killstreak", -1);
  self setclientomnvar("ui_killcam_copycat", 0);
  self setclientomnvar("ui_killcam_paratrooperInsert", 0);
  self setclientomnvar("ui_killcam_killedby_weaponReputation", 0);
  self setclientomnvar("ui_killcam_action", 0);
  self setclientomnvar("ui_killcam_type", 3);
  self setclientomnvar("ui_killcam_killedby_id", level.var_74CA);
  maps\mp\_utility::func_A165("spectator");
  self.var_0188 = 1;
  self method_8533(0);
  function_03B7(0);
  self.var_00E1 = -1;
  self.var_0020 = var_02 + var_00;
  self.var_009F = level.var_74CA;
  self.var_5A2F = var_02;
  self.var_014A = 0;
  thread maps\mp\gametypes\_potg::func_772D();
  self allowspectateteam("allies", 1);
  self allowspectateteam("axis", 1);
  self allowspectateteam("freelook", 1);
  self allowspectateteam("none", 1);
  if(level.var_6520) {
    foreach(var_05 in level.var_985B) {
      self allowspectateteam(var_05, 1);
    }
  }

  foreach(var_05 in level.var_985B) {
    self allowspectateteam(var_05, 1);
  }

  thread func_36B5(var_03);
  thread func_6164(var_03);
  wait 0.05;
  if(!isDefined(self)) {
    return;
  }

  self.var_5A2F = var_02 - 0.05;
  self setclientomnvar("ui_killcam_end_milliseconds", int(var_02 * 1000) + gettime());
  thread func_9046(var_03);
  self.var_8C8A = 0;
  self.var_5A31 = maps\mp\_utility::func_44FA();
  self notify("showing_final_killcam");
  thread func_318D(function_036B() + 0.5);
  thread switchkillcamentityovertime();
  func_A784();
  if(level.var_8C03) {
    thread maps\mp\gametypes\_playerlogic::func_9049();
    return;
  }

  thread func_5A2B(1, var_03);
}

switchkillcamentityovertime() {
  self endon("abort_killcam");
  self endon("killcam_ended");
  var_00 = maps\mp\_utility::func_44FA();
  var_01 = [];
  foreach(var_03 in level.var_74CB) {
    if(maps\mp\_events::iskillevent(var_03.var_1458)) {
      var_04 = var_01.size;
      var_01[var_04] = spawnStruct();
      var_01[var_04].var_1EB5 = var_03.var_1EB5;
      var_01[var_04].victimnum = var_03.victimnum;
      var_01[var_04].var_3FD7 = var_03.var_3FD7;
      var_01[var_04].var_A490 = var_03.var_A490;
      var_01[var_04].var_01D0 = var_03.var_01D0;
    }
  }

  if(var_01.size > 1) {
    var_01 = common_scripts\utility::func_0FA4(var_01, ::potgcomparekilltimes);
  }

  if(var_01.size < 1) {
    return;
  }

  var_04 = 0;
  var_06 = maps\mp\gametypes\_potg::func_4632() * 1000;
  var_07 = function_0369() * 1000;
  var_08 = var_00 + var_06 - var_07;
  var_09 = level.playofthegamerecordtime - var_01[0].var_3FD7;
  var_0A = var_08 - var_00;
  var_0A = var_0A - var_09;
  setpotgkillcamentity(var_01[var_04]);
  while(var_04 < var_01.size) {
    var_0B = maps\mp\_utility::func_44FA() - var_00;
    if(var_0B > var_0A) {
      var_04++;
      if(var_04 < var_01.size && isDefined(var_01[var_04 - 1])) {
        var_0C = var_01[var_04].var_3FD7 - var_01[var_04 - 1].var_3FD7;
        if(var_0C > 1000) {
          wait(0.5);
        }

        var_0A = var_0C + var_0B;
        setpotgkillcamentity(var_01[var_04]);
      }
    }

    wait 0.05;
  }
}

potgcomparekilltimes() {
  if(!isDefined(self.var_3FD7)) {
    return 0;
  }

  return self.var_3FD7;
}

setpotgkillcamentity(param_00) {
  var_01 = 0;
  if(isDefined(param_00.var_1EB5) && isDefined(param_00.var_A490)) {
    var_01 = func_86B7(level.var_74CA, param_00.var_1EB5, param_00.var_01D0, param_00.var_A490, 0);
  }

  if(!var_01 && isDefined(param_00.var_1EB5)) {
    if(param_00.var_1EB5 != level.var_74CA) {
      self.var_00E1 = param_00.var_1EB5;
      if(isDefined(param_00.victimnum)) {
        self.var_00E2 = param_00.victimnum;
      }

      return;
    }
  }

  self.var_00E1 = -1;
  self.var_009F = level.var_74CA;
}

canincludeattachmentsforweapon(param_00) {
  switch (param_00) {
    case "combatknife_mp":
    case "riotshield_mp":
      return 0;
  }

  return 1;
}

func_5A29(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D, param_0E) {
  self endon("disconnect");
  self endon("spawned");
  level endon("game_ended");
  var_0F = func_585A(param_00, param_09, param_04);
  if((param_01 < 0 || !isDefined(param_09)) && !var_0F) {
    return;
  }

  level.var_689A++;
  var_10 = level.var_689A * 0.05;
  if(level.var_689A > 1) {
    wait(0.05 * level.var_689A - 1);
  }

  wait 0.05;
  level.var_689A--;
  if(isDefined(level.var_4E09)) {
    return;
  }

  var_11 = func_5A33(param_03, param_04, param_05, param_07, param_08, param_0E, level.var_8C03, param_0C);
  if(getDvar("scr_killcam_posttime") == "") {
    var_12 = 2;
  } else {
    var_12 = getdvarfloat("scr_killcam_posttime");
    if(var_12 < 0.05) {
      var_12 = 0.05;
    }
  }

  var_13 = var_11 + var_12;
  if(isDefined(param_08) && var_13 > param_08) {
    if(param_08 < 2) {
      return;
    }

    if(param_08 - var_11 >= 1) {
      var_12 = param_08 - var_11;
    } else {
      var_12 = 1;
      var_11 = param_08 - 1;
    }

    var_13 = var_11 + var_12;
  }

  if(isDefined(param_09.var_2AB8)) {
    if(gettime() - param_09.var_2AB8 < var_12 * 1000) {
      var_12 = 1;
      var_13 = var_11 + var_12;
    }
  }

  self setclientomnvar("ui_killcam_end_milliseconds", 0);
  self setclientomnvar("ui_show_overview_map_icons", 0);
  if(function_01EF(param_09) && !isDefined(param_09.var_565F)) {
    return;
  }

  if(isPlayer(param_09)) {
    self setclientomnvar("ui_killcam_killedby_id", param_09 getentitynumber());
  } else if(function_01EF(param_09) || var_0F) {
    self setclientomnvar("ui_killcam_killedby_id", -1);
  }

  if(isDefined(param_04)) {
    if(maps\mp\_utility::func_5740(param_04)) {
      var_14 = maps\mp\_utility::func_4545(level.var_5A7D[param_04]);
      self setclientomnvar("ui_killcam_killedby_killstreak", var_14);
      self setclientomnvar("ui_killcam_killedby_weapon", -1);
      self setclientomnvar("ui_killcam_killedby_attachment1", -1);
      self setclientomnvar("ui_killcam_killedby_attachment2", -1);
      self setclientomnvar("ui_killcam_killedby_attachment3", -1);
      self setclientomnvar("ui_killcam_killedby_attachment4", -1);
      self setclientomnvar("ui_killcam_copycat", 0);
      self setclientomnvar("ui_killcam_killedby_weaponReputation", 0);
    } else if(var_0F) {
      self setclientomnvar("ui_killcam_killedby_killstreak", -1);
      self setclientomnvar("ui_killcam_killedby_weapon", -1);
      self setclientomnvar("ui_killcam_killedby_attachment1", -1);
      self setclientomnvar("ui_killcam_killedby_attachment2", -1);
      self setclientomnvar("ui_killcam_killedby_attachment3", -1);
      self setclientomnvar("ui_killcam_killedby_attachment4", -1);
      self setclientomnvar("ui_killcam_copycat", 0);
      self setclientomnvar("ui_killcam_killedby_weaponReputation", 0);
    } else {
      var_15 = [];
      var_16 = getweapondisplayname(param_04);
      param_04 = maps\mp\gametypes\_division_change::func_7CCD(param_04);
      if(isDefined(var_16)) {
        var_17 = maps\mp\_utility::func_472B(param_04);
        var_18 = maps\mp\_utility::func_452A(var_16);
        var_19 = -1;
        if(isDefined(var_18) && var_18 != 0) {
          if(var_17 == "cond2" || var_17 == "cond1") {
            var_1A = maps\mp\_utility::func_4431(var_16);
            var_1B = maps\mp\_utility::func_452A(var_1A);
            if(isDefined(var_1B) && var_1B != 0) {
              var_1C = tablelookup("mp/statstable.csv", 18, maps\mp\_utility::unsignedint_to_hexstring_fixed(var_1B), 34);
              if(var_1C == "0") {
                if(var_17 == "cond1") {
                  var_18 = var_1B + 1;
                } else if(var_17 == "cond2") {
                  var_18 = var_1B + 2;
                }
              } else if(var_1C == "1") {
                if(var_17 == "cond2") {
                  var_18 = var_1B + 1;
                }
              }
            }
          }

          var_1D = maps\mp\_utility::unsignedint_to_hexstring_fixed(var_1B);
          var_1C = tablelookuprownum("mp/statstable.csv", 18, var_1D);
        } else {
          var_1C = tablelookuprownum("mp/statstable.csv", 2, var_19);
        }

        self setclientomnvar("ui_killcam_killedby_weapon", var_1C);
        self setclientomnvar("ui_killcam_killedby_killstreak", -1);
        self setclientomnvar("ui_killcam_killedby_weaponReputation", 0);
        if(canincludeattachmentsforweapon(var_19)) {
          var_18 = function_0061(param_07);
        }

        var_18 = common_scripts\utility::func_0F93(var_18, "special_grip");
        if(!level.var_8C03 && maps\mp\_utility::func_761E() && isPlayer(param_0C) && !isbot(self) && !function_01EF(self) && maps\mp\gametypes\_class::func_5E0A(param_0C)) {
          self setclientomnvar("ui_killcam_copycat", 1);
          thread func_A68A(param_0C);
        } else {
          self setclientomnvar("ui_killcam_copycat", 0);
        }
      } else {
        self setclientomnvar("ui_killcam_killedby_weapon", -1);
        self setclientomnvar("ui_killcam_killedby_killstreak", -1);
        self setclientomnvar("ui_killcam_copycat", 0);
      }

      for(var_1E = 0; var_1E < 4; var_1E++) {
        if(isDefined(var_1B[var_1E])) {
          var_1F = tablelookuprownum("mp/attachmenttable.csv", 3, maps\mp\_utility::func_1150(var_1B[var_1E]));
          self setclientomnvar("ui_killcam_killedby_attachment" + var_1E + 1, var_1F);
          continue;
        }

        self setclientomnvar("ui_killcam_killedby_attachment" + var_1E + 1, -1);
      }
    }
  } else {
    self setclientomnvar("ui_killcam_killedby_weapon", -1);
    self setclientomnvar("ui_killcam_killedby_killstreak", -1);
    self setclientomnvar("ui_killcam_copycat", 0);
    self setclientomnvar("ui_killcam_killedby_weaponReputation", 0);
  }

  if(!var_18 && isDefined(var_11.var_5DFA) && var_11.var_5DFA.size > 4) {
    var_20 = var_11.var_5DFA[0];
    var_21 = var_11.var_5DFA[3];
    if(var_20 != 0) {
      var_22 = maps\mp\_utility::func_452B(var_20);
      var_23 = int(tablelookup(maps\mp\_utility::func_4604(), 1, var_22, 0));
      self setclientomnvar("ui_killcam_killedby_perk_1", var_23);
    } else {
      self setclientomnvar("ui_killcam_killedby_perk_1", -1);
    }

    var_24 = maps\mp\_utility::func_452B(var_21);
    var_25 = int(tablelookup(maps\mp\_utility::func_4604(), 1, var_24, 0));
    self setclientomnvar("ui_killcam_killedby_perk_2", var_25);
    for(var_1E = 3; var_1E <= 9; var_1E++) {
      self setclientomnvar("ui_killcam_killedby_perk_" + var_1E, -1);
    }

    self setclientomnvar("ui_killcam_killedby_division", var_11.var_0079);
  } else if(!var_1A) {
    for(var_1E = 1; var_1E <= 9; var_1E++) {
      self setclientomnvar("ui_killcam_killedby_perk_" + var_1E, -1);
    }

    self setclientomnvar("ui_killcam_killedby_division", var_13.var_0079);
  } else if(var_1A) {
    for(var_1E = 1; var_1E <= 9; var_1E++) {
      self setclientomnvar("ui_killcam_killedby_perk_" + var_1E, -1);
    }

    self setclientomnvar("ui_killcam_killedby_division", -1);
  }

  if(!level.var_3F9D && var_17 != "replay" && var_17 != "playofthegame") {
    if(var_11) {
      self setclientomnvar("ui_killcam_action", 2);
    } else {
      self setclientomnvar("ui_killcam_action", 1);
    }
  } else {
    self setclientomnvar("ui_killcam_action", 0);
  }

  switch (var_17) {
    case "replay":
      self setclientomnvar("ui_killcam_type", 2);
      break;

    case "playofthegame":
      self setclientomnvar("ui_killcam_type", 3);
      break;

    case "score":
      self setclientomnvar("ui_killcam_type", 1);
      break;

    case "normal":
    default:
      self setclientomnvar("ui_killcam_type", 0);
      break;
  }

  var_26 = var_1C + var_0F + var_1B;
  var_27 = gettime();
  self notify("begin_killcam", var_27);
  if(!var_1A && !function_01EF(var_13) && isDefined(var_13) && isPlayer(var_15)) {
    var_13 method_82A8(var_15);
  }

  maps\mp\_utility::func_A165("spectator");
  self.var_0188 = 1;
  if(function_01EF(var_13) && var_17 != "replay" && var_17 != "playofthegame") {
    param_0B = var_15 getentitynumber();
  }

  self method_8533(0);
  if(var_1A) {
    self.var_009F = var_15 getentitynumber();
  } else {
    self.var_009F = param_0B;
  }

  self.var_00E2 = var_15 getentitynumber();
  self.var_00E1 = -1;
  var_28 = func_86B7(param_0B, param_0C, param_0E, var_15, var_1C);
  if(!var_28) {
    thread func_86B6(param_0C, var_26, param_0D);
  }

  if(var_1A) {
    if(var_26 > gettime() / 1000) {
      var_26 = gettime() / 1000;
    }
  } else if(var_26 > var_18) {
    var_26 = var_18;
  }

  self.var_0020 = var_26;
  self.var_5A2F = var_21;
  self.var_014A = var_10;
  self allowspectateteam("allies", 1);
  self allowspectateteam("axis", 1);
  self allowspectateteam("freelook", 1);
  self allowspectateteam("none", 1);
  if(level.var_6520) {
    foreach(var_2A in level.var_985B) {
      self allowspectateteam(var_2A, 1);
    }
  }

  foreach(var_2A in level.var_985B) {
    self allowspectateteam(var_2A, 1);
  }

  thread func_36B5(var_17, var_13);
  thread func_6164(var_17, var_13);
  wait 0.05;
  if(!isDefined(self)) {
    return;
  }

  if(self.var_0020 < var_26) {}

  var_1C = self.var_0020 - 0.05 - var_0F;
  var_21 = var_1C + var_20;
  self.var_5A2F = var_21;
  if(var_1C <= 0) {
    if(var_17 != "replay" && var_17 != "playofthegame") {
      maps\mp\_utility::func_A165("dead");
    }

    maps\mp\_utility::func_23FF();
    self notify("killcam_ended");
    return;
  }

  self setclientomnvar("ui_killcam_end_milliseconds", int(var_21 * 1000) + gettime());
  if(level.var_8C03) {
    thread func_318D(var_1C);
  }

  self.var_5A29 = 1;
  thread func_9046(var_17, var_13);
  self.var_8C8A = 0;
  self.var_5A31 = maps\mp\_utility::func_44FA();
  if(!level.var_8C03) {
    thread func_A6FB(var_11);
  } else {
    self notify("showing_final_killcam");
  }

  thread func_36D6();
  func_A784();
  if(level.var_8C03) {
    if(self == var_13) {
      var_13 maps\mp\gametypes\_missions::func_7750("ch_precision_moviestar");
    }

    if(level.var_74CA < 0 || var_17 != "playofthegame") {
      thread maps\mp\gametypes\_playerlogic::func_9049();
      return;
    }
  }

  thread func_5A2B(1, var_17, var_13);
}

func_318D(param_00) {
  if(common_scripts\utility::func_562E(level.skipfinalkillcamfx)) {
    return;
  }

  if(isDefined(level.var_3200)) {
    return;
  }

  level.var_3200 = 1;
  var_01 = param_00;
  if(var_01 > 1) {
    var_01 = 1;
    wait(param_00 - 1);
  }

  setslowmotion(1, 0.25, var_01);
  wait(var_01 + 1);
  setslowmotion(0.25, 1, 0.5);
  level.var_3200 = undefined;
}

func_A784() {
  self endon("abort_killcam");
  var_00 = maps\mp\gametypes\_playerlogic::func_9A1C(0);
  if(var_00 > 0) {
    self setclientomnvar("ui_killcam_time_until_spawn", gettime() + var_00 * 1000);
  }

  wait(self.var_5A2F - 0.05);
}

func_86B6(param_00, param_01, param_02) {
  self endon("disconnect");
  self endon("killcam_ended");
  var_03 = gettime() - param_01 * 1000;
  if(param_02 > var_03) {
    wait 0.05;
    param_01 = self.var_0020;
    var_03 = gettime() - param_01 * 1000;
    if(param_02 > var_03) {
      wait(param_02 - var_03 / 1000);
    }
  }

  self.var_00E1 = param_00;
}

func_A6FB(param_00) {
  self endon("disconnect");
  self endon("killcam_ended");
  while(self useButtonPressed()) {
    wait 0.05;
  }

  while(!self useButtonPressed()) {
    wait 0.05;
  }

  self.var_8C8A = 1;
  if(isDefined(self.var_012C["totalKillcamsSkipped"])) {
    self.var_012C["totalKillcamsSkipped"]++;
  }

  if(param_00 <= 0) {
    maps\mp\_utility::func_2401("kc_info");
  }

  self notify("abort_killcam");
}

func_A6F7(param_00) {
  self endon("disconnect");
  self endon("killcam_ended");
  self notifyonplayercommand("KillCamParatrooperInsert", "+weapnext");
  self waittill("KillCamParatrooperInsert");
  self setclientomnvar("ui_killcam_paratrooperInsert", 0);
  thread maps\mp\gametypes\_weapons::func_A931();
}

func_A68A(param_00) {
  self endon("disconnect");
  self endon("killcam_ended");
  self notifyonplayercommand("KillCamCopyCat", "+weapnext");
  self waittill("KillCamCopyCat");
  self setclientomnvar("ui_killcam_copycat", 0);
  self method_8617("copycat_steal_class");
  maps\mp\gametypes\_class::func_8657(param_00);
}

func_36D6() {
  self endon("disconnect");
  self endon("killcam_ended");
  for(;;) {
    if(self.var_0020 <= 0) {
      break;
    }

    wait 0.05;
  }

  self notify("abort_killcam");
}

func_9046(param_00, param_01) {
  self endon("disconnect");
  self endon("killcam_ended");
  self waittill("spawned");
  thread func_5A2B(0, param_00, param_01);
}

func_36B5(param_00, param_01) {
  self endon("disconnect");
  self endon("killcam_ended");
  level waittill("game_ended");
  thread func_5A2B(1, param_00, param_01);
}

func_6164(param_00, param_01) {
  self endon("disconnect");
  self endon("killcam_ended");
  level waittill("host_migration_begin");
  func_5A2B(1, param_00, param_01);
}

func_5A2B(param_00, param_01, param_02) {
  self setclientomnvar("ui_killcam_end_milliseconds", 0);
  func_8649("unknown", -1, -1);
  self.var_5A29 = undefined;
  if(isDefined(self.var_5A31) && isPlayer(self) && maps\mp\_matchdata::func_1F59(self.var_5CC6)) {
    var_03 = maps\mp\_utility::func_44FA();
    setmatchdata("lives", self.var_5CC6, "killcam_watch_duration", maps\mp\_utility::func_2314(var_03 - self.var_5A31));
  }

  if(!level.var_3F9D) {
    maps\mp\_utility::func_2401("kc_info");
  }

  thread maps\mp\gametypes\_spectating::func_872F();
  self notify("killcam_ended");
  if(!param_00) {
    return;
  }

  if(param_01 != "replay" && param_01 != "playofthegame") {
    maps\mp\_utility::func_A165("dead");
  }

  if(isPlayer(self) && isDefined(param_02) && param_02 maps\mp\_utility::func_0649("specialty_perception") || param_02 maps\mp\_utility::func_0649("specialty_class_perception")) {
    thread func_238F(param_02);
  }

  if(isPlayer(self) && isDefined(param_02) && isDefined(param_02.var_0079)) {
    thread func_237D(param_02);
  }

  maps\mp\_utility::func_23FF();
}

func_238F(param_00) {
  wait(0.1);
  var_01 = common_scripts\utility::func_44F5("perception_glow");
  if(isDefined(var_01)) {
    function_0295(var_01, param_00, "j_head", self);
  }
}

func_237D(param_00) {
  wait(0.1);
  maps\mp\gametypes\_division_change::func_2F7B(param_00.var_0079, param_00 maps\mp\gametypes\_divisions::func_461C(param_00.var_0079), param_00);
}

func_1F41() {
  self.var_1F3F = 0;
  thread func_1F42(::func_1F45, ::func_1F40);
}

func_1F45() {
  return self useButtonPressed();
}

func_1F43() {
  return self fragButtonPressed();
}

func_1F40() {
  self setclientomnvar("ui_show_skip_killcam", 0);
  self.var_1F3F = 1;
  if(isDefined(self.var_012C["totalKillcamsInterrupted"])) {
    self.var_012C["totalKillcamsInterrupted"]++;
  }
}

func_1F44() {
  self.var_1F3F = 1;
  self.var_A7F5 = 1;
  if(isDefined(self.var_012C["totalKillcamsInterrupted"])) {
    self.var_012C["totalKillcamsInterrupted"]++;
  }
}

func_1F42(param_00, param_01) {
  self endon("death_delay_finished");
  self endon("disconnect");
  level endon("game_ended");
  while(self[[param_00]]()) {
    wait 0.05;
  }

  while(!self[[param_00]]()) {
    wait 0.05;
  }

  self[[param_01]]();
}

func_92E1(param_00, param_01, param_02) {
  if(isDefined(param_00) && isDefined(param_00.var_5BE2)) {
    var_03 = gettime() - param_00.var_5BE2 / 1000;
  } else {
    var_03 = 0;
  }

  func_5A29(param_00, param_01, -1, 0, undefined, 0, param_02, 1, maps\mp\gametypes\_gamelogic::func_9A1B(), param_00, undefined, undefined, "replay", var_03, 0);
}