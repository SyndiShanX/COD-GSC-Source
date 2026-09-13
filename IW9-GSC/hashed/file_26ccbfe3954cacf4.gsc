/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_26ccbfe3954cacf4.gsc
***********************************************/

initialize(_id_9F4A3632D9F75D32) {
  if(!_id_E60552DD6ABCC4AA()) {
    return;
  }
  level._id_7B37B2193F163B9B = spawnStruct();
  level._id_7B37B2193F163B9B._id_892FA74A6B549EF0 = [];
  level._id_7B37B2193F163B9B._id_156F390A5362BC55 = [];
  level._id_7B37B2193F163B9B._id_9F4A3632D9F75D32 = _id_9F4A3632D9F75D32;
  thread _id_9D31B1338E2F80E8();
  thread _id_821A6FDD1D60D2AF();
  thread _id_C9B0122DE1017D85();
  thread _id_494150569261C828();

  if(istrue(level.usegulag))
    thread _id_5B2B7905D2D6B349();

  if(_id_A0E0C0E1E94630F6())
    thread _id_C596173D88D8446E();

  _id_44F4640B93AB1B47::_id_0360128EC8C9D243();

  if(getdvarint("dvar_429176496A1B2FD8", 0))
    thread _id_A93242F2E58447B3();
}

_id_E60552DD6ABCC4AA() {
  if(getDvar("dvar_12E53040D5281856", "") == "scripted")
    return 0;

  return getdvarint("dvar_B7FCB658021D7931", 1) == 1;
}

onplayerconnect(player) {
  if(isDefined(player._id_5876CD9FC14AF731) && isDefined(player._id_5876CD9FC14AF731.clientmatchdataid))
    player.clientmatchdataid = player._id_5876CD9FC14AF731.clientmatchdataid;
}

onplayerdisconnect(player) {
  if(isDefined(player._id_0B8E75E4315698CD)) {
    player._id_0B8E75E4315698CD.clientmatchdataid = player.clientmatchdataid;
    player._id_0B8E75E4315698CD = undefined;
  }
}

isteameliminated(team) {
  _id_BCE4EFC75EB01319 = scripts\mp\utility\teams::getteamdata(team, "aliveCount");

  if(_id_BCE4EFC75EB01319 > 0)
    return 0;

  return _id_1E4A61DB11011446::_id_227CA42A35B0398B(team);
}

_id_A93242F2E58447B3() {
  level endon("game_ended");

  if(level.br_infils_disabled)
    level waittill("spawned_bots");
  else
    level waittill("br_circle_set");

  for(;;) {
    logstring("[DumpBots] start");
    _id_E1E65E11F75F9CBB = level._id_7B37B2193F163B9B._id_156F390A5362BC55.size;
    _id_B11BEC30763A97F8 = 0;
    _id_D507B1DD6759FF83 = 0;
    _id_A4C3A5AFE5B8DA9B = [];
    _id_6B7BEE46F2C6DA28 = gettime();

    foreach(player in level.players) {
      if(!isDefined(player) || player _id_40E63DD222434655::_id_A9CBF557DC66D201()) {
        continue;
      }
      if(player _id_6ECC7CD453466014()) {
        continue;
      }
      _id_A4C3A5AFE5B8DA9B[player.team] = 1;

      if(isbot(player)) {
        _id_B11BEC30763A97F8++;
        continue;
      }

      _id_D507B1DD6759FF83++;
    }

    _id_BCE4EFC75EB01319 = _id_B11BEC30763A97F8 + _id_D507B1DD6759FF83;
    logstring("Time:" + _id_6B7BEE46F2C6DA28 + ", TotalPlayers:" + (_id_BCE4EFC75EB01319 + _id_E1E65E11F75F9CBB) + ", AliveHumans:" + _id_D507B1DD6759FF83 + ", AliveBots:" + (_id_B11BEC30763A97F8 + _id_E1E65E11F75F9CBB) + ", UIBots:" + _id_E1E65E11F75F9CBB);

    if(isDefined(level.br_circle) && isDefined(level.br_circle.dangercircleent))
      logstring("Circle:" + level.br_circle.circleindex + " origin:" + level.br_circle.dangercircleent.origin);

    logstring("IsGulagShutDown:" + _id_1E4A61DB11011446::_id_72CE5F47DA0F5661());

    if(level._id_7B37B2193F163B9B._id_156F390A5362BC55.size > 0) {
      logstring("[DumpUIBots] start");

      foreach(bot in level._id_7B37B2193F163B9B._id_156F390A5362BC55) {
        logstring("[Dump UIBot] name:" + bot.name + " locked:" + bot.locked + " team:" + bot.team);
        _id_4C9BD9A3BF3F8CF7::_id_B3BB8F282B894DAD(bot.team);
      }

      logstring("[DumpUIBots] end");
    }

    logstring("[DumpActiveTeams] start");

    foreach(team, v in _id_A4C3A5AFE5B8DA9B) {
      logstring("team:" + team);
      players = scripts\mp\utility\teams::getteamdata(team, "alivePlayers");

      foreach(player in players) {
        speed = length(player getvelocity());
        status = scripts\engine\utility::ter_op(isbot(player) && isDefined(player.status), player.status, "");
        logstring("[Dump player] name:" + player.name + " origin:" + player.origin + " health:" + player.health + " speed:" + speed + " status:" + status);

        if(isbot(player)) {
          if(!isDefined(player._id_DABF4CF09B2C06CA) || distancesquared(player.origin, player._id_DABF4CF09B2C06CA) > 10)
            player._id_B012001B3448E7C7 = _id_6B7BEE46F2C6DA28;

          player._id_DABF4CF09B2C06CA = player.origin;

          if(isDefined(player._id_B012001B3448E7C7) && _id_6B7BEE46F2C6DA28 - player._id_B012001B3448E7C7 > 10000)
            logstring("[Dump player] STUCKED!!! lastTimeHaveMove:" + (player._id_B012001B3448E7C7 - level.starttime) + " stuck time:" + (_id_6B7BEE46F2C6DA28 - player._id_B012001B3448E7C7));
        }
      }
    }

    logstring("[DumpActiveTeams] end");
    level scripts\engine\utility::waittill_any_in_array_or_timeout(["ui_bot_counter_updated", "updatePlayerAndTeamCountUI"], 1);
  }
}

