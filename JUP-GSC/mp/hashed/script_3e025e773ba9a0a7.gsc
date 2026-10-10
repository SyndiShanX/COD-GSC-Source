/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3e025e773ba9a0a7.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_185660037b9236c1;
#using script_220d0eb95a8fab7d;
#using script_2304453c69e996e2;
#using script_24946c036cb2f7b2;
#using script_24f248b33b79e48d;
#using script_2ff6eb4f5b8663fb;
#using script_3ab210ea917601e7;
#using script_41387eecc35b88bf;
#using script_46c7c73b1a7e4773;
#using script_4ef01fe6151dde4d;
#using script_4fdefae8b7bcdf73;
#using script_5753ba9c28794a65;
#using script_5d8202968463a21d;
#using script_638d701d263ee1ed;
#using script_64351208cb856df9;
#using script_6c6a46b757ce4c71;
#using script_6df6604a74a7a9c7;
#using script_7956d56c4922bd1;
#using script_7cfaa6fd841fb4dd;
#using script_d60e0219a7419e0;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\loot\common_cache;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\throttle;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_sentry_turret;
#using scripts\mp\hud_util;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#namespace namespace_200c114c5956154;

function function_1527eec0e5633eed() {}

function function_2a30840abb2a500c() {
  function_89384091f7a2dbd("REV_OB_MERC_CAMP", 0, &function_c75af84dd6eab876);
  function_89384091f7a2dbd("REV_OB_MERC_CAMP", 1, &function_6a8707b4b593d6fe);
  function_89384091f7a2dbd("REV_OB_MERC_CAMP", 2, &function_943ea7930b5c572a);
  function_89384091f7a2dbd("REV_OB_MERC_CAMP", 3, &function_d7a577aa657fd425);
  function_8b5b2a3392fc7e2a("PlayerJoin", &function_299ddda5b65917c8, "REV_OB_MERC_CAMP");
  function_8b5b2a3392fc7e2a("PlayerLeave", &function_12daaf2053fe7e28, "REV_OB_MERC_CAMP");
  function_8b5b2a3392fc7e2a("PlayerEnteredAwarenessZone", &function_57d8fbd500aa11b9, "REV_OB_MERC_CAMP");
  function_8b5b2a3392fc7e2a("PlayerExitedAwarenessZone", &function_91ce608117ff26d9, "REV_OB_MERC_CAMP");
}

function function_c75af84dd6eab876() {
  var_45c17c8bd7095cc4 = function_4188e118731a30f4();
  self.variant_definition = function_b9c4aa88ad97ee68(var_45c17c8bd7095cc4);
  setdvarifuninitialized(@ "hash_181e765f7a6858d2", self.variant_definition.var_c1b09676fae60012);
  setdvarifuninitialized(@ "hash_683ddaf9dc721a27", self.variant_definition.var_c1b09576fae5fddf);
  self.s_center = getStruct(self.varianttag, "targetname");
  assertex(isDefined(self.s_center), "<dev string:x1c>" + self.varianttag);
  self.var_11978328ba1dcca9 = namespace_4df2ab39b0e96ec7::function_4d8bb2d866771a10(self.s_center.origin);

  if(self.var_11978328ba1dcca9 == "difficulty_undefined") {
    self.var_11978328ba1dcca9 = "difficulty_easy";
  }

  self.var_afa707aba3ebdb93 = 1;

  switch (self.var_11978328ba1dcca9) {
    case #"hash_7bb2cd766703d463":
      self.var_b90c26f642e9b96e = "ob_minor_activity_complete_green";
      break;
    case #"hash_af83e47edfa8900a":
      self.var_afa707aba3ebdb93 = 2;
      self.var_b90c26f642e9b96e = "ob_minor_activity_complete_yellow";
      break;
    case #"hash_5343b465e56ec9a4":
      self.var_b90c26f642e9b96e = "ob_minor_activity_complete_red";
      break;
    case #"hash_651f76c0ad6741ec":
      self.var_b90c26f642e9b96e = "ob_minor_activity_complete_orange";
      break;
    default:
      break;
  }

  self.var_b16a3f666cef01c9 = undefined;
  self.var_5bf00987ba8a77f9 = undefined;
  self.var_8f42ac2e2e0b47dd = [];
  self.var_b2d13123da58d6fc = [];
  self.var_fa7a41661ea21397 = [];
  self.var_d8fa1a786f40b58 = [];
  self.var_f8929e2dc20c06e7 = [];
  self.var_178595624adb84da = [];
  self.var_7349395f496cee5e = [];
  self.var_ead59363d5449f72 = [];
  self.var_c2112be1bcab1204 = [];
  self.n_radius = 512;
  self.var_a83cd45596a51205 = undefined;
  self.var_cb8cd16df7c04d16 = [];
  self.b_airstrike = 1;
  level._effect["turret_muzflash"] = loadfx("vfx/core/muzflash/minigun_flash_cheap.vfx");
  thread function_fb8a05533bdeedf2();
  thread function_38dfcd58550b6616();
  thread function_184f4af0ddd67790();
  thread function_8a7a0773bc20b786();
  self.b_merc_camp = 1;
  namespace_9718b9a169c3ead0::function_cb146e445d78e9ee();
  self.var_bbbbbc7263f1c834 = getdvarint(@ "hash_633ecae936a5d71f", 1);
  self.var_961ebb1a79122846 = 0;
  waitframe();
  function_b6fc2c96b463c007(self);
}

function function_6a8707b4b593d6fe() {
  function_3e33031646de23b0(self);

  if(istrue(self.b_airstrike)) {
    namespace_64135de19550f047::function_daee52aa53ad6314(self.s_center.origin, 1500);
  }

  function_3fe9c2c70d8c34cc();
  thread function_80fecf012759bcf2();
  thread function_50f6110631f4d234();
  thread function_99f836857c743547();
}

function function_99f836857c743547() {
  self.s_center waittill("activity_ended");
  endactivity(self, 0);
}

function function_943ea7930b5c572a() {
  if(self.var_cb8cd16df7c04d16.size > 0) {
    foreach(drone in self.var_cb8cd16df7c04d16) {
      data = spawnStruct();
      data.inflictor = undefined;
      drone function_655249500e8f380f(data);
    }
  }

  thread function_a26e39e03a0d6739();

  if(isDefined(self.var_92867ef0a7302d31)) {
    function_2169641d6a403864(self.var_92867ef0a7302d31);
  }

  self.zombiesactive = 0;
}

