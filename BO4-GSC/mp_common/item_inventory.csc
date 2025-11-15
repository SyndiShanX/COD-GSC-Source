/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\item_inventory.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\item_inventory_util;
#include scripts\mp_common\item_world;
#include scripts\mp_common\item_world_util;

#namespace item_inventory;

autoexec __init__system__() {
  system::register(#"item_inventory", &__init__, undefined, #"item_world");
}

private __init__() {
  if(!isDefined(getgametypesetting(#"useitemspawns")) || getgametypesetting(#"useitemspawns") == 0) {
    return;
  }

  callback::on_localplayer_spawned(&_on_localplayer_spawned);
  clientfield::register("clientuimodel", "hudItems.multiItemPickup.status", 1, 2, "int", &function_38ebb2a1, 0, 1);
  clientfield::register("clientuimodel", "hudItems.multiItemPickup.status", 17000, 3, "int", &function_38ebb2a1, 0, 1);
  clientfield::register("clientuimodel", "hudItems.healthItemstackCount", 5000, 8, "int", undefined, 0, 0);
  clientfield::register("clientuimodel", "hudItems.equipmentStackCount", 5000, 8, "int", undefined, 0, 0);
  level thread function_d2f05352();
}

private _on_localplayer_spawned(localclientnum) {
  if(self function_da43934d()) {
    self thread function_3e624606(localclientnum);
    self thread function_ac4df751(localclientnum);
    self thread function_ca87f318(localclientnum);
    self thread function_7f35a045(localclientnum);
    self thread function_d1e6731e(localclientnum);
    self thread function_2ae9881d(localclientnum);

    if(ispc()) {
      self thread function_9b83c65d(localclientnum);
    }
  }
}

function_a5c2a6b8(localclientnum) {
  return isDefined(level.tabbedmultiitempickup) && level.tabbedmultiitempickup || !gamepadusedlast(localclientnum);
}

private function_38ebb2a1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  clientdata = item_world::function_a7e98a1a(localclientnum);

  if(newval == 2) {
    clientdata.var_ff9e7e43 = 1;

    if(function_a5c2a6b8(localclientnum)) {
      clientdata.groupitems = [];

      if(isDefined(level.tabbedmultiitempickup) && level.tabbedmultiitempickup) {
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.canUseQuickInventory"), 0);
      }
    }

    return;
  }

  if(newval == 0) {
    clientdata.groupitems = [];
    player = function_27673a7(localclientnum);

    if(isplayer(player) && isalive(player)) {
      player function_9116bb0e(localclientnum, 1);
    }
  }

  if(isDefined(level.tabbedmultiitempickup) && level.tabbedmultiitempickup && oldval == 2) {
    for(i = 0; i < clientdata.inventory.var_c212de25; i++) {
      if(clientdata.inventory.items[i].networkid != 32767) {
        if(clientdata.inventory.items[i].availableaction == 1 || clientdata.inventory.items[i].availableaction == 4 || clientdata.inventory.items[i].availableaction == 2 || clientdata.inventory.items[i].availableaction == 6) {
          setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.canUseQuickInventory"), 1);
          break;
        }
      }
    }
  }
}

private function_3fe6ef04(localclientnum) {
  data = item_world::function_a7e98a1a(localclientnum);
  var_cfa0e915 = [];

  foreach(consumeditem in data.inventory.consumed.items) {
    if(isDefined(var_cfa0e915[consumeditem.itementry.name])) {
      continue;
    }

    var_cfa0e915[consumeditem.itementry.name] = 1;
  }

  return var_cfa0e915.size;
}

private function_88da0c8e(localclientnum) {
  paintcans = stats::get_stat_global(localclientnum, #"items_paint_cans_collected");
  return (isDefined(paintcans) ? paintcans : 0) >= 150;
}

private function_99b22bbc(localclientnum) {
  if(function_96d4f30e(localclientnum)) {
    return false;
  }

  if(isgrappling(localclientnum)) {
    return false;
  }

  if(function_d5f07a6e(localclientnum)) {
    return false;
  }

  return true;
}

private function_ca87f318(localclientnum) {
  self endon(#"shutdown", #"death");
  self notify("8b67206b631ec6e");
  self endon("8b67206b631ec6e");
  clientdata = item_world::function_a7e98a1a(localclientnum);
  var_790695cc = "inventory_equip" + localclientnum;
  var_6e7b39bc = "inventory_detach" + localclientnum;
  clientdata.var_b9730e2b = gettime();

  while(true) {
    waitresult = level waittill(var_790695cc, var_6e7b39bc);

    if(gettime() - clientdata.var_b9730e2b < 300) {
      continue;
    }

    if(waitresult._notify === var_790695cc) {
      networkid = waitresult.id;
      quickequip = isDefined(waitresult.extraarg) ? waitresult.extraarg : 0;

      if(quickequip) {
        var_ed98a5fe = function_15d578f4(localclientnum, networkid);

        if(isDefined(var_ed98a5fe)) {
          itementry = var_ed98a5fe.itementry;
        }

        if(isDefined(itementry) && (itementry.itemtype == #"generic" || itementry.itemtype == #"killstreak")) {
          data = item_world::function_a7e98a1a(localclientnum);
          name = isDefined(itementry.parentname) ? itementry.parentname : itementry.name;

          for(index = 0; index < data.inventory.items.size && index < 16 + 1; index++) {
            inventoryitem = data.inventory.items[index];

            if(!isDefined(inventoryitem.itementry) || isDefined(inventoryitem.endtime)) {
              continue;
            }

            if(inventoryitem.networkid == networkid) {
              continue;
            }

            if(name == (isDefined(inventoryitem.itementry.parentname) ? inventoryitem.itementry.parentname : inventoryitem.itementry.name)) {
              networkid = inventoryitem.networkid;
              break;
            }
          }
        }
      }

      if(isDefined(waitresult.extraarg2)) {
        function_97fedb0d(localclientnum, 11, networkid, quickequip);
      } else {
        function_97fedb0d(localclientnum, 4, networkid, quickequip);
      }
    } else if(waitresult._notify === var_6e7b39bc) {
      networkid = waitresult.id;
      function_97fedb0d(localclientnum, 6, networkid);
    }

    clientdata.var_b9730e2b = gettime();
  }
}

private function_10861362(localclientnum) {
  vehicle = getplayervehicle(self);

  if(!isDefined(vehicle)) {
    return true;
  }

  var_88fa0205 = vehicle getoccupantseat(localclientnum, self);

  if(isDefined(var_88fa0205) && (var_88fa0205 == 0 || var_88fa0205 == 4)) {
    return false;
  }

  return true;
}

private function_ee44351a(localclientnum, inventoryitem) {
  weapon = item_world_util::function_35e06774(inventoryitem.itementry);

  if(!isDefined(weapon)) {
    return true;
  }

  if(weapon == getcurrentweapon(localclientnum) || weapon == function_e9fe14ee(localclientnum)) {
    return function_99b22bbc(localclientnum);
  }

  return true;
}

private function_e23e5e85(localclientnum) {
  clientdata = item_world::function_a7e98a1a(localclientnum);

  if(!isDefined(clientdata) || !isDefined(clientdata.inventory) || !isDefined(clientdata.inventory.items)) {
    return false;
  }

  armoritem = clientdata.inventory.items[11];

  if(!isDefined(armoritem) || armoritem.networkid === 32767 || armoritem.itementry.itemtype !== #"armor") {
    return false;
  }

  clientmodel = getuimodelvalue(getuimodel(getuimodelforcontroller(localclientnum), "predictedClientModel"));
  armormodel = getuimodel(clientmodel, "armor");
  var_15663411 = getuimodel(armoritem.itemuimodel, "armorMax");

  if(!isDefined(armormodel) || !isDefined(var_15663411) || getuimodelvalue(armormodel) == getuimodelvalue(var_15663411)) {
    return false;
  }

  return true;
}

private function_e094fd92(item) {
  if(!isDefined(item) || !isDefined(item.networkid) || item.networkid == 32767 || !isDefined(item.quickequip) || item.quickequip != 1 || !isDefined(item.consumable) || item.consumable != 1) {
    return false;
  }

  return true;
}

private function_f3ef5269(localclientnum) {
  perksarray = [];
  clientdata = item_world::function_a7e98a1a(localclientnum);

  for(i = 0; i < 10; i++) {
    currentitem = clientdata.inventory.items[i];

    if(function_e094fd92(currentitem)) {
      if(!isDefined(perksarray)) {
        perksarray = [];
      } else if(!isarray(perksarray)) {
        perksarray = array(perksarray);
      }

      perksarray[perksarray.size] = currentitem;
    }
  }

  return perksarray;
}

private function_e090a831(localclientnum, networkid) {
  clientdata = item_world::function_a7e98a1a(localclientnum);
  perkindex = 0;

  for(i = 0; i < 10; i++) {
    currentitem = clientdata.inventory.items[i];

    if(function_e094fd92(currentitem)) {
      if(currentitem.networkid == networkid) {
        return perkindex;
      }

      perkindex++;
    }
  }

  return -1;
}

private function_535a5a06(localclientnum, var_6e51c00) {
  assert(var_6e51c00 >= -1 && var_6e51c00 <= 1);
  inventoryuimodel = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory");
  var_f99434b1 = createuimodel(inventoryuimodel, "quickConsumeIndex");
  perksarray = function_f3ef5269(localclientnum);
  var_be32fa6d = perksarray.size;

  if(var_be32fa6d < 2) {
    setuimodelvalue(var_f99434b1, 0);
    return 0;
  }

  quickconsumeindex = getuimodelvalue(var_f99434b1);

  if(!isDefined(quickconsumeindex)) {
    quickconsumeindex = 0;
  }

  quickconsumeindex += var_6e51c00;

  if(quickconsumeindex >= var_be32fa6d) {
    quickconsumeindex = 0;
  } else if(quickconsumeindex < 0) {
    quickconsumeindex = var_be32fa6d - 1;
  }

  setuimodelvalue(var_f99434b1, quickconsumeindex);
  return quickconsumeindex;
}

private function_91483494(localclientnum) {
  return function_1606ff3(localclientnum, 1);
}

private function_9f5d2dc8(localclientnum) {
  return function_1606ff3(localclientnum, 0);
}

private function_1606ff3(localclientnum, var_6e51c00) {
  perksarray = function_f3ef5269(localclientnum);
  currentindex = function_535a5a06(localclientnum, var_6e51c00);
  inventoryuimodel = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory");
  var_98d32f1c = createuimodel(inventoryuimodel, "quickConsumeNetworkId");

  if(isDefined(perksarray[currentindex])) {
    setuimodelvalue(var_98d32f1c, perksarray[currentindex].networkid);
  } else {
    setuimodelvalue(var_98d32f1c, 32767);
  }

  if(perksarray.size > 1) {
    playSound(localclientnum, #"hash_4d31bd9927d823c3");
  }
}

private function_22759012(localclientnum, networkid) {
  perkindex = function_e090a831(localclientnum, networkid);

  if(perkindex > -1) {
    inventoryuimodel = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory");
    var_f99434b1 = createuimodel(inventoryuimodel, "quickConsumeIndex");
    setuimodelvalue(var_f99434b1, perkindex);
    var_98d32f1c = createuimodel(inventoryuimodel, "quickConsumeNetworkId");
    setuimodelvalue(var_98d32f1c, networkid);
    return;
  }

  function_9f5d2dc8(localclientnum);
}

private function_1470ccfe(localclientnum, item) {
  clientdata = item_world::function_a7e98a1a(localclientnum);

  for(i = 0; i < 10; i++) {
    currentitem = clientdata.inventory.items[i];

    if(currentitem.networkid == 32767 || !item_inventory_util::function_73593286(item.itementry, currentitem.itementry) || !isDefined(currentitem.availableaction) || item.availableaction != currentitem.availableaction) {
      continue;
    }

    return currentitem.networkid;
  }

  return undefined;
}

private function_9b83c65d(localclientnum) {
  self endon(#"shutdown", #"death");
  self notify("7448ede5a4a225c6");
  self endon("7448ede5a4a225c6");
  clientdata = item_world::function_a7e98a1a(localclientnum);
  var_ca4fc719 = "inventory_consume" + localclientnum;
  var_e2d1f454 = "inventory_armor_repair_pressed" + localclientnum;
  var_3731e165 = "inventory_armor_repair_released" + localclientnum;
  var_6a10d173 = "inventory_quick_consume" + localclientnum;
  var_ce5c0b10 = "inventory_cycle_quick_consumable" + localclientnum;
  var_17bdd1c3 = "inventory_equip_quick_consumable" + localclientnum;

  while(true) {
    waitresult = level waittill(var_ca4fc719, var_e2d1f454, var_3731e165, var_6a10d173, var_ce5c0b10, var_17bdd1c3);

    if(waitresult._notify === var_ca4fc719) {
      if(!function_10861362(localclientnum)) {
        self playSound(localclientnum, #"uin_unavailable_charging");
        continue;
      }

      inventoryitem = function_15d578f4(localclientnum, waitresult.id);
      function_22759012(localclientnum, inventoryitem.networkid);
    } else if(waitresult._notify === var_17bdd1c3) {
      inventoryitem = function_15d578f4(localclientnum, waitresult.id);
      networkid = function_1470ccfe(localclientnum, inventoryitem);
      function_22759012(localclientnum, isDefined(networkid) ? networkid : inventoryitem.networkid);
      continue;
    } else if(waitresult._notify === var_6a10d173) {
      currentindex = function_535a5a06(localclientnum, 0);
      perksarray = function_f3ef5269(localclientnum);

      if(isDefined(perksarray[currentindex])) {
        inventoryitem = perksarray[currentindex];
      } else {
        continue;
      }
    } else if(waitresult._notify === var_ce5c0b10) {
      function_91483494(localclientnum);
      continue;
    } else {
      inventoryitem = clientdata.inventory.items[16];

      if(!isDefined(inventoryitem) || inventoryitem.networkid === 32767 || inventoryitem.itementry.itemtype !== #"armor_shard") {
        if(waitresult._notify === var_e2d1f454) {
          inventoryuimodel = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory");
          var_3ea10284 = createuimodel(inventoryuimodel, "armorShardNotAvailable");
          forcenotifyuimodel(var_3ea10284);
        }

        continue;
      }

      var_b3d8c077 = function_ab88dbd2(localclientnum, #"armorrepair_toggle");
      var_a3162739 = isDefined(clientdata.inventory.var_f3518190) && inventoryitem == clientdata.inventory.var_f3518190.item;

      if(waitresult._notify === var_e2d1f454) {
        if((!function_e23e5e85(localclientnum) || inventoryitem.count == 0 || !function_10861362(localclientnum)) && (isDefined(var_b3d8c077) && !var_b3d8c077 || isDefined(var_b3d8c077) && var_b3d8c077 && !var_a3162739)) {
          self playSound(localclientnum, #"uin_unavailable_charging");
          inventoryuimodel = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory");
          var_3ea10284 = createuimodel(inventoryuimodel, "armorShardNotAvailable");
          forcenotifyuimodel(var_3ea10284);
          continue;
        }
      } else if(isDefined(var_b3d8c077) && var_b3d8c077 || !var_a3162739) {
        continue;
      }
    }

    if(!isDefined(inventoryitem.itementry.casttime) || inventoryitem.itementry.casttime <= 0) {
      function_97fedb0d(localclientnum, 4, inventoryitem.networkid);
      continue;
    }

    var_eaae8ced = 0;

    if(isDefined(clientdata.inventory.consumed.items) && isarray(clientdata.inventory.consumed.items)) {
      foreach(consumeditem in clientdata.inventory.consumed.items) {
        if(isDefined(consumeditem.itementry.talents) && isarray(consumeditem.itementry.talents)) {
          foreach(talent in consumeditem.itementry.talents) {
            if(talent.talent == #"talent_consumer_wz") {
              var_eaae8ced = 1;
              break;
            }
          }
        }

        if(var_eaae8ced) {
          break;
        }
      }
    }

    if(isDefined(clientdata.inventory.var_f3518190)) {
      if(inventoryitem != clientdata.inventory.var_f3518190.item) {
        setuimodelvalue(createuimodel(clientdata.inventory.var_f3518190.item.itemuimodel, "castTimeFraction"), 0, 0);
        playSound(localclientnum, #"hash_4d31bd9927d823c3");
        var_f3518190 = spawnStruct();
        var_f3518190.item = inventoryitem;
        var_f3518190.caststart = gettime();
        var_f3518190.castend = var_f3518190.caststart + int((isDefined(var_eaae8ced ? var_f3518190.item.itementry.casttime * 0.5 : var_f3518190.item.itementry.casttime) ? var_eaae8ced ? var_f3518190.item.itementry.casttime * 0.5 : var_f3518190.item.itementry.casttime : 0) * 1000);
        clientdata.inventory.var_f3518190 = var_f3518190;
        function_de74158f(localclientnum, var_f3518190.item.networkid);
        clientdata.inventory.var_4d4ec560 = inventoryitem.networkid;
      } else {
        setuimodelvalue(createuimodel(clientdata.inventory.var_f3518190.item.itemuimodel, "castTimeFraction"), 0, 0);
        setuimodelvalue(clientdata.inventory.consumed.var_a25538fb, function_3fe6ef04(localclientnum));
        clientdata.inventory.var_f3518190 = undefined;
        clientdata.inventory.var_4d4ec560 = undefined;
      }

      continue;
    }

    if(!isDefined(clientdata.inventory.var_4d4ec560) || clientdata.inventory.var_4d4ec560 != inventoryitem.networkid) {
      playSound(localclientnum, #"hash_4d31bd9927d823c3");
      var_f3518190 = spawnStruct();
      var_f3518190.item = inventoryitem;
      var_f3518190.caststart = gettime();
      var_f3518190.castend = var_f3518190.caststart + int((isDefined(var_eaae8ced ? var_f3518190.item.itementry.casttime * 0.5 : var_f3518190.item.itementry.casttime) ? var_eaae8ced ? var_f3518190.item.itementry.casttime * 0.5 : var_f3518190.item.itementry.casttime : 0) * 1000);
      clientdata.inventory.var_f3518190 = var_f3518190;
      function_de74158f(localclientnum, var_f3518190.item.networkid);
      clientdata.inventory.var_4d4ec560 = inventoryitem.networkid;
    }
  }
}

private function_ac4df751(localclientnum) {
  self endon(#"shutdown", #"death");
  self notify("697b03f7ded5069f");
  self endon("697b03f7ded5069f");
  clientdata = item_world::function_a7e98a1a(localclientnum);
  var_5054e2f7 = "inventory_drop" + localclientnum;
  var_ffec0c46 = "inventory_drop_current_weapon" + localclientnum;
  var_46a7a0e3 = "inventory_drop_current_weapon_and_detach" + localclientnum;
  var_fcd005cc = "inventory_drop_weapon_in_slot" + localclientnum;
  var_3d759450 = "inventory_drop_weapon_in_slot_and_detach" + localclientnum;

  while(true) {
    waitresult = level waittill(var_5054e2f7, var_ffec0c46, var_46a7a0e3, var_fcd005cc, var_3d759450);

    if(waitresult._notify === var_5054e2f7) {
      networkid = waitresult.id;
      count = waitresult.extraarg;
      itemid = item_world::function_28b42f1c(localclientnum, networkid);

      if(itemid != 32767) {
        if(function_6d9d9cd7(waitresult.selectedindex)) {
          inventoryitem = clientdata.inventory.items[waitresult.selectedindex];

          if(isDefined(inventoryitem) && !function_ee44351a(localclientnum, inventoryitem)) {
            continue;
          }
        }

        if(ispc()) {
          if(isDefined(clientdata.inventory.var_f3518190) && clientdata.inventory.var_f3518190.item.id == itemid) {
            clientdata.inventory.var_f3518190 = undefined;
            clientdata.inventory.var_4d4ec560 = undefined;
            setuimodelvalue(clientdata.inventory.consumed.var_a25538fb, function_3fe6ef04(localclientnum));
          }
        }

        function_97fedb0d(localclientnum, 5, networkid, count);
      }

      continue;
    }

    if(waitresult._notify === var_ffec0c46 || waitresult._notify === var_fcd005cc) {
      weaponslotid = isDefined(waitresult.slotid) ? array(16 + 1, 16 + 1 + 6 + 1)[waitresult.slotid] : function_d768ea30(localclientnum);

      if(isDefined(weaponslotid)) {
        networkid = item_world_util::function_970b8d86(self, weaponslotid);
        function_97fedb0d(localclientnum, 5, networkid);
      }

      continue;
    }

    if(waitresult._notify === var_46a7a0e3 || waitresult._notify === var_3d759450) {
      weaponslotid = isDefined(waitresult.slotid) ? array(16 + 1, 16 + 1 + 6 + 1)[waitresult.slotid] : function_d768ea30(localclientnum);

      if(isDefined(weaponslotid)) {
        networkid = item_world_util::function_970b8d86(self, weaponslotid);
        function_97fedb0d(localclientnum, 8, networkid);
      }
    }
  }
}

private function_8edef5cc(localclientnum, inventoryitem) {
  data = item_world::function_a7e98a1a(localclientnum);
  slot = function_daf3ebda(localclientnum, inventoryitem.itementry);

  if(!isDefined(slot)) {
    slot = self function_78ed4455(localclientnum, inventoryitem.itementry);
  }

  if(isDefined(slot)) {
    if(inventoryitem.itementry.type != #"attachment") {
      item = data.inventory.items[slot];
      setuimodelvalue(createuimodel(item.itemuimodel, "focusTarget"), 1);
    }

    return;
  }

  if(function_ad4c6116(localclientnum, inventoryitem.itementry)) {
    for(i = 0; i < data.inventory.var_c212de25; i++) {
      if(data.inventory.items[i].networkid === 32767) {
        setuimodelvalue(createuimodel(data.inventory.items[i].itemuimodel, "focusTarget"), 1);
        break;
      }
    }
  }
}

private function_96ce9058(localclientnum, var_6c2b2289, inventoryitem, item) {
  level endon(var_6c2b2289);
  self notify("7357e9cab2fc6298");
  self endon("7357e9cab2fc6298");

  if(isDefined(item.itementry.unlockableitemref)) {
    var_1ce96a13 = array(0, 0, 0, 0, 0);

    while(true) {
      waitframe(1);

      for(i = 0; i < 5; i++) {
        if(isDefined(item.itementry.objectives[i]) && isDefined(item.itementry.objectives[i].var_7e835304)) {
          value = stats::get_stat_global(localclientnum, item.itementry.objectives[i].var_7e835304);

          if(isDefined(value) && value != var_1ce96a13[i]) {
            var_1ce96a13[i] = value;
            function_39b663b7(localclientnum, inventoryitem, item);
          }
        }
      }
    }
  }
}

private function_7f35a045(localclientnum) {
  self endon(#"shutdown", #"death");
  self notify("70f223fcee367f6f");
  self endon("70f223fcee367f6f");
  clientdata = item_world::function_a7e98a1a(localclientnum);
  var_6c2b2289 = "inventory_item_focus" + localclientnum;

  while(true) {
    waitresult = level waittill(var_6c2b2289);
    data = item_world::function_a7e98a1a(localclientnum);
    function_534dcb9c(localclientnum);

    if(isDefined(level.var_6d21daaf[localclientnum])) {
      setuimodelvalue(level.var_6d21daaf[localclientnum], 0);
    }

    foreach(weaponslotid in array(16 + 1, 16 + 1 + 6 + 1)) {
      foreach(attachmentoffset in array(1, 2, 3, 4, 5, 6)) {
        var_f9f8c0b5 = weaponslotid + attachmentoffset;
        item = data.inventory.items[var_f9f8c0b5];
        setuimodelvalue(createuimodel(item.itemuimodel, "focusTarget"), 0);
        setuimodelvalue(createuimodel(item.itemuimodel, "notAvailable"), 0);
      }
    }

    setuimodelvalue(createuimodel(data.inventory.items[11].itemuimodel, "focusTarget"), 0);
    setuimodelvalue(createuimodel(data.inventory.items[13].itemuimodel, "focusTarget"), 0);
    setuimodelvalue(createuimodel(data.inventory.items[12].itemuimodel, "focusTarget"), 0);
    setuimodelvalue(createuimodel(data.inventory.items[10].itemuimodel, "focusTarget"), 0);

    for(i = 0; i < 10; i++) {
      setuimodelvalue(createuimodel(data.inventory.items[i].itemuimodel, "focusTarget"), 0);
    }

    if(waitresult._notify !== var_6c2b2289) {
      continue;
    }

    networkid = waitresult.id;
    data.inventory.var_9d51958c = networkid;

    if(networkid === 32767) {
      continue;
    }

    inventoryitem = function_15d578f4(localclientnum, networkid);

    if(isDefined(inventoryitem) && 32767 != inventoryitem.id) {
      item = function_b1702735(inventoryitem.id);

      if(isDefined(item) && isDefined(item.itementry)) {
        self thread function_96ce9058(localclientnum, var_6c2b2289, inventoryitem, item);
      }
    }

    if(!isDefined(inventoryitem) && function_a5c2a6b8(localclientnum) && self clientfield::get_player_uimodel("hudItems.multiItemPickup.status") == 2) {
      arrayremovevalue(data.groupitems, undefined, 0);

      for(index = 0; index < data.groupitems.size; index++) {
        var_81bb13f5 = data.groupitems[index];

        if(var_81bb13f5.networkid === networkid) {
          if(var_81bb13f5.itementry.itemtype != #"ammo" && var_81bb13f5.itementry.itemtype != #"weapon") {
            inventoryitem = var_81bb13f5;
            function_8edef5cc(localclientnum, inventoryitem);
          }

          break;
        }
      }
    }

    if(!isDefined(inventoryitem) || !isDefined(inventoryitem.itementry) || inventoryitem.itementry.itemtype !== #"attachment") {
      continue;
    }

    var_a4250c2b = function_d768ea30(localclientnum);

    foreach(weaponslotid in array(16 + 1, 16 + 1 + 6 + 1)) {
      weaponitem = data.inventory.items[weaponslotid];

      if(weaponitem.id === 32767) {
        continue;
      }

      var_ceefbd10 = item_inventory_util::function_837f4a57(inventoryitem.itementry);
      var_f9f8c0b5 = item_inventory_util::function_dfaca25e(weaponslotid, var_ceefbd10);
      attachmentname = item_inventory_util::function_2ced1d34(weaponitem, inventoryitem.itementry);
      var_86364446 = data.inventory.items[var_f9f8c0b5];

      if(isDefined(attachmentname)) {
        if(networkid != var_86364446.networkid) {
          setuimodelvalue(createuimodel(var_86364446.itemuimodel, "focusTarget"), 1);
        }

        var_fdc9fcff = isDefined(var_a4250c2b) && var_a4250c2b == 16 + 1 ? 16 + 1 + 6 + 1 : 16 + 1;

        if(var_fdc9fcff == weaponslotid) {
          setuimodelvalue(level.var_6d21daaf[localclientnum], 1);
        }

        continue;
      }

      setuimodelvalue(createuimodel(var_86364446.itemuimodel, "notAvailable"), 1);
    }
  }
}

private function_2ae9881d(localclientnum) {
  self endon(#"shutdown", #"death");
  self notify("62a25a832b1d0cff");
  self endon("62a25a832b1d0cff");
  clientdata = item_world::function_a7e98a1a(localclientnum);
  var_f3efb06b = "cycle_health" + localclientnum;
  var_db83305d = "cycle_equipment" + localclientnum;
  clientdata.var_cb55ac3c = gettime();

  while(true) {
    waitresult = level waittill(var_f3efb06b, var_db83305d);

    if(gettime() - clientdata.var_cb55ac3c < 200) {
      continue;
    }

    if(waitresult._notify === var_f3efb06b) {
      function_97fedb0d(localclientnum, 10);
    } else if(waitresult._notify === var_db83305d) {
      function_97fedb0d(localclientnum, 9);
    }

    clientdata.var_cb55ac3c = gettime();
  }
}

private function_d1e6731e(localclientnum) {
  self endon(#"shutdown", #"death");
  self notify("1eaaee589e299bd6");
  self endon("1eaaee589e299bd6");
  clientdata = item_world::function_a7e98a1a(localclientnum);
  var_bd0cdac3 = "attachment_pickup";
  var_b784f644 = var_bd0cdac3 + localclientnum;

  while(true) {
    util::waittill_any_ents(self, var_bd0cdac3, level, var_b784f644);
    currentitem = self.var_9b882d22;

    if(!isDefined(currentitem) || !isDefined(currentitem.itementry)) {
      continue;
    }

    var_512ddf16 = self clientfield::get_player_uimodel("hudItems.multiItemPickup.status") == 2;

    if(self.var_9b882d22.hidetime === -1 && !var_512ddf16) {
      continue;
    }

    if(var_512ddf16 && self.var_54d9f4a6) {
      continue;
    }

    origin = getlocalclienteyepos(localclientnum);

    if(distance2dsquared(origin, currentitem.origin) > 128 * 128 || abs(origin[2] - currentitem.origin[2]) > 128) {
      continue;
    }

    if(!isDefined(currentitem.itementry)) {
      continue;
    }

    equipdata = 0;

    if(!function_ad4c6116(localclientnum, currentitem.itementry)) {
      swap = 0;
      data = item_world::function_a7e98a1a(localclientnum);

      switch (currentitem.itementry.itemtype) {
        case #"equipment":
          swap = 1;
          break;
        case #"health":
          swap = 1;
          break;
        default:
          break;
      }

      if(!swap) {
        continue;
      }

      function_97fedb0d(localclientnum, 7, currentitem.networkid, 2);
      continue;
    } else {
      switch (currentitem.itementry.itemtype) {
        case #"equipment":
          equipdata = 1;
        case #"health":
          equipdata = 1;
        case #"weapon":
          equipdata = 1;
          break;
      }
    }

    function_97fedb0d(localclientnum, 7, currentitem.networkid, equipdata);
  }
}

private function_6d9d9cd7(slotid) {
  assert(isint(slotid));

  foreach(slot in array(10, 11, 12, 13, 16 + 1, 16 + 1 + 6 + 1)) {
    if(slot == slotid) {
      return true;
    }
  }

  return false;
}

private function_d2f05352() {
  level endon(#"shutdown");
  waitframe(1);

  while(true) {
    players = getlocalplayers();
    time = gettime();

    foreach(player in players) {
      if(!isalive(player)) {
        continue;
      }

      localclientnum = player getlocalclientnumber();

      if(!isDefined(localclientnum)) {
        continue;
      }

      data = item_world::function_a7e98a1a(localclientnum);

      if(!isDefined(data) || !isDefined(data.inventory) || !isDefined(data.inventory.items)) {
        continue;
      }

      consumed = data.inventory.consumed;
      var_3ef517e = data.inventory.consumed.items;
      var_95dcc077 = 0;

      for(i = 0; i < var_3ef517e.size; i++) {
        item = var_3ef517e[i];

        if(item.endtime <= time) {
          var_95dcc077 = 1;
          arrayremoveindex(var_3ef517e, i);
          playSound(localclientnum, #"hash_4c7a6e162e2f26a0");
          continue;
        }
      }

      var_cfa0e915 = [];

      for(i = 0; i < var_3ef517e.size; i++) {
        item = var_3ef517e[i];

        if(isDefined(var_cfa0e915[item.itementry.name])) {
          continue;
        }

        var_cfa0e915[item.itementry.name] = 1;
        duration = item.endtime - item.starttime;
        timeremaining = item.endtime - time;

        if(var_95dcc077) {
          item.itemuimodel = createuimodel(consumed.uimodel, "item" + var_cfa0e915.size - 1);
          function_1a99656a(localclientnum, item, item.networkid, item.id, 0, 0, 0, 0);
        }

        frac = 1;

        if(duration > 0) {
          frac = 1 - timeremaining / duration;
        }

        setuimodelvalue(createuimodel(item.itemuimodel, "endStartFraction"), frac, 0);
      }

      if(ispc()) {
        var_f3518190 = data.inventory.var_f3518190;

        if(isDefined(var_f3518190) && var_f3518190.item.id != 32767) {
          duration = var_f3518190.castend - var_f3518190.caststart;
          timeremaining = var_f3518190.castend - time;

          if(timeremaining <= 0) {
            function_97fedb0d(localclientnum, 4, var_f3518190.item.networkid);
            setuimodelvalue(createuimodel(var_f3518190.item.itemuimodel, "castTimeFraction"), 0, 0);
            data.inventory.var_f3518190 = undefined;

            if(var_f3518190.item.networkid == data.inventory.items[16].networkid) {
              var_95dcc077 = 1;

              if(!function_e23e5e85(localclientnum)) {
                data.inventory.var_4d4ec560 = undefined;
              }
            }
          } else {
            setuimodelvalue(createuimodel(var_f3518190.item.itemuimodel, "castTimeFraction"), 1 - timeremaining / duration, 0);
            uimodel = getuimodel(data.inventory.consumed.uimodel, "item" + function_3fe6ef04(localclientnum));

            if(isDefined(uimodel)) {
              setuimodelvalue(createuimodel(uimodel, "castTimeFraction"), 1 - timeremaining / duration, 0);
            }
          }
        }
      }

      for(index = 0; index < 10; index++) {
        item = data.inventory.items[index];

        if(!isDefined(item.endtime)) {
          continue;
        }

        duration = item.endtime - item.starttime;
        timeremaining = item.endtime - time;
        frac = 1;

        if(duration > 0) {
          frac = 1 - timeremaining / duration;
        }

        setuimodelvalue(createuimodel(item.itemuimodel, "endStartFraction"), frac, 0);
      }

      if(var_95dcc077) {
        setuimodelvalue(consumed.var_a25538fb, var_cfa0e915.size);
        function_9f5d2dc8(localclientnum);
      }
    }

    players = undefined;
    waitframe(1);
  }
}

private function_fe189514(itementry) {
  if(isDefined(itementry) && isDefined(itementry.weapon)) {
    return (isDefined(itementry.weapon.name) ? itementry.weapon.name : #"");
  }

  return #"";
}

private function_1a99656a(localclientnum, inventoryitem, networkid, itemid, count, totalcount, availableaction, var_e35261f6 = 1, var_189fcf49 = 0, var_1204dfe9 = 1) {
  data = undefined;

  if(itemid == 32767 && isDefined(inventoryitem.networkid) && inventoryitem.networkid != 32767) {
    data = level.var_d342a3fd[localclientnum];
  } else if(itemid != 32767 && inventoryitem.networkid === 32767) {
    data = level.var_d342a3fd[localclientnum];
  } else if(isDefined(inventoryitem.itementry) && inventoryitem.itementry.itemtype === #"armor_shard") {
    data = level.var_d342a3fd[localclientnum];
  }

  var_dbce1e30 = 0;

  if(inventoryitem.id === itemid && isDefined(inventoryitem.count) && inventoryitem.count > count) {
    var_dbce1e30 = 1;

    if(isDefined(inventoryitem.itementry) && inventoryitem.itementry.itemtype === #"armor_shard") {
      clientdata = item_world::function_a7e98a1a(localclientnum);

      if(isDefined(clientdata) && isDefined(clientdata.inventory) && networkid === clientdata.inventory.var_4d4ec560) {
        clientdata.inventory.var_4d4ec560 = undefined;
      }
    }
  }

  player = function_27673a7(localclientnum);
  var_1bd87f37 = 1;

  if(isDefined(inventoryitem.itementry) && inventoryitem.itementry.itemtype == #"armor_shard" && networkid == 32767 && var_1204dfe9 == 0) {
    var_1bd87f37 = 0;
  }

  var_d5042302 = isDefined(inventoryitem.itementry) && inventoryitem.itementry.itemtype === #"attachment";
  var_1c54cff7 = inventoryitem.itementry;

  if(var_1bd87f37) {
    inventoryitem.id = itemid;
    inventoryitem.networkid = networkid;
  } else {
    itemid = inventoryitem.id;
    networkid = inventoryitem.networkid;
  }

  inventoryitem.count = count;
  inventoryitem.itementry = 32767 == itemid ? undefined : function_b1702735(itemid).itementry;
  inventoryitem.availableaction = availableaction;
  inventoryitem.consumable = isDefined(inventoryitem.itementry) ? inventoryitem.itementry.consumable : undefined;
  inventoryitem.quickequip = 0;

  if(var_e35261f6) {
    inventoryitem.starttime = undefined;
    inventoryitem.endtime = undefined;
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "endStartFraction"), 0, 0);
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "castTimeFraction"), 0, 0);
  }

  setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "id"), inventoryitem.networkid);
  setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "realId"), inventoryitem.id);
  setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "stackCount"), count);

  if(isDefined(inventoryitem.itementry) && inventoryitem.itementry.itemtype == #"armor_shard") {
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "totalCount"), count);
  } else {
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "totalCount"), totalcount);
  }

  item = undefined;

  if(itemid != 32767) {
    item = function_b1702735(itemid);
  }

  if(itemid == 32767 || !isDefined(item.itementry)) {
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "name"), #"");
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "icon"), #"blacktransparent");
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "rarity"), "None");
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "availableAction"), availableaction);
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "stowedAvailableAction"), 0);
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "canTransferAttachment"), 0);
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "consumable"), 0);
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "assetName"), #"");
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "description"), #"");
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "castTime"), 0);
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "type"), "");
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "equipped"), 0);
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "endStartFraction"), 0, 0);
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "castTimeFraction"), 0, 0);
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "notAvailable"), 0);
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "notAccessible"), 0);
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "focusTarget"), 0);
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "quickEquip"), 0);
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "cycle"), 0);
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "armorMax"), 0);
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "hasAttachments"), 0);
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "supportsAttachments"), 0);
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "unlockableItemRef"), #"");
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "quote"), #"");
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "rewardName"), #"");
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "ammoType"), #"");
    function_442857e2(localclientnum, var_1c54cff7);
  } else {
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "name"), item_world::get_item_name(item.itementry));
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "icon"), isDefined(item.itementry.icon) ? item.itementry.icon : #"blacktransparent");
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "rarity"), isDefined(item.itementry.rarity) ? item.itementry.rarity : "None");
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "assetName"), function_fe189514(item.itementry));
    armormax = 0;

    if(isDefined(item.itementry) && item.itementry.itemtype == #"armor") {
      armormax = isDefined(item.itementry.amount) ? item.itementry.amount : 0;
    }

    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "armorMax"), armormax);
    description = isDefined(item.itementry.description) ? item.itementry.description : #"";

    if(getdvar(#"hash_4a5fd7d94cfc9dfd", 0) == 1) {
      if(isDefined(item.itementry.unlockableitemref)) {
        if(isDefined(item.itementry.var_a51bc1f7)) {
          description = isDefined(item.itementry.var_a51bc1f7) ? item.itementry.var_a51bc1f7 : #"";
        }
      }
    }

    if(description == #"" && isDefined(item.itementry.weapon)) {
      itemindex = getitemindexfromref(item.itementry.weapon.name);
      var_97dcd0a5 = getunlockableiteminfofromindex(itemindex);

      if(isDefined(var_97dcd0a5) && isDefined(var_97dcd0a5.description)) {
        description = var_97dcd0a5.description;
      }
    }

    if(isDefined(item.itementry) && item.itementry.itemtype === #"resource") {
      if(function_88da0c8e(localclientnum)) {
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "notAccessible"), 1);
        description = isDefined(item.itementry.descriptionalt) ? item.itementry.descriptionalt : description;
      }
    }

    if(isDefined(item.itementry) && item.itementry.itemtype === #"weapon") {
      supportsattachments = item_inventory_util::function_4bd83c04(item);
      setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "supportsAttachments"), supportsattachments);
      var_754fe8c5 = getweaponammotype(item.itementry.weapon);

      if(isDefined(level.var_c53d118f) && isDefined(level.var_c53d118f[var_754fe8c5])) {
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "ammoType"), level.var_c53d118f[var_754fe8c5]);
      } else {
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "ammoType"), #"");
      }
    }

    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "description"), description);
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "castTime"), isDefined(item.itementry.casttime) ? item.itementry.casttime : 0);
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "type"), item.itementry.itemtype);
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "equipped"), isDefined(inventoryitem.endtime));
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "availableAction"), availableaction);
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "stowedAvailableAction"), 0);
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "consumable"), 0);

    if(isDefined(item.itementry.unlockableitemref)) {
      function_39b663b7(localclientnum, inventoryitem, item);
    } else {
      setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "unlockableItemRef"), #"");
      setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "quote"), #"");
      setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "rewardName"), #"");
    }

    if(!var_189fcf49) {
      function_442857e2(localclientnum, isDefined(inventoryitem.itementry) ? inventoryitem.itementry : var_1c54cff7);
    }

    if(count != 0 && !var_dbce1e30) {
      function_8ffee46f(localclientnum, inventoryitem);
    }
  }

  if(isDefined(data)) {
    canusequickinventory = 0;
    filledslots = 0;

    for(i = 0; i < data.inventory.var_c212de25; i++) {
      if(data.inventory.items[i].networkid != 32767) {
        if(data.inventory.items[i].availableaction == 1 || data.inventory.items[i].availableaction == 4 || data.inventory.items[i].availableaction == 2 || data.inventory.items[i].availableaction == 6) {
          if(isDefined(data.inventory.items[i].quickequip) && data.inventory.items[i].quickequip) {
            canusequickinventory |= 1;
          }
        }

        filledslots++;
      }
    }

    shardcount = 0;

    if(data.inventory.items[16].networkid != 32767 && data.inventory.items[16].count > 0) {
      filledslots++;
      canusequickinventory |= 1;
    }

    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.filledSlots"), filledslots);
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.canUseQuickInventory"), canusequickinventory);
    var_a966c73b = data.inventory.items[15];
    inventoryuimodel = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory");

    if(var_a966c73b.networkid != 32767) {
      setuimodelvalue(createuimodel(inventoryuimodel, "resourceCount"), 2);
    } else {
      setuimodelvalue(createuimodel(inventoryuimodel, "resourceCount"), 1);
    }

    if(itemid !== 32767 && isDefined(inventoryitem.itementry) && inventoryitem.itementry.itemtype === #"weapon") {
      foreach(weaponslotid in array(16 + 1, 16 + 1 + 6 + 1)) {
        if(data.inventory.items[weaponslotid].networkid === networkid) {
          attachmentslots = array("attachSlotOptics", "attachSlotBarrel", "attachSlotRail", "attachSlotMagazine", "attachSlotBody", "attachSlotStock");

          foreach(index, attachmentoffset in array(1, 2, 3, 4, 5, 6)) {
            slot = attachmentslots[index];
            var_f9f8c0b5 = item_inventory_util::function_dfaca25e(weaponslotid, attachmentoffset);
            attachmentitem = data.inventory.items[var_f9f8c0b5];

            if(!isDefined(inventoryitem.itementry.(slot))) {
              setuimodelvalue(createuimodel(attachmentitem.itemuimodel, "disabled"), 1);
              continue;
            }

            setuimodelvalue(createuimodel(attachmentitem.itemuimodel, "disabled"), 0);
          }

          break;
        }
      }
    }

    if(itemid !== 32767 && isDefined(inventoryitem.itementry) && inventoryitem.itementry.itemtype === #"attachment") {
      var_f9f8c0b5 = item_world_util::function_808be9a3(player, inventoryitem.networkid);
      var_2cf6fb05 = undefined;

      foreach(weaponslotid in array(16 + 1, 16 + 1 + 6 + 1)) {
        if(item_inventory_util::function_398b9770(weaponslotid, var_f9f8c0b5)) {
          var_2cf6fb05 = weaponslotid;
          break;
        }
      }

      if(isDefined(var_2cf6fb05)) {
        function_cb7cfe5b(localclientnum, var_2cf6fb05, inventoryitem);
        hasattachments = has_attachments(localclientnum, var_2cf6fb05);
        var_508262d4 = data.inventory.items[var_2cf6fb05];

        if(hasattachments) {
          setuimodelvalue(createuimodel(var_508262d4.itemuimodel, "hasAttachments"), 1);
        } else {
          setuimodelvalue(createuimodel(var_508262d4.itemuimodel, "hasAttachments"), 0);
        }
      } else {
        var_a4250c2b = player function_d768ea30(localclientnum);
        function_cb7cfe5b(localclientnum, var_a4250c2b, inventoryitem);
      }

      function_ce628f27(localclientnum);
      return;
    }

    if(var_d5042302) {
      var_a4250c2b = player function_d768ea30(localclientnum);
      hasattachments = has_attachments(localclientnum, var_a4250c2b);

      if(isDefined(var_a4250c2b)) {
        var_508262d4 = data.inventory.items[var_a4250c2b];

        if(hasattachments) {
          setuimodelvalue(createuimodel(var_508262d4.itemuimodel, "hasAttachments"), 1);
        } else {
          setuimodelvalue(createuimodel(var_508262d4.itemuimodel, "hasAttachments"), 0);
        }
      }

      function_deddbdf0(localclientnum, var_a4250c2b);
      function_ce628f27(localclientnum);
    }
  }
}

