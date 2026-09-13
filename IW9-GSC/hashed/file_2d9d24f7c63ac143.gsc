/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2d9d24f7c63ac143.gsc
***********************************************/

_id_E0948A1E98E82AE1() {
  if(istrue(level._id_D034183ABF2E274D)) {
    level._id_201C841C4668A94F = "dmzBackpack";
    level._id_342175A1B9F9067E = "dmzBackpackSize";
  } else {
    level._id_201C841C4668A94F = "brBackpack";
    level._id_342175A1B9F9067E = "brBackpackSize";
  }

  level._id_1833D54921DA2CC6 = scripts\mp\utility\game::privatematch();
}

_id_5BAAA0CE73D6FE84(player, ammotype) {
  if(_id_EFAB78B72D131D76(player)) {
    _id_9AC5E72784815708 = _id_2985254128B1C262(player);
    _id_811ABFDB6C33F17F = _id_724736FCF0FB6604::br_ammo_type_for_weapon(_id_9AC5E72784815708);

    if(isDefined(_id_811ABFDB6C33F17F)) {
      if(isDefined(ammotype) && ammotype != _id_811ABFDB6C33F17F) {
        return;
      }
      _id_5A57E79AE8D5AE67 = player.br_ammo[_id_811ABFDB6C33F17F];
      _id_AB0EE360900BCB85 = level._id_E6EA72FC5E3FCD00[_id_811ABFDB6C33F17F];
      _id_5A57E79AE8D5AE67 = int(min(_id_5A57E79AE8D5AE67, _id_AB0EE360900BCB85));

      if(_id_5A57E79AE8D5AE67 > 1023) {}

      player setclientomnvar("ui_playerdata_weapon_ammo", _id_5A57E79AE8D5AE67);
    }
  }
}

_id_E35A7CB7E7C8C17E(player, weapon, _id_F51BBB191526DFA4, _id_4E479E14D0837E84, _id_223785486725CD51) {
  if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7())
    _id_0B7A9CE0A2282B79::_id_9FEE9BD8EFD81655(player, weapon, _id_F51BBB191526DFA4, _id_4E479E14D0837E84);
  else
    _id_8107FE0FEEC27866(player, weapon, _id_223785486725CD51);
}

_id_705889B7586CF34E(player, weapon, weaponslot) {
  if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7())
    _id_0B7A9CE0A2282B79::_id_1F83D85290C29BEF(player, weaponslot);

  _id_8107FE0FEEC27866(player, weapon);
}

_id_EE4CCDFF22E510FD(player, _id_72E90F48E0FD0E1C, _id_514B604B42B22810) {
  if(_id_514B604B42B22810 == "none")
    player setplayerdata(level._id_5D69837CF4DB0407, "dmzWeapon", "sticker", _id_72E90F48E0FD0E1C, _id_514B604B42B22810);
  else
    player setplayerdata(level._id_5D69837CF4DB0407, "dmzWeapon", "sticker", _id_72E90F48E0FD0E1C, getsubstr(_id_514B604B42B22810, 2));
}

_id_8107FE0FEEC27866(player, weapon, _id_223785486725CD51) {
  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(weapon);
  variantid = weapon.variantid;

  if(!isDefined(weapon.variantid))
    variantid = 0;

  lootid = _id_2669878CF5A1B6BC::_id_79D6E6C22245687A(_id_AB501F397D3CD312, variantid);
  player setplayerdata(level._id_5D69837CF4DB0407, "dmzWeapon", "weapon", _id_AB501F397D3CD312);
  player setplayerdata(level._id_5D69837CF4DB0407, "dmzWeapon", "variantID", variantid);
  player setplayerdata(level._id_5D69837CF4DB0407, "dmzWeapon", "lootItemID", lootid);

  if(!istrue(_id_223785486725CD51)) {
    player._id_3EF503345DC57957 = player getweaponammoclip(weapon);
    player._id_00AD7897ECDBCB63 = player getweaponammoclip(weapon, "left");

    if(weapon.hasalternate) {
      _id_B6FF735C3690CC44 = weapon getaltweapon();
      player._id_86B32AFF94B5714E = player getweaponammoclip(_id_B6FF735C3690CC44);
    }
  }

  attachments = getweaponattachments(weapon);
  _id_F957368A964A7504 = _id_2669878CF5A1B6BC::_id_792BACB194F6F862(_id_AB501F397D3CD312);
  _id_428A6C7CD65625C0 = 0;
  _id_91BBF8D2294A656E = weapon.attachmentvarindices;

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < attachments.size && _id_428A6C7CD65625C0 < 7; _id_DF6D8E005B4B8020++) {
    if(scripts\mp\utility\weapon::attachmentisselectable(weapon, attachments[_id_DF6D8E005B4B8020])) {
      player setplayerdata(level._id_5D69837CF4DB0407, "dmzWeapon", "attachmentSetup", _id_428A6C7CD65625C0, "attachment", attachments[_id_DF6D8E005B4B8020]);
      player setplayerdata(level._id_5D69837CF4DB0407, "dmzWeapon", "attachmentSetup", _id_428A6C7CD65625C0, "variantID", _id_91BBF8D2294A656E[attachments[_id_DF6D8E005B4B8020]]);
      _id_428A6C7CD65625C0++;
    }
  }

  for(_id_DF6D8E005B4B8020 = _id_428A6C7CD65625C0; _id_428A6C7CD65625C0 < 7; _id_DF6D8E005B4B8020++) {
    player setplayerdata(level._id_5D69837CF4DB0407, "dmzWeapon", "attachmentSetup", _id_428A6C7CD65625C0, "attachment", "none");
    player setplayerdata(level._id_5D69837CF4DB0407, "dmzWeapon", "attachmentSetup", _id_428A6C7CD65625C0, "variantID", 0);
    _id_428A6C7CD65625C0++;
  }

  if(isDefined(weapon.camo))
    player setplayerdata(level._id_5D69837CF4DB0407, "dmzWeapon", "camo", weapon.camo);

  if(isDefined(weapon.reticle))
    player setplayerdata(level._id_5D69837CF4DB0407, "dmzWeapon", "reticle", weapon.reticle);

  if(isDefined(weapon.visual))
    player setplayerdata(level._id_5D69837CF4DB0407, "dmzWeapon", "cosmeticAttachment", weapon.visual);

  stickers = [];

  if(isDefined(weapon.stickerslot0))
    _id_EE4CCDFF22E510FD(player, 0, weapon.stickerslot0);

  if(isDefined(weapon.stickerslot1))
    _id_EE4CCDFF22E510FD(player, 1, weapon.stickerslot1);

  if(isDefined(weapon.stickerslot2))
    _id_EE4CCDFF22E510FD(player, 2, weapon.stickerslot2);

  if(isDefined(weapon.stickerslot3))
    _id_EE4CCDFF22E510FD(player, 3, weapon.stickerslot3);

  if(isDefined(weapon._id_B39AC546CC8621F8))
    _id_EE4CCDFF22E510FD(player, 4, weapon._id_B39AC546CC8621F8);

  _id_3E89085D4A19A802(player, weapon);
  _id_5BAAA0CE73D6FE84(player);
}

_id_3E89085D4A19A802(player, weapon) {
  if(!isDefined(weapon))
    weapon = _id_F2849DAE62F7444E(player);

  player._id_9AC5E72784815708 = weapon;
}

_id_2985254128B1C262(player) {
  return player._id_9AC5E72784815708;
}

_id_F2849DAE62F7444E(player, _id_3AE9C94F047DB7C3, _id_5DC27A5BF459C504) {
  if(!isDefined(_id_5DC27A5BF459C504))
    _id_5DC27A5BF459C504 = "dmzWeapon";

  if(!isDefined(_id_3AE9C94F047DB7C3))
    _id_3AE9C94F047DB7C3 = level._id_5D69837CF4DB0407;

  weapon = player getplayerdata(_id_3AE9C94F047DB7C3, _id_5DC27A5BF459C504, "weapon");
  variantid = player getplayerdata(_id_3AE9C94F047DB7C3, _id_5DC27A5BF459C504, "variantID");
  attachments = [];
  _id_F3464D71F01F614E = [];
  _id_0EAE5A591E200672 = [];

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < 7; _id_DF6D8E005B4B8020++) {
    attachments[_id_DF6D8E005B4B8020] = player getplayerdata(_id_3AE9C94F047DB7C3, _id_5DC27A5BF459C504, "attachmentSetup", _id_DF6D8E005B4B8020, "attachment");
    _id_F3464D71F01F614E[_id_DF6D8E005B4B8020] = player getplayerdata(_id_3AE9C94F047DB7C3, _id_5DC27A5BF459C504, "attachmentSetup", _id_DF6D8E005B4B8020, "variantID");
    _id_803ECABB6F57B183 = player getplayerdata(_id_3AE9C94F047DB7C3, _id_5DC27A5BF459C504, "attachmentSetup", _id_DF6D8E005B4B8020, "customTune", 0);
    _id_803ECBBB6F57B3B6 = player getplayerdata(_id_3AE9C94F047DB7C3, _id_5DC27A5BF459C504, "attachmentSetup", _id_DF6D8E005B4B8020, "customTune", 1);
    _id_C19231FE2990712E = scripts\mp\class::_id_A5D1432D54033EA9(_id_803ECABB6F57B183, _id_803ECBBB6F57B3B6, 0);

    if(isDefined(_id_C19231FE2990712E))
      _id_0EAE5A591E200672[attachments[_id_DF6D8E005B4B8020]] = _id_C19231FE2990712E;
  }

  camo = player getplayerdata(_id_3AE9C94F047DB7C3, _id_5DC27A5BF459C504, "camo");
  reticle = player getplayerdata(_id_3AE9C94F047DB7C3, _id_5DC27A5BF459C504, "reticle");
  cosmeticattachment = player getplayerdata(_id_3AE9C94F047DB7C3, _id_5DC27A5BF459C504, "cosmeticAttachment");
  stickers = [];

  for(_id_36D2ABBDCBCB186C = 0; _id_36D2ABBDCBCB186C < 5; _id_36D2ABBDCBCB186C++)
    stickers[_id_36D2ABBDCBCB186C] = player getplayerdata(_id_3AE9C94F047DB7C3, _id_5DC27A5BF459C504, "sticker", _id_36D2ABBDCBCB186C);

  return _id_2669878CF5A1B6BC::buildweapon(weapon, attachments, camo, reticle, variantid, _id_F3464D71F01F614E, cosmeticattachment, stickers);
}

_id_EFAB78B72D131D76(player) {
  _id_CBA40E031462D0A0 = isDefined(player._id_9AC5E72784815708) && player._id_9AC5E72784815708.basename != "none";

  if(istrue(level._id_0F478C1F94CAA7E9))
    data = player getplayerdata(level._id_5D69837CF4DB0407, "dmzWeapon", "weapon");

  return _id_CBA40E031462D0A0;
}

_id_D9B1550011525161(player) {
  return player getplayerdata(level._id_5D69837CF4DB0407, "dmzWeapon", "lootItemID");
}

_id_F5A1A13F0181BB66(player, _id_5756AA71087F3439, _id_44EE85DCF52B4001) {
  if(istrue(player._id_859654E0445A36D9) && isDefined(level.br_pickups._id_355CDDB773CB000D)) {
    player scripts\mp\hud_message::showerrormessage(level.br_pickups._id_355CDDB773CB000D);
    return;
  }

  if(!_id_EFAB78B72D131D76(player)) {
    return;
  }
  _id_358E8D9068997399 = _id_D9B1550011525161(player);
  _id_280ABCD08CBDCC79 = _id_2985254128B1C262(player);
  count = scripts\engine\utility::ter_op(isDefined(player._id_3EF503345DC57957), player._id_3EF503345DC57957, weaponclipsize(_id_280ABCD08CBDCC79));
  _id_E97D731BEDD44C63 = scripts\engine\utility::ter_op(_id_280ABCD08CBDCC79.hasalternate && isDefined(player._id_86B32AFF94B5714E), player._id_86B32AFF94B5714E, weaponclipsize(_id_280ABCD08CBDCC79 getaltweapon()));
  countlefthand = undefined;

  if(scripts\mp\utility\weapon::isakimbo(_id_280ABCD08CBDCC79))
    countlefthand = scripts\engine\utility::ter_op(isDefined(player._id_00AD7897ECDBCB63), player._id_00AD7897ECDBCB63, weaponclipsize(_id_280ABCD08CBDCC79));

  _id_E1147886CCF51970 = _id_724736FCF0FB6604::_id_86A5C7670325346B(player, 2);
  _id_590202DAF6A1D4D7(player);
  _id_7E52B56769FA7774::_id_E5845FF9B61AC5D7(_id_280ABCD08CBDCC79, count, undefined, _id_E97D731BEDD44C63, _id_44EE85DCF52B4001, _id_5756AA71087F3439, undefined, undefined, undefined, _id_E1147886CCF51970, countlefthand);
}

_id_954372D604277278(player) {
  if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7())
    _id_0B7A9CE0A2282B79::_id_F910B139E75FD559(player);

  _id_590202DAF6A1D4D7(player);
}

_id_6A77670D14B0D08C(player, _id_3AE9C94F047DB7C3, _id_5DC27A5BF459C504) {
  if(!isDefined(_id_5DC27A5BF459C504))
    _id_5DC27A5BF459C504 = "dmzWeapon";

  if(!isDefined(_id_3AE9C94F047DB7C3))
    _id_3AE9C94F047DB7C3 = level._id_5D69837CF4DB0407;

  player setplayerdata(_id_3AE9C94F047DB7C3, _id_5DC27A5BF459C504, "weapon", "none");
  player setplayerdata(_id_3AE9C94F047DB7C3, _id_5DC27A5BF459C504, "lootItemID", 0);
  player setplayerdata(_id_3AE9C94F047DB7C3, _id_5DC27A5BF459C504, "camo", "none");
  player setplayerdata(_id_3AE9C94F047DB7C3, _id_5DC27A5BF459C504, "reticle", "none");
  player setplayerdata(_id_3AE9C94F047DB7C3, _id_5DC27A5BF459C504, "cosmeticAttachment", "none");
  player setplayerdata(_id_3AE9C94F047DB7C3, _id_5DC27A5BF459C504, "variantID", 0);
  player setplayerdata(_id_3AE9C94F047DB7C3, _id_5DC27A5BF459C504, "blueprintName", "");

  for(_id_40E4B9C48B36C9EC = 0; _id_40E4B9C48B36C9EC < 5; _id_40E4B9C48B36C9EC++) {
    player setplayerdata(_id_3AE9C94F047DB7C3, _id_5DC27A5BF459C504, "attachmentSetup", _id_40E4B9C48B36C9EC, "attachment", "none");
    player setplayerdata(_id_3AE9C94F047DB7C3, _id_5DC27A5BF459C504, "attachmentSetup", _id_40E4B9C48B36C9EC, "variantID", 0);
  }

  for(_id_36D2ABBDCBCB186C = 0; _id_36D2ABBDCBCB186C < 4; _id_36D2ABBDCBCB186C++)
    player setplayerdata(_id_3AE9C94F047DB7C3, _id_5DC27A5BF459C504, "sticker", _id_36D2ABBDCBCB186C, "none");
}

_id_51F991FDAF031388(player, _id_3AE9C94F047DB7C3, _id_5DC27A5BF459C504) {
  _id_6A77670D14B0D08C(player, _id_3AE9C94F047DB7C3, _id_5DC27A5BF459C504);
  player._id_9AC5E72784815708 = undefined;
}

_id_590202DAF6A1D4D7(player, _id_5DC27A5BF459C504) {
  _id_51F991FDAF031388(player, undefined, "dmzWeapon");
  player._id_3EF503345DC57957 = undefined;
  player._id_86B32AFF94B5714E = undefined;
  player._id_00AD7897ECDBCB63 = undefined;
  _id_724736FCF0FB6604::_id_AE30366A2D519A57(player, 2, undefined);
}

_id_106B52ED8F680043(lootid) {
  if(lootid == 0)
    return undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B13E35608B336D65(self); _id_AC0E594AC96AA3A8++) {
    _id_EEEAE9DEFA0C1E95 = _id_6196D9EA9A30E609(_id_AC0E594AC96AA3A8);

    if(lootid == _id_EEEAE9DEFA0C1E95)
      return _id_AC0E594AC96AA3A8;
  }

  return undefined;
}