_id_5B2B7905D2D6B349() {
  level endon("game_ended");

  if(level.br_infils_disabled)
    level waittill("spawned_bots");
  else
    level waittill("br_circle_set");

  timeout = getdvarint("dvar_5D346678D4FB1795", 30000);

  while(getdvarint("scr_br_gulag", 1) && !_id_1E4A61DB11011446::_id_72CE5F47DA0F5661()) {
    if(level._id_7B37B2193F163B9B._id_156F390A5362BC55.size == 0) {
      wait 1;
      continue;
    }

    player = _id_BAAA373E746B0672();

    if(isDefined(player)) {
      if(gettime() - player.jailtime > timeout) {
        _id_CD5428D556223258 = player _id_7C6F438B4F3922CB();
        _id_4C9BD9A3BF3F8CF7::_id_966AB6FFD873EC11(1, 1, "DeployUIBotIntoGulag", _id_CD5428D556223258);
      }
    }

    wait 1;
  }
}

_id_BAAA373E746B0672() {
  targetplayer = undefined;
  _id_1001A564E09EA44A = undefined;

  foreach(arena in level.gulag.arenas) {
    foreach(_id_AA9F4C033D62BC8A in arena.matches) {
      if(_id_AA9F4C033D62BC8A.size != 1) {
        continue;
      }
      player = _id_AA9F4C033D62BC8A[0];

      if(!isDefined(player) || isbot(player)) {
        continue;
      }
      if(!isDefined(_id_1001A564E09EA44A) || player.jailtime < _id_1001A564E09EA44A) {
        _id_1001A564E09EA44A = player.jailtime;
        targetplayer = player;
      }
    }
  }

  return targetplayer;
}

_id_7C6F438B4F3922CB() {
  if(!isDefined(self.arena))
    return undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.gulag.arenas.size; _id_AC0E594AC96AA3A8++) {
    if(level.gulag.arenas[_id_AC0E594AC96AA3A8] == self.arena)
      return _id_AC0E594AC96AA3A8;
  }

  return undefined;
}

_id_64432AF189B8A177(_id_1A645E724209AC4A, _id_2BA509F4D1261BA7) {
  if(!_id_5972C32461575E59())
    return 0;

  _id_CC9D656EFB786A8B = undefined;
  _id_C2AD339C4E95C7FE = undefined;

  switch (_id_1A645E724209AC4A) {
    case 0:
      _id_D0EB1456103AB1E3 = getdvarint("dvar_81156FDDEB6B5508", 5900);
      _id_72FDE5447014F573 = _id_D0EB1456103AB1E3 * _id_D0EB1456103AB1E3;
      height = getdvarint("dvar_B51792A54D2CC6DF", 5900);

      if(_id_2E6A95DFE7DFC5F8::_id_B2502F3345564ABF(_id_72FDE5447014F573, height, 0) && !_id_0190FB7E79CAD0D0()) {
        _id_CC9D656EFB786A8B = 0;
        _id_C2AD339C4E95C7FE = "landing position meets the range [2D dist = " + _id_D0EB1456103AB1E3 + ", height = " + height + "] and not witnessed";
        _id_2E6A95DFE7DFC5F8::_id_89B861AA78808ED8();
      }

      break;
    case 1:
      if(_id_5CB1C8EC264FBDBD(self) == 0) {
        _id_CC9D656EFB786A8B = 1;
        _id_C2AD339C4E95C7FE = "prematch active player count limit";
      }

      break;
    case 2:
      if(_id_DC1089B7B817790E() < 0) {
        _id_CC9D656EFB786A8B = 1;
        _id_C2AD339C4E95C7FE = "infil active bot count limit";
      }

      break;
    case 3:
      if(!_id_40E63DD222434655::_id_16A5388D4963E316() && !_id_0190FB7E79CAD0D0()) {
        if(!_id_4C9BD9A3BF3F8CF7::_id_B2502F3345564ABF()) {
          self dodamage(self.health + 10000, self.origin, self);
          return 0;
        } else {
          _id_CC9D656EFB786A8B = 1;
          _id_C2AD339C4E95C7FE = "parachute stuck at " + self.origin;
        }
      }

      break;
    case 4:
      if(!_id_40E63DD222434655::_id_16A5388D4963E316() && !_id_0190FB7E79CAD0D0()) {
        if(!_id_4C9BD9A3BF3F8CF7::_id_B2502F3345564ABF()) {
          self dodamage(self.health + 10000, self.origin, self);
          return 0;
        } else {
          _id_CC9D656EFB786A8B = 1;
          _id_C2AD339C4E95C7FE = "off_navmesh and not witnessed.";
        }
      }

      break;
    default:
      break;
  }

  if(isDefined(_id_CC9D656EFB786A8B) && !_id_40E63DD222434655::_id_5F352FB76C54705C()) {
    if(_id_2BA509F4D1261BA7)
      _id_40E63DD222434655::_id_0532C9AA14C794FF(_id_40E63DD222434655::_id_3032314D524A3487());

    if(_id_CC9D656EFB786A8B)
      return _id_4C9BD9A3BF3F8CF7::_id_0D3638CF9A2DA76A(_id_C2AD339C4E95C7FE);
    else
      return _id_2E6A95DFE7DFC5F8::_id_0D3638CF9A2DA76A(_id_C2AD339C4E95C7FE);
  } else
    return 0;
}

