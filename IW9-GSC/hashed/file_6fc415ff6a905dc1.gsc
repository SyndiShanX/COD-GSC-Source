/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6fc415ff6a905dc1.gsc
***********************************************/

_id_F09E47B124561928() {
  if(isai(self)) {
    return;
  }
  if(!_id_2D9D24F7C63AC143::_id_E37CA8120DC19C6A()) {
    return;
  }
  _id_7F04A682872040DB(self);

  if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7()) {
    _id_0B7A9CE0A2282B79::_id_33366ADE5697AA38(self);
    _id_001F290B334E7EA5 = _id_0B7A9CE0A2282B79::_id_AAD5C8B478DF88C4(self);

    if(_id_001F290B334E7EA5 > 0)
      _id_2D9D24F7C63AC143::_id_C2F16E2BBB4E38C0("brloot_armor_plate", _id_001F290B334E7EA5);
  } else {
    _id_F95E462AD75806A2();
    _id_2D55E66E05614871();
  }

  if(!_id_B0D22762C7EE8FE4())
    _id_568D5B6B51690C6A();

  _id_2D9D24F7C63AC143::_id_5BAAA0CE73D6FE84(self);

  if(!isDefined(level._id_EB4AD3D9B8C36077)) {
    _id_615B735DDA2A4C94 = "mp/dmz_starting_inventory_ae_whitelist.csv";
    level._id_EB4AD3D9B8C36077 = [];
    _id_977F24E61599CBBA = tablelookupgetnumrows(_id_615B735DDA2A4C94);

    for(_id_CB89110314447B2F = 0; _id_CB89110314447B2F < _id_977F24E61599CBBA; _id_CB89110314447B2F++)
      level._id_EB4AD3D9B8C36077[level._id_EB4AD3D9B8C36077.size] = int(tablelookupbyrow(_id_615B735DDA2A4C94, _id_CB89110314447B2F, 1));
  }

  _id_3EAA9F644DBE7834 = scripts\cp_mp\challenges::_id_6D40F12A09494350(0, 9);

  foreach(item in _id_9CD290910C24D4D3()) {
    _id_F6C9F9BBBC46C8E7 = item.lootid;

    if(isDefined(item.objweapon)) {
      _id_49D6C5A42EBCF947 = scripts\mp\weapons::_id_7A91162092CC11EC(item.lootid);

      if(isDefined(_id_49D6C5A42EBCF947))
        _id_F6C9F9BBBC46C8E7 = _id_49D6C5A42EBCF947;
    }

    if(scripts\engine\utility::array_contains(level._id_EB4AD3D9B8C36077, _id_F6C9F9BBBC46C8E7))
      scripts\cp_mp\challenges::_id_D24138B32084FC3E(self, _id_F6C9F9BBBC46C8E7, undefined, _id_3EAA9F644DBE7834, item.quantity);
  }

  foreach(item in _id_2D9D24F7C63AC143::_id_254150D1E667DEE7()) {
    if(scripts\engine\utility::array_contains(level._id_EB4AD3D9B8C36077, item.lootid))
      scripts\cp_mp\challenges::_id_D24138B32084FC3E(self, item.lootid, undefined, _id_3EAA9F644DBE7834, item.quantity);
  }
}

