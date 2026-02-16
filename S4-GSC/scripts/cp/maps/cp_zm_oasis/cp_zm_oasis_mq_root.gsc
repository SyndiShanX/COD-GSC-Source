/***************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_root.gsc
***************************************************************/

init() {
  level thread setup_mq_trial_block();
  set_altar_clip(0);
  set_portal_clip(0);

  if(!getdvarint("#x3a165e78de6483fc8", 0) == 1) {
    return;
  }
  _id_099C::_id_C211("ossmq", 1, ::init_charge_mirror, ::do_charge_mirror, ::cleanup_charge_mirror, ::debug_charge_mirror);
  _id_099C::_id_C211("ossmq", 2, ::init_free_ktfx, ::do_free_ktfx, ::cleanup_free_ktfx, ::debug_free_ktfx);
  _id_099C::_id_C211("ossmq", 3, ::init_first_visit_ktfx, ::do_first_visit_ktfx, ::cleanup_first_visit_ktfx, ::debug_first_visit_ktfx);
  _id_099C::_id_C211("ossmq", 4, ::init_trails, ::do_trails, ::cleanup_trails, ::debug_trails);
  _id_099C::_id_C211("ossmq", 5, ::init_to_the_end, ::do_to_the_end, ::cleanup_to_the_end, ::debug_to_the_end);
  level._effect["mq_portal_red"] = loadfx("vfx/s4/zombie/vfx_hub_portal_variant");
  level._effect["mq_mud_splash"] = loadfx("vfx/s4/level/cp_sumpf/vfx_mud_body_splash");
  level._effect["mq_mirror_ambient_uncharged_fx"] = loadfx("vfx/s4/zombie/vfx_ghost_mirror_broken_ambient");
  level._effect["mq_mirror_ambient_charged_fx"] = loadfx("vfx/s4/zombie/vfx_ghost_mirror_smk_blue");
  level._effect["mq_trial_obelisk"] = loadfx("vfx/s4/zombie/vfx_obj_sin_eater_obelisk_idle.vfx");
  level._effect["mq_trial_obelisk_charged"] = loadfx("vfx/s4/zombie/vfx_obj_sin_eater_obelisk_activate.vfx");
  level._effect["mq_trial_obelisk_arrive"] = loadfx("vfx/s4/zombie/vfx_obj_sin_eater_obelisk_move_arrive.vfx");
  level._effect["mq_trial_obelisk_depart"] = loadfx("vfx/s4/zombie/vfx_obj_sin_eater_obelisk_move_depart.vfx");
  level._effect["mq_trial_obelisk_destroy"] = loadfx("vfx/s4/zombie/vfx_obj_sin_eater_obelisk_destroy.vfx");
  level._effect["mq_mirror_despawn_fx"] = loadfx("vfx/s4/zombie/vfx_ghost_mirror_show");
  level._effect["mq_scepter_despawn_fx"] = loadfx("vfx/s4/level/cp_zod/vfx_mq_tome_page_shield_destroy");
  level._effect["mq_scepter_amb_fx_lrg"] = loadfx("vfx/s4/zombie/vfx_scepter_enhanced_ambient");
  level._effect["mq_ktfx_showup_fx"] = loadfx("vfx/s4/zombie/vfx_kortifex_emerge");
  level._effect["mq_ktfx_disappear_fx"] = loadfx("vfx/s4/zombie/vfx_kortifex_disappear");
  level._effect["mq_ktfx_charging_fx"] = loadfx("vfx/s4/zombie_ai/vfx_boss_fight_absorb_energy_smk");
  level._effect["mq_construct_pulse"] = loadfx("vfx/s4/level/cp_zm_oasis/vfx_construct_red_vein_os");
  level._effect["mq_portal_lock_a"] = loadfx("vfx/s4/zombie/vfx_barrier_blocking_a");
  level._effect["mq_portal_lock_b"] = loadfx("vfx/s4/zombie/vfx_barrier_blocking_b");
  level._effect["mq_portal_lock_c"] = loadfx("vfx/s4/zombie/vfx_barrier_blocking_c");
  level._effect["mq_trial_b_charge_trail"] = loadfx("vfx/s4/zombie/vfx_beam_connect_taril_r.vfx");
  level._effect["mq_trial_b_zombie_soul_trail"] = loadfx("vfx/s4/zombie/vfx_soul_charge_r.vfx");
  level._effect["mq_trial_b_orb"] = loadfx("vfx/s4/zombie/vfx_energy_orb_runner_r.vfx");
  level._effect["mq_trial_b_orb_spawn"] = loadfx("vfx/s4/zombie/vfx_energy_orb_spawn_r.vfx");
  level._effect["mq_trial_b_orb_charge"] = loadfx("vfx/s4/zombie/vfx_obelisk_energy_charge_r.vfx");
  level._effect["mq_trial_b_torch"] = loadfx("vfx/s4/level/cp_zm_oasis/vfx_fire_torch.vfx");
  level._effect["mq_trial_b_stone"] = loadfx("vfx/s4/level/cp_sumpf/vfx_stone_glow_ambient.vfx");
  level._effect["mq_trial_b_stone_spawn"] = loadfx("vfx/s4/level/cp_sumpf/vfx_stone_spawn.vfx");
  level._effect["mq_trial_c_orb"] = loadfx("vfx/s4/zombie/vfx_energy_orb_runner_r.vfx");
  level._effect["mq_trial_c_orb_spawn"] = loadfx("vfx/s4/zombie/vfx_energy_orb_spawn_r.vfx");
  level._effect["mq_trial_c_orb_charge"] = loadfx("vfx/s4/zombie/vfx_obelisk_energy_charge_r.vfx");
  level._effect["mq_trial_c_zombie_soul_trail"] = loadfx("vfx/s4/zombie/vfx_soul_charge_r.vfx");
  level._effect["mq_trial_c_cursed_item_idle"] = loadfx("vfx/s4/level/cp_zm_oasis/vfx_cursed_items_idle.vfx");
  level._effect["mq_trial_c_cursed_item_spawn"] = loadfx("vfx/s4/level/cp_zm_oasis/vfx_cursed_items_respawn.vfx");
  level._effect["mq_trial_c_cursed_item_screen"] = loadfx("vfx/s4/zombie/vfx_screen_cursed.vfx");
  level._effect["mq_trial_c_hand_idle"] = loadfx("vfx/s4/zombie/vfx_crystal_hand_shield_idle.vfx");
  level._effect["mq_trial_c_shield_active"] = loadfx("vfx/s4/zombie/vfx_shield_demonic_activate.vfx");
  level._effect["mq_trial_c_shield_charged"] = loadfx("vfx/s4/zombie/vfx_shield_orb_trail_y.vfx");
  level._effect["mq_trial_c_shield_drop"] = loadfx("vfx/s4/level/cp_sumpf/vfx_mud_body_splash.vfx");
  level._effect["mq_trial_c_syphoncore_idle"] = loadfx("vfx/s4/zombie/vfx_ritual_idle.vfx");
  level._effect["mq_trial_c_syphoncore_active"] = loadfx("vfx/s4/zombie/vfx_ritual_idle_mouth.vfx");
  level._effect["mq_trial_c_syphoncore_destroy"] = loadfx("vfx/s4/zombie/vfx_kortifex_disappear.vfx");
  level._effect["mq_trial_c_fountain_full"] = loadfx("vfx/s4/zombie/vfx_perk_fountain_liquid_drop.vfx");
  level._effect["mq_trial_c_fountain_half"] = loadfx("vfx/s4/zombie/vfx_perk_fountain_liquid_drop_sml.vfx");
  level._effect["mq_trial_c_fountain_surface"] = loadfx("vfx/s4/zombie/vfx_perk_fountain_liquid_surface.vfx");
  level._effect["mq_gauntlet_screen"] = loadfx("vfx/s4/zombie/vfx_screen_challenge");
  level._effect["mq_trial_obelisk_success"] = loadfx("vfx/s4/zombie/vfx_obelisk_energy_charge_ambient");
  level._effect["mq_extra_spawned_zombie"] = loadfx("vfx/s4/zombie/vfx_ritual_sacrificing.vfx");
}

