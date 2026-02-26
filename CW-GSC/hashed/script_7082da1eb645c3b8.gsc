/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_7082da1eb645c3b8.gsc
***********************************************/

#using script_155b17ff7c8b315c;
#using script_3dc93ca9902a9cda;
#using script_4134e1e2e7684c4c;
#using script_446752c03c555e16;
#using script_57d05cf093ffba5c;
#using script_6cd35fe7afb1f231;
#using script_77d064824b2c820c;
#using script_97b74052c477c23;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp\cp_rus_amerika;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#using scripts\weapons\cp\spy_camera;
#namespace namespace_be0b7a4;

function function_cc475eed(str_objective) {
  namespace_fc3e8cb::function_2987fd4c("s_teleport_woods_elevator", 0, 0);
  level thread namespace_f6d09d1a::function_a677563d();
  level thread namespace_fc3e8cb::function_869f213d();
  level flag::set("flg_elevator_all_enemies_dead");
  level thread namespace_fc3e8cb::elevator_descend(1);
}

function elevator_main(str_objective, var_50cc0d4f) {
  namespace_fc3e8cb::function_44a6fc04(str_objective);

  if(var_50cc0d4f) {
    level thread cp_rus_amerika::function_f6b6f426("terminal");
  }

  level thread function_2023f5();
  level thread function_48a28239();
  level thread namespace_4bd68414::function_da4cb613();
  level thread function_c73d21cc();
  level thread function_fa117b21();
  level thread namespace_fc3e8cb::function_bd7f6a68();
  level thread function_46490d4e();
  doors::function_f35467ac("e_terminal_entrance_door");
  level flag::wait_till("flg_elevator_end");
  cp_rus_amerika::function_cee29c87("terminal");
  skipto::function_4e3ab877(str_objective);
}

