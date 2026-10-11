/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\loot\common_inventory.gsc
******************************************************/

#using script_443d99fe707f1d9f;
#using script_485622d93fa7e4cf;
#using script_5640d32580c6bc7d;
#using script_6fc415ff6a905dc1;
#using scripts\common\callbacks;
#using scripts\cp_mp\loot\common_cache;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#using scripts\mp\utility\lui_game_event_aggregator;
#namespace common_inventory;

function inventory_init() {
  if(!inventory_isenabled()) {
    return;
  }

  if(!isDefined(level.commonitem)) {
    assertmsg("<dev string:x1c>");
    return;
  }

  function_d3405ff387ff4f2e();
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&function_893d47a3b0d1dfe2);
  registersharedfunc("game", "removeFirstFromBackpack", &function_181a584e4a68d5d6);
}

function private function_893d47a3b0d1dfe2(notification, var_421750c958bd3064) {
  if(istrue(level.infilcinematicactive)) {
    return;
  }

  if(isDefined(notification) && isDefined(var_421750c958bd3064) && !istrue(self.isjuggernaut)) {
    switch (notification) {
      case #"hash_f9442c17e42ea782":
        itemtype = function_a46acbfe17ad9a54(var_421750c958bd3064);

        if((itemtype == 3 || itemtype == 1) && (isDefined(self.triggeringstreak) || istrue(self.enabledequipdeployvfx))) {
          break;
        }

        itemindex = function_4953ec8e37aa67b8(var_421750c958bd3064);

        if(function_5711a00587f71794(self) && (!is_equal(itemtype, 0) || is_equal(itemtype, 0) && function_c44440af852c483(self)) && (function_1225f23a18664f4c(self) || itemtype != 1)) {
          function_80bada2833945a7a(itemtype, itemindex);
          function_80fcd9b9bddea7a9(itemtype, itemindex, 1);
        } else {
          uidropitem(itemtype, itemindex, 1);
        }

        break;
      case #"hash_24d3e929a240e2d7":
        itemtype = function_a46acbfe17ad9a54(var_421750c958bd3064);

        if((itemtype == 3 || itemtype == 1) && (isDefined(self.triggeringstreak) || istrue(self.enabledequipdeployvfx))) {
          break;
        }

        itemindex = function_4953ec8e37aa67b8(var_421750c958bd3064);

        if(function_5711a00587f71794(self) && (!is_equal(itemtype, 0) || is_equal(itemtype, 0) && function_c44440af852c483(self)) && (function_1225f23a18664f4c(self) || itemtype != 1)) {
          function_80bada2833945a7a(itemtype, itemindex, undefined, 1);
          function_80fcd9b9bddea7a9(itemtype, itemindex);
        } else {
          uidropitem(itemtype, itemindex);
        }

        break;
      case #"hash_344a8be1e67f4848":
        itemtype = function_a46acbfe17ad9a54(var_421750c958bd3064);

        if(itemtype == 3 && isDefined(self.triggeringstreak)) {
          break;
        }

        itemindex = function_4953ec8e37aa67b8(var_421750c958bd3064);

        if(itemtype == 1 && itemindex == 2) {
          function_400fb193601d3a21();
        } else {
          function_777092be5abab355(itemindex);
        }

        break;
      case #"hash_1e7d2b97f26d79a5":
        itemtype = function_a46acbfe17ad9a54(var_421750c958bd3064);

        if(itemtype == 3 && isDefined(self.triggeringstreak)) {
          break;
        }

        itemindex = function_4953ec8e37aa67b8(var_421750c958bd3064);
        [itembundle, quantity] = function_80fcd9b9bddea7a9(itemtype, itemindex);

        if(!isDefined(itembundle) || quantity <= 0) {
          assertmsg("<dev string:x80>" + itemtype + "<dev string:xc5>");
          break;
        }

        itemcount = function_7209c8cd4b2e3afd(quantity);
        remainder = function_4b5b6b5953138fe7(itembundle, itemcount);

        if(remainder == 0) {
          break;
        }

        remaindercount = function_7209c8cd4b2e3afd(remainder);
        function_1a95cb90efa117b8(itembundle, remaindercount);
        break;
      case #"hash_df97645422cac8a6":
        itemtype = function_a46acbfe17ad9a54(var_421750c958bd3064);

        if(itemtype != 1) {
          break;
        }

        itemindex = function_4953ec8e37aa67b8(var_421750c958bd3064);
        function_c14b2cb6d5a65def(itemindex);
        break;
      case #"hash_21120d09fe99acc5":
        lootid = var_421750c958bd3064;
        item = function_23a72b496d4206c9(lootid);

        if(!isDefined(item)) {
          assertmsg("<dev string:xeb>" + lootid + "<dev string:x129>");
          break;
        }

        function_354e083223035de2(item, lootid);
        break;
      case #"hash_970fe96b5f1fa60b":
        itemtype = function_a46acbfe17ad9a54(var_421750c958bd3064);

        if(itemtype == 3 && isDefined(self.triggeringstreak)) {
          break;
        }

        itemindex = function_4953ec8e37aa67b8(var_421750c958bd3064);

        if(isDefined(self.var_2fa5b49969def47)) {
          scripts\cp_mp\loot\common_cache::closelootablecontainer(self.var_2fa5b49969def47, self);
        }

        [var_632d9a80cbdc3a50, removedquantity] = function_80fcd9b9bddea7a9(itemtype, itemindex);
        item = spawnStruct();
        item.count = removedquantity;
        item.var_9c44eb334c225d45 = 2;
        lootid = function_6d15e119c2779a93(var_632d9a80cbdc3a50);
        function_86d7576fb0f41e09(item, lootid);
        break;
      default:
        break;
    }
  }
}

function private function_a46acbfe17ad9a54(var_421750c958bd3064) {
  return (var_421750c958bd3064 & 256 - 1 << 8) >> 8;
}

function private function_4953ec8e37aa67b8(var_421750c958bd3064) {
  return var_421750c958bd3064 & 256 - 1;
}

function private uidropitem(itemtype, itemindex, quantity) {
  [var_632d9a80cbdc3a50, removedquantity] = function_80fcd9b9bddea7a9(itemtype, itemindex, quantity);

  if(isDefined(var_632d9a80cbdc3a50) && isDefined(removedquantity) && removedquantity > 0) {
    dropstruct = scripts\cp_mp\loot\common_item::function_3fa6e9da3fd741f2();
    scripts\cp_mp\loot\common_item::function_ab8cf1b73aaa14(dropstruct, var_632d9a80cbdc3a50);
    items_dropitem(var_632d9a80cbdc3a50, removedquantity, dropstruct);
  }
}

