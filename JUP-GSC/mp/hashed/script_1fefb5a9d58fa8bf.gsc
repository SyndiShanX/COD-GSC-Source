/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1fefb5a9d58fa8bf.gsc
*************************************************/

#using script_12668187dcf15b96;
#using script_2d9d24f7c63ac143;
#using script_3bf3f0172d4a2247;
#using script_6fc415ff6a905dc1;
#using script_b7a9ce0a2282b79;
#using scripts\cp_mp\utility\loot;
#using scripts\mp\gametypes\br_analytics;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#namespace namespace_55d169675fb220b4;

function private function_d220ff97de9bb9e9(lootid, var_a06806243448e2c7) {
  if(getdvarint(@ "hash_fb7f8a822cd99fc", 1) == 0) {
    return false;
  }

  var_f9b6541ac6e9f8b9 = scripts\mp\gametypes\br_pickups::isvaluable(var_a06806243448e2c7) || scripts\mp\gametypes\br_pickups::ispersonal(var_a06806243448e2c7);

  if(!var_f9b6541ac6e9f8b9) {
    return false;
  }

  if(function_10440574d3361667(lootid) <= 0) {
    return false;
  }

  var_c899bf54d501193c = ["brloot_valuable_goldbar"];

  foreach(entry in var_c899bf54d501193c) {
    if(entry == var_a06806243448e2c7) {
      return false;
    }
  }

  return true;
}

function private setbackpackitem(lootid, pickup) {
  if(function_d220ff97de9bb9e9(lootid, pickup.scriptablename)) {
    var_95ba1f30ea5d8a76 = function_10440574d3361667(lootid);
    totalcashvalue = var_95ba1f30ea5d8a76 * pickup.count;
    scripts\mp\gametypes\br_plunder::playerplunderpickup(totalcashvalue);
    scripts\mp\gametypes\br_analytics::trackcashevent(self, "loot", totalcashvalue);
    return 0;
  }

  if(scripts\mp\gametypes\br_pickups::function_9e686ab118ac7725(pickup.scriptablename)) {
    namespace_5aecb7b921208f15::function_94a5ca57b9bc1d23(pickup);
    return 0;
  }

  return -1;
}

function private shouldrevokebackpackitemonexfil(var_25978461c6e4f61b) {
  return !(scripts\mp\gametypes\br_pickups::iskey(var_25978461c6e4f61b) || scripts\mp\gametypes\br_pickups::function_a38e261031751c09(var_25978461c6e4f61b) || scripts\mp\gametypes\br_pickups::function_16a5ebe82e3f2286(var_25978461c6e4f61b) || scripts\mp\gametypes\br_pickups::function_b989edd9af4f42c7(var_25978461c6e4f61b) || scripts\mp\gametypes\br_pickups::function_d7c5786a0c42ef6c(var_25978461c6e4f61b) || scripts\mp\gametypes\br_pickups::issuperpickup(var_25978461c6e4f61b) || scripts\mp\gametypes\br_pickups::iskillstreak(var_25978461c6e4f61b));
}

function private canitemfitinbackpack(lootid, var_a06806243448e2c7, quantity, maxcount) {
  if(function_d220ff97de9bb9e9(lootid, var_a06806243448e2c7)) {
    return 1;
  }

  return undefined;
}

function private getautopickupquantity(lootid, var_a06806243448e2c7, quantity, maxcount) {
  if(function_d220ff97de9bb9e9(lootid, var_a06806243448e2c7)) {
    return 0;
  }

  return undefined;
}

function init() {
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("setBackpackItem", &setbackpackitem);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("getAutoPickupQuantity", &getautopickupquantity);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("canItemFitInBackpack", &canitemfitinbackpack);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("shouldRevokeBackpackItemOnExfil", &shouldrevokebackpackitemonexfil);

  if(namespace_a38a2e1fe7519183::function_e0fc1230452cf4e7()) {
    function_d2c13fc95e4e8962(1);
    namespace_a38a2e1fe7519183::init();
  }

  function_225667c119b5512d();
}

