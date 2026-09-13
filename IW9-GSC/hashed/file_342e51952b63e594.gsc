/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_342e51952b63e594.gsc
***********************************************/

init() {
  level endon("game_ended");
  level._id_C153EAC6E7C0E1A2 = getdvarint("dvar_AE537EA74AD94BF6", 0);

  if(!level._id_C153EAC6E7C0E1A2) {
    return;
  }
  level._id_78794C7CFBB450D5 = getDvar("dvar_D02BF26D7B888C7B", "barter_recipe_list_iw9");
  level._id_CFD448BDAF563AFA = _id_98723716DBE58366(getDvar("dvar_25DBDC95FF3E3DA5", "barter_list_overrides_iw9"));
  scripts\mp\flags::gameflagwait("prematch_done");
  level._id_5B4FDABD6FF8AC60 = _id_EEE09BD49D34D254(level._id_78794C7CFBB450D5);
}

_id_B03A252F9AB9BCFD(player, index) {
  _id_17D459426E3D4968 = _id_4AE28D68DFC25DAD(player);
  return _id_2F1EF432DF69A29B(player, _id_17D459426E3D4968[index]);
}

_id_2B4F0BEA679346EF(player) {
  player notify("clear_barter");
  level endon("game_ended");
  player endon("death_or_disconnect");
  player endon("clear_barter");
  waitframe();
  player setclientomnvar("ui_barter_success", 0);
}

_id_45EEFC63956143ED(_id_15B89FF206500554, _id_78794C7CFBB450D5) {
  if(!isDefined(_id_15B89FF206500554) || !isDefined(_id_78794C7CFBB450D5) || !isDefined(level._id_CFD448BDAF563AFA[_id_78794C7CFBB450D5])) {
    return;
  }
  _id_15B89FF206500554._id_9E3B77C6C3E95470 = level._id_CFD448BDAF563AFA[_id_78794C7CFBB450D5] + 1;
  _id_15B89FF206500554._id_8165379C774FE8E3 = _id_EEE09BD49D34D254(_id_78794C7CFBB450D5);
}

_id_0FA0F2FCFC30F95A(players, _id_15B89FF206500554, _id_78794C7CFBB450D5) {
  foreach(player in players)
  _id_C661AFD69DC6CB4D(player, _id_15B89FF206500554, _id_78794C7CFBB450D5);
}

_id_C661AFD69DC6CB4D(player, _id_15B89FF206500554, _id_78794C7CFBB450D5) {
  if(!isDefined(player) || !isDefined(_id_15B89FF206500554) || !isDefined(_id_78794C7CFBB450D5) || !isDefined(level._id_CFD448BDAF563AFA[_id_78794C7CFBB450D5])) {
    return;
  }
  if(!isDefined(_id_15B89FF206500554._id_A713DCDD8D8D5D12))
    _id_15B89FF206500554._id_A713DCDD8D8D5D12 = [];

  _id_15B89FF206500554._id_A713DCDD8D8D5D12[player.guid] = spawnStruct();
  _id_15B89FF206500554._id_A713DCDD8D8D5D12[player.guid]._id_9EB2829AF566123B = level._id_CFD448BDAF563AFA[_id_78794C7CFBB450D5] + 1;
  _id_15B89FF206500554._id_A713DCDD8D8D5D12[player.guid]._id_5B4FDABD6FF8AC60 = _id_EEE09BD49D34D254(_id_78794C7CFBB450D5);
}

_id_CF93C66F1F68B32B(player, _id_15B89FF206500554) {
  if(!istrue(level._id_C153EAC6E7C0E1A2))
    return 0;

  if(!isDefined(player) || !isDefined(_id_15B89FF206500554))
    return 0;

  return isDefined(_id_15B89FF206500554._id_A713DCDD8D8D5D12) && isDefined(_id_15B89FF206500554._id_A713DCDD8D8D5D12[player.guid]) || isDefined(_id_15B89FF206500554._id_9E3B77C6C3E95470);
}

