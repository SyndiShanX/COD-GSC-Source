/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_48614492ef09b23.gsc
***********************************************/

_id_CF1B1F86951A9209(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  _id_9CD7DF4997AEA4BF(player, instance);
  instance._id_2BC73315BD31809C[player.guid] = player;

  if(isDefined(instance._id_055AA0066A9F3E9F))
    [[instance._id_055AA0066A9F3E9F]](instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61);

  scripts\mp\loot::_id_30F5EA60517F9E06(player, instance);
}

_id_6207D6F728CEE51D(players, _id_69E96A4CAA72D794, lootid, quantity, weaponobj, _id_338E098F5CBFDA5B, _id_F8048727716242B0) {
  foreach(player in players)
  _id_4DF3C8D739C4B460(player, _id_69E96A4CAA72D794, lootid, quantity, weaponobj, _id_338E098F5CBFDA5B, _id_F8048727716242B0);
}

_id_9CD7DF4997AEA4BF(player, _id_69E96A4CAA72D794) {
  if(!scripts\mp\loot::_id_E3081772BBF7A51C(player, _id_69E96A4CAA72D794)) {
    _id_46A3A8565AC0C17C = _id_B2FF0AF91E5DF8F4(_id_69E96A4CAA72D794.type);
    scripts\mp\loot::_id_CF0B3E7D1E5A3274(player, _id_69E96A4CAA72D794, _id_46A3A8565AC0C17C);
    _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid].contents[0] = [];
    _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid].contents[0]["quantity"] = 0;
    _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid].contents[0]["lootID"] = 0;

    if(!istrue(_id_69E96A4CAA72D794._id_FEBE9AACDD2E47B2)) {
      _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid]._id_04F6CDE716E0C3D7 = 0;
      _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid]._id_6FB67C8525B1D79E = undefined;
    }
  }
}

