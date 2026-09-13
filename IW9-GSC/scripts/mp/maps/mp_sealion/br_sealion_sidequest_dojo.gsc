/********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_sealion\br_sealion_sidequest_dojo.gsc
********************************************************************/

main() {
  thread _id_DEEE3B97BF9C0945();
}

_id_DEEE3B97BF9C0945() {
  waitframe();

  if(!scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414()) {
    return;
  }
  init();
}

init() {
  if(!getdvarint("dvar_2401B3254BC2849D", 0)) {
    return;
  }
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("sealion_sidequest_dojo_item_2", ::_id_9958F22CADBFFA90);
  level._id_00B51E4D3B0C7756 = spawnStruct();
  level._id_00B51E4D3B0C7756 _id_618A1163576C3819();
  level._id_00B51E4D3B0C7756 _id_B4BC8E806C1993A4();
  level._id_00B51E4D3B0C7756 thread _id_9D99A6B3C18A711C();
  level._id_00B51E4D3B0C7756 thread init_ai();
  level._id_00B51E4D3B0C7756 thread _id_5DDA9E97C47B0EA3();
}

_id_618A1163576C3819() {
  self._id_EDF9681A968D1555 = 0;
  self._id_A96E2D1657A44A52 = 0;
  self._id_A50A2B7C43DD961C = 0;
  self._id_C95C20211E1274F9 = 0;
  self._id_8304E0770299DA93 = getdvarint("dvar_14931C70D700C55C", 0);
  self._id_FF61AC9EE35E6999 = getdvarint("dvar_822C764E14FEC632", 3000);
  self._id_194BFFF0E02C69BB = getdvarint("dvar_B2D27CC0ED604AAA", 3000);
  self._id_14E033A5B6EEB714 = getdvarint("dvar_935DFAB89DC8DEAF", 1100);
  _id_7C9104D0FEEC8422 = getdvarint("dvar_29710446D74630DF", 1000);
  self._id_A304A6E45BACE997 = _id_7C9104D0FEEC8422 * _id_7C9104D0FEEC8422;
  self._id_4B7C4E4F552AFA9E = [];
  self._id_4B32A3FC69BF108C = [];
  _id_861BE59C011E535E = "3,3,4,1";
  _id_85D23B4915B2694C = "1,2,2,3";
  _id_90A9CD95EF6496B4 = getdvarint("dvar_4838B7C39021124C", 4);

  switch (_id_90A9CD95EF6496B4) {
    case 3:
      _id_861BE59C011E535E = "3,3,3,1";
      _id_85D23B4915B2694C = "1,2,2,3";
    case 2:
      _id_861BE59C011E535E = "3,3,3,1";
      _id_85D23B4915B2694C = "1,2,2,3";
    case 1:
      _id_861BE59C011E535E = "2,3,2,1";
      _id_85D23B4915B2694C = "1,1,2,3";
  }

  _id_5BD51BC55EC0B596 = getDvar("dvar_0B706E4C1A27C957", _id_861BE59C011E535E);
  _id_7B9CD16A7B379034 = getDvar("dvar_A77AF0466E67944D", _id_85D23B4915B2694C);
  _id_808B84CC33CE43C5 = strtok(_id_5BD51BC55EC0B596, ",");

  foreach(s in _id_808B84CC33CE43C5) {
    _id_AC0E594AC96AA3A8 = int(s);

    if(isint(_id_AC0E594AC96AA3A8))
      self._id_4B7C4E4F552AFA9E = scripts\engine\utility::array_add(self._id_4B7C4E4F552AFA9E, _id_AC0E594AC96AA3A8);
  }

  _id_ADE2CC2451EC8F90 = strtok(_id_7B9CD16A7B379034, ",");

  foreach(s in _id_ADE2CC2451EC8F90) {
    _id_AC0E594AC96AA3A8 = int(s);

    if(isint(_id_AC0E594AC96AA3A8))
      self._id_4B32A3FC69BF108C = scripts\engine\utility::array_add(self._id_4B32A3FC69BF108C, _id_AC0E594AC96AA3A8);
  }

  self._id_E3166F35B0B68F29 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC((-96, -7001, 1230));
}

init_ai() {
  level endon("game_ended");
  _id_48814951E916AF89::_id_2FC80954FA70D153();
  _id_48814951E916AF89::_id_BA4022744DCE59F6("sidequest_dojo", 10);
  _id_252FA7D2B1B1B50B::_id_B146E2B40516B668("sidequest_dojo");
}

