/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\loot\common_kiosk.gsc
***********************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\currency;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#namespace common_kiosk;

function init_kiosk() {
  level.var_989093b9a969783 = spawnStruct();
  level.var_989093b9a969783.scriptables = [];
  level.br_armory_kiosk_enabled = 0;
  level.var_11a3973390a71e8 = "";

  if(isDefined(level.gametypebundle) && istrue(level.gametypebundle.var_d651598a91f20ae3)) {
    level.br_armory_kiosk_enabled = istrue(level.gametypebundle.var_a005e276e98e5ed8);
    level.var_11a3973390a71e8 = level.gametypebundle.var_383d2fae80ff311e;
    setomnvar("ui_buy_mode", istrue(level.gametypebundle.var_5880a79f0328330b));
  }

  if(level.br_armory_kiosk_enabled) {
    level.var_e7cee4fbb5b46ef2 = scripts\cp_mp\utility\loot::function_54b046aa3ba2678a(level.var_11a3973390a71e8);
    scripts\engine\scriptable::scriptable_addusedcallback(&armorykioskused);
    scripts\engine\scriptable::scriptable_addautousecallback(&armorykioskused);
    registeronluieventcallbacksharedfunc(&onarmorykioskpurchase);
    level.var_d03e6ba38b56b4ab = getdvarint(@ "hash_e77ab3a32453ae92", 1);
    level.var_e9f7702d839b262c = getdvarint(@ "hash_624b1f6964c696d", 180);
    level.randomanglemax = getdvarint(@ "hash_69c62cae4d7929c9", 10);
    level.var_fb60f0244999d528 = getdvarint(@ "hash_9c3612143e0ad401", 1);
    instances = getallspawninstances();

    if(isDefined(level.var_738bfbedf3eeea26)) {
      [[level.var_738bfbedf3eeea26]](instances);
    } else {
      setspawninstances(instances);

      foreach(instance in instances) {
        function_51f6eab92b227b84(instance);
      }
    }

    function_b38f5ffe645943c3(level.var_11a3973390a71e8);
    _parsepurchaseitemtables();
  }
}

function function_b38f5ffe645943c3(stationref) {
  setDvar(@ "br_buy_station", stationref);
  level.var_e7cee4fbb5b46ef2 = scripts\cp_mp\utility\loot::function_54b046aa3ba2678a(stationref);

  if(!isDefined(level.var_6be7b375ec4a629c)) {
    level.var_6be7b375ec4a629c = [];
  }

  foreach(var_eb7139726cc569b5 in level.var_6be7b375ec4a629c) {
    if(var_eb7139726cc569b5["index"] == level.var_e7cee4fbb5b46ef2) {
      return;
    }
  }

  level.var_6be7b375ec4a629c[level.var_6be7b375ec4a629c.size] = function_d84cdb7463425ba(stationref);
}

function getallspawninstances() {
  if(!level.br_armory_kiosk_enabled) {
    return;
  }

  allspawninstances = getentitylessscriptablearray("scriptable_br_plunder_box", "classname");
  return allspawninstances;
}

function setspawninstances(instances) {
  assert(isarray(instances));
  level.var_989093b9a969783.scriptables = instances;
}

function function_51f6eab92b227b84(instance) {
  buystation = spawnscriptable("br_plunder_box", instance.origin, instance.angles);
  buystation setscriptablepartstate("br_plunder_box", "visible");
  buystation.visible = 1;
}

function function_3058b3e95a1bf984(instance, player) {
  if(istrue(level.gameended)) {
    return false;
  }

  if((!player scripts\cp_mp\utility\player_utility::_isalive() || istrue(player.inlaststand)) && !scripts\cp_mp\utility\game_utility::function_9cdaadfddeda4d7a()) {
    return false;
  }

  if(player scripts\common\utility::isusingremote()) {
    return false;
  }

  if(player scripts\cp_mp\utility\player_utility::isinvehicle()) {
    return false;
  }

  if(isDefined(player) && isDefined(player.var_e5520effcbe8bd30)) {
    return false;
  }

  if(istrue(player.iscarrying)) {
    player showerrormessagesharedfunc("MP/FIELD_UPGRADE_CANNOT_USE");
    return false;
  }

  return true;
}

