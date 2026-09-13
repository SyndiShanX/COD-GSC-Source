/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_58b1eca22500284f.gsc
***********************************************/

_id_88FBE091EBBDA87C() {
  if(getdvarint("dvar_F8B075119C563072", 1) == 0) {
    return;
  }
  level._id_C6D8A22182E47EDD = spawnStruct();
  level._id_C6D8A22182E47EDD._id_BD67AA0990219283 = 0;
  level._id_C6D8A22182E47EDD._id_7039E552E73D25A1 = undefined;
  level._id_C6D8A22182E47EDD._id_48C882AEA7E3896F = -1;

  if(level.mapname == "mp_ai_firefight") {
    level._id_C6D8A22182E47EDD._id_BBA978AAB35DB160 = (1716, 1566, 200);
    level._id_C6D8A22182E47EDD._id_9ED3F1945D363261 = (1716, 1566, 200);
  } else if(level.mapname == "mp_biobunker") {
    level._id_C6D8A22182E47EDD._id_BBA978AAB35DB160 = (-9085, 11650, 1695);
    level._id_C6D8A22182E47EDD._id_9ED3F1945D363261 = (-9085, 11681, 1695);
  }

  level._id_C6D8A22182E47EDD._id_35B62437221AF0E5 = spawnscriptable("dmz_biobunker_shopkeeper_voice", level._id_C6D8A22182E47EDD._id_BBA978AAB35DB160, (0, 0, 0));
  level._id_C6D8A22182E47EDD._id_4E6E1A3A72BD88D2 = scripts\engine\utility::getStructArray("shoppingListLoc", "targetname");
  level._id_C6D8A22182E47EDD._id_E57F4A6F7E313E90 = undefined;

  if(getdvarint("dvar_FBEB3E3EDCE37B14", 0))
    level._id_C6D8A22182E47EDD._id_E57F4A6F7E313E90 = scripts\engine\utility::getStructArray("shoppingListDebugItem", "targetname");

  level._id_C6D8A22182E47EDD._id_3FA3E4E3ABB61E4D = [];
  level._id_C6D8A22182E47EDD._id_41701EF07A1F9FE8 = [];
  level._id_C6D8A22182E47EDD._id_18685E9D0375A313 = [];
  level thread _id_5B927062B844E007();
  level thread _id_9DFC2BB48A54CD50();
  level thread _id_68613DF3DD9C24A1();
  level thread _id_C17CFC74E781A94A();
}

_id_C17CFC74E781A94A() {
  level endon("game_ended");
  interval = 0.1;
  _id_919026833C44ED10 = 0;

  for(;;) {
    _id_2C12590F73A533C9 = 0;
    _id_75DE05D60A5C11AC = _id_A8501C6FE24440EB();

    if(istrue(_id_75DE05D60A5C11AC)) {
      _id_2C12590F73A533C9 = _id_D6C06E62BEFCF33F("CombatAround", 3);

      if(istrue(_id_2C12590F73A533C9))
        _id_919026833C44ED10 = 0;
    }

    if(!istrue(_id_2C12590F73A533C9)) {
      player = _id_DEA6A60B8E33598F(level._id_C6D8A22182E47EDD._id_BBA978AAB35DB160);

      if(isDefined(player)) {
        _id_2C12590F73A533C9 = _id_DD677378528C056F(player);

        if(istrue(_id_2C12590F73A533C9))
          _id_919026833C44ED10 = 0;
      }
    }

    if(!istrue(_id_2C12590F73A533C9) && _id_919026833C44ED10 > 7) {
      _id_2C12590F73A533C9 = _id_D6C06E62BEFCF33F("RandomIdle", 1);

      if(istrue(_id_2C12590F73A533C9))
        _id_919026833C44ED10 = 0;
    }

    wait(interval);
    _id_919026833C44ED10 = _id_919026833C44ED10 + interval;
  }
}

_id_D89D7E1FA23F3CEE() {
  level._id_C6D8A22182E47EDD._id_35B62437221AF0E5 setscriptablepartstate("speaker", "off");
  waitframe();
}

_id_F3756F0695358FE3() {
  level endon("game_ended");
  level._id_C6D8A22182E47EDD._id_35B62437221AF0E5 notify("speaking_priority_reset");
  level._id_C6D8A22182E47EDD._id_35B62437221AF0E5 endon("speaking_priority_reset");
  wait 8;
  level._id_C6D8A22182E47EDD._id_BD67AA0990219283 = 0;
}

