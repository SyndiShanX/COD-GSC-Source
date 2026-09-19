/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\onevone.gsc
*************************************************/

main() {
  _id_04D4::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  _id_04D4::setupcallbacks();

  if(_isusingmatchrulesdata()) {
    level._id_5300 = ::_id_5300;
    [[level._id_5300]]();
    level thread maps\mp\_utility::_id_7C13();
  } else {
    maps\mp\_utility::registertimelimitdvar(level.gametype, 3);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 20);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 20);
    level._id_6031 = 0;
    level._id_6035 = 0;
  }

  _id_0511::_id_8751("game", "minimapHiddenWhileADS", 1);
  level._id_3992 = 0.5;
  level._id_606F = 7.0;
  level._id_09B7 = 0.0;
  level._id_6B1E = undefined;
  level._id_6BAF = ::_id_6BAF;
  level._id_6B5C = ::_id_6B5C;
  level._id_6B7F = ::_id_6B7F;
  level._id_4696 = ::_id_4696;
  level._id_6BA7 = ::_id_86E1;
  level._id_6B7B = ::_id_6B7B;
  level._id_6BB6 = ::_id_6BB6;

  if(level._id_6031 || level._id_6035)
    level._id_62AD = maps\mp\gametypes\_damage::_id_3FC8;

  _setteammode("ffa");
  game["dialog"]["gametype"] = "ffa_intro";
  game["dialog"]["defense_obj"] = "gbl_start";
  game["dialog"]["offense_obj"] = "gbl_start";

  if(getdvarint("2043"))
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
}

_id_5300() {
  maps\mp\_utility::_id_8653(1);
  _setdynamicdvar("scr_onevone_winlimit", 1);
  maps\mp\_utility::registerwinlimitdvar("onevone", 1);
  _setdynamicdvar("scr_onevone_roundlimit", 1);
  maps\mp\_utility::registerroundlimitdvar("onevone", 1);
  _setdynamicdvar("scr_onevone_halftime", 0);
  maps\mp\_utility::registerhalftimedvar("onevone", 0);
}

_id_6BAF() {
  _setclientnamemode("auto_change");
  maps\mp\_utility::setobjectivetext("allies", &"OBJECTIVES_ONEVONE");
  maps\mp\_utility::setobjectivetext("axis", &"OBJECTIVES_ONEVONE");

  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_ONEVONE");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_ONEVONE");
  } else {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_ONEVONE_SCORE");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_ONEVONE_SCORE");
  }

  maps\mp\_utility::setobjectivehinttext("allies", &"OBJECTIVES_ONEVONE_HINT");
  maps\mp\_utility::setobjectivehinttext("axis", &"OBJECTIVES_ONEVONE_HINT");
  _id_050D::_id_10E4();
  level._id_A239 = 0;
  var_0[0] = "onevone";
  _id_04D1::main(var_0);
  level._id_7895 = 1;
  level._id_7691 = 0;
  level._id_7692 = 0;
  level._id_17EF = 1;
  level thread _id_92EE();
}

_id_6B5C(var_0, var_1, var_2) {
  var_3 = 0;

  foreach(var_5 in level.players) {
    if(isDefined(var_5.score) && var_5.score > var_3)
      var_3 = var_5.score;
  }

  if(game["state"] == "postgame" && var_1.score >= var_3)
    var_1._id_3B4B = 1;
}

_id_6B7F(var_0, var_1, var_2, var_3, var_4) {
  if(_id_57BE(var_0)) {
    var_5 = 1;

    if(var_4 == "MOD_MELEE") {
      if((!isDefined(level._id_6B17) || !level._id_6B17) && (!isDefined(level._id_6B18) || !level._id_6B18) && (!isDefined(level._id_6B16) || !level._id_6B16) && self._id_5DFE != "shovel_loot3_mp")
        var_5 = 2;

      var_1._id_0021++;
    }

    var_1._id_00E4++;
    var_1._id_0090 = var_1._id_00E4;
    var_1 maps\mp\_utility::_id_867C(var_1._id_00E4);
    var_6 = var_5 * maps\mp\gametypes\_rank::getscoreinfovalue(var_0);
    var_1 maps\mp\_utility::_id_867B(var_1._id_008F + var_6);
    var_1 _id_04D2::_id_A161(var_1, var_6);
    return var_5;
  }

  return 0;
}

