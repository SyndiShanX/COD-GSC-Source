/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_b7a9ce0a2282b79.gsc
***********************************************/

init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("instanceInventory", "restorePlateCarrier", ::_id_743A2B4D08F023D2);
  scripts\cp_mp\utility\script_utility::registersharedfunc("instanceInventory", "getNumStartUpgradePlates", ::_id_35BD7333660F5D4C);
  scripts\cp_mp\utility\script_utility::registersharedfunc("instanceInventory", "getUpgradeCount", ::_id_07E5492B68492F80);
}

initteamdatafields() {
  foreach(team in level.teamnamelist)
  level.teamdata[team]["extractedStashItems"] = [];
}

_id_DDBC94F52A1947B5(player, lootid) {
  _id_95C7C9334EA70BD8 = scripts\mp\utility\teams::getteamdata(player.team, "extractedStashItems");
  _id_95C7C9334EA70BD8[lootid] = 1;
  scripts\mp\utility\teams::setteamdata(player.team, "extractedStashItems", _id_95C7C9334EA70BD8);
}

_id_E0FC1230452CF4E7() {
  if(!isDefined(level._id_8F125BA0DC7C4B33))
    level._id_8F125BA0DC7C4B33 = getdvarint("dvar_0A31E837C3D3A9C9", 0);

  return level._id_8F125BA0DC7C4B33;
}

_id_758B22811E547EFE() {
  if(!isDefined(level._id_77441E4682269FC5))
    level._id_77441E4682269FC5 = getdvarint("dvar_3A0B46B826670C2B", 0);

  return level._id_77441E4682269FC5;
}

_id_DEDF2039EDEE97D0() {
  if(!isDefined(level._id_8FA33B5EFBA196A8))
    level._id_8FA33B5EFBA196A8 = getdvarint("dvar_EFFDF75F46ECB806", 1);

  return level._id_8FA33B5EFBA196A8;
}

_id_E10AC19DB1A5E21D(player, struct) {
  lootid = player _meth_644ED519CAC9722B(1, 2).lootid;
  _id_5577636292591C8B = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(lootid);

  if(isDefined(_id_5577636292591C8B) && _id_5577636292591C8B == "weapon")
    _id_5577636292591C8B = "equipment";

  if(isDefined(_id_5577636292591C8B) && _id_5577636292591C8B == "equipment") {
    struct.loadoutequipmentprimary = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);
    struct._id_B68E3A0A9C628D23 = _func_64CCC54BDBAE5CF6(lootid);

    if(isDefined(struct._id_B68E3A0A9C628D23) && struct._id_B68E3A0A9C628D23 > 0)
      struct.loadoutequipmentprimary = _id_7EF95BBA57DC4B82::_id_F4F687E4E1EDB923(struct.loadoutequipmentprimary);
  }

  lootid = player _meth_644ED519CAC9722B(1, 3).lootid;
  _id_5577636292591C8B = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(lootid);

  if(isDefined(_id_5577636292591C8B) && _id_5577636292591C8B == "weapon")
    _id_5577636292591C8B = "equipment";

  if(isDefined(_id_5577636292591C8B) && _id_5577636292591C8B == "equipment") {
    struct.loadoutequipmentsecondary = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);
    struct._id_0A1DFC5CE15795A3 = _func_64CCC54BDBAE5CF6(lootid);

    if(isDefined(struct._id_0A1DFC5CE15795A3) && struct._id_0A1DFC5CE15795A3 > 0)
      struct.loadoutequipmentsecondary = _id_7EF95BBA57DC4B82::_id_F4F687E4E1EDB923(struct.loadoutequipmentsecondary);
  }

  lootid = player _meth_644ED519CAC9722B(1, 4).lootid;
  _id_5577636292591C8B = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(lootid);

  if(isDefined(_id_5577636292591C8B) && _id_5577636292591C8B == "super") {
    _id_EBEC497FF8B18A45 = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);

    if(isDefined(_id_EBEC497FF8B18A45) && !scripts\mp\supers::_id_907944A173ED27E1(_id_EBEC497FF8B18A45) && _id_EBEC497FF8B18A45 != "super_temp_v")
      struct.loadoutfieldupgrade1 = _id_EBEC497FF8B18A45;
  }

  _id_5864EA4E21A60CD4 = _id_EF8648922F0937B9(player);
  struct.loadoutstreaksfilled = 1;
  lootid = player _meth_644ED519CAC9722B(65535, 0).lootid;
  _id_5577636292591C8B = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(lootid);

  if(isDefined(_id_5577636292591C8B) && _id_5577636292591C8B == "killstreak")
    struct.loadoutkillstreak1 = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);
  else if(isDefined(_id_5864EA4E21A60CD4)) {
    _id_FEE734B9A173F3EC = scripts\mp\teams::_id_E0B3EFF8C73F5475(_id_5864EA4E21A60CD4);

    if(isDefined(_id_FEE734B9A173F3EC)) {
      struct.loadoutkillstreak1 = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(_id_FEE734B9A173F3EC);
      _id_AA051314F7CDAB4E(player, _id_FEE734B9A173F3EC);
    }
  }
}

_id_F19E6219C8DFB06E(player) {
  _id_787F50A063A49187(player, 11, 1, 0, player.primaryweaponobj);
  _id_787F50A063A49187(player, 11, 1, 1, player.secondaryweaponobj);
  _id_F5B2810055F85EAD(player, "primary", _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(player.loadoutequipmentprimary));
  _id_F5B2810055F85EAD(player, "secondary", _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(player.loadoutequipmentsecondary));
  scripts\mp\class::_id_CFA0343E808B7421(player, 0);
}

_id_EA56934C1996D527(player, location, _id_FB6BAFB61D5C3D4A) {
  struct = spawnStruct();
  instance = player _meth_644ED519CAC9722B(location, _id_FB6BAFB61D5C3D4A);
  _id_5577636292591C8B = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(instance.lootid);

  if(isDefined(_id_5577636292591C8B) && _id_5577636292591C8B == "weapon")
    struct._id_358E8D9068997399 = instance.lootid;
  else
    struct._id_358E8D9068997399 = 0;

  struct.weaponref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(struct._id_358E8D9068997399);
  struct._id_9DA910194DABEABE = _func_64CCC54BDBAE5CF6(struct._id_358E8D9068997399);
  struct._id_31553E68A5164E3E = [];
  struct._id_F3464D71F01F614E = [];
  struct._id_0EAE5A591E200672 = [];
  struct._id_4D3CC0262CEA20F0 = [];
  struct._id_91F46FFD5296EEE1 = "none";
  struct._id_B2EC7DAEBAAB7CAF = "none";
  struct._id_67DFD35699BA2D3E = "none";
  struct._id_3A585B7543F910C5 = [];

  if(struct._id_358E8D9068997399 == 0)
    return struct;

  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(struct.weaponref);
  _id_C7BD95B10C89CFF8 = _id_2669878CF5A1B6BC::weaponassetnamemap(_id_AB501F397D3CD312, struct._id_9DA910194DABEABE);
  _id_A49780479DE1FC05 = instance._id_6CB812578F7D9AE7;

  for(_id_80FBF4ED7B56B1DF = 0; _id_80FBF4ED7B56B1DF <= 4; _id_80FBF4ED7B56B1DF++) {
    _id_251FC0CE44D0B66D = "none";
    _id_552C315BC08BC397 = 0;
    _id_DF6D8E005B4B8020 = 0 + _id_80FBF4ED7B56B1DF;
    struct._id_F3464D71F01F614E[_id_80FBF4ED7B56B1DF] = 0;

    if(isDefined(_id_A49780479DE1FC05) && isDefined(_id_A49780479DE1FC05[_id_DF6D8E005B4B8020])) {
      _id_552C315BC08BC397 = _id_A49780479DE1FC05[_id_DF6D8E005B4B8020];
      _id_5577636292591C8B = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(_id_552C315BC08BC397);

      if(isDefined(_id_552C315BC08BC397) && _id_552C315BC08BC397 != 0 && isDefined(_id_5577636292591C8B) && _id_5577636292591C8B == "attachment") {
        _id_251FC0CE44D0B66D = _id_600B944A95C3A7BF::_id_02F80E9272A2074D(_id_552C315BC08BC397, _id_C7BD95B10C89CFF8);
        struct._id_F3464D71F01F614E[_id_80FBF4ED7B56B1DF] = scripts\mp\weapons::_id_15ABE90BE101FFC8(_id_C7BD95B10C89CFF8, _id_251FC0CE44D0B66D, _id_A49780479DE1FC05[_id_DF6D8E005B4B8020]);
      }
    }

    struct._id_31553E68A5164E3E[_id_80FBF4ED7B56B1DF] = _id_251FC0CE44D0B66D;
  }

  if(isDefined(instance._id_D3C548C09BB62DA2)) {
    for(_id_AC0E594AC96AA3A8 = 2; _id_AC0E594AC96AA3A8 <= 6; _id_AC0E594AC96AA3A8++) {
      value = _id_423648B9C03FDAA1(_id_AC0E594AC96AA3A8, instance, 1);

      if(isDefined(value) && int(value) != 0) {
        value = int(value);
        _id_456C71B4CCDD0652 = value & 255;
        _id_456C72B4CCDD0885 = value >> 8;
        struct._id_0EAE5A591E200672[_id_AC0E594AC96AA3A8 - 2] = [_func_F76FF66A6601D9C9(_id_456C71B4CCDD0652), _func_F76FF66A6601D9C9(_id_456C72B4CCDD0885)];
      }
    }

    for(_id_AC0E594AC96AA3A8 = 8; _id_AC0E594AC96AA3A8 <= 12; _id_AC0E594AC96AA3A8++) {
      value = _id_423648B9C03FDAA1(_id_AC0E594AC96AA3A8, instance, 1);

      if(isDefined(value) && int(value) != 0)
        struct._id_4D3CC0262CEA20F0[_id_AC0E594AC96AA3A8 - 8] = int(value);
    }

    value = _id_423648B9C03FDAA1(7, instance, 1);

    if(isDefined(value) && int(value) != 0)
      struct._id_EB30BDF1F971A3CD = int(value);
  }

  _id_5577636292591C8B = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(_id_A49780479DE1FC05[5]);

  if(isDefined(_id_A49780479DE1FC05) && isDefined(_id_A49780479DE1FC05[5]) && isDefined(_id_5577636292591C8B) && _id_5577636292591C8B == "camo") {
    _id_91F46FFD5296EEE1 = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(_id_A49780479DE1FC05[5]);
    _id_A3F7381340CF06D9 = _func_50F8A8F765BAD85E(_func_2EF675C13CA1C4AF("enum_1345CC24140E89B8", _id_91F46FFD5296EEE1), ["stat_89E9C01960F4C582"]);
    struct._id_91F46FFD5296EEE1 = _id_A3F7381340CF06D9.ref;
  }

  _id_5577636292591C8B = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(_id_A49780479DE1FC05[6]);

  if(isDefined(_id_A49780479DE1FC05) && isDefined(_id_A49780479DE1FC05[6] && isDefined(_id_5577636292591C8B) && _id_5577636292591C8B == "reticle"))
    struct._id_B2EC7DAEBAAB7CAF = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(_id_A49780479DE1FC05[6]);

  _id_5577636292591C8B = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(_id_A49780479DE1FC05[7]);

  if(isDefined(_id_A49780479DE1FC05) && isDefined(_id_A49780479DE1FC05[7]) && isDefined(_id_5577636292591C8B) && (_id_5577636292591C8B == "gun_screen" || _id_5577636292591C8B == "weapon_charm"))
    struct._id_67DFD35699BA2D3E = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(_id_A49780479DE1FC05[7]);

  for(_id_171380A28F103A53 = 0; _id_171380A28F103A53 <= 4; _id_171380A28F103A53++) {
    _id_3372B69CF77360ED = "none";
    _id_36D2ABBDCBCB186C = _id_171380A28F103A53 + 8;
    _id_5577636292591C8B = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(_id_A49780479DE1FC05[_id_36D2ABBDCBCB186C]);

    if(isDefined(_id_A49780479DE1FC05) && isDefined(_id_A49780479DE1FC05[_id_36D2ABBDCBCB186C]) && isDefined(_id_5577636292591C8B) && _id_5577636292591C8B == "sticker") {
      lootid = _id_A49780479DE1FC05[_id_36D2ABBDCBCB186C];

      if(isDefined(lootid) && lootid != 0)
        _id_3372B69CF77360ED = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);
    }

    struct._id_3A585B7543F910C5[_id_171380A28F103A53] = _id_3372B69CF77360ED;
  }

  return struct;
}

_id_7DFE7EA5FFD28AD4(player, weaponslot) {
  _id_FB6BAFB61D5C3D4A = _id_4AD0394E9AD7176D(weaponslot);
  return _id_EA56934C1996D527(player, 1, _id_FB6BAFB61D5C3D4A);
}

_id_DC67872CC4CFAE72(player, location, _id_FB6BAFB61D5C3D4A) {
  instance = player _meth_644ED519CAC9722B(location, _id_FB6BAFB61D5C3D4A);

  if(instance._id_FB5FDFAFC29F4513 != "0")
    player _meth_DD5661EBE3C9A5A2(instance._id_FB5FDFAFC29F4513);
}

_id_4AD0394E9AD7176D(weaponslot) {
  return scripts\engine\utility::ter_op(weaponslot == 0, 0, 1);
}

_id_540C2B6342F4E28C(player, slot) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  if(slot == 2)
    return player _meth_644ED519CAC9722B(2, 0);
  else {
    _id_89DC405A017D19CA = _id_4AD0394E9AD7176D(slot);
    return player _meth_644ED519CAC9722B(1, _id_89DC405A017D19CA);
  }
}

_id_1F83D85290C29BEF(player, weaponslot) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  _id_FB6BAFB61D5C3D4A = _id_4AD0394E9AD7176D(weaponslot);
  _id_6E079390DF583EB4 = player _meth_644ED519CAC9722B(1, _id_FB6BAFB61D5C3D4A);
  player _meth_DA187BCAE911D661(_id_6E079390DF583EB4._id_FB5FDFAFC29F4513, 2, 0);
}