function private function_80fcd9b9bddea7a9(itemtype, itemindex, quantity) {
  var_632d9a80cbdc3a50 = undefined;
  removedquantity = 0;

  switch (itemtype) {
    case 0:
      if(function_ceee9e1f4c8d1135()) {
        callbacks = function_cca8bbe88a39ad41("currency");
        [var_632d9a80cbdc3a50, currentquantity] = self[[callbacks.var_df9b308efe82294a]]();
        var_74806f0c4caa7e55 = currentquantity;

        if(isDefined(quantity)) {
          var_74806f0c4caa7e55 = quantity * getmatchrulesdata("brData", "plunderDropSomeAmount");
        }

        removedquantity = self[[callbacks.var_bd286dd0c1f53098]](var_74806f0c4caa7e55);
      }

      break;
    case 1:
      callbacks = function_cca8bbe88a39ad41("weapon");
      lifetimeoverride = namespace_b4f2af6fa775d9b::function_278858bf72df5d3(itemindex);
      self[[callbacks.var_bd286dd0c1f53098]](itemindex, lifetimeoverride);
      break;
    case 2:
      slot = scripts\mp\equipment::function_4967838290cb31b9(itemindex);
      item_type = "lethal";

      if(slot == "secondary") {
        item_type = "tactical";
      }

      if(slot == "health") {
        item_type = "armor";
      }

      callbacks = function_cca8bbe88a39ad41(item_type);
      [var_632d9a80cbdc3a50, currentquantity] = self[[callbacks.var_df9b308efe82294a]]();
      removedquantity = self[[callbacks.var_bd286dd0c1f53098]](quantity);
      break;
    case 3:
      item_type = "killstreak";
      callbacks = function_cca8bbe88a39ad41(item_type);
      [var_632d9a80cbdc3a50, removedquantity] = self[[callbacks.var_df9b308efe82294a]]();
      self[[callbacks.var_bd286dd0c1f53098]]();
      break;
    case 4:
      item_type = "super";
      callbacks = function_cca8bbe88a39ad41(item_type);
      [var_632d9a80cbdc3a50, removedquantity] = self[[callbacks.var_df9b308efe82294a]]();
      self[[callbacks.var_bd286dd0c1f53098]]();
      break;
    case 6:
      item_type = "gasmask";
      callbacks = function_cca8bbe88a39ad41(item_type);
      [var_632d9a80cbdc3a50, removedquantity] = self[[callbacks.var_df9b308efe82294a]]();
      self[[callbacks.var_bd286dd0c1f53098]]();
      break;
    case 7:
      item_type = "revive";
      callbacks = function_cca8bbe88a39ad41(item_type);
      [var_632d9a80cbdc3a50, removedquantity] = self[[callbacks.var_df9b308efe82294a]]();
      self[[callbacks.var_bd286dd0c1f53098]]();
      break;
    case 5:
    case 10:
      removedlootid = function_d870b2c45335bd88(itemindex);
      currentquantity = function_5ce7fe3dca9c1a22(itemindex);
      var_e0ceabe179f1f193 = function_fc925a153c7fd55c(removedlootid);

      if(!isDefined(var_e0ceabe179f1f193)) {
        assertmsg("<dev string:x145>" + removedlootid + "<dev string:x184>");
        break;
      }

      var_632d9a80cbdc3a50 = getscriptbundle("itemspawnentry:" + var_e0ceabe179f1f193);
      newlootid = 0;
      newquantity = 0;
      removedquantity = currentquantity;

      if(isDefined(quantity) && quantity > 0 && quantity < currentquantity && !istrue(var_632d9a80cbdc3a50.var_ec7430d9ed0b6e64)) {
        removedquantity = quantity;
        newlootid = removedlootid;
        newquantity = currentquantity - removedquantity;
      }

      function_ca3bbb1070436540(itemindex, newlootid, newquantity);
      break;
    case 11:
      break;
  }

  return [var_632d9a80cbdc3a50, removedquantity];
}

function function_400fb193601d3a21() {
  var_17d89f18c1d0eb4f = self getcurrentweapon();
  function_ad6e2b653093328a();

  if(var_17d89f18c1d0eb4f.basename != "iw9_me_fists_mp" && !issameweapon(var_17d89f18c1d0eb4f, level.weaponnone)) {
    function_ad55c4cd0426138d(var_17d89f18c1d0eb4f);
  }

  self takeweapon(var_17d89f18c1d0eb4f);
  params = spawnStruct();
  params.oldlocation = "backpack";
  params.var_d84bffa3178eec97 = 0;
  params.newlocation = "loadout";
  params.var_1e6cc7248a40392e = 0;
  callback::callback("inventory_item_moved", params);
}

function function_777092be5abab355(itemslotindex) {
  lootid = function_d870b2c45335bd88(itemslotindex);
  quantity = function_5ce7fe3dca9c1a22(itemslotindex);

  if(lootid == 0 || quantity == 0) {
    return;
  }

  function_b9d2aee928c46b5f(lootid, quantity, itemslotindex, undefined);
}