_id_AEB6F176059D98F5(lootid) {
  if(lootid == 0)
    return undefined;

  _id_042A7CD0B06E308F = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B13E35608B336D65(self); _id_AC0E594AC96AA3A8++) {
    _id_EEEAE9DEFA0C1E95 = _id_6196D9EA9A30E609(_id_AC0E594AC96AA3A8);

    if(lootid == _id_EEEAE9DEFA0C1E95)
      _id_042A7CD0B06E308F[_id_AC0E594AC96AA3A8] = _id_897B29ADB37F06A7(_id_AC0E594AC96AA3A8);
  }

  _id_042A7CD0B06E308F = tablesort(_id_042A7CD0B06E308F, "up");
  return _id_042A7CD0B06E308F;
}

_id_0ED8F025D796C038(lootid, _id_DFDD438871090D04) {
  if(lootid == 0)
    return undefined;

  _id_042A7CD0B06E308F = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B13E35608B336D65(self); _id_AC0E594AC96AA3A8++) {
    _id_EEEAE9DEFA0C1E95 = _id_6196D9EA9A30E609(_id_AC0E594AC96AA3A8);

    if(lootid == _id_EEEAE9DEFA0C1E95)
      _id_042A7CD0B06E308F[_id_042A7CD0B06E308F.size] = _id_AC0E594AC96AA3A8;
  }

  return _id_042A7CD0B06E308F;
}

_id_E37CA8120DC19C6A() {
  _id_78C5BD06AAAA2482 = scripts\mp\utility\game::privatematch() && !_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7() && getdvarint("dvar_6F45A6CBB79F0513", 0) == 0;
  return scripts\mp\utility\game::matchmakinggame() || _id_78C5BD06AAAA2482 || getdvarint("force_ranking");
}

_id_57931A717F140EBE(player) {
  weapons = [];
  _id_BC002676438672C9 = player getweaponslistprimaries();

  foreach(weapon in _id_BC002676438672C9) {
    if(scripts\mp\utility\weapon::_id_0D3C77884D93D850(weapon) || scripts\mp\utility\weapon::_id_3F15E5E526FF94CE(weapon) || weaponinventorytype(weapon) == "altmode" || scripts\mp\utility\weapon::ismeleeoverrideweapon(weapon) || scripts\mp\utility\weapon::issuperweapon(weapon))
      continue;
    else
      weapons[weapons.size] = weapon;
  }

  return weapons;
}

_id_254150D1E667DEE7() {
  items = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B13E35608B336D65(self); _id_AC0E594AC96AA3A8++) {
    [lootid, quantity] = _id_6738846DA50730F1(_id_AC0E594AC96AA3A8);

    if(lootid != 0) {
      item = spawnStruct();
      item.lootid = lootid;
      item.quantity = quantity;
      item.index = _id_AC0E594AC96AA3A8;
      items[items.size] = item;
    }
  }

  if(_id_EFAB78B72D131D76(self)) {
    item = spawnStruct();
    item.lootid = _id_D9B1550011525161(self);
    item.quantity = 1;
    item._id_E1147886CCF51970 = _id_724736FCF0FB6604::_id_86A5C7670325346B(self, 2);
    item.objweapon = _id_2985254128B1C262(self);
    _id_96C4059AA2EABFB8 = _id_0B7A9CE0A2282B79::_id_74031E3249A6F69E(self, 2);

    if(isDefined(_id_96C4059AA2EABFB8))
      item._id_4E479E14D0837E84 = _id_96C4059AA2EABFB8;

    items[items.size] = item;
  }

  return items;
}

_id_6738846DA50730F1(index) {
  lootid = _id_6196D9EA9A30E609(index);
  quantity = _id_897B29ADB37F06A7(index);
  return [lootid, quantity];
}

_id_84772EBF836AF5DB(index, amount) {
  if(!_id_E37CA8120DC19C6A()) {
    return;
  }
  _id_E8DB6AFBF2180F7E = _id_897B29ADB37F06A7(index);
  _id_3FA041E4F059BC71 = int(max(0, _id_E8DB6AFBF2180F7E + amount));
  lootid = _id_6196D9EA9A30E609(index);
  _id_D87A9518235B9682(index, lootid, _id_3FA041E4F059BC71);
}

_id_3B2BF3060F2EFDF3(player, index, lootid, quantity, _id_6208DB3305D9CB5B) {
  _id_645600FDEAF0AFF1 = player getplayerdata(level._id_5D69837CF4DB0407, level._id_201C841C4668A94F, index, "lootID");
  _id_9DB5199707687A1B = player getplayerdata(level._id_5D69837CF4DB0407, level._id_201C841C4668A94F, index, "quantity");

  if(_id_645600FDEAF0AFF1 != lootid && quantity > 0)
    _id_0B7A9CE0A2282B79::_id_22C2D36F9A723C2F(player, index, _id_6208DB3305D9CB5B);

  player _id_D87A9518235B9682(index, lootid, quantity);
}

_id_3C3EE4C5700E0E32(player, index, lootid, quantity, _id_72AD120EAAC64650, _id_6208DB3305D9CB5B) {
  _id_0B7A9CE0A2282B79::_id_D368B112DC94BAAE(player, index, _id_72AD120EAAC64650, _id_6208DB3305D9CB5B);
  player _id_D87A9518235B9682(index, lootid, quantity);
}

_id_11F48AE5B87B4525(player, index, lootid, quantity) {
  _id_645600FDEAF0AFF1 = player getplayerdata(level._id_5D69837CF4DB0407, level._id_201C841C4668A94F, index, "lootID");
  _id_9DB5199707687A1B = player getplayerdata(level._id_5D69837CF4DB0407, level._id_201C841C4668A94F, index, "quantity");

  if(_id_645600FDEAF0AFF1 != lootid && quantity > 0)
    _id_0B7A9CE0A2282B79::_id_0233512489717381(player, index, lootid);

  player _id_D87A9518235B9682(index, lootid, quantity);
}

_id_B4E3D555D6D737BB(player, index, _id_6208DB3305D9CB5B) {
  _id_0B7A9CE0A2282B79::_id_0E8A616866B41197(player, index, _id_6208DB3305D9CB5B);
  player _id_D87A9518235B9682(index, 0, 0);
}

_id_AD05407157B7D86D(player, index) {
  _id_0B7A9CE0A2282B79::_id_52384260FE709F19(player, index);
}

_id_C6306EA9715DD8F1(player, slot) {
  _id_0B7A9CE0A2282B79::_id_351FE4AC57CA37E5(player, slot);
}

_id_E900E7E66383AD97(player, index, quantity, _id_F3990D8529DE3A54) {
  _id_645600FDEAF0AFF1 = player _id_6196D9EA9A30E609(index);
  player _id_D87A9518235B9682(index, _id_645600FDEAF0AFF1, quantity, _id_F3990D8529DE3A54);
}

_id_A0CCC23064473A05(player, index, lootid, quantity) {
  player _id_D87A9518235B9682(index, lootid, quantity);
}

_id_D87A9518235B9682(index, lootid, quantity, _id_F3990D8529DE3A54) {
  if(!_id_E37CA8120DC19C6A()) {
    return;
  }
  ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);

  if(!isDefined(quantity) || quantity < 0)
    quantity = 0;

  if(!isDefined(lootid) || lootid != 0 && quantity == 0)
    lootid = 0;

  if(level._id_1833D54921DA2CC6) {
    self setplayerdata(level._id_5D69837CF4DB0407, level._id_201C841C4668A94F, index, "lootID", 1);
    self setplayerdata(level._id_5D69837CF4DB0407, level._id_201C841C4668A94F, index, "quantity", 1);
  }

  self setplayerdata(level._id_5D69837CF4DB0407, level._id_201C841C4668A94F, index, "lootID", lootid);
  self setplayerdata(level._id_5D69837CF4DB0407, level._id_201C841C4668A94F, index, "quantity", quantity);

  if(quantity == 0 || lootid == 0) {
    self setplayerdata(level._id_5D69837CF4DB0407, level._id_201C841C4668A94F, index, "lootID", 0);
    self setplayerdata(level._id_5D69837CF4DB0407, level._id_201C841C4668A94F, index, "quantity", 0);

    if(!istrue(_id_F3990D8529DE3A54))
      _id_AD05407157B7D86D(self, index);
  } else {
    pickup = spawnStruct();
    pickup.scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);
    _id_715028F54BAD19A1::branalytics_lootpickup(self, pickup.scriptablename, quantity);
  }
}

_id_E7EC9888699DD8CF() {
  _id_D28F52DA6EDE0191(self, 5, 1);
  _id_0B7A9CE0A2282B79::_id_5B7DC44BB66553A6(self);
  _id_0B7A9CE0A2282B79::_id_EA96B27797C7E268(self);
  _id_2E1D1AF8AFE39BA8 = undefined;

  if(scripts\mp\utility\game::getsubgametype() == "dmz") {
    _id_0CB44A7B7EDD34BD = getdvarint("dvar_8F2B4D22DCDC9934", -1);

    if(_id_0CB44A7B7EDD34BD != -1)
      _id_2E1D1AF8AFE39BA8 = _id_0CB44A7B7EDD34BD;
  } else
    _id_2E1D1AF8AFE39BA8 = getdvarint("scr_br_plate_carrier_start_level", 3);

  _id_0347AA4935F42810 = _id_2CEDCC356F1B9FC8::_id_C2F2BB9E0AE9A454(_id_2E1D1AF8AFE39BA8);
  _id_7E52B56769FA7774::_id_E98A5A4E0E001AC3(self, _id_0347AA4935F42810);
}

_id_5C5E6619F0B24F90(_id_F3990D8529DE3A54) {
  for(_id_A6F8D8115E0F1E79 = 0; _id_A6F8D8115E0F1E79 < _id_B13E35608B336D65(self); _id_A6F8D8115E0F1E79++)
    _id_DB1DD76061352E5B(_id_A6F8D8115E0F1E79, undefined, _id_F3990D8529DE3A54);

  if(istrue(_id_F3990D8529DE3A54))
    self._id_4F7710ECFF5B1619 = 1;

  _id_E7EC9888699DD8CF();
}

_id_BAB1A10B3FDAAE51() {
  for(_id_A6F8D8115E0F1E79 = 0; _id_A6F8D8115E0F1E79 < _id_B13E35608B336D65(self); _id_A6F8D8115E0F1E79++) {
    if(level._id_1833D54921DA2CC6) {
      self setplayerdata(level._id_5D69837CF4DB0407, level._id_201C841C4668A94F, _id_A6F8D8115E0F1E79, "lootID", 1);
      self setplayerdata(level._id_5D69837CF4DB0407, level._id_201C841C4668A94F, _id_A6F8D8115E0F1E79, "quantity", 1);
    }

    self setplayerdata(level._id_5D69837CF4DB0407, level._id_201C841C4668A94F, _id_A6F8D8115E0F1E79, "lootID", 0);
    self setplayerdata(level._id_5D69837CF4DB0407, level._id_201C841C4668A94F, _id_A6F8D8115E0F1E79, "quantity", 0);
  }
}

_id_3D7E44B7E940DE24(lootid, quantity) {
  _id_A1D8C3682333615E = quantity;
  _id_A1093166DE09E6B8 = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

  if(!isDefined(_id_A1093166DE09E6B8))
    _id_A1093166DE09E6B8 = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);

  maxcount = level.br_pickups._id_04138F9DDC1CD22D[_id_A1093166DE09E6B8];

  if(!isDefined(maxcount))
    maxcount = level.br_pickups.maxcounts[_id_A1093166DE09E6B8];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B13E35608B336D65(self); _id_AC0E594AC96AA3A8++) {
    _id_EEEAE9DEFA0C1E95 = _id_6196D9EA9A30E609(_id_AC0E594AC96AA3A8);

    if(_id_EEEAE9DEFA0C1E95 == 0 && _id_EEEAE9DEFA0C1E95 != lootid)
      return 1;

    if(_id_EEEAE9DEFA0C1E95 == lootid) {
      _id_FF239359935AA777 = _id_897B29ADB37F06A7(_id_AC0E594AC96AA3A8);

      if(_id_FF239359935AA777 + quantity <= maxcount)
        return 1;
      else
        quantity = _id_FF239359935AA777 + quantity - maxcount;
    }
  }

  if(quantity == _id_A1D8C3682333615E)
    return 0;

  return 1;
}

_id_E05897F5D860188E(lootid, quantity, _id_920F4173513EB6B8) {
  if(!isDefined(lootid))
    return undefined;

  _id_A1093166DE09E6B8 = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

  if(!isDefined(_id_A1093166DE09E6B8))
    _id_A1093166DE09E6B8 = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);

  maxcount = level.br_pickups._id_04138F9DDC1CD22D[_id_A1093166DE09E6B8];

  if(!isDefined(maxcount))
    maxcount = level.br_pickups.maxcounts[_id_A1093166DE09E6B8];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B13E35608B336D65(self); _id_AC0E594AC96AA3A8++) {
    _id_EEEAE9DEFA0C1E95 = _id_6196D9EA9A30E609(_id_AC0E594AC96AA3A8);

    if(_id_EEEAE9DEFA0C1E95 == lootid) {
      if(istrue(_id_920F4173513EB6B8))
        return _id_AC0E594AC96AA3A8;

      _id_FF239359935AA777 = _id_897B29ADB37F06A7(_id_AC0E594AC96AA3A8);

      if(_id_FF239359935AA777 < maxcount)
        return _id_AC0E594AC96AA3A8;
    }
  }

  return undefined;
}

_id_6196D9EA9A30E609(index) {
  return self getplayerdata(level._id_5D69837CF4DB0407, level._id_201C841C4668A94F, index, "lootID");
}

_id_897B29ADB37F06A7(index) {
  return self getplayerdata(level._id_5D69837CF4DB0407, level._id_201C841C4668A94F, index, "quantity");
}

_id_AE22C70A9C2474D9() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B13E35608B336D65(self); _id_AC0E594AC96AA3A8++) {
    _id_EEEAE9DEFA0C1E95 = _id_6196D9EA9A30E609(_id_AC0E594AC96AA3A8);

    if(_id_EEEAE9DEFA0C1E95 == 0)
      return _id_AC0E594AC96AA3A8;
  }

  return undefined;
}

_id_F6F8C1FC9549EAF6(lootid) {
  scriptable = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);
  return isDefined(scriptable) && isDefined(level.br_pickups.br_itemtype[scriptable]) && level.br_pickups.br_itemtype[scriptable] == "weaponcase";
}

_id_8E61EF2A2F9137E7(lootid) {
  scriptable = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);
  return isDefined(scriptable) && scriptable == "brloot_radioactive_charge";
}

_id_B4893066110F4D10(lootid) {
  scriptable = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);
  return isDefined(scriptable) && scriptable == "brloot_volatile_decoy_grenade";
}

_id_02D86BA79A58BB62(lootid) {
  return isDefined(lootid) && lootid == 8525;
}

_id_8A160D9935D47F5E(ref, type, quantity) {
  lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(ref);
  return _id_E01D9736B2D100AC(lootid, quantity);
}

_id_E01D9736B2D100AC(lootid, quantity) {
  if(!isDefined(lootid) || !isDefined(quantity))
    return undefined;

  _id_A1093166DE09E6B8 = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

  if(!_id_7E103028C464AB9A(_id_A1093166DE09E6B8))
    return 0;

  if(_id_7E52B56769FA7774::_id_D345EEC68E01361F(lootid))
    return isDefined(_id_AE22C70A9C2474D9());

  return _id_3D7E44B7E940DE24(lootid, quantity);
}

_id_B4BD198A25085E3E(lootid) {
  total = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B13E35608B336D65(self); _id_AC0E594AC96AA3A8++) {
    _id_F1CBC68C79EBF1EA = _id_6196D9EA9A30E609(_id_AC0E594AC96AA3A8);

    if(_id_F1CBC68C79EBF1EA == lootid)
      total = total + _id_897B29ADB37F06A7(_id_AC0E594AC96AA3A8);
  }

  return total;
}

_id_6FE7E7891D125C48(player) {
  total = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B13E35608B336D65(player); _id_AC0E594AC96AA3A8++) {
    _id_F1CBC68C79EBF1EA = player _id_6196D9EA9A30E609(_id_AC0E594AC96AA3A8);

    if(_id_F1CBC68C79EBF1EA)
      total = total + 1;
  }

  return total;
}

_id_5915BDBC5F6302B6(_id_0060452E1FC245C1) {
  _id_B623B9953B720A12 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B13E35608B336D65(self); _id_AC0E594AC96AA3A8++) {
    _id_F1CBC68C79EBF1EA = _id_6196D9EA9A30E609(_id_AC0E594AC96AA3A8);

    if(scripts\engine\utility::array_contains(_id_0060452E1FC245C1, _id_F1CBC68C79EBF1EA))
      _id_B623B9953B720A12[_id_B623B9953B720A12.size] = _id_AC0E594AC96AA3A8;
  }

  return _id_B623B9953B720A12;
}

