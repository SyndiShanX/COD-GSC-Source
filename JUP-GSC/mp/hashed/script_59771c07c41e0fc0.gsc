/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_59771c07c41e0fc0.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_1845b8a2edf19262;
#using script_185660037b9236c1;
#using script_208955cb4d2c8fb3;
#using script_220d0eb95a8fab7d;
#using script_24946c036cb2f7b2;
#using script_2d400da2610fe542;
#using script_3ab210ea917601e7;
#using script_3ce4651e69c721db;
#using script_41387eecc35b88bf;
#using script_46c7c73b1a7e4773;
#using script_4e6e58ab5d96c2b0;
#using script_5200937492b52afd;
#using script_5753ba9c28794a65;
#using script_5d8202968463a21d;
#using script_638d701d263ee1ed;
#using script_6c6a46b757ce4c71;
#using script_7956d56c4922bd1;
#using script_7cfaa6fd841fb4dd;
#using script_edb8e725d068ac9;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\loot\common_cache;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\tripwire;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\gametypes\ob;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\entity;
#namespace namespace_5a6420d2880ffe83;

function function_557cb9d43dd5e520() {
  function_89384091f7a2dbd("REV_OB_MERC_STRONGHOLD", 0, &function_1c518ee0267d39a7);
  function_89384091f7a2dbd("REV_OB_MERC_STRONGHOLD", 1, &function_1d7f1aa5e90c423f);
  function_89384091f7a2dbd("REV_OB_MERC_STRONGHOLD", 2, &function_c92a1d18faacf0b7);
  function_89384091f7a2dbd("REV_OB_MERC_STRONGHOLD", 3, &function_d247acefc6b0fea4);
  function_8b5b2a3392fc7e2a("PlayerLeave", &function_5c651df8cfad0810, "REV_OB_MERC_STRONGHOLD");
  function_8b5b2a3392fc7e2a("PlayerEnteredAwarenessZone", &function_cf049bb9bdcb65b1, "REV_OB_MERC_STRONGHOLD");

  if(getdvarint(@ "hash_bf4ebf5964c596f5", 1)) {
    namespace_4a32b5725832011a::function_77a37b3f4896fc9b();
    level.var_55ae2ac5cd96a23f = 1;
    registersharedfunc("safe", "onStartUnlocking", &function_945cd263f86ee313);
  }

  level thread function_f927f5dd26f5e076();

  namespace_4c2b495b8d79cc2e::function_fca481c0e8fafd2c("SpatialZoneContainerGroup_No_Key_Zone", &function_97724206a31d0a1a, &function_f390f4ebbe42c73c, "handler_comms_nokey");
}

function function_1c518ee0267d39a7() {
  if(!isDefined(self)) {
    println("<dev string:x1c>");
    return;
  }

  self endon("activity_ended");
  self endon("instance_destroyed");
  self.variant_definition = function_4188e118731a30f4();
  self.variant_settings = function_b9c4aa88ad97ee68(self);
  self.main_struct = getStruct(self.varianttag + "_main", "targetname");

  if(!isDefined(self.main_struct)) {
    println("<dev string:xc8>" + self.varianttag + "<dev string:xe5>");
    return;
  }

  if(!isDefined(self.main_struct.target)) {
    println("<dev string:xc8>" + self.varianttag + "<dev string:x174>");
    return;
  }

  root_structs = getStructArray(self.main_struct.target, "targetname");

  if(!isDefined(root_structs) || root_structs.size == 0) {
    println("<dev string:xc8>" + self.varianttag + "<dev string:x20d>");
    return;
  }

  self.root_struct = getclosest(self.main_struct.origin, root_structs, 3000);
  [self.var_e82f27370c0c78a7] = strtok(self.root_struct.target, "_");

  if(!isDefined(self.root_struct)) {
    println("<dev string:xc8>" + self.varianttag + "<dev string:x29c>");
    return;
  }

  self.root_struct.activityinstance = self;
  self.floor_count = 1;

  if(isDefined(self.root_struct.script_noteworthy)) {
    self.floor_count = int(self.root_struct.script_noteworthy);
  }

  self.capture_radius = default_to(self.variant_settings.var_aa2f6abe766e0b14, 150);
  self.attract_radius = default_to(self.variant_settings.var_4957ff6533310443, 2048);
  self.lose_progress = default_to(self.variant_settings.var_99e94a285263be97, 1);
  self.encounter_bundle = default_to(self.variant_settings.safeencounter, "jup_ob_merc_stronghold_encounter_safe");
  scriptables = getentitylessscriptablearray(self.root_struct.target, "targetname");
  other_structs = array_combine(getStructArray(self.root_struct.target, "targetname"), scriptables, function_f159c10d5cf8f0b4(self.root_struct.target, "targetname"));
  self.var_10f090a9e9488068 = [];
  self.lootcache_spawns = [];
  self.tripwires = [];
  self.safe_struct = undefined;

  foreach(struct in other_structs) {
    if(!isDefined(struct.script_noteworthy)) {
      continue;
    }

    switch (struct.script_noteworthy) {
      case #"hash_2a78ee15440a7a06":
        struct.canunlock = 1;
        self.var_10f090a9e9488068[self.var_10f090a9e9488068.size] = struct;
        break;
      case #"hash_106df5d1729e996":
        self.var_10f090a9e9488068[self.var_10f090a9e9488068.size] = struct;
        break;
      case #"hash_c7833a7b1cbbcbb8":
        self.lootcache_spawns[self.lootcache_spawns.size] = struct;
        break;
      case #"hash_1e2a3b90ad592d02":
        self.safe_struct = struct;
        break;
    }
  }

  other_structs = getStructArray(self.main_struct.target, "target");

  foreach(struct in other_structs) {
    if(!isDefined(struct.script_noteworthy)) {
      continue;
    }

    switch (struct.script_noteworthy) {
      case #"hash_1e2a3b90ad592d02":
        self.safe_struct = struct;
        break;
      case #"hash_67d246bbbd8678a0":
        self.safe_reinforce = struct;
        break;
    }
  }

  self.region_difficulty = namespace_4df2ab39b0e96ec7::function_4d8bb2d866771a10(self.root_struct.origin);

  switch (self.region_difficulty) {
    case #"hash_7bb2cd766703d463":
      self.var_d2d422f50501ae28 = default_to(self.variant_settings.var_45c274695def950f, 3);
      self.var_d133a794fe336c9d = default_to(self.variant_settings.var_45c274695def950f, 2);
      self.capture_time = default_to(self.variant_settings.var_ffbb339bc7800aab.capturetime, 75);
      self.var_48c4ba670a4f33fc = default_to(self.variant_settings.var_ffbb339bc7800aab.lootlist, "ob_jup_items_activity_merc_stronghold_safe_green");
      self.tripwire_count = default_to(self.variant_settings.var_cac3f854e5a01b31, 2);
      self.var_b90c26f642e9b96e = "ob_minor_activity_complete_green";
      break;
    case #"hash_af83e47edfa8900a":
      self.var_d2d422f50501ae28 = default_to(self.variant_settings.var_45c274695def950f, 2);
      self.var_d133a794fe336c9d = default_to(self.variant_settings.var_45c274695def950f, 3);
      self.capture_time = default_to(self.variant_settings.var_62856878a9debbdc.capturetime, 75);
      self.var_48c4ba670a4f33fc = default_to(self.variant_settings.var_62856878a9debbdc.lootlist, "ob_jup_items_activity_merc_stronghold_safe_green");
      self.tripwire_count = default_to(self.variant_settings.var_f3cd38cc4ea1ead6, 3);
      self.var_b90c26f642e9b96e = "ob_minor_activity_complete_yellow";
      break;
    default:
      println("<dev string:xc8>" + self.varianttag + "<dev string:x31f>");
      function_4bc22996edea81f1(self);
      return;
  }

  self.var_48c4ba670a4f33fc = getDvar(@ "hash_c80f3e1e7f1c4ea8", self.var_48c4ba670a4f33fc);
  self.capture_time = float(self.capture_time);
  self.var_82fe1c44f0e59dd5 = squared(self.capture_radius);
  self.var_287c8f447c48c9aa = squared(self.attract_radius);
  self.var_614385c59920cb82 = 3;
  self.var_999c4a8370c90a74 = &function_99b95e1bcf411ecd;
  condition = 1;
  function_10646a42a1856556(scriptables);
  function_d96f75b6f0fc7daf();
  function_44f59d05c32d272e();
  function_f40b2a445b8885bc();
  function_587c183c4febe0f4();
  thread function_f916023bc6d70f23();
  namespace_9718b9a169c3ead0::function_cb146e445d78e9ee();
  function_3e33031646de23b0(self);
  function_7719e82ffdcda669(self);
  self waittill("merc_stronghold_unlocked");
  function_b6fc2c96b463c007(self);
}

