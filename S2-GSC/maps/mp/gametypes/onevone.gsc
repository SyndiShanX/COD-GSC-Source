/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\onevone.gsc
*********************************************/

func_00F9() {
  maps\mp\gametypes\_globallogic::func_00D5();
  lib_01DD::func_8A0C();
  maps\mp\gametypes\_globallogic::func_8A0C();
  if(isusingmatchrulesdata()) {
    level.var_5300 = ::func_5300;
    [[level.var_5300]]();
    level thread maps\mp\_utility::func_7C13();
  } else {
    maps\mp\_utility::func_7BFA(level.var_3FDC, 3);
    maps\mp\_utility::func_7BF9(level.var_3FDC, 20);
    maps\mp\_utility::func_7C04(level.var_3FDC, 1);
    maps\mp\_utility::func_7BF7(level.var_3FDC, 1);
    maps\mp\_utility::func_7BF1(level.var_3FDC, 0);
    maps\mp\_utility::func_7BE5(level.var_3FDC, 0);
    maps\mp\_utility::func_7BF9(level.var_3FDC, 20);
    level.var_6031 = 0;
    level.var_6035 = 0;
  }

  maps\mp\gametypes\_tweakables::func_8751("game", "minimapHiddenWhileADS", 1);
  level.var_3992 = 0.5;
  level.var_606F = 7;
  level.var_09B7 = 0;
  level.var_6B1E = undefined;
  level.var_6BAF = ::func_6BAF;
  level.var_6B5C = ::func_6B5C;
  level.var_6B7F = ::func_6B7F;
  level.var_4696 = ::func_4696;
  level.var_6BA7 = ::func_86E1;
  level.var_6B7B = ::func_6B7B;
  level.var_6BB6 = ::func_6BB6;
  if(level.var_6031 || level.var_6035) {
    level.var_62AD = ::maps\mp\gametypes\_damage::func_3FC8;
  }

  setteammode("ffa");
  game["dialog"]["gametype"] = "ffa_intro";
  game["dialog"]["defense_obj"] = "gbl_start";
  game["dialog"]["offense_obj"] = "gbl_start";
  if(getdvarint("2043")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }
}

func_5300() {
  maps\mp\_utility::func_8653(1);
  setdynamicdvar("scr_onevone_winlimit", 1);
  maps\mp\_utility::func_7C04("onevone", 1);
  setdynamicdvar("scr_onevone_roundlimit", 1);
  maps\mp\_utility::func_7BF7("onevone", 1);
  setdynamicdvar("scr_onevone_halftime", 0);
  maps\mp\_utility::func_7BE5("onevone", 0);
}

func_6BAF() {
  setclientnamemode("auto_change");
  maps\mp\_utility::func_86DC("allies", &"OBJECTIVES_ONEVONE");
  maps\mp\_utility::func_86DC("axis", &"OBJECTIVES_ONEVONE");
  if(level.var_910F) {
    maps\mp\_utility::func_86DB("allies", &"OBJECTIVES_ONEVONE");
    maps\mp\_utility::func_86DB("axis", &"OBJECTIVES_ONEVONE");
  } else {
    maps\mp\_utility::func_86DB("allies", &"OBJECTIVES_ONEVONE_SCORE");
    maps\mp\_utility::func_86DB("axis", &"OBJECTIVES_ONEVONE_SCORE");
  }

  maps\mp\_utility::func_86D8("allies", &"OBJECTIVES_ONEVONE_HINT");
  maps\mp\_utility::func_86D8("axis", &"OBJECTIVES_ONEVONE_HINT");
  lib_050D::func_10E4();
  level.var_A239 = 0;
  var_00[0] = "onevone";
  maps\mp\gametypes\_gameobjects::func_00F9(var_00);
  level.var_7895 = 1;
  level.var_7691 = 0;
  level.var_7692 = 0;
  level.var_17EF = 1;
  level thread func_92EE();
}