_id_9FEE9BD8EFD81655(player, weaponobj, _id_F51BBB191526DFA4, _id_4E479E14D0837E84) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  if(istrue(_id_F51BBB191526DFA4))
    _id_DC67872CC4CFAE72(player, 2, 0);

  _id_787F50A063A49187(player, 11, 2, 0, weaponobj);
  _id_A839B9AD5740477D(player, 2, 0);

  if(isDefined(_id_4E479E14D0837E84)) {
    instance = player _meth_644ED519CAC9722B(2, 0);
    _id_11CC6F33CB91B3F1 = _id_FE92418620D93763(_id_4E479E14D0837E84[0]);
    _id_D3C548C09BB62DA2 = _id_FE92418620D93763(_id_4E479E14D0837E84[1]);
    _id_CD81C0E152649846(player, instance, _id_11CC6F33CB91B3F1, _id_D3C548C09BB62DA2);
  }
}

_id_FE92418620D93763(_id_4E479E14D0837E84) {
  _id_60D63C99A7A31E59 = [];

  if(isDefined(_id_4E479E14D0837E84)) {
    foreach(data in _id_4E479E14D0837E84) {
      _id_A0D21FDD38F60ECF = _id_60D63C99A7A31E59.size;
      _id_60D63C99A7A31E59[_id_A0D21FDD38F60ECF] = [];
      _id_60D63C99A7A31E59[_id_A0D21FDD38F60ECF][0] = data.key;
      _id_60D63C99A7A31E59[_id_A0D21FDD38F60ECF][1] = int(data.value);
    }
  }

  return _id_60D63C99A7A31E59;
}

_id_BF2FA755E8269CA8(keys, values, instance, _id_D3C548C09BB62DA2) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  if(!isDefined(keys) || !isDefined(values) || !isDefined(instance))
    return undefined;

  if(!isarray(keys))
    keys = [keys];

  if(!isarray(values))
    values = [values];

  if(keys.size != values.size) {}

  _id_C630485049DEA721 = [];
  _id_0A7EFDAACBD89567 = instance._id_4E479E14D0837E84;

  if(istrue(_id_D3C548C09BB62DA2))
    _id_0A7EFDAACBD89567 = instance._id_D3C548C09BB62DA2;

  _id_11E7B05668D732B9 = 0;

  if(istrue(_id_D3C548C09BB62DA2))
    _id_11E7B05668D732B9 = 0;

  foreach(index, key in keys) {
    _id_946361B3EC392AC3 = undefined;

    foreach(_id_333DD8CDF98DFA17, data in _id_0A7EFDAACBD89567) {
      if(data.key == key) {
        _id_A0D21FDD38F60ECF = _id_C630485049DEA721.size;
        _id_C630485049DEA721[_id_A0D21FDD38F60ECF] = [];
        _id_C630485049DEA721[_id_A0D21FDD38F60ECF][0] = key;
        _id_C630485049DEA721[_id_A0D21FDD38F60ECF][1] = values[index];
        _id_946361B3EC392AC3 = undefined;
        break;
      } else if(data.key == _id_11E7B05668D732B9)
        _id_946361B3EC392AC3 = _id_333DD8CDF98DFA17;
    }

    if(isDefined(_id_946361B3EC392AC3)) {
      _id_0A7EFDAACBD89567[_id_946361B3EC392AC3].key = key;
      _id_0A7EFDAACBD89567[_id_946361B3EC392AC3].value = values[index];
      _id_A0D21FDD38F60ECF = _id_C630485049DEA721.size;
      _id_C630485049DEA721[_id_A0D21FDD38F60ECF] = [];
      _id_C630485049DEA721[_id_A0D21FDD38F60ECF][0] = key;
      _id_C630485049DEA721[_id_A0D21FDD38F60ECF][1] = values[index];
    }
  }

  return _id_C630485049DEA721;
}

_id_A839B9AD5740477D(player, location, _id_FB6BAFB61D5C3D4A, _id_223785486725CD51) {
  _id_558774275543A708 = _id_EA56934C1996D527(player, location, _id_FB6BAFB61D5C3D4A);
  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(_id_558774275543A708.weaponref);
  player setplayerdata(level._id_5D69837CF4DB0407, "dmzWeapon", "weapon", _id_AB501F397D3CD312);
  player setplayerdata(level._id_5D69837CF4DB0407, "dmzWeapon", "variantID", _id_558774275543A708._id_9DA910194DABEABE);
  player setplayerdata(level._id_5D69837CF4DB0407, "dmzWeapon", "lootItemID", _id_558774275543A708._id_358E8D9068997399);
  _id_428A6C7CD65625C0 = 0;

  if(isDefined(_id_558774275543A708._id_31553E68A5164E3E)) {
    for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < _id_558774275543A708._id_31553E68A5164E3E.size; _id_DF6D8E005B4B8020++) {
      player setplayerdata(level._id_5D69837CF4DB0407, "dmzWeapon", "attachmentSetup", _id_428A6C7CD65625C0, "attachment", _id_558774275543A708._id_31553E68A5164E3E[_id_DF6D8E005B4B8020]);
      player setplayerdata(level._id_5D69837CF4DB0407, "dmzWeapon", "attachmentSetup", _id_428A6C7CD65625C0, "variantID", _id_558774275543A708._id_F3464D71F01F614E[_id_DF6D8E005B4B8020]);

      if(isDefined(_id_558774275543A708._id_0EAE5A591E200672) && isDefined(_id_558774275543A708._id_0EAE5A591E200672[_id_DF6D8E005B4B8020])) {
        player setplayerdata(level._id_5D69837CF4DB0407, "dmzWeapon", "attachmentSetup", _id_428A6C7CD65625C0, "customTune", 0, _func_ F3C863DD3265167(_id_558774275543A708._id_0EAE5A591E200672[_id_DF6D8E005B4B8020][0]));
        player setplayerdata(level._id_5D69837CF4DB0407, "dmzWeapon", "attachmentSetup", _id_428A6C7CD65625C0, "customTune", 1, _func_ F3C863DD3265167(_id_558774275543A708._id_0EAE5A591E200672[_id_DF6D8E005B4B8020][1]));
      }

      _id_428A6C7CD65625C0++;
    }
  }

  if(isDefined(_id_558774275543A708._id_91F46FFD5296EEE1))
    player setplayerdata(level._id_5D69837CF4DB0407, "dmzWeapon", "camo", _id_558774275543A708._id_91F46FFD5296EEE1);

  if(isDefined(_id_558774275543A708._id_B2EC7DAEBAAB7CAF))
    player setplayerdata(level._id_5D69837CF4DB0407, "dmzWeapon", "reticle", _id_558774275543A708._id_B2EC7DAEBAAB7CAF);

  if(isDefined(_id_558774275543A708._id_67DFD35699BA2D3E))
    player setplayerdata(level._id_5D69837CF4DB0407, "dmzWeapon", "cosmeticAttachment", _id_558774275543A708._id_67DFD35699BA2D3E);

  if(isDefined(_id_558774275543A708._id_3A585B7543F910C5)) {
    for(_id_36D2ABBDCBCB186C = 0; _id_36D2ABBDCBCB186C < _id_558774275543A708._id_3A585B7543F910C5.size; _id_36D2ABBDCBCB186C++) {
      if(isDefined(_id_558774275543A708._id_3A585B7543F910C5[_id_36D2ABBDCBCB186C]))
        player setplayerdata(level._id_5D69837CF4DB0407, "dmzWeapon", "sticker", _id_36D2ABBDCBCB186C, _id_558774275543A708._id_3A585B7543F910C5[_id_36D2ABBDCBCB186C]);
    }
  }

  _id_2D9D24F7C63AC143::_id_3E89085D4A19A802(player);

  if(!istrue(_id_223785486725CD51))
    _id_2D9D24F7C63AC143::_id_5BAAA0CE73D6FE84(player);
}

_id_F910B139E75FD559(player) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  _id_6267A5AD12C5E4D4 = player _meth_644ED519CAC9722B(2, 0);
  player _meth_DD5661EBE3C9A5A2(_id_6267A5AD12C5E4D4._id_FB5FDFAFC29F4513);
}

_id_5D94B2DFABBC4CCE(player, weaponobj, weaponslot, _id_F51BBB191526DFA4, _id_4E479E14D0837E84) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  _id_FB6BAFB61D5C3D4A = _id_4AD0394E9AD7176D(weaponslot);

  if(istrue(_id_F51BBB191526DFA4))
    _id_DC67872CC4CFAE72(player, 1, _id_FB6BAFB61D5C3D4A);

  _id_787F50A063A49187(player, 11, 1, _id_FB6BAFB61D5C3D4A, weaponobj);

  if(isDefined(_id_4E479E14D0837E84)) {
    instance = player _meth_644ED519CAC9722B(1, _id_FB6BAFB61D5C3D4A);
    _id_11CC6F33CB91B3F1 = _id_FE92418620D93763(_id_4E479E14D0837E84[0]);
    _id_D3C548C09BB62DA2 = _id_FE92418620D93763(_id_4E479E14D0837E84[1]);
    _id_CD81C0E152649846(player, instance, _id_11CC6F33CB91B3F1, _id_D3C548C09BB62DA2);
  }
}

_id_787F50A063A49187(player, _id_207098E76BCAC40F, location, _id_FB6BAFB61D5C3D4A, weaponobj) {
  variantid = weaponobj.variantid;

  if(!isDefined(weaponobj.variantid))
    variantid = 0;

  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(weaponobj);
  lootid = _id_2669878CF5A1B6BC::_id_79D6E6C22245687A(_id_AB501F397D3CD312, variantid);
  _id_DF6D8E005B4B8020 = 0;
  _id_282ED072C12D4D4D = [];

  for(_id_E26E310B5F042288 = 0; _id_E26E310B5F042288 <= 12; _id_E26E310B5F042288++)
    _id_282ED072C12D4D4D[_id_E26E310B5F042288] = 0;

  if(isDefined(weaponobj.attachments)) {
    foreach(attachment in weaponobj.attachments) {
      if(_id_2669878CF5A1B6BC::attachmentiscosmetic(attachment)) {
        _id_282ED072C12D4D4D[7] = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(attachment);
        continue;
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "attachmentIsSelectable")) {
        if([[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "attachmentIsSelectable")]](weaponobj, attachment)) {
          attachmentref = attachment;

          if(isDefined(weaponobj.attachmentvarindices) && isDefined(weaponobj.attachmentvarindices[attachment])) {
            _id_4F13B964AB82FE13 = scripts\mp\weapons::_id_1C6803F36C2EA0A6(weaponobj.basename, attachment, weaponobj.attachmentvarindices[attachment]);

            if(!isDefined(_id_4F13B964AB82FE13))
              _id_4F13B964AB82FE13 = _id_2669878CF5A1B6BC::_id_693E108CB61CEEB5(_id_AB501F397D3CD312, attachment);

            _id_282ED072C12D4D4D[_id_DF6D8E005B4B8020] = _id_4F13B964AB82FE13;
          } else
            _id_282ED072C12D4D4D[_id_DF6D8E005B4B8020] = _id_2669878CF5A1B6BC::_id_693E108CB61CEEB5(_id_AB501F397D3CD312, attachment);

          _id_DF6D8E005B4B8020 = _id_DF6D8E005B4B8020 + 1;
        }
      }
    }
  }

  if(isDefined(weaponobj.camo))
    _id_282ED072C12D4D4D[5] = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(weaponobj.camo);

  if(isDefined(weaponobj.reticle))
    _id_282ED072C12D4D4D[6] = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(weaponobj._id_58093338294DCB11);

  if(isDefined(weaponobj.stickerslot0) && weaponobj.stickerslot0 != "none")
    _id_282ED072C12D4D4D[8] = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(weaponobj.stickerslot0);

  if(isDefined(weaponobj.stickerslot1) && weaponobj.stickerslot1 != "none")
    _id_282ED072C12D4D4D[9] = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(weaponobj.stickerslot1);

  if(isDefined(weaponobj.stickerslot2) && weaponobj.stickerslot2 != "none")
    _id_282ED072C12D4D4D[10] = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(weaponobj.stickerslot2);

  if(isDefined(weaponobj.stickerslot3) && weaponobj.stickerslot3 != "none")
    _id_282ED072C12D4D4D[11] = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(weaponobj.stickerslot3);

  if(isDefined(weaponobj._id_B39AC546CC8621F8) && weaponobj._id_B39AC546CC8621F8 != "none")
    _id_282ED072C12D4D4D[12] = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(weaponobj._id_B39AC546CC8621F8);

  player _meth_4F1027E74D5073C4(lootid, _id_207098E76BCAC40F, location, _id_FB6BAFB61D5C3D4A, _id_282ED072C12D4D4D);
}

_id_E5845FF9B61AC5D7(player, weaponobj, _id_0EC22A950F210E39, _id_BAC000ABFE10D487, _id_9539CCECBBDEBC31, _id_4E479E14D0837E84) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  weaponslot = undefined;
  primaryweapon = _id_7E52B56769FA7774::_id_13ECF3644442A3E7(player, 0);
  secondaryweapon = _id_7E52B56769FA7774::_id_13ECF3644442A3E7(player, 1);

  if(isDefined(primaryweapon) && primaryweapon == weaponobj)
    weaponslot = 0;
  else if(isDefined(secondaryweapon) && secondaryweapon == weaponobj)
    weaponslot = 1;
  else
    weaponslot = 0;

  if(isDefined(_id_0EC22A950F210E39)) {
    _id_6E079390DF583EB4 = player _meth_644ED519CAC9722B(1, weaponslot);

    if(istrue(_id_BAC000ABFE10D487) && istrue(_id_9539CCECBBDEBC31)) {
      _id_6267A5AD12C5E4D4 = player _meth_644ED519CAC9722B(2, 0);
      _id_87D6A0C83604FBEA(player, _id_6E079390DF583EB4, _id_6267A5AD12C5E4D4, 1, 2, weaponslot, 0);
      return;
    } else if(istrue(_id_BAC000ABFE10D487))
      player _meth_DA187BCAE911D661(_id_6E079390DF583EB4._id_FB5FDFAFC29F4513, 2, 0);
    else
      player _meth_DD5661EBE3C9A5A2(_id_6E079390DF583EB4._id_FB5FDFAFC29F4513);
  }

  if(istrue(_id_9539CCECBBDEBC31)) {
    _id_6267A5AD12C5E4D4 = player _meth_644ED519CAC9722B(2, 0);
    player _meth_DA187BCAE911D661(_id_6267A5AD12C5E4D4._id_FB5FDFAFC29F4513, 1, weaponslot);
  } else {
    _id_787F50A063A49187(player, 11, 1, weaponslot, weaponobj);

    if(isDefined(_id_4E479E14D0837E84)) {
      instance = player _meth_644ED519CAC9722B(1, weaponslot);
      _id_11CC6F33CB91B3F1 = _id_FE92418620D93763(_id_4E479E14D0837E84[0]);
      _id_D3C548C09BB62DA2 = _id_FE92418620D93763(_id_4E479E14D0837E84[1]);
      _id_CD81C0E152649846(player, instance, _id_11CC6F33CB91B3F1, _id_D3C548C09BB62DA2);
    }
  }
}