private function_8bb02a48(localclientnum) {
  data = item_world::function_a7e98a1a(localclientnum);

  if(!isDefined(data)) {
    return;
  }

  var_b8f1b496 = data.inventory.items[12];
  var_7007b688 = [];

  if(isDefined(var_b8f1b496.itementry)) {
    var_7007b688 = item_world_util::function_4cbb6617(data.inventory, #"equipment", array(#"frag_grenade_wz_item", #"cluster_semtex_wz_item", #"acid_bomb_wz_item", #"molotov_wz_item", #"wraithfire_wz_item", #"hatchet_wz_item", #"tomahawk_t8_wz_item", #"seeker_mine_wz_item", #"dart_wz_item", #"hawk_wz_item", #"ultimate_turret_wz_item", #"swat_grenade_wz_item", #"concussion_wz_item", #"smoke_grenade_wz_item", #"smoke_grenade_wz_item_spring_holiday", #"emp_grenade_wz_item", #"spectre_grenade_wz_item", #"grapple_wz_item", #"unlimited_grapple_wz_item", #"barricade_wz_item", #"spiked_barrier_wz_item", #"trophy_system_wz_item", #"concertina_wire_wz_item", #"sensor_dart_wz_item", #"supply_pod_wz_item", #"trip_wire_wz_item", #"cymbal_monkey_wz_item", #"homunculus_wz_item", #"vision_pulse_wz_item", #"flare_gun_wz_item", #"flare_gun_veh_wz_item", #"wz_snowball", #"wz_waterballoon"), var_b8f1b496.itementry);
  }

  for(index = 0; index < var_7007b688.size && index < 2; index++) {
    equipmentitem = data.inventory.equipmentitems[index];
    inventoryitem = var_7007b688[index];
    function_1a99656a(localclientnum, equipmentitem, inventoryitem.networkid, inventoryitem.id, inventoryitem.count, function_bba770de(localclientnum, inventoryitem.itementry), inventoryitem.availableaction, undefined, 1);
    setuimodelvalue(createuimodel(equipmentitem.itemuimodel, "cycle"), 1);
    forcenotifyuimodel(createuimodel(equipmentitem.itemuimodel, "totalCount"));
  }

  for(index = var_7007b688.size; index < 2; index++) {
    equipmentitem = data.inventory.equipmentitems[index];
    function_1a99656a(localclientnum, equipmentitem, 32767, 32767, 0, 0, 0, undefined, 1);
    setuimodelvalue(createuimodel(equipmentitem.itemuimodel, "cycle"), 0);
  }
}

private function_5c2fff73(localclientnum) {
  data = item_world::function_a7e98a1a(localclientnum);

  if(!isDefined(data)) {
    return;
  }

  var_765bac06 = data.inventory.items[10];
  var_7007b688 = [];

  if(isDefined(var_765bac06.itementry)) {
    var_7007b688 = item_world_util::function_4cbb6617(data.inventory, #"health", array(#"health_item_small", #"health_item_medium", #"health_item_large", #"health_item_squad"), var_765bac06.itementry);
  }

  for(index = 0; index < var_7007b688.size && index < 2; index++) {
    healthitem = data.inventory.healthitems[index];
    inventoryitem = var_7007b688[index];
    function_1a99656a(localclientnum, healthitem, inventoryitem.networkid, inventoryitem.id, inventoryitem.count, function_bba770de(localclientnum, inventoryitem.itementry), inventoryitem.availableaction, undefined, 1);
    setuimodelvalue(createuimodel(healthitem.itemuimodel, "cycle"), 1);
    forcenotifyuimodel(createuimodel(healthitem.itemuimodel, "totalCount"));
  }

  for(index = var_7007b688.size; index < 2; index++) {
    healthitem = data.inventory.healthitems[index];
    function_1a99656a(localclientnum, healthitem, 32767, 32767, 0, 0, 0, undefined, 1);
    setuimodelvalue(createuimodel(healthitem.itemuimodel, "cycle"), 0);
  }
}

private function_442857e2(localclientnum, itementry) {
  if(!isDefined(itementry)) {
    return;
  }

  if(itementry.itemtype !== #"equipment" && itementry.itemtype !== #"generic" && itementry.itemtype !== #"health" && itementry.itemtype !== #"killstreak" && itementry.itemtype !== #"attachment" && itementry.itemtype !== #"armor_shard") {
    return;
  }

  data = item_world::function_a7e98a1a(localclientnum);

  if(!isDefined(data)) {
    return;
  }

  var_6962e967 = 0;

  if(itementry.itemtype == #"attachment") {
    player = function_27673a7(localclientnum);
    var_a4250c2b = player function_d768ea30(localclientnum);

    if(isDefined(var_a4250c2b)) {
      var_55022c4f = array(1, 2, 3, 4, 5, 6);

      for(attachmentindex = 0; attachmentindex < var_55022c4f.size; attachmentindex++) {
        attachmentoffset = var_55022c4f[attachmentindex];
        var_f9f8c0b5 = item_inventory_util::function_dfaca25e(var_a4250c2b, attachmentoffset);
        inventoryitem = data.inventory.items[var_f9f8c0b5];

        if(inventoryitem.networkid != 32767 && item_inventory_util::function_73593286(itementry, inventoryitem.itementry)) {
          var_6962e967 = 1;
          break;
        }
      }
    }
  } else if(itementry.itemtype == #"armor_shard") {
    inventoryitem = data.inventory.items[16];
  } else {
    foreach(slot in array(10, 11, 12, 13, 16 + 1, 16 + 1 + 6 + 1)) {
      inventoryitem = data.inventory.items[slot];

      if(inventoryitem.networkid != 32767 && item_inventory_util::function_73593286(itementry, inventoryitem.itementry)) {
        var_6962e967 = 1;
        break;
      }
    }
  }

  totalcount = function_bba770de(localclientnum, itementry);

  if(itementry.itemtype == #"armor_shard") {
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "quickEquip"), totalcount > 0);
  } else {
    var_6d4bb070 = 0;

    for(index = 0; index < 10; index++) {
      inventoryitem = data.inventory.items[index];

      if(inventoryitem.networkid == 32767 || !item_inventory_util::function_73593286(itementry, inventoryitem.itementry)) {
        continue;
      }

      if(var_6962e967 || var_6d4bb070 || isDefined(inventoryitem.endtime)) {
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "quickEquip"), 0);
        inventoryitem.quickequip = 0;
      } else if(!var_6d4bb070) {
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "quickEquip"), 1);
        inventoryitem.quickequip = 1;
        var_6d4bb070 = 1;
      }

      setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "totalCount"), totalcount);
    }
  }

  if(itementry.itemtype === #"health") {
    function_5c2fff73(localclientnum);
    return;
  }

  if(itementry.itemtype === #"equipment") {
    function_8bb02a48(localclientnum);
  }
}