_id_DD677378528C056F(player) {
  if(!isDefined(player)) {
    return;
  }
  if(scripts\engine\utility::array_contains(level._id_C6D8A22182E47EDD._id_3FA3E4E3ABB61E4D, player) && scripts\engine\utility::array_contains(level._id_C6D8A22182E47EDD._id_18685E9D0375A313, player)) {
    level._id_C6D8A22182E47EDD._id_18685E9D0375A313 = scripts\engine\utility::array_remove(level._id_C6D8A22182E47EDD._id_18685E9D0375A313, player);
    return _id_D6C06E62BEFCF33F("PlayersApproachAgain", 2);
  } else if(!scripts\engine\utility::array_contains(level._id_C6D8A22182E47EDD._id_3FA3E4E3ABB61E4D, player)) {
    level._id_C6D8A22182E47EDD._id_3FA3E4E3ABB61E4D[level._id_C6D8A22182E47EDD._id_3FA3E4E3ABB61E4D.size] = player;
    return _id_D6C06E62BEFCF33F("ApproachFirstTime", 2);
  }
}

_id_DEA6A60B8E33598F(origin) {
  players = scripts\mp\utility\player::getplayersinradius(level._id_C6D8A22182E47EDD._id_BBA978AAB35DB160, 512);
  _id_F693DB2B79EE3819 = 256;
  _id_67E54DC8917A5918 = [];

  foreach(player in players) {
    if(!isalive(player)) {
      continue;
    }
    if(abs(player.origin[2] - level._id_C6D8A22182E47EDD._id_BBA978AAB35DB160[0] < _id_F693DB2B79EE3819))
      _id_67E54DC8917A5918[_id_67E54DC8917A5918.size] = player;
  }

  players = sortbydistance(_id_67E54DC8917A5918, level._id_C6D8A22182E47EDD._id_BBA978AAB35DB160);
  _id_41701EF07A1F9FE8 = [];

  foreach(player in players) {
    _id_B9352A31FDB74279 = sighttracepassed(level._id_C6D8A22182E47EDD._id_9ED3F1945D363261, player getEye(), 0, undefined);

    if(_id_B9352A31FDB74279) {
      _id_41701EF07A1F9FE8[_id_41701EF07A1F9FE8.size] = player;
      continue;
    }

    if(scripts\engine\utility::array_contains(level._id_C6D8A22182E47EDD._id_41701EF07A1F9FE8, player))
      level._id_C6D8A22182E47EDD._id_18685E9D0375A313[level._id_C6D8A22182E47EDD._id_18685E9D0375A313.size] = player;
  }

  level._id_C6D8A22182E47EDD._id_41701EF07A1F9FE8 = _id_41701EF07A1F9FE8;
  return _id_41701EF07A1F9FE8[0];
}

_id_A8501C6FE24440EB() {
  if(isDefined(level._id_33A2175A9A4306BC) && istrue(level._id_33A2175A9A4306BC._id_009BADBB469626F6)) {
    if(distance2d(level._id_C6D8A22182E47EDD._id_BBA978AAB35DB160, level._id_33A2175A9A4306BC.origin) - level._id_33A2175A9A4306BC.radius < 1500)
      return 0;
  }

  _id_E3FDA941919216D6 = scripts\mp\utility\entity::_id_D9CE8FB00F0E5FA1(level._id_C6D8A22182E47EDD._id_BBA978AAB35DB160, 768);

  foreach(ent in _id_E3FDA941919216D6) {
    if(!isDefined(ent)) {
      continue;
    }
    if(isalive(ent)) {
      if(isPlayer(ent)) {
        if(ent scripts\mp\utility\player::isincombat() || istrue(ent.inlaststand))
          return 1;
      } else if(isagent(ent)) {
        if(!istrue(ent.stealth_enabled)) {
          if(isDefined(ent.enemy))
            return 1;
        } else if(ent[[ent.fnisinstealthcombat]]())
          return 1;
      }
    }
  }

  return 0;
}

_id_9DFC2BB48A54CD50() {
  scripts\mp\flags::_id_1240434F4201AC9D("prematch_done");
  waitframe();

  foreach(_id_2FA65F34EB9042F5 in level.br_armory_kiosk.scriptables) {
    if(isDefined(_id_2FA65F34EB9042F5._id_5EA299587B551F9F) && _id_2FA65F34EB9042F5._id_5EA299587B551F9F == "dmz_biobunker")
      level._id_C6D8A22182E47EDD._id_2FA65F34EB9042F5 = _id_2FA65F34EB9042F5;
  }

  level thread _id_D49EF0C9DB01CE16();
}