_id_5972C32461575E59() {
  return isDefined(level._id_7B37B2193F163B9B);
}

_id_D012729EAC1E7053() {
  return isDefined(self._id_B4ADDE4C68BB0F24) && istrue(self._id_B4ADDE4C68BB0F24._id_D012729EAC1E7053);
}

_id_6ECC7CD453466014() {
  return isDefined(self._id_B4ADDE4C68BB0F24) && (istrue(self._id_B4ADDE4C68BB0F24._id_6ECC7CD453466014) || istrue(self._id_B4ADDE4C68BB0F24._id_7DBB8165D792B06C));
}

_id_3AE9C05025CBAC2D() {
  return isDefined(self._id_B4ADDE4C68BB0F24) && istrue(self._id_B4ADDE4C68BB0F24._id_7DBB8165D792B06C);
}

_id_0190FB7E79CAD0D0() {
  _id_721982228624D657 = _id_6489FCDFE6FA2E36::getspectatorsofplayer(self);
  return _id_721982228624D657.size > 0;
}

_id_749723C2A45A0233() {
  if(_id_5972C32461575E59())
    return level._id_7B37B2193F163B9B._id_156F390A5362BC55;
  else
    return [];
}

_id_1BBD21D289BA8A92() {
  if(_id_5972C32461575E59())
    return level._id_7B37B2193F163B9B._id_156F390A5362BC55.size;
  else
    return 0;
}

_id_9D31B1338E2F80E8() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);

    if(isDefined(player)) {
      if(isbot(player)) {
        if(!isDefined(player._id_B4ADDE4C68BB0F24))
          player._id_B4ADDE4C68BB0F24 = spawnStruct();

        player thread _id_2E6A95DFE7DFC5F8::_id_A955D908F57B75CF();
        continue;
      }

      player._id_44F4FB2FDD683FFA = spawnStruct();
    }
  }
}

_id_821A6FDD1D60D2AF() {
  level endon("game_ended");
  level childthread _id_BCEF157DFCF2C5F3();
  level childthread _id_1E0804E806447A25();
}

_id_BCEF157DFCF2C5F3() {
  if(istrue(level.skipprematch)) {
    return;
  }
  level waittill("player_spawned");

  while(scripts\mp\gamelogic::_id_1147BBC93EA9B83C()) {
    _id_9FA0DDC57B0F35B0 = _id_5CB1C8EC264FBDBD();
    _id_4C9BD9A3BF3F8CF7::_id_E81D83CFE1AB45FC(_id_9FA0DDC57B0F35B0, "Skydive", "SpawnInPrematch");
    wait 1;
  }

  _id_E88F02AC1F526A32 = _id_DC1089B7B817790E();

  if(_id_E88F02AC1F526A32 < 0) {
    foreach(player in level.players) {
      if(isbot(player) && !player _id_6ECC7CD453466014()) {
        success = player _id_4C9BD9A3BF3F8CF7::_id_0D3638CF9A2DA76A("infil active bot count limit");

        if(success) {
          _id_E88F02AC1F526A32++;

          if(_id_E88F02AC1F526A32 == 0) {
            break;
          }
        }
      }
    }
  } else if(_id_E88F02AC1F526A32 > 0) {
    level waittill("br_c130_in_bounds");
    _id_4C9BD9A3BF3F8CF7::_id_33227166F85D1AEA(_id_E88F02AC1F526A32, "Skydive", "ActivateUIBotsAfterPrematch");
  }
}

_id_5CB1C8EC264FBDBD(_id_F5720CAC60CA8410) {
  _id_4F705E7659D183F9 = 0;

  foreach(player in level.players) {
    if(isDefined(player) && (!isDefined(_id_F5720CAC60CA8410) || _id_F5720CAC60CA8410 != player)) {
      if(!isbot(player) || !player _id_6ECC7CD453466014())
        _id_4F705E7659D183F9++;
    }
  }

  _id_9FA0DDC57B0F35B0 = _id_D6D3F0E8A701880F() - _id_4F705E7659D183F9;

  if(_id_9FA0DDC57B0F35B0 < 0)
    _id_9FA0DDC57B0F35B0 = 0;

  return _id_9FA0DDC57B0F35B0;
}

_id_D6D3F0E8A701880F() {
  return getdvarint("dvar_E82992EEC48CF830", 20);
}

_id_DC1089B7B817790E() {
  _id_1E9700821627AB11 = _id_1B34E035241A60E7();
  _id_1745F9FF57437BE9 = int(_id_1E9700821627AB11 * clamp(getdvarfloat("dvar_A9691C347E9BB21C", 1), 0, 1));
  return _id_1745F9FF57437BE9 - (_id_1E9700821627AB11 - level._id_7B37B2193F163B9B._id_156F390A5362BC55.size);
}