function armorykioskused(instance, part, state, player, bautouse, usestring) {
  if(!function_1414925deba056bc(instance.type, "kiosk")) {
    return;
  }

  if(istrue(bautouse) && !function_7e0281196d6407c8()) {
    return;
  }

  if(!isDefined(player)) {
    player = self;
  }

  if(istrue(bautouse) && !isDefined(player.armorykioskpurchaseallowed)) {
    player.armorykioskpurchaseallowed = 0;
  }

  if(!function_3058b3e95a1bf984(instance, player)) {
    if(istrue(bautouse)) {
      player.armorykioskpurchaseallowed = 0;
    }

    return;
  }

  if(istrue(bautouse)) {
    if(!player.armorykioskpurchaseallowed) {
      function_28d837f720b03bfa(instance, player);
    }

    return;
  }

  if(istrue(player.insertingarmorplate)) {
    player notify("try_armor_cancel");
  }

  if(!isDefined(state)) {
    player thread _runpurchasemenu(instance);
    return;
  }

  if(state == "visible") {
    if(isDefined(instance)) {
      instance setscriptablepartstate("br_plunder_box", "opening");
      instance thread kioskfixupproneplayers();
    }

    player thread _runpurchasemenu(instance);
    return;
  }

  if(state == "opening" || state == "open") {
    player thread _runpurchasemenu(instance);
  }
}

function function_d84cdb7463425ba(var_9023cea8f03e72d2) {
  var_eb7139726cc569b5 = [];
  var_3d329ebb0d03d6db = scripts\cp_mp\utility\loot::function_54b046aa3ba2678a(var_9023cea8f03e72d2);
  var_eb7139726cc569b5["index"] = var_3d329ebb0d03d6db;
  var_eb7139726cc569b5["ref"] = var_9023cea8f03e72d2;
  var_eb7139726cc569b5["items"] = [];
  var_904eefa8f06ceecb = tablelookuprownum("mp/buyStation/buyStationDefs.csv", 0, var_3d329ebb0d03d6db);
  stationitem = tablelookupbyrow("mp/buyStation/buyStationDefs.csv", var_904eefa8f06ceecb, 3);
  itemindex = 0;

  while(stationitem != "") {
    itemcost = tablelookupbyrow("mp/buyStation/buyStationDefs.csv", var_904eefa8f06ceecb, 4 + 4 * itemindex);

    if(itemcost != "") {
      var_eb7139726cc569b5["items"][stationitem] = int(itemcost);
    } else {
      var_eb7139726cc569b5["items"][stationitem] = -1;
    }

    var_188ded2ca8751cee = function_93cabb608eabdb7c(stationitem);
    var_eb7139726cc569b5["items"][stationitem] = isDefined(var_188ded2ca8751cee) ? var_188ded2ca8751cee : var_eb7139726cc569b5["items"][stationitem];
    itemindex++;
    stationitem = tablelookupbyrow("mp/buyStation/buyStationDefs.csv", var_904eefa8f06ceecb, 3 + 4 * itemindex);
  }

  return var_eb7139726cc569b5;
}

function function_7e0281196d6407c8() {
  return getdvarint(@ "hash_1696df050ad70202", 0);
}

