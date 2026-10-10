/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5640d32580c6bc7d.gsc
*************************************************/

#using script_1de396bd08617dd4;
#using script_3282f33bea60a32;
#using script_443d99fe707f1d9f;
#using script_6f74c67411fcab41;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\loot\common_cache;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\weapon;
#using scripts\mp\equipment;
#using scripts\mp\hud_message;
#namespace namespace_e40ee8b394ce404;

function function_cf1b1f86951a9209(instance, part, state, player, var_a5b2c541413aa895, usestring) {
  if(!istrue(instance.var_532eac3c428e5b9b)) {
    return;
  }

  player.var_605f6834e7492317 = 1;
  function_9cd7df4997aea4bf(player, instance);
  instance.playeropen[player.guid] = player;

  if(isDefined(instance.usedcallback)) {
    [[instance.usedcallback]](instance, part, state, player, var_a5b2c541413aa895, usestring);
  }

  function_8f75065bda6ee24a(player, instance);
}

function function_8f75065bda6ee24a(opener, container) {
  [items, lastvalidindex] = function_438749eb7a7b738(container.contents, opener, container);
  container.contents = items;
  opener.var_2fa5b49969def47 = container;
  opener.var_f2aa9ae949179907 = opener.origin;
  containersize = function_54d1e54b22f3f1f6(container.containertype);

  if(isDefined(container.linkedparent)) {
    opener.var_f2aa9ae949179907 = opener.origin - container.linkedparent.origin;
  }

  if(items.size > containersize) {
    println("<dev string:x1c>" + items.size + "<dev string:x53>" + containersize + "<dev string:x6f>");
  }

  for(itemindex = 0; itemindex < containersize; itemindex++) {
    if(itemindex <= lastvalidindex) {
      common_cache::function_446c7ad7bcc70992(opener, itemindex, items[itemindex].lootid, items[itemindex].quantity, items[itemindex].weapondata);
      continue;
    }

    common_cache::function_c7294f5b9b5006d5(opener, itemindex);
  }

  if(!istrue(container.noweaponslot) && isDefined(container.contents.weaponslotcontents)) {
    opener setclientomnvar("loot_container_weapon", container.contents.weaponslotcontents);
  }

  opener setclientomnvar("loot_container_open", container.containertype);
  container thread common_cache::function_71a59f067d5fe986(opener);
  container thread common_cache::function_47b931d76ffd028f(opener);
  opener calloutmarkerping::function_faa3cbec7243fe72();
}

function function_6207d6f728cee51d(players, container, lootid, quantity, weaponobj, noextract, force) {
  foreach(player in players) {
    function_4df3c8d739c4b460(player, container, lootid, quantity, weaponobj, noextract, force);
  }
}

function function_9cd7df4997aea4bf(player, container) {
  if(!isDefined(container.contents)) {
    container.contents = [];
  }

  if(!isDefined(container.contents[0])) {
    container.contents[0] = spawnStruct();
    container.contents[0].quantity = 0;
    container.contents[0].lootid = 0;

    if(!istrue(container.noweaponslot)) {
      container.contents.weaponslotcontents = 0;
      container.contents.weaponslotobj = undefined;
    }
  }

  if(!isDefined(container.containertype)) {
    container.containertype = function_b2ff0af91e5df8f4(container.type);
  }
}

