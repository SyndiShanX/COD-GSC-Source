/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6489b5b0c90138d7.gsc
***********************************************/

setupcallbacks() {
  if(getdvarint("scr_scorpiontrophyevent", 0) == 0 || istrue(level._id_EC2FB549B15AD827) || istrue(level._id_77907D733ABE8B63)) {
    _id_4C770A9A4AD7659C::_id_52004C7A02FCFFD6("player_connect", ::_id_66D05C31053F7C8F);
    return;
  }

  _id_4C770A9A4AD7659C::_id_52004C7A02FCFFD6("game_ended", ::ongameended);
  _id_4C770A9A4AD7659C::_id_52004C7A02FCFFD6("player_disconnect", ::onplayerdisconnect);
  _id_4C770A9A4AD7659C::_id_52004C7A02FCFFD6("player_connect", ::onplayerconnect);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    level.adddroponplayerdeath = ::_id_3354140884867D15;
    level._id_D3FB932F0373554C = ::_id_C8958695ACF2E1F1;
  } else {
    _id_4C770A9A4AD7659C::_id_52004C7A02FCFFD6("player_death", ::_id_DDCB9338C5CD1D29);
    _id_48814951E916AF89::_id_93ADD0B65DB9F722(::_id_A1FFA457F63D28FD);
  }

  scripts\cp_mp\utility\script_utility::registersharedfunc("br_loot_cache", "opened", ::_id_AA629573B9B452B7);
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_loot_cache_lege", "opened", ::_id_AA629573B9B452B7);
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_loot_cache", "spawnLoot", ::_id_735A4FD352102F67);
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_loot_cache_lege", "spawnLoot", ::_id_735A4FD352102F67);
  scripts\cp_mp\utility\script_utility::registersharedfunc(26160, "pickedUp", ::_id_B468EE3A4AAD8F93);
  scripts\cp_mp\utility\script_utility::registersharedfunc("brloot_scorpion_trophy", "delete", ::_id_C2FEB4D9932DFDCC);
  scripts\cp_mp\utility\script_utility::registersharedfunc("iw9_mp_scorpion_trophy_entityless", "delete", ::_id_C2FEB4D9932DFDCC);
  scripts\cp_mp\utility\script_utility::registersharedfunc("scorpion_event", "player_win", ::_id_D5E7A53FA83F629D);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("trophy_bank", ::_id_340F4F4118DCF7C3);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("brloot_scorpion_trophy", ::_id_199F02943420E747);
  scripts\engine\scriptable::scriptable_addautousecallback(::_id_76C38F4AF5D006EA);
  _id_3FF084F114B7F6C9::_id_F3D757808130BAC4(::_id_3D8E31FA3CC6EEE5);
  level thread _id_4D7A0B09D5F48C13();

  if(isDefined(data())) {
    return;
  }
  data = spawnStruct();
  data.dropcount = getdvarint("dvar_0A883D4D8DEC18E3", 1);
  data.maxcount = getdvarint("dvar_23B3D2EB188B1230", 6);
  data._id_FF2AFEEAAA71F4BC = getdvarint("dvar_C80CE9FC7BBC1E00", _id_950CDE7E875198D1());
  data._id_7D56C242C2C9880A = getdvarint("dvar_A4F1B7232D99C28F", 10);
  data._id_DBAD26986EC8F069 = getdvarint("dvar_404A77E17612EEE5", 1);
  data._id_8E3CD6BCC3E4F17C = getdvarint("dvar_884AF2871BE336E8", _id_FDF3D038AD278D6B());
  data._id_A082B242B6FAE420 = 200;
  data._id_4E54EDC5768A0AD4 = getdvarint("dvar_3F33F4C872C90245", 20);
  data._id_3F2E2CB7B92E01EF = getdvarint("dvar_CA2BC81F1C460D5B", 0);
  data.triggers = [];
  data._id_50ABD2E2174E8F51 = [];
  data._id_DE335D425AB8C9B0 = [];
  data._id_EB3BE366ABC17855 = [];
  data._id_5C0ED12BDB833AD9 = [];
  game["scorpionEvent"] = data;
}