function function_1d7f1aa5e90c423f() {
  self endon("activity_ended");
  self endon("instance_destroyed");
  thread namespace_b3f32c8cb80b8124::function_e73a92bbeb2ae323();

  if(!istrue(level.var_55ae2ac5cd96a23f)) {
    self waittill("merc_stronghold_cleared");
    endactivity(self, 1);
  }
}

function function_c92a1d18faacf0b7() {
  namespace_4fda5d7358015a06::function_dca86aca511288f4(self, "CleanupState");
  self endon("instance_destroyed");
  thread function_a26e39e03a0d6739();
}

function function_d247acefc6b0fea4() {
  if(isDefined(self.var_bdbc894efe4c6a96) && self.var_bdbc894efe4c6a96.size > 0) {
    namespace_17b45e55cf344cda::function_486b0f579d5b6dae(self.var_bdbc894efe4c6a96);
  }

  function_2ced1a9613bd11ab(self);
}

function function_922249df70b163b4() {
  if(!isDefined(self.safe_struct)) {
    println("<dev string:xc8>" + self.varianttag + "<dev string:x387>");
    function_4bc22996edea81f1(self);
    return;
  }

  if(!isDefined(self.safe_reinforce)) {
    println("<dev string:xc8>" + self.varianttag + "<dev string:x3d2>");
    function_4bc22996edea81f1(self);
    return;
  }

  if(isDefined(self.safe_struct)) {
    self.safe = namespace_4a32b5725832011a::function_12920ead9cafd0e1(self.safe_struct.origin, self.safe_struct.angles);
    self.safe.stealthgroup = self.safe_struct.script_parameters;
    self.safe.var_2091b0afd53afd0 = 1;
  }

  if(isDefined(self.safe_reinforce)) {
    spawnpointdata = spawnStruct();
    spawnpointdata.origin = self.safe_reinforce.origin + (0, 0, 12);
    spawnpointdata.angles = (0, 0, 0);
    spawnpointdata.ai_faction = "";
    spawnpointdata.var_994503f84e8b10ee = self.safe_reinforce.script_parameters;
    spawnpointdata.spawn_filter = "mediumAirship";

    if(isDefined(self.safe.stealthgroup)) {
      spawnpointdata.script_stealthgroup = self.var_e82f27370c0c78a7 + "_" + self.safe.stealthgroup;
    }

    self.reinforcementpoint = spawnpointdata;
  }
}

function function_3b904252bd807c48() {
  ai_spawn_director::function_9aa732b22b08a6dc(self.var_ec8e19d33579ee5d, &function_29604012bba4e2c9, self);
  ai_spawn_director::function_11f03fd3165d148f(self.var_ec8e19d33579ee5d, &function_3ad08f64466364b3, self);
}

function function_29604012bba4e2c9(encounterid, userdata, activityinstance) {
  activityinstance.helispawned = 1;
}

function function_3ad08f64466364b3(encounterid, userdata, activityinstance) {
  activityinstance.helispawned = 0;
}

