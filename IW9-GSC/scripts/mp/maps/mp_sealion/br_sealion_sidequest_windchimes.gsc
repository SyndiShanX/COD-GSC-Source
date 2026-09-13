/**************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_sealion\br_sealion_sidequest_windchimes.gsc
**************************************************************************/

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
  if(!getdvarint("dvar_AC28292C092FDFF4", 0)) {
    return;
  }
  level._id_F385B864293E8777 = spawnStruct();
  level._id_F385B864293E8777 _id_618A1163576C3819();
  level._id_F385B864293E8777 init_locations();
  level._id_F385B864293E8777 thread _id_9D99A6B3C18A711C();
  level._id_F385B864293E8777 thread _id_5DDA9E97C47B0EA3();
}

_id_618A1163576C3819() {
  self._id_D4A3F8D948B36CF5 = 0;
  self._id_E17ABF4B7C27DDC5 = getdvarint("dvar_B9EEDFAEBCCEBA0A", 1);
  self._id_7A6129FE86BEA3F1 = getdvarint("dvar_AE1E4346F5F955B0", 0);
  self._id_55384C655C427167 = getdvarfloat("dvar_D03FCE2ADEF12930", 15);
  self._id_17E70EB167A5DFA6 = _id_05C607EF7F46F361::_id_467F8B6E641DC16C;
  self._id_0EDF373B26C990D0 = [];
  self._id_F7EC79E960E42516 = [];
  self._id_924F10604F27BF91 = [];
}

init_locations() {
  self._id_08B9487AA33EC65C = [];
  self._id_831965D9A3153DFE = [];
  _id_EDC7B3ACAC033F8C(0, (5114, -7356, 870.5), (0, 0, 0));
  _id_EDC7B3ACAC033F8C(1, (4811.5, -9109, 852.3), (0, 234, -90));
  _id_EDC7B3ACAC033F8C(2, (6454.5, -5851, 802), (0, 37, -90));
  _id_EDC7B3ACAC033F8C(3, (6011.5, -8400, 592), (0, 180, 0));
  _id_EDC7B3ACAC033F8C(4, (5712, -9376, 643.5), (0, 0, 0));
  _id_C91D23EB513C69EA(0, (5115.5, -7451, 904.5), (0, 0, 0), (4923, -7798, 767.5));
  _id_C91D23EB513C69EA(1, (4801.5, -9066.5, 954.5), (0, 0, 0), (4373.5, -9462, 711.442));
  _id_C91D23EB513C69EA(2, (6570.75, -5982, 894), (0, 0, 0), (6436, -6608, 704));
  _id_C91D23EB513C69EA(3, (5989, -8468, 679.5), (0, 0, 0), (6175, -8545, 560));
  _id_C91D23EB513C69EA(4, (5647.5, -9348, 637.5), (0, 0, 0), (5600, -9540, 560));
}

_id_EDC7B3ACAC033F8C(_id_DCFF713A65C6F38F, _id_C2D635BFDF4BA6B0, _id_764F77EF8CB87B6A) {
  _id_30E2A1986E8CF6CB = spawnStruct();
  _id_30E2A1986E8CF6CB._id_DCFF713A65C6F38F = _id_DCFF713A65C6F38F;
  _id_30E2A1986E8CF6CB.origin = _id_C2D635BFDF4BA6B0;
  _id_30E2A1986E8CF6CB.angles = _id_764F77EF8CB87B6A;
  self._id_831965D9A3153DFE = scripts\engine\utility::array_add(self._id_831965D9A3153DFE, _id_30E2A1986E8CF6CB);
}

_id_C91D23EB513C69EA(_id_DCFF713A65C6F38F, _id_2C32821835851146, _id_A9527187ABF22FFC, _id_48B5CCEBEF9716EC) {
  _id_61B21C96BA6E34B5 = spawnStruct();
  _id_61B21C96BA6E34B5._id_3BE85B982F955C3E = "as_decor_chimes_01";
  _id_61B21C96BA6E34B5.origin = _id_2C32821835851146;
  _id_61B21C96BA6E34B5.angles = _id_A9527187ABF22FFC;
  _id_61B21C96BA6E34B5._id_48B5CCEBEF9716EC = _id_48B5CCEBEF9716EC;
  _id_61B21C96BA6E34B5._id_4B32CB39BB0627DC = [];

  foreach(location in self._id_831965D9A3153DFE) {
    if(location._id_DCFF713A65C6F38F == _id_DCFF713A65C6F38F)
      _id_61B21C96BA6E34B5._id_4B32CB39BB0627DC[_id_61B21C96BA6E34B5._id_4B32CB39BB0627DC.size] = location;
  }

  self._id_08B9487AA33EC65C = scripts\engine\utility::array_add(self._id_08B9487AA33EC65C, _id_61B21C96BA6E34B5);
}

