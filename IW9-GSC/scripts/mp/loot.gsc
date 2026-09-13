/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\loot.gsc
***********************************************/

init() {
  level.lootweaponcache = [];
  level.lootweaponrefs = [];
  _id_725F93C8F8F7CF9D = getdvarint("dvar_D8D8D08BFD9EC4DF", 30);
  _id_EF5B044960434F17 = getdvarint("dvar_017FE9ACEBDD2352", 5);
  level._id_DE221BFB117F1FD1 = _id_725F93C8F8F7CF9D * _id_725F93C8F8F7CF9D;
  level._id_EF5B044960434F17 = _id_EF5B044960434F17 * _id_EF5B044960434F17;
}

getpassivesforweapon(_id_5C3F9357F11D2223, variantid) {
  _id_60CE74182E7C83A7 = getlootinfoforweapon(_id_5C3F9357F11D2223, variantid);

  if(isDefined(_id_60CE74182E7C83A7))
    return _id_60CE74182E7C83A7.passives;

  return undefined;
}

getlootinfoforweapon(_id_5C3F9357F11D2223, variantid) {
  if(!isDefined(variantid))
    return undefined;

  if(isDefined(level.lootweaponcache[_id_5C3F9357F11D2223]) && isDefined(level.lootweaponcache[_id_5C3F9357F11D2223][variantid])) {
    weaponinfo = level.lootweaponcache[_id_5C3F9357F11D2223][variantid];
    return weaponinfo;
  }

  weaponinfo = cachelootweaponweaponinfo(_id_5C3F9357F11D2223, variantid);

  if(isDefined(weaponinfo))
    return weaponinfo;

  return undefined;
}

getweaponassetfromrootweapon(_id_CD13663AEE778DB6, variantid) {
  _id_6CF67C6D17CF3316 = "mp/loot/weapon/" + _id_CD13663AEE778DB6 + ".csv";
  weaponasset = tablelookup(_id_6CF67C6D17CF3316, 0, variantid, 3);
  return weaponasset;
}

lookupvariantref(_id_CD13663AEE778DB6, variantid) {
  _id_6CF67C6D17CF3316 = "mp/loot/weapon/" + _id_CD13663AEE778DB6 + ".csv";
  _id_093B3002EBEF628B = tablelookup(_id_6CF67C6D17CF3316, 0, variantid, 1);
  return _id_093B3002EBEF628B;
}

isweaponitem(_id_358E8D9068997399) {
  itemtype = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(_id_358E8D9068997399);
  return isDefined(itemtype) && itemtype == "weapon";
}

cachelootweaponweaponinfo(_id_5C3F9357F11D2223, variantid) {
  if(!isDefined(_id_5C3F9357F11D2223))
    return undefined;

  if(!isDefined(level.lootweaponcache[_id_5C3F9357F11D2223]))
    level.lootweaponcache[_id_5C3F9357F11D2223] = [];

  _id_0C6C779C138E8C65 = getweaponloottable(_id_5C3F9357F11D2223);
  weaponinfo = readweaponinfofromtable(_id_0C6C779C138E8C65, variantid, _id_5C3F9357F11D2223);
  level.lootweaponcache[_id_5C3F9357F11D2223][variantid] = weaponinfo;
  return weaponinfo;
}

readweaponinfofromtable(_id_0B2F2B716DA5389C, variantid, _id_5C3F9357F11D2223) {
  struct = spawnStruct();
  _id_4BB9768282D4260D = _id_2669878CF5A1B6BC::getweaponrootname(_id_5C3F9357F11D2223);
  ref = _id_4BB9768282D4260D + "|" + variantid;
  struct.ref = ref;
  struct.weaponasset = level.weaponlootmapdata[ref].assetname;
  struct.variantid = variantid;
  return struct;
}

getweaponqualitybyid(weapon, variantid) {
  if(!isDefined(variantid) || variantid < 0)
    return 0;

  _id_0C6C779C138E8C65 = getweaponloottable(weapon);
  quality = int(tablelookup(_id_0C6C779C138E8C65, 0, variantid, 4));
  return quality;
}

_id_381163B13DA57799(opener, _id_69E96A4CAA72D794, _id_3793828403C6873E, _id_9B0656C2ED2321CF) {
  contents = scripts\engine\utility::ter_op(isDefined(_id_9B0656C2ED2321CF), _id_9B0656C2ED2321CF, _id_69E96A4CAA72D794.contents);

  if(!isDefined(contents[_id_3793828403C6873E]))
    return 0;

  item = contents[_id_3793828403C6873E];
  quantity = item["quantity"];
  lootid = item["lootID"];
  team = item["team"];
  _id_FAFCDAA6B732231A = item["visibilityCondition"];

  if(isDefined(quantity) && quantity > 0 && isDefined(lootid) && lootid > 0 && (!isDefined(team) || team == opener.team) && (!isDefined(_id_FAFCDAA6B732231A) || [[_id_FAFCDAA6B732231A]](opener, _id_69E96A4CAA72D794)))
    return 1;

  return 0;
}

_id_44AB83CC979E1217(opener, _id_69E96A4CAA72D794, _id_3793828403C6873E) {
  if(!isDefined(_id_69E96A4CAA72D794._id_BF23A60678978C19[_id_3793828403C6873E]))
    return 0;

  item = _id_69E96A4CAA72D794._id_BF23A60678978C19[_id_3793828403C6873E];
  quantity = item["quantity"];
  lootid = item["lootID"];
  team = item["team"];
  _id_FAFCDAA6B732231A = item["visibilityCondition"];

  if(isDefined(quantity) && quantity > 0 && isDefined(lootid) && lootid > 0 && (!isDefined(team) || team == opener.team) && (!isDefined(_id_FAFCDAA6B732231A) || [[_id_FAFCDAA6B732231A]](opener, _id_69E96A4CAA72D794)))
    return 1;

  return 0;
}

_id_2581F2AB21309779(_id_69E96A4CAA72D794) {
  if(!isDefined(_id_69E96A4CAA72D794._id_46A3A8565AC0C17C))
    return 1;

  switch (_id_69E96A4CAA72D794._id_46A3A8565AC0C17C) {
    case 15:
    case 14:
    case 13:
      return 0;
    default:
      return 1;
  }
}

_id_61C51BD9656A843D(opener, _id_69E96A4CAA72D794, _id_FAB72763A744C649) {
  _id_BF23A60678978C19 = _id_69E96A4CAA72D794._id_BF23A60678978C19;

  if(!isDefined(_id_FAB72763A744C649))
    _id_FAB72763A744C649 = [];

  if(!isDefined(_id_69E96A4CAA72D794._id_3AADF7A3CC811358))
    _id_69E96A4CAA72D794._id_3AADF7A3CC811358 = [];

  if(isDefined(_id_BF23A60678978C19)) {
    foreach(_id_3793828403C6873E, item in _id_BF23A60678978C19) {
      lootid = 0;
      quantity = 0;

      if(isDefined(item["lootID"])) {
        lootid = item["lootID"];
        quantity = item["quantity"];
      }

      if(lootid == 0 || quantity == 0) {
        continue;
      }
      _id_A28BD7F30254C8A0 = _id_9514E33EEB6EEA69(opener, lootid, quantity);

      if(_id_A28BD7F30254C8A0 != quantity) {
        _id_A0D21FDD38F60ECF = _id_FAB72763A744C649.size;
        _id_FAB72763A744C649[_id_A0D21FDD38F60ECF] = spawnStruct();
        _id_FAB72763A744C649[_id_A0D21FDD38F60ECF].index = _id_3793828403C6873E + 11;
        _id_FAB72763A744C649[_id_A0D21FDD38F60ECF]._id_C79D6D2F755EB27E = quantity;
        _id_FAB72763A744C649[_id_A0D21FDD38F60ECF].lootid = lootid;
        _id_69E96A4CAA72D794._id_3AADF7A3CC811358[_id_A0D21FDD38F60ECF] = _id_3793828403C6873E;
      }
    }
  }

  return _id_FAB72763A744C649;
}

_id_9514E33EEB6EEA69(opener, lootid, quantity) {
  _id_A1093166DE09E6B8 = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

  if(!isDefined(_id_A1093166DE09E6B8))
    return quantity;

  maxcount = level.br_pickups._id_04138F9DDC1CD22D[_id_A1093166DE09E6B8];

  if(!isDefined(maxcount) || maxcount == 0)
    maxcount = level.br_pickups.maxcounts[_id_A1093166DE09E6B8];

  if(maxcount > 0 && isDefined(lootid)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2D9D24F7C63AC143::_id_B13E35608B336D65(opener); _id_AC0E594AC96AA3A8++) {
      _id_EEEAE9DEFA0C1E95 = opener _id_2D9D24F7C63AC143::_id_6196D9EA9A30E609(_id_AC0E594AC96AA3A8);

      if(_id_EEEAE9DEFA0C1E95 == lootid) {
        _id_E30B916ADC1E2DC8 = opener _id_2D9D24F7C63AC143::_id_897B29ADB37F06A7(_id_AC0E594AC96AA3A8);

        if(_id_E30B916ADC1E2DC8 < maxcount)
          return int(max(0, _id_E30B916ADC1E2DC8 + quantity - maxcount));
      }
    }
  }

  if(_id_2CEDCC356F1B9FC8::isammo(_id_A1093166DE09E6B8)) {
    _id_509D86412C9D7426 = opener getweaponslistprimaries();

    foreach(_id_DE88CD14114C1E24 in _id_509D86412C9D7426) {
      _id_7CAC4FF8E11F1BCA = _id_724736FCF0FB6604::br_ammo_type_for_weapon(_id_DE88CD14114C1E24);

      if(isDefined(_id_7CAC4FF8E11F1BCA) && _id_A1093166DE09E6B8 == _id_7CAC4FF8E11F1BCA && opener.br_ammo[_id_A1093166DE09E6B8] < level._id_E6EA72FC5E3FCD00[_id_A1093166DE09E6B8])
        return int(max(0, opener.br_ammo[_id_A1093166DE09E6B8] + quantity - level._id_E6EA72FC5E3FCD00[_id_A1093166DE09E6B8]));
    }
  }

  if(_id_2CEDCC356F1B9FC8::isarmorplate(_id_A1093166DE09E6B8)) {
    equipname = level.br_pickups.br_equipname[_id_A1093166DE09E6B8];
    slot = level.equipment.table[equipname].defaultslot;

    if(!isDefined(opener.equipment[slot]) || opener _id_7E52B56769FA7774::equipmentslothasroom(_id_A1093166DE09E6B8, slot)) {
      _id_5324597EDFAFF57C = opener scripts\mp\equipment::getequipmentslotammo(slot);
      _id_5324597EDFAFF57C = scripts\engine\utility::ter_op(isDefined(_id_5324597EDFAFF57C), _id_5324597EDFAFF57C, 0);
      _id_B5CDF4D935E6AC13 = opener scripts\mp\equipment::getequipmentmaxammo(equipname);
      return int(max(0, _id_5324597EDFAFF57C + quantity - _id_B5CDF4D935E6AC13));
    }
  }

  if(_id_7E52B56769FA7774::_id_B989EDD9AF4F42C7(_id_A1093166DE09E6B8) || _id_7E52B56769FA7774::_id_D7C5786A0C42EF6C(_id_A1093166DE09E6B8)) {
    equipname = level.br_pickups.br_equipname[_id_A1093166DE09E6B8];
    slot = level.equipment.table[equipname].defaultslot;

    if(opener _id_7E52B56769FA7774::pickupissameasequipmentslot(equipname, slot) && opener _id_7E52B56769FA7774::equipmentslothasroom(_id_A1093166DE09E6B8, slot)) {
      _id_5324597EDFAFF57C = opener scripts\mp\equipment::getequipmentslotammo(slot);
      _id_5324597EDFAFF57C = scripts\engine\utility::ter_op(isDefined(_id_5324597EDFAFF57C), _id_5324597EDFAFF57C, 0);
      _id_B5CDF4D935E6AC13 = opener scripts\mp\equipment::getequipmentmaxammo(equipname);
      return int(max(0, _id_5324597EDFAFF57C + quantity - _id_B5CDF4D935E6AC13));
    }
  }

  if(_id_7E52B56769FA7774::isplunder(_id_A1093166DE09E6B8)) {
    if(isDefined(opener.plundercount) && isDefined(level.br_plunder.plunderlimit) && opener.plundercount >= level.br_plunder.plunderlimit)
      return quantity;

    _id_7EDDF19F11DA2F94 = scripts\engine\utility::_id_53C4C53197386572(opener.plundercount, 0);
    maxplunder = scripts\engine\utility::_id_53C4C53197386572(level.br_plunder.plunderlimit, _id_7EDDF19F11DA2F94 + quantity);
    return int(max(0, _id_7EDDF19F11DA2F94 + quantity - maxplunder));
  }

  return quantity;
}

_id_57C0F59F64F553FA(opener, _id_69E96A4CAA72D794, items, _id_6064FB4B46498174) {
  opener endon("death_or_disconnect");
  opener endon("enter_live_ragdoll");
  _id_69E96A4CAA72D794 endon("closed");
  level endon("game_ended");
  waittime = 0.55;
  _id_E88566CF37C5687E = getdvarfloat("dvar_D9E519D9C89AF2F3", 0.0);

  if(_id_E88566CF37C5687E > 0.0)
    waittime = _id_E88566CF37C5687E + 0.2;

  _id_677B4D98122F0868 = getdvarfloat("dvar_12B0E0C79CCF572D", 0.0);

  if(_id_677B4D98122F0868 > 0.0) {
    waittime = 0.35 + _id_677B4D98122F0868;

    if(_id_E88566CF37C5687E > 0.0)
      waittime = _id_E88566CF37C5687E + _id_677B4D98122F0868;
  }

  _id_ED396A07B4C75932 = getdvarint("dvar_AB7929439577C576", 1);
  wait(waittime);

  foreach(item in items) {
    if(!scripts\mp\utility\player::isreallyalive(opener) || !_id_6F45E7311F77EAC4(opener) || _id_23A3BB1172216C05(_id_69E96A4CAA72D794, opener)) {
      if(isDefined(_id_69E96A4CAA72D794._id_73FB94C9AEDCC497))
        _id_69E96A4CAA72D794._id_73FB94C9AEDCC497 = [];

      if(isDefined(_id_69E96A4CAA72D794._id_3AADF7A3CC811358))
        _id_69E96A4CAA72D794._id_3AADF7A3CC811358 = [];

      return;
    }

    if(!isDefined(item) || !isDefined(item.lootid) || !isDefined(item._id_C79D6D2F755EB27E) || !isDefined(item.index)) {
      continue;
    }
    if(!_id_7EDA25C90CC3AAA1(item.index) && !_id_381163B13DA57799(opener, _id_69E96A4CAA72D794, item.index)) {
      continue;
    }
    if(_id_7EDA25C90CC3AAA1(item.index) && !_id_44AB83CC979E1217(opener, _id_69E96A4CAA72D794, item.index - 11)) {
      continue;
    }
    _id_34D6E1AC2BBEFABD = 0;

    if(isDefined(_id_69E96A4CAA72D794.contents)) {
      foreach(_id_C56207BDA09B3A36 in _id_69E96A4CAA72D794.contents) {
        if(_id_7EDA25C90CC3AAA1(item.index)) {
          break;
        }

        _id_EEEAE9DEFA0C1E95 = _id_C56207BDA09B3A36["lootID"];

        if(isDefined(_id_EEEAE9DEFA0C1E95) && _id_EEEAE9DEFA0C1E95 == item.lootid) {
          quantity = _id_C56207BDA09B3A36["quantity"];
          _id_A28BD7F30254C8A0 = _id_9514E33EEB6EEA69(opener, item.lootid, quantity);

          if(quantity != _id_A28BD7F30254C8A0) {
            _id_34D6E1AC2BBEFABD = 1;
            _id_9D924AEA120C2693(opener, item.index, _id_69E96A4CAA72D794);
            _id_97C23A1323ACC7DF = quantity - _id_A28BD7F30254C8A0;

            if(_id_97C23A1323ACC7DF < 0) {
              continue;
            }
            _id_2F00CA0526F3EDC6(opener, item.index, _id_97C23A1323ACC7DF, _id_6064FB4B46498174, 1);

            if(isDefined(_id_69E96A4CAA72D794) && _id_23A3BB1172216C05(_id_69E96A4CAA72D794, opener) && _id_6F45E7311F77EAC4(opener))
              _id_68085C72D7B628EC(_id_69E96A4CAA72D794, opener);

            if(!_id_ED396A07B4C75932)
              wait(getdvarfloat("dvar_F920B46A5250C2A9", 0.33));
          }
        }
      }
    }

    if(_id_7EDA25C90CC3AAA1(item.index) && isDefined(_id_69E96A4CAA72D794._id_BF23A60678978C19)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_69E96A4CAA72D794._id_BF23A60678978C19.size; _id_AC0E594AC96AA3A8++) {
        if(!isDefined(_id_69E96A4CAA72D794._id_BF23A60678978C19[_id_AC0E594AC96AA3A8])) {
          continue;
        }
        _id_EEEAE9DEFA0C1E95 = _id_69E96A4CAA72D794._id_BF23A60678978C19[_id_AC0E594AC96AA3A8]["lootID"];

        if(isDefined(_id_EEEAE9DEFA0C1E95) && _id_EEEAE9DEFA0C1E95 == item.lootid) {
          quantity = _id_69E96A4CAA72D794._id_BF23A60678978C19[_id_AC0E594AC96AA3A8]["quantity"];
          _id_A28BD7F30254C8A0 = _id_9514E33EEB6EEA69(opener, item.lootid, quantity);

          if(quantity != _id_A28BD7F30254C8A0) {
            _id_34D6E1AC2BBEFABD = 1;
            _id_9D924AEA120C2693(opener, item.index, _id_69E96A4CAA72D794);
            _id_97C23A1323ACC7DF = quantity - _id_A28BD7F30254C8A0;
            _id_2F00CA0526F3EDC6(opener, item.index, _id_97C23A1323ACC7DF, _id_6064FB4B46498174, 1);

            if(isDefined(_id_69E96A4CAA72D794) && _id_23A3BB1172216C05(_id_69E96A4CAA72D794, opener) && _id_6F45E7311F77EAC4(opener))
              _id_68085C72D7B628EC(_id_69E96A4CAA72D794, opener);

            if(!_id_ED396A07B4C75932)
              wait(getdvarfloat("dvar_F920B46A5250C2A9", 0.33));
          }
        }
      }
    }

    if(_id_34D6E1AC2BBEFABD && _id_ED396A07B4C75932)
      wait(getdvarfloat("dvar_F920B46A5250C2A9", 0.33));
  }

  if(isDefined(_id_69E96A4CAA72D794._id_73FB94C9AEDCC497))
    _id_69E96A4CAA72D794._id_73FB94C9AEDCC497 = [];

  if(isDefined(_id_69E96A4CAA72D794._id_3AADF7A3CC811358))
    _id_69E96A4CAA72D794._id_3AADF7A3CC811358 = [];
}

