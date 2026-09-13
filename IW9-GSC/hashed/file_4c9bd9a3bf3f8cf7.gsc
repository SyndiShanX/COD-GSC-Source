/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4c9bd9a3bf3f8cf7.gsc
***********************************************/

_id_B2502F3345564ABF() {
  if(istrue(level._id_7B37B2193F163B9B._id_B871280CBDC11CAF))
    return 0;

  if(_id_26CCBFE3954CACF4::_id_7A5B6228C3FE75F6())
    return 0;

  if(!isDefined(self))
    return 0;

  if(level.brgametype.name == "gxp")
    return 0;

  return !_id_6F6C5CB39CD095B0();
}

_id_6F6C5CB39CD095B0() {
  if(!_id_40E63DD222434655::_id_6DD2DFEB41384764())
    return 0;

  if(scripts\mp\gamelogic::_id_1147BBC93EA9B83C()) {
    _id_786F842D5771CDB6 = _func_538E92208B641725();

    foreach(_id_E72DFDB2A9343F1B in _id_786F842D5771CDB6) {
      if(!_id_E72DFDB2A9343F1B.isai && _id_E72DFDB2A9343F1B.team == self.team)
        return 1;
    }
  } else {
    _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(self.team, "players");

    foreach(player in _id_6D5ED003AF1F9612) {
      if(!isai(player))
        return 1;
    }
  }

  return 0;
}

_id_0D3638CF9A2DA76A(_id_401C3A2E68AAB0FD) {
  if(!_id_B2502F3345564ABF())
    return 0;

  if(!isDefined(_id_401C3A2E68AAB0FD))
    _id_401C3A2E68AAB0FD = "unknown reason";

  self._id_B4ADDE4C68BB0F24._id_C2AD339C4E95C7FE = strtok(_id_401C3A2E68AAB0FD, " ")[0];
  thread _id_B20F2224A6FA748E();
  return 1;
}

_id_B20F2224A6FA748E() {
  deactivate();
}

deactivate() {
  _id_7577420D6146984A = 0;

  if(_id_26CCBFE3954CACF4::_id_D012729EAC1E7053()) {
    _id_7577420D6146984A = 1;
    level._id_7B37B2193F163B9B._id_892FA74A6B549EF0 = scripts\engine\utility::array_remove(level._id_7B37B2193F163B9B._id_892FA74A6B549EF0, self);
  }

  _id_59FF79D681BB860C::_id_2C2B5B435027F895(undefined);
  _id_89A675C5BDE8848F = spawnStruct();
  _id_89A675C5BDE8848F._id_B4ADDE4C68BB0F24 = 1;
  _id_89A675C5BDE8848F.name = self.name;
  _id_89A675C5BDE8848F.team = self.team;
  _id_89A675C5BDE8848F.squad = self._id_0FF97225579DE16A;
  _id_89A675C5BDE8848F.gulaguses = self.gulaguses;
  _id_89A675C5BDE8848F.operatorcustomization = self.operatorcustomization;
  _id_89A675C5BDE8848F.difficulty = self botgetdifficulty();
  _id_89A675C5BDE8848F._id_E2055BF088954E86 = self._id_E2055BF088954E86;
  _id_89A675C5BDE8848F.locked = 0;
  _id_89A675C5BDE8848F.plundercount = self.plundercount;
  _id_89A675C5BDE8848F.xuid = self.xuid;
  _id_6AFF3948CF4CCA03::playersetplundercount(0);

  if(_id_72AF5A878A9D3397::_id_E60552DD6ABCC4AA())
    _id_89A675C5BDE8848F._id_FF1A8C6F49882FE8 = self._id_FF1A8C6F49882FE8;

  _id_89A675C5BDE8848F.pers = [];
  _id_89A675C5BDE8848F.pers["kills"] = self.pers["kills"];
  _id_89A675C5BDE8848F.pers["deaths"] = self.pers["deaths"];
  _id_89A675C5BDE8848F.pers["shotsFired"] = self.pers["shotsFired"];
  _id_89A675C5BDE8848F.pers["shotsHit"] = self.pers["shotsHit"];
  _id_2B281A85CAA4ABDE(_id_89A675C5BDE8848F);
  self._id_B4ADDE4C68BB0F24._id_7DBB8165D792B06C = 1;
  self._id_0B8E75E4315698CD = _id_89A675C5BDE8848F;
  _id_40E63DD222434655::kickplayer("uibot", scripts\engine\utility::ter_op(_id_7577420D6146984A, "dormant", "active"));
  level notify("ui_bot_counter_updated");
}