function function_4df3c8d739c4b460(player, container, lootid, quantity, weaponobj, noextract, force) {
  function_9cd7df4997aea4bf(player, container);
  [items, lastvalidindex] = function_438749eb7a7b738(container.contents, player, container);
  container.contents = items;
  containersize = function_54d1e54b22f3f1f6(container.containertype);

  for(i = lastvalidindex + 1; i < containersize; i++) {
    container.contents[i] = undefined;
  }

  if(lootid == 0 || quantity == 0) {
    return;
  }

  if(isDefined(weaponobj) && !istrue(container.noweaponslot)) {
    return;
  }

  containerindex = container.contents.size;
  canstack = undefined;

  foreach(index, item in container.contents) {
    if(!isDefined(item) || !isDefined(item.quantity) || !isDefined(item.lootid)) {
      continue;
    }

    if(item.lootid == 8395 && lootid == item.lootid) {
      containerindex = index;
      quantity += item.quantity;
      canstack = 1;
      break;
    }

    bundlename = common_item::function_fc925a153c7fd55c(lootid);
    itembundle = getscriptbundle("itemspawnentry:" + bundlename);
    scriptablename = itembundle.scriptable;
    maxcount = itembundle.maxcount;

    if(!isDefined(maxcount) || maxcount == 0) {
      continue;
    }

    if(item.lootid == lootid && quantity + item.quantity <= maxcount) {
      containerindex = index;
      quantity += item.quantity;
      canstack = 1;
      break;
    }
  }

  if(containerindex >= containersize && !isDefined(weaponobj) && !istrue(canstack)) {
    if(istrue(force)) {
      containerlootid = container.contents[0].lootid;
      bundlename = common_item::function_fc925a153c7fd55c(containerlootid);
      itembundle = getscriptbundle("itemspawnentry:" + bundlename);
      common_item::function_c465d27f3f6066b4(itembundle, container.origin, container.angles);
    } else {
      player hud_message::showerrormessage("MP/BALLOON_EXTRACT_DENY_NO_ROOM");
      return;
    }
  }

  if(isDefined(container.var_6978a4b328fd33b3)) {
    [lootid, var_83d63b00fa6616e7] = [[container.var_6978a4b328fd33b3]](container, player, lootid, quantity);

    if(isDefined(var_83d63b00fa6616e7)) {
      noextract = var_83d63b00fa6616e7;
    }
  }

  if(!isDefined(container.contents[containerindex])) {
    common_cache::function_6eee0ede493b44e8(container, quantity, lootid);
  } else {
    container.contents[containerindex].quantity = quantity;
    container.contents[containerindex].lootid = lootid;
  }

  if(isDefined(noextract)) {
    container.contents[containerindex].noextract = 1;
  } else {
    container.contents[containerindex].noextract = undefined;
  }

  player function_ce9b69fc041571d2(player, container);
}

function function_7de9a54614a594c3(container, index, removeall) {
  quantity = 1;

  if(!isDefined(removeall)) {
    removeall = 0;
  }

  lootid = container.contents[index].lootid;

  if(removeall) {
    quantity = container.contents[index].quantity;
  }

  if(container.contents[index].quantity - quantity == 0) {
    container.contents[index].lootid = 0;
  }

  container.contents[index].quantity -= quantity;
  function_ce9b69fc041571d2(self, container);
}