getlootweaponref(_id_358E8D9068997399) {
  return level.lootweaponrefs[_id_358E8D9068997399];
}

_id_03A712642B82F6F2(scriptablename) {
  if(!isDefined(scriptablename))
    return 8;

  if(_id_7E52B56769FA7774::isrevivepickup(scriptablename))
    return 0;

  if(_id_7E52B56769FA7774::iskillstreak(scriptablename))
    return 1;

  if(_id_2CEDCC356F1B9FC8::isarmorplate(scriptablename))
    return 2;

  if(_id_2CEDCC356F1B9FC8::_id_4AA12E0ED3F6B745(scriptablename))
    return 3;

  if(_id_7E52B56769FA7774::_id_B1E944A2B3E15E9D(scriptablename))
    return 4;

  if(_id_7E52B56769FA7774::issuperpickup(scriptablename))
    return 5;

  if(_id_2CEDCC356F1B9FC8::isequipment(scriptablename))
    return 6;

  if(_id_2CEDCC356F1B9FC8::isammo(scriptablename))
    return 7;

  return 8;
}

_id_C01727794CD72A1C(_id_BF2C7BA7126C84F1, _id_BF2C78A7126C7E58) {
  if(!isDefined(_id_BF2C7BA7126C84F1) || !isDefined(_id_BF2C78A7126C7E58))
    return 1;

  if(!istrue(_id_BF2C7BA7126C84F1["lootID"]) || !istrue(_id_BF2C78A7126C7E58["lootID"]) || !istrue(_id_BF2C7BA7126C84F1["quantity"]) || !istrue(_id_BF2C78A7126C7E58["quantity"]))
    return 1;

  _id_D9FC4B7DC88A5BBC = _id_03A712642B82F6F2(_id_600B944A95C3A7BF::_id_E1D5A33193DB0133(_id_BF2C7BA7126C84F1["lootID"]));
  _id_D9FC4E7DC88A6255 = _id_03A712642B82F6F2(_id_600B944A95C3A7BF::_id_E1D5A33193DB0133(_id_BF2C78A7126C7E58["lootID"]));
  return _id_D9FC4B7DC88A5BBC < _id_D9FC4E7DC88A6255;
}

_id_30F5EA60517F9E06(opener, _id_69E96A4CAA72D794) {
  _id_6064FB4B46498174 = _id_69E96A4CAA72D794;

  if(_id_E3081772BBF7A51C(opener, _id_69E96A4CAA72D794)) {
    _id_6064FB4B46498174 = _id_69E96A4CAA72D794;
    _id_69E96A4CAA72D794 = _id_3AAE4431F00C347F(opener, _id_69E96A4CAA72D794);
    _id_69E96A4CAA72D794.origin = _id_6064FB4B46498174.origin;
    _id_69E96A4CAA72D794.angles = _id_6064FB4B46498174.angles;
  }

  if(_id_54066DBD8EF44FE1(_id_69E96A4CAA72D794) && getdvarint("dvar_0AB065F0DA94D8FF", 1)) {
    [items, _id_77DC0A100921C5A7] = _id_0438749EB7A7B738(_id_69E96A4CAA72D794.contents, opener, _id_69E96A4CAA72D794);
    _id_69E96A4CAA72D794.contents = items;
    _id_69E96A4CAA72D794.contents = scripts\engine\utility::array_sort_with_func(_id_69E96A4CAA72D794.contents, ::_id_C01727794CD72A1C);
  }

  _id_BFBB389447A5262C = 0;

  for(_id_3793828403C6873E = 0; _id_3793828403C6873E < 11; _id_3793828403C6873E++) {
    if(_id_381163B13DA57799(opener, _id_69E96A4CAA72D794, _id_3793828403C6873E)) {
      if(isweaponitem(_id_69E96A4CAA72D794.contents[_id_3793828403C6873E]["lootID"])) {
        _id_E97B68032A8F5332 = _id_69E96A4CAA72D794.contents[_id_BFBB389447A5262C];
        _id_69E96A4CAA72D794.contents[_id_BFBB389447A5262C] = _id_69E96A4CAA72D794.contents[_id_3793828403C6873E];
        _id_69E96A4CAA72D794.contents[_id_3793828403C6873E] = _id_E97B68032A8F5332;
        _id_BFBB389447A5262C++;
      }
    }
  }

  items = _id_69E96A4CAA72D794.contents;
  opener._id_02FA5B49969DEF47 = _id_6064FB4B46498174;
  opener._id_F2AA9AE949179907 = opener.origin;
  _id_6064FB4B46498174.opener = opener;

  if(isPlayer(opener))
    opener _id_41E759DE50F883DC(items, _id_6064FB4B46498174._id_46A3A8565AC0C17C);

  if(isDefined(_id_69E96A4CAA72D794._id_BF8E5F003146AF44))
    opener._id_F2AA9AE949179907 = rotatevectorinverted(opener.origin - _id_6064FB4B46498174._id_BF8E5F003146AF44.origin, _id_6064FB4B46498174._id_BF8E5F003146AF44.angles);

  if(items.size > 11) {}

  _id_FAB72763A744C649 = [];
  _id_4472B62C1FA150E5 = 0;
  _id_69E96A4CAA72D794._id_73FB94C9AEDCC497 = [];

  for(_id_3793828403C6873E = 0; _id_3793828403C6873E < 11; _id_3793828403C6873E++) {
    if(_id_381163B13DA57799(opener, _id_69E96A4CAA72D794, _id_3793828403C6873E)) {
      _id_A28BD7F30254C8A0 = items[_id_3793828403C6873E]["quantity"];

      if(getdvarint("dvar_C272DFD858EBA88F", 1) && _id_2581F2AB21309779(_id_6064FB4B46498174))
        _id_A28BD7F30254C8A0 = _id_9514E33EEB6EEA69(opener, items[_id_3793828403C6873E]["lootID"], items[_id_3793828403C6873E]["quantity"]);

      _id_446C7AD7BCC70992(opener, _id_69E96A4CAA72D794, _id_3793828403C6873E, items[_id_3793828403C6873E]["lootID"], items[_id_3793828403C6873E]["quantity"], items[_id_3793828403C6873E]["ref"]);

      if(_id_A28BD7F30254C8A0 != items[_id_3793828403C6873E]["quantity"]) {
        _id_A0D21FDD38F60ECF = _id_FAB72763A744C649.size;
        _id_FAB72763A744C649[_id_A0D21FDD38F60ECF] = spawnStruct();
        _id_FAB72763A744C649[_id_A0D21FDD38F60ECF].index = _id_3793828403C6873E;
        _id_FAB72763A744C649[_id_A0D21FDD38F60ECF]._id_C79D6D2F755EB27E = items[_id_3793828403C6873E]["quantity"];
        _id_FAB72763A744C649[_id_A0D21FDD38F60ECF].lootid = items[_id_3793828403C6873E]["lootID"];

        if(!opener _meth_B73431B8E7AE9204())
          _id_69E96A4CAA72D794._id_73FB94C9AEDCC497[_id_A0D21FDD38F60ECF] = _id_3793828403C6873E;
      }

      if(!_id_4472B62C1FA150E5) {
        scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(items[_id_3793828403C6873E]["lootID"]);

        if(isDefined(scriptablename))
          _id_4472B62C1FA150E5 = _id_2CEDCC356F1B9FC8::_id_63D8455B2C1455EB(scriptablename);
      }

      continue;
    }

    _id_C7294F5B9B5006D5(opener, _id_3793828403C6873E);
  }

  if(isDefined(_id_69E96A4CAA72D794._id_04F6CDE716E0C3D7))
    _id_62AD0C002D54CBCC(opener, _id_69E96A4CAA72D794, "loot_container_weapon", _id_69E96A4CAA72D794._id_04F6CDE716E0C3D7, _id_69E96A4CAA72D794._id_6FB67C8525B1D79E);
  else
    opener setclientomnvar("loot_container_weapon", 0);

  if(!isDefined(_id_6064FB4B46498174._id_46A3A8565AC0C17C))
    _id_6064FB4B46498174._id_46A3A8565AC0C17C = 1;

  _id_46A3A8565AC0C17C = _id_6064FB4B46498174._id_46A3A8565AC0C17C;

  if(_id_46A3A8565AC0C17C == 6) {
    if(isDefined(_id_6064FB4B46498174.owner) && isDefined(_id_6064FB4B46498174.owner.team) && isDefined(opener.team) && _id_6064FB4B46498174.owner.team == opener.team && isDefined(_id_6064FB4B46498174.owner._id_3F78C6A0862F9E25))
      _id_46A3A8565AC0C17C = 7 + _id_6064FB4B46498174.owner._id_3F78C6A0862F9E25;

    if(isDefined(_id_6064FB4B46498174._id_846A20D8E6F30B8E))
      opener setclientomnvar("loot_container_dead_player_index", _id_6064FB4B46498174._id_846A20D8E6F30B8E);
  }

  if(_id_54066DBD8EF44FE1(_id_6064FB4B46498174)) {
    owner = _id_6064FB4B46498174.owner;

    if(isDefined(_id_6064FB4B46498174._id_846A20D8E6F30B8E))
      opener setclientomnvar("loot_container_dead_player_index", _id_6064FB4B46498174._id_846A20D8E6F30B8E);

    if(isDefined(_id_6064FB4B46498174._id_342175A1B9F9067E))
      opener setclientomnvar("loot_container_dead_player_backpack_size", _id_6064FB4B46498174._id_342175A1B9F9067E);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("dmz_bosses", "onBackpackOpen"))
      opener[[scripts\cp_mp\utility\script_utility::getsharedfunc("dmz_bosses", "onBackpackOpen")]](_id_6064FB4B46498174);

    _id_FAB72763A744C649 = _id_61C51BD9656A843D(opener, _id_69E96A4CAA72D794, _id_FAB72763A744C649);
    _id_46BF6F4D9DCC9B78(opener, _id_69E96A4CAA72D794);
  }

  if(_id_FAB72763A744C649.size > 0 && !opener _meth_B73431B8E7AE9204())
    thread _id_57C0F59F64F553FA(opener, _id_69E96A4CAA72D794, _id_FAB72763A744C649, _id_6064FB4B46498174);

  opener setclientomnvar("loot_container_open", _id_46A3A8565AC0C17C);

  if(istrue(level._id_A101059DEA76957C) && !istrue(_id_6064FB4B46498174._id_4E6E38A1603F22EE) && _id_6064FB4B46498174._id_46A3A8565AC0C17C != 13 && _id_6064FB4B46498174._id_46A3A8565AC0C17C != 15 && !_id_54066DBD8EF44FE1(_id_6064FB4B46498174)) {
    _id_6064FB4B46498174._id_4E6E38A1603F22EE = 1;

    if(!isDefined(opener._id_79C8F592B7C3C2D6))
      opener._id_79C8F592B7C3C2D6 = 0;

    opener._id_79C8F592B7C3C2D6++;
    thread _id_86D77B1DBD44B06E(opener, _id_6064FB4B46498174, _id_4472B62C1FA150E5);
  }

  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  _id_6064FB4B46498174.dropstruct = dropstruct;

  if(opener _meth_B73431B8E7AE9204())
    _id_69E96A4CAA72D794 thread _id_576B46DBF8366FE3(_id_69E96A4CAA72D794, opener, _id_FAB72763A744C649, _id_6064FB4B46498174);

  _id_6064FB4B46498174 thread _id_71A59F067D5FE986(_id_6064FB4B46498174, opener);
  _id_6064FB4B46498174 thread _id_47B931D76FFD028F(_id_6064FB4B46498174, opener);

  if(_id_E3081772BBF7A51C(opener, _id_69E96A4CAA72D794))
    _id_69E96A4CAA72D794._id_556DB0B72A96514E[opener.guid].contents = items;

  opener scripts\cp_mp\calloutmarkerping::_id_FAA3CBEC7243FE72();
}

_id_41E759DE50F883DC(items, _id_FA77CD787F3091D9) {
  if(!isDefined(items)) {
    return;
  }
  if(!isDefined(items.size) || items.size <= 0) {
    return;
  }
  _id_5A0FC1D304E970EA = "unset";

  if(isDefined(self.sessionteam))
    _id_5A0FC1D304E970EA = self.sessionteam;

  if(isDefined(self.team))
    _id_5A0FC1D304E970EA = self.team;

  _id_9C02E895E4DBDC3B = "0";

  if(isDefined(level._id_A7B62649C81B481A) && isDefined(level._id_A7B62649C81B481A._id_ACC161DE36707DE2))
    _id_9C02E895E4DBDC3B = scripts\engine\utility::string(level._id_A7B62649C81B481A._id_ACC161DE36707DE2);

  _id_9846F3DA68A7D5BC = [];
  _id_CF765966D1EE56D6 = [];

  foreach(item in items) {
    _id_CF765966D1EE56D6[_id_9846F3DA68A7D5BC.size] = scripts\engine\utility::string(item["quantity"]);
    _id_9846F3DA68A7D5BC[_id_9846F3DA68A7D5BC.size] = scripts\engine\utility::string(item["lootID"]);
  }

  data = spawnStruct();
  data.player = self;
  data._id_5A0FC1D304E970EA = _id_5A0FC1D304E970EA;
  data.x = self.origin[0];
  data.y = self.origin[1];
  data.z = self.origin[2];
  data._id_6437FC57F57C9AD8 = self.angles[0];
  data._id_FE76A03A13318315 = self.angles[1];
  data._id_868460883D5CE6A2 = self.angles[2];
  data._id_9C02E895E4DBDC3B = _id_9C02E895E4DBDC3B;
  data._id_C983D3ABB7EC13D9 = int(scripts\mp\utility\game::getsecondspassed());
  data._id_9846F3DA68A7D5BC = _id_9846F3DA68A7D5BC;
  data._id_CF765966D1EE56D6 = _id_CF765966D1EE56D6;
  data._id_FA77CD787F3091D9 = _id_FA77CD787F3091D9;
  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_dmz_on_container", data);
}

_id_576B46DBF8366FE3(_id_69E96A4CAA72D794, opener, _id_FAB72763A744C649, _id_6064FB4B46498174) {
  opener endon("death_or_disconnect");
  opener endon("enter_live_ragdoll");
  _id_69E96A4CAA72D794 endon("closed");
  level endon("game_ended");
  _id_98125A9AD5CDA4F2 = 0.5;
  _id_77242E1F9173BC1C = 0.2;
  currentindex = 0;
  wait(_id_98125A9AD5CDA4F2);

  while(opener activatekeypressed() && _id_6F45E7311F77EAC4(opener) && currentindex < 11 && scripts\mp\utility\player::isreallyalive(opener) && !_id_23A3BB1172216C05(_id_69E96A4CAA72D794, opener)) {
    if(_id_381163B13DA57799(opener, _id_69E96A4CAA72D794, currentindex)) {
      scriptablename = opener _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(_id_69E96A4CAA72D794.contents[currentindex]["lootID"]);
      _id_25978461C6E4F61B = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(_id_69E96A4CAA72D794.contents[currentindex]["lootID"]);
      _id_FE539E37B6579930 = 0;
      _id_20E37EE1B2F4E448 = 0;
      _id_5FA12DC278A8F1BA = 0;

      if(_id_7E52B56769FA7774::_id_B989EDD9AF4F42C7(scriptablename) || _id_7E52B56769FA7774::_id_D7C5786A0C42EF6C(scriptablename)) {
        equipname = level.br_pickups.br_equipname[scriptablename];
        slot = level.equipment.table[equipname].defaultslot;

        if(opener _id_7E52B56769FA7774::pickupissameasequipmentslot(equipname, slot)) {
          if(opener _id_7E52B56769FA7774::equipmentslothasroom(scriptablename, slot))
            _id_FE539E37B6579930 = 1;
        } else if(!isDefined(opener scripts\mp\equipment::getcurrentequipment(slot)) || opener scripts\mp\equipment::getequipmentslotammo(slot) == 0)
          _id_FE539E37B6579930 = 1;
      } else if(_id_7E52B56769FA7774::isweaponpickup(scriptablename)) {
        _id_5FA12DC278A8F1BA = 1;

        foreach(weaponobj in opener.primaryinventory) {
          if(weaponobj.basename == "iw9_me_fists_mp") {
            _id_FE539E37B6579930 = 1;
            break;
          }
        }

        if(!_id_FE539E37B6579930 && !_id_2D9D24F7C63AC143::_id_EFAB78B72D131D76(opener) && _id_2D9D24F7C63AC143::_id_B13E35608B336D65(opener) >= 7)
          _id_20E37EE1B2F4E448 = 1;
      } else if(_id_2CEDCC356F1B9FC8::_id_4AA12E0ED3F6B745(scriptablename)) {
        _id_0556946700794BB3 = _id_2CEDCC356F1B9FC8::_id_692C3DF266580DF6(scriptablename);

        if(_id_0556946700794BB3 > opener._id_BED158A6DFAC230D)
          _id_FE539E37B6579930 = 1;
      } else if(_id_2CEDCC356F1B9FC8::isarmorplate(scriptablename))
        _id_FE539E37B6579930 = 1;
      else if(_id_7E52B56769FA7774::iskillstreak(scriptablename)) {
        if(!opener _id_7E52B56769FA7774::hasanykillstreak())
          _id_FE539E37B6579930 = 1;
      } else if(_id_7E52B56769FA7774::isgasmask(scriptablename)) {
        if(!isDefined(opener.gasmaskhealth))
          _id_FE539E37B6579930 = 1;
      } else if(_id_7E52B56769FA7774::_id_B1E944A2B3E15E9D(scriptablename)) {
        _id_CCC0DF5641A7616B = _id_2D9D24F7C63AC143::_id_B13E35608B336D65(opener);
        _id_D5AF812B9411DCC4 = _id_2D9D24F7C63AC143::_id_3188D9C94B3D56C2(scriptablename);

        if(_id_CCC0DF5641A7616B < _id_D5AF812B9411DCC4)
          _id_FE539E37B6579930 = 1;
      } else if(_id_7E52B56769FA7774::isrevivepickup(scriptablename)) {
        if(!opener _id_2CEDCC356F1B9FC8::hasselfrevivetoken())
          _id_FE539E37B6579930 = 1;
      } else if(_id_7E52B56769FA7774::issuperpickup(scriptablename)) {
        if(!opener _id_2D9D24F7C63AC143::_id_5E7049647595AB97())
          _id_FE539E37B6579930 = 1;
      }

      if(_id_25978461C6E4F61B == "cash") {
        _id_9D924AEA120C2693(opener, currentindex, _id_69E96A4CAA72D794);
        _id_2F00CA0526F3EDC6(opener, currentindex, _id_69E96A4CAA72D794.contents[currentindex]["quantity"], _id_69E96A4CAA72D794, 1);
        wait(_id_77242E1F9173BC1C);
      } else if(_id_FE539E37B6579930) {
        opener _id_3AE3712FE76D0C6A(opener, currentindex, 0, _id_69E96A4CAA72D794);
        wait(_id_77242E1F9173BC1C);
      } else if(_id_20E37EE1B2F4E448) {
        opener _id_F0617AD70B7E7792(0, 100, _id_69E96A4CAA72D794);
        wait(_id_77242E1F9173BC1C);
      } else if(!_id_5FA12DC278A8F1BA && (_id_2CEDCC356F1B9FC8::isammo(scriptablename) || opener _id_2D9D24F7C63AC143::_id_3D7E44B7E940DE24(_id_69E96A4CAA72D794.contents[currentindex]["lootID"], _id_69E96A4CAA72D794.contents[currentindex]["quantity"]))) {
        opener _id_601D9AFC257AF3FF(opener, currentindex, _id_69E96A4CAA72D794);
        wait(_id_77242E1F9173BC1C);
      }
    }

    currentindex++;
  }

  if(_id_FAB72763A744C649.size > 0 && currentindex < 11 && _id_6F45E7311F77EAC4(opener))
    thread _id_57C0F59F64F553FA(opener, _id_69E96A4CAA72D794, _id_FAB72763A744C649, _id_6064FB4B46498174);
  else if(isDefined(_id_69E96A4CAA72D794) && _id_23A3BB1172216C05(_id_69E96A4CAA72D794, opener) && _id_6F45E7311F77EAC4(opener))
    _id_68085C72D7B628EC(_id_69E96A4CAA72D794, opener);
}

