/****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_sumpf\cp_sumpf_mq.gsc
****************************************************/

init() {
  level thread init_mq_blockers();

  if(!getdvarint("#x33ad41eaa5a9a3eec", 0) == 1) {
    return;
  }
  _id_099C::_id_C211("shinomq", 1, ::init_step_one_reveal_stele, ::do_step_one_reveal_stele, ::cleanup_step_one_reveal_stele, ::debug_step_one_reveal_stele);
  _id_099C::_id_C211("shinomq", 2, ::init_step_two_cypher_wheel, ::do_step_two_cypher_wheel, ::cleanup_step_two_cypher_wheel, ::debug_step_two_cypher_wheel);
  _id_099C::_id_C211("shinomq", 3, ::init_step_three_soul_charge, ::do_step_three_soul_charge, ::cleanup_step_three_soul_charge, ::debug_step_three_soul_charge);
  _id_099C::_id_C211("shinomq", 4, ::init_step_four_saraxis_echo, ::do_step_four_saraxis_echo, ::cleanup_step_four_saraxis_echo, ::debug_step_four_saraxis_echo);
  _id_099C::_id_C211("shinomq", 5, ::init_step_five_mirror, ::do_step_five_mirror, ::cleanup_step_five_mirror, ::debug_step_five_mirror);
  _id_099C::_id_C211("shinomq", 6, ::init_step_six_altar, ::do_step_six_altar, ::cleanup_step_six_altar, ::debug_step_six_altar);
  _id_099C::_id_C211("shinomq", 7, ::init_step_seven_final_fight, ::do_step_seven_final_fight, ::cleanup_step_seven_final_fight, ::debug_step_seven_final_fight);
  level._effect["mq_fragment_ambient_fx"] = loadfx("vfx/s4/zombie/vfx_loot_crystal_idle");
  level._effect["mq_small_stele_interact_fx"] = loadfx("vfx/s4/zombie/vfx_stele_interact");
  level._effect["mq_stele_rune_fx"] = loadfx("vfx/s4/zombie/vfx_central_stele_rune");
  level._effect["mq_stele_cover_remove_fx_01"] = loadfx("vfx/s4/level/cp_sumpf/vfx_leaf_dust_burst");
  level._effect["mq_stele_cover_remove_fx_02"] = loadfx("vfx/s4/level/cp_sumpf/vfx_leaf_dust_burst_02");
  level._effect["mq_stele_cover_remove_fx_03"] = loadfx("vfx/s4/level/cp_sumpf/vfx_leaf_dust_burst_03");
  level._effect["mq_stele_charge_trail"] = loadfx("vfx/s4/zombie/vfx_central_stele_taril");
  level._effect["mq_stele_charge_central_fx_01"] = loadfx("vfx/s4/zombie/vfx_central_stele_stage01");
  level._effect["mq_stele_charge_central_fx_02"] = loadfx("vfx/s4/zombie/vfx_central_stele_stage02");
  level._effect["mq_stele_charge_central_fx_03"] = loadfx("vfx/s4/zombie/vfx_central_stele_stage03");
  level._effect["mq_stele_charge_central_fx_04"] = loadfx("vfx/s4/zombie/vfx_central_stele_stage04");
  level._effect["mq_stele_charge_zombie_fx"] = loadfx("vfx/s4/zombie/vfx_central_stele_zombie_charge");
  level._effect["mq_zombie_stele_charge_trail"] = loadfx("vfx/s4/level/cp_sumpf/vfx_soul_charge");
  level._effect["mq_zombie_blood_blast_fx"] = loadfx("vfx/s4/zombie/vfx_flogger_trap_blood");
  level._effect["mq_glowing_orb_fx"] = loadfx("vfx/s4/level/cp_sumpf/vfx_glow_orb");
  level._effect["mq_glowing_orb_fx_hit"] = loadfx("vfx/s4/level/cp_sumpf/vfx_glow_orb_hit");
  level._effect["mq_flogger_kill_blood_drop"] = loadfx("vfx/s4/zombie/vfx_perk_fountain_liquid_drop");
  level._effect["mq_flogger_kill_blood_drop_sml"] = loadfx("vfx/s4/zombie/vfx_perk_fountain_liquid_drop_sml");
  level._effect["mq_flogger_kill_blood_surface"] = loadfx("vfx/s4/zombie/vfx_perk_fountain_liquid_surface");
  level._effect["mq_zombie_blood_1p_effect"] = loadfx("vfx/s4/zombie_weapon/vfx_fld_aether_shroud_head_1p");
  level._effect["mq_zombie_blood"] = loadfx("vfx/s4/zombie/vfx_screen_fountain_blood");
  level._effect["mq_mirror_part_showup_fx"] = loadfx("vfx/s4/zombie/vfx_ghost_mirror_show");
  level._effect["mq_mirror_part_ambient_fx"] = loadfx("vfx/s4/zombie/vfx_ghost_mirror_ambient");
  level._effect["mq_mirror_part_hit_fx"] = loadfx("vfx/s4/zombie/vfx_ghost_mirror_exp_smk");
  level._effect["mq_mirror_path_finder_orb_fx"] = loadfx("vfx/s4/level/cp_zod/vfx_mq_tome_page_shield");
  level._effect["mq_mirror_ambient_uncharged_fx"] = loadfx("vfx/s4/zombie/vfx_ghost_mirror_broken_ambient");
  level._effect["mq_mirror_ambient_charged_fx"] = loadfx("vfx/s4/zombie/vfx_ghost_mirror_smk_blue");
  level._effect["mq_mirror_fx_to_saraxis"] = loadfx("vfx/s4/zombie/vfx_crystal_hand_trail");
  level._effect["mq_mirror_dome_hold_lrg"] = loadfx("vfx/s4/zombie/vfx_dome_lrg");
  level._effect["mq_mirror_dome_hold_med"] = loadfx("vfx/s4/zombie/vfx_dome_med");
  level._effect["mq_mirror_dome_hold_sml"] = loadfx("vfx/s4/zombie/vfx_dome_sml");
  level._effect["mq_mirror_dome_hold_explosion"] = loadfx("vfx/s4/zombie/vfx_dome_clean");
  level._effect["mq_final_loot_fx"] = loadfx("vfx/s4/zombie/vfx_obj_domination_rune_zmb_spawn");
  level._effect["mq_mirror_atk_exp"] = loadfx("vfx/s4/zombie/vfx_ghost_mirror_elec_fly_exp");
  level._effect["mq_mirror_atk_glow"] = loadfx("vfx/s4/zombie/vfx_ghost_mirror_elec_fly_glow");
  level._effect["mq_mirror_atk_lp"] = loadfx("vfx/s4/zombie/vfx_ghost_mirror_elec_fly_loop");
  level._effect["mq_mirror_atk"] = loadfx("vfx/s4/zombie/vfx_ghost_mirror_elec_fly");
  level._effect["mq_cypher_wheels_success_fx"] = loadfx("vfx/s4/zombie/vfx_central_stele_aligned");
  level._effect["mq_sara_fix_mask_fx_01"] = loadfx("vfx/s4/zombie/vfx_saraxis_mirror_repair");
  level._effect["mq_sara_fix_mask_fx_02"] = loadfx("vfx/s4/zombie/vfx_saraxis_mirror_repair_os");
  level._effect["mq_sara_echo_idle_loop"] = loadfx("vfx/s4/zombie_ai/vfx_echo_calm_runner");
  level._effect["mq_sara_echo_turn_to_idle"] = loadfx("vfx/s4/zombie_ai/vfx_echo_blue_idle");
  level._effect["mq_sara_echo_angry_loop"] = loadfx("vfx/s4/zombie_ai/vfx_echo_angry_runner");
  level._effect["mq_sara_echo_turn_to_angry"] = loadfx("vfx/s4/zombie_ai/vfx_echo_orange_idle");
  level._effect["mq_sara_echo_calm_loop"] = loadfx("vfx/s4/zombie_ai/vfx_echo_idle_runner");
  level._effect["mq_sara_echo_turn_to_calm"] = loadfx("vfx/s4/zombie_ai/vfx_echo_base_idle");
  set_up_mq_models();
}

set_up_mq_models() {
  var_0 = scripts\engine\utility::getstruct("mq_zombie_blood_fountain", "script_noteworthy");
  level.e_zombie_blood_fountain = scripts\cp\utility::_id_E190("s4_zm_broken_demonic_fountain", var_0.origin, var_0.angles);
  var_1 = scripts\engine\utility::getStructArray("mq_step_three_small_stele_loc", "script_noteworthy");

  foreach(var_3 in var_1) {
    var_0 = scripts\engine\utility::getstruct(var_3.target, "script_noteworthy");
    var_4 = scripts\cp\utility::_id_E190("s4_zm_stone_stele", var_0.origin, var_0.angles);
  }

  var_0 = scripts\engine\utility::getstruct("mq_center_stele_mdl", "script_noteworthy");
  level.mdl_center_stele = scripts\cp\utility::_id_E190("s4_zm_central_stone_stele", var_0.origin, var_0.angles);
  var_0 = scripts\engine\utility::getstruct("mq_stele_cover_01", "script_noteworthy");
  level.mdl_cover_01 = scripts\cp\utility::_id_E190("s4_zm_central_stone_stele_vines_c", var_0.origin, var_0.angles);
  var_0 = scripts\engine\utility::getstruct("mq_stele_cover_02", "script_noteworthy");
  level.mdl_cover_02 = scripts\cp\utility::_id_E190("s4_zm_central_stone_stele_vines_b", var_0.origin, var_0.angles);
  var_0 = scripts\engine\utility::getstruct("mq_stele_cover_03", "script_noteworthy");
  level.mdl_cover_03 = scripts\cp\utility::_id_E190("s4_zm_central_stone_stele_vines_a", var_0.origin, var_0.angles);
  var_0 = scripts\engine\utility::getstruct("mq_cypher_wheel_base", "script_noteworthy");
  scripts\cp\utility::_id_E190("s4_zm_cypher_wheel_e", var_0.origin, var_0.angles);
  var_0 = scripts\engine\utility::getstruct("mq_blood_altar", "script_noteworthy");
  scripts\cp\utility::_id_E190("s4_zm_blood_altar", var_0.origin, var_0.angles);
  var_6 = scripts\engine\utility::getStructArray("mq_lost_monolith", "script_noteworthy");

  foreach(var_0 in var_6) {
    scripts\cp\utility::_id_E190("s4_zm_lost_monolith", var_0.origin, var_0.angles);
  }
}

init_mq_blockers() {
  level endon("game_ended");
  level scripts\engine\utility::_id_5C24("introscreen_over");
  level.a_lock_down_clips = getEntArray("mq_step_three_door_clip", "targetname");
  level.a_lock_down_clip_fxs = getEntArray("mq_step_three_door_clip_fx", "targetname");
  level.a_mdl_stp7_door_block_fxs = getEntArray("mq_step_seven_door_block_img", "script_noteworthy");
  level.a_mdl_stp7_door_blocks = getEntArray("mq_step_seven_door_block", "script_noteworthy");
  set_lock_down_clips(0, level.a_lock_down_clips, level.a_lock_down_clip_fxs);
  set_lock_down_clips(0, level.a_mdl_stp7_door_blocks, level.a_mdl_stp7_door_block_fxs);
  level.mdl_altar_blocker = getent("mq_step_seven_altar_block", "script_noteworthy");
  level.mdl_altar_blocker notsolid();

  if(!getdvarint("#x33ad41eaa5a9a3eec", 0)) {
    level.mdl_mq_blocker = getent("mq_mdl_blocker", "script_noteworthy");

    if(isDefined(level.mdl_mq_blocker)) {
      level.mdl_mq_blocker notsolid();
      level.mdl_mq_blocker _meth_8093();
    }
  }
}

generate_cypher_code() {
  level.a_n_kanji_symbols = [];
  var_0 = randomintrange(0, 5);
  var_1 = randomintrange(5, 10);
  var_2 = randomintrange(10, 15);
  level.a_n_kanji_symbols = [var_0, var_1, var_2];
}

set_up_symbol_mdls() {
  var_0 = ["s4_zm_kanji_symbols_01", "s4_zm_kanji_symbols_02", "s4_zm_kanji_symbols_03", "s4_zm_kanji_symbols_04", "s4_zm_kanji_symbols_05", "s4_zm_kanji_symbols_06", "s4_zm_kanji_symbols_07", "s4_zm_kanji_symbols_08", "s4_zm_kanji_symbols_09", "s4_zm_kanji_symbols_10", "s4_zm_kanji_symbols_11", "s4_zm_kanji_symbols_12", "s4_zm_kanji_symbols_13", "s4_zm_kanji_symbols_14", "s4_zm_kanji_symbols_15"];
  var_1 = scripts\engine\utility::getStructArray("mq_kanji_spawn_loc", "script_noteworthy");
  generate_cypher_code();

  for(var_2 = 0; var_2 < level.a_n_kanji_symbols.size; var_2++) {
    scripts\cp\utility::_id_E190(var_0[level.a_n_kanji_symbols[var_2]], var_1[var_2].origin, var_1[var_2].angles);
  }
}

init_step_one_reveal_stele() {
  level.s_stele_loc = scripts\engine\utility::getstruct("mq_step_one_stele_loc", "targetname");
  level.s_stele_loc.search_2d_dist = 72;
  level.mdl_center_stele.mdl_fx = scripts\cp\utility::_id_E190("tag_origin", level.mdl_center_stele.origin, level.mdl_center_stele.angles);
  level.mdl_center_stele playLoopSound("zmb_stele_spell_lp");
  playFXOnTag(level._effect["mq_stele_rune_fx"], level.mdl_center_stele.mdl_fx, "tag_origin");
  level.n_cypher_inserted = 0;
  _id_06CB::_id_AA4A(::on_zombie_killed_step_one);
  level thread init_step_one_interactions();
  level.mdl_returned_cypher_wheels = [];
  var_0 = scripts\engine\utility::getstruct("mq_returned_stele_frag_01", "script_noteworthy");
  level.mdl_returned_cypher_wheels[0] = ::scripts\cp\utility::_id_E190("s4_zm_cypher_wheel_a", var_0.origin + (0, 10, 0), var_0.angles);
  level.mdl_returned_cypher_wheels[0].v_base_loc = var_0.origin;
  var_1 = scripts\engine\utility::getstruct("mq_returned_stele_frag_02", "script_noteworthy");
  level.mdl_returned_cypher_wheels[1] = ::scripts\cp\utility::_id_E190("s4_zm_cypher_wheel_b", var_1.origin + (0, 10, 0), var_1.angles);
  level.mdl_returned_cypher_wheels[1].v_base_loc = var_1.origin;
  var_2 = scripts\engine\utility::getstruct("mq_returned_stele_frag_03", "script_noteworthy");
  level.mdl_returned_cypher_wheels[2] = ::scripts\cp\utility::_id_E190("s4_zm_cypher_wheel_c", var_2.origin + (0, 10, 0), var_2.angles);
  level.mdl_returned_cypher_wheels[2].v_base_loc = var_2.origin;
  var_3 = scripts\engine\utility::getstruct("mq_returned_stele_center_arrow", "script_noteworthy");
  level.mdl_cypher_wheel_arrow = scripts\cp\utility::_id_E190("s4_zm_cypher_wheel_d", var_3.origin + (0, 10, 0), var_3.angles);
  level.mdl_cypher_wheel_arrow.v_base_loc = var_3.origin;
  var_4 = scripts\engine\utility::getstruct("mq_cypher_key_loc", "script_noteworthy");
  level.mdl_cypher_key = scripts\cp\utility::_id_E190("s4_zm_rune_cypher_key_off", var_4.origin, var_4.angles);
  level thread check_players_get_close_to_cypher_key();
  level thread molotov_use_check();
  set_up_symbol_mdls();
}

do_step_one_reveal_stele() {
  level thread check_players_get_close_to_stele();
  level waittill("step_one_is_done");
}

init_step_one_interactions() {
  level endon("game_ended");
  level scripts\engine\utility::_id_5C24("interactions_initialized");
  _id_0737::_id_C266("mq_step_one_fragment_loc", undefined, ::on_interact_fragment, ::init_interact_fragment);
  level._id_835D["mq_step_one_fragment_loc"] = &"CP_SUMPF/MQ_GRAB_FRAGMENT";
  _id_0737::_id_C266("mq_step_one_stele_loc", ::hint_text_stele, ::on_interact_stele);
  _id_0737::addinteractionhinttypecallback("mq_step_one_stele_loc", ::hint_type_stele);
}

cleanup_step_one_reveal_stele() {
  level.mdl_center_stele stoploopsound("zmb_stele_spell_lp");
  _id_0737::_id_C4AB("mq_step_one_stele_loc");
  _id_0737::_id_C4AB("mq_step_one_fragment_loc");
  _id_06CB::_id_C417(::on_zombie_killed_step_one);

  if(isDefined(level.mdl_center_stele.mdl_fx)) {
    stopFXOnTag(level._effect["mq_stele_rune_fx"], level.mdl_center_stele.mdl_fx, "tag_origin");
  }
}

debug_step_one_reveal_stele() {
  if(isDefined(level.mdl_cover_01)) {
    level.mdl_cover_01 delete();
  }

  if(isDefined(level.mdl_cover_02)) {
    level.mdl_cover_02 delete();
  }

  if(isDefined(level.mdl_cover_03)) {
    level.mdl_cover_03 delete();
  }

  level.mdl_returned_cypher_wheels = [];
  var_0 = scripts\engine\utility::getstruct("mq_returned_stele_frag_01", "script_noteworthy");
  level.mdl_returned_cypher_wheels[0] = ::scripts\cp\utility::_id_E190("s4_zm_cypher_wheel_a", var_0.origin, var_0.angles);
  var_0 = scripts\engine\utility::getstruct("mq_returned_stele_frag_02", "script_noteworthy");
  level.mdl_returned_cypher_wheels[1] = ::scripts\cp\utility::_id_E190("s4_zm_cypher_wheel_b", var_0.origin, var_0.angles);
  var_0 = scripts\engine\utility::getstruct("mq_returned_stele_frag_03", "script_noteworthy");
  level.mdl_returned_cypher_wheels[2] = ::scripts\cp\utility::_id_E190("s4_zm_cypher_wheel_c", var_0.origin, var_0.angles);
  var_0 = scripts\engine\utility::getstruct("mq_returned_stele_center_arrow", "script_noteworthy");
  scripts\cp\utility::_id_E190("s4_zm_cypher_wheel_d", var_0.origin, var_0.angles);
  wait 1.5;
  level notify("step_one_is_done");
}

on_zombie_killed_step_one(var_0) {
  level endon("game_ended");

  if(self._id_110B0 == "screamer" && distancesquared(self.origin, level.s_stele_loc.origin) < 250000) {
    level thread play_boom_schreier_kill_near_monolith_vo();

    if(isDefined(level.mdl_cover_01)) {
      playFX(level._effect["mq_stele_cover_remove_fx_01"], level.mdl_center_stele.origin);
      level.mdl_cover_01 delete();
      return;
    }

    if(isDefined(level.mdl_cover_02)) {
      playFX(level._effect["mq_stele_cover_remove_fx_02"], level.mdl_center_stele.origin);
      level.mdl_cover_02 delete();
      return;
    }

    if(isDefined(level.mdl_cover_03)) {
      playFX(level._effect["mq_stele_cover_remove_fx_03"], level.mdl_center_stele.origin);
      level.mdl_cover_03 delete();
      level thread play_boom_schreier_kill_near_monolith_finish_vo();
    }

    level scripts\engine\utility::_id_5C1B("mq_stele_exposed");
    stopFXOnTag(level._effect["mq_stele_rune_fx"], level.mdl_center_stele.mdl_fx, "tag_origin");
  }
}

on_interact_stele(var_0, var_1) {
  if(scripts\engine\utility::_id_5C00("mq_stele_exposed")) {
    if(scripts\engine\utility::_id_5C00("mq_cypher_wheel_one_collected")) {
      scripts\cp\utility::_id_B8EF("zmb_rune_puzzle_piece", var_0.origin);
      var_1 _meth_827A("cp_zm_s2_mq_shield_rumble", var_1.origin);
      level.n_cypher_inserted++;

      if(isDefined(level.mdl_returned_cypher_wheels[0])) {
        level.mdl_returned_cypher_wheels[0].origin = level.mdl_returned_cypher_wheels[0].v_base_loc;
      }

      scripts\engine\utility::_id_5C04("mq_cypher_wheel_one_collected");
    }

    wait 0.5;

    if(scripts\engine\utility::_id_5C00("mq_cypher_wheel_two_collected")) {
      scripts\cp\utility::_id_B8EF("zmb_rune_puzzle_piece", var_0.origin);
      var_1 _meth_827A("cp_zm_s2_mq_shield_rumble", var_1.origin);
      level.n_cypher_inserted++;

      if(isDefined(level.mdl_returned_cypher_wheels[1])) {
        level.mdl_returned_cypher_wheels[1].origin = level.mdl_returned_cypher_wheels[1].v_base_loc;
      }

      scripts\engine\utility::_id_5C04("mq_cypher_wheel_two_collected");
    }

    wait 0.5;

    if(scripts\engine\utility::_id_5C00("mq_cypher_wheel_three_collected")) {
      scripts\cp\utility::_id_B8EF("zmb_rune_puzzle_piece", var_0.origin);
      var_1 _meth_827A("cp_zm_s2_mq_shield_rumble", var_1.origin);
      level.n_cypher_inserted++;

      if(isDefined(level.mdl_returned_cypher_wheels[2])) {
        level.mdl_returned_cypher_wheels[2].origin = level.mdl_returned_cypher_wheels[2].v_base_loc;
        level.mdl_cypher_wheel_arrow.origin = level.mdl_cypher_wheel_arrow.v_base_loc;
      }

      scripts\engine\utility::_id_5C04("mq_cypher_wheel_three_collected");
    }

    if(level.n_cypher_inserted == 3) {
      level thread play_all_pieces_assembled_at_stele_vo();
      _id_0737::_id_C4AB("mq_step_one_stele_loc");
      level notify("step_one_is_done");
    }
  }
}