private function_39b663b7(localclientnum, inventoryitem, item) {
  var_409a5960 = createuimodel(getuimodelforcontroller(localclientnum), "questInfo");
  itemindex = getitemindexfromref(item.itementry.unlockableitemref);

  if(itemindex !== 0) {
    var_10d25c94 = createuimodel(var_409a5960, itemindex);

    if(!isDefined(getuimodel(var_10d25c94, "completed"))) {
      setuimodelvalue(createuimodel(var_10d25c94, "completed"), 0);
    }

    for(i = 0; i < 5; i++) {
      description = undefined;
      objectivemodel = createuimodel(var_10d25c94, "objective" + i + 1);

      if(!isDefined(objectivemodel)) {
        continue;
      }

      if(!isDefined(getuimodel(objectivemodel, "state"))) {
        setuimodelvalue(createuimodel(objectivemodel, "state"), 0);
      }

      if(isDefined(item.itementry.objectives[i])) {
        if(isDefined(item.itementry.objectives[i].teamsizedescriptions) && item.itementry.objectives[i].teamsizedescriptions.size > 0) {
          numplayers = getgametypesetting("maxTeamPlayers");

          foreach(objectivestruct in item.itementry.objectives[i].teamsizedescriptions) {
            if(objectivestruct.teamsize == numplayers) {
              description = objectivestruct.description;
              break;
            }
          }
        }

        if(!isDefined(description)) {
          description = item.itementry.objectives[i].description;
        }

        var_2571317b = 0;

        if(isDefined(item.itementry.objectives[i].var_7e835304)) {
          var_2571317b = setuimodelvalue(createuimodel(objectivemodel, "unlockProgress"), stats::get_stat_global(localclientnum, item.itementry.objectives[i].var_7e835304));
        } else {
          setuimodelvalue(createuimodel(objectivemodel, "unlockProgress"), -1);
        }

        if(!setuimodelvalue(createuimodel(objectivemodel, "description"), description) && var_2571317b) {
          forcenotifyuimodel(createuimodel(objectivemodel, "description"));
        }

        continue;
      }

      setuimodelvalue(createuimodel(objectivemodel, "unlockProgress"), -1);
      setuimodelvalue(createuimodel(objectivemodel, "description"), #"");
    }

    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "unlockableItemRef"), item.itementry.unlockableitemref);
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "quote"), item.itementry.var_e8b98a8a);
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "rewardName"), item.itementry.rewardname);
  }
}

