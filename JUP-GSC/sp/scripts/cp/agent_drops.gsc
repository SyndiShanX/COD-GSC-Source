/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\agent_drops.gsc
***********************************************/

#using scripts\cp\pickups;
#using scripts\cp\utility;
#using scripts\engine\utility;
#namespace agent_drops;

function function_6620b2d387064d74() {
  function_22ad9cf8a9381198();
  function_cb24c57ae08ed7ae();
}

function function_22ad9cf8a9381198() {
  level.var_d932f46857d6d61 = [];
  level.var_dd7e94a4498cc047 = [];
  level.var_82482823a4bd9581 = [];
  level.var_d5149904ccb5fe9d = [];
  level.var_f7c5323d78892a4b = [];
  level.var_365210df3b94b112 = [];
  function_d2475f924f681ec3();
}

function function_d2475f924f681ec3() {
  level.var_13503c3176b8b0b1 = [];
  level.var_13503c3176b8b0b1["brloot_ammo_762"] = 38;
  level.var_13503c3176b8b0b1["brloot_ammo_919"] = 37;
  level.var_13503c3176b8b0b1["brloot_ammo_50cal"] = 10;
  level.var_13503c3176b8b0b1["brloot_ammo_12g"] = 10;
  level.var_13503c3176b8b0b1["brloot_ammo_rocket"] = 5;
  level.var_20e9e1c4da44b83 = [];
  level.var_20e9e1c4da44b83["brloot_ammo_762"] = -1;
  level.var_20e9e1c4da44b83["brloot_ammo_919"] = -1;
  level.var_20e9e1c4da44b83["brloot_ammo_50cal"] = -1;
  level.var_20e9e1c4da44b83["brloot_ammo_12g"] = -1;
  level.var_20e9e1c4da44b83["brloot_ammo_rocket"] = -1;
}

function function_cb24c57ae08ed7ae() {
  if(!function_240f7f4e57340e8f()) {
    function_6c38af1ab38e980e("headshot_cash", &function_8cd9ca26d81fd9d, "money", 1, 30, 10, 1);
    function_6c38af1ab38e980e("cash_drop_50", &function_8cd9ca26d81fd9d, "money", 1, 30, 10, 1);
    function_6c38af1ab38e980e("cash_drop_100", &function_8cd9ca26d81fd9d, "money", 1, undefined, 5, 0);
    function_6c38af1ab38e980e("cash_drop_150", &function_8cd9ca26d81fd9d, "money", 1, 30, 10, 1);
    function_6c38af1ab38e980e("cash_drop_500", &function_8cd9ca26d81fd9d, "money", 1, undefined, 5, 0);
    function_6c38af1ab38e980e("cash_drop_1000", &function_8cd9ca26d81fd9d, "money", 1, 30, 10, 1);
  }

  function_6c38af1ab38e980e("brloot_powerup_armor", &function_9eec29e4018e3bd9, "power_up", 0, 30, 10, 1);
  function_6c38af1ab38e980e("brloot_ammo_762", &function_e5fbaab3da0af6de, "ammo", 1, undefined, 20, 0);
  function_6c38af1ab38e980e("brloot_ammo_rocket", &function_e5fbaab3da0af6de, "ammo", 1, undefined, 5, 0);
  function_6c38af1ab38e980e("brloot_ammo_rocket_rpg_ai", &function_e5fbaab3da0af6de, "forced_ammo", 0, undefined, 100, 0);
  function_6c38af1ab38e980e("brloot_ammo_919", &function_e5fbaab3da0af6de, "ammo", 1, undefined, 20, 0);
  function_6c38af1ab38e980e("brloot_ammo_50cal", &function_e5fbaab3da0af6de, "ammo", 1, undefined, 5, 0);
  function_6c38af1ab38e980e("brloot_ammo_12g", &function_e5fbaab3da0af6de, "ammo", 1, undefined, 10, 0);
  function_6c38af1ab38e980e("drop_random_ammo_types", &function_e4bd43508c05c894, "ammo", 1, undefined, 20, 0);
  function_6c38af1ab38e980e("brloot_armor_plate", &function_9eec29e4018e3bd9, "power_up", 0, 8, 20, 0);
  function_6c38af1ab38e980e("brloot_powerup_ammo", &function_9eec29e4018e3bd9, "power_up", 0, 30, 10, 0);
  function_6c38af1ab38e980e("brloot_powerup_equipment", &function_9eec29e4018e3bd9, "power_up", 0, undefined, 10, 0);
  function_6c38af1ab38e980e("brloot_offhand_claymore", &function_3eeb69d40ad71f2b, "equipment", 1, undefined, 100, 0);
  function_6c38af1ab38e980e("brloot_offhand_decoy", &function_3eeb69d40ad71f2b, "equipment", 1, undefined, 100, 0);
  function_6c38af1ab38e980e("brloot_offhand_flash", &function_3eeb69d40ad71f2b, "equipment", 1, undefined, 100, 0);
  function_6c38af1ab38e980e("brloot_offhand_gas", &function_3eeb69d40ad71f2b, "equipment", 1, undefined, 100, 0);
  function_6c38af1ab38e980e("brloot_offhand_smoke", &function_3eeb69d40ad71f2b, "equipment", 1, undefined, 100, 0);
  function_6c38af1ab38e980e("brloot_offhand_snapshot", &function_3eeb69d40ad71f2b, "equipment", 1, undefined, 100, 0);
  function_6c38af1ab38e980e("brloot_offhand_throwingknife", &function_3eeb69d40ad71f2b, "equipment", 1, undefined, 100, 1);
  function_6c38af1ab38e980e("brloot_offhand_heartbeatsensor", &function_3eeb69d40ad71f2b, "equipment", 1, undefined, 100, 0);
  function_6c38af1ab38e980e("brloot_equip_gasmask", &function_66d0a6e429fdf0f4, "equipment", 1, undefined, 100, 0);
}