_id_B4BC8E806C1993A4() {
  _id_746D6CA978BE565F = [];
  _id_9E4F7FB5B3E1E553 = scripts\engine\utility::getStructArray("sidequest_dojo_spawn", "script_noteworthy");

  foreach(struct in _id_9E4F7FB5B3E1E553) {
    spawn_point = spawnStruct();
    spawn_point.origin = getclosestpointonnavmesh(struct.origin);
    spawn_point.angles = struct.angles;

    if(isDefined(struct._id_E6DA89CE4A78AE6F)) {
      self._id_E6DA89CE4A78AE6F = spawn_point;
      continue;
    }

    _id_746D6CA978BE565F = scripts\engine\utility::array_add(_id_746D6CA978BE565F, spawn_point);
  }

  self._id_746D6CA978BE565F = _id_746D6CA978BE565F;
  _id_029A3DB0499A2874 = [];
  _id_029A3DB0499A2874[0] = [];
  _id_029A3DB0499A2874[1] = [];
  _id_029A3DB0499A2874[2] = [];
  _id_45A94F9D2DDACD6E = scripts\engine\utility::getStructArray("sidequest_dojo_mask_location", "script_noteworthy");

  foreach(struct in _id_45A94F9D2DDACD6E) {
    spawn_point = spawnStruct();
    spawn_point.origin = struct.origin;
    spawn_point.angles = struct.angles;
    group = int(struct.group);
    _id_029A3DB0499A2874[group] = scripts\engine\utility::array_add(_id_029A3DB0499A2874[group], spawn_point);
  }

  self._id_029A3DB0499A2874 = _id_029A3DB0499A2874;
}

_id_9D99A6B3C18A711C() {
  _id_88D7A2B341D3E3D7 = [];
  _id_88D7A2B341D3E3D7[_id_88D7A2B341D3E3D7.size] = "brloot_offhand_advancedsupplydrop";
  _id_88D7A2B341D3E3D7[_id_88D7A2B341D3E3D7.size] = _id_14183DF6F9AF8737::_id_53382489FF523151();
  _id_88D7A2B341D3E3D7[_id_88D7A2B341D3E3D7.size] = "brloot_super_munitionsbox";
  _id_88D7A2B341D3E3D7[_id_88D7A2B341D3E3D7.size] = "brloot_super_armorbox";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.maxteamsize; _id_AC0E594AC96AA3A8++)
    _id_88D7A2B341D3E3D7[_id_88D7A2B341D3E3D7.size] = "brloot_plunder_cash_rare_1";

  self._id_F8C903F8D6D4E353 = _id_88D7A2B341D3E3D7;
}

_id_5DDA9E97C47B0EA3() {
  self._id_728C3B1BFF7FCE85 = _id_491D781E5F46A297("sealion_sidequest_dojo_item_1", (-1435.93, -5764.24, 1302.76), (0, 135, 80));
  self._id_728C381BFF7FC7EC = _id_491D781E5F46A297("sealion_sidequest_dojo_item_2", (-1451.96, -5747.98, 1301.83), (0, 135, 80));
  self._id_728C391BFF7FCA1F = _id_491D781E5F46A297("sealion_sidequest_dojo_item_3", (-1467.58, -5732.78, 1301.65), (0, 135, 80));
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  _id_B3A74F84A63ECC69();
  self._id_BDB14CB91EAAAB14 = [];
  self._id_BDB14CB91EAAAB14 = scripts\engine\utility::array_add(self._id_BDB14CB91EAAAB14, _id_C61B254E575A5BEC("brloot_sealion_dojo_item_1", scripts\engine\utility::random(self._id_029A3DB0499A2874[0])));
  self._id_BDB14CB91EAAAB14 = scripts\engine\utility::array_add(self._id_BDB14CB91EAAAB14, _id_C61B254E575A5BEC("brloot_sealion_dojo_item_2", scripts\engine\utility::random(self._id_029A3DB0499A2874[1])));
  self._id_BDB14CB91EAAAB14 = scripts\engine\utility::array_add(self._id_BDB14CB91EAAAB14, _id_C61B254E575A5BEC("brloot_sealion_dojo_item_3", scripts\engine\utility::random(self._id_029A3DB0499A2874[2])));
}