_id_4D7A0B09D5F48C13() {
  scripts\engine\utility::flag_wait("buy_stations_spawned");

  if(!isDefined(level._id_6AA304E25520289F)) {
    return;
  }
  _id_9B520A44F4A86EA1 = [];
  _id_FC4EACC5FD5D61BF = [];
  _id_9C384998C2DF8582 = [];
  _id_E935789D709DD070 = [];

  foreach(struct in scripts\engine\utility::array_randomize(level._id_6AA304E25520289F)) {
    top = struct.origin[1] > 0;
    right = struct.origin[0] > 0;

    if(top && right) {
      _id_9C384998C2DF8582[_id_9C384998C2DF8582.size] = struct;
      continue;
    }

    if(!top && right) {
      _id_E935789D709DD070[_id_E935789D709DD070.size] = struct;
      continue;
    }

    if(top && !right) {
      _id_9B520A44F4A86EA1[_id_9B520A44F4A86EA1.size] = struct;
      continue;
    }

    if(!top && !right)
      _id_FC4EACC5FD5D61BF[_id_FC4EACC5FD5D61BF.size] = struct;
  }

  _id_ADBF09495B575466 = [];

  foreach(_id_6A34E2E9651B7071 in [_id_9B520A44F4A86EA1, _id_FC4EACC5FD5D61BF, _id_9C384998C2DF8582, _id_E935789D709DD070]) {
    if(_id_6A34E2E9651B7071.size > 0)
      _id_ADBF09495B575466[_id_ADBF09495B575466.size] = _id_6A34E2E9651B7071;
  }

  if(_id_ADBF09495B575466.size == 0) {
    return;
  }
  _id_ADBF09495B575466 = scripts\engine\utility::array_randomize(_id_ADBF09495B575466);
  spawned = 0;
  level._id_939840B6113E9E66 = [];

  while(spawned < data()._id_8E3CD6BCC3E4F17C) {
    index = spawned % _id_ADBF09495B575466.size;
    spawned = spawned + 1;
    struct = _id_ADBF09495B575466[index][_id_ADBF09495B575466[index].size - 1];
    _id_ADBF09495B575466[index][_id_ADBF09495B575466[index].size - 1] = undefined;
    level._id_939840B6113E9E66[level._id_939840B6113E9E66.size] = spawnscriptable("iw9_mp_scorpion_trophy_bank", struct.origin, struct.angles);

    if(_id_ADBF09495B575466[index].size == 0) {
      _id_D4A4D8D21B1B423A = [];

      foreach(array in _id_ADBF09495B575466) {
        if(array.size > 0)
          _id_D4A4D8D21B1B423A[_id_D4A4D8D21B1B423A.size] = array;
      }

      _id_ADBF09495B575466 = _id_D4A4D8D21B1B423A;
    }

    if(_id_ADBF09495B575466.size == 0) {
      break;
    }
  }

  level._id_6AA304E25520289F = undefined;
}

_id_340F4F4118DCF7C3(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isvalidplayer(player)) {
    return;
  }
  if(!player _id_1C8B9D8312271186()) {
    return;
  }
  player showsplash("scorpion_trophy_banked");
  success = player _id_4C65595E68DB285C();
  instance setscriptablepartstate("upload", "on");
  player scripts\common\utility::_id_3677F2BE30FDD581("trophy_effects", "upload");

  if(success)
    player thread _id_7E52B56769FA7774::playerplaypickupanim();
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
  _id_D849E5E65179D50B = 0;

  if(_id_1C8B9D8312271186()) {
    _id_D849E5E65179D50B = int(min(data()._id_DE335D425AB8C9B0[entnum], data()._id_FF2AFEEAAA71F4BC));
    data()._id_DE335D425AB8C9B0[entnum] = data()._id_DE335D425AB8C9B0[entnum] - _id_D849E5E65179D50B;
    self setclientomnvar("ui_scorpion_trophies_collected", data()._id_DE335D425AB8C9B0[entnum]);
  }

  trigger = _id_CFB0BD180308A4BA(data().dropcount, self, _id_D849E5E65179D50B, self.origin, entnum, _id_642470E1ABC1BBF9.attacker, "player_kill");
  trigger._id_E7C898D742B4BA46 = _id_642470E1ABC1BBF9.attacker;
}

