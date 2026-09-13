/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_a96d7b74342a88f.gsc
***********************************************/

setupcallbacks() {
  if(getdvarint("dvar_B7AA1FDC2FFB47E8", 0) == 0 || istrue(level._id_EC2FB549B15AD827) || istrue(level._id_77907D733ABE8B63)) {
    _id_4C770A9A4AD7659C::_id_52004C7A02FCFFD6("player_connect", ::_id_66D05C31053F7C8F);
    return;
  }

  _id_4C770A9A4AD7659C::_id_52004C7A02FCFFD6("game_ended", ::ongameended);
  _id_4C770A9A4AD7659C::_id_52004C7A02FCFFD6("player_disconnect", ::onplayerdisconnect);
  _id_4C770A9A4AD7659C::_id_52004C7A02FCFFD6("player_connect", ::onplayerconnect);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    level.adddroponplayerdeath = ::_id_3354140884867D15;
    level _id_4C770A9A4AD7659C::_id_52004C7A02FCFFD6("on_ai_killed", ::_id_C8958695ACF2E1F1);
    scripts\cp_mp\utility\script_utility::registersharedfunc("br_loot_soul_trophy", "onUFODeath", ::_id_5B296896E8119568);
  } else {
    _id_4C770A9A4AD7659C::_id_52004C7A02FCFFD6("player_death", ::_id_DDCB9338C5CD1D29);
    _id_48814951E916AF89::_id_93ADD0B65DB9F722(::_id_A1FFA457F63D28FD);
  }

  scripts\cp_mp\utility\script_utility::registersharedfunc("br_loot_cache", "opened", ::_id_AA629573B9B452B7);
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_loot_cache_lege", "opened", ::_id_AA629573B9B452B7);
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_loot_cache", "spawnLoot", ::_id_735A4FD352102F67);
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_loot_cache_lege", "spawnLoot", ::_id_735A4FD352102F67);
  scripts\cp_mp\utility\script_utility::registersharedfunc(38901, "pickedUp", ::_id_B468EE3A4AAD8F93);
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_loot_soul_trophy", "onGhostDeath", ::_id_10BF4CAE77D3576F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_loot_soul_trophy", "ghostFailTrophyDrop", ::_id_DFE6251B1FC30A57);
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_loot_soul_trophy", "bankTrophies", ::_id_439F0781DBD8A339);
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_loot_soul_trophy", "canGatherTrophies", ::_id_2A504551561A812C);
  scripts\cp_mp\utility\script_utility::registersharedfunc("brloot_haunting_soul", "delete", ::_id_C2FEB4D9932DFDCC);
  scripts\cp_mp\utility\script_utility::registersharedfunc("iw9_mp_haunting_soul_entityless", "delete", ::_id_C2FEB4D9932DFDCC);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("brloot_haunting_soul", ::_id_199F02943420E747);
  scripts\engine\scriptable::scriptable_addautousecallback(::_id_76C38F4AF5D006EA);
  _id_3FF084F114B7F6C9::_id_F3D757808130BAC4(::_id_3D8E31FA3CC6EEE5);

  if(isDefined(data())) {
    return;
  }
  data = spawnStruct();
  data.dropcount = getdvarint("dvar_9AEFDB4FCE0D657C", 1);
  data.maxcount = getdvarint("dvar_7FE601AA0104AAD0", 6);
  data._id_DBAD26986EC8F069 = getdvarint("dvar_77F1E2983668B905", 1);
  data._id_A082B242B6FAE420 = 200;
  data._id_3F2E2CB7B92E01EF = getdvarint("dvar_43DBD84D9A8AF5FB", 0);
  data._id_99F17B3789FBC400 = getdvarint("dvar_638ABF3FE16AA9EC", 51);
  data._id_4AA589B5856F979B = getdvarint("dvar_4F3539C1D48C151F", 5);
  data.triggers = [];
  data._id_577A17D83577E3E6 = [];
  data._id_DE335D425AB8C9B0 = [];
  data._id_EB3BE366ABC17855 = [];
  data._id_5C0ED12BDB833AD9 = [];
  data._id_09AE8FE3B8B9628A = [];
  data._id_09AE8FE3B8B9628A["boss"] = getdvarint("dvar_866E4194E44E51DA", 5);
  data._id_09AE8FE3B8B9628A["minion"] = getdvarint("dvar_DC6295AB46095DE5", 1);
  data._id_09AE8FE3B8B9628A["ai"] = getdvarint("dvar_ED7E2CC605FC69F5", 0);
  data._id_09AE8FE3B8B9628A["player"] = getdvarint("dvar_F64AA3EB6FB048DA", 0);
  data._id_09AE8FE3B8B9628A["ghost"] = getdvarint("dvar_F64AA3EB6FB048DA", 1);
  data._id_39D9404B6089E83A = [];
  data._id_39D9404B6089E83A["butcherBoss"] = getdvarint("dvar_F08C79CC621951F8", 5);
  data._id_39D9404B6089E83A["mummyBoss"] = getdvarint("dvar_FC0646AE7CA7925C", 5);
  data._id_39D9404B6089E83A["swampBoss"] = getdvarint("dvar_9AA26F5DAB98300D", 2);
  data._id_39D9404B6089E83A["ufo"] = getdvarint("dvar_DFB9AA4B20D5923D", 5);
  data._id_39D9404B6089E83A["jugg"] = getdvarint("dvar_F41A6EF7AC4A77B2", 5);
  data._id_39D9404B6089E83A["chemistBoss"] = getdvarint("dvar_960E16E548A45FB4", 5);
  data._id_39D9404B6089E83A["ratBoss"] = getdvarint("dvar_8549DC399023D794", 5);
  data._id_39D9404B6089E83A["trapperBoss"] = getdvarint("dvar_8153EFC3C8A8ADF7", 5);
  data._id_39D9404B6089E83A[" pyroBoss"] = getdvarint("dvar_BF4FD92A4431E0EB", 5);
  data._id_D169F943AA5A10EF["mummyBossMinion"] = getdvarint("dvar_F949B5B8E85A55A6", 2);
  data._id_D169F943AA5A10EF["zombie"] = getdvarint("dvar_D65D169787E16F05", 2);
  data._id_D169F943AA5A10EF["affected"] = getdvarint("dvar_CBD70C7C398A196F", 1);
  data._id_396A802F615CEBB0 = getdvarint("dvar_8A7F46D7D139B66C", 1);
  data._id_B5858D9A2232E324 = [];
  data._id_B5858D9A2232E324["ai"] = getdvarint("dvar_F0F1ABE0A72E30AF", 10);
  data._id_B5858D9A2232E324["cache"] = getdvarint("dvar_C17EB103B46231E5", 20);
  data._id_B5858D9A2232E324["zombie"] = getdvarint("dvar_6E15B3C273A756AF", 20);
  data._id_B5858D9A2232E324["mummyBossMinion"] = getdvarint("dvar_089CD793684FC454", 25);
  data._id_B5858D9A2232E324["ghost"] = getdvarint("dvar_58BF85EC241291A2", 100);
  data._id_B5858D9A2232E324["affected"] = getdvarint("dvar_F2CCFDB7F6EDA0D1", 30);
  game["soulCollecting"] = data;
}