_id_91A0BAB850D7DB10(index, lootid, maxcount, _id_9610A859DB3F00CC, _id_E30B916ADC1E2DC8) {
  _id_F94E260AC3C6121E = _id_E30B916ADC1E2DC8 + _id_9610A859DB3F00CC - maxcount;
  thread _id_E900E7E66383AD97(self, index, maxcount);
  return _id_F94E260AC3C6121E;
}

_id_15308562FDA076AA(lootid, pickup) {
  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("setBackpackItem")) {
    result = _id_362C58E8BB39BCDA::runbrgametypefunc("setBackpackItem", lootid, pickup);

    if(result >= 0)
      return result;
  }

  quantity = pickup.count;
  maxcount = level.br_pickups._id_04138F9DDC1CD22D[pickup.scriptablename];

  if(!isDefined(maxcount) || maxcount == 0)
    maxcount = level.br_pickups.maxcounts[pickup.scriptablename];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B13E35608B336D65(self); _id_AC0E594AC96AA3A8++) {
    _id_EEEAE9DEFA0C1E95 = _id_6196D9EA9A30E609(_id_AC0E594AC96AA3A8);

    if(_id_EEEAE9DEFA0C1E95 == lootid) {
      _id_E30B916ADC1E2DC8 = _id_897B29ADB37F06A7(_id_AC0E594AC96AA3A8);

      if(_id_E30B916ADC1E2DC8 + quantity <= maxcount) {
        _id_E900E7E66383AD97(self, _id_AC0E594AC96AA3A8, _id_E30B916ADC1E2DC8 + quantity);
        return 0;
      } else
        quantity = _id_91A0BAB850D7DB10(_id_AC0E594AC96AA3A8, lootid, maxcount, quantity, _id_E30B916ADC1E2DC8);
    }

    if(quantity <= 0)
      return 0;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B13E35608B336D65(self); _id_AC0E594AC96AA3A8++) {
    _id_EEEAE9DEFA0C1E95 = _id_6196D9EA9A30E609(_id_AC0E594AC96AA3A8);

    if(_id_EEEAE9DEFA0C1E95 == 0 && _id_EEEAE9DEFA0C1E95 != lootid) {
      if(quantity <= maxcount) {
        _id_11F48AE5B87B4525(self, _id_AC0E594AC96AA3A8, lootid, quantity);
        return 0;
      } else {
        _id_11F48AE5B87B4525(self, _id_AC0E594AC96AA3A8, lootid, maxcount);
        quantity = quantity - maxcount;
      }
    }

    if(quantity <= 0)
      return 0;
  }

  return quantity;
}

_id_9D094FAC5AE6454E(ref, type, quantity) {
  lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(ref);
  _id_60227BFF1E9478CC = spawnStruct();
  _id_60227BFF1E9478CC.scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);
  _id_60227BFF1E9478CC.count = quantity;
  return _id_10F6E537F1B5763C(lootid, _id_60227BFF1E9478CC);
}

_id_10F6E537F1B5763C(lootid, pickup, _id_70E660487C2924EC, _id_C751296A033CDB3C, _id_7F437A5779C8787C) {
  if(!isDefined(lootid) || !isDefined(pickup)) {
    return;
  }
  if(_id_7E52B56769FA7774::_id_907944A173ED27E1(pickup.scriptablename))
    return 0;

  if(_id_7E52B56769FA7774::_id_D345EEC68E01361F(lootid, pickup.scriptablename)) {
    index = _id_AE22C70A9C2474D9();

    if(!isDefined(index))
      return 0;

    _id_71E56BB092FD2574(lootid);
    thread _id_11F48AE5B87B4525(self, index, lootid, pickup.count);
    return 0;
  } else if(_id_7E52B56769FA7774::_id_DF3F5431C93ED5A1(undefined, pickup.scriptablename)) {
    index = _id_AE22C70A9C2474D9();

    if(!isDefined(index))
      return 0;

    _id_799D521F485A1701::_id_60D5992F51286201();
  } else if(_id_7E52B56769FA7774::_id_E4B6260DBB04B43D(pickup.scriptablename)) {
    index = _id_AE22C70A9C2474D9();

    if(!isDefined(index))
      return 0;

    _id_728FFCEE8CBF30EE::_id_BC0879C9AA2863A3(self, pickup, index);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(lootid, "pickedUp")) {
    result = scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2(lootid, "pickedUp", pickup.instance, self);

    if(isDefined(result))
      return;
  }

  level notify("br_loot_item_added_to_backpack", lootid, pickup, self);
  _id_189B67B2735B981D::_id_81F5578AED261DA1(self);

  if(_id_2CEDCC356F1B9FC8::isammo(pickup.scriptablename)) {
    if(self.br_ammo[pickup.scriptablename] < level._id_E6EA72FC5E3FCD00[pickup.scriptablename] && _id_724736FCF0FB6604::_id_D885E66811EE3A4D(pickup.scriptablename)) {
      _id_5718FAB182F37D81 = level._id_E6EA72FC5E3FCD00[pickup.scriptablename] - self.br_ammo[pickup.scriptablename];
      _id_C1192C297BBF292F = int(min(_id_5718FAB182F37D81, pickup.count));

      if(istrue(pickup.isautouse) && _id_7E52B56769FA7774::_id_E44C2D69DB881894(pickup.scriptablename)) {
        self.br_ammo[pickup.scriptablename] = self.br_ammo[pickup.scriptablename] + _id_C1192C297BBF292F;
        _id_724736FCF0FB6604::br_ammo_player_hud_update_ammotype(pickup.scriptablename);
        _id_724736FCF0FB6604::br_ammo_update_weapons(self);
        quantity = pickup.count - _id_C1192C297BBF292F;
        dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

        if(isDefined(_id_C751296A033CDB3C))
          dropstruct.count = _id_C751296A033CDB3C;

        _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, undefined, pickup._id_96C7526F4AB04875, undefined, undefined, pickup.origin);
        item = _id_7E52B56769FA7774::spawnpickup(pickup.scriptablename, _id_CB4FAD49263E20C4, quantity, 1, undefined, 0);
        return 0;
      } else {
        _id_724736FCF0FB6604::br_ammo_give_type(self, pickup.scriptablename, _id_C1192C297BBF292F);
        pickup.count = pickup.count - _id_C1192C297BBF292F;
      }
    } else if(istrue(pickup.isautouse) && _id_7E52B56769FA7774::_id_E44C2D69DB881894(pickup.scriptablename) && !getdvarint("dvar_B5DB5FF4B3F9E052", 0) && getdvarint("dvar_D116B9023292A13E", 1)) {
      [index, quantity] = _id_0280230FEED0C006(pickup.scriptablename);
      _id_1A07696025C0B4EF = _id_E02526FC6DB8443F(pickup.scriptablename);

      if(quantity >= 0 && isDefined(_id_1A07696025C0B4EF) && quantity + pickup.count > _id_1A07696025C0B4EF) {
        _id_0CF3B8CE798A5A08 = pickup.count;
        pickup.count = _id_1A07696025C0B4EF - quantity;
        _id_0CF3B8CE798A5A08 = _id_0CF3B8CE798A5A08 - pickup.count;
        dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

        if(isDefined(_id_C751296A033CDB3C))
          dropstruct.count = _id_C751296A033CDB3C;

        _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, undefined, pickup._id_96C7526F4AB04875, undefined, undefined, pickup.origin);
        item = _id_7E52B56769FA7774::spawnpickup(pickup.scriptablename, _id_CB4FAD49263E20C4, _id_0CF3B8CE798A5A08, 1, undefined, 0);
      }
    }
  }

  quantity = _id_15308562FDA076AA(lootid, pickup);

  if(quantity > 0) {
    if(!istrue(_id_70E660487C2924EC)) {
      baseorigin = self.origin;
      baseangles = self.angles;
      dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
      _id_96C7526F4AB04875 = pickup._id_96C7526F4AB04875;
      _id_7591ED99E87A77D3 = pickup.origin;

      if(istrue(_id_7F437A5779C8787C) && isDefined(self.br_kiosk) && isDefined(self.br_kiosk.dropstruct)) {
        _id_E1D097C517C3AF5B = self.br_kiosk _id_7E52B56769FA7774::_id_4F4D537C794B2BF5();
        self.br_kiosk.dropstruct._id_DFBA5A2C3C6F0A07 = _id_E1D097C517C3AF5B;
        dropstruct = self.br_kiosk.dropstruct;
        baseorigin = scripts\engine\utility::_id_53C4C53197386572(self.br_kiosk._id_AFC028D00356E443, self.br_kiosk.origin);
        baseangles = self.br_kiosk.angles;
        _id_7591ED99E87A77D3 = undefined;
        _id_96C7526F4AB04875 = undefined;
      } else if(isDefined(pickup.dropstruct))
        dropstruct = pickup.dropstruct;

      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, baseorigin, baseangles, self, undefined, _id_96C7526F4AB04875, undefined, undefined, _id_7591ED99E87A77D3);
      item = _id_7E52B56769FA7774::spawnpickup(pickup.scriptablename, _id_CB4FAD49263E20C4, quantity, 1, undefined, 0);

      if(isDefined(pickup.dropstruct))
        pickup.dropstruct = dropstruct;

      return 0;
    } else
      return quantity;
  }

  return 0;
}

_id_DB1DD76061352E5B(index, _id_74806F0C4CAA7E55, _id_F3990D8529DE3A54) {
  if(!_id_E37CA8120DC19C6A())
    return 0;

  [lootid, _] = _id_6738846DA50730F1(index);
  _id_FF239359935AA777 = _id_897B29ADB37F06A7(index);

  if(!isDefined(_id_74806F0C4CAA7E55))
    _id_74806F0C4CAA7E55 = _id_FF239359935AA777;

  _id_A28BD7F30254C8A0 = int(max(0, _id_FF239359935AA777 - _id_74806F0C4CAA7E55));
  thread _id_E900E7E66383AD97(self, index, _id_A28BD7F30254C8A0, _id_F3990D8529DE3A54);
  _id_2713F4A3502D1624 = _id_91C1BE871300A518(lootid);
  _id_6355A9DB4EA7AB55(lootid);
  return lootid;
}

_id_D63A7299C6203BF9(lootid) {
  if(!_id_E37CA8120DC19C6A())
    return 0;

  index = _id_E05897F5D860188E(lootid, undefined, 1);
  return isDefined(index);
}

_id_6F39F9916649AC48(lootid, quantity) {
  if(!_id_E37CA8120DC19C6A())
    return 0;

  itemtype = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(lootid);

  if(itemtype == "weapon")
    _id_954372D604277278(self);
  else {
    index = _id_E05897F5D860188E(lootid, undefined, 1);

    if(!isDefined(index))
      return 0;

    _id_DB1DD76061352E5B(index, quantity);
  }
}

_id_51F5AAFA38A37F0F(scriptablename, _id_940774B1F9D551A3) {
  lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(scriptablename);

  if(!isDefined(lootid)) {
    return;
  }
  _id_750FCC188317845A = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B13E35608B336D65(self); _id_AC0E594AC96AA3A8++) {
    if(_id_6196D9EA9A30E609(_id_AC0E594AC96AA3A8) == lootid)
      _id_750FCC188317845A[_id_AC0E594AC96AA3A8] = _id_897B29ADB37F06A7(_id_AC0E594AC96AA3A8);
  }

  if(_id_750FCC188317845A.size <= 0)
    return _id_940774B1F9D551A3;

  _id_5581023A8FC8D56D = tablesort(_id_750FCC188317845A, "up");

  foreach(index in _id_5581023A8FC8D56D) {
    _id_E30B916ADC1E2DC8 = _id_897B29ADB37F06A7(index);

    if(_id_940774B1F9D551A3 <= _id_E30B916ADC1E2DC8) {
      _id_DB1DD76061352E5B(index, _id_940774B1F9D551A3);
      return 0;
    }

    _id_940774B1F9D551A3 = _id_940774B1F9D551A3 - _id_E30B916ADC1E2DC8;
    _id_DB1DD76061352E5B(index, _id_E30B916ADC1E2DC8);
  }

  return _id_940774B1F9D551A3;
}

_id_0280230FEED0C006(scriptablename) {
  if(!isDefined(scriptablename))
    return undefined;

  lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(scriptablename);
  _id_342175A1B9F9067E = _id_B13E35608B336D65(self);
  _id_CF2620907B40F599 = -1;
  _id_56120302DFEE9EED = undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_342175A1B9F9067E; _id_AC0E594AC96AA3A8++) {
    [_id_22293F90436EA191, quantity] = _id_6738846DA50730F1(_id_AC0E594AC96AA3A8);

    if(lootid == _id_22293F90436EA191 && quantity > _id_CF2620907B40F599) {
      _id_CF2620907B40F599 = quantity;
      _id_56120302DFEE9EED = _id_AC0E594AC96AA3A8;
    }
  }

  return [_id_56120302DFEE9EED, _id_CF2620907B40F599];
}

_id_49A39674C4A064E3(scriptablename) {
  if(!isDefined(scriptablename))
    return 0;

  maxcount = _id_E02526FC6DB8443F(scriptablename);
  lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(scriptablename);
  _id_342175A1B9F9067E = _id_B13E35608B336D65(self);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_342175A1B9F9067E; _id_AC0E594AC96AA3A8++) {
    [_id_22293F90436EA191, quantity] = _id_6738846DA50730F1(_id_AC0E594AC96AA3A8);

    if(lootid == _id_22293F90436EA191 && quantity >= maxcount)
      return 1;
  }

  return 0;
}

_id_E02526FC6DB8443F(scriptablename) {
  if(!isDefined(scriptablename) || !isDefined(level.br_pickups._id_04138F9DDC1CD22D) || !isDefined(level.br_pickups._id_04138F9DDC1CD22D[scriptablename]))
    return undefined;

  return level.br_pickups._id_04138F9DDC1CD22D[scriptablename];
}

_id_C578CFF4DE96AF82(scriptablename) {
  if(!isDefined(scriptablename) || !isDefined(level.br_pickups._id_4183295EDCC21DB0) || !isDefined(level.br_pickups._id_4183295EDCC21DB0[scriptablename]))
    return undefined;

  return level.br_pickups._id_4183295EDCC21DB0[scriptablename];
}

_id_93F02514431A1F5D(lootid) {
  _id_FF239359935AA777 = 0;
  index = _id_106B52ED8F680043(lootid);

  if(!isDefined(index))
    return _id_FF239359935AA777;

  _id_342175A1B9F9067E = _id_B13E35608B336D65(self);

  for(_id_AC0E594AC96AA3A8 = index; _id_AC0E594AC96AA3A8 < _id_342175A1B9F9067E; _id_AC0E594AC96AA3A8++) {
    [_id_22293F90436EA191, _] = _id_6738846DA50730F1(_id_AC0E594AC96AA3A8);

    if(lootid == _id_22293F90436EA191) {
      if(_id_7E52B56769FA7774::_id_D345EEC68E01361F(lootid)) {
        _id_FF239359935AA777 = _id_FF239359935AA777 + 1;
        continue;
      }

      _id_FF239359935AA777 = _id_897B29ADB37F06A7(_id_AC0E594AC96AA3A8) + _id_FF239359935AA777;
    }
  }

  return _id_FF239359935AA777;
}

_id_EF5C7EC55E0E20EE(lootid) {
  index = _id_106B52ED8F680043(lootid);

  if(!isDefined(index))
    return 0;

  if(!isDefined(self.team))
    return _id_93F02514431A1F5D(index);

  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(self.team, "players");
  _id_0FB01EE55B395FA5 = 0;

  foreach(player in _id_A6AB8D0FDA441DC2) {
    _id_25885A6A7C97BC01 = player _id_93F02514431A1F5D(lootid);
    _id_0FB01EE55B395FA5 = _id_0FB01EE55B395FA5 + _id_25885A6A7C97BC01;
  }

  return _id_0FB01EE55B395FA5;
}

_id_71E56BB092FD2574(lootid) {
  if(!isDefined(lootid)) {
    return;
  }
  type = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(lootid);
  ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);

  switch (type) {
    case "tactical":
    case "field_upgrade":
    case "equipment":
    case "perk":
    case "killstreak":
    case "lethal":
    case "super":
    case "secondary":
    case "primary":
    case "weapon":
      return;
    case "consumable":
      if(isDefined(level._id_B33C035C483C2893) && isDefined(level._id_B33C035C483C2893["onPickup"]) && isDefined(level._id_B33C035C483C2893["onPickup"][ref]))
        [[level._id_B33C035C483C2893["onPickup"][ref]]](self);

      return;
  }

  return;
}