setup_mq_trial_block() {
  level endon("game_ended");
  scripts\engine\utility::_id_5C24("introscreen_over");
  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_a::trial_a_wall_block();
  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_a::trial_a_oblesik_clip();
  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::trial_b_init_clip();
  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_c::trial_c_init_clip();
}

init_charge_mirror() {
  var_0 = scripts\engine\utility::getstruct("mq_altar_start_loc", "script_noteworthy");
  level.mdl_altar = scripts\cp\utility::_id_E190("s4_zm_blood_altar_sand", var_0.origin, var_0.angles);
  level.n_mirror_charge_kills = 0;
  level.n_mirror_charge_requirement = 0;
  level.mdl_fake_mirror = scripts\cp\utility::_id_E190("s4_zm_bronze_mirror_full_break", var_0.origin);
}

do_charge_mirror() {
  level waittill("papq_is_done");
  level.mdl_altar altar_rise();
  _id_0737::_id_C266("mq_altar_interact", undefined, ::on_interact_altar);
  level._id_835D["mq_altar_interact"] = &"CP_ZM_OASIS/MQ_PLACE_MIRROR";
  level waittill("mq_step_one_done");
}

cleanup_charge_mirror() {}

debug_charge_mirror() {
  level notify("papq_is_done");
  waitframe();
  level notify("debug_force_quit");
  waitframe();
  level notify("mq_step_one_done");
}

altar_rise() {
  level endon("game_ended");
  level endon("mq_step_one_done");
  level endon("debug_force_quit");
  wait 5;
  var_0 = scripts\engine\utility::getstruct("mq_altar_end_loc", "script_noteworthy");
  thread altar_rise_vfx();
  thread altar_rise_sfx();
  thread altar_rise_cam_shake_and_rumble();
  set_altar_clip(1);
  self moveto(var_0.origin, 6, 0, 0);
  self waittill("movedone");
  level play_vo_altar_revealed();
}

altar_rise_vfx() {
  level endon("game_ended");
  level endon("mq_step_one_done");
  level endon("debug_force_quit");
  self endon("movedone");

  for(;;) {
    playFX(level._effect["mq_mud_splash"], self.origin);
    wait 0.75;
  }
}

altar_rise_sfx() {
  level endon("game_ended");
  level endon("mq_step_one_done");
  level endon("debug_force_quit");
  self endon("movedone");
  scripts\cp\utility::_id_B8EF("zmb_podium_rise", self.origin);
}

altar_rise_cam_shake_and_rumble() {
  level endon("game_ended");
  level endon("mq_step_one_done");
  level endon("debug_force_quit");
  self endon("movedone");

  for(;;) {
    foreach(var_1 in level.players) {
      var_2 = distance2dsquared(level.mdl_altar.origin, var_1.origin);

      if(var_2 <= _func_0219(500)) {
        var_1 earthquakeforplayer(0.3, 0.5, var_1.origin, 100);
        var_1 _meth_827A("cp_zm_s2_mq_shield_rumble", var_1.origin);
      }
    }

    wait 0.3;
  }
}

on_interact_altar(var_0, var_1) {
  scripts\engine\utility::_id_5C1B("force_cut_exfil_vo");
  level thread set_up_mirror_model();
  level.skip_endgame_vo = 1;
  scripts\cp\utility::_id_B8EF("zmb_place_mirror", level.mdl_mirror.origin);
  _id_0737::_id_C4AB("mq_altar_interact");

  if(scripts\engine\utility::_id_5C00("round_spawn_zombies")) {
    scripts\engine\utility::_id_5C04("round_spawn_zombies");
  }

  var_2 = _id_06FE::_id_6322();

  foreach(var_4 in var_2) {
    var_4 _meth_81FA();
  }

  wait 1;
  level play_vo_mirror_placed();
  level notify("mq_step_one_done");
}

set_up_mirror_model() {
  level endon("game_ended");
  level endon("mq_step_one_done");
  level.mdl_mirror = scripts\cp\utility::_id_E190("s4_zm_bronze_mirror_full_break", level.mdl_altar.origin + (0, 0, 65), level.mdl_altar.angles + (0, 0, 90));
  level.mdl_mirror _meth_82CB("s4_zm_bronze_mirror_combine_idle_01");
  level.mdl_mirror.mdl_fx = scripts\cp\utility::_id_E190("tag_origin", level.mdl_mirror.origin, level.mdl_mirror.angles + (0, 0, 90));
  level.mdl_mirror.mdl_fx linkto(level.mdl_mirror);
  waitframe();
  playFX(level._effect["mq_mirror_despawn_fx"], level.mdl_mirror.origin);
  waitframe();
  playFXOnTag(level._effect["mq_mirror_ambient_uncharged_fx"], level.mdl_mirror.mdl_fx, "tag_origin");
  level.mdl_fake_mirror delete();
}

fadetowhite(var_0, var_1) {
  level endon("game_ended");
  level notify("FadeToWhite_singleton");
  level endon("FadeToWhite_singleton");
  _func_01EA("ui_total_fade_color", 1);

  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }
    level thread scripts\cp_mp\utility\game_utility::_id_58C7(var_3, 1, var_0);
  }

  wait(scripts\cp\utility::_id_459B(var_1, var_0 + 0.3));

  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }
    level thread scripts\cp_mp\utility\game_utility::_id_58C7(var_3, 0, var_0);
  }

  wait(var_0 + 0.3);
  _func_01EA("ui_total_fade_color", 0);
}

set_up_zombie_spawning(var_0, var_1) {
  var_2 = level.players.size;
  var_3 = [6, 6, 5, 5];
  var_4 = [8, 8, 6, 6];
  var_5 = [15, 15, 12, 12];
  var_6 = [7, 10, 13, 16];
  var_7 = [1, 2, 3, 4];
  var_8 = [1, 1, 1, 1];
  var_9 = [1, 1, 2, 2];
  var_10 = scripts\engine\utility::getStructArray(var_0, "script_noteworthy");
  level thread spawn_zombie("base", "enemy_base_zombie_cp", var_3[var_2 - 1], var_6[var_2 - 1], undefined, var_1, var_10, var_10);
  level thread spawn_zombie("screamer", "enemy_zombie_screamer_cp", var_4[var_2 - 1], var_7[var_2 - 1], undefined, var_1, var_10, var_10);
  level thread spawn_zombie("juggernaut", "enemy_zombie_juggernaut_cp", var_5[var_2 - 1], var_8[var_2 - 1], var_9[var_2 - 1], var_1, var_10, var_10);
}

