/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\game_utility.gsc
**************************************************/

getmapname() {
  if(!isDefined(level.mapname))
    level.mapname = getDvar("g_mapname");

  return level.mapname;
}

_id_0BEFF479639E6508() {
  if(isDefined(level._id_62F6F7640E4431E3))
    return scripts\engine\utility::_id_53C4C53197386572(level._id_62F6F7640E4431E3._id_0BEFF479639E6508, 0);

  if(!isDefined(level.gametype))
    return 0;

  return level.gametype == "br";
}

_id_22CD3D64FDB05892() {
  if(!isDefined(level.gametype))
    return 0;

  return level.gametype == "arm" || level.gametype == "gwtdm" || level.gametype == "conflict";
}

_id_3BF9723F3DDB4D76() {
  if(!_id_0BEFF479639E6508())
    return 0;

  if(!isDefined(level.brgametype))
    return 0;

  return level.brgametype.name == "gxp";
}

_id_BA5574C7F287C587() {
  return getdvarint("mgl", 0) != 0;
}

_id_FA7BFCC1D68B7B73() {
  return _id_BA5574C7F287C587() && _id_0BEFF479639E6508();
}

_id_2D79A7A3B91C4C3E() {
  return _id_BA5574C7F287C587() && !_id_0BEFF479639E6508();
}

_id_A0148D3A4A97BBB1() {
  return _id_2D79A7A3B91C4C3E() && level.mapname == "mp_don3_mobile";
}

_id_7F8A6A1772BD6F5F() {
  level._id_F8DF85EE28F001E3 = 1;
}

_id_244067E915C0EABE() {
  return istrue(level._id_F8DF85EE28F001E3);
}

registerlargemap() {
  level.largemap = 1;
}

islargemap() {
  return istrue(level.largemap);
}

islargebrmap() {
  return _id_0BEFF479639E6508() && islargemap();
}

registerdonetskmap() {
  registerlargemap();
  level.isdonetskmap = 1;
}

isdonetskmap() {
  return istrue(level.isdonetskmap);
}

registerdonetsksubmap() {
  level.donetsksubmap = 1;
}

isdonetsksubmap() {
  return istrue(level.donetsksubmap);
}

_id_5258141665FF7B95() {
  registerlargemap();
  level._id_7EE65FAE13124702 = 1;
}

_id_7EE65FAE13124702() {
  return istrue(level._id_7EE65FAE13124702);
}

_id_5B9E95ACD14775A5() {
  level._id_6C8C09778110DDF8 = 1;
}

_id_DA8C49606D8AA048() {
  return istrue(level._id_6C8C09778110DDF8);
}

_id_DB54DB563AC2EC62() {
  registerlargemap();
  level._id_3678E32EA86B4DA7 = 1;
}

_id_3678E32EA86B4DA7() {
  return istrue(level._id_3678E32EA86B4DA7);
}

_id_9CFE515677727128() {
  level._id_E0708DADCDABA5AB = 1;
}

_id_47EB75D4E513B67B() {
  return istrue(level._id_E0708DADCDABA5AB);
}

_id_743719859FBAB899() {
  registerlargemap();
  level._id_E21746ABAAAF8414 = 1;
}

_id_E21746ABAAAF8414() {
  return istrue(level._id_E21746ABAAAF8414);
}

_id_7643F25D8EF9F5D9() {
  level._id_9EB5D18392A3526E = 1;
}

_id_9EB5D18392A3526E() {
  return istrue(level._id_9EB5D18392A3526E);
}

_id_4B8E6239B2D87474() {
  registerlargemap();
  level._id_5E0E3A24DBB1FAE1 = 1;
}

_id_5E0E3A24DBB1FAE1() {
  return istrue(level._id_5E0E3A24DBB1FAE1);
}

_id_AC85A5AB21DB294E() {
  level._id_0A88026E516CDED1 = 1;
}

_id_0A88026E516CDED1() {
  return istrue(level._id_0A88026E516CDED1);
}

_id_FFBBB4525B11D5A2() {
  return istrue(level.mapname == "mp_bio_lab");
}

_id_EE0C2958AA2EE59E() {
  return istrue(level.mapname == "mp_biobunker");
}

_id_934AC55AA85CE574() {
  return istrue(level.mapname == "mp_bio_lab") || istrue(level.mapname == "mp_biobunker");
}

_id_DA466A8AA038E27D() {
  return isdonetsksubmap() || _id_DA8C49606D8AA048() || _id_47EB75D4E513B67B();
}