function function_80bada2833945a7a(itemtype, itemindex, noextract, dropall) {
  if(!isDefined(dropall)) {
    dropall = 0;
  }

  [items, lastvalidindex] = function_438749eb7a7b738(self.var_2fa5b49969def47.contents, self, self.var_2fa5b49969def47);
  self.var_2fa5b49969def47.contents = items;
  containersize = function_54d1e54b22f3f1f6(self.var_2fa5b49969def47.containertype);

  for(i = lastvalidindex + 1; i < containersize; i++) {
    self.var_2fa5b49969def47.contents[i] = undefined;
  }

  container = self.var_2fa5b49969def47;

  if(istrue(self getclientomnvar("loot_container_weapon")) && itemtype == 1) {
    hud_message::showerrormessage("MP/BALLOON_EXTRACT_DENY_NO_ROOM");
    return;
  }

  [lootid, quantity, weaponobj] = function_4b1ea8143efb9dd(itemtype, itemindex, dropall);

  if(!isDefined(lootid)) {
    return;
  }

  if(lootid == 0 || quantity == 0 && !isDefined(weaponobj)) {
    return;
  }

  containerindex = container.contents.size;
  canstack = undefined;
  droppedquantity = quantity;

  foreach(index, item in container.contents) {
    if(!isDefined(item) || !isDefined(item.quantity) || !isDefined(item.lootid)) {
      continue;
    }

    bundlename = common_item::function_fc925a153c7fd55c(lootid);
    itembundle = getscriptbundle("itemspawnentry:" + bundlename);
    scriptablename = itembundle.scriptable;
    totalquantity = quantity + item.quantity;

    if(itembundle.type == "currency" && lootid == item.lootid && totalquantity < 2048) {
      containerindex = index;
      quantity = totalquantity;
      canstack = 1;
      break;
    }

    maxcount = itembundle.maxcount;

    if(!isDefined(maxcount) || maxcount == 0) {
      continue;
    }

    if(item.lootid == lootid && totalquantity <= maxcount) {
      containerindex = index;
      quantity = totalquantity;
      canstack = 1;
      break;
    }
  }

  if(containerindex >= containersize && itemtype != 1 && !istrue(canstack)) {
    hud_message::showerrormessage("MP/BALLOON_EXTRACT_DENY_NO_ROOM");
    return;
  }

  if(isDefined(self.var_2fa5b49969def47.var_6978a4b328fd33b3)) {
    [lootid, var_83d63b00fa6616e7] = [[self.var_2fa5b49969def47.var_6978a4b328fd33b3]](self.var_2fa5b49969def47, self, lootid, quantity, itemtype, itemindex);

    if(isDefined(var_83d63b00fa6616e7)) {
      noextract = var_83d63b00fa6616e7;
    }
  }

  if(!isDefined(self.var_2fa5b49969def47.contents[containerindex])) {
    common_cache::function_6eee0ede493b44e8(self.var_2fa5b49969def47, quantity, lootid);
  } else {
    self.var_2fa5b49969def47.contents[containerindex].quantity = quantity;
    self.var_2fa5b49969def47.contents[containerindex].lootid = lootid;
  }

  if(isDefined(noextract)) {
    self.var_2fa5b49969def47.contents[containerindex].noextract = 1;
  } else {
    self.var_2fa5b49969def47.contents[containerindex].noextract = undefined;
  }

  function_ce9b69fc041571d2(self, self.var_2fa5b49969def47);
}

function function_daa9df3be019b879(lootid) {
  bundlename = common_item::function_fc925a153c7fd55c(lootid);
  itembundle = getscriptbundle("itemspawnentry:" + bundlename);
  return isDefined(lootid) && itembundle.type == "currency";
}

function function_ce9b69fc041571d2(opener, container) {
  [items, lastvalidindex] = function_438749eb7a7b738(container.contents, opener, container);
  container.contents = items;
  containersize = function_54d1e54b22f3f1f6(container.containertype);

  if(items.size > containersize) {
    println("<dev string:x1c>" + items.size + "<dev string:x53>" + containersize + "<dev string:x6f>");
  }

  for(itemindex = 0; itemindex < containersize; itemindex++) {
    common_cache::function_c7294f5b9b5006d5(opener, itemindex);
  }

  for(itemindex = 0; itemindex < containersize; itemindex++) {
    if(itemindex <= lastvalidindex) {
      common_cache::function_446c7ad7bcc70992(opener, itemindex, items[itemindex].lootid, items[itemindex].quantity, items[itemindex].weapondata);
    }
  }
}

function function_438749eb7a7b738(items, opener, container) {
  assert(isDefined(items));
  validitems = [];
  firstindex = 0;
  lastindex = items.size - 1;

  foreach(item in items) {
    quantity = item.quantity;
    lootid = item.lootid;
    team = item.team;
    visibilitycondition = item.visibilitycondition;

    if(isDefined(quantity) && quantity > 0 && isDefined(lootid) && lootid > 0 && (!isDefined(team) || team == opener.team) && (!isDefined(visibilitycondition) || [[visibilitycondition]](opener, container))) {
      validitems[firstindex] = item;
      firstindex++;
      continue;
    }

    validitems[lastindex] = item;
    lastindex--;
  }

  return [validitems, lastindex];
}