_id_DDCB9338C5CD1D29(_id_642470E1ABC1BBF9) {
  if(!isDefined(self)) {
    return;
  }
  if(!_id_1DC73C36B8CB3ECA()) {
    return;
  }
  entnum = self getentitynumber();

  if(!isDefined(entnum)) {
    return;
  }
  if(isDefined(data().triggers[entnum]))
    data().triggers[entnum] thread cleanup(0);

  if(!isDefined(_id_642470E1ABC1BBF9) || !isvalidplayer(_id_642470E1ABC1BBF9.attacker)) {
    return;
  }
  if(_id_642470E1ABC1BBF9.attacker == self) {
    return;
  }
  if(level.teambased && scripts\engine\utility::is_equal(self.team, _id_642470E1ABC1BBF9.attacker.team)) {
    return;
  }
  if(!_id_642470E1ABC1BBF9.attacker _id_2A504551561A812C()) {
    return;
  }
  attackerentnum = _id_642470E1ABC1BBF9.attacker getentitynumber();

  if(!isDefined(data()._id_5C0ED12BDB833AD9[entnum]))
    data()._id_5C0ED12BDB833AD9[entnum] = [];

  if(isDefined(data()._id_5C0ED12BDB833AD9[entnum][attackerentnum])) {
    return;
  }
  _id_F20C9943BA2BA620 = data().dropcount;
  _id_F20C9943BA2BA620 = _id_F20C9943BA2BA620 + _id_2ACC835899C21624(_id_642470E1ABC1BBF9.objweapon, "player");
  _id_F20C9943BA2BA620 = _id_F7D641028CE25B8B(_id_F20C9943BA2BA620, _id_642470E1ABC1BBF9.attacker, _id_642470E1ABC1BBF9.meansofdeath, _id_642470E1ABC1BBF9.objweapon, self.origin + (0, 0, 40));
  _id_CFB0BD180308A4BA(_id_F20C9943BA2BA620, self, self.origin, entnum, _id_642470E1ABC1BBF9.attacker, "player_kill");
}