_id_3354140884867D15(dropstruct, attacker, meansofdeath, weaponobj) {
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
  if(isDefined(data()._id_50ABD2E2174E8F51[entnum])) {
    foreach(trophy in data()._id_50ABD2E2174E8F51[entnum])
    trophy thread _id_5179A5DDCA15A921();

    data()._id_50ABD2E2174E8F51[entnum] = undefined;
  }

  if(isvalidplayer(attacker)) {
    if(!isDefined(data()._id_5C0ED12BDB833AD9[entnum]))
      data()._id_5C0ED12BDB833AD9[entnum] = [];

    if(isDefined(data()._id_5C0ED12BDB833AD9[entnum][attacker.team]))
      return;
  }

  _id_D849E5E65179D50B = 0;

  if(_id_1C8B9D8312271186()) {
    _id_D849E5E65179D50B = int(min(data()._id_DE335D425AB8C9B0[entnum], data()._id_FF2AFEEAAA71F4BC));
    data()._id_DE335D425AB8C9B0[entnum] = data()._id_DE335D425AB8C9B0[entnum] - _id_D849E5E65179D50B;
    self setclientomnvar("ui_scorpion_trophies_collected", data()._id_DE335D425AB8C9B0[entnum]);
  }

  _id_CFB0BD180308A4BA(data().dropcount, self, _id_D849E5E65179D50B, self.origin, entnum, attacker, "player_kill", dropstruct);
}

onplayerdisconnect(params) {
  if(!isvalidplayer(self)) {
    return;
  }
  if(_id_1C8B9D8312271186())
    self dlog_recordplayerevent("dlog_event_scorpion_not_banked", ["count", data()._id_DE335D425AB8C9B0[self getentitynumber()]]);

  self setplayerdata("mp", "s3EarnedTrophies", _id_F4792371AD163637());
}

onplayerconnect(params) {
  if(!isvalidplayer(self)) {
    return;
  }
  self setclientomnvar("ui_scorpion_trophies_collected", scripts\engine\utility::_id_53C4C53197386572(data()._id_DE335D425AB8C9B0[self getentitynumber()], 0));
  self setclientomnvar("ui_scorpion_trophies_secured", scripts\engine\utility::_id_53C4C53197386572(data()._id_EB3BE366ABC17855[self getentitynumber()], 0));
  self setplayerdata("mp", "s3EarnedTrophies", _id_F4792371AD163637());
}

_id_66D05C31053F7C8F(params) {
  if(!isvalidplayer(self)) {
    return;
  }
  self setplayerdata("mp", "s3EarnedTrophies", 0);
}

_id_C8958695ACF2E1F1(_id_6181DE250AFA5BB6, dropstruct) {
  _id_A1FFA457F63D28FD(self, _id_6181DE250AFA5BB6, dropstruct);
}