_id_9D99A6B3C18A711C() {
  _id_88D7A2B341D3E3D7 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++)
    _id_88D7A2B341D3E3D7[_id_88D7A2B341D3E3D7.size] = _id_6AFF3948CF4CCA03::getplundernamebyamount(scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), 50, 80));

  _id_88D7A2B341D3E3D7[_id_88D7A2B341D3E3D7.size] = pickscriptablelootitem("weapon", 4, 4, "mp/loot/br/default/lootset_cache_lege.csv");
  _id_88D7A2B341D3E3D7[_id_88D7A2B341D3E3D7.size] = _id_14183DF6F9AF8737::_id_53382489FF523151();
  _id_88D7A2B341D3E3D7[_id_88D7A2B341D3E3D7.size] = _id_14183DF6F9AF8737::getrandomkillstreak(3);
  self._id_F8C903F8D6D4E353 = _id_88D7A2B341D3E3D7;
}

_id_5DDA9E97C47B0EA3() {
  level endon("game_ended");
  _id_86AA606DBC290168 = [1, 2, 3, 4, 5];
  self._id_86AA606DBC290168 = _id_86AA606DBC290168;
  self._id_08B9487AA33EC65C = scripts\engine\utility::array_randomize(self._id_08B9487AA33EC65C);

  foreach(_id_FE8F7703F6313ED4, _id_EEE5A0CB759FD5D5 in self._id_08B9487AA33EC65C)
  _id_EEE5A0CB759FD5D5 _id_0A795A5A44E066AA(_id_86AA606DBC290168[_id_FE8F7703F6313ED4]);

  _id_3727DA924FC9ACD0(_id_86AA606DBC290168);

  if(getdvarint("dvar_422A83ED915D6F55", 1))
    scripts\mp\flags::gameflagwait("prematch_fade_done");

  foreach(_id_EFEEF04F39DED5D5 in self._id_F7EC79E960E42516) {
    _id_EFEEF04F39DED5D5 setModel("as_decor_chimes_01");
    _id_EFEEF04F39DED5D5 setCanDamage(1);
  }
}

_id_0A795A5A44E066AA(_id_7F233AAB87AAC6DF) {
  _id_EFEEF04F39DED5D5 = spawn("script_model", self.origin);
  _id_EFEEF04F39DED5D5 setCanDamage(0);
  _id_EFEEF04F39DED5D5.angles = self.angles;
  _id_EFEEF04F39DED5D5._id_7F233AAB87AAC6DF = _id_7F233AAB87AAC6DF;
  _id_EFEEF04F39DED5D5._id_48B5CCEBEF9716EC = self._id_48B5CCEBEF9716EC;
  _id_EFEEF04F39DED5D5._id_4B32CB39BB0627DC = self._id_4B32CB39BB0627DC;
  level._id_F385B864293E8777._id_F7EC79E960E42516 = scripts\engine\utility::array_add(level._id_F385B864293E8777._id_F7EC79E960E42516, _id_EFEEF04F39DED5D5);
  _id_EFEEF04F39DED5D5 thread _id_EC30BD7CF10353A4();
}

_id_3727DA924FC9ACD0(_id_86AA606DBC290168) {
  foreach(_id_FE8F7703F6313ED4, location in self._id_F7EC79E960E42516) {
    location._id_363253B80C5DFA19 = scripts\engine\utility::_id_7A2AAA4A09A4D250(location._id_4B32CB39BB0627DC);
    scriptable = spawnscriptable("sealion_sidequest_windchimes_numbers", location._id_363253B80C5DFA19.origin, location._id_363253B80C5DFA19.angles);
    _id_E4ED4D25F622448A = "visible_" + _id_86AA606DBC290168[_id_FE8F7703F6313ED4] + "";
    scriptable setscriptablepartstate("sealion_sidequest_windchimes_numbers", _id_E4ED4D25F622448A);
    self._id_924F10604F27BF91 = scripts\engine\utility::array_add(self._id_924F10604F27BF91, scriptable);
  }
}