_id_6B9FB04B51E91720(player, _id_15B89FF206500554) {
  if(!_id_CF93C66F1F68B32B(player, _id_15B89FF206500554))
    return 0;

  if(isDefined(_id_15B89FF206500554._id_A713DCDD8D8D5D12) && isDefined(_id_15B89FF206500554._id_A713DCDD8D8D5D12[player.guid]))
    return _id_15B89FF206500554._id_A713DCDD8D8D5D12[player.guid]._id_9EB2829AF566123B;

  return _id_15B89FF206500554._id_9E3B77C6C3E95470;
}

_id_EEE09BD49D34D254(_id_78794C7CFBB450D5) {
  _id_2E6CDE9123966491 = getscriptbundle(_func_2EF675C13CA1C4AF("enum_6C8907A65A40A6A9", _id_78794C7CFBB450D5));
  _id_5B4FDABD6FF8AC60 = [];

  foreach(_id_A242355F9B40388B in _id_2E6CDE9123966491._id_13736FC9FAA3BCF3) {
    if(isDefined(_id_A242355F9B40388B._id_A242355F9B40388B))
      _id_5B4FDABD6FF8AC60[_id_5B4FDABD6FF8AC60.size] = getscriptbundle("barterrecipes:" + _id_A242355F9B40388B._id_A242355F9B40388B);
  }

  return _id_5B4FDABD6FF8AC60;
}

_id_98723716DBE58366(_id_1493DA49A2631455) {
  _id_B609EF20B3D0FD99 = getscriptbundle(_func_2EF675C13CA1C4AF("enum_283F419BC25A568B", _id_1493DA49A2631455));
  _id_8EE856C796C0FE41 = [];

  foreach(index, list in _id_B609EF20B3D0FD99._id_A43D35F01FE54F92) {
    if(isDefined(list.list))
      _id_8EE856C796C0FE41[list.list] = index;
  }

  return _id_8EE856C796C0FE41;
}

_id_4AE28D68DFC25DAD(player) {
  if(!isDefined(player) || !isDefined(player.br_kiosk))
    return level._id_5B4FDABD6FF8AC60;

  if(isDefined(player.br_kiosk._id_A713DCDD8D8D5D12) && isDefined(player.br_kiosk._id_A713DCDD8D8D5D12[player.guid]))
    return player.br_kiosk._id_A713DCDD8D8D5D12[player.guid]._id_5B4FDABD6FF8AC60;

  if(isDefined(player.br_kiosk._id_8165379C774FE8E3))
    return player.br_kiosk._id_8165379C774FE8E3;

  return level._id_5B4FDABD6FF8AC60;
}

_id_DDE2BA6E3E9A30F8(player) {
  if(!isDefined(player))
    return 0;

  if(!scripts\mp\utility\player::isreallyalive(player))
    return 0;

  return 1;
}

_id_90E06D23E15CCC43(player, _id_3771CA82B40BC649) {
  _id_8919314D1DF8D669 = player _id_2D9D24F7C63AC143::_id_88A168912191EC3E(1, 1, 1);

  if(isDefined(_id_8919314D1DF8D669)) {
    foreach(_id_419647311D7D621F, itemtype in _id_8919314D1DF8D669) {
      if(!itemtype.size) {
        continue;
      }
      foreach(_id_E1D097C517C3AF5B, slot in itemtype) {
        if(!isDefined(slot)) {
          continue;
        }
        lootid = slot[0];
        quantity = slot[1];

        if(!istrue(lootid) || !istrue(quantity)) {
          continue;
        }
        if(lootid != _id_3771CA82B40BC649) {
          continue;
        }
        if(_id_7E52B56769FA7774::_id_D345EEC68E01361F(_id_3771CA82B40BC649) && quantity > 0)
          quantity = 1;

        if(_id_3771CA82B40BC649 == _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("cash") && isDefined(player.plundercount))
          quantity = player.plundercount;

        return [quantity, _id_419647311D7D621F, _id_E1D097C517C3AF5B];
      }
    }
  }

  return [0, 0, 0];
}