_id_1B34E035241A60E7() {
  if(!scripts\mp\utility\game::matchmakinggame())
    return getdvarint("dvar_116700C9B39C1EBA", 0);
  else {
    _id_F4343E072926C2F9 = 0;
    _id_786F842D5771CDB6 = _func_538E92208B641725();

    foreach(_id_E72DFDB2A9343F1B in _id_786F842D5771CDB6) {
      if(_id_E72DFDB2A9343F1B.isai)
        _id_F4343E072926C2F9++;
    }

    return _id_F4343E072926C2F9;
  }
}

_id_1E0804E806447A25() {
  if(istrue(level.br_infils_disabled))
    level waittill("player_spawned");
  else
    level waittill("br_c130_left_bounds");

  _id_865C2DBD684C82CD = getdvarint("dvar_E7E9BB130C1CA431", 0);

  if(_id_865C2DBD684C82CD)
    thread _id_E89EAA436FFAD5A4();

  _id_C5452D63F815C7E9 = 1;

  for(;;) {
    _id_8BAA6CFD8698560C = 0;
    _id_AFDC93E504789C3D = 0;
    _id_797045BA3477AEE8 = [];

    foreach(player in level.players) {
      if(!isDefined(player) || isbot(player)) {
        continue;
      }
      _id_8BAA6CFD8698560C = 1;

      if(player _id_40E63DD222434655::_id_A9CBF557DC66D201()) {
        continue;
      }
      _id_AFDC93E504789C3D = 1;
      _id_8DFB4C8E7302515E = player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag() || !_id_59FF79D681BB860C::_id_DED80385EA7471DB(player) || player isskydiving() || player isparachuting();

      if(_id_8DFB4C8E7302515E) {
        continue;
      }
      _id_797045BA3477AEE8[_id_797045BA3477AEE8.size] = player;
    }

    _id_740F3E695765220F = _id_8BAA6CFD8698560C && !_id_AFDC93E504789C3D;

    if(_id_740F3E695765220F) {
      level._id_7B37B2193F163B9B._id_B871280CBDC11CAF = 1;
      thread _id_E79F454A81696E11("noHumanAliveButSpectating");
      level notify("no_human_alive");
      break;
    }

    if(_id_797045BA3477AEE8.size > 0) {
      _id_6F45C47A2030379D = "ui_bots_deployed";
      level thread _id_05982992426CF092(_id_797045BA3477AEE8, _id_C5452D63F815C7E9, _id_6F45C47A2030379D);
      level waittill(_id_6F45C47A2030379D);
    }

    wait(_id_C5452D63F815C7E9);
  }
}

_id_05982992426CF092(_id_99E8FCB28E160694, _id_C5452D63F815C7E9, _id_00DFC67EAAF62BC0) {
  foreach(player in _id_99E8FCB28E160694) {
    _id_44F4FB2FDD683FFA = player._id_44F4FB2FDD683FFA;

    if(_id_7A5B6228C3FE75F6())
      _id_755CF06AFB953275 = 1;
    else {
      _id_5BC7CBBCF589F547 = player _id_40E63DD222434655::_id_A0FBE39135AB0D35();
      _id_AE5632495DFCA986 = gettime() - _id_5BC7CBBCF589F547;

      if(!isDefined(_id_44F4FB2FDD683FFA._id_96BE2FBD0AC6A848))
        _id_44F4FB2FDD683FFA._id_96BE2FBD0AC6A848 = 0;

      if(!isDefined(_id_44F4FB2FDD683FFA._id_5BC7CBBCF589F547))
        _id_44F4FB2FDD683FFA._id_5BC7CBBCF589F547 = 0;

      if(_id_44F4FB2FDD683FFA._id_5BC7CBBCF589F547 != _id_5BC7CBBCF589F547) {
        _id_44F4FB2FDD683FFA._id_96BE2FBD0AC6A848 = 0;
        _id_44F4FB2FDD683FFA._id_5BC7CBBCF589F547 = _id_5BC7CBBCF589F547;
      }

      velocity = player getvelocity();
      speed = length(velocity);

      if(speed < getdvarint("dvar_3D8CE2C99AA4DB2B", 1) && _id_AE5632495DFCA986 > 0) {
        _id_2180ADC7CD6CB25A = getdvarint("dvar_9BE4E2FBBFE8D9C5", 500);
        _id_44F4FB2FDD683FFA._id_96BE2FBD0AC6A848 = _id_44F4FB2FDD683FFA._id_96BE2FBD0AC6A848 + _id_2180ADC7CD6CB25A * _id_C5452D63F815C7E9;
      }

      _id_0B8BBA9CCD960781 = getdvarint("dvar_E32340E297EFBBDD", 45000);
      _id_755CF06AFB953275 = _id_AE5632495DFCA986 >= _id_0B8BBA9CCD960781 + _id_44F4FB2FDD683FFA._id_96BE2FBD0AC6A848;
    }

    if(_id_755CF06AFB953275) {
      _id_44F4FB2FDD683FFA._id_96BE2FBD0AC6A848 = 0;
      player thread _id_4C9BD9A3BF3F8CF7::_id_947B37D99674B59C();
    }
  }

  level _id_59FF79D681BB860C::_id_C73FFCC4D5A2BC9C(_id_00DFC67EAAF62BC0);
}

_id_7A5B6228C3FE75F6() {
  return _id_1E4A61DB11011446::_id_72CE5F47DA0F5661() || _id_B4855C4A6654B47B() || _id_00989977C2EE260D();
}

_id_B4855C4A6654B47B() {
  return isDefined(level.brgametype._id_C42E40EC22A1F0D4) && !level.brgametype._id_C42E40EC22A1F0D4;
}

_id_00989977C2EE260D() {
  return isDefined(level.br_alt_mode_inflation) && istrue(level.br_alt_mode_inflation.disabled);
}