spawn_zombie(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("game_ended");
  level endon(var_5);
  var_8 = 0;

  for(;;) {
    if(isDefined(var_4) && var_8 >= var_4) {
      return;
    }
    if(get_alive_zombies_count(var_0) < var_3) {
      if(scripts\engine\utility::is_equal(var_0, "screamer")) {
        var_9 = pick_random_spawner(var_7);
      } else {
        var_9 = pick_random_spawner(var_6);
      }

      playFX(level._effect["zmb_ai_teleport_spawn_in"], var_9.origin);
      waitframe();
      var_10 = _id_09A4::_id_110AD(var_1, var_9.origin, var_9.angles, var_9);
      var_8++;
      wait 0.5;
      var_10.brain_rot_immune = 1;
      var_10._id_4A75 = 1;

      if(isDefined(var_10) && isalive(var_10)) {
        if(scripts\engine\utility::is_equal(var_0, "base")) {
          if(level._id_11049 < 10) {
            var_10[[var_10._id_D603]]("run");
          }
        }

        if(scripts\engine\utility::is_equal(var_0, "juggernaut")) {
          var_10.b_ignore_cleanup = 1;
        }
      }
    }

    wait(var_2);
  }
}

pick_random_spawner(var_0) {
  var_1 = randomint(var_0.size);
  var_2 = var_0[var_1];
  return var_2;
}

get_alive_zombies_count(var_0) {
  var_1 = 0;
  var_2 = _id_06FE::_id_6322();

  foreach(var_4 in var_2) {
    if(scripts\engine\utility::is_equal(var_4._id_110B0, var_0)) {
      var_1++;
    }
  }

  return var_1;
}

on_zombie_killed_s1(var_0) {
  if(isPlayer(var_0._id_50FF) && distance(self.origin, level.mdl_mirror.origin) < 500 && self._id_110B0 == "screamer") {
    level.n_mirror_charge_kills++;

    if(level.n_mirror_charge_kills == level.n_mirror_charge_requirement) {
      level notify("mirror_charge_done");
    }

    level thread send_fx_trail(self gettagorigin("j_spine4"), level.mdl_mirror.origin, "papq_echo_zmb_trail", 500);
  }
}

send_fx_trail(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_4 = distance(var_0, var_1) / var_3;

  if(var_4 <= 0) {
    return;
  }
  var_5 = scripts\cp\utility::_id_E190("tag_origin", var_0);
  waitframe();

  if(!isDefined(level.a_trail_sfx_recorder)) {
    level.a_trail_sfx_recorder = [];
  }

  var_6 = 0;

  if(!scripts\engine\utility::array_contains(level.a_trail_sfx_recorder, var_0)) {
    level.a_trail_sfx_recorder = scripts\engine\utility::array_add(level.a_trail_sfx_recorder, var_0);
    var_5 playLoopSound("zmb_souls_lp");
    var_6 = 1;
  }

  if(isDefined(var_5)) {
    playFXOnTag(level._effect[var_2], var_5, "tag_origin");
    wait 0.2;
    var_5 moveto(var_1, var_4);
    var_5 waittill("movedone");
    wait 2;
  }

  if(isDefined(var_5)) {
    if(var_6) {
      level.a_trail_sfx_recorder = scripts\engine\utility::array_remove(level.a_trail_sfx_recorder, var_0);
    }

    _func_0130(var_5);
    var_5 delete();
  }
}

set_altar_clip(var_0) {
  var_1 = getent("mq_altar_clip", "script_noteworthy");

  if(istrue(var_0)) {
    var_1 solid();
    var_1 _meth_80B5();
  } else {
    var_1 notsolid();
    var_1 _meth_8093();
  }
}

set_portal_clip(var_0) {
  var_1 = getent("mq_1st_portal_col", "script_noteworthy");

  if(istrue(var_0)) {
    var_1 solid();
    var_1 _meth_80B5();
  } else {
    var_1 notsolid();
    var_1 _meth_8093();
  }
}