_id_E59CC32A4F43C5D8(player, amount, itemtype, _id_3793828403C6873E) {
  switch (itemtype) {
    case 0:
      plundercount = player.plundercount - amount;
      player _id_6AFF3948CF4CCA03::playersetplundercount(plundercount);
      break;
    case 1:
      break;
    case 2:
      slot = scripts\mp\equipment::_id_4967838290CB31B9(_id_3793828403C6873E);
      player scripts\mp\equipment::decrementequipmentslotammo(slot, amount);
      break;
    case 3:
      player scripts\mp\killstreaks\killstreaks::removekillstreak(1);
      break;
    case 4:
      player _id_7E52B56769FA7774::resetsuper();
      player.equipment["super"] = undefined;
      break;
    case 6:
      player _id_7E52B56769FA7774::_id_75520EA44545C906();
      _id_0B7A9CE0A2282B79::_id_777C89585478357B(player);
      break;
    case 7:
      player _id_7E52B56769FA7774::removeselfrevivetoken();
      break;
    default:
      return;
  }
}

_id_84FA317D531E4EF3(player, _id_E781BA2B9E37466A, _id_9594D9142592E492) {
  while(_id_9594D9142592E492.size < 5)
    _id_9594D9142592E492[_id_9594D9142592E492.size] = "";

  _id_81954D580B24281B = 0.0;
  _id_E4F34F3A01C6FFF2 = 0.0;
  _id_689A1188271A0BE5 = 0.0;

  if(isPlayer(player)) {
    _id_81954D580B24281B = player.origin[0];
    _id_E4F34F3A01C6FFF2 = player.origin[1];
    _id_689A1188271A0BE5 = player.origin[2];
  }

  player dlog_recordplayerevent("dlog_event_dmz_player_barter", ["game_time_ms", scripts\cp_mp\utility\game_utility::gettimesincegamestart(), "player_position_x", _id_81954D580B24281B, "player_position_y", _id_E4F34F3A01C6FFF2, "player_position_z", _id_689A1188271A0BE5, "item_gained", _id_E781BA2B9E37466A, "items_spent", _id_9594D9142592E492]);
}

