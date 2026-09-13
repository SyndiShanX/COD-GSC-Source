/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_62ef5a31b91bb69d.gsc
***********************************************/

init() {
  level endon("game_ended");

  while(!isDefined(level.struct_class_names) || !isDefined(level.br_pickups))
    waitframe();

  if(getdvarint("dvar_BDA24D8913A553DF", 0) == 1) {
    level thread _id_701449195235BE31::_id_2A171645B15089FF("bunker_back_keypad", 400);
    return;
  }

  level._id_668566D171E33358 = ::_id_D84086B50C326AA0;
  level._id_5A712C9D76830012 = ::_id_D184C5A2664DE51B;
  _id_701449195235BE31::_id_6CAE4397834E60C8("brloot_offhand_thermalphone_node", "brloot_offhand_thermalphone", 2, 1);
  scripts\engine\utility::flag_wait("scriptables_ready");
  _id_A559CE6DD8E982E8();
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_keypad_bunker_interior", ::_id_E9EAC965D8CF5767);
  _id_07919BB8D7505A92 = scripts\engine\utility::getStructArray("bunker_back_keypad", "script_noteworthy");

  foreach(_id_6EFE0C080EEEDD55 in _id_07919BB8D7505A92) {
    _id_6EB04909CB5CA84D = spawnscriptable("maphint_keypad_bunker_interior", _id_6EFE0C080EEEDD55.origin);

    if(!isDefined(_id_6EFE0C080EEEDD55.script_label)) {
      [_id_D05C82AB9C8FB702, _id_A72B841AFDABBF6E] = _id_36610ECB92BA78B9(5, 3);
      _id_8D8D39E90C0CEF94(_id_D05C82AB9C8FB702, _id_A72B841AFDABBF6E);
      _id_6EB04909CB5CA84D _id_525695B62DA3796F(_id_A72B841AFDABBF6E, ::_id_512191058A740C74);
      _id_6EB04909CB5CA84D _id_D72E2B26F769D658(_id_6EFE0C080EEEDD55);
      logstring("PASSWORD OF THIS ROUND IS: " + _id_6EB04909CB5CA84D.code["string"]);
      continue;
    }

    if(_id_6EFE0C080EEEDD55.script_label == "pmc") {
      code = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
      _id_DDDC705D1DA7078A = scripts\engine\utility::_id_7A2AAA4A09A4D250(code);
      _id_DDDC6F5D1DA70557 = scripts\engine\utility::_id_7A2AAA4A09A4D250(code);
      _id_DDDC6E5D1DA70324 = scripts\engine\utility::_id_7A2AAA4A09A4D250(code);
      _id_6EB04909CB5CA84D _id_525695B62DA3796F([_id_DDDC705D1DA7078A, _id_DDDC6F5D1DA70557, _id_DDDC6E5D1DA70324], ::_id_4E1B724288222A0F);
      _id_29EEB793C67C5C1D = scripts\engine\utility::getStruct(_id_6EFE0C080EEEDD55.target, "targetname");
      door = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius(_id_29EEB793C67C5C1D.origin, 100);
      _id_6EB04909CB5CA84D.door = door[0];
      level._id_DAB6C0F07F8DF447 = _id_6EB04909CB5CA84D.code["string"];
    }
  }

  level waittill("matchStartTimer_done");

  foreach(player in level.players)
  _id_D184C5A2664DE51B(player);
}