_id_E81D83CFE1AB45FC(count, _id_A4273E17F90BFBE6, _id_401C3A2E68AAB0FD) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < count; _id_AC0E594AC96AA3A8++) {
    _id_89A675C5BDE8848F = _id_32EC26AB4915F882();

    if(!isDefined(_id_89A675C5BDE8848F)) {
      break;
    }

    _id_89A675C5BDE8848F _id_7CAE93055DAE77EC(_id_A4273E17F90BFBE6, _id_401C3A2E68AAB0FD);
  }
}

_id_33227166F85D1AEA(count, _id_A4273E17F90BFBE6, _id_401C3A2E68AAB0FD) {
  _id_E81BFDB1CB64FBEC = _id_33A64AF3F46CB84D(count);

  foreach(_id_09FDF6C66BCC4A02 in _id_E81BFDB1CB64FBEC)
  _id_516B85F3BBC993A7(_id_09FDF6C66BCC4A02);

  foreach(_id_09FDF6C66BCC4A02 in _id_E81BFDB1CB64FBEC) {
    _id_09FDF6C66BCC4A02._id_DB1B05E55E874B47 = _id_401C3A2E68AAB0FD;
    _id_72AF5A878A9D3397::_id_C622E0EA21D494FE(_id_09FDF6C66BCC4A02, _id_401C3A2E68AAB0FD);
  }

  bots = _id_59FF79D681BB860C::_id_7D92B857142DBDC6(_id_E81BFDB1CB64FBEC, undefined, ::_id_9570B978F27641EF, undefined, "spawned_bots");

  if(bots.size < _id_E81BFDB1CB64FBEC.size) {
    _id_0B727546678AB62B = 0;

    foreach(_id_09FDF6C66BCC4A02 in _id_E81BFDB1CB64FBEC) {
      if(isDefined(_id_09FDF6C66BCC4A02.bot)) {
        _id_0B727546678AB62B++;
        continue;
      }

      _id_09FDF6C66BCC4A02 _id_1EE0D9F85F7DC5D9(_id_401C3A2E68AAB0FD);
    }
  }

  foreach(bot in bots)
  bot thread _id_E164F99EA8CC4A48(_id_A4273E17F90BFBE6, _id_401C3A2E68AAB0FD);
}

_id_E164F99EA8CC4A48(_id_A4273E17F90BFBE6, _id_401C3A2E68AAB0FD) {
  bot = self;

  if(!istrue(bot._id_0DEB55E4A0429EF1)) {
    bot scripts\engine\utility::waittill_any_in_array_return(["bot_br_super_think", "death_or_disconnect"]);

    if(!_id_59FF79D681BB860C::_id_DED80385EA7471DB(bot))
      return undefined;
  }

  bot _id_59FF79D681BB860C::_id_142B713A2846F9AC("Activated - UI Bot");
  bot _id_59FF79D681BB860C::_id_1E8FE34F5DFDEA49(_id_A4273E17F90BFBE6);
  bot _id_7D256D3586241325(_id_401C3A2E68AAB0FD);
  bot scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76();
  bot scripts\cp_mp\utility\player_utility::_id_985B0973F29DA4F8("ui_bot::ResumeStatusThread()");
  bot._id_7CA8AC9793BC9C22 = undefined;
  level notify("ui_bot_counter_updated");
  bot _id_72AF5A878A9D3397::_id_B1C37E649A5CD380("active", "uibot");
}

_id_7CAE93055DAE77EC(_id_A4273E17F90BFBE6, _id_401C3A2E68AAB0FD) {
  level endon("game_ended");
  _id_516B85F3BBC993A7(self);
  self._id_DB1B05E55E874B47 = _id_401C3A2E68AAB0FD;
  _id_72AF5A878A9D3397::_id_C622E0EA21D494FE(self, _id_401C3A2E68AAB0FD);

  if(!_id_F7BBD79229321ACB(self, _func_538E92208B641725())) {
    logstring("[UIBOT] Activate: Drop UI Bots: " + self.name + " xuid: " + self.xuid);
    _id_1EE0D9F85F7DC5D9(_id_401C3A2E68AAB0FD + "_InvalidBotProfile");
    return undefined;
  }

  bots = _id_59FF79D681BB860C::_id_7D92B857142DBDC6([self], self.team, ::_id_9570B978F27641EF, undefined, "spawned_bots");

  if(bots.size == 0) {
    _id_1EE0D9F85F7DC5D9(_id_401C3A2E68AAB0FD);
    return undefined;
  }

  bot = bots[0];
  bot _id_E164F99EA8CC4A48(_id_A4273E17F90BFBE6, _id_401C3A2E68AAB0FD);
  return bot;
}