function function_d7a577aa657fd425() {
  if(self.var_8f42ac2e2e0b47dd.size > 0) {
    foreach(cache in self.var_8f42ac2e2e0b47dd) {
      cache freescriptable();
    }
  }

  if(isDefined(self.loot_marker)) {
    self.loot_marker setscriptablepartstate("model", "invisible");
  }

  if(self.var_c2112be1bcab1204.size > 0) {
    foreach(scriptable in self.var_c2112be1bcab1204) {
      scriptable setscriptablepartstate("state", "hidden");
    }
  }

  if(isDefined(self.var_c441245b5c737557)) {
    self.var_c441245b5c737557 freescriptable();
  }

  if(self.var_ead59363d5449f72.size > 0) {
    foreach(sentry in self.var_ead59363d5449f72) {
      if(isDefined(sentry)) {
        sentry notify("kill_turret", 1);
      }
    }
  }

  if(self.var_7349395f496cee5e.size > 0) {
    foreach(barrel in self.var_7349395f496cee5e) {
      if(isDefined(barrel)) {
        barrel freescriptable();
        barrel = undefined;
      }
    }
  }

  if(self.var_d8fa1a786f40b58.size > 0) {
    function_486b0f579d5b6dae(self.var_d8fa1a786f40b58);
  }

  if(self.var_fa7a41661ea21397.size > 0) {
    foreach(mine in self.var_fa7a41661ea21397) {
      if(isDefined(mine)) {
        mine delete();
      }
    }
  }

  if(self.var_b2d13123da58d6fc.size > 0) {
    foreach(vehicle in self.var_b2d13123da58d6fc) {
      if(isDefined(vehicle)) {
        b_delete = 1;
        occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(vehicle, 0);

        foreach(occupant in occupants) {
          if(array_contains(level.players, occupant)) {
            b_delete = 0;
          }
        }

        if(istrue(b_delete)) {
          vehicle.var_a8f4bb03b366aa80 = 1;
          thread scripts\cp_mp\vehicles\vehicle::vehicle_death(vehicle);
        }
      }
    }
  }

  self.var_189ca75754491759 = undefined;
  self.var_66c96b07839101f9 = undefined;
}

function function_5897d7d67e40152c() {}

function function_bdc8d4d334ec48f5(activityinstance) {
  activityinstance endon("activity_ended");
  self endon("death");
  self endon("leaving");
  self endon("crashing");

  while(true) {
    self waittill("damage", amount, attacker);

    if(array_contains(level.players, attacker)) {
      activityinstance notify("player_attacking", attacker);
    }

    wait 1;
  }
}

function function_c19d2513ad75af8d() {}

function function_50f6110631f4d234() {
  self endon("activity_ended");
  var_89f9905ac0967ce = [];
  self.var_865c65851de2f738 = self.s_center function_954eb52ab4cdeb46("s_merc_camp_sentry", "targetname");

  if(self.var_865c65851de2f738.size > 0) {
    var_89f9905ac0967ce = array_add(var_89f9905ac0967ce, "s_merc_camp_sentry");
  }

  self.var_2d2565d73a005313 = self.s_center function_954eb52ab4cdeb46("s_merc_camp_drone", "targetname");

  if(self.var_2d2565d73a005313.size > 0) {
    thread function_57099d469cbc7133();
  }

  var_30609ba9b7dd19bf = int(min(var_89f9905ac0967ce.size, self.var_afa707aba3ebdb93));
  str_override = getDvar(@ "hash_b13b59a0d62a36fd", "merc_camp_random");

  if(str_override == "merc_camp_all") {
    var_30609ba9b7dd19bf = var_89f9905ac0967ce.size;
  }

  var_89f9905ac0967ce = array_randomize(var_89f9905ac0967ce);
  var_23890c9beb8de5ba = array_slice(var_89f9905ac0967ce, 0, var_30609ba9b7dd19bf);

  foreach(str_hazard in var_23890c9beb8de5ba) {
    switch (str_hazard) {
      case #"hash_607ec07c00f34010":
        thread function_946602198aa47915();
        break;
      case #"hash_a5c91c69bb471104":
        if(getdvarint(@ "hash_e865e223283f1d8d", 0) == 1 || namespace_4df2ab39b0e96ec7::function_4d8bb2d866771a10(self.s_center.origin) != "difficulty_easy") {
          thread function_795bb4f677bc4a0c();
        }

        break;
      default:
        assert("<dev string:x5d>" + str_hazard);
        break;
    }

    waitframe();
  }
}

function function_3fe9c2c70d8c34cc() {
  self endon("activity_ended");
  assertex(isDefined(self.s_center.script_noteworthy), "<dev string:x7e>" + self.s_center.targetname + "<dev string:xaa>");
  var_63c0b38ddf088f10 = "ev_" + self.s_center.script_noteworthy;
  self.var_b16a3f666cef01c9 = function_3ee36bc763779ba1(var_63c0b38ddf088f10, 1, 1, 1, 2);
  region_difficulty = namespace_4df2ab39b0e96ec7::function_4d8bb2d866771a10(self.s_center.origin);

  if(region_difficulty == "difficulty_undefined") {
    region_difficulty = getDvar(@ "hash_2d2062bab211cbf5", "difficulty_easy");
  }

  function_d37068aac7785c04(self.var_b16a3f666cef01c9, region_difficulty, 1);
  assertex(isDefined(self.var_b16a3f666cef01c9), "<dev string:xf9>" + var_63c0b38ddf088f10);

  if(isDefined(self.var_b16a3f666cef01c9)) {
    function_84b829dec3e573eb(self.var_b16a3f666cef01c9, &function_a1cf7371d74e5bc2, self);
    function_ce9c21523336cdbc(self.var_b16a3f666cef01c9, &function_fde8b0ef95665cb2, self);
    function_cf06967ecf7cfb28(self.var_b16a3f666cef01c9, &function_fdff165a3e012db6, self);
    scripts\cp_mp\agents\ai_spawn_director::function_f81b7c3f18ef98be(self.var_b16a3f666cef01c9, &function_29f060323ff45d33, self);
  }

  thread function_8d2984d08374f307();
  thread function_eb2efff99891ff74(self.var_b16a3f666cef01c9);
}