function function_b92f379a5ad772f8() {
  self.var_ec8e19d33579ee5d = ai_spawn_director::spawn_request("ai_encounter:" + "jup_ob_merc_stronghold_encounter_presafe", self.safe.origin, 2048, 1, 1, 0);
  waitframe();

  if(isDefined(self.var_ec8e19d33579ee5d)) {
    ai_spawn_director::function_e4a67fe4ddca7ed5(self.var_ec8e19d33579ee5d, &function_bfb2d106fb179ca2, self);
    ai_spawn_director::function_11f03fd3165d148f(self.var_ec8e19d33579ee5d, &function_dceb459c3597d366, self);
    function_adcc96a7d541aa36(self.var_ec8e19d33579ee5d, 0);
    function_fc38783a3da0bc71(self.var_ec8e19d33579ee5d, 1);
  }
}

function function_a5311fb4a565a810() {
  if(isDefined(self.var_8d95ebec3c279578)) {
    ai_spawn_director::function_e4a67fe4ddca7ed5(self.var_8d95ebec3c279578, &function_bfb2d106fb179ca2, self);
    ai_spawn_director::function_11f03fd3165d148f(self.var_8d95ebec3c279578, &function_dceb459c3597d366, self);
    function_adcc96a7d541aa36(self.var_8d95ebec3c279578, 0);
    function_fc38783a3da0bc71(self.var_8d95ebec3c279578, 1);
  }
}

function function_c5770043463ad63() {
  level endon("game_ended");

  if(isDefined(self.safe)) {
    safe = self.safe;
    safe waittill("safe_unlocking");
    activityinstance = self;
    thread function_cefa7b514c4aff6d();

    while(!istrue(activityinstance.helispawned)) {
      if(!istrue(safe.reinforcementscalled)) {
        safe.reinforcementscalled = 1;
        function_a5311fb4a565a810();
        thread function_dd78c34c770c2497(self.var_6c29f2fdb0054bbe);
      }

      wait 0.1;
    }
  }
}

function function_945cd263f86ee313(safe, part, state, player) {
  if(isDefined(player)) {
    player notify("disguise_state_change", "end_disguise");
  }
}

function private function_edfa3b20cf5df03() {
  var_54d38f1df370976a = namespace_ad1f398af6f48cb1::function_621b23491ba1db4d();

  if(isDefined(var_54d38f1df370976a)) {
    self.safe.key = var_54d38f1df370976a.keyitemid;
    self.intelstring = var_54d38f1df370976a.intelstring;
    self notify("warlord_key_picked");
  }
}

function function_10646a42a1856556(scriptables) {
  if(!isDefined(level.var_e9a6fc11b0aa7eb2)) {
    scripts\cp_mp\tripwire::init();
    level.tripwireweaponname = "jup_frag_grenade_ob";

    if(isDefined(level.var_f1bff73a86c35c52)) {
      [[level.var_f1bff73a86c35c52]]();
    }
  }

  self.scriptables = scriptables;

  foreach(scriptable in self.scriptables) {
    if(isDefined(scriptable.classname) && issubstr(scriptable.classname, "nest")) {
      continue;
    }

    if(isDefined(scriptable.classname) && issubstr(scriptable.classname, "scriptable_blocker")) {
      scriptable setscriptablepartstate("state", "visible");
    }

    if(isDefined(scriptable.classname) && issubstr(scriptable.classname, "scriptable_ob_toggleable")) {
      scriptable setscriptablepartstate("state", "visible");
    }

    if(isDefined(scriptable.classname) && issubstr(scriptable.classname, "tripwire")) {
      self.tripwires[self.tripwires.size] = scriptable;
    }
  }
}

function function_aa43dfcdd8f03fe0(var_2d9552508615d396, tripwire) {
  if(isDefined(tripwire.activityinstance) && isDefined(tripwire.var_70587812595fd991)) {
    namespace_75b9b66caa533c31::function_aed7a5e07b895fa(var_2d9552508615d396, tripwire);
  }
}

function function_d96f75b6f0fc7daf() {
  self.tripwires = array_randomize(self.tripwires);

  if(!isDefined(self.tripwire_count)) {
    self.tripwire_count = self.tripwires.size;
  }

  if(self.tripwire_count > self.tripwires.size) {
    self.tripwire_count = self.tripwires.size;
  }

  for(i = 0; i < self.tripwire_count; i++) {
    [[level.var_e9a6fc11b0aa7eb2]](self.tripwires[i], "team_hundred_ninety");
    self.tripwires[i].activityinstance = self;
    self.tripwires[i].var_70587812595fd991 = default_to(self.variant_settings.tripwiregrenadeweapon, undefined);
  }
}