_id_1EE0D9F85F7DC5D9(_id_401C3A2E68AAB0FD) {
  _id_72AF5A878A9D3397::_id_1968D5899AA0A0CB(self, "kickout", "uibot");
  success = _id_8EDD1FB6091A089F(self);

  if(!success) {
    return;
  }
  _id_72AF5A878A9D3397::_id_C622E0EA21D494FE(self, _id_401C3A2E68AAB0FD + "_failed");
  _id_551F4F12C0E20C06();
}

_id_551F4F12C0E20C06() {
  team = self.team;

  if(_id_26CCBFE3954CACF4::isteameliminated(team)) {
    scripts\mp\utility\teams::setteamdata(team, "deathEvent", 0);
    scripts\mp\utility\teams::modifyteamdata(team, "hasSpawned", 1);
    [[level.updategameevents]]();
  }
}

_id_C827480E6D21A271() {
  _id_89A675C5BDE8848F = self._id_5876CD9FC14AF731;

  if(isDefined(_id_89A675C5BDE8848F)) {
    self.gulaguses = _id_89A675C5BDE8848F.gulaguses;

    if(istrue(level.br_c130spawndone))
      self.jumped = 1;

    self._id_B4ADDE4C68BB0F24._id_7DBB8165D792B06C = 0;
    _id_6AFF3948CF4CCA03::playersetplundercount(_id_89A675C5BDE8848F.plundercount);
    self.pers["kills"] = _id_89A675C5BDE8848F.pers["kills"];
    self.pers["deaths"] = _id_89A675C5BDE8848F.pers["deaths"];
    self.pers["shotsFired"] = _id_89A675C5BDE8848F.pers["shotsFired"];
    self.pers["shotsHit"] = _id_89A675C5BDE8848F.pers["shotsHit"];
    success = _id_8EDD1FB6091A089F(_id_89A675C5BDE8848F);
    _id_72AF5A878A9D3397::_id_C622E0EA21D494FE(_id_89A675C5BDE8848F, _id_89A675C5BDE8848F._id_DB1B05E55E874B47 + "_succeeded");
  }
}

_id_83574001589FB42D() {
  if(isDefined(self._id_5876CD9FC14AF731)) {
    self.operatorcustomization = self._id_5876CD9FC14AF731.operatorcustomization;
    scripts\mp\teams::setmodelfromcustomization();
    self._id_5876CD9FC14AF731 = undefined;
    logstring("[Super Bots] Bot late recovered from uiBot:" + self.name);
  }
}

_id_2B281A85CAA4ABDE(_id_89A675C5BDE8848F) {
  team = _id_89A675C5BDE8848F.team;
  level._id_7B37B2193F163B9B._id_156F390A5362BC55[level._id_7B37B2193F163B9B._id_156F390A5362BC55.size] = _id_89A675C5BDE8848F;
  level.teamdata[team]["UIBotCount"]++;
  level.teamdata[team]["UnlockedUIBotCount"]++;
  _id_B3BB8F282B894DAD(team);
}

_id_8EDD1FB6091A089F(_id_89A675C5BDE8848F) {
  if(!scripts\engine\utility::array_contains(level._id_7B37B2193F163B9B._id_156F390A5362BC55, _id_89A675C5BDE8848F))
    return 0;

  team = _id_89A675C5BDE8848F.team;
  _id_89A675C5BDE8848F.locked = 0;
  level._id_7B37B2193F163B9B._id_156F390A5362BC55 = scripts\engine\utility::array_remove(level._id_7B37B2193F163B9B._id_156F390A5362BC55, _id_89A675C5BDE8848F);
  level.teamdata[team]["UIBotCount"]--;
  _id_B3BB8F282B894DAD(team);
  level notify("ui_bot_counter_updated");
  return 1;
}

