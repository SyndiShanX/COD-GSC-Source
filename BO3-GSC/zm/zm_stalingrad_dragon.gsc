/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_stalingrad_dragon.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\_burnplayer;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\animation_shared;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\damagefeedback_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\math_shared;
#using scripts\shared\music_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_ai_shared;
#using scripts\shared\vehicle_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_elemental_zombies;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\zm_siegebot_nikolai;
#using scripts\zm\zm_stalingrad_drop_pods;
#using scripts\zm\zm_stalingrad_ee_main;
#using scripts\zm\zm_stalingrad_util;
#using scripts\zm\zm_stalingrad_vo;
#using_animtree("generic");
#namespace dragon;

function autoexec __init__sytem__() {
  system::register("stalingrad_dragon", &__init__, &__main__, undefined);
}

function __init__() {
  level flag::init("dragon_boss_vignette");
  level flag::init("dragon_boss_vignette_ready");
  level flag::init("dragon_boss_intro_init");
  level flag::init("dragon_boss_start");
  level flag::init("dragon_boss_dead");
  level flag::init("dragon_boss_in_air");
  level flag::init("dragon_boss_takedamage");
  level flag::init("dragon_boss_init");
  level flag::init("dragon_hazard_active");
  level.var_3f756142 = 1;
  level.var_5a45def9 = 120;
  level.var_181b1223 = "south";
  level.var_5494305 = undefined;
  function_cf4cd159();
  function_8be04f83();
  function_ffa0a9ed();
  function_d76099a6();
  level thread function_e56b0a04();
}

function __main__() {
  level thread function_d34b0574();
}

function init_clientfields() {
  clientfield::register("scriptmover", "dragon_body_glow", 12000, 1, "int");
  clientfield::register("scriptmover", "dragon_notify_bullet_impact", 12000, 1, "int");
  clientfield::register("scriptmover", "dragon_wound_glow_on", 12000, 2, "int");
  clientfield::register("scriptmover", "dragon_wound_glow_off", 12000, 2, "int");
  clientfield::register("scriptmover", "dragon_mouth_fx", 12000, 1, "int");
  n_bits = getminbitcountfornum(10);
  clientfield::register("scriptmover", "dragon_notetracks", 12000, n_bits, "counter");
  clientfield::register("toplayer", "dragon_fire_burn_tell", 12000, 3, "int");
  clientfield::register("toplayer", "dragon_transportation_exploders", 12000, 1, "int");
  clientfield::register("allplayers", "dragon_transport_eject", 12000, 1, "int");
  clientfield::register("world", "dragon_hazard_fx_anim_init", 12000, 1, "int");
  clientfield::register("world", "dragon_hazard_fountain", 12000, 1, "int");
  clientfield::register("world", "dragon_hazard_library", 12000, 1, "counter");
  clientfield::register("world", "dragon_boss_guts", 12000, 2, "int");
}

function function_d34b0574() {
  level.var_357a65b = spawn("script_model", vectorscale((0, 0, -1), 10000));
  level.var_357a65b setModel("c_zom_dlc3_dragon_body_hazard");
  level.var_357a65b.targetname = "dragon_hazard";
  level.var_357a65b.b_ignore_mark3_pulse_damage = 1;
  level.var_357a65b function_b1132160();
  util::wait_network_frame();
  level.var_357a65b clientfield::set("dragon_body_glow", 1);
  level flag::wait_till("start_zombie_round_logic");
  level.var_357a65b clientfield::set("dragon_body_glow", 0);
}

function dragon_hazard_fx_anim_init() {
  level clientfield::set("dragon_hazard_fx_anim_init", 1);
  level thread scene::init("p7_fxanim_zm_stal_dragon_hazard_fountain_01_bundle");
  level flag::init("dragon_hazard_library_once");
  level thread scene::init("p7_fxanim_zm_stal_dragon_hazard_library_chand_01_bundle");
  level thread scene::init("p7_fxanim_zm_stal_dragon_hazard_library_chand_02_bundle");
  level thread scene::init("p7_fxanim_zm_stal_dragon_hazard_judicial_bundle");
  level flag::init("dragon_hazard_dept_store_once");
  level thread scene::init("p7_fxanim_zm_stal_dragon_hazard_dept_store_01_bundle");
  level flag::init("dragon_hazard_armory_once");
  level flag::init("dragon_hazard_barracks_once");
}

function dragon_boss_intro_init() {
  if(!level flag::get("dragon_boss_intro_init")) {
    level flag::set("dragon_boss_intro_init");
    level notify("hash_dfaade1d");
    level thread scene::play("cin_t7_ai_zm_dlc3_dragon_boss_fight_intro_b_idle");
  }
}

function function_e56b0a04() {
  level waittill("player_enter_boss_arena");
  zm_stalingrad_util::function_4da6e8(0);
}

function function_f85863e2() {
  level endon("hash_dfaade1d");
  level.var_de98a8ad = 0;
  while(level.round_number <= 4) {
    level waittill("between_round_over");
  }
  level.var_de98a8ad = 0.35;
}

function function_30137a38() {
  level endon("hash_dfaade1d");
  level.var_a8b674f9 = 0;
  level flag::wait_till("department_store_upper_open");
  level.var_a8b674f9 = 1;
  level.var_de98a8ad = 0.35;
}

function function_8be04f83() {
  level.var_163a43e4 = [];
  level.var_428b5b88 = 0;
  level.var_f73b438a = 0;
  level.var_fc730f22 = [];
  zm_weapons::add_custom_limited_weapon_check(&function_8c1bac65);
  level.var_6e68a823 = [];
  level.var_6e68a823["library"] = "cin_t7_ai_zm_dlc3_dragon_transport_roost2";
  level.var_6e68a823["factory"] = "cin_t7_ai_zm_dlc3_dragon_transport_roost1";
  level.var_6e68a823["judicial"] = "cin_t7_ai_zm_dlc3_dragon_transport_roost3";
  foreach(var_76862d83 in level.var_6e68a823) {
    if(isDefined(var_76862d83)) {
      scene::add_scene_func(var_76862d83, &function_c8c51697, "play");
      scene::add_scene_func(var_76862d83, &function_7ba58f31, "done");
    }
    scene::add_scene_func(var_76862d83 + "_idle_2_pavlovs", &function_d2059ba7, "play");
    scene::add_scene_func(var_76862d83 + "_idle_2_pavlovs", &function_c65ef401, "done");
  }
  level.var_f5464041 = [];
  level.var_f5464041["library"] = 1;
  level.var_f5464041["factory"] = 1;
  level.var_f5464041["judicial"] = 1;
}

function function_8c1bac65(var_953206f3) {
  n_count = 0;
  foreach(var_3ee6fb6a in level.var_fc730f22) {
    if(var_953206f3 == var_3ee6fb6a) {
      n_count++;
      continue;
    }
    if(isDefined(level.zombie_weapons[var_953206f3]) && isDefined(level.zombie_weapons[var_953206f3].upgrade)) {
      if(var_3ee6fb6a == level.zombie_weapons[var_953206f3].upgrade) {
        n_count++;
      }
    }
  }
  return n_count;
}

function function_cf4cd159() {
  level.var_777ffc66 = undefined;
  level.var_973195fc = [];
  level.var_973195fc["start"] = "cin_t7_ai_zm_dlc3_dragon_flight_land_8";
  level.var_973195fc["alley"] = "cin_t7_ai_zm_dlc3_dragon_flight_land_6";
  level.var_973195fc["opera_street"] = "cin_t7_ai_zm_dlc3_dragon_flight_land_7";
  level.var_973195fc["department_store"] = "cin_t7_ai_zm_dlc3_dragon_flight_land_1";
  level.var_973195fc["factory"] = "cin_t7_ai_zm_dlc3_dragon_flight_land_2";
  level.var_973195fc["library"] = "cin_t7_ai_zm_dlc3_dragon_flight_land_5";
  level.var_973195fc["red_brick"] = "cin_t7_ai_zm_dlc3_dragon_flight_land_3";
  level.var_973195fc["yellow"] = "cin_t7_ai_zm_dlc3_dragon_flight_land_4";
  level.var_5eab5443 = [];
  level.var_5eab5443["start"] = "fxexp_404";
  level.var_5eab5443["alley"] = "fxexp_410";
  level.var_5eab5443["opera_street"] = "fxexp_406";
  level.var_5eab5443["department_store"] = "fxexp_409";
  level.var_5eab5443["factory"] = "fxexp_408";
  level.var_5eab5443["library"] = "fxexp_407";
  level.var_5eab5443["red_brick"] = "fxexp_405";
  level.var_5eab5443["yellow"] = "fxexp_411";
  level.var_5eab5443["boss_east"] = "fxexp_400";
  level.var_5eab5443["boss_south"] = "fxexp_401";
  level.var_5eab5443["boss_west"] = "fxexp_402";
  scene::add_scene_func("cin_t7_ai_zm_dlc3_dragon_flight_idle_a_1", &function_59bb533b, "play");
  foreach(var_29f29c1d in level.var_973195fc) {
    if(isDefined(var_29f29c1d)) {
      scene::add_scene_func(var_29f29c1d, &function_4dfd2088, "play");
      scene::add_scene_func(var_29f29c1d, &function_9ccce34a, "done");
    }
  }
  var_63b19580 = array("start", "alley", "opera_street", "department_store", "factory", "library", "red_brick", "yellow");
}

function function_b1132160() {
  var_90150bee = "tag_throat_fx";
  origin = self gettagorigin(var_90150bee);
  angles = self gettagangles(var_90150bee);
  turret = spawnvehicle("veh_bo3_dlc3_dragon_flame", origin, angles);
  turret linkto(self, var_90150bee);
  turret.b_ignore_cleanup = 1;
  turret.ignoreme = 1;
  turret.ignore_nuke = 1;
  turret.ignore_round_robbin_death = 1;
  turret.ignore_enemy_count = 1;
  turret vehicle::god_on();
  self.var_caa5308f = turret;
  turret thread function_3f75a750();
}

function function_3f75a750() {
  wait(0.05);
  self connectpaths();
}

function function_59bb533b(a_ents) {
  if(!isDefined(level.var_357a65b)) {
    function_d34b0574();
  }
}

function function_851889a0(var_2e1f54d4, var_777ffc66) {
  level endon("hash_9ccce34a");
  level waittill("wingflap_arrival");
  switch (var_777ffc66) {
    case "start": {
      level thread scene::play("p7_fxanim_zm_stal_dragon_hazard_fountain_01_bundle");
      level clientfield::set("dragon_hazard_fountain", 1);
      break;
    }
    case "library": {
      level clientfield::increment("dragon_hazard_library");
      if(!level flag::get("dragon_hazard_library_once")) {
        level flag::set("dragon_hazard_library_once");
        level thread scene::play("p7_fxanim_zm_stal_dragon_hazard_library_chand_01_bundle");
      }
      level thread scene::play("p7_fxanim_zm_stal_dragon_hazard_library_chand_02_bundle");
      break;
    }
    case "opera_street": {
      level thread scene::play("p7_fxanim_zm_stal_dragon_hazard_judicial_bundle");
      break;
    }
    case "department_store": {
      if(!level flag::get("dragon_hazard_dept_store_once")) {
        level flag::set("dragon_hazard_dept_store_once");
        level thread scene::play("p7_fxanim_zm_stal_dragon_hazard_dept_store_01_bundle");
      }
      break;
    }
    default: {
      break;
    }
  }
  level waittill("wingflap_exit");
  switch (var_777ffc66) {
    case "start": {
      level thread scene::stop("p7_fxanim_zm_stal_dragon_hazard_fountain_01_bundle");
      level thread scene::init("p7_fxanim_zm_stal_dragon_hazard_fountain_01_bundle");
      level clientfield::set("dragon_hazard_fountain", 0);
      break;
    }
    case "opera_street": {
      level thread scene::stop("p7_fxanim_zm_stal_dragon_hazard_judicial_bundle");
      level thread scene::init("p7_fxanim_zm_stal_dragon_hazard_judicial_bundle");
      break;
    }
    default: {
      break;
    }
  }
}

function function_f553bc7() {
  level waittill("hash_3346438b");
  level scene::play("p7_fxanim_zm_stal_letters_a_r_bundle");
}

function function_8b270ed4() {
  level waittill("hash_3346438b");
  level scene::play("p7_fxanim_zm_stal_letters_y_bundle");
}

function function_4dfd2088(a_ents) {
  switch (level.var_777ffc66) {
    case "alley":
    case "yellow": {
      if(!level flag::get("dragon_hazard_armory_once")) {
        level flag::set("dragon_hazard_armory_once");
        level thread function_f553bc7();
      }
      break;
    }
    case "red_brick": {
      if(!level flag::get("dragon_hazard_barracks_once")) {
        level flag::set("dragon_hazard_barracks_once");
        level thread function_8b270ed4();
      }
      break;
    }
    default: {
      break;
    }
  }
  level thread function_851889a0(level.var_357a65b, level.var_777ffc66);
  level thread function_3d1f7c2e(level.var_357a65b, level.var_777ffc66);
  level thread function_21146aa(level.var_357a65b, level.var_777ffc66);
  level thread function_d4556285(level.var_357a65b, level.var_777ffc66);
}

function function_9ccce34a(a_ents) {
  level notify("hash_9ccce34a");
}

function function_c8c51697(a_ents) {
  if(!isDefined(level.var_e29dd7ca)) {
    level.var_e29dd7ca = a_ents["dragon_transport"];
    level.var_e29dd7ca attach("c_zom_dlc3_dragon_harness");
    level.var_e29dd7ca setignorepauseworld(1);
  } else if(level.var_e29dd7ca != a_ents["dragon_transport"]) {
    level.var_e29dd7ca = a_ents["dragon_transport"];
    level.var_e29dd7ca attach("c_zom_dlc3_dragon_harness");
  }
  level.var_e29dd7ca sethighdetail(1);
  level.var_e29dd7ca thread handle_notetracks();
}

function function_7ba58f31(a_ents) {
  var_76862d83 = level.var_6e68a823[level.var_9d19c7e];
  level thread scene::play(var_76862d83 + "_idle");
}

function function_d2059ba7(a_ents) {
  level waittill("eject");
  level thread function_3f0f5f61();
}

function function_c65ef401(a_ents) {
  level.var_e29dd7ca = undefined;
  level.var_9d19c7e = undefined;
  level notify("hash_803aa6bf");
}

function function_b4d22afe() {
  level endon("hash_dfaade1d");
  level thread function_f85863e2();
  level thread function_30137a38();
  level.var_2ed06b05 = [];
  level.var_2ed06b05[0] = "cin_t7_ai_zm_dlc3_dragon_flight_idle_a_1";
  level.var_2ed06b05[1] = "cin_t7_ai_zm_dlc3_dragon_flight_idle_b_1";
  n_path = 0;
  while(true) {
    level scene::play(level.var_2ed06b05[n_path]);
    n_path = randomintrange(0, level.var_2ed06b05.size);
    if(level.var_de98a8ad != 0) {
      var_f72c48e9 = randomfloat(1);
      if(var_f72c48e9 <= level.var_de98a8ad) {
        level.var_777ffc66 = function_517c3b8c();
        dragon_hazard();
      }
    }
  }
}