_id_0438749EB7A7B738(items, opener, _id_69E96A4CAA72D794) {
  _id_542AB2415C42E657 = [];
  _id_47868F432C8FCB6B = 0;
  lastindex = items.size - 1;

  foreach(item in items) {
    quantity = item["quantity"];
    lootid = item["lootID"];
    team = item["team"];
    _id_FAFCDAA6B732231A = item["visibilityCondition"];

    if(isDefined(quantity) && quantity > 0 && isDefined(lootid) && lootid > 0 && (!isDefined(team) || team == opener.team) && (!isDefined(_id_FAFCDAA6B732231A) || [[_id_FAFCDAA6B732231A]](opener, _id_69E96A4CAA72D794))) {
      _id_542AB2415C42E657[_id_47868F432C8FCB6B] = item;
      _id_47868F432C8FCB6B++;
      continue;
    }

    _id_542AB2415C42E657[lastindex] = item;
    lastindex--;
  }

  return [_id_542AB2415C42E657, lastindex];
}

_id_C7294F5B9B5006D5(player, index) {
  player setclientomnvar("loot_container_item_" + index, 0);
  player setclientomnvar("loot_container_quantity_" + index, 0);
  player setclientomnvar("loot_container_type_" + index, 0);
}

_id_47B931D76FFD028F(_id_69E96A4CAA72D794, opener) {
  _id_69E96A4CAA72D794 endon("death");
  level endon("game_ended");
  _id_69E96A4CAA72D794 endon("closed");
  opener scripts\engine\utility::waittill_any_4("close_container", "flashbang", "concussed", "weapon_fired");
  _id_68085C72D7B628EC(_id_69E96A4CAA72D794, opener);
}

_id_825B88A376D4BE6F(_id_167656C36D02A90A, opener) {
  if(!isDefined(opener) || !isDefined(opener getplayerangles()))
    return 1;

  _id_85CDA59B0F7F2FF2 = anglesToForward(opener getplayerangles());
  return scripts\engine\math::anglebetweenvectors(_id_167656C36D02A90A, _id_85CDA59B0F7F2FF2) > 20;
}

_id_9FB5B05ED3F94474(_id_69E96A4CAA72D794, opener, _id_FAC5875C19871D1F) {
  _id_C739A0E481FCE3D8 = level._id_DE221BFB117F1FD1;

  if(_id_FAC5875C19871D1F > 2 && getdvarint("dvar_419FD2F09B23942A", 1))
    _id_C739A0E481FCE3D8 = level._id_EF5B044960434F17;

  if(isDefined(_id_69E96A4CAA72D794._id_BF8E5F003146AF44)) {
    _id_0331CB3E6B6E2212 = rotatevectorinverted(opener.origin - _id_69E96A4CAA72D794._id_BF8E5F003146AF44.origin, _id_69E96A4CAA72D794._id_BF8E5F003146AF44.angles);

    if(distancesquared(opener._id_F2AA9AE949179907, _id_0331CB3E6B6E2212) > _id_C739A0E481FCE3D8)
      return 0;
  } else if(distancesquared(opener._id_F2AA9AE949179907, opener.origin) > _id_C739A0E481FCE3D8)
    return 0;

  return 1;
}

_id_F5765DCF987B7720(_id_69E96A4CAA72D794, opener, _id_167656C36D02A90A, _id_FAC5875C19871D1F) {
  if(istrue(opener.isdisconnecting))
    return 0;

  if(!scripts\mp\utility\player::isreallyalive(opener))
    return 0;

  if(_id_F3557CAF4562BFF7(_id_69E96A4CAA72D794) && istrue(_id_69E96A4CAA72D794._id_0343C584E7E00192))
    return 1;

  if(!isDefined(opener.origin))
    return 0;

  if(!_id_9FB5B05ED3F94474(_id_69E96A4CAA72D794, opener, _id_FAC5875C19871D1F))
    return 0;

  if(_id_825B88A376D4BE6F(_id_167656C36D02A90A, opener))
    return 0;

  if(opener playerads() > 0.5)
    return 0;

  return 1;
}

_id_71A59F067D5FE986(_id_69E96A4CAA72D794, opener) {
  _id_69E96A4CAA72D794 endon("death");
  level endon("game_ended");
  _id_69E96A4CAA72D794 endon("closed");
  _id_167656C36D02A90A = anglesToForward(opener getplayerangles());
  _id_FAC5875C19871D1F = 0;

  while(_id_F5765DCF987B7720(_id_69E96A4CAA72D794, opener, _id_167656C36D02A90A, _id_FAC5875C19871D1F)) {
    if(getdvarint("dvar_419FD2F09B23942A", 1)) {
      if(lengthsquared(opener getvelocity()) == 0) {
        if(_id_FAC5875C19871D1F == 0) {
          if(isDefined(_id_69E96A4CAA72D794._id_BF8E5F003146AF44))
            opener._id_F2AA9AE949179907 = rotatevectorinverted(opener.origin - _id_69E96A4CAA72D794._id_BF8E5F003146AF44.origin, _id_69E96A4CAA72D794._id_BF8E5F003146AF44.angles);
          else
            opener._id_F2AA9AE949179907 = opener.origin;
        }

        _id_FAC5875C19871D1F++;
        _id_FAC5875C19871D1F = int(min(_id_FAC5875C19871D1F, getdvarint("dvar_AEA0716D0A0F790A", 6)));
      } else {
        _id_FAC5875C19871D1F--;
        _id_FAC5875C19871D1F = int(max(_id_FAC5875C19871D1F, 0));
      }
    }

    waitframe();
  }

  _id_68085C72D7B628EC(_id_69E96A4CAA72D794, opener);
}

_id_68085C72D7B628EC(_id_69E96A4CAA72D794, opener) {
  if(isDefined(opener))
    opener setclientomnvar("loot_container_open", 0);

  if(!isDefined(_id_69E96A4CAA72D794)) {
    return;
  }
  _id_6CD112326D215E1F(opener, _id_69E96A4CAA72D794);
  _id_69E96A4CAA72D794.opener = undefined;
  partname = _id_69E96A4CAA72D794 _meth_EC5F4851431F3382();

  if(_id_23A3BB1172216C05(_id_69E96A4CAA72D794, opener)) {
    if(_id_552B8E4EA5FF7DF1::_id_6759FF16E552AA94(_id_69E96A4CAA72D794) || _id_552B8E4EA5FF7DF1::_id_8C57777A730CA632(_id_69E96A4CAA72D794) || scripts\mp\teamrevive::_id_5B55070C02328EA7(_id_69E96A4CAA72D794)) {
      _id_69E96A4CAA72D794 notify("death");
      _id_69E96A4CAA72D794 freescriptable();
    } else
      _id_932E5252B650E475(opener, _id_69E96A4CAA72D794);
  } else if(_id_F3557CAF4562BFF7(_id_69E96A4CAA72D794)) {
    if(scripts\mp\utility\player::isreallyalive(opener) && istrue(_id_69E96A4CAA72D794._id_0343C584E7E00192) && isDefined(_id_69E96A4CAA72D794.contents) && _id_69E96A4CAA72D794.contents.size > 0) {
      lootid = undefined;
      quantity = undefined;

      foreach(item in _id_69E96A4CAA72D794.contents) {
        lootid = item["lootID"];
        quantity = item["quantity"];
        break;
      }

      if(isDefined(lootid) && isDefined(quantity) && lootid != 0 && quantity > 0)
        opener _id_7E52B56769FA7774::_id_FE539E37B6579930(lootid, quantity);

      _id_7E52B56769FA7774::loothide(_id_69E96A4CAA72D794);
      return;
    } else {
      foreach(player in level.players)
      _id_69E96A4CAA72D794 enablescriptableplayeruse(player);
    }
  } else if(!_id_532EAC3C428E5B9B(_id_69E96A4CAA72D794)) {
    if(_id_69E96A4CAA72D794 getscriptableparthasstate(partname, "partially_open_usable")) {
      state = _id_69E96A4CAA72D794 getscriptablepartstate(partname);

      if(!isDefined(state))
        logstring("Log this in IW9-396144: state is undefined, container.type = " + scripts\engine\utility::ter_op(isDefined(_id_69E96A4CAA72D794.type), _id_69E96A4CAA72D794.type, "undefined") + ", partName = " + partname);

      if(state == "partially_open_in_use_unusable" || state == "partially_reopen_in_use_unusable")
        _id_69E96A4CAA72D794 setscriptablepartstate(partname, "partially_open_usable");
      else if(state == "partially_opening_unusable")
        _id_69E96A4CAA72D794 thread _id_D3E618521013C7EB();
      else if(!_id_E3081772BBF7A51C(opener, _id_69E96A4CAA72D794) && state != "partially_open_usable" && state != "closing") {}
    }
  }

  if(isDefined(_id_69E96A4CAA72D794._id_CEB543956C7203E7))
    [[_id_69E96A4CAA72D794._id_CEB543956C7203E7]](_id_69E96A4CAA72D794, opener);

  if(getdvarint("dvar_C85A9BCC06A81A1F", 0) && isDefined(_id_69E96A4CAA72D794._id_2568210352BE1ECF) && _id_69E96A4CAA72D794._id_2568210352BE1ECF.size > 0) {
    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

    if(isDefined(_id_69E96A4CAA72D794.dropstruct))
      dropstruct = _id_69E96A4CAA72D794.dropstruct;

    foreach(index, item in _id_69E96A4CAA72D794._id_2568210352BE1ECF) {
      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, opener.origin, opener.angles, opener, undefined);
      scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(item["lootID"]);
      _id_7E52B56769FA7774::spawnpickup(scriptablename, _id_CB4FAD49263E20C4, item["quantity"], 1, undefined, 0);
      opener._id_02FA5B49969DEF47.contents[index]["lootID"] = 0;
      opener._id_02FA5B49969DEF47.contents[index]["quantity"] = 0;
    }

    _id_69E96A4CAA72D794._id_2568210352BE1ECF = undefined;
  }

  if(isDefined(_id_69E96A4CAA72D794.dropstruct))
    _id_69E96A4CAA72D794.dropstruct = undefined;

  opener._id_02FA5B49969DEF47 = undefined;
  _id_69E96A4CAA72D794 notify("closed");
  opener scripts\cp_mp\calloutmarkerping::_id_FAA3CBEC7243FE72();
}

_id_D3E618521013C7EB() {
  self endon("death");
  level endon("game_ended");
  partname = self _meth_EC5F4851431F3382();
  waitframe();

  while(self getscriptablepartstate(partname) == "partially_opening_unusable")
    waitframe();

  self setscriptablepartstate(partname, "partially_open_usable");
}

_id_6F45E7311F77EAC4(player) {
  return player getclientomnvar("loot_container_open") > 0;
}

_id_73D8C72E055E8640(player) {
  if(!_id_6F45E7311F77EAC4(player))
    return 0;

  if(!isDefined(player._id_02FA5B49969DEF47))
    return 0;

  if(!isDefined(player._id_02FA5B49969DEF47._id_46A3A8565AC0C17C))
    return 0;

  if(player._id_02FA5B49969DEF47._id_46A3A8565AC0C17C != 14)
    return 0;

  if(!isDefined(player._id_02FA5B49969DEF47.contents))
    return 0;

  foreach(item in player._id_02FA5B49969DEF47.contents) {
    if(isDefined(item["lootID"])) {
      scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(item["lootID"]);

      if(isDefined(scriptablename) && _id_7E52B56769FA7774::_id_E4B6260DBB04B43D(scriptablename))
        return 1;
    }
  }

  return 0;
}

_id_6CD112326D215E1F(opener, _id_69E96A4CAA72D794) {
  _id_69E96A4CAA72D794 = _id_59B9C8081B873A10(opener, _id_69E96A4CAA72D794);

  if(!isDefined(_id_69E96A4CAA72D794._id_7F52190FA265244C)) {
    return;
  }
  foreach(_id_8EB93A779D9DF6F7 in _id_69E96A4CAA72D794._id_7F52190FA265244C)
  _func_A1054A8C2BC6C36D(_id_8EB93A779D9DF6F7);

  _id_69E96A4CAA72D794._id_7F52190FA265244C = [];
}

_id_7EF8FA0B69DA782A(_id_8DB5472153EA4811) {
  _id_1560C7D5CACC7888 = 31;

  if(_id_1560C7D5CACC7888 > 31)
    return undefined;

  _id_25CDF28FDB105D24 = spawnStruct();
  _id_9EB6DF06F8B7B0EE = 1048575;
  _id_25CDF28FDB105D24.lootid = _id_9EB6DF06F8B7B0EE &_id_8DB5472153EA4811;
  _id_8DB5472153EA4811 = _id_8DB5472153EA4811 >> 20;
  _id_B1A98C6B10F6E8C1 = 2047;
  _id_25CDF28FDB105D24._id_8470CC41230CE05D = _id_B1A98C6B10F6E8C1 &_id_8DB5472153EA4811;
  _id_8DB5472153EA4811 = _id_8DB5472153EA4811 >> 11;
  return _id_25CDF28FDB105D24;
}

_id_C4858170624B6CAF(lootid, _id_8470CC41230CE05D) {
  if(!isDefined(lootid))
    lootid = 0;

  if(!isDefined(_id_8470CC41230CE05D))
    _id_8470CC41230CE05D = 0;

  _id_8DB5472153EA4811 = 0;
  _id_1560C7D5CACC7888 = 31;

  if(_id_1560C7D5CACC7888 > 31)
    return _id_8DB5472153EA4811;

  _id_8DB5472153EA4811 = _id_8DB5472153EA4811 | _id_8470CC41230CE05D;
  _id_8DB5472153EA4811 = _id_8DB5472153EA4811 << 20;
  _id_8DB5472153EA4811 = _id_8DB5472153EA4811 | lootid;
  return _id_8DB5472153EA4811;
}

_id_D6A3266145BAB76D(_id_8C24A642E5ABBA4E) {
  player = self;
  _id_22937F7DA36B4B8F = player getclientomnvar(_id_8C24A642E5ABBA4E);

  if(!isDefined(_id_22937F7DA36B4B8F))
    return 0;

  _id_BD62F58E765FFFD5 = _id_7EF8FA0B69DA782A(_id_22937F7DA36B4B8F);
  _id_B7EF0BD383C9DBAF = _id_BD62F58E765FFFD5.lootid;
  return _id_B7EF0BD383C9DBAF;
}

_id_62AD0C002D54CBCC(player, _id_69E96A4CAA72D794, _id_142EE196B1C70723, lootid, weapon) {
  _id_8EB93A779D9DF6F7 = undefined;

  if(isDefined(lootid) && lootid != 0) {
    if(!isDefined(weapon)) {
      _id_C9C301A888170672 = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);
      _id_8EB93A779D9DF6F7 = _func_51F396445BAA7FA6(_id_C9C301A888170672);
    } else if(isweapon(weapon)) {
      _id_CCE9361200C5117C = _id_2669878CF5A1B6BC::_id_0C9AF9FE37668DF2(weapon.basename);
      _id_C9C301A888170672 = "brloot_weapon_generic_" + _id_CCE9361200C5117C;
      _id_8EB93A779D9DF6F7 = _func_51F396445BAA7FA6(_id_C9C301A888170672, weapon);
    } else {
      _id_C9C301A888170672 = weapon;
      _id_8EB93A779D9DF6F7 = _func_51F396445BAA7FA6(_id_C9C301A888170672);
    }
  }

  if(isDefined(_id_8EB93A779D9DF6F7) && _id_8EB93A779D9DF6F7 != 0) {
    if(!isDefined(_id_69E96A4CAA72D794._id_7F52190FA265244C))
      _id_69E96A4CAA72D794._id_7F52190FA265244C = [];

    _id_69E96A4CAA72D794._id_7F52190FA265244C[_id_69E96A4CAA72D794._id_7F52190FA265244C.size] = _id_8EB93A779D9DF6F7;
  }

  _id_453AE8156FBDC0DE = _id_C4858170624B6CAF(lootid, _id_8EB93A779D9DF6F7);
  player setclientomnvar(_id_142EE196B1C70723, _id_453AE8156FBDC0DE);
}