function function_c227bd210d16e07c(player, context) {
  namespace_36be7f9eab6ca7bc::function_e1b1d2af636da618("EXGM Inventory (finalizeInstanceInventory): player='%s' context='%s', .inventoryFinalized='%s', .extracted='%s'", player.name, context, player.var_84d661ff601a2f9f, player.extracted);
  scripts\mp\gametypes\br_gametype_dmz::function_c227bd210d16e07c(player);
}

function private function_63bffcbc307b499() {}

function oninfil(player) {
  namespace_36be7f9eab6ca7bc::function_e1b1d2af636da618("EXGM Inventory (onInfil): player '%s' BEGIN", player.name);

  if(namespace_a38a2e1fe7519183::function_e0fc1230452cf4e7()) {
    namespace_b16531563568eaba::function_33366ade5697aa38(player);
    namespace_b16531563568eaba::function_8d65122ea2e88ecd(player);

    namespace_36be7f9eab6ca7bc::function_e1b1d2af636da618("<dev string:x1c>", player.name);
    player namespace_a38a2e1fe7519183::function_e64d9a42c66018c9(player);
  }

  var_78311d69ed34c252 = function_d5a68db48f43ba18(player);

  foreach(itemsource, itemlist in var_78311d69ed34c252) {
    foreach(item in itemlist) {
      scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(item.lootid);
      namespace_36be7f9eab6ca7bc::function_e1b1d2af636da618("<dev string:x64>", player.name, item.quantity, scriptablename, item.lootid, itemsource);
    }
  }

  var_a14b720d29c34b48 = function_d4da37abcaec5fca(var_78311d69ed34c252);
  player dlog_recordplayerevent("dlog_event_exgm_player_infil", ["inventory", var_a14b720d29c34b48.totalitems, "inventory_quantity", var_a14b720d29c34b48.var_c03ff9876291acd3, "infil_pos_x", player.origin[0], "infil_pos_y", player.origin[1], "infil_pos_z", player.origin[2]]);
  namespace_36be7f9eab6ca7bc::function_e1b1d2af636da618("EXGM Inventory (onInfil): player '%s' END", player.name);
}

function function_8b39e363ca709341() {
  if(namespace_a38a2e1fe7519183::function_e0fc1230452cf4e7()) {
    namespace_a38a2e1fe7519183::function_c1bb256c7473f345(self);
    return;
  }

  namespace_aead94004cf4c147::function_bab1a10b3fdaae51();
  namespace_aead94004cf4c147::function_590202daf6a1d4d7(self);
}

function onsuccessfulextract(player) {
  namespace_36be7f9eab6ca7bc::function_e1b1d2af636da618("EXGM Inventory (onSuccessfulExtract): player '%s' BEGIN", player.name);

  if(namespace_a38a2e1fe7519183::function_e0fc1230452cf4e7()) {
    namespace_36be7f9eab6ca7bc::function_e1b1d2af636da618("<dev string:xbc>", player.name);
    player namespace_a38a2e1fe7519183::function_e64d9a42c66018c9(player);
  }

  var_78311d69ed34c252 = function_d5a68db48f43ba18(player);
  totalcashvalue = function_dfa39169979c22d8(player, var_78311d69ed34c252);
  var_a14b720d29c34b48 = function_d4da37abcaec5fca(var_78311d69ed34c252);
  player dlog_recordplayerevent("dlog_event_exgm_player_exfil", ["total_cash_value", totalcashvalue, "cash", player.plundercount, "inventory", var_a14b720d29c34b48.totalitems, "inventory_quantity", var_a14b720d29c34b48.var_c03ff9876291acd3, "exfil_pos_x", player.origin[0], "exfil_pos_y", player.origin[1], "exfil_pos_z", player.origin[2]]);
  function_c227bd210d16e07c(player, "onSuccessfulExtract");
  namespace_36be7f9eab6ca7bc::function_e1b1d2af636da618("EXGM Inventory (onSuccessfulExtract): player '%s' END", player.name);
}

function private function_d5a68db48f43ba18(player) {
  itemsources = [];
  itemsources["loadout"] = player namespace_512200f0f9e6ebc9::snapshotinventory();
  itemsources["backpack"] = player namespace_aead94004cf4c147::snapshotbackpack();
  return itemsources;
}