_id_A1FFA457F63D28FD(agent, _id_6181DE250AFA5BB6, dropstruct) {
  if(!_id_1DC73C36B8CB3ECA()) {
    return;
  }
  if(data()._id_7D56C242C2C9880A <= 0) {
    return;
  }
  if(!isvalidplayer(_id_6181DE250AFA5BB6)) {
    return;
  }
  if(!_id_6181DE250AFA5BB6 _id_2A504551561A812C()) {
    return;
  }
  if(randomint(100) > data()._id_7D56C242C2C9880A) {
    return;
  }
  _id_CFB0BD180308A4BA(data()._id_DBAD26986EC8F069, agent, 0, agent.origin, data()._id_A082B242B6FAE420, _id_6181DE250AFA5BB6, "ai_kill", dropstruct);
  data()._id_A082B242B6FAE420 = data()._id_A082B242B6FAE420 + 1;
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

  if(randomint(100) > data()._id_4E54EDC5768A0AD4)
    return items;

  items[items.size] = "brloot_scorpion_trophy";
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
  if(randomint(100) > data()._id_4E54EDC5768A0AD4) {
    return;
  }
  trophies = _id_CFB0BD180308A4BA(1, self, 0, self.origin, data()._id_A082B242B6FAE420, undefined, "loot", dropstruct);
  data()._id_A082B242B6FAE420 = data()._id_A082B242B6FAE420 + 1;
  return trophies;
}

_id_76C38F4AF5D006EA(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(instance) || !isDefined(instance.type) || instance.type != "brloot_scorpion_trophy") {
    return;
  }
  _id_199F02943420E747(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61, 1);
}

_id_199F02943420E747(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61, _id_71B664F5AB636333) {
  if(!isDefined(instance) || !isDefined(instance.type) || instance.type != "brloot_scorpion_trophy") {
    return;
  }
  if(isDefined(instance.team) && instance.team == player.team) {
    if(isDefined(instance._id_926F48790E712666)) {
      data()._id_DE335D425AB8C9B0[instance.entnum] = _id_5BFF4E2A3631E3E5(instance.entnum, 1);

      if(isDefined(instance._id_926F48790E712666)) {
        instance._id_926F48790E712666 showsplash("scorpion_trophy_recovered");
        instance._id_926F48790E712666 setclientomnvar("ui_scorpion_trophies_collected", data()._id_DE335D425AB8C9B0[instance.entnum]);
      }
    }

    if(!isDefined(instance._id_926F48790E712666) || instance._id_926F48790E712666 != player)
      player showsplash("scorpion_trophy_denied");
  } else {
    player _id_439F0781DBD8A339(1, scripts\engine\utility::_id_53C4C53197386572(instance._id_5D30E45C6D206A9E, "loot"));

    if(isDefined(instance.team))
      data()._id_5C0ED12BDB833AD9[instance.entnum][player.team] = 1;
  }

  player scripts\common\utility::_id_3677F2BE30FDD581("trophy_effects", "pickup");

  if(!istrue(_id_71B664F5AB636333))
    player thread _id_7E52B56769FA7774::playerplaypickupanim();

  data()._id_50ABD2E2174E8F51[instance.entnum] = scripts\engine\utility::array_remove(data()._id_50ABD2E2174E8F51[instance.entnum], instance);

  if(data()._id_50ABD2E2174E8F51[instance.entnum].size == 0)
    data()._id_50ABD2E2174E8F51[instance.entnum] = undefined;

  instance thread _id_5179A5DDCA15A921(1);
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
  if(!_id_8EFD0A6812869EA2()) {
    return;
  }
  foreach(player in level.players)
  player _id_4C65595E68DB285C();
}

_id_D5E7A53FA83F629D() {
  _id_4C65595E68DB285C();
}