function dragon_hazard(b_debug = 0) {
  level endon("hash_dfaade1d");
  if(!isDefined(level.var_777ffc66)) {
    return;
  }
  if(isDefined(level.var_973195fc[level.var_777ffc66])) {
    level scene::play(level.var_973195fc[level.var_777ffc66]);
  }
  if(b_debug) {
    level thread function_b4d22afe();
  }
}

function function_51d28faf() {
  level endon("dragon_full");
  wait(10);
  if(level.var_163a43e4.size > 0) {
    level flag::set("dragon_rider_timeout");
  }
  level thread function_825bb926();
}

function function_29710212() {
  level flag::wait_till_any(array("dragon_rider_timeout", "dragon_full", "dragon_reroute"));
}

function function_83dd194d() {
  while(!level flag::get_any(array("dragon_rider_timeout", "dragon_full"))) {
    var_76862d83 = level.var_6e68a823[level.var_9d19c7e];
    level thread scene::play(var_76862d83);
    level waittill("hash_e276220e");
    if(level flag::get("dragon_reroute")) {
      level flag::clear("dragon_reroute");
    }
    level flag::set("dragon_platform_arrive");
    function_29710212();
    if(level flag::get("dragon_reroute")) {
      level flag::clear("dragon_platform_arrive");
      level scene::play(var_76862d83 + "_timeout");
    }
  }
  if(level flag::get_any(array("dragon_rider_timeout", "dragon_full"))) {
    foreach(player in level.var_163a43e4) {
      if(player hasweapon(getweapon("minigun"))) {
        zm_powerups::weapon_powerup_remove(player, "minigun_time_over", "minigun", 1);
        wait(0.3);
      }
      var_d2f4cbdf = player getweaponslistprimaries();
      w_current = player getcurrentweapon();
      if(zm_utility::is_offhand_weapon(w_current)) {
        player.var_de933247 = var_d2f4cbdf[0];
      } else {
        player.var_de933247 = w_current;
      }
      foreach(w_primary in var_d2f4cbdf) {
        if(isDefined(level.limited_weapons[w_primary])) {
          if(!isDefined(level.var_fc730f22)) {
            level.var_fc730f22 = [];
          } else if(!isarray(level.var_fc730f22)) {
            level.var_fc730f22 = array(level.var_fc730f22);
          }
          level.var_fc730f22[level.var_fc730f22.size] = w_primary;
        }
      }
      player freezecontrols(1);
      player disableweapons();
      player disableoffhandweapons();
    }
    wait(2);
    level thread scene::play(var_76862d83 + "_idle_2_pavlovs");
    foreach(player in level.var_163a43e4) {
      if(isDefined(level.musicsystem.currentplaytype) && level.musicsystem.currentplaytype < 4 && (!(isDefined(level.musicsystemoverride) && level.musicsystemoverride))) {
        player playsoundtoplayer("mus_stalingrad_dragonride", player);
      }
      player clientfield::set_to_player("dragon_transportation_exploders", 1);
    }
    if(level.activeplayers.size == 1) {
      level thread scene::play((var_76862d83 + "_idle_2_pavlovs_p") + level.var_3f756142, level.var_163a43e4[0]);
    } else {
      var_2102f1cc = 1;
      foreach(player in level.var_163a43e4) {
        player unlink();
        level thread scene::play((var_76862d83 + "_idle_2_pavlovs_p") + var_2102f1cc, player);
        var_2102f1cc++;
      }
    }
    level.var_f73b438a++;
  }
  level waittill("hash_803aa6bf");
  level flag::clear("dragon_console_triggered");
  level flag::clear("dragon_full");
  level flag::clear("dragon_rider_timeout");
  level flag::clear("dragon_platform_arrive");
  level flag::clear("dragon_platform_one_rider");
}

function function_40dbf71() {
  level endon("hash_803aa6bf");
  while(true) {
    if(isDefined(level.var_e29dd7ca)) {
      origin = level.var_e29dd7ca gettagorigin("");
      sphere(origin, 16, (1, 0, 0), 1, 1, 16, 1);
    }
    wait(0.05);
  }
}

function function_3d1f7c2e(var_2e1f54d4, var_777ffc66, var_90929db6 = 0, var_c3052a58 = 0) {
  var_90f8d95e = struct::get_array("rumble_" + var_777ffc66, "targetname");
  if(!var_90929db6) {
    level waittill("arrival");
    level thread function_3b45d6c2(var_90f8d95e);
  }
  var_12bd8497 = getent(var_777ffc66 + "_1_damage", "targetname");
  var_12bd8497.var_37ba64ca = 0;
  var_12bd8497 thread function_2d3f510e(var_c3052a58);
}

function function_21146aa(var_2e1f54d4, var_777ffc66) {
  level endon("dragon_interrupt");
  var_90f8d95e = struct::get_array("rumble_" + var_777ffc66, "targetname");
  level waittill("fire_start");
  var_2e1f54d4 clientfield::set("dragon_body_glow", 1);
  level thread function_acdda91d("zm_stalingrad_dragon_fire_charge", var_90f8d95e);
  level waittill("breathe_fire");
  stopallrumbles();
  util::wait_network_frame();
  level thread function_acdda91d("zm_stalingrad_dragon_fire_breathe", var_90f8d95e);
  level waittill("fire_end");
  var_2e1f54d4 clientfield::set("dragon_body_glow", 0);
  level waittill("hash_ed468118");
  stopallrumbles();
}

function function_3b45d6c2(var_90f8d95e) {
  foreach(s_location in var_90f8d95e) {
    playrumbleonposition("zm_stalingrad_dragon_arrival", s_location.origin);
    util::wait_network_frame();
  }
}

function function_acdda91d(str_rumble, var_90f8d95e) {
  foreach(s_location in var_90f8d95e) {
    playrumblelooponposition(str_rumble, s_location.origin);
    util::wait_network_frame();
  }
}

function function_ca29ccc4(var_2e1f54d4, var_777ffc66) {
  level endon("dragon_interrupt");
  var_2e1f54d4 thread function_c4860ff6();
  switch (var_777ffc66) {
    case "department_store": {
      weaponname = "turret_dragon_flame_s";
      break;
    }
    case "alley":
    case "factory":
    case "library":
    case "red_brick":
    case "yellow": {
      weaponname = "turret_dragon_flame_m";
      break;
    }
    case "opera_street":
    case "start":
    default: {
      weaponname = "turret_dragon_flame_l";
      break;
    }
  }
  weapon = getweapon(weaponname);
  var_2e1f54d4.var_caa5308f setvehweapon(weapon);
  var_2e1f54d4.var_caa5308f.firing = 1;
  while(var_2e1f54d4.var_caa5308f.firing) {
    var_2e1f54d4.var_caa5308f fireweapon();
    wait(0.05);
  }
}

function function_d4556285(var_2e1f54d4, var_777ffc66) {
  level endon("dragon_interrupt");
  level endon("hash_a35dee4e");
  level waittill("breathe_fire");
  level thread function_ca29ccc4(var_2e1f54d4, var_777ffc66);
  wait(1);
  switch (var_777ffc66) {
    case "start": {
      exploder::stop_exploder("fxexp_403");
      break;
    }
    default: {
      break;
    }
  }
  if(level flag::get("dragon_boss_start")) {
    n_duration = 20;
  } else {
    n_duration = 10;
  }
  var_12bd8497 = getent(var_777ffc66 + "_1_damage", "targetname");
  var_12bd8497 thread function_2dcfeeb9(var_777ffc66, n_duration);
}

function function_c4860ff6() {
  level endon("dragon_interrupt");
  level waittill("fire_end");
  self.var_caa5308f.firing = 0;
}

function function_2d3f510e(var_c3052a58) {
  level endon("breathe_fire");
  while(true) {
    foreach(player in level.activeplayers) {
      if(player istouching(self) && player.var_c777a4de !== 1) {
        if(!var_c3052a58 && math::cointoss() && (!(isDefined(self.var_37ba64ca) && self.var_37ba64ca))) {
          if(!isDefined(player.var_22e4c94d) || (isDefined(player.var_22e4c94d) && player.var_22e4c94d.size >= 1)) {
            self.var_37ba64ca = 1;
            player thread zm_stalingrad_vo::function_b86ec8c9();
          }
        }
        player thread function_2cc55104();
      }
    }
    wait(0.1);
  }
}

function function_c6f5d03() {
  self endon("hash_421b488f");
  level.var_8f92a57b.var_7cd42d94 = 0;
  foreach(player in level.activeplayers) {
    player.var_4ebc7c98 = 0;
  }
  if(isDefined(level.var_de98e3ce.var_d54b9ade.var_62ceb838)) {
    var_62ceb838 = level.var_de98e3ce.var_d54b9ade.var_62ceb838;
    var_62ceb838.var_4ebc7c98 = 0;
  }
  while(isDefined(self)) {
    level.var_8f92a57b.var_7cd42d94 = level.var_8f92a57b.var_7cd42d94 + 0.1;
    foreach(player in level.activeplayers) {
      if(isDefined(player) && player istouching(self)) {
        player function_20b34915();
      }
    }
    a_zombies = zm_elemental_zombie::function_d41418b8();
    foreach(zombies in a_zombies) {
      if(zombies istouching(self) && (!(isDefined(self.is_elemental_zombie) && self.is_elemental_zombie))) {
        zombies function_20b34915();
        break;
      }
    }
    if(isDefined(var_62ceb838)) {
      var_62ceb838.var_4ebc7c98 = var_62ceb838.var_4ebc7c98 + 0.1;
    }
    wait(0.1);
  }
}

function function_2cc55104() {
  self endon("death");
  self endon("disconnect");
  self.var_c777a4de = 1;
  self clientfield::set_to_player("dragon_fire_burn_tell", self getentitynumber() + 1);
  self function_2114330(2);
  self.var_c777a4de = 0;
  self clientfield::set_to_player("dragon_fire_burn_tell", 0);
}

function function_2114330(n_duration) {
  level endon("breathe_fire");
  self endon("death");
  self endon("disconnect");
  wait(n_duration);
}

function function_20b34915() {
  self endon("death");
  if(isplayer(self)) {
    current_weapon = self getcurrentweapon();
    n_health = self.maxhealth;
    if(current_weapon.isriotshield) {
      if(isDefined(self.riotshield_damage_absorb_callback)) {
        if(isDefined(self.var_e34aa037)) {
          self.var_e34aa037 = self.var_e34aa037 + 0.1;
          if(self.var_e34aa037 >= 1) {
            self.var_e34aa037 = 0;
            self notify("hash_3d742bf8");
          }
        }
        self[[self.riotshield_damage_absorb_callback]](self, n_health * 0.02, "riotshield", "MOD_BURNED");
      }
    } else if(self.var_e3fc4787 !== 1) {
      self thread function_17d42ef();
    }
    self dodamage(n_health * 0.02, self.origin + vectorscale((0, 0, 1), 120), undefined, undefined, undefined, "MOD_BURNED", 0, getweapon("incendiary_fire"));
    self notify("hash_690aad79");
    if(!isDefined(self.var_4ebc7c98)) {
      self.var_4ebc7c98 = 0;
    }
    self.var_4ebc7c98 = self.var_4ebc7c98 + 0.1;
  } else {
    self thread zm_elemental_zombie::function_f4defbc2();
    if(!level flag::get("dragon_boss_start")) {
      self zombie_utility::set_zombie_run_cycle(self.zombie_move_speed_original);
    }
  }
}

function function_17d42ef() {
  self endon("death");
  self endon("disconnect");
  self.var_e3fc4787 = 1;
  if(self.is_zombie === 1 && self.completed_emerging_into_playable_area === 1) {
    self zombie_death::flame_death_fx();
  } else if(zm_utility::is_player_valid(self)) {
    self burnplayer::setplayerburning(1, 1, 0, self);
  }
  wait(1);
  self.var_e3fc4787 = 0;
}

function function_2dcfeeb9(var_777ffc66, n_duration) {
  level flag::set("dragon_hazard_active");
  self.var_3eb19318 = 1;
  self thread function_c6f5d03();
  exploder::exploder(level.var_5eab5443[var_777ffc66]);
  while(n_duration > 10) {
    wait(10);
    exploder::exploder_stop(level.var_5eab5443[var_777ffc66]);
    util::wait_network_frame();
    exploder::exploder(level.var_5eab5443[var_777ffc66]);
    n_duration = n_duration - 10;
  }
  wait(n_duration);
  exploder::exploder_stop(level.var_5eab5443[var_777ffc66]);
  switch (var_777ffc66) {
    case "start": {
      exploder::exploder("fxexp_403");
      break;
    }
    default: {
      break;
    }
  }
  self notify("hash_421b488f");
  level notify("hash_ed468118");
  self.var_3eb19318 = 0;
  foreach(player in level.activeplayers) {
    if(player.var_4ebc7c98 === level.var_8f92a57b.var_7cd42d94) {
      level flag::set("drshup_bathed_in_flame");
    }
  }
  if(isDefined(level.var_de98e3ce.var_d54b9ade.var_62ceb838)) {
    var_62ceb838 = level.var_de98e3ce.var_d54b9ade.var_62ceb838;
    if(var_62ceb838.var_4ebc7c98 === level.var_8f92a57b.var_7cd42d94) {
      level flag::set("egg_bathed_in_flame");
    }
  }
  level flag::clear("dragon_hazard_active");
}

function function_70d68a42() {
  while(true) {
    level flag::wait_till("dragon_console_triggered");
    level function_83dd194d();
    util::wait_network_frame();
  }
}

