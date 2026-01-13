/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_town\cp_town_mpq.gsc
***************************************************/

cp_town_mpq_init() {
  scripts\cp\zombies\zombie_quest::register_quest_step("deathray", 0, ::default_init, ::deathray_step_1, ::complete_deathray_step_1, ::debug_deathray_step_1, 1);
  scripts\cp\zombies\zombie_quest::register_quest_step("deathray", 1, ::default_init, ::deathray_step_2, ::complete_deathray_step_2, ::debug_deathray_step_2, 1);
  scripts\cp\zombies\zombie_quest::register_quest_step("deathray", 2, ::default_init, ::deathray_step_3, ::complete_deathray_step_3, ::debug_deathray_step_3, 1);
  scripts\cp\zombies\zombie_quest::register_quest_step("deathray", 3, ::default_init, ::deathray_step_4, ::complete_deathray_step_4, ::debug_deathray_step_4, 1);
  scripts\cp\zombies\zombie_quest::register_quest_step("deathray", 4, ::default_init, ::deathray_step_5, ::complete_deathray_step_5, ::debug_deathray_step_5, 1);
  scripts\cp\zombies\zombie_quest::register_quest_step("deathray", 5, ::default_init, ::deathray_step_6, ::complete_deathray_step_6, ::debug_deathray_step_6, 1);
  scripts\cp\zombies\zombie_quest::register_quest_step("deathray", 6, ::default_init, ::deathray_step_7, ::complete_deathray_step_7, ::debug_deathray_step_7, 1);
  scripts\cp\zombies\zombie_quest::register_quest_step("chemistry", 0, ::init_chemistry_step_1, ::chemistry_step_1, ::complete_chemistry_step_1, ::debug_chemistry_step_1, 2);
  scripts\cp\zombies\zombie_quest::register_quest_step("chemistry", 1, ::init_chemistry_step_2, ::chemistry_step_2, ::complete_chemistry_step_2, ::debug_chemistry_step_2, 2);
  scripts\cp\zombies\zombie_quest::register_quest_step("chemistry", 2, ::init_chemistry_step_3, ::chemistry_step_3, ::complete_chemistry_step_3, ::debug_chemistry_step_3, 2, " Create &carry Chem Mix ");
  scripts\cp\zombies\zombie_quest::register_quest_step("chemistry", 3, ::init_chemistry_step_4, ::chemistry_step_4, ::complete_chemistry_step_4, ::debug_chemistry_step_4, 2, " Add Chem Mix to bomb");
  scripts\cp\zombies\zombie_quest::register_quest_step("launchcode", 0, ::init_launchcode_step_1, ::launchcode_step_1, ::launchcode_step_1_complete, ::launchcode_step_1_debug, 3, " Open safe");
  scripts\cp\zombies\zombie_quest::register_quest_step("launchcode", 1, ::default_init, ::launchcode_step_2, ::launchcode_step_2_complete, ::launchcode_step_2_debug, 3, " Take codes");
  scripts\cp\zombies\zombie_quest::register_quest_step("launchcode", 2, ::default_init, ::launchcode_step_3, ::launchcode_step_3_complete, ::launchcode_step_3_debug, 3, " Build bomb");
  scripts\cp\zombies\zombie_quest::register_quest_step("launchcode", 3, ::default_init, ::launchcode_step_4, ::complete_launchcode_step_4, ::debug_launchcode_step_4, 3);
  level.mpq_arm_func = ::set_quake_flag_if_close_to_arm;
  level._effect["locker_key"] = loadfx("vfx\iw7\levels\cp_disco\Requests\vfx_locker_key.vfx");
  level._effect["ufo_glow_death"] = loadfx("vfx\iw7\levels\cp_town\alien\vfx_atomize_zombie.vfx");
  level._effect["life_ray_beam"] = loadfx("vfx\iw7\levels\cp_town\skq\vfx_life_beam.vfx");
  level._effect["life_ray_burst"] = loadfx("vfx\iw7\levels\cp_town\skq\vfx_revive_burst.vfx");
  level._effect["death_ray_beam"] = loadfx("vfx\iw7\levels\cp_town\skq\vfx_death_beam.vfx");
  level._effect["death_ray_vaporize"] = loadfx("vfx\iw7\_requests\mp\vfx_atomize_body.vfx");
  level._effect["torso_glow"] = loadfx("vfx\iw7\levels\cp_town\skq\vfx_part_torso_glow.vfx");
  level._effect["head_glow"] = loadfx("vfx\iw7\levels\cp_town\skq\vfx_part_head_glow.vfx");
  level._effect["meat_freeze"] = loadfx("vfx\iw7\levels\cp_town\skq\vfx_meat_freeze.vfx");
  level._effect["mirror_break"] = loadfx("vfx\iw7\levels\cp_town\skq\vfx_mirror_break.vfx");
  level._effect["turnstile_teleport"] = loadfx("vfx\iw7\levels\cp_town\vfx_town_telep_diss.vfx");
  init_zom_body();
  level thread spawn_film_reel_hints();
  level thread listen_for_zombie_spawn();
  level thread listen_for_death_by_cleaver();
  level thread listen_for_toilet_head();
  level thread listen_for_turnstile_damage();
  level thread listen_for_photo_change();
  level thread shuffle_film_reels();
  scripts\engine\utility::flag_init("deathray_step1");
  scripts\engine\utility::flag_init("deathray_step2");
  scripts\engine\utility::flag_init("deathray_step3");
  scripts\engine\utility::flag_init("deathray_step4");
  scripts\engine\utility::flag_init("deathray_step5");
  scripts\engine\utility::flag_init("deathray_step6");
  scripts\engine\utility::flag_init("deathray_step7");
  scripts\engine\utility::flag_init("chemistry_step1");
  scripts\engine\utility::flag_init("chemistry_step2");
  scripts\engine\utility::flag_init("chemistry_step3");
  scripts\engine\utility::flag_init("chemistry_step4");
  scripts\engine\utility::flag_init("launchcode_step1");
  scripts\engine\utility::flag_init("launchcode_step2");
  scripts\engine\utility::flag_init("launchcode_step3");
  scripts\engine\utility::flag_init("launchcode_step4");
  scripts\engine\utility::flag_init("frozen_meat_gone");
  scripts\engine\utility::flag_init("quake_lifts_arm");
  scripts\engine\utility::flag_init("allow_quake_lifts_arm");
}

debug_bounce_laser() {
  wait(10);
  for(;;) {
    bounce_laser("tag_origin_death_ray_fx", "life_ray_beam", "life_ray_burst");
    wait(10);
    bounce_laser("tag_origin_death_ray_fx", "death_ray_beam", "death_ray_vaporize");
    wait(10);
  }
}

set_backstory_interaction_active_for_players() {
  foreach(var_1 in level.players) {
    if(scripts\engine\utility::istrue(var_1.played_backstory_vo)) {
      scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(level.backstory_interactions[0], var_1);
      var_1.played_backstory_vo = 0;
    }
  }
}

deathray_step_1() {
  scripts\engine\utility::flag_wait("deathray_step1");
}

deathray_step_2() {
  scripts\engine\utility::flag_wait("deathray_step2");
}

deathray_step_3() {
  scripts\engine\utility::flag_wait("deathray_step3");
}

deathray_step_4() {
  scripts\engine\utility::flag_wait("deathray_step4");
}

deathray_step_5() {
  scripts\engine\utility::flag_wait("deathray_step5");
}

deathray_step_6() {
  scripts\engine\utility::flag_wait("deathray_step6");
}

deathray_step_7() {
  scripts\engine\utility::flag_wait("deathray_step7");
}

complete_deathray_step_1() {
  scripts\engine\utility::flag_set("deathray_step1");
  level thread set_backstory_interaction_active_for_players();
}

complete_deathray_step_2() {
  scripts\engine\utility::flag_set("deathray_step2");
  level thread set_backstory_interaction_active_for_players();
}

complete_deathray_step_3() {
  scripts\engine\utility::flag_set("deathray_step3");
  level thread set_backstory_interaction_active_for_players();
}

complete_deathray_step_4() {
  scripts\engine\utility::flag_set("deathray_step4");
  level thread set_backstory_interaction_active_for_players();
}

complete_deathray_step_5() {
  scripts\engine\utility::flag_set("deathray_step5");
  level thread set_backstory_interaction_active_for_players();
}

complete_deathray_step_6() {
  scripts\engine\utility::flag_set("deathray_step6");
  level thread set_backstory_interaction_active_for_players();
}

complete_deathray_step_7() {
  scripts\engine\utility::flag_set("deathray_step7");
  level thread set_backstory_interaction_active_for_players();
}

debug_deathray_step_1() {
  foreach(var_1 in level.mpq_zom_body_parts) {
    set_quest_omnvar_by_targetname(var_1);
    var_1 hide();
    wait(0.1);
  }

  level.leg_knocked_down = 1;
  var_3 = getent("mpq_zom_l_leg_part_ground", "targetname");
  if(isDefined(var_3)) {
    var_3 hide();
  }

  foreach(var_5, var_1 in level.mpq_zom_parts) {
    if(!isDefined(var_1.fx_ent)) {
      level thread glow_bed_part(var_5, var_1);
    }

    var_1 show();
    wait(0.1);
  }

  level.mpq_zom_parts_picked_up["head"] = 1;
  level.mpq_zom_parts_picked_up["torso"] = 1;
  level.mpq_zom_parts_picked_up["left_arm"] = 1;
  level.mpq_zom_parts_picked_up["right_arm"] = 1;
  level.mpq_zom_parts_picked_up["left_leg"] = 1;
  level.mpq_zom_parts_picked_up["right_leg"] = 1;
  level.mpq_zom_parts_index = level.mpq_zom_parts_picked_up.size;
}