_id_57BE(var_0) {
  switch (var_0) {
    case "kill":
    case "flamethrower_kill":
      return 1;
  }

  return 0;
}

_id_92EE() {
  level.timerstopped = 1;
  level._id_9A13 = 1;
  level.timerpausetime = gettime();
  level._id_6B20 = 1;

  while(level.players.size < 2 || level.ingraceperiod)
    waitframe();

  _id_92EF(level.players, undefined);
  level._id_6B20 = 0;
  wait 1.0;
  maps\mp\gametypes\_gamelogic::_id_7DFC();
  level thread _id_63F2();
}

ishqarenaingungame(var_0) {
  return var_0 == 41 || var_0 == 42 || var_0 == 43 || var_0 == 44 || var_0 == 45;
}

isjumping(var_0, var_1) {
  if(level.gametype == "onevone" && var_1 == 1)
    return [26 + randomint(3), 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40];
  else if(level.gametype == "onevone" && var_1 == 2)
    return [3 + randomint(38)];
  else {
    var_2 = [[3, 4, 5, 6, 7, 33, 34, 46, 47], [8, 9, 10, 11, 12, 13, 48, 49], [14, 15, 19, 35, 50], [16, 17, 18, 36], [20, 21, 22, 37], [23, 24, 38, 39, 41, 43], [26, 27, 25, 40, 42, 44, 45], [41], [42, 43, 44, 45]];
    var_3 = [];
    var_4 = 1;
    var_5 = 1;

    for(var_6 = 0; var_6 < var_0; var_6++) {
      var_7 = 0;
      var_8 = -1;
      var_9 = 1;
      var_10 = 1;

      while(!var_7) {
        if(level.gametype == "onevone") {
          switch (var_6) {
            case 0:
              var_8 = 0;
              var_10 = 0;
              break;
            case 1:
              var_8 = 1;
              var_10 = 0;
              break;
            case 2:
              var_8 = 3;
              var_10 = 0;
              break;
            case 3:
              var_8 = 4;
              var_10 = 0;
              break;
            case 4:
              var_8 = 2 + 3 * randomint(2);
              break;
          }
        } else if(level.hub_1v1_weapon_mode == 0) {
          switch (var_6) {
            case 0:
              var_8 = randomint(2);
              break;
            case 1:
              var_8 = _randomintrange(2, 5);
              break;
            case 2:
              var_8 = _randomintrange(5, 7);
              var_10 = 0;
              break;
          }
        } else if(level.hub_1v1_weapon_mode == 1) {
          var_4 = 0;
          var_5 = 0;

          switch (var_6) {
            case 0:
              var_8 = 7;
              var_10 = 0;
              break;
            case 1:
              var_8 = 8;
              var_10 = 0;
              var_9 = 0;
              break;
            case 2:
              var_8 = 8;
              var_10 = 0;
              var_9 = 0;
              break;
          }
        }

        var_7 = 1;

        for(var_11 = 0; var_10 && isDefined(level._id_6B1C) && var_11 < level._id_6B1C.size; var_11++) {
          if(level._id_6B1C[var_11] == var_8)
            var_7 = 0;
        }

        for(var_11 = 0; var_9 && var_11 < var_3.size; var_11++) {
          if(var_3[var_11] == var_8)
            var_7 = 0;
        }

        if(!var_7)
          waitframe();
      }

      var_3[var_3.size] = var_8;
    }

    var_12 = [];

    foreach(var_14 in var_3) {
      var_7 = 0;
      var_15 = -1;

      while(!var_7) {
        var_15 = var_2[var_14][randomint(var_2[var_14].size)];
        var_7 = 1;

        for(var_11 = 0; var_4 && isDefined(level._id_6B1B) && var_11 < level._id_6B1B.size; var_11++) {
          if(level._id_6B1B[var_11] == var_15)
            var_7 = 0;
        }

        for(var_11 = 0; var_5 && isDefined(level._id_6B1D) && var_11 < level._id_6B1D.size; var_11++) {
          if(level._id_6B1D[var_11] == var_15)
            var_7 = 0;
        }

        for(var_11 = 0; isDefined(var_12) && var_11 < var_12.size; var_11++) {
          if(var_12[var_11] == var_15)
            var_7 = 0;
        }

        if(!var_7)
          waitframe();
      }

      var_12[var_12.size] = var_15;
    }

    level._id_6B1D = level._id_6B1B;
    level._id_6B1B = var_12;
    level._id_6B1C = var_3;
    return var_12;
  }
}