function function_517c3b8c() {
  var_50f98093 = [];
  var_4752d17a = [];
  foreach(player in level.activeplayers) {
    str_zone_name = player zm_zonemgr::get_player_zone();
    if(isDefined(str_zone_name)) {
      var_89bbe661 = undefined;
      switch (str_zone_name) {
        case "start_A_zone":
        case "start_B_zone":
        case "start_C_zone": {
          var_89bbe661 = "start";
          break;
        }
        case "alley_A_zone":
        case "alley_B_zone": {
          var_89bbe661 = "alley";
          break;
        }
        case "judicial_street_B_zone":
        case "judicial_street_zone": {
          var_89bbe661 = "opera_street";
          break;
        }
        case "department_store_floor2_A_zone":
        case "department_store_floor2_B_zone":
        case "department_store_floor3_A_zone":
        case "department_store_floor3_B_zone":
        case "department_store_floor3_C_zone":
        case "department_store_zone": {
          var_89bbe661 = "department_store";
          break;
        }
        case "factory_A_zone":
        case "factory_B_zone":
        case "factory_C_zone":
        case "factory_arm_zone": {
          var_89bbe661 = "factory";
          break;
        }
        case "library_A_zone":
        case "library_B_zone": {
          var_89bbe661 = "library";
          break;
        }
        case "powered_bridge_A_zone":
        case "red_brick_A_zone":
        case "red_brick_B_zone":
        case "red_brick_C_zone": {
          var_89bbe661 = "red_brick";
          break;
        }
        case "powered_bridge_B_zone":
        case "yellow_A_zone":
        case "yellow_B_zone":
        case "yellow_C_zone":
        case "yellow_D_zone": {
          var_89bbe661 = "yellow";
          break;
        }
        default: {
          var_89bbe661 = undefined;
          break;
        }
      }
      if(!array::contains(var_50f98093, var_89bbe661)) {
        var_4752d17a[var_4752d17a.size] = 1;
        var_50f98093[var_50f98093.size] = var_89bbe661;
        continue;
      }
      for(n_index = 0; var_50f98093[n_index] != var_89bbe661; n_index++) {}
      var_4752d17a[n_index]++;
    }
  }
  var_44faa778 = 1;
  while(var_44faa778) {
    var_44faa778 = 0;
    for(i = 1; i < var_4752d17a.size; i++) {
      if((var_4752d17a[i - 1]) < var_4752d17a[i]) {
        var_d697e552 = var_50f98093[i - 1];
        var_8da39cf7 = var_4752d17a[i - 1];
        var_50f98093[i - 1] = var_50f98093[i];
        var_4752d17a[i - 1] = var_4752d17a[i];
        var_50f98093[i] = var_d697e552;
        var_4752d17a[i] = var_8da39cf7;
        var_44faa778 = 1;
      }
    }
  }
  if(var_50f98093.size > 0 && !level.var_a8b674f9) {
    if(var_50f98093[0] == "department_store") {
      if(var_50f98093.size > 1) {
        return var_50f98093[1];
      }
      return undefined;
    }
  }
  return var_50f98093[0];
}

function function_71776fa5(var_19b50ade) {
  level.var_3be78871 = undefined;
  if(isDefined(var_19b50ade)) {
    if(isDefined(level.var_9ae0d334[var_19b50ade + "_exit"])) {
      level.var_3be78871 = level.var_9ae0d334[var_19b50ade + "_exit"];
    }
  }
}

function function_5bafaddd(var_5f982950, var_b1c60ae7) {
  var_cc373138 = getent("mdl_dragon_console_" + var_5f982950, "targetname");
  while(true) {
    level.var_67881099[var_5f982950] waittill("hash_9c0a67f3");
    foreach(var_fbb61447 in var_b1c60ae7) {
      if(!level flag::get(var_fbb61447 + "_console_cooldown")) {
        var_3db2a27f = getent("mdl_dragon_console_" + var_fbb61447, "targetname");
        var_3db2a27f showpart("tag_screen_red_animate");
        var_3db2a27f hidepart("tag_screen_green_animate");
        var_3db2a27f playSound("zmb_stalingrad_unavailable");
        var_3db2a27f.var_a3338832 = 0;
        level.var_f5464041[var_fbb61447] = 4;
      }
    }
    if(isDefined(level.var_9d19c7e)) {
      if(level.var_9d19c7e != var_5f982950) {
        level flag::set("dragon_reroute");
        level flag::clear("dragon_platform_arrive");
      }
    }
    level.var_9d19c7e = var_5f982950;
    var_cc373138 showpart("tag_screen_red_animate");
    var_cc373138 hidepart("tag_screen_green_animate");
    var_cc373138 playSound("zmb_stalingrad_buttons");
    var_cc373138.var_a3338832 = 0;
    var_5503da8a = getent("dragon_console_antenna_" + var_5f982950, "targetname");
    var_5503da8a thread scene::play("p7_fxanim_zm_stal_dragon_console_antenna_bundle", var_5503da8a);
    level thread zm_stalingrad_vo::function_4311e03d();
    level flag::set("dragon_console_triggered");
    level flag::wait_till("dragon_platform_arrive");
    level.var_f5464041[var_5f982950] = 6;
    if(!level flag::get("dragon_console_global_disable")) {
      foreach(var_fbb61447 in var_b1c60ae7) {
        if(!level flag::get(var_fbb61447 + "_console_cooldown")) {
          var_3db2a27f = getent("mdl_dragon_console_" + var_fbb61447, "targetname");
          var_3db2a27f hidepart("tag_screen_red_animate");
          var_3db2a27f showpart("tag_screen_green_animate");
          var_3db2a27f playSound("zmb_stalingrad_available");
          var_3db2a27f.var_a3338832 = 1;
          level.var_f5464041[var_fbb61447] = 3;
        }
      }
    }
    level flag::wait_till_any(array("dragon_platform_one_rider", "dragon_reroute"));
    if(level flag::get("dragon_console_global_disable")) {
      level.var_f5464041[var_5f982950] = 7;
      level flag::wait_till_any(array("dragon_rider_timeout", "dragon_full"));
      level.var_f5464041[var_5f982950] = 8;
      function_9fa4f2a3(var_5f982950, 0);
      level flag::wait_till_clear_all(array("dragon_platform_arrive", "dragon_platform_one_rider"));
      level flag::wait_till_clear("dragon_console_global_disable");
    } else {
      if(level flag::get("dragon_reroute")) {
        level.var_f5464041[var_5f982950] = 4;
        level flag::wait_till_clear("dragon_reroute");
        var_cc373138 hidepart("tag_screen_red_animate");
        var_cc373138 showpart("tag_screen_green_animate");
        var_cc373138.var_a3338832 = 1;
        level.var_f5464041[var_5f982950] = 3;
      } else {
        foreach(var_fbb61447 in var_b1c60ae7) {
          if(!level flag::get(var_fbb61447 + "_console_cooldown")) {
            var_3db2a27f = getent("mdl_dragon_console_" + var_fbb61447, "targetname");
            var_3db2a27f showpart("tag_screen_red_animate");
            var_3db2a27f hidepart("tag_screen_green_animate");
            var_3db2a27f playSound("zmb_stalingrad_unavailable");
            var_3db2a27f.var_a3338832 = 0;
            level.var_f5464041[var_fbb61447] = 4;
          }
        }
        level.var_f5464041[var_5f982950] = 7;
        level flag::wait_till_any(array("dragon_rider_timeout", "dragon_full"));
        level.var_f5464041[var_5f982950] = 8;
        level thread zm_stalingrad_vo::function_c9fde593();
        level flag::set(var_5f982950 + "_console_cooldown");
        foreach(var_fbb61447 in var_b1c60ae7) {
          if(!level flag::get(var_fbb61447 + "_console_cooldown")) {
            level thread function_66a21ca(var_fbb61447);
          }
        }
        level flag::wait_till_clear_all(array("dragon_platform_arrive", "dragon_platform_one_rider"));
        level.var_f5464041[var_5f982950] = 2;
        wait(level.var_5a45def9);
        if(!function_4a78ee23(var_b1c60ae7)) {
          function_496d5723(var_5f982950);
        } else {
          function_66a21ca(var_5f982950);
        }
        level flag::clear(var_5f982950 + "_console_cooldown");
        var_cc373138 playSound("zmb_stalingrad_cooldown_over");
      }
    }
  }
}

function function_4a78ee23(var_c7b41a30) {
  foreach(var_5f982950 in var_c7b41a30) {
    var_cc373138 = getent("mdl_dragon_console_" + var_5f982950, "targetname");
    if(!(isDefined(var_cc373138.var_a3338832) && var_cc373138.var_a3338832)) {
      return true;
    }
  }
  return false;
}

function function_66a21ca(var_5f982950) {
  level flag::wait_till_clear_all(array("dragon_platform_arrive", "dragon_platform_one_rider"));
  function_496d5723(var_5f982950);
}

function function_7ee20edb(var_5f982950) {
  var_cc373138 = getent("mdl_dragon_console_" + var_5f982950, "targetname");
  var_cc373138 hidepart("tag_screen_green_animate");
  var_cc373138 hidepart("tag_screen_red_animate");
  var_cc373138.var_a3338832 = 0;
  level.var_f5464041[var_5f982950] = 1;
  while(!level flag::exists("power_on")) {
    wait(1);
  }
  level flag::wait_till("power_on");
  var_cc373138 showpart("tag_screen_red_animate");
}

function function_9fa4f2a3(var_5f982950, var_68860b9a = 1) {
  var_cc373138 = getent("mdl_dragon_console_" + var_5f982950, "targetname");
  var_cc373138 hidepart("tag_screen_green_animate");
  var_cc373138 showpart("tag_screen_red_animate");
  var_cc373138.var_a3338832 = 0;
  if(var_68860b9a) {
    level.var_f5464041[var_5f982950] = 1;
  }
}

function function_496d5723(var_5f982950) {
  var_cc373138 = getent("mdl_dragon_console_" + var_5f982950, "targetname");
  var_cc373138 hidepart("tag_screen_red_animate");
  var_cc373138 showpart("tag_screen_green_animate");
  var_cc373138 playSound("zmb_stalingrad_available");
  var_cc373138.var_a3338832 = 1;
  level.var_f5464041[var_5f982950] = 3;
}

function function_eb1965f1(var_ffc320da) {
  s_unitrigger = spawnStruct();
  s_unitrigger.origin = self.origin;
  s_unitrigger.angles = self.angles;
  s_unitrigger.script_unitrigger_type = "unitrigger_radius_use";
  s_unitrigger.cursor_hint = "HINT_NOICON";
  s_unitrigger.require_look_at = 0;
  s_unitrigger.targetname = var_ffc320da;
  s_unitrigger.usetime = 350;
  s_unitrigger.var_395c2885 = 0;
  s_unitrigger.related_parent = self;
  s_unitrigger.radius = self.radius;
  s_unitrigger.height = self.height;
  zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger, 0);
  s_unitrigger.prompt_and_visibility_func = &function_bd21006c;
  zm_unitrigger::register_static_unitrigger(s_unitrigger, &function_8b508a1b);
  self.s_unitrigger = s_unitrigger;
}

function function_bd21006c(player) {
  if(!player zm_utility::is_player_looking_at(self.origin, 0.1, 0)) {
    self sethintstring("");
    return false;
  }
  if(!level flag::get("power_on")) {
    self sethintstring(&"ZM_STALINGRAD_POWER_REQUIRED");
    return false;
  }
  switch (level.var_f5464041[self.targetname]) {
    case 1: {
      self sethintstring(&"ZM_STALINGRAD_CONSOLE_DISABLED");
      break;
    }
    case 2: {
      self sethintstring(&"ZM_STALINGRAD_CONSOLE_COOLDOWN");
      break;
    }
    case 3: {
      if(player.var_e7d196cc === "dragon_wings") {
        var_d2b5a43f = 0;
      } else {
        var_d2b5a43f = 500;
      }
      self sethintstring(&"ZM_STALINGRAD_CONSOLE_DRAGON_SUMMON", var_d2b5a43f);
      break;
    }
    case 4: {
      self sethintstring(&"ZM_STALINGRAD_CONSOLE_DRAGON_BUSY");
      break;
    }
    case 5: {
      self sethintstring(&"ZM_STALINGRAD_CONSOLE_DRAGON_ON_THE_WAY");
      break;
    }
    case 6: {
      self sethintstring(&"ZM_STALINGRAD_CONSOLE_DRAGON_ARRIVED");
      break;
    }
    case 7: {
      self sethintstring(&"ZM_STALINGRAD_CONSOLE_DRAGON_TAKE_OFF_COUNTDOWN");
      break;
    }
    case 8: {
      self sethintstring(&"ZM_STALINGRAD_CONSOLE_DRAGON_ENROUTE_PAVLOVS");
      break;
    }
    default: {
      self sethintstring("");
      break;
    }
  }
  return true;
}

function function_8b508a1b() {
  self endon("kill_trigger");
  self.stub thread zm_unitrigger::run_visibility_function_for_all_triggers();
  while(true) {
    self waittill("trigger", player);
    var_422cea21 = level.var_f5464041[self.targetname];
    if(var_422cea21 == 3) {
      if(player != self.parent_player) {
        continue;
      }
      if(isDefined(player.screecher_weapon)) {
        continue;
      }
      if(!zm_utility::is_player_valid(player)) {
        player thread zm_utility::ignore_triggers(0.5);
        continue;
      }
      if(!player zm_score::can_player_purchase(500)) {
        player zm_audio::create_and_play_dialog("general", "transport_deny");
      } else {
        self.stub.related_parent notify("hash_9c0a67f3", player);
        player clientfield::increment_to_player("interact_rumble");
        if(player.var_e7d196cc !== "dragon_wings") {
          player zm_score::minus_to_player_score(500);
        }
        level.var_f5464041[self.targetname] = 5;
      }
    } else {
      if(!level flag::get("dragonride_crafted")) {
        level thread zm_stalingrad_vo::function_cfb82bef();
      } else if(var_422cea21 == 1 || var_422cea21 == 2 || var_422cea21 == 4 || var_422cea21 == 8) {
        level thread zm_stalingrad_vo::function_902b2a27();
      }
    }
    util::wait_network_frame();
  }
}

function function_90d81e44() {
  level flag::init("dragon_console_triggered");
  level flag::init("dragon_reroute");
  level flag::init("dragon_platform_arrive");
  level flag::init("dragon_platform_one_rider");
  level flag::init("dragon_rider_timeout");
  level flag::init("dragon_pavlov_first_time");
  level flag::init("library_console_cooldown");
  level flag::init("factory_console_cooldown");
  level flag::init("judicial_console_cooldown");
  level flag::init("dragon_full");
  level flag::init("dragon_console_global_disable");
  level.var_9d19c7e = undefined;
  level.var_67881099 = [];
  level.var_67881099["library"] = struct::get("t_dragon_console_library", "targetname");
  level.var_67881099["library"] function_eb1965f1("library");
  level.var_67881099["factory"] = struct::get("t_dragon_console_factory", "targetname");
  level.var_67881099["factory"] function_eb1965f1("factory");
  level.var_67881099["judicial"] = struct::get("t_dragon_console_judicial", "targetname");
  level.var_67881099["judicial"] function_eb1965f1("judicial");
  level.var_1db728f2 = [];
  level.var_1db728f2["library"] = struct::get_array("s_dragon_platform_library");
  level.var_1db728f2["library"] function_cad59534("library");
  level.var_1db728f2["factory"] = struct::get_array("s_dragon_platform_factory");
  level.var_1db728f2["factory"] function_cad59534("factory");
  level.var_1db728f2["judicial"] = struct::get_array("s_dragon_platform_judicial");
  level.var_1db728f2["judicial"] function_cad59534("judicial");
  level thread function_7ee20edb("library");
  level thread function_7ee20edb("factory");
  level thread function_7ee20edb("judicial");
  level thread function_70d68a42();
  level flag::wait_till("dragonride_crafted");
  function_496d5723("library");
  function_496d5723("factory");
  function_496d5723("judicial");
  level thread function_5bafaddd("library", array("factory", "judicial"));
  level thread function_5bafaddd("factory", array("library", "judicial"));
  level thread function_5bafaddd("judicial", array("library", "factory"));
}