private function_cb7cfe5b(localclientnum, var_a4250c2b, var_ac517de7) {
  if(var_ac517de7.networkid === 32767 || !isDefined(var_ac517de7.itementry) || var_ac517de7.itementry.itemtype !== #"attachment") {
    return;
  }

  if(!isDefined(var_a4250c2b)) {
    setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "availableAction"), 0);
    setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "notAvailable"), 1);
    return;
  }

  data = item_world::function_a7e98a1a(localclientnum);
  var_ac044d12 = undefined;
  var_fdc9fcff = undefined;
  var_ffd2f6e4 = undefined;
  var_ac044d12 = data.inventory.items[var_a4250c2b];
  var_fdc9fcff = var_a4250c2b == 16 + 1 ? 16 + 1 + 6 + 1 : 16 + 1;
  var_ffd2f6e4 = data.inventory.items[var_fdc9fcff];
  noweapon = !isDefined(var_ac044d12) || var_ac044d12.networkid === 32767 || !isDefined(var_ac044d12.itementry) || var_ac044d12.itementry.itemtype !== #"weapon";
  var_cdef462d = !isDefined(var_ffd2f6e4) || var_ffd2f6e4.networkid === 32767 || !isDefined(var_ffd2f6e4.itementry) || var_ffd2f6e4.itementry.itemtype !== #"weapon";

  if(noweapon) {
    setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "availableAction"), 0);
    setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "notAvailable"), 1);

    if(var_cdef462d) {
      setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "stowedAvailableAction"), 0);
      return;
    }
  }

  var_ceefbd10 = item_inventory_util::function_837f4a57(var_ac517de7.itementry);

  if(isDefined(item_inventory_util::function_2ced1d34(var_ac044d12, var_ac517de7.itementry))) {
    var_f9f8c0b5 = item_inventory_util::function_dfaca25e(var_a4250c2b, var_ceefbd10);

    if(data.inventory.items[var_f9f8c0b5].networkid !== 32767) {
      setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "availableAction"), 3);
    } else {
      setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "availableAction"), 2);
    }

    setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "notAvailable"), 0);
    function_442857e2(localclientnum, var_ac517de7.itementry);
  } else {
    setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "availableAction"), 0);
    setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "notAvailable"), 1);
  }

  if(var_cdef462d) {
    setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "stowedAvailableAction"), 0);
    return;
  }

  if(isDefined(item_inventory_util::function_2ced1d34(var_ffd2f6e4, var_ac517de7.itementry))) {
    var_50f8a92d = item_inventory_util::function_dfaca25e(var_fdc9fcff, var_ceefbd10);

    if(data.inventory.items[var_50f8a92d].networkid !== 32767) {
      setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "stowedAvailableAction"), 3);
    } else {
      setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "stowedAvailableAction"), 2);
    }

    return;
  }

  setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "stowedAvailableAction"), 0);
}