_id_92EF(var_0, var_1) {
  var_2 = 5;
  var_3 = 3;
  var_4 = 1;
  var_5 = 1;
  var_6 = -1;

  if(level.gametype == "onevone") {
    var_7 = [0, 1, 2];

    foreach(var_9 in var_0)
    var_9 _id_86E2(var_7, var_2);

    var_7 = _id_6B24(var_4, var_5, var_7, var_0, var_1);

    if(var_7.size == 0) {
      return;
    }
    var_6 = _id_44DB(var_7);

    foreach(var_9 in var_0)
    var_9 setclientomnvar("ui_onevone_show_class_menu", -1);

    waitframe();
    var_3 = var_2;
    var_4 = 2;
  }

  var_7 = isjumping(var_3, var_6);

  if(var_6 != 2) {
    foreach(var_9 in var_0)
    var_9 _id_86E2(var_7, var_2);

    var_7 = _id_6B24(var_4, var_5, var_7, var_0, var_1);
  }

  foreach(var_9 in var_0)
  var_9 setclientomnvar("ui_onevone_show_class_menu", -1);

  if(var_7.size == 0) {
    level._id_6B18 = 0;
    level._id_6B19 = 0;
    level._id_6B16 = 0;
    level._id_6B17 = 0;
  } else {
    var_17 = _id_44DB(var_7);
    level._id_6B18 = var_17 == 29;
    level._id_6B19 = var_17 == 30;
    level._id_6B16 = var_17 == 31;
    level._id_6B17 = var_17 == 32;

    if(level._id_6B19)
      var_17 = _id_45AB();

    _id_86E3(var_17, var_1);
    level._id_6B1F = 0;

    if(isDefined(var_1)) {
      var_1 notify("onevoneClassCreated");
      return;
    }

    level notify("onevoneClassCreated");
  }
}