func_6B5C(param_00, param_01, param_02) {
  var_03 = 0;
  foreach(var_05 in level.var_744A) {
    if(isDefined(var_05.var_015C) && var_05.var_015C > var_03) {
      var_03 = var_05.var_015C;
    }
  }

  if(game["state"] == "postgame" && param_01.var_015C >= var_03) {
    param_01.var_3B4B = 1;
  }
}

func_6B7F(param_00, param_01, param_02, param_03, param_04) {
  if(func_57BE(param_00)) {
    var_05 = 1;
    if(param_04 == "MOD_MELEE") {
      if((!isDefined(level.var_6B17) || !level.var_6B17) && (!isDefined(level.var_6B18) || !level.var_6B18) && (!isDefined(level.var_6B16) || !level.var_6B16) && self.var_5DFE != "shovel_loot3_mp") {
        var_05 = 2;
      }

      param_01.var_0021++;
    }

    param_01.var_00E4++;
    param_01.var_0090 = param_01.var_00E4;
    param_01 maps\mp\_utility::func_867C(param_01.var_00E4);
    var_06 = var_05 * maps\mp\gametypes\_rank::func_4671(param_00);
    param_01 maps\mp\_utility::func_867B(param_01.var_008F + var_06);
    param_01 maps\mp\gametypes\_gamescore::func_A161(param_01, var_06);
    return var_05;
  }

  return 0;
}

func_57BE(param_00) {
  switch (param_00) {
    case "kill":
    case "flamethrower_kill":
      return 1;
  }

  return 0;
}

func_92EE() {
  level.var_9A12 = 1;
  level.var_9A13 = 1;
  level.var_9A11 = gettime();
  level.var_6B20 = 1;
  while(level.var_744A.size < 2 || level.var_5139) {
    wait 0.05;
  }

  func_92EF(level.var_744A, undefined);
  level.var_6B20 = 0;
  wait(1);
  maps\mp\gametypes\_gamelogic::func_7DFC();
  level thread func_63F2();
}

ishqarenaingungame(param_00) {
  return param_00 == 41 || param_00 == 42 || param_00 == 43 || param_00 == 44 || param_00 == 45;
}

func_83B8(param_00, param_01) {
  if(level.var_3FDC == "onevone" && param_01 == 1) {
    return [26 + randomint(3), 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40];
  }

  if(level.var_3FDC == "onevone" && param_01 == 2) {
    return [3 + randomint(38)];
  }

  var_02 = [[3, 4, 5, 6, 7, 33, 34, 46, 47], [8, 9, 10, 11, 12, 13, 48, 49], [14, 15, 19, 35, 50], [16, 17, 18, 36], [20, 21, 22, 37], [23, 24, 38, 39, 41, 43], [26, 27, 25, 40, 42, 44, 45], [41], [42, 43, 44, 45]];
  var_03 = [];
  var_04 = 1;
  var_05 = 1;
  for(var_06 = 0; var_06 < param_00; var_06++) {
    var_07 = 0;
    var_08 = -1;
    var_09 = 1;
    var_0A = 1;
    while(!var_07) {
      if(level.var_3FDC == "onevone") {
        switch (var_06) {
          case 0:
            var_08 = 0;
            var_0A = 0;
            break;

          case 1:
            var_08 = 1;
            var_0A = 0;
            break;

          case 2:
            var_08 = 3;
            var_0A = 0;
            break;

          case 3:
            var_08 = 4;
            var_0A = 0;
            break;

          case 4:
            var_08 = 2 + 3 * randomint(2);
            break;
        }
      } else if(level.hub_1v1_weapon_mode == 0) {
        switch (var_06) {
          case 0:
            var_08 = randomint(2);
            break;

          case 1:
            var_08 = randomintrange(2, 5);
            break;

          case 2:
            var_08 = randomintrange(5, 7);
            var_0A = 0;
            break;
        }
      } else if(level.hub_1v1_weapon_mode == 1) {
        var_04 = 0;
        var_05 = 0;
        switch (var_06) {
          case 0:
            var_08 = 7;
            var_0A = 0;
            break;

          case 1:
            var_08 = 8;
            var_0A = 0;
            var_09 = 0;
            break;

          case 2:
            var_08 = 8;
            var_0A = 0;
            var_09 = 0;
            break;
        }
      }

      var_07 = 1;
      for(var_0B = 0; var_0A && isDefined(level.var_6B1C) && var_0B < level.var_6B1C.size; var_0B++) {
        if(level.var_6B1C[var_0B] == var_08) {
          var_07 = 0;
        }
      }

      for(var_0B = 0; var_09 && var_0B < var_03.size; var_0B++) {
        if(var_03[var_0B] == var_08) {
          var_07 = 0;
        }
      }

      if(!var_07) {
        wait 0.05;
      }
    }

    var_03[var_03.size] = var_08;
  }

  var_0C = [];
  foreach(var_0E in var_03) {
    var_07 = 0;
    var_0F = -1;
    while(!var_07) {
      var_0F = var_02[var_0E][randomint(var_02[var_0E].size)];
      var_07 = 1;
      for(var_0B = 0; var_04 && isDefined(level.var_6B1B) && var_0B < level.var_6B1B.size; var_0B++) {
        if(level.var_6B1B[var_0B] == var_0F) {
          var_07 = 0;
        }
      }

      for(var_0B = 0; var_05 && isDefined(level.var_6B1D) && var_0B < level.var_6B1D.size; var_0B++) {
        if(level.var_6B1D[var_0B] == var_0F) {
          var_07 = 0;
        }
      }

      for(var_0B = 0; isDefined(var_0C) && var_0B < var_0C.size; var_0B++) {
        if(var_0C[var_0B] == var_0F) {
          var_07 = 0;
        }
      }

      if(!var_07) {
        wait 0.05;
      }
    }

    var_0C[var_0C.size] = var_0F;
  }

  level.var_6B1D = level.var_6B1B;
  level.var_6B1B = var_0C;
  level.var_6B1C = var_03;
  return var_0C;
}