function function_d21f20fe() {
  if(isDefined(level.var_9d19c7e)) {
    if(level.var_f5464041[level.var_9d19c7e] == 8) {
      level flag::wait_till_clear_all(array("dragon_platform_arrive", "dragon_platform_one_rider"));
      level flag::clear("dragon_console_global_disable");
      function_496d5723("library");
      function_496d5723("factory");
      function_496d5723("judicial");
    } else {
      level flag::clear("dragon_console_global_disable");
      switch (level.var_9d19c7e) {
        case "library": {
          function_496d5723("factory");
          function_496d5723("judicial");
          break;
        }
        case "factory": {
          function_496d5723("library");
          function_496d5723("judicial");
          break;
        }
        case "judicial": {
          function_496d5723("factory");
          function_496d5723("library");
          break;
        }
        default: {
          break;
        }
      }
    }
  } else {
    level flag::clear("dragon_console_global_disable");
    function_496d5723("library");
    function_496d5723("factory");
    function_496d5723("judicial");
  }
}

function dragon_console_global_disable() {
  level flag::set("dragon_console_global_disable");
  if(isDefined(level.var_9d19c7e)) {
    switch (level.var_9d19c7e) {
      case "library": {
        function_9fa4f2a3("factory");
        function_9fa4f2a3("judicial");
        break;
      }
      case "factory": {
        function_9fa4f2a3("library");
        function_9fa4f2a3("judicial");
        break;
      }
      case "judicial": {
        function_9fa4f2a3("factory");
        function_9fa4f2a3("library");
        break;
      }
      default: {
        function_9fa4f2a3("library");
        function_9fa4f2a3("factory");
        function_9fa4f2a3("judicial");
        break;
      }
    }
  }
}

function function_9a5142a() {
  return level.var_9d19c7e;
}

function function_69a0541c() {
  return level.var_777ffc66;
}

function function_8c8c2c29() {
  return level.var_163a43e4;
}

function player_intersection_tracker_override(other_player) {
  return true;
}

function craftable_use_hold_think(player) {
  self thread craftable_use_hold_think_internal(player);
  retval = self util::waittill_any_return("craft_succeed", "craft_failed", "dragon_ride_kill_trigger");
  if(retval == "craft_succeed") {
    return true;
  }
  return false;
}

function function_76121f8c(s_unitrigger) {
  self endon("craft_succeed");
  self endon("craft_failed");
  s_unitrigger waittill("kill_trigger");
  self notify("dragon_ride_kill_trigger");
}

function craftable_use_hold_think_internal(player) {
  wait(0.01);
  if(!isDefined(self)) {
    return;
  }
  self.craft_time = self.usetime;
  self.craft_start_time = gettime();
  craft_time = self.craft_time;
  craft_start_time = self.craft_start_time;
  if(craft_time > 0) {
    player zm_utility::disable_player_move_states(1);
    player zm_utility::increment_is_drinking();
    player thread player_progress_bar(craft_start_time, craft_time);
    while(isDefined(self) && player player_continue_crafting(self) && (gettime() - self.craft_start_time) < self.craft_time) {
      wait(0.05);
    }
    player notify("craftable_progress_end");
    player playsoundtoplayer("zmb_dragon_mount", player);
    if(isDefined(player.is_drinking) && player.is_drinking) {
      player zm_utility::decrement_is_drinking();
    }
    player zm_utility::enable_player_move_states();
  }
  if(isDefined(self)) {
    if(player player_continue_crafting(self) && (self.craft_time <= 0 || (gettime() - self.craft_start_time) >= self.craft_time)) {
      self notify("craft_succeed");
      if(isDefined(player.usebartext)) {
        player.usebartext hud::destroyelem();
        player.usebartext = undefined;
      }
      if(isDefined(player.usebar)) {
        player.usebar hud::destroyelem();
        player.usebar = undefined;
      }
    } else {
      self notify("craft_failed");
    }
  }
}

function player_progress_bar(start_time, craft_time) {
  self.usebar = self hud::createprimaryprogressbar();
  self.usebartext = self hud::createprimaryprogressbartext();
  if(isDefined(self) && isDefined(start_time) && isDefined(craft_time)) {
    self player_progress_bar_update(start_time, craft_time);
  }
  if(isDefined(self.usebartext)) {
    self.usebartext hud::destroyelem();
    self.usebartext = undefined;
  }
  if(isDefined(self.usebar)) {
    self.usebar hud::destroyelem();
    self.usebar = undefined;
  }
}

function player_progress_bar_update(start_time, craft_time) {
  self endon("entering_last_stand");
  self endon("death");
  self endon("disconnect");
  self endon("craftable_progress_end");
  self endon("craft_succeed");
  while(isDefined(self) && (gettime() - start_time) < craft_time) {
    progress = (gettime() - start_time) / craft_time;
    if(progress < 0) {
      progress = 0;
    }
    if(progress > 1) {
      progress = 1;
    }
    self.usebar hud::updatebar(progress);
    wait(0.05);
  }
}

function player_continue_crafting(t_console) {
  if(self laststand::player_is_in_laststand() || self zm_utility::in_revive_trigger()) {
    return false;
  }
  if(isDefined(self.screecher)) {
    return false;
  }
  if(!self usebuttonpressed()) {
    return false;
  }
  trigger = t_console.stub zm_unitrigger::unitrigger_trigger(self);
  torigin = t_console.stub.origin;
  porigin = self getEye();
  radius_sq = (2.25 * t_console.stub.radius) * t_console.stub.radius;
  var_422cea21 = level.var_f5464041[trigger.targetname];
  var_395c2885 = t_console.stub.var_395c2885;
  if(var_395c2885 == 0 && var_422cea21 != 3) {
    return false;
  }
  if(var_395c2885 == 1 && var_422cea21 < 6) {
    return false;
  }
  if(distance2dsquared(torigin, porigin) > radius_sq) {
    return false;
  }
  if(!isDefined(trigger) || !trigger istouching(self)) {
    return false;
  }
  if(var_395c2885 == 0 && !self util::is_player_looking_at(trigger.origin, 0.1, 0)) {
    return false;
  }
  return true;
}

function function_cad59534(var_ffc320da) {
  foreach(s_unitrigger_stub in self) {
    s_unitrigger = spawnStruct();
    s_unitrigger.origin = s_unitrigger_stub.origin;
    s_unitrigger.angles = s_unitrigger_stub.angles;
    s_unitrigger.script_unitrigger_type = "unitrigger_radius_use";
    s_unitrigger.cursor_hint = "HINT_NOICON";
    s_unitrigger.require_look_at = 0;
    s_unitrigger.targetname = var_ffc320da;
    s_unitrigger.usetime = 350;
    s_unitrigger.var_395c2885 = 1;
    s_unitrigger.related_parent = s_unitrigger_stub;
    s_unitrigger.radius = s_unitrigger_stub.radius;
    s_unitrigger.height = s_unitrigger_stub.height;
    zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger, 1);
    s_unitrigger.prompt_and_visibility_func = &function_cd9b4bf3;
    zm_unitrigger::register_static_unitrigger(s_unitrigger, &function_69f9b2b8);
    s_unitrigger_stub.s_unitrigger = s_unitrigger;
  }
}

function function_cd9b4bf3(player) {
  var_422cea21 = level.var_f5464041[self.targetname];
  w_current = player getcurrentweapon();
  if(player zm_utility::has_hero_weapon() || w_current == getweapon("launcher_dragon_strike") || w_current == getweapon("launcher_dragon_strike_upgraded") || w_current == getweapon("minigun")) {
    self sethintstring("");
    return false;
  }
  if(var_422cea21 == 6 || var_422cea21 == 7 && !array::contains(level.var_163a43e4, player)) {
    self sethintstring(&"ZM_STALINGRAD_RIDE_DRAGON");
    return true;
  }
  self sethintstring("");
  return false;
}

function function_69f9b2b8() {
  self endon("kill_trigger");
  self.stub thread zm_unitrigger::run_visibility_function_for_all_triggers();
  while(true) {
    self waittill("trigger", player);
    var_422cea21 = level.var_f5464041[self.targetname];
    if(var_422cea21 == 6 || var_422cea21 == 7) {
      if(player != self.parent_player) {
        continue;
      }
      if(isDefined(player.screecher_weapon)) {
        continue;
      }
      w_current = player getcurrentweapon();
      if(player zm_utility::has_hero_weapon() || w_current == getweapon("launcher_dragon_strike") || w_current == getweapon("launcher_dragon_strike_upgraded") || w_current == getweapon("minigun")) {
        continue;
      }
      if(!zm_utility::is_player_valid(player)) {
        player thread zm_utility::ignore_triggers(0.5);
        continue;
      }
      trigger = self.stub zm_unitrigger::unitrigger_trigger(player);
      trigger thread function_31efd8da(player);
    }
    util::wait_network_frame();
  }
}

function function_31efd8da(player) {
  self endon("kill_trigger");
  player thread function_76121f8c(self);
  result = self craftable_use_hold_think(player);
  if(result) {
    player thread function_280af5e8();
  }
}

function function_280af5e8() {
  self endon("disconnect");
  self endon("death");
  if(!array::contains(level.var_163a43e4, self)) {
    level.var_428b5b88++;
    if(level.activeplayers.size == 1) {
      var_ce48aee6 = "tag_passenger" + level.var_3f756142;
    } else {
      var_ce48aee6 = "tag_passenger" + level.var_428b5b88;
    }
    array::add(level.var_163a43e4, self);
    self thread function_d1ac3943();
    self bgb::suspend_weapon_cycling();
    self enableinvulnerability();
    self.var_fa6d2a24 = 1;
    self zm_utility::increment_ignoreme();
    self.var_4222bc21 = 1;
    self thread zm_stalingrad_vo::function_cf8fccfe(1);
    v_angles = level.var_e29dd7ca gettagangles(var_ce48aee6);
    self setplayerangles((0, v_angles[1], 0));
    self playerlinktodelta(level.var_e29dd7ca, var_ce48aee6, 1, 45, 45, 80, 10, 1, 1);
    if(level.var_163a43e4.size == 1) {
      level flag::set("dragon_platform_one_rider");
      level thread function_51d28faf();
      level thread function_4e945eab();
    }
  }
  if(level.var_428b5b88 == level.activeplayers.size) {
    level flag::set("dragon_full");
    level thread function_825bb926();
  }
}

function function_d1ac3943() {
  level endon("hash_9a634383");
  self waittill("disconnect");
  arrayremovevalue(level.var_163a43e4, self);
}

function function_fce6cca8(v_target_origin, var_2a65eda2) {
  self endon("death");
  self endon("disconnect");
  var_848f1155 = spawn("script_model", self.origin);
  var_848f1155 setModel("tag_origin");
  var_848f1155.angles = var_2a65eda2;
  self playerlinktodelta(var_848f1155, "tag_origin", 1, 45, 45, 45, 45, 0, 0);
  self notsolid();
  var_848f1155 notsolid();
  self clientfield::set("dragon_transport_eject", 1);
  self playSound("zmb_dragon_eject");
  self playLoopSound("zmb_dragon_fly_lp");
  self thread zm_stalingrad_vo::function_cf8fccfe(0);
  n_time = var_848f1155 zm_utility::fake_physicslaunch(v_target_origin, 400);
  wait(n_time);
  self clientfield::set("dragon_transport_eject", 0);
  self stoploopsound(0.5);
  self solid();
  var_848f1155 delete();
  self notify("hash_2e47bc4a");
  self disableinvulnerability();
  self zm_utility::decrement_ignoreme();
  self.var_4222bc21 = 0;
  self bgb::resume_weapon_cycling();
  if(!level flag::get("dragon_pavlov_first_time")) {
    level flag::set("dragon_pavlov_first_time");
  }
  wait(4);
  self.var_fa6d2a24 = 0;
}

function function_3f0f5f61() {
  s_pavlov_player = struct::get_array("s_pavlov_player", "targetname");
  var_9544a498 = 0;
  var_58151835 = 0;
  foreach(player in level.var_163a43e4) {
    var_58151835++;
    if(array::contains(level.activeplayers, player)) {
      player scene::stop();
      player unlink();
      player freezecontrols(0);
      player enableweapons();
      player enableoffhandweapons();
      player zm_weapons::switch_back_primary_weapon(player.var_de933247, 0);
      if(level.activeplayers.size == 1) {
        var_ce48aee6 = "tag_passenger" + level.var_3f756142;
      } else {
        var_ce48aee6 = "tag_passenger" + var_58151835;
      }
      player playerlinktoabsolute(level.var_e29dd7ca, var_ce48aee6);
      wait(0.05);
      if(isDefined(player)) {
        player playerlinktodelta(level.var_e29dd7ca, var_ce48aee6, 1, 45, 45, 80, 10, 1, 1);
        player thread function_900a9386();
      }
    }
  }
  level.var_fc730f22 = [];
  wait(2);
  foreach(player in level.var_163a43e4) {
    if(array::contains(level.activeplayers, player)) {
      player unlink();
      if(level.activeplayers.size == 1) {
        var_ce48aee6 = "tag_passenger" + level.var_3f756142;
        var_2a65eda2 = level.var_e29dd7ca gettagangles(var_ce48aee6);
        player thread function_fce6cca8(s_pavlov_player[level.var_3f756142 - 1].origin, var_2a65eda2);
      } else {
        var_ce48aee6 = "tag_passenger" + (var_9544a498 + 1);
        var_2a65eda2 = level.var_e29dd7ca gettagangles(var_ce48aee6);
        player thread function_fce6cca8(s_pavlov_player[var_9544a498].origin, var_2a65eda2);
      }
      wait(0.4);
    }
    var_9544a498++;
  }
  level.var_163a43e4 = [];
  level.var_428b5b88 = 0;
  level notify("hash_9a634383");
}

function function_900a9386() {
  while(!self zm_zonemgr::entity_in_zone("pavlovs_B_zone")) {
    wait(0.5);
  }
  self clientfield::set_to_player("dragon_transportation_exploders", 0);
}

function function_4e945eab() {
  str_exploder_name = "dragon_transport_alert_" + level.var_9d19c7e;
  exploder::exploder(str_exploder_name);
}

function function_825bb926() {
  str_exploder_name = "dragon_transport_alert_" + level.var_9d19c7e;
  exploder::exploder_stop(str_exploder_name);
}

function function_3c66b6ec(var_2c17cb9d) {
  level.var_357a65b attach(level.var_7b6aff02[var_2c17cb9d]);
}

function function_4f5115c6(var_2c17cb9d) {
  level.var_357a65b detach(level.var_7b6aff02[var_2c17cb9d]);
}