_id_EC30BD7CF10353A4() {
  level endon("game_ended");

  for(;;) {
    self waittill("damage", damage, attacker);
    _id_82F11E5ABFAC8A2A = getdvarint("dvar_422A83ED915D6F55", 1);

    if(!level._id_F385B864293E8777._id_D4A3F8D948B36CF5 && (!_id_82F11E5ABFAC8A2A || _id_82F11E5ABFAC8A2A && scripts\mp\flags::gameflag("prematch_fade_done")))
      thread _id_212BB79AEC03BE84(attacker);

    self setscriptablepartstate("windchime_sfx", "play_sfx_" + self._id_7F233AAB87AAC6DF);
    waitframe();
    self setscriptablepartstate("windchime_sfx", "default");
  }
}

_id_212BB79AEC03BE84(eattacker) {
  _id_6B65BF8B75FFB766 = level._id_F385B864293E8777;
  _id_DB4EA7966B4B4C16 = eattacker;

  if(_id_6B65BF8B75FFB766._id_E17ABF4B7C27DDC5)
    _id_DB4EA7966B4B4C16 = eattacker.team;

  if(!isDefined(_id_6B65BF8B75FFB766._id_0EDF373B26C990D0[_id_DB4EA7966B4B4C16]))
    _id_6B65BF8B75FFB766._id_0EDF373B26C990D0[_id_DB4EA7966B4B4C16] = 0;

  _id_45B4FD19621AA16B = _id_6B65BF8B75FFB766._id_0EDF373B26C990D0[_id_DB4EA7966B4B4C16];
  _id_470D00F52D762C51 = _id_6B65BF8B75FFB766._id_86AA606DBC290168[_id_45B4FD19621AA16B];

  if(self._id_7F233AAB87AAC6DF == _id_470D00F52D762C51) {
    self setscriptablepartstate("windchime_vfx", "play_vfx");

    if(_id_45B4FD19621AA16B == 4) {
      _id_6B65BF8B75FFB766 thread _id_27BDE4D2F0BB5620(eattacker, self._id_48B5CCEBEF9716EC);
      return;
    }

    _id_6B65BF8B75FFB766._id_0EDF373B26C990D0[_id_DB4EA7966B4B4C16]++;
    waitframe();
    self setscriptablepartstate("windchime_vfx", "default");
  } else if(getdvarint("dvar_50AD3C1444ED7559", 1))
    _id_6B65BF8B75FFB766._id_0EDF373B26C990D0[_id_DB4EA7966B4B4C16] = 0;
}

