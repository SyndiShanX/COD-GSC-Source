/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\loot\common_item.gsc
*************************************************/

#using script_12a101fb4d4cb63e;
#using script_14183f3fced4ee2b;
#using script_14e5d6cbb6a32c41;
#using script_1de396bd08617dd4;
#using script_3282f33bea60a32;
#using script_3af0e35fc47898ae;
#using script_3cb11ad6dcd981;
#using script_443d99fe707f1d9f;
#using script_5032ed8da1128621;
#using script_53758641d3c1870c;
#using script_54be039c89fddc12;
#using script_64457324b9cce77;
#using script_670b6177abb05234;
#using script_6a11212698833ae9;
#using script_6f74c67411fcab41;
#using script_cbdac3b4a48bb8f;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\loot\common_cache;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\loot\common_kiosk;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace common_item;

function items_init() {
  utility::registersharedfunc("game", "isCommonItemEnabled", &items_isenabled);

  if(!items_isenabled()) {
    return;
  }

  level.commonitem = spawnStruct();
  level.commonitem.itemcallbacks = [];
  level.commonitem.var_882afeeb7cb0dbeb = getdvarint(@ "common_item_runtime_scriptable_limit", 500);
  scriptable_group::function_200bd098377a8674("common_items", level.commonitem.var_882afeeb7cb0dbeb, 10);
  function_a621885d4088d15f();
  level utility::flag_init("common_items_init");
  loot::init();
  thread namespace_94efe9b48c602c39::function_628ac163573e544e();
  thread namespace_41242478a801e045::function_f2c483126e453846();
  thread namespace_f9e8a327d793c098::function_b60c68caa2f279ab();
  thread namespace_f808ba0ae0debcf5::function_1a53aa54f5e85b78();
  thread namespace_7a0486ab8e12b1a::function_265288d8625410c7();
  thread namespace_fe6cb1145ab372e6::function_618664c61d5fc27b();
  thread namespace_de169b8ad93c38b5::function_e1a78f7ca6c76a52();
  thread namespace_736197e4d378b91b::function_cbd6a7a14d9bb07b();
  thread namespace_ab72fb42cd326323::function_4113bac1fcc24f04();
  thread namespace_77804604a7f8a031::function_e365b9e0c732498c();
  thread namespace_2bf4cd4dfd211422::function_2c48f8f076e75751();
  thread namespace_fcd9a54e8b7f9724::function_ef5eba565dd3356d();
  thread namespace_6236231ba2ba2d74::function_db1254dca5eaf211();
  thread namespace_6a37cb2f602c62bc::function_fc61ac927e47d181();
  thread common_cache::init_cache();
  thread common_kiosk::init_kiosk();
  thread namespace_426352158e3bb03b::function_2f94630a18a17ba2();
  items_database_init();
  common_inventory::inventory_init();
  scriptable::scriptable_addusedcallback(&function_ccb2889218715cb1);
  scriptable::scriptable_addautousecallback(&function_ccb2889218715cb1);
  utility::registersharedfunc("game", "spawnPickupFromList", &function_cd45408bd44fab07);
  utility::registersharedfunc("game", "getScriptableFromLootID", &function_2f759e70c6189ff0);
  utility::registersharedfunc("game", "getBundleNameFromLootID", &function_fc925a153c7fd55c);
  utility::registersharedfunc("game", "getBundleNameFromScriptable", &function_2cdc55ba39d97d70);
  utility::registersharedfunc("game", "obtainItemEquip", &function_de489fa2ffdb7f2d);
  utility::registersharedfunc("game", "getItemBundleNameFromRef", &function_61d960957fcf3ca0);
  utility::registersharedfunc("game", "spawnNewItemFromScriptable", &function_119bf86e1d774c3);
  utility::registersharedfunc("game", "showStockLootFeed", &function_61b68d989b016af3);
  utility::registersharedfunc("game", "getLootIDFromRef", &function_2c836ad05e5f634c);
  level utility::flag_set("common_items_init");
  level.var_3e5d2a63c1d15191 = getdvarfloat(@ "hash_3d0c37a1b0da97b3", 0.8);
  level.var_1dfefe3988a59ae5 = getdvarint(@ "hash_d7613094ea4ba91f", 0);
  level.var_cb89daf3a1d3e761 = getdvarint(@ "scr_item_should_check_area", 1);
  level.var_a0b1f76228d242e1 = getdvarint(@ "hash_1761d693d5c4ded5", 5);
  level.var_b08a4f5480f5801d = getdvarfloat(@ "hash_e2cadd2e657c0c27", 0.5);
  level.var_3a94e816b6c1f549 = getdvarfloat(@ "hash_f877f79616e047c7", 0.85);
  level.var_77551c1821d16927 = getdvarfloat(@ "hash_290c05a9320b623d", 50);
  level.var_f4a8313dc2ced539 = getdvarint(@ "hash_3ca29b429f678228", 1);
  level.var_bb7795c61887fc81 = getdvarfloat(@ "hash_b91d6bc7e0694ac", 2000);
  level.commonitem.var_f6db2dc3ab7b9a12 = getdvarint(@ "hash_c867bb7a1159d0a0", 0);
  level.commonitem.var_199caf9c010ecca9 = getdvarint(@ "sv_serverobject_partitioning_enabled", 1);

  level thread function_b270e989412a5f67();
}

function items_isenabled() {
  if(!isDefined(level.gametypebundle)) {
    assertmsg("<dev string:x1c>");
    return false;
  }

  return istrue(level.gametypebundle.var_d651598a91f20ae3);
}

function function_900f562c61c6a5d6(itemtype, usefunc, var_381daafc5fc31b7f, canusefunc, var_df9b308efe82294a, var_bd286dd0c1f53098, dropitemfunc) {
  if(isDefined(level.commonitem.itemcallbacks[itemtype])) {
    assertmsg("<dev string:x71>" + itemtype);
    return;
  }

  assert(isDefined(usefunc));
  callbacks = spawnStruct();
  callbacks.usefunc = usefunc;
  callbacks.var_381daafc5fc31b7f = var_381daafc5fc31b7f;
  callbacks.canusefunc = canusefunc;
  callbacks.var_df9b308efe82294a = var_df9b308efe82294a;
  callbacks.var_bd286dd0c1f53098 = var_bd286dd0c1f53098;
  callbacks.dropitemfunc = dropitemfunc;
  callbacks.funcs = [];
  level.commonitem.itemcallbacks[itemtype] = callbacks;
}

function function_5958815b72ad58a0(itemtype, var_aa1252cceaef87a8, overridefunc) {
  if(!isDefined(level.commonitem.itemcallbacks)) {
    level.commonitem.itemcallbacks = [];
  }

  if(!isDefined(level.commonitem.itemcallbacks[itemtype])) {
    level.commonitem.itemcallbacks[itemtype] = < error pop > ;
  }

  if(!isDefined(level.commonitem.itemcallbacks[itemtype].funcs)) {
    level.commonitem.itemcallbacks[itemtype].funcs = [];
  }

  level.commonitem.itemcallbacks[itemtype].funcs[var_aa1252cceaef87a8] = overridefunc;
}

function function_4651d0094e0bd59d(itemtype, var_aa1252cceaef87a8) {
  if(isDefined(level.commonitem.itemcallbacks) && isDefined(level.commonitem.itemcallbacks[itemtype])) {
    return level.commonitem.itemcallbacks[itemtype].funcs[var_aa1252cceaef87a8];
  }

  return undefined;
}

function function_576728d3d4486bd6(item, autouse, var_7819673a9bd72341, var_95484d8d503de3b8) {
  scriptablename = item.type;

  if(function_f0c15201c9f7e1db(scriptablename)) {
    itembundlename = function_2cdc55ba39d97d70(scriptablename);
    var_9ec3e3e77fa5f56c = "itemspawnentry:" + itembundlename;

    if(function_633f07e180b6ec8f(var_9ec3e3e77fa5f56c)) {
      return false;
    }

    itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
    lootid = function_6d15e119c2779a93(itembundle);
    callbacks = function_cca8bbe88a39ad41(itembundle.type);
    itemcount = item.count;

    if(!isDefined(callbacks)) {
      assertmsg("<dev string:xb2>" + itembundle.type + "<dev string:xee>");
      return false;
    }

    canuse = 1;

    if(autouse) {
      if(isDefined(callbacks.var_381daafc5fc31b7f)) {
        canuse = self[[callbacks.var_381daafc5fc31b7f]](itembundle, item, autouse, 0);
      }
    } else if(isDefined(callbacks.canusefunc)) {
      canuse = self[[callbacks.canusefunc]](itembundle, item, autouse, 0);
    }

    if(common_inventory::inventory_isenabled()) {
      if(canuse) {
        var_84ab4c28dc11052d = function_de489fa2ffdb7f2d(item, autouse, 1);

        if(istrue(var_84ab4c28dc11052d)) {
          if(!istrue(var_95484d8d503de3b8)) {
            function_fbfd7096a2dbc7e7(itembundle, 1);
          }

          return true;
        }
      } else if(autouse && !istrue(itembundle.var_bbae53787b1abf3e)) {
        return false;
      }

      if(!function_b343caad692916aa(itembundle)) {
        if(!autouse && !istrue(var_95484d8d503de3b8)) {
          function_fbfd7096a2dbc7e7(itembundle, 0);
        }

        return false;
      }

      if(!autouse && common_inventory::function_4f73be3d1273e86b() && !common_inventory::function_3298f1ad0b756cbd(itembundle, function_b8bfea9514c89a77(item.count))) {
        if(!istrue(var_7819673a9bd72341)) {
          common_inventory::function_354e083223035de2(item, lootid);
        } else if(!istrue(var_95484d8d503de3b8)) {
          function_fbfd7096a2dbc7e7(itembundle, 0);
        }

        return false;
      }

      var_c3051697735d1320 = item.var_4f74f0aef2b2a8bf;
      remainder = common_inventory::function_f64964e50cc34c47(itembundlename, itembundle, item, autouse);
      quantitystowed = item.count - remainder;

      if(remainder) {
        item.count = remainder;
        itemcount = remainder;
      } else {
        item.count = 0;
        itemcount = 0;
        function_c14962ea14e58968(item);
      }

      if(quantitystowed > 0) {
        function_61e26b275dfa50e0(itembundle, quantitystowed, var_c3051697735d1320, 1, item, var_95484d8d503de3b8);
        return true;
      }

      if(!autouse && !istrue(var_95484d8d503de3b8)) {
        function_fbfd7096a2dbc7e7(itembundle, 0);
      }

      return false;
    } else {
      if(canuse) {
        var_84ab4c28dc11052d = function_de489fa2ffdb7f2d(item, autouse);

        if(istrue(var_84ab4c28dc11052d)) {
          return true;
        }
      }

      return false;
    }
  }

  return false;
}