_id_2ACC835899C21624(objweapon, type) {
  return scripts\engine\utility::ter_op(_id_0CBB0697DE4C5728::_id_D8804135C49FD481(objweapon), data()._id_09AE8FE3B8B9628A[type], 0);
}

_id_10BF4CAE77D3576F(attacker, smeansofdeath, objweapon, targetpos, _id_3CEF84D10F889AEC) {
  if(!isDefined(data())) {
    return;
  }
  if(!_id_1DC73C36B8CB3ECA()) {
    return;
  }
  if(randomint(100) > data()._id_B5858D9A2232E324["ghost"]) {
    return;
  }
  dropcount = data()._id_396A802F615CEBB0;
  dropcount = dropcount + _id_2ACC835899C21624(objweapon, "ghost");
  dropcount = _id_F7D641028CE25B8B(dropcount, attacker, smeansofdeath, objweapon, targetpos);
  waitframe();
  data()._id_A082B242B6FAE420 = data()._id_A082B242B6FAE420 + 1;
  _id_CFB0BD180308A4BA(dropcount, _id_3CEF84D10F889AEC, targetpos, data()._id_A082B242B6FAE420, attacker, "ai_kill_ghost", _id_7E52B56769FA7774::_id_7B9F3966A7A42003(), 1, 1);
}

_id_F7D641028CE25B8B(dropcount, attacker, smeansofdeath, objweapon, targetpos, _id_945B82491D91C210) {
  if(isvalidplayer(attacker)) {
    _id_FD26F60CC35B3E73 = attacker _id_366E874F71B41311(dropcount, _id_945B82491D91C210);
    return _id_7342D9B11A2C7E61::_id_D5489F0F94DB01E6(dropcount, _id_FD26F60CC35B3E73, attacker, targetpos);
  } else
    return dropcount;
}

_id_366E874F71B41311(dropcount, _id_945B82491D91C210) {
  if(istrue(_id_945B82491D91C210)) {
    _id_FD26F60CC35B3E73 = int(ceil(data()._id_99F17B3789FBC400 / 100 * dropcount));
    _id_FD26F60CC35B3E73 = int(min(_id_FD26F60CC35B3E73, data()._id_4AA589B5856F979B));
  } else
    _id_FD26F60CC35B3E73 = dropcount;

  _id_FD26F60CC35B3E73 = int(min(_id_FD26F60CC35B3E73, data().maxcount - _id_644B35BC4F205DCB()));
  return _id_FD26F60CC35B3E73;
}

_id_DFE6251B1FC30A57() {
  if(!isDefined(self)) {
    return;
  }
  data()._id_A082B242B6FAE420 = data()._id_A082B242B6FAE420 + 1;
  _id_CFB0BD180308A4BA(1, self, self.origin, data()._id_A082B242B6FAE420, undefined, "loot", _id_7E52B56769FA7774::_id_7B9F3966A7A42003());
}

_id_3354140884867D15(dropstruct, attacker, meansofdeath, objweapon) {
  if(!isDefined(self)) {
    return;
  }
  if(!_id_1DC73C36B8CB3ECA()) {
    return;
  }
  if(isDefined(self.c130)) {
    return;
  }
  if(_id_2CEDCC356F1B9FC8::isplayeringulag()) {
    return;
  }
  entnum = self getentitynumber();

  if(!isDefined(entnum)) {
    return;
  }
  if(isDefined(data()._id_577A17D83577E3E6[entnum])) {
    foreach(trophy in data()._id_577A17D83577E3E6[entnum])
    trophy thread _id_5179A5DDCA15A921();
  }

  if(isvalidplayer(attacker) && _id_03E9ED9D398B432E()) {
    if(!isDefined(data()._id_5C0ED12BDB833AD9[entnum]))
      data()._id_5C0ED12BDB833AD9[entnum] = [];

    if(isDefined(data()._id_5C0ED12BDB833AD9[entnum][attacker.team]))
      return;
  }

  _id_F20C9943BA2BA620 = data().dropcount;
  _id_F20C9943BA2BA620 = _id_F20C9943BA2BA620 + _id_2ACC835899C21624(objweapon, "player");
  _id_F20C9943BA2BA620 = _id_F7D641028CE25B8B(_id_F20C9943BA2BA620, attacker, meansofdeath, objweapon, self.origin + (0, 0, 40));
  _id_CFB0BD180308A4BA(_id_F20C9943BA2BA620, self, self.origin, entnum, attacker, "player_kill", dropstruct);
}