_id_4DF3C8D739C4B460(player, _id_69E96A4CAA72D794, lootid, quantity, weaponobj, _id_338E098F5CBFDA5B, _id_F8048727716242B0, _id_30F9866CD8907775) {
  _id_9CD7DF4997AEA4BF(player, _id_69E96A4CAA72D794);
  [items, _id_77DC0A100921C5A7] = scripts\mp\loot::_id_0438749EB7A7B738(_id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid].contents, player, _id_69E96A4CAA72D794);
  _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid].contents = items;
  _id_B77D74FC05206ACD = _id_54D1E54B22F3F1F6(_id_69E96A4CAA72D794);

  for(_id_AC0E594AC96AA3A8 = _id_77DC0A100921C5A7 + 1; _id_AC0E594AC96AA3A8 < _id_B77D74FC05206ACD; _id_AC0E594AC96AA3A8++)
    _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid].contents[_id_AC0E594AC96AA3A8] = undefined;

  if(lootid == 0 || quantity == 0) {
    return;
  }
  if(isDefined(weaponobj) && !istrue(_id_69E96A4CAA72D794._id_FEBE9AACDD2E47B2)) {
    if(_id_3689EE4697DD6347(player, _id_69E96A4CAA72D794))
      scripts\mp\loot::_id_A0952BC59C9AFA3F(player, _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid], weaponobj, lootid, quantity, undefined, _id_338E098F5CBFDA5B);
    else
      scripts\mp\loot::_id_67BE8D119FA22135(_id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid], lootid, weaponobj, undefined, _id_338E098F5CBFDA5B, quantity, undefined);
  } else {
    _id_D54A79024C228770 = _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid].contents.size;
    _id_7745D84DFCF3F0FB = undefined;

    foreach(index, item in _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid].contents) {
      if(!isDefined(item) || !isDefined(item["quantity"]) || !isDefined(item["lootID"])) {
        continue;
      }
      if(item["lootID"] == 8395 && lootid == item["lootID"]) {
        _id_D54A79024C228770 = index;
        quantity = quantity + item["quantity"];
        _id_7745D84DFCF3F0FB = 1;
        break;
      }

      scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);
      maxcount = level.br_pickups._id_04138F9DDC1CD22D[scriptablename];

      if(!isDefined(maxcount) || maxcount == 0)
        maxcount = level.br_pickups.maxcounts[scriptablename];

      if(!isDefined(maxcount) || maxcount == 0) {
        continue;
      }
      if(item["lootID"] == lootid && quantity + item["quantity"] <= maxcount) {
        _id_D54A79024C228770 = index;
        quantity = quantity + item["quantity"];
        _id_7745D84DFCF3F0FB = 1;
        break;
      }
    }

    if(_id_D54A79024C228770 >= _id_B77D74FC05206ACD && !isDefined(weaponobj) && !istrue(_id_7745D84DFCF3F0FB)) {
      if(istrue(_id_F8048727716242B0)) {
        _id_D54A79024C228770 = 0;
        _id_879D3E9D5C72B703 = _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid].contents[_id_D54A79024C228770]["lootID"];
        _id_EA1DCC638E88B8C9 = _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid].contents[_id_D54A79024C228770]["quantity"];
        scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(_id_879D3E9D5C72B703);
        dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
        _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, _id_69E96A4CAA72D794.origin, _id_69E96A4CAA72D794.angles);
        _id_7E52B56769FA7774::spawnpickup(scriptablename, _id_CB4FAD49263E20C4, _id_EA1DCC638E88B8C9);
      } else {
        player scripts\mp\hud_message::showerrormessage("MP/BALLOON_EXTRACT_DENY_NO_ROOM");
        return;
      }
    }

    if(isDefined(_id_69E96A4CAA72D794._id_6978A4B328FD33B3)) {
      [lootid, _id_83D63B00FA6616E7] = [[_id_69E96A4CAA72D794._id_6978A4B328FD33B3]](_id_69E96A4CAA72D794, player, lootid, quantity, undefined, undefined, _id_D54A79024C228770);

      if(istrue(_id_83D63B00FA6616E7))
        _id_338E098F5CBFDA5B = _id_83D63B00FA6616E7;
    }

    _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid].contents[_id_D54A79024C228770]["quantity"] = quantity;
    _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid].contents[_id_D54A79024C228770]["lootID"] = lootid;

    if(istrue(_id_338E098F5CBFDA5B)) {
      _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid].contents[_id_D54A79024C228770]["noExtract"] = 1;
      return;
    }

    _id_69E96A4CAA72D794._id_556DB0B72A96514E[player.guid].contents[_id_D54A79024C228770]["noExtract"] = undefined;
  }
}