_id_5332E1C0F06B0245(_id_3064FA24DBBD5BBF) {
  if(isai(self)) {
    return;
  }
  if(!_id_2D9D24F7C63AC143::_id_E37CA8120DC19C6A()) {
    return;
  }
  self setplayerdata(level._id_5D69837CF4DB0407, "lootedCash", self.plundercount);
  _id_1D4DB10D5290694A = _id_2D9D24F7C63AC143::_id_254150D1E667DEE7();

  foreach(item in _id_1D4DB10D5290694A)
  _id_A82DECEE54864929(item.lootid);

  _id_06BE2E3DE0644E52 = [];
  _id_31949CE029B087D1 = [];

  if(isDefined(self._id_9405380A2F34C55D)) {
    foreach(_id_784DD6733F8F56A5 in self._id_9405380A2F34C55D) {
      [_id_C9CCB7804978DC9F, _id_DD612E75937756FA] = _id_2391409EF7B431E1::_id_E92E13020D5EE099(_id_784DD6733F8F56A5);

      if(isDefined(_id_DD612E75937756FA) && isDefined(level._id_B287C5D31BEE8267[_id_DD612E75937756FA]) && isDefined(level._id_B287C5D31BEE8267[_id_DD612E75937756FA].name)) {
        _id_06BE2E3DE0644E52[_id_06BE2E3DE0644E52.size] = level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F].name;
        _id_31949CE029B087D1[_id_06BE2E3DE0644E52.size] = level._id_B287C5D31BEE8267[_id_DD612E75937756FA].name;
      }
    }
  }

  self dlog_recordplayerevent("dlog_event_dmz_exfil_dogtags", ["tags_victim", _id_06BE2E3DE0644E52, "tags_killer", _id_31949CE029B087D1]);
  self._id_9405380A2F34C55D = undefined;
  _id_414B281CD48C16D3 = _id_9CD290910C24D4D3();

  foreach(item in _id_414B281CD48C16D3)
  _id_A82DECEE54864929(item.lootid);

  _id_414B281CD48C16D3 = _id_9CD290910C24D4D3();
  _id_EBD34E72023FC5A9 = _id_2D9D24F7C63AC143::_id_254150D1E667DEE7();
  clipammo = _id_C1106D5209A8B595();

  if(!_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7()) {
    foreach(item in _id_414B281CD48C16D3)
    _id_C324D060CDE743E3(item.lootid, item.quantity);

    if(!_id_B0D22762C7EE8FE4())
      _id_CFC379803B1DD46F();

    foreach(item in _id_EBD34E72023FC5A9) {
      _id_C324D060CDE743E3(item.lootid, item.quantity);
      _id_2D9D24F7C63AC143::_id_6F39F9916649AC48(item.lootid, item.quantity);
    }

    foreach(lootid in _id_3AACF02225CA0DA5::_id_8F6753648E94E7EC(self))
    _id_C324D060CDE743E3(lootid);
  }

  _id_3AACF02225CA0DA5::_id_5704AB2A9381630F(self);
  _id_0B7A9CE0A2282B79::_id_ED325A060ADCBE65(self);
  _id_68C58FC50DB46DC6 = self getplayerdata(level._id_5D69837CF4DB0407, "dmzBankedCash");
  self setplayerdata(level._id_5D69837CF4DB0407, "dmzBankedCash", _id_68C58FC50DB46DC6 + self.plundercount);
  _id_6A8EC730B2BFA844::_id_3172B1344F4E08A0(self, _id_414B281CD48C16D3, _id_1D4DB10D5290694A, clipammo, self.plundercount, _id_3064FA24DBBD5BBF);
}

_id_F95E462AD75806A2() {
  _id_414B281CD48C16D3 = _id_9CD290910C24D4D3();
  _id_0113572A27A3AC22 = _id_774FEF5F034555BA();

  foreach(item in _id_414B281CD48C16D3) {
    index = undefined;

    if(_id_0113572A27A3AC22)
      index = _id_752A16F10A698186(item.lootid, ::_id_25BE694D7A22DB61);
    else
      index = _id_752A16F10A698186(item.lootid);

    if(isDefined(index)) {
      _id_FF239359935AA777 = self getplayerdata(level._id_5D69837CF4DB0407, "dmzInventory", index, "quantity");
      ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(item.lootid);

      if(_id_FF239359935AA777 == 1) {
        if(_id_0113572A27A3AC22) {
          itemtype = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(item.lootid);

          if(itemtype == "weapon")
            scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(item.lootid);
        }

        _id_0E249CFFD8B8F7A9(index, 0, 0);
      } else
        _id_0E249CFFD8B8F7A9(index, item.lootid, _id_FF239359935AA777 - 1);
    }
  }
}

_id_D347B1E01AE5D066() {
  cooldown = _id_0B7A9CE0A2282B79::_id_0319DC9ED3B41647();
  return getsystemtime() + cooldown;
}