_id_446C7AD7BCC70992(player, _id_69E96A4CAA72D794, index, lootid, quantity, _id_C9C301A888170672) {
  if(_id_C26E54FFD0C8BE94(_id_69E96A4CAA72D794, index))
    _id_B1423ADECED14528(player, index - 11, lootid, quantity);
  else {
    _id_319F74ED8FA1A512 = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(lootid);
    _id_BA7D157F3BBF68E9 = undefined;

    if(isDefined(_id_319F74ED8FA1A512))
      _id_BA7D157F3BBF68E9 = level._id_F984BA508AE5BCB1[_id_319F74ED8FA1A512];

    if(lootid == 0)
      _id_C7294F5B9B5006D5(player, index);
    else if(isDefined(_id_BA7D157F3BBF68E9)) {
      if(_id_BA7D157F3BBF68E9._id_319F74ED8FA1A512 == "weapon")
        _id_62AD0C002D54CBCC(player, _id_69E96A4CAA72D794, "loot_container_item_" + index, lootid, _id_C9C301A888170672);
      else
        player setclientomnvar("loot_container_item_" + index, lootid);

      player setclientomnvar("loot_container_quantity_" + index, quantity);
      player setclientomnvar("loot_container_type_" + index, _id_BA7D157F3BBF68E9._id_03A436BD812A2B86);

      if(quantity > 4095)
        logstring("IW9-690092: Item quantity too large for loot ID: " + lootid);
    }
  }
}

_id_7EDA25C90CC3AAA1(index) {
  return index >= 11 && index <= 20;
}

_id_C26E54FFD0C8BE94(_id_69E96A4CAA72D794, index) {
  return _id_7EDA25C90CC3AAA1(index) && _id_54066DBD8EF44FE1(_id_69E96A4CAA72D794);
}

_id_4DF382B17698F0C5(_id_69E96A4CAA72D794, index, _id_CC768FF46F3F6339) {
  if(isDefined(_id_69E96A4CAA72D794) && isDefined(_id_69E96A4CAA72D794._id_3AADF7A3CC811358) && scripts\engine\utility::array_contains(_id_69E96A4CAA72D794._id_3AADF7A3CC811358, index) && !istrue(_id_CC768FF46F3F6339))
    return 0;

  if(isDefined(_id_69E96A4CAA72D794) && isDefined(_id_69E96A4CAA72D794._id_BF23A60678978C19) && isDefined(_id_69E96A4CAA72D794._id_BF23A60678978C19[index]) && isDefined(_id_69E96A4CAA72D794._id_BF23A60678978C19[index]["lootID"]))
    return _id_69E96A4CAA72D794._id_BF23A60678978C19[index]["lootID"];

  return 0;
}

_id_DC8D7C1709ADCD67(_id_69E96A4CAA72D794, index, _id_CC768FF46F3F6339) {
  if(isDefined(_id_69E96A4CAA72D794) && isDefined(_id_69E96A4CAA72D794._id_3AADF7A3CC811358) && scripts\engine\utility::array_contains(_id_69E96A4CAA72D794._id_3AADF7A3CC811358, index) && !istrue(_id_CC768FF46F3F6339))
    return 0;

  if(isDefined(_id_69E96A4CAA72D794) && isDefined(_id_69E96A4CAA72D794._id_BF23A60678978C19) && isDefined(_id_69E96A4CAA72D794._id_BF23A60678978C19[index]) && isDefined(_id_69E96A4CAA72D794._id_BF23A60678978C19[index]["quantity"]))
    return _id_69E96A4CAA72D794._id_BF23A60678978C19[index]["quantity"];

  return 0;
}

_id_7F855164A30A5F5F(player) {
  player setclientomnvar("loot_container_loadout_weapon_id", 0);
  player setclientomnvar("loot_container_loadout_weapon_attachments", 0);
  player setclientomnvar("loot_container_loadout_weapon_ammo", 0);
}

_id_9B4AD636BEC4278D(player, lootid, quantity) {
  gasmasktype = 0;
  gasmaskhealth = 0;

  if(!(lootid == 0 || quantity == 0)) {
    gasmaskhealth = quantity;
    scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

    if(scriptablename == "brloot_equip_gasmask_durable")
      gasmasktype = 3;
    else if(scriptablename == "brloot_equip_gasmask_scuba")
      gasmasktype = 4;
    else
      gasmasktype = 2;
  }

  player setclientomnvar("loot_container_loadout_gasmask_id", gasmasktype);
  player setclientomnvar("loot_container_loadout_gasmask_quantity", gasmaskhealth);
}

_id_B1423ADECED14528(player, index, lootid, quantity) {
  if(lootid == 0 || quantity == 0) {
    lootid = 0;
    quantity = 0;
  }

  switch (index) {
    case 0:
      player setclientomnvar("loot_container_loadout_plunder_quantity", quantity);
      break;
    case 1:
      player setclientomnvar("loot_container_loadout_lethal_id", lootid);
      player setclientomnvar("loot_container_loadout_lethal_quantity", quantity);
      break;
    case 2:
      player setclientomnvar("loot_container_loadout_tactical_id", lootid);

      if(_id_7E52B56769FA7774::_id_D345EEC68E01361F(lootid))
        quantity = 1;

      player setclientomnvar("loot_container_loadout_tactical_quantity", quantity);
      break;
    case 3:
      player setclientomnvar("loot_container_loadout_armor_quantity", quantity);
      break;
    case 6:
      _id_9B4AD636BEC4278D(player, lootid, quantity);
      break;
    case 7:
      player setclientomnvar("loot_container_loadout_revive", quantity);
      break;
    case 5:
      player setclientomnvar("loot_container_loadout_super_id", lootid);
      break;
    case 4:
      player setclientomnvar("loot_container_loadout_killstreak_id", lootid);
      break;
    case 8:
      if(lootid == 0 || quantity == 0) {
        player setclientomnvar("loot_container_loadout_dogtag_tier", 0);
        break;
      }

      if(lootid == 26140) {
        player setclientomnvar("loot_container_loadout_dogtag_tier", 5);
        player setclientomnvar("loot_container_loadout_dogtag_quantity", 1);
        break;
      }

      tier = _id_2391409EF7B431E1::_id_2D2F7E8A6547AE42(lootid);
      player setclientomnvar("loot_container_loadout_dogtag_tier", tier + 1);
      player setclientomnvar("loot_container_loadout_dogtag_quantity", quantity);
      break;
    case 9:
      player setclientomnvar("loot_container_loadout_backpack", lootid);
    default:
      break;
  }
}

_id_46BF6F4D9DCC9B78(player, _id_69E96A4CAA72D794) {
  _id_BF23A60678978C19 = _id_69E96A4CAA72D794._id_BF23A60678978C19;

  if(isDefined(_id_BF23A60678978C19)) {
    foreach(index, item in _id_BF23A60678978C19) {
      lootid = 0;
      quantity = 0;

      if(isDefined(item["lootID"])) {
        lootid = item["lootID"];
        quantity = item["quantity"];
      }

      _id_B1423ADECED14528(player, index, lootid, quantity);
    }
  }

  if(isDefined(_id_69E96A4CAA72D794._id_A06E7128C001851D) && isDefined(_id_69E96A4CAA72D794._id_A0E9FEF038504BD0)) {
    _id_98F7CE981BB1F93C = _id_69E96A4CAA72D794._id_A06E7128C001851D;
    weaponobj = _id_69E96A4CAA72D794._id_A0E9FEF038504BD0;
    attachments = getweaponattachments(weaponobj);
    _id_A28F4E760500001B = 0;

    foreach(attachment in attachments) {
      if(!scripts\mp\utility\weapon::attachmentisselectable(weaponobj, attachment)) {
        continue;
      }
      _id_A28F4E760500001B++;
    }

    _id_62AD0C002D54CBCC(player, _id_69E96A4CAA72D794, "loot_container_loadout_weapon_id", _id_98F7CE981BB1F93C, weaponobj);
    player setclientomnvar("loot_container_loadout_weapon_attachments", _id_A28F4E760500001B);
    player setclientomnvar("loot_container_loadout_weapon_ammo", player getweaponammoclip(weaponobj));
  }
}

_id_F478CA9D3C44018C(player, index, _id_69E96A4CAA72D794, _id_CC768FF46F3F6339) {
  if(isDefined(_id_69E96A4CAA72D794) && isDefined(_id_69E96A4CAA72D794._id_73FB94C9AEDCC497) && scripts\engine\utility::array_contains(_id_69E96A4CAA72D794._id_73FB94C9AEDCC497, index) && !istrue(_id_CC768FF46F3F6339))
    return 0;

  _id_F1CBC68C79EBF1EA = undefined;

  if(index == 100)
    _id_F1CBC68C79EBF1EA = player _id_D6A3266145BAB76D("loot_container_weapon");
  else
    _id_F1CBC68C79EBF1EA = player _id_D6A3266145BAB76D("loot_container_item_" + index);

  return _id_F1CBC68C79EBF1EA;
}

_id_8E5978971B5DCD16(player, index, _id_69E96A4CAA72D794, _id_CC768FF46F3F6339) {
  if(isDefined(_id_69E96A4CAA72D794) && isDefined(_id_69E96A4CAA72D794._id_73FB94C9AEDCC497) && scripts\engine\utility::array_contains(_id_69E96A4CAA72D794._id_73FB94C9AEDCC497, index) && !istrue(_id_CC768FF46F3F6339))
    return 0;

  if(index == 100)
    return 1;

  return player getclientomnvar("loot_container_quantity_" + index);
}

_id_23A3BB1172216C05(_id_69E96A4CAA72D794, opener) {
  if(_id_532EAC3C428E5B9B(_id_69E96A4CAA72D794))
    return 0;

  _id_69E96A4CAA72D794 = _id_59B9C8081B873A10(opener, _id_69E96A4CAA72D794);

  if(!isDefined(_id_69E96A4CAA72D794.contents))
    return 1;

  contents = _id_69E96A4CAA72D794.contents;

  foreach(_id_C56207BDA09B3A36 in contents) {
    if(!isDefined(_id_C56207BDA09B3A36["lootID"]) || !isDefined(_id_C56207BDA09B3A36["quantity"])) {
      continue;
    }
    if(_id_C56207BDA09B3A36["lootID"] > 0 && _id_C56207BDA09B3A36["quantity"] > 0)
      return 0;
  }

  if(isDefined(_id_69E96A4CAA72D794.customweaponname))
    return 0;

  if(istrue(_id_69E96A4CAA72D794._id_04F6CDE716E0C3D7))
    return 0;

  if(_id_54066DBD8EF44FE1(_id_69E96A4CAA72D794)) {
    if(isDefined(_id_69E96A4CAA72D794._id_BF23A60678978C19)) {
      foreach(_id_C56207BDA09B3A36 in _id_69E96A4CAA72D794._id_BF23A60678978C19) {
        if(!isDefined(_id_C56207BDA09B3A36["lootID"]) || !isDefined(_id_C56207BDA09B3A36["quantity"])) {
          continue;
        }
        if(_id_C56207BDA09B3A36["lootID"] > 0 && _id_C56207BDA09B3A36["quantity"] > 0)
          return 0;
      }
    }

    if(isDefined(_id_69E96A4CAA72D794._id_A0E9FEF038504BD0))
      return 0;
  }

  return 1;
}

_id_60D2295CCC45D8C0(player, lootid, quantity, _id_69E96A4CAA72D794) {
  if(isDefined(quantity) && quantity < 0) {
    return;
  }
  _id_3EAA9F644DBE7834 = scripts\cp_mp\challenges::_id_6D40F12A09494350(0, 0);
  scriptablename = _id_69E96A4CAA72D794.type;
  _id_46A3A8565AC0C17C = _id_69E96A4CAA72D794._id_46A3A8565AC0C17C;

  if(isDefined(_id_46A3A8565AC0C17C) && (_id_46A3A8565AC0C17C == 2 || _id_46A3A8565AC0C17C == 6 || _id_46A3A8565AC0C17C >= 7 && _id_46A3A8565AC0C17C <= 12))
    _id_3EAA9F644DBE7834 = scripts\cp_mp\challenges::_id_6D40F12A09494350(_id_3EAA9F644DBE7834, 4);
  else
    _id_3EAA9F644DBE7834 = scripts\cp_mp\challenges::_id_6D40F12A09494350(_id_3EAA9F644DBE7834, 3);

  lootsource = 0;
  _id_D330FA8595DB7E4F = 0;

  if(isDefined(scriptablename)) {
    switch (scriptablename) {
      case "dmz_hidden_container":
        lootsource = scripts\cp_mp\challenges::_id_6D40F12A09494350(lootsource, 1);
        break;
      case "cache_medicine_cabinet":
      case "cache_medical_box_wall":
        lootsource = scripts\cp_mp\challenges::_id_6D40F12A09494350(lootsource, 2);
        break;
      case "cache_computer_tower":
        lootsource = scripts\cp_mp\challenges::_id_6D40F12A09494350(lootsource, 3);
        break;
      case "dmz_supply_drop":
        lootsource = scripts\cp_mp\challenges::_id_6D40F12A09494350(lootsource, 4);
        lootsource = scripts\cp_mp\challenges::_id_6D40F12A09494350(lootsource, 5);
        _id_D330FA8595DB7E4F = 1;
        break;
      case "dmz_supply_drop_samsite":
        lootsource = scripts\cp_mp\challenges::_id_6D40F12A09494350(lootsource, 4);
        lootsource = scripts\cp_mp\challenges::_id_6D40F12A09494350(lootsource, 6);
        _id_D330FA8595DB7E4F = 1;
        break;
      case "cache_weapon_locker":
        lootsource = scripts\cp_mp\challenges::_id_6D40F12A09494350(lootsource, 7);
        break;
      case "cache_duffel_bag_01":
        lootsource = scripts\cp_mp\challenges::_id_6D40F12A09494350(lootsource, 8);
        break;
      case "cache_cash_register_clean":
      case "cache_cash_register":
        lootsource = scripts\cp_mp\challenges::_id_6D40F12A09494350(lootsource, 9);
        break;
      case "dmz_supply_drop_boss":
        _id_D330FA8595DB7E4F = 1;
        break;
      default:
        break;
    }
  }

  if(_id_D330FA8595DB7E4F)
    _id_CE5D71BAED479274(player, _id_69E96A4CAA72D794);

  if(_id_396A814D39E7044F::_id_7BA31CB6B21C346F()) {
    if(player scripts\mp\calloutmarkerping_mp::_id_C28D94289C4A6ECD(_id_69E96A4CAA72D794, lootid))
      player thread _id_396A814D39E7044F::_id_36EDF91561322753(3);
  }

  scripts\cp_mp\challenges::_id_D24138B32084FC3E(player, lootid, undefined, _id_3EAA9F644DBE7834, quantity, lootsource);
}

_id_CE5D71BAED479274(_id_F2983979DD4F1FF0, _id_69E96A4CAA72D794) {
  _id_7ECBD4F07F6882D0 = getdvarint("dvar_A1E254E5A2B575D7", 1) == 1;
  _id_BA03253452037335 = 0;
  players = scripts\mp\utility\teams::getteamdata(_id_F2983979DD4F1FF0.team, "players");

  if(isDefined(_id_69E96A4CAA72D794)) {
    if(isDefined(_id_69E96A4CAA72D794._id_8697902B8B8A79B1)) {
      if(!_id_7ECBD4F07F6882D0) {
        _id_243D9EA347100EF1 = 0;

        foreach(player in players) {
          if(scripts\engine\utility::array_contains(_id_69E96A4CAA72D794._id_8697902B8B8A79B1, player)) {
            _id_243D9EA347100EF1 = 1;
            break;
          }
        }

        if(!_id_243D9EA347100EF1) {
          _id_69E96A4CAA72D794._id_8697902B8B8A79B1 = scripts\engine\utility::array_combine_unique(_id_69E96A4CAA72D794._id_8697902B8B8A79B1, players);
          _id_BA03253452037335 = 1;
        }
      }
    } else {
      _id_69E96A4CAA72D794._id_8697902B8B8A79B1 = [];
      _id_69E96A4CAA72D794._id_8697902B8B8A79B1 = scripts\engine\utility::array_combine_unique(_id_69E96A4CAA72D794._id_8697902B8B8A79B1, players);
      _id_BA03253452037335 = 1;
    }
  }

  if(!_id_BA03253452037335) {
    return;
  }
  foreach(player in players) {
    if(!isDefined(player._id_320A8BA98AE41575))
      player._id_320A8BA98AE41575 = 0;

    player._id_320A8BA98AE41575++;
    player scripts\mp\utility\points::_id_0366980B6A8796AE("stat_9A68D11B1688325A");
  }
}

_id_F3557CAF4562BFF7(_id_69E96A4CAA72D794) {
  if(!isDefined(_id_69E96A4CAA72D794) || !isDefined(_id_69E96A4CAA72D794._id_46A3A8565AC0C17C))
    return 0;

  return _id_69E96A4CAA72D794._id_46A3A8565AC0C17C == 14;
}

_id_532EAC3C428E5B9B(_id_69E96A4CAA72D794) {
  if(!isDefined(_id_69E96A4CAA72D794._id_46A3A8565AC0C17C))
    return 0;

  return _id_69E96A4CAA72D794._id_46A3A8565AC0C17C == 13 || _id_69E96A4CAA72D794._id_46A3A8565AC0C17C == 15;
}

_id_54066DBD8EF44FE1(_id_69E96A4CAA72D794) {
  if(!isDefined(_id_69E96A4CAA72D794._id_46A3A8565AC0C17C))
    return 0;

  return _id_69E96A4CAA72D794._id_46A3A8565AC0C17C == 16 || _id_69E96A4CAA72D794._id_46A3A8565AC0C17C == 6 || _id_69E96A4CAA72D794._id_46A3A8565AC0C17C >= 7 && _id_69E96A4CAA72D794._id_46A3A8565AC0C17C <= 12;
}