_id_E79F454A81696E11(_id_401C3A2E68AAB0FD) {
  level endon("game_ended");
  logstring("[Super Bots] DeployAllUIBotsThread start");
  _id_72AF5A878A9D3397::_id_8303A56B1EE268B2("begin", _id_401C3A2E68AAB0FD, level._id_7B37B2193F163B9B._id_156F390A5362BC55.size);

  while(level._id_7B37B2193F163B9B._id_156F390A5362BC55.size > 0) {
    count = level._id_7B37B2193F163B9B._id_156F390A5362BC55.size;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < count; _id_AC0E594AC96AA3A8++) {
      _id_89A675C5BDE8848F = _id_4C9BD9A3BF3F8CF7::_id_32EC26AB4915F882();

      if(!isDefined(_id_89A675C5BDE8848F)) {
        break;
      }

      bot = _id_89A675C5BDE8848F _id_4C9BD9A3BF3F8CF7::_id_7CAE93055DAE77EC("Combat", _id_401C3A2E68AAB0FD);

      if(isDefined(bot)) {
        streamtimeout = getdvarint("dvar_A022906BE1321BB1", 2);
        _id_F1F1BC7727CA599B = bot _id_3904CFFF5CE7FDCB::_id_034FFA859CF805CB(0, streamtimeout);
        _id_72AF5A878A9D3397::_id_6B1CA7FAEB9FD14A(bot, bot.origin, _id_F1F1BC7727CA599B, _id_401C3A2E68AAB0FD);
        bot setOrigin(_id_F1F1BC7727CA599B, 1);
        bot _meth_D7BF524EB1822214(0);
      }
    }

    wait 1;
  }

  _id_72AF5A878A9D3397::_id_8303A56B1EE268B2("end", _id_401C3A2E68AAB0FD);
  logstring("[Super Bots] DeployAllUIBotsThread end");
}

_id_C9B0122DE1017D85() {
  level endon("game_ended");

  for(;;) {
    msg = level scripts\engine\utility::waittill_any_in_array_return(["ui_bot_counter_updated", "updatePlayerAndTeamCountUI"]);

    if(msg == "updatePlayerAndTeamCountUI") {
      level._id_7B37B2193F163B9B._id_892FA74A6B549EF0 = scripts\engine\utility::array_removeundefined(level._id_7B37B2193F163B9B._id_892FA74A6B549EF0);
      level._id_7B37B2193F163B9B._id_156F390A5362BC55 = scripts\engine\utility::array_removeundefined(level._id_7B37B2193F163B9B._id_156F390A5362BC55);
    }

    _id_A892D044D30522DA();
  }
}

_id_A892D044D30522DA() {
  if(getdvarint("dvar_A2D26B607A32E157", 0) == 1) {
    _id_7246A3F648408E11 = level._id_7B37B2193F163B9B._id_892FA74A6B549EF0.size;
    _id_D89E89E64B8A8E94 = level._id_7B37B2193F163B9B._id_156F390A5362BC55.size;
    _id_4ABF63AEDDF72469 = 0;
    _id_28424573CF3F8F98 = 0;
    _id_BA0722E02A3ACDF1 = 0;

    foreach(player in level.players) {
      if(isbot(player)) {
        if(!player _id_40E63DD222434655::_id_A9CBF557DC66D201() && !player _id_6ECC7CD453466014()) {
          if(player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag())
            _id_28424573CF3F8F98++;
          else
            _id_4ABF63AEDDF72469++;
        }

        continue;
      }

      if(_id_40E63DD222434655::_id_40034C2FAF09A87B())
        _id_BA0722E02A3ACDF1++;
    }

    _id_92A9BA49002E7180 = _id_4ABF63AEDDF72469 - _id_7246A3F648408E11;
    _id_047BF15E70EE220A = (_id_D89E89E64B8A8E94 << 24) + (_id_7246A3F648408E11 << 16) + (_id_92A9BA49002E7180 << 8) + _id_BA0722E02A3ACDF1;
    setomnvar("ui_br_matchinfo_bot_stats", _id_047BF15E70EE220A);
    setomnvar("ui_br_matchinfo_bot_gulag_stats", _id_28424573CF3F8F98);
  } else {
    setomnvar("ui_br_matchinfo_bot_stats", 0);
    setomnvar("ui_br_matchinfo_bot_gulag_stats", 0);
  }
}

_id_494150569261C828() {
  level endon("game_ended");

  if(istrue(level.br_infils_disabled))
    level waittill("player_spawned");
  else
    level waittill("br_c130_left_bounds");

  _id_60EF63D165685620 = 1.15;
  _id_60EF66D165685CB9 = 1.2;

  for(;;) {
    interval = getdvarint("dvar_E0EC70C334CF532A", 30);
    point = _id_0F7D87293D8DDA36();

    if(isDefined(point) && point[1] > 0) {
      _id_8B49E0C7718E511C = _id_49ED1ADAD9307CE5();
      _id_37749FA4A24BFE71 = _id_8B49E0C7718E511C / point[1];

      if(_id_37749FA4A24BFE71 > _id_60EF63D165685620)
        interval = clamp(pow(1 / (_id_37749FA4A24BFE71 - _id_60EF63D165685620), _id_60EF66D165685CB9), 1, interval);
    }

    msg = level scripts\engine\utility::waittill_any_in_array_or_timeout(["player_killed"], interval);

    if(msg == "player_killed") {
      continue;
    }
    _id_78C6F95A3C5B0462 = level._id_7B37B2193F163B9B._id_892FA74A6B549EF0.size;

    if(_id_78C6F95A3C5B0462 != 0) {
      _id_629C48F843740B97 = undefined;

      for(index = 0; index < _id_78C6F95A3C5B0462; index++) {
        _id_9D90FC100C035523 = level._id_7B37B2193F163B9B._id_892FA74A6B549EF0[index];

        if(!_id_9D90FC100C035523 _id_40E63DD222434655::_id_16A5388D4963E316()) {
          _id_629C48F843740B97 = _id_9D90FC100C035523;
          break;
        }
      }

      if(isDefined(_id_629C48F843740B97)) {
        _id_629C48F843740B97 _id_2E6A95DFE7DFC5F8::_id_7CAE93055DAE77EC();
        _id_629C48F843740B97 dodamage(_id_629C48F843740B97.health + 10000, _id_629C48F843740B97.origin, _id_629C48F843740B97);
      }
    }
  }
}