function function_b9d2aee928c46b5f(lootid, quantity, inventoryslotindex, countalt, var_cbc0ab512152abfc) {
  newitembundlename = function_fc925a153c7fd55c(lootid);
  var_a8856d1c2cbf78f6 = "itemspawnentry:" + newitembundlename;

  if(function_633f07e180b6ec8f(var_a8856d1c2cbf78f6)) {
    return false;
  }

  newitembundle = getscriptbundle(var_a8856d1c2cbf78f6);
  var_2aac741db0d5fe2e = newitembundle.scriptable;

  if(!isDefined(var_2aac741db0d5fe2e)) {
    return false;
  }

  newitemcallbacks = function_cca8bbe88a39ad41(newitembundle.type);

  if(!isDefined(newitemcallbacks)) {
    assertmsg("<dev string:x1c9>" + newitembundle.type + "<dev string:x209>");
    return false;
  }

  if(isDefined(newitemcallbacks.canusefunc) && !self[[newitemcallbacks.canusefunc]](newitembundle, undefined, 0, 1)) {
    function_fbfd7096a2dbc7e7(newitembundle, 0);
    return false;
  }

  [var_c8072c59ba873dc1, olditemcount] = self[[newitemcallbacks.var_df9b308efe82294a]]();
  var_c4c781308ba64c2 = olditemcount;
  packedcount = function_7209c8cd4b2e3afd(quantity, undefined, countalt);
  newitemremainder = function_1a95cb90efa117b8(newitembundle, packedcount);

  if(isarray(newitemremainder)) {
    newitemremainder = newitemremainder[0];
  }

  if(newitemremainder >= packedcount) {
    function_fbfd7096a2dbc7e7(newitembundle, 0);
    return false;
  }

  assertex(isDefined(newitemremainder), "<dev string:x21d>" + newitembundle.type + "<dev string:x24e>");

  if(isstruct(var_c8072c59ba873dc1) && isDefined(var_c8072c59ba873dc1.ref) && var_c8072c59ba873dc1.ref == newitembundle.ref && !istrue(newitembundle.disablestacking)) {
    var_c4c781308ba64c2 = newitemremainder;
    olditemcount = newitemremainder;
  }

  if(isDefined(inventoryslotindex)) {
    var_72371d0de2680b76 = 0;

    if(isDefined(var_c8072c59ba873dc1) && var_c4c781308ba64c2 > 0) {
      var_72371d0de2680b76 = function_6d15e119c2779a93(var_c8072c59ba873dc1);
    }

    function_ca3bbb1070436540(inventoryslotindex, var_72371d0de2680b76, var_c4c781308ba64c2);
  }

  if(isDefined(var_cbc0ab512152abfc) && var_cbc0ab512152abfc && !isDefined(inventoryslotindex) && isDefined(var_c8072c59ba873dc1) && olditemcount > 0) {
    items_dropitem(var_c8072c59ba873dc1, olditemcount);
  }

  function_fbfd7096a2dbc7e7(newitembundle, 1);
  return true;
}

function function_f64964e50cc34c47(itembundlename, itembundle, item, autouse) {
  lootid = function_6d15e119c2779a93(itembundle);

  if(!isDefined(lootid)) {
    assertmsg("<dev string:x273>" + itembundlename + "<dev string:x2a5>");
    return item.count;
  }

  count = function_b8bfea9514c89a77(item.count);

  if(function_3298f1ad0b756cbd(itembundle, count, autouse)) {
    params = spawnStruct();
    params.item = item;
    params.itembundlename = itembundlename;
    params.itembundle = itembundle;
    params.tobackpack = 1;
    callback::callback("player_item_pickup", params);
    remainder = function_4b5b6b5953138fe7(itembundle, item.count);

    if(remainder <= 0) {
      self notify("self_pickedupitem", getxhashasset(item.type));
    }

    return remainder;
  }

  return item.count;
}

function function_3298f1ad0b756cbd(itembundle, quantity, autouse) {
  backpacksize = function_1b35b10884bd8d67();
  lootid = function_6d15e119c2779a93(itembundle);

  for(i = 0; i < backpacksize; i++) {
    currentlootid = function_d870b2c45335bd88(i);

    if(currentlootid == 0 && currentlootid != lootid && (!istrue(autouse) || istrue(itembundle.var_bbae53787b1abf3e) && istrue(itembundle.var_515391a9c294e239))) {
      return true;
    }

    if(currentlootid == lootid && !istrue(itembundle.disablestacking) && (!istrue(autouse) || istrue(itembundle.var_bbae53787b1abf3e))) {
      currentquantity = function_5ce7fe3dca9c1a22(i);

      if(currentquantity < function_c7171bcea41dd66f(itembundle)) {
        return true;
      }
    }
  }

  return false;
}

function function_4f73be3d1273e86b() {
  backpacksize = function_1b35b10884bd8d67();

  for(i = 0; i < backpacksize; i++) {
    currentlootid = function_d870b2c45335bd88(i);

    if(currentlootid == 0) {
      return false;
    }
  }

  return true;
}

function function_4776284a348ebb6a(targetlootid) {
  if(!isDefined(targetlootid)) {
    assert("<dev string:x2cf>");
    return -1;
  }

  backpacksize = function_1b35b10884bd8d67();

  for(i = 0; i < backpacksize; i++) {
    currentlootid = function_d870b2c45335bd88(i);

    if(currentlootid == targetlootid) {
      return i;
    }
  }

  return -1;
}

function function_4b5b6b5953138fe7(itembundle, itemcount) {
  if(!isDefined(itembundle) || !isDefined(itemcount)) {
    assertmsg("<dev string:x301>");
    return 0;
  }

  itemnamestring = ter_op(isDefined(itembundle.ref), itembundle.ref, "<dev string:x34e>");

  lootid = function_6d15e119c2779a93(itembundle);

  if(!isDefined(lootid)) {
    assertmsg("<dev string:x273>" + function_2cdc55ba39d97d70(itemnamestring) + "<dev string:x2a5>");
    return itemcount;
  }

  quantity = function_b8bfea9514c89a77(itemcount);
  maxcount = function_c7171bcea41dd66f(itembundle);

  if(!istrue(itembundle.disablestacking)) {
    for(i = 0; i < function_1b35b10884bd8d67(); i++) {
      currentlootid = function_d870b2c45335bd88(i);

      if(currentlootid == lootid) {
        slotquantity = function_5ce7fe3dca9c1a22(i);

        if(slotquantity <= maxcount) {
          slotsavailable = maxcount - slotquantity;
          var_a17f14f68ba0defc = min(maxcount, slotquantity + quantity);
          function_ca3bbb1070436540(i, lootid, var_a17f14f68ba0defc);
          quantity = int(max(0, quantity - slotsavailable));
        }
      }

      if(quantity <= 0) {
        return 0;
      }
    }
  }

  for(i = 0; i < function_1b35b10884bd8d67(); i++) {
    currentlootid = function_d870b2c45335bd88(i);

    if(currentlootid == 0 && currentlootid != lootid) {
      var_514fa029a62f1e60 = min(maxcount, quantity);
      function_ca3bbb1070436540(i, lootid, var_514fa029a62f1e60);
      quantity -= var_514fa029a62f1e60;

      if(quantity <= 0) {
        return 0;
      }
    }
  }

  return function_7209c8cd4b2e3afd(quantity);
}