_id_86D77B1DBD44B06E(opener, _id_69E96A4CAA72D794, _id_4472B62C1FA150E5) {
  level endon("game_ended");
  opener endon("death_or_disconnect");
  opener endon("enter_live_ragdoll");
  _id_69E96A4CAA72D794 endon("death");
  waittime = 0.35;
  _id_97072EEAE32EBD38 = getdvarfloat("dvar_D9E519D9C89AF2F3", 0.0);

  if(_id_97072EEAE32EBD38 > 0.0)
    waittime = _id_97072EEAE32EBD38;

  _id_69E96A4CAA72D794 scripts\engine\utility::waittill_any_timeout_1(waittime, "closed");

  if(!scripts\mp\utility\player::isreallyalive(opener)) {
    return;
  }
  if(_id_4472B62C1FA150E5) {
    _id_95592165F5BA7FB4 = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getsubgametype(), "_lootingSpecialXPOverride"), 0);

    if(_id_95592165F5BA7FB4 == 0)
      _id_95592165F5BA7FB4 = undefined;

    opener thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_F396D39FEE1A8054", undefined, undefined, _id_95592165F5BA7FB4);
    opener playsoundtoplayer("uin_loot_container_open_epic", opener);
  } else {
    _id_4B5A99C16ABFDFB1 = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getsubgametype(), "_lootingXPOverride"), 0);

    if(_id_4B5A99C16ABFDFB1 == 0)
      _id_4B5A99C16ABFDFB1 = undefined;

    opener thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_C19301D569C97C3C", undefined, undefined, _id_4B5A99C16ABFDFB1);
    opener playsoundtoplayer("uin_loot_container_open_common", opener);
  }
}

_id_1791C1E8974E9BD7(player, lootid, quantity, weaponref, _id_CC768FF46F3F6339, _id_96C7526F4AB04875, _id_7591ED99E87A77D3, _id_4A08890FD43D6BC7) {
  ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);
  success = 0;

  if(ref == "cash") {
    _id_3466C10973E9C476 = _id_6AFF3948CF4CCA03::getplundernamebyamount(quantity);
    _id_60227BFF1E9478CC = spawnStruct();
    _id_60227BFF1E9478CC.scriptablename = _id_3466C10973E9C476;
    _id_60227BFF1E9478CC._id_8598D3D3BC3D9CEB = 1;
    _id_60227BFF1E9478CC.count = quantity;
    player _id_7E52B56769FA7774::_id_EFDDDF60C5DB058C(_id_60227BFF1E9478CC);
    player _id_6AFF3948CF4CCA03::playerplunderpickup(quantity, undefined, undefined, 1);
    player scripts\cp_mp\challenges::onpickupitem("plunder");
    success = 1;
  } else if(ref == "dmz_loot_quest_intel" || ref == "dmz_trap_quest_trigger") {
    player _id_7E52B56769FA7774::_id_37BE6E543436F3B3(lootid, undefined, 1);
    success = 1;
  } else if(_id_2CEDCC356F1B9FC8::isammo(ref))
    success = player _id_7E52B56769FA7774::_id_54DAC56D15DD3D93(ref, lootid, quantity, 1);
  else if(_id_2391409EF7B431E1::_id_03C17A26CE6A4668(lootid) && _id_2391409EF7B431E1::_id_D9F5C5090DE1241B(player, quantity)) {
    [_id_C9CCB7804978DC9F, _] = _id_2391409EF7B431E1::_id_E92E13020D5EE099(quantity);
    _id_773F62BF746FC586 = level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F].player;

    if(isDefined(_id_773F62BF746FC586))
      _id_2391409EF7B431E1::_id_8E643D6706DEFEEA(_id_773F62BF746FC586, quantity);

    if(!isDefined(_id_773F62BF746FC586) || _id_773F62BF746FC586 != player)
      _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_recover_dog_tag", [player], undefined);

    success = 1;
  } else if(istrue(isweaponitem(lootid))) {
    _id_4A08890FD43D6BC7 = istrue(_id_4A08890FD43D6BC7) && _id_2D9D24F7C63AC143::_id_B13E35608B336D65(player) >= 7 && !_id_2D9D24F7C63AC143::_id_EFAB78B72D131D76(player);
    success = player _id_7E52B56769FA7774::_id_D8CD9C1941A88194(lootid, quantity, weaponref, 1, undefined, undefined, _id_96C7526F4AB04875, _id_7591ED99E87A77D3, _id_CC768FF46F3F6339, _id_4A08890FD43D6BC7);
  } else
    success = player _id_7E52B56769FA7774::_id_D8CD9C1941A88194(lootid, quantity, weaponref, 1, !istrue(_id_CC768FF46F3F6339), undefined, _id_96C7526F4AB04875, _id_7591ED99E87A77D3, _id_CC768FF46F3F6339);

  return success;
}

_id_A335AA664CAA37C9(player, _id_69E96A4CAA72D794) {
  if(istrue(player._id_859654E0445A36D9) && isDefined(level.br_pickups._id_355CDDB773CB000D)) {
    player scripts\mp\hud_message::showerrormessage(level.br_pickups._id_355CDDB773CB000D);
    return;
  }

  lootid = _id_2D9D24F7C63AC143::_id_D9B1550011525161(player);
  _id_6064FB4B46498174 = _id_69E96A4CAA72D794;
  _id_69E96A4CAA72D794 = _id_59B9C8081B873A10(player, _id_69E96A4CAA72D794);

  if(!isDefined(_id_69E96A4CAA72D794._id_6FB67C8525B1D79E)) {
    return;
  }
  _id_C161EC212069668D = 1;

  foreach(weaponobj in player.primaryinventory) {
    if(weaponobj.basename == "iw9_me_fists_mp") {
      _id_C161EC212069668D = 0;
      break;
    }
  }

  if(_id_C161EC212069668D && _id_2D9D24F7C63AC143::_id_EFAB78B72D131D76(player)) {
    scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyequipnoroom);
    return;
  }

  _id_60D2295CCC45D8C0(player, lootid, 1, _id_6064FB4B46498174);

  if(!_id_C161EC212069668D) {
    _id_A92926D5B02CF6ED(player, _id_6064FB4B46498174);
    return;
  }

  [_, weaponobj, _id_E1147886CCF51970, _id_4E479E14D0837E84, _, _, _] = _id_775A7FC396485A9A(player, _id_69E96A4CAA72D794);
  _id_2D9D24F7C63AC143::_id_E35A7CB7E7C8C17E(player, weaponobj, undefined, _id_4E479E14D0837E84);
  _id_724736FCF0FB6604::_id_AE30366A2D519A57(player, 2, _id_E1147886CCF51970);
  _id_505E8EB7E77704C5(player, _id_6064FB4B46498174);
  player playsoundtoplayer("br_pickup_weap", player);
}

_id_2F00CA0526F3EDC6(player, index, quantity, _id_69E96A4CAA72D794, _id_CC768FF46F3F6339) {
  lootid = 0;
  _id_35EABFFB2F0F31E3 = 0;
  [lootid, _id_35EABFFB2F0F31E3] = _id_EDB397974AE6EE68(player, _id_69E96A4CAA72D794, index, _id_CC768FF46F3F6339);

  if(lootid == 0 || _id_35EABFFB2F0F31E3 == 0) {
    return;
  }
  weaponref = _id_4B96AA12974840C0(player, _id_69E96A4CAA72D794, index);
  _id_609578472524B507 = undefined;
  _id_4A08890FD43D6BC7 = undefined;

  if(isDefined(weaponref)) {
    if(istrue(player._id_859654E0445A36D9) && isDefined(level.br_pickups._id_355CDDB773CB000D)) {
      player scripts\mp\hud_message::showerrormessage(level.br_pickups._id_355CDDB773CB000D);
      return;
    }

    _id_60227BFF1E9478CC = spawnStruct();
    _id_60227BFF1E9478CC.scriptablename = weaponref;
    _id_4A08890FD43D6BC7 = 1;
    _id_DD515FCF025B2E79 = _id_724736FCF0FB6604::_id_55C5D35C8C76A95B(_id_60227BFF1E9478CC)[0];

    foreach(_id_DE88CD14114C1E24 in self.primaryweapons) {
      if(issameweapon(_id_DE88CD14114C1E24, _id_DD515FCF025B2E79)) {
        lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_724736FCF0FB6604::br_ammo_type_for_weapon(_id_DD515FCF025B2E79));
        _id_35EABFFB2F0F31E3 = weaponclipsize(_id_DD515FCF025B2E79);
        quantity = _id_35EABFFB2F0F31E3;
        _id_609578472524B507 = 1;
        break;
      }
    }
  }

  _id_CB325DDB4A764623 = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);

  if(isDefined(_id_CB325DDB4A764623) && _id_CB325DDB4A764623 == "cash") {
    _id_B3D7D06E99EFD05E = scripts\engine\utility::_id_53C4C53197386572(player.plundercount, 0);
    maxplunder = scripts\engine\utility::_id_53C4C53197386572(level.br_plunder.plunderlimit, _id_B3D7D06E99EFD05E + _id_35EABFFB2F0F31E3);

    if(_id_B3D7D06E99EFD05E + _id_35EABFFB2F0F31E3 > level.br_plunder.plunderlimit)
      quantity = level.br_plunder.plunderlimit - _id_B3D7D06E99EFD05E;
  }

  if(!isDefined(quantity))
    quantity = _id_35EABFFB2F0F31E3;

  if(lootid == 0 || quantity == 0)
    return 1;

  _id_96C7526F4AB04875 = distance2d(_id_69E96A4CAA72D794.origin, player.origin) / 2;
  _id_7591ED99E87A77D3 = undefined;

  if(_id_F3557CAF4562BFF7(_id_69E96A4CAA72D794))
    _id_7591ED99E87A77D3 = _id_69E96A4CAA72D794.origin;

  success = _id_1791C1E8974E9BD7(player, lootid, quantity, weaponref, _id_CC768FF46F3F6339, _id_96C7526F4AB04875, _id_7591ED99E87A77D3, _id_4A08890FD43D6BC7);

  if(success || istrue(_id_609578472524B507)) {
    _id_A28BD7F30254C8A0 = _id_35EABFFB2F0F31E3 - quantity;
    _id_699DE62155C8C832 = lootid;
    _id_60D2295CCC45D8C0(player, _id_699DE62155C8C832, quantity, _id_69E96A4CAA72D794);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pmc_missions", "onContainerLooted"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("pmc_missions", "onContainerLooted")]](player, _id_699DE62155C8C832, quantity, _id_69E96A4CAA72D794);

    _id_153D3281E46E14DA(player, _id_69E96A4CAA72D794, index, _id_699DE62155C8C832, _id_A28BD7F30254C8A0);
    _id_F3C9E05D4767D037(lootid, player, _id_69E96A4CAA72D794, index);
  }

  return success;
}

_id_A92926D5B02CF6ED(player, _id_69E96A4CAA72D794, itemtype, _id_96C7526F4AB04875) {
  if(!isDefined(_id_69E96A4CAA72D794))
    return 1;

  if(istrue(player._id_859654E0445A36D9) && isDefined(level.br_pickups._id_355CDDB773CB000D)) {
    player scripts\mp\hud_message::showerrormessage(level.br_pickups._id_355CDDB773CB000D);
    return;
  }

  [_, _id_6FB67C8525B1D79E, _id_E1147886CCF51970, _id_4E479E14D0837E84, quantity, _id_18C2C5B0A787D075, _id_CF4FD93A53325100] = _id_775A7FC396485A9A(player, _id_69E96A4CAA72D794);

  if(!isDefined(_id_6FB67C8525B1D79E))
    return 1;

  weapon = _id_6FB67C8525B1D79E;

  foreach(_id_DE88CD14114C1E24 in self.primaryweapons) {
    if(issameweapon(_id_DE88CD14114C1E24, weapon)) {
      scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyalreadyhaveweapon);
      return;
    }
  }

  if(_id_2D9D24F7C63AC143::_id_EFAB78B72D131D76(player)) {
    _id_4D2B659118F5C515 = _id_2D9D24F7C63AC143::_id_2985254128B1C262(player);

    if(issameweapon(_id_4D2B659118F5C515, weapon)) {
      scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyalreadyhaveweapon);
      return;
    }
  }

  quantity = scripts\engine\utility::_id_53C4C53197386572(quantity, weaponclipsize(weapon));
  _id_7591ED99E87A77D3 = undefined;

  if(_id_F3557CAF4562BFF7(_id_69E96A4CAA72D794))
    _id_7591ED99E87A77D3 = _id_69E96A4CAA72D794.origin;

  _id_7E52B56769FA7774::_id_E5845FF9B61AC5D7(weapon, quantity, undefined, _id_18C2C5B0A787D075, undefined, undefined, _id_4E479E14D0837E84, _id_96C7526F4AB04875, _id_7591ED99E87A77D3, undefined, _id_CF4FD93A53325100);
  _id_FE4048AD22C35D73 = _id_724736FCF0FB6604::_id_2AB3BDA08C595A32(player, weapon);

  if(isDefined(_id_FE4048AD22C35D73))
    _id_724736FCF0FB6604::_id_AE30366A2D519A57(player, _id_FE4048AD22C35D73, _id_E1147886CCF51970);

  scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("pmc_missions", "onPickupWeapon", player, _id_6FB67C8525B1D79E, _id_4E479E14D0837E84);
  _id_505E8EB7E77704C5(player, _id_69E96A4CAA72D794);

  if(_id_F3557CAF4562BFF7(_id_69E96A4CAA72D794)) {
    player setclientomnvar("loot_container_open", 0);
    _id_69E96A4CAA72D794 notify("closed");
    _id_7E52B56769FA7774::loothide(_id_69E96A4CAA72D794);
  }
}

_id_3AE3712FE76D0C6A(player, index, loadoutindex, _id_69E96A4CAA72D794) {
  lootid = 0;
  quantity = 0;
  _id_96C7526F4AB04875 = distance2d(_id_69E96A4CAA72D794.origin, self.origin) / 2;

  if(_id_0C3D68FB7B175EDD(player, _id_69E96A4CAA72D794) && loadoutindex != 0)
    _id_E183B2E94298BB75(loadoutindex, player, _id_69E96A4CAA72D794, 0);
  else
    [lootid, quantity] = _id_EDB397974AE6EE68(player, _id_69E96A4CAA72D794, index);

  if(lootid == 0 || quantity == 0) {
    return;
  }
  ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);

  if(_id_430DF78A3A4143C1(player, _id_69E96A4CAA72D794, index))
    ref = _id_69E96A4CAA72D794.contents[index]["ref"];

  _id_10BBEACB1429824E = 0;

  if(_id_2CEDCC356F1B9FC8::isammo(ref)) {
    _id_BADA25504E8844D7 = spawnStruct();
    _id_BADA25504E8844D7.scriptablename = ref;
    _id_BADA25504E8844D7.count = quantity;

    if(_id_F3557CAF4562BFF7(_id_69E96A4CAA72D794))
      _id_BADA25504E8844D7.origin = _id_69E96A4CAA72D794.origin;

    player _id_2D9D24F7C63AC143::_id_10F6E537F1B5763C(lootid, _id_BADA25504E8844D7);
  } else if(_id_7E52B56769FA7774::_id_5449DA9D3D0358A4(ref)) {
    scripts\mp\hud_message::showerrormessage(level.br_pickups._id_0FDE0E27B3A09BF3);
    return;
  } else if(_id_430DF78A3A4143C1(player, _id_69E96A4CAA72D794, index)) {
    if(istrue(player._id_859654E0445A36D9) && isDefined(level.br_pickups._id_355CDDB773CB000D)) {
      player scripts\mp\hud_message::showerrormessage(level.br_pickups._id_355CDDB773CB000D);
      return;
    }

    _id_7591ED99E87A77D3 = undefined;

    if(_id_F3557CAF4562BFF7(_id_69E96A4CAA72D794))
      _id_7591ED99E87A77D3 = _id_69E96A4CAA72D794.origin;

    if(loadoutindex > 0)
      _id_7E52B56769FA7774::_id_62F068CEC343A111(player, 1, loadoutindex - 1, undefined, 0, 0, _id_96C7526F4AB04875, _id_7591ED99E87A77D3);

    weaponobj = _id_7E52B56769FA7774::getfullweaponobjforscriptablepartname(ref);
    quantity = weaponclipsize(weaponobj);
    success = _id_7E52B56769FA7774::_id_E5845FF9B61AC5D7(weaponobj, quantity, undefined, undefined, undefined, undefined, undefined, _id_96C7526F4AB04875, _id_7591ED99E87A77D3, undefined, quantity);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pmc_missions", "onPickupWeapon"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("pmc_missions", "onPickupWeapon")]](player, weaponobj);

    if(!istrue(success))
      return;
  } else {
    _id_6A80B9F81CD7AD99 = undefined;

    if(getdvarint("dvar_1903EE79B0FFFB17", 0))
      _id_6A80B9F81CD7AD99 = _id_2D9D24F7C63AC143::_id_AE22C70A9C2474D9();

    _id_7591ED99E87A77D3 = undefined;

    if(_id_F3557CAF4562BFF7(_id_69E96A4CAA72D794))
      _id_7591ED99E87A77D3 = _id_69E96A4CAA72D794.origin;

    _id_10BBEACB1429824E = _id_7E52B56769FA7774::_id_FE539E37B6579930(lootid, quantity, _id_6A80B9F81CD7AD99, undefined, undefined, undefined, _id_96C7526F4AB04875, _id_7591ED99E87A77D3);

    if(!isDefined(_id_10BBEACB1429824E))
      return;
  }

  _id_60D2295CCC45D8C0(player, lootid, quantity, _id_69E96A4CAA72D794);

  if(_id_F3557CAF4562BFF7(_id_69E96A4CAA72D794)) {
    player setclientomnvar("loot_container_open", 0);
    _id_69E96A4CAA72D794 notify("closed");
    _id_7E52B56769FA7774::loothide(_id_69E96A4CAA72D794);
    return;
  }

  _id_4327207228CE0185 = lootid;
  lootid = scripts\engine\utility::ter_op(_id_10BBEACB1429824E == 0, 0, lootid);
  _id_153D3281E46E14DA(player, _id_69E96A4CAA72D794, index, lootid, quantity);
  _id_F3C9E05D4767D037(_id_4327207228CE0185, player, _id_69E96A4CAA72D794, index);
}