_id_D49EF0C9DB01CE16() {
  level endon("game_ended");

  for(;;) {
    state = level._id_C6D8A22182E47EDD._id_2FA65F34EB9042F5 getscriptablepartstate("br_plunder_box");

    if(state == "opening" || state == "open") {
      break;
    }

    waitframe();
  }

  _id_D6C06E62BEFCF33F("PlayerOpenFreeBuyStation", 3);
  _id_AD62E88241ED114D = level._id_C6D8A22182E47EDD._id_2FA65F34EB9042F5.playersusing.size;

  for(;;) {
    if(level._id_C6D8A22182E47EDD._id_2FA65F34EB9042F5.playersusing.size > _id_AD62E88241ED114D)
      _id_D6C06E62BEFCF33F("PlayerOpenFreeBuyStation", 2);

    _id_AD62E88241ED114D = level._id_C6D8A22182E47EDD._id_2FA65F34EB9042F5.playersusing.size;
    wait 1;
  }
}

_id_68613DF3DD9C24A1() {
  scripts\mp\flags::_id_1240434F4201AC9D("prematch_done");
  waitframe();

  foreach(_id_2FA65F34EB9042F5 in level.br_armory_kiosk.scriptables) {
    if(isDefined(_id_2FA65F34EB9042F5._id_5EA299587B551F9F) && _id_2FA65F34EB9042F5._id_5EA299587B551F9F == "dmz_biobunker_high_tier") {
      level._id_C6D8A22182E47EDD._id_6F3DAB194C75E802 = _id_2FA65F34EB9042F5;

      if(isDefined(level._id_C6D8A22182E47EDD._id_6F3DAB194C75E802._id_AFC028D00356E443))
        level._id_C6D8A22182E47EDD._id_6F3DAB194C75E802._id_AFC028D00356E443 = level._id_C6D8A22182E47EDD._id_6F3DAB194C75E802._id_AFC028D00356E443 + (0, 0, -2.5);

      _id_2FA65F34EB9042F5._id_08B199355950FB72 = 1;
      _id_342E51952B63E594::_id_45EEFC63956143ED(_id_2FA65F34EB9042F5, "barter_recipe_list_iw9_biobunker_shopkeeper");
    }
  }

  _id_4384ABBF498DF6A7::_id_0233A7ADC7A673BE(level._id_C6D8A22182E47EDD._id_6F3DAB194C75E802);
  level thread _id_36186F6BC0210D19();
}

_id_36186F6BC0210D19() {
  level endon("game_ended");
  _id_E78F7F72026B2759 = 0;

  for(;;) {
    state = level._id_C6D8A22182E47EDD._id_6F3DAB194C75E802 getscriptablepartstate("br_plunder_box");

    if(state == "opening" || state == "open") {
      break;
    }

    if(isDefined(level._id_C6D8A22182E47EDD._id_6F3DAB194C75E802._id_8D6DBCF5443A11F0) && level._id_C6D8A22182E47EDD._id_6F3DAB194C75E802._id_8D6DBCF5443A11F0 > _id_E78F7F72026B2759) {
      _id_D6C06E62BEFCF33F("UseLockedRewardStation", 3);
      _id_E78F7F72026B2759 = level._id_C6D8A22182E47EDD._id_6F3DAB194C75E802._id_8D6DBCF5443A11F0;
    }

    waitframe();
  }

  _id_D6C06E62BEFCF33F("UseUnlockedRewardStation", 4);
  _id_AD62E88241ED114D = level._id_C6D8A22182E47EDD._id_6F3DAB194C75E802.playersusing.size;

  for(;;) {
    if(level._id_C6D8A22182E47EDD._id_6F3DAB194C75E802.playersusing.size > _id_AD62E88241ED114D)
      _id_D6C06E62BEFCF33F("UseUnlockedRewardStation", 2);

    _id_AD62E88241ED114D = level._id_C6D8A22182E47EDD._id_6F3DAB194C75E802.playersusing.size;
    wait 1;
  }
}

_id_2693581ED81D3CDB() {
  _id_4384ABBF498DF6A7::_id_3B1235B668CB5C71(level._id_C6D8A22182E47EDD._id_6F3DAB194C75E802);
}