function _parsepurchaseitemtables() {
  if(!isDefined(level.var_6be7b375ec4a629c)) {
    level.var_6be7b375ec4a629c = [];
  }

  var_8c0c54c9e01403ca = getDvar(@ "scr_buy_station_pool");

  if(isDefined(var_8c0c54c9e01403ca) && var_8c0c54c9e01403ca != "") {
    var_3d321e8859561813 = array_randomize(strtok(var_8c0c54c9e01403ca, ","));

    for(var_3d329ebb0d03d6db = 0; var_3d329ebb0d03d6db < var_3d321e8859561813.size; var_3d329ebb0d03d6db++) {
      level.var_6be7b375ec4a629c[level.var_6be7b375ec4a629c.size] = function_d84cdb7463425ba(var_3d321e8859561813[var_3d329ebb0d03d6db]);
    }
  } else {
    level.var_6be7b375ec4a629c[level.var_6be7b375ec4a629c.size] = function_d84cdb7463425ba(level.var_11a3973390a71e8);
  }

  level.var_989093b9a969783.items = [];
  numrows = tablelookupgetnumrows("mp/buyStation/buyStationItems.csv");

  for(row = 0; row < numrows; row++) {
    itemindex = int(tablelookupbyrow("mp/buyStation/buyStationItems.csv", row, 0));
    assert(!isDefined(level.var_989093b9a969783.items[itemindex]));
    var_97642cc850f90ca0 = spawnStruct();
    itemref = tablelookupbyrow("mp/buyStation/buyStationItems.csv", row, 3);
    var_97642cc850f90ca0.entryref = tablelookupbyrow("mp/buyStation/buyStationItems.csv", row, 1);
    var_97642cc850f90ca0.type = tablelookupbyrow("mp/buyStation/buyStationItems.csv", row, 2);
    var_97642cc850f90ca0.ref = itemref;
    var_97642cc850f90ca0.cost = int(tablelookupbyrow("mp/buyStation/buyStationItems.csv", row, 4));
    var_97642cc850f90ca0.cost = default_to(function_93cabb608eabdb7c(var_97642cc850f90ca0.entryref), var_97642cc850f90ca0.cost);
    var_97642cc850f90ca0.firesalediscount = int(tablelookupbyrow("mp/buyStation/buyStationItems.csv", row, 10));
    var_97642cc850f90ca0.firesalediscount = default_to(function_57e6c79279b89596(var_97642cc850f90ca0.entryref), var_97642cc850f90ca0.firesalediscount);
    var_97642cc850f90ca0.perkdiscount = int(tablelookupbyrow("mp/buyStation/buyStationItems.csv", row, 11));
    var_97642cc850f90ca0.itemamount = int(tablelookupbyrow("mp/buyStation/buyStationItems.csv", row, 12));

    if(isDefined(var_97642cc850f90ca0.itemamount) && var_97642cc850f90ca0.itemamount > 0) {}

    level.var_989093b9a969783.items[itemindex] = var_97642cc850f90ca0;
  }
}

function kioskfixupproneplayers() {
  if(!getdvarint(@ "hash_636451c6314df097", 1)) {
    return;
  }

  radius = getdvarfloat(@ "hash_3990f3347374d18e", 300);
  closeplayers = sortbydistancecullbyradius(level.players, self.origin, radius);

  foreach(player in closeplayers) {
    if(!isDefined(player) || !isalive(player)) {
      continue;
    }

    if(player getstance() != "prone") {
      continue;
    }

    halfsize = player getboundshalfsize();
    radius = halfsize[0];
    height = 2 * halfsize[2];

    if(capsuletracepassed(player.origin, radius, height, undefined, 0, 0)) {
      continue;
    }

    player setstance("crouch", 1);
  }
}

function _runpurchasemenu(kiosk) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player endon("death");
  player.common_kiosk = kiosk;

  if(isDefined(level.var_6beff7b631ab7e18)) {
    [[level.var_6beff7b631ab7e18]](kiosk, player);
  }

  var_25fa7366933d59f2 = player hasperksharedfunc("specialty_br_cheaper_kiosk");
  var_19f9a8eac6699ca9 = getdvarint(@ "hash_b0634929cd39973b", 1);

  if(!isint(kiosk) && isDefined(kiosk.overrideindex)) {
    level.var_e7cee4fbb5b46ef2 = kiosk.overrideindex;
    player setclientomnvar("ui_buystation_override", kiosk.overrideindex);
  } else if(isDefined(level.var_4b3d0771df2c44a9) && !istrue(player.var_e5b7a6a0ec2b440e)) {
    level.var_e7cee4fbb5b46ef2 = level.var_4b3d0771df2c44a9;
    player setclientomnvar("ui_buystation_override", level.var_4b3d0771df2c44a9);
  }

  player setclientomnvar("ui_buystation_purchase_response", 0);
  openvalue = 0;

  if(istrue(player.common_kiosk.isdeployablekiosk)) {
    openvalue += 16;
  } else {
    openvalue += 2;
  }

  isfiresale = isDefined(player.common_kiosk) && iskioskfiresaleactiveforplayer(player.common_kiosk, player);

  if(isfiresale) {
    openvalue += 4;
  }

  player setclientomnvar("ui_buystation_open", openvalue);
  player.armorykioskpurchaseallowed = 1;
  player thread _watchtoautoclosemenu(kiosk);
}

function _watchtoautoclosemenu(kiosk) {
  player = self;
  player endon("disconnect");
  player notify("_watchToAutoCloseMenu_end");
  player endon("_watchToAutoCloseMenu_end");
  player childthread _proximitywatcher(kiosk);
  waittill_any_ents(player, "death", player, "last_stand_start", player, "pushed_too_far", level, "game_ended");
  player _closepurchasemenuwithresponse(2);
}