_id_6355A9DB4EA7AB55(lootid) {
  if(!isDefined(lootid)) {
    return;
  }
  type = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(lootid);

  if(!isDefined(type)) {
    return;
  }
  ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);

  switch (type) {
    case "extractable":
    case "tactical":
    case "field_upgrade":
    case "equipment":
    case "perk":
    case "killstreak":
    case "lethal":
    case "super":
    case "secondary":
    case "primary":
    case "weapon":
      return;
    case "consumable":
      if(isDefined(level._id_B33C035C483C2893) && isDefined(level._id_B33C035C483C2893["onDrop"]) && isDefined(level._id_B33C035C483C2893["onDrop"][ref]))
        [[level._id_B33C035C483C2893["onDrop"][ref]]](self);

      return;
  }

  return;
}

_id_36B1968BFE78916B(lootid) {
  return isDefined(_id_106B52ED8F680043(lootid));
}

_id_3AB0A87EEAA203BF() {
  if(!istrue(level._id_2C93542553C664F5))
    return 0;

  foreach(weaponobj in self.primaryinventory) {
    if(weaponobj.basename == "iw9_me_fists_mp")
      return 0;
  }

  return 1;
}

_id_5E7049647595AB97() {
  if(!level._id_1D814F83596D0A02)
    return 0;

  return isDefined(self.equipment["super"]) && scripts\mp\equipment::getequipmentslotammo("super") > 0;
}

_id_D674D32C2D3BA5ED(player) {
  if(!istrue(level._id_472D7A6D15E57940))
    return 0;

  return isDefined(player.streakdata) && isDefined(player.streakdata.streaks) && self.streakdata.streaks.size > 0;
}

_id_5BF048439A846222(_id_C0FCE415CDB283C2) {
  return _id_C0FCE415CDB283C2 == "equip_c4" || _id_C0FCE415CDB283C2 == "equip_throwing_knife" || _id_C0FCE415CDB283C2 == "equip_claymore" || _id_C0FCE415CDB283C2 == "equip_at_mine" || _id_C0FCE415CDB283C2 == "equip_throwing_knife_fire";
}

_id_8237B4EEAB275F08(player, slot, _id_C0FCE415CDB283C2) {
  if(!isDefined(player) || !isDefined(slot))
    return 0;

  if(_id_5BF048439A846222(_id_C0FCE415CDB283C2))
    return 0;

  if(getdvarint("dvar_CED962345FF6ECD0", 0))
    return 0;

  _id_32AD03C5B4A0887D = undefined;
  _id_54697B28405E2F94 = "";
  _id_3B04A55BCBA2273A = 0;
  _id_28D82FB085BEFA70 = 0;

  for(_id_A6F8D8115E0F1E79 = 0; _id_A6F8D8115E0F1E79 < _id_B13E35608B336D65(player); _id_A6F8D8115E0F1E79++) {
    quantity = player _id_897B29ADB37F06A7(_id_A6F8D8115E0F1E79);
    lootid = player _id_6196D9EA9A30E609(_id_A6F8D8115E0F1E79);

    if(quantity > 0) {
      type = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(lootid);

      if(type == "equipment") {
        _id_CB325DDB4A764623 = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);

        if(isDefined(_id_C0FCE415CDB283C2) && isDefined(_id_CB325DDB4A764623) && _id_CB325DDB4A764623 == _id_C0FCE415CDB283C2) {
          _id_32AD03C5B4A0887D = _id_A6F8D8115E0F1E79;
          _id_54697B28405E2F94 = _id_CB325DDB4A764623;
          _id_3B04A55BCBA2273A = quantity;
          _id_28D82FB085BEFA70 = lootid;
          break;
        } else if(!isDefined(_id_32AD03C5B4A0887D)) {
          _id_BDDD73591D13804E = scripts\mp\equipment::getdefaultslot(_id_CB325DDB4A764623);

          if(isDefined(_id_BDDD73591D13804E) && _id_BDDD73591D13804E == slot) {
            _id_32AD03C5B4A0887D = _id_A6F8D8115E0F1E79;
            _id_54697B28405E2F94 = _id_CB325DDB4A764623;
            _id_3B04A55BCBA2273A = quantity;
            _id_28D82FB085BEFA70 = lootid;
          }
        }
      }
    }
  }

  if(isDefined(_id_32AD03C5B4A0887D)) {
    player scripts\mp\equipment::giveequipment(_id_54697B28405E2F94, slot);
    player scripts\mp\equipment::setequipmentammo(_id_54697B28405E2F94, _id_3B04A55BCBA2273A);

    if(_id_54697B28405E2F94 == "equip_hb_sensor") {
      _id_0EC0F9AD939B29E0::_id_30CD943D877DC29F(_id_3B04A55BCBA2273A);
      _id_DB1DD76061352E5B(_id_32AD03C5B4A0887D);
    } else {
      _id_402526809B38DA5F = player scripts\mp\equipment::getequipmentmaxammo(_id_54697B28405E2F94);
      _id_3FA041E4F059BC71 = min(_id_402526809B38DA5F, _id_3B04A55BCBA2273A);
      _id_E8DB6AFBF2180F7E = _id_897B29ADB37F06A7(_id_32AD03C5B4A0887D);
      player _id_84772EBF836AF5DB(_id_32AD03C5B4A0887D, -1 * _id_3FA041E4F059BC71);
      _id_0B7A9CE0A2282B79::_id_F5B2810055F85EAD(player, slot, _id_28D82FB085BEFA70);
    }

    player setclientomnvar("ui_notify_show_minimal_hud", gettime());
    return 1;
  }

  return 0;
}

_id_2C226F050114F4B2(dropstruct, victim) {
  for(_id_A6F8D8115E0F1E79 = 0; _id_A6F8D8115E0F1E79 < _id_B13E35608B336D65(victim); _id_A6F8D8115E0F1E79++) {
    quantity = victim _id_897B29ADB37F06A7(_id_A6F8D8115E0F1E79);
    lootid = victim _id_6196D9EA9A30E609(_id_A6F8D8115E0F1E79);

    if(quantity > 0 && lootid > 0) {
      if(_id_2391409EF7B431E1::_id_03C17A26CE6A4668(lootid)) {
        [_id_9BE70D6D4FF253A1, _id_59BD51AFC73DF2CD, _id_DAB81EAD77442A10] = _id_2391409EF7B431E1::_id_379463A84ADB07B4(quantity);
        _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, victim.origin, victim.angles, victim);
        _id_0DD070161709FA76 = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);
        dogtag = _id_7E52B56769FA7774::spawnpickup(_id_0DD070161709FA76, _id_CB4FAD49263E20C4, _id_9BE70D6D4FF253A1, 0, undefined, 0, _id_59BD51AFC73DF2CD, _id_DAB81EAD77442A10);
        victim _id_7E52B56769FA7774::_id_2F4E0022C686DBE6(dogtag);
        continue;
      }

      if(_id_02D86BA79A58BB62(lootid)) {
        victim _id_744CAD313ED0A87E::_id_F9FF7C89B3792CCC(dropstruct, victim._id_1FAF51A7DC279A8B);
        continue;
      }

      if(isDefined(_id_728FFCEE8CBF30EE::_id_96A1620D901981D1(lootid, 5))) {
        victim _id_7E52B56769FA7774::_id_B41950C9B54B12E0(dropstruct, _id_A6F8D8115E0F1E79, lootid);
        continue;
      }

      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, victim.origin, victim.angles, victim);
      _id_0DD070161709FA76 = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);
      _id_0BB9E46E1D8130F2 = istrue(level.br_pickups.br_hasautopickup[_id_0DD070161709FA76]);
      item = _id_7E52B56769FA7774::spawnpickup(_id_0DD070161709FA76, _id_CB4FAD49263E20C4, quantity, undefined, undefined, _id_0BB9E46E1D8130F2);
      victim _id_7E52B56769FA7774::_id_2F4E0022C686DBE6(item);
    }
  }
}

_id_5814F4F8710E57F7(victim, dropstruct) {
  _id_4FF6E95896E65939 = [];
  _id_BADDE91D16301BE4 = 0;
  _id_094333580DC2B96B = 0;

  for(_id_A6F8D8115E0F1E79 = 0; _id_A6F8D8115E0F1E79 < _id_B13E35608B336D65(victim); _id_A6F8D8115E0F1E79++) {
    quantity = victim _id_897B29ADB37F06A7(_id_A6F8D8115E0F1E79);
    lootid = victim _id_6196D9EA9A30E609(_id_A6F8D8115E0F1E79);

    if(quantity > 0 && lootid > 0) {
      if(_id_02D86BA79A58BB62(lootid)) {
        victim _id_744CAD313ED0A87E::_id_F9FF7C89B3792CCC(dropstruct, victim._id_1FAF51A7DC279A8B);
        continue;
      }

      if(isDefined(_id_728FFCEE8CBF30EE::_id_96A1620D901981D1(lootid, 5))) {
        victim _id_7E52B56769FA7774::_id_B41950C9B54B12E0(dropstruct, _id_A6F8D8115E0F1E79, lootid);
        continue;
      }

      if(_id_F6F8C1FC9549EAF6(lootid)) {
        if(getdvarint("dvar_F5F97AEC0784002A", 1)) {
          if(isPlayer(victim))
            _id_3AACF02225CA0DA5::_id_04545674E87C5795(victim, "stat_6855EC86930D06C1");

          _id_918249FD5219A579 = _id_3AACF02225CA0DA5::_id_4E271AE7BC17F13C(victim, dropstruct);
          victim _id_7E52B56769FA7774::_id_2F4E0022C686DBE6(_id_918249FD5219A579);
          continue;
        } else
          _id_094333580DC2B96B = 1;
      }

      _id_4FF6E95896E65939[_id_A6F8D8115E0F1E79] = [];
      _id_4FF6E95896E65939[_id_A6F8D8115E0F1E79]["lootID"] = lootid;
      _id_4FF6E95896E65939[_id_A6F8D8115E0F1E79]["quantity"] = quantity;
      _id_BADDE91D16301BE4++;
    }
  }

  if(istrue(level._id_0F478C1F94CAA7E9) && istrue(level._id_A3499C286AC570E4)) {
    if(_id_EFAB78B72D131D76(victim))
      _id_BADDE91D16301BE4++;
  }

  dogtag = undefined;

  if(getdvarint("dvar_6D0BEEF651F58A69", 0))
    victim _id_7E52B56769FA7774::_id_A61F07010C727C0A(dropstruct);
  else if(_id_2391409EF7B431E1::_id_C07675F2CE32FCB5(victim)) {
    _id_123D6D777458B852 = _id_2391409EF7B431E1::_id_57711583C5D26490(victim);

    if(isDefined(_id_123D6D777458B852)) {
      _id_2391409EF7B431E1::_id_BC03AA369196F2BF(victim, 0);
      dogtag = [];
      dogtag["lootID"] = _id_2391409EF7B431E1::_id_777013E79BE19C16(victim);
      dogtag["quantity"] = _id_123D6D777458B852;
    }
  }

  return [_id_4FF6E95896E65939, _id_094333580DC2B96B, dogtag];
}

_id_45013DFE9531841F(victim, dogtag) {
  _id_8919314D1DF8D669 = victim _id_88A168912191EC3E(1, 1);
  _id_BF23A60678978C19 = [];
  index = 0;
  _id_7803C95645E637E1 = 1;
  _id_04F6CDE716E0C3D7 = undefined;
  _id_6FB67C8525B1D79E = undefined;
  _id_0EC22A950F210E39 = undefined;
  _id_DFDB8AEFC4328EA0 = undefined;

  if(isDefined(_id_8919314D1DF8D669)) {
    foreach(_id_419647311D7D621F, itemtype in _id_8919314D1DF8D669) {
      if(!itemtype.size) {
        _id_BF23A60678978C19[index] = [];
        _id_BF23A60678978C19[index]["lootID"] = 0;
        _id_BF23A60678978C19[index]["quantity"] = 0;
        index++;
        continue;
      }

      foreach(_id_E1D097C517C3AF5B, slot in itemtype) {
        if(!isDefined(slot) && _id_419647311D7D621F != 1) {
          _id_BF23A60678978C19[index] = [];
          _id_BF23A60678978C19[index]["lootID"] = 0;
          _id_BF23A60678978C19[index]["quantity"] = 0;
          index++;
          continue;
        }

        lootid = slot[0];
        quantity = slot[1];

        if(!isDefined(lootid) || !isDefined(quantity)) {
          continue;
        }
        if(_id_419647311D7D621F == 1) {
          if(itemtype.size > 1) {
            if(!_id_7803C95645E637E1) {
              _id_04F6CDE716E0C3D7 = lootid;
              _id_6FB67C8525B1D79E = slot[2];
            } else {
              _id_0EC22A950F210E39 = slot[2];
              _id_DFDB8AEFC4328EA0 = _id_E1D097C517C3AF5B;
            }

            _id_7803C95645E637E1 = 0;
          }

          continue;
        }

        _id_BF23A60678978C19[index] = [];
        _id_BF23A60678978C19[index]["lootID"] = lootid;
        _id_BF23A60678978C19[index]["quantity"] = quantity;
        index++;
      }
    }
  }

  if(isDefined(dogtag)) {
    _id_BF23A60678978C19[8] = [];
    _id_BF23A60678978C19[8]["lootID"] = dogtag["lootID"];
    _id_BF23A60678978C19[8]["quantity"] = dogtag["quantity"];
    index++;
  }

  if(isDefined(victim._id_0CD82E790E825DB2)) {
    _id_BF23A60678978C19[9] = [];
    _id_BF23A60678978C19[9]["lootID"] = victim._id_CDA8C241EFFB412A;
    _id_BF23A60678978C19[9]["quantity"] = 1;
    index++;
  }

  _id_275F4441AB7920C8 = _id_724736FCF0FB6604::_id_1A561E5EF2ECA63A(victim, _id_6FB67C8525B1D79E);
  return [_id_BF23A60678978C19, _id_6FB67C8525B1D79E, _id_04F6CDE716E0C3D7, _id_275F4441AB7920C8, _id_0EC22A950F210E39, _id_DFDB8AEFC4328EA0];
}