onplayerdisconnect(params) {
  if(!isvalidplayer(self)) {
    return;
  }
  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    self dlog_recordplayerevent("dlog_event_scorpion_not_banked", ["count", scripts\engine\utility::_id_53C4C53197386572(data()._id_DE335D425AB8C9B0[self getentitynumber()], 0)]);
    self setplayerdata("mp", "s6EarnedSouls", 0);
  } else
    _id_4C65595E68DB285C();
}

onplayerconnect(params) {
  if(!isvalidplayer(self)) {
    return;
  }
  self setclientomnvar("ui_scorpion_trophies_collected", scripts\engine\utility::_id_53C4C53197386572(data()._id_DE335D425AB8C9B0[self getentitynumber()], 0));
  self setplayerdata("mp", "s6EarnedSouls", 0);
}

_id_66D05C31053F7C8F(params) {
  if(!isvalidplayer(self)) {
    return;
  }
  self setplayerdata("mp", "s6EarnedSouls", 0);
}

_id_C8958695ACF2E1F1(_id_D27680FF86693F5C) {
  attacker = _id_D27680FF86693F5C.eattacker;

  if(isDefined(attacker) && !isPlayer(_id_D27680FF86693F5C.eattacker))
    attacker = attacker.owner;

  if(!isPlayer(attacker)) {
    return;
  }
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  _id_7CD4E0954F3B9A74 = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(self, "subcategory");

  if(isDefined(self.agent_type) && issubstr(self.agent_type, "affected"))
    _id_7CD4E0954F3B9A74 = "affected";

  if(isDefined(data()._id_39D9404B6089E83A[_id_7CD4E0954F3B9A74]))
    _id_5B296896E8119568(self, attacker, dropstruct, _id_7CD4E0954F3B9A74, _id_D27680FF86693F5C.sweapon, "boss", _id_D27680FF86693F5C.smeansofdeath);
  else if(isDefined(data()._id_D169F943AA5A10EF[_id_7CD4E0954F3B9A74]))
    _id_5B296896E8119568(self, attacker, dropstruct, _id_7CD4E0954F3B9A74, _id_D27680FF86693F5C.sweapon, "minion", _id_D27680FF86693F5C.smeansofdeath);
  else
    _id_A1FFA457F63D28FD(self, attacker, dropstruct, _id_D27680FF86693F5C.sweapon, _id_D27680FF86693F5C.smeansofdeath);
}

_id_5B296896E8119568(agent, attacker, dropstruct, agentname, objweapon, type, meansofdeath) {
  if(randomint(100) > scripts\engine\utility::_id_53C4C53197386572(data()._id_B5858D9A2232E324[agentname], 100)) {
    return;
  }
  dropcount = 0;

  if(type == "boss") {
    dropcount = data()._id_39D9404B6089E83A[agentname];
    _id_945B82491D91C210 = 1;
  } else if(type == "minion") {
    dropcount = data()._id_D169F943AA5A10EF[agentname];
    _id_945B82491D91C210 = 0;
  } else
    return;

  dropcount = dropcount + _id_2ACC835899C21624(objweapon, type);
  dropcount = _id_F7D641028CE25B8B(dropcount, attacker, meansofdeath, objweapon, agent.origin + (0, 0, 40), _id_945B82491D91C210);
  data()._id_A082B242B6FAE420 = data()._id_A082B242B6FAE420 + 1;
  level thread _id_CFB0BD180308A4BA(dropcount, agent, agent.origin, data()._id_A082B242B6FAE420, attacker, "ai_kill_" + agentname, dropstruct, 1, 1, 0.5);
}