function function_80fecf012759bcf2() {
  self endon("activity_ended");

  if(!isDefined(self.variant_definition.zombieencounter) || self.variant_definition.zombieencounter == "") {
    return;
  }

  region_difficulty = namespace_4df2ab39b0e96ec7::function_4d8bb2d866771a10(self.s_center.origin);

  if(region_difficulty == "difficulty_undefined") {
    region_difficulty = getDvar(@ "hash_2d2062bab211cbf5", "difficulty_easy");
  }

  var_e2faf0f2ae7c812f = 0;
  chance = randomint(100);

  switch (region_difficulty) {
    case #"hash_7bb2cd766703d463":
      difficulty_chance = getdvarint(@ "hash_181e765f7a6858d2", 0);
      break;
    case #"hash_af83e47edfa8900a":
      difficulty_chance = getdvarint(@ "hash_683ddaf9dc721a27", 0);
      break;
    default:
      difficulty_chance = 0;
      break;
  }

  if(chance < difficulty_chance) {
    var_e2faf0f2ae7c812f = 1;
  }

  if(var_e2faf0f2ae7c812f) {
    self.a_s_zombie = [];
    self.a_s_zombie = self.s_center function_954eb52ab4cdeb46(self.variant_definition.var_eaa2211b57edc70, "targetname");
    self waittill("merc_camp_soldiers_spawned");

    if(self.a_s_zombie.size > 0) {
      pos = array_random(self.a_s_zombie);
    } else {
      pos = function_da1778e7ead6a780();
    }

    if(isDefined(pos)) {
      self.var_92867ef0a7302d31 = ai_spawn_director::spawn_request("ai_encounter:" + self.variant_definition.zombieencounter, pos.origin, self.variant_definition.zombieradius, 1, 1, 0);
      self.zombieorigin = pos.origin;
      ai_spawn_director::function_e4a67fe4ddca7ed5(self.var_92867ef0a7302d31, &function_f76cd41cb452d6d0, self);
      function_d37068aac7785c04(self.var_92867ef0a7302d31, region_difficulty, 1);
      self.zombiesactive = 1;
      thread function_5fc755f9665c9445();
      thread function_de20787ef0f118bc();
    }
  }
}

function function_da1778e7ead6a780() {
  self endon("activity_ended");
  attempts = 0;

  while(true) {
    angle = randomfloatrange(1, 360);
    rad = randomfloatrange(self.variant_definition.var_a8a7baed4e3bac32, self.variant_definition.zombiemaxdistance);
    pos = spawnStruct();
    cx = self.s_center.origin[0];
    cy = self.s_center.origin[1];
    cz = self.s_center.origin[2];
    dist = 0;
    posx = cx + rad * cos(angle);
    posy = cy + rad * sin(angle);
    pos.origin = getclosestpointonnavmesh((posx, posy, cz), undefined, 0, 0, 0);
    center = getclosestpointonnavmesh(self.s_center.origin, undefined, 0, 0, 0);

    if(isDefined(pos.origin) && isDefined(center)) {
      dist = distance2d(pos.origin, center);
    }

    if(dist > self.variant_definition.var_a8a7baed4e3bac32 && dist < self.variant_definition.zombiemaxdistance) {
      break;
    }

    wait 0.1;
    attempts += 1;

    if(attempts > 5) {
      break;
    }
  }

  return pos;
}

function function_fb8a05533bdeedf2() {
  self endon("activity_ended");
  structs = self.s_center function_954eb52ab4cdeb46("s_merc_camp_vehicle", "targetname");

  if(structs.size > 0) {
    if(structs.size > 1) {
      var_cfbbb24f5eaee23a = int(min(structs.size, 1));
      var_eca97cd144d9e144 = int(min(structs.size, 3));

      if(var_eca97cd144d9e144 > var_cfbbb24f5eaee23a) {
        n_vehicles = randomintrange(var_cfbbb24f5eaee23a, var_eca97cd144d9e144);
      } else {
        n_vehicles = var_cfbbb24f5eaee23a;
      }

      structs_random = array_randomize(structs);
      var_a3ed1b4a55e2a2c8 = array_slice(structs_random, 0, n_vehicles);
    } else {
      var_a3ed1b4a55e2a2c8 = structs;
    }

    foreach(struct in var_a3ed1b4a55e2a2c8) {
      spawn_type = "veh9_suv_1996";

      if(isDefined(struct.script_noteworthy)) {
        spawn_type = struct.script_noteworthy;
      } else {
        spawn_type = random(["veh9_suv_1996", "atv", "veh9_techo_rebel_armor", "veh9_utv"]);
      }

      spawn_data = spawnStruct();
      spawn_data.origin = struct.origin + (0, 0, 128);
      spawn_data.angles = struct.angles;
      vehicle = vehicle_spawn(spawn_type, spawn_data);

      if(isDefined(vehicle)) {
        self.var_b2d13123da58d6fc = array_add(self.var_b2d13123da58d6fc, vehicle);
      }

      waitframe();
    }
  }
}

function function_38dfcd58550b6616() {
  self endon("activity_ended");
  var_7f8c8f8cc7f509da = "e_cover_" + self.s_center.script_noteworthy;
  self.var_d8fa1a786f40b58 = function_e9158c9e8c391f25(var_7f8c8f8cc7f509da);
}

function function_8a7a0773bc20b786() {
  self endon("activity_ended");
  str_flagname = "s_merc_camp_flag_" + self.s_center.script_noteworthy;
  scriptables = getentitylessscriptablearray(str_flagname, "targetname", self.s_center.origin, 3000);

  foreach(scriptable in scriptables) {
    if(isDefined(scriptable.classname) && issubstr(scriptable.classname, "scriptable_ob_toggleable")) {
      scriptable setscriptablepartstate("state", "visible");
      self.var_c2112be1bcab1204 = array_add(self.var_c2112be1bcab1204, scriptable);
    }
  }
}

function function_946602198aa47915() {
  self endon("activity_ended");
  assertex(self.var_f492e9f0a5184244.size > 0, "<dev string:x153>" + "<dev string:x18e>");

  while(self.var_178595624adb84da.size == 0) {
    waitframe();
  }

  n_mines = self.var_f492e9f0a5184244.size;

  if(self.var_f492e9f0a5184244.size > 1) {
    var_579e6443e44e1fed = int(min(self.var_f492e9f0a5184244.size, 3));
    var_74379ac55697384f = int(min(self.var_f492e9f0a5184244.size, 12));

    if(var_74379ac55697384f > var_579e6443e44e1fed) {
      n_mines = randomintrange(var_579e6443e44e1fed, var_74379ac55697384f);
    } else {
      n_mines = var_579e6443e44e1fed;
    }
  }

  structs_random = array_randomize(self.var_f492e9f0a5184244);

  for(index = 0; index < n_mines; index++) {
    badplace_id = "bp_" + self.s_center.script_noteworthy + "_mine" + index;
    mine = function_908ec13fb4d6cede(structs_random[index].origin, badplace_id, self.var_178595624adb84da[0], undefined, mine.angles, 1);
    mine.allowfriendlyfire = 1;
    self.var_fa7a41661ea21397 = array_add(self.var_fa7a41661ea21397, mine);
    mine thread function_d86fd1410a32c79(self);
    function_f0675d4a690011d6(mine);
    mine thread function_bdc8d4d334ec48f5(self);
    waitframe();
  }
}