play_vo_altar_revealed() {
  level endon("end_game");

  if(istrue(level._id_493C)) {
    level waittill("dialogue_finished");
  }

  var_0 = ["zm_cpm5_mqs5_dnrt_qiaa", "zm_cpm5_mqs5_dnrt_qiab", "zm_cpm5_mqs5_dnrt_qiac", "zm_cpm5_mqs5_dnrt_qiad"];
  level thread _id_0720::play_narrations(scripts\engine\utility::random(var_0), 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");
}

play_vo_mirror_placed() {
  level endon("end_game");

  if(istrue(level._id_493C)) {
    level waittill("dialogue_finished");
  }

  var_0 = ["zm_cpm5_mqs5_dnvk_qiam", "zm_cpm5_mqs5_dnvk_qian", "zm_cpm5_mqs5_dnvk_qiao", "zm_cpm5_mqs5_dnvk_qiap"];
  level thread _id_0720::play_narrations(scripts\engine\utility::random(var_0), 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");
  var_0 = ["zm_cpm5_mqs5_vlst_qiaq", "zm_cpm5_mqs5_vlst_qiar", "zm_cpm5_mqs5_vlst_qias", "zm_cpm5_mqs5_vlst_qiat"];
  level thread _id_0720::play_narrations(scripts\engine\utility::random(var_0), 1, 0, "force_quit_current_dialogue");
  scripts\cp\utility::_id_B8EF("zmb_vign_mirror_pre", level.mdl_mirror.origin);
  level waittill("dialogue_finished");
}

init_free_ktfx() {
  level thread ktfx_show_up();
  reveal_pap_in_dark_aether();
}

do_free_ktfx() {
  level waittill("mq_step_two_done");
}

cleanup_free_ktfx() {
  if(!scripts\engine\utility::_id_5C00("round_spawn_zombies")) {
    scripts\engine\utility::_id_5C1B("round_spawn_zombies");
  }
}

debug_free_ktfx() {
  level endon("game_ended");
  level notify("debug_force_quit");
  waitframe();
  level notify("mq_step_two_done");
  waitframe();
  var_0 = scripts\engine\utility::getstruct("mq_1st_portal_loc", "script_noteworthy");
  level thread do_interact_1st_portal(var_0);
}

ktfx_show_up() {
  level endon("game_ended");
  level endon("mq_step_two_done");
  self endon("death");
  level endon("debug_force_quit");
  _func_01E3("kortifex_vignette");
  stopFXOnTag(level._effect["mq_mirror_ambient_uncharged_fx"], level.mdl_mirror.mdl_fx, "tag_origin");
  waitframe();
  playFXOnTag(level._effect["mq_mirror_ambient_charged_fx"], level.mdl_mirror.mdl_fx, "tag_origin");
  scripts\cp\utility::_id_B8EF("zmb_vign_mirror", level.mdl_mirror.origin);
  level play_vo_ktfx_vlist_scream();
  wait 1;

  if(istrue(level._id_493C)) {
    level waittill("dialogue_finished");
  }

  if(isDefined(level.mdl_mirror) && isDefined(level.mdl_mirror.mdl_fx)) {
    stopFXOnTag(level._effect["mq_mirror_ambient_charged_fx"], level.mdl_mirror.mdl_fx, "tag_origin");
    playFX(level._effect["mq_mirror_despawn_fx"], level.mdl_mirror.origin);
    level.mdl_mirror.mdl_fx delete();
    level.mdl_mirror delete();
  }

  var_0 = scripts\engine\utility::getstruct("mq_ktfx_spawn_loc", "script_noteworthy");
  playFX(level._effect["mq_scepter_despawn_fx"], var_0.origin);
  level.mdl_scepter = scripts\cp\utility::_id_E190("s4_zm_scepter_rig", var_0.origin, var_0.angles);
  level.mdl_scepter _meth_82CB("s4_zm_scepter_01", "scepter_showup");
  level thread play_vo_scepter_appear();
  level.mdl_scepter waittillmatch("scepter_showup", "start_spin");
  scripts\cp\utility::_id_B8EF("zmb_vign_scepter_spin", level.mdl_scepter.origin);
  playFXOnTag(level._effect["mq_scepter_amb_fx_lrg"], level.mdl_scepter, "tag_scepter_move");
  level.mdl_scepter waittillmatch("scepter_showup", "finish");
  stopFXOnTag(level._effect["mq_scepter_amb_fx_lrg"], level.mdl_scepter, "tag_scepter_move");
  waitframe();
  playFX(level._effect["mq_scepter_despawn_fx"], level.mdl_scepter.origin);
  level.mdl_scepter delete();
  playFX(level._effect["mq_ktfx_showup_fx"], var_0.origin);
  waitframe();
  level.mdl_ktfx = scripts\cp\utility::_id_E190("c_s4_zmb_kortifex", var_0.origin + (0, 0, -50), var_0.angles + (0, -90, 0));
  level.mdl_ktfx _meth_82CB("ai_s4_zm_zombie_Kortifex_Vignette_01", "ktfx_free");
  level.mdl_ktfx playLoopSound("zmb_amb_kortifex_lp");
  level.t_dmg_ktfx_s2 = getent("t_dmg_ktfx_step_two", "script_noteworthy");
  level.t_dmg_ktfx_s2 thread ktfx_dmg_watcher("mq_step_two_done");
  level thread play_vo_ktfx_liberation_dialogue();
  level.mdl_ktfx waittillmatch("ktfx_free", "free");
  level.mdl_ktfx waittillmatch("ktfx_free", "finish");
  scripts\cp\utility::_id_B8EF("zmb_vign_kortifex_disappear", level.mdl_ktfx.origin);
  level.mdl_ktfx stoploopsound("zmb_amb_kortifex_lp");
  playFX(level._effect["mq_ktfx_disappear_fx"], level.mdl_ktfx.origin + (0, 0, 50));
  level.mdl_ktfx delete();
  wait 2;
  _func_01E3("none");
  _id_0737::_id_C266("mq_1st_portal_loc", ::hint_interact_1st_portal, ::on_interact_1st_portal, ::init_interact_1st_portal);
  _id_0737::addinteractionhinttypecallback("mq_1st_portal_loc", ::hint_type_1st_portal);
  level.t_dmg_ktfx_s2 delete();
  level notify("mq_step_two_done");
}

do_bob(var_0, var_1, var_2) {
  level endon("game_ended");

  if(isDefined(var_0)) {
    level endon(var_0);
  }

  self endon("death");
  var_3 = self.origin + (0, 0, var_2);
  var_4 = self.origin - (0, 0, var_2);

  for(;;) {
    self moveto(var_3, var_1, 0, 0);
    self waittill("movedone");
    self moveto(var_4, var_1, 0, 0);
    self waittill("movedone");
  }
}

force_check_health_bar(var_0) {
  if(isDefined(var_0)) {
    var_1 = vectornormalize(var_0.origin - self.origin);
    var_2 = self getplayerangles();
    var_3 = anglesToForward(var_2);
    var_4 = vectordot(var_1, var_3);

    if(var_4 > 0.97) {
      _id_072E::_id_FBD5("ui_target_enemy_type", 7);
      _id_072E::_id_FBD5("ui_target_enemy_class", 1);
      _id_072E::_id_FBD5("ui_target_health", 999);
      _id_072E::_id_FBD5("ui_target_max_health", 999);

      if(isDefined(var_0)) {
        _id_072E::_id_FBD5("ui_target_entity_num", var_0 getentitynumber());
      }
    } else
      _id_072E::_id_FBD5("ui_target_entity_num", -1);
  }
}

play_vo_ktfx_vlist_scream() {
  level endon("end_game");

  if(istrue(level._id_493C)) {
    level waittill("dialogue_finished");
  }

  level thread _id_0720::play_narrations("zm_cpm5_mqs5_vlst_qiau", 1, 0, "force_quit_current_dialogue");
  playsoundatpos(level.mdl_mirror.origin, "zm_cpm5_mqs5_krtx_qiaw");
  level waittill("dialogue_finished");
}

play_vo_scepter_appear() {
  level endon("end_game");
  wait 1.5;
  level thread _id_0720::play_narrations("zm_cpm5_mqs5_vlst_qiba", 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narrations(["zm_cpm5_mqs5_krft_qibb", "zm_cpm5_mqs5_krft_qibc"], 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");
}

play_vo_ktfx_liberation_dialogue() {
  level endon("end_game");

  if(istrue(level._id_493C)) {
    level waittill("dialogue_finished");
  }

  level.mdl_ktfx play_sequence_3d_vos(["zm_cpm5_mqs5_krtx_qibd", "zm_cpm5_mqs5_krtx_qibe", "zm_cpm5_mqs5_krtx_qibf", "zm_cpm5_mqs5_vlst_qibg", "zm_cpm5_mqs5_krtx_qibh"]);
  wait 3;
  level thread _id_0720::play_narrations(["zm_cpm5_mqs5_krft_qica", "zm_cpm5_mqs5_vlst_qicb", "zm_cpm5_mqs5_krft_qicc", "zm_cpm5_mqs5_krft_qicd", "zm_cpm5_mqs5_dnrt_qice", "zm_cpm5_mqs5_vlst_qicg", "zm_cpm5_mqs5_vlst_qich", "zm_cpm5_mqs5_krft_qici", "zm_cpm5_mqs5_vlst_qicj", "zm_cpm5_mqs5_vlst_qick", "zm_cpm5_mqs5_vlst_qicl", "zm_cpm5_mqs5_dnrt_qicn", "zm_cpm5_mqs5_dnvk_qico"], 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");
  scripts\engine\utility::_id_5C04("force_cut_exfil_vo");
  scripts\engine\utility::_id_5C1B("mq_da_portal_hint_on");
}

play_sequence_3d_vos(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(issubstr(var_0[var_1], "krtx")) {
      self playSound(var_0[var_1]);
      wait(_id_0720::get_dialogue_length(var_0[var_1]));
      continue;
    }

    _id_0720::play_narration(var_0[var_1]);
  }
}

init_first_visit_ktfx() {
  set_portal_clip(1);
  var_0 = scripts\engine\utility::getstruct("mq_ktfx_loc_da", "script_noteworthy");
  level.mdl_ktfx_da = scripts\cp\utility::_id_E190("c_s4_zmb_kortifex", var_0.origin, var_0.angles);
  level.mdl_ktfx_da _meth_82CB("ai_s4_zm_kortifex_absorb_energy_01");
  level.mdl_ktfx_da.mdl_fx = scripts\cp\utility::_id_E190("tag_origin", level.mdl_ktfx_da.origin + (0, 0, 50), level.mdl_ktfx_da.angles);
  level.mdl_ktfx_da.mdl_fx thread set_up_ktfx_effect();

  foreach(var_2 in level.players) {
    var_2 thread molotov_stuck_check(level.mdl_ktfx_da, "mq_step_three_done");
  }

  level.a_mdl_da_barriers = [];
  var_4 = scripts\engine\utility::getStructArray("mq_magic_barrier_da", "script_noteworthy");

  foreach(var_6 in var_4) {
    var_7 = scripts\cp\utility::_id_E190("vfx_zm_obj_holdout_barrier_mod_bottom_center_56x48", var_6.origin, var_6.angles);
    level.a_mdl_da_barriers = scripts\engine\utility::array_add(level.a_mdl_da_barriers, var_7);
  }

  var_9 = scripts\engine\utility::getStructArray("mq_magic_barrier_rune_da", "script_noteworthy");

  foreach(var_6 in var_9) {
    var_7 = scripts\cp\utility::_id_E190("s4_zm_rune_decal_inviktor", var_6.origin, var_6.angles);
    level.a_mdl_da_barriers = scripts\engine\utility::array_add(level.a_mdl_da_barriers, var_7);
  }

  foreach(var_2 in level.players) {
    var_2 thread handle_player_outofmap();
  }

  level.t_dmg_ktfx = getent("t_dmg_ktfx_sml", "script_noteworthy");
  level.t_dmg_ktfx thread ktfx_dmg_watcher("mq_step_three_done");
}

do_first_visit_ktfx() {
  level waittill("mq_ktfx_fight_done");
  level thread down_all_players();
  var_0 = _id_06FE::_id_6322();

  foreach(var_2 in var_0) {
    var_2 _meth_81FA();
  }

  level waittill("mq_down_player_vo_done");
  level thread teleport_players_back_to_oasis();
  level waittill("mq_step_three_done");
}

cleanup_first_visit_ktfx() {
  foreach(var_1 in level.a_mdl_da_barriers) {
    _func_0130(var_1);
    var_1 delete();
  }

  var_3 = getent("mq_ktfx_fight_fall_check", "script_noteworthy");
  var_3 delete();
  var_4 = getent("mq_ktfx_path_blocker", "script_noteworthy");
  var_4 delete();
  level.set_min_last_stand_wait_override_func = undefined;
  level.self_revive_override_func = undefined;
  level._id_6399 = undefined;
  level.b_force_cut_enter_laststand_vo = 0;
  level.b_force_skip_laststand_shield = 0;
  level.revive_dmg_shield_time_override = undefined;

  foreach(var_6 in level.players) {
    var_6.b_force_laststand = undefined;
    var_6.b_force_block_revive = 0;
  }

  level.b_force_laststand_is_on = undefined;
  _func_0130(level.mdl_ktfx_da.mdl_fx);
  level.mdl_ktfx_da.mdl_fx delete();
  level.mdl_ktfx_da delete();
  level.t_dmg_ktfx delete();
  var_8 = scripts\engine\utility::getstruct("mq_1st_portal_loc", "script_noteworthy");
  var_8.mdl_chain_a_fx = scripts\cp\utility::_id_E190("tag_origin", var_8.origin + (15, 0, 0), var_8.angles + (45, 90, 45));
  var_8.mdl_chain_b_fx = scripts\cp\utility::_id_E190("tag_origin", var_8.origin + (15, 0, 0), var_8.angles + (140, 90, 60));
  var_8.mdl_chain_c_fx = scripts\cp\utility::_id_E190("tag_origin", var_8.origin + (15, 0, 0), var_8.angles + (90, 90, 120));
  playFXOnTag(level._effect["mq_portal_lock_a"], var_8.mdl_chain_a_fx, "tag_origin");
  playFXOnTag(level._effect["mq_portal_lock_b"], var_8.mdl_chain_b_fx, "tag_origin");
  playFXOnTag(level._effect["mq_portal_lock_c"], var_8.mdl_chain_c_fx, "tag_origin");
}

debug_first_visit_ktfx() {
  level notify("mq_ktfx_fight_done");
  waitframe();
  level notify("mq_step_three_done");
}

set_up_ktfx_effect() {
  level endon("game_ended");
  waitframe();
  playFXOnTag(level._effect["mq_ktfx_charging_fx"], self, "tag_origin");
}

force_block_self_revive(var_0) {}

on_interact_1st_portal(var_0, var_1) {
  if(level scripts\engine\utility::_id_5C00("start_rbz_exfil")) {
    return;
  }
  if(!scripts\engine\utility::_id_5C00("return_from_da") && scripts\engine\utility::_id_5C00("mq_da_portal_hint_on")) {
    _id_0737::_id_C3C5(var_0);
    level thread do_vote_first_visit_da(var_0, var_1);
  }
}

init_interact_1st_portal(var_0) {
  foreach(var_2 in var_0) {
    var_3 = scripts\engine\utility::getstruct(var_2._id_CD99, "script_noteworthy");
    var_2.mdl_fx = scripts\cp\utility::_id_E190("tag_origin", var_3.origin, var_3.angles);
    var_2.mdl_portal_img = scripts\cp\utility::_id_E190("vfx_zm_hub_portal_center_dest_oasis_dark_aether", var_3.origin, var_3.angles);
    var_2.mdl_fx thread play_portal_effect();
    scripts\cp\utility::_id_B8EF("zmb_exfil_portal_open", var_2.origin);
    var_2 thread interact_active_watcher();
  }
}

hint_interact_1st_portal(var_0, var_1) {
  if(!scripts\engine\utility::_id_5C00("mq_da_portal_hint_on") || level scripts\engine\utility::_id_5C00("start_rbz_exfil")) {
    return "";
  } else if(scripts\engine\utility::_id_5C00("return_from_da")) {
    return &"CP_ZM_OASIS/MQ_DA_PORTAL_LOCK";
  } else {
    return &"CP_ZM_OASIS/MQ_ENTER_DA";
  }
}

hint_type_1st_portal(var_0, var_1) {
  if(scripts\engine\utility::_id_5C00("return_from_da")) {
    return "HINT_NOBUTTON";
  } else {
    return "HINT_NOICON";
  }
}

interact_active_watcher() {
  level endon("end_game");
  level waittill("mq_step_three_done");
  _id_0737::_id_1037(self);
  level waittill("mq_step_four_done");
  _id_0737::_id_C3C5(self);
}

do_vote_first_visit_da(var_0, var_1) {
  level endon("game_ended");
  var_2 = _id_0992::_id_106AF(var_1, 14, "mq first visit DA start failed");

  if(istrue(var_2)) {
    level thread do_interact_1st_portal(var_0);
    level thread play_vo_enter_portal();
  } else
    _id_0737::_id_1037(var_0);
}

do_interact_1st_portal(var_0) {
  level endon("game_ended");
  level endon("mq_step_three_done");
  level scripts\engine\utility::_id_5C1B("disallow_rbz_exfil");
  _func_01E3("pap_defend");
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  level thread do_teleporting(var_1, level.mdl_ktfx_da.origin, "cp_zm_oasis_drk_tr");
  level waittill("portal_warp_finished");
  level scripts\engine\utility::_id_5C04("disallow_rbz_exfil");

  if(scripts\engine\utility::_id_5C00("round_spawn_zombies")) {
    scripts\engine\utility::_id_5C04("round_spawn_zombies");
  }

  var_2 = _id_06FE::_id_6322();

  foreach(var_4 in var_2) {
    var_4 _meth_81FA();
  }

  level thread ktfx_scene_play_da();
  level thread play_vo_arrive_da();
  level.b_force_laststand_is_on = 1;
  level._id_6399 = ::bleed_out_time_override;
  level.b_force_cut_enter_laststand_vo = 1;
}

bleed_out_time_override() {
  return 60;
}

play_portal_effect() {
  level endon("game_ended");
  level endon("mq_step_three_done");
  waitframe();
  playFXOnTag(level._effect["mq_portal_red"], self, "tag_origin");
  self playLoopSound("zmb_player_portal_lp");
}

ktfx_scene_play_da() {
  level endon("game_ended");
  level endon("mq_step_three_done");
  wait 6;
  level thread ktfx_fight_duration_watch();
}

ktfx_fight_duration_watch() {
  level endon("game_ended");
  level endon("mq_step_three_done");
  level thread scene_fight_kick_off();
  wait 41;
  _func_01E3("first_trip_dark_aether");
  scripts\cp\utility::_id_B8EF("zmb_construct_voice_stinger_0", level.mdl_ktfx_da.origin);
  scripts\cp\utility::_id_B8EF("zmb_kortifex_downs_players_event_pre", level.mdl_ktfx_da.origin);
  playFXOnTag(level._effect["mq_construct_pulse"], level.void_construct.fx_proxy, "tag_origin");
  level.self_revive_override_func = ::force_block_self_revive;
  level.set_min_last_stand_wait_override_func = ::auto_revive_wait_override;
  level.b_force_skip_laststand_shield = 1;
  level.revive_dmg_shield_time_override = 0;

  foreach(var_1 in level.players) {
    if(istrue(var_1.inlaststand)) {
      var_1 setclientomnvar("zm_hint_index", 0);
    }

    var_1.b_force_block_revive = 1;
  }

  wait 4;
  level thread scene_fight_complete();
}

down_all_players() {
  level endon("game_ended");
  level thread fadetowhite(0.2);

  foreach(var_1 in level.players) {
    var_1.b_force_laststand = 1;

    if(!istrue(var_1.inlaststand)) {
      var_1 dodamage(var_1.maxhealth, var_1.origin);
      scripts\cp\utility::_id_B8F4("zmb_kortifex_downs_players_event", var_1);
    }
  }

  level thread play_vo_down_players();
}

scene_fight_kick_off() {
  set_up_zombie_spawning("mq_1st_visit_da_zmb_spawner", "mq_ktfx_fight_done");
  level._id_A52A = 1;
}

scene_fight_complete() {
  level notify("mq_ktfx_fight_done");
  level._id_A52A = 0;
}

teleport_players_back_to_oasis() {
  level endon("game_ended");
  level endon("mq_step_three_done");
  var_0 = scripts\engine\utility::getStructArray("mq_1st_da_visit_return_loc", "script_noteworthy");
  level thread do_teleporting(var_0, undefined, "cp_zm_oasis_oasis_tr");
  level waittill("portal_warp_finished");
  level thread play_vo_return_oasis();
  scripts\engine\utility::_id_5C1B("return_from_da");
  level.force_check_health_bar_for_certain_entity = undefined;
  level.entity_to_check_health_bar = undefined;
  level notify("mq_step_three_done");
}

do_teleporting(var_0, var_1, var_2) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(isDefined(var_1)) {
    foreach(var_4 in level.players) {
      var_4 thread player_teleport_lookat_watch(var_1);
    }
  }

  level thread _id_098A::warp_for_rbz(var_0, var_2);
}

player_teleport_lookat_watch(var_0) {
  self endon("death");
  level endon("end_game");
  self waittill("fasttravel_finished");

  if(isDefined(self) && isPlayer(self) && isalive(self)) {
    self setplayerangles(vectortoangles(var_0 - self.origin));
  }
}

stream_destination(var_0) {
  level endon("game_ended");
  wait 4;

  if(scripts\cp\cp_destinations::get_loaded_destination() != var_0) {
    scripts\cp\cp_destinations::unload_current_destination();
    scripts\cp\cp_destinations::load_destination(var_0);
  }
}

handle_player_outofmap() {
  level endon("game_ended");
  self endon("disconnect");
  level endon("mq_step_three_done");
  var_0 = getent("mq_ktfx_fight_fall_check", "script_noteworthy");
  var_1 = scripts\engine\utility::getStructArray("mq_1sr_portal_dest", "targetname");

  for(;;) {
    if(self istouching(var_0)) {
      var_2 = var_1[randomint(var_1.size)];
      thread fadetowhite_for_specific_player(0.1);
      wait 0.1;
      playFX(scripts\engine\utility::getfx("outofmap_teleport"), var_2.origin);
      thread _id_098B::_id_F02A(var_2);
      var_3 = self.health - 0.1 * self.maxhealth;

      if(var_3 > 0) {
        self dodamage(var_3, self.origin, undefined, undefined, "MOD_SUICIDE");
      }

      if(isDefined(self._id_1B3D) && self._id_1B3D > 0) {
        _id_0707::_id_D161(self, 0 * self._id_9C09);
      }

      self playsoundtoplayer("zmb_d_ae_respawn", self);
      self playsoundtoteam("zmb_d_ae_respawn_m", self.team, self, self);
      wait 0.4;
      _func_019D(scripts\engine\utility::getfx("outofmap_teleport_begin"), self, "j_head", self);
      _func_019D(scripts\engine\utility::getfx("outofmap_teleport_end"), self, "j_head", self);
      wait 0.5;
    }

    waitframe();
  }
}

fadetowhite_for_specific_player(var_0) {
  level endon("game_ended");
  self notify("FadeToWhite_singleton");
  self endon("FadeToWhite_singleton");
  self setclientomnvar("ui_total_fade_color", 1);
  level thread scripts\cp_mp\utility\game_utility::_id_58C7(self, 1, var_0);
  wait(var_0 + 0.3);
  level thread scripts\cp_mp\utility\game_utility::_id_58C7(self, 0, var_0);
  wait(var_0 + 0.3);
  self setclientomnvar("ui_total_fade_color", 0);
}

auto_revive_wait_override() {
  return gettime() + 10000;
}

ktfx_dmg_watcher(var_0) {
  level endon("end_game");

  if(isDefined(var_0)) {
    level endon(var_0);
  }

  self endon("death");

  for(;;) {
    self waittill("damage", var_1, var_2);

    if(isPlayer(var_2)) {
      level thread _id_072E::display_damage_number_internal(var_2, 2, 0, self.origin);
    }
  }
}

molotov_stuck_check(var_0, var_1) {
  level endon("game_ended");

  if(isDefined(var_1)) {
    level endon(var_1);
  }

  self endon("disconnect");
  var_0 endon("death");
  self waittill("grenade_fire", var_2);

  if(isDefined(self) && isDefined(var_2)) {
    thread molotov_stuck_check(var_0);
    var_3 = var_2 scripts\engine\utility::_id_108A4("missile_stuck", "death");

    if(scripts\engine\utility::is_equal(var_3["message"], "missile_stuck") && (scripts\engine\utility::is_equal(var_3["ent"].weapon_name, "s4_molotov_zm") || scripts\engine\utility::is_equal(var_3["ent"].weapon_name, "s4_thermite_zm"))) {
      var_4 = var_3[0];

      if(isDefined(var_2) && isDefined(var_0) && isDefined(var_4) && distancesquared(var_4.origin, var_0.origin) < _func_0219(500)) {
        var_2 notify("death");
        waitframe();

        if(isDefined(var_2)) {
          var_2 delete();
        }
      }
    }
  }
}

play_vo_enter_portal() {
  level endon("end_game");

  if(istrue(level._id_493C)) {
    level waittill("dialogue_finished");
  }

  level thread _id_0720::play_narrations(["zm_cpm5_mqs5_vlst_qida", "zm_cpm5_mqs5_vlst_qidb", "zm_cpm5_mqs5_krft_qidc"], 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");
}

play_vo_arrive_da() {
  level endon("end_game");
  wait 0.5;

  if(istrue(level._id_493C)) {
    level waittill("dialogue_finished");
  }

  level.mdl_ktfx_da play_sequence_3d_vos(["zm_cpm5_mqs5_krtx_qidd"]);
}

play_vo_down_players() {
  level endon("end_game");
  wait 1.5;

  if(istrue(level._id_493C)) {
    level waittill("dialogue_finished");
  }

  level thread _id_0720::play_narrations(["zm_cpm5_mqs5_krft_qide", "zm_cpm5_mqs5_dnrt_qidf"], 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");
  scripts\cp\utility::_id_B8EF("zmb_construct_voice_stinger_1", level.mdl_ktfx_da.origin);
  playFXOnTag(level._effect["mq_construct_pulse"], level.void_construct.fx_proxy, "tag_origin");
  wait 2;
  level.mdl_ktfx_da play_sequence_3d_vos(["zm_cpm5_mqs5_krtx_qidg"]);
  scripts\cp\utility::_id_B8EF("zmb_construct_voice_stinger_2", level.mdl_ktfx_da.origin);
  playFXOnTag(level._effect["mq_construct_pulse"], level.void_construct.fx_proxy, "tag_origin");
  wait 3;
  level notify("mq_down_player_vo_done");
  level.mdl_ktfx_da play_sequence_3d_vos(["zm_cpm5_mqs5_krtx_qidh", "zm_cpm5_mqs5_krtx_qidi"]);
}

play_vo_return_oasis() {
  level endon("end_game");
  wait 0.5;

  if(istrue(level._id_493C)) {
    level waittill("dialogue_finished");
  }

  level thread _id_0720::play_narrations(["zm_cpm5_mqs5_krft_qidj", "zm_cpm5_mqs5_dnrt_qidk", "zm_cpm5_mqs5_krft_qidl", "zm_cpm5_mqs5_dnvk_qidm", "zm_cpm5_mqs5_dnvk_qidn", "zm_cpm5_mqs5_vlst_qido", "zm_cpm5_mqs5_vlst_qidp"], 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");
}

init_trails() {
  if(!scripts\engine\utility::_id_5C00("round_spawn_zombies")) {
    scripts\engine\utility::_id_5C1B("round_spawn_zombies");
  }

  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_gauntlet::init();
  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_a::trial_a_init();
  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::trial_b_init();
  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_c::trial_c_init();
  level thread trial_progress_watcher();
  level thread portal_unlock_watcher_trail_a();
  level thread portal_unlock_watcher_trail_b();
  level thread portal_unlock_watcher_trail_c();
  var_0 = scripts\engine\utility::getstruct("mq_1st_portal_loc", "script_noteworthy");
  level.mdl_portal_sfx = scripts\cp\utility::_id_E190("tag_origin", var_0.origin);
  level.mdl_portal_sfx playLoopSound("zmb_portal_blocker_beams_lp");
  _func_01E3("none");
}

do_trails() {
  level waittill("mq_step_four_done");
}

cleanup_trails() {
  level.mdl_portal_sfx stoploopsound("zmb_portal_blocker_beams_lp");
}

debug_trails() {
  level notify("mq_step_four_done");
}

trial_progress_watcher() {
  level endon("game_ended");
  level endon("mq_step_four_done");
  level scripts\engine\utility::waittill_any_3("mq_trial_a_done", "mq_trial_b_done", "mq_trial_c_done");
  level thread play_vo_one_trial_done();
  level scripts\engine\utility::waittill_any_3("mq_trial_a_done", "mq_trial_b_done", "mq_trial_c_done");
  level thread play_vo_two_trials_done();
  level scripts\engine\utility::waittill_any_3("mq_trial_a_done", "mq_trial_b_done", "mq_trial_c_done");
  scripts\engine\utility::_id_5C04("mq_da_portal_hint_on");
  level thread play_vo_three_trials_done();
}

portal_unlock_watcher_trail_a() {
  level endon("game_ended");
  level endon("mq_step_four_done");
  var_0 = scripts\engine\utility::getstruct("mq_1st_portal_loc", "script_noteworthy");
  level waittill("mq_trial_a_done");
  stopFXOnTag(level._effect["mq_portal_lock_a"], var_0.mdl_chain_a_fx, "tag_origin");
  var_0.mdl_chain_a_fx delete();
}

portal_unlock_watcher_trail_b() {
  level endon("game_ended");
  level endon("mq_step_four_done");
  var_0 = scripts\engine\utility::getstruct("mq_1st_portal_loc", "script_noteworthy");
  level waittill("mq_trial_b_done");
  stopFXOnTag(level._effect["mq_portal_lock_b"], var_0.mdl_chain_b_fx, "tag_origin");
  var_0.mdl_chain_b_fx delete();
}

portal_unlock_watcher_trail_c() {
  level endon("game_ended");
  level endon("mq_step_four_done");
  var_0 = scripts\engine\utility::getstruct("mq_1st_portal_loc", "script_noteworthy");
  level waittill("mq_trial_c_done");
  stopFXOnTag(level._effect["mq_portal_lock_c"], var_0.mdl_chain_c_fx, "tag_origin");
  var_0.mdl_chain_c_fx delete();
  level.can_drop_ww_shield = 1;
}

play_vo_one_trial_done() {
  level endon("game_ended");
  wait 6;

  while(istrue(level._id_493C) || have_vo_play_to_players()) {
    wait 1;
  }

  var_0 = ["zm_cpm5_mqs5_vlst_qigu", "zm_cpm5_mqs5_krft_qigv"];
  var_1 = ["zm_cpm5_mqs5_vlst_qigw", "zm_cpm5_mqs5_krft_qigx"];
  var_2 = ["zm_cpm5_mqs5_vlst_qigy", "zm_cpm5_mqs5_krft_qigz"];
  var_3 = ["zm_cpm5_mqs5_vlst_qig1", "zm_cpm5_mqs5_krft_qig2"];
  level thread _id_0720::play_narrations(scripts\engine\utility::random([var_0, var_1, var_2, var_3]), 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");
}

play_vo_two_trials_done() {
  level endon("game_ended");
  wait 6;

  while(istrue(level._id_493C) || have_vo_play_to_players()) {
    wait 1;
  }

  var_0 = ["zm_cpm5_mqs5_vlst_qiji", "zm_cpm5_mqs5_krft_qijj"];
  var_1 = ["zm_cpm5_mqs5_vlst_qijk", "zm_cpm5_mqs5_krft_qijl"];
  var_2 = ["zm_cpm5_mqs5_vlst_qijm", "zm_cpm5_mqs5_krft_qijn"];
  var_3 = ["zm_cpm5_mqs5_vlst_qijo", "zm_cpm5_mqs5_krft_qijp"];
  level thread _id_0720::play_narrations(scripts\engine\utility::random([var_0, var_1, var_2, var_3]), 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");
}

play_vo_three_trials_done() {
  level endon("game_ended");
  wait 6;

  while(istrue(level._id_493C) || have_vo_play_to_players()) {
    wait 1;
  }

  level thread _id_0720::play_narrations(["zm_cpm5_mqs5_krft_qine", "zm_cpm5_mqs5_vlst_qinf", "zm_cpm5_mqs5_krft_qing", "zm_cpm5_mqs5_vlst_qinh", "zm_cpm5_mqs5_krft_qini", "zm_cpm5_mqs5_vlst_qinj", "zm_cpm5_mqs5_vlst_qink"], 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");
  wait 3;
  level thread _id_0720::play_narrations(["zm_cpm5_mqs5_dnrt_qinl", "zm_cpm5_mqs5_dnvk_qinm", "zm_cpm5_mqs5_krft_qinn", "zm_cpm5_mqs5_dnrt_qino", "zm_cpm5_mqs5_dcmt_qinq", "zm_cpm5_mqs5_dnrt_qinr", "zm_cpm5_mqs5_dcmt_qins", "zm_cpm5_mqs5_dnvk_qint", "zm_cpm5_mqs5_krft_qinu"], 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");
  level notify("mq_step_four_done");
}

have_vo_play_to_players() {
  if(isDefined(level.players)) {
    foreach(var_1 in level.players) {
      if(isDefined(var_1)) {
        if(istrue(var_1._id_493C)) {
          return 1;
        }

        if(isDefined(var_1._id_4169) && _func_0121(var_1._id_4169) && var_1._id_4169 != "") {
          return 1;
        }
      }
    }
  }

  return 0;
}

init_to_the_end() {
  _id_0737::_id_C266("mq_1st_portal_loc", ::hint_interact_2st_portal, ::on_interact_2nd_portal, ::init_interact_2nd_portal);
  level._id_8393["mq_1st_portal_loc"]._id_3108 = ::can_use_2nd_portal;
  level.n_players_ready_for_boss_fight = 0;
}

do_to_the_end() {
  level waittill("mq_step_five_done");
}

cleanup_to_the_end() {
  level.can_drop_ww_dg2 = 1;
}

debug_to_the_end() {
  level notify("mq_step_five_done");
}

on_interact_2nd_portal(var_0, var_1) {
  _id_0737::_id_C3C5(var_0);
  level thread do_vote_second_visit_da(var_0, var_1);
}

hint_interact_2st_portal(var_0, var_1) {
  if(level scripts\engine\utility::_id_5C00("start_rbz_exfil")) {
    return "";
  }

  return &"CP_ZM_OASIS/MQ_ENTER_DA";
}

can_use_2nd_portal(var_0, var_1) {
  if(level scripts\engine\utility::_id_5C00("start_rbz_exfil")) {
    return 0;
  }

  return 1;
}

init_interact_2nd_portal(var_0) {}

do_vote_second_visit_da(var_0, var_1) {
  level endon("game_ended");
  var_2 = _id_0992::_id_106AF(var_1, 14, "mq second visit DA start failed");

  if(istrue(var_2)) {
    level thread do_interact_2nd_portal(var_0);
    level thread play_vo_interact_2nd_portal();
  } else
    _id_0737::_id_1037(var_0);
}

do_interact_2nd_portal(var_0) {
  level endon("game_ended");
  level endon("mq_step_three_done");
  level scripts\engine\utility::_id_5C1B("disallow_rbz_exfil");
  var_1 = scripts\engine\utility::getStructArray("mq_2nd_teleport_loc", "script_noteworthy");

  foreach(var_3 in level.players) {
    var_3 thread boss_fight_start_watcher();
  }

  level thread do_teleporting(var_1, level.mdl_ktfx_da.origin, "cp_zm_oasis_drk_tr");
  level waittill("portal_warp_finished");

  if(isDefined(level.trial_of_mindfulness_obelisk.mdl)) {
    _func_0130(level.trial_of_mindfulness_obelisk.mdl);
    level.trial_of_mindfulness_obelisk.mdl delete();
    var_5 = getent("mq_trial_of_mindfulness_obelisk_clip", "script_noteworthy");
    var_5 _meth_8093();
    var_5 delete();
  }

  if(isDefined(level.main_obelisk_b.mdl)) {
    _func_0130(level.main_obelisk_b.mdl);
    level.main_obelisk_b.mdl delete();
    var_6 = getEntArray("mq_trial_b_obelisk_clip", "script_noteworthy");
    scripts\engine\utility::_id_1B98(var_6, ::_meth_8093);
    scripts\engine\utility::_id_1B98(var_6, ::delete);
  }

  if(isDefined(level.main_obelisk_c.mdl)) {
    _func_0130(level.main_obelisk_c.mdl);
    level.main_obelisk_c.mdl delete();
    var_5 = getent("trial_of_resilience_obelisk_clip", "script_noteworthy");
    var_5 _meth_8093();
    var_5 delete();
  }

  while(level.n_players_ready_for_boss_fight < level.players.size) {
    waitframe();
  }

  wait 1;
  level thread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_boss::kick_off_boss_fight();
  var_0.mdl_fx stoploopsound("zmb_player_portal_lp");
  _func_0130(var_0.mdl_fx);
  var_0.mdl_fx delete();
  var_0.mdl_portal_img delete();
  level notify("mq_step_five_done");
}

boss_fight_start_watcher() {
  self endon("death");
  level endon("end_game");
  self waittill("fasttravel_finished");
  level.n_players_ready_for_boss_fight++;
}

reveal_pap_in_dark_aether() {
  foreach(var_1 in level.a_mdl_paps) {
    if(!scripts\engine\utility::is_equal(var_1, level.mdl_oasis_pap)) {
      var_1 setModel("s4_zm_machine_weapon_dim");
      var_1 _meth_82CB("s4_zm_fxanim_pap_idle_anim");
      playFXOnTag(scripts\engine\utility::getfx("pap_idle"), var_1, "tag_origin");

      if(_func_0205("zmb_pap_idle_lp")) {
        var_1 playLoopSound("zmb_pap_idle_lp");
      }
    }
  }
}

on_zombie_killed_give_no_score(var_0) {
  var_1 = self;
  var_2 = var_0._id_50FF;

  if(isDefined(var_0._id_04F6)) {
    var_2 _id_072A::giveekiasuperpoints(var_0._id_04F6);
  }

  level.total_ekia_per_round_per_player[var_2 getxuid()]++;
  var_2 _id_074E::_id_5530("kills", 1);
  var_2 thread _id_072A::updaterecentkillingblows(var_1);

  if(isDefined(var_1._id_1DDE)) {
    foreach(var_4 in var_1._id_1DDE) {
      if(!isDefined(var_4) || !isPlayer(var_4)) {
        continue;
      }
      if(var_4 == var_2) {
        continue;
      }
      if(var_1 == var_4) {
        continue;
      }
      if(isDefined(level._id_1D2C)) {
        continue;
      }
      var_5 = undefined;

      if(isDefined(var_1._id_1DD4)) {
        var_6 = var_1._id_1DD4[var_4.guid];

        if(isDefined(var_6)) {
          if(gettime() - var_6._id_90A7 > 10000) {
            continue;
          }
        }
      }

      var_4 _id_072A::giveekiasuperpoints();
      level.total_ekia_per_round_per_player[var_4 getxuid()]++;
      var_4 _id_074E::_id_5530("assists", 1);
    }
  }
}

disable_none_kill_score_event() {
  level.a_disabled_score_event = ["stun_grenade_stunned_enemy", "stun_mine_stunned_enemy", "juggernaut_backpack_destroyed", "energy_mine_stunned_enemy"];
}

enable_none_kill_score_event() {
  level.a_disabled_score_event = undefined;
}

play_vo_interact_2nd_portal() {
  level endon("end_game");

  if(istrue(level._id_493C)) {
    level waittill("dialogue_finished");
  }

  level thread _id_0720::play_narrations(["zm_cpm5_mqs5_dnrt_qioa", "zm_cpm5_mqs5_dnvk_qiob"], 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");
  level notify("mq_step_five_done");
}