_id_80BADA2833945A7A(itemtype, _id_3793828403C6873E, _id_338E098F5CBFDA5B, _id_53AAAE2C915F815B) {
  [items, _id_77DC0A100921C5A7] = scripts\mp\loot::_id_0438749EB7A7B738(self._id_02FA5B49969DEF47._id_556DB0B72A96514E[self.guid].contents, self, self._id_02FA5B49969DEF47);
  self._id_02FA5B49969DEF47._id_556DB0B72A96514E[self.guid].contents = items;
  _id_B77D74FC05206ACD = _id_54D1E54B22F3F1F6(self._id_02FA5B49969DEF47);

  for(_id_AC0E594AC96AA3A8 = _id_77DC0A100921C5A7 + 1; _id_AC0E594AC96AA3A8 < _id_B77D74FC05206ACD; _id_AC0E594AC96AA3A8++)
    self._id_02FA5B49969DEF47._id_556DB0B72A96514E[self.guid].contents[_id_AC0E594AC96AA3A8] = undefined;

  _id_69E96A4CAA72D794 = self._id_02FA5B49969DEF47._id_556DB0B72A96514E[self.guid];
  _id_98F7CE981BB1F93C = scripts\mp\loot::_id_D6A3266145BAB76D("loot_container_weapon");

  if(istrue(_id_98F7CE981BB1F93C) && itemtype == 1) {
    scripts\mp\hud_message::showerrormessage("MP/BALLOON_EXTRACT_DENY_NO_ROOM");
    return;
  }

  [lootid, quantity, weaponobj] = _id_04B1EA8143EFB9DD(itemtype, _id_3793828403C6873E, _id_53AAAE2C915F815B);

  if(!isDefined(lootid) || _id_0B7A9CE0A2282B79::_id_A3BBD9874F6A5599(lootid)) {
    return;
  }
  if(lootid == 0 || quantity == 0 && !isDefined(weaponobj)) {
    return;
  }
  if(itemtype == 1 && isDefined(weaponobj)) {
    if(scripts\mp\utility\weapon::_id_1E9278BA699927F7(weaponobj)) {
      return;
    }
    _id_4E479E14D0837E84 = undefined;

    if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7())
      _id_4E479E14D0837E84 = _id_0B7A9CE0A2282B79::_id_74031E3249A6F69E(self, _id_3793828403C6873E);

    _id_D00F368C9DF807CF = undefined;

    if(weaponobj.hasalternate) {
      _id_BE014A8D5A4F68F4 = weaponobj getaltweapon();

      if(isDefined(_id_BE014A8D5A4F68F4))
        _id_D00F368C9DF807CF = self getweaponammoclip(_id_BE014A8D5A4F68F4);
    }

    _id_9BFC8A67E4E991BC = undefined;

    if(scripts\mp\utility\weapon::isakimbo(weaponobj))
      _id_9BFC8A67E4E991BC = self getweaponammoclip(weaponobj, "left");

    scripts\mp\loot::_id_A0952BC59C9AFA3F(self, self._id_02FA5B49969DEF47._id_556DB0B72A96514E[self.guid], weaponobj, lootid, itemtype, _id_3793828403C6873E, quantity, _id_4E479E14D0837E84, _id_338E098F5CBFDA5B, _id_D00F368C9DF807CF, _id_9BFC8A67E4E991BC);
    return;
  }

  _id_D54A79024C228770 = _id_69E96A4CAA72D794.contents.size;
  _id_7745D84DFCF3F0FB = undefined;
  _id_94C9B55B80B148AC = quantity;

  foreach(index, item in _id_69E96A4CAA72D794.contents) {
    if(!isDefined(item) || !isDefined(item["quantity"]) || !isDefined(item["lootID"])) {
      continue;
    }
    _id_7F32FEF084A25F04 = quantity + item["quantity"];

    if(item["lootID"] == 8395 && lootid == item["lootID"] && _id_7F32FEF084A25F04 < 4095) {
      _id_D54A79024C228770 = index;
      quantity = _id_7F32FEF084A25F04;
      _id_7745D84DFCF3F0FB = 1;
      break;
    }

    scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);
    maxcount = level.br_pickups._id_04138F9DDC1CD22D[scriptablename];

    if(!isDefined(maxcount) || maxcount == 0)
      maxcount = level.br_pickups.maxcounts[scriptablename];

    if(!isDefined(maxcount) || maxcount == 0) {
      continue;
    }
    if(item["lootID"] == lootid && _id_7F32FEF084A25F04 <= maxcount && _id_7F32FEF084A25F04 < 4095) {
      _id_D54A79024C228770 = index;
      quantity = _id_7F32FEF084A25F04;
      _id_7745D84DFCF3F0FB = 1;
      break;
    }
  }

  if(_id_D54A79024C228770 >= _id_B77D74FC05206ACD && itemtype != 1 && !istrue(_id_7745D84DFCF3F0FB)) {
    scripts\mp\hud_message::showerrormessage("MP/BALLOON_EXTRACT_DENY_NO_ROOM");
    return;
  }

  if(isDefined(self._id_02FA5B49969DEF47._id_6978A4B328FD33B3)) {
    [lootid, _id_83D63B00FA6616E7] = [[self._id_02FA5B49969DEF47._id_6978A4B328FD33B3]](self._id_02FA5B49969DEF47, self, lootid, quantity, itemtype, _id_3793828403C6873E, _id_D54A79024C228770);

    if(istrue(_id_83D63B00FA6616E7))
      _id_338E098F5CBFDA5B = _id_83D63B00FA6616E7;
  }

  if(_id_7E52B56769FA7774::_id_34AF0F77C1668DBA(lootid))
    thread _id_7E52B56769FA7774::_id_8AAB3CDA02F81C09(self, itemtype, undefined, 1, _id_94C9B55B80B148AC);
  else if(istrue(_id_53AAAE2C915F815B) && !_id_7E52B56769FA7774::_id_F96674BA1A1EC2B3(lootid))
    thread _id_7E52B56769FA7774::quickdropall(itemtype, _id_3793828403C6873E, 1);
  else
    thread _id_7E52B56769FA7774::quickdropitem(itemtype, _id_3793828403C6873E, 1);

  self._id_02FA5B49969DEF47._id_556DB0B72A96514E[self.guid].contents[_id_D54A79024C228770]["quantity"] = quantity;
  self._id_02FA5B49969DEF47._id_556DB0B72A96514E[self.guid].contents[_id_D54A79024C228770]["lootID"] = lootid;

  if(istrue(_id_338E098F5CBFDA5B))
    self._id_02FA5B49969DEF47._id_556DB0B72A96514E[self.guid].contents[_id_D54A79024C228770]["noExtract"] = 1;
  else
    self._id_02FA5B49969DEF47._id_556DB0B72A96514E[self.guid].contents[_id_D54A79024C228770]["noExtract"] = undefined;

  _id_CE9B69FC041571D2(self, self._id_02FA5B49969DEF47);
  scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

  if(_id_7E52B56769FA7774::_id_282D89F7705A2D63(scriptablename))
    _id_7E52B56769FA7774::_id_BFC82C27ED3D9308(undefined, undefined, scriptablename, _id_3793828403C6873E);
}