registernightmap(_id_674C814E22D13236) {
  if(!isDefined(_id_674C814E22D13236))
    _id_674C814E22D13236 = 1;

  level.nightmap = 1;
  visionsetkillcamthirdpersonnight("killcam_night");

  if(_id_674C814E22D13236)
    _id_67C053F33E4F21A1();
}

isnightmap() {
  return istrue(level.nightmap);
}

_id_67C053F33E4F21A1() {
  level._id_3EAC2A21EE8E9D4F = 1;
}

_id_D2D2B803A7B741A4() {
  return istrue(level._id_3EAC2A21EE8E9D4F);
}

registerarenamap() {
  level.arenamap = 1;
  level.disablespawncamera = 1;
  level.skipfirstraise = 1;
  level.requiresminstartspawns = 0;
}

registersmallmap() {
  level.disablespawncamera = 1;
  level.skipfirstraise = 1;
}

isarenamap() {
  return istrue(level.arenamap);
}

_id_5A094C7DC3B36EBD() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isLifeLimited"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isLifeLimited")]]();

  return 0;
}

_id_6AE03EFB52C52C29(player) {
  if(_id_5A094C7DC3B36EBD()) {
    _id_C262D94FEEF124F0 = scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("game", "getGametypeNumLives");

    if(isDefined(player.pers["deaths"]) && player.pers["deaths"] >= _id_C262D94FEEF124F0)
      return 1;
  }

  return 0;
}

_id_9CDAADFDDEDA4D7A() {
  return istrue(level._id_9CDAADFDDEDA4D7A);
}

_id_6C1FCE6F6B8779D5() {
  if(_id_0BEFF479639E6508()) {
    _id_FAF0D2FAC3F47583 = getDvar("dvar_7611A2790A0BF7FE", "");

    if(_id_FAF0D2FAC3F47583 != "")
      return _id_FAF0D2FAC3F47583;
  }

  return level.gametype;
}

shouldskipfirstraise() {
  if(!isDefined(level.skipfirstraise))
    level.skipfirstraise = getdvarint("scr_game_weapon_skip_first_raise", 0) == 1;

  return istrue(level.skipfirstraise);
}

getlocaleid() {
  if(!isDefined(level.localeid)) {
    localeid = getdvarint("scr_localeID", 0);

    if(localeid > 0)
      level.localeid = "locale_" + localeid;
    else if(localeid == 0)
      level.localeid = undefined;
    else if(isdonetskmap())
      level.localeid = "locale_6";
    else {
      switch (getmapname()) {
        case "mp_quarry2":
          level.localeid = "locale_5";
          break;
        case "mp_downtown_gw":
          level.localeid = "locale_6";
          break;
        case "mp_farms2_gw":
          level.localeid = "locale_9";
          break;
        case "mp_aniyah":
          level.localeid = "locale_17";
          break;
      }
    }
  }

  return level.localeid;
}

getlocaleent(_id_6C77123D46F26285, _id_8A8A9680C8AD47A2, _id_783AB83623B57681) {
  _id_6F0350C82FC94C38 = getEntArray(_id_6C77123D46F26285, "targetname");
  _id_44716BCB2430218B = undefined;

  if(isDefined(_id_6F0350C82FC94C38) && _id_6F0350C82FC94C38.size == 1)
    return _id_6F0350C82FC94C38[0];

  if(isDefined(getlocaleid()) && !istrue(_id_783AB83623B57681)) {
    foreach(ent in _id_6F0350C82FC94C38) {
      if(isDefined(ent.script_noteworthy) && ent.script_noteworthy == level.localeid) {
        _id_44716BCB2430218B = ent;
        continue;
      }

      if(level.mapname == "mp_port2_gw" && _id_6C77123D46F26285 == "airstrikeheight") {
        if(ent.origin == (34880, -26944, 3072))
          _id_44716BCB2430218B = ent;

        continue;
      }

      ent delete();
    }
  } else {
    foreach(ent in _id_6F0350C82FC94C38) {
      if(!isDefined(_id_44716BCB2430218B)) {
        _id_44716BCB2430218B = ent;
        continue;
      }

      ent delete();
    }
  }

  if(isDefined(_id_44716BCB2430218B))
    return _id_44716BCB2430218B;

  if(istrue(_id_8A8A9680C8AD47A2))
    return;
}

