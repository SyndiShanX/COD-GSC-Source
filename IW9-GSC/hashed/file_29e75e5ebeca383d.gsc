/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_29e75e5ebeca383d.gsc
***********************************************/

_id_FB7271D5EE18B98D(data) {
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("safe", ::_id_F156678B1297CFB2);
  level._id_D8B853B40A83B85A = spawnStruct();

  if(getdvarint("dvar_5EA4FA2AE23946A7", 0) != 0)
    level._id_D8B853B40A83B85A.time = getdvarint("dvar_5EA4FA2AE23946A7", 0);
  else
    level._id_D8B853B40A83B85A.time = _id_64ACB6CE534155B7::_id_B891F0C9814330EB("safecracker");

  level._id_D8B853B40A83B85A._id_7CA8C9DD069B168F = getdvarint("dvar_CFD8130A7AC5BDCF", 90);
  level._id_D8B853B40A83B85A._id_F7D2D2031214744B = getdvarint("dvar_62EED71E92D5AED0", 3);
  level._id_D8B853B40A83B85A._id_591B8A798C3A67C3 = getdvarint("dvar_952302AF5EBC79D4", 2000);
  level._id_D8B853B40A83B85A._id_59216A99E6C86D53 = level._id_D8B853B40A83B85A._id_591B8A798C3A67C3 * level._id_D8B853B40A83B85A._id_591B8A798C3A67C3;
  level._id_D8B853B40A83B85A._id_49D9DE2A9CD31CDD = getdvarint("dvar_FB53E617C8BA412A", 12500);
  level._id_D8B853B40A83B85A._id_FC6C2C380A8177A1 = level._id_D8B853B40A83B85A._id_49D9DE2A9CD31CDD * level._id_D8B853B40A83B85A._id_49D9DE2A9CD31CDD;
  level._id_D8B853B40A83B85A._id_0A127465B8187AC6 = getdvarint("dvar_B8BC0DB35821CDCA", 5000);
  level._id_D8B853B40A83B85A._id_B2193923C0E12A84 = getdvarint("dvar_9928CA92A88608A4", 7000);
  level._id_D8B853B40A83B85A._id_3AAD62E7A6C7F662 = getdvarint("dvar_0A868DE1AA94E39C", 1);
  level._id_D8B853B40A83B85A._id_0597C27BD871980D = getdvarint("dvar_6197C0161EDB1DC5", 1);
  level._id_D8B853B40A83B85A._id_0A75DA4F9A75843E = getdvarint("dvar_BB228E00BD7B5C27", 45);
  level._id_D8B853B40A83B85A._id_6E8B543291B3BD51 = getdvarfloat("dvar_D2C15D7F43BB9E4C", 5.0);
  level._id_D8B853B40A83B85A._id_C7FABBF8BA74055D = getdvarfloat("dvar_F13FC63A2B8A1B8D", 30.0);
  level._id_D8B853B40A83B85A._id_A4DFE8291567C56B = getdvarint("dvar_54DCA27F5ECFA36E", 1000);
  level._id_D8B853B40A83B85A._id_8FE0E04A07E07422 = getdvarfloat("dvar_829DE2BBB4CEF69F", 4.0);
  level._id_D8B853B40A83B85A._id_F45ED74A08F90A5A = getdvarint("dvar_EFAE0B9A025AD8BA", 1);
  level._id_D8B853B40A83B85A._id_056AD755924F1363 = 21;
  level._id_D8B853B40A83B85A._id_CA3BEE0F7088468F = 0;
  game["dialog"]["mission_safecrack_accept"] = "rnkp_wzan_msst";
  game["dialog"]["mission_safecrack_success"] = "rnkp_wzan_mssc";
  game["dialog"]["mission_safecrack_safe1"] = "rnkp_wzan_tms1";
  game["dialog"]["mission_safecrack_safe1_first_person"] = "rnkp_wzan_plso";
  game["dialog"]["mission_safecrack_safe2"] = "rnkp_wzan_tms2";
  game["dialog"]["mission_safecrack_safe2_first_person"] = "rnkp_wzan_plst";
  data.funcs["onInit"] = ::_id_8C64A4F648288A95;
  data.funcs["onShowAgain"] = ::_id_86CFD4337FEDF826;
  data.funcs["onTeamAssigned"] = ::_id_921A0BE9EC330C6A;
  data.funcs["onEnterGulag"] = ::_id_CA07A6CA5C3C8AF5;
  data.funcs["onPlayerRespawn"] = ::_id_F6755BD234F8E261;
  data.funcs["onPlayerKilled"] = ::_id_A2045D8CAF0F792F;
  data.funcs["onPlayerDisconnect"] = ::_id_319BA124F0EC457C;
  data.funcs["onCancel"] = ::_id_AFD4BF63773CD7AD;
  data.funcs["onPlayerTearDown"] = ::_id_83D3732A571F142A;
  data.funcs["onPlayerAssimilated"] = ::_id_75B53AD947495F9C;
  data.funcs["circleTick"] = ::_id_BCDFE083CC8168D7;
  data.funcs["onTimerExpired"] = ::_id_A80693D6D6F626DC;
  data.funcs["validateContractNotInStronghold"] = ::_id_3E354A7F7649493B;
}