_id_CE9B69FC041571D2(opener, _id_69E96A4CAA72D794) {
  [items, _id_77DC0A100921C5A7] = scripts\mp\loot::_id_0438749EB7A7B738(_id_69E96A4CAA72D794._id_556DB0B72A96514E[opener.guid].contents, opener, _id_69E96A4CAA72D794);
  _id_69E96A4CAA72D794._id_556DB0B72A96514E[opener.guid].contents = items;
  _id_B77D74FC05206ACD = _id_54D1E54B22F3F1F6(_id_69E96A4CAA72D794);

  if(items.size > _id_B77D74FC05206ACD) {}

  for(_id_3793828403C6873E = 0; _id_3793828403C6873E < _id_B77D74FC05206ACD; _id_3793828403C6873E++)
    scripts\mp\loot::_id_C7294F5B9B5006D5(opener, _id_3793828403C6873E);

  for(_id_3793828403C6873E = 0; _id_3793828403C6873E < _id_B77D74FC05206ACD; _id_3793828403C6873E++) {
    if(_id_3793828403C6873E <= _id_77DC0A100921C5A7)
      scripts\mp\loot::_id_446C7AD7BCC70992(opener, _id_69E96A4CAA72D794._id_556DB0B72A96514E[opener.guid], _id_3793828403C6873E, items[_id_3793828403C6873E]["lootID"], items[_id_3793828403C6873E]["quantity"], items[_id_3793828403C6873E]["ref"]);
  }
}

_id_B2FF0AF91E5DF8F4(scriptablename) {
  _id_46A3A8565AC0C17C = 1;

  switch (scriptablename) {
    case "dmz_dead_drop_transaction_drawer":
    case "dmz_dead_drop":
      _id_46A3A8565AC0C17C = 15;
      break;
    case "equip_balloon_extract_mp":
      _id_46A3A8565AC0C17C = 13;
      break;
    default:
      break;
  }

  return _id_46A3A8565AC0C17C;
}

_id_54D1E54B22F3F1F6(_id_69E96A4CAA72D794) {
  _id_46A3A8565AC0C17C = _id_69E96A4CAA72D794._id_46A3A8565AC0C17C;
  _id_697150CB1FFEFABB = scripts\engine\utility::ter_op(!istrue(_id_69E96A4CAA72D794._id_FEBE9AACDD2E47B2), 1, 0);

  switch (_id_46A3A8565AC0C17C) {
    case 15:
      return getdvarint("dvar_823C57EC4DAC4069", 4) - _id_697150CB1FFEFABB;
    case 13:
      return getdvarint("dvar_780B498909AD7B76", 4) - _id_697150CB1FFEFABB;
    default:
      return 10;
  }
}