function function_b2ff0af91e5df8f4(scriptablename) {
  containertype = 1;

  switch (scriptablename) {
    case #"hash_8387e0bfe22abc5d":
      containertype = 15;
      break;
    case #"hash_884fc5db10bac9b3":
      containertype = 13;
      break;
    case #"hash_c4e1cdfcbfebe45e":
      containertype = 18;
      break;
    case #"hash_7a9b70fe784edb0b":
      containertype = 17;
      break;
    case #"hash_cc9e0ca88d6cbd9b":
      containertype = 19;
      break;
    case #"hash_70401edca74af4ba":
      containertype = 19;
      break;
    case #"hash_c3bde42c4152cd33":
      containertype = 19;
      break;
    case #"hash_415e65d890f08790":
      containertype = 19;
      break;
    default:
      break;
  }

  return containertype;
}

function function_54d1e54b22f3f1f6(containertype) {
  switch (containertype) {
    case 15:
      return (getdvarint(@ "hash_823c57ec4dac4069", 4) - getdvarint(@ "hash_1d7f857b2cd9dba2", 0));
    case 13:
      return (getdvarint(@ "hash_780b498909ad7b76", 4) - getdvarint(@ "hash_6ee9465e13d271e5", 0));
    case 18:
      return (getdvarint(@ "hash_ca5506ebef1c08c6", 4) - getdvarint(@ "hash_e5044e04d13e3266", 0));
    case 17:
      return (getdvarint(@ "hash_16335f8c9a65d30f", 4) - getdvarint(@ "hash_f09fed6023f0158b", 0));
    case 19:
      return (getdvarint(@ "hash_60725a15df4c8b17", 4) - getdvarint(@ "hash_ab124095978e89eb", 0));
    default:
      return 10;
  }
}

function function_4b1ea8143efb9dd(itemtype, itemindex, dropall) {
  switch (itemtype) {
    case 0:
      return [0, 0];
    case 1:
      if(itemindex == 2) {
        if(!function_ced2abb96f1d86a5()) {
          return [0, 0, undefined];
        }

        lootid = function_69df855efa3b5b9e();
        var_ec22a950f210e39 = function_e2b4c63cab73c1f1();
        return [lootid, self getweaponammoclip(var_ec22a950f210e39), var_ec22a950f210e39];
      }

      var_ec22a950f210e39 = function_61f99d560d896d24(itemindex);

      if(!isDefined(var_ec22a950f210e39)) {
        return [0, 0, undefined];
      }

      rootname = scripts\cp_mp\weapon::getweaponrootname(var_ec22a950f210e39);
      variantid = var_ec22a950f210e39.variantid;

      if(!isDefined(var_ec22a950f210e39.variantid)) {
        variantid = 0;
      }

      lootid = scripts\cp_mp\weapon::function_79d6e6c22245687a(rootname, variantid);
      return [lootid, self getweaponammoclip(var_ec22a950f210e39), var_ec22a950f210e39];
    case 10:
      lootid = function_d870b2c45335bd88(itemindex);

      if(!isDefined(lootid)) {
        return [0, 0];
      }

      bundlename = function_fc925a153c7fd55c(lootid);

      if(!isDefined(bundlename)) {
        assertmsg("<dev string:x74>" + lootid + "<dev string:xb0>");
        return [0, 0];
      }

      itembundle = getscriptbundle("itemspawnentry:" + bundlename);

      if(!isDefined(itembundle)) {
        assertmsg("<dev string:xb6>" + bundlename + "<dev string:xb0>");
        return [0, 0];
      }

      scriptablename = itembundle.scriptable;
      quantity = 1;

      if(istrue(dropall) || isDefined(scriptablename) && isgasmask(scriptablename)) {
        quantity = common_inventory::function_5ce7fe3dca9c1a22(itemindex);
      } else {
        quantity = 1;
      }

      return [lootid, quantity];
    case 6:
      callbacks = common_item::function_cca8bbe88a39ad41("gasmask");
      [itembundle, quantity] = self[[callbacks.var_df9b308efe82294a]]();
      lootid = common_item::function_6d15e119c2779a93(itembundle);
      return [lootid, quantity];
    case 7:
      callbacks = common_item::function_cca8bbe88a39ad41("revive");
      [itembundle, quantity] = self[[callbacks.var_df9b308efe82294a]]();
      lootid = common_item::function_6d15e119c2779a93(itembundle);
      return [lootid, quantity];
    case 2:
      slot = equipment::function_4967838290cb31b9(itemindex);
      item_type = "lethal";

      if(slot == "secondary") {
        item_type = "tactical";
      }

      if(slot == "health") {
        item_type = "armor";
      }

      callbacks = common_item::function_cca8bbe88a39ad41(item_type);
      [itembundle, currentquantity] = self[[callbacks.var_df9b308efe82294a]]();
      lootid = common_item::function_6d15e119c2779a93(itembundle);
      quantity = 0;

      if(currentquantity >= 1) {
        quantity = 1;
      }

      if(istrue(dropall)) {
        quantity = currentquantity;
      }

      return [lootid, quantity];
    case 3:
      [itembundle, quantity] = namespace_de169b8ad93c38b5::function_d6029511a9d0984();
      lootid = common_item::function_6d15e119c2779a93(itembundle);
      return [lootid, quantity];
    case 4:
      item_type = "super";
      callbacks = common_item::function_cca8bbe88a39ad41(item_type);
      [itembundle, quantity] = self[[callbacks.var_df9b308efe82294a]]();
      lootid = common_item::function_6d15e119c2779a93(itembundle);

      if(!isDefined(lootid)) {
        return [undefined, undefined, undefined];
      }

      return [lootid, quantity];
    default:
      assertmsg("<dev string:xfb>" + itemtype);
      return;
  }
}