_id_8C64A4F648288A95() {
  self._id_5344ABD2BA35D7C2 = [];
  _id_AB2BE8088C0A7C90 = _id_70C697E50D1A348F();

  if(!_id_CC660B55959B2E7F(_id_AB2BE8088C0A7C90))
    return 0;

  foreach(_id_2A438B0332B8A143 in _id_AB2BE8088C0A7C90) {
    _id_65F2E31BA81E1B45 = spawnStruct();
    _id_65F2E31BA81E1B45._id_2A438B0332B8A143 = _id_2A438B0332B8A143;
    self._id_5344ABD2BA35D7C2[self._id_5344ABD2BA35D7C2.size] = _id_65F2E31BA81E1B45;
  }

  self._id_B98ADEEA66F9BBF8 = 0;
  return 1;
}

_id_86CFD4337FEDF826() {
  return 0;
}

_id_921A0BE9EC330C6A() {
  self.category = "safecracker";
  _id_FABF84450735DD93 = self.teams[0];
  _id_F7D2D2031214744B = level._id_D8B853B40A83B85A._id_F7D2D2031214744B;
  time = level._id_D8B853B40A83B85A.time;
  _id_64ACB6CE534155B7::uiobjectiveshowtoteam("safecracker", _id_FABF84450735DD93);
  time = _id_64ACB6CE534155B7::_id_9B6275085FBCB8F4(time);
  _id_64ACB6CE534155B7::_id_5A15174D34F0670C(time, 0);
  self._id_0E6BF347FCA0E305 = [];

  foreach(_id_65F2E31BA81E1B45 in self._id_5344ABD2BA35D7C2) {
    _id_65F2E31BA81E1B45._id_32605DB102447D94 = _id_0AF2FB3745ABD2CC(_id_65F2E31BA81E1B45._id_2A438B0332B8A143.origin, _id_65F2E31BA81E1B45._id_2A438B0332B8A143.angles);
    _id_65F2E31BA81E1B45._id_32605DB102447D94._id_65F2E31BA81E1B45 = _id_65F2E31BA81E1B45;
  }

  if(level._id_D8B853B40A83B85A._id_3AAD62E7A6C7F662) {
    foreach(_id_65F2E31BA81E1B45 in self._id_5344ABD2BA35D7C2) {
      _id_65F2E31BA81E1B45 _id_37E73A6A4C1AFB18(_id_FABF84450735DD93);
      _id_65F2E31BA81E1B45 _id_89E2EEF706F41A37(_id_FABF84450735DD93);
    }
  } else {
    self._id_5344ABD2BA35D7C2[0] _id_37E73A6A4C1AFB18(_id_FABF84450735DD93);
    self._id_5344ABD2BA35D7C2[0] _id_89E2EEF706F41A37(_id_FABF84450735DD93);
  }

  _id_64ACB6CE534155B7::displayteamsplash(_id_FABF84450735DD93, "br_safecracker_quest_start_team");
  _id_64ACB6CE534155B7::displaysquadmessagetoteam(_id_FABF84450735DD93, self._id_0D154AC2657C5F44, 6, _id_64ACB6CE534155B7::getquestindex("safecracker"));
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_safecrack_accept", _id_FABF84450735DD93, 1, 2);
}

_id_CA07A6CA5C3C8AF5(player) {
  if(_id_42A0806457EA8039(player))
    _id_738B34CE3EB8143E(player);
}

_id_F6755BD234F8E261(player) {
  if(_id_42A0806457EA8039(player))
    _id_EAB871A28AE5F349(player);
}

_id_A2045D8CAF0F792F(attacker, victim) {
  _id_D7A3859EF519189D(victim);
}

_id_319BA124F0EC457C(player) {
  _id_D7A3859EF519189D(player);
}

_id_AFD4BF63773CD7AD(team) {
  if(istrue(self.teams[0] == team))
    _id_CD0F560FAD2E9CB6(0);
}

_id_D7A3859EF519189D(player) {
  if(player.team == self.teams[0]) {
    if(!_id_3ACF1C0EBAF602F2::isteamvalid(self.teams[0], level._id_41F4BC9EE8C7C9C6.defaultfilter)) {
      if(istrue(level._id_D8B853B40A83B85A._id_F45ED74A08F90A5A) && istrue(self._id_CFB8550756FFDFAA)) {
        return;
      }
      _id_CD0F560FAD2E9CB6(0);
    }
  }
}

_id_AA30A0B07502A038(success, results) {
  self notify("task_ended");
  wait 1.0;
  _id_E8C97D5848BB6AB4(self.teams[0], 1);
  _id_64ACB6CE534155B7::_id_93663FE58D95F174(scripts\engine\utility::ter_op(istrue(success), self.teams[0], undefined), results);
}

