/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1ba01e8491ed7a4c.gsc
***********************************************/

#using script_1b9f100b85b7e21d;
#using script_290b454abd681dd4;
#using script_2d443451ce681a;
#using script_37f9ff47f340fbe8;
#using script_3dc93ca9902a9cda;
#using script_7409560e3a0c9884;
#using script_eb1a9e047313195;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\easing;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\perks;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\teleport_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp\cp_sidemission_tundra;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\player_decision;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;
#using scripts\weapons\cp\spy_camera;
#namespace namespace_da32b76a;

function function_c17355e(var_d3440450) {
  level flag::set("tundra_intro_done");
  level flag::set("player_is_rappelling");
  level flag::set("player_rappel_done");
  level battlechatter::function_2ab9360b(1);
  level thread namespace_ba979a10::setup_allies();
  level thread namespace_ba979a10::function_cb6a2e9b();
  level thread namespace_ba979a10::function_ee211e0d();
  level thread namespace_ba979a10::function_d6af6077();
}

function function_baff9422(var_d3440450, var_50cc0d4f) {
  thread function_896664a1();
  wait 1;
  skipto::function_4e3ab877("dev_vip_active");
}

function function_896664a1() {
  wait 5;
  flag::set("flag_obj_2_search_clear_1");
  flag::set("flag_obj_2_search_clear_2");
  flag::set("flag_obj_3_search_clear_1");
  flag::set("flag_obj_3_search_clear_2");
  wait 0.5;
  level flag::set("flag_obj_1_search_clear_1");
  level flag::set("flag_obj_1_search_clear_2");
  level flag::set("flag_obj_1_search_clear_3");
  level flag::set("flag_obj_1_search_clear_4");
  level flag::set("flag_rudnik_truck_mp_1_spawn");
  level flag::set("flag_rudnik_truck_stop");
  level flag::set("player_rappel_done");
  level flag::set("dev_view_arms_hack");
}

function function_bf8d2448(var_d3440450, var_50cc0d4f) {
  level thread function_89e4fd54();
  level thread function_81f64302();
  level thread function_335d39d4();
  level thread function_8a11a2c7();
  level thread function_86097daf();
  level thread function_6ae9bdde();
  level thread function_40c20c88();
  level thread function_95c14263();
  level thread function_dd9d2a4a();
  level thread function_63049e20();
  level thread function_4acbe62d();
  level thread function_bee56462("flag_spawn_fuel_depot_enemies", "flag_spawn_motor_pool_enemies", "motor_pool_ext_enemies");
  level thread function_bee56462("flag_spawn_motor_pool_enemies", "flag_spawn_fuel_depot_enemies", "fuel_depot_ext_enemies");
  level thread doors::unlock("tundra_final_door");
  level battlechatter::function_2ab9360b(1);
  level.woods battlechatter::function_2ab9360b(0);
  level.woods ai::set_behavior_attribute("demeanor", "combat");
  level.player val::set("intro", "ignoreme", 0);
  level thread namespace_ba979a10::function_14f72bec();
  level thread namespace_ba979a10::function_7fe34c6e();
  level flag::wait_till("player_rappel_done");
  level.woods thread namespace_ba979a10::function_c70f5d3();
  level flag::wait_till("flag_rudnik_truck_drive");
  savegame::checkpoint_save();
  level flag::wait_till("flag_tundra_vip_kill_confirmed");
  level flag::set("flag_spawn_fuel_depot_enemies");
  level flag::set("flag_spawn_motor_pool_enemies");
  skipto::function_4e3ab877("tundra_combat");
  level namespace_ba979a10::function_d6b495cf();
  level thread namespace_ba979a10::function_abde7b6d();
}

function function_89e4fd54() {
  spawner = getent("rudnik", "targetname");
  spawner spawner::add_spawn_function(&namespace_ba979a10::function_78a1b9ef);
  spawner::add_spawn_function_group("motor_pool_enemies", "script_noteworthy", &function_11c72468);
  spawner::add_spawn_function_group("rooftop_enemies", "script_noteworthy", &function_6a87063a);
}