_id_49ED1ADAD9307CE5(_id_B12D06A2613EF1A1) {
  count = 0;

  foreach(player in level.players) {
    if(isPlayer(player) && !player _id_40E63DD222434655::_id_A9CBF557DC66D201() && !player _id_6ECC7CD453466014())
      count++;
  }

  if(!istrue(_id_B12D06A2613EF1A1))
    count = count + _id_1BBD21D289BA8A92();

  return count;
}

_id_A0E0C0E1E94630F6() {
  _id_00CEBA6EC7E8CA50 = "mp/br_bot_survival_curve.csv";
  _id_9E93F969D16D924B = getdvarint("party_maxplayers", 150);
  _id_CB2737353AD087DA = tableexists(_id_00CEBA6EC7E8CA50);
  level._id_DE1B021064D0F5BB = spawnStruct();
  level._id_DE1B021064D0F5BB.points = [];

  if(_id_CB2737353AD087DA && isDefined(level.br_level) && isDefined(level.br_level.br_circledelaytimes)) {
    _id_67BA7C3C6B03A843 = 0;

    for(circleindex = 0; circleindex < level.br_level.br_circleclosetimes.size - level.br_level.br_movingcirclecount; circleindex++) {
      _id_67BA7C3C6B03A843 = _id_67BA7C3C6B03A843 + level.br_level.br_circleclosetimes[circleindex];
      _id_67BA7C3C6B03A843 = _id_67BA7C3C6B03A843 + level.br_level.br_circledelaytimes[circleindex];
    }

    points = [];
    mapname = getDvar("g_mapname");
    _id_678958B6C61E482B = 0;
    _id_09DD5D9E57E7E36D = tablelookupgetnumrows(_id_00CEBA6EC7E8CA50);

    for(_id_CB89110314447B2F = 0; _id_CB89110314447B2F < _id_09DD5D9E57E7E36D; _id_CB89110314447B2F++) {
      name = tablelookupbyrow(_id_00CEBA6EC7E8CA50, _id_CB89110314447B2F, 0);
      gametype = tablelookupbyrow(_id_00CEBA6EC7E8CA50, _id_CB89110314447B2F, 1);
      _id_9A7CC3CF1CC979D2 = int(tablelookupbyrow(_id_00CEBA6EC7E8CA50, _id_CB89110314447B2F, 2));
      _id_D537A29A9F9B1B07 = getdvarint("dvar_730801902929CF2A", 0);

      if(name == mapname && scripts\mp\utility\game::getsubgametype() == gametype && _id_9A7CC3CF1CC979D2 == _id_D537A29A9F9B1B07) {
        _id_678958B6C61E482B = 1;
        progress = int(tablelookupbyrow(_id_00CEBA6EC7E8CA50, _id_CB89110314447B2F, 3));
        _id_37749FA4A24BFE71 = int(tablelookupbyrow(_id_00CEBA6EC7E8CA50, _id_CB89110314447B2F, 4)) / 100;
        _id_71EA6E5E5CC30C2F = int(tablelookupbyrow(_id_00CEBA6EC7E8CA50, _id_CB89110314447B2F, 5)) / 100;
        threshold = int(tablelookupbyrow(_id_00CEBA6EC7E8CA50, _id_CB89110314447B2F, 6));
        points[points.size] = (int(float(_id_67BA7C3C6B03A843) * progress / 100), int(_id_37749FA4A24BFE71 * _id_9E93F969D16D924B), int(_id_71EA6E5E5CC30C2F * _id_9E93F969D16D924B) * 100 + threshold);
        continue;
      }

      if(_id_678958B6C61E482B) {
        break;
      }
    }

    if(points.size > 0) {
      level._id_DE1B021064D0F5BB.points = points;
      return 1;
    }
  }

  return 0;
}

_id_E3B7C7A52E05AC10(point) {
  if(isDefined(point))
    return int(int(point[2]) / 100);

  return undefined;
}

_id_94F7FCF9188A0A81(point) {
  if(isDefined(point))
    return int(int(point[2]) % 100);

  return undefined;
}