_id_C6B3799B231916BB(victim, dropstruct) {
  if(istrue(victim.extracted)) {
    return;
  }
  [_id_4FF6E95896E65939, _id_094333580DC2B96B, dogtag] = _id_5814F4F8710E57F7(victim, dropstruct);
  [_id_BF23A60678978C19, _id_A0E9FEF038504BD0, _id_C299C08E4B8A8E56, _id_C31356A794D8CB46, _id_0EC22A950F210E39, _id_DFDB8AEFC4328EA0] = _id_45013DFE9531841F(victim, dogtag);

  if(_id_4FF6E95896E65939.size > 0 || _id_BF23A60678978C19.size > 0) {
    if(istrue(level._id_A2ED7C61B6DA2D72) && scripts\mp\utility\game::isteamreviveenabled() && !getdvarint("scr_test_backpack", 0)) {
      _id_04F6CDE716E0C3D7 = undefined;
      _id_6FB67C8525B1D79E = undefined;
      _id_3EF503345DC57957 = undefined;
      _id_86B32AFF94B5714E = undefined;
      _id_275F4441AB7920C8 = undefined;
      _id_8348F10D08DAD67A = undefined;
      _id_B19049DAAB6B92CB = undefined;

      if(_id_EFAB78B72D131D76(victim)) {
        _id_04F6CDE716E0C3D7 = _id_D9B1550011525161(victim);
        _id_6FB67C8525B1D79E = _id_2985254128B1C262(victim);
        _id_3EF503345DC57957 = scripts\engine\utility::ter_op(isDefined(victim._id_3EF503345DC57957), victim._id_3EF503345DC57957, weaponclipsize(_id_6FB67C8525B1D79E));

        if(scripts\mp\utility\weapon::isakimbo(_id_6FB67C8525B1D79E))
          _id_B19049DAAB6B92CB = scripts\engine\utility::ter_op(isDefined(victim._id_00AD7897ECDBCB63), victim._id_00AD7897ECDBCB63, weaponclipsize(_id_6FB67C8525B1D79E));

        _id_275F4441AB7920C8 = _id_724736FCF0FB6604::_id_86A5C7670325346B(victim, 2);

        if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7())
          _id_8348F10D08DAD67A = _id_0B7A9CE0A2282B79::_id_74031E3249A6F69E(self, 2);

        if(_id_6FB67C8525B1D79E.hasalternate) {
          _id_B6FF735C3690CC44 = _id_6FB67C8525B1D79E getaltweapon();
          _id_86B32AFF94B5714E = scripts\engine\utility::ter_op(isDefined(victim._id_86B32AFF94B5714E), victim._id_86B32AFF94B5714E, weaponclipsize(_id_B6FF735C3690CC44));
        }
      }

      _id_9D09471027604346 = undefined;

      if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7() && isDefined(_id_A0E9FEF038504BD0) && isDefined(_id_C299C08E4B8A8E56))
        _id_9D09471027604346 = _id_0B7A9CE0A2282B79::_id_74031E3249A6F69E(self, 1);

      scripts\mp\teamrevive::_id_9341574D596E9D36(victim, _id_4FF6E95896E65939, 6, _id_2391409EF7B431E1::_id_FB2923D9D7EB7AAC(victim), _id_04F6CDE716E0C3D7, _id_6FB67C8525B1D79E, _id_3EF503345DC57957, _id_86B32AFF94B5714E, _id_275F4441AB7920C8, _id_094333580DC2B96B, _id_BF23A60678978C19, _id_C299C08E4B8A8E56, _id_A0E9FEF038504BD0, _id_8348F10D08DAD67A, _id_9D09471027604346, _id_C31356A794D8CB46, _id_B19049DAAB6B92CB);
    } else {
      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, victim.origin, victim.angles, victim);
      _id_3EDA0EF65C9478AC = scripts\engine\utility::array_find(level.allteamnamelist, victim.team);
      squadindex = victim._id_3F78C6A0862F9E25;

      if(squadindex < 0 && isDefined(victim._id_71AFB85EC1CC06F8))
        squadindex = victim._id_71AFB85EC1CC06F8;

      _id_87583859F07B58E3 = victim _id_7E52B56769FA7774::spawnpickup(_id_432475069C798DDC(self.attached_bag), _id_CB4FAD49263E20C4, 1, undefined, undefined, undefined, _id_3EDA0EF65C9478AC, squadindex);

      if(isDefined(_id_87583859F07B58E3)) {
        if(scripts\mp\utility\game::getsubgametype() == "dmz")
          _id_87583859F07B58E3._id_BBC200BC77C5DB2B = 1;
        else if(scripts\mp\utility\game::getsubgametype() == "resurgence")
          thread _id_F4FC5C80C4D45C10(_id_87583859F07B58E3);
        else
          thread _id_A87DF010E38D988E(_id_87583859F07B58E3);

        _id_87583859F07B58E3.contents = _id_4FF6E95896E65939;
        _id_87583859F07B58E3._id_BF23A60678978C19 = _id_BF23A60678978C19;

        if(_id_EFAB78B72D131D76(victim)) {
          _id_87583859F07B58E3._id_04F6CDE716E0C3D7 = _id_D9B1550011525161(victim);
          _id_87583859F07B58E3._id_6FB67C8525B1D79E = _id_2985254128B1C262(victim);
          _id_87583859F07B58E3._id_3EF503345DC57957 = scripts\engine\utility::ter_op(isDefined(victim._id_3EF503345DC57957), victim._id_3EF503345DC57957, weaponclipsize(_id_87583859F07B58E3._id_6FB67C8525B1D79E));
          _id_87583859F07B58E3._id_275F4441AB7920C8 = _id_724736FCF0FB6604::_id_86A5C7670325346B(victim, 2);

          if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7())
            _id_87583859F07B58E3._id_4E479E14D0837E84 = _id_0B7A9CE0A2282B79::_id_74031E3249A6F69E(self, 2);

          if(_id_87583859F07B58E3._id_6FB67C8525B1D79E.hasalternate) {
            _id_B6FF735C3690CC44 = _id_87583859F07B58E3._id_6FB67C8525B1D79E getaltweapon();
            _id_87583859F07B58E3._id_86B32AFF94B5714E = scripts\engine\utility::ter_op(isDefined(victim._id_86B32AFF94B5714E), victim._id_86B32AFF94B5714E, weaponclipsize(_id_B6FF735C3690CC44));
          }

          if(scripts\mp\utility\weapon::isakimbo(_id_87583859F07B58E3._id_6FB67C8525B1D79E))
            _id_87583859F07B58E3._id_00AD7897ECDBCB63 = scripts\engine\utility::ter_op(isDefined(victim._id_00AD7897ECDBCB63), victim._id_00AD7897ECDBCB63, weaponclipsize(_id_87583859F07B58E3._id_6FB67C8525B1D79E));
        }

        _id_87583859F07B58E3._id_46A3A8565AC0C17C = 6;
        _id_87583859F07B58E3.owner = victim;
        _id_87583859F07B58E3._id_342175A1B9F9067E = _id_B13E35608B336D65(victim);
        _id_87583859F07B58E3._id_846A20D8E6F30B8E = _id_2391409EF7B431E1::_id_FB2923D9D7EB7AAC(victim);
        victim._id_6A4360DCF2A8F3D4 = _id_87583859F07B58E3;

        if(isDefined(_id_A0E9FEF038504BD0) && isDefined(_id_C299C08E4B8A8E56)) {
          _id_87583859F07B58E3._id_A06E7128C001851D = _id_C299C08E4B8A8E56;
          _id_87583859F07B58E3._id_A0E9FEF038504BD0 = _id_A0E9FEF038504BD0;
          _id_87583859F07B58E3._id_C31356A794D8CB46 = _id_C31356A794D8CB46;
          _id_87583859F07B58E3._id_27990AA12DECFFDD = victim getweaponammoclip(_id_A0E9FEF038504BD0);
          _id_87583859F07B58E3._id_C693663E1BBDD8E9 = victim getweaponammoclip(_id_A0E9FEF038504BD0, "left");

          if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7())
            _id_87583859F07B58E3._id_BB6791B7369EF71A = _id_0B7A9CE0A2282B79::_id_74031E3249A6F69E(self, 1);
        }

        foreach(item in _id_87583859F07B58E3.contents)
        scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2(item["lootID"], "addedToContainer", _id_87583859F07B58E3, victim);
      }
    }
  }

  if(isDefined(victim.attached_bag) && !istrue(level._id_A2ED7C61B6DA2D72))
    victim _id_4480C6CE37B2BDF3::_id_6D569066AC5F3DF0();

  if(isDefined(_id_0EC22A950F210E39) && _id_7E52B56769FA7774::shoulddropbrprimary(_id_0EC22A950F210E39, victim)) {
    _id_FACC6A1A18B419F0 = _id_7E52B56769FA7774::dropbrweapon(_id_0EC22A950F210E39, dropstruct);

    if(isDefined(_id_FACC6A1A18B419F0)) {
      if(scripts\mp\utility\game::getsubgametype() == "dmz")
        _id_FACC6A1A18B419F0._id_BBC200BC77C5DB2B = 1;
      else
        thread _id_A87DF010E38D988E(_id_FACC6A1A18B419F0);

      if(isDefined(_id_FACC6A1A18B419F0._id_AC26EC91048AC2E3))
        victim._id_620F2A17DF977448 = _id_FACC6A1A18B419F0._id_AC26EC91048AC2E3;

      if(isDefined(_id_DFDB8AEFC4328EA0) && _id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7())
        _id_FACC6A1A18B419F0._id_4E479E14D0837E84 = _id_0B7A9CE0A2282B79::_id_74031E3249A6F69E(self, _id_DFDB8AEFC4328EA0);

      victim._id_3480393DC131952A = _id_FACC6A1A18B419F0;
    }
  }

  if(_id_C4F1BD7A01A307FA(victim))
    victim._id_457667014505E1F9 = _id_4FF6E95896E65939;

  if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7())
    _id_0B7A9CE0A2282B79::_id_EF552DF845E8B952(victim);
}

_id_A87DF010E38D988E(item) {
  item endon("death");
  level endon("game_ended");
  item._id_BBC200BC77C5DB2B = 1;
  wait(getdvarint("dvar_2B4F8183903E67EF", 180));

  if(!isDefined(item)) {
    return;
  }
  item._id_BBC200BC77C5DB2B = undefined;
}

_id_8121CBEE12383790(victim, dropstruct) {
  _id_4FF6E95896E65939 = [];
  _id_BADDE91D16301BE4 = 0;
  _id_094333580DC2B96B = 0;

  for(_id_A6F8D8115E0F1E79 = 0; _id_A6F8D8115E0F1E79 < _id_B13E35608B336D65(victim); _id_A6F8D8115E0F1E79++) {
    quantity = victim _id_897B29ADB37F06A7(_id_A6F8D8115E0F1E79);
    lootid = victim _id_6196D9EA9A30E609(_id_A6F8D8115E0F1E79);

    if(quantity > 0 && lootid > 0) {
      if(_id_2391409EF7B431E1::_id_03C17A26CE6A4668(lootid)) {
        [_id_9BE70D6D4FF253A1, _id_59BD51AFC73DF2CD, _id_DAB81EAD77442A10] = _id_2391409EF7B431E1::_id_379463A84ADB07B4(quantity);
        _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, victim.origin, victim.angles, victim);
        scriptable = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);
        _id_7E52B56769FA7774::spawnpickup(scriptable, _id_CB4FAD49263E20C4, _id_9BE70D6D4FF253A1, 0, undefined, 0, _id_59BD51AFC73DF2CD, _id_DAB81EAD77442A10);
        continue;
      }

      if(_id_02D86BA79A58BB62(lootid)) {
        victim _id_744CAD313ED0A87E::_id_F9FF7C89B3792CCC(dropstruct, victim._id_1FAF51A7DC279A8B);
        continue;
      }

      if(isDefined(_id_728FFCEE8CBF30EE::_id_96A1620D901981D1(lootid, 5))) {
        victim _id_7E52B56769FA7774::_id_B41950C9B54B12E0(dropstruct, _id_A6F8D8115E0F1E79, lootid);
        continue;
      }

      _id_4FF6E95896E65939[_id_A6F8D8115E0F1E79] = [];
      _id_4FF6E95896E65939[_id_A6F8D8115E0F1E79]["lootID"] = lootid;
      _id_4FF6E95896E65939[_id_A6F8D8115E0F1E79]["quantity"] = quantity;

      if(_id_F6F8C1FC9549EAF6(lootid))
        _id_094333580DC2B96B = 1;

      _id_BADDE91D16301BE4++;
    }
  }

  if(istrue(level._id_0F478C1F94CAA7E9) && istrue(level._id_A3499C286AC570E4)) {
    if(_id_EFAB78B72D131D76(victim))
      _id_BADDE91D16301BE4++;
  }

  if(_id_2391409EF7B431E1::_id_C07675F2CE32FCB5(victim)) {
    quantity = _id_2391409EF7B431E1::_id_57711583C5D26490(victim);

    if(isDefined(quantity)) {
      [_id_9BE70D6D4FF253A1, _id_59BD51AFC73DF2CD, _id_DAB81EAD77442A10] = _id_2391409EF7B431E1::_id_379463A84ADB07B4(quantity);
      _id_5983083928CE568C = _id_2391409EF7B431E1::_id_59771B0CC100410A(victim);
      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, victim.origin, victim.angles, victim);
      _id_3DD3ADFB27186CD7 = _id_7E52B56769FA7774::spawnpickup(_id_5983083928CE568C, _id_CB4FAD49263E20C4, _id_9BE70D6D4FF253A1, 0, undefined, 0, _id_59BD51AFC73DF2CD, _id_DAB81EAD77442A10);

      if(isDefined(_id_3DD3ADFB27186CD7)) {
        _id_2391409EF7B431E1::_id_BC03AA369196F2BF(victim, 0);
        victim.dogtag = _id_3DD3ADFB27186CD7;

        if(isDefined(victim._id_D2DBB2FA012E6D9C))
          victim._id_D2DBB2FA012E6D9C[victim._id_D2DBB2FA012E6D9C.size] = _id_3DD3ADFB27186CD7;
      }

      if(isDefined(level._id_547167A7517600FB) && isDefined(level._id_547167A7517600FB._id_A5354AFEB0D5DFCC))
        [[level._id_547167A7517600FB._id_A5354AFEB0D5DFCC]](victim);
    }
  }

  if(_id_BADDE91D16301BE4 > 0) {
    if(istrue(level._id_A2ED7C61B6DA2D72) && scripts\mp\utility\game::isteamreviveenabled()) {
      _id_04F6CDE716E0C3D7 = undefined;
      _id_6FB67C8525B1D79E = undefined;
      _id_3EF503345DC57957 = undefined;
      _id_86B32AFF94B5714E = undefined;
      _id_275F4441AB7920C8 = undefined;
      _id_8348F10D08DAD67A = undefined;
      _id_00AD7897ECDBCB63 = undefined;

      if(_id_EFAB78B72D131D76(victim)) {
        _id_04F6CDE716E0C3D7 = _id_D9B1550011525161(victim);
        _id_6FB67C8525B1D79E = _id_2985254128B1C262(victim);
        _id_3EF503345DC57957 = scripts\engine\utility::ter_op(isDefined(victim._id_3EF503345DC57957), victim._id_3EF503345DC57957, weaponclipsize(_id_6FB67C8525B1D79E));
        _id_275F4441AB7920C8 = _id_724736FCF0FB6604::_id_86A5C7670325346B(victim, 2);

        if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7())
          _id_8348F10D08DAD67A = _id_0B7A9CE0A2282B79::_id_74031E3249A6F69E(self, 2);

        if(_id_6FB67C8525B1D79E.hasalternate) {
          _id_B6FF735C3690CC44 = _id_6FB67C8525B1D79E getaltweapon();
          _id_86B32AFF94B5714E = scripts\engine\utility::ter_op(isDefined(victim._id_86B32AFF94B5714E), victim._id_86B32AFF94B5714E, weaponclipsize(_id_B6FF735C3690CC44));
        }

        if(scripts\mp\utility\weapon::isakimbo(_id_6FB67C8525B1D79E))
          _id_00AD7897ECDBCB63 = scripts\engine\utility::ter_op(isDefined(victim._id_00AD7897ECDBCB63), victim._id_00AD7897ECDBCB63, weaponclipsize(_id_6FB67C8525B1D79E));
      }

      scripts\mp\teamrevive::_id_9341574D596E9D36(victim, _id_4FF6E95896E65939, 6, _id_2391409EF7B431E1::_id_FB2923D9D7EB7AAC(victim), _id_04F6CDE716E0C3D7, _id_6FB67C8525B1D79E, _id_3EF503345DC57957, _id_86B32AFF94B5714E, _id_275F4441AB7920C8, _id_094333580DC2B96B, undefined, undefined, undefined, _id_8348F10D08DAD67A, undefined, undefined, _id_00AD7897ECDBCB63);
    } else {
      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, victim.origin, victim.angles, victim);
      _id_3EDA0EF65C9478AC = scripts\engine\utility::array_find(level.allteamnamelist, victim.team);
      squadindex = victim._id_3F78C6A0862F9E25;
      _id_87583859F07B58E3 = _id_7E52B56769FA7774::spawnpickup(_id_432475069C798DDC(self.attached_bag), _id_CB4FAD49263E20C4, 1, undefined, undefined, undefined, _id_3EDA0EF65C9478AC, squadindex);

      if(isDefined(_id_87583859F07B58E3)) {
        _id_87583859F07B58E3.contents = _id_4FF6E95896E65939;

        if(istrue(level._id_0F478C1F94CAA7E9) && istrue(level._id_A3499C286AC570E4)) {
          if(_id_EFAB78B72D131D76(victim)) {
            _id_87583859F07B58E3._id_04F6CDE716E0C3D7 = _id_D9B1550011525161(victim);
            _id_87583859F07B58E3._id_6FB67C8525B1D79E = _id_2985254128B1C262(victim);
            _id_87583859F07B58E3._id_3EF503345DC57957 = scripts\engine\utility::ter_op(isDefined(victim._id_3EF503345DC57957), victim._id_3EF503345DC57957, weaponclipsize(_id_87583859F07B58E3._id_6FB67C8525B1D79E));
            _id_87583859F07B58E3._id_275F4441AB7920C8 = _id_724736FCF0FB6604::_id_86A5C7670325346B(victim, 2);

            if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7())
              _id_87583859F07B58E3._id_4E479E14D0837E84 = _id_0B7A9CE0A2282B79::_id_74031E3249A6F69E(self, 2);

            if(_id_87583859F07B58E3._id_6FB67C8525B1D79E.hasalternate) {
              _id_B6FF735C3690CC44 = _id_87583859F07B58E3._id_6FB67C8525B1D79E getaltweapon();
              _id_87583859F07B58E3._id_86B32AFF94B5714E = scripts\engine\utility::ter_op(isDefined(victim._id_86B32AFF94B5714E), victim._id_86B32AFF94B5714E, weaponclipsize(_id_B6FF735C3690CC44));
            }

            if(scripts\mp\utility\weapon::isakimbo(_id_87583859F07B58E3._id_6FB67C8525B1D79E))
              _id_87583859F07B58E3._id_00AD7897ECDBCB63 = scripts\engine\utility::ter_op(isDefined(victim._id_00AD7897ECDBCB63), victim._id_00AD7897ECDBCB63, weaponclipsize(_id_87583859F07B58E3._id_6FB67C8525B1D79E));
          }
        }

        _id_87583859F07B58E3._id_46A3A8565AC0C17C = 6;
        _id_87583859F07B58E3.owner = victim;
        _id_87583859F07B58E3._id_846A20D8E6F30B8E = _id_2391409EF7B431E1::_id_FB2923D9D7EB7AAC(victim);
        victim._id_6A4360DCF2A8F3D4 = _id_87583859F07B58E3;

        foreach(item in _id_87583859F07B58E3.contents)
        scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2(item["lootID"], "addedToContainer", _id_87583859F07B58E3, victim);
      }
    }
  }

  if(isDefined(victim.attached_bag) && !istrue(level._id_A2ED7C61B6DA2D72))
    victim _id_4480C6CE37B2BDF3::_id_6D569066AC5F3DF0();
}