hint_text_stele(var_0, var_1) {
  if(scripts\engine\utility::_id_5C00("mq_stele_exposed")) {
    var_2 = 0;

    if(scripts\engine\utility::_id_5C00("mq_cypher_wheel_one_collected")) {
      var_2++;
    }

    if(scripts\engine\utility::_id_5C00("mq_cypher_wheel_two_collected")) {
      var_2++;
    }

    if(scripts\engine\utility::_id_5C00("mq_cypher_wheel_three_collected")) {
      var_2++;
    }

    if(var_2 >= 1) {
      if(var_2 == 1) {
        return &"CP_SUMPF/MQ_INSERT_FRAGMENT";
        return;
      }

      return &"CP_SUMPF/MQ_INSERT_FRAGMENTS";
      return;
      return;
    }

    return "";
    return;
  } else
    return "";
}

hint_type_stele(var_0, var_1) {
  if(scripts\engine\utility::_id_5C00("mq_stele_exposed")) {
    if(scripts\engine\utility::_id_5C00("mq_cypher_wheel_one_collected") || scripts\engine\utility::_id_5C00("mq_cypher_wheel_two_collected") || scripts\engine\utility::_id_5C00("mq_cypher_wheel_three_collected")) {
      return "HINT_NOICON";
    } else {
      return "HINT_NOBUTTON";
    }
  } else
    return "HINT_NOBUTTON";
}

on_interact_fragment(var_0, var_1) {
  scripts\cp\utility::_id_B8EF("fly_pickup_quest_generic", var_0.origin);

  switch (var_0.mdl_frag.my_spawn_struct._id_0481) {
    case "frag_model_01":
      level scripts\engine\utility::_id_5C1B("mq_cypher_wheel_one_collected");
      break;
    case "frag_model_02":
      level scripts\engine\utility::_id_5C1B("mq_cypher_wheel_two_collected");
      break;
    case "frag_model_03":
      level scripts\engine\utility::_id_5C1B("mq_cypher_wheel_three_collected");
      break;
    default:
      break;
  }

  var_1 _meth_827A("cp_zm_s2_mq_shield_rumble", var_1.origin);
  level thread _id_0720::play_event_vo_from_selected_players("pickup_item", [var_1]);
  _func_0130(var_0.mdl_frag);
  var_0.mdl_frag delete();
  _id_0737::_id_C3C5(var_0);
}

init_interact_fragment(var_0) {
  foreach(var_2 in var_0) {
    var_3 = scripts\engine\utility::getstruct(var_2.target, "targetname");

    if(!isDefined(var_2.mdl_frag)) {
      var_2.mdl_frag = scripts\cp\utility::_id_E190(var_3._id_CE18, var_3.origin, var_3.angles);
      var_2.mdl_frag thread show_hide_outline();
      var_2.mdl_frag.my_spawn_struct = var_3;
    }
  }
}

show_hide_outline() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    var_0 = 0;

    foreach(var_2 in level.players) {
      if(var_2 scripts\cp\utility::_id_8708()) {
        var_3 = distancesquared(self.origin, var_2.origin);

        if(var_3 <= _func_0219(400) && !istrue(var_0)) {
          var_0 = 1;
        }

        break;
      }
    }

    if(istrue(var_0)) {
      self _meth_81B0("outline_depth_yellow_zm_wider");
    } else {
      self _meth_81AD();
    }

    wait 0.1;
  }
}

do_bob(var_0) {
  level endon("game_ended");

  if(isDefined(var_0)) {
    level endon(var_0);
  }

  self endon("death");
  var_1 = self.origin + (0, 0, 4);
  var_2 = self.origin + (0, 0, -4);

  for(;;) {
    self moveto(var_1, 1, 0, 0);
    self waittill("movedone");
    self moveto(var_2, 1, 0, 0);
    self waittill("movedone");
  }
}

molotov_use_check(var_0) {
  level endon("game_ended");
  level endon("step_six_is_done");

  for(;;) {
    level waittill("grenade_exploded_during_stealth", var_0);

    if(isDefined(var_0) && distance2d(var_0.origin, level.mdl_cypher_key.origin) < 70 && (scripts\engine\utility::is_equal(var_0.weapon_name, "s4_molotov_zm") || scripts\engine\utility::is_equal(var_0.weapon_name, "s4_thermite_zm"))) {
      level scripts\engine\utility::_id_5C1B("cypher_key_exposed");
      level.mdl_cypher_key setModel("s4_zm_rune_cypher_key_on");
      wait 2;
      level thread _id_0720::play_narrations(["zm_cpm4_mqs4_blkr_qgbj", "zm_cpm4_mqs4_vrcn_qgbk"], 1, 0, "force_quit_current_dialogue");
      level waittill("dialogue_finished");
      return;
    }
  }
}

check_players_get_close_to_stele() {
  level endon("game_ended");
  level endon("mq_stele_exposed");
  level endon("step_one_is_done");
  level endon("boom_schreier_kill_near_monolith_vo_played");

  for(;;) {
    foreach(var_1 in level.players) {
      if(isDefined(var_1) && isDefined(level.s_stele_loc) && distancesquared(var_1.origin, level.s_stele_loc.origin) < 250000 && var_1 scripts\cp\maps\cp_sumpf\cp_sumpf_wwq::is_look_at(level.s_stele_loc, 120)) {
        while(istrue(level._id_493C)) {
          wait 0.5;
        }

        var_2 = ["zm_cpm4_mqs4_vrcn_qg1a", "zm_cpm4_mqs4_vrcn_qg1b", "zm_cpm4_mqs4_blkr_qg1c", "zm_cpm4_mqs4_dsrx_qg1d"];
        var_3 = ["zm_cpm4_mqs4_vrcn_qg1e", "zm_cpm4_mqs4_blkr_qg1f", "zm_cpm4_mqs4_dsrx_qg1g"];
        var_4 = ["zm_cpm4_mqs4_vrcn_qg1h", "zm_cpm4_mqs4_blkr_qg1i", "zm_cpm4_mqs4_dsrx_qg1j"];
        var_5 = scripts\engine\utility::random([var_2, var_3, var_4]);
        level thread _id_0720::play_narrations(var_5, 1, 0, "force_quit_current_dialogue");
        level waittill("dialogue_finished");
        level thread _id_0720::play_event_vo_from_selected_players("ally_confirmation", level.players, 1);
        return;
      }
    }

    wait 1;
  }
}

check_players_get_close_to_cypher_key() {
  level endon("game_ended");
  level endon("cypher_key_exposed");
  level endon("mq_step_two_is_done");

  for(;;) {
    foreach(var_1 in level.players) {
      if(isDefined(var_1) && isDefined(level.mdl_cypher_key) && distancesquared(var_1.origin, level.mdl_cypher_key.origin) < 6400 && var_1 scripts\cp\maps\cp_sumpf\cp_sumpf_wwq::is_look_at(level.mdl_cypher_key, 120)) {
        level scripts\engine\utility::_id_5C1B("cypher_key_found");
        level thread _id_0720::play_narrations(["zm_cpm4_mqs4_vrcn_qgbg", "zm_cpm4_mqs4_krft_qgbh", "zm_cpm4_mqs4_krft_qgbi"], 1, 0, "force_quit_current_dialogue");
        return;
      }
    }

    wait 1;
  }
}

play_boom_schreier_kill_near_monolith_vo() {
  level endon("game_ended");

  if(!level scripts\engine\utility::_id_5C00("boom_schreier_kill_near_monolith_vo_played")) {
    level scripts\engine\utility::_id_5C1B("boom_schreier_kill_near_monolith_vo_played");

    while(istrue(level._id_493C)) {
      wait 0.5;
    }

    if(level scripts\engine\utility::_id_5C00("boom_schreier_kill_near_monolith_completed")) {
      level scripts\engine\utility::_id_5C1B("boom_schreier_kill_near_monolith_vo_finished");
      return;
    }

    level thread _id_0720::play_narration("zm_cpm4_mqs4_blkr_qg1k", 1, 0);
    level waittill("dialogue_finished");
    level scripts\engine\utility::_id_5C1B("boom_schreier_kill_near_monolith_vo_finished");
  }
}

play_boom_schreier_kill_near_monolith_finish_vo() {
  level endon("game_ended");
  wait 2;

  if(!level scripts\engine\utility::_id_5C00("boom_schreier_kill_near_monolith_vo_finished")) {
    level scripts\engine\utility::_id_5C1B("boom_schreier_kill_near_monolith_completed");
    level scripts\engine\utility::_id_5C24("boom_schreier_kill_near_monolith_vo_finished");
  }

  level thread _id_0720::play_narration(["zm_cpm4_mqs4_vrcn_qg1l"], 1, 0);
  level waittill("dialogue_finished");

  if(scripts\engine\utility::_id_5C00("mq_cypher_wheel_one_collected") && scripts\engine\utility::_id_5C00("mq_cypher_wheel_two_collected") && scripts\engine\utility::_id_5C00("mq_cypher_wheel_three_collected")) {
    level thread _id_0720::play_narrations(["zm_cpm4_mqs4_vrcn_qg1q", "zm_cpm4_mqs4_dsrx_qg1r"], 1, 0, "force_quit_current_dialogue");
    level waittill("dialogue_finished");
    level thread _id_0720::play_event_vo_from_selected_players("ally_confirmation", level.players, 1);
  } else if(scripts\engine\utility::_id_5C00("mq_cypher_wheel_one_collected") || scripts\engine\utility::_id_5C00("mq_cypher_wheel_two_collected") || scripts\engine\utility::_id_5C00("mq_cypher_wheel_three_collected")) {
    level thread _id_0720::play_narrations(["zm_cpm4_mqs4_vrcn_qg1o", "zm_cpm4_mqs4_dsrx_qg1p"], 1, 0, "force_quit_current_dialogue");
    level waittill("dialogue_finished");
    level thread _id_0720::play_event_vo_from_selected_players("ally_confirmation", level.players, 1);
  } else {
    level thread _id_0720::play_narrations(["zm_cpm4_mqs4_vrcn_qg1m", "zm_cpm4_mqs4_dsrx_qg1n"], 1, 0, "force_quit_current_dialogue");
    level waittill("dialogue_finished");
    level thread _id_0720::play_event_vo_from_selected_players("ally_confirmation", level.players, 1);
  }

  wait 2;
}

play_all_pieces_assembled_at_stele_vo() {
  level endon("game_ended");
  level thread _id_0720::play_narrations(["zm_cpm4_mqs4_krft_qg1s", "zm_cpm4_mqs4_vrcn_qg1t", "zm_cpm4_mqs4_dsrx_qg1u", "zm_cpm4_mqs4_dsrx_qg1v"], 1, 0, "force_quit_current_dialogue");
}

init_step_two_cypher_wheel() {
  level _id_0737::_id_C266("mq_step_one_stele_loc", undefined, ::activate_cypher_wheels, ::init_cypher_wheels);
  level._id_8393["mq_step_one_stele_loc"]._id_7965 = ::cypher_wheels_show_hint_string;
  level._id_8393["mq_step_one_stele_loc"].hint_type_func = ::cypher_wheels_get_hint_type;
}

do_step_two_cypher_wheel() {
  level waittill("mq_step_two_is_done");
}

cleanup_step_two_cypher_wheel() {
  _id_0737::_id_C4AB("mq_step_one_stele_loc");

  if(isDefined(level.cypher_wheels_hint)) {
    level.cypher_wheels_hint delete();
  }

  if(isDefined(level.cypher_wheels_link)) {
    level.cypher_wheels_link delete();
  }
}

debug_step_two_cypher_wheel() {
  waitframe();
  level notify("mq_step_two_is_done");
}

cypher_wheels_show_hint_string(var_0, var_1) {
  if(isDefined(var_0._id_3D11)) {
    return &"CP_SUMPF/MQ_CYPHER_WHEELS_COOLDOWN";
  }

  if(level scripts\engine\utility::_id_5C00("cypher_wheels_in_use")) {
    return &"";
  } else if(!level scripts\engine\utility::_id_5C00("cypher_wheels_done")) {
    return &"CP_SUMPF/MQ_CYPHER_WHEELS_USE";
  }

  return &"";
}

cypher_wheels_get_hint_type(var_0, var_1) {
  if(isDefined(var_0._id_3D11)) {
    return "HINT_NOBUTTON";
  }

  return "HINT_NOICON";
}

init_cypher_wheels(var_0) {
  var_1 = var_0[0];
  level.cypher_wheels_link = getent("cypher_wheels_link", "targetname");
  level.cypher_wheels_hint = scripts\cp\utility::_id_E190("tag_origin", level.cypher_wheels_link.origin + (0, 10, 40), level.cypher_wheels_link.angles);
  level.cypher_wheels_hint makeunusable();
  level.cypher_wheels_hint sethintstring(&"CP_SUMPF/MQ_CYPHER_WHEELS_DECIPHER");
  level.cypher_wheels_hint setcursorhint("HINT_NOBUTTON");
  var_2 = scripts\engine\utility::getstruct("mq_returned_stele_frag_03", "script_noteworthy");
  level.cypher_wheel_center = scripts\cp\utility::_id_E190("tag_origin", var_2.origin, var_2.angles);

  foreach(var_4 in level.mdl_returned_cypher_wheels) {
    var_4 linkto(level.cypher_wheel_center);
  }

  var_6 = [];
  var_6[0] = 6;
  var_6[1] = 6;
  var_6[2] = 6;
  var_7 = [];
  var_7[0] = 0;
  var_7[1] = 0;
  var_7[2] = 0;

  for(var_8 = 0; var_8 < level.mdl_returned_cypher_wheels.size; var_8++) {
    var_9 = spawnStruct();
    var_9.wheel_index = var_8;
    var_9.wheel_segments = var_6[var_9.wheel_index];
    var_9.symbol_yaw = 360.0 / var_9.wheel_segments;
    var_9.default_index = var_7[var_9.wheel_index];
    var_9.symbol_index = var_9.default_index;
    level.mdl_returned_cypher_wheels[var_8].wheel_data = var_9;
  }
}

activate_cypher_wheels(var_0, var_1) {
  if(!isPlayer(var_1)) {
    return;
  }
  if(level scripts\engine\utility::_id_5C00("cypher_wheels_in_use") || level scripts\engine\utility::_id_5C00("cypher_wheels_done")) {
    return;
  }
  if(isDefined(level.cypher_wheels_end_use_time) && gettime() - level.cypher_wheels_end_use_time < 0) {
    return;
  }
  var_1 thread operate_cypher_wheels(var_0);
}

cypher_wheels_cooldown() {
  level endon("game_ended");
  self._id_3D11 = 1;
  wait 0;
  self._id_3D11 = undefined;
  level _id_0737::refresh_all_players_interaction([self]);
}

operate_cypher_wheels(var_0) {
  level endon("game_ended");
  level scripts\engine\utility::_id_5C1B("cypher_wheels_in_use");

  foreach(var_2 in level.mdl_returned_cypher_wheels) {
    var_2 thread handle_wheel_rotation(self);
  }

  level.cypher_wheels_hint makeuseable();

  foreach(var_9 in scripts\cp\utility::_id_6C5C()) {
    if(!isalive(var_9)) {
      continue;
    }
    if(var_9 == self) {
      level.cypher_wheels_hint _meth_80E0(var_9);
      continue;
    }

    level.cypher_wheels_hint disableplayeruse(var_9);
  }

  var_11 = level thread force_nearby_zombie_go_away(self);
  var_12 = decipher_wheels(gettime());
  level.cypher_wheels_hint makeunusable();
  wait 0.2;
  level.cypher_wheels_end_use_time = gettime();
  level scripts\engine\utility::_id_5C04("cypher_wheels_in_use");

  foreach(var_14 in var_11) {
    var_14._id_CF4A = 0;
  }

  if(istrue(var_12)) {
    level scripts\engine\utility::_id_5C1B("cypher_wheels_done");
    playsoundatpos(level.cypher_wheel_center.origin, "zmb_cipher_wheel_success");
    var_16 = anglestoright(level.mdl_center_stele.mdl_fx.angles);
    playFX(scripts\engine\utility::getfx("mq_cypher_wheels_success_fx"), level.mdl_center_stele.mdl_fx.origin, var_16);

    if(isDefined(self)) {
      self _meth_827A("cp_zm_s2_mq_shield_rumble", self.origin);
    }

    level _id_0737::refresh_all_players_interaction([var_0]);
    wait 1;
    level thread _id_0720::play_narration(["zm_cpm4_mqs4_vrcn_qgbl", "zm_cpm4_mqs4_vrcn_qgbm", "zm_cpm4_mqs4_vrcn_qgbn"], 1, 0);
    level notify("mq_step_two_is_done");
  } else {
    var_0 thread cypher_wheels_cooldown();
    level thread play_cypher_wheels_fail_vo();
    var_17 = 0;

    foreach(var_2 in level.mdl_returned_cypher_wheels) {
      if(var_2.wheel_data.symbol_index != var_2.wheel_data.default_index) {
        playsoundatpos(var_2.origin, "zmb_cipher_wheel_reset");
        var_17 = 1;
        var_2.wheel_data.symbol_index = var_2.wheel_data.default_index;
        var_2 _meth_82A7((0, 0, 0), 0.5, 0.1, 0.1);
      }
    }

    if(var_17 && isDefined(self)) {
      self _meth_827A("cp_zm_s2_mq_shield_rumble", self.origin);
    }
  }
}

force_adjust_zombie_position(var_0) {
  level endon("game_ended");
  self endon("death");
  self._id_CF4A = 1;
  wait 2;

  if(!isalive(self)) {
    return;
  }
  for(;;) {
    if(!isDefined(var_0)) {
      break;
    }

    if(distancesquared(self.origin, var_0.origin) <= _func_0219(60)) {
      var_1 = vectortoangles(self.origin - var_0.origin);
      var_2 = anglesToForward(var_1);
      var_3 = self.origin + var_2 * 1;
      self.origin = var_3;
      waitframe();
      continue;
    }

    break;
  }

  self._id_CF4A = 0;

  if(!isDefined(var_0)) {
    return;
  }
  if(level.players.size == 1) {
    thread force_zombie_go_away(var_0);
  }
}

force_nearby_zombie_go_away(var_0) {
  level endon("game_ended");
  var_0 thread create_nav_obstacle();
  var_1 = _func_0071(var_0.origin, 100, level._id_11056);

  foreach(var_3 in var_1) {
    var_3 thread force_adjust_zombie_position(var_0);
  }

  return var_1;
}

create_nav_obstacle() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  while(scripts\engine\utility::_id_5C00("cypher_wheels_in_use")) {
    self._id_A3E7 = _func_02B3(self);
    waitframe();
  }

  if(isDefined(self._id_A3E7)) {
    _func_02B1(self._id_A3E7);
  }
}

force_zombie_go_away(var_0) {
  level endon("game_ended");
  self endon("death");
  var_1 = undefined;

  while(!isDefined(var_1)) {
    if(!isDefined(var_0)) {
      return;
    }
    var_2 = vectortoangles(self.origin - var_0.origin);
    var_3 = anglesToForward(var_2);
    var_1 = var_0.origin + var_3 * 70;
    var_1 = _func_02A9(var_1, 50);
    waitframe();
  }

  self._id_CF4A = 1;

  if(isDefined(var_1)) {
    self _meth_8326(var_1);
    self waittill("goal");
  }

  self._id_CF4A = 0;
}

get_cypher_wheel_symbol() {
  if(self.symbol_index > 0) {
    return self.wheel_index * 5 + self.symbol_index - 1;
  }

  return undefined;
}

handle_wheel_rotation(var_0) {
  level endon("game_ended");
  level endon("cypher_wheels_in_use");
  self endon("death");
  var_1 = self.wheel_data;
  var_2 = var_1.wheel_segments;

  for(;;) {
    self waittill("rotate_wheel", var_3);

    if(isDefined(var_3) && var_3 != 0) {
      scripts\engine\utility::_id_5474("wheel_rotating");
      playsoundatpos(self.origin, "zmb_cipher_wheel_move");
      var_0 _meth_827A("cp_zm_s2_mq_shield_rumble", var_0.origin);
      var_1.symbol_index = var_1.symbol_index + var_3;

      if(var_1.symbol_index < 0) {
        var_1.symbol_index = var_1.symbol_index + var_2;
      } else if(var_1.symbol_index >= var_2) {
        var_1.symbol_index = var_1.symbol_index - var_2;
      }

      self _meth_82A2((0, var_3 * var_1.symbol_yaw, 0), 0.2, 0.05, 0.05);
      self waittill("rotatedone");
      scripts\engine\utility::_id_5470("wheel_rotating");
    }
  }
}