getlocalestruct(_id_CAB957ADC8D7710F, _id_8A8A9680C8AD47A2) {
  _id_6F0350C82FC94C38 = scripts\engine\utility::getStructArray(_id_CAB957ADC8D7710F, "targetname");
  _id_44716BCB2430218B = undefined;

  if(isDefined(getlocaleid())) {
    foreach(ent in _id_6F0350C82FC94C38) {
      if(isDefined(ent.script_noteworthy) && ent.script_noteworthy == level.localeid)
        _id_44716BCB2430218B = ent;
    }
  } else {
    foreach(ent in _id_6F0350C82FC94C38) {
      if(!isDefined(_id_44716BCB2430218B)) {
        _id_44716BCB2430218B = ent;
        break;
      }
    }
  }

  if(isDefined(_id_44716BCB2430218B))
    return _id_44716BCB2430218B;

  if(istrue(_id_8A8A9680C8AD47A2))
    return;
}

getlocalestructarray(_id_CAB957ADC8D7710F, _id_8A8A9680C8AD47A2) {
  _id_6F0350C82FC94C38 = scripts\engine\utility::getStructArray(_id_CAB957ADC8D7710F, "targetname");
  _id_134CB8F60FF902C0 = [];

  if(isDefined(getlocaleid())) {
    foreach(ent in _id_6F0350C82FC94C38) {
      if(getmapname() == "mp_quarry2") {
        _id_134CB8F60FF902C0[_id_134CB8F60FF902C0.size] = ent;
        continue;
      }

      if(isDefined(ent.script_noteworthy) && ent.script_noteworthy == level.localeid)
        _id_134CB8F60FF902C0[_id_134CB8F60FF902C0.size] = ent;
    }

    return _id_134CB8F60FF902C0;
  }

  if(_id_6F0350C82FC94C38.size == 0) {
    if(istrue(_id_8A8A9680C8AD47A2)) {}
  } else {}
}

_id_0B2C4B42F9236924() {
  return istrue(level._id_12226443217B5474);
}

_id_21322DA268E71C19() {
  return istrue(level._id_1AF27F387B8D3369) || _id_0B2C4B42F9236924();
}

_id_852712268D005332(player, fadetoblack, _id_F69BA8D7B96E8326) {
  player notify("start_fade_to_black_keep_ui");
  player endon("start_fade_to_black_keep_ui");
  player endon("disconnect");
  level endon("game_ended");
  _id_400FC540BBC48AA9 = 0;

  if(istrue(fadetoblack))
    _id_400FC540BBC48AA9 = 1;

  if(!isDefined(_id_F69BA8D7B96E8326) || _id_F69BA8D7B96E8326 == 0) {
    player setclientomnvar("ui_world_fade", _id_400FC540BBC48AA9);
    return;
  }

  _id_226A6D12E60638A5 = _id_400FC540BBC48AA9;
  _id_400FC540BBC48AA9 = 0;
  _id_DB4AF00B8B0BF7C6 = int(_id_F69BA8D7B96E8326 / level.framedurationseconds);
  _id_F2C7B24B4F8544F3 = 1 / _id_DB4AF00B8B0BF7C6;

  if(!istrue(fadetoblack)) {
    _id_F2C7B24B4F8544F3 = _id_F2C7B24B4F8544F3 * -1;
    _id_400FC540BBC48AA9 = 1;
  }

  while(_id_DB4AF00B8B0BF7C6 > 0) {
    _id_400FC540BBC48AA9 = _id_400FC540BBC48AA9 + _id_F2C7B24B4F8544F3;
    player setclientomnvar("ui_world_fade", _id_400FC540BBC48AA9);
    _id_DB4AF00B8B0BF7C6--;
    waitframe();
  }

  player setclientomnvar("ui_world_fade", _id_226A6D12E60638A5);
}

fadetoblackforplayer(player, fadetoblack, _id_F69BA8D7B96E8326) {
  player notify("start_fade_to_black");
  player endon("start_fade_to_black");
  player endon("disconnect");
  level endon("game_ended");
  _id_400FC540BBC48AA9 = 0;

  if(istrue(fadetoblack))
    _id_400FC540BBC48AA9 = 1;

  if(!isDefined(_id_F69BA8D7B96E8326) || _id_F69BA8D7B96E8326 == 0) {
    player setclientomnvar("ui_total_fade", _id_400FC540BBC48AA9);
    return;
  }

  _id_226A6D12E60638A5 = _id_400FC540BBC48AA9;
  _id_400FC540BBC48AA9 = 0;
  _id_DB4AF00B8B0BF7C6 = int(_id_F69BA8D7B96E8326 / level.framedurationseconds);
  _id_F2C7B24B4F8544F3 = 1 / _id_DB4AF00B8B0BF7C6;

  if(!istrue(fadetoblack)) {
    _id_F2C7B24B4F8544F3 = _id_F2C7B24B4F8544F3 * -1;
    _id_400FC540BBC48AA9 = 1;
  }

  while(_id_DB4AF00B8B0BF7C6 > 0) {
    _id_400FC540BBC48AA9 = _id_400FC540BBC48AA9 + _id_F2C7B24B4F8544F3;
    player setclientomnvar("ui_total_fade", _id_400FC540BBC48AA9);
    _id_DB4AF00B8B0BF7C6--;
    waitframe();
  }

  player setclientomnvar("ui_total_fade", _id_226A6D12E60638A5);
  player notify("finish_fade_to_black");
}