private function_deddbdf0(localclientnum, var_f7956021) {
  data = item_world::function_a7e98a1a(localclientnum);

  for(itemindex = 0; itemindex < data.inventory.var_c212de25; itemindex++) {
    inventoryitem = data.inventory.items[itemindex];
    function_cb7cfe5b(localclientnum, var_f7956021, inventoryitem);
  }
}

private function_ce628f27(localclientnum) {
  data = item_world::function_a7e98a1a(localclientnum);

  foreach(var_a4250c2b in array(16 + 1, 16 + 1 + 6 + 1)) {
    var_ac044d12 = data.inventory.items[var_a4250c2b];
    var_fdc9fcff = var_a4250c2b == 16 + 1 ? 16 + 1 + 6 + 1 : 16 + 1;
    var_ffd2f6e4 = data.inventory.items[var_fdc9fcff];

    foreach(attachmentoffset in array(1, 2, 3, 4, 5, 6)) {
      var_f9f8c0b5 = var_a4250c2b + attachmentoffset;
      var_50f8a92d = var_fdc9fcff + attachmentoffset;
      var_ac517de7 = data.inventory.items[var_f9f8c0b5];
      var_3c2da577 = data.inventory.items[var_50f8a92d];

      if(var_ac517de7.networkid === 32767 || !isDefined(var_ac517de7.itementry)) {
        continue;
      }

      if(var_3c2da577.networkid === 32767 || !isDefined(var_3c2da577.itementry)) {
        if(isDefined(var_ffd2f6e4) && isDefined(var_ffd2f6e4.itementry) && isDefined(item_inventory_util::function_2ced1d34(var_ffd2f6e4, var_ac517de7.itementry))) {
          setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "canTransferAttachment"), 2);
          continue;
        }

        setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "canTransferAttachment"), 0);
        continue;
      }

      if(isDefined(item_inventory_util::function_2ced1d34(var_ffd2f6e4, var_ac517de7.itementry)) && isDefined(item_inventory_util::function_2ced1d34(var_ac044d12, var_3c2da577.itementry))) {
        setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "canTransferAttachment"), 3);
        continue;
      }

      setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "canTransferAttachment"), 0);
    }
  }
}

is_inventory_item(localclientnum, itementry) {
  data = item_world::function_a7e98a1a(localclientnum);

  if(itementry.itemtype == #"ammo") {
    return false;
  }

  return true;
}

private function_a4a6f064(localclientnum, itementry) {
  return isDefined(function_daf3ebda(localclientnum, itementry));
}

function_daf3ebda(localclientnum, itementry) {
  if(!(isDefined(itementry.stackable) && itementry.stackable)) {
    return undefined;
  }

  data = item_world::function_a7e98a1a(localclientnum);
  maxstack = item_inventory_util::function_cfa794ca(data.inventory.var_7658cbec, itementry);

  if(maxstack <= 1) {
    return undefined;
  }

  clientdata = item_world::function_a7e98a1a(localclientnum);

  if(itementry.itemtype == #"resource") {
    if(item_world_util::function_41f06d9d(itementry) && clientdata.inventory.items[14].count < maxstack) {
      return 14;
    }

    var_ee79c3a4 = clientdata.inventory.items[15];

    if(!isDefined(var_ee79c3a4.id) || var_ee79c3a4.id == 32767) {
      return 15;
    }

    if(var_ee79c3a4.itementry.name !== itementry.name) {
      return undefined;
    }

    if(var_ee79c3a4.count < maxstack) {
      return 15;
    }

    return undefined;
  }

  if(itementry.itemtype == #"armor_shard") {
    if(clientdata.inventory.items[16].count < maxstack) {
      return 16;
    }

    return undefined;
  }

  for(i = 0; i < clientdata.inventory.items.size; i++) {
    if(!isDefined(clientdata.inventory.items[i].id) || clientdata.inventory.items[i].id == 32767) {
      continue;
    }

    inventoryitem = function_b1702735(clientdata.inventory.items[i].id);

    if(!isDefined(inventoryitem) || !isDefined(inventoryitem.itementry)) {
      continue;
    }

    if(inventoryitem.itementry.name !== itementry.name) {
      continue;
    }

    if(clientdata.inventory.items[i].count < maxstack) {
      return i;
    }
  }

  return undefined;
}