function private function_d4da37abcaec5fca(var_78311d69ed34c252) {
  result = spawnStruct();
  result.totalitems = [];
  result.var_c03ff9876291acd3 = [];

  foreach(itemlist in var_78311d69ed34c252) {
    foreach(item in itemlist) {
      scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(item.lootid);

      if(isDefined(scriptablename)) {
        result.totalitems[result.totalitems.size] = scriptablename;
      } else {
        result.totalitems[result.totalitems.size] = "Invalid scriptable name, loot ID: " + item.lootid;
      }

      result.var_c03ff9876291acd3[result.var_c03ff9876291acd3.size] = item.quantity;
    }
  }

  assert(result.totalitems.size < 21);
  return result;
}

function private function_dfa39169979c22d8(player, var_78311d69ed34c252) {
  namespace_36be7f9eab6ca7bc::function_e1b1d2af636da618("EXGM Inventory (sellPlayerItems): player '%s' BEGIN", player.name);
  totalcashvalue = 0;
  namespace_36be7f9eab6ca7bc::function_e1b1d2af636da618("EXGM Inventory (sellPlayerItems): player '%s' had $%s loose cash", player.name, player.plundercount);
  totalcashvalue += player.plundercount;
  player setplayerdata("jupiter_exgm", "lootedCash", player.plundercount);

  foreach(itemsource, itemlist in var_78311d69ed34c252) {
    foreach(item in itemlist) {
      scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(item.lootid);
      var_38aa5958a501629d = isDefined(scriptablename) && (scripts\mp\gametypes\br_pickups::isvaluable(scriptablename) || scripts\mp\gametypes\br_pickups::ispersonal(scriptablename));

      if(!var_38aa5958a501629d) {
        itemtype = undefined;

        if(isDefined(scriptablename)) {
          itemtype = level.br_pickups.br_itemtype[scriptablename];
        }

        namespace_36be7f9eab6ca7bc::function_e1b1d2af636da618("<dev string:x110>", scriptablename, item.lootid, itemsource, player.name, itemtype);

        continue;
      }

      var_95ba1f30ea5d8a76 = function_10440574d3361667(item.lootid);
      var_12740f4650a020e2 = var_95ba1f30ea5d8a76 * item.quantity;
      totalcashvalue += var_12740f4650a020e2;

      namespace_36be7f9eab6ca7bc::function_e1b1d2af636da618("<dev string:x18c>", player.name, item.quantity, scriptablename, item.lootid, itemsource, var_12740f4650a020e2, var_95ba1f30ea5d8a76, item.quantity);
    }
  }

  function_b59c29bc25734ddf(player, totalcashvalue);
  namespace_36be7f9eab6ca7bc::function_e1b1d2af636da618("EXGM Inventory (sellPlayerItems): player '%s' END", player.name);
  return totalcashvalue;
}

function function_10440574d3361667(lootid) {
  scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);

  if(!isDefined(scriptablename)) {
    return 0;
  }

  cashvalue = level.br_pickups.br_value[scriptablename];

  if(!isDefined(cashvalue)) {
    return 0;
  }

  return cashvalue;
}

function private function_1c18fdd44dc52444() {}

function function_d5fef0fcb4508f0a(player) {
  var_9384de78bb3039fb = player getplayerdata("jupiter_exgm", "dollars");
  return var_9384de78bb3039fb;
}

function function_56476767182e6c0e(player, var_68a57894bd5c848) {
  namespace_36be7f9eab6ca7bc::function_e1b1d2af636da618("EXGM Inventory (setWalletAmount): player '%s', newWalletAmount=%s", player.name, var_68a57894bd5c848);
  player setplayerdata("jupiter_exgm", "dollars", var_68a57894bd5c848);
}

function function_b59c29bc25734ddf(player, var_64ad08fc292d8716) {
  var_9384de78bb3039fb = function_d5fef0fcb4508f0a(player);
  var_68a57894bd5c848 = var_9384de78bb3039fb + var_64ad08fc292d8716;

  if(var_68a57894bd5c848 < 0) {
    var_68a57894bd5c848 = 0;
  }

  namespace_36be7f9eab6ca7bc::function_e1b1d2af636da618("EXGM Inventory (adjustWalletAmount): player '%s', cur=%s delta=%s new=%s", player.name, var_9384de78bb3039fb, var_64ad08fc292d8716, var_68a57894bd5c848);
  function_56476767182e6c0e(player, var_68a57894bd5c848);
}