function function_de489fa2ffdb7f2d(item, autouse, var_95484d8d503de3b8) {
  scriptablename = item.type;

  if(function_f0c15201c9f7e1db(scriptablename)) {
    newitembundlename = function_2cdc55ba39d97d70(scriptablename);
    var_a8856d1c2cbf78f6 = "itemspawnentry:" + newitembundlename;

    if(function_633f07e180b6ec8f(var_a8856d1c2cbf78f6)) {
      return false;
    }

    newitembundle = getscriptbundle(var_a8856d1c2cbf78f6);
    callbacks = function_cca8bbe88a39ad41(newitembundle.type);

    if(!isDefined(callbacks)) {
      assertmsg("<dev string:xb2>" + newitembundle.type + "<dev string:xee>");
      return false;
    }

    if(autouse) {
      var_1489a088d7cc25cd = 1;

      if(isDefined(callbacks.var_381daafc5fc31b7f)) {
        var_1489a088d7cc25cd = self[[callbacks.var_381daafc5fc31b7f]](newitembundle, item, autouse, 0);
      }

      if(var_1489a088d7cc25cd) {
        var_c3051697735d1320 = item.var_4f74f0aef2b2a8bf;
        quantityused = function_bb2e10bb5f7e813f(item, newitembundlename, newitembundle);

        if(quantityused > 0) {
          function_61e26b275dfa50e0(newitembundle, quantityused, var_c3051697735d1320, 0, item, var_95484d8d503de3b8);
          return true;
        }
      }
    } else {
      if(isDefined(callbacks.canusefunc)) {
        canuse = self[[callbacks.canusefunc]](newitembundle, item, autouse, 0);
        assertex(isDefined(canuse), "<dev string:xf3>" + getxhashhexname(scriptablename) + "<dev string:x11c>");
      }

      canuse = default_to(canuse, 1);

      if(istrue(canuse)) {
        [var_2814cca693e6ef2d, var_64009c8d010b1490] = [undefined, 0];

        if(isDefined(callbacks.var_df9b308efe82294a)) {
          [var_2814cca693e6ef2d, var_64009c8d010b1490] = self[[callbacks.var_df9b308efe82294a]]();
        }

        if(isstruct(var_2814cca693e6ef2d) && isDefined(var_2814cca693e6ef2d.ref) && (var_2814cca693e6ef2d.ref != newitembundle.ref || istrue(newitembundle.disablestacking)) && var_64009c8d010b1490 > 0 && var_2814cca693e6ef2d.inventorytype != "Pooled") {
          dropstruct = function_3fa6e9da3fd741f2();
          function_ab8cf1b73aaa14(dropstruct, var_2814cca693e6ef2d);
          items_dropitem(var_2814cca693e6ef2d, var_64009c8d010b1490, dropstruct);
        }

        var_c3051697735d1320 = item.var_4f74f0aef2b2a8bf;
        quantityused = function_bb2e10bb5f7e813f(item, newitembundlename, newitembundle);

        if(quantityused > 0) {
          function_61e26b275dfa50e0(newitembundle, quantityused, var_c3051697735d1320, 0, item, var_95484d8d503de3b8);
          return true;
        }
      }

      if(!istrue(var_95484d8d503de3b8)) {
        function_fbfd7096a2dbc7e7(newitembundle, 0);
      }
    }
  }

  return false;
}

function function_1a95cb90efa117b8(itembundle, packedcount) {
  item = spawnStruct();
  item.type = itembundle.scriptable;
  item.count = packedcount;
  return function_7f6f62ba8dfd0da0(itembundle, item);
}

function function_7f6f62ba8dfd0da0(itembundle, item) {
  callbacks = function_cca8bbe88a39ad41(itembundle.type);
  assertex(isDefined(callbacks), "<dev string:xb2>" + itembundle.type + "<dev string:xee>");
  assertex(isDefined(callbacks.usefunc), "<dev string:x139>" + itembundle.type + "<dev string:xee>");
  params = spawnStruct();
  params.item = item;
  params.itembundle = itembundle;
  callback::callback("player_used_item", params);
  return self[[callbacks.usefunc]](itembundle, item);
}

function function_a703a4241f091edc(item, time) {
  if(!isPlayer(self)) {
    return;
  }

  if(!isDefined(item.var_b82e5f82c73104ff)) {
    item.var_b82e5f82c73104ff = [];
  }

  playernum = self getplayerclientnum();
  endtime = gettime() + time * 1000;

  if(isDefined(item.var_b82e5f82c73104ff[playernum]) && item.var_b82e5f82c73104ff[playernum] > endtime) {
    return;
  }

  item.var_b82e5f82c73104ff[playernum] = endtime;
}

function items_dropitem(itembundle, count, dropstruct) {
  if(!isDefined(itembundle)) {
    assertmsg("<dev string:x176>");
    return undefined;
  }

  if(!isDefined(count) || count <= 0) {
    assertmsg("<dev string:x1a8>" + utility::ter_op(isDefined(itembundle.ref), itembundle.ref, "<dev string:x1e4>"));
    return undefined;
  }

  itembundlename = function_61d960957fcf3ca0(itembundle.ref);
  var_9ec3e3e77fa5f56c = "itemspawnentry:" + itembundlename;

  if(function_633f07e180b6ec8f(var_9ec3e3e77fa5f56c)) {
    return undefined;
  }

  lootid = function_6d15e119c2779a93(itembundle);
  self dlog_recordplayerevent("dlog_event_player_common_item", ["dropped", lootid, "stowed", 0, "equipped", 0, "bought", 0, "sold", 0, "type", itembundle.type, "from_cache", 0, "from_rift_reward", 0]);

  if(!isDefined(dropstruct)) {
    dropstruct = function_3fa6e9da3fd741f2();
  }

  dropinfo = function_49b86047c8a8b228(dropstruct, self.origin, self.angles, self);
  itemtypecallbacks = function_cca8bbe88a39ad41(itembundle.type);

  if(isDefined(itemtypecallbacks.dropitemfunc)) {
    return self[[itemtypecallbacks.dropitemfunc]](itembundle, count, dropinfo.origin, dropinfo.angles, dropstruct.var_c62a12bfca2ae58e);
  }

  var_befe30ad29a799c6 = [#"teamselect", self getentitynumber()];
  item = function_d59d110ccf0f5b8b(itembundle, count, dropinfo.origin, dropinfo.angles, 0, 0, var_befe30ad29a799c6, dropinfo.payload, dropstruct.var_c62a12bfca2ae58e);
  function_a703a4241f091edc(item, 300);
  params = spawnStruct();
  params.item = item;
  params.itembundle = itembundle;
  params.itembundlename = itembundlename;
  params.payload = var_befe30ad29a799c6;
  callback::callback("player_item_drop", params);
  return item;
}

function function_105c431a9b8cac6b(ref, count, dropstruct) {
  itembundlename = function_61d960957fcf3ca0(ref);
  var_9ec3e3e77fa5f56c = "itemspawnentry:" + itembundlename;

  if(function_633f07e180b6ec8f(var_9ec3e3e77fa5f56c)) {
    return undefined;
  }

  if(!isDefined(dropstruct)) {
    dropstruct = function_59a2e61d79065dca();
  }

  dropinfo = function_49b86047c8a8b228(dropstruct, self.origin, self.angles, self);
  itembundle = getscriptbundle(var_9ec3e3e77fa5f56c);
  itemtypecallbacks = function_cca8bbe88a39ad41(itembundle.type);

  if(isDefined(itemtypecallbacks.dropitemfunc)) {
    return self[[itemtypecallbacks.dropitemfunc]](itembundle, count, dropstruct.origin, dropstruct.angles);
  }

  item = function_d59d110ccf0f5b8b(itembundle, count, dropstruct.origin, dropstruct.angles);
  params = spawnStruct();
  params.item = item;
  params.itembundlename = itembundlename;
  callback::callback("player_item_drop", params);
  return item;
}

function function_23a72b496d4206c9(targetlootid) {
  var_a23a9d12025e9230 = getlootscriptablearrayinradius(undefined, undefined, self.origin, 100);

  if(var_a23a9d12025e9230.size < 1) {
    return;
  }

  items = [];

  foreach(scriptable in var_a23a9d12025e9230) {
    itembundlename = function_2cdc55ba39d97d70(scriptable.type);

    if(!isDefined(itembundlename)) {
      continue;
    }

    itembundle = getscriptbundle("itemspawnentry:" + itembundlename);

    if(!isDefined(itembundle.ref)) {
      continue;
    }

    lootid = function_6d15e119c2779a93(itembundle);

    if(isDefined(lootid) && targetlootid == lootid) {
      items[items.size] = scriptable;
    }
  }

  if(items.size == 1) {
    return items[0];
  }

  var_5d9d8662fc4251b8 = undefined;
  largestdot = 0;
  playerforward = anglesToForward(self getplayerangles());

  foreach(scriptable in items) {
    directionvec = vectorNormalize(scriptable.origin - self.origin);
    dot = vectordot(playerforward, directionvec);

    if(dot > largestdot) {
      largestdot = dot;
      var_5d9d8662fc4251b8 = scriptable;
    }
  }

  return var_5d9d8662fc4251b8;
}

function function_7ccc263b372af2bc(item) {
  if(!isDefined(item.origin)) {
    return false;
  }

  var_4b2d501a4d31124f = (self getEye()[2] + item.origin[2]) / 2;
  var_b5e0ad6a13b55e67 = (item.origin[0], item.origin[1], var_4b2d501a4d31124f);
  directiontoitem = vectorNormalize(var_b5e0ad6a13b55e67 - self getEye());
  playerangles = self getplayerangles();
  playerforward = anglesToForward(playerangles);
  return vectordot(directiontoitem, playerforward) > level.var_3e5d2a63c1d15191;
}

function function_fb9af6e6b3526dc6() {
  self setclientomnvar("ui_loot_splash_item_quantity", 0);
  self setclientomnvar("ui_loot_splash_item_id", 0);
}

function function_fce713259eb405d8(itembundle, itemcount, var_c3051697735d1320) {
  self notify("updateLootSplash");
  self endon("disconnect");
  waitframe();

  if(istrue(itembundle.var_3b43fe792f56dea7) && isDefined(var_c3051697735d1320) && isDefined(var_c3051697735d1320.itembundlename)) {
    itembundle = getscriptbundle("itemspawnentry:" + var_c3051697735d1320.itembundlename);
  }

  quantity = 0;
  shouldshowquantity = (isDefined(itembundle.maxcount) && itembundle.maxcount > 0 || itembundle.type == "currency") && !istrue(itembundle.var_ff1750b480636dc9);

  if(shouldshowquantity && isDefined(itemcount)) {
    quantity = itemcount;
  }

  lootid = function_6d15e119c2779a93(itembundle);

  if(isDefined(lootid)) {
    self setclientomnvar("ui_loot_splash_item_quantity", quantity);
    self setclientomnvar("ui_loot_splash_item_id", lootid);
  } else {
    itembundlename = function_2cdc55ba39d97d70(itembundle.scriptable);

    if(isDefined(itembundlename)) {
      logstring("ui_loot_splash_item_id LootID: undefineditem bundle: " + itembundlename);
    }
  }

  self endon("updateLootSplash");
  waitframe();
  function_fb9af6e6b3526dc6();
}

function function_61b68d989b016af3(player, var_a0115a87500b34b) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  count = 0;

  foreach(item in var_a0115a87500b34b) {
    count++;
    waittime = 0.1;

    if(count % 3 == 0) {
      waittime = 1.5;
    }

    if(!isDefined(item.count) || item.count <= 0) {
      continue;
    }

    if(!isDefined(item.ref) || item.ref == "") {
      continue;
    }

    lootid = function_2c836ad05e5f634c(item.ref);
    itembundle = function_f4a303d532b044a7(lootid);

    if(!isDefined(itembundle.ref)) {
      continue;
    }

    player function_fce713259eb405d8(itembundle, item.count);
    wait waittime;
  }
}