function function_dbd1a6ad7182a0da() {
  if(isDefined(self.var_8bebfe2a52f10bf7)) {
    foreach(weapon in self.primaryweapons) {
      if(weapon.basename != "none") {
        _takeweapon(weapon);
      }
    }

    foreach(weapon in self.var_8bebfe2a52f10bf7) {
      if(weapon.basename != "none") {
        self giveweapon(weapon);
        _switchtoweaponimmediate(weapon);
      }
    }

    self.var_8bebfe2a52f10bf7 = undefined;
  }

  for(index = 0; index < 50; index++) {
    lootid = self getplayerdata(level.progressiongroup, "dmzInventory", index, "lootID");
    quantity = self getplayerdata(level.progressiongroup, "dmzInventory", index, "quantity");
    type = scripts\cp_mp\utility\loot::function_282cf83c9eeda744(lootid);
    ref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);

    if(isDefined(lootid) && lootid > 0) {
      if(type == "weapon") {
        continue;
      }

      itembundlename = function_fc925a153c7fd55c(lootid);

      if(isDefined(itembundlename)) {
        itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
        scriptable = itembundle.scriptable;
        item = spawnStruct();
        item.type = scriptable;
        item.count = function_7209c8cd4b2e3afd(quantity);
        function_de489fa2ffdb7f2d(item, 0);
      }
    }
  }
}

function function_a342582cc42f28cb() {
  self.var_8bebfe2a52f10bf7 = arraycopy(self.primaryweapons);

  foreach(weapon in self.var_8bebfe2a52f10bf7) {
    variantid = weapon.variantid;

    if(!isDefined(weapon.variantid)) {
      variantid = 0;
    }

    rootname = scripts\cp_mp\weapon::getweaponrootname(weapon);
    ref = rootname;

    if(variantid) {
      ref = rootname + "_v" + variantid;
    }

    lootid = function_2c836ad05e5f634c(ref);

    if(isDefined(lootid) && lootid > 0) {
      namespace_512200f0f9e6ebc9::function_c324d060cde743e3(lootid, 1);
    }
  }

  callbacks = function_cca8bbe88a39ad41("tactical");
  [itembundle, quantity] = self[[callbacks.var_df9b308efe82294a]]();
  lootid = function_6d15e119c2779a93(itembundle);

  if(isDefined(lootid) && lootid > 0) {
    namespace_512200f0f9e6ebc9::function_c324d060cde743e3(lootid, quantity);
  }

  callbacks = function_cca8bbe88a39ad41("lethal");
  [itembundle, quantity] = self[[callbacks.var_df9b308efe82294a]]();
  lootid = function_6d15e119c2779a93(itembundle);

  if(isDefined(lootid) && lootid > 0) {
    namespace_512200f0f9e6ebc9::function_c324d060cde743e3(lootid, quantity);
  }

  callbacks = function_cca8bbe88a39ad41("super");
  [itembundle, quantity] = self[[callbacks.var_df9b308efe82294a]]();
  lootid = function_6d15e119c2779a93(itembundle);

  if(isDefined(lootid) && lootid > 0) {
    namespace_512200f0f9e6ebc9::function_c324d060cde743e3(lootid, quantity);
  }

  callbacks = function_cca8bbe88a39ad41("killstreak");
  [itembundle, quantity] = self[[callbacks.var_df9b308efe82294a]]();
  lootid = function_6d15e119c2779a93(itembundle);

  if(isDefined(lootid) && lootid > 0) {
    namespace_512200f0f9e6ebc9::function_c324d060cde743e3(lootid, quantity);
  }
}

function function_48b99b38763ac68c() {
  dropstruct = function_59a2e61d79065dca();
  callbacks = function_cca8bbe88a39ad41("weapon");
  self[[callbacks.var_bd286dd0c1f53098]](0);
  self[[callbacks.var_bd286dd0c1f53098]](1);
  self[[callbacks.var_bd286dd0c1f53098]](2);
  callbacks = function_cca8bbe88a39ad41("lethal");
  [itembundle, quantity] = self[[callbacks.var_df9b308efe82294a]]();

  if(isDefined(itembundle)) {
    items_dropitem(itembundle, quantity, dropstruct);
  }

  callbacks = function_cca8bbe88a39ad41("tactical");
  [itembundle, quantity] = self[[callbacks.var_df9b308efe82294a]]();

  if(isDefined(itembundle)) {
    items_dropitem(itembundle, quantity, dropstruct);
  }

  callbacks = function_cca8bbe88a39ad41("super");
  [itembundle, quantity] = self[[callbacks.var_df9b308efe82294a]]();

  if(isDefined(itembundle)) {
    items_dropitem(itembundle, quantity, dropstruct);
  }

  callbacks = function_cca8bbe88a39ad41("killstreak");
  [itembundle, quantity] = self[[callbacks.var_df9b308efe82294a]]();

  if(isDefined(itembundle)) {
    items_dropitem(itembundle, quantity, dropstruct);
  }

  for(i = 0; i < function_1b35b10884bd8d67(); i++) {
    lootid = function_d870b2c45335bd88(i);
    quantity = function_5ce7fe3dca9c1a22(i);

    if(isDefined(lootid) && lootid > 0) {
      bundlename = function_fc925a153c7fd55c(lootid);
      itembundle = getscriptbundle("itemspawnentry:" + bundlename);
      items_dropitem(itembundle, quantity, dropstruct);
    }
  }
}

function function_ceee9e1f4c8d1135() {
  return true;
}

function private shoulddropitem(itembundle, quantity) {
  return isDefined(itembundle) && isDefined(quantity) && quantity > 0;
}

function function_4433fa5f0f02ffd8(dropstruct, itemindex) {
  lootid = function_d870b2c45335bd88(itemindex);

  if(!isDefined(lootid) || lootid <= 0) {
    return;
  }

  bundlename = function_fc925a153c7fd55c(lootid);

  if(!isDefined(bundlename)) {
    return;
  }

  itembundle = getscriptbundle("itemspawnentry:" + bundlename);

  if(!isDefined(itembundle)) {
    return;
  }

  quantity = function_5ce7fe3dca9c1a22(itemindex);
  function_ca3bbb1070436540(itemindex, lootid, 0);
  items_dropitem(itembundle, quantity, dropstruct);
}