_id_0F7D87293D8DDA36() {
  if(!isDefined(level.br_circle) || !isDefined(level.br_circle._id_5B8569581E64D55A) || !isDefined(level._id_DE1B021064D0F5BB) || !isDefined(level._id_DE1B021064D0F5BB.points) || level._id_DE1B021064D0F5BB.points.size <= 0)
    return undefined;

  _id_027A51444298629D = (gettime() - level.br_circle._id_5B8569581E64D55A) / 1000.0;
  point = undefined;

  for(_id_AC0E594AC96AA3A8 = level._id_DE1B021064D0F5BB._id_9A6BA9F5A0E705C7; _id_AC0E594AC96AA3A8 < level._id_DE1B021064D0F5BB.points.size; _id_AC0E594AC96AA3A8++) {
    if(_id_027A51444298629D < level._id_DE1B021064D0F5BB.points[_id_AC0E594AC96AA3A8][0]) {
      point = level._id_DE1B021064D0F5BB.points[_id_AC0E594AC96AA3A8];
      level._id_DE1B021064D0F5BB._id_9A6BA9F5A0E705C7 = _id_AC0E594AC96AA3A8;
      break;
    }
  }

  if(!isDefined(point))
    level._id_DE1B021064D0F5BB._id_9A6BA9F5A0E705C7 = level._id_DE1B021064D0F5BB.points.size;

  return point;
}

_id_C596173D88D8446E() {
  level endon("game_ended");
  level._id_DE1B021064D0F5BB._id_9A6BA9F5A0E705C7 = 0;

  if(level.br_infils_disabled)
    level waittill("spawned_bots");
  else
    level waittill("br_c130_left_bounds");

  for(;;) {
    _id_027A51444298629D = (gettime() - level.br_circle._id_5B8569581E64D55A) / 1000.0;
    point = _id_0F7D87293D8DDA36();

    if(!isDefined(point)) {
      break;
    }

    _id_A36B089919C77AA6 = point[0] - _id_027A51444298629D;
    _id_8B49E0C7718E511C = _id_49ED1ADAD9307CE5();
    _id_0A22A5A2E074A564 = _id_8B49E0C7718E511C - point[1];

    if(_id_0A22A5A2E074A564 < 1) {
      wait(_id_A36B089919C77AA6);
      continue;
    }

    _id_CF155863A8E68EC0 = _id_A36B089919C77AA6 / _id_0A22A5A2E074A564;
    wait(_id_CF155863A8E68EC0);
    logstring("[Super Bots] SurvivalCurve: to many survivors, kill a bot");
    _id_4C9BD9A3BF3F8CF7::_id_966AB6FFD873EC11(1, 0, "SurvivalCurve");
    wait 1;
  }

  _id_878092E10CF51032();
}

_id_878092E10CF51032() {
  level._id_7B37B2193F163B9B._id_B871280CBDC11CAF = 1;
  _id_401C3A2E68AAB0FD = "CleanUpLeftUIBots";
  _id_72AF5A878A9D3397::_id_8303A56B1EE268B2("begin", _id_401C3A2E68AAB0FD, _id_1BBD21D289BA8A92());

  while(_id_1BBD21D289BA8A92() > 0) {
    _id_4C9BD9A3BF3F8CF7::_id_966AB6FFD873EC11(1, 0, _id_401C3A2E68AAB0FD);
    wait 1;
  }

  _id_72AF5A878A9D3397::_id_8303A56B1EE268B2("end", _id_401C3A2E68AAB0FD);
}

_id_FB4771E79218146B(bot) {
  if(!isbot(bot))
    return undefined;

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle._id_5B8569581E64D55A))
    return undefined;

  if(istrue(bot._id_82BD86E99F1DD1E4)) {
    bot._id_82BD86E99F1DD1E4 = undefined;
    return undefined;
  }

  if(!isDefined(level._id_DE1B021064D0F5BB) || !isDefined(level._id_DE1B021064D0F5BB.points) || level._id_DE1B021064D0F5BB.points.size <= 0)
    return undefined;

  point = _id_0F7D87293D8DDA36();

  if(!isDefined(point))
    return undefined;

  threshold = _id_94F7FCF9188A0A81(point) / 100;
  _id_8B49E0C7718E511C = _id_49ED1ADAD9307CE5();

  if(_id_8B49E0C7718E511C > point[1] * (1 + threshold)) {
    _id_0A34750D17473C49::markplayeraseliminated(bot);
    logstring("[Super Bots] SurvivalCurve: mark bot as eliminated:" + bot.name);
    return 1;
  } else if(_id_8B49E0C7718E511C < point[1] * (1 - threshold)) {
    if(!bot _id_4C9BD9A3BF3F8CF7::_id_B2502F3345564ABF())
      return undefined;

    bot.respawningfromtoken = 1;
    bot thread _id_6E4F25CE6AAFC2A8();
    return 0;
  }

  return undefined;
}

_id_6E4F25CE6AAFC2A8() {
  level endon("game_ended");
  name = self.name;
  _id_DAB12564D8FDBE0B = self getentitynumber();
  _id_FF1A8C6F49882FE8 = scripts\engine\utility::_id_53C4C53197386572(self._id_FF1A8C6F49882FE8, "");
  _id_6FD1E5714453E3F9 = 2;
  timeuntilspawn = scripts\mp\playerlogic::timeuntilspawn(1) + _id_6FD1E5714453E3F9;
  wait(timeuntilspawn);

  if(!isDefined(self)) {
    logstring("WARNING: SurvivalCurveWaitRecycleThread() bot is undefined! Skip recycle. name=" + name + " entityID=" + _id_DAB12564D8FDBE0B + " BBA_Id=" + _id_FF1A8C6F49882FE8);
    return;
  }

  logstring("[Super Bots] SurvivalCurve: recycle bot after killed:" + self.name);
  result = _id_4C9BD9A3BF3F8CF7::_id_0D3638CF9A2DA76A("SurvivalCurve recycle after killed");

  if(!result)
    _id_40E63DD222434655::kickplayer();
}