_id_491D781E5F46A297(_id_E89A9A6A3475BD0A, _id_CCD641F9100F73F8, _id_D07056AD0C95B812) {
  item = spawnscriptable(_id_E89A9A6A3475BD0A, _id_CCD641F9100F73F8, _id_D07056AD0C95B812);
  waitframe();
  item setscriptablepartstate(_id_E89A9A6A3475BD0A, "visible");
  return item;
}

_id_B3A74F84A63ECC69() {
  self._id_728C3B1BFF7FCE85 setscriptablepartstate("sealion_sidequest_dojo_item_1", "hidden");
  self._id_728C381BFF7FC7EC setscriptablepartstate("sealion_sidequest_dojo_item_2", "hidden_usable");
  self._id_728C391BFF7FCA1F setscriptablepartstate("sealion_sidequest_dojo_item_3", "hidden");
}

_id_C61B254E575A5BEC(_id_98B268853ED37383, _id_ACF3ABFDC41D27F7) {
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(_id_ACF3ABFDC41D27F7.origin, _id_ACF3ABFDC41D27F7.angles);
  pickup = _id_7E52B56769FA7774::spawnpickup(_id_98B268853ED37383, _id_CB4FAD49263E20C4);
  level._id_D8DB1602C8BF473E[_id_98B268853ED37383] = ::_id_079F58986383E503;
  return pickup;
}

_id_9958F22CADBFFA90(scriptable, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(level._id_00B51E4D3B0C7756._id_AD1F6870CFDFAA5A)) {
    level._id_00B51E4D3B0C7756._id_AD1F6870CFDFAA5A = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7("brloot_sealion_dojo_item_1");
    level._id_00B51E4D3B0C7756._id_A7E35678A8C1549F = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7("brloot_sealion_dojo_item_2");
    level._id_00B51E4D3B0C7756._id_7C90D88CE3A3D6A8 = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7("brloot_sealion_dojo_item_3");
  }

  lootid = 0;
  _id_940BCA0E072AD307 = 0;

  for(_id_A6F8D8115E0F1E79 = 0; _id_A6F8D8115E0F1E79 < _id_2D9D24F7C63AC143::_id_B13E35608B336D65(player); _id_A6F8D8115E0F1E79++) {
    lootid = player _id_2D9D24F7C63AC143::_id_6196D9EA9A30E609(_id_A6F8D8115E0F1E79);

    if(lootid == level._id_00B51E4D3B0C7756._id_AD1F6870CFDFAA5A && !level._id_00B51E4D3B0C7756._id_A96E2D1657A44A52) {
      level._id_00B51E4D3B0C7756._id_A96E2D1657A44A52 = 1;
      _id_940BCA0E072AD307 = 1;
      level thread _id_8FA5EDC8C5F0739D("sealion_sidequest_dojo_item_1");
      break;
    } else if(lootid == level._id_00B51E4D3B0C7756._id_A7E35678A8C1549F && !level._id_00B51E4D3B0C7756._id_A50A2B7C43DD961C) {
      level._id_00B51E4D3B0C7756._id_A50A2B7C43DD961C = 1;
      _id_940BCA0E072AD307 = 1;
      level thread _id_8FA5EDC8C5F0739D("sealion_sidequest_dojo_item_2");
      break;
    } else if(lootid == level._id_00B51E4D3B0C7756._id_7C90D88CE3A3D6A8 && !level._id_00B51E4D3B0C7756._id_C95C20211E1274F9) {
      level._id_00B51E4D3B0C7756._id_C95C20211E1274F9 = 1;
      _id_940BCA0E072AD307 = 1;
      level thread _id_8FA5EDC8C5F0739D("sealion_sidequest_dojo_item_3");
      break;
    }
  }

  if(_id_940BCA0E072AD307)
    player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_BC18E7D11781E655");

  player _id_2D9D24F7C63AC143::_id_6F39F9916649AC48(lootid, 1);
}