gettimesincegamestart() {
  return [[scripts\cp_mp\utility\script_utility::getsharedfunc("game_utility", "getTimeSinceGameStart")]]();
}

startkeyearning() {
  if(isbot(self)) {
    return;
  }
  if(isDefined(self.reportchallengeuserevent_done)) {
    return;
  }
  if(!istrue(level.playerxpenabled)) {
    return;
  }
  if(istrue(scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("br", "isInstancedSpace"))) {
    return;
  }
  _id_8283EE79FFF791BE = int(getbattlepassxpultipliertotal() * 100);
  self _meth_DB073176839D77FB("109", [32, 1, 83, getplaylistid(), 113, _id_8283EE79FFF791BE, 120, _func_4F9373A1227DB35C()]);
  self.reportchallengeuserevent_done = 0;
}

stopkeyearning(winner) {
  if(!isDefined(self)) {
    return;
  }
  if(isbot(self)) {
    return;
  }
  if(istrue(self.reportchallengeuserevent_done)) {
    return;
  }
  if(!istrue(level.playerxpenabled)) {
    return;
  }
  result = 0;

  if(istrue(self.disconnecting) && !isDefined(self.connectedpostgame))
    result = 2;

  if(!isDefined(winner)) {}

  if(isDefined(winner)) {
    if(level.teambased) {
      if(winner == "eliminated")
        result = 4;
      else if(winner == "tie")
        result = 3;
      else if(isDefined(self.pers["team"]) && self.pers["team"] == winner)
        result = 1;
      else if(isDefined(self.pers["team"]) && self.pers["team"] != winner)
        result = 2;
    } else if(isDefined(self.connectedpostgame))
      result = 0;
    else if(!isDefined(self.timeplayed) || self.timeplayed["total"] < 1 || self.pers["participation"] < 1)
      result = 0;
    else if(!istrue(self.pers["hasDoneAnyCombat"]))
      result = 0;
    else if(!isDefined(level.placement))
      result = 0;
    else if(!isPlayer(winner) && winner == "eliminated")
      result = 4;
    else {
      _id_7C6311737CB7A0B2 = 0;

      for(_id_3EB36C9F2F1A8E92 = 0; _id_3EB36C9F2F1A8E92 < min(level.placement["all"].size, 3); _id_3EB36C9F2F1A8E92++) {
        if(level.placement["all"][_id_3EB36C9F2F1A8E92] != self) {
          continue;
        }
        _id_7C6311737CB7A0B2 = 1;
      }

      if(_id_7C6311737CB7A0B2)
        result = 1;
      else
        result = 2;
    }
  }

  scripts\cp_mp\challenges::_id_B5929663421247FA(self, result, winner);
  self reportchallengeuserevent("death", 0);
  self.reportchallengeuserevent_done = 1;
}

_visionsetnakedforplayer(_id_FC0043E95242D5CB, _id_647B7CD7ECE0574A) {
  if(_id_FC0043E95242D5CB == "") {
    self visionsetnakedforplayer(_id_FC0043E95242D5CB, _id_647B7CD7ECE0574A);

    if(isDefined(self.activevisionsetlist))
      self.activevisionsetlist = undefined;

    return;
  }

  if(!isDefined(_id_647B7CD7ECE0574A))
    _id_647B7CD7ECE0574A = 0;

  if(!isDefined(self.activevisionsetlist))
    self.activevisionsetlist = [];

  if(!isDefined(self.activevisionsetlist[_id_FC0043E95242D5CB]))
    self.activevisionsetlist[_id_FC0043E95242D5CB] = 1;
  else
    self.activevisionsetlist[_id_FC0043E95242D5CB]++;

  if(self.activevisionsetlist[_id_FC0043E95242D5CB] == 1)
    self visionsetnakedforplayer(_id_FC0043E95242D5CB, _id_647B7CD7ECE0574A);
}