debug_deathray_step_2() {
  var_0 = getent("mpq_punch_card", "targetname");
  var_0 hide();
  set_quest_omnvar_by_targetname(var_0);
  level.punch_card_acquired = 1;
}

debug_deathray_step_3() {
  var_0 = getent("elvira_mirror", "targetname");
  var_0 hide();
  level.mirrors_picked_up["elvira_mirror"] = 1;
  set_quest_omnvar_by_targetname(var_0);
  var_0 = getent("car_mirror", "targetname");
  var_0 hide();
  var_0 = getent("car_mirror_ground", "targetname");
  var_0 hide();
  level.mirrors_picked_up["car_mirror_ground"] = 1;
  set_quest_omnvar_by_targetname(var_0);
  var_0 = getent("bathroom_mirror_piece", "targetname");
  var_0 hide();
  level.mirrors_picked_up["bathroom_mirror_piece"] = 1;
  set_quest_omnvar_by_targetname(var_0);
  var_1 = scripts\engine\utility::getstructarray("mirror_placement", "script_noteworthy");
  foreach(var_3 in var_1) {
    var_4 = scripts\engine\utility::getstruct(var_3.target, "targetname");
    var_0 = spawn("script_model", var_4.origin);
    var_0.angles = var_4.angles;
    var_0 setModel(var_4.script_noteworthy);
  }

  level.mirrors_placed["car_mirror"] = 1;
  level.mirrors_placed["bathroom_mirror"] = 1;
  level.mirrors_placed["elvira_mirror"] = 1;
}

debug_deathray_step_4() {
  foreach(var_1 in level.mpq_zom_parts) {
    var_1 hide();
  }

  level.knife_throw_target_body show();
  level.body_made = 1;
  level.terminal_unlocked = 1;
}

debug_deathray_step_5() {
  level.polarity_reversed = 1;
}

debug_deathray_step_6() {
  level.knife_throw_target_body hide();
  spawn_garage_key(level.knife_throw_target_body.origin);
  level.key_spawned = 1;
}

debug_deathray_step_7() {
  foreach(var_1 in level.mpq_zom_body_parts) {
    set_quest_omnvar_by_targetname(var_1);
    var_1 hide();
    wait(0.1);
  }

  level scripts\cp\utility::set_completed_quest_mark(1);
  level.garage_key_found = 1;
}

init_chemistry_step_1() {}

init_chemistry_step_2() {}

init_chemistry_step_3() {}

init_chemistry_step_4() {}

chemistry_step_1() {
  scripts\engine\utility::flag_wait("chemistry_step1");
}

chemistry_step_2() {
  scripts\engine\utility::flag_wait("chemistry_step2");
}

chemistry_step_3() {
  scripts\engine\utility::flag_wait("chemistry_step3");
}

chemistry_step_4() {
  scripts\engine\utility::flag_wait("chemistry_step4");
}

complete_chemistry_step_1() {
  scripts\engine\utility::flag_set("chemistry_step1");
  level thread set_backstory_interaction_active_for_players();
}

complete_chemistry_step_2() {
  scripts\engine\utility::flag_set("chemistry_step2");
  level thread set_backstory_interaction_active_for_players();
}

complete_chemistry_step_3() {
  scripts\engine\utility::flag_set("chemistry_step3");
  level thread set_backstory_interaction_active_for_players();
}

complete_chemistry_step_4() {
  scripts\engine\utility::flag_set("chemistry_step4");
  level thread set_backstory_interaction_active_for_players();
}

debug_chemistry_step_1() {}

debug_chemistry_step_2() {}

debug_chemistry_step_3() {}

debug_chemistry_step_4() {}

init_launchcode_step_1() {
  scripts\engine\utility::flag_init("teleporter_charged");
  scripts\engine\utility::flag_init("teleporter_charging");
  level.teleporter_pieces_found = 0;
  level.teleporter_pieces_placed = 0;
  level.safe = getent("town_safe", "targetname");
  level.gauge_trigs = getEntArray("mpq_gauge_trig", "targetname");
  level thread phase3_launchcode_interaction();
}

launchcode_step_1() {
  scripts\engine\utility::array_thread(level.gauge_trigs, ::phase3_watch_gauge_trigs);
  level thread phase3_create_safe_combo();
  scripts\engine\utility::flag_wait("launchcode_step1");
}

launchcode_step_1_complete() {
  scripts\engine\utility::flag_set("launchcode_step1");
  phase3_open_safe();
  level thread set_backstory_interaction_active_for_players();
}

launchcode_step_1_debug() {}

launchcode_step_2() {
  scripts\engine\utility::flag_wait("launchcode_step2");
}

launchcode_step_2_complete() {
  scripts\engine\utility::flag_set("launchcode_step2");
  scripts\cp\utility::set_quest_icon(20);
  level thread set_backstory_interaction_active_for_players();
}

launchcode_step_2_debug() {}

launchcode_step_3() {
  scripts\cp\maps\cp_town\cp_town_crab_boss_fight::advance_pre_combat_stage();
  scripts\engine\utility::flag_wait("launchcode_step3");
}

launchcode_step_3_debug() {}

launchcode_step_3_complete() {
  scripts\engine\utility::flag_set("launchcode_step3");
  level.teleporter_pieces_placed = 3;
  level.teleporter_pieces_found = 3;
  scripts\cp\utility::set_quest_icon(16);
  scripts\cp\utility::set_quest_icon(17);
  scripts\cp\utility::set_quest_icon(18);
  scripts\engine\utility::flag_set("launchcode_step3");
  level thread set_backstory_interaction_active_for_players();
}

launchcode_step_4() {
  scripts\engine\utility::flag_wait("launchcode_step4");
}

complete_launchcode_step_4() {
  scripts\engine\utility::flag_set("launchcode_step4");
  level thread set_backstory_interaction_active_for_players();
}

debug_launchcode_step_4() {}

init_mpq_interactions() {
  scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1, "mpq_zom_body", undefined, undefined, ::zom_body_bed_hint_func, ::zom_body_bed_activation_func, 0, 0, ::zom_body_bed_init_func, undefined);
  scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1, "mpq_zom_body_part", undefined, undefined, ::zom_body_part_hint_func, ::zom_body_part_activation_func, 0, 0, ::zom_body_part_init_func, undefined);
  scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1, "mirror", undefined, undefined, ::mirror_hint_func, ::mirror_activation_func, 0, 0, ::mirror_init_func, undefined);
  scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1, "mirror_placement", undefined, undefined, ::mirror_placement_hint_func, ::mirror_placement_activation_func, 0, 0, ::mirror_placement_init_func, undefined);
  scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1, "punch_card", undefined, undefined, ::punch_card_hint_func, ::punch_card_activation_func, 0, 0, ::punch_card_init_func, undefined);
  scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1, "ray_gun_start", undefined, undefined, ::ray_gun_hint_func, ::ray_gun_activation_func, 0, 0, ::ray_gun_init_func, undefined);
  scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1, "garage_door", undefined, undefined, ::garage_door_hint_func, ::garage_door_activation_func, 0, 0, ::garage_door_init_func, undefined);
  scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1, "mpq_ray_gun", undefined, undefined, ::ray_gun_hint_func, ::ray_gun_hint_func, 0, 0, ::ray_gun_hint_func, undefined);
  level.interaction_hintstrings["take_launchcodes"] = "";
  level.interaction_hintstrings["bomb_teleporter_part"] = "";
  scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1, "take_launchcodes", undefined, undefined, undefined, ::phase3_take_launch_codes, 0, 0);
  scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1, "bomb_teleporter_part", undefined, undefined, undefined, ::phase3_take_bomb_part, 0, 0);
  scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1, "place_bomb_parts", undefined, undefined, ::phase3_place_bomb_parts_hint, ::phase3_place_bomb_parts, 0, 0);
}

init_zom_body() {
  var_0 = spawnStruct();
  var_0.origin = (4113.5, -4577.5, 20);
  var_0.angles = (333.461, 131.629, -2.74148);
  level.knife_throw_target_body = spawn("script_model", var_0.origin);
  level.knife_throw_target_body setModel("fullbody_zmb_soldier");
  level.knife_throw_target_body.angles = var_0.angles;
  level.knife_throw_target_body scriptmodelplayanim("IW7_cp_zom_wheel_idle_01", 1);
  level.knife_throw_target_body hide();
  level.zom_parts_placed = [];
}

zom_body_bed_hint_func(var_0, var_1) {
  return "";
}

zom_body_bed_activation_func(var_0, var_1) {
  if(isDefined(level.body_made) && isDefined(level.key_spawned)) {
    if(isDefined(level.key_fx)) {
      level scripts\cp\utility::set_completed_quest_mark(1);
      level.key_fx delete();
      level.garage_key_found = 1;
      return;
    }

    return;
  }

  if(level.mpq_zom_parts_picked_up.size > level.mpq_zom_parts_index) {
    foreach(var_5, var_3 in level.mpq_zom_parts_picked_up) {
      level.zom_parts_placed[var_5] = 1;
      var_4 = level.mpq_zom_parts[var_5];
      if(!isDefined(var_4.fx_ent)) {
        level thread glow_bed_part(var_5, var_4);
      }

      var_4 show();
    }

    level.mpq_zom_parts_index = level.mpq_zom_parts_picked_up.size;
  }
}