_id_8FA5EDC8C5F0739D(_id_E89A9A6A3475BD0A) {
  level._id_00B51E4D3B0C7756._id_EDF9681A968D1555++;

  switch (_id_E89A9A6A3475BD0A) {
    case "sealion_sidequest_dojo_item_1":
      level._id_00B51E4D3B0C7756._id_728C3B1BFF7FCE85 setscriptablepartstate("sealion_sidequest_dojo_item_1", "visible");
      break;
    case "sealion_sidequest_dojo_item_2":
      if(level._id_00B51E4D3B0C7756._id_EDF9681A968D1555 < 3)
        level._id_00B51E4D3B0C7756._id_728C381BFF7FC7EC setscriptablepartstate("sealion_sidequest_dojo_item_2", "visible_usable");

      break;
    case "sealion_sidequest_dojo_item_3":
      level._id_00B51E4D3B0C7756._id_728C391BFF7FCA1F setscriptablepartstate("sealion_sidequest_dojo_item_3", "visible");
      break;
  }

  if(level._id_00B51E4D3B0C7756._id_EDF9681A968D1555 == 3) {
    level._id_00B51E4D3B0C7756._id_728C381BFF7FC7EC setscriptablepartstate("sealion_sidequest_dojo_item_2", "visible");
    level._id_00B51E4D3B0C7756 thread _id_67B851EA6AAAB2BD();
  }
}

_id_67B851EA6AAAB2BD() {
  level endon("game_ended");
  self endon("sidequest_end");

  if(istrue(self._id_E4B9B55EF09D4F53) || !_id_58F20490049AF6AC::_id_778A4C3D053ED0A9((-1451.96, -5747.98, 1301.83))) {
    return;
  }
  thread _id_F09FD68F7BADB8F5();
  self._id_936EC1DBCBED6E7D = 1;
  _id_6F21E5ABF098A6D1 = scripts\mp\utility\player::getplayersinradius((-96, -7001, 1230), self._id_194BFFF0E02C69BB);

  foreach(player in _id_6F21E5ABF098A6D1)
  player thread scripts\mp\hud_message::showsplash("br_sealion_sidequest_dojo_start", undefined, undefined, undefined, undefined, "splash_list_br_sealion_sidequest_dojo");

  _id_48814951E916AF89::_id_66A6064FAD612BF3(::_id_F2DB660BD33BCC5E);
  _id_48814951E916AF89::_id_93ADD0B65DB9F722(::_id_F2DB660BD33BCC5E);
  _id_6F21E5ABF098A6D1 = scripts\mp\utility\player::getplayersinradius((-96, -7001, 1230), self._id_194BFFF0E02C69BB);
  _id_7E832B5C6F2F9F2D(self._id_E6DA89CE4A78AE6F, self._id_4B32A3FC69BF108C[0], _id_6F21E5ABF098A6D1);
  thread _id_4764CDA74BD698E0();
  self waittill("wave_cleared");
  _id_A33817CBCA5F5B92 = (0, 0, 0);
  _id_B107122DE8641235 = (0, 0, 0);
  _id_9ABF330EDF64A73F = undefined;

  for(_id_A2B11613E4C46ED8 = 0; _id_A2B11613E4C46ED8 < self._id_4B7C4E4F552AFA9E.size; _id_A2B11613E4C46ED8++) {
    _id_6F21E5ABF098A6D1 = scripts\mp\utility\player::getplayersinradius((-96, -7001, 1230), self._id_194BFFF0E02C69BB);
    _id_A163C11BC4467538 = self._id_4B7C4E4F552AFA9E[_id_A2B11613E4C46ED8];
    _id_686726AADBD73B45 = self._id_4B32A3FC69BF108C[_id_A2B11613E4C46ED8];
    _id_74DADE39E02D8FEE = scripts\engine\utility::array_randomize(self._id_746D6CA978BE565F);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A163C11BC4467538; _id_AC0E594AC96AA3A8++) {
      wait(randomfloatrange(0.3, 0.5));
      _id_7E832B5C6F2F9F2D(_id_74DADE39E02D8FEE[_id_AC0E594AC96AA3A8], _id_686726AADBD73B45, _id_6F21E5ABF098A6D1);
    }

    thread _id_4764CDA74BD698E0();
    self waittill("wave_cleared", _id_A33817CBCA5F5B92, _id_B107122DE8641235, _id_9ABF330EDF64A73F);
  }

  _id_48814951E916AF89::_id_66A6064FAD612BF3(::_id_F2DB660BD33BCC5E);
  _id_6F21E5ABF098A6D1 = scripts\mp\utility\player::getplayersinradius((-96, -7001, 1230), self._id_194BFFF0E02C69BB);

  foreach(player in _id_6F21E5ABF098A6D1)
  player thread scripts\mp\hud_message::showsplash("br_sealion_sidequest_dojo_end", undefined, undefined, undefined, undefined, "splash_list_br_sealion_sidequest_dojo");

  thread _id_70B18B3F61C8AC1A(_id_9ABF330EDF64A73F, _id_A33817CBCA5F5B92, _id_B107122DE8641235);
  self notify("sidequest_end");
}

