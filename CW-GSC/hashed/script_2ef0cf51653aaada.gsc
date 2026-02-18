/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2ef0cf51653aaada.gsc
***********************************************/

#using script_1b9f100b85b7e21d;
#using script_1d21191fa6d656cf;
#using script_3b2905ec05ed796;
#using script_3dc93ca9902a9cda;
#using script_498cf7685befe7bf;
#using script_77f51076c7c89596;
#using script_e3ec3024527fc15;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\districts;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\player_decision;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#namespace namespace_ce17746;

function starting(str_objective) {
  level flag::set("level_intro_nuke_checkpoint");
  level.allowbattlechatter[# "allies"] = 0;
  level.allowbattlechatter[# "axis"] = 0;
  snd::client_msg("audio_level_begin_duck_start");
  namespace_534279a::spawn_allies();
  namespace_604e2e22::function_3b9e7104();
  level.var_77be18d2 = vehicle::simple_spawn_single("player_fav");
  a_vehicles = vehicle::simple_spawn("veh_town");
  array::run_all(a_vehicles, &val::set, #"intro", "ignoreme", 0);
  level.var_7b278a4f = vehicle::simple_spawn_single("ally_fav_left");
  level.var_5d798cf2 = vehicle::simple_spawn_single("ally_fav_right");
  level.var_82e50b77 = vehicle::simple_spawn_single("redshirt_fav");
  level util::function_3e65fe0b(1);
  level thread namespace_604e2e22::function_1e2a0690("aa_courtyard", "courtyard_aa_gunner", "scene_sge_0000_ambient_aa_gun");
}

function main(str_objective, var_50cc0d4f) {
  level.player clientfield::set_to_player("stream_intro_assets", 1);
  savegame::checkpoint_save();
  setDvar(#"hash_6f9f3341a7820247", 0.2);
  namespace_95f223d5::music("1.0_approach");
  snd::client_msg("audio_intro_triton_disable");
  level globallogic_ui::function_7bc0e4b9();
  exploder::exploder("fxexp_env_fx_set_courtyard");
  level util::create_streamer_hint((7833.92, -3391.2, 161.25), (0, 200, 0), 0.5);

  if(isDefined(getDvar(#"hash_2fb8df40cf115959")) && getDvar(#"hash_2fb8df40cf115959") != 0) {
    var_8105a86b = vehicle::simple_spawn_single("<dev string:x38>");
    var_8105a86b.origin = (-12110, 15073, 1127);
    var_8105a86b.angles = (0, -38, 0);
    var_8105a86b usevehicle(level.player, 0);
    setlightingstate(1);

    while(!level.player actionslotonebuttonPressed() && !level.player actionslottwobuttonPressed() && !level.player actionslotthreebuttonPressed() && !level.player actionslotfourbuttonPressed()) {
      waitframe(1);

      if(level.player actionslotonebuttonPressed()) {
        level.player.var_e5c643e6 = 1;
      }

      if(level.player actionslottwobuttonPressed()) {
        level.player.var_e5c643e6 = 2;
      }

      if(level.player actionslotthreebuttonPressed()) {
        level.player.var_e5c643e6 = 3;
      }

      if(level.player actionslotfourbuttonPressed()) {
        level.player.var_e5c643e6 = 4;
      }
    }
  }

  level flag::set("flg_intro_ride_in_progress");
  level thread function_91d00da9();
  level.var_77be18d2 thread vehicle::lights_on();
  level thread intro_objectives();
  level thread function_4665de46();
  level thread function_c08c908f();
  level thread function_9f7b1c2();
  level thread namespace_604e2e22::function_4a3de7f5("infil");
  e_player = getplayers()[0];
  e_player districts::function_930f8c81("interior_cathedral_01");
  level.var_7b278a4f thread vehicle::lights_on();
  level.var_5d798cf2 thread vehicle::lights_on();
  level.var_82e50b77 thread vehicle::lights_on();
  level.var_82e50b77 val::set(#"hash_8a59e6b78571c5a", "ignoreme", 1);
  level.var_82e50b77.overridevehicledamage = &fav::damage_override;

  if(isDefined(getDvar(#"hash_2fb8df40cf115959")) && getDvar(#"hash_2fb8df40cf115959") != 0) {
    switch (level.player.var_e5c643e6) {
      case 1:
        level.var_77be18d2 delete();
        break;
      case 3:
        level.var_7b278a4f delete();
        break;
      case 4:
        level.var_5d798cf2 delete();
        break;
    }
  }

  level thread function_ee43d0f7();
  level thread function_53c16fe1();
  scene::function_27f5972e("p9_fxanim_cp_siege_watch_tower_destruction_bundle");
  scene::function_27f5972e("p9_fxanim_cp_siege_wood_gate_bundle");
  level waittill(#"hash_42baa5404bc46f9c");
  namespace_1512c89a::function_ff11843e();
  level.player clientfield::set_to_player("stream_intro_assets", 0);
  wait 1;
  setDvar(#"hash_6f9f3341a7820247", 1.8);
  level flag::wait_till("flg_emp_blast");
  level util::function_3e65fe0b(0);
  skipto::function_4e3ab877("infil");
}

function cleanup(str_objective, var_50cc0d4f, var_aa1a6455, player) {}

function intro_objectives() {
  level waittill(#"hash_34379201e08ecdef");
  objectives::set(#"cp_scripted", undefined, undefined, #"hash_62624188ae803d4f", #"hash_4e609fa5c5db92c2");
}

function function_4665de46() {
  level waittill(#"hash_48ade2ded2e42ff3");
  var_25418acc = level.player player_decision::function_1c4fb6d4();

  switch (var_25418acc) {
    case 1:
      level.woods thread hms_util::dialogue("vox_cp_seig_01000_wood_nowayimmissingt_27", 1);
      break;
    case 0:
      level.woods thread hms_util::dialogue("vox_cp_seig_01000_wood_nowayimmissingt_93", 1);
      break;
    case 2:
      level.woods thread hms_util::dialogue("vox_cp_seig_01000_wood_nowayimmissingt_56", 1);
      break;
    default:

      iprintlnbold("<dev string:x46>");

      break;
  }
}

function function_91d00da9() {
  level notify(#"hash_6c0d7373e8865c90");
  level endon(#"hash_6c0d7373e8865c90", #"game_ended");
  level flag::wait_till("flg_intro_ride_in_progress");
  level flag::wait_till(#"gameplay_started");
  wait 0.5;
  level.player playrumblelooponentity("fallwind_loop_slow");
  level waittill(#"hash_465d6bb5960c37f8");
  level flag::clear("flg_intro_ride_in_progress");
  level.player stoprumble("fallwind_loop_slow");
}

function function_c08c908f() {
  level waittill(#"hash_4857742ef12d250c");
  earthquake(0.6, 2.5, level.player.origin, 1000);
  level.player playrumbleonentity("damage_heavy");
  var_2354baae = (-148, 5446, 123);
  snd::client_msg("evt_emp_blast_screenshake");
}

function function_9f7b1c2() {
  level waittill(#"hash_7375d56c49712b45");
  exploder::exploder("fxexp_nuke_shockwave");
  snd::client_msg("evt_emp_blast_shockwave");
}

function function_ee43d0f7() {
  var_d558e027 = struct::get_array("watch_tower_destruction", "targetname");

  foreach(var_7f05924f in var_d558e027) {
    bottom_right = getent(var_7f05924f.target, "targetname");
    bottom_left = getent(bottom_right.target, "targetname");
    top_right = getent(bottom_left.target, "targetname");
    top_middle = getent(top_right.target, "targetname");
    top_left = getent(top_middle.target, "targetname");
    var_6848a619 = getent(top_left.target, "targetname");
    var_b683c71b = getent(var_6848a619.target, "targetname");
    var_6be00677 = getent(var_b683c71b.target, "targetname");
    var_cdc34ef0 = getent(var_6be00677.target, "targetname");
    var_4b1bea26 = getent(var_cdc34ef0.target, "targetname");
    var_129bc7c3 = getent(var_4b1bea26.target, "targetname");
    var_404e7179 = getent(var_129bc7c3.target, "targetname");
    var_53b5b6c5 = getent(var_404e7179.target, "targetname");
    bottom_right.scene = var_7f05924f;
    bottom_right.trigger1 = bottom_left;
    bottom_right.trigger2 = top_right;
    bottom_right.var_fd38508 = top_middle;
    bottom_right.var_1e132187 = top_left;
    bottom_right.location = "bottom_right";
    bottom_right.floor = var_6848a619;
    bottom_right.var_b683c71b = var_b683c71b;
    bottom_right.var_6be00677 = var_6be00677;
    bottom_right.var_cdc34ef0 = var_cdc34ef0;
    bottom_right.var_4b1bea26 = var_4b1bea26;
    bottom_right.var_129bc7c3 = var_129bc7c3;
    bottom_right.var_404e7179 = var_404e7179;
    bottom_right.var_53b5b6c5 = var_53b5b6c5;
    bottom_left.scene = var_7f05924f;
    bottom_left.trigger1 = bottom_right;
    bottom_left.trigger2 = top_right;
    bottom_left.var_fd38508 = top_middle;
    bottom_left.var_1e132187 = top_left;
    bottom_left.location = "bottom_left";
    bottom_left.floor = var_6848a619;
    bottom_left.var_b683c71b = var_b683c71b;
    bottom_left.var_6be00677 = var_6be00677;
    bottom_left.var_cdc34ef0 = var_cdc34ef0;
    bottom_left.var_4b1bea26 = var_4b1bea26;
    bottom_left.var_129bc7c3 = var_129bc7c3;
    bottom_left.var_404e7179 = var_404e7179;
    bottom_left.var_53b5b6c5 = var_53b5b6c5;
    top_right.scene = var_7f05924f;
    top_right.trigger1 = bottom_right;
    top_right.trigger2 = bottom_left;
    top_right.var_fd38508 = top_middle;
    top_right.var_1e132187 = top_left;
    top_right.location = "top_right";
    top_right.floor = var_6848a619;
    top_right.var_b683c71b = var_b683c71b;
    top_right.var_6be00677 = var_6be00677;
    top_right.var_cdc34ef0 = var_cdc34ef0;
    top_right.var_4b1bea26 = var_4b1bea26;
    top_right.var_129bc7c3 = var_129bc7c3;
    top_right.var_404e7179 = var_404e7179;
    top_right.var_53b5b6c5 = var_53b5b6c5;
    top_middle.scene = var_7f05924f;
    top_middle.trigger1 = bottom_right;
    top_middle.trigger2 = bottom_left;
    top_middle.var_fd38508 = top_right;
    top_middle.var_1e132187 = top_left;
    top_middle.location = "top_middle";
    top_middle.floor = var_6848a619;
    top_middle.var_b683c71b = var_b683c71b;
    top_middle.var_6be00677 = var_6be00677;
    top_middle.var_cdc34ef0 = var_cdc34ef0;
    top_middle.var_4b1bea26 = var_4b1bea26;
    top_middle.var_129bc7c3 = var_129bc7c3;
    top_middle.var_404e7179 = var_404e7179;
    top_middle.var_53b5b6c5 = var_53b5b6c5;
    top_left.scene = var_7f05924f;
    top_left.trigger1 = bottom_right;
    top_left.trigger2 = bottom_left;
    top_left.var_fd38508 = top_right;
    top_left.var_1e132187 = top_middle;
    top_left.location = "top_left";
    top_left.floor = var_6848a619;
    top_left.var_b683c71b = var_b683c71b;
    top_left.var_6be00677 = var_6be00677;
    top_left.var_cdc34ef0 = var_cdc34ef0;
    top_left.var_4b1bea26 = var_4b1bea26;
    top_left.var_129bc7c3 = var_129bc7c3;
    top_left.var_404e7179 = var_404e7179;
    top_left.var_53b5b6c5 = var_53b5b6c5;
    bottom_right thread function_2e153a87();
    bottom_left thread function_2e153a87();
    top_right thread function_2e153a87();
    top_middle thread function_2e153a87();
    top_left thread function_2e153a87();
  }
}

function function_2e153a87() {
  self endon(#"death");
  s_rpg_origin = struct::get("s_rpg_origin", "targetname");
  e_vignette_tower_volume = getent("e_vignette_tower_volume", "targetname");

  while(true) {
    s_results = self waittill(#"damage");

    if(istouching(s_results.position, e_vignette_tower_volume) && !level flag::get("flg_wall_rpg_magic_bullet")) {
      continue;
    }

    var_947d01ee = s_results.weapon.weapclass;

    switch (var_947d01ee) {
      case # "grenade":
        level.player.var_ee4032c4 = (isDefined(level.player.var_ee4032c4) ? level.player.var_ee4032c4 : 0) + 1;
        snd::play("evt_tower_explo", self);
        self function_b1cd831c();
        return;
      case # "rocketlauncher":
        self function_b1cd831c();
        return;
      default:
        break;
    }
  }
}

function function_b1cd831c() {
  self endon(#"death");
  self.trigger1 delete();
  self.trigger2 delete();
  self.var_fd38508 delete();
  self.var_1e132187 delete();
  self.floor delete();
  self.var_b683c71b delete();
  self.var_6be00677 delete();
  self.var_cdc34ef0 delete();
  self.var_4b1bea26 delete();
  self.var_129bc7c3 delete();
  self.var_404e7179 delete();
  self.var_53b5b6c5 delete();
  physicsexplosionsphere(self.origin + (0, 0, 0), 50, 1, 4);
  a_ai = getaiteamarray("axis");

  foreach(ai in a_ai) {
    if(distance2dsquared(self.origin, ai.origin) < 22500) {
      ai delete();
    }
  }

  a_vh = getEntArray("intro_mg", "targetname");

  foreach(vh in a_vh) {
    if(distance2dsquared(self.origin, vh.origin) < 22500) {
      vh delete();
    }
  }

  var_fb90e03a = getEntArray("emp_mg_objective_1", "targetname");
  var_fb90e03a = arraycombine(var_fb90e03a, getEntArray("emp_mg_objective_2", "targetname"));
  var_fb90e03a = arraycombine(var_fb90e03a, getEntArray("emp_mg_objective_3", "targetname"));
  var_fb90e03a = arraysortclosest(var_fb90e03a, self.origin);
  var_fb90e03a[0] notify(#"hash_690490dc48ae49b8");
  self.scene notify(#"death");
  location = self.location;
  self thread function_6943404();
  self.scene scene::play("play_" + location);
  self.scene scene::play("outro_" + location);
}

function function_6943404() {
  waitframe(3);
  self delete();
}

function function_53c16fe1() {
  var_d10853ff = getent("wood_gate_trigger", "targetname");
  var_d10853ff trigger::wait_till();
  scene::play_from_time("p9_fxanim_cp_siege_wood_gate_bundle", "play");
}