function isgasmask(scriptablename) {
  return false;
}

function function_5711a00587f71794(player) {
  var_a5dd524a90e1907c = player common_cache::function_d6041f45fee8083d();

  if(!var_a5dd524a90e1907c) {
    return 0;
  }

  if(!isDefined(player.var_2fa5b49969def47)) {
    return 0;
  }

  if(!isDefined(player.var_2fa5b49969def47.containertype)) {
    return 0;
  }

  containertype = player.var_2fa5b49969def47.containertype;

  switch (containertype) {
    case 13:
    case 15:
    case 17:
    case 18:
    case 19:
      return 1;
    default:
      return 0;
  }
}

function function_c44440af852c483(player) {
  var_a5dd524a90e1907c = player common_cache::function_d6041f45fee8083d();

  if(!var_a5dd524a90e1907c) {
    return 0;
  }

  if(!isDefined(player.var_2fa5b49969def47)) {
    return 0;
  }

  if(!isDefined(player.var_2fa5b49969def47.containertype)) {
    return 0;
  }

  containertype = player.var_2fa5b49969def47.containertype;

  switch (containertype) {
    case 17:
    case 18:
    case 19:
      return 0;
    default:
      return 1;
  }
}

function function_1225f23a18664f4c(player) {
  var_a5dd524a90e1907c = player common_cache::function_d6041f45fee8083d();

  if(!var_a5dd524a90e1907c) {
    return 0;
  }

  if(!isDefined(player.var_2fa5b49969def47)) {
    return 0;
  }

  if(!isDefined(player.var_2fa5b49969def47.containertype)) {
    return 0;
  }

  containertype = player.var_2fa5b49969def47.containertype;

  switch (containertype) {
    case 15:
      return getdvarint(@ "hash_6ee9465e13d271e5", 0);
    case 13:
      return getdvarint(@ "hash_1d7f857b2cd9dba2", 0);
    default:
      return 0;
  }
}

function function_564c579ae581a82d(contents) {
  var_1c1dd30a3c77139c = [];

  foreach(key, item in contents) {
    var_1c1dd30a3c77139c[key] = spawnStruct();
    var_1c1dd30a3c77139c[key].lootid = item.lootid;
    var_1c1dd30a3c77139c[key].quantity = item.quantity;
    var_1c1dd30a3c77139c[key].index = item.index;

    if(isDefined(item.noextract)) {
      var_1c1dd30a3c77139c[key].noextract = item.noextract;
    }
  }

  return var_1c1dd30a3c77139c;
}