function function_d86fd1410a32c79(activityinstance) {
  self endon("death");
  activityinstance endon("activity_ended");
  self waittill("trigger_grenade", ents);

  if(ents.size > 0) {
    if(ents[0] scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(ents[0], 0);

      if(isDefined(occupants) && occupants.size > 0) {
        foreach(occupant in occupants) {
          if(array_contains(level.players, occupant)) {
            ents[0] = occupant;
          }
        }
      }
    }

    if(array_contains(level.players, ents[0])) {
      if(!array_contains(activityinstance.var_6c29f2fdb0054bbe, ents[0])) {
        function_bbdcd857d0c2a65e(activityinstance, ents[0], "PlayerJoinedDamage");
      }

      activityinstance notify("player_attacking", ents[0]);
    }
  }
}

function function_795bb4f677bc4a0c() {
  self endon("activity_ended");
  assertex(self.var_865c65851de2f738.size > 0, "<dev string:x153>" + "<dev string:x1a2>");
  self.var_70507c40273c3d2c = throttle_initialize("sentry_health_bar_update", 2);

  if(!isDefined(level.sentrysettings["ai_sentry_turret"])) {
    scripts\mp\ai_sentry_turret::init();
  }

  namespace_64135de19550f047::function_64d1082e50f1eed();
  var_bee2cac8b9e57cc5 = self.var_865c65851de2f738.size;

  if(self.var_865c65851de2f738.size > 1) {
    var_41196d8061932ee4 = int(min(self.var_865c65851de2f738.size, 1));
    var_cdbc8c42217fae4a = int(min(self.var_865c65851de2f738.size, 3));

    if(var_cdbc8c42217fae4a > var_41196d8061932ee4) {
      var_bee2cac8b9e57cc5 = randomintrange(var_41196d8061932ee4, var_cdbc8c42217fae4a);
    } else {
      var_bee2cac8b9e57cc5 = var_41196d8061932ee4;
    }
  }

  structs_random = array_randomize(self.var_865c65851de2f738);

  for(index = 0; index < var_bee2cac8b9e57cc5; index++) {
    sentry = function_586d4d82f07e0d09(structs_random[index]);
    self.var_ead59363d5449f72 = array_add(self.var_ead59363d5449f72, sentry);
    function_f0675d4a690011d6(sentry);
    sentry laseroff();
    sentry thread function_bdc8d4d334ec48f5(self);
    sentry thread function_e61d8bebfc9cce2a(self);
    waitframe();
  }
}

function function_e61d8bebfc9cce2a(activityinstance) {
  self endon("death");
  activityinstance endon("activity_ended");

  while(true) {
    if(isDefined(self.besttarget) && array_contains(level.players, self.besttarget)) {
      if(!array_contains(activityinstance.var_6c29f2fdb0054bbe, self.besttarget)) {
        function_bbdcd857d0c2a65e(activityinstance, self.besttarget, "PlayerJoinedDamage");
      }

      activityinstance notify("player_attacking", self.besttarget);
    }

    wait 1;
  }
}