glow_bed_part(var_0, var_1) {
  var_1.fx_ent = spawn("script_model", var_1.origin);
  switch (var_0) {
    case "torso":
      var_1.fx_ent.origin = var_1.fx_ent.origin + (17, -17, 50);
      var_1.fx_ent_2 = spawn("script_model", var_1.origin);
      var_1.fx_ent_2.origin = var_1.fx_ent_2.origin + (12, -12, 35);
      var_1.fx_ent_2 setModel("tag_origin_limb_glow_fx");
      break;

    case "head":
      var_1.fx_ent.origin = var_1.fx_ent.origin + (2, -2, 15);
      break;

    case "left_arm":
      var_1.fx_ent.origin = var_1.fx_ent.origin + (-9, -9, 3);
      break;

    case "right_arm":
      var_1.fx_ent.origin = var_1.fx_ent.origin + (8, 8, 6);
      break;

    case "left_leg":
      var_1.fx_ent.origin = var_1.fx_ent.origin + (-17, -5, -5);
      break;

    case "right_leg":
      var_1.fx_ent.origin = var_1.fx_ent.origin + (-5, 10, -5);
      break;
  }

  var_1.fx_ent setModel("tag_origin_limb_glow_fx");
}

zom_body_bed_init_func(var_0, var_1) {
  level.mpq_zom_parts_index = 0;
  level.mpq_zom_parts = [];
  level.mpq_zom_parts["head"] = getent("mpq_zom_head", "targetname");
  level.mpq_zom_parts["torso"] = getent("mpq_zom_torso", "targetname");
  level.mpq_zom_parts["left_arm"] = getent("mpq_zom_l_arm", "targetname");
  level.mpq_zom_parts["right_arm"] = getent("mpq_zom_r_arm", "targetname");
  level.mpq_zom_parts["left_leg"] = getent("mpq_zom_l_leg", "targetname");
  level.mpq_zom_parts["right_leg"] = getent("mpq_zom_r_leg", "targetname");
  level.mpq_zom_parts_picked_up = [];
  foreach(var_3 in level.mpq_zom_parts) {
    var_3 hide();
  }

  level.life_ray_end = spawnStruct();
  level.life_ray_end.origin = (4116, -4575, 60);
}

zom_body_bed_can_use_override_func(var_0, var_1) {}

spawn_garage_key(var_0) {
  level.key_fx = spawnfx(level._effect["locker_key"], var_0 + (0, 0, 32));
  wait(0.2);
  triggerfx(level.key_fx);
}

zom_body_part_init_func(var_0, var_1) {
  if(!isDefined(level.mpq_zom_body_parts)) {
    level.mpq_zom_body_parts = [];
  }

  level.mpq_zom_body_parts["head"] = getent("mpq_zom_head_part", "targetname");
  level.mpq_zom_body_parts["torso"] = getent("mpq_zom_torso_part", "targetname");
  level.mpq_zom_body_parts["left_arm"] = getent("mpq_zom_l_arm_part", "targetname");
  level.mpq_zom_body_parts["right_arm"] = getent("mpq_zom_r_arm_part", "targetname");
  level.mpq_zom_body_parts["left_leg"] = getent("mpq_zom_l_leg_part", "targetname");
  level.mpq_zom_body_parts["right_leg"] = getent("mpq_zom_r_leg_part", "targetname");
  var_2 = getent("mpq_zom_l_leg_part_ground", "targetname");
  if(isDefined(var_2)) {
    var_2 hide();
  }

  level thread listen_for_power_handle();
  level thread listen_for_leg_damage();
  level thread play_glow_on_parts();
  level thread update_struct_positions();
}

update_struct_positions() {
  wait(10);
  var_0 = scripts\engine\utility::getstructarray("mirror", "script_noteworthy");
  var_1 = scripts\engine\utility::getclosest((5579, 363.5, 342), var_0, 1000);
  var_1.origin = (5579, 363.5, 342);
  var_0 = scripts\engine\utility::getstructarray("mpq_zom_body_part", "script_noteworthy");
  var_1 = scripts\engine\utility::getclosest((6242, -526, 378), var_0, 1000);
  var_1.origin = var_1.origin + (0, 0, 60);
  var_1 = scripts\engine\utility::getclosest((-317, 3665, 475), var_0, 1000);
  var_1.origin = (-327, 3661, 475);
  var_1 = scripts\engine\utility::getclosest((3230, 1868, -90), var_0, 1000);
  var_1.origin = (3236, 1878, -86);
}

play_glow_on_parts() {
  wait(5);
  foreach(var_2, var_1 in level.mpq_zom_body_parts) {
    var_1.fx_ent = spawn("script_model", var_1.origin);
    wait(1);
    switch (var_2) {
      case "torso":
        var_1.fx_ent.origin = var_1.fx_ent.origin + (0, -5, 50);
        break;

      case "head":
        var_1.fx_ent.origin = var_1.fx_ent.origin + (0, 0, 12);
        break;

      case "left_arm":
        var_1.fx_ent.origin = var_1.fx_ent.origin + (0, 0, 20);
        break;

      case "right_arm":
        var_1.fx_ent.origin = var_1.fx_ent.origin + (0, 0, 5);
        break;

      case "left_leg":
        var_1.fx_ent.origin = var_1.fx_ent.origin + (-20, -20, 0);
        break;

      case "right_leg":
        break;
    }

    var_1.fx_ent setModel("tag_origin_limb_glow_fx");
    wait(1);
  }
}

zom_body_part_hint_func(var_0, var_1) {
  return "";
}

zom_body_part_activation_func(var_0, var_1) {
  var_2 = scripts\engine\utility::getclosest(var_0.origin, level.mpq_zom_body_parts, 500);
  var_3 = "none";
  foreach(var_6, var_5 in level.mpq_zom_body_parts) {
    if(var_2 == var_5) {
      var_3 = var_6;
    }
  }

  if(scripts\engine\utility::istrue(level.mpq_zom_parts_picked_up[var_3])) {
    return;
  }

  if(var_3 == "left_arm") {
    if(!scripts\engine\utility::flag("found_missing_handle")) {
      return;
    }

    if(!scripts\engine\utility::flag("quake_lifts_arm")) {
      return;
    }
  } else if(var_3 == "torso") {
    if(!scripts\engine\utility::flag("frozen_meat_gone")) {
      return;
    }
  } else if(var_3 == "left_leg") {
    if(!isDefined(level.leg_knocked_down)) {
      return;
    }

    var_7 = getent("mpq_zom_l_leg_part_ground", "targetname");
    var_7 hide();
  }

  set_quest_omnvar_by_targetname(var_2);
  var_1 playlocalsound("part_pickup");
  playFX(level._effect["generic_pickup"], var_2.origin);
  var_2 hide();
  level.mpq_zom_parts_picked_up[var_3] = 1;
  switch (var_2.var_336) {
    case "mpq_zom_head_part":
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("key_phase_1_collect_head", "town_comment_vo");
      break;

    case "mpq_zom_torso_part":
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("key_phase_1_collect_torso", "town_comment_vo");
      break;

    case "mpq_zom_l_arm_part":
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("key_phase_1_collect_arms", "town_comment_vo");
      break;

    case "mpq_zom_r_arm_part":
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("key_phase_1_collect_arms", "town_comment_vo");
      break;

    case "mpq_zom_l_leg_part":
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("key_phase_1_collect_legs", "town_comment_vo");
      break;

    case "mpq_zom_r_leg_part":
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("key_phase_1_collect_legs", "town_comment_vo");
      break;
  }

  var_2.fx_ent setscriptablepartstate("muzzle_fx", "inactive");
  wait(0.1);
  if(isDefined(var_2.fx_ent)) {
    var_2.fx_ent delete();
  }
}

set_quest_omnvar_by_targetname(var_0) {
  var_1 = 0;
  switch (var_0.var_336) {
    case "mpq_zom_head_part":
      var_1 = 1;
      break;

    case "mpq_zom_torso_part":
      var_1 = 6;
      break;

    case "mpq_zom_l_arm_part":
      var_1 = 2;
      break;

    case "mpq_zom_r_arm_part":
      var_1 = 3;
      break;

    case "mpq_zom_l_leg_part":
      var_1 = 4;
      break;

    case "mpq_zom_r_leg_part":
      var_1 = 5;
      break;

    case "mpq_punch_card":
      var_1 = 10;
      break;

    case "car_mirror_ground":
    case "mirror":
      var_1 = 7;
      break;

    case "elvira_mirror":
      var_1 = 8;
      break;

    case "bathroom_mirror_piece":
      var_1 = 9;
      break;
  }

  if(var_1 > 0) {
    scripts\cp\utility::set_quest_icon(var_1);
  }
}

listen_for_power_handle() {
  level.mpq_zom_body_parts["left_arm"].high_point = level.mpq_zom_body_parts["left_arm"].origin[2];
  var_0 = scripts\engine\utility::getstructarray("mpq_zom_body_part", "script_noteworthy");
  var_1 = scripts\engine\utility::getclosest(level.mpq_zom_body_parts["left_arm"].origin, var_0);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_1);
  scripts\engine\utility::flag_wait("found_missing_handle");
  level thread play_arm_fx(0.25);
  level.mpq_zom_body_parts["left_arm"] movez(-16, 1);
  scripts\engine\utility::flag_set("allow_quake_lifts_arm");
  scripts\engine\utility::flag_wait("quake_lifts_arm");
}