function function_28d837f720b03bfa(kiosk, player) {
  player.common_kiosk = kiosk;
  player.armorykioskpurchaseallowed = 1;
  player thread function_ab62cd6135dfe6(kiosk);
}

function function_ab62cd6135dfe6(kiosk) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player endon("death");
  player childthread function_59e987d44a301ef5(kiosk);
  waittill_any_ents(player, "last_stand_start", player, "exit_quick_purchase_zone");

  if(isDefined(player)) {
    player.armorykioskpurchaseallowed = 0;
  }
}

function function_59e987d44a301ef5(kiosk) {
  player = self;
  var_525b03beaf285c54 = getdvarint(@ "hash_c37f7e3bb9eca843", 0);
  maxdistsquared = var_525b03beaf285c54 * var_525b03beaf285c54;

  while(true) {
    if(!isDefined(kiosk) || distancesquared(player.origin, kiosk.origin) > maxdistsquared) {
      player notify("exit_quick_purchase_zone");
      break;
    }

    wait 0.1;
  }
}

function _proximitywatcher(kiosk) {
  player = self;
  var_23d839b7d0ace88a = 64;
  var_525b03beaf285c54 = getdvarfloat(@ "hash_ecd52993b5dab130", 128) + var_23d839b7d0ace88a;
  maxdistsquared = var_525b03beaf285c54 * var_525b03beaf285c54;

  while(true) {
    wait 0.1;
    var_77c977c78b3f7d84 = distancesquared(player.origin, kiosk.origin);

    if(var_77c977c78b3f7d84 > maxdistsquared) {
      player notify("pushed_too_far");
      break;
    }
  }
}

function _closepurchasemenuwithresponse(var_97aa74c2193a9dc6) {
  player = self;

  if(var_97aa74c2193a9dc6 == 1 && getdvarint(@ "hash_ed6e4ffa933af621", 0)) {
    return;
  }

  player setclientomnvar("ui_buystation_purchase_response", var_97aa74c2193a9dc6);
  player setclientomnvar("ui_buystation_open", 1);
  player setclientomnvar("ui_buystation_override", -1);
  scripts\cp_mp\vehicles\vehicle_interact::function_fed77cd5c54efe19(player.var_c77002478cdfd85f, player);
  player.common_kiosk = undefined;
  player.var_e5b7a6a0ec2b440e = undefined;
  player.var_c77002478cdfd85f = undefined;
  player.armorykioskpurchaseallowed = undefined;
}

function _purchasemenuclosedbyclient(player) {
  player _closepurchasemenuwithresponse(0);
  player notify("_watchToAutoCloseMenu_end");
}

function function_65b2a9d69f873524(itemref, player) {
  kioskindex = level.var_e7cee4fbb5b46ef2;

  if(isPlayer(player) && isDefined(player.common_kiosk) && isDefined(player.common_kiosk.overrideindex)) {
    kioskindex = player.common_kiosk.overrideindex;
  }

  foreach(var_eb7139726cc569b5 in level.var_6be7b375ec4a629c) {
    if(var_eb7139726cc569b5["index"] == kioskindex) {
      if(isDefined(var_eb7139726cc569b5["items"][itemref]) && var_eb7139726cc569b5["items"][itemref] > 0) {
        return var_eb7139726cc569b5["items"][itemref];
      }

      return undefined;
    }
  }
}

function _getactualcost(player, itemdata) {
  isfiresale = 0;

  if(isDefined(player.common_kiosk)) {
    isfiresale = iskioskfiresaleactiveforplayer(player.common_kiosk, player);
  }

  var_25fa7366933d59f2 = player hasperksharedfunc("specialty_br_cheaper_kiosk");
  finalcost = itemdata.cost;
  var_bbd3ced9f1e6acbf = function_65b2a9d69f873524(itemdata.entryref, player);

  if(isDefined(var_bbd3ced9f1e6acbf)) {
    finalcost = var_bbd3ced9f1e6acbf;
  }

  var_1a61fa389340ae66 = getdvarint(hashcat(@ "scr_", itemdata.ref, "_cost_override"), 0);

  if(var_1a61fa389340ae66 != 0) {
    finalcost = var_1a61fa389340ae66;
  }

  if(isfiresale) {
    return _applysalesdiscount(finalcost, itemdata.firesalediscount);
  } else if(istrue(var_25fa7366933d59f2)) {
    return _applysalesdiscount(finalcost, itemdata.perkdiscount);
  }

  return finalcost;
}