_id_5B927062B844E007() {
  _id_8EBBF5D649145AB9 = [];

  if(getdvarint("dvar_DD86E03EC61B9DD6", 0))
    _id_8EBBF5D649145AB9["test"] = ["equip_frag", "equip_smoke"];
  else {
    _id_8EBBF5D649145AB9["bb_shopkeeper_list_01"] = ["brloot_valuable_bunker_notes_common", "brloot_valuable_bunker_server_tape_uncommon", "brloot_valuable_bunker_board_common"];
    _id_8EBBF5D649145AB9["bb_shopkeeper_list_02"] = ["brloot_valuable_bunker_notes_uncommon", "brloot_valuable_bunker_server_tape_common", "brloot_valuable_bunker_chlorine"];
    _id_8EBBF5D649145AB9["bb_shopkeeper_list_03"] = ["brloot_valuable_bunker_formaldehyde", "brloot_valuable_bunker_acetic_acid", "brloot_valuable_bunker_server_tape_uncommon"];
    _id_8EBBF5D649145AB9["bb_shopkeeper_list_04"] = ["brloot_valuable_bunker_notes_rare", "brloot_valuable_bunker_server_tape_rare"];
    _id_8EBBF5D649145AB9["bb_shopkeeper_list_05"] = ["brloot_valuable_bunker_sulfuric_acid", "brloot_valuable_bunker_notes_uncommon"];
    _id_8EBBF5D649145AB9["bb_shopkeeper_list_06"] = ["brloot_valuable_bunker_notes_epic", "brloot_valuable_bunker_board_uncommon"];
    _id_8EBBF5D649145AB9["bb_shopkeeper_list_07"] = ["brloot_valuable_bunker_board_epic", "brloot_valuable_bunker_notes_rare"];
  }

  _id_A1165E9078BC3654 = getarraykeys(_id_8EBBF5D649145AB9);
  _id_E22D4969CB9F2BFE = scripts\engine\utility::random(_id_A1165E9078BC3654);
  scripts\mp\flags::_id_1240434F4201AC9D("prematch_done");
  _id_304F476283F6D36E::_id_466D1FC9A557D7C9("bb_shoppingListLoc", _id_E22D4969CB9F2BFE);
  waitframe();

  foreach(_id_5793A0CF9D352C92 in level._id_CED78996BBF1B2D3) {
    if(isDefined(_id_5793A0CF9D352C92.type) && _id_5793A0CF9D352C92.type == "dmz_dead_drop_transaction_drawer")
      level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92 = _id_5793A0CF9D352C92;
  }

  level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92._id_5C7408F4A44005E6 = _id_8EBBF5D649145AB9[_id_E22D4969CB9F2BFE];

  if(isDefined(level._id_C6D8A22182E47EDD._id_E57F4A6F7E313E90))
    _id_53CB4B428D14444E();

  _id_471C5970300E0CB0(["brloot_valuable_sealion_luckycat", "brloot_valuable_sealion_dogbank"], _id_6A8EC730B2BFA844::_id_38D565BD866CED0E);
  _id_471C5970300E0CB0(["brloot_valuable_liquor"], _id_6A8EC730B2BFA844::_id_C543832FAB9303CB);
  _id_471C5970300E0CB0(["brloot_valuable_rare_dogbank"], _id_6A8EC730B2BFA844::_id_F3F7CF5AA591A391);
  level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92.playersused = [];
  level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92._id_465361013186AA4C = [];
  level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92._id_2CC2B26893D5A8B6 = [];
  level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92._id_50657BCF5BB1ED14 = ::_id_0400A665F959F1C4;
  level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92._id_7FF4ADF1A6C36A48 = ::_id_C7EA55D0E15707E6;
}

_id_0400A665F959F1C4(player) {
  if(!scripts\engine\utility::array_contains(level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92.playersused, player)) {
    level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92.playersused[level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92.playersused.size] = player;
    _id_D6C06E62BEFCF33F("PlayerUseBoxFirstTime", 4);
  } else
    _id_D6C06E62BEFCF33F("PlayersUseGeneral", 3);
}

_id_471C5970300E0CB0(itemlist, callback) {
  if(!isDefined(level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92._id_2084AB8D06FC75F3))
    level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92._id_2084AB8D06FC75F3 = [];

  _id_5DE46ADBB510F463 = level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92._id_2084AB8D06FC75F3.size;
  level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92._id_2084AB8D06FC75F3[_id_5DE46ADBB510F463] = spawnStruct();
  level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92._id_2084AB8D06FC75F3[_id_5DE46ADBB510F463].list = itemlist;
  level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92._id_2084AB8D06FC75F3[_id_5DE46ADBB510F463].callback = callback;
  level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92._id_2084AB8D06FC75F3[_id_5DE46ADBB510F463]._id_C82DFE214C069C6C = [];
}