try_decipher_wheel_symbols() {
  foreach(var_1 in level.mdl_returned_cypher_wheels) {
    var_2 = var_1.wheel_data;
    var_3 = var_2 get_cypher_wheel_symbol();
    var_4 = level.a_n_kanji_symbols[var_2.wheel_index];

    if(!isDefined(var_3) || var_3 != var_4) {
      return 0;
    }
  }

  return 1;
}

decipher_wheels(var_0) {
  self endon("death_or_disconnect");
  self playerlinkto(level.cypher_wheels_link, "tag_origin", 0, 45, 45, 45, 45);
  self disableoffhandweapons();
  self allowmelee(0);
  scripts\cp\utility::_id_1566(1);
  self._id_0E05 = 1;
  self setstance("crouch");
  scripts\common\utility::_id_1582(0);
  scripts\common\utility::_id_1570(0);
  var_1 = 0;
  var_2 = undefined;
  var_3 = 0;

  while(scripts\cp\utility::_id_8677(self)) {
    var_4 = self getplayerangles();
    var_5 = anglesToForward(var_4);
    var_6 = self getEye();
    var_7 = var_6 + var_5 * 60;
    var_8 = scripts\engine\trace::_id_C053(var_6, var_7, level.mdl_returned_cypher_wheels);
    var_9 = var_8["entity"];

    if(isDefined(var_9)) {
      if(isDefined(var_2) && var_9 != var_2) {
        var_2 _meth_81AD();
      }

      var_2 = var_9;
      var_2 _meth_81B1(self, "outline_nodepth_orange");
    } else if(isDefined(var_2)) {
      var_2 _meth_81AD();
      var_2 = undefined;
    }

    if(self useButtonPressed()) {
      if(var_1) {
        playsoundatpos(level.cypher_wheel_center.origin, "zmb_cipher_wheel_lock");
        var_3 = level try_decipher_wheel_symbols();
        break;
      }
    } else
      var_1 = 1;

    if(self stancebuttonPressed()) {
      break;
    }

    if(isDefined(var_2) && !var_2 scripts\engine\utility::_id_546E("wheel_rotating")) {
      var_10 = 0;
      var_11 = 0;

      if(self secondaryoffhandbuttonPressed()) {
        var_10 = 1;
      }

      if(self fragButtonPressed()) {
        var_11 = 1;
      }

      if(var_10) {
        var_2 notify("rotate_wheel", 1);
      }

      if(var_11) {
        var_2 notify("rotate_wheel", -1);
      }
    }

    waitframe();
  }

  if(isDefined(var_2)) {
    var_2 _meth_81AD();
    var_2 = undefined;
  }

  scripts\common\utility::_id_1582(1);
  scripts\common\utility::_id_1570(1);
  scripts\cp\utility::_id_1566(0);
  self._id_0E05 = undefined;
  self enableoffhandweapons();
  self allowmelee(1);
  self unlink();
  return var_3;
}

play_cypher_wheels_fail_vo() {
  if(level scripts\engine\utility::_id_5C00("cypher_key_found") || level scripts\engine\utility::_id_5C00("cypher_key_exposed")) {
    return;
  }
  if(!level scripts\engine\utility::_id_5C00("cypher_wheels_vo_played")) {
    level scripts\engine\utility::_id_5C1B("cypher_wheels_vo_played");
    level thread _id_0720::play_narration(["zm_cpm4_mqs4_krft_qgba", "zm_cpm4_mqs4_krft_qgbc", "zm_cpm4_mqs4_krft_qgbe"], 1, 0);
  }
}

init_step_three_soul_charge() {
  level.a_s_small_stele_interacts = scripts\engine\utility::getStructArray("mq_step_three_small_stele_loc", "script_noteworthy");
  level thread awake_small_steles();
  level.n_total_awaken_steles = 0;
  level.n_player_amount_interact_small_stele = 0;
  var_0 = scripts\engine\utility::getStructArray("doctors_quarters_outside_zone", "target");
  var_1 = scripts\engine\utility::getStructArray("doctors_quarters_outside_to_center_building_zone", "target");
  level.a_s_lock_down_zombie_spawners = scripts\cp\utility::_id_1BB8(var_0, var_1);
  level.a_s_lock_down_screamer_spawners = [];
  level.a_s_charge_zombie_spawners = [];

  foreach(var_3 in level.a_s_lock_down_zombie_spawners) {
    if(scripts\engine\utility::is_equal(var_3._id_039B, "enemy_base_zombie_cp|enemy_zombie_screamer_cp")) {
      level.a_s_lock_down_screamer_spawners = scripts\engine\utility::array_add(level.a_s_lock_down_screamer_spawners, var_3);
    }

    if(!scripts\engine\utility::is_equal(var_3._id_CD99, "under_water") && !scripts\engine\utility::is_equal(var_3._id_039B, "enemy_zombie_trickster_cp")) {
      level.a_s_charge_zombie_spawners = scripts\engine\utility::array_add(level.a_s_charge_zombie_spawners, var_3);
    }

    if(scripts\engine\utility::is_equal(var_3._id_039B, "enemy_zombie_trickster_cp")) {
      level.a_s_lock_down_zombie_spawners = scripts\engine\utility::array_remove(level.a_s_lock_down_zombie_spawners, var_3);
    }
  }

  _id_0737::_id_C266("mq_step_three_small_stele_loc", ::hint_interact_small_stele, ::on_interact_small_stele, ::init_interact_small_stele);
  _id_06CB::_id_AA4A(::on_zombie_killed_step_three);
}

do_step_three_soul_charge() {
  level waittill("lock_down_started");
  level waittill("lock_down_finished");
  level waittill("step_three_is_done");
}

cleanup_step_three_soul_charge() {
  _id_0737::_id_C4AB("mq_step_three_small_stele_loc");
  _id_06CB::_id_C417(::on_zombie_killed_step_three);

  if(isDefined(level.mdl_center_stele.mdl_fx)) {
    level.mdl_center_stele.mdl_fx delete();
  }
}

debug_step_three_soul_charge() {
  level notify("lock_down_started");
  waitframe();
  level notify("lock_down_finished");
  waitframe();
  level notify("step_three_is_done");
}

awake_small_steles() {
  level endon("game_ended");
  level endon("step_three_is_done");

  foreach(var_1 in level.a_s_small_stele_interacts) {
    var_1.is_awaken = 0;
  }

  level.n_total_awaken_steles = 0;
  level notify("mq_stop_watching_awaken");
  kill_ambient_fx_on_awaken_small_steles();
  waitframe();

  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    level.a_s_small_stele_interacts[var_3].is_awaken = 1;
    level.n_total_awaken_steles++;
  }

  play_ambient_fx_on_awaken_small_steles();
  level thread small_stele_awaken_watcher();
}

play_ambient_fx_on_awaken_small_steles() {
  foreach(var_1 in level.a_s_small_stele_interacts) {
    var_1.mdl_stele = scripts\engine\utility::getstruct(var_1.target, "script_noteworthy");

    if(istrue(var_1.is_awaken)) {
      var_1.mdl_stele.mdl_fx = scripts\cp\utility::_id_E190("tag_origin", var_1.mdl_stele.origin, var_1.mdl_stele.angles);
      playFXOnTag(level._effect["mq_small_stele_interact_fx"], var_1.mdl_stele.mdl_fx, "tag_origin");
      var_1.mdl_stele.mdl_fx playLoopSound("zmb_sml_stele_spell_lp");
    }
  }
}

kill_ambient_fx_on_awaken_small_steles() {
  foreach(var_1 in level.a_s_small_stele_interacts) {
    if(isDefined(var_1.mdl_stele) && isDefined(var_1.mdl_stele.mdl_fx)) {
      stopFXOnTag(level._effect["mq_small_stele_interact_fx"], var_1.mdl_stele.mdl_fx, "tag_origin");
      var_1.mdl_stele.mdl_fx stoploopsound();
      var_1.mdl_stele.mdl_fx delete();
    }
  }
}

small_stele_awaken_watcher() {
  level endon("game_ended");
  level endon("step_three_is_done");
  level endon("mq_stop_watching_awaken");

  for(;;) {
    if(!scripts\engine\utility::is_equal(level.n_total_awaken_steles, level.players.size)) {
      level thread awake_small_steles();
    }

    waitframe();
  }
}

on_interact_small_stele(var_0, var_1) {
  level endon("game_ended");

  if(!level scripts\engine\utility::_id_5C00("mq_lock_down_in_cd") && istrue(var_0.is_awaken) && !scripts\engine\utility::_id_5C00("start_rbz_exfil") && !istrue(level._id_204A) && !istrue(var_0.is_activated)) {
    if(!level scripts\engine\utility::_id_5C00("mq_small_stele_interacted")) {
      level thread simultaneously_interact_watcher_lock_down();
    }

    scripts\cp\utility::_id_B8F4("zmb_sml_stele_interact", var_1);
    var_1 _meth_827A("cp_zm_s2_mq_shield_rumble", var_1.origin);
    var_0.is_activated = 1;
    level.n_player_amount_interact_small_stele++;
    var_0 thread small_stele_fx_watcher();

    if(scripts\engine\utility::is_equal(level.n_player_amount_interact_small_stele, level.players.size)) {
      level notify("mq_stop_watching_awaken");
      level thread successful_sound_play_watcher();
      start_lock_down();
    }
  }
}

init_interact_small_stele(var_0) {}

hint_interact_small_stele(var_0, var_1) {
  if(istrue(var_0.is_activated) || level scripts\engine\utility::_id_5C00("mq_lock_down_in_cd") || !istrue(var_0.is_awaken) || scripts\engine\utility::_id_5C00("start_rbz_exfil") || istrue(level._id_204A)) {
    return "";
  } else {
    return &"CP_SUMPF/MQ_START_LOCKDOWN";
  }
}

successful_sound_play_watcher() {
  level endon("game_ended");
  level endon("step_three_is_done");
  wait 2;

  foreach(var_1 in level.players) {
    if(isDefined(var_1)) {
      scripts\cp\utility::_id_B8F4("zmb_holdout_stinger", var_1);
    }
  }
}

simultaneously_interact_watcher_lock_down() {
  level endon("game_ended");
  level endon("lock_down_started");
  level scripts\engine\utility::_id_5C1B("mq_small_stele_interacted");
  wait 3;
  level reset_lock_down();
}

start_lock_down() {
  level endon("game_ended");
  level thread force_teleport_player();

  foreach(var_1 in level.a_s_small_stele_interacts) {
    if(istrue(var_1.is_awaken) && !istrue(var_1.is_activated)) {
      var_1.is_activated = 1;
    }
  }

  level scripts\cp\maps\cp_sumpf\cp_sumpf_zipline::set_zipline_disabled(1);
  level notify("lock_down_started");
  setup_params_for_lock_down();

  foreach(var_1 in level.a_s_small_stele_interacts) {
    if(!istrue(var_1.is_activated)) {
      var_1.is_activated = 1;
      var_1 thread small_stele_fx_watcher();
    }

    if(!isDefined(var_1.mdl_stele.mdl_fx)) {
      var_1.mdl_stele.mdl_fx = scripts\cp\utility::_id_E190("tag_origin", var_1.mdl_stele.origin, var_1.mdl_stele.angles);
    }

    playFXOnTag(level._effect["mq_small_stele_interact_fx"], var_1.mdl_stele.mdl_fx, "tag_origin");
    var_1.mdl_stele.mdl_fx playLoopSound("zmb_sml_stele_spell_lp");
  }

  level thread central_stele_fx_watcher();
  set_lock_down_clips(1, level.a_lock_down_clips, level.a_lock_down_clip_fxs);
  scripts\engine\utility::_id_5C04("round_spawn_zombies");
  level.force_cleanup_all_zombies = 1;
  var_5 = _id_06FE::_id_6322();

  foreach(var_7 in var_5) {
    var_7 scripts\cp\zombies\zm_cleanup::cleanup_zombie();
  }

  level notify("complete_shooting_gallery");
  level.force_cleanup_all_zombies = 0;

  if(scripts\engine\utility::_id_5C00("in_special_round")) {
    level.rbz scripts\engine\utility::_id_5474("all_killed");
    level.next_special_round = level._id_11049 + 1;
  }

  level thread scripts\cp\maps\cp_sumpf\cp_sumpf_wwq::fadetowhite(0.3);
  level thread _id_0720::play_narration(["zm_cpm4_mqs4_vlst_qgca", "zm_cpm4_mqs4_vlst_qgcc", "zm_cpm4_mqs4_vlst_qgce"], 1, 0);
  level waittill("dialogue_finished");
  level thread lock_down_zombie_spawn_watcher();
  level thread lock_down_progress_watcher();
  level thread spawn_charge_zombie_watcher();
  level thread check_charging_progress();
  level._id_A52A = 1;
  level.a_disabled_score_event = ["stun_grenade_stunned_enemy", "stun_mine_stunned_enemy", "juggernaut_backpack_destroyed", "energy_mine_stunned_enemy"];
}

stop_lock_down() {
  level endon("game_ended");
  level endon("step_three_is_done");
  level notify("lock_down_finished");
  level reset_lock_down();
  level thread scripts\cp\maps\cp_sumpf\cp_sumpf_wwq::fadetowhite(0.3);
  var_0 = _id_06FE::_id_6322();

  foreach(var_2 in var_0) {
    var_2 _meth_81FA();
  }

  level notify("complete_shooting_gallery");
  level._id_A52A = 0;
  level.a_disabled_score_event = undefined;

  if(isDefined(level.mdl_center_stele.mdl_fx)) {
    _func_0130(level.mdl_center_stele.mdl_fx);
  }

  waitframe();

  if(level.n_stele_charge_progress >= level.n_stele_charge_requirement) {
    kill_ambient_fx_on_awaken_small_steles();
    level thread _id_0720::play_narration(["zm_cpm4_mqs4_vrcn_qgcs", "zm_cpm4_mqs4_vrcn_qgct", "zm_cpm4_mqs4_vrcn_qgcu", "zm_cpm4_mqs4_vrcn_qgcv"], 1, 0);
    level scripts\engine\utility::_id_108A7(10, "dialogue_finished");
    level notify("step_three_is_done");
  } else {
    level thread lock_down_cooldown_watcher();
    level.n_stele_charge_progress = 0;
    level thread awake_small_steles();
    level thread _id_0720::play_narration(["zm_cpm4_mqs4_vrcn_qgco", "zm_cpm4_mqs4_vrcn_qgcp", "zm_cpm4_mqs4_vrcn_qgcq", "zm_cpm4_mqs4_vrcn_qgcr"], 1, 0);
    set_lock_down_clips(0, level.a_lock_down_clips, level.a_lock_down_clip_fxs);
    scripts\engine\utility::_id_5C1B("round_spawn_zombies");
    level scripts\cp\maps\cp_sumpf\cp_sumpf_zipline::set_zipline_disabled(0);
  }
}

force_teleport_player() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::getStructArray("mq_step3_teleport_loc", "script_noteworthy");

  foreach(var_2 in level.players) {
    var_3 = var_2 scripts\cp\zone_manager::_id_642F();

    if(!scripts\engine\utility::is_equal(var_3.script_zone_name, "doctors_quarters_outside_zone") && !scripts\engine\utility::is_equal(var_3.script_zone_name, "doctors_quarters_outside_to_center_building_zone")) {
      _id_098A::warp_sepcific_player(var_0, var_2);
    }
  }
}

reset_lock_down() {
  level scripts\engine\utility::_id_5C04("mq_small_stele_interacted");
  level.n_player_amount_interact_small_stele = 0;

  foreach(var_1 in level.a_s_small_stele_interacts) {
    if(istrue(var_1.is_activated)) {
      var_1.is_activated = 0;
      var_1 notify("stop_small_stele_fx_trails");
    }
  }
}

setup_params_for_lock_down() {
  level.n_lock_down_duration = 0;
  level.n_stele_charge_progress = 0;
  level.n_stele_charge_requirement = 0;

  switch (level.players.size) {
    case 1:
      level.n_lock_down_duration = 90;
      level.n_stele_charge_requirement = 10;
      break;
    case 2:
      level.n_lock_down_duration = 100;
      level.n_stele_charge_requirement = 13;
      break;
    case 3:
      level.n_lock_down_duration = 110;
      level.n_stele_charge_requirement = 16;
      break;
    case 4:
      level.n_lock_down_duration = 120;
      level.n_stele_charge_requirement = 19;
      break;
    default:
      level.n_lock_down_duration = 90;
      level.n_stele_charge_requirement = 10;
      break;
  }

  level.n_each_phase_duration = level.n_lock_down_duration / 4;
}