_id_CFB0BD180308A4BA(count, from, _id_D849E5E65179D50B, origin, entnum, _id_6181DE250AFA5BB6, type, dropstruct) {
  if(!isDefined(dropstruct) && scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    return;
  }
  count = count + scripts\engine\utility::_id_53C4C53197386572(_id_D849E5E65179D50B, 0);
  mover = undefined;

  if(isDefined(from) && isent(from) && isPlayer(from))
    mover = from getmovingplatformparent();

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    _id_50ABD2E2174E8F51 = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < count; _id_AC0E594AC96AA3A8++) {
      if(isent(from))
        _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, from.origin, from.angles, from, undefined, undefined, randomfloatrange(15, 30));
      else
        _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, from.origin, from.angles, undefined, 115 + randomfloatrange(-10, 10), 35 + randomfloatrange(-5, 5), randomfloatrange(15, 30));

      trophy = spawnscriptable("brloot_scorpion_trophy", _id_CB4FAD49263E20C4.origin, _id_CB4FAD49263E20C4.angles, _id_CB4FAD49263E20C4.payload);
      trophy.entnum = entnum;
      trophy._id_98D6306F2F5F9E66 = 0;
      trophy._id_5D30E45C6D206A9E = type;
      _id_7E52B56769FA7774::registerscriptableinstance(trophy);

      if(isent(from) && isPlayer(from))
        trophy.team = from.team;

      if(_id_D849E5E65179D50B > 0) {
        trophy._id_926F48790E712666 = from;
        _id_D849E5E65179D50B = _id_D849E5E65179D50B - 1;
      }

      mover = _id_CB4FAD49263E20C4.groundentity;

      if(isDefined(mover)) {
        trophy scripts\common\utility::_id_6E506F39F121EA8A(mover, rotatevectorinverted(trophy.origin - mover.origin, mover.angles));
        trophy setscriptablepartstate("brloot_scorpion_trophy", "dropped_linked");
      } else
        trophy setscriptablepartstate("brloot_scorpion_trophy", "dropped");

      _id_50ABD2E2174E8F51[_id_50ABD2E2174E8F51.size] = trophy;
    }

    data()._id_50ABD2E2174E8F51[entnum] = _id_50ABD2E2174E8F51;
    return _id_50ABD2E2174E8F51;
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

    foreach(spawnpos in _id_22CE7236B68B2334) {
      trophy = spawn("script_model", spawnpos + (0, 0, randomfloatrange(18, 27)));
      trophy setModel("iw9_mp_scorpion_trophy_entity");

      if(isDefined(_id_6181DE250AFA5BB6))
        trophy showonlytoplayer(_id_6181DE250AFA5BB6);

      trophy setscriptablepartstate("iw9_mp_scorpion_trophy_entity", "visible");
      trophy._id_98D6306F2F5F9E66 = 1;
      trophy.angles = (0, randomfloat(360), 0);
      trophy rotatevelocity((0, randomfloatrange(45, 135) * scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), 1, -1), 0), 9999);

      if(isDefined(mover))
        trophy linkTo(mover);

      trophies[trophies.size] = trophy;
    }

    return _id_128EDF2232D31C50(origin, scripts\engine\utility::ter_op(count > 1, 45, 35), entnum, trophies, type, _id_D849E5E65179D50B, from, mover);
  }
}