_id_AE287E5EB2024104(victim, dropstruct) {
  victim._id_D2DBB2FA012E6D9C = victim _id_88A168912191EC3E();

  if(istrue(level._id_51225D738094457D) && isDefined(victim._id_D2DBB2FA012E6D9C)) {
    _id_C2FC8BF80C1B0AA2 = victim.attached_bag;

    if(!isDefined(_id_C2FC8BF80C1B0AA2))
      _id_C2FC8BF80C1B0AA2 = "brloot_backpack";

    _id_BF23A60678978C19 = [];
    index = 0;
    _id_7803C95645E637E1 = 1;
    _id_04F6CDE716E0C3D7 = undefined;
    _id_6FB67C8525B1D79E = undefined;

    foreach(_id_419647311D7D621F, itemtype in victim._id_D2DBB2FA012E6D9C) {
      if(!itemtype.size) {
        continue;
      }
      foreach(slot in itemtype) {
        if(!isDefined(slot)) {
          continue;
        }
        lootid = slot[0];
        quantity = slot[1];

        if(!istrue(lootid) || !istrue(quantity)) {
          continue;
        }
        if(_id_419647311D7D621F == 1) {
          if(itemtype.size > 1) {
            if(!_id_7803C95645E637E1) {
              _id_04F6CDE716E0C3D7 = lootid;
              _id_6FB67C8525B1D79E = slot[2];
            }

            _id_7803C95645E637E1 = 0;
          }

          continue;
        }

        _id_BF23A60678978C19[index] = [];
        _id_BF23A60678978C19[index]["lootID"] = lootid;
        _id_BF23A60678978C19[index]["quantity"] = quantity;
        index++;
      }
    }

    if(isDefined(_id_BF23A60678978C19) && _id_BF23A60678978C19.size > 0) {
      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, victim.origin, victim.angles, victim);
      _id_3EDA0EF65C9478AC = scripts\engine\utility::array_find(level.allteamnamelist, victim.team);
      squadindex = victim._id_3F78C6A0862F9E25;
      _id_874B2676837CF5A1 = _id_7E52B56769FA7774::spawnpickup(_id_432475069C798DDC(_id_C2FC8BF80C1B0AA2), _id_CB4FAD49263E20C4, 1, undefined, undefined, undefined, _id_3EDA0EF65C9478AC, squadindex);

      if(!isDefined(_id_874B2676837CF5A1)) {
        return;
      }
      if(isDefined(_id_04F6CDE716E0C3D7) && isDefined(_id_6FB67C8525B1D79E)) {
        _id_874B2676837CF5A1._id_04F6CDE716E0C3D7 = _id_04F6CDE716E0C3D7;
        _id_874B2676837CF5A1._id_6FB67C8525B1D79E = _id_6FB67C8525B1D79E;

        if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7())
          _id_874B2676837CF5A1._id_4E479E14D0837E84 = _id_0B7A9CE0A2282B79::_id_74031E3249A6F69E(self, 1);
      }

      _id_874B2676837CF5A1.contents = _id_BF23A60678978C19;
      _id_874B2676837CF5A1._id_46A3A8565AC0C17C = 6;
      _id_874B2676837CF5A1.owner = victim;
      _id_874B2676837CF5A1._id_846A20D8E6F30B8E = _id_2391409EF7B431E1::_id_FB2923D9D7EB7AAC(victim);
      victim._id_77893F01EE39C62E = _id_874B2676837CF5A1;
    }
  }
}

_id_1DB038329EB56917(player, lootid, quantity, _id_3E99C0842E4CCFA7) {
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, player.origin, player.angles, player);
  _id_3EDA0EF65C9478AC = scripts\engine\utility::array_find(level.allteamnamelist, player.team);
  squadindex = player._id_3F78C6A0862F9E25;
  _id_87583859F07B58E3 = _id_7E52B56769FA7774::spawnpickup(_id_432475069C798DDC(self.attached_bag), _id_CB4FAD49263E20C4, 1, undefined, undefined, undefined, _id_3EDA0EF65C9478AC, squadindex);

  if(isDefined(_id_87583859F07B58E3)) {
    _id_4FF6E95896E65939 = [];

    for(_id_F45699551971765C = 0; _id_F45699551971765C < _id_3E99C0842E4CCFA7; _id_F45699551971765C++) {
      _id_4FF6E95896E65939[_id_F45699551971765C] = [];
      _id_4FF6E95896E65939[_id_F45699551971765C]["lootID"] = lootid;
      _id_4FF6E95896E65939[_id_F45699551971765C]["quantity"] = quantity;
    }

    _id_87583859F07B58E3.contents = _id_4FF6E95896E65939;
    _id_87583859F07B58E3._id_46A3A8565AC0C17C = 6;
    _id_87583859F07B58E3.owner = player;
    player calloutmarkerping_create(19, _id_87583859F07B58E3.origin, _id_87583859F07B58E3.index);
  }
}

_id_432475069C798DDC(_id_4F08E017049AD3CB) {
  if(isDefined(_id_4F08E017049AD3CB)) {
    switch (_id_4F08E017049AD3CB) {
      case "parts_backpack_inventory_small":
        return "brloot_backpack_player_small";
      case "parts_backpack_inventory_medium":
        return "brloot_backpack_player_medium";
      case "parts_backpack_inventory_large":
        return "brloot_backpack_player_large";
      case "dmz_backpack_secured":
        return "brloot_backpack_player_secure";
      case "dmz_backpack_scavenger":
        return "brloot_backpack_player_scav";
    }
  }

  return "brloot_backpack";
}

_id_565CBEA3437267D9(player) {
  _id_F6AF44BB087C3DA5 = _id_102ABD6883C5F9BF(player);

  if(_id_F6AF44BB087C3DA5 != 0) {
    _id_14AB898D93FD9B3F = _id_2C4CEE072C4426C4(_id_F6AF44BB087C3DA5);

    switch (_id_14AB898D93FD9B3F) {
      case 1:
        return "parts_backpack_inventory_medium";
      case 2:
        return "parts_backpack_inventory_large";
      case 3:
        return "dmz_backpack_secured";
      case 4:
        return "dmz_backpack_scavenger";
      default:
        return "parts_backpack_inventory_small";
    }

    return "parts_backpack_inventory_small";
  }

  _id_A61C75B156FC1EE0 = _id_B13E35608B336D65(player);

  switch (_id_A61C75B156FC1EE0) {
    case 5:
      return "parts_backpack_inventory_small";
    case 7:
      return "parts_backpack_inventory_medium";
    case 9:
      return "parts_backpack_inventory_large";
    case 11:
      return "dmz_backpack_scavenger";
    default:
      return "parts_backpack_inventory_small";
  }

  return "parts_backpack_inventory_small";
}

_id_3188D9C94B3D56C2(_id_A1093166DE09E6B8) {
  if(!isDefined(_id_A1093166DE09E6B8))
    return 5;

  switch (_id_A1093166DE09E6B8) {
    case "brloot_backpack_medium":
      return 7;
    case "brloot_backpack_large":
      return 9;
    case "brloot_backpack_secure":
      return 5;
    case "brloot_backpack_scav":
      return 11;
    default:
      break;
  }

  return 5;
}

_id_CB9FAEA721C36499(_id_A61C75B156FC1EE0) {
  if(isDefined(_id_A61C75B156FC1EE0)) {
    switch (_id_A61C75B156FC1EE0) {
      case 5:
        return undefined;
      case 7:
        return _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7("brloot_backpack_medium");
      case 9:
        return _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7("brloot_backpack_large");
      default:
        break;
    }
  }

  return undefined;
}

_id_2C4CEE072C4426C4(lootid) {
  if(!isDefined(lootid))
    return 0;

  scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

  if(!isDefined(scriptablename))
    return 0;

  switch (scriptablename) {
    case "brloot_backpack_medium":
      return 1;
    case "brloot_backpack_large":
      return 2;
    case "brloot_backpack_secure":
      return 3;
    case "brloot_backpack_scav":
      return 4;
    default:
      return 0;
  }

  return 0;
}

_id_41B6BFF9497A60D9(lootid) {
  if(!isDefined(lootid))
    return 0;

  scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

  if(!isDefined(scriptablename))
    return 0;

  switch (scriptablename) {
    case "brloot_backpack_medium":
    case "brloot_backpack_large":
      return 1;
    case "brloot_backpack_secure":
      return 0;
    default:
      return 0;
  }

  return 0;
}

_id_C4F1BD7A01A307FA(player) {
  if(istrue(player.extracted))
    return _id_F41D7258200E1D08(player);

  return (_id_F41D7258200E1D08(player) || istrue(player._id_4F7710ECFF5B1619)) && getdvarint("dvar_FF574F42CBB4F9F7", 1);
}

_id_F41D7258200E1D08(player) {
  _id_F6AF44BB087C3DA5 = _id_102ABD6883C5F9BF(player);

  if(_id_F6AF44BB087C3DA5 == 0)
    return 0;

  _id_88B0DF56AEDAF993 = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7("brloot_backpack_secure");

  if(!isDefined(_id_88B0DF56AEDAF993))
    return 0;

  return _id_F6AF44BB087C3DA5 == _id_88B0DF56AEDAF993;
}

_id_102ABD6883C5F9BF(player) {
  if(!isDefined(player._id_CDA8C241EFFB412A))
    return 0;

  return player._id_CDA8C241EFFB412A;
}

_id_91C1BE871300A518(lootid) {
  _id_2713F4A3502D1624 = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

  if(!isDefined(_id_2713F4A3502D1624))
    _id_2713F4A3502D1624 = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);

  return _id_2713F4A3502D1624;
}

_id_F87E08A944AD2C57(array, _id_D35FC50E2F1F14DF) {
  for(_id_AC0E5C4AC96AAA41 = 1; _id_AC0E5C4AC96AAA41 < array.size; _id_AC0E5C4AC96AAA41++) {
    key = array[_id_AC0E5C4AC96AAA41];

    for(_id_AC0E594AC96AA3A8 = _id_AC0E5C4AC96AAA41 - 1; _id_AC0E594AC96AA3A8 >= 0 && ![[_id_D35FC50E2F1F14DF]](array[_id_AC0E594AC96AA3A8], key); _id_AC0E594AC96AA3A8--)
      array[_id_AC0E594AC96AA3A8 + 1] = array[_id_AC0E594AC96AA3A8];

    array[_id_AC0E594AC96AA3A8 + 1] = key;
  }

  return array;
}

_id_A40546ED395D06C8(_id_1C311A2ADD5FAB38) {
  return _id_F87E08A944AD2C57(_id_1C311A2ADD5FAB38, ::_id_6F3FB8A752376EB2);
}

_id_6F3FB8A752376EB2(a, b) {
  return a <= b;
}

_id_8B121DD10A442DD2() {
  if(!isDefined(level._id_C59C301EAABC2E32))
    return 0;

  if(!_id_3583FF375AB3A91E::_id_C84E254980C7C8ED())
    return 0;

  if(!level._id_C59C301EAABC2E32)
    return 1;

  return 0;
}

_id_7E103028C464AB9A(itemname) {
  _id_02C155EAC30EEE07 = _id_8B121DD10A442DD2();

  if(_id_02C155EAC30EEE07 && _id_362C58E8BB39BCDA::isbrgametypefuncdefined("lootAllowedInBackpack"))
    _id_02C155EAC30EEE07 = _id_362C58E8BB39BCDA::runbrgametypefunc("lootAllowedInBackpack", itemname);

  return _id_02C155EAC30EEE07;
}

_id_9AC2038430604B09(player) {
  for(_id_FE4048AD22C35D73 = 0; _id_FE4048AD22C35D73 < 3; _id_FE4048AD22C35D73++) {
    _id_2B3E04E32A6A0C4C = _id_7E52B56769FA7774::_id_13ECF3644442A3E7(player, _id_FE4048AD22C35D73);

    if(isDefined(_id_2B3E04E32A6A0C4C) && !scripts\mp\utility\weapon::isfistsonly(_id_2B3E04E32A6A0C4C) && !scripts\mp\utility\weapon::isgunlessweapon(_id_2B3E04E32A6A0C4C)) {
      _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(_id_2B3E04E32A6A0C4C);

      if(_id_AB501F397D3CD312 != "none")
        return 1;
    }
  }

  return 0;
}