_id_86E3(var_0, var_1) {
  if(isDefined(var_1))
    var_2 = var_1;
  else
    var_2 = level;

  var_2.onevone_classchoicenum = var_0;

  if(level.gametype != "onevone" && ishqarenaingungame(var_0)) {
    return;
  }
  var_2._id_6B15 = maps\mp\gametypes\_class::_id_44B4();
  var_2._id_6B21 = "maps/mp/gametypes/onevoneClassTable.csv";
  var_2._id_6B15["loadoutDivision"] = maps\mp\gametypes\_class::table_getdivision(var_2._id_6B21, var_0);
  var_2._id_6B15["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::_id_473C(maps\mp\gametypes\_class::table_getweapon(var_2._id_6B21, var_0, 0), 0);

  for(var_3 = 0; var_3 < 6; var_3++)
    var_2._id_6B15["loadoutPrimaryAttachmentsGUID"][var_3] = maps\mp\gametypes\_class::table_getweaponattachment(var_2._id_6B21, var_0, 0, var_3);

  var_2._id_6B15["loadoutPrimaryCamoGUID"] = maps\mp\gametypes\_class::table_getweaponcamo(var_2._id_6B21, var_0, 0);
  var_2._id_6B15["loadoutPrimaryCamo2GUID"] = maps\mp\gametypes\_class::table_getweaponcamo2(var_2._id_6B21, var_0, 0);
  var_2._id_6B15["loadoutPrimaryReticleGUID"] = maps\mp\gametypes\_class::table_getweaponreticle(var_2._id_6B21, var_0, 0);
  var_2._id_6B15["loadoutPrimaryPaintjobId"] = 0;
  var_2._id_6B15["loadoutPrimaryCharmGUID"] = 0;
  var_2._id_6B15["loadoutSecondaryWeaponStruct"] = maps\mp\_utility::_id_473C(maps\mp\gametypes\_class::table_getweapon(var_2._id_6B21, var_0, 1), 0);

  for(var_3 = 0; var_3 < 6; var_3++)
    var_2._id_6B15["loadoutSecondaryAttachmentsGUID"][var_3] = maps\mp\gametypes\_class::table_getweaponattachment(var_2._id_6B21, var_0, 1, var_3);

  var_2._id_6B15["loadoutSecondaryCamoGUID"] = maps\mp\gametypes\_class::table_getweaponcamo(var_2._id_6B21, var_0, 1);
  var_2._id_6B15["loadoutSecondaryCamo2GUID"] = maps\mp\gametypes\_class::table_getweaponcamo2(var_2._id_6B21, var_0, 1);
  var_2._id_6B15["loadoutSecondaryReticleGUID"] = maps\mp\gametypes\_class::table_getweaponreticle(var_2._id_6B21, var_0, 1);
  var_2._id_6B15["loadoutSecondaryPaintjobId"] = 0;
  var_2._id_6B15["loadoutSecondaryCharmGUID"] = 0;
  var_2._id_6B15["loadoutEquipmentStruct"] = maps\mp\_utility::_id_44CE(maps\mp\gametypes\_class::table_getequipment(var_2._id_6B21, var_0), 0);
  var_2._id_6B15["loadoutEquipmentNumExtra"] = maps\mp\gametypes\_class::_id_9585(var_2._id_6B21, var_0);
  var_2._id_6B15["loadoutOffhandStruct"] = maps\mp\_utility::_id_44CE(maps\mp\gametypes\_class::table_getoffhand(var_2._id_6B21, var_0), 0);
  var_2._id_6B15["loadoutOffhandNumExtra"] = maps\mp\gametypes\_class::table_getoffhandextra(var_2._id_6B21, var_0);

  for(var_3 = 0; var_3 < 9; var_3++)
    var_2._id_6B15["loadoutPerksGUID"][var_3] = maps\mp\gametypes\_class::table_getperk(var_2._id_6B21, var_0, var_3);
}

_id_6B24(var_0, var_1, var_2, var_3, var_4) {
  for(var_5 = 0; var_5 < var_0; var_5++) {
    foreach(var_7 in var_3) {
      foreach(var_9 in var_3)
      var_9 setclientomnvar("ui_onevone_show_class_menu", var_7 getentitynumber());

      for(var_11 = 0; var_11 < var_1; var_11++) {
        var_7 thread _id_A703();
        var_7 thread _id_A704();
        var_7 waittill("1v1_ban_notify");
        waitframe();

        if(isDefined(var_7) && isDefined(var_7._id_21F8))
          var_12 = var_7._id_21F8;
        else
          var_12 = randomint(3);

        if(var_12 < 0 && !_func_367()) {
          foreach(var_9 in var_3)
          var_9 setclientomnvar("ui_onevone_show_class_menu", -1);

          level._id_6B18 = 0;
          level._id_6B19 = 0;
          level._id_6B16 = 0;
          level._id_6B17 = 0;
          level._id_6B1F = 1;

          if(isDefined(var_4))
            var_4 notify("onevoneClassCreated");
          else
            level notify("onevoneClassCreated");

          return [];
        }

        var_2[var_12] = -1;

        foreach(var_9 in var_3)
        var_9 setclientomnvar("ui_onevone_class_" + (var_12 + 1), var_2[var_12]);
      }
    }
  }

  return var_2;
}

_id_A703() {
  self endon("disconnect");
  self endon("1v1_ban_notify");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "onevone_class_selection") {
      break;
    } else
      waitframe();
  }

  self._id_21F8 = var_1;
  self notify("1v1_ban_notify");
}

_id_A704() {
  self endon("disconnect");
  self endon("1v1_ban_notify");
  wait 11;

  if(isDefined(self))
    self notify("1v1_ban_notify");
}

_id_44DB(var_0) {
  var_1 = 1;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2] >= 0) {
      var_1 = var_0[var_2];
      break;
    }
  }

  return var_1;
}

_id_86E2(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1; var_2++) {
    if(var_2 >= var_0.size) {
      self setclientomnvar("ui_onevone_class_" + (var_2 + 1), -1);
      continue;
    }

    self setclientomnvar("ui_onevone_class_" + (var_2 + 1), var_0[var_2]);
  }
}