function private function_3d862161c8265c44(callbacks, dropstruct, var_16e342d6918d81d1, var_26b448211c62d57a) {
  if(!function_ceee9e1f4c8d1135()) {
    return;
  }

  [itembundle, quantity] = self[[callbacks.var_df9b308efe82294a]]();

  if(!isDefined(itembundle)) {
    return;
  }

  var_7437c824531b589b = quantity;

  if(isDefined(var_16e342d6918d81d1)) {
    var_7437c824531b589b = [[var_16e342d6918d81d1]](var_7437c824531b589b);
  }

  if(isDefined(var_7437c824531b589b)) {
    while(var_7437c824531b589b > 0) {
      removedquantity = self[[callbacks.var_bd286dd0c1f53098]](var_7437c824531b589b);
      var_7437c824531b589b = max(var_7437c824531b589b - removedquantity, 0);
    }
  }

  var_987ea9f2095b357a = quantity;

  if(isDefined(var_26b448211c62d57a)) {
    var_987ea9f2095b357a = [[var_26b448211c62d57a]](var_987ea9f2095b357a);
  }

  if(shoulddropitem(itembundle, var_987ea9f2095b357a)) {
    while(var_987ea9f2095b357a > 0) {
      item = items_dropitem(itembundle, var_987ea9f2095b357a, dropstruct);

      if(!isDefined(item)) {
        break;
      }

      var_987ea9f2095b357a -= item.count;
    }
  }
}

function function_2166e0fab7a3263(itemtype, dropstruct, itemindex, var_16e342d6918d81d1, var_26b448211c62d57a) {
  if(!isDefined(itemtype)) {
    assertmsg("<dev string:x35e>");
    return;
  }

  callbacks = function_cca8bbe88a39ad41(itemtype);

  if(!isDefined(callbacks)) {
    assertmsg("<dev string:x38b>" + itemtype);
    return;
  }

  switch (itemtype) {
    case #"hash_27124c6c97ccffa1":
      overridelifetime = ter_op(isDefined(dropstruct), dropstruct.var_c62a12bfca2ae58e);
      self[[callbacks.var_bd286dd0c1f53098]](itemindex, overridelifetime);
      break;
    case #"hash_a2937f8adf677a96":
      function_3d862161c8265c44(callbacks, dropstruct, var_16e342d6918d81d1, var_26b448211c62d57a);
      break;
    case #"hash_25789111b74943b4":
    case #"hash_339227cb650975db":
    case #"hash_850999d7864fa3b4":
    case #"hash_c04d8180feb92b2b":
    case #"hash_cce09c1231d104b7":
      [itembundle, quantity] = self[[callbacks.var_df9b308efe82294a]]();
      shoulddrop = shoulddropitem(itembundle, quantity);

      if(shoulddrop) {
        self[[callbacks.var_bd286dd0c1f53098]](quantity);
        items_dropitem(itembundle, quantity, dropstruct);
      }

      break;
    case #"hash_1cac65e1b8bf24a7":
    case #"hash_936cd4f623c2d2db":
    case #"hash_9bb0b5639d19444a":
    case #"hash_b06d15a59bd8ea50":
    case #"hash_d80af4621c199350":
    case #"hash_e534fd8ec73eafb4":
      [itembundle, quantity] = self[[callbacks.var_df9b308efe82294a]]();
      shoulddrop = shoulddropitem(itembundle, quantity);

      if(shoulddrop) {
        self[[callbacks.var_bd286dd0c1f53098]]();
        items_dropitem(itembundle, quantity, dropstruct);
      }

      break;
    case #"hash_37276153aa1bb01d":
    case #"hash_3f28cec865ad2857":
    case #"hash_4c21f84c42d4988e":
    case #"hash_ab671284a3fc4e3d":
    case #"hash_ca90ddd937cbc83a":
    case #"hash_ee5a421e18a58c0f":
    case #"hash_f1a23e97c35685da":
      assertmsg("<dev string:x3c2>" + itemtype);
      break;
    default:
      break;
  }
}

function function_10e55eeb4c15dd5a(item, autouse, var_95484d8d503de3b8) {
  if(!inventory_isenabled()) {
    return false;
  }

  scriptablename = item.type;

  if(function_f0c15201c9f7e1db(scriptablename)) {
    itembundlename = function_2cdc55ba39d97d70(scriptablename);
    var_9ec3e3e77fa5f56c = "itemspawnentry:" + itembundlename;

    if(function_633f07e180b6ec8f(var_9ec3e3e77fa5f56c)) {
      return false;
    }

    itembundle = getscriptbundle(var_9ec3e3e77fa5f56c);

    if(!function_b343caad692916aa(itembundle)) {
      return false;
    }

    if(!istrue(autouse) && function_4f73be3d1273e86b() && !function_3298f1ad0b756cbd(itembundle, function_b8bfea9514c89a77(item.count))) {
      lootid = function_6d15e119c2779a93(itembundle);
      function_354e083223035de2(item, lootid);
      return false;
    }

    var_c3051697735d1320 = item.var_4f74f0aef2b2a8bf;
    remainder = function_f64964e50cc34c47(itembundlename, itembundle, item, autouse);
    quantitystowed = item.count - remainder;

    if(remainder) {
      item.count = remainder;
    } else {
      item.count = 0;
      function_c14962ea14e58968(item);
    }

    if(quantitystowed > 0) {
      function_61e26b275dfa50e0(itembundle, quantitystowed, var_c3051697735d1320, 0, item, var_95484d8d503de3b8);
      return true;
    }

    if(!istrue(var_95484d8d503de3b8)) {
      function_fbfd7096a2dbc7e7(itembundle, 0);
    }
  }

  return false;
}

function function_354e083223035de2(item, lootid) {
  scriptablename = item.type;
  itembundlename = function_2cdc55ba39d97d70(scriptablename);

  if(!isDefined(itembundlename)) {
    assertmsg("<dev string:x404>" + scriptablename + "<dev string:x447>");
    return 0;
  }

  var_9ec3e3e77fa5f56c = "itemspawnentry:" + itembundlename;

  if(function_633f07e180b6ec8f(var_9ec3e3e77fa5f56c)) {
    return 0;
  }

  itembundle = getscriptbundle(var_9ec3e3e77fa5f56c);

  if(!isDefined(itembundle)) {
    assertmsg("<dev string:x47d>" + itembundlename + "<dev string:x447>");
    return 0;
  }

  self.var_34f110a584482e9 = gettime();

  if(!function_b343caad692916aa(itembundle) || istrue(itembundle.notbackpack)) {
    return 0;
  }

  if(function_3298f1ad0b756cbd(itembundle, item.count)) {
    var_c3051697735d1320 = item.var_4f74f0aef2b2a8bf;
    remainder = function_f64964e50cc34c47(itembundlename, itembundle, item);
    stowed_count = item.count - remainder;

    if(remainder) {
      item.count = remainder;
    } else {
      item.count = 0;
      function_c14962ea14e58968(item);
    }

    function_61e26b275dfa50e0(itembundle, stowed_count, var_c3051697735d1320, 0, item);
    return;
  }

  item.var_9c44eb334c225d45 = 1;
  function_86d7576fb0f41e09(item, lootid);
}