_id_83D3732A571F142A(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  if(_id_8A04AA0E0755E7E3 == self.teams[0]) {
    _id_738B34CE3EB8143E(player);
    player _id_64ACB6CE534155B7::uiobjectivehide();

    foreach(_id_65F2E31BA81E1B45 in self._id_5344ABD2BA35D7C2) {
      if(isDefined(_id_65F2E31BA81E1B45._id_32605DB102447D94))
        _id_65F2E31BA81E1B45._id_32605DB102447D94 disablescriptableplayeruse(player);
    }

    if(!_id_3ACF1C0EBAF602F2::isteamvalid(self.teams[0], level._id_41F4BC9EE8C7C9C6.defaultfilter)) {
      thread _id_A199D7C38ADEEC99();
      thread _id_AA30A0B07502A038(0);
    }
  }
}

_id_75B53AD947495F9C(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  if(_id_EB06B338608EF354 == self.teams[0]) {
    _id_EAB871A28AE5F349(player);
    player _id_64ACB6CE534155B7::uiobjectiveshow("safecracker");
    player setclientomnvar("ui_br_objective_countdown_timer", self.missiontime);

    foreach(_id_65F2E31BA81E1B45 in self._id_5344ABD2BA35D7C2) {
      if(isDefined(_id_65F2E31BA81E1B45._id_32605DB102447D94))
        _id_65F2E31BA81E1B45._id_32605DB102447D94 enablescriptableplayeruse(player);
    }
  }
}

_id_BCDFE083CC8168D7(_id_819EDACDACB810E4, _id_52D59C928EB97C81) {
  if(istrue(self._id_DF2A5E89C3BBA966)) {
    return;
  }
  foreach(_id_65F2E31BA81E1B45 in self._id_5344ABD2BA35D7C2) {
    if(isDefined(_id_65F2E31BA81E1B45._id_32605DB102447D94)) {
      if(istrue(_id_65F2E31BA81E1B45._id_32605DB102447D94.bombplanted)) {
        continue;
      }
      if(!_id_58F20490049AF6AC::_id_778A4C3D053ED0A9(_id_65F2E31BA81E1B45._id_32605DB102447D94.origin)) {
        self._id_DF2A5E89C3BBA966 = 1;
        _id_CD0F560FAD2E9CB6(1, "br_safecracker_quest_obj_circle", "mission_gen_fail");
        return;
      }
    }
  }
}

_id_A80693D6D6F626DC() {
  foreach(_id_65F2E31BA81E1B45 in self._id_5344ABD2BA35D7C2) {
    if(isDefined(_id_65F2E31BA81E1B45._id_32605DB102447D94) && istrue(_id_65F2E31BA81E1B45._id_32605DB102447D94.bombplanted) && !istrue(_id_65F2E31BA81E1B45._id_32605DB102447D94.opened)) {
      wait(level._id_D8B853B40A83B85A._id_6E8B543291B3BD51);
      _id_64ACB6CE534155B7::_id_51D3A2B4CDE79545();
      return;
    }
  }

  _id_CD0F560FAD2E9CB6(1, "br_safecracker_quest_timer_expired", "mission_gen_fail_time");
}

_id_CD0F560FAD2E9CB6(_id_BEF2D73950379FA0, _id_F7B6CC6C062A7A43, _id_A7B676ACA5B263C2) {
  if(istrue(_id_BEF2D73950379FA0)) {
    params = spawnStruct();
    params.intvar = 0;
    _id_64ACB6CE534155B7::displayteamsplash(self.teams[0], _id_F7B6CC6C062A7A43, params);
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam(_id_A7B676ACA5B263C2, self.teams[0], 1, 2);
  }

  thread _id_A199D7C38ADEEC99();
  thread _id_AA30A0B07502A038(0);
}

_id_42A0806457EA8039(player) {
  if(player.team == self.teams[0])
    return 1;

  return 0;
}

_id_89E2EEF706F41A37(_id_FABF84450735DD93) {
  self._id_32605DB102447D94 setscriptablepartstate("safe", "usable_not_open");

  foreach(player in level.players)
  self._id_32605DB102447D94 disablescriptableplayeruse(player);

  players = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

  foreach(player in players)
  self._id_32605DB102447D94 enablescriptableplayeruse(player);
}