_id_22C2D36F9A723C2F(player, index, _id_6208DB3305D9CB5B) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  _id_65B695F0C0D909ED = 1 + index;
  _id_AA074BF91D082A74 = player _meth_644ED519CAC9722B(1, _id_6208DB3305D9CB5B);
  player _meth_DA187BCAE911D661(_id_AA074BF91D082A74._id_FB5FDFAFC29F4513, 2, _id_65B695F0C0D909ED);
}

_id_D368B112DC94BAAE(player, index, _id_72AD120EAAC64650, _id_6208DB3305D9CB5B) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  _id_65B695F0C0D909ED = 1 + index;
  _id_5DD11D67A8FFE194 = player _meth_644ED519CAC9722B(2, _id_65B695F0C0D909ED);
  _id_AA074BF91D082A74 = player _meth_644ED519CAC9722B(_id_72AD120EAAC64650, _id_6208DB3305D9CB5B);
  _id_87D6A0C83604FBEA(player, _id_5DD11D67A8FFE194, _id_AA074BF91D082A74, 2, _id_72AD120EAAC64650, _id_65B695F0C0D909ED, _id_6208DB3305D9CB5B);
}

_id_0E8A616866B41197(player, index, _id_6208DB3305D9CB5B) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  _id_65B695F0C0D909ED = 1 + index;
  _id_5DD11D67A8FFE194 = player _meth_644ED519CAC9722B(2, _id_65B695F0C0D909ED);
  player _meth_DA187BCAE911D661(_id_5DD11D67A8FFE194._id_FB5FDFAFC29F4513, 1, _id_6208DB3305D9CB5B);
}

_id_0233512489717381(player, index, lootid) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  _id_65B695F0C0D909ED = 1 + index;
  _id_207098E76BCAC40F = 13;
  _id_2F44E3B98C77C7CC = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

  if(_id_7E52B56769FA7774::_id_82D45592D750D388(_id_2F44E3B98C77C7CC) || _id_7E52B56769FA7774::_id_A38E261031751C09(_id_2F44E3B98C77C7CC))
    _id_207098E76BCAC40F = 15;

  player _meth_4F1027E74D5073C4(lootid, _id_207098E76BCAC40F, 2, _id_65B695F0C0D909ED, []);
}

_id_F5B2810055F85EAD(player, slot, lootid) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  _id_89DC405A017D19CA = _id_F1C7356A808E9BD9(slot);

  if(!isDefined(_id_89DC405A017D19CA)) {
    return;
  }
  if(lootid == 0) {
    return;
  }
  player _meth_4F1027E74D5073C4(lootid, 13, 1, _id_89DC405A017D19CA, []);
}

_id_AA051314F7CDAB4E(player, lootid) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  player _meth_4F1027E74D5073C4(lootid, 13, 65535, 0, []);
}

_id_92D947129EA5BA6E(player, lootid) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  player _meth_4F1027E74D5073C4(lootid, 13, 65535, 1, []);
}

_id_C0AE57D4DC3A8EEF(player, lootid) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  player _meth_4F1027E74D5073C4(lootid, 13, 65535, 3, []);
}

_id_826C883F14E827B3(player, lootid) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  player _meth_4F1027E74D5073C4(lootid, 13, 65535, 4, []);
}

_id_0BD01C77AB46F790(player, lootid) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  player _meth_4F1027E74D5073C4(lootid, 13, 65535, 2, []);
}

_id_EF8648922F0937B9(player) {
  if(!_id_E0FC1230452CF4E7())
    return undefined;

  _id_2B33B070C1F877E6 = player _meth_644ED519CAC9722B(65535, 6);

  if(isDefined(_id_2B33B070C1F877E6) && _id_2B33B070C1F877E6._id_FB5FDFAFC29F4513 != "0") {
    if(isDefined(_id_2B33B070C1F877E6._id_6CB812578F7D9AE7) && isDefined(_id_2B33B070C1F877E6._id_6CB812578F7D9AE7[0])) {
      skinref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(_id_2B33B070C1F877E6._id_6CB812578F7D9AE7[0]);

      if(isDefined(skinref))
        return scripts\mp\teams::_id_BE562399EFB845E4(skinref);
    }
  }
}

_id_28F402FA85068F06(player) {
  if(!_id_E0FC1230452CF4E7())
    return undefined;

  _id_2B33B070C1F877E6 = player _meth_644ED519CAC9722B(65535, 6);

  if(isDefined(_id_2B33B070C1F877E6) && _id_2B33B070C1F877E6._id_FB5FDFAFC29F4513 != "0") {
    if(isDefined(_id_2B33B070C1F877E6._id_6CB812578F7D9AE7) && isDefined(_id_2B33B070C1F877E6._id_6CB812578F7D9AE7[1])) {
      executionref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(_id_2B33B070C1F877E6._id_6CB812578F7D9AE7[1]);

      if(isDefined(executionref))
        return scripts\mp\teams::_id_B6B7981D7ED1B94F(executionref);
    }
  }
}

_id_80A3ED28ED1B33A1(player, _id_153FDEE861E0F06F, _id_D933A3A8C547998E) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  _id_573D6CFC9F758DCC = player _meth_644ED519CAC9722B(65535, 5);
  _id_282ED072C12D4D4D = [];
  _id_48B8A0D00D96E904 = 0;

  if(isDefined(_id_573D6CFC9F758DCC) && _id_573D6CFC9F758DCC._id_FB5FDFAFC29F4513 != "0") {
    if(isDefined(_id_573D6CFC9F758DCC._id_6CB812578F7D9AE7)) {
      _id_282ED072C12D4D4D = _id_573D6CFC9F758DCC._id_6CB812578F7D9AE7;

      for(_id_2B8554E15B5C8E77 = 0; _id_2B8554E15B5C8E77 <= 9; _id_2B8554E15B5C8E77++) {
        if(_id_282ED072C12D4D4D[_id_2B8554E15B5C8E77] != 0)
          _id_48B8A0D00D96E904++;
      }
    }
  }

  if(isDefined(_id_D933A3A8C547998E)) {
    _id_287813C50EC317AB = int(min(_id_48B8A0D00D96E904, 9));
    _id_282ED072C12D4D4D[_id_287813C50EC317AB] = _id_D933A3A8C547998E;
  }

  _id_7BC70FC1DD299F89(player);
  player _meth_4F1027E74D5073C4(_id_600B944A95C3A7BF::_id_A50B607D2500DDA5("dmz_exfil_streak"), 15, 65535, 5, _id_282ED072C12D4D4D);
  _id_573D6CFC9F758DCC = player _meth_644ED519CAC9722B(65535, 5);
  _id_5170A7C15B09F348 = _id_BF2FA755E8269CA8([2], [_id_153FDEE861E0F06F], _id_573D6CFC9F758DCC);
  _id_CD81C0E152649846(player, _id_573D6CFC9F758DCC, _id_5170A7C15B09F348);
}

_id_7BC70FC1DD299F89(player) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  _id_DC67872CC4CFAE72(player, 65535, 5);
}

_id_1558F8FB859C492A(player) {
  if(!_id_E0FC1230452CF4E7())
    return [0, []];

  _id_573D6CFC9F758DCC = player _meth_644ED519CAC9722B(65535, 5);

  if(isDefined(_id_573D6CFC9F758DCC) && _id_573D6CFC9F758DCC._id_FB5FDFAFC29F4513 != "0") {
    if(isDefined(_id_573D6CFC9F758DCC._id_6CB812578F7D9AE7) && isDefined(_id_573D6CFC9F758DCC._id_4E479E14D0837E84)) {
      _id_153FDEE861E0F06F = _id_423648B9C03FDAA1(2, _id_573D6CFC9F758DCC);

      if(!isDefined(_id_153FDEE861E0F06F))
        _id_153FDEE861E0F06F = 0;

      return [int(_id_153FDEE861E0F06F), _id_573D6CFC9F758DCC._id_6CB812578F7D9AE7];
    }
  }

  return [0, []];
}

_id_52384260FE709F19(player, index) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  index = index + 1;
  _id_DC67872CC4CFAE72(player, 2, index);
}

_id_BFEDEB20F8B77F3F(player, slot, _id_4850537BC9BF2170) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  if(istrue(_id_4850537BC9BF2170) && !_id_6484CE4430C9439B(player, slot)) {
    return;
  }
  if(slot == 2)
    _id_DC67872CC4CFAE72(player, 2, 0);
  else {
    _id_89DC405A017D19CA = _id_4AD0394E9AD7176D(slot);
    _id_DC67872CC4CFAE72(player, 1, _id_89DC405A017D19CA);
  }
}

_id_351FE4AC57CA37E5(player, slot) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  _id_89DC405A017D19CA = _id_F1C7356A808E9BD9(slot);

  if(!isDefined(_id_89DC405A017D19CA)) {
    return;
  }
  _id_DC67872CC4CFAE72(player, 1, _id_89DC405A017D19CA);
}

_id_28550536EBAFE216(player) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  _id_DC67872CC4CFAE72(player, 65535, 0);
}

_id_777C89585478357B(player) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  _id_DC67872CC4CFAE72(player, 65535, 4);
}

_id_0A60428CDA4724A7(player) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  _id_DC67872CC4CFAE72(player, 65535, 3);
}

_id_5B7DC44BB66553A6(player) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  _id_DC67872CC4CFAE72(player, 65535, 1);
}

_id_EA96B27797C7E268(player) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  _id_DC67872CC4CFAE72(player, 65535, 2);
}

_id_87D6A0C83604FBEA(player, _id_7E55BD82D026534D, _id_7E55BA82D0264CB4, _id_0FCF7E6E6D8C4861, _id_0FCF7B6E6D8C41C8, _id_4A10E88291DB3581, _id_4A10E58291DB2EE8) {
  player _meth_DA187BCAE911D661(_id_7E55BD82D026534D._id_FB5FDFAFC29F4513, 2, 13);
  player _meth_DA187BCAE911D661(_id_7E55BA82D0264CB4._id_FB5FDFAFC29F4513, _id_0FCF7E6E6D8C4861, _id_4A10E88291DB3581);
  player _meth_DA187BCAE911D661(_id_7E55BD82D026534D._id_FB5FDFAFC29F4513, _id_0FCF7B6E6D8C41C8, _id_4A10E58291DB2EE8);
}

_id_AB1505092D4E2A8C(player, _id_87F0698DC7AC0A09, location, _id_FB6BAFB61D5C3D4A, _id_760480DC8B6F2623) {
  _id_08488A6AF29DE20A = player _meth_644ED519CAC9722B(location, _id_FB6BAFB61D5C3D4A);

  if(_id_08488A6AF29DE20A._id_FB5FDFAFC29F4513 != "0" && _id_08488A6AF29DE20A.lootid != 0 && _id_08488A6AF29DE20A._id_207098E76BCAC40F != 11) {
    _id_85166DA84E55DE25 = _id_423648B9C03FDAA1(15, _id_08488A6AF29DE20A, 1);

    if(_id_3A8D97D9E7D9E535(player, _id_08488A6AF29DE20A) > getsystemtime())
      player _meth_DD5661EBE3C9A5A2(_id_08488A6AF29DE20A._id_FB5FDFAFC29F4513);
    else if(istrue(_id_760480DC8B6F2623[_id_85166DA84E55DE25]))
      player _meth_DD5661EBE3C9A5A2(_id_08488A6AF29DE20A._id_FB5FDFAFC29F4513);
    else {
      _id_760480DC8B6F2623[_id_85166DA84E55DE25] = 1;
      _id_5170A7C15B09F348 = _id_BF2FA755E8269CA8([1], [_id_87F0698DC7AC0A09], _id_08488A6AF29DE20A);

      if(isDefined(_id_5170A7C15B09F348))
        _id_CD81C0E152649846(player, _id_08488A6AF29DE20A, _id_5170A7C15B09F348);

      _id_08488A6AF29DE20A = player _meth_644ED519CAC9722B(location, _id_FB6BAFB61D5C3D4A);
      player._id_B1BF418AA7242C1D[player._id_B1BF418AA7242C1D.size] = _id_08488A6AF29DE20A;
      return _id_760480DC8B6F2623;
    }
  }

  return _id_760480DC8B6F2623;
}

_id_8D65122EA2E88ECD(player) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  if(isDefined(player._id_B1BF418AA7242C1D)) {
    return;
  }
  player._id_B1BF418AA7242C1D = [];
  _id_87F0698DC7AC0A09 = _id_A3D464413E73F057(player);
  _id_760480DC8B6F2623 = [];
  _id_760480DC8B6F2623 = _id_AB1505092D4E2A8C(player, _id_87F0698DC7AC0A09, 2, 0, _id_760480DC8B6F2623);
  _id_760480DC8B6F2623 = _id_AB1505092D4E2A8C(player, _id_87F0698DC7AC0A09, 1, 0, _id_760480DC8B6F2623);
  _id_760480DC8B6F2623 = _id_AB1505092D4E2A8C(player, _id_87F0698DC7AC0A09, 1, 1, _id_760480DC8B6F2623);
}

_id_DB31AF9BFC65EA51(player) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  player._id_81D789409ADA6941 = [];
  _id_B2721CF177F915E4 = player _meth_644ED519CAC9722B(1, 2);

  if(_id_B2721CF177F915E4._id_FB5FDFAFC29F4513 != "0" && _id_B2721CF177F915E4.lootid != 0)
    player._id_81D789409ADA6941[2] = _id_B2721CF177F915E4.lootid;

  _id_2230DE25F8635C83 = player _meth_644ED519CAC9722B(1, 3);

  if(_id_2230DE25F8635C83._id_FB5FDFAFC29F4513 != "0" && _id_2230DE25F8635C83.lootid != 0)
    player._id_81D789409ADA6941[3] = _id_2230DE25F8635C83.lootid;

  _id_BED94C5E8BA6C57E = player _meth_644ED519CAC9722B(1, 4);

  if(_id_BED94C5E8BA6C57E._id_FB5FDFAFC29F4513 != "0" && _id_BED94C5E8BA6C57E.lootid != 0)
    player._id_81D789409ADA6941[4] = _id_BED94C5E8BA6C57E.lootid;
}