function function_63326db4(b_debug = 0) {
  level endon("hash_a35dee4e");
  level flag::set("dragon_boss_start");
  level thread util::clientnotify("dfs");
  level.var_357a65b.b_override_explosive_damage_cap = 1;
  level thread function_80c3dfb0(1);
  level clientfield::set("deactivate_ai_vox", 1);
  if(b_debug) {
    level flag::set("");
    dragon_boss_intro_init();
    function_17b7a6a();
  }
  zm_spawner::deregister_zombie_death_event_callback(&namespace_2e6e7fce::function_1389d425);
  level zm_stalingrad_util::function_3804dbf1();
  zm_stalingrad_util::function_adf4d1d0();
  util::wait_network_frame();
  level zm_zonemgr::enable_zone("boss_arena_zone");
  level thread function_4e639a6a();
  level.whelp_no_power_up_pickup = 1;
  function_c0e035d6("boss_arena_spawn");
  level thread scene::play("cin_sta_vign_mech_intro");
  zm::register_player_damage_callback(&function_6689dfc5);
  wait(14);
  level.var_357a65b clientfield::set("dragon_mouth_fx", 1);
  level scene::play("cin_t7_ai_zm_dlc3_dragon_boss_fight_intro_b");
}

function function_c0e035d6(str_spawn, var_bf7e118f = 0, var_8f4dddff = 1) {
  if(level.round_number < 20) {
    zombie_utility::ai_calculate_health(20);
  }
  var_ad0ee644 = struct::get_array(str_spawn, "targetname");
  var_ad0ee644 = array::filter(var_ad0ee644, 0, &zm_stalingrad_util::function_c66f2957);
  if(!var_bf7e118f) {
    level notify("stop_dragon_boss_zombie");
    wait(1);
    level thread zm_stalingrad_util::function_f70dde0b(level.zombie_spawners[0], var_ad0ee644, str_spawn, level.var_e66ebd0c[level.activeplayers.size - 1], 1.25, undefined, "stop_dragon_boss_zombie", 0);
  } else {
    level notify("stop_dragon_boss_zombie");
    wait(1);
    n_zombie_count = (level.var_e66ebd0c[level.activeplayers.size - 1]) - ((level.var_8447be11[level.activeplayers.size - 1]) * var_8f4dddff);
    level thread zm_stalingrad_util::function_f70dde0b(level.zombie_spawners[0], var_ad0ee644, str_spawn, n_zombie_count, 1.25, undefined, "stop_dragon_boss_zombie", 0);
    level thread zm_stalingrad_util::function_b55ebb81(undefined, undefined, (level.var_8447be11[level.activeplayers.size - 1]) * var_8f4dddff, 1, 0, "stop_dragon_boss_zombie");
  }
}

function function_17b7a6a() {
  var_41b8920e = struct::get_array("s_dragon_boss_debug_player", "targetname");
  n_player = 0;
  foreach(player in level.activeplayers) {
    player setorigin(var_41b8920e[n_player].origin);
    player setplayerangles(var_41b8920e[n_player].angles);
    n_player++;
  }
}