_id_A1FFA457F63D28FD(agent, attacker, dropstruct, objweapon, meansofdeath) {
  if(!_id_1DC73C36B8CB3ECA()) {
    return;
  }
  if(data()._id_B5858D9A2232E324["ai"] <= 0) {
    return;
  }
  if(!isvalidplayer(attacker)) {
    return;
  }
  if(!attacker _id_2A504551561A812C()) {
    return;
  }
  if(randomint(100) > data()._id_B5858D9A2232E324["ai"]) {
    return;
  }
  _id_DBAD26986EC8F069 = data()._id_DBAD26986EC8F069;
  _id_DBAD26986EC8F069 = _id_DBAD26986EC8F069 + _id_2ACC835899C21624(objweapon, "ai");
  _id_DBAD26986EC8F069 = _id_F7D641028CE25B8B(_id_DBAD26986EC8F069, attacker, meansofdeath, objweapon, agent.origin + (0, 0, 40));
  data()._id_A082B242B6FAE420 = data()._id_A082B242B6FAE420 + 1;
  level thread _id_CFB0BD180308A4BA(_id_DBAD26986EC8F069, agent, agent.origin, data()._id_A082B242B6FAE420, attacker, "ai_kill_agent", dropstruct, undefined, undefined, 0.5);
}

_id_AA629573B9B452B7(items, opener, _id_64C59C08B4538D72) {
  if(!istrue(_id_64C59C08B4538D72))
    return items;

  if(!_id_1DC73C36B8CB3ECA())
    return items;

  if(!isvalidplayer(opener))
    return items;

  if(!opener _id_2A504551561A812C())
    return items;

  if(randomint(100) > data()._id_B5858D9A2232E324["cache"])
    return items;

  items[items.size] = "brloot_haunting_soul";
  return items;
}

_id_735A4FD352102F67(opener, dropstruct) {
  if(!_id_1DC73C36B8CB3ECA()) {
    return;
  }
  if(!isvalidplayer(opener)) {
    return;
  }
  if(!opener _id_2A504551561A812C()) {
    return;
  }
  if(randomint(100) > data()._id_B5858D9A2232E324["cache"]) {
    return;
  }
  _id_114A9184D249D367 = 1;
  data()._id_A082B242B6FAE420 = data()._id_A082B242B6FAE420 + 1;
  trophies = _id_CFB0BD180308A4BA(_id_114A9184D249D367, self, self.origin, data()._id_A082B242B6FAE420, undefined, "loot", dropstruct);
  return trophies;
}

_id_76C38F4AF5D006EA(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(instance) || !isDefined(instance.type) || instance.type != "brloot_haunting_soul") {
    return;
  }
  _id_199F02943420E747(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61, 1);
}

_id_199F02943420E747(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61, _id_71B664F5AB636333) {
  if(!isDefined(instance) || !isDefined(instance.type) || instance.type != "brloot_haunting_soul") {
    return;
  }
  if(isDefined(instance.team) && instance.team == player.team) {
    if(isDefined(instance._id_926F48790E712666))
      instance._id_926F48790E712666 showsplash("haunting_soul_recovered");

    if(!isDefined(instance._id_926F48790E712666) || instance._id_926F48790E712666 != player)
      player showsplash("haunting_soul_denied");
  } else {
    _id_3F436FCD864C3893 = data()._id_DE335D425AB8C9B0[player getentitynumber()];

    if(isDefined(_id_3F436FCD864C3893) && _id_3F436FCD864C3893 >= data().maxcount) {
      if(!_id_64C6053B5D1A581A(player))
        player scripts\mp\hud_message::showerrormessage("SPLASHES/HAUNTING_SOUL_COLLECTED_MAX");

      return;
    }

    player _id_439F0781DBD8A339(1, scripts\engine\utility::_id_53C4C53197386572(instance._id_5D30E45C6D206A9E, "loot"));

    if(isDefined(instance.team))
      data()._id_5C0ED12BDB833AD9[instance.entnum][player.team] = 1;
  }

  player scripts\common\utility::_id_3677F2BE30FDD581("trophy_effects", "pickup");

  if(!istrue(_id_71B664F5AB636333))
    player thread _id_7E52B56769FA7774::playerplaypickupanim();

  instance thread _id_5179A5DDCA15A921(1);
}

_id_64C6053B5D1A581A(player) {
  if(!isDefined(player._id_DB68A896B15AAA74) || gettime() >= player._id_DB68A896B15AAA74) {
    player._id_DB68A896B15AAA74 = gettime() + 3000;
    return 0;
  }

  return 1;
}

_id_B468EE3A4AAD8F93(scriptable, player) {
  player _id_439F0781DBD8A339(1, "loot");
  player scripts\common\utility::_id_3677F2BE30FDD581("trophy_effects", "pickup");
  return 1;
}

_id_F858675BC65238FE() {
  if(isDefined(self.trigger))
    self.trigger thread cleanup(0);
}

_id_C2FEB4D9932DFDCC() {
  return 1;
}