_id_70C697E50D1A348F() {
  _id_AB2BE8088C0A7C90 = [];
  _id_AA9D61F3C51B6A77 = self.tablet.origin;
  _id_FDC6EE1B91EBB7BF = undefined;
  locations = _id_718E51890EBD699A(_id_AA9D61F3C51B6A77);

  if(!isDefined(locations) || locations.size < level._id_D8B853B40A83B85A._id_F7D2D2031214744B)
    return undefined;

  if(!level.br_circle_disabled) {
    _id_527A7B84D978E792 = _id_58F20490049AF6AC::_id_60951B84C58915AB(self.tablet.origin);
    _id_FDC6EE1B91EBB7BF = _id_58F20490049AF6AC::_id_7D8550B9A2C52852(_id_527A7B84D978E792);
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_D8B853B40A83B85A._id_F7D2D2031214744B; _id_AC0E594AC96AA3A8++) {
    _id_1C2F5D2BDB99E23E = undefined;
    _id_385B83E50B8E55E2 = level._id_D8B853B40A83B85A._id_49D9DE2A9CD31CDD;

    foreach(_id_32605DB102447D94 in locations) {
      if(istrue(_id_32605DB102447D94.inuse)) {
        continue;
      }
      dist = distance2d(_id_32605DB102447D94.origin, _id_AA9D61F3C51B6A77);

      if(!level.br_circle_disabled) {
        if(!isDefined(_id_32605DB102447D94._id_E1384FF4A85E24E6))
          _id_32605DB102447D94._id_E1384FF4A85E24E6 = _id_58F20490049AF6AC::_id_60951B84C58915AB(_id_32605DB102447D94.origin);

        _id_28DEB7FF62E281D3 = _id_58F20490049AF6AC::_id_7D8550B9A2C52852(_id_32605DB102447D94._id_E1384FF4A85E24E6);

        if(_id_28DEB7FF62E281D3 < _id_FDC6EE1B91EBB7BF) {
          continue;
        }
        _id_42F65B4B53C1F5D4 = dist / 190;
        _id_28DEB7FF62E281D3 = _id_28DEB7FF62E281D3 - _id_42F65B4B53C1F5D4;

        if(_id_28DEB7FF62E281D3 < level._id_D8B853B40A83B85A._id_C7FABBF8BA74055D)
          continue;
      }

      _id_5435995E95681B89 = 0;

      if(dist < level._id_D8B853B40A83B85A._id_B2193923C0E12A84) {
        if(dist < level._id_D8B853B40A83B85A._id_0A127465B8187AC6)
          _id_5435995E95681B89 = level._id_D8B853B40A83B85A._id_0A127465B8187AC6 - dist;
      } else
        _id_5435995E95681B89 = dist - level._id_D8B853B40A83B85A._id_B2193923C0E12A84;

      if(_id_5435995E95681B89 < _id_385B83E50B8E55E2) {
        if(_id_4948CDF739393D2D::_id_AE011F52B2B15BAF(_id_32605DB102447D94.origin, 0)) {
          continue;
        }
        _id_385B83E50B8E55E2 = _id_5435995E95681B89;
        _id_1C2F5D2BDB99E23E = _id_32605DB102447D94;

        if(_id_5435995E95681B89 <= 0) {
          break;
        }
      }
    }

    if(!isDefined(_id_1C2F5D2BDB99E23E))
      return undefined;

    _id_1C2F5D2BDB99E23E.inuse = 1;
    _id_AB2BE8088C0A7C90[_id_AC0E594AC96AA3A8] = _id_1C2F5D2BDB99E23E;
    _id_AA9D61F3C51B6A77 = _id_1C2F5D2BDB99E23E.origin;
  }

  return _id_AB2BE8088C0A7C90;
}

_id_718E51890EBD699A(origin) {
  _id_45A953583BD24E64 = [];

  if(!isDefined(level._id_D8B853B40A83B85A._id_9DA47341BA68C8BF)) {
    _id_8434484B7956C141 = 0;
    _id_F4AA6C284DC35785 = scripts\engine\utility::getStructArray("dmz_safe", "script_noteworthy");
    _id_AA49A1900CA8984C = scripts\engine\utility::getStructArray("br_safe", "script_noteworthy");
    level._id_D8B853B40A83B85A._id_9DA47341BA68C8BF = scripts\engine\utility::array_combine(_id_F4AA6C284DC35785, _id_AA49A1900CA8984C);

    foreach(_id_32605DB102447D94 in level._id_D8B853B40A83B85A._id_9DA47341BA68C8BF) {
      if(_id_8434484B7956C141 < 5) {
        if(distancesquared(_id_32605DB102447D94.origin, (24447, 27440, 264)) < 100) {
          level._id_D8B853B40A83B85A._id_9DA47341BA68C8BF = scripts\engine\utility::array_remove(level._id_D8B853B40A83B85A._id_9DA47341BA68C8BF, _id_32605DB102447D94);
          _id_8434484B7956C141++;
          continue;
        } else if(distancesquared(_id_32605DB102447D94.origin, (26320, 37909.3, 873.75)) < 100) {
          level._id_D8B853B40A83B85A._id_9DA47341BA68C8BF = scripts\engine\utility::array_remove(level._id_D8B853B40A83B85A._id_9DA47341BA68C8BF, _id_32605DB102447D94);
          _id_8434484B7956C141++;
          continue;
        } else if(distancesquared(_id_32605DB102447D94.origin, (26394, 38091, 682)) < 100) {
          level._id_D8B853B40A83B85A._id_9DA47341BA68C8BF = scripts\engine\utility::array_remove(level._id_D8B853B40A83B85A._id_9DA47341BA68C8BF, _id_32605DB102447D94);
          _id_8434484B7956C141++;
          continue;
        } else if(distancesquared(_id_32605DB102447D94.origin, (27463, 28891, 489)) < 100) {
          level._id_D8B853B40A83B85A._id_9DA47341BA68C8BF = scripts\engine\utility::array_remove(level._id_D8B853B40A83B85A._id_9DA47341BA68C8BF, _id_32605DB102447D94);
          _id_8434484B7956C141++;
          continue;
        } else if(distancesquared(_id_32605DB102447D94.origin, (24314.8, 28874, 398)) < 100) {
          level._id_D8B853B40A83B85A._id_9DA47341BA68C8BF = scripts\engine\utility::array_remove(level._id_D8B853B40A83B85A._id_9DA47341BA68C8BF, _id_32605DB102447D94);
          _id_8434484B7956C141++;
          continue;
        } else
          break;
      }
    }
  }

  foreach(_id_32605DB102447D94 in level._id_D8B853B40A83B85A._id_9DA47341BA68C8BF) {
    if(istrue(_id_32605DB102447D94.inuse)) {
      continue;
    }
    distsq = distance2dsquared(origin, _id_32605DB102447D94.origin);

    if(distsq >= level._id_D8B853B40A83B85A._id_59216A99E6C86D53 && distsq <= level._id_D8B853B40A83B85A._id_FC6C2C380A8177A1)
      _id_45A953583BD24E64[_id_45A953583BD24E64.size] = _id_32605DB102447D94;
  }

  if(_id_45A953583BD24E64.size == 0)
    return undefined;

  return _id_45A953583BD24E64;
}

