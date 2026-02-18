/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\zm_gold_ww_quest.gsc
***********************************************/

#using script_3411bb48d41bd3b;
#using script_5fd73298643b6fff;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm\zm_gold_main_quest;
#using scripts\zm\zm_gold_vo;
#using scripts\zm_common\zm_crafting;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_intel;
#using scripts\zm_common\zm_items;
#using scripts\zm_common\zm_sq;
#using scripts\zm_common\zm_ui_inventory;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;
#namespace zm_gold_ww_quest;

function init() {
  clientfield::register("world", "" + # "hash_e3e178ca4bfed0a", 16000, 1, "int");
  clientfield::register("world", "" + # "hash_4bbd14acfb65a055", 16000, 1, "counter");
  clientfield::register("world", "" + # "hash_6ad15545c118bf44", 16000, 6, "int");
  clientfield::register("world", "" + # "play_charge_fx", 16000, 1, "int");
  clientfield::register("scriptmover", "" + # "hash_438f8800ecce6fba", 16000, 1, "int");
  clientfield::register("scriptmover", "" + # "hash_631477f00832803c", 16000, 1, "int");
  level thread function_47f32607();
  level thread function_f861601e();
  level thread function_1b65b01d();
  spawner::add_ai_spawn_function(&function_2d43051c);
  callback::on_item_pickup(&function_eeecf07f);
  level thread function_2b26d68b();
  level thread function_7baaf94();
  level thread function_2d9c01e4();

  level thread function_37597f29();
}

function function_2d43051c() {
  if(self.archetype === # "raz") {
    self thread function_fc49d802();
  }
}

function function_fc49d802() {
  level endon(#"hash_607dade1cb80a138");
  self endon(#"death");
  self waittill(#"hash_60f75ee59e5d030f");

  if(zm_utility::check_point_in_playable_area(self.origin)) {
    level notify(#"hash_712ab943a79224a7", {
      #ai: self
    });
  }
}

function function_f861601e() {
  level.lockers = [];
  lockers_pos = struct::get_array("lockers_pos", "targetname");
  array::thread_all(lockers_pos, &function_a91dc42a);
}

function function_7baaf94() {
  level flag::wait_till(#"power_on3");
  var_fd72bb7d = getEntArray("crafting_trigger", "targetname");

  foreach(crafting_trigger in var_fd72bb7d) {
    if(isDefined(crafting_trigger) && crafting_trigger.script_noteworthy === "wonder_weapon_trigger") {
      crafting_trigger setinvisibletoall();
    }
  }
}

function function_1b65b01d() {
  level zm_sq::register(#"gold_ww_quest", #"hash_6758d64b690c570f", #"hash_3cfd69dc67bdcf69", &function_a4b8aff7, &function_ce530cda);
  level zm_sq::register(#"gold_ww_quest", #"hash_7b5bab654708470b", #"hash_3cfd66dc67bdca50", &function_87f86c84, &function_5c376939);
  level zm_sq::register(#"gold_ww_quest", #"hash_287ae417b1339180", #"hash_3cfd67dc67bdcc03", &function_c2088edf, &function_4b909440);
  level zm_sq::register(#"gold_ww_quest", #"find_barrel", #"hash_3cfd6cdc67bdd482", &function_4ef5947, &function_c36925e7);
  level zm_sq::register(#"gold_ww_quest", #"hash_c6f3225f56517f9", #"hash_3cfd6ddc67bdd635", &function_a634505e, &function_33d6e713);
  level zm_sq::register(#"gold_ww_quest", #"hash_3540a78605fcb68f", #"hash_3cfd6adc67bdd11c", &function_8f2904c6, &function_230b550c);
  level zm_sq::register(#"gold_ww_quest", #"hash_50c3abfaa73108ba", #"hash_3cfd6bdc67bdd2cf", &function_cd56635f, &function_63eefce1);
}

function function_47f32607() {
  level endon(#"end_game");
  level flag::wait_till("start_zombie_round_logic");
  var_583d6636 = struct::get("ww_schematic", "targetname");
  function_ade87eb5(#"item_zmintel_gold_requiem_artifact_1", var_583d6636, 0);
  level clientfield::set("" + # "hash_e3e178ca4bfed0a", 1);
  level zm_sq::start(#"gold_ww_quest", 1);
}

function function_a4b8aff7(b_skipped) {
  level endon(#"end_game", #"hash_6758d64b690c570f" + "_ended_early");

  wait 2;
  iprintlnbold("<dev string:x38>");

  if(b_skipped) {
    return;
  }

  level flag::wait_till(#"hash_722723ce1e3aa7d2");
  var_fd72bb7d = getEntArray("crafting_trigger", "targetname");

  foreach(crafting_trigger in var_fd72bb7d) {
    if(isDefined(crafting_trigger) && crafting_trigger.script_noteworthy === "wonder_weapon_trigger") {
      crafting_trigger setvisibletoall();
    }
  }

  iprintlnbold("<dev string:x4c>");
  wait 2;
}

function function_ce530cda(b_skipped, var_19e802fa) {
  if(b_skipped || var_19e802fa) {
    var_fd72bb7d = getEntArray("crafting_trigger", "targetname");

    foreach(crafting_trigger in var_fd72bb7d) {
      if(isDefined(crafting_trigger) && crafting_trigger.script_noteworthy === "wonder_weapon_trigger") {
        crafting_trigger setvisibletoall();
      }
    }
  }

  level flag::set(#"hash_722723ce1e3aa7d2");

  iprintlnbold("<dev string:x62>");
}

function function_2b26d68b() {
  level.var_1aca2bc0 = array::random([# "mission_control"]);
  level flag::wait_till(#"hash_722723ce1e3aa7d2");

  while(true) {
    n_players_in_zone = zm_zonemgr::get_players_in_zone(#"zone_burnt_forest_defend") + zm_zonemgr::get_players_in_zone(#"zone_napalm_strike") + zm_zonemgr::get_players_in_zone(#"zone_napalm_strike2");

    if(n_players_in_zone <= 0) {
      break;
    }

    waitframe(1);
  }

  level scene::init(#"hash_451a7f652aaab3c6");
  var_a1175523 = getEntArray("dimitri_ww_interact", "targetname");

  foreach(var_3f073f58 in var_a1175523) {
    if(isDefined(var_3f073f58) && var_3f073f58.script_noteworthy == level.var_1aca2bc0) {
      var_3f073f58 thread function_8de4f4ec();
    }

    var_3f073f58 setModel("tag_origin");
  }

  var_2805a4c0 = getEntArray("weapon_folder", "targetname");

  foreach(var_15a4e821 in var_2805a4c0) {
    if(isDefined(var_15a4e821) && var_15a4e821.script_noteworthy == level.var_1aca2bc0) {
      function_ade87eb5(#"item_zmintel_gold_requiem_artifact_2", var_15a4e821, 0);
    }

    var_15a4e821 delete();
  }
}

function function_8de4f4ec() {
  level endon(#"end_game");
  var_b446c1a5 = self zm_unitrigger::create(&function_5c2866af, 80);
  waitresult = self waittill(#"trigger_activated");
  zm_unitrigger::unregister_unitrigger(var_b446c1a5);
  level flag::set(#"hash_5dce120a8e013b48");
  waitresult.e_who val::set(#"hash_4a38b38071007d0a", "disable_weapons");
  wait 0.6;

  if(isDefined(waitresult.e_who)) {
    waitresult.e_who function_cf884a61();

    if(isDefined(waitresult.e_who)) {
      waitresult.e_who val::reset(#"hash_4a38b38071007d0a", "disable_weapons");
    }
  }

  level flag::clear(#"hash_5dce120a8e013b48");
  level zm_ui_inventory::function_7df6bb60(#"hash_4214918e34681e5a", 1);
  array::thread_all(function_a1ef346b(), &zm_intel::collect_intel, #"zmintel_gold_omega_artifact_1");
  level flag::set(#"hash_5c438c30435a20f3");
  s_spawn_pos = struct::get(self.target, "targetname");
  var_7f595528 = namespace_85745671::function_7a1b21f6(s_spawn_pos.origin, s_spawn_pos.angles, 15, 512, 512, 512);
  var_67fee1f1 = [];

  if(isarray(var_7f595528)) {
    foreach(spawn_point in var_7f595528) {
      if(ispointonnavmesh(spawn_point.origin, 0)) {
        if(!isDefined(var_67fee1f1)) {
          var_67fee1f1 = [];
        } else if(!isarray(var_67fee1f1)) {
          var_67fee1f1 = array(var_67fee1f1);
        }

        if(!isinarray(var_67fee1f1, spawn_point)) {
          var_67fee1f1[var_67fee1f1.size] = spawn_point;
        }
      }
    }
  }

  i = 0;

  while(i < 10) {
    s_spawn = array::random(var_67fee1f1);
    spawn_ai = spawnactor("spawner_bo5_zombie_zm_gold", s_spawn.origin, s_spawn.angles, undefined, 1);

    if(isDefined(spawn_ai)) {
      spawn_ai.var_c9b11cb3 = # "hash_5d96e8e3ed203968";
      spawn_ai thread namespace_85745671::function_2089690e();
      spawn_ai pathmode("move allowed");
      spawn_ai.ignore_enemy_count = 1;
      spawn_ai.exclude_cleanup_adding_to_total = 1;
      spawn_ai.completed_emerging_into_playable_area = 1;
      spawn_ai.zombie_think_done = 1;
      i++;
      wait 1;
    }

    waitframe(1);
  }
}

function function_5c2866af(e_player) {
  if(isPlayer(e_player)) {
    if(!level flag::get(#"hash_49e515cdcf4bb8db")) {
      self sethintstring(#"hash_f6abf835e03d2f8");
      return true;
    } else {
      return false;
    }
  }

  return false;
}

function function_87f86c84(b_skipped) {
  level endon(#"end_game", #"hash_7b5bab654708470b" + "_ended_early");

  if(b_skipped) {
    return;
  }

  level flag::wait_till(#"hash_5c438c30435a20f3");

  iprintlnbold("<dev string:x78>");
}

function function_5c376939(b_skipped, var_19e802fa) {
  if(b_skipped || var_19e802fa) {
    iprintlnbold("<dev string:x88>");
  }
}

function function_c2088edf(b_skipped) {
  level endon(#"end_game", #"hash_287ae417b1339180" + "_ended_early");

  if(b_skipped) {
    return;
  }

  var_611c4091 = getent("ww_quest_computer", "targetname");
  var_611c4091 zm_unitrigger::create(&function_e594b500, 64, &function_5d8ec91d);
  level waittill(#"hash_7788540323db060");
  dimitri_eyes_pos = struct::get("dimitri_eyes_pos", "targetname");
  var_95614195 = dimitri_eyes_pos util::spawn_model(#"hash_59fe28273eedc6e3", dimitri_eyes_pos.origin, dimitri_eyes_pos.angles);
  var_535d61f8 = getent("retinal_scan", "targetname");
  var_535d61f8 scene::play(#"hash_291b7cbc6012c485", "up", var_535d61f8);
  var_535d61f8 clientfield::set("" + # "hash_438f8800ecce6fba", 1);
  wait 4;
  var_535d61f8 scene::stop(#"hash_291b7cbc6012c485");
  var_535d61f8 thread scene::play(#"hash_291b7cbc6012c485", "down", var_535d61f8);
  var_611c4091 playSound(#"hash_30cc6f636c8bdec1");

  iprintlnbold("<dev string:x9e>");
}

function function_e594b500(e_player) {
  if(isPlayer(e_player)) {
    if(level flag::get("power_on3")) {
      self sethintstring(#"hash_6244ec26d09cb15d");
      return true;
    } else {
      self sethintstring(#"zombie/need_power");
      return true;
    }

    return false;
  }

  return false;
}

function function_5d8ec91d() {
  level endon(#"end_game");

  while(true) {
    waitresult = self waittill(#"trigger");
    player = waitresult.activator;

    if(!level flag::get("power_on3")) {
      continue;
    }

    player function_bc82f900(#"zm_gold_interact_rumble_small");
    level notify(#"hash_7788540323db060");
    zm_unitrigger::unregister_unitrigger(self.stub);
  }
}

function function_4b909440(b_skipped, var_19e802fa) {
  if(b_skipped || var_19e802fa) {
    iprintlnbold("<dev string:x9e>");
  }
}

function function_fd185787() {
  level.var_685ca72f = function_af26979d();
  var_79bb44c5 = getent("puzzle_board_center", "targetname");
  var_79bb44c5 childthread function_912a9d36(level.var_685ca72f);
  level.var_3fc8ed1e = getent("ww_quest_computer", "targetname");
  level childthread function_d196daba(level.var_3fc8ed1e, level.var_685ca72f);
  level flag::wait_till(#"hash_76c7837322a67981");
  var_3180c9b8 = util::spawn_model("tag_origin", var_79bb44c5.origin, var_79bb44c5.angles);
  var_3180c9b8 clientfield::set("" + # "hash_631477f00832803c", 1);
  var_79bb44c5 hide();
  wait 3;
  var_33229741 = struct::get(var_79bb44c5.target, "targetname");
  var_5d7d58f2 = function_ade87eb5(#"hash_11a77d8a90e047f1", var_79bb44c5, 0);
  var_3180c9b8 playSound(#"hash_783d3d061bcb79ae");
  n_power = length(var_79bb44c5.origin - var_33229741.origin);
  drop_time = var_5d7d58f2 zm_utility::fake_physicslaunch(var_33229741.origin, n_power);
  wait 1;
  var_79bb44c5 delete();
}

function function_4ef5947(b_skipped) {
  level endon(#"end_game", #"find_barrel" + "_ended_early");

  if(b_skipped) {
    return;
  }

  level childthread function_fd185787();
  var_10fcac9a = getent("computer_desk_drawer", "targetname");
  var_1616b76e = var_10fcac9a.origin;
  a_s_pos = struct::get_array(var_10fcac9a.target, "targetname");

  foreach(pos in a_s_pos) {
    if(pos.script_string === "desk_drawer_open_pos") {
      desk_drawer_open_pos = pos;
      continue;
    }

    var_7486f39c = pos;
  }

  var_10fcac9a playSound("zmb_quest_ww_drawer_open");
  locker_key_pos = struct::get("locker_key_pos", "targetname");
  var_4f28f4ee = function_ade87eb5(#"hash_7dcd682c7e6f92d0", locker_key_pos, 0);
  var_4f28f4ee linkto(var_10fcac9a);
  var_10fcac9a moveto(desk_drawer_open_pos.origin, 2);
  level waittill(#"hash_28bed8664988e37a");
  var_10fcac9a moveto(var_1616b76e, 2);
  var_10fcac9a playSound("zmb_quest_ww_drawer_close");
  var_7fca3c64 = 0;
  var_30ee3bb8 = 0;
  var_720e558b = 0;
  var_7a10624 = 0;

  for(i = 0; i < 6; i++) {
    locker = array::random(level.lockers);

    if(!var_7fca3c64) {
      locker.var_b6d3d947 = 1;
      var_7fca3c64 = 1;
      continue;
    }

    if(!var_30ee3bb8) {
      locker.var_58d0878f = 1;
      var_30ee3bb8 = 1;
      continue;
    }

    if(!var_720e558b) {
      locker.var_e87fbf2f = 1;
      var_720e558b = 1;
      continue;
    }

    if(!is_true(locker.var_b6d3d947)) {
      locker.var_aa3c8a94 = 1;

      if(!var_7a10624) {
        locker.var_943bebe3 = 1;
        var_7a10624 = 1;
      }
    }
  }

  level flag::set(#"hash_705c7ba8a56685ed");

  iprintlnbold("<dev string:xb6>");

  level flag::wait_till(#"found_barrel");

  iprintlnbold("<dev string:xcc>");
}

function function_c36925e7(b_skipped, var_19e802fa) {
  if(b_skipped || var_19e802fa) {
    level flag::set(#"hash_705c7ba8a56685ed");

    iprintlnbold("<dev string:xcc>");
  }
}

function function_a634505e(b_skipped) {
  level endon(#"end_game", #"hash_c6f3225f56517f9" + "_ended_early");

  if(b_skipped) {
    return;
  }

  level flag::wait_till(#"hash_5b2f8d1b5f283517");

  iprintlnbold("<dev string:xe3>");
}

function function_33d6e713(b_skipped, var_19e802fa) {
  if(b_skipped || var_19e802fa) {
    iprintlnbold("<dev string:xe3>");

    level clientfield::set("" + # "hash_6ad15545c118bf44", 0);
  }

  level flag::clear(#"hash_23851dbffef298e1");
  level flag::clear(#"hit_bullseye");
  level flag::clear(#"hit_board");

  if(isDefined(level.var_b0b63450)) {
    level.var_b0b63450 delete();
  }

  if(isDefined(level.var_1221f4ab)) {
    level.var_1221f4ab delete();
  }

  if(isDefined(level.var_82f3ced5)) {
    level.var_82f3ced5 delete();
  }

  level clientfield::set("" + # "hash_e3e178ca4bfed0a", 0);
}

function function_af26979d() {
  var_77d81993 = [];
  var_cc14c4b2 = 1;

  for(i = 0; i < 3; i++) {
    do {
      var_76f1881e = randomint(20) + 1;
    }
    while(var_76f1881e == var_cc14c4b2);

    var_77d81993[var_77d81993.size] = var_76f1881e;
    var_cc14c4b2 = var_76f1881e;
  }

  return var_77d81993;
}

function function_d7d376af(var_77d81993) {
  var_cc14c4b2 = 1;
  b_clockwise = 1;

  for(i = 0; i < var_77d81993.size; i++) {
    var_76f1881e = var_77d81993[i] & 31;
    var_76f1881e += b_clockwise ? 0 : 32;
    level clientfield::set("" + # "hash_6ad15545c118bf44", var_76f1881e);
    n_delta = (var_77d81993[i] - var_cc14c4b2) * (b_clockwise ? 1 : -1);

    if(n_delta < 0) {
      n_delta += 20;
    }

    var_cc14c4b2 = var_77d81993[i];
    b_clockwise = !b_clockwise;
    wait n_delta * 0.5 + 2;
  }

  level clientfield::set("" + # "hash_6ad15545c118bf44", 0);
}

function function_a8890244(var_c8e10123) {
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"damage");

    if(isPlayer(waitresult.attacker) && (waitresult.mod === "MOD_PISTOL_BULLET" || waitresult.mod === "MOD_RIFLE_BULLET")) {
      iprintlnbold(function_9e72a96(var_c8e10123));

      level flag::set(var_c8e10123);
    }
  }
}

function function_b3e7ac72(mdl_clip, v_origin, v_angles, var_c8e10123) {
  e_clip = util::spawn_model(mdl_clip, v_origin, v_angles);
  e_clip setCanDamage(1);
  e_clip ghost();
  e_clip val::set("hit_clip", "allowdeath", 0);
  e_clip thread function_a8890244(var_c8e10123);

  if(is_true(level.var_55513c53)) {
    e_clip show();
  }

  return e_clip;
}

function private function_a6d637ea(var_77d81993, n_index) {
  var_76f1881e = var_77d81993[n_index];
  n_angle = (var_76f1881e - 1) * 18;
  self.angles = (n_angle, self.angles[1], self.angles[2]);
}

function function_912a9d36(var_77d81993) {
  self notify("176317fcb3d53d71");
  self endon("176317fcb3d53d71");
  level.var_b0b63450 = function_b3e7ac72(#"p9_zm_gold_dart_board_clip_00", self.origin, self.angles, #"hit_bullseye");
  level.var_1221f4ab = function_b3e7ac72(#"p9_zm_gold_dart_board_clip_01", self.origin - (0, 0.5, 0), self.angles, #"hash_23851dbffef298e1");
  level.var_82f3ced5 = function_b3e7ac72(#"p9_zm_gold_dart_board_clip_02", self.origin + (0, 0.5, 0), self.angles, #"hit_board");
  n_index = 0;
  level.var_1221f4ab function_a6d637ea(var_77d81993, n_index);

  while(true) {
    if(level flag::get(#"hash_23851dbffef298e1")) {
      n_index++;

      if(n_index < var_77d81993.size) {
        level.var_1221f4ab function_a6d637ea(var_77d81993, n_index);
      } else {
        level.var_1221f4ab notsolid();
      }
    } else if(level flag::get(#"hit_bullseye")) {
      if(n_index >= var_77d81993.size) {
        level flag::set(#"hash_76c7837322a67981");

        iprintlnbold("<dev string:xfa>");

        break;
      } else {
        n_index = 0;
        level.var_1221f4ab function_a6d637ea(var_77d81993, n_index);
        level.var_1221f4ab solid();
      }
    } else if(level flag::get(#"hit_board")) {
      n_index = 0;
      level.var_1221f4ab function_a6d637ea(var_77d81993, n_index);
      level.var_1221f4ab solid();
    }

    level flag::clear(#"hash_23851dbffef298e1");
    level flag::clear(#"hit_bullseye");
    level flag::clear(#"hit_board");
    waitframe(1);
  }

  if(isDefined(level.var_b0b63450)) {
    level.var_b0b63450 delete();
  }

  if(isDefined(level.var_1221f4ab)) {
    level.var_1221f4ab delete();
  }

  if(isDefined(level.var_82f3ced5)) {
    level.var_82f3ced5 delete();
  }
}

function private function_85d6a457(str_notify) {
  level clientfield::set("" + # "hash_6ad15545c118bf44", 0);

  if(isDefined(level.var_3fc8ed1e)) {
    zm_unitrigger::unregister_unitrigger(level.var_3fc8ed1e.s_unitrigger);
  }
}

function function_d196daba(e_computer, var_77d81993) {
  level endoncallback(&function_85d6a457, #"hash_76c7837322a67981");
  level clientfield::increment("" + # "hash_4bbd14acfb65a055");
  var_35fc9135 = struct::get("go_co_sc_lo", "targetname");
  playsoundatposition(#"hash_5cffc6d32c1f7512", var_35fc9135.origin);

  while(true) {
    activator = e_computer zm_unitrigger::function_fac87205(#"hash_6766f9d6a024ee72", 64);
    activator function_bc82f900(#"zm_gold_interact_rumble_small");
    playsoundatposition(#"hash_3874b1f24664c38a", var_35fc9135.origin);
    level function_d7d376af(var_77d81993);
  }
}

function function_2d9c01e4() {
  level endon(#"end_game");
  level flag::wait_till(#"hash_722723ce1e3aa7d2");
  level thread function_6128f9d0();
  level flag::wait_till(#"hash_4942017a2b95789a");
  power_cell_pos = struct::get("power_cell_pos", "targetname");
  activator = power_cell_pos zm_unitrigger::function_fac87205(#"hash_48839f315e10aa6a", 64);
  activator function_bc82f900(#"zm_gold_interact_rumble_small");
  var_3875fad7 = level.round_number + 2;
  power_cell = util::spawn_model(#"p9_zm_gold_ray_rifle_component_charged_power", power_cell_pos.origin, power_cell_pos.angles);
  playsoundatposition(#"hash_70b82b4de231f767", power_cell_pos.origin);
  level clientfield::set("" + # "play_charge_fx", 1);
  var_c6adbe4d = power_cell_pos zm_unitrigger::create(#"hash_107c45e6dc18900f", 64, &function_e08e775b);

  while(var_3875fad7 > level.round_number) {
    wait 1;
  }

  if(isDefined(var_c6adbe4d)) {
    zm_unitrigger::unregister_unitrigger(var_c6adbe4d);
  }

  level clientfield::set("" + # "play_charge_fx", 0);

  iprintlnbold("<dev string:x10e>");

  waitframe(5);
  power_cell delete();
  function_ade87eb5(#"hash_1caaa6e2c3bfe02", power_cell_pos, 0);
}

function function_e08e775b() {
  level endon(#"end_game");
  self endon(#"death");

  while(true) {
    self waittill(#"trigger");
    level thread zm_gold_main_quest::function_b9a3fa11(#"hash_1e547dbf77f66df3", #"hash_1e548dbf77f68923", #"hash_1e5491bf77f68fef");
    zm_unitrigger::unregister_unitrigger(self.stub);
  }
}

function function_8f2904c6(b_skipped) {
  level endon(#"end_game", #"hash_3540a78605fcb68f" + "_ended_early");

  if(b_skipped) {
    return;
  }

  level flag::wait_till(#"hash_370e627ee07d49f4");

  foreach(player in getplayers()) {
    if(isDefined(player)) {
      zm_items::player_pick_up(player, zm_crafting::get_component("zitem_gold_charged_power_cell"));
    }
  }
}

function function_230b550c(b_skipped, var_19e802fa) {
  if(b_skipped || var_19e802fa) {
    iprintlnbold("<dev string:x119>");

    foreach(player in function_a1ef346b()) {
      zm_items::player_pick_up(player, zm_crafting::get_component("zitem_gold_charged_power_cell"));
    }
  }
}

function function_6128f9d0() {
  level endon(#"end_game");
  waitresult = level waittill(#"hash_712ab943a79224a7");
  ai = waitresult.ai;

  if(isDefined(ai)) {
    function_ade87eb5(#"hash_322a19bc285c73d9", ai, 2);
    level waittill(#"hash_2d5cdf8748bf209d");

    iprintlnbold("<dev string:x12f>");

    level flag::set(#"hash_4942017a2b95789a");
  }
}

function function_cd56635f(b_skipped) {
  level endon(#"end_game", #"hash_50c3abfaa73108ba" + "_ended_early");

  if(b_skipped) {
    return;
  }

  zm_crafting::function_d1f16587("zblueprint_gold_wonderweapon", &function_37ad9539);
  level flag::wait_till(#"hash_6eeca22c4519b770");
  craft_item_pos = struct::get("craft_item_pos", "targetname");
  function_ade87eb5(#"item_zmintel_gold_requiem_artifact_4", craft_item_pos, 0);
  level waittill(#"ww_pickup");

  iprintlnbold("<dev string:x147>");
}

function function_63eefce1(b_skipped, var_19e802fa) {
  if(b_skipped || var_19e802fa) {
    ww_weapon = getweapon(#"ww_ray_rifle_t9");

    foreach(player in getplayers()) {
      player zm_weapons::weapon_give(ww_weapon);
    }

    iprintlnbold("<dev string:x147>");
  }
}

function function_37ad9539(var_1377a1e8) {
  level flag::set(#"hash_6eeca22c4519b770");

  iprintlnbold("<dev string:x15f>");
}

function function_a91dc42a() {
  level endon(#"end_game");
  model = util::spawn_model(#"p7_lockers_metal_tall_01", self.origin, self.angles);

  if(!isDefined(level.lockers)) {
    level.lockers = [];
  } else if(!isarray(level.lockers)) {
    level.lockers = array(level.lockers);
  }

  if(!isinarray(level.lockers, model)) {
    level.lockers[level.lockers.size] = model;
  }

  var_3d9eca2c = anglesToForward(self.angles);
  level flag::wait_till(#"hash_705c7ba8a56685ed");
  var_e03eac13 = model zm_unitrigger::create(#"hash_2319b3ca445b4cf1", 32, &function_6de8eec4);
  var_e03eac13.origin = var_e03eac13.origin + (0, 0, 40) + var_3d9eca2c * 20;
  var_e03eac13.var_dad14d36 = model;
  var_e03eac13.var_40376d20 = struct::get(self.target, "targetname");
}

function function_6de8eec4() {
  level endon(#"end_game");

  while(true) {
    waitresult = self waittill(#"trigger");
    player = waitresult.activator;
    player function_bc82f900(#"zm_gold_interact_rumble_small");

    if(is_true(self.stub.var_dad14d36.var_aa3c8a94)) {
      var_ac9c030e = array::random(["zone_tents2", "zone_tents"]);
      spawn_mimic = zm_utility::function_cce73165("mimic_location", #"spawner_bo5_mimic", var_ac9c030e);

      if(isDefined(spawn_mimic)) {
        spawn_mimic.var_7a5e475 = 0;

        if(is_true(self.stub.var_dad14d36.var_943bebe3)) {
          spawn_mimic callback::function_d8abfc3d(#"hash_3beb0aebbde81394", &function_4741f2d1);
          spawn_mimic callback::on_death(&function_4741f2d1);
        }
      }
    }

    if(is_true(self.stub.var_dad14d36.var_e87fbf2f)) {
      if(isDefined(self.stub.var_40376d20)) {
        var_ab71b599 = zm_intel::function_2ba45c94("zmintel_gold_maxis_audiolog_3", self.stub.var_40376d20.origin);
        var_ab71b599.angles = (0, 0, 53);
      }
    }

    if(is_true(self.stub.var_dad14d36.var_58d0878f)) {
      playsoundatposition(#"hash_1faff36484237fbb", self.origin);

      iprintlnbold("<dev string:x171>");

      array::thread_all(function_a1ef346b(), &zm_intel::collect_intel, #"zmintel_gold_requiem_artifact_3");
    }

    self.stub.var_dad14d36 thread scene::play("p7_lockers_metal_tail_01_bundle", self.stub.var_dad14d36);
    zm_unitrigger::unregister_unitrigger(self.stub);
  }
}

function function_4741f2d1(params) {
  if(!isDefined(level.var_30690c68) && !isDefined(self.var_fa074143)) {
    self.var_fa074143 = 1;
    level thread function_a458979c(self);
  }
}

function function_a458979c(entity) {
  level endon(#"end_game");

  if(zm_utility::check_point_in_playable_area(entity.origin)) {
    function_ade87eb5(#"hash_63707e896cd62344", entity, 2);
    level waittill(#"barrel_pickup");

    iprintlnbold("<dev string:x181>");

    level flag::set(#"found_barrel");
    return;
  }

  wait 3;
  var_ac9c030e = array::random(["zone_tents2", "zone_tents"]);
  spawn_mimic = zm_utility::function_cce73165("mimic_location", #"spawner_bo5_mimic", var_ac9c030e);

  if(isDefined(spawn_mimic)) {
    spawn_mimic.var_7a5e475 = 0;

    if(is_true(self.stub.var_dad14d36.var_943bebe3)) {
      spawn_mimic callback::function_d8abfc3d(#"hash_3beb0aebbde81394", &function_4741f2d1);
      spawn_mimic callback::on_death(&function_4741f2d1);
    }
  }
}

function function_eeecf07f(params) {
  item = params.item;

  if(isPlayer(self)) {
    if(isDefined(item.itementry.name)) {
      switch (item.itementry.name) {
        case # "item_zmintel_gold_requiem_artifact_1":
          level zm_ui_inventory::function_7df6bb60(#"hash_5d24d46e696a9fd1", 1);
          array::thread_all(function_a1ef346b(), &zm_intel::collect_intel, #"zmintel_gold_requiem_artifact_1");
          level flag::set(#"hash_722723ce1e3aa7d2");
          zm_gold_vo::function_65937665();
          break;
        case # "hash_7dcd682c7e6f92d0":
          level zm_ui_inventory::function_7df6bb60(#"hash_36dcff5d560ebdf2", 1);
          level notify(#"hash_28bed8664988e37a");
          level thread zm_gold_vo::function_84947a87();
          break;
        case # "item_zmintel_gold_requiem_artifact_2":
          array::thread_all(function_a1ef346b(), &zm_intel::collect_intel, #"zmintel_gold_requiem_artifact_2");
          break;
        case # "hash_63707e896cd62344":
          level zm_ui_inventory::function_7df6bb60(#"hash_36dcff5d560ebdf2", 2);
          level notify(#"barrel_pickup");
          level zm_gold_main_quest::function_b9a3fa11(#"hash_343bcffdd018ad79", #"hash_343bdffdd018c8a9", #"hash_343be3fdd018cf75");
          break;
        case # "item_zmintel_gold_requiem_artifact_4":
          array::thread_all(function_a1ef346b(), &zm_intel::collect_intel, #"zmintel_gold_requiem_artifact_4");
          level notify(#"ww_pickup");
          ww_weapon = getweapon(#"ww_ray_rifle_t9");
          self zm_weapons::weapon_give(ww_weapon, 1);
          self zm_vo::function_d342796e(#"hash_62aba8e16a728e4");
          wait 1;
          level zm_gold_main_quest::function_b9a3fa11(#"hash_32525c195b5b2706", #"hash_32526c195b5b4236", #"hash_325270195b5b4902");
          break;
        case # "hash_11a77d8a90e047f1":
          level zm_ui_inventory::function_7df6bb60(#"hash_4214918e34681e5a", 2);
          level flag::set(#"hash_5b2f8d1b5f283517");
          level zm_gold_main_quest::function_b9a3fa11(#"hash_30dd69dc943a1b0f", #"hash_30dd59dc9439ffdf", #"hash_30dd55dc9439f913");
          break;
        case # "hash_1caaa6e2c3bfe02":
          level zm_ui_inventory::function_7df6bb60(#"hash_64ec4aaf73911014", 2);
          level flag::set(#"hash_370e627ee07d49f4");
          level zm_gold_main_quest::function_b9a3fa11(#"hash_6c5be047d95ba22f", #"hash_6c5bd047d95b86ff", #"hash_6c5bcc47d95b8033");
          break;
        case # "hash_322a19bc285c73d9":
          level zm_ui_inventory::function_7df6bb60(#"hash_64ec4aaf73911014", 1);
          level notify(#"hash_2d5cdf8748bf209d");
          level zm_gold_main_quest::function_b9a3fa11(#"hash_4900551fa5339d35", #"hash_4900451fa5338205", #"hash_4900411fa5337b39");
          break;
      }
    }
  }
}

function private function_cf884a61() {
  switch (level.var_85422c0e) {
    case # "strauss":
      var_d0767760 = # "hash_3ed655c697ae2603";
      break;
    case # "carver":
      var_d0767760 = # "hash_3ed645c697ae0ad3";
      break;
    case # "grey":
      var_d0767760 = # "hash_3ed649c697ae119f";
      break;
    default:
      break;
  }

  level thread zm_vo::function_7622cb70(var_d0767760, 0.5, 0);
  level scene::play(#"hash_451a7f652aaab3c6", self);
}

function function_ade87eb5(item_name, entity, type) {
  point = function_4ba8fde(item_name);
  item = item_drop::drop_item(0, undefined, 1, 0, point.id, entity.origin, entity.angles, type);
  item.var_dd21aec2 = 1 | 16;
  return item;
}

function function_37597f29() {
  util::add_debug_command("<dev string:x198>");
  util::add_debug_command("<dev string:x1f6>");
  util::add_debug_command("<dev string:x265>");
  zm_devgui::add_custom_devgui_callback(&cmd);
}

function cmd(cmd) {
  switch (cmd) {
    case # "hash_ddb7689e8dd7f4a":
      function_f6d9adbf();
      break;
    case # "hash_1ca6d4b25ce0e1a1":
      function_4291c822();
      break;
    case # "hash_48623dc89693d85a":
      function_c6769eb8();
      break;
    default:
      break;
  }
}

function function_f6d9adbf() {
  level thread spawn_mangler();
}

function function_4291c822() {
  var_685ca72f = function_af26979d();
  level thread function_d7d376af(var_685ca72f);
}

function function_c6769eb8() {
  var_79bb44c5 = getent("<dev string:x2cd>", "<dev string:x2e4>");
  var_685ca72f = function_af26979d();

  if(isDefined(level.var_b0b63450)) {
    level.var_b0b63450 delete();
  }

  if(isDefined(level.var_1221f4ab)) {
    level.var_1221f4ab delete();
  }

  if(isDefined(level.var_82f3ced5)) {
    level.var_82f3ced5 delete();
  }

  level.var_55513c53 = 1;
  var_79bb44c5 thread function_912a9d36(var_685ca72f);
  level.var_1221f4ab.origin = (var_79bb44c5.origin[0] + 10, level.var_1221f4ab.origin[1], level.var_1221f4ab.origin[2]);

  foreach(var_76f1881e in var_685ca72f) {
    iprintlnbold(var_76f1881e);
  }
}

function spawn_mangler() {
  var_b6246671 = struct::get("<dev string:x2f2>", "<dev string:x2e4>");
  spawn_mangler = spawnactor(#"hash_4f87aa2a203d37d0", var_b6246671.origin, var_b6246671.angles, "<dev string:x30c>", 1);

  if(isDefined(spawn_mangler)) {
    spawn_mangler callback::function_d8abfc3d(#"on_ai_damage", &function_fdccaaa8);
  }
}

function function_fdccaaa8(s_params) {
  str_hit_loc = s_params.shitloc;

  if(self.archetype === # "raz" && str_hit_loc === "<dev string:x31b>") {
    level thread function_f4a3a8b0(self);
  }
}

function function_f4a3a8b0(entity) {
  level endon(#"end_game");

  if(math::cointoss(50)) {
    callback::remove_on_ai_damage(&function_fdccaaa8);
    var_728dec0e = util::spawn_model(#"p9_zm_gold_ray_rifle_component_depleted_power", entity.origin + (0, 0, 20), entity.angles);
    var_728dec0e zm_unitrigger::function_fac87205(#"hash_1d065ea51d79a22e", 64);

    iprintlnbold("<dev string:x32e>");

    var_728dec0e delete();
    level flag::set(#"hash_4942017a2b95789a");
  }
}