/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_nam_armada.gsc
***********************************************/

#using script_13209888df6eddf6;
#using script_1bc87bb1cbccfd6e;
#using script_25b0725f0d26dbf5;
#using script_25e5dde7b6917cfc;
#using script_32ff16d71b77016b;
#using script_3711e526ec2a3863;
#using script_3de47beee8436774;
#using script_47d08d7129406c5a;
#using script_4937c6974f43bb71;
#using script_5093e69067abcf4d;
#using script_701ab3cbf9eb8c3a;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\dev_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_death_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp\cp_nam_armada_fx;
#using scripts\cp_common\achievements;
#using scripts\cp_common\ammo_resupply_crate;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\friendlyfire;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hint_tutorial;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\player_decision;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#using scripts\weapons\weapon_utils;
#namespace cp_nam_armada;

function private event_handler[createstruct] function_e0a8e4ba(struct) {
  foreach(var_27b3836d, k in ["ripcord_heli_crash_zones", "ripcord_ambient"]) {
    if(!isDefined(level.var_41204f29)) {
      level.var_41204f29 = [];
    } else if(!isarray(level.var_41204f29)) {
      level.var_41204f29 = array(level.var_41204f29);
    }

    if(!isinarray(level.var_41204f29, tolower(k))) {
      level.var_41204f29[level.var_41204f29.size] = tolower(k);
    }
  }

  level.var_5e990e96 = arraycopy(level.var_41204f29);

  if(isDefined(level.struct)) {
    temp = arraycopy(level.struct);
    level.struct = [];

    foreach(struct in temp) {
      struct::init(struct);
    }
  }

  function_6c07201b("CreateStruct", &function_e0a8e4ba);
}

#namespace namespace_722cc932;