function function_6c38af1ab38e980e(drop_name, drop_func, drop_type, single_instance, time_between_spawns, var_429f631e84274dd3, var_3b2e46e915ea397b) {
  if(istrue(var_3b2e46e915ea397b)) {
    return;
  }

  if(function_92031ff8a97d9e90(drop_name)) {
    assertmsg("scriptscpagent_drops::register_agent_drop was called using a drop_name (" + drop_name + ") that was previously registered.");
  }

  if(!isDefined(level.var_d932f46857d6d61[drop_name])) {
    level.var_d932f46857d6d61[drop_name] = [];
  }

  level.var_d932f46857d6d61[drop_name] = drop_func;

  if(isDefined(drop_type)) {
    if(!isDefined(level.var_dd7e94a4498cc047[drop_type])) {
      level.var_dd7e94a4498cc047[drop_type] = [];
    }

    level.var_dd7e94a4498cc047[drop_name] = drop_type;
  }

  if(istrue(single_instance)) {
    level.var_82482823a4bd9581[drop_name] = 1;
  }

  if(isDefined(time_between_spawns)) {
    function_630229e935873b44(drop_name, time_between_spawns);
  }

  if(isDefined(var_429f631e84274dd3)) {
    level.var_365210df3b94b112[drop_name] = var_429f631e84274dd3;
  } else {
    level.var_365210df3b94b112[drop_name] = 100;
  }

  setDvar(hashcat(@ "hash_6e663fb6f8a19320", drop_name), level.var_365210df3b94b112[drop_name]);
}

function function_276d0d2c772b45bb(drop_name) {
  level.var_d932f46857d6d61[drop_name] = undefined;
  level.var_365210df3b94b112[drop_name] = undefined;
  level.var_82482823a4bd9581[drop_name] = undefined;
  level.var_dd7e94a4498cc047[drop_name] = undefined;
  level.var_d5149904ccb5fe9d[drop_name] = undefined;
}

function function_630229e935873b44(drop_name, time_between_spawns) {
  level.var_d5149904ccb5fe9d[drop_name] = time_between_spawns * 1000;
}

function function_6c418592a0f5850d(drop_name) {
  return isDefined(level.var_d5149904ccb5fe9d[drop_name]);
}

function function_9c2f4b63b917cbc1(drop_name) {
  return level.var_d5149904ccb5fe9d[drop_name];
}