_id_F0617AD70B7E7792(_id_8817E4FBE0F63228, _id_EBBCB5A184F5C67B, _id_69E96A4CAA72D794) {
  if(!isalive(self)) {
    return;
  }
  if(_id_F3557CAF4562BFF7(_id_69E96A4CAA72D794) && isDefined(self._id_0E0C39101BFC15D2) && istrue(self._id_0E0C39101BFC15D2[_id_EBBCB5A184F5C67B])) {
    self setclientomnvar("loot_container_open", 0);
    _id_69E96A4CAA72D794 notify("closed");
    return;
  }

  if(_id_EBBCB5A184F5C67B == 100) {
    if(istrue(self._id_859654E0445A36D9) && isDefined(level.br_pickups._id_355CDDB773CB000D)) {
      scripts\mp\hud_message::showerrormessage(level.br_pickups._id_355CDDB773CB000D);
      return;
    }

    if(_id_2D9D24F7C63AC143::_id_EFAB78B72D131D76(self)) {
      _id_FCBB55496A5BA4CB = _id_2D9D24F7C63AC143::_id_2985254128B1C262(self);
      _id_45D3E9C928EE2A64 = getcompleteweaponname(_id_FCBB55496A5BA4CB);
      dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

      if(isDefined(_id_69E96A4CAA72D794.dropstruct))
        dropstruct = _id_69E96A4CAA72D794.dropstruct;

      _id_7591ED99E87A77D3 = undefined;

      if(_id_F3557CAF4562BFF7(_id_69E96A4CAA72D794))
        _id_7591ED99E87A77D3 = _id_69E96A4CAA72D794.origin;

      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, undefined, undefined, undefined, undefined, _id_7591ED99E87A77D3);
      item = _id_7E52B56769FA7774::spawnpickup(_id_45D3E9C928EE2A64, _id_CB4FAD49263E20C4, 1, 1, _id_FCBB55496A5BA4CB, 0);
      _id_96C4059AA2EABFB8 = undefined;

      if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7()) {
        _id_96C4059AA2EABFB8 = _id_0B7A9CE0A2282B79::_id_74031E3249A6F69E(self, 2);

        if(isDefined(_id_96C4059AA2EABFB8))
          item._id_4E479E14D0837E84 = _id_96C4059AA2EABFB8;
      }

      item._id_E1147886CCF51970 = _id_724736FCF0FB6604::_id_86A5C7670325346B(self, 2);
      _id_2D9D24F7C63AC143::_id_954372D604277278(self);
    }

    [lootid, weaponobj, _id_E1147886CCF51970, _id_4E479E14D0837E84, quantity, _, _id_CF4FD93A53325100] = _id_775A7FC396485A9A(self, _id_69E96A4CAA72D794, _id_8817E4FBE0F63228);

    if(!isDefined(weaponobj)) {
      return;
    }
    quantity = scripts\engine\utility::_id_53C4C53197386572(quantity, weaponclipsize(weaponobj));
    self setweaponammoclip(weaponobj, quantity);

    if(scripts\mp\utility\weapon::isakimbo(weaponobj)) {
      _id_CF4FD93A53325100 = scripts\engine\utility::_id_53C4C53197386572(_id_CF4FD93A53325100, weaponclipsize(weaponobj));
      self setweaponammoclip(weaponobj, _id_CF4FD93A53325100, "left");
    }

    _id_2D9D24F7C63AC143::_id_E35A7CB7E7C8C17E(self, weaponobj, 1);
    _id_724736FCF0FB6604::_id_AE30366A2D519A57(self, 2, _id_E1147886CCF51970);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pmc_missions", "onPickupWeapon"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("pmc_missions", "onPickupWeapon")]](self, weaponobj, _id_4E479E14D0837E84);

    _id_505E8EB7E77704C5(self, _id_69E96A4CAA72D794, _id_8817E4FBE0F63228);
    return;
  }

  [_id_879D3E9D5C72B703, _id_EA1DCC638E88B8C9] = _id_EDB397974AE6EE68(self, _id_69E96A4CAA72D794, _id_8817E4FBE0F63228);
  _id_B358C0DF5898A29B = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(_id_879D3E9D5C72B703);
  [_id_F27898E4AFD922B4, _id_DFAB44D4D8D10B36] = _id_2D9D24F7C63AC143::_id_6738846DA50730F1(_id_EBBCB5A184F5C67B);
  _id_2789584B4D4CB228 = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(_id_F27898E4AFD922B4);
  _id_AB2190C9F802C652 = isDefined(_id_B358C0DF5898A29B) && _id_55E418C5CC946593::_id_43044DA0ED44D79F(_id_B358C0DF5898A29B);
  _id_FA65D19C2D55B80D = isDefined(_id_2789584B4D4CB228) && _id_55E418C5CC946593::_id_43044DA0ED44D79F(_id_2789584B4D4CB228);
  _id_03C295612E84D714 = isDefined(_id_2789584B4D4CB228) && _id_7E52B56769FA7774::_id_E4B6260DBB04B43D(_id_2789584B4D4CB228);

  if(_id_FA65D19C2D55B80D) {
    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

    if(isDefined(_id_69E96A4CAA72D794.dropstruct))
      dropstruct = _id_69E96A4CAA72D794.dropstruct;

    dropstruct._id_DFBA5A2C3C6F0A07 = _id_EBBCB5A184F5C67B;
    _id_7591ED99E87A77D3 = undefined;

    if(_id_F3557CAF4562BFF7(_id_69E96A4CAA72D794))
      _id_7591ED99E87A77D3 = _id_69E96A4CAA72D794.origin;

    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, undefined, undefined, undefined, undefined, _id_7591ED99E87A77D3);
    perkdata = _id_55E418C5CC946593::_id_3634D41E203BC04E(_id_EBBCB5A184F5C67B);

    if(isDefined(perkdata.perks)) {
      _id_CB4FAD49263E20C4._id_A0597A25C511B0AC = ["stat_371D996051B67A4A"];

      foreach(perk in perkdata.perks)
      _id_CB4FAD49263E20C4._id_A0597A25C511B0AC[_id_CB4FAD49263E20C4._id_A0597A25C511B0AC.size] = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(perk);
    }

    item = _id_7E52B56769FA7774::spawnpickup(_id_2789584B4D4CB228, _id_CB4FAD49263E20C4, _id_DFAB44D4D8D10B36, 1, undefined, 0);
    _id_55E418C5CC946593::_id_BBB44BD3B8347EFC(_id_EBBCB5A184F5C67B, item);
  } else if(_id_03C295612E84D714) {
    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

    if(isDefined(_id_69E96A4CAA72D794.dropstruct))
      dropstruct = _id_69E96A4CAA72D794.dropstruct;

    _id_7591ED99E87A77D3 = undefined;

    if(_id_F3557CAF4562BFF7(_id_69E96A4CAA72D794))
      _id_7591ED99E87A77D3 = _id_69E96A4CAA72D794.origin;

    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, undefined, undefined, undefined, undefined, _id_7591ED99E87A77D3);
    _id_728FFCEE8CBF30EE::_id_3A7809BE256ADADB(_id_CB4FAD49263E20C4, self);
    _id_F7806D4CF24AACD3 = _id_7E52B56769FA7774::spawnpickup(_id_2789584B4D4CB228, _id_CB4FAD49263E20C4, _id_DFAB44D4D8D10B36, 1, undefined, 0);
    _id_728FFCEE8CBF30EE::_id_A5130B39363778B7(self, _id_F7806D4CF24AACD3, _id_EBBCB5A184F5C67B);
  } else if(_id_7E52B56769FA7774::_id_282D89F7705A2D63(_id_2789584B4D4CB228))
    _id_7E52B56769FA7774::_id_BFC82C27ED3D9308(_id_F27898E4AFD922B4, _id_DFAB44D4D8D10B36, _id_2789584B4D4CB228, _id_EBBCB5A184F5C67B);

  _id_2D9D24F7C63AC143::_id_DB1DD76061352E5B(_id_EBBCB5A184F5C67B, _id_DFAB44D4D8D10B36);
  _id_60227BFF1E9478CC = spawnStruct();
  _id_60227BFF1E9478CC.scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(_id_879D3E9D5C72B703);
  _id_60227BFF1E9478CC.count = _id_EA1DCC638E88B8C9;
  _id_60227BFF1E9478CC._id_8598D3D3BC3D9CEB = 1;
  _id_60227BFF1E9478CC.origin = _id_69E96A4CAA72D794.origin;
  _id_60227BFF1E9478CC.dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

  if(_id_7E52B56769FA7774::_id_02D86BA79A58BB62(_id_60227BFF1E9478CC.scriptablename)) {
    _id_60227BFF1E9478CC._id_1FAF51A7DC279A8B = _id_69E96A4CAA72D794._id_1FAF51A7DC279A8B;
    _id_60227BFF1E9478CC._id_B939ABDEDC45C697 = _id_69E96A4CAA72D794._id_B939ABDEDC45C697;
  }

  if(_id_AB2190C9F802C652) {
    _id_55E418C5CC946593::_id_1CA82D98D7519E1F(_id_EBBCB5A184F5C67B, _id_69E96A4CAA72D794);
    _id_2D9D24F7C63AC143::_id_11F48AE5B87B4525(self, _id_EBBCB5A184F5C67B, _id_879D3E9D5C72B703, 1);
  } else if(_id_2391409EF7B431E1::_id_03C17A26CE6A4668(_id_879D3E9D5C72B703) && _id_2391409EF7B431E1::_id_D9F5C5090DE1241B(self, _id_EA1DCC638E88B8C9)) {
    [_id_C9CCB7804978DC9F, _] = _id_2391409EF7B431E1::_id_E92E13020D5EE099(_id_EA1DCC638E88B8C9);
    _id_773F62BF746FC586 = level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F].player;

    if(isDefined(_id_773F62BF746FC586))
      _id_2391409EF7B431E1::_id_8E643D6706DEFEEA(_id_773F62BF746FC586, _id_EA1DCC638E88B8C9);

    if(!isDefined(_id_773F62BF746FC586) || _id_773F62BF746FC586 != self)
      _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_recover_dog_tag", [self], undefined);
  } else {
    _id_2D9D24F7C63AC143::_id_10F6E537F1B5763C(_id_879D3E9D5C72B703, _id_60227BFF1E9478CC);
    _id_7E52B56769FA7774::_id_A74604666BDE595B(_id_60227BFF1E9478CC);
    _id_7E52B56769FA7774::_id_EFDDDF60C5DB058C(_id_60227BFF1E9478CC);

    if(!_id_F3557CAF4562BFF7(_id_69E96A4CAA72D794))
      _id_60D2295CCC45D8C0(self, _id_879D3E9D5C72B703, _id_EA1DCC638E88B8C9, _id_69E96A4CAA72D794);
    else
      _id_7E52B56769FA7774::_id_56DD1FAA25A3414F(self, _id_60227BFF1E9478CC, 20);
  }

  if(!getdvarint("dvar_8B40BEE5A7E0FC04", 0) || _id_F3557CAF4562BFF7(_id_69E96A4CAA72D794) || _id_54066DBD8EF44FE1(_id_69E96A4CAA72D794)) {
    _id_153D3281E46E14DA(self, _id_69E96A4CAA72D794, _id_8817E4FBE0F63228, 0, 0);
    maxcount = level.br_pickups._id_04138F9DDC1CD22D[_id_60227BFF1E9478CC.scriptablename];

    if(!isDefined(maxcount) || maxcount == 0)
      maxcount = level.br_pickups.maxcounts[_id_60227BFF1E9478CC.scriptablename];

    dropstruct = _id_60227BFF1E9478CC.dropstruct;

    if(isDefined(_id_69E96A4CAA72D794.dropstruct))
      dropstruct = _id_69E96A4CAA72D794.dropstruct;

    if(!_id_FA65D19C2D55B80D && !_id_03C295612E84D714) {
      _id_7591ED99E87A77D3 = undefined;
      _id_284FD7F2566F4EB5 = 1;
      scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(_id_F27898E4AFD922B4);

      if(_id_F3557CAF4562BFF7(_id_69E96A4CAA72D794)) {
        if(getdvarint("dvar_8367F78074282EF0", 0) && istrue(_id_69E96A4CAA72D794._id_0343C584E7E00192)) {
          _id_8691AF1F100B771F = level.br_pickups.br_itemtype[_id_60227BFF1E9478CC.scriptablename];
          _id_14AB898D93FD9B3F = level.br_pickups.br_itemtype[scriptablename];

          if(isDefined(_id_8691AF1F100B771F) && isDefined(_id_14AB898D93FD9B3F) && _id_8691AF1F100B771F == _id_14AB898D93FD9B3F) {
            _id_7E52B56769FA7774::_id_FE539E37B6579930(_id_F27898E4AFD922B4, _id_DFAB44D4D8D10B36);
            _id_284FD7F2566F4EB5 = 0;
          }
        }

        if(!istrue(_id_69E96A4CAA72D794._id_0343C584E7E00192) && dropstruct.dropcount < 1)
          _id_7591ED99E87A77D3 = _id_69E96A4CAA72D794.origin;
      }

      if(_id_284FD7F2566F4EB5) {
        if(_id_7E52B56769FA7774::_id_02D86BA79A58BB62(scriptablename))
          _id_744CAD313ED0A87E::_id_F9FF7C89B3792CCC(dropstruct, self._id_1FAF51A7DC279A8B);
        else {
          _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, undefined, undefined, undefined, undefined, _id_7591ED99E87A77D3);
          _id_0E14905A4CDF3B12 = _id_7E52B56769FA7774::spawnpickup(scriptablename, _id_CB4FAD49263E20C4, _id_DFAB44D4D8D10B36, 1, undefined, 0);

          if(isDefined(_id_0E14905A4CDF3B12)) {
            self notify("swapped_item_on_full_backpack", scriptablename);
            scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2(scriptablename, "dropped", _id_0E14905A4CDF3B12, self, _id_CB4FAD49263E20C4.origin);
          }
        }
      }
    }
  } else {
    _id_153D3281E46E14DA(self, _id_69E96A4CAA72D794, _id_8817E4FBE0F63228, _id_F27898E4AFD922B4, _id_DFAB44D4D8D10B36);

    if(getdvarint("dvar_C85A9BCC06A81A1F", 0)) {
      if(!isDefined(_id_69E96A4CAA72D794._id_2568210352BE1ECF))
        _id_69E96A4CAA72D794._id_2568210352BE1ECF = [];

      _id_69E96A4CAA72D794._id_2568210352BE1ECF[_id_8817E4FBE0F63228] = [];
      _id_69E96A4CAA72D794._id_2568210352BE1ECF[_id_8817E4FBE0F63228]["lootID"] = _id_F27898E4AFD922B4;
      _id_69E96A4CAA72D794._id_2568210352BE1ECF[_id_8817E4FBE0F63228]["quantity"] = _id_DFAB44D4D8D10B36;
    }
  }

  if(_id_F3557CAF4562BFF7(_id_69E96A4CAA72D794)) {
    self setclientomnvar("loot_container_open", 0);
    _id_69E96A4CAA72D794 notify("closed");
    _id_7E52B56769FA7774::loothide(_id_69E96A4CAA72D794);
  }

  _id_F3C9E05D4767D037(_id_879D3E9D5C72B703, self, _id_69E96A4CAA72D794, _id_8817E4FBE0F63228);
}

_id_E183B2E94298BB75(loadoutindex, player, _id_69E96A4CAA72D794, itemtype) {
  if(istrue(player._id_859654E0445A36D9) && isDefined(level.br_pickups._id_355CDDB773CB000D)) {
    player scripts\mp\hud_message::showerrormessage(level.br_pickups._id_355CDDB773CB000D);
    return;
  }

  [lootid, _id_6FB67C8525B1D79E, _id_E1147886CCF51970, _id_4E479E14D0837E84, quantity, _, _] = _id_775A7FC396485A9A(player, _id_69E96A4CAA72D794);

  if(!isDefined(_id_6FB67C8525B1D79E)) {
    return;
  }
  _id_7E52B56769FA7774::_id_62F068CEC343A111(player, 1, loadoutindex - 1, undefined, 0, 0);
  _id_45D3E9C928EE2A64 = getcompleteweaponname(_id_6FB67C8525B1D79E);
  _id_0D8AEA6BBFACDFF1 = undefined;

  if(isDefined(_id_6FB67C8525B1D79E.basename))
    _id_0D8AEA6BBFACDFF1 = _id_6FB67C8525B1D79E.basename;
  else
    _id_0D8AEA6BBFACDFF1 = getweaponbasename(_id_6FB67C8525B1D79E);

  _id_7591ED99E87A77D3 = undefined;

  if(_id_F3557CAF4562BFF7(_id_69E96A4CAA72D794))
    _id_7591ED99E87A77D3 = _id_69E96A4CAA72D794.origin;

  success = _id_724736FCF0FB6604::br_forcegivecustomweapon(player, _id_6FB67C8525B1D79E, _id_45D3E9C928EE2A64, _id_0D8AEA6BBFACDFF1, undefined, undefined, _id_7591ED99E87A77D3, undefined, _id_E1147886CCF51970);

  if(success) {
    weaponslot = 0;
    _id_5CEDEAA00F81A480 = _id_7E52B56769FA7774::_id_13ECF3644442A3E7(player, 0);
    _id_1859B2A5C0F86ED0 = _id_7E52B56769FA7774::_id_13ECF3644442A3E7(player, 1);

    if(isDefined(_id_5CEDEAA00F81A480) && _id_5CEDEAA00F81A480 == _id_6FB67C8525B1D79E)
      weaponslot = 0;
    else if(isDefined(_id_1859B2A5C0F86ED0) && _id_1859B2A5C0F86ED0 == _id_6FB67C8525B1D79E)
      weaponslot = 1;

    scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("pmc_missions", "onPickupWeapon", player, _id_6FB67C8525B1D79E, _id_4E479E14D0837E84);
    _id_0B7A9CE0A2282B79::_id_5D94B2DFABBC4CCE(player, _id_6FB67C8525B1D79E, weaponslot, 1, _id_4E479E14D0837E84);
    _id_505E8EB7E77704C5(player, _id_69E96A4CAA72D794);

    if(_id_F3557CAF4562BFF7(_id_69E96A4CAA72D794)) {
      player setclientomnvar("loot_container_open", 0);
      _id_69E96A4CAA72D794 notify("closed");
      _id_7E52B56769FA7774::loothide(_id_69E96A4CAA72D794);
    }
  }
}