_id_CF1BEF64E94F2D1A(itemtype, _id_3793828403C6873E, _id_A548A6C15CEB9E8C, _id_616AB931ECBA446B, _id_51844D2EE50A997B) {
  _id_A548A6C15CEB9E8C = istrue(_id_A548A6C15CEB9E8C);

  switch (itemtype) {
    case 0:
      if(scripts\mp\utility\game::getsubgametype() == "dmz") {
        plundercount = 0;

        if(isDefined(self.plundercount) && self.plundercount > 0)
          plundercount = _id_7E52B56769FA7774::getquickdropplundercount(!istrue(_id_51844D2EE50A997B));

        if(plundercount <= 0) {
          if(_id_A548A6C15CEB9E8C)
            return [8395, 0];
          else
            return undefined;
        }

        if(!istrue(_id_616AB931ECBA446B))
          _id_6AFF3948CF4CCA03::playersetplundercount(0);

        return [8395, plundercount];
      }

      _id_CB4FAD49263E20C4 = _id_6AFF3948CF4CCA03::_id_79275E2FAB13F54D();
      _id_6AEE9C9054F09ED5 = _id_CB4FAD49263E20C4._id_6AEE9C9054F09ED5;
      _id_B64F283113C99581 = _id_CB4FAD49263E20C4._id_B64F283113C99581;

      if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("playerPlunderModifyInventoryDrop"))
        [_id_6AEE9C9054F09ED5, _id_B64F283113C99581] = _id_362C58E8BB39BCDA::runbrgametypefunc("playerPlunderModifyInventoryDrop", _id_6AEE9C9054F09ED5, _id_B64F283113C99581);

      self.plundercountondeath = _id_6AEE9C9054F09ED5;
      _id_6AFF3948CF4CCA03::playersetplundercount(_id_6AEE9C9054F09ED5);

      if(_id_B64F283113C99581 <= 0) {
        if(_id_A548A6C15CEB9E8C)
          return [8395, 0];
        else
          return undefined;
      }

      return [8395, _id_B64F283113C99581];
    case 1:
      if(_id_3793828403C6873E == 2) {
        if(!_id_EFAB78B72D131D76(self))
          return [0, 0, undefined];

        lootid = self getplayerdata(level._id_5D69837CF4DB0407, "dmzWeapon", "lootItemID");
        _id_0EC22A950F210E39 = _id_2985254128B1C262(self);
        _id_A895F5DBA4DE0DA1 = scripts\engine\utility::ter_op(isDefined(self._id_3EF503345DC57957), self._id_3EF503345DC57957, self getweaponammoclip(_id_0EC22A950F210E39));
        return [lootid, _id_A895F5DBA4DE0DA1, _id_0EC22A950F210E39];
      }

      _id_0EC22A950F210E39 = _id_7E52B56769FA7774::_id_13ECF3644442A3E7(self, _id_3793828403C6873E);

      if(!isDefined(_id_0EC22A950F210E39)) {
        if(_id_A548A6C15CEB9E8C)
          return [0, 0, undefined];
        else
          return undefined;
      }

      _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(_id_0EC22A950F210E39);
      variantid = _id_0EC22A950F210E39.variantid;

      if(!isDefined(_id_0EC22A950F210E39.variantid))
        variantid = 0;

      lootid = _id_2669878CF5A1B6BC::_id_79D6E6C22245687A(_id_AB501F397D3CD312, variantid);
      return [lootid, self getweaponammoclip(_id_0EC22A950F210E39), _id_0EC22A950F210E39];
    case 10:
      return _id_6738846DA50730F1(_id_3793828403C6873E);
    case 2:
      slot = scripts\mp\equipment::_id_4967838290CB31B9(_id_3793828403C6873E);

      if(!isDefined(self.equipment[slot])) {
        if(_id_A548A6C15CEB9E8C)
          return [0, 0];
        else
          return undefined;
      }

      ref = self.equipment[slot];
      _id_FEB782334DD23A66 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, self.equipment[slot]);
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_FEB782334DD23A66);
      ammocount = 0;

      if(ref == "equip_hb_sensor")
        ammocount = _id_0EC0F9AD939B29E0::_id_DB61876ACA4E4CD3();
      else if(istrue(_id_51844D2EE50A997B))
        ammocount = 1;
      else
        ammocount = scripts\mp\equipment::getequipmentslotammo(slot);

      return [lootid, ammocount];
    case 3:
      if(!isDefined(self.streakdata.streaks[1])) {
        if(_id_A548A6C15CEB9E8C)
          return [0, 0];
        else
          return undefined;
      }

      scriptable = level.br_pickups._id_838863C4848D4C26[self.streakdata.streaks[1].streakname];
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(scriptable);
      return [lootid, 1];
    case 4:
      if(!isDefined(self.equipment["super"])) {
        if(_id_A548A6C15CEB9E8C)
          return [0, 0];
        else
          return undefined;
      }

      _id_FEB782334DD23A66 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, self.equipment["super"]);
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_FEB782334DD23A66);
      ammocount = _id_7E52B56769FA7774::_id_FCDE72DCBCEC206B();

      if(isDefined(ammocount) && ammocount == 0) {
        if(istrue(self._id_1066FBD86C88A6DF) || scripts\mp\perks\perkfunctions::_id_66F0CBD5FF8458FE() && scripts\mp\supers::issuperready())
          ammocount = 1;
      }

      ammocount = scripts\engine\utility::_id_53C4C53197386572(ammocount, 0);
      return [lootid, ammocount];
    case 6:
      if(!scripts\cp_mp\gasmask::hasgasmask(self)) {
        if(_id_A548A6C15CEB9E8C)
          return [0, 0];
        else
          return undefined;
      }

      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(self.gasmasktype);
      quantity = int(self.gasmaskhealth);
      return [lootid, quantity];
    case 7:
      if(!_id_2CEDCC356F1B9FC8::hasselfrevivetoken()) {
        if(_id_A548A6C15CEB9E8C)
          return [0, 0];
        else
          return undefined;
      }

      if(scripts\mp\utility\game::getsubgametype() == "resurgence") {
        if(level.br_circle.circleindex == 0) {
          if(!isDefined(self._id_AD98D6456993DAFE)) {
            self._id_AD98D6456993DAFE = 1;

            if(_id_A548A6C15CEB9E8C)
              return [0, 0];
            else
              return undefined;
          }
        }
      }

      _id_D11137E58D02736C = _id_2CEDCC356F1B9FC8::_id_791E72676CD7B544(self);
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_D11137E58D02736C);
      return [lootid, 1];
    default:
      return;
  }
}

_id_B13E35608B336D65(player) {
  _id_342175A1B9F9067E = _id_684EF6E1C75B5518(player);

  if(isDefined(_id_342175A1B9F9067E))
    return _id_342175A1B9F9067E;
  else
    return 0;
}

_id_684EF6E1C75B5518(player) {
  if(istrue(level._id_A7F81DFDC88E53E6))
    return level._id_E247454AC2869696;

  return player getplayerdata(level._id_5D69837CF4DB0407, level._id_342175A1B9F9067E);
}

_id_D28F52DA6EDE0191(player, _id_A61C75B156FC1EE0, _id_CB6CD39E3733B463, _id_CDA8C241EFFB412A) {
  player._id_CDA8C241EFFB412A = _id_CDA8C241EFFB412A;

  if(!isDefined(_id_CDA8C241EFFB412A))
    player._id_CDA8C241EFFB412A = _id_CB9FAEA721C36499(_id_A61C75B156FC1EE0);

  _id_14AB898D93FD9B3F = _id_2C4CEE072C4426C4(player._id_CDA8C241EFFB412A);
  player setclientomnvar("ui_loot_backpack_type", _id_14AB898D93FD9B3F);
  player setplayerdata(level._id_5D69837CF4DB0407, level._id_342175A1B9F9067E, _id_A61C75B156FC1EE0);
  player setplayerdata(level._id_5D69837CF4DB0407, "backpackSize", _id_A61C75B156FC1EE0);

  if(istrue(_id_CB6CD39E3733B463)) {
    return;
  }
  _id_8F24A28261FB9DA3 = _id_565CBEA3437267D9(player);
  player _id_4480C6CE37B2BDF3::_id_0C3F3FCEEDDDA6F6(_id_8F24A28261FB9DA3);
}

_id_6491BD812BB47EFB(player, _id_A0D21FDD38F60ECF, _id_2713F4A3502D1624) {
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

  for(_id_AC0E594AC96AA3A8 = _id_A0D21FDD38F60ECF; _id_AC0E594AC96AA3A8 < 11; _id_AC0E594AC96AA3A8++) {
    [lootid, quantity] = _id_6738846DA50730F1(_id_AC0E594AC96AA3A8);

    if(!isDefined(lootid) || !isDefined(quantity)) {
      continue;
    }
    if(lootid == 0 || quantity == 0) {
      continue;
    }
    _id_7E52B56769FA7774::_id_6F62CB4FC113349C(player, 10, _id_AC0E594AC96AA3A8, 1);
  }

  if(!_id_18E2D7A6912B1D07(_id_2713F4A3502D1624) && _id_EFAB78B72D131D76(player))
    _id_7E52B56769FA7774::_id_62F068CEC343A111(player, 1, 2);
}

_id_18E2D7A6912B1D07(_id_2713F4A3502D1624) {
  if(!isDefined(_id_2713F4A3502D1624))
    return 0;

  switch (_id_2713F4A3502D1624) {
    case "brloot_backpack_medium":
    case "brloot_backpack_large":
      return 1;
    case "brloot_backpack_scav":
    case "brloot_backpack_secure":
      return 0;
    default:
      return 0;
  }

  return 0;
}

_id_69A380E3F9C37CC7(player) {
  foreach(weaponobj in player.primaryinventory) {
    if(weaponobj.basename == "iw9_me_fists_mp")
      return 0;
  }

  if(!_id_EFAB78B72D131D76(player))
    return 0;

  return 1;
}

_id_631FD0855C653A68(player, _id_3340318A370A7CB2) {
  level endon("game_ended");
  player endon("disconnect");

  while(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7() && !istrue(self _meth_F6C07D6EA7D83A5A()))
    waitframe();

  _id_E7FC8151A96DC953 = _id_0B7A9CE0A2282B79::_id_C241FBC63120CFC4(player, _id_3340318A370A7CB2);

  if(!istrue(level._id_A7F81DFDC88E53E6)) {
    _id_342175A1B9F9067E = _id_B13E35608B336D65(player);
    _id_CDA8C241EFFB412A = scripts\engine\utility::ter_op(istrue(_id_E7FC8151A96DC953), player._id_CDA8C241EFFB412A, undefined);
    _id_D28F52DA6EDE0191(player, _id_342175A1B9F9067E, 1, _id_CDA8C241EFFB412A);
  }

  scripts\mp\flags::_id_1240434F4201AC9D("prematch_done");
  _id_E7FC8151A96DC953 = _id_0B7A9CE0A2282B79::_id_FC56050BD3DCEA6C(player);
}

_id_88A168912191EC3E(_id_73957FA8E31562B2, _id_A548A6C15CEB9E8C, _id_616AB931ECBA446B) {
  _id_BF23A60678978C19 = [];
  _id_BF23A60678978C19[0] = [];
  _id_BF23A60678978C19[0][0] = _id_CF1BEF64E94F2D1A(0, 0, _id_A548A6C15CEB9E8C, _id_616AB931ECBA446B);
  _id_BF23A60678978C19[1] = [];
  _id_BF23A60678978C19[1][0] = _id_CF1BEF64E94F2D1A(1, 0, _id_A548A6C15CEB9E8C);
  _id_BF23A60678978C19[1][1] = _id_CF1BEF64E94F2D1A(1, 1, _id_A548A6C15CEB9E8C);
  _id_BF23A60678978C19[2] = [];
  _id_BF23A60678978C19[2][0] = _id_CF1BEF64E94F2D1A(2, 0, _id_A548A6C15CEB9E8C);
  _id_BF23A60678978C19[2][1] = _id_CF1BEF64E94F2D1A(2, 1, _id_A548A6C15CEB9E8C);
  _id_BF23A60678978C19[2][2] = _id_CF1BEF64E94F2D1A(2, 2, _id_A548A6C15CEB9E8C);
  _id_BF23A60678978C19[3] = [];

  if(istrue(_id_73957FA8E31562B2))
    _id_BF23A60678978C19[3][0] = _id_CF1BEF64E94F2D1A(3, 0, _id_A548A6C15CEB9E8C);

  _id_BF23A60678978C19[4] = [];
  _id_BF23A60678978C19[4][0] = _id_CF1BEF64E94F2D1A(4, 0, _id_A548A6C15CEB9E8C);

  if(istrue(_id_73957FA8E31562B2)) {
    _id_BF23A60678978C19[6] = [];
    _id_BF23A60678978C19[6][0] = _id_CF1BEF64E94F2D1A(6, 0, _id_A548A6C15CEB9E8C);
    _id_BF23A60678978C19[7] = [];
    _id_BF23A60678978C19[7][0] = _id_CF1BEF64E94F2D1A(7, 0, _id_A548A6C15CEB9E8C);
  }

  return _id_BF23A60678978C19;
}

_id_B4F4561FDB86FA25(player) {
  if(!istrue(level._id_D034183ABF2E274D) || _id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7() || istrue(level._id_B4F4561FDB86FA25)) {
    player _id_BAB1A10B3FDAAE51();
    _id_590202DAF6A1D4D7(player);
    _id_D28F52DA6EDE0191(player, 5, 1);
    player setplayerdata(level._id_5D69837CF4DB0407, "dmzPlateCarrierLevel", 1);
    _id_590202DAF6A1D4D7(player);
  }
}

_id_F1F10297297D06C8() {}

_id_720D227D0E55A960() {
  if(!isDefined(level._id_7D17E26667BE2792))
    level._id_7D17E26667BE2792 = getdvarint("dvar_55D9444D8A3CE31A", 0);

  return level._id_7D17E26667BE2792;
}

_id_5323BEF1AD6244B9(damagetick) {
  _id_E32ED31BF12217D2 = [];
  _id_E32ED31BF12217D2 = _id_5915BDBC5F6302B6(level._id_534E97D34EF9FA29);

  foreach(_id_0A58C1FCA5D8A5B2 in _id_E32ED31BF12217D2)
  _id_E900E7E66383AD97(self, _id_0A58C1FCA5D8A5B2, int(_id_897B29ADB37F06A7(_id_0A58C1FCA5D8A5B2) - damagetick));
}

_id_E25E584CAC984A5D(itemtype) {
  if(!isDefined(itemtype))
    return 0;

  return itemtype == "plunder" || itemtype == "valuable" || itemtype == "personal" || itemtype == "dogtag";
}

_id_F4FC5C80C4D45C10(_id_51BE4043D33594E7) {
  if(isDefined(self._id_901A9107CE867B4C)) {
    self._id_901A9107CE867B4C._id_BBC200BC77C5DB2B = undefined;
    self._id_901A9107CE867B4C notify("end_backpack_empty_watcher");
  }

  self._id_901A9107CE867B4C = _id_51BE4043D33594E7;
  self._id_901A9107CE867B4C._id_BBC200BC77C5DB2B = 1;
  self._id_901A9107CE867B4C thread _id_7F924754A3DA2A62();
}

_id_7F924754A3DA2A62() {
  level endon("game_ended");
  self endon("end_backpack_empty_watcher");

  while(isDefined(self) && !isDefined(self._id_BF23A60678978C19))
    wait 0.05;

  while(isDefined(self) && isDefined(self._id_BF23A60678978C19)) {
    _id_1866E32D84CB48A7 = 1;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self._id_BF23A60678978C19.size - 1; _id_AC0E594AC96AA3A8++) {
      if(self._id_BF23A60678978C19[_id_AC0E594AC96AA3A8]["quantity"])
        _id_1866E32D84CB48A7 = 0;
    }

    if(_id_1866E32D84CB48A7) {
      self._id_BBC200BC77C5DB2B = undefined;
      return;
    }

    wait 1;
  }
}

_id_68BCA2C2E9F0A1D3(_id_47868F432C8FCB6B, _id_5E7CE68553217EAF) {
  _id_342175A1B9F9067E = _id_B13E35608B336D65(self);

  if(_id_47868F432C8FCB6B < 0 || _id_47868F432C8FCB6B >= _id_342175A1B9F9067E || _id_5E7CE68553217EAF < 0 || _id_5E7CE68553217EAF >= _id_342175A1B9F9067E) {
    return;
  }
  [_id_026E51DC5F1CC490, _id_C1500F171AEB561A] = _id_6738846DA50730F1(_id_47868F432C8FCB6B);
  [_id_41DCBC4D3302F6DC, _id_4819AFA0C5073B0E] = _id_6738846DA50730F1(_id_5E7CE68553217EAF);

  if(isDefined(_id_026E51DC5F1CC490) && isDefined(_id_C1500F171AEB561A) && isDefined(_id_41DCBC4D3302F6DC) && isDefined(_id_4819AFA0C5073B0E)) {
    _id_A0CCC23064473A05(self, _id_5E7CE68553217EAF, _id_026E51DC5F1CC490, _id_C1500F171AEB561A);
    _id_A0CCC23064473A05(self, _id_47868F432C8FCB6B, _id_41DCBC4D3302F6DC, _id_4819AFA0C5073B0E);

    if(_id_7E52B56769FA7774::_id_9B77601837F66E32(_id_026E51DC5F1CC490) || _id_7E52B56769FA7774::_id_9B77601837F66E32(_id_41DCBC4D3302F6DC))
      _id_728FFCEE8CBF30EE::_id_6D070B6AD87FC4A2(self, _id_026E51DC5F1CC490, _id_41DCBC4D3302F6DC, _id_47868F432C8FCB6B, _id_5E7CE68553217EAF);

    if(_id_7E52B56769FA7774::_id_B605A733974C2FF5(_id_026E51DC5F1CC490) && _id_7C03AB87C5F9F420::_id_8E1F9B3B6C83372D(_id_47868F432C8FCB6B))
      _id_7C03AB87C5F9F420::_id_9EE717001ACD63A0(_id_5E7CE68553217EAF);
    else if(_id_7E52B56769FA7774::_id_B605A733974C2FF5(_id_41DCBC4D3302F6DC) && _id_7C03AB87C5F9F420::_id_8E1F9B3B6C83372D(_id_5E7CE68553217EAF))
      _id_7C03AB87C5F9F420::_id_9EE717001ACD63A0(_id_47868F432C8FCB6B);
  }
}