function function_a74a1ad1bba9f0fd(drop_name) {
  if(isDefined(level.var_f7c5323d78892a4b[drop_name])) {
    return level.var_f7c5323d78892a4b[drop_name];
  }

  return 0;
}

function function_526976d2fd70521f(drop_name) {
  drop_chance = function_b843fbf56b48d7a5(drop_name);

  if(randomint(100) < drop_chance) {
    if(function_6c418592a0f5850d(drop_name)) {
      time = gettime();
      next_spawn_time = function_a74a1ad1bba9f0fd(drop_name);
      return (time >= next_spawn_time);
    } else {
      return 1;
    }

    return;
  }

  return 0;
}

function function_b843fbf56b48d7a5(drop_name) {
  if(getdvarint(@ "hash_2cda10d708006761")) {
    return 100;
  }

  if(isDefined(level.var_365210df3b94b112[drop_name])) {
    if(getdvarint(hashcat(@ "hash_6e663fb6f8a19320", drop_name)) != level.var_365210df3b94b112[drop_name]) {
      return getdvarint(hashcat(@ "hash_6e663fb6f8a19320", drop_name));
    } else {
      return level.var_365210df3b94b112[drop_name];
    }

    return;
  }

  return 100;
}

function function_304333ff6b2313f(drop_name) {
  if(function_6c418592a0f5850d(drop_name)) {
    add_time = function_9c2f4b63b917cbc1(drop_name);
    time = gettime();
    level.var_f7c5323d78892a4b[drop_name] = time + add_time;
  }
}

function function_29a7cb456961b143(drop_name) {
  if(isDefined(level.var_dd7e94a4498cc047[drop_name])) {
    return level.var_dd7e94a4498cc047[drop_name];
  }

  return undefined;
}

function function_6fdbf71c8217cfc5(drop_name) {
  if(!function_713174da2f52de61()) {
    return;
  }

  if(!function_e4e9a069045bf808(drop_name)) {
    return;
  }

  if(function_9fffc56f57c8f7c8(drop_name)) {
    return;
  }

  if(!isDefined(self.var_d932f46857d6d61)) {
    self.var_d932f46857d6d61 = [];
  }

  if(function_92031ff8a97d9e90(drop_name)) {
    if(function_2a5a6ec75498cac6(drop_name)) {
      drop_type = function_29a7cb456961b143(drop_name);

      if(isDefined(drop_type)) {
        function_8c4c5c17f08ff6f0(drop_type);
      }
    }

    self.var_d932f46857d6d61[self.var_d932f46857d6d61.size] = drop_name;
  }
}

function function_713174da2f52de61() {
  if(isDefined(self.unittype)) {
    switch (self.unittype) {
      case #"hash_f4a90c6c03d32ee9":
        return 0;
      case #"hash_e87767df2e5c3a68":
        return 0;
      default:
        return 1;
    }

    return;
  }

  return 0;
}

function function_9fffc56f57c8f7c8(drop_name) {
  if(isDefined(self.var_d932f46857d6d61)) {
    for(i = 0; i < self.var_d932f46857d6d61.size; i++) {
      if(self.var_d932f46857d6d61[i] == drop_name) {
        return true;
      }
    }
  }

  return false;
}

function function_92031ff8a97d9e90(drop_name) {
  return isDefined(level.var_d932f46857d6d61[drop_name]);
}

function function_2a5a6ec75498cac6(drop_name) {
  return istrue(level.var_82482823a4bd9581[drop_name]);
}

function function_8c4c5c17f08ff6f0(var_528b2fc70e7691cc) {
  if(isDefined(self.var_d932f46857d6d61)) {
    drop_funcs = self.var_d932f46857d6d61;

    for(i = 0; i < drop_funcs.size; i++) {
      drop_type = function_29a7cb456961b143(drop_funcs[i]);

      if(isDefined(drop_type) && drop_type == var_528b2fc70e7691cc) {
        function_8033aadb6558d0fe(drop_funcs[i]);
      }
    }
  }
}