_id_33366ADE5697AA38(player) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  _id_A839B9AD5740477D(player, 2, 0);

  for(_id_65B695F0C0D909ED = 0; _id_65B695F0C0D909ED < 11; _id_65B695F0C0D909ED++) {
    _id_65D040B6FA76F410 = player _meth_644ED519CAC9722B(2, 1 + _id_65B695F0C0D909ED);
    lootid = _id_65D040B6FA76F410.lootid;
    quantity = _id_423648B9C03FDAA1(3, _id_65D040B6FA76F410, 0);
    quantity = int(scripts\engine\utility::_id_53C4C53197386572(quantity, 1));
    player setplayerdata(level._id_5D69837CF4DB0407, "dmzBackpack", _id_65B695F0C0D909ED, "lootID", lootid);
    player setplayerdata(level._id_5D69837CF4DB0407, "dmzBackpack", _id_65B695F0C0D909ED, "quantity", quantity);
    player _id_6FC415FF6A905DC1::_id_BAC731E0FDAA0CCB(lootid);
  }

  for(_id_65B695F0C0D909ED = 0; _id_65B695F0C0D909ED < 11; _id_65B695F0C0D909ED++) {
    lootid = player _id_2D9D24F7C63AC143::_id_6196D9EA9A30E609(_id_65B695F0C0D909ED);
    quantity = player _id_2D9D24F7C63AC143::_id_897B29ADB37F06A7(_id_65B695F0C0D909ED);
    ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);
  }
}

_id_F1C7356A808E9BD9(_id_CBB2B3D05E48BD27) {
  switch (_id_CBB2B3D05E48BD27) {
    case "primary":
      return 2;
    case "secondary":
      return 3;
    case "super":
      return 4;
    case "health":
    default:
      return undefined;
  }
}

_id_56EC0560843AA9A4(player) {
  _id_A0E4ABF938DBE26B = player _meth_644ED519CAC9722B(1, 5);

  if(istrue(_id_59352C09A417A5E2(player, 28)) && isDefined(_id_A0E4ABF938DBE26B) && _id_A0E4ABF938DBE26B._id_FB5FDFAFC29F4513 != "0")
    return _id_A0E4ABF938DBE26B.quantity;
  else
    return _id_1D6D967DBF6DFA05(player);
}

_id_416AB73109B71D69(player) {
  _id_A0E4ABF938DBE26B = player _meth_644ED519CAC9722B(1, 5);

  if(istrue(_id_59352C09A417A5E2(player, 28)) && isDefined(_id_A0E4ABF938DBE26B) && _id_A0E4ABF938DBE26B._id_FB5FDFAFC29F4513 != "0")
    return _id_A0E4ABF938DBE26B.quantity;
  else
    return 0;
}

_id_B9E5B13D100AA0F5(player, quantity) {
  _id_A0E4ABF938DBE26B = player _meth_644ED519CAC9722B(1, 5);

  if(istrue(_id_59352C09A417A5E2(player, 28)) && isDefined(_id_A0E4ABF938DBE26B) && _id_A0E4ABF938DBE26B._id_FB5FDFAFC29F4513 != "0")
    player _meth_77EFF0A02C92C9B7(_id_A0E4ABF938DBE26B._id_FB5FDFAFC29F4513, quantity);
}

_id_695FDEAB4DB350B4(player) {
  _id_8A9D33941712CF66 = 0;

  if(istrue(_id_59352C09A417A5E2(player, 28))) {
    _id_8A9D33941712CF66 = 10000;
    _id_004DEB41B14261B5 = int(min(_id_07E5492B68492F80(player, 15), 18));

    if(isDefined(_id_004DEB41B14261B5))
      _id_8A9D33941712CF66 = _id_8A9D33941712CF66 + _id_004DEB41B14261B5 * 5000;
  }

  return _id_8A9D33941712CF66;
}

_id_3B61A01133ED91B0(player) {
  if(!istrue(_id_59352C09A417A5E2(player, 28))) {
    return;
  }
  plundercount = 0;

  if(isDefined(player.plundercount) && player.plundercount > 0)
    plundercount = player.plundercount;

  _id_8A9D33941712CF66 = _id_695FDEAB4DB350B4(player);
  _id_CF9F108239129DC2 = player _meth_7AEE6670DA372309();
  _id_C899829BBFE3B823 = _id_8A9D33941712CF66 - _id_CF9F108239129DC2;

  if(_id_C899829BBFE3B823 > 0) {
    _id_FFC09FBC7F1BBBC5 = 0;

    if(_id_C899829BBFE3B823 >= plundercount)
      _id_FFC09FBC7F1BBBC5 = plundercount;
    else
      _id_FFC09FBC7F1BBBC5 = _id_C899829BBFE3B823;

    player _meth_A653645C73C1F9F8(_id_FFC09FBC7F1BBBC5);
    plundercount = plundercount - _id_FFC09FBC7F1BBBC5;
  }

  _id_B9E5B13D100AA0F5(player, plundercount);
}

_id_7D760EDC2A7E9B8F(player) {
  _id_8A9D33941712CF66 = _id_695FDEAB4DB350B4(player);
  _id_CF9F108239129DC2 = player _meth_7AEE6670DA372309();

  if(_id_CF9F108239129DC2 > _id_8A9D33941712CF66)
    player _meth_2FB23B36F31441C5(_id_8A9D33941712CF66);

  _id_80D194BFF78511DB = _id_416AB73109B71D69(player);

  if(_id_80D194BFF78511DB > 25000)
    _id_B9E5B13D100AA0F5(player, 25000);
}

_id_2AB8227B96AB5D5F(player) {
  plundercount = 0;

  if(isDefined(player.plundercount) && player.plundercount > 0)
    plundercount = player.plundercount;

  if(istrue(_id_59352C09A417A5E2(player, 28)))
    _id_B9E5B13D100AA0F5(player, plundercount);
  else
    player setplayerdata(level._id_5D69837CF4DB0407, "dmzPocketCash", plundercount);
}

_id_CD234CDD6B1B3699(player) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  _id_1341F0AE49D492CD(player, 1);
  _id_1D553B4E5DF1CB3E(player);
}

_id_EA65E35C77F7679B(player) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  _id_623484AC7E5934A9 = [];
  player.pers["telemetry"]._id_7E78E00462492360 = [];
  _id_F41D7258200E1D08 = _id_2D9D24F7C63AC143::_id_C4F1BD7A01A307FA(player);
  _id_95C7C9334EA70BD8 = scripts\mp\utility\teams::getteamdata(player.team, "extractedStashItems");

  for(_id_65B695F0C0D909ED = 0; _id_65B695F0C0D909ED < 11; _id_65B695F0C0D909ED++) {
    _id_65D040B6FA76F410 = player _meth_644ED519CAC9722B(2, 1 + _id_65B695F0C0D909ED);

    if(_id_65D040B6FA76F410.lootid == 35070)
      level._id_796BCFECDCC6BDF8._id_1AE013F9F46FF5F4++;

    if(_id_65D040B6FA76F410._id_FB5FDFAFC29F4513 != "0") {
      _id_25978461C6E4F61B = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(_id_65D040B6FA76F410.lootid);

      if(isDefined(_id_25978461C6E4F61B)) {
        _id_A38E261031751C09 = _id_7E52B56769FA7774::_id_A38E261031751C09(_id_25978461C6E4F61B);
        player.pers["telemetry"]._id_7E78E00462492360[_id_65B695F0C0D909ED] = 0;

        if(!_id_7E52B56769FA7774::_id_82D45592D750D388(_id_25978461C6E4F61B) && !_id_A38E261031751C09 && !_id_F41D7258200E1D08) {
          player _id_2D9D24F7C63AC143::_id_DB1DD76061352E5B(_id_65B695F0C0D909ED);
          player.pers["telemetry"]._id_7E78E00462492360[_id_65B695F0C0D909ED] = 1;
        } else if(_id_A38E261031751C09) {
          _id_623484AC7E5934A9[_id_65D040B6FA76F410.lootid] = 1;
          _id_FF239359935AA777 = player _id_2D9D24F7C63AC143::_id_897B29ADB37F06A7(_id_65B695F0C0D909ED);
          _id_F605BAF61D74D8DF(player, _id_65D040B6FA76F410, _id_FF239359935AA777);
        }
      }
    }
  }

  if(_id_F41D7258200E1D08)
    _id_1341F0AE49D492CD(player);

  foreach(_id_BCD9424DBE5BE418, _ in _id_95C7C9334EA70BD8) {
    if(!istrue(_id_623484AC7E5934A9[_id_BCD9424DBE5BE418])) {
      _id_65B695F0C0D909ED = player _id_2D9D24F7C63AC143::_id_AE22C70A9C2474D9();

      if(isDefined(_id_65B695F0C0D909ED))
        _id_2D9D24F7C63AC143::_id_11F48AE5B87B4525(player, _id_65B695F0C0D909ED, _id_BCD9424DBE5BE418, 1);
    }
  }

  _id_1D553B4E5DF1CB3E(player);
  _id_6B94748791FA241C(player);
  _id_1771E66EA683FBF8(player);
  _id_3B61A01133ED91B0(player);
}

_id_F605BAF61D74D8DF(player, _id_65D040B6FA76F410, quantity) {
  _id_5170A7C15B09F348 = _id_BF2FA755E8269CA8([3], [quantity], _id_65D040B6FA76F410);

  if(isDefined(_id_5170A7C15B09F348))
    _id_CD81C0E152649846(player, _id_65D040B6FA76F410, _id_5170A7C15B09F348);
}

_id_1341F0AE49D492CD(player, _id_FD5DE2FBC2159648, infil) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("haunting", "shouldDropArtifact"))
    player thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("haunting", "shouldDropArtifact")]]();

  for(_id_65B695F0C0D909ED = 0; _id_65B695F0C0D909ED < 11; _id_65B695F0C0D909ED++) {
    _id_65D040B6FA76F410 = player _meth_644ED519CAC9722B(2, 1 + _id_65B695F0C0D909ED);

    if(_id_65D040B6FA76F410._id_FB5FDFAFC29F4513 != "0") {
      if(_id_957F1B4B0DC253D9(_id_65D040B6FA76F410.lootid, _id_FD5DE2FBC2159648, infil)) {
        _id_52384260FE709F19(player, _id_65B695F0C0D909ED);

        if(istrue(_id_FD5DE2FBC2159648)) {
          _id_3EAA9F644DBE7834 = scripts\cp_mp\challenges::_id_6D40F12A09494350(0, 1);
          scripts\cp_mp\challenges::_id_D24138B32084FC3E(player, _id_65D040B6FA76F410.lootid, undefined, _id_3EAA9F644DBE7834, 1, 0);
        }

        continue;
      }

      if(!istrue(infil)) {
        _id_FF239359935AA777 = player _id_2D9D24F7C63AC143::_id_897B29ADB37F06A7(_id_65B695F0C0D909ED);

        if(_id_2391409EF7B431E1::_id_03C17A26CE6A4668(_id_65D040B6FA76F410.lootid))
          _id_FF239359935AA777 = _id_2391409EF7B431E1::_id_20D00ACCAA12C27F();
        else if(!istrue(player.extracted) && isDefined(player._id_457667014505E1F9) && isDefined(player._id_457667014505E1F9[_id_65B695F0C0D909ED]) && player._id_457667014505E1F9[_id_65B695F0C0D909ED]["lootID"] == _id_65D040B6FA76F410.lootid) {
          _id_FF239359935AA777 = player._id_457667014505E1F9[_id_65B695F0C0D909ED]["quantity"];

          if(!isDefined(_id_FF239359935AA777))
            _id_FF239359935AA777 = 1;
        }

        _id_F605BAF61D74D8DF(player, _id_65D040B6FA76F410, _id_FF239359935AA777);
      }
    }
  }
}

_id_957F1B4B0DC253D9(lootid, _id_FD5DE2FBC2159648, infil) {
  scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);
  _id_907944A173ED27E1 = isDefined(scriptablename) && _id_7E52B56769FA7774::_id_907944A173ED27E1(scriptablename);
  _id_0D8D84C04A1B3965 = isDefined(scriptablename) && (_id_907944A173ED27E1 || _id_7E52B56769FA7774::_id_3CAD96C265936DF7(scriptablename));
  _id_47EC0D8898E4A94E = scripts\cp_mp\utility\game_utility::_id_EE0C2958AA2EE59E() || istrue(level._id_A25720E982F459FB);
  return !istrue(_id_FD5DE2FBC2159648) && !(istrue(infil) && _id_47EC0D8898E4A94E) && _id_2D9D24F7C63AC143::_id_F6F8C1FC9549EAF6(lootid) || _id_2D9D24F7C63AC143::_id_8E61EF2A2F9137E7(lootid) || _id_2D9D24F7C63AC143::_id_B4893066110F4D10(lootid) || _id_0D8D84C04A1B3965 && !istrue(_id_FD5DE2FBC2159648) && !istrue(infil) || _id_907944A173ED27E1 && istrue(_id_FD5DE2FBC2159648);
}

_id_A3BBD9874F6A5599(lootid, _id_FD5DE2FBC2159648, infil) {
  scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);
  _id_907944A173ED27E1 = isDefined(scriptablename) && _id_7E52B56769FA7774::_id_907944A173ED27E1(scriptablename);
  _id_0D8D84C04A1B3965 = isDefined(scriptablename) && (_id_907944A173ED27E1 || _id_7E52B56769FA7774::_id_3CAD96C265936DF7(scriptablename));
  return !istrue(_id_FD5DE2FBC2159648) && !(istrue(infil) && istrue(level._id_A25720E982F459FB)) && _id_2D9D24F7C63AC143::_id_F6F8C1FC9549EAF6(lootid) || _id_0D8D84C04A1B3965 && !istrue(_id_FD5DE2FBC2159648) && !istrue(infil) || _id_907944A173ED27E1 && istrue(_id_FD5DE2FBC2159648);
}