small_stele_fx_watcher() {
  level endon("game_ended");
  self endon("stop_small_stele_fx_trails");

  for(;;) {
    level thread send_fx_trail(self.origin, level.s_stele_loc.origin + (0, 30, 70), "mq_stele_charge_trail", 200);
    wait 0.8;
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
    var_5 playLoopSound("zmb_yellow_beam_lp");
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

central_stele_fx_watcher() {
  level endon("game_ended");
  var_0 = undefined;

  if(isDefined(level.s_stele_loc)) {
    var_0 = scripts\cp\utility::_id_E190("tag_origin", level.s_stele_loc.origin + (0, 20, 50));
    var_0.angles = level.s_stele_loc.angles;
    waitframe();
    var_0 playLoopSound("zmb_soul_charging_lp");
  }

  level thread play_central_stele_fx("mq_stele_charge_central_fx_01", "mq_achieve_chrging_progress_25");
  level waittill("mq_achieve_chrging_progress_25");
  level thread play_central_stele_fx("mq_stele_charge_central_fx_02", "mq_achieve_chrging_progress_50");
  level waittill("mq_achieve_chrging_progress_50");
  level thread play_central_stele_fx("mq_stele_charge_central_fx_03", "mq_achieve_chrging_progress_75");
  level waittill("mq_achieve_chrging_progress_75");
  level thread play_central_stele_fx("mq_stele_charge_central_fx_04", "lock_down_finished");
  level waittill("lock_down_finished");

  if(isDefined(level.s_stele_loc)) {
    var_0 stoploopsound();
    var_0 delete();
  }
}

lock_down_cooldown_watcher() {
  level endon("game_ended");
  level endon("step_three_is_done");
  level scripts\engine\utility::_id_5C1B("mq_lock_down_in_cd");
  level waittill("round_start");
  level scripts\engine\utility::_id_5C04("mq_lock_down_in_cd");
}

lock_down_zombie_spawn_watcher() {
  level endon("game_ended");
  level endon("lock_down_finished");
  var_0 = level.players.size;
  var_1 = [4, 4, 4, 4];
  var_2 = [3, 3, 3, 3];
  var_3 = [2, 2, 2, 2];
  var_4 = [1, 1, 1, 1];
  var_5 = [5, 5, 5, 5];
  var_6 = [4, 4, 4, 4];
  var_7 = [3, 3, 3, 3];
  var_8 = [2, 2, 2, 2];
  var_9 = [10, 10, 10, 10];
  var_10 = [10, 10, 10, 10];
  var_11 = [8, 8, 8, 8];
  var_12 = [8, 8, 8, 8];
  var_13 = [7, 7, 7, 7];
  var_14 = [15, 15, 15, 15];
  var_15 = [20, 20, 20, 20];
  var_16 = [20, 20, 20, 20];
  var_17 = [1, 2, 3, 4];
  var_18 = [1, 2, 3, 4];
  var_19 = [1, 2, 3, 4];
  var_20 = [1, 2, 3, 4];
  var_21 = [1, 1, 2, 2];
  var_22 = [1, 1, 2, 2];
  var_23 = [1, 1, 2, 2];
  var_24 = [1, 1, 2, 2];
  level thread spawn_zombie_in_lock_down("base", "enemy_base_zombie_sumpf_cp", var_1[var_0 - 1], var_13[var_0 - 1], "mq_lock_down_phase_two_started");
  level thread spawn_zombie_in_lock_down("screamer", "enemy_zombie_screamer_cp", var_5[var_0 - 1], var_17[var_0 - 1], "mq_lock_down_phase_two_started");
  level thread spawn_zombie_in_lock_down("juggernaut", "enemy_zombie_juggernaut_cp", var_9[var_0 - 1], var_21[var_0 - 1], "mq_lock_down_phase_two_started");
  level waittill("mq_lock_down_phase_two_started");
  level thread spawn_zombie_in_lock_down("base", "enemy_base_zombie_sumpf_cp", var_2[var_0 - 1], var_14[var_0 - 1], "mq_lock_down_phase_three_started");
  level thread spawn_zombie_in_lock_down("screamer", "enemy_zombie_screamer_cp", var_6[var_0 - 1], var_18[var_0 - 1], "mq_lock_down_phase_three_started");
  level thread spawn_zombie_in_lock_down("juggernaut", "enemy_zombie_juggernaut_cp", var_10[var_0 - 1], var_22[var_0 - 1], "mq_lock_down_phase_three_started");
  level waittill("mq_lock_down_phase_three_started");
  level thread spawn_zombie_in_lock_down("base", "enemy_base_zombie_sumpf_cp", var_3[var_0 - 1], var_15[var_0 - 1], "mq_lock_down_phase_four_started");
  level thread spawn_zombie_in_lock_down("screamer", "enemy_zombie_screamer_cp", var_7[var_0 - 1], var_19[var_0 - 1], "mq_lock_down_phase_four_started");
  level thread spawn_zombie_in_lock_down("juggernaut", "enemy_zombie_juggernaut_cp", var_11[var_0 - 1], var_23[var_0 - 1], "mq_lock_down_phase_four_started");
  level waittill("mq_lock_down_phase_four_started");
  level thread spawn_zombie_in_lock_down("base", "enemy_base_zombie_sumpf_cp", var_4[var_0 - 1], var_16[var_0 - 1], "lock_down_finished");
  level thread spawn_zombie_in_lock_down("screamer", "enemy_zombie_screamer_cp", var_8[var_0 - 1], var_20[var_0 - 1], "lock_down_finished");
  level thread spawn_zombie_in_lock_down("juggernaut", "enemy_zombie_juggernaut_cp", var_12[var_0 - 1], var_24[var_0 - 1], "lock_down_finished");
}

lock_down_progress_watcher() {
  level endon("game_ended");
  level notify("mq_lock_down_phase_one_started");
  wait(level.n_each_phase_duration);
  level notify("mq_lock_down_phase_two_started");
  level.a_s_small_stele_interacts[0] notify("stop_small_stele_fx_trails");
  wait(level.n_each_phase_duration);
  level notify("mq_lock_down_phase_three_started");
  level.a_s_small_stele_interacts[1] notify("stop_small_stele_fx_trails");
  wait(level.n_each_phase_duration);
  level notify("mq_lock_down_phase_four_started");
  level.a_s_small_stele_interacts[2] notify("stop_small_stele_fx_trails");
  wait(level.n_each_phase_duration);
  level.a_s_small_stele_interacts[3] notify("stop_small_stele_fx_trails");
  wait 5;
  level thread stop_lock_down();
}

spawn_zombie_in_lock_down(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  level endon(var_4);

  for(;;) {
    if(get_alive_zombies_count(var_0) < var_3) {
      if(scripts\engine\utility::is_equal(var_0, "screamer")) {
        var_5 = pick_random_spawner(level.a_s_lock_down_screamer_spawners);
      } else {
        var_5 = pick_random_spawner(level.a_s_lock_down_zombie_spawners);
      }

      var_6 = _id_09A4::_id_110AD(var_1, var_5.origin, var_5.angles, var_5);
      var_6.b_ignore_cleanup = 1;
      wait 0.5;

      if(isDefined(var_6) && isalive(var_6)) {
        var_6.brain_rot_immune = 1;
        var_6._id_4A75 = 1;
        var_6.on_zombie_killed_score_override_func = ::on_zombie_killed_mq_give_score;

        if(scripts\engine\utility::is_equal(var_0, "base")) {
          if(level._id_11049 < 15) {
            if(isDefined(var_6._id_D603)) {
              var_6[[var_6._id_D603]]("sprint");
            }

            var_6.maxhealth = 1500;
            var_6.health = 1500;
          }
        }
      }
    }

    wait(var_2);
  }
}

spawn_charge_zombie_watcher() {
  level endon("game_ended");
  level endon("step_three_is_done");
  level endon("lock_down_finished");
  var_0 = level.n_lock_down_duration / (level.n_stele_charge_requirement * 1.5);

  for(;;) {
    wait(var_0);
    var_1 = pick_random_spawner(level.a_s_charge_zombie_spawners);
    var_2 = _id_09A4::_id_110AD("enemy_base_zombie_sumpf_cp", var_1.origin, var_1.angles, var_1);
    var_2.b_ignore_cleanup = 1;
    wait 0.5;

    if(!isDefined(var_2) || !isalive(var_2)) {
      return;
    }
    if(isDefined(var_2._id_D603)) {
      var_2[[var_2._id_D603]]("super_sprint");
    }

    if(level._id_11049 < 15) {
      var_2.maxhealth = 1500;
      var_2.health = 1500;
    }

    var_2.brain_rot_immune = 1;
    var_2._id_4A75 = 1;
    var_2.on_zombie_killed_score_override_func = ::on_zombie_killed_mq_give_score;
    var_2.b_is_stele_zombie = 1;
    var_2 thread play_charge_fx();
  }
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

set_lock_down_clips(var_0, var_1, var_2) {
  if(istrue(var_0)) {
    foreach(var_4 in var_1) {
      var_4 solid();
      var_4 _meth_80B5();
    }

    foreach(var_7 in var_2) {
      var_7 show();
    }
  } else {
    foreach(var_4 in var_1) {
      var_4 notsolid();
      var_4 _meth_8093();
    }

    foreach(var_7 in var_2) {
      var_7 hide();
    }
  }
}

play_central_stele_fx(var_0, var_1) {
  level endon("game_ended");
  playFXOnTag(level._effect[var_0], level.mdl_center_stele.mdl_fx, "tag_origin");
  level waittill(var_1);

  if(isDefined(level.mdl_center_stele.mdl_fx)) {
    stopFXOnTag(level._effect[var_0], level.mdl_center_stele.mdl_fx, "tag_origin");
  }
}

on_zombie_killed_step_three(var_0) {
  if(istrue(self.b_is_stele_zombie) && check_zombie_is_killed_by_dg2(var_0)) {
    stopFXOnTag(level._effect["mq_stele_charge_zombie_fx"], self, "j_spine4");

    if(distancesquared(self.origin, level.s_stele_loc.origin) < 250000) {
      level thread send_fx_trail(self gettagorigin("j_spine4"), level.s_stele_loc.origin + (0, 30, 70), "mq_zombie_stele_charge_trail", 600);
      level.n_stele_charge_progress++;

      if(isDefined(level.n_stele_charge_requirement) && level.n_stele_charge_progress == int(level.n_stele_charge_requirement / 4)) {
        level thread play_stele_charge_one_quarter_vo();
      }
    }
  }
}

check_zombie_is_killed_by_dg2(var_0) {
  if(isDefined(var_0._id_04F6) && scripts\engine\utility::is_equal(var_0._id_04F6.basename, "s4_ar_tgun_mp")) {
    return 1;
  }

  if(isDefined(var_0._id_511D) && scripts\engine\utility::is_equal(var_0._id_511D._id_0088, "zombie_screamer") && isDefined(var_0._id_511D.damageweapon) && scripts\engine\utility::is_equal(var_0._id_511D.damageweapon.basename, "s4_ar_tgun_mp")) {
    return 1;
  }

  return 0;
}

check_charging_progress() {
  level endon("game_ended");
  level endon("step_three_is_done");
  level endon("lock_down_finished");
  var_0 = int(level.n_stele_charge_requirement / 4);
  var_1 = int(level.n_stele_charge_requirement / 4 * 2);
  var_2 = int(level.n_stele_charge_requirement / 4 * 3);

  for(;;) {
    if(level.n_stele_charge_progress >= var_0 && level.n_stele_charge_progress < var_1) {
      level notify("mq_achieve_chrging_progress_25");
    }

    if(level.n_stele_charge_progress >= var_1 && level.n_stele_charge_progress < var_2) {
      level notify("mq_achieve_chrging_progress_50");
    }

    if(level.n_stele_charge_progress >= var_2) {
      level notify("mq_achieve_chrging_progress_75");
    }

    wait 0.5;
  }
}

play_charge_fx() {
  self endon("death");
  level endon("game_ended");
  wait 1;

  if(!isalive(self)) {
    return;
  }
  self playLoopSound("zmb_ai_glow_lp");
  playFXOnTag(level._effect["mq_stele_charge_zombie_fx"], self, "j_spine4");
}

play_stele_charge_one_quarter_vo() {
  var_0 = ["zm_cpm4_mqs4_krtx_qgcg", "zm_cpm4_mqs4_dsrx_qgch"];
  var_1 = ["zm_cpm4_mqs4_krtx_qgci", "zm_cpm4_mqs4_dsrx_qgcj"];
  var_2 = ["zm_cpm4_mqs4_krtx_qgck", "zm_cpm4_mqs4_dsrx_qgcl"];
  var_3 = ["zm_cpm4_mqs4_krtx_qgcm", "zm_cpm4_mqs4_dsrx_qgcn"];
  var_4 = scripts\engine\utility::random([var_0, var_1, var_2, var_3]);
  level thread _id_0720::play_narrations(var_4, 1, 0, "force_quit_current_dialogue");
}

init_step_four_saraxis_echo() {
  _func_01E3("echo_vign");
  level thread scripts\cp\maps\cp_sumpf\cp_sumpf_wwq::fadetowhite(0.3);
  level thread saraxis_echo_vignette_watcher();
}

do_step_four_saraxis_echo() {
  level waittill("step_four_is_done");
  _func_01E3("none");
}

cleanup_step_four_saraxis_echo() {
  scripts\engine\utility::_id_5C1B("round_spawn_zombies");
  level scripts\cp\maps\cp_sumpf\cp_sumpf_zipline::set_zipline_disabled(0);

  if(isDefined(level.sara_echo)) {
    level.sara_echo delete();
  }

  if(isDefined(level.e_zombie_blood_fountain)) {
    level.e_zombie_blood_fountain setModel("s4_zm_broken_demonic_fountain_revive");
    level.e_zombie_blood_fountain thread blood_dropping_fx_watcher();
  }
}

debug_step_four_saraxis_echo() {
  level notify("step_four_is_done");
}

saraxis_echo_vignette_watcher() {
  level endon("game_ended");
  level endon("step_four_is_done");
  var_0 = scripts\engine\utility::getstruct("mq_step_four_saraxis_movement_start_loc", "script_noteworthy");

  if(!isDefined(var_0)) {
    return;
  }
  level.sara_echo = scripts\cp\utility::_id_E190("tag_origin", var_0.origin, var_0.angles);
  level.sara_echo endon("death");
  waitframe();

  if(!isDefined(level.sara_echo)) {
    return;
  }
  playsoundatpos(level.sara_echo.origin, "zmb_echo_orb_spawn");
  playFX(scripts\engine\utility::getfx("mq_sara_echo_turn_to_idle"), level.sara_echo.origin);
  playFXOnTag(scripts\engine\utility::getfx("mq_sara_echo_idle_loop"), level.sara_echo, "tag_origin");
  level.sara_echo playLoopSound("zmb_echo_orb_lp");
  wait 2;
  level notify("force_quit_current_dialogue");
  waitframe();
  level thread _id_0720::play_narrations(["zm_cpm4_mqs4_dsrx_qgda", "zm_cpm4_mqs4_vrcn_qgdb", "zm_cpm4_mqs4_vrcn_qgdc"], 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");

  if(!isDefined(level.sara_echo)) {
    return;
  }
  var_1 = scripts\engine\utility::getstruct("mq_step_four_saraxis_spawn_loc", "script_noteworthy");

  if(isDefined(var_1)) {
    level.sara_echo moveto(var_1.origin, 4);
  }

  level.sara_echo play_sound_and_wait("zm_cpm4_mqs4_deco_qgdd");
  level thread _id_0720::play_narrations(["zm_cpm4_mqs4_dsrx_qgde", "zm_cpm4_mqs4_dsrx_qgdf"], 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");

  if(!isDefined(level.sara_echo)) {
    return;
  }
  level.sara_echo play_sound_and_wait("zm_cpm4_mqs4_deco_qgdg");
  level thread _id_0720::play_narrations(["zm_cpm4_mqs4_dsrx_qgdh", "zm_cpm4_mqs4_dsrx_qgdi"], 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");

  if(!isDefined(level.sara_echo)) {
    return;
  }
  var_2 = _func_02A9(level.sara_echo.origin, 20);

  if(isDefined(var_2)) {
    stopFXOnTag(scripts\engine\utility::getfx("mq_sara_echo_idle_loop"), level.sara_echo, "tag_origin");
    wait 0.5;

    if(!isDefined(level.sara_echo)) {
      return;
    }
    level.sara_echo moveto(var_2 + (0, 0, 61), 0.1);
    playFX(scripts\engine\utility::getfx("mq_sara_echo_turn_to_angry"), level.sara_echo.origin);
    playFXOnTag(scripts\engine\utility::getfx("mq_sara_echo_angry_loop"), level.sara_echo, "tag_origin");
  }

  level.sara_echo changeechoballsoundstate(1);
  level.sara_echo play_sound_and_wait("zm_cpm4_mqs4_deco_qgdj");

  if(!isDefined(level.sara_echo)) {
    return;
  }
  var_2 = _func_02A9(level.sara_echo.origin, 20);

  if(isDefined(var_2)) {
    stopFXOnTag(scripts\engine\utility::getfx("mq_sara_echo_angry_loop"), level.sara_echo, "tag_origin");
    wait 0.5;

    if(!isDefined(level.sara_echo)) {
      return;
    }
    level.sara_echo moveto(var_2 + (0, 0, 61), 0.1);
    playFX(scripts\engine\utility::getfx("mq_sara_echo_turn_to_calm"), level.sara_echo.origin);
    playFXOnTag(scripts\engine\utility::getfx("mq_sara_echo_calm_loop"), level.sara_echo, "tag_origin");
  }

  level.sara_echo changeechoballsoundstate(0);
  level.sara_echo play_sound_and_wait("zm_cpm4_mqs4_deco_qgdk");
  level thread _id_0720::play_narration("zm_cpm4_mqs4_dsrx_qgdl", 1, 0);
  level waittill("dialogue_finished");

  if(!isDefined(level.sara_echo)) {
    return;
  }
  var_2 = _func_02A9(level.sara_echo.origin, 20);

  if(isDefined(var_2)) {
    stopFXOnTag(scripts\engine\utility::getfx("mq_sara_echo_calm_loop"), level.sara_echo, "tag_origin");
    wait 0.5;

    if(!isDefined(level.sara_echo)) {
      return;
    }
    level.sara_echo moveto(var_2 + (0, 0, 61), 0.1);
    playFX(scripts\engine\utility::getfx("mq_sara_echo_turn_to_angry"), level.sara_echo.origin);
    playFXOnTag(scripts\engine\utility::getfx("mq_sara_echo_angry_loop"), level.sara_echo, "tag_origin");
  }

  level.sara_echo changeechoballsoundstate(1);
  level.sara_echo play_sound_and_wait("zm_cpm4_mqs4_deco_qgdm");

  if(isDefined(level.sara_echo)) {
    stopFXOnTag(scripts\engine\utility::getfx("mq_sara_echo_angry_loop"), level.sara_echo, "tag_origin");
    level.sara_echo stoploopsound();
    playsoundatpos(level.sara_echo.origin, "zmb_echo_orb_leave");
  }

  wait 1;
  play_ending_vo();
  level notify("step_four_is_done");
}

play_ending_vo() {
  level endon("game_ended");
  level endon("step_four_is_done");

  foreach(var_1 in level.a_lock_down_clips) {
    var_1 notsolid();
    var_1 _meth_8093();
    var_1 delete();
  }

  foreach(var_4 in level.a_lock_down_clip_fxs) {
    var_4 hide();
    var_4 delete();
  }

  level thread _id_0720::play_narrations(["zm_cpm4_mqs4_krft_qgdn", "zm_cpm4_mqs4_dsrx_qgdo", "zm_cpm4_mqs4_dsrx_qgdp"], 1, 0, "force_quit_current_dialogue");
  level thread wait_and_resume_gameplay(_id_0720::get_dialogue_length("zm_cpm4_mqs4_krft_qgdn") + _id_0720::get_dialogue_length("zm_cpm4_mqs4_dsrx_qgdo"));
  level waittill("dialogue_finished");
  _id_0720::play_event_vo_from_selected_players("ally_confirmation", level.players, 1);
}

changeechoballsoundstate(var_0) {
  var_1 = "zmb_echo_orb_lp";
  var_2 = "zmb_echo_orb_change_to_not_red";

  if(istrue(var_0)) {
    var_1 = "zmb_echo_orb_red_lp";
    var_2 = "zmb_echo_orb_change_to_red";
  }

  scripts\cp\utility::_id_B8ED(self.origin, var_2);
  self stoploopsound();
  self playLoopSound(var_1);
}

wait_and_resume_gameplay(var_0) {
  level endon("game_ended");
  wait(var_0);
  scripts\engine\utility::_id_5C1B("round_spawn_zombies");
}

play_sound_and_wait(var_0) {
  level endon("game_ended");

  if(!isDefined(self.origin)) {
    return 0;
  }

  scripts\cp\utility::_id_B8ED(self.origin, var_0);
  var_1 = _id_0720::get_dialogue_length(var_0);
  wait(var_1);
}

init_step_five_mirror() {
  level.n_zombie_blood_collected = 0;
  level.s_fountain_fx_loc = scripts\engine\utility::getstruct("mq_blood_fountain_fx_loc", "script_noteworthy");
  level.a_mdl_mirror_parts = [];
  level.e_blood_surface = scripts\cp\utility::_id_E190("tag_origin", level.e_zombie_blood_fountain.origin, level.e_zombie_blood_fountain.angles);
  level.e_blood_surface.n_max_height = level.e_blood_surface.origin[2];
  level.e_blood_surface.n_min_height = level.e_blood_surface.origin[2] + -20;
  playFXOnTag(level._effect["mq_flogger_kill_blood_surface"], level.e_blood_surface, "tag_origin");
  level.e_blood_surface set_blood_surface_height(-20);
  level thread set_up_mirror_part_one();
  var_0 = scripts\engine\utility::getStructArray("mq_mirror_part_finder_loc", "script_noteworthy");
  var_1 = randomint(var_0.size);
  var_2 = var_0[var_1];
  var_2.mdl_fx = scripts\cp\utility::_id_E190("tag_origin", var_2.origin, var_2.angles);
  playFXOnTag(level._effect["mq_mirror_path_finder_orb_fx"], var_2.mdl_fx, "tag_origin");
  var_2.mdl_fx.b_orb_show = 0;
  var_2.mdl_fx thread zombie_blood_visable_watcher();
  var_2.mdl_fx thread mirror_finder_lifetime_watcher();
  var_2.mdl_fx thread play_mirror_or_orb_sound_watcher();
  var_2 thread mirror_part_finder_start_wait();
  _id_0737::_id_C266("mq_step_five_empty_fountain_loc", ::hint_interact_blood_fountain, ::on_interact_blood_fountain, ::init_interact_blood_fountain);
  level._id_8393["mq_step_five_empty_fountain_loc"].hint_type_func = ::blood_fountain_get_hint_type;
  _id_0737::_id_C266("mq_central_altar_btn", ::hint_interact_central_altar, ::on_interact_central_altar);
  _id_0737::addinteractionhinttypecallback("mq_central_altar_btn", ::hint_type_central_altar);
  _id_06CB::_id_AA4A(::on_zombie_killed_step_five);
  level.regen_scalar_update_func = ::zombie_blood_health_regen_mod;
  level.aether_shroud_speed_scaler_override_func = ::get_zombie_blood_speed_scaler;
}

do_step_five_mirror() {
  level thread _id_0720::play_narrations(["zm_cpm4_mqs4_dsrx_qgea", "zm_cpm4_mqs4_dsrx_qgeb", "zm_cpm4_mqs4_vrcn_qgec", "zm_cpm4_mqs4_vrcn_qged", "zm_cpm4_mqs4_dsrx_qgee", "zm_cpm4_mqs4_dsrx_qgef", "zm_cpm4_mqs4_vrcn_qgeg"], 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");
  level waittill("step_five_is_done");
}

cleanup_step_five_mirror() {
  _id_0737::_id_C4AB("mq_central_altar_btn");
  try_to_spawn_mirror_on_altar();
}

debug_step_five_mirror() {
  level notify("dialogue_finished");
  waitframe();
  level notify("step_five_is_done");
}

set_up_mirror_part_one() {
  level endon("game_ended");
  level endon("step_five_is_done");
  var_0 = scripts\engine\utility::getStructArray("mq_mirror_part_01_loc", "script_noteworthy");
  var_1 = randomint(var_0.size);
  var_2 = var_0[var_1];
  var_2.mdl_mirror_part = scripts\cp\utility::_id_E190("s4_zm_bronze_mirror_full_break", var_2.origin, var_2.angles);
  var_2.mdl_mirror_part.b_mirror_show = 0;
  var_2.mdl_mirror_part _meth_82CB("s4_zm_bronze_mirror_idle_l_01");
  level.a_mdl_mirror_parts = scripts\engine\utility::array_add(level.a_mdl_mirror_parts, var_2.mdl_mirror_part);
  wait 0.5;
  playFXOnTag(level._effect["mq_mirror_part_ambient_fx"], var_2.mdl_mirror_part, "j_mirror_left");
  var_2.s_destination = scripts\engine\utility::getstruct(var_2.target, "targetname");
  var_2.s_destination.s_my_parent = var_2;
  var_2.t_dmg = getent(var_2.target, "targetname");
  var_2 thread mirror_part_dmg_watcher();
  var_2.mdl_mirror_part thread zombie_blood_visable_watcher();
  var_2.mdl_mirror_part thread play_mirror_or_orb_sound_watcher();
  var_3 = scripts\engine\utility::getstruct(var_2.target, "script_noteworthy");
  var_4 = scripts\cp\utility::_id_E190("s4_zm_kanji_symbols_x", var_3.origin, var_3.angles);
  var_4 thread zombie_blood_visable_watcher();
  var_4 thread x_marker_remove_watcher();
}

check_zombie_blood(var_0) {
  return istrue(var_0.b_in_zombie_blood);
}

hint_interact_blood_fountain(var_0, var_1) {
  if(check_zombie_blood(var_1)) {
    return "";
  }

  if(level scripts\engine\utility::_id_5C00("mq_zmb_bld_ready")) {
    return &"CP_SUMPF/MQ_DRINK_ZOMBIE_BLOOD";
  } else {
    return &"CP_SUMPF/MQ_OUT_OF_BLOOD";
  }
}

on_interact_blood_fountain(var_0, var_1) {
  if(check_zombie_blood(var_1)) {
    return;
  }
  if(level scripts\engine\utility::_id_5C00("mq_zmb_bld_ready")) {
    var_1 _meth_827A("cp_zm_s2_mq_shield_rumble", var_1.origin);
    var_1 thread do_active_zombie_blood_sequence();
  } else
    var_1 thread blood_fountain_interact_failed();
}

blood_fountain_get_hint_type(var_0, var_1) {
  if(check_zombie_blood(var_1)) {
    return "HINT_NOBUTTON";
  }

  if(level scripts\engine\utility::_id_5C00("mq_zmb_bld_ready")) {
    return "HINT_NOICON";
  } else {
    return "HINT_NOBUTTON";
  }
}

init_interact_blood_fountain(var_0) {}

do_active_zombie_blood_sequence() {
  level endon("game_ended");
  level endon("step_five_is_done");

  if(scripts\engine\utility::_id_5C00("mq_blood_fountain_fullfilled")) {
    scripts\engine\utility::_id_5C04("mq_blood_fountain_fullfilled");
  }

  level.e_blood_surface set_blood_surface_height(-6.5);
  self playlocalsound("zmb_ui_purchase_accept");
  _id_0720::_id_BEC0("upgrade_perk", 1);
  childthread play_zombie_blood_gestrue();
  wait 2;
  thread apply_zombie_blood_1p_fx();
  level.n_zombie_blood_collected = level.n_zombie_blood_collected - 6.66667;
  level.n_zombie_blood_collected = clamp(level.n_zombie_blood_collected, 0, 20);

  if(level.n_zombie_blood_collected <= 6.66667) {
    if(scripts\engine\utility::_id_5C00("mq_zmb_bld_ready")) {
      level scripts\engine\utility::_id_5C04("mq_zmb_bld_ready");
    }
  }
}

blood_fountain_interact_failed() {
  level endon("game_ended");
  level endon("step_five_is_done");
  self playlocalsound("zmb_ui_purchase_deny");
  wait 1;
  level thread play_drink_empty_fountain_vo(self);
}

play_zombie_blood_gestrue() {
  self endon("disconnect");
  var_0 = "s4_zm_vm_ges_goblet_shinomq_zombie_blood";
  var_1 = self getcurrentweapon();

  if(var_1.type == "riotshield") {
    return;
  } else {
    self loadweaponsforplayer([var_0]);
    wait 0.1;

    if(isDefined(self)) {
      scripts\cp\utility::playgestureweaponanim(var_0);
    }
  }
}

apply_zombie_blood_1p_fx() {
  self endon("death");
  level endon("game_ended");

  if(check_zombie_blood(self)) {
    return;
  }
  _func_019D(scripts\engine\utility::getfx("mq_zombie_blood"), self, "j_head", self);
  self visionsetnakedforplayer("zm_zombie_blood", 0.5);
  self.b_in_zombie_blood = 1;
  level notify("player_zombie_blood_changed");
  self._id_A25F = self._id_A25F + 0.5;
  thread _id_073C::_id_FCCC();
  scripts\cp\utility::_id_B8F4("zmb_zombie_blood_start", self);
  self playLoopSound("zmb_zombie_blood_lp");
  thread zombie_blood_revive_watcher();
  wait 45;
  self notify("mq_zmb_blood_off");

  if(_func_0107(level.a_mdl_mirror_parts)) {
    foreach(var_1 in level.a_mdl_mirror_parts) {
      if(isDefined(var_1)) {
        playFXOnTag(level._effect["mq_mirror_part_showup_fx"], var_1, "tag_origin");
      }
    }
  }

  _func_02D1(scripts\engine\utility::getfx("mq_zombie_blood"), self, "j_head", self);
  self visionsetnakedforplayer("", 0.5);
  self.b_in_zombie_blood = 0;
  level notify("player_zombie_blood_changed");
  self._id_A25F = self._id_A25F - 0.5;
  self._id_A25F = clamp(self._id_A25F, 1, 999);
  thread _id_073C::_id_FCCC();
  level thread play_zombie_blood_clear_vo(self);
  self stoploopsound("zmb_zombie_blood_lp");
  scripts\cp\utility::_id_B8F4("zmb_zombie_blood_stop", self);
}

zombie_blood_revive_watcher() {
  self endon("death");
  self endon("disconnect");
  self endon("mq_zmb_blood_off");
  level endon("game_ended");

  for(;;) {
    self waittill("exit_last_stand");
    self visionsetnakedforplayer("zm_zombie_blood", 0.5);
  }
}

on_zombie_killed_step_five(var_0) {
  if(scripts\cp\zombies\zm_flogger::is_hit_by_flogger(var_0._id_511D)) {
    thread dead_zombie_near_fountain_check();
  }
}

dead_zombie_near_fountain_check() {
  level endon("game_ended");
  level endon("step_five_is_done");

  if(scripts\cp\utility::_id_A2B8(gettime()) > scripts\cp\utility::_id_A2B8(level.flogger.activation_time) + 4 && scripts\cp\utility::_id_A2B8(gettime()) < scripts\cp\utility::_id_A2B8(level.flogger.activation_time) + 35 - 4) {
    wait 0.8;
    scripts\cp\utility::_id_B8EF("zmb_fountain_impact", level.e_zombie_blood_fountain.origin);
    playFX(level._effect["mq_zombie_blood_blast_fx"], level.s_fountain_fx_loc.origin);
    level.e_zombie_blood_fountain thread play_blood_drop_fx();
    level.e_blood_surface set_blood_surface_height(1);
    level thread play_zombie_blood_start_filling_vo();
    level.n_zombie_blood_collected = level.n_zombie_blood_collected + 1;
    level.n_zombie_blood_collected = clamp(level.n_zombie_blood_collected, 0, 20);

    if(level.n_zombie_blood_collected >= 6.66667) {
      if(!scripts\engine\utility::_id_5C00("mq_zmb_bld_ready")) {
        level scripts\engine\utility::_id_5C1B("mq_zmb_bld_ready");
        level thread play_zombie_blood_filled_vo();
      }
    }

    if(scripts\engine\utility::is_equal(level.n_zombie_blood_collected, 20)) {
      if(!scripts\engine\utility::_id_5C00("mq_blood_fountain_fullfilled")) {
        scripts\engine\utility::_id_5C1B("mq_blood_fountain_fullfilled");
      }
    }
  } else {}
}

play_blood_drop_fx() {
  level endon("game_ended");
  level endon("step_five_is_done");
  var_0 = scripts\cp\utility::_id_E190("tag_origin", self.origin, self.angles);
  playFXOnTag(level._effect["mq_flogger_kill_blood_drop"], var_0, "tag_origin");
  wait 1;
  _func_0130(var_0);
  var_0 delete();
}

set_blood_surface_height(var_0) {
  var_1 = self.origin[2];
  var_1 = clamp(var_1 + var_0, self.n_min_height, self.n_max_height);
  self.v_dest = (self.origin[0], self.origin[1], var_1);
  level notify("mq_blood_surface_stop_moving");
  thread blood_surface_move();
}

blood_surface_move() {
  level endon("game_ended");
  level endon("step_five_is_done");
  level endon("mq_blood_surface_stop_moving");
  var_0 = distance(self.origin, self.v_dest) / 10;

  if(var_0 > 0) {
    self moveto(self.v_dest, var_0, 0, 0);
  }
}

mirror_part_dmg_watcher() {
  level endon("game_ended");
  level endon("step_five_is_done");

  for(;;) {
    self.t_dmg waittill("damage", var_0, var_1);

    if(check_zombie_blood(var_1)) {
      level notify("mq_mirror_part_one_hit");

      foreach(var_3 in level.players) {
        if(isPlayer(var_3)) {
          if(check_zombie_blood(var_3)) {
            if(!isDefined(self.proxy_fx_entity)) {
              self.proxy_fx_entity = scripts\cp\utility::_id_E190("tag_origin", self.origin);
            }

            _func_019D(level._effect["mq_mirror_part_hit_fx"], self.proxy_fx_entity, "tag_origin", var_3);
            scripts\cp\utility::_id_B8EF("zmb_mirror_piece_hit", self.origin);
          }
        }
      }

      self.mdl_mirror_part _meth_82CB("s4_zm_bronze_mirror_pain_01");
      wait 2.6;
      self.mdl_mirror_part moveto(self.s_destination.origin, 2, 0, 0);
      self.mdl_mirror_part waittill("movedone");
      self.mdl_mirror_part _meth_82CB("s4_zm_bronze_mirror_idle_l_01");
      self.mdl_mirror_part thread show_hide_outline();
      _id_0737::_id_C266(self.s_destination._id_039B, ::hint_interact_mirror_part, ::on_interact_mirror_part_one);

      if(isDefined(self.t_dmg)) {
        self.t_dmg delete();
      }

      if(isDefined(self.proxy_fx_entity)) {
        self.proxy_fx_entity delete();
      }
    }
  }
}

play_mirror_or_orb_sound_watcher() {
  level endon("game_ended");
  self endon("death");
  level endon("step_five_is_done");

  for(;;) {
    level.players_in_zombie_blood = 0;

    foreach(var_1 in level.players) {
      if(check_zombie_blood(var_1)) {
        level.players_in_zombie_blood = 1;
        break;
      }
    }

    if(level.players_in_zombie_blood) {
      if(isDefined(self.b_orb_show) && !self.b_orb_show) {
        scripts\cp\utility::_id_B8EF("zmb_mirror_red_orb_spawn", self.origin);
        self playLoopSound("zmb_mirror_red_orb_lp");
        self.b_orb_show = 1;
      }

      if(isDefined(self.b_mirror_show) && !self.b_mirror_show) {
        scripts\cp\utility::_id_B8EF("zmb_mirror_piece_spawn", self.origin);
        self playLoopSound("zmb_mirror_piece_lp");
        self.b_mirror_show = 1;
      }
    } else {
      if(istrue(self.b_orb_show)) {
        scripts\cp\utility::_id_B8EF("zmb_mirror_red_orb_leave", self.origin);
        self stoploopsound("zmb_mirror_red_orb_lp");
        self.b_orb_show = 0;
      }

      if(istrue(self.b_mirror_show)) {
        scripts\cp\utility::_id_B8EF("zmb_mirror_piece_leave", self.origin);
        self stoploopsound("zmb_mirror_piece_lp");
        self.b_mirror_show = 0;
      }
    }

    level scripts\engine\utility::_id_108A7(20, "player_zombie_blood_changed");
  }
}

zombie_blood_visable_watcher() {
  level endon("game_ended");
  self endon("death");
  level endon("step_five_is_done");

  for(;;) {
    foreach(var_1 in level.players) {
      if(check_zombie_blood(var_1)) {
        self showtoplayer(var_1);
        continue;
      }

      self hidefromplayer(var_1);
    }

    waitframe();
  }
}

on_interact_mirror_part_one(var_0, var_1) {
  if(check_zombie_blood(var_1)) {
    level thread play_get_mirror_parts_vo();
    level scripts\engine\utility::_id_5C1B("mq_mirror_part_one_collected");
    var_1 _meth_827A("cp_zm_s2_mq_shield_rumble", var_1.origin);

    if(isDefined(var_0.s_my_parent.mdl_mirror_part)) {
      _func_0130(var_0.s_my_parent.mdl_mirror_part);
      var_0.s_my_parent.mdl_mirror_part delete();
    }

    _id_0737::_id_C3C5(var_0);
  }
}

hint_interact_mirror_part(var_0, var_1) {
  if(check_zombie_blood(var_1)) {
    return &"CP_SUMPF/MQ_PICK_MIRROR_PART";
  } else {
    return "";
  }
}

mirror_part_finder_start_wait() {
  level endon("game_ended");
  level endon("step_five_is_done");

  for(;;) {
    foreach(var_1 in level.players) {
      if(distancesquared(var_1.origin, self.origin) < 10000 && istrue(var_1.b_in_zombie_blood)) {
        thread mirror_part_finder_move();
        level thread play_chase_mirror_orb_vo();
        return;
      }
    }

    wait 1;
  }
}

mirror_part_finder_move() {
  level endon("game_ended");
  level endon("step_five_is_done");
  var_0 = self;
  var_1 = scripts\engine\utility::getstruct(self.target, "targetname");
  var_2 = scripts\engine\utility::getStructArray(var_1._id_039B, "script_noteworthy");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(var_3 < var_2.size - 1) {
      path_finder_spawn_zombie(var_2[var_3 + 1].origin);
    }

    var_1 = scripts\engine\utility::getstruct(var_0.target, "targetname");

    if(isDefined(var_1)) {
      var_4 = distance(var_0.origin, var_1.origin) / 150;

      if(isDefined(self.mdl_fx)) {
        self.mdl_fx moveto(var_1.origin, var_4, 0, 0);
        self.mdl_fx waittill("movedone");
        var_0 = var_1;
      }
    }
  }

  self.mdl_fx thread mirror_part_finder_end_wait(var_1);
}

mirror_finder_lifetime_watcher() {
  level endon("game_ended");
  self endon("death");
  level endon("step_five_is_done");
  level waittill("mq_mirror_part_two_revealed");
  _func_0130(self);
  self delete();
}

mirror_part_finder_end_wait(var_0) {
  level endon("game_ended");
  level endon("step_five_is_done");

  for(;;) {
    foreach(var_2 in level.players) {
      if(distancesquared(var_2.origin, self.origin) < 10000 && istrue(var_2.b_in_zombie_blood)) {
        level thread reveal_mirror_part_two(var_0.target);
        level notify("mq_mirror_part_two_revealed");
        return;
      }
    }

    wait 1;
  }
}

find_playable_spawn_zombie(var_0) {
  var_1 = undefined;

  for(var_2 = 0; var_2 < 16; var_2++) {
    var_3 = _func_02AB(var_0 + (randomint(100), randomint(100), 0));

    if(!isDefined(var_3)) {
      continue;
    }
    if(isDefined(level.check_in_playable_area_func)) {
      if(![[level.check_in_playable_area_func]](var_3)) {
        continue;
      }
    }

    var_1 = var_3;
    break;
  }

  if(!isDefined(var_1)) {
    return undefined;
  }

  var_4 = vectortoangles(var_0 - var_1);
  var_5 = spawnStruct();
  var_5._id_CC9D = "spawn_ground";
  var_5._id_0481 = "spawnStruct";
  var_5.origin = var_1;
  var_5.angles = var_4;
  var_6 = _id_09A4::_id_110AD("enemy_zombie_screamer_cp", var_1, var_4, var_5);
  return var_6;
}

path_finder_spawn_zombie(var_0) {
  level endon("game_ended");
  find_playable_spawn_zombie(var_0);
  waitframe();
  find_playable_spawn_zombie(var_0);
  waitframe();
  find_playable_spawn_zombie(var_0);
}

reveal_mirror_part_two(var_0) {
  level endon("game_ended");
  level endon("step_five_is_done");
  var_1 = scripts\engine\utility::getstruct(var_0, "targetname");
  var_1.mdl_mirror_part = scripts\cp\utility::_id_E190("s4_zm_bronze_mirror_full_break", var_1.origin, var_1.angles);
  var_1.mdl_mirror_part.b_mirror_show = 0;
  var_1.mdl_mirror_part thread show_hide_outline();
  var_1.mdl_mirror_part notsolid();
  var_1.mdl_mirror_part _meth_82CB("s4_zm_bronze_mirror_idle_r_01");
  level.a_mdl_mirror_parts = scripts\engine\utility::array_add(level.a_mdl_mirror_parts, var_1.mdl_mirror_part);
  waitframe();
  playFXOnTag(level._effect["mq_mirror_part_showup_fx"], var_1.mdl_mirror_part, "tag_origin");
  playFXOnTag(level._effect["mq_mirror_part_ambient_fx"], var_1.mdl_mirror_part, "j_mirror_right");
  var_1.mdl_mirror_part thread zombie_blood_visable_watcher();
  var_1.mdl_mirror_part thread play_mirror_or_orb_sound_watcher();
  _id_0737::_id_C266(var_1._id_039B, ::hint_interact_mirror_part, ::on_interact_mirror_part_two);
}

on_interact_mirror_part_two(var_0, var_1) {
  if(check_zombie_blood(var_1)) {
    level thread play_get_mirror_parts_vo();
    level scripts\engine\utility::_id_5C1B("mq_mirror_part_two_collected");
    var_1 _meth_827A("cp_zm_s2_mq_shield_rumble", var_1.origin);

    if(isDefined(var_0.mdl_mirror_part)) {
      _func_0130(var_0.mdl_mirror_part);
      var_0.mdl_mirror_part delete();
    }

    _id_0737::_id_C3C5(var_0);
  }
}

on_interact_central_altar(var_0, var_1) {
  if(level scripts\engine\utility::_id_5C00("mq_mirror_part_one_collected") && !level scripts\engine\utility::_id_5C00("mq_mirror_part_two_collected")) {
    level.mdl_altar_blocker solid();
    var_1 _meth_827A("cp_zm_s2_mq_shield_rumble", var_1.origin);
    try_to_spawn_mirror_on_altar();
    scripts\cp\utility::_id_B8ED(level.mdl_altar_mirror.origin, "zmb_mirror_pieces_on_monolith");

    if(level scripts\engine\utility::_id_5C00("mq_mirror_part_two_placed")) {
      level.mdl_altar_mirror _meth_82CB("s4_zm_bronze_mirror_idle_01");
    } else {
      level.mdl_altar_mirror _meth_82CB("s4_zm_bronze_mirror_idle_l_01");
    }

    level scripts\engine\utility::_id_5C04("mq_mirror_part_one_collected");
    level scripts\engine\utility::_id_5C1B("mq_mirror_part_one_placed");
  } else if(!level scripts\engine\utility::_id_5C00("mq_mirror_part_one_collected") && level scripts\engine\utility::_id_5C00("mq_mirror_part_two_collected")) {
    level.mdl_altar_blocker solid();
    try_to_spawn_mirror_on_altar();
    scripts\cp\utility::_id_B8ED(level.mdl_altar_mirror.origin, "zmb_mirror_pieces_on_monolith");

    if(level scripts\engine\utility::_id_5C00("mq_mirror_part_one_placed")) {
      level.mdl_altar_mirror _meth_82CB("s4_zm_bronze_mirror_idle_01");
    } else {
      level.mdl_altar_mirror _meth_82CB("s4_zm_bronze_mirror_idle_r_01");
    }

    level scripts\engine\utility::_id_5C04("mq_mirror_part_two_collected");
    level scripts\engine\utility::_id_5C1B("mq_mirror_part_two_placed");
  } else if(level scripts\engine\utility::_id_5C00("mq_mirror_part_one_collected") && level scripts\engine\utility::_id_5C00("mq_mirror_part_two_collected")) {
    level.mdl_altar_blocker solid();
    try_to_spawn_mirror_on_altar();
    scripts\cp\utility::_id_B8ED(level.mdl_altar_mirror.origin, "zmb_mirror_pieces_on_monolith");
    level.mdl_altar_mirror _meth_82CB("s4_zm_bronze_mirror_idle_01");
    level scripts\engine\utility::_id_5C1B("mq_mirror_part_one_placed");
    level scripts\engine\utility::_id_5C1B("mq_mirror_part_two_placed");
  }

  if(level scripts\engine\utility::_id_5C00("mq_mirror_part_one_placed") && level scripts\engine\utility::_id_5C00("mq_mirror_part_two_placed")) {
    level thread play_both_mirror_parts_placed_vo();
    level notify("step_five_is_done");
    _id_0737::_id_C4AB("mq_central_altar_btn");
  }
}

hint_interact_central_altar(var_0, var_1) {
  if(level scripts\engine\utility::_id_5C00("mq_mirror_part_one_collected") && !level scripts\engine\utility::_id_5C00("mq_mirror_part_one_placed") && level scripts\engine\utility::_id_5C00("mq_mirror_part_two_collected") && !level scripts\engine\utility::_id_5C00("mq_mirror_part_two_placed")) {
    return &"CP_SUMPF/MQ_PLACE_MIRROR_PARTS";
  } else if(level scripts\engine\utility::_id_5C00("mq_mirror_part_one_collected") && !level scripts\engine\utility::_id_5C00("mq_mirror_part_one_placed")) {
    return &"CP_SUMPF/MQ_PLACE_MIRROR_PART";
  } else if(level scripts\engine\utility::_id_5C00("mq_mirror_part_two_collected") && !level scripts\engine\utility::_id_5C00("mq_mirror_part_two_placed")) {
    return &"CP_SUMPF/MQ_PLACE_MIRROR_PART";
  } else {
    return &"CP_SUMPF/MQ_NEED_MIRROR_PART";
  }
}

hint_type_central_altar(var_0, var_1) {
  if(level scripts\engine\utility::_id_5C00("mq_mirror_part_one_collected") && !level scripts\engine\utility::_id_5C00("mq_mirror_part_one_placed")) {
    return "HINT_NOICON";
  } else if(level scripts\engine\utility::_id_5C00("mq_mirror_part_two_collected") && !level scripts\engine\utility::_id_5C00("mq_mirror_part_two_placed")) {
    return "HINT_NOICON";
  } else {
    return "HINT_NOBUTTON";
  }
}

try_to_spawn_mirror_on_altar() {
  if(!isDefined(level.mdl_altar_mirror)) {
    var_0 = scripts\engine\utility::getstruct("mq_altar_mirror_loc", "script_noteworthy");
    level.mdl_altar_mirror = scripts\cp\utility::_id_E190("s4_zm_bronze_mirror_full_break", var_0.origin, var_0.angles);
  }
}

x_marker_remove_watcher() {
  level endon("game_ended");
  level endon("death");
  level endon("step_five_is_done");
  level waittill("step_five_is_done");
  self delete();
}

blood_dropping_fx_watcher() {
  level endon("game_ended");
  level endon("step_five_is_done");
  scripts\cp\utility::_id_B8EF("zmb_fntn_zm_blood_on", self.origin);
  self playLoopSound("zmb_fntn_zm_blood_lp");

  for(;;) {
    try_to_spawn_loop_fx_mdl();
    playFXOnTag(level._effect["mq_flogger_kill_blood_drop_sml"], self.mdl_loop_fx, "tag_origin");
    waitframe();
    stopFXOnTag(level._effect["mq_flogger_kill_blood_drop"], self.mdl_loop_fx, "tag_origin");
    level waittill("mq_blood_fountain_fullfilled");
    playFXOnTag(level._effect["mq_flogger_kill_blood_drop"], self.mdl_loop_fx, "tag_origin");
    waitframe();
    stopFXOnTag(level._effect["mq_flogger_kill_blood_drop_sml"], self.mdl_loop_fx, "tag_origin");
    level waittill("mq_blood_fountain_fullfilled");
  }
}

try_to_spawn_loop_fx_mdl() {
  if(!isDefined(self.mdl_loop_fx)) {
    self.mdl_loop_fx = scripts\cp\utility::_id_E190("tag_origin", self.origin, self.angles);
  }
}

get_zombie_blood_speed_scaler(var_0) {
  if(istrue(var_0.b_in_zombie_blood)) {
    return 1.5;
  } else {
    return 1;
  }
}

play_zombie_blood_start_filling_vo() {
  level endon("game_ended");

  if(!level scripts\engine\utility::_id_5C00("zombie_blood_start_filling_vo_played")) {
    level scripts\engine\utility::_id_5C1B("zombie_blood_start_filling_vo_played");
    level scripts\engine\utility::_id_5C24("flogger_use_vo_played");
    level thread _id_0720::play_narration("zm_cpm4_mqs4_vrcn_qgeh", 1, 0);
  }
}

zombie_blood_health_regen_mod(var_0, var_1) {
  if(check_zombie_blood(var_0)) {
    return var_1 * 3;
  } else {
    return var_1;
  }
}

play_zombie_blood_filled_vo() {
  level endon("game_ended");

  while(istrue(level._id_493C)) {
    wait 0.5;
  }

  if(!level scripts\engine\utility::_id_5C00("zombie_blood_filled_vo_played")) {
    level scripts\engine\utility::_id_5C1B("zombie_blood_filled_vo_played");
    level thread _id_0720::play_narrations(["zm_cpm4_mqs4_vrcn_qgei", "zm_cpm4_mqs4_vrcn_qgej"], 1, 0, "force_quit_current_dialogue");
    level waittill("dialogue_finished");
    level thread _id_0720::play_event_vo_from_selected_players("ally_confirmation", level.players, 1);
  }
}

play_zombie_blood_clear_vo(var_0) {
  if(level scripts\engine\utility::_id_5C00("mq_mirror_part_one_collected") && level scripts\engine\utility::_id_5C00("mq_mirror_part_two_collected")) {
    return;
  }
  if(isDefined(var_0)) {
    var_1 = scripts\engine\utility::random(["zm_cpm4_mqs4_vrcn_qgek", "zm_cpm4_mqs4_vrcn_qgel", "zm_cpm4_mqs4_vrcn_qgem", "zm_cpm4_mqs4_vrcn_qgen", "zm_cpm4_mqs4_vrcn_qgeo", "zm_cpm4_mqs4_vrcn_qgep"]);
    level thread _id_0720::_id_B309(var_0, var_1);
  }
}

play_drink_empty_fountain_vo(var_0) {
  if(isDefined(var_0) && !istrue(scripts\engine\utility::_id_5C00("mq_empty_fountain_vo_in_cd"))) {
    var_1 = scripts\engine\utility::random(["zm_cpm4_mqs4_vrcn_qgeq", "zm_cpm4_mqs4_vrcn_qger", "zm_cpm4_mqs4_vrcn_qges", "zm_cpm4_mqs4_vrcn_qget", "zm_cpm4_mqs4_vrcn_qgeu", "zm_cpm4_mqs4_vrcn_qgev"]);
    level thread _id_0720::_id_B309(var_0, var_1);
    level thread empty_fountain_vo_cooldown();
  }
}

empty_fountain_vo_cooldown() {
  level endon("end_game");
  scripts\engine\utility::_id_5C1B("mq_empty_fountain_vo_in_cd");
  wait 5;
  scripts\engine\utility::_id_5C04("mq_empty_fountain_vo_in_cd");
}

play_chase_mirror_orb_vo() {
  if(!level scripts\engine\utility::_id_5C00("chase_mirror_orb_vo_played")) {
    level scripts\engine\utility::_id_5C1B("chase_mirror_orb_vo_played");
    level thread _id_0720::play_narration(["zm_cpm4_mqs4_vrcn_qgew", "zm_cpm4_mqs4_vrcn_qgex", "zm_cpm4_mqs4_vrcn_qgey", "zm_cpm4_mqs4_vrcn_qgez"], 1, 0);
  }
}

play_get_mirror_parts_vo() {
  level endon("game_ended");

  if(!level scripts\engine\utility::_id_5C00("mq_mirror_part_one_collected") && !level scripts\engine\utility::_id_5C00("mq_mirror_part_two_collected")) {
    var_0 = ["zm_cpm4_mqs4_vlst_qg5a", "zm_cpm4_mqs4_krft_qg5b"];
    var_1 = ["zm_cpm4_mqs4_vlst_qg5c", "zm_cpm4_mqs4_krft_qg5d"];
    var_2 = ["zm_cpm4_mqs4_vlst_qg5e", "zm_cpm4_mqs4_krft_qg5f"];
    var_3 = scripts\engine\utility::random([var_0, var_1, var_2]);
    level thread _id_0720::play_narrations(var_3, 1, 0, "force_quit_current_dialogue");
  } else {
    var_4 = ["zm_cpm4_mqs4_dsrx_qg5g", "zm_cpm4_mqs4_vrcn_qg5h"];
    var_5 = ["zm_cpm4_mqs4_dsrx_qg5i", "zm_cpm4_mqs4_vrcn_qg5j"];
    var_6 = ["zm_cpm4_mqs4_dsrx_qg5k", "zm_cpm4_mqs4_vrcn_qg5l"];
    var_7 = scripts\engine\utility::random([var_4, var_5, var_6]);
    level thread _id_0720::play_narrations(var_7, 1, 0, "force_quit_current_dialogue");
    level waittill("dialogue_finished");
    level thread _id_0720::play_event_vo_from_selected_players("ally_confirmation", level.players, 1);
  }
}

play_both_mirror_parts_placed_vo() {
  var_0 = ["zm_cpm4_mqs4_vrcn_qgfa", "zm_cpm4_mqs4_vrcn_qgfb"];
  var_1 = ["zm_cpm4_mqs4_vrcn_qgfc", "zm_cpm4_mqs4_vrcn_qgfd"];
  var_2 = ["zm_cpm4_mqs4_vrcn_qgfe", "zm_cpm4_mqs4_vrcn_qgff"];
  var_3 = scripts\engine\utility::random([var_0, var_1, var_2]);
  level thread _id_0720::play_narrations(var_3, 1, 0, "force_quit_current_dialogue");
}

init_step_six_altar() {
  level.a_s_monolith_locs = scripts\engine\utility::getStructArray("mq_monolith_loc", "targetname");
  level.n_players_interacted_with_monolith = 0;
  level.n_players_completed_orb_chasing = 0;
  level.s_mirror_loc = scripts\engine\utility::getstruct("mq_central_altar_fx_sender_loc", "script_noteworthy");
  level.s_mirror_loc.mdl_mirror_fx = scripts\cp\utility::_id_E190("tag_origin", level.s_mirror_loc.origin, level.s_mirror_loc.angles);
  playFXOnTag(level._effect["mq_mirror_ambient_uncharged_fx"], level.s_mirror_loc.mdl_mirror_fx, "tag_origin");
}

do_step_six_altar() {
  level thread send_monolith_trails();
  level waittill("orb_chasing_is_done");
  level waittill("step_six_is_done");
}

cleanup_step_six_altar() {
  level monolith_interact_reset(1);

  foreach(var_1 in level.a_s_monolith_locs) {
    if(isDefined(var_1.mdl_fx)) {
      playFX(level._effect["mq_glowing_orb_fx_hit"], var_1.mdl_fx.origin);
      scripts\cp\utility::_id_B8ED(var_1.mdl_fx.origin, "zmb_monolith_orb_leave");
      _func_0130(var_1.mdl_fx);
      var_1.mdl_fx delete();
    }

    _id_0737::_id_C4AB(var_1._id_039B);
  }
}

debug_step_six_altar() {
  level notify("half_mirror_part_placed");
  waitframe();
  level notify("half_mirror_part_placed");
  waitframe();
  level notify("orb_chasing_is_done");
  waitframe();
  level notify("step_six_is_done");
}

send_monolith_trails() {
  level endon("game_ended");
  level endon("step_six_is_done");
  var_0 = scripts\engine\utility::getstruct("mq_central_altar_fx_sender_loc", "script_noteworthy");

  if(isDefined(level.a_s_monolith_locs)) {
    var_1 = scripts\engine\utility::array_randomize(level.a_s_monolith_locs);

    for(var_2 = 0; var_2 < level.players.size; var_2++) {
      var_3 = scripts\cp\utility::_id_E190("tag_origin", var_0.origin, var_0.angles);
      waitframe();
      playFXOnTag(level._effect["mq_zombie_stele_charge_trail"], var_3, "tag_origin");
      var_4 = distance(var_0.origin, var_1[var_2].origin) / 100;
      var_3 moveto(var_1[var_2].origin, var_4, 0, 0);
      var_3 thread altar_trail_move_watcher(var_1[var_2]);
      var_1[var_2].b_is_awaken = 1;
    }
  }
}

altar_trail_move_watcher(var_0) {
  level endon("game_ended");
  level endon("step_six_is_done");
  self endon("death");
  self waittillmatch("movedone");
  var_0 thread init_orb_chasing();
  _func_0130(self);
  self delete();
}

init_orb_chasing() {
  level endon("game_ended");
  level endon("step_six_is_done");
  self.b_has_orb = 1;
  self.mdl_fx = scripts\cp\utility::_id_E190("tag_origin", self.origin, self.angles);
  self.mdl_fx.s_parent = self;
  waitframe();
  playFXOnTag(level._effect["mq_glowing_orb_fx"], self.mdl_fx, "tag_origin");
  scripts\cp\utility::_id_B8ED(self.mdl_fx.origin, "zmb_monolith_orb_spawn");
  self.mdl_fx playLoopSound("zmb_monolith_orb_lp");
  _id_0737::_id_C266(self._id_039B, ::hint_interact_monolith_btn, ::on_interact_monolith_btn, ::init_interact_monolith_btn);
}

on_interact_monolith_btn(var_0, var_1) {
  if(!istrue(var_0.b_is_activated) && !istrue(level._id_204A) && !scripts\engine\utility::_id_5C00("start_rbz_exfil") && istrue(var_0.b_is_awaken)) {
    if(!level scripts\engine\utility::_id_5C00("mq_monolith_btn_interacted")) {
      level thread simultaneously_interact_watcher_monolith();
    }

    scripts\cp\utility::_id_B8ED(var_0.origin, "zmb_monolith_interact");
    var_1 _meth_827A("cp_zm_s2_mq_shield_rumble", var_1.origin);
    var_0.b_is_activated = 1;
    level.n_players_interacted_with_monolith++;

    if(level.n_players_interacted_with_monolith >= level.players.size) {
      foreach(var_1 in level.players) {
        if(isDefined(var_1)) {
          scripts\cp\utility::_id_B8F4("zmb_all_monoliths_interacted", var_1);
        }
      }

      if(level scripts\engine\utility::_id_5C00("orb_chasing_done")) {
        if(!check_team_has_dg_2()) {
          return "";
        }

        level notify("step_six_is_done");
        _id_0737::_id_C3C5(var_0);
      } else {
        level notify("mq_monolith_orbs_leave");
        level thread play_monolith_orbs_chasing_vo();
        level start_monolith_chasing();
      }
    }
  }
}

hint_interact_monolith_btn(var_0, var_1) {
  if(istrue(var_0.b_is_activated) || istrue(level._id_204A) || scripts\engine\utility::_id_5C00("start_rbz_exfil") || !istrue(var_0.b_is_awaken)) {
    return "";
  } else if(level scripts\engine\utility::_id_5C00("orb_chasing_done")) {
    if(!check_team_has_dg_2()) {
      return "";
    }

    return &"CP_SUMPF/MQ_START_MONOLITH_CEREMONY";
  } else
    return &"CP_SUMPF/MQ_START_ORB_CHASING";
}

init_interact_monolith_btn(var_0) {}

simultaneously_interact_watcher_monolith() {
  level endon("game_ended");
  level endon("mq_monolith_orbs_leave");
  level scripts\engine\utility::_id_5C1B("mq_monolith_btn_interacted");
  wait 3;
  var_0 = 0;
  monolith_interact_reset(var_0);
}

monolith_interact_reset(var_0) {
  level scripts\engine\utility::_id_5C04("mq_monolith_btn_interacted");
  level.n_players_interacted_with_monolith = 0;

  foreach(var_2 in level.a_s_monolith_locs) {
    if(istrue(var_2.b_is_activated)) {
      var_2.b_is_activated = 0;
    }

    if(istrue(var_2.b_is_awaken) && istrue(var_0)) {
      var_2.b_is_awaken = 0;
    }
  }
}

start_monolith_chasing() {
  foreach(var_1 in level.a_s_monolith_locs) {
    var_1 thread monolith_orb_move_and_dmg_watcher(100.0, var_1.mdl_fx, 1);
  }

  level thread orb_chasing_duration_watcher();
}

monolith_orb_move_and_dmg_watcher(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("step_six_is_done");
  level endon("orb_chasing_times_out");

  if(!isDefined(var_1)) {
    return;
  }
  var_3 = scripts\engine\utility::getstruct(self.target, "targetname");

  if(isDefined(var_3)) {
    var_4 = distance(self.origin, var_3.origin) / var_0;
    var_1 moveto(var_3.origin, var_4, 0, 1);
    var_1 waittill("movedone");
    wait(var_2);

    if(scripts\engine\utility::is_equal(var_3._id_039B, "mq_no_t_dmg")) {
      var_3 thread monolith_orb_move_and_dmg_watcher(800, var_1, 0);
    } else {
      var_3.t_dmg = getent(var_3._id_0481, "targetname");

      if(isDefined(var_3.t_dmg)) {
        var_3.t_dmg waittill("damage", var_5, var_6);

        if(isPlayer(var_6)) {
          playFXOnTag(level._effect["mq_glowing_orb_fx_hit"], var_1, "tag_origin");
          scripts\cp\utility::_id_B8ED(var_1.origin, "zmb_monolith_orb_hit");
          var_3 thread monolith_orb_move_and_dmg_watcher(800, var_1, 0);
          return;
        }
      } else {
        level.n_players_completed_orb_chasing++;

        if(level.n_players_completed_orb_chasing >= level.players.size) {
          level notify("orb_chasing_is_done");
          level thread play_monolith_orbs_chasing_finish_vo();
          level scripts\engine\utility::_id_5C1B("orb_chasing_done");
          var_7 = 0;
          level monolith_interact_reset(var_7);
        }
      }
    }
  }
}

orb_chasing_duration_watcher() {
  level endon("game_ended");
  level endon("step_six_is_done");
  level endon("orb_chasing_is_done");
  wait 50;
  level notify("orb_chasing_times_out");
  level thread orb_chasing_reset();
  var_0 = 1;
  level monolith_interact_reset(var_0);
}

orb_chasing_reset() {
  level endon("game_ended");
  level endon("step_six_is_done");
  level.n_players_completed_orb_chasing = 0;

  foreach(var_1 in level.a_s_monolith_locs) {
    if(isDefined(var_1.mdl_fx)) {
      playFX(level._effect["mq_glowing_orb_fx_hit"], var_1.mdl_fx.origin);
      _func_0130(var_1.mdl_fx);
      var_1.mdl_fx delete();
    }
  }

  wait 5;
  level thread send_monolith_trails();
}

play_monolith_orbs_chasing_vo() {
  level endon("game_ended");

  if(!level scripts\engine\utility::_id_5C00("monolith_orbs_chasing_vo_played")) {
    level scripts\engine\utility::_id_5C1B("monolith_orbs_chasing_vo_played");
    level thread _id_0720::play_narration(["zm_cpm4_mqs4_vrcn_qgfg", "zm_cpm4_mqs4_vrcn_qgfh", "zm_cpm4_mqs4_vrcn_qgfi"], 1, 0);
    level waittill("dialogue_finished");
    level thread _id_0720::play_event_vo_from_selected_players("ally_confirmation", level.players, 1);
  }
}

play_monolith_orbs_chasing_finish_vo() {
  var_0 = ["zm_cpm4_mqs4_vrcn_qgfj", "zm_cpm4_mqs4_vrcn_qgfk", "zm_cpm4_mqs4_dsrx_qgfl"];
  var_1 = ["zm_cpm4_mqs4_vrcn_qgfm", "zm_cpm4_mqs4_dsrx_qgfn"];
  var_2 = ["zm_cpm4_mqs4_vrcn_qgfo", "zm_cpm4_mqs4_dsrx_qgfp"];
  var_3 = scripts\engine\utility::random([var_0, var_1, var_2]);
  level thread _id_0720::play_narrations(var_3, 1, 0, "force_quit_current_dialogue");
}

init_step_seven_final_fight() {
  _func_01E3("boss_intro");
  set_lock_down_clips(1, level.a_mdl_stp7_door_blocks, level.a_mdl_stp7_door_block_fxs);
  level.a_s_final_fight_zombie_spawners = scripts\engine\utility::getStructArray("dig_site_final_fight", "target");
  level.a_s_final_fight_screamer_spawners = [];

  foreach(var_1 in level.a_s_final_fight_zombie_spawners) {
    if(scripts\engine\utility::is_equal(var_1._id_039B, "enemy_base_zombie_cp|enemy_zombie_screamer_cp")) {
      level.a_s_final_fight_screamer_spawners = scripts\engine\utility::array_add(level.a_s_final_fight_screamer_spawners, var_1);
    }
  }

  level.n_mirror_charge_progress = 0;
  level.n_final_fight_phase = 1;
  level.n_mirror_charge_requirement = 0;
  level.n_saraxis_invulnerable_dis_check = 0;
  scripts\engine\utility::_id_5C04("round_spawn_zombies");
  level.force_cleanup_all_zombies = 1;
  var_3 = _id_06FE::_id_6322();

  foreach(var_5 in var_3) {
    if(!istrue(var_5.b_not_kill)) {
      var_5 scripts\cp\zombies\zm_cleanup::cleanup_zombie();
    }
  }

  level notify("complete_shooting_gallery");
  level.force_cleanup_all_zombies = 0;

  if(scripts\engine\utility::_id_5C00("in_special_round")) {
    level.rbz scripts\engine\utility::_id_5474("all_killed");
    level.next_special_round = level._id_11049 + 1;
  }

  _id_06CB::_id_AA4A(::on_zombie_killed_step_seven);
  level scripts\engine\utility::_id_5C1B("in_saraxis_final_fight");
  level thread saraxis_intro();
  level thread final_fight_zombie_spawning_watcher();
  level._id_A52A = 1;
  level.a_disabled_score_event = ["stun_grenade_stunned_enemy", "stun_mine_stunned_enemy", "juggernaut_backpack_destroyed", "energy_mine_stunned_enemy"];
}

do_step_seven_final_fight() {
  level endon("game_ended");
  level waittill("mq_saraxis_is_down");
  var_0 = scripts\cp\zombies\zm_round_logic::respawn_players(level.rbz);

  if(var_0) {
    waitframe();
  }

  thread clear_sound_submix("cp_boss_fight");
  level thread _id_0720::play_narrations(["zm_cpm4_mqs4_deco_qg7f", "zm_cpm4_mqs4_dsrx_qg7g"], 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");
  _func_01E3("boss_outro");
  playsoundatpos((0, 0, 0), "zmb_boss_intro_comic_strip_beats_end");
  thread set_sound_submix("cp_comic_pages");
  scripts\cp\zombies\zm_comics_pages::play_page_sequence("cp_sumpf_boss_fight_end");
  thread clear_sound_submix("cp_comic_pages");
  level thread _id_0720::play_narration("zm_cpm4_mqs4_dsrx_qg7k", 1, 0);
  level waittill("dialogue_finished");
  level thread _id_0720::play_narrations(["zm_cpm4_mqs4_krft_qg7l", "zm_cpm4_mqs4_krft_qg7m", "zm_cpm4_mqs4_krft_qg7n"], 1, 0, "force_quit_current_dialogue");
  level.mdl_altar_mirror _meth_82CB("s4_zm_bronze_mirror_combine_01");
  wait 7;
  level.mdl_altar_mirror _meth_82CB("s4_zm_bronze_mirror_combine_idle_01");
  level.mdl_altar_mirror thread show_hide_outline();
  _id_0737::_id_C266("mq_central_altar_btn", undefined, ::on_interact_mirror);
  level._id_835D["mq_central_altar_btn"] = &"CP_SUMPF/MQ_PICK_UP_RESTORED_MIRROR";
  level waittill("mq_restored_mirror_picked_up");
  level thread give_reward_fountain();
  level thread complete_hidden_quest_challenge();
  level scripts\engine\utility::_id_5C04("in_saraxis_final_fight");
  level scripts\engine\utility::_id_5C00("finish_shino_mq");
  level waittill("step_seven_is_done");
}

cleanup_step_seven_final_fight() {
  set_lock_down_clips(0, level.a_mdl_stp7_door_blocks, level.a_mdl_stp7_door_block_fxs);
  _id_06CB::_id_C417(::on_zombie_killed_step_seven);
  scripts\engine\utility::_id_5C1B("round_spawn_zombies");
  level._id_A52A = 0;
  level.a_disabled_score_event = undefined;
  level.extend_wonder_weapon_drop_limit = 1;
}

debug_step_seven_final_fight() {
  level notify("mq_saraxis_is_down");
  _func_01E3("none");
  waitframe();
  level notify("mq_restored_mirror_picked_up");
  waitframe();
  level notify("step_seven_is_done");
}

on_zombie_killed_step_seven(var_0) {
  try_drop_ammo_in_final_fight(var_0);

  if(!level scripts\engine\utility::_id_5C00("mq_mirror_charged")) {
    if(check_zombie_is_killed_by_dg2(var_0)) {
      if(distancesquared(self.origin, level.s_mirror_loc.origin) < 250000) {
        if(istrue(self.b_is_charging_zmb)) {
          do_mirror_charging();
        }
      }
    }
  }

  if(istrue(self.b_killed_by_mirror)) {
    var_1 = self.origin - (level.s_mirror_loc.origin + (0, 0, -30));
    var_2 = var_1 * 50;

    if(scripts\engine\utility::is_equal(self._id_110B0, "juggernaut")) {
      self._id_4C08 = 1;
    }

    self._id_BF53 = var_2;
    self._id_BF52 = "torso_lower";
  }

  if(istrue(self.b_is_final_boss)) {
    level.b_mq_stop_spawn_max_ammo_after_wave = 1;
    level notify("mq_saraxis_is_down");
    _func_01E3("none");
    set_mirror_state(0);

    if(isDefined(level.ai_saraxis_echo.mdl_stun_fx)) {
      _func_0130(level.ai_saraxis_echo.mdl_stun_fx);
      level.ai_saraxis_echo.mdl_stun_fx delete();
    }
  }
}

try_drop_ammo_in_final_fight(var_0) {
  if(istrue(self.b_killed_by_mirror) || istrue(self.b_is_final_boss)) {
    return;
  }
  var_1 = 1;

  if(isDefined(level.check_in_playable_area_func)) {
    var_1 = [[level.check_in_playable_area_func]](self);
  }

  if(!isPlayer(var_0._id_50FF) || !istrue(var_1)) {
    return;
  }
  var_2 = randomfloat(100);

  if(scripts\engine\utility::is_equal(self._id_1210, "actor_enemy_zombie_juggernaut_cp")) {
    if(var_2 < 10) {
      var_3 = 0;

      for(var_4 = 0; var_4 < 3; var_4++) {
        [var_6, var_7, var_8] = _id_073D::_id_6531(var_3, self.origin, self.angles);
        _id_092E::_id_E178("cploot_ammo", var_6, var_7, var_8);
        var_3++;
      }
    }
  } else if(var_2 < 2.5) {
    var_3 = 0;
    [var_6, var_7, var_8] = _id_073D::_id_6531(var_3, self.origin, self.angles);
    _id_092E::_id_E178("cploot_ammo", var_6, var_7, var_8);
  }
}

do_mirror_charging() {
  level thread send_fx_trail(self.origin + (0, 0, 30), level.s_mirror_loc.origin, "mq_zombie_stele_charge_trail", 600);
  level.n_mirror_charge_progress++;

  if(level.n_mirror_charge_progress >= level.n_mirror_charge_requirement) {
    level.n_mirror_charge_progress = 0;
    level set_mirror_state(1);
  }
}

saraxis_intro() {
  level endon("game_ended");
  level endon("step_seven_is_done");
  wait 5;
  var_0 = scripts\engine\utility::getstruct("mq_saraxis_echo_spawn_loc", "script_noteworthy");
  level thread scripts\cp\maps\cp_sumpf\cp_sumpf_wwq::fadetowhite(0.3);
  level.sara_echo = _func_03C5("shinomq_saraxis_echo", var_0.origin, var_0.angles);
  level.sara_echo ff_saraxis_echo_vignette_watcher();
  level.ai_saraxis_echo = _id_09A4::_id_110AD("enemy_zombie_trickster_cp", var_0.origin, var_0.angles, var_0);
  level.ai_saraxis_echo setModel("c_s4_zmb_demon_deceiver_saraxis");
  level.ai_saraxis_echo.b_is_final_boss = 1;
  level.ai_saraxis_echo.b_ignore_cleanup = 1;
  level.ai_saraxis_echo.immune_brimstone = 1;
  level.ai_saraxis_echo set_saraxis_fx();
  level.ai_saraxis_echo.on_zombie_killed_score_override_func = ::on_zombie_killed_mq_give_score;
  waitframe();

  if(isDefined(level._effect["zmb_ai_teleport_spawn_in"])) {
    playFX(level._effect["zmb_ai_teleport_spawn_in"], level.ai_saraxis_echo.origin + (0, 0, 52));
    playsoundatpos(level.ai_saraxis_echo.origin, "zmb_boss_seraxis_appear");
  }

  level.ai_saraxis_echo scripts\aitypes\zombie_common\awareness::set_unaware();
  level.ai_saraxis_echo.maxhealth = 150000;
  level.ai_saraxis_echo.health = 150000;
  waitframe();
  level.ai_saraxis_echo.extra_mask_health = get_mask_health();
  level.ai_saraxis_echo._id_8530 = level.ai_saraxis_echo.maxhealth * 0.7;
  level.ai_saraxis_echo thread saraxis_invulnerable_check();
  level.ai_saraxis_echo thread saraxis_mask_break_watcher();
  level thread play_saraxis_echo_intro_vo_one();

  if(isDefined(level.ai_saraxis_echo.try_do_scripted_anim)) {
    level.ai_saraxis_echo[[level.ai_saraxis_echo.try_do_scripted_anim]]("animscripted", "special_intro_01");
    level.ai_saraxis_echo waittill("AnimscriptMP_Complete");
  }

  level.ai_saraxis_echo thread wait_for_images_played();
  playsoundatpos((0, 0, 0), "zmb_boss_intro_comic_strip_beats");
  thread set_sound_submix("cp_comic_pages");
  scripts\cp\zombies\zm_comics_pages::play_page_sequence("cp_sumpf_boss_fight_start");
  thread clear_sound_submix("cp_comic_pages");
  level notify("image_finished");
  play_saraxis_echo_intro_vo_two();
  level.ai_saraxis_echo scripts\aitypes\zombie_common\awareness::set_aware();
  level thread play_final_fight_kickoff_vo();
  level thread saraxis_echo_sound_watcher();
  level scripts\engine\utility::_id_5C1B("mq_in_final_fight_phase_one");
  thread set_sound_submix("cp_boss_fight");
}

set_saraxis_fx() {
  self.eruption_explode_fxs = [];
  self.eruption_explode_fxs[0] = loadfx("vfx/s4/zombie_ai/vfx_zai_saraxis_exp_sm.vfx");
  self.eruption_explode_fxs[1] = loadfx("vfx/s4/zombie_ai/vfx_zai_saraxis_exp_md.vfx");
  self.eruption_explode_fxs[2] = loadfx("vfx/s4/zombie_ai/vfx_zai_saraxis_exp_lg.vfx");
  self.eruption_launch = loadfx("vfx/s4/zombie_ai/vfx_zai_saraxis_tell_launch.vfx");
  self.eruption_marker_loop = loadfx("vfx/s4/zombie_ai/vfx_zai_saraxis_tell_marker_loop.vfx");
  self.eruption_knockdown_fx = loadfx("vfx/s4/zombie_ai/vfx_zai_saraxis_zombie_downed.vfx");
  self.ground_teleport_in_fx = loadfx("vfx/s4/zombie_ai/vfx_zai_saraxis_spawn_in.vfx");
  self.ground_teleport_out_fx = loadfx("vfx/s4/zombie_ai/vfx_zai_saraxis_spawn_out.vfx");
  self.damage_mask_impact_fx = loadfx("vfx/s4/zombie_ai/vfx_zai_trickster_mask_hit_damage.vfx");
  self.damage_fail_impact_fx = loadfx("vfx/s4/zombie_ai/vfx_zai_trickster_hit_no_damage.vfx");
  self.break_mask_spin_fx = loadfx("vfx/s4/zombie_ai/vfx_zai_trickster_mask_spin_rnr.vfx");
  self.death_explosion_fx = loadfx("vfx/s4/zombie_ai/vfx_zai_saraxis_death_exp.vfx");
  self.energy_mine_hit_fx = loadfx("vfx/s4/zombie_ai/vfx_zai_trickster_mask_counteract.vfx");
}

wait_for_images_played() {
  level endon("game_ended");
  self _meth_84BC(2, self.origin);
  level waittill("page_sequence_done");
  wait 0.2;

  if(isalive(self)) {
    self _meth_84C0(2);
    self[[self.try_do_scripted_anim]]("animscripted", "special_intro_04");
    self waittill("AnimscriptMP_Complete");
    self _meth_8474();
  }
}

ff_saraxis_echo_vignette_watcher() {
  level endon("game_ended");
  level endon("step_seven_is_done");

  if(isDefined(self)) {
    playsoundatpos(self.origin, "zmb_echo_orb_spawn");
    playsoundatpos(self.origin, "zmb_echo_orb_transition_riser");
    wait 2;
  }

  var_0 = undefined;

  if(isDefined(self)) {
    playsoundatpos(self.origin, "zm_cpm4_mqs4_deco_qgg0");
    var_0 = spawn("script_model", self.origin);
    var_0 setModel("tag_origin");
    var_0.angles = self.angles;
    waitframe();
    self setscriptablepartstate("saraxis_echo", "idle_base");
    var_0 playLoopSound("zmb_echo_orb_lp");
  }

  wait 2;

  if(isDefined(self)) {
    var_0 changeechoballsoundstate(1);
    self setscriptablepartstate("saraxis_echo", "angry_base");
  }

  wait 2;

  if(isDefined(self)) {
    var_0 changeechoballsoundstate(0);
    self setscriptablepartstate("saraxis_echo", "calm_base");
  }

  wait 2;

  if(isDefined(self)) {
    self setscriptablepartstate("saraxis_echo", "fade_out");
    var_0 stoploopsound();
    playsoundatpos(self.origin, "zmb_echo_orb_leave");
  }

  wait 1;

  if(isDefined(self)) {
    var_0 delete();
    self _meth_86BE();
  }
}

final_fight_zombie_spawning_watcher() {
  level endon("game_ended");
  var_0 = level.players.size;
  var_1 = [3, 3, 3, 3];
  var_2 = [3, 3, 3, 3];
  var_3 = [2, 2, 2, 2];
  var_4 = [8, 8, 8, 8];
  var_5 = [6, 6, 6, 6];
  var_6 = [4, 4, 4, 4];
  var_7 = [30, 30, 30, 30];
  var_8 = [20, 20, 20, 20];
  var_9 = [10, 10, 10, 10];
  var_10 = [8, 12, 16, 20];
  var_11 = [6, 10, 14, 18];
  var_12 = [8, 12, 16, 20];
  var_13 = [2, 3, 4, 5];
  var_14 = [4, 5, 6, 7];
  var_15 = [2, 3, 4, 5];
  var_16 = [1, 2, 3, 3];
  var_17 = [1, 2, 3, 3];
  var_18 = [2, 2, 3, 4];
  level waittill("mq_in_final_fight_phase_one");
  level.n_saraxis_invulnerable_dis_check = 500;
  level.n_mirror_charge_requirement = get_mirror_charge_requirment(1);
  level thread spawn_zombie_in_final_fight("base", "enemy_base_zombie_sumpf_cp", var_1[var_0 - 1], var_10[var_0 - 1], "mq_in_final_fight_phase_two");
  level thread spawn_zombie_in_final_fight("screamer", "enemy_zombie_screamer_cp", var_4[var_0 - 1], var_13[var_0 - 1], "mq_in_final_fight_phase_two");
  level thread spawn_zombie_in_final_fight("juggernaut", "enemy_zombie_juggernaut_cp", var_7[var_0 - 1], var_16[var_0 - 1], "mq_in_final_fight_phase_two");
  level waittill("mq_in_final_fight_phase_two");
  level.n_saraxis_invulnerable_dis_check = 400;
  level.n_mirror_charge_requirement = get_mirror_charge_requirment(2);
  level thread spawn_zombie_in_final_fight("base", "enemy_base_zombie_sumpf_cp", var_2[var_0 - 1], var_11[var_0 - 1], "mq_in_final_fight_phase_three");
  level thread spawn_zombie_in_final_fight("screamer", "enemy_zombie_screamer_cp", var_5[var_0 - 1], var_14[var_0 - 1], "mq_in_final_fight_phase_three");
  level thread spawn_zombie_in_final_fight("juggernaut", "enemy_zombie_juggernaut_cp", var_8[var_0 - 1], var_17[var_0 - 1], "mq_in_final_fight_phase_three");
  level waittill("mq_in_final_fight_phase_three");
  level.n_saraxis_invulnerable_dis_check = 350;
  level.n_mirror_charge_requirement = get_mirror_charge_requirment(3);
  level thread spawn_zombie_in_final_fight("base", "enemy_base_zombie_sumpf_cp", var_3[var_0 - 1], var_12[var_0 - 1], "mq_saraxis_is_down");
  level thread spawn_zombie_in_final_fight("screamer", "enemy_zombie_screamer_cp", var_6[var_0 - 1], var_15[var_0 - 1], "mq_saraxis_is_down");
  level thread spawn_zombie_in_final_fight("juggernaut", "enemy_zombie_juggernaut_cp", var_9[var_0 - 1], var_18[var_0 - 1], "mq_saraxis_is_down");
}

spawn_zombie_in_final_fight(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  level endon(var_4);

  for(;;) {
    if(!scripts\engine\utility::_id_5C00("pause_ff_zombie_spawning")) {
      if(isDefined(var_3) && get_alive_zombies_count(var_0) < var_3) {
        if(scripts\engine\utility::is_equal(var_0, "screamer")) {
          var_5 = pick_random_spawner(level.a_s_final_fight_screamer_spawners);
        } else {
          var_5 = pick_random_spawner(level.a_s_final_fight_zombie_spawners);
        }

        var_6 = _id_09A4::_id_110AD(var_1, var_5.origin, var_5.angles, var_5);
        var_6.b_ignore_cleanup = 1;
        wait 0.5;

        if(isDefined(var_6) && isalive(var_6)) {
          var_6.brain_rot_immune = 1;
          var_6._id_4A75 = 1;
          var_6.on_zombie_killed_score_override_func = ::on_zombie_killed_mq_give_score;

          if(scripts\engine\utility::is_equal(var_0, "base") && level._id_11049 < 20) {
            if(isDefined(var_6._id_D603)) {
              var_6[[var_6._id_D603]]("sprint");
            }

            var_6.maxhealth = 2000;
            var_6.health = 2000;
          }

          if(level scripts\engine\utility::_id_5C00("mq_in_final_fight_phase_one") && scripts\engine\utility::is_equal(var_0, "base") && !level scripts\engine\utility::_id_5C00("mq_mirror_charged") && !level scripts\engine\utility::_id_5C00("mq_final_fight_boss_is_hidden")) {
            if(spawn_charge_zombie_check()) {
              var_6 set_charge_fx();
              var_6.b_is_charging_zmb = 1;
            }
          }

          if(level scripts\engine\utility::_id_5C00("mq_in_final_fight_phase_two") && scripts\engine\utility::is_equal(var_0, "screamer") && !level scripts\engine\utility::_id_5C00("mq_mirror_charged") && !level scripts\engine\utility::_id_5C00("mq_final_fight_boss_is_hidden")) {
            if(spawn_charge_zombie_check()) {
              var_6 set_charge_fx();
              var_6.b_is_charging_zmb = 1;
            }
          }

          if(level scripts\engine\utility::_id_5C00("mq_in_final_fight_phase_three") && scripts\engine\utility::is_equal(var_0, "juggernaut") && !level scripts\engine\utility::_id_5C00("mq_mirror_charged") && !level scripts\engine\utility::_id_5C00("mq_final_fight_boss_is_hidden")) {
            if(spawn_charge_zombie_check()) {
              var_6 set_charge_fx();
              var_6.b_is_charging_zmb = 1;
            }
          }
        }
      }
    }

    wait(var_2);
  }
}

spawn_charge_zombie_check() {
  var_0 = 0;

  if(level scripts\engine\utility::_id_5C00("mq_in_final_fight_phase_one")) {
    var_0 = 70;
  }

  if(level scripts\engine\utility::_id_5C00("mq_in_final_fight_phase_two")) {
    var_0 = 80;
  }

  if(level scripts\engine\utility::_id_5C00("mq_in_final_fight_phase_three")) {
    var_0 = 100;
  }

  var_1 = randomint(100);

  if(var_1 < var_0) {
    return 1;
  } else {
    return 0;
  }
}

get_mirror_charge_requirment(var_0) {
  switch (var_0) {
    case 1:
      switch (level.players.size) {
        case 1:
          return 8;
        case 2:
          return 10;
        case 3:
          return 12;
        case 4:
          return 14;
      }

      break;
    case 2:
      switch (level.players.size) {
        case 1:
          return 7;
        case 2:
          return 8;
        case 3:
          return 10;
        case 4:
          return 11;
      }

      break;
    case 3:
      switch (level.players.size) {
        case 1:
          return 5;
        case 2:
          return 6;
        case 3:
          return 7;
        case 4:
          return 8;
      }

      break;
    default:
      switch (level.players.size) {
        case 1:
          return 8;
        case 2:
          return 10;
        case 3:
          return 12;
        case 4:
          return 14;
      }

      break;
  }
}

set_charge_fx() {
  playFXOnTag(level._effect["mq_stele_charge_zombie_fx"], self, "j_spine4");
  thread zombie_charge_fx_watcher();
}

zombie_charge_fx_watcher() {
  level endon("game_ended");
  self endon("death");
  level endon("step_seven_is_done");
  level waittill("mq_mirror_charged");

  if(isalive(self)) {
    _func_012F(level._effect["mq_stele_charge_zombie_fx"], self, "j_spine4");
  }
}

pick_random_spawner(var_0) {
  var_1 = randomint(var_0.size);
  var_2 = var_0[var_1];
  return var_2;
}

set_mirror_state(var_0) {
  level.s_mirror_loc thread set_mirror_fx(var_0);

  if(istrue(var_0)) {
    level scripts\engine\utility::_id_5C1B("mq_mirror_charged");
    level thread play_mirror_charged_vo();
  } else {
    level scripts\engine\utility::_id_5C04("mq_mirror_charged");
    mirror_charge_kill_zombies();
  }
}

set_mirror_fx(var_0) {
  level endon("game_ended");
  level endon("step_seven_is_done");

  if(istrue(var_0)) {
    if(!isDefined(self.mdl_mirror_fx)) {
      self.mdl_mirror_fx = scripts\cp\utility::_id_E190("tag_origin", self.origin, self.angles);
    }

    _func_012F(level._effect["mq_mirror_ambient_uncharged_fx"], self.mdl_mirror_fx, "tag_origin");
    playFXOnTag(level._effect["mq_mirror_ambient_charged_fx"], self.mdl_mirror_fx, "tag_origin");

    if(!isDefined(self.mdl_altar_fx)) {
      self.mdl_altar_fx = scripts\cp\utility::_id_E190("tag_origin", self.origin + (0, 0, -60), self.angles);
    }

    if(level scripts\engine\utility::_id_5C00("mq_in_final_fight_phase_one")) {
      playFXOnTag(level._effect["mq_mirror_dome_hold_lrg"], self.mdl_altar_fx, "tag_origin");
    } else if(level scripts\engine\utility::_id_5C00("mq_in_final_fight_phase_two")) {
      playFXOnTag(level._effect["mq_mirror_dome_hold_med"], self.mdl_altar_fx, "tag_origin");
    } else if(level scripts\engine\utility::_id_5C00("mq_in_final_fight_phase_three")) {
      playFXOnTag(level._effect["mq_mirror_dome_hold_sml"], self.mdl_altar_fx, "tag_origin");
    }
  } else {
    if(isDefined(self.mdl_altar_fx)) {
      playFX(level._effect["mq_mirror_dome_hold_explosion"], self.mdl_altar_fx.origin);
    }

    waitframe();
    var_1 = scripts\engine\utility::getstruct("mq_altar_mirror_loc", "script_noteworthy");

    if(isDefined(var_1)) {
      if(!istrue(level.b_mq_stop_spawn_max_ammo_after_wave)) {
        _id_0990::_id_E3DD("full_ammo", var_1.origin + (0, 60, -50));
      }

      if(istrue(level.b_will_give_awards_after_mq_wave)) {
        _id_0990::_id_E3DD("bonus_points_team", var_1.origin + (60, 0, -50));
        _id_0990::_id_E3DD("bonus_points_team", var_1.origin + (-60, 0, -50));
        _id_0990::_id_E3DD("armor_repair", var_1.origin + (0, -60, -50));
        level.b_will_give_awards_after_mq_wave = 0;
      }
    }

    if(isDefined(self.mdl_altar_fx)) {
      _func_0130(self.mdl_altar_fx);
    }

    if(isDefined(self.mdl_mirror_fx)) {
      _func_012F(level._effect["mq_mirror_ambient_charged_fx"], self.mdl_mirror_fx, "tag_origin");
      playFXOnTag(level._effect["mq_mirror_ambient_uncharged_fx"], self.mdl_mirror_fx, "tag_origin");
    }
  }
}

saraxis_invulnerable_check() {
  level endon("game_ended");
  level endon("step_seven_is_done");
  self endon("death");

  for(;;) {
    if(level scripts\engine\utility::_id_5C00("mq_mirror_charged")) {
      if(distance(self.origin, level.s_mirror_loc.origin) < level.n_saraxis_invulnerable_dis_check) {
        self.b_invulnerable = 0;
      } else {
        self.b_invulnerable = 1;
      }
    } else
      self.b_invulnerable = 1;

    waitframe();
  }
}

saraxis_mask_break_watcher() {
  level endon("game_ended");
  level endon("step_seven_is_done");
  self endon("death");
  level endon("mq_saraxis_is_down");

  for(;;) {
    self waittill("break_extra_mask");
    level.s_mirror_loc thread send_electricity_ball_to_sara();

    if(!scripts\engine\utility::_id_5C00("mq_in_final_fight_phase_three")) {
      self setscriptablepartstate("mask", scripts\aitypes\zombie_trickster\trickster::getmaskscriptablestatename(self.mask_num - 1));
      self.mask_num--;
    }

    if(isDefined(level.n_final_fight_phase)) {
      switch (level.n_final_fight_phase) {
        case 1:
          level thread _id_0720::play_narration(["zm_cpm4_mqs4_vrcn_qggl", "zm_cpm4_mqs4_vrcn_qggm", "zm_cpm4_mqs4_vrcn_qggn"], 1, 0);
          break;
        case 2:
          level thread _id_0720::play_narration(["zm_cpm4_mqs4_krtx_qggx", "zm_cpm4_mqs4_krtx_qggy", "zm_cpm4_mqs4_krtx_qggz"], 1, 0);
          break;
        default:
          break;
      }
    }

    if(isDefined(self.try_do_scripted_anim)) {
      level scripts\engine\utility::_id_5C1B("saraxis_echo_stunned");
      level thread saraxis_echo_damage_watcher(self);
      self[[self.try_do_scripted_anim]]("animscripted", "special_stun_in");
      self waittill("AnimscriptMP_Complete");
      self[[self.try_do_scripted_anim]]("animscripted", "special_stun_loop", 1);
      wait 5;
      self notify("CancelAnimscriptMP");

      if(isDefined(level.ai_saraxis_echo.mdl_stun_fx)) {
        _func_0130(level.ai_saraxis_echo.mdl_stun_fx);
        level.ai_saraxis_echo.mdl_stun_fx delete();
      }

      self[[self.try_do_scripted_anim]]("animscripted", "special_stun_out");
      self waittill("AnimscriptMP_Complete");
      self notify("CancelAnimscriptMP");
      level scripts\engine\utility::_id_5C04("saraxis_echo_stunned");
      thread saraxis_hide();
      scripts\engine\utility::_id_5C1B("pause_ff_zombie_spawning");
      wait 3;
      set_mirror_state(0);
    }
  }
}

send_electricity_ball_to_sara() {
  level endon("game_ended");
  level endon("step_seven_is_done");
  level.ai_saraxis_echo endon("death");
  playFX(level._effect["mq_mirror_atk_glow"], self.origin);
  var_0 = scripts\cp\utility::_id_E190("tag_origin", self.origin);
  waitframe();
  playFXOnTag(level._effect["mq_mirror_atk"], var_0, "tag_origin");
  var_1 = distance(var_0.origin, level.ai_saraxis_echo gettagorigin("j_spine4")) / 600;
  var_0 moveto(level.ai_saraxis_echo gettagorigin("j_spine4"), var_1, 0, 0);
  var_0 waittill("movedone");
  playFX(level._effect["mq_mirror_atk_exp"], var_0.origin);
  waitframe();
  var_0 delete();

  if(!isDefined(level.ai_saraxis_echo.mdl_stun_fx) && isDefined(level.ai_saraxis_echo) && isalive(level.ai_saraxis_echo) && level.ai_saraxis_echo tagexists("j_spine4")) {
    level.ai_saraxis_echo.mdl_stun_fx = scripts\cp\utility::_id_E190("tag_origin", level.ai_saraxis_echo gettagorigin("j_spine4"));
    playFXOnTag(level._effect["mq_mirror_atk_lp"], level.ai_saraxis_echo.mdl_stun_fx, "tag_origin");
  }
}

saraxis_echo_damage_watcher(var_0) {
  level endon("game_ended");

  while(level scripts\engine\utility::_id_5C00("saraxis_echo_stunned")) {
    if(isDefined(var_0) && isDefined(var_0._id_8530) && var_0.health <= var_0._id_8530) {
      var_1 = scripts\engine\utility::random(["zm_cpm4_mqs4_deco_qggo", "zm_cpm4_mqs4_deco_qggp", "zm_cpm4_mqs4_deco_qggq", "zm_cpm4_mqs4_deco_qggr"]);
      playsoundatpos(var_0.origin, var_1);
      return;
    }

    wait 1;
  }
}

saraxis_hide() {
  level endon("game_ended");
  level endon("step_seven_is_done");
  self endon("death");
  level notify("saraxis_start_to_hide");
  self.origin = self.origin - (0, 0, 100);
  self[[level.ai_saraxis_echo.try_do_scripted_anim]]("animscripted", "special_stun_loop", 1);
  self hide();
  level scripts\engine\utility::_id_5C1B("mq_final_fight_boss_is_hidden");
  var_0 = 10;

  if(isDefined(level.n_final_fight_phase) && isDefined(self._id_8530) && self.health <= self._id_8530) {
    level.b_will_give_awards_after_mq_wave = 1;

    switch (level.n_final_fight_phase) {
      case 1:
        var_1 = [3, 3, 3, 3];
        var_2 = [8, 12, 16, 20];
        var_3 = level.players.size;
        level thread spawn_enemies_while_revealation(var_1[var_3 - 1], var_2[var_3 - 1]);
        level thread _id_0720::play_narrations(["zm_cpm4_mqs4_deco_qggs", "zm_cpm4_mqs4_deco_qggt", "zm_cpm4_mqs4_deco_qggu", "zm_cpm4_mqs4_dsrx_qggv", "zm_cpm4_mqs4_vrcn_qggw"], 1, 0, "force_quit_current_dialogue");
        level.disable_incoming_powerup_vo = 1;
        level waittill("dialogue_finished");
        level.disable_incoming_powerup_vo = 0;
        level notify("saraxis_revealation_finished");
        var_0 = 0;
        break;
      case 2:
        var_4 = [3, 3, 3, 3];
        var_5 = [6, 10, 14, 18];
        var_3 = level.players.size;
        level thread spawn_enemies_while_revealation(var_4[var_3 - 1], var_5[var_3 - 1]);
        level thread _id_0720::play_narrations(["zm_cpm4_mqs4_deco_qg7a", "zm_cpm4_mqs4_deco_qg7b", "zm_cpm4_mqs4_deco_qg7c", "zm_cpm4_mqs4_dsrx_qg7d", "zm_cpm4_mqs4_vlst_qg7e"], 1, 0, "force_quit_current_dialogue");
        level.disable_incoming_powerup_vo = 1;
        level waittill("dialogue_finished");
        level.disable_incoming_powerup_vo = 0;
        level notify("saraxis_revealation_finished");
        var_0 = 0;
        break;
      default:
        break;
    }
  }

  wait(var_0);
  level scripts\engine\utility::_id_5C04("mq_final_fight_boss_is_hidden");
  self show();
  self.origin = self.origin + (0, 0, 100);
  _id_0AED::_id_3158();
  self _meth_8474();
  scripts\engine\utility::_id_5C04("pause_ff_zombie_spawning");
  try_to_restore_saraxis_mask(level.n_final_fight_phase);
}

spawn_enemies_while_revealation(var_0, var_1) {
  level endon("game_ended");
  level endon("saraxis_revealation_finished");
  wait 10;

  if(!isDefined(var_0)) {
    var_0 = 4;
  }

  if(!isDefined(var_1)) {
    var_1 = 7;
  }

  for(;;) {
    if(get_alive_zombies_count("base") < var_1) {
      var_2 = pick_random_spawner(level.a_s_final_fight_zombie_spawners);
      var_3 = _id_09A4::_id_110AD("enemy_base_zombie_sumpf_cp", var_2.origin, var_2.angles, var_2);
      var_3.b_ignore_cleanup = 1;
      waitframe();

      if(isDefined(var_3) && isalive(var_3)) {
        var_3._id_4A75 = 1;
        var_3.on_zombie_killed_score_override_func = ::on_zombie_killed_mq_give_score;

        if(level._id_11049 < 20) {
          var_3.maxhealth = 2000;
          var_3.health = 2000;
          wait 0.5;

          if(isalive(var_3) && isDefined(var_3._id_D603)) {
            var_3[[var_3._id_D603]]("sprint");
          }
        }
      }
    }

    wait(var_0);
  }
}

try_to_restore_saraxis_mask(var_0) {
  switch (var_0) {
    case 1:
      check_saraxis_health(1, 0.4, "mq_in_final_fight_phase_two", "mq_in_final_fight_phase_one");
      break;
    case 2:
      check_saraxis_health(0.7, 0, "mq_in_final_fight_phase_three", "mq_in_final_fight_phase_two");
      break;
    case 3:
      check_saraxis_health(0.4, undefined, undefined, "mq_in_final_fight_phase_three");
      break;
    default:
      break;
  }
}

check_saraxis_health(var_0, var_1, var_2, var_3) {
  if(self.health > self._id_8530) {
    if(self.mask_num < 3) {
      level thread _id_0720::play_narration(["zm_cpm4_mqs4_deco_qg71", "zm_cpm4_mqs4_deco_qg72", "zm_cpm4_mqs4_deco_qg73", "zm_cpm4_mqs4_deco_qg74", "zm_cpm4_mqs4_deco_qg75", "zm_cpm4_mqs4_deco_qg76", "zm_cpm4_mqs4_deco_qg77", "zm_cpm4_mqs4_deco_qg78"], 1, 0);
      sara_restore_mask();
    }

    if(isDefined(level.final_fight_fail_same_phase_counter)) {
      level.final_fight_fail_same_phase_counter++;
    } else {
      level.final_fight_fail_same_phase_counter = 1;
    }

    if(level.final_fight_fail_same_phase_counter >= 2) {
      var_4 = int(self._id_8530 + (self.maxhealth * var_0 - self._id_8530) * 0.045);

      if(var_4 > 0) {
        self.health = var_4;
      }
    } else
      self.health = int(self.maxhealth * var_0);
  } else {
    level.final_fight_fail_same_phase_counter = 0;
    level.n_final_fight_phase++;
    level scripts\engine\utility::_id_5C1B(var_2);
    level scripts\engine\utility::_id_5C04(var_3);
    self._id_8530 = self.maxhealth * var_1;
  }

  self.extra_mask_health = get_mask_health();
}

sara_restore_mask() {
  level endon("game_ended");
  level endon("step_seven_is_done");
  self notify("CancelAnimscriptMP");
  self[[self.try_do_scripted_anim]]("animscripted", "restore_mask_in");
  self waittill("AnimscriptMP_Complete");
  self notify("CancelAnimscriptMP");
  self[[self.try_do_scripted_anim]]("animscripted", "restore_mask_loop", 1);
  playFXOnTag(level._effect["mq_sara_fix_mask_fx_01"], self, "j_wrist_ri");
  playFXOnTag(level._effect["mq_sara_fix_mask_fx_02"], self, "tag_helmetlight");
  wait 5;
  self notify("CancelAnimscriptMP");
  stopFXOnTag(level._effect["mq_sara_fix_mask_fx_01"], self, "j_wrist_ri");
  stopFXOnTag(level._effect["mq_sara_fix_mask_fx_02"], self, "tag_helmetlight");

  if(!scripts\engine\utility::_id_5C00("mq_in_final_fight_phase_three")) {
    self setscriptablepartstate("mask", scripts\aitypes\zombie_trickster\trickster::getmaskscriptablestatename(self.mask_num + 1));
    self.mask_num++;
  }

  self[[self.try_do_scripted_anim]]("animscripted", "restore_mask_out");
  self waittill("AnimscriptMP_Complete");
  self notify("CancelAnimscriptMP");
  _id_0AED::_id_3158();
  self _meth_8474();
}

get_mask_health() {
  switch (level.players.size) {
    case 1:
      return 2500;
    case 2:
      return 5000;
    case 3:
      return 7500;
    case 4:
      return 10000;
  }
}

mirror_trail_lifetime_watcher_hide() {
  self endon("death");
  level endon("game_ended");
  level waittill("saraxis_start_to_hide");

  if(isDefined(self)) {
    _func_0130(self);
    self delete();
  }
}

mirror_trail_lifetime_watcher_down() {
  self endon("death");
  level endon("game_ended");
  level waittill("mq_saraxis_is_down");

  if(isDefined(self)) {
    _func_0130(self);
    self delete();
  }
}

on_interact_mirror(var_0, var_1) {
  var_1 _meth_827A("cp_zm_s2_mq_shield_rumble", var_1.origin);
  level.mdl_altar_mirror delete();
  level notify("mq_restored_mirror_picked_up");
  _id_0737::_id_C4AB("mq_central_altar_btn");
  _func_0130(level.s_mirror_loc.mdl_mirror_fx);
  level.s_mirror_loc.mdl_mirror_fx delete();
}

complete_hidden_quest_challenge() {
  level endon("game_ended");

  foreach(var_1 in level.players) {
    if(isPlayer(var_1)) {
      var_1 thread _id_070F::createfinishquestevent(var_1);
    }
  }
}

give_reward_fountain() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::getstruct("mq_altar_mirror_loc", "script_noteworthy");

  if(isDefined(var_0)) {
    var_1 = _id_0990::_id_E3DD("full_ammo", var_0.origin + (0, 60, -50));
  }

  wait 2;
  drop_final_loot(level.s_mirror_loc);
  wait 1;
  drop_final_loot(level.s_mirror_loc);
  wait 1;
  drop_final_loot(level.s_mirror_loc);
  var_2 = scripts\engine\utility::getstruct("mq_final_reward_dg2_loc", "script_noteworthy");
  var_3 = scripts\cp\cp_weapon::buildweapon("s4_pi_raygun_mp");
  _id_092E::_id_E24D(var_3, var_2.origin, var_2.angles, undefined);
  level notify("step_seven_is_done");
}

drop_final_loot(var_0) {
  var_1 = scripts\cp\utility::_id_E190("tag_origin", var_0.origin);
  var_2 = level.cache_drop_table_names["syphoncore"];

  if(!isDefined(var_2)) {
    return undefined;
  }

  var_3 = _id_073D::get_highest_round_loot_table(var_2, scripts\cp\utility::_id_6871());

  if(isDefined(var_1)) {
    playFX(level._effect["mq_final_loot_fx"], var_1.origin);
    _id_073D::select_and_spawn_items_from_table(var_3, var_1.origin + (0, 0, 48), var_1.angles, undefined, "syphoncore", 20, undefined, 0.2, "zmb_spawn_portal", var_1);
  }
}

mirror_charge_kill_zombies() {
  var_0 = _id_06FE::_id_6322();

  foreach(var_2 in var_0) {
    if(!scripts\engine\utility::is_equal(var_2._id_110B0, "trickster")) {
      var_2.b_killed_by_mirror = 1;
      var_2 _meth_81FA();
    }
  }
}

on_zombie_killed_mq_give_score(var_0) {
  if(istrue(self.b_is_final_boss)) {
    return;
  }
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

play_final_fight_kickoff_vo() {
  level endon("game_ended");
  level thread _id_0720::play_narrations(["zm_cpm4_mqs4_krft_qggh", "zm_cpm4_mqs4_vrcn_qggi", "zm_cpm4_mqs4_vrcn_qggj"], 1, 0, "force_quit_current_dialogue");
}

play_mirror_charged_vo() {
  if(!level scripts\engine\utility::_id_5C00("mirror_charged_vo_played")) {
    level scripts\engine\utility::_id_5C1B("mirror_charged_vo_played");
    level thread _id_0720::play_narration("zm_cpm4_mqs4_vrcn_qggk", 1, 0);
  }
}

play_saraxis_echo_intro_vo_one() {
  level endon("game_ended");
  wait 0.5;

  if(isDefined(level.ai_saraxis_echo)) {
    level.ai_saraxis_echo play_sound_and_wait("zm_cpm4_mqs4_deco_qgga");
  }

  level thread _id_0720::play_narrations(["zm_cpm4_mqs4_dsrx_qggb", "zm_cpm4_mqs4_dsrx_qggc"], 1, 0, "force_quit_current_dialogue");
}

play_saraxis_echo_intro_vo_two() {
  level endon("game_ended");
  level thread play_boss_fight_music();
  level thread _id_0720::play_narration("zm_cpm4_mqs4_dsrx_qggf", 1, 0);
  level waittill("dialogue_finished");

  if(isDefined(level.ai_saraxis_echo)) {
    level.ai_saraxis_echo play_sound_and_wait("zm_cpm4_mqs4_deco_qggg");
  }
}

play_boss_fight_music() {
  level endon("game_ended");
  wait 6;
  _func_01E3("boss_fight");
}

saraxis_echo_sound_watcher() {
  level endon("game_ended");
  level endon("mq_saraxis_is_down");
  wait 30;

  for(;;) {
    if(!istrue(level._id_493C) && isDefined(level.ai_saraxis_echo) && !level scripts\engine\utility::_id_5C00("mq_final_fight_boss_is_hidden") && !level scripts\engine\utility::_id_5C00("saraxis_echo_stunned")) {
      var_0 = scripts\engine\utility::random(["zm_cpm4_mqs4_deco_qgg1", "zm_cpm4_mqs4_deco_qgg2", "zm_cpm4_mqs4_deco_qgg3", "zm_cpm4_mqs4_deco_qgg4", "zm_cpm4_mqs4_deco_qgg5", "zm_cpm4_mqs4_deco_qgg6", "zm_cpm4_mqs4_deco_qgg7", "zm_cpm4_mqs4_deco_qgg8"]);
      playsoundatpos(level.ai_saraxis_echo.origin, var_0);
      wait 60;
      continue;
    }

    wait 1;
  }
}

set_sound_submix(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2)) {
      var_2 _meth_867F(var_0);
    }
  }
}

clear_sound_submix(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2)) {
      var_2 _meth_8680(var_0);
    }
  }
}

check_team_has_dg_2() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1)) {
      foreach(var_3 in var_1.weaponlist) {
        if(scripts\engine\utility::is_equal(var_3.basename, "s4_ar_tgun_mp")) {
          return 1;
        }
      }
    }
  }

  return 0;
}