_id_E2F4F470C55123B8(_id_A9241440B3109A63, _id_C481D6C6144F4C31) {
  _id_BBAC576AADE31A1E = 0;

  if(isDefined(_id_A9241440B3109A63))
    _id_EBD34E72023FC5A9 = _id_A9241440B3109A63;
  else
    _id_EBD34E72023FC5A9 = _id_2D9D24F7C63AC143::_id_254150D1E667DEE7();

  self._id_9405380A2F34C55D = [];

  foreach(item in _id_EBD34E72023FC5A9) {
    ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(item.lootid);
    _id_25978461C6E4F61B = level.br_pickups._id_838863C4848D4C26[ref];
    itemtype = undefined;

    if(isDefined(_id_25978461C6E4F61B))
      itemtype = level.br_pickups.br_itemtype[_id_25978461C6E4F61B];

    if(isDefined(itemtype) && itemtype == "plunder") {
      _id_BBAC576AADE31A1E = _id_BBAC576AADE31A1E + item.quantity;
      continue;
    }

    if(isDefined(_id_25978461C6E4F61B) && isDefined(itemtype)) {
      _id_B87F7FAE01CE754F = level.br_pickups._id_D93566A78E29D583[_id_25978461C6E4F61B];

      if(itemtype == "dogtag") {
        self._id_9405380A2F34C55D[self._id_9405380A2F34C55D.size] = item.quantity;
        value = level.br_pickups._id_D93566A78E29D583[_id_25978461C6E4F61B];
        _id_BBAC576AADE31A1E = _id_BBAC576AADE31A1E + value;

        if(!istrue(_id_C481D6C6144F4C31))
          _id_2D9D24F7C63AC143::_id_DB1DD76061352E5B(item.index, item.quantity);
      } else if(!_id_7E52B56769FA7774::_id_A38E261031751C09(_id_25978461C6E4F61B)) {
        if(isDefined(_id_B87F7FAE01CE754F) && isDefined(itemtype)) {
          switch (itemtype) {
            case "personal":
            case "valuable":
            case "note":
              _id_BBAC576AADE31A1E = _id_BBAC576AADE31A1E + _id_B87F7FAE01CE754F * item.quantity;
              break;
          }
        }

        _id_4183295EDCC21DB0 = _id_2D9D24F7C63AC143::_id_C578CFF4DE96AF82(_id_25978461C6E4F61B);

        if(itemtype == "valuable" && !istrue(_id_4183295EDCC21DB0) && !istrue(_id_C481D6C6144F4C31))
          _id_2D9D24F7C63AC143::_id_6F39F9916649AC48(item.lootid, item.quantity);
      }
    }
  }

  _id_BBAC576AADE31A1E = _id_BBAC576AADE31A1E + _id_3AACF02225CA0DA5::_id_BAF5E17D7033A223(self);
  return _id_BBAC576AADE31A1E;
}

_id_B0D22762C7EE8FE4() {
  if(!isDefined(level._id_A488DE48EEE3F95E))
    level._id_A488DE48EEE3F95E = getdvarint("dvar_B3D354DAB8DA45D4", 0);

  return level._id_A488DE48EEE3F95E;
}

_id_0E249CFFD8B8F7A9(index, lootid, quantity, cooldown) {
  ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);

  if(lootid == 0 || quantity <= 0) {
    lootid = 0;
    quantity = 0;
  }

  if(!isDefined(cooldown))
    cooldown = 0;

  self setplayerdata(level._id_5D69837CF4DB0407, "dmzInventory", index, "lootID", lootid);
  self setplayerdata(level._id_5D69837CF4DB0407, "dmzInventory", index, "quantity", quantity);
  self setplayerdata(level._id_5D69837CF4DB0407, "dmzInventory", index, "cooldownEndTime", cooldown);
}

_id_7F18210BF7CEDD4B(index, _id_6A2F907D62DAF47B) {
  if(_id_6A2F907D62DAF47B <= 0)
    _id_6A2F907D62DAF47B = 0;

  self setplayerdata(level._id_5D69837CF4DB0407, "dmzInventory", index, "lootedQuantity", _id_6A2F907D62DAF47B);
}

