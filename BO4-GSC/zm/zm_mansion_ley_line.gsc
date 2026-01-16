/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_mansion_ley_line.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\trigger_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm\ai\zm_ai_bat;
#include scripts\zm\zm_mansion_pap_quest;
#include scripts\zm\zm_mansion_special_rounds;
#include scripts\zm\zm_mansion_util;
#include scripts\zm_common\util\ai_dog_util;
#include scripts\zm_common\util\ai_werewolf_util;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_characters;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_sq;
#include scripts\zm_common\zm_ui_inventory;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_vo;
#include scripts\zm_common\zm_zonemgr;

#namespace namespace_a8113e97;

init() {
  clientfield::register("allplayers", "" + #"hash_5370f4bc9fc25d13", 8000, 1, "int");
  clientfield::register("scriptmover", "" + #"ley_lines", 8000, 2, "int");
  clientfield::register("scriptmover", "" + #"power_beam", 8000, 2, "int");
  clientfield::register("scriptmover", "" + #"red_ray", 8000, 2, "int");
  clientfield::register("scriptmover", "" + #"green_ray", 8000, 2, "int");
  clientfield::register("scriptmover", "" + #"blue_ray", 8000, 2, "int");
  clientfield::register("scriptmover", "" + #"stone_glow", 8000, 1, "int");
  clientfield::register("scriptmover", "" + #"stone_despawn", 8000, 1, "counter");
  clientfield::register("scriptmover", "" + #"stone_soul", 8000, 1, "int");
  clientfield::register("scriptmover", "" + #"hash_34c5ab29531f15f0", 8000, 1, "int");
  clientfield::register("scriptmover", "" + #"hash_546e7612359187c3", 8000, 1, "counter");
  clientfield::register("toplayer", "" + #"mansion_mq_rumble", 8000, 1, "counter");
  clientfield::register("world", "" + #"skybox_stream", 8000, 1, "int");
  register_steps();
  init_flags();
  scene::add_scene_func(#"p8_fxanim_zm_man_atlas_bundle", &function_ea49787e, "init");
  scene::add_scene_func(#"p8_fxanim_zm_man_telescope_bundle", &function_604f9d73, "init");
  level thread scene::init(#"p8_fxanim_zm_man_telescope_bundle");
  level thread scene::init(#"p8_fxanim_zm_man_dome_crank_bundle");
  level.var_1613cea0 = 0;
  level.mdl_ring_outer = getent("ring_outer", "targetname");
  level.mdl_ring_middle = getent("ring_middle", "targetname");
  level.mdl_ring_inner = getent("ring_inner", "targetname");
  level.mdl_ring_outer.e_linkto = getent("ring_outer_linkto", "targetname");
  level.mdl_ring_outer linkto(level.mdl_ring_outer.e_linkto);
  level.mdl_ring_middle.e_linkto = getent("ring_middle_linkto", "targetname");
  level.mdl_ring_middle linkto(level.mdl_ring_middle.e_linkto);
  level.mdl_ring_inner.e_linkto = getent("ring_inner_linkto", "targetname");
  level.mdl_ring_inner linkto(level.mdl_ring_inner.e_linkto);
  level.mdl_ring_outer.var_846c254a = getent(level.mdl_ring_outer.target, "targetname");
  level.mdl_ring_middle.var_846c254a = getent(level.mdl_ring_middle.target, "targetname");
  level.mdl_ring_inner.var_846c254a = getent(level.mdl_ring_inner.target, "targetname");
  level.mdl_ring_outer.var_846c254a linkto(level.mdl_ring_outer);
  level.mdl_ring_middle.var_846c254a linkto(level.mdl_ring_middle);
  level.mdl_ring_inner.var_846c254a linkto(level.mdl_ring_inner);
  level.mdl_ring_outer.v_start = level.mdl_ring_outer.var_846c254a.origin;
  level.mdl_ring_middle.v_start = level.mdl_ring_middle.var_846c254a.origin;
  level.mdl_ring_inner.v_start = level.mdl_ring_inner.var_846c254a.origin;
  mdl_stone = getent("stone_obs", "targetname");
  mdl_stone ghost();
  level thread function_5f259315();
  level thread function_30fcf7ae();

  if(zm_utility::is_ee_enabled()) {
    level thread function_9513d3a6();
    level thread function_3f64b455();
    level thread function_b87ae607();
  }
}

function_30fcf7ae() {
  level.mdl_crystal_outer = getent("crystal_outer", "targetname");
  level.mdl_crystal_outer linkto(level.mdl_ring_outer);
  level.mdl_crystal_outer.v_start = level.mdl_crystal_outer.origin;
  level.mdl_crystal_middle = getent("crystal_middle", "targetname");
  level.mdl_crystal_middle linkto(level.mdl_ring_middle);
  level.mdl_crystal_middle.v_start = level.mdl_crystal_middle.origin;
  level.mdl_crystal_inner = getent("crystal_inner", "targetname");
  level.mdl_crystal_inner linkto(level.mdl_ring_inner);
  level.mdl_crystal_inner.v_start = level.mdl_crystal_inner.origin;
  level.e_blue = getent("blue_light", "targetname");
  level.e_green = getent("green_light", "targetname");
  level.e_red = getent("red_light", "targetname");
  array::run_all(getEntArray("r_con", "script_noteworthy"), &hide);
  level thread rings_start();
  level flag::wait_till("ley_start");
  array::run_all(getEntArray("r_con", "script_noteworthy"), &show);
  a_players = util::get_active_players();
  e_player_random = array::random(a_players);

  if(isalive(e_player_random)) {
    e_player_random thread zm_vo::function_a2bd5a0c(#"hash_22f0e4f17e4e1994", 0, 1);
  }

  level.e_blue clientfield::set("" + #"blue_ray", 1);
  level.e_green clientfield::set("" + #"green_ray", 1);
  level.e_red clientfield::set("" + #"red_ray", 1);
}

function_5f259315() {
  level flag::wait_till(#"open_pap");

  if(zm_utility::is_ee_enabled()) {
    if(zm_custom::function_901b751c(#"hash_3c5363541b97ca3e") && zm_custom::function_901b751c(#"zmpapenabled") != 2) {
      zm_sq::start(#"zm_mansion_ley_line");
    }
  }
}

register_steps() {
  zm_sq::register(#"zm_mansion_ley_line", #"step_1", #"ley_line_step_1", &init_step_1, &cleanup_step_1);
  zm_sq::register(#"zm_mansion_ley_line", #"step_2", #"ley_line_step_2", &init_step_2, &cleanup_step_2);
  zm_sq::register(#"zm_mansion_ley_line", #"step_3", #"ley_line_step_3", &init_step_3, &cleanup_step_3);
  zm_sq::register(#"zm_mansion_ley_line", #"step_4", #"ley_line_step_4", &init_step_4, &cleanup_step_4);
}

init_flags() {
  level flag::init(#"hash_546b8f78e6510d81");
  level flag::init(#"hash_546b8c78e6510868");
  level flag::init(#"hash_546b8d78e6510a1b");
  level flag::init(#"hash_546b9278e651129a");
  level flag::init(#"ley_start");
  level flag::init(#"rings_done");
  level flag::init(#"ring_rotate");
  level flag::init(#"wheel_locked");
  level flag::init(#"combo_dialed");
  level flag::init(#"combo_done");
  level flag::init(#"house_defend");
  level flag::init(#"hash_b240a9137ecc6f9");
  level flag::init(#"greenhouse_open");
  level flag::init(#"hash_702dbaf6695a5607");
}

init_step_1(var_a276c861) {
  mdl_stone = getent("gazing_stone_library", "targetname");
  var_47323b73 = mdl_stone zm_unitrigger::create(undefined, 64, &function_55b79f54);
  var_47323b73.str_loc = "library";
  var_47323b73.var_f0e6c7a2 = mdl_stone;

  if(!var_47323b73.var_f0e6c7a2 flag::exists(#"flag_gazing_stone_in_use")) {
    var_47323b73.var_f0e6c7a2 flag::init(#"flag_gazing_stone_in_use");
  }

  level thread crescent_activate();
  level thread function_d3128b5f();

  if(!var_a276c861) {
    level flag::wait_till(#"ley_start");
  }
}

cleanup_step_1(var_5ea5c94d, ended_early) {
  level flag::set(#"gazed_library");
  level flag::set(#"ley_start");

  foreach(str_flag in array(#"hash_546b8f78e6510d81", #"hash_546b8c78e6510868", #"hash_546b8d78e6510a1b", #"hash_546b9278e651129a")) {
    level flag::set(str_flag);
  }

  var_2782a2fe = getent("beam_man", "targetname");
  var_2782a2fe clientfield::set("" + #"ley_lines", 1);
}

init_step_2(var_a276c861) {
  level zm_ui_inventory::function_7df6bb60(#"hash_7b006e4a8b2139a2", 1);

  if(!var_a276c861) {
    level flag::wait_till(#"rings_done");
  }
}

cleanup_step_2(var_5ea5c94d, ended_early) {
  level flag::set(#"rings_done");
}

init_step_3(var_a276c861) {
  level zm_ui_inventory::function_7df6bb60(#"hash_7b006f4a8b213b55", 1);
  exploder::exploder("fxexp_telescope_charge");
  playsoundatposition(#"hash_75404411ef08e098", (4029, -146, -138));
  level thread door_opener();
  level thread function_5164d716();
  level thread combo_watcher();
  level thread function_d8162064();

  if(!var_a276c861) {
    getent("trigger_combo_button", "targetname") thread function_bfefc7aa();
    level flag::wait_till(#"wheel_locked");
    power_beam();
  }

  level thread tube_shoot();
}

cleanup_step_3(var_5ea5c94d, ended_early) {
  level notify(#"hash_11429494f29d116d");
  level flag::set(#"ley_start");
  level flag::set(#"rings_done");

  if(!level flag::get(#"wheel_locked")) {
    mdl_wheel = function_b1b02a54();
    mdl_wheel thread scene::play(#"p8_fxanim_zm_man_dome_crank_wheel_bundle", mdl_wheel);
    mdl_door_right = getent("<dev string:x38>", "<dev string:x5f>");
    mdl_door_left = getent("<dev string:x6c>", "<dev string:x5f>");
    var_5a2e8e4f = anglestoright(mdl_door_right.angles);
    var_58aebac7 = anglestoright(mdl_door_left.angles);
    var_a40d6e4f = mdl_door_right.origin + var_5a2e8e4f * 64;
    var_5f19fbd3 = mdl_door_left.origin - var_58aebac7 * 64;
    mdl_door_right moveto(var_a40d6e4f, 0.1);
    mdl_door_left moveto(var_5f19fbd3, 0.1);
    mdl_door_left waittill(#"movedone");
  }

    level flag::set(#"wheel_locked");
  level flag::set(#"combo_dialed");
  level flag::set(#"combo_done");
  var_7f147f52 = getent("t_eshield_check", "targetname");
  var_7f147f52 delete();
}

init_step_4(var_a276c861) {
  level zm_ui_inventory::function_7df6bb60(#"hash_7b00684a8b212f70", 1);
  level thread function_c888f1f4();
  level thread function_1be5e603();

  if(!var_a276c861) {
    level flag::wait_till(#"house_defend");
    level flag::clear(#"spawn_zombies");
    level flag::clear(#"zombie_drop_powerups");
    mansion_util::function_45ac4bb8();
    level thread function_f3668a9();
    level thread mansion_util::function_bb613572(function_a7bed514(), #"hash_b240a9137ecc6f9");
    wave_1();
    wave_3();
    a_players = util::get_active_players();
    e_player_random = array::random(a_players);

    if(isalive(e_player_random)) {
      e_player_random thread zm_vo::function_a2bd5a0c(#"hash_5927981205a122fc", 0, 1);
    }

    level flag::wait_till(#"greenhouse_open");
  }
}

cleanup_step_4(var_5ea5c94d, ended_early) {
  level flag::set(#"greenhouse_open");
  level flag::set(#"hash_b240a9137ecc6f9");
  level notify(#"hash_3c7945247db32d89");
  mdl_stone = getent("stone_obs", "targetname");

  if(isDefined(mdl_stone)) {
    mdl_stone delete();
  }

  s_relic = struct::get("relic_greenhouse");
  mdl_relic = util::spawn_model(#"p8_zm_man_druid_door_stone_circle", s_relic.origin, s_relic.angles);
  util::wait_network_frame();
  mdl_relic.targetname = s_relic.targetname;
  mdl_relic clientfield::set("" + #"stone_glow", 1);
}

function_55b79f54() {
  while(true) {
    waitresult = self waittill(#"trigger");
    player = waitresult.activator;

    if(!zm_utility::can_use(player) || isDefined(player.b_gazing) && player.b_gazing || isDefined(player.var_d049df11) && player.var_d049df11 || distancesquared(groundtrace(player.origin, player.origin + (0, 0, -128), 0, player)[#"position"], player.origin) > 16) {
      continue;
    }

    level thread mansion_pap::function_9e7129d2(player, self.stub.var_f0e6c7a2, 16, "ley");
    player thread mansion_util::function_58dfa337(15);
    player thread mansion_util::function_a113df82(18);
    level flag::set(#"gazed_library");
  }
}

function_a8de7aeb(player) {}

crescent_activate() {
  level flag::wait_till(#"gazed_library");
  level zm_ui_inventory::function_7df6bb60(#"hash_7b006d4a8b2137ef", 1);
  scene::add_scene_func(#"p8_fxanim_zm_man_beam_device_bundle", &function_d961aafc, "shot 1");
  level scene::play(#"p8_fxanim_zm_man_beam_device_bundle", "shot 1");
  scene::remove_scene_func(#"p8_fxanim_zm_man_beam_device_bundle", &function_d961aafc, "shot 1");
}

function_d961aafc(a_ents) {
  mdl_coil = a_ents[getfirstarraykey(a_ents)];
  mdl_coil thread function_70d8a7cb();
  level thread function_71d1b235();
  level thread function_fde77b55();
}

function_70d8a7cb() {
  level endon(#"ley_start");
  self val::set("ley_source", "takedamage", 1);
  self.health = 99999;

  while(true) {
    s_result = self waittill(#"damage");
    a_players = util::get_active_players();

    if(isDefined(s_result.attacker) && isplayer(s_result.attacker) && s_result.attacker zm_utility::function_aa45670f(s_result.weapon, 0)) {
      for(i = 0; i < a_players.size; i++) {
        if(a_players[i] === s_result.attacker) {
          self playSound(#"hash_7651f08f562fc850");
          self clientfield::increment("" + #"hash_546e7612359187c3", 1);
          level flag::set("symbol_hit_player_" + i + 1);
        }
      }
    }
  }
}

function_fde77b55(mdl_coil) {
  level notify(#"ley_reset");
  level endon(#"ley_start", #"ley_reset");

  while(true) {
    level flag::wait_till_any(array(#"hash_546b8f78e6510d81", #"hash_546b8c78e6510868", #"hash_546b8d78e6510a1b", #"hash_546b9278e651129a"));
    a_str_flags = [];

    for(i = 1; i < getplayers().size + 1; i++) {
      a_str_flags[a_str_flags.size] = "symbol_hit_player_" + i;
    }

    wait getplayers().size * 0.35;

    if(level flag::get_all(a_str_flags)) {
      level scene::play(#"p8_fxanim_zm_man_beam_device_bundle", "shot 2");
      var_2782a2fe = getent("beam_man", "targetname");
      var_2782a2fe playSound(#"hash_4a842fe16ea6db6a");
      var_2782a2fe clientfield::set("" + #"ley_lines", 1);
      level flag::set(#"ley_start");
      continue;
    }

    for(i = 1; i < getplayers().size + 1; i++) {
      level flag::clear("symbol_hit_player_" + i);
    }
  }
}

function_d3128b5f() {
  level flag::wait_till(#"ley_start");
  level.mdl_crystal clientfield::set("" + #"hash_34c5ab29531f15f0", 0);
  var_95807f2d = [];
  a_s_rings = struct::get_array(#"control_ring", "script_string");

  foreach(s_ring in a_s_rings) {
    trigger = spawn("trigger_box_use", s_ring.origin, 0, 64, 64, 64);
    trigger setcursorhint("HINT_NOICON");
    trigger triggerignoreteam();
    function_dae4ab9b(trigger, 0.1);
    trigger.str_pos = s_ring.script_noteworthy;
    trigger thread function_57692917(s_ring);

    if(!isDefined(var_95807f2d)) {
      var_95807f2d = [];
    } else if(!isarray(var_95807f2d)) {
      var_95807f2d = array(var_95807f2d);
    }

    var_95807f2d[var_95807f2d.size] = trigger;
  }

  var_310c1492 = struct::get("<dev string:x92>");
  var_556dff4b = spawn("<dev string:xa7>", var_310c1492.origin, 0, 64, 128);
  var_556dff4b setcursorhint("<dev string:xbc>");
  var_556dff4b triggerignoreteam();
  var_556dff4b.str_pos = var_310c1492.script_noteworthy;
  var_556dff4b thread function_57692917();

    level waittill(#"rings_done");
  array::run_all(var_95807f2d, &delete);

  var_556dff4b delete();

}

rings_start() {
  if(!zm_utility::is_ee_enabled()) {
    return;
  }

  var_7e35b184 = array(5, 6, 7);
  n_inner = array::random(var_7e35b184);
  arrayremovevalue(var_7e35b184, n_inner);

  for(i = 0; i < n_inner; i++) {
    ring_rotate("inner");
    waitframe(1);
  }

  n_middle = array::random(var_7e35b184);
  arrayremovevalue(var_7e35b184, n_middle);

  for(i = 0; i < n_middle; i++) {
    ring_rotate("middle");
    waitframe(1);
  }

  n_outer = array::random(var_7e35b184);
  arrayremovevalue(var_7e35b184, n_outer);

  for(i = 0; i < n_outer; i++) {
    ring_rotate("outer");
    waitframe(1);
  }
}

function_57692917(s_ring) {
  level endon(#"rings_done");

  if(isDefined(s_ring)) {
    trigger = trigger::wait_till(s_ring.target, "targetname", undefined, 0);

    if(isDefined(trigger)) {
      trigger delete();
    }

    level scene::play(s_ring.script_noteworthy + "_control", "open");
  }

  waitresult = undefined;
  player = undefined;

  while(true) {
    if(!isDefined(waitresult) || isalive(player) && (!player usebuttonpressed() || !player istouching(self))) {
      waitresult = self waittill(#"trigger");
      player = waitresult.activator;
    }

    if(level.var_1613cea0 || !zm_utility::can_use(player)) {
      waitframe(1);
      continue;
    }

    level.var_1613cea0 = 1;

    if(self.str_pos === "reset") {
      ring_reset();
    } else {
      player ring_rotate(self.str_pos, s_ring, 0);
    }

    level.var_1613cea0 = 0;
  }
}

ring_reset() {
  level.mdl_ring_inner.e_linkto rotateto(level.mdl_ring_inner.e_linkto.var_5287d229, 2);
  level.mdl_ring_middle.e_linkto rotateto(level.mdl_ring_middle.e_linkto.var_5287d229, 2);
  level.mdl_ring_outer.e_linkto rotateto(level.mdl_ring_outer.e_linkto.var_5287d229, 2);
  level.mdl_ring_inner playSound(#"hash_13acff42f13d9448");
  level.mdl_ring_middle playSound(#"hash_7813e29d18ad3dcf");
  level.mdl_ring_outer playSound(#"hash_3b464e57c6aa7e35");
  level.mdl_ring_outer.e_linkto waittilltimeout(2, #"rotatedone");
}

ring_rotate(str_pos, s_ring, var_50cc0d4f = 1) {
  if(var_50cc0d4f) {
    n_move_time = 0.1;
  } else {
    n_move_time = 2;
    level scene::stop(s_ring.script_noteworthy + "_control", "targetname");
  }

  if(!isDefined(s_ring) || self function_39b9ecb(s_ring)) {
    n_rot = 30;
    var_6c4c2561 = -30;

    if(!var_50cc0d4f) {
      level thread scene::play(s_ring.script_noteworthy + "_control", "wheel_right");
    }
  } else {
    n_rot = -30;
    var_6c4c2561 = 30;

    if(!var_50cc0d4f) {
      level thread scene::play(s_ring.script_noteworthy + "_control", "wheel_left");
    }
  }

  switch (str_pos) {
    case #"outer":
      level.mdl_ring_inner.e_linkto rotatepitch(var_6c4c2561, n_move_time);
      level.mdl_ring_middle.e_linkto rotateroll(n_rot, n_move_time);
      level.mdl_ring_outer.e_linkto rotatepitch(n_rot, n_move_time);
      level.mdl_ring_inner playSound(#"hash_1928aff0a0342673");
      level.mdl_ring_outer.e_linkto waittilltimeout(n_move_time, #"rotatedone");
      break;
    case #"middle":
      level.mdl_ring_outer.e_linkto rotatepitch(var_6c4c2561, n_move_time);
      level.mdl_ring_middle.e_linkto rotateroll(n_rot, n_move_time);
      level.mdl_ring_inner playSound(#"hash_1928aef0a03424c0");
      level.mdl_ring_middle.e_linkto waittilltimeout(n_move_time, #"rotatedone");
      break;
    case #"inner":
      level.mdl_ring_middle.e_linkto rotateroll(var_6c4c2561, n_move_time);
      level.mdl_ring_inner.e_linkto rotatepitch(n_rot, n_move_time);
      level.mdl_ring_inner playSound(#"hash_1928aef0a03424c0");
      level.mdl_ring_inner.e_linkto waittilltimeout(n_move_time, #"rotatedone");
      break;
  }

  if(var_50cc0d4f) {
    level.mdl_ring_inner.e_linkto.var_5287d229 = level.mdl_ring_inner.e_linkto.angles;
    level.mdl_ring_middle.e_linkto.var_5287d229 = level.mdl_ring_middle.e_linkto.angles;
    level.mdl_ring_outer.e_linkto.var_5287d229 = level.mdl_ring_outer.e_linkto.angles;
  }

  waitframe(1);

  if(level flag::get(#"power_on1") || level flag::get(#"hash_2daf5bdda85cc660")) {
    level thread ring_watcher(self);
  }
}

ring_watcher(player) {
  var_4a92152c = distancesquared(level.mdl_crystal_outer.v_start, level.mdl_crystal_outer.origin);
  var_b2a31570 = distancesquared(level.mdl_crystal_middle.v_start, level.mdl_crystal_middle.origin);
  var_a0357e49 = distancesquared(level.mdl_crystal_inner.v_start, level.mdl_crystal_inner.origin);

  if(var_4a92152c <= 5 * 5) {
    level.e_red clientfield::set("" + #"red_ray", 2);
  } else {
    level.e_red clientfield::set("" + #"red_ray", 1);
  }

  if(var_b2a31570 <= 5 * 5) {
    level.e_green clientfield::set("" + #"green_ray", 2);
  } else {
    level.e_green clientfield::set("" + #"green_ray", 1);
  }

  if(var_a0357e49 <= 5 * 5) {
    level.e_blue clientfield::set("" + #"blue_ray", 2);
  } else {
    level.e_blue clientfield::set("" + #"blue_ray", 1);
  }

  if(var_4a92152c <= 5 * 5 && var_b2a31570 <= 5 * 5 && var_a0357e49 <= 5 * 5) {
    level flag::set(#"rings_done");
    wait 0.5;

    if(isalive(player)) {
      player zm_audio::create_and_play_dialog(#"light_beam", #"aligned");
    }
  }
}

function_71d1b235() {
  level flag::wait_till(#"rings_done");
  playrumbleonposition("zm_mansion_atlas_globe_set_rumble", level.mdl_ring_outer.origin);
  level.mdl_crystal_inner playSound(#"hash_2647ce5bb2e14502");
  wait 2;
  s_atlas = struct::get("s_atl");
  s_atlas thread scene::play("melt");
  e_head = getent("head_collision", "targetname");
  e_head movey(32, 3);
  level.mdl_crystal clientfield::set("" + #"hash_34c5ab29531f15f0", 1);
  level waittill(#"rings_delete");
  level.mdl_rings showpart("link_ring1_jnt", "p8_fxanim_zm_man_atlas_rings_mod", 1);
  level.mdl_rings showpart("link_ring2_jnt", "p8_fxanim_zm_man_atlas_rings_mod", 1);
  level.mdl_rings showpart("link_ring3_jnt", "p8_fxanim_zm_man_atlas_rings_mod", 1);
  function_f856cc2();
  var_1ed057a1 = getent("beam_obs", "targetname");
  var_1ed057a1 clientfield::set("" + #"ley_lines", 2);
  wait 4;
  e_head disconnectpaths();
  var_9283def2 = array("zone_main_hall", "zone_main_hall_north", "zone_start_east", "zone_start_west", "zone_grand_staircase");
  a_players = [];

  foreach(player in util::get_active_players()) {
    if(player zm_zonemgr::is_player_in_zone(var_9283def2)) {
      if(!isDefined(a_players)) {
        a_players = [];
      } else if(!isarray(a_players)) {
        a_players = array(a_players);
      }

      a_players[a_players.size] = player;
    }
  }

  if(a_players.size) {
    array::random(a_players) zm_audio::create_and_play_dialog(#"atlas_stat", #"collapse");
  }

  wait 2;
  level scene::stop(#"p8_fxanim_zm_man_atlas_control_panel_bundle");
  level scene::play(#"p8_fxanim_zm_man_atlas_control_panel_bundle", "close");
}

function_ea49787e(a_ents) {
  level.mdl_crystal = a_ents[#"crystal"];
  level.mdl_atlas = a_ents[#"atlas"];
  level.mdl_rings = a_ents[#"atlas_rings"];
  util::wait_network_frame(5);
  level.mdl_crystal clientfield::set("" + #"hash_34c5ab29531f15f0", 1);
  level.mdl_rings hidepart("link_ring1_jnt", "p8_fxanim_zm_man_atlas_rings_mod", 1);
  level.mdl_rings hidepart("link_ring2_jnt", "p8_fxanim_zm_man_atlas_rings_mod", 1);
  level.mdl_rings hidepart("link_ring3_jnt", "p8_fxanim_zm_man_atlas_rings_mod", 1);
}

function_f856cc2() {
  level.mdl_ring_outer.e_linkto delete();
  level.mdl_ring_outer.var_846c254a delete();
  level.mdl_ring_outer delete();
  level.mdl_ring_middle.e_linkto delete();
  level.mdl_ring_middle.var_846c254a delete();
  level.mdl_ring_middle delete();
  level.mdl_ring_inner.e_linkto delete();
  level.mdl_ring_inner.var_846c254a delete();
  level.mdl_ring_inner delete();
  level.e_blue delete();
  level.e_red delete();
  level.e_green delete();
}

function_604f9d73(a_ents) {
  level.mdl_telescope = a_ents[getfirstarraykey(a_ents)];
  scene::remove_scene_func(#"p8_fxanim_zm_man_telescope_bundle", &function_604f9d73, "init");
}

function_b1b02a54() {
  a_s_scene = struct::get_script_bundle_instances("scene", #"p8_fxanim_zm_man_dome_crank_wheel_bundle");
  a_scene_ents = a_s_scene[getfirstarraykey(a_s_scene)].scene_ents;
  mdl_wheel = a_scene_ents[getfirstarraykey(a_scene_ents)];
  mdl_wheel stopanimscripted();
  mdl_wheel moveto(mdl_wheel.origin, 0.1);
  return mdl_wheel;
}

door_opener() {
  mdl_wheel = function_b1b02a54();
  var_47323b73 = mdl_wheel zm_unitrigger::create();
  var_47323b73.mdl_wheel = mdl_wheel;
  var_47323b73.mdl_door_right = getent("mdl_telescope_observatory_door_right", "targetname");
  var_47323b73.mdl_door_left = getent("mdl_telescope_observatory_door_left", "targetname");
  var_47323b73 thread function_250cf19b();
  level flag::wait_till(#"wheel_locked");
  zm_unitrigger::unregister_unitrigger(var_47323b73);
}

function_250cf19b() {
  level endon(#"greenhouse_open", #"wheel_locked");
  level scene::stop(#"p8_fxanim_zm_man_dome_crank_bundle");
  level thread scene::play(#"p8_fxanim_zm_man_dome_crank_bundle", "reset");
  level flag::wait_till(#"hash_702dbaf6695a5607");
  waitframe(1);
  level scene::stop(#"p8_fxanim_zm_man_dome_crank_bundle");
  level thread scene::play(#"p8_fxanim_zm_man_dome_crank_bundle", "part_open");
  self.mdl_door_right unlink();
  self.mdl_door_left unlink();

  if(!isDefined(level.n_turns)) {
    level.n_turns = 0;
  }

  while(true) {
    waitresult = self.mdl_wheel waittill(#"trigger_activated");
    player = waitresult.e_who;

    if(!zm_utility::can_use(player)) {
      continue;
    }

    while(isalive(player) && player usebuttonpressed() && isDefined(self.trigger) && player istouching(self.trigger)) {
      if(level.n_turns < 16) {
        self.mdl_wheel rotateroll(-90, 0.25);
        self.mdl_wheel playLoopSound(#"hash_70057df239d8bb23");
        var_5a2e8e4f = anglestoright(self.mdl_door_right.angles);
        var_58aebac7 = anglestoright(self.mdl_door_left.angles);
        var_a40d6e4f = self.mdl_door_right.origin + var_5a2e8e4f * 4;
        var_5f19fbd3 = self.mdl_door_left.origin - var_58aebac7 * 4;
        self.mdl_door_right moveto(var_a40d6e4f, 0.25);
        self.mdl_door_left moveto(var_5f19fbd3, 0.25);
        self.mdl_door_right playLoopSound(#"hash_1734ee34b49eddb4");
        level.n_turns++;

        if(level.n_turns >= 16) {
          self.mdl_door_right playSound(#"hash_7134188ed9012ffe");
          self.mdl_door_right stoploopsound();
          self.mdl_wheel stoploopsound();
        }

        array::wait_till(array(self.mdl_door_right, self.mdl_door_left), "movedone");
        continue;
      }

      wait 0.25;
    }

    self.mdl_door_right stoploopsound();
    self.mdl_wheel stoploopsound();

    if(getplayers().size == 1) {
      wait 1;
    }

    if(!level flag::get(#"wheel_locked")) {
      level scene::stop(#"p8_fxanim_zm_man_dome_crank_bundle");
      level thread scene::play(#"p8_fxanim_zm_man_dome_crank_bundle", "reset");

      if(level.n_turns < 5) {
        var_c5af0345 = 5 - level.n_turns;
      }

      while(level.n_turns) {
        self.mdl_wheel rotateroll(90, 0.25);
        self.mdl_wheel playLoopSound(#"hash_70057df239d8bb23");
        var_5a2e8e4f = anglestoright(self.mdl_door_right.angles);
        var_58aebac7 = anglestoright(self.mdl_door_left.angles);
        var_a40d6e4f = self.mdl_door_right.origin - var_5a2e8e4f * 4;
        var_5f19fbd3 = self.mdl_door_left.origin + var_58aebac7 * 4;
        self.mdl_door_right moveto(var_a40d6e4f, 0.25);
        self.mdl_door_left moveto(var_5f19fbd3, 0.25);
        self.mdl_door_right playLoopSound(#"hash_644ccbe0bd198b6");
        level.n_turns--;
        array::wait_till(array(self.mdl_door_right, self.mdl_door_left), "movedone");
      }

      if(isDefined(var_c5af0345)) {
        wait 0.25 * var_c5af0345;
        var_c5af0345 = undefined;
      }

      level scene::stop(#"p8_fxanim_zm_man_dome_crank_bundle");
      level thread scene::play(#"p8_fxanim_zm_man_dome_crank_bundle", "part_open");
      self.mdl_door_right stoploopsound();
      self.mdl_wheel stoploopsound();
      self.mdl_door_right playSound(#"hash_5bb03dee040764f4");
    }
  }
}

function_5164d716() {
  level endon(#"wheel_locked", #"greenhouse_open");
  level flag::wait_till(#"hash_702dbaf6695a5607");
  var_e0cc1e20 = getent("trigger_obs_wheel_lock", "targetname");
  var_e0cc1e20.health = 99999;

  while(true) {
    s_notify = var_e0cc1e20 waittill(#"damage");
    var_e0cc1e20.health += s_notify.amount;

    if(isDefined(s_notify.attacker) && isplayer(s_notify.attacker) && mansion_util::is_shield(s_notify.weapon) && s_notify.mod === "MOD_MELEE" && isDefined(level.n_turns) && level.n_turns > 15) {
      mdl_wheel = function_b1b02a54();
      mdl_wheel scene::play(#"p8_fxanim_zm_man_dome_crank_wheel_bundle", mdl_wheel);
      mdl_door_right = getent("mdl_telescope_observatory_door_right", "targetname");
      mdl_wheel stoploopsound();
      mdl_door_right stoploopsound();
      var_e0cc1e20 delete();
      level scene::stop(#"p8_fxanim_zm_man_dome_crank_bundle");
      level thread scene::play(#"p8_fxanim_zm_man_dome_crank_bundle", "open");
      level flag::set(#"wheel_locked");
    }
  }
}

function_e188ae5d() {
  mdl_base = getent("mdl_tel_base", "targetname");
  mdl_wheel = getent("mdl_tel_wheel", "targetname");

  foreach(var_6142bc53 in level.var_21d0f5ee) {
    mdl_wheel hidepart("tag_wheel_" + var_6142bc53);
    mdl_base hidepart(var_6142bc53 + "_01");
    mdl_base hidepart(var_6142bc53 + "_02");
    mdl_base hidepart(var_6142bc53 + "_03");
  }

  level flag::wait_till(#"rings_done");

  foreach(var_6142bc53 in level.var_21d0f5ee) {
    mdl_wheel showpart("tag_wheel_" + var_6142bc53);
    mdl_base hidepart(var_6142bc53 + "_01");
    mdl_base hidepart(var_6142bc53 + "_02");
    mdl_base hidepart(var_6142bc53 + "_03");
  }
}

function_3f64b455() {
  level endon(#"combo_done");
  mdl_wheel = getent("mdl_tel_wheel", "targetname");
  n_shot = 0;
  level.var_21d0f5ee = array("aquarius", "pisces", "aries", "taurus", "gemini", "cancer", "leo", "virgo", "libra", "scorpio", "sagittarius", "capricorn");
  level thread function_e188ae5d();
  mdl_wheel.s_unitrigger = mdl_wheel zm_unitrigger::create(undefined, 48, &function_5e54642e);
  zm_unitrigger::function_89380dda(mdl_wheel.s_unitrigger);
  level.var_779d8f63 = 1;
  s_result = undefined;

  while(true) {
    if(!isDefined(s_result) || isalive(s_result.e_who) && (!s_result.e_who usebuttonpressed() || isDefined(mdl_wheel.s_unitrigger.trigger) && !s_result.e_who istouching(mdl_wheel.s_unitrigger.trigger))) {
      s_result = mdl_wheel waittill(#"trigger_activated");
    }

    if(isplayer(s_result.e_who)) {
      if(s_result.e_who function_39b9ecb(mdl_wheel.s_unitrigger)) {
        level.var_779d8f63--;

        if(level.var_779d8f63 < 1) {
          level.var_779d8f63 = 12;
        }
      } else {
        level.var_779d8f63++;

        if(level.var_779d8f63 > 12) {
          level.var_779d8f63 = 1;
        }
      }

      s_rotate = struct::get(level.var_21d0f5ee[level.var_779d8f63 - 1]);
      mdl_wheel rotateto(s_rotate.angles, 0.35);
      mdl_wheel playSound(#"hash_bbeb6a0420a769e");

      if(n_shot < 9) {
        n_shot++;
      } else {
        n_shot = 1;
      }

      scene::play(#"p8_fxanim_zm_man_telescope_control_gears_bundle", "shot " + n_shot);
    }
  }
}

function_39b9ecb(s_unitrigger) {
  v_delta = vectornormalize(s_unitrigger.origin - self getEye());
  v_view = anglesToForward(self getplayerangles());
  v_cross = vectorcross(v_view, v_delta);
  var_35b81369 = vectordot(v_cross, anglestoup(s_unitrigger.angles));
  var_7c6b02a8 = vectordot(v_cross, (0, 0, 1));

  if(var_35b81369 >= 0 && var_7c6b02a8 >= 0) {
    return 1;
  }

  return 0;
}

function_5e54642e() {
  self endon(#"death");
  function_dae4ab9b(self, 0.1);
  self zm_unitrigger::function_69168e61();
}

function_9513d3a6() {
  level flag::wait_till(#"rings_done");
  a_s_locs = struct::get_array("symbol_combo_loc");
  struct::get("s_zodiac_symbol_spawn");
  var_3ab52107 = [];

  for(i = 1; i <= 12; i++) {
    if(!isDefined(var_3ab52107)) {
      var_3ab52107 = [];
    } else if(!isarray(var_3ab52107)) {
      var_3ab52107 = array(var_3ab52107);
    }

    var_3ab52107[var_3ab52107.size] = i;
  }

  if(isDefined(level.var_d181080c)) {
    foreach(mdl_symbol in level.var_d181080c) {
      if(isDefined(mdl_symbol.var_c6f538f0)) {
        array::run_all(mdl_symbol.var_c6f538f0, &delete);
      }

      mdl_symbol delete();
    }
  }

  level.var_d181080c = [];
  level.var_5c086e54 = [];

  for(i = 0; i < 3; i++) {
    n_symbol = array::random(var_3ab52107);
    arrayremovevalue(var_3ab52107, n_symbol);

    switch (n_symbol) {
      case 1:
        str_model = "p8_zm_man_zodiac_sign_aquarius";
        break;
      case 2:
        str_model = "p8_zm_man_zodiac_sign_pisces";
        break;
      case 3:
        str_model = "p8_zm_man_zodiac_sign_aries";
        break;
      case 4:
        str_model = "p8_zm_man_zodiac_sign_taurus";
        break;
      case 5:
        str_model = "p8_zm_man_zodiac_sign_gemini";
        break;
      case 6:
        str_model = "p8_zm_man_zodiac_sign_cancer";
        break;
      case 7:
        str_model = "p8_zm_man_zodiac_sign_leo";
        break;
      case 8:
        str_model = "p8_zm_man_zodiac_sign_virgo";
        break;
      case 9:
        str_model = "p8_zm_man_zodiac_sign_libra";
        break;
      case 10:
        str_model = "p8_zm_man_zodiac_sign_scorpio";
        break;
      case 11:
        str_model = "p8_zm_man_zodiac_sign_sagittarius";
        break;
      case 12:
        str_model = "p8_zm_man_zodiac_sign_capricorn";
        break;
    }

    mdl_symbol = util::spawn_model(str_model, (0, 0, -400));
    mdl_symbol.script_int = n_symbol;
    mdl_symbol.s_loc = array::random(a_s_locs);
    arrayremovevalue(a_s_locs, mdl_symbol.s_loc);
    level.var_d181080c[level.var_d181080c.size] = mdl_symbol;
  }

  level thread function_8ced5d5b();
}

function_8ced5d5b() {
  a_n_numbers = array(7, 9, 11, 13, 15);
  var_679750f5 = [];

  for(i = 0; i < 3; i++) {
    n_num = array::random(a_n_numbers);
    var_679750f5[var_679750f5.size] = n_num;
    arrayremovevalue(a_n_numbers, n_num);
  }

  var_db303d4f = array::sort_by_value(var_679750f5, 1);

  for(i = 0; i < 3; i++) {
    level.var_d181080c[i].origin = level.var_d181080c[i].s_loc.origin;
    level.var_d181080c[i].angles = level.var_d181080c[i].s_loc.angles;
    level.var_d181080c[i].var_19d827d = var_db303d4f[i];
    level.var_d181080c[i] thread function_7cc34fef();
  }
}

function_7cc34fef() {
  self.var_c6f538f0 = [];
  self.a_s_locs = struct::get_array(self.s_loc.script_noteworthy);
  self.a_s_locs = array::randomize(self.a_s_locs);

  switch (self.var_19d827d) {
    case 7:
      self.var_c6f538f0[0] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_03_01", self.a_s_locs[0].origin, self.a_s_locs[0].angles);
      self.var_c6f538f0[1] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_04_01", self.a_s_locs[1].origin, self.a_s_locs[1].angles);
      break;
    case 9:
      if(math::cointoss()) {
        self.var_c6f538f0[0] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_04_01", self.a_s_locs[0].origin, self.a_s_locs[0].angles);
        self.var_c6f538f0[1] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_05_01", self.a_s_locs[1].origin, self.a_s_locs[1].angles);
      } else {
        self.var_c6f538f0[0] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_03_01", self.a_s_locs[0].origin, self.a_s_locs[0].angles);
        self.var_c6f538f0[1] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_03_01", self.a_s_locs[1].origin, self.a_s_locs[1].angles);
        self.var_c6f538f0[2] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_03_01", self.a_s_locs[2].origin, self.a_s_locs[2].angles);
      }

      break;
    case 11:
      self.var_c6f538f0[0] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_03_01", self.a_s_locs[0].origin, self.a_s_locs[0].angles);
      self.var_c6f538f0[1] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_03_01", self.a_s_locs[1].origin, self.a_s_locs[1].angles);
      self.var_c6f538f0[2] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_05_01", self.a_s_locs[2].origin, self.a_s_locs[2].angles);
      break;
    case 13:
      self.var_c6f538f0[0] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_03_01", self.a_s_locs[0].origin, self.a_s_locs[0].angles);
      self.var_c6f538f0[1] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_05_01", self.a_s_locs[1].origin, self.a_s_locs[1].angles);
      self.var_c6f538f0[2] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_05_01", self.a_s_locs[2].origin, self.a_s_locs[2].angles);
      break;
    case 15:
      self.var_c6f538f0[0] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_05_01", self.a_s_locs[0].origin, self.a_s_locs[0].angles);
      self.var_c6f538f0[1] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_05_01", self.a_s_locs[1].origin, self.a_s_locs[1].angles);
      self.var_c6f538f0[2] = util::spawn_model("p8_zm_werewolf_claw_marks_grp_05_01", self.a_s_locs[2].origin, self.a_s_locs[2].angles);
      break;
  }
}

function_bfefc7aa() {
  level endon(#"combo_done");
  self notify(#"combo_reset");
  self endon(#"combo_reset");
  mdl_wheel = getent("mdl_tel_wheel", "targetname");
  mdl_base = getent("mdl_tel_base", "targetname");
  self.health = 99999;

  while(true) {
    s_notify = self waittill(#"damage");
    self.health += s_notify.amount;

    if(level flag::get(#"combo_dialed") || !isDefined(level.var_779d8f63) || !isDefined(level.var_21d0f5ee) || isinarray(level.var_5c086e54, level.var_779d8f63)) {
      continue;
    }

    if(s_notify.mod !== #"mod_melee") {
      continue;
    }

    if(isplayer(s_notify.attacker)) {
      level.var_5c086e54[level.var_5c086e54.size] = level.var_779d8f63;
      mdl_base showpart(level.var_21d0f5ee[level.var_779d8f63 - 1] + "_0" + level.var_5c086e54.size);
      mdl_wheel hidepart("tag_wheel_" + level.var_21d0f5ee[level.var_779d8f63 - 1]);
      playsoundatposition(#"hash_7391894450e708c9", mdl_base gettagorigin(level.var_21d0f5ee[level.var_779d8f63 - 1] + "_0" + level.var_5c086e54.size));
      mdl_wheel playSound(#"hash_8ea83abca0ca591");

      if(level.var_5c086e54.size > 2) {
        level.var_ee0a344c = s_notify.attacker;
        level flag::set(#"combo_dialed");
      }
    }
  }
}

combo_watcher() {
  level endon(#"combo_done");
  mdl_wheel = getent("mdl_tel_wheel", "targetname");
  mdl_base = getent("mdl_tel_base", "targetname");

  while(true) {
    level flag::wait_till(#"combo_dialed");

    for(i = 0; i < 3; i++) {
      wait 0.75;
      mdl_base hidepart(level.var_21d0f5ee[level.var_5c086e54[0] - 1] + "_01");
      mdl_base hidepart(level.var_21d0f5ee[level.var_5c086e54[1] - 1] + "_02");
      mdl_base hidepart(level.var_21d0f5ee[level.var_5c086e54[2] - 1] + "_03");
      wait 0.5;
      playsoundatposition(#"hash_7391894450e708c9", mdl_base gettagorigin(level.var_21d0f5ee[level.var_5c086e54[1] - 1] + "_02"));
      mdl_base showpart(level.var_21d0f5ee[level.var_5c086e54[0] - 1] + "_01");
      mdl_base showpart(level.var_21d0f5ee[level.var_5c086e54[1] - 1] + "_02");
      mdl_base showpart(level.var_21d0f5ee[level.var_5c086e54[2] - 1] + "_03");
    }

    if(level.var_5c086e54[0] === level.var_d181080c[0].script_int && level.var_5c086e54[1] === level.var_d181080c[1].script_int && level.var_5c086e54[2] === level.var_d181080c[2].script_int) {
      if(isalive(level.var_ee0a344c)) {
        level.var_ee0a344c zm_audio::create_and_play_dialog(#"telescope", #"code_confirm");
        level.var_ee0a344c = undefined;
      }

      mdl_wheel playSound(#"hash_68988cab9fa84ad5");
      zm_unitrigger::unregister_unitrigger(mdl_wheel.s_unitrigger);
      level flag::set(#"combo_done");
      continue;
    }

    mdl_base hidepart(level.var_21d0f5ee[level.var_5c086e54[0] - 1] + "_01");
    mdl_base hidepart(level.var_21d0f5ee[level.var_5c086e54[1] - 1] + "_02");
    mdl_base hidepart(level.var_21d0f5ee[level.var_5c086e54[2] - 1] + "_03");

    foreach(var_6142bc53 in level.var_21d0f5ee) {
      mdl_wheel hidepart("tag_wheel_" + var_6142bc53);
    }

    mdl_wheel playSound(#"hash_12c1d713dd5a5d68");
    level.var_ee0a344c = undefined;
    level.var_5c086e54 = undefined;
    wait 5;
    function_9513d3a6();

    foreach(var_6142bc53 in level.var_21d0f5ee) {
      mdl_wheel showpart("tag_wheel_" + var_6142bc53);
    }

    level flag::clear(#"combo_dialed");
  }
}

function_d8162064() {
  level endon(#"greenhouse_open");
  level flag::wait_till(#"combo_done");
  mdl_door_right = getent("mdl_telescope_observatory_door_right", "targetname");
  mdl_door_left = getent("mdl_telescope_observatory_door_left", "targetname");
  mdl_door_right linkto(level.mdl_telescope, "p8_zm_man_greenhouse_ext_dome_01_link_jnt");
  mdl_door_left linkto(level.mdl_telescope, "p8_zm_man_greenhouse_ext_dome_01_link_jnt");
  array::run_all(util::get_active_players(), &clientfield::increment_to_player, "" + #"mansion_mq_rumble", 1);
  level scene::play(#"p8_fxanim_zm_man_telescope_bundle");
  level flag::set(#"hash_702dbaf6695a5607");
}

function_a99a5c4e(a_s_valid_respawn_points) {
  var_e9b059c7 = [];

  foreach(s_respawn_point in a_s_valid_respawn_points) {
    if(s_respawn_point.script_noteworthy == "zone_greenhouse_lab") {
      if(!isDefined(var_e9b059c7)) {
        var_e9b059c7 = [];
      } else if(!isarray(var_e9b059c7)) {
        var_e9b059c7 = array(var_e9b059c7);
      }

      var_e9b059c7[var_e9b059c7.size] = s_respawn_point;
    }
  }

  return var_e9b059c7;
}

power_beam() {
  level endon(#"hash_11429494f29d116d");
  level flag::wait_till(#"combo_done");
  level clientfield::set("" + #"skybox_stream", 1);
  var_7f147f52 = getent("t_eshield_check", "targetname");
  var_7f147f52.health = 999999;
  var_7f147f52 function_d5bfc8e8();
  level thread zm_utility::function_9ad5aeb1(1, 1, 0, 1, 0);
}

function_d5bfc8e8() {
  level endon(#"hash_11429494f29d116d");
  self endon(#"death");
  self.a_bashers = [];
  var_1a50a8c5 = undefined;

  do {
    s_result = self waittill(#"damage");
    self.health += s_result.amount;
    e_player = s_result.inflictor;
    var_989dd232 = 0;

    if(isplayer(e_player)) {
      var_989dd232 = isDefined(e_player.var_4ceff143) && e_player.var_4ceff143 && s_result.mod === "MOD_MELEE" && mansion_util::is_shield(s_result.weapon);
    }

    if(var_989dd232) {
      e_player thread function_3d93d103();

      if(!isDefined(self.a_bashers)) {
        self.a_bashers = [];
      } else if(!isarray(self.a_bashers)) {
        self.a_bashers = array(self.a_bashers);
      }

      if(!isinarray(self.a_bashers, e_player)) {
        self.a_bashers[self.a_bashers.size] = e_player;
      }
    }

    var_1a50a8c5 = 0;
    self.a_bashers = array::remove_undefined(self.a_bashers);

    foreach(e_basher in self.a_bashers) {
      if(isDefined(e_basher.var_12c0dec1) && e_basher.var_12c0dec1) {
        var_1a50a8c5++;
      }
    }
  }
  while(var_1a50a8c5 < getplayers().size);
}

function_3d93d103() {
  self notify("2e914afcb974e9ec");
  self endon("2e914afcb974e9ec");
  self endon(#"disconnect");
  self.var_12c0dec1 = 1;
  self playSound(#"hash_613cef4818d77aca");
  wait 1.6;

  if(isplayer(self)) {
    self.var_12c0dec1 = undefined;
  }
}

function_b87ae607(n_stage) {
  e_trap = getent("werewolfer_trap_touch", "targetname");

  while(true) {
    level flag::wait_till(#"hash_6f483dda6f8ab19d");

    while(level flag::get(#"hash_6f483dda6f8ab19d")) {
      foreach(player in util::get_active_players()) {
        if(isDefined(player.var_c09a076a) && player.var_c09a076a && player istouching(e_trap) && !(isDefined(player.var_c79d709f) && player.var_c79d709f) && !(isDefined(player.var_4ceff143) && player.var_4ceff143)) {
          player.var_4ceff143 = 1;
          player.var_c79d709f = 1;
          player notify(#"shield_timeout");
          player thread function_371e56be(e_trap);
        }
      }

      waitframe(1);
    }
  }
}

function_371e56be(e_trap) {
  self notify(#"hash_1e76041e9fa5f479");
  self endon(#"disconnect", #"hash_1e76041e9fa5f479", #"death");
  self clientfield::set("" + #"hash_5370f4bc9fc25d13", 1);

  while(level flag::get(#"hash_6f483dda6f8ab19d") && self istouching(e_trap) && mansion_util::is_shield(self getcurrentweapon())) {
    waitframe(1);
  }

  self.var_c79d709f = undefined;
  self thread function_53577dc7();

  if(!mansion_util::is_shield(self getcurrentweapon())) {
    self notify(#"hash_459246e5bfcc3713");
    self notify(#"hash_1e76041e9fa5f479");
  }

  while(isDefined(self.var_4ceff143) && self.var_4ceff143) {
    s_result = self waittill(#"shield_timeout", #"weapon_change");

    if(s_result._notify !== "weapon_change" || !mansion_util::is_shield(s_result.weapon)) {
      self notify(#"hash_459246e5bfcc3713");
    }
  }
}

function_53577dc7() {
  self endon(#"disconnect");
  self waittilltimeout(9.2, #"shield_timeout", #"hash_459246e5bfcc3713", #"destroy_riotshield");
  self.var_4ceff143 = 0;
  self clientfield::set("" + #"hash_5370f4bc9fc25d13", 0);
  self notify(#"shield_timeout");
}

tube_shoot() {
  level flag::wait_till(#"hash_702dbaf6695a5607");
  level.mdl_telescope clientfield::set("" + #"power_beam", 2);
  level.mdl_telescope playSound(#"hash_7602966ff564e065");
  level.mdl_telescope playLoopSound(#"hash_69b6d00136d35f2b");
  wait 5.3;
  level thread zm_utility::function_9ad5aeb1(0, 1, 0, 1, 0);

  foreach(player in getplayers()) {
    player setlightingstate(1);
  }

  level util::delay(5, undefined, &clientfield::set, "" + #"skybox_stream", 0);
  player = level.mdl_telescope mansion_util::get_closest_valid_player();

  if(isDefined(player)) {
    player zm_audio::create_and_play_dialog(#"full_moon", #"react_first");
  }

  getent("beam_man", "targetname") clientfield::set("" + #"ley_lines", 0);
  getent("beam_obs", "targetname") clientfield::set("" + #"ley_lines", 3);
  level.mdl_telescope clientfield::set("" + #"power_beam", 0);
  level.mdl_telescope stoploopsound();
  level.mdl_telescope playSound(#"hash_79e81e464a483017");
  level.mdl_telescope = undefined;
}

function_f3668a9() {
  level flag::wait_till(#"hash_b240a9137ecc6f9");
  wait 15;
  level flag::set(#"spawn_zombies");
  level flag::set(#"zombie_drop_powerups");
}

function_c888f1f4() {
  level endon(#"greenhouse_open");
  wait 8;
  exploder::exploder("exp_lgt_telescope_base_door");
  trigger = trigger::wait_till("scope_door_open", "targetname", undefined, 0);
  mdl_stone = getent("stone_obs", "targetname");
  mdl_stone show();
  mdl_stone clientfield::set("" + #"force_stream_model", 1);

  if(isDefined(trigger)) {
    trigger delete();
  }

  mdl_door = getent("mdl_telescope_base_door", "targetname");
  s_moveto = struct::get(mdl_door.target);
  array::run_all(util::get_active_players(), &clientfield::increment_to_player, "" + #"mansion_mq_rumble", 1);
  mdl_door moveto(s_moveto.origin, 3, 0.1, 1.5);
  mdl_door playSound(#"hash_34b16f03c4ce4b97");
  mdl_door waittill(#"movedone");
  mdl_door moveto(s_moveto.origin - (0, 0, 64), 3);
  mdl_door playSound(#"hash_34b17003c4ce4d4a");
  mdl_door waittill(#"movedone");
  var_47323b73 = mdl_stone zm_unitrigger::create(undefined, 128);
  var_47323b73.v_start = mdl_stone.angles;
  mdl_stone thread function_31e641f5();
}

function_31e641f5() {
  level endon(#"greenhouse_open");

  while(true) {
    self waittill(#"trigger_activated");
    b_using = 1;
    n_time = 0;
    self thread mansion_util::function_6a523c8c((1, 0, 0));
    self playSound(#"hash_54ef1510e22e8574");

    while(n_time < 3) {
      foreach(player in getplayers()) {
        if(!player usebuttonpressed() || !zm_utility::can_use(player) || !isDefined(self.s_unitrigger) || !isDefined(self.s_unitrigger.trigger) || !player istouching(self.s_unitrigger.trigger)) {
          b_using = 0;
          n_time = 0;
          break;
        }
      }

      if(b_using == 0) {
        self notify(#"stop_wobble");
        self.angles = self.s_unitrigger.v_start;
        self clientfield::set("" + #"stone_glow", 0);
        self playSound(#"hash_3640a466781bf551");
        break;
      }

      self clientfield::set("" + #"stone_glow", 1);
      wait 0.1;
      n_time += 0.1;
    }

    if(b_using == 1) {
      self playSound(#"hash_e1ac3a86a1144fc");
      break;
    }

    wait 0.1;
  }

  array::run_all(util::get_active_players(), &clientfield::increment_to_player, "" + #"mansion_mq_rumble", 1);
  level flag::set(#"disable_fast_travel");
  level clientfield::set("fasttravel_exploder", 0);
  exploder::exploder("fxexp_barrier_gameplay_observatory");
  level thread mansion_util::function_f1c106b("loc4", 1);
  self clientfield::set("" + #"stone_soul", 1);
  self playLoopSound(#"hash_5eb57257201f9043");
  self moveto(struct::get(self.target).origin, 1);
  self waittill(#"movedone");
  self clientfield::set("" + #"stone_pickup", 1);
  self thread function_a8ddd91f();
  wait 1;
  self.var_4c4f2b6 = self.angles;
  self thread mansion_util::function_da5cd631();
  level flag::set(#"house_defend");
  zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
}

function_a8ddd91f() {
  level endon(#"greenhouse_open");
  level flag::wait_till(#"hash_b240a9137ecc6f9");
  level thread zm_utility::function_9ad5aeb1(0, 1, 0, 1, 0);
  level.var_84b2907f = undefined;
  wait 2;
  mdl_stone = getent("stone_obs", "targetname");
  mdl_stone notify(#"stop_spin");
  mdl_stone stoploopsound();
  mdl_stone playSound(#"hash_3019afe90c2eb3aa");
  wait 0.5;
  mdl_stone rotateto(mdl_stone.var_4c4f2b6, 1);
  mdl_stone waittill(#"rotatedone");
  mdl_stone clientfield::set("" + #"stone_soul", 0);
  mdl_stone bobbing((0, 1, 0), 1, 5);
  var_47323b73 = mdl_stone zm_unitrigger::create(undefined, 96, &function_c9ebaa3);
}

function_c9ebaa3() {
  while(!level flag::get(#"greenhouse_open")) {
    waitresult = self waittill(#"trigger");
    player = waitresult.activator;

    if(!zm_utility::can_use(player)) {
      continue;
    }

    player thread mansion_util::function_f15c4657();
    level thread function_78a99a79();
    zm_unitrigger::unregister_unitrigger(self.stub);
  }
}

function_78a99a79() {
  mdl_stone = getent("stone_obs", "targetname");

  if(isDefined(mdl_stone)) {
    v_loc = mdl_stone.origin + (15, 0, -40);
    mdl_stone clientfield::increment("" + #"stone_despawn", 1);
    mdl_stone playSound(#"hash_397fa4e3bc7de2fb");
    mdl_stone thread util::delayed_delete(1);
    zm_powerups::specific_powerup_drop(#"full_ammo", v_loc);
  }

  level flag::set(#"greenhouse_open");
}

wave_1() {
  level endon(#"hash_b240a9137ecc6f9");
  level flag::wait_till(#"house_defend");
  wait 2;
  n_players = getplayers().size;

  switch (n_players) {
    case 1:
      n_num = 16;
      n_current = 9;
      break;
    case 2:
      n_num = 22;
      n_current = 13;
      break;
    case 3:
      n_num = 27;
      n_current = 17;
      break;
    case 4:
      n_num = 32;
      n_current = 20;
      break;
  }

  level.var_e12e0420 = 0;
  level.var_84b2907f = &function_a9b81878;
  a_s_locs = array::randomize(struct::get_array("greenhouse_bat"));
  x = 0;
  level flag::set(#"hash_29b12646045186fa");

  for(i = 0; i < n_num; i++) {
    if(getaiteamarray(level.zombie_team).size >= 24) {
      level flag::set(#"hash_29b12646045186fa");
    }

    ai_bat = bat::function_2e37549f(1, a_s_locs[x], 20);

    if(isDefined(ai_bat)) {
      level.var_e12e0420++;
      x++;
      ai_bat.no_powerups = 1;
      ai_bat zm_score::function_acaab828();
      ai_bat callback::function_d8abfc3d(#"on_ai_killed", &function_3da8da85);

      if(x == a_s_locs.size) {
        x = 0;
      }

      while(level.var_e12e0420 >= n_current || getaiteamarray(level.zombie_team).size >= 24) {
        waitframe(1);
      }
    }

    level flag::clear(#"hash_29b12646045186fa");
    wait randomfloatrange(0.2, 0.5);
  }

  level flag::clear(#"hash_29b12646045186fa");
  function_aa1d0bc6();
}

function_a9b81878(ai) {
  if(isalive(ai)) {
    ai.no_powerups = 1;
    ai zm_score::function_acaab828();
    ai waittill(#"death");

    if(isDefined(level.var_e12e0420)) {
      level.var_e12e0420--;
    }
  }
}

function_3da8da85(params) {
  level.var_e12e0420--;
}

function_aa1d0bc6() {
  if(isDefined(20 - getplayers().size)) {
    __s = spawnStruct();
    __s endon(#"timeout");
    __s util::delay_notify(20 - getplayers().size, "timeout");
  }

  function_655a2fcc();
}

function_655a2fcc() {
  while(true) {
    if(level.var_e12e0420 < 5) {
      return;
    }

    wait 0.25;
  }
}

wave_2() {
  level endon(#"hash_b240a9137ecc6f9");
  wait 2;

  switch (getplayers().size) {
    case 1:
      n_wolves = 20;
      break;
    case 2:
      n_wolves = 26;
      break;
    case 3:
      n_wolves = 32;
      break;
    case 4:
      n_wolves = 40;
      break;
  }

  level.var_20f423f6 = 0;

  for(i = 0; i < n_wolves; i++) {
    var_69024a6a = zm_mansion_special_rounds::function_988438a7(level.dog_spawners[0], undefined, 20);

    if(isDefined(var_69024a6a)) {
      level.var_20f423f6++;
      var_69024a6a zombie_dog_util::dog_init();
      var_69024a6a.var_126d7bef = 1;
      var_69024a6a.ignore_round_spawn_failsafe = 1;
      var_69024a6a.ignore_enemy_count = 1;
      var_69024a6a.b_ignore_cleanup = 1;
      var_69024a6a.no_powerups = 1;
      var_69024a6a.favoriteenemy = array::random(getplayers());
      s_spawn_loc = zm_mansion_special_rounds::function_e1c262fb(var_69024a6a);
      var_69024a6a forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
      var_69024a6a thread zm_mansion_special_rounds::function_c79d744e(s_spawn_loc);
      var_69024a6a callback::function_d8abfc3d(#"on_ai_killed", &function_831a12ae);
    }

    wait 0.25;

    while(level.var_20f423f6 > getplayers().size * 4) {
      wait 0.25;
    }
  }

  level flag::clear(#"hash_29b12646045186fa");
  function_cd9e9ab1();
}

function_831a12ae(params) {
  level.var_20f423f6--;
}

function_cd9e9ab1() {
  if(isDefined(30 - getplayers().size * 2)) {
    __s = spawnStruct();
    __s endon(#"timeout");
    __s util::delay_notify(30 - getplayers().size * 2, "timeout");
  }

  function_a918c691();
}

function_a918c691() {
  while(true) {
    if(level.var_20f423f6 < 3) {
      return;
    }

    wait 0.25;
  }
}

wave_3() {
  level endon(#"hash_b240a9137ecc6f9");
  wait 3.5;
  n_players = getplayers().size;

  switch (n_players) {
    case 1:
      n_enemies = 4;
      var_61584de3 = 2;
      break;
    case 2:
      n_enemies = 7;
      var_61584de3 = 2;
      break;
    case 3:
      n_enemies = 9;
      var_61584de3 = 3;
      break;
    case 4:
      n_enemies = 10;
      var_61584de3 = 4;
      break;
  }

  a_s_greenhouse = struct::get_array("greenhouse_lab_spawns");
  a_s_locs = [];

  foreach(s_greenhouse in a_s_greenhouse) {
    if(s_greenhouse.script_noteworthy === "werewolf_location") {
      a_s_locs[a_s_locs.size] = s_greenhouse;
    }
  }

  level flag::set(#"hash_29b12646045186fa");
  level.var_4b9e58af = 0;

  for(i = 0; i < n_enemies; i++) {
    while(level.var_4b9e58af >= var_61584de3) {
      waitframe(1);
    }

    if(getaiteamarray(level.zombie_team).size >= 20) {
      level flag::set(#"hash_29b12646045186fa");
    }

    s_loc = array::random(a_s_locs);
    var_69024a6a = zombie_werewolf_util::function_47a88a0c(1, undefined, 1, s_loc, 20);

    if(isalive(var_69024a6a)) {
      level.var_4b9e58af++;
      var_69024a6a.no_powerups = 1;
      var_69024a6a zm_score::function_acaab828();
      var_69024a6a.script_noteworthy = "angry_werewolf";
      var_69024a6a.var_126d7bef = 1;
      var_69024a6a.ignore_round_spawn_failsafe = 1;
      var_69024a6a.ignore_enemy_count = 1;
      var_69024a6a.b_ignore_cleanup = 1;
      var_69024a6a callback::function_d8abfc3d(#"on_ai_killed", &function_70e83f44);

      if(!(isDefined(level.var_456ece3d) && level.var_456ece3d)) {
        level.var_456ece3d = 1;
        var_69024a6a thread function_d89f5961();
      }

      level flag::clear(#"hash_29b12646045186fa");
    }

    wait 6 - n_players / 2;
  }

  function_acf54a6a();
}

function_d89f5961() {
  level endon(#"end_game", #"intermission", #"hash_3bc655798befa0c6");
  self endon(#"death");
  a_e_players = util::get_active_players();
  a_e_players = array::randomize(a_e_players);

  foreach(e_player in a_e_players) {
    if(isalive(e_player)) {
      e_player zm_vo::function_a2bd5a0c(#"hash_5da859125becfdfa", 0, 1);
      break;
    }
  }

  n_range_sq = 360000;
  var_51dd97e5 = undefined;

  do {
    a_e_players = util::get_active_players();

    foreach(e_player in a_e_players) {
      if(zm_vo::is_player_valid(e_player)) {
        n_dist_sq = distancesquared(e_player.origin, self.origin);

        if(n_dist_sq <= n_range_sq && e_player zm_utility::is_facing(self, 0.75, 1)) {
          var_51dd97e5 = e_player;
          break;
        }
      }
    }

    waitframe(1);
  }
  while(!zm_vo::is_player_valid(var_51dd97e5));

  a_str_vo = [];
  a_str_vo[10] = "vox_werewolf_react_plr_10_0";
  a_str_vo[12] = "vox_werewolf_react_plr_12_4";
  a_str_vo[11] = "vox_werewolf_react_plr_11_2";
  a_str_vo[9] = "vox_werewolf_react_plr_9_0";
  var_e04d003f = var_51dd97e5 zm_characters::function_d35e4c92();
  var_51dd97e5 zm_vo::vo_say(a_str_vo[var_e04d003f], 0, 1, 9999);
}

function_70e83f44(params) {
  level.var_4b9e58af--;
}

function_acf54a6a() {
  while(true) {
    if(level.var_4b9e58af < 1) {
      level flag::set(#"hash_b240a9137ecc6f9");
      return;
    }

    wait 1;
  }
}

function_1be5e603() {
  level flag::wait_till(#"greenhouse_open");
  level flag::clear(#"disable_fast_travel");
  level clientfield::set("fasttravel_exploder", 1);
  exploder::stop_exploder("fxexp_barrier_gameplay_observatory");
  level thread mansion_util::function_f1c106b("loc4", 0);
  mansion_util::function_5904a8e1();
}

function_a7bed514(str_script_noteworthy = "spawn_location") {
  a_spawns = struct::get_array(str_script_noteworthy, "script_noteworthy");

  foreach(s_loc in a_spawns) {
    if(s_loc.targetname !== "greenhouse_lab_spawns") {
      arrayremovevalue(a_spawns, s_loc, 1);
    }
  }

  return array::remove_undefined(a_spawns);
}