function function_44f59d05c32d272e() {
  self.locked_doors = [];
  zone = namespace_4c2b495b8d79cc2e::function_5bbdc39a533d9d57(self, "Proximity_Join_Zone");
  searchradius = namespace_4c2b495b8d79cc2e::function_2403f7fe5d40cecc(zone[0]);
  self.mapdoors = getentitylessscriptablearray(undefined, undefined, self.main_struct.origin, searchradius, "door");
  self.var_ab1e4c965d683006 = namespace_ef96e7c723871c3d::function_c94f363ec8793bc2(self.main_struct.origin, searchradius);

  if(getdvarint(@ "hash_9c3d7b7ac76a359c", 0) == 1) {
    thread scripts\mp\utility\debug::drawsphere(self.main_struct.origin, searchradius, 900, (0, 1, 1));

    foreach(mappeddoor in self.mapdoors) {
      thread scripts\mp\utility\debug::drawsphere(mappeddoor.origin, 1, 900, (1, 1, 1));
    }
  }

  foreach(var_7d1484060301dfa7 in self.var_10f090a9e9488068) {
    if(getdvarint(@ "hash_9c3d7b7ac76a359c", 0) == 1) {
      thread scripts\mp\utility\debug::drawsphere(var_7d1484060301dfa7.origin, 5, 900, (0.25, 0, 0.5));
    }

    var_98fa2809e21ff34f = [];
    var_98fa2809e21ff34f = namespace_f6368c72597c6d90::function_ad1b6accbaab404e(var_7d1484060301dfa7, self.locked_doors, "human_stronghold", istrue(var_7d1484060301dfa7.canunlock), "merc_stronghold", self.mapdoors);

    foreach(door in var_98fa2809e21ff34f) {
      if(istrue(door.doubledoor)) {
        if(issubstr(door.classname, "saloon")) {
          var_f34a60219065c89 = 1;
        }

        if(istrue(var_f34a60219065c89)) {
          door function_9af4c9b2cc1bf989();
        } else {
          door scriptabledoorfreeze(1);
        }
      } else {
        namespace_f6368c72597c6d90::function_fbbfe6f05eda5eb1(door);
      }

      if(istrue(var_7d1484060301dfa7.canunlock)) {
        door.stronghold_activity = self;
        door.var_def557e8fd5c6763 = &function_f10295a436fc1aa2;
        door.fortress = self;
        self.locked_doors[self.locked_doors.size] = door;
        continue;
      }

      door scriptabledoorfreeze(1);
    }
  }

  self.mapdoors = undefined;
}

function private function_f10295a436fc1aa2(scriptable, player) {
  level endon("game_ended");

  if(istrue(level.var_55ae2ac5cd96a23f)) {
    scriptable.stronghold_activity function_922249df70b163b4();
  }

  scriptable.stronghold_activity function_5d929bdf9c67783f();
  scriptable.stronghold_activity function_e2797519315ed24a();
  keylootid = loot::getlootidfromref("loot_key_human_stronghold");
  soundorigin = scriptable.origin;
  wait 1;
  playsoundatpos(soundorigin, "mp_door_key_break");
  backpackindex = player common_inventory::function_4776284a348ebb6a(keylootid);

  if(isDefined(backpackindex) && backpackindex != -1) {
    player common_inventory::function_ca3bbb1070436540(backpackindex, 0, 0);
  }

  scriptable.stronghold_activity notify("merc_stronghold_unlocked");

  if(issharedfuncdefined("ob_quest_missions", "onMercStrongholdActive")) {
    [[getsharedfunc("ob_quest_missions", "onMercStrongholdActive")]](scriptable.stronghold_activity, player);
  }

  scriptable.stronghold_activity thread function_a7fafdf4ccb30418(namespace_4c2b495b8d79cc2e::function_7ec62d1550b9897e(scriptable.stronghold_activity, "Awareness_Zone"));
  self.stronghold_activity function_b92f379a5ad772f8();
}

function private function_e2797519315ed24a() {
  namespace_ef96e7c723871c3d::function_e05a3fe61be76eed(self.var_ab1e4c965d683006);

  foreach(var_6876372a894fe601 in self.locked_doors) {
    namespace_9e69d66f68c38a10::function_b092780f9ec4496e(var_6876372a894fe601);
  }

  function_edfa3b20cf5df03();
  self.locked_doors = [];
}