_id_128EDF2232D31C50(origin, radius, entnum, trophies, type, _id_D849E5E65179D50B, _id_24D90D64DEBEFDD4, mover) {
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
  trigger._id_D849E5E65179D50B = _id_D849E5E65179D50B;

  foreach(trophy in trophies)
  trophy.trigger = trigger;

  trigger thread watchtrigger();
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
      if(self._id_D849E5E65179D50B > 0) {
        data()._id_DE335D425AB8C9B0[self.entnum] = _id_5BFF4E2A3631E3E5(self.entnum, self._id_D849E5E65179D50B);

        if(isDefined(self._id_24D90D64DEBEFDD4)) {
          self._id_24D90D64DEBEFDD4 showsplash("scorpion_trophy_recovered");
          self._id_24D90D64DEBEFDD4 setclientomnvar("ui_scorpion_trophies_collected", data()._id_DE335D425AB8C9B0[self.entnum]);
        }
      }

      if(!isDefined(self._id_24D90D64DEBEFDD4) || self._id_24D90D64DEBEFDD4 != ent)
        ent showsplash("scorpion_trophy_denied");

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
  entnum = self getentitynumber();
  event = undefined;

  switch (type) {
    case "loot":
      event = "dlog_event_scorpion_gathered_loot";
      break;
    case "ai_kill":
      event = "dlog_event_scorpion_gathered_ai_kill";
      break;
    case "player_kill":
      event = "dlog_event_scorpion_gathered_player_kill";
      break;
  }

  if(!isDefined(data()._id_DE335D425AB8C9B0[entnum]))
    data()._id_DE335D425AB8C9B0[entnum] = 0;

  _id_087CB17AD78EF31A = data()._id_DE335D425AB8C9B0[entnum];
  _id_0E554EAFDC47FD35 = _id_5BFF4E2A3631E3E5(entnum, num);
  data()._id_DE335D425AB8C9B0[entnum] = _id_0E554EAFDC47FD35;

  if(_id_0E554EAFDC47FD35 > _id_087CB17AD78EF31A) {
    self dlog_recordplayerevent(event, ["count", _id_0E554EAFDC47FD35 - _id_087CB17AD78EF31A]);
    self setclientomnvar("ui_scorpion_trophies_collected", _id_0E554EAFDC47FD35);
    thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_CCB945806D13FD43");
    _id_9164E8CFB80749FF = _id_644B35BC4F205DCB();
    _id_1B4ADA49A21B51CA = undefined;

    if(_id_9164E8CFB80749FF == data().maxcount) {
      self dlog_recordplayerevent("dlog_event_scorpion_limit_reached", ["limit", data().maxcount]);

      if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
        if(scripts\mp\utility\game::getsubgametype() == "plunder")
          _id_1B4ADA49A21B51CA = "scorpion_trophy_collected_plunder_max";
        else
          _id_1B4ADA49A21B51CA = "scorpion_trophy_collected_br_max";
      } else
        _id_1B4ADA49A21B51CA = "scorpion_trophy_collected_core_max";
    } else if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
      if(scripts\mp\utility\game::getsubgametype() == "plunder")
        _id_1B4ADA49A21B51CA = "scorpion_trophy_collected_plunder";
      else
        _id_1B4ADA49A21B51CA = "scorpion_trophy_collected_br";
    } else
      _id_1B4ADA49A21B51CA = "scorpion_trophy_collected_core";

    showsplash(_id_1B4ADA49A21B51CA);

    if((_id_9164E8CFB80749FF == data().maxcount || _id_9164E8CFB80749FF == 1) && isDefined(level._id_939840B6113E9E66) && level._id_939840B6113E9E66.size > 0) {
      _id_114AB88507847C50 = sortbydistance(level._id_939840B6113E9E66, self.origin)[0];

      foreach(_id_F0EA4030349A33D5 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
        if(_id_F0EA4030349A33D5 _meth_BEE315A15CF61820(_id_114AB88507847C50.index))
          return;
      }

      _id_D0AE85B60EC1F5F7 = self calloutmarkerping_create(18, (0, 0, 100), _id_114AB88507847C50.index);
      thread _id_1B75E18C641D5093(_id_D0AE85B60EC1F5F7, _id_114AB88507847C50.index);
    }
  }
}

_id_1B75E18C641D5093(_id_D0AE85B60EC1F5F7, index) {
  scripts\engine\utility::waittill_any_timeout_2(30, "death_or_disconnect", "enter_live_ragdoll");

  if(isDefined(self) && self _meth_BEE315A15CF61820(index))
    self calloutmarkerping_delete(_id_D0AE85B60EC1F5F7);
}

_id_5BFF4E2A3631E3E5(entnum, num) {
  _id_087CB17AD78EF31A = data()._id_DE335D425AB8C9B0[entnum];
  _id_0E554EAFDC47FD35 = _id_087CB17AD78EF31A + num;
  _id_A5407B03B3E5F39F = data().maxcount - scripts\engine\utility::_id_53C4C53197386572(data()._id_EB3BE366ABC17855[entnum], 0);

  if(_id_0E554EAFDC47FD35 > _id_A5407B03B3E5F39F)
    _id_0E554EAFDC47FD35 = _id_A5407B03B3E5F39F;

  return _id_0E554EAFDC47FD35;
}

