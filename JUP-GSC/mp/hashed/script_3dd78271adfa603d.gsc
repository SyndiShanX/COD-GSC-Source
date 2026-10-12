/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3dd78271adfa603d.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_185660037b9236c1;
#using script_220d0eb95a8fab7d;
#using script_29b50ff5f1477a5d;
#using script_2d400da2610fe542;
#using script_3ab210ea917601e7;
#using script_41387eecc35b88bf;
#using scripts\cp_mp\zombie_challenges;
#using script_4e6e58ab5d96c2b0;
#using script_4fdefae8b7bcdf73;
#using script_5753ba9c28794a65;
#using script_5d8202968463a21d;
#using script_60dd6e3992c1f29;
#using script_638d701d263ee1ed;
#using script_64351208cb856df9;
#using script_6df6604a74a7a9c7;
#using script_7956d56c4922bd1;
#using script_7edf952f8921aa6b;
#using script_d60e0219a7419e0;
#using scripts\common\callbacks;
#using scripts\common\create_script_utility;
#using scripts\common\powerups;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\gasmask;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\loot\common_cache;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\math;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\mp_agent_damage;
#using scripts\ob\points;
#namespace namespace_c63df5a8b7194592;

function function_1cf627178cf6bee() {
  activity_common::function_89384091f7a2dbd("REV_OB_ZOMBIE_STRONGHOLD", 0, &function_fb6bc8f3ed4781d4);
  activity_common::function_89384091f7a2dbd("REV_OB_ZOMBIE_STRONGHOLD", 1, &function_fbc94dc837737154);
  activity_common::function_89384091f7a2dbd("REV_OB_ZOMBIE_STRONGHOLD", 2, &function_2a6a959fd054e401);
  activity_common::function_89384091f7a2dbd("REV_OB_ZOMBIE_STRONGHOLD", 3, &function_89bdb2d03896122b);
  activity_common::function_89384091f7a2dbd("REV_OB_ZOMBIE_STRONGHOLD", 5, &function_7b8f4f5e1fbe30d5);
  activity_common::function_8b5b2a3392fc7e2a("PlayerJoin", &function_c1cb9b8f30cff8c6, "REV_OB_ZOMBIE_STRONGHOLD");
  activity_common::function_8b5b2a3392fc7e2a("PlayerLeave", &function_7208e454d9a1452e, "REV_OB_ZOMBIE_STRONGHOLD");
  callback::add("player_item_pickup", &function_8af75525d37866eb);

  if(!isDefined(level.var_96a2d0c3a5256c2)) {
    namespace_b2b546ada8578eda::function_96a2d0c3a5256c2();
    level.var_96a2d0c3a5256c2 = 1;
  }
}