_id_C324D060CDE743E3(lootid, quantity) {
  if(!isDefined(quantity))
    quantity = 1;

  if(_id_774FEF5F034555BA()) {
    itemtype = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(lootid);

    if(isDefined(itemtype) && itemtype == "weapon") {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < quantity; _id_AC0E594AC96AA3A8++) {
        index = _id_752A16F10A698186(lootid, ::_id_AE513B3A65D8BFBC);

        if(isDefined(index) && self getplayerdata(level._id_5D69837CF4DB0407, "dmzInventory", index, "cooldownEndTime") > getsystemtime()) {
          _id_0E249CFFD8B8F7A9(index, lootid, 1, 0);
          _id_7F18210BF7CEDD4B(index, 1);
        }

        _id_A5321C6E027413F8 = _id_E89462F915A860FD();

        if(isDefined(_id_A5321C6E027413F8)) {
          _id_0E249CFFD8B8F7A9(_id_A5321C6E027413F8, lootid, 1);
          _id_7F18210BF7CEDD4B(_id_A5321C6E027413F8, 1);
        }
      }

      return;
    }
  }

  index = _id_752A16F10A698186(lootid);

  if(isDefined(index)) {
    _id_FF239359935AA777 = self getplayerdata(level._id_5D69837CF4DB0407, "dmzInventory", index, "quantity");
    _id_FDFD1B213EF1E39C = self getplayerdata(level._id_5D69837CF4DB0407, "dmzInventory", index, "lootedQuantity");
    _id_0E249CFFD8B8F7A9(index, lootid, _id_FF239359935AA777 + quantity);
    _id_7F18210BF7CEDD4B(index, _id_FDFD1B213EF1E39C + quantity);
  } else {
    index = _id_E89462F915A860FD();

    if(isDefined(index)) {
      _id_0E249CFFD8B8F7A9(index, lootid, quantity);
      _id_7F18210BF7CEDD4B(index, quantity);
    }
  }
}

_id_4BE4A391F94837BF(lootid) {
  if(lootid == 0)
    return undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 50; _id_AC0E594AC96AA3A8++) {
    _id_EEEAE9DEFA0C1E95 = self getplayerdata(level._id_5D69837CF4DB0407, "dmzInventory", _id_AC0E594AC96AA3A8, "lootID");

    if(lootid == _id_EEEAE9DEFA0C1E95) {
      if(self getplayerdata(level._id_5D69837CF4DB0407, "dmzInventory", _id_AC0E594AC96AA3A8, "cooldownEndTime") > getsystemtime())
        return _id_AC0E594AC96AA3A8;
    }
  }

  return undefined;
}

_id_25BE694D7A22DB61(_id_3793828403C6873E) {
  if(self getplayerdata(level._id_5D69837CF4DB0407, "dmzInventory", _id_3793828403C6873E, "cooldownEndTime") > getsystemtime())
    return 0;

  return 1;
}

_id_AE513B3A65D8BFBC(_id_3793828403C6873E) {
  if(self getplayerdata(level._id_5D69837CF4DB0407, "dmzInventory", _id_3793828403C6873E, "cooldownEndTime") > getsystemtime())
    return 1;

  return 0;
}

_id_752A16F10A698186(lootid, _id_7191CAA0AEAD68A5) {
  if(lootid == 0)
    return undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 50; _id_AC0E594AC96AA3A8++) {
    _id_EEEAE9DEFA0C1E95 = self getplayerdata(level._id_5D69837CF4DB0407, "dmzInventory", _id_AC0E594AC96AA3A8, "lootID");

    if(lootid == _id_EEEAE9DEFA0C1E95) {
      if(!isDefined(_id_7191CAA0AEAD68A5) || self[[_id_7191CAA0AEAD68A5]](_id_AC0E594AC96AA3A8))
        return _id_AC0E594AC96AA3A8;
    }
  }

  return undefined;
}

_id_E89462F915A860FD() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 50; _id_AC0E594AC96AA3A8++) {
    _id_EEEAE9DEFA0C1E95 = self getplayerdata(level._id_5D69837CF4DB0407, "dmzInventory", _id_AC0E594AC96AA3A8, "lootID");

    if(_id_EEEAE9DEFA0C1E95 == 0)
      return _id_AC0E594AC96AA3A8;
  }

  return undefined;
}

_id_7F04A682872040DB(player) {
  for(_id_3793828403C6873E = 0; _id_3793828403C6873E < 50; _id_3793828403C6873E++)
    player setplayerdata(level._id_5D69837CF4DB0407, "dmzInventory", _id_3793828403C6873E, "lootedQuantity", 0);
}

_id_EE79F56D03F6A83D(player) {
  for(_id_3793828403C6873E = 0; _id_3793828403C6873E < 50; _id_3793828403C6873E++) {
    player setplayerdata(level._id_5D69837CF4DB0407, "dmzInventory", _id_3793828403C6873E, "lootID", 0);
    player setplayerdata(level._id_5D69837CF4DB0407, "dmzInventory", _id_3793828403C6873E, "quantity", 0);
    player setplayerdata(level._id_5D69837CF4DB0407, "dmzInventory", _id_3793828403C6873E, "lootedQuantity", 0);
    player setplayerdata(level._id_5D69837CF4DB0407, "dmzInventory", _id_3793828403C6873E, "cooldownEndTime", 0);
  }
}