function function_86d7576fb0f41e09(item, lootid) {
  if(!isDefined(item.var_9c44eb334c225d45)) {
    assertmsg("<dev string:x4c3>");
    return;
  }

  stubcache = item;
  stubcache.contents = [];
  stubcache.containertype = 14;
  stubcache.contents[0] = spawnStruct();
  stubcache.contents[0].quantity = item.count;
  stubcache.contents[0].lootid = lootid;
  stubcache.var_978407de904a5fd1 = 1;

  if(isDefined(item.var_4f74f0aef2b2a8bf)) {
    stubcache.contents[0].weapondata = spawnStruct();
    stubcache.contents[0].weapondata.rarity = item.var_4f74f0aef2b2a8bf.rarity;
    stubcache.contents[0].weapondata.attachments = item.var_4f74f0aef2b2a8bf.attachments;
  }

  function_7ea0601f1375d4c7(stubcache);
}

function function_7ea0601f1375d4c7(stubcache) {
  if(!isDefined(stubcache.var_9c44eb334c225d45)) {
    assertmsg("<dev string:x4c3>");
    return;
  }

  if(stubcache.var_9c44eb334c225d45 == 0 || istrue(stubcache.fromcache)) {
    assertmsg("<dev string:x578>");
    return;
  }

  itemcount = stubcache.contents[0].quantity;
  itemlootid = stubcache.contents[0].lootid;
  itemweapondata = stubcache.contents[0].weapondata;
  stubcache.var_6a32bedb4200b578 = self.var_2fa5b49969def47;
  stubcache.var_d8667251a92de6f2 = self.var_f2aa9ae949179907;
  self.var_2fa5b49969def47 = stubcache;
  self.var_f2aa9ae949179907 = self.origin;

  if(stubcache.var_9c44eb334c225d45 == 1 && !isstruct(stubcache) && stubcache isscriptableinstance()) {
    foreach(player in level.players) {
      stubcache disablescriptableplayeruse(player);
    }
  }

  scripts\cp_mp\loot\common_cache::function_446c7ad7bcc70992(self, 0, itemlootid, function_b8bfea9514c89a77(itemcount), itemweapondata);

  for(itemindex = 1; itemindex < 10; itemindex++) {
    scripts\cp_mp\loot\common_cache::function_c7294f5b9b5006d5(self, itemindex);
  }

  self setclientomnvar("loot_container_weapon", 0);
  self setclientomnvar("loot_container_open", stubcache.containertype);
  thread function_833716900e3b8d89(stubcache);
  stubcache thread function_ceec15c03350d7d3(self);
}

function function_cc518f9c6e1d9543(stubcache) {
  if(!isDefined(stubcache.var_9c44eb334c225d45)) {
    assertmsg("<dev string:x4c3>");
    return;
  }

  self setclientomnvar("loot_container_open", 0);

  if(stubcache.var_9c44eb334c225d45 == 1 && !isstruct(stubcache) && stubcache isscriptableinstance()) {
    if(scripts\cp_mp\loot\common_cache::iscontainerempty(stubcache)) {
      function_c14962ea14e58968(stubcache);
    } else {
      foreach(player in level.players) {
        stubcache enablescriptableplayeruse(player);
      }
    }
  }

  if(stubcache.var_9c44eb334c225d45 == 2 && isstruct(stubcache) && !scripts\cp_mp\loot\common_cache::iscontainerempty(stubcache)) {
    lootid = stubcache.contents[0].lootid;
    quantity = stubcache.contents[0].quantity;
    function_b9d2aee928c46b5f(lootid, quantity);
    function_eff2aed88a59ccfd(self, 0, 0, 0);
  }

  self.var_2fa5b49969def47 = stubcache.var_6a32bedb4200b578;
  self.var_f2aa9ae949179907 = stubcache.var_d8667251a92de6f2;
  stubcache.var_6a32bedb4200b578 = undefined;
  stubcache.var_d8667251a92de6f2 = undefined;
  stubcache notify("closed");
}

function function_833716900e3b8d89(cache) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  cache endon("death");
  cache endon("closed");

  while(function_d47564d30fb44889(cache)) {
    wait 0.05;
  }

  function_cc518f9c6e1d9543(cache);
}

function function_d47564d30fb44889(cache) {
  if(istrue(self.isdisconnecting)) {
    return false;
  }

  if(self playerads() >= 0.5) {
    return false;
  }

  if(cache.var_9c44eb334c225d45 != 2) {
    if(distancesquared(self.origin, self.var_f2aa9ae949179907) > level.var_de221bfb117f1fd1 * level.var_de221bfb117f1fd1) {
      return false;
    }

    if(!function_7ccc263b372af2bc(cache)) {
      return false;
    }

    if(!scripts\cp_mp\loot\common_cache::function_d6041f45fee8083d()) {
      return false;
    }
  }

  return true;
}

function function_ceec15c03350d7d3(player) {
  level endon("game_ended");
  self endon("death");
  player endon("death");
  player endon("disconnect");
  waittill_any_5("closed", "close_container", "flashbang", "concussed", "weapon_fired");
  player function_cc518f9c6e1d9543(self);
}