_id_3E4C2FE4A6617607() {
  foreach(_id_B4ADDE4C68BB0F24 in level._id_7B37B2193F163B9B._id_156F390A5362BC55) {
    team = _id_B4ADDE4C68BB0F24.team;
    level.teamdata[team]["UIBotCount"] = 0;
    level.teamdata[team]["UnlockedUIBotCount"] = 0;
  }

  level._id_7B37B2193F163B9B._id_156F390A5362BC55 = [];
  level notify("ui_bot_counter_updated");
}

_id_CDE96C5B28CC69F6() {
  if(!scripts\mp\utility\game::matchmakinggame()) {
    return;
  }
  if(!_id_26CCBFE3954CACF4::_id_5972C32461575E59()) {
    return;
  }
  _id_786F842D5771CDB6 = _func_538E92208B641725();
  _id_156F390A5362BC55 = _id_26CCBFE3954CACF4::_id_749723C2A45A0233();
  _id_BB621279272EE27A = [];

  foreach(_id_09FDF6C66BCC4A02 in _id_156F390A5362BC55) {
    if(!_id_F7BBD79229321ACB(_id_09FDF6C66BCC4A02, _id_786F842D5771CDB6))
      _id_BB621279272EE27A = scripts\engine\utility::array_add(_id_BB621279272EE27A, _id_09FDF6C66BCC4A02);
  }

  foreach(_id_09FDF6C66BCC4A02 in _id_BB621279272EE27A) {
    _id_516B85F3BBC993A7(_id_09FDF6C66BCC4A02);
    logstring("[UIBOT] Drop UI Bots: " + _id_09FDF6C66BCC4A02.name + " xuid: " + _id_09FDF6C66BCC4A02.xuid);
    _id_8EDD1FB6091A089F(_id_09FDF6C66BCC4A02);
  }
}

_id_F7BBD79229321ACB(_id_89A675C5BDE8848F, _id_786F842D5771CDB6) {
  if(!isDefined(_id_89A675C5BDE8848F))
    return 0;

  if(scripts\mp\utility\game::matchmakinggame()) {
    if(!isDefined(_id_89A675C5BDE8848F.xuid) || _id_89A675C5BDE8848F.xuid == "")
      return 0;

    found = 0;

    foreach(_id_E72DFDB2A9343F1B in _id_786F842D5771CDB6) {
      if(scripts\engine\utility::is_equal(_id_89A675C5BDE8848F.xuid, _id_E72DFDB2A9343F1B.xuid)) {
        found = 1;
        break;
      }
    }

    if(!found)
      return 0;
  }

  return 1;
}

_id_B3BB8F282B894DAD(team) {
  _id_EADA48B37E7E4B05 = 0;
  _id_B6BD7A39A24879EE = 0;

  foreach(_id_B4ADDE4C68BB0F24 in level._id_7B37B2193F163B9B._id_156F390A5362BC55) {
    if(_id_B4ADDE4C68BB0F24.team == team) {
      _id_EADA48B37E7E4B05++;

      if(!_id_B4ADDE4C68BB0F24.locked)
        _id_B6BD7A39A24879EE++;
    }
  }

  _id_4E57201D0F72C7D6 = level.teamdata[team]["UIBotCount"];
  _id_B08AEA35D83F4F3D = level.teamdata[team]["UnlockedUIBotCount"];

  if(_id_4E57201D0F72C7D6 < 0)
    scripts\mp\utility\script::demoforcesre("UIBotCount is negative! team=" + team);

  if(_id_B08AEA35D83F4F3D < 0)
    scripts\mp\utility\script::demoforcesre("UnlockedUIBotCount is negative! team=" + team);

  if(_id_EADA48B37E7E4B05 != _id_4E57201D0F72C7D6)
    scripts\mp\utility\script::demoforcesre("UIBotCount mismatch! team=" + team + " countInUIBotManager=" + _id_EADA48B37E7E4B05 + " countInTeamData=" + _id_4E57201D0F72C7D6);

  if(_id_B6BD7A39A24879EE != _id_B08AEA35D83F4F3D)
    scripts\mp\utility\script::demoforcesre("UnlockedUIBotCount mismatch! team=" + team + " unlockedCountInUIBotManager=" + _id_B6BD7A39A24879EE + " unlockedCountInTeamData=" + _id_B08AEA35D83F4F3D);
}

_id_516B85F3BBC993A7(_id_89A675C5BDE8848F) {
  team = _id_89A675C5BDE8848F.team;
  _id_89A675C5BDE8848F.locked = 1;
  level.teamdata[team]["UnlockedUIBotCount"]--;
}