_visionunsetnakedforplayer(_id_FC0043E95242D5CB) {
  self endon("disconnect");
  level endon("game_ended");
  self.activevisionsetlist[_id_FC0043E95242D5CB]--;

  if(self.activevisionsetlist[_id_FC0043E95242D5CB] == 0) {
    _id_BFD32F432F9DACCF = [];

    foreach(_id_B830AB0B24E02BA3, _id_0C901FC1C126661A in self.activevisionsetlist) {
      if(_id_B830AB0B24E02BA3 == _id_FC0043E95242D5CB) {
        continue;
      }
      _id_BFD32F432F9DACCF[_id_B830AB0B24E02BA3] = _id_0C901FC1C126661A;
    }

    self.activevisionsetlist = _id_BFD32F432F9DACCF;
    self visionsetnakedforplayer("", 0);

    foreach(_id_B830AB0B24E02BA3, _id_0C901FC1C126661A in _id_BFD32F432F9DACCF)
    self visionsetnakedforplayer(_id_B830AB0B24E02BA3, level.framedurationseconds);
  }
}

removematchingents_bymodel(name, _id_4732C617E87C7C9D) {
  ents = getEntArray();

  foreach(ent in ents) {
    if(isDefined(ent.model) && ent.model == name) {
      if(istrue(_id_4732C617E87C7C9D) && isDefined(ent.target))
        removematchingents_bykey(ent.target, "targetname");

      ent delete();
    }
  }
}

removematchingents_bycodeclassname(name) {
  ents = getEntArray();

  foreach(ent in ents) {
    if(isDefined(ent.code_classname) && ent.code_classname == name)
      ent delete();
  }
}

removematchingents_byclassname(name) {
  ents = getEntArray();

  foreach(ent in ents) {
    if(isDefined(ent.classname) && ent.classname == name)
      ent delete();
  }
}

removematchingents_bykey(name, key) {
  ents = getEntArray(name, key);

  foreach(ent in ents)
  ent delete();
}

initchallengeandeventglobals() {
  _id_584994FAB4A8712B = spawnStruct();
  level.challengeandeventglobals = _id_584994FAB4A8712B;
  _id_584994FAB4A8712B.game_type_col = [];
  _id_584994FAB4A8712B.game_type_col["missions"] = 2;
  _id_584994FAB4A8712B.game_type_col["dm"] = 5;
  _id_584994FAB4A8712B.game_type_col["war"] = 6;
  _id_584994FAB4A8712B.game_type_col["sd"] = 7;
  _id_584994FAB4A8712B.game_type_col["dom"] = 8;
  _id_584994FAB4A8712B.game_type_col["conf"] = 9;
  _id_584994FAB4A8712B.game_type_col["sr"] = 10;
  _id_584994FAB4A8712B.game_type_col["grind"] = 11;
  _id_584994FAB4A8712B.game_type_col["ball"] = 12;
  _id_584994FAB4A8712B.game_type_col["infect"] = 13;
  _id_584994FAB4A8712B.game_type_col["tjugg"] = 14;
  _id_584994FAB4A8712B.game_type_col["gun"] = 15;
  _id_584994FAB4A8712B.game_type_col["grnd"] = 16;
  _id_584994FAB4A8712B.game_type_col["siege"] = 17;
  _id_584994FAB4A8712B.game_type_col["koth"] = 18;
  _id_584994FAB4A8712B.game_type_col["ctf"] = 19;
  _id_584994FAB4A8712B.game_type_col["dd"] = 20;
  _id_584994FAB4A8712B.game_type_col["tdef"] = 21;
  _id_584994FAB4A8712B.game_type_col["front"] = 22;
  _id_584994FAB4A8712B.game_type_col["cmd"] = 23;
  _id_584994FAB4A8712B.game_type_col["br"] = 24;
  _id_584994FAB4A8712B.game_type_col["arena"] = 25;
  _id_584994FAB4A8712B.game_type_col["cyber"] = 26;
  _id_584994FAB4A8712B.game_type_col["rush"] = 27;
  _id_584994FAB4A8712B.game_type_col["esc"] = 28;
  _id_584994FAB4A8712B.game_type_col["vip"] = 29;
  _id_584994FAB4A8712B.game_type_col["btm"] = 30;
  _id_584994FAB4A8712B.game_type_col["rugby"] = 31;
  _id_584994FAB4A8712B.game_type_col["arm"] = 32;
  _id_584994FAB4A8712B.game_type_col["mtmc"] = 33;
  _id_584994FAB4A8712B.game_type_col["snatch"] = 34;
  _id_584994FAB4A8712B.game_type_col["hq"] = 35;
  _id_584994FAB4A8712B.game_type_col["defcon"] = 36;
  _id_584994FAB4A8712B.game_type_col["pill"] = 37;
  _id_584994FAB4A8712B.game_type_col["blitz"] = 38;
  _id_584994FAB4A8712B.game_type_col["brm"] = 39;
  _id_584994FAB4A8712B.game_type_col["hvt"] = 40;
  _id_584994FAB4A8712B.game_type_col["trial"] = 41;
  _id_584994FAB4A8712B.game_type_col["brtdm"] = 44;
  _id_584994FAB4A8712B.game_type_col["oic"] = 45;
  _id_584994FAB4A8712B.game_type_col["ko"] = 46;
  _id_584994FAB4A8712B.game_type_col["risk"] = 47;
  _id_584994FAB4A8712B.game_type_col["hstg"] = 48;
  _id_584994FAB4A8712B.game_type_col["fr"] = 49;
  _id_584994FAB4A8712B.game_type_col["gwbomb"] = 50;
  _id_584994FAB4A8712B.game_type_col["rescue"] = 51;
  _id_584994FAB4A8712B.game_type_col["zm_rb"] = 54;
  _id_584994FAB4A8712B.game_type_col["gwai"] = 55;
  _id_584994FAB4A8712B.game_type_col["control"] = 56;
  _id_584994FAB4A8712B.game_type_col["ob"] = 57;
  _id_584994FAB4A8712B.game_type_col["benchmark"] = 58;
  _id_584994FAB4A8712B.game_type_col["ballmode"] = 59;
  _id_584994FAB4A8712B.game_type_col["bounty"] = 60;
  _id_584994FAB4A8712B.game_type_col["brtdm_mgl"] = 61;
  _id_584994FAB4A8712B.game_type_col["conflict"] = 62;
}