_id_68CA06034B8AACCD(opener, _id_69E96A4CAA72D794) {
  [items, _id_77DC0A100921C5A7] = _id_0438749EB7A7B738(_id_69E96A4CAA72D794.contents, opener, _id_69E96A4CAA72D794);
  _id_69E96A4CAA72D794.contents = items;
  opener._id_02FA5B49969DEF47 = _id_69E96A4CAA72D794;
  opener._id_F2AA9AE949179907 = opener.origin;

  if(isDefined(_id_69E96A4CAA72D794._id_BF8E5F003146AF44))
    opener._id_F2AA9AE949179907 = rotatevectorinverted(opener.origin - _id_69E96A4CAA72D794._id_BF8E5F003146AF44.origin, _id_69E96A4CAA72D794._id_BF8E5F003146AF44.angles);

  if(items.size > 11) {}

  for(_id_3793828403C6873E = 0; _id_3793828403C6873E < 11; _id_3793828403C6873E++) {
    if(_id_3793828403C6873E <= _id_77DC0A100921C5A7) {
      _id_446C7AD7BCC70992(opener, _id_69E96A4CAA72D794, _id_3793828403C6873E, items[_id_3793828403C6873E]["lootID"], items[_id_3793828403C6873E]["quantity"], items[_id_3793828403C6873E]["ref"]);
      continue;
    }

    _id_C7294F5B9B5006D5(opener, _id_3793828403C6873E);
  }

  opener setclientomnvar("loot_container_weapon", 0);

  if(!isDefined(_id_69E96A4CAA72D794._id_46A3A8565AC0C17C))
    _id_69E96A4CAA72D794._id_46A3A8565AC0C17C = 1;

  _id_46A3A8565AC0C17C = _id_69E96A4CAA72D794._id_46A3A8565AC0C17C;

  foreach(player in level.players)
  _id_69E96A4CAA72D794 disablescriptableplayeruse(player);

  opener setclientomnvar("loot_container_open", _id_46A3A8565AC0C17C);
  _id_69E96A4CAA72D794 thread _id_71A59F067D5FE986(_id_69E96A4CAA72D794, opener);
  _id_69E96A4CAA72D794 thread _id_47B931D76FFD028F(_id_69E96A4CAA72D794, opener);
  opener scripts\cp_mp\calloutmarkerping::_id_FAA3CBEC7243FE72();
}

_id_601D9AFC257AF3FF(player, _id_E1D097C517C3AF5B, _id_69E96A4CAA72D794, _id_CC768FF46F3F6339, quantity) {
  if(isDefined(_id_69E96A4CAA72D794) && _id_F3557CAF4562BFF7(_id_69E96A4CAA72D794)) {
    return;
  }
  if(_id_E1D097C517C3AF5B == 100)
    _id_A335AA664CAA37C9(player, _id_69E96A4CAA72D794);
  else {
    _id_9D924AEA120C2693(player, _id_E1D097C517C3AF5B, _id_69E96A4CAA72D794);
    _id_2F00CA0526F3EDC6(player, _id_E1D097C517C3AF5B, quantity, _id_69E96A4CAA72D794, _id_CC768FF46F3F6339);
  }

  if(isDefined(_id_69E96A4CAA72D794) && _id_23A3BB1172216C05(_id_69E96A4CAA72D794, player) && _id_6F45E7311F77EAC4(player))
    _id_68085C72D7B628EC(_id_69E96A4CAA72D794, player);
}

_id_E146F016A8A7244F(_id_EA3E3B2121E6713A, _id_E1D097C517C3AF5B) {
  if(istrue(level.infilcinematicactive)) {
    return;
  }
  if(isDefined(_id_EA3E3B2121E6713A)) {
    if(!isDefined(self._id_02FA5B49969DEF47)) {
      return;
    }
    _id_69E96A4CAA72D794 = self._id_02FA5B49969DEF47;

    switch (_id_EA3E3B2121E6713A) {
      case "loot_container":
        _id_601D9AFC257AF3FF(self, _id_E1D097C517C3AF5B, _id_69E96A4CAA72D794, undefined, 1);
        break;
      case "loot_all_container":
        _id_601D9AFC257AF3FF(self, _id_E1D097C517C3AF5B, _id_69E96A4CAA72D794);
        break;
      case "equip_loot_container":
        loadoutindex = _id_E1D097C517C3AF5B >> 8;
        itemtype = _id_E1D097C517C3AF5B & 255;

        if((itemtype == 3 || itemtype == 150) && loadoutindex != 0)
          _id_E183B2E94298BB75(loadoutindex, self, _id_69E96A4CAA72D794, itemtype);
        else if(_id_E1D097C517C3AF5B == 100 || itemtype == 150)
          _id_A92926D5B02CF6ED(self, _id_69E96A4CAA72D794, itemtype);
        else {
          _id_9D924AEA120C2693(self, itemtype, _id_69E96A4CAA72D794);
          _id_3AE3712FE76D0C6A(self, itemtype, loadoutindex, _id_69E96A4CAA72D794);
        }

        if(isDefined(_id_69E96A4CAA72D794) && _id_23A3BB1172216C05(_id_69E96A4CAA72D794, self) && _id_6F45E7311F77EAC4(self))
          _id_68085C72D7B628EC(_id_69E96A4CAA72D794, self);

        break;
      case "close_loot_container":
        if(isDefined(_id_69E96A4CAA72D794))
          _id_68085C72D7B628EC(_id_69E96A4CAA72D794, self);

        break;
      case "loot_to_specific_slot":
        _id_8817E4FBE0F63228 = _id_E1D097C517C3AF5B >> 8;
        _id_EBBCB5A184F5C67B = _id_E1D097C517C3AF5B & 255;

        if(_id_6F45E7311F77EAC4(self) && isDefined(_id_69E96A4CAA72D794))
          _id_F0617AD70B7E7792(_id_8817E4FBE0F63228, _id_EBBCB5A184F5C67B, _id_69E96A4CAA72D794);

        if(isDefined(_id_69E96A4CAA72D794) && _id_23A3BB1172216C05(_id_69E96A4CAA72D794, self) && _id_6F45E7311F77EAC4(self))
          _id_68085C72D7B628EC(_id_69E96A4CAA72D794, self);

        break;
      default:
        break;
    }
  }
}

_id_9D924AEA120C2693(player, _id_E1D097C517C3AF5B, _id_69E96A4CAA72D794) {
  if(_id_C26E54FFD0C8BE94(_id_69E96A4CAA72D794, _id_E1D097C517C3AF5B)) {
    return;
  }
  lootid = _id_F478CA9D3C44018C(player, _id_E1D097C517C3AF5B, _id_69E96A4CAA72D794);
  _id_35EABFFB2F0F31E3 = _id_8E5978971B5DCD16(player, _id_E1D097C517C3AF5B, _id_69E96A4CAA72D794);

  if(lootid == 0 || _id_35EABFFB2F0F31E3 == 0) {
    return;
  }
  _id_4AB0C4B064F3C0BA = _id_59B9C8081B873A10(player, _id_69E96A4CAA72D794);
  contents = _id_4AB0C4B064F3C0BA.contents;

  if(isDefined(contents[_id_E1D097C517C3AF5B]) && isDefined(contents[_id_E1D097C517C3AF5B]["callback"]))
    thread[[self._id_02FA5B49969DEF47.contents[_id_E1D097C517C3AF5B]["callback"]]](self._id_02FA5B49969DEF47, player);
}

_id_55B384ECB923003E() {
  return getdvarint("dvar_F86A28F69E6CCC38", 1) == 1;
}

_id_C929A8AD95B46FDA(_id_69E96A4CAA72D794) {
  if(isDefined(_id_69E96A4CAA72D794.type) && _id_69E96A4CAA72D794.type == "br_loot_cache_april")
    return 0;

  if(scripts\mp\utility\game::getsubgametype() == "dmz" && !getdvarint("dvar_597831555A246842", 0))
    return 1;

  if(isDefined(_id_69E96A4CAA72D794.type) && _id_69E96A4CAA72D794.type != "br_loot_cache" && _id_69E96A4CAA72D794.type != "br_reusable_loot_cache" && _id_69E96A4CAA72D794.type != "br_loot_cache_lege" && _id_69E96A4CAA72D794.type != "br_loot_cache_gulag" && _id_69E96A4CAA72D794.type != "br_loot_cache_personal_supply" && _id_69E96A4CAA72D794.type != "br_loot_cache_stronghold" && _id_69E96A4CAA72D794.type != "br_loot_cache_blacksite" && _id_69E96A4CAA72D794.type != "cache_medicine_cabinet" && _id_69E96A4CAA72D794.type != "cache_cash_register" && _id_69E96A4CAA72D794.type != "cache_cash_register_clean" && _id_69E96A4CAA72D794.type != "cache_medical_box_wall" && _id_69E96A4CAA72D794.type != "dmz_hidden_container_common" && _id_69E96A4CAA72D794.type != "cache_duffel_bag_01" && _id_69E96A4CAA72D794.type != "cache_duffel_bag_02" && _id_69E96A4CAA72D794.type != "cache_weapon_locker")
    return 1;

  if(!getdvarint("dvar_F6C12CF19AC66121", 1))
    return 1;

  return 0;
}

_id_4749C1A092E650BD() {
  return getdvarint("dvar_1B2E1EF116B3DE36", 0) == 1;
}

_id_8306D72EA2E8889C() {
  return getdvarint("dvar_B692410C5B56FFB5", 1) == 1;
}

_id_310AB06891CB4517() {
  return _id_4749C1A092E650BD() || _id_8306D72EA2E8889C() || _id_55B384ECB923003E();
}

_id_EA8078BE364FF10F(_id_69E96A4CAA72D794, lootid, player) {
  if(!isDefined(_id_69E96A4CAA72D794))
    return [undefined, undefined];

  _id_69E96A4CAA72D794 = _id_59B9C8081B873A10(player, _id_69E96A4CAA72D794);

  if(!isDefined(_id_69E96A4CAA72D794.contents) || !isDefined(lootid))
    return [undefined, undefined];

  if(_id_54066DBD8EF44FE1(_id_69E96A4CAA72D794)) {
    foreach(index, item in _id_69E96A4CAA72D794.contents) {
      if(!isDefined(item["lootID"]) || !isDefined(item["quantity"]) || item["lootID"] == 0 || item["quantity"] == 0) {
        continue;
      }
      if(item["lootID"] == lootid)
        return [index, 0];
    }

    if(isDefined(_id_69E96A4CAA72D794._id_BF23A60678978C19)) {
      foreach(index, item in _id_69E96A4CAA72D794._id_BF23A60678978C19) {
        if(!isDefined(item["lootID"]) || !isDefined(item["quantity"]) || item["lootID"] == 0 || item["quantity"] == 0) {
          continue;
        }
        if(item["lootID"] == lootid)
          return [index, 1];
      }
    }

    if(isDefined(_id_69E96A4CAA72D794._id_A06E7128C001851D) && isDefined(_id_69E96A4CAA72D794._id_A0E9FEF038504BD0) && lootid == _id_69E96A4CAA72D794._id_A06E7128C001851D)
      return [100, 1];
  }

  foreach(index, item in _id_69E96A4CAA72D794.contents) {
    if(!isDefined(item["lootID"]) || !isDefined(item["quantity"]) || item["lootID"] == 0 || item["quantity"] == 0) {
      continue;
    }
    if(item["lootID"] == lootid)
      return [index, 0];
  }

  if(isDefined(_id_69E96A4CAA72D794._id_04F6CDE716E0C3D7) && lootid == _id_69E96A4CAA72D794._id_04F6CDE716E0C3D7)
    return [100, 0];

  return [undefined, undefined];
}

_id_59B9C8081B873A10(opener, _id_69E96A4CAA72D794) {
  if(_id_E3081772BBF7A51C(opener, _id_69E96A4CAA72D794))
    return _id_3AAE4431F00C347F(opener, _id_69E96A4CAA72D794);

  return _id_69E96A4CAA72D794;
}

_id_EDB397974AE6EE68(opener, _id_69E96A4CAA72D794, index, _id_CC768FF46F3F6339) {
  _id_042DCD1DAFC60CA9 = _id_C26E54FFD0C8BE94(_id_69E96A4CAA72D794, index);

  if(_id_042DCD1DAFC60CA9) {
    index = index - 11;
    lootid = _id_4DF382B17698F0C5(_id_69E96A4CAA72D794, index, _id_CC768FF46F3F6339);
    _id_35EABFFB2F0F31E3 = _id_DC8D7C1709ADCD67(_id_69E96A4CAA72D794, index, _id_CC768FF46F3F6339);
  } else {
    lootid = _id_F478CA9D3C44018C(opener, index, _id_69E96A4CAA72D794, _id_CC768FF46F3F6339);
    _id_35EABFFB2F0F31E3 = _id_8E5978971B5DCD16(opener, index, _id_69E96A4CAA72D794, _id_CC768FF46F3F6339);
  }

  return [lootid, _id_35EABFFB2F0F31E3];
}

_id_3F23DFE9EB1BEE5F(opener, _id_69E96A4CAA72D794, index, quantity) {
  if(!isDefined(_id_69E96A4CAA72D794)) {
    return;
  }
  if(_id_C26E54FFD0C8BE94(_id_69E96A4CAA72D794, index))
    _id_69E96A4CAA72D794._id_BF23A60678978C19[index - 11]["quantity"] = quantity;
  else if(_id_E3081772BBF7A51C(opener, _id_69E96A4CAA72D794))
    _id_69E96A4CAA72D794._id_556DB0B72A96514E[opener.guid].contents[index]["quantity"] = quantity;
  else
    _id_69E96A4CAA72D794.contents[index]["quantity"] = quantity;
}

_id_69532A81D0171769(opener, _id_69E96A4CAA72D794, index, lootid) {
  if(!isDefined(_id_69E96A4CAA72D794)) {
    return;
  }
  if(_id_C26E54FFD0C8BE94(_id_69E96A4CAA72D794, index))
    _id_69E96A4CAA72D794._id_BF23A60678978C19[index - 11]["lootID"] = lootid;
  else if(_id_E3081772BBF7A51C(opener, _id_69E96A4CAA72D794))
    _id_69E96A4CAA72D794._id_556DB0B72A96514E[opener.guid].contents[index]["lootID"] = lootid;
  else
    _id_69E96A4CAA72D794.contents[index]["lootID"] = lootid;
}

_id_153D3281E46E14DA(opener, _id_69E96A4CAA72D794, index, lootid, quantity) {
  if(!isDefined(_id_69E96A4CAA72D794) || !isDefined(opener) || !isDefined(index) || !isDefined(lootid) || !isDefined(quantity)) {
    return;
  }
  lootid = scripts\engine\utility::ter_op(lootid > 0, lootid, 0);
  quantity = scripts\engine\utility::ter_op(quantity > 0, quantity, 0);

  if(lootid == 0 || quantity == 0) {
    lootid = 0;
    quantity = 0;
  }

  _id_69532A81D0171769(opener, _id_69E96A4CAA72D794, index, lootid);
  _id_3F23DFE9EB1BEE5F(opener, _id_69E96A4CAA72D794, index, quantity);
  _id_C3EE5296B29CB5F6 = _id_59B9C8081B873A10(opener, _id_69E96A4CAA72D794);
  _id_446C7AD7BCC70992(opener, _id_C3EE5296B29CB5F6, index, lootid, quantity);
}

_id_0C3D68FB7B175EDD(opener, _id_69E96A4CAA72D794) {
  if(!isDefined(_id_69E96A4CAA72D794))
    return 0;

  if(isDefined(_id_69E96A4CAA72D794._id_A06E7128C001851D) && isDefined(_id_69E96A4CAA72D794._id_A0E9FEF038504BD0))
    return 1;

  _id_4AB0C4B064F3C0BA = _id_59B9C8081B873A10(opener, _id_69E96A4CAA72D794);
  return isDefined(_id_4AB0C4B064F3C0BA._id_04F6CDE716E0C3D7) && isDefined(_id_4AB0C4B064F3C0BA._id_6FB67C8525B1D79E);
}

_id_775A7FC396485A9A(opener, _id_69E96A4CAA72D794, index) {
  weaponref = _id_4B96AA12974840C0(opener, _id_69E96A4CAA72D794, index);

  if(isDefined(weaponref)) {
    lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(weaponref);
    weaponobj = _id_7E52B56769FA7774::getfullweaponobjforscriptablepartname(weaponref);
    return [lootid, weaponobj, undefined, undefined, weaponclipsize(weaponobj)];
  }

  if(!_id_0C3D68FB7B175EDD(opener, _id_69E96A4CAA72D794))
    return [undefined, undefined, undefined, undefined, undefined];

  lootid = undefined;
  weaponobj = undefined;
  _id_E1147886CCF51970 = undefined;
  _id_4E479E14D0837E84 = undefined;
  quantity = undefined;
  _id_18C2C5B0A787D075 = undefined;
  _id_CF4FD93A53325100 = undefined;

  if(isDefined(_id_69E96A4CAA72D794._id_A06E7128C001851D) && isDefined(_id_69E96A4CAA72D794._id_A0E9FEF038504BD0)) {
    lootid = _id_69E96A4CAA72D794._id_A06E7128C001851D;
    weaponobj = _id_69E96A4CAA72D794._id_A0E9FEF038504BD0;
    _id_E1147886CCF51970 = _id_69E96A4CAA72D794._id_C31356A794D8CB46;
    _id_4E479E14D0837E84 = _id_69E96A4CAA72D794._id_BB6791B7369EF71A;
    quantity = _id_69E96A4CAA72D794._id_27990AA12DECFFDD;
    _id_18C2C5B0A787D075 = _id_69E96A4CAA72D794._id_49CD0247F1C08A6E;
    _id_CF4FD93A53325100 = _id_69E96A4CAA72D794._id_C693663E1BBDD8E9;
  } else {
    _id_C3EE5296B29CB5F6 = _id_59B9C8081B873A10(opener, _id_69E96A4CAA72D794);
    lootid = _id_C3EE5296B29CB5F6._id_04F6CDE716E0C3D7;
    weaponobj = _id_C3EE5296B29CB5F6._id_6FB67C8525B1D79E;
    _id_E1147886CCF51970 = _id_C3EE5296B29CB5F6._id_275F4441AB7920C8;
    _id_4E479E14D0837E84 = _id_C3EE5296B29CB5F6._id_4E479E14D0837E84;
    quantity = _id_C3EE5296B29CB5F6._id_3EF503345DC57957;
    _id_18C2C5B0A787D075 = _id_C3EE5296B29CB5F6._id_86B32AFF94B5714E;
    _id_CF4FD93A53325100 = _id_C3EE5296B29CB5F6._id_00AD7897ECDBCB63;
  }

  return [lootid, weaponobj, _id_E1147886CCF51970, _id_4E479E14D0837E84, quantity, _id_18C2C5B0A787D075, _id_CF4FD93A53325100];
}