_id_04B1EA8143EFB9DD(itemtype, _id_3793828403C6873E, _id_53AAAE2C915F815B) {
  switch (itemtype) {
    case 10:
      lootid = _id_2D9D24F7C63AC143::_id_6196D9EA9A30E609(_id_3793828403C6873E);

      if(!isDefined(lootid))
        return [0, 0];

      scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);
      quantity = 1;

      if(_id_2391409EF7B431E1::_id_03C17A26CE6A4668(lootid))
        [quantity, _id_59BD51AFC73DF2CD, _id_DAB81EAD77442A10] = _id_2391409EF7B431E1::_id_379463A84ADB07B4(quantity);
      else if(istrue(_id_53AAAE2C915F815B) || _id_7E52B56769FA7774::_id_D345EEC68E01361F(lootid))
        quantity = _id_2D9D24F7C63AC143::_id_897B29ADB37F06A7(_id_3793828403C6873E);
      else if(isDefined(scriptablename) && _id_2CEDCC356F1B9FC8::isammo(scriptablename))
        quantity = int(min(_id_2D9D24F7C63AC143::_id_897B29ADB37F06A7(_id_3793828403C6873E), level.br_pickups.counts[scriptablename]));
      else
        quantity = 1;

      return [lootid, quantity];
    case 7:
    case 6:
    case 4:
    case 3:
    case 2:
    case 1:
    case 0:
      return _id_2D9D24F7C63AC143::_id_CF1BEF64E94F2D1A(itemtype, _id_3793828403C6873E, 1, 1, !istrue(_id_53AAAE2C915F815B));
    default:
      return;
  }
}

_id_5711A00587F71794(player) {
  if(!scripts\mp\loot::_id_6F45E7311F77EAC4(player))
    return 0;

  if(!isDefined(player._id_02FA5B49969DEF47))
    return 0;

  if(!isDefined(player._id_02FA5B49969DEF47._id_46A3A8565AC0C17C))
    return 0;

  _id_46A3A8565AC0C17C = player._id_02FA5B49969DEF47._id_46A3A8565AC0C17C;

  switch (_id_46A3A8565AC0C17C) {
    case 15:
    case 13:
      return 1;
    default:
      return 0;
  }
}

_id_3689EE4697DD6347(player, _id_69E96A4CAA72D794) {
  if(!_id_5711A00587F71794(player))
    return 0;

  if(player._id_02FA5B49969DEF47._id_46A3A8565AC0C17C != _id_69E96A4CAA72D794._id_46A3A8565AC0C17C)
    return 0;

  if(!isDefined(_id_69E96A4CAA72D794._id_2BC73315BD31809C) || !isDefined(_id_69E96A4CAA72D794._id_2BC73315BD31809C[player.guid]))
    return 0;

  return 1;
}

_id_1225F23A18664F4C(player) {
  if(!scripts\mp\loot::_id_6F45E7311F77EAC4(player))
    return 0;

  if(!isDefined(player._id_02FA5B49969DEF47))
    return 0;

  if(!isDefined(player._id_02FA5B49969DEF47._id_46A3A8565AC0C17C))
    return 0;

  _id_46A3A8565AC0C17C = player._id_02FA5B49969DEF47._id_46A3A8565AC0C17C;

  switch (_id_46A3A8565AC0C17C) {
    case 15:
      return getdvarint("dvar_6EE9465E13D271E5", 0);
    case 13:
      return getdvarint("dvar_1D7F857B2CD9DBA2", 0);
    default:
      return 0;
  }
}

_id_564C579AE581A82D(contents) {
  _id_1C1DD30A3C77139C = [];

  foreach(key, item in contents) {
    _id_1C1DD30A3C77139C[key] = spawnStruct();
    _id_1C1DD30A3C77139C[key].lootid = item["lootID"];
    _id_1C1DD30A3C77139C[key].quantity = item["quantity"];
    _id_1C1DD30A3C77139C[key].index = item["index"];

    if(isDefined(item["noExtract"]))
      _id_1C1DD30A3C77139C[key]._id_338E098F5CBFDA5B = item["noExtract"];
  }

  return _id_1C1DD30A3C77139C;
}