_id_6B6B6273F8180522(_id_E6F187BCB4B1648E, origin, radius, _id_74526F264CEE0949) {
  if(isDefined(origin))
    self.mapcircle = _func_DC11C1CAFFE56E16(_id_E6F187BCB4B1648E, origin[0], origin[1], radius, _id_74526F264CEE0949);
  else
    self.mapcircle = _func_DC11C1CAFFE56E16(_id_E6F187BCB4B1648E, undefined, undefined, radius, _id_74526F264CEE0949);

  _id_04EAF685BC40A3B9();
}

_id_6E148C8DA2E4DB13(_id_A9706ADAF7C52E27) {
  if(_id_ACAA75CA8754452E())
    self.mapcircle.origin = (_id_A9706ADAF7C52E27[0], _id_A9706ADAF7C52E27[1], self.mapcircle.origin[2]);
}

_id_6A52FD9D448DF322(_id_DC6CBFDA5CAFD043) {
  if(_id_ACAA75CA8754452E())
    self.mapcircle _meth_9A27BB9750C77935(_id_DC6CBFDA5CAFD043);
}

_id_6988310081DE7B45() {
  if(_id_ACAA75CA8754452E())
    self.mapcircle show();
}

_id_04EAF685BC40A3B9() {
  if(_id_ACAA75CA8754452E())
    self.mapcircle hide();
}

_id_CFD53C8F6878014F(player) {
  if(_id_ACAA75CA8754452E())
    self.mapcircle showtoplayer(player);
}

_id_D7D113D56EF0EF5B(player) {
  if(_id_ACAA75CA8754452E())
    self.mapcircle hidefromplayer(player);
}

_id_4584AD1C0E2C58EC(_id_A66785EDEC9E567B) {
  if(_id_ACAA75CA8754452E())
    self.mapcircle.origin = (self.mapcircle.origin[0], self.mapcircle.origin[1], _id_A66785EDEC9E567B);
}

_id_AF5604CE591768E1() {
  if(_id_ACAA75CA8754452E())
    self.mapcircle delete();
}

_id_D9583306C5A171E4() {
  _id_2A73DEE08DD771A7 = (0, 0, 0);

  if(_id_ACAA75CA8754452E())
    _id_2A73DEE08DD771A7 = self.mapcircle.origin;

  return _id_2A73DEE08DD771A7;
}

_id_ACAA75CA8754452E() {
  return isDefined(self.mapcircle);
}

_id_DB48978D7206BD41(_id_E6F187BCB4B1648E, origin, radius, _id_A567A9249DA5E49B) {
  self._id_616C7052C6C2D9B9 = _func_DC11C1CAFFE56E16(_id_E6F187BCB4B1648E, origin[0], origin[1], radius, _id_A567A9249DA5E49B);
  _id_8D43E0A01E766078();
}