function function_2d05d3354917445b(backpackindex, lootid, quantity) {
  newitembundlename = function_fc925a153c7fd55c(lootid);
  var_a8856d1c2cbf78f6 = undefined;

  if(isDefined(newitembundlename)) {
    var_a8856d1c2cbf78f6 = "itemspawnentry:" + newitembundlename;

    if(function_633f07e180b6ec8f(var_a8856d1c2cbf78f6)) {
      return;
    }
  }

  backpacklootid = function_d870b2c45335bd88(backpackindex);
  backpackquantity = function_5ce7fe3dca9c1a22(backpackindex);
  oldbundlename = function_fc925a153c7fd55c(backpacklootid);
  var_c8072c59ba873dc1 = getscriptbundle("itemspawnentry:" + oldbundlename);
  items_dropitem(var_c8072c59ba873dc1, backpackquantity);
  function_ca3bbb1070436540(backpackindex, lootid, quantity);

  if(isDefined(var_a8856d1c2cbf78f6)) {
    newitembundle = getscriptbundlefieldvalues(var_a8856d1c2cbf78f6, [#"pickupsfx"]);
    function_fbfd7096a2dbc7e7(newitembundle, 1);
  }
}

function inventory_isenabled() {
  if(isDefined(level.gametypebundle) && istrue(level.gametypebundle.var_d651598a91f20ae3)) {
    if(istrue(level.gametypebundle.var_a3f121ced843d5e)) {
      return (isDefined(level.gametypebundle.backpackkey) && level.gametypebundle.backpackkey != "");
    }
  }

  return false;
}

function function_9bb27db31cac473d() {
  return level.gametypebundle.backpackkey;
}

function function_2205ef8e9a67e1be() {
  return "backpackSize";
}

function function_5f55af0d9c99908b() {
  return "dmzWeapon";
}

function function_d3405ff387ff4f2e() {
  backpack_size = default_to(level.gametypebundle.backpacksize, 8);
  setdvarifuninitialized(@ "hash_4449685517101675", istrue(level.gametypebundle.var_413ebee422ca9e3c));

  if(istrue(level.gametypebundle.var_413ebee422ca9e3c)) {
    setdvarifuninitialized(@ "hash_5fcbce13ef8d5f", backpack_size);
  }

  setdvarifuninitialized(@ "hash_a384f4621ba11550", backpack_size);
}

function function_286713f0349afb22() {
  return getdvarint(@ "hash_a384f4621ba11550", 8);
}

function function_181a584e4a68d5d6(lootid, quantity) {
  if(!isDefined(quantity)) {
    quantity = 1;
  }

  backpackindex = function_4776284a348ebb6a(lootid);

  if(backpackindex == -1) {
    return false;
  }

  backpackquantity = function_5ce7fe3dca9c1a22(backpackindex);

  if(quantity <= 0) {
    return false;
  }

  backpackquantity -= quantity;

  if(backpackquantity <= 0) {
    function_ca3bbb1070436540(backpackindex, 0, 0);
  } else {
    function_ca3bbb1070436540(backpackindex, lootid, backpackquantity);
  }

  return true;
}

function function_1b35b10884bd8d67() {
  result = self getplayerdata(level.progressiongroup, function_2205ef8e9a67e1be());

  if(!isDefined(result)) {
    result = function_286713f0349afb22();
    assertmsg("<dev string:x626>");
  }

  return result;
}

function function_32c79be2384f10fb(size, itembundle) {
  if(istrue(level.gametypebundle.var_413ebee422ca9e3c)) {
    return;
  }

  if(isDefined(size)) {
    self setplayerdata(level.progressiongroup, function_2205ef8e9a67e1be(), size);
  } else {
    self setplayerdata(level.progressiongroup, function_2205ef8e9a67e1be(), function_286713f0349afb22());
  }

  self setclientomnvar("ui_loot_backpack_type", function_afb28406eb20d361(itembundle));
}

function function_afb28406eb20d361(itembundle) {
  if(!isDefined(itembundle)) {
    return 0;
  }

  itemref = itembundle.ref;

  if(!isDefined(itemref)) {
    return 0;
  }

  switch (itemref) {
    case #"hash_75ca97f27fab119c":
      return 1;
    case #"hash_5cdbaa0bf3e5ebfe":
      return 2;
    default:
      return 0;
  }

  return 0;
}

function function_d870b2c45335bd88(index) {
  return self getplayerdata(level.progressiongroup, function_9bb27db31cac473d(), index, "lootID");
}

function function_5ce7fe3dca9c1a22(index) {
  return self getplayerdata(level.progressiongroup, function_9bb27db31cac473d(), index, "quantity");
}

function function_ca3bbb1070436540(index, lootid, quantity) {
  if(!isint(index) || index < 0 || index >= 256) {
    assertmsg("<dev string:x693>" + (isDefined(index) ? index : "<dev string:x6be>") + "<dev string:x6cb>");
    return;
  }

  if(!isDefined(quantity)) {
    quantity = 0;
  }

  if(!isDefined(lootid) || lootid != 0 && quantity == 0) {
    lootid = 0;
  }

  backpackkey = function_9bb27db31cac473d();
  self setplayerdata(level.progressiongroup, backpackkey, index, "lootID", lootid);
  self setplayerdata(level.progressiongroup, backpackkey, index, "quantity", int(quantity));
}

function function_e2b4c63cab73c1f1() {
  weapon = self getplayerdata(level.progressiongroup, function_5f55af0d9c99908b(), "weapon");

  if(weapon == "none") {
    return undefined;
  }

  variantid = self getplayerdata(level.progressiongroup, function_5f55af0d9c99908b(), "variantID");
  attachments = [];
  attachmentids = [];

  for(attachmentindex = 0; attachmentindex < 7; attachmentindex++) {
    attachments[attachmentindex] = self getplayerdata(level.progressiongroup, function_5f55af0d9c99908b(), "attachmentSetup", attachmentindex, "attachment");
    attachmentids[attachmentindex] = self getplayerdata(level.progressiongroup, function_5f55af0d9c99908b(), "attachmentSetup", attachmentindex, "variantID");
  }

  return scripts\cp_mp\weapon::buildweapon(weapon, attachments, undefined, undefined, variantid, attachmentids);
}

function function_ad55c4cd0426138d(weapon) {
  rootname = scripts\cp_mp\weapon::getweaponrootname(weapon);
  variantid = weapon.variantid;

  if(!isDefined(weapon.variantid)) {
    variantid = 0;
  }

  ref = rootname;

  if(variantid) {
    ref = rootname + "_v" + variantid;
  }

  lootid = function_2c836ad05e5f634c(ref);
  self setplayerdata(level.progressiongroup, function_5f55af0d9c99908b(), "weapon", rootname);
  self setplayerdata(level.progressiongroup, function_5f55af0d9c99908b(), "variantID", variantid);
  self setplayerdata(level.progressiongroup, function_5f55af0d9c99908b(), "lootItemID", lootid);
  self.var_8a265f7b950a8d5d = self getweaponammoclip(weapon) + self getweaponammostock(weapon);

  if(weapon.hasalternate) {
    weaponalt = weapon getaltweapon();
    self.var_86b32aff94b5714e = self getweaponammoclip(weaponalt);
  }

  attachments = getweaponattachments(weapon);
  defaulttoidmap = scripts\cp_mp\weapon::getbaseweaponattachdefaulttoidmap(rootname);
  var_428a6c7cd65625c0 = 0;

  for(attachmentindex = 0; attachmentindex < attachments.size && var_428a6c7cd65625c0 < 7; attachmentindex++) {
    if(!isDefined(defaulttoidmap[attachments[attachmentindex]])) {
      self setplayerdata(level.progressiongroup, function_5f55af0d9c99908b(), "attachmentSetup", var_428a6c7cd65625c0, "attachment", attachments[attachmentindex]);
      self setplayerdata(level.progressiongroup, function_5f55af0d9c99908b(), "attachmentSetup", var_428a6c7cd65625c0, "variantID", 0);
      var_428a6c7cd65625c0++;
    }
  }
}

function function_ced2abb96f1d86a5() {
  return self getplayerdata(level.progressiongroup, function_5f55af0d9c99908b(), "weapon") != "none";
}

function function_69df855efa3b5b9e() {
  return self getplayerdata(level.progressiongroup, function_5f55af0d9c99908b(), "lootItemID");
}

function function_bd059d6c2e0ece90() {
  self setplayerdata(level.progressiongroup, function_5f55af0d9c99908b(), "weapon", "none");
  self setplayerdata(level.progressiongroup, function_5f55af0d9c99908b(), "lootItemID", 0);
  self setplayerdata(level.progressiongroup, function_5f55af0d9c99908b(), "camo", "none");
  self setplayerdata(level.progressiongroup, function_5f55af0d9c99908b(), "reticle", "none");
  self setplayerdata(level.progressiongroup, function_5f55af0d9c99908b(), "cosmeticAttachment", "none");
  self setplayerdata(level.progressiongroup, function_5f55af0d9c99908b(), "variantID", 0);
  self setplayerdata(level.progressiongroup, function_5f55af0d9c99908b(), "blueprintName", "");

  for(attachindex = 0; attachindex < 5; attachindex++) {
    self setplayerdata(level.progressiongroup, function_5f55af0d9c99908b(), "attachmentSetup", attachindex, "attachment", "none");
    self setplayerdata(level.progressiongroup, function_5f55af0d9c99908b(), "attachmentSetup", attachindex, "variantID", 0);
  }

  for(var_36d2abbdcbcb186c = 0; var_36d2abbdcbcb186c < 4; var_36d2abbdcbcb186c++) {
    self setplayerdata(level.progressiongroup, function_5f55af0d9c99908b(), "sticker", var_36d2abbdcbcb186c, "none");
  }
}

function function_389d4cd85d174957() {
  backpacksize = function_1b35b10884bd8d67();

  for(i = 0; i < backpacksize; i++) {
    function_ca3bbb1070436540(i, 0, 0);
  }

  function_bd059d6c2e0ece90();
}

function function_e70feddd94ade74f() {
  primaryweaponlootid = function_2c836ad05e5f634c("iw9_pi_golf17");
  function_9ac814eecef8b3af(0, 0, "iw9_pi_golf17", primaryweaponlootid);
  function_9ac814eecef8b3af(0, 1);
  function_cf99f67e363f5d6c(0, 0, "none");
  function_cf99f67e363f5d6c(0, 1, "none");
  function_b10833eee9e6a55f(0, 0, "none");
}

function function_9ac814eecef8b3af(classindex, weaponindex, clearweapon, clearweaponid) {
  if(isDefined(clearweapon) && isDefined(clearweaponid)) {
    self setplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "weapon", clearweapon);
    self setplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "lootItemID", clearweaponid);
  } else {
    self setplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "weapon", "iw9_me_fists");
    self setplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "lootItemID", 0);
  }

  self setplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "camo", "none");
  self setplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "reticle", "none");
  self setplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "cosmeticAttachment", "none");
  self setplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "variantID", 0);
  self setplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "blueprintName", "");

  for(attachindex = 0; attachindex < 5; attachindex++) {
    self setplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "attachmentSetup", attachindex, "attachment", "none");
    self setplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "attachmentSetup", attachindex, "variantID", 0);
  }

  for(var_36d2abbdcbcb186c = 0; var_36d2abbdcbcb186c < 4; var_36d2abbdcbcb186c++) {
    self setplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "sticker", var_36d2abbdcbcb186c, "none");
  }
}