function function_8033aadb6558d0fe(drop_name) {
  if(!isDefined(self.var_d932f46857d6d61)) {
    return;
  }

  temp_array = [];

  for(i = 0; i < self.var_d932f46857d6d61.size; i++) {
    if(self.var_d932f46857d6d61[i] != drop_name) {
      temp_array[temp_array.size] = self.var_d932f46857d6d61[i];
    }
  }

  self.var_d932f46857d6d61 = temp_array;
}

function function_c568b761a7f0b678(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration) {
  if(isDefined(self.var_d932f46857d6d61)) {
    for(i = 0; i < self.var_d932f46857d6d61.size; i++) {
      var_b703f10aa66786b1 = self.var_d932f46857d6d61[i];

      if(isDefined(level.var_d932f46857d6d61[var_b703f10aa66786b1]) && function_526976d2fd70521f(var_b703f10aa66786b1)) {
        self.var_d0e9753b09126417 = var_b703f10aa66786b1;

        if(self[[level.var_d932f46857d6d61[var_b703f10aa66786b1]]]()) {
          function_304333ff6b2313f(var_b703f10aa66786b1);
        }
      }
    }
  }
}

function function_e4e9a069045bf808(drop_name) {
  if(getdvarint(@ "hash_1cda994c72edfabe", 0)) {
    return false;
  }

  if(!scripts\cp\utility::coop_mode_has("agent_drops")) {
    return false;
  }

  if(istrue(level.var_ea8aff4b580b0b8d)) {
    return false;
  }

  return true;
}

function function_b1c55038843de38b() {
  if(isDefined(self.var_7c968c5609aded2)) {
    return_value = self.var_7c968c5609aded2;
    self.var_7c968c5609aded2++;
    return return_value;
  }

  return 0;
}

function function_8cd9ca26d81fd9d() {
  amount = 100;
  drop_type = "brloot_plunder_cash_common_1";

  if(isDefined(self.var_d0e9753b09126417)) {
    switch (self.var_d0e9753b09126417) {
      case #"hash_d0eeb6cbc5a7b58f":
        drop_type = "brloot_plunder_cash_uncommon_2";
        amount = 200;
        break;
      case #"hash_68a7a13097c6d8b2":
        drop_type = "brloot_plunder_cash_uncommon_2";
        amount = 500;
        break;
      case #"hash_51d09164e6d2cea2":
        drop_type = "brloot_plunder_cash_rare_1";
        amount = 1000;
        break;
      case #"hash_49b303308736b4eb":
        drop_type = "brloot_plunder_cash_uncommon_1";
        amount = 100;
        break;
      case #"hash_1bf0dcf87f6c7bf6":
      case #"hash_49bc7530873e2426":
      default:
        drop_type = "brloot_plunder_cash_common_1";
        amount = 100;
        break;
    }
  }

  dropinfo = getitemdroporiginandangles(function_b1c55038843de38b(), self.origin, self.angles, self);
  item = spawnpickup(drop_type, dropinfo, amount, 1, undefined, 1);
  return true;
}

function function_e4bd43508c05c894() {
  drops = function_d7555674b07d6fc9();
  rates = function_ee2a1706b8952b4c(drops);
  ammo_count = function_9a9eb8e1438e9cb8();
  first_drop = weighted_array_randomize(drops, rates);
  drops = array_remove(drops, first_drop);
  dropinfo = getitemdroporiginandangles(function_b1c55038843de38b(), self.origin, self.angles, self);

  switch (first_drop) {
    case #"hash_672892a4af1e94cc":
      item = spawnpickup("brloot_ammo_762", dropinfo, ammo_count[first_drop], 1, undefined, 1);
      break;
    case #"hash_755a9bafcd63b343":
      item = spawnpickup("brloot_ammo_rocket", dropinfo, ammo_count[first_drop], 1, undefined, 1);
      break;
    case #"hash_1cd9ffa488237604":
      item = spawnpickup("brloot_ammo_919", dropinfo, ammo_count[first_drop], 1, undefined, 1);
      break;
    case #"hash_f1734c15f85881ca":
      item = spawnpickup("brloot_ammo_50cal", dropinfo, ammo_count[first_drop], 1, undefined, 1);
      break;
    case #"hash_57e5eda4a702c559":
      item = spawnpickup("brloot_ammo_12g", dropinfo, ammo_count[first_drop], 1, undefined, 1);
      break;
  }

  drops = function_d7555674b07d6fc9(first_drop);
  rates = function_ee2a1706b8952b4c(drops);
  second_drop = weighted_array_randomize(drops, rates);
  drop_chance = int(function_b843fbf56b48d7a5(second_drop) * 0.5);
  result = randomint(100) < drop_chance;

  if(result) {
    dropinfo = getitemdroporiginandangles(function_b1c55038843de38b(), self.origin, self.angles, self);
    item = spawnpickup(second_drop, dropinfo, ammo_count[second_drop], 1, undefined, 1);
    function_304333ff6b2313f(second_drop);
  }

  return true;
}

