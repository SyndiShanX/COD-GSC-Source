/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_39cbfe2ef5995b4b.gsc
***********************************************/

#using scripts\core_common\aat_shared;
#using scripts\core_common\armor;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_inventory_util;
#using scripts\core_common\item_world;
#using scripts\core_common\item_world_util;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#namespace namespace_efff98ec;

function private autoexec __init__system__() {
  system::register(#"hash_fd2ea50703c7073", &preinit, undefined, undefined, #"item_world");
}

function private preinit() {
  if(item_inventory::function_7d5553ac()) {
    return;
  }

  function_116fd9a7();
}

function private function_116fd9a7() {
  item_world::function_861f348d(#"hash_9ed0c30684ca35a", &function_d045e83b);
  item_world::function_861f348d(#"hash_76a324a4d6073913", &function_2e5b5858);
  item_world::function_861f348d(#"hash_3bfb97e39d67e5f9", &function_cb9b4dd7);
  item_world::function_861f348d(#"hash_788c59214ead02af", &function_14b2eddf);
  item_world::function_861f348d(#"hash_6247ea34d3b1ddb6", &function_42ffe9b2);
  item_world::function_861f348d(#"hash_2cbf15cbb314c93e", &function_2eebeff5);
  item_world::function_861f348d(#"hash_51b30f6e7331e136", &function_349d4c26);
  item_world::function_861f348d(#"hash_2b4dff2e0db72d06", &function_670cce3f);
  item_world::function_861f348d(#"generic_pickup", &function_41a52251);
  item_world::function_861f348d(#"hash_5c844f5c1207159c", &function_2b2e9302);
  item_world::function_861f348d(#"hash_57df81951e3bc37c", &function_7de52ecc);
  item_world::function_861f348d(#"hash_1f0d729dc6dd1202", &function_898628ef);
  item_world::function_861f348d(#"hash_31380667bf69d3a0", &function_a240798a);
  item_world::function_861f348d(#"hash_29f7ad396d214a52", &function_d46c2559);
  item_world::function_861f348d(#"hash_50375e5de228e9fc", &function_a712496a);
  item_world::function_861f348d(#"hash_ff2bc61e2c18f43", &function_80ef3ea5);
  item_world::function_861f348d(#"hash_4213c4725d9f115", &function_753fb11f);
  item_world::function_861f348d(#"hash_68c089ceb01f806b", &function_2650d5c6);
  item_world::function_861f348d(#"hash_3115e37ace8310b1", &function_c3f4d281);
  item_world::function_861f348d(#"hash_292f5be0001274a4", &function_24dc1d12);
  item_world::function_861f348d(#"hash_1002a9af0882010e", &function_88803841);
}

function private function_d045e83b(item, player, networkid, itemid, itemcount, var_aec6fa7f, slot) {
  if(itemid.itementry.itemtype !== # "ammo") {
    assertmsg("<dev string:x38>" + itemid.name + "<dev string:x42>");
    return 0;
  }

  if(!self item_inventory::can_pickup_ammo(itemid)) {
    return (isDefined(itemid.itementry.amount) ? itemid.itementry.amount : isDefined(slot) ? slot : 1);
  }

  itemcount function_b00db06(8, var_aec6fa7f);
  return itemcount item_inventory::equip_ammo(itemid, slot);
}

function private function_2e5b5858(item, player, networkid, itemid, itemcount, var_aec6fa7f, slotid) {
  droppeditem = undefined;
  var_3d1f9df4 = 0;
  var_b0938bd7 = undefined;
  var_381f3b39 = 0;
  remainingitems = 0;

  if(networkid.itementry.var_4a1a4613 === # "armor_swap") {
    if(itemid armor::has_armor()) {
      inventoryitem = itemid.inventory.items[6];

      if(inventoryitem.networkid != 32767) {
        droppeditem = inventoryitem.itementry;
        var_3d1f9df4 = droppeditem.amount;
      }
    }

    itemid item_inventory::drop_armor();
    remainingitems = itemid item_inventory::give_inventory_item(networkid, 1, var_aec6fa7f, slotid);

    if(remainingitems < itemcount) {
      if(isDefined(networkid.networkid) && item_world_util::function_db35e94f(networkid.networkid)) {
        networkid = item_inventory::get_inventory_item(networkid.networkid);
      }

      if(itemid item_inventory::function_fba4a353(networkid)) {
        itemid item_inventory::equip_armor(networkid);
        var_b0938bd7 = networkid.itementry;
        var_381f3b39 = networkid.itementry.amount;
      }
    }
  } else if(networkid.itementry.var_4a1a4613 === # "armor_heal") {
    noarmor = 1;

    if(itemid.armortier > 0) {
      if(networkid.itementry.armortier > itemid.armortier) {
        inventoryitem = itemid.inventory.items[6];
        itemid thread function_bcaf2ad1(inventoryitem.networkid);
        noarmor = 1;
      } else {
        noarmor = 0;

        if(isDefined(itemid.armor) && isDefined(itemid.maxarmor)) {
          inventoryitem = itemid.inventory.items[6];
          inventoryitem.amount = itemid.maxarmor;
          itemid.armor = itemid.maxarmor;
        }
      }
    }

    if(noarmor) {
      itemid item_inventory::give_inventory_item(networkid, 1, var_aec6fa7f, slotid);

      if(isDefined(networkid.networkid) && item_world_util::function_db35e94f(networkid.networkid)) {
        networkid = item_inventory::get_inventory_item(networkid.networkid);
      }

      if(itemid item_inventory::function_fba4a353(networkid)) {
        itemid item_inventory::equip_armor(networkid);
        var_b0938bd7 = networkid.itementry;
        var_381f3b39 = networkid.itementry.amount;
      }
    }
  }

  item_world::function_1a46c8ae(itemid, droppeditem, var_3d1f9df4, var_b0938bd7, var_381f3b39);
  return remainingitems;
}

function function_bcaf2ad1(var_6ead57c0) {
  var_4d7e11d8 = self item_inventory::drop_inventory_item(var_6ead57c0);
  item_world::consume_item(var_4d7e11d8);
}

function private function_cb9b4dd7(item, player, networkid, itemid, itemcount, var_aec6fa7f, slotid) {
  remainingitems = itemcount item_inventory::give_inventory_item(itemid, var_aec6fa7f, undefined, slotid);
  itemcount item_inventory::function_3d113bfb();
  return remainingitems;
}

function private function_14b2eddf(item, player, networkid, itemid, itemcount, var_aec6fa7f, slotid) {
  var_f0dc4e93 = itemcount item_inventory::function_ec087745();
  weaponslotid = undefined;

  if(isDefined(var_f0dc4e93) && var_f0dc4e93 != 32767) {
    weaponslotid = itemcount item_inventory::function_b246c573(var_f0dc4e93);
  }

  remainingitems = itemcount item_inventory::give_inventory_item(itemid, var_aec6fa7f, undefined, slotid);

  if(isDefined(weaponslotid) && isDefined(slotid) && item_inventory_util::function_398b9770(weaponslotid, slotid)) {
    if(isDefined(itemid.networkid) && item_world_util::function_db35e94f(itemid.networkid)) {
      itemid = item_inventory::get_inventory_item(itemid.networkid);
    }

    itemcount item_inventory::equip_attachment(itemid, var_f0dc4e93, undefined, 0);
  }

  return remainingitems;
}

function private function_42ffe9b2(item, player, networkid, itemid, itemcount, var_aec6fa7f, slotid) {
  if(itemcount item_inventory::function_fba4a353(itemid)) {
    slotid = 8;
  }

  remainingitems = itemcount item_inventory::give_inventory_item(itemid, var_aec6fa7f, undefined, slotid);

  if(remainingitems < var_aec6fa7f && slotid === 8) {
    if(isDefined(itemid.networkid) && item_world_util::function_db35e94f(itemid.networkid)) {
      itemid = item_inventory::get_inventory_item(itemid.networkid);
    }

    itemcount item_inventory::equip_backpack(itemid);
  }

  return remainingitems;
}

function private function_2eebeff5(item, player, networkid, itemid, itemcount, var_aec6fa7f, slotid) {
  remainingitems = itemid item_inventory::give_inventory_item(networkid, itemcount, var_aec6fa7f, slotid);

  if(remainingitems < itemcount) {
    if(isDefined(networkid.networkid) && item_world_util::function_db35e94f(networkid.networkid)) {
      networkid = item_inventory::get_inventory_item(networkid.networkid);
    }

    if(itemid item_inventory::function_fba4a353(networkid)) {
      itemid thread item_inventory::equip_equipment(networkid);
    }
  }

  return remainingitems;
}

function private function_349d4c26(item, player, networkid, itemid, itemcount, var_aec6fa7f, slotid) {
  remainingitems = itemcount item_inventory::give_inventory_item(itemid, var_aec6fa7f, undefined, slotid);

  if(remainingitems < var_aec6fa7f) {
    if(isDefined(itemid.networkid) && item_world_util::function_db35e94f(itemid.networkid)) {
      itemid = item_inventory::get_inventory_item(itemid.networkid);
    }

    if(itemcount item_inventory::function_fba4a353(itemid)) {
      itemcount thread item_inventory::equip_health(itemid);
    }
  }

  return remainingitems;
}

function private function_670cce3f(item, player, networkid, itemid, itemcount, var_aec6fa7f, slotid) {
  remainingitems = itemcount item_inventory::give_inventory_item(itemid, var_aec6fa7f, undefined, slotid);
  return remainingitems;
}

function private function_41a52251(item, player, networkid, itemid, itemcount, var_aec6fa7f, slotid) {
  remainingitems = itemcount item_inventory::give_inventory_item(itemid, var_aec6fa7f, undefined, slotid);
  return remainingitems;
}

function private function_2b2e9302(item, player, networkid, itemid, itemcount, var_aec6fa7f, slotid) {
  remainingitems = itemcount item_inventory::give_inventory_item(itemid, var_aec6fa7f, undefined, slotid);
  itemcount callback::callback(#"hash_3b891b6daa75c782", itemid);
  return remainingitems;
}

function private function_7de52ecc(item, player, networkid, itemid, itemcount, var_aec6fa7f, slotid) {
  remainingitems = itemid item_inventory::give_inventory_item(networkid, itemcount, var_aec6fa7f, slotid);

  if(remainingitems < itemcount) {
    if(isDefined(networkid.networkid) && item_world_util::function_db35e94f(networkid.networkid)) {
      networkid = item_inventory::get_inventory_item(networkid.networkid);
    }

    if(itemid item_inventory::function_fba4a353(networkid)) {
      itemid thread item_inventory::function_854cf2c3(networkid);
    }
  }

  return remainingitems;
}

function private function_898628ef(item, player, networkid, itemid, itemcount, var_aec6fa7f, slotid) {
  remainingitems = itemid item_inventory::give_inventory_item(networkid, itemcount, var_aec6fa7f, slotid);
  stockammo = networkid.stockammo;

  if(remainingitems < itemcount) {
    if(isDefined(networkid.networkid) && item_world_util::function_db35e94f(networkid.networkid)) {
      networkid = item_inventory::get_inventory_item(networkid.networkid);
    }

    if(itemid item_inventory::function_fba4a353(networkid)) {
      itemid thread item_inventory::function_1ac37022(networkid, stockammo);
    }
  }

  return remainingitems;
}

function private function_a240798a(item, player, networkid, itemid, itemcount, var_aec6fa7f, slotid) {
  remainingitems = itemcount item_inventory::give_inventory_item(itemid, var_aec6fa7f, undefined, slotid);
  return remainingitems;
}

function private function_24dc1d12(item, player, networkid, itemid, itemcount, var_aec6fa7f, slotid) {
  return false;
}

function private function_c3f4d281(item, player, networkid, itemid, itemcount, var_aec6fa7f, slotid) {
  self hud::function_4a4de0de();
  nullweapon = getweapon(#"none");
  var_f945fa92 = getweapon(#"bare_hands");
  var_f934814c = getweapon(#"ww_ieu_electric_t9");
  var_92587dd3 = getweapon(#"ww_ieu_electric_t9_upgraded");

  foreach(weaponslot in item_inventory_util::function_4905dddf()) {
    inventoryweapon = self item_inventory_util::function_2b83d3ff(self item_inventory::function_2e711614(weaponslot));

    if(isDefined(inventoryweapon) && inventoryweapon != nullweapon && inventoryweapon != var_f945fa92 && inventoryweapon.weapclass != "melee" && inventoryweapon.rootweapon != var_f934814c && inventoryweapon.rootweapon != var_92587dd3) {
      ammoamount = isDefined(slotid.itementry.amount) ? slotid.itementry.amount : 20;
      maxammo = inventoryweapon.maxammo;
      var_e6527384 = maxammo * ammoamount / 100;
      currentammostock = self getweaponammostock(inventoryweapon);
      var_e6527384 = currentammostock + var_e6527384;

      if(var_e6527384 < 0) {
        var_e6527384 = 0;
      } else if(var_e6527384 > maxammo) {
        var_e6527384 = maxammo;
      }

      self setweaponammostock(inventoryweapon, int(var_e6527384));
    }
  }

  return false;
}

function private function_80ef3ea5(item, player, networkid, itemid, itemcount, var_aec6fa7f, slotid) {
  return false;
}

function private function_753fb11f(item, player, networkid, itemid, itemcount, var_aec6fa7f, slotid) {
  return false;
}

function private function_88803841(item, player, networkid, itemid, itemcount, var_aec6fa7f, slotid) {
  return false;
}

function private function_d46c2559(item, player, networkid, itemid, itemcount, var_aec6fa7f, slotid) {
  item_drop::function_d8342646(slotid.var_25b21f27);
  return false;
}

function private function_2650d5c6(item, player, networkid, itemid, itemcount, var_aec6fa7f, slotid) {
  self hud::function_801bf40f();
  var_2cacdde7 = 50;
  inventoryitem = slotid.inventory.items[6];

  if(isDefined(inventoryitem)) {
    var_2cacdde7 = isDefined(inventoryitem.itementry.var_a3aa1ca2) ? inventoryitem.itementry.var_a3aa1ca2 : 50;

    if(isDefined(level.var_8cc294a7)) {
      var_2cacdde7 = [[level.var_8cc294a7]](var_2cacdde7);
    }

    if(var_2cacdde7 == 0) {
      var_2cacdde7 = 50;
    }
  }

  var_2cacdde7 = int(var_2cacdde7);
  self.armor += math::clamp(var_2cacdde7, 0, self.maxarmor);
  return false;
}

function private function_a712496a(item, player, networkid, itemid, itemcount, var_aec6fa7f, slotid) {
  assert(isPlayer(self));
  stockammo = networkid.stockammo;

  if(isDefined(networkid.weaponoverride)) {
    foreach(attachment in networkid.weaponoverride.attachments) {
      attachmentname = item_world_util::function_6a0ee21a(attachment);

      if(!isDefined(attachmentname)) {
        continue;
      }

      attachmentitem = item_world_util::function_49ce7663(attachmentname);

      if(!isDefined(attachmentitem)) {
        continue;
      }

      item_inventory_util::function_9e9c82a6(networkid, attachmentitem);
    }
  }

  if(item_inventory::get_weapon_count() == item_inventory_util::function_80fb4b76()) {
    stashitem = item_world_util::function_83c20f83(networkid);
    stashitem &= ~(isDefined(networkid.deathstash) ? networkid.deathstash : 0);
    weaponitem = item_inventory::function_230ceec4(itemid.currentweapon);

    if(!isDefined(weaponitem)) {
      itemid takeweapon(itemid.currentweapon);
    } else {
      itemid item_inventory::drop_inventory_item(weaponitem.networkid, stashitem, itemid.origin, isDefined(networkid.targetnamehash) ? networkid.targetnamehash : networkid.targetname, undefined, 1);
    }
  }

  remainingitems = itemid item_inventory::give_inventory_item(networkid, itemcount, var_aec6fa7f, slotid);

  if(remainingitems < itemcount) {
    if(isDefined(networkid.networkid) && item_world_util::function_db35e94f(networkid.networkid)) {
      networkid = item_inventory::get_inventory_item(networkid.networkid);
    }

    if(isDefined(networkid.itementry.ammomodname)) {
      itemid item_inventory::function_b579540e(networkid, networkid.itementry.ammomodname);
      weapon = item_inventory_util::function_2b83d3ff(networkid);
      itemid aat::acquire(weapon, networkid.itementry.ammomodname);
    }

    itemid item_inventory::equip_weapon(networkid, 1, 1, 0, 1, stockammo);
  }

  return remainingitems;
}