_id_A5786099CA387B00() {
  point = _id_0F7D87293D8DDA36();

  if(isDefined(point)) {
    threshold = _id_94F7FCF9188A0A81(point) / 100;
    _id_8B49E0C7718E511C = _id_49ED1ADAD9307CE5();

    if(_id_8B49E0C7718E511C > point[1] * (1 + threshold))
      return 0;
  }

  return 1;
}

_id_E89EAA436FFAD5A4() {
  level endon("game_ended");
  duration = getdvarint("dvar_6F2BCB1F13830539", 90000);
  _id_D0B92E71C0C2D4FB = _id_0719A071E30A49F1();
  _id_E254F66879E0132D = gettime();
  _id_401C3A2E68AAB0FD = "";

  for(;;) {
    if(_id_D0B92E71C0C2D4FB > 0 && gettime() >= _id_D0B92E71C0C2D4FB) {
      _id_401C3A2E68AAB0FD = "It's too late";
      break;
    }

    if(_id_06F0140D48AEE879()) {
      if(gettime() - _id_E254F66879E0132D >= duration) {
        _id_401C3A2E68AAB0FD = "only one team alive";
        break;
      }
    } else
      _id_E254F66879E0132D = gettime();

    wait 1;
  }

  forceendgame("Force end game due to terminator. " + _id_401C3A2E68AAB0FD);
}

_id_0719A071E30A49F1() {
  if(istrue(level.br_circle_disabled))
    return 0;

  if(!isDefined(level.br_circle._id_5B8569581E64D55A))
    level waittill("br_circle_set");

  _id_2FB1AB6E77CC6A3D = 0;

  if(isDefined(level.br_level.br_circledelaytimes)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.br_level.br_circledelaytimes.size; _id_AC0E594AC96AA3A8++) {
      _id_C3D4CAA5CB4132E6 = level.br_level.br_circledelaytimes[_id_AC0E594AC96AA3A8];
      _id_2FB1AB6E77CC6A3D = _id_2FB1AB6E77CC6A3D + _id_C3D4CAA5CB4132E6;
    }
  }

  if(isDefined(level.br_level.br_circleclosetimes)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.br_level.br_circleclosetimes.size; _id_AC0E594AC96AA3A8++) {
      _id_C2D7D58BFAD1B1EE = level.br_level.br_circleclosetimes[_id_AC0E594AC96AA3A8];
      _id_2FB1AB6E77CC6A3D = _id_2FB1AB6E77CC6A3D + _id_C2D7D58BFAD1B1EE;
    }
  }

  return level.br_circle._id_5B8569581E64D55A + _id_2FB1AB6E77CC6A3D * 1000 + getdvarint("dvar_B601EE95F4A4BA2E", 0);
}

_id_06F0140D48AEE879() {
  _id_B80587EAE094EC62 = 0;
  _id_638AAA73BDEB51C9 = _id_A0F36FF3EAE203AE();

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(_id_947D35B32CF46531(_id_F90358454413407F, _id_638AAA73BDEB51C9)) {
      _id_B80587EAE094EC62++;

      if(_id_B80587EAE094EC62 > 1)
        return 0;
    }
  }

  return 1;
}

_id_A0F36FF3EAE203AE() {
  if(istrue(level.br_circle_disabled))
    return 0;

  if(level.br_level.br_movingcirclecount <= 0)
    return 0;

  return level.br_circle.circleindex + 1 >= level.br_level.br_circlecenters.size - level.br_level.br_movingcirclecount;
}

_id_947D35B32CF46531(team, _id_638AAA73BDEB51C9) {
  _id_BCE4EFC75EB01319 = scripts\mp\utility\teams::getteamdata(team, "aliveCount");

  if(_id_BCE4EFC75EB01319 <= 0)
    return 0;

  if(istrue(_id_638AAA73BDEB51C9)) {
    players = scripts\mp\utility\teams::getteamdata(team, "players");

    foreach(_id_F0EA4030349A33D5 in players) {
      if(!isai(_id_F0EA4030349A33D5))
        return 1;
    }

    return 0;
  } else
    return 1;
}

forceendgame(_id_401C3A2E68AAB0FD) {
  level._id_7B37B2193F163B9B._id_B871280CBDC11CAF = 1;
  _id_575CD615EEA97FF5 = getdvarint("dvar_14A1F07FA4C28B94", 0);
  logstring("[KEY_MOMENT] ForceEndGame. endGameMethod=" + _id_575CD615EEA97FF5 + " reason=" + _id_401C3A2E68AAB0FD);
  _id_72AF5A878A9D3397::_id_873C0BE4897BD6C8(_id_575CD615EEA97FF5);

  if(_id_575CD615EEA97FF5 == 0) {
    thread scripts\mp\gamelogic::forceend();
    return;
  }

  winner = _id_5B81A287D0EFF6AD();

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    _func_EB1A045A6D299C6A();

  if(!_id_1E4A61DB11011446::_id_A587B0B0998C6D13())
    thread scripts\mp\gamelogic::endgame(winner, game["end_reason"]["enemies_eliminated"], game["end_reason"]["br_eliminated"]);
}

_id_5B81A287D0EFF6AD() {
  _id_638AAA73BDEB51C9 = 1;

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(_id_947D35B32CF46531(_id_F90358454413407F, _id_638AAA73BDEB51C9))
      return _id_F90358454413407F;
  }

  _id_638AAA73BDEB51C9 = 0;

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(_id_947D35B32CF46531(_id_F90358454413407F, _id_638AAA73BDEB51C9))
      return _id_F90358454413407F;
  }

  if(level._id_7B37B2193F163B9B._id_156F390A5362BC55.size > 0)
    return level._id_7B37B2193F163B9B._id_156F390A5362BC55[0].team;

  return undefined;
}