func_92EF(param_00, param_01) {
  var_02 = 5;
  var_03 = 3;
  var_04 = 1;
  var_05 = 1;
  var_06 = -1;
  if(level.var_3FDC == "onevone") {
    var_07 = [0, 1, 2];
    foreach(var_09 in param_00) {
      var_09 func_86E2(var_07, var_02);
    }

    var_07 = func_6B24(var_04, var_05, var_07, param_00, param_01);
    if(var_07.size == 0) {
      return;
    }

    var_06 = func_44DB(var_07);
    foreach(var_09 in param_00) {
      var_09 setclientomnvar("ui_onevone_show_class_menu", -1);
    }

    wait 0.05;
    var_03 = var_02;
    var_04 = 2;
  }

  var_07 = func_83B8(var_03, var_06);
  if(var_06 != 2) {
    foreach(var_09 in param_00) {
      var_09 func_86E2(var_07, var_02);
    }

    var_07 = func_6B24(var_04, var_05, var_07, param_00, param_01);
  }

  foreach(var_09 in param_00) {
    var_09 setclientomnvar("ui_onevone_show_class_menu", -1);
  }

  if(var_07.size == 0) {
    level.var_6B18 = 0;
    level.var_6B19 = 0;
    level.var_6B16 = 0;
    level.var_6B17 = 0;
    return;
  }

  var_11 = func_44DB(var_07);
  level.var_6B18 = var_11 == 29;
  level.var_6B19 = var_11 == 30;
  level.var_6B16 = var_11 == 31;
  level.var_6B17 = var_11 == 32;
  if(level.var_6B19) {
    var_11 = func_45AB();
  }

  func_86E3(var_11, param_01);
  level.var_6B1F = 0;
  if(isDefined(param_01)) {
    param_01 notify("onevoneClassCreated");
    return;
  }

  level notify("onevoneClassCreated");
}

