/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_29b50ff5f1477a5d.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_185660037b9236c1;
#using script_220d0eb95a8fab7d;
#using script_3ab210ea917601e7;
#using script_41387eecc35b88bf;
#using script_4a6760982b403bad;
#using script_54be039c89fddc12;
#using script_5753ba9c28794a65;
#using script_5d8202968463a21d;
#using script_638d701d263ee1ed;
#using script_64351208cb856df9;
#using script_6df6604a74a7a9c7;
#using script_77be8cd2b6610d5;
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
#using scripts\cp_mp\armor;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\gasmask;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\killstreaks\white_phosphorus;
#using scripts\cp_mp\loot\common_cache;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\mp_agent_damage;
#using scripts\ob\points;
#namespace namespace_b2b546ada8578eda;

function function_cf070c7d20b69e36() {
  function_89384091f7a2dbd("REV_OB_AETHERNEST", 0, &function_ed03dff524b1f1ec);
  function_89384091f7a2dbd("REV_OB_AETHERNEST", 1, &function_af2f8c2f34b7292c);
  function_89384091f7a2dbd("REV_OB_AETHERNEST", 2, &function_5c710295d42036e9);
  function_89384091f7a2dbd("REV_OB_AETHERNEST", 3, &function_38736a058eca7b23);
  function_89384091f7a2dbd("REV_OB_AETHERNEST", 5, &function_f2842b850f8fed3b);
  function_8b5b2a3392fc7e2a("PlayerJoin", &function_43705e033b99948e, "REV_OB_AETHERNEST");
  function_8b5b2a3392fc7e2a("PlayerLeave", &function_f9b067b93ae7bb66, "REV_OB_AETHERNEST");

  if(!isDefined(level.var_96a2d0c3a5256c2)) {
    function_96a2d0c3a5256c2();
    level.var_96a2d0c3a5256c2 = 1;
  }
}

function function_96a2d0c3a5256c2() {
  scripts\engine\scriptable::scriptable_adddamagedcallback(&function_e9836f11aaedad08);
}