_id_A559CE6DD8E982E8() {
  level._id_C3E836AA42332524 = [];
  _id_46645C55A70BE92F = getscriptablearray("code_on_wall_hint", "script_noteworthy");

  foreach(_id_52145FC3D0FAB939 in _id_46645C55A70BE92F) {
    hint = spawnStruct();
    hint._id_2A54822CD9478401 = _id_52145FC3D0FAB939;
    _id_2BB71B2F127A70A6 = getscriptablearray(_id_52145FC3D0FAB939.targetname, "targetname");

    foreach(part in _id_2BB71B2F127A70A6) {
      if(issubstr(part.classname, "code_on_wall_letters")) {
        hint._id_3FE6A66DBFBA3CC6 = part;
        continue;
      }

      if(issubstr(part.classname, "code_on_wall_decal")) {
        hint._id_CD121E7958EDC3B7 = part;
        _id_479E458F6F530F0D::_id_F0D61E14DFDE9CCD(hint._id_CD121E7958EDC3B7);
      }
    }

    level._id_C3E836AA42332524[level._id_C3E836AA42332524.size] = hint;
  }

  level._id_FF38E3A8F17A70FE = [];
  _id_46645C55A70BE92F = getscriptablearray("cow_panel_hint", "targetname");

  foreach(_id_52145FC3D0FAB939 in _id_46645C55A70BE92F)
  level._id_FF38E3A8F17A70FE[level._id_FF38E3A8F17A70FE.size] = _id_52145FC3D0FAB939;

  level._id_A4713EF3075623A5 = [];
  _id_BF40240E76BAFB50 = scripts\engine\utility::getStructArray("thermal_arrow", "script_noteworthy");

  foreach(_id_E6BE399CE64AE703 in _id_BF40240E76BAFB50) {
    _id_C83AA9DBC3654AFA = spawn("script_model", _id_E6BE399CE64AE703.origin);
    _id_C83AA9DBC3654AFA.angles = _id_E6BE399CE64AE703.angles;
    _id_C83AA9DBC3654AFA setModel("sign_thermal_phone_arrow_02");

    if(isDefined(_id_E6BE399CE64AE703.targetname) && _id_E6BE399CE64AE703.targetname == "with_radiation")
      _id_479E458F6F530F0D::_id_F0D61E14DFDE9CCD(_id_C83AA9DBC3654AFA);

    level._id_A4713EF3075623A5[level._id_A4713EF3075623A5.size] = _id_C83AA9DBC3654AFA;
  }
}

_id_D84086B50C326AA0(player) {
  foreach(_id_0CD5967AD0DA78AD in level._id_C3E836AA42332524) {
    if(isDefined(_id_0CD5967AD0DA78AD._id_CD121E7958EDC3B7))
      _id_0CD5967AD0DA78AD._id_CD121E7958EDC3B7 showtoplayer(player);

    if(isDefined(_id_0CD5967AD0DA78AD._id_2A54822CD9478401))
      _id_0CD5967AD0DA78AD._id_2A54822CD9478401 showtoplayer(player);

    if(isDefined(_id_0CD5967AD0DA78AD._id_3FE6A66DBFBA3CC6))
      _id_0CD5967AD0DA78AD._id_3FE6A66DBFBA3CC6 showtoplayer(player);
  }

  foreach(_id_6C4933CF1CD3C78D in level._id_FF38E3A8F17A70FE)
  _id_6C4933CF1CD3C78D showtoplayer(player);

  foreach(_id_98A02BF461F1B08C in level._id_A4713EF3075623A5)
  _id_98A02BF461F1B08C showtoplayer(player);
}

_id_D184C5A2664DE51B(player) {
  foreach(_id_0CD5967AD0DA78AD in level._id_C3E836AA42332524) {
    if(isDefined(_id_0CD5967AD0DA78AD._id_2A54822CD9478401))
      _id_0CD5967AD0DA78AD._id_2A54822CD9478401 hidefromplayer(player);

    if(isDefined(_id_0CD5967AD0DA78AD._id_3FE6A66DBFBA3CC6))
      _id_0CD5967AD0DA78AD._id_3FE6A66DBFBA3CC6 hidefromplayer(player);

    if(isDefined(_id_0CD5967AD0DA78AD._id_CD121E7958EDC3B7))
      _id_0CD5967AD0DA78AD._id_CD121E7958EDC3B7 hidefromplayer(player);
  }

  foreach(_id_6C4933CF1CD3C78D in level._id_FF38E3A8F17A70FE)
  _id_6C4933CF1CD3C78D hidefromplayer(player);

  foreach(_id_98A02BF461F1B08C in level._id_A4713EF3075623A5)
  _id_98A02BF461F1B08C hidefromplayer(player);
}

_id_525695B62DA3796F(code, _id_B075106686DFD0DF) {
  self._id_885780D268327BA4 = code.size;
  self.code = [];
  self.code["string"] = "";
  self.successfunction = _id_B075106686DFD0DF;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < code.size; _id_AC0E594AC96AA3A8++)
    self.code["string"] = self.code["string"] + code[_id_AC0E594AC96AA3A8];
}

_id_D72E2B26F769D658(loc) {
  doors = getentitylessscriptablearray(loc.target, "targetname");
  door = doors[0];

  if(isDefined(door)) {
    self.door = door;
    _id_3F57BCE790B3F25E = getEnt(door.target, "targetname");

    if(isDefined(_id_3F57BCE790B3F25E)) {
      door._id_3F57BCE790B3F25E = _id_3F57BCE790B3F25E;
      doorclip = getEnt(_id_3F57BCE790B3F25E.target, "targetname");
      doorclip linkTo(_id_3F57BCE790B3F25E);
      door._id_3F57BCE790B3F25E.doorclip = doorclip;
      door._id_3F57BCE790B3F25E disconnectPaths();
      return;
    }

    return;
  } else {}
}