private function_3e624606(localclientnum) {
  self endon(#"shutdown", #"death");
  self notify("3260d2bc5ad24d7b");
  self endon("3260d2bc5ad24d7b");
  clientdata = item_world::function_a7e98a1a(localclientnum);
  var_99fe8c78 = "multi_item_pickup" + localclientnum;
  var_dab12fb1 = "multi_item_pickup_stowed_weapon" + localclientnum;

  while(true) {
    waitresult = level waittill(var_99fe8c78, var_dab12fb1);

    if(self clientfield::get_player_uimodel("hudItems.multiItemPickup.status") == 2) {
      networkid = waitresult.id;
      index = item_world::function_73436347(clientdata.groupitems, networkid);
      itemid = item_world::function_28b42f1c(localclientnum, networkid);

      if(itemid == 32767) {
        continue;
      }

      if(isDefined(index)) {
        item = function_b1702735(itemid);

        if(!function_ad4c6116(localclientnum, item.itementry)) {
          continue;
        }

        if(waitresult._notify === var_dab12fb1) {
          function_97fedb0d(localclientnum, 12, networkid);
        } else {
          function_97fedb0d(localclientnum, 3, networkid);
        }

        function_7f056944(localclientnum, index);

        if(!is_inventory_item(localclientnum, item.itementry)) {
          continue;
        }
      }
    }
  }
}

private function_30697356(localclientnum, itementry) {
  if(!isDefined(itementry)) {
    return 0;
  }

  if(itementry.itemtype === #"armor_shard") {
    return 6;
  }

  if(isDefined(itementry.consumable) && itementry.consumable) {
    return 4;
  }

  if(itementry.itemtype === #"generic") {
    return 0;
  }

  if(itementry.itemtype === #"cash") {
    return 0;
  }

  if(itementry.itemtype === #"killstreak") {
    return 4;
  }

  if(itementry.itemtype === #"armor") {
    return 0;
  }

  if(itementry.itemtype === #"ammo") {
    return 0;
  }

  if(itementry.itemtype == #"weapon") {
    return 0;
  }

  if(itementry.itemtype == #"quest") {
    return 0;
  }

  if(itementry.itemtype === #"attachment") {
    return 2;
  }

  return 1;
}

function_ad4c6116(localclientnum, itementry) {
  if(itementry.itemtype == #"weapon") {
    return true;
  }

  if(!is_inventory_item(localclientnum, itementry)) {
    return true;
  }

  if(itementry.itemtype == #"resource") {
    if(item_world_util::function_41f06d9d(itementry)) {
      return !function_88da0c8e(localclientnum);
    }
  }

  if(itementry.itemtype == #"armor") {
    return true;
  }

  if(itementry.itemtype == #"attachment") {
    slotid = function_1415f8f1(localclientnum, itementry);

    if(isDefined(slotid)) {
      return true;
    }
  }

  if(function_a243ddd6(localclientnum, itementry)) {
    return true;
  }

  if(function_a4a6f064(localclientnum, itementry)) {
    return true;
  }

  if(itementry.itemtype == #"armor_shard") {
    return false;
  }

  data = item_world::function_a7e98a1a(localclientnum);

  if(itementry.itemtype == #"resource") {
    if(data.inventory.items[15].networkid === 32767) {
      return true;
    }

    return false;
  }

  for(i = 0; i < data.inventory.var_c212de25; i++) {
    if(data.inventory.items[i].networkid === 32767) {
      return true;
    }
  }

  return false;
}

function_a243ddd6(localclientnum, itementry) {
  data = item_world::function_a7e98a1a(localclientnum);

  switch (itementry.itemtype) {
    case #"attachment":
      slotid = function_1415f8f1(localclientnum, itementry);

      if(!isDefined(slotid)) {
        return false;
      }

      return (data.inventory.items[slotid].networkid == 32767);
    case #"armor":
      return (data.inventory.items[11].networkid == 32767);
    case #"backpack":
      return (data.inventory.items[13].networkid == 32767);
    case #"equipment":
      return (data.inventory.items[12].networkid == 32767);
    case #"health":
      return (data.inventory.items[10].networkid == 32767);
    case #"weapon":
      return (data.inventory.items[16 + 1].networkid == 32767 || data.inventory.items[16 + 1 + 6 + 1].networkid == 32767);
    case #"ammo":
    case #"generic":
    case #"killstreak":
    case #"cash":
    default:
      return false;
  }
}

function_d768ea30(localclientnum) {
  assert(isplayer(self));
  var_b4322d52 = 0;
  currentweapon = isDefined(self.currentweapon) ? self.currentweapon : self.weapon;

  if(currentweapon == level.weaponbasemeleeheld) {
    data = item_world::function_a7e98a1a(localclientnum);
    return;
  }

  foreach(attachment in currentweapon.attachments) {
    if(attachment == #"null") {
      var_b4322d52 = 1;
      break;
    }
  }

  return var_b4322d52 ? 16 + 1 + 6 + 1 : 16 + 1;
}

function_78ed4455(localclientnum, itementry) {
  assert(isplayer(self));
  data = item_world::function_a7e98a1a(localclientnum);

  switch (itementry.itemtype) {
    case #"armor":
      return 11;
    case #"backpack":
      return 13;
    case #"equipment":
      if(data.inventory.items[12].networkid == 32767) {
        return 12;
      }

      break;
    case #"health":
      if(data.inventory.items[10].networkid == 32767) {
        return 10;
      }

      break;
    case #"weapon":
      if(data.inventory.items[16 + 1].networkid == 32767) {
        return (16 + 1);
      } else if(data.inventory.items[16 + 1 + 6 + 1].networkid == 32767) {
        return (16 + 1 + 6 + 1);
      }

      break;
  }

  if(itementry.itemtype == #"attachment") {
    return function_1415f8f1(localclientnum, itementry);
  }
}

function_9c4460e0(localclientnum, itemid, count = 1, slotid = undefined) {
  assert(isint(itemid));

  if(!isDefined(itemid)) {
    return;
  }

  point = function_b1702735(itemid);

  if(!isDefined(point)) {
    return;
  }

  itementry = point.itementry;
  availableaction = function_30697356(localclientnum, itementry);
  data = item_world::function_a7e98a1a(localclientnum);
  selectedindex = undefined;

  if(count == 0) {
    return;
  }

  if(!isDefined(selectedindex) && isDefined(slotid)) {
    selectedindex = slotid;
  }

  if(!isDefined(selectedindex)) {
    selectedindex = item_world::function_73436347(data.inventory.items, 32767);

    if(!isDefined(selectedindex)) {
      println("<dev string:x38>" + itemid + "<dev string:x79>");
      return;
    }
  }

  player = function_27673a7(localclientnum);
  networkid = item_world_util::function_970b8d86(player, selectedindex);
  inventoryitem = undefined;

  if(selectedindex < data.inventory.items.size) {
    inventoryitem = data.inventory.items[selectedindex];
  }

  assert(isDefined(inventoryitem));
  totalcount = function_bba770de(localclientnum, itementry);
  totalcount += count;
  player function_1a99656a(localclientnum, inventoryitem, networkid, itemid, count, totalcount, availableaction);
}

function_1415f8f1(localclientnum, itementry) {
  assert(isplayer(self));
  data = item_world::function_a7e98a1a(localclientnum);

  if(itementry.itemtype == #"attachment") {
    weaponslotid = function_d768ea30(localclientnum);

    if(!isDefined(weaponslotid)) {
      return;
    }

    var_f0dc4e93 = item_world_util::function_970b8d86(self, weaponslotid);

    if(data.inventory.items[weaponslotid].networkid == 32767) {
      return;
    }

    var_ceefbd10 = item_inventory_util::function_837f4a57(itementry);
    var_f9f8c0b5 = item_inventory_util::function_dfaca25e(weaponslotid, var_ceefbd10);
    weaponitem = self function_15d578f4(localclientnum, var_f0dc4e93);
    attachmentname = item_inventory_util::function_2ced1d34(weaponitem, itementry);

    if(isDefined(attachmentname)) {
      return var_f9f8c0b5;
    }
  }
}

function_bba770de(localclientnum, itementry) {
  data = item_world::function_a7e98a1a(localclientnum);
  count = 0;

  if(!isDefined(itementry)) {
    return count;
  }

  name = isDefined(itementry.parentname) ? itementry.parentname : itementry.name;

  for(index = 0; index < data.inventory.items.size && index < 16 + 1; index++) {
    inventoryitem = data.inventory.items[index];

    if(!isDefined(inventoryitem.itementry) || isDefined(inventoryitem.endtime)) {
      continue;
    }

    if(name == (isDefined(inventoryitem.itementry.parentname) ? inventoryitem.itementry.parentname : inventoryitem.itementry.name)) {
      count += inventoryitem.count;
    }
  }

  return count;
}

can_pickup_ammo(localclientnum, item, ammoamount = undefined) {
  assert(isplayer(self));
  data = item_world::function_a7e98a1a(localclientnum);
  itementry = item.itementry;
  ammoweapon = itementry.weapon;
  ammoamount = isDefined(itementry.amount) ? itementry.amount : isDefined(ammoamount) ? ammoamount : 1;
  maxstockammo = item_inventory_util::function_2879cbe0(data.inventory.var_7658cbec, ammoweapon);
  currentammostock = self getweaponammostock(localclientnum, ammoweapon);
  var_9b9ba643 = maxstockammo - currentammostock;
  addammo = int(min(ammoamount, var_9b9ba643));
  return addammo > 0;
}

private function_85645978(data, item) {
  currtime = gettime();

  foreach(consumeditem in data.inventory.consumed.items) {
    if(item.itementry.name == consumeditem.itementry.name && currtime < consumeditem.endtime) {
      return consumeditem;
    }
  }

  return undefined;
}

function_52e537be(localclientnum, networkid) {
  item = function_15d578f4(localclientnum, networkid);

  if(isDefined(item)) {
    setuimodelvalue(createuimodel(item.itemuimodel, "castTimeFraction"), 0, 0);
  }

  data = item_world::function_a7e98a1a(localclientnum);

  if(isDefined(data) && isDefined(data.inventory) && networkid === data.inventory.var_4d4ec560) {
    setuimodelvalue(data.inventory.consumed.var_a25538fb, function_3fe6ef04(localclientnum));
    data.inventory.var_4d4ec560 = undefined;
  }
}

consume_item(localclientnum, networkid) {
  assert(networkid != 32767);

  if(networkid == 32767) {
    return;
  }

  data = item_world::function_a7e98a1a(localclientnum);
  item = function_15d578f4(localclientnum, networkid);

  if(!isDefined(item) || !isDefined(item.itementry)) {
    return;
  }

  duration = int((isDefined(item.itementry.duration) ? item.itementry.duration : 0) * 1000);
  starttime = gettime();
  endtime = starttime + duration;
  item.starttime = starttime;
  item.endtime = endtime;
  totalcount = function_bba770de(localclientnum, item.itementry);
  function_1a99656a(localclientnum, item, networkid, item.id, 1, totalcount, 5, 0);
  var_3285d88f = data.inventory.consumed.items.size;
  var_cfa0e915 = [];

  foreach(consumeditem in data.inventory.consumed.items) {
    if(isDefined(var_cfa0e915[consumeditem.itementry.name])) {
      continue;
    }

    var_cfa0e915[consumeditem.itementry.name] = 1;
  }

  consumeditem = function_85645978(data, item);

  if(isDefined(consumeditem)) {
    consumeditem.endtime += duration;

    for(index = 0; index < 10; index++) {
      inventoryitem = data.inventory.items[index];

      if(!isDefined(inventoryitem.endtime)) {
        continue;
      }

      if(inventoryitem.itementry.name == item.itementry.name) {
        inventoryitem.starttime = consumeditem.starttime;
        inventoryitem.endtime = consumeditem.endtime;
      }
    }
  } else {
    consumeditem = spawnStruct();
    consumeditem.id = item.id;
    consumeditem.itementry = item.itementry;
    consumeditem.itemuimodel = createuimodel(data.inventory.consumed.uimodel, "item" + var_cfa0e915.size);
    consumeditem.starttime = gettime();
    consumeditem.endtime = consumeditem.starttime + duration;
    var_cfa0e915[consumeditem.itementry.name] = 1;
  }

  data.inventory.consumed.items[var_3285d88f] = consumeditem;
  var_31c78e6f = consumeditem.itementry;
  function_1a99656a(localclientnum, consumeditem, 32767, 32767, 0, 0, 0, 0);
  function_1a99656a(localclientnum, consumeditem, networkid, item.id, 0, 0, 0, 0);
  setuimodelvalue(data.inventory.consumed.var_a25538fb, var_cfa0e915.size);
  function_442857e2(localclientnum, var_31c78e6f);
  level thread function_451ebd83(localclientnum, consumeditem.itementry, networkid);
}

function_de74158f(localclientnum, networkid) {
  assert(networkid != 32767);

  if(networkid == 32767) {
    return;
  }

  data = item_world::function_a7e98a1a(localclientnum);
  item = function_15d578f4(localclientnum, networkid);

  if(!isDefined(item)) {
    return;
  }

  var_cfa0e915 = [];

  foreach(consumeditem in data.inventory.consumed.items) {
    if(isDefined(var_cfa0e915[consumeditem.itementry.name])) {
      continue;
    }

    var_cfa0e915[consumeditem.itementry.name] = 1;
  }

  consumeditem = spawnStruct();
  consumeditem.id = item.id;
  consumeditem.itementry = item.itementry;
  consumeditem.itemuimodel = createuimodel(data.inventory.consumed.uimodel, "item" + var_cfa0e915.size);
  var_cfa0e915[consumeditem.itementry.name] = 1;
  function_1a99656a(localclientnum, consumeditem, 32767, 32767, 0, 0, 0, 0);
  function_1a99656a(localclientnum, consumeditem, networkid, item.id, 0, 0, 0, 0);
  setuimodelvalue(data.inventory.consumed.var_a25538fb, var_cfa0e915.size);
  level thread function_451ebd83(localclientnum, item.itementry, undefined);
}

function_7f056944(localclientnum, index) {
  var_6e2c91d0 = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.multiItemPickup");
  setuimodelvalue(createuimodel(var_6e2c91d0, "item" + index + ".disabled"), 1);
}

function_3bd1836f(localclientnum, networkid) {
  if(networkid == item_world_util::function_970b8d86(function_27673a7(localclientnum), 13)) {
    give_backpack(localclientnum, networkid);
    return;
  }

  data = item_world::function_a7e98a1a(localclientnum);

  foreach(inventoryitem in data.inventory.items) {
    if(inventoryitem.networkid === networkid) {
      function_8063170(inventoryitem, 1);
      playSound(localclientnum, #"hash_4d31bd9927d823c3");
      return;
    }
  }
}

give_backpack(localclientnum, networkid) {
  data = item_world::function_a7e98a1a(localclientnum);

  if(!isDefined(data)) {
    return;
  }

  item = function_15d578f4(localclientnum, networkid);

  if(!isDefined(item)) {
    waittillframeend();
    item = function_15d578f4(localclientnum, networkid);

    if(!isDefined(item)) {
      return;
    }
  }

  data.inventory.var_7658cbec = item_inventory_util::function_d8cebda3(item.itementry);

  if(data.inventory.var_7658cbec&1 && data.inventory.var_c212de25 != 10) {
    for(index = data.inventory.var_c212de25; index < 10; index++) {
      inventoryitem = data.inventory.items[index];
      setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "disabled"), 0);
    }

    data.inventory.var_c212de25 = 10;
    inventoryuimodel = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory");
    setuimodelvalue(createuimodel(inventoryuimodel, "count"), data.inventory.var_c212de25);
  }
}

function_15d578f4(localclientnum, networkid) {
  assert(isDefined(localclientnum));
  assert(item_world_util::function_d9648161(networkid));
  data = item_world::function_a7e98a1a(localclientnum);
  assert(isDefined(data));

  for(index = 0; index < data.inventory.items.size; index++) {
    inventoryitem = data.inventory.items[index];

    if(inventoryitem.networkid === networkid) {
      return inventoryitem;
    }
  }
}

function_c48cd17f(localclientnum, networkid) {
  item = function_15d578f4(localclientnum, networkid);

  if(isDefined(item)) {
    return item.id;
  }

  return 32767;
}

has_attachments(localclientnum, weaponslotid) {
  assert(isDefined(localclientnum));

  if(!isDefined(weaponslotid)) {
    return false;
  }

  data = item_world::function_a7e98a1a(localclientnum);

  foreach(attachmentoffset in array(1, 2, 3, 4, 5, 6)) {
    slotid = item_inventory_util::function_dfaca25e(weaponslotid, attachmentoffset);

    if(data.inventory.items[slotid].networkid != 32767) {
      return true;
    }
  }

  return false;
}

inventory_init(localclientnum) {
  data = item_world::function_a7e98a1a(localclientnum);
  inventoryuimodel = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory");
  pickedupammotypes = createuimodel(inventoryuimodel, "pickedUpAmmoTypes");
  setuimodelvalue(createuimodel(pickedupammotypes, "count"), 0);
  data.inventory = spawnStruct();
  data.inventory.consumed = {};
  data.inventory.consumed.items = [];
  data.inventory.count = 16 + 1 + 6 + 1 + 6 + 1;
  data.inventory.items = [];
  data.inventory.var_a7a2b773 = 0;
  data.inventory.var_c212de25 = 5;
  data.inventory.var_7658cbec = 0;

  if(ispc()) {
    data.inventory.var_f3518190 = undefined;
    data.inventory.var_4d4ec560 = undefined;
  }

  for(index = 0; index < data.inventory.count; index++) {
    data.inventory.items[index] = spawnStruct();
  }

  for(index = 0; index < 5; index++) {
    data.inventory.items[index].itemuimodel = createuimodel(inventoryuimodel, "item" + index);
    setuimodelvalue(createuimodel(data.inventory.items[index].itemuimodel, "backpackSlot"), 0);
    setuimodelvalue(createuimodel(data.inventory.items[index].itemuimodel, "disabled"), 0);
  }

  for(index = 5; index < 10; index++) {
    data.inventory.items[index].itemuimodel = createuimodel(inventoryuimodel, "item" + index);
    setuimodelvalue(createuimodel(data.inventory.items[index].itemuimodel, "backpackSlot"), 1);
    setuimodelvalue(createuimodel(data.inventory.items[index].itemuimodel, "disabled"), 1);
  }

  data.inventory.items[10].itemuimodel = createuimodel(inventoryuimodel, "health");
  data.inventory.items[11].itemuimodel = createuimodel(inventoryuimodel, "gear");
  data.inventory.items[13].itemuimodel = createuimodel(inventoryuimodel, "storage");
  data.inventory.items[12].itemuimodel = createuimodel(inventoryuimodel, "equipment");
  data.inventory.items[14].itemuimodel = createuimodel(inventoryuimodel, "resource0");
  data.inventory.items[15].itemuimodel = createuimodel(inventoryuimodel, "resource1");
  data.inventory.items[16].itemuimodel = createuimodel(inventoryuimodel, "shard0");
  weaponslots = array(16 + 1, 16 + 1 + 6 + 1);

  for(index = 0; index < weaponslots.size; index++) {
    weaponslotid = weaponslots[index];
    data.inventory.items[weaponslotid].itemuimodel = createuimodel(inventoryuimodel, "weapon" + index);
    var_55022c4f = array(1, 2, 3, 4, 5, 6);

    for(attachmentindex = 0; attachmentindex < var_55022c4f.size; attachmentindex++) {
      attachmentoffset = var_55022c4f[attachmentindex];
      var_f9f8c0b5 = item_inventory_util::function_dfaca25e(weaponslotid, attachmentoffset);
      uimodelindex = attachmentindex + index * var_55022c4f.size;
      data.inventory.items[var_f9f8c0b5].itemuimodel = createuimodel(inventoryuimodel, "attachment" + uimodelindex);
    }
  }

  for(index = 0; index < data.inventory.items.size; index++) {
    if(!isDefined(data.inventory.items[index].itemuimodel)) {
      continue;
    }

    function_1a99656a(localclientnum, data.inventory.items[index], 32767, 32767, 0, 0, 0);
  }

  data.inventory.healthitems = [];

  for(index = 0; index < 2; index++) {
    data.inventory.healthitems[index] = spawnStruct();
    data.inventory.healthitems[index].itemuimodel = createuimodel(inventoryuimodel, "health" + index);
    function_1a99656a(localclientnum, data.inventory.healthitems[index], 32767, 32767, 0, 0, 0);
  }

  data.inventory.equipmentitems = [];

  for(index = 0; index < 2; index++) {
    data.inventory.equipmentitems[index] = spawnStruct();
    data.inventory.equipmentitems[index].itemuimodel = createuimodel(inventoryuimodel, "equipment" + index);
    function_1a99656a(localclientnum, data.inventory.equipmentitems[index], 32767, 32767, 0, 0, 0);
  }

  setuimodelvalue(createuimodel(inventoryuimodel, "count"), 5);
  setuimodelvalue(createuimodel(inventoryuimodel, "filledSlots"), 0);
  setuimodelvalue(createuimodel(inventoryuimodel, "attachmentCount"), 6);
  setuimodelvalue(createuimodel(inventoryuimodel, "resourceCount"), 1);
  setuimodelvalue(createuimodel(inventoryuimodel, "shardCount"), 1);
  setuimodelvalue(createuimodel(inventoryuimodel, "canUseQuickInventory"), 0);

  if(function_88da0c8e(localclientnum)) {
    setuimodelvalue(createuimodel(data.inventory.items[14].itemuimodel, "notAccessible"), 1);
  }

  data.inventory.consumed.uimodel = createuimodel(inventoryuimodel, "consumed");
  data.inventory.consumed.var_a25538fb = createuimodel(data.inventory.consumed.uimodel, "count");
  setuimodelvalue(data.inventory.consumed.var_a25538fb, 0);
  level thread function_dab42db1(localclientnum);
  level thread function_d7869556(localclientnum);
  level thread function_cf96d951(localclientnum);
  forcenotifyuimodel(createuimodel(inventoryuimodel, "initialize"));
}