play_arm_fx(var_0) {
  playFX(level._effect["vfx_mini_stuck_impact"], level.mpq_zom_body_parts["left_arm"].origin);
}

listen_for_leg_damage() {
  var_0 = level.mpq_zom_body_parts["left_leg"];
  var_0 setCanDamage(1);
  var_1 = 0;
  while(!var_1) {
    var_0 waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B);
    if(isDefined(var_6) && is_explosive(var_6, var_8)) {
      var_1 = 1;
      break;
    }

    wait(0.1);
  }

  knock_leg_down(var_0);
  level.leg_knocked_down = 1;
}

knock_leg_down(var_0) {
  var_1 = getent("mpq_zom_l_leg_part_ground", "targetname");
  if(isDefined(var_1)) {
    var_0 moveto(var_1.origin, 1);
    var_0 rotateto(var_1.angles, 1);
    wait(1);
    var_1.fx_ent = var_0.fx_ent;
    var_1 show();
    var_1.fx_ent.origin = var_1.origin + (25, 10, 0);
    var_1.fx_ent setModel("tag_origin_limb_glow_fx");
    var_0 hide();
  }
}

is_explosive(var_0, var_1) {
  return var_0 == "MOD_EXPLOSIVE_BULLET" || var_0 == "MOD_EXPLOSIVE" || var_0 == "MOD_GRENADE_SPLASH" || var_0 == "MOD_PROJECTILE" || var_0 == "MOD_PROJECTILE_SPLASH";
}

set_quake_flag_if_close_to_arm() {
  self endon("death");
  if(scripts\engine\utility::flag("quake_lifts_arm")) {
    return;
  }

  var_0 = 10000;
  var_1 = level.mpq_zom_body_parts["left_arm"];
  if(distancesquared(self.origin, var_1.origin) < var_0) {
    lift_arm_out_of_ground(var_1);
  }
}

lift_arm_out_of_ground(var_0) {
  self endon("death");
  wait(1);
  var_1 = 0;
  var_2 = var_0.origin + (0, 0, 16);
  while(var_0.origin[2] < var_0.high_point) {
    if(scripts\engine\utility::flag("allow_quake_lifts_arm")) {
      playFX(level._effect["vfx_mini_stuck_release"], var_2);
      var_0 movez(4, 0.25);
    }

    wait(3);
  }

  if(scripts\engine\utility::flag("allow_quake_lifts_arm")) {
    scripts\engine\utility::flag_set("quake_lifts_arm");
  }
}

mirror_init_func(var_0, var_1) {
  level.mirrors_picked_up = [];
}

mirror_hint_func(var_0, var_1) {
  return "";
}

mirror_activation_func(var_0, var_1) {
  if(level.mirrors_picked_up.size > 2) {
    return;
  }

  var_2 = var_0.name;
  if(isDefined(level.mirrors_picked_up[var_2])) {
    return;
  }

  if(var_2 == "car_mirror") {
    if(level.car_mirror_hit) {
      var_3 = getent("car_mirror_ground", "targetname");
      set_quest_omnvar_by_targetname(var_3);
      var_1 playlocalsound("part_pickup");
      playFX(level._effect["generic_pickup"], var_3.origin);
      var_3 delete();
      level.mirrors_picked_up[var_2] = 1;
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("key_phase_1_collect_mirror", "town_comment_vo");
      return;
    }

    return;
  }

  if(var_3 == "bathroom_mirror") {
    if(level.bathroom_mirror_hit) {
      var_3 = getent("bathroom_mirror_piece", "targetname");
      set_quest_omnvar_by_targetname(var_3);
      var_1 playlocalsound("part_pickup");
      playFX(level._effect["generic_pickup"], var_3.origin);
      var_3 delete();
      level.mirrors_picked_up[var_2] = 1;
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("key_phase_1_collect_mirror", "town_comment_vo");
      return;
    }
  }
}

elvira_is_up() {
  if(isDefined(level.elvira_ai)) {
    return 0;
  }

  return 1;
}

mirror_placement_init_func(var_0, var_1) {
  level.mirrors_placed = [];
  level thread listen_for_mirror_damage();
}

mirror_placement_hint_func(var_0, var_1) {
  return "";
}

mirror_placement_activation_func(var_0, var_1) {
  if(level.mirrors_placed.size > 2) {
    return;
  }

  var_2 = var_0.name;
  if(!isDefined(level.mirrors_picked_up[var_2])) {
    return;
  }

  if(isDefined(level.mirrors_placed[var_2])) {
    return;
  }

  var_3 = scripts\engine\utility::getstruct(var_0.target, "targetname");
  var_4 = spawn("script_model", var_3.origin);
  var_4.angles = var_3.angles;
  var_4 setModel(var_3.script_noteworthy);
  level.mirrors_placed[var_2] = 1;
}

get_model_for_mirror(var_0) {
  var_1 = "";
  switch (var_0.name) {
    case "car_mirror":
      var_1 = "veh_civ_lnd_39_coupe_mirror_lft_frt_dmg";
      break;

    case "bathroom_mirror":
      var_1 = "cp_town_broken_mirror_shard";
      break;

    case "elvira_mirror":
      var_1 = "cp_town_elvira_mirror";
      break;

    default:
      break;
  }

  return var_1;
}

listen_for_mirror_damage() {
  var_0 = getent("mirror_car", "targetname");
  var_0 hidepart("tag_mirror_right");
  var_1 = getent("car_mirror", "targetname");
  var_1 thread hide_on_damage();
  var_2 = getent("bathroom_mirror", "targetname");
  var_2 thread break_mirror_in_bathroom();
  var_3 = getent("frozen_meat", "targetname");
  var_3 thread freeze_meat_in_locker();
}

hide_on_damage() {
  level.car_mirror_hit = 0;
  self setCanDamage(1);
  var_0 = getent("car_mirror_ground", "targetname");
  var_0 hide();
  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A);
    if(isDefined(var_2) && isplayer(var_2) && var_5 == "MOD_MELEE" && var_2.currentmeleeweapon == "iw7_knife_zm_crowbar") {
      self hide();
      level.car_mirror_hit = 1;
      var_0 = getent("car_mirror_ground", "targetname");
      var_0 show();
      break;
    }
  }

  wait(0.1);
  self delete();
}

break_mirror_in_bathroom() {
  level.bathroom_mirror_hit = 0;
  self setCanDamage(1);
  var_0 = getent("bathroom_mirror_broken", "targetname");
  var_0 hide();
  var_1 = getent("bathroom_mirror_piece", "targetname");
  var_1 hide();
  for(;;) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B);
    if(isDefined(var_3) && isplayer(var_3) && var_6 == "MOD_MELEE" && var_3.currentmeleeweapon == "iw7_knife_zm_crowbar") {
      playFX(level._effect["mirror_break"], (-1060.77, 3661.85, 463.01), (0, 0, -30));
      playsoundatpos((-1060, 3661, 463), "mpq_mirror_shatter");
      self hide();
      level.bathroom_mirror_hit = 1;
      var_0 = getent("bathroom_mirror_broken", "targetname");
      var_0 show();
      var_0C = getent("bathroom_mirror_piece", "targetname");
      var_0C show();
      break;
    }
  }
}

freeze_meat_in_locker() {
  level waittill("start_freeze_trap");
  self setCanDamage(1);
  playFX(level._effect["meat_freeze"], (6263.18, -512, 418.71), (0, 0, -30));
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    if(isDefined(var_1) && isplayer(var_1) && var_4 == "MOD_MELEE" && var_1.currentmeleeweapon == "iw7_knife_zm_crowbar") {
      playFX(level._effect["zombie_freeze_shatter"], (6263.18, -512, 418.71));
      self hide();
      break;
    }
  }

  scripts\engine\utility::flag_set("frozen_meat_gone");
}

punch_card_init_func() {}

punch_card_hint_func(var_0, var_1) {
  return "";
}

punch_card_activation_func(var_0, var_1) {
  var_2 = getent("mpq_punch_card", "targetname");
  var_2 hide();
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("key_phase_1_collect_punchcard_pc", "town_comment_vo");
  set_quest_omnvar_by_targetname(var_2);
  level.punch_card_acquired = 1;
}

garage_door_init_func() {
  wait(5);
  var_0 = getent("garage_door", "targetname");
  var_0 movez(-96, 3, 0.5, 0.1);
}

garage_door_hint_func(var_0, var_1) {
  return "";
}

garage_door_activation_func(var_0, var_1) {
  if(!isDefined(level.garage_key_found)) {
    return;
  }

  if(scripts\engine\utility::istrue(level.garage_door_open)) {
    return;
  }

  var_2 = getent("garage_door", "targetname");
  var_2 movez(96, 3, 0.5, 0.1);
  playsoundatpos((4767, 1233, 431), "town_roll_up_garage_door");
  wait(1);
  var_3 = getent("garage_door_clip", "targetname");
  var_3 notsolid();
  level.garage_door_open = 1;
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("key_phase_1_success_garage", "town_comment_vo");
  var_4 = scripts\cp\zombies\zombies_spawning::create_spawner("gas_station_street", (4795.6, 1395.2, 344), (0, 163, 0), "ground_spawn_no_boards", "spawn_ground", "dirt");
  var_4 scripts\cp\zombies\zombies_spawning::make_spawner_active();
}