function function_fb6bc8f3ed4781d4() {
  activity_instance = self;
  activity_instance endon("activity_ended");
  activity_instance endon("instance_destroyed");
  activityvariantdefinition = namespace_3485b020a23acaae::function_4188e118731a30f4();
  self.variant_definition = activityvariantdefinition;
  level._effect["smoke_effect_1"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_aether_cyst_spore_area_500.vfx");
  level._effect["smoke_effect_4"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_aether_cyst_spore_vent_release.vfx");
  level._effect["camera_vfx"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_aether_cyst_spore_area_camera.vfx");
  self.s_center = utility::getStruct(self.varianttag + "_main", "targetname");

  if(!isDefined(self.s_center)) {
    function_4bc22996edea81f1(self);
  }

  self.difficulty_region = namespace_f721fc7d0d2d0f47::function_4d8bb2d866771a10(self.s_center.origin);

  switch (self.difficulty_region) {
    case #"hash_651f76c0ad6741ec":
      self.var_67d58bcaf37c2e2b = 7000;
      self.var_c305d8b37977e9c9 = 12;
      self.var_b775d3fc5973f7ac = 20;
      self.var_c61203960d56682a = 3;
      self.var_cd1f6a0cc4b9d2b6 = 1;
      self.var_d76a378fe188ada0 = 4;
      self.var_91d007152e252433 = 0;
      self.var_34f38a376bb1343f = 0;
      self.spawn_list = "ob_jup_items_activity_aethernest_red";
      self.var_de4d87caa90a9970 = 15;
      self.var_a4aeecf5b922b358 = 3;
      break;
    case #"hash_5343b465e56ec9a4":
      self.var_67d58bcaf37c2e2b = 5125;
      self.var_c305d8b37977e9c9 = 10;
      self.var_b775d3fc5973f7ac = 18;
      self.var_c61203960d56682a = 2;
      self.var_cd1f6a0cc4b9d2b6 = 2;
      self.var_d76a378fe188ada0 = 3;
      self.var_91d007152e252433 = 0;
      self.var_34f38a376bb1343f = 0;
      self.spawn_list = "ob_jup_items_activity_aethernest_orange";
      self.var_de4d87caa90a9970 = 10;
      self.var_a4aeecf5b922b358 = 3;
      break;
    case #"hash_af83e47edfa8900a":
      self.var_67d58bcaf37c2e2b = 3300;
      self.var_c305d8b37977e9c9 = 8;
      self.var_b775d3fc5973f7ac = 15;
      self.var_c61203960d56682a = 2;
      self.var_cd1f6a0cc4b9d2b6 = 2;
      self.var_d76a378fe188ada0 = 2;
      self.var_91d007152e252433 = 0;
      self.var_34f38a376bb1343f = 1;
      self.spawn_list = "ob_jup_items_activity_aethernest_yellow";
      self.var_de4d87caa90a9970 = 10;
      self.var_a4aeecf5b922b358 = 2;
      break;
    case #"hash_7bb2cd766703d463":
    default:
      self.var_67d58bcaf37c2e2b = 2000;
      self.var_c305d8b37977e9c9 = 6;
      self.var_b775d3fc5973f7ac = 12;
      self.var_c61203960d56682a = 1;
      self.var_cd1f6a0cc4b9d2b6 = 2;
      self.var_d76a378fe188ada0 = 1;
      self.var_91d007152e252433 = 1;
      self.var_34f38a376bb1343f = 1;
      self.spawn_list = "ob_jup_items_activity_aethernest_green";
      self.var_de4d87caa90a9970 = 10;
      self.var_a4aeecf5b922b358 = 1;
      break;
  }

  self.var_f683875f2e47f6bc = [];
  self.var_ec031f5af338bc24 = self.var_67d58bcaf37c2e2b;
  self.first_threshold = self.var_67d58bcaf37c2e2b * 0.666667;
  self.second_threshold = self.var_67d58bcaf37c2e2b * 0.333333;
  self.started = 0;
  self.var_e171f154ea4ec2c8 = 0;
  self.s_center.activityinstance = self;
  sort_structs();
  function_c350f33277c1de1();
  function_eda4e16141cc6490();
  function_afe71f4277675131();
  function_d0d0c2cf7d4c1fc9();
  function_cf65031f2b7139e3();
  namespace_4c2b495b8d79cc2e::function_2dac62aa2032b9b1("SpatialZoneContainerGroup_ActivityInstance_AwarenessZone", &function_c9b0c1c4babe3cb);
  function_425a1df4fd86e188();
  self.floor_count = 1;

  if(isDefined(self.s_center.script_noteworthy)) {
    self.floor_count = int(self.s_center.script_noteworthy);
  }

  namespace_4fda5d7358015a06::function_b6fc2c96b463c007(self);
}

function function_425a1df4fd86e188() {
  trigger_volumes = getnoentvolumearray("aethernest_interior_trigger", "targetname");
  self.var_83116f41aad4fc96 = trigger_volumes;
  self.var_1258379e7ea78440 = [];

  foreach(trigger_volume in trigger_volumes) {
    if(is_equal(trigger_volume.target, self.varianttag) || is_equal(trigger_volume.target, self.varianttag + "_main")) {
      trigger_volume thread function_ddab80cebff23794(self);
    }
  }

  trigger_volumes = getnoentvolumearray("zmstronghold_treasure_room_trigger", "targetname");
  self.var_17186c6d528a44d1 = undefined;

  foreach(trigger_volume in trigger_volumes) {
    if(is_equal(trigger_volume.target, self.varianttag) || is_equal(trigger_volume.target, self.varianttag + "_main")) {
      self.var_17186c6d528a44d1 = trigger_volume;
      trigger_volume thread function_d70b7e579a26e875(self);
    }
  }

  thread namespace_b2b546ada8578eda::function_82440f5119dba754();
}

function function_ddab80cebff23794(instance) {
  instance endon("activity_ended");
  instance endon("instance_destroyed");
  instance endon("aethergas_cleared");

  while(true) {
    self waittill("trigger", ent);
    is_player = isPlayer(ent);
    is_vehicle = ent scripts\common\vehicle::isvehicle();

    if(!is_player && !is_vehicle) {
      continue;
    }

    if(is_vehicle) {
      if(isarray(ent.occupants)) {
        foreach(occupant in ent.occupants) {
          if(isPlayer(occupant)) {
            player = occupant;

            if(!isalive(player)) {
              continue;
            }

            player.var_ce51e639071849f = gettime();

            if(!array_contains(instance.var_1258379e7ea78440, player)) {
              instance.var_1258379e7ea78440 = function_6d6af8144a5131f1(instance.var_1258379e7ea78440, player);
              player thread function_950d1ee4567388cb(self, instance);
            }
          }
        }
      }
    }

    if(is_player) {
      player = ent;

      if(!isalive(player)) {
        continue;
      }

      if(scripts\cp_mp\gasmask::hasgasmask(player) == 0) {
        if(!istrue(player.var_c70b8c1206c03437)) {
          squad = scripts\cp_mp\utility\squad_utility::getsquadmembers();

          if(squad.size == 0) {
            squad = [player];
          }

          instance thread function_1281c7fff9456e18("zm_stronghold_no_protection");

          foreach(squadmate in squad) {
            squadmate.var_c70b8c1206c03437 = 1;
          }
        }
      }

      player.var_ce51e639071849f = gettime();

      if(!array_contains(instance.var_1258379e7ea78440, player)) {
        instance.var_1258379e7ea78440 = function_6d6af8144a5131f1(instance.var_1258379e7ea78440, player);
        player thread function_950d1ee4567388cb(self, instance);
      } else if(array_contains(instance.var_1258379e7ea78440, player) && !istrue(player.var_7bf8710b8f268d67)) {
        player thread function_950d1ee4567388cb(self, instance);
      }
    }

    var_91e59e745cfdf8a5 = namespace_b2b546ada8578eda::function_e1b3ae526db82c88(instance);

    foreach(player in var_91e59e745cfdf8a5) {
      player.var_ce51e639071849f = gettime();

      if(!array_contains(instance.var_1258379e7ea78440, player)) {
        instance.var_1258379e7ea78440 = function_6d6af8144a5131f1(instance.var_1258379e7ea78440, player);
        player thread function_950d1ee4567388cb(self, instance);
        continue;
      }

      if(array_contains(instance.var_1258379e7ea78440, player) && !istrue(player.var_7bf8710b8f268d67)) {
        player thread function_950d1ee4567388cb(self, instance);
      }
    }

    waitframe();
  }
}

function function_d70b7e579a26e875(instance) {
  instance endon("activity_ended");
  instance endon("instance_destroyed");
  instance endon("aethergas_cleared");
  var_90ed426540e8be37 = [];

  while(true) {
    self waittill("trigger", ent);
    is_player = isPlayer(ent);

    if(!is_player) {
      continue;
    }

    if(is_player) {
      player = ent;

      if(array_contains(var_90ed426540e8be37, player)) {
        continue;
      }

      if(!isalive(player)) {
        continue;
      }

      if(!istrue(player.var_39b049a8b56b7d8d)) {
        squad = scripts\cp_mp\utility\squad_utility::getsquadmembers();

        if(squad.size == 0) {
          squad = [player];
        }

        if(randomfloat(1) < 0.3) {
          instance thread function_1281c7fff9456e18("zm_stronghold_treasure_room");

          foreach(squadmate in squad) {
            squadmate.var_39b049a8b56b7d8d = 1;
          }
        }

        foreach(squadmate in squad) {
          array_add(var_90ed426540e8be37, squadmate);
        }
      }
    }

    wait 0.1;
  }
}

function sort_structs() {
  all_structs = utility::getStructArray(self.s_center.targetname, "target");
  self.var_7fe21e160de181f7 = [];
  self.var_eb9f6bfe8a0d4839 = [];
  self.var_d8875e62f764b801 = [];
  self.var_6a12b6a1b2843943 = [];
  self.var_a1dc369621f4b3b = [];
  self.var_82994cf791e27f7d = [];
  self.var_a0fa0c27dc0dbab1 = [];

  foreach(struct in all_structs) {
    if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "s_locked_door") {
      self.var_7fe21e160de181f7[self.var_7fe21e160de181f7.size] = struct;
      continue;
    }

    if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "s_loot_cache_spawn") {
      self.var_eb9f6bfe8a0d4839[self.var_eb9f6bfe8a0d4839.size] = struct;
      continue;
    }

    if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "stronghold_mimic_spawn") {
      self.var_d8875e62f764b801[self.var_d8875e62f764b801.size] = struct;
      continue;
    }

    if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "essence_spawn_large") {
      self.var_6a12b6a1b2843943[self.var_6a12b6a1b2843943.size] = struct;
      continue;
    }

    if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "essence_spawn_small") {
      self.var_a1dc369621f4b3b[self.var_a1dc369621f4b3b.size] = struct;
      continue;
    }

    if(isDefined(struct.targetname) && struct.targetname == "ceiling_spawner") {
      self.var_82994cf791e27f7d[self.var_82994cf791e27f7d.size] = struct;
      continue;
    }

    if(isDefined(struct.targetname) && struct.targetname == "s_cyst_spawn") {
      self.var_a0fa0c27dc0dbab1[self.var_a0fa0c27dc0dbab1.size] = struct;
    }
  }

  if(isDefined(self.s_center.stronghold_targetname)) {
    root_structs = utility::getStructArray(self.s_center.stronghold_targetname, "targetname");
    self.root_struct = utility::getclosest(self.s_center.origin, root_structs, 1000);
  }
}