function function_f40b2a445b8885bc() {
  building_center = self.root_struct.origin;
  building_radius = 1000;
  awareness_radii = namespace_8480efeffcd6e233::function_5bbdc39a533d9d57(self, "Awareness_Zone");

  if(awareness_radii.size) {
    building_center = awareness_radii[0].origin;
    building_radius = awareness_radii[0].radius;
  }

  var_510c132b62d77d0a = ["ob_loot_cache", "ob_loot_cache_large"];
  var_e9797ff12b9b7021 = getlootscriptablearrayinradius(var_510c132b62d77d0a, undefined, building_center, building_radius);
  var_bd0496839afeb73 = [];
  var_3460c39ea31fc730 = [];

  foreach(cache in var_e9797ff12b9b7021) {
    if(cache.type == "ob_loot_cache") {
      var_bd0496839afeb73[var_bd0496839afeb73.size] = cache;
      continue;
    }

    if(cache.type == "ob_loot_cache_large") {
      var_3460c39ea31fc730[var_3460c39ea31fc730.size] = cache;
      continue;
    }

    assertex(0, "<dev string:x426>" + cache.type + "<dev string:x454>");
  }

  regular_count = var_bd0496839afeb73.size;
  legendary_count = var_3460c39ea31fc730.size;
  self.lootcache_spawns = array_randomize(self.lootcache_spawns);

  foreach(spawnpoint in self.lootcache_spawns) {
    var_55a1bbe3cf72ddb7 = 0;

    foreach(cache in var_e9797ff12b9b7021) {
      if(distancesquared(cache.origin, spawnpoint.origin) < 5625) {
        var_55a1bbe3cf72ddb7 = 1;
        break;
      }
    }

    if(!var_55a1bbe3cf72ddb7) {
      if(regular_count < self.var_d2d422f50501ae28) {
        cache = common_cache::cache_spawncache(#"hash_31848ee41c7d520d", spawnpoint.origin, spawnpoint.angles - (0, 90, 0));
        cache setscriptablepartstate("body", "closed_usable");
        regular_count += 1;
        continue;
      }

      if(legendary_count < self.var_d133a794fe336c9d) {
        cache = common_cache::cache_spawncache(#"hash_c1d0ea6db3f38ac5", spawnpoint.origin, spawnpoint.angles - (0, 90, 0));
        cache setscriptablepartstate("body", "closed_usable");
        legendary_count += 1;
        continue;
      }

      break;
    }
  }
}

function function_f916023bc6d70f23() {
  level endon("game_ended");
  self endon("activity_ended");
  self endon("instance_destroyed");
  self waittill("warlord_key_picked");
  struct = sortbydistance(level.ob.var_3c0bad034d227d02, self.safe_struct.origin)[0];
  radio = spawnscriptable("ob_intel_terminus_audio", struct.origin, struct.angles);
  radio.var_84e2ca49013808d2 = self.intelstring;

  radio thread namespace_287c594b1c56aa67::function_6e50624e2c06832b();

  if(!isDefined(level.var_d97f7ce3bb56f2a3["terminus_audio_intel_warlord"])) {
    level.var_d97f7ce3bb56f2a3["terminus_audio_intel_warlord"] = [];
  }

  level.var_d97f7ce3bb56f2a3["terminus_audio_intel_warlord"] = array_add(level.var_d97f7ce3bb56f2a3["terminus_audio_intel_warlord"], radio);
}

function function_587c183c4febe0f4() {
  covertargetname = "e_cover_" + self.main_struct.target;
  self.var_bdbc894efe4c6a96 = function_e9158c9e8c391f25(covertargetname);
}

function function_5d929bdf9c67783f() {
  self.encounter = function_3ee36bc763779ba1(self.root_struct.target, 1, 0, 1, 2);

  if(isDefined(self.encounter)) {
    function_d37068aac7785c04(self.encounter, self.region_difficulty, 1);
    function_ce9c21523336cdbc(self.encounter, &function_92b5f29556b6c5b3, self);
    function_3c85fe57dbc02e4e(self.encounter, &function_7545164b5529be52, self);
    function_ff46e79c8c7a21c8(self.reinforcementpoint);
    self.var_8d95ebec3c279578 = ai_spawn_director::spawn_request("ai_encounter:" + "jup_ob_merc_stronghold_encounter_safe", self.safe.origin, 2048, 0, 1, 0);
    thread function_c5770043463ad63();
  }

  encounterdata = function_9a39e23c3c52c2af(self.encounter);

  if(isDefined(encounterdata)) {
    self.encounterorigin = encounterdata.origin;
    self.encounterradius = encounterdata.radius;
  }
}

function function_92b5f29556b6c5b3(encounterid, activityinstance, agent, data) {
  level endon("game_ended");
  agent endon("death");
  agent.var_5323a94889eff1de = 1;
  agent ent_flag_wait("stealth_enabled");
  agent setstealthstate("combat");
  agent function_8b6c9d30305fd087(agent, activityinstance);

  if(issharedfuncdefined("rift_gate_relics_s3", "track_merc_captain_kill")) {
    if(isDefined(agent) && isDefined(agent.subclass) && agent.subclass == "ob_captain") {
      [[getsharedfunc("rift_gate_relics_s3", "track_merc_captain_kill")]](agent);
    }
  }

  activityinstance thread function_230e249807e20ca7(encounterid, agent);
}

function function_7545164b5529be52(encounterid, activityinstance, wave) {
  return false;
}

function function_bfb2d106fb179ca2(encounterid, activityinstance, agent, data) {
  level endon("game_ended");
  agent endon("death");
  agent.qsetgoalpos = 1;
  agent ob::function_e83e24c88a9a762c(1);
  agent.var_5323a94889eff1de = 1;
  agent ent_flag_wait("stealth_enabled");
  agent setstealthstate("combat");

  if(!isDefined(agent.script_stealthgroup) || !isDefined(level.stealth.combat_volumes[agent.script_stealthgroup])) {
    safe = activityinstance.safe;

    if(isDefined(safe)) {
      var_a6911d286b1b19a0 = 36;
      var_49cbbdcc9e6795d4 = 500;
      reinforcementposition = safe.origin + anglesToForward(safe.angles) * var_a6911d286b1b19a0;
      reinforcementposition += (0, 0, 12);
      reinforcementposition = getclosestpointonnavmesh(reinforcementposition);
      agent.goalheight = 80;
      agent setgoalpos(reinforcementposition, var_49cbbdcc9e6795d4);

      if(getdvarint(@ "hash_230f5449e5459051", 0) == 1) {
        level thread debug::drawline(safe.origin, reinforcementposition, 9999, game["<dev string:x485>"]["<dev string:x48f>"]);
        level thread debug::drawsphere(reinforcementposition, 24, 9999, game["<dev string:x485>"]["<dev string:x48f>"]);
      }
    }
  }
}

function function_8b6c9d30305fd087(agent, activityinstance) {
  if(!isDefined(agent) || !agent.isactive) {
    return;
  }

  var_d7fed986a016b24b = 120;
  var_9a2ade83732f36f2 = activityinstance.encounterorigin;
  var_c6b2d4e3dc77cf9d = activityinstance.encounterradius + var_d7fed986a016b24b;

  if(isDefined(var_9a2ade83732f36f2) && isDefined(var_c6b2d4e3dc77cf9d)) {
    if(getdvarint(@ "hash_230f5449e5459051", 0) == 1) {
      level thread debug::drawline(var_9a2ade83732f36f2, agent.origin, 9999, game["<dev string:x485>"]["<dev string:x48f>"]);
      level thread debug::drawsphere(var_9a2ade83732f36f2, var_c6b2d4e3dc77cf9d, 9999, game["<dev string:x485>"]["<dev string:x48f>"]);
    }

    agent function_65cdab0fc78aba8f(var_9a2ade83732f36f2, var_c6b2d4e3dc77cf9d);
  }
}

function function_dceb459c3597d366(encounterid, activityinstance, agent) {
  level endon("game_ended");
  agent endon("death");
  agent.var_4ebe755e0a0a430e = 1;
  agent.var_1929d925cdb4438f = 600;
  agent.var_9e15c6628beed283 = 1000;
  agent.var_ecf9593266634668 = 1000;
  agent.var_6f4b3de679c353ba = 1200;
  agent.var_cddc39d4b9f0b17d = 120;

  while(true) {
    reinforcement_timeout = 45;
    waittill_notify_or_timeout("goal", reinforcement_timeout);
    agent ob::function_e83e24c88a9a762c(0);

    if(self iswithinscriptgoalRadius()) {
      break;
    }
  }

  agent.var_4ebe755e0a0a430e = 0;
  function_8b6c9d30305fd087(agent, activityinstance);
}

function function_5c651df8cfad0810(var_b381b0883bcd4847) {
  activity_instance = self;
  player_list = var_b381b0883bcd4847.playerlist;

  if(isDefined(activity_instance) && activity_instance.state != "EndedState") {
    foreach(player in var_b381b0883bcd4847.playerlist) {
      player thread function_4a508fcbbea05afd();
    }
  }
}

function function_cf049bb9bdcb65b1(var_b381b0883bcd4847) {
  player_list = var_b381b0883bcd4847.playerlist;

  foreach(player in player_list) {
    function_99f612c991e568a0(player);
  }
}

function function_4a508fcbbea05afd() {
  self endon("death_or_disconnect");
  wait 120;
  player = self;

  if(function_5acc35fc66331385(player, 16946)) {
    player ent_flag_clear("quest_s0a1t4_mstr_approach");
    player ent_flag_clear("quest_s0a1t4_mstr_unlockdoor");
    player ent_flag_clear("quest_s0a1t4_mstr_lastenemydown");
    player ent_flag_clear("quest_s0a1t4_mstr_reenforce");
  }

  if(function_5acc35fc66331385(player, 17078)) {
    player ent_flag_clear("quest_s0a3t3_mercstronghold_approach");
    player ent_flag_clear("quest_s0a3t3_mercstronghold_nokey");
    player ent_flag_clear("quest_s0a3t3_mercstronghold_unlock");
    player ent_flag_clear("quest_s0a3t3_mercstronghold_lastenemy");
    player ent_flag_clear("quest_s0a3t3_mercstronghold_reinforce_resp");
  }
}

function private function_230e249807e20ca7(encounterid, agent) {
  self endon("activity_ended");
  self endon("instance_destroyed");
  agent waittill("death");

  if(function_d45cf335caa19838(encounterid) == 0) {
    self notify("merc_stronghold_cleared");

    if(isDefined(self.safe) && !istrue(self.safe.reinforcementscalled)) {
      thread function_9dbc2d439e39df13(self.var_6c29f2fdb0054bbe);
    }
  }
}

function private function_a7fafdf4ccb30418(players) {
  ob_humans::function_f7e877aa7e97d952(self, "<dev string:x498>");

  if(!isDefined(players) || !isarray(players) || players.size == 0) {
    return;
  }

  var_694cf27a7080216 = [];

  foreach(player in players) {
    if(!isDefined(player) || array_contains(var_694cf27a7080216, player)) {
      continue;
    }

    squadmembers = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
    var_8c4ed29f8594fb86 = zombie_challenges::function_f578373042c34e16(16946, "quest_s0a1t4_mstr_unlockdoor", squadmembers);
    on_mission = var_8c4ed29f8594fb86;

    if(!var_8c4ed29f8594fb86) {
      on_mission = namespace_838b439602b3acc7::function_5acc35fc66331385(player, 17078) || getdvarint(@ "hash_7b8b09c504a0c9a0", 0);
    }

    params = spawnStruct();
    params.player = player;
    callback::callback("on_unlock_merc_stronghold", params);

    if(var_8c4ed29f8594fb86 || on_mission) {
      foreach(squadmember in squadmembers) {
        var_694cf27a7080216[var_694cf27a7080216.size] = squadmember;
      }
    }
  }

  foreach(player in players) {
    if(!isDefined(player) || array_contains(var_694cf27a7080216, player)) {
      ob_humans::function_dd0ceeddc603cb3e(player, self, "<dev string:x4bc>");

      continue;
    }

    ob_humans::function_d170903981c617de(player);
    ob_humans::function_dd0ceeddc603cb3e(player, self, "<dev string:x4f8>");

    var_568cebb5b294f8c0 = namespace_9718b9a169c3ead0::function_d52f11eff492795d(player);
    thread namespace_9718b9a169c3ead0::function_90db3e7d7b085484(var_568cebb5b294f8c0, "activity_merc_stronghold_unlock_door", [player]);
  }
}

function private function_9dbc2d439e39df13(players) {
  ob_humans::function_f7e877aa7e97d952(self, "<dev string:x515>");

  if(!isDefined(players) || !isarray(players) || players.size == 0) {
    return;
  }

  var_694cf27a7080216 = [];

  foreach(player in players) {
    if(!isDefined(player) || array_contains(var_694cf27a7080216, player)) {
      continue;
    }

    squadmembers = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
    var_8c4ed29f8594fb86 = zombie_challenges::function_f578373042c34e16(16946, "quest_s0a1t4_mstr_lastenemydown", squadmembers);
    on_mission = var_8c4ed29f8594fb86;

    if(!var_8c4ed29f8594fb86) {
      on_mission = namespace_838b439602b3acc7::function_5acc35fc66331385(player, 17078) || getdvarint(@ "hash_7b8b09c504a0c9a0", 0);
    }

    params = spawnStruct();
    params.player = player;
    callback::callback("on_merc_stronghold_cleared_vo", params);

    if(var_8c4ed29f8594fb86 || on_mission) {
      foreach(squadmember in squadmembers) {
        var_694cf27a7080216[var_694cf27a7080216.size] = squadmember;
      }
    }
  }

  foreach(player in players) {
    if(!isDefined(player) || array_contains(var_694cf27a7080216, player)) {
      ob_humans::function_dd0ceeddc603cb3e(player, self, "<dev string:x538>");

      continue;
    }

    ob_humans::function_d170903981c617de(player);
    ob_humans::function_dd0ceeddc603cb3e(player, self, "<dev string:x573>");

    function_1281c7fff9456e18("merc_stronghold_vo_stronghold_cleared", [player]);
  }
}

function private function_dd78c34c770c2497(players) {
  ob_humans::function_f7e877aa7e97d952(self, "<dev string:x58f>");

  if(!isDefined(players) || !isarray(players) || players.size == 0) {
    return;
  }

  if(percent_chance(30)) {
    ob_humans::function_f7e877aa7e97d952(self, "<dev string:x5b8>");

    var_694cf27a7080216 = [];

    foreach(player in players) {
      if(!isDefined(player) || array_contains(var_694cf27a7080216, player)) {
        continue;
      }

      squadmembers = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
      var_8c4ed29f8594fb86 = zombie_challenges::function_f578373042c34e16(16946, "quest_s0a1t4_mstr_reenforce", squadmembers);
      on_mission = var_8c4ed29f8594fb86;

      if(!var_8c4ed29f8594fb86) {
        on_mission = namespace_838b439602b3acc7::function_5acc35fc66331385(player, 17078) || getdvarint(@ "hash_7b8b09c504a0c9a0", 0);
      }

      params = spawnStruct();
      params.player = player;
      callback::callback("on_merc_stronghold_reinforcement", params);

      if(var_8c4ed29f8594fb86 || on_mission) {
        foreach(squadmember in squadmembers) {
          var_694cf27a7080216[var_694cf27a7080216.size] = squadmember;
        }
      }
    }

    foreach(player in players) {
      if(!isDefined(player) || array_contains(var_694cf27a7080216, player)) {
        ob_humans::function_dd0ceeddc603cb3e(player, self, "<dev string:x5e7>");

        continue;
      }

      ob_humans::function_d170903981c617de(player);
      ob_humans::function_dd0ceeddc603cb3e(player, self, "<dev string:x62e>");

      function_1281c7fff9456e18("merc_stronghold_vo_reinforcement_convo", [player]);
    }

    return;
  }

  foreach(player in players) {
    ob_humans::function_d170903981c617de(player);
    ob_humans::function_dd0ceeddc603cb3e(player, self, "<dev string:x656>");
  }

  function_1281c7fff9456e18("merc_stronghold_vo_reinforcement", players);
}

function private function_7719e82ffdcda669(activityinstance) {
  instid = function_f0f498aed6f8fa5d(activityinstance);
  activitytype = namespace_4fda5d7358015a06::function_de53ed8e35d0ed7a(activityinstance);

  if(isDefined(activitytype) && activitytype == "REV_OB_MERC_STRONGHOLD") {
    assert(!isDefined(level.activities.strongholdinstances) || !isDefined(level.activities.strongholdinstances[instid]));
    level.activities.strongholdinstances[instid] = activityinstance;
  }
}

function private function_2ced1a9613bd11ab(activityinstance) {
  uniqueid = function_f0f498aed6f8fa5d(activityinstance);
  activitytype = namespace_4fda5d7358015a06::function_de53ed8e35d0ed7a(activityinstance);

  if(isDefined(activitytype) && activitytype == "REV_OB_MERC_STRONGHOLD") {
    level.activities.strongholdinstances[uniqueid] = undefined;
  }
}

function private function_97724206a31d0a1a() {
  var_ed2a434bd0491fba = [];

  if(isDefined(level.activities.strongholdinstances)) {
    foreach(instance in level.activities.strongholdinstances) {
      if(!isDefined(instance)) {
        continue;
      }

      activitystate = namespace_4fda5d7358015a06::function_73bd348a2ec322cf(instance);

      if(!isDefined(activitystate) || !(activitystate == "IdleState" || activitystate == "ActiveState")) {
        continue;
      }

      assert(namespace_4fda5d7358015a06::function_de53ed8e35d0ed7a(instance) == "<dev string:x684>");
      var_ed2a434bd0491fba[var_ed2a434bd0491fba.size] = instance;
    }
  }

  return var_ed2a434bd0491fba;
}

function private function_99f612c991e568a0(player) {
  assert(isDefined(player));

  ob_humans::function_dd0ceeddc603cb3e(player, self, "<dev string:x69e>");

  function_bbdcd857d0c2a65e(self, player, "PlayerJoinedOther");
  squadmembers = player scripts\cp_mp\utility\squad_utility::getsquadmembers(player.team, 1);
  var_8c4ed29f8594fb86 = zombie_challenges::function_f578373042c34e16(16946, "quest_s0a1t4_mstr_approach", squadmembers);
  on_mission = var_8c4ed29f8594fb86;

  if(!var_8c4ed29f8594fb86) {
    foreach(player in squadmembers) {
      if(namespace_838b439602b3acc7::function_5acc35fc66331385(player, 17078) || getdvarint(@ "hash_7b8b09c504a0c9a0", 0)) {
        on_mission = 1;
        break;
      }
    }
  }

  foreach(player in squadmembers) {
    params = spawnStruct();
    params.player = player;
    callback::callback("on_approach_merc_stronghold", params);
  }

  if(!var_8c4ed29f8594fb86 && !on_mission) {
    var_1fb2b7ffa4d3d9f1 = namespace_9718b9a169c3ead0::function_d52f11eff492795d(player, 1);

    foreach(player in squadmembers) {
      ob_humans::function_d170903981c617de(player);
    }

    ob_humans::function_dd0ceeddc603cb3e(player, self, "<dev string:x6bd>");

    thread namespace_9718b9a169c3ead0::function_90db3e7d7b085484(var_1fb2b7ffa4d3d9f1, "activity_merc_stronghold_approach", squadmembers);
    return;
  }

  ob_humans::function_dd0ceeddc603cb3e(player, self, "<dev string:x6d5>");
}

function private function_f390f4ebbe42c73c(var_d6bfa53c531546d6) {
  player = var_d6bfa53c531546d6.player;
  var_a917328b0b1b2a19 = var_d6bfa53c531546d6.enteredzone;

  if(!isDefined(player)) {
    return;
  }

  if(istrue(var_a917328b0b1b2a19) && isDefined(self.locked_doors) && self.locked_doors.size > 0) {
    ob_humans::function_dd0ceeddc603cb3e(player, self, "<dev string:x70a>");

    function_bbdcd857d0c2a65e(self, player, "PlayerJoinedOther");
    squadmembers = player scripts\cp_mp\utility\squad_utility::getsquadmembers(player.team, 1);

    if(isDefined(squadmembers) && isarray(squadmembers) && squadmembers.size > 0 && !namespace_9718b9a169c3ead0::function_1abf09c903e6c16b(squadmembers, "loot_key_human_stronghold")) {
      on_mission = namespace_838b439602b3acc7::function_5acc35fc66331385(player, 17078) || getdvarint(@ "hash_7b8b09c504a0c9a0", 0);

      if(on_mission) {
        params = spawnStruct();
        params.player = player;
        callback::callback("merc_stronghold_nokey", params);

        ob_humans::function_dd0ceeddc603cb3e(player, self, "<dev string:x727>");
      } else {
        ob_humans::function_d170903981c617de(player);
        ob_humans::function_dd0ceeddc603cb3e(player, self, "<dev string:x75c>");

        thread namespace_9718b9a169c3ead0::function_43007b614b2eb884("merc_stronghold_vo_no_key", squadmembers, 300);
      }

      return;
    }

    ob_humans::function_dd0ceeddc603cb3e(player, self, "<dev string:x772>");
  }
}

function private function_cefa7b514c4aff6d() {
  level endon("game_ended");
  safe = self.safe;

  while(isDefined(self.safe)) {
    self.safe waittill("cache_item_looted", lootid);
    var_25978461c6e4f61b = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);

    if(isDefined(var_25978461c6e4f61b) && isstring(var_25978461c6e4f61b) && issubstr(var_25978461c6e4f61b, "loot_key_human_fortress")) {
      thread function_3d04c4bc0abbcfa1(namespace_4c2b495b8d79cc2e::function_7ec62d1550b9897e(self, "Awareness_Zone"), var_25978461c6e4f61b);
      params = spawnStruct();
      params.cacheinstance = safe;
      params.stronghold_name = self.varianttag;
      callback::callback("stronghold_key_looted", params);
      endactivity(self, 1);
      break;
    }
  }
}

function private function_3d04c4bc0abbcfa1(players, var_25978461c6e4f61b) {
  ob_humans::function_f7e877aa7e97d952(self, "<dev string:x7ab>");

  if(!isDefined(players) || !isarray(players) || players.size == 0 || !isDefined(var_25978461c6e4f61b)) {
    return;
  }

  var_fbc7b9b8af0387d9 = "activity_merc_stronghold_success_generic";

  if(issubstr(var_25978461c6e4f61b, "allforone")) {
    var_fbc7b9b8af0387d9 = "activity_merc_stronghold_success_all_for_one";
  } else if(issubstr(var_25978461c6e4f61b, "chemist")) {
    var_fbc7b9b8af0387d9 = "activity_merc_stronghold_success_chemist";
  } else if(issubstr(var_25978461c6e4f61b, "maestro")) {
    var_fbc7b9b8af0387d9 = "activity_merc_stronghold_success_maestro";
  } else if(issubstr(var_25978461c6e4f61b, "rainmaker")) {
    var_fbc7b9b8af0387d9 = "activity_merc_stronghold_success_rainmaker";
  }

  if(isDefined(var_fbc7b9b8af0387d9)) {
    var_694cf27a7080216 = [];

    foreach(player in players) {
      if(!isDefined(player) || array_contains(var_694cf27a7080216, player)) {
        continue;
      }

      on_mission = (namespace_838b439602b3acc7::function_5acc35fc66331385(player, 17078) || getdvarint(@ "hash_7b8b09c504a0c9a0", 0)) && var_fbc7b9b8af0387d9 == "activity_merc_stronghold_success_all_for_one";

      if(on_mission) {
        params = spawnStruct();
        params.player = player;
        params.warlord = "allforone";
        callback::callback("merc_warlord_success", params);
        squadmembers = player scripts\cp_mp\utility\squad_utility::getsquadmembers(player.team, 1);

        foreach(squadmember in squadmembers) {
          var_694cf27a7080216[var_694cf27a7080216.size] = squadmember;
        }
      }
    }

    foreach(player in players) {
      if(!isDefined(player) || array_contains(var_694cf27a7080216, player)) {
        ob_humans::function_dd0ceeddc603cb3e(player, self, "<dev string:x7cc>");

        continue;
      }

      ob_humans::function_d170903981c617de(player);
      ob_humans::function_dd0ceeddc603cb3e(player, self, "<dev string:x805>" + var_fbc7b9b8af0387d9 + "<dev string:x828>");

      var_1d1eecf1ed7cbdb0 = namespace_9718b9a169c3ead0::function_d52f11eff492795d(player);
      thread namespace_9718b9a169c3ead0::function_90db3e7d7b085484(var_1d1eecf1ed7cbdb0, var_fbc7b9b8af0387d9, [player]);
    }

    return;
  }

  ob_humans::function_f7e877aa7e97d952(self, "<dev string:x82d>");
}

function function_99b95e1bcf411ecd() {
  agents = scripts\mp\utility\entity::function_d9ce8fb00f0e5fa1(self.origin, self.activity.attract_radius, "team_hundred_ninety");
  attracted = [];

  foreach(agent in agents) {
    if(!isPlayer(agent)) {
      attracted[attracted.size] = agent;
    }
  }

  agents = attracted;

  foreach(agent in agents) {
    agent ent_flag_init("activity_safe_attracted");
  }
}

function private function_f927f5dd26f5e076() {
  wait 5;
  function_6e7290c8ee4f558b("<dev string:x867>");
  function_a9a864379a098ad6("<dev string:x8a8>", "<dev string:x8c4>", &function_4cc130b05adeaae0);
  function_fe953f000498048f();
}

function function_4cc130b05adeaae0() {
  foreach(player in level.players) {
    function_38e113a4c30f6c0d("<dev string:x8f8>", player.origin, player.angles, 0, 1);
  }
}

# /