function function_987cb73(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  if(player) {
    function_46490d4e(1);
    level flag::set("flg_elevator_end");
    level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_perf_elevator", 1);
    level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_perf_mainstreet_keys_b", 1);
  } else {
    level thread function_1521ed24();
  }

  if(isDefined(level.var_28f2e8d6)) {
    foreach(emitter in level.var_28f2e8d6) {
      if(isarray(emitter)) {
        array::notify_all(emitter, "snd_emitter_stop");
        continue;
      }

      emitter notify(#"snd_emitter_stop");
    }
  }
}

function function_1521ed24() {
  var_4768ddc1 = arraycombine(getaiarray("ai_enemy_elevator_top", "targetname"), getaiarray("ai_enemy_elevator_top_wave_2", "targetname"));

  foreach(ai_guard in var_4768ddc1) {
    level.woods ai::shoot_at_target("kill_within_time", ai_guard, undefined, 0.2);
  }
}

function function_2023f5() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");

  if(level flag::get("flg_elevator_player_interact") == 0) {
    level function_b40a8b3f();
    objectives::complete("obj_elevator_interact");
    level.player playrumbleonentity("anim_med");
  }

  objectives::complete("obj_elevator_goto");
  level thread function_e0f7a16e();
  namespace_b61bbd82::music("8.0_elevator");
  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_perf_elevator", 0);
  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_perf_observation", 1);
  level flag::wait_till("flg_control_tower_elevator_at_top");
  var_d248d2d4 = struct::get("s_obj_elevator_enter_command_center", "targetname");
  objectives::goto("obj_elevator_enter_command_center", var_d248d2d4.origin, #"hash_4a3bd5687b30613a", 0);
  level flag::wait_till("flg_elevator_end");
  objectives::complete("obj_elevator_enter_command_center");
}

function function_e0f7a16e() {
  level.player endon(#"death");
  level.player playrumblelooponentity("cp_rus_kgb_elevator_rumble_loop");
  level flag::wait_till("flg_control_tower_elevator_at_top");
  level.player stoprumble("cp_rus_kgb_elevator_rumble_loop");
  level.player playrumbleonentity("anim_heavy");
  level.player playrumbleonentity("anim_light");
}

function function_b40a8b3f() {
  level endon(#"flg_elevator_player_interact");
  level flag::wait_till("flg_elevator_juggernauts_dead");
  wait 1;
  s_obj_elevator_interact = struct::get("s_obj_elevator_interact", "targetname");
  objectives::goto("obj_elevator_interact", s_obj_elevator_interact.origin, #"hash_233d6343fbeb9550", 0);
  level flag::wait_till("flg_elevator_player_interact");
}

function function_c73d21cc() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  var_d5535d9a = getvehiclearray("control_tower_elevator", "targetname")[0];
  var_6f5ab79e = getnode("nd_woods_elevator_exposed", "targetname");
  var_63d2d7ec = level flag::wait_till_any(["flg_elevator_all_enemies_dead", "flg_elevator_player_interact"]);
  level.woods colors::disable();
  level.woods clearenemy();
  level.woods val::set(#"woods_elevator", "ignoreall", 1);
  level.woods val::set(#"woods_elevator", "ignoreme", 1);
  level.woods ai::set_behavior_attribute("vignette_mode", "fast");
  level.woods battlechatter::function_2ab9360b(0);

  if(var_63d2d7ec._notify === # "flg_elevator_all_enemies_dead") {
    level thread namespace_4bd68414::function_ffca973f();
    level thread function_204f03cb();
    level flag::wait_till("flg_elevator_player_interact");
    level scene::stop("scene_amk_5050_woods_elevator");
    level.woods lookatentity();
  }

  level.woods forceteleport(var_6f5ab79e.origin + (0, 0, 5), var_6f5ab79e.angles);
  waitframe(1);
  level.woods linkto(var_d5535d9a);
  level flag::set("flg_control_tower_woods_on_elevator");
  s_elevator_woods_poi = struct::get("s_elevator_woods_poi", "targetname");
  level.woods ai::poi_enable(1, s_elevator_woods_poi, 0);
  level thread namespace_4bd68414::function_55a0cc3d();
  level thread scene::play("scene_amk_5050_woods_elevator", "exit");
  level flag::wait_till("flg_control_tower_elevator_near_top");
  level thread namespace_fc3e8cb::function_5c5b6ea7("nd_woods_elevator_cover");
  snd::client_msg("flg_control_tower_elevator_at_top");
  level flag::wait_till("flg_control_tower_elevator_at_top");
  level thread namespace_4bd68414::function_13e6b28c();
  level.woods ai::set_behavior_attribute("demeanor", "combat");
  level.woods battlechatter::function_2ab9360b(1);
  level.woods unlink();
  level.woods val::set(#"woods_elevator", "ignoreall", 0);
  level.woods val::set(#"woods_elevator", "ignoreme", 0);
  level.woods ai::poi_enable(0);
  level namespace_fc3e8cb::function_5c5b6ea7("nd_command_center_woods_start");
  level.woods function_9ae1c50();
  level.woods ai::set_behavior_attribute("vignette_mode", "off");
  level flag::wait_till("flg_terminal_leave_elevator");
  level.woods clearforcedgoal();
  level.woods colors::set_force_color("blue");
  level flag::wait_till("flg_elevator_top_enemies_dead");
  level.woods function_678d90a1(0.001001);
  level.woods colors::disable();
  level.woods ai::set_behavior_attribute("disablelean", 1);
  level.woods ai::set_behavior_attribute("disablepeek", 1);
  level.woods ai::set_behavior_attribute("vignette_mode", "fast");
  level.woods battlechatter::function_2ab9360b(0);
  level scene::play("scene_amk_6010_tml_computer", "room_enter");
  level flag::set("flg_elevator_woods_in_terminal_room");

  if(!level flag::get("flg_terminal_player_in_terminal_room")) {
    level thread scene::play("scene_amk_6010_tml_computer", "room_enter_hold");
  }

  level thread namespace_4bd68414::function_24aa0543();
  level.woods function_94575fdf();
}

function function_204f03cb() {
  level endon(#"flg_elevator_player_interact");
  level scene::play("scene_amk_5050_woods_elevator", "enter");
  level thread scene::play("scene_amk_5050_woods_elevator", "idle");
  level.woods lookatentity(level.player);
  level flag::set("flg_control_tower_woods_on_elevator");
}

function function_fa117b21() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level flag::wait_till("flg_elevator_player_interact");
  println("<dev string:x38>");
  var_78d2e059 = spawner::simple_spawn("ai_enemy_elevator_top", &function_fef9a6fd);
  level thread namespace_fc3e8cb::function_85939627(var_78d2e059, "flg_elevator_top_enemies_one_dead", 1);
  level thread namespace_fc3e8cb::function_940ffdb0("flg_elevator_fallback", var_78d2e059, "vol_elevator_back");
  level flag::wait_till("flg_control_tower_elevator_at_top");
  level flag::wait_till_any_timeout(10, ["flg_terminal_approaching_command_center", "flg_elevator_top_enemies_one_dead"]);
  var_3065736e = spawner::simple_spawn("ai_enemy_elevator_top_wave_2", &function_fef9a6fd);
  level thread namespace_fc3e8cb::function_85939627(var_3065736e, "flg_elevator_top_wave_2_enemies_one_dead", 1);
  level thread function_51c78e84();
  var_720cf56 = arraycombine(var_78d2e059, var_3065736e);
  level thread namespace_fc3e8cb::function_85939627(var_720cf56, "flg_elevator_top_enemies_dead", var_720cf56.size);
  level flag::wait_till_all(["flg_elevator_top_enemies_one_dead", "flg_elevator_top_wave_2_enemies_one_dead"]);
  function_1eaaceab(var_3065736e);

  foreach(ai in var_3065736e) {
    ai.favoriteenemy = level.player;
    ai setgoal(level.player);
  }
}

function function_51c78e84() {
  wait 0.1;
  e_terminal_entrance_door = getent("e_terminal_entrance_door", "targetname");
  e_terminal_entrance_door_clip = getent("e_terminal_entrance_door_clip", "targetname");
  e_terminal_entrance_door_org = getent("e_terminal_entrance_door_org", "targetname");
  e_terminal_entrance_door linkto(e_terminal_entrance_door_org);
  e_terminal_entrance_door_clip linkto(e_terminal_entrance_door_org);
  e_terminal_entrance_door_clip disconnectpaths();
  var_9d14bbbd = (e_terminal_entrance_door_org.angles[0], e_terminal_entrance_door_org.angles[1] - 150, e_terminal_entrance_door_org.angles[2]);
  e_terminal_entrance_door_org rotateto(var_9d14bbbd, 0.5, 0.1, 0.2);
  e_terminal_entrance_door flag::set("door_open");
  snd::client_targetname(e_terminal_entrance_door_org, "evt_ai_open_terminal_door_audio");
}

function function_74ebff30() {
  e_terminal_entrance_door = getent("e_terminal_entrance_door", "targetname");
  e_terminal_entrance_door_clip = getent("e_terminal_entrance_door_clip", "targetname");
  e_terminal_entrance_door_org = getent("e_terminal_entrance_door_org", "targetname");

  if(e_terminal_entrance_door flag::get("door_open") == 1) {
    e_terminal_entrance_door linkto(e_terminal_entrance_door_org);
    e_terminal_entrance_door_clip linkto(e_terminal_entrance_door_org);
    e_terminal_entrance_door_clip disconnectpaths();
    var_cba21548 = (e_terminal_entrance_door_org.angles[0], e_terminal_entrance_door_org.angles[1] + 150, e_terminal_entrance_door_org.angles[2]);
    e_terminal_entrance_door_org rotateto(var_cba21548, 0.5, 0.1, 0.2);
    e_terminal_entrance_door flag::clear("door_open");
  }

  level flag::wait_till("flg_facades_start");
  e_terminal_entrance_door delete();
  e_terminal_entrance_door_org delete();
  e_terminal_entrance_door_clip delete();
}

function function_fef9a6fd() {
  self endon(#"death");
  self.grenadeammo = 0;
  self ai::set_pacifist(1);

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "ai_enemy_elevator_top_booth") {
    level flag::wait_till("flg_control_tower_elevator_at_top");
    self ai::set_pacifist(0);
    self waittill(#"damage");
    level flag::set("flg_elevator_top_enemies_take_damage");
    return;
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "ai_enemy_elevator_terminal") {
    var_e0f6457b = [];
    var_e0f6457b[0] = self;
    level scene::init(#"hash_221910ad2b77a8e3", var_e0f6457b);
    level thread scene::play(#"hash_221910ad2b77a8e3", var_e0f6457b);
    var_facf831 = scene::function_8582657c(#"hash_221910ad2b77a8e3", "enter");
    wait var_facf831 - 1;
    self ai::set_pacifist(0);
    self.goalradius = 32;
    nd_elevator_hallway = getnode("nd_elevator_hallway", "targetname");
    self setgoal(nd_elevator_hallway, 1);
    return;
  }

  level flag::wait_till_any_timeout(10, ["flg_terminal_leave_elevator", "flg_elevator_top_enemies_one_dead"]);
  self ai::set_pacifist(0);
}

function private function_46490d4e(var_e563178a = 0) {
  if(!var_e563178a) {
    level flag::wait_till("flg_terminal_scenes_init");
  }

  level scene::init("scene_amk_6010_tml_server");
  a_scene_ents = [];
  var_7399a89a = doors::get_doors("e_terminal_exit_door_animated", "targetname");

  foreach(door in var_7399a89a) {
    if(door.script_noteworthy === "left_door") {
      a_scene_ents[#"left_door"] = door.c_door.m_e_door;
      continue;
    }

    if(door.script_noteworthy === "right_door") {
      a_scene_ents[#"right_door"] = door.c_door.m_e_door;
    }
  }

  level scene::init("scene_amk_6010_tml_computer", a_scene_ents);
}

function function_48a28239() {
  level flag::wait_till("flg_elevator_player_interact");
  e_elevator_front_clip = getent("e_elevator_front_clip", "targetname");
  e_elevator_front_clip movez(1024, 0.2, 0.05, 0.05);
  level flag::wait_till("flg_control_tower_elevator_at_top");
  e_elevator_front_clip deletedelay();
}

function function_4254583f(str_objective) {
  level flag::set("flg_elevator_woods_in_terminal_room");
  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_perf_observation", 1);
  namespace_fc3e8cb::function_2987fd4c("s_teleport_woods_terminal", 0, 0);
}

function function_da9636d5(str_objective, var_50cc0d4f) {
  namespace_fc3e8cb::function_44a6fc04(var_50cc0d4f);

  level thread function_2f099c26();
  namespace_b61bbd82::music("10.0_hacking");
  clientfield::set("cull_courtyard", 1);
  level.player util::blend_movespeedscale(0.9, 1);
  level thread function_4f772681();
  level thread function_538dfcc4();
  level thread function_fb9fa5af();
  level thread function_37b57088();
  function_b53a12d0();
  level flag::wait_till("flg_terminal_end");
  skipto::function_4e3ab877(var_50cc0d4f);
}

function function_207b0552(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  clientfield::set("cull_courtyard", 1);
  var_5c5d4c59 = getactorteamarray("axis");

  foreach(var_78198c24 in var_5c5d4c59) {
    if(var_78198c24.allowdeath !== 0) {
      var_78198c24 delete();
      continue;
    }

    var_78198c24 val::set(#"hash_179d084bd3674a52", "allowdeath", 1);
    var_78198c24 delete();
  }

  if(player == 1) {
    level flag::set("flg_terminal_end");
    level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_motorpool_closed_state", 1, "flg_motor_pool_giant_doors_closed");
    level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_motorpool_open_state", 1, "flg_motor_pool_giant_doors_closed");
    doors::function_f35467ac("e_terminal_exit_door_animated", "targetname");
  }
}

function function_2f099c26() {
  s_obj_computer_terminal = struct::get("s_obj_computer_terminal", "targetname");
  objectives::goto("obj_terminal_interact", s_obj_computer_terminal.origin, #"hash_27548d1d10470e72", 0);
  level flag::wait_till("flg_terminal_player_exit");
  objectives::complete("obj_terminal_interact");
  var_d248d2d4 = struct::get("s_obj_terminal_exit_command_center", "targetname");
  objectives::goto("obj_elevator_command_center", var_d248d2d4.origin, #"hash_6a71e12841ece51e", 0);
  level flag::wait_till("flg_terminal_end");
  objectives::complete("obj_elevator_command_center");
}

function function_538dfcc4() {
  level flag::wait_till("flg_terminal_player_interact");
  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_perf_elevator", 1);
  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_perf_mainstreet_keys_b", 1);
  level waittill(#"hash_40f87ebb2800cdc6");
  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_terminal_room", 1);
  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_perf_observation", 0);
  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_motorpool_vista", 1);
  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_perf_townsquare_keys", 0);
  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_motorpool_closed_state", 1, "flg_motor_pool_giant_doors_closed");
  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_motorpool_open_state", 1, "flg_motor_pool_giant_doors_closed");
}

function function_fb9fa5af() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level flag::set("flg_terminal_player_in_terminal_room");
  level flag::wait_till("flg_elevator_woods_in_terminal_room");
  level.woods ai::set_behavior_attribute("disablelean", 1);
  level.woods ai::set_behavior_attribute("disablepeek", 1);
  level.woods ai::set_behavior_attribute("vignette_mode", "fast");
  level.woods battlechatter::function_2ab9360b(0);
  level namespace_2977687d::scene_amk_6010_tml_computer();
  level.woods flag::set("flg_terminal_woods_open_door");
  level thread namespace_fc3e8cb::function_5c5b6ea7("nd_observation_woods_start");
  level.woods ai::set_behavior_attribute("demeanor", "combat");
  level.woods ai::set_behavior_attribute("vignette_mode", "off");
  level.woods ai::set_behavior_attribute("disablelean", 0);
  level.woods ai::set_behavior_attribute("disablepeek", 0);
  level.woods ai::function_3a5e9945(1);
  level.woods battlechatter::function_2ab9360b(0);
}

function function_b53a12d0() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  namespace_6f1d35e1::function_b2911127(0);
  wait 0.5;
  namespace_6f1d35e1::function_eea42dd9(#"hash_57b485a113a18d3");
  namespace_6f1d35e1::function_5d2e6f6a(1);
  s_computer_terminal_interact = struct::get("s_computer_terminal_interact", "targetname");
  var_fc55b8bc = util::spawn_model("tag_origin", s_computer_terminal_interact.origin, s_computer_terminal_interact.angles);
  var_fc55b8bc util::create_cursor_hint("tag_origin", (0, 0, 0), #"hash_77965c9740b1082d", 58);
  var_fc55b8bc waittill(#"trigger");
  level thread namespace_fc3e8cb::function_c09299();
  level thread function_180b7f97();
  level flag::set("flg_terminal_player_interact");
  var_fc55b8bc util::delay(0.2, undefined, &util::remove_cursor_hint);
  var_fc55b8bc util::delay(0.3, undefined, &delete);
  level.player val::set(#"computer_terminal", "disable_weapons", 1);
  level.player val::set(#"computer_terminal", "freezecontrols_allowlook", 1);
  wait 0.5;
  level.player val::set("computer_terminal", "show_weapon_hud", 0);
  level.player spy_camera::function_b83af2a9();
  vec_right = anglestoright(s_computer_terminal_interact.angles);
  vec_to_player = vectornormalize(level.player getplayercamerapos() - s_computer_terminal_interact.origin);
  n_dot = vectordot(vec_right, vec_to_player);
  var_a16bf7b3 = n_dot > 0 ? "player_left_enter" : "player_right_enter";
  level scene::play(#"hash_784633e475f51557", var_a16bf7b3);
  level thread scene::play(#"hash_784633e475f51557", "player_loop");

  if(!isDefined(level.var_32fb1de5)) {
    level.var_32fb1de5 = spawn("script_model", s_computer_terminal_interact.origin);
    level.var_32fb1de5.team = "axis";
    level.var_32fb1de5.name = "Computer";
    level thread namespace_4bd68414::function_e85255c2();
  }

  animation::add_notetrack_func("amerika_control_tower::terminal_exit", &function_2d735bd7);
  function_55a75785();
}

function function_180b7f97() {
  wait 1;
  level.player playrumblelooponentity("status_effect_dot");
  wait 1;
  level.player stoprumble("status_effect_dot");
  wait 0.8;
  level.player playrumbleonentity("damage_light");
}

function function_55a75785() {
  level.var_d1b1f86c = dialog_tree::new_tree(undefined, undefined, 1);
  level.var_d1b1f86c dialog_tree::function_6bb91351(1);
  level.var_d1b1f86c dialog_tree::add_option(#"hash_597b79d7afed1a13", undefined, undefined, undefined, 0, "flg_terminal_tapes_trigger", "forever", &function_b864e340);
  level.var_d1b1f86c dialog_tree::add_option(#"hash_78a92d25ee4249e2", undefined, undefined, undefined, 0, "flg_terminal_tapes_trigger", "forever", &function_349b458d);
  level.var_d1b1f86c dialog_tree::add_option(#"hash_21c9f7e87c332a1f", undefined, undefined, undefined, 1, "flg_terminal_tapes_trigger", "forever", &function_ac774391);
  level.var_32087fb9 = dialog_tree::new_tree(undefined, undefined, 1);
  level.var_32087fb9 dialog_tree::add_option(#"hash_841d08607115dbf", undefined, undefined, undefined, 1, undefined, "forever", &function_4eff952);
  level.var_7688ff49 = dialog_tree::new_tree(undefined, undefined, 1);
  level.var_7688ff49 dialog_tree::function_6bb91351(1);
  level.var_7688ff49 dialog_tree::add_option(#"hash_59cbd736387031cd", undefined, undefined, undefined, 1, undefined, "forever", &function_690804b8, 1);
  level.var_7688ff49 dialog_tree::add_option(#"hash_59cbd43638702cb4", undefined, undefined, undefined, 1, undefined, "forever", &function_690804b8, 2);
  level.var_7688ff49 dialog_tree::add_option(#"hash_51070678b1416ec5", undefined, undefined, undefined, 1, undefined, "forever", &function_3def2ceb);
  level.var_1188cc49 = dialog_tree::new_tree(undefined, undefined, 1);
  level.var_1188cc49 dialog_tree::function_6bb91351(1);
  level.var_1188cc49 dialog_tree::add_option(#"hash_12aba2b48db7771", undefined, undefined, undefined, 1, undefined, "forever", &function_21b97d8e);
  function_eedcd240();
}

function function_eedcd240() {
  wait 1;
  snd::play([0.2, "evt_computer_welcome", 0]);
  namespace_6f1d35e1::function_5d2e6f6a(2);
  wait 1;
  namespace_6f1d35e1::function_5d2e6f6a(3);
  wait 1;
  level.var_d1b1f86c thread dialog_tree::run(undefined, undefined, undefined, undefined, 1);
}

function function_2d735bd7(params) {
  level thread function_fe94d9f8();
  scene::play(#"hash_784633e475f51557", "player_exit");
  level.player val::reset_all(#"computer_terminal");
  level.player spy_camera::function_6de171e9();
  savegame::checkpoint_save(1);
  level flag::set("flg_terminal_player_exit");
}

function function_fe94d9f8() {
  wait 1;
  level.player playrumblelooponentity("damage_light");
  wait 1;
  level.player stoprumble("damage_light");
}

function function_37b57088() {
  doors::function_f35467ac("e_terminal_exit_door_animated");
  level flag::wait_till("flg_terminal_player_interact");
  level thread function_74ebff30();
  level flag::wait_till("flg_observation_on_catwalk");
}

function function_b864e340() {
  wait 0.5;
  snd::play([0, "evt_computer_tactical", 0]);
  namespace_6f1d35e1::function_5d2e6f6a(5);
  level namespace_4bd68414::function_51448d9f();
  wait 1;
  snd::play([0.25, "evt_computer_menu_return", 0]);
  namespace_6f1d35e1::function_5d2e6f6a(3);
  wait 0.5;
}

function function_349b458d() {
  wait 0.5;
  snd::play([0, "evt_computer_kgb", 0]);
  namespace_6f1d35e1::function_5d2e6f6a(4);
  level namespace_4bd68414::function_892d5a11();
  wait 1;
  snd::play([0.25, "evt_computer_menu_return", 0]);
  namespace_6f1d35e1::function_5d2e6f6a(11);
  wait 0.5;
}

function function_21b97d8e() {
  level.player notify(#"hash_609f4e8c28b6821");
  snd::client_msg("audio_stop_terminal_computer_duck");
  wait 0.5;
  snd::play([0, "evt_computer_audio_log_back", 0]);
  namespace_6f1d35e1::function_5d2e6f6a(3);

  if(level flag::get("flg_greenlight_intel_found")) {
    level namespace_4bd68414::function_7959f57d();
    namespace_6f1d35e1::function_5d2e6f6a(13);
    level.var_7688ff49 thread dialog_tree::run(undefined, undefined, undefined, undefined, 1);
    return;
  }

  level.var_d1b1f86c thread dialog_tree::run(undefined, undefined, undefined, undefined, 1);
}

function function_ac774391() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  namespace_6f1d35e1::function_5d2e6f6a(6);
  level thread namespace_4bd68414::function_e79f4ae2();
  wait 1.75;
  snd::play([0, "evt_computer_error", 0]);
  namespace_6f1d35e1::function_5d2e6f6a(7);
  level flag::set(#"hash_10227bcd8df77658");
  level.woods flag::wait_till(#"hash_584b304e1b5d8810");
  level.var_32087fb9 thread dialog_tree::run(undefined, undefined, undefined, undefined, 1);
  wait 3;
  level thread function_310fcb9();
  snd::play([0, "evt_use_computer_line_keystroke", 0]);
}

function function_310fcb9() {
  level.player endon(#"terminal_hint_sticky_note", #"terminal_hint_postcard", #"terminal_hint_poster");

  while(true) {
    wait 15;
    level.player util::show_hint_text(#"hash_51547940bf27c3cf", undefined, [#"terminal_hint_sticky_note", #"terminal_hint_postcard", #"terminal_hint_poster"], 3);
    wait 6;
  }
}

function function_4eff952() {
  snd::play([0, "evt_use_computer_line_keystroke", 0]);
  level namespace_4bd68414::function_692fbedf();
  wait 1;
  level thread function_6168629();
}

function function_6168629() {
  level function_ea2e6360();
  snd::play("evt_terminal_ui_access_granted", (6278, 4476, 304));
  wait 0.25;
  snd::play([0, "evt_computer_unlocked_01", 0]);
  namespace_6f1d35e1::function_5d2e6f6a(8);
  wait 2;
  namespace_6f1d35e1::function_5d2e6f6a(10);
  wait 3;
  snd::play([0, "evt_computer_unlocked_02", 0]);
  namespace_6f1d35e1::function_5d2e6f6a(14);
  wait 3;
  snd::play([0, "evt_computer_menu_greenlight", 0]);
  namespace_6f1d35e1::function_5d2e6f6a(12);
  namespace_6f1d35e1::function_93dd719c(#"hash_688367698c99efb0");
  level flag::set("flg_greenlight_intel_found");
  level.var_7688ff49 thread dialog_tree::run(undefined, undefined, undefined, undefined, 1);
}

function function_690804b8(var_237f80b0) {
  switch (var_237f80b0) {
    case 1:
      level thread namespace_4bd68414::function_f0072474();
      snd::play([0.25, "evt_computer_audio_log_01", 0]);
      namespace_6f1d35e1::function_5d2e6f6a(15);
      break;
    case 2:
      level thread namespace_4bd68414::function_29b017c5();
      snd::play([0.3, "evt_computer_audio_log_02", 0]);
      namespace_6f1d35e1::function_5d2e6f6a(18);
      break;
    default:

      hms_util::print("<dev string:x56>");

      break;
  }

  wait 0.75;
  level.var_1188cc49 thread dialog_tree::run(undefined, undefined, undefined, undefined, 1);
}

function function_3def2ceb() {
  level flag::set("flg_greenlight_intel_printed");
  snd::play([0.3, "evt_computer_click_greenlight", 0]);
  namespace_6f1d35e1::function_5d2e6f6a(16);
  level waittill(#"hash_40f87ebb2800cdc6");
  level thread function_cd9b75f7();
  namespace_6f1d35e1::function_5d2e6f6a(17);
}

function function_ea2e6360() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");

  switch (randomintrange(1, 3)) {
    case 1:
      var_bdd9eaad = # "terminal_hint_sticky_note";
      break;
    case 2:
      var_bdd9eaad = # "terminal_hint_postcard";
      break;
    case 3:
      var_bdd9eaad = # "terminal_hint_poster";
      break;
    default:

      hms_util::print("<dev string:x56>");

      break;
  }

  var_8c309123[#"note"] = getent("terminal_hint_sticky_note", "targetname");
  var_8c309123[#"note"].offset = (0, 0, 2.5);
  var_8c309123[#"postcard"] = getent("terminal_hint_postcard", "targetname");
  var_8c309123[#"postcard"].offset = (0, 0, 5);
  var_8c309123[#"poster"] = getent("terminal_hint_poster", "targetname");
  var_8c309123[#"poster"].offset = (5, 0, 10);
  var_8c309123[#"note"] util::create_cursor_hint("tag_origin", var_8c309123[#"note"].offset, #"hash_23c6c63a28d6b1bc", 100, undefined, &hint_use, undefined, 100, 31, 0, 0, undefined, &function_add2e8e8);
  var_8c309123[#"postcard"] util::create_cursor_hint("tag_origin", var_8c309123[#"postcard"].offset, #"hash_2d2c88f338114b60", 100, undefined, &hint_use, undefined, 100, 40, 0, 0, undefined, &function_add2e8e8);
  var_8c309123[#"poster"] util::create_cursor_hint("tag_origin", var_8c309123[#"poster"].offset, #"hash_4e1a9c0154d891fd", 200, undefined, &hint_use, undefined, 200, 15, 0, 0, undefined, &function_add2e8e8);
  level thread namespace_4bd68414::function_7b7422db();

  while(true) {
    waitresult = level.player waittill(#"terminal_hint_sticky_note", #"terminal_hint_postcard", #"terminal_hint_poster");

    if(waitresult._notify == var_bdd9eaad) {
      level thread namespace_4bd68414::function_892bda90();
      break;
    }

    level flag::set("flg_terminal_block_password_input");
    wait 0.25;
    snd::play([0.3, "evt_computer_audio_log_back", 0]);
    namespace_6f1d35e1::function_5d2e6f6a(9);
    wait 1.5;
    snd::play([0, "evt_computer_error", 0]);
    namespace_6f1d35e1::function_5d2e6f6a(7);
    level namespace_4bd68414::function_58edca49();
    wait 1;
    level thread namespace_4bd68414::terminal_greenlight_wrong_password_dialogue();
    level flag::clear("flg_terminal_block_password_input");
  }

  level flag::set("flg_terminal_password_cracked");
  level flag::clear("flg_terminal_block_password_input");

  foreach(object in var_8c309123) {
    object util::remove_cursor_hint();
  }
}

function function_add2e8e8(s_info) {
  assert(isDefined(self.offset));
  assert(isDefined(self.var_3e95b88f.prompts[#"use"].var_5e83875a));
  var_e88b5bd1 = util::within_fov(s_info.player getplayercamerapos(), s_info.player getplayerangles(), self.origin + self.offset, cos(self.var_3e95b88f.prompts[#"use"].var_5e83875a));
  var_bc9b323c = level flag::get("flg_terminal_block_password_input");
  return var_e88b5bd1 && !var_bc9b323c;
}

function hint_use(s_info) {
  level.player notify(self.targetname);
}

function function_cd9b75f7() {
  level.player endon(#"death");

  if(!isDefined(level.var_32fb1de5)) {
    s_computer_terminal_interact = struct::get("s_computer_terminal_interact", "targetname");
    level.var_32fb1de5 = spawn("script_model", s_computer_terminal_interact.origin);
    level.var_32fb1de5.team = "axis";
    level.var_32fb1de5.name = "Computer";
  }

  namespace_b61bbd82::music("12.0_breach");
  snd::client_msg("flg_audio_terminal_alarm_start");
  level util::delay(1.5, undefined, &namespace_4bd68414::function_fe1cd4ee);

  while(!level flag::get("flg_terminal_end")) {
    wait 5;
    level thread namespace_4bd68414::function_defae9e0();
  }

  level.var_32fb1de5 deletedelay();
}

function function_4f772681() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  var_229a8637 = 0;
  var_be18fd80 = 0;
  level flag::wait_till_any(["flg_terminal_gun_low_ready", "flg_terminal_end_gundown"]);

  while(!flag::get("flg_terminal_end_gundown")) {
    if(flag::get("flg_terminal_gun_low_ready") && !var_be18fd80) {
      var_be18fd80 = 1;
      level.player util::blend_movespeedscale(0.8, 1);
      level.player val::set(#"hash_6496005f6f13ed07", "show_weapon_hud", 0);
    } else if(!flag::get("flg_terminal_gun_low_ready") && var_be18fd80) {
      var_be18fd80 = 0;
      level.player util::blend_movespeedscale(0.9, 1);
      level.player val::reset(#"hash_6496005f6f13ed07", "show_weapon_hud");
    }

    if(flag::get("flg_terminal_gun_low_ready")) {
      if(level.player getcurrentweapon() == level.var_e3f5eafc && var_229a8637) {
        level.player util::function_749362d7(0);
        var_229a8637 = 0;
      } else if(level.player getcurrentweapon() != level.var_e3f5eafc && !var_229a8637) {
        level.player util::function_749362d7(1, #"hash_79d8239db87989b0");
        var_229a8637 = 1;
      }
    } else if(!flag::get("flg_terminal_gun_low_ready") && var_229a8637) {
      var_229a8637 = 0;
      level.player util::function_749362d7(0);
    }

    wait 0.25;
  }

  level function_458ecc56();
}

function private function_458ecc56() {
  level.player util::function_749362d7(0);
  level.player util::blend_movespeedscale_default(1);
  level.player val::reset(#"hash_6496005f6f13ed07", "show_weapon_hud");
  var_2ad20c99 = getent("t_terminal_gun_low_ready_volume", "targetname");
  var_2ad20c99 delete();
}

function function_170cfeb3(str_objective) {
  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_motorpool_vista", 1);
  namespace_fc3e8cb::function_2987fd4c("s_teleport_woods_observation", 0, 0);
  level thread function_cd9b75f7();
}

function function_7ff0a4d3(str_objective, var_50cc0d4f) {
  namespace_fc3e8cb::function_44a6fc04(str_objective);

  if(!var_50cc0d4f) {
    savegame::function_7790f03();
  }

  level thread function_31224772();
  namespace_b61bbd82::music("12.1_exit");
  level.player util::blend_movespeedscale(0.9, 1);
  level thread function_3005c939();
  level thread namespace_4c1dd357::function_725c2118();
  level thread function_401d9737();
  level thread function_983decfe();
  level thread function_9df17fc0();
  level.vh_town_square_apc = hms_util::function_a3bb1e9c("vh_town_square_apc", "suspend", 0);
  level.vh_town_square_apc thread hms_util::function_7b8ccc06();
  level.vh_town_square_apc thread hms_util::function_ca8302de();
  nd_vh_town_square_apc_observation_start = getvehiclenode("nd_vh_town_square_apc_observation_start", "targetname");
  level.vh_town_square_apc thread vehicle::get_on_and_go_path(nd_vh_town_square_apc_observation_start);
  level thread function_bea61ad6();
  level flag::wait_till("flg_observation_end");
  skipto::function_4e3ab877(str_objective);
}

function function_9df17fc0() {
  trig = getent("roof_tops_stream_encounter_district", "targetname");
  var_a54540e7 = getent("roof_tops_stop_stream_encounter_district", "targetname");

  if(isDefined(trig)) {
    trig waittill(#"trigger");
    clientfield::set("rooftop_02_interior", 1);
    var_a54540e7 waittill(#"trigger");
    clientfield::set("rooftop_02_interior", 2);
  }
}

function function_123e9b38(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  if(player == 0) {
    level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_motorpool_vista", 0);
    level flag::set("flg_terminal_end_gundown");
  }

  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_perf_observation", 1);
  level thread namespace_f6d09d1a::function_811985a1();
}

function function_31224772() {
  objectives::follow("obj_observation_follow_woods", level.woods, #"hash_6783da2c53b544a4", 0);
}

function function_3005c939() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level thread scene::init("sc_observation_woods_stairs");
  level thread namespace_4bd68414::function_1a1db78c();
  level.woods val::set(#"hash_7f4af3d9057acdb8", "ignoreme", 1);
  level.woods val::set(#"hash_7f4af3d9057acdb8", "ignoreall", 1);
  level.woods ai::set_behavior_attribute("vignette_mode", "fast");
  level.woods ai::set_behavior_attribute("disablepeek", 1);
  level.woods ai::set_behavior_attribute("disablelean", 1);
  level.woods battlechatter::function_2ab9360b(0);
  level thread namespace_fc3e8cb::function_5c5b6ea7("nd_observation_woods_approaching_catwalk");
  level flag::wait_till("flg_terminal_end");
  level namespace_fc3e8cb::function_92dea087("flg_observation_approaching_window", "flg_terminal_end");
  level.woods notify(#"amk_woods_new_goal");
  level.woods clearforcedgoal();
  level scene::play("sc_observation_woods_stairs", "enter", [level.woods]);
  level thread scene::play("sc_observation_woods_stairs", "loop", [level.woods]);
  level namespace_fc3e8cb::function_92dea087("flg_observation_approaching_stairs", "flg_observation_on_catwalk");
  level scene::play("sc_observation_woods_stairs", "exit", [level.woods]);
  level flag::set("flg_observation_woods_end_stairs");

  if(level flag::get("flg_observation_end") == 0) {
    level thread namespace_fc3e8cb::function_5c5b6ea7("nd_observation_woods_on_stairs");
  }

  level flag::wait_till("flg_observation_end");
  level.woods val::set(#"hash_7f4af3d9057acdb8", "ignoreme", 0);
}

function function_bea61ad6() {
  level flag::wait_till("flg_observation_approaching_window");

  while(level flag::get("flg_observation_approaching_catwalk") == 0) {
    if(isDefined(level.vh_town_square_apc)) {
      var_e88b5bd1 = util::within_fov(level.player getplayercamerapos(), level.player getplayerangles(), level.vh_town_square_apc.origin, 0.707107);

      if(var_e88b5bd1 == 1) {
        break;
      }
    }

    wait 0.1;
  }

  level flag::set("flg_observation_apc_los");
}

function function_401d9737() {
  level thread namespace_fc3e8cb::function_1c62d05e("ai_enemy_observation_far_drone", "flg_facades_start", 1, 4, 6, 0, "flg_observation_spawn_snipers");
  level flag::wait_till("flg_observation_approaching_stairs");
  level thread namespace_fc3e8cb::function_1c62d05e("ai_enemy_observation_near_drone", "flg_facades_start", 1, 1, 2, 0, "flg_observation_spawn_snipers");
}

function function_983decfe() {
  level endon(#"flg_facades_start");
  level flag::wait_till("flg_observation_spawn_snipers");
  var_15b931de = spawner::simple_spawn("ai_enemy_observation_sniper", &function_550b8a92);
  level thread namespace_fc3e8cb::function_18e5080e("flg_helipad_end", var_15b931de);
}

function function_550b8a92() {
  self getenemyinfo(level.player);
  self.grenadeammo = 0;
}