_id_CE92A41B8F3B666F(_id_65B695F0C0D909ED, _id_D54A79024C228770) {
  _id_342175A1B9F9067E = _id_B13E35608B336D65(self);
  _id_69E96A4CAA72D794 = self._id_02FA5B49969DEF47;

  if(_id_65B695F0C0D909ED < 0 || _id_65B695F0C0D909ED >= _id_342175A1B9F9067E) {
    return;
  }
  [_id_F27898E4AFD922B4, _id_DFAB44D4D8D10B36] = _id_6738846DA50730F1(_id_65B695F0C0D909ED);
  [_id_879D3E9D5C72B703, _id_EA1DCC638E88B8C9] = scripts\mp\loot::_id_EDB397974AE6EE68(self, _id_69E96A4CAA72D794, _id_D54A79024C228770, 0);
  scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(_id_F27898E4AFD922B4);

  if(isDefined(_id_F27898E4AFD922B4) && isDefined(_id_DFAB44D4D8D10B36) && isDefined(_id_879D3E9D5C72B703) && isDefined(_id_EA1DCC638E88B8C9)) {
    _id_DA5C10799C16C24F = 8569;

    if(_id_879D3E9D5C72B703 == _id_DA5C10799C16C24F) {
      scripts\mp\loot::_id_F0617AD70B7E7792(_id_D54A79024C228770, _id_65B695F0C0D909ED, _id_69E96A4CAA72D794);
      return;
    } else
      _id_A0CCC23064473A05(self, _id_65B695F0C0D909ED, _id_879D3E9D5C72B703, _id_EA1DCC638E88B8C9);

    if(_id_F27898E4AFD922B4 == 0 || scripts\engine\utility::_id_5B7E9A4C946F3A13(_id_69E96A4CAA72D794._id_46A3A8565AC0C17C, [13, 15]))
      scripts\mp\loot::_id_153D3281E46E14DA(self, _id_69E96A4CAA72D794, _id_D54A79024C228770, _id_F27898E4AFD922B4, _id_DFAB44D4D8D10B36);
    else {
      scripts\mp\loot::_id_153D3281E46E14DA(self, _id_69E96A4CAA72D794, _id_D54A79024C228770, 0, 0);
      dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
      item = _id_7E52B56769FA7774::spawnpickup(scriptablename, _id_CB4FAD49263E20C4, _id_DFAB44D4D8D10B36, 1);
      scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2(scriptablename, "dropped", item, self, _id_CB4FAD49263E20C4.origin);
    }

    _id_2789584B4D4CB228 = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(_id_F27898E4AFD922B4);

    if(_id_7E52B56769FA7774::_id_282D89F7705A2D63(_id_2789584B4D4CB228))
      _id_7E52B56769FA7774::_id_BFC82C27ED3D9308(_id_F27898E4AFD922B4, _id_DFAB44D4D8D10B36, _id_2789584B4D4CB228, _id_65B695F0C0D909ED);
  }
}

_id_1D982E57487B7EFE() {
  startweapon = self getcurrentweapon();
  primaryweapon = _id_7E52B56769FA7774::_id_13ECF3644442A3E7(self, 0);
  secondaryweapon = _id_7E52B56769FA7774::_id_13ECF3644442A3E7(self, 1);

  if(scripts\mp\utility\weapon::_id_1E9278BA699927F7(primaryweapon) || scripts\mp\utility\weapon::_id_1E9278BA699927F7(secondaryweapon)) {
    return;
  }
  _id_F5E71C4DF042FA27 = _id_724736FCF0FB6604::br_ammo_type_for_weapon(primaryweapon);
  _id_4CC9E4D0A2B19A67 = _id_724736FCF0FB6604::br_ammo_type_for_weapon(secondaryweapon);
  _id_1AB509D42ABD4C39 = self getweaponammoclip(primaryweapon);
  _id_F877D26184FC0D79 = self getweaponammoclip(secondaryweapon);
  _id_DCF6299535B22F5E = 0;
  _id_2E177550D1CC0F9E = 0;

  if(primaryweapon.basename != "iw9_me_fists_mp")
    _id_DCF6299535B22F5E = self.br_ammo[_id_F5E71C4DF042FA27];

  if(secondaryweapon.basename != "iw9_me_fists_mp")
    _id_2E177550D1CC0F9E = self.br_ammo[_id_4CC9E4D0A2B19A67];

  self switchtoweaponimmediate(scripts\engine\utility::ter_op(issameweapon(startweapon, primaryweapon), secondaryweapon, primaryweapon));
  self takeweapon(primaryweapon);
  self takeweapon(secondaryweapon);
  self giveweapon(secondaryweapon);
  self giveweapon(primaryweapon);

  if(primaryweapon.basename != "iw9_me_fists_mp") {
    _id_724736FCF0FB6604::br_ammo_update_ammotype_weapons(self, _id_F5E71C4DF042FA27, _id_DCF6299535B22F5E);
    self setweaponammoclip(primaryweapon, _id_1AB509D42ABD4C39);
  }

  if(secondaryweapon.basename != "iw9_me_fists_mp") {
    _id_724736FCF0FB6604::br_ammo_update_ammotype_weapons(self, _id_4CC9E4D0A2B19A67, _id_2E177550D1CC0F9E);
    self setweaponammoclip(secondaryweapon, _id_F877D26184FC0D79);
  }
}

_id_51301C83420D42B4(_id_03DE70F4007CA2C9, _id_D54A79024C228770) {
  _id_69E96A4CAA72D794 = self._id_02FA5B49969DEF47;
  [_, _id_6FB67C8525B1D79E, _id_E1147886CCF51970, _id_4E479E14D0837E84, quantity, _id_18C2C5B0A787D075, _id_CF4FD93A53325100] = scripts\mp\loot::_id_775A7FC396485A9A(self, _id_69E96A4CAA72D794, _id_D54A79024C228770);
  weapon = _id_6FB67C8525B1D79E;

  if(scripts\mp\utility\weapon::_id_1E9278BA699927F7(weapon)) {
    return;
  }
  quantity = scripts\engine\utility::_id_53C4C53197386572(quantity, weaponclipsize(weapon));

  if(scripts\mp\utility\weapon::isakimbo(weapon))
    _id_CF4FD93A53325100 = scripts\engine\utility::_id_53C4C53197386572(_id_CF4FD93A53325100, weaponclipsize(weapon));

  _id_CDA8C241EFFB412A = _id_102ABD6883C5F9BF(self);
  _id_2713F4A3502D1624 = _id_91C1BE871300A518(_id_CDA8C241EFFB412A);
  _id_44EE85DCF52B4001 = _id_18E2D7A6912B1D07(_id_2713F4A3502D1624) && !_id_EFAB78B72D131D76(self);
  self.lastdroppableweaponobj = self.primaryweapons[_id_03DE70F4007CA2C9];
  success = _id_7E52B56769FA7774::_id_E5845FF9B61AC5D7(weapon, quantity, undefined, _id_18C2C5B0A787D075, _id_44EE85DCF52B4001, undefined, _id_4E479E14D0837E84, undefined, undefined, _id_E1147886CCF51970, _id_CF4FD93A53325100);

  if(success) {
    if(scripts\mp\loot::_id_54066DBD8EF44FE1(_id_69E96A4CAA72D794) || _id_69E96A4CAA72D794._id_46A3A8565AC0C17C == 15)
      scripts\mp\loot::_id_505E8EB7E77704C5(self, _id_69E96A4CAA72D794);
    else
      scripts\mp\loot::_id_153D3281E46E14DA(self, _id_69E96A4CAA72D794, _id_D54A79024C228770, 0, 0);
  }
}

_id_9F1F9042105E4240(itemtype, _id_3793828403C6873E, _id_65B695F0C0D909ED) {
  if(!_id_1E4A61DB11011446::_id_420EC7054801A5BD(itemtype, _id_3793828403C6873E)) {
    return;
  }
  _id_13ECA9A3244E502F = _id_CF1BEF64E94F2D1A(itemtype, _id_3793828403C6873E);

  if(!isDefined(_id_13ECA9A3244E502F)) {
    return;
  }
  _id_10E2428105250E94 = _id_13ECA9A3244E502F[0];
  _id_E0628A07E9D30516 = _id_13ECA9A3244E502F[1];
  [_id_F27898E4AFD922B4, _id_DFAB44D4D8D10B36] = _id_6738846DA50730F1(_id_65B695F0C0D909ED);
  _id_FE868233E98E9D8B = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(_id_F27898E4AFD922B4);
  _id_ECBFB8D6F45CA36B = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(_id_10E2428105250E94);
  _id_3A83234B1FA4439D = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(_id_10E2428105250E94);
  _id_B3FCCFB5CA1D6EA8 = _id_F27898E4AFD922B4 == 0;

  if(!_id_B3FCCFB5CA1D6EA8) {
    _id_128A351CEA87D140 = _id_7E52B56769FA7774::issuperpickup(_id_FE868233E98E9D8B) && _id_7E52B56769FA7774::issuperpickup(_id_ECBFB8D6F45CA36B);
    _id_BB9A27098C4E4DE9 = _id_3A83234B1FA4439D != "super_stimpistol" || _id_3A83234B1FA4439D != "super_oxygen_mask";

    if(_id_128A351CEA87D140 && _id_BB9A27098C4E4DE9) {
      thread _id_7E52B56769FA7774::_id_CAB3366841D709AA(_id_65B695F0C0D909ED);
      return;
    }
  }

  if(_id_10E2428105250E94 == _id_F27898E4AFD922B4 && _id_E01D9736B2D100AC(_id_10E2428105250E94, _id_E0628A07E9D30516)) {
    _id_7E52B56769FA7774::_id_D8CD9C1941A88194(_id_10E2428105250E94, _id_E0628A07E9D30516, undefined, 1, 1, 1);
    thread _id_7E52B56769FA7774::quickdropall(itemtype, _id_3793828403C6873E, 1);
    return;
  }

  _id_A0CCC23064473A05(self, _id_65B695F0C0D909ED, _id_10E2428105250E94, _id_E0628A07E9D30516);
  thread _id_7E52B56769FA7774::quickdropall(itemtype, _id_3793828403C6873E, 1);

  if(!_id_B3FCCFB5CA1D6EA8 && !_id_7E52B56769FA7774::br_forcegivecustompickupitem(self, _id_FE868233E98E9D8B, 1, _id_DFAB44D4D8D10B36)) {
    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
    item = _id_7E52B56769FA7774::spawnpickup(_id_FE868233E98E9D8B, _id_CB4FAD49263E20C4, _id_DFAB44D4D8D10B36, 1);
  }
}

_id_A763F6F503206771(player, scriptable, lootid) {
  if(!isDefined(scriptable) || !isDefined(player)) {
    return;
  }
  _id_60227BFF1E9478CC = spawnStruct();
  _id_60227BFF1E9478CC.scriptablename = _id_7E52B56769FA7774::_id_155B1A2C8879BDA5(scriptable);
  _id_60227BFF1E9478CC.count = scriptable.count;
  _id_A08D277F2971B749 = 0;

  if(_id_7E52B56769FA7774::isweaponpickup(_id_60227BFF1E9478CC.scriptablename)) {
    if(_id_B13E35608B336D65(player) <= 5) {
      return;
    }
    if(istrue(player._id_859654E0445A36D9) && isDefined(level.br_pickups._id_355CDDB773CB000D)) {
      player scripts\mp\hud_message::showerrormessage(level.br_pickups._id_355CDDB773CB000D);
      return;
    }

    _id_0CC708B3BF7C11ED = _id_724736FCF0FB6604::_id_55C5D35C8C76A95B(scriptable);
    _id_DD515FCF025B2E79 = _id_0CC708B3BF7C11ED[0];
    _id_A08D277F2971B749 = 0;

    foreach(_id_DE88CD14114C1E24 in player.primaryweapons) {
      if(issameweapon(_id_DE88CD14114C1E24, _id_DD515FCF025B2E79)) {
        _id_60227BFF1E9478CC.scriptablename = _id_724736FCF0FB6604::br_ammo_type_for_weapon(_id_DD515FCF025B2E79);
        _id_60227BFF1E9478CC.count = weaponclipsize(_id_DD515FCF025B2E79);
        lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_60227BFF1E9478CC.scriptablename);
        _id_A08D277F2971B749 = 1;
      }
    }

    if(_id_EFAB78B72D131D76(player) && !_id_A08D277F2971B749) {
      _id_9AC5E72784815708 = _id_2985254128B1C262(player);

      if(issameweapon(_id_9AC5E72784815708, _id_DD515FCF025B2E79)) {
        _id_60227BFF1E9478CC.scriptablename = _id_724736FCF0FB6604::br_ammo_type_for_weapon(_id_DD515FCF025B2E79);
        _id_60227BFF1E9478CC.count = weaponclipsize(_id_DD515FCF025B2E79);
        lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_60227BFF1E9478CC.scriptablename);
        _id_A08D277F2971B749 = 1;
      } else {
        dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
        _id_FACC6A1A18B419F0 = player _id_7E52B56769FA7774::dropbrweapon(_id_9AC5E72784815708, dropstruct, scriptable.origin);
        _id_9BE70D6D4FF253A1 = scripts\engine\utility::_id_53C4C53197386572(player._id_3EF503345DC57957, 0);
        _id_59BD51AFC73DF2CD = scripts\engine\utility::_id_53C4C53197386572(player._id_00AD7897ECDBCB63, 0);
        _id_7E52B56769FA7774::loot_setitemcount(_id_FACC6A1A18B419F0, _id_9BE70D6D4FF253A1, _id_59BD51AFC73DF2CD, player._id_86B32AFF94B5714E);

        if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7())
          _id_FACC6A1A18B419F0._id_4E479E14D0837E84 = _id_0B7A9CE0A2282B79::_id_74031E3249A6F69E(player, 2);

        _id_954372D604277278(player);
      }
    }

    if(!_id_A08D277F2971B749) {
      _id_BADA25504E8844D7 = spawnStruct();
      _id_CFCB8FC02F9DB4DC = _id_7E52B56769FA7774::loot_getitemcount(scriptable);
      _id_BADA25504E8844D7.scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);
      _id_BADA25504E8844D7.origin = player.origin;
      _id_BADA25504E8844D7.count = _id_CFCB8FC02F9DB4DC;
      _id_BADA25504E8844D7.weapon = _id_DD515FCF025B2E79;
      _id_BADA25504E8844D7._id_4A08890FD43D6BC7 = 1;
      _id_BADA25504E8844D7.countlefthand = 0;
      _id_BADA25504E8844D7._id_E97D731BEDD44C63 = scriptable._id_E97D731BEDD44C63;
      _id_BADA25504E8844D7._id_4E479E14D0837E84 = scriptable._id_4E479E14D0837E84;
      _id_BADA25504E8844D7.customweaponname = scriptable.customweaponname;
      _id_BADA25504E8844D7._id_E1147886CCF51970 = scriptable._id_E1147886CCF51970;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pmc_missions", "onPickupWeapon"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("pmc_missions", "onPickupWeapon")]](player, _id_DD515FCF025B2E79, _id_BADA25504E8844D7._id_4E479E14D0837E84);

      _id_7E52B56769FA7774::_id_60234AA487445085(_id_BADA25504E8844D7, player, 0, scriptable);
      return;
    }
  }

  results = _id_7E52B56769FA7774::cantakepickup(_id_60227BFF1E9478CC);

  if(results == 1 && (_id_E01D9736B2D100AC(lootid, _id_60227BFF1E9478CC.count) || _id_7E52B56769FA7774::isplunder(_id_60227BFF1E9478CC.scriptablename)) || results == 20) {
    _id_5A88DBC7A4ED6E63 = 1 && !_id_7E52B56769FA7774::isplunder(_id_60227BFF1E9478CC.scriptablename) && !_id_2CEDCC356F1B9FC8::isammo(_id_60227BFF1E9478CC.scriptablename);
    _id_7E52B56769FA7774::lootused(scriptable, undefined, undefined, player, undefined, undefined, 1, _id_5A88DBC7A4ED6E63);
    return;
  }

  if(!player _id_1E4A61DB11011446::_id_1C7F3F4E23F94F86(_id_60227BFF1E9478CC.scriptablename)) {
    return;
  }
  if(_id_7E52B56769FA7774::isplunder(_id_60227BFF1E9478CC.scriptablename)) {
    return;
  }
  if(_id_A08D277F2971B749) {
    player scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyalreadyhaveweapon);
    return;
  }

  if(_id_7E52B56769FA7774::_id_DF3F5431C93ED5A1(lootid)) {
    player scripts\mp\hud_message::showerrormessage(level.br_pickups._id_61251EF22EFA8D15);
    return;
  }

  _id_491C9B4E02748831 = scriptable;
  _id_491C9B4E02748831.contents = [];
  _id_491C9B4E02748831._id_46A3A8565AC0C17C = 14;
  _id_491C9B4E02748831.contents[0] = [];
  _id_491C9B4E02748831.contents[0]["quantity"] = scriptable.count;
  _id_491C9B4E02748831.contents[0]["lootID"] = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_60227BFF1E9478CC.scriptablename);
  scripts\mp\loot::_id_68CA06034B8AACCD(player, _id_491C9B4E02748831);
}

_id_C2F16E2BBB4E38C0(_id_4185480FA177DDB5, quantity) {
  if(!isDefined(quantity))
    quantity = 1;

  items = strtok(_id_4185480FA177DDB5, ",");

  foreach(itemname in items) {
    _id_65B695F0C0D909ED = _id_AE22C70A9C2474D9();

    if(!isDefined(_id_65B695F0C0D909ED)) {
      break;
    }

    _id_60227BFF1E9478CC = spawnStruct();
    _id_60227BFF1E9478CC.scriptablename = itemname;
    _id_60227BFF1E9478CC.count = quantity;
    lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_60227BFF1E9478CC.scriptablename);
    _id_10F6E537F1B5763C(lootid, _id_60227BFF1E9478CC);
  }
}