_id_774FEF5F034555BA() {
  if(!isDefined(level._id_0113572A27A3AC22))
    level._id_0113572A27A3AC22 = getdvarint("dvar_E28234D5ED130FB4", 1);

  return level._id_0113572A27A3AC22;
}

_id_C1106D5209A8B595() {
  items = [];

  if(!isDefined(self.br_ammo))
    return items;

  foreach(ammotype, count in self.br_ammo) {
    if(count == 0) {
      continue;
    }
    item = spawnStruct();
    item.lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(ammotype);
    item.quantity = count;
    items[items.size] = item;
  }

  return items;
}

_id_9CD290910C24D4D3() {
  items = [];
  _id_9FD35FFD09E2A230 = _id_2D9D24F7C63AC143::_id_57931A717F140EBE(self);

  foreach(weapon in _id_9FD35FFD09E2A230) {
    variantid = weapon.variantid;

    if(!isDefined(weapon.variantid))
      variantid = 0;

    _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(weapon);
    lootid = _id_2669878CF5A1B6BC::_id_79D6E6C22245687A(_id_AB501F397D3CD312, variantid);

    if(isDefined(lootid) && lootid > 0) {
      item = spawnStruct();
      item.lootid = lootid;
      item.quantity = 1;
      item.objweapon = weapon;
      _id_FE4048AD22C35D73 = _id_724736FCF0FB6604::_id_2AB3BDA08C595A32(self, weapon);

      if(isDefined(_id_FE4048AD22C35D73))
        item._id_E1147886CCF51970 = _id_724736FCF0FB6604::_id_86A5C7670325346B(self, _id_FE4048AD22C35D73);

      if(isDefined(_id_FE4048AD22C35D73)) {
        _id_96C4059AA2EABFB8 = _id_0B7A9CE0A2282B79::_id_74031E3249A6F69E(self, _id_FE4048AD22C35D73);

        if(isDefined(_id_96C4059AA2EABFB8))
          item._id_4E479E14D0837E84 = _id_96C4059AA2EABFB8;
      }

      items[items.size] = item;
    }
  }

  ref = scripts\mp\equipment::getcurrentequipment("primary");

  if(isDefined(ref)) {
    _id_212E6B7D207A0089 = scripts\mp\equipment::getequipmentslotammo("primary");
    lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(ref);

    if(isDefined(lootid) && _id_212E6B7D207A0089 > 0) {
      item = spawnStruct();
      item.lootid = lootid;
      item.quantity = _id_212E6B7D207A0089;
      items[items.size] = item;
    }
  }

  ref = scripts\mp\equipment::getcurrentequipment("secondary");

  if(isDefined(ref)) {
    _id_212E6B7D207A0089 = scripts\mp\equipment::getequipmentslotammo("secondary");
    lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(ref);

    if(isDefined(lootid) && isDefined(_id_212E6B7D207A0089) && _id_212E6B7D207A0089 > 0) {
      item = spawnStruct();
      item.lootid = lootid;
      item.quantity = _id_212E6B7D207A0089;
      items[items.size] = item;
    }
  }

  ref = scripts\mp\equipment::getcurrentequipment("super");
  ref = _id_600B944A95C3A7BF::_id_151B82E1257F4CDE(ref);
  _id_212E6B7D207A0089 = _id_1E4A61DB11011446::getsuperweapondisabledammobr();
  lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(ref);

  if(isDefined(lootid) && isDefined(_id_212E6B7D207A0089) && _id_212E6B7D207A0089 > 0) {
    item = spawnStruct();
    item.lootid = lootid;
    item.quantity = _id_212E6B7D207A0089;
    items[items.size] = item;
  }

  ref = scripts\mp\killstreaks\killstreaks::getkillstreakinslot(1);

  if(isDefined(ref)) {
    lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(ref.streakname);

    if(isDefined(lootid)) {
      item = spawnStruct();
      item.lootid = lootid;
      item.quantity = 1;
      items[items.size] = item;
    }
  }

  if(_id_2CEDCC356F1B9FC8::hasplatepouch()) {
    lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("armor_satchel");

    if(isDefined(lootid)) {
      item = spawnStruct();
      item.lootid = lootid;
      item.quantity = 1;
      items[items.size] = item;
    }
  }

  if(scripts\cp_mp\gasmask::hasgasmask(self)) {
    lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("gas_mask");

    if(isDefined(lootid)) {
      item = spawnStruct();
      item.lootid = lootid;
      item.quantity = 1;
      items[items.size] = item;
    }
  }

  itemname = self.equipment["health"];
  _id_9BE70D6D4FF253A1 = scripts\mp\equipment::getequipmentslotammo("health");

  if(isDefined(itemname) && isDefined(_id_9BE70D6D4FF253A1) && _id_9BE70D6D4FF253A1 > 0) {
    item = spawnStruct();
    item.lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("armor_plate");
    item.quantity = _id_9BE70D6D4FF253A1;
    items[items.size] = item;
  }

  return items;
}