_id_27BDE4D2F0BB5620(player, _id_48B5CCEBEF9716EC) {
  self._id_D4A3F8D948B36CF5 = 1;
  _id_A68BD8938E722CBB = player.team;

  foreach(player in level.players) {
    if(isDefined(player) && isalive(player) && !player _id_2CEDCC356F1B9FC8::isplayeringulag()) {
      if(player.team != _id_A68BD8938E722CBB) {
        continue;
      }
      player thread scripts\mp\hud_message::showsplash("br_sealion_sidequest_windchimes_end", undefined, undefined, undefined, undefined, "splash_list_br_sealion_sidequest_windchimes");
    }
  }

  wait 1;
  self.crate = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, player.team, "legendary_supply_drop", _id_48B5CCEBEF9716EC + (0, 0, 4096), (0, randomfloat(360), 0), _id_48B5CCEBEF9716EC);

  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_legendary_supply_drop", "legendary_supply_onCrateUse"))
    scripts\cp_mp\utility\script_utility::registersharedfunc("br_legendary_supply_drop", "legendary_supply_onCrateUse", _id_261E315C49E5E4EF::_id_3241AFDFEC957CB9);

  self.crate.source = "windchimes";
  self.crate._id_08C5EE84D75AB881 = self._id_F8C903F8D6D4E353;
  self.crate._id_036685CC32931D3A = 1;
  self.crate.ammo_count = 2;
  self.crate._id_655E8F8E75379DAE = "sealion_sq_windchimes_complete";
  self._id_EEA4C420836BC8D6 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(self._id_EEA4C420836BC8D6 > -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(self._id_EEA4C420836BC8D6, "current", self.crate.origin, "ui_map_icon_obj_sealion_sidequest_reward");

    if(isDefined(_id_A68BD8938E722CBB)) {
      objective_removeallfrommask(self._id_EEA4C420836BC8D6);
      objective_showtoplayersinmask(self._id_EEA4C420836BC8D6);
      objective_addteamtomask(self._id_EEA4C420836BC8D6, _id_A68BD8938E722CBB);
      objective_setbackground(self._id_EEA4C420836BC8D6, 1);
    }

    objective_onentity(self._id_EEA4C420836BC8D6, self.crate);
    objective_setzoffset(self._id_EEA4C420836BC8D6, 55);
    _func_D76CC64B205084A3(self._id_EEA4C420836BC8D6, 1);
    thread _id_8557C7840DD2B9A6(_id_A68BD8938E722CBB);
    thread _id_FAFBAD0009EDCA2B();
    thread _id_AAD3DAA14AC69436();
  }

  if(self._id_7A6129FE86BEA3F1) {
    _id_65F00AA8A9F3E4F1 = spawnStruct();
    _id_65F00AA8A9F3E4F1.origin = _id_48B5CCEBEF9716EC;
    thread _id_4D5A55FCA0ED1835::docratedropsmoke(undefined, _id_65F00AA8A9F3E4F1, self._id_55384C655C427167);
  }
}

_id_8557C7840DD2B9A6(_id_A68BD8938E722CBB) {
  self.crate waittill("collision");
  scripts\mp\objidpoolmanager::returnobjectiveid(self._id_EEA4C420836BC8D6);
  self._id_EEA4C420836BC8D6 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(self._id_EEA4C420836BC8D6 > -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(self._id_EEA4C420836BC8D6, "current", self.crate.origin, "ui_map_icon_obj_sealion_sidequest_reward");

    if(isDefined(_id_A68BD8938E722CBB)) {
      objective_removeallfrommask(self._id_EEA4C420836BC8D6);
      objective_showtoplayersinmask(self._id_EEA4C420836BC8D6);
      objective_addteamtomask(self._id_EEA4C420836BC8D6, _id_A68BD8938E722CBB);
      objective_setbackground(self._id_EEA4C420836BC8D6, 1);
    }

    objective_position(self._id_EEA4C420836BC8D6, self.crate.origin + (0, 0, 55));
    objective_setdescription(self._id_EEA4C420836BC8D6, &"MP_BR_INGAME/REWARD_ICON_NAME_WINDCHIMES");
    _id_BA48515CE8DADAB4 = self.crate.origin;
    waitframe();

    while(self.crate.origin != _id_BA48515CE8DADAB4) {
      objective_position(self._id_EEA4C420836BC8D6, self.crate.origin + (0, 0, 55));
      _id_BA48515CE8DADAB4 = self.crate.origin;
      waitframe();
    }
  }
}

_id_FAFBAD0009EDCA2B() {
  level endon("game_ended");
  id = self._id_EEA4C420836BC8D6;

  while(isDefined(self.crate))
    waitframe();

  if(isDefined(id))
    scripts\mp\objidpoolmanager::returnobjectiveid(id);

  self notify("end_gas_thread");
}

_id_AAD3DAA14AC69436() {
  level endon("game_ended");
  self endon("end_gas_thread");
  _id_B68217195E5CF6D2 = _id_58F20490049AF6AC::_id_60951B84C58915AB(self.crate.origin);
  _id_6CD08FE827AF3392 = _id_58F20490049AF6AC::_id_7D8550B9A2C52852(_id_B68217195E5CF6D2);
  wait(_id_6CD08FE827AF3392);

  if(isDefined(self._id_EEA4C420836BC8D6))
    scripts\mp\objidpoolmanager::update_objective_state(self._id_EEA4C420836BC8D6, "active");
}