ray_gun_init_func() {
  level.ray_gun_interaction_structs = [];
  var_0 = scripts\engine\utility::getstructarray("ray_gun_start", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_3 = scripts\engine\utility::getstructarray(var_2.target, "targetname");
    foreach(var_5 in var_3) {
      switch (var_5.script_noteworthy) {
        case "bomb_counter":
          var_2.bomb_counter = var_5;
          var_5.origin = var_5.origin + (-0.1, -0.1, -23.9);
          if(!isDefined(var_5.angles)) {
            var_2.bomb_counter.angles = (0, 0, 0);
          }
          break;

        case "bomb_status":
          var_2.bomb_status = var_5;
          if(!isDefined(var_5.angles)) {
            var_2.bomb_status.angles = (0, 0, 0);
          }
          break;
      }
    }
  }
}

ray_gun_hint_func(var_0, var_1) {
  return "";
}

ray_gun_activation_func(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  if(!isDefined(level.punch_card_added)) {
    if(isDefined(level.punch_card_acquired)) {
      var_2 = getent("mpq_punch_card", "targetname");
      var_2 show();
      var_3 = scripts\engine\utility::getstruct("punch_card_slot", "targetname");
      var_2.origin = var_3.origin;
      var_2.angles = var_3.angles;
      level.punch_card_added = 1;
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("key_phase_1_collect_punchcard_generic", "town_comment_vo");
      return;
    }

    return;
  }

  if(level.mpq_zom_parts_picked_up.size < level.mpq_zom_parts.size) {
    return;
  }

  if(!isDefined(level.terminal_unlocked)) {
    ray_gun_terminal(var_2, var_3);
    if(!isDefined(level.terminal_unlocked)) {
      level thread ray_fail_vo(var_3);
      return;
    }

    return;
  }

  if(!isDefined(level.body_made)) {
    var_4 = scripts\engine\utility::getstruct("mirror_laser_start", "targetname");
    playsoundatpos(var_4.origin, "cp_town_life_death_ray");
    wait(1);
    wait(1);
    wait(1);
    bounce_laser("tag_origin_life_ray_fx", "life_ray_beam", "life_ray_burst");
    var_5 = level.mirrors_placed.size > 2;
    var_6 = level.zom_parts_placed.size > 5;
    if(var_5 && var_6) {
      foreach(var_8 in level.mpq_zom_parts) {
        var_8 hide();
        if(isDefined(var_8.fx_ent)) {
          var_8.fx_ent delete();
        }

        if(isDefined(var_8.fx_ent_2)) {
          var_8.fx_ent_2 delete();
        }
      }

      level.knife_throw_target_body show();
      level scripts\cp\utility::set_completed_quest_mark(5);
      level.body_made = 1;
      var_0A = scripts\engine\utility::random(level.players);
      if(isDefined(var_0A.vo_prefix)) {
        switch (var_0A.vo_prefix) {
          case "p1_":
            level thread scripts\cp\cp_vo::try_to_play_vo("sally_life_ray_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            break;

          case "p2_":
            level thread scripts\cp\cp_vo::try_to_play_vo("pdex_life_ray_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            break;

          case "p3_":
            level thread scripts\cp\cp_vo::try_to_play_vo("andre_life_ray_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            break;

          case "p4_":
            level thread scripts\cp\cp_vo::try_to_play_vo("aj_life_ray_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            break;

          default:
            break;
        }

        return;
      }

      return;
    }

    return;
  }

  if(!isDefined(level.polarity_reversed)) {
    ray_gun_terminal(var_6, var_7);
    if(!isDefined(level.polarity_reversed)) {
      level thread ray_fail_vo(var_7);
      return;
    }

    return;
  }

  if(!isDefined(level.key_spawned)) {
    var_0B = 1;
    if(var_0B) {
      level.key_spawned = 1;
      var_4 = scripts\engine\utility::getstruct("mirror_laser_start", "targetname");
      playsoundatpos(var_0B.origin, "cp_town_life_death_ray");
      wait(1);
      wait(1);
      wait(1);
      bounce_laser("tag_origin_death_ray_fx", "death_ray_beam", "death_ray_vaporize");
      level thread ray_fail_vo(var_6);
      level.knife_throw_target_body hide();
      spawn_garage_key(level.knife_throw_target_body.origin);
      var_0A = scripts\engine\utility::random(level.players);
      if(isDefined(var_0A.vo_prefix)) {
        switch (var_0A.vo_prefix) {
          case "p1_":
            level thread scripts\cp\cp_vo::try_to_play_vo("sally_death_ray_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            break;

          case "p2_":
            level thread scripts\cp\cp_vo::try_to_play_vo("pdex_death_ray_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            break;

          case "p3_":
            level thread scripts\cp\cp_vo::try_to_play_vo("andre_death_ray_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            break;

          case "p4_":
            level thread scripts\cp\cp_vo::try_to_play_vo("aj_death_ray_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            break;

          default:
            break;
        }

        return;
      }

      return;
    }

    return;
  }
}

ray_fail_vo(var_0) {
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("key_phase_1_fail_liferay", "town_comment_vo");
}

bounce_laser(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getstruct("mirror_laser_start", "targetname");
  var_4 = spawn("script_model", var_3.origin);
  var_4.angles = var_3.angles;
  var_4 setModel(var_0);
  wait(1);
  var_5 = scripts\engine\utility::getstruct("mirror_spot_1", "targetname");
  if(!scripts\engine\utility::istrue(level.mirrors_placed["bathroom_mirror"])) {
    var_5 = scripts\engine\utility::getstruct("mirror_spot_1", "targetname");
    if(!isDefined(var_3.angles)) {
      var_3.angles = (0, 0, 0);
    }

    playfxbetweenpoints(level._effect[var_1], var_3.origin, var_3.angles, var_5.origin);
    wait(0.1);
    var_4 delete();
    return;
  }

  if(!isDefined(var_3.angles)) {
    var_3.angles = (0, 0, 0);
  }

  playfxbetweenpoints(level._effect[var_1], var_3.origin, var_3.angles, var_5.origin);
  wait(0.1);
  var_3 = var_5;
  var_5 = scripts\engine\utility::getstruct("mirror_spot_2", "targetname");
  if(!scripts\engine\utility::istrue(level.mirrors_placed["elvira_mirror"])) {
    var_5 = scripts\engine\utility::getstruct("mirror_spot_2", "targetname");
    if(!isDefined(var_3.angles)) {
      var_3.angles = (0, 0, 0);
    }

    playfxbetweenpoints(level._effect[var_1], var_3.origin, var_3.angles, var_5.origin);
    wait(0.1);
    var_4 delete();
    return;
  }

  if(!isDefined(var_3.angles)) {
    var_3.angles = (0, 0, 0);
  }

  playfxbetweenpoints(level._effect[var_1], var_3.origin, var_3.angles, var_5.origin);
  wait(0.1);
  var_3 = var_5;
  var_5 = scripts\engine\utility::getstruct("mirror_spot_3", "targetname");
  if(!scripts\engine\utility::istrue(level.mirrors_placed["car_mirror"])) {
    var_5 = scripts\engine\utility::getstruct("mirror_spot_3", "targetname");
    if(!isDefined(var_3.angles)) {
      var_3.angles = (0, 0, 0);
    }

    playfxbetweenpoints(level._effect[var_1], var_3.origin, var_3.angles, var_5.origin);
    wait(0.1);
    var_4 delete();
    return;
  }

  if(!isDefined(var_3.angles)) {
    var_3.angles = (0, 0, 0);
  }

  playfxbetweenpoints(level._effect[var_1], var_3.origin, var_3.angles, var_5.origin);
  wait(0.1);
  var_3 = var_5;
  var_5 = level.life_ray_end;
  if(!isDefined(var_3.angles)) {
    var_3.angles = (0, 0, 0);
  }

  playfxbetweenpoints(level._effect[var_1], var_3.origin, var_3.angles, var_5.origin);
  wait(0.1);
  playFX(level._effect[var_2], var_5.origin);
  var_4 delete();
}

stop_and_fire() {
  var_0 = 1440000;
  var_1 = level.spawned_enemies;
  var_2 = undefined;
  foreach(var_4 in var_1) {
    if(distance2dsquared(var_4.origin, self.origin) < var_0) {
      var_2 = var_4;
      break;
    }
  }

  if(!isDefined(var_2)) {
    return;
  }

  wait(5);
  playFXOnTag(level._effect["death_ray_cannon_muzzle_flash"], self, "tag_origin");
  var_6 = self gettagorigin("tag_origin");
  var_7 = self gettagangles("tag_origin");
  playfxbetweenpoints(level._effect["death_ray_cannon_beam"], var_6, var_7, var_2.origin);
  playFX(level._effect["death_ray_cannon_rock_impact"], var_2.origin);
  level thread make_glowing_zombies(var_2.origin);
  wait(5);
}

make_glowing_zombies(var_0) {
  var_1 = 160000;
  var_2 = sortbydistance(level.spawned_enemies, var_0);
  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(distance2dsquared(var_2[var_3].origin, var_0) > var_1) {
      break;
    }

    var_2[var_3] set_glow_attributes();
  }
}

listen_for_zombie_spawn() {
  for(;;) {
    level waittill("agent_spawned", var_0);
    if(isDefined(var_0) && isDefined(var_0.agent_type) && var_0.agent_type == "generic_zombie") {
      if(scripts\engine\utility::istrue(var_0.is_soldier)) {
        var_0 set_glow_attributes();
      }
    }
  }
}

set_glow_attributes() {
  self.glowing = 1;
  self.full_gib = 1;
  self.nocorpse = 1;
  self.gib_fx_override = "ufo_glow_death";
  self setscriptablepartstate("ufo_glow", "active", 1);
  self.synctransients = "sprint";
}

listen_for_death_by_cleaver() {
  level.death_by_cleaver = 0;
  while(!level.death_by_cleaver) {
    scripts\engine\utility::waitframe();
  }

  var_0 = scripts\engine\utility::getstructarray("mpq_zom_body_part", "script_noteworthy");
  var_1 = scripts\engine\utility::getclosest(level.mpq_zom_body_parts["right_leg"].origin, var_0);
  level.mpq_zom_body_parts["right_leg"] notsolid();
  level.mpq_zom_body_parts["right_leg"].origin = level.death_by_cleaver_org + (0, 0, -5);
  var_1.origin = level.death_by_cleaver_org + (-20, 10, 10);
  level.mpq_zom_body_parts["right_leg"].fx_ent = spawn("script_model", level.death_by_cleaver_org + (-20, 10, 0));
  level.mpq_zom_body_parts["right_leg"].fx_ent setModel("tag_origin_limb_glow_fx");
}

spawn_film_reel_hints() {
  var_0 = spawn("script_model", (4070, -4190, 16));
  wait(0.1);
  var_0 setModel("cp_town_film_reel_case");
}

listen_for_toilet_head() {
  level endon("game_ended");
  while(!isDefined(level.players)) {
    wait(0.1);
  }

  var_0 = scripts\engine\utility::getstruct("toilet_head", "targetname");
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  level.toilet_head = spawn("script_model", var_1);
  level.toilet_head setModel("zmb_male_head_01");
  level.toilet_head.angles = var_2;
  var_3 = scripts\engine\utility::getstruct("toilet_head_spot", "targetname");
  var_4 = 0;
  var_5 = 1600;
  while(!var_4) {
    foreach(var_7 in level.players) {
      if(distance2dsquared(var_3.origin, var_7.origin) < var_5) {
        var_8 = 0;
        var_9 = var_7 getstance();
        if(isDefined(var_7.chemical_base_picked) && var_7.chemical_base_picked == "animalfat" && var_9 == "prone") {
          var_8 = 1;
          level.toilet_head playSound("zmb_vo_base_male_pain");
          var_7 setclientomnvar("zm_chem_element_index", 0);
          var_7.chemical_base_picked = undefined;
        }

        lift_head(var_8, var_7);
        var_4 = 1;
        break;
      }
    }

    wait(0.1);
  }

  level.toilet_head delete();
}

lift_head(var_0, var_1) {
  level.toilet_head movez(5, 2, 0.1, 0.1);
  wait(5);
  if(var_0 == 1) {
    var_1 scripts\cp\cp_merits::processmerit("mt_dlc3_troll2");
  }

  level.toilet_head movez(-8, 2, 0.1, 0.1);
  wait(3);
}

ray_gun_terminal(var_0, var_1) {
  enter_detonate_bomb_sequence(var_0, var_1);
  enter_bomb_code_internal(var_0, var_1);
}

assign_nuclear_code(var_0, var_1, var_2) {
  var_0.ray_gun_code = [];
  if(var_2) {
    for(var_3 = 5; var_3 > 0; var_3--) {
      var_0.ray_gun_code[5 - var_3] = var_1[var_3 - 1];
    }

    return;
  }

  for(var_3 = 0; var_3 < 5; var_3++) {
    var_0.ray_gun_code[var_3] = var_1[var_3];
  }
}

shuffle_film_reels() {
  var_0 = [3, 4, 5, 6, 8];
  var_1 = scripts\engine\utility::array_randomize(var_0);
  for(var_2 = 1; var_2 < 6; var_2++) {
    var_3 = getent("film_reel_" + var_2, "targetname");
    var_3 setModel("cp_town_film_reel_case_" + var_1[var_2 - 1]);
    wait(0.1);
  }

  level.liferaycode = var_1;
}

enter_detonate_bomb_sequence(var_0, var_1) {
  turn_off_other_hud(var_1);
  turn_on_bomb_status_light(var_0);
  var_1 allowmelee(0);
  var_1 getradiuspathsighttestnodes();
  var_1 scripts\engine\utility::allow_weapon_switch(0);
}

enter_bomb_code_internal(var_0, var_1) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_1.bomb_interaction_struct = var_0;
  if(!isDefined(level.terminal_unlocked)) {
    assign_nuclear_code(var_1, level.liferaycode, 0);
  } else {
    assign_nuclear_code(var_1, level.liferaycode, 1);
  }

  reset_nuclear_code_progress(var_1);
  transition_into_enter_bomb_code(var_0, var_1);
  turn_on_enter_bomb_code_hud(var_1, var_0);
  var_0 thread run_bomb_counters(var_1, var_0);
  var_0 thread bomb_counter_selected_monitor(var_1, var_0);
  var_0 thread player_exit_monitor(var_1, var_0);
  var_0 thread player_damage_exit_monitor(var_1, var_0);
}

turn_on_bomb_status_light(var_0) {
  var_1 = spawn("script_model", (4102.2, -4242.1, 51));
  var_1 setModel("crab_boss_origin");
  var_1.angles = var_0.bomb_status.angles;
  var_1 setscriptablepartstate("bomb_status", "red");
  var_0.bomb_status_light = var_1;
}

reset_nuclear_code_progress(var_0) {
  var_0 setclientomnvar("zm_ui_dialpad_1", -1);
  var_0 setclientomnvar("zm_ui_dialpad_5", 0);
  var_0.ray_gun_code_progress_index = 0;
  var_0.completed_ray_gun_code = "";
  var_0.times_input_wrong_digits = 0;
}

transition_into_enter_bomb_code(var_0, var_1) {
  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel("tag_origin");
  var_2.angles = var_0.angles + (34, 0, 0);
  var_2.origin = var_0.origin + scripts\cp\utility::vec_multiply(anglesToForward(var_0.angles), 3);
  var_0.anchor = var_2;
}

run_bomb_counters(var_0, var_1) {
  var_0 endon("disconnect");
  var_1 endon("stop_bomb_counter");
  for(;;) {
    for(var_2 = 0; var_2 < 10; var_2++) {
      var_0 setclientomnvar("zm_ui_dialpad_0", var_2 + 1);
      wait(0.1);
    }
  }
}

bomb_counter_selected_monitor(var_0, var_1) {
  var_0 endon("disconnect");
  var_1 endon("stop_bomb_counter");
  for(;;) {
    var_0 waittill("luinotifyserver", var_2, var_3);
    if(var_2 != "bomb_counter_digit") {
      continue;
    }

    if(correct_digit_entered(var_0, var_3)) {
      advance_nuclear_code_progress(var_0, var_3);
      if(nuclear_code_completed(var_0)) {
        player_complete_nuclear_code(var_1, var_0);
      }

      continue;
    }

    input_wrong_digit(var_1, var_0);
  }
}

player_damage_exit_monitor(var_0, var_1) {
  var_0 endon("disconnect");
  var_1 endon("stop_bomb_counter");
  for(;;) {
    var_0 waittill("damage");
    var_0 notify("luinotifyserver", "exit_bomb_counter");
  }
}

player_exit_monitor(var_0, var_1) {
  var_0 endon("disconnect");
  var_1 endon("stop_bomb_counter");
  for(;;) {
    var_0 waittill("luinotifyserver", var_2);
    if(var_2 != "exit_bomb_counter") {
      continue;
    }

    var_1 thread delay_enable_interaction(var_1);
    var_1 thread exit_enter_bomb_code(var_1, var_0);
  }
}

turn_on_enter_bomb_code_hud(var_0, var_1) {
  var_2 = spawn("script_model", var_1.bomb_counter.origin);
  var_2 setModel("tag_origin");
  var_2.origin = var_2.origin + (-0.2, 0.25, 0);
  var_2.angles = (0, 335, 0);
  var_2.angles = var_1.bomb_counter.angles;
  var_2.angles = (0, 340.5, 0);
  var_1.bomb_counter_ent = var_2;
  var_0 setclientomnvar("zm_ui_dialpad_ent", var_2);
  var_0 setclientomnvar("zm_ui_dialpad_2", 2);
}

turn_off_enter_bomb_code_hud(var_0) {
  var_0 setclientomnvar("zm_ui_dialpad_2", 0);
}

reset_bomb_interaction_struct() {
  level.num_of_ray_gun_code_entered = 0;
  foreach(var_1 in level.ray_gun_interaction_structs) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
  }
}

correct_digit_entered(var_0, var_1) {
  return var_1 == var_0.ray_gun_code[var_0.ray_gun_code_progress_index];
}

input_wrong_digit(var_0, var_1) {
  var_1.times_input_wrong_digits++;
  var_1 setclientomnvar("zm_ui_dialpad_5", var_1.times_input_wrong_digits);
  if(var_1.times_input_wrong_digits == 3) {
    wait(1);
    var_0 thread delay_enable_interaction(var_0);
    var_0 thread exit_enter_bomb_code(var_0, var_1);
  }
}

advance_nuclear_code_progress(var_0, var_1) {
  var_0.ray_gun_code_progress_index++;
  var_0.completed_ray_gun_code = var_0.completed_ray_gun_code + var_1;
  var_0 setclientomnvar("zm_ui_dialpad_1", int(var_0.completed_ray_gun_code));
}

nuclear_code_completed(var_0) {
  return var_0.ray_gun_code_progress_index == 5;
}

player_complete_nuclear_code(var_0, var_1) {
  var_1 setclientomnvar("zm_ui_dialpad_5", 4);
  wait(2);
  level thread nuclear_bomb_armed_sequence(var_1);
  var_0.bomb_status_light setscriptablepartstate("bomb_status", "green");
  exit_enter_bomb_code(var_0, var_1);
}

delay_enable_interaction(var_0) {
  wait(0.5);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

exit_enter_bomb_code(var_0, var_1) {
  end_detonate_bomb(var_1);
  var_0.anchor delete();
  var_1.bomb_interaction_struct = undefined;
  thread delay_enable_interaction(var_0);
  var_0 notify("stop_bomb_counter");
}

nuclear_bomb_armed_sequence(var_0) {
  if(!scripts\engine\utility::istrue(level.terminal_unlocked)) {
    level.terminal_unlocked = 1;
    return;
  }

  level.polarity_reversed = 1;
  var_1 = getEntArray("death_ray_sign", "targetname");
  foreach(var_3 in var_1) {
    var_3 setModel("cp_town_camp_danger_deathraysign");
  }
}

end_detonate_bomb(var_0) {
  exit_detonate_bomb_sequence(var_0);
}

clean_up_bomb_interaction_struct(var_0) {
  if(isDefined(var_0.bomb_counter_ent)) {
    var_0.bomb_counter_ent delete();
  }

  if(isDefined(var_0.bomb_status_light)) {
    var_0.bomb_status_light delete();
  }
}

exit_detonate_bomb_sequence(var_0) {
  turn_off_enter_bomb_code_hud(var_0);
  turn_on_other_hud(var_0);
  var_0 enableweapons();
  var_0 scripts\engine\utility::allow_weapon_switch(1);
  var_0 allowmelee(1);
}

turn_off_other_hud(var_0) {
  var_0 setclientomnvar("zm_ui_dialpad_4", 1);
}

turn_on_other_hud(var_0) {
  var_0 setclientomnvar("zm_ui_dialpad_4", 0);
}

listen_for_turnstile_damage() {
  var_0 = getent("turnstile", "targetname");
  if(isDefined(var_0)) {
    var_0 setCanDamage(1);
    for(;;) {
      var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A);
      if(isDefined(var_2) && isplayer(var_2)) {
        playFX(level._effect["turnstile_teleport"], var_0.origin);
        var_0 hide();
        var_2 scripts\cp\cp_merits::processmerit("mt_dlc3_troll");
        break;
      }

      wait(0.1);
    }
  }
}

listen_for_photo_change() {
  level waittill("crab_boss_beaten");
  var_0 = getent("hero_photo", "targetname");
  var_0 setModel("cp_town_space_hero_photos_01");
}

phase3_watch_gauge_trigs() {
  level endon("deathray_step1");
  self.gauge = getent(self.target, "targetname");
  self.gauge thread phase3_gauge_movement_logic();
  if(!isDefined(level.gauges)) {
    level.gauges = [];
  }

  level.gauges = scripts\engine\utility::array_add(level.gauges, self.gauge);
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    if(isDefined(var_1) && isplayer(var_1) && var_4 == "MOD_MELEE" && var_1.currentmeleeweapon == "iw7_knife_zm_crowbar") {
      self.gauge playSound("mpq_gauge_hit");
      if(scripts\engine\utility::istrue(self.gauge.stuck)) {
        self.gauge.current_value = undefined;
        self.gauge.current_reading = undefined;
        self.gauge.stuck = undefined;
        self.gauge thread phase3_gauge_movement_logic();
        continue;
      } else {
        var_0A = self.gauge.angles;
        self.gauge notify("damaged");
        wait(0.1);
        self.gauge.angles = var_0A;
        self.gauge.current_value = var_0A;
        self.gauge.current_reading = phase3_get_gauge_reading(self.gauge);
        self.gauge.stuck = 1;
        var_0B = phase3_check_for_combo_complete();
        if(var_0B) {
          scripts\engine\utility::flag_set("launchcode_step1");
          return;
        }
      }
    }
  }
}

phase3_open_safe() {
  scripts\engine\utility::exploder(200);
  earthquake(0.45, 1, level.safe.origin, 256);
  playsoundatpos(level.safe.origin, "mpq_safe_open");
  level.safe setModel("cp_town_safe_open");
  var_0 = scripts\engine\utility::getstruct("take_launchcodes", "script_noteworthy");
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
  var_1 = scripts\engine\utility::random(level.players);
  if(isDefined(var_1.vo_prefix)) {
    switch (var_1.vo_prefix) {
      case "p1_":
        level thread scripts\cp\cp_vo::try_to_play_vo("sally_safe_unlock_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        break;

      case "p2_":
        level thread scripts\cp\cp_vo::try_to_play_vo("pdex_safe_unlock_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        break;

      case "p3_":
        level thread scripts\cp\cp_vo::try_to_play_vo("andre_safe_unlock_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        break;

      case "p4_":
        level thread scripts\cp\cp_vo::try_to_play_vo("aj_safe_unlock_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        break;

      default:
        break;
    }
  }
}

phase3_take_launch_codes(var_0, var_1) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_2 = getent(var_0.target, "targetname");
  playFX(level._effect["generic_pickup"], var_2.origin);
  var_1 playlocalsound("zmb_item_pickup");
  var_2 delete();
  scripts\engine\utility::flag_set("launchcode_step2");
}

phase3_take_bomb_part(var_0, var_1) {
  var_2 = getent(var_0.target, "targetname");
  if(!isDefined(var_2)) {
    return;
  }

  switch (var_2.model) {
    case "cp_town_teleporter_device_projector":
      if(var_1 getstance() != "prone") {
        return;
      }

      scripts\cp\utility::set_quest_icon(16);
      break;

    case "cp_town_teleporter_device_pipes":
      scripts\cp\utility::set_quest_icon(17);
      break;

    default:
      scripts\cp\utility::set_quest_icon(18);
      break;
  }

  playFX(level._effect["generic_pickup"], var_2.origin);
  var_1 playlocalsound("zmb_item_pickup");
  level.teleporter_pieces_found++;
  var_2 delete();
}

phase3_get_gauge_reading(var_0) {
  var_1 = 0;
  if(isDefined(var_0.current_value)) {
    var_2 = int(var_0.current_value[2]);
    if(is_in_range(var_2, 70, 75)) {
      var_1 = 0;
      var_0._current_value = (0, 0, 75);
      var_0.angles = (var_0.angles[0], var_0.angles[1], 75);
    } else if(is_in_range(var_2, 59, 69)) {
      var_1 = 1;
      var_0._current_value = (var_0.angles[0], var_0.angles[1], 65);
      var_0.angles = (var_0.angles[0], var_0.angles[1], 65);
    } else if(is_in_range(var_2, 44, 58)) {
      var_1 = 2;
      var_0._current_value = (var_0.angles[0], var_0.angles[1], 50);
      var_0.angles = (var_0.angles[0], var_0.angles[1], 50);
    } else if(is_in_range(var_2, 28, 43)) {
      var_1 = 3;
      var_0._current_value = (var_0.angles[0], var_0.angles[1], 33);
      var_0.angles = (var_0.angles[0], var_0.angles[1], 33);
    } else if(is_in_range(var_2, 10, 27)) {
      var_1 = 4;
      var_0._current_value = (var_0.angles[0], var_0.angles[1], 15);
      var_0.angles = (var_0.angles[0], var_0.angles[1], 15);
    } else if(is_in_range(var_2, -7, 9)) {
      var_1 = 5;
      var_0._current_value = (var_0.angles[0], var_0.angles[1], 0);
      var_0.angles = (var_0.angles[0], var_0.angles[1], 0);
    } else if(is_in_range(var_2, -20, -8)) {
      var_1 = 6;
      var_0._current_value = (var_0.angles[0], var_0.angles[1], -15);
      var_0.angles = (var_0.angles[0], var_0.angles[1], -15);
    } else if(is_in_range(var_2, -35, -21)) {
      var_1 = 7;
      var_0._current_value = (var_0.angles[0], var_0.angles[1], -32);
      var_0.angles = (var_0.angles[0], var_0.angles[1], -32);
    } else if(is_in_range(var_2, -50, -36)) {
      var_1 = 8;
      var_0._current_value = (var_0.angles[0], var_0.angles[1], -45);
      var_0.angles = (var_0.angles[0], var_0.angles[1], -45);
    } else if(is_in_range(var_2, -69, -51)) {
      var_1 = 9;
      var_0._current_value = (var_0.angles[0], var_0.angles[1], -62);
      var_0.angles = (var_0.angles[0], var_0.angles[1], -62);
    } else {
      var_1 = 10;
      var_0._current_value = (0, 0, -75);
      var_0.angles = (var_0.angles[0], var_0.angles[1], -75);
    }
  } else {
    var_1 = 0;
  }

  if(var_1 > 0) {
    var_3 = var_1;
  } else {
    var_3 = 0;
  }

  return var_3;
}

is_in_range(var_0, var_1, var_2) {
  if(var_0 >= var_1 && var_0 <= var_2) {
    return 1;
  }

  if(var_0 + 360 >= var_1 && var_0 + 360 <= var_2) {
    return 1;
  }

  if(var_0 - 360 >= var_1 && var_0 - 360 <= var_2) {
    return 1;
  }

  return 0;
}

phase3_gauge_movement_logic() {
  self endon("damaged");
  if(isDefined(self.og_angles)) {
    self.angles = self.og_angles;
  } else {
    self.og_angles = self.angles;
  }

  self rotateto((self.angles[0], self.angles[1], -75), randomfloatrange(0.15, 0.4));
  self waittill("rotatedone");
  wait(0.1);
  for(;;) {
    wait(randomfloatrange(0.25, 1.6));
    self rotateto((self.angles[0], self.angles[1], 75), randomfloatrange(3, 4));
    self waittill("rotatedone");
    wait(randomfloatrange(0.25, 1.6));
    self rotateto((self.angles[0], self.angles[1], -75), randomfloatrange(3, 4));
    self waittill("rotatedone");
  }
}

phase3_create_safe_combo() {
  wait(20);
  level.combo_numbers = [];
  level.combo_numbers["1"] = "geneva_building_number_signs_07";
  level.combo_numbers["2"] = "geneva_building_number_signs_01";
  level.combo_numbers["4"] = "geneva_building_number_signs_4_fix";
  level.combo_numbers["6"] = "geneva_building_number_signs_13";
  level.combo_numbers["7"] = "geneva_building_number_signs_04";
  level.combo_numbers["8"] = "geneva_building_number_signs_10";
  level.combo_numbers["9"] = "geneva_building_number_signs_19";
  var_0 = ["1", "2", "4", "6", "7", "8", "9"];
  var_1 = [];
  var_2 = "";
  var_3 = [];
  var_4 = getEntArray("pressure_numbers", "targetname");
  for(var_5 = 0; var_5 < 4; var_5++) {
    var_6 = scripts\engine\utility::random(var_0);
    var_7 = level.combo_numbers[var_6];
    if(var_5 < 3) {
      var_2 = var_2 + "" + var_6 + ",";
    } else {
      var_2 = var_2 + "" + var_6 + "";
    }

    var_4[var_5] setModel(var_7);
  }

  level.combo_numbers = var_2;
}

phase3_check_for_combo_complete() {
  var_0 = strtok(level.combo_numbers, ",");
  foreach(var_2 in level.gauges) {
    if(!isDefined(var_2.current_reading)) {
      return 0;
    }

    if(scripts\engine\utility::array_contains(var_0, "" + var_2.current_reading)) {
      var_3 = 0;
      var_4 = [];
      foreach(var_6 in var_0) {
        if(var_6 == "" + var_2.current_reading && !var_3) {
          var_3 = 1;
          continue;
        }

        var_4[var_4.size] = var_6;
      }

      var_0 = var_4;
      continue;
    }

    return 0;
  }

  return 1;
}

phase3_place_bomb_parts_hint(var_0, var_1) {
  if(scripts\engine\utility::flag("teleporter_charged")) {
    return &"CP_TOWN_INTERACTIONS_TELEPORT_READY";
  }

  if(level.teleporter_pieces_placed < level.teleporter_pieces_found) {
    return &"CP_TOWN_INTERACTIONS_PLACE_BOMB_PIECE";
  }

  if(scripts\engine\utility::flag("chemistry_step3") && !scripts\engine\utility::flag("chemistry_step4")) {
    return &"CP_TOWN_INTERACTIONS_ADD_CHEMS";
  }

  if(scripts\engine\utility::flag("chemistry_step4") && scripts\engine\utility::flag("launchcode_step2") && scripts\engine\utility::flag("launchcode_step3") && !scripts\engine\utility::flag("launchcode_step4")) {
    return &"CP_TOWN_INTERACTIONS_ACTIVATE_TELEPORT";
  }

  return "";
}

phase3_place_bomb_parts(var_0, var_1) {
  if(scripts\engine\utility::flag("chemistry_step3") && !scripts\engine\utility::flag("chemistry_step4")) {
    if(isDefined(var_1.chemical_base_picked) && var_1.chemical_base_picked == level.bomb_compound.name) {
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("key_phase_3_success_bomb_const", "town_comment_vo");
      scripts\engine\utility::flag_set("chemistry_step4");
      scripts\cp\maps\cp_town\cp_town_chemistry::set_chemical_carried_by_player_after_beaker_deposit(var_1, "");
      var_2 = getent("hero_photo", "targetname");
      var_2 setModel("cp_town_space_hero_photos_02");
      var_1 scripts\cp\cp_interaction::refresh_interaction();
      return;
    } else {
      var_2 scripts\cp\cp_interaction::refresh_interaction();
      return;
    }
  }

  if(scripts\engine\utility::flag("teleporter_charged")) {
    foreach(var_4 in level.players) {
      if(distance2dsquared(var_4.origin, var_1.origin) > 9216) {
        return;
      }

      if(!var_4 usebuttonpressed()) {
        return;
      }
    }

    var_6 = scripts\engine\utility::getstruct("place_bomb_parts", "script_noteworthy");
    var_7 = getent(var_6.target, "targetname");
    var_7 stoploopsound();
    scripts\cp\utility::playsoundinspace("cp_town_bomb_charge_stop", var_7.origin);
    level notify("bomb_teleported");
    var_2 thread scripts\cp\cp_vo::try_to_play_vo("key_phase_3_success_bomb_teleport", "town_comment_vo");
    var_2 scripts\cp\cp_interaction::remove_from_current_interaction_list(var_1);
    level thread phase3_teleport_bomb();
    return;
  }

  if(scripts\engine\utility::flag("chemistry_step4") && scripts\engine\utility::flag("launchcode_step2") && scripts\engine\utility::flag("launchcode_step3") && !scripts\engine\utility::flag("launchcode_step4")) {
    foreach(var_8 in level.players) {
      if(distance2dsquared(var_8.origin, var_5.origin) > 9216) {
        return;
      }

      if(!var_8 usebuttonpressed()) {
        return;
      }
    }

    var_6 thread scripts\cp\cp_vo::try_to_play_vo("boss_charge_portal_first", "town_comment_vo");
    var_6 scripts\cp\cp_interaction::remove_from_current_interaction_list(var_5);
    level thread phase3_charge_bomb_teleporter(var_5);
    return;
  }

  if(level.teleporter_pieces_found != level.teleporter_pieces_placed) {
    var_9 playlocalsound("zmb_coin_sounvenir_place");
  }

  while(level.teleporter_pieces_placed != level.teleporter_pieces_found) {
    level.teleporter_pieces_placed++;
    wait(0.05);
  }

  if(level.teleporter_pieces_placed == 3) {
    scripts\engine\utility::flag_set("launchcode_step3");
    level thread play_teleporter_vo(var_9);
    var_9 scripts\cp\cp_interaction::refresh_interaction();
  }
}

play_teleporter_vo(var_0) {
  var_0 endon("disconnect");
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("key_phase_3_success_teleporter_craft", "town_comment_vo");
  wait(scripts\cp\cp_vo::get_sound_length("key_phase_3_success_teleporter_craft") + 10);
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("boss_charge_portal_generic", "town_comment_vo");
}

phase3_charge_bomb_teleporter(var_0) {
  level endon("bomb_teleported");
  level endon("game_ended");
  var_1 = scripts\engine\utility::getstruct("place_bomb_parts", "script_noteworthy");
  var_2 = getent(var_1.target, "targetname");
  playFXOnTag(level._effect["vfx_bomb_portal_chargeup"], var_2, "tag_bomb");
  var_2 playSound("cp_town_bomb_charge_start");
  var_2 playLoopSound("cp_town_bomb_charge_lp");
  wait(20);
  var_2 stoploopsound("cp_town_bomb_charge_lp");
  var_2 playLoopSound("cp_town_bomb_charged_up_lp");
  stopFXOnTag(level._effect["vfx_bomb_portal_chargeup"], var_2, "tag_bomb");
  playFXOnTag(level._effect["vfx_bomb_portal_charged"], var_2, "tag_bomb");
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
  scripts\engine\utility::flag_set("teleporter_charged");
  scripts\engine\utility::flag_clear("teleporter_charging");
  if(!scripts\engine\utility::istrue(var_0.played_charging_vo)) {
    scripts\cp\cp_vo::try_to_play_vo_on_all_players("boss_charge_portal_complete_first", 0);
    var_0.played_charging_vo = 1;
  } else {
    scripts\cp\cp_vo::try_to_play_vo_on_all_players("boss_charge_portal_complete_generic", 0);
  }

  wait(30);
  var_2 playSound("cp_town_bomb_charge_fail");
  var_2 stoploopsound("cp_town_bomb_charged_up_lp");
  stopFXOnTag(level._effect["vfx_bomb_portal_charged"], var_2, "tag_bomb");
  scripts\engine\utility::flag_clear("teleporter_charged");
  scripts\engine\utility::flag_clear("teleporter_charging");
}

phase3_teleport_bomb() {
  var_0 = scripts\engine\utility::getstruct("place_bomb_parts", "script_noteworthy");
  var_1 = getent(var_0.target, "targetname");
  playFX(level._effect["vfx_bomb_portal_out"], var_1.origin);
  var_1 delete();
  scripts\engine\utility::flag_set("launchcode_step4");
  level notify("crab_boss_quest_completed");
}

phase3_launchcode_interaction() {
  wait(5);
  var_0 = scripts\engine\utility::getstruct("take_launchcodes", "script_noteworthy");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
}

default_init() {}