function function_1a5ef09ec005ebf(origin, var_faa66d6f4c6c9e1d) {
  if(utility::issharedfuncdefined("game", "getZoneDefForOrigin")) {
    bundlename = utility::callsharedfunc("game", "getZoneDefForOrigin", origin);

    if(isDefined(var_faa66d6f4c6c9e1d)) {
      var_e62511cd09a9b71f = getscriptbundlefieldvalues("itemspawnzonedef:" + bundlename, var_faa66d6f4c6c9e1d);
      return var_e62511cd09a9b71f;
    }

    var_a91353c4805838d2 = getscriptbundle("itemspawnzonedef:" + bundlename);
    return var_a91353c4805838d2;
  }
}

function function_7ab86debeff1fefd(itemtype, itemindex) {
  if(isDefined(level.var_176215213ecd54a8)) {
    return self[[level.var_176215213ecd54a8]](itemtype, itemindex);
  }
}

function function_ab8cf1b73aaa14(dropstruct, itembundle, itemindex) {
  if(!isDefined(dropstruct)) {
    assertmsg("<dev string:x1f1>");
    return;
  }

  if(!isDefined(itembundle)) {
    assertmsg("<dev string:x23e>");
    return;
  }

  dropstruct.var_c62a12bfca2ae58e = function_7ab86debeff1fefd(itembundle.type, itemindex);
}

function function_b8bfea9514c89a77(packedcount) {
  if(!isDefined(packedcount)) {
    return 0;
  }

  packedcount = int(packedcount);
  return packedcount >> 0 & 2048 - 1;
}

function function_9f9adbfb9db3d2ab(packedcount) {
  if(!isDefined(packedcount)) {
    return 0;
  }

  packedcount = int(packedcount);
  return packedcount >> 11 & 2048 - 1;
}

function function_8fd389f931f45c66(packedcount) {
  if(!isDefined(packedcount)) {
    return 0;
  }

  packedcount = int(packedcount);
  return packedcount >> 22 & 64 - 1;
}

function function_7209c8cd4b2e3afd(itemcount, itemcountlefthand, var_dab81ead77442a10, itemcountrarity) {
  if(!isDefined(itemcount)) {
    return 0;
  }

  count = 0;
  itemcount = int(itemcount);
  assert(itemcount < 2048);
  count |= (itemcount & 2048 - 1) << 0;

  if(isDefined(itemcountlefthand)) {
    itemcountlefthand = int(itemcountlefthand);
    assert(itemcountlefthand < 2048);
    count |= (itemcountlefthand & 2048 - 1) << 11;
  }

  if(isDefined(var_dab81ead77442a10)) {
    var_dab81ead77442a10 = int(var_dab81ead77442a10);
    assert(var_dab81ead77442a10 < 64);
    count |= (var_dab81ead77442a10 & 64 - 1) << 22;
  }

  if(isDefined(itemcountrarity)) {
    itemcountrarity = int(itemcountrarity);
    assert(itemcountrarity < 8);
    count |= (itemcountrarity & 8 - 1) << 28;
  }

  return count;
}

function function_cd45408bd44fab07(listbundlename, count, origin, angles, var_14c85b39207719b8, var_57266f5ca6feebd7) {
  var_6f0d08c8a9f06ab5 = function_bc2f4857c90f5344(listbundlename, count);
  itemsspawned = [];
  dropstruct = function_59a2e61d79065dca(var_6f0d08c8a9f06ab5.size, undefined, undefined, undefined, undefined, undefined, 27, 13);

  for(i = 0; i < var_6f0d08c8a9f06ab5.size; i++) {
    var_8df7f401dd287a5c = var_6f0d08c8a9f06ab5[i];

    if(!isDefined(var_8df7f401dd287a5c)) {
      continue;
    }

    itembundle = getscriptbundle("itemspawnentry:" + var_8df7f401dd287a5c);
    assertex(isDefined(itembundle), "<dev string:x28b>" + var_8df7f401dd287a5c + "<dev string:x2c1>" + listbundlename + "<dev string:xee>");

    if(!isDefined(itembundle)) {
      continue;
    }

    item = function_c465d27f3f6066b4(itembundle, origin, angles, var_14c85b39207719b8, var_57266f5ca6feebd7, undefined, dropstruct);
    itemsspawned = utility::array_add(itemsspawned, item);
  }

  return itemsspawned;
}

function function_bc2f4857c90f5344(listbundlename, count) {
  return function_6b35ded8b1d89ce8("itemspawnlist:" + listbundlename, count);
}

function function_c465d27f3f6066b4(itembundle, itemorigin, itemangles, var_14c85b39207719b8, var_57266f5ca6feebd7, payload, dropstruct) {
  if(!isDefined(itembundle)) {
    assertmsg("<dev string:x2d7>");
    return undefined;
  }

  dropinfo = function_250558a79c78739e(itemorigin, itemangles);

  if(!istrue(var_14c85b39207719b8)) {
    if(!isDefined(dropstruct)) {
      dropstruct = function_59a2e61d79065dca(1, undefined, undefined, undefined, undefined, undefined, 27, 13);
    }

    dropinfo = function_49b86047c8a8b228(dropstruct, itemorigin, itemangles);
  }

  droporigin = dropinfo.origin;
  dropangles = isDefined(itemangles) ? itemangles : dropinfo.angles;
  dropangles = isDefined(dropangles) ? dropangles : (0, 0, 0);

  if(itembundle.type == "weapon") {
    return namespace_736197e4d378b91b::function_c069cffb4cbd1707(itembundle, droporigin, dropangles, undefined, undefined, var_14c85b39207719b8, var_57266f5ca6feebd7, payload, dropinfo.payload);
  }

  dropcount = 1;

  if(isDefined(itembundle.spawncount) && itembundle.spawncount > 0) {
    dropcount = itembundle.spawncount;
  }

  return function_d59d110ccf0f5b8b(itembundle, dropcount, droporigin, dropangles, var_14c85b39207719b8, var_57266f5ca6feebd7, payload, dropinfo.payload);
}

function function_119bf86e1d774c3(scriptablename, itemorigin, itemangles, itemindex, totalitemcount, var_14c85b39207719b8, var_57266f5ca6feebd7, payload) {
  itembundle = function_1749413ee00b69f(scriptablename);

  if(!isDefined(itembundle)) {
    return undefined;
  }

  return function_c465d27f3f6066b4(itembundle, itemorigin, itemangles, var_14c85b39207719b8, var_57266f5ca6feebd7, payload);
}

function private function_4837e73f5e8c9129() {
  self endon("death");
  self endon("cleanup");

  while(true) {
    waitframe();

    if(self function_6954a8d7ba8cd9fb()) {
      break;
    }
  }

  function_68bb330b8e871f35();
}

function function_d59d110ccf0f5b8b(dropbundle, dropcount, droporigin, dropangles, var_14c85b39207719b8, var_57266f5ca6feebd7, payload1, payload2, overridelifetime) {
  scriptablename = function_edbb604348696c44(dropbundle.scriptable);

  if(!isscriptabledefined(scriptablename)) {
    assertmsg("<dev string:x329>" + dropbundle.ref + "<dev string:x360>" + getxhashsourcename(scriptablename) + "<dev string:x387>");
    return undefined;
  }

  item = spawnscriptable(scriptablename, droporigin, dropangles, undefined, payload1, payload2);
  item thread function_4837e73f5e8c9129();

  if(!istrue(var_14c85b39207719b8)) {
    item setscriptablepartstate(item.type, "dropped");
  }

  if(isDefined(dropcount)) {
    item.count = int(dropcount);
  }

  function_43272b9595268864(dropbundle, droporigin);
  function_8908e7c9faba929a(item);
  item callback::callback("scriptable_item_spawned", {
    #angles: dropangles, #origin: droporigin, #itembundle: dropbundle, #item: item
  });

  if(!istrue(var_57266f5ca6feebd7)) {
    var_c33c1d1c46eaa040 = utility::default_to(dropbundle.lifetime, 90);

    if(isDefined(overridelifetime)) {
      var_c33c1d1c46eaa040 = overridelifetime;
    }

    item thread function_33ee459f817ccf86(var_c33c1d1c46eaa040);
  }

  return item;
}