_id_70B18B3F61C8AC1A(player, _id_56CA12713E575E0B, _id_B4D6EB8C01F0574C) {
  wait 1;
  _id_BAB0D10E51188531 = [];

  if(isDefined(player))
    _id_BAB0D10E51188531 = scripts\mp\utility\teams::getteamdata(player.team, "players");

  if(!isDefined(_id_56CA12713E575E0B) || !isDefined(_id_B4D6EB8C01F0574C)) {
    _id_56CA12713E575E0B = (-1400, -5747.98, 1301.83);
    _id_B4D6EB8C01F0574C = (0, 0, 0);
  }

  _id_05C607EF7F46F361::_id_467F8B6E641DC16C(self._id_F8C903F8D6D4E353, _id_56CA12713E575E0B, _id_B4D6EB8C01F0574C, _id_BAB0D10E51188531, 0, "sealion_sq_dojo_complete");
}

_id_F09FD68F7BADB8F5() {
  level endon("game_ended");
  self endon("sidequest_end");

  if(level.br_circle_disabled) {
    return;
  }
  _id_3F69BE4080274AC5 = _id_58F20490049AF6AC::_id_60951B84C58915AB((-1451.96, -5747.98, 1301.83));
  _id_0D24B6BA242F5C12 = _id_58F20490049AF6AC::_id_7D8550B9A2C52852(_id_3F69BE4080274AC5);
  wait(_id_0D24B6BA242F5C12);
  _id_A0855282A90C40E9();
}

_id_7E832B5C6F2F9F2D(spawn_point, tier, _id_9907D14293E5472F) {
  _id_4C3337129231E244 = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693("rusher", tier);
  agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(_id_4C3337129231E244, spawn_point.origin, spawn_point.angles, "absolute", "sidequest_dojo", undefined, undefined, "team_hundred_ninety_five", undefined, self._id_E3166F35B0B68F29, 1, 0, 0, undefined, 0);

  if(isDefined(agent) && isai(agent)) {
    agent.ignoreall = 0;

    if(isDefined(_id_9907D14293E5472F)) {
      foreach(player in _id_9907D14293E5472F) {
        if(isDefined(player))
          agent getenemyinfo(player);
      }
    }

    agent setgoalpos(agent.origin, 32.0);
  }

  agent.pathenemyfightdist = 0;
  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "dropWeapon", 0);
  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "dropGrenade", 0);
  agent _id_4F7C27D4FEF4BC09::_id_5213D881F2E26966((-96, -7001, 1230), 3000);
}

_id_F2DB660BD33BCC5E(agent, attacker) {
  _id_55CD6811E34E60DF = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "category");

  if(!scripts\engine\utility::is_equal("sidequest_dojo", _id_55CD6811E34E60DF)) {
    return;
  }
  _id_36242BF26474F8A7 = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "killedByGas");

  if(istrue(_id_36242BF26474F8A7) && !istrue(self._id_E4B9B55EF09D4F53))
    _id_A0855282A90C40E9();

  if(_id_48814951E916AF89::_id_9368FB9261E4CD0A("sidequest_dojo") > 1) {
    return;
  }
  self notify("wave_cleared", agent.origin, agent.angles, attacker);
}

_id_4764CDA74BD698E0() {
  self endon("wave_cleared");
  self endon("sidequest_end");

  while(_id_48814951E916AF89::_id_9368FB9261E4CD0A("sidequest_dojo") > 0)
    wait 1.0;

  waitframe();
  self notify("wave_cleared", undefined, undefined, undefined);
}

_id_A0855282A90C40E9() {
  _id_48814951E916AF89::_id_66A6064FAD612BF3(::_id_F2DB660BD33BCC5E);
  _id_6F21E5ABF098A6D1 = scripts\mp\utility\player::getplayersinradius((-96, -7001, 1230), self._id_194BFFF0E02C69BB);

  foreach(player in _id_6F21E5ABF098A6D1)
  player thread scripts\mp\hud_message::showsplash("br_sealion_sidequest_dojo_fail", undefined, undefined, undefined, undefined, "splash_list_br_sealion_sidequest_dojo");

  self._id_E4B9B55EF09D4F53 = 1;
  self notify("sidequest_end");
}

_id_079F58986383E503(pickup, player) {
  level._id_D8DB1602C8BF473E[pickup.scriptablename] = undefined;
  player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_05E46A45CC69DC1C");
}