_id_CDD53BCF36C9DFE4(item) {
  foreach(_id_D89286DB53D9FE8A in level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92._id_2084AB8D06FC75F3) {
    if(scripts\engine\utility::array_contains(_id_D89286DB53D9FE8A.list, item))
      return 1;
  }

  return 0;
}

_id_D7DCFF7D37237950(player, _id_5793A0CF9D352C92) {
  foreach(_id_D89286DB53D9FE8A in level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92._id_2084AB8D06FC75F3) {
    if(_id_338F5DE6D3ECB78B(player.team, _id_D89286DB53D9FE8A.list) && !scripts\engine\utility::array_contains(_id_D89286DB53D9FE8A._id_C82DFE214C069C6C, player.team)) {
      [[_id_D89286DB53D9FE8A.callback]](player, _id_5793A0CF9D352C92);
      _id_D89286DB53D9FE8A._id_C82DFE214C069C6C[_id_D89286DB53D9FE8A._id_C82DFE214C069C6C.size] = player.team;
    }
  }
}

_id_0001F4431C20DA8B(team, items) {
  _id_1A6D3B0183F59962 = [];

  foreach(item in items)
  _id_1A6D3B0183F59962[item] = 0;

  return _id_1A6D3B0183F59962;
}

_id_2667078CD7D32E65(team, array) {
  foreach(_id_57734DB0DA4FB01B in array[team]) {
    if(!_id_57734DB0DA4FB01B)
      return 0;
  }

  return 1;
}

_id_338F5DE6D3ECB78B(team, array) {
  if(!isDefined(level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92._id_2CC2B26893D5A8B6) || !isDefined(level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92._id_2CC2B26893D5A8B6[team]))
    return 0;

  foreach(item in array) {
    if(!istrue(level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92._id_2CC2B26893D5A8B6[team][item]))
      return 0;
  }

  return 1;
}

_id_C7EA55D0E15707E6(_id_E1CF43F3AE9D77E7, player) {
  _id_45161B0CC87EACED = 0;

  foreach(struct in _id_E1CF43F3AE9D77E7) {
    if(struct.lootid != 0) {
      _id_45161B0CC87EACED = 1;
      break;
    }
  }

  if(!_id_45161B0CC87EACED) {
    return;
  }
  if(!level._id_C6D8A22182E47EDD._id_6F3DAB194C75E802.locked)
    _id_D6C06E62BEFCF33F("DepositGeneral", 2);

  if(!isDefined(level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92._id_465361013186AA4C[player.team]))
    level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92._id_465361013186AA4C[player.team] = _id_0001F4431C20DA8B(player.team, level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92._id_5C7408F4A44005E6);

  if(!isDefined(level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92._id_2CC2B26893D5A8B6[player.team]))
    level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92._id_2CC2B26893D5A8B6[player.team] = [];

  _id_B7A23086776412AD = 0;
  _id_B3A9E27FFF924C96 = 0;
  _id_4726CA55B7EB6C19 = _id_6A8EC730B2BFA844::_id_16AE6D8B5F25F31B("trade_keycode");
  _id_AADFB8482B27EA43 = _id_6A8EC730B2BFA844::_id_C5E0BAC8F123CC88(player.team, _id_4726CA55B7EB6C19);

  foreach(item in _id_E1CF43F3AE9D77E7) {
    ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(item.lootid);

    if(scripts\engine\utility::array_contains(level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92._id_5C7408F4A44005E6, ref)) {
      if(!level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92._id_465361013186AA4C[player.team][ref]) {
        level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92._id_465361013186AA4C[player.team][ref] = 1;
        _id_B7A23086776412AD = 1;
      } else
        _id_B3A9E27FFF924C96 = 1;
    }

    if(_id_CDD53BCF36C9DFE4(ref))
      level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92._id_2CC2B26893D5A8B6[player.team][ref] = 1;
  }

  _id_5AE592D099951346 = _id_2667078CD7D32E65(player.team, level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92._id_465361013186AA4C);
  _id_D7DCFF7D37237950(player, level._id_C6D8A22182E47EDD._id_5793A0CF9D352C92);

  if(_id_5AE592D099951346 || _id_B7A23086776412AD || _id_B3A9E27FFF924C96)
    _id_6A8EC730B2BFA844::_id_93AB9968BF96E2B0(player);

  if(_id_5AE592D099951346) {
    _id_D6C06E62BEFCF33F("DepositRewardStationUnlockComplete", 4);
    _id_2693581ED81D3CDB();
    return;
  }

  if(_id_B7A23086776412AD) {
    _id_D6C06E62BEFCF33F("DepositRewardStationUnlockPartial", 2);
    return;
  }

  if(_id_B3A9E27FFF924C96) {
    _id_D6C06E62BEFCF33F("DepositRewardStationUnlockRepeat", 2);
    return;
  }

  _id_D6C06E62BEFCF33F("DepositGeneral", 2);
}