_id_9570B978F27641EF() {
  self._id_B4ADDE4C68BB0F24 = spawnStruct();
  self._id_B4ADDE4C68BB0F24._id_7DBB8165D792B06C = 1;

  if(isDefined(level._id_7B37B2193F163B9B._id_9F4A3632D9F75D32)) {
    spawnpoint = spawnStruct();
    spawnpoint.origin = level._id_7B37B2193F163B9B._id_9F4A3632D9F75D32;
    spawnpoint.angles = (0, 0, 0);
    spawnpoint.index = -1;
    self.prespawnspawn = spawnpoint;
    self._id_7CA8AC9793BC9C22 = 1;
  }
}

_id_966AB6FFD873EC11(count, _id_DCFAC6660215F3BE, _id_401C3A2E68AAB0FD, _id_94AFB7D602135955) {
  if(count <= 0) {
    return;
  }
  _id_68767159CA419DC7 = "Killsome_" + _id_401C3A2E68AAB0FD;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < count; _id_AC0E594AC96AA3A8++) {
    _id_89A675C5BDE8848F = _id_32EC26AB4915F882();

    if(!isDefined(_id_89A675C5BDE8848F)) {
      break;
    }

    _id_629C48F843740B97 = _id_89A675C5BDE8848F _id_7CAE93055DAE77EC("Combat", _id_68767159CA419DC7);

    if(isDefined(_id_629C48F843740B97)) {
      if(istrue(_id_DCFAC6660215F3BE)) {
        _id_629C48F843740B97.gulaguses = undefined;
        _id_629C48F843740B97._id_82BD86E99F1DD1E4 = 1;
        _id_629C48F843740B97._id_94AFB7D602135955 = _id_94AFB7D602135955;
      }

      wait 1;

      if(_id_40E63DD222434655::_id_2CEE00BF93CE58E6(_id_629C48F843740B97))
        _id_629C48F843740B97 suicide();
    }
  }
}

_id_32EC26AB4915F882(_id_6F5C365E73AD85FC) {
  foreach(_id_89A675C5BDE8848F in level._id_7B37B2193F163B9B._id_156F390A5362BC55) {
    if(isDefined(_id_6F5C365E73AD85FC) && _id_89A675C5BDE8848F.team == _id_6F5C365E73AD85FC) {
      continue;
    }
    if(!_id_89A675C5BDE8848F.locked)
      return _id_89A675C5BDE8848F;
  }

  return undefined;
}

_id_33A64AF3F46CB84D(count) {
  _id_E81BFDB1CB64FBEC = [];
  _id_786F842D5771CDB6 = _func_538E92208B641725();

  foreach(_id_89A675C5BDE8848F in level._id_7B37B2193F163B9B._id_156F390A5362BC55) {
    if(!_id_89A675C5BDE8848F.locked && _id_F7BBD79229321ACB(_id_89A675C5BDE8848F, _id_786F842D5771CDB6)) {
      _id_E81BFDB1CB64FBEC[_id_E81BFDB1CB64FBEC.size] = _id_89A675C5BDE8848F;

      if(_id_E81BFDB1CB64FBEC.size >= count) {
        break;
      }
    }
  }

  return _id_E81BFDB1CB64FBEC;
}