_id_512191058A740C74(_id_6EB04909CB5CA84D) {
  _id_5F8753D360CD9D25 = [-102, 5.5, 0.1, 0.5];
  _id_6EB04909CB5CA84D.door setscriptablepartstate("bunkerdoor", "opening", 0);
  _id_6EB04909CB5CA84D.door._id_3F57BCE790B3F25E thread _id_701449195235BE31::_id_2AB59E04B43701ED(_id_5F8753D360CD9D25[0], _id_5F8753D360CD9D25[1], _id_5F8753D360CD9D25[2], _id_5F8753D360CD9D25[3]);
  _id_3D732BB6A256ADFD::_id_D50D0A086958E440("stat_73698E98EEE3B648", "missionCompleted");
  _id_6A8EC730B2BFA844::_id_7616962F7C523A5D(self);
}

_id_4E1B724288222A0F(_id_6EB04909CB5CA84D) {
  door = _id_6EB04909CB5CA84D.door;
  _id_57D3850A12CF1D8F::_id_B092780F9EC4496E(door);
  _id_6A8EC730B2BFA844::_id_8B3BE362BFF6847F(self);
}

_id_8D8D39E90C0CEF94(_id_D05C82AB9C8FB702, _id_A72B841AFDABBF6E) {
  letters = ["a", "b", "c", "d", "e"];
  _id_E3AE92B8C5AD88D0 = scripts\engine\utility::array_randomize(letters);
  _id_AB86BDB7535F6172 = scripts\engine\utility::array_randomize(level._id_C3E836AA42332524);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D05C82AB9C8FB702.size; _id_AC0E594AC96AA3A8++) {
    _id_AB86BDB7535F6172[_id_AC0E594AC96AA3A8]._id_2A54822CD9478401 setscriptablepartstate("model", "" + _id_D05C82AB9C8FB702[_id_AC0E594AC96AA3A8]);
    _id_AB86BDB7535F6172[_id_AC0E594AC96AA3A8]._id_3FE6A66DBFBA3CC6 setscriptablepartstate("model", _id_E3AE92B8C5AD88D0[_id_AC0E594AC96AA3A8]);
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A72B841AFDABBF6E.size; _id_AC0E594AC96AA3A8++)
    level._id_FF38E3A8F17A70FE[_id_AC0E594AC96AA3A8] setscriptablepartstate("model", _id_E3AE92B8C5AD88D0[_id_AC0E594AC96AA3A8]);
}

_id_36610ECB92BA78B9(_id_2ABBF07783249758, _id_885780D268327BA4) {
  numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  numbers = scripts\engine\utility::array_randomize(numbers);
  _id_D05C82AB9C8FB702 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2ABBF07783249758; _id_AC0E594AC96AA3A8++)
    _id_D05C82AB9C8FB702[_id_AC0E594AC96AA3A8] = numbers[_id_AC0E594AC96AA3A8];

  _id_A72B841AFDABBF6E = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_885780D268327BA4; _id_AC0E594AC96AA3A8++)
    _id_A72B841AFDABBF6E[_id_AC0E594AC96AA3A8] = numbers[_id_AC0E594AC96AA3A8];

  return [_id_D05C82AB9C8FB702, _id_A72B841AFDABBF6E];
}

_id_E9EAC965D8CF5767(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  _id_87706707D1A8F420 = 2;
  _id_B5056FD27D24527A = 0;
  _id_1DF19819FC6EF3F7 = scripts\engine\utility::ter_op(istrue(instance._id_7FB2B43C09485D2C), "_model", "");
  instance setscriptablepartstate(part, "off" + _id_1DF19819FC6EF3F7);
  player _id_7D625073C6379D53::keypad_playerinteractwithkeypadloop(instance);

  if(isDefined(player))
    player _id_0B8A0932FDC35B80::playersetkeypadstateindex(_id_B5056FD27D24527A);

  wait 1;

  if(instance._id_B50F7CB6D7639B3A != _id_87706707D1A8F420)
    instance setscriptablepartstate(part, "on" + _id_1DF19819FC6EF3F7);
}