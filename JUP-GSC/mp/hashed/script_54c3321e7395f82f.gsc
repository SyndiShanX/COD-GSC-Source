/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_54c3321e7395f82f.gsc
*************************************************/

#using script_3ab210ea917601e7;
#using script_41387eecc35b88bf;
#using script_46c7c73b1a7e4773;
#using script_5f501fbedf0953f;
#using script_638d701d263ee1ed;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\loot\common_cache;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\utility;
#namespace namespace_57a329915670ffdc;

function function_729f6e368df801f4() {
  function_89384091f7a2dbd("REV_OB_ARMORED_CONVOY", 0, &namespace_16464fbff4c4f003::function_21672171040d6aae);
  function_89384091f7a2dbd("REV_OB_ARMORED_CONVOY", 1, &namespace_16464fbff4c4f003::function_c4da40d7e3056ed6);
  function_89384091f7a2dbd("REV_OB_ARMORED_CONVOY", 2, &namespace_16464fbff4c4f003::function_1f2529d9fe2f4432);
  function_89384091f7a2dbd("REV_OB_ARMORED_CONVOY", 3, &namespace_16464fbff4c4f003::function_ee03881506b0073d);
  function_89384091f7a2dbd("REV_OB_ARMORED_CONVOY", 4, &namespace_16464fbff4c4f003::function_5b846516c4a7f320);
  function_8b5b2a3392fc7e2a("PlayerJoin", &namespace_16464fbff4c4f003::function_7aa120c6895b1b0, "REV_OB_ARMORED_CONVOY");
  function_8b5b2a3392fc7e2a("PlayerLeave", &namespace_16464fbff4c4f003::function_53ecaed01e5352a0, "REV_OB_ARMORED_CONVOY");
  registersharedfunc("armored_convoy_activity", "CustomParseParams", &parseparams);
  registersharedfunc("armored_convoy_activity", "GetMaxVehicles", &function_f59e21c58d674dc1);
  registersharedfunc("armored_convoy_activity", "GetRiderEncounterFromIndex", &function_4c8727d4f35931a1);
  registersharedfunc("armored_convoy_activity", "GetVehicleRefFromIndex", &function_c45e80be17065ee9);
  registersharedfunc("armored_convoy_activity", "SpawnLootCache", &function_7c279c038503812f);
  registersharedfunc("armored_convoy_activity", "PlayApproachConvoyVO", &playapproachconvoyvo);
  registersharedfunc("armored_convoy_activity", "PlayEngageVO", &playengagevo);
  registersharedfunc("armored_convoy_activity", "PlayVehDestroyedVO", &playvehdestroyedvo);
  registersharedfunc("armored_convoy_activity", "OnPlayerLeftActivity", &onplayerleftactivity);
}

function parseparams(var_28af8e747331e08d) {
  self.routedifficulty = namespace_4df2ab39b0e96ec7::function_4d8bb2d866771a10(self.nd_spline_start.origin);

  if(self.routedifficulty == "difficulty_undefined") {
    self.routedifficulty = getDvar(@ "hash_600f124219762287", "difficulty_easy");
  }

  namespace_16464fbff4c4f003::function_219e012faa65219d(var_28af8e747331e08d);
}

function function_f59e21c58d674dc1() {
  return namespace_16464fbff4c4f003::function_c7989b2ed75d1228();
}

function function_4c8727d4f35931a1(vehicleposition) {
  return namespace_16464fbff4c4f003::function_a23b8410030b26d0(vehicleposition);
}

function function_c45e80be17065ee9(vehicleposition) {
  switch (self.routedifficulty) {
    case #"hash_5343b465e56ec9a4":
    case #"hash_651f76c0ad6741ec":
    case #"hash_7bb2cd766703d463":
    case #"hash_af83e47edfa8900a":
    default:
      vehicle_ref = "veh9_techo_rebel_armor";
      break;
  }

  return vehicle_ref;
}

