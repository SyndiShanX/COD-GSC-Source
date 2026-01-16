/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_items.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\hud_util_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_equipment;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zm_items;

autoexec __init__system__() {
  system::register(#"zm_items", &__init__, &__main__, undefined);
}

__init__() {
  if(!isDefined(level.var_ddfee332)) {
    level.var_ddfee332 = 0;
  }

  if(!isDefined(level.item_list)) {
    level.item_list = [];
  }

  if(!isDefined(level.item_spawns)) {
    level.item_spawns = [];
  }

  if(!isDefined(level.item_inventory)) {
    level.item_inventory = [];
  }

  if(!isDefined(level.item_callbacks)) {
    level.item_callbacks = [];
  }

  clientfield::register("item", "highlight_item", 1, 2, "int");
  callback::on_spawned(&player_on_spawned);
}

__main__() {
  a_items = getitemarray();

  foreach(item in a_items) {
    w_item = item.item;

    if(isDefined(w_item) && isDefined(w_item.craftitem) && w_item.craftitem) {
      tname = w_item;

      if(!isDefined(level.item_spawns[tname])) {
        level.item_spawns[tname] = [];
      }

      if(!isDefined(level.item_spawns[tname])) {
        level.item_spawns[tname] = [];
      } else if(!isarray(level.item_spawns[tname])) {
        level.item_spawns[tname] = array(level.item_spawns[tname]);
      }

      level.item_spawns[tname][level.item_spawns[tname].size] = item;

      if(!isDefined(level.item_list)) {
        level.item_list = [];
      } else if(!isarray(level.item_list)) {
        level.item_list = array(level.item_list);
      }

      if(!isinarray(level.item_list, w_item)) {
        level.item_list[level.item_list.size] = w_item;
      }
    }
  }

  foreach(a_items in level.item_spawns) {
    var_b38ebe37 = a_items[0].item.var_ec2cbce2;

    if(isDefined(level.var_fd2e6f70)) {
      a_items = [
        [level.var_fd2e6f70]
      ](a_items);
    } else {
      a_items = array::randomize(a_items);
    }

    var_7a1b3d24 = 0;

    var_7a1b3d24 = getdvarint(#"hash_7f8707c59bcda3cb", 0);

      if(var_7a1b3d24 === 0) {
        if(a_items.size > var_b38ebe37) {
          for(i = var_b38ebe37; i < a_items.size; i++) {
            a_items[i] delete();
          }
        }
      }
  }

  level thread function_307756a0();

}

player_on_spawned() {
  if(!isDefined(self.item_inventory)) {
    self.item_inventory = [];
  }

  if(!isDefined(self.item_slot_inventory)) {
    self.item_slot_inventory = [];
  }
}

function_4d230236(w_item, fn_callback) {
  if(!isDefined(level.item_callbacks)) {
    level.item_callbacks = [];
  }

  if(!isDefined(level.item_callbacks[w_item])) {
    level.item_callbacks[w_item] = [];
  }

  if(!isDefined(level.item_callbacks[w_item])) {
    level.item_callbacks[w_item] = [];
  } else if(!isarray(level.item_callbacks[w_item])) {
    level.item_callbacks[w_item] = array(level.item_callbacks[w_item]);
  }

  level.item_callbacks[w_item][level.item_callbacks[w_item].size] = fn_callback;
}

private function_307756a0() {
  while(true) {
    waitresult = level waittill(#"player_bled_out");
    player = waitresult.player;
    player thread function_b64c32cf(player);
  }
}

private function_b64c32cf(player) {
  foreach(item in level.item_list) {
    if(item.var_337fc1cf && isDefined(player.item_inventory[item]) && player.item_inventory[item]) {
      if(item.var_9fffdcee) {
        assertmsg("<dev string:x38>" + item.name + "<dev string:x46>");
        continue;
      }

      function_ab3bb6bf(player, item);
    }
  }
}

player_has(player, w_item) {
  if(!(isDefined(w_item.craftitem) && w_item.craftitem) && isDefined(player)) {
    if(w_item.var_9fffdcee) {
      assertmsg("<dev string:x9a>" + w_item.name + "<dev string:xa4>");
    } else {
      return player hasweapon(w_item);
    }
  }

  if(w_item.var_9fffdcee) {
    holder = level;
  } else {
    holder = player;
  }

  if(!isDefined(holder.item_inventory)) {
    holder.item_inventory = [];
  }

  return isDefined(holder.item_inventory[w_item]) && holder.item_inventory[w_item];
}

player_pick_up(player, w_item) {
  if(w_item.var_9fffdcee) {
    holder = level;
  } else {
    holder = player;
  }

  if(!isDefined(holder.item_inventory)) {
    holder.item_inventory = [];
  }

  holder.item_inventory[w_item] = 1;

  if(w_item.var_df0f9ce9) {
    if(isDefined(holder.item_slot_inventory[w_item.var_df0f9ce9])) {
      player function_ab3bb6bf(holder, holder.item_slot_inventory[w_item.var_df0f9ce9]);
    }

    holder.item_slot_inventory[w_item.var_df0f9ce9] = w_item;
  }

  level notify(#"component_collected", {
    #component: w_item, 
    #holder: holder
  });
  player notify(#"component_collected", {
    #component: w_item, 
    #holder: holder
  });

  if(isDefined(level.item_callbacks[w_item])) {
    foreach(callback in level.item_callbacks[w_item]) {
      player[[callback]](holder, w_item);
    }
  }

  if(!(isDefined(level.var_ddfee332) && level.var_ddfee332) && player hasweapon(w_item)) {
    player takeweapon(w_item);
  }
}

player_take(player, w_item) {
  if(!(isDefined(w_item.craftitem) && w_item.craftitem) && isDefined(player)) {
    if(w_item.var_9fffdcee) {
      assertmsg("<dev string:x9a>" + w_item.name + "<dev string:xa4>");
    } else {
      player zm_weapons::weapon_take(w_item);
    }
  }

  if(w_item.var_9fffdcee) {
    holder = level;
  } else {
    holder = player;
    player zm_weapons::weapon_take(w_item);
  }

  if(!isDefined(holder.item_inventory)) {
    holder.item_inventory = [];
  }

  holder.item_inventory[w_item] = 0;
}

function_ab3bb6bf(holder, w_item) {
  holder.item_inventory[w_item] = 0;

  if(w_item.var_df0f9ce9) {
    holder.item_slot_inventory[w_item.var_df0f9ce9] = undefined;
  }

  level notify(#"component_lost", {
    #component: w_item, 
    #holder: holder
  });
  self notify(#"component_lost", {
    #component: w_item, 
    #holder: holder
  });

  if(self hasweapon(w_item)) {
    self takeweapon(w_item);
  }

  new_item = spawn_item(w_item, self.origin + (0, 0, 8), self.angles);
  return new_item;
}

spawn_item(w_item, v_origin, v_angles, var_f93e465d = 1) {
  new_item = spawnweapon(w_item, v_origin, v_angles, var_f93e465d);
  return new_item;
}

debug_items() {
  for(;;) {
    a_items = getitemarray();

    foreach(item in a_items) {
      w_item = item.item;

      if(isDefined(w_item) && isDefined(w_item.craftitem) && w_item.craftitem) {
        sphere(item.origin, 6, (0, 0, 1), 1, 0, 12, 20);
      }
    }

    wait 1;
  }
}