function function_8908e7c9faba929a(item) {
  if(!isDefined(level.commonitem.var_2fed0f30000b5aaf)) {
    level.commonitem.var_2fed0f30000b5aaf = [];
  }

  if(isDefined(level.commonitem.var_2fed0f30000b5aaf[item.index])) {
    assert("<dev string:x3a4>" + item.type + "<dev string:x3dc>" + item.index + "<dev string:x3e2>");
    return;
  } else {
    level.commonitem.var_2fed0f30000b5aaf[item.index] = item;
  }

  scriptable_group::function_476b3beecd82dcca("common_items", item);

  if(level.commonitem.var_199caf9c010ecca9) {
    item.var_73d5550e1343a475 = function_20802d775db3ce8(item.index, item.origin);
    item callback::add(#"hash_c6a6fbc56f71a3b1", &function_78601a7fc032bb47);
    item callback::add(#"hash_8e9040f5886c6379", &function_78601a7fc032bb47);
  }

  if(level.commonitem.var_f6db2dc3ab7b9a12) {
    logstring("[COMMON_ITEM] " + "Registering a spawned scriptable [" + item.type + "](" + item.index + ").");
  }
}

function function_78601a7fc032bb47(var_534a10d17a7d82c5) {
  level.commonitem.var_2fed0f30000b5aaf[self.index] = undefined;

  if(var_534a10d17a7d82c5.group_id == "common_items") {
    if(level.commonitem.var_199caf9c010ecca9 && isDefined(self.var_73d5550e1343a475)) {
      function_e54fb70d6646b97c(self.var_73d5550e1343a475);
      self.var_73d5550e1343a475 = undefined;
    }

    if(level.commonitem.var_f6db2dc3ab7b9a12) {
      logstring("[COMMON_ITEM] " + "Deregistering a spawned scriptable [" + self.type + "](" + self.index + ").");
    }
  }
}

function private function_43272b9595268864(itembundle, dropposition) {
  if(!isDefined(itembundle.dropsfx)) {
    return;
  }

  if(isDefined(dropposition)) {
    playsoundatpos(dropposition, itembundle.dropsfx);
    return;
  }

  self playSound(itembundle.dropsfx);
}

function function_a621885d4088d15f() {
  level.commonitem.var_30d780bdba4bc858 = [];
  level.commonitem.var_d58f96d6b0e99929 = [];
}

function function_901913fce1c734e2(scriptablename, var_702868f226e310ec) {
  level.commonitem.var_30d780bdba4bc858[scriptablename] = var_702868f226e310ec;
}

function function_e88c7dbe0f396ccb(scriptablename, func) {
  level.commonitem.var_d58f96d6b0e99929[scriptablename] = func;
}

function function_edbb604348696c44(scriptablename) {
  if(isDefined(level.commonitem.var_30d780bdba4bc858[scriptablename])) {
    scriptablename = level.commonitem.var_30d780bdba4bc858[scriptablename];
  }

  if(isDefined(level.commonitem.var_d58f96d6b0e99929[scriptablename])) {
    replacementname = [[level.commonitem.var_d58f96d6b0e99929[scriptablename]]]();

    if(isDefined(replacementname)) {
      scriptablename = replacementname;
    }
  }

  return scriptablename;
}

function private items_database_init() {
  level.commonitem.var_b09fc2aeb718c263 = [];
  level.commonitem.var_ec08d293dcc1ea4f = [];
  level.commonitem.var_970a8dd2fe7c510b = [];

  if(!isDefined(level.gametypebundle.var_328f56c2f24c4831)) {
    assertmsg("<dev string:x3f7>");
    return;
  }

  zonelist = getscriptbundle("itemspawnzonelist:" + level.gametypebundle.var_328f56c2f24c4831);

  if(!isDefined(zonelist)) {
    assertmsg("<dev string:x451>" + level.gametypebundle.var_328f56c2f24c4831 + "<dev string:x48e>");
    return;
  }

  level.commonitem.var_9c1299ad2123c6a6 = [];
  level.commonitem.var_2b8c7f81dece4299 = [];

  if(isDefined(zonelist.includelist)) {
    function_754c0f10a7b580ad(zonelist.includelist);
  }

  if(!zonelist.zonedefs.size) {
    assertmsg("<dev string:x4c0>" + level.gametypebundle.var_328f56c2f24c4831 + "<dev string:x4e0>");
    return;
  }

  validglobal = 0;

  foreach(zonedef in zonelist.zonedefs) {
    if(!isDefined(zonedef.zonedef)) {
      continue;
    }

    var_a91353c4805838d2 = getscriptbundle("itemspawnzonedef:" + zonedef.zonedef);

    if(isDefined(var_a91353c4805838d2) && isDefined(var_a91353c4805838d2.itemspawnlist)) {
      function_754c0f10a7b580ad(var_a91353c4805838d2.itemspawnlist);

      if(!validglobal && isDefined(zonedef.zonename) && zonedef.zonename == "global") {
        validglobal = 1;
      }
    }
  }

  assertex(validglobal, "<dev string:x4ef>" + level.gametypebundle.var_328f56c2f24c4831 + "<dev string:x537>");
  level.commonitem.var_9c1299ad2123c6a6 = undefined;
  level.commonitem.var_2b8c7f81dece4299 = undefined;
}

function private function_754c0f10a7b580ad(listbundlename) {
  if(!isDefined(listbundlename) || listbundlename == "") {
    return 1;
  }

  if(utility::array_contains(level.commonitem.var_9c1299ad2123c6a6, listbundlename)) {
    return 0;
  }

  utility::array_add(level.commonitem.var_9c1299ad2123c6a6, listbundlename);
  itemlistbundle = getscriptbundle("itemspawnlist:" + listbundlename);

  if(!isDefined(itemlistbundle)) {
    return 2;
  }

  foreach(itementry in itemlistbundle.itementries) {
    error = function_a6275c9ae7ae1bda(itementry.itemspawnentry);

    if(error) {
      switch (error) {
        case 1:
          println("<dev string:x56b>" + listbundlename + "<dev string:x58e>");
          break;
        case 2:
          assertmsg("<dev string:x5af>" + listbundlename + "<dev string:x5ce>" + itementry.itemspawnentry + "<dev string:x5f0>");
          break;
      }
    }
  }

  foreach(itemlistentry in itemlistbundle.itemlistentries) {
    error = function_754c0f10a7b580ad(itemlistentry.itemspawnlist);

    if(error) {
      switch (error) {
        case 1:
          println("<dev string:x56b>" + listbundlename + "<dev string:x61d>");
          break;
        case 2:
          assertmsg("<dev string:x5af>" + listbundlename + "<dev string:x643>" + itemlistentry.itemspawnlist + "<dev string:x66a>");
          break;
      }
    }
  }

  return 0;
}

function private function_a6275c9ae7ae1bda(itembundlename) {
  if(!isDefined(itembundlename) || itembundlename == "") {
    return 1;
  }

  if(utility::array_contains(level.commonitem.var_2b8c7f81dece4299, itembundlename)) {
    return 0;
  } else {
    level.commonitem.var_2b8c7f81dece4299[level.commonitem.var_2b8c7f81dece4299.size] = itembundlename;
  }

  itembundle = getscriptbundlefieldvalues("itemspawnentry:" + itembundlename, [#"type", #"hash_b9a3752dc7a3d626", #"scriptable", #"ref"]);

  if(!isDefined(itembundle)) {
    return 2;
  }

  if(isDefined(itembundlename) && isDefined(itembundle)) {
    itemtypefunc = function_4651d0094e0bd59d(itembundle.type, #"hash_3483a973fd1fe5b8");

    if(isDefined(itemtypefunc)) {
      [[itemtypefunc]](itembundlename);
    } else {
      function_112c64fc568b602f(itembundlename);
    }
  }

  itemtypefunc = function_4651d0094e0bd59d(itembundle.type, #"hash_79cd484b40e882b");

  if(isDefined(itemtypefunc)) {
    [[itemtypefunc]](itembundlename);
  }

  if(istrue(itembundle.var_5a5e50bc261c907a)) {
    return 0;
  }

  if(isDefined(itembundle.scriptable)) {
    if(!isDefined(level.commonitem.var_ec08d293dcc1ea4f[itembundle.scriptable])) {
      level.commonitem.var_ec08d293dcc1ea4f[itembundle.scriptable] = itembundlename;
    } else {
      print("<dev string:x696>" + level.commonitem.var_ec08d293dcc1ea4f[itembundle.scriptable] + "<dev string:x6d4>" + itembundlename + "<dev string:x6df>" + getxhashsourcename(itembundle.scriptable) + "<dev string:x6ee>");
    }
  }

  if(isDefined(itembundle.ref)) {
    if(!isDefined(level.commonitem.var_970a8dd2fe7c510b[itembundle.ref])) {
      var_6fc01db500097fd9 = [" "];

      foreach(character in var_6fc01db500097fd9) {
        if(issubstr(itembundle.ref, character)) {
          assertmsg("<dev string:x737>" + itembundlename + "<dev string:x759>" + character + "<dev string:x78c>");
          return 0;
        }
      }

      level.commonitem.var_970a8dd2fe7c510b[itembundle.ref] = itembundlename;
      lootid = function_2c836ad05e5f634c(itembundle.ref);

      if(isDefined(lootid)) {
        level.commonitem.var_b09fc2aeb718c263[lootid] = itembundlename;
      }
    } else {
      print("<dev string:x696>" + level.commonitem.var_970a8dd2fe7c510b[itembundle.ref] + "<dev string:x6d4>" + itembundlename + "<dev string:x6df>" + itembundle.ref + "<dev string:x792>");
    }
  }

  return 0;
}

function function_b343caad692916aa(itembundle) {
  if(isDefined(itembundle.inventorytype) && itembundle.inventorytype == "Pooled") {
    return false;
  }

  if(isDefined(itembundle.inventorytype) && itembundle.inventorytype != "none") {
    return true;
  }

  if(isDefined(itembundle.inventoryslot) && itembundle.inventoryslot != "none") {
    return true;
  }

  return false;
}

function function_f0c15201c9f7e1db(scriptablename) {
  if(isstring(scriptablename)) {
    scriptablename = getxhashasset(scriptablename);
  }

  return isDefined(level.commonitem.var_ec08d293dcc1ea4f[scriptablename]);
}

function function_cca8bbe88a39ad41(itemtype) {
  return level.commonitem.itemcallbacks[itemtype];
}

function function_fc925a153c7fd55c(lootid) {
  lootidtype = loot::function_282cf83c9eeda744(lootid);

  if(isDefined(lootidtype)) {
    funcoverride = function_4651d0094e0bd59d(lootidtype, #"bundlenamefromlootid");

    if(isDefined(funcoverride)) {
      return [[funcoverride]](lootid);
    }
  }

  return level.commonitem.var_b09fc2aeb718c263[lootid];
}

function function_2b10ba6fb19dccd9(lootid) {
  itembundlename = function_fc925a153c7fd55c(lootid);

  if(isDefined(itembundlename)) {
    return hashcat(%"itemspawnentry:", itembundlename);
  }

  return undefined;
}

function function_b4dd67b39cbb2f31(lootid) {
  return getxhashsourcename(function_fc925a153c7fd55c(lootid));

  return getxhashhexname(function_fc925a153c7fd55c(lootid));
}

function function_2cdc55ba39d97d70(scriptablename) {
  if(isstring(scriptablename)) {
    scriptablename = getxhashasset(scriptablename);
  }

  return level.commonitem.var_ec08d293dcc1ea4f[scriptablename];
}

function function_8daeb22f16cf4ce9(scriptablename) {
  return getxhashsourcename(function_2cdc55ba39d97d70(scriptablename));

  return getxhashhexname(function_2cdc55ba39d97d70(scriptablename));
}

function function_61d960957fcf3ca0(ref) {
  return level.commonitem.var_970a8dd2fe7c510b[ref];
}

function function_1749413ee00b69f(scriptablename) {
  if(!isDefined(scriptablename) || !function_f0c15201c9f7e1db(scriptablename)) {
    if(!isDefined(scriptablename)) {
      assertmsg("<dev string:x7cd>");
    } else if(isstring(scriptablename)) {
      assertmsg("<dev string:x826>" + scriptablename + "<dev string:x874>");
    } else if(isxhashasset(scriptablename)) {
      assertmsg("<dev string:x826>" + getxhashsourcename(scriptablename) + "<dev string:x874>");
    } else {
      assertmsg("<dev string:x87a>");
    }

    return undefined;
  }

  scriptablename = function_edbb604348696c44(scriptablename);
  itembundlename = function_2cdc55ba39d97d70(scriptablename);

  if(!isDefined(itembundlename)) {
    assertmsg("<dev string:x8ff>" + scriptablename + "<dev string:x942>");
    return undefined;
  }

  itembundle = getscriptbundle("itemspawnentry:" + itembundlename);

  if(!isDefined(itembundle)) {
    assertmsg("<dev string:x96c>" + itembundlename + "<dev string:x942>");
    return undefined;
  }

  return itembundle;
}

function function_467f0c241ad05cfb(ref) {
  return getxhashsourcename(function_61d960957fcf3ca0(ref));

  return getxhashhexname(function_61d960957fcf3ca0(ref));
}

function function_2f759e70c6189ff0(lootid) {
  itembundlename = function_fc925a153c7fd55c(lootid);

  if(!isDefined(itembundlename) || itembundlename == "") {
    assertmsg("<dev string:x9b2>" + lootid);
    return;
  }

  itembundle = getscriptbundle("itemspawnentry:" + itembundlename);

  if(!isDefined(itembundle)) {
    assertmsg("<dev string:x9f0>" + itembundlename);
    return;
  }

  return itembundle.scriptable;
}

function function_f4a303d532b044a7(lootid) {
  if(!isint(lootid)) {
    assertmsg("<dev string:xa30>" + (isDefined(lootid) ? lootid : "<dev string:x1e4>") + "<dev string:xa63>");
    return undefined;
  }

  itembundlename = function_fc925a153c7fd55c(lootid);

  if(!isDefined(itembundlename) || itembundlename == "") {
    lootinfo = getlootiteminfofromid(lootid);

    if(isDefined(lootinfo) && isDefined(lootinfo.itemref)) {
      assertmsg("<dev string:xa91>" + lootid + "<dev string:xade>" + "<dev string:xaf6>" + lootinfo.itemref + "<dev string:xee>" + "<dev string:xb2d>" + "<dev string:xba0>");
    } else {
      assertmsg("<dev string:xbe4>" + lootid + "<dev string:x874>");
    }

    return undefined;
  }

  itembundle = getscriptbundle("itemspawnentry:" + itembundlename);

  if(!isDefined(itembundle)) {
    assertmsg("<dev string:xc37>" + itembundlename + "<dev string:xee>");
    return undefined;
  }

  return itembundle;
}

function function_1df1b532888e29ab(itemtype) {
  return isDefined(function_cca8bbe88a39ad41(itemtype));
}

function function_1414925deba056bc(scriptablename, itemtype) {
  if(!isDefined(scriptablename) || !function_f0c15201c9f7e1db(scriptablename) || !isDefined(itemtype)) {
    return false;
  }

  itembundlename = function_2cdc55ba39d97d70(scriptablename);
  itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
  return isDefined(itembundle.type) && itembundle.type == itemtype;
}

function function_4ec04bdf7386d3d0(itembundle) {
  return isDefined(itembundle.maxcount) ? itembundle.maxcount : 0;
}

function function_c7171bcea41dd66f(itembundle) {
  if(istrue(itembundle.var_535a50184aa057f0)) {
    return (isDefined(itembundle.var_32c4755a90372a) ? itembundle.var_32c4755a90372a : 0);
  }

  return isDefined(itembundle.maxcount) ? itembundle.maxcount : 0;
}

function function_68789a2229990351(itembundle) {
  if(istrue(itembundle.var_535a50184aa057f0)) {
    return (isDefined(itembundle.var_a5f594a8f75b2992) ? itembundle.var_a5f594a8f75b2992 : 0);
  }

  return isDefined(itembundle.maxcount) ? itembundle.maxcount : 0;
}

function function_ccb2889218715cb1(item, part, state, player, autouse, usestring) {
  if(!isDefined(item.type) || !function_f0c15201c9f7e1db(item.type) || istrue(item.disable)) {
    return;
  }

  itembundlename = function_2cdc55ba39d97d70(item.type);

  if(!isDefined(itembundlename) || itembundlename == "") {
    assertmsg("<dev string:xc78>" + item.type + "<dev string:xc9d>");
    return;
  }

  itembundle = getscriptbundle("itemspawnentry:" + itembundlename);

  if(!isDefined(itembundle)) {
    assertmsg("<dev string:xcd2>" + itembundlename + "<dev string:xcfd>" + item.type + "<dev string:xee>");
    return;
  }

  if(!function_1df1b532888e29ab(itembundle.type)) {
    if(itembundle.type != "cache" && itembundle.type != "kiosk" && itembundle.type != "restock") {
      assertmsg("<dev string:xd2c>" + itembundlename + "<dev string:xd47>" + itembundle.type + "<dev string:xee>");
    }

    return;
  }

  if(autouse) {
    if(!istrue(itembundle.var_13fc3679e0d849db)) {
      return;
    }

    time = gettime();

    if(isDefined(player.var_833d5b97f04819f3) && player.var_833d5b97f04819f3 > time) {
      return;
    }

    playernum = player getplayerclientnum();

    if(isDefined(item.var_b82e5f82c73104ff) && isDefined(item.var_b82e5f82c73104ff[playernum]) && item.var_b82e5f82c73104ff[playernum] > time) {
      return;
    }
  }

  var_5dc9acd40a672a19 = player function_de489fa2ffdb7f2d(item, autouse, 1);
  var_4edf9373b84d50e = 0;

  if(!var_5dc9acd40a672a19 && (!autouse || istrue(itembundle.var_bbae53787b1abf3e)) && itembundle.type != "weapon") {
    var_4edf9373b84d50e = player common_inventory::function_10e55eeb4c15dd5a(item, autouse, 1);
  }

  if(var_5dc9acd40a672a19) {
    player.var_833d5b97f04819f3 = gettime() + utility::function_a5b14435e3229bed(0.1);
  }

  if(var_5dc9acd40a672a19 || var_4edf9373b84d50e) {
    player function_fbfd7096a2dbc7e7(itembundle, 1);
    return;
  }

  if(!autouse && (!isDefined(player.var_2fa5b49969def47) || !istrue(player.var_2fa5b49969def47.var_978407de904a5fd1))) {
    player function_fbfd7096a2dbc7e7(itembundle, 0);
  }
}

function private function_bb2e10bb5f7e813f(item, itembundlename, itembundle) {
  usedquantity = undefined;
  remainderquantity = function_7f6f62ba8dfd0da0(itembundle, item);

  if(isarray(remainderquantity) && isint(remainderquantity[0])) {
    if(isint(remainderquantity[1])) {
      usedquantity = remainderquantity[1];
    }

    remainderquantity = remainderquantity[0];
  }

  if(!isDefined(usedquantity)) {
    usedquantity = item.count - remainderquantity;
  }

  if(usedquantity > 0 || remainderquantity <= 0) {
    params = spawnStruct();
    params.item = item;
    params.itembundlename = itembundlename;
    params.itembundle = itembundle;
    params.tobackpack = 0;
    callback::callback("player_item_pickup", params);

    if(remainderquantity > 0) {
      item.count = remainderquantity;
    } else {
      self notify("self_pickedupitem", getxhashasset(item.type));
      function_c14962ea14e58968(item);
    }
  }

  return usedquantity;
}

function private function_c42d7a973667ed98(lifetime) {
  if(!getdvarint(@ "hash_691b5207342d5801", 0)) {
    return;
  }

  self endon("<dev string:xd7a>");
  remain = lifetime;

  while(remain > 0) {
    color = (1, 1, 1);
    alpha = 1;
    scale = 0.4;
    duration = 1;
    center = 1;
    scripts\common\debug::debug_print3d(self, "<dev string:xd83>" + remain, color, duration, "<dev string:xd7a>", "<dev string:xd7a>", alpha, scale, 20);
    wait duration;
    remain -= duration;
  }
}

function function_33ee459f817ccf86(waitseconds) {
  self endon("death");

  overridelifetime = getdvarint(@ "hash_4fa90c2ce3766d92", 0);

  if(overridelifetime < 0) {
    return;
  }

  if(overridelifetime) {
    waitseconds = overridelifetime;
  }

  thread function_c42d7a973667ed98(waitseconds);

  wait waitseconds;

  if(isDefined(self)) {
    params = spawnStruct();
    params.item = self;
    callback::callback("player_item_cleanup", params);
  }

  thread function_c14962ea14e58968(self);
}

function function_c14962ea14e58968(item) {
  if(istrue(item.fromcache)) {
    item.count = 0;
    return;
  }

  if(isDefined(item.var_4a0145502132790a)) {
    scriptable_group::function_879ccb6a53e634f5("common_items", item);
  }

  if(isstruct(item)) {
    item notify("death");
    return;
  }

  if(isent(item)) {
    item delete();
    return;
  }

  item scripts\cp_mp\calloutmarkerping::function_6bc4f6b579285f79();
  item notify("death");

  if(item getscriptableisreserved()) {
    item freescriptable();
    return;
  }

  item setscriptablepartstate(item.type, "hidden");
}

function function_68bb330b8e871f35() {
  if(istrue(self.var_695427780354d0e5)) {
    return;
  }

  contents = trace::create_contents(0, 1, 0, 0, 0, 1, 1, 0, 0);
  ignorelist = [];
  caststart = self.origin + (0, 0, 50);
  castend = caststart + (0, 0, -200);
  traceresult = trace::ray_trace(caststart, castend, ignorelist, contents);

  if(isDefined(traceresult["entity"])) {
    groundent = traceresult["entity"];

    if(groundent ismovingplatform()) {
      worldorigin = traceresult["position"] + (0, 0, 4);
      localorigin = rotatevectorinverted(worldorigin - groundent.origin, groundent.angles);
      localangles = combineangles(invertangles(groundent.angles), self.angles);

      if(isDefined(self.linkedparent)) {
        self.linkedparent linkTo(groundent, "", localorigin, localangles);
        return;
      }

      utility::scriptable_setparententity(groundent, localorigin, localangles);
    }
  }
}

function function_61e26b275dfa50e0(itembundle, itemcount, var_c3051697735d1320, stow, item, var_95484d8d503de3b8) {
  if(!isDefined(stow)) {
    stow = 0;
  }

  if(istrue(itembundle.var_3b43fe792f56dea7) && isDefined(var_c3051697735d1320) && isDefined(var_c3051697735d1320.itembundlename)) {
    itembundle = getscriptbundle("itemspawnentry:" + var_c3051697735d1320.itembundlename);
  }

  fromcache = 0;

  if(isDefined(item)) {
    fromcache = istrue(item.fromcache);
  }

  fromriftreward = 0;

  if(isDefined(item)) {
    fromriftreward = istrue(item.fromriftreward);
  }

  lootid = function_6d15e119c2779a93(itembundle);

  if(stow) {
    self dlog_recordplayerevent("dlog_event_player_common_item", ["dropped", 0, "stowed", lootid, "equipped", 0, "bought", 0, "sold", 0, "type", itembundle.type, "from_cache", fromcache, "from_rift_reward", fromriftreward]);
  } else {
    self dlog_recordplayerevent("dlog_event_player_common_item", ["dropped", 0, "stowed", 0, "equipped", lootid, "bought", 0, "sold", 0, "type", itembundle.type, "from_cache", fromcache, "from_rift_reward", fromriftreward]);
  }

  if(!istrue(var_95484d8d503de3b8)) {
    function_fbfd7096a2dbc7e7(itembundle, 1);
  }

  if(!istrue(itembundle.var_c03c4ef51659ba4c)) {
    thread function_fce713259eb405d8(itembundle, itemcount, var_c3051697735d1320);
  }
}

function function_fbfd7096a2dbc7e7(itembundle, issuccessful) {
  if(!isDefined(itembundle)) {
    return;
  }

  if(issuccessful) {
    if(isDefined(itembundle.pickupsfx)) {
      self playsoundtoplayer(itembundle.pickupsfx, self);
    }

    return;
  }

  if(isDefined(itembundle.denialsfx)) {
    self playsoundtoplayer(itembundle.denialsfx, self);
  }
}

function function_59a2e61d79065dca(var_e35351de85fe342d, var_8ee5ee589d379b1, var_91170e589f9e8ff, var_82839e7264d5d15e, var_8260b07264afb13c, var_13c9c27ba11aac1a, var_808de1e892fb0269, var_6353cc9d3791853a, var_8a600b6102da9f9b, optionaloverridedist, var_6fe2ff802d5192d4, var_d8cf705570b19696, var_69f3e94ac253c6ab, var_c62a12bfca2ae58e) {
  dropstruct = spawnStruct();
  dropstruct.dropidx = 0;
  dropstruct.var_e35351de85fe342d = var_e35351de85fe342d;
  dropstruct.var_8ee5ee589d379b1 = var_8ee5ee589d379b1;
  dropstruct.var_91170e589f9e8ff = var_91170e589f9e8ff;
  dropstruct.var_82839e7264d5d15e = var_82839e7264d5d15e;
  dropstruct.var_8260b07264afb13c = var_8260b07264afb13c;
  dropstruct.var_13c9c27ba11aac1a = var_13c9c27ba11aac1a;
  dropstruct.var_808de1e892fb0269 = var_808de1e892fb0269;
  dropstruct.var_6353cc9d3791853a = var_6353cc9d3791853a;
  dropstruct.var_8a600b6102da9f9b = var_8a600b6102da9f9b;
  dropstruct.optionaloverridedist = optionaloverridedist;
  dropstruct.var_6fe2ff802d5192d4 = var_6fe2ff802d5192d4;
  dropstruct.var_d8cf705570b19696 = var_d8cf705570b19696;
  dropstruct.var_69f3e94ac253c6ab = var_69f3e94ac253c6ab;
  dropstruct.var_c62a12bfca2ae58e = var_c62a12bfca2ae58e;
  return dropstruct;
}

function function_3fa6e9da3fd741f2() {
  dropstruct = function_59a2e61d79065dca();
  dropstruct.var_8ee5ee589d379b1 = -30;
  dropstruct.var_91170e589f9e8ff = 30;
  dropstruct.var_82839e7264d5d15e = -30;
  dropstruct.var_8260b07264afb13c = 30;
  return dropstruct;
}

function function_49b86047c8a8b228(dropstruct, baseorigin, baseangles, ignoreent, var_3ace5ac9c7d6fa44, var_688e4da4cb16116d) {
  assert(!isDefined(ignoreent) || isent(ignoreent));

  if(!isDefined(dropstruct) || !isstruct(dropstruct) || !isDefined(dropstruct.dropidx)) {
    println("<dev string:xd87>");
    return function_250558a79c78739e(baseorigin, baseangles);
  }

  var_c459fe3ec72a8224 = 6;

  if(isDefined(dropstruct.var_13c9c27ba11aac1a) && dropstruct.var_13c9c27ba11aac1a > 0) {
    var_c459fe3ec72a8224 = dropstruct.var_13c9c27ba11aac1a;
  }

  ring_quantity = 3;
  slot_yaw = 360 / var_c459fe3ec72a8224;
  ring_yaw = isDefined(dropstruct.var_7281c7ba7331bc41) ? dropstruct.var_7281c7ba7331bc41 : 30;
  var_551904951118b7b9 = level.var_1dfefe3988a59ae5;
  var_ab9f50e5b2c2e07e = ter_op(isDefined(dropstruct.var_8ee5ee589d379b1), dropstruct.var_8ee5ee589d379b1, -5);
  var_ab7c62e5b29cc05c = ter_op(isDefined(dropstruct.var_91170e589f9e8ff), dropstruct.var_91170e589f9e8ff, 5);
  var_b0bb91ad89d1aaed = ter_op(isDefined(dropstruct.var_82839e7264d5d15e), dropstruct.var_82839e7264d5d15e, -5);
  var_b0987bad89ab32d3 = ter_op(isDefined(dropstruct.var_8260b07264afb13c), dropstruct.var_8260b07264afb13c, 5);
  var_b57e08395cbe94d2 = 40;

  if(isDefined(ignoreent) && isent(ignoreent) && isPlayer(ignoreent) && player_utility::isreallyalive(ignoreent)) {
    currentstance = ignoreent getstance();

    if(currentstance == "crouch") {
      var_b57e08395cbe94d2 = 20;
    } else if(currentstance == "prone") {
      var_b57e08395cbe94d2 = 10;
    }
  }

  dropdata = spawnStruct();
  dropdata.noground = 0;
  dropdata.payload = 0;
  dropdata.groundentity = undefined;

  if(!isDefined(baseangles)) {
    baseangles = (0, 0, 0);
  }

  groundfloat = 0;

  if(isDefined(dropstruct.var_6fe2ff802d5192d4)) {
    groundfloat = dropstruct.var_6fe2ff802d5192d4;
  }

  var_d2052427afb83208 = dropstruct.dropidx;

  if(isDefined(dropstruct.var_e35351de85fe342d) && dropstruct.var_e35351de85fe342d > 0) {
    var_910a2201eb1324a9 = var_c459fe3ec72a8224 * ring_quantity;

    if(var_910a2201eb1324a9 < dropstruct.var_e35351de85fe342d) {
      ring_quantity += int((dropstruct.var_e35351de85fe342d - var_910a2201eb1324a9) / var_c459fe3ec72a8224) + 1;
      var_910a2201eb1324a9 = var_c459fe3ec72a8224 * ring_quantity;
    }

    var_ffe1703d5d22415a = int(var_910a2201eb1324a9 / dropstruct.var_e35351de85fe342d);
    var_8bb31dc1b994cab5 = dropstruct.dropidx * var_ffe1703d5d22415a;
    var_d40d2342f65ca3dd = 0;

    if(var_ffe1703d5d22415a > 1) {
      var_d40d2342f65ca3dd = randomintrange(0, var_ffe1703d5d22415a - 1);
    }

    var_d2052427afb83208 = var_8bb31dc1b994cab5 + var_d40d2342f65ca3dd;
  }

  var_57716496f9f490f = 75;

  if(isDefined(dropstruct.var_808de1e892fb0269)) {
    var_57716496f9f490f = dropstruct.var_808de1e892fb0269;
  }

  var_e0cc897878c28778 = 35;

  if(isDefined(dropstruct.var_6353cc9d3791853a)) {
    var_e0cc897878c28778 = dropstruct.var_6353cc9d3791853a;
  }

  dropdata.ring = int(var_d2052427afb83208 / var_c459fe3ec72a8224);
  dropdata.ringslot = var_d2052427afb83208 - dropdata.ring * var_c459fe3ec72a8224;
  dropdata.yaw = baseangles[1] + dropdata.ringslot * slot_yaw + dropdata.ring * ring_yaw + randomfloatrange(var_ab9f50e5b2c2e07e, var_ab7c62e5b29cc05c);
  dropdata.dist = var_57716496f9f490f + dropdata.ring * var_e0cc897878c28778 + randomfloatrange(var_b0bb91ad89d1aaed, var_b0987bad89ab32d3);

  if(isDefined(dropstruct.var_8a600b6102da9f9b)) {
    dropdata.yaw = baseangles[1] + dropstruct.var_8a600b6102da9f9b;
  }

  if(isDefined(dropstruct.optionaloverridedist)) {
    dropdata.dist = dropstruct.optionaloverridedist;
  }

  dropdata.outangles = (0, dropdata.yaw, 0);
  dropdata.dir = anglesToForward(dropdata.outangles);

  if(level.var_cb89daf3a1d3e761 && !isDefined(dropstruct.optionaloverridedist) && !isDefined(dropstruct.var_d8cf705570b19696) && !istrue(var_688e4da4cb16116d) && dropdata.ring < 1) {
    function_1b451ac8cf14a6a4(dropdata, dropstruct, baseorigin);
  }

  dropdata.outorigin = baseorigin + dropdata.dir * dropdata.dist;

  if(isDefined(dropstruct.var_d8cf705570b19696)) {
    dropdata.outorigin = dropstruct.var_d8cf705570b19696;
  }

  if(true) {
    if(var_551904951118b7b9) {
      println("<dev string:xdf9>" + dropstruct.dropidx + "<dev string:xe0b>" + baseorigin + "<dev string:xe16>" + dropdata.outorigin + "<dev string:xe1e>" + dropdata.dist);
    }

    tracecontents = trace::create_contents(0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1);
    traceresults = function_9b539449b8809a8(dropstruct, dropdata, baseorigin, ignoreent, tracecontents, var_551904951118b7b9);
    var_45e7ad8e414c03f = level.var_a0b1f76228d242e1;
    var_daa047868cf7a01b = level.var_b08a4f5480f5801d;

    if(isDefined(traceresults) && traceresults["fraction"] < var_daa047868cf7a01b && var_45e7ad8e414c03f > 0 && !isDefined(dropstruct.var_8a600b6102da9f9b) && !isDefined(dropstruct.optionaloverridedist) && !isDefined(dropstruct.var_d8cf705570b19696)) {
      function_37e7de90990a9b95(dropstruct, dropdata, baseorigin, baseangles, ignoreent, tracecontents, var_45e7ad8e414c03f, var_daa047868cf7a01b, var_551904951118b7b9);
    }

    function_1bf026a5b9fdae23(dropstruct, dropdata, ignoreent, tracecontents, var_551904951118b7b9);
    function_2b84f1379888e314(dropstruct, dropdata, ignoreent, tracecontents, groundfloat, dropstruct.var_69f3e94ac253c6ab, var_551904951118b7b9);
  } else {
    dropdata.outorigin += (0, 0, groundfloat);
  }

  if(1 && !dropdata.noground) {
    startorigin = baseorigin;

    if(!istrue(var_3ace5ac9c7d6fa44)) {
      startorigin += (0, 0, var_b57e08395cbe94d2);
    }

    dropdata.payload = calcscriptablepayloadgravityarc(startorigin, dropdata.outorigin);
  }

  if(var_551904951118b7b9) {
    println("<dev string:xdf9>" + dropstruct.dropidx + "<dev string:xe2b>" + dropdata.outorigin + "<dev string:xe3e>" + dropdata.outangles);
  }

  dropstruct.dropidx++;
  return function_250558a79c78739e(dropdata.outorigin, dropdata.outangles, dropdata.payload, dropdata.groundentity);
}

function private function_1b451ac8cf14a6a4(dropdata, dropstruct, baseorigin) {
  var_fafd64b272244139 = getlootscriptablearrayinradius(undefined, undefined, baseorigin, dropdata.dist + 10);

  if(isDefined(var_fafd64b272244139) && var_fafd64b272244139.size > 0) {
    foreach(scriptable in var_fafd64b272244139) {
      if(!isDefined(scriptable.origin)) {
        continue;
      }

      directionvec = scriptable.origin - baseorigin;
      normalizedvec = vectorNormalize(directionvec);
      angle = vectordot(dropdata.dir, normalizedvec);

      if(angle > level.var_3a94e816b6c1f549) {
        mindist = distance2d(baseorigin, scriptable.origin) / 2;

        if(mindist < dropdata.dist) {
          dropdata.dist = mindist;
        }
      }
    }

    var_57716496f9f490f = 75;

    if(isDefined(dropstruct.var_808de1e892fb0269)) {
      var_57716496f9f490f = dropstruct.var_808de1e892fb0269;
    }

    var_e0cc897878c28778 = 35;

    if(isDefined(dropstruct.var_6353cc9d3791853a)) {
      var_e0cc897878c28778 = dropstruct.var_6353cc9d3791853a;
    }

    if(dropdata.dist < level.var_77551c1821d16927) {
      dropdata.dist = var_57716496f9f490f + randomfloatrange(-5, 5);
    }
  }
}

function private function_9b539449b8809a8(dropstruct, dropdata, baseorigin, ignoreent, tracecontents, var_551904951118b7b9) {
  tracestart = baseorigin + (0, 0, 21);
  wallgrace = dropdata.dir * 18;
  traceend = dropdata.outorigin + wallgrace + (0, 0, 21);
  traceresults = trace::ray_trace(tracestart, traceend, ignoreent, tracecontents);

  if(var_551904951118b7b9) {
    function_d2d7b153b9d3889e(dropstruct.dropidx, "<dev string:xe43>", tracestart, traceend, traceresults);
  }

  if(traceresults["fraction"] < 1) {
    dropdata.outorigin = traceresults["position"];
  } else {
    dropdata.outorigin = traceend;
  }

  dropdata.outorigin -= wallgrace;
  heightchecks = level.var_f4a8313dc2ced539;

  for(check = 0; check < heightchecks; check++) {
    tracestart += (0, 0, 10 * check);
    hightraceresults = trace::ray_trace(tracestart, traceend, ignoreent, tracecontents);

    if(hightraceresults["fraction"] < traceresults["fraction"]) {
      traceresults["fraction"] = -1;
    }
  }

  return traceresults;
}

function private function_37e7de90990a9b95(dropstruct, dropdata, baseorigin, baseangles, ignoreent, tracecontents, retries, var_daa047868cf7a01b, var_551904951118b7b9) {
  var_c459fe3ec72a8224 = 6;
  slot_yaw = 360 / var_c459fe3ec72a8224;
  initialring = dropdata.ring;
  initialslot = dropdata.ringslot;
  initialyaw = dropdata.yaw;
  initialdist = dropdata.dist;
  initialdir = dropdata.dir;
  var_f4a31528787ae6bd = dropdata.outangles;
  var_9bd3420d924c5c43 = dropdata.outorigin;
  var_57716496f9f490f = 75;

  if(isDefined(dropstruct.var_808de1e892fb0269)) {
    var_57716496f9f490f = dropstruct.var_808de1e892fb0269;
  }

  var_e0cc897878c28778 = 35;

  if(isDefined(dropstruct.var_6353cc9d3791853a)) {
    var_e0cc897878c28778 = dropstruct.var_6353cc9d3791853a;
  }

  attempts = 0;
  success = 0;

  while(attempts < retries && !success) {
    dropstruct.dropidx++;
    dropdata.ring = int(dropstruct.dropidx / var_c459fe3ec72a8224);
    dropdata.ringslot = dropstruct.dropidx - dropdata.ring * var_c459fe3ec72a8224;
    dropdata.yaw = baseangles[1] + dropdata.ringslot * slot_yaw + dropdata.ring * 30 + randomfloatrange(-5, 5);
    dropdata.dist = var_57716496f9f490f + dropdata.ring * var_e0cc897878c28778 + randomfloatrange(-5, 5);
    dropdata.outangles = (0, dropdata.yaw, 0);
    dropdata.dir = anglesToForward(dropdata.outangles);

    if(level.var_cb89daf3a1d3e761 && dropdata.ring < 1) {
      function_1b451ac8cf14a6a4(dropdata, dropstruct, baseorigin);
    }

    dropdata.outorigin = baseorigin + dropdata.dir * dropdata.dist;
    traceresults = function_9b539449b8809a8(dropstruct, dropdata, baseorigin, ignoreent, tracecontents, var_551904951118b7b9);

    if(traceresults["fraction"] >= var_daa047868cf7a01b) {
      return;
    }

    attempts++;
  }

  dropdata.ring = initialring;
  dropdata.ringslot = initialslot;
  dropdata.yaw = initialyaw;
  dropdata.dist = initialdist;
  dropdata.dir = initialdir;
  dropdata.outangles = var_f4a31528787ae6bd;
  dropdata.outorigin = var_9bd3420d924c5c43;
}

function private function_1bf026a5b9fdae23(dropstruct, dropdata, ignoreent, tracecontents, var_551904951118b7b9) {
  tracestart = dropdata.outorigin;
  traceend = dropdata.outorigin + (0, 0, 60);
  traceresults = trace::ray_trace(tracestart, traceend, ignoreent, tracecontents);

  if(var_551904951118b7b9) {
    function_d2d7b153b9d3889e(dropstruct.dropidx, "<dev string:xe49>", tracestart + (0, 1, 0), traceend + (0, 1, 0), traceresults);
  }

  if(traceresults["fraction"] < 1) {
    dropdata.outorigin = traceresults["position"] + (0, 0, -6);
  } else {
    dropdata.outorigin = traceend;
  }

  return traceresults;
}

function private function_2b84f1379888e314(dropstruct, dropdata, ignoreent, tracecontents, groundfloat, var_69f3e94ac253c6ab, var_551904951118b7b9) {
  tracestart = dropdata.outorigin;
  traceheight = default_to(var_69f3e94ac253c6ab, level.var_bb7795c61887fc81);
  var_3a7f0173b03f5767 = -1 * traceheight;
  traceend = dropdata.outorigin + (0, 0, var_3a7f0173b03f5767);
  traceresults = scripts\engine\trace::ray_trace(tracestart, traceend, ignoreent, tracecontents);

  if(var_551904951118b7b9) {
    function_d2d7b153b9d3889e(dropstruct.dropidx, "<dev string:xe4f>", tracestart, traceend, traceresults);
  }

  if(traceresults["fraction"] < 1) {
    dropdata.outorigin = traceresults["position"] + (0, 0, groundfloat);
    dropdata.groundentity = traceresults["entity"];

    if(isDefined(dropdata.groundentity) && (istrue(dropdata.groundentity.isdestroyed) || istrue(dropdata.groundentity.burningdown))) {
      ignorelist = [dropdata.groundentity];

      if(isDefined(ignoreent)) {
        ignorelist[ignorelist.size] = ignoreent;
      }

      traceresults = scripts\engine\trace::ray_trace(dropdata.outorigin, traceend, ignorelist, tracecontents);

      if(var_551904951118b7b9) {
        function_d2d7b153b9d3889e(dropstruct.dropidx, "<dev string:xe55>", dropdata.outorigin, traceend, traceresults);
      }

      if(traceresults["fraction"] < 1) {
        dropdata.outorigin = traceresults["position"] + (0, 0, groundfloat);
        dropdata.groundentity = traceresults["entity"];
      } else {
        if(var_551904951118b7b9) {
          println("<dev string:xdf9>" + dropstruct.dropidx + "<dev string:xe5c>");
        }

        dropdata.outorigin = (0, 0, 0);
        dropdata.noground = 1;
      }
    }
  } else {
    if(var_551904951118b7b9) {
      println("<dev string:xdf9>" + dropstruct.dropidx + "<dev string:xe5c>");
    }

    dropdata.outorigin = (0, 0, 0);
    dropdata.noground = 1;
  }

  return traceresults;
}

function private function_250558a79c78739e(origin, angles, payload, groundentity) {
  assert(isDefined(origin));
  dropinfo = spawnStruct();
  dropinfo.origin = origin;

  if(isDefined(angles)) {
    dropinfo.angles = angles;
  } else {
    dropinfo.angles = (0, 0, 0);
  }

  if(isDefined(payload)) {
    dropinfo.payload = payload;
  } else {
    dropinfo.payload = 0;
  }

  dropinfo.groundentity = groundentity;
  return dropinfo;
}

function function_d2d7b153b9d3889e(index, name, start, end, traceresults) {
  var_a16891a5162df351 = 2000;

  if(traceresults["<dev string:xe6b>"] < 1) {
    line(start, traceresults["<dev string:xe77>"], (1, 0, 0), 1, 0, var_a16891a5162df351);

    if(isDefined(traceresults["<dev string:xe83>"])) {
      selectedentity = traceresults["<dev string:xe83>"];
      println("<dev string:xdf9>" + index + "<dev string:xe8d>" + name + "<dev string:xe93>" + traceresults["<dev string:xe6b>"] + "<dev string:xe9c>" + traceresults["<dev string:xe77>"] + "<dev string:xea4>" + utility::default_to(selectedentity.name, "<dev string:x1e4>"));
    } else {
      println("<dev string:xdf9>" + index + "<dev string:xe8d>" + name + "<dev string:xe93>" + traceresults["<dev string:xe6b>"] + "<dev string:xe9c>" + traceresults["<dev string:xe77>"]);
    }

    return;
  }

  println("<dev string:xdf9>" + index + "<dev string:xe8d>" + name + "<dev string:xead>");
  line(start, end, (1, 1, 1), 1, 0, var_a16891a5162df351);
}

function function_2c836ad05e5f634c(ref) {
  if(!isDefined(level.var_782b4804d4e2d690)) {
    level.var_782b4804d4e2d690 = [];
  } else if(isDefined(level.var_782b4804d4e2d690[ref])) {
    return level.var_782b4804d4e2d690[ref];
  }

  lootinfo = getlootiteminfofromref(ref);

  if(!isDefined(lootinfo) || !isDefined(lootinfo.itemid)) {
    return undefined;
  }

  lootid = lootinfo.itemid;

  if(lootid == 0) {
    return undefined;
  }

  level.var_782b4804d4e2d690[ref] = lootid;
  return lootid;
}

function function_6d15e119c2779a93(itembundle) {
  if(!isDefined(itembundle)) {
    return undefined;
  }

  if(!isDefined(itembundle.ref)) {
    itembundlename = function_2cdc55ba39d97d70(itembundle.scriptable);
    assertmsg("<dev string:xeb9>" + itembundlename + "<dev string:xefa>");
    return undefined;
  }

  return function_2c836ad05e5f634c(itembundle.ref);
}

function function_b270e989412a5f67() {
  devgui::function_6e7290c8ee4f558b("<dev string:xf1c>");
  devgui::function_a9a864379a098ad6("<dev string:xf30>", "<dev string:xf45>", &draw_items, 1);
  devgui::function_a9a864379a098ad6("<dev string:xf60>", "<dev string:xf83>", &function_237a0fdd6c243aca);
  devgui::function_a9a864379a098ad6("<dev string:xfa6>", "<dev string:xfbb>", &cleanup_all_items);
  devgui::function_b23a59dfb4ca49a1("<dev string:xfdb>", "<dev string:xff8>", &function_dbbe2312a3bd6d8a);
  devgui::function_b23a59dfb4ca49a1("<dev string:x101d>", "<dev string:x103b>", &function_dbbe2312a3bd6d8a);
  devgui::function_fe953f000498048f();
}

function function_112c64fc568b602f(var_9ec97bdad14a0a5b) {
  if(getdvarint(@ "hash_10f0811105fc2f93", 0) == 0) {
    return;
  }

  item_bundle = getscriptbundlefieldvalues("<dev string:x1061>" + var_9ec97bdad14a0a5b, [#"type", #"subtype", #"scriptable"]);
  var_1c769e6e3f9771fc = "<dev string:xd83>";

  if(isDefined(item_bundle.type) && item_bundle.type != "<dev string:xd83>") {
    var_1c769e6e3f9771fc = item_bundle.type + "<dev string:x1074>";
  }

  var_1712f2a4cc83caf8 = "<dev string:xd83>";

  if(isDefined(item_bundle.subtype) && item_bundle.subtype != "<dev string:xd83>") {
    var_1712f2a4cc83caf8 = item_bundle.subtype + "<dev string:x1074>";
  }

  if(!isDefined(item_bundle.scriptable)) {
    return;
  }

  devgui::function_b23a59dfb4ca49a1("<dev string:x1079>" + var_1c769e6e3f9771fc + var_1712f2a4cc83caf8 + var_9ec97bdad14a0a5b, "<dev string:x1098>" + var_9ec97bdad14a0a5b, &function_f8162124bbb6ece3, 0, 0);
}

function private draw_items() {
  while(true) {
    items = scriptable_group::function_f8ecd6e02634e682("<dev string:x10a7>");

    if(isDefined(items)) {
      foreach(item in items) {
        sphere(item.origin, 10, (1, 0, 0), 1);
        line(item.origin, item.origin + (0, 0, 50), (1, 0, 0), 1, 1);
      }
    }

    waitframe();
  }
}

function private function_237a0fdd6c243aca() {
  level.var_f8a5820fe8fff0fd = !istrue(level.var_f8a5820fe8fff0fd);
  iprintlnbold(level.var_f8a5820fe8fff0fd ? "<dev string:x10b7>" : "<dev string:x10d8>");
}

function private function_4bc7f4cf12558446(origin, color, radius, depthtest, duration) {
  if(istrue(level.var_f8a5820fe8fff0fd)) {
    sphere(origin, color, radius, depthtest, duration);
  }
}

function private function_434cb1f9af023e71(start, end, color, alpha, depthtest, duration) {
  if(istrue(level.var_f8a5820fe8fff0fd)) {
    line(start, end, color, alpha, depthtest, duration);
  }
}

function function_f8162124bbb6ece3(params) {
  item_name = params[0];
  payload = params[1];

  if(isDefined(item_name) && item_name != "<dev string:xd83>") {
    if(isDefined(payload)) {
      payload = [#"teamselect", level.players[0] getentitynumber()];
    }

    foreach(var_b58ae7444b8d7baa, var_a59089e939dc706f in level.commonitem.var_970a8dd2fe7c510b) {
      if(item_name == var_a59089e939dc706f || item_name == var_b58ae7444b8d7baa) {
        itembundle = getscriptbundle("<dev string:x1061>" + var_a59089e939dc706f);
        function_c465d27f3f6066b4(itembundle, function_963151d62c29fc95(), undefined, 0, 0, payload);
        return;
      }
    }

    foreach(var_5dece42973125f56, var_a59089e939dc706f in level.commonitem.var_ec08d293dcc1ea4f) {
      if(item_name == var_a59089e939dc706f || item_name == var_5dece42973125f56) {
        itembundle = getscriptbundle("<dev string:x1061>" + var_a59089e939dc706f);
        function_c465d27f3f6066b4(itembundle, function_963151d62c29fc95(), undefined, 0, 0, payload);
        return;
      }
    }

    itembundle = getscriptbundle("<dev string:x1061>" + item_name);

    if(isDefined(itembundle)) {
      function_c465d27f3f6066b4(itembundle, function_963151d62c29fc95(), undefined, 0, 0, payload);
      return;
    }

    assertmsg("<dev string:x10fa>" + item_name + "<dev string:x1136>");
  }
}

function function_963151d62c29fc95() {
  if(level.players.size > 0) {
    player = level.players[0];
    forward = anglesToForward(player getplayerangles());
    drop_pos = player.origin + forward * 100;
    drop_pos = utility::drop_to_ground(drop_pos, 100) + (0, 0, 8);
    return drop_pos;
  }

  return (0, 0, 0);
}

function function_dbbe2312a3bd6d8a(params) {
  enabled = params[0] == "<dev string:x118e>";

  if(level.players.size > 0) {
    player = level.players[0];
    player_forward = anglesToForward(player getplayerangles());
    result = scripts\engine\trace::ray_trace(player getEye(), player getEye() + player_forward * 10000);

    if(isDefined(result["<dev string:xe77>"]) && isDefined(result["<dev string:xe6b>"]) && result["<dev string:xe6b>"] < 1) {
      cylinder(result["<dev string:xe77>"], result["<dev string:xe77>"] + (0, 0, 1), 32, (0, 1, 0), 0, 10);
      scriptables = getscriptablearrayinradius(undefined, undefined, result["<dev string:xe77>"], 32);
      scriptables = utility::array_combine(scriptables, getlootscriptablearrayinradius(undefined, undefined, result["<dev string:xe77>"], 32));

      if(scriptables.size == 0) {
        return;
      }

      foreach(scriptable in scriptables) {
        if(scriptable getscriptableisloot() && scriptable getscriptableisusableonanypart()) {
          if(enabled) {
            scriptable enablescriptableplayeruse(player);
            continue;
          }

          scriptable disablescriptableplayeruse(player);
        }
      }
    }
  }
}

function cleanup_all_items(params) {
  items = scriptable_group::function_f8ecd6e02634e682("<dev string:x10a7>");

  if(isDefined(items)) {
    foreach(item in items) {
      if(isDefined(item)) {
        function_c14962ea14e58968(item);
      }
    }
  }
}

# /