_id_2F1EF432DF69A29B(player, _id_A242355F9B40388B) {
  if(!_id_DDE2BA6E3E9A30F8(player))
    return 0;

  _id_02E72CF01652B5BD = [];
  _id_4039D4D6EDCF4894 = [];

  if(isDefined(_id_A242355F9B40388B._id_41F94BCA374ED58A) && _id_A242355F9B40388B._id_41F94BCA374ED58A > 0) {
    if(!_id_0B7A9CE0A2282B79::_id_59352C09A417A5E2(player, _id_A242355F9B40388B._id_41F94BCA374ED58A))
      return 0;
  }

  foreach(item in _id_A242355F9B40388B._id_46768C0F1BE07B9D) {
    scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(item.lootid);
    _id_8F0A45A0F5B42B90 = item.lootid;

    if(_id_7E52B56769FA7774::_id_82D45592D750D388(scriptablename)) {
      _id_B835958CE1825933 = _id_57D3850A12CF1D8F::_id_0475482BFE3FEB25(scriptablename);
      [scriptablename, _id_2053E168B46CAA6E] = _id_57D3850A12CF1D8F::_id_7D321A63BC56C65C(_id_B835958CE1825933, player, 1);
      _id_8F0A45A0F5B42B90 = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(scriptablename);
    }

    _id_99CA2650C284F5C3 = player _id_2D9D24F7C63AC143::_id_93F02514431A1F5D(_id_8F0A45A0F5B42B90);
    [_id_B834CFED17D314A3, _id_8691AF1F100B771F, loadoutindex] = _id_90E06D23E15CCC43(player, _id_8F0A45A0F5B42B90);
    _id_0F53AE6184F353B7 = undefined;

    if(_id_2391409EF7B431E1::_id_C07675F2CE32FCB5(player) && _id_7E52B56769FA7774::_id_9E3428357E5DF2E3(scriptablename)) {
      _id_E6FFEDC06591FAA4 = _id_2391409EF7B431E1::_id_59771B0CC100410A(player);

      if(_id_E6FFEDC06591FAA4 == scriptablename) {
        _id_B834CFED17D314A3++;
        _id_0F53AE6184F353B7 = 1;
      }
    }

    if(_id_99CA2650C284F5C3 + _id_B834CFED17D314A3 < item.quantity)
      return 0;

    _id_89955E781D50267A = player _id_2D9D24F7C63AC143::_id_AEB6F176059D98F5(_id_8F0A45A0F5B42B90);

    if(_id_89955E781D50267A.size == 0 && _id_B834CFED17D314A3 < item.quantity)
      return 0;

    if(_id_99CA2650C284F5C3 >= item.quantity) {
      _id_B834CFED17D314A3 = undefined;
      loadoutindex = undefined;
      _id_8691AF1F100B771F = undefined;
      _id_0F53AE6184F353B7 = undefined;
    } else
      _id_B834CFED17D314A3 = item.quantity - _id_99CA2650C284F5C3;

    _id_99CA2650C284F5C3 = int(min(_id_99CA2650C284F5C3, item.quantity));

    if(isDefined(_id_B834CFED17D314A3))
      _id_B834CFED17D314A3 = int(min(_id_B834CFED17D314A3, item.quantity));

    _id_02E72CF01652B5BD[_id_02E72CF01652B5BD.size] = [_id_99CA2650C284F5C3, _id_89955E781D50267A, _id_B834CFED17D314A3, loadoutindex, _id_8691AF1F100B771F, _id_0F53AE6184F353B7];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < item.quantity; _id_AC0E594AC96AA3A8++)
      _id_4039D4D6EDCF4894[_id_4039D4D6EDCF4894.size] = scriptablename;
  }

  foreach(item in _id_02E72CF01652B5BD) {
    _id_A4F8448F29141288 = item[0];

    foreach(index in item[1]) {
      [lootid, quantity] = player _id_2D9D24F7C63AC143::_id_6738846DA50730F1(index);

      if(_id_7E52B56769FA7774::_id_D345EEC68E01361F(lootid))
        _id_A4F8448F29141288 = quantity;

      player _id_2D9D24F7C63AC143::_id_DB1DD76061352E5B(index, _id_A4F8448F29141288);
      _id_A4F8448F29141288 = _id_A4F8448F29141288 - quantity;

      if(_id_A4F8448F29141288 <= 0) {
        break;
      }
    }

    if(istrue(item[5])) {
      _id_2391409EF7B431E1::_id_BC03AA369196F2BF(player, 0);
      continue;
    }

    if(!isDefined(item[2]) || !isDefined(item[3]) || !isDefined(item[4])) {
      continue;
    }
    _id_E59CC32A4F43C5D8(player, item[2], item[4], item[3]);
  }

  scriptablename = _id_A242355F9B40388B._id_289245099AF802F6;

  if(!isDefined(scriptablename))
    scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(_id_A242355F9B40388B.lootid);

  result = undefined;

  if(!istrue(_id_A242355F9B40388B.permanent))
    result = player _id_7E52B56769FA7774::_id_D8CD9C1941A88194(_id_A242355F9B40388B.lootid, _id_A242355F9B40388B.quantity, _id_A242355F9B40388B._id_289245099AF802F6);

  if(!istrue(result) && !istrue(_id_A242355F9B40388B.permanent)) {
    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

    if(isDefined(player.br_kiosk)) {
      _id_E1D097C517C3AF5B = player.br_kiosk _id_7E52B56769FA7774::_id_4F4D537C794B2BF5();
      player.br_kiosk.dropstruct._id_DFBA5A2C3C6F0A07 = _id_E1D097C517C3AF5B;
      dropstruct = player.br_kiosk.dropstruct;
    }

    baseorigin = player.origin;
    baseangles = player.angles;

    if(isDefined(player.br_kiosk)) {
      baseorigin = scripts\engine\utility::_id_53C4C53197386572(player.br_kiosk._id_AFC028D00356E443, player.br_kiosk.origin);
      baseangles = player.br_kiosk.angles;
    }

    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, baseorigin, baseangles, player);
    pickup = player _id_7E52B56769FA7774::spawnpickup(scriptablename, _id_CB4FAD49263E20C4, _id_A242355F9B40388B.quantity, 1, undefined, 0);
  }

  player scripts\cp_mp\challenges::_id_7BA17FB69C312E2C(undefined, scriptablename, _id_A242355F9B40388B.lootid, _id_A242355F9B40388B.quantity, 0);
  _id_84FA317D531E4EF3(player, scriptablename, _id_4039D4D6EDCF4894);
  return 1;
}