_id_6B94748791FA241C(player) {
  if(!istrue(level._id_E442BA065DD78F24)) {
    return;
  }
  if(!isDefined(player._id_54D33FF1DF87C60F)) {
    return;
  }
  _id_BFEDEB20F8B77F3F(player, player._id_54D33FF1DF87C60F);
}

_id_1771E66EA683FBF8(player) {
  lootid = player _meth_644ED519CAC9722B(1, 4).lootid;
  _id_5577636292591C8B = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(lootid);

  if(isDefined(_id_5577636292591C8B) && _id_5577636292591C8B == "super") {
    _id_EBEC497FF8B18A45 = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);

    if(isDefined(_id_EBEC497FF8B18A45) && (scripts\mp\supers::_id_907944A173ED27E1(_id_EBEC497FF8B18A45) || _id_EBEC497FF8B18A45 == "super_temp_v"))
      _id_351FE4AC57CA37E5(player, "super");
  }
}

_id_ED325A060ADCBE65(player) {
  if(!istrue(level._id_E442BA065DD78F24)) {
    return;
  }
  foreach(weaponslot in [0, 1]) {
    weapon = _id_7E52B56769FA7774::_id_13ECF3644442A3E7(player, weaponslot);

    if(isDefined(weapon) && weaponclass(weapon) == "sniper" && weapon hasattachment("unique_sn_alpha50_stpats")) {
      player._id_54D33FF1DF87C60F = weaponslot;
      return;
    }
  }

  if(!isDefined(player._id_54D33FF1DF87C60F)) {
    weapon = _id_2D9D24F7C63AC143::_id_2985254128B1C262(player);

    if(isDefined(weapon) && weaponclass(weapon) == "sniper" && weapon hasattachment("unique_sn_alpha50_stpats"))
      player._id_54D33FF1DF87C60F = 2;
  }
}

_id_181F84B6E516D4E6(_id_08488A6AF29DE20A, _id_DEC9BCCE93873125) {
  _id_CB325DDB4A764623 = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(_id_08488A6AF29DE20A.lootid);
  _id_DEC9BCCE93873125 = _id_DEC9BCCE93873125 + " ID: " + _id_08488A6AF29DE20A.lootid + " " + _id_CB325DDB4A764623 + " ";

  if(isDefined(_id_08488A6AF29DE20A._id_6CB812578F7D9AE7)) {
    foreach(_id_CAE85767829655F7, _id_99B9B0B10959580E in _id_08488A6AF29DE20A._id_6CB812578F7D9AE7) {
      if(isDefined(_id_99B9B0B10959580E) && _id_99B9B0B10959580E != 0)
        _id_DEC9BCCE93873125 = _id_DEC9BCCE93873125 + " Child " + _id_CAE85767829655F7 + ": " + _id_99B9B0B10959580E + " ";
    }
  }

  return _id_DEC9BCCE93873125;
}

_id_E29C498DD636939A(instance, _id_DEC9BCCE93873125) {
  _id_CB325DDB4A764623 = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(instance.lootid);
  return _id_DEC9BCCE93873125 + instance.lootid + " " + _id_CB325DDB4A764623;
}

_id_DDD16C8B86863B56(player) {
  _id_91CB23E7AB33F8EF = player getplayerdata(level._id_5D69837CF4DB0407, "dmzActiveOperatorSlot");
  return _id_91CB23E7AB33F8EF - 100;
}

_id_1D6D967DBF6DFA05(player) {
  _id_52C67624A2BB680E = player getplayerdata(level._id_5D69837CF4DB0407, "dmzPocketCash");
  player setplayerdata(level._id_5D69837CF4DB0407, "dmzPocketCash", 0);
  return _id_52C67624A2BB680E;
}

_id_C241FBC63120CFC4(player, _id_3340318A370A7CB2) {
  if(!_id_E0FC1230452CF4E7())
    return 0;

  _id_5864EA4E21A60CD4 = _id_EF8648922F0937B9(player);
  _id_5DD11D67A8FFE194 = player _meth_644ED519CAC9722B(65535, 1);
  _id_E12099EACE9B6BFC = scripts\mp\teams::_id_A317055D4D0A4605(_id_5864EA4E21A60CD4);
  scriptable = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(_id_5DD11D67A8FFE194.lootid);

  if(_id_5DD11D67A8FFE194._id_FB5FDFAFC29F4513 != "0" && isDefined(scriptable) && _id_7E52B56769FA7774::_id_B1E944A2B3E15E9D(scriptable)) {
    _id_342175A1B9F9067E = _id_2D9D24F7C63AC143::_id_3188D9C94B3D56C2(_id_600B944A95C3A7BF::_id_E1D5A33193DB0133(_id_5DD11D67A8FFE194.lootid));
    _id_2D9D24F7C63AC143::_id_D28F52DA6EDE0191(player, _id_342175A1B9F9067E, undefined, _id_5DD11D67A8FFE194.lootid);
  } else if(isDefined(_id_5864EA4E21A60CD4) && isDefined(_id_E12099EACE9B6BFC)) {
    scriptable = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(_id_E12099EACE9B6BFC);
    _id_92D947129EA5BA6E(player, _id_E12099EACE9B6BFC);
    _id_342175A1B9F9067E = _id_2D9D24F7C63AC143::_id_3188D9C94B3D56C2(scriptable);
    _id_2D9D24F7C63AC143::_id_D28F52DA6EDE0191(player, _id_342175A1B9F9067E, undefined, _id_E12099EACE9B6BFC);
  } else
    _id_2D9D24F7C63AC143::_id_D28F52DA6EDE0191(player, 5);

  _id_6267A5AD12C5E4D4 = player _meth_644ED519CAC9722B(2, 0);
  _id_5577636292591C8B = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(_id_6267A5AD12C5E4D4.lootid);

  if(_id_6267A5AD12C5E4D4._id_FB5FDFAFC29F4513 != "0" && _id_6267A5AD12C5E4D4.lootid > 0) {
    _id_B3723CF04DCD3FB8 = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(_id_2D9D24F7C63AC143::_id_102ABD6883C5F9BF(player));
    _id_6D77D0560B815B93 = _id_2D9D24F7C63AC143::_id_18E2D7A6912B1D07(_id_B3723CF04DCD3FB8);

    if(isDefined(_id_5577636292591C8B) && _id_5577636292591C8B == "weapon" && _id_6D77D0560B815B93)
      _id_A839B9AD5740477D(player, 2, 0, _id_3340318A370A7CB2);
    else
      _id_F910B139E75FD559(player);
  }

  _id_DC62A204E1921A99 = player _meth_644ED519CAC9722B(65535, 4);

  if(_id_DC62A204E1921A99._id_FB5FDFAFC29F4513 != "0") {
    scriptable = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(_id_DC62A204E1921A99.lootid);

    if(isDefined(scriptable) && _id_7E52B56769FA7774::isgasmask(scriptable))
      player scripts\cp_mp\gasmask::init(undefined, scriptable);
    else
      _id_777C89585478357B(player);
  } else if(isDefined(_id_5864EA4E21A60CD4)) {
    _id_7C64A9A794249D9F = scripts\mp\teams::_id_08D92D3FB88A9D34(_id_5864EA4E21A60CD4);

    if(isDefined(_id_7C64A9A794249D9F)) {
      scriptable = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(_id_7C64A9A794249D9F);
      _id_826C883F14E827B3(player, _id_7C64A9A794249D9F);
      player scripts\cp_mp\gasmask::init(undefined, scriptable);
    }
  }

  _id_EA074533D9558D3D = player _meth_644ED519CAC9722B(65535, 3);
  scriptable = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(_id_EA074533D9558D3D.lootid);
  _id_A96A2AB9BF3042D5 = undefined;

  if(isDefined(_id_5864EA4E21A60CD4))
    _id_A96A2AB9BF3042D5 = scripts\mp\teams::_id_A3195A1D60BB2D90(_id_5864EA4E21A60CD4);

  if(_id_EA074533D9558D3D._id_FB5FDFAFC29F4513 != "0" && isDefined(scriptable) && _id_7E52B56769FA7774::isrevivepickup(scriptable))
    player _id_7E52B56769FA7774::_id_AAAA1B3DFE18885C(1, _id_EA074533D9558D3D.lootid);
  else if(isDefined(_id_A96A2AB9BF3042D5)) {
    _id_C0AE57D4DC3A8EEF(player, _id_A96A2AB9BF3042D5);
    player _id_7E52B56769FA7774::_id_AAAA1B3DFE18885C(1, _id_A96A2AB9BF3042D5);
  }

  _id_928D2239AB126D72 = player _meth_644ED519CAC9722B(65535, 5);
  _id_EE3ED078F6741EDE = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(_id_928D2239AB126D72.lootid);

  if(_id_928D2239AB126D72._id_FB5FDFAFC29F4513 != "0" && isDefined(_id_EE3ED078F6741EDE) && _id_EE3ED078F6741EDE == "dmz_exfil_streak")
    _id_4480C6CE37B2BDF3::_id_470B4AAAFD986A0D(player);
  else
    player _id_4480C6CE37B2BDF3::_id_1A425272955D5F75();

  _id_1341F0AE49D492CD(player, 0, 1);
  _id_8D65122EA2E88ECD(player);
  _id_DB31AF9BFC65EA51(player);
  return 1;
}

_id_FC56050BD3DCEA6C(player) {
  if(!_id_E0FC1230452CF4E7())
    return 0;

  _id_EA074533D9558D3D = player _meth_644ED519CAC9722B(65535, 3);
  _id_A96A2AB9BF3042D5 = undefined;
  _id_5864EA4E21A60CD4 = _id_EF8648922F0937B9(player);

  if(isDefined(_id_5864EA4E21A60CD4))
    _id_A96A2AB9BF3042D5 = scripts\mp\teams::_id_A3195A1D60BB2D90(_id_5864EA4E21A60CD4);

  if(_id_EA074533D9558D3D._id_FB5FDFAFC29F4513 == "0" && !isDefined(_id_A96A2AB9BF3042D5) && isDefined(player.team)) {
    if(_id_59352C09A417A5E2(player, 30)) {
      _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(player.team, "players");

      if(isDefined(_id_A6AB8D0FDA441DC2) && _id_A6AB8D0FDA441DC2.size == 1) {
        _id_C0AE57D4DC3A8EEF(player, _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("brloot_self_revive"));
        player _id_7E52B56769FA7774::_id_AAAA1B3DFE18885C(1);
      }
    }
  }
}

_id_A9857977596563CD(player, _id_AC505D7DEE638BDF) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  _id_53D2BE04710104CA(player, _id_B41E38C8836A823E(player, 0), _id_AC505D7DEE638BDF);
  _id_53D2BE04710104CA(player, _id_B41E38C8836A823E(player, 1), _id_AC505D7DEE638BDF);
  _id_53D2BE04710104CA(player, _id_B41E38C8836A823E(player, 2), _id_AC505D7DEE638BDF);
}

_id_53D2BE04710104CA(player, instance, _id_AC505D7DEE638BDF) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  _id_79BF9868C4B11727 = int(scripts\engine\utility::_id_53C4C53197386572(instance._id_B34159F22F6379C9, 0));

  if(_id_79BF9868C4B11727 <= getsystemtime()) {
    return;
  }
  _id_963B1B6E92E4DB70 = int(max(_id_79BF9868C4B11727 - _id_AC505D7DEE638BDF, 0));
  player _meth_4E8D00B0EE5D3BBB(instance._id_FB5FDFAFC29F4513, _id_963B1B6E92E4DB70);
}

_id_B45A3C813EAAA08D(player, instance) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  _id_79BF9868C4B11727 = _id_3A8D97D9E7D9E535(player, instance);

  if(_id_79BF9868C4B11727 > getsystemtime()) {
    return;
  }
  _id_963B1B6E92E4DB70 = _id_0319DC9ED3B41647();

  if(getdvarint("dvar_6DC2F0452C76707D", 1) || getdvarint("dvar_257CB72A99900EF2", 1))
    _id_963B1B6E92E4DB70 = _id_809D965739629DBF(player, instance);

  _id_963B1B6E92E4DB70 = getsystemtime() + _id_963B1B6E92E4DB70;
  _id_B0BEE880705AE6BE = _id_869526AEC2165EC3(player, instance);
  player _meth_4E8D00B0EE5D3BBB(_id_B0BEE880705AE6BE._id_FB5FDFAFC29F4513, int(_id_963B1B6E92E4DB70));
}

_id_B41E38C8836A823E(player, index) {
  return player _meth_644ED519CAC9722B(5, index);
}

_id_869526AEC2165EC3(player, instance) {
  if(!isDefined(instance) || !isDefined(player) || !isDefined(instance._id_D3C548C09BB62DA2))
    return 0;

  foreach(data in instance._id_D3C548C09BB62DA2) {
    if(data.key == 15)
      return player _meth_644ED519CAC9722B(5, int(data.value) - 1);
  }
}

_id_3A8D97D9E7D9E535(player, instance) {
  _id_B0BEE880705AE6BE = _id_869526AEC2165EC3(player, instance);
  return scripts\engine\utility::_id_53C4C53197386572(_id_B0BEE880705AE6BE._id_B34159F22F6379C9, 0);
}

_id_809D965739629DBF(player, instance) {
  if(!isDefined(instance) || !isDefined(player) || !isDefined(instance._id_D3C548C09BB62DA2))
    return 0;

  _id_85166DA84E55DE25 = _id_423648B9C03FDAA1(15, instance, 1);

  if(!isDefined(_id_85166DA84E55DE25))
    return _id_0319DC9ED3B41647();

  _id_9E007EC32F9C5194 = _id_F1AA77738031B49C(instance);

  if(_id_9E007EC32F9C5194 > 0)
    return _id_9E007EC32F9C5194;

  if(!getdvarint("dvar_6DC2F0452C76707D", 1))
    return _id_0319DC9ED3B41647();

  _id_FE3513EDECDEC855 = undefined;

  switch (_id_85166DA84E55DE25) {
    case "1":
      _id_FE3513EDECDEC855 = getdvarint("dvar_618C3CA8C4897D2C", 7200);
      break;
    case "2":
      _id_FE3513EDECDEC855 = getdvarint("dvar_618C3FA8C48983C5", 14400);
      break;
    case "3":
      _id_FE3513EDECDEC855 = getdvarint("dvar_618C3EA8C4898192", 21600);
      break;
    default:
      _id_FE3513EDECDEC855 = _id_0319DC9ED3B41647();
      break;
  }

  _id_45B8F5C6792A74F2 = _id_1EE6A57E88B1A120(player, _id_85166DA84E55DE25);
  return max(0, _id_FE3513EDECDEC855 - _id_FE3513EDECDEC855 * _id_45B8F5C6792A74F2);
}