_id_86E1(var_0) {
  if(!isDefined(var_0) || var_0) {
    self._id_00E4 = 0;
    self._id_0090 = self._id_00E4;
    maps\mp\_utility::_id_867C(self._id_00E4);
  }

  if(isDefined(level._id_6B14) && level._id_6B14 > 0)
    level._id_6B14 = gettime();

  if(!isDefined(level._id_6B15) && (!isDefined(level._id_6B1F) || !level._id_6B1F)) {
    maps\mp\_utility::freezecontrolswrapper(1);
    level waittill("onevoneClassCreated");
    thread maps\mp\_utility::_id_3E90(0, 1.0);
  }

  if(level.players.size == 2) {
    level.players[0] setclientomnvar("ui_onevone_opponent_client_num", level.players[1] getentitynumber());
    level.players[1] setclientomnvar("ui_onevone_opponent_client_num", level.players[0] getentitynumber());
  }

  if(!level._id_6B1F) {
    if(_weapontype(maps\mp\_utility::_id_4737(level._id_6B15["loadoutPrimaryWeaponStruct"])) == "melee")
      level._id_6B15["ignoreMeleeSlotWeapon"] = 1;

    self.pers["class"] = "gamemode";
    self.pers["gamemodeLoadout"] = level._id_6B15;

    if(isDefined(level._id_6B18) && level._id_6B18) {
      self.maxhealth = 40;
      self.health = self.maxhealth;
    } else if(isDefined(level._id_6B17) && level._id_6B17) {
      self.maxhealth = 20;
      self.health = self.maxhealth;
    } else if(isDefined(level._id_6B16) && level._id_6B16)
      _id_479A();
  } else
    self.pers["class"] = "custom1";

  self.pers["lastClass"] = "";
  self.class = self.pers["class"];
  self.lastclass = self.pers["lastClass"];
  self._id_5DF2 = undefined;
  maps\mp\gametypes\_class::_id_4790(self.team, self.class);
  self._id_5DEE._id_5A62 = 0;
  self._id_5DEE._id_5A63 = 0;
  self._id_5DEE._id_5A64 = 0;
  self._id_5DEE._id_5A65 = 0;
  self._id_5DEE._id_59DA = 0;
  thread _id_7B76();
}

_id_7B76() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  while(self getcurrentprimaryweapon() == "none")
    waitframe();

  var_0 = maps\mp\_utility::_id_4737(self._id_5E00);

  if(isDefined(level._id_6B17) && level._id_6B17) {
    self setweaponammoclip(var_0, 1);
    self setweaponammostock(var_0, 0);
  } else if(isDefined(level._id_6B16) && level._id_6B16)
    _id_479A();
  else
    self setweaponammostock(var_0, _id_469F(var_0));
}

_id_469F(var_0) {
  var_1 = maps\mp\_utility::getweaponclass(var_0);
  var_2 = _weaponclipsize(var_0);

  switch (var_1) {
    case "weapon_heavy":
      return int(var_2 / 2);
    case "weapon_sniper":
    case "weapon_assault":
    case "weapon_smg":
      if(var_2 > 20)
        return int(var_2 * 3 / 4);
      else
        return var_2;
    case "weapon_pistol":
    case "weapon_shotgun":
      if(var_2 < 4)
        return int(var_2 * 2);
      else
        return var_2;
    default:
      return var_2;
  }
}

_id_4413(var_0, var_1, var_2) {
  var_3 = _id_469F(var_0);
  var_4 = _weaponclipsize(var_0);
  return int(_min(var_3 + var_4 - var_2, var_1));
}

_id_6BB6() {
  level endon("game_ended");

  if(isDefined(level._id_6B23) && level._id_6B23) {
    return;
  }
  level._id_6B23 = 1;
  var_0 = _id_46E9();

  if(!isDefined(var_0)) {
    level._id_99F5 = 1;

    foreach(var_2 in level.players)
    var_2 iprintlnbold("Next Kill Wins!");

    level common_scripts\utility::_id_A70C(level.players[0], "death", level.players[1], "death");
    var_0 = _id_46E9();
  }

  level._id_3B5C = "none";
  level thread maps\mp\gametypes\_gamelogic::_id_36B9(var_0, game["end_reason"]["time_limit_reached"]);
}

_id_46E9() {
  var_0 = 0;
  var_1 = undefined;
  var_2 = -10000;

  foreach(var_4 in level.players) {
    if(var_4.score > var_2) {
      var_1 = var_4;
      var_2 = var_4.score;
      continue;
    }

    if(var_4.score == var_2)
      var_0 = 1;
  }

  if(!var_0)
    return var_1;
  else
    return undefined;
}