ongameended(data) {
  foreach(player in level.players)
  player _id_4C65595E68DB285C();
}

_id_CFB0BD180308A4BA(count, from, origin, entnum, attacker, type, dropstruct, _id_EEEBD7263F6EF4FF, _id_C28574AF8B8188BC, _id_6393850CED28F59E) {
  level endon("game_ended");

  if(!isDefined(dropstruct) && scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    return;
  }
  if(count <= 0) {
    return;
  }
  if(isDefined(_id_6393850CED28F59E))
    wait(_id_6393850CED28F59E);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    trophies = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < count; _id_AC0E594AC96AA3A8++) {
      dropangles = scripts\engine\utility::ter_op(istrue(_id_EEEBD7263F6EF4FF), undefined, (0, randomfloat(360), 0));

      if(isDefined(from) && isent(from))
        _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, from.origin + (0, 0, 20), dropangles, from, undefined, undefined, randomfloatrange(25, 40));
      else
        _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, origin, dropangles, undefined, undefined, undefined, randomfloatrange(25, 40), undefined, undefined, undefined, 1);

      trophy = _id_7E52B56769FA7774::spawnpickup("brloot_haunting_soul", _id_CB4FAD49263E20C4, 1, 1);

      if(!isDefined(trophy)) {
        continue;
      }
      trophy.entnum = entnum;
      trophy._id_98D6306F2F5F9E66 = 0;
      trophy._id_5D30E45C6D206A9E = type;
      trophies[trophies.size] = trophy;

      if(isDefined(from) && isent(from) && isPlayer(from)) {
        trophy.team = from.team;
        trophy._id_926F48790E712666 = from;
        data()._id_577A17D83577E3E6[entnum] = scripts\engine\utility::array_add_safe(data()._id_577A17D83577E3E6[entnum], trophy);
      }

      trophy setscriptablepartstate("brloot_haunting_soul", "dropped");
      trophy thread _id_15DE990401BDD484(0);

      if(istrue(_id_C28574AF8B8188BC))
        wait(2 / count);
    }

    return trophies;
  } else {
    _id_22CE7236B68B2334 = [];
    trophies = [];

    if(count > 1) {
      angle = randomfloat(360);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < count; _id_AC0E594AC96AA3A8++) {
        offset = (cos(angle), sin(angle), 0) * 12;
        _id_22CE7236B68B2334[_id_22CE7236B68B2334.size] = offset + origin;
        angle = angle + 360 / count;
      }
    } else
      _id_22CE7236B68B2334[_id_22CE7236B68B2334.size] = origin;

    mover = undefined;

    if(isDefined(from) && isent(from) && isPlayer(from))
      mover = from getmovingplatformparent();

    foreach(spawnpos in _id_22CE7236B68B2334) {
      trophy = spawn("script_model", spawnpos);
      trophy setModel("iw9_mp_haunting_soul_entity");

      if(isDefined(attacker) && isPlayer(attacker))
        trophy showonlytoplayer(attacker);

      trophy setscriptablepartstate("iw9_mp_haunting_soul_entity", "visible");
      trophy._id_98D6306F2F5F9E66 = 1;
      trophy.angles = (0, randomfloat(360), 0);
      trophy rotatevelocity((0, randomfloatrange(45, 135) * scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), 1, -1), 0), 9999);

      if(isDefined(mover))
        trophy linkTo(mover);

      endpos = getgroundposition(trophy.origin, 10) + (0, 0, randomfloatrange(25, 40));
      origin = endpos;
      dist = abs(endpos - spawnpos[2]);
      movetime = dist / 60;
      trophy moveTo(endpos, movetime);
      trophies[trophies.size] = trophy;
    }

    return _id_128EDF2232D31C50(origin, scripts\engine\utility::ter_op(count > 1, 45, 35), entnum, trophies, type, from, mover, attacker);
  }
}

_id_128EDF2232D31C50(origin, radius, entnum, trophies, type, _id_24D90D64DEBEFDD4, mover, attacker) {
  if(isDefined(mover)) {
    trigger = spawn("trigger_radius", origin, 0, radius, 35);
    trigger enablelinkTo();
    trigger linkTo(mover);
    trigger thread _id_1DABBBECF02DD66B(mover);
  } else
    trigger = spawn("noent_volume_trigger_radius", origin, 0, radius, 35);

  trigger._id_182D8860FAC4C70B = trophies;
  trigger.entnum = entnum;
  trigger.type = type;
  trigger._id_24D90D64DEBEFDD4 = _id_24D90D64DEBEFDD4;

  if(isDefined(attacker) && isPlayer(attacker))
    trigger._id_E7C898D742B4BA46 = attacker;

  foreach(trophy in trophies)
  trophy.trigger = trigger;

  trigger thread watchtrigger();
  trigger thread _id_15DE990401BDD484(1);
  data().triggers[entnum] = trigger;
  return trigger;
}