_id_8C5B523B8E941DC2(_id_089688461C79EF11, _id_FE4048AD22C35D73, ref) {
  self setplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "weapon", ref);
}

_id_E5A485A5370DEBC1(_id_089688461C79EF11, _id_FE4048AD22C35D73, lootid) {
  self setplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "lootItemID", lootid);
}

_id_0E2B623E5AD975EE(_id_089688461C79EF11, _id_FE4048AD22C35D73) {
  _id_8C5B523B8E941DC2(_id_089688461C79EF11, _id_FE4048AD22C35D73, "iw9_me_fists");
  _id_E5A485A5370DEBC1(_id_089688461C79EF11, _id_FE4048AD22C35D73, 0);
  self setplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "camo", "none");
  self setplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "reticle", "none");
  self setplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "cosmeticAttachment", "none");
  self setplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "variantID", 0);
  self setplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "blueprintName", "");

  for(_id_40E4B9C48B36C9EC = 0; _id_40E4B9C48B36C9EC < 5; _id_40E4B9C48B36C9EC++) {
    self setplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "attachmentSetup", _id_40E4B9C48B36C9EC, "attachment", "none");
    self setplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "attachmentSetup", _id_40E4B9C48B36C9EC, "variantID", 0);
  }

  for(_id_36D2ABBDCBCB186C = 0; _id_36D2ABBDCBCB186C < 4; _id_36D2ABBDCBCB186C++)
    self setplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "sticker", _id_36D2ABBDCBCB186C, "none");
}

_id_7734D7B754DF1192(_id_089688461C79EF11, _id_50B79E19F823671D, ref) {
  self setplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "equipmentSetups", _id_50B79E19F823671D, "equipment", ref);
}

_id_5F0596C296180F6C(index, ref) {
  self setplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "killstreakSetups", index, "killstreak", ref);
}

_id_E93FF591A55C2CD6(_id_089688461C79EF11, _id_A780F473A6275DF4, ref) {
  return self setplayerdata(level._id_13ECA9A3244E502F, "squadMembers", "loadouts", _id_089688461C79EF11, "fieldUpgrades", _id_A780F473A6275DF4, ref);
}

_id_568D5B6B51690C6A() {
  _id_0E2B623E5AD975EE(0, 0);
  _id_0E2B623E5AD975EE(0, 1);
  _id_7734D7B754DF1192(0, 0, "none");
  _id_7734D7B754DF1192(0, 1, "none");
  _id_E93FF591A55C2CD6(0, 0, "none");
  _id_5F0596C296180F6C(0, "none");
}