_id_1D0718FB3B210270(_id_A9706ADAF7C52E27) {
  if(_id_28F9DFE13002DBB9())
    self._id_616C7052C6C2D9B9.origin = (_id_A9706ADAF7C52E27[0], _id_A9706ADAF7C52E27[1], self._id_616C7052C6C2D9B9.origin[2]);
}

_id_6C06A9A26AF579E8() {
  if(_id_28F9DFE13002DBB9())
    self._id_616C7052C6C2D9B9 show();
}

_id_8D43E0A01E766078() {
  if(_id_28F9DFE13002DBB9())
    self._id_616C7052C6C2D9B9 hide();
}

_id_FAB8EC5FEB7D4C9C(player) {
  if(_id_28F9DFE13002DBB9())
    self._id_616C7052C6C2D9B9 showtoplayer(player);
}

_id_74C4CD59F26EB9EC(player) {
  if(_id_28F9DFE13002DBB9())
    self._id_616C7052C6C2D9B9 hidefromplayer(player);
}

_id_AE2BFAA147F91CA5(_id_A66785EDEC9E567B) {
  if(_id_28F9DFE13002DBB9())
    self._id_616C7052C6C2D9B9.origin = (self._id_616C7052C6C2D9B9.origin[0], self._id_616C7052C6C2D9B9.origin[1], _id_A66785EDEC9E567B);
}

_id_F630402329582086() {
  if(_id_28F9DFE13002DBB9())
    self._id_616C7052C6C2D9B9 delete();
}

_id_DCC52394E28DAFAD() {
  _id_2A73DEE08DD771A7 = (0, 0, 0);

  if(_id_28F9DFE13002DBB9())
    _id_2A73DEE08DD771A7 = self._id_616C7052C6C2D9B9.origin;

  return _id_2A73DEE08DD771A7;
}

_id_28F9DFE13002DBB9() {
  return isDefined(self._id_616C7052C6C2D9B9);
}

isaigameparticipant(ent) {
  if(isagent(ent) && istrue(ent.agent_gameparticipant))
    return 1;

  if(isbot(ent))
    return 1;

  return 0;
}

isgameparticipant(ent) {
  if(isaigameparticipant(ent))
    return 1;

  if(isPlayer(ent))
    return 1;

  return 0;
}

addtoparticipantsarray() {
  level.participants[level.participants.size] = self;
}

removefromparticipantsarray() {
  found = 0;

  for(_id_F90358454413407F = 0; _id_F90358454413407F < level.participants.size; _id_F90358454413407F++) {
    if(level.participants[_id_F90358454413407F] == self) {
      for(found = 1; _id_F90358454413407F < level.participants.size - 1; _id_F90358454413407F++)
        level.participants[_id_F90358454413407F] = level.participants[_id_F90358454413407F + 1];

      level.participants[_id_F90358454413407F] = undefined;
      break;
    }
  }
}

addtocharactersarray() {
  level.characters[level.characters.size] = self;
}

removefromcharactersarray() {
  found = 0;

  for(_id_F90358454413407F = 0; _id_F90358454413407F < level.characters.size; _id_F90358454413407F++) {
    if(level.characters[_id_F90358454413407F] == self) {
      for(found = 1; _id_F90358454413407F < level.characters.size - 1; _id_F90358454413407F++)
        level.characters[_id_F90358454413407F] = level.characters[_id_F90358454413407F + 1];

      level.characters[_id_F90358454413407F] = undefined;
      break;
    }
  }
}

_id_E8D365DE417A3E14() {
  if(!isDefined(level.mines))
    level.mines = [];

  if(!isDefined(level.projectilekillstreaks))
    level.projectilekillstreaks = [];

  if(!isDefined(level._id_2D97AFEAD10E4548))
    level._id_2D97AFEAD10E4548 = 0;

  for(;;) {
    level.grenades = getEntArray("grenade", "classname");
    level.missiles = getEntArray("rocket", "classname");
    level._id_715AA7F8DE54C394 = undefined;
    level._id_E7E46E0E18411A5B = undefined;
    waitframe();
  }
}

_id_F5E8B13ACC5B4E24() {
  if(isDefined(level._id_715AA7F8DE54C394)) {
    return;
  }
  level._id_715AA7F8DE54C394 = _id_8E7FB050EC31DCB1(400);
}

_id_9ED62E98A39D59EB() {
  if(isDefined(level._id_E7E46E0E18411A5B)) {
    return;
  }
  level._id_E7E46E0E18411A5B = _id_8E7FB050EC31DCB1(400);
}