function event_handler[level_init] main(eventstruct) {
  setclearanceceiling(16);
  level.destructible_callbacks[# "destructible_explosive_concussive_small"] = &armada_mortar::function_1df2273d;
  clientfield::register("toplayer", "ease_to_dialog_dof", 1, 1, "int");
  clientfield::register("toplayer", "lerp_fov", 1, 3, "int");
  clientfield::register("vehicle", "adler_chopper_mortar_village", 1, 1, "int");
  clientfield::register("world", "toggle_dynsignage_mortartown", 1, 1, "int");
  clientfield::register("world", "toggle_gameplay_character_visibility", 1, 2, "int");
  clientfield::register("vehicle", "" + # "hash_4ddf67f7aa0f6884", 1, 1, "int");
  clientfield::register("vehicle", "" + # "hash_354296015ca81fd", 1, 1, "int");
  clientfield::register("toplayer", "" + # "pstfx_teleport", 1, getminbitcountfornum(2), "int");
  clientfield::register("vehicle", "" + # "hash_2299cc8957801441", 1, 1, "int");
  clientfield::register("world", "" + # "hash_5a188b1de711e5ca", 1, 1, "int");
  clientfield::register("world", "" + # "hash_7705eee7a483781a", 1, 1, "int");
  clientfield::register("world", "" + # "hash_4ee03d623b77b0c2", 1, 1, "int");
  clientfield::register("world", "" + # "hash_16a1381cc22da440", 1, 1, "int");
  clientfield::register("world", "" + # "hash_147afd2c82d374fe", 1, 1, "int");
  clientfield::register("toplayer", "" + # "force_stream_weapons", 1, 2, "int");
  clientfield::register("toplayer", "pstfx_script_vignette", 1, 2, "int");
  clientfield::register("toplayer", "" + # "hash_1d5f8429329030", 1, 2, "int");
  clientfield::register("toplayer", "" + # "hash_4e480e273ade4c04", 1, 2, "int");
  namespace_9a981837::function_c44464c8();
  function_37dfd679();
  function_13237d0a();
  function_ee098efb();
  function_60f16ecb();
  vehicle::add_spawn_function_by_type(#"hash_308369147254321b", &function_4ed18070);
  vehicle::add_spawn_function_by_type(#"hash_b71765a3bf22ce7", &function_4ed18070);
  vehicle::add_spawn_function_by_type(#"hash_d51aef98cfc8f9b", &function_4ed18070);
  vehicle::add_spawn_function_by_type(#"hash_d51aff98cfc914e", &function_4ed18070);
  vehicle::add_spawn_function_by_type(#"hash_2ed1cf0a9a3c0624", &function_4ed18070);
  vehicle::add_spawn_function_by_type(#"vehicle_t9_mil_us_helicopter_large_cp_armada_player", &function_4ed18070);
  vehicle::add_spawn_function_by_type(#"hash_56f2823854475ea7", &function_4ed18070);
  vehicle::add_spawn_function_by_type(#"hash_75cd743f7ce45c03", &function_4ed18070);
  level clientfield::set("toggle_gameplay_character_visibility", 1);
  load::main();
  level thread namespace_a64c0f5b::main();
  level flag::clear("stealth_enabled");
  level flag::set("no_corpse_pickup ");
  level.var_9317da1b = 1;
  level.var_95b5c0fe = 1;
  setDvar(#"compassmaxrange", "2100");
  setDvar(#"vehicle_switch_seat_delay", 36000000);
  setDvar(#"hkai_navmeshusehierarchialpathfind", 1);
  setDvar(#"hkai_pathfinditerationlimit", 800);
  setDvar(#"hash_10e00e3d79a6e4b1", 1);
  setDvar(#"hash_1352c0ba0dd8747", 30);
  level thread namespace_9a981837::init_fx();
  level thread namespace_72b0499b::init_audio();
  function_22b7fffd();
  init_callbacks();

  level thread _setup_devgui();
}

function function_37dfd679() {
  skipto::function_eb91535d("armada_intro", &namespace_e871b49a::intro_flow, &function_fb3e29d5, "Intro", &function_6e6c4f85);
  skipto::add("armada_flyin", &namespace_e871b49a::function_50d6beb5, &function_cf7ffedf, "Fly in", &function_6e6c4f85);
  skipto::function_eb91535d("armada_mortar_orbit", &armada_mortar::function_6ad1ac64, &function_9d4b09a, "Mortar - Orbit", &armada_mortar::function_e160f453);
  skipto::function_eb91535d("armada_mortar_start", &armada_mortar::function_94a21d8b, &function_5109008, "Mortar Village", &function_6e6c4f85);
  skipto::function_eb91535d("armada_mortar_exfil", &armada_mortar::function_997dda5e, &function_dfc4bc30, "Mortar Village Exfil", &armada_mortar::function_a11d0dcc);
  level.var_53bb8ef2 = spawnStruct();
  level.var_1f372b50 = spawnStruct();
  level.var_9051f4a3 = spawnStruct();
  level.var_539110f3 = spawnStruct();
  skipto::function_eb91535d("player_controlled_huey_01", &function_5854aa8c, &function_64cad509, "Player Controlled Huey 01", &function_d6bbe091);
  skipto::add("player_controlled_huey_02", &function_f137e067, &function_d3e80e12, "Player Controlled Huey 02", &function_b839a88b);
  skipto::function_eb91535d("defend_firebase_ripcord", &function_dc1d0dfb, &function_46c0f651, "Defend Firebase Ripcord", &function_d623578b);
  skipto::function_eb91535d("secure_the_nuke", &function_2870229e, &function_47cfc791, "Secure The Nuke", &function_2ea27496);
  skipto::add("armada_crash_start", &armada_crash::function_945def6e, &function_860b1ca0, "Crash Start", &armada_crash::function_9eecfef5);
  skipto::function_eb91535d("armada_crash_part_1_gunner", &armada_crash::function_58ef8b05, &function_c1a2b1dd, "Crash - Gunner", &armada_crash::function_398bee81);
  skipto::add("armada_crash_part_4_laststand", &armada_crash::function_cd3c6f53, &function_df03d4dc, "Crash - Last Stand", &function_6e6c4f85);
  skipto::function_46d8992a("armada_intro");

  skipto::add_dev("<dev string:x38>", &function_c03bb520);
  skipto::add_dev("<dev string:x49>", &function_1061456b);
}

function function_ade9b040(var_d3440450) {
  namespace_b7cfe907::function_6a03d24d(var_d3440450);
}

function function_6e6c4f85(name, starting, direct, player) {}

function function_4ed18070() {
  self setdedicatedshadow(1);
  self setnosunshadow();
}

function function_fb3e29d5(var_d3440450) {
  level.var_cb4dca51 = 2;
  level.var_c0c469ea = 0.5;
  var_49cf9916 = struct::get("armada_start_streamer_hint");
  level clientfield::set("" + # "hash_7705eee7a483781a", 1);
  level.player util::create_streamer_hint(var_49cf9916.origin, var_49cf9916.angles, 1, 30);
  level namespace_82bfe441::fade(1, "FadeImmediate");
  level.player util::function_749362d7(1);
  level namespace_b7cfe907::function_882e6973(0, struct::get("spawn_vip_intro", "targetname"), 0);
  level flag::wait_till("flag_armada_vip_spawned");
  a_ents = [];
  a_ents[# "vip"] = level.vip;
  level scene::init(#"armada_intro", a_ents);
  level thread namespace_e871b49a::function_5a637552(#"hash_760fd21e9907ff11", "flag_intro_chopper_guys_go", "flag_play_gear_up_pt02");
  level thread namespace_e871b49a::function_3a5d1f07(#"hash_799d967f164f5092", "flag_intro_player_boarded_chopper");
  level thread namespace_e871b49a::function_3a5d1f07(#"hash_132134e8d6335e7f", "flag_intro_player_boarded_chopper");
  level.player util::streamer_wait(undefined, 2, 30);
}

function function_cf7ffedf(var_d3440450) {
  util::function_3e65fe0b(1);
  util::delay(2, undefined, &snd::client_msg, #"hash_55704324b6ae9012");
  level namespace_b7cfe907::function_6a03d24d(var_d3440450);
  level flag::wait_till_all(["flag_armada_player_chopper_spawned", "flag_armada_vip_spawned", "flag_armada_buddy_spawned", "flag_armada_copilot_spawned", "flag_armada_pilot_spawned"]);
  level namespace_e871b49a::function_55d23d1e();
  level clientfield::set("toggle_gameplay_character_visibility", 0);
  level thread namespace_e871b49a::function_e04385cb(0, "flag_intro_player_boarded_chopper");
  level thread namespace_e871b49a::function_d7d6110f();
  level flag::set("flag_intro_mixed_flyover_guys_go");
  level flag::set("flag_intro_hueys_take_off");
  level flag::set("flag_intro_cobras_take_off");
  level flag::set("flag_intro_trucks_go");
  level flag::set("flag_intro_ambient_vehicles_start");
  level flag::set("flag_vo_intro_start");
  level flag::set("flag_intro_boarders_go");
  level flag::set("flag_intro_player_vm_done");
  level flag::set("flag_intro_chopper_guys_go");
  level flag::set("flag_intro_trucks_start");
  level flag::set("flag_chinook_takeoff");
  level thread namespace_e871b49a::function_edd0551c();
  a_ents = [];
  a_ents[# "buddy"] = level.buddy;
  a_ents[# "pilot"] = level.pilot;
  a_ents[# "copilot"] = level.copilot;
  a_ents[# "hash_4972abe0166bbc73"] = level.var_7466d419;
  level scene::init(#"hash_45e2dd5c24266fcf", a_ents);
  a_ents = [];
  a_ents[# "buddy"] = level.buddy;
  a_ents[# "pilot"] = level.pilot;
  a_ents[# "copilot"] = level.copilot;
  a_ents[# "hash_4972abe0166bbc73"] = level.var_7466d419;
  level thread scene::play(#"hash_69b8e06afe12b8f9", "idle", a_ents);
  level thread namespace_e871b49a::function_5a637552(#"hash_760fd21e9907ff11", "flag_intro_chopper_guys_go", "flag_play_gear_up_pt02");
  level thread namespace_e871b49a::function_6b21ec6d();
  level thread namespace_e871b49a::function_3705ef2f("flag_intro_player_boarded_chopper");
  level.player thread namespace_e871b49a::function_2549ca47();
  level.player thread namespace_e871b49a::function_4c403681();
  level.player thread namespace_b7cfe907::function_6666cad6();
  level thread namespace_e871b49a::function_c9528d2b();
  level thread namespace_e871b49a::function_3f7b5c03();
}

function function_9c328bac(var_d3440450) {
  namespace_b7cfe907::function_6a03d24d(var_d3440450);
  level flag::set("flag_player_chopper_screenshake_active");
  var_a129a5ee = getent("trigger_oob_firebase_to_branch", "targetname");
  var_a129a5ee triggerenable(0);
}

function function_62105860(var_d3440450) {
  util::delay(2, undefined, &snd::client_msg, #"hash_55704324b6ae9012");
  namespace_b7cfe907::function_6a03d24d(var_d3440450);
  thread namespace_e871b49a::function_d97a8605();
  level flag::set("flag_player_chopper_screenshake_active");
  level flag::set("flag_firebase_base_intro_exploders");
  level flag::set("flag_firebase_base_enemy_trucks_start");
  level flag::set("flag_firebase_enemy_cliff_start");
  var_a129a5ee = getent("trigger_oob_firebase_to_branch", "targetname");
  var_a129a5ee triggerenable(0);
}

function function_55dc2a68(var_d3440450) {
  namespace_b7cfe907::function_6a03d24d(var_d3440450);
  level flag::set("flag_player_chopper_screenshake_active");
  var_a129a5ee = getent("trigger_oob_firebase_to_branch", "targetname");
  var_a129a5ee triggerenable(0);
}

function function_6b6544ba(var_d3440450) {
  namespace_b7cfe907::function_6a03d24d(var_d3440450);
  level flag::set("flag_vo_firebase_arrival_stabilize_complete");
}

function function_ce0ab1c0(var_d3440450) {
  namespace_b7cfe907::function_6a03d24d(var_d3440450);
}

function function_9d4b09a(var_d3440450) {
  util::delay(2, undefined, &snd::client_msg, #"hash_55704324b6ae9012");
  level thread armada_mortar::function_110866d(1);
}

function function_5109008(var_d3440450) {
  util::delay(2, undefined, &snd::client_msg, #"hash_55704324b6ae9012");
  level armada_mortar::function_6b5096fe();
  level namespace_b7cfe907::function_6a03d24d(var_d3440450);
  level.var_7466d419 setvehicletype(#"hash_56f2823854475ea7");
  level armada_mortar::function_97a20289();
  level.player scene::function_27f5972e(#"hash_32b809763b13c282");
  level flag::set("flag_vo_mortar_arrival_orbit_complete");
  level thread function_59656f55(1, 0, 0);
  level.player util::streamer_wait(undefined, 2, 45, undefined, #"hash_32b809763b13c282");
}

function function_dfc4bc30(var_d3440450) {
  var_49cf9916 = struct::get("mortar_exfil_streamer_hint");
  level armada_mortar::function_a1de7ea2(1);
  level.player scene::function_27f5972e(#"hash_7d15d57d22684df");
  level.player util::create_streamer_hint(var_49cf9916.origin, var_49cf9916.angles, 1, 30);
  util::delay(2, undefined, &snd::client_msg, #"hash_55704324b6ae9012");
  namespace_72b0499b::music("8.0_landing");

  if(isDefined(getent("mortar_brush_exfil_door_closed", "targetname"))) {
    getent("mortar_brush_exfil_door_closed", "targetname") delete();
  }

  level.var_da566d53 = "upper_village";
  level flag::set("flag_bamboo_end_end");
  level flag::set("armada_bamboo_end_completed");
  level thread function_59656f55(1, 0, 0);
  level.player util::streamer_wait(undefined, 2, 30);
}

function function_860b1ca0(var_d3440450) {
  level thread function_226ff16b(1);
  util::delay(2, undefined, &snd::client_msg, #"hash_55704324b6ae9012");
  namespace_b7cfe907::function_6a03d24d(var_d3440450);
}

function function_c1a2b1dd(var_d3440450) {
  util::delay(2, undefined, &snd::client_msg, #"hash_55704324b6ae9012");
  level armada_crash::function_7b315e60();
  namespace_b7cfe907::function_6a03d24d(var_d3440450);

  while(!isDefined(level.player)) {
    waitframe(1);
  }

  namespace_82bfe441::fade(1, "FadeImmediate");
}

function function_df03d4dc(var_d3440450) {
  namespace_82bfe441::fade(1, "FadeFast");
  util::delay(2, undefined, &snd::client_msg, #"hash_55704324b6ae9012");
  namespace_b7cfe907::function_6a03d24d(var_d3440450);
}

function function_22b7fffd() {
  animation::add_notetrack_func("armada_util::chopper_force_start_engine", &namespace_b7cfe907::function_53c06d6e);
  animation::add_notetrack_func("SetRotorSpeed", &namespace_b7cfe907::function_388cae02);
  animation::add_notetrack_func("spawn_crew", &namespace_b7cfe907::function_9ac0bc90);
  animation::add_notetrack_func("spawn_boat_crew", &namespace_b7cfe907::function_80a8e837);
  animation::add_notetrack_func("despawn_crew_and_delete_self", &namespace_b7cfe907::function_a7574a48);
  animation::add_notetrack_func("despawn_crew", &namespace_b7cfe907::function_5677b6eb);
  animation::add_notetrack_func("screenshake", &namespace_b7cfe907::function_ed1b0fb);
  animation::add_notetrack_func("armada_fx::my_hide_viewmodel", &namespace_9a981837::function_fcea30b4);
  animation::add_notetrack_func("armada_fx::auto_dof_call", &namespace_9a981837::function_a9a0debb);
  animation::add_notetrack_func("swap_hat_model", &namespace_b7cfe907::swap_hat_model);
  animation::add_notetrack_func("armada_mortar::player_pickup_intel_finish", &armada_mortar::function_a6fea06f);
  scene::add_scene_func(#"armada_intro", &namespace_e871b49a::function_70c35833, "init");
  scene::add_scene_func(#"hash_30c1ba04c9ba0bf3", &armada_crash::smoke_signal, "outro");
  scene::add_scene_func(#"hash_30c1ba04c9ba0bf3", &armada_crash::m16, "outro");
  scene::add_scene_func(#"hash_30c1ba04c9ba0bf3", &armada_crash::function_7322d11e, "ending");
}

function init_callbacks() {
  callback::on_spawned(&function_56b5efa8);
  callback::on_player_killed(&function_91c1bb33);
}

function function_56b5efa8() {
  level.player = getplayers()[0];
  thread namespace_9a981837::function_7e002ff8();
  level thread namespace_9a981837::intro_dof();
  level.killstreaksenabled = 0;
  namespace_b7cfe907::function_9ebb66cb();
}

function function_91c1bb33(params) {
  if(isDefined(level.var_d42e271a)) {
    level.var_d42e271a delete();
  }

  if(isDefined(level.pilot)) {
    level.pilot util::stop_magic_bullet_shield();
  }

  if(isDefined(level.copilot)) {
    level.copilot util::stop_magic_bullet_shield();
  }

  if(isDefined(level.vip)) {
    level.vip util::stop_magic_bullet_shield();
  }

  if(isDefined(level.gunner)) {
    level.gunner util::stop_magic_bullet_shield();
  }

  if(isDefined(level.buddy)) {
    level.buddy util::stop_magic_bullet_shield();
  }
}

function function_a291d0f(var_d3440450, var_50cc0d4f, var_fcf2c706 = 0) {
  if(level flag::get(#"hash_22a3c9d4c3c49987")) {
    return;
  }

  level flag::set(#"hash_22a3c9d4c3c49987");
  level flag::wait_till("all_players_spawned");

  if(var_50cc0d4f) {
    switch (var_d3440450) {
      case # "player_controlled_huey_01":
        str_script_noteworthy = # "hash_44b941c1984f5dc6";
        break;
      case # "player_controlled_huey_02":
        str_script_noteworthy = # "hash_651a32ffba7e27b4";
        break;
      case # "defend_firebase_ripcord":
        str_script_noteworthy = # "hash_1668bd06b3baa8e2";
        break;
      case # "secure_the_nuke":
        str_script_noteworthy = # "hash_8f14f3cf9fd498a";
        break;
    }

    namespace_b7cfe907::function_27e76b4c(str_script_noteworthy, 0);
    namespace_b7cfe907::function_d5d40694();
    namespace_b7cfe907::function_ed68628c(1);
    namespace_b7cfe907::function_882e6973(1);
  } else {
    namespace_b7cfe907::function_d777fe61(0);
  }

  callback::on_disconnect(&function_15ce9e60);
  level.vip val::set(#"hash_16f344886ca07918", "takedamage", 0);
  level.buddy val::set(#"hash_16f344886ca07918", "takedamage", 0);
  level.gunner val::set(#"hash_16f344886ca07918", "takedamage", 0);
  level.pilot val::set(#"hash_16f344886ca07918", "takedamage", 0);
  level.copilot val::set(#"hash_16f344886ca07918", "takedamage", 0);
  friendlyfire::turnoff();
  var_53bb8ef2 = level.var_53bb8ef2;
  var_53bb8ef2.var_a57e0aff = spawnStruct();
  var_53bb8ef2.var_a57e0aff.var_d39130d2 = [];
  var_53bb8ef2.var_78bd98cb = level.var_7466d419;
  var_53bb8ef2.var_cfa81957 = function_d8afd6c7();
  var_53bb8ef2.var_9df3157 = 0;
  level thread function_9be6ef5f();
  level thread function_3e0633ef();
  var_53bb8ef2.var_78bd98cb turret::disable(1);
  var_53bb8ef2.var_78bd98cb turret::disable(2);
  armada_mortar::function_e9339cdf();
  namespace_b7cfe907::function_75972637();
  level thread function_d9cfd0c9();
  var_53bb8ef2.var_57a6f59c = util::spawn_model(#"tag_origin");
  var_53bb8ef2.var_78bd98cb.overridevehicledamage = &function_802c8975;
  level.overrideplayerdamage = &function_8b077075;
  level.var_f5ebfda9 = 1;
  level.var_bde3d03 = &function_c8abf85b;
  var_53bb8ef2.var_df6d4579 = getweapon(#"hash_1b226dddac770884");
  level.var_9c483e1 = &function_cb853b3d;
  vehicle::add_spawn_function_by_type(#"hash_1bdb534f1e8e23f5", &function_7fb76185);
  vehicle::add_spawn_function_by_type(#"hash_3cdadb03ee525329", &function_7fb76185);
  vehicle::add_spawn_function_by_type(#"hash_64eb6f83a98f9b6", &function_7fb76185);
  vehicle::add_spawn_function_by_type(#"hash_3677daa34d36098a", &function_7fb76185);
  vehicle::add_spawn_function_by_type(#"hash_331dac1d7450a6ed", &function_7fb76185);
  vehicle::add_spawn_function_by_type(#"hash_2bf574cefe3e6d9e", &function_7fb76185);
  vehicle::add_spawn_function_by_type(#"hash_57f7c02f5db425b9", &function_7fb76185);
  vehicle::add_spawn_function_by_type(#"hash_4420cded39673048", &function_7fb76185);
  vehicle::add_spawn_function_by_type(#"hash_2bf574cefe3e6d9e", &function_f994e739);
  vehicle::add_spawn_function_by_type(#"hash_57f7c02f5db425b9", &function_f994e739);
  vehicle::add_spawn_function_by_type(#"hash_4420cded39673048", &function_f994e739);
  vehicle::add_spawn_function_by_type(#"hash_3cdadb03ee525329", &function_cc00984b);
  vehicle::add_spawn_function_by_type(#"hash_64eb6f83a98f9b6", &function_cc00984b);
  vehicle::add_spawn_function_by_type(#"hash_3677daa34d36098a", &function_cc00984b);
  vehicle::add_spawn_function_by_type(#"hash_331dac1d7450a6ed", &function_cc00984b);
  vehicle::add_spawn_function_by_type(#"hash_2bf574cefe3e6d9e", &function_cc00984b);
  vehicle::add_spawn_function_by_type(#"hash_57f7c02f5db425b9", &function_cc00984b);
  level.player setsunshadowsplitdistance(10000);
  level battlechatter::function_2ab9360b(0);
  var_78110506 = 1;

  if(var_50cc0d4f && (var_d3440450 === # "secure_the_nuke" || var_d3440450 === # "defend_firebase_ripcord")) {
    var_78110506 = 0;
  }

  if(getdvarint(#"hash_3b90a67ea0b6081b", 0) >= 2) {
    var_78110506 = 0;
  }

  if(var_78110506) {
    level thread function_8832667d(var_50cc0d4f, var_fcf2c706);
  } else if(!level flag::get(#"hash_1836f795cbffc399")) {
    helicopter::function_2b057725();
  }

  level.player thread namespace_b7cfe907::function_8a8a52ab();
  function_3623e8fb();
}

function function_15ce9e60() {
  setDvar(#"hash_367578d4c1c78030", 0);
}

function function_8832667d(var_50cc0d4f, var_fcf2c706) {
  fadetime = 5;

  if(var_50cc0d4f || var_fcf2c706) {
    flag::clear("display_heli_controls");
    hint_data = [hint_tutorial::function_f0104b5([# "hash_676bc11f6040cd", #"hash_731892233ce087da"]), hint_tutorial::function_f0104b5([# "hash_5bd5b5bff21f9f83", #"hash_86dc1ffb6db49c0"])];
    hint_tutorial::function_4c2d4fc4(#"", #"hash_6c56d5b0ec0e04b6", undefined, undefined, undefined, fadetime, undefined, 1, hint_data);
    wait fadetime + 0.5;

    if(!level flag::get(#"hash_1836f795cbffc399")) {
      helicopter::function_2b057725();
    }

    flag::wait_till("flag_weapon_hints");
    hint_data = [hint_tutorial::function_f0104b5([# "hash_54edc62282b5b42c", #"hash_3e04863b2160682d"]), hint_tutorial::function_f0104b5([# "hash_27b404419a5df906"])];
    hint_tutorial::function_4c2d4fc4(#"", #"hash_3e5bd95c59322d64", undefined, undefined, undefined, fadetime, "flag_rocket_hints", 1, hint_data);
  }
}

function function_ea7f1a78(var_65348f88) {
  while(!level flag::get(var_65348f88)) {
    weaponoverheating = level.var_7466d419 isvehicleturretoverheating(3);

    if(weaponoverheating) {
      level flag::set(var_65348f88);
      return;
    }

    wait 0.05;
  }
}

function function_802c8975(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(getdvarint(#"hash_3b90a67ea0b6081b", 0) >= 2) {
    return 0;
  }

  var_53bb8ef2 = level.var_53bb8ef2;

  if(isgodmode(level.player) || is_true(var_53bb8ef2.var_4ec7cb08) || !isDefined(vdamageorigin) || !isDefined(partname) || vdamageorigin util::is_on_side(self.team)) {
    return 0;
  }

  if(partname == getweapon(#"gunship_missile_armada")) {
    var_53bb8ef2.var_4ec7cb08 = 1;
    self thread function_ff36634b();
    return 0;
  }

  var_d5788a84 = 0;
  var_83af05db = 0;

  if(modelindex === "MOD_PROJECTILE") {
    var_d5788a84 = 1;
  } else if(is_true(var_53bb8ef2.var_b0bffa0a)) {
    return 0;
  } else {
    var_d5788a84 = 1;
    var_53bb8ef2.var_b0bffa0a = 1;
    level thread function_902ac76(var_53bb8ef2);

    if(!is_true(var_53bb8ef2.var_6f17e122)) {
      self thread function_76a52ae7();
    }

    self thread function_5f3b3863(var_53bb8ef2);
  }

  var_53bb8ef2.var_cfa81957 -= psoffsettime;

  if(var_53bb8ef2.var_cfa81957 <= 0) {
    var_53bb8ef2.var_4ec7cb08 = 1;
    self thread function_ff36634b();
  } else {
    self thread function_8feeb0be();
  }

  if(var_d5788a84 > 0) {
    level.player dodamage(var_d5788a84, vdamageorigin.origin, var_53bb8ef2.var_57a6f59c, shitloc, vsurfacenormal, modelindex, damagefromunderneath, partname);
  }

  return var_83af05db;
}

function function_8b077075(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex) {
  if(isDefined(psoffsettime) && psoffsettime != level.var_53bb8ef2.var_57a6f59c) {
    return 0;
  }

  self.health++;
  return boneindex;
}

function function_902ac76(var_53bb8ef2) {
  self notify("12ae9f3292bae703");
  self endon("12ae9f3292bae703");

  if(is_true(var_53bb8ef2.var_6f17e122)) {
    n_cooldown = 0.25;
  } else {
    n_cooldown = randomfloatrange(1.5, 3);
  }

  wait n_cooldown;
  var_53bb8ef2.var_b0bffa0a = 0;
}

function function_76a52ae7() {
  self endon(#"death");
  level.player endon(#"death");
  n_hits = randomintrangeinclusive(1, 2);

  for(i = 0; i < n_hits; i++) {
    wait randomfloatrange(0.1, 0.25);
    level.player playsoundtoplayer(#"hash_6f23e713eb9dc8b6", level.player);
  }
}

function function_3e0633ef() {
  self notify("76c6bc157b2fd02f");
  self endon("76c6bc157b2fd02f");
  level endon(#"hash_140019c0ef68a765");
  var_909be19 = level.gameskill;

  if(!isDefined(var_909be19)) {
    var_909be19 = 1;
  }

  while(true) {
    while(var_909be19 == level.gameskill) {
      waitframe(1);
    }

    var_909be19 = level.gameskill;
    function_32477c69();
  }
}

function function_d8afd6c7() {
  n_health = 2000;

  if(isDefined(level.gameskill)) {
    switch (level.gameskill) {
      case 0:
        n_health = 2200;
        break;
      case 3:
        n_health = 1900;
        break;
      case 4:
        n_health = 1800;
        break;
    }
  }

  return n_health;
}

function function_5f3b3863(var_53bb8ef2) {
  self endon(#"death");

  if(is_true(var_53bb8ef2.var_90de8a20)) {
    return;
  }

  var_53bb8ef2.var_90de8a20 = 1;
  var_7aa944d9 = self.origin;
  var_fc58e99b = 1;

  for(i = 0; i < 3; i++) {
    wait 1;

    if(distancesquared(var_7aa944d9, self.origin) > sqr(1000)) {
      var_fc58e99b = 0;
      break;
    }

    var_7aa944d9 = self.origin;
  }

  if(var_fc58e99b) {
    var_53bb8ef2.var_6f17e122 = 1;
    var_53bb8ef2.var_b0bffa0a = 0;

    while(true) {
      wait 1;

      if(distancesquared(var_7aa944d9, self.origin) > sqr(250)) {
        break;
      }

      var_7aa944d9 = self.origin;
    }

    var_53bb8ef2.var_6f17e122 = 0;
    self val::set(#"hash_5c6b30eb86f98bcb", "takedamage", 0);
    wait 6;
    self val::reset(#"hash_5c6b30eb86f98bcb", "takedamage");
  }

  var_53bb8ef2.var_90de8a20 = 0;
}

function function_8feeb0be() {
  self notify("1df6b63859101a16");
  self endon("1df6b63859101a16");
  self endon(#"death", #"hash_455ac689d741c96b");
  self function_e7152de8();
  wait 5;
  var_53bb8ef2 = level.var_53bb8ef2;
  var_be81a997 = function_d8afd6c7();
  var_c62824cc = var_53bb8ef2.var_cfa81957;

  if(var_c62824cc >= var_be81a997) {
    return;
  }

  var_61dc66d2 = 5 * (1 - var_c62824cc / var_be81a997);
  var_8fc81e63 = gettime();

  while(true) {
    n_time_passed = float(gettime() - var_8fc81e63) / 1000;
    n_percent = min(1, n_time_passed / var_61dc66d2);
    var_53bb8ef2.var_cfa81957 = lerpfloat(var_c62824cc, var_be81a997, n_percent);
    self function_e7152de8();

    if(n_percent >= 1) {
      break;
    }

    waitframe(1);
  }
}

function function_e7152de8() {
  var_6a94bb25 = function_d8afd6c7();
  var_82c2d032 = var_6a94bb25 / 4;
  var_53bb8ef2 = level.var_53bb8ef2;
  var_4cd42d59 = 0;

  for(i = 0; i < 4; i++) {
    if(var_53bb8ef2.var_cfa81957 <= var_6a94bb25 - var_82c2d032 * i) {
      var_4cd42d59 = i;
    }
  }

  if(var_53bb8ef2.var_9df3157 != var_4cd42d59) {
    if(var_4cd42d59 > var_53bb8ef2.var_9df3157) {
      level thread function_17203f6f();
    }

    self vehicle::set_damage_fx_level(var_4cd42d59);
    var_53bb8ef2.var_9df3157 = var_4cd42d59;
  }
}

function function_3623e8fb() {
  t_oob = getent("t_player_heli_oob", "targetname");
  t_oob triggerenable(1);
}

function function_13237d0a() {
  t_oob = getent("t_player_heli_oob", "targetname");
  t_oob triggerenable(0);
}

function function_c8abf85b(e_player) {
  level.var_53bb8ef2.var_78bd98cb thread function_ff36634b();
}

function function_ff36634b() {
  self endon(#"death");
  playFXOnTag(#"hash_4f1f5945e75fd8c6", self, "tag_body");
  playFXOnTag(#"hash_1a0d6a6745ac6af", self, "tag_body");
  earthquake(0.5, 1, self.origin, 5000);
  self notify(#"hash_455ac689d741c96b");
  self thread namespace_c8fb02a7::function_2a0f9c3c();
  level thread helicopter::function_437dfc97();

  if(isDefined(level.player)) {
    level.player startcameratween(2);
  }

  waitframe(1);

  if(isDefined(level.player)) {
    level.player cameraactivate(1);
    level.player camerasetlookat(self);
    level.player camerasetposition(level.player getplayercamerapos());
    level.overrideplayerdamage = undefined;
    level.player util::stop_magic_bullet_shield();
    level.player.allowdeath = 1;
    level.player kill();
  }

  wait 2;

  if(isDefined(level.player)) {
    level.player camerasetlookat(self.origin);
    level.player playrumbleonentity("damage_heavy");
  }

  self.overridevehicledamage = undefined;
  self kill();
}

function function_9be6ef5f() {
  self notify("40f97006c33fab50");
  self endon("40f97006c33fab50");
  level endon(#"hash_140019c0ef68a765");

  while(true) {
    level waittill(#"save_restore");
    function_32477c69();
  }
}

function function_32477c69() {
  level notify(#"hash_455ac689d741c96b");
  var_53bb8ef2 = level.var_53bb8ef2;

  if(isDefined(var_53bb8ef2)) {
    var_53bb8ef2.var_b0bffa0a = 0;
    var_53bb8ef2.var_cafcae4c = 0;
    var_53bb8ef2.var_9df3157 = 0;
    var_53bb8ef2.var_cfa81957 = function_d8afd6c7();

    if(isDefined(var_53bb8ef2.var_78bd98cb)) {
      var_53bb8ef2.var_78bd98cb vehicle::set_damage_fx_level(0);
    }
  }
}

function function_6cf6a8c2(s_spawn, var_86a56d5f = 1, var_9f1d53c7 = 1, var_59ec68d9) {
  self.script_int = s_spawn.script_int;
  self.script_noteworthy = s_spawn.script_noteworthy;
  self.var_214db6bf = s_spawn;
  self.var_bc2f081e = s_spawn.var_bc2f081e;
  self.voiceprefix = undefined;
  self.var_3d0026c9 = undefined;

  if(isactor(self)) {
    var_562dce82 = self;

    if(isDefined(s_spawn)) {
      v_spawn = getclosestpointonnavmesh(s_spawn.origin);

      if(!isDefined(v_spawn)) {
        v_spawn = s_spawn.origin;
      }

      self forceteleport(v_spawn, s_spawn.angles);
      var_562dce82 = s_spawn;

      if(isDefined(s_spawn.var_68dbe0ef)) {
        self thread function_e1fb8179(s_spawn.var_68dbe0ef);
      }
    }

    if(isDefined(var_562dce82.target)) {
      if(isDefined(var_59ec68d9)) {
        self thread function_906d6449(var_562dce82, var_59ec68d9);
      } else {
        goal = struct::get(var_562dce82.target);

        if(!isDefined(goal)) {
          goal = getnode(var_562dce82.target, "targetname");

          if(!isDefined(goal)) {
            goal = getent(var_562dce82.target, "targetname");
          }
        }

        if(isDefined(goal)) {
          if(var_86a56d5f) {
            if(isentity(goal)) {
              self setgoal(goal, 1);
            } else {
              self thread spawner::go_to_node(goal);
            }
          } else {
            if(isstruct(goal)) {
              goal = goal.origin;
            }

            self setgoal(goal, 1);
          }
        }
      }

      if(self util::is_on_side(#"axis")) {
        self.script_accuracy = 50;

        if(var_9f1d53c7) {
          self function_c9e47ce7();
        }
      }
    }
  }

  if(!function_8d8e91af(self)) {
    if(isactor(self)) {
      self callback::function_d8abfc3d(#"on_ai_killed", &function_cb853b3d);
    } else if(isvehicle(self)) {
      self callback::function_d8abfc3d(#"on_vehicle_killed", &function_edf88bbb);
    }
  }

  if(function_8d8e91af(self)) {
    return;
  }

  if(isvehicle(self)) {
    if(isDefined(s_spawn)) {
      self.origin = s_spawn.origin;
      self.angles = s_spawn.angles;
    }

    var_8be533d2 = self.target;

    if(isDefined(s_spawn.target)) {
      var_8be533d2 = s_spawn.target;
    }

    if(isDefined(var_8be533d2) && (!isDefined(s_spawn) || var_8be533d2 != s_spawn.targetname)) {
      nd_path = getvehiclenode(var_8be533d2, "targetname");

      if(isDefined(nd_path)) {
        if(var_86a56d5f) {
          self thread vehicle::get_on_and_go_path(nd_path);
          return;
        }

        self vehicle::get_on_path(nd_path);
      }
    }
  }
}

function function_e1fb8179(var_68dbe0ef) {
  self endon(#"death");
  destructible = struct::get("pch_dest_kill_" + var_68dbe0ef, "script_noteworthy");

  if(isDefined(destructible)) {
    destructible waittill(#"hash_5bb6862842cacfe8");
    self thread function_3338c8d0(destructible.origin);
  }
}

function function_3338c8d0(var_77e64dda) {
  self kill();
  wait 0.15;

  if(!isDefined(var_77e64dda) || !isDefined(self)) {
    return;
  }

  v_launch = (0, 0, 0);
  v_direction = self.origin - var_77e64dda;
  v_direction = vectornormalize((v_direction[0], v_direction[1], 0));
  v_launch = v_direction * randomfloatrange(35, 65) + (0, 0, randomfloatrange(35, 65));
  self startragdoll();
  self launchragdoll(v_launch, array::random(["tag_origin", "j_spineupper", "j_spinelower", "j_head"]));
}

function function_906d6449(var_562dce82, var_59ec68d9) {
  self endon(#"death");
  self.ignoreall = 1;
  self.fixednode = 1;
  self notify(#"stop_going_to_node");
  level flag::wait_till(var_59ec68d9);
  goal = struct::get(var_562dce82.target);

  if(!isDefined(goal)) {
    goal = getnode(var_562dce82.target, "targetname");

    if(!isDefined(goal)) {
      goal = getent(var_562dce82.target, "targetname");
    }
  }

  if(!isDefined(goal)) {
    return;
  }

  self setdesiredspeed("sprint");
  var_4f401c38 = goal.target;

  while(isDefined(var_4f401c38)) {
    next_goal = struct::get(var_4f401c38);

    if(!isDefined(next_goal)) {
      next_goal = getnode(var_4f401c38, "targetname");
    }

    if(isDefined(next_goal.target)) {
      var_4f401c38 = next_goal.target;
      continue;
    }

    break;
  }

  if(!isDefined(var_4f401c38)) {
    var_4f401c38 = goal.targetname;
  }

  var_d55bf3de = struct::get(var_4f401c38);

  if(!isDefined(var_d55bf3de)) {
    var_d55bf3de = getnode(var_4f401c38, "targetname");
  }

  wait randomfloat(1);
  self.ignoreall = 0;
  self.fixednode = 0;
  self thread spawner::go_to_node(goal);
}

function function_cb853b3d(s_params) {
  if(level.var_c2ccaeac === # "defend_firebase_ripcord" || level.var_c2ccaeac === # "secure_the_nuke") {
    if(isPlayer(s_params.eattacker)) {
      function_53c1b17f(s_params);
    }

    if(isDefined(self) && !function_24648886(self)) {
      self deletedelay();
      return;
    }

    level thread function_ec8864c(self);
  }

  if(s_params.weapon === level.var_53bb8ef2.var_df6d4579) {
    level thread function_adc4e3e3(self);
  }
}

function function_adc4e3e3(var_add480b6) {
  if(isDefined(var_add480b6)) {
    wait 0.15;

    if(isDefined(var_add480b6)) {
      v_launch = (0, 0, 0);

      for(i = 0; i < 3; i++) {
        var_66732ef3 = randomfloatrange(35, 80);

        if(i < 2 && math::cointoss()) {
          var_66732ef3 *= -1;
        }

        switch (i) {
          case 0:
            v_launch += (var_66732ef3, 0, 0);
            break;
          case 1:
            v_launch += (0, var_66732ef3, 0);
            break;
          case 2:
            v_launch += (0, 0, var_66732ef3);
            break;
        }
      }

      var_add480b6 startragdoll();
      var_add480b6 launchragdoll(v_launch, array::random(["tag_origin", "j_spineupper", "j_spinelower", "j_head"]));
    }
  }
}

function function_edf88bbb(s_params) {
  level thread function_53d20a8c(self, s_params);
  level thread function_a0d52507(self, s_params);
  function_53c1b17f(s_params);
}

function function_53d20a8c(vehicle, s_params) {
  if(isDefined(vehicle)) {
    var_fff98e50 = function_e45cbe76(vehicle.origin, 512, #"axis");

    foreach(var_d32424f1 in var_fff98e50) {
      if(isalive(var_d32424f1)) {
        var_d32424f1 kill(var_d32424f1.origin, s_params.eattacker, s_params.einflictor, s_params.weapon);
        waitframe(1);
      }
    }
  }
}

function function_a0d52507(var_a485bd2b, s_params) {
  if(isDefined(var_a485bd2b)) {
    switch (var_a485bd2b.vehicletype) {
      default:
        return;
      case # "hash_64eb6f83a98f9b6":
      case # "hash_331dac1d7450a6ed":
      case # "hash_57f7c02f5db425b9":
        var_d1bcfb0f = 250;
        var_88814cc1 = 300;
        break;
      case # "hash_2bf574cefe3e6d9e":
      case # "hash_3677daa34d36098a":
      case # "hash_3cdadb03ee525329":
        var_d1bcfb0f = 1100;
        var_88814cc1 = 1200;
        break;
    }

    if(!var_a485bd2b function_b835102b()) {
      v_origin = var_a485bd2b.origin;
      v_angles = var_a485bd2b.angles;
      v_velocity = var_a485bd2b getvelocity();
      var_a485bd2b notsolid();
      var_a485bd2b ghost();
    }

    var_a485bd2b vehicle::get_off_path();

    if(var_a485bd2b function_b835102b()) {
      wait 0.15;
    }

    if(isDefined(var_a485bd2b)) {
      if(var_a485bd2b function_b835102b()) {
        v_origin = var_a485bd2b.origin;
        v_angles = var_a485bd2b.angles;
      }

      v_up = anglestoup(v_angles);
      v_launch = v_up * randomfloatrange(var_d1bcfb0f, var_88814cc1);
      v_right = anglestoright(v_angles);
      v_side = v_right;
      var_33d2e98f = {
        #origin: v_origin, #angles: v_angles
      };

      if(isDefined(var_a485bd2b.var_bc2f081e)) {
        if(var_a485bd2b.var_bc2f081e == "left") {
          v_side *= -1;
        }
      } else if(var_33d2e98f math::get_dot_right(s_params.eattacker.origin) > 0) {
        v_side *= -1;
      }

      v_launch += v_side * randomfloatrange(var_d1bcfb0f, var_88814cc1);
      var_7caa77 = var_33d2e98f math::get_dot_forward(s_params.eattacker.origin);

      if(abs(var_7caa77) > 0.5) {
        v_forward = anglesToForward(v_angles);

        if(var_7caa77 > 0) {
          v_launch += v_forward * -1 * randomfloatrange(var_d1bcfb0f, var_88814cc1);
        } else {
          v_launch += v_forward * randomfloatrange(var_d1bcfb0f, var_88814cc1);
        }
      }

      if(var_a485bd2b function_b835102b()) {
        var_a485bd2b launchvehicle(v_launch, v_origin, 0, 1);
        return;
      }

      var_6bd119d1 = util::spawn_model(var_a485bd2b.deathmodel, v_origin, v_angles);
      level thread function_15453e56(var_6bd119d1, var_a485bd2b);
      playFXOnTag(#"hash_675029ecfb9f0c0e", var_6bd119d1, "tag_body_animate");
      var_6bd119d1 physicslaunch(var_6bd119d1.origin, v_launch);
    }
  }
}

function function_15453e56(var_6bd119d1, var_df50ed) {
  while(isDefined(var_6bd119d1) && isDefined(var_df50ed)) {
    waitframe(1);
  }

  if(isDefined(var_6bd119d1)) {
    var_6bd119d1 delete();
  }
}

function function_c9e47ce7() {
  if(isDefined(level.var_53bb8ef2.var_78bd98cb)) {
    if(issubstr(self.aitype, "rpg")) {
      self thread function_e334faa2();
      return;
    }

    a_tags = array("tag_engine_right", "tag_engine_left", "tag_door_front_left_animate", "tag_door_front_right_animate");
    self clearentitytarget();
    self setentitytarget(level.var_53bb8ef2.var_78bd98cb, 1, a_tags[randomint(a_tags.size)]);
  }
}

function function_e334faa2() {
  self endon(#"death");
  level endon(#"hash_34bafa63913f5978");
  var_1c16ecf8 = 2750;
  var_fc348a84 = 0;

  if(!isDefined(self.var_23ecda53)) {
    self.var_23ecda53 = spawn("script_model", self.origin);
    self.var_23ecda53 setModel("tag_origin");
    level thread function_ca31f3fa(self, self.var_23ecda53);
  }

  self clearentitytarget();
  self setentitytarget(self.var_23ecda53, 1, "tag_origin");

  while(isalive(level.var_53bb8ef2.var_78bd98cb)) {
    velocity = level.var_53bb8ef2.var_78bd98cb getvelocity();
    var_e5e8cdc0 = (velocity[0], velocity[1], 0);
    var_bc097d48 = vectornormalize((level.var_53bb8ef2.var_78bd98cb.origin[0], level.var_53bb8ef2.var_78bd98cb.origin[1], 0) - (self.origin[0], self.origin[1], 0));
    var_648ba6f2 = vectornormalize((velocity[0], velocity[1], 0));
    n_dot = vectordot(var_648ba6f2, var_bc097d48);
    dist_to_target = distance2d(self.origin, level.var_53bb8ef2.var_78bd98cb.origin);
    var_fc348a84 = dist_to_target / var_1c16ecf8;
    var_639005a4 = distance2d(level.var_53bb8ef2.var_78bd98cb.origin, level.var_53bb8ef2.var_78bd98cb.origin + velocity * var_fc348a84);
    var_bdd7184f = (0, 0, 240);

    if(n_dot > 0.75) {
      var_fc348a84 += var_639005a4 / var_1c16ecf8;
      self.var_23ecda53.origin = level.var_53bb8ef2.var_78bd98cb.origin + var_e5e8cdc0 * var_fc348a84 + var_bdd7184f;
    } else if(n_dot < -0.75) {
      var_fc348a84 -= var_639005a4 / var_1c16ecf8;
      self.var_23ecda53.origin = level.var_53bb8ef2.var_78bd98cb.origin + var_e5e8cdc0 * var_fc348a84 + var_bdd7184f;
    } else {
      self.var_23ecda53.origin = level.var_53bb8ef2.var_78bd98cb.origin + var_e5e8cdc0 * var_fc348a84 + var_bdd7184f;
    }

    waitframe(1);
  }

  self clearentitytarget();
}

function function_ca31f3fa(e_parent, var_1080e7e4) {
  e_parent waittill(#"death");
  var_1080e7e4 delete();
}

function function_f994e739() {
  level endon(#"game_ended");
  self endon(#"death");
  self val::set(#"hash_5827a24ebe1f127", "ignoreme", 1);
  waitframe(1);
  self turret::set_burst_parameters(1, 2, 0.25, 0.5, 1);
  self turret::enable(1, 0);
  self turret::function_41c79ce4(1, 1);
  var_78bd98cb = level.var_53bb8ef2.var_78bd98cb;
  v_offset = (0, 0, 0);
  self turret::set_target(var_78bd98cb, v_offset, 1, 1);
  self turret::function_49c3b892(var_78bd98cb, 1);

  while(isalive(var_78bd98cb)) {
    self getperfectinfo(var_78bd98cb, 1);
    wait 1.5;
  }
}

function function_cc00984b() {
  self endoncallback(&function_e4bfb57e, #"death", #"hash_70183fb94b2642f0");

  while(true) {
    while(self getspeed() <= 0) {
      wait 1;
    }

    self clientfield::set("" + # "hash_2299cc8957801441", 1);

    while(self getspeed() > 0) {
      wait 1;
    }

    self clientfield::set("" + # "hash_2299cc8957801441", 0);
  }
}

function function_e4bfb57e(str_notify) {
  self clientfield::set("" + # "hash_2299cc8957801441", 0);
}

function function_fb080e60(var_b6fdd6f2, var_7af285a8 = 0) {
  if(!isDefined(var_b6fdd6f2)) {
    var_b6fdd6f2 = [];
  } else if(!isarray(var_b6fdd6f2)) {
    var_b6fdd6f2 = array(var_b6fdd6f2);
  }

  foreach(cleanup_ent in var_b6fdd6f2) {
    if(isDefined(cleanup_ent)) {
      if(var_7af285a8 && is_true(cleanup_ent.var_36ceff65)) {
        continue;
      }

      cleanup_ent delete();
    }
  }
}

function function_3e652c23(var_b6fdd6f2, var_dfe17990, var_845c9577) {
  var_e649ad5 = struct::get(var_dfe17990, "targetname");

  while(!flag::get(var_845c9577)) {
    if(!isDefined(var_e649ad5)) {
      break;
    }

    if(!util::within_fov(level.player.origin, level.player.angles, var_e649ad5.origin, cos(70))) {
      break;
    }

    wait 0.3;
  }

  function_fb080e60(var_b6fdd6f2);
}

function function_d305a607(var_3ba94e96, str_spawns, var_86a56d5f = 1, var_9f1d53c7 = 1, spawn_func, arg1, arg2, arg3) {
  var_2199674d = [];
  a_spawners = getspawnerarray(var_3ba94e96, "targetname");

  if(a_spawners.size <= 0) {
    return [];
  }

  if(!isDefined(str_spawns)) {
    a_s_spawns = function_49a2ca0c(a_spawners);
  } else {
    a_s_spawns = function_49a2ca0c(str_spawns);
  }

  foreach(s_spawn in a_s_spawns) {
    spawner = function_84228c0e(s_spawn, a_spawners);
    e_spawned = function_27d376a0(spawner, s_spawn, var_86a56d5f, var_9f1d53c7, spawn_func, arg1, arg2, arg3);

    if(!isDefined(var_2199674d)) {
      var_2199674d = [];
    } else if(!isarray(var_2199674d)) {
      var_2199674d = array(var_2199674d);
    }

    var_2199674d[var_2199674d.size] = e_spawned;
  }

  return var_2199674d;
}

function function_49a2ca0c(source) {
  var_3be3a3f8 = 0;

  if(isarray(source)) {
    var_3bc84e2 = [];

    foreach(spawner in source) {
      foreach(s_spawn in struct::get_array(spawner.target)) {
        s_spawn.var_cd2ac598 = spawner;

        if(!isDefined(var_3bc84e2)) {
          var_3bc84e2 = [];
        } else if(!isarray(var_3bc84e2)) {
          var_3bc84e2 = array(var_3bc84e2);
        }

        var_3bc84e2[var_3bc84e2.size] = s_spawn;
      }
    }
  } else {
    var_3be3a3f8 = 1;
    var_3bc84e2 = struct::get_array(source);
  }

  var_cc56247a = [];
  var_f9d15262 = [];

  foreach(s_spawn in var_3bc84e2) {
    if(var_3be3a3f8 && !isDefined(s_spawn.var_d691a932) && !isDefined(s_spawn.var_bf2d3e18)) {
      continue;
    }

    if(isDefined(s_spawn.script_int)) {
      if(!isDefined(var_cc56247a)) {
        var_cc56247a = [];
      } else if(!isarray(var_cc56247a)) {
        var_cc56247a = array(var_cc56247a);
      }

      var_cc56247a[var_cc56247a.size] = s_spawn;
      continue;
    }

    if(!isDefined(var_f9d15262)) {
      var_f9d15262 = [];
    } else if(!isarray(var_f9d15262)) {
      var_f9d15262 = array(var_f9d15262);
    }

    var_f9d15262[var_f9d15262.size] = s_spawn;
  }

  var_cc56247a = array::sort_by_script_int(var_cc56247a, 1);
  a_s_spawns = arraycombine(var_cc56247a, var_f9d15262);
  return a_s_spawns;
}

function function_84228c0e(s_spawn, a_spawners) {
  if(isDefined(s_spawn.var_cd2ac598)) {
    return s_spawn.var_cd2ac598;
  }

  var_828a77d1 = s_spawn.var_d691a932;

  if(!isDefined(var_828a77d1)) {
    var_828a77d1 = s_spawn.var_bf2d3e18;
  }

  if(isDefined(var_828a77d1)) {
    foreach(spawner in a_spawners) {
      var_b8e762a2 = spawner.var_d691a932;

      if(!isDefined(var_b8e762a2)) {
        var_b8e762a2 = spawner.var_bf2d3e18;
      }

      if(var_828a77d1 === var_b8e762a2) {
        return spawner;
      }
    }
  }
}

function function_27d376a0(spawner, s_spawn, var_86a56d5f = 1, var_9f1d53c7 = 1, spawn_func, arg1, arg2, arg3) {
  v_original_origin = spawner.origin;
  var_156222bf = spawner.angles;
  var_62c2f167 = spawner.target;

  if(is_true(spawner.script_drone)) {
    spawner.origin = s_spawn.origin;
    spawner.angles = s_spawn.angles;
    spawner.target = s_spawn.target;
  }

  while(true) {
    e_spawned = spawner::simple_spawn_single(spawner, &function_6cf6a8c2, s_spawn, var_86a56d5f, var_9f1d53c7);

    if(isDefined(e_spawned)) {
      break;
    }

    util::wait_network_frame();
  }

  if(isDefined(spawn_func)) {
    util::single_thread(e_spawned, spawn_func, arg1, arg2, arg3);
  }

  spawner.origin = v_original_origin;
  spawner.angles = var_156222bf;
  spawner.target = var_62c2f167;
  return e_spawned;
}

function function_7fb76185() {
  self.var_72cf1573 = 1;
  self.overridevehicledamage = &function_3fe8ed1d;
}

function function_3fe8ed1d(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(self flag::get(#"hash_385108f80acca96c")) {
    return 0;
  }

  if(self.health - modelindex <= 0) {
    var_763db622 = {
      #vpoint: vsurfacenormal, #eattacker: damagefromunderneath, #einflictor: psoffsettime, #weapon: partname
    };
    var_a57e0aff = level.var_53bb8ef2.var_a57e0aff;
    var_a57e0aff function_c2812178(var_763db622);
    return 0;
  }

  return modelindex;
}

function function_c2812178(var_763db622) {
  s_event = {
    #var_763db622: var_763db622
  };

  if(!isDefined(self.var_d39130d2)) {
    self.var_d39130d2 = [];
  } else if(!isarray(self.var_d39130d2)) {
    self.var_d39130d2 = array(self.var_d39130d2);
  }

  self.var_d39130d2[self.var_d39130d2.size] = s_event;

  if(self flag::get(#"processing")) {
    return;
  }

  self flag::set(#"processing");
  self thread function_4e7bc9d9();
}

function function_4e7bc9d9() {
  while(self.var_d39130d2.size > 0) {
    s_event = self.var_d39130d2[0];
    arrayremoveindex(self.var_d39130d2, 0);
    var_763db622 = s_event.var_763db622;
    v_impact = var_763db622.vpoint;
    var_1ffbc8e0 = function_19e76ff2(v_impact, 400);
    var_6d773c04 = arraygetclosest(v_impact, var_1ffbc8e0);

    if(isalive(var_6d773c04)) {
      if(is_true(var_6d773c04.var_3314f72b) && !isPlayer(var_763db622.eattacker)) {
        waitframe(1);
        continue;
      }

      function_3f36f605(var_6d773c04, s_event);
      s_event.var_e7b886bf = var_6d773c04.player_heli_vehicle_cascade_forced;
      s_event.var_3728a157 = var_6d773c04.var_b71ad346;
      str_vehicletype = var_6d773c04.vehicletype;
      var_6d773c04 kill(v_impact, var_763db622.eattacker, var_763db622.einflictor, var_763db622.weapon);

      if(var_6d773c04 flag::get(#"hash_40e1cea03744d0f1") || is_true(var_6d773c04.var_a84747b2) && var_763db622.weapon !== level.var_53bb8ef2.var_df6d4579) {
        waitframe(1);
        continue;
      }

      var_1ffbc8e0 = function_19e76ff2(v_impact, 850);
      arrayremovevalue(var_1ffbc8e0, var_6d773c04);

      for(i = 0; i < var_1ffbc8e0.size; i++) {
        var_3a99b470 = var_1ffbc8e0[i];

        if(!var_3a99b470 function_986e037a(str_vehicletype, v_impact, s_event.var_3728a157)) {
          var_1ffbc8e0[i] = -1;
          continue;
        }

        function_3f36f605(var_3a99b470, s_event);
      }

      arrayremovevalue(var_1ffbc8e0, -1);
      s_event.var_c3f64d04 = [];

      foreach(var_3a99b470 in var_1ffbc8e0) {
        var_834347de = spawnStruct();
        var_834347de.s_event = s_event;
        var_834347de.v_impact = v_impact;
        var_834347de.var_3728a157 = s_event.var_3728a157;
        var_834347de.var_e2112f87 = [var_3a99b470];

        if(!isDefined(s_event.var_c3f64d04)) {
          s_event.var_c3f64d04 = [];
        } else if(!isarray(s_event.var_c3f64d04)) {
          s_event.var_c3f64d04 = array(s_event.var_c3f64d04);
        }

        s_event.var_c3f64d04[s_event.var_c3f64d04.size] = var_834347de;
        function_1cd28808(var_3a99b470, var_834347de);
      }

      wait randomfloatrange(0.1, 0.3);

      foreach(var_834347de in s_event.var_c3f64d04) {
        level thread function_89d33f48(s_event, var_834347de);
        wait randomfloatrange(0.1, 0.3);
      }
    }

    waitframe(1);
  }

  self flag::clear(#"processing");
}

function function_19e76ff2(v_origin, n_radius) {
  var_87105910 = [];
  var_1ffbc8e0 = arraysortclosest(getentarraybytype(12), v_origin, undefined, 0, n_radius);

  foreach(var_3a99b470 in var_1ffbc8e0) {
    if(!var_3a99b470 flag::get(#"hash_385108f80acca96c") && !isspawner(var_3a99b470) && !isvehiclespawner(var_3a99b470) && is_true(var_3a99b470.var_72cf1573)) {
      if(!isDefined(var_87105910)) {
        var_87105910 = [];
      } else if(!isarray(var_87105910)) {
        var_87105910 = array(var_87105910);
      }

      var_87105910[var_87105910.size] = var_3a99b470;
    }
  }

  return var_87105910;
}

function function_986e037a(str_vehicletype, v_impact, var_3728a157) {
  if(self flag::get(#"hash_40e1cea03744d0f1")) {
    return false;
  }

  if(str_vehicletype != # "hash_4420cded39673048" && self.vehicletype == # "hash_4420cded39673048") {
    return false;
  }

  if(isDefined(var_3728a157) && isDefined(v_impact) && distancesquared(self.origin, v_impact) > sqr(var_3728a157)) {
    return false;
  }

  return true;
}

function function_1cd28808(var_6d773c04, var_834347de) {
  if(!isalive(var_6d773c04)) {
    return;
  }

  var_1ffbc8e0 = function_19e76ff2(var_6d773c04.origin, 850);
  arrayremovevalue(var_1ffbc8e0, var_6d773c04);

  foreach(var_3a99b470 in var_1ffbc8e0) {
    if(!var_3a99b470 function_986e037a(var_6d773c04.vehicletype, var_834347de.v_impact, var_834347de.var_3728a157)) {
      continue;
    }

    function_3f36f605(var_3a99b470, var_834347de);

    if(!isDefined(var_834347de.var_e2112f87)) {
      var_834347de.var_e2112f87 = [];
    } else if(!isarray(var_834347de.var_e2112f87)) {
      var_834347de.var_e2112f87 = array(var_834347de.var_e2112f87);
    }

    if(!isinarray(var_834347de.var_e2112f87, var_3a99b470)) {
      var_834347de.var_e2112f87[var_834347de.var_e2112f87.size] = var_3a99b470;
    }

    function_1cd28808(var_3a99b470, var_834347de);
  }
}

function function_3f36f605(var_52fba58, struct) {
  if(isalive(var_52fba58)) {
    var_52fba58 flag::set(#"hash_385108f80acca96c");
    var_52fba58 thread function_5c4f6a39(struct);
  }
}

function function_5c4f6a39(struct) {
  self endon(#"death");
  wait 5;
  var_763db622 = struct.var_763db622;
  self kill(var_763db622.vpoint, var_763db622.eattacker, var_763db622.einflictor, var_763db622.weapon);
}

function function_89d33f48(s_event, var_834347de) {
  var_e2112f87 = arraycopy(var_834347de.var_e2112f87);
  function_1eaaceab(var_e2112f87);

  if(var_e2112f87.size > 0) {
    var_763db622 = s_event.var_763db622;
    var_e2112f87 = arraysortclosest(var_e2112f87, var_763db622.vpoint);

    foreach(var_e8a1125f in var_e2112f87) {
      if(isalive(var_e8a1125f)) {
        var_e8a1125f kill(var_763db622.vpoint, var_763db622.eattacker, var_763db622.einflictor, var_763db622.weapon);
        wait randomfloatrange(0.1, 0.3);
      }
    }
  }

  arrayremovevalue(s_event.var_c3f64d04, var_834347de);

  if(s_event.var_c3f64d04.size <= 0 && isDefined(s_event.var_e7b886bf) && !s_event flag::get(#"hash_5d237dd0c256d3e1")) {
    s_event flag::set(#"hash_5d237dd0c256d3e1");
    var_94e90887 = getEntArray(s_event.var_e7b886bf, "player_heli_vehicle_cascade_forced", 1);
    function_1eaaceab(var_94e90887);

    if(var_94e90887.size > 0) {
      var_834347de = spawnStruct();
      var_834347de.var_e2112f87 = var_94e90887;
      level thread function_89d33f48(s_event, var_834347de);
    }
  }
}

function function_4f34fd5a(var_d3440450 = "", var_7f6942d7 = "fighting_hind", var_74165b46 = "hind_destroyed") {
  var_1f372b50 = level.var_1f372b50;
  var_1f372b50 endon(#"skipped_01", #"skipped_02");
  var_cb8bae59 = 0;
  flag::clear("flag_obj_fly_3_return_00_m");
  flag::clear("flag_obj_fly_3_hut_1");

  if(var_d3440450 == "player_controlled_huey_02") {
    flag::set("flag_obj_fly_3_return_00_m");
    flag::set("flag_obj_fly_3_hut_1");
    flag::set("flag_obj_fly_3_hut_2");
    flag::set("flag_obj_fly_3_return_01a_m");
  }

  var_c06d8037 = ["obj_fly_3_return_00_m", "obj_fly_3_hut_1", "obj_fly_3_hut_2", "obj_fly_3_return_01a_m", "obj_fly_3_return_01b_m", "obj_fly_3_return_02", "obj_fly_3_return_03", "obj_fly_3_return_04", "obj_fly_3_return_05"];
  var_867db8c = ["flag_obj_fly_3_return_00_m", "flag_obj_fly_3_hut_1", "flag_obj_fly_3_hut_2", "flag_obj_fly_3_return_01a_m", "flag_obj_fly_3_return_01b_m", "flag_obj_fly_3_return_02", "flag_obj_fly_3_return_03", "flag_obj_fly_3_return_04", "flag_obj_fly_3_return_05"];
  assert(var_c06d8037.size == var_867db8c.size, "<dev string:x65>");

  while(true) {
    str_flag = "";
    str_struct = "";

    for(i = 0; i < var_867db8c.size; i++) {
      if(!flag::get(var_867db8c[i])) {
        str_flag = var_867db8c[i];
        str_struct = var_c06d8037[i];
        break;
      }
    }

    var_1f372b50.s_waypoint = struct::get(str_struct);

    if(flag::get(var_7f6942d7) || flag::get("hide_pch_obj")) {
      objectives::complete("armada_obj_fly_to_firebase", var_1f372b50.s_waypoint);

      if(!var_cb8bae59 && flag::get(var_7f6942d7)) {
        level thread objectives::kill("armada_obj_kill_the_hind", level.enemy_heli, #"hash_17e6b740b76e28b8", undefined, undefined, undefined, #"hash_17f4660b06e37fdb");
        var_cb8bae59 = 1;
      }

      if(i < var_867db8c.size) {
        if(flag::get("hide_pch_obj")) {
          level flag::clear("hide_pch_obj");
          level flag::wait_till_any([str_flag, var_7f6942d7, var_74165b46]);
        } else {
          level flag::wait_till_any([str_flag, var_74165b46, "hide_pch_obj"]);
        }
      } else {
        break;
      }

      continue;
    }

    level thread objectives::function_4eb5c04a("armada_obj_fly_to_firebase", var_1f372b50.s_waypoint, #"hash_5483ae2de22e69c8");

    if(i < var_867db8c.size) {
      level flag::wait_till_any([str_flag, var_7f6942d7, "hide_pch_obj"]);
    } else {
      break;
    }

    objectives::complete("armada_obj_fly_to_firebase", var_1f372b50.s_waypoint);
  }

  objectives::complete("armada_obj_fly_to_firebase", var_1f372b50.s_waypoint);
}

function function_fd9a75d2(s_spawn, var_86a56d5f = 1, var_9f1d53c7 = 1) {
  self function_6cf6a8c2(s_spawn, var_86a56d5f, var_9f1d53c7);

  if(!isDefined(level.var_1f372b50.var_b6fdd6f2)) {
    level.var_1f372b50.var_b6fdd6f2 = [];
  } else if(!isarray(level.var_1f372b50.var_b6fdd6f2)) {
    level.var_1f372b50.var_b6fdd6f2 = array(level.var_1f372b50.var_b6fdd6f2);
  }

  level.var_1f372b50.var_b6fdd6f2[level.var_1f372b50.var_b6fdd6f2.size] = self;

  if(!isDefined(level.var_1f372b50.var_5b419be2)) {
    level.var_1f372b50.var_5b419be2 = [];
  } else if(!isarray(level.var_1f372b50.var_5b419be2)) {
    level.var_1f372b50.var_5b419be2 = array(level.var_1f372b50.var_5b419be2);
  }

  level.var_1f372b50.var_5b419be2[level.var_1f372b50.var_5b419be2.size] = self;
}

function function_b3dd6259(s_spawn, var_86a56d5f = 1, var_9f1d53c7 = 1) {
  self function_6cf6a8c2(s_spawn, var_86a56d5f, var_9f1d53c7);

  if(!isDefined(level.var_1f372b50.var_b6fdd6f2)) {
    level.var_1f372b50.var_b6fdd6f2 = [];
  } else if(!isarray(level.var_1f372b50.var_b6fdd6f2)) {
    level.var_1f372b50.var_b6fdd6f2 = array(level.var_1f372b50.var_b6fdd6f2);
  }

  level.var_1f372b50.var_b6fdd6f2[level.var_1f372b50.var_b6fdd6f2.size] = self;

  if(!isDefined(level.var_1f372b50.var_8b8c7c77)) {
    level.var_1f372b50.var_8b8c7c77 = [];
  } else if(!isarray(level.var_1f372b50.var_8b8c7c77)) {
    level.var_1f372b50.var_8b8c7c77 = array(level.var_1f372b50.var_8b8c7c77);
  }

  level.var_1f372b50.var_8b8c7c77[level.var_1f372b50.var_8b8c7c77.size] = self;
}

function function_4a645aa9(var_3ba94e96, str_spawns, var_86a56d5f = 1, var_9f1d53c7 = 1, spawn_func, arg1, arg2, arg3) {
  a_ai_spawned = function_d305a607(var_3ba94e96, str_spawns, var_86a56d5f, var_9f1d53c7, spawn_func, arg1, arg2, arg3);

  foreach(ai_spawned in a_ai_spawned) {
    if(!isDefined(level.var_1f372b50.var_b6fdd6f2)) {
      level.var_1f372b50.var_b6fdd6f2 = [];
    } else if(!isarray(level.var_1f372b50.var_b6fdd6f2)) {
      level.var_1f372b50.var_b6fdd6f2 = array(level.var_1f372b50.var_b6fdd6f2);
    }

    level.var_1f372b50.var_b6fdd6f2[level.var_1f372b50.var_b6fdd6f2.size] = ai_spawned;

    if(!isDefined(level.var_1f372b50.var_5b419be2)) {
      level.var_1f372b50.var_5b419be2 = [];
    } else if(!isarray(level.var_1f372b50.var_5b419be2)) {
      level.var_1f372b50.var_5b419be2 = array(level.var_1f372b50.var_5b419be2);
    }

    level.var_1f372b50.var_5b419be2[level.var_1f372b50.var_5b419be2.size] = ai_spawned;
  }

  return a_ai_spawned;
}

function function_ca66dab0(var_3ba94e96, str_spawns, var_86a56d5f = 1, var_9f1d53c7 = 1, spawn_func, arg1, arg2, arg3) {
  a_ai_spawned = function_d305a607(var_3ba94e96, str_spawns, var_86a56d5f, var_9f1d53c7, spawn_func, arg1, arg2, arg3);

  foreach(ai_spawned in a_ai_spawned) {
    if(!isDefined(level.var_1f372b50.var_b6fdd6f2)) {
      level.var_1f372b50.var_b6fdd6f2 = [];
    } else if(!isarray(level.var_1f372b50.var_b6fdd6f2)) {
      level.var_1f372b50.var_b6fdd6f2 = array(level.var_1f372b50.var_b6fdd6f2);
    }

    level.var_1f372b50.var_b6fdd6f2[level.var_1f372b50.var_b6fdd6f2.size] = ai_spawned;

    if(!isDefined(level.var_1f372b50.var_8b8c7c77)) {
      level.var_1f372b50.var_8b8c7c77 = [];
    } else if(!isarray(level.var_1f372b50.var_8b8c7c77)) {
      level.var_1f372b50.var_8b8c7c77 = array(level.var_1f372b50.var_8b8c7c77);
    }

    level.var_1f372b50.var_8b8c7c77[level.var_1f372b50.var_8b8c7c77.size] = ai_spawned;
  }

  return a_ai_spawned;
}

function function_d7c5193b(var_ff72be84, var_5986bd6d = 0, var_c6034837 = 0, var_3ac1a8ad = 0) {
  var_55804cd3 = [];

  if(var_5986bd6d > 0) {
    if(!isDefined(var_55804cd3)) {
      var_55804cd3 = [];
    } else if(!isarray(var_55804cd3)) {
      var_55804cd3 = array(var_55804cd3);
    }

    var_55804cd3[var_55804cd3.size] = "ar";
  }

  if(var_c6034837 > 0) {
    if(!isDefined(var_55804cd3)) {
      var_55804cd3 = [];
    } else if(!isarray(var_55804cd3)) {
      var_55804cd3 = array(var_55804cd3);
    }

    var_55804cd3[var_55804cd3.size] = "lmg";
  }

  if(var_3ac1a8ad > 0) {
    if(!isDefined(var_55804cd3)) {
      var_55804cd3 = [];
    } else if(!isarray(var_55804cd3)) {
      var_55804cd3 = array(var_55804cd3);
    }

    var_55804cd3[var_55804cd3.size] = "rpg";
  }

  a_ai_spawned = [];
  var_b82f118 = var_5986bd6d;
  var_50ad5cf2 = var_c6034837;
  var_51702fb9 = var_3ac1a8ad;
  n_to_spawn = var_5986bd6d + var_c6034837 + var_3ac1a8ad;

  for(i = 0; i < n_to_spawn; i++) {
    str_choice = array::random(var_55804cd3);

    switch (str_choice) {
      case # "ar":
        str_spawner = "sp_pch_convoy_01_ar";
        var_b82f118--;

        if(var_b82f118 <= 0) {
          arrayremovevalue(var_55804cd3, "ar");
        }

        break;
      case # "lmg":
        str_spawner = "sp_pch_convoy_01_lmg";
        var_50ad5cf2--;

        if(var_50ad5cf2 <= 0) {
          arrayremovevalue(var_55804cd3, "lmg");
        }

        break;
      case # "rpg":
        str_spawner = "sp_pch_convoy_01_rpg";
        var_51702fb9--;

        if(var_51702fb9 <= 0) {
          arrayremovevalue(var_55804cd3, "rpg");
        }

        break;
    }

    ai_spawned = spawner::simple_spawn_single(str_spawner, &function_f312a183, var_ff72be84, i);

    if(!isDefined(a_ai_spawned)) {
      a_ai_spawned = [];
    } else if(!isarray(a_ai_spawned)) {
      a_ai_spawned = array(a_ai_spawned);
    }

    a_ai_spawned[a_ai_spawned.size] = ai_spawned;
  }

  return a_ai_spawned;
}

function function_f312a183(var_ff72be84, n_index) {
  self endon(#"death");
  var_ff72be84 endon(#"death", #"reached_end_node");
  self function_6cf6a8c2(undefined, undefined, 0);
  self val::set("pch_ignoreall", "ignoreall", 1);
  v_forward = anglesToForward(var_ff72be84.angles);
  v_right = anglestoright(var_ff72be84.angles);

  switch (n_index) {
    case 0:
    case 1:
      n_spacing = 128;
      break;
    case 2:
    case 3:
      n_spacing = 0;
      break;
    case 4:
    case 5:
      n_spacing = -128;
      break;
  }

  var_43e399ea = -1;

  if(n_index % 2 > 0) {
    var_43e399ea = 1;
  }

  var_2ed5776a = self getpathfindingradius();
  v_center = checknavmeshdirection(var_ff72be84.origin, vectornormalize(v_forward), 180 + n_spacing, var_2ed5776a);
  v_spawn = checknavmeshdirection(v_center, vectornormalize(v_right * var_43e399ea), 180, var_2ed5776a);
  self forceteleport(v_spawn, var_ff72be84.angles);

  while(true) {
    v_forward = anglesToForward(var_ff72be84.angles);
    v_right = anglestoright(var_ff72be84.angles);
    v_center = checknavmeshdirection(var_ff72be84.origin, vectornormalize(v_forward), 180 + n_spacing, var_2ed5776a);
    v_goal = checknavmeshdirection(v_center, vectornormalize(v_right * var_43e399ea), 180, var_2ed5776a);
    self setgoal(v_goal, 1);
    waitframe(1);
  }
}

function function_e745d54c(var_ff72be84, var_5986bd6d = 0, var_c6034837 = 0, var_3ac1a8ad = 0) {
  a_ai_spawned = function_d7c5193b(var_ff72be84, var_5986bd6d, var_c6034837, var_3ac1a8ad);

  foreach(ai_spawned in a_ai_spawned) {
    if(!isDefined(level.var_1f372b50.var_b6fdd6f2)) {
      level.var_1f372b50.var_b6fdd6f2 = [];
    } else if(!isarray(level.var_1f372b50.var_b6fdd6f2)) {
      level.var_1f372b50.var_b6fdd6f2 = array(level.var_1f372b50.var_b6fdd6f2);
    }

    level.var_1f372b50.var_b6fdd6f2[level.var_1f372b50.var_b6fdd6f2.size] = ai_spawned;

    if(!isDefined(level.var_1f372b50.var_5b419be2)) {
      level.var_1f372b50.var_5b419be2 = [];
    } else if(!isarray(level.var_1f372b50.var_5b419be2)) {
      level.var_1f372b50.var_5b419be2 = array(level.var_1f372b50.var_5b419be2);
    }

    level.var_1f372b50.var_5b419be2[level.var_1f372b50.var_5b419be2.size] = ai_spawned;
  }

  return a_ai_spawned;
}

function function_f987f9d0(var_ff72be84, var_5986bd6d = 0, var_c6034837 = 0, var_3ac1a8ad = 0) {
  a_ai_spawned = function_d7c5193b(var_ff72be84, var_5986bd6d, var_c6034837, var_3ac1a8ad);

  foreach(ai_spawned in a_ai_spawned) {
    if(!isDefined(level.var_1f372b50.var_b6fdd6f2)) {
      level.var_1f372b50.var_b6fdd6f2 = [];
    } else if(!isarray(level.var_1f372b50.var_b6fdd6f2)) {
      level.var_1f372b50.var_b6fdd6f2 = array(level.var_1f372b50.var_b6fdd6f2);
    }

    level.var_1f372b50.var_b6fdd6f2[level.var_1f372b50.var_b6fdd6f2.size] = ai_spawned;

    if(!isDefined(level.var_1f372b50.var_8b8c7c77)) {
      level.var_1f372b50.var_8b8c7c77 = [];
    } else if(!isarray(level.var_1f372b50.var_8b8c7c77)) {
      level.var_1f372b50.var_8b8c7c77 = array(level.var_1f372b50.var_8b8c7c77);
    }

    level.var_1f372b50.var_8b8c7c77[level.var_1f372b50.var_8b8c7c77.size] = ai_spawned;
  }

  return a_ai_spawned;
}

function function_3b521a25(var_ff72be84, var_ada0b21) {
  if(isDefined(var_ff72be84)) {
    var_ff72be84 waittill(#"death", #"reached_end_node");
  }

  function_1eaaceab(var_ada0b21);

  foreach(var_46745ec4 in var_ada0b21) {
    var_46745ec4 val::reset("pch_ignoreall", "ignoreall");
    var_46745ec4 function_c9e47ce7();
  }
}

function function_59656f55(var_75e1daa3 = 1, var_f9b4f8aa = 1, var_8de58c85 = 1) {
  a_s_scenes = [];

  if(var_75e1daa3) {
    a_s_scenes = arraycombine(a_s_scenes, struct::get_array(#"hash_5a206ef4d4d410d7"));
  }

  if(var_f9b4f8aa) {
    a_s_scenes = arraycombine(a_s_scenes, struct::get_array(#"hash_6e898c25427fa596"));
  }

  if(var_8de58c85) {
    a_s_scenes = arraycombine(a_s_scenes, struct::get_array(#"hash_4d23e3f89e1744b2"));
  }

  if(a_s_scenes.size > 0) {
    if(isalive(level.player)) {
      a_s_scenes = arraysortclosest(a_s_scenes, level.player.origin);
    }

    foreach(s_scene in a_s_scenes) {
      if(!s_scene flag::get(#"hash_6845c57772eb7843")) {
        s_scene flag::set(#"hash_6845c57772eb7843");
        s_scene scene::init();
      }

      waitframe(1);
    }
  }
}

function function_ee098efb() {
  scene::add_scene_func(#"hash_5086f88dd131bff4", &function_223d42b1, "init");
  scene::add_scene_func(#"hash_5ba3c1b2eec0f15a", &function_223d42b1, "init");
  scene::add_scene_func(#"hash_5a9b23086dc697ed", &function_223d42b1, "init");
  scene::add_scene_func(#"hash_786d0feb8a10068e", &function_223d42b1, "init");
  scene::add_scene_func(#"hash_4fefa930a824f884", &function_223d42b1, "init");
  scene::add_scene_func(#"hash_3876cc82e38e62c1", &function_223d42b1, "init");
  scene::add_scene_func(#"hash_6bdffc7c40f3fa3f", &function_223d42b1, "init");
  scene::add_scene_func(#"hash_4ecaac634378b214", &function_223d42b1, "init");
  scene::add_scene_func(#"hash_5086f88dd131bff4", &function_eadcc337, "Shot 2");
  scene::add_scene_func(#"hash_5ba3c1b2eec0f15a", &function_eadcc337, "Shot 2");
  scene::add_scene_func(#"hash_5a9b23086dc697ed", &function_eadcc337, "Shot 2");
  scene::add_scene_func(#"hash_786d0feb8a10068e", &function_eadcc337, "Shot 2");
  scene::add_scene_func(#"hash_4fefa930a824f884", &function_eadcc337, "Shot 2");
  scene::add_scene_func(#"hash_3876cc82e38e62c1", &function_eadcc337, "Shot 2");
  scene::add_scene_func(#"hash_6bdffc7c40f3fa3f", &function_eadcc337, "Shot 2");
  scene::add_scene_func(#"hash_4ecaac634378b214", &function_eadcc337, "Shot 2");
}

function function_223d42b1(a_ents) {
  foreach(ent in a_ents) {
    if(isDefined(ent)) {
      ent setteam(#"axis");
      ent flag::set(#"hash_5e822f0ec26ae171");
    }
  }
}

function function_64cad509(var_d3440450) {
  util::delay(2, undefined, &snd::client_msg, #"hash_55704324b6ae9012");
  level thread armada_mortar::function_4c8e7a76(1);
  namespace_72b0499b::music("9.0_flying");
  function_a291d0f(var_d3440450, 1, 1);
}

function function_5854aa8c(var_d3440450, var_50cc0d4f) {
  var_1f372b50 = level.var_1f372b50;
  var_1f372b50 endon(#"skipped_01");

  if(!var_50cc0d4f) {
    function_a291d0f(var_d3440450, var_50cc0d4f, 1);
  }

  setDvar(#"hash_367578d4c1c78030", 600);
  level snd::client_msg(#"hash_4a41082a1d97f925");
  level snd::client_msg(#"hash_72dd94fb3a8887e5");
  level snd::client_msg(#"hash_551e8554285c2305");
  snd::client_msg(#"hash_2b94ea847ae2b667");
  level flag::set("flag_player_controlled_huey");
  var_75e1daa3 = 0;

  if(var_50cc0d4f) {
    var_75e1daa3 = 1;
  }

  level thread function_59656f55(var_75e1daa3, 1, 1);
  level thread function_4f34fd5a(var_d3440450);
  level thread function_d66218b9();
  level thread function_49fec2ec();
  level thread function_e817bc24();
  level thread function_ad2fd586();
  level thread function_6c8d98bf();
  level thread function_56b0e932();
  level thread function_d499f214();
  level scene::add_scene_func(#"hash_5a28b8fc9d6fc749", &function_a1a63718, "Shot 2", "Shot 2");
  level thread function_825827fb();
  level thread function_e4534482();

  if(level flag::get("flag_sp_pch_runners_02_close")) {
    level flag::clear("flag_sp_pch_runners_02_close");
  }

  level thread function_9560eef9();
  level flag::wait_till("flag_pch_complete_skipto_01");
  var_1f372b50.var_6180054f = 1;
  skipto::function_4e3ab877(var_d3440450);
}

function function_d66218b9() {
  level.var_1f372b50 endon(#"skipped_01");

  for(i = 0; i < 5; i++) {
    level thread function_d00e7d6d(i);
  }
}

function function_d00e7d6d(n_index) {
  level.var_1f372b50 endon(#"skipped_01");
  var_ff72be84 = spawner::simple_spawn_single("sp_vh_pch_convoy_01", &function_a059d587, n_index);
  level flag::wait_till("flag_pch_combat_02");

  if(isvehicle(var_ff72be84)) {
    var_a974a435 = var_ff72be84 vehicle::function_86c7bebb();
    function_fb080e60(var_a974a435);
  }

  function_fb080e60(var_ff72be84);
}

function function_a059d587(n_index) {
  self endon(#"death");
  self function_fd9a75d2(undefined, 0);
  var_8be533d2 = "nd_pch_convoy_01_0" + n_index + 1;
  nd_path = getvehiclenode(var_8be533d2, "targetname");
  self thread vehicle::get_on_and_go_path(nd_path);
}

function function_baf2710b() {
  level.var_1f372b50 endon(#"skipped_01");
  level flag::wait_till("flag_pch_combat_01");
  a_ai_spawned = function_4a645aa9("sp_pch_runners_01");
  level flag::wait_till("flag_pch_runners_01_actors_cleanup");

  foreach(ai_spawned in a_ai_spawned) {
    if(isalive(ai_spawned)) {
      ai_spawned kill();
    }
  }
}

function function_df1a44de() {
  level.var_1f372b50 endon(#"skipped_01");
  var_89472944 = function_4a645aa9("sp_pch_runners_01_drones");
  level flag::wait_till("flag_pch_runners_01_drones");
  level thread function_af0048eb(var_89472944);
  level flag::wait_till("flag_pch_combat_02");
  function_fb080e60(var_89472944);
}

function function_ad2fd586() {
  level.var_1f372b50 endon(#"skipped_01");
  a_spawners = getspawnerarray("sp_pch_runners_02", "targetname");
  a_s_spawns = function_49a2ca0c(a_spawners);
  var_94918af1 = [];

  foreach(s_spawn in a_s_spawns) {
    spawner = function_84228c0e(s_spawn, a_spawners);
    e_spawned = spawner::simple_spawn_single(spawner, &function_6cf6a8c2, s_spawn, 0, 0, "flag_sp_pch_runners_02_close");

    if(isDefined(e_spawned)) {
      if(!isDefined(level.var_1f372b50.var_b6fdd6f2)) {
        level.var_1f372b50.var_b6fdd6f2 = [];
      } else if(!isarray(level.var_1f372b50.var_b6fdd6f2)) {
        level.var_1f372b50.var_b6fdd6f2 = array(level.var_1f372b50.var_b6fdd6f2);
      }

      level.var_1f372b50.var_b6fdd6f2[level.var_1f372b50.var_b6fdd6f2.size] = e_spawned;

      if(!isDefined(level.var_1f372b50.var_5b419be2)) {
        level.var_1f372b50.var_5b419be2 = [];
      } else if(!isarray(level.var_1f372b50.var_5b419be2)) {
        level.var_1f372b50.var_5b419be2 = array(level.var_1f372b50.var_5b419be2);
      }

      level.var_1f372b50.var_5b419be2[level.var_1f372b50.var_5b419be2.size] = e_spawned;

      if(!isDefined(var_94918af1)) {
        var_94918af1 = [];
      } else if(!isarray(var_94918af1)) {
        var_94918af1 = array(var_94918af1);
      }

      var_94918af1[var_94918af1.size] = e_spawned;
    }
  }

  level flag::wait_till("flag_pch_runners_02_fov_cleanup");
  function_3e652c23(var_94918af1, "sp_pch_runners_02_pos", "flag_pch_combat_02");
}

function function_6c8d98bf() {
  level.var_1f372b50 endon(#"skipped_01");
  level flag::wait_till("flag_pch_combat_01");
  var_abc28788 = function_4a645aa9("sp_pch_building_defenders_01", "s_pch_building_defenders_01_01");
  level flag::wait_till("flag_pch_building_defenders_01");
  var_9817e033 = function_4a645aa9("sp_pch_building_defenders_01", "s_pch_building_defenders_01_02");
  level flag::wait_till("flag_pch_building_defenders_01_fov_cleanup");
  a_ai_spawned = arraycombine(var_abc28788, var_9817e033, 0, 0);
  function_3e652c23(a_ai_spawned, "pch_building_defenders_01_pos", "flag_pch_building_defenders_01_cleanup");
}

function function_49fec2ec() {
  level.var_1f372b50 endon(#"skipped_01");
  a_ai_spawned = function_4a645aa9("sp_pch_boat_01");
  level flag::wait_till("flag_sp_pch_boat_01_fov_cleanup");
  function_3e652c23(a_ai_spawned, "sp_pch_boat_01_pos", "flag_pch_skipto_01_cleanup");
}

function function_e817bc24() {
  level.var_1f372b50 endon(#"skipped_01");
  level flag::wait_till("flag_pch_combat_01");

  for(i = 0; i < 3; i++) {
    level thread function_22772241(i);
  }
}

function function_22772241(n_index) {
  level.var_1f372b50 endon(#"skipped_01");
  var_ff72be84 = spawner::simple_spawn_single("sp_vh_pch_convoy_02", &function_869b1ad9, n_index);
  level flag::wait_till("flag_pch_skipto_01_cleanup");

  if(isvehicle(var_ff72be84)) {
    var_a974a435 = var_ff72be84 vehicle::function_86c7bebb();
    function_fb080e60(var_a974a435);
  }

  function_fb080e60(var_ff72be84);
}

function function_869b1ad9(n_index) {
  self endon(#"death");
  self setforcenocull();
  self function_fd9a75d2(undefined, 0);
  var_8be533d2 = "nd_pch_convoy_02_0" + n_index + 1;
  nd_path = getvehiclenode(var_8be533d2, "targetname");
  self thread vehicle::get_on_and_go_path(nd_path);
  self setspeedimmediate(0);
  level flag::wait_till("flag_pch_convoy_02");
  self resumespeed();
}

function function_78af49ee() {
  level.var_1f372b50 endon(#"skipped_01");
  level flag::wait_till("flag_pch_islanders_01_01");
  var_abc28788 = function_4a645aa9("sp_pch_islanders_01", "s_pch_islanders_01_01");
  level flag::wait_till("flag_pch_islanders_01_02");
  var_9817e033 = function_4a645aa9("sp_pch_islanders_01", "s_pch_islanders_01_02");
  level flag::wait_till("flag_pch_islanders_01_cleanup");
  a_ai_spawned = arraycombine(var_abc28788, var_9817e033, 0, 0);

  foreach(ai_spawned in a_ai_spawned) {
    if(isalive(ai_spawned)) {
      ai_spawned kill();
    }
  }
}

function function_5e6c3800() {
  level.var_1f372b50 endon(#"skipped_01");
  level flag::wait_till("flag_pch_runners_03");
  a_ai_spawned = function_4a645aa9("sp_pch_runners_03");

  foreach(ai_spawned in a_ai_spawned) {
    ai_spawned function_d7886de2();
  }

  level flag::wait_till("flag_pch_runners_03_cleanup");

  foreach(ai_spawned in a_ai_spawned) {
    if(isalive(ai_spawned)) {
      ai_spawned kill();
    }
  }
}

function function_c32e0e2c() {
  level.var_1f372b50 endon(#"skipped_01");
  level flag::wait_till("flag_pch_runners_03_drones_spawn");
  var_9e1bacc9 = function_4a645aa9("sp_pch_runners_03_drones", "s_pch_runners_03_drones_01");
  var_a965c35d = function_4a645aa9("sp_pch_runners_03_drones", "s_pch_runners_03_drones_02");
  var_bba267d6 = function_4a645aa9("sp_pch_runners_03_drones", "s_pch_runners_03_drones_03");
  var_1f6e8256 = struct::get("s_pch_runners_03_drones_sort");
  var_9e1bacc9 = arraysort(var_9e1bacc9, var_1f6e8256.origin, 0);
  var_a965c35d = arraysort(var_a965c35d, var_1f6e8256.origin, 0);
  var_bba267d6 = arraysort(var_bba267d6, var_1f6e8256.origin, 0);
  var_11178ba5 = arraycombine(var_9e1bacc9, var_a965c35d);
  var_11178ba5 = arraycombine(var_11178ba5, var_bba267d6);

  foreach(drone in var_11178ba5) {
    drone function_d7886de2();
  }

  level flag::wait_till("flag_pch_runners_03_drones_move");
  level thread function_af0048eb(var_9e1bacc9);
  level thread function_af0048eb(var_a965c35d);
  level thread function_af0048eb(var_bba267d6);
  level flag::wait_till("flag_pch_skipto_01_cleanup");
  function_fb080e60(var_11178ba5);
}

function function_af0048eb(var_89472944) {
  level.var_1f372b50 endon(#"skipped_01", #"skipped_02");

  foreach(drone in var_89472944) {
    if(isDefined(drone)) {
      drone notify(#"move");
      waitframe(randomintrangeinclusive(1, 3));
    }
  }
}

function function_56b0e932() {
  level.var_1f372b50 endon(#"skipped_01");
  level flag::wait_till("flag_pch_combat_02");
  var_27240fa9 = spawner::simple_spawn("sp_vh_pch_bridge_sentry_01", &function_fd9a75d2);
  var_abc28788 = function_4a645aa9("sp_pch_bridge_sentry_01_01");
  level flag::wait_till("flag_pch_bridge_sentry_01");
  var_9817e033 = spawner::simple_spawn("sp_pch_bridge_sentry_01_02", &function_fd9a75d2);

  if(!isDefined(level.var_8c63abe1)) {
    level.var_8c63abe1 = [];
  } else if(!isarray(level.var_8c63abe1)) {
    level.var_8c63abe1 = array(level.var_8c63abe1);
  }

  foreach(var_2e8e92e in var_27240fa9) {
    if(!isDefined(level.var_8c63abe1)) {
      level.var_8c63abe1 = [];
    } else if(!isarray(level.var_8c63abe1)) {
      level.var_8c63abe1 = array(level.var_8c63abe1);
    }

    level.var_8c63abe1[level.var_8c63abe1.size] = var_2e8e92e;
  }

  foreach(ai_spawned in var_abc28788) {
    if(!isDefined(level.var_8c63abe1)) {
      level.var_8c63abe1 = [];
    } else if(!isarray(level.var_8c63abe1)) {
      level.var_8c63abe1 = array(level.var_8c63abe1);
    }

    level.var_8c63abe1[level.var_8c63abe1.size] = ai_spawned;
  }

  foreach(ai_spawned in var_9817e033) {
    if(!isDefined(level.var_8c63abe1)) {
      level.var_8c63abe1 = [];
    } else if(!isarray(level.var_8c63abe1)) {
      level.var_8c63abe1 = array(level.var_8c63abe1);
    }

    level.var_8c63abe1[level.var_8c63abe1.size] = ai_spawned;
  }

  level flag::wait_till("flag_pch_bridge_sentry_01_fov_cleanup");
  a_ai_spawned = arraycombine(var_abc28788, var_9817e033, 0, 0);
  function_3e652c23(a_ai_spawned, "sp_pch_bridge_sentry_01_pos", "flag_pch_bridge_sentry_01_cleanup");
  level flag::wait_till("flag_pch_bridge_sentry_01_cleanup");
  function_fb080e60(var_27240fa9);
}

function function_85d01673() {
  if(!isDefined(level.var_1f372b50.var_e66c9b5a)) {
    level.var_1f372b50.var_e66c9b5a = [];
  } else if(!isarray(level.var_1f372b50.var_e66c9b5a)) {
    level.var_1f372b50.var_e66c9b5a = array(level.var_1f372b50.var_e66c9b5a);
  }

  level.var_1f372b50.var_e66c9b5a[level.var_1f372b50.var_e66c9b5a.size] = self;
}

function function_d7886de2() {
  if(!isDefined(level.var_1f372b50.var_c4a2f2c0)) {
    level.var_1f372b50.var_c4a2f2c0 = [];
  } else if(!isarray(level.var_1f372b50.var_c4a2f2c0)) {
    level.var_1f372b50.var_c4a2f2c0 = array(level.var_1f372b50.var_c4a2f2c0);
  }

  level.var_1f372b50.var_c4a2f2c0[level.var_1f372b50.var_c4a2f2c0.size] = self;
}

function function_d499f214() {
  var_1f372b50 = level.var_1f372b50;
  var_1f372b50 endon(#"skipped_01");
  s_waitresult = level flag::wait_till_any(["flag_pch_island_fork_left_cleanup", "flag_pch_island_fork_right_cleanup"]);

  if(s_waitresult._notify == "flag_pch_island_fork_left_cleanup") {
    var_1f372b50 notify(#"hash_185cafe726f8c276");
    var_b6fdd6f2 = isDefined(var_1f372b50.var_e66c9b5a) ? var_1f372b50.var_e66c9b5a : [];
  } else {
    var_1f372b50 notify(#"hash_704cc0aff7e3f92d");
    var_b6fdd6f2 = isDefined(var_1f372b50.var_c4a2f2c0) ? var_1f372b50.var_c4a2f2c0 : [];
  }

  function_fb080e60(var_b6fdd6f2);
}

function function_825827fb() {
  bridge = struct::get("destructible_bridge_with_ai", "script_noteworthy");
  bridge waittill(#"hash_5bb6862842cacfe8");

  if(isDefined(level.var_8c63abe1)) {
    foreach(ent in level.var_8c63abe1) {
      if(isalive(ent)) {
        ent kill();

        if(isactor(ent)) {
          ent startragdoll(1);
          ent launchragdoll((randomintrange(-15, 15), randomintrange(-15, 15), randomintrange(65, 95)));
        }
      }
    }
  }

  dest_clip = getent("destructible_bridge_clip_01", "targetname");

  if(isDefined(dest_clip)) {
    dest_clip delete();
  }
}

function function_e4534482() {
  bridge = struct::get("pch_dest_kill_sp_pch_runners_02_bridge", "script_noteworthy");
  bridge waittill(#"hash_5bb6862842cacfe8");
  var_1c5e85f = getEntArray("destructible_bridge_clip_1st_encounter", "targetname");

  foreach(script_brushmodel in var_1c5e85f) {
    script_brushmodel delete();
  }
}

function function_a1a63718(a_ents) {
  bridge = a_ents[# "prop 1"];

  if(isDefined(bridge)) {
    bridge notsolid();
  }

  level notify(#"hash_467e710db8ce1306");
}

function function_d9cfd0c9() {
  level thread function_668b4885();
}

function function_eadcc337(a_ents) {
  level notify(#"hash_467e710db8ce1306");

  foreach(ent in a_ents) {
    if(isDefined(ent)) {
      ent flag::set(#"hash_667f31bea2f2a495");
    }
  }
}

function function_9560eef9() {
  level.player endon(#"death");
  level.var_1f372b50 endon(#"skipped_01");
  level flag::wait_till("flag_sp_pch_runners_02_close");

  while(namespace_b7cfe907::function_3f693cc5()) {
    wait 1;
  }

  namespace_b7cfe907::function_51923449();
  level.player dialogue::function_47b06180();
  level.player dialogue::queue("vox_cp_armd_00007_sims_tearemupbell_69");
  wait 0.5;
  level.player dialogue::queue("vox_cp_armd_00007_sims_targetthehuts_cd");
  namespace_b7cfe907::function_f1a80dd();
}

function function_146e6ce6() {
  level.player endon(#"death");
  level.var_1f372b50 endon(#"skipped_02");
  level flag::wait_till(#"hash_46e14e6683647861");

  if(!namespace_b7cfe907::function_3f693cc5()) {
    level.player dialogue::queue("vox_cp_armd_00007_adlr_morerpgs_10");
  }

  level flag::wait_till(#"hash_7b75da88d0666ee");
  level thread function_dd31f611();
  level flag::wait_till(#"flag_pch_convoy_05_spawn");
  level thread function_5551882d();
  level flag::wait_till(#"flag_pch_convoy_05_move");
  level thread function_2b278b37();
  level flag::wait_till(#"hash_7c2981a6619ba42e");

  if(!level flag::get(#"hash_32e884a9a0098217")) {
    namespace_b7cfe907::function_51923449();
    level.player dialogue::queue("vox_cp_armd_00007_adlr_keepmovingthata_53");
    namespace_b7cfe907::function_f1a80dd();
  }
}

function function_dd31f611() {
  level.player endon(#"death");
  level.var_1f372b50 endon(#"skipped_02");
  level endon(#"flag_pch_complete");
  level flag::wait_till_clear_all([# "hash_36b991dd466b2597", #"hash_778593645b5ad026"]);

  if(level flag::get(#"flag_pch_convoy_05_spawn")) {
    return;
  }

  var_fb3de706 = getent("vol_pch_caves_vo", "targetname");

  if(level.var_53bb8ef2.var_78bd98cb istouching(var_fb3de706)) {
    namespace_b7cfe907::function_51923449();
    level.player dialogue::queue("vox_cp_armd_00007_sims_watchthecavesba_cf");
    wait 1;

    if(!level flag::get(#"hash_36b991dd466b2597") && !level flag::get(#"hash_778593645b5ad026") && !level flag::get(#"flag_pch_convoy_05_spawn")) {
      level.player dialogue::queue("vox_cp_armd_00007_adlr_openfire_79");
    }

    namespace_b7cfe907::function_f1a80dd();
  }
}

function function_5551882d() {
  level.player endon(#"death");
  level.var_1f372b50 endon(#"skipped_02");
  level endon(#"flag_pch_complete");

  if(level flag::get(#"hash_36b991dd466b2597") || level flag::get(#"hash_778593645b5ad026")) {
    wait 1;

    if(level flag::get(#"hash_36b991dd466b2597") || level flag::get(#"hash_778593645b5ad026")) {
      return;
    }
  }

  namespace_b7cfe907::function_51923449();
  level.player dialogue::queue("vox_cp_armd_00007_adlr_multiplegroundt_36");
  wait 0.5;

  if(!level flag::get(#"hash_36b991dd466b2597") && !level flag::get(#"hash_778593645b5ad026") && !level flag::get(#"flag_pch_convoy_05_move")) {
    level.player dialogue::queue("vox_cp_armd_00007_sims_pickemoffbell_c7");
  }

  namespace_b7cfe907::function_f1a80dd();
}

function function_2b278b37() {
  level.player endon(#"death");
  var_1f372b50 = level.var_1f372b50;
  var_1f372b50 endon(#"skipped_02");
  level endon(#"flag_pch_complete");

  if(level flag::get(#"hash_36b991dd466b2597") || level flag::get(#"hash_778593645b5ad026")) {
    level flag::wait_till_clear_all([# "hash_36b991dd466b2597", #"hash_778593645b5ad026"]);
    var_549c5e7b = arraycopy(var_1f372b50.var_60454b04);
    function_1eaaceab(var_549c5e7b);

    while(!level flag::get(#"hash_32e884a9a0098217") && var_549c5e7b.size > 0) {
      var_5168e40f = 0;

      foreach(var_cd75ffd6 in var_549c5e7b) {
        if(level.player util::is_player_looking_at(var_cd75ffd6 getcentroid(), undefined, 1, var_cd75ffd6, level.var_53bb8ef2.var_78bd98cb)) {
          var_5168e40f = 1;
          break;
        }
      }

      if(var_5168e40f) {
        break;
      }

      waitframe(1);
      function_1eaaceab(var_1f372b50.var_60454b04);
    }
  }

  if(level flag::get(#"hash_32e884a9a0098217")) {
    return;
  }

  namespace_b7cfe907::function_51923449();
  level.player dialogue::queue("vox_cp_armd_00007_sims_vcconvoyonthero_89");
  wait 0.5;

  if(!level flag::get(#"hash_36b991dd466b2597") && !level flag::get(#"hash_778593645b5ad026") && !level flag::get(#"hash_32e884a9a0098217")) {
    level.player dialogue::queue("vox_cp_armd_00007_adlr_takeoutthosesup_1d");
  }

  namespace_b7cfe907::function_f1a80dd();
}

function function_668b4885() {
  level.player endon(#"death");

  for(var_84d11ff9 = 0; true; var_84d11ff9++) {
    level waittill(#"hash_467e710db8ce1306");

    if((randomint(3) > 1 || var_84d11ff9 > 2) && !level flag::get(#"hash_4352417f279f6096")) {
      level flag::set(#"hash_4352417f279f6096");
      wait randomfloatrange(0.3, 0.5);

      if(!namespace_b7cfe907::function_3f693cc5()) {
        vo_array = ["vox_cp_armd_00007_sims_fuckyeah_aa", "vox_cp_armd_00007_sims_goodshootingbel_0d", "vox_cp_armd_00007_sims_thatsit_1d", "vox_cp_armd_00007_sims_nailedemgood_23", "vox_cp_armd_00007_sims_hellyeah_a6", "vox_cp_armd_00007_sims_yeah_ea"];
        level.player dialogue::queue(array::random(vo_array));
        var_84d11ff9 = 0;
        wait 2;
      }

      level flag::clear(#"hash_4352417f279f6096");
      continue;
    }
  }
}

function function_17203f6f() {
  if(!level flag::get(#"hash_4352417f279f6096")) {
    if(isDefined(level.var_53bb8ef2.var_9df3157)) {
      level flag::set(#"hash_4352417f279f6096");
      wait randomfloatrange(0.5, 1);

      if(!namespace_b7cfe907::function_3f693cc5()) {
        if(level.var_53bb8ef2.var_9df3157 < 3) {
          if(randomint(3) > 1) {
            level.player dialogue::queue(array::random(array("vox_cp_armd_00007_adlr_damnitweretakin_8a", "vox_cp_armd_00007_adlr_canttakenmanymo_eb")));
            wait 2;
          }
        } else {
          level.player dialogue::queue(array::random(array("vox_cp_armd_00007_adlr_wecanttakemuchm_03", "vox_cp_armd_00007_adlr_wegethitagainwe_f6")));
          wait 2;
        }
      }

      level flag::clear(#"hash_4352417f279f6096");
    }
  }
}

function function_d6bbe091(var_d3440450, var_50cc0d4f, var_aa1a6455, e_player) {
  if(isDefined(getent("trigger_bell_tower_damage", "targetname"))) {
    getent("trigger_bell_tower_damage", "targetname") delete();
  }

  if(!e_player) {
    return;
  }

  var_1f372b50 = level.var_1f372b50;

  if(!is_true(var_1f372b50.var_6180054f)) {
    var_1f372b50 notify(#"skipped_01");

    if(isDefined(var_1f372b50.s_waypoint)) {
      objectives::complete("armada_obj_fly_to_firebase", var_1f372b50.s_waypoint);
    }

    level thread function_4f34fd5a("player_controlled_huey_02");

    if(isDefined(var_1f372b50.var_5b419be2)) {
      level thread function_fb080e60(var_1f372b50.var_5b419be2);
    }
  }
}

function function_d3e80e12(var_d3440450) {
  util::delay(2, undefined, &snd::client_msg, #"hash_55704324b6ae9012");
  namespace_72b0499b::music("9.0_flying");
  function_a291d0f(var_d3440450, 1);
  level thread function_4f34fd5a(var_d3440450);
}

function function_f137e067(var_d3440450, var_50cc0d4f) {
  var_1f372b50 = level.var_1f372b50;
  var_1f372b50 endon(#"skipped_02");

  if(!var_50cc0d4f) {
    function_a291d0f(var_d3440450, var_50cc0d4f);
  }

  level thread function_c2fa77ff();
  level thread function_146e6ce6();
  level snd::client_msg(#"hash_4a41082a1d97f925");
  level snd::client_msg(#"hash_551e8554285c2305");
  snd::client_msg(#"hash_2b94ea847ae2b667");

  if(var_50cc0d4f) {
    level thread function_59656f55(1, 1, 1);
  }

  level thread function_1f62aab9();
  level thread function_5bb16651();
  level thread function_8ecb23a6();
  level thread function_831cc5dd();
  level thread function_7114ce1c();
  level thread function_950dfa27();
  level thread function_46e8f51c();
  level thread function_bc837f16();
  var_1f372b50.var_60454b04 = [];
  level thread function_83bef370();
  level thread function_a07b71e6();
  level thread function_98eff2b2();
  level thread exploder::exploder("fxexp_firebase_smoke_columns");
  level thread function_7aad38d0();
  level thread function_1f9ef370();
  level flag::wait_till("flag_pch_complete");
  var_1f372b50.var_9055e2fa = 1;
  skipto::function_4e3ab877(var_d3440450);
}

function function_c2fa77ff() {
  level.var_1f372b50 endon(#"skipped_02");
  setDvar(#"hash_367578d4c1c78030", 840);
  level flag::wait_till(#"flag_pch_dock_defenders_01");
  setDvar(#"hash_367578d4c1c78030", 600);
}

function function_1f62aab9() {
  level.var_1f372b50 endon(#"skipped_02");

  for(i = 0; i < 4; i++) {
    level thread function_f8b8cec5(i);
  }
}

function function_f8b8cec5(n_index) {
  level.var_1f372b50 endon(#"skipped_02");
  var_ff72be84 = spawner::simple_spawn_single("sp_vh_pch_convoy_03", &function_125c7964, n_index);
  level flag::wait_till("flag_pch_cleanup_post_bridge");

  if(isvehicle(var_ff72be84)) {
    var_a974a435 = var_ff72be84 vehicle::function_86c7bebb();
    function_fb080e60(var_a974a435);
  }

  function_fb080e60(var_ff72be84);
}

function function_125c7964(n_index) {
  self endon(#"death");
  self function_b3dd6259(undefined, 0);
  var_8be533d2 = "nd_pch_convoy_03_0" + n_index + 1;
  nd_path = getvehiclenode(var_8be533d2, "targetname");
  self thread vehicle::get_on_and_go_path(nd_path);
}

function function_1dcb11bb() {
  level.var_1f372b50 endon(#"skipped_02");
  level flag::wait_till("flag_pch_dock_defenders_01");
  a_ai_spawned = [];
  s_spawn = struct::get("s_pch_dock_defenders_01_lmg_01");
  var_76eba732 = spawner::simple_spawn_single("sp_pch_dock_defenders_01_lmg", &function_b3dd6259, s_spawn);

  if(!isDefined(a_ai_spawned)) {
    a_ai_spawned = [];
  } else if(!isarray(a_ai_spawned)) {
    a_ai_spawned = array(a_ai_spawned);
  }

  a_ai_spawned[a_ai_spawned.size] = var_76eba732;
  wait 0.5;
  s_spawn = struct::get("s_pch_dock_defenders_01_rpg_01");
  var_ecd7dd18 = spawner::simple_spawn_single("sp_pch_dock_defenders_01_rpg", &function_b3dd6259, s_spawn);

  if(!isDefined(a_ai_spawned)) {
    a_ai_spawned = [];
  } else if(!isarray(a_ai_spawned)) {
    a_ai_spawned = array(a_ai_spawned);
  }

  a_ai_spawned[a_ai_spawned.size] = var_ecd7dd18;
  wait 0.5;
  s_spawn = struct::get("s_pch_dock_defenders_01_ar_01");
  var_9adfb7ff = spawner::simple_spawn_single("sp_pch_dock_defenders_01_ar", &function_b3dd6259, s_spawn);

  if(!isDefined(a_ai_spawned)) {
    a_ai_spawned = [];
  } else if(!isarray(a_ai_spawned)) {
    a_ai_spawned = array(a_ai_spawned);
  }

  a_ai_spawned[a_ai_spawned.size] = var_9adfb7ff;
  wait 0.5;
  s_spawn = struct::get("s_pch_dock_defenders_01_ar_02");
  var_8b219883 = spawner::simple_spawn_single("sp_pch_dock_defenders_01_ar", &function_b3dd6259, s_spawn);

  if(!isDefined(a_ai_spawned)) {
    a_ai_spawned = [];
  } else if(!isarray(a_ai_spawned)) {
    a_ai_spawned = array(a_ai_spawned);
  }

  a_ai_spawned[a_ai_spawned.size] = var_8b219883;
  level flag::wait_till("s_pch_dock_defenders_01_fov_cleanup");
  function_3e652c23(a_ai_spawned, "s_pch_dock_defenders_01_pos", "flag_pch_cleanup_post_bridge");
}

function function_2b782d15() {
  level.var_1f372b50 endon(#"skipped_02");
  a_ai_spawned = [];
  s_spawn = struct::get("s_pch_dock_defenders_02_ar_01");
  var_9adfb7ff = spawner::simple_spawn_single("sp_pch_dock_defenders_02_ar", &function_b3dd6259, s_spawn);

  if(!isDefined(a_ai_spawned)) {
    a_ai_spawned = [];
  } else if(!isarray(a_ai_spawned)) {
    a_ai_spawned = array(a_ai_spawned);
  }

  a_ai_spawned[a_ai_spawned.size] = var_9adfb7ff;
  s_spawn = struct::get("s_pch_dock_defenders_02_lmg_01");
  var_76eba732 = spawner::simple_spawn_single("sp_pch_dock_defenders_02_lmg", &function_b3dd6259, s_spawn);

  if(!isDefined(a_ai_spawned)) {
    a_ai_spawned = [];
  } else if(!isarray(a_ai_spawned)) {
    a_ai_spawned = array(a_ai_spawned);
  }

  a_ai_spawned[a_ai_spawned.size] = var_76eba732;
  s_spawn = struct::get("s_pch_dock_defenders_02_rpg_01");
  var_ecd7dd18 = spawner::simple_spawn_single("sp_pch_dock_defenders_02_rpg", &function_b3dd6259, s_spawn, undefined, 0);

  if(!isDefined(a_ai_spawned)) {
    a_ai_spawned = [];
  } else if(!isarray(a_ai_spawned)) {
    a_ai_spawned = array(a_ai_spawned);
  }

  a_ai_spawned[a_ai_spawned.size] = var_ecd7dd18;
  var_ecd7dd18 thread function_dbefbd4f();
  level flag::wait_till("flag_pch_cleanup_post_bridge");
  function_fb080e60(a_ai_spawned);
}

function function_dbefbd4f() {
  self endon(#"death");
  self val::set("pch_ignoreall", "ignoreall", 1);
  self setgoal(self.origin, 1);
  level flag::wait_till("flag_pch_dock_defenders_02");
  nd_goal = getnode("nd_pch_dock_defenders_02_rpg_01", "targetname");
  self setgoal(nd_goal, 1);
  self waittill(#"goal");
  self val::reset("pch_ignoreall", "ignoreall");
  self function_c9e47ce7();
}

function function_5bb16651() {
  level.var_1f372b50 endon(#"skipped_02");
  a_ai_spawned = function_ca66dab0("sp_pch_boat_02");
  level flag::wait_till("flag_pch_cleanup_post_bridge");
  function_fb080e60(a_ai_spawned);
}

function function_8ecb23a6() {
  level.var_1f372b50 endon(#"skipped_02");
  var_27240fa9 = spawner::simple_spawn("sp_vh_pch_village_defenders_01", &function_b3dd6259);
  a_ai_spawned = function_ca66dab0("sp_pch_village_defenders_01");
  level flag::wait_till("flag_sp_pch_village_defenders_01_fov_cleanup");
  function_3e652c23(a_ai_spawned, "sp_pch_village_defenders_01_pos", "flag_pch_cleanup_post_bridge");
  level flag::wait_till("flag_pch_cleanup_post_bridge");
  function_fb080e60(var_27240fa9);
}

function function_831cc5dd() {
  level.var_1f372b50 endon(#"skipped_02");
  a_ai_spawned = function_ca66dab0("sp_pch_building_defenders_02");
  level flag::wait_till("flag_sp_pch_building_defenders_02_fov_cleanup");
  function_3e652c23(a_ai_spawned, "sp_pch_building_defenders_02_pos", "flag_pch_cleanup_post_bridge");
}

function function_f65c67e2() {
  level.var_1f372b50 endon(#"skipped_02");

  for(i = 0; i < 2; i++) {
    level thread function_c890913(i);
  }

  a_ai_spawned = function_ca66dab0("sp_pch_runners_04");

  foreach(i, ai_spawned in a_ai_spawned) {
    ai_spawned thread function_b014a9f7(i);
  }

  level flag::wait_till("flag_pch_runners_04_look_at");
  var_71d2a694 = struct::get("s_pch_runners_04_look_at");

  while(true) {
    if(level.player util::is_player_looking_at(var_71d2a694.origin, undefined, 1, level.var_53bb8ef2.var_78bd98cb) || level flag::get("flag_pch_runners_04_move")) {
      break;
    }

    waitframe(1);
  }

  level flag::set("flag_pch_runners_04_move");
  level flag::wait_till("flag_pch_runners_04_cleanup");
  function_fb080e60(a_ai_spawned);
}

function function_c890913(n_index) {
  level.var_1f372b50 endon(#"skipped_02");
  var_ff72be84 = spawner::simple_spawn_single("sp_vh_pch_runners_04", &function_6f5d3d68, n_index);
  level flag::wait_till("flag_pch_runners_04_cleanup");

  if(isvehicle(var_ff72be84)) {
    var_a974a435 = var_ff72be84 vehicle::function_86c7bebb();
    function_fb080e60(var_a974a435);
  }

  function_fb080e60(var_ff72be84);
}

function function_6f5d3d68(n_index) {
  self endon(#"death");
  self function_b3dd6259(undefined, 0);
  var_8be533d2 = "nd_pch_runners_04_trucks_0" + n_index + 1;
  nd_path = getvehiclenode(var_8be533d2, "targetname");
  self thread vehicle::get_on_and_go_path(nd_path);
  self vehicle::pause_path();
  level flag::wait_till("flag_pch_runners_04_move");
  self vehicle::resume_path();
}

function function_b014a9f7(n_index) {
  self endon(#"death");
  var_e6fe2893 = getnodearray("nd_pch_runners_04_mid", "targetname");
  var_ee1446ea = 0;
  var_f341ce5b = -1;

  while(true) {
    var_7ca4c705 = var_f341ce5b - 0.01;
    var_6a0f072d = var_f341ce5b + 0.01;

    foreach(var_c54ff397 in var_e6fe2893) {
      n_dot = self math::get_dot_forward(var_c54ff397.origin);

      if(n_dot >= max(-1, var_7ca4c705) && n_dot <= min(0, var_6a0f072d)) {
        var_ee1446ea = 1;
        break;
      }
    }

    if(var_ee1446ea) {
      break;
    }

    var_f341ce5b += 0.01;

    if(var_f341ce5b >= 0) {
      var_c54ff397 = array::random(var_e6fe2893);
      break;
    }

    waitframe(1);
  }

  var_903daa83 = getnodearray("nd_pch_runners_04_end", "targetname");
  var_903daa83 = array::sort_by_script_int(var_903daa83, 1);
  nd_end = var_903daa83[n_index + 1];
  level flag::wait_till("flag_pch_runners_04_move");
  self setgoal(var_c54ff397, 1);

  while(distance2dsquared(self.origin, var_c54ff397.origin) >= sqr(256)) {
    waitframe(1);
  }

  self setgoal(nd_end, 1);
}

function function_7114ce1c() {
  level.var_1f372b50 endon(#"skipped_02");
  level flag::wait_till("flag_pch_convoy_04_spawn");

  for(i = 0; i < 5; i++) {
    level thread function_6fb6b4a(i);
  }
}

function function_6fb6b4a(n_index) {
  level.var_1f372b50 endon(#"skipped_02");
  var_ff72be84 = spawner::simple_spawn_single("sp_vh_pch_convoy_04", &function_6a418e77, n_index);
  level flag::wait_till("flag_pch_convoy_04_cleanup");
  function_fb080e60(var_ff72be84);
}

function function_6a418e77(n_index) {
  self endon(#"death");
  self function_b3dd6259(undefined, 0);
  var_8be533d2 = "nd_pch_convoy_04_0" + n_index + 1;
  nd_path = getvehiclenode(var_8be533d2, "targetname");
  self thread vehicle::get_on_and_go_path(nd_path);
  self vehicle::pause_path();
  level flag::wait_till("flag_pch_convoy_04_move");
  self vehicle::resume_path();
}

function function_950dfa27() {
  level.var_1f372b50 endon(#"skipped_02");
  level flag::wait_till("flag_pch_rpg_alley_01");
  a_ai_spawned = function_ca66dab0("sp_pch_rpg_alley_01", undefined, 1, 1, &function_9fdccf8c);

  foreach(ai_spawned in a_ai_spawned) {
    ai_spawned callback::function_d8abfc3d(#"on_ai_killed", &function_7cedc5e);
  }

  var_1d108160 = getEntArray("t_pch_rpg_alley_01_damage", "targetname");

  foreach(t_damage in var_1d108160) {
    t_damage thread function_689a7627(a_ai_spawned);
  }

  level flag::wait_till("flag_pch_rpg_valley_01_cleanup");

  foreach(ai_spawned in a_ai_spawned) {
    while(isalive(ai_spawned) && level.player util::is_player_looking_at(ai_spawned.origin, undefined, 1, ai_spawned, level.var_53bb8ef2.var_78bd98cb)) {
      waitframe(1);
    }

    function_fb080e60(ai_spawned);
  }

  function_fb080e60(var_1d108160);
}

function function_9fdccf8c() {
  self.maxsightdistsqrd = sqr(20000);
  self.newenemyreactiondistsq = sqr(20000);
}

function function_7cedc5e(s_params) {
  self magicmissile(getweapon(#"launcher_standard_t9"), self.origin + (0, 0, 32), anglestoup(self.angles) * -2000);
}

function function_689a7627(a_ai_spawned) {
  self endon(#"death");

  while(true) {
    s_waitresult = self waittill(#"damage");

    if(isPlayer(s_waitresult.attacker)) {
      break;
    }
  }

  foreach(ai_spawned in a_ai_spawned) {
    if(isalive(ai_spawned) && ai_spawned istouching(self)) {
      ai_spawned kill(s_waitresult.position, s_waitresult.attacker, s_waitresult.inflictor, s_waitresult.weapon);
    }
  }
}

function function_46e8f51c() {
  level.player endon(#"death");
  var_58460138 = struct::get_array("p9_fxanim_cp_armada_rocket_cave", "targetname");

  foreach(var_22160a4c in var_58460138) {
    var_22160a4c scene::init();
  }

  level flag::wait_till_any(["flag_pch_left_pass_cleanup", "flag_pch_right_pass_cleanup"]);

  foreach(var_22160a4c in var_58460138) {
    var_22160a4c scene::stop(1);
  }
}

function function_bc837f16() {
  level.var_1f372b50 endon(#"skipped_02");
  level flag::wait_till("flag_pch_village_defenders_02_01");
  var_abc28788 = function_ca66dab0("sp_pch_village_defenders_02", "s_pch_village_defenders_02_01");
  level flag::wait_till("flag_pch_village_defenders_02_02");
  var_9817e033 = function_ca66dab0("sp_pch_village_defenders_02", "s_pch_village_defenders_02_02");
  level flag::wait_till("flag_pch_village_defenders_02_fov_cleanup");
  a_ai_spawned = arraycombine(var_abc28788, var_9817e033, 0, 0);
  function_3e652c23(a_ai_spawned, "pch_village_defenders_02_pos", "flag_pch_village_defenders_02_cleanup");
}

function function_83bef370() {
  level.var_1f372b50 endon(#"skipped_02");
  level flag::wait_till("flag_pch_convoy_05_spawn");

  for(i = 0; i < 5; i++) {
    level thread function_ed3237b8(i);
  }

  level flag::wait_till("flag_pch_convoy_05_look_at");
  var_71d2a694 = struct::get("s_pch_convoy_05_look_at");

  while(true) {
    if(level.player util::is_player_looking_at(var_71d2a694.origin, undefined, 1, level.var_53bb8ef2.var_78bd98cb) || level flag::get("flag_pch_convoy_05_move")) {
      break;
    }

    waitframe(1);
  }

  level flag::set("flag_pch_convoy_05_move");
}

function function_ed3237b8(n_index) {
  level.var_1f372b50 endon(#"skipped_02");
  var_ff72be84 = spawner::simple_spawn_single("sp_vh_pch_convoy_05", &function_4babc824, n_index);
}

function function_4babc824(n_index) {
  self endon(#"death");

  if(!isDefined(level.var_1f372b50.var_60454b04)) {
    level.var_1f372b50.var_60454b04 = [];
  } else if(!isarray(level.var_1f372b50.var_60454b04)) {
    level.var_1f372b50.var_60454b04 = array(level.var_1f372b50.var_60454b04);
  }

  level.var_1f372b50.var_60454b04[level.var_1f372b50.var_60454b04.size] = self;
  self function_b3dd6259(undefined, 0);
  var_8be533d2 = "nd_pch_convoy_05_0" + n_index + 1;
  nd_path = getvehiclenode(var_8be533d2, "targetname");
  self thread vehicle::get_on_and_go_path(nd_path);
  self vehicle::pause_path();
  level flag::wait_till("flag_pch_convoy_05_move");
  self vehicle::resume_path();
}

function function_eb45b20c() {
  if(!isDefined(level.var_1f372b50.var_e1f9d938)) {
    level.var_1f372b50.var_e1f9d938 = [];
  } else if(!isarray(level.var_1f372b50.var_e1f9d938)) {
    level.var_1f372b50.var_e1f9d938 = array(level.var_1f372b50.var_e1f9d938);
  }

  level.var_1f372b50.var_e1f9d938[level.var_1f372b50.var_e1f9d938.size] = self;
}

function function_56a193e6() {
  if(!isDefined(level.var_1f372b50.var_a17927ca)) {
    level.var_1f372b50.var_a17927ca = [];
  } else if(!isarray(level.var_1f372b50.var_a17927ca)) {
    level.var_1f372b50.var_a17927ca = array(level.var_1f372b50.var_a17927ca);
  }

  level.var_1f372b50.var_a17927ca[level.var_1f372b50.var_a17927ca.size] = self;
}

function function_98eff2b2() {
  var_1f372b50 = level.var_1f372b50;
  var_1f372b50 endon(#"skipped_02");
  s_waitresult = level flag::wait_till_any(["flag_pch_left_pass_cleanup", "flag_pch_right_pass_cleanup"]);

  if(s_waitresult._notify == "flag_pch_left_pass_cleanup") {
    var_1f372b50 notify(#"left_pass_cleanup");
    var_b6fdd6f2 = isDefined(var_1f372b50.var_e1f9d938) ? var_1f372b50.var_e1f9d938 : [];
  } else {
    var_1f372b50 notify(#"right_pass_cleanup");
    var_b6fdd6f2 = isDefined(var_1f372b50.var_a17927ca) ? var_1f372b50.var_a17927ca : [];
  }

  function_fb080e60(var_b6fdd6f2);
}

function function_a07b71e6() {
  level.var_1f372b50 endon(#"skipped_02", #"left_pass_cleanup");
  level flag::wait_till("flag_pch_bend_sentry_01");
  var_ff72be84 = spawner::simple_spawn_single("sp_vh_bend_sentry_01", &function_b3dd6259);

  if(isDefined(var_ff72be84)) {
    var_ff72be84 function_eb45b20c();
  }

  a_ai_spawned = function_ca66dab0("sp_pch_bend_sentry_01");

  foreach(ai_spawned in a_ai_spawned) {
    ai_spawned function_eb45b20c();
  }

  level flag::wait_till("flag_pch_bend_sentry_01_cleanup");
  function_fb080e60(var_ff72be84);
  function_fb080e60(a_ai_spawned);
}

function function_e81b4b60() {
  level.var_1f372b50 endon(#"skipped_02");
  s_waitresult = level flag::wait_till_any(["flag_pch_runners_05_spawn", "flag_pch_runners_05_force"]);
  a_ai_spawned = function_ca66dab0("sp_pch_runners_05", undefined, 1, 0);

  foreach(i, ai_spawned in a_ai_spawned) {
    ai_spawned thread function_add898c5(i);
  }

  if(s_waitresult._notify == "flag_pch_runners_05_spawn") {
    level flag::wait_till("flag_pch_runners_05_look_at");
    var_71d2a694 = struct::get("s_pch_runners_05_look_at");

    while(true) {
      if(level.player util::is_player_looking_at(var_71d2a694.origin, undefined, 1, level.var_53bb8ef2.var_78bd98cb) || level flag::get("flag_pch_runners_05_move")) {
        break;
      }

      waitframe(1);
    }
  }

  level flag::set("flag_pch_runners_05_move");
}

function function_add898c5(n_index) {
  self endon(#"death");
  self val::set("pch_ignoreall", "ignoreall", 1);
  var_59f6ca7 = undefined;
  var_dcc29aee = undefined;

  for(i = 0; i < 2; i++) {
    switch (i) {
      case 0:
        var_98a868e9 = self;
        var_b9149645 = "nd_pch_runners_05_mid_01";
        break;
      case 1:
        var_98a868e9 = var_59f6ca7;
        var_b9149645 = "nd_pch_runners_05_mid_02";
        break;
    }

    var_e6fe2893 = getnodearray(var_b9149645, "targetname");
    var_ee1446ea = 0;
    var_f341ce5b = -1;

    while(true) {
      var_7ca4c705 = var_f341ce5b - 0.01;
      var_6a0f072d = var_f341ce5b + 0.01;

      foreach(var_c54ff397 in var_e6fe2893) {
        n_dot = var_98a868e9 math::get_dot_forward(var_c54ff397.origin);

        if(n_dot >= max(-1, var_7ca4c705) && n_dot <= min(0, var_6a0f072d)) {
          var_ee1446ea = 1;
          break;
        }
      }

      if(var_ee1446ea) {
        break;
      }

      var_f341ce5b += 0.01;

      if(var_f341ce5b >= 0) {
        var_c54ff397 = array::random(var_e6fe2893);
        break;
      }

      waitframe(1);
    }

    switch (i) {
      case 0:
        var_59f6ca7 = var_c54ff397;
        break;
      case 1:
        var_dcc29aee = var_c54ff397;
        break;
    }
  }

  var_903daa83 = getnodearray("nd_pch_runners_05_end", "targetname");
  var_903daa83 = array::sort_by_script_int(var_903daa83, 1);
  nd_end = var_903daa83[n_index + 1];
  level flag::wait_till("flag_pch_runners_05_move");

  for(i = 0; i < 2; i++) {
    switch (i) {
      case 0:
        nd_goal = var_59f6ca7;
        break;
      case 1:
        self val::reset("pch_ignoreall", "ignoreall");
        nd_goal = var_dcc29aee;
        break;
    }

    self setgoal(nd_goal, 1);

    while(distance2dsquared(self.origin, nd_goal.origin) >= sqr(256)) {
      waitframe(1);
    }
  }

  self setgoal(nd_end, 1);
}

function function_1f9ef370() {
  level flag::set("hide_pch_obj");
  assert(isDefined(getent("<dev string:x91>", "<dev string:xa5>")), "<dev string:xb3>");
  level.enemy_heli = vehicle::simple_spawn_single("spawner_rus_heli");
  level namespace_b7cfe907::function_51923449();
  level.enemy_heli thread function_c0841e82();
  level.enemy_heli thread function_f5d90d3c(level.var_53bb8ef2.var_78bd98cb);
  level.enemy_heli thread function_2b68bef2(level.var_53bb8ef2.var_78bd98cb);
  level.enemy_heli thread function_1e2430a5(level.var_53bb8ef2.var_78bd98cb);
  level.enemy_heli thread function_ae21677d();
  level.player dialogue::function_47b06180();
  level util::delay(3, undefined, &flag::set, "fighting_hind");
  level.player dialogue::queue("vox_cp_armd_00007_bcmd_badgernineronew_fd");
  level.player dialogue::queue("vox_cp_armd_00007_sims_sincewhendidthe_54");
  level.player dialogue::queue("vox_cp_armd_00007_adlr_theydontfucking_25");
  level.player thread dialogue::queue("vox_cp_armd_00007_adlr_takedownthathin_f2");
  level.player thread function_9090ff32(level.enemy_heli);
  level.player thread function_f53de8f5(level.enemy_heli);
  level.player thread function_92475bd2();
  level flag::wait_till("hind_destroyed");

  if(!level flag::get("pch_enemy_hind_left_behind")) {
    level thread savegame::checkpoint_save(1);
    level flag::set(#"hash_778593645b5ad026");
    level flag::set(#"hash_36b991dd466b2597");
    level.player dialogue::function_47b06180();
    wait 0.3;
    level.player dialogue::queue("vox_cp_armd_00007_sims_ithinkyougothim_fa");
    wait 0.3;
    level.player dialogue::queue("vox_cp_armd_00007_adlr_yeahyougothimgo_d9");
    wait 0.1;
    level.player dialogue::queue("vox_cp_armd_00007_sims_thatwasfuckings_3d");
    level.player dialogue::queue("vox_cp_armd_00007_adlr_thefacttheysent_db");
    wait 1;
    level flag::clear(#"hash_36b991dd466b2597");
    level flag::set(#"hash_7236e80e219ebe5f");
  }

  level namespace_b7cfe907::function_f1a80dd();
  level flag::clear("pch_enemy_hind_left_behind");
}

function function_ae21677d() {
  self endon(#"death");

  while(!level flag::get("hind_destroyed")) {
    if(isDefined(level.var_53bb8ef2.var_78bd98cb)) {
      if(!isDefined(level.enemy_heli.favoriteenemy) || level.enemy_heli.favoriteenemy != level.var_53bb8ef2.var_78bd98cb) {
        level.enemy_heli.favoriteenemy = level.var_53bb8ef2.var_78bd98cb;
      }
    }

    wait 1;
  }
}

function function_9090ff32(enemy) {
  self endon(#"death");
  enemy endon(#"death");
  vo_array = ["vox_cp_armd_00007_adlr_comeonbellstayo_aa", "vox_cp_armd_00007_adlr_youcandothis_7b", "vox_cp_armd_00007_sims_stayonhimbell_e8", "vox_cp_armd_00007_sims_dontletupnow_8f"];
  var_fd3f3dfe = 0;
  wait 7;

  while(vo_array.size > 0 && isDefined(level.var_53bb8ef2.var_78bd98cb)) {
    if(!flag::get("hind_damage_vo_playing") && !is_true(level.var_53bb8ef2.var_78bd98cb.var_918b6ecc)) {
      var_fd3f3dfe = randomintrangeinclusive(0, vo_array.size - 1);
      level.player dialogue::queue(vo_array[var_fd3f3dfe]);
      vo_array = array::remove_index(vo_array, var_fd3f3dfe);
      wait randomintrangeinclusive(3, 6);
    } else if(flag::get("hind_damage_vo_playing")) {
      wait 5;
    }

    waitframe(1);
  }
}

function function_f53de8f5(enemy) {
  self endon(#"death");
  enemy endon(#"death");
  var_633ec8ba = ["vox_cp_armd_00007_adlr_yeswegotyourrus_e9", "vox_cp_armd_00007_sims_thatsitstayonhi_5a"];
  var_4d0d207b = ["vox_cp_armd_00007_adlr_hithimagain_c4", "vox_cp_armd_00007_sims_yeahtakedowntha_7a"];

  while(var_633ec8ba.size + var_4d0d207b.size > 0 && isDefined(level.var_53bb8ef2.var_78bd98cb)) {
    damage_data = enemy waittill(#"damage");

    if(!is_true(level.var_53bb8ef2.var_78bd98cb.var_918b6ecc)) {
      flag::set("hind_damage_vo_playing");

      if(damage_data.weapon.name == # "hash_1b226dddac770884" && var_4d0d207b.size > 0) {
        var_fd3f3dfe = randomintrangeinclusive(0, var_4d0d207b.size - 1);
        level.player dialogue::queue(var_4d0d207b[var_fd3f3dfe]);
        var_4d0d207b = array::remove_index(var_4d0d207b, var_fd3f3dfe);
        wait 1;
      } else if(damage_data.weapon.name == # "hash_25b7b14b6698454a" && var_633ec8ba.size > 0) {
        var_fd3f3dfe = randomintrangeinclusive(0, var_633ec8ba.size - 1);
        level.player dialogue::queue(var_633ec8ba[var_fd3f3dfe]);
        var_633ec8ba = array::remove_index(var_633ec8ba, var_fd3f3dfe);
        wait randomintrangeinclusive(3, 6);
      }

      flag::clear("hind_damage_vo_playing");
    }

    waitframe(1);
  }
}

function function_92475bd2() {
  self endon(#"death");
  level flag::wait_till_any([# "hash_7236e80e219ebe5f", #"hash_6e1900cbdf755aa"]);

  if(level flag::get(#"hash_7236e80e219ebe5f")) {
    namespace_b7cfe907::function_51923449();

    if(!level flag::get(#"flag_pch_convoy_05_spawn")) {
      level.player dialogue::queue("vox_cp_armd_00007_plt1_ripcordbasetwen_0e", undefined, 1);
      level.player dialogue::queue("vox_cp_armd_00007_adlr_ripcordthisisba_5a");
      level.player dialogue::queue("vox_cp_armd_00007_rpcd_rogerthatninert_40");
      level.player dialogue::queue("vox_cp_armd_00007_rpcd_wellclearanlzas_1e");
      level.player dialogue::queue("vox_cp_armd_00007_adlr_rogerthatripcor_1d");
    } else {
      level.player dialogue::queue("vox_cp_armd_00007_adlr_ripcordthisisba_42", undefined, 1);
      level.player dialogue::queue("vox_cp_armd_00007_rpcd_rogerthatninero_68");
      level.player dialogue::queue("vox_cp_armd_00007_adlr_rogerthatripcor_1d_1");
    }

    namespace_b7cfe907::function_f1a80dd();
  }

  level flag::clear(#"hash_778593645b5ad026");
}

function function_c0841e82() {
  self waittill(#"death");
  level flag::clear("fighting_hind");
  level flag::set("hind_destroyed");
}

function function_f5d90d3c(enemy) {
  self endon(#"death");
  enemy waittill(#"death");
  self vehicle_ai::set_state("scripted");
  level.player dialogue::function_47b06180();
}

function function_2b68bef2(enemy) {
  self endon(#"death");
  enemy endon(#"death");
  enemy.var_918b6ecc = 0;
  level flag::wait_till("flag_pch_convoy_04_move");
  var_e6217f97 = 0;

  while(true) {
    var_2231bfef = vectornormalize(enemy.origin - self.origin);

    if(vectordot(var_2231bfef, vectornormalize(enemy getvelocity())) > 0.3) {
      enemy.var_918b6ecc = 1;
      var_e6217f97++;

      if(var_e6217f97 == 1) {
        level namespace_b7cfe907::function_51923449();
        level.player dialogue::function_47b06180();
        level.player dialogue::queue("vox_cp_armd_00007_adlr_wedontwanttolos_9b");
        level namespace_b7cfe907::function_f1a80dd();
      } else if(var_e6217f97 == 5) {
        level namespace_b7cfe907::function_51923449();
        level.player dialogue::function_47b06180();
        level.player dialogue::queue("vox_cp_armd_00007_sims_wereallygonnahi_6f");
        level namespace_b7cfe907::function_f1a80dd();
      } else if(var_e6217f97 == 10) {
        var_e6217f97 = 0;
      }

      wait 3;
      continue;
    }

    enemy.var_918b6ecc = 0;
    waitframe(1);
  }
}

function function_1e2430a5(enemy) {
  var_275ae8f = 1;
  level endon(#"pch_enemy_hind_left_behind");
  assert(isDefined(level.var_7466d419), "<dev string:xf7>");
  assert(isDefined(level.var_7466d419.turretweapon), "<dev string:x11c>");
  rocket_weapon = level.var_7466d419.turretweapon;

  while(isDefined(self) && self.health > 0 && var_275ae8f) {
    damage_data = self waittill(#"damage");

    if(isPlayer(damage_data.attacker) && damage_data.weapon != rocket_weapon) {
      var_275ae8f = 0;
    }
  }

  if(var_275ae8f) {
    level.player stats::function_dad108fa(#"hash_57693240f81b6777", 1);
  }
}

function function_b839a88b(var_d3440450, var_50cc0d4f, var_aa1a6455, e_player) {
  if(!e_player) {
    return;
  }

  var_1f372b50 = level.var_1f372b50;

  if(!is_true(var_1f372b50.var_9055e2fa)) {
    var_1f372b50 notify(#"skipped_02");

    if(isDefined(var_1f372b50.s_waypoint)) {
      objectives::complete("armada_obj_fly_to_firebase", var_1f372b50.s_waypoint);
    }

    s_teleport = struct::get("heli_spawn_firebase_defend", "script_noteworthy");
    level.var_53bb8ef2.var_78bd98cb.origin = s_teleport.origin;
    level.var_53bb8ef2.var_78bd98cb.angles = s_teleport.angles;

    if(isDefined(var_1f372b50.var_8b8c7c77)) {
      level thread function_fb080e60(var_1f372b50.var_8b8c7c77);
    }
  }

  if(isDefined(var_1f372b50.var_b6fdd6f2)) {
    level thread function_fb080e60(var_1f372b50.var_b6fdd6f2);
  }

  if(isDefined(level.enemy_heli)) {
    level flag::set("pch_enemy_hind_left_behind");
    level flag::set(#"hash_778593645b5ad026");
    level.enemy_heli delete();

    if(!level flag::get(#"hash_32e884a9a0098217")) {
      level namespace_b7cfe907::function_51923449();
      level.player dialogue::function_47b06180();
      level.player dialogue::queue("vox_cp_armd_00007_bcmd_badgernineronee_e1");
      level namespace_b7cfe907::function_f1a80dd();
    }

    level flag::set(#"hash_6e1900cbdf755aa");
  }
}

function function_aa2f407c(var_3ba94e96, str_spawns, var_86a56d5f = 1, var_9f1d53c7 = 1, spawn_func, arg1, arg2, arg3) {
  a_ai_spawned = function_d305a607(var_3ba94e96, str_spawns, var_86a56d5f, var_9f1d53c7, spawn_func, arg1, arg2, arg3);

  foreach(ai_spawned in a_ai_spawned) {
    if(!isDefined(level.var_9051f4a3.var_b6fdd6f2)) {
      level.var_9051f4a3.var_b6fdd6f2 = [];
    } else if(!isarray(level.var_9051f4a3.var_b6fdd6f2)) {
      level.var_9051f4a3.var_b6fdd6f2 = array(level.var_9051f4a3.var_b6fdd6f2);
    }

    level.var_9051f4a3.var_b6fdd6f2[level.var_9051f4a3.var_b6fdd6f2.size] = ai_spawned;

    if(isactor(ai_spawned)) {
      ai_spawned thread function_a3c825cd();
    }
  }

  return a_ai_spawned;
}

function function_46c0f651(var_d3440450) {
  util::delay(2, undefined, &snd::client_msg, #"hash_55704324b6ae9012");
}

function function_dc1d0dfb(var_d3440450, var_50cc0d4f) {
  var_9051f4a3 = level.var_9051f4a3;
  var_9051f4a3 endon(#"skipped");
  namespace_72b0499b::music("10.0_assault", 2);
  level snd::client_msg(#"hash_4a41082a1d97f925");
  level snd::client_msg(#"hash_551e8554285c2305");
  snd::client_msg(#"hash_2b94ea847ae2b667");
  function_a291d0f(var_d3440450, var_50cc0d4f);
  function_d6988dc3();
  setDvar(#"hash_367578d4c1c78030", 840);
  level thread function_f14a15c0(var_50cc0d4f);
  var_9051f4a3.var_c912eb6b = 0;
  var_9051f4a3.var_f446dd0f = 0;
  var_9051f4a3.var_b6fdd6f2 = [];
  var_9051f4a3.var_79de6b64 = [];

  if(var_50cc0d4f) {
    if(getdvarint(#"hash_3b90a67ea0b6081b", 0) >= 2) {
      level.player val::set(#"hash_ca2667067306cf1", "<dev string:x157>", 1);
      level.player val::set(#"hash_ca2667067306cf1", "<dev string:x163>", 0);
      level.player val::set(#"hash_ca2667067306cf1", "<dev string:x171>", 0);
      n_seat = level.var_53bb8ef2.var_78bd98cb getoccupantseat(level.player);

      if(isDefined(n_seat) && n_seat >= 0) {
        level.var_53bb8ef2.var_78bd98cb usevehicle(level.player, n_seat);
      }

      var_f98108c1 = struct::get(#"hash_6839f84b984b36ff");
      level.player setorigin(var_f98108c1.origin);
      level.player setplayerangles(var_f98108c1.angles);
    }

    level thread function_7aad38d0(1);
    level thread exploder::exploder("fxexp_firebase_smoke_columns");
    level thread function_59656f55(0, 0, 1);
  } else {
    level thread function_56a77920();
  }

  level thread function_6f8c4ba2();
  level thread function_225a40cf(var_50cc0d4f);
  level thread function_2a10e512();
  level thread function_755d640();
  level thread function_2f5a4827();
  level thread function_1fcee01d();
  level flag::wait_till(#"hash_494514617379bbdf");
  var_9051f4a3.b_completed = 1;
  skipto::function_4e3ab877(var_d3440450);
}

function function_56a77920() {
  a_s_scenes = arraycombine(struct::get_array(#"hash_5a206ef4d4d410d7"), struct::get_array(#"hash_6e898c25427fa596"));

  foreach(s_scene in a_s_scenes) {
    s_scene scene::stop(1);
    waitframe(1);
  }
}

function function_d6988dc3() {
  t_oob = getent("t_ripcord_oob", "targetname");
  t_oob triggerenable(1);
}

function function_60f16ecb() {
  t_oob = getent("t_ripcord_oob", "targetname");
  t_oob triggerenable(0);
}

function function_158cdaa(s_spawn, var_86a56d5f = 1, var_9f1d53c7 = 1) {
  self function_6cf6a8c2(s_spawn, var_86a56d5f, var_9f1d53c7);

  if(!isDefined(level.var_9051f4a3.var_b6fdd6f2)) {
    level.var_9051f4a3.var_b6fdd6f2 = [];
  } else if(!isarray(level.var_9051f4a3.var_b6fdd6f2)) {
    level.var_9051f4a3.var_b6fdd6f2 = array(level.var_9051f4a3.var_b6fdd6f2);
  }

  level.var_9051f4a3.var_b6fdd6f2[level.var_9051f4a3.var_b6fdd6f2.size] = self;
}

function function_6f8c4ba2() {
  level.var_9051f4a3 endon(#"skipped");
  var_79de6b64 = struct::get_array(#"hash_cf5f0a7b582f11d", "script_noteworthy");

  foreach(s_mortar in var_79de6b64) {
    s_mortar function_cffa5653();
  }

  level thread function_aaa7f178(var_79de6b64);
  var_5073adc1 = function_aa2f407c("sp_ripcord_north_face_convoys", #"hash_2b1a54dbfe4d9598", 1, 0, &function_ede2a394);
  var_96c8ba6a = function_aa2f407c("sp_ripcord_north_face_convoys", #"hash_2b1a55dbfe4d974b", 1, 0, &function_ede2a394, 0);
  var_cbb940ec = arraycombine(var_5073adc1, var_96c8ba6a);
  function_1eaaceab(var_cbb940ec);
  level thread function_c31eac23(var_cbb940ec);
  var_c5b0c2c8 = function_aa2f407c("sp_vh_ripcord_cliff_defenders");
  level thread function_ef4f929e(var_c5b0c2c8);
  var_35775c75 = function_aa2f407c("sp_vh_ripcord_rpg_teams_north");
  level thread function_b72590f1(var_35775c75);
  level thread function_74c4dd1b();
}

function function_225a40cf(var_50cc0d4f) {
  level.player endon(#"death");
  var_9051f4a3 = level.var_9051f4a3;
  var_9051f4a3 endon(#"skipped");
  level flag::set(#"hash_490bc7407722903d");
  level thread function_3eca44a();
  level thread function_330ed1b();
  a_str_flags = [# "hash_16dd0f9eab25b6c5", #"hash_6295d08fb1cbde3c", #"hash_2fcba334efb3236f"];

  for(i = 0; i < 3; i++) {
    s_waitresult = level flag::wait_till_any(a_str_flags);
    arrayremovevalue(a_str_flags, s_waitresult._notify);
    level thread function_330ed1b();
    function_9a2646df();
  }

  level thread function_2095821c();
  level flag::set(#"hash_2c292d90841ea555");
  level flag::set(#"hash_624585ec0b1e15fa");
  level flag::set(#"hash_eeac05ac492404c");
  function_9b9ad0ab("sp_ripcord_support_huey_04", &function_ca16a858);
  level thread savegame::checkpoint_save(1);
  level flag::wait_till(#"hash_55116385b662a489");
  level flag::set(#"hash_77c17e91c8956ded");
  objectives::scripted(#"hash_4456b15b5561ff72", undefined, #"hash_61eb08daf30d45b8");
  objectives::function_6a5ca7ac(#"hash_4456b15b5561ff72", undefined, #"hash_3e1e8f33287f0c8");

  if(!level flag::get(#"hash_6dfec0bfb77bdbe9")) {
    s_obj = struct::get(#"hash_1e9c89c7e88596");
    objectives::function_4eb5c04a(#"hash_2219bd003d6556ce", s_obj.origin);
    level flag::set(#"hash_22413fc0a2a93e24");
    level flag::wait_till(#"hash_6dfec0bfb77bdbe9");
  }

  level flag::set(#"hash_4738db7348240118");
  function_9b9ad0ab("sp_ripcord_support_huey_05", &function_cfa8bf1a);
  level flag::set(#"hash_6262020fe28bc726");
  level flag::set(#"hash_57c6ee97826e6249");
  level thread function_330ed1b();
  level flag::wait_till_any([# "hash_655527a3d778dd1f", #"hash_60fbef66f73d44ea"]);
  level flag::set(#"hash_27538459b6861212");
  level thread function_330ed1b();
  level util::delay(0.5, undefined, &function_9a2646df);
  level flag::set(#"hash_45f5f17f37f2ef89");
  level flag::wait_till_all([# "hash_655527a3d778dd1f", #"hash_60fbef66f73d44ea"]);
  level thread function_330ed1b();
  level util::delay(0.5, undefined, &function_9a2646df);
  level flag::set(#"hash_160f56c6d59d5917");
  level thread function_4afd7dea();
  level thread savegame::checkpoint_save(1);
  objectives::complete(#"hash_4456b15b5561ff72");
  level flag::set(#"hash_250edc5195758370");
  level flag::wait_till(#"hash_9b54061312dc6ab");
  level flag::set(#"hash_67902020b6966b5e");
  level flag::wait_till(#"hash_1ef3a1febf52c90e");

  foreach(str_name, s_breach in var_9051f4a3.var_6ae38a69) {
    level flag::set(s_breach.var_62e5c9d9);

    foreach(var_4e75a347 in function_cf993931(str_name)) {
      var_4e75a347 thread function_24ff6a6e();
    }
  }

  foreach(var_5b5d5258 in var_9051f4a3.var_79de6b64) {
    if(!var_5b5d5258 flag::get(#"destroyed")) {
      var_5b5d5258 function_e00566fd(undefined, 1);
    }
  }

  level flag::wait_till(#"hash_2e43c4e93e07445c");
  objectives::complete(#"hash_3e1e8f33287f0c8");
  level flag::set(#"hash_494514617379bbdf");
}

function function_24ff6a6e() {
  self endon(#"death");
  wait randomfloatrange(0.1, 2);
  self function_a2798ad7();
  self kill();
}

function function_24648886(e_corpse) {
  if(!isDefined(e_corpse)) {
    return false;
  }

  if(!isDefined(level.player)) {
    return true;
  }

  if(distancesquared(level.player.origin, e_corpse.origin) >= sqr(8000)) {
    return false;
  }

  if(level.player function_80d68e4d(e_corpse, 0.7, 1)) {
    return false;
  }

  return true;
}

function function_ec8864c(e_corpse) {
  while(function_24648886(e_corpse)) {
    waitframe(1);
  }

  if(isDefined(e_corpse)) {
    e_corpse deletedelay();
  }
}

function function_f14a15c0(var_50cc0d4f = 0) {
  level.var_9051f4a3 endon(#"skipped");

  if(!var_50cc0d4f) {
    objectives::hide("armada_obj_fly_to_firebase");
  }

  level thread function_c03e5a7d(var_50cc0d4f);

  if(!var_50cc0d4f && !level flag::get(#"hash_34c04132eb808eea")) {
    s_obj = struct::get(#"hash_fbf66e1e463e089");
    objectives::function_4eb5c04a(#"hash_6e6242b6e75e539", s_obj.origin, undefined, 0);
    level flag::wait_till(#"hash_34c04132eb808eea");
    objectives::complete(#"hash_6e6242b6e75e539");
  }

  level flag::set(#"hash_2edfaf196e292488");
}

function function_c03e5a7d(var_50cc0d4f = 0) {
  level.var_9051f4a3 endon(#"skipped");

  if(!var_50cc0d4f) {
    wait 2;
  }

  objectives::scripted(#"hash_3e1e8f33287f0c8", undefined, #"hash_44e6ef7cc513f30a");
}

function function_74c4dd1b() {
  level.var_9051f4a3 endon(#"skipped");

  for(i = 0; i < 6; i++) {
    switch (i) {
      case 0:
        function_a98e77d5(#"hash_b834523b7fc2f1d", 5, #"hash_376991c319a40802", #"hash_6331e355463731b3", #"hash_6331e45546373366", "sp_ripcord_breach_01_02_vc", "vol_ripcord_breach_01_kill");
        break;
      case 1:
        function_a98e77d5(#"hash_b834423b7fc2d6a", 5, #"hash_376991c319a40802", #"hash_1a3974af0f424030", #"hash_1a3977af0f424549", "sp_ripcord_breach_01_03_vc", "vol_ripcord_breach_01_kill");
        break;
      case 2:
        function_a98e77d5(#"breach_02", 5, #"hash_44b60e500cfd1235", #"hash_3a28dc4da7ef3d85", #"hash_3a28d94da7ef386c", "sp_ripcord_breach_02_vc", "vol_ripcord_breach_02_kill");
        break;
      case 3:
        function_a98e77d5(#"breach_03", 5, #"hash_7820f7ffc3673e84", #"hash_60b6e389af747cca", #"hash_60b6e289af747b17", "sp_ripcord_breach_03_vc", "vol_ripcord_breach_03_kill");
        break;
      case 4:
        function_a98e77d5(#"breach_04", 5, #"hash_22e28bfd5bdc7bc7", #"hash_3b782f73edc28cdb", #"hash_3b783073edc28e8e", "sp_ripcord_breach_04_vc", "vol_ripcord_breach_04_kill");
        break;
      case 5:
        function_a98e77d5(#"south_flank_runners", 5, #"hash_1d9525aee2777a29", #"hash_4e538981f4a67329", #"hash_4e538681f4a66e10", "sp_ripcord_south_flank_runners", "vol_ripcord_south_flank_runners_kill");
        break;
    }

    wait 1;
  }
}

function function_3eca44a(var_50cc0d4f = 0) {
  level.var_9051f4a3 endon(#"skipped");
  namespace_b7cfe907::function_51923449();

  if(var_50cc0d4f) {
    wait 1;
  }

  level.player dialogue::queue("vox_cp_armd_00007_rpcd_ripcordthisisba_d5", undefined, 1);
  level.player dialogue::queue("vox_cp_armd_00007_rpcd_beadvisedwehave_8f");
  level.player dialogue::queue("vox_cp_armd_00007_sims_enemysduginalla_b5");
  level.player dialogue::queue("vox_cp_armd_00007_adlr_wedonthaveahope_9c");
  level.player dialogue::queue("vox_cp_armd_00007_adlr_lightemup_17");
  wait 2;
  namespace_b7cfe907::function_f1a80dd();
  level flag::wait_till_timeout(10, #"hash_77c17e91c8956ded");

  if(!level flag::get(#"hash_77c17e91c8956ded")) {
    function_2df3274d();
  }
}

function function_9a2646df() {
  var_9051f4a3 = level.var_9051f4a3;

  if(level flag::get(#"hash_7445343042e1e0c") || namespace_b7cfe907::function_3f693cc5()) {
    return;
  }

  level thread function_8738b5d2();

  switch (var_9051f4a3.var_c912eb6b) {
    case 0:
      level.player thread dialogue::queue("vox_cp_armd_00007_sims_keepitup_a8", 1);
      break;
    case 1:
      level.player thread dialogue::queue("vox_cp_armd_00007_adlr_nicework_90_1", 1);
      break;
    case 2:
      level.player thread dialogue::queue("vox_cp_armd_00007_sims_fuckyeah_71", 1);
      break;
    case 3:
      level.player thread dialogue::queue("vox_cp_armd_00007_adlr_goodeffect_44", 1);
      var_9051f4a3.var_c912eb6b = 0;
      return;
  }

  var_9051f4a3.var_c912eb6b++;
}

function function_8738b5d2() {
  level.var_9051f4a3 endon(#"skipped");
  level flag::set(#"hash_7445343042e1e0c");
  wait 4;
  level flag::clear(#"hash_7445343042e1e0c");
}

function function_2df3274d() {
  if(namespace_b7cfe907::function_3f693cc5()) {
    return;
  }

  if(!level flag::get(#"hash_44de5e18379b8764")) {
    level flag::set(#"hash_44de5e18379b8764");
    level.player thread dialogue::queue("vox_cp_armd_00007_adlr_ripcordstakinga_16", 1);
    return;
  }

  if(!level flag::get(#"hash_44de6118379b8c7d")) {
    level flag::set(#"hash_44de6118379b8c7d");
    level.player thread dialogue::queue("vox_cp_armd_00007_sims_comeondoctaketh_10", 1);
  }
}

function function_1fcee01d() {
  if(level flag::get(#"hash_3b8d05ec17de5042")) {
    return;
  }

  level flag::set(#"hash_3b8d05ec17de5042");
  level.var_9051f4a3.var_8c393c78 = 0;

  if(!level flag::get(#"hash_11ed3cb4b3a96f61")) {
    level thread function_1b763158();
  }
}

function function_53c1b17f(s_params) {
  if(isDefined(level.var_9051f4a3) && isPlayer(s_params.eattacker) && self.team === # "axis") {
    level.var_9051f4a3.var_8c393c78 = 0;
  }
}

function function_56ca8045(n_damage, var_624c5691 = 1) {
  if(!isDefined(n_damage)) {
    return;
  }

  var_9051f4a3 = level.var_9051f4a3;
  var_9051f4a3.var_8c393c78 += n_damage;
  b_fail = 0;

  if(var_624c5691) {
    if(var_9051f4a3.var_8c393c78 >= 18000) {
      b_fail = 1;
    }
  } else if(var_9051f4a3.var_8c393c78 >= 8000) {
    b_fail = 1;
  }

  if(b_fail) {
    level flag::set(#"hash_189bbc62bf947091");

    if(isalive(level.player)) {
      level.player.var_97a2e324 = # "allies";
      level.player thread friendlyfire::missionfail();
    }

    return;
  }

  level thread function_cdfbef90();
}

function function_1b763158() {
  level endon(#"hash_189bbc62bf947091", #"hash_11ed3cb4b3a96f61");
  level.var_9051f4a3 endon(#"skipped");
  t_damage = getent("t_ripcord_friendly_fire", "targetname");

  while(true) {
    s_waitresult = t_damage waittill(#"damage");

    if(isPlayer(s_waitresult.attacker) && s_waitresult.mod !== "MOD_PROJECTILE_SPLASH") {
      level thread function_56ca8045(s_waitresult.amount, 1);
    }
  }
}

function function_cdfbef90() {
  self notify("49f07e1d20688d40");
  self endon("49f07e1d20688d40");
  level endon(#"hash_189bbc62bf947091", #"hash_11ed3cb4b3a96f61");
  var_9051f4a3 = level.var_9051f4a3;
  var_9051f4a3 endon(#"skipped");

  while(var_9051f4a3.var_8c393c78 > 0) {
    wait 1;
    var_9051f4a3.var_8c393c78 = max(0, var_9051f4a3.var_8c393c78 - 250);
  }
}

function function_330ed1b() {
  self notify("51e7f248bbea0ca1");
  self endon("51e7f248bbea0ca1");
  level.var_9051f4a3 endon(#"skipped");
  level endon(#"hash_67902020b6966b5e");

  if(getdvarint(#"hash_3b90a67ea0b6081b", 0) >= 2) {
    return;
  }

  if(!level flag::get(#"hash_67902020b6966b5e")) {
    level thread function_fd4f7873();
    level flag::wait_till_any_timeout(120, [# "hash_4279102511f3e9e8", #"hash_67902020b6966b5e"]);

    if(!level flag::get(#"hash_67902020b6966b5e")) {
      level util::missionfailedwrapper(#"hash_3fe32a539067e0b5", #"hash_5ca05ccf36994b39");
      namespace_b7cfe907::function_51923449();
      level.player dialogue::queue("vox_cp_armd_00007_rpcd_badgernineronep_03", undefined, 1);
    }
  }
}

function function_fd4f7873() {
  self notify("404691ac5ebb8ee7");
  self endon("404691ac5ebb8ee7");
  var_9051f4a3 = level.var_9051f4a3;
  var_9051f4a3 endon(#"skipped");
  level endon(#"hash_67902020b6966b5e");

  if(level flag::get(#"hash_67902020b6966b5e")) {
    return;
  }

  for(i = 0; i < 2; i++) {
    wait 40;

    if(!namespace_b7cfe907::function_3f693cc5()) {
      namespace_b7cfe907::function_51923449();

      switch (var_9051f4a3.var_f446dd0f) {
        case 0:
          level.player dialogue::queue("vox_cp_armd_00007_rpcd_badgernineronew_2c");
          level.player dialogue::queue("vox_cp_armd_00007_adlr_getwithitbellta_80");
          var_9051f4a3.var_f446dd0f++;
          break;
        case 1:
          level.player dialogue::queue("vox_cp_armd_00007_rpcd_nineronewecanth_62");
          level.player dialogue::queue("vox_cp_armd_00007_sims_whatthefuckcome_22");
          var_9051f4a3.var_f446dd0f = 0;
          break;
      }

      level util::delay(2, undefined, &namespace_b7cfe907::function_f1a80dd);
    }
  }
}

function function_8544c23e(var_549c5e7b, var_f95b722f, var_854f3b02, var_b253c927 = 0) {
  level.var_9051f4a3 endon(#"skipped");
  function_1eaaceab(var_549c5e7b);

  if(var_549c5e7b.size > 0) {
    var_549c5e7b = array::sort_by_script_int(var_549c5e7b, 1);
    objectives::kill(var_f95b722f, undefined, undefined, 0, 1, 0, #"hash_745f1c5e96b6668a");

    foreach(var_cd75ffd6 in var_549c5e7b) {
      if(isalive(var_cd75ffd6)) {
        objectives::update_position(var_f95b722f, var_cd75ffd6);
        var_cd75ffd6 waittill(#"death");

        if(var_b253c927) {
          break;
        }
      }
    }

    objectives::complete(var_f95b722f);
  }

  if(isDefined(var_854f3b02)) {
    level flag::set(var_854f3b02);
  }
}

function function_9d49cee9() {
  self endon(#"death");

  if(self.vehicletype == # "hash_2bf574cefe3e6d9e") {
    self thread function_12f91d79();
  }

  self.player_heli_vehicle_cascade_forced = "ripcord_riverbank_convoy_01";

  while(!level flag::get(#"hash_6bb86ce8c2cb78e7") && isalive(level.player) && !level.player util::is_player_looking_at(self.origin, 0.8, 1, self, level.var_53bb8ef2.var_78bd98cb)) {
    waitframe(1);
  }

  level flag::set(#"hash_6bb86ce8c2cb78e7");
  self vehicle::go_path();
  level flag::wait_till(#"hash_6dfec0bfb77bdbe9");
  self kill();
}

function function_12f91d79() {
  self endon(#"death");

  while(!self turret::is_turret_enabled(1)) {
    waitframe(1);
  }

  self turret::disable(1);
  level flag::wait_till(#"hash_490bc7407722903d");
  wait 1;
  self turret::enable(1, 0);
}

function function_3e14be61() {
  self endon(#"death");
  level flag::wait_till(#"hash_6bb86ce8c2cb78e7");
  self vehicle::go_path();
  level flag::wait_till(#"hash_6dfec0bfb77bdbe9");
  self kill();
}

function function_4ba24e3b() {
  var_9051f4a3 = level.var_9051f4a3;
  var_9051f4a3 endon(#"skipped");

  if(!isDefined(var_9051f4a3.var_32dc329c)) {
    var_9051f4a3.var_32dc329c = [];
  } else if(!isarray(var_9051f4a3.var_32dc329c)) {
    var_9051f4a3.var_32dc329c = array(var_9051f4a3.var_32dc329c);
  }

  var_9051f4a3.var_32dc329c[var_9051f4a3.var_32dc329c.size] = self;
  self.a_e_targets = function_aa2f407c("sp_ripcord_clustered_targets", self.target);
  self thread function_9aaa0e13();
  self thread function_d8b47383();
}

function function_9aaa0e13() {
  level.var_9051f4a3 endon(#"skipped");

  foreach(struct in struct::get_array(self.target)) {
    if(struct.script_noteworthy === # "objective") {
      s_obj = struct;
      break;
    }
  }

  if(!isDefined(s_obj)) {
    return;
  }

  self.s_obj = s_obj;
  level flag::wait_till(#"hash_2edfaf196e292488");

  if(!self flag::get(#"objective_complete")) {
    var_f95b722f = s_obj.var_4f7ad985;
    objectives::kill(var_f95b722f, s_obj.origin, undefined, 0, 1, 0, #"hash_745f1c5e96b6668a");
    self flag::wait_till(#"objective_complete");
    objectives::complete(var_f95b722f);
  }
}

function function_d8b47383() {
  level.var_9051f4a3 endon(#"skipped");
  self endon(#"destroyed");

  foreach(ent in getEntArray(self.target, "targetname", 1)) {
    if(ent.script_noteworthy === # "trigger_damage") {
      t_damage = ent;
      break;
    }
  }

  if(!isDefined(t_damage)) {
    function_1eaaceab(self.a_e_targets);
    ai::waittill_dead(self.a_e_targets);
    e_attacker = level.player;
  } else {
    self.t_damage = t_damage;
    t_damage endon(#"death");

    while(true) {
      s_waitresult = t_damage waittill(#"damage");

      if(isPlayer(s_waitresult.attacker) && s_waitresult.mod !== "MOD_PROJECTILE_SPLASH") {
        break;
      }
    }

    e_attacker = s_waitresult.attacker;
  }

  self thread function_2e9bb366(e_attacker);
}

function function_2e9bb366(e_attacker) {
  if(self flag::get(#"destroyed")) {
    return;
  }

  self flag::set(#"destroyed");
  function_1eaaceab(self.a_e_targets);

  foreach(e_target in self.a_e_targets) {
    e_target util::delay(randomfloatrange(0.1, 1), undefined, &kill, e_target.origin, e_attacker, e_attacker, level.var_53bb8ef2.var_df6d4579);
  }

  foreach(struct in struct::get_array(self.target)) {
    if(struct.script_noteworthy === # "explosion") {
      var_85e471f5 = struct;
      break;
    }
  }

  if(isDefined(var_85e471f5)) {
    wait 1;
    playFX(#"hash_68a62bc3d5b15568", var_85e471f5.origin);
  }

  wait 0.5;

  if(isDefined(self.var_5af73ff)) {
    level flag::set(self.var_5af73ff);
  }

  self flag::set(#"objective_complete");
}

function function_aaa7f178(var_79de6b64) {
  level.var_9051f4a3 endon(#"skipped");
  level flag::wait_till(#"hash_490bc7407722903d");
  var_79de6b64 = array::sort_by_script_int(var_79de6b64, 1);

  foreach(s_mortar in var_79de6b64) {
    s_mortar notify(#"hash_e34d6cf64d19bda");
    wait randomfloatrange(0.5, 1);
  }
}

function function_2095821c() {
  level.player endon(#"death");
  level.var_9051f4a3 endon(#"skipped");
  var_7233f141 = function_aa2f407c("sp_ripcord_reinf_convoy_01", undefined, 1, 0, &function_e12f1afa);
  var_5073adc1 = function_aa2f407c("sp_ripcord_reinf_convoy_02", undefined, 1, 0, &function_e154be89);
  level thread function_31afcffc(arraycombine(var_7233f141, var_5073adc1));
  level flag::wait_till_all([# "hash_77c17e91c8956ded", #"hash_6dfec0bfb77bdbe9", #"hash_55116385b662a489"]);

  if(level flag::get(#"hash_22413fc0a2a93e24")) {
    objectives::complete(#"hash_2219bd003d6556ce");
  }

  level thread function_8544c23e(var_7233f141, #"ripcord_reinf_convoy_01", #"hash_655527a3d778dd1f", 1);
  level thread function_8544c23e(var_5073adc1, #"ripcord_reinf_convoy_02", #"hash_60fbef66f73d44ea", 1);
  var_19e82d16 = [];
  var_713e5bc1 = [];
  var_757e6441 = [];
  var_4c689216 = function_aa2f407c("sp_ripcord_reinf_rpgs_02");
  level flag::wait_till(#"hash_160f56c6d59d5917");
  var_eb5353bb = arraycombine(var_19e82d16, var_713e5bc1);
  function_1eaaceab(var_eb5353bb);

  foreach(var_4e7c260f in var_eb5353bb) {
    var_4e7c260f ai::bloody_death();
  }

  level flag::wait_till(#"hash_250edc5195758370");
  var_eb5353bb = arraycombine(var_757e6441, var_4c689216);
  function_1eaaceab(var_eb5353bb);

  foreach(var_4e7c260f in var_eb5353bb) {
    var_4e7c260f ai::bloody_death();
  }
}

function function_e12f1afa() {
  self endon(#"death");
  self setforcenocull();
  self.player_heli_vehicle_cascade_forced = "ripcord_reinf_convoy_01";
  self thread function_afab9670();
  self setspeedimmediate(0);
  level flag::wait_till(#"hash_6dfec0bfb77bdbe9");
  self resumespeed();
}

function function_e154be89() {
  self endon(#"death");
  self setforcenocull();
  self.player_heli_vehicle_cascade_forced = "ripcord_reinf_convoy_02";
  self thread function_afab9670();
  self setspeedimmediate(0);
  level flag::wait_till(#"hash_6dfec0bfb77bdbe9");
  self resumespeed();
}

function function_afab9670() {
  self endon(#"death");
  trigger::wait_till("t_ripcord_reinf_convoy_fail", "targetname", self, 0);
  level flag::set(#"hash_4279102511f3e9e8");
}

function function_31afcffc(var_549c5e7b) {
  level.player endon(#"death");
  level.var_9051f4a3 endon(#"skipped");
  namespace_b7cfe907::function_51923449();
  wait 1;
  level util::delay(2, undefined, &flag::set, #"hash_55116385b662a489");
  level.player dialogue::queue("vox_cp_armd_00007_rpcd_badgernineroneo_fe");
  level.player dialogue::queue("vox_cp_armd_00007_rpcd_diverttointerce_80");
  level.player dialogue::queue("vox_cp_armd_00007_adlr_rogerthatripcor_10");
  wait 1;
  namespace_b7cfe907::function_f1a80dd();
  function_1eaaceab(var_549c5e7b);
  var_5168e40f = 0;
  var_78bd98cb = level.var_53bb8ef2.var_78bd98cb;

  while(var_549c5e7b.size > 0) {
    foreach(var_cd75ffd6 in var_549c5e7b) {
      if(distance2dsquared(var_78bd98cb.origin, var_cd75ffd6.origin) <= sqr(5000) && level.player util::is_player_looking_at(var_cd75ffd6 getcentroid(), 0.2, 1, var_cd75ffd6, var_78bd98cb)) {
        var_5168e40f = 1;
        break;
      }
    }

    if(var_5168e40f) {
      break;
    }

    wait 0.1;
    function_1eaaceab(var_549c5e7b);
  }

  if(var_5168e40f) {
    if(!namespace_b7cfe907::function_3f693cc5()) {
      level.player dialogue::queue("vox_cp_armd_00007_adlr_takeoutthoseaat_bf");
    }

    wait 10;
    function_2df3274d();
  }
}

function function_ac5ebfa1() {
  level.var_9051f4a3 endon(#"skipped");
  a_spawners = getspawnerarray("sp_ripcord_reinf_runners", "targetname");

  for(i = 0; i < 4; i++) {
    switch (i) {
      case 0:
        var_3ba94e96 = "sp_ripcord_reinf_runners_01";
        str_spawns = # "hash_661c0d6b54386759";
        break;
      case 1:
        var_3ba94e96 = "sp_ripcord_reinf_runners_02";
        str_spawns = # "hash_661c0a6b54386240";
        break;
      case 2:
        var_3ba94e96 = "sp_ripcord_reinf_runners_03";
        str_spawns = # "hash_661c0b6b543863f3";
        break;
      case 3:
        var_3ba94e96 = "sp_ripcord_reinf_runners_04";
        str_spawns = # "hash_661c106b54386c72";
        break;
    }

    level thread function_737ae2d0(var_3ba94e96, str_spawns);
  }
}

function function_737ae2d0(var_3ba94e96, str_spawns) {
  level.var_9051f4a3 endon(#"skipped");
  a_spawners = getspawnerarray(var_3ba94e96, "targetname");
  a_s_spawns = struct::get_array(str_spawns);
  a_s_spawns = array::randomize(a_s_spawns);

  foreach(s_spawn in a_s_spawns) {
    spawner = array::random(a_spawners);
    spawner.origin = s_spawn.origin;
    spawner.angles = s_spawn.angles;
    spawner.target = s_spawn.target;

    while(true) {
      var_4e75a347 = spawner::simple_spawn_single(spawner, &function_158cdaa);

      if(isDefined(var_4e75a347)) {
        var_4e75a347 namespace_4e75a347::function_cab4b520("ALERT");
        break;
      }

      waitframe(1);
    }

    wait randomfloatrange(0.4, 0.5);
  }
}

function function_4afd7dea() {
  level.player endon(#"death");
  var_9051f4a3 = level.var_9051f4a3;
  var_9051f4a3 endon(#"skipped");
  level thread function_226ff16b();
  var_273af5fa = function_aa2f407c("sp_ripcord_east_flank_rpgs", #"hash_36cfe917966a1b00");
  level thread function_4826ff0();
  var_6a21c9d = function_aa2f407c("sp_ripcord_north_flank_apcs", #"hash_12f98eba8396f376", 1, 0, &function_286a4ce2);
  var_a534a30f = function_aa2f407c("sp_ripcord_north_flank_apcs", #"hash_62c9b0bc917ccba3", 1, 0, &function_286a4ce2, 1);
  var_a21e5c7c = function_aa2f407c("sp_ripcord_north_flank_trucks", undefined, 1, 0, &function_286a4ce2, 1);
  a_vh_targets = arraycombine(var_6a21c9d, var_a534a30f);
  a_vh_targets = arraycombine(a_vh_targets, var_a21e5c7c);
  var_238b2d24 = function_aa2f407c("sp_ripcord_north_flank_rpgs");
  level flag::wait_till(#"hash_250edc5195758370");
  level thread function_63381e72(a_vh_targets);
  level flag::wait_till(#"hash_19e56ebdc65f268b");
  objectives::scripted(#"hash_27f5175fca92a241", undefined, #"hash_ffb718cd7acca4b");
  objectives::function_6a5ca7ac(#"hash_27f5175fca92a241", undefined, #"hash_3e1e8f33287f0c8");

  if(!level flag::get(#"hash_3a020db7d8aa516c")) {
    s_obj = struct::get(#"hash_3ad9f2aa17139b09");
    var_5eb0f978 = level.player math::get_dot_right(s_obj.origin, 1) >= 0.45;

    if(var_5eb0f978) {
      s_obj = struct::get(#"hash_27dd3e85a5af7d32");
    }

    objectives::function_4eb5c04a(#"hash_117a5c13253d75cd", s_obj.origin);
    level flag::wait_till(#"hash_3a020db7d8aa516c");

    if(var_5eb0f978) {
      s_obj = struct::get(#"hash_27dd3d85a5af7b7f");
      objectives::update_position(#"hash_117a5c13253d75cd", s_obj.origin);
      level flag::wait_till(#"hash_2fd001615557fe78");
    }

    objectives::complete(#"hash_117a5c13253d75cd");
  }

  level thread function_330ed1b();
  function_1eaaceab(a_vh_targets);

  if(a_vh_targets.size > 0) {
    objectives::kill(#"hash_2d2e7426cedd97b8", a_vh_targets, undefined, 0, 1, 0, #"hash_745f1c5e96b6668a");
    ai::waittill_dead(a_vh_targets);
    objectives::complete(#"hash_2d2e7426cedd97b8");
  }

  if(isDefined(var_9051f4a3.var_8a6f2b32)) {
    function_1eaaceab(var_9051f4a3.var_8a6f2b32);

    foreach(var_45fdfcce in var_9051f4a3.var_8a6f2b32) {
      var_45fdfcce ai::bloody_death();
    }
  }

  level flag::set(#"hash_9b54061312dc6ab");
  level flag::set(#"hash_71b417d2e25ac7c1");
  level flag::set(#"hash_16d9badc5604cc63");
  wait 2;
  level flag::set(#"hash_1ef3a1febf52c90e");
  var_c3d060a6 = arraycombine(var_273af5fa, var_238b2d24);
  function_1eaaceab(var_c3d060a6);

  foreach(ai_cleanup in var_c3d060a6) {
    ai_cleanup thread ai::bloody_death(randomfloatrange(0.1, 2));
  }

  wait 2;
  objectives::complete(#"hash_27f5175fca92a241");
  level flag::set(#"hash_2e43c4e93e07445c");
}

function function_63381e72(a_vh_targets) {
  level.player endon(#"death");
  level.var_9051f4a3 endon(#"skipped");
  namespace_b7cfe907::function_51923449();
  wait 1;
  level util::delay(2, undefined, &flag::set, #"hash_19e56ebdc65f268b");
  level.player dialogue::queue("vox_cp_armd_00007_rpcd_badgernineronet_c4");
  level.player dialogue::queue("vox_cp_armd_00007_adlr_holdonripcordwe_58");
  wait 1;
  namespace_b7cfe907::function_f1a80dd();
  function_1eaaceab(a_vh_targets);
  var_5168e40f = 0;
  var_78bd98cb = level.var_53bb8ef2.var_78bd98cb;

  while(a_vh_targets.size > 0) {
    foreach(vh_target in a_vh_targets) {
      if(distance2dsquared(var_78bd98cb.origin, vh_target.origin) <= sqr(5000) && level.player util::is_player_looking_at(vh_target getcentroid(), 0.2, 1, vh_target, var_78bd98cb)) {
        var_5168e40f = 1;
        break;
      }
    }

    if(var_5168e40f) {
      break;
    }

    wait 0.1;
    function_1eaaceab(a_vh_targets);
  }

  if(var_5168e40f) {
    n_timeout = 1;
    namespace_b7cfe907::function_51923449();
    level.player dialogue::queue("vox_cp_armd_00007_sims_hitthatarmor_58", n_timeout);
    wait 2;
    level.player dialogue::queue("vox_cp_armd_00007_adlr_stayonthatconvo_4e", n_timeout);
    wait 2;
    namespace_b7cfe907::function_f1a80dd();
    n_timeout = 10;
    level flag::wait_till_timeout(n_timeout, #"hash_9b54061312dc6ab");

    if(!level flag::get(#"hash_9b54061312dc6ab")) {
      function_2df3274d();
    }
  }
}

function function_4826ff0() {
  var_9051f4a3 = level.var_9051f4a3;

  if(isDefined(var_9051f4a3.var_5f448549)) {
    function_1eaaceab(var_9051f4a3.var_5f448549);

    foreach(var_4e7c260f in var_9051f4a3.var_5f448549) {
      if(isalive(var_4e7c260f)) {
        var_4e7c260f ai::bloody_death();
        wait 0.1;
      }
    }
  }

  if(isDefined(var_9051f4a3.var_f3b33549)) {
    function_1eaaceab(var_9051f4a3.var_f3b33549);

    foreach(var_4e7c260f in var_9051f4a3.var_f3b33549) {
      if(isalive(var_4e7c260f)) {
        var_4e7c260f ai::bloody_death();
        wait 0.1;
      }
    }
  }

  if(isDefined(var_9051f4a3.var_c5b0c2c8)) {
    function_1eaaceab(var_9051f4a3.var_c5b0c2c8);

    foreach(var_52fba58 in var_9051f4a3.var_c5b0c2c8) {
      if(isalive(var_52fba58)) {
        level flag::set(#"hash_331923797c112355");
        var_52fba58 kill();
        wait 0.1;
      }
    }
  }

  if(isDefined(var_9051f4a3.var_24e3ce59)) {
    function_1eaaceab(var_9051f4a3.var_24e3ce59);

    foreach(var_52fba58 in var_9051f4a3.var_24e3ce59) {
      if(isalive(var_52fba58)) {
        level flag::set(#"hash_496519e991f11c8e");
        var_52fba58 kill();
        wait 0.1;
      }
    }
  }

  var_385f5dc0 = struct::get(#"hash_8d295ee06976887");
  var_385f5dc0.radius = float(var_385f5dc0.radius);

  if(isDefined(var_9051f4a3.var_51ae0380)) {
    foreach(var_cd75ffd6 in var_9051f4a3.var_51ae0380) {
      if(isDefined(var_cd75ffd6) && distancesquared(var_cd75ffd6.origin, var_385f5dc0.origin) <= sqr(var_385f5dc0.radius)) {
        var_cd75ffd6 delete();
      }
    }
  }

  foreach(e_corpse in getcorpsearray(var_385f5dc0.origin, var_385f5dc0.radius)) {
    e_corpse delete();
  }
}

function function_286a4ce2(var_e81f32c5 = 0) {
  self endon(#"death");
  self.var_3314f72b = 1;
  self.var_b71ad346 = 650;
  self.var_a84747b2 = 1;

  if(self.script_noteworthy === # "hash_7169b6adf298d58b") {
    level thread function_ec6e2d8a(self);
  }

  self callback::function_d8abfc3d(#"on_vehicle_killed", &function_9644639d);

  if(var_e81f32c5) {
    self setspeedimmediate(0);
  }

  a_s_spawns = struct::get_array(self.var_214db6bf.target);

  if(a_s_spawns.size > 0) {
    var_7a436008 = [1, 2, 3, 4, 5, 6, 7, 8];

    while(var_7a436008.size > a_s_spawns.size) {
      n_seat = array::random(var_7a436008);
      arrayremovevalue(var_7a436008, n_seat);
      self flag::set("crew" + n_seat + "_occupied");
    }

    function_aa2f407c("sp_north_flank_defenders", self.var_214db6bf.target, undefined, undefined, &function_cece4b10, self);
  }

  if(var_e81f32c5) {
    level flag::wait_till(#"hash_3a020db7d8aa516c");
    self resumespeed();
  }
}

function function_9644639d(s_params) {
  level flag::set(#"hash_71b417d2e25ac7c1");
  level thread function_330ed1b();
  level util::delay(0.5, undefined, &function_9a2646df);
}

function function_cece4b10(var_ff72be84) {
  self endon(#"death");
  self.overrideactordamage = &function_8d79732c;

  if(!isDefined(level.var_9051f4a3.var_8a6f2b32)) {
    level.var_9051f4a3.var_8a6f2b32 = [];
  } else if(!isarray(level.var_9051f4a3.var_8a6f2b32)) {
    level.var_9051f4a3.var_8a6f2b32 = array(level.var_9051f4a3.var_8a6f2b32);
  }

  level.var_9051f4a3.var_8a6f2b32[level.var_9051f4a3.var_8a6f2b32.size] = self;
  self val::set(#"hash_24a2b3432fa6a156", "ignoreall", 1);
  self vehicle::get_in(self, var_ff72be84, "crew");
  self flag::wait_till_clear_all(["in_vehicle", "riding_vehicle"]);
  self val::reset(#"hash_24a2b3432fa6a156", "ignoreall");
  vol_goal = getent(self.var_214db6bf.target, "targetname");
  self setgoal(vol_goal, 1);
}

function function_8d79732c(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex) {
  if(isPlayer(boneindex)) {
    return modelindex;
  }

  return 0;
}

function function_ec6e2d8a(var_ff72be84) {
  vh_target = level.var_9051f4a3.var_4817b03f;

  if(!isDefined(vh_target)) {
    return;
  }

  if(isalive(var_ff72be84)) {
    vh_target val::reset(#"hash_3b9be08d33a28b30", "ignoreme");
    var_ff72be84 turret::set_target(vh_target, (0, 0, 0), 1, 1, 1);
  }

  level flag::wait_till(#"hash_3a020db7d8aa516c");
  wait 3;
  vh_target val::set(#"hash_3b9be08d33a28b30", "ignoreme", 1);
  level flag::set(#"hash_52752944f5336796");
  wait 1;

  if(isalive(var_ff72be84)) {
    var_ff72be84 turret::clear_target(1);
  }
}

function function_cffa5653() {
  if(!isDefined(level.var_9051f4a3.var_79de6b64)) {
    level.var_9051f4a3.var_79de6b64 = [];
  } else if(!isarray(level.var_9051f4a3.var_79de6b64)) {
    level.var_9051f4a3.var_79de6b64 = array(level.var_9051f4a3.var_79de6b64);
  }

  level.var_9051f4a3.var_79de6b64[level.var_9051f4a3.var_79de6b64.size] = self;
  self.var_2199674d = [];
  self.var_447b1ac8 = [];
  self.var_972f9755 = [];

  foreach(ent in getEntArray(self.target, "targetname", 1)) {
    if(ent.script_noteworthy === # "trigger_damage") {
      self.t_damage = ent;
      self thread function_cff233c();
    }
  }

  var_2199674d = function_aa2f407c(self.target);

  foreach(e_spawned in var_2199674d) {
    if(!isDefined(self.var_2199674d)) {
      self.var_2199674d = [];
    } else if(!isarray(self.var_2199674d)) {
      self.var_2199674d = array(self.var_2199674d);
    }

    self.var_2199674d[self.var_2199674d.size] = e_spawned;

    if(e_spawned.script_noteworthy === # "crew") {
      if(!isDefined(self.var_447b1ac8)) {
        self.var_447b1ac8 = [];
      } else if(!isarray(self.var_447b1ac8)) {
        self.var_447b1ac8 = array(self.var_447b1ac8);
      }

      self.var_447b1ac8[self.var_447b1ac8.size] = e_spawned;
    }
  }

  foreach(struct in struct::get_array(self.target)) {
    switch (struct.script_noteworthy) {
      case # "muzzle":
        if(!isDefined(self.var_972f9755)) {
          self.var_972f9755 = [];
        } else if(!isarray(self.var_972f9755)) {
          self.var_972f9755 = array(self.var_972f9755);
        }

        self.var_972f9755[self.var_972f9755.size] = struct;
        break;
      case # "explosion":
        self.var_85e471f5 = struct;
        break;
    }
  }

  self thread function_94edfe20();
  self flag::set(#"spawned");
}

function function_cff233c() {
  self endon(#"destroyed");

  while(true) {
    s_waitresult = self.t_damage waittill(#"damage");
    e_attacker = s_waitresult.attacker;

    if(issentient(e_attacker) && e_attacker getteam() == # "allies") {
      break;
    }
  }

  self function_e00566fd(s_waitresult);
}

function function_e00566fd(s_waitresult, b_cleanup = 0) {
  if(!self flag::get(#"spawned")) {
    return;
  }

  if(isPlayer(s_waitresult.attacker) && isDefined(self.var_4a9e8ee3)) {
    level flag::set(self.var_4a9e8ee3);
  }

  if(isDefined(self.var_85e471f5)) {
    self thread function_86506afc();
  }

  function_1eaaceab(self.var_2199674d);

  foreach(e_spawned in self.var_2199674d) {
    if(!b_cleanup) {
      e_spawned util::delay(randomfloatrange(0.1, 1), undefined, &kill, e_spawned.origin, s_waitresult.attacker, s_waitresult.attacker, level.var_53bb8ef2.var_df6d4579);
      continue;
    }

    if(isvehicle(e_spawned) || function_8d8e91af(e_spawned)) {
      e_spawned kill();
      continue;
    }

    e_spawned ai::bloody_death();
  }

  self flag::set(#"destroyed");
}

function function_86506afc() {
  wait 1;
  playFX(#"hash_68a62bc3d5b15568", self.var_85e471f5.origin);
}

function function_94edfe20() {
  self endon(#"destroyed");
  self waittill(#"hash_e34d6cf64d19bda");
  var_972f9755 = array::randomize(self.var_972f9755);

  foreach(i, var_a2d4664b in var_972f9755) {
    var_a2d4664b.var_5dcf77d6 = 0;
    self thread function_f91a9d15(var_a2d4664b);

    if(i + 1 < var_972f9755.size) {
      wait 2;
    }
  }

  while(true) {
    foreach(var_a2d4664b in var_972f9755) {
      n_delay = randomintrangeinclusive(10, 20);

      if(var_a2d4664b.var_5dcf77d6 >= n_delay) {
        self thread function_f91a9d15(var_a2d4664b);
        var_a2d4664b.var_5dcf77d6 = 0;
        continue;
      }

      var_a2d4664b.var_5dcf77d6++;
    }

    wait 1;
  }
}

function function_f91a9d15(var_a2d4664b) {
  level.var_9051f4a3 endon(#"skipped");
  level endon(#"hash_494514617379bbdf");
  s_target = struct::get(#"hash_2d5a030e61f3ef3d");
  n_radius = float(s_target.radius);
  n_x = randomfloat(n_radius);

  if(math::cointoss()) {
    n_x *= -1;
  }

  n_y = randomfloat(n_radius);

  if(math::cointoss()) {
    n_y *= -1;
  }

  v_target = s_target.origin + (n_x, n_y, 0);
  a_trace = groundtrace(v_target, v_target - (0, 0, 2048), 0, level.var_53bb8ef2.var_78bd98cb);

  if(isDefined(a_trace[# "position"]) && !isDefined(a_trace[# "entity"])) {
    var_42ba4b31 = util::spawn_model(#"tag_origin", var_a2d4664b.origin);
    v_target = a_trace[# "position"];
    n_time = var_42ba4b31 function_a93c1395(v_target, float(var_a2d4664b.n_power));
    self thread function_50e34d79(n_time, v_target);

    if(isDefined(var_a2d4664b.var_b135ee81)) {
      n_time -= float(var_a2d4664b.var_b135ee81);
    }

    wait 0.1;
    playFXOnTag(#"hash_75dc71e69737c2b1", var_42ba4b31, "tag_origin");

    if(n_time - 0.1 > 0) {
      wait n_time - 0.1;
    }

    var_42ba4b31 delete();
  }
}

function function_50e34d79(n_time, v_target) {
  var_9051f4a3 = level.var_9051f4a3;
  var_9051f4a3 endon(#"skipped");
  level endon(#"hash_494514617379bbdf");
  wait n_time;
  v_angles = (270, 0, 0);
  playFX(#"hash_7e60569db9c36606", v_target, anglesToForward(v_angles), anglestoup(v_angles));
  var_ada0b21 = function_e16259ed(var_9051f4a3.var_72364dd7);
  var_eb5353bb = arraysortclosest(var_ada0b21, v_target, undefined, 0, 300);

  foreach(var_4e7c260f in var_eb5353bb) {
    var_4e7c260f dodamage(10, v_target, undefined, undefined, undefined, "MOD_EXPLOSIVE");
  }
}

function function_a93c1395(target_pos, power) {
  start_pos = self.origin;
  gravity = getdvarint(#"bg_gravity", 0) * -1;
  dist = distance(start_pos, target_pos);
  time = dist / power;
  delta = target_pos - start_pos;
  drop = 0.5 * gravity * time * time;
  velocity = (delta[0] / time, delta[1] / time, (delta[2] - drop) / time);
  self movegravity(velocity, time);
  return time;
}

function function_7aad38d0(var_50cc0d4f = 0) {
  level.var_9051f4a3 endon(#"skipped");

  if(!var_50cc0d4f) {
    level flag::wait_till(#"hash_725325f3f3a86396");
  }

  if(var_50cc0d4f) {
    level thread function_9b9ad0ab("sp_ripcord_rpg_huey", &function_4112226, 1);
    level thread function_9b9ad0ab("sp_ripcord_support_huey_01", &function_9f50131);
    level thread function_9b9ad0ab("sp_ripcord_support_huey_02", &function_e6828e29);
    level thread function_9b9ad0ab("sp_ripcord_support_huey_03", &function_432b55b);
    level thread function_9b9ad0ab("sp_ripcord_reveal_huey_01", &function_45c28ee0);
    level thread function_9b9ad0ab("sp_ripcord_reveal_huey_02", &function_ef3aeb5d);
  } else {
    level thread function_7c0da395();
  }

  a_s_targets = struct::get_array(#"ripcord_clustered_targets", "script_noteworthy");
  a_s_targets = array::sort_by_script_int(a_s_targets, 1);

  foreach(s_targets in a_s_targets) {
    if(var_50cc0d4f) {
      s_targets thread function_4ba24e3b();
      continue;
    }

    s_targets function_4ba24e3b();
  }

  var_8f9e5ea9 = function_aa2f407c("sp_vh_ripcord_guiding_vehicles_03", undefined, undefined, undefined, &function_c4d2fbf9);
  level thread ripcord_guiding_vehicles_03(var_8f9e5ea9);

  if(!var_50cc0d4f) {
    function_9b9ad0ab("sp_ripcord_support_huey_01", &function_9f50131);
    function_9b9ad0ab("sp_ripcord_support_huey_02", &function_e6828e29);
    function_9b9ad0ab("sp_ripcord_support_huey_03", &function_432b55b);
    function_9b9ad0ab("sp_ripcord_reveal_huey_01", &function_45c28ee0);
    function_9b9ad0ab("sp_ripcord_reveal_huey_02", &function_ef3aeb5d);
  }
}

function function_c4d2fbf9() {
  self.health = 100;
  self flag::set(#"hash_40e1cea03744d0f1");
}

function ripcord_guiding_vehicles_03(var_a21e5c7c) {
  level.var_9051f4a3 endon(#"skipped");
  function_1eaaceab(var_a21e5c7c);

  if(var_a21e5c7c.size > 0) {
    level thread function_84de7dcf(var_a21e5c7c);

    foreach(i, var_ff72be84 in var_a21e5c7c) {
      if(isalive(var_ff72be84)) {
        var_ff72be84 waittill(#"death");

        if(i + 1 < var_a21e5c7c.size) {
          level thread function_330ed1b();
          wait 0.5;
          function_9a2646df();
        }
      }
    }
  }

  level flag::set(#"hash_2fcba334efb3236f");
}

function function_84de7dcf(var_a21e5c7c) {
  level.var_9051f4a3 endon(#"skipped");
  level flag::wait_till(#"hash_2edfaf196e292488");
  function_1eaaceab(var_a21e5c7c);
  var_7cb9f06d = var_a21e5c7c.size > 1;

  if(var_7cb9f06d) {
    s_obj = struct::get(#"hash_34dc85bc677d1df4");
    objectives::kill(#"ripcord_guiding_vehicles_03", s_obj.origin, undefined, 0, 1, 0, #"hash_745f1c5e96b6668a");

    while(var_a21e5c7c.size > 1) {
      function_1eaaceab(var_a21e5c7c);
      waitframe(1);
    }
  }

  var_59b8ed4 = var_a21e5c7c[0];

  if(isalive(var_59b8ed4)) {
    if(!var_7cb9f06d) {
      objectives::kill(#"ripcord_guiding_vehicles_03", var_59b8ed4, undefined, 0, 1, 0, #"hash_745f1c5e96b6668a");
    } else {
      objectives::update_position(#"ripcord_guiding_vehicles_03", var_59b8ed4);
      var_59b8ed4 waittill(#"death");
    }
  } else {
    wait 0.5;
  }

  objectives::complete(#"ripcord_guiding_vehicles_03");
}

function function_9b9ad0ab(str_spawner, spawn_func, arg1) {
  level.var_9051f4a3 endon(#"skipped");

  while(true) {
    if(isDefined(arg1)) {
      var_78bd98cb = spawner::simple_spawn_single(str_spawner, spawn_func, arg1);
    } else {
      var_78bd98cb = spawner::simple_spawn_single(str_spawner, spawn_func);
    }

    if(isDefined(var_78bd98cb)) {
      break;
    }

    waitframe(1);
  }
}

function function_4dee3ecb() {
  if(!isDefined(level.var_9051f4a3.var_b6fdd6f2)) {
    level.var_9051f4a3.var_b6fdd6f2 = [];
  } else if(!isarray(level.var_9051f4a3.var_b6fdd6f2)) {
    level.var_9051f4a3.var_b6fdd6f2 = array(level.var_9051f4a3.var_b6fdd6f2);
  }

  level.var_9051f4a3.var_b6fdd6f2[level.var_9051f4a3.var_b6fdd6f2.size] = self;
  self setrotorspeed(1);
  self.drivepath = 1;
  nd_start = getvehiclenode(self.target, "targetname");
  self vehicle::get_on_path(nd_start);
}

function function_45c28ee0() {
  self endon(#"death");
  self function_4dee3ecb();
  self setmaxpitchroll(20, 50);

  while(!level flag::get(#"hash_490bc7407722903d") && isalive(level.player) && !level.player util::is_player_looking_at(self.origin, 0.9, 1, self, level.var_53bb8ef2.var_78bd98cb)) {
    waitframe(1);
  }

  level flag::set(#"hash_490bc7407722903d");
  self vehicle::go_path();
}

function function_ef3aeb5d() {
  self endon(#"delete");
  level.var_9051f4a3 endon(#"skipped");
  self function_4dee3ecb();
  self setmaxpitchroll(10, 40);
  level flag::wait_till(#"hash_490bc7407722903d");
  self vehicle::go_path();
}

function function_1b0fcde7(var_6bff65c4 = 1, n_pitch = 20) {
  if(!isDefined(level.var_9051f4a3.var_86c425b5)) {
    level.var_9051f4a3.var_86c425b5 = [];
  } else if(!isarray(level.var_9051f4a3.var_86c425b5)) {
    level.var_9051f4a3.var_86c425b5 = array(level.var_9051f4a3.var_86c425b5);
  }

  level.var_9051f4a3.var_86c425b5[level.var_9051f4a3.var_86c425b5.size] = self;
  self val::set(#"hash_3b9be08d33a28b30", "ignoreall", 1);
  self val::set(#"hash_3b9be08d33a28b30", "ignoreme", 1);
  self.overridevehicledamage = &function_fc619d52;

  if(var_6bff65c4) {
    level thread namespace_b7cfe907::function_68d5d346(self, [0, 1, 7, 8]);
    self callback::function_d8abfc3d(#"on_vehicle_killed", &function_ea8ebebc);
    self callback::function_d8abfc3d(#"on_deleted", &function_ea8ebebc);
  }

  self setrotorspeed(1);
  self setspeed(50, 20, 10);
  self setyawspeed(50, 20, 10);
  self vehclearlookat();
  self.var_964b76ab = n_pitch;
  self setdefaultpitch(self.var_964b76ab);
}

function function_fc619d52(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(isDefined(vsurfacenormal) && vsurfacenormal != "MOD_CRUSH" && (isPlayer(damagefromunderneath) || isPlayer(modelindex))) {
    level thread function_56ca8045(partname, 0);
  }

  return false;
}

function function_ea8ebebc(s_params) {
  self namespace_b7cfe907::function_5677b6eb();
}

function function_22761cc0(s_start, var_7985d5b8 = 256, var_a35f50b = 1) {
  self notify("2e9ed5116a26d486");
  self endon("2e9ed5116a26d486");
  self endon(#"death", #"hash_29cc7e1c0557d2ea");
  self notify(#"hash_211a124ebbd9dc00");
  self.var_cb55c804 = var_7985d5b8;
  self setneargoalnotifydist(self.var_cb55c804);
  self cleargoalyaw();
  self cleartargetyaw();
  s_goal = s_start;

  if(!isstruct(s_goal)) {}

  for(s_goal = struct::get(s_goal); true; s_goal = struct::get(s_goal.target)) {
    self.var_b0a8e2ae = s_goal;

    if(var_a35f50b) {
      n_yaw = int(s_goal.angles[1]);
      self setgoalyaw(n_yaw);
      self settargetyaw(n_yaw);
    }

    self function_a57c34b7(s_goal.origin, 1);
    self setgoal(s_goal.origin, 1);
    self waittill(#"goal", #"near_goal");

    if(!isDefined(s_goal.target)) {
      break;
    }
  }

  self notify(#"hash_5ac2aa2987e9f0e1");
}

function function_34728c3a(s_center) {
  self endon(#"death", #"hash_211a124ebbd9dc00");

  if(!isDefined(s_center)) {
    if(!isDefined(self.var_b0a8e2ae)) {
      return;
    }

    s_center = self.var_b0a8e2ae;
  }

  if(isstring(s_center) || ishash(s_center)) {
    s_center = struct::get(s_center);
  }

  self.var_b0a8e2ae = s_center;
  var_5d5bac89 = 0;
  var_b75bab4a = 0;
  var_6e9ae5a5 = 1;
  var_48fc7504 = 0;
  var_b14b572f = 0;
  v_center = s_center.origin;
  n_yaw = int(s_center.angles[1]);
  self setgoalyaw(n_yaw);
  self settargetyaw(n_yaw);
  v_up = anglestoup(s_center.angles);
  v_forward = anglesToForward(s_center.angles);
  v_right = anglestoright(s_center.angles);
  var_294c717c = v_center;
  self.var_cb55c804 = 32;
  self setneargoalnotifydist(self.var_cb55c804);
  var_3d422bc1 = 0;

  while(true) {
    if(var_6e9ae5a5) {
      var_3d422bc1 = 0;
      var_6e9ae5a5 = 0;
    } else {
      var_3d422bc1 += 30;
    }

    if(math::cointoss(var_3d422bc1)) {
      var_6e9ae5a5 = 1;
      var_5d5bac89 = 0;
      var_b75bab4a = 0;

      if(math::cointoss()) {
        var_6fd0c424 = v_forward;

        if(var_b14b572f) {
          var_6fd0c424 *= randomfloatrange(512, 1024);
          var_6fd0c424 *= -1;
        } else {
          var_6fd0c424 *= randomfloatrange(256, 512);
        }

        var_b14b572f = !var_b14b572f;
      } else {
        var_6fd0c424 = v_right * randomfloatrange(256, 512);

        if(var_48fc7504) {
          var_6fd0c424 *= -1;
        }

        var_48fc7504 = !var_48fc7504;
      }

      var_294c717c = v_center + var_6fd0c424;
      self function_a57c34b7(var_294c717c, 1);
      self setgoal(var_294c717c, 1);
      self waittill(#"goal", #"near_goal");
      continue;
    }

    var_6e9ae5a5 = 0;
    var_48fc7504 = 0;
    var_b14b572f = 0;
    var_2bdcb269 = v_right * randomfloat(128);

    if(var_5d5bac89) {
      var_2bdcb269 *= -1;
    }

    v_goal = var_294c717c + var_2bdcb269;
    var_5d5bac89 = !var_5d5bac89;

    if(math::cointoss(25)) {
      var_83dbc6c0 = v_up * randomfloat(128);

      if(var_b75bab4a) {
        var_83dbc6c0 *= -1;
      }

      v_goal += var_83dbc6c0;
      var_b75bab4a = !var_b75bab4a;
    }

    self function_a57c34b7(v_goal, 1);
    self setgoal(v_goal, 1);
    self waittill(#"goal", #"near_goal");
  }
}

function function_539a07b0(var_6776e7ab) {
  self endon(#"death", #"hash_62eeba7b308527bd");

  if(isDefined(var_6776e7ab)) {
    var_1d685f93 = getent(var_6776e7ab, "targetname");
  }

  while(true) {
    wait randomfloatrange(3, 5);

    if(isDefined(var_1d685f93) && !self istouching(var_1d685f93)) {
      continue;
    }

    n_fire_time = randomfloatrange(1, 3);
    self thread vehicle_ai::fire_for_time(n_fire_time, 3);
    self vehicle_ai::fire_for_time(n_fire_time, 4);
  }
}

function function_4d16e098(var_6776e7ab) {
  self endon(#"death", #"hash_3ac6fa8c90fd94b3");

  if(isDefined(var_6776e7ab)) {
    var_1d685f93 = getent(var_6776e7ab, "targetname");
  }

  while(true) {
    wait randomfloatrange(5, 10);
    n_rounds = randomintrangeinclusive(1, 5);
    var_7590fc14 = randomfloatrange(0.25, 1);

    for(i = 0; i < n_rounds; i++) {
      if(isDefined(var_1d685f93) && !self istouching(var_1d685f93)) {
        continue;
      }

      self function_c5c81070();

      if(i + 1 < n_rounds) {
        wait var_7590fc14;
      }
    }
  }
}

function function_c5c81070(s_target) {
  if(!isDefined(self.var_5282fb88)) {
    self.var_5282fb88 = 0;
  }

  v_right = anglestoright(self.angles);
  v_forward = anglesToForward(self.angles);
  v_up = anglestoup(self.angles);
  var_bf584f29 = v_right * 70;

  if(self.var_5282fb88 == 0) {
    self.var_5282fb88 = 1;
    var_bf584f29 *= -1;
  } else {
    self.var_5282fb88 = 0;
  }

  var_bf584f29 += self.origin + v_forward * 40 + v_up * -100;
  v_velocity = v_forward * 3000;

  if(isDefined(s_target)) {
    if(!isstruct(s_target)) {
      s_target = struct::get(s_target);
    }

    v_target = s_target.origin;
    n_radius = isDefined(float(s_target.radius)) ? float(s_target.radius) : 32;

    if(self.var_5282fb88 == 0) {
      v_target += v_right * randomfloat(n_radius);
    } else {
      v_target -= v_right * randomfloat(n_radius);
    }

    v_velocity = vectornormalize(v_target - var_bf584f29) * 3000;
  }

  self magicmissile(getweapon(#"hash_1b226dddac770884"), var_bf584f29, v_velocity);
}

function function_b7727676(var_4f7542) {
  self notify("18b40ab2fbe6ae5f");
  self endon("18b40ab2fbe6ae5f");
  var_a62d5aa5 = self.var_964b76ab;

  if(var_a62d5aa5 == var_4f7542) {
    return;
  }

  n_start_time = gettime();

  while(isDefined(self)) {
    n_current_time = gettime();
    n_time_passed = float(n_current_time - n_start_time) / 1000;
    n_percent = min(1, n_time_passed / 1);
    self.var_964b76ab = lerpfloat(var_a62d5aa5, var_4f7542, n_percent);
    self setdefaultpitch(self.var_964b76ab);

    if(n_percent >= 1) {
      break;
    }

    waitframe(1);
  }
}

function function_9f50131() {
  self endon(#"death");
  self.var_97de493f = # "hash_681bd6072c58cbb7";
  self function_1b0fcde7();
  self.a_crash_zones = struct::get_array(#"ripcord_support_huey_01", "ripcord_heli_crash_zones");
  level.var_9051f4a3.var_4817b03f = self;
  self thread function_539a07b0();
  self thread function_4d16e098();
  self thread function_22761cc0(#"hash_199c58c9616c9e5f");
  level flag::wait_till(#"hash_eeac05ac492404c");
  self setspeed(80, 40, 20);
  self thread function_f686addf();
  self function_22761cc0(#"hash_46d30825e7d91a41");
  self setspeed(50, 20, 10);
  self thread function_539a07b0();
  self thread function_4d16e098();
  self thread function_22761cc0(#"hash_70687984a0627a3e");
  level flag::wait_till(#"hash_45f5f17f37f2ef89");
  self notify(#"hash_29cc7e1c0557d2ea");
  self notify(#"hash_62eeba7b308527bd");
  self notify(#"hash_3ac6fa8c90fd94b3");
  var_1bb57bae = struct::get(#"hash_70687984a0627a3e");
  n_yaw = int(var_1bb57bae.angles[1]);
  self setgoalyaw(n_yaw);
  self settargetyaw(n_yaw);
  self function_a57c34b7(var_1bb57bae.origin, 1);
  self setgoal(var_1bb57bae.origin, 1);
  level flag::wait_till(#"hash_52752944f5336796");
  self thread function_b7727676(0);
  wait 1;
  self thread function_c97e7d1b(5);
}

function function_f686addf() {
  self endon(#"death");
  trigger::wait_till("t_ripcord_support_huey_01_strafe_breach_01", "targetname", self);
  t_trigger = getent("t_ripcord_support_huey_01_strafe_breach_01", "targetname");
  t_trigger delete();
  self notify(#"hash_62eeba7b308527bd");
  self notify(#"hash_3ac6fa8c90fd94b3");
  self thread function_f1cf27a7();
  self function_c5c81070();
  wait 1;
  self function_c5c81070();
  wait 0.25;
  self function_c5c81070();
  wait 0.25;
  self function_c5c81070();
  wait 2;
  self function_c5c81070();
  wait 0.25;
  self function_c5c81070();
  wait 1;
  self function_c5c81070();
  wait 0.5;
  self function_c5c81070();
  wait 2;
  self function_c5c81070();
  wait 0.25;
  self function_c5c81070();
  wait 0.25;
  self function_c5c81070();
  wait 0.25;
  self function_c5c81070();
  wait 2;
  self function_c5c81070();
}

function function_f1cf27a7() {
  self endon(#"death");
  self thread vehicle_ai::fire_for_time(10, 3);
  self vehicle_ai::fire_for_time(10, 4);
  self thread function_539a07b0();
}

function function_1c6687fb() {
  self endon(#"death");
  level flag::wait_till(#"hash_4723793e58855abb");
  self namespace_b7cfe907::function_5677b6eb();
  self delete();
}

function function_e6828e29() {
  self endon(#"death");
  self.var_97de493f = # "hash_681bd7072c58cd6a";
  self function_1b0fcde7();
  self.a_crash_zones = struct::get_array(#"ripcord_support_huey_02", "ripcord_heli_crash_zones");
  self thread function_22761cc0(#"hash_571e6eb87af9dfe2");
  level flag::wait_till(#"hash_490bc7407722903d");
  wait 2;
  self cleargoalyaw();
  self cleartargetyaw();
  self.var_cb55c804 = 2048;
  self setneargoalnotifydist(self.var_cb55c804);
  var_1bb57bae = struct::get(#"hash_571e6db87af9de2f");
  self function_a57c34b7(var_1bb57bae.origin, 1);
  self setgoal(var_1bb57bae.origin, 1);
  self waittill(#"goal", #"near_goal");

  if(!level flag::get(#"hash_1eb15b1c688ad333")) {
    self thread function_22761cc0(#"hash_571e6db87af9de2f");
    level flag::wait_till(#"hash_1eb15b1c688ad333");
  }

  self thread function_b7727676(0);
  self thread function_22761cc0(#"hash_64ec0ad3e5ac1f84", 1024, 0);
  wait 2.5;
  s_rpg = struct::get(#"hash_4421d602ca4050cd");
  var_bf65d868 = util::spawn_model(#"tag_origin", s_rpg.origin);
  var_5b61a3b6 = function_6588ca82(var_bf65d868, self, 1, 0, 500);
  var_5b61a3b6 setstablemissile(1);
  var_5b61a3b6 waittilltimeout(1.5, #"death", #"explode");

  if(isDefined(var_5b61a3b6)) {
    var_5b61a3b6 detonate();
  }

  var_bf65d868 delete();
  self thread function_c97e7d1b(8);
}

function function_c97e7d1b(n_delay, var_968d174e = 0) {
  self.overridevehicledamage = undefined;
  self vehicle_death::deathrollon();
  self kill();
  wait n_delay;

  if(isDefined(self)) {
    if(var_968d174e) {
      playFX(#"hash_12469565edf5ff11", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
      wait 1;
    } else {
      playFX(#"hash_764f5963981c5fec", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    }

    if(isDefined(self)) {
      self delete();
    }
  }
}

function function_432b55b() {
  self endon(#"death");
  self.var_97de493f = # "hash_681bd8072c58cf1d";
  self function_1b0fcde7(1, 0);
  self.a_crash_zones = struct::get_array(#"ripcord_support_huey_03", "ripcord_heli_crash_zones");
  self function_a57c34b7(self.origin, 1);
  self setgoal(self.origin, 1);
  self setspeed(100, 30, 15);
  self setyawspeed(50, 20, 10);
  level flag::wait_till(#"hash_490bc7407722903d");
  self function_22761cc0(#"hash_3a719158914fd1f9", 2048, 0);
  n_delay = 11.5;

  if(!level flag::get(#"hash_5b9375a85ac4aa60")) {
    self thread function_5dc6ac9f();
    level flag::wait_till(#"hash_5b9375a85ac4aa60");
    self notify(#"hash_62eeba7b308527bd");
    self notify(#"hash_3ac6fa8c90fd94b3");
    self thread function_b7727676(0);
    n_delay = 11.5;
  }

  self thread function_22761cc0(#"hash_7a4fa54f08f048fb", 2048, 0);
  self thread function_7b3c7bb1();
  wait n_delay;
  s_rpg = struct::get(#"hash_6238dc2db9dead4a");
  var_bf65d868 = util::spawn_model(#"tag_origin", s_rpg.origin);
  var_5b61a3b6 = function_6588ca82(var_bf65d868, self, 1, 0, 500);
  var_5b61a3b6 setstablemissile(1);
  var_5b61a3b6 waittilltimeout(1, #"death", #"explode");

  if(isDefined(var_5b61a3b6)) {
    var_5b61a3b6 detonate();
  }

  var_bf65d868 delete();
  self thread function_c97e7d1b(9);
}

function function_5dc6ac9f() {
  self endon(#"death");
  level endon(#"hash_5b9375a85ac4aa60");
  self thread function_22761cc0(#"hash_2353facb8e6f705a");
  self thread function_b7727676(20);
  wait 2;
  self thread function_539a07b0();
  self thread function_4d16e098();
}

function function_7b3c7bb1() {
  self endon(#"death");
  var_c044e402 = struct::get(#"hash_3c4ef86ddc8eb161");
  self turret::set_target(var_c044e402.origin, undefined, 2, 1);
  wait 3;
  self vehicle_ai::fire_for_time(8, 2);
  self turretcleartarget(2);
}

function function_ca16a858() {
  self endon(#"death");
  self.var_97de493f = # "hash_681bd1072c58c338";
  self function_1b0fcde7(1, 0);
  self.var_83bc6615 = 1;
  self function_a57c34b7(self.origin, 1);
  self setgoal(self.origin, 1);
  self setspeed(150, 50, 25);
  self setyawspeed(50, 25, 10);
  self.var_cb55c804 = 1024;
  self setneargoalnotifydist(self.var_cb55c804);
  var_1bb57bae = struct::get(#"hash_4b3cbb5b7b1b4b9e");
  self function_a57c34b7(var_1bb57bae.origin, 1);
  self setgoal(var_1bb57bae.origin, 1);
  self waittill(#"goal", #"near_goal");
  self setspeed(100, 30, 15);
  self setyawspeed(50, 20, 10);
  self thread function_b7727676(30);
  self thread function_22761cc0(var_1bb57bae);
  wait 2;
  level flag::wait_till(#"hash_5d4f3557dde7c0c8");
  self thread function_e5ecc2aa();
  level flag::wait_till(#"hash_52d13ee4dded2faf");
  self setspeed(80, 30, 15);
  self setyawspeed(80, 30, 15);
  self thread function_b7727676(20);
  self function_22761cc0(#"hash_2a4021bf052f68eb", 2048, 0);
  self thread function_539a07b0();
  self thread function_4d16e098();
  self thread function_22761cc0(#"hash_3a86125ec1904c38");
  level flag::wait_till(#"hash_1ef3a1febf52c90e");
  self thread function_1c6687fb();
  self notify(#"hash_62eeba7b308527bd");
  self notify(#"hash_3ac6fa8c90fd94b3");
  wait 6;
  self setspeed(20, 10, 5);
  self setyawspeed(20, 10, 5);
  self setmaxpitchroll(10, 30);
  self thread function_b7727676(0);
  self function_22761cc0(#"hash_50f19b29908fa95e", 1024, 0);
  self setspeed(80, 30, 15);
  self setyawspeed(80, 30, 15);
  self thread function_22761cc0(#"hash_66b73ce5b965b387", 2048, 0);
  level flag::wait_till_timeout(15, #"hash_5b2bd051ba87df67");

  while(!isalive(level.player) || level.player util::is_player_looking_at(self.origin, 0.8, 0, self, level.var_53bb8ef2.var_78bd98cb)) {
    waitframe(1);
  }

  self namespace_b7cfe907::function_5677b6eb();
  self deletedelay();
}

function function_e5ecc2aa() {
  self endon(#"death");
  s_target = struct::get(#"hash_1227fcea601eb2a");
  self function_c5c81070(s_target);
  wait 1;
  var_7c47616e = anglestoright(self.angles) * 100;
  self turret::set_target(s_target.origin - var_7c47616e, undefined, 3);
  self turret::set_target(s_target.origin + var_7c47616e, undefined, 4);
  self thread vehicle_ai::fire_for_time(3, 3);
  self thread vehicle_ai::fire_for_time(3, 4);
  self function_c5c81070(s_target);
  wait 0.25;
  self function_c5c81070(s_target);
  wait 2;
  self function_c5c81070(s_target);
  wait 0.25;
  self function_c5c81070(s_target);
  wait 0.25;
  self function_c5c81070(s_target);
  wait 2;
  self turretcleartarget(3);
  self turretcleartarget(4);
  level flag::set(#"hash_52d13ee4dded2faf");
}

function function_cfa8bf1a() {
  self endon(#"death");
  self.var_97de493f = # "hash_681bd2072c58c4eb";
  self function_1b0fcde7(1, 0);
  self.a_crash_zones = struct::get_array(#"ripcord_support_huey_05", "ripcord_heli_crash_zones");
  self function_22761cc0(#"hash_257d28ccd5ddab7d", 1024, 0);
  self thread function_b7727676(20);
  self thread function_22761cc0(#"hash_53da0b359fa2b3c9");
  wait 2;
  level flag::wait_till(#"hash_d6c4f4313d92a09");
  self thread function_6b186654();
  level flag::wait_till(#"hash_7cc817743508fef0");
  self thread function_b7727676(0);
  self thread function_22761cc0(#"hash_739bad9133512c45", 1024, 0);
  wait 3;
  s_rpg = struct::get(#"hash_9c41a1a723d6464");
  var_bf65d868 = util::spawn_model(#"tag_origin", s_rpg.origin);
  var_5b61a3b6 = function_6588ca82(var_bf65d868, self, 1, 0, 500);
  var_5b61a3b6 setstablemissile(1);
  var_5b61a3b6 waittilltimeout(1, #"death", #"explode");

  if(isDefined(var_5b61a3b6)) {
    var_5b61a3b6 detonate();
  }

  var_bf65d868 delete();
  self thread function_c97e7d1b(4);
}

function function_6b186654() {
  self endon(#"death");
  s_target = struct::get(#"hash_1efd4dcf7cebc203");
  self function_c5c81070(s_target);
  wait 1;
  var_7c47616e = anglestoright(self.angles) * 100;
  self turret::set_target(s_target.origin - var_7c47616e, undefined, 3);
  self turret::set_target(s_target.origin + var_7c47616e, undefined, 4);
  self thread vehicle_ai::fire_for_time(3, 3);
  self thread vehicle_ai::fire_for_time(3, 4);
  self function_c5c81070(s_target);
  wait 0.25;
  self function_c5c81070(s_target);
  wait 2;
  self function_c5c81070(s_target);
  wait 0.25;
  self function_c5c81070(s_target);
  wait 0.25;
  self function_c5c81070(s_target);
  wait 2;
  self turretcleartarget(3);
  self turretcleartarget(4);
  level flag::set(#"hash_7cc817743508fef0");
}

function function_7c0da395() {
  level.var_9051f4a3 endon(#"skipped");
  s_waitresult = level flag::wait_till_any([# "hash_71d2b27628b98956", #"hash_704543df3c4e06bc"]);
  function_9b9ad0ab("sp_ripcord_rpg_huey", &function_4112226, 1);
}

function function_4112226(var_9ff20235 = 1) {
  self endon(#"death");
  self.var_97de493f = # "hash_681bd3072c58c69e";
  self function_1b0fcde7(1, 10);
  self.a_crash_zones = struct::get_array(#"ripcord_rpg_huey", "ripcord_heli_crash_zones");
  s_start = struct::get(#"hash_5c43cfcac08b9ec3");
  var_8be533d2 = # "hash_45296b8f85fbfa9e";
  var_262212e0 = 1;
  var_42b5e5c1 = 2.5;

  if(!var_9ff20235) {
    s_start = struct::get(#"hash_70aaa0728e68d78f");
    var_8be533d2 = # "hash_6ef61f17ca57df64";
    var_262212e0 = 1.5;
    var_42b5e5c1 = 4.5;
  }

  self.origin = s_start.origin;
  self.angles = s_start.angles;
  self function_a57c34b7(s_start.origin, 1);
  self setgoal(s_start.origin, 1);
  self setspeed(150, 50, 25);
  self setyawspeed(50, 25, 10);
  self setmaxpitchroll(0, 80);

  while(!level flag::get(#"hash_374dd1a0e9ce31c") && isalive(level.player) && !level.player util::is_player_looking_at(self.origin, 0.8, 1, self, level.var_53bb8ef2.var_78bd98cb)) {
    waitframe(1);
  }

  level flag::set(#"hash_374dd1a0e9ce31c");
  self thread function_22761cc0(var_8be533d2, 1024, 0);
  wait var_262212e0;
  s_rpg = struct::get(#"hash_53d4da730fa16cd6");
  util::delay(1.5, undefined, &playfx, #"hash_1f198f210dbcc8db", s_rpg.origin, anglesToForward(s_rpg.angles), anglestoup(s_rpg.angles));
  var_bf65d868 = util::spawn_model(#"tag_origin", s_rpg.origin);
  var_5b61a3b6 = function_6588ca82(var_bf65d868, self, 1, 0, 500);
  var_5b61a3b6 setstablemissile(1);
  var_5b61a3b6 waittilltimeout(3, #"death", #"explode");

  if(isDefined(var_5b61a3b6)) {
    var_5b61a3b6 detonate();
  }

  var_bf65d868 delete();
  self thread function_b7727676(0);
  self thread function_8cbe2fb2(var_42b5e5c1);
}

function function_8cbe2fb2(var_42b5e5c1) {
  self vehicle_death::death_fx();
  self vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
  self thread vehicle_death::helicopter_crash();
  wait var_42b5e5c1;

  if(isDefined(self)) {
    self notify(#"crash_done");
    self notify(#"crash_move_done");
    playFXOnTag(#"hash_764f5963981c5fec", self, "tag_body");
    playFXOnTag(#"hash_6ca050a42ba76baa", self, "tag_body");
    self vehicle_ai::gibbed_death();

    if(isalive(self)) {
      self kill();
    }
  }
}

function function_6588ca82(e_source, e_target, var_c81911e = 0, var_855e955d = 1, var_66732ef3 = 2000) {
  var_f4de797f = getweapon(#"hash_1e25706a023b5e09");
  v_source = e_source.origin;

  if(isactor(e_source)) {
    v_source = e_source function_204d1e9a();
  }

  v_velocity = vectornormalize(e_target.origin - v_source) * var_66732ef3;

  if(var_c81911e) {
    var_5b61a3b6 = e_source magicmissile(var_f4de797f, v_source, v_velocity, e_target);
  } else {
    var_5b61a3b6 = e_source magicmissile(var_f4de797f, v_source, v_velocity);
  }

  if(var_855e955d) {
    level thread function_7d2ad92b(var_5b61a3b6);
  }

  return var_5b61a3b6;
}

function function_7d2ad92b(var_5b61a3b6) {
  if(!isDefined(var_5b61a3b6)) {
    return;
  }

  var_5b61a3b6 endon(#"death", #"explode");
  wait 2;
  var_5b61a3b6 detonate();
}

function function_a3c825cd() {
  self notify("7d8f11505232db7f");
  self endon("7d8f11505232db7f");
  self endon(#"death", #"hash_276be8c3ece06e32");

  if(getdvarint(#"hash_3b90a67ea0b6081b", 0) >= 2) {
    return;
  }

  var_f4de797f = getweapon(#"hash_1e25706a023b5e09");

  if(self.weapon != var_f4de797f) {
    return;
  }

  self.holdfire = 1;
  var_9051f4a3 = level.var_9051f4a3;
  var_78bd98cb = level.var_53bb8ef2.var_78bd98cb;

  while(true) {
    if(!self isatgoal()) {
      self waittill(#"goal");
      wait 1;
    }

    while(!self function_8c4583b()) {
      wait 0.1;
    }

    while(self function_8c4583b()) {
      if(is_true(var_9051f4a3.var_6a3bc516)) {
        wait 0.1;
        continue;
      }

      var_9051f4a3.var_6a3bc516 = 1;
      level thread function_f14ccc68();

      if(false) {
        var_5b61a3b6 = function_6588ca82(self, var_78bd98cb, 1);
        var_9051f4a3.var_cf754a79 = 1;
        level thread function_945d2383(var_5b61a3b6);
      } else {
        function_6588ca82(self, var_78bd98cb);
      }

      wait randomfloatrange(4, 5);
    }
  }
}

function function_8c4583b() {
  if(level.player isnotarget()) {
    return false;
  }

  var_78bd98cb = level.var_53bb8ef2.var_78bd98cb;

  if(!isDefined(var_78bd98cb)) {
    return false;
  }

  if(is_true(self.ignoreall) || !self isatgoal()) {
    return false;
  }

  if(distancesquared(self.origin, var_78bd98cb.origin) > sqr(8000)) {
    return false;
  }

  if(!bullettracepassed(self function_204d1e9a(), var_78bd98cb.origin, 1, var_78bd98cb)) {
    return false;
  }

  return true;
}

function function_204d1e9a() {
  return self gettagorigin("tag_flash") + anglesToForward(self.angles) * 64;
}

function function_f14ccc68() {
  var_9051f4a3 = level.var_9051f4a3;
  var_9051f4a3 endon(#"skipped");
  wait 0.6;
  var_9051f4a3.var_6a3bc516 = 0;
}

function function_945d2383(var_5b61a3b6) {
  var_9051f4a3 = level.var_9051f4a3;
  var_9051f4a3 endon(#"skipped");

  while(isDefined(var_5b61a3b6)) {
    waitframe(1);
  }

  wait 4;
  var_9051f4a3.var_cf754a79 = 0;
}

function function_ef4f929e(var_27240fa9) {
  var_9051f4a3 = level.var_9051f4a3;
  var_9051f4a3 endon(#"skipped");
  var_9051f4a3.var_5f448549 = [];
  var_9051f4a3.var_c5b0c2c8 = var_27240fa9;
  level flag::wait_till(#"hash_2c292d90841ea555");
  setDvar(#"hash_367578d4c1c78030", 500);
  a_ai_spawned = function_aa2f407c("sp_ripcord_cliff_defenders", undefined, 0, 1, &function_7c5d5d43);
  var_9051f4a3.var_5f448549 = a_ai_spawned;
}

function function_7c5d5d43() {
  self endon(#"death");
  self val::set(#"hash_1836e54ed9ab516", "ignoreall", 1);
  level flag::wait_till(#"hash_6aff13acab5241ed");
  wait randomfloatrange(0.1, 0.2);
  self val::reset(#"hash_1836e54ed9ab516", "ignoreall");
  self function_c9e47ce7();
  nd_current = self.goalnode;
  nd_next = getnode(nd_current.target, "targetname");
  self setgoal(nd_next, 1);
  self waittill(#"goal");
  wait randomfloatrange(0.1, 0.2);
  level flag::wait_till(#"hash_5591beeee14423dd");
  wait randomfloatrange(0.1, 0.3);
  nd_current = self.goalnode;
  var_df0210a2 = getnode(nd_current.target, "targetname");
  self setgoal(var_df0210a2, 1);
}

function function_b72590f1(var_a21e5c7c) {
  var_9051f4a3 = level.var_9051f4a3;
  var_9051f4a3 endon(#"skipped");
  var_9051f4a3.var_24e3ce59 = var_a21e5c7c;
  var_9051f4a3.var_f3b33549 = [];
  level flag::wait_till(#"hash_624585ec0b1e15fa");
  var_2e0881c2 = [];
  var_9a845ac0 = [];
  var_9c7a34dc = arraycombine(var_2e0881c2, var_9a845ac0);
  var_9051f4a3.var_f3b33549 = var_9c7a34dc;
}

function function_c31eac23(var_cbb940ec) {
  level.var_9051f4a3 endon(#"skipped");

  if(var_cbb940ec.size > 0) {
    if(!level flag::get(#"hash_4738db7348240118")) {
      level thread function_5bb71d52(var_cbb940ec);
      level flag::wait_till(#"hash_4738db7348240118");
    }

    function_1eaaceab(var_cbb940ec);

    if(var_cbb940ec.size > 0) {
      foreach(var_cd75ffd6 in var_cbb940ec) {
        var_cd75ffd6 resumespeed();
      }

      level flag::wait_till(#"hash_27538459b6861212");
      function_1eaaceab(var_cbb940ec);

      foreach(var_cd75ffd6 in var_cbb940ec) {
        if(isalive(var_cd75ffd6)) {
          level flag::set(#"hash_2a99d75e7a14ef29");
          var_cd75ffd6 kill();
          wait randomfloatrange(0.1, 1);
        }
      }
    }
  }
}

function function_ede2a394(var_3368b534 = 1) {
  self endon(#"death");

  if(!isDefined(level.var_9051f4a3.var_51ae0380)) {
    level.var_9051f4a3.var_51ae0380 = [];
  } else if(!isarray(level.var_9051f4a3.var_51ae0380)) {
    level.var_9051f4a3.var_51ae0380 = array(level.var_9051f4a3.var_51ae0380);
  }

  level.var_9051f4a3.var_51ae0380[level.var_9051f4a3.var_51ae0380.size] = self;

  if(self.vehicletype == # "hash_3677daa34d36098a") {
    a_spawners = getspawnerarray("sp_ripcord_north_face_convoy_riders", "targetname");

    for(i = 0; i < 8; i++) {
      spawner = array::random(a_spawners);

      while(true) {
        var_4e75a347 = spawner::simple_spawn_single(spawner, &function_f6b45548, self);

        if(isDefined(var_4e75a347)) {
          break;
        }

        waitframe(1);
      }
    }
  }

  if(var_3368b534) {
    trigger::wait_till("t_ripcord_north_face_convoys_kill", "targetname", self, 0);
    self kill();
  }
}

function function_f6b45548(var_ff72be84) {
  self endon(#"death");
  self vehicle::get_in(self, var_ff72be84, "crew");
}

function function_5bb71d52(var_cbb940ec) {
  level.var_9051f4a3 endon(#"skipped");
  level endon(#"hash_4738db7348240118", #"hash_27538459b6861212");

  while(isalive(level.player) && var_cbb940ec.size > 0) {
    while(isalive(level.player) && var_cbb940ec.size > 0) {
      var_5168e40f = 0;
      function_1eaaceab(var_cbb940ec);

      foreach(var_cd75ffd6 in var_cbb940ec) {
        if(level.player util::is_player_looking_at(var_cd75ffd6 getcentroid(), 0.8, 0, var_cd75ffd6, level.var_53bb8ef2.var_78bd98cb)) {
          var_5168e40f = 1;
          break;
        }
      }

      if(!var_5168e40f) {
        break;
      }

      waitframe(1);
    }

    function_1eaaceab(var_cbb940ec);

    foreach(var_cd75ffd6 in var_cbb940ec) {
      var_cd75ffd6 setspeedimmediate(0);
    }

    while(isalive(level.player) && var_cbb940ec.size > 0) {
      var_5168e40f = 0;
      function_1eaaceab(var_cbb940ec);

      foreach(var_cd75ffd6 in var_cbb940ec) {
        if(level.player util::is_player_looking_at(var_cd75ffd6 getcentroid(), 0.8, 0, var_cd75ffd6, level.var_53bb8ef2.var_78bd98cb)) {
          var_5168e40f = 1;
          break;
        }
      }

      if(var_5168e40f) {
        break;
      }

      waitframe(1);
    }

    function_1eaaceab(var_cbb940ec);

    foreach(var_cd75ffd6 in var_cbb940ec) {
      var_cd75ffd6 resumespeed();
    }
  }
}

function function_2a10e512() {
  level.var_9051f4a3 endon(#"skipped");
  level endon(#"hash_2dfb720e0ae80724");

  while(true) {
    wait 1;

    foreach(var_4e75a347 in getfakeaiarray()) {
      if(is_true(var_4e75a347.drone.isdead) && isDefined(level.player) && !level.player util::is_player_looking_at(var_4e75a347.origin, 0.8, 1, var_4e75a347, level.var_53bb8ef2.var_78bd98cb)) {
        var_4e75a347 delete();
      }
    }
  }
}

function function_335f38a0(var_4e75a347) {
  return !isDefined(var_4e75a347) || is_true(var_4e75a347.drone.isdead);
}

function function_e16259ed(var_4180f434) {
  if(!isDefined(var_4180f434)) {
    return [];
  }

  for(i = 0; i < var_4180f434.size; i++) {
    if(function_335f38a0(var_4180f434[i])) {
      var_4180f434[i] = -1;
    }
  }

  arrayremovevalue(var_4180f434, -1);
  return var_4180f434;
}

function function_a98e77d5(str_name, var_de4a9f7a, var_62e5c9d9, var_f532cfce, var_9e70224a, var_3ba94e96, var_4a90b33c) {
  s_breach = spawnStruct();
  s_breach.var_4180f434 = [];
  s_breach.var_de4a9f7a = var_de4a9f7a;
  s_breach.var_62e5c9d9 = var_62e5c9d9;
  level.var_9051f4a3.var_6ae38a69[str_name] = s_breach;
  level thread function_cece544c(str_name, var_62e5c9d9, var_f532cfce, var_9e70224a, var_3ba94e96, var_4a90b33c);
}

function function_d1490330(str_name, var_de4a9f7a) {
  s_breach = level.var_9051f4a3.var_6ae38a69[str_name];
  s_breach.var_de4a9f7a = var_de4a9f7a;
}

function function_cece544c(str_name, var_62e5c9d9, var_f532cfce, var_9e70224a, var_3ba94e96, var_4a90b33c) {
  var_9051f4a3 = level.var_9051f4a3;
  var_9051f4a3 endon(#"skipped");
  level endon(#"hash_2dfb720e0ae80724", #"hash_6e5d171aabf4f2f9");
  s_breach = var_9051f4a3.var_6ae38a69[str_name];
  var_7c192175 = struct::get_array(var_f532cfce);
  var_46e5370e = struct::get_array(var_9e70224a);
  a_spawners = getspawnerarray(var_3ba94e96, "targetname");
  var_d36bacb3 = array::randomize(var_7c192175);
  var_f766cd1c = array::randomize(var_46e5370e);

  if(isDefined(var_4a90b33c)) {
    var_2df413d3 = getent(var_4a90b33c, "targetname");
  }

  while(!level flag::get(var_62e5c9d9)) {
    arrayremovevalue(var_9051f4a3.var_b6fdd6f2, undefined);
    var_2b48934b = function_cf993931(str_name);
    var_de4a9f7a = function_6a618669(str_name);
    var_eabc4a23 = var_2b48934b.size;

    if(var_eabc4a23 < var_de4a9f7a) {
      if(math::cointoss()) {
        if(var_d36bacb3.size <= 0) {
          var_d36bacb3 = array::randomize(var_7c192175);
        }

        s_spawn = var_d36bacb3[0];
        arrayremoveindex(var_d36bacb3, 0);
      } else {
        if(var_f766cd1c.size <= 0) {
          var_f766cd1c = array::randomize(var_46e5370e);
        }

        s_spawn = var_f766cd1c[0];
        arrayremoveindex(var_f766cd1c, 0);
      }

      spawner = array::random(a_spawners);
      spawner.origin = s_spawn.origin;
      spawner.angles = s_spawn.angles;
      spawner.target = s_spawn.target;
      spawner.script_moveplaybackrate = 0.75;
      var_4e75a347 = spawner::simple_spawn_single(spawner, &function_158cdaa, s_spawn);

      if(isDefined(var_4e75a347)) {
        var_4e75a347.var_36ceff65 = 1;

        if(!isDefined(var_9051f4a3.var_6ae38a69[str_name].var_4180f434)) {
          var_9051f4a3.var_6ae38a69[str_name].var_4180f434 = [];
        } else if(!isarray(var_9051f4a3.var_6ae38a69[str_name].var_4180f434)) {
          var_9051f4a3.var_6ae38a69[str_name].var_4180f434 = array(var_9051f4a3.var_6ae38a69[str_name].var_4180f434);
        }

        var_9051f4a3.var_6ae38a69[str_name].var_4180f434[var_9051f4a3.var_6ae38a69[str_name].var_4180f434.size] = var_4e75a347;
        var_4e75a347.var_1eca86c3 = str_name;

        if(math::cointoss(75)) {
          var_4e75a347 namespace_4e75a347::function_cab4b520("ALERT");
        } else {
          var_4e75a347 thread function_2176dc7e();
        }

        if(isDefined(var_2df413d3)) {
          var_4e75a347 thread function_21cf9a54(var_2df413d3);
        }
      }
    }

    wait randomfloatrange(0.05, 0.15);
  }
}

function function_248d029() {
  var_9051f4a3 = level.var_9051f4a3;
  var_9051f4a3 endon(#"skipped");
  var_78bd98cb = level.var_53bb8ef2.var_78bd98cb;

  foreach(str_name, s_breach in var_9051f4a3.var_6ae38a69) {
    var_2b48934b = function_cf993931(str_name);

    for(var_de4a9f7a = function_6a618669(str_name); var_2b48934b.size > 0 && var_2b48934b.size > var_de4a9f7a; var_de4a9f7a = function_6a618669(str_name)) {
      ai_cleanup = arraygetfarthest(var_78bd98cb.origin, var_2b48934b);
      ai_cleanup function_a2798ad7();
      ai_cleanup kill();
      waitframe(1);
      var_2b48934b = function_cf993931(var_2b48934b);
    }
  }
}

function function_cf993931(str_name) {
  s_breach = level.var_9051f4a3.var_6ae38a69[str_name];

  if(!isDefined(s_breach)) {
    return [];
  }

  s_breach.var_4180f434 = function_e16259ed(s_breach.var_4180f434);
  return s_breach.var_4180f434;
}

function function_6a618669(str_name) {
  return level.var_9051f4a3.var_6ae38a69[str_name].var_de4a9f7a;
}

function function_2176dc7e() {
  self endon(#"death", #"hash_276eb2b6c51bf236");

  while(true) {
    wait randomfloatrange(0.5, 1);
    n_shots = randomintrangeinclusive(1, 5);

    for(i = 0; i < n_shots; i++) {
      playFXOnTag(#"weapon/fx8_muz_ar_acc_3p", self, "tag_flash");

      if(i + 1 < n_shots) {
        wait 0.05;
      }
    }
  }
}

function function_21cf9a54(var_2df413d3) {
  self endon(#"death");

  while(!self istouching(var_2df413d3)) {
    waitframe(1);
  }

  var_2b7aa68e = randomfloatrange(1, 5);
  self thread function_49bddccd(var_2b7aa68e);
  self waittill(#"hash_276eb2b6c51bf236");
  var_e57270d7 = randomfloatrange(1, 4);
  self thread function_49bddccd(var_e57270d7);
}

function function_49bddccd(n_delay) {
  self notify("3e62beeaf0c9295e");
  self endon("3e62beeaf0c9295e");
  self endon(#"death");
  wait n_delay;
  self function_a2798ad7();
  self kill();
}

function function_a2798ad7() {
  if(isDefined(self.drone.var_544c8017)) {
    var_c2edc777 = [# "hash_2cfd60bac064ea72", #"hash_2cfd5fbac064e8bf", #"hash_2cfd5ebac064e70c"];
  } else if(self.drone.stance === "cover_crouch") {
    var_c2edc777 = [# "hash_1937ee9d43631333", #"hash_1937ef9d436314e6", #"hash_1937f09d43631699"];
  } else {
    var_c2edc777 = [# "hash_707322f7c079704d", #"hash_70731ff7c0796b34", #"hash_707320f7c0796ce7"];
  }

  if(isDefined(var_c2edc777)) {
    self.drone.noragdoll = 1;
    self.drone.deathanim = array::random(var_c2edc777);
  }
}

function function_e53ae863(str_spawns) {
  a_s_spawns = struct::get_array(str_spawns);

  foreach(s_spawn in a_s_spawns) {
    s_spawn.var_29894783 = util::spawn_model(#"tag_origin", s_spawn.origin, s_spawn.angles);
    playFXOnTag(#"hash_4aeb2425485e527", s_spawn.var_29894783, "tag_origin");

    if(!isDefined(level.var_9051f4a3.var_cd3317e9)) {
      level.var_9051f4a3.var_cd3317e9 = [];
    } else if(!isarray(level.var_9051f4a3.var_cd3317e9)) {
      level.var_9051f4a3.var_cd3317e9 = array(level.var_9051f4a3.var_cd3317e9);
    }

    level.var_9051f4a3.var_cd3317e9[level.var_9051f4a3.var_cd3317e9.size] = s_spawn;
  }
}

function function_b7c8bf68(str_spawns) {
  if(!isDefined(str_spawns)) {
    a_s_spawns = isDefined(level.var_9051f4a3.var_cd3317e9) ? level.var_9051f4a3.var_cd3317e9 : [];
  } else {
    a_s_spawns = struct::get_array(str_spawns);
  }

  foreach(s_spawn in a_s_spawns) {
    if(isDefined(s_spawn.var_29894783)) {
      s_spawn.var_29894783 delete();
    }
  }
}

function function_9aecf345() {
  var_c37e0cf5 = struct::get_array(#"hash_6bd970367d86682e");
  var_c37e0cf5 = array::sort_by_script_int(var_c37e0cf5, 1);

  foreach(i, var_85e471f5 in var_c37e0cf5) {
    playFX(#"hash_68a62bc3d5b15568", var_85e471f5.origin);

    if(i == 0) {
      wait 1;
      continue;
    }

    wait 0.5;
  }
}

function function_43a56026() {
  var_9051f4a3 = level.var_9051f4a3;
  var_9051f4a3 endon(#"skipped");
  a_spawners = getspawnerarray("sp_ripcord_breach_02_line_battle", "targetname");
  a_s_spawns = struct::get_array(#"hash_11242b0fdc2d3200");
  a_s_remaining = array::randomize(a_s_spawns);
  var_b88b12ff = [];

  while(!level flag::get(#"hash_44b60e500cfd1235")) {
    var_9051f4a3.var_8f7933bf = function_e16259ed(var_9051f4a3.var_8f7933bf);

    if(var_b88b12ff.size < a_s_spawns.size && var_9051f4a3.var_8f7933bf.size < var_9051f4a3.var_3f0cf76d) {
      if(a_s_remaining.size <= 0) {
        a_s_remaining = array::randomize(a_s_spawns);
      }

      s_spawn = a_s_remaining[0];
      arrayremoveindex(a_s_remaining, 0);
      spawner = array::random(a_spawners);
      spawner.origin = s_spawn.origin;
      spawner.angles = s_spawn.angles;
      spawner.target = s_spawn.target;
      spawner.script_moveplaybackrate = 0.75;
      var_4e75a347 = spawner::simple_spawn_single(spawner, &function_e5184fac);

      if(isDefined(var_4e75a347)) {
        if(!isDefined(var_b88b12ff)) {
          var_b88b12ff = [];
        } else if(!isarray(var_b88b12ff)) {
          var_b88b12ff = array(var_b88b12ff);
        }

        var_b88b12ff[var_b88b12ff.size] = var_4e75a347;

        if(!isDefined(var_9051f4a3.var_8f7933bf)) {
          var_9051f4a3.var_8f7933bf = [];
        } else if(!isarray(var_9051f4a3.var_8f7933bf)) {
          var_9051f4a3.var_8f7933bf = array(var_9051f4a3.var_8f7933bf);
        }

        var_9051f4a3.var_8f7933bf[var_9051f4a3.var_8f7933bf.size] = var_4e75a347;
      }
    }

    wait randomfloatrange(0.5, 1);
  }
}

function function_e5184fac() {
  self endon(#"death");
  self function_158cdaa();
  self.var_1eca86c3 = # "breach_02";
  wait randomfloatrange(10, 15);
  self kill();
}

function function_755d640() {
  var_c37e0cf5 = struct::get_array("s_ripcord_ambient_explosions");

  foreach(var_85e471f5 in var_c37e0cf5) {
    var_85e471f5 thread function_ae163871();
  }
}

function function_ae163871() {
  level.var_9051f4a3 endon(#"skipped");
  level endon(#"hash_2dfb720e0ae80724", #"hash_1ef3a1febf52c90e");
  self.radius = float(self.radius);
  v_angles = (270, 0, 0);
  v_forward = anglesToForward(v_angles);
  v_up = anglestoup(v_angles);

  while(true) {
    wait randomfloatrange(30, 60);
    n_x = randomfloat(self.radius);

    if(math::cointoss()) {
      n_x *= -1;
    }

    n_y = randomfloat(self.radius);

    if(math::cointoss()) {
      n_y *= -1;
    }

    v_trace = self.origin + (n_x, n_y, 3000);
    a_trace = groundtrace(v_trace, v_trace - (0, 0, 4000), 0, level.var_53bb8ef2.var_78bd98cb);

    if(isDefined(a_trace[# "position"]) && !isDefined(a_trace[# "entity"])) {
      playFX(#"hash_7e60569db9c36606", a_trace[# "position"], v_forward, v_up);
    }
  }
}

function function_faa719f() {
  var_9051f4a3 = level.var_9051f4a3;
  var_9051f4a3 endon(#"skipped");
  level endon(#"hash_2dfb720e0ae80724");
  var_9051f4a3.var_69fc4412[# "drone"] = struct::get_array(#"hash_747ff813bf06bdb4");
  var_9051f4a3.var_69fc4412[# "drone_moving"] = struct::get_array(#"hash_7af19991cf0b004b");
  var_9051f4a3.var_69fc4412[# "real"] = struct::get_array(#"hash_4fb99e4c2563a902");
  var_9051f4a3.var_69fc4412[# "real_moving"] = struct::get_array(#"hash_29dfe0db030ec589");

  foreach(str_type, a_s_spawns in var_9051f4a3.var_69fc4412) {
    foreach(s_spawn in a_s_spawns) {
      s_spawn.var_a1fc8c0d = gettime();
      s_spawn.var_c9a1df52 = str_type;
    }
  }

  var_f8308ae = getspawnerarray("sp_ripcord_ambient_vc_drone", "targetname");
  var_8a4dcdc9 = getspawnerarray("sp_ripcord_ambient_vc_drone_moving", "targetname");
  var_6219ad55 = getspawnerarray("sp_ripcord_ambient_vc_real", "targetname");

  while(true) {
    foreach(var_86e408fb in var_9051f4a3.var_69fc4412[# "drone"]) {
      function_bd6bc5e1(var_86e408fb, var_f8308ae);
    }

    foreach(var_8f636700 in var_9051f4a3.var_69fc4412[# "drone_moving"]) {
      function_bd6bc5e1(var_8f636700, var_8a4dcdc9, 1);
    }

    foreach(var_87347f49 in var_9051f4a3.var_69fc4412[# "real"]) {
      function_977d452c(var_87347f49, var_6219ad55);
    }

    foreach(var_fc711531 in var_9051f4a3.var_69fc4412[# "real_moving"]) {
      function_977d452c(var_fc711531, var_6219ad55, 1);
    }

    wait 1;
  }
}

function function_bd6bc5e1(s_spawn, a_spawners, var_e81f32c5 = 0) {
  var_9051f4a3 = level.var_9051f4a3;

  if(is_true(s_spawn.b_disabled)) {
    arrayremovevalue(var_9051f4a3.var_69fc4412[s_spawn.var_c9a1df52], s_spawn);
    return;
  }

  if(!isDefined(s_spawn.var_4e75a347) || is_true(s_spawn.var_4e75a347.drone.isdead)) {
    n_dist = sqr(8000);

    if(isDefined(level.var_53bb8ef2.var_78bd98cb)) {
      n_dist = distance2dsquared(s_spawn.origin, level.var_53bb8ef2.var_78bd98cb.origin);
    }

    if(n_dist >= sqr(8000) || isalive(level.player) && !level.player util::is_player_looking_at(s_spawn.origin, 0.8, 1, level.var_53bb8ef2.var_78bd98cb)) {
      v_spawn = s_spawn.origin;

      if(!var_e81f32c5) {
        v_spawn -= (0, 0, 64);
      }

      spawner = array::random(a_spawners);
      spawner.origin = v_spawn;
      spawner.angles = s_spawn.angles;
      spawner.target = s_spawn.target;
      s_spawn.var_4e75a347 = spawner::simple_spawn_single(spawner, &function_6cf6a8c2, s_spawn);

      if(isDefined(s_spawn.var_4e75a347)) {
        if(!isDefined(var_9051f4a3.var_b6fdd6f2)) {
          var_9051f4a3.var_b6fdd6f2 = [];
        } else if(!isarray(var_9051f4a3.var_b6fdd6f2)) {
          var_9051f4a3.var_b6fdd6f2 = array(var_9051f4a3.var_b6fdd6f2);
        }

        var_9051f4a3.var_b6fdd6f2[var_9051f4a3.var_b6fdd6f2.size] = s_spawn.var_4e75a347;
        s_spawn.var_4e75a347.var_36ceff65 = 1;
        s_spawn.var_4e75a347.var_1adf387f = s_spawn;

        if(math::cointoss(75)) {
          s_spawn.var_4e75a347 namespace_4e75a347::function_cab4b520("ALERT");
        }

        s_spawn.var_a1fc8c0d = gettime();

        if(var_e81f32c5) {
          s_spawn.var_4e75a347 thread function_69f58ded(s_spawn);
        }
      }
    }

    return;
  }

  n_lifetime = randomfloat(120);

  if(float(gettime() - s_spawn.var_a1fc8c0d) / 1000 >= n_lifetime) {
    s_spawn.var_4e75a347 kill();
  }
}

function function_69f58ded(s_spawn) {
  self endon(#"death");
  self thread namespace_4e75a347::drone_fight(s_spawn.script_noteworthy);
  wait randomfloat(5);
  self notify(#"hash_1b1ebb63b6197fd7");
  self animation::stop(0, 1);
  waitframe(1);
  self notify(#"move");
}

function function_977d452c(s_spawn, a_spawners, var_e81f32c5 = 0) {
  var_9051f4a3 = level.var_9051f4a3;

  if(is_true(s_spawn.b_disabled)) {
    arrayremovevalue(var_9051f4a3.var_69fc4412[s_spawn.var_c9a1df52], s_spawn);
    return;
  }

  if(!isalive(s_spawn.ai_spawned)) {
    n_dist = sqr(8000);

    if(isDefined(level.var_53bb8ef2.var_78bd98cb)) {
      n_dist = distance2dsquared(s_spawn.origin, level.var_53bb8ef2.var_78bd98cb.origin);
    }

    if(n_dist >= sqr(8000) || isalive(level.player) && !level.player util::is_player_looking_at(s_spawn.origin, 0.8, 1, level.var_53bb8ef2.var_78bd98cb)) {
      s_spawn.ai_spawned = spawner::simple_spawn_single(array::random(a_spawners), &function_6cf6a8c2, s_spawn, !var_e81f32c5, 0);

      if(isDefined(s_spawn.ai_spawned)) {
        if(!isDefined(var_9051f4a3.var_b6fdd6f2)) {
          var_9051f4a3.var_b6fdd6f2 = [];
        } else if(!isarray(var_9051f4a3.var_b6fdd6f2)) {
          var_9051f4a3.var_b6fdd6f2 = array(var_9051f4a3.var_b6fdd6f2);
        }

        var_9051f4a3.var_b6fdd6f2[var_9051f4a3.var_b6fdd6f2.size] = s_spawn.ai_spawned;
        s_spawn.ai_spawned.var_36ceff65 = 1;
        s_spawn.ai_spawned.var_1adf387f = s_spawn;
        s_spawn.ai_spawned function_68c964c3(s_spawn);
        s_spawn.ai_spawned.grenadeammo = 0;
        s_spawn.var_a1fc8c0d = gettime();

        if(var_e81f32c5) {
          s_spawn.ai_spawned thread function_59bffb65(s_spawn);
        }
      }
    }

    return;
  }

  n_lifetime = randomfloat(120);

  if(float(gettime() - s_spawn.var_a1fc8c0d) / 1000 >= n_lifetime) {
    s_spawn.ai_spawned kill();
  }
}

function function_59bffb65(s_spawn) {
  self endon(#"death");
  goal = struct::get(s_spawn.target);

  if(!isDefined(goal)) {
    goal = getnode(s_spawn.target, "targetname");
  }

  if(!isDefined(goal)) {
    return;
  }

  self setdesiredspeed("sprint");
  var_f77fa2d4 = math::cointoss(75);

  if(!var_f77fa2d4) {
    var_4f401c38 = goal.target;

    while(isDefined(var_4f401c38)) {
      next_goal = struct::get(var_4f401c38);

      if(!isDefined(next_goal)) {
        next_goal = getnode(var_4f401c38, "targetname");
      }

      if(isDefined(next_goal.target)) {
        var_4f401c38 = next_goal.target;
        continue;
      }

      break;
    }

    if(!isDefined(var_4f401c38)) {
      var_4f401c38 = goal.targetname;
    }

    var_d55bf3de = struct::get(var_4f401c38);

    if(!isDefined(var_d55bf3de)) {
      var_d55bf3de = getnode(var_4f401c38, "targetname");
    }
  }

  wait randomfloat(5);

  if(var_f77fa2d4) {
    self clearentitytarget();
    self val::set(#"hash_1836e54ed9ab516", "ignoreall", 1);
  } else if(isDefined(var_d55bf3de)) {
    self function_68c964c3(var_d55bf3de);
  }

  self thread spawner::go_to_node(goal);

  if(var_f77fa2d4) {
    self waittill(#"reached_path_end");
    self function_68c964c3(self.goalnode);
    self val::reset(#"hash_1836e54ed9ab516", "ignoreall");
  }
}

function function_68c964c3(var_8d075cb6 = self) {
  var_fa4eb7a2 = level.var_9051f4a3.var_fa4eb7a2[util::get_enemy_team(self.team)];
  arrayremovevalue(var_fa4eb7a2, undefined);

  foreach(var_2cd0eff2 in var_fa4eb7a2) {
    if(var_8d075cb6 math::get_dot_forward(var_2cd0eff2.origin, 1) <= 0.3) {
      self setignoreent(var_2cd0eff2, 1);
    }
  }
}

function function_c3e83ca1() {
  level.var_9051f4a3 endon(#"skipped");
  level endon(#"hash_2dfb720e0ae80724");
  var_417d6b44 = struct::get_array(#"hash_44e31e4fbb8893a7");

  foreach(var_91da74ae in var_417d6b44) {
    var_91da74ae.n_time_since_last_shot = 0;
  }

  w_weapon = getweapon(#"hash_4ff481a4f55ed901");
  var_7fa7e662 = util::spawn_model(#"tag_origin");
  var_7fa7e662 setteam(#"allies");

  while(true) {
    foreach(var_91da74ae in var_417d6b44) {
      n_delay = randomfloatrange(0.1, 1);

      if(var_91da74ae.n_time_since_last_shot >= n_delay) {
        v_source = var_91da74ae.origin;
        v_angles = var_91da74ae.angles;

        for(i = 0; i < 2; i++) {
          v_offset = (0, 0, 0);

          for(j = 0; j < 3; j++) {
            n_offset = randomfloat(16);

            if(math::cointoss()) {
              n_offset *= -1;
            }

            switch (j) {
              case 0:
                v_offset += (n_offset, 0, 0);
                break;
              case 1:
                v_offset += (0, n_offset, 0);
                break;
              case 2:
                v_offset += (0, 0, n_offset);
                break;
            }
          }

          switch (i) {
            case 0:
              v_source += v_offset;
              break;
            case 1:
              v_angles += v_offset;
              break;
          }
        }

        magicbullet(w_weapon, v_source, v_source + anglesToForward(v_angles) * 1024, var_7fa7e662);
        var_91da74ae.n_time_since_last_shot = 0;
        continue;
      }

      var_91da74ae.n_time_since_last_shot += 0.1;
    }

    wait 0.1;
  }
}

function function_2f5a4827() {
  var_9051f4a3 = level.var_9051f4a3;
  var_9051f4a3 endon(#"skipped");
  level endon(#"hash_2dfb720e0ae80724");
  var_773577b4 = getspawnerarray("sp_ripcord_ambient_runners", "targetname");
  var_be4cdc25 = struct::get_array(#"hash_20ac5ee2789b6399");

  foreach(var_bd01b58f in var_be4cdc25) {
    if(!isDefined(var_bd01b58f.min_spawns)) {
      var_bd01b58f.min_spawns = 1;
    }

    if(!isDefined(var_bd01b58f.max_spawns)) {
      var_bd01b58f.max_spawns = 2;
    }

    var_bd01b58f.min_spawns = int(var_bd01b58f.min_spawns);
    var_bd01b58f.max_spawns = int(var_bd01b58f.max_spawns);
    var_bd01b58f.var_a934617 = struct::get_array(var_bd01b58f.target);
    var_bd01b58f.var_831f3c76 = array::randomize(var_bd01b58f.var_a934617);
  }

  var_9051f4a3.var_72364dd7 = [];

  while(true) {
    foreach(var_bd01b58f in var_be4cdc25) {
      if(!var_bd01b58f flag::get(#"engaged") && !var_bd01b58f flag::get(#"paused")) {
        if(var_bd01b58f.var_831f3c76.size <= 0) {
          var_bd01b58f.var_831f3c76 = array::randomize(var_bd01b58f.var_a934617);

          if(isDefined(var_bd01b58f.var_3677c3bd)) {
            arrayremovevalue(var_bd01b58f.var_831f3c76, var_bd01b58f.var_3677c3bd);
          }
        }

        s_path = var_bd01b58f.var_831f3c76[0];
        arrayremoveindex(var_bd01b58f.var_831f3c76, 0);
        var_bd01b58f.var_3677c3bd = s_path;

        if(var_bd01b58f.min_spawns == var_bd01b58f.max_spawns) {
          var_91152aeb = var_bd01b58f.max_spawns;
        } else {
          var_91152aeb = randomintrangeinclusive(var_bd01b58f.min_spawns, var_bd01b58f.max_spawns);
        }

        var_9051f4a3.var_72364dd7 = function_e16259ed(var_9051f4a3.var_72364dd7);

        while(var_91152aeb > 0 && var_9051f4a3.var_72364dd7.size + var_91152aeb > 10) {
          var_91152aeb--;
          var_9051f4a3.var_72364dd7 = function_e16259ed(var_9051f4a3.var_72364dd7);
        }

        if(var_91152aeb <= 0) {
          continue;
        }

        var_bd01b58f flag::set(#"engaged");
        var_bd01b58f.var_ada0b21 = [];

        for(i = 0; i < var_91152aeb; i++) {
          var_e59e40b2 = array::random(var_773577b4);
          var_e59e40b2.origin = s_path.origin;
          var_e59e40b2.angles = s_path.angles;
          var_e59e40b2.target = s_path.target;

          while(true) {
            var_46745ec4 = spawner::simple_spawn_single(var_e59e40b2, &function_158cdaa);

            if(isDefined(var_46745ec4)) {
              var_46745ec4.var_36ceff65 = 1;

              if(!isDefined(var_9051f4a3.var_72364dd7)) {
                var_9051f4a3.var_72364dd7 = [];
              } else if(!isarray(var_9051f4a3.var_72364dd7)) {
                var_9051f4a3.var_72364dd7 = array(var_9051f4a3.var_72364dd7);
              }

              var_9051f4a3.var_72364dd7[var_9051f4a3.var_72364dd7.size] = var_46745ec4;

              if(!isDefined(var_bd01b58f.var_ada0b21)) {
                var_bd01b58f.var_ada0b21 = [];
              } else if(!isarray(var_bd01b58f.var_ada0b21)) {
                var_bd01b58f.var_ada0b21 = array(var_bd01b58f.var_ada0b21);
              }

              var_bd01b58f.var_ada0b21[var_bd01b58f.var_ada0b21.size] = var_46745ec4;
              break;
            }

            waitframe(1);
          }
        }

        var_bd01b58f thread function_a3928a6c();
        var_bd01b58f thread function_51ba79bd();
      }
    }

    wait randomfloatrange(2, 3);
  }
}

function function_a3928a6c() {
  level.var_9051f4a3 endon(#"skipped");
  level endon(#"hash_2dfb720e0ae80724");

  if(self.var_ada0b21.size <= 1) {
    foreach(var_46745ec4 in self.var_ada0b21) {
      var_46745ec4.var_c2c86d65 = 0;
      var_46745ec4 notify(#"move");
    }

    return;
  }

  while(true) {
    self.var_ada0b21 = function_e16259ed(self.var_ada0b21);

    if(self.var_ada0b21.size <= 0) {
      return;
    }

    var_7dd9263b = self.var_ada0b21[0];
    arrayremoveindex(self.var_ada0b21, 0);
    var_7dd9263b.var_c2c86d65 = 0;
    var_7dd9263b notify(#"move");
    var_4936c2ce = var_7dd9263b.drone.run_speed;

    while(!function_335f38a0(var_7dd9263b) && !isDefined(var_4936c2ce)) {
      var_4936c2ce = var_7dd9263b.drone.run_speed;
      waitframe(1);
    }

    if(isDefined(var_4936c2ce)) {
      break;
    }
  }

  foreach(var_46745ec4 in self.var_ada0b21) {
    wait randomfloatrange(0.25, 2);

    if(!function_335f38a0(var_46745ec4)) {
      var_46745ec4.drone.run_speed = var_4936c2ce;
      var_46745ec4 notify(#"move");
    }
  }
}

function function_51ba79bd() {
  level.var_9051f4a3 endon(#"skipped");
  level endon(#"hash_2dfb720e0ae80724");

  while(self.var_ada0b21.size > 0) {
    self.var_ada0b21 = function_e16259ed(self.var_ada0b21);
    wait 0.1;
  }

  self flag::clear(#"engaged");
}

function function_a87fafa3() {
  val::set(#"last_stand", "allowdeath", 0);
}

function function_d623578b(var_d3440450, var_50cc0d4f, var_aa1a6455, e_player) {
  level flag::set(#"hash_67902020b6966b5e");

  if(!e_player) {
    return;
  }

  function_491b5b63();
  var_9051f4a3 = level.var_9051f4a3;

  if(!is_true(var_9051f4a3.b_completed)) {
    var_9051f4a3 notify(#"skipped");

    if(isDefined(var_9051f4a3.s_waypoint)) {
      objectives::complete("armada_obj_firebase_defend", var_9051f4a3.s_waypoint);
    }

    if(isDefined(var_9051f4a3.var_b6fdd6f2)) {
      level thread function_fb080e60(var_9051f4a3.var_b6fdd6f2);
    }
  }

  foreach(var_5b5d5258 in var_9051f4a3.var_79de6b64) {
    var_5b5d5258 flag::set(#"destroyed");
  }
}

function function_491b5b63() {
  a_str_flags = [# "hash_459de234e0c1039c", #"hash_7db1f12e6f3747a", #"hash_172cf6a43985872d"];

  foreach(str_flag in a_str_flags) {
    if(!level flag::get(str_flag)) {
      return;
    }
  }

  if(isDefined(level.player)) {
    level.player achievements::give_achievement(#"cp_achievement_scorched_earth");
  }
}

function function_47cfc791(var_d3440450) {
  util::delay(2, undefined, &snd::client_msg, #"hash_55704324b6ae9012");
}

function function_2870229e(var_d3440450, var_50cc0d4f) {
  var_539110f3 = level.var_539110f3;
  var_539110f3 endon(#"skipped");
  snd::client_msg(#"hash_2b94ea847ae2b667");
  function_a291d0f(var_d3440450, var_50cc0d4f);
  function_d6988dc3();
  scene::function_27f5972e(#"hash_768798e8e7be9fe1");
  scene::function_27f5972e(#"hash_ee8053ecf9e94ed");
  scene::function_27f5972e(#"hash_72c6c90c740fc9de");
  scene::function_27f5972e(#"armada_crash_start");
  level clientfield::set("" + # "hash_4ee03d623b77b0c2", 1);
  var_96c2a0a6 = struct::get_array(#"hash_4483879458d31dab", "ripcord_ambient");

  foreach(var_bd01b58f in var_96c2a0a6) {
    var_bd01b58f flag::set(#"paused");

    if(isDefined(var_bd01b58f.var_ada0b21)) {
      foreach(var_46745ec4 in var_bd01b58f.var_ada0b21) {
        if(!function_335f38a0(var_46745ec4)) {
          var_46745ec4 function_a2798ad7();
          var_46745ec4 kill();
        }
      }
    }
  }

  if(var_50cc0d4f) {
    level flag::set(#"hash_71b417d2e25ac7c1");
    level flag::set(#"hash_16d9badc5604cc63");
    level thread function_226ff16b(0, 0, 1);
  }

  level thread function_7935e4b6();

  if(getdvarint(#"hash_3b90a67ea0b6081b", 0) >= 2) {
    level.player val::set(#"hash_ca2667067306cf1", "<dev string:x157>", 1);
    level.player val::set(#"hash_ca2667067306cf1", "<dev string:x163>", 0);
    level.player val::set(#"hash_ca2667067306cf1", "<dev string:x171>", 0);
    n_seat = level.var_53bb8ef2.var_78bd98cb getoccupantseat(level.player);

    if(isDefined(n_seat) && n_seat >= 0) {
      level.var_53bb8ef2.var_78bd98cb usevehicle(level.player, n_seat);
    }

    var_f98108c1 = struct::get(#"hash_6839f84b984b36ff");
    level.player setorigin(var_f98108c1.origin);
    level.player setplayerangles(var_f98108c1.angles);
    level flag::set(#"hash_37caccfd2105f700");
    level flag::set(#"hash_51517bef10a765cc");
    return;
  }

  b_debug = 0;

  if(getdvarint(#"hash_38a23cdbf4dbed74", 0) >= 1) {
    b_debug = 1;
  }

  if(!var_50cc0d4f || b_debug) {
    level thread function_d05971bd();
    t_nuke_return = getent("t_nuke_return", "targetname");
    var_78bd98cb = level.var_53bb8ef2.var_78bd98cb;

    if(!var_78bd98cb istouching(t_nuke_return)) {
      level thread function_121bd937();
      level thread function_e0fedfbc();

      while(isalive(level.player) && isalive(var_78bd98cb) && !var_78bd98cb istouching(t_nuke_return)) {
        waitframe(1);
      }

      if(!isalive(var_78bd98cb) || !isalive(level.player)) {
        return;
      }
    }
  }

  level.player setsunshadowsplitdistance(0);
  setDvar(#"hash_367578d4c1c78030", 0);
  level thread exploder::kill_exploder("fxexp_firebase_smoke_columns");
  level flag::set(#"hash_11ed3cb4b3a96f61");
  namespace_72b0499b::music("11.0_asset");
  function_208489a2(1);
  var_9051f4a3 = level.var_9051f4a3;

  if(isDefined(var_9051f4a3.var_b6fdd6f2)) {
    level thread function_fb080e60(var_9051f4a3.var_b6fdd6f2, 1);
  }

  if(isDefined(level.var_53bb8ef2.var_78bd98cb)) {
    level.var_53bb8ef2.var_78bd98cb vehicle::set_damage_fx_level(0);
  }

  level notify(#"hash_140019c0ef68a765");
  util::function_3e65fe0b(1);
  level clientfield::set("toggle_gameplay_character_visibility", 0);
  level flag::set(#"hash_1514f781f5772ca1");
  level.vip val::reset(#"hash_16f344886ca07918", "takedamage");
  level.buddy val::reset(#"hash_16f344886ca07918", "takedamage");
  level.gunner val::reset(#"hash_16f344886ca07918", "takedamage");
  level.pilot val::reset(#"hash_16f344886ca07918", "takedamage");
  level.copilot val::reset(#"hash_16f344886ca07918", "takedamage");
  level.vip val::set(#"hash_3bb822ac59ad80", "take_weapons", 1);
  level.buddy val::set(#"hash_3bb822ac59ad80", "take_weapons", 1);
  friendlyfire::turnbackon();
  level.buddy val::set(#"nuke_transition", "hide", 1);
  a_ents = [];
  a_ents[# "vip"] = level.vip;
  a_ents[# "hash_4972abe0166bbc73"] = level.var_7466d419;
  level thread scene::play(#"hash_ee8053ecf9e94ed", a_ents);
  level flag::set(#"hash_1836f795cbffc399");
  level thread helicopter::function_437dfc97();
  level thread namespace_82bfe441::fade(1, "FadeImmediate");

  if(!var_50cc0d4f || b_debug) {
    level.player thread function_2dca33ef();
    level.player startcameratween(0.3, 0, 1);
    waitframe(1);
  }

  scene::add_scene_func(#"hash_768798e8e7be9fe1", &function_62f48e6c, "play");
  a_ents = [];
  a_ents[# "hash_4972abe0166bbc73"] = level.var_7466d419;
  level.var_7466d419 scene::play(#"hash_768798e8e7be9fe1", a_ents);

  if(isDefined(level.var_7466d419.var_b01889cd)) {
    level.var_7466d419.var_b01889cd delete();
  }

  level scene::stop(#"hash_ee8053ecf9e94ed");
  scene::add_scene_func(#"hash_72c6c90c740fc9de", &function_372862d0, "done");
  scene::add_scene_func(#"hash_72c6c90c740fc9de", &function_60899afd, "play");
  a_ents = [];
  a_ents[# "buddy"] = level.buddy;
  a_ents[# "vip"] = level.vip;
  a_ents[# "hash_4972abe0166bbc73"] = level.var_7466d419;
  level scene::play(#"hash_72c6c90c740fc9de", a_ents);
  var_539110f3.b_completed = 1;
  player_decision::function_8c0836dd(0);
  objectives::complete(#"nuke_secure");
  skipto::function_4e3ab877(var_d3440450);
}

function function_d05971bd() {
  foreach(s_scene in struct::get_array(#"hash_4d23e3f89e1744b2")) {
    s_scene scene::stop(1);
    waitframe(1);
  }
}

function function_121bd937() {
  level.var_539110f3 endon(#"skipped");
  level.player dialogue::queue("vox_cp_armd_00007_rpcd_badgernineroney_9c", undefined, 1);
  level.player dialogue::queue("vox_cp_armd_00007_plt1_copythatripcord_ad");
}

function function_e0fedfbc() {
  var_539110f3 = level.var_539110f3;
  var_539110f3 endon(#"skipped");
  waitframe(1);
  var_539110f3.s_waypoint = struct::get(#"hash_2d00d540e2beca6b");
  var_539110f3.var_805ed574 = # "nuke_return";
  objectives::function_4eb5c04a(var_539110f3.var_805ed574, var_539110f3.s_waypoint, #"hash_7d1526cc7da37ff6", undefined, undefined, #"hash_5c53b6128244009d");
  level flag::wait_till(#"hash_11ed3cb4b3a96f61");
  objectives::complete(var_539110f3.var_805ed574, var_539110f3.s_waypoint);
  var_539110f3.s_waypoint = undefined;
}

function function_2dca33ef() {
  self endon(#"death");
  self clientfield::set_to_player("" + # "hash_4e480e273ade4c04", 1);
  waitframe(1);
  self flag::wait_till(#"scene");
  self clientfield::set_to_player("" + # "hash_4e480e273ade4c04", 2);
}

function function_62f48e6c(a_ents) {
  var_28437f5c = struct::get(#"hash_3dcc0da8f1013d06");
  level.var_7466d419.var_b01889cd = util::spawn_model(#"tag_origin", level.var_7466d419.origin, level.var_7466d419.angles);
  level.var_7466d419 linkto(level.var_7466d419.var_b01889cd);
  level.var_7466d419.var_b01889cd moveto(var_28437f5c.origin, 2.5);
  wait 0.5;
  namespace_b7cfe907::function_28dd3085();
  level flag::set(#"hash_37caccfd2105f700");

  if(isDefined(level.var_7466d419.var_b01889cd)) {
    level.var_7466d419.var_b01889cd rotateto(var_28437f5c.angles, 2, 0.5);
  }
}

function function_60899afd(a_ents) {
  level thread exploder::exploder("fx_firebase_nukeretrieve_downdraft");
  level thread exploder::exploder("fx_firebase_nukeretrieve");
  level thread function_626219b6();
  level thread function_e24dfc79();
  level flag::set(#"hash_51517bef10a765cc");

  if(isDefined(a_ents[# "buddy"])) {
    a_ents[# "buddy"] val::reset(#"nuke_transition", "hide");
  }

  level waittill(#"hash_65c7da1490ee3c0e");
  level flag::set(#"hash_5b2bd051ba87df67");
  level waittill(#"hash_4870e2c44b745c0e");
  level flag::set(#"hash_4723793e58855abb");
}

function function_626219b6() {
  level waittill(#"hash_488f873e58a90c78");
  objectives::scripted(#"nuke_secure", undefined, #"hash_616f95c1194ab2aa");
}

function function_e24dfc79() {
  if(!isalive(level.player)) {
    return;
  }

  self notify("f7e79337407ca38");
  self endon("f7e79337407ca38");
  level.player endon(#"death");
  wait 0.1;
  level.player setviewclamp(5, 5, 5, 5, 0, 1, 1);
  level waittill(#"hash_563b941c135ba389");
  level.player setviewclamp(0, 0, 0, 0, 0, 1, 1);
}

function function_372862d0(a_ents) {
  exploder::kill_exploder("fx_firebase_nukeretrieve_downdraft");
}

function function_208489a2(var_7af285a8 = 0) {
  var_9051f4a3 = level.var_9051f4a3;

  if(isDefined(var_9051f4a3.var_86c425b5)) {
    foreach(var_7c0a5f3 in var_9051f4a3.var_86c425b5) {
      if(isDefined(var_7c0a5f3)) {
        if(var_7af285a8 && is_true(var_7c0a5f3.var_83bc6615)) {
          continue;
        }

        var_7c0a5f3 namespace_b7cfe907::function_5677b6eb();
        var_7c0a5f3 delete();
      }
    }
  }
}

function function_226ff16b(b_skip = 0, var_844ac87e = 1, var_50cc0d4f = 0) {
  level.var_9051f4a3 endon(#"skipped");
  var_b419fe3a = getspawnerarray("sp_ripcord_landing_huey", "targetname")[0];

  if(!b_skip) {
    level flag::wait_till(#"hash_71b417d2e25ac7c1");

    while(var_844ac87e && isalive(level.player) && level.player util::is_player_looking_at(var_b419fe3a.origin, 0.7, 1, level.var_53bb8ef2.var_78bd98cb)) {
      waitframe(1);
    }
  }

  level flag::set(#"hash_71b417d2e25ac7c1");

  while(true) {
    var_78bd98cb = spawner::simple_spawn_single(var_b419fe3a, &function_51a65f48, b_skip, var_50cc0d4f);

    if(isDefined(var_78bd98cb)) {
      break;
    }

    waitframe(1);
  }
}

function function_51a65f48(b_skip, var_50cc0d4f) {
  self endon(#"death");
  level endon(#"hash_1514f781f5772ca1");
  self.var_97de493f = # "hash_681bd4072c58c851";
  self function_1b0fcde7(1, 0);
  self.var_83bc6615 = 1;

  if(!b_skip) {
    self setmaxpitchroll(20, 50);
    self setspeed(15);
    self sethoverparams(0);
    self thread function_1e8718e3();
    self thread function_90ddb1ff();
    self thread function_14d7fe90(var_50cc0d4f);

    if(!var_50cc0d4f) {
      self function_22761cc0(#"hash_5e078e3a1b990615", undefined, 0);
      self setyawspeed(20, 10, 10);
      self function_22761cc0(#"hash_78ec7e18023d667e", undefined, 0);
      self thread function_22761cc0(#"hash_3f19bbf95dd0e44e");
    }

    level flag::wait_till(#"hash_16d9badc5604cc63");
  }

  level flag::set(#"hash_16d9badc5604cc63");
  self thread function_212c8571(b_skip);
  level flag::wait_till(#"hash_4c15d58f01f8ae6b");
  self namespace_b7cfe907::function_5677b6eb();
}

function function_1e8718e3() {
  self endon(#"death");
  var_1975645a = getspawnerarray("sp_ripcord_landing_huey_riders", "targetname");
  var_1975645a = array::sort_by_script_int(var_1975645a, 1);

  foreach(var_b76f85db in var_1975645a) {
    while(true) {
      ai_rider = spawner::simple_spawn_single(var_b76f85db, &function_4d89239b, self);

      if(isDefined(ai_rider)) {
        break;
      }

      waitframe(1);
    }
  }
}

function function_4d89239b(var_78bd98cb) {
  self endon(#"death");
  var_78bd98cb endon(#"death");
  self function_a265ea();

  switch (self.script_int) {
    case 1:
      str_scene = # "hash_14899833ec8a1750";
      n_delay = 0;
      break;
    case 2:
      str_scene = # "hash_77195c19fb332536";
      n_delay = 0.5;
      break;
    case 3:
      str_scene = # "hash_6d8304cc2577a711";
      n_delay = 0;
      break;
    case 4:
      str_scene = # "hash_2943864d6b335089";
      n_delay = 0.5;
      break;
  }

  var_78bd98cb thread scene::init(str_scene, self);
  level flag::wait_till(#"hash_7ca581999fba3c22");

  if(n_delay > 0) {
    wait n_delay;
  }

  var_78bd98cb scene::play(str_scene, self);
  v_navmesh = getclosestpointonnavmesh(self.origin, 128, 32);

  if(isDefined(v_navmesh)) {
    self forceteleport(v_navmesh);
  }
}

function function_90ddb1ff() {
  self endon(#"death");
  level endon(#"hash_1514f781f5772ca1");
  trigger::wait_till("t_ripcord_landing_huey_landing", "targetname", self);
  level flag::set(#"hash_282d410a7b6edd55");
}

function function_14d7fe90(var_50cc0d4f) {
  self endon(#"death");
  level endon(#"hash_282d410a7b6edd55");
  level flag::wait_till(#"hash_1514f781f5772ca1");
  self thread function_212c8571(0);
  var_28437f5c = struct::get(#"hash_fe4acd6bf3140ca");

  if(var_50cc0d4f) {
    self.origin = var_28437f5c.origin;
    self.angles = var_28437f5c.angles;
  } else {
    var_67ae4496 = util::spawn_model(#"tag_origin", self.origin, self.angles);
    self linkto(var_67ae4496);
    var_67ae4496 moveto(var_28437f5c.origin, 2, 0, 1);
    var_67ae4496 rotateto(var_28437f5c.angles, 2, 0, 1);
    var_67ae4496 waittilltimeout(2, #"movedone", #"rotatedone");
    var_67ae4496 delete();
  }

  self setspeedimmediate(10);
}

function function_212c8571(b_skip = 0) {
  self endon(#"death");
  self setmaxpitchroll(20, 50);
  self setyawspeed(20, 10, 10);
  self sethoverparams(0);

  if(b_skip) {
    var_991810cb = struct::get(#"hash_66da0f03e3bf1f1e", "script_noteworthy");
    self function_a57c34b7(var_991810cb.origin, 1);
    self setgoal(var_991810cb.origin, 1);
    n_yaw = var_991810cb.angles[1];
    self settargetyaw(n_yaw);
    self setgoalyaw(n_yaw);
    self.origin = var_991810cb.origin;
    self.angles = var_991810cb.angles;
    self setspeedimmediate(0);
  } else {
    self setspeed(10);
    self function_22761cc0(#"hash_fe4acd6bf3140ca");

    while(self getspeed() > 0.1) {
      waitframe(1);
    }
  }

  level flag::set(#"hash_7ca581999fba3c22");
}

function function_7935e4b6() {
  level flag::wait_till(#"hash_37caccfd2105f700");
  spawner::simple_spawn("sp_nuke_patrol_guys", &function_dd5e7a0e);
  level thread function_115e7bd6();
  level flag::wait_till(#"hash_51517bef10a765cc");
  spawner::simple_spawn("sp_nuke_trench_guard", &function_dd5e7a0e);
  level thread function_fec856aa();
  level thread function_ebf9b10d();
  level thread function_4a3b6d8f();
  level thread function_51375365();
  level thread function_c8c0cf8e();
  level thread function_53fdfc();
  level thread function_dda1c23b();
}

function function_a265ea() {
  self endon(#"death");

  if(!isDefined(level.var_5840c01e)) {
    level.var_5840c01e = [];
  } else if(!isarray(level.var_5840c01e)) {
    level.var_5840c01e = array(level.var_5840c01e);
  }

  level.var_5840c01e[level.var_5840c01e.size] = self;
  self val::set(#"hash_41438abab3275dfd", "ignoreme", 1);
  self val::set(#"hash_41438abab3275dfd", "ignoreall", 1);
  self val::set(#"hash_41438abab3275dfd", "takedamage", 0);
  self val::set(#"hash_41438abab3275dfd", "allowdeath", 0);
}

function function_dd5e7a0e() {
  self endon(#"death");
  self function_a265ea();
  self ai::set_behavior_attribute(#"demeanor", "patrol");
}

function function_115e7bd6() {
  level.var_539110f3 endon(#"skipped");
  var_773577b4 = getspawnerarray("sp_nuke_runners_01", "targetname");
  var_773577b4 = array::sort_by_script_int(var_773577b4, 1);

  for(i = 0; i < var_773577b4.size; i++) {
    spawner::simple_spawn_single(var_773577b4[i], &function_f6a76fab);
    wait 0.25;
  }
}

function function_f6a76fab() {
  self endon(#"death");
  self function_a265ea();
  self setdesiredspeed("sprint");
}

function function_fec856aa() {
  level.var_539110f3 endon(#"skipped");
  var_773577b4 = getspawnerarray("sp_nuke_runners_02", "targetname");
  var_773577b4 = array::sort_by_script_int(var_773577b4, 1);

  for(i = 0; i < var_773577b4.size; i++) {
    spawner::simple_spawn_single(var_773577b4[i], &function_a265ea);
    n_delay = 0.5;

    if(i > 0) {
      n_delay = 1;
    }

    wait n_delay;
  }
}

function function_ebf9b10d() {
  level.var_539110f3 endon(#"skipped");
  var_773577b4 = getspawnerarray("sp_nuke_runners_03", "targetname");
  var_773577b4 = array::sort_by_script_int(var_773577b4, 1);

  for(i = 0; i < var_773577b4.size; i++) {
    spawner::simple_spawn_single(var_773577b4[i], &function_a265ea);
    wait 1;
  }
}

function function_4a3b6d8f() {
  level.var_539110f3 endon(#"skipped");
  var_773577b4 = getspawnerarray("sp_nuke_runners_04", "targetname");
  var_773577b4 = array::sort_by_script_int(var_773577b4, 1);

  for(i = 0; i < var_773577b4.size; i++) {
    spawner::simple_spawn_single(var_773577b4[i], &function_a265ea);
    wait 1;
  }
}

function function_51375365() {
  level.var_539110f3 endon(#"skipped");
  wait 4;

  for(i = 0; i < 2; i++) {
    spawner::simple_spawn_single("sp_nuke_stairs_guys", &function_a265ea);

    if(i == 0) {
      wait 5;
    }
  }
}

function function_c8c0cf8e() {
  level.var_539110f3 endon(#"skipped");
  wait 16.5;
  spawner::simple_spawn_single("sp_nuke_lone_runner", &function_f20e9126);
}

function function_f20e9126() {
  self endon(#"death");
  self function_a265ea();
  self setdesiredspeed("sprint");
}

function function_53fdfc() {
  level.var_539110f3 endon(#"skipped");
  wait 17;
  spawner::simple_spawn_single("sp_nuke_heli_fly_by", &function_c2fadb70);
}

function function_c2fadb70() {
  self endon(#"death");
  self function_a265ea();
  level thread namespace_b7cfe907::function_68d5d346(self, [0, 1, 6, 7, 8, 9, 10, 11]);
  self setrotorspeed(1);
  self setspeed(50, 20, 10);
  self setyawspeed(50, 20, 10);
  self vehclearlookat();
  self setmaxpitchroll(20, 50);
  self function_22761cc0(self.target, 2048, 0);
  self namespace_b7cfe907::function_5677b6eb();
  self deletedelay();
}

function function_dda1c23b(var_50cc0d4f = 0) {
  level thread function_6829238d();

  if(!var_50cc0d4f) {
    wait 25.5;
    level thread function_eb104fb1();
  }

  level thread function_245135eb(var_50cc0d4f);
  level thread function_c66035a2(var_50cc0d4f);

  if(!var_50cc0d4f) {
    wait 4;
  }

  level thread function_6b13cfba();

  if(!var_50cc0d4f) {
    wait 1;
  }

  level thread function_f45e624d(var_50cc0d4f);
  level thread function_58ce2b2f(var_50cc0d4f);
  level thread function_5c6bb419(var_50cc0d4f);

  if(!var_50cc0d4f) {
    wait 2;
  }

  level flag::set(#"hash_6a59e2434ff3978c");
}

function function_6829238d(var_a1490bc8 = 1) {
  self notify("6fda315a0ca58773");
  self endon("6fda315a0ca58773");

  if(var_a1490bc8) {
    level waittill(#"hash_7fff22369ee7d10a");
  }

  level flag::set(#"hash_4c15d58f01f8ae6b");

  if(isDefined(level.var_5840c01e)) {
    foreach(var_1080e7e4 in level.var_5840c01e) {
      if(isDefined(var_1080e7e4)) {
        if(isDefined(var_1080e7e4.var_7613726a)) {
          var_1080e7e4 scene::stop(var_1080e7e4.var_7613726a, 1);
        }

        var_1080e7e4 delete();
      }
    }
  }
}

function function_245135eb(var_50cc0d4f) {
  if(!var_50cc0d4f) {
    wait 1;
  }

  spawner::simple_spawn_single("sp_vh_crash_jeep_01", &function_5c03f4d6, var_50cc0d4f);
}

function function_5c03f4d6(var_50cc0d4f) {
  self endon(#"death");
  self function_a265ea();
  nd_path = getvehiclenode(self.target, "targetname");
  self vehicle::get_on_path(nd_path);
  self.var_7613726a = # "hash_5823504556939fca";
  self thread scene::play(self.var_7613726a);
  level flag::wait_till(#"hash_6a59e2434ff3978c");
  self vehicle::go_path();
}

function function_c66035a2(var_50cc0d4f) {
  if(!var_50cc0d4f) {
    wait 1;
  }

  spawner::simple_spawn("sp_vh_crash_trucks", &function_4acf181f, var_50cc0d4f);
}

function function_4acf181f(var_50cc0d4f) {
  self endon(#"death");
  self function_a265ea();
  nd_path = getvehiclenode(self.target, "targetname");
  self vehicle::get_on_path(nd_path);

  if(!var_50cc0d4f) {
    level flag::wait_till(#"hash_6a59e2434ff3978c");
  }

  self vehicle::go_path();
}

function function_eb104fb1() {
  var_773577b4 = getspawnerarray("sp_crash_runners_01", "targetname");
  var_773577b4 = array::sort_by_script_int(var_773577b4, 1);

  for(i = 0; i < var_773577b4.size; i++) {
    spawner::simple_spawn_single(var_773577b4[i], &function_8f227688);
    wait 3;
  }
}

function function_8f227688() {
  self endon(#"death");
  self function_a265ea();
  self setdesiredspeed("sprint");
}

function function_f45e624d(var_50cc0d4f) {
  if(!var_50cc0d4f) {
    wait 2;
  }

  var_773577b4 = getspawnerarray("sp_crash_runners_02", "targetname");
  var_773577b4 = array::sort_by_script_int(var_773577b4, 1);

  for(i = 0; i < var_773577b4.size; i++) {
    spawner::simple_spawn_single(var_773577b4[i], &function_a265ea);
    n_delay = 0.5;

    switch (i) {
      case 1:
      case 2:
        n_delay = 1;
        break;
    }

    wait n_delay;
  }
}

function function_58ce2b2f(var_50cc0d4f) {
  if(!var_50cc0d4f) {
    wait 2.5;
  }

  var_773577b4 = getspawnerarray("sp_crash_runners_03", "targetname");
  var_773577b4 = array::sort_by_script_int(var_773577b4, 1);

  for(i = 0; i < var_773577b4.size; i++) {
    spawner::simple_spawn_single(var_773577b4[i], &function_a265ea);
    wait 1.5;
  }
}

function function_6b13cfba() {
  var_773577b4 = getspawnerarray("sp_crash_runners_04", "targetname");
  var_773577b4 = array::sort_by_script_int(var_773577b4, 1);

  for(i = 0; i < var_773577b4.size; i++) {
    spawner::simple_spawn_single(var_773577b4[i], &function_a265ea);
    wait 1.5;
  }
}

function function_5c6bb419(var_50cc0d4f) {
  if(!var_50cc0d4f) {
    wait 0.25;
  }

  for(i = 0; i < 2; i++) {
    spawner::simple_spawn_single("sp_nuke_stairs_guys", &function_a265ea);

    if(i == 0) {
      wait 3;
    }
  }
}

function function_2ea27496(var_d3440450, var_50cc0d4f, var_aa1a6455, e_player) {
  var_53bb8ef2 = level.var_53bb8ef2;

  if(isDefined(var_53bb8ef2.var_78bd98cb)) {
    var_53bb8ef2.var_78bd98cb.overridevehicledamage = undefined;
  }

  level.overrideplayerdamage = undefined;
  level.var_f5ebfda9 = undefined;
  level.var_bde3d03 = undefined;
  var_96c2a0a6 = struct::get_array(#"hash_4483879458d31dab", "ripcord_ambient");

  foreach(var_bd01b58f in var_96c2a0a6) {
    var_bd01b58f flag::clear(#"paused");
  }

  level flag::set(#"hash_2dfb720e0ae80724");
  var_9051f4a3 = level.var_9051f4a3;

  if(isDefined(var_9051f4a3.var_b6fdd6f2)) {
    level thread function_fb080e60(var_9051f4a3.var_b6fdd6f2);
  }

  level notify(#"hash_140019c0ef68a765");
  level clientfield::set("toggle_gameplay_character_visibility", 0);
  function_60f16ecb();
  level battlechatter::function_2ab9360b(1);

  if(!e_player) {
    return;
  }

  var_539110f3 = level.var_539110f3;

  if(!is_true(var_539110f3.b_completed)) {
    var_539110f3 notify(#"skipped");

    if(isDefined(var_539110f3.var_805ed574)) {
      objectives::complete(var_539110f3.var_805ed574, var_539110f3.s_waypoint);
    }
  }
}

function function_c03bb520(var_d3440450, var_50cc0d4f) {}

function function_1061456b(var_d3440450, var_50cc0d4f) {
  namespace_b7cfe907::function_27e76b4c("<dev string:x17f>", 0);
}

function private function_eaba72c9() {
  self notify("<dev string:x19e>");
  self endon("<dev string:x19e>");
  var_7f91fe17 = 0;

  while(true) {
    if(getdvarint(#"hash_2c2688d7152d1e56", 0) > 0) {
      if(!level scene::is_playing("<dev string:x1b2>", "<dev string:x1cc>")) {
        level thread scene::play("<dev string:x1b2>", "<dev string:x1cc>");
      }

      setDvar(#"hash_2c2688d7152d1e56", 0);
    }

    if(getdvarint(#"hash_28822a1bcce307da", 0) > 0) {
      if(!level scene::is_playing("<dev string:x1dc>")) {
        level thread scene::play("<dev string:x1dc>");
      }

      setDvar(#"hash_28822a1bcce307da", 0);
    }

    if(getdvarint(#"hash_63e4407ed222d81a", 0) > 0) {
      function_c3963aed();
      setDvar(#"hash_63e4407ed222d81a", 0);
    }

    if(getdvarint(#"hash_78e74121d07eb3ff", 0) > 0) {
      function_43339e00();
      setDvar(#"hash_63e4407ed222d81a", 0);
    }

    if(getdvarint(#"hash_2335341888db9443", 0) > 0) {
      oobtriggers = getEntArray("<dev string:x1fa>", "<dev string:x213>");

      foreach(trig in oobtriggers) {
        trig triggerenable(var_7f91fe17);
      }

      var_7f91fe17 = !var_7f91fe17;
      level notify(#"hash_1cf48096c380b7cd");
      setDvar(#"hash_2335341888db9443", 0);
    }

    if(getdvarint(#"hash_6607aa92eb9e51e1", 0) > 0) {
      if(isDefined(level.var_b99c0779)) {
        if(level.var_b99c0779 getheliheightlock()) {
          level.var_b99c0779 setheliheightlock(0);
          level.var_b99c0779 setheliheightcap(0);
        } else {
          level.var_b99c0779 setheliheightlock(1);
          level.var_b99c0779 setheliheightcap(1);
        }
      }

      if(isDefined(level.var_7466d419)) {
        if(level.var_7466d419 getheliheightlock()) {
          level.var_7466d419 setheliheightlock(0);
          level.var_7466d419 setheliheightcap(0);
        } else {
          level.var_7466d419 setheliheightlock(1);
          level.var_7466d419 setheliheightcap(1);
        }
      }

      setDvar(#"hash_6607aa92eb9e51e1", 0);
    }

    waitframe(1);
  }
}

function private function_c3963aed() {
  if(isDefined(level.var_b99c0779)) {
    if(level.var_b99c0779 getseatoccupant(0) === level.player || level.var_b99c0779 getseatoccupant(1) === level.player || level.var_b99c0779 getseatoccupant(2) === level.player || level.var_b99c0779 getseatoccupant(5) === level.player) {
      return;
    }

    level.var_b99c0779.origin = level.player.origin + (0, 0, 1024);
    level.var_b99c0779.angles = level.player.angles;
    level.var_b99c0779 usevehicle(level.player, 0);
    return;
  }

  var_e3b71bd = getent("<dev string:x220>", "<dev string:xa5>");

  if(!isDefined(var_e3b71bd)) {
    return;
  }

  chopper = vehicle::simple_spawn_single("<dev string:x220>");
  chopper.origin = level.player.origin + (0, 0, 1024);
  chopper.angles = level.player.angles;
  chopper usevehicle(level.player, 0);
  chopper makeusable();
  level.var_b99c0779 = chopper;
}

function private function_43339e00() {
  if(isDefined(level.var_7466d419) && isDefined(level.player)) {
    var_a462bbef = level.var_7466d419 getoccupantseat(level.player);

    if(isDefined(var_a462bbef)) {
      if(var_a462bbef != -1) {
        level.var_7466d419.var_2067b085 = var_a462bbef;
        level.var_7466d419 usevehicle(level.player, var_a462bbef);
        return;
      }

      if(isDefined(level.var_7466d419.var_2067b085)) {
        level.var_7466d419 usevehicle(level.player, level.var_7466d419.var_2067b085);
        level.var_7466d419.var_2067b085 = undefined;
        return;
      }

      level.var_7466d419 setseatoccupied(2, 0);
      level.var_7466d419 usevehicle(level.player, 2);
      level.var_7466d419.var_2067b085 = undefined;
    }
  }
}

function private _setup_devgui() {
  while(!canadddebugcommand()) {
    waitframe(1);
  }

  mapname = util::get_map_name();
  adddebugcommand("<dev string:x234>" + mapname + "<dev string:x245>");
  adddebugcommand("<dev string:x234>" + mapname + "<dev string:x293>");
  adddebugcommand("<dev string:x234>" + mapname + "<dev string:x2e7>");
  adddebugcommand("<dev string:x234>" + mapname + "<dev string:x339>");
  adddebugcommand("<dev string:x234>" + mapname + "<dev string:x37c>");
  adddebugcommand("<dev string:x234>" + mapname + "<dev string:x3ba>");
  level thread function_eaba72c9();
}