_id_CFC379803B1DD46F() {
  _id_FE4048AD22C35D73 = 0;
  _id_9FD35FFD09E2A230 = _id_2D9D24F7C63AC143::_id_57931A717F140EBE(self);

  foreach(weapon in _id_9FD35FFD09E2A230) {
    if(_id_FE4048AD22C35D73 > 1) {
      continue;
    }
    variantid = weapon.variantid;

    if(!isDefined(weapon.variantid))
      variantid = 0;

    _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(weapon);
    lootid = _id_2669878CF5A1B6BC::_id_79D6E6C22245687A(_id_AB501F397D3CD312, variantid);
    _id_8C5B523B8E941DC2(0, _id_FE4048AD22C35D73, _id_AB501F397D3CD312);

    if(!isDefined(lootid))
      lootid = 0;

    _id_E5A485A5370DEBC1(0, _id_FE4048AD22C35D73, lootid);
    _id_FE4048AD22C35D73++;
  }

  ref = scripts\mp\equipment::getcurrentequipment("primary");
  _id_212E6B7D207A0089 = scripts\mp\equipment::getequipmentslotammo("primary");

  if(isDefined(ref) && _id_212E6B7D207A0089 > 0)
    _id_7734D7B754DF1192(0, 0, ref);

  ref = scripts\mp\equipment::getcurrentequipment("secondary");
  _id_212E6B7D207A0089 = scripts\mp\equipment::getequipmentslotammo("secondary");

  if(isDefined(ref) && _id_212E6B7D207A0089 > 0)
    _id_7734D7B754DF1192(0, 1, ref);

  ref = scripts\mp\equipment::getcurrentequipment("super");
  ref = _id_600B944A95C3A7BF::_id_151B82E1257F4CDE(ref);
  _id_212E6B7D207A0089 = _id_1E4A61DB11011446::getsuperweapondisabledammobr();

  if(isDefined(ref) && _id_212E6B7D207A0089 > 0)
    _id_E93FF591A55C2CD6(0, 0, ref);

  ref = scripts\mp\killstreaks\killstreaks::getkillstreakinslot(1);

  if(isDefined(ref))
    _id_5F0596C296180F6C(0, ref.streakname);
}

_id_BAC731E0FDAA0CCB(lootid) {
  if(!isDefined(lootid)) {
    return;
  }
  type = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(lootid);

  if(!isDefined(type)) {
    return;
  }
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
      if(isDefined(level._id_B33C035C483C2893) && isDefined(level._id_B33C035C483C2893["onMatchStart"]) && isDefined(level._id_B33C035C483C2893["onMatchStart"][ref]))
        [[level._id_B33C035C483C2893["onMatchStart"][ref]]](self);

      return;
  }

  return;
}

_id_A82DECEE54864929(lootid) {
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
      break;
    case "consumable":
      if(isDefined(level._id_B33C035C483C2893) && isDefined(level._id_B33C035C483C2893["onExtract"]) && isDefined(level._id_B33C035C483C2893["onExtract"][ref]))
        [[level._id_B33C035C483C2893["onExtract"][ref]]](self);

      break;
  }

  if(_id_7E52B56769FA7774::_id_A38E261031751C09(ref))
    _id_0B7A9CE0A2282B79::_id_DDBC94F52A1947B5(self, lootid);

  return;
}

_id_2D55E66E05614871() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 11; _id_AC0E594AC96AA3A8++) {
    lootid = self getplayerdata(level._id_5D69837CF4DB0407, "dmzBackpackFE", _id_AC0E594AC96AA3A8, "lootID");
    quantity = self getplayerdata(level._id_5D69837CF4DB0407, "dmzBackpackFE", _id_AC0E594AC96AA3A8, "quantity");
    ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);
    _id_2D9D24F7C63AC143::_id_6196D9EA9A30E609(_id_AC0E594AC96AA3A8);
    _id_2D9D24F7C63AC143::_id_897B29ADB37F06A7(_id_AC0E594AC96AA3A8);
    _id_BAC731E0FDAA0CCB(lootid);
    self setplayerdata(level._id_5D69837CF4DB0407, "dmzBackpackFE", _id_AC0E594AC96AA3A8, "lootID", 0);
    self setplayerdata(level._id_5D69837CF4DB0407, "dmzBackpackFE", _id_AC0E594AC96AA3A8, "quantity", 0);
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 11; _id_AC0E594AC96AA3A8++) {
    lootid = self getplayerdata(level._id_5D69837CF4DB0407, "dmzBackpackFE", _id_AC0E594AC96AA3A8, "lootID");
    quantity = self getplayerdata(level._id_5D69837CF4DB0407, "dmzBackpackFE", _id_AC0E594AC96AA3A8, "quantity");
    ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 11; _id_AC0E594AC96AA3A8++) {
    lootid = _id_2D9D24F7C63AC143::_id_6196D9EA9A30E609(_id_AC0E594AC96AA3A8);
    quantity = _id_2D9D24F7C63AC143::_id_897B29ADB37F06A7(_id_AC0E594AC96AA3A8);
    ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);
  }
}