watchtrigger() {
  self endon("remove");

  for(;;) {
    self waittill("trigger", ent);

    if(!isvalidplayer(ent)) {
      continue;
    }
    if(isDefined(self.team) && ent.team == self.team) {
      if(isDefined(self._id_24D90D64DEBEFDD4))
        self._id_24D90D64DEBEFDD4 showsplash("haunting_soul_recovered");

      if(!isDefined(self._id_24D90D64DEBEFDD4) || self._id_24D90D64DEBEFDD4 != ent)
        ent showsplash("haunting_soul_declined");

      thread cleanup(1);
      continue;
    }

    if(!ent _id_2A504551561A812C()) {
      continue;
    }
    if(isDefined(self._id_E7C898D742B4BA46)) {
      if(self._id_E7C898D742B4BA46 != ent) {
        continue;
      }
      data()._id_5C0ED12BDB833AD9[self.entnum][ent getentitynumber()] = 1;
    } else if(isDefined(self.team))
      data()._id_5C0ED12BDB833AD9[self.entnum][ent.team] = 1;

    ent _id_439F0781DBD8A339(self._id_182D8860FAC4C70B.size, self.type);
    ent scripts\common\utility::_id_3677F2BE30FDD581("trophy_effects", "pickup");
    thread cleanup(1);
  }
}

_id_439F0781DBD8A339(num, type) {
  if(!isDefined(data()) || !isDefined(type)) {
    return;
  }
  entnum = self getentitynumber();
  event = undefined;
  aitype = undefined;

  if(type == "loot" || type == "player_kill")
    event = "dlog_event_scorpion_gathered_" + type;
  else if(scripts\engine\utility::string_starts_with(type, "ai_kill")) {
    event = "dlog_event_scorpion_gathered_ai_kill";
    aitype = getsubstr(type, 8);
  }

  if(!isDefined(data()._id_DE335D425AB8C9B0[entnum]))
    data()._id_DE335D425AB8C9B0[entnum] = 0;

  _id_E38849C8432CDE0C = data()._id_DE335D425AB8C9B0[entnum];
  _id_CF3EC260E417F55F = int(clamp(_id_E38849C8432CDE0C + num, 0, data().maxcount));

  if(_id_E38849C8432CDE0C == _id_CF3EC260E417F55F) {
    return;
  }
  data()._id_DE335D425AB8C9B0[entnum] = _id_CF3EC260E417F55F;
  _id_2303C5DE643ECC1C = [];

  if(isDefined(aitype))
    _id_2303C5DE643ECC1C = ["count", _id_CF3EC260E417F55F - _id_E38849C8432CDE0C, "type", aitype];
  else
    _id_2303C5DE643ECC1C = ["count", _id_CF3EC260E417F55F - _id_E38849C8432CDE0C];

  self dlog_recordplayerevent(event, _id_2303C5DE643ECC1C);
  self setclientomnvar("ui_scorpion_trophies_collected", _id_CF3EC260E417F55F);
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2D65862CE8CA39F9", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);

  if(_id_CF3EC260E417F55F == data().maxcount) {
    self dlog_recordplayerevent("dlog_event_scorpion_limit_reached", ["limit", data().maxcount]);
    showsplash("haunting_soul_collected_max");
  } else
    showsplash("haunting_soul_collected");
}

_id_4C65595E68DB285C() {
  if(!isvalidplayer(self))
    return 0;

  if(!_id_1C8B9D8312271186())
    return 0;

  entnum = self getentitynumber();

  if(istrue(data()._id_EB3BE366ABC17855[entnum]))
    return 0;

  data()._id_EB3BE366ABC17855[entnum] = 1;
  num = scripts\engine\utility::_id_53C4C53197386572(data()._id_DE335D425AB8C9B0[entnum], 0);
  self dlog_recordplayerevent("dlog_event_scorpion_banked", ["count", num]);
  self _meth_DB073176839D77FB("597", [32, 1, 31, num]);
  self setclientomnvar("ui_scorpion_trophies_collected", num);
  self setplayerdata("mp", "s6EarnedSouls", num);
  return 1;
}