function function_7c279c038503812f(vehicle) {
  var_b67c5086cfc7b5ef = spawnscriptable(self.var_cb2499e4e9d175a2, vehicle.origin);

  switch (vehicle.classname_mp) {
    case #"hash_d088afbf21032120":
      v_loot = (-60, 0, -10);
      break;
    case #"hash_535a330be104394c":
      v_loot = (-50, 0, -10);
      break;
    default:
      v_loot = (-50, 0, -10);
      break;
  }

  var_b67c5086cfc7b5ef scripts\common\utility::scriptable_setparententity(vehicle, v_loot, (0, 90, 0));
  var_b67c5086cfc7b5ef setscriptablepartstate("body", "closed_usable_no_collision");

  if(istrue(self.regiondifficulty)) {
    if(self.routedifficulty == "difficulty_easy") {
      n_items = 3;
      loot_list = self.defaultloot;
    } else {
      n_items = 4;
      loot_list = self.betterloot;
    }
  } else {
    n_items = 3;
    loot_list = self.defaultloot;
  }

  common_cache::fillcontentsfromlist(var_b67c5086cfc7b5ef, loot_list, n_items);
  thread function_96f15b75346c0661(vehicle);
  vehicle.loot_crate = var_b67c5086cfc7b5ef;
  self.var_9009411bf4edf20b = array_add(self.var_9009411bf4edf20b, var_b67c5086cfc7b5ef);
}

function playapproachconvoyvo(activity_instance, player_list) {
  foreach(player in player_list) {
    squadmembers = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
    var_8c4ed29f8594fb86 = zombie_challenges::function_f578373042c34e16(16095, "quest_s0a1t2_cnvy_approach", squadmembers);

    if(!var_8c4ed29f8594fb86) {
      activity_instance thread namespace_277c27ef297ef569::function_1281c7fff9456e18("activity_armored_convoy_approach_broadcast", [player]);
    }

    player callback::callback("on_approach_convoy");
  }
}

function playengagevo(activity_instance, var_2a7b538f984af574) {
  foreach(player in activity_instance.playerparticipants) {
    squadmembers = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
    var_8c4ed29f8594fb86 = zombie_challenges::function_f578373042c34e16(16095, "quest_s0a1t2_cnvy_engage", squadmembers);

    if(!var_8c4ed29f8594fb86 && istrue(var_2a7b538f984af574)) {
      activity_instance thread namespace_277c27ef297ef569::function_1281c7fff9456e18("activity_armored_convoy_engage_enemy_broadcast", [player]);
    } else if(!var_8c4ed29f8594fb86) {
      activity_instance thread namespace_277c27ef297ef569::function_1281c7fff9456e18("activity_armored_convoy_engage_player_broadcast", [player]);
    }

    player callback::callback("on_engage_convoy");
  }
}

function playvehdestroyedvo(activity_instance, var_7a4fd332f67e105e) {
  foreach(player in activity_instance.playerparticipants) {
    squadmembers = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
    var_8c4ed29f8594fb86 = zombie_challenges::function_f578373042c34e16(16095, "quest_s0a1t2_cnvy_vehicledestroyed", squadmembers);

    if(!var_8c4ed29f8594fb86 && istrue(var_7a4fd332f67e105e)) {
      activity_instance thread namespace_277c27ef297ef569::function_1281c7fff9456e18("activity_armored_convoy_vehicles_remain_broadcast", [player]);
    } else if(!var_8c4ed29f8594fb86) {
      activity_instance thread namespace_277c27ef297ef569::function_1281c7fff9456e18("activity_armored_convoy_vehicles_destroyed_broadcast", [player]);
    }

    player callback::callback("on_destroy_convoy");
  }
}

function onplayerleftactivity(activity_instance, var_b381b0883bcd4847) {
  if(isDefined(activity_instance) && activity_instance.state != "EndedState") {
    foreach(player in var_b381b0883bcd4847.playerlist) {
      player thread function_4a508fcbbea05afd();
    }
  }
}

function function_4a508fcbbea05afd() {
  self endon("death_or_disconnect");
  wait 120;
  player = self;

  if(function_5acc35fc66331385(player, 16095)) {
    player ent_flag_clear("quest_s0a1t2_cnvy_approach");
    player ent_flag_clear("quest_s0a1t2_cnvy_engage");
    player ent_flag_clear("quest_s0a1t2_cnvy_vehicledestroyed");
    player ent_flag_clear("quest_s0a1t2_cnvy_closedestconvoy");
  }
}

function private function_96f15b75346c0661(vehicle) {
  vehicle waittill("death");
  waitframe();

  if(isDefined(vehicle.loot_crate)) {
    n_movetime = 1;
    vehicle.loot_crate scripts\common\utility::scriptable_clearparententity();
    v_angles = vehicle.angles;
    v_pos = vehicle.origin;
    loot_yaw = ter_op(cointoss(), -90, 90);
    loot_vector = (96, 0, 0);
    loot_angles = v_angles + (0, loot_yaw, 0);
    loot_point = v_pos + rotatevector(loot_vector, loot_angles);
    var_839f515b361331f9 = getgroundposition(loot_point, 32, 720, 0);
    vehicle.loot_crate.origin = var_839f515b361331f9;
  }
}