_id_505E8EB7E77704C5(opener, _id_69E96A4CAA72D794, index) {
  if(_id_430DF78A3A4143C1(opener, _id_69E96A4CAA72D794, index)) {
    _id_153D3281E46E14DA(opener, _id_69E96A4CAA72D794, index, 0, 0);
    return;
  }

  if(_id_E3081772BBF7A51C(opener, _id_69E96A4CAA72D794)) {
    _id_69E96A4CAA72D794._id_556DB0B72A96514E[opener.guid]._id_6FB67C8525B1D79E = undefined;
    _id_69E96A4CAA72D794._id_556DB0B72A96514E[opener.guid]._id_04F6CDE716E0C3D7 = 0;
    _id_69E96A4CAA72D794._id_556DB0B72A96514E[opener.guid]._id_4E479E14D0837E84 = undefined;
    _id_69E96A4CAA72D794._id_556DB0B72A96514E[opener.guid]._id_275F4441AB7920C8 = undefined;
    _id_69E96A4CAA72D794._id_556DB0B72A96514E[opener.guid]._id_3EF503345DC57957 = undefined;
    _id_69E96A4CAA72D794._id_556DB0B72A96514E[opener.guid]._id_00AD7897ECDBCB63 = undefined;
    _id_69E96A4CAA72D794._id_556DB0B72A96514E[opener.guid]._id_86B32AFF94B5714E = undefined;
  } else if(isDefined(_id_69E96A4CAA72D794._id_A06E7128C001851D) && isDefined(_id_69E96A4CAA72D794._id_A0E9FEF038504BD0)) {
    _id_69E96A4CAA72D794._id_A0E9FEF038504BD0 = undefined;
    _id_69E96A4CAA72D794._id_A06E7128C001851D = 0;
    _id_69E96A4CAA72D794._id_BB6791B7369EF71A = undefined;
    _id_69E96A4CAA72D794._id_C31356A794D8CB46 = undefined;
    _id_69E96A4CAA72D794._id_27990AA12DECFFDD = undefined;
    _id_69E96A4CAA72D794._id_49CD0247F1C08A6E = undefined;
    _id_69E96A4CAA72D794._id_C693663E1BBDD8E9 = undefined;
    _id_7F855164A30A5F5F(opener);
    return;
  } else {
    _id_69E96A4CAA72D794._id_6FB67C8525B1D79E = undefined;
    _id_69E96A4CAA72D794._id_04F6CDE716E0C3D7 = 0;
    _id_69E96A4CAA72D794._id_4E479E14D0837E84 = undefined;
    _id_69E96A4CAA72D794._id_275F4441AB7920C8 = undefined;
    _id_69E96A4CAA72D794._id_3EF503345DC57957 = undefined;
    _id_69E96A4CAA72D794._id_86B32AFF94B5714E = undefined;
    _id_69E96A4CAA72D794._id_00AD7897ECDBCB63 = undefined;
  }

  opener setclientomnvar("loot_container_weapon", 0);
}

_id_67BE8D119FA22135(_id_69E96A4CAA72D794, lootid, weaponobj, _id_E1147886CCF51970, _id_338E098F5CBFDA5B, quantity, _id_4E479E14D0837E84, _id_35CD020CF27C8866, _id_CF4FD93A53325100) {
  _id_69E96A4CAA72D794._id_04F6CDE716E0C3D7 = lootid;
  _id_69E96A4CAA72D794._id_6FB67C8525B1D79E = weaponobj;
  _id_69E96A4CAA72D794._id_275F4441AB7920C8 = _id_E1147886CCF51970;
  _id_69E96A4CAA72D794._id_5A90D1A92F9AF4E3 = _id_338E098F5CBFDA5B;
  _id_69E96A4CAA72D794._id_3EF503345DC57957 = quantity;
  _id_69E96A4CAA72D794._id_00AD7897ECDBCB63 = _id_CF4FD93A53325100;
  _id_69E96A4CAA72D794._id_86B32AFF94B5714E = _id_35CD020CF27C8866;
  _id_69E96A4CAA72D794._id_4E479E14D0837E84 = _id_4E479E14D0837E84;
}

_id_A0952BC59C9AFA3F(player, _id_DFF481F07E235198, weaponobj, lootid, itemtype, _id_3793828403C6873E, quantity, _id_4E479E14D0837E84, _id_338E098F5CBFDA5B, _id_35CD020CF27C8866, _id_CF4FD93A53325100) {
  _id_E1147886CCF51970 = _id_724736FCF0FB6604::_id_1A561E5EF2ECA63A(player, weaponobj);

  if(isDefined(_id_DFF481F07E235198))
    _id_67BE8D119FA22135(_id_DFF481F07E235198, lootid, weaponobj, _id_E1147886CCF51970, _id_338E098F5CBFDA5B, quantity, _id_4E479E14D0837E84, _id_35CD020CF27C8866, _id_CF4FD93A53325100);
  else
    _id_67BE8D119FA22135(player._id_02FA5B49969DEF47, lootid, weaponobj, _id_E1147886CCF51970, _id_338E098F5CBFDA5B, quantity, _id_4E479E14D0837E84, _id_35CD020CF27C8866, _id_CF4FD93A53325100);

  _id_62AD0C002D54CBCC(player, _id_DFF481F07E235198, "loot_container_weapon", lootid, weaponobj);

  if(isDefined(itemtype) && isDefined(_id_3793828403C6873E))
    player thread _id_7E52B56769FA7774::quickdropitem(itemtype, _id_3793828403C6873E, 1);
}

_id_430DF78A3A4143C1(opener, _id_69E96A4CAA72D794, index) {
  if(!isDefined(opener) || !isDefined(_id_69E96A4CAA72D794) || !isDefined(index))
    return 0;

  _id_4AB0C4B064F3C0BA = _id_59B9C8081B873A10(opener, _id_69E96A4CAA72D794);
  return isDefined(_id_4AB0C4B064F3C0BA) && isDefined(_id_4AB0C4B064F3C0BA.contents[index]) && isDefined(_id_4AB0C4B064F3C0BA.contents[index]["ref"]);
}

_id_4B96AA12974840C0(opener, _id_69E96A4CAA72D794, index) {
  if(!_id_430DF78A3A4143C1(opener, _id_69E96A4CAA72D794, index))
    return undefined;

  _id_4AB0C4B064F3C0BA = _id_59B9C8081B873A10(opener, _id_69E96A4CAA72D794);
  return _id_4AB0C4B064F3C0BA.contents[index]["ref"];
}

_id_932E5252B650E475(opener, _id_69E96A4CAA72D794) {
  partname = _id_69E96A4CAA72D794 _meth_EC5F4851431F3382();

  if(_id_E3081772BBF7A51C(opener, _id_69E96A4CAA72D794))
    _id_9AD640BA63792064(opener, _id_69E96A4CAA72D794);
  else if(_id_69E96A4CAA72D794 getscriptableparthasstate(partname, "fully_opening_unusable"))
    _id_69E96A4CAA72D794 setscriptablepartstate(partname, "fully_opening_unusable");
}

_id_F3C9E05D4767D037(lootid, player, _id_69E96A4CAA72D794, index) {
  if(!_id_54066DBD8EF44FE1(_id_69E96A4CAA72D794) || !_id_7E52B56769FA7774::_id_B1E944A2B3E15E9D(_id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid)) || !_id_7EDA25C90CC3AAA1(index)) {
    return;
  }
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  baseorigin = _id_69E96A4CAA72D794.origin;
  baseangles = _id_69E96A4CAA72D794.angles;
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(baseorigin, baseangles);

  if(isDefined(_id_69E96A4CAA72D794._id_BF8E5F003146AF44))
    _id_CB4FAD49263E20C4.groundentity = _id_69E96A4CAA72D794._id_BF8E5F003146AF44;

  _id_B8DBA75F79D1BAA3 = _id_7E52B56769FA7774::loot_getitemcount(_id_69E96A4CAA72D794);
  _id_B63DD71EA2A6019D = _id_7E52B56769FA7774::loot_getitemcountlefthand(_id_69E96A4CAA72D794);
  _id_D00F368C9DF807CF = _id_7E52B56769FA7774::_id_3A5F7703319142DD(_id_69E96A4CAA72D794);
  _id_87583859F07B58E3 = _id_7E52B56769FA7774::spawnpickup("brloot_backpack_player_small", _id_CB4FAD49263E20C4, _id_B8DBA75F79D1BAA3, 0, undefined, undefined, _id_B63DD71EA2A6019D, _id_D00F368C9DF807CF);
  _id_3883D0BB982156F3(_id_69E96A4CAA72D794, _id_87583859F07B58E3);
  _id_87583859F07B58E3 setscriptablepartstate("body", "partially_open_usable");

  if(isDefined(_id_69E96A4CAA72D794.opener))
    _id_68085C72D7B628EC(_id_69E96A4CAA72D794, _id_69E96A4CAA72D794.opener);

  _id_7E52B56769FA7774::loothide(_id_69E96A4CAA72D794, "body");
}

_id_3883D0BB982156F3(_id_69E96A4CAA72D794, _id_51BE4043D33594E7) {
  _id_51BE4043D33594E7.contents = _id_69E96A4CAA72D794.contents;
  _id_51BE4043D33594E7._id_46A3A8565AC0C17C = _id_69E96A4CAA72D794._id_46A3A8565AC0C17C;
  _id_51BE4043D33594E7._id_846A20D8E6F30B8E = _id_69E96A4CAA72D794._id_846A20D8E6F30B8E;
  _id_51BE4043D33594E7.owner = _id_69E96A4CAA72D794.owner;
  _id_51BE4043D33594E7._id_04F6CDE716E0C3D7 = _id_69E96A4CAA72D794._id_04F6CDE716E0C3D7;
  _id_51BE4043D33594E7._id_6FB67C8525B1D79E = _id_69E96A4CAA72D794._id_6FB67C8525B1D79E;
  _id_51BE4043D33594E7._id_3EF503345DC57957 = _id_69E96A4CAA72D794._id_3EF503345DC57957;
  _id_51BE4043D33594E7._id_00AD7897ECDBCB63 = _id_69E96A4CAA72D794._id_00AD7897ECDBCB63;
  _id_51BE4043D33594E7._id_275F4441AB7920C8 = _id_69E96A4CAA72D794._id_275F4441AB7920C8;
  _id_51BE4043D33594E7._id_4E479E14D0837E84 = _id_69E96A4CAA72D794._id_FD8A9B46F4A1E27C;
  _id_51BE4043D33594E7._id_86B32AFF94B5714E = _id_69E96A4CAA72D794._id_86B32AFF94B5714E;
  _id_51BE4043D33594E7._id_342175A1B9F9067E = _id_69E96A4CAA72D794._id_342175A1B9F9067E;
  _id_51BE4043D33594E7._id_BF23A60678978C19 = _id_69E96A4CAA72D794._id_BF23A60678978C19;
  _id_51BE4043D33594E7._id_A06E7128C001851D = _id_69E96A4CAA72D794._id_A06E7128C001851D;
  _id_51BE4043D33594E7._id_A0E9FEF038504BD0 = _id_69E96A4CAA72D794._id_A0E9FEF038504BD0;
  _id_51BE4043D33594E7._id_27990AA12DECFFDD = _id_69E96A4CAA72D794._id_27990AA12DECFFDD;
  _id_51BE4043D33594E7._id_C693663E1BBDD8E9 = _id_69E96A4CAA72D794._id_C693663E1BBDD8E9;
  _id_51BE4043D33594E7._id_49CD0247F1C08A6E = _id_69E96A4CAA72D794._id_49CD0247F1C08A6E;
  _id_51BE4043D33594E7._id_BB6791B7369EF71A = _id_69E96A4CAA72D794._id_BB6791B7369EF71A;
  _id_51BE4043D33594E7._id_C31356A794D8CB46 = _id_69E96A4CAA72D794._id_C31356A794D8CB46;

  if(isDefined(_id_69E96A4CAA72D794.owner) && isDefined(_id_69E96A4CAA72D794.owner._id_6A4360DCF2A8F3D4))
    _id_69E96A4CAA72D794.owner._id_6A4360DCF2A8F3D4 = _id_51BE4043D33594E7;

  if(scripts\mp\utility\game::getsubgametype() == "dmz")
    _id_51BE4043D33594E7._id_BBC200BC77C5DB2B = 1;

  foreach(item in _id_51BE4043D33594E7.contents)
  scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2(item["lootID"], "addedToContainer", _id_51BE4043D33594E7);
}

_id_BF4465D9535802BA(_id_69E96A4CAA72D794, player, items) {
  _id_CF0B3E7D1E5A3274(player, _id_69E96A4CAA72D794, _id_69E96A4CAA72D794._id_46A3A8565AC0C17C);

  if(!isDefined(_id_69E96A4CAA72D794._id_E0AEA15595ECF1A9))
    _id_69E96A4CAA72D794._id_E0AEA15595ECF1A9 = [];

  _id_69E96A4CAA72D794._id_E0AEA15595ECF1A9[player.guid] = items;
}

_id_40B46E7298657A93(_id_69E96A4CAA72D794, players, items) {
  foreach(player in players)
  _id_BF4465D9535802BA(_id_69E96A4CAA72D794, player, items);
}

_id_CF0B3E7D1E5A3274(player, _id_69E96A4CAA72D794, _id_46A3A8565AC0C17C, weaponslot) {
  if(!isDefined(_id_69E96A4CAA72D794._id_556DB0B72A96514E))
    _id_69E96A4CAA72D794._id_556DB0B72A96514E = [];

  if(!isDefined(_id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid])) {
    _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid] = spawnStruct();
    _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid].contents = [];
  }

  _id_69E96A4CAA72D794._id_46A3A8565AC0C17C = 1;
  _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid]._id_46A3A8565AC0C17C = 1;

  if(isDefined(_id_46A3A8565AC0C17C)) {
    _id_69E96A4CAA72D794._id_46A3A8565AC0C17C = _id_46A3A8565AC0C17C;
    _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid]._id_46A3A8565AC0C17C = _id_46A3A8565AC0C17C;
  }

  _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid].type = _id_69E96A4CAA72D794.type;
  _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid].origin = _id_69E96A4CAA72D794.origin;
  _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid].angles = _id_69E96A4CAA72D794.angles;
}

_id_618F897065A12122(player, _id_69E96A4CAA72D794, items) {
  if(!_id_E3081772BBF7A51C(player, _id_69E96A4CAA72D794))
    _id_CF0B3E7D1E5A3274(player, _id_69E96A4CAA72D794);

  if(!isarray(items))
    items = [items];

  foreach(item in items) {
    index = _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid].contents.size;
    _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid].contents[index] = [];
    _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid].contents[index]["lootID"] = item["lootID"];
    _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid].contents[index]["quantity"] = scripts\engine\utility::_id_53C4C53197386572(item["quantity"], 1);
  }
}

_id_3BE0B970932FA47E(player, _id_69E96A4CAA72D794, lootid, quantity, weaponobj, _id_4E479E14D0837E84, _id_E1147886CCF51970, _id_18C2C5B0A787D075, _id_CF4FD93A53325100) {
  if(!_id_E3081772BBF7A51C(player, _id_69E96A4CAA72D794))
    _id_CF0B3E7D1E5A3274(player, _id_69E96A4CAA72D794);

  _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid]._id_04F6CDE716E0C3D7 = lootid;
  _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid]._id_6FB67C8525B1D79E = weaponobj;
  _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid]._id_4E479E14D0837E84 = _id_4E479E14D0837E84;
  _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid]._id_275F4441AB7920C8 = _id_E1147886CCF51970;
  _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid]._id_3EF503345DC57957 = quantity;
  _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid]._id_00AD7897ECDBCB63 = _id_CF4FD93A53325100;
  _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid]._id_86B32AFF94B5714E = _id_18C2C5B0A787D075;
}

_id_E3081772BBF7A51C(opener, _id_69E96A4CAA72D794) {
  return isDefined(_id_69E96A4CAA72D794) && isDefined(opener) && isDefined(_id_69E96A4CAA72D794._id_556DB0B72A96514E) && isDefined(_id_69E96A4CAA72D794._id_556DB0B72A96514E[opener.guid]);
}

_id_3AAE4431F00C347F(opener, _id_69E96A4CAA72D794) {
  if(!isDefined(_id_69E96A4CAA72D794._id_556DB0B72A96514E) || !isDefined(_id_69E96A4CAA72D794._id_556DB0B72A96514E[opener.guid]))
    return undefined;

  return _id_69E96A4CAA72D794._id_556DB0B72A96514E[opener.guid];
}

_id_3C85CBBFD2D2A3DA(opener, _id_69E96A4CAA72D794) {
  if(!isDefined(_id_69E96A4CAA72D794._id_556DB0B72A96514E) || !isDefined(_id_69E96A4CAA72D794._id_556DB0B72A96514E[opener.guid]))
    return undefined;

  return _id_69E96A4CAA72D794._id_556DB0B72A96514E[opener.guid].contents;
}

_id_C24E299B175682E4(player, _id_69E96A4CAA72D794) {
  _id_69E96A4CAA72D794 disablescriptableplayeruse(player);
}

_id_9AD640BA63792064(opener, _id_69E96A4CAA72D794) {
  totalplayers = _id_69E96A4CAA72D794._id_556DB0B72A96514E.size;
  _id_EE9DE3C34A771918 = 0;

  foreach(guid, _id_556DB0B72A96514E in _id_69E96A4CAA72D794._id_556DB0B72A96514E) {
    player = scripts\mp\utility\player::getplayerforguid(guid);

    if(_id_23A3BB1172216C05(_id_556DB0B72A96514E, player)) {
      _id_EE9DE3C34A771918++;
      _id_C24E299B175682E4(player, _id_69E96A4CAA72D794);
    }
  }

  partname = _id_69E96A4CAA72D794 _meth_EC5F4851431F3382();

  if(_id_EE9DE3C34A771918 >= totalplayers && _id_69E96A4CAA72D794 getscriptableparthasstate(partname, "fully_opening_unusable"))
    _id_69E96A4CAA72D794 setscriptablepartstate(partname, "fully_opening_unusable");
}