func_86E3(param_00, param_01) {
  if(isDefined(param_01)) {
    var_02 = param_01;
  } else {
    var_02 = level;
  }

  var_02.onevone_classchoicenum = param_00;
  if(level.var_3FDC != "onevone" && ishqarenaingungame(param_00)) {
    return;
  }

  var_02.var_6B15 = maps\mp\gametypes\_class::func_44B4();
  var_02.var_6B21 = "maps\mp\gametypes\onevoneClassTable.csv";
  var_02.var_6B15["loadoutDivision"] = maps\mp\gametypes\_class::func_9583(var_02.var_6B21, param_00);
  var_02.var_6B15["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::func_473C(maps\mp\gametypes\_class::func_9590(var_02.var_6B21, param_00, 0), 0);
  for(var_03 = 0; var_03 < 6; var_03++) {
    var_02.var_6B15["loadoutPrimaryAttachmentsGUID"][var_03] = maps\mp\gametypes\_class::func_958B(var_02.var_6B21, param_00, 0, var_03);
  }

  var_02.var_6B15["loadoutPrimaryCamoGUID"] = maps\mp\gametypes\_class::func_958E(var_02.var_6B21, param_00, 0);
  var_02.var_6B15["loadoutPrimaryCamo2GUID"] = maps\mp\gametypes\_class::func_958D(var_02.var_6B21, param_00, 0);
  var_02.var_6B15["loadoutPrimaryReticleGUID"] = maps\mp\gametypes\_class::func_9591(var_02.var_6B21, param_00, 0);
  var_02.var_6B15["loadoutPrimaryPaintjobId"] = 0;
  var_02.var_6B15["loadoutPrimaryCharmGUID"] = 0;
  var_02.var_6B15["loadoutSecondaryWeaponStruct"] = maps\mp\_utility::func_473C(maps\mp\gametypes\_class::func_9590(var_02.var_6B21, param_00, 1), 0);
  for(var_03 = 0; var_03 < 6; var_03++) {
    var_02.var_6B15["loadoutSecondaryAttachmentsGUID"][var_03] = maps\mp\gametypes\_class::func_958B(var_02.var_6B21, param_00, 1, var_03);
  }

  var_02.var_6B15["loadoutSecondaryCamoGUID"] = maps\mp\gametypes\_class::func_958E(var_02.var_6B21, param_00, 1);
  var_02.var_6B15["loadoutSecondaryCamo2GUID"] = maps\mp\gametypes\_class::func_958D(var_02.var_6B21, param_00, 1);
  var_02.var_6B15["loadoutSecondaryReticleGUID"] = maps\mp\gametypes\_class::func_9591(var_02.var_6B21, param_00, 1);
  var_02.var_6B15["loadoutSecondaryPaintjobId"] = 0;
  var_02.var_6B15["loadoutSecondaryCharmGUID"] = 0;
  var_02.var_6B15["loadoutEquipmentStruct"] = maps\mp\_utility::func_44CE(maps\mp\gametypes\_class::func_9584(var_02.var_6B21, param_00), 0);
  var_02.var_6B15["loadoutEquipmentNumExtra"] = maps\mp\gametypes\_class::func_9585(var_02.var_6B21, param_00);
  var_02.var_6B15["loadoutOffhandStruct"] = maps\mp\_utility::func_44CE(maps\mp\gametypes\_class::func_9587(var_02.var_6B21, param_00), 0);
  var_02.var_6B15["loadoutOffhandNumExtra"] = maps\mp\gametypes\_class::func_9588(var_02.var_6B21, param_00);
  for(var_03 = 0; var_03 < 9; var_03++) {
    var_02.var_6B15["loadoutPerksGUID"][var_03] = maps\mp\gametypes\_class::func_9589(var_02.var_6B21, param_00, var_03);
  }
}

func_6B24(param_00, param_01, param_02, param_03, param_04) {
  for(var_05 = 0; var_05 < param_00; var_05++) {
    foreach(var_07 in param_03) {
      foreach(var_09 in param_03) {
        var_09 setclientomnvar("ui_onevone_show_class_menu", var_07 getentitynumber());
      }

      var_0B = 0;
      while(var_0B < param_01) {
        var_07 thread func_A703();
        var_07 thread func_A704();
        var_07 waittill("1v1_ban_notify");
        wait 0.05;
        if(isDefined(var_07) && isDefined(var_07.var_21F8)) {
          var_0C = var_07.var_21F8;
        } else {
          var_0C = randomint(3);
        }

        if(var_0C < 0 && !function_0367()) {
          foreach(var_09 in param_03) {
            var_09 setclientomnvar("ui_onevone_show_class_menu", -1);
          }

          level.var_6B18 = 0;
          level.var_6B19 = 0;
          level.var_6B16 = 0;
          level.var_6B17 = 0;
          level.var_6B1F = 1;
          if(isDefined(param_04)) {
            param_04 notify("onevoneClassCreated");
          } else {
            level notify("onevoneClassCreated");
          }

          return [];
        }

        param_04[var_10] = -1;
        foreach(var_0B in var_05) {
          var_0B setclientomnvar("ui_onevone_class_" + var_10 + 1, param_04[var_10]);
        }

        var_0F++;
      }
    }
  }

  return param_02;
}

func_A703() {
  self endon("disconnect");
  self endon("1v1_ban_notify");
  for(;;) {
    self waittill("luinotifyserver", var_00, var_01);
    if(var_00 == "onevone_class_selection") {
      break;
    } else {
      wait 0.05;
    }
  }

  self.var_21F8 = var_01;
  self notify("1v1_ban_notify");
}

func_A704() {
  self endon("disconnect");
  self endon("1v1_ban_notify");
  wait(11);
  if(isDefined(self)) {
    self notify("1v1_ban_notify");
  }
}

func_44DB(param_00) {
  var_01 = 1;
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    if(param_00[var_02] >= 0) {
      var_01 = param_00[var_02];
      break;
    }
  }

  return var_01;
}