_id_0AF2FB3745ABD2CC(origin, angles) {
  if(!isDefined(angles))
    angles = (0, 0, 0);

  _id_B66875EAF0848550 = "br_quest_safe";

  if(isDefined(level._id_FFAE696F4EF77D0E))
    _id_B66875EAF0848550 = [[level._id_FFAE696F4EF77D0E]]();

  _id_32605DB102447D94 = spawnscriptable(_id_B66875EAF0848550, origin, angles);
  _id_32605DB102447D94._id_B8EBE3F71A08AB40 = self;
  _id_32605DB102447D94 setscriptablepartstate("safe", "unusable");
  _id_32605DB102447D94.bombplanted = 0;
  _id_32605DB102447D94 scripts\common\utility::_id_57257D1ED9CE2F48(::_id_2217437346021976);
  return _id_32605DB102447D94;
}

_id_2217437346021976() {
  _id_32605DB102447D94 = self;

  if(!istrue(self.opened) && isDefined(_id_32605DB102447D94._id_B8EBE3F71A08AB40))
    _id_32605DB102447D94._id_B8EBE3F71A08AB40 _id_CD0F560FAD2E9CB6(0);

  return 0;
}

_id_F156678B1297CFB2(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(istrue(player _id_362C58E8BB39BCDA::runbrgametypefunc("playerSkipLootPickup", instance))) {
    return;
  }
  _id_B8EBE3F71A08AB40 = instance._id_B8EBE3F71A08AB40;

  if(state == "usable_not_open") {
    if(player.team != _id_B8EBE3F71A08AB40.teams[0]) {
      return;
    }
    instance.bombplanted = 1;

    if(getdvarint("dvar_2BD07E31CFAB5DBF", 1)) {
      _id_90B08876A946FDF5 = anglesToForward(instance.angles);
      _id_1F55514C31C74991 = anglestoleft(instance.angles);
      instance._id_E141356311900568 = spawnStruct();
      instance._id_E141356311900568.origin = instance.origin + _id_90B08876A946FDF5 * 18 + _id_1F55514C31C74991 * 10;
      instance._id_E141356311900568.angles = instance.angles + (0, -70, 0);
    }

    instance thread _id_7DC98F165FE5F59D(player);
  } else if(state == "usable_open") {
    if(!isDefined(instance.contents)) {
      _id_B98ADEEA66F9BBF8 = 1;

      if(isDefined(_id_B8EBE3F71A08AB40))
        _id_B98ADEEA66F9BBF8 = _id_B8EBE3F71A08AB40._id_B98ADEEA66F9BBF8;

      items = getscriptcachecontents("br_quest_safe", level._id_D8B853B40A83B85A._id_CA3BEE0F7088468F);
      level._id_D8B853B40A83B85A._id_CA3BEE0F7088468F = level._id_D8B853B40A83B85A._id_CA3BEE0F7088468F + 1;

      if(level._id_D8B853B40A83B85A._id_CA3BEE0F7088468F >= level._id_D8B853B40A83B85A._id_056AD755924F1363)
        level._id_D8B853B40A83B85A._id_CA3BEE0F7088468F = 0;

      instance._id_46A3A8565AC0C17C = 4;
      instance _id_552B8E4EA5FF7DF1::lootcachespawncontents(items, 1, player, instance.contents);
    } else
      instance _id_552B8E4EA5FF7DF1::lootcachespawncontents(undefined, 1, player, instance.contents);
  }
}

_id_2844B247CE15CFC2(dangericonent) {
  dangericonent endon("death");
  self waittill("death");

  if(isDefined(dangericonent.headiconid))
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(dangericonent.headiconid);

  dangericonent delete();
}

