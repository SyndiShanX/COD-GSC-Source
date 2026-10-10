/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\armory_kiosk.gsc
***********************************************/

#using script_16ea1b94f0f381b3;
#using script_757c9ac43a532dac;
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\cp\cp_hud_util;
#using scripts\cp\cp_objectives;
#using scripts\cp\pickups;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\omnvar_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_airdrop;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#namespace armory_kiosk;

function init() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0)) {
    return;
  }

  if(level.createfx_enabled) {
    return;
  }

  if(isDefined(level.br_armory_kiosk)) {
    return;
  }

  setDvar(@ "br_buy_station", "cp_core");
  level.br_armory_kiosk = spawnStruct();
  level.br_armory_kiosk.scriptables = [];
  level.br_armory_kiosk_enabled = getdvarint(@ "scr_br_armory_kiosk", 1);
  level.var_11a3973390a71e8 = getDvar(@ "br_buy_station", "cp_core");
  level.var_e7cee4fbb5b46ef2 = scripts\cp_mp\utility\loot::function_54b046aa3ba2678a(level.var_11a3973390a71e8);

  if(level.br_armory_kiosk_enabled) {
    scripts\engine\scriptable::scriptable_addusedcallback(&armorykioskused);
    scripts\engine\scriptable::scriptable_addautousecallback(&armorykioskused);
    function_9bc69c26770d9533(&onarmorykioskpurchase);
    level.var_d03e6ba38b56b4ab = getdvarint(@ "hash_e77ab3a32453ae92", 1);
    level.var_e9f7702d839b262c = getdvarint(@ "hash_624b1f6964c696d", 180);
    level.randomanglemax = getdvarint(@ "hash_69c62cae4d7929c9", 10);
    level.var_fb60f0244999d528 = getdvarint(@ "hash_9c3612143e0ad401", 1);
    _initsalesdiscount();
    _parsepurchaseitemtables();
    level thread _watchforcircleclosure();

    level thread function_54fdd9330a3bed3e();

    namespace_2f242676eb49ca88::kiosk_init();

    if(isDefined(level.vehicle) && isDefined(level.vehicle.instances)) {
      scripts\cp_mp\vehicles\vehicle_tracking::function_5c8408cb68649308("veh9_jltv_mg", "KIOSK", 5);
    }
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

function _initignoredtabspergamemode() {
  if(getDvar(@ "hash_7611a2790a0bf7fe", "") == "plunder" || getDvar(@ "hash_7611a2790a0bf7fe", "") == "risk") {
    setDvar(@ "br_kiosk_ignored_tab_nums", "2,5");
    return;
  }

  setDvar(@ "br_kiosk_ignored_tab_nums", "3,4,5");
}

function _initsalesdiscount() {
  var_db834d1cac99ea96 = getdvarint(@ "br_kiosk_sales_discount", 0);
  level.br_armory_kiosk.sales_discount = int(clamp(var_db834d1cac99ea96, 0, 100));
  var_bc97c6f634d832a0 = getDvar(@ "hash_68eb502c50f9a22", "");
  level.br_armory_kiosk.sales_discount_items = strtok(var_bc97c6f634d832a0, ",");
  var_997f4424a87b464e = 20;
  var_f587fa837f6bf48f = level.br_armory_kiosk.sales_discount % var_997f4424a87b464e;

  if(var_f587fa837f6bf48f > 0) {
    var_9a7512c4544fd449 = int(floor(level.br_armory_kiosk.sales_discount / var_997f4424a87b464e) * var_997f4424a87b464e);
    var_50c417a2a6400d = var_f587fa837f6bf48f / var_997f4424a87b464e >= 0.5;

    if(var_50c417a2a6400d) {
      var_9a7512c4544fd449 += var_997f4424a87b464e;
    }

    level.br_armory_kiosk.sales_discount = int(var_9a7512c4544fd449);
  }

  if(var_db834d1cac99ea96 != level.br_armory_kiosk.sales_discount) {
    setDvar(@ "br_kiosk_sales_discount", level.br_armory_kiosk.sales_discount);
    assertmsg("Supply station discount value [" + var_db834d1cac99ea96 + "] is potentially dangerous, converted to [" + level.br_armory_kiosk.sales_discount + "].");
  }
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

function function_ac84b48bb39d674f(kiosk) {
  if(getdvarint(@ "hash_b0634929cd39973b", 1) == 0) {
    return false;
  }

  if(!isDefined(kiosk) || !isDefined(kiosk.index)) {
    return false;
  }

  if(!isDefined(level.var_6be7b375ec4a629c)) {
    return false;
  }

  if(!isDefined(level.var_44235d71492fa1a5)) {
    level.var_44235d71492fa1a5 = [];
  }

  if(isDefined(level.var_44235d71492fa1a5[kiosk.index])) {
    return true;
  }

  foreach(var_eb7139726cc569b5 in level.var_6be7b375ec4a629c) {
    if(var_eb7139726cc569b5["index"] == level.var_e7cee4fbb5b46ef2) {
      level.var_44235d71492fa1a5[kiosk.index] = [];

      foreach(var_cf29bd90372e77 in var_eb7139726cc569b5["items"]) {
        level.var_44235d71492fa1a5[kiosk.index][var_541fd62b8d9c236d] = var_cf29bd90372e77["defaultStock"];
      }

      return true;
    }
  }

  return false;
}

function function_6af40e269aae683e(kiosk, var_cf9d634ef87d898b) {
  if(!function_ac84b48bb39d674f(kiosk)) {
    return undefined;
  }

  return level.var_44235d71492fa1a5[kiosk.index][var_cf9d634ef87d898b];
}

function function_b88d64cd67bbe60f(kiosk) {
  if(!function_ac84b48bb39d674f(kiosk)) {
    return undefined;
  }

  itemspacked = 0;
  var_89ffab3d9d3c9cdd = 0;

  foreach(var_e5b48212891e8513 in level.var_44235d71492fa1a5[kiosk.index]) {
    if(isDefined(var_e5b48212891e8513)) {
      assert(0 <= var_e5b48212891e8513 && var_e5b48212891e8513 <= 3);
      assert(itemspacked < 16);
      var_89ffab3d9d3c9cdd |= var_e5b48212891e8513 << 2 * itemspacked;
      itemspacked++;
    }
  }

  return var_89ffab3d9d3c9cdd;
}

function function_469cfcbc4a5185c1(kiosk, var_cf9d634ef87d898b) {
  if(!function_ac84b48bb39d674f(kiosk)) {
    return;
  }

  itemstock = level.var_44235d71492fa1a5[kiosk.index][var_cf9d634ef87d898b];

  if(isDefined(itemstock)) {
    level.var_44235d71492fa1a5[kiosk.index][var_cf9d634ef87d898b] = ter_op(itemstock > 0, itemstock - 1, 0);
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
  var_ac75b489772f26ce = 4 * itemindex;

  while(stationitem != "") {
    assert(!isDefined(var_eb7139726cc569b5["<dev string:x1c>"][stationitem]));
    itemcost = tablelookupbyrow("mp/buyStation/buyStationDefs.csv", var_904eefa8f06ceecb, 4 + var_ac75b489772f26ce);
    var_685cb12f08da73b = tablelookupbyrow("mp/buyStation/buyStationDefs.csv", var_904eefa8f06ceecb, 5 + var_ac75b489772f26ce);
    itemhidden = tablelookupbyrow("mp/buyStation/buyStationDefs.csv", var_904eefa8f06ceecb, 6 + var_ac75b489772f26ce);
    var_eb7139726cc569b5["items"][stationitem] = [];

    if(itemcost != "") {
      var_eb7139726cc569b5["items"][stationitem]["cost"] = int(itemcost);
    } else {
      var_eb7139726cc569b5["items"][stationitem]["cost"] = -1;
    }

    if(var_685cb12f08da73b != "") {
      var_685cb12f08da73b = int(var_685cb12f08da73b);

      if(0 <= var_685cb12f08da73b && var_685cb12f08da73b <= 3) {
        var_eb7139726cc569b5["items"][stationitem]["defaultStock"] = var_685cb12f08da73b;
      } else {
        var_eb7139726cc569b5["items"][stationitem]["defaultStock"] = randomintrange(0, 3);
      }
    } else {
      var_eb7139726cc569b5["items"][stationitem]["defaultStock"] = undefined;
    }

    if(itemhidden != "") {
      var_eb7139726cc569b5["items"][stationitem]["hidden"] = int(itemhidden);
    } else {
      var_eb7139726cc569b5["items"][stationitem]["hidden"] = 0;
    }

    itemindex++;
    var_ac75b489772f26ce = 4 * itemindex;
    stationitem = tablelookupbyrow("mp/buyStation/buyStationDefs.csv", var_904eefa8f06ceecb, 3 + var_ac75b489772f26ce);
  }

  return var_eb7139726cc569b5;
}

function function_fe176342ed52b44f(itemref) {
  return int(tablelookup("cp/buyStation/buyStationItems.csv", 1, itemref, 0));
}

function function_517b8730ddec7f59(itemref) {
  return int(tablelookup("cp/buyStation/buyStationItems.csv", 1, itemref, 4));
}

function function_7e0281196d6407c8() {
  return getdvarint(@ "hash_1696df050ad70202", 0);
}

function private function_4d81ae9cb22f4180(dvar, backupref) {
  var_c95404cd83f761b6 = [];
  var_fffdbfff87ab6316 = getDvar(dvar);

  if(isDefined(var_fffdbfff87ab6316) && var_fffdbfff87ab6316 != "") {
    var_3d321e8859561813 = [];
    var_3d08c62a01a4bedd = strtok(var_fffdbfff87ab6316, ",");

    if(var_3d08c62a01a4bedd.size == 2 && (int(var_3d08c62a01a4bedd[0]) || int(var_3d08c62a01a4bedd[1]))) {
      var_919b9496930895b6 = int(var_3d08c62a01a4bedd[0]);
      var_36336cefcad243f5 = int(var_3d08c62a01a4bedd[1]);

      for(var_c5dcc7e2f341bf0b = var_919b9496930895b6; var_c5dcc7e2f341bf0b <= var_36336cefcad243f5; var_c5dcc7e2f341bf0b++) {
        var_904eefa8f06ceecb = tablelookuprownum("mp/buyStation/buyStationDefs.csv", 0, var_c5dcc7e2f341bf0b);

        if(var_904eefa8f06ceecb != -1) {
          var_9023cea8f03e72d2 = tablelookupbyrow("mp/buyStation/buyStationDefs.csv", var_904eefa8f06ceecb, 1);

          if(var_9023cea8f03e72d2 != "") {
            var_3d321e8859561813[var_3d321e8859561813.size] = var_9023cea8f03e72d2;
          }
        }
      }
    } else {
      var_3d321e8859561813 = var_3d08c62a01a4bedd;
    }

    var_3d321e8859561813 = array_randomize(var_3d321e8859561813);

    for(var_3d329ebb0d03d6db = 0; var_3d329ebb0d03d6db < var_3d321e8859561813.size; var_3d329ebb0d03d6db++) {
      var_c95404cd83f761b6[var_c95404cd83f761b6.size] = function_d84cdb7463425ba(var_3d321e8859561813[var_3d329ebb0d03d6db]);
    }
  } else if(isDefined(backupref)) {
    var_c95404cd83f761b6[var_c95404cd83f761b6.size] = function_d84cdb7463425ba(backupref);
  }

  return var_c95404cd83f761b6;
}

function _parsepurchaseitemtables() {
  if(!isDefined(level.var_6be7b375ec4a629c)) {
    level.var_6be7b375ec4a629c = function_4d81ae9cb22f4180(@ "scr_buy_station_pool", level.var_11a3973390a71e8);
  }

  if(!isDefined(level.var_3899105ceec08fb8)) {
    level.var_3899105ceec08fb8 = function_4d81ae9cb22f4180(@ "hash_f4138ad8e0de3ac6");
  }

  level.br_armory_kiosk.items = [];
  table = "cp/buyStation/buyStationItems.csv";
  numrows = tablelookupgetnumrows(table);

  for(row = 0; row < numrows; row++) {
    itemindex = int(tablelookupbyrow(table, row, 0));
    assert(!isDefined(level.br_armory_kiosk.items[itemindex]));

    if(itemindex == 51) {
      test = 1;
    }

    var_97642cc850f90ca0 = spawnStruct();
    itemref = tablelookupbyrow(table, row, 3);
    var_97642cc850f90ca0.entryref = tablelookupbyrow(table, row, 1);
    var_97642cc850f90ca0.type = tablelookupbyrow(table, row, 2);
    var_97642cc850f90ca0.ref = itemref;
    var_97642cc850f90ca0.cost = int(tablelookupbyrow(table, row, 4));
    var_97642cc850f90ca0.firesalediscount = int(tablelookupbyrow(table, row, 10));
    level.br_armory_kiosk.items[itemindex] = var_97642cc850f90ca0;
  }
}

function private function_d1687e85988049bb(itemref, var_c95404cd83f761b6) {
  foreach(var_eb7139726cc569b5 in var_c95404cd83f761b6) {
    if(var_eb7139726cc569b5["index"] == level.var_e7cee4fbb5b46ef2) {
      if(isDefined(var_eb7139726cc569b5["items"][itemref]) && var_eb7139726cc569b5["items"][itemref]["cost"] > 0) {
        return var_eb7139726cc569b5["items"][itemref]["cost"];
      }

      return undefined;
    }
  }
}

function private function_d0e1afe1bd3614df(itemref) {
  cost = function_d1687e85988049bb(itemref, level.var_6be7b375ec4a629c);

  if(!isDefined(cost) && isDefined(level.var_3899105ceec08fb8)) {
    cost = function_d1687e85988049bb(itemref, level.var_3899105ceec08fb8);
  }

  return cost;
}

function _getactualcost(player, itemdata) {
  isfiresale = 0;

  if(isDefined(player.br_kiosk)) {
    isfiresale = iskioskfiresaleactiveforplayer(player.br_kiosk, player);
  }

  finalcost = itemdata.cost;
  var_bbd3ced9f1e6acbf = function_d0e1afe1bd3614df(itemdata.entryref);

  if(isDefined(var_bbd3ced9f1e6acbf)) {
    finalcost = var_bbd3ced9f1e6acbf;
  }

  var_1a61fa389340ae66 = getdvarint(hashcat(@ "scr_", itemdata.ref, "_cost_override"), 0);

  if(var_1a61fa389340ae66 != 0) {
    finalcost = var_1a61fa389340ae66;
  }

  if(level.br_armory_kiosk.sales_discount > 0) {
    var_3719b75d66108f99 = level.br_armory_kiosk.sales_discount_items.size == 0 || array_contains(level.br_armory_kiosk.sales_discount_items, itemdata.ref);

    if(var_3719b75d66108f99) {
      finalcost = _applysalesdiscount(finalcost, level.br_armory_kiosk.sales_discount);
    }
  }

  if(isDefined(level.var_2ad8917b23c8c1d2)) {
    return [[level.var_2ad8917b23c8c1d2]](finalcost, itemdata);
  }

  if(isfiresale) {
    return _applysalesdiscount(finalcost, itemdata.firesalediscount);
  }

  return finalcost;
}

function function_59e987d44a301ef5(kiosk) {
  if(scripts\cp_mp\utility\game_utility::function_9cdaadfddeda4d7a() && isint(kiosk)) {
    kiosk = self;
  }

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

function _watchforcircleclosure() {
  level endon("game_ended");
  setdvarifuninitialized(@ "hash_acddd0026cc9adad", 0);

  while(true) {
    level waittill("br_circle_set");
    var_dff50030f50c58ea = getdvarint(@ "hash_acddd0026cc9adad", 0);

    if(var_dff50030f50c58ea == 0) {
      continue;
    }

    if(level.br_circle.circleindex + 1 >= var_dff50030f50c58ea) {
      disableallarmorykiosks();

      foreach(player in level.players) {
        if(!isDefined(player) || !isalive(player)) {
          continue;
        }

        player thread function_234f5394668ed388("br_kiosks_disabled");
      }

      break;
    }
  }
}

function function_54fdd9330a3bed3e() {
  while(true) {
    if(getdvarint(@ "hash_ca216e77fa44180c", 0) > 0) {
      foreach(armorykiosk in level.br_armory_kiosk.scriptables) {
        line(armorykiosk.origin, armorykiosk.origin + (0, 0, 5000), (0.7, 0.2, 0.1), 1, 1, 1);
      }
    }

    waitframe();
  }
}

function showdiscountsplash(delayseconds) {
  player = self;
  player endon("disconnect");
  level endon("game_ended");

  if(istrue(player.hasseendiscountsplash)) {
    return;
  }

  if(!isDefined(level.br_armory_kiosk.sales_discount)) {
    return;
  }

  if(level.br_armory_kiosk.sales_discount == 0) {
    return;
  }

  player.hasseendiscountsplash = 1;

  if(isDefined(delayseconds) && delayseconds > 0) {
    wait delayseconds;
  }

  if(level.br_armory_kiosk.sales_discount_items.size == 0) {
    player thread function_234f5394668ed388("br_sales_event_all");
    return;
  }

  player thread function_234f5394668ed388("br_sales_event_selective");
}

function function_8807282a387bb5b4() {
  return true;
}

function function_f29b0d39f0da104d() {
  if(!function_8807282a387bb5b4()) {
    return;
  }

  foreach(armorykiosk in level.br_armory_kiosk.scriptables) {
    function_ef7118f0ef2196b5(armorykiosk);
  }
}

function function_ef7118f0ef2196b5(armorykiosk) {
  armorykiosk.var_60b371eba77d2372 = scripts\cp\cp_objectives::requestworldid("kiosk_objective", 15);
  objective_setshowdistance(armorykiosk.var_60b371eba77d2372, 1);
  objective_state(armorykiosk.var_60b371eba77d2372, "current");
  objective_icon(armorykiosk.var_60b371eba77d2372, "ui_mobile_buystation_visual_marker");
  objective_setbackground(armorykiosk.var_60b371eba77d2372, 1);
  objective_position(armorykiosk.var_60b371eba77d2372, armorykiosk.origin + (0, 0, 40));
  objective_setplayintro(armorykiosk.var_60b371eba77d2372, 1);
  objective_setlabel(armorykiosk.var_60b371eba77d2372, &"CP_MISSION_DEFENDER/SUPPLIES_ICON");
  objective_setownerteam(armorykiosk.var_60b371eba77d2372, "allies");
  armorykiosk thread function_ac44ca4a1f1d7561();
}

function function_ac44ca4a1f1d7561() {
  level endon("game_ended");
  self endon("death");
  waittime = 4;

  if(isDefined(level.var_4b12176117d66ebb)) {
    waittime = level.var_4b12176117d66ebb;
  }

  while(true) {
    level waittill("kiosks_pulsate_objectives");
    objective_setpulsate(self.var_60b371eba77d2372, 1);
    wait waittime;
    objective_setpulsate(self.var_60b371eba77d2372, 0);
  }
}

function onprematchdone() {
  foreach(armorykiosk in level.br_armory_kiosk.scriptables) {
    armorykiosk setscriptablepartstate("br_plunder_box", "visible");
    armorykiosk.visible = 1;
  }

  function_f29b0d39f0da104d();
}

function dangercircletick(dangercircleorigin, dangercircleradius) {
  if(function_946938d9fde4bdce("kiosk") || getdvarint(@ "scr_br_kiosk_ignore_circle", 0) == 1) {
    return;
  }

  radiussquared = dangercircleradius * dangercircleradius;

  foreach(armorykiosk in level.br_armory_kiosk.scriptables) {
    if(isDefined(armorykiosk.visible) && distance2dsquared(armorykiosk.origin, dangercircleorigin) > radiussquared) {
      disablearmorykiosk(armorykiosk);
    }
  }
}

function function_1a1709943670772a() {
  if(function_946938d9fde4bdce("kiosk") || getdvarint(@ "scr_br_kiosk_ignore_circle", 0) == 1) {
    return;
  }

  hiddenkiosks = [];

  foreach(armorykiosk in level.br_armory_kiosk.scriptables) {
    if(isDefined(armorykiosk.visible)) {
      hiddenkiosks[hiddenkiosks.size] = armorykiosk;
      disablearmorykiosk(armorykiosk);
    }
  }

  return hiddenkiosks;
}

function disableallarmorykiosks() {
  if(function_946938d9fde4bdce("kiosk")) {
    return;
  }

  foreach(armorykiosk in level.br_armory_kiosk.scriptables) {
    if(isDefined(armorykiosk.visible)) {
      disablearmorykiosk(armorykiosk);
    }
  }
}

function disablearmorykiosk(armorykiosk) {
  armorykiosk setscriptablepartstate("br_plunder_box", "disabled");
  armorykiosk.visible = undefined;
  armorykiosk.disabled = 1;

  if(armorykiosk checkforactiveobjicon()) {
    armorykiosk scripts\cp\cp_objectives::deletequestobjicon();
  }
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
  level.br_armory_kiosk.scriptables = instances;
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

  if(istrue(player function_25fb9a3b7ee98d69("playerSkipKioskUse", instance))) {
    return false;
  }

  if(istrue(player.iscarrying)) {
    player function_ced51005e26102fa("MP/CANNOT_USE_GENERIC");
    return false;
  }

  return true;
}

function armorykioskused(instance, part, state, player, var_a5b2c541413aa895, usestring) {
  if(!function_be79dba5f7b2a51b(instance.type)) {
    return;
  }

  if(istrue(var_a5b2c541413aa895) && !function_7e0281196d6407c8()) {
    return;
  }

  if(!isDefined(player)) {
    player = self;
  }

  if(istrue(var_a5b2c541413aa895) && !isDefined(player.armorykioskpurchaseallowed)) {
    player.armorykioskpurchaseallowed = 0;
  }

  if(!function_3058b3e95a1bf984(instance, player)) {
    if(istrue(var_a5b2c541413aa895)) {
      player.armorykioskpurchaseallowed = 0;
    }

    return;
  }

  if(istrue(var_a5b2c541413aa895)) {
    if(!player.armorykioskpurchaseallowed) {
      function_28d837f720b03bfa(instance, player);
    }

    return;
  }

  if(istrue(player.insertingarmorplate)) {
    player notify("try_armor_cancel", "armory_kiosk_used");
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

function kiosksetupfiresaleforplayer(kiosk, player) {
  if(!isDefined(kiosk.firesaleforplayers)) {
    kiosk.firesaleforplayers = [player];
  } else if(!array_contains(kiosk.firesaleforplayers, player)) {
    kiosk.firesaleforplayers = array_add(kiosk.firesaleforplayers, player);
  }

  if(!kiosk checkforactiveobjicon()) {
    kiosk function_f4c2d922e3610d74("ui_mp_br_mapmenu_icon_poi_plunder_box_firesale", "active", kiosk.origin);
  }

  kiosk function_46f7ad16e39b4e0d(player);
}

function function_d7f25b3c73157f5c() {
  if(function_2f0d084017095d28(2)) {
    return true;
  }

  return false;
}

function iskioskfiresaleactiveforplayer(kiosk, player) {
  if(scripts\cp_mp\utility\game_utility::function_9cdaadfddeda4d7a() && (!isDefined(kiosk) || isint(kiosk))) {
    kiosk = player;
  }

  if(function_d7f25b3c73157f5c()) {
    return 1;
  }

  if(!isDefined(kiosk.firesaleforplayers)) {
    return 0;
  }

  return array_contains(kiosk.firesaleforplayers, player);
}

function kioskfiresaledoneforplayer(kiosk, player) {
  if(!isDefined(kiosk.firesaleforplayers)) {
    return;
  }

  kiosk function_601b78b411b7479(player);
  kiosk.firesaleforplayers = array_remove(kiosk.firesaleforplayers, player);

  if(!function_d7f25b3c73157f5c()) {
    setomnvar("ui_br_kiosk_hide_discount", 1);
  }
}

function function_1a8066ccdb91c1d1() {
  if(isDefined(level.var_d03e6ba38b56b4ab) && istrue(level.var_d03e6ba38b56b4ab)) {
    return level.var_fb60f0244999d528;
  }

  return 0;
}

function getkioskyawoffsetoverride() {
  if(isDefined(level.var_d03e6ba38b56b4ab) && istrue(level.var_d03e6ba38b56b4ab)) {
    finaloffset = level.var_e9f7702d839b262c;

    if(level.randomanglemax > 0) {
      finaloffset += randomfloatrange(level.randomanglemax * -1, level.randomanglemax);
    }

    return finaloffset;
  }

  return 180 + randomfloatrange(-10, 10);
}

function _runpurchasemenu(kiosk) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player endon("death");
  player.br_kiosk = kiosk;

  if(function_1a0bffd69502c210()) {
    player notify("kiosk_used");
  }

  if(isDefined(level.var_6beff7b631ab7e18)) {
    [[level.var_6beff7b631ab7e18]](kiosk, player);
  }

  if(getdvarint(@ "hash_80e2d358a4c12e43", 0) > 0) {
    kiosksetupfiresaleforplayer(kiosk, player);
    setDvar(@ "hash_80e2d358a4c12e43", 0);
  }

  isfiresale = iskioskfiresaleactiveforplayer(kiosk, player);

  if(!isint(kiosk) && isDefined(kiosk.overrideindex)) {
    level.var_e7cee4fbb5b46ef2 = kiosk.overrideindex;
    player setclientomnvar("ui_buystation_override", kiosk.overrideindex);

    if(isDefined(kiosk.var_ded92ccb217bbaeb)) {
      player setclientomnvar("ui_weapon_buystation_override", kiosk.var_ded92ccb217bbaeb);
    }
  } else if(isDefined(level.var_4b3d0771df2c44a9) && !istrue(player.var_e5b7a6a0ec2b440e)) {
    level.var_e7cee4fbb5b46ef2 = level.var_4b3d0771df2c44a9;
    player setclientomnvar("ui_buystation_override", level.var_4b3d0771df2c44a9);
  }

  player setclientomnvar("ui_buystation_purchase_response", 0);
  openvalue = 2;

  if(isfiresale) {
    openvalue += 4;
  }

  player setclientomnvar("ui_buystation_open", openvalue);
  player.armorykioskpurchaseallowed = 1;
  function_e667d74ecc894ceb(player, "menu_open");
  player thread _watchtoautoclosemenu(kiosk);

  if(getdvarint(@ "hash_b4ff8c1463b8bc79", 1)) {
    player setsoundsubmix("iw8_br_plunder_kiosk_menu");
  }
}

function function_28d837f720b03bfa(kiosk, player) {
  player.br_kiosk = kiosk;

  if(getdvarint(@ "hash_80e2d358a4c12e43", 0) > 0) {
    kiosksetupfiresaleforplayer(kiosk, player);
    setDvar(@ "hash_80e2d358a4c12e43", 0);
  }

  player.armorykioskpurchaseallowed = 1;
  player thread function_ab62cd6135dfe6(kiosk);
}

function function_5221f0c9bdea6589() {
  player = self;
  player.br_kiosk = undefined;
  player.var_e5b7a6a0ec2b440e = undefined;
  player.var_c77002478cdfd85f = undefined;
  player.armorykioskpurchaseallowed = undefined;
}

function function_ab62cd6135dfe6(kiosk) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player endon("death");
  player childthread function_59e987d44a301ef5(kiosk);
  waittill_any_ents(player, "death", player, "last_stand_start", player, "exit_quick_purchase_zone", level, "game_ended");

  if(isDefined(player)) {
    function_5221f0c9bdea6589();
  }
}

function _closepurchasemenuwithresponse(var_97aa74c2193a9dc6) {
  player = self;

  if(var_97aa74c2193a9dc6 == 1 && getdvarint(@ "hash_ed6e4ffa933af621", 0)) {
    return;
  }

  player setclientomnvar("ui_buystation_purchase_response", var_97aa74c2193a9dc6);
  player setclientomnvar("ui_buystation_open", 1);
  player clearsoundsubmix("iw8_br_plunder_kiosk_menu");
  scripts\cp_mp\vehicles\vehicle_interact::function_fed77cd5c54efe19(player.var_c77002478cdfd85f, player);
  player.br_kiosk = undefined;
  player.var_e5b7a6a0ec2b440e = undefined;
  player.var_c77002478cdfd85f = undefined;
  player.armorykioskpurchaseallowed = undefined;
  function_e667d74ecc894ceb(player, "menu_close", "reason: " + var_97aa74c2193a9dc6);
}

function _purchasemenuclosedbyclient(player) {
  player _closepurchasemenuwithresponse(0);
  player notify("_watchToAutoCloseMenu_end");
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

function _proximitywatcher(kiosk) {
  if(scripts\cp_mp\utility\game_utility::function_9cdaadfddeda4d7a() && isint(kiosk)) {
    kiosk = self;
  }

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

function _getequipmentammotomax(equipmentref) {
  player = self;

  if(!isDefined(equipmentref)) {
    return 0;
  }

  ammo = player scripts\cp_mp\equipment::getequipmentammo(equipmentref);
  ammomax = player scripts\cp_mp\equipment::getequipmentmaxammo(equipmentref);
  return max(0, ammomax - ammo);
}

function _maxoutequipmentammo(equipmentref) {
  player = self;

  if(!isDefined(equipmentref)) {
    return 0;
  }

  ammo = player scripts\cp_mp\equipment::getequipmentammo(equipmentref);
  ammomax = player scripts\cp_mp\equipment::getequipmentmaxammo(equipmentref);

  if(ammo < ammomax) {
    player scripts\cp_mp\equipment::setequipmentammo(equipmentref, ammomax);
  }
}

function function_8c8f1e3f153a6fa3() {}

function _findgivearmoramountanddropleftovers(fromkiosk, var_2737cac9ee8f6098) {
  player = self;
  var_1cd29382d1867470 = player scripts\cp_mp\armor::function_600f6cf462e983f();
  var_a81adeb0e1f89320 = player scripts\cp_mp\armor::function_47320a25b8ee003();

  if(getdvarint(@ "scr_br_alt_mode_gg", 0)) {
    bundlecount = 2;
  } else {
    bundlecount = 5;
  }

  var_bf203ce62dd1c99c = int(max(min(bundlecount, var_a81adeb0e1f89320 - var_1cd29382d1867470), 0));
  dropamount = bundlecount - var_bf203ce62dd1c99c;

  if(function_83e3b506365bafc5()) {
    lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("brloot_armor_plate");
    fakepickup = spawnStruct();
    fakepickup.scriptablename = "brloot_armor_plate";
    fakepickup.count = dropamount;
    leftover = player function_ef240aa7c1052d13(lootid, fakepickup, 1);

    if(leftover > 0 && !istrue(var_2737cac9ee8f6098)) {
      overridedist = undefined;

      if(fromkiosk && isDefined(player.br_kiosk)) {
        overridedist = distance2d(player.origin, player.br_kiosk.origin) / 2;
      }

      dropinfo = scripts\cp\pickups::getitemdroporiginandangles(0, player.origin, player.angles, player, undefined, overridedist);
      function_9d6d4c76abc82cf("brloot_armor_plate", dropinfo, leftover, 1);
    }
  } else if(dropamount > 0 && !istrue(var_2737cac9ee8f6098)) {
    yawoffsetoverride = undefined;

    if(istrue(fromkiosk)) {
      yawoffsetoverride = getkioskyawoffsetoverride();
    }

    dropinfo = function_bb87cfae1e28e70b(0, player.origin, player.angles, player, yawoffsetoverride);
    function_9d6d4c76abc82cf("brloot_armor_plate", dropinfo, dropamount, 1);
  }

  return var_bf203ce62dd1c99c;
}

function _validateitempurchase(itemdata, var_6dc0e605ecd21eee, var_7c3865dee4abed6) {
  player = self;
  var_fbd5fada61ae8341 = _getactualcost(player, itemdata);

  if(!isDefined(player.plundercount)) {
    player.plundercount = 0;
  }

  if(player.plundercount < var_fbd5fada61ae8341) {
    player _closepurchasemenuwithresponse(3);
    return 0;
  }

  if(isDefined(level.var_5771fc79979ccc58)) {
    return [[level.var_5771fc79979ccc58]](itemdata, var_6dc0e605ecd21eee, var_7c3865dee4abed6, var_fbd5fada61ae8341);
  }

  if(itemdata.type == "killstreak") {
    if(!istrue(var_6dc0e605ecd21eee)) {
      if(player function_77986db57958b676(itemdata.ref)) {
        player _closepurchasemenuwithresponse(4);
        return 0;
      }
    }
  } else if(itemdata.type == "fieldupgrade" || itemdata.type == "super") {
    if(player function_3f422a1c87bd2809()) {
      player _closepurchasemenuwithresponse(6);
      return 0;
    }

    if(!istrue(var_6dc0e605ecd21eee)) {
      currentsuperref = player function_97fac14206681b1f();

      if(isDefined(currentsuperref) && itemdata.ref == currentsuperref) {
        player _closepurchasemenuwithresponse(5);
        return 0;
      }
    }
  } else if(itemdata.type == "perk") {
    if(player function_87072b42853a9c58(itemdata.ref)) {
      player _closepurchasemenuwithresponse(5);
      return 0;
    }
  } else if(itemdata.type == "special") {
    switch (itemdata.ref) {
      case #"hash_25789111b74943b4":
      case #"hash_2dcde97962801ba9":
        if(scripts\cp_mp\utility\game_utility::function_9cdaadfddeda4d7a()) {
          var_6a8b46e184e181cc = spawnStruct();
          var_6a8b46e184e181cc.scriptablename = "brloot_armor_plate";

          if(itemdata.ref == "armor_bundle") {
            var_6a8b46e184e181cc.count = 5;
          } else {
            var_6a8b46e184e181cc.count = 1;
          }

          canpickupresult = function_76ae39f27ed53321(var_6a8b46e184e181cc);

          if(canpickupresult != 1) {
            assert(canpickupresult == 4);
            player _closepurchasemenuwithresponse(7);
            return 0;
          }
        }

        break;
      case #"hash_a7a7446a3194cb49":
        var_1f158ccaa5d9c0be = scripts\cp_mp\armor::function_92fec40b905c5112();

        if(!var_1f158ccaa5d9c0be) {
          player _closepurchasemenuwithresponse(7);
          return 0;
        }

        break;
      case #"hash_4808e1f340e11163":
        if(istrue(var_7c3865dee4abed6)) {
          return 1;
        }

        var_6a8b46e184e181cc = spawnStruct();
        var_6a8b46e184e181cc.scriptablename = "brloot_equip_gasmask";
        canpickupresult = function_76ae39f27ed53321(var_6a8b46e184e181cc);
        assert(canpickupresult == 1);
        break;
      case #"hash_dcf82d1f65a6b16e":
        if(istrue(var_7c3865dee4abed6)) {
          return 1;
        }

        var_6a8b46e184e181cc = spawnStruct();
        var_6a8b46e184e181cc.scriptablename = "brloot_equip_gasmask";
        canpickupresult = function_76ae39f27ed53321(var_6a8b46e184e181cc);
        assert(canpickupresult == 1);
        break;
      case #"hash_e67a71b27007444":
        if(istrue(var_7c3865dee4abed6)) {
          return 1;
        }

        var_b1db5698237fe274 = 0;

        if(player _getequipmentammotomax(player.equipment["primary"]) > 0) {
          var_b1db5698237fe274 = 1;
        } else if(player _getequipmentammotomax(player.equipment["secondary"]) > 0) {
          var_b1db5698237fe274 = 1;
        } else if(!player function_eceea793e05658bd()) {
          var_b1db5698237fe274 = 1;
        }

        if(!var_b1db5698237fe274) {
          player _closepurchasemenuwithresponse(8);
          return 0;
        }

        break;
      case #"hash_6613e243265c4795":
        if(function_f41fe8dc1d31d5bf()) {
          player _closepurchasemenuwithresponse(9);
          return 0;
        }

        if(istrue(var_7c3865dee4abed6)) {
          return 1;
        }

        if(istrue(player.hasrespawntoken)) {
          player _closepurchasemenuwithresponse(10);
          return 0;
        }

        break;
      case #"hash_1c3e21ffbc842487":
      case #"hash_4f292feb06ad9942":
        if(istrue(var_7c3865dee4abed6)) {
          return 1;
        }

        if(player function_c8dfc3feceeb2896()) {
          player _closepurchasemenuwithresponse(10);
          return 0;
        }

        break;
      case #"hash_3a0285dc5b457e3a":
        if(istrue(var_7c3865dee4abed6)) {
          return 1;
        }

        var_6a8b46e184e181cc = spawnStruct();
        var_6a8b46e184e181cc.scriptablename = "brloot_offhand_advancedsupplydrop";
        var_6a8b46e184e181cc.count = 1;
        canpickupresult = function_76ae39f27ed53321(var_6a8b46e184e181cc);

        if(canpickupresult != 1) {
          assert(canpickupresult == 4);
          player _closepurchasemenuwithresponse(7);
          return 0;
        }

        break;
      case #"hash_b41ab83f39326993":
        if(isDefined(level.br_circle)) {
          player _closepurchasemenuwithresponse(17);
          return 0;
        }

        break;
      case #"hash_532a5678aa4979f3":
        if(isDefined(level.br_circle) || istrue(level.brgametype.circlerunning)) {
          player _closepurchasemenuwithresponse(9);
          return 0;
        }

        break;
      case #"hash_83584572ba67a745":
        if(!player function_334bee7871c3ae0f()) {
          player _closepurchasemenuwithresponse(21);
          return 0;
        }

        break;
      case #"hash_546ee28ea1d0dc10":
        if(!player function_ff0081ca56b5a384("armor")) {
          player _closepurchasemenuwithresponse(20);
          return 0;
        }

        break;
      case #"hash_99e995f94c6d662b":
        if(!player function_a037837dc6c85636()) {
          player _closepurchasemenuwithresponse(19);
          return 0;
        }

        break;
      case #"hash_63edc28701e80b73":
        if(!player function_ff0081ca56b5a384("trophy")) {
          player _closepurchasemenuwithresponse(20);
          return 0;
        }

        break;
      case #"hash_8db3828479a5780b":
        if(!player function_ff0081ca56b5a384("uav")) {
          player _closepurchasemenuwithresponse(20);
          return 0;
        }

        break;
      case #"hash_7cf102dbc7cbbbc5":
        if(!player function_ff0081ca56b5a384("barrel")) {
          player _closepurchasemenuwithresponse(20);
          return 0;
        }

        break;
      case #"hash_63d4978a15e681a8":
        if(player function_6e4f7e117d4651c3()) {
          player _closepurchasemenuwithresponse(23);
          return 0;
        }

        if(!player function_d48c5142f8271c18()) {
          player _closepurchasemenuwithresponse(22);
          return 0;
        }

        break;
      case #"hash_6235851dae0eeca8":
      case #"hash_6c0c806bbf705a0c":
      case #"hash_2e68ca53eaf9ae70":
      case #"hash_a179b8412a3a0354":
      case #"hash_a179bb412a3a080d":
      case #"hash_a2240c78d2ced063":
      case #"hash_2e68cd53eaf9b329":
      case #"hash_baa7a6f9de5c563d":
      case #"hash_bb639a6ed9e9b88a":
      case #"hash_bbf617dca645120c":
      case #"hash_bbf61adca64516c5":
      case #"hash_2fc44f64748f8c8e":
      case #"hash_dda8890cb35ca0bf":
      case #"hash_e4154ddbab061c63":
      case #"hash_f6bd03bdc3846abe":
      case #"hash_fd8da3bdddb8e1c2":
        objective = undefined;

        if(isDefined(level.var_d23c7c1add9fb181)) {
          objective = player[[level.var_d23c7c1add9fb181]]();
        }

        if(isDefined(objective) && isDefined(level.var_4de8052758f986f3) && [[level.var_4de8052758f986f3]](objective.objectivekey, player.team, itemdata.ref)) {
          player _closepurchasemenuwithresponse(17);
          return 0;
        }

        break;
      case #"hash_dad2e39dcf5e31c":
      case #"hash_bd3c5bede4f8165f":
      case #"hash_c31089e2e50b5079":
        break;
      case #"hash_43f2312fe01322cf":
        break;
      case #"hash_9789620b82d8908c":
      case #"hash_f0fd4758cf2900f0":
      case #"hash_f4fe496941705c28":
        break;
      case #"hash_c662d84c73daa0a8":
        break;
    }
  }

  return 1;
}

function _killstreakneedslocationselection(killstreakref) {
  switch (killstreakref) {
    case #"hash_8c766d6477287bb6":
    case #"hash_b4ac3581c343a029":
      return 1;
    case #"hash_634b246c3da5c56f":
      return 0;
    default:
      assertmsg("Unexpected killstreak purchase type: " + killstreakref);
      return 0;
  }
}

function _locationselectioninterrupt() {
  player = self;
  waittill_any_ents(player, "death", level, "game_ended");
  player notify("cancel_location");
}

function _handlekillstreakpurchase(itemdata, dropcurrent, droppurchased, var_db943473454f6ea6) {
  player = self;
  player endon("disconnect");
  activateimmediately = getdvarint(@ "hash_e516a6aa0d85b36d", 0);

  if(!activateimmediately) {
    player function_da31e13c27a6acf4(itemdata.ref, dropcurrent, 1, droppurchased, var_db943473454f6ea6);
    function_a573b91325f9ea32(player, itemdata, "killstreak", "br_killstreak_purchased");
    return;
  }

  if(_killstreakneedslocationselection(itemdata.ref)) {
    var_6eb64f3fea3bbe81 = player.br_kiosk;
    player _closepurchasemenuwithresponse(16);
    player scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "kiosk");
    player beginlocationselection(0, 0, "circle_marker", 0, 4);
    player childthread _locationselectioninterrupt();
    returninfo = player function_88cafec24778c70c("confirm_location", "cancel_location");
    player endlocationselection();
    player scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1, "kiosk");

    if(isDefined(returninfo) && returninfo.string == "confirm_location") {
      locationtrace = function_5c8ad6e89a9f7b73(returninfo.location);
      player.kstargetlocation = locationtrace["position"];
      usesuccess = player function_25c4c34d6c3dd08a(itemdata.ref);

      if(istrue(usesuccess)) {
        function_a573b91325f9ea32(player, itemdata, "killstreak", "br_killstreak_purchased_and_activated");
      }
    } else {
      player thread _runpurchasemenu(var_6eb64f3fea3bbe81);
    }

    return;
  }

  player function_da31e13c27a6acf4(itemdata.ref, dropcurrent, 1, var_db943473454f6ea6);
  usesuccess = player function_25c4c34d6c3dd08a(itemdata.ref);

  if(istrue(usesuccess)) {
    function_a573b91325f9ea32(player, itemdata, "killstreak", "br_killstreak_purchased_and_activated");
  }
}

function function_90b0e9eb26e38443(itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_db943473454f6ea6) {
  scriptablename = itemdata.ref;
  var_bada25504e8844d7 = spawnStruct();
  var_bada25504e8844d7.scriptablename = scriptablename;
  var_bada25504e8844d7.origin = self.origin;
  var_bada25504e8844d7.count = 1;
  var_bada25504e8844d7.maxcount = level.br_pickups.maxcounts[scriptablename];
  var_bada25504e8844d7.stackable = level.br_pickups.stackable[scriptablename];
  [ammo, ammoleft, var_35ead47ed0d7507e] = function_cfb85293f9660751(level.br_lootiteminfo[scriptablename].fullweaponobj);
  var_bada25504e8844d7.count = ammo * 3;
  var_bada25504e8844d7.countlefthand = ammoleft;
  var_bada25504e8844d7.countalt = var_35ead47ed0d7507e;
  function_6e3db23952f2e451(var_bada25504e8844d7);
  function_a573b91325f9ea32(self, itemdata, "weapon");
}

function _handlefieldupgradepurchase(itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_db943473454f6ea6) {
  function_eb96721d13c5f3df(itemdata.ref, var_7dddac09987d559e, 1, var_452130d9d126e506, var_db943473454f6ea6);
  function_a573b91325f9ea32(self, itemdata, "fieldUpgrade", "br_field_upgrade_purchased");

  if(level.allowsupers && !istrue(var_452130d9d126e506)) {
    function_74efaa97ebfec5df(function_19dd797e5d48d987(), undefined, undefined, undefined);
  }
}

function _handlespecialpurchase(itemdata, var_7dddac09987d559e, var_452130d9d126e506, kiosk) {
  player = self;
  purchasesuccess = 1;
  var_b517df938986556f = 1;
  armorcount = undefined;
  quantity = 1;

  switch (itemdata.ref) {
    case #"hash_25789111b74943b4":
      purchasesuccess = function_e2db59d7677bfceb(player, "brloot_armor_plate", 1, undefined, 1, var_452130d9d126e506);

      if(!purchasesuccess) {
        dropinfo = function_bb87cfae1e28e70b(0, kiosk.origin, kiosk.angles, player);
        pickupent = function_9d6d4c76abc82cf("brloot_armor_plate", dropinfo, 1, 1, undefined, 0);
        purchasesuccess = 1;
      }

      itemdata.lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("brloot_armor_plate");
      break;
    case #"hash_2dcde97962801ba9":
      var_2b83f7cf5dd2cf23 = player _findgivearmoramountanddropleftovers(1);

      if(var_2b83f7cf5dd2cf23 <= 0) {
        purchasesuccess = 1;
      } else {
        purchasesuccess = function_e2db59d7677bfceb(player, "brloot_armor_plate", 1, var_2b83f7cf5dd2cf23, 1, var_452130d9d126e506);
      }

      itemdata.lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("brloot_armor_plate");
      quantity = var_2b83f7cf5dd2cf23;
      assert(purchasesuccess);
      break;
    case #"hash_4808e1f340e11163":
      var_1680a35fe50dc05e = "brloot_equip_gasmask";
      purchasesuccess = function_e2db59d7677bfceb(player, var_1680a35fe50dc05e, 1, undefined, 1, var_452130d9d126e506);
      assert(purchasesuccess);
      itemdata.lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(var_1680a35fe50dc05e);
      break;
    case #"hash_dcf82d1f65a6b16e":
      var_1680a35fe50dc05e = "brloot_equip_gasmask";
      purchasesuccess = function_e2db59d7677bfceb(player, var_1680a35fe50dc05e, 1, undefined, 1, var_452130d9d126e506);
      assert(purchasesuccess);
      itemdata.lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(var_1680a35fe50dc05e);
      break;
    case #"hash_e67a71b27007444":
      player function_836c7d119e02d1d5();
      player _maxoutequipmentammo(player.equipment["primary"]);
      player _maxoutequipmentammo(player.equipment["secondary"]);
      break;
    case #"hash_6613e243265c4795":
      player function_c00f90a28c41febe();
      var_b517df938986556f = 0;
      break;
    case #"hash_1c3e21ffbc842487":
      var_5db3e79ef6900447 = "brloot_self_revive";

      if(istrue(var_452130d9d126e506)) {
        purchasesuccess = function_e2db59d7677bfceb(player, var_5db3e79ef6900447, 1, undefined, 1, var_452130d9d126e506);
        assert(purchasesuccess);
      } else {
        player function_2d5a30d6fe54567b();
      }

      itemdata.lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(var_5db3e79ef6900447);
      var_b517df938986556f = 0;
      break;
    case #"hash_4f292feb06ad9942":
      var_5db3e79ef6900447 = "brloot_self_revive";

      if(istrue(var_452130d9d126e506)) {
        purchasesuccess = function_e2db59d7677bfceb(player, var_5db3e79ef6900447, 1, undefined, 1, var_452130d9d126e506);
        assert(purchasesuccess);
      } else {
        player function_2d5a30d6fe54567b();
      }

      itemdata.lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(var_5db3e79ef6900447);
      var_b517df938986556f = 0;
      break;
    case #"hash_3a0285dc5b457e3a":
      purchasesuccess = function_e2db59d7677bfceb(player, "brloot_offhand_advancedsupplydrop", 1, undefined, 1, var_452130d9d126e506);
      assert(purchasesuccess);
      itemdata.lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("brloot_offhand_advancedsupplydrop");
      break;
    case #"hash_b41ab83f39326993":
      purchasesuccess = player playerhandlecirclepickitem();
      break;
    case #"hash_532a5678aa4979f3":
      purchasesuccess = player playerhandleredeploy();
      break;
    case #"hash_83584572ba67a745":
      purchasesuccess = player _handlevehiclerepair();
      break;
    case #"hash_546ee28ea1d0dc10":
      purchasesuccess = player function_388aa30e37abbb0("armor");
      break;
    case #"hash_99e995f94c6d662b":
      purchasesuccess = player function_9fc999a4450eacb2("trophy");
      break;
    case #"hash_63edc28701e80b73":
      purchasesuccess = player function_388aa30e37abbb0("trophy");
      break;
    case #"hash_8db3828479a5780b":
      purchasesuccess = player function_388aa30e37abbb0("uav");
      break;
    case #"hash_7cf102dbc7cbbbc5":
      purchasesuccess = player function_388aa30e37abbb0("barrel");
      break;
    case #"hash_63d4978a15e681a8":
      purchasesuccess = function_e2db59d7677bfceb(player, "brloot_offhand_advancedvehicledrop", 1, undefined, 1, var_452130d9d126e506);
      assert(purchasesuccess);
      itemdata.lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("brloot_offhand_advancedvehicledrop");
      break;
    case #"hash_d63b8f48fb92540d":
      purchasesuccess = player _handlevehiclepurchase(itemdata, var_7dddac09987d559e);

      if(purchasesuccess) {
        player thread function_234f5394668ed388("br_vehicle_purchased");
      } else {
        player function_ced51005e26102fa("MP/VEHICLE_PURCHASE_FAILED");
      }

      break;
    case #"hash_2fc44f64748f8c8e":
    case #"hash_6235851dae0eeca8":
    case #"hash_9789620b82d8908c":
    case #"hash_6c0c806bbf705a0c":
    case #"hash_a179b8412a3a0354":
    case #"hash_a179bb412a3a080d":
    case #"hash_a2240c78d2ced063":
    case #"hash_baa7a6f9de5c563d":
    case #"hash_bb639a6ed9e9b88a":
    case #"hash_bbf617dca645120c":
    case #"hash_bbf61adca64516c5":
    case #"hash_e4154ddbab061c63":
    case #"hash_2e68ca53eaf9ae70":
    case #"hash_2e68cd53eaf9b329":
    case #"hash_dda8890cb35ca0bf":
    case #"hash_f0fd4758cf2900f0":
    case #"hash_f4fe496941705c28":
    case #"hash_f6bd03bdc3846abe":
    case #"hash_fd8da3bdddb8e1c2":
      purchasesuccess = isDefined(level.var_3ce1055115edcbbb) && [[level.var_3ce1055115edcbbb]](player, itemdata.ref);
      break;
    case #"hash_bd3c5bede4f8165f":
      purchasesuccess = isDefined(level.var_efbc646224fda4fa);
      player thread[[level.var_efbc646224fda4fa]]();
      break;
    case #"hash_c31089e2e50b5079":
    case #"hash_dad2e39dcf5e31c":
      purchasesuccess = 1;
      player thread function_f5e58b5375381386("sentry_gun");
      player function_f87529d7af4978b("sentry_gun", "other", undefined, undefined, undefined, 0);
      break;
    case #"hash_a7a7446a3194cb49":
      purchasesuccess = scripts\cp_mp\armor::function_92fec40b905c5112();
      break;
    case #"hash_b0eb18371d980895":
      purchasesuccess = 1;
      player.supportcranked = 1;
      player thread[[level.var_68a1353068460d1]]();
      break;
    case #"hash_c662d84c73daa0a8":
      break;
    default:
      assertmsg("Unsupported kiosk item: " + itemdata.ref);
      break;
  }

  if(purchasesuccess) {
    splash = undefined;

    if(var_b517df938986556f) {
      splash = "br_item_purchased";
    }

    function_a573b91325f9ea32(player, itemdata, "special", splash, quantity);
  }

  if(scripts\cp_mp\utility\game_utility::function_9cdaadfddeda4d7a()) {
    if(isDefined(level.var_8ec1a1ca587a6487)) {
      player[[level.var_8ec1a1ca587a6487]](itemdata.ref);
    }

    armorykioskused(0, undefined, undefined, self);
    return;
  }

  if(getdvarint(@ "hash_5509a47c2830abd3", 1) == 1) {
    armorykioskused(kiosk, undefined, undefined, self);
  }
}

function _handlevehiclepurchase(itemdata, var_7dddac09987d559e) {
  assertex(isDefined(self.br_kiosk), "cannot purchase a vehicle when not at a kiosk.");
  var_26d956b5a9e59a2e = (1, 1, 1);
  var_10a5a10c444aefbb = (1, 0, 0);
  var_42b28c7586481d92 = (0, 1, 0);
  var_1efdce79e6a210ae = (0, 1, 1);
  dbgradius = 3;
  dbgtime = 8;

  if(!scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle(itemdata.ref, undefined, undefined, "KIOSK")) {
    return false;
  }

  if(scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
    return false;
  }

  spawndata = spawnStruct();

  if(isDefined(self.br_kiosk.vehiclespawn)) {
    spawndata.origin = self.br_kiosk.vehiclespawn.origin;
    spawndata.angles = self.br_kiosk.vehiclespawn.angles;
  }

  if(!isDefined(spawndata.origin)) {
    spawndata.origin = self.br_kiosk.origin + anglesToForward(self.br_kiosk.angles) * 100 + (0, 0, 60);
  }

  if(!isDefined(spawndata.angles)) {
    spawndata.angles = (0, self.br_kiosk.angles[1] + 90, 0);
  }

  contents = physics_createcontents(["physicscontents_water", "physicscontents_item", "physicscontents_vehicleclip"]);

  if(!scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_checkspawnclearance(spawndata.origin, itemdata.ref)) {
    return false;
  }

  spawndata.spawntype = "KIOSK";

  if(scripts\cp_mp\vehicles\vehicle_airdrop::function_ccdcf48542c8a5b7(itemdata.ref)) {
    vehicle = scripts\cp_mp\vehicles\vehicle_airdrop::vehicle_airdrop(itemdata.ref, spawndata);
  } else {
    vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn(itemdata.ref, spawndata);
  }

  if(!isDefined(vehicle)) {
    return false;
  }

  scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_preventrespawn(vehicle);
  scripts\cp_mp\calloutmarkerping::calloutmarkerping_createcallout(21, (0, 0, 100), vehicle getentitynumber());
  return true;
}

function function_334bee7871c3ae0f() {
  player = self;
  vehicle = player.var_c77002478cdfd85f;

  if(isDefined(vehicle)) {
    if(vehicle.health == vehicle.maxhealth) {
      return false;
    }

    return true;
  }

  return false;
}

function function_a037837dc6c85636() {
  player = self;
  vehicle = player.var_c77002478cdfd85f;

  if(isDefined(vehicle)) {
    if(isDefined(vehicle.trophyammo) && isDefined(vehicle.var_c1cc7f4fbebfb815) && vehicle.trophyammo == vehicle.var_c1cc7f4fbebfb815) {
      return false;
    } else {
      return true;
    }
  }

  return false;
}

function function_ff0081ca56b5a384(upgradetype) {
  player = self;
  vehicle = player.var_c77002478cdfd85f;

  if(isDefined(vehicle)) {
    if(scripts\cp_mp\vehicles\vehicle_interact::function_97c32f66eff29610(vehicle, upgradetype)) {
      return false;
    } else {
      return true;
    }
  }

  return false;
}

function _handlevehiclerepair(itemdata, var_7dddac09987d559e) {
  player = self;
  vehicle = player.var_c77002478cdfd85f;

  if(isDefined(vehicle)) {
    if(vehicle.health == vehicle.maxhealth) {
      return false;
    }

    var_6d294b74de0d301e = getdvarfloat(@ "hash_3c1b0adf9da014a0", 0.25);
    var_e4f8ad64a6e67d4b = int(vehicle.maxhealth * var_6d294b74de0d301e);
    vehicle scripts\cp_mp\vehicles\vehicle_damage::function_653b96ce8310763e(var_e4f8ad64a6e67d4b);
    players = function_9563f2d4e690856d(self.team, "players");

    foreach(player in players) {
      if(getdvarint(@ "hash_38d15e2d7ddbf066", 1) == 1) {
        player hudicontype("truckheal");
      }

      player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_team_cash_pockets", vehicle.health);
      player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_team_cash_banked", vehicle.maxhealth);
    }

    return true;
  }

  return false;
}

function function_9fc999a4450eacb2(upgradetype) {
  player = self;
  vehicle = player.var_c77002478cdfd85f;

  if(isDefined(vehicle)) {
    scripts\cp_mp\vehicles\vehicle_interact::function_c4b9d8e33849435e(vehicle, upgradetype, player);
    return true;
  }

  return false;
}

function function_388aa30e37abbb0(upgradetype) {
  player = self;
  vehicle = player.var_c77002478cdfd85f;

  if(isDefined(vehicle)) {
    if(scripts\cp_mp\vehicles\vehicle_interact::function_97c32f66eff29610(vehicle, upgradetype)) {
      return false;
    } else {
      scripts\cp_mp\vehicles\vehicle_interact::function_c4b9d8e33849435e(vehicle, upgradetype, player);
      return true;
    }
  }

  return false;
}

function function_6e4f7e117d4651c3() {
  player = self;
  squad = function_9563f2d4e690856d(player.team, "players");

  foreach(squadmate in squad) {
    if(isDefined(squadmate)) {
      superref = squadmate function_97fac14206681b1f();

      if(isDefined(superref) && superref == "super_vehicle_drop") {
        if(squadmate getammocount(squadmate.super.staticdata.weapon) > 0) {
          return true;
        }
      }
    }
  }

  if(isDefined(level.var_e3ccf0898a949bec) && istrue(level.var_e3ccf0898a949bec[player.team])) {
    return true;
  }

  return false;
}

function function_d48c5142f8271c18() {
  if(isDefined(level.teamvehicles) && !isDefined(level.teamvehicles[self.team])) {
    return true;
  }

  return false;
}

function function_365e64606d4f3da8(itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_db943473454f6ea6) {
  function_f87529d7af4978b(itemdata.ref, "other");
  thread function_234f5394668ed388("br_killstreak_purchased");
  armorykioskused(0, undefined, undefined, self);
}

function function_6c02b611541421d2(itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_db943473454f6ea6) {
  function_690e9e142ebc1c69(itemdata.ref);
  function_4f2bd7da634cba24(itemdata.ref, 1);
  thread function_234f5394668ed388("br_field_upgrade_purchased");

  if(level.allowsupers && !istrue(var_452130d9d126e506)) {
    function_74efaa97ebfec5df(function_19dd797e5d48d987(), undefined, undefined, undefined);
  }

  armorykioskused(0, undefined, undefined, self);
}

function function_f1d968fd69ab759a(itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_db943473454f6ea6) {
  function_690e9e142ebc1c69(itemdata.ref);
  function_4f2bd7da634cba24(itemdata.ref, 1);
  thread function_234f5394668ed388("br_field_upgrade_purchased");

  if(level.allowsupers && !istrue(var_452130d9d126e506)) {
    function_74efaa97ebfec5df(function_19dd797e5d48d987(), undefined, undefined, undefined);
  }

  armorykioskused(0, undefined, undefined, self);
}

function function_157316f7321dd26b(itemdata, dropcurrent, droppurchased, var_db943473454f6ea6) {
  self endon("disconnect");
  function_5942f6cdbb6cb63b(itemdata.ref);
  function_a573b91325f9ea32(self, itemdata, "perk", itemdata.ref);
  armorykioskused(0, undefined, undefined, self);
}

function function_bc5f62f877be030f(func, itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_db943473454f6ea6) {
  level endon("game_ended");
  function_a573b91325f9ea32(self, itemdata, itemdata.type);

  if(!isalive(self)) {
    armorykioskused(0, undefined, undefined, self);
  }

  while(!isalive(self)) {
    waitframe();
  }

  self thread[[func]](itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_db943473454f6ea6);
}

function function_601181692f53e4ed(itemref) {
  foreach(item in level.br_armory_kiosk.items) {
    if(item.ref == itemref) {
      return item;
    }
  }
}

function onarmorykioskpurchase(channel, purchaseindex) {
  player = self;
  kiosk = player.br_kiosk;

  if(!istrue(player.armorykioskpurchaseallowed) && !istrue(level.var_d804888d9484ff69)) {
    return;
  }

  var_6c457c5f341beb23 = "channel: " + channel;

  if(isDefined(purchaseindex)) {
    var_6c457c5f341beb23 = var_6c457c5f341beb23 + ", index: " + purchaseindex;
  }

  function_e667d74ecc894ceb(player, "menu_purchase", var_6c457c5f341beb23);
  var_7dddac09987d559e = getdvarint(@ "hash_d6a60f25ef560a17", 1);
  var_452130d9d126e506 = getdvarint(@ "hash_8e3b1991482f0d41", 0);

  if(player function_c4d8558fc1592cd6()) {
    var_452130d9d126e506 = 1;
  }

  if(channel == "br_cancel_purchase") {
    _purchasemenuclosedbyclient(player);
    return;
  }

  if(channel == "br_item_purchase") {
    itemindex = purchaseindex;
    assert(isDefined(level.br_armory_kiosk.items[itemindex]));
    itemdata = level.br_armory_kiosk.items[itemindex];
    canpurchase = player _validateitempurchase(itemdata, var_7dddac09987d559e, var_452130d9d126e506);

    if(canpurchase) {
      if(isDefined(itemdata.var_144769f518d71226) && itemdata.var_144769f518d71226 > 0) {
        itemdata.var_144769f518d71226--;
        setomnvar("ui_buystation_limited_item_amount_temp", itemdata.var_144769f518d71226);
      }

      var_db943473454f6ea6 = undefined;

      if(function_83e3b506365bafc5()) {
        var_db943473454f6ea6 = function_507b98884b41cc8e();
      }

      if(scripts\cp_mp\utility\game_utility::function_9cdaadfddeda4d7a() && itemdata.type == "killstreak") {
        player thread function_bc5f62f877be030f(&function_365e64606d4f3da8, itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_db943473454f6ea6);
      } else if(scripts\cp_mp\utility\game_utility::function_9cdaadfddeda4d7a() && itemdata.type == "fieldupgrade" || itemdata.type == "super") {
        player thread function_bc5f62f877be030f(&function_6c02b611541421d2, itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_db943473454f6ea6);
      } else if(scripts\cp_mp\utility\game_utility::function_9cdaadfddeda4d7a() && itemdata.type == "perk") {
        player thread function_bc5f62f877be030f(&function_157316f7321dd26b, itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_db943473454f6ea6);
      } else if(isDefined(level.var_8a3d726e5cf04cc0)) {
        player[[level.var_8a3d726e5cf04cc0]](itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_db943473454f6ea6);
      } else if(itemdata.type == "killstreak") {
        player thread _handlekillstreakpurchase(itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_db943473454f6ea6);
      } else if(itemdata.type == "fieldupgrade" || itemdata.type == "super") {
        player _handlefieldupgradepurchase(itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_db943473454f6ea6);
      } else if(itemdata.type == "weapon") {
        player function_90b0e9eb26e38443(itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_db943473454f6ea6);
      } else if(itemdata.type == "perk") {
        player function_157316f7321dd26b(itemdata, var_7dddac09987d559e, var_452130d9d126e506);
      } else if(itemdata.type == "special") {
        player _handlespecialpurchase(itemdata, var_7dddac09987d559e, var_452130d9d126e506, kiosk);
      }
    }

    return;
  }

  if(channel == "br_loadout_purchase") {
    defaultloadout = 0;
    loadoutindex = purchaseindex;
    loadoutitemdata = function_601181692f53e4ed("loadout_custom");

    if(function_496ba4f72ba5e5d1(loadoutindex)) {
      loadoutitemdata = function_601181692f53e4ed("loadout_default");
      defaultloadout = 1;
    }

    var_3e487e0c00e4a4c = _getactualcost(player, loadoutitemdata);

    if(player.plundercount < var_3e487e0c00e4a4c) {
      player _closepurchasemenuwithresponse(3);
      return;
    }

    newclasschoice = function_6a38b44a9a4e8761(loadoutindex);
    function_90ca6872b70e4c2e(self, "purchasing_new_loadout");
    player.pers["class"] = newclasschoice;
    player.class = newclasschoice;
    newclassdata = player function_a4968a44b192f2ed(newclasschoice);
    function_be7af2b74939c9b5(player, var_7dddac09987d559e);
    function_a573b91325f9ea32(player, loadoutitemdata, "loadout", "br_loadout_purchased");

    if(istrue(defaultloadout)) {
      function_98bd9179435d1557(self, var_3e487e0c00e4a4c, "defaultLoadout", "loadout_" + loadoutindex);
    } else {
      function_3cf2d6ddf853bdee(self, var_3e487e0c00e4a4c, newclassdata);
    }

    return;
  }

  if(channel == "br_team_revive") {
    var_bf5d82befbb59efe = purchaseindex - 1;
    var_eb276d34779513e3 = !function_946938d9fde4bdce("useTokenToReviveTeammate");
    usetoken = istrue(player.hasrespawntoken) && var_eb276d34779513e3;
    var_69fac551dcf6c2fb = function_601181692f53e4ed("teamrevive");
    var_a120356b021f8e8 = _getactualcost(player, var_69fac551dcf6c2fb);

    if(!usetoken && player.plundercount < var_a120356b021f8e8) {
      player _closepurchasemenuwithresponse(3);
      return 0;
    }

    var_c7869d69dbcf7fd3 = undefined;
    squad = function_9563f2d4e690856d(player.team, "players");

    foreach(squadmate in squad) {
      if(!isDefined(squadmate) || squadmate == player) {
        continue;
      }

      if(isDefined(squadmate.sessionuimemberindex) && squadmate.sessionuimemberindex == var_bf5d82befbb59efe) {
        var_c7869d69dbcf7fd3 = squadmate;
        break;
      }
    }

    if(!isDefined(var_c7869d69dbcf7fd3)) {
      player _closepurchasemenuwithresponse(12);
      return;
    }

    if(!var_c7869d69dbcf7fd3 function_b71e2f7afd69d580() && !getdvarint(@ "hash_4d250e4873e1753e", 0)) {
      if(function_f6c807a601f8a34d(var_c7869d69dbcf7fd3)) {
        player _closepurchasemenuwithresponse(14);
        return;
      }

      if(isalive(var_c7869d69dbcf7fd3)) {
        player _closepurchasemenuwithresponse(15);
        return;
      }

      player _closepurchasemenuwithresponse(13);
      return;
    }

    var_a4c6cda2e74187f2 = 0;

    if(!usetoken) {
      cost = level.br_armory_kiosk.teamrevivecost;
      firesalediscount = level.br_armory_kiosk.teamrevivefiresalediscount;
      function_a573b91325f9ea32(player, var_69fac551dcf6c2fb, "teamrevive");

      if(istrue(player.hasrespawntoken)) {
        var_a4c6cda2e74187f2 = 1;
      } else {
        player function_c00f90a28c41febe(1);
      }

      function_98bd9179435d1557(player, var_a120356b021f8e8, "teamrevive_money", "teamrevive");
    } else {
      var_3a93448a74526680 = [];
      var_3a93448a74526680.cost = 0;
      var_3a93448a74526680.firesalediscount = 0;
      function_a573b91325f9ea32(player, var_3a93448a74526680, "teamrevive");
    }

    if(function_3fcb060110170ac9("kioskRevivePlayer")) {
      var_c7869d69dbcf7fd3 thread function_25fb9a3b7ee98d69("kioskRevivePlayer", player, usetoken);
    } else {
      var_c7869d69dbcf7fd3 thread function_8bd31d20349aa464(player, usetoken);
    }

    if(var_a4c6cda2e74187f2) {
      player function_c00f90a28c41febe(1);
    }

    level thread function_188f8c265a7ef6ea(kiosk.origin, "revive");
    player thread function_234f5394668ed388("br_squadmate_revived");
    return;
  }

  if(channel == "upgrade_weapon") {}
}

function _makekioskpurchase(itemdata) {
  player = self;
  isfiresale = iskioskfiresaleactiveforplayer(player.br_kiosk, player);
  cost = _getactualcost(player, itemdata);
  assert(player.plundercount >= cost);

  if(isfiresale && itemdata.firesalediscount > 0) {
    kioskfiresaledoneforplayer(player.br_kiosk, player);
  }

  if(!function_a8a68668a0b2c9c4()) {
    player thread function_e800498086e36c29("br_kioskBuy", undefined, function_3d48da36c7fd0fdb(itemdata.cost));
  }

  if(cost > 0) {
    player function_78a18c3b6dbfb0a5(cost);
  }

  if(!isDefined(level.br_plunder)) {
    level.br_plunder = spawnStruct();
  }

  if(!isDefined(level.br_plunder.kiosk_spent_total)) {
    level.br_plunder.kiosk_spent_total = 0;
  }

  level.br_plunder.kiosk_spent_total += cost;

  if(!isDefined(level.br_plunder.kiosk_num_purchases)) {
    level.br_plunder.kiosk_num_purchases = 0;
  }

  level.br_plunder.kiosk_num_purchases++;
  player _closepurchasemenuwithresponse(1);
  return cost;
}

function function_a573b91325f9ea32(player, itemdata, itemtyperef, splashref, quantity) {
  cashspent = player _makekioskpurchase(itemdata);
  lootid = itemdata.lootid;

  if(!isDefined(lootid)) {
    lootid = scripts\cp_mp\utility\loot::getlootidfromref(itemdata.ref);
  }

  if(!isDefined(quantity)) {
    quantity = 1;
  }

  if(isDefined(itemtyperef)) {
    function_98bd9179435d1557(player, itemdata.cost, itemtyperef, itemdata.ref);
  }

  if(isDefined(splashref)) {
    player thread function_234f5394668ed388(splashref);
  }
}

function playerlocationselectinterrupt() {
  player = self;
  level endon("game_ended");
  self endon("disconnect");
  player endon("confirm_location");
  waittill_any_ents(player, "death", level, "game_ended");
  player notify("cancel_location");
}

function playerhandlecirclepickitem() {
  self setclientomnvar("ui_buystation_purchase_response", 1);
  self setclientomnvar("ui_buystation_open", 1);
  self setclientomnvar("ui_show_tac_map", 1);
  scripts\cp_mp\utility\player_utility::_freezecontrols(1);
  self beginlocationselection(0, 0, "circle_marker", 0, 4);
  thread playerlocationselectinterrupt();
  returninfo = function_88cafec24778c70c("confirm_location", "cancel_location");
  success = 0;
  self endlocationselection();

  if(isDefined(returninfo) && returninfo.string == "confirm_location") {
    if(function_9cb5f84f96e33914(returninfo.location, 1)) {
      locationtrace = function_5c8ad6e89a9f7b73(returninfo.location);
      groundorg = locationtrace["position"];

      if(function_9cb5f84f96e33914(groundorg, 1)) {
        thread restartcircleelimination(groundorg);
        success = 1;
      } else {
        _closepurchasemenuwithresponse(18);
      }
    }
  }

  scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1);
  self setclientomnvar("ui_show_tac_map", 0);
  return success;
}

function restartcircleelimination(origin) {
  level endon("game_ended");
  level notify("restartCircleElimination");
  var_7c409a7d87b3c6b6 = 60;
  var_5e344cd3618ee701 = 4;
  var_55a74749a759fc2d = -1;
  var_4d700b38444fab26 = 15;
  var_8f6402ad8e91da6a = getdvarint(@ "hash_5ef97113d77c0835", var_7c409a7d87b3c6b6);
  startcircleindex = getdvarint(@ "hash_341f671cd388b556", var_5e344cd3618ee701);
  var_26189638809f7b88 = getdvarint(@ "hash_b925987adb7fbd3e", var_55a74749a759fc2d);
  var_937dd942e0664f1a = getdvarint(@ "hash_3c88a1d746d97236", var_4d700b38444fab26);

  if(level.script == "<dev string:x22>") {
    if(var_8f6402ad8e91da6a == var_7c409a7d87b3c6b6) {
      var_8f6402ad8e91da6a = 25;
    }

    if(startcircleindex == var_5e344cd3618ee701) {
      startcircleindex = 2;
    }
  }

  if(function_3fcb060110170ac9("restartCircleElimination")) {
    thread function_25fb9a3b7ee98d69("restartCircleElimination", origin, var_8f6402ad8e91da6a);
  }

  foreach(player in level.players) {
    player function_234f5394668ed388("br_late_circle_soon");
  }

  if(function_946938d9fde4bdce("circle")) {
    function_fa5baabe8489e675(origin, var_8f6402ad8e91da6a, startcircleindex, var_26189638809f7b88);
    level.brgametype.disabledfeatures["circle"] = undefined;
  }

  if(function_9d18a22123e54d05("allowLateJoiners")) {
    level.allowlatecomers = 0;
    setnojiptime(1, 1);
    setnojipscore(1, 1);
  }

  var_efcf5eb682ef5688 = max(0, var_8f6402ad8e91da6a - var_937dd942e0664f1a);
  wait var_efcf5eb682ef5688;

  foreach(player in level.players) {
    player function_234f5394668ed388("br_late_circle_now");
  }

  var_ad75dbc17e0faf18 = var_8f6402ad8e91da6a - var_efcf5eb682ef5688;
  wait var_ad75dbc17e0faf18;

  if(function_946938d9fde4bdce("teamSpectate")) {
    level thread function_baf6855827fe902();
    level.brgametype.disabledfeatures["teamSpectate"] = undefined;
  }

  if(function_946938d9fde4bdce("oneLife")) {
    level.disablespawning = 1;
    setdynamicdvar(hashcat(@ "scr_", function_67386b14d0c7d1ee(), "_numLives"), 1);
  }
}

function playerhandleredeploy() {
  self setclientomnvar("ui_buystation_purchase_response", 1);
  self setclientomnvar("ui_buystation_open", 1);
  self setclientomnvar("ui_show_tac_map", 1);
  scripts\cp_mp\utility\player_utility::_freezecontrols(1);
  self beginlocationselection(0, 0, "circle_marker", 0, 4);
  thread playerlocationselectinterrupt();
  returninfo = function_88cafec24778c70c("confirm_location", "cancel_location");
  success = 0;
  self endlocationselection();

  if(isDefined(returninfo) && returninfo.string == "confirm_location") {
    locationtrace = function_5c8ad6e89a9f7b73(returninfo.location);
    groundorg = locationtrace["position"];
    _closepurchasemenuwithresponse(18);
  }

  scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1);
  self setclientomnvar("ui_show_tac_map", 0);
  return success;
}

function playerredeploy(groundorigin, overrideheight, overrideyaw) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  var_4630a5df954561f2 = 12000;
  height = overrideheight;

  if(!isDefined(height)) {
    height = var_4630a5df954561f2;
  }

  yaw = overrideyaw;

  if(!isDefined(yaw)) {
    yaw = 0;
  }

  spawnpoint = spawnStruct();
  spawnpoint.origin = groundorigin + (0, 0, height);
  spawnpoint.angles = (0, yaw, 0);
  spawnpoint.height = height;
  streamorigin = player function_20071a4b90f92b46(spawnpoint);
  player.forcespawnorigin = streamorigin;
  var_b59f471c2c064e56 = 1;
  player function_a39e8a33d7378f08();
  wait var_b59f471c2c064e56;
  spawnorigin = spawnpoint.origin;
  spawnangles = spawnpoint.angles;
  startorigin = spawnorigin;

  if(isDefined(streamorigin)) {
    startorigin = streamorigin;
  }

  player function_92e04b29006f91c();
  player function_2cea92d21876a90a(startorigin, spawnangles);
  linker = spawn("script_model", startorigin);
  linker setModel("tag_origin");
  linker.angles = spawnangles;
  linker hide();
  linker showtoplayer(player);
  player playerlinktoabsolute(linker, "tag_origin");
  player function_a593971d75d82113();
  player thread function_1f5865aab1fdafd(linker);
  waitframe();
  player function_b4e05f84b56c7bbf();
  player function_ba38e09a56256701();
  linker playsoundtoplayer("br_ac130_flyby", player);
  wait 1.5;
  player unlink();
  player scripts\common\damage_effects::function_a2b4e6088394bade();
  player clearclienttriggeraudiozone(1);
  player function_6fb380927695ee76();
  falltime = 0;

  if(isDefined(level.parachutedeploydelay)) {
    falltime = level.parachutedeploydelay;
  }

  player.isredeploykeepweapons = 1;
  player thread scripts\cp_mp\parachute::startfreefall(falltime, 0, undefined, undefined, 1);
  player setclientomnvar("ui_br_transition_type", 0);
  player setclientomnvar("ui_show_spectateHud", -1);
  player function_4ec23357b146259c();
  wait 0.5;
  player function_b17054c9879ea13b();
  waitframe();
  linker delete();
}