_id_F1AA77738031B49C(instance) {
  if(!isDefined(instance.lootid) || instance.lootid == 0)
    return 0;

  ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(instance.lootid);

  if(!isDefined(ref))
    return 0;

  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(ref);
  variantid = _func_64CCC54BDBAE5CF6(instance.lootid);
  cooldown = _id_2669878CF5A1B6BC::_id_115404A4DBD59830(_id_AB501F397D3CD312, variantid);
  return cooldown;
}

_id_80478F2EF8C8882F(player) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++) {
    instance = _id_B41E38C8836A823E(player, _id_AC0E594AC96AA3A8);

    if(!isDefined(instance)) {
      continue;
    }
    _id_79BF9868C4B11727 = int(scripts\engine\utility::_id_53C4C53197386572(instance._id_B34159F22F6379C9, 0));

    if(_id_79BF9868C4B11727 > getsystemtime())
      return 1;
  }
}

_id_498BA9B391E5D087(player) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  if(!istrue(_id_80478F2EF8C8882F(player))) {
    return;
  }
  _id_5FB1BB78299865EE = undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++) {
    instance = _id_B41E38C8836A823E(player, _id_AC0E594AC96AA3A8);

    if(!isDefined(instance)) {
      continue;
    }
    _id_79BF9868C4B11727 = int(scripts\engine\utility::_id_53C4C53197386572(instance._id_B34159F22F6379C9, 0));

    if(_id_79BF9868C4B11727 > getsystemtime()) {
      if(!isDefined(_id_5FB1BB78299865EE)) {
        _id_5FB1BB78299865EE = _id_79BF9868C4B11727;
        continue;
      }

      _id_5FB1BB78299865EE = int(min(_id_5FB1BB78299865EE, _id_79BF9868C4B11727));
    }
  }

  return _id_5FB1BB78299865EE;
}

_id_0319DC9ED3B41647() {
  return getdvarint("dvar_40EB514E313DD3EF", 14400);
}

_id_04E92B2A9E565AEE() {
  return getdvarint("dvar_C5AC098E3A15AF33", 3000);
}

_id_04FEDDB036AE52E8(player) {
  _id_9C8064E9C57C2ECE = [];
  _id_6267A5AD12C5E4D4 = player _meth_644ED519CAC9722B(2, 0);

  if(_id_6267A5AD12C5E4D4._id_FB5FDFAFC29F4513 != "0" && _id_6267A5AD12C5E4D4.lootid != 0)
    _id_9C8064E9C57C2ECE[_id_9C8064E9C57C2ECE.size] = _id_6267A5AD12C5E4D4;

  _id_DE79DBEA8C4F970E = player _meth_644ED519CAC9722B(1, 0);

  if(_id_DE79DBEA8C4F970E._id_FB5FDFAFC29F4513 != "0" && _id_DE79DBEA8C4F970E.lootid != 0)
    _id_9C8064E9C57C2ECE[_id_9C8064E9C57C2ECE.size] = _id_DE79DBEA8C4F970E;

  _id_6585928B9413484E = player _meth_644ED519CAC9722B(1, 1);

  if(_id_6585928B9413484E._id_FB5FDFAFC29F4513 != "0" && _id_6585928B9413484E.lootid != 0)
    _id_9C8064E9C57C2ECE[_id_9C8064E9C57C2ECE.size] = _id_6585928B9413484E;

  return _id_9C8064E9C57C2ECE;
}

_id_5148F855DE907E6F(player, weaponslot) {
  if(!_id_E0FC1230452CF4E7())
    return undefined;

  _id_08488A6AF29DE20A = _id_540C2B6342F4E28C(player, weaponslot);

  foreach(instance in player._id_B1BF418AA7242C1D) {
    _id_609578472524B507 = undefined;

    if(_id_E7FCC338BF1CCF24(instance, _id_08488A6AF29DE20A))
      return _id_423648B9C03FDAA1(15, _id_08488A6AF29DE20A, 1);
  }

  return undefined;
}

_id_1D553B4E5DF1CB3E(player) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  if(!isDefined(player._id_B1BF418AA7242C1D)) {
    return;
  }
  _id_9C8064E9C57C2ECE = _id_04FEDDB036AE52E8(player);

  foreach(instance in player._id_B1BF418AA7242C1D) {
    _id_609578472524B507 = undefined;

    foreach(_id_EA21A6B912D4BCB9 in _id_9C8064E9C57C2ECE) {
      if(_id_E7FCC338BF1CCF24(instance, _id_EA21A6B912D4BCB9)) {
        _id_609578472524B507 = _id_EA21A6B912D4BCB9;
        break;
      }
    }

    if(!isDefined(_id_609578472524B507)) {
      _id_B45A3C813EAAA08D(player, instance);
      continue;
    }

    if(_id_609578472524B507._id_207098E76BCAC40F != 14)
      _id_814F4E5C852D9604(player, _id_609578472524B507);
  }
}

_id_814F4E5C852D9604(player, instance) {
  player _meth_DD5661EBE3C9A5A2(instance._id_FB5FDFAFC29F4513);
  player _meth_4F1027E74D5073C4(instance.lootid, 14, instance.location, instance._id_FB6BAFB61D5C3D4A, instance._id_6CB812578F7D9AE7);
  _id_2BA777E4C43A10F5 = player _meth_644ED519CAC9722B(instance.location, instance._id_FB6BAFB61D5C3D4A);

  if(isDefined(instance._id_4E479E14D0837E84)) {
    _id_5170A7C15B09F348 = _id_FE92418620D93763(instance._id_4E479E14D0837E84);
    player _meth_E70C1FC3C2E5E05F(_id_2BA777E4C43A10F5._id_FB5FDFAFC29F4513, 0, _id_5170A7C15B09F348);
  }

  if(isDefined(instance._id_D3C548C09BB62DA2)) {
    _id_5170A7C15B09F348 = _id_FE92418620D93763(instance._id_D3C548C09BB62DA2);
    player _meth_E70C1FC3C2E5E05F(_id_2BA777E4C43A10F5._id_FB5FDFAFC29F4513, 1, _id_5170A7C15B09F348);
  }
}

_id_2286BF57AEDE9518(player) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  if(!isDefined(player._id_B1BF418AA7242C1D)) {
    return;
  }
  foreach(instance in player._id_B1BF418AA7242C1D)
  _id_B45A3C813EAAA08D(player, instance);
}

_id_CD81C0E152649846(player, instance, _id_4E479E14D0837E84, _id_D3C548C09BB62DA2) {
  player _meth_E70C1FC3C2E5E05F(instance._id_FB5FDFAFC29F4513, 0, _id_4E479E14D0837E84);

  if(isDefined(_id_D3C548C09BB62DA2))
    player _meth_E70C1FC3C2E5E05F(instance._id_FB5FDFAFC29F4513, 1, _id_D3C548C09BB62DA2);
}

_id_04A84E57F6373E69(key, _id_4E479E14D0837E84, _id_7F24F2A49F4715F7) {
  if(isDefined(_id_4E479E14D0837E84)) {
    foreach(data in _id_4E479E14D0837E84) {
      if(key == data.key) {
        if(istrue(_id_7F24F2A49F4715F7))
          return [data.value, data._id_64C2FFAA2C43CE24, data._id_0355199FD29C935E];
        else
          return data.value;
      }
    }
  }

  return undefined;
}

_id_423648B9C03FDAA1(key, instance, _id_D3C548C09BB62DA2, _id_7F24F2A49F4715F7) {
  if(!isDefined(key) || !isDefined(instance))
    return undefined;

  _id_4E479E14D0837E84 = instance._id_4E479E14D0837E84;

  if(istrue(_id_D3C548C09BB62DA2))
    _id_4E479E14D0837E84 = instance._id_D3C548C09BB62DA2;

  return _id_04A84E57F6373E69(key, _id_4E479E14D0837E84, _id_7F24F2A49F4715F7);
}

_id_92F14840AA31925D(key, value, _id_4E479E14D0837E84) {
  foreach(data in _id_4E479E14D0837E84) {
    if(key == data.key)
      data.value = value;
  }

  return _id_4E479E14D0837E84;
}

_id_E7FCC338BF1CCF24(_id_D01B7A8EBE9FE5C9, _id_EA21A6B912D4BCB9) {
  _id_CF86F085F815A526 = _id_423648B9C03FDAA1(1, _id_D01B7A8EBE9FE5C9);
  _id_E51271B38C67DFC6 = _id_423648B9C03FDAA1(1, _id_EA21A6B912D4BCB9);

  if(!isDefined(_id_CF86F085F815A526) || !isDefined(_id_E51271B38C67DFC6))
    return 0;

  if(_id_CF86F085F815A526 == _id_E51271B38C67DFC6) {
    _id_0F4D447FFD61BCF2 = _id_423648B9C03FDAA1(15, _id_D01B7A8EBE9FE5C9, 1);
    _id_B8250A3B219F951A = _id_423648B9C03FDAA1(15, _id_EA21A6B912D4BCB9, 1);
    return isDefined(_id_0F4D447FFD61BCF2) && isDefined(_id_B8250A3B219F951A) && _id_0F4D447FFD61BCF2 == _id_B8250A3B219F951A;
  }

  return 0;
}

_id_C60AD978E8EC0345(player, location, _id_FB6BAFB61D5C3D4A) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  instance = player _meth_644ED519CAC9722B(location, _id_FB6BAFB61D5C3D4A);
  return [instance._id_4E479E14D0837E84, instance._id_D3C548C09BB62DA2];
}

_id_CD4840758C0F2125(instance) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  return [instance._id_4E479E14D0837E84, instance._id_D3C548C09BB62DA2];
}

_id_74031E3249A6F69E(player, slot) {
  if(!_id_E0FC1230452CF4E7())
    return undefined;

  location = 1;
  _id_FB6BAFB61D5C3D4A = slot;

  if(slot == 2) {
    location = 2;
    _id_FB6BAFB61D5C3D4A = 0;
  }

  return _id_C60AD978E8EC0345(player, location, _id_FB6BAFB61D5C3D4A);
}

_id_743A2B4D08F023D2(player) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  _id_02AC478345313402 = player _meth_644ED519CAC9722B(65535, 2);
  _id_5864EA4E21A60CD4 = _id_EF8648922F0937B9(player);
  _id_3FC34CA532242BEA = scripts\mp\teams::_id_81360519D4836BF7(_id_5864EA4E21A60CD4);
  _id_0347AA4935F42810 = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(_id_02AC478345313402.lootid);

  if(_id_02AC478345313402._id_FB5FDFAFC29F4513 != "0" && _id_2CEDCC356F1B9FC8::_id_4AA12E0ED3F6B745(_id_0347AA4935F42810))
    _id_0E9CFD120B0B43EF = _id_7E52B56769FA7774::_id_E98A5A4E0E001AC3(player, _id_0347AA4935F42810, 1);
  else if(isDefined(_id_5864EA4E21A60CD4) && isDefined(_id_3FC34CA532242BEA)) {
    scriptable = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(_id_02AC478345313402.lootid);
    _id_0BD01C77AB46F790(player, _id_3FC34CA532242BEA);
    _id_0E9CFD120B0B43EF = _id_7E52B56769FA7774::_id_E98A5A4E0E001AC3(player, _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(_id_3FC34CA532242BEA), 1);
  } else
    _id_7E52B56769FA7774::_id_A0877DFCB342653A(player);
}

_id_C0CC833A07B24CD8(player, instance, _id_6537D9855FB64BF9, _id_0FD52A3922167EA1, _id_11B87EF3F5CCBC5E) {
  lootid = scripts\mp\weapons::_id_7A91162092CC11EC(instance.lootid);

  if(!isDefined(lootid))
    return [_id_0FD52A3922167EA1, _id_6537D9855FB64BF9];

  if(!isDefined(_id_11B87EF3F5CCBC5E[lootid])) {
    _id_0FD52A3922167EA1[_id_0FD52A3922167EA1.size] = _id_6537D9855FB64BF9;
    _id_0FD52A3922167EA1[_id_0FD52A3922167EA1.size] = lootid;
    _id_11B87EF3F5CCBC5E[lootid] = 1;
    _id_6537D9855FB64BF9 = _id_6537D9855FB64BF9 + 1;
  }

  _id_093B3002EBEF628B = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);
  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(_id_093B3002EBEF628B);
  assetname = _id_2669878CF5A1B6BC::_id_072376783A92BE46(_id_AB501F397D3CD312);
  attachments = _func_6527364C1ECCA6C6(assetname);

  foreach(attachment in attachments) {
    _id_3B3077EE39BDCD6F = _func_40FD49171FAD19D3(attachment);
    _id_4F13B964AB82FE13 = level._id_8DD253609D606F1C[_id_3B3077EE39BDCD6F];

    if(!isDefined(_id_4F13B964AB82FE13)) {
      continue;
    }
    if(!isDefined(_id_11B87EF3F5CCBC5E[_id_4F13B964AB82FE13])) {
      _id_0FD52A3922167EA1[_id_0FD52A3922167EA1.size] = _id_6537D9855FB64BF9;
      _id_0FD52A3922167EA1[_id_0FD52A3922167EA1.size] = _id_4F13B964AB82FE13;
      _id_11B87EF3F5CCBC5E[_id_4F13B964AB82FE13] = 1;
      _id_6537D9855FB64BF9 = _id_6537D9855FB64BF9 + 1;
    }
  }

  return [_id_0FD52A3922167EA1, _id_6537D9855FB64BF9, _id_11B87EF3F5CCBC5E];
}