_id_8E7FB050EC31DCB1(_id_A61C75B156FC1EE0) {
  _id_C70B9ADBC218860A = [];
  _id_C70B9ADBC218860A[0] = level.grenades;
  _id_C70B9ADBC218860A[1] = level.missiles;
  _id_C70B9ADBC218860A[2] = level.mines;
  _id_C70B9ADBC218860A[3] = level.projectilekillstreaks;
  _id_F5BA0D51B1831F07 = [];

  foreach(array in _id_C70B9ADBC218860A) {
    foreach(entity in array) {
      if(isent(entity))
        _id_F5BA0D51B1831F07[entity getentitynumber()] = entity;
    }
  }

  return scripts\engine\utility::_id_21A6A1C613B50A28(_id_F5BA0D51B1831F07, _id_A61C75B156FC1EE0);
}

game_utility_init() {
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("game_utility", "init")]]();
  _id_480C0D1316D8D13C = getdvarint("online_battle_xpscale");

  if(_id_480C0D1316D8D13C > 4 || _id_480C0D1316D8D13C < 0)
    exitlevel(0);

  level addbattlepassxpmultiplier(_id_480C0D1316D8D13C, "online_battle_xpscale_dvar");
}

_id_EA9801BFF6CCF12A() {
  _id_3B64EB40368C1450::_id_7372010B17478CDC("player_for_spawn_logic", 1, 0, "$self", ::_id_A3D2FE29DC7C7C4C, "$value");
}

_id_A3D2FE29DC7C7C4C(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  self ignorecharacterduringspawnselection(!_id_77C892C2CEC7A0EB);
}

getbattlepassxpultipliertotal() {
  _id_99C98EF413B2A3A4 = level getbattlepassxpmultiplier();
  _id_9A43FE5A154B7BC8 = 1.0;
  _id_018648EB9853B55B = getdvarint("dvar_A429AB6EDB6E3023", 0) == 0;

  if((_id_99C98EF413B2A3A4 > 4 || _id_99C98EF413B2A3A4 < 0) && _id_018648EB9853B55B)
    exitlevel(0);

  if(self isbnetigrplayer())
    _id_9A43FE5A154B7BC8 = getbnetigrbattlepassxpmultiplier(self);

  _id_62563A3AB1624A5A = _id_99C98EF413B2A3A4 * _id_9A43FE5A154B7BC8;
  return _id_62563A3AB1624A5A;
}

getbattlepassxpmultiplier() {
  if(!isDefined(self.battlepassxpmultipliers))
    return 1.0;

  _id_7662D3C556FCCB56 = 1.0;

  foreach(modifier in self.battlepassxpmultipliers) {
    if(!isDefined(modifier)) {
      continue;
    }
    _id_7662D3C556FCCB56 = _id_7662D3C556FCCB56 * modifier;
  }

  return _id_7662D3C556FCCB56;
}

addbattlepassxpmultiplier(_id_98EA5AFB293A76A2, ref) {
  _id_427D7621553DFFF6 = 4 / level getbattlepassxpmultiplier();

  if(_id_98EA5AFB293A76A2 > _id_427D7621553DFFF6) {
    return;
  }
  if(!isDefined(self.battlepassxpmultipliers))
    self.battlepassxpmultipliers = [];

  if(isDefined(self.battlepassxpmultipliers[ref]))
    self.battlepassxpmultipliers[ref] = max(self.battlepassxpmultipliers[ref], _id_98EA5AFB293A76A2);
  else
    self.battlepassxpmultipliers[ref] = _id_98EA5AFB293A76A2;
}

_id_E3EF0908B595E8E1() {
  _id_85D8DAEAC55B1742 = getplaylistid();
  xpscale = getdvarint("online_mp_xpscale");

  if(!isDefined(_id_85D8DAEAC55B1742))
    return xpscale;

  _id_D3448F1D7D264387 = getDvar("online_playerxp_playlists", "");
  _id_D3448F1D7D264387 = strtok(_id_D3448F1D7D264387, ",");
  _id_C89CF11E0615DEBF = 0;

  foreach(_id_9B912FBD24510C8F in _id_D3448F1D7D264387) {
    if(int(_id_9B912FBD24510C8F) == _id_85D8DAEAC55B1742) {
      _id_C89CF11E0615DEBF = 1;
      break;
    }
  }

  if(xpscale >= 2 || _id_C89CF11E0615DEBF)
    return int(max(xpscale, 2));

  return xpscale;
}