_id_6B7B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self._id_00E4 = 0;
  self._id_0090 = self._id_00E4;
  maps\mp\_utility::_id_867C(self._id_00E4);

  if(!isPlayer(var_1)) {
    return;
  }
  if(maps\mp\gametypes\_damage::_id_56FA(self, var_1)) {
    return;
  }
  if(var_1 == self) {
    return;
  }
  if(isDefined(level._id_6B1E) && var_1 != level._id_6B1E)
    level._id_09B7 = _min(level._id_606F, level._id_09B7 + level._id_3992);

  level._id_6B1E = _id_46E9();

  if(level._id_6B19) {
    var_10 = _id_45AB();
    _id_86E3(var_10);

    foreach(var_12 in level.players) {
      var_12 _id_86E1(1);
      var_12 maps\mp\gametypes\_class::_id_0F35();
      var_12 _id_7B76();
    }
  } else if(level._id_6B16)
    var_1 _id_479A();
  else if(level._id_6B17) {
    var_14 = maps\mp\_utility::_id_4737(var_1._id_5E00);
    var_1 setweaponammoclip(var_14, 1);
    var_1 switchtoweaponimmediate(var_14);
  }
}

_id_45AB() {
  if(!isDefined(level._id_6B1A) || level._id_6B1A.size == 0) {
    level._id_6B1A = [];

    for(var_0 = 3; var_0 < 28; var_0++)
      level._id_6B1A[level._id_6B1A.size] = var_0;

    level._id_6B1A = common_scripts\utility::array_randomize(level._id_6B1A);
  }

  var_1 = common_scripts\utility::_id_0F82(level._id_6B1A);
  level._id_6B1A = common_scripts\utility::_id_0F93(level._id_6B1A, var_1);
  return var_1;
}

_id_479A() {
  maps\mp\_utility::giveperk("specialty_extralethal");
  self setweaponammoclip("frag_grenade_mp", 2);
  self setweaponammoclip("frag_grenade_german_mp", 2);
  self._id_6088 = 2;
}

_id_63F2() {
  level endon("game_ended");
  var_0 = getEntArray("minimap_corner", "targetname");
  var_1 = _id_050D::_id_3B89(var_0[0].origin, var_0[1].origin);
  level._id_6B14 = -20000;
  var_2 = -20000;

  for(;;) {
    var_3 = gettime();

    if(level._id_6B14 + 11000 < var_3) {
      if(var_2 + 8500 < var_3) {
        foreach(var_5 in level.players)
        _func_256(var_5.origin, var_5);

        var_2 = var_3;
      }
    }

    waitframe();
  }
}

_id_4696(var_0) {
  var_1 = self;

  if(!isDefined(var_1)) {
    for(var_2 = 0; var_2 < level.players.size; var_2++) {
      if(var_2 == var_0) {
        var_1 = level.players[var_2];
        break;
      }
    }
  }

  if(isPlayer(var_1))
    return _id_6FBC(var_1, level._id_6B20);

  return _id_04D4::_id_4437();
}

_id_6FBC(var_0, var_1) {
  if(!isDefined(level._id_6B26)) {
    level._id_6B26 = level._id_908C;
    level._id_6B27 = [];
    level._id_6B28 = [];

    foreach(var_3 in level._id_6B26) {
      if(isDefined(var_3._id_0165)) {
        if(var_3._id_0165 == "start_spawn_a") {
          level._id_6B29 = var_3;
          continue;
        }

        if(var_3._id_0165 == "start_spawn_b") {
          level._id_6B2A = var_3;
          continue;
        }

        if(var_3._id_0165 == "spawn_a") {
          level._id_6B27[level._id_6B27.size] = var_3;
          continue;
        }

        if(var_3._id_0165 == "spawn_b")
          level._id_6B28[level._id_6B28.size] = var_3;
      }
    }
  }

  if(isDefined(level._id_6B29) && isDefined(level._id_6B2A)) {
    if(var_1) {
      if(var_0 == level.players[0])
        return level._id_6B29;
      else
        return level._id_6B2A;
    } else if(level.players.size >= 2 && isDefined(level._id_6B27) && level._id_6B27.size > 1 && isDefined(level._id_6B28) && level._id_6B28.size > 1) {
      var_5 = 0;
      var_6 = 0;

      if(var_0 == level.players[0]) {
        var_5 = _distance2d(level._id_6B29.origin, level.players[1].origin);
        var_6 = _distance2d(level._id_6B2A.origin, level.players[1].origin);
      } else {
        var_5 = _distance2d(level._id_6B29.origin, level.players[0].origin);
        var_6 = _distance2d(level._id_6B2A.origin, level.players[0].origin);
      }

      var_7 = level._id_6B27;

      if(var_5 < var_6)
        var_7 = level._id_6B28;

      return common_scripts\utility::random(var_7);
    }
  }

  return _id_04D4::_id_4437();
}