_id_2495DD1DDE4756FB(player) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  _id_0FD52A3922167EA1 = [];
  _id_11B87EF3F5CCBC5E = [];
  _id_0FD52A3922167EA1[_id_0FD52A3922167EA1.size] = 32;
  _id_0FD52A3922167EA1[_id_0FD52A3922167EA1.size] = 1;
  _id_21341C7142D7E704 = 76;
  _id_333F404612F8D562 = player _meth_644ED519CAC9722B(1, 0);
  [_id_0FD52A3922167EA1, _id_21341C7142D7E704, _id_11B87EF3F5CCBC5E] = _id_C0CC833A07B24CD8(player, _id_333F404612F8D562, _id_21341C7142D7E704, _id_0FD52A3922167EA1, _id_11B87EF3F5CCBC5E);
  _id_20DEBC67D125A6A2 = player _meth_644ED519CAC9722B(1, 1);
  [_id_0FD52A3922167EA1, _id_21341C7142D7E704, _id_11B87EF3F5CCBC5E] = _id_C0CC833A07B24CD8(player, _id_20DEBC67D125A6A2, _id_21341C7142D7E704, _id_0FD52A3922167EA1, _id_11B87EF3F5CCBC5E);
  _id_6267A5AD12C5E4D4 = player _meth_644ED519CAC9722B(2, 0);
  [_id_0FD52A3922167EA1, _id_21341C7142D7E704, _id_11B87EF3F5CCBC5E] = _id_C0CC833A07B24CD8(player, _id_6267A5AD12C5E4D4, _id_21341C7142D7E704, _id_0FD52A3922167EA1, _id_11B87EF3F5CCBC5E);
  _id_B2721CF177F915E4 = player _meth_644ED519CAC9722B(1, 2);
  _id_0FD52A3922167EA1[_id_0FD52A3922167EA1.size] = _id_21341C7142D7E704;
  _id_0FD52A3922167EA1[_id_0FD52A3922167EA1.size] = _id_B2721CF177F915E4.lootid;
  _id_11B87EF3F5CCBC5E[_id_B2721CF177F915E4.lootid] = 1;
  _id_21341C7142D7E704++;
  _id_2230DE25F8635C83 = player _meth_644ED519CAC9722B(1, 3);
  _id_0FD52A3922167EA1[_id_0FD52A3922167EA1.size] = _id_21341C7142D7E704;
  _id_0FD52A3922167EA1[_id_0FD52A3922167EA1.size] = _id_2230DE25F8635C83.lootid;
  _id_11B87EF3F5CCBC5E[_id_2230DE25F8635C83.lootid] = 1;
  _id_21341C7142D7E704++;
  _id_BED94C5E8BA6C57E = player _meth_644ED519CAC9722B(1, 4);
  _id_0FD52A3922167EA1[_id_0FD52A3922167EA1.size] = _id_21341C7142D7E704;
  _id_0FD52A3922167EA1[_id_0FD52A3922167EA1.size] = _id_BED94C5E8BA6C57E.lootid;
  _id_11B87EF3F5CCBC5E[_id_BED94C5E8BA6C57E.lootid] = 1;
  _id_21341C7142D7E704++;
  _id_8862C20CFFB85370 = player _meth_644ED519CAC9722B(65535, 0);
  _id_0FD52A3922167EA1[_id_0FD52A3922167EA1.size] = _id_21341C7142D7E704;
  _id_0FD52A3922167EA1[_id_0FD52A3922167EA1.size] = _id_8862C20CFFB85370.lootid;
  _id_11B87EF3F5CCBC5E[_id_8862C20CFFB85370.lootid] = 1;
  _id_21341C7142D7E704++;

  for(_id_65B695F0C0D909ED = 1; _id_65B695F0C0D909ED <= 12; _id_65B695F0C0D909ED++) {
    _id_5DD11D67A8FFE194 = player _meth_644ED519CAC9722B(2, _id_65B695F0C0D909ED);

    if(!isDefined(_id_11B87EF3F5CCBC5E[_id_5DD11D67A8FFE194.lootid])) {
      _id_0FD52A3922167EA1[_id_0FD52A3922167EA1.size] = _id_21341C7142D7E704;
      _id_0FD52A3922167EA1[_id_0FD52A3922167EA1.size] = _id_5DD11D67A8FFE194.lootid;
      _id_11B87EF3F5CCBC5E[_id_5DD11D67A8FFE194.lootid] = 1;
      _id_21341C7142D7E704++;
    }
  }

  _id_00023D99FAF8C73C = _id_21341C7142D7E704 - 76;
  player _meth_DB073176839D77FB("348", _id_0FD52A3922167EA1);
}

_id_EF552DF845E8B952(player) {
  if(_id_6484CE4430C9439B(player, 0))
    _id_DC67872CC4CFAE72(player, 1, 0);

  if(_id_6484CE4430C9439B(player, 1))
    _id_DC67872CC4CFAE72(player, 1, 1);

  _id_F910B139E75FD559(player);
  _id_351FE4AC57CA37E5(player, "primary");
  _id_351FE4AC57CA37E5(player, "secondary");
  _id_351FE4AC57CA37E5(player, "super");
  _id_28550536EBAFE216(player);
  _id_777C89585478357B(player);
  _id_0A60428CDA4724A7(player);
  _id_5B7DC44BB66553A6(player);
  _id_EA96B27797C7E268(player);

  if(!_id_2D9D24F7C63AC143::_id_C4F1BD7A01A307FA(player))
    _id_F30F21D87C483297(player);
}

_id_E8B12CE137E718CD(player) {
  if(!isDefined(player._id_81D789409ADA6941)) {
    return;
  }
  if(isDefined(player._id_81D789409ADA6941[2])) {
    _id_1189BD7FBE2861F8 = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(player._id_81D789409ADA6941[2]);
    isselectable = scripts\mp\equipment::isequipmentselectable(_id_1189BD7FBE2861F8);

    if(istrue(isselectable))
      player _meth_4F1027E74D5073C4(player._id_81D789409ADA6941[2], 13, 1, 2, []);
  }

  if(isDefined(player._id_81D789409ADA6941[3])) {
    _id_1189BD7FBE2861F8 = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(player._id_81D789409ADA6941[3]);
    isselectable = scripts\mp\equipment::isequipmentselectable(_id_1189BD7FBE2861F8);

    if(istrue(isselectable))
      player _meth_4F1027E74D5073C4(player._id_81D789409ADA6941[3], 13, 1, 3, []);
  }

  if(isDefined(player._id_81D789409ADA6941[4])) {
    _id_EBEC497FF8B18A45 = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(player._id_81D789409ADA6941[4]);
    _id_94DEAC09D462D41E = scripts\mp\supers::_id_5CC7D8C432D5D6C1(_id_EBEC497FF8B18A45);
    _id_41F94BCA374ED58A = scripts\mp\supers::_id_C519AE03535AFE0F(_id_EBEC497FF8B18A45);

    if(!istrue(_id_94DEAC09D462D41E) || isDefined(_id_41F94BCA374ED58A) && _id_59352C09A417A5E2(player, _id_41F94BCA374ED58A))
      player _meth_4F1027E74D5073C4(player._id_81D789409ADA6941[4], 13, 1, 4, []);
  }
}

_id_868B6D4FBEC3938C(player) {
  _id_C1BB256C7473F345(player);
  _id_B9E5B13D100AA0F5(player, 0);
  _id_E8B12CE137E718CD(player);
}

_id_C1BB256C7473F345(player) {
  _id_2286BF57AEDE9518(player);
  _id_DC67872CC4CFAE72(player, 1, 0);
  _id_DC67872CC4CFAE72(player, 1, 1);
  _id_F910B139E75FD559(player);
  _id_351FE4AC57CA37E5(player, "primary");
  _id_351FE4AC57CA37E5(player, "secondary");
  _id_351FE4AC57CA37E5(player, "super");
  _id_28550536EBAFE216(player);
  _id_777C89585478357B(player);
  _id_0A60428CDA4724A7(player);
  _id_5B7DC44BB66553A6(player);
  _id_EA96B27797C7E268(player);
  _id_7BC70FC1DD299F89(player);

  if(!_id_2D9D24F7C63AC143::_id_C4F1BD7A01A307FA(player))
    _id_F30F21D87C483297(player);
  else
    _id_1341F0AE49D492CD(player);
}

_id_F30F21D87C483297(player) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  for(_id_65B695F0C0D909ED = 0; _id_65B695F0C0D909ED < 11; _id_65B695F0C0D909ED++)
    _id_52384260FE709F19(player, _id_65B695F0C0D909ED);
}

_id_B05E71B6D3D2256F(player) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  player _meth_78EC884C707A6ADC();
}

_id_4B57E9867785E738(player) {
  if(!_id_E0FC1230452CF4E7())
    return 0;

  for(_id_A7C9E7C67496899E = 0; _id_A7C9E7C67496899E <= 1; _id_A7C9E7C67496899E++) {
    _id_08488A6AF29DE20A = player _meth_644ED519CAC9722B(1, _id_A7C9E7C67496899E);

    if(isDefined(_id_08488A6AF29DE20A._id_207098E76BCAC40F) && _id_08488A6AF29DE20A._id_207098E76BCAC40F == 14)
      return 1;
  }

  _id_6267A5AD12C5E4D4 = player _meth_644ED519CAC9722B(2, 0);

  if(isDefined(_id_6267A5AD12C5E4D4._id_207098E76BCAC40F) && _id_6267A5AD12C5E4D4._id_207098E76BCAC40F == 14)
    return 1;

  return 0;
}

_id_4D95079FF587FDB9(player) {
  if(!_id_E0FC1230452CF4E7())
    return 0;

  for(_id_A7C9E7C67496899E = 0; _id_A7C9E7C67496899E <= 1; _id_A7C9E7C67496899E++) {
    _id_08488A6AF29DE20A = player _meth_644ED519CAC9722B(1, _id_A7C9E7C67496899E);

    if(isDefined(_id_08488A6AF29DE20A._id_207098E76BCAC40F) && _id_08488A6AF29DE20A._id_207098E76BCAC40F == 11)
      return 1;
  }

  _id_6267A5AD12C5E4D4 = player _meth_644ED519CAC9722B(2, 0);

  if(isDefined(_id_6267A5AD12C5E4D4._id_207098E76BCAC40F) && _id_6267A5AD12C5E4D4._id_207098E76BCAC40F == 11)
    return 1;

  return 0;
}

_id_7BC089FE8FDE43C7(player, weaponslot) {
  _id_08488A6AF29DE20A = _id_540C2B6342F4E28C(player, weaponslot);

  if(isDefined(_id_08488A6AF29DE20A)) {
    if(isDefined(_id_08488A6AF29DE20A._id_207098E76BCAC40F) && _id_08488A6AF29DE20A._id_207098E76BCAC40F == 11)
      return 1;
  }

  return 0;
}

_id_E64D9A42C66018C9(player) {
  _id_333F404612F8D562 = player _meth_644ED519CAC9722B(1, 0);
  _id_C094DB262CE4DFA0 = "Loadout Weapon 1 ";
  _id_20DEBC67D125A6A2 = player _meth_644ED519CAC9722B(1, 1);
  _id_C094DB262CE4DFA0 = "Loadout Weapon 2 ";
  _id_6267A5AD12C5E4D4 = player _meth_644ED519CAC9722B(2, 0);
  _id_C094DB262CE4DFA0 = "Backpack Weapon ";
  _id_B2721CF177F915E4 = player _meth_644ED519CAC9722B(1, 2);
  _id_2230DE25F8635C83 = player _meth_644ED519CAC9722B(1, 3);
  _id_BED94C5E8BA6C57E = player _meth_644ED519CAC9722B(1, 4);
  _id_8862C20CFFB85370 = player _meth_644ED519CAC9722B(65535, 0);
  _id_DC62A204E1921A99 = player _meth_644ED519CAC9722B(65535, 4);
  _id_5DD11D67A8FFE194 = player _meth_644ED519CAC9722B(65535, 1);
  _id_EA074533D9558D3D = player _meth_644ED519CAC9722B(65535, 3);

  for(_id_65B695F0C0D909ED = 1; _id_65B695F0C0D909ED <= 12; _id_65B695F0C0D909ED++)
    _id_5DD11D67A8FFE194 = player _meth_644ED519CAC9722B(2, _id_65B695F0C0D909ED);
}

_id_540204218B5DD9DA(player) {
  player._id_6F7281F031B30320 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 <= 6; _id_AC0E594AC96AA3A8++)
    player._id_6F7281F031B30320[_id_AC0E594AC96AA3A8] = scripts\mp\hud_util::createfontstring("default", 0.8);
}

_id_C563BBC48F1DD3D2(player) {
  for(;;) {
    if(!isDefined(player._id_6F7281F031B30320))
      _id_540204218B5DD9DA(player);

    _id_333F404612F8D562 = player _meth_644ED519CAC9722B(1, 0);
    player._id_6F7281F031B30320[0] scripts\mp\hud_util::setpoint("TOPLEFT", "TOPLEFT", 250, 30);
    player._id_6F7281F031B30320[0] clearalltextafterhudelem();
    _id_20DEBC67D125A6A2 = player _meth_644ED519CAC9722B(1, 1);
    player._id_6F7281F031B30320[1] scripts\mp\hud_util::setpoint("TOPLEFT", "TOPLEFT", 250, 40);
    player._id_6F7281F031B30320[1] clearalltextafterhudelem();
    _id_6267A5AD12C5E4D4 = player _meth_644ED519CAC9722B(2, 0);
    player._id_6F7281F031B30320[2] scripts\mp\hud_util::setpoint("TOPLEFT", "TOPLEFT", 250, 50);
    player._id_6F7281F031B30320[2] clearalltextafterhudelem();
    _id_B2721CF177F915E4 = player _meth_644ED519CAC9722B(1, 2);
    _id_2230DE25F8635C83 = player _meth_644ED519CAC9722B(1, 3);
    player._id_6F7281F031B30320[3] scripts\mp\hud_util::setpoint("TOPLEFT", "TOPLEFT", 250, 60);
    player._id_6F7281F031B30320[3] clearalltextafterhudelem();
    player._id_6F7281F031B30320[3].archived = 0;
    _id_BED94C5E8BA6C57E = player _meth_644ED519CAC9722B(1, 4);
    _id_8862C20CFFB85370 = player _meth_644ED519CAC9722B(65535, 0);
    player._id_6F7281F031B30320[4] scripts\mp\hud_util::setpoint("TOPLEFT", "TOPLEFT", 250, 80);
    player._id_6F7281F031B30320[4] clearalltextafterhudelem();
    player._id_6F7281F031B30320[4].archived = 0;
    _id_DC62A204E1921A99 = player _meth_644ED519CAC9722B(65535, 4);
    _id_5DD11D67A8FFE194 = player _meth_644ED519CAC9722B(65535, 1);
    _id_02AC478345313402 = player _meth_644ED519CAC9722B(65535, 2);
    _id_EA074533D9558D3D = player _meth_644ED519CAC9722B(65535, 3);
    player._id_6F7281F031B30320[5] scripts\mp\hud_util::setpoint("TOPLEFT", "TOPLEFT", 250, 100);
    player._id_6F7281F031B30320[5] clearalltextafterhudelem();
    player._id_6F7281F031B30320[5].archived = 0;
    _id_B868DD85A8E182F2 = "Backpack Items: ";

    for(_id_65B695F0C0D909ED = 1; _id_65B695F0C0D909ED <= 12; _id_65B695F0C0D909ED++) {
      _id_5DD11D67A8FFE194 = player _meth_644ED519CAC9722B(2, _id_65B695F0C0D909ED);
      _id_B868DD85A8E182F2 = _id_B868DD85A8E182F2 + _id_E29C498DD636939A(_id_5DD11D67A8FFE194, "") + ", ";
    }

    player._id_6F7281F031B30320[6] scripts\mp\hud_util::setpoint("TOPLEFT", "TOPLEFT", 250, 140);
    player._id_6F7281F031B30320[6] clearalltextafterhudelem();
    player._id_6F7281F031B30320[6].archived = 0;
    wait 3;
  }
}

