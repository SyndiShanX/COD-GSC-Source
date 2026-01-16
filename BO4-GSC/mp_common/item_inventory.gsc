/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\item_inventory.gsc
***********************************************/

#include scripts\abilities\ability_player;
#include scripts\abilities\gadgets\gadget_health_regen;
#include scripts\core_common\activecamo_shared_util;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\player\player_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\mp_common\armor;
#include scripts\mp_common\item_drop;
#include scripts\mp_common\item_inventory_util;
#include scripts\mp_common\item_world;
#include scripts\mp_common\item_world_util;
#include scripts\mp_common\player\player_loadout;
#include scripts\weapons\sensor_dart;

#namespace item_inventory;

autoexec __init__system__() {
  system::register(#"item_inventory", &__init__, undefined, #"item_world");
}

private __init__() {
  if(!isDefined(getgametypesetting(#"useitemspawns")) || getgametypesetting(#"useitemspawns") == 0) {
    return;
  }

  level.var_67f4fd41 = &function_38d1ea04;
  level.var_dea62998 = &function_bdc03d88;
  level.var_cf16ff75 = &function_a2162b3b;
  level.var_6ec46eeb = &function_d85c5382;
  level.sensor_darts = [];
  clientfield::register("clientuimodel", "hudItems.multiItemPickup.status", 17000, 3, "int");
  clientfield::register_clientuimodel("hudItems.healthItemstackCount", 5000, 8, "int", 0);
  clientfield::register_clientuimodel("hudItems.equipmentStackCount", 5000, 8, "int", 0);
  ability_player::register_gadget_activation_callbacks(23, &_gadget_health_regen_on, &_gadget_health_regen_off);
  ability_player::register_gadget_primed_callbacks(23, &function_d116a346);
  level.var_d3b4a4db = &function_64d3e50;
  level thread function_d2f05352();
  level.var_5c14d2e6 = &function_3f7ef88;
  level.var_317fb13c = &function_3f7ef88;

  if(!isDefined(level.var_4cf92425)) {
    level.var_4cf92425 = [];
  }
}

function_64d3e50() {
  if(!isDefined(self) || !isDefined(self.inventory) || !isDefined(self.inventory.items) || !isDefined(self.inventory.items[10])) {
    return;
  }

  networkid = self.inventory.items[10].networkid;

  if(isDefined(networkid) && networkid != 32767) {
    item = get_inventory_item(networkid);
    self thread use_inventory_item(networkid, 1, 0);
  }
}

function_299d2131(maxhealth, healthamount, var_4465ef1e) {
  self endon(#"death");

  while(self.heal.enabled) {
    waitframe(1);
  }

  if(!isDefined(self)) {
    return;
  }

  self.var_44d52546 = 1;
  self player::function_9080887a(maxhealth);
  self.heal.var_bc840360 = math::clamp(healthamount + self.health, 0, maxhealth);
  self.heal.rate = healthamount / var_4465ef1e;
  self gadget_health_regen::function_ddfdddb1();
  self gadget_health_regen::heal_start();
  self callback::function_d8abfc3d(#"done_healing", &function_4a257174);
}

function_4a257174() {
  if(isDefined(self)) {
    self callback::function_52ac9652(#"done_healing", &function_4a257174);
    self.var_44d52546 = undefined;
    gadget_health_regen::heal_end();
  }
}

function_fc04b237(weapon, weaponoptions) {
  assert(isplayer(self));
  assert(isDefined(weapon));

  if(!isDefined(weaponoptions)) {
    return;
  }

  if(!isDefined(self.pers) || !isDefined(self.pers[#"activecamo"])) {
    return weaponoptions;
  }

  camoindex = getcamoindex(weaponoptions);
  activecamoname = getactivecamo(camoindex);

  if(!isDefined(activecamoname) || !isDefined(self.pers[#"activecamo"][activecamoname])) {
    return weaponoptions;
  }

  activecamo = self.pers[#"activecamo"][activecamoname];

  if(!isDefined(activecamo) || !isDefined(activecamo.var_dd54a13b)) {
    return weaponoptions;
  }

  var_28c04c49 = activecamo::function_c14cb514(weapon);
  weaponstate = activecamo.var_dd54a13b[var_28c04c49];

  if(!isDefined(weaponstate)) {
    return weaponoptions;
  }

  stagenum = weaponstate.stagenum;

  if(!isDefined(stagenum)) {
    return weaponoptions;
  }

  stage = activecamo.stages[stagenum];
  var_7df02232 = stage.var_19b6044e;

  if(!isDefined(var_7df02232)) {
    return weaponoptions;
  }

  buildkitweapon = activecamo::function_385ef18d(weapon);
  weaponoptions = self getbuildkitweaponoptions(buildkitweapon, var_7df02232, stagenum);
  return weaponoptions;
}

private function_a2162b3b(deployableweapon) {
  if(isplayer(self)) {
    if(deployableweapon === self.var_cc111ddc) {
      self.var_cc111ddc = undefined;
    }

    if(deployableweapon === self.var_8181d952) {
      self.var_8181d952 = undefined;
    }

    if(deployableweapon === self.var_cd3bc45b) {
      self.var_cd3bc45b = undefined;
    }

    if(deployableweapon === self.var_d0015cb3) {
      self.var_d0015cb3 = undefined;
    }

    if(deployableweapon === self.var_14c391cc) {
      self.var_14c391cc = undefined;
    }
  }
}

private function_d62822d5() {
  self.var_cc111ddc = undefined;
  self.var_8181d952 = undefined;
  self.var_cd3bc45b = undefined;
  self.var_d0015cb3 = undefined;
  self.var_14c391cc = undefined;
}

private function_76646dad(weapon) {
  if(weapon.name == #"basketball") {
    return true;
  }

  slot = self gadgetgetslot(weapon);
  return slot == 0;
}

private function_e72d56f9(weapon, usecount) {
  assert(isDefined(weapon));

  if(isplayer(self) && isalive(self)) {
    self function_d62822d5();
    networkid = self function_a33744de(weapon);

    if(networkid != 32767) {
      self use_inventory_item(networkid, usecount, 0);
      item = self get_inventory_item(networkid);

      if(isDefined(item) && item.count > 0) {
        self function_c6be9f7f(weapon, item.count);
      }
    }
  }
}

private event_handler[event_1294e3a7] function_9e4c68e2(eventstruct) {
  if(sessionmodeiswarzonegame() && isplayer(self) && isalive(self) && self function_76646dad(eventstruct.weapon)) {
    self.var_cd3bc45b = eventstruct.weapon;
  }
}

event_handler[event_eb7e11e4] function_2f677e9d(eventstruct) {
  if(sessionmodeiswarzonegame() && isplayer(self) && isalive(self) && self function_76646dad(eventstruct.weapon)) {
    self.var_d0015cb3 = eventstruct.weapon;
  }
}

private event_handler[grenade_fire] function_4776caf4(eventstruct) {
  if(sessionmodeiswarzonegame() && isplayer(self) && isalive(self) && self function_76646dad(eventstruct.weapon)) {
    self.var_8181d952 = eventstruct.weapon;
    var_994e5c9a = 0;
    equipments = array(#"ability_smart_cover", #"eq_concertina_wire", #"eq_grapple", #"dart", #"eq_hawk", #"ultimate_turret");

    foreach(equipmentname in equipments) {
      if(eventstruct.weapon.name == equipmentname) {
        var_994e5c9a = 1;
        break;
      }
    }

    var_aec6fa7f = undefined;

    if(!var_994e5c9a) {
      weapon = eventstruct.weapon;
      networkid = self function_a33744de(weapon);

      if(networkid != 32767) {
        item = self get_inventory_item(networkid);

        if(isDefined(item) && item.amount > 0) {
          var_aec6fa7f = item.amount;
        }
      }

      self function_e72d56f9(weapon, 1);
    }

    weaponname = eventstruct.weapon.name;

    if(weaponname == #"trophy_system" || weaponname == #"hatchet" || weaponname == #"tomahawk_t8" || weaponname == #"basketball" || weaponname == #"cymbal_monkey") {
      if(isDefined(eventstruct.projectile)) {
        dropitem = eventstruct.projectile;
        dropitem endon(#"death");

        if(weaponname == #"basketball") {
          dropitem setinvisibletoplayer(self);
          wait 0.25;

          if(isDefined(self)) {
            dropitem setvisibletoplayer(self);
          }
        }

        if(weaponname == #"cymbal_monkey") {
          waitframe(1);
          dropitem = dropitem.mdl_monkey;
        }

        if(weaponname == #"trophy_system") {
          if(isDefined(item)) {
            self._trophy_system_ammo1 = var_aec6fa7f;
          }
        }

        wait 0.5;

        if(!isDefined(dropitem)) {
          return;
        }

        itemspawnpoint = function_d08934c6(weaponname);

        if(!isDefined(itemspawnpoint)) {
          return;
        }

        assert(itemspawnpoint.id < 1024);
        dropitem.id = itemspawnpoint.id;
        dropitem.networkid = item_world_util::function_1f0def85(dropitem);
        dropitem.itementry = itemspawnpoint.itementry;
        dropitem.hidetime = 0;
        dropitem.amount = eventstruct.weapon.name == #"basketball" ? 1 : 0;
        dropitem.count = 1;
        dropitem clientfield::set("dynamic_item_drop", 1);
        dropitem setitemindex(dropitem.id);
        level.item_spawn_drops[dropitem.networkid] = dropitem;
      }

      return;
    }

    if(weaponname == #"waterballoon") {
      if(isDefined(eventstruct.projectile)) {
        camoindex = getcamoindex(self getweaponoptions(eventstruct.weapon));
        var_f94ce554 = array(111, 112, 113, 114, 115, 116);
        var_af7d7388 = array(#"hash_7306b72d120049f8", #"hash_27ae7cb403d5365b", #"hash_6add258ae958d31c", #"hash_6eb8f7ceb4627d9f", #"hash_228bf15c70137b61", #"hash_10c0ee53a36783e9");
        assert(var_f94ce554.size == var_af7d7388.size);

        for(index = 0; index < var_f94ce554.size && index < var_af7d7388.size; index++) {
          if(var_f94ce554[index] == camoindex) {
            eventstruct.projectile setModel(var_af7d7388[index]);
            arrayremoveindex(var_f94ce554, index, 0);
            break;
          }
        }

        wait 0.5;

        if(isDefined(self) && self hasweapon(eventstruct.weapon, 1)) {
          weaponoptions = self calcweaponoptions(var_f94ce554[randomintrange(0, var_f94ce554.size)], 0, 0);
          self updateweaponoptions(eventstruct.weapon, weaponoptions);
        }
      }
    }
  }
}

private event_handler[weapon_switch_started] function_f5883bb1(eventstruct) {
  self.next_weapon = undefined;

  if(sessionmodeiswarzonegame() && isplayer(self) && isalive(self)) {
    if(eventstruct.weapon.isprimary && eventstruct.weapon != eventstruct.last_weapon) {
      self.next_weapon = eventstruct.weapon;
    }
  }
}

private event_handler[weapon_change] function_a8c42ee4(eventstruct) {
  if(sessionmodeiswarzonegame() && isplayer(self) && isalive(self)) {
    if(isDefined(self.var_8181d952)) {
      weapon = self.var_8181d952;
      equipments = array();

      foreach(equipmentname in equipments) {
        if(weapon.name == equipmentname) {
          self function_e72d56f9(weapon, 1);
          return;
        }
      }
    }

    if(isDefined(self.var_d0015cb3)) {
      weapon = self.var_d0015cb3;
      equipments = array(#"ability_smart_cover", #"eq_concertina_wire", #"ultimate_turret");

      foreach(equipmentname in equipments) {
        if(weapon.name == equipmentname) {
          self function_e72d56f9(weapon, 1);
          return;
        }
      }
    }
  }
}

event_handler[gadget_primed] gadget_primed_callback(eventstruct) {
  player = eventstruct.entity;

  if(sessionmodeiswarzonegame() && isplayer(player) && isalive(player) && player function_76646dad(eventstruct.weapon)) {
    function_d62822d5();
    player.var_cc111ddc = eventstruct.weapon;
  }
}

event_handler[gadget_on] gadget_on_callback(eventstruct) {
  player = eventstruct.entity;

  if(sessionmodeiswarzonegame() && isplayer(player) && isalive(player) && player function_76646dad(eventstruct.weapon)) {
    equipments = array(#"eq_grapple", #"dart", #"eq_hawk");

    foreach(equipmentname in equipments) {
      if(eventstruct.weapon.name == equipmentname) {
        weapon = eventstruct.weapon;
        player function_e72d56f9(weapon, 1);
      }
    }
  }
}

event_handler[event_dfabd488] function_40d8d1ec(eventstruct) {
  player = eventstruct.entity;

  if(sessionmodeiswarzonegame() && isplayer(player) && isalive(player) && player function_76646dad(eventstruct.weapon)) {
    player.var_14c391cc = eventstruct.weapon;
  }
}

event_handler[change_seat] function_2aa4e6cf(eventstruct) {
  player = self;

  if(sessionmodeiswarzonegame() && isplayer(player) && isalive(player)) {
    if(eventstruct.seat_index == 0 && player function_2cceca7b()) {
      player forceoffhandend();
    }
  }
}

private function_38d1ea04() {
  if(isplayer(self) && isDefined(self.inventory)) {
    inventoryitem = self.inventory.items[11];

    if(isDefined(inventoryitem) && isDefined(inventoryitem.itementry)) {
      armorshards = inventoryitem.itementry.armorshards;
    }

    if(isDefined(armorshards) && armorshards > 0) {
      armorshard = function_4ba8fde(#"armor_shard_item");

      if(isDefined(armorshard)) {
        var_7841fe31 = self give_inventory_item(armorshard, armorshards, undefined, 16);

        if(var_7841fe31 > 0) {
          function_d7944517(armorshard.id, undefined, var_7841fe31);
        }
      }
    }

    if(inventoryitem.networkid != 32767 && inventoryitem.itementry.itemtype == #"armor") {
      self remove_inventory_item(inventoryitem.networkid);
    }
  }
}

private function_bdc03d88() {
  if(isplayer(self) && isDefined(self.inventory)) {
    inventoryitem = self.inventory.items[11];

    if(inventoryitem.networkid != 32767 && inventoryitem.itementry.itemtype == #"armor") {
      inventoryitem.amount = armor::get_armor();

      if(function_27cd171b(inventoryitem)) {
        self setperk(#"specialty_damaged_armor");
      }
    }
  }
}

private function_434d0c2b(itemtype, prioritylist, var_ab9610ad = undefined) {
  assert(isplayer(self));
  assert(ishash(itemtype));
  assert(isarray(prioritylist));
  items = [];
  var_e3c48c83 = item_world_util::get_itemtype(var_ab9610ad);

  foreach(item in self.inventory.items) {
    if(item.id == 32767) {
      continue;
    }

    var_b74300d3 = item_world_util::get_itemtype(item.itementry);

    if(var_e3c48c83 === var_b74300d3) {
      return item;
    }

    if(item.itementry.itemtype == itemtype) {
      if(isDefined(items[var_b74300d3])) {
        if(item.count > items[var_b74300d3].count) {
          items[var_b74300d3] = item;
        }

        continue;
      }

      items[var_b74300d3] = item;
    }
  }

  foreach(var_b74300d3 in prioritylist) {
    if(isDefined(items[var_b74300d3])) {
      return items[var_b74300d3];
    }
  }

  foreach(item in items) {
    if(isDefined(item)) {
      return item;
    }
  }
}

private _cycle_item(itemtype, prioritylist, var_bcc2655a) {
  assert(isplayer(self));
  assert(ishash(itemtype));
  assert(isarray(prioritylist));

  if(!isDefined(var_bcc2655a)) {
    return;
  }

  items = [];
  var_c7837092 = item_world_util::get_itemtype(var_bcc2655a);

  foreach(item in self.inventory.items) {
    if(item.id == 32767) {
      continue;
    }

    var_b74300d3 = item_world_util::get_itemtype(item.itementry);

    if(item.itementry.itemtype == itemtype) {
      if(isDefined(items[var_b74300d3])) {
        if(item.count > items[var_b74300d3].count) {
          items[var_b74300d3] = item;
        }

        continue;
      }

      items[var_b74300d3] = item;
    }
  }

  for(currentindex = 0; currentindex < prioritylist.size; currentindex++) {
    if(prioritylist[currentindex] == var_c7837092) {
      break;
    }
  }

  for(index = currentindex + 1; index < prioritylist.size; index++) {
    var_b74300d3 = prioritylist[index];

    if(isDefined(items[var_b74300d3])) {
      return items[var_b74300d3];
    }
  }

  if(currentindex < prioritylist.size) {
    for(index = 0; index < currentindex; index++) {
      var_b74300d3 = prioritylist[index];

      if(isDefined(items[var_b74300d3])) {
        return items[var_b74300d3];
      }
    }
  }
}

private function_9da31874(itemtype) {
  assert(isplayer(self));
  assert(ishash(itemtype));
  items = [];

  foreach(index, item in self.inventory.items) {
    if(index >= 10) {
      break;
    }

    if(item.id == 32767 || item.itementry.itemtype != itemtype) {
      continue;
    }

    items[items.size] = item;
  }

  currentindex = isDefined(self.inventory.var_a0290b96[itemtype]) ? self.inventory.var_a0290b96[itemtype] : 0;

  if(currentindex < 0) {
    currentindex = 0;
  } else if(currentindex > items.size) {
    currentindex = items.size;
  }

  if(items.size > 0) {
    currentindex = (currentindex + 1) % items.size;
    self.inventory.var_a0290b96[itemtype] = currentindex;
  }

  return items[currentindex];
}

private function_283a29c8(var_ab9610ad = undefined) {
  assert(isplayer(self));

  if(function_fe402108()) {
    return;
  }

  item = function_434d0c2b(#"equipment", array(#"frag_grenade_wz_item", #"cluster_semtex_wz_item", #"acid_bomb_wz_item", #"molotov_wz_item", #"wraithfire_wz_item", #"hatchet_wz_item", #"tomahawk_t8_wz_item", #"seeker_mine_wz_item", #"dart_wz_item", #"hawk_wz_item", #"ultimate_turret_wz_item", #"swat_grenade_wz_item", #"concussion_wz_item", #"smoke_grenade_wz_item", #"smoke_grenade_wz_item_spring_holiday", #"emp_grenade_wz_item", #"spectre_grenade_wz_item", #"grapple_wz_item", #"unlimited_grapple_wz_item", #"barricade_wz_item", #"spiked_barrier_wz_item", #"trophy_system_wz_item", #"concertina_wire_wz_item", #"sensor_dart_wz_item", #"supply_pod_wz_item", #"trip_wire_wz_item", #"cymbal_monkey_wz_item", #"homunculus_wz_item", #"vision_pulse_wz_item", #"flare_gun_wz_item", #"flare_gun_veh_wz_item", #"wz_snowball", #"wz_waterballoon"), var_ab9610ad);

  if(isDefined(item)) {
    equip_equipment(item);
  }
}

private function_2e10e66e(var_ab9610ad = undefined) {
  assert(isplayer(self));

  if(function_fe402108()) {
    return;
  }

  item = function_434d0c2b(#"backpack", array(#"hash_7c3701ba5f0879c2"), var_ab9610ad);

  if(isDefined(item)) {
    equip_backpack(item);
  }
}

private function_a7d62e18(var_ab9610ad = undefined) {
  assert(isplayer(self));

  if(function_fe402108()) {
    return;
  }

  item = function_434d0c2b(#"health", array(#"health_item_small", #"health_item_medium", #"health_item_large", #"health_item_squad"), var_ab9610ad);

  if(isDefined(item)) {
    equip_health(item);
  }
}

private function_9d805044(itemtype, var_ab9610ad = undefined) {
  assert(isplayer(self));
  assert(isstring(itemtype) || ishash(itemtype));

  if(function_fe402108()) {
    return;
  }

  switch (itemtype) {
    case #"backpack":
      function_2e10e66e(var_ab9610ad);
      break;
    case #"equipment":
      function_283a29c8(var_ab9610ad);
      break;
    case #"health":
      function_a7d62e18(var_ab9610ad);
      break;
    default:
      break;
  }
}

private function_d08934c6(equipment) {
  var_b74300d3 = undefined;

  switch (equipment) {
    case #"hatchet":
      var_b74300d3 = #"hatchet_wz_item";
      break;
    case #"tomahawk_t8":
      var_b74300d3 = #"tomahawk_t8_wz_item";
      break;
    case #"basketball":
      var_b74300d3 = #"wz_ball";
      break;
    case #"cymbal_monkey":
      var_b74300d3 = #"cymbal_monkey_wz_item";
      break;
    case #"trophy_system":
      var_b74300d3 = #"trophy_system_wz_item";
      break;
  }

  if(isDefined(var_b74300d3)) {
    return function_4ba8fde(var_b74300d3);
  }
}

function_520b16d6() {
  item = spawnStruct();
  item.amount = 0;
  item.count = 0;
  item.id = 32767;
  item.networkid = 32767;
  item.itementry = undefined;
  item.var_627c698b = undefined;
  item.weaponoptions = undefined;
  item.charmindex = undefined;
  item.deathfxindex = undefined;
  return item;
}

private function_27cd171b(inventoryitem) {
  if(!isDefined(inventoryitem.amount)) {
    return false;
  }

  if(inventoryitem.amount <= 0) {
    return true;
  }

  return inventoryitem.amount / inventoryitem.itementry.amount <= 0.5;
}

function_d85c5382(sensordart, player) {
  level.sensor_darts[level.sensor_darts.size] = sensordart;
  arrayremovevalue(level.sensor_darts, undefined);
}

private function_d2f05352() {
  level endon(#"game_ended");

  while(true) {
    players = getplayers();
    time = gettime();

    for(playerindex = 0; playerindex < players.size; playerindex++) {
      if((playerindex + 1) % 15 == 0) {
        waitframe(1);
      }

      player = players[playerindex];

      if(!isDefined(player) || player.sessionstate != "playing" || !isalive(player) || !isDefined(player.inventory) || player.inventory.consumed.size <= 0) {
        continue;
      }

      consumed = player.inventory.consumed;
      var_1bc7a1b2 = 0;

      for(i = 0; i < consumed.size; i++) {
        item = consumed[i];

        if(item.endtime <= time) {
          arrayremoveindex(consumed, i);
          var_1bc7a1b2 = 1;
          continue;
        }
      }

      if(var_1bc7a1b2) {
        player function_6c36ab6b();
      }

      for(index = 0; index < 10; index++) {
        item = player.inventory.items[index];

        if(isDefined(item.endtime) && item.endtime <= time) {
          player use_inventory_item(item.networkid, 1, 0);
        }
      }
    }

    players = undefined;
    waitframe(1);
  }
}

private function_a4413333() {
  assert(isplayer(self));
  healthitem = self.inventory.items[10];

  if(healthitem.networkid !== 32767) {
    self clientfield::set_player_uimodel("hudItems.healthItemstackCount", function_bba770de(healthitem.itementry));
  }

  equipmentitem = self.inventory.items[12];

  if(equipmentitem.networkid !== 32767) {
    self clientfield::set_player_uimodel("hudItems.equipmentStackCount", function_bba770de(equipmentitem.itementry));
  }
}

private function_6c36ab6b() {
  self cleartalents();

  foreach(item in self.inventory.items) {
    itementry = item.itementry;

    if(isDefined(itementry) && !(isDefined(itementry.consumable) && itementry.consumable) && isarray(itementry.talents)) {
      foreach(var_9de7969b in itementry.talents) {
        self addtalent(var_9de7969b.talent);
      }
    }
  }

  foreach(item in self.inventory.consumed) {
    itementry = item.itementry;

    if(isDefined(itementry) && isarray(itementry.talents)) {
      foreach(var_9de7969b in itementry.talents) {
        self addtalent(var_9de7969b.talent);
      }
    }
  }

  if(isDefined(self.class_num)) {
    self.specialty = self getloadoutperks(self.class_num);
  } else {
    self.specialty = [];
  }

  self loadout::register_perks();
  armoritem = self.inventory.items[11];

  if(armoritem.networkid != 32767 && armoritem.itementry.itemtype == #"armor") {
    if(function_27cd171b(armoritem)) {
      self setperk(#"specialty_damaged_armor");
    }
  }

  if(isDefined(getgametypesetting(#"wzheavymetalheroes")) ? getgametypesetting(#"wzheavymetalheroes") : 0) {
    self setperk(#"specialty_doublejump");
    self setperk(#"specialty_fallheight");
  }
}

private function_60706bdb(networkid) {
  assert(isplayer(self));
  item = get_inventory_item(networkid);

  if(!isDefined(item) || !isDefined(item.itementry)) {
    return;
  }

  if(item.itementry.itemtype == #"weapon") {
    weapon = item_inventory_util::function_2b83d3ff(item);
    ammoclip = self getweaponammoclip(weapon);
    item.amount = ammoclip;
  }
}

private function_d7944517(itemid, weapon, count, amount, stashitem = 0, var_7cab8e12 = undefined, targetname = undefined, attachments = undefined) {
  assert(isplayer(self));
  assert(item_world_util::function_2c7fc531(itemid));
  self endon(#"death");
  droppos = var_7cab8e12;

  if(!stashitem) {
    forward = anglesToForward(self.angles);
    droppos = self.origin + 36 * forward + (0, 0, 10);
  }

  return self item_drop::drop_item(weapon, count, amount, itemid, droppos, (0, randomintrange(0, 360), 0), stashitem, 0, targetname, undefined, attachments);
}

private function_d116a346(slot, weapon) {
  if(sessionmodeiswarzonegame() && isplayer(self)) {
    self.var_e42fb511 = weapon;
  }
}

private _gadget_health_regen_on(slot, weapon) {
  if(sessionmodeiswarzonegame() && isplayer(self)) {
    self.var_d6cd7d80 = weapon;
  }
}

private _gadget_health_regen_off(slot, weapon) {
  if(sessionmodeiswarzonegame() && isplayer(self)) {
    self.var_d6cd7d80 = undefined;
    self.var_e42fb511 = undefined;
  }
}

private function_2cceca7b() {
  return self isgrappling() || self isusingoffhand() || self function_55acff10(1);
}

private function_c1cef1ec(weapon) {
  if(weapon != self getcurrentoffhand()) {
    return false;
  }

  return self function_2cceca7b();
}

private function_c6be9f7f(weapon, ammo) {
  assert(isplayer(self));
  assert(isDefined(weapon));
  slot = self gadgetgetslot(weapon);

  if(slot >= 0 && slot < 3) {
    if("ammo" != weapon.gadget_powerusetype) {
      return;
    }

    if(weapon.name == #"eq_tripwire") {
      newpower = weapon.gadget_powermax;
      ammo = weapon.clipsize;
    } else {
      if(!weapon.clipsize) {
        var_35935a45 = weapon.gadget_powermax;
      } else {
        var_35935a45 = weapon.gadget_powermax / weapon.clipsize;
      }

      newammo = ammo;

      if(newammo > weapon.clipsize) {
        newammo = weapon.clipsize;
      }

      newpower = newammo * var_35935a45;
    }

    power = self gadgetpowerset(slot, newpower);
    self setweaponammoclip(weapon, ammo);
    debug_print("set_gadget_power: " + power + ", ammo: " + ammo, weapon);
  }
}

private function_ee9ce1c4(itementry, var_dfe6c7e5 = 0) {
  self endon(#"death");
  self.var_10abd91d = 1;
  self replace_weapon(item_world_util::function_35e06774(itementry), level.nullprimaryoffhand);
  self function_c6be9f7f(level.nullprimaryoffhand, 0);
  self.var_10abd91d = 0;
}

private function_8214f1b6(itementry, var_dfe6c7e5 = 0) {
  self endon(#"death");
  self.var_10abd91d = 1;
  weapon = item_world_util::function_35e06774(itementry);
  slot = self gadgetgetslot(weapon);

  if(slot >= 0 && slot < 3) {
    while(self function_af359de(slot)) {
      waitframe(1);
    }
  }

  self replace_weapon(weapon, level.var_ef61b4b5);
  self.var_10abd91d = 0;
}

function_bba770de(itementry) {
  assert(isplayer(self));
  count = 0;

  if(!isDefined(itementry)) {
    return count;
  }

  if(!isDefined(self) || !isDefined(self.inventory) || !isDefined(self.inventory.items)) {
    return count;
  }

  name = isDefined(itementry.parentname) ? itementry.parentname : itementry.name;

  for(index = 0; index < self.inventory.items.size && index < 16 + 1; index++) {
    inventoryitem = self.inventory.items[index];

    if(!isDefined(inventoryitem.itementry)) {
      continue;
    }

    if(name == (isDefined(inventoryitem.itementry.parentname) ? inventoryitem.itementry.parentname : inventoryitem.itementry.name)) {
      count += inventoryitem.count;
    }
  }

  return count;
}

can_pickup_ammo(item, ammoamount = undefined) {
  assert(isplayer(self));
  itementry = item.itementry;
  ammoweapon = itementry.weapon;
  ammoamount = isDefined(itementry.amount) ? itementry.amount : isDefined(ammoamount) ? ammoamount : 1;
  maxstockammo = item_inventory_util::function_2879cbe0(self.inventory.var_7658cbec, ammoweapon);
  currentammostock = self getweaponammostock(ammoweapon);
  var_9b9ba643 = maxstockammo - currentammostock;
  addammo = int(min(ammoamount, var_9b9ba643));
  return addammo > 0;
}

function_550fcb41(item) {
  assert(isplayer(self));

  if(!(isDefined(item.itementry.stackable) && item.itementry.stackable)) {
    return false;
  }

  maxstack = item_inventory_util::function_cfa794ca(self.inventory.var_7658cbec, item.itementry);

  if(maxstack <= 1) {
    return false;
  }

  for(i = 0; i < self.inventory.items.size; i++) {
    if(self.inventory.items[i].id == 32767) {
      continue;
    }

    if(self.inventory.items[i].itementry.name != item.itementry.name) {
      continue;
    }

    if(self.inventory.items[i].count < maxstack) {
      return true;
    }
  }

  return false;
}

private function_85645978(item) {
  currtime = gettime();

  foreach(consumeditem in self.inventory.consumed) {
    if(item.itementry.name == consumeditem.itementry.name && currtime < consumeditem.endtime) {
      return consumeditem;
    }
  }

  return undefined;
}

private function_3fe6ef04() {
  assert(isplayer(self));
  var_cfa0e915 = [];

  foreach(consumeditem in self.inventory.consumed) {
    if(isDefined(var_cfa0e915[consumeditem.itementry.name])) {
      continue;
    }

    var_cfa0e915[consumeditem.itementry.name] = 1;
  }

  return var_cfa0e915.size;
}

consume_item(item) {
  assert(isplayer(self));
  assert(isDefined(item));

  if(!isDefined(item) || !isDefined(item.itementry)) {
    return 0;
  }

  if(isDefined(item.starttime)) {
    return 0;
  }

  if(self isinvehicle()) {
    vehicle = self getvehicleoccupied();

    if(vehicle getoccupantseat(self) == 0) {
      self playsoundtoplayer(#"uin_unavailable_charging", self);
      return 0;
    }

    currentweapon = self getcurrentweapon();

    if(isDefined(currentweapon) && isDefined(currentweapon.var_29d24e37) && currentweapon.var_29d24e37) {
      self playsoundtoplayer(#"uin_unavailable_charging", self);
      return 0;
    }
  }

  if(item.itementry.itemtype == #"armor_shard") {
    return function_6d647220(item);
  }

  consumeditem = self function_85645978(item);

  if(!isDefined(consumeditem) && self function_3fe6ef04() >= 10) {
    self playsoundtoplayer(#"uin_unavailable_charging", self);
    return 0;
  }

  self callback::callback(#"hash_5775ae80fc576ea6", item);
  duration = int((isDefined(item.itementry.duration) ? item.itementry.duration : 0) * 1000);
  starttime = gettime();
  endtime = starttime + duration;
  item.starttime = starttime;
  item.endtime = endtime;

  if(isDefined(consumeditem)) {
    consumeditem.endtime += duration;

    for(index = 0; index < 10; index++) {
      inventoryitem = self.inventory.items[index];

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
    consumeditem.starttime = gettime();
    consumeditem.endtime = consumeditem.starttime + duration;
  }

  self.inventory.consumed[self.inventory.consumed.size] = consumeditem;
  level callback::callback(#"on_drop_inventory", self);
  self function_b00db06(11, item.networkid);
  self function_db2abc4(item);
  self function_6c36ab6b();

  if(isDefined(consumeditem.itementry) && isDefined(consumeditem.itementry.talents) && isarray(consumeditem.itementry.talents)) {
    foreach(talent in consumeditem.itementry.talents) {
      if(talent.talent == #"hash_6b4f1f8c0c22026f") {
        self thread function_299d2131(300, 100, 0.1);
        break;
      }
    }
  }

  return 1;
}

function_6d647220(item) {
  assert(isplayer(self));
  assert(isDefined(item));

  if(!isDefined(item) || item.networkid == 32767) {
    return false;
  }

  if(!has_armor()) {
    return false;
  }

  if(!isDefined(self.armor) || !isDefined(self.maxarmor)) {
    return false;
  }

  if(self.armor == self.maxarmor) {
    return false;
  }

  self use_inventory_item(item.networkid, 1);
  armoritem = undefined;

  if(isplayer(self) && isDefined(self.inventory)) {
    armoritem = self.inventory.items[11];

    if(!isDefined(armoritem) || armoritem.networkid == 32767 || armoritem.itementry.itemtype != #"armor") {
      return false;
    }
  }

  if(isDefined(self.var_3f1410dd)) {
    self.var_3f1410dd.repair_amount += int(min(isDefined(armoritem.itementry.var_a3aa1ca2) ? armoritem.itementry.var_a3aa1ca2 : 0, self.maxarmor - self.armor));
    self.var_3f1410dd.var_7352c057++;
  }

  self.armor = int(min(self.armor + (isDefined(armoritem.itementry.var_a3aa1ca2) ? armoritem.itementry.var_a3aa1ca2 : 0), self.maxarmor));
  function_bdc03d88();
  self function_6c36ab6b();
  self function_db2abc4(item);
  return true;
}

cycle_equipment_item() {
  assert(isplayer(self));
  var_bcc2655a = undefined;
  equipmentitem = self.inventory.items[12];

  if(equipmentitem.networkid !== 32767) {
    var_bcc2655a = equipmentitem.itementry;
  }

  if(getdvarint(#"hash_4cd4e3d15cf4ee7e", 1)) {
    item = _cycle_item(#"equipment", array(#"frag_grenade_wz_item", #"cluster_semtex_wz_item", #"acid_bomb_wz_item", #"molotov_wz_item", #"wraithfire_wz_item", #"hatchet_wz_item", #"tomahawk_t8_wz_item", #"seeker_mine_wz_item", #"dart_wz_item", #"hawk_wz_item", #"ultimate_turret_wz_item", #"swat_grenade_wz_item", #"concussion_wz_item", #"smoke_grenade_wz_item", #"smoke_grenade_wz_item_spring_holiday", #"emp_grenade_wz_item", #"spectre_grenade_wz_item", #"grapple_wz_item", #"unlimited_grapple_wz_item", #"barricade_wz_item", #"spiked_barrier_wz_item", #"trophy_system_wz_item", #"concertina_wire_wz_item", #"sensor_dart_wz_item", #"supply_pod_wz_item", #"trip_wire_wz_item", #"cymbal_monkey_wz_item", #"homunculus_wz_item", #"vision_pulse_wz_item", #"flare_gun_wz_item", #"flare_gun_veh_wz_item", #"wz_snowball", #"wz_waterballoon"), var_bcc2655a);
  } else {
    item = function_9da31874(#"equipment");
  }

  if(isDefined(item)) {
    equip_equipment(item);
    return;
  }

  self playsoundtoplayer(#"uin_unavailable_charging", self);
}

cycle_health_item() {
  assert(isplayer(self));
  var_bcc2655a = undefined;
  healthitem = self.inventory.items[10];

  if(healthitem.networkid !== 32767) {
    var_bcc2655a = healthitem.itementry;
  }

  if(getdvarint(#"hash_4cd4e3d15cf4ee7e", 1)) {
    item = _cycle_item(#"health", array(#"health_item_small", #"health_item_medium", #"health_item_large", #"health_item_squad"), var_bcc2655a);
  } else {
    item = function_9da31874(#"health");
  }

  if(isDefined(item)) {
    equip_health(item);
    return;
  }

  self playsoundtoplayer(#"uin_unavailable_charging", self);
}

function_9ba10b94(networkid) {
  assert(isplayer(self));
  self endon(#"death");
  slotid = function_b246c573(networkid);

  if(!isDefined(slotid)) {
    return;
  }

  attachmentweapons = [];
  attachmentids = [];

  foreach(attachmentoffset in array(1, 2, 3, 4, 5, 6)) {
    var_f9f8c0b5 = item_inventory_util::function_dfaca25e(slotid, attachmentoffset);
    item = self.inventory.items[var_f9f8c0b5];

    if(item.networkid != 32767) {
      attachmentweapons[attachmentweapons.size] = item_world_util::function_f4a8d375(item.id);
      attachmentids[attachmentids.size] = item.id;
      remove_inventory_item(item.networkid, 0, 1);
    }
  }

  drop_inventory_item(self.inventory.items[slotid].networkid);

  for(index = 0; index < attachmentids.size; index++) {
    self thread function_d7944517(attachmentids[index], attachmentweapons[index], 1, 1);
  }
}

function_9d102bbd(var_b72297c2, networkid) {
  assert(isplayer(self));
  self endon(#"death");

  if(!item_world_util::can_pick_up(var_b72297c2)) {
    return false;
  }

  if(!isDefined(var_b72297c2) || !isDefined(var_b72297c2.itementry) || var_b72297c2.itementry.itemtype !== #"weapon") {
    return false;
  }

  weaponitem = get_inventory_item(networkid);

  if(!isDefined(weaponitem)) {
    return false;
  }

  if(!isDefined(weaponitem.itementry) || weaponitem.itementry.itemtype != #"weapon") {
    return false;
  }

  slotid = function_b246c573(networkid);

  if(!isDefined(slotid)) {
    return false;
  }

  weapon = item_inventory_util::function_2b83d3ff(weaponitem);

  if(isDefined(self) && isDefined(weapon) && (self function_c1cef1ec(weapon) || !self function_bf2312f1(weapon))) {
    return false;
  }

  if(isentity(var_b72297c2)) {
    var_b72297c2.hidetime = gettime();
  } else {
    function_54ca5536(var_b72297c2.id, gettime());
  }

  dropweapons = [];
  dropids = [];
  var_cc9e34fb = [];
  var_14174938 = [];

  if(item_inventory_util::function_4bd83c04(var_b72297c2)) {
    foreach(attachmentoffset in array(1, 2, 3, 4, 5, 6)) {
      var_f9f8c0b5 = item_inventory_util::function_dfaca25e(slotid, attachmentoffset);
      item = self.inventory.items[var_f9f8c0b5];

      if(item.networkid != 32767) {
        attachmentname = item_inventory_util::function_2ced1d34(var_b72297c2, item.itementry, 1);
        assert(!isDefined(var_cc9e34fb[attachmentoffset]));

        if(isDefined(attachmentname) && !isDefined(var_cc9e34fb[attachmentoffset])) {
          var_cc9e34fb[attachmentoffset] = item.itementry;
        } else {
          dropweapons[dropweapons.size] = item_world_util::function_f4a8d375(item.id);
          dropids[dropids.size] = item.id;
        }

        var_14174938[var_14174938.size] = item.networkid;
      }
    }
  }

  if(isDefined(var_b72297c2.attachments) || isDefined(var_b72297c2.itementry.attachments)) {
    attachments = isDefined(var_b72297c2.attachments) ? var_b72297c2.attachments : var_b72297c2.itementry.attachments;

    foreach(attachment in attachments) {
      attachmentitem = attachment;

      if(!isDefined(attachmentitem)) {
        continue;
      }

      if(!isDefined(attachmentitem.itementry)) {
        if(!item_world_util::function_7363384a(attachment.attachment_type)) {
          continue;
        }

        attachmentitem = function_4ba8fde(attachment.attachment_type);

        if(!isDefined(attachmentitem)) {
          continue;
        }
      }

      attachmentoffset = item_inventory_util::function_837f4a57(attachmentitem.itementry);

      if(!isDefined(attachmentoffset)) {
        continue;
      }

      if(!isDefined(var_cc9e34fb[attachmentoffset])) {
        var_cc9e34fb[attachmentoffset] = attachmentitem.itementry;
        continue;
      }

      dropweapons[dropweapons.size] = item_world_util::function_f4a8d375(attachmentitem.id);
      dropids[dropids.size] = attachmentitem.id;
    }
  }

  var_b72297c2.attachments = [];

  foreach(var_fe35755b in var_cc9e34fb) {
    if(isDefined(var_fe35755b.name)) {
      attachmentitem = function_4ba8fde(var_fe35755b.name);
      var_e38a0464 = function_520b16d6();
      var_e38a0464.count = 1;
      var_e38a0464.id = attachmentitem.id;
      var_e38a0464.networkid = var_e38a0464.id;
      var_e38a0464.itementry = attachmentitem.itementry;
      var_b72297c2.attachments[var_b72297c2.attachments.size] = var_e38a0464;
    }
  }

  for(index = 0; index < var_14174938.size; index++) {
    var_ddd377f2 = var_14174938[index];
    remove_inventory_item(var_ddd377f2, 0, 1);
  }

  self drop_inventory_item(networkid);

  for(index = 0; index < dropids.size; index++) {
    self thread function_d7944517(dropids[index], dropweapons[index], 1, 1);
  }

  item_world::function_de2018e3(var_b72297c2, self, slotid);
  item_world::consume_item(var_b72297c2);
  return true;
}

function_fba40e6c(item) {
  assert(isplayer(self));
  self endon(#"death");

  if(!item_world_util::can_pick_up(item)) {
    return 0;
  }

  itemslot = self function_e66dcff5(item, 1);
  dropitem = self.inventory.items[itemslot];
  self function_85287396(1);
  droppeditem = self drop_inventory_item(dropitem.networkid);
  slotid = function_e66dcff5(item, 1);

  if(!isDefined(item)) {
    self item_world::function_de2018e3(dropitem, self, itemslot);
    item_world::consume_item(droppeditem);
    inventoryitem = self function_8babc9f9(dropitem.itementry);

    if(isDefined(inventoryitem)) {
      self equip_item(inventoryitem.networkid);
    }

    self function_85287396(0);
    return;
  }

  itementry = item.itementry;
  self item_world::function_de2018e3(item, self, slotid);
  inventoryitem = self function_8babc9f9(itementry);
  item_world::consume_item(item);

  if(isDefined(inventoryitem)) {
    self equip_item(inventoryitem.networkid);
  }

  self function_85287396(0);
}

function_e66dcff5(item, var_662e1704 = 0) {
  assert(isplayer(self));

  if(!isDefined(self.inventory)) {
    return undefined;
  }

  if(!isDefined(item) || !isDefined(item.itementry)) {
    return undefined;
  }

  if(item.itementry.itemtype == #"ammo") {
    return undefined;
  }

  if(item.itementry.itemtype == #"weapon") {
    foreach(slotid in array(16 + 1, 16 + 1 + 6 + 1)) {
      if(self.inventory.items[slotid].networkid === 32767) {
        return slotid;
      }
    }

    weaponitem = function_230ceec4(self.currentweapon);

    if(!isDefined(weaponitem)) {
      return;
    }

    return function_b246c573(weaponitem.networkid);
  }

  if(item.itementry.itemtype == #"backpack") {
    return 13;
  }

  if(item.itementry.itemtype == #"armor") {
    return 11;
  }

  if(item.itementry.itemtype == #"resource") {
    if(item_world_util::function_41f06d9d(item.itementry)) {
      return 14;
    }

    return 15;
  }

  if(item.itementry.itemtype == #"armor_shard") {
    return 16;
  }

  if(item.itementry.itemtype == #"equipment") {
    if(var_662e1704 || self.inventory.items[12].networkid === 32767) {
      return 12;
    }
  }

  if(item.itementry.itemtype == #"health") {
    if(var_662e1704 || self.inventory.items[10].networkid === 32767) {
      return 10;
    }
  }

  if(item.itementry.itemtype == #"attachment") {
    weaponslotid = function_d768ea30();

    if(var_662e1704) {
      weaponslotid = isDefined(weaponslotid) && weaponslotid == 16 + 1 ? 16 + 1 + 6 + 1 : 16 + 1;
    }

    if(isDefined(weaponslotid)) {
      var_f0dc4e93 = item_world_util::function_970b8d86(self, weaponslotid);

      if(self.inventory.items[weaponslotid].networkid != 32767) {
        var_ceefbd10 = item_inventory_util::function_837f4a57(item.itementry);
        var_f9f8c0b5 = item_inventory_util::function_dfaca25e(weaponslotid, var_ceefbd10);
        weaponitem = self get_inventory_item(var_f0dc4e93);
        attachmentname = item_inventory_util::function_2ced1d34(weaponitem, item.itementry, 1);

        if(isDefined(attachmentname)) {
          return var_f9f8c0b5;
        }
      }
    }
  }

  if(isDefined(item.itementry.stackable) && item.itementry.stackable) {
    weapon = item_world_util::function_35e06774(item.itementry);

    if(isDefined(weapon)) {
      maxstack = item_inventory_util::function_cfa794ca(self.inventory.var_7658cbec, item.itementry);

      if(maxstack > 1) {
        foreach(i, spawnitem in self.inventory.items) {
          if(spawnitem.id == 32767) {
            continue;
          }

          inventoryitem = function_b1702735(spawnitem.id);

          if(inventoryitem.itementry.name != item.itementry.name) {
            continue;
          }

          if(self.inventory.items[i].count < maxstack) {
            return i;
          }
        }
      }
    }
  }

  for(index = 0; index < self.inventory.var_c212de25; index++) {
    if(self.inventory.items[index].id == 32767) {
      return index;
    }
  }

  return undefined;
}

drop_armor(stashitem = 0, var_7cab8e12 = undefined, targetname = undefined) {
  assert(isplayer(self));

  if(self has_armor()) {
    item = self.inventory.items[11];
    self thread drop_inventory_item(item.networkid, stashitem, var_7cab8e12, targetname);
    return true;
  }

  return false;
}

function_d86d7ac7(stashitem = 0, var_7cab8e12 = undefined, targetname = undefined) {
  assert(isplayer(self));

  for(index = self.inventory.var_c212de25; index < 10; index++) {
    inventoryitem = self.inventory.items[index];

    if(inventoryitem.networkid != 32767) {
      self thread drop_inventory_item(inventoryitem.networkid, stashitem, var_7cab8e12, targetname);
    }
  }
}

drop_inventory_item(networkid, stashitem = 0, var_7cab8e12 = undefined, targetname = undefined, var_4a6f595d = 1) {
  assert(isplayer(self));
  self endon(#"death");
  dropitem = undefined;
  item = get_inventory_item(networkid);

  if(!isDefined(item)) {
    return dropitem;
  }

  weapon = item_inventory_util::function_2b83d3ff(item);

  if(isDefined(self) && isDefined(weapon) && self.currentweapon == weapon && self isfiring()) {
    waitframe(1);
  }

  if(!isDefined(self) || isDefined(weapon) && self.currentweapon == weapon && self isfiring()) {
    return dropitem;
  }

  if(!isDefined(var_7cab8e12) && getdvarint(#"hash_5f50ef95773c29b5", 0)) {
    for(i = getdvarint(#"hash_5f50ef95773c29b5", 0); i > 0; i--) {
      dropitem = self function_d7944517(item.id, weapon, item.count, item.amount, stashitem, var_7cab8e12, targetname, isDefined(item.attachments) ? item.attachments : array());
    }

    return dropitem;
  }

    function_60706bdb(networkid);
  count = isDefined(item.count) ? item.count : 1;
  amount = isDefined(item.amount) ? item.amount : 0;
  removeonly = isDefined(item.endtime);
  var_337ff88 = self.inventory.items[13].networkid === networkid;

  if(self function_23335063(networkid, 0)) {
    if(var_337ff88 && var_4a6f595d) {
      function_d86d7ac7(stashitem, var_7cab8e12, targetname);
      function_ec238da8();
    }

    if(count > 0) {
      if(isDefined(item.var_42caf41a) && item.var_42caf41a) {
        item.var_42caf41a = 0;
      }

      item_inventory_util::function_6e9e7169(item);

      if(!removeonly) {
        weapon = item_inventory_util::function_2b83d3ff(item);
        dropitem = self function_d7944517(item.id, weapon, count, amount, stashitem, var_7cab8e12, targetname, isDefined(item.attachments) ? item.attachments : array());
      } else {
        consumeditem = function_85645978(item);

        if(isDefined(consumeditem)) {
          var_ee0e9af9 = [];

          for(index = 0; index < 10; index++) {
            inventoryitem = self.inventory.items[index];

            if(!isDefined(inventoryitem.endtime)) {
              continue;
            }

            if(inventoryitem.itementry.name == item.itementry.name) {
              var_ee0e9af9[var_ee0e9af9.size] = inventoryitem;
            }
          }

          remaining = consumeditem.endtime - gettime();
          consumeditem.endtime -= remaining / (var_ee0e9af9.size + 1);

          for(index = 0; index < var_ee0e9af9.size; index++) {
            inventoryitem = var_ee0e9af9[index];
            inventoryitem.starttime = consumeditem.starttime;
            inventoryitem.endtime = consumeditem.endtime;
          }
        }
      }

      if(isDefined(item.attachments)) {
        attachments = arraycopy(item.attachments);

        foreach(attachment in attachments) {
          if(!isDefined(attachment)) {
            continue;
          }

          remove_inventory_item(attachment.networkid);
        }
      }

      if(isDefined(item.var_887db92c)) {
        dropitem.var_887db92c = item.var_887db92c;
      }

      return dropitem;
    }
  }

  return dropitem;
}

equip_ammo(item, var_aec6fa7f) {
  assert(isplayer(self));
  assert(isDefined(item));
  self function_db2abc4(item);
  itementry = item.itementry;
  ammoweapon = itementry.weapon;
  ammoamount = isDefined(itementry.amount) ? itementry.amount : isDefined(var_aec6fa7f) ? var_aec6fa7f : 1;
  maxstockammo = item_inventory_util::function_2879cbe0(self.inventory.var_7658cbec, ammoweapon);
  currentammostock = self getweaponammostock(ammoweapon);
  var_9b9ba643 = maxstockammo - currentammostock;
  addammo = int(min(ammoamount, var_9b9ba643));

  if(isDefined(ammoweapon) && ammoweapon != level.weaponnone) {
    self.inventory.ammo[ammoweapon.name] = item.id;
    self function_fc9f8b05(ammoweapon, addammo);

    if(isDefined(var_aec6fa7f)) {
      return (ammoamount - addammo);
    }

    return 0;
  }

  assertmsg("<dev string:x38>" + itementry.name + "<dev string:x55>");
  return ammoamount - addammo;
}

function_4cde30fa(inventoryitem, itementry) {
  if(game.state == "pregame" || !isplayer(self) || isDefined(self.var_3f1410dd) || !isDefined(inventoryitem) || !isDefined(itementry)) {
    return;
  }

  self.var_3f1410dd = {
    #player_xuid: int(self getxuid(1)), 
    #start_time: function_f8d53445(), 
    #end_time: 0, 
    #var_4550558c: isDefined(inventoryitem.amount) ? inventoryitem.amount : 0, 
    #tier: isDefined(itementry.armortier) ? itementry.armortier : 1, 
    #damage_taken: 0, 
    #var_7352c057: 0, 
    #repair_amount: 0, 
    #broken: 0, 
    #died: 0
  };
}

function_bef83dc6() {
  if(game.state == "pregame" || !isplayer(self) || !isDefined(self.var_3f1410dd)) {
    return;
  }

  self.var_3f1410dd.broken = isDefined(self.armor) && self.armor <= 0;
  self.var_3f1410dd.died = isDefined(self.health) && self.health <= 0;
  self.var_3f1410dd.end_time = function_f8d53445();
  function_92d1707f(#"hash_3d5d9b3e2bc86b28", self.var_3f1410dd);
  self.var_3f1410dd = undefined;
}

equip_armor(item) {
  itementry = item.itementry;
  inventoryitem = get_inventory_item(item.networkid);

  if(!isDefined(inventoryitem)) {
    return;
  }

  self function_db2abc4(item);
  self armor::set_armor(inventoryitem.amount, isDefined(itementry.amount) ? itementry.amount : 0, isDefined(itementry.armortier) ? itementry.armortier : 1, isDefined(itementry.var_99c0cb08) ? itementry.var_99c0cb08 : 1, isDefined(itementry.var_2ee21ae6) ? itementry.var_2ee21ae6 : 1, isDefined(itementry.var_c690c73d) ? itementry.var_c690c73d : 1, isDefined(itementry.var_99edb6a3) ? itementry.var_99edb6a3 : 1, isDefined(itementry.var_22c3ab38) ? itementry.var_22c3ab38 : 1, isDefined(itementry.var_9f307988) ? itementry.var_9f307988 : 1, isDefined(itementry.var_7a80f06e) ? itementry.var_7a80f06e : 1, isDefined(itementry.explosivedamagescale) ? itementry.explosivedamagescale : 1, isDefined(itementry.var_f2902d7b) ? itementry.var_f2902d7b : 1, itementry.var_19f48bbe);
  self function_4cde30fa(inventoryitem, itementry);
  self.inventory.items[11] = inventoryitem;
  self function_b00db06(6, item.networkid);
  self clientfield::set_player_uimodel("hudItems.armorType", isDefined(itementry.armortier) ? itementry.armortier : 1);
}

function_e258cef5(networkid, itemtype) {
  if(networkid == 32767) {
    return undefined;
  }

  item = get_inventory_item(networkid);

  if(!isDefined(item) || !isDefined(item.itementry) || item.itementry.itemtype != itemtype) {
    return undefined;
  }

  return item;
}

equip_attachment(item, var_610add8d, var_d6f68de7, var_a3a17c55 = 1, switchweapon = 1) {
  assert(isplayer(self));
  assert(isstruct(item));
  var_4e2a1ed8 = function_e258cef5(var_610add8d, #"weapon");

  if(!isDefined(var_4e2a1ed8)) {
    return;
  }

  if(item_inventory_util::function_9e9c82a6(var_4e2a1ed8, item, 0)) {
    function_b3342af3(item, undefined, var_4e2a1ed8);
    offset = item_inventory_util::function_837f4a57(item.itementry);
    var_ac396b2f = get_weapon_slot(var_4e2a1ed8);

    if(!isDefined(var_ac396b2f)) {
      return;
    }

    var_dd6937a8 = item_inventory_util::function_dfaca25e(var_ac396b2f, offset);
    var_2134bf0d = self.inventory.items[var_dd6937a8];
    itemslotid = function_b246c573(item.networkid);

    if(!isDefined(itemslotid)) {
      return;
    }

    var_97cc940d = 0;

    if(isDefined(var_d6f68de7)) {
      var_3f6f5f3c = function_e258cef5(var_d6f68de7, #"weapon");
      var_2134bf0d = self.inventory.items[var_dd6937a8];

      if(isDefined(var_3f6f5f3c) && isDefined(var_2134bf0d) && isDefined(function_e258cef5(var_2134bf0d.networkid, #"attachment")) && function_f3195b3d(var_2134bf0d.networkid)) {
        var_97cc940d = 1;
      }
    }

    if(!var_97cc940d) {
      function_26c87da8(itemslotid, var_dd6937a8);
    }

    self function_b00db06(6, item.networkid);

    foreach(slot in array("attachSlotOptics", "attachSlotBarrel", "attachSlotRail", "attachSlotMagazine", "attachSlotBody", "attachSlotStock")) {
      if(isDefined(item.itementry.(slot)) && item.itementry.(slot)) {
        function_41a57271(var_4e2a1ed8, slot, undefined, item);
      }
    }

    function_d019bf1d(var_610add8d, undefined, undefined, 0);
    item_inventory_util::function_6e9e7169(var_4e2a1ed8);
    equip_weapon(var_4e2a1ed8, switchweapon, undefined, var_a3a17c55, 0);
    self function_db2abc4(item);

    if(var_97cc940d) {
      equip_attachment(var_2134bf0d, var_d6f68de7, undefined, var_a3a17c55, 1);
    }
  }
}

equip_backpack(item) {
  assert(isplayer(self));
  inventoryitem = get_inventory_item(item.networkid);

  if(!isDefined(inventoryitem)) {
    return;
  }

  slotid = function_b246c573(item.networkid);

  if(!isDefined(slotid)) {
    return;
  }

  self function_db2abc4(item);
  function_26c87da8(slotid, 13);
  self.inventory.var_7658cbec = item_inventory_util::function_d8cebda3(item.itementry);

  if(self.inventory.var_7658cbec&1) {
    self.inventory.var_c212de25 = 10;
  }

  self.inventory.items[13] = inventoryitem;
  self function_b00db06(6, item.networkid);
  self clientfield::set_player_uimodel("hudItems.hasBackpack", 1);
}

debug_print(message, weapon) {

  if(getdvarint(#"inventory_debug", 0) > 0) {
    weaponname = "<dev string:x59>";

    if(isDefined(weapon)) {
      weaponname = "<dev string:x5c>" + function_9e72a96(weapon.name);
    }

    self iprintlnbold("<dev string:x69>" + message + weaponname);
    println("<dev string:x69>" + self.playername + "<dev string:x7d>" + message + weaponname);
  }

}

equip_equipment(item) {
  self notify("44650fade24c857e");
  self endon("44650fade24c857e");
  assert(isplayer(self));

  while(isDefined(self) && isDefined(self.var_10abd91d) && self.var_10abd91d) {
    waitframe(1);
  }

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(item) || !isDefined(item.itementry)) {
    return;
  }

  itementry = item.itementry;
  weapon = itementry.weapon;
  debug_print("equip_equipment:", weapon);

  if(isDefined(self) && isDefined(self.inventory) && isDefined(self.inventory.items)) {
    equipmentitem = self.inventory.items[12];
  }

  if(isDefined(equipmentitem) && equipmentitem.id != 32767) {
    equippedweapon = function_b1702735(equipmentitem.id).itementry.weapon;

    if(isDefined(equippedweapon)) {
      slot = self gadgetgetslot(equippedweapon);

      if(slot >= 0 && slot < 3) {
        if(self gadgetisprimed(slot)) {
          debug_print("equip_equipment: fail: GadgetIsPrimed", equippedweapon);
          return;
        }
      }

      if(self function_c1cef1ec(equippedweapon)) {
        debug_print("equip_equipment: fail: offhand equipment in use", equippedweapon);
        return;
      }

      if(isDefined(self.var_6d2ad74f) && self.var_6d2ad74f === equippedweapon) {
        debug_print("equip_equipment: fail: equipment waiting for removal", equippedweapon);
        return;
      }

      if(equipmentitem.networkid != item.networkid) {
        function_d019bf1d(equipmentitem.networkid);
      }
    }
  }

  if(isDefined(weapon) && weapon != level.weaponnone) {
    self function_db2abc4(item);
    slotid = function_b246c573(item.networkid);

    if(isDefined(slotid) && slotid < self.inventory.var_c212de25) {
      function_26c87da8(slotid, 12);
    }

    weaponoptions = undefined;

    if(weapon.name == #"waterballoon") {
      var_f94ce554 = array(111, 112, 113, 114, 115, 116);
      weaponoptions = self calcweaponoptions(var_f94ce554[randomintrange(0, var_f94ce554.size)], 0, 0);
    }

    self replace_weapon(level.nullprimaryoffhand, weapon, undefined, undefined, undefined, weaponoptions);
    self function_b00db06(6, item.networkid);

    for(i = 0; i < self.inventory.items.size; i++) {
      if(self.inventory.items[i].networkid === item.networkid) {
        self function_c6be9f7f(weapon, self.inventory.items[i].count);
        break;
      }
    }

    debug_print("equip_equipment: success", weapon);
    self clientfield::set_player_uimodel("hudItems.equipmentStackCount", function_bba770de(self.inventory.items[12].itementry));
    return;
  }

  assertmsg("<dev string:x82>" + itementry.name + "<dev string:x55>");
}

equip_health(item) {
  self notify("6243ac340a4d2698");
  self endon("6243ac340a4d2698");
  assert(isplayer(self));

  while(isDefined(self) && isDefined(self.var_10abd91d) && self.var_10abd91d) {
    waitframe(1);
  }

  if(!isDefined(item) || !isDefined(self)) {
    return;
  }

  itementry = item.itementry;
  weapon = itementry.weapon;
  debug_print("equip_health:", weapon);

  if(isDefined(self.var_d6cd7d80)) {
    debug_print("equip_health: fail: offhand equipment casting", self.var_d6cd7d80);
    return;
  }

  if(isDefined(self.var_e42fb511)) {
    debug_print("equip_health: fail: offhand equipment primed", self.var_e42fb511);
    return;
  }

  if(isDefined(self.inventory) && isDefined(self.inventory.items[10])) {
    var_b6edb3b2 = self.inventory.items[10].networkid;
  }

  if(isDefined(var_b6edb3b2) && var_b6edb3b2 != 32767) {
    var_2337367a = get_inventory_item(var_b6edb3b2);

    if(isDefined(var_2337367a)) {
      equippedweapon = item_inventory_util::function_2b83d3ff(var_2337367a);

      if(isDefined(equippedweapon)) {
        slot = self gadgetgetslot(equippedweapon);

        if(slot >= 0 && slot < 3) {
          if(self gadgetisprimed(slot)) {
            debug_print("equip_health: fail: GadgetIsPrimed", equippedweapon);
            return;
          }

          if(self gadgetisactive(slot)) {
            debug_print("equip_health: fail: GadgetIsActive", equippedweapon);
            return;
          }
        }

        if(self function_c1cef1ec(equippedweapon)) {
          debug_print("equip_health: fail: offhand equipment in use", equippedweapon);
          return;
        }

        if(isDefined(self.var_6d2ad74f) && self.var_6d2ad74f === equippedweapon) {
          debug_print("equip_health: fail: equipment waiting for removal", equippedweapon);
          return;
        }
      }
    }

    if(var_2337367a.networkid != item.networkid) {
      function_d019bf1d(var_b6edb3b2);
    }
  }

  if(isDefined(weapon) && weapon != level.weaponnone) {
    self function_db2abc4(item);
    slotid = function_b246c573(item.networkid);

    if(isDefined(slotid) && slotid < self.inventory.var_c212de25) {
      function_26c87da8(slotid, 10);
    }

    self replace_weapon(level.var_ef61b4b5, weapon);
    self function_b00db06(6, item.networkid);
    self clientfield::set_player_uimodel("hudItems.healthItemstackCount", function_bba770de(item.itementry));
    slot = self gadgetgetslot(weapon);

    if(slot >= 0 && slot < 3) {
      self function_19ed70ca(slot, 0);
    }

    debug_print("equip_health: success", weapon);
    return;
  }

  assertmsg("<dev string:xab>" + itementry.name + "<dev string:x55>");
}

equip_item(networkid, quickequip = 0, weaponid = 0) {
  assert(isplayer(self));
  item = get_inventory_item(networkid);

  if(isDefined(item) && isDefined(item.itementry)) {
    if(isDefined(item.itementry.consumable) && item.itementry.consumable) {
      return self consume_item(item);
    }

    itemtype = item.itementry.itemtype;

    switch (itemtype) {
      case #"ammo":
        self equip_ammo(item);
        break;
      case #"armor":
        self equip_armor(item);
        break;
      case #"attachment":
        if(weaponid == 0) {
          self equip_attachment(item, function_ec087745(), undefined, !quickequip, 1);
        } else {
          self equip_attachment(item, function_c3fb7a6e(), function_ec087745(), !quickequip, 0);
        }

        break;
      case #"backpack":
        self equip_backpack(item);
        break;
      case #"equipment":
        self equip_equipment(item);
        break;
      case #"generic":
      case #"cash":
        break;
      case #"health":
        self equip_health(item);
        break;
      case #"killstreak":
        self use_killstreak(networkid, item);
        break;
      case #"weapon":
        self equip_weapon(item);
        break;
      default:
        assertmsg("<dev string:xd1>" + (isDefined(item.itementry.itemtype) ? item.itementry.itemtype : "<dev string:xeb>") + "<dev string:xf7>");
        return 0;
    }

    return 1;
  }

  return 0;
}

private can_switch_weapons() {
  if(self function_2cceca7b()) {
    return false;
  }

  return true;
}

private function_bf2312f1(weapon) {
  currentweapon = self getcurrentweapon();

  if(isDefined(currentweapon) && currentweapon != level.weaponnone && currentweapon == weapon) {
    if(self function_55acff10()) {
      return false;
    }

    if(self isfiring()) {
      return false;
    }
  }

  return true;
}

equip_weapon(item, switchweapon = 1, var_9fa01da8 = 0, var_a3a17c55 = 0, initialweaponraise = 0) {
  assert(isplayer(self));
  itementry = item.itementry;
  itemtype = itementry.itemtype;
  assert(itemtype == #"weapon");
  currentweapon = level.weaponbasemeleeheld;
  var_68dc9720 = 16 + 1;
  var_6073ab7b = 0;

  if(function_bad4a3a5() == 2) {
    if(var_9fa01da8) {
      currentweapon = self getstowedweapon();
    } else {
      currentweapon = self.currentweapon;
    }

    foreach(slotid in array(16 + 1, 16 + 1 + 6 + 1)) {
      var_b8c2759f = self.inventory.items[slotid];

      if(var_b8c2759f.networkid === 32767) {
        continue;
      }

      equippedweapon = item_inventory_util::function_2b83d3ff(var_b8c2759f);

      if(currentweapon == equippedweapon) {
        var_68dc9720 = slotid;
        function_60706bdb(var_b8c2759f.networkid);
        function_d019bf1d(var_b8c2759f.networkid);
        break;
      }
    }

    currentweapon = level.weaponbasemeleeheld;
  } else {
    if(function_bad4a3a5() == 0) {
      if(function_8b1a219a() && (self getcurrentweapon() != level.weaponnone || self getcurrentweapon() != currentweapon)) {
        var_6073ab7b = 1;
      } else {
        currentweapon = level.weaponnone;
      }
    }

    var_68dc9720 = undefined;

    foreach(slotid in array(16 + 1, 16 + 1 + 6 + 1)) {
      if(self.inventory.items[slotid].networkid === item.networkid) {
        var_68dc9720 = slotid;
        break;
      }
    }

    if(!isDefined(var_68dc9720)) {
      foreach(slotid in array(16 + 1, 16 + 1 + 6 + 1)) {
        if(self.inventory.items[slotid].networkid === 32767) {
          var_68dc9720 = slotid;
          break;
        }
      }
    }
  }

  weapon = item_inventory_util::function_2b83d3ff(item);

  if(isDefined(weapon) && weapon != level.weaponnone) {
    var_346dc077 = self getweaponammostock(weapon);
    item.var_42caf41a = slotid == 16 + 1 + 6 + 1;
    item_inventory_util::function_6e9e7169(item);
    weapon = item_inventory_util::function_2b83d3ff(item);
    slotid = function_b246c573(item.networkid);

    if(!isDefined(slotid)) {
      return;
    }

    self function_26c87da8(slotid, var_68dc9720);

    if(initialweaponraise && !isDefined(item.weaponoptions) && !isDefined(item.charmindex) && !isDefined(item.deathfxindex)) {
      weaponoptions = undefined;

      if(isDefined(getgametypesetting(#"wzrandomcamo")) ? getgametypesetting(#"wzrandomcamo") : 0) {
        renderoptions = function_ea647602("camo", weapon);

        if(renderoptions.size > 0) {
          var_9412af4a = randomint(renderoptions.size);
          weaponoptions = self calcweaponoptions(renderoptions[var_9412af4a].item_index, 0, 0);
        }
      } else {
        buildkitweapon = activecamo::function_385ef18d(weapon);
        weaponoptions = self getbuildkitweaponoptions(buildkitweapon);
        charmindex = self function_9826b353(buildkitweapon);
        deathfxindex = self function_74829bcf(buildkitweapon);
      }

      if(weaponoptions != self getbuildkitweaponoptions(level.weaponnone)) {
        item.weaponoptions = weaponoptions;
      }

      item.charmindex = charmindex;
      item.deathfxindex = deathfxindex;
    }

    item.weaponoptions = self function_fc04b237(weapon, item.weaponoptions);
    self replace_weapon(currentweapon, weapon, 1, initialweaponraise, var_a3a17c55, item.weaponoptions, item.charmindex, item.deathfxindex);

    if(var_6073ab7b) {
      self replace_weapon(level.weaponnone, level.weaponbasemeleeheld);
    }

    self function_b00db06(6, item.networkid);
    inventoryitem = get_inventory_item(item.networkid);

    if(!isDefined(inventoryitem)) {
      return;
    }

    if(weapon !== currentweapon) {
      var_b917b36f = int(min(var_346dc077, weapon.clipsize));
      self function_fc9f8b05(weapon, var_b917b36f);
    }

    var_954e19c7 = get_weapon_count();

    if(var_a3a17c55) {
      self function_c9a111a(weapon);
    } else {
      self shoulddoinitialweaponraise(weapon, initialweaponraise);
    }

    self setweaponammoclip(weapon, int(inventoryitem.amount));

    if(switchweapon || var_954e19c7 == 1) {
      if(self can_switch_weapons()) {
        self switchtoweapon(weapon, 1);
        self.currentweapon = weapon;
      }
    }

    self function_db2abc4(item);
    return;
  }

  assertmsg("<dev string:x11f>" + itementry.name + "<dev string:x55>");
}

function_ec087745(var_75e3ca7a = 0) {
  assert(isplayer(self));

  if(!isDefined(self) || !isplayer(self)) {
    return 32767;
  }

  weapon = self.currentweapon;

  if(!var_75e3ca7a && self isswitchingweapons() && isDefined(self.next_weapon) && self.next_weapon != level.weaponnone && self.next_weapon != level.weaponbasemeleeheld) {}

  networkid = function_a33744de(weapon);

  if(self isswitchingweapons() && networkid == 32767) {
    networkid = function_a33744de(self.currentweapon);
  }

  return networkid;
}

function_c3fb7a6e() {
  assert(isplayer(self));
  var_53c16cb = self function_ec087745();

  foreach(weaponslot in array(16 + 1, 16 + 1 + 6 + 1)) {
    item = self.inventory.items[weaponslot];

    if(!isDefined(item) || item.networkid === 32767 || var_53c16cb === item.networkid) {
      continue;
    }

    return item.networkid;
  }

  return 32767;
}

function_d768ea30() {
  assert(isplayer(self));
  networkid = self function_ec087745();

  if(networkid === 32767) {
    return;
  }

  return item_world_util::function_808be9a3(self, networkid);
}

function_bad4a3a5() {
  assert(isplayer(self));
  weaponcount = 0;
  weapons = self getweaponslistprimaries();

  foreach(weapon in weapons) {
    if(isDefined(weapon.var_29d24e37) && weapon.var_29d24e37) {
      continue;
    }

    if(weapon != level.weaponnone && weapon != level.weaponbasemeleeheld) {
      weaponcount++;
    }
  }

  return weaponcount;
}

function_777cc133() {
  assert(isplayer(self));

  for(index = 0; index < self.inventory.var_c212de25; index++) {
    if(self.inventory.items[index].networkid == 32767) {
      return index;
    }
  }
}

function_2e711614(slotid) {
  assert(isplayer(self));

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.inventory)) {
    return;
  }

  if(!isDefined(self.inventory.items)) {
    return;
  }

  return self.inventory.items[slotid];
}

function_230ceec4(weapon) {
  assert(isplayer(self));
  assert(isweapon(weapon));

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.inventory)) {
    return;
  }

  if(!isDefined(self.inventory.items)) {
    return;
  }

  foreach(weaponslot in array(10, 11, 12, 13, 16 + 1, 16 + 1 + 6 + 1)) {
    item = self.inventory.items[weaponslot];

    if(!isDefined(item)) {
      continue;
    }

    if(item.networkid === 32767) {
      continue;
    }

    if(item_inventory_util::function_2b83d3ff(item) === weapon) {
      return item;
    }
  }
}

function_a33744de(weapon) {
  assert(isplayer(self));
  assert(isweapon(weapon));
  weaponitem = function_230ceec4(weapon);
  return isDefined(weaponitem) ? weaponitem.networkid : 32767;
}

function_b246c573(networkid) {
  assert(isplayer(self));
  assert(item_world_util::function_db35e94f(networkid));

  for(i = 0; i < self.inventory.items.size; i++) {
    if(self.inventory.items[i].networkid === networkid) {
      return i;
    }
  }
}

get_inventory_item(networkid) {
  assert(isint(networkid) && networkid != 32767);

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.inventory)) {
    return;
  }

  if(!isDefined(self.inventory.items)) {
    return;
  }

  for(i = 0; i < self.inventory.items.size; i++) {
    if(self.inventory.items[i].networkid === networkid) {
      return self.inventory.items[i];
    }
  }
}

function_8babc9f9(itementry) {
  assert(isplayer(self));
  name = isDefined(itementry.parentname) ? itementry.parentname : itementry.name;

  if(!isDefined(self) || !isDefined(self.inventory) || !isDefined(self.inventory.items)) {
    return undefined;
  }

  for(index = 0; index < self.inventory.items.size && index < 16 + 1; index++) {
    inventoryitem = self.inventory.items[index];

    if(!isDefined(inventoryitem.itementry)) {
      continue;
    }

    if(name == (isDefined(inventoryitem.itementry.parentname) ? inventoryitem.itementry.parentname : inventoryitem.itementry.name)) {
      return inventoryitem;
    }
  }
}

function_c48cd17f(networkid) {
  assert(isplayer(self));
  assert(item_world_util::function_d9648161(networkid));
  item = get_inventory_item(networkid);

  if(isDefined(item)) {
    return item.id;
  }

  return 32767;
}

function_189a93f8(weapon) {
  assert(isplayer(self));
  assert(isweapon(weapon));
  item = function_230ceec4(weapon);

  if(isDefined(item)) {
    return item.id;
  }

  return 32767;
}

get_weapon_count() {
  assert(isplayer(self));

  if(!isDefined(self.inventory)) {
    return 0;
  }

  weaponcount = 0;

  foreach(slotid in array(16 + 1, 16 + 1 + 6 + 1)) {
    if(self.inventory.items[slotid].networkid != 32767) {
      weaponcount++;
    }
  }

  return weaponcount;
}

get_weapon_slot(item) {
  if(item.networkid === 32767) {
    return;
  }

  foreach(slotid in array(16 + 1, 16 + 1 + 6 + 1)) {
    if(self.inventory.items[slotid].networkid == item.networkid) {
      return slotid;
    }
  }
}

function_3f7ef88() {
  assert(isplayer(self));

  if(!isplayer(self) || !isalive(self)) {
    return;
  }

  if(item_world::function_1b11e73c()) {
    while(isDefined(self) && !isDefined(self.inventory)) {
      waitframe(1);
    }

    if(!isDefined(self)) {
      return;
    }

    pistol = function_4ba8fde(#"pistol_standard_t8_item");
    var_fa3df96 = self function_e66dcff5(pistol);
    pistol.attachments = [];
    attachment = function_4ba8fde(#"fastmag_wz_item");
    var_e38a0464 = function_520b16d6();
    var_e38a0464.count = 1;
    var_e38a0464.id = attachment.id;
    var_e38a0464.networkid = var_e38a0464.id;
    var_e38a0464.itementry = attachment.itementry;
    item_inventory_util::function_9e9c82a6(pistol, attachment);
    attachment = function_4ba8fde(#"reflex_wz_item");
    var_e38a0464 = function_520b16d6();
    var_e38a0464.count = 1;
    var_e38a0464.id = attachment.id;
    var_e38a0464.networkid = var_e38a0464.id;
    var_e38a0464.itementry = attachment.itementry;
    item_inventory_util::function_9e9c82a6(pistol, attachment);
    pistol.amount = self getweaponammoclipsize(item_inventory_util::function_2b83d3ff(pistol));
    self item_world::function_de2018e3(pistol, self, var_fa3df96);
    ammo = function_4ba8fde(#"ammo_type_45_item");
    var_fa3df96 = self function_e66dcff5(ammo);
    self item_world::function_de2018e3(ammo, self, var_fa3df96);
    health = function_4ba8fde(#"health_item_small");
    health.count = 5;
    var_fa3df96 = self function_e66dcff5(health);
    self item_world::function_de2018e3(health, self, var_fa3df96);
    self.var_554ec2e2 = undefined;
  }
}

give_inventory_item(item, itemcount = 1, var_aec6fa7f = 0, slotid = undefined) {
  if(!isplayer(self) || !isDefined(self.inventory)) {
    assert(0, "<dev string:x13f>");
    return 0;
  }

  if(!isDefined(item)) {
    assert(0, "<dev string:x178>");
    return 0;
  }

  if(isDefined(item.itementry) && isDefined(item.var_887db92c)) {
    item.itementry.var_887db92c = item.var_887db92c;
  }

  itementry = item.itementry;
  itemid = item.id;

  if(isDefined(item.itementry.actionregisterweapon)) {
    actionregisterweapon = getscriptbundle(item.itementry.actionregisterweapon);

    if(isDefined(actionregisterweapon)) {
      itementry = actionregisterweapon;
    }

    var_8c36ae16 = function_4ba8fde(item.itementry.actionregisterweapon);

    if(isDefined(var_8c36ae16)) {
      itemid = var_8c36ae16.id;
    }
  }

  maxstacksize = item_inventory_util::function_cfa794ca(self.inventory.var_7658cbec, item.itementry);
  var_1393d318 = maxstacksize > 1;

  if(item.itementry.itemtype == #"resource" && item_world_util::function_41f06d9d(item.itementry)) {
    var_92d652f2 = self.inventory.items[slotid];
    var_b41045b2 = int(max(150 - self stats::get_stat_global(#"items_paint_cans_collected"), 0));
    maxstacksize = var_b41045b2 + (isDefined(var_92d652f2.count) ? var_92d652f2.count : 0);
  }

  if(isDefined(itementry.name) && var_1393d318) {
    for(i = 0; i < self.inventory.items.size; i++) {
      if(self.inventory.items[i].id != 32767) {
        if(self.inventory.items[i].itementry.name != itementry.name) {
          continue;
        }

        var_35f34839 = maxstacksize - self.inventory.items[i].count;

        if(var_35f34839 <= 0) {
          continue;
        }

        var_8c6165fc = int(min(itemcount, var_35f34839));
        self.inventory.items[i].count += var_8c6165fc;
        item.networkid = self.inventory.items[i].networkid;
        self function_b00db06(9, self.inventory.items[i].networkid, self.inventory.items[i].count);

        if(i == 10) {
          self clientfield::set_player_uimodel("hudItems.healthItemstackCount", function_bba770de(self.inventory.items[i].itementry));
        } else if(i == 12) {
          self clientfield::set_player_uimodel("hudItems.equipmentStackCount", function_bba770de(self.inventory.items[i].itementry));
        }

        inventoryweapon = item_inventory_util::function_2b83d3ff(self.inventory.items[i]);

        if(isDefined(inventoryweapon)) {
          self function_c6be9f7f(inventoryweapon, self.inventory.items[i].count);
        }

        itemcount -= var_8c6165fc;
        assert(itemcount >= 0);

        if(itemcount <= 0) {
          self function_b00db06(4, itemid, 0);
          self function_6c36ab6b();
          self function_a4413333();
          return 0;
        }
      }
    }
  }

  if(isDefined(slotid)) {
    var_92d652f2 = undefined;

    if(slotid < self.inventory.items.size) {
      var_92d652f2 = self.inventory.items[slotid];
    }

    assert(isDefined(var_92d652f2));

    if(var_92d652f2.networkid == 32767) {
      var_8c6165fc = int(min(itemcount, maxstacksize));
      item.networkid = item_world_util::function_970b8d86(self, slotid);
      item_inventory_util::function_6e9e7169(item);
      var_92d652f2.amount = var_aec6fa7f;
      var_92d652f2.count = var_8c6165fc;
      var_92d652f2.id = itemid;
      var_92d652f2.networkid = item.networkid;
      var_92d652f2.itementry = itementry;
      var_92d652f2.starttime = undefined;
      var_92d652f2.endtime = undefined;
      var_92d652f2.weaponoptions = undefined;
      var_92d652f2.charmindex = undefined;
      var_92d652f2.deathfxindex = undefined;
      self function_b00db06(4, item.id, var_8c6165fc, slotid + 1);
      itemcount -= var_8c6165fc;
      assert(itemcount >= 0);

      if(itemcount <= 0) {
        if(isDefined(item.attachments)) {
          foreach(attachmentitem in item.attachments) {
            if(!isDefined(attachmentitem)) {
              continue;
            }

            var_769a94ae = item_inventory_util::function_837f4a57(attachmentitem.itementry);

            if(!isDefined(var_769a94ae)) {
              continue;
            }

            var_f9f8c0b5 = item_inventory_util::function_dfaca25e(slotid, var_769a94ae);
            give_inventory_item(attachmentitem, undefined, undefined, var_f9f8c0b5);
            attachmentitem = get_inventory_item(attachmentitem.networkid);
            item_inventory_util::function_9e9c82a6(var_92d652f2, attachmentitem, 0);
          }

          item_inventory_util::function_6e9e7169(var_92d652f2);
        } else if(isDefined(itementry.attachments)) {
          if(item_inventory_util::function_4bd83c04(item)) {
            foreach(attachment in itementry.attachments) {
              if(!item_world_util::function_7363384a(attachment.attachment_type)) {
                continue;
              }

              attachmentitem = function_4ba8fde(attachment.attachment_type);

              if(!isDefined(attachmentitem)) {
                continue;
              }

              var_769a94ae = item_inventory_util::function_837f4a57(attachmentitem.itementry);

              if(!isDefined(var_769a94ae)) {
                continue;
              }

              var_f9f8c0b5 = item_inventory_util::function_dfaca25e(slotid, var_769a94ae);
              give_inventory_item(attachmentitem, undefined, undefined, var_f9f8c0b5);
              attachmentitem = get_inventory_item(attachmentitem.networkid);
              item_inventory_util::function_9e9c82a6(var_92d652f2, attachmentitem, 0);
            }

            item_inventory_util::function_6e9e7169(var_92d652f2);
            weapon = item_inventory_util::function_2b83d3ff(var_92d652f2);

            if(isDefined(weapon)) {
              var_92d652f2.amount = self getweaponammoclipsize(item_inventory_util::function_2b83d3ff(var_92d652f2));
            }
          }
        }

        var_92d652f2.weaponoptions = item.weaponoptions;
        var_92d652f2.charmindex = item.charmindex;
        var_92d652f2.deathfxindex = item.deathfxindex;
        self function_6c36ab6b();
        self function_a4413333();
        return 0;
      }
    }

    if((slotid === 14 || slotid === 15 || slotid == 16) && var_92d652f2.networkid != 32767) {
      return itemcount;
    }
  }

  for(i = 0; i < self.inventory.var_c212de25; i++) {
    if(self.inventory.items[i].networkid === 32767) {
      var_8c6165fc = int(min(itemcount, maxstacksize));
      item.networkid = item_world_util::function_970b8d86(self, i);
      self.inventory.items[i].amount = var_aec6fa7f;
      self.inventory.items[i].count = var_8c6165fc;
      self.inventory.items[i].id = itemid;
      self.inventory.items[i].networkid = item.networkid;
      self.inventory.items[i].itementry = itementry;
      self.inventory.items[i].starttime = undefined;
      self.inventory.items[i].endtime = undefined;
      item_inventory_util::function_6e9e7169(self.inventory.items[i]);
      self function_b00db06(4, item.id, var_8c6165fc, i + 1);
      itemcount -= var_8c6165fc;
      assert(itemcount >= 0);

      if(itemcount <= 0) {
        break;
      }
    }
  }

  self function_6c36ab6b();
  self function_a4413333();
  return itemcount;
}

function_461de298() {
  assert(isplayer(self));

  if(!(isDefined(getgametypesetting(#"wzlootlockers")) ? getgametypesetting(#"wzlootlockers") : 0)) {
    return;
  }

  if(!isplayer(self)) {
    return;
  }

  var_73869e24 = function_4ba8fde(#"resource_item_loot_locker_key");
  lootweapons = self item_inventory_util::get_loot_weapons();
  var_51c5992 = min(lootweapons.size, 2);

  if(var_51c5992 > 0) {
    self give_inventory_item(var_73869e24, var_51c5992, 0, 15);
  }
}

has_armor() {
  assert(isplayer(self));

  if(!isDefined(self)) {
    return 0;
  }

  if(!isDefined(self.inventory)) {
    return 0;
  }

  if(!isDefined(self.inventory.items)) {
    return 0;
  }

  if(!isDefined(self.inventory.items[11])) {
    return 0;
  }

  hasarmor = self.inventory.items[11].networkid != 32767 && self.inventory.items[11].itementry.itemtype == #"armor";
  return hasarmor;
}

has_backpack() {
  assert(isplayer(self));
  hasbackpack = isDefined(self.inventory) && isDefined(self.inventory.items) && isDefined(self.inventory.items[13]) && isDefined(self.inventory.items[13].itementry) && self.inventory.items[13].itementry.itemtype == #"backpack";
  return hasbackpack;
}

function_471897e2() {
  assert(isplayer(self));
  var_22939dc4 = isDefined(self.inventory) && isDefined(self.inventory.items) && isDefined(self.inventory.items[15]) && isDefined(self.inventory.items[15].itementry) && self.inventory.items[15].itementry.itemtype == #"resource" && self.inventory.items[15].itementry.name == #"resource_item_loot_locker_key";
  return var_22939dc4;
}

function_7fe4ce88(item_name) {
  assert(isplayer(self));

  if(!isDefined(self.inventory)) {
    return undefined;
  }

  foreach(item in self.inventory.items) {
    if(item.id == 32767) {
      continue;
    }

    var_b74300d3 = item_world_util::get_itemtype(item.itementry);

    if(item_name == var_b74300d3) {
      return item;
    }
  }
}

has_inventory_item(slotid) {
  assert(isplayer(self));
  return isDefined(self.inventory.items[slotid]) && self.inventory.items[slotid].networkid != 32767;
}

init_inventory() {
  assert(isplayer(self));
  self.inventory = spawnStruct();
  self.inventory.items = [];

  for(i = 0; i < 16 + 1 + 6 + 1 + 6 + 1; i++) {
    self.inventory.items[i] = function_520b16d6();
  }

  self.inventory.ammo = [];
  self.inventory.consumed = [];
  self.inventory.var_c212de25 = 5;
  self.inventory.var_7658cbec = 0;
  self.inventory.var_a0290b96 = [];
  self function_85287396(0);
}

function_fe402108() {
  return isDefined(self.var_11921c74) && self.var_11921c74;
}

function_e7af31c6(slotid) {
  assert(isplayer(self));
  assert(slotid >= 0 && slotid < 16 + 1 + 6 + 1 + 6 + 1);
  return self.inventory.items[slotid].networkid != 32767;
}

function_f3195b3d(networkid) {
  assert(isplayer(self));
  assert(isint(networkid) && networkid != 32767);

  foreach(slot in array(10, 11, 12, 13, 16 + 1, 16 + 1 + 6 + 1)) {
    if(self.inventory.items[slot].networkid === networkid) {
      return true;
    }
  }

  foreach(weaponid in array(16 + 1, 16 + 1 + 6 + 1)) {
    foreach(attachmentoffset in array(1, 2, 3, 4, 5, 6)) {
      attachmentid = item_inventory_util::function_dfaca25e(weaponid, attachmentoffset);

      if(self.inventory.items[attachmentid].networkid === networkid) {
        return true;
      }
    }
  }

  return false;
}

function_db2abc4(item) {
  assert(isplayer(self));
  assert(isDefined(item));

  if(isDefined(item) && isDefined(item.itementry)) {
    if(isDefined(item.itementry.consumable) && item.itementry.consumable) {
      if(isDefined(item.itementry.equipsound)) {
        self playsoundtoplayer(item.itementry.equipsound, self);
        return;
      }
    }

    switch (item.itementry.itemtype) {
      case #"weapon":
        break;
      case #"ammo":
        break;
      case #"health":
        break;
      case #"equipment":
        break;
      case #"armor":
        break;
      case #"backpack":
        break;
      case #"attachment":
        if(isDefined(item.itementry.equipsound)) {
          self playsoundtoplayer(item.itementry.equipsound, self);
        }

        break;
      case #"generic":
        break;
    }
  }
}

function_a24d6e36(networkid, notifyclient = 1, var_cda2ff12 = 1) {
  assert(isplayer(self));
  assert(isint(networkid) && networkid != 32767);
  self endon(#"death");
  itemid = function_c48cd17f(networkid);

  if(itemid == 32767) {
    return 0;
  }

  item = get_inventory_item(networkid);
  weapon = item_inventory_util::function_2b83d3ff(item);

  if(isDefined(weapon)) {
    self.var_6d2ad74f = weapon;
    slot = self gadgetgetslot(weapon);

    if(slot >= 0 && slot < 3) {
      self function_19ed70ca(slot, 1);
      self gadgetpowerset(slot, 0);
    }

    while(isDefined(self) && (self function_c1cef1ec(weapon) || !self function_bf2312f1(weapon))) {
      waitframe(1);
    }
  }

  if(item.count > 0 && isDefined(weapon)) {
    self function_19ed70ca(slot, 0);
    self gadgetpowerset(slot, weapon.gadget_powermax);
    return;
  }

  self remove_inventory_item(networkid, 0, notifyclient, var_cda2ff12);
}

private function_eb70ad46(networkid, notifyclient = 1, var_cda2ff12 = 1) {
  item = get_inventory_item(networkid);
  weapon = item_inventory_util::function_2b83d3ff(item);
  itementry = item.itementry;
  self.inventory.items[13] = function_520b16d6();
  self.inventory.var_c212de25 = 5;
  self.inventory.var_7658cbec = 0;

  if(notifyclient) {
    self function_b00db06(5, networkid);
  }

  function_9d805044(itementry.itemtype, itementry);

  if(var_cda2ff12) {
    for(index = self.inventory.var_c212de25; index < 10; index++) {
      inventoryitem = self.inventory.items[index];

      if(inventoryitem.networkid != 32767) {
        remove_inventory_item(inventoryitem.networkid);
      }
    }
  }

  if(isDefined(self.var_6d2ad74f) && self.var_6d2ad74f === weapon) {
    self.var_6d2ad74f = undefined;
  }

  debug_print("remove_inventory_item: Success!", weapon);
  self clientfield::set_player_uimodel("hudItems.hasBackpack", 0);
}

remove_inventory_item(networkid, var_dfe6c7e5 = 0, notifyclient = 1, var_cda2ff12 = 1) {
  assert(isplayer(self));
  assert(isint(networkid) && networkid != 32767);
  itemid = function_c48cd17f(networkid);

  if(itemid == 32767) {
    debug_print("remove_inventory_item: failed! No ItemId");
    return false;
  }

  item = get_inventory_item(networkid);
  weapon = item_inventory_util::function_2b83d3ff(item);
  itementry = item.itementry;

  if(isDefined(self) && isDefined(weapon) && (self function_c1cef1ec(weapon) || !self function_bf2312f1(weapon))) {
    debug_print("remove_inventory_item: failed! Weapon in Use");
    return false;
  }

  if(self.inventory.items[13].networkid === networkid) {
    function_eb70ad46(networkid, notifyclient, var_cda2ff12);
    return true;
  }

  for(i = 0; i < self.inventory.items.size; i++) {
    if(self.inventory.items[i].networkid === networkid) {
      unequipped = self function_d019bf1d(networkid, var_dfe6c7e5, notifyclient, var_cda2ff12);
      self.inventory.items[i] = function_520b16d6();

      if(function_8b1a219a()) {
        if(isDefined(array::find(array(16 + 1, 16 + 1 + 6 + 1), i)) && get_weapon_count() == 0) {
          self sortheldweapons();
        }
      }

      self function_6c36ab6b();
      self function_a4413333();

      if(notifyclient) {
        self function_b00db06(5, networkid);
      }

      if(i == 10) {
        self clientfield::set_player_uimodel("hudItems.healthItemstackCount", 0);
      } else if(i == 12) {
        self clientfield::set_player_uimodel("hudItems.equipmentStackCount", 0);
      }

      if(unequipped) {
        function_9d805044(itementry.itemtype, itementry);
      }

      if(isDefined(self.var_6d2ad74f) && self.var_6d2ad74f === weapon) {
        self.var_6d2ad74f = undefined;
      }

      if(itementry.itemtype == #"cash") {
        self function_3d113bfb();
      }

      debug_print("remove_inventory_item: Success!", weapon);
      return true;
    }

    if(!isDefined(self.inventory)) {
      return false;
    }
  }

  debug_print("remove_inventory_item: Failed!", weapon);
  return false;
}

replace_weapon(old_weapon, new_weapon, primary_weapon = 0, var_e47b0bf = 1, var_6086c488 = 0, options = undefined, charmindex = undefined, deathfxindex) {
  assert(isDefined(old_weapon));
  assert(isDefined(new_weapon));

  if(isDefined(old_weapon) && old_weapon != level.weaponnone) {
    self replaceweapon(old_weapon, 0, new_weapon, options);
    self takeweapon(old_weapon);
  } else {
    self giveweapon(new_weapon, options);
  }

  if(!self hasweapon(new_weapon)) {
    return;
  }

  if(isDefined(charmindex) && charmindex >= 0) {
    self function_3fb8b14(new_weapon, charmindex);
  }

  if(isDefined(deathfxindex) && deathfxindex >= 0) {
    self function_a85d2581(new_weapon, deathfxindex);
  }

  if(var_6086c488) {
    self function_c9a111a(new_weapon);
  } else {
    self shoulddoinitialweaponraise(new_weapon, var_e47b0bf);
  }

  if(primary_weapon && self isinvehicle()) {
    self.currentweapon = new_weapon;
  }
}

function_85287396(enabled) {
  if(isDefined(self)) {
    self.var_11921c74 = enabled;
  }
}

function_fba4a353(item) {
  if(!isplayer(self) || !isDefined(self.inventory)) {
    assert(0, "<dev string:x13f>");
    return false;
  }

  assert(isDefined(item));

  if(1 && isDefined(item) && isDefined(item.itementry)) {
    slotid = undefined;

    switch (item.itementry.itemtype) {
      case #"armor":
        slotid = 11;
        break;
      case #"backpack":
        slotid = 13;
        break;
      case #"equipment":
        slotid = 12;
        break;
      case #"health":
        slotid = 10;
        break;
      case #"weapon":
        slotid = array(16 + 1, 16 + 1 + 6 + 1);
        break;
    }

    if(isarray(slotid)) {
      emptyslot = 0;

      foreach(id in slotid) {
        if(self.inventory.items[id].networkid === 32767 || self.inventory.items[id].networkid === item.networkid) {
          emptyslot = 1;
          break;
        }
      }

      if(!emptyslot) {
        return false;
      }
    } else if(self.inventory.items[slotid].networkid !== 32767 && self.inventory.items[slotid].networkid !== item.networkid) {
      return false;
    }

    return true;
  }

  return false;
}

function_ecd1c667(itemid, count) {
  assert(isplayer(self));
  assert(item_world_util::function_2c7fc531(itemid));
  self endon(#"death");
  item = function_b1702735(itemid);
  assert(item.itementry.itemtype == #"ammo");
  weapon = item.itementry.weapon;
  maxammo = self getweaponammostock(weapon);
  count = int(min(isDefined(count) ? count : maxammo, maxammo));

  if(count <= 0) {
    return;
  }

  self function_fc9f8b05(weapon, count * -1);
  self function_d7944517(item.id, item.itementry.weapon, 1, count);
}

function_cfe0e919(networkid, count) {
  assert(isplayer(self));
  assert(isint(count) && count > 0);
  self endon(#"death");
  item = get_inventory_item(networkid);

  if(!isDefined(item) || !isDefined(item.itementry)) {
    return;
  }

  if(self.inventory.items[12].networkid == networkid && isDefined(self.var_8181d952) && self.var_8181d952 == item.itementry.weapon) {
    if(item.count == count) {
      count--;
    }
  }

  count = int(min(item.count, count));

  if(count <= 0) {
    return;
  }

  weapon = item.itementry.weapon;
  self function_d7944517(item.id, item.itementry.weapon, count, 0);
  self use_inventory_item(networkid, count);
}

function_23335063(networkid, var_cda2ff12 = 1) {
  if(!self remove_inventory_item(networkid, undefined, undefined, var_cda2ff12)) {
    return false;
  }

  return true;
}

function_c4468806(player, item) {
  if(game.state == "pregame" || !isDefined(item)) {
    return;
  }

  data = {
    #game_time: function_f8d53445(), 
    #player_xuid: int(player getxuid(1)), 
    #item: hash(item.itementry.name)
  };
  println("<dev string:x1ac>" + item.itementry.name);
  function_92d1707f(#"hash_50be59ef12074ce", data);
}

function_394d85cd() {
  assert(isplayer(self));
  var_13339abf = array(#"ammo_type_9mm_item", #"ammo_type_45_item", #"ammo_type_556_item", #"ammo_type_762_item", #"ammo_type_338_item", #"ammo_type_50cal_item", #"ammo_type_12ga_item", #"ammo_type_rocket_item");
  var_c2043143 = array(2, 4, 8, 16, 32, 64, 128, 256);

  for(index = 0; index < var_13339abf.size; index++) {
    if(self.inventory.var_7658cbec&var_c2043143[index]) {
      continue;
    }

    ammoitem = var_13339abf[index];
    var_f415ce36 = getscriptbundle(ammoitem);
    weapon = var_f415ce36.weapon;
    assert(isDefined(weapon));

    if(!isDefined(weapon)) {
      continue;
    }

    maxammo = item_inventory_util::function_2879cbe0(self.inventory.var_7658cbec, weapon);
    var_346dc077 = self getweaponammostock(weapon);

    if(var_346dc077 > maxammo) {
      var_f580278d = function_4ba8fde(ammoitem).id;
      function_ecd1c667(var_f580278d, var_346dc077 - maxammo);
    }
  }
}

function_a2c7ce35() {
  assert(isplayer(self));
  var_3e9ef0a1 = array(array(#"frag_grenade_wz_item", #"cluster_semtex_wz_item", #"acid_bomb_wz_item", #"molotov_wz_item", #"wraithfire_wz_item", #"hatchet_wz_item", #"tomahawk_t8_wz_item", #"seeker_mine_wz_item", #"dart_wz_item", #"hawk_wz_item", #"ultimate_turret_wz_item"), array(#"swat_grenade_wz_item", #"concussion_wz_item", #"smoke_grenade_wz_item", #"smoke_grenade_wz_item_spring_holiday", #"emp_grenade_wz_item", #"spectre_grenade_wz_item"), array(#"grapple_wz_item", #"unlimited_grapple_wz_item", #"barricade_wz_item", #"spiked_barrier_wz_item", #"trophy_system_wz_item", #"concertina_wire_wz_item", #"sensor_dart_wz_item", #"supply_pod_wz_item", #"trip_wire_wz_item", #"cymbal_monkey_wz_item", #"homunculus_wz_item", #"vision_pulse_wz_item", #"flare_gun_wz_item", #"flare_gun_veh_wz_item", #"wz_snowball", #"wz_waterballoon"));
  var_c77511ea = array(8192, 16384, 32768);
  var_710be50e = array(12);

  for(itemindex = 0; itemindex < 10; itemindex++) {
    var_710be50e[var_710be50e.size] = itemindex;
  }

  for(equipmenttype = 0; equipmenttype < var_3e9ef0a1.size; equipmenttype++) {
    if(self.inventory.var_7658cbec&var_c77511ea[equipmenttype]) {
      continue;
    }

    equipmentitems = var_3e9ef0a1[equipmenttype];

    for(index = 0; index < equipmentitems.size; index++) {
      equipmentitem = equipmentitems[index];
      itemspawnpoint = function_4ba8fde(equipmentitem);

      if(!isDefined(itemspawnpoint)) {
        continue;
      }

      maxstack = item_inventory_util::function_cfa794ca(self.inventory.var_7658cbec, itemspawnpoint.itementry);

      for(itemindex = 0; itemindex < var_710be50e.size; itemindex++) {
        item = self.inventory.items[var_710be50e[itemindex]];

        if(item.networkid == 32767) {
          continue;
        }

        if(item.itementry.name != equipmentitem) {
          continue;
        }

        if(item.count <= maxstack) {
          continue;
        }

        var_9311e423 = item.count - maxstack;
        self use_inventory_item(item.networkid, var_9311e423);
        newitem = spawnStruct();
        newitem.id = item.id;
        newitem.itementry = item.itementry;
        remainingitems = give_inventory_item(newitem, var_9311e423);

        if(remainingitems > 0) {
          self function_d7944517(newitem.id, newitem.itementry.weapon, remainingitems, 0);
        }
      }
    }
  }
}

function_2bb3a825() {
  assert(isplayer(self));
  var_9b624be0 = array(#"health_item_small", #"health_item_medium", #"health_item_large", #"health_item_squad");
  var_448bc079 = array(512, 1024, 2048, 4096);
  var_5675add1 = array(10);

  for(itemindex = 0; itemindex < 10; itemindex++) {
    var_5675add1[var_5675add1.size] = itemindex;
  }

  for(index = var_9b624be0.size - 1; index >= 0; index--) {
    if(self.inventory.var_7658cbec&var_448bc079[index]) {
      continue;
    }

    healthitem = var_9b624be0[index];
    itemspawnpoint = function_4ba8fde(healthitem);

    if(!isDefined(itemspawnpoint)) {
      continue;
    }

    maxstack = item_inventory_util::function_cfa794ca(self.inventory.var_7658cbec, itemspawnpoint.itementry);

    for(itemindex = 0; itemindex < var_5675add1.size; itemindex++) {
      item = self.inventory.items[var_5675add1[itemindex]];

      if(item.networkid == 32767) {
        continue;
      }

      if(item.itementry.name != healthitem) {
        continue;
      }

      if(item.count <= maxstack) {
        continue;
      }

      var_9311e423 = item.count - maxstack;
      self use_inventory_item(item.networkid, var_9311e423);
      newitem = spawnStruct();
      newitem.id = item.id;
      newitem.itementry = item.itementry;
      remainingitems = give_inventory_item(newitem, var_9311e423);

      if(remainingitems > 0) {
        self function_d7944517(newitem.id, newitem.itementry.weapon, remainingitems, 0);
      }
    }
  }
}

function_2521e90f() {
  for(index = self.inventory.var_c212de25; index < 10; index++) {
    item = self.inventory.items[index];

    if(item.networkid == 32767) {
      continue;
    }

    newitem = spawnStruct();
    newitem.id = item.id;
    newitem.itementry = item.itementry;
    newitem.count = item.count;
    remove_inventory_item(item.networkid, 0, 1, 1);
    remainingitems = give_inventory_item(newitem, newitem.count);

    if(remainingitems > 0) {
      self function_d7944517(newitem.id, newitem.itementry.weapon, remainingitems, 0);
    }
  }
}

function_ec238da8() {
  function_394d85cd();
  function_a2c7ce35();
  function_2bb3a825();
  function_2521e90f();
}

reset_inventory() {
  self endon(#"death", #"disconnect");
  assert(isplayer(self));
  self.var_7bba6210 = 1;
  self disableoffhandspecial();
  self disableoffhandweapons();
  self.var_6d2ad74f = undefined;

  while(self function_2cceca7b()) {
    waitframe(1);
  }

  if(!isDefined(self) || !isDefined(self.inventory)) {
    return;
  }

  self function_d62822d5();

  foreach(inventoryitem in self.inventory.items) {
    if(inventoryitem.networkid != 32767) {
      remove_inventory_item(inventoryitem.networkid, 0, 0);
    }
  }

  foreach(ammoweapon, itemid in self.inventory.ammo) {
    weapon = getweapon(ammoweapon);
    self setweaponammostock(weapon, 0);
  }

  if(isDefined(level.givecustomloadout)) {
    self[[level.givecustomloadout]](1);
  }

  self init_inventory();
  self function_6c36ab6b();
  self function_b00db06(10);
  self clientfield::set_player_uimodel("hudItems.armorType", 0);
  self clientfield::set_player_uimodel("hudItems.hasBackpack", 0);
  self clientfield::set_player_uimodel("hudItems.healthItemstackCount", 0);
  self clientfield::set_player_uimodel("hudItems.equipmentStackCount", 0);
  self.var_7bba6210 = undefined;
  self enableoffhandspecial();
  self enableoffhandweapons();
  self callback::callback(#"inventory_reset");
}

function_26c87da8(var_c9293a27, var_8f194e5a) {
  assert(isplayer(self));
  assert(isDefined(var_c9293a27) && isDefined(var_8f194e5a));

  if(!isDefined(var_c9293a27) || !isDefined(var_8f194e5a)) {
    return;
  }

  if(var_c9293a27 == var_8f194e5a) {
    return;
  }

  fromitem = self.inventory.items[var_c9293a27];
  toitem = self.inventory.items[var_8f194e5a];
  self.inventory.items[var_c9293a27] = toitem;
  self.inventory.items[var_8f194e5a] = fromitem;

  if(isDefined(fromitem.itementry)) {
    fromitem.networkid = item_world_util::function_970b8d86(self, var_8f194e5a);
  }

  if(isDefined(toitem.itementry)) {
    toitem.networkid = item_world_util::function_970b8d86(self, var_c9293a27);
  }

  if(var_8f194e5a == 10) {
    self clientfield::set_player_uimodel("hudItems.healthItemstackCount", function_bba770de(toitem.itementry));
  } else if(var_8f194e5a == 12) {
    self clientfield::set_player_uimodel("hudItems.equipmentStackCount", function_bba770de(toitem.itementry));
  }

  self function_b00db06(12, var_c9293a27, var_8f194e5a);
}

function_b3342af3(item, notifyclient = 1, ignoreweapon = undefined) {
  assert(isplayer(self));
  assert(isstruct(item));

  foreach(slotid in array(16 + 1, 16 + 1 + 6 + 1)) {
    var_f0dc4e93 = self.inventory.items[slotid].networkid;

    if(var_f0dc4e93 == 32767) {
      continue;
    }

    if(isDefined(ignoreweapon) && ignoreweapon.networkid === var_f0dc4e93) {
      continue;
    }

    weaponitem = get_inventory_item(var_f0dc4e93);

    if(!isDefined(weaponitem) || !isDefined(weaponitem.itementry) || weaponitem.itementry.itemtype != #"weapon") {
      assert(0);
      continue;
    }

    currentammo = self getweaponammoclip(item_inventory_util::function_2b83d3ff(weaponitem));

    if(item_inventory_util::function_31a0b1ef(weaponitem, item, 0)) {
      itemtype = item.itementry.itemtype;
      networkid = item.networkid;

      if(notifyclient) {
        self function_b00db06(7, networkid);
      }

      weapon = item_inventory_util::function_2b83d3ff(weaponitem);
      iscurrentweapon = weapon == self.currentweapon;
      function_d019bf1d(var_f0dc4e93, undefined, notifyclient, 0);
      item_inventory_util::function_6e9e7169(weaponitem);
      equip_weapon(weaponitem, iscurrentweapon, undefined, 1, 0);
      newammo = self getweaponammoclipsize(item_inventory_util::function_2b83d3ff(weaponitem));
      var_b917b36f = currentammo - newammo;

      if(var_b917b36f > 0) {
        self function_fc9f8b05(weapon, var_b917b36f);
      }

      return true;
    }
  }

  return false;
}

function_41a57271(item, slot, notifyclient = 1, ignoreattachment = undefined) {
  assert(isplayer(self));
  assert(isstruct(item));

  if(!isDefined(item.attachments)) {
    return 0;
  }

  attachments = arraycopy(item.attachments);

  foreach(attachment in attachments) {
    if(!isDefined(attachment) || !isDefined(attachment.itementry)) {
      continue;
    }

    if(isDefined(ignoreattachment) && ignoreattachment.networkid == attachment.networkid) {
      continue;
    }

    if(isDefined(attachment.itementry.(slot)) && attachment.itementry.(slot)) {
      function_b3342af3(get_inventory_item(attachment.networkid), notifyclient);
    }
  }
}

function_d019bf1d(networkid, var_dfe6c7e5 = 0, notifyclient = 1, var_8eb4edca = 1) {
  assert(isplayer(self));
  assert(isint(networkid) && networkid != 32767);

  if(!function_f3195b3d(networkid)) {
    return 0;
  }

  item = get_inventory_item(networkid);

  if(!isDefined(item)) {
    return 0;
  }

  itementry = item.itementry;
  itemtype = itementry.itemtype;

  if(itemtype == #"weapon") {
    return function_3f5b2e2e(item, notifyclient, var_8eb4edca);
  }

  if(itemtype == #"attachment") {
    return function_b3342af3(item, notifyclient);
  } else {
    if(itemtype == #"armor") {
      self function_bef83dc6();
      self armor::set_armor(0, 0, 0, 1, 0);
      self clientfield::set_player_uimodel("hudItems.armorType", 0);
    } else if(itemtype == #"equipment") {
      self thread function_ee9ce1c4(itementry, var_dfe6c7e5);
    } else if(itemtype == #"health") {
      self thread function_8214f1b6(itementry, var_dfe6c7e5);
    }

    if(notifyclient) {
      self function_b00db06(7, networkid);
    }

    return 1;
  }

  return 0;
}

function_3f5b2e2e(item, notifyclient = 1, var_8eb4edca = 1) {
  assert(isplayer(self));
  assert(isstruct(item));
  itemtype = item.itementry.itemtype;
  networkid = item.networkid;
  function_60706bdb(networkid);

  if(isDefined(item.attachments) && var_8eb4edca) {
    attachmentitems = [];

    foreach(attachment in item.attachments) {
      if(!isDefined(attachment)) {
        continue;
      }

      attachmentitem = get_inventory_item(attachment.networkid);
      attachmentitems[attachmentitems.size] = attachmentitem;
    }

    foreach(attachmentitem in attachmentitems) {
      function_b3342af3(attachmentitem, 1);
    }
  }

  weapon = item_inventory_util::function_2b83d3ff(item);
  item.weaponoptions = self function_fc04b237(weapon, item.weaponoptions);

  if(get_weapon_count() > 1) {
    self replace_weapon(weapon, level.weaponbasemeleeheld, 1);

    foreach(slotid in array(16 + 1, 16 + 1 + 6 + 1)) {
      if(self.inventory.items[slotid].networkid != 32767 && self.inventory.items[slotid].networkid != item.networkid) {
        altweapon = item_inventory_util::function_2b83d3ff(self.inventory.items[slotid]);
        currentweapon = self getcurrentweapon();

        if(altweapon != currentweapon) {
          self switchtoweapon(altweapon, 1);
        }

        self.currentweapon = altweapon;
        break;
      }
    }
  } else {
    self replace_weapon(weapon, level.weaponbasemeleeheld, 1);

    if(weapon == self.currentweapon) {
      currentweapon = self getcurrentweapon();

      if(level.weaponbasemeleeheld != currentweapon) {
        self switchtoweapon(level.weaponbasemeleeheld, 1);
      }

      self.currentweapon = level.weaponbasemeleeheld;
    }
  }

  self clearstowedweapon();

  if(notifyclient) {
    self function_b00db06(7, networkid);
  }

  return true;
}

use_inventory_item(networkid, usecount = 1, var_dfe6c7e5 = 1) {
  self endon(#"death");
  assert(isplayer(self));
  assert(isint(networkid) && networkid != 32767);

  for(i = 0; i < self.inventory.items.size; i++) {
    if(self.inventory.items[i].networkid === networkid) {
      if(isDefined(self.inventory.items[i].itementry.unlimited) && self.inventory.items[i].itementry.unlimited) {
        break;
      }

      self.inventory.items[i].count -= usecount;

      if(self.inventory.items[i].count < 0) {
        self.inventory.items[i].count = 0;
        break;
      }

      var_641929a7 = {
        #item: self.inventory.items[i]
      };
      self callback::callback(#"on_item_use", var_641929a7);
      self function_b00db06(9, networkid, self.inventory.items[i].count);
      function_a4413333();
      function_c4468806(self, self.inventory.items[i]);

      if(self.inventory.items[i].count <= 0) {
        self thread function_a24d6e36(networkid, 1);
      }

      break;
    }
  }
}

function_956a8ecd() {
  assert(isentity(self));

  if(!isentity(self)) {
    return;
  }

  self waittill(#"hash_363004a4e0ccc1f", #"hawk_settled", #"death", #"stationary");
  var_d783088e = [];

  foreach(sensordart in level.sensor_darts) {
    if(!isDefined(sensordart)) {
      continue;
    }

    parentent = sensordart getlinkedent();

    if(isDefined(parentent) && parentent == self) {
      var_d783088e[var_d783088e.size] = sensordart;
    }
  }

  if(!isDefined(self) || self.health <= 0) {
    foreach(sensordart in var_d783088e) {
      sensordart thread sensor_dart::function_4db10465();
    }

    return;
  }

  angles = self.angles;
  origin = self.origin;
  dropitem = item_drop::drop_item(undefined, 1, 0, self.id, origin, angles);

  if(isDefined(dropitem) && item_world_util::function_74e1e547(origin)) {
    dropitem.var_d783088e = var_d783088e;
  } else {
    foreach(sensordart in var_d783088e) {
      sensordart thread sensor_dart::function_4db10465();
    }
  }

  util::wait_network_frame(1);

  if(isDefined(self)) {
    self delete();
    arrayremovevalue(level.item_vehicles, undefined, 0);
  }
}

private function_d8ceeeec(notifyhash) {
  self val::reset(#"item_killstreak", "freezecontrols_allowlook");
}

use_killstreak(networkid, item) {
  assert(isplayer(self));
  assert(isDefined(item));
  self endoncallback(&function_d8ceeeec, #"death");

  if(self isinvehicle()) {
    return;
  }

  if(self function_2cceca7b()) {
    return;
  }

  if(self inlaststand()) {
    return;
  }

  if(self isonladder()) {
    return;
  }

  vehicletype = item.itementry.vehicle;

  if(item.itementry.weapon.deployable) {
    traceresults = self function_242060b9(item.itementry.weapon);

    if(traceresults.isvalid) {
      if(isDefined(level.var_1f020f16) && isDefined(vehicletype) && isDefined(level.var_1f020f16[vehicletype])) {
        traceresults.isvalid = self[[level.var_1f020f16[vehicletype]]](item.itementry.vehicle, item.itementry.weapon, traceresults);
      }
    }
  } else if(isDefined(level.var_4cf92425[vehicletype])) {
    traceresults = self[[level.var_4cf92425[vehicletype]]](item.itementry.vehicle);
  } else {
    eyeangle = self getplayerangles();
    forward = anglesToForward(eyeangle);
    eyepos = self getplayercamerapos();
    endpos = eyepos + forward * 50;
    var_f45df727 = eyepos + forward * 100;
    traceresults = {};
    traceresults.trace = bulletTrace(eyepos, var_f45df727, 1, self, 1, 1);
    traceresults.isvalid = traceresults.trace[#"fraction"] >= 1;
    traceresults.waterdepth = 0;
    traceresults.origin = endpos;
    traceresults.angles = eyeangle;
  }

  if(traceresults.isvalid) {
    remoteweapon = getweapon(#"warzone_remote");

    if(self hasweapon(remoteweapon)) {
      return;
    }

    if(self isswitchingweapons()) {
      self waittilltimeout(2, #"weapon_change");
    }

    self val::set(#"item_killstreak", "freezecontrols_allowlook", 1);
    self giveweapon(remoteweapon);
    self switchtoweapon(remoteweapon, 1);
    self waittilltimeout(2, #"weapon_change");

    if(self getcurrentweapon() != remoteweapon) {
      self takeweapon(remoteweapon);
      self val::reset(#"item_killstreak", "freezecontrols_allowlook");
      return;
    }

    remove_inventory_item(networkid);
    self closeingamemenu();
    relativeorigin = undefined;
    var_2e2dbfa3 = undefined;

    if(isDefined(traceresults.hitent)) {
      relativeorigin = traceresults.origin - traceresults.hitent.origin;
      var_2e2dbfa3 = traceresults.hitent.angles;
    }

    spawnorigin = traceresults.origin;

    if(isDefined(traceresults.hitent) && isDefined(relativeorigin)) {
      anglesdelta = traceresults.hitent.angles - var_2e2dbfa3;
      spawnorigin = traceresults.hitent.origin + rotatepoint(relativeorigin, anglesdelta);
    }

    vehicle = spawnvehicle(vehicletype, spawnorigin, traceresults.angles);

    if(isDefined(vehicle)) {
      if(isDefined(vehicle.vehicleclass) && vehicle.vehicleclass == #"helicopter") {
        vehicle.origin += (0, 0, vehicle.height);
      }

      level.item_vehicles[level.item_vehicles.size] = vehicle;
    }

    util::wait_network_frame(1);

    if(isDefined(vehicle)) {
      vehicle.id = item.id;

      if(isDefined(vehicle.vehicleclass) && vehicle.vehicleclass != #"helicopter") {
        vehicle thread function_956a8ecd();
      }

      vehicle setteam(self.team);
      vehicle.team = self.team;

      if(!isai(vehicle)) {
        vehicle setowner(self);
      }

      vehicle.owner = self;
      vehicle.ownerentnum = self.entnum;

      if(vehicle isremotecontrol()) {
        self val::reset(#"item_killstreak", "freezecontrols_allowlook");
        vehicle usevehicle(self, 0);
        self waittill(#"exit_vehicle");
      } else if(isDefined(vehicle.var_7feead71)) {
        vehicle[[vehicle.var_7feead71]](self);
      }
    }

    self val::reset(#"item_killstreak", "freezecontrols_allowlook");
    self takeweapon(remoteweapon);
    return;
  }

  self sethintstring(#"hash_37605398dce96965");
  wait 1.5;

  if(isDefined(self)) {
    self sethintstring(#"");
  }
}

function_3d113bfb() {
  if(!isplayer(self)) {
    return;
  }

  if(!isDefined(self.var_a097ccb7)) {
    self.var_a097ccb7 = 0;
  }

  if(!isstruct(self.inventory) || !isarray(self.inventory.items)) {
    return;
  }

  cash = 0;

  foreach(item in self.inventory.items) {
    if(!isDefined(item) || !isstruct(item.itementry) || item.itementry.itemtype !== #"cash") {
      continue;
    }

    cash += isDefined(item.itementry.amount) ? item.itementry.amount : 0;
  }

  self.var_a097ccb7 = cash;

  if(self.var_a097ccb7 > 0) {
    self clientfield::set("wz_cash_carrying", 1);
    return;
  }

  self clientfield::set("wz_cash_carrying", 0);
}