function private function_7d2c407c71fe805b() {}

function function_a2415c12f0dccc7b(player, var_2b465f51da1e8fcf, var_2b465e51da1e8d9c, var_6b92729cd2d4b6a6) {
  tabletitle = "<dev string:x20a>" + player.name;
  var_cd8110645a9a2632 = ["<dev string:x220>", "<dev string:x229>", "<dev string:x233>", "<dev string:x241>", "<dev string:x24d>", "<dev string:x25f>"];
  var_871bdbc7e5abb341 = [];

  for(i = 0; i < 50; i++) {
    lootid = player getplayerdata(level.progressiongroup, "<dev string:x268>", i, "<dev string:x278>");
    quantity = player getplayerdata(level.progressiongroup, "<dev string:x268>", i, "<dev string:x282>");
    lootedquantity = player getplayerdata(level.progressiongroup, "<dev string:x268>", i, "<dev string:x28e>");
    scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);
    value = function_10440574d3361667(lootid);
    var_871bdbc7e5abb341[var_871bdbc7e5abb341.size] = [i, lootid, scriptablename, quantity, lootedquantity, value];
  }

  textcolor = (1, 0, 0);
  textscale = 1;
  return namespace_36be7f9eab6ca7bc::function_b1ea22d278623807(var_2b465f51da1e8fcf, var_2b465e51da1e8d9c, tabletitle, var_cd8110645a9a2632, var_871bdbc7e5abb341, textcolor, textscale, var_6b92729cd2d4b6a6);
}

function function_408da9b4e0f08fb2(player, var_2b465f51da1e8fcf, var_2b465e51da1e8d9c, var_6b92729cd2d4b6a6) {
  tabletitle = "<dev string:x2a0>" + player.name;
  var_cd8110645a9a2632 = ["<dev string:x220>", "<dev string:x229>", "<dev string:x233>", "<dev string:x241>", "<dev string:x25f>"];
  var_871bdbc7e5abb341 = [];
  backpackcontents = player namespace_aead94004cf4c147::snapshotbackpack();

  foreach(item in backpackcontents) {
    var_d53771808585d4da = scripts\cp_mp\utility\loot::getscriptablefromlootid(item.lootid);
    itemvalue = function_10440574d3361667(item.lootid);
    var_871bdbc7e5abb341[var_871bdbc7e5abb341.size] = [item.index, item.lootid, var_d53771808585d4da, item.quantity, itemvalue];
  }

  textcolor = (1, 0, 0);
  textscale = 1;
  return namespace_36be7f9eab6ca7bc::function_b1ea22d278623807(var_2b465f51da1e8fcf, var_2b465e51da1e8d9c, tabletitle, var_cd8110645a9a2632, var_871bdbc7e5abb341, textcolor, textscale, var_6b92729cd2d4b6a6);
}

function function_3d87fb81fa720ae2(player, var_2b465f51da1e8fcf, var_2b465e51da1e8d9c, var_6b92729cd2d4b6a6) {
  tabletitle = "<dev string:x2b1>" + player.name;
  var_cd8110645a9a2632 = ["<dev string:x229>", "<dev string:x233>", "<dev string:x241>", "<dev string:x25f>"];
  var_871bdbc7e5abb341 = [];
  loadoutcontents = player namespace_512200f0f9e6ebc9::snapshotinventory();

  foreach(item in loadoutcontents) {
    var_d53771808585d4da = scripts\cp_mp\utility\loot::getscriptablefromlootid(item.lootid);
    itemvalue = function_10440574d3361667(item.lootid);
    var_871bdbc7e5abb341[var_871bdbc7e5abb341.size] = [item.lootid, var_d53771808585d4da, item.quantity, itemvalue];
  }

  textcolor = (1, 0, 0);
  textscale = 1;
  return namespace_36be7f9eab6ca7bc::function_b1ea22d278623807(var_2b465f51da1e8fcf, var_2b465e51da1e8d9c, tabletitle, var_cd8110645a9a2632, var_871bdbc7e5abb341, textcolor, textscale, var_6b92729cd2d4b6a6);
}

function private function_7262087a8dc78555() {}

function private function_225667c119b5512d() {}

# /