_id_4C65595E68DB285C() {
  if(!isvalidplayer(self))
    return 0;

  if(!_id_1C8B9D8312271186())
    return 0;

  entnum = self getentitynumber();
  num = data()._id_DE335D425AB8C9B0[entnum];
  self dlog_recordplayerevent("dlog_event_scorpion_banked", ["count", num]);
  self _meth_DB073176839D77FB("462", [32, 1, 31, num]);
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_D7637699E926CBC6");

  if(!isDefined(data()._id_EB3BE366ABC17855[entnum]))
    data()._id_EB3BE366ABC17855[entnum] = 0;

  data()._id_EB3BE366ABC17855[entnum] = data()._id_EB3BE366ABC17855[entnum] + num;
  data()._id_DE335D425AB8C9B0[entnum] = 0;
  self setclientomnvar("ui_scorpion_trophies_collected", 0);
  self setclientomnvar("ui_scorpion_trophies_secured", data()._id_EB3BE366ABC17855[entnum]);
  self setplayerdata("mp", "s3EarnedTrophies", data()._id_EB3BE366ABC17855[entnum]);
  return 1;
}

_id_1DABBBECF02DD66B(mover) {
  self endon("remove");
  mover waittill("death");
  thread cleanup(0);
}

cleanup(used) {
  if(isDefined(self._id_182D8860FAC4C70B)) {
    foreach(trophy in self._id_182D8860FAC4C70B)
    trophy thread _id_5179A5DDCA15A921(used);
  }

  self notify("remove");
  data().triggers[self.entnum] = undefined;
  waittillframeend;
  self delete();
}

_id_5179A5DDCA15A921(used) {
  if(!isDefined(self)) {
    return;
  }
  if(istrue(self.deleting)) {
    return;
  }
  self.deleting = 1;
  state = scripts\engine\utility::ter_op(istrue(used), "pickup", "deleted");
  self setscriptablepartstate(self _meth_EC5F4851431F3382(), state);
  wait 3;

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
  _id_4A7273FE950A1C5F = scripts\engine\utility::_id_53C4C53197386572(data()._id_EB3BE366ABC17855[entnum], 0);
  return _id_D8FED4D7AD83256A + _id_4A7273FE950A1C5F;
}

_id_1DC73C36B8CB3ECA() {
  return !scripts\mp\gamelogic::_id_1147BBC93EA9B83C() || data()._id_3F2E2CB7B92E01EF;
}

isvalidplayer(player) {
  return isDefined(player) && isPlayer(player) && !isbot(player) && isDefined(player getentitynumber()) && isDefined(player.team);
}

_id_F5681F11E80E8DD6() {
  return scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508();
}

_id_8EFD0A6812869EA2() {
  return !scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508();
}

_id_950CDE7E875198D1() {
  return scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508(), 2, 0);
}

_id_FDF3D038AD278D6B() {
  return scripts\engine\utility::ter_op(level.mapname == "mp_saba2" || level.mapname == "mp_saba" || level.mapname == "mp_saba_pm", 6, 2);
}

_id_1C8B9D8312271186() {
  if(!isDefined(self) || !isDefined(self getentitynumber()))
    return 0;

  entnum = self getentitynumber();
  return isDefined(data()._id_DE335D425AB8C9B0[entnum]) && data()._id_DE335D425AB8C9B0[entnum] > 0;
}

_id_F4792371AD163637() {
  if(!isDefined(self) || !isDefined(self getentitynumber()))
    return 0;

  entnum = self getentitynumber();

  if(isDefined(data()._id_EB3BE366ABC17855[entnum]))
    return data()._id_EB3BE366ABC17855[entnum];
  else
    return 0;
}

data() {
  return game["scorpionEvent"];
}