function function_184f4af0ddd67790() {
  self endon("activity_ended");
  self.loot_marker = getentitylessscriptablearray("s_loot_marker_" + self.s_center.script_noteworthy, "targetname")[0];

  if(isDefined(self.loot_marker)) {
    self.loot_marker setscriptablepartstate("model", "visible");
    var_9b21ca26a5521d14 = (-38, 5, 0);
    var_e7a41455efc79691 = (0, 90, 0);
    cache_pos = coordtransform(var_9b21ca26a5521d14, self.loot_marker.origin, self.loot_marker.angles);
    self.var_c441245b5c737557 = common_cache::cache_spawncache(#"hash_a13332f0087da3c4", cache_pos, self.loot_marker.angles + var_e7a41455efc79691);
    self.var_c441245b5c737557.var_69971d3fabc4c29b = 1;

    if(!isDefined(self.var_c441245b5c737557) || "<dev string:x1b8>" != self.var_c441245b5c737557 getscriptablepartstate("<dev string:x1c9>")) {
      println("<dev string:x1d1>" + self.var_c441245b5c737557.origin);
    }

    thread function_e4cb6ba98b816518();
    return;
  }

  structs = self.s_center function_954eb52ab4cdeb46("s_merc_camp_cache", "targetname");

  if(structs.size > 0) {
    if(structs.size > 1) {
      var_c861c692ff9761d8 = int(min(structs.size, 1));
      var_1333f42d9fc03d92 = int(min(structs.size, 3));

      if(var_1333f42d9fc03d92 > var_c861c692ff9761d8) {
        n_caches = randomintrange(var_c861c692ff9761d8, var_1333f42d9fc03d92);
      } else {
        n_caches = var_c861c692ff9761d8;
      }

      structs_random = array_randomize(structs);
      var_a3ed1b4a55e2a2c8 = array_slice(structs_random, 0, n_caches);
    } else {
      var_a3ed1b4a55e2a2c8 = structs;
    }

    foreach(struct in var_a3ed1b4a55e2a2c8) {
      var_15bcd5035937f3bd = getgroundposition(struct.origin, 32);
      cache = spawnscriptable("br_loot_cache", var_15bcd5035937f3bd, struct.angles);

      while(!isDefined(cache)) {
        waitframe();
      }

      cache setscriptablepartstate("body", "closed_usable");
      self.var_8f42ac2e2e0b47dd = array_add(self.var_8f42ac2e2e0b47dd, cache);
    }
  }
}

function function_a1cf7371d74e5bc2(requestid, userdata) {
  activityinstance = userdata;
  activityinstance endon("activity_ended");
}

function function_fde8b0ef95665cb2(requestid, userdata, agent, data) {
  agent endon("death");

  if(!isDefined(agent.ob)) {
    agent.ob = spawnStruct();
  }

  activityinstance = userdata;
  activityinstance endon("activity_ended");
  activityinstance.var_f8929e2dc20c06e7 = array_add(activityinstance.var_f8929e2dc20c06e7, agent);
  activityinstance.var_178595624adb84da = array_add(activityinstance.var_178595624adb84da, agent);

  if(activityinstance.var_178595624adb84da.size == 1) {
    activityinstance notify("merc_camp_soldiers_spawned");
  }

  agent thread function_48588a3353c21eef(activityinstance);
  agent thread function_bdc8d4d334ec48f5(activityinstance);
  agent ent_flag_init("activity_mercCamp_spawned");

  if(isDefined(activityinstance.var_6c29f2fdb0054bbe) && activityinstance.var_6c29f2fdb0054bbe.size > 0) {
    agent thread function_661fcf655409f736(activityinstance);
  }
}

function function_fdff165a3e012db6(requestid, activityinstance) {
  assert(isDefined(activityinstance));
  assert(function_73bd348a2ec322cf(activityinstance) == "<dev string:x231>");
  activityinstance.var_532109d48fb82eba = 1;
  activityinstance function_c2db087f74636224();
  namespace_40713433c91dd86c::function_c402ecda1e84ba27(activityinstance.var_6c29f2fdb0054bbe, 0, activityinstance.var_11978328ba1dcca9, activityinstance.s_center.origin);

  if(istrue(self.var_bbbbbc7263f1c834) && !istrue(self.keylooted)) {
    callback::callback("analytics_proximity_activity_completed");
  }

  var_8a060ef9fe48fc5d = activityinstance.var_d953047f1b4c7c9.scriptable;
  activityinstance.var_67c56bf0b03688bf = array_remove_index(activityinstance.var_67c56bf0b03688bf, var_8a060ef9fe48fc5d.index);
  var_8a060ef9fe48fc5d freescriptable();

  if(activityinstance.var_cb8cd16df7c04d16.size > 0) {
    foreach(drone in activityinstance.var_cb8cd16df7c04d16) {
      data = spawnStruct();
      data.inflictor = undefined;
      drone function_655249500e8f380f(data);
    }
  }

  endactivity(activityinstance, 1);
}

function function_f76cd41cb452d6d0(requestid, userdata, agent, data) {
  nav_point = getclosestpointonnavmesh(userdata.s_center.origin);
  agent setgoalpos(nav_point, 512);
  agent ent_flag_wait("stealth_enabled");
  agent thread function_5ff7e9e4289a75cb(userdata);
}

function function_cba77a1a3ec18752() {
  foreach(agent in self.var_178595624adb84da) {
    if(!isDefined(agent.var_526f1dcf41e8b261)) {
      agent.var_526f1dcf41e8b261 = 3;
    }

    switch (self.var_11978328ba1dcca9) {
      case #"hash_7bb2cd766703d463":
        assert(self.variant_definition.var_366e63b4885121cc > 0);
        agent.var_526f1dcf41e8b261 /= self.variant_definition.var_366e63b4885121cc;
        break;
      case #"hash_af83e47edfa8900a":
        assert(self.variant_definition.var_366e66b488512865 > 0);
        agent.var_526f1dcf41e8b261 /= self.variant_definition.var_366e66b488512865;
        break;
      default:
        break;
    }
  }

  function_18790a3cb3f88db7(self.var_92867ef0a7302d31);
  self.zombiesactive = 0;
}

function function_29f060323ff45d33(requestid, userdata, var_9f82bb66fd374ef5) {
  activityinstance = userdata;
  activityinstance endon("activity_ended");
  requestdata = function_9a39e23c3c52c2af(requestid);
  snipercount = 0;
  var_61568ea9915dce8a = 0;

  if(isDefined(requestdata.ai) && isarray(requestdata.ai)) {
    foreach(ai in requestdata.ai) {
      if(isDefined(ai) && isDefined(ai.subclass)) {
        switch (ai.subclass) {
          case #"hash_c9beeb2ff7f370db":
            var_61568ea9915dce8a++;
            break;
          case #"hash_5a24fffee0d81302":
            snipercount++;
            break;
          case #"hash_806a6487959205af":
            if(issharedfuncdefined("rift_gate_relics_s3", "track_merc_captain_kill")) {
              [[getsharedfunc("rift_gate_relics_s3", "track_merc_captain_kill")]](ai);
            }

            break;
          default:
            break;
        }
      }
    }
  }

  votype = "s_merc_camp_type_default";

  if(var_61568ea9915dce8a != 0 && snipercount < var_61568ea9915dce8a) {
    votype = "s_merc_camp_type_tactician";
  } else if(snipercount != 0 && snipercount >= var_61568ea9915dce8a) {
    votype = "s_merc_camp_type_sniper";
  }

  activityinstance.var_fbe46459634710c1 = votype;
}

function function_3e87ce8983612b15(activityinstance) {
  self endon("death");
  activityinstance endon("activity_ended");

  while(true) {
    if(istrue(self.scripted_mode)) {
      wait 1;
      continue;
    }

    self notify("startCombatRush");
    wait randomfloatrange(5, 15);

    if(!isDefined(self.enemy)) {
      continue;
    }

    self aieventlistenerevent("combat", self.enemy, self.enemy.origin);
    self agentsetfavoriteenemy(self.enemy);
    self setagentattacker(self.enemy);
    self getenemyinfo(self.enemy);
    self forcethreatupdate();
    var_3445e5886ef95e60 = self.origin - self.enemy.origin;

    if(length(var_3445e5886ef95e60) < 256) {
      continue;
    }

    self.goalradius = 128;
    goalradius = randomfloatrange(384, 768);
    goalangle = randomfloatrange(-90, 90);
    testpos = goalradius * vectorNormalize(rotatevector(var_3445e5886ef95e60, (0, goalangle, 0)));
    goalpos = self getclosestreachablepointonnavmesh(testpos);
    goalnode = self findbestcovernode(undefined, 1, goalpos, 0);
    goal = undefined;

    if(isDefined(goalnode)) {
      self setgoalnode(goalnode);
      self usecovernodeifpossible(goalnode);
      goal = goalnode.origin;
    } else {
      self setgoalpos(goalpos);
      goal = goalpos;
    }

    self.var_b88dec7ef382d5d9 = 1;
    waitframe();
    thread function_999a08cfdf4c612d(self, goal);
    waittill_any_timeout_1(10, "goal");
    self.var_b88dec7ef382d5d9 = 0;
  }
}

function function_999a08cfdf4c612d(activityinstance, goal) {
  self endon("death");
  level endon("game_ended");
  activityinstance endon("activity_ended");

  while(istrue(self.var_b88dec7ef382d5d9)) {
    thread draw_ent_axis((1, 0, 0), 10, 30);
    thread draw_circle(goal, 32, (1, 0, 0), 1, 0, 10);
    thread draw_line_for_time(self.origin, goal, 1, 0, 0, 0.1);

    wait 0.1;
  }
}

function function_661fcf655409f736(activityinstance) {
  self endon("death");
  activityinstance endon("activity_ended");

  while(istrue(self.scripted_mode)) {
    wait 0.2;
  }

  player = undefined;
  goal = activityinstance.s_center;
  dist = distance2d(self.origin, activityinstance.s_center.origin);

  if(isDefined(activityinstance.var_6c29f2fdb0054bbe) && activityinstance.var_6c29f2fdb0054bbe.size > 0) {
    a_players = sortbydistancecullbyradius(activityinstance.var_6c29f2fdb0054bbe, self.origin, dist * 1.25);

    if(a_players.size > 0) {
      player = random(a_players);
      goal = player;
    }
  }

  self notify("startCombatRush");
  scripts\mp\ai_behavior::function_304da84d9a815c01(goal.origin, 512, 0);

  if(isDefined(player)) {
    self aieventlistenerevent("combat", player, player.origin);
    self agentsetfavoriteenemy(player);
    self setagentattacker(player);
    self getenemyinfo(player);
    self forcethreatupdate();
  }
}

function function_48588a3353c21eef(activityinstance) {
  self endon("death");
  activityinstance endon("activity_ended");
  thread scripts\cp_mp\agents\ai_spawn_director::function_e64438bcaad08d5c();

  switch (activityinstance.var_11978328ba1dcca9) {
    case #"hash_7bb2cd766703d463":
      assert(activityinstance.variant_definition.var_366e63b4885121cc > 0);
      self.var_526f1dcf41e8b261 *= activityinstance.variant_definition.var_366e63b4885121cc;
      break;
    case #"hash_af83e47edfa8900a":
      assert(activityinstance.variant_definition.var_366e66b488512865 > 0);
      self.var_526f1dcf41e8b261 *= activityinstance.variant_definition.var_366e66b488512865;
      break;
    default:
      break;
  }

  while(true) {
    if(isDefined(self.enemy)) {
      if(isPlayer(self.enemy)) {
        if(!array_contains(activityinstance.var_6c29f2fdb0054bbe, self.enemy)) {
          function_bbdcd857d0c2a65e(activityinstance, self.enemy, "PlayerJoinedDamage");
        }

        activityinstance notify("player_attacking", self.enemy);

        if(istrue(activityinstance.zombiesactive)) {
          activityinstance function_cba77a1a3ec18752();
        }
      } else if(self.enemy.team == "team_two_hundred") {
        if(!istrue(activityinstance.var_9d9556835372d3ac)) {
          activityinstance notify("zombies_attacking");
        }
      }
    }

    wait 1;
  }
}

function function_5fc755f9665c9445() {
  level endon("game_ended");
  self endon("activity_ended");

  while(true) {
    if(istrue(self.var_9d9556835372d3ac)) {
      var_918abacd628ed946 = 0;

      foreach(agent in self.var_178595624adb84da) {
        if(agent.bisincombat) {
          var_918abacd628ed946 = 1;
          break;
        }
      }

      if(!var_918abacd628ed946) {
        self.var_9d9556835372d3ac = 0;
        self notify("zombies_defeated");
      }
    }

    wait 1;
  }
}

function function_de20787ef0f118bc() {
  level endon("game_ended");
  self endon("activity_ended");
  centerpos = getclosestpointonnavmesh(self.s_center.origin);
  likelypath = findpathcustom(centerpos, self.zombieorigin);
  self.defendgoalpos = function_e8886bdbac4b238(likelypath);

  while(true) {
    self waittill("zombies_attacking");
    var_f6f1142a78a26af9 = [];
    self.var_fa353b0b729cac03 = [];
    self.var_9d9556835372d3ac = 1;
    var_f6f1142a78a26af9 = array_sort_with_func(self.var_178595624adb84da, &function_2daf9ed06b3947b8);

    for(i = 0; i < var_f6f1142a78a26af9.size && self.var_fa353b0b729cac03.size < self.variant_definition.var_6148f30571b073ba; i++) {
      defender = var_f6f1142a78a26af9[i];
      defdistance = distance(defender.origin, self.defendgoalpos);

      if(defender.subclass != "ob_sniper" && defender.subclass != "ob_rocketeer" && defdistance < 2 * self.variant_definition.var_5a6d6a38b17d1c22) {
        defender setgoalpos(self.defendgoalpos, self.variant_definition.var_5a6d6a38b17d1c22);
        defender.keepclaimednodeifvalid = 1;
        self.var_fa353b0b729cac03 = array_add(self.var_fa353b0b729cac03, defender);
      }
    }

    self waittill("zombies_defeated");

    foreach(agent in self.var_fa353b0b729cac03) {
      if(!isDefined(agent) || !isalive(agent)) {
        continue;
      }

      if(!isDefined(agent.team) || agent.team != "team_hundred_ninety") {
        continue;
      }

      if(distancesquared(self.s_center.origin, agent.origin) >= squared(5000)) {
        continue;
      }

      agent setgoalpos(self.s_center.origin, 1024);
      defender.keepclaimednodeifvalid = 0;
    }

    wait 1;
  }
}

function function_2daf9ed06b3947b8(a, b) {
  dista = distance(a.origin, self.defendgoalpos);
  distb = distance(b.origin, self.defendgoalpos);

  if(dista < distb) {
    return 1;
  }

  return 0;
}

function function_e8886bdbac4b238(navpath) {
  lastpoint = undefined;

  foreach(point in navpath) {
    dist = distance(point, self.s_center.origin);

    if(dist < self.variant_definition.var_321b04cfd62ce287) {
      if(!isDefined(lastpoint) || dist > distance(self.s_center.origin, lastpoint)) {
        lastpoint = point;
      }
    }
  }

  return lastpoint;
}

function function_5ff7e9e4289a75cb(activityinstance) {
  self endon("death");
  activityinstance endon("activity_ended");
  wait 1;
  self setstealthstate("combat");
  self notify("startCombatRush");
}

function function_eb2efff99891ff74(var_e7826c567072d609) {
  self endon("activity_ended");
  struct = self.s_center function_98edf48d14333f3f("s_merc_camp_guard", "targetname");

  if(!isDefined(struct)) {
    struct = self.s_center;
  }

  var_564f5428abdc3636 = 256;

  if(isDefined(struct.radius)) {
    var_564f5428abdc3636 = struct.radius;
  }

  var_9aa7d97c2a6cef5b = var_564f5428abdc3636 * var_564f5428abdc3636;
  self waittill("player_attacking", player);
  self.playerengaged = 1;

  while(true) {
    var_40a6343aa51dd430 = function_9a39e23c3c52c2af(var_e7826c567072d609);
    var_96caf68dd2f8f406 = var_40a6343aa51dd430.ai;

    if(var_96caf68dd2f8f406.size == 0) {
      return;
    }

    var_b3d2c590b879f78d = sortbydistance(var_96caf68dd2f8f406, struct.origin);

    foreach(ai_soldier in var_b3d2c590b879f78d) {
      waitframe();

      if(!isDefined(ai_soldier) || !isalive(ai_soldier)) {
        continue;
      }

      self.var_5bf00987ba8a77f9 = ai_soldier;
      break;
    }

    if(isDefined(self.var_5bf00987ba8a77f9)) {
      self.var_5bf00987ba8a77f9 scripts\mp\ai_behavior::function_304da84d9a815c01(struct.origin, var_564f5428abdc3636, 0);
      self.var_5bf00987ba8a77f9 waittill("death");
    }

    wait randomfloatrange(4, 6);
  }
}

function function_8d2984d08374f307() {
  self endon("activity_ended");
  old_player = undefined;

  while(true) {
    self waittill("player_attacking", player);
    self.lastattackedtime = gettime();

    if(isDefined(player)) {
      if(isDefined(old_player) && player == old_player) {
        wait 1;
        continue;
      }

      self.var_178595624adb84da = array_removedead_or_dying(self.var_178595624adb84da);

      foreach(soldier in self.var_178595624adb84da) {
        if(isDefined(soldier) && !isDefined(soldier.enemy)) {
          soldier notify("startCombatRush");
          soldier aieventlistenerevent("combat", player, player.origin);
          soldier agentsetfavoriteenemy(player);
          soldier setagentattacker(player);
          soldier getenemyinfo(player);
          soldier forcethreatupdate();
          waitframe();
        }
      }

      old_player = player;
    }

    wait 1;
  }
}

function function_57099d469cbc7133() {
  self endon("activity_ended");
  assertex(self.var_2d2565d73a005313.size > 0, "<dev string:x153>" + "<dev string:x240>");

  while(self.var_178595624adb84da.size == 0) {
    waitframe();
  }

  self.var_269a59bcee49ce1 = 25;
  var_ad90f001e8588e05 = self.var_2d2565d73a005313[0];
  drone = namespace_64135de19550f047::function_e13d4385ead80da4(var_ad90f001e8588e05, undefined);

  if(isDefined(drone)) {
    function_f0675d4a690011d6(drone);
    drone setneargoalnotifydist(256);
    drone.var_1e0eb63ecb3f1e2 = 1;
    drone.ignorelist = drone;
    drone thread namespace_49e272e116f37d0::function_bc77383cc0c4d3b9(var_ad90f001e8588e05, undefined, 40, 1);
    drone thread function_bdc8d4d334ec48f5(self);
    self.var_cb8cd16df7c04d16 = array_add(self.var_cb8cd16df7c04d16, drone);
  }
}

function function_57d8fbd500aa11b9(var_b381b0883bcd4847) {
  player_list = var_b381b0883bcd4847.playerlist;

  foreach(player in player_list) {
    function_efcf810b1e6f4e71(player, 1);
  }
}

function function_91ce608117ff26d9(var_b381b0883bcd4847) {
  player_list = var_b381b0883bcd4847.playerlist;

  foreach(player in player_list) {
    function_efcf810b1e6f4e71(player, 0);
  }
}

function function_efcf810b1e6f4e71(player, var_a917328b0b1b2a19) {
  if(!istrue(self.b_merc_camp) || function_73bd348a2ec322cf(self) != "ActiveState") {
    ob_humans::function_dd0ceeddc603cb3e(player, self, "<dev string:x255>");

    return;
  }

  var_aec21a5b011527dc = self.var_47187a65a8fb783d;

  if(istrue(var_a917328b0b1b2a19)) {
    ob_humans::function_dd0ceeddc603cb3e(player, self, "<dev string:x282>");

    if(!isDefined(self.var_189ca75754491759)) {
      self.var_189ca75754491759 = [];
    }

    if(!array_contains(self.var_189ca75754491759, player)) {
      if(isDefined(var_aec21a5b011527dc) && isarray(var_aec21a5b011527dc) && var_aec21a5b011527dc.size == 1 && isDefined(player.guid) && istrue(var_aec21a5b011527dc[player.guid])) {
        if(!istrue(self.var_8b79601f5cca1fa9)) {
          squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers(player.team, 1);
          thread function_8e4e1fc9ff81363c(squad);

          foreach(squadmate in squad) {
            self.var_189ca75754491759[self.var_189ca75754491759.size] = squadmate;
          }
        } else {
          ob_humans::function_dd0ceeddc603cb3e(player, self, "<dev string:x2a1>");
        }
      } else {
        ob_humans::function_dd0ceeddc603cb3e(player, self, "<dev string:x2e9>");
      }
    } else {
      ob_humans::function_dd0ceeddc603cb3e(player, self, "<dev string:x32b>");
    }

    return;
  }

  if(!istrue(self.var_532109d48fb82eba) && istrue(self.playerengaged)) {
    squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers(player.team, 1);
    var_3d17c981a8ce7454 = 1;

    if(isDefined(var_aec21a5b011527dc) && isarray(var_aec21a5b011527dc)) {
      foreach(squadmate in squad) {
        if(isDefined(squadmate) && squadmate != player && isDefined(squadmate.guid) && istrue(self.var_47187a65a8fb783d[squadmate.guid])) {
          var_3d17c981a8ce7454 = 0;
          break;
        }
      }
    }

    if(var_3d17c981a8ce7454) {
      if(namespace_838b439602b3acc7::function_5acc35fc66331385(player, 17078) || getdvarint(@ "hash_7b8b09c504a0c9a0", 0)) {
        params = spawnStruct();
        params.player = player;
        callback::callback("merc_camp_fail", params);
        player thread function_4a508fcbbea05afd();
      }
    }
  }
}

function function_8e4e1fc9ff81363c(players) {
  if(!isDefined(self) || !isDefined(players) || !isarray(players) || players.size == 0) {
    ob_humans::function_f7e877aa7e97d952(self, "<dev string:x369>");

    return;
  }

  self endon("activity_ended");

  while(!isDefined(self.var_fbe46459634710c1)) {
    waitframe();
  }

  on_mission = 0;

  foreach(player in players) {
    if(namespace_838b439602b3acc7::function_5acc35fc66331385(player, 16152) || namespace_838b439602b3acc7::function_5acc35fc66331385(player, 17078) || getdvarint(@ "hash_7b8b09c504a0c9a0", 0)) {
      params = spawnStruct();
      params.player = player;
      callback::callback("approached_merc_camp", params);
      on_mission = 1;
    }
  }

  if(!on_mission) {
    ob_humans::function_d170903981c617de(player);
    ob_humans::function_dd0ceeddc603cb3e(player, self, "<dev string:x39e>" + self.var_fbe46459634710c1 + "<dev string:x3bf>");

    switch (self.var_fbe46459634710c1) {
      case #"hash_64ef5ee25b022921":
        function_1281c7fff9456e18("merc_camp_vo_approach_generic", players);
        break;
      case #"hash_f70b08ee00093db7":
        function_1281c7fff9456e18("merc_camp_vo_approach_sniper", players);
        break;
      case #"hash_25a0e6b2bfb7482c":
        function_1281c7fff9456e18("merc_camp_vo_approach_tactician", players);
        break;
      default:
        break;
    }

    return;
  }

  ob_humans::function_dd0ceeddc603cb3e(player, self, "<dev string:x3c4>");
}

function function_c2db087f74636224() {
  players = namespace_4c2b495b8d79cc2e::function_7ec62d1550b9897e(self, "Awareness_Zone");
  var_694cf27a7080216 = [];

  foreach(player in players) {
    if(!isDefined(player) || array_contains(var_694cf27a7080216, player)) {
      continue;
    }

    if(namespace_838b439602b3acc7::function_5acc35fc66331385(player, 17078) || getdvarint(@ "hash_7b8b09c504a0c9a0", 0)) {
      params = spawnStruct();
      params.player = player;
      callback::callback("merc_camp_success", params);
      squadmembers = player scripts\cp_mp\utility\squad_utility::getsquadmembers();

      foreach(squadmember in squadmembers) {
        var_694cf27a7080216[var_694cf27a7080216.size] = squadmember;
      }
    }
  }

  foreach(player in players) {
    if(!isDefined(player) || array_contains(var_694cf27a7080216, player)) {
      continue;
    }

    function_1281c7fff9456e18("merc_camp_vo_camp_cleared", [player]);
  }
}

function function_6216e8ce2640ec45(var_e501c18e04378d20) {
  if(!isDefined(var_e501c18e04378d20)) {
    return;
  }

  ob_humans::function_dd0ceeddc603cb3e(var_e501c18e04378d20, self, "<dev string:x3f9>");

  if(namespace_838b439602b3acc7::function_5acc35fc66331385(var_e501c18e04378d20, 17078) || getdvarint(@ "hash_7b8b09c504a0c9a0", 0)) {
    ob_humans::function_dd0ceeddc603cb3e(var_e501c18e04378d20, self, "<dev string:x41a>");

    params = spawnStruct();
    params.player = var_e501c18e04378d20;
    callback::callback("merc_camp_looted", params);
    return;
  }

  squad = var_e501c18e04378d20 scripts\cp_mp\utility\squad_utility::getsquadmembers(var_e501c18e04378d20.team, 1);
  var_14304961a076b8d = namespace_9718b9a169c3ead0::function_d52f11eff492795d(var_e501c18e04378d20, 1);
  wait 1;

  ob_humans::function_d170903981c617de(var_e501c18e04378d20);
  ob_humans::function_dd0ceeddc603cb3e(var_e501c18e04378d20, self, "<dev string:x453>");

  thread namespace_9718b9a169c3ead0::function_90db3e7d7b085484(var_14304961a076b8d, "activity_merc_camp_key_looted", squad);
}

function private function_4a508fcbbea05afd() {
  self endon("death_or_disconnect");
  wait 120;
  player = self;

  if(function_5acc35fc66331385(player, 17078)) {
    player ent_flag_clear("quest_s0a3t3_merccamp_fail");
    player ent_flag_clear("quest_s0a3t3_merccamp_success");
    player ent_flag_clear("quest_s0a3t3_merccamp_approach");
  }
}

function function_e530d11a8cbf4e45() {}

function function_299ddda5b65917c8(var_b381b0883bcd4847) {
  player_list = var_b381b0883bcd4847.playerlist;
  var_a83ac3549acc2da2 = var_b381b0883bcd4847.var_b494ea8c4b70490;

  if(isDefined(self.var_c441245b5c737557) && self.var_c441245b5c737557 getscriptablepartstate("body") == "hidden") {
    println("<dev string:x46d>" + self.var_c441245b5c737557.origin + "<dev string:x4a5>");

    if(function_73bd348a2ec322cf(self) == "ActiveState") {
      println("<dev string:x4f1>");
      self.var_c441245b5c737557 setscriptablepartstate("body", "closed_usable");
    }
  }

  if(istrue(self.var_bbbbbc7263f1c834) && self.var_961ebb1a79122846 == 0 && !istrue(self.keylooted) && !istrue(self.var_8b79601f5cca1fa9)) {
    thread function_a5152566f7918e06();
  }

  self.var_961ebb1a79122846 = self.var_6c29f2fdb0054bbe.size;

  foreach(player in player_list) {
    if(isPlayer(player)) {
      if(var_a83ac3549acc2da2 == "PlayerJoinedProximity") {
        self notify("player_proximity", player);
        continue;
      }

      if(var_a83ac3549acc2da2 == "PlayerJoinedDamage") {
        self notify("player_attacking", player);
      }
    }
  }
}

function private function_a5152566f7918e06() {
  level endon("game_ended");
  self endon("activity_ended");
  self endon("merc_camp_abandoned");
  self.var_3d1bc6f2c2fbb5d = 1;
  wait 6;
  callback::callback("analytics_proximity_activity_start");
  self.var_3d1bc6f2c2fbb5d = 0;
}

function function_12daaf2053fe7e28(var_b381b0883bcd4847) {
  if(istrue(self.var_bbbbbc7263f1c834) && !istrue(self.keylooted) && !istrue(self.var_8b79601f5cca1fa9)) {
    if(self.var_6c29f2fdb0054bbe.size == 0) {
      if(!istrue(self.var_3d1bc6f2c2fbb5d)) {
        callback::callback("analytics_proximity_activity_abandon");
      }

      self notify("merc_camp_abandoned");
      self.var_3d1bc6f2c2fbb5d = 0;
    }

    self.var_961ebb1a79122846 = self.var_6c29f2fdb0054bbe.size;
  }
}

function private function_e4cb6ba98b816518() {
  level endon("game_ended");
  namespace_4fda5d7358015a06::function_dca86aca511288f4(self, "EndedState");
  lootcache = self.var_c441245b5c737557;

  while(isDefined(lootcache)) {
    lootcache waittill("cache_item_looted", lootid, player);
    var_25978461c6e4f61b = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);

    if(isPlayer(player)) {
      player notify("disguise_state_change", "end_disguise");
    }

    if(isDefined(var_25978461c6e4f61b) && isstring(var_25978461c6e4f61b) && issubstr(var_25978461c6e4f61b, "loot_key_human")) {
      thread function_6216e8ce2640ec45(player);
      params = spawnStruct();
      params.cacheinstance = lootcache;
      params.merc_camp_name = self.varianttag;
      callback::callback("encampment_key_looted", params);

      if(istrue(self.var_bbbbbc7263f1c834) && !istrue(self.var_8b79601f5cca1fa9)) {
        callback::callback("analytics_proximity_activity_completed", params);
      }

      self.keylooted = 1;
      break;
    }
  }

  namespace_4fda5d7358015a06::function_20e36ec9e5802d01(self, "EndedState");
}