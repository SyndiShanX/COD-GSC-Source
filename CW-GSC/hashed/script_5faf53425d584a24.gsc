/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5faf53425d584a24.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_world;
#using scripts\core_common\item_world_util;
#using scripts\core_common\system_shared;
#namespace namespace_c8382500;

function private autoexec __init__system__() {
  system::register(#"hash_63f9eec221c850be", &preinit, undefined, undefined, #"item_world");
}

function private preinit() {
  if(!item_inventory::function_7d5553ac()) {
    level.var_e8af489f = &function_23b313bd;
  }
}

function private function_a7b7d70b(player, networkid) {
  if(item_inventory::function_7d5553ac()) {
    return;
  }

  item = player item_inventory::get_inventory_item(networkid);

  if(isDefined(item) && isDefined(item.itementry) && is_true(item.itementry.consumable)) {
    player function_b00db06(15, item.networkid);
  }
}

function private function_23b313bd(player, eventtype, eventdata, var_c5a66313) {
  if(is_true(level.var_ab396c31)) {
    return;
  }

  if(!isDefined(player)) {
    return;
  }

  switch (eventtype) {
    case 1:
      return;
    case 2:
      var_c1ea9cae = is_true(eventdata);
      player.var_c1ea9cae = var_c1ea9cae;
      break;
  }

  item_world::function_1b11e73c();

  if(!isDefined(player) || !isalive(player)) {
    return;
  }

  if(eventtype == 4 || eventtype == 11) {
    networkid = eventdata;
    quickequip = var_c5a66313;
    weaponid = eventtype == 11 ? 1 : 0;

    if(player inlaststand() || !isDefined(player.inventory) || !player item_inventory::equip_item(networkid, quickequip === 1, weaponid)) {
      function_a7b7d70b(player, networkid);
      return;
    }

    itemid = player item_inventory::function_c48cd17f(networkid);

    if(itemid != 32767) {
      item = function_b1702735(itemid);

      if(isDefined(item) && isDefined(item.itementry)) {
        item_world::function_1a46c8ae(player, undefined, undefined, item.itementry, item.itementry.amount);
      }
    }

    return;
  }

  if(player inlaststand()) {
    return;
  }

  if(!isDefined(player.inventory)) {
    return;
  }

  switch (eventtype) {
    case 3:
    case 12:
      networkid = eventdata;

      if(player clientfield::get_player_uimodel("hudItems.multiItemPickup.status") == 2) {
        item = item_world::function_528ca826(networkid);

        if(isDefined(item) && player item_world_util::can_pick_up(item)) {
          success = player item_world::pickup_item(item, 1, eventtype == 12);

          if(success) {
            stash = item_world_util::function_31f5aa51(item);

            if(isDefined(stash) && is_true(stash.lootlocker)) {
              var_97809692 = player item_inventory::function_2e711614(10);

              if(var_97809692.itementry.name == # "resource_item_loot_locker_key") {
                player item_inventory::use_inventory_item(var_97809692.networkid, 1);

                if(!isDefined(player.var_fbcc86d3)) {
                  player.var_fbcc86d3 = [];
                }

                player.var_fbcc86d3[item.itementry.weapon.name] = 1;
              }

              var_97809692 = player item_inventory::function_2e711614(10);

              if(!isDefined(var_97809692.itementry) || var_97809692.itementry.name != # "resource_item_loot_locker_key") {
                stash.var_193b3626 = undefined;
              }

              if(!isDefined(stash.var_80b1d504)) {
                stash.var_80b1d504 = 0;
              }

              stash.var_80b1d504 += 1;
            }
          }
        }
      }

      break;
    case 5:
      networkid = eventdata;
      count = var_c5a66313;
      var_a1ca235e = undefined;
      var_3d1f9df4 = undefined;

      if(item_world_util::function_2c7fc531(networkid)) {
        itemid = networkid;
        item = function_b1702735(itemid);
        assert(item.itementry.itemtype == # "ammo");

        if(item.itementry.itemtype == # "ammo") {
          var_a1ca235e = item.itementry;
          var_3d1f9df4 = count;
          player item_inventory::function_ecd1c667(itemid, count);
        }
      } else {
        if(networkid == 32767) {
          return;
        }

        inventory_item = player item_inventory::get_inventory_item(networkid);

        if(!isDefined(inventory_item)) {
          break;
        }

        removeonly = isDefined(inventory_item.endtime);

        if(!isDefined(count) || count === inventory_item.count || removeonly) {
          var_3d1f9df4 = isDefined(count) ? count : inventory_item.itementry.amount;
          player item_inventory::drop_inventory_item(networkid);
        } else {
          var_3d1f9df4 = count;
          player item_inventory::function_cfe0e919(networkid, count);
        }
      }

      item_world::function_1a46c8ae(player, var_a1ca235e, var_3d1f9df4, undefined, undefined);
      break;
    case 6:
      networkid = eventdata;
      freeslot = player item_inventory::function_777cc133();

      if(isDefined(freeslot)) {
        player item_inventory::function_d019bf1d(networkid);
        attachmentslot = player item_inventory::function_b246c573(networkid);

        if(isDefined(attachmentslot)) {
          player item_inventory::function_26c87da8(attachmentslot, freeslot);
        }
      }

      break;
    case 7:
      networkid = eventdata;
      equipdata = var_c5a66313;
      item = item_world::function_528ca826(networkid);

      if(!isDefined(item)) {
        return;
      }

      origin = player getplayercamerapos();

      if(distance2dsquared(origin, item.origin) > sqr(128) || abs(origin[2] - item.origin[2]) > 128) {
        return;
      }

      if(!isDefined(item) || !isDefined(item.itementry)) {
        return;
      }

      if(item.itementry.itemtype == # "weapon") {
        var_bd31d7b2 = player item_inventory::function_ec087745();

        if(equipdata == 1 && var_bd31d7b2 != 32767) {
          player item_inventory::function_9d102bbd(item, var_bd31d7b2);
        } else {
          player item_world::pickup_item(item, 1);
        }
      } else {
        if(equipdata == 2) {
          player item_inventory::function_fba40e6c(item);
          break;
        }

        var_641d3dc2 = item.itementry.itemtype != # "attachment";
        itementry = item.itementry;
        player item_world::pickup_item(item, var_641d3dc2);

        if(equipdata == 1 || equipdata == 2) {
          if(isDefined(itementry)) {
            inventoryitem = player item_inventory::function_8babc9f9(itementry);
          }

          if(isDefined(inventoryitem)) {
            switch (inventoryitem.itementry.itemtype) {
              case # "tactical":
              case # "equipment":
              case # "field_upgrade":
                player item_inventory::equip_equipment(inventoryitem);
                break;
              case # "health":
                player item_inventory::equip_health(inventoryitem);
                break;
              case # "perk_tier_3":
              case # "perk_tier_2":
              case # "perk_tier_1":
                player item_inventory::function_854cf2c3(inventoryitem);
                break;
              case # "scorestreak":
                player item_inventory::function_1ac37022(inventoryitem);
                break;
            }
          }
        }
      }

      break;
    case 8:
      networkid = eventdata;
      player item_inventory::function_9ba10b94(networkid);
      break;
    case 10:
      player item_inventory::cycle_health_item();
      break;
    case 9:
      player item_inventory::cycle_equipment_item();
      break;
    case 13:
      item = eventdata;
      cost = var_c5a66313;

      if(isDefined(item) && isDefined(cost)) {
        if(isDefined(level.var_df225c5e)) {
          [[level.var_df225c5e]](item, cost, player);
        }
      }
    case 14:
      player item_inventory::function_fa4bb600();
      break;
    case 15:
      player item_inventory::function_a50547af();
      break;
  }
}