function function_d7555674b07d6fc9(excluded_types) {
  if(isDefined(excluded_types)) {
    return_array = [];

    if(!isarray(excluded_types)) {
      excluded_types = [excluded_types];
    }

    keys = getarraykeys(level.var_13503c3176b8b0b1);

    for(i = 0; i < keys.size; i++) {
      var_db40693db52522e8 = 1;

      for(j = 0; j < excluded_types.size; j++) {
        if(keys[i] == excluded_types[j]) {
          var_db40693db52522e8 = 0;
          break;
        }
      }

      if(var_db40693db52522e8) {
        return_array[return_array.size] = keys[i];
      }
    }

    return return_array;
  }

  return getarraykeys(level.var_13503c3176b8b0b1);
}

function function_ee2a1706b8952b4c(ammo_types) {
  rates = [];

  for(i = 0; i < ammo_types.size; i++) {
    rate = function_d4d68b57453c54e0(ammo_types[i]);
    rates[rates.size] = rate;
  }

  return rates;
}

function function_d4d68b57453c54e0(ammo_type) {
  if(isDefined(level.var_20e9e1c4da44b83[ammo_type]) && level.var_20e9e1c4da44b83[ammo_type] >= 0) {
    return level.var_20e9e1c4da44b83[ammo_type];
  }

  return level.var_13503c3176b8b0b1[ammo_type];
}

function function_6cd80be6451f285(ammo_type, drop_chance) {
  level.var_20e9e1c4da44b83[ammo_type] = drop_chance;
}

function function_38924fb7672b340d(drop_name, var_429f631e84274dd3) {
  if(isDefined(var_429f631e84274dd3)) {
    level.var_365210df3b94b112[drop_name] = var_429f631e84274dd3;
  } else {
    level.var_365210df3b94b112[drop_name] = 100;
  }

  setDvar(hashcat(@ "hash_6e663fb6f8a19320", drop_name), level.var_365210df3b94b112[drop_name]);
}

function function_77f5254d6847360b(ammo_type) {
  drops = function_d7555674b07d6fc9();

  for(i = 0; i < drops.size; i++) {
    function_73a9ff1e1e7ef586(drops[i]);
  }
}

function function_73a9ff1e1e7ef586(ammo_type) {
  function_6cd80be6451f285(ammo_type, -1);
}

function function_9a9eb8e1438e9cb8() {
  ammo_count = [];
  ammo_count["brloot_ammo_762"] = 30;
  ammo_count["brloot_ammo_919"] = 25;
  ammo_count["brloot_ammo_50cal"] = 10;
  ammo_count["brloot_ammo_12g"] = 10;
  ammo_count["brloot_ammo_rocket"] = 1;
  return ammo_count;
}

function function_c530de57dafe4bd8(drop_name) {
  ammo_counts = function_9a9eb8e1438e9cb8();

  if(isDefined(ammo_counts[drop_name])) {
    return ammo_counts[drop_name];
  }

  return undefined;
}