_id_7DC98F165FE5F59D(player) {
  level endon("game_ended");
  self setscriptablepartstate("safe", "unusable");
  dangericonent = player scripts\mp\utility\weapon::_launchgrenade("safe_c4_danger_icon_mp", self.origin, (0, 0, 0), 100, 1);
  dangericonent.weapon_object = makeweapon("safe_c4_danger_icon_mp");

  if(self._id_B8EBE3F71A08AB40._id_B98ADEEA66F9BBF8 == 2)
    self._id_B8EBE3F71A08AB40._id_CFB8550756FFDFAA = 1;

  _id_85E5587B75CFCA4A = vectorNormalize(anglesToForward(self.angles));
  _id_0F3C1B7C658B5AE1 = _id_85E5587B75CFCA4A * 19;
  origin = self.origin + _id_0F3C1B7C658B5AE1 + (0, 0, 30);
  bomb = spawn("script_model", origin);
  bomb.angles = self.angles + (0, -90, 0);
  _id_DB73CA20E2C2FFEC = _id_85E5587B75CFCA4A * 139;
  navobstacle = createnavbadplacebybounds(self.origin + _id_DB73CA20E2C2FFEC, (160, 280, 80), self.angles);
  bomb setModel("offhand_wm_c4_br_safe");
  bomb setscriptablepartstate("effects", "plant");
  bomb thread _id_2844B247CE15CFC2(dangericonent);
  bomb thread _id_F0282E7DBD8851FD(level._id_D8B853B40A83B85A._id_6E8B543291B3BD51);
  wait(level._id_D8B853B40A83B85A._id_6E8B543291B3BD51);
  bomb.angles = self.angles;
  bomb.origin = bomb.origin + _id_0F3C1B7C658B5AE1;
  bomb setscriptablepartstate("effects", "explodeWall");
  wait 0.2;
  thread _id_77A40230D4DD9AF0(player);

  if(isDefined(dangericonent.headiconid))
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(dangericonent.headiconid);

  if(isDefined(dangericonent))
    dangericonent delete();

  bomb hide();

  if(isDefined(navobstacle))
    destroynavobstacle(navobstacle);

  wait 1.8;
  bomb delete();
}

_id_F0282E7DBD8851FD(_id_1A7062CA13AF0FB0) {
  level endon("game_ended");
  self endon("bomb_exploded");
  self endon("bomb_defused");
  self endon("death");
  bomb = self;

  if(soundexists("breach_c4_plant_05"))
    bomb playSound("breach_c4_plant_05");

  _id_8ADAF4318D8A76E4 = int(_id_1A7062CA13AF0FB0);
  _id_D8DA94A475707D63 = _id_1A7062CA13AF0FB0 - _id_8ADAF4318D8A76E4;

  if(_id_D8DA94A475707D63 > 0) {
    wait(_id_D8DA94A475707D63);
    _id_1A7062CA13AF0FB0 = _id_8ADAF4318D8A76E4;
  }

  _id_C351A54729796AE1 = 0.5;
  starttime = gettime();
  endtime = starttime + _id_1A7062CA13AF0FB0 * 1000;
  _id_64F88D0441939203 = starttime;

  while(_id_64F88D0441939203 < endtime) {
    _id_64F88D0441939203 = gettime();
    _id_C301D652D9A73075 = endtime - _id_64F88D0441939203;

    if(_id_C301D652D9A73075 <= 1000 && soundexists("breach_warning_beep_05")) {
      bomb playSound("breach_warning_beep_05");
      _id_C351A54729796AE1 = 0.05;
    } else if(_id_C301D652D9A73075 <= 2000 && soundexists("breach_warning_beep_04")) {
      bomb playSound("breach_warning_beep_04");
      _id_C351A54729796AE1 = 0.25;
    } else if(_id_C301D652D9A73075 <= 3000 && soundexists("breach_warning_beep_03")) {
      bomb playSound("breach_warning_beep_03");
      _id_C351A54729796AE1 = 0.5;
    } else if(_id_C301D652D9A73075 <= 4000 && soundexists("breach_warning_beep_02"))
      bomb playSound("breach_warning_beep_02");
    else if(soundexists("breach_warning_beep_01"))
      bomb playSound("breach_warning_beep_01");

    wait(_id_C351A54729796AE1);
  }
}