function _applysalesdiscount(originalprice, discount) {
  if(!isDefined(discount) || discount == 0) {
    return originalprice;
  } else if(discount == 100) {
    return 0;
  }

  fraction = (100 - discount) * 0.01;
  return int(floor(originalprice * fraction + 0.5));
}

function iskioskfiresaleactiveforplayer(kiosk, player) {
  if(isDefined(level.var_8337ff60938f1ed5) && [[level.var_8337ff60938f1ed5]](kiosk, player)) {
    return true;
  }

  return false;
}

function onarmorykioskpurchase(channel, purchaseindex) {
  player = self;
  kiosk = player.common_kiosk;

  if(!istrue(player.armorykioskpurchaseallowed)) {
    return;
  }

  if(channel == "br_cancel_purchase") {
    _purchasemenuclosedbyclient(player);
    return;
  }

  if(channel == "br_item_purchase") {
    itemindex = purchaseindex;
    assert(isDefined(level.var_989093b9a969783.items[itemindex]));
    itemdata = level.var_989093b9a969783.items[itemindex];
    cost = player _getactualcost(player, itemdata);
    cost *= default_to(level.gametypebundle.var_dc7ab0a22b829f8b, 10);
    var_fbe1c496c49a42bc = default_to(function_98aedb8cf660c612(itemdata.entryref), "essence");
    var_7dc72c180df9143b = undefined;

    if(player can_afford(var_fbe1c496c49a42bc, cost)) {
      itemtype = itemdata.type;

      if(itemtype == "fieldupgrade") {
        itemtype = "super";
      } else if(itemdata.entryref == "armorBundle") {
        itemtype = "armor";
        itemcallbacks = player scripts\cp_mp\loot\common_item::function_cca8bbe88a39ad41(itemtype);

        if([[itemcallbacks.var_381daafc5fc31b7f]]()) {
          fakeitem = spawnStruct();
          fakeitem.type = "brloot_armor_plate";
          fakeitem.count = 5;
          fakeitem.fromcache = 1;
          player[[itemcallbacks.usefunc]](undefined, fakeitem, 0);
          var_fbe1c496c49a42bc = default_to(function_98aedb8cf660c612(itemdata.entryref), "essence");
          player scripts\cp_mp\currency::function_a06aa3b8c98e131e(var_fbe1c496c49a42bc, cost, #"buystation", itemdata.entryref);

          if(!isDefined(self.pers["currency_spent"])) {
            self.pers["currency_spent"] = cost;
            return;
          }

          self.pers["currency_spent"] = self.pers["currency_spent"] + cost;
        }

        return;
      } else if(itemdata.entryref == "reviveToken") {
        var_7dc72c180df9143b = "brloot_self_revive";
      }

      var_3719061529ddd848 = default_to(var_7dc72c180df9143b, itemdata.ref);
      itembundlename = scripts\cp_mp\loot\common_item::function_61d960957fcf3ca0(var_3719061529ddd848);
      assertex(isDefined(itembundlename), "<dev string:x1c>" + var_3719061529ddd848 + "<dev string:x42>");
      itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
      scriptable_name = itembundle.scriptable;
      fakeitem = spawnStruct();
      fakeitem.type = scriptable_name;
      fakeitem.count = 1;
      fakeitem.fromcache = 1;

      if(isDefined(itembundle.spawncount)) {
        fakeitem.count = itembundle.spawncount;
      }

      lootid = scripts\cp_mp\loot\common_item::function_6d15e119c2779a93(itembundle);
      var_84ab4c28dc11052d = player scripts\cp_mp\loot\common_item::function_576728d3d4486bd6(fakeitem, 0, 1);

      if(!var_84ab4c28dc11052d) {
        player items_dropitem(itembundle, fakeitem.count);
      }

      player dlog_recordplayerevent("dlog_event_player_common_item", ["dropped", 0, "stowed", 0, "equipped", 0, "bought", lootid, "sold", 0, "type", itembundle.type, "from_cache", 0, "from_rift_reward", 0]);
      var_fbe1c496c49a42bc = default_to(function_98aedb8cf660c612(itemdata.entryref), "essence");
      player scripts\cp_mp\currency::function_a06aa3b8c98e131e(var_fbe1c496c49a42bc, cost, #"buystation", var_3719061529ddd848);

      if(!isDefined(self.pers["currency_spent"])) {
        self.pers["currency_spent"] = cost;
      } else {
        self.pers["currency_spent"] = self.pers["currency_spent"] + cost;
      }
    }

    return;
  }

  if(channel == "br_team_revive") {
    if(isDefined(level.var_6d368866ba58bb04)) {
      player thread[[level.var_6d368866ba58bb04]](purchaseindex);
    }

    return;
  }

  if(channel == "sell_item") {
    itemindex = scripts\cp_mp\loot\common_inventory::function_4953ec8e37aa67b8(purchaseindex);
    function_8e857ffadd6d1af2(self, itemindex);
    return;
  }

  if(channel == "sell_all_item") {
    itemindex = scripts\cp_mp\loot\common_inventory::function_4953ec8e37aa67b8(purchaseindex);
    function_8e857ffadd6d1af2(self, itemindex, 1);
    return;
  }

  if(channel == "sell_all_valuables") {
    for(itemindex = 0; itemindex < scripts\cp_mp\loot\common_inventory::function_1b35b10884bd8d67(); itemindex++) {
      function_8e857ffadd6d1af2(self, itemindex, 1);
    }
  }
}

function function_38859e49d1ac69a0(itemref) {
  var_5ef3cbc8ae1f14da = scripts\cp_mp\currency::function_2e815a7b6d0bbcf6();

  if(isDefined(var_5ef3cbc8ae1f14da) && isDefined(var_5ef3cbc8ae1f14da.var_36a99886b712dcc3)) {
    foreach(var_4badbf1f7702e897 in var_5ef3cbc8ae1f14da.var_36a99886b712dcc3) {
      if(isDefined(var_4badbf1f7702e897.var_3fd8eff0621723c9) && var_4badbf1f7702e897.var_3fd8eff0621723c9 == itemref) {
        return var_4badbf1f7702e897;
      }
    }
  }
}

function function_8e857ffadd6d1af2(player, itemslotindex, sellall) {
  lootid = scripts\cp_mp\loot\common_inventory::function_d870b2c45335bd88(itemslotindex);

  if(!isDefined(lootid) || lootid == 0) {
    return;
  }

  var_9fb3b576439ee3d = 1;
  quantity = scripts\cp_mp\loot\common_inventory::function_5ce7fe3dca9c1a22(itemslotindex);

  if(istrue(sellall)) {
    var_9fb3b576439ee3d = quantity;
  }

  itembundle = scripts\cp_mp\loot\common_item::function_f4a303d532b044a7(lootid);

  if(!isDefined(itembundle)) {
    return;
  }

  itemref = itembundle.ref;
  var_b1f734ded9a2721a = function_38859e49d1ac69a0(itemref);

  if(isDefined(itemref) && isDefined(var_b1f734ded9a2721a) && isDefined(var_b1f734ded9a2721a.var_af40863a32d7792b)) {
    gametypebundle = getgametypescriptbundle();
    cashmultiplier = isDefined(gametypebundle.var_dc7ab0a22b829f8b) ? gametypebundle.var_dc7ab0a22b829f8b : 1;
    cashvalue = var_9fb3b576439ee3d * var_b1f734ded9a2721a.var_af40863a32d7792b * cashmultiplier;
    var_74806f0c4caa7e55 = var_9fb3b576439ee3d;
    player dlog_recordplayerevent("dlog_event_player_common_item", ["dropped", 0, "stowed", 0, "equipped", 0, "bought", 0, "sold", lootid, "type", itembundle.type, "from_cache", 0, "from_rift_reward", 0]);
    currencybundle = scripts\cp_mp\currency::function_7714028270738890(var_b1f734ded9a2721a.var_38d055f24fe64e71);

    if(isDefined(currencybundle)) {
      player scripts\cp_mp\currency::function_3036cef61495210f(currencybundle.currencyname, cashvalue, #"sold");
    }

    player scripts\cp_mp\loot\common_inventory::function_ca3bbb1070436540(itemslotindex, lootid, quantity - var_74806f0c4caa7e55);
    params = spawnStruct();
    params.bundle = function_f4a303d532b044a7(lootid);
    params.ref = itemref;
    params.value = cashvalue;
    params.var_6d5e047412a465f6 = var_9fb3b576439ee3d;
    params.lootid = lootid;
    player callback::callback("kiosk_item_sold", params);
  }
}