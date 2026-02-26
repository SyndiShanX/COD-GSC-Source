/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_237e957844a8197c.gsc
***********************************************/

#using script_1b9f100b85b7e21d;
#using script_3dc93ca9902a9cda;
#using script_7728aa611ab72ad9;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#namespace namespace_a789f8ae;

function function_96b44444() {
  level waittill(#"chyron_menu_closed");
  level.player val::set("rev_start", "freezecontrols_allowlook", 1);
  level.player val::set("rev_start", "low_ready", 1);
  level.park sethighdetail(1);
  level thread scene::play("scene_rev_1010_rde_intro", "intro");
  wait 12;
  level.park sethighdetail(0);
  level.player val::reset_all("rev_start");
  level flag::set("flag_intro_scene_ended");
}

function function_716ff5d8(var_57ef78ed) {
  a_enemies = spawner::simple_spawn("2010_enemy");
  a_ents[#"enemy01"] = a_enemies[0];
  a_ents[#"enemy04"] = a_enemies[1];
  a_ents[#"enemy04"].var_c681e4c1 = 1;

  if(var_57ef78ed == "church") {
    level thread scene::init("scene_rev_2010_pla_rendezvous", a_ents);
    var_3bd815c8 = doors::get_doors("church_exit_door")[0];
    var_3bd815c8 doors::waittill_door_opened();
    level.player util::blend_movespeedscale_default(1.5);
    var_3bd815c8 doors::function_f35467ac();
    var_3bd815c8.c_door thread function_fbc17248();
  }

  level scene::play("scene_rev_2010_pla_rendezvous", "Start", a_ents);
  level flag::set("flg_rendezvous_scene_done");
}

function function_fbc17248() {
  if(is_true(self.var_c4c3fa39)) {
    snd::play("evt_church_door_bash_open", self);
    return;
  }

  snd::play("evt_church_door_open", self);
}

function wait_for_death(var_bc2b55eb) {
  self endon(#"death");
  self waittill(var_bc2b55eb + "_die");
  self animation::stop();
  self kill();
}

function function_c68fb2ec() {
  var_13fa77c6 = getent("pillar_rpg_collapse_clip", "targetname");
  wait 2.3;
  level scene::play("p9_fxanim_gp_pillar_rpg_collapse_scene", "play");
  wait 1;

  if(isDefined(var_13fa77c6)) {
    var_13fa77c6 delete();
  }
}

function function_6f16e46d() {
  level thread function_3499a2c7();
}

function function_986b3cba(var_afde181b, var_82527dbb) {
  level endon(#"1st_floor_cctv");

  if(isDefined(level.var_ba0f7a1a) && level.var_ba0f7a1a) {
    level thread scene::play("scene_rev_3010_fir_split_off_breach", "adler_loop");
    level thread scene::play("scene_rev_3010_fir_split_off_breach", "woods_loop");
    level thread scene::play("scene_rev_3010_fir_split_off_breach", "mason_loop");
  } else {
    level thread scene::play("scene_rev_3010_fir_split_off_breach", "adler_start");
    level thread scene::play("scene_rev_3010_fir_split_off_breach", "woods_start");
    level thread scene::play("scene_rev_3010_fir_split_off_breach", "mason_start");
  }

  level waittill(#"hash_6cd798a2f083a39a");

  while(!level flag::get("flg_remove_adlers_team")) {
    wait randomfloatrange(var_afde181b, var_82527dbb);

    if(!level flag::get("flg_remove_adlers_team") && level flag::get("flg_vo_done_play_adler_nag")) {
      level scene::play("scene_rev_3010_fir_split_off_breach", "nag");
      level thread scene::play("scene_rev_3010_fir_split_off_breach", "adler_loop");
    }
  }

  level flag::wait_till("flg_remove_adlers_team");

  if(isDefined(level.woods)) {
    level.woods delete();
  }

  if(isDefined(level.mason)) {
    level.mason delete();
  }

  if(isDefined(level.adler)) {
    level.adler delete();
  }
}

function function_3a0e41ed() {
  a_ents = [];
  level flag::wait_till("play_scene_hands_up");
  a_ents[#"hash_86fe5b596d46e2f"] = spawner::simple_spawn_single(getent("vig_handsup_contra_spawner", "targetname"));
  a_ents[#"hash_5dd01c989f26191b"] = spawner::simple_spawn_single(getent("vig_handsup_civ_spawner", "targetname"));
  a_ents[#"hash_86fe5b596d46e2f"] endon(#"death");
  a_ents[#"hash_5dd01c989f26191b"] endon(#"death");
  level scene::init("scene_vig_0000_amb_execution_wall_handsup", a_ents);

  foreach(guy in a_ents) {
    guy.health = 1;
  }

  a_ents[#"hash_86fe5b596d46e2f"] function_628aec92("scene_vig_0000_amb_execution_wall_handsup");
  a_ents[#"hash_5dd01c989f26191b"] function_628aec92("scene_vig_0000_amb_execution_wall_handsup");
  level scene::play("scene_vig_0000_amb_execution_wall_handsup", "enter", a_ents);
  level scene::play("scene_vig_0000_amb_execution_wall_handsup", "loop", a_ents);
}

function function_d13f90cb() {
  a_ents = [];
  level flag::wait_till("play_scene_civ_ground");
  a_ents[#"hash_86fe5b596d46e2f"] = spawner::simple_spawn_single(getent("vig_struggle_contra_spawner", "targetname"));
  a_ents[#"hash_5dd01c989f26191b"] = spawner::simple_spawn_single(getent("vig_struggle_civ_spawner", "targetname"));
  a_ents[#"hash_86fe5b596d46e2f"] endon(#"death");
  a_ents[#"hash_5dd01c989f26191b"] endon(#"death");
  level scene::init("scene_vig_0000_amb_struggle_ground", a_ents);

  foreach(guy in a_ents) {
    guy.health = 1;
  }

  a_ents[#"hash_86fe5b596d46e2f"] function_628aec92("scene_vig_0000_amb_struggle_ground");
  a_ents[#"hash_5dd01c989f26191b"] function_628aec92("scene_vig_0000_amb_struggle_ground");
  level scene::play("scene_vig_0000_amb_struggle_ground", "enter", a_ents);
  level thread scene::play("scene_vig_0000_amb_struggle_ground", "loop", a_ents);
  wait 5;
  level scene::play("scene_vig_0000_amb_struggle_ground", "exit", a_ents);
}

function function_cca11e21() {
  var_b5ee4ca5 = getEntArray("surrender_scene_enemy_spawner", "targetname");
  var_b98ae473 = getEntArray("surrender_scene_contra_spawner", "targetname");
  a_ents = [];
  level flag::wait_till("play_scene_civ_ground");
  var_3d261bd8 = spawner::simple_spawn(var_b5ee4ca5);
  var_8e714466 = spawner::simple_spawn(var_b98ae473);
  a_ents[#"hash_24f28c860161bc0c"] = var_8e714466[0];
  a_ents[#"hash_24f28f860161c125"] = var_8e714466[1];
  a_ents[#"enemy01"] = var_3d261bd8[0];
  a_ents[#"enemy02"] = var_3d261bd8[1];
  level scene::init("scene_rev_0000_ambient_surrender", a_ents);
  level scene::play("scene_rev_0000_ambient_surrender", "start", a_ents);
}

function function_afa9528d(var_2250555) {
  if(level.var_884e01f1 !== 1) {
    a_ents = [];
    a_ents[#"hash_363ff12eba02d468"] = getent("flip_table", "targetname");

    if(var_2250555) {
      a_ents[#"enemy"] = spawner::simple_spawn_single(getent("vig_right_1_enemy_table_flip_spawner", "targetname"));
    }

    s_scene = struct::get("scene_table_flip");
    s_scene scene::init(a_ents);
    level.var_884e01f1 = 1;
  }
}

function function_3499a2c7() {
  function_afa9528d(1);
  var_4a3daa0b = struct::get("table_flip_look_at_org", "targetname");
  s_scene = struct::get("scene_table_flip");
  ai_enemy = s_scene.scene_ents[#"enemy"];
  ai_enemy endon(#"death");

  while(true) {
    within_fov = util::within_fov(level.player getplayercamerapos(), level.player getplayerangles(), var_4a3daa0b.origin, cos(45));
    var_19433220 = sighttracepassed(level.player getplayercamerapos(), var_4a3daa0b.origin, 0, undefined);
    var_265622ec = distance2d(level.player.origin, var_4a3daa0b.origin);

    if(within_fov == 1 && var_19433220 == 1 || var_265622ec < 200) {
      hms_util::print("<dev string:x38>");

      break;
    }

    waitframe(1);
  }

  level notify(#"hash_20b372100c1d49b2");
  s_scene thread function_b1f33833(ai_enemy);
  ai_enemy ai::set_behavior_attribute("disablearrivals", 1);
  s_scene thread scene::play();
  wait 2.6;
  s_scene scene::stop();
  var_e4bd6323 = getnode("table_flip_node", "targetname");
  ai_enemy ai::set_goal_node(var_e4bd6323);
}

function function_b1f33833(var_541d697) {
  var_541d697 endoncallback(&function_6ea46f39, #"death");
  var_e189955e = self.scene_ents[#"hash_363ff12eba02d468"];
  var_e189955e waittill(#"flip");
  snd::client_msg("audio_table_flip");
  physicsexplosionsphere(var_e189955e.origin + (0, -16, 32), 60, 0, 0.06);
}

function function_6ea46f39(str_notify) {
  s_scene = struct::get("scene_table_flip");
  s_scene scene::stop();
}

function function_5629159e() {
  level endon(#"game_ended", #"death");

  while(!isDefined(level.var_7ddb94fb)) {
    level.var_7ddb94fb = getent("mine_intro", "script_noteworthy");
    waitframe(1);
  }

  level.var_7ddb94fb setCanDamage(0);
}

function function_ccfa368() {
  level endon(#"game_ended", #"death");
  level thread function_5629159e();
  flag::wait_till("flg_right_courtyard_initial_spawn");
  level.var_dc8e763c = spawner::simple_spawn_single("fleeing_civ_mine_intro");
  a_actors[#"actor 1"] = level.var_dc8e763c;
  level thread scene::play("scene_rev_2020_fir_landmine_death", "init", a_actors);
  level flag::wait_till("flg_obj_courtyard_update");

  while(true) {
    within_fov = util::within_fov(level.player getplayercamerapos(), level.player getplayerangles(), level.var_dc8e763c getEye(), cos(60));

    if(within_fov == 1) {
      hms_util::print("<dev string:x4f>");

      break;
    }

    waitframe(1);
  }

  level thread scene::play("scene_rev_2020_fir_landmine_death", "start", a_actors);
  level flag::set("flg_vo_mines");

  if(isDefined(level.var_7ddb94fb)) {
    level.var_dc8e763c thread function_cf0e1871(level.var_7ddb94fb);
  }

  s_result = level.var_dc8e763c waittill(#"trigger_mine", #"death");

  if(isDefined(level.var_7ddb94fb.t_proximity)) {
    level.var_7ddb94fb.t_proximity notify(#"trigger");
  }

  if(isDefined(level.var_7ddb94fb)) {
    level.var_7ddb94fb waittill(#"death");
  }

  level notify(#"hash_ab5ce3c74acd448");
  savegame::checkpoint_save();
}

function function_cf0e1871(e_mine) {
  self endon(#"trigger_mine", #"death");
  e_mine waittill(#"death");
  self dodamage(9999, e_mine.origin);
}

function function_103e5f20() {
  a_ents = [];
  a_ents[#"enemy"] = spawner::simple_spawn_single(getent("vig_right_1_enemy_door_kick_spawner", "targetname"));
  a_ents[#"enemy"] endon(#"death");
  level flag::wait_till("flg_vig_first_floor_door_kick");
  var_4a3daa0b = struct::get("first_floor_cctv_door_look_at", "targetname");

  while(true) {
    within_fov = util::within_fov(level.player getplayercamerapos(), level.player getplayerangles(), var_4a3daa0b.origin, cos(35));
    var_19433220 = sighttracepassed(level.player getplayercamerapos(), var_4a3daa0b.origin, 0, undefined);

    if(within_fov == 1 && var_19433220 == 1) {
      break;
    }

    waitframe(1);
  }

  cctv_guards = spawner::simple_spawn("cctv_guards");
  level scene::play("cin_gen_aie_door_kick", a_ents);
}

function function_8b3f291() {
  a_ents = [];
  level flag::wait_till("play_scene_civ_execute");
  a_ents[#"contra"] = spawner::simple_spawn_single(getent("vig_execute_contra_spawner", "targetname"));
  a_ents[#"civilian"] = spawner::simple_spawn_single(getent("vig_execute_civ_spawner", "targetname"));
  a_ents[#"contra"] endon(#"death");
  a_ents[#"civilian"] endon(#"death");
  a_ents[#"contra"] function_628aec92("scene_vig_0000_amb_surrender_to_execution");
  a_ents[#"civilian"] function_628aec92("scene_vig_0000_amb_surrender_to_execution");

  foreach(guy in a_ents) {
    guy.health = 1;
  }

  level scene::play("scene_vig_0000_amb_surrender_to_execution", "surrender_enter", a_ents);
  level thread scene::play("scene_vig_0000_amb_surrender_to_execution", "surrender_loop", a_ents);
  wait 1.733;
  level scene::play("scene_vig_0000_amb_surrender_to_execution", "surrender_to_kick", a_ents);
  level thread scene::play("scene_vig_0000_amb_surrender_to_execution", "kick_loop", a_ents);
  wait 1.8;
  level scene::play("scene_vig_0000_amb_surrender_to_execution", "kick_to_execution", a_ents);
  level scene::play("scene_vig_0000_amb_surrender_to_execution", "execute_loop", a_ents);
}

function function_f08f3cb7(scenename, var_61210cb0) {
  while(level scene::is_active(scenename) && isalive(self)) {
    wait 0.1;
  }

  level scene::stop(scenename);

  if(isalive(var_61210cb0) && !isalive(self)) {
    var_61210cb0.team = "axis";
  }
}

function function_646785f0(scenename, var_c41afa4b) {
  while(level scene::is_active(scenename) && isalive(self)) {
    wait 0.1;
  }

  while(isalive(var_c41afa4b)) {
    wait 0.1;
  }

  level scene::stop(scenename);
}

function function_628aec92(scenename) {
  while(level scene::is_active(scenename) && isalive(self)) {
    wait 0.1;
  }

  level scene::stop(scenename);
}

function function_5997824f() {
  level.player thread util::delay(1.1, undefined, &playrumbleonentity, "damage_light");
  hms_util::function_78c3826c("scene_amk_6090_stg_garage");
}

function function_7d86c1d() {
  level flag::wait_till("flg_VIP_spotted_in_cctv");
  level scene::init("scene_rev_3050_fir_security_camera");
  level thread scene::play("scene_rev_3050_fir_security_camera", "play");
  level flag::wait_till("flg_cctv_finished");
  level scene::stop("scene_rev_3050_fir_security_camera", 1);
}

function function_c1f6c87c() {
  level endon(#"hash_4a17bb3c36a854c4");
  level endon(#"flg_cctv_finished");
  var_e534dcb = struct::get("ai_alder_radio", "targetname");
  level.park thread hms_util::dialogue("vox_cp_cbcr_01400_park_thereholdit_f8");
  level.park hms_util::dialogue("vox_cp_cbcr_01400_park_adlerwehaveeyes_b8");
  wait 0.1;
  level.park hms_util::dialogue("vox_cp_cbcr_01400_park_perseus_92");
  var_e534dcb hms_util::dialogue("vox_cp_cbcr_01400_adlr_where_3a", 1, "allies", "Adler");
  level.park hms_util::dialogue("vox_cp_cbcr_01400_park_2ndfloorroom27b_3d");
}

function function_c54af28a() {
  s_scene = struct::get("cctv_nuke_room_scene");
  var_34d58d57 = getent("clean_room_door", "targetname");
  var_34d58d57 hide();
  s_scene scene::init();
  s_scene.scene_ents[#"guy01"] thread function_d46f031f(["gut"], "hastings");
  s_scene.scene_ents[#"guy02"] thread function_d46f031f(["shoulder", "head"], "scientist");
  s_scene.scene_ents[#"guy03"] thread function_d46f031f(["shoulder", "head"], "scientist");
  s_scene.scene_ents[#"perseus"] disableaimassist();
  s_scene.scene_ents[#"guy01"] setModel("c_t9_cub_civ_male_scientist_body1");
  level flag::wait_till("flg_VIP_spotted_in_cctv");
  snd::client_msg("audio_cctv_nuke_room_duck");
  level flag::set("flg_stop_park_change_nags");

  hms_util::print("<dev string:x5e>");

  s_scene thread scene::play();
  level thread function_c1f6c87c();
  level flag::wait_till("flg_cctv_finished");
  var_34d58d57 show();
  s_scene scene::stop(1);
}

function function_d46f031f(a_shots, guy) {
  level endon(#"flg_cctv_finished");

  for(i = 0; i < a_shots.size; i++) {
    self waittill(a_shots[i] + "_shot");

    if(guy == "hastings") {
      self setModel("c_t9_cub_civ_male_scientist_body_bloody_torso");
      continue;
    }

    if(a_shots[i] != "head") {
      self setModel("c_t9_cub_civ_male_scientist_body_bloody_shoulder");
      continue;
    }

    self detach(self.head);
    self attach("c_t9_guard_m_berlin_head04_shot");
  }
}

function function_48e82918() {
  level flag::wait_till("flg_lobby_camera");
  var_df21139a = struct::get("lobby_phys_impulse", "targetname");
  physicsexplosionsphere(var_df21139a.origin, 60, 0, 0.06);
  var_35a13abc = spawner::simple_spawn("lobby_camera_drone");
  var_9cdc026 = snd::play("evt_cctv_group_fs", var_35a13abc);
  var_8c1e64e3 = snd::play("evt_cctv_group_gear", var_35a13abc);
  level waittill(#"hash_37a2f205712110e2");
  snd::stop(var_9cdc026);
  snd::stop(var_8c1e64e3);
}

function function_fedf7c() {
  level scene::init("scene_rev_3050_fir_cam_dining_room");
  level flag::wait_till("play_scene_civ_ground");
  level thread scene::play("scene_rev_3050_fir_cam_dining_room");
  level thread function_7482b1ff();
  snd::client_msg("audio_cctv_dining_room_duck");
  level flag::set("flg_in_dining_room");
  wait randomfloatrange(1, 2);
  level.park hms_util::dialogue("vox_cp_cbcr_01400_park_keeplooking_c6");
  level flag::wait_till("flg_cctv_finished");
  level scene::stop("scene_rev_3050_fir_cam_dining_room", 1);
}

function function_7482b1ff() {
  level.player endon(#"death");
  level endon(#"flg_VIP_spotted_in_cctv", #"flg_stop_park_change_nags");
  wait 8;
  var_ffbbfc35 = [];
  var_ffbbfc35[0] = "vox_cp_cbcr_01400_park_theresgottobeot_26";
  var_ffbbfc35[1] = "vox_cp_cbcr_01400_park_tryanotherchann_77";
  var_ffbbfc35[2] = "vox_cp_cbcr_01400_park_tryanotherfeed_32";
  var_ffbbfc35[3] = "vox_cp_cbcr_01400_park_thatsnotit_9b";
  var_ffbbfc35[4] = "vox_cp_cbcr_01400_park_changethechanne_ce";
  array::randomize(var_ffbbfc35);
  n_nag = 0;

  while(!level flag::get("flg_cctv_nags_done")) {
    if(isDefined(var_ffbbfc35[n_nag])) {
      level.park hms_util::dialogue(var_ffbbfc35[n_nag]);
      n_nag++;
      wait randomfloatrange(10, 15);
      continue;
    }

    level flag::set("flg_cctv_nags_done");
    break;
  }
}

function function_604a3e80() {
  level endon(#"flg_in_dining_room");
  s_scene = struct::get("rev_3050_fir_cam_kitchen_scene");
  var_e534dcb = struct::get("ai_alder_radio", "targetname");

  if(isDefined(level.adler)) {
    level.adler animation::stop();
  }

  level scene::init("scene_rev_3050_fir_cam_kitchen");
  s_scene.scene_ents[#"adler"] sethighdetail(1);
  level flag::wait_till("play_scene_civ_execute");
  level thread scene::play("scene_rev_3050_fir_cam_kitchen");
  level flag::set("flg_in_kitchen");
  wait 0.75;
  level.park thread hms_util::dialogue("vox_cp_cbcr_01400_park_adlertheresonem_84");
  level flag::wait_till("flg_cctv_finished");
  level scene::stop("scene_rev_3050_fir_cam_kitchen", 1);
  s_scene.scene_ents[#"adler"] sethighdetail(0);
}

function function_c9b603f3(var_57ef78ed) {
  level endon(#"hash_604e61bc28aebaeb");
  actors[#"door2"] = getent("cctv_exit_door_left", "targetname");
  actors[#"door1"] = getent("cctv_exit_door_right", "targetname");
  level.lazar sethighdetail(1);
  e_clip = getent("cctv_exit_door_left_clip", "targetname");
  e_clip disconnectpaths();
  level thread function_39beb73c(actors);

  if(var_57ef78ed == "floor_one") {
    level waittill(#"hash_51b0d8debd24a46f");
    level thread scene::play("scene_rev_3040_fir_cctv_lazar", "enter");
    level waittill(#"hash_14228b58001caf88");
    level thread scene::play("scene_rev_3040_fir_cctv_lazar", "lazar_loop");
  } else {
    level thread scene::play("scene_rev_3040_fir_cctv_lazar", "lazar_loop");
  }

  level flag::wait_till("flg_cctv_finished");
  level scene::play("scene_rev_3040_fir_cctv_lazar", "exit", actors);
}

function function_8d918610(var_57ef78ed) {
  level endon(#"hash_604e61bc28aebaeb");

  if(var_57ef78ed == "floor_one") {
    level waittill(#"hash_2217c60a57d6c9a3");
    level scene::play("scene_rev_3040_fir_cctv_lazar", "park_enter_45frames_after_lazar");
  }

  level thread scene::play("scene_rev_3040_fir_cctv_lazar", "park_loop");
  level function_fd4c7e28();
}

function function_39beb73c(actors) {
  level flag::wait_till("flg_cctv_int");
  level notify(#"hash_604e61bc28aebaeb");
  var_2cdf7dae = getactorteamarray("axis");

  foreach(guy in var_2cdf7dae) {
    if(isDefined(guy.anim_debug_name) && guy.anim_debug_name != "perseus") {
      guy util::stop_magic_bullet_shield();
      guy deletedelay();
    }
  }

  level flag::wait_till("flg_cctv_finished");
  level scene::play("scene_rev_3040_fir_cctv_lazar", "exit", actors);
  level.lazar sethighdetail(0);
  level thread function_3ef39f15();
  level thread function_1e877ccc();
}

function function_fd4c7e28() {
  level endon(#"flg_VIP_spotted_in_cctv");

  while(true) {
    var_b621dade = "nag" + randomintrangeinclusive(1, 3);
    level scene::play("scene_rev_3040_fir_cctv_lazar", var_b621dade);
    level scene::play("scene_rev_3040_fir_cctv_lazar", "park_loop");
  }
}

function function_39f8bb19() {
  level endon(#"flg_VIP_spotted_in_cctv");
  level scene::play("scene_rev_3040_fir_cctv_lazar", "enter");
  level scene::play("scene_rev_3040_fir_cctv_lazar", "lazar_loop");
}

function function_dde2e307() {
  hms_util::function_78c3826c("scene_rev_3060_c4_gate");
}

function function_3ef39f15() {
  level endon(#"c4_planted");
  level scene::play("scene_rev_3070_fir_c4_gate", "enter_lazar");
  level thread scene::play("scene_rev_3070_fir_c4_gate", "loop_lazar");
}

function function_1e877ccc() {
  level endon(#"c4_planted");
  level scene::play("scene_rev_3070_fir_c4_gate", "enter_park");
  level thread scene::play("scene_rev_3070_fir_c4_gate", "loop_park");
}

function function_223dbff(var_b66369f4) {
  if(!var_b66369f4) {
    level flag::wait_till("c4_planted");
    level thread scene::play("scene_rev_3070_fir_c4_gate", "loop_to_brace");
    level waittill(#"hash_1ebf62c7b43dbd5e");
  }

  level thread function_3a15e85();
}

function function_3a15e85() {
  level scene::play("scene_rev_3070_fir_c4_gate", "exit");
  wait 1;
  trigger::use("lazar_fix_2nd_pathing");
}

function function_78f15dd1() {
  level thread scene::init("door_breach");
  level flag::wait_till("flg_door_breached_to_second_floor");
  level scene::play("door_breach", "play");
}

function function_e73fa40e(var_57ef78ed) {
  a_ents[#"door"] = getent("clean_room_door", "targetname");
  level thread scene::init("scene_rev_4010_nuke_room_lazar", a_ents);

  if(var_57ef78ed != "2nd_floor") {
    level flag::wait_till_all(array("flg_player_nearing_vip_room_vo", "flg_vip_door_last_stand_enemies_dead"));
  } else {
    level flag::wait_till("flg_player_nearing_vip_room_vo");
  }

  level notify(#"hash_1c417066dc2e86a4");
  level flag::wait_till("flg_open_nuke_door");
  level thread namespace_307260b8::function_529afded(1);
  level scene::play("scene_rev_4010_nuke_room_lazar", "enter", a_ents);
  level thread scene::play("scene_rev_4010_nuke_room_lazar", "loop", a_ents);
  level flag::wait_till("play_nuke_room");
  level.lazar val::set("nuke_room_ignore_all", "ignoreall", 0);
  e_door_clip = getent("nuke_room_door_clip", "targetname");
  e_door_clip show();
  level thread scene::play("scene_rev_4010_nuke_room_lazar", "close", a_ents);
  level waittill(#"hash_40c545f8691fd139");

  hms_util::print("<dev string:x6a>");

  level flag::wait_till("obj_photo_done");
  e_door_clip delete();
  level thread scene::play_from_time("scene_rev_4010_nuke_room_lazar", "exit", a_ents, 0.185897, 1, 1);
}

function function_ee30e713() {
  level.player endon(#"death");
  level waittill(#"hash_5d0126efad9dc30");

  hms_util::print("<dev string:x77>");

  self delete();
}

function function_b91f9a58(var_57ef78ed) {
  a_ents = [];
  var_602672df = getent("vip_door_player_clip", "targetname");

  hms_util::print("<dev string:x88>");

  var_602672df hide();
  a_ents[#"park"] = getent("park", "targetname", 1);
  a_ents[#"scientist"] = spawner::simple_spawn_single(getent("vip_room_scientist_spawner", "targetname"));
  a_ents[#"scientist"] setModel("c_t9_cp_cub_civ_scientist_hastings_bloody");
  level thread function_abdca9ef(a_ents);
  a_ents[#"nuke_room_park_gun"] = getent("nuke_room_park_gun", "targetname");
  a_ents[#"nuke_room_park_gun"] hide();
  a_ents[#"nuke_room_park_gun"] thread function_c2bb9d98();

  if(var_57ef78ed != "2nd_floor") {
    level flag::wait_till_all(array("flg_player_nearing_vip_room_vo", "flg_vip_door_last_stand_enemies_dead"));
  } else {
    level flag::wait_till("flg_player_nearing_vip_room_vo");
  }

  var_602672df show();

  hms_util::print("<dev string:x95>");

  var_602672df thread function_ee30e713();
  level scene::play("scene_rev_4010_nuke_room_lazar", "park_enter", a_ents);
  level.lazar val::set("nuke_room_ignore_all", "ignoreall", 1);

  if(!level flag::get("play_nuke_room")) {
    level thread scene::play("scene_rev_4010_nuke_room_lazar", "park_enter_hold", a_ents);
    level flag::wait_till("play_nuke_room");
  }

  level.park ai::set_behavior_attribute("demeanor", "cqb");
  level scene::play("scene_rev_4010_nuke_room_lazar", "park_enter2", a_ents);

  if(!level flag::get("obj_photo_done")) {
    level function_f93bb53f();
  }

  level thread namespace_307260b8::function_529afded(0);
  level thread scene::play("scene_rev_4010_nuke_room_lazar", "park_exit", a_ents);
  level thread function_fe6c4ca4();
  level waittill(#"flg_escape_bullets_start");
  level thread scene::stop("scene_rev_4010_nuke_room_lazar");

  if(isDefined(a_ents[#"scientist"]) && isalive(a_ents[#"scientist"])) {
    a_ents[#"scientist"] kill();
  }
}

function function_c2bb9d98() {
  self waittill(#"hash_5844b9b98619c009");
  self show();
}

function private function_fe6c4ca4() {
  s_scene = struct::get("scene_rev_4010_nuke_room_lazar", "targetname");
  var_207ec521 = s_scene.scene_ents[#"nuke_room_park_gun"];
  level waittill(#"hash_6c6472ced18e7153");
  var_207ec521 hide();
  wait 1.5;
  level.park ai::set_behavior_attribute("demeanor", "combat");
}

function function_ad98871a() {
  e_door_clip = getent("nuke_room_door_clip", "targetname");
  e_door_clip delete();
  a_ents[#"door"] = getent("clean_room_door", "targetname");
  level scene::play_from_time("scene_rev_4010_nuke_room_lazar", "exit", a_ents, 1, 1, 1, 1, 1);
}

function function_abdca9ef(a_ents) {
  level thread scene::play("scene_rev_4010_nuke_room", "body_loop", a_ents);
}

function function_f93bb53f() {
  level endon(#"hash_18231374474c1e10");
  var_2f6b4bf5 = 0;
  level thread function_b3ef71a8();

  while(!level flag::get("obj_photo_done")) {
    if(var_2f6b4bf5 == 0) {
      level scene::play("scene_rev_4010_nuke_room_lazar", "park_loop");
      var_2f6b4bf5 = randomintrangeinclusive(1, 2);
      continue;
    }

    var_b621dade = "park_nag" + var_2f6b4bf5;
    level scene::play("scene_rev_4010_nuke_room_lazar", var_b621dade);
    var_2f6b4bf5 = 0;
  }

  while(!level flag::get("flg_vo_in_nuke_room_complete")) {
    level scene::play("scene_rev_4010_nuke_room_lazar", "park_loop");
  }
}

function function_b3ef71a8() {
  level endon(#"hash_18231374474c1e10");

  while(true) {
    if(level flag::get("obj_photo_done") && level flag::get("flg_vo_in_nuke_room_complete")) {
      level notify(#"hash_18231374474c1e10");
    }

    wait 0.1;
  }
}

function function_59320958() {
  var_63802c77 = getent("left_window_bullet_origin", "targetname");
  var_79f11353 = getent("right_window_bullet_origin", "targetname");
  var_3cca49f5 = getent("bullet_destination_1", "targetname");
  var_2e72ad46 = getent("bullet_destination_2", "targetname");
  var_603a10d8 = getent("bullet_destination_3", "targetname");
  level flag::wait_till("flg_escape_bullets_start");
  level thread scene::play("p9_fxanim_gp_hallway_glass_break_scene", "play");
  magicbullet(getweapon(#"ar_accurate_t9"), var_63802c77.origin, var_3cca49f5.origin);
  wait 0.2;
  magicbullet(getweapon(#"ar_accurate_t9"), var_79f11353.origin, var_2e72ad46.origin);
  wait 0.1;
  magicbullet(getweapon(#"ar_accurate_t9"), var_79f11353.origin, var_603a10d8.origin);
  wait 0.1;
  magicbullet(getweapon(#"ar_accurate_t9"), var_79f11353.origin, var_2e72ad46.origin);
  wait 0.2;
  magicbullet(getweapon(#"ar_accurate_t9"), var_63802c77.origin, var_3cca49f5.origin);
  wait 0.1;
  magicbullet(getweapon(#"ar_accurate_t9"), var_79f11353.origin, var_603a10d8.origin);

  while(!flag::get("flg_escape_turn_off_window_bullets")) {
    magicbullet(getweapon(#"ar_accurate_t9"), var_63802c77.origin, var_3cca49f5.origin);
    wait 0.2;
    magicbullet(getweapon(#"ar_accurate_t9"), var_79f11353.origin, var_2e72ad46.origin);
    wait 0.1;
    magicbullet(getweapon(#"ar_accurate_t9"), var_79f11353.origin, var_603a10d8.origin);
    wait 0.1;
    magicbullet(getweapon(#"ar_accurate_t9"), var_79f11353.origin, var_2e72ad46.origin);
    wait 0.2;
    magicbullet(getweapon(#"ar_accurate_t9"), var_63802c77.origin, var_3cca49f5.origin);
    wait 0.1;
    magicbullet(getweapon(#"ar_accurate_t9"), var_79f11353.origin, var_603a10d8.origin);
  }
}

function function_a1651470() {
  var_cad35a6 = doors::get_doors("escape_breach_door");
  c_door = var_cad35a6[0].c_door;
  [[c_door]] - > function_e7be6e76(0, 1, 0, 0);
  level thread function_9f83193();
  a_ents = [];
  a_ents[#"lazar"] = getent("lazar", "targetname", 1);
  a_ents[#"prop 1"] = c_door.m_e_door;
  level scene::add_scene_func("scene_rev_5010_esc_trapped_breach", &function_aecde30d, "breach_enter");
  level scene::play("scene_rev_5010_esc_trapped_breach", "breach_enter", a_ents);

  if(![[c_door]] - > is_open()) {
    level.lazar thread hms_util::dialogue("vox_cp_cbcr_01700_lazr_doorisjammed_3f");
  }

  while(!level flag::get("flg_escape_door_open")) {
    level scene::play("scene_rev_5010_esc_trapped_breach", "breach_loop", a_ents);
    level flag::set("flg_lazar_in_position");
  }

  var_d15c3251 = getnode("node_post_door_kick", "targetname");

  if(!flag::get("flg_lazar_skip_node")) {
    level.lazar thread spawner::go_to_node(var_d15c3251);
  } else {
    level.lazar colors::enable();
    trigger::use("trig_lazar_color_post_node");
  }

  level trigger::use("trig_lazar_go_ahead");

  if(!level flag::get("flg_door_kicked")) {
    level flag::set("flg_door_kicked");
    level scene::play("scene_rev_5010_esc_trapped_breach", "breach_exit", a_ents);
  }

  level flag::set("flg_past_hallway");
  level.lazar colors::enable();
}

function function_9f83193() {
  var_a2ac77ba = getEntArray("escape_front_right_civ_spawner", "targetname", 1);

  while(!isDefined(var_a2ac77ba[1])) {
    var_a2ac77ba = getEntArray("escape_front_right_civ_spawner", "targetname", 1);
    wait 0.1;
  }

  if(isDefined(var_a2ac77ba[1])) {
    var_a2ac77ba[1] thread function_82205464("scene_rev_0000_ambient_cower13", 500);
  }

  if(isDefined(var_a2ac77ba[2])) {
    var_a2ac77ba[2] thread function_82205464("scene_rev_0000_ambient_cower14", 500);
  }
}

function function_aecde30d(ents) {
  c_door = ents[#"prop 1"].c_door;
  [[c_door]] - > function_e7be6e76(0, 0, 0, 0);
}

function function_8aab62a1(scene, var_3a51c5dc, loop_anim, ents) {
  level scene::play(scene, var_3a51c5dc, ents);
  level scene::play(scene, loop_anim, ents);
}

function scene_rev_5030_rft_heliland() {
  level scene::play("scene_rev_5030_rft_heliland", "enter_player");
}

function function_ba3f106b(var_57ef78ed) {
  if(var_57ef78ed != "exfil") {
    if(isDefined(level.redshirt_1)) {
      var_4ab9f7af = struct::get("redshirt_1_rooftop_struct");
      level.redshirt_1 forceteleport(var_4ab9f7af.origin, var_4ab9f7af.angles);
      level.redshirt_1 colors::disable();
      level.redshirt_1.ignoreall = 1;
    } else {
      level hms_util::function_ee1d1df6("redshirt_1", "Redshirt 1", "redshirt_1_rooftop_struct");
      level.redshirt_1 colors::disable();
      level.redshirt_1.ignoreall = 1;
    }

    if(isDefined(level.redshirt_2)) {
      var_657624 = struct::get("redshirt_2_rooftop_struct");
      level.redshirt_2 forceteleport(var_657624.origin, var_657624.angles);
      level.redshirt_2 colors::disable();
      level.redshirt_2.ignoreall = 1;
    } else {
      level hms_util::function_ee1d1df6("redshirt_2", "Redshirt 2", "redshirt_2_rooftop_struct");
      level.redshirt_2 colors::disable();
      level.redshirt_2.ignoreall = 1;
    }
  }

  level flag::set("flg_rooftop_redshirts_spawned");

  if(var_57ef78ed == "escape") {
    flag::wait_till("flg_escape_heli_flyby");
  }

  if(var_57ef78ed == "escape" || var_57ef78ed == "rooftop") {
    level scene::init("scene_rev_5040_rtp_balloon_release");
    level thread function_4c89bd94();
    level flag::wait_till("flg_regroup_with_team");
    level scene::play("scene_rev_5040_rtp_balloon_release", "main");
  }

  level thread scene::play("scene_rev_5040_rtp_balloon_release", "balloon_air_loop");
  level flag::set("flg_setup_skyhook_done");
}

function function_4c89bd94() {
  flag_check = level flag::get("flg_regroup_with_team");
  level thread scene::play("scene_rev_5040_rtp_balloon_release", "init");

  while(!flag_check) {
    level waittill(#"hash_18248e684569c04");
    level scene::init("scene_rev_5040_rtp_balloon_release");
    flag_check = level flag::get("flg_regroup_with_team");
  }
}

function function_fe8c8150() {
  level thread function_617f5754();
}

function function_617f5754() {
  level endon(#"hash_253be3e72f1d36e0");
  level scene::play("scene_rev_5045a_rtp_balloon_defend", "start");
  level flag::set("flg_park_skyhook_ready");

  for(i = 0; true; i = 0) {
    if(i == 0) {
      level scene::play("scene_rev_5045a_rtp_balloon_defend", "idle_loop");
      i = randomintrangeinclusive(1, 4);
      continue;
    }

    level scene::play("scene_rev_5045a_rtp_balloon_defend", "nag" + i);
  }
}

function function_1c03801f() {
  level endon(#"hash_253be3e72f1d36e0");
  level scene::play("scene_rev_5045b_rtp_balloon_defend", "start");
  level flag::set("flg_lazar_skyhook_ready");
  level scene::play("scene_rev_5045b_rtp_balloon_defend", "idle_loop");
}

function function_23334bfb() {
  level.player endon(#"death");
  var_bcbd3ddd = getent("skyhook_hook", "targetname");
  level.player val::set(#"hash_3de08cce7bf91456", "disable_weapons", 1);
  level.player val::set(#"hash_3de08cce7bf91456", "freezecontrols_allowlook", 1);
  wait 0.4;
  level notify(#"hash_253be3e72f1d36e0");
  level scene::stop("scene_rev_5045a_rtp_balloon_defend");
  level scene::stop("scene_rev_5045b_rtp_balloon_defend");
  level scene::play("scene_rev_5050_rtp_extract", "hookup_explosion", var_bcbd3ddd);
  level.player val::reset_all(#"hash_3de08cce7bf91456");
  level flag::set("flg_exfil_explosion_hit");
  s_tag = struct::get("tag_align_rev_skyhook");
  var_60a25e22 = getcorpsearray(s_tag.origin, 256);
  array::delete_all(var_60a25e22);
  e_debris = getent("rooftop_rpg_debris", "targetname");
  e_debris show();
  level.lazar detach(level.lazar.head);
  level.park detach(level.park.head);
  level.lazar attach("c_t9_cp_usa_hero_lazar_head1_revolucion_infil_explosion");
  level.park attach("c_t9_cp_eng_hero_park_head_revolucion_infil_explosion");
  level.lazar setModel("c_t9_cp_usa_hero_lazar_revolucion_infil_dirty_body");
  level.park setModel("c_t9_cp_eng_hero_park_revolucion_infil_body_explosion");
  level flag::set("flg_choice_nags");
  level scene::play("scene_rev_5050_rtp_extract", "explosion_getup");
  level scene::stop("scene_rev_5040_rtp_balloon_release", 1);
  level scene::play("scene_rev_5050_rtp_extract", "choice_loop");
}

function function_67b48edc() {
  level flag::set("flg_saved_park");
  level.park sethighdetail(1);
  level scene::play("scene_rev_5050_rtp_extract", "choose_park");
}

function function_5bbd4049() {
  level flag::set("flg_saved_lazar");
  level.lazar sethighdetail(1);
  level scene::play("scene_rev_5050_rtp_extract", "choose_lazar");
}

function function_d4b87197() {
  level scene::play("scene_rev_5050_rtp_extract", "choose_fail");
}

function function_28cf7333() {
  level waittill(#"hash_32722a1530edbc3");
  level scene::play("scene_rev_5055_rtp_soldiers_clear", "enter");
}

function function_82205464(var_fa359e06, var_67b4e975) {
  self endon(#"death");
  actors[#"guy"] = self;
  level thread scene::play(var_fa359e06, "cower_loop", actors);

  while(!(level.player islookingat(self) && distancesquared(level.player.origin, self.origin) <= var_67b4e975 * var_67b4e975)) {
    wait 0.1;
  }

  level thread scene::play(var_fa359e06, "extreme_loop", actors);
}

function function_dbd5c057() {
  level thread scene::init("p9_fxanim_cp_yamanatua_birds_scare_01_bundle");
  level thread scene::init("p9_fxanim_cp_yamanatua_birds_scare_02_bundle");
  level thread scene::init("p9_fxanim_cp_yamanatua_birds_scare_03_bundle");
  level flag::wait_till("flg_escape_on_scaffolding");

  if(isDefined(level.player)) {
    level.player playrumbleonentity(#"fallimpact_med");
    level thread scene::play("p9_fxanim_cp_yamanatua_birds_scare_01_bundle", "shot1");
    wait randomfloatrange(0.1, 0.3);
    level.player playrumbleonentity(#"fallimpact_med");
    level thread scene::play("p9_fxanim_cp_yamanatua_birds_scare_02_bundle", "shot1");
    wait randomfloatrange(0.2, 0.5);
    level.player playrumbleonentity(#"fallimpact_med");
    level thread scene::play("p9_fxanim_cp_yamanatua_birds_scare_03_bundle", "shot1");
  }
}

function function_eff61506() {
  level.player endon(#"death");
  level endon(#"hash_2ca0e7bbee5cd2e3");
  level thread scene::init("scene_rev_0000_ambient_dead_scientist_01");
  level thread scene::init("scene_rev_0000_ambient_dead_scientist_03");
  level thread scene::init("scene_rev_0000_ambient_dead_scientist_04");
}