_id_77A40230D4DD9AF0(player) {
  _id_B8EBE3F71A08AB40 = self._id_B8EBE3F71A08AB40;
  _id_FABF84450735DD93 = _id_B8EBE3F71A08AB40.teams[0];
  players = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");
  self setscriptablepartstate("safe", "opening");
  self.opened = 1;

  if(getdvarint("dvar_2BD07E31CFAB5DBF", 1)) {
    foreach(player in level.players)
    self disablescriptableplayeruse(player);

    items = getscriptcachecontents("br_quest_safe", level._id_D8B853B40A83B85A._id_CA3BEE0F7088468F);
    level._id_D8B853B40A83B85A._id_CA3BEE0F7088468F = level._id_D8B853B40A83B85A._id_CA3BEE0F7088468F + 1;

    if(level._id_D8B853B40A83B85A._id_CA3BEE0F7088468F >= level._id_D8B853B40A83B85A._id_056AD755924F1363)
      level._id_D8B853B40A83B85A._id_CA3BEE0F7088468F = 0;

    foreach(player in players)
    self disablescriptableplayeruse(player);

    wait 0.8;
    _id_3ACF1C0EBAF602F2::questrewarddropitems(player.team, items, self._id_E141356311900568.origin, self._id_E141356311900568.angles, 1, 3, 50);
  }

  thread _id_885786E5FF464CAA();

  if(isDefined(_id_B8EBE3F71A08AB40)) {
    _id_B8EBE3F71A08AB40._id_B98ADEEA66F9BBF8++;

    if(_id_B8EBE3F71A08AB40._id_B98ADEEA66F9BBF8 < 3) {
      if(_id_B8EBE3F71A08AB40._id_B98ADEEA66F9BBF8 == 2) {
        level thread _id_2CEDCC356F1B9FC8::brleaderdialogteamexcludeplayer("mission_safecrack_safe2", player.team, player, 1, undefined, 2);
        level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("mission_safecrack_safe2_first_person", player, 1, undefined, 2);
      } else if(_id_B8EBE3F71A08AB40._id_B98ADEEA66F9BBF8 == 1) {
        level thread _id_2CEDCC356F1B9FC8::brleaderdialogteamexcludeplayer("mission_safecrack_safe1", player.team, player, 1, undefined, 2);
        level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("mission_safecrack_safe1_first_person", player, 1, undefined, 2);
      }

      _id_64ACB6CE534155B7::displaysquadmessagetoteam(_id_FABF84450735DD93, player, 7, _id_64ACB6CE534155B7::getquestindex("safecracker"));

      if(level._id_D8B853B40A83B85A._id_0597C27BD871980D) {
        time = _id_B8EBE3F71A08AB40 _id_64ACB6CE534155B7::_id_F69C3E487B364F2F(level._id_D8B853B40A83B85A._id_7CA8C9DD069B168F);
        _id_B8EBE3F71A08AB40 _id_64ACB6CE534155B7::_id_5606274C76B4A2DF(time);
      }

      if(!level._id_D8B853B40A83B85A._id_3AAD62E7A6C7F662) {
        _id_64ACB6CE534155B7::displayteamsplash(_id_FABF84450735DD93, "br_safecracker_quest_next_location");
        _id_41EC09AF5A3FB6EC = _id_B8EBE3F71A08AB40._id_5344ABD2BA35D7C2[_id_B8EBE3F71A08AB40._id_B98ADEEA66F9BBF8];
        _id_41EC09AF5A3FB6EC.objectiveiconid = self._id_65F2E31BA81E1B45.objectiveiconid;
        self._id_65F2E31BA81E1B45.objectiveiconid = undefined;
        _id_41EC09AF5A3FB6EC _id_64ACB6CE534155B7::movequestobjicon(_id_41EC09AF5A3FB6EC._id_2A438B0332B8A143.origin);
        _id_41EC09AF5A3FB6EC _id_89E2EEF706F41A37(_id_FABF84450735DD93);
      } else
        self._id_65F2E31BA81E1B45 _id_6BB69599D9063E0F(_id_FABF84450735DD93, 0);
    } else {
      _id_64ACB6CE534155B7::displaysquadmessagetoteam(_id_FABF84450735DD93, player, 8, _id_64ACB6CE534155B7::getquestindex("safecracker"));
      rewards = undefined;

      if(getdvarint("dvar_2BD07E31CFAB5DBF", 1))
        rewards = _id_64ACB6CE534155B7::_id_D212A5E7A40D7C8D("safecracker", _id_FABF84450735DD93, self._id_E141356311900568);
      else
        rewards = _id_64ACB6CE534155B7::_id_D212A5E7A40D7C8D("safecracker", _id_FABF84450735DD93, self);

      if(!_id_2CEDCC356F1B9FC8::istutorial()) {
        if(isDefined(rewards) && isDefined(rewards["plunder"]))
          thread _id_64ACB6CE534155B7::_id_878EBCC241B54505("br_safecracker_quest_complete", _id_64ACB6CE534155B7::_id_3D262D56274BD22E("safecracker"), rewards["plunder"], _id_FABF84450735DD93, 1);

        level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_safecrack_success", _id_FABF84450735DD93, 1, 3.5);
      }

      _id_B8EBE3F71A08AB40 thread _id_AA30A0B07502A038(1, rewards);
    }

    foreach(player in players)
    player _id_64ACB6CE534155B7::uiobjectivesetparameter(_id_B8EBE3F71A08AB40._id_B98ADEEA66F9BBF8);

    _id_B8EBE3F71A08AB40 _id_64ACB6CE534155B7::_id_E2AA45E2C6B5DEC1(_id_B8EBE3F71A08AB40._id_B98ADEEA66F9BBF8);
    _id_96674628376EABA6 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](player.team, 0);

    foreach(_id_F0EA4030349A33D5 in _id_96674628376EABA6)
    _id_F0EA4030349A33D5 notify("calloutmarkerping_warzoneKillQuestIcon");
  }
}

_id_A199D7C38ADEEC99() {
  foreach(_id_65F2E31BA81E1B45 in self._id_5344ABD2BA35D7C2) {
    if(isDefined(_id_65F2E31BA81E1B45._id_32605DB102447D94)) {
      _id_F451F1EFD8B651C8 = _id_65F2E31BA81E1B45._id_32605DB102447D94 getscriptablepartstate("safe");

      if(isDefined(_id_F451F1EFD8B651C8) && _id_F451F1EFD8B651C8 == "usable_not_open")
        _id_65F2E31BA81E1B45._id_32605DB102447D94 _id_9AE7A4649C25E6B2();
    }
  }
}