function init_flags() {}

function cleanup(name, starting, direct, player) {}

function function_86097daf() {
  level endon(#"hash_146b46855a0f35b8");
  flag::wait_till("flag_spawn_motor_pool_enemies");
  var_c5c80463 = spawner::simple_spawn("tundra_motor_pool_int_enemies", &function_eb42d547);
  flag::wait_till("search_objective_1_cleared");

  if(!flag::get("flag_rudnik_truck_drive")) {
    var_23d3924a = spawner::simple_spawn("tundra_radar_roof_enemies_01");
  }
}

function function_6ae9bdde() {
  level endon(#"hash_146b46855a0f35b8");
  flag::wait_till("flag_spawn_radar_enemies");
  var_85e8ce7 = spawner::simple_spawn("tundra_radar_int_enemies", &function_eb42d547);
}

function function_40c20c88() {
  level endon(#"hash_146b46855a0f35b8");
  flag::wait_till("flag_spawn_fuel_depot_enemies");
  var_ce5c48e8 = spawner::simple_spawn("tundra_fuel_depot_int_enemies", &function_eb42d547);
  flag::wait_till("search_objective_3_cleared");

  if(!flag::get("flag_rudnik_truck_drive")) {
    var_23d3924a = spawner::simple_spawn("tundra_radar_roof_enemies_02");
  }
}

function function_6a87063a() {
  self val::set("rooftop_enemies", "ignoreme", 1);
}

function function_8a11a2c7() {
  level thread function_3d8085b3();
  level thread function_85f13965();
  level flag::wait_till("flag_start_final_building");
  level.woods dialogue::radio("vox_cp_rcir_01200_wood_theresthatbasta_59");
  level.woods dialogue::radio("vox_cp_rcir_01200_wood_rudniksheadingo_76");
  level flag::wait_till("tundra_vip_enemy_spawned");
  level flag::wait_till("flag_tundra_vip_killed");
  level.player dialogue::queue("vox_cp_rcir_01200_masn_targeteliminate_d1");
  wait 0.5;
  dialogue::radio("vox_cp_rcir_01200_cmnd_weneedkillconfi_9b");
  level flag::wait_till("flag_tundra_vip_kill_confirmed");
  waitframe(1);
  level dialogue::function_9e580f95();
  wait 0.5;
  level.player dialogue::queue("vox_cp_rcir_01200_masn_killconfirmedwe_e4");
  level.woods dialogue::radio("vox_cp_rcir_01200_wood_iwantacopyformy_fe");
  dialogue::radio("vox_cp_rcir_01300_cmnd_niceworkevaccho_43");
  level flag::set("flag_picture_vo_finished");
  level flag::clear("woods_pause_overwatch");
}

function function_3d8085b3() {
  level thread function_f38469ca();
  clear_flags = ["search_objective_1_cleared", "search_objective_2_cleared", "search_objective_3_cleared"];
  cleared = level flag::wait_till_any(clear_flags);
  arrayremovevalue(clear_flags, cleared._notify);
  level.player dialogue::queue("vox_cp_rcir_01200_masn_buildingclear_76");
  level.player dialogue::queue("vox_cp_rcir_01200_masn_rudnikisnthere_2b");
  wait 1;
  dialogue::radio("vox_cp_rcir_01200_wood_rudniksnotinher_cb");
  level flag::set("buiding_1_cleared");
  cleared = level flag::wait_till_any(clear_flags);
  arrayremovevalue(clear_flags, cleared._notify);
  var_ebe5de4 = getsubstr(clear_flags[0], 17, 18);
  var_ebe5de4 = int(var_ebe5de4);

  if(!flag::get("flag_rudnik_truck_drive")) {
    level.player dialogue::queue("vox_cp_rcir_01200_masn_clear_08");
    wait 1;
    dialogue::radio("vox_cp_rcir_01200_wood_letsgetovertoth_a3");
  }

  level flag::set("buiding_2_cleared");
}

function function_f38469ca() {
  level endon(#"flag_rudnik_truck_drive");
  wait 360;
  i = 0;
  nags = [];
  speaker = [];
  nags[nags.size] = "vox_cp_rcir_01200_wood_keepmovingthrou_ea";
  speaker[speaker.size] = level.woods;
  nags[nags.size] = "vox_cp_rcir_01200_wood_keepsearching_87";
  speaker[speaker.size] = level.woods;
  nags[nags.size] = "vox_cp_rcir_01200_wood_keepsearching_87";
  speaker[speaker.size] = level.woods;

  while(!level flag::get("buiding_1_cleared") && true) {
    speaker[i] dialogue::radio("" + nags[i]);
    i++;

    if(i >= nags.size) {
      i = 0;
    }

    wait 30;
  }

  level flag::wait_till("search_objective_2_cleared");

  if(!level flag::get("buiding_2_cleared") && true) {
    dialogue::radio("vox_cp_rcir_01200_wood_youfindthatfuck_20");
  }
}

function function_85f13965() {
  level endon(#"flag_tundra_vip_kill_confirmed");
  level flag::wait_till("flag_tundra_vip_killed");
  wait 10;
  nags = [];
  speaker = [];
  nags[nags.size] = "vox_cp_rcir_01200_wood_weneedaphotoofr_90";
  speaker[speaker.size] = level.woods;
  nags[nags.size] = "vox_cp_rcir_01200_wood_useyourcamerama_8a";
  speaker[speaker.size] = level.woods;
  nags[nags.size] = "vox_cp_rcir_01200_wood_jesusmasontaket_b0";
  speaker[speaker.size] = level.woods;
  nags[nags.size] = "vox_cp_rcir_01200_wood_werenotonvacati_09";
  speaker[speaker.size] = level.woods;
  wait 15;
  i = 0;

  while(!level flag::get("flag_tundra_vip_kill_confirmed")) {
    speaker[i] dialogue::radio("" + nags[i]);
    i++;

    if(i >= nags.size) {
      i = 0;
    }

    wait 15;
  }
}

function function_11c72468() {}

function function_eb42d547() {
  self endon(#"death");

  while(true) {
    if(isalive(self) && isalive(level.player)) {
      self getperfectinfo(level.player);
    }

    wait 0.5;
  }
}

function function_335d39d4() {
  level.woods waittill(#"damage", #"bulletwhizby");
  level.woods val::set("intro", "ignoreall", 0);
}

function function_63049e20() {
  level thread tundra_outbuilding1_enemies();
  level thread tundra_outbuilding2_enemies();
}

function tundra_outbuilding1_enemies() {
  level endon(#"flag_start_final_building");
  level flag::wait_till("flag_spawn_outbuilding_1");
  var_f248f249 = spawner::simple_spawn("tundra_outbuilding1_enemies", &function_11c72468);
}

function tundra_outbuilding2_enemies() {
  level endon(#"flag_start_final_building");
  level flag::wait_till("flag_spawn_outbuilding_2");
  var_e88dded3 = spawner::simple_spawn("tundra_outbuilding2_enemies", &function_11c72468);
}

function function_dd9d2a4a() {
  level thread function_9c60849e("flag_combat_vehicle_1", "tundra_combat_veh1", "tundra_combat_veh1_riders");
  level thread function_9c60849e("flag_combat_vehicle_2", "tundra_combat_veh2", "tundra_combat_veh2_riders");
  level thread function_9c60849e("flag_bunker_vehicle_1", "tundra_final_bunker_veh1", "tundra_bunker_veh1_riders");
  level thread function_9c60849e("flag_bunker_vehicle_2", "tundra_final_bunker_veh2", "tundra_bunker_veh2_riders");
  level thread function_9c60849e("flag_bunker_vehicle_3", "tundra_final_bunker_veh3", "tundra_bunker_veh3_riders");
  level thread function_9c60849e("flag_bunker_vehicle_4", "tundra_final_bunker_veh4", "tundra_bunker_veh4_riders");
}

function function_9c60849e(var_28c216f0, vehicle, riders) {
  level flag::wait_till(vehicle);
  e_vehicle = vehicle::simple_spawn_single_and_drive(riders);
  e_vehicle.health = 3000;
  snd::client_targetname(e_vehicle, "ai_truck");
  wait 1;
  arrayremovevalue(e_vehicle.var_761c973.riders, undefined, 1);
  array::thread_all(e_vehicle.var_761c973.riders, &function_7f2c92f5);
}

function function_7f2c92f5() {
  self endon(#"death");
  self waittill(#"exited_vehicle");
  self setgoal(self.origin, 0, 64, 128);
  self val::set("guy_truck", "ignoreall", 1);

  while(self isplayinganimscripted()) {
    waitframe(1);
  }

  waitframe(2);

  if(isalive(self) && isalive(level.player)) {
    self val::set("guy_truck", "ignoreall", 0);
    self setgoal(level.player, undefined, 1024);
    self ai::function_54115a91(level.player);
  }
}

function function_95c14263() {
  level thread function_762a3f7d();
  level thread function_c82d4e91();
  level flag::wait_till("flag_spawn_fb_enemies_lower");
  var_cfed5da = spawner::simple_spawn("tundra_final_building_int_enemies");
}

function function_c82d4e91() {
  level flag::wait_till("flag_move_fb_enemies_final_vol");
  enemies = spawner::get_ai_group_ai("final_building_enemies");

  foreach(guy in enemies) {
    if(isDefined(guy) && isalive(guy)) {
      vol = getent("final_bunker_int_combat_vol", "targetname");
      guy setgoal(vol, 1);
    }
  }
}

function function_762a3f7d() {
  level flag::wait_till("flag_spawn_enemy_vip");
  level.vip = spawner::simple_spawn_single("rudnik", &namespace_ba979a10::function_29513390);
  level.vip.health = 999;
  level.vip.grenadeammo = 0;
  level.vip.a.nodeath = 1;
  level.vip.skipdeath = 1;
  level.vip.skipdeathanim = 1;
  level.vip.noragdoll = 1;
}

function function_4acbe62d() {
  level flag::wait_till("flag_rudnik_truck_stop");
  var_8433129 = struct::get("use_org_door_breach", "targetname");
  var_8433129 util::create_cursor_hint(undefined, undefined, #"hash_1ee1b0708e5db4a2");
  var_8433129 prompts::set_objective("bunker_breach");
  var_8433129 waittill(#"trigger");
  level thread objectives::complete("bunker_breach");
  level flag::set("door_breached");
  level thread namespace_ba979a10::function_d6b495cf(1048576, 0);
  level thread namespace_ae270045::function_5e3101b2();
  level.player util::delay(0.7, undefined, &playrumbleonentity, #"damage_heavy");
  level flag::set("flag_spawn_enemy_vip");
  level thread namespace_c1cfab6c::breach();
  level thread scene::play("scene_sm_tundra_door_breach", [level.player]);
  level util::delay(1, undefined, &function_7e35860f);
  level util::delay(0.9, undefined, &function_c85c94ca);
  wait 1.1;
  var_78b3d4a1 = 0.3;
  var_b89fe77a = 1;
  var_af6c8808 = 0.3;
  var_970d5e06 = 2.5;
  level.player setmovespeedscale(var_78b3d4a1);
  setslowmotion(var_b89fe77a, var_78b3d4a1, var_af6c8808);
  level flag::set("flag_rudnik_run");
  level flag::wait_till_timeout(var_970d5e06, "flag_tundra_vip_killed");
  level.player val::reset_all(#"hash_29302a13c9b142f3");
  setslowmotion(var_78b3d4a1, var_b89fe77a, var_af6c8808);
  level.player setmovespeedscale(var_b89fe77a);
}

function function_8a5a9aa2() {
  level flag::wait_till("flag_rudnik_truck_stop");
  var_8433129 = struct::get("use_org_door_breach", "targetname");
  var_8433129 util::create_cursor_hint(undefined, undefined, #"hash_1ee1b0708e5db4a2");
  var_8433129 prompts::set_objective("bunker_breach");
  var_8433129 waittill(#"trigger");
  level thread objectives::complete("bunker_breach");
  level flag::set("door_breached");
  level thread namespace_ae270045::function_5e3101b2();
  level.player util::delay(0.7, undefined, &playrumbleonentity, #"damage_heavy");
  level flag::set("flag_spawn_enemy_vip");
  level thread namespace_c1cfab6c::breach();
  level.player val::set(#"hash_29302a13c9b142f3", "disable_weapons", 1);
  fake_player = util::spawn_player_clone(level.player);
  fake_player.targetname = "BreachFakePlayer";
  level.player playerlinktoabsolute(fake_player, "tag_player");
  level.player ghost();
  fake_player detach("c_t9_pl_mason_head1_infil_stealth_viewmodel");
  fake_player detach("c_t9_cp_yam_hero_masonwinter_torso");
  level thread scene::play("scene_sm_tundra_door_breach", [fake_player]);
  level util::delay(1, undefined, &function_7e35860f);
  level util::delay(0.9, undefined, &function_c85c94ca);
  wait 1.7;
  level.player val::reset(#"hash_29302a13c9b142f3", "disable_weapons");
  level.player playerlinktodelta(fake_player, "tag_player", 1, 30, 30, 15, 15);
  level.player show();
  var_78b3d4a1 = 0.3;
  var_b89fe77a = 1;
  var_af6c8808 = 0.3;
  var_970d5e06 = 3;
  level.player setmovespeedscale(var_78b3d4a1);
  setslowmotion(var_b89fe77a, var_78b3d4a1, var_af6c8808);
  level flag::set("flag_rudnik_run");
  var_e382c85e = 0.5;
  level.player util::delay(var_e382c85e, undefined, &unlink);
  fake_player util::delay(var_e382c85e, undefined, &ghost);
  level waittilltimeout(var_970d5e06, #"flag_tundra_vip_killed");
  level.player val::reset_all(#"hash_29302a13c9b142f3");
  setslowmotion(var_78b3d4a1, var_b89fe77a, var_af6c8808);
  level.player setmovespeedscale(var_b89fe77a);
}

function function_7e35860f() {
  var_f2309115 = spawner::simple_spawn_single("react_enemy");
  var_f2309115.health = 1;
  waitframe(1);
  scene::play("scene_sm_tundra_breach_exposed_turn_around", [var_f2309115]);

  if(isDefined(var_f2309115) && isalive(var_f2309115) && isDefined(level.player) && isalive(level.player)) {
    var_f2309115 setgoal(level.player, 1);
  }
}

function function_c85c94ca() {
  level thread scene::play("scene_sm_tundra_breach_table_flip", [level.vip]);
  level thread function_2f4f8bce();
  level.vip waittill(#"damage");
  level scene::stop("scene_sm_tundra_breach_table_flip");
  level.player playhitmarker(undefined, 5, undefined, 1);

  if(flag::get("rudnik_no_hit_loc") || flag::get("rudnik_head_shot_loc")) {
    level thread scene::play("scene_sm_tundra_rudnik_death", "head", [level.vip]);
  } else {
    level thread scene::play("scene_sm_tundra_rudnik_death", "torso", [level.vip]);
  }

  level.vip waittill(#"death");
  level.vip ai::set_corpse_entity(undefined);
}

function function_2f4f8bce() {
  level waittill(#"hash_32210e7ba4780afb");
  var_a94cb625 = getent("table_flip_pulse_pos", "targetname");
  physicsexplosionsphere(var_a94cb625.origin, 100, 100, 0.15);
}

function function_81f64302() {
  level.player endon(#"death");
  level flag::wait_till("flag_tundra_vip_killed");
  player_decision::function_8c0836dd(0);
  level.var_30eb363 = undefined;
  level.var_85b00b2b = undefined;
  level.player notifyonplayercommand("ability_activated_camera", "+actionslot 4");
  level thread function_38ac2a96();
  level.player spy_camera::function_6de171e9();
  level thread function_3239474f();

  foreach(e_obj in level.var_a4592423) {
    level.player spy_camera::function_f785d9e9(e_obj);
  }

  array::wait_any(level.var_a4592423, "photo_taken");
  level flag::set("flag_tundra_vip_kill_confirmed");
  level flag::set("woods_pause_overwatch");

  foreach(e_obj in level.var_a4592423) {
    level.player spy_camera::function_b28ab5a9(e_obj);
    waitframe(1);
  }

  array::delete_all(level.var_a4592423);
  level.player waittill(#"end_camera_ads");
  level.player spy_camera::function_b83af2a9();
  level flag::set("camera_put_away");
}

function function_38ac2a96() {
  player = getplayers()[0];
  level endon(#"flag_tundra_vip_kill_confirmed");
  player endon(#"death");

  while(true) {
    level flag::clear("cancel_ability_wheel_select_camera_hint");
    level flag::clear("cancel_camera_up_hint");
    level flag::clear("cancel_hint_camera_use");
    player util::show_hint_text(#"hash_62b200bcfa871ac", undefined, undefined, 8);
    player waittill(#"ability_activated_camera");
    level flag::set("cancel_ability_wheel_select_camera_hint");
    wait 0.5;
    player util::show_hint_text(#"hash_65f560d181b08c7", undefined, undefined, 8);
    s_waitresult = player waittill(#"hash_59b80e9e535f9788", #"ability_deactivated_camera");
    level flag::set("cancel_camera_up_hint");
    wait 0.5;

    if(s_waitresult._notify == "ability_deactivated_camera") {
      continue;
    }

    player util::show_hint_text(#"hash_7e88a33f7f3c1d91", undefined, "take_picture", 8);
    s_waitresult = player waittilltimeout(2, #"hash_59b80e9e535f9788", #"hash_5512f0799022267", #"ability_deactivated_camera", #"take_picture");
    level flag::set("cancel_hint_camera_use");
    return;
  }
}

function function_6bfbb3e8() {
  player = getplayers()[0];
  level spy_camera::function_f91a82ef(1, undefined);
  level flag::wait_till("flag_tundra_vip_kill_confirmed");
  player waittill(#"end_camera_ads");
  player thread util::show_hint_text(#"hash_12be6ba1327c64b1", undefined, "hide_camera_unequip_hint", -1);
  player waittill(#"ability_deactivated_camera");
  level flag::set("flag_player_end_camera_ads");
}

function function_3239474f() {
  level endon(#"camera_put_away");
  wait 3;
  nags = [];
  speaker = [];
  nags[nags.size] = "vox_cp_rcir_01200_wood_youneedaclearpi_0f";
  speaker[speaker.size] = level.woods;
  nags[nags.size] = "vox_cp_rcir_01200_wood_getthewholebody_60";
  speaker[speaker.size] = level.woods;
  nags[nags.size] = "vox_cp_rcir_01200_wood_commandneedsacl_30";
  speaker[speaker.size] = level.woods;
  nags[nags.size] = "vox_cp_rcir_01200_wood_yeahok_39";
  speaker[speaker.size] = level.woods;
  i = 0;

  while(!level flag::get("flag_tundra_vip_kill_confirmed")) {
    level.player waittill(#"take_picture");
    waitframe(1);

    if(!level flag::get("flag_tundra_vip_kill_confirmed")) {
      speaker[i] dialogue::radio("" + nags[i]);
      i++;

      if(i >= nags.size) {
        i = 0;
      }

      wait 15;
      continue;
    }

    continue;
  }
}

function function_bee56462(my_flag, var_44a53a25, var_14802c6e) {
  level endon(#"flag_tundra_vip_kill_confirmed", #"search_objective_1_cleared", #"search_objective_3_cleared");

  while(true) {
    level flag::wait_till(my_flag);

    if(level flag::get(var_44a53a25)) {
      guys = spawner::get_ai_group_ai(var_14802c6e);
      guys array::thread_all(guys, &namespace_ba979a10::function_7d2d1987);
      level flag::clear(var_44a53a25);
    }

    level flag::wait_till_clear(my_flag);
  }
}