function function_c350f33277c1de1() {
  prop_radius = 3000;

  if(isDefined(self.s_center.n_radius_override)) {
    prop_radius = int(self.s_center.n_radius_override);
  }

  self.prop_array = getentitylessscriptablearray(self.s_center.targetname, "target", self.s_center.origin, prop_radius);

  if(self.prop_array.size == 0 && isDefined(self.root_struct)) {
    self.prop_array = getentitylessscriptablearray(self.root_struct.target, "targetname", self.s_center.origin, prop_radius);
  }

  self.gas_array = [];

  foreach(prop in self.prop_array) {
    prop setscriptablepartstate("state", "visible");

    if(issubstr(prop.classname, "gas")) {
      self.gas_array[self.gas_array.size] = prop;
    }

    if(issubstr(prop.classname, "flag") || issubstr(prop.classname, "banner")) {
      if(prop getscriptableparthasstate("state", "Visible_zm")) {
        prop setscriptablepartstate("state", "visible_zm");
      }
    }
  }
}

function function_afe71f4277675131() {
  var_f57c80feb76a8e88 = ["ob_loot_cache", "ob_loot_cache_large", "ob_loot_cache_zm", "ob_loot_cache_large_zm"];
  loot_caches = getlootscriptablearrayinradius(var_f57c80feb76a8e88, undefined, self.s_center.origin, 1000);

  foreach(cache in loot_caches) {
    cache setscriptablepartstate("body", "hidden", 1);
  }

  cache_array = [];
  cache_array = append_caches(cache_array, self.var_cd1f6a0cc4b9d2b6, #"hash_d8e996c37357f449");
  cache_array = append_caches(cache_array, self.var_d76a378fe188ada0 - 1, #"hash_9f528a48605451");
  cache_array = append_caches(cache_array, 1, #"hash_887c5b1de73dd2a4");
  cache_array = append_caches(cache_array, self.var_91d007152e252433, #"hash_31848ee41c7d520d");
  cache_array = append_caches(cache_array, self.var_34f38a376bb1343f, #"hash_c1d0ea6db3f38ac5");
  cache_array = array_randomize(cache_array);
  waitframe();
  self.lootcaches = [];
  self.mounds = [];
  counter = 0;

  foreach(struct in self.var_eb9f6bfe8a0d4839) {
    cache = common_cache::cache_spawncache(cache_array[counter], struct.origin, struct.angles);
    waitframe();
    self.lootcaches[self.lootcaches.size] = cache;
    mound = spawnscriptable("ob_aethernest_toggleable_cover", struct.origin, struct.angles);

    if(isDefined(cache.type) && issubstr(cache.type, "large")) {
      mound setscriptablepartstate("state", "visible_large_hint");
    } else {
      mound setscriptablepartstate("state", "visible_medium_hint");
    }

    mound scripts\cp_mp\interaction::function_98fc2e3f04194a50(&function_ea0d2f50c264d5ef);
    self.mounds[self.mounds.size] = mound;

    if(counter + 1 < self.var_eb9f6bfe8a0d4839.size) {
      counter += 1;
    }

    foreach(player in level.players) {
      cache disablescriptableplayeruse(player);
    }
  }
}

function function_ea0d2f50c264d5ef(scriptable, player) {
  return false;
}

function append_caches(cache_array, num_caches, scriptable_name) {
  for(i = 0; i < num_caches; i++) {
    cache_array[cache_array.size] = scriptable_name;
  }

  return cache_array;
}

function function_d0d0c2cf7d4c1fc9() {
  self.var_2319616d73f58983 = namespace_b2b546ada8578eda::function_b25446edb490c05f(self.var_a0fa0c27dc0dbab1, self.var_b775d3fc5973f7ac);
  self.cysts = [];
  self.var_5eba52fdc9fb7b54 = [];
  self.scriptable = spawnscriptable("ob_aethernest_activity_scriptable", self.s_center.origin);

  foreach(s_cyst in self.var_2319616d73f58983) {
    s_cyst.var_c32336dbbd60b8d9 = int(self.var_67d58bcaf37c2e2b / self.var_2319616d73f58983.size);

    foreach(spawner in self.var_82994cf791e27f7d) {
      if(spawner.script_noteworthy == s_cyst.script_noteworthy) {
        s_cyst.spawner = spawner;
      }
    }
  }
}

function function_e9836f11aaedad08(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  if(!utility::is_equal(instance.type, "ob_aethernest_cyst_scriptable") || istrue(instance.destroyed)) {
    return;
  }

  if(isDefined(instance.spawner)) {
    instance.spawner notify("start_spawn");
  }

  if(isDefined(instance.health)) {
    instance.health -= idamage;

    if(isPlayer(eattacker)) {
      instance.var_f49149402765ecae = utility::function_6d6af8144a5131f1(instance.var_f49149402765ecae, eattacker);

      if(scripts\mp\mp_agent_damage::function_87c3b43d00319847()) {
        mp_agent_damage::function_c54b2cc2e762c201(eattacker, instance.eidentifier, "none", smeansofdeath, objweapon, int(idamage), undefined, 0, undefined, 0, 0);
      }

      eattacker damagefeedback::updatehitmarker("standard", instance.health <= 0, 0, 0, undefined);
    }

    instance.activity_instance.last_player_attacker = eattacker;

    if(!instance.activity_instance.started) {
      instance.activity_instance notify("aethernest_start");
    }

    instance.activity_instance function_9ca778648cd6e0c8(idamage);

    if(instance.health <= 0) {
      eattacker points::function_ddee59d6b1a2b9e(#"hash_626189d6229d39b4");
      instance thread namespace_b2b546ada8578eda::function_155971201d58c7dc("aethernest_cyst_gas_burst");
      instance.destroyed = 1;

      if(getactivitytype(instance.activity_instance) == "REV_OB_ZOMBIE_STRONGHOLD") {
        if(isPlayer(eattacker) && !istrue(eattacker.var_d45cc2b767709d2d)) {
          squad = eattacker scripts\cp_mp\utility\squad_utility::getsquadmembers();

          if(squad.size == 0) {
            squad = [eattacker];
          }

          instance.activity_instance thread function_1281c7fff9456e18("zm_stronghold_destroy_cyst");

          foreach(squadmate in squad) {
            squadmate.var_d45cc2b767709d2d = 1;
          }
        }
      }
    }
  }
}

function function_a08bd3ee0d31ebd8() {
  num_small = self.var_de4d87caa90a9970;
  num_large = self.var_a4aeecf5b922b358;
  var_f35397f89190ced6 = self.var_a1dc369621f4b3b;
  var_ebd6b32ebb14f5e2 = self.var_6a12b6a1b2843943;
  self.var_15b4d0a72da5ccd4 = [];
  self.var_150be27a3d15f800 = [];
  var_524e12dc3d6a1b26 = 0;
  var_e365e58776a8ef9e = 0;

  foreach(point in var_f35397f89190ced6) {
    spawn_locs = function_3bd08a7c5eba1671(int(max(int(point.minspawn) - 4, 1)), point.origin, point.height, point.radius - 50);

    foreach(location in spawn_locs) {
      key = self.var_15b4d0a72da5ccd4.size;
      self.var_15b4d0a72da5ccd4[key] = spawnnewitemfromscriptablesharedfunc("obloot_essence_small", location, undefined, undefined, undefined, undefined, 1);
      self.var_15b4d0a72da5ccd4[key].key = key;
      var_524e12dc3d6a1b26 += 1;
    }
  }

  if(num_small > var_524e12dc3d6a1b26) {
    remaining_spawns = num_small - var_524e12dc3d6a1b26;
    index = 0;
    var_f35397f89190ced6 = utility::array_randomize(var_f35397f89190ced6);

    while(remaining_spawns > 0) {
      index_mod = index % var_f35397f89190ced6.size;
      point = var_f35397f89190ced6[index_mod];
      spawn_locs = function_3bd08a7c5eba1671(1, point.origin, point.height, point.radius);
      location = spawn_locs[0];
      key = self.var_15b4d0a72da5ccd4.size;
      self.var_15b4d0a72da5ccd4[key] = spawnnewitemfromscriptablesharedfunc("obloot_essence_small", location, undefined, undefined, undefined, undefined, 1);
      self.var_15b4d0a72da5ccd4[key].key = key;
      remaining_spawns -= 1;
      index += 1;
    }
  }

  var_ebd6b32ebb14f5e2 = utility::array_randomize(var_ebd6b32ebb14f5e2);

  foreach(point in var_ebd6b32ebb14f5e2) {
    key = self.var_150be27a3d15f800.size;
    self.var_150be27a3d15f800[key] = spawnnewitemfromscriptablesharedfunc("obloot_essence_large", point.origin, undefined, undefined, undefined, undefined, 1);
    self.var_150be27a3d15f800[key].key = key;
    var_e365e58776a8ef9e += 1;

    if(var_e365e58776a8ef9e >= num_large) {
      break;
    }
  }
}

function function_cf65031f2b7139e3() {
  self.var_d8875e62f764b801 = utility::array_randomize(self.var_d8875e62f764b801);
  self.var_b18ef82cae22792d = 0;
  function_678f2d3acbd40b11("ai_encounter:ob_aethernest_mimics", self.var_c61203960d56682a);
}

function function_fd78eacbc58cc6f() {
  self.initialdoors = [];
  self.locked_doors = [];

  if(self.var_7fe21e160de181f7.size == 0 && isDefined(self.root_struct)) {
    stronghold_structs = utility::getStructArray(self.root_struct.target, "targetname");

    foreach(struct in stronghold_structs) {
      if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "s_locked_door") {
        self.var_7fe21e160de181f7[self.var_7fe21e160de181f7.size] = struct;
      }
    }
  }

  foreach(s_locked_door in self.var_7fe21e160de181f7) {
    self.locked_doors = namespace_9e69d66f68c38a10::function_ad1b6accbaab404e(s_locked_door, self.locked_doors, "fortress", 0);
  }

  foreach(door in self.locked_doors) {
    if(istrue(door.doubledoor)) {
      door scriptabledoorfreeze(1);
    } else {
      namespace_9e69d66f68c38a10::function_fbbfe6f05eda5eb1(door);
    }

    door.fortress = self;
    door.var_def557e8fd5c6763 = &function_9f6806e422ce37b3;
  }
}

function private function_9f6806e422ce37b3(scriptable, player) {
  scriptable.fortress thread namespace_b3f32c8cb80b8124::function_e73a92bbeb2ae323();
}

function function_ce5af2f09a72177a(offsets, axes) {
  x_axis = axes["forward"];
  y_axis = axes["right"];
  z_axis = axes["up"];
  return offsets[0] * x_axis + offsets[1] * y_axis + offsets[2] * z_axis;
}

function function_eda4e16141cc6490() {
  foreach(spawner in self.var_82994cf791e27f7d) {
    spawner.scriptable = spawnscriptable("ob_aethernest_toggleable_spawner", spawner.origin, spawner.angles);
    spawner.scriptable setscriptablepartstate("state", "visible");
    spawner.num_spawns = randomintrange(1, 3);
    function_e2b7429085d664a("ai_encounter:ob_aethernest_crawlers", spawner.num_spawns, spawner);
    spawner.crawlers = [];
    spawner thread function_fd451ad57dcd0b99();
  }
}

function function_b27f0c7dafeadb3(targetlootid) {
  backpacksize = scripts\cp_mp\loot\common_inventory::function_1b35b10884bd8d67();

  for(i = 0; i < backpacksize; i++) {
    currentlootid = scripts\cp_mp\loot\common_inventory::function_d870b2c45335bd88(i);

    if(currentlootid == targetlootid) {
      return true;
    }
  }

  return false;
}

function function_c9b0c1c4babe3cb(var_d6bfa53c531546d6) {
  if(getactivitytype(self) != "REV_OB_ZOMBIE_STRONGHOLD") {
    return;
  }

  player = var_d6bfa53c531546d6.player;

  if(!isDefined(self.players_nearby)) {
    self.players_nearby = [];
  }

  if(!isDefined(self.var_441e741dad8237a6)) {
    self.var_441e741dad8237a6 = [];
  }

  var_2788abb533782ec5 = self.players_nearby;
  self.players_nearby = var_d6bfa53c531546d6.var_9f2dab34edc7e257;

  if(self.players_nearby.size > var_2788abb533782ec5.size && var_2788abb533782ec5.size == 0) {
    if(!array_contains(self.var_441e741dad8237a6, player)) {
      haskey = 1;

      if(haskey) {
        squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();

        if(squad.size == 0) {
          squad = [player];
        }

        var_8c4ed29f8594fb86 = zombie_challenges::function_f578373042c34e16(17086, "quest_s0_a3t4_springcln_start", squad);

        if(!var_8c4ed29f8594fb86) {
          var_896a02526e5df786 = ["zm_stronghold_approach_ravenov", "zm_stronghold_approach_miller", "zm_stronghold_approach_greene", "zm_stronghold_approach_barrera"];
          thread function_1281c7fff9456e18(var_896a02526e5df786[randomint(4)]);
        }

        foreach(squadmate in squad) {
          squadmate callback::callback("on_approach_zm_stronghold");
          self.var_441e741dad8237a6[self.var_441e741dad8237a6.size] = squadmate;
        }
      }
    }

    foreach(s_cyst in self.var_2319616d73f58983) {
      cyst = spawnscriptable("ob_aethernest_cyst_scriptable", s_cyst.origin, s_cyst.angles);
      cyst.s_cyst = s_cyst;
      cyst.health = s_cyst.var_c32336dbbd60b8d9;

      if(s_cyst.var_c32336dbbd60b8d9 > 0) {
        cyst.eidentifier = cyst;
        cyst.eidentifier.var_52dcdba485e7ceeb = "tag_origin";
        cyst.spawn_list = self.spawn_list;
        cyst.activity_instance = self;

        if(isDefined(s_cyst.spawner)) {
          cyst.spawner = s_cyst.spawner;
        }

        self.cysts[self.cysts.size] = cyst;
        cyst setscriptablepartstate("usable", "off");
      } else {
        cyst setscriptablepartstate("health", "ignore_damage");
        cyst setscriptablepartstate("body", "bursted");
      }

      if(!isDefined(level.ob.cysts)) {
        level.ob.cysts = [];
      }

      level.ob.cysts = array_add(level.ob.cysts, cyst);
      self.var_5eba52fdc9fb7b54[self.var_5eba52fdc9fb7b54.size] = cyst;
    }

    if(!isDefined(self.var_15b4d0a72da5ccd4)) {
      function_a08bd3ee0d31ebd8();
    } else {
      for(i = 0; i < self.var_15b4d0a72da5ccd4.size; i++) {
        if(isDefined(self.var_15b4d0a72da5ccd4[i]) && isvector(self.var_15b4d0a72da5ccd4[i])) {
          location = self.var_15b4d0a72da5ccd4[i];
          self.var_15b4d0a72da5ccd4[i] = spawnnewitemfromscriptablesharedfunc("obloot_essence_small", location, undefined, undefined, undefined, undefined, 1);
          self.var_15b4d0a72da5ccd4[i].key = i;
        }
      }

      for(i = 0; i < self.var_150be27a3d15f800.size; i++) {
        if(isDefined(self.var_150be27a3d15f800[i]) && isvector(self.var_15b4d0a72da5ccd4[i])) {
          location = self.var_150be27a3d15f800[i];
          self.var_150be27a3d15f800[i] = spawnnewitemfromscriptablesharedfunc("obloot_essence_large", location, undefined, undefined, undefined, undefined, 1);
          self.var_150be27a3d15f800[i].key = i;
        }
      }
    }

    return;
  }

  if(self.players_nearby.size == 0) {
    foreach(cyst in self.var_5eba52fdc9fb7b54) {
      if(isDefined(cyst) && isDefined(cyst.s_cyst) && isDefined(cyst.health)) {
        if(isDefined(level.ob.cysts) && array_contains(level.ob.cysts, cyst)) {
          level.ob.cysts = array_remove(level.ob.cysts, cyst);
        }

        cyst.s_cyst.var_c32336dbbd60b8d9 = cyst.health;
        cyst freescriptable();
      }
    }

    self.var_5eba52fdc9fb7b54 = [];
    self.cysts = [];

    if(isDefined(self.var_15b4d0a72da5ccd4)) {
      foreach(essence in self.var_15b4d0a72da5ccd4) {
        if(isDefined(essence) && !isvector(essence)) {
          self.var_15b4d0a72da5ccd4[essence.key] = essence.origin;
          common_item::function_c14962ea14e58968(essence);
        }
      }

      foreach(essence in self.var_150be27a3d15f800) {
        if(isDefined(essence) && !isvector(essence)) {
          self.var_150be27a3d15f800[essence.key] = essence.origin;
          common_item::function_c14962ea14e58968(essence);
        }
      }
    }
  }
}

function function_fbc94dc837737154() {
  activity_instance = self;
  activity_instance endon("activity_ended");
  activity_instance endon("instance_destroyed");
  activity_participation::function_3e33031646de23b0(self);
  thread function_3d3f2b8fc6060ed2();
  self waittill("aethernest_start");
  self.scriptable setscriptablepartstate("audio_notifications", "nest_started");
  self.started = 1;
  thread namespace_80f1ffea676eeeaa::function_a26e39e03a0d6739();
  thread namespace_b2b546ada8578eda::function_c769482a1e8c11d5();
  thread function_8e5f7aaa701e23f8();
  self waittill("nest_cleared");
  self.scriptable setscriptablepartstate("audio_notifications", "nest_cleared");
  earthquake(0.6, 1.7, self.s_center.origin, 500);
  playrumbleonposition("grenade_rumble", self.s_center.origin);
  namespace_4fda5d7358015a06::endactivity(activity_instance, 1);
}

function function_e633f9daa5bf8b8a() {
  self.spawner endon("start_spawn");
  self.spawner endon("second_threshold_reached");
  self endon("death");
  self endon("despawn");

  while(true) {
    namespace_53fc9ddbb516e6e1::animscripted_sharedfunc(self.idle_anim, "idle_end", undefined, undefined);
  }
}

function function_b77d89314204f95d() {
  self.spawner endon("start_spawn");
  self.spawner endon("second_threshold_reached");
  spawner = self.spawner;
  self waittill("death");
  spawner.crawlers = array_remove(spawner.crawlers, self);
}

function function_fd451ad57dcd0b99() {
  waittill_any_2("start_spawn", "second_threshold_reached");
  crawler = namespace_b2b546ada8578eda::function_1757c4b6ecb2e2c6(1);
  namespace_b2b546ada8578eda::function_1dd4c3b1da546151(crawler);
  crawler = namespace_b2b546ada8578eda::function_1757c4b6ecb2e2c6(2);

  if(isDefined(crawler)) {
    wait 0.45;
    namespace_b2b546ada8578eda::function_1dd4c3b1da546151(crawler);
  }

  wait 1.5;
  namespace_b2b546ada8578eda::function_21034501787df0c9();
}

function function_3d3f2b8fc6060ed2() {
  self endon("aethernest_start");
  self endon("activity_ended");
  self endon("instance_destroyed");
  var_10855db46bb1b90c = 0;

  while(true) {
    nearby_players = sortbydistancecullbyradius(level.players, self.s_center.origin, 2000);

    if(nearby_players.size > 0) {
      if(!var_10855db46bb1b90c) {
        var_10855db46bb1b90c = 1;
        function_24b55c1a13b9a63a("ai_flood_fill_encounter:jup_ob_zombie_stronghold_flood_fill_encounter_passive", undefined, self.difficulty_region, 1);
        break;
      }
    }

    wait 0.5;
  }
}

function function_9ca778648cd6e0c8(damage) {
  current_health = namespace_b2b546ada8578eda::function_9883479ef6511b80();
  prev_health = current_health + damage;

  if(prev_health >= self.first_threshold && current_health <= self.first_threshold) {
    self notify("first_threshold_reached");
    return;
  }

  if(prev_health >= self.second_threshold && current_health <= self.second_threshold) {
    self notify("second_threshold_reached");

    foreach(spawner in self.var_82994cf791e27f7d) {
      spawner notify("second_threshold_reached");
    }
  }
}

function function_8e5f7aaa701e23f8() {
  self endon("activity_ended");
  self endon("instance_destroyed");
  function_24b55c1a13b9a63a("ai_flood_fill_encounter:jup_ob_zombie_stronghold_flood_fill_encounter", undefined, self.difficulty_region, 1);
  self waittill("first_threshold_reached");
  thread wave_logic("second_threshold_reached", "wave_1", 22);
  self.scriptable setscriptablepartstate("audio_notifications", "health_threshold_1");
  earthquake(0.35, 1.7, self.s_center.origin, 500);
  playrumbleonposition("grenade_rumble", self.s_center.origin);
  self waittill("second_threshold_reached");
  thread wave_logic("nest_cleared", "wave_2", 30);
  self.scriptable setscriptablepartstate("audio_notifications", "health_threshold_2");
  earthquake(0.47, 1.7, self.s_center.origin, 500);
  playrumbleonposition("grenade_rumble", self.s_center.origin);
}

function wave_logic(endon_tag, size_tag, wait_time) {
  if(isDefined(endon_tag)) {
    self endon(endon_tag);
  }

  self endon("activity_ended");
  self endon("instance_destroyed");
  thread namespace_b2b546ada8578eda::function_b4adf91e395e53f0();

  if(isDefined(size_tag)) {
    function_24b55c1a13b9a63a("ai_encounter:jup_ob_zombie_stronghold_encounter", size_tag, self.difficulty_region);
  } else {
    function_24b55c1a13b9a63a("ai_encounter:jup_ob_zombie_stronghold_encounter");
  }

  wait wait_time;
  function_24b55c1a13b9a63a("ai_flood_fill_encounter:jup_ob_zombie_stronghold_flood_fill_encounter", undefined, self.difficulty_region, 1);
}

function function_24b55c1a13b9a63a(bundle, var_f555f0c2ce194ea8, var_4f51b9f082dab4dd, var_92190fa0ccb5e392) {
  encounter_radius = 500;
  z_clamp = 50;
  centerpoint = self.s_center.origin;
  self.encounterid = namespace_80f1ffea676eeeaa::function_f8ccadcd850da124(bundle, centerpoint, encounter_radius, 1, 1, 1, 2);

  if(isDefined(self.encounterid)) {
    if(isDefined(var_f555f0c2ce194ea8)) {
      function_d37068aac7785c04(self.encounterid, var_f555f0c2ce194ea8, 1);
    }

    if(isDefined(var_4f51b9f082dab4dd)) {
      function_d37068aac7785c04(self.encounterid, var_4f51b9f082dab4dd, 1);
    }

    namespace_80f1ffea676eeeaa::function_ce9c21523336cdbc(self.encounterid, &function_92eab905b00e7dd2, self);

    if(isDefined(var_92190fa0ccb5e392)) {
      if(var_92190fa0ccb5e392) {
        function_4b7d420e1bad897f(self.encounterid, self.var_c305d8b37977e9c9);
      }
    }
  }
}

function function_e2b7429085d664a(bundle, num_spawns, spawner) {
  centerpoint = spawner.origin;
  self.encounterid = function_f8ccadcd850da124(bundle, centerpoint, 80, 1, 1, 1, 2);

  if(isDefined(self.encounterid)) {
    function_d37068aac7785c04(self.encounterid, num_spawns, 1);
    function_ce9c21523336cdbc(self.encounterid, &function_c5417c4498aa702a, spawner);
  }
}

function function_678f2d3acbd40b11(bundle, num_spawns) {
  centerpoint = self.s_center.origin;
  self.encounterid = function_f8ccadcd850da124(bundle, centerpoint, 500, 1, 1, 1, 2);

  if(isDefined(self.encounterid)) {
    function_d37068aac7785c04(self.encounterid, num_spawns, 1);
    function_ce9c21523336cdbc(self.encounterid, &function_f65d4eb41b0a5fa3, self);
  }
}

function function_92eab905b00e7dd2(requestid, userdata, agent, data) {
  agent endon("death");

  if(isalive(agent)) {
    activityinstance = userdata;

    if(isDefined(activityinstance.last_player_attacker)) {
      agent zombie_utils::function_a047f71d0256058b(activityinstance.last_player_attacker);
    }
  }
}

function function_c5417c4498aa702a(requestid, userdata, agent, data) {
  agent endon("death");

  if(isalive(agent)) {
    data.spawnspeed = 2;
    spawner = userdata;
    crawler = agent;
    crawler val::set("idle_hang", "damage", 0);
    crawler val::set("idle_hp_bar", "show_healthbar", 0);
    crawler.activity_instance = self;
    crawler.spawner = spawner;
    crawler.idle_anim = "nest_crawler_idle_two_drop_01";
    crawler.var_7c6c1f790fad020f = 1;
    crawler visiblenotsolid();
    crawler thread function_e633f9daa5bf8b8a();
    crawler thread function_b77d89314204f95d();
    spawner.crawlers[spawner.crawlers.size] = crawler;
    crawler ent_flag_wait("zombie_asm_init_finished");

    if(!isDefined(crawler.animname)) {
      crawler.animname = crawler.animsetname;
    }
  }
}

function function_f65d4eb41b0a5fa3(requestid, userdata, agent, data) {
  agent endon("death");

  if(isalive(agent)) {
    activityinstance = userdata;

    if(activityinstance.var_b18ef82cae22792d < activityinstance.var_d8875e62f764b801.size) {
      point = activityinstance.var_d8875e62f764b801[activityinstance.var_b18ef82cae22792d];
      activityinstance.var_b18ef82cae22792d += 1;

      if(isDefined(point)) {
        namespace_f35b248fe3d46dfb::function_7f3bb3916bbd189d([point], agent, undefined, point.proplist, &function_dc12df4bf3fedd5b);
      }
    }
  }
}

function function_2f109c081d5fd179(obj) {
  if(isDefined(obj)) {
    obj delete();
  }
}

function function_7b8f4f5e1fbe30d5() {
  var_cc7aa96a854fd8ee = spawnStruct();
  var_cc7aa96a854fd8ee.origin = self.s_center.origin;
  var_cc7aa96a854fd8ee.angles = self.s_center.angles;
}

function function_c1cb9b8f30cff8c6(var_b381b0883bcd4847) {
  player_list = var_b381b0883bcd4847.playerlist;
  var_a83ac3549acc2da2 = var_b381b0883bcd4847.playerjoinreason;
}

function function_7208e454d9a1452e(var_b381b0883bcd4847) {
  player_list = var_b381b0883bcd4847.playerlist;

  foreach(player in player_list) {
    if(isPlayer(player)) {
      if(isDefined(self) && self.state != "EndedState") {
        player function_4a508fcbbea05afd();
      }

      player notify("left_aethernest");
    }
  }
}

function function_4a508fcbbea05afd() {
  self endon("death_or_disconnect");
  wait 120;
  player = self;

  if(function_5acc35fc66331385(player, 17086)) {
    player ent_flag_clear("quest_s0_a3t4_springcln_start");
  }
}

function function_2a6a959fd054e401(activity_succeeded) {
  self endon("instance_destroyed");
  thread namespace_80f1ffea676eeeaa::function_a26e39e03a0d6739();
  namespace_b2b546ada8578eda::function_45addf4a995d163(self.var_f683875f2e47f6bc);

  foreach(player in self.playerparticipants) {
    squadmembers = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
    var_8c4ed29f8594fb86 = zombie_challenges::function_f578373042c34e16(17086, "quest_s0_a3t4_springcln_success", squadmembers);

    if(!var_8c4ed29f8594fb86) {
      if(percent_chance(50)) {
        convos = ["zm_stronghold_clear_ravenov_miller", "zm_stronghold_clear_ravenov_greene", "zm_stronghold_clear_ravenov_barrera"];
        thread function_1281c7fff9456e18(convos[randomint(3)], [player]);
        continue;
      }

      thread function_1281c7fff9456e18("zm_stronghold_clear_ravenov_noresp", [player]);
    }
  }

  namespace_bd7428f3122be80f::function_c402ecda1e84ba27(self.playerparticipants, 0, self.difficulty_region, self.s_center.origin);
  powerups::powerup_drop("full_ammo", getclosestpointonnavmesh(self.s_center.origin) + (0, 0, 30));

  foreach(mound in self.mounds) {
    if(isDefined(mound)) {
      mound setscriptablepartstate("state", "dead");
    }
  }

  foreach(cache in self.lootcaches) {
    foreach(player in level.players) {
      cache enablescriptableplayeruse(player);
    }

    cache setscriptablepartstate("body", "closed_usable");
  }

  if(isDefined(self.scriptable)) {
    self.scriptable freescriptable();
  }

  if(isDefined(self.gas_array)) {
    foreach(gas in self.gas_array) {
      gas setscriptablepartstate("state", "hidden");
    }
  }

  if(isDefined(self.gas_vfx)) {
    foreach(vfx in self.gas_vfx) {
      function_2f109c081d5fd179(vfx);
    }
  }
}

function function_89bdb2d03896122b() {
  self endon("instance_destroyed");
  self notify("aethernest_cease");
  thread namespace_80f1ffea676eeeaa::function_a26e39e03a0d6739();

  if(isDefined(self.var_f683875f2e47f6bc)) {
    namespace_b2b546ada8578eda::function_45addf4a995d163(self.var_f683875f2e47f6bc);
  }

  if(isDefined(self.mounds)) {
    foreach(mound in self.mounds) {
      if(isDefined(mound)) {
        mound freescriptable();
      }
    }
  }

  if(isDefined(self.prop_array)) {
    foreach(prop in self.prop_array) {
      prop setscriptablepartstate("state", "hidden");
    }
  }

  if(isDefined(self.lootcaches)) {
    foreach(cache in self.lootcaches) {
      cache freescriptable();
    }
  }

  if(isDefined(self.gas_vfx)) {
    foreach(vfx in self.gas_vfx) {
      function_2f109c081d5fd179(vfx);
    }
  }

  if(isDefined(self.var_82994cf791e27f7d)) {
    foreach(spawner in self.var_82994cf791e27f7d) {
      if(isDefined(spawner.scriptable)) {
        spawner.scriptable freescriptable();
      }
    }
  }

  if(isDefined(self.var_5eba52fdc9fb7b54)) {
    foreach(cyst in self.var_5eba52fdc9fb7b54) {
      cyst freescriptable();
    }
  }

  if(isDefined(self.scriptable)) {
    self.scriptable freescriptable();
  }
}

function function_3bd08a7c5eba1671(num_points, cylinder_origin, cylinder_height, outer_radius, inner_radius, use_throttle, begin_yaw, end_yaw) {
  level endon("game_ended");
  spawn_points = [];
  use_throttle = utility::default_to(use_throttle, 1);
  throttle_count = 0;
  backup_points = [];

  for(i = 0; i < num_points; i++) {
    failed_attempts = 0;

    while(failed_attempts < 5) {
      cylinder_height = 10;
      disk_center = cylinder_origin + (0, 0, cylinder_height);
      random_point = math::function_e70fb12ac4e8f91b(disk_center, outer_radius, inner_radius, begin_yaw, end_yaw);
      ground_point = utility::function_114e5c055b13dacf(random_point, cylinder_height);

      if(backup_points.size == 0) {
        backup_points[backup_points.size] = random_point;
      }

      if(isDefined(ground_point)) {
        spawn_points[spawn_points.size] = ground_point;
        break;
      } else {
        failed_attempts++;
      }

      if(use_throttle) {
        throttle_count++;

        if(throttle_count % 3 == 0) {
          waitframe();
        }
      }
    }
  }

  if(spawn_points.size == 0) {
    return backup_points;
  }

  return spawn_points;
}

function function_dc12df4bf3fedd5b() {
  prop_height = (0, 0, 64);
  players = player_utility::getplayersinradius(self.origin, 100);

  if(players.size) {
    foreach(player in players) {
      if(!isalive(player)) {
        continue;
      }

      if(istrue(player.ignoreme) || istrue(player.inlaststand)) {
        continue;
      }

      if(getdvarint(@ "hash_821690ed248715f7", 0)) {
        sphere(player.origin, 20, (0, 1, 0), 0, 1, 1);
      }

      if(isDefined(player.last_valid_position) && isDefined(self.navmesh_position)) {
        if(!trace::ray_trace_passed(player.last_valid_position, self.navmesh_position, [self], trace::create_default_contents(1))) {
          if(getdvarint(@ "hash_821690ed248715f7", 0)) {
            line(player.last_valid_position, self.navmesh_position, (0, 1, 1), 1, 0, 1);
            sphere(self.navmesh_position, 20, (1, 0, 0), 0, 1, 1);
          }

          continue;
        }
      } else {
        player_center = player gettagorigin("j_spine4");
        player_center = utility::default_to(player_center, player getcentroid());

        if(isDefined(player_center) && !sighttracepassed(self.origin + prop_height, player_center, 0, self)) {
          if(getdvarint(@ "hash_821690ed248715f7", 0)) {
            line(self.origin + prop_height, player gettagorigin("<dev string:x1c>"), (1, 1, 0), 1, 0, 1);
          }

          continue;
        }
      }

      traceresult = playerphysicstrace(self.origin + (0, 0, 20), player.origin + (0, 0, 36), player, undefined, self, 1);

      if(traceresult["fraction"] >= 1) {
        self notify("stop_shake_tell");
        return player;
      }

      if(getdvarint(@ "hash_821690ed248715f7", 0)) {
        line(self.origin + (0, 0, 8), player.origin + (0, 0, 8), (1, 0, 0), 1, 0, 1);
        sphere(traceresult["<dev string:x28>"], 4, (1, 0, 0), 1, 0, 10, 1);
      }
    }
  }
}

function function_8af75525d37866eb(params) {
  var_5e922aa9baf90c9 = params.item;

  if(!isDefined(var_5e922aa9baf90c9)) {
    assertmsg("<dev string:x34>" + "<dev string:x92>");
    return;
  }

  var_f064f548b129ddb1 = params.itembundlename;

  if(!isDefined(var_f064f548b129ddb1)) {
    assertmsg("<dev string:xd5>" + "<dev string:x133>");
    return;
  }

  var_e476492a3c0a252a = getscriptbundle("itemspawnentry:" + var_f064f548b129ddb1);

  if(!isDefined(var_e476492a3c0a252a)) {
    assertmsg("<dev string:x15f>" + var_f064f548b129ddb1 + "<dev string:x1ad>");
    return;
  }

  if(var_f064f548b129ddb1 == "ob_jup_item_keycard") {
    squad = scripts\cp_mp\utility\squad_utility::getsquadmembers();

    if(squad.size == 0) {
      squad = [self];
    }

    foreach(squadmate in squad) {
      squadmate.var_2e3a9190f3171a15 = 1;
    }
  }
}