_id_947B37D99674B59C() {
  level endon("game_ended");
  _id_81A80043D8CE8EEF = 3000;
  _id_6B7BEE46F2C6DA28 = gettime();

  if(isDefined(self._id_44F4FB2FDD683FFA._id_446D5C9F0F95831D) && _id_6B7BEE46F2C6DA28 - self._id_44F4FB2FDD683FFA._id_446D5C9F0F95831D < _id_81A80043D8CE8EEF) {
    return;
  }
  self._id_44F4FB2FDD683FFA._id_446D5C9F0F95831D = _id_6B7BEE46F2C6DA28;
  radius = getdvarint("dvar_358164E65D640280", 390);
  radius = max(radius, 390);
  _id_89A675C5BDE8848F = _id_32EC26AB4915F882(self.team);

  if(!isDefined(_id_89A675C5BDE8848F)) {
    return;
  }
  _id_CC70F10B6C345F6C = getdvarfloat("dvar_E4A177FEBF5C5689", 0);
  _id_17F9769ECC54CD5A = scripts\engine\utility::ter_op(randomfloat(1) < _id_CC70F10B6C345F6C, 1, 0);
  _id_E2270F384295FABA = _id_17F9769ECC54CD5A == 0 || _id_26CCBFE3954CACF4::_id_7A5B6228C3FE75F6();

  if(_id_E2270F384295FABA) {
    if(_id_1E4A61DB11011446::_id_72CE5F47DA0F5661()) {
      _id_DAC0CB34AD4DB25F = getdvarint("dvar_F394EBA720226431", 3700);
      radius = radius + _id_DAC0CB34AD4DB25F;
    }

    bot = _id_063BDF181A81CBD9(_id_89A675C5BDE8848F, self.origin, self.angles, radius, self.name);
  } else
    bot = _id_FFBE03EA2562F5AC(_id_89A675C5BDE8848F, self.origin, self.angles, radius, self.name);

  if(isDefined(bot)) {
    if(!bot._id_AB5F5270CB22E3C8 && _id_E2270F384295FABA)
      bot thread _id_40E63DD222434655::_id_916E2512538553DB();

    if(!_id_E2270F384295FABA)
      bot._id_6601CCD8EC4B0356 = self;

    bot switchtoweapon(bot.primaryweapons[0]);

    if(isDefined(self))
      self._id_44F4FB2FDD683FFA._id_F315B15BF1BD4B5E = gettime();
  }
}

_id_38B0BF785F0D3321(type, origin, bot, name) {
  _id_D5BB04F234D19728 = distance(origin, bot.origin);
  _id_2A740F1203C3EF99 = bot;

  foreach(player in level.players) {
    if(_id_40E63DD222434655::_id_40034C2FAF09A87B(player)) {
      _id_DF8E0358F6E2B842 = distance(player.origin, bot.origin);

      if(_id_DF8E0358F6E2B842 < _id_D5BB04F234D19728) {
        _id_D5BB04F234D19728 = _id_DF8E0358F6E2B842;
        _id_2A740F1203C3EF99 = player;
      }
    }
  }

  logstring("[Super Bots] Deploy Bot in " + type + " bot:" + bot.name + " (" + bot.origin[0] + ", " + bot.origin[1] + ", " + bot.origin[2] + ") player:" + name + " (" + origin[0] + ", " + origin[1] + ", " + origin[2] + ")" + " distToPlayer:" + distance(origin, bot.origin) + " minDistPlayer:" + _id_2A740F1203C3EF99.name + " (" + _id_2A740F1203C3EF99.origin[0] + ", " + _id_2A740F1203C3EF99.origin[1] + ", " + _id_2A740F1203C3EF99.origin[2] + ")" + " minDistToPlayer:" + _id_D5BB04F234D19728);
}