_id_885786E5FF464CAA() {
  level endon("game_ended");
  wait(level._id_D8B853B40A83B85A._id_0A75DA4F9A75843E);
  _id_9AE7A4649C25E6B2();
}

_id_9AE7A4649C25E6B2() {
  if(isDefined(self._id_65F2E31BA81E1B45) && istrue(self._id_65F2E31BA81E1B45._id_2A438B0332B8A143.inuse))
    self._id_65F2E31BA81E1B45._id_2A438B0332B8A143.inuse = 0;

  if(isDefined(self.entity))
    self.entity delete();

  self freescriptable();
}

_id_CC660B55959B2E7F(_id_AB2BE8088C0A7C90) {
  if(!isDefined(_id_AB2BE8088C0A7C90))
    return 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_D8B853B40A83B85A._id_F7D2D2031214744B; _id_AC0E594AC96AA3A8++) {
    _id_2A438B0332B8A143 = _id_AB2BE8088C0A7C90[_id_AC0E594AC96AA3A8];

    if(!isDefined(_id_2A438B0332B8A143)) {
      _id_AB2BE8088C0A7C90 = undefined;
      return 0;
    }
  }

  return 1;
}

_id_9FFF9366482CEE3B() {
  player = self._id_0D154AC2657C5F44;

  foreach(_id_65F2E31BA81E1B45 in self._id_5344ABD2BA35D7C2) {
    if(!_id_58F20490049AF6AC::_id_77CEC84F05CA9418(_id_65F2E31BA81E1B45._id_2A438B0332B8A143.origin, player.origin))
      return 0;
  }

  return 1;
}

_id_3E354A7F7649493B() {
  if(!isDefined(self._id_5344ABD2BA35D7C2))
    return 0;

  foreach(_id_65F2E31BA81E1B45 in self._id_5344ABD2BA35D7C2) {
    if(_id_4948CDF739393D2D::_id_AE011F52B2B15BAF(_id_65F2E31BA81E1B45._id_2A438B0332B8A143.origin, 0)) {
      foreach(_id_87B4FDFD5BE4AC27 in self._id_5344ABD2BA35D7C2)
      _id_87B4FDFD5BE4AC27._id_2A438B0332B8A143.inuse = 0;

      self._id_5344ABD2BA35D7C2 = undefined;
      _id_A886B05AE9E9E86A = _id_8C64A4F648288A95();

      if(!_id_A886B05AE9E9E86A) {
        self.tablet thread _id_64ACB6CE534155B7::tablethide();
        return 0;
      }
    }
  }

  return 1;
}

_id_37E73A6A4C1AFB18(_id_FABF84450735DD93) {
  _id_64ACB6CE534155B7::createquestobjicon("ui_mp_br_mapmenu_icon_safebreaker_objective", "current", self._id_2A438B0332B8A143.origin + (0, 0, 55));
  objective_removeallfrommask(self.objectiveiconid);
  players = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

  foreach(player in players) {
    if(scripts\mp\utility\player::isreallyalive(player) && !player _id_2CEDCC356F1B9FC8::isplayeringulag())
      objective_addclienttomask(self.objectiveiconid, player);
  }

  objective_setshowdistance(self.objectiveiconid, 0);
  thread _id_A11AEA6569521300();
}

_id_A11AEA6569521300() {
  level endon("game_ended");
  wait(level._id_D8B853B40A83B85A._id_8FE0E04A07E07422);
  objective_setshowdistance(self.objectiveiconid, 1);
}

_id_E8C97D5848BB6AB4(_id_FABF84450735DD93, questcomplete) {
  foreach(_id_65F2E31BA81E1B45 in self._id_5344ABD2BA35D7C2)
  _id_65F2E31BA81E1B45 _id_6BB69599D9063E0F(_id_FABF84450735DD93, questcomplete);
}

_id_6BB69599D9063E0F(_id_FABF84450735DD93, _id_C3CD5D44C5030861) {
  if(isDefined(self.objectiveiconid)) {
    foreach(player in scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players"))
    _id_7087E66B57D92A78(player, _id_C3CD5D44C5030861);

    _id_64ACB6CE534155B7::deletequestobjicon();
    self.objectiveiconid = undefined;
  }
}

_id_7087E66B57D92A78(player, _id_C3CD5D44C5030861) {
  _id_64ACB6CE534155B7::hidequestobjiconfromplayer(player);

  if(istrue(_id_C3CD5D44C5030861))
    player _id_64ACB6CE534155B7::uiobjectivehide();
}

_id_738B34CE3EB8143E(player) {
  foreach(_id_65F2E31BA81E1B45 in self._id_5344ABD2BA35D7C2) {
    if(isDefined(_id_65F2E31BA81E1B45.objectiveiconid))
      _id_65F2E31BA81E1B45 _id_64ACB6CE534155B7::hidequestobjiconfromplayer(player);
  }
}

_id_EAB871A28AE5F349(player) {
  foreach(_id_65F2E31BA81E1B45 in self._id_5344ABD2BA35D7C2) {
    if(isDefined(_id_65F2E31BA81E1B45.objectiveiconid))
      _id_65F2E31BA81E1B45 _id_64ACB6CE534155B7::showquestobjicontoplayer(player);
  }
}