_id_A5A6E50F5442F0FE(_id_49DCCE316989A19C) {
  if(!isDefined(_id_49DCCE316989A19C)) {
    return;
  }
  foreach(loc in level._id_C6D8A22182E47EDD._id_4E6E1A3A72BD88D2) {
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(loc.origin, loc.angles + (90, 0, 0));
    _id_7E52B56769FA7774::spawnpickup(_id_49DCCE316989A19C, _id_CB4FAD49263E20C4);
  }
}

_id_53CB4B428D14444E() {
  foreach(loc in level._id_C6D8A22182E47EDD._id_E57F4A6F7E313E90) {
    offset = (0, 0, 0);

    if(issubstr(loc._id_2B7395B3855CE24F, "note"))
      offset = (90, 0, 0);

    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(loc.origin, loc.angles + offset);
    _id_7E52B56769FA7774::spawnpickup(loc._id_2B7395B3855CE24F, _id_CB4FAD49263E20C4);
  }
}

_id_D6C06E62BEFCF33F(_id_C7B61F413AD4EC68, priority, _id_CD40AC65A2951F58, _id_CD63C265A2BB9772) {
  return level._id_C6D8A22182E47EDD._id_35B62437221AF0E5 _id_2477CC89494291A1(level._id_C6D8A22182E47EDD._id_35B62437221AF0E5, _id_C7B61F413AD4EC68, priority, _id_CD40AC65A2951F58, _id_CD63C265A2BB9772);
}

_id_2477CC89494291A1(_id_7D2852D02216C876, _id_C7B61F413AD4EC68, priority, _id_CD40AC65A2951F58, _id_CD63C265A2BB9772) {
  if(!isDefined(_id_CD40AC65A2951F58))
    _id_CD40AC65A2951F58 = 0.05;

  if(!isDefined(_id_CD63C265A2BB9772))
    _id_CD63C265A2BB9772 = 0.07;

  if(!isDefined(priority))
    priority = 1;

  if(level._id_C6D8A22182E47EDD._id_BD67AA0990219283 > priority) {
    return;
  }
  if(isDefined(level._id_C6D8A22182E47EDD._id_7039E552E73D25A1) && level._id_C6D8A22182E47EDD._id_7039E552E73D25A1 == _id_C7B61F413AD4EC68 && level._id_C6D8A22182E47EDD._id_48C882AEA7E3896F + 8000 >= gettime()) {
    return;
  }
  wait(randomfloatrange(_id_CD40AC65A2951F58, _id_CD63C265A2BB9772));
  _id_D89D7E1FA23F3CEE();

  if(0) {}

  level._id_C6D8A22182E47EDD._id_BD67AA0990219283 = priority;
  level._id_C6D8A22182E47EDD._id_48C882AEA7E3896F = gettime();
  level._id_C6D8A22182E47EDD._id_7039E552E73D25A1 = _id_C7B61F413AD4EC68;
  _id_7D2852D02216C876 setscriptablepartstate("speaker", _id_C7B61F413AD4EC68);
  _id_7D2852D02216C876 thread _id_F3756F0695358FE3();
  return 1;
}

_id_3136E267CBF2A63C(_id_2FA65F34EB9042F5, playersused) {
  foreach(player in _id_2FA65F34EB9042F5.playersusing) {
    if(!scripts\engine\utility::array_contains(playersused, player))
      return 1;
  }

  return 0;
}

_id_A06BC7F3D6E3CB4B() {
  _id_7D2852D02216C876 = spawnscriptable("dmz_biobunker_shopkeeper_voice", (1716, 1566, 200), (0, 0, 0));

  for(;;) {
    _id_7D2852D02216C876 setscriptablepartstate("speaker", "RandomIdle");
    wait 0.2;
    _id_7D2852D02216C876 setscriptablepartstate("speaker", "off");
    wait 0.2;
  }
}