function function_e5fbaab3da0af6de() {
  if(isDefined(self.var_d0e9753b09126417)) {
    drop_name = self.var_d0e9753b09126417;
    amount = function_c530de57dafe4bd8(drop_name);

    switch (drop_name) {
      case #"hash_1cd9ffa488237604":
      case #"hash_57e5eda4a702c559":
      case #"hash_672892a4af1e94cc":
      case #"hash_755a9bafcd63b343":
      case #"hash_f1734c15f85881ca":
        break;
      case #"hash_7bbe2f3bfd8d0162":
        drop_name = "brloot_ammo_rocket";
        amount = 1;
        function_304333ff6b2313f(drop_name);
        break;
    }

    dropinfo = getitemdroporiginandangles(function_b1c55038843de38b(), self.origin, self.angles, self);
    dropinfo.var_a61783b788746c54 = 1;
    item = spawnpickup(drop_name, dropinfo, amount, 1, undefined, 1);
    return 1;
  }

  return 0;
}

function function_8f956de778c73e8e() {
  drop_chance = getdvarint(@ "hash_5372d188bbf813ac", 10);

  if(randomint(100) <= drop_chance) {
    drop_type = "brloot_armor_plate";
    amount = 1;
    dropinfo = getitemdroporiginandangles(function_b1c55038843de38b(), self.origin, self.angles, self);
    dropinfo.var_a61783b788746c54 = 1;
    item = spawnpickup(drop_type, dropinfo, amount, 1, undefined, 1);
    return 1;
  }

  return 0;
}

function function_9eec29e4018e3bd9() {
  if(isDefined(self.var_d0e9753b09126417)) {
    drop_name = "brloot_powerup_ammo";
    amount = 1;
    bautouse = 1;
    drop_chance = getdvarint(@ "hash_5b1597cf9406744", 5);

    switch (self.var_d0e9753b09126417) {
      case #"hash_444817d1d52f73b3":
        drop_name = "brloot_powerup_ammo";
        amount = 1;
        break;
      case #"hash_f7690febb5e098cb":
        drop_name = scripts\engine\utility::random(["brloot_offhand_claymore", "brloot_offhand_c4", "brloot_offhand_frag", "brloot_offhand_molotov", "brloot_offhand_semtex", "brloot_offhand_thermite", "brloot_offhand_throwingknife"]);
        bautouse = 0;
        amount = 4;
        break;
      case #"hash_2eb74e6e69980388":
        drop_name = "brloot_powerup_armor";
        amount = 1;
        break;
      case #"hash_55798564991651ac":
        drop_name = "brloot_armor_plate";
        amount = 1;
        bautouse = getdvarint(@ "hash_9925f8ad1812f844", 1);
        break;
    }

    dropinfo = getitemdroporiginandangles(function_b1c55038843de38b(), self.origin, self.angles, self);
    dropinfo.var_a61783b788746c54 = 1;
    item = spawnpickup(drop_name, dropinfo, amount, 0, undefined, bautouse);
    return true;
  }

  return false;
}

function function_3eeb69d40ad71f2b() {
  if(isDefined(self.var_d0e9753b09126417)) {
    amount = 4;
    drop_name = self.var_d0e9753b09126417;
    dropinfo = getitemdroporiginandangles(function_b1c55038843de38b(), self.origin, self.angles, self);
    dropinfo.var_a61783b788746c54 = 1;
    item = spawnpickup(drop_name, dropinfo, amount, 0, undefined, 0);
    return true;
  }

  return false;
}

function function_66d0a6e429fdf0f4() {
  if(isDefined(self.gasmaskhealth) && self.gasmaskhealth > 0) {
    if(isDefined(self.var_d0e9753b09126417)) {
      amount = 4;
      drop_name = self.var_d0e9753b09126417;
      dropinfo = getitemdroporiginandangles(function_b1c55038843de38b(), self.origin, self.angles, self);
      dropinfo.var_a61783b788746c54 = 1;
      item = spawnpickup(drop_name, dropinfo, amount, 0, undefined, 0);
      return true;
    }

    return false;
  }

  return false;
}

function weighted_array_randomize(array, weights) {
  assert(array.size == weights.size);
  cumulative_weight = 0;

  for(i = 0; i < weights.size; i++) {
    cumulative_weight += weights[i];
  }

  random_weight = randomfloat(cumulative_weight);
  running_total = 0;

  for(i = 0; i < array.size; i++) {
    running_total += weights[i];

    if(running_total >= random_weight) {
      return array[i];
    }
  }
}