_id_063BDF181A81CBD9(_id_89A675C5BDE8848F, origin, angles, radius, name) {
  level endon("game_ended");
  bot = _id_89A675C5BDE8848F _id_7CAE93055DAE77EC("Combat", "DeployOneBotOnGround");

  if(!_id_59FF79D681BB860C::isvalidplayer(bot))
    return undefined;

  bot._id_B4ADDE4C68BB0F24._id_6ECC7CD453466014 = 1;
  bot scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
  bot scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("ui_bot::DeployOneBotOnGround()");
  bot botsetflag("suspended", 1);
  _id_F1F1BC7727CA599B = undefined;
  _id_724926DBAC2BB2FB = 10;
  _id_6D39356E6E1F0FC1 = 0;
  _id_50CC8A323926E734 = bot.origin;
  _id_99E8FCB28E160694 = [];

  foreach(player in level.players) {
    if(_id_40E63DD222434655::_id_40034C2FAF09A87B(player))
      _id_99E8FCB28E160694[_id_99E8FCB28E160694.size] = player;
  }

  while(!isDefined(_id_F1F1BC7727CA599B) && _id_6D39356E6E1F0FC1 < _id_724926DBAC2BB2FB) {
    waitframe();

    if(_id_5D2AAE3A7D90DF56() >= getdvarint("dvar_789BFEB36C8E00FD", 999)) {
      break;
    }

    circleradius = _id_2695A20D4011076D::getdangercircleradius();

    if(circleradius > 0) {
      circleorigin = _id_2695A20D4011076D::getdangercircleorigin();
      _id_5BC945B12CD2C2C6 = distance2d(circleorigin, origin);

      if(_id_5BC945B12CD2C2C6 > radius + circleradius) {
        logstring("[Super Bots] Warning: no valid bot deploy position found for player, the player is faraway from the circle");
        break;
      }
    }

    _id_6D39356E6E1F0FC1++;
    _id_25854DB1807F021A = _id_F24F661DC7782EBC(origin, _id_99E8FCB28E160694, radius);

    if(isDefined(_id_25854DB1807F021A)) {
      bot setOrigin(_id_25854DB1807F021A, 1);

      if(!bot _id_40E63DD222434655::_id_B74CF5EB822312CB())
        _id_F1F1BC7727CA599B = _id_25854DB1807F021A;
    }
  }

  bot._id_B4ADDE4C68BB0F24._id_6ECC7CD453466014 = 0;

  if(isDefined(_id_F1F1BC7727CA599B)) {
    bot botsetflag("suspended", 0);
    bot setOrigin(_id_F1F1BC7727CA599B, 1);
    bot _meth_D7BF524EB1822214(0);
    bot scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76();
    bot scripts\cp_mp\utility\player_utility::_id_985B0973F29DA4F8("ui_bot::DeployOneBotOnGround()");
    _id_72AF5A878A9D3397::_id_6B1CA7FAEB9FD14A(bot, _id_50CC8A323926E734, _id_F1F1BC7727CA599B, "DeployOneBotOnGround");

    if(getdvarint("dvar_429176496A1B2FD8", 0))
      _id_38B0BF785F0D3321("ground", origin, bot, name);

    return bot;
  }

  if(_id_6D39356E6E1F0FC1 == _id_724926DBAC2BB2FB)
    logstring("[Super Bots] Warning: no valid bot deploy position found for player origin " + origin);

  if(!bot _id_0D3638CF9A2DA76A("deployment fails"))
    bot _id_40E63DD222434655::kickplayer();

  return undefined;
}

_id_5D2AAE3A7D90DF56() {
  _id_4F304A8F807B9777 = 0;

  foreach(player in level.players) {
    if(isbot(player) && !player _id_40E63DD222434655::_id_A9CBF557DC66D201() && !player _id_26CCBFE3954CACF4::_id_6ECC7CD453466014())
      _id_4F304A8F807B9777++;
  }

  return _id_4F304A8F807B9777;
}

_id_F24F661DC7782EBC(origin, _id_99E8FCB28E160694, radius) {
  _id_0938ED9C898B8C83 = getdvarfloat("dvar_74D198F9030A4630", 0.8);
  _id_25854DB1807F021A = _id_2695A20D4011076D::getrandompointincircle(origin, radius, _id_0938ED9C898B8C83, 1.0, 1, 0);
  _id_0305CB3C698A6470 = _id_2695A20D4011076D::getdangercircleorigin();
  _id_F4700C92066207E4 = _id_2695A20D4011076D::getdangercircleradius();
  _id_91A9B1A7E28B6C47 = 0.1;

  if(!scripts\engine\utility::ispointinsidecircle(_id_25854DB1807F021A, _id_0305CB3C698A6470, _id_F4700C92066207E4 * (1 - _id_91A9B1A7E28B6C47)))
    return undefined;

  _id_2BC127F950AD927C = radius * _id_0938ED9C898B8C83;

  foreach(player in _id_99E8FCB28E160694) {
    if(_id_40E63DD222434655::_id_40034C2FAF09A87B(player) && scripts\engine\utility::ispointinsidecircle(player.origin, _id_25854DB1807F021A, _id_2BC127F950AD927C))
      return undefined;
  }

  return _id_25854DB1807F021A;
}