func_86E2(param_00, param_01) {
  for(var_02 = 0; var_02 < param_01; var_02++) {
    if(var_02 >= param_00.size) {
      self setclientomnvar("ui_onevone_class_" + var_02 + 1, -1);
      continue;
    }

    self setclientomnvar("ui_onevone_class_" + var_02 + 1, param_00[var_02]);
  }
}

func_86E1(param_00) {
  if(!isDefined(param_00) || param_00) {
    self.var_00E4 = 0;
    self.var_0090 = self.var_00E4;
    maps\mp\_utility::func_867C(self.var_00E4);
  }

  if(isDefined(level.var_6B14) && level.var_6B14 > 0) {
    level.var_6B14 = gettime();
  }

  if(!isDefined(level.var_6B15) && !isDefined(level.var_6B1F) || !level.var_6B1F) {
    maps\mp\_utility::func_3E8E(1);
    level waittill("onevoneClassCreated");
    thread maps\mp\_utility::func_3E90(0, 1);
  }

  if(level.var_744A.size == 2) {
    level.var_744A[0] setclientomnvar("ui_onevone_opponent_client_num", level.var_744A[1] getentitynumber());
    level.var_744A[1] setclientomnvar("ui_onevone_opponent_client_num", level.var_744A[0] getentitynumber());
  }

  if(!level.var_6B1F) {
    if(function_01A9(maps\mp\_utility::func_4737(level.var_6B15["loadoutPrimaryWeaponStruct"])) == "melee") {
      level.var_6B15["ignoreMeleeSlotWeapon"] = 1;
    }

    self.var_012C["class"] = "gamemode";
    self.var_012C["gamemodeLoadout"] = level.var_6B15;
    if(isDefined(level.var_6B18) && level.var_6B18) {
      self.var_00FB = 40;
      self.var_00BC = self.var_00FB;
    } else if(isDefined(level.var_6B17) && level.var_6B17) {
      self.var_00FB = 20;
      self.var_00BC = self.var_00FB;
    } else if(isDefined(level.var_6B16) && level.var_6B16) {
      func_479A();
    }
  } else {
    self.var_012C["class"] = "custom1";
  }

  self.var_012C["lastClass"] = "";
  self.var_2319 = self.var_012C["class"];
  self.var_5B84 = self.var_012C["lastClass"];
  self.var_5DF2 = undefined;
  maps\mp\gametypes\_class::func_4790(self.var_01A7, self.var_2319);
  self.var_5DEE.var_5A62 = 0;
  self.var_5DEE.var_5A63 = 0;
  self.var_5DEE.var_5A64 = 0;
  self.var_5DEE.var_5A65 = 0;
  self.var_5DEE.var_59DA = 0;
  thread func_7B76();
}