function function_ed03dff524b1f1ec() {
  activity_instance = self;
  activity_instance endon("activity_ended");
  activity_instance endon("instance_destroyed");
  activityvariantdefinition = function_4188e118731a30f4();
  self.variant_definition = activityvariantdefinition;
  self.s_center = getStruct(self.varianttag, "targetname");
  self.difficulty_region = namespace_4df2ab39b0e96ec7::function_4d8bb2d866771a10(self.s_center.origin);

  switch (self.difficulty_region) {
    case #"hash_651f76c0ad6741ec":
      self.var_67d58bcaf37c2e2b = 3800;
      self.var_c305d8b37977e9c9 = 6;
      self.var_b775d3fc5973f7ac = 10;
      self.spawn_list = "ob_jup_items_activity_aethernest_red";
      break;
    case #"hash_5343b465e56ec9a4":
      self.var_67d58bcaf37c2e2b = 3125;
      self.var_c305d8b37977e9c9 = 5;
      self.var_b775d3fc5973f7ac = 9;
      self.spawn_list = "ob_jup_items_activity_aethernest_orange";
      break;
    case #"hash_af83e47edfa8900a":
      self.var_67d58bcaf37c2e2b = 1800;
      self.var_c305d8b37977e9c9 = 4;
      self.var_b775d3fc5973f7ac = 7;
      self.spawn_list = "ob_jup_items_activity_aethernest_yellow";
      break;
    case #"hash_7bb2cd766703d463":
    default:
      self.var_67d58bcaf37c2e2b = 900;
      self.var_c305d8b37977e9c9 = 3;
      self.var_b775d3fc5973f7ac = 5;
      self.difficulty_region = "difficulty_easy";
      self.spawn_list = "ob_jup_items_activity_aethernest_green";
      break;
  }

  self.floor_count = 1;
  level._effect["smoke_effect_1"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_aether_cyst_spore_area_500.vfx");
  level._effect["smoke_effect_4"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_aether_cyst_spore_vent_release.vfx");
  level._effect["camera_vfx"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_aether_cyst_spore_area_camera.vfx");
  function_b9c12dbbc627c840();
  self.var_f683875f2e47f6bc = [];
  self.crawlers = [];
  self.var_ec031f5af338bc24 = self.var_67d58bcaf37c2e2b;
  self.first_threshold = self.var_67d58bcaf37c2e2b * 0.666667;
  self.second_threshold = self.var_67d58bcaf37c2e2b * 0.333333;
  function_c2f1ea19349c995e();
  function_1055046bfeb8d74d();
  self.var_2319616d73f58983 = function_b25446edb490c05f(self.var_a0fa0c27dc0dbab1, self.var_b775d3fc5973f7ac);

  foreach(s_cyst in self.var_2319616d73f58983) {
    s_cyst.var_c32336dbbd60b8d9 = int(self.var_67d58bcaf37c2e2b / self.var_2319616d73f58983.size);
  }

  self.cysts = [];
  self.var_5eba52fdc9fb7b54 = [];
  self.var_e171f154ea4ec2c8 = 0;
  self.var_3b4e070a9fbc7044 = [];
  namespace_8480efeffcd6e233::function_2dac62aa2032b9b1("SpatialZoneContainerGroup_ActivityInstance_AwarenessZone", &function_92e06b144888d213);
  self.started = 0;
  function_b6fc2c96b463c007(self);
}

function function_92e06b144888d213(var_d6bfa53c531546d6) {
  if(getactivitytype(self) != "REV_OB_AETHERNEST") {
    return;
  }

  if(!isDefined(self.players_nearby)) {
    self.players_nearby = [];
  }

  var_2788abb533782ec5 = self.players_nearby;
  self.players_nearby = var_d6bfa53c531546d6.var_9f2dab34edc7e257;

  if(self.players_nearby.size > var_2788abb533782ec5.size && var_2788abb533782ec5.size == 0) {
    switch (getmapname()) {
      case #"hash_224f194c88e9eac":
      case #"hash_330a93d145b37045":
      case #"hash_d7741d09a5c36348":
        var_b02d13c9b463922c = 1;
        break;
      default:
        var_b02d13c9b463922c = 0;
        break;
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
        self.cysts[self.cysts.size] = cyst;
        cyst setscriptablepartstate("usable", "off");

        if(var_b02d13c9b463922c) {
          cyst setscriptablepartstate("body", "pristine_rift_run");
        }
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

    return;
  }

  if(self.players_nearby.size == 0) {
    foreach(cyst in self.var_5eba52fdc9fb7b54) {
      if(isDefined(cyst) && isDefined(cyst.s_cyst) && isDefined(cyst.health)) {
        cyst.s_cyst.var_c32336dbbd60b8d9 = cyst.health;

        if(isDefined(level.ob.cysts) && array_contains(level.ob.cysts, cyst)) {
          level.ob.cysts = array_remove(level.ob.cysts, cyst);
        }

        cyst freescriptable();
      }
    }

    self.var_5eba52fdc9fb7b54 = [];
    self.cysts = [];
    self.var_2090e50657f45b8a = 0;
  }
}

function function_ce5af2f09a72177a(offsets, axes) {
  x_axis = axes["forward"];
  y_axis = axes["right"];
  z_axis = axes["up"];
  return offsets[0] * x_axis + offsets[1] * y_axis + offsets[2] * z_axis;
}

function function_b25446edb490c05f(var_a649f057274db819, num_spawns) {
  buckets = [];
  var_8a2272f39e290538 = [];

  foreach(struct in var_a649f057274db819) {
    if(isDefined(struct.script_noteworthy)) {
      if(!isDefined(buckets[struct.script_noteworthy])) {
        buckets[struct.script_noteworthy] = [];
        var_8a2272f39e290538[var_8a2272f39e290538.size] = struct.script_noteworthy;
      }

      buckets[struct.script_noteworthy][buckets[struct.script_noteworthy].size] = struct;
    }
  }

  if(var_8a2272f39e290538.size > 0) {
    var_8a2272f39e290538 = array_randomize(var_8a2272f39e290538);
    var_a23d7a44b71c7bc1 = [];
    i = 0;
    var_1f516aa1cb36eb04 = min(num_spawns, var_a649f057274db819.size);

    while(var_a23d7a44b71c7bc1.size < var_1f516aa1cb36eb04) {
      key_index = i % var_8a2272f39e290538.size;

      if(buckets[var_8a2272f39e290538[key_index]].size > 0) {
        random_selection = array_random(buckets[var_8a2272f39e290538[key_index]]);
        buckets[var_8a2272f39e290538[key_index]] = array_remove(buckets[var_8a2272f39e290538[key_index]], random_selection);
        var_a23d7a44b71c7bc1[var_a23d7a44b71c7bc1.size] = random_selection;
      }

      i += 1;
    }

    return var_a23d7a44b71c7bc1;
  }

  return array_slice(array_randomize(var_a649f057274db819), 0, num_spawns);
}

function function_1055046bfeb8d74d() {
  var_4f0815c18c21f38b = getStructArray(self.varianttag, "target");
  self.var_3b71feeee7e739e1 = undefined;
  self.var_48870c486fffdeb2 = [];
  self.var_91d27f052acb9f09 = [];
  self.var_a0fa0c27dc0dbab1 = [];
  self.s_loot_cache_spawn = undefined;
  var_46a4ac8d6a98d672 = ["patch1", "patch2", "patch3", "patch4", "root1", "root2", "root3"];
  var_2e022fb2a196ab4 = ["jup_foliage_tree_roots_01", "t10_terrain_redacted_ground_patch_04", "t10_terrain_redacted_ground_patch_03", "jup_foliage_tree_roots_02", "ee_foliage_tree_spruce_01_debris_l_roots", "ee_foliage_tree_spruce_01_debris_k_roots", "ee_foliage_tree_spruce_01_debris_m_roots"];
  var_4a21f2ea02343335 = 20;

  for(index = 0; index < var_4f0815c18c21f38b.size; index++) {
    if(index % var_4a21f2ea02343335 == 0) {
      waitframe();
    }

    struct = var_4f0815c18c21f38b[index];

    if(!isDefined(struct.targetname)) {
      continue;
    } else if(struct.targetname == "ceiling_spawner") {
      self.var_3b71feeee7e739e1 = struct;
      continue;
    } else if(struct.targetname == "ceiling_zombie") {
      self.var_48870c486fffdeb2[self.var_48870c486fffdeb2.size] = struct;
      continue;
    } else if(struct.targetname == "s_cyst_spawn") {
      self.var_a0fa0c27dc0dbab1[self.var_a0fa0c27dc0dbab1.size] = struct;
      continue;
    } else if(struct.targetname == "s_loot_cache_spawn") {
      self.s_loot_cache_spawn = struct;
      continue;
    }

    if(!isDefined(self.var_91d27f052acb9f09[struct.targetname])) {
      self.var_91d27f052acb9f09[struct.targetname] = [];
    }

    self.var_91d27f052acb9f09[struct.targetname][self.var_91d27f052acb9f09[struct.targetname].size] = struct;
  }

  if(isDefined(self.s_loot_cache_spawn)) {
    cache = common_cache::cache_spawncache(#"hash_ee41a7fa562ce499", self.s_loot_cache_spawn.origin, self.s_loot_cache_spawn.angles);
    mound = spawnscriptable("ob_aethernest_toggleable_cover", self.s_loot_cache_spawn.origin, self.s_loot_cache_spawn.angles);
    mound setscriptablepartstate("state", "visible_large_hint");
    mound scripts\cp_mp\interaction::function_98fc2e3f04194a50(&function_ea0d2f50c264d5ef);
    self.cache = cache;
    self.cache_cover = mound;
    waitframe();

    foreach(player in level.players) {
      cache disablescriptableplayeruse(player);
    }
  }

  waitframe();

  if(isDefined(self.var_3b71feeee7e739e1)) {
    self.var_3b71feeee7e739e1.scriptable = spawnscriptable("ob_aethernest_toggleable_spawner", self.var_3b71feeee7e739e1.origin, self.var_3b71feeee7e739e1.angles);
    self.var_3b71feeee7e739e1.scriptable setscriptablepartstate("state", "visible");
    self.num_spawns = randomintrange(1, 3);
    function_e2b7429085d664a("ai_encounter:ob_aethernest_crawlers", self.num_spawns);
  }
}

function function_ea0d2f50c264d5ef(scriptable, player) {
  return false;
}

function function_c2f1ea19349c995e() {
  if(isDefined(self.s_center.target)) {
    root_structs = getStructArray(self.s_center.target, "targetname");
    self.root_struct = getclosest(self.s_center.origin, root_structs, 1000);

    if(isDefined(self.root_struct)) {
      radius = float(default_to(self.s_center.script_noteworthy, 600));
      self.prop_array = getentitylessscriptablearray(self.root_struct.target, "targetname", self.s_center.origin, radius);
      self.gas_array = [];

      foreach(prop in self.prop_array) {
        prop setscriptablepartstate("state", "visible");

        if(issubstr(prop.classname, "gas")) {
          self.gas_array[self.gas_array.size] = prop;
        }
      }
    }
  }
}

function function_b9c12dbbc627c840() {
  trigger_volumes = getnoentvolumearray("aethernest_interior_trigger", "targetname");
  self.var_83116f41aad4fc96 = trigger_volumes;
  self.var_1258379e7ea78440 = [];

  foreach(trigger_volume in trigger_volumes) {
    if(is_equal(trigger_volume.target, self.varianttag)) {
      trigger_volume thread function_e94bfecc4848adc(self);
    }
  }

  thread function_82440f5119dba754();
}

function function_e94bfecc4848adc(instance) {
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

      player.var_ce51e639071849f = gettime();

      if(!array_contains(instance.var_1258379e7ea78440, player)) {
        instance.var_1258379e7ea78440 = function_6d6af8144a5131f1(instance.var_1258379e7ea78440, player);
        player thread function_950d1ee4567388cb(self, instance);
      } else if(array_contains(instance.var_1258379e7ea78440, player) && !istrue(player.var_7bf8710b8f268d67)) {
        player thread function_950d1ee4567388cb(self, instance);
      }
    }

    var_91e59e745cfdf8a5 = function_e1b3ae526db82c88(instance);

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

function function_e1b3ae526db82c88(activityinstance) {
  var_74cd31da10a00e02 = [];
  players_nearby = namespace_4c2b495b8d79cc2e::function_7ec62d1550b9897e(activityinstance, "Awareness_Zone");

  foreach(player in players_nearby) {
    if(player istouching(self)) {
      var_74cd31da10a00e02[var_74cd31da10a00e02.size] = player;
    }
  }

  return var_74cd31da10a00e02;
}

function function_b320ab2e583e71f2(trigger, instance) {
  instance endon("activity_ended");
  instance endon("instance_destroyed");
  instance endon("aethergas_cleared");
  self endon("aethergas_exited");

  while(true) {
    trigger waittill("trigger", ent);

    if(is_equal(ent, self)) {
      self.var_ce51e639071849f = gettime();
    }

    wait 0.1;
  }
}

function function_af2f8c2f34b7292c() {
  activity_instance = self;
  activity_instance endon("activity_ended");
  activity_instance endon("instance_destroyed");
  function_3e33031646de23b0(self);
  thread function_3d3f2b8fc6060ed2();
  thread function_bde54847b120dfb5();
  self waittill("aethernest_start");
  thread namespace_277c27ef297ef569::function_1281c7fff9456e18("activity_aethernest_damaged");
  playsoundeventonplayers("snd_aethernest_start", self.playerparticipants);
  thread function_f62fd3496b0a06e8();
  self.started = 1;
  thread function_a26e39e03a0d6739();
  thread function_c769482a1e8c11d5();
  thread function_8e5f7aaa701e23f8();
  self waittill("nest_cleared");
  playsoundeventonplayers("snd_aethernest_cleared", self.playerparticipants);
  earthquake(0.6, 1.7, self.s_center.origin, 500);
  playrumbleonposition("grenade_rumble", self.s_center.origin);
  endactivity(activity_instance, 1);
}

function function_9f61ce12bbb16cac() {
  self.activity_instance endon("aethernest_start");
  self endon("death");
  self endon("despawn");

  while(true) {
    namespace_53fc9ddbb516e6e1::animscripted_sharedfunc(self.idle_anim, "idle_end", undefined, undefined);
  }
}

function function_77e6043e861fdb3b() {
  self.activity_instance endon("aethernest_start");
  activity_instance = self.activity_instance;
  self waittill("death");
  activity_instance.crawlers = array_remove(activity_instance.crawlers, self);
}

function function_f62fd3496b0a06e8() {
  if(isDefined(self.var_3b71feeee7e739e1)) {
    crawler = function_1757c4b6ecb2e2c6(1);
    function_1dd4c3b1da546151(crawler);
    crawler = function_1757c4b6ecb2e2c6(2);

    if(isDefined(crawler)) {
      wait 0.45;
      function_1dd4c3b1da546151(crawler);
    }

    wait 1.5;
    function_21034501787df0c9();
  }
}

function function_1757c4b6ecb2e2c6(count) {
  foreach(crawler in self.crawlers) {
    if(isalive(crawler)) {
      count -= 1;

      if(count == 0) {
        return crawler;
      }
    }
  }
}

function function_1dd4c3b1da546151(crawler) {
  if(isalive(crawler)) {
    crawler thread namespace_53fc9ddbb516e6e1::animscripted_sharedfunc("spawn_nest_crawler_single", "spawn_end", undefined, undefined);
    crawler val::reset("idle_hang", "damage");
    crawler val::reset("idle_hp_bar", "show_healthbar");
    crawler.var_7c6c1f790fad020f = 0;
    crawler visiblesolid();
    self.crawlers = array_remove(self.crawlers, crawler);
    crawler.dropped = 1;
  }
}

function function_21034501787df0c9() {
  foreach(crawler in self.crawlers) {
    if(isalive(crawler)) {
      if(istrue(crawler._blackboard.animscriptedactive) && !istrue(crawler.dropped)) {
        function_1dd4c3b1da546151(crawler);
        wait 0.45;
      }
    }
  }
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
        function_24b55c1a13b9a63a("ai_flood_fill_encounter:ob_aethernest_passive_flood_fill_encounter", undefined, self.difficulty_region);
        break;
      }
    }

    wait 0.5;
  }
}

function function_bde54847b120dfb5() {
  self endon("aethernest_start");
  self endon("activity_ended");
  self endon("instance_destroyed");
  var_10855db46bb1b90c = 0;

  while(true) {
    nearby_players = sortbydistancecullbyradius(level.players, self.s_center.origin, 500);

    if(nearby_players.size > 0) {
      if(!var_10855db46bb1b90c) {
        var_10855db46bb1b90c = 1;

        if(isalive(nearby_players[0])) {
          params = spawnStruct();
          params.player = nearby_players[0];
          params.player callback::callback("aethernest_approach", params);
        }

        break;
      }
    }

    wait 0.5;
  }
}

function function_280292a937210629(players) {
  foreach(player in players) {
    player setscriptablepartstate("nest_fx", "on", 0);
  }
}

function function_45addf4a995d163(players) {
  foreach(player in players) {
    if(isDefined(player) && isalive(player)) {
      player setscriptablepartstate("nest_fx", "off", 0);
    }
  }
}

function function_4ae44d09c29841c9(activity_instance) {
  activity_instance endon("aethernest_start");
  activity_instance endon("aethernest_cease");
  activity_instance endon("activity_ended");
  activity_instance endon("instance_destroyed");

  while(true) {
    wait randomfloat(10);
    thread function_155971201d58c7dc("aethernest_cyst_gas_expel");
    wait 15;
  }
}

function function_82440f5119dba754() {
  self endon("activity_ended");
  self endon("instance_destroyed");
  self endon("aethergas_cleared");

  while(true) {
    exit_buffer = ter_op(self.var_1258379e7ea78440.size > 8, 400, 200);

    foreach(player in self.var_1258379e7ea78440) {
      if(isPlayer(player) && isDefined(player.var_ce51e639071849f) && gettime() - player.var_ce51e639071849f > exit_buffer) {
        var_7b24f88f7b6ff5da = player getistouchingentities(self.var_83116f41aad4fc96);

        if(var_7b24f88f7b6ff5da.size == 0) {
          player thread function_b006b89a63144ac5(self);
        }
      }
    }

    wait 0.1;
  }
}

function function_950d1ee4567388cb(trigger, activity_instance) {
  self endon("death");
  self endon("aethergas_cleared");
  self endon("aethergas_exited");
  thread function_25dfef63d653d7ca();
  scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudio();
  function_280292a937210629([self]);

  if(scripts\cp_mp\gasmask::hasgasmask(self)) {
    if(!namespace_8055140764bdf2f4::function_aeffe7dc479451ad()) {
      if(isDefined(level.var_f26b4e7eb9af8155)) {
        self[[level.var_f26b4e7eb9af8155]]("aether_gas");
      } else if(!istrue(self.gasmaskequipped)) {
        self notify("toggle_gasmask");
      }
    }
  }

  wait 1;

  while(true) {
    if(istrue(self.gasmaskequipped)) {
      scripts\cp_mp\gasmask::processdamage(3.6);
    } else {
      self dodamage(3.6, self.origin, self, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
      scripts\cp_mp\armor::damagearmor(3.6, undefined, self, "MOD_TRIGGER_HURT");

      if(scripts\cp_mp\gasmask::hasgasmask(self)) {
        scripts\cp_mp\gasmask::processdamage(3.6);
      }
    }

    if(!istrue(self.gasmaskequipped)) {
      if(scripts\cp_mp\gasmask::hasgasmask(self)) {
        if(!namespace_8055140764bdf2f4::function_aeffe7dc479451ad()) {
          if(isDefined(level.var_f26b4e7eb9af8155)) {
            self[[level.var_f26b4e7eb9af8155]]("aether_gas");
          }
        }
      } else if(loopingcoughaudioissupressed()) {
        scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudiosupression();
      }
    }

    wait 1.6;
  }
}

function function_25dfef63d653d7ca() {
  self endon("disconnect");
  self.var_7bf8710b8f268d67 = 1;
  self waittill("death");
  self.var_7bf8710b8f268d67 = 0;
}

function function_b006b89a63144ac5(activity_instance) {
  self notify("aethergas_exited");
  scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudio();
  scripts\cp_mp\killstreaks\white_phosphorus::clearloopingcoughaudio();
  function_45addf4a995d163([self]);

  if(isDefined(activity_instance)) {
    activity_instance.var_1258379e7ea78440 = array_remove(activity_instance.var_1258379e7ea78440, self);
  }

  if(istrue(self.gasmaskequipped) || istrue(self.gasmaskswapinprogress) && !istrue(self.gasmaskequipped)) {
    if(isDefined(level.var_c57ee1e174e42601)) {
      self[[level.var_c57ee1e174e42601]]("aether_gas");
      return;
    }

    self notify("toggle_gasmask");
  }
}

function function_b4e25f2d73c0223b(idamage) {
  return int(max(idamage, 500));
}

function function_e9836f11aaedad08(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  if(!is_equal(instance.type, "ob_aethernest_cyst_scriptable") || istrue(instance.destroyed)) {
    return;
  }

  if(isDefined(instance.playerusing)) {
    return;
  }

  if(isDefined(instance.spawner)) {
    instance.spawner notify("start_spawn");
  }

  if(weapon::iswonderweapon(objweapon)) {
    idamage = function_b4e25f2d73c0223b(idamage);
  }

  if(isDefined(instance.health)) {
    instance.health -= idamage;

    if(isPlayer(eattacker)) {
      instance.var_f49149402765ecae = function_6d6af8144a5131f1(instance.var_f49149402765ecae, eattacker);

      if(scripts\mp\mp_agent_damage::function_87c3b43d00319847()) {
        scripts\mp\mp_agent_damage::function_c54b2cc2e762c201(eattacker, instance.eidentifier, "none", smeansofdeath, objweapon, int(idamage), undefined, 0, undefined, 0, 0);
      }

      eattacker scripts\cp_mp\damagefeedback::updatehitmarker("standard", instance.health <= 0, 0, 0, undefined);

      if(!array_contains(instance.activity_instance.playerparticipants, eattacker)) {
        function_bbdcd857d0c2a65e(instance.activity_instance, eattacker);
      }
    }

    instance.activity_instance.last_player_attacker = eattacker;

    if(!instance.activity_instance.started) {
      instance.activity_instance notify("aethernest_start");
    }

    instance.activity_instance function_9ca778648cd6e0c8(idamage);

    if(instance.health <= 0) {
      eattacker scripts\ob\points::function_ddee59d6b1a2b9e(#"hash_626189d6229d39b4");
      instance thread function_155971201d58c7dc("aethernest_cyst_gas_burst");
      instance.destroyed = 1;
      instance setscriptablepartstate("usable", "off");
      params = spawnStruct();
      params.player = eattacker;
      params.cyst = instance;
      eattacker callback::callback("aethernest_cyst_destroyed", params);

      if(isDefined(instance.spawningsquad) && !isDefined(instance.var_26fd9d9c73229afe)) {
        instance.activity_instance.var_2090e50657f45b8a = 0;
      }

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

      return;
    }

    if(isDefined(instance.activity_instance.var_3b4e070a9fbc7044) && !istrue(instance.activity_instance.var_2090e50657f45b8a) && !array_contains(instance.activity_instance.var_3b4e070a9fbc7044, eattacker) && isDefined(level.var_d0ae7d85b0070ba0) && [[level.var_d0ae7d85b0070ba0]](eattacker) && namespace_28253c2ed4569abd::get_element(objweapon, eattacker, smeansofdeath) == "toxic") {
      function_60302fa0d978c62b(instance, eattacker);
    }
  }
}

function function_60302fa0d978c62b(scriptable, player) {
  scriptable setscriptablepartstate("body", "rift_gate_quest_model");
  scriptable setscriptablepartstate("usable", "on");
  scripts\cp_mp\interaction::function_32645103f7520635(scriptable, &function_5251088e615017c5, undefined, &function_a71cfebe6cfde69b);
  scriptable scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_d3af10ea2f04c99b);
  scriptable.activity_instance.var_2090e50657f45b8a = 1;
  scriptable.spawningsquad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
}

function function_a71cfebe6cfde69b(player) {
  if(isDefined(self.playerusing) && self.playerusing != player) {
    return;
  }

  player endon("interaction_complete");
  player endon("death");
  self.playerusing = player;

  while(player useButtonPressed()) {
    waitframe();
  }

  self.playerusing = undefined;
}

function function_d3af10ea2f04c99b(interact, player) {
  if(isDefined(interact.playerusing) && interact.playerusing != player || !array_contains(interact.spawningsquad, player)) {
    return {
      #string: &"", #type: "HINT_NOBUTTON"};
  }

  return {
    #string: &"JUP_OB_S1/RIFT_GATE_QUEST_CYST_INTERACT_HINT", #type: "HINT_BUTTON"};
}

function function_5251088e615017c5(player) {
  self.spawningsquad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
  player notify("interaction_complete");
  self.var_26fd9d9c73229afe = player;
  self.playerusing = undefined;
  self.health = 0;
  player scripts\ob\points::function_ddee59d6b1a2b9e(#"hash_626189d6229d39b4");
  thread function_155971201d58c7dc("aethernest_cyst_gas_burst");
  self.destroyed = 1;
  self setscriptablepartstate("usable", "off");
}

function function_9ca778648cd6e0c8(damage) {
  current_health = function_9883479ef6511b80();
  prev_health = current_health + damage;

  if(prev_health >= self.first_threshold && current_health <= self.first_threshold) {
    self notify("first_threshold_reached");
    return;
  }

  if(prev_health >= self.second_threshold && current_health <= self.second_threshold) {
    self notify("second_threshold_reached");
  }
}

function function_9883479ef6511b80() {
  current_health = 0;

  foreach(cyst in self.cysts) {
    current_health += cyst.health;
  }

  self.var_ec031f5af338bc24 = current_health;
  return current_health;
}

function function_c769482a1e8c11d5() {
  self endon("activity_ended");
  self endon("instance_destroyed");

  while(true) {
    self waittill("cyst_cleared");

    if(self.var_e171f154ea4ec2c8 == self.var_b775d3fc5973f7ac) {
      self notify("aethergas_cleared");

      foreach(player in self.var_1258379e7ea78440) {
        player notify("aethergas_cleared");
        player thread function_b006b89a63144ac5();
      }

      break;
    }

    waitframe();
  }

  self notify("nest_cleared");
}

function function_8e5f7aaa701e23f8() {
  self endon("activity_ended");
  self endon("instance_destroyed");
  function_24b55c1a13b9a63a("ai_flood_fill_encounter:ob_aethernest_flood_fill_encounter", undefined, undefined, 1);
  self waittill("first_threshold_reached");
  thread wave_logic("second_threshold_reached", "size_5", 16);
  playsoundeventonplayers("snd_aethernest_healthchange", self.playerparticipants);
  earthquake(0.35, 1.7, self.s_center.origin, 500);
  playrumbleonposition("grenade_rumble", self.s_center.origin);
  self waittill("second_threshold_reached");
  thread wave_logic("nest_cleared", "size_7", 20);
  playsoundeventonplayers("snd_aethernest_healthchange", self.playerparticipants);
  earthquake(0.47, 1.7, self.s_center.origin, 500);
  playrumbleonposition("grenade_rumble", self.s_center.origin);
}

function wave_logic(endon_tag, size_tag, wait_time) {
  if(isDefined(endon_tag)) {
    self endon(endon_tag);
  }

  self endon("activity_ended");
  self endon("instance_destroyed");
  thread function_b4adf91e395e53f0();

  if(isDefined(size_tag)) {
    function_24b55c1a13b9a63a("ai_encounter:ob_aethernest_encounter", size_tag, self.difficulty_region);
  } else {
    function_24b55c1a13b9a63a("ai_encounter:ob_aethernest_encounter");
  }

  wait wait_time;
  function_24b55c1a13b9a63a("ai_flood_fill_encounter:ob_aethernest_flood_fill_encounter", undefined, self.difficulty_region, 1);
}

function function_b4adf91e395e53f0() {
  self endon("activity_ended");
  self endon("instance_destroyed");

  foreach(cyst in self.cysts) {
    cyst thread function_155971201d58c7dc("aethernest_cyst_gas_expel");
  }
}

function function_155971201d58c7dc(effect_type) {
  self endon("death");

  switch (effect_type) {
    case #"hash_2f0f62be9305365f":
      self setscriptablepartstate("health", "ignore_damage");
      self setscriptablepartstate("body", "bursted");
      self.activity_instance.var_779e11fc33f215f9 = self.s_cyst;
      self.activity_instance.cysts = array_remove(self.activity_instance.cysts, self);
      self.activity_instance.var_e171f154ea4ec2c8 += 1;
      var_375c9bbee9c8fdf6 = self.spawn_list;
      var_5edfc5b3c4d591b1 = self.origin;
      var_bd4ee238fcb23d3f = self.angles;
      waitframe();
      self.activity_instance notify("cyst_cleared");
      wait 0.5;

      if(isDefined(self.var_26fd9d9c73229afe)) {
        itembundlename = "ob_jup_item_key_rift_gate_season1_toxic";
        itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
        payload = [#"teamselect", self.var_26fd9d9c73229afe getentitynumber()];
        a_squad = self.var_26fd9d9c73229afe scripts\cp_mp\utility\squad_utility::getsquadmembers();
        item = scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(itembundle, self.origin + anglestoup(self.angles) * 7, self.angles + (7, 7, 7), 1, 0, payload);
        self.activity_instance.var_2090e50657f45b8a = 0;
        self.activity_instance.var_3b4e070a9fbc7044 = array_combine(self.activity_instance.var_3b4e070a9fbc7044, a_squad);
        params = spawnStruct();
        params.item = item;
        params.itembundlename = itembundlename;
        params.payload = payload;

        if(isDefined(level.var_8b939fbe0ef2d56b)) {
          self.var_26fd9d9c73229afe[[level.var_8b939fbe0ef2d56b]](params);
        }

        thread scripts\cp_mp\overlord::playevent("quest_s1_rift_gate_unlock_object_acquired", a_squad, 1);
      } else {
        scripts\cp_mp\loot\common_item::function_cd45408bd44fab07(var_375c9bbee9c8fdf6, 1, var_5edfc5b3c4d591b1 + anglestoup(var_bd4ee238fcb23d3f) * 10);
      }

      wait 2;
      break;
    case #"hash_9a6d8b5ace91c19b":
    default:
      break;
  }
}

function function_24b55c1a13b9a63a(bundle, var_f555f0c2ce194ea8, var_4f51b9f082dab4dd, var_92190fa0ccb5e392) {
  encounter_radius = 250;
  z_clamp = 50;
  centerpoint = self.s_center.origin + (0, 0, z_clamp * (self.floor_count - 1));
  self.encounterid = function_f8ccadcd850da124(bundle, centerpoint, encounter_radius, 1, 1, 1, 2);

  if(isDefined(self.encounterid)) {
    if(isDefined(var_f555f0c2ce194ea8)) {
      function_d37068aac7785c04(self.encounterid, var_f555f0c2ce194ea8, 1);
    }

    if(isDefined(var_4f51b9f082dab4dd)) {
      function_d37068aac7785c04(self.encounterid, var_4f51b9f082dab4dd, 1);
    }

    function_ce9c21523336cdbc(self.encounterid, &function_92eab905b00e7dd2, self);

    if(isDefined(var_92190fa0ccb5e392)) {
      if(var_92190fa0ccb5e392) {
        function_4b7d420e1bad897f(self.encounterid, self.var_c305d8b37977e9c9);
      }
    }
  }
}

function function_e2b7429085d664a(bundle, num_spawns) {
  centerpoint = self.var_3b71feeee7e739e1.origin;
  self.encounterid = function_f8ccadcd850da124(bundle, centerpoint, 80, 1, 1, 1, 2);

  if(isDefined(self.encounterid)) {
    function_d37068aac7785c04(self.encounterid, num_spawns, 1);
    function_ce9c21523336cdbc(self.encounterid, &function_c2efd8eb6c962bc2, self);
  }
}

function function_cadda8ac1fffb5(bundle, optional_tag, suffix) {
  self.encounterid = function_3ee36bc763779ba1(self.varianttag + suffix, 1, 1, 1, 2);

  if(isDefined(self.encounterid)) {
    if(isDefined(optional_tag)) {
      function_d37068aac7785c04(self.encounterid, optional_tag, 1);
    }

    function_ce9c21523336cdbc(self.encounterid, &function_92eab905b00e7dd2, self);
  }
}

function function_92eab905b00e7dd2(requestid, userdata, agent, data) {
  agent endon("death");

  if(isalive(agent)) {
    activityinstance = userdata;

    if(isDefined(activityinstance.last_player_attacker)) {
      agent function_a047f71d0256058b(activityinstance.last_player_attacker);
    }
  }
}

function function_c2efd8eb6c962bc2(requestid, userdata, agent, data) {
  agent endon("death");

  if(isalive(agent)) {
    data.spawnspeed = 2;
    activityinstance = userdata;
    crawler = agent;
    crawler val::set("idle_hang", "damage", 0);
    crawler val::set("idle_hp_bar", "show_healthbar", 0);
    crawler.activity_instance = activityinstance;
    crawler.idle_anim = "nest_crawler_idle_two_drop_01";
    crawler.var_7c6c1f790fad020f = 1;
    crawler visiblenotsolid();
    crawler thread function_9f61ce12bbb16cac();
    crawler thread function_77e6043e861fdb3b();
    activityinstance.crawlers[activityinstance.crawlers.size] = crawler;
    crawler ent_flag_wait("zombie_asm_init_finished");

    if(!isDefined(crawler.animname)) {
      crawler.animname = crawler.animsetname;
    }
  }
}

function function_2f109c081d5fd179(obj) {
  if(isDefined(obj)) {
    obj delete();
  }
}

function function_f2842b850f8fed3b() {
  var_cc7aa96a854fd8ee = spawnStruct();
  var_cc7aa96a854fd8ee.origin = self.s_center.origin;
  var_cc7aa96a854fd8ee.angles = self.s_center.angles;
}

function function_43705e033b99948e(var_b381b0883bcd4847) {
  player_list = var_b381b0883bcd4847.playerlist;
  var_a83ac3549acc2da2 = var_b381b0883bcd4847.playerjoinreason;
}

function function_f9b067b93ae7bb66(var_b381b0883bcd4847) {
  player_list = var_b381b0883bcd4847.playerlist;

  foreach(player in player_list) {
    if(isPlayer(player)) {
      player notify("left_aethernest");
    }
  }
}

function function_5c710295d42036e9() {
  self endon("instance_destroyed");
  thread function_a26e39e03a0d6739();
  function_45addf4a995d163(self.var_1258379e7ea78440);

  if(self.successfullycompleted) {
    namespace_40713433c91dd86c::function_c402ecda1e84ba27(self.playerparticipants, 0, self.difficulty_region, self.s_center.origin);
    scripts\common\powerups::powerup_drop("full_ammo", getclosestpointonnavmesh(self.s_center.origin) + (0, 0, 30));

    if(isDefined(self.cache)) {
      self.cache_cover setscriptablepartstate("state", "dead");
      self.cache setscriptablepartstate("body", "closed_usable");

      foreach(player in level.players) {
        self.cache enablescriptableplayeruse(player);
      }
    }

    foreach(player in self.playerparticipants) {
      player thread function_b006b89a63144ac5();
    }
  }

  if(isDefined(self.gas_vfx)) {
    foreach(vfx in self.gas_vfx) {
      function_2f109c081d5fd179(vfx);
    }
  }

  if(isDefined(self.gas_array)) {
    foreach(gas in self.gas_array) {
      gas setscriptablepartstate("state", "hidden");
    }
  }
}

function function_38736a058eca7b23() {
  self endon("instance_destroyed");
  self notify("aethernest_cease");
  thread function_a26e39e03a0d6739();
  function_45addf4a995d163(self.var_1258379e7ea78440);

  if(isDefined(self.gas_vfx)) {
    foreach(vfx in self.gas_vfx) {
      function_2f109c081d5fd179(vfx);
    }
  }

  foreach(cyst in self.var_5eba52fdc9fb7b54) {
    cyst freescriptable();
  }

  if(isDefined(self.cache)) {
    self.cache freescriptable();
  }

  if(isDefined(self.cache_cover)) {
    self.cache_cover freescriptable();
  }

  if(isDefined(self.var_85c0a3df419144e7)) {
    foreach(prop in self.var_85c0a3df419144e7) {
      function_2f109c081d5fd179(prop);
    }
  }

  if(isDefined(self.prop_array)) {
    foreach(prop in self.prop_array) {
      prop setscriptablepartstate("state", "hidden");
    }
  }

  if(isDefined(self.var_3b71feeee7e739e1)) {
    self.var_3b71feeee7e739e1.scriptable freescriptable();
  }
}

function playsoundeventonplayers(soundevent, array_players) {
  foreach(player in array_players) {
    if(isPlayer(player)) {
      player playsoundevent(soundevent);
      namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_operator_vo", {
        #target: undefined, #speaker: player, #sound_event: soundevent, #sound_type: undefined, #script_func_name: "ob::playSoundEventOnPlayers"
      });
    }
  }
}