_id_FFBE03EA2562F5AC(_id_89A675C5BDE8848F, origin, angles, radius, name) {
  spawnorigin = _id_5BAB271917698DC4::getsafeoriginaroundpoint(origin, radius);

  if(isDefined(spawnorigin)) {
    bot = _id_89A675C5BDE8848F _id_7CAE93055DAE77EC("Skydive", "DeployOneBotInAir");

    if(!_id_59FF79D681BB860C::isvalidplayer(bot))
      return undefined;

    spawnorigin = _id_2CEDCC356F1B9FC8::droptogroundmultitrace(spawnorigin);
    spawnangles = _id_5BAB271917698DC4::getanglesfacingorigin(spawnorigin, origin);
    height = scripts\cp_mp\parachute::getc130height();

    if(isDefined(level.br_circle)) {
      circleindex = level.br_circle.circleindex;
      _id_AE439BDE76B3E937 = _id_67708F418B1FAC79::getgulagclosedcircleindex();
      _id_F0B695BB4C38471B = isDefined(circleindex) && circleindex >= _id_AE439BDE76B3E937;

      if(_id_F0B695BB4C38471B)
        height = height * getdvarfloat("dvar_A1C2D6B19BB6A568", 0.55);
    }

    if(isDefined(level.respawnheightoverride))
      height = level.respawnheightoverride;

    _id_A6427A6A24F058DC = (0, 0, height);
    spawnorigin = _id_1E4A61DB11011446::getoffsetspawnorigin(spawnorigin, _id_A6427A6A24F058DC);
    _id_72AF5A878A9D3397::_id_6B1CA7FAEB9FD14A(bot, bot.origin, spawnorigin, "DeployOneBotInAir");
    bot setOrigin(spawnorigin);
    bot _meth_D7BF524EB1822214(0);
    bot setplayerangles(spawnangles);
    _id_BDA1DE83E1856735 = 0;

    if(isDefined(level.parachutedeploydelay))
      _id_BDA1DE83E1856735 = level.parachutedeploydelay;

    _id_CB4FAD49263E20C4 = bot _id_6AFF3948CF4CCA03::_id_79275E2FAB13F54D();
    bot.plundercount = _id_CB4FAD49263E20C4._id_6AEE9C9054F09ED5;
    bot thread scripts\cp_mp\parachute::startfreefall(_id_BDA1DE83E1856735, 0, undefined, undefined, 1);

    if(getdvarint("dvar_429176496A1B2FD8", 0))
      _id_38B0BF785F0D3321("air", origin, bot, name);

    return bot;
  }

  return undefined;
}

_id_B9C4A50390B0B5EB(bot, _id_89A675C5BDE8848F) {
  bot._id_5876CD9FC14AF731 = _id_89A675C5BDE8848F;
  _id_89A675C5BDE8848F.bot = bot;
  bot scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
  bot scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("ui_bot::SpawnUIBotLogic()");
  bot scripts\mp\bots\bots::bot_set_loadout_class();
  _id_344E415F40E9796B = getdvarint("dvar_B7F8B4B89EA6CED1", 0);

  if(_id_344E415F40E9796B > 0) {
    bot._id_76B390D02672ECEA = 1;
    bot thread _id_4FEDC3015E876FF8(_id_344E415F40E9796B);
  }
}

_id_4FEDC3015E876FF8(_id_344E415F40E9796B) {
  self endon("ClearPlotArmorThread");
  name = self.name;
  id = self getentitynumber();
  _id_401C3A2E68AAB0FD = scripts\engine\utility::waittill_any_in_array_or_timeout(["death", "disconnect"], _id_344E415F40E9796B);

  if(isDefined(self)) {
    if(_id_59FF79D681BB860C::_id_DED80385EA7471DB(self)) {
      logstring("[Super Bots] clear plotArmorTriggerHurt. name=" + name + " id=" + id + " health=" + self.health + " superThinkCalled=" + istrue(self._id_0DEB55E4A0429EF1) + " reason=" + _id_401C3A2E68AAB0FD);

      if(!_id_0D3638CF9A2DA76A("ClearPlotArmorThread timeout"))
        _id_40E63DD222434655::kickplayer();
    } else
      _id_7D256D3586241325(_id_401C3A2E68AAB0FD);
  } else
    logstring("[Super Bots] clear plotArmorTriggerHurt. self=undefined name=" + name + " id=" + id + " reason=" + _id_401C3A2E68AAB0FD);
}

_id_7D256D3586241325(_id_401C3A2E68AAB0FD) {
  if(istrue(self._id_76B390D02672ECEA)) {
    self._id_76B390D02672ECEA = 0;
    name = self.name;
    id = self getentitynumber();
    health = scripts\engine\utility::_id_53C4C53197386572(self.health, "undefined");

    if(!isDefined(_id_401C3A2E68AAB0FD))
      _id_401C3A2E68AAB0FD = "unknown";

    logstring("[Super Bots] clear plotArmorTriggerHurt. name=" + name + " id=" + id + " health=" + health + " superThinkCalled=" + istrue(self._id_0DEB55E4A0429EF1) + " reason=" + _id_401C3A2E68AAB0FD);
    self notify("ClearPlotArmorThread");
  }
}