function function_cf99f67e363f5d6c(classindex, equipindex, ref) {
  self setplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "equipmentSetups", equipindex, "equipment", ref);
}

function function_b10833eee9e6a55f(classindex, superindex, ref) {
  self setplayerdata(level.loadoutdata, "squadMembers", "loadouts", classindex, "fieldUpgrades", superindex, ref);
}

function function_9000524cb245fdbe(index, ref) {
  self setplayerdata(level.loadoutdata, "squadMembers", "killstreakSetups", index, "killstreak", ref);
}

function function_4df538728f6d3815(weaponslotindex) {
  if(namespace_9571f642f38c8169::function_a6172e49f7313fd8()) {
    return namespace_9571f642f38c8169::function_7cce337c4902cbb6(weaponslotindex);
  }

  return undefined;
}

function function_852cd6dd29c274bd(currentweapon) {
  if(!isweapon(currentweapon) || isnullweapon(currentweapon)) {
    return false;
  }

  assertex(isPlayer(self), "<dev string:x6e9>");
  var_bbec008369304198 = [0, 1, 2];

  foreach(var_fb4895ca57fbf227 in var_bbec008369304198) {
    w_slot = namespace_736197e4d378b91b::function_2aeaf88105d3b617(var_fb4895ca57fbf227);

    if(isDefined(currentweapon) && isDefined(w_slot) && currentweapon == w_slot) {
      var_f0ee9ada549b5763 = function_4df538728f6d3815(var_fb4895ca57fbf227);

      if(isDefined(var_f0ee9ada549b5763)) {
        return true;
      }
    }
  }

  return false;
}