_id_A3D464413E73F057(player) {
  if(!isDefined(level._id_19CC064EF4F4F035))
    level._id_19CC064EF4F4F035 = 0;

  if(!isDefined(player._id_87F0698DC7AC0A09)) {
    player._id_87F0698DC7AC0A09 = level._id_19CC064EF4F4F035;
    level._id_19CC064EF4F4F035++;
  }

  return player._id_87F0698DC7AC0A09;
}

_id_359EA1FA75CE58D8() {
  if(!isDefined(level._id_A2C878A15054B7D2))
    level._id_A2C878A15054B7D2 = getdvarint("dvar_B39534CBFCE013C4", 0);

  return level._id_A2C878A15054B7D2;
}

_id_6E0F57C0FDD64F13(player) {
  if(istrue(player._id_7093A8118013837F))
    return 1;

  _id_ED6DDFE7149B5D7C = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("loot_key_gold_door");

  if(!isDefined(_id_ED6DDFE7149B5D7C))
    return 0;

  for(_id_65B695F0C0D909ED = 14; _id_65B695F0C0D909ED >= 1; _id_65B695F0C0D909ED--) {
    _id_5DD11D67A8FFE194 = player _meth_644ED519CAC9722B(2, _id_65B695F0C0D909ED);

    if(_id_5DD11D67A8FFE194._id_FB5FDFAFC29F4513 != "0" && _id_5DD11D67A8FFE194.lootid == _id_ED6DDFE7149B5D7C) {
      player._id_7093A8118013837F = 1;

      if(_id_65B695F0C0D909ED <= 12) {
        _id_239511438B021CBE = _id_65B695F0C0D909ED - 1;
        player setplayerdata(level._id_5D69837CF4DB0407, "dmzBackpack", _id_239511438B021CBE, "lootID", 0);
        player setplayerdata(level._id_5D69837CF4DB0407, "dmzBackpack", _id_239511438B021CBE, "quantity", 0);
      }

      _id_DC67872CC4CFAE72(player, 2, _id_65B695F0C0D909ED);
      return 1;
    }
  }

  return 0;
}

_id_3B6AC6FDE1B3E84A(player) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  if(!player isfireteamleader()) {
    return;
  }
  if(!_id_6E0F57C0FDD64F13(player) && _id_359EA1FA75CE58D8()) {
    _id_06980251E86D0A47 = player getfireteammembers();
    kick(player getentitynumber(), "EXE/PLAYERKICKED_NO_BIO_LAB_TICKET");

    foreach(_id_7EEF32A705DE8BEE in _id_06980251E86D0A47)
    kick(_id_7EEF32A705DE8BEE getentitynumber(), "EXE/PLAYERKICKED_NO_BIO_LAB_TICKET");
  }
}

_id_6484CE4430C9439B(player, slot) {
  if(!isDefined(player) || !isDefined(player._id_06317F2446D7F722))
    return 1;

  return !istrue(player._id_06317F2446D7F722[slot]);
}

_id_D3E4D206D9B842A0(scriptable) {
  if(!isDefined(scriptable._id_4E479E14D0837E84) || !isDefined(scriptable._id_4E479E14D0837E84[1]))
    return 0;

  foreach(data in scriptable._id_4E479E14D0837E84[1]) {
    if(data.key == 15 && int(data.value) > 0)
      return 1;
  }

  return 0;
}

_id_C2B37CAEB3E8DFA0(player, _id_FE4048AD22C35D73, _id_A0A8CC91D4F7CB2D, _id_AA1D8F0586732A5A) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  _id_5170A7C15B09F348 = _id_CD4840758C0F2125(_id_AA1D8F0586732A5A);

  if(istrue(_id_423648B9C03FDAA1(7, _id_AA1D8F0586732A5A, 1)))
    _id_5170A7C15B09F348[1] = _id_92F14840AA31925D(7, 0, _id_5170A7C15B09F348[1]);

  _id_0DE3154264E07D28 = [];
  _id_76A621441904EBAB = [];

  for(_id_80FBF4ED7B56B1DF = 0; _id_80FBF4ED7B56B1DF <= 4; _id_80FBF4ED7B56B1DF++) {
    _id_DF6D8E005B4B8020 = 0 + _id_80FBF4ED7B56B1DF;

    if(isDefined(_id_423648B9C03FDAA1(8 + _id_80FBF4ED7B56B1DF, _id_A0A8CC91D4F7CB2D, 1)) && _id_A0A8CC91D4F7CB2D._id_6CB812578F7D9AE7[_id_DF6D8E005B4B8020] != 0)
      _id_0DE3154264E07D28[_id_A0A8CC91D4F7CB2D._id_6CB812578F7D9AE7[_id_DF6D8E005B4B8020]] = 1;

    _id_0A58B61FF61269EF = _id_423648B9C03FDAA1(2 + _id_80FBF4ED7B56B1DF, _id_A0A8CC91D4F7CB2D, 1);

    if(isDefined(_id_0A58B61FF61269EF) && _id_A0A8CC91D4F7CB2D._id_6CB812578F7D9AE7[_id_DF6D8E005B4B8020] != 0)
      _id_76A621441904EBAB[_id_A0A8CC91D4F7CB2D._id_6CB812578F7D9AE7[_id_DF6D8E005B4B8020]] = _id_0A58B61FF61269EF;
  }

  for(_id_80FBF4ED7B56B1DF = 0; _id_80FBF4ED7B56B1DF <= 4; _id_80FBF4ED7B56B1DF++) {
    _id_DF6D8E005B4B8020 = 0 + _id_80FBF4ED7B56B1DF;
    _id_113E0F3DDDFC9A41 = 0;
    _id_0A58B61FF61269EF = 0;

    if(isDefined(_id_0DE3154264E07D28[_id_AA1D8F0586732A5A._id_6CB812578F7D9AE7[_id_DF6D8E005B4B8020]]))
      _id_113E0F3DDDFC9A41 = 1;

    if(isDefined(_id_76A621441904EBAB[_id_AA1D8F0586732A5A._id_6CB812578F7D9AE7[_id_DF6D8E005B4B8020]]))
      _id_0A58B61FF61269EF = _id_76A621441904EBAB[_id_AA1D8F0586732A5A._id_6CB812578F7D9AE7[_id_DF6D8E005B4B8020]];

    _id_5170A7C15B09F348[1] = _id_92F14840AA31925D(8 + _id_80FBF4ED7B56B1DF, _id_113E0F3DDDFC9A41, _id_5170A7C15B09F348[1]);
    _id_5170A7C15B09F348[1] = _id_92F14840AA31925D(2 + _id_80FBF4ED7B56B1DF, _id_0A58B61FF61269EF, _id_5170A7C15B09F348[1]);
  }

  _id_11CC6F33CB91B3F1 = _id_FE92418620D93763(_id_5170A7C15B09F348[0]);
  _id_D3C548C09BB62DA2 = _id_FE92418620D93763(_id_5170A7C15B09F348[1]);
  _id_CD81C0E152649846(player, _id_AA1D8F0586732A5A, _id_11CC6F33CB91B3F1, _id_D3C548C09BB62DA2);
}

_id_36275388F9093535(_id_4E479E14D0837E84) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  _id_87F0698DC7AC0A09 = _id_04A84E57F6373E69(1, _id_4E479E14D0837E84[0]);

  foreach(player in level.players) {
    if(isDefined(player._id_87F0698DC7AC0A09) && isDefined(_id_87F0698DC7AC0A09) && player._id_87F0698DC7AC0A09 == int(_id_87F0698DC7AC0A09))
      return player;
  }
}

_id_251FB8FBF0D6ADDC() {
  if(!isDefined(level._id_1200C749A3268F9F))
    level._id_1200C749A3268F9F = getdvarfloat("dvar_4D31327236448D75", 0.05);

  return level._id_1200C749A3268F9F;
}

_id_BA249AC98EDC6279(player) {
  if(!_id_E0FC1230452CF4E7())
    return 0;

  _id_5332CDA4054641DA = _id_07E5492B68492F80(player, 14);
  return _id_5332CDA4054641DA * _id_251FB8FBF0D6ADDC();
}

_id_5C55FF785294AD1D() {
  if(!isDefined(level._id_70D06CC3A8218177))
    level._id_70D06CC3A8218177 = getdvarfloat("dvar_AAD2DC8050226460", 0.04);

  return level._id_70D06CC3A8218177;
}

_id_66F4C5EC2E0BEEE6() {
  if(!isDefined(level._id_18C292B7709DAFCC))
    level._id_18C292B7709DAFCC = getdvarfloat("dvar_1C2DC077C5758375", 0.05);

  return level._id_18C292B7709DAFCC;
}

_id_956E931113E352A6() {
  if(!isDefined(level._id_3AA04E5B96BB1307))
    level._id_3AA04E5B96BB1307 = getdvarfloat("dvar_C9A496BAF46A5A42", 0.05);

  return level._id_3AA04E5B96BB1307;
}

_id_C826EE21A52E408B() {
  if(!isDefined(level._id_096AB8672D820807))
    level._id_096AB8672D820807 = getdvarfloat("dvar_AE4F2B9BFC7F50A8", 0.05);

  return level._id_096AB8672D820807;
}

_id_39F56604458D5A9B(player, _id_A365E25AA9D7BCDA) {
  if(!_id_E0FC1230452CF4E7())
    return 0;

  if(_id_A365E25AA9D7BCDA.ref == "armor") {
    _id_5332CDA4054641DA = _id_07E5492B68492F80(player, 13);
    return _id_5C55FF785294AD1D() * _id_5332CDA4054641DA;
  } else if(_id_A365E25AA9D7BCDA.ref == "dmz_exfil_personal") {
    _id_5332CDA4054641DA = _id_07E5492B68492F80(player, 11);
    return _id_66F4C5EC2E0BEEE6() * _id_5332CDA4054641DA;
  } else if(_id_A365E25AA9D7BCDA.type == "killstreak") {
    _id_5332CDA4054641DA = _id_07E5492B68492F80(player, 12);
    return _id_956E931113E352A6() * _id_5332CDA4054641DA;
  }
}

_id_1EE6A57E88B1A120(player, _id_85166DA84E55DE25) {
  _id_57838BB4FAE836F8 = undefined;

  switch (_id_85166DA84E55DE25) {
    case "1":
      _id_57838BB4FAE836F8 = 16;
      break;
    case "2":
      _id_57838BB4FAE836F8 = 17;
      break;
    case "3":
      _id_57838BB4FAE836F8 = 18;
      break;
  }

  if(isDefined(_id_57838BB4FAE836F8)) {
    _id_5332CDA4054641DA = _id_07E5492B68492F80(player, _id_57838BB4FAE836F8);
    return _id_5332CDA4054641DA * _id_C826EE21A52E408B();
  } else
    return 0;
}

_id_93F21618E59F6402(player) {
  _id_6F908D78E5AC8E01 = level._id_BF6C149BC4124962;

  if(!_id_E0FC1230452CF4E7())
    return _id_6F908D78E5AC8E01;

  return _id_6F908D78E5AC8E01 + _id_07E5492B68492F80(player, 29);
}

_id_35BD7333660F5D4C(player) {
  _id_51539D5A1AA9B3F9 = _id_07C40FA80892A721::_id_047320A25B8EE003();
  _id_5332CDA4054641DA = _id_93F21618E59F6402(player);
  return min(_id_5332CDA4054641DA, _id_51539D5A1AA9B3F9);
}

_id_AAD5C8B478DF88C4(player) {
  if(!_id_E0FC1230452CF4E7())
    return 0;

  _id_41C6EC89B130DBA2 = _id_93F21618E59F6402(player);
  _id_51539D5A1AA9B3F9 = _id_07C40FA80892A721::_id_047320A25B8EE003();
  return max(0, _id_41C6EC89B130DBA2 - _id_51539D5A1AA9B3F9);
}

_id_59352C09A417A5E2(player, _id_FB6BAFB61D5C3D4A) {
  if(!_id_E0FC1230452CF4E7())
    return 1;

  return _id_07E5492B68492F80(player, _id_FB6BAFB61D5C3D4A) > 0;
}

_id_07E5492B68492F80(player, _id_FB6BAFB61D5C3D4A) {
  if(istrue(_id_758B22811E547EFE()))
    return 1;
  else
    return scripts\engine\utility::_id_53C4C53197386572(player _meth_10ABD3FE15BA02DD(_id_FB6BAFB61D5C3D4A), 0);
}

_id_E860C1BE7FF11F5B(team, _id_FB6BAFB61D5C3D4A) {
  _id_D3D220AE17C9A0BE = 0;
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players) {
    _id_5332CDA4054641DA = _id_07E5492B68492F80(player, _id_FB6BAFB61D5C3D4A);
    _id_D3D220AE17C9A0BE = max(_id_5332CDA4054641DA, _id_D3D220AE17C9A0BE);
  }

  return int(_id_D3D220AE17C9A0BE);
}