function_dab42db1(localclientnum) {
  level flagsys::wait_till(#"item_world_initialized");

  foreach(ammotype in array(#"ammo_type_9mm_item", #"ammo_type_45_item", #"ammo_type_556_item", #"ammo_type_762_item", #"ammo_type_338_item", #"ammo_type_50cal_item", #"ammo_type_12ga_item", #"ammo_type_rocket_item")) {
    point = function_4ba8fde(ammotype);

    if(isDefined(point) && isDefined(point.itementry) && point.itementry.itemtype == #"ammo") {
      function_4f16aa30(localclientnum, point.id);
    }
  }

  inventoryuimodel = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory");
  pickedupammotypes = createuimodel(inventoryuimodel, "pickedUpAmmoTypes");
  forcenotifyuimodel(pickedupammotypes);
}

function_cf96d951(localclientnum) {
  level flagsys::wait_till(#"item_world_initialized");
  data = item_world::function_a7e98a1a(localclientnum);
  point = function_4ba8fde(#"armor_shard_item");

  if(isDefined(point) && isDefined(point.itementry) && point.itementry.itemtype == #"armor_shard") {
    if(data.inventory.items[16].networkid == 32767) {
      function_1a99656a(localclientnum, data.inventory.items[16], point.networkid, point.id, 0, 0, 0);
    }
  }
}

function_d7869556(localclientnum) {
  level flagsys::wait_till(#"item_world_initialized");
  data = item_world::function_a7e98a1a(localclientnum);
  point = function_4ba8fde(#"resource_item_paint");

  if(isDefined(point) && isDefined(point.itementry) && point.itementry.itemtype == #"resource") {
    function_1a99656a(localclientnum, data.inventory.items[14], point.networkid, point.id, 0, 0, 0);
  }
}

private function_534dcb9c(localclientnum) {
  if(!isDefined(level.var_af8f97c8) || !isDefined(level.var_af8f97c8[localclientnum])) {
    if(!isDefined(level.var_aa75d3e)) {
      level.var_aa75d3e = [];
    } else if(!isarray(level.var_aa75d3e)) {
      level.var_aa75d3e = array(level.var_aa75d3e);
    }

    if(!isDefined(level.var_af8f97c8)) {
      level.var_af8f97c8 = [];
    } else if(!isarray(level.var_af8f97c8)) {
      level.var_af8f97c8 = array(level.var_af8f97c8);
    }

    if(!isDefined(level.var_53cbbb33)) {
      level.var_53cbbb33 = [];
    } else if(!isarray(level.var_53cbbb33)) {
      level.var_53cbbb33 = array(level.var_53cbbb33);
    }

    if(!isDefined(level.var_3a0390dd)) {
      level.var_3a0390dd = [];
    } else if(!isarray(level.var_3a0390dd)) {
      level.var_3a0390dd = array(level.var_3a0390dd);
    }

    if(!isDefined(level.var_c8a5f79b)) {
      level.var_c8a5f79b = [];
    } else if(!isarray(level.var_c8a5f79b)) {
      level.var_c8a5f79b = array(level.var_c8a5f79b);
    }

    if(!isDefined(level.var_7086ad4f)) {
      level.var_7086ad4f = [];
    } else if(!isarray(level.var_7086ad4f)) {
      level.var_7086ad4f = array(level.var_7086ad4f);
    }

    level.var_aa75d3e[localclientnum] = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.currentWeaponIndex");
    level.var_af8f97c8[localclientnum] = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.currentWeapon");
    level.var_c8a5f79b[localclientnum] = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.currentWeapon.ammoType");
    level.var_53cbbb33[localclientnum] = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.currentWeapon.isOperator");
    level.var_3a0390dd[localclientnum] = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.currentWeapon.isTactical");
    level.var_7086ad4f[localclientnum] = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.showAttachments");
    level.var_6d21daaf[localclientnum] = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.canTransferFromStash");
  }
}

function_6231c19(params) {
  if(params.weapon.name == #"none") {
    return;
  }

  if(isstruct(self)) {
    return;
  }

  if(!self function_da43934d() || !isplayer(self) || !isalive(self)) {
    return;
  }

  function_534dcb9c(params.localclientnum);

  if(isDefined(params.weapon)) {
    data = item_world::function_a7e98a1a(params.localclientnum);

    if(!isDefined(data) || !isDefined(data.inventory) || !isDefined(data.inventory.items) || data.inventory.items.size == 0) {
      return;
    }

    self.currentweapon = params.weapon;

    if(params.weapon == level.weaponbasemeleeheld) {
      setuimodelvalue(level.var_7086ad4f[params.localclientnum], 0);
      itemindex = getbaseweaponitemindex(getweapon(#"none"));

      foreach(index, slot in array(16 + 1, 16 + 1 + 6 + 1)) {
        if(data.inventory.items[slot].networkid == 32767) {
          break;
        }
      }

      if(!isDefined(index)) {
        return;
      }

      setuimodelvalue(level.var_3a0390dd[params.localclientnum], 0);
      setuimodelvalue(level.var_53cbbb33[params.localclientnum], 0);

      if(!setuimodelvalue(level.var_aa75d3e[params.localclientnum], index)) {
        forcenotifyuimodel(level.var_aa75d3e[params.localclientnum]);
      }

      if(!setuimodelvalue(level.var_af8f97c8[params.localclientnum], itemindex)) {
        forcenotifyuimodel(level.var_af8f97c8[params.localclientnum]);
      }

      function_deddbdf0(params.localclientnum);
      function_ce628f27(params.localclientnum);
      return;
    }

    var_a4250c2b = self function_d768ea30(params.localclientnum);

    foreach(index, slot in array(16 + 1, 16 + 1 + 6 + 1)) {
      if(slot === var_a4250c2b) {
        if(!setuimodelvalue(level.var_aa75d3e[params.localclientnum], index)) {
          forcenotifyuimodel(level.var_aa75d3e[params.localclientnum]);
        }

        break;
      }
    }

    networkid = item_world_util::function_970b8d86(self, var_a4250c2b);
    item = function_15d578f4(params.localclientnum, networkid);

    if(isDefined(item) && isDefined(item.itementry) && isDefined(item.itementry.var_340eac1f) && item.itementry.var_340eac1f) {
      setuimodelvalue(level.var_53cbbb33[params.localclientnum], 0);
      setuimodelvalue(level.var_3a0390dd[params.localclientnum], 1);
    } else if(isDefined(item) && isDefined(item.itementry) && isDefined(item.itementry.var_dc6c5d3b) && item.itementry.var_dc6c5d3b) {
      setuimodelvalue(level.var_3a0390dd[params.localclientnum], 0);
      setuimodelvalue(level.var_53cbbb33[params.localclientnum], 1);
    } else {
      setuimodelvalue(level.var_3a0390dd[params.localclientnum], 0);
      setuimodelvalue(level.var_53cbbb33[params.localclientnum], 0);
    }

    if(isDefined(params.weapon.statname) && params.weapon.statname != #"") {
      itemindex = getbaseweaponitemindex(getweapon(params.weapon.statname));
    } else {
      itemindex = getbaseweaponitemindex(params.weapon);
    }

    var_754fe8c5 = getweaponammotype(params.weapon);

    if(isDefined(level.var_c53d118f) && isDefined(level.var_c53d118f[var_754fe8c5])) {
      setuimodelvalue(level.var_c8a5f79b[params.localclientnum], level.var_c53d118f[var_754fe8c5]);
    } else {
      setuimodelvalue(level.var_c8a5f79b[params.localclientnum], #"");
    }

    setuimodelvalue(level.var_af8f97c8[params.localclientnum], itemindex);
    forcenotifyuimodel(level.var_af8f97c8[params.localclientnum]);
    supportsattachments = 0;

    if(isDefined(item)) {
      supportsattachments = item_inventory_util::function_4bd83c04(item);
    }

    setuimodelvalue(level.var_7086ad4f[params.localclientnum], supportsattachments);
    function_deddbdf0(params.localclientnum, var_a4250c2b);
    function_ce628f27(params.localclientnum);
  }
}

function_8ffee46f(localclientnum, item) {
  var_f9b70cae = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.pickedUpItem");
  itemname = item_world::get_item_name(item.itementry);

  if(!setuimodelvalue(var_f9b70cae, itemname)) {
    forcenotifyuimodel(var_f9b70cae);
  }

  if(item.itementry.itemtype == #"weapon") {
    var_d9659d2a = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.pickedUpWeapon");

    if(!setuimodelvalue(var_d9659d2a, itemname)) {
      forcenotifyuimodel(var_d9659d2a);
    }

    return;
  }

  if(item.itementry.itemtype == #"generic") {
    function_22759012(localclientnum, item.networkid);
  }
}

function_c9764f6d(localclientnum) {
  var_80c295ff = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.droppedWeapon");
  forcenotifyuimodel(var_80c295ff);
}

function_451ebd83(localclientnum, item, networkid) {
  itemname = item_world::get_item_name(item);
  waittillframeend();
  var_e16dbee1 = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.consumedItem");

  if(!setuimodelvalue(var_e16dbee1, itemname)) {
    forcenotifyuimodel(var_e16dbee1);
  }

  data = item_world::function_a7e98a1a(localclientnum);

  if(isDefined(data) && isDefined(data.inventory) && networkid === data.inventory.var_4d4ec560) {
    data.inventory.var_4d4ec560 = undefined;
  }

  function_9f5d2dc8(localclientnum);
}

function_4f16aa30(localclientnum, itemid) {
  if(!isDefined(level.var_c53d118f)) {
    level.var_c53d118f = [];
  }

  assert(item_world_util::function_2c7fc531(itemid));
  item = function_b1702735(itemid);

  if(!isDefined(item.itementry)) {
    return;
  }

  var_754fe8c5 = getweaponammotype(item.itementry.weapon);

  if(!isDefined(var_754fe8c5) || item.itementry.itemtype !== #"ammo") {
    return;
  }

  var_f9b70cae = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.pickedUpItem");
  var_7268d07 = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.pickedUpAmmoTypes");
  var_5a2db7bb = createuimodel(var_7268d07, "count");
  var_b4676aed = getuimodelvalue(var_5a2db7bb);

  for(i = 0; i < var_b4676aed; i++) {
    var_acd2831f = createuimodel(var_7268d07, "" + i + 1);

    if(getuimodelvalue(createuimodel(var_acd2831f, "assetName")) == var_754fe8c5) {
      if(item.itementry.itemtype == #"ammo" && !getuimodelvalue(createuimodel(var_acd2831f, "canDrop"))) {
        setuimodelvalue(createuimodel(var_acd2831f, "id"), itemid);
        setuimodelvalue(createuimodel(var_acd2831f, "canDrop"), item.itementry.itemtype == #"ammo");
      }

      return;
    }
  }

  level.var_c53d118f[var_754fe8c5] = item.itementry.displayname;
  var_acd2831f = createuimodel(var_7268d07, "" + var_b4676aed + 1);
  setuimodelvalue(createuimodel(var_acd2831f, "assetName"), var_754fe8c5);
  setuimodelvalue(createuimodel(var_acd2831f, "id"), itemid);
  setuimodelvalue(createuimodel(var_acd2831f, "canDrop"), 1);
  setuimodelvalue(createuimodel(var_acd2831f, "name"), item.itementry.displayname);
  setuimodelvalue(createuimodel(var_acd2831f, "icon"), item.itementry.icon);
  setuimodelvalue(createuimodel(var_acd2831f, "description"), item.itementry.description);
  setuimodelvalue(var_5a2db7bb, var_b4676aed + 1);
}

function_b1136fc8(localclientnum, item) {
  if(isDefined(item) && isDefined(item.origin) && isDefined(item.itementry)) {
    if(isDefined(item.itementry.dropsound)) {
      playSound(localclientnum, item.itementry.dropsound, item.origin);
      return;
    }

    switch (item.itementry.itemtype) {
      case #"weapon":
        playSound(localclientnum, #"hash_67fed8a52accbb23", item.origin);
        break;
      case #"ammo":
        playSound(localclientnum, #"fly_drop_generic", item.origin);
        break;
      case #"health":
        playSound(localclientnum, #"hash_4d393a136d0df945", item.origin);
        break;
      case #"equipment":
        playSound(localclientnum, #"fly_drop_generic", item.origin);
        break;
      case #"armor":
        playSound(localclientnum, #"hash_6bd51d5a531ff32", item.origin);
        break;
      case #"backpack":
        playSound(localclientnum, #"hash_60e9138ddc9660ed", item.origin);
        break;
      case #"attachment":
        playSound(localclientnum, #"fly_drop_generic", item.origin);
        break;
      case #"quest":
        playSound(localclientnum, #"fly_drop_generic", item.origin);
        break;
      case #"generic":
        playSound(localclientnum, #"fly_drop_generic", item.origin);
        break;
      case #"cash":
        playSound(localclientnum, #"fly_drop_generic", item.origin);
        break;
    }
  }
}

function_31868137(localclientnum, item) {
  if(isDefined(item) && isDefined(item.origin) && isDefined(item.itementry)) {
    if(isDefined(item.itementry.pickupsound)) {
      playSound(localclientnum, item.itementry.pickupsound, item.origin);
      return;
    }

    switch (item.itementry.itemtype) {
      case #"weapon":
        playSound(localclientnum, #"hash_62fabedcce13774c", item.origin);
        break;
      case #"ammo":
        playSound(localclientnum, #"fly_pickup_ammo", item.origin);
        break;
      case #"health":
        playSound(localclientnum, #"hash_7cb9f9cf7068ccee", item.origin);
        break;
      case #"equipment":
        playSound(localclientnum, #"fly_pickup_generic", item.origin);
        break;
      case #"armor":
        playSound(localclientnum, #"hash_2d8e1c5a5387840f", item.origin);
        break;
      case #"backpack":
        playSound(localclientnum, #"hash_69949bb7db9ef21e", item.origin);
        break;
      case #"attachment":
        playSound(localclientnum, #"hash_48ae9b1190e79fc5", item.origin);
        break;
      case #"quest":
        playSound(localclientnum, #"hash_5738a0fcb2e4efca", item.origin);
        break;
      case #"generic":
        playSound(localclientnum, #"fly_pickup_generic", item.origin);
        break;
      case #"cash":
        playSound(localclientnum, #"fly_pickup_generic", item.origin);
        break;
    }
  }
}

function_c6ff0aa2(localclientnum, networkid) {
  data = item_world::function_a7e98a1a(localclientnum);
  index = item_world::function_73436347(data.inventory.items, networkid);

  if(!isDefined(index)) {
    println("<dev string:xa3>" + networkid + "<dev string:xbc>");
    return;
  }

  item = data.inventory.items[index];
  isweapon = isDefined(item.itementry) && item.itementry.itemtype == #"weapon";
  var_53aa3063 = isDefined(item.itementry) && item.itementry.itemtype == #"generic";
  var_ac3edb34 = item.itementry;

  if(isDefined(item.endtime)) {
    consumeditem = function_85645978(data, item);

    if(isDefined(consumeditem)) {
      var_ee0e9af9 = [];

      for(index = 0; index < 10; index++) {
        inventoryitem = data.inventory.items[index];

        if(!isDefined(inventoryitem.endtime)) {
          continue;
        }

        if(inventoryitem.itementry.name == item.itementry.name) {
          var_ee0e9af9[var_ee0e9af9.size] = inventoryitem;
        }
      }

      remaining = consumeditem.endtime - gettime();
      consumeditem.endtime -= remaining / var_ee0e9af9.size;

      for(index = 0; index < var_ee0e9af9.size; index++) {
        inventoryitem = var_ee0e9af9[index];
        inventoryitem.starttime = consumeditem.starttime;
        inventoryitem.endtime = consumeditem.endtime;
      }
    }
  }

  function_1a99656a(localclientnum, item, 32767, 32767, 0, 0, 0, 1, 0, 0);
  player = function_27673a7(localclientnum);

  if(player.weapon.name == #"none" || player.weapon.name == #"bare_hands") {
    var_a4250c2b = player function_d768ea30(localclientnum);

    if(isDefined(var_a4250c2b) && var_a4250c2b == index) {
      primaryweapons = player getweaponslistprimaries();
      nextweapon = level.weaponbasemeleeheld;

      foreach(weapon in primaryweapons) {
        if(weapon !== player.currentweapon) {
          nextweapon = weapon;
          break;
        }
      }

      var_a3eec6f2 = spawnStruct();
      var_a3eec6f2.localclientnum = localclientnum;
      var_a3eec6f2.weapon = nextweapon;
      player function_6231c19(var_a3eec6f2);
    }
  }

  if(index == 13) {
    take_backpack(localclientnum, networkid);
  }

  if(isweapon) {
    function_c9764f6d(localclientnum);
    function_ce628f27(localclientnum);
    return;
  }

  if(var_53aa3063) {
    function_9f5d2dc8(localclientnum);
  }
}

function_8063170(inventoryitem, equipped) {
  if(!isDefined(inventoryitem) || !isDefined(inventoryitem.itementry)) {
    return;
  }

  if(inventoryitem.itementry.itemtype === #"armor_shard") {
    return;
  }

  if(inventoryitem.itementry.itemtype === #"attachment" || inventoryitem.itementry.itemtype === #"weapon") {
    availableaction = inventoryitem.availableaction;
  } else {
    availableaction = inventoryitem.availableaction && !equipped;
  }

  setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "availableAction"), availableaction);
}

function_26c87da8(localclientnum, var_c9293a27, var_8f194e5a) {
  assert(isDefined(var_c9293a27) && isDefined(var_8f194e5a));

  if(var_c9293a27 == var_8f194e5a) {
    return;
  }

  data = item_world::function_a7e98a1a(localclientnum);
  fromitem = data.inventory.items[var_c9293a27];
  toitem = data.inventory.items[var_8f194e5a];
  var_23501832 = fromitem.networkid;
  var_a2dd129a = fromitem.id;
  var_b208c7e1 = fromitem.itementry;
  var_3907299e = fromitem.count;
  var_57b0c2f = fromitem.availableaction;
  var_9269cd0a = toitem.networkid;
  var_d3a45360 = toitem.id;
  var_ec763bb2 = toitem.itementry;
  var_532f304 = toitem.count;
  var_ad138826 = toitem.availableaction;
  player = function_27673a7(localclientnum);
  player function_1a99656a(localclientnum, toitem, var_23501832 != 32767 ? item_world_util::function_970b8d86(player, var_8f194e5a) : 32767, var_a2dd129a, var_3907299e, function_bba770de(localclientnum, var_b208c7e1), var_57b0c2f, undefined, 1);
  player function_1a99656a(localclientnum, fromitem, var_9269cd0a != 32767 ? item_world_util::function_970b8d86(player, var_c9293a27) : 32767, var_d3a45360, var_532f304, function_bba770de(localclientnum, var_ec763bb2), var_ad138826, undefined, 1);
  function_442857e2(localclientnum, var_ec763bb2);
  function_442857e2(localclientnum, var_b208c7e1);
  function_ce628f27(localclientnum);
  var_a4250c2b = player function_d768ea30(localclientnum);
  function_deddbdf0(localclientnum, var_a4250c2b);
}

take_backpack(localclientnum, networkid) {
  data = item_world::function_a7e98a1a(localclientnum);
  data.inventory.var_7658cbec = 0;

  if(data.inventory.var_c212de25 == 10) {
    for(index = 5; index < 10; index++) {
      inventoryitem = data.inventory.items[index];
      setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "disabled"), 1);
    }

    data.inventory.var_c212de25 = 5;
    inventoryuimodel = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory");
    setuimodelvalue(createuimodel(inventoryuimodel, "count"), data.inventory.var_c212de25);
  }
}

function_fa372100(localclientnum, networkid) {
  data = item_world::function_a7e98a1a(localclientnum);

  foreach(inventoryitem in data.inventory.items) {
    if(inventoryitem.networkid === networkid) {
      function_8063170(inventoryitem, 0);
      break;
    }
  }
}

update_inventory_item(localclientnum, networkid, count) {
  data = item_world::function_a7e98a1a(localclientnum);
  player = function_27673a7(localclientnum);

  foreach(inventoryslot, inventoryitem in data.inventory.items) {
    if(inventoryitem.networkid === networkid) {
      var_338e8597 = isDefined(inventoryitem.count) ? inventoryitem.count : 0;
      totalcount = function_bba770de(localclientnum, inventoryitem.itementry);
      totalcount += max(0, count - var_338e8597);
      function_1a99656a(localclientnum, inventoryitem, inventoryitem.networkid, inventoryitem.id, count, totalcount, inventoryitem.availableaction);
      function_8063170(inventoryitem, function_6d9d9cd7(inventoryslot));
      break;
    }
  }
}

function_9116bb0e(localclientnum, closed = 0) {
  assert(isplayer(self));
  clientdata = item_world::function_a7e98a1a(localclientnum);
  var_6e2c91d0 = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.multiItemPickup");
  var_cc67e8b = createuimodel(var_6e2c91d0, "count");

  if(isDefined(clientdata.groupitems) && !closed) {
    arrayremovevalue(clientdata.groupitems, undefined, 0);

    foreach(i, itemdef in clientdata.groupitems) {
      itemmodel = createuimodel(var_6e2c91d0, "item" + i);
      setuimodelvalue(createuimodel(itemmodel, "id"), itemdef.networkid);

      if(!isDefined(itemdef.itementry)) {
        setuimodelvalue(createuimodel(itemmodel, "inventoryFull"), 0);
        setuimodelvalue(createuimodel(itemmodel, "icon"), #"blacktransparent");
        setuimodelvalue(createuimodel(itemmodel, "rarity"), "none");
        setuimodelvalue(createuimodel(itemmodel, "name"), #"");
        setuimodelvalue(createuimodel(itemmodel, "claimsInventorySlot"), 0);
        setuimodelvalue(createuimodel(itemmodel, "stackCount"), 0);
        setuimodelvalue(createuimodel(itemmodel, "stashStackSize"), 0);
        setuimodelvalue(createuimodel(itemmodel, "armorTier"), 1);
        setuimodelvalue(createuimodel(itemmodel, "armor"), 0);
        setuimodelvalue(createuimodel(itemmodel, "armorMax"), 1);
        setuimodelvalue(createuimodel(itemmodel, "itemtype"), "none");
        setuimodelvalue(createuimodel(itemmodel, "specialItem"), 0);

        if(ispc()) {
          setuimodelvalue(createuimodel(itemmodel, "description"), #"");
        }

        continue;
      }

      setuimodelvalue(createuimodel(itemmodel, "itemtype"), itemdef.itementry.itemtype);

      if(itemdef.itementry.itemtype === #"ammo") {
        canpickup = self can_pickup_ammo(localclientnum, itemdef);
        setuimodelvalue(createuimodel(itemmodel, "inventoryFull"), !canpickup);
      } else if(itemdef.itementry.itemtype === #"armor_shard") {
        canpickup = self function_ad4c6116(localclientnum, itemdef.itementry);
        setuimodelvalue(createuimodel(itemmodel, "inventoryFull"), !canpickup);
      } else {
        setuimodelvalue(createuimodel(itemmodel, "inventoryFull"), 0);
      }

      if(ispc()) {
        description = isDefined(itemdef.itementry.description) ? itemdef.itementry.description : #"";

        if(description == #"" && isDefined(itemdef.itementry.weapon)) {
          itemindex = getitemindexfromref(itemdef.itementry.weapon.name);
          var_97dcd0a5 = getunlockableiteminfofromindex(itemindex);

          if(isDefined(var_97dcd0a5) && isDefined(var_97dcd0a5.description)) {
            description = var_97dcd0a5.description;
          }
        }

        setuimodelvalue(createuimodel(itemmodel, "description"), isDefined(description) ? description : #"");
      }

      pickupicon = isDefined(itemdef.itementry.pickupicon) ? itemdef.itementry.pickupicon : itemdef.itementry.icon;
      stashicon = isDefined(itemdef.itementry.stashicon) ? itemdef.itementry.stashicon : pickupicon;
      setuimodelvalue(createuimodel(itemmodel, "icon"), isDefined(stashicon) ? stashicon : #"blacktransparent");
      setuimodelvalue(createuimodel(itemmodel, "rarity"), itemdef.itementry.rarity);
      setuimodelvalue(createuimodel(itemmodel, "name"), item_world::get_item_name(itemdef.itementry));
      setuimodelvalue(createuimodel(itemmodel, "claimsInventorySlot"), is_inventory_item(localclientnum, itemdef.itementry) && !function_a4a6f064(localclientnum, itemdef.itementry));
      setuimodelvalue(createuimodel(itemmodel, "stackCount"), 0);
      setuimodelvalue(createuimodel(itemmodel, "stashStackSize"), 0);

      if(itemdef.itementry.itemtype === #"armor") {
        setuimodelvalue(createuimodel(itemmodel, "armorTier"), itemdef.itementry.armortier);
        setuimodelvalue(createuimodel(itemmodel, "armor"), isDefined(isDefined(itemdef.amount) ? itemdef.amount : itemdef.itementry.amount) ? isDefined(itemdef.amount) ? itemdef.amount : itemdef.itementry.amount : 0);
        setuimodelvalue(createuimodel(itemmodel, "armorMax"), isDefined(itemdef.itementry.amount) ? itemdef.itementry.amount : 1);
      } else {
        setuimodelvalue(createuimodel(itemmodel, "armorTier"), 1);
        setuimodelvalue(createuimodel(itemmodel, "armor"), 0);
        setuimodelvalue(createuimodel(itemmodel, "armorMax"), 1);
      }

      if(isDefined(itemdef.itementry.stackable) && itemdef.itementry.stackable || itemdef.itementry.itemtype === #"ammo") {
        if((itemdef.itementry.itemtype === #"ammo" || isstruct(itemdef)) && !isDefined(itemdef.amount)) {
          setuimodelvalue(createuimodel(itemmodel, "stackCount"), isDefined(itemdef.itementry.amount) ? itemdef.itementry.amount : 1);
        } else {
          setuimodelvalue(createuimodel(itemmodel, "stackCount"), int(max(isDefined(itemdef.amount) ? itemdef.amount : 1, isDefined(itemdef.count) ? itemdef.count : 1)));
        }
      } else {
        setuimodelvalue(createuimodel(itemmodel, "stashStackSize"), isDefined(itemdef.count) ? itemdef.count : 1);
      }

      if(isDefined(itemdef.var_41f13734) && itemdef.var_41f13734) {
        setuimodelvalue(createuimodel(itemmodel, "specialItem"), 1);
      }
    }

    currentcount = getuimodelvalue(var_cc67e8b);
    setuimodelvalue(var_cc67e8b, clientdata.groupitems.size);

    if(currentcount === clientdata.groupitems.size) {}

    var_aaa1adcb = createuimodel(var_6e2c91d0, "forceNotifyAmmoList");
    forcenotifyuimodel(var_aaa1adcb);
    return;
  }

  setuimodelvalue(var_cc67e8b, 0);
}