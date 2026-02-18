/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_719116534f2a623f.gsc
***********************************************/

#using script_155b17ff7c8b315c;
#using script_1b9f100b85b7e21d;
#using script_446752c03c555e16;
#using script_57d05cf093ffba5c;
#using script_6cd35fe7afb1f231;
#using script_97b74052c477c23;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp\cp_rus_amerika_fx;
#using scripts\cp_common\arcade_machine;
#using scripts\cp_common\breadcrumbs;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#using scripts\weapons\cp\spy_camera;
#namespace namespace_aad1a8fc;

function function_c4dc0c81(str_objective) {
  setDvar(#"r_lightingsunshadowdisabledynamicdraw", 1);
  clientfield::set("SetPBGExposureBank", 2);
  namespace_fc3e8cb::function_2987fd4c("s_teleport_woods_arcade", 1, 0);
  level flag::set("flg_tunnels_woods_at_lower_level");
  level thread function_8fbb8d72();
}

function function_f31f54a0(str_objective, var_50cc0d4f) {
  namespace_fc3e8cb::function_44a6fc04(var_50cc0d4f);

  level thread function_d9a12f35();
  level thread function_212dbe3();
  level thread function_c73e4889();
  level thread function_ae1399c9();
  level thread function_76c43e8d();
  clientfield::set("cull_mainstreet", 1);
  snd::client_msg("flg_arcade_audio_emitters_start");
  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_arcade_window_volumetric", 1);
  level thread function_14dd1d24();
  level thread function_c924cc46();
  level namespace_fc3e8cb::function_a96c8ec0();
  level thread namespace_fc3e8cb::function_56dd5180();
  level thread namespace_fc3e8cb::function_869f213d();
  level function_7ad4f5cb();
  level thread function_9df06428();
  level thread namespace_fc3e8cb::function_6fe40e14("video_store_gun_rack1", "video_store_gun_rack2", "video_store_gun_rack3");
  level thread namespace_979752dc::function_740dbf99();
  level flag::wait_till_any(["flg_arcade_at_exit", "flg_arcade_scenes_complete"]);
  skipto::function_4e3ab877(var_50cc0d4f);
}

function function_bb767617(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  clientfield::set("cull_facility", 2);
  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_arcade_window_volumetric", 0);
  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_perf_tunnel", 1);
  var_a430c43a = getEntArray("e_obj_arcade_photo", "targetname");
  array::delete_all(var_a430c43a);

  if(player) {
    level thread namespace_fc3e8cb::function_2e7c81f6(0);
    level thread function_28acc8ac();
    level namespace_fc3e8cb::function_a96c8ec0();
    level thread namespace_fc3e8cb::function_56dd5180();
  }
}

function function_d9a12f35() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level spy_camera::function_f91a82ef(0);

  if(!isDefined(objectives::function_285e460("obj_arcade_main"))) {
    objectives::scripted("obj_arcade_main", undefined, #"hash_6e65c7528d18da7f", 0);
  }

  level breadcrumb::function_61037c6c("s_obj_arcade_breadcrumb");
  level flag::wait_till("flg_arcade_at_vista");
  objectives::complete("obj_arcade_main");
  level.player clientfield::set_to_player("spy_camera_photo_focus_check", 1);
  var_457dd409 = struct::get("s_arcade_vig_heli_rappel", "targetname");
  objectives::goto("obj_arcade_photo", var_457dd409.origin, #"hash_5425ac050fa6e018", 1, 0);
  objectives::function_67f87f80("obj_arcade_photo", undefined, #"hash_10a1b044bd73dc29");
  wait 1;

  if(!flag::get("flg_arcade_street_photo_taken") && level.player getcurrentweapon() != level.var_e3f5eafc) {
    level.player util::show_hint_text(#"hash_549b99af44962dbf", undefined, "hide_camera_equip_hint", 20);
  }

  level flag::wait_till("flg_arcade_street_photo_taken");
  level.player clientfield::set_to_player("spy_camera_photo_focus_check", 0);
  objectives::complete("obj_arcade_photo");
  level spy_camera::function_f91a82ef(1);
}

function function_ae1399c9() {
  level.woods ai::set_behavior_attribute("vignette_mode", "fast");
  level.woods ai::set_behavior_attribute("disablepeek", 1);
  level.woods ai::set_behavior_attribute("disablelean", 1);
  level.woods battlechatter::function_2ab9360b(0);
  level flag::wait_till("flg_tunnels_woods_at_lower_level");
  level scene::init("scene_amk_3025_arc_exit");
  level thread namespace_2977687d::scene_amk_3010_arc_enter();
  level.player util::blend_movespeedscale(0.85, 1);
}

function function_8fbb8d72() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level.player util::blend_movespeedscale(0.85, 1);
}

function function_76c43e8d() {
  flag::wait_till("flg_arcade_entrance_vig_start");
  namespace_b61bbd82::music("deactivate_4.0_inside", 1);
}

function function_212dbe3() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level flag::wait_till("flg_arcade_at_entrance");
  savegame::function_7790f03(1);
  waitframe(1);
  level thread function_28acc8ac();
}

function function_28acc8ac() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  var_229a8637 = 0;
  var_be18fd80 = 0;
  level flag::wait_till_any(["flg_arcade_gun_low_ready", "flg_arcade_end_gundown"]);

  while(!flag::get("flg_arcade_end_gundown")) {
    if(flag::get("flg_arcade_gun_low_ready") && !var_be18fd80) {
      level.player util::blend_movespeedscale(0.8, 1);
      level.player namespace_fc3e8cb::function_112aa648(1);
      var_be18fd80 = 1;
    } else if(!flag::get("flg_arcade_gun_low_ready") && var_be18fd80 && !level.player flag::get(#"playing_arcade_game")) {
      wait 1;

      if(flag::get("flg_arcade_gun_low_ready")) {
        continue;
      }

      level.player util::blend_movespeedscale_default(1);
      level.player namespace_fc3e8cb::function_112aa648(0);
      var_be18fd80 = 0;
    }

    if(flag::get("flg_arcade_gun_low_ready")) {
      if(level.player getcurrentweapon() == level.var_e3f5eafc && var_229a8637) {
        level.player util::function_749362d7(0);
        var_229a8637 = 0;
      } else if(level.player getcurrentweapon() != level.var_e3f5eafc && !var_229a8637) {
        level.player util::function_749362d7(1, #"hash_79d8239db87989b0");
        var_229a8637 = 1;
      }
    } else if(!flag::get("flg_arcade_gun_low_ready") && var_229a8637 && !level.player flag::get(#"playing_arcade_game")) {
      wait 1;

      if(flag::get("flg_arcade_gun_low_ready")) {
        continue;
      }

      level.player util::function_749362d7(0);
      var_229a8637 = 0;
    }

    wait 0.25;
  }

  level function_77b24e0e();
}

function function_9df06428() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");

  while(!level flag::get("flg_arcade_woods_move_to_exit")) {
    if(level.player getcurrentweapon() == level.var_e3f5eafc) {
      level flag::set("flg_arcade_camera_out");
      break;
    }

    wait 0.1;
  }
}

function private function_77b24e0e() {
  level.player util::function_749362d7(0);
  level.player util::blend_movespeedscale_default(1);
  level.player namespace_fc3e8cb::function_112aa648(0);
  var_507573c7 = getent("t_arcade_gun_low_ready_volume", "targetname");
  var_507573c7 delete();
  level thread scene::play("scene_amk_3025_arc_exit", "exit_close_door");
  level thread scene::play("p9_fxanim_cp_amk_4010_heli_rappel_rope_bundle", "post");
}

function function_c73e4889() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  var_a430c43a = getEntArray("e_obj_arcade_photo", "targetname");
  assert(var_a430c43a.size == 13);

  foreach(e_obj in var_a430c43a) {
    level.player spy_camera::function_f785d9e9(e_obj);
  }

  array::wait_any(var_a430c43a, "photo_taken");
  level flag::set("flg_arcade_street_photo_taken");
  clientfield::set("cull_facility", 2);
  level.player flag::clear("flg_random_photo_taken");

  foreach(e_obj in var_a430c43a) {
    level.player spy_camera::function_b28ab5a9(e_obj);
    waitframe(1);
  }

  while(level.player adsButtonPressed() || !util::within_fov(level.player getplayercamerapos(), level.player getplayerangles(), level.woods getEye(), cos(45))) {
    wait 0.5;
  }

  level.woods flag::set("flg_arcade_woods_move_to_exit");
}

function function_14dd1d24() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  s_arcade_vig_heli_rappel = struct::get("s_arcade_vig_heli_rappel", "targetname");
  level thread scene::init("arcade_window_rappel_scene", "targetname");
  level flag::wait_till("flg_arcade_at_vista");

  while(true) {
    within_fov = util::within_fov(level.player getplayercamerapos(), level.player getplayerangles(), s_arcade_vig_heli_rappel.origin, cos(45));
    var_19433220 = sighttracepassed(level.player getplayercamerapos(), s_arcade_vig_heli_rappel.origin, 0, undefined);

    if(within_fov == 1 && var_19433220 == 1) {
      level function_61dadea0();
      break;
    }

    waitframe(1);
  }
}

function function_61dadea0() {
  level thread scene::play("arcade_window_rappel_scene", "targetname");
  level thread namespace_fc3e8cb::function_fa5905d0("s_arcade_heli_lights");
  var_f1f393cc = getaiarray("sp_streets_rappel_group", "targetname");
  function_1eaaceab(var_f1f393cc);
  level thread namespace_fc3e8cb::function_18e5080e("flg_video_store_start", var_f1f393cc);
  var_31a7069 = getent("vol_amerika_video_store_heli_vignette", "targetname");

  foreach(ai in var_f1f393cc) {
    ai namespace_fc3e8cb::function_aa5f0d6b();
    ai thread namespace_fc3e8cb::function_a7c9ed68(var_31a7069, 0, 1);
    ai thread function_48dea88a();
  }
}

function function_c924cc46() {
  level flag::wait_till("flg_arcade_at_entrance");
  level thread function_c1bc15a1();
  level thread namespace_fc3e8cb::function_1c62d05e("ai_enemy_arcade_drone", "flg_video_store_at_catwalk", 1);
  var_3d7e32e2 = spawner::simple_spawn("sp_arcade_vista_actors", &namespace_fc3e8cb::function_aa5f0d6b);
  level thread namespace_fc3e8cb::function_18e5080e("flg_video_store_corridor", var_3d7e32e2);
}

function function_48dea88a() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  self endon(#"death");
  self waittill(#"hash_542161c43bda2568");
  wait 1;
  self waittill(#"goal");

  if(self.allowdeath !== 0) {
    self deletedelay();
  }
}

function function_c1bc15a1() {
  level flag::wait_till("flg_amk_player_spawned");
  s_scene_arcade_window_01 = struct::get("s_scene_arcade_window_01", "targetname");
  s_scene_arcade_window_02 = struct::get("s_scene_arcade_window_02", "targetname");
  s_scene_arcade_window_01 scene::init("scene_amk_0000_command_window_02");
  s_scene_arcade_window_02 scene::init("scene_amk_0000_command_window_02");
  s_scene_arcade_window_01 thread scene::play("scene_amk_0000_command_window_01");
  s_scene_arcade_window_02 thread scene::play("scene_amk_0000_command_window_02");
  level flag::wait_till("flg_video_store_at_catwalk");
  s_scene_arcade_window_01 scene::stop("scene_amk_0000_command_window_01");
  s_scene_arcade_window_02 scene::stop("scene_amk_0000_command_window_02");
  waitframe(1);
  s_scene_arcade_window_01 scene::delete_scene_spawned_ents("scene_amk_0000_command_window_01");
  s_scene_arcade_window_02 scene::delete_scene_spawned_ents("scene_amk_0000_command_window_02");
}

function private function_7ad4f5cb() {
  a_s_interacts = struct::get_array(#"hash_3dd86258529972ca");
  array::thread_all(a_s_interacts, &function_f78628e6);
}

function private function_f78628e6() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  e_interact = util::spawn_model(#"tag_origin", self.origin, self.angles);

  while(!flag::get("flg_arcade_end_gundown")) {
    gameRef = self.script_noteworthy;
    var_ae865aeb = getscriptbundle(gameRef);
    var_3b88de0c = # "hash_6ffbe136c9ac4c4e";

    if(isDefined(var_ae865aeb) && isDefined(var_ae865aeb.var_303ce84a)) {
      var_3b88de0c = var_ae865aeb.var_303ce84a;
    }

    e_interact util::create_cursor_hint("tag_origin", (0, 0, 0), var_3b88de0c, 40, undefined, undefined, undefined, 150);
    e_interact thread arcade_machine::function_bafc791c();
    util::waittill_any_ents_two(level, #"flg_arcade_end_gundown", e_interact, "trigger");
    e_interact util::delay(0.2, undefined, &util::remove_cursor_hint);

    if(level flag::get("flg_arcade_end_gundown")) {
      break;
    }

    wait 0.5;
    level thread namespace_4bd68414::arcade_woods_play_game_start_dialogue();
    self arcade_machine::play();
    snd::client_msg("flg_arcade_emulator_start");
    self arcade_machine::function_71510186();
    self arcade_machine::exit();
    snd::client_msg("flg_arcade_emulator_stop");
    level thread namespace_4bd68414::arcade_woods_play_game_end_dialogue();
  }

  e_interact util::remove_cursor_hint();
  e_interact delete();
}