function function_ffa0a9ed() {
  level.var_553153a1 = [];
  level.var_553153a1["south"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_idle_b";
  level.var_553153a1["east"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_idle_a";
  level.var_553153a1["west"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_idle_c";
  level.var_2cd19c16 = [];
  level.var_2cd19c16["south"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_idle_b_loop";
  level.var_2cd19c16["east"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_idle_a_loop";
  level.var_2cd19c16["west"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_idle_c_loop";
  level.var_7804ba2f = [];
  level.var_7804ba2f["south"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_attack_b";
  level.var_7804ba2f["east"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_attack_a";
  level.var_7804ba2f["west"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_attack_c";
  level.var_f6d7d191 = [];
  level.var_f6d7d191["south"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_takeoff_b";
  level.var_f6d7d191["east"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_takeoff_a";
  level.var_f6d7d191["west"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_takeoff_c";
  level.var_89507cd6 = [];
  level.var_89507cd6["south"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_hover_fire_b";
  level.var_89507cd6["east"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_hover_fire_a";
  level.var_89507cd6["west"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_hover_fire_c";
  level.var_10b5de68 = [];
  level.var_10b5de68["south"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_hover_idle_b";
  level.var_10b5de68["east"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_hover_idle_a";
  level.var_10b5de68["west"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_hover_idle_c";
  level.var_2c32671c = [];
  level.var_2c32671c["south"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_landing_b";
  level.var_2c32671c["east"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_landing_a";
  level.var_2c32671c["west"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_landing_c";
  level.var_6bda5d71 = [];
  level.var_6bda5d71["south"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_taunt_b";
  level.var_6bda5d71["east"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_taunt_a";
  level.var_6bda5d71["west"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_taunt_c";
  level.var_c3753bf4 = [];
  level.var_c3753bf4["a_2_b"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_move_a_2_b";
  level.var_c3753bf4["b_2_a"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_move_b_2_a";
  level.var_c3753bf4["b_2_c"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_move_b_2_c";
  level.var_c3753bf4["c_2_b"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_move_c_2_b";
  level.var_614028f9 = [];
  level.var_614028f9[1]["south"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_pain_hvy_b";
  level.var_614028f9[1]["east"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_pain_hvy_a";
  level.var_614028f9[1]["west"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_pain_hvy_c";
  level.var_614028f9[2]["south"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_pain_hvy_b";
  level.var_614028f9[2]["east"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_pain_hvy_a";
  level.var_614028f9[2]["west"] = "cin_t7_ai_zm_dlc3_dragon_boss_fight_pain_hvy_c";
  level flag::init("dragon_interrupt");
  scene::add_scene_func("cin_t7_ai_zm_dlc3_dragon_boss_fight_death_b", &function_6593b39c, "play");
  scene::add_scene_func("cin_t7_ai_zm_dlc3_dragon_boss_fight_death_b", &function_4d11a596, "done");
  scene::add_scene_func("p7_fxanim_zm_stal_dragon_chunks_bundle", &function_d0a25c9e, "play");
  scene::add_scene_func("cin_t7_ai_zm_dlc3_dragon_boss_fight_intro_b", &function_883bba2, "done");
  scene::add_scene_func("cin_t7_ai_zm_dlc3_dragon_boss_fight_lance_pain_shoulder_a", &function_b138e200, "play");
  scene::add_scene_func("cin_t7_ai_zm_dlc3_dragon_boss_fight_lance_pain_belly_c", &function_b138e200, "play");
  scene::add_scene_func("cin_t7_ai_zm_dlc3_dragon_boss_fight_lance_pain_neck_b", &function_b138e200, "play");
  scene::add_scene_func("cin_t7_ai_zm_dlc3_dragon_boss_fight_lance_pain_shoulder_a", &function_4fd8b482, "done");
  scene::add_scene_func("cin_t7_ai_zm_dlc3_dragon_boss_fight_lance_pain_belly_c", &function_4fd8b482, "done");
  scene::add_scene_func("cin_t7_ai_zm_dlc3_dragon_boss_fight_lance_pain_neck_b", &function_4fd8b482, "done");
  scene::add_scene_func("cin_sta_1st_boss_transition_dempsey", &function_8d48f9f7, "play", 0);
  scene::add_scene_func("cin_sta_1st_boss_transition_nikolai", &function_8d48f9f7, "play", 1);
  scene::add_scene_func("cin_sta_1st_boss_transition_richtofen", &function_8d48f9f7, "play", 2);
  scene::add_scene_func("cin_sta_1st_boss_transition_takeo", &function_8d48f9f7, "play", 3);
  scene::add_scene_func("cin_sta_1st_boss_transition_dempsey", &dragon_boss_transition_dempsey_done, "done");
  scene::add_scene_func("cin_sta_1st_boss_transition_nikolai", &dragon_boss_transition_nikolai_done, "done");
  scene::add_scene_func("cin_sta_1st_boss_transition_richtofen", &dragon_boss_transition_richtofen_done, "done");
  scene::add_scene_func("cin_sta_1st_boss_transition_takeo", &dragon_boss_transition_takeo_done, "done");
  scene::add_scene_func("cin_sta_vign_mech_intro", &function_109151c2, "init");
  scene::add_scene_func("cin_sta_vign_mech_intro", &function_bd0972bc, "done");
  scene::add_scene_func("", &function_e73b4306, "");
  scene::add_scene_func("", &function_a2ac4477, "");
}

function function_b138e200(a_ents) {
  level waittill("hash_f095f38c");
  level.var_ef6a691++;
  level.var_7a29ed06++;
  function_3c66b6ec(level.var_ef6a691);
  level.var_357a65b clientfield::set("dragon_wound_glow_on", level.var_ef6a691);
  level.var_ef9c43d7 thread function_7aaaf6eb();
}

function function_7aaaf6eb() {
  self endon("hash_bfb2d45a");
  if(!isDefined(self.var_d38bf7e6)) {
    str_vo_alias = "vox_nik1_dragon_boss_hint_";
    self.var_d38bf7e6[2] = [];
    for(i = 0; i < 3; i++) {
      if(!isDefined(self.var_d38bf7e6[2])) {
        self.var_d38bf7e6[2] = [];
      } else if(!isarray(self.var_d38bf7e6[2])) {
        self.var_d38bf7e6[2] = array(self.var_d38bf7e6[2]);
      }
      self.var_d38bf7e6[2][self.var_d38bf7e6[2].size] = str_vo_alias + i;
    }
    self.var_d38bf7e6[1] = [];
    j = 3;
    while(i < 6) {
      if(!isDefined(self.var_d38bf7e6[1])) {
        self.var_d38bf7e6[1] = [];
      } else if(!isarray(self.var_d38bf7e6[1])) {
        self.var_d38bf7e6[1] = array(self.var_d38bf7e6[1]);
      }
      self.var_d38bf7e6[1][self.var_d38bf7e6[1].size] = str_vo_alias + i;
      i++;
    }
    self.var_d38bf7e6[3] = [];
    for(i = 6; i < 9; i++) {
      if(!isDefined(self.var_d38bf7e6[3])) {
        self.var_d38bf7e6[3] = [];
      } else if(!isarray(self.var_d38bf7e6[3])) {
        self.var_d38bf7e6[3] = array(self.var_d38bf7e6[3]);
      }
      self.var_d38bf7e6[3][self.var_d38bf7e6[3].size] = str_vo_alias + i;
    }
  }
  while(true) {
    wait(randomfloatrange(15, 25));
    var_448853df = array::random(self.var_d38bf7e6[level.var_ef6a691]);
    self.var_fa4643fb thread zm_stalingrad_vo::function_897246e4(var_448853df);
  }
}

function function_4fd8b482(a_ents) {
  level flag::clear("dragon_boss_vignette");
  level flag::set("dragon_boss_takedamage");
  level.var_b04a9a70 = 1;
  level thread function_c40e4649(level.var_b04a9a70);
}

function function_d76099a6() {
  level.var_e66ebd0c = array(18, 20, 22, 24);
  level.var_8447be11 = array(1, 1, 2, 2);
  level.var_ce49fa61 = array(10000, 13000, 16000, 19000);
}

function dragon_boss_init() {
  level.var_357a65b setModel("c_zom_dlc3_dragon_body_boss_hazard");
  foreach(var_5cd4afc1 in level.var_553153a1) {
    scene::add_scene_func(var_5cd4afc1, &function_cab64a16, "play");
    scene::add_scene_func(var_5cd4afc1, &function_3bc22c00, "done");
  }
  foreach(var_a4070b4f in level.var_7804ba2f) {
    scene::add_scene_func(var_a4070b4f, &function_c08b162c, "play");
    scene::add_scene_func(var_a4070b4f, &function_8226b1a6, "done");
  }
  foreach(var_13dbb8bc in level.var_2c32671c) {
    scene::add_scene_func(var_13dbb8bc, &function_b499c281, "play");
    scene::add_scene_func(var_13dbb8bc, &function_cbded78b, "done");
  }
  foreach(var_3ee20f11 in level.var_6bda5d71) {
    scene::add_scene_func(var_3ee20f11, &function_c24d6636, "play");
    scene::add_scene_func(var_3ee20f11, &function_33594820, "done");
    scene::add_scene_func(var_3ee20f11 + "_v2", &function_c24d6636, "play");
    scene::add_scene_func(var_3ee20f11 + "_v2", &function_33594820, "done");
  }
  foreach(var_b4464c14 in level.var_c3753bf4) {
    scene::add_scene_func(var_b4464c14, &function_829c1ad9, "play");
    scene::add_scene_func(var_b4464c14, &function_3b09a8e3, "done");
  }
  scene::add_scene_func("cin_t7_ai_zm_dlc3_dragon_boss_fight_pain_hvy_a", &function_da9435cb, "play");
  scene::add_scene_func("cin_t7_ai_zm_dlc3_dragon_boss_fight_pain_hvy_b", &function_da9435cb, "play");
  scene::add_scene_func("cin_t7_ai_zm_dlc3_dragon_boss_fight_pain_hvy_c", &function_da9435cb, "play");
  scene::add_scene_func("cin_t7_ai_zm_dlc3_dragon_boss_fight_pain_hvy_a", &function_a1be712d, "done");
  scene::add_scene_func("cin_t7_ai_zm_dlc3_dragon_boss_fight_pain_hvy_b", &function_a1be712d, "done");
  scene::add_scene_func("cin_t7_ai_zm_dlc3_dragon_boss_fight_pain_hvy_c", &function_a1be712d, "done");
  level.var_81fa8ec0 = 0;
  level.var_62ebede = 0;
  level.var_cbe80f3e = 0;
  level.var_181b1223 = "south";
  level.var_b04a9a70 = 0;
  level.var_7a29ed06 = 1;
  level.var_ef6a691 = 0;
  level flag::clear("dragon_boss_takedamage");
  level.var_7b6aff02[1] = "c_zom_dlc3_dragon_body_boss_wound_shoulder";
  level.var_7b6aff02[2] = "c_zom_dlc3_dragon_body_boss_wound_belly";
  level.var_7b6aff02[3] = "c_zom_dlc3_dragon_body_boss_wound_throat";
  level.var_61699bd7[1] = array("j_overshoulder_ri_anim_wound", "j_shoulder_ri_anim_wound");
  level.var_61699bd7[2] = array("j_spine_2_anim_wound", "j_spine_3_anim_wound");
  level.var_61699bd7[3] = array("j_neck_7_anim_wound", "j_neck_6_anim_wound");
  level.var_299d7581[1] = 15;
  level.var_299d7581[2] = 20;
  level.var_299d7581[3] = 20;
  level.var_357a65b clientfield::set("dragon_notify_bullet_impact", 1);
  level.var_9f0dc220 = level.var_ce49fa61[level.activeplayers.size - 1];
  level thread function_9f54bfc4();
  level flag::set("dragon_boss_init");
}

function function_b1bbbd8f() {
  level endon("hash_a35dee4e");
  while(true) {
    level flag::wait_till("dragon_boss_vignette");
    while(!dragon_boss_vignette_ready() || !function_1a2d9dc9()) {
      wait(0.1);
    }
    wait(0.75);
    level flag::set("dragon_boss_vignette_ready");
  }
}

function function_109151c2(a_ents) {
  level.var_ef9c43d7 = a_ents["dragon_nikolai"];
  level.var_ef9c43d7.targetname = "nikolai_siegebot";
  level.var_ef9c43d7 setteam("allies");
  level.var_ef9c43d7.takedamage = 0;
  level.var_ef9c43d7 enablelinkto();
  level.var_ef9c43d7 sethighdetail(0);
  level.var_ef9c43d7 vehicle_ai::set_state("special_attack");
  level.var_ef9c43d7 hidepart("tag_heat_vent_01_d1");
  level.var_ef9c43d7 hidepart("tag_heat_vent_02_d1");
  level.var_ef9c43d7 hidepart("tag_heat_vent_03_d1");
  level.var_ef9c43d7 hidepart("tag_heat_vent_04_d1");
  level.var_ef9c43d7 hidepart("tag_heat_vent_05_d1");
  level.var_ef9c43d7 hidepart("tag_heat_vent_05_d2");
  level.var_ef9c43d7.var_fa4643fb = a_ents["nikolai_driver"];
  level.var_ef9c43d7 setturrettargetrelativeangles((0, 0, 0), 0);
  level.var_ef9c43d7 setturrettargetrelativeangles((0, 0, 0), 1);
  level.var_ef9c43d7 setturrettargetrelativeangles((0, 0, 0), 2);
  level.var_ef9c43d7 setturrettargetrelativeangles((0, 0, 0), 3);
  level.var_ef9c43d7 setturrettargetrelativeangles((0, 0, 0), 4);
  level.var_4c8e35f4 = [];
  posts = struct::get_array("nd_dragon_nikolai", "targetname");
  foreach(post in posts) {
    level.var_4c8e35f4[post.script_string] = post;
  }
  level.var_1564d2c8 = [];
  posts = struct::get_array("dragon_boss_post", "targetname");
  foreach(post in posts) {
    level.var_1564d2c8[post.script_string] = post;
  }
  level.var_ef9c43d7.var_1c9faafd = level.var_ef9c43d7 function_b1a4952d();
  level thread scene::play("cin_sta_intro_3rd_crashed_mech_loop");
}

function function_bd0972bc(a_ents) {
  level.var_ef9c43d7 notify("end_attack_thread_gun");
  level.var_ef9c43d7 thread function_32faa6e1();
  level notify("hash_2425bb5b");
  level.var_ef9c43d7 thread siegebot_nikolai::function_f7035c2f(level.var_ef9c43d7.var_fa4643fb);
}

function function_cab64a16(a_ents) {
  level endon("dragon_interrupt");
  level endon("hash_a35dee4e");
}

function function_3bc22c00(a_ents) {
  level endon("dragon_interrupt");
  level endon("hash_a35dee4e");
  if(level flag::get("dragon_boss_vignette")) {
    if(!dragon_boss_vignette_ready()) {
      level.var_b04a9a70 = 4;
      level thread function_c40e4649(level.var_b04a9a70);
    } else {
      level.var_b04a9a70 = 5;
      level thread function_c40e4649(level.var_b04a9a70);
    }
  } else if(!flag::get("dragon_interrupt")) {
    level.var_81fa8ec0++;
    if(level.var_81fa8ec0 <= 1 || level.var_ef6a691 == 3) {
      while(level.var_b04a9a70 == 0) {
        level.var_b04a9a70 = function_cf6274b2();
      }
    } else {
      level.var_b04a9a70 = 4;
    }
    level thread function_c40e4649(level.var_b04a9a70);
  }
}

function function_c08b162c(a_ents) {
  level endon("dragon_interrupt");
  level endon("hash_a35dee4e");
  if(!flag::get("dragon_interrupt") && !flag::get("world_is_paused")) {
    var_777ffc66 = "boss_" + level.var_181b1223;
    level thread function_3d1f7c2e(level.var_357a65b, var_777ffc66, 1, 1);
    level thread function_21146aa(level.var_357a65b, var_777ffc66);
    level thread function_d4556285(level.var_357a65b, var_777ffc66);
  }
}

function function_bf4afe33() {
  level endon("hash_a35dee4e");
  if(level scene::is_playing("cin_t7_ai_zm_dlc3_dragon_boss_fight_idle_a_loop") || level scene::is_playing("cin_t7_ai_zm_dlc3_dragon_boss_fight_idle_b_loop") || level scene::is_playing("cin_t7_ai_zm_dlc3_dragon_boss_fight_idle_c_loop")) {
    return true;
  }
  return false;
}

function dragon_boss_vignette_ready() {
  level endon("hash_a35dee4e");
  if(level.var_7a29ed06 == 1) {
    if(level.var_181b1223 != "east" || !function_bf4afe33()) {
      return false;
    }
    return true;
  }
  if(level.var_7a29ed06 == 2) {
    if(level.var_181b1223 != "west" || !function_bf4afe33()) {
      return false;
    }
    return true;
  }
  if(level.var_7a29ed06 == 3) {
    if(level.var_181b1223 != "south" || !function_bf4afe33()) {
      return false;
    }
    return true;
  }
  return false;
}

function function_1a2d9dc9() {
  level endon("hash_a35dee4e");
  if(level.var_ef9c43d7.var_1163fa40 === 1) {
    return false;
  }
  var_b1a4952d = level.var_ef9c43d7 function_b1a4952d();
  var_7649b699 = undefined;
  if(isDefined(var_b1a4952d)) {
    var_7649b699 = var_b1a4952d.script_string;
  }
  if(level.var_7a29ed06 == 1 && var_7649b699 === "north") {
    return true;
  }
  if(level.var_7a29ed06 == 2 && var_7649b699 === "north") {
    return true;
  }
  if(level.var_7a29ed06 == 3 && var_7649b699 === "west") {
    return true;
  }
  if(level.var_ef9c43d7.var_11643dca === 1) {
    return true;
  }
  return false;
}

function function_8226b1a6(a_ents) {
  level endon("dragon_interrupt");
  level endon("hash_a35dee4e");
  if(level flag::get("dragon_boss_vignette")) {
    if(!dragon_boss_vignette_ready()) {
      level.var_b04a9a70 = 4;
      level thread function_c40e4649(level.var_b04a9a70);
    } else {
      level.var_b04a9a70 = 5;
      level thread function_c40e4649(level.var_b04a9a70);
    }
  } else if(!flag::get("dragon_interrupt")) {
    level.var_62ebede++;
    if(level.var_62ebede <= 2 || level.var_ef6a691 == 3) {
      while(level.var_b04a9a70 == 1) {
        level.var_b04a9a70 = function_cf6274b2();
      }
    } else {
      level.var_b04a9a70 = 4;
    }
    level thread function_c40e4649(level.var_b04a9a70);
  }
}

function function_3a34c204() {
  self endon("hash_7869a7a5");
  level endon("hash_a35dee4e");
  var_6646a04b = getweapon("launcher_dragon_fireball");
  self waittill("hash_5556f7b");
  var_201fdf35 = level.var_357a65b gettagorigin("tag_aim");
  a_e_players = arraysortclosest(level.activeplayers, var_201fdf35);
  e_player = array::random(a_e_players);
  v_facing = anglesToForward(e_player getplayerangles());
  v_velocity = e_player getvelocity() + v_facing;
  v_velocity = (v_velocity[0], v_velocity[1], 0);
  var_f840b1a7 = vectornormalize(v_velocity);
  var_4cc0e23c = e_player.origin;
  for(i = 0; i < 3; i++) {
    var_270cdd14 = anglesToForward((0, randomintrange(-180, 180), 0));
    v_target_origin = var_4cc0e23c + (var_270cdd14 * randomintrange(36, 72));
    self thread function_98ee9e20(i, var_6646a04b, v_target_origin);
    util::wait_network_frame();
    var_4cc0e23c = var_4cc0e23c + (var_f840b1a7 * 256);
  }
}

function function_98ee9e20(n_number, var_6646a04b, v_target_origin, e_player) {
  ground_trace = bulletTrace(v_target_origin + vectorscale((0, 0, 1), 128), v_target_origin + (vectorscale((0, 0, -1), 500)), 0, e_player);
  e_fx = fx::play("meatball_impact", ground_trace["position"], (0, 0, 0), "stop_meatball_impact");
  self waittill("hash_49fa08aa");
  if(n_number) {
    wait(n_number * 0.1);
  }
  var_201fdf35 = level.var_357a65b gettagorigin("tag_aim");
  var_aa911866 = magicbullet(var_6646a04b, var_201fdf35, v_target_origin, level.var_357a65b);
  var_aa911866 waittill("death");
  e_fx delete();
}

function function_b499c281(a_ents) {
  level endon("hash_a35dee4e");
}

function function_cbded78b(a_ents) {
  level endon("hash_a35dee4e");
  level flag::clear("dragon_boss_in_air");
  if(level flag::get("dragon_boss_vignette")) {
    if(!dragon_boss_vignette_ready()) {
      level.var_b04a9a70 = 4;
      level thread function_c40e4649(level.var_b04a9a70);
    } else {
      level.var_b04a9a70 = 5;
      level thread function_c40e4649(level.var_b04a9a70);
    }
  } else {
    a_ents["dragon_hazard"] notify("hash_7869a7a5");
    level.var_62ebede++;
    level.var_b04a9a70 = 0;
    level thread function_c40e4649(level.var_b04a9a70);
  }
}

function function_c24d6636(a_ents) {
  level endon("dragon_interrupt");
  level endon("hash_a35dee4e");
}

function function_33594820(a_ents) {
  level endon("dragon_interrupt");
  level endon("hash_a35dee4e");
  if(level flag::get("dragon_boss_vignette")) {
    if(!dragon_boss_vignette_ready()) {
      level.var_b04a9a70 = 4;
      level thread function_c40e4649(level.var_b04a9a70);
    } else {
      level.var_b04a9a70 = 5;
      level thread function_c40e4649(level.var_b04a9a70);
    }
  } else if(!flag::get("dragon_interrupt")) {
    level.var_cbe80f3e++;
    if(level.var_cbe80f3e <= 1 || level.var_ef6a691 == 3) {
      while(level.var_b04a9a70 == 3) {
        level.var_b04a9a70 = function_cf6274b2();
      }
    } else {
      level.var_b04a9a70 = 4;
    }
    level thread function_c40e4649(level.var_b04a9a70);
  }
}

function function_829c1ad9(a_ents) {
  level endon("hash_a35dee4e");
  level flag::set("dragon_boss_in_air");
}

function function_3b09a8e3(a_ents) {
  level endon("hash_a35dee4e");
  level flag::clear("dragon_boss_in_air");
  level.var_ef9c43d7 notify("reselect_goal");
  level.var_181b1223 = level.var_5494305;
  level.var_5494305 = undefined;
  if(level flag::get("dragon_boss_vignette")) {
    if(!dragon_boss_vignette_ready()) {
      level.var_b04a9a70 = 4;
      level thread function_c40e4649(level.var_b04a9a70);
    } else {
      level.var_b04a9a70 = 5;
      level thread function_c40e4649(level.var_b04a9a70);
    }
  } else {
    level.var_81fa8ec0 = 0;
    level.var_62ebede = 0;
    level.var_cbe80f3e = 0;
    while(level.var_b04a9a70 == 4) {
      level.var_b04a9a70 = function_cf6274b2();
    }
    level thread function_c40e4649(level.var_b04a9a70);
  }
}

function function_da9435cb(a_ents) {
  level endon("hash_a35dee4e");
  level flag::clear("dragon_boss_takedamage");
  level.var_357a65b clientfield::set("dragon_body_glow", 0);
  level.var_9f0dc220 = level.var_ce49fa61[level.activeplayers.size - 1];
  switch (level.var_ef6a691) {
    case 1: {
      str_tag = "j_shoulder_ri_wound_fx";
      break;
    }
    case 2: {
      str_tag = "j_spine_3_anim_wound_fx";
      break;
    }
    case 3: {
      str_tag = "j_neck_6_anim_wound_fx";
      break;
    }
  }
  playFXOnTag(level._effect["dragon_weakpoint_destroyed"], level.var_357a65b, str_tag);
  level.var_357a65b clientfield::set("dragon_wound_glow_off", level.var_ef6a691);
}

function function_a1be712d(a_ents) {
  level endon("hash_a35dee4e");
  level flag::clear("dragon_interrupt");
  if(level.var_ef6a691 < 3) {
    level.var_b04a9a70 = 4;
    level thread function_c40e4649(level.var_b04a9a70);
  }
  if(level.var_ef6a691 == 1) {
    function_c0e035d6("boss_arena_spawn", 1);
  } else if(level.var_ef6a691 == 2) {
    function_c0e035d6("boss_arena_spawn", 1, 2);
  }
}

function function_6593b39c(a_ents) {
  level flag::set("dragon_boss_dead");
  foreach(e_player in level.players) {
    e_player.var_4222bc21 = 1;
  }
  level.whelp_no_power_up_pickup = undefined;
  level clientfield::set("dragon_boss_guts", 1);
  level.var_357a65b waittill("hash_537f8baf");
  level thread util::clientnotify("dfss");
}

function function_4d11a596(a_ents) {
  level clientfield::set("dragon_boss_guts", 2);
  level scene::play("p7_fxanim_zm_stal_dragon_chunks_bundle");
  foreach(e_player in level.players) {
    level scoreevents::processscoreevent("main_EE_quest_stalingrad_dragon", e_player);
  }
}

function function_d0a25c9e(a_ents) {
  foreach(player in level.players) {
    if(player laststand::player_is_in_laststand()) {
      self reviveplayer();
      self notify("player_revived");
      self notify("stop_revive_trigger");
      if(isDefined(self.revivetrigger)) {
        self.revivetrigger delete();
        self.revivetrigger = undefined;
      }
    }
  }
  level zm_stalingrad_util::function_e7c75cf0();
  wait(4.5);
  level thread function_2a3b64e3();
}

function function_2a3b64e3() {
  level flag::clear("dragon_boss_start");
  level lui::screen_fade_out(1, "white");
  level thread function_47b84e6b();
  level thread function_11044369();
  level util::waittill_any("dragon_boss_transition_dempsey_done", "dragon_boss_transition_nikolai_done", "dragon_boss_transition_richtofen_done", "dragon_boss_transition_takeo_done");
  function_ee289cd();
}

function function_b55a5517() {
  self endon("disconnect");
  switch (self.characterindex) {
    case 0: {
      var_573ab4fb = "cin_sta_1st_boss_transition_dempsey";
      break;
    }
    case 1: {
      var_573ab4fb = "cin_sta_1st_boss_transition_nikolai";
      break;
    }
    case 2: {
      var_573ab4fb = "cin_sta_1st_boss_transition_richtofen";
      break;
    }
    case 3: {
      var_573ab4fb = "cin_sta_1st_boss_transition_takeo";
      break;
    }
  }
  self setinvisibletoall();
  self scene::play(var_573ab4fb, self);
  self setvisibletoall();
  self.var_4222bc21 = 0;
}

function function_8d48f9f7(a_ents, var_765a3ab1) {
  foreach(player in level.players) {
    if(player.characterindex != var_765a3ab1) {
      foreach(ent in a_ents) {
        ent setinvisibletoplayer(player, 1);
      }
      continue;
    }
    switch (player.characterindex) {
      case 0: {
        var_97c1eada = "mech_demp";
        break;
      }
      case 1: {
        var_97c1eada = "mech_nik";
        break;
      }
      case 2: {
        var_97c1eada = "mech_rich";
        break;
      }
      case 3: {
        var_97c1eada = "mech_takeo";
        break;
      }
    }
    var_206fd092 = a_ents[var_97c1eada];
    var_206fd092 hidepart("tag_heat_vent_01_d1");
    var_206fd092 hidepart("tag_heat_vent_02_d1");
    var_206fd092 hidepart("tag_heat_vent_03_d1");
    var_206fd092 hidepart("tag_heat_vent_04_d1");
    var_206fd092 hidepart("tag_heat_vent_05_d1");
    var_206fd092 hidepart("tag_heat_vent_05_d2");
  }
}

function dragon_boss_transition_dempsey_done(a_ents) {
  level notify("dragon_boss_transition_dempsey_done");
}

function dragon_boss_transition_nikolai_done(a_ents) {
  level notify("dragon_boss_transition_nikolai_done");
}

function dragon_boss_transition_richtofen_done(a_ents) {
  level notify("dragon_boss_transition_richtofen_done");
}

function dragon_boss_transition_takeo_done(a_ents) {
  level notify("dragon_boss_transition_takeo_done");
}

function function_47b84e6b() {
  stopallrumbles();
  wait(2);
  foreach(e_player in level.players) {
    e_player thread function_b55a5517();
  }
  wait(1.5);
  level thread lui::screen_fade_in(1, "white");
  level waittill("fadeout");
  level thread lui::screen_fade_out(1, "white");
}

function function_ee289cd() {
  level thread lui::screen_fade_in(1, "white");
  level thread function_471551b5();
}

function function_883bba2(a_ents) {
  dragon_boss_init();
  level.var_357a65b thread function_2ce58010();
  level thread function_262689b5();
  function_c0e035d6("boss_arena_spawn");
}

function function_96eb8639() {
  var_f72c48e9 = randomfloat(1);
  if(var_f72c48e9 <= 0.5) {
    if(!level flag::get("dragon_hazard_active")) {
      return 1;
    }
    if(level.var_ef6a691 >= 2) {
      return 2;
    }
    return 3;
  }
  if(level.var_ef6a691 >= 2) {
    return 2;
  }
  return 3;
}

function function_cf6274b2() {
  level endon("dragon_interrupt");
  level endon("hash_a35dee4e");
  var_94bcf41e = randomfloat(1);
  if(level.var_ef6a691 < 3) {
    if(var_94bcf41e <= 0.05) {
      return 0;
    }
    if(var_94bcf41e > 0.05 && var_94bcf41e <= 0.9) {
      return function_96eb8639();
    }
    if(var_94bcf41e > 0.9 && var_94bcf41e <= 0.95) {
      return 3;
    }
    if(var_94bcf41e > 0.95 && var_94bcf41e <= 1) {
      return 4;
    }
  } else {
    if(var_94bcf41e <= 0.1) {
      return 0;
    }
    if(var_94bcf41e > 0.1 && var_94bcf41e <= 0.85) {
      return function_96eb8639();
    }
    if(var_94bcf41e > 0.85 && var_94bcf41e <= 1) {
      return 3;
    }
  }
}

function function_bba545e9() {
  level endon("hash_a35dee4e");
  if(math::cointoss()) {
    return level.var_6bda5d71[level.var_181b1223];
  }
  return level.var_6bda5d71[level.var_181b1223] + "_v2";
}

function function_c40e4649(var_94bcf41e) {
  level endon("dragon_interrupt");
  level endon("hash_a35dee4e");
  switch (var_94bcf41e) {
    case 0: {
      level scene::play(level.var_553153a1[level.var_181b1223]);
      jump loc_0000D450;
    }
    case 5: {
      level scene::play(level.var_2cd19c16[level.var_181b1223]);
      jump loc_0000D450;
    }
    case 1: {
      level scene::play(level.var_7804ba2f[level.var_181b1223]);
      jump loc_0000D450;
    }
    case 2: {
      level function_6a9f428b();
      jump loc_0000D450;
    }
    case 3: {
      level scene::play(function_bba545e9());
      jump loc_0000D450;
    }
    case 4: {
      if(level flag::get("dragon_boss_vignette")) {
        switch (level.var_7a29ed06) {
          case 1: {
            if(level.var_181b1223 == "south") {
              level.var_5494305 = "east";
              level scene::play("cin_t7_ai_zm_dlc3_dragon_boss_fight_move_b_2_a");
            } else {
              if(level.var_181b1223 == "west") {
                level.var_5494305 = "south";
                level scene::play("cin_t7_ai_zm_dlc3_dragon_boss_fight_move_c_2_b");
              } else {
                level.var_b04a9a70 = 5;
                level scene::play(level.var_2cd19c16[level.var_181b1223]);
              }
            }
            break;
          }
          case 2: {
            if(level.var_181b1223 == "south") {
              level.var_5494305 = "west";
              level scene::play("cin_t7_ai_zm_dlc3_dragon_boss_fight_move_b_2_c");
            } else {
              if(level.var_181b1223 == "east") {
                level.var_5494305 = "south";
                level scene::play("cin_t7_ai_zm_dlc3_dragon_boss_fight_move_a_2_b");
              } else {
                level.var_b04a9a70 = 5;
                level scene::play(level.var_2cd19c16[level.var_181b1223]);
              }
            }
            break;
          }
          case 3: {
            if(level.var_181b1223 == "east") {
              level.var_5494305 = "south";
              level scene::play("cin_t7_ai_zm_dlc3_dragon_boss_fight_move_a_2_b");
            } else {
              if(level.var_181b1223 == "west") {
                level.var_5494305 = "south";
                level scene::play("cin_t7_ai_zm_dlc3_dragon_boss_fight_move_c_2_b");
              } else {
                level.var_b04a9a70 = 5;
                level scene::play(level.var_2cd19c16[level.var_181b1223]);
              }
            }
            break;
          }
          default: {
            break;
          }
        }
      } else {
        if(level.var_181b1223 == "south") {
          if(level.var_ef6a691 <= 2) {
            var_4b07f20e = randomfloat(1);
            if(var_4b07f20e <= 0.5) {
              level.var_5494305 = "east";
              level scene::play("cin_t7_ai_zm_dlc3_dragon_boss_fight_move_b_2_a");
            } else {
              level.var_5494305 = "west";
              level scene::play("cin_t7_ai_zm_dlc3_dragon_boss_fight_move_b_2_c");
            }
          } else {
            level scene::play(function_bba545e9());
            level.var_b04a9a70 = 3;
          }
        } else {
          if(level.var_181b1223 == "east") {
            level.var_5494305 = "south";
            level scene::play("cin_t7_ai_zm_dlc3_dragon_boss_fight_move_a_2_b");
          } else if(level.var_181b1223 == "west") {
            level.var_5494305 = "south";
            level scene::play("cin_t7_ai_zm_dlc3_dragon_boss_fight_move_c_2_b");
          }
        }
      }
      break;
    }
    default: {
      break;
    }
  }
}

function function_6a9f428b() {
  level endon("hash_a35dee4e");
  level flag::set("dragon_boss_in_air");
  level scene::play(level.var_f6d7d191[level.var_181b1223]);
  level.var_357a65b clientfield::set("dragon_body_glow", 1);
  level scene::play(level.var_10b5de68[level.var_181b1223]);
  var_d5b51315 = randomintrange(2, 4);
  if(level.var_ef6a691 == 3) {
    var_d5b51315++;
  }
  for(i = 0; i < var_d5b51315; i++) {
    level.var_357a65b thread function_3a34c204();
    level scene::play(level.var_89507cd6[level.var_181b1223]);
  }
  level.var_357a65b clientfield::set("dragon_body_glow", 0);
  level scene::play(level.var_2c32671c[level.var_181b1223]);
  level flag::clear("dragon_boss_in_air");
  if(level flag::get("dragon_boss_vignette")) {
    if(!dragon_boss_vignette_ready()) {
      level.var_b04a9a70 = 4;
      level thread function_c40e4649(level.var_b04a9a70);
    } else {
      level.var_b04a9a70 = 5;
      level thread function_c40e4649(level.var_b04a9a70);
    }
  } else {
    level.var_357a65b notify("hash_7869a7a5");
    level.var_62ebede++;
    level.var_b04a9a70 = 0;
    level thread function_c40e4649(level.var_b04a9a70);
  }
}

function function_262689b5() {
  level endon("hash_a35dee4e");
  level.var_181b1223 = "south";
  level thread function_c40e4649(1);
}

function function_2ce58010() {
  level endon("hash_a35dee4e");
  while(true) {
    self waittill("damage", n_damage, attacker, direction_vec, point, type, modelname, tagname, partname, weapon, idflags);
    if(isplayer(attacker) && level flag::get("dragon_boss_takedamage") && !level flag::get("world_is_paused")) {
      foreach(var_61c194b7 in level.var_61699bd7[level.var_ef6a691]) {
        if(var_61c194b7 == partname) {
          level.var_ef9c43d7 notify("hash_bfb2d45a");
          level.var_9f0dc220 = level.var_9f0dc220 - n_damage;
          if(damagefeedback::dodamagefeedback(weapon, undefined, n_damage, type)) {
            attacker thread damagefeedback::update(type, attacker);
          }
          if(level.var_9f0dc220 <= 0 && !level flag::get("dragon_boss_in_air")) {
            level flag::set("dragon_interrupt");
            if(level.var_ef6a691 <= 2) {
              level.var_357a65b scene::stop();
              level scene::play(level.var_614028f9[level.var_ef6a691][level.var_181b1223]);
              continue;
            }
            level thread function_8a29cbcb();
            return;
          }
        }
      }
    }
  }
}

function function_8a29cbcb() {
  function_30560c4b();
  level.var_357a65b clientfield::set("dragon_body_glow", 1);
  for(i = 1; i <= 3; i++) {
    level.var_357a65b clientfield::set("dragon_wound_glow_on", i);
  }
  level scene::play("cin_t7_ai_zm_dlc3_dragon_boss_fight_death_b");
  function_cf119cfd();
}

function function_471551b5(b_debug = 0) {
  level flag::set("nikolai_start");
}

function function_30560c4b() {
  level notify("hash_dfaade1d");
  level notify("hash_a35dee4e");
  level notify("stop_dragon_boss_zombie");
  level thread zm_stalingrad_util::function_adf4d1d0();
  level thread function_80c3dfb0(0);
  level clientfield::set("deactivate_ai_vox", 0);
  level.var_357a65b scene::stop();
  level.var_357a65b clientfield::set("dragon_notify_bullet_impact", 0);
  level.var_7a29ed06 = 1;
  level.var_ef6a691 = 0;
}

function function_cf119cfd() {
  foreach(var_5cd4afc1 in level.var_553153a1) {
    scene::remove_scene_func(var_5cd4afc1, &function_cab64a16, "play");
    scene::remove_scene_func(var_5cd4afc1, &function_3bc22c00, "done");
  }
  foreach(var_a4070b4f in level.var_7804ba2f) {
    scene::remove_scene_func(var_a4070b4f, &function_c08b162c, "play");
    scene::remove_scene_func(var_a4070b4f, &function_8226b1a6, "done");
  }
  foreach(var_13dbb8bc in level.var_2c32671c) {
    scene::remove_scene_func(var_13dbb8bc, &function_b499c281, "play");
    scene::remove_scene_func(var_13dbb8bc, &function_cbded78b, "done");
  }
  foreach(var_3ee20f11 in level.var_6bda5d71) {
    scene::remove_scene_func(var_3ee20f11, &function_c24d6636, "play");
    scene::remove_scene_func(var_3ee20f11, &function_33594820, "done");
    scene::remove_scene_func(var_3ee20f11 + "_v2", &function_c24d6636, "play");
    scene::remove_scene_func(var_3ee20f11 + "_v2", &function_33594820, "done");
  }
  foreach(var_b4464c14 in level.var_c3753bf4) {
    scene::remove_scene_func(var_b4464c14, &function_829c1ad9, "play");
    scene::remove_scene_func(var_b4464c14, &function_3b09a8e3, "done");
  }
  scene::remove_scene_func("cin_t7_ai_zm_dlc3_dragon_boss_fight_pain_hvy_a", &function_da9435cb, "play");
  scene::remove_scene_func("cin_t7_ai_zm_dlc3_dragon_boss_fight_pain_hvy_b", &function_da9435cb, "play");
  scene::remove_scene_func("cin_t7_ai_zm_dlc3_dragon_boss_fight_pain_hvy_c", &function_da9435cb, "play");
  scene::remove_scene_func("cin_t7_ai_zm_dlc3_dragon_boss_fight_pain_hvy_a", &function_a1be712d, "done");
  scene::remove_scene_func("cin_t7_ai_zm_dlc3_dragon_boss_fight_pain_hvy_b", &function_a1be712d, "done");
  scene::remove_scene_func("cin_t7_ai_zm_dlc3_dragon_boss_fight_pain_hvy_c", &function_a1be712d, "done");
  level flag::clear("dragon_boss_init");
  level.var_357a65b.var_caa5308f delete();
  level.var_357a65b delete();
}

function function_80c3dfb0(turnon) {
  if(turnon) {
    level.musicsystemoverride = 1;
    music::setmusicstate("dragon_fight");
  } else {
    music::setmusicstate("none");
    level.musicsystemoverride = 0;
  }
}

function function_285a7d29() {
  level scene::init("cin_sta_vign_mech_intro");
}

function function_11044369() {
  level.var_ef9c43d7 notify("stop_dragon_nikolai_think");
  level.var_ef9c43d7.var_fa4643fb delete();
  util::wait_network_frame();
  level.var_ef9c43d7 delete();
  level.var_ef9c43d7 = undefined;
}

function function_30e5b419(s_pos, str_pos, var_6e2a6191, var_4827e728) {
  if(s_pos.script_string == str_pos) {
    return false;
  }
  if(s_pos.script_string === var_6e2a6191) {
    return false;
  }
  if(s_pos.script_string === var_4827e728) {
    return false;
  }
  return true;
}

function function_b1a4952d() {
  if(isDefined(self.var_b1a4952d) && distance2dsquared(self.origin, self.var_b1a4952d.origin) < (100 * 100)) {
    return self.var_b1a4952d;
  }
  foreach(post in level.var_4c8e35f4) {
    if(distance2dsquared(self.origin, post.origin) < (100 * 100)) {
      self.var_b1a4952d = post;
      return post;
    }
  }
}

function attack_thread_gun() {
  self endon("death");
  self endon("change_state");
  self endon("end_attack_thread");
  self notify("end_attack_thread_gun");
  self endon("end_attack_thread_gun");
  self endon("stop_dragon_nikolai_think");
  count = 0;
  while(true) {
    if(count < 5) {
      wait(0.05);
    } else {
      count = 0;
      wait(1);
    }
    enemy = undefined;
    var_7c574538 = 10000 * 10000;
    zombies = getaiteamarray(level.zombie_team);
    foreach(player in level.activeplayers) {
      foreach(zombie in zombies) {
        if(isalive(zombie) && isalive(player)) {
          if(self getspeed() > 5) {
            forward = self getvelocity();
            forward = (forward[0], forward[1], 0);
            forward = vectornormalize(forward);
            var_2a039b93 = zombie.origin - self.origin;
            var_2a039b93 = (var_2a039b93[0], var_2a039b93[1], 0);
            var_2a039b93 = vectornormalize(var_2a039b93);
            if(vectordot(forward, var_2a039b93) < 0.17) {
              continue;
            }
          }
          distsqr = distancesquared(player.origin, zombie.origin);
          if(distsqr < var_7c574538) {
            var_7c574538 = distsqr;
            enemy = zombie;
          }
          if(distsqr < (60 * 60)) {
            break;
          }
        }
      }
      if(distsqr < (60 * 60)) {
        break;
      }
    }
    if(!isDefined(enemy)) {
      self setturrettargetrelativeangles((0, 0, 0), 0);
      self setturrettargetrelativeangles((0, 0, 0), 1);
      self setturrettargetrelativeangles((0, 0, 0), 2);
      wait(0.1);
      continue;
    }
    self setlookatent(enemy);
    self vehicle_ai::setturrettarget(enemy, 0);
    offset = (enemy.origin - enemy getEye()) * 0.8;
    self vehicle_ai::setturrettarget(enemy, 1, offset);
    var_eb3cc6f2 = gettime();
    do {
      wait(0.2);
    }
    while(isalive(enemy) && !self.gunner1ontarget && vehicle_ai::timesince(var_eb3cc6f2) < 1);
    while(isalive(enemy) && self vehseenrecently(enemy, 1) && count < 5) {
      self vehicle_ai::fire_for_rounds(1, 1);
      count++;
    }
  }
}

function function_32faa6e1(no_delay = 0) {
  self endon("stop_dragon_nikolai_think");
  self setCanDamage(0);
  self thread attack_thread_gun();
  if(!no_delay) {
    wait(1);
  }
  self.var_11643dca = undefined;
  while(true) {
    if(level flag::get("dragon_boss_vignette") && self.var_a079fbeb !== 1) {
      var_2edd3c78 = self.radius * 0.6;
      self setneargoalnotifydist(var_2edd3c78);
      var_2443f661 = undefined;
      var_90863f97 = undefined;
      switch (level.var_7a29ed06) {
        case 1: {
          var_2443f661 = "east";
          var_90863f97 = "north";
          break;
        }
        case 2: {
          var_2443f661 = "west";
          var_90863f97 = "north";
          break;
        }
        case 3: {
          var_2443f661 = "south";
          var_90863f97 = "west";
          break;
        }
        default: {
          break;
        }
      }
      self.var_1163fa40 = 1;
      goalpos = level.var_4c8e35f4[var_90863f97].origin;
      if(!function_1a2d9dc9() && distance2dsquared(goalpos, self.origin) > (var_2edd3c78 * var_2edd3c78)) {
        self setvehgoalpos(goalpos, 1, 1);
        foundpath = self vehicle_ai::waittill_pathresult();
        if(foundpath) {
          self setbrake(0);
          self asmrequestsubstate("locomotion@movement");
          self vehicle_ai::waittill_pathing_done();
          self cancelaimove();
          self clearvehgoalpos();
          self setbrake(1);
        }
      }
      self thread function_f3810a1d(var_2443f661);
      wait(0.2);
      continue;
    }
    self setneargoalnotifydist(self.radius);
    var_b1a4952d = self function_b1a4952d();
    var_7649b699 = undefined;
    if(isDefined(var_b1a4952d)) {
      var_7649b699 = var_b1a4952d.script_string;
    }
    var_f315c28 = array::filter(level.var_4c8e35f4, 0, &function_30e5b419, level.var_181b1223, var_7649b699);
    var_2cd775bb = array::random(var_f315c28);
    self setvehgoalpos(var_2cd775bb.origin, 1, 1);
    foundpath = self vehicle_ai::waittill_pathresult();
    if(foundpath) {
      self setbrake(0);
      self asmrequestsubstate("locomotion@movement");
      var_47314356 = self util::waittill_any_return("near_goal", "goal", "reselect_goal", "stop_dragon_nikolai_think");
      self cancelaimove();
      self clearvehgoalpos();
      self setbrake(1);
      if(var_47314356 != "reselect_goal") {
        var_7a6fe6cc = randomintrange(5, 8);
        self util::waittill_any_timeout(var_7a6fe6cc, "reselect_goal", "stop_dragon_nikolai_think");
      }
    }
  }
}

function function_6689dfc5(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
  if(isDefined(level.var_ef9c43d7) && eattacker === level.var_ef9c43d7) {
    return 0;
  }
  return idamage;
}

function function_5b3d5084(var_8a585abc) {
  self endon("stop_dragon_nikolai_think");
  if(var_8a585abc) {
    v_target = level.var_357a65b gettagorigin(level.var_61699bd7[level.var_ef6a691][0]);
  } else {
    v_target = level.var_357a65b.origin;
  }
  self vehicle_ai::setturrettarget(v_target, 2);
  self siegebot_nikolai::face_target(v_target, 15);
  spike = self fireweapon(2);
  spike util::waittill_notify_or_timeout("death", 3);
  self cleargunnertarget(1);
  self clearturrettarget();
}

function function_4e639a6a() {
  level endon("dragon_boss_dead");
  s_dragon_boss_full_ammo = struct::get("s_dragon_boss_full_ammo", "targetname");
  while(true) {
    level waittill("hash_2425bb5b");
    var_93eb638b = zm_powerups::specific_powerup_drop("full_ammo", s_dragon_boss_full_ammo.origin);
    var_93eb638b notify("powerup_reset");
    level thread function_bdbc171f(var_93eb638b);
    var_93eb638b waittill("powerup_grabbed");
  }
}

function function_bdbc171f(var_93eb638b) {
  var_93eb638b endon("powerup_grabbed");
  level waittill("nikolai_complete");
  if(isDefined(var_93eb638b)) {
    var_93eb638b thread zm_powerups::powerup_timeout();
  }
}

function function_9f54bfc4() {
  level endon("hash_a35dee4e");
  level thread function_b1bbbd8f();
  while(true) {
    wait(level.var_299d7581[level.var_7a29ed06]);
    level flag::set("dragon_boss_vignette");
    level.var_ef9c43d7 notify("reselect_goal");
    level flag::wait_till("dragon_boss_vignette_ready");
    switch (level.var_7a29ed06) {
      case 1: {
        level.var_ef9c43d7 function_a08562dc("cin_t7_ai_zm_dlc3_dragon_boss_fight_lance_pain_shoulder_a", "lance_shoulder@stationary", "o_zm_dlc3_dragon_boss_fight_lance_pain_shoulder_a");
        break;
      }
      case 2: {
        level.var_ef9c43d7 function_a08562dc("cin_t7_ai_zm_dlc3_dragon_boss_fight_lance_pain_belly_c", "lance_belly@stationary", "o_zm_dlc3_dragon_boss_fight_lance_pain_belly_c");
        break;
      }
      case 3: {
        level.var_ef9c43d7 function_a08562dc("cin_t7_ai_zm_dlc3_dragon_boss_fight_lance_pain_neck_b", "lance_neck@stationary", "o_zm_dlc3_dragon_boss_fight_lance_pain_neck_b");
        break;
      }
      default: {
        break;
      }
    }
    level flag::wait_till_clear("dragon_boss_vignette");
    level flag::clear("dragon_boss_vignette_ready");
    level.var_ef9c43d7.var_a079fbeb = undefined;
    if(level.var_ef6a691 == 3) {
      return;
    }
    level flag::wait_till("dragon_interrupt");
  }
}

function function_f3810a1d(var_2443f661) {
  self notify("hash_f3810a1d");
  self endon("hash_f3810a1d");
  var_9e426197 = level.var_1564d2c8[var_2443f661];
  while(true) {
    if(distance2dsquared(level.var_357a65b.origin, var_9e426197.origin) < (300 * 300)) {
      break;
    }
    wait(0.05);
  }
  self notify("stop_dragon_nikolai_think");
  self setturrettargetrelativeangles((0, 0, 0), 0);
  self setturrettargetrelativeangles((0, 0, 0), 1);
  self setturrettargetrelativeangles((0, 0, 0), 2);
  self setturrettargetrelativeangles((0, 0, 0), 3);
  self setturrettargetrelativeangles((0, 0, 0), 4);
  self setlookatent(level.var_357a65b);
  self vehicle_ai::setturrettarget(level.var_357a65b, 0);
  self siegebot_nikolai::face_target(var_9e426197.origin, 20, 0);
  self.var_1163fa40 = undefined;
  self.var_11643dca = 1;
}

function function_a08562dc(scriptbundlename, var_4ee9a8c8, var_8d89a2d7) {
  self notify("stop_dragon_nikolai_think");
  self thread function_719d5095(var_8d89a2d7);
  level thread scene::play(scriptbundlename);
  self asmrequestsubstate(var_4ee9a8c8);
  self vehicle_ai::waittill_asm_complete(var_4ee9a8c8, 10);
  self asmrequestsubstate("locomotion@movement");
  wait(0.4);
  self.var_a079fbeb = 1;
  self thread function_32faa6e1(1);
}

function function_719d5095(animname) {
  self endon("death");
  self util::waittill_notify_or_timeout("fire_harpoon_pre", 2);
  align = struct::get("tag_align_dragon_path", "targetname");
  origin = self gettagorigin("tag_gunner_flash2");
  angles = self gettagangles("tag_gunner_flash2");
  harpoon = spawn("script_model", origin);
  harpoon setModel("veh_t7_dlc3_mech_nikolai_harpoon_large");
  harpoon.angles = angles;
  harpoon useanimtree($generic);
  playFXOnTag("dlc3/stalingrad/fx_mech_wpn_harpoon_trail_vignette", harpoon, "tag_origin");
  self util::waittill_notify_or_timeout("fire_harpoon", 0.1);
  harpoon animation::play(animname, align, undefined, 1, 0.1, 0.1, 0.8, 0);
  wait(0.2);
  harpoon delete();
}

function function_c4fdcc57(harpoon) {
  start = gettime();
  oldorigin = harpoon.origin;
  while(isDefined(harpoon)) {
    debugstar(harpoon.origin, 1000000, (0, 1, 0));
    line(oldorigin, harpoon.origin, (1, 0, 0), 1, 0, 1000000);
    randvec = vectornormalize(math::random_vector(1)) * 100;
    oldorigin = harpoon.origin;
    wait(0.05);
  }
}

function function_aaf7e575() {
  if(isDefined(self.var_4222bc21) && self.var_4222bc21) {
    return false;
  }
  return true;
}

function function_16734812() {
  level notify("hash_dfaade1d");
  util::wait_network_frame();
  level.var_777ffc66 = "";
  level thread dragon_hazard(1);
}

function function_e7982921() {
  level notify("hash_dfaade1d");
  util::wait_network_frame();
  level.var_777ffc66 = "";
  level thread dragon_hazard(1);
}

function function_cfe0d523() {
  level notify("hash_dfaade1d");
  util::wait_network_frame();
  level.var_777ffc66 = "";
  level thread dragon_hazard(1);
}

function function_5f0cb06e() {
  level notify("hash_dfaade1d");
  util::wait_network_frame();
  level.var_777ffc66 = "";
  level thread dragon_hazard(1);
}

function function_84bd37c8() {
  level notify("hash_dfaade1d");
  util::wait_network_frame();
  level.var_777ffc66 = "";
  level thread dragon_hazard(1);
}

function dragon_hazard_library() {
  level notify("hash_dfaade1d");
  util::wait_network_frame();
  level.var_777ffc66 = "";
  level thread dragon_hazard(1);
}

function function_7977857() {
  level notify("hash_dfaade1d");
  util::wait_network_frame();
  level.var_777ffc66 = "";
  level thread dragon_hazard(1);
}

function function_b8de630a() {
  level notify("hash_dfaade1d");
  util::wait_network_frame();
  level.var_777ffc66 = "";
  level thread dragon_hazard(1);
}

function function_941c2339() {
  if(!level flag::get("") && !level flag::get("")) {
    zm_stalingrad_util::function_4da6e8(0);
    wait(0.05);
    level thread function_63326db4(1);
  }
}

function function_ef4a09c3() {
  if(level flag::get("") && !level flag::get("")) {
    zm_stalingrad_util::function_4da6e8(1);
    function_30560c4b();
    function_cf119cfd();
    function_11044369();
    util::wait_network_frame();
    level thread function_b4d22afe();
    level flag::clear("");
  }
}

function function_372d0868() {
  level.var_5a45def9 = 120;
}

function function_21b70393() {
  level.var_5a45def9 = 1;
}

function function_482eea0f(n_seat) {
  level.var_3f756142 = n_seat;
}

function function_c09859f(n_seat) {
  if(!level flag::get("")) {
    dragon_boss_init();
  }
  function_17b7a6a();
  function_8a29cbcb();
}

function function_e73b4306(a_ents) {
  level waittill("fadeout");
  level thread lui::screen_fade_out(1, "");
}

function function_a2ac4477(a_ents) {
  level thread lui::screen_fade_in(1, "");
}

function handle_notetracks() {
  self thread function_5173a048();
  self endon("death");
  while(isDefined(self)) {
    str_notify = self util::waittill_any_return("arrival", "big_wingflap", "sml_wingflap", "wingflap_arrival", "wingflap_exit", "flak", "death");
    switch (str_notify) {
      case "arrival": {
        self clientfield::increment("dragon_notetracks", 1);
        break;
      }
      case "big_wingflap": {
        self clientfield::increment("dragon_notetracks", 6);
        break;
      }
      case "sml_wingflap": {
        self clientfield::increment("dragon_notetracks", 7);
        break;
      }
      case "wingflap_arrival": {
        self clientfield::increment("dragon_notetracks", 8);
        break;
      }
      case "wingflap_exit": {
        self clientfield::increment("dragon_notetracks", 9);
        break;
      }
      case "flak": {
        self clientfield::increment("dragon_notetracks", 10);
        break;
      }
    }
  }
}

function function_5173a048() {
  self endon("death");
  while(isDefined(self)) {
    str_notify = self util::waittill_any_return("footstep_fr", "footstep_fl", "footstep_br", "footstep_bl", "death");
    switch (str_notify) {
      case "footstep_fl": {
        self clientfield::increment("dragon_notetracks", 2);
        break;
      }
      case "footstep_fr": {
        self clientfield::increment("dragon_notetracks", 3);
        break;
      }
      case "footstep_bl": {
        self clientfield::increment("dragon_notetracks", 4);
        break;
      }
      case "footstep_br": {
        self clientfield::increment("dragon_notetracks", 5);
        break;
      }
    }
  }
}