_id_1DABBBECF02DD66B(mover) {
  self endon("remove");
  mover waittill("death");
  thread cleanup(0);
}

_id_15DE990401BDD484(_id_69C8E45B8B8BB727) {
  self endon("remove");
  self endon("death");
  wait(getdvarfloat("dvar_8E2BEBEB7C769ABE", 28));

  if(!isDefined(self)) {
    return;
  }
  if(_id_69C8E45B8B8BB727) {
    if(isDefined(self._id_182D8860FAC4C70B)) {
      foreach(trophy in self._id_182D8860FAC4C70B)
      trophy setscriptablepartstate(trophy _meth_EC5F4851431F3382(), "fading");
    }
  } else
    self setscriptablepartstate(self _meth_EC5F4851431F3382(), "fading");

  wait 5;

  if(!isDefined(self)) {
    return;
  }
  if(_id_69C8E45B8B8BB727)
    thread cleanup(0, 1);
  else
    thread _id_5179A5DDCA15A921(0, 1);
}

cleanup(used, immediate) {
  if(isDefined(self._id_182D8860FAC4C70B)) {
    foreach(trophy in self._id_182D8860FAC4C70B)
    trophy thread _id_5179A5DDCA15A921(used, immediate);
  }

  self notify("remove");
  data().triggers[self.entnum] = undefined;
  waittillframeend;
  self delete();
}

_id_5179A5DDCA15A921(used, immediate) {
  if(!isDefined(self)) {
    return;
  }
  if(istrue(self.deleting)) {
    return;
  }
  self.deleting = 1;

  if(isDefined(self.entnum) && isDefined(data()._id_577A17D83577E3E6[self.entnum])) {
    data()._id_577A17D83577E3E6[self.entnum] = scripts\engine\utility::array_remove(data()._id_577A17D83577E3E6[self.entnum], self);

    if(data()._id_577A17D83577E3E6[self.entnum].size == 0)
      data()._id_577A17D83577E3E6[self.entnum] = undefined;
  }

  if(!istrue(immediate)) {
    state = scripts\engine\utility::ter_op(istrue(used), "pickup", "deleted");
    self setscriptablepartstate(self _meth_EC5F4851431F3382(), state);
    wait 3;
  }

  if(istrue(self._id_98D6306F2F5F9E66))
    self delete();
  else {
    _id_7E52B56769FA7774::_id_007B67823458CD14();
    self freescriptable();
  }
}

_id_3D8E31FA3CC6EEE5(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  entnum = player getentitynumber();

  if(!isDefined(entnum) || !isDefined(data().triggers[entnum])) {
    return;
  }
  data().triggers[entnum].team = _id_EB06B338608EF354;
}

showsplash(_id_1B4ADA49A21B51CA) {
  if(isDefined(self._id_0D072E417B4CD76A) && self._id_0D072E417B4CD76A > gettime()) {
    return;
  }
  self._id_0D072E417B4CD76A = gettime() + 1000;

  if(scripts\mp\utility\game::getsubgametype() == "dmz")
    _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4(_id_1B4ADA49A21B51CA, [self]);
  else
    thread scripts\mp\hud_message::showsplash(_id_1B4ADA49A21B51CA, undefined, undefined, undefined, 1);
}

_id_2A504551561A812C() {
  entnum = self getentitynumber();
  return _id_644B35BC4F205DCB() < data().maxcount;
}

_id_644B35BC4F205DCB() {
  entnum = self getentitynumber();
  _id_D8FED4D7AD83256A = scripts\engine\utility::_id_53C4C53197386572(data()._id_DE335D425AB8C9B0[entnum], 0);
  return _id_D8FED4D7AD83256A;
}

_id_1DC73C36B8CB3ECA() {
  return !scripts\mp\gamelogic::_id_1147BBC93EA9B83C() || data()._id_3F2E2CB7B92E01EF;
}

_id_03E9ED9D398B432E() {
  return scripts\mp\utility\game::getsubgametype() != "zxp";
}

isvalidplayer(player) {
  return isDefined(player) && isPlayer(player) && !isbot(player) && isDefined(player getentitynumber()) && isDefined(player.team);
}

_id_1C8B9D8312271186() {
  if(!isDefined(self) || !isDefined(self getentitynumber()))
    return 0;

  entnum = self getentitynumber();
  return isDefined(data()._id_DE335D425AB8C9B0[entnum]) && data()._id_DE335D425AB8C9B0[entnum] > 0;
}

data() {
  return game["soulCollecting"];
}