func_7B76() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  while(self getcurrentprimaryweapon() == "none") {
    wait 0.05;
  }

  var_00 = maps\mp\_utility::func_4737(self.var_5E00);
  if(isDefined(level.var_6B17) && level.var_6B17) {
    self method_82FA(var_00, 1);
    self setweaponammostock(var_00, 0);
    return;
  }

  if(isDefined(level.var_6B16) && level.var_6B16) {
    func_479A();
    return;
  }

  self setweaponammostock(var_00, func_469F(var_00));
}

func_469F(param_00) {
  var_01 = maps\mp\_utility::func_472A(param_00);
  var_02 = weaponclipsize(param_00);
  switch (var_01) {
    case "weapon_heavy":
      return int(var_02 / 2);

    case "weapon_sniper":
    case "weapon_assault":
    case "weapon_smg":
      if(var_02 > 20) {
        return int(var_02 * 3 / 4);
      } else {
        return var_02;
      }

      break;

    case "weapon_pistol":
    case "weapon_shotgun":
      if(var_02 < 4) {
        return int(var_02 * 2);
      } else {
        return var_02;
      }

      break;

    default:
      return var_02;
  }
}

func_4413(param_00, param_01, param_02) {
  var_03 = func_469F(param_00);
  var_04 = weaponclipsize(param_00);
  return int(min(var_03 + var_04 - param_02, param_01));
}

func_6BB6() {
  level endon("game_ended");
  if(isDefined(level.var_6B23) && level.var_6B23) {
    return;
  }

  level.var_6B23 = 1;
  var_00 = func_46E9();
  if(!isDefined(var_00)) {
    level.var_99F5 = 1;
    foreach(var_02 in level.var_744A) {
      var_02 iclientprintlnbold("Next Kill Wins!");
    }

    level common_scripts\utility::func_A70C(level.var_744A[0], "death", level.var_744A[1], "death");
    var_00 = func_46E9();
  }

  level.var_3B5C = "none";
  level thread maps\mp\gametypes\_gamelogic::func_36B9(var_00, game["end_reason"]["time_limit_reached"]);
}

func_46E9() {
  var_00 = 0;
  var_01 = undefined;
  var_02 = -10000;
  foreach(var_04 in level.var_744A) {
    if(var_04.var_015C > var_02) {
      var_01 = var_04;
      var_02 = var_04.var_015C;
      continue;
    }

    if(var_04.var_015C == var_02) {
      var_00 = 1;
    }
  }

  if(!var_00) {
    return var_01;
  }

  return undefined;
}

func_6B7B(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  self.var_00E4 = 0;
  self.var_0090 = self.var_00E4;
  maps\mp\_utility::func_867C(self.var_00E4);
  if(!isPlayer(param_01)) {
    return;
  }

  if(maps\mp\gametypes\_damage::func_56FA(self, param_01)) {
    return;
  }

  if(param_01 == self) {
    return;
  }

  if(isDefined(level.var_6B1E) && param_01 != level.var_6B1E) {
    level.var_09B7 = min(level.var_606F, level.var_09B7 + level.var_3992);
  }

  level.var_6B1E = func_46E9();
  if(level.var_6B19) {
    var_0A = func_45AB();
    func_86E3(var_0A);
    foreach(var_0C in level.var_744A) {
      var_0C func_86E1(1);
      var_0C maps\mp\gametypes\_class::func_0F35();
      var_0C func_7B76();
    }

    return;
  }

  if(level.var_6B16) {
    param_01 func_479A();
    return;
  }

  if(level.var_6B17) {
    var_0E = maps\mp\_utility::func_4737(param_01.var_5E00);
    param_01 method_82FA(var_0E, 1);
    param_01 switchtoweaponimmediate(var_0E);
    return;
  }
}

func_45AB() {
  if(!isDefined(level.var_6B1A) || level.var_6B1A.size == 0) {
    level.var_6B1A = [];
    for(var_00 = 3; var_00 < 28; var_00++) {
      level.var_6B1A[level.var_6B1A.size] = var_00;
    }

    level.var_6B1A = common_scripts\utility::func_0F92(level.var_6B1A);
  }

  var_01 = common_scripts\utility::func_0F82(level.var_6B1A);
  level.var_6B1A = common_scripts\utility::func_0F93(level.var_6B1A, var_01);
  return var_01;
}

func_479A() {
  maps\mp\_utility::func_47A2("specialty_extralethal");
  self method_82FA("frag_grenade_mp", 2);
  self method_82FA("frag_grenade_german_mp", 2);
  self.var_6088 = 2;
}

func_63F2() {
  level endon("game_ended");
  var_00 = getEntArray("minimap_corner", "targetname");
  var_01 = lib_050D::func_3B89(var_00[0].var_0116, var_00[1].var_0116);
  level.var_6B14 = -20000;
  var_02 = -20000;
  for(;;) {
    var_03 = gettime();
    if(level.var_6B14 + 11000 < var_03) {
      if(var_02 + 8500 < var_03) {
        foreach(var_05 in level.var_744A) {
          function_0256(var_05.var_0116, var_05);
        }

        var_02 = var_03;
      }
    }

    wait 0.05;
  }
}

func_4696(param_00) {
  var_01 = self;
  if(!isDefined(var_01)) {
    for(var_02 = 0; var_02 < level.var_744A.size; var_02++) {
      if(var_02 == param_00) {
        var_01 = level.var_744A[var_02];
        break;
      }
    }
  }

  if(isPlayer(var_01)) {
    return func_6FBC(var_01, level.var_6B20);
  }

  return maps\mp\gametypes\_globallogic::func_4437();
}

func_6FBC(param_00, param_01) {
  if(!isDefined(level.var_6B26)) {
    level.var_6B26 = level.var_908C;
    level.var_6B27 = [];
    level.var_6B28 = [];
    foreach(var_03 in level.var_6B26) {
      if(isDefined(var_03.var_0165)) {
        if(var_03.var_0165 == "start_spawn_a") {
          level.var_6B29 = var_03;
          continue;
        }

        if(var_03.var_0165 == "start_spawn_b") {
          level.var_6B2A = var_03;
          continue;
        }

        if(var_03.var_0165 == "spawn_a") {
          level.var_6B27[level.var_6B27.size] = var_03;
          continue;
        }

        if(var_03.var_0165 == "spawn_b") {
          level.var_6B28[level.var_6B28.size] = var_03;
        }
      }
    }
  }

  if(isDefined(level.var_6B29) && isDefined(level.var_6B2A)) {
    if(param_01) {
      if(param_00 == level.var_744A[0]) {
        return level.var_6B29;
      } else {
        return level.var_6B2A;
      }
    } else if(level.var_744A.size >= 2 && isDefined(level.var_6B27) && level.var_6B27.size > 1 && isDefined(level.var_6B28) && level.var_6B28.size > 1) {
      var_05 = 0;
      var_06 = 0;
      if(param_00 == level.var_744A[0]) {
        var_05 = distance2d(level.var_6B29.var_0116, level.var_744A[1].var_0116);
        var_06 = distance2d(level.var_6B2A.var_0116, level.var_744A[1].var_0116);
      } else {
        var_05 = distance2d(level.var_6B29.var_0116, level.var_744A[0].var_0116);
        var_06 = distance2d(level.var_6B2A.var_0116, level.var_744A[0].var_0116);
      }

      var_07 = level.var_6B27;
      if(var_05 < var_06) {
        var_07 = level.var_6B28;
      }

      return common_scripts\utility::func_7A33(var_07);
    }
  }

  return maps\mp\gametypes\_globallogic::func_4437();
}