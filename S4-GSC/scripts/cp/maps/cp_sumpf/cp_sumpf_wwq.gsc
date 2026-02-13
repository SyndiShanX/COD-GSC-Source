/*****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_sumpf\cp_sumpf_wwq.gsc
*****************************************************/

init() {
  _id_099C::_id_C211("shinowwq", 1, ::init_step_one_find_workbench, ::do_step_one_find_workbench, ::cleanup_step_one_find_workbench, ::debug_step_one_find_workbench);
  _id_099C::_id_C211("shinowwq", 2, ::init_step_two_search_for_components, ::do_step_two_search_for_components, ::cleanup_step_two_search_for_components, ::debug_step_two_search_for_components);
  _id_099C::_id_C211("shinowwq", 3, ::init_step_three_assemble, ::do_step_three_soul_assemble, ::cleanup_step_three_assemble, ::debug_step_three_assemble);
  level._effect["wwq_target_raido_tower_zombie_fx"] = loadfx("vfx/s4/level/cp_sumpf/vfx_glow_orb");
  level._effect["wwq_thunder_striker_fx"] = loadfx("vfx/s4/level/cp_sumpf/vfx_lightning_strike_radio_tower");
  level._effect["wwq_thunder_hit_radio_fx"] = loadfx("vfx/s4/level/cp_sumpf/vfx_lightning_radio_tower_down");
  level._effect["wwq_thunder_hit_radio_lp_fx"] = loadfx("vfx/s4/level/cp_sumpf/vfx_lightning_radio_tower_down_loop");
  level._effect["wwq_circuit_explo_fx"] = loadfx("vfx/s4/level/cp_sumpf/vfx_circuits_explosion_sm");
  level._effect["wwq_trap_panel_spark_loop_fx"] = loadfx("vfx/s4/level/cp_sumpf/vfx_circuits_explosion_sm_loop");
  level._effect["wwq_sacrifice_zombie_ambient_fx"] = loadfx("vfx/s4/zombie/vfx_ritual_sacrificing.vfx");
  level._effect["wwq_sacrifice_zombie_trail_fx"] = loadfx("vfx/s4/level/cp_zod/vfx_mq_tome_page_shield_anchor_trail");
  level._effect["wwq_tube_charged_fx"] = loadfx("vfx/s4/zombie/vfx_tesla_bulb_zmb");
  level._effect["wwq_craft_complete_fx"] = loadfx("vfx/s4/zombie/vfx_craft_weapon");
  level._effect["wwq_tesla_charge_amb_fx_01"] = loadfx("vfx/s4/level/cp_sumpf/vfx_tesla_coil_chargeup");
  level._effect["wwq_tesla_charge_amb_fx_02"] = loadfx("vfx/s4/level/cp_sumpf/vfx_tesla_coil_chargeup_02");
  level._effect["wwq_tesla_charge_amb_fx_03"] = loadfx("vfx/s4/level/cp_sumpf/vfx_tesla_coil_chargeup_03");
  level._effect["wwq_tesla_charge_amb_fx_04"] = loadfx("vfx/s4/level/cp_sumpf/vfx_tesla_coil_chargeup_04");
  level._effect["wwq_tesla_charge_amb_fx_05"] = loadfx("vfx/s4/level/cp_sumpf/vfx_tesla_coil_chargeup_top");
  level._effect["wwq_tesla_charge_indicator_fx_01"] = loadfx("vfx/s4/zombie/vfx_tesla_chargestatus_p_01");
  level._effect["wwq_tesla_charge_indicator_fx_02"] = loadfx("vfx/s4/zombie/vfx_tesla_chargestatus_p_02");
  level._effect["wwq_tesla_charge_indicator_fx_03"] = loadfx("vfx/s4/zombie/vfx_tesla_chargestatus_p_03");
  level._effect["wwq_tesla_charge_indicator_fx_04"] = loadfx("vfx/s4/zombie/vfx_tesla_chargestatus_p_04");
  level._effect["wwq_tesla_charge_indicator_fx_05"] = loadfx("vfx/s4/zombie/vfx_tesla_chargestatus_p_05");
  level._effect["zombie_spawn_flash_fx"] = loadfx("vfx/s4/zombie_ai/vfx_zai_portal_spawn.vfx");
  level thread set_up_initial_interactions();
}

set_up_initial_interactions() {
  level endon("game_ended");
  level scripts\engine\utility::_id_5C24("interactions_initialized");
  level.s_tube_01_loc = scripts\engine\utility::getstruct("wwq_workbench_loc", "script_noteworthy");
  level.s_tube_01_loc.b_should_pickup = 0;
  _id_0737::_id_C266("wwq_workbench_loc", ::hint_interaction_workbench, ::on_interact_workbench, ::init_interact_tube);
  _id_0737::addinteractionhinttypecallback("wwq_workbench_loc", ::hint_type_workbench);
  level.s_tube_02_loc = scripts\engine\utility::getstruct("wwq_tube_02_loc", "script_noteworthy");
  level.s_tube_02_loc.b_should_pickup = 1;
  level.s_tube_02_loc.wait_flag = "wwq_win_defend";
  _id_0737::_id_C266("wwq_tube_02_loc", ::hint_interaction_tube_02, ::on_interact_tube_02, ::init_interact_tube);
  level._id_8393["wwq_tube_02_loc"].hint_type_func = ::get_tube_02_hint_type;
  level.s_tube_03_loc = scripts\engine\utility::getstruct("wwq_tube_03_loc", "script_noteworthy");
  level.s_tube_03_loc.b_should_pickup = 1;
  level.s_tube_03_loc.wait_flag = "wwq_tesla_charged";
  _id_0737::_id_C266("wwq_tube_03_loc", ::hint_interaction_tube_03, ::on_interact_tube_03, ::init_interact_tube);
  level.s_circuit_breaker_loc = scripts\engine\utility::getstruct("wwq_circuit_breaker_loc", "script_noteworthy");
  level.s_circuit_breaker_loc.b_should_pickup = 1;
  _id_0737::_id_C266("wwq_circuit_breaker_loc", undefined, ::on_interact_circuit_breaker, ::init_interact_circuit_breaker);
  level._id_835D["wwq_circuit_breaker_loc"] = &"CP_SUMPF/WWQ_COLLECT_CIRCUIT_BREAKER";
  level.s_barrel_loc = scripts\engine\utility::getstruct("wwq_barrel_loc", "script_noteworthy");
  level.s_barrel_loc.b_should_pickup = 1;
  _id_0737::_id_C266("wwq_barrel_loc", undefined, ::on_interact_barrel, ::init_interact_barrel);
  level._id_835D["wwq_barrel_loc"] = &"CP_SUMPF/WWQ_COLLECT_BARREL";
}

init_step_one_find_workbench() {
  level.s_workdbench_loc = scripts\engine\utility::getstruct("wwq_workbench_loc", "script_noteworthy");
}

do_step_one_find_workbench() {
  level thread do_step_one_wait();
  level waittill("wwq_step_one_is_done");
}

cleanup_step_one_find_workbench() {}

debug_step_one_find_workbench() {
  level notify("wwq_step_one_is_done");
}

do_step_one_wait() {
  level endon("game_ended");
  level endon("wwq_step_one_is_done");
  level thread check_players_find_workbench();
  wait 10;
  level notify("wwq_step_one_is_done");
}

check_players_find_workbench() {
  level endon("game_ended");

  for(;;) {
    foreach(var_1 in level.players) {
      if(isDefined(var_1) && distancesquared(var_1.origin, level.s_workdbench_loc.origin) < 22500) {
        level thread play_find_workbench_vo();
        return;
      }
    }

    wait 1;
  }
}

play_find_workbench_vo() {
  level endon("game_ended");
  var_0 = ["zm_cpm4_wws4_krft_wgaa", "zm_cpm4_wws4_vlst_wgab"];
  var_1 = ["zm_cpm4_wws4_krft_wgac", "zm_cpm4_wws4_vlst_wgad"];
  var_2 = ["zm_cpm4_wws4_krft_wgae", "zm_cpm4_wws4_vlst_wgaf"];
  var_3 = scripts\engine\utility::random([var_0, var_1, var_2]);
  level thread _id_0720::play_narrations(var_3, 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");
  level thread check_players_get_close_to_workbench();
}

check_players_get_close_to_workbench() {
  level endon("game_ended");
  level endon("electro_trap_blowed");

  while(!scripts\engine\utility::_id_5C00("electro_trap_blowed")) {
    foreach(var_1 in level.players) {
      if(isDefined(var_1) && distancesquared(var_1.origin, level.s_workdbench_loc.origin) < 2500 && var_1 is_look_at(level.s_workdbench_loc, 60)) {
        level thread _id_0720::play_narration(["zm_cpm4_wws4_blkr_wgb1", "zm_cpm4_wws4_blkr_wgb2", "zm_cpm4_wws4_krft_wgb3"], 1, 0);
        return;
      }
    }

    wait 1;
  }
}

init_step_two_search_for_components() {
  _id_06CB::_id_AA4A(::on_zombie_killed_step_two);
  level.a_e_ww_parts = [];
  var_0 = getent("wwq_dg2_body_part", "script_noteworthy");
  level.a_e_ww_parts = scripts\engine\utility::array_add(level.a_e_ww_parts, var_0);
  level.n_electro_trap_kills = 0;
  level.s_electro_trap_loc = scripts\engine\utility::getstruct("electric_trap_storage", "targetname");
  _id_0737::_id_C266("wwq_elec_trap_loc", ::hint_interact_electro_trap, ::on_interact_electro_trap, ::init_interact_electro_trap);
  _id_0737::addinteractionhinttypecallback("wwq_elec_trap_loc", ::hint_type_electro_trap);
  level.s_electro_trap_loc thread trap_broken_time_watcher();
  level.mdl_trap_pnl = getent("wwq_trap_pnl_mdl", "script_noteworthy");
  _id_0737::_id_C266("wwq_radio_tower_trig_loc", ::hint_interaction_radio_tower, ::on_interact_radio_tower, ::init_interact_radio_tower);
  _id_0737::addinteractionhinttypecallback("wwq_radio_tower_trig_loc", ::hint_type_radio_tower);
  level.s_barrel_drop_loc = scripts\engine\utility::getstruct("wwq_barrel_drop_loc", "script_noteworthy");
  level.s_radio_tower = scripts\engine\utility::getstruct("wwq_radio_tower_center_loc", "script_noteworthy");
  level.s_radio_tower.n_health = 100;
  level.a_s_commroom_spawners = scripts\engine\utility::getstructarray("comm_room_outside_zone", "target");
  level.a_s_commroom_screamer_spawners = [];

  foreach(var_2 in level.a_s_commroom_spawners) {
    if(scripts\engine\utility::is_equal(var_2._id_039B, "enemy_base_zombie_cp|enemy_zombie_screamer_cp")) {
      level.a_s_commroom_screamer_spawners = scripts\engine\utility::array_add(level.a_s_commroom_screamer_spawners, var_2);
    }

    if(scripts\engine\utility::is_equal(var_2._id_0481, "player_respawn_location")) {
      level.a_s_commroom_spawners = scripts\engine\utility::array_remove(level.a_s_commroom_spawners, var_2);
    }

    if(scripts\engine\utility::is_equal(var_2._id_039B, "enemy_zombie_trickster_cp")) {
      level.a_s_commroom_spawners = scripts\engine\utility::array_remove(level.a_s_commroom_spawners, var_2);
    }
  }

  level.a_ai_zombies_attacking_radio_tower = scripts\cp\utility::_id_459B(level.a_ai_zombies_attacking_radio_tower, []);
  level.a_s_radio_attacker_locs = scripts\engine\utility::getstructarray("wwq_radio_attacker_loc", "script_noteworthy");
  level.s_tube_03_loc.t_dmg = getent("wwq_tesla_dmg_trig", "targetname");
  level.s_tube_03_loc thread tesla_device_dmg_watcher();
  level.n_tesla_charge_times = 0;
}

do_step_two_search_for_components() {
  level thread step_two_progress_watcher();
  level thread check_players_get_close_to_second_vacuum();
  level thread check_players_get_close_to_third_vacuum();
  level waittill("wwq_step_two_is_done");
}

cleanup_step_two_search_for_components() {}

debug_step_two_search_for_components() {
  level scripts\engine\utility::_id_5C1B("wwq_second_tube_collected");
  spawn_ww_parts_on_workbench("wwq_barrel_workbench_loc", "s4_zm_dg2_components_barrel", 0);
  spawn_ww_parts_on_workbench("wwq_tube_02_workbench_loc", "s4_zm_dg2_components_tube", 1);
  waitframe();
  level scripts\engine\utility::_id_5C1B("wwq_third_tube_collected");
  spawn_ww_parts_on_workbench("wwq_tube_03_workbench_loc", "s4_zm_dg2_components_tube", 1);
  waitframe();
  level notify("wwq_step_two_is_done");
}

on_zombie_killed_step_two_give_score(var_0) {
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

on_zombie_killed_step_two(var_0) {
  if(istrue(self.b_is_target_radio_zombie)) {
    if(istrue(self.s_loc.b_is_occupied)) {
      self.s_loc.b_is_occupied = 0;
    }

    if(scripts\engine\utility::array_contains(level.a_ai_zombies_attacking_radio_tower, self)) {
      level.a_ai_zombies_attacking_radio_tower = scripts\engine\utility::array_remove(level.a_ai_zombies_attacking_radio_tower, self);
    }

    if(check_free_attacking_locations()) {
      if(isDefined(level.s_radio_tower.objective_marker_index) && isDefined(level.s_radio_tower.objective_param)) {
        level.s_radio_tower.objective_param.setbackground = 0;
        level.s_radio_tower.objective_param.team = "neutral";
        _id_0987::_id_FB90(level.s_radio_tower.objective_marker_index, level.s_radio_tower.objective_param);
      }
    }
  }

  if(!level scripts\engine\utility::_id_5C00("wwq_first_tube_collected")) {
    if(scripts\engine\utility::is_equal(var_0._id_511D.target, "electric_trap_storage")) {
      level.n_electro_trap_kills++;

      if(level scripts\engine\utility::_id_5C00("electro_trap_blowed")) {
        if(scripts\engine\utility::is_equal(level.n_electro_trap_kills, 13)) {
          scripts\cp\utility::_id_B8EF("zmb_ww_tube_charge", level.s_tube_01_loc.mdl_tube.origin);
          playFXOnTag(level._effect["wwq_tube_charged_fx"], level.s_tube_01_loc.mdl_tube, "tag_origin");
          level scripts\engine\utility::_id_5C1B("wwq_first_tube_collected");
          level.a_e_ww_parts = scripts\engine\utility::array_add(level.a_e_ww_parts, level.s_tube_01_loc.mdl_tube);
          level thread play_finish_charging_vacuum_tube_vo();
        }
      } else if(scripts\engine\utility::is_equal(level.n_electro_trap_kills, 3))
        do_trap_breaking();
    }
  }
}

wwq_step_two_trap_blowed_watcher() {
  level endon("game_ended");
  scripts\engine\utility::_id_5C24("electro_trap_blowed");
  _id_0737::_id_1037(self);
}

step_two_progress_watcher() {
  level endon("game_ended");

  for(;;) {
    if(level scripts\engine\utility::_id_5C00("wwq_first_tube_collected") && level scripts\engine\utility::_id_5C00("wwq_second_tube_collected") && level scripts\engine\utility::_id_5C00("wwq_third_tube_collected")) {
      level notify("wwq_step_two_is_done");
      return;
    }

    wait 1;
  }
}

spawn_ww_parts_on_workbench(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getstruct(var_0, "script_noteworthy");
  var_4 = scripts\cp\utility::_id_E190(var_1, var_3.origin, var_3.angles);

  if(istrue(var_2)) {
    playFXOnTag(level._effect["wwq_tube_charged_fx"], var_4, "tag_origin");
  }

  level.a_e_ww_parts = scripts\engine\utility::array_add(level.a_e_ww_parts, var_4);
}

on_interact_circuit_breaker(var_0, var_1) {
  if(isDefined(var_0.mdl_circuit_breaker)) {
    level scripts\engine\utility::_id_5C1B("wwq_circuit_breaker_in_hand");
    scripts\cp\utility::_id_B8EF("zmb_ww_fuse_pickup", var_0.origin);
    var_0.mdl_circuit_breaker notify("death");
    var_0.mdl_circuit_breaker _meth_86BE();
    var_1 _meth_827A("cp_zm_s2_mq_shield_rumble", var_1.origin);
    level thread _id_0720::play_event_vo_from_selected_players("pickup_item", [var_1]);
  }

  _id_0737::_id_C3C5(var_0);
}

init_interact_circuit_breaker(var_0) {
  if(!isDefined(var_0[0].mdl_circuit_breaker)) {
    var_0[0].mdl_circuit_breaker = _func_03C5("cploot_item_circuit_breaker", var_0[0].origin, var_0[0].angles);
    var_0[0].mdl_circuit_breaker thread show_hide_outline_listener();
  }
}

hint_interaction_workbench(var_0, var_1) {
  if(level scripts\engine\utility::_id_5C00("wwq_first_tube_collected") && level scripts\engine\utility::_id_5C00("wwq_second_tube_collected") && level scripts\engine\utility::_id_5C00("wwq_third_tube_collected")) {
    if(level scripts\engine\utility::_id_5C00("craft_btn_in_use") || isDefined(var_0.user) && !scripts\engine\utility::is_equal(var_0.user, var_1)) {
      return "";
    } else {
      var_1 thread ww_crafting_watcher(var_0);
      return &"CP_SUMPF/WWQ_CRAFT_DG2";
    }
  } else
    return "";
}

on_interact_workbench(var_0, var_1) {}

hint_interact_electro_trap(var_0, var_1) {
  if(level scripts\engine\utility::_id_5C00("electro_trap_blowed") && level scripts\engine\utility::_id_5C00("wwq_circuit_breaker_in_hand")) {
    return &"CP_SUMPF/WWQ_PLACE_CIRCUIT";
  } else if(level scripts\engine\utility::_id_5C00("electro_trap_blowed") && !level scripts\engine\utility::_id_5C00("wwq_circuit_breaker_in_hand")) {
    return &"CP_SUMPF/WWQ_TRAP_BROKEN";
  } else {
    return "";
  }
}

on_interact_electro_trap(var_0, var_1) {
  if(level scripts\engine\utility::_id_5C00("electro_trap_blowed") && level scripts\engine\utility::_id_5C00("wwq_circuit_breaker_in_hand")) {
    var_0 thread return_fuse_to_trap_panel(var_1);
    level thread play_repair_electro_trap_vo();
  }
}

return_fuse_to_trap_panel(var_0) {
  level endon("game_ended");
  level endon("wwq_step_two_is_done");
  var_1 = scripts\engine\utility::getstruct("wwq_returned_fuse_loc", "script_noteworthy");
  var_2 = scripts\cp\utility::_id_E190("s4_zm_circuit_breaker", var_1.origin, var_1.angles);
  scripts\cp\utility::_id_B8EF("zmb_ww_fuse_insert", self.origin);
  var_0 _meth_827A("cp_zm_s2_mq_shield_rumble", var_0.origin);
  wait 1.5;
  level.mdl_trap_pnl _meth_82CB("s4_zm_trap_control_close_01");
  level.s_electro_trap_loc._id_4A88 = undefined;
  level.s_electro_trap_loc scripts\engine\utility::_id_5470("trap_broken");
  level.s_electro_trap_loc scripts\engine\utility::_id_5474("fuse_return");

  if(isDefined(level.s_electro_trap_loc.mdl_fx)) {
    _func_0130(level.s_electro_trap_loc.mdl_fx);
    level.s_electro_trap_loc.mdl_fx delete();
  }

  _id_0737::_id_C3C5(self);
  scripts\cp\maps\cp_sumpf\cp_sumpf_trap::active_electric_trap(level.s_electro_trap_loc, var_0);
}

hint_type_electro_trap(var_0, var_1) {
  if(level scripts\engine\utility::_id_5C00("electro_trap_blowed") && level scripts\engine\utility::_id_5C00("wwq_circuit_breaker_in_hand")) {
    return "HINT_NOICON";
  } else if(level scripts\engine\utility::_id_5C00("electro_trap_blowed") && !level scripts\engine\utility::_id_5C00("wwq_circuit_breaker_in_hand")) {
    return "HINT_NOBUTTON";
  }

  return "HINT_NOICON";
}

init_interact_electro_trap(var_0) {
  foreach(var_2 in var_0) {
    _id_0737::_id_C3C5(var_2);
    var_2 thread wwq_step_two_trap_blowed_watcher();
  }
}

trap_broken_time_watcher() {
  level endon("game_ended");
  level endon("wwq_step_two_is_done");

  for(;;) {
    if(istrue(self._id_7D7E)) {
      wait 15;
      do_trap_breaking();
      return;
    }

    waitframe();
  }
}

do_trap_breaking() {
  if(!scripts\engine\utility::_id_5C00("electro_trap_blowed")) {
    level.mdl_trap_pnl _meth_82CB("s4_zm_trap_control_open_01");
    scripts\cp\utility::_id_B8EF("zmb_ww_panel_blows", level.s_electro_trap_loc.origin);
    level scripts\engine\utility::_id_5C1B("electro_trap_blowed");
    level.s_electro_trap_loc scripts\engine\utility::_id_5474("trap_broken");
    level.s_electro_trap_loc._id_4A88 = 1;
    playFX(level._effect["wwq_circuit_explo_fx"], level.s_electro_trap_loc.origin);
    level.s_electro_trap_loc.mdl_fx = scripts\cp\utility::_id_E190("tag_origin", level.s_electro_trap_loc.origin + anglesToForward(level.s_electro_trap_loc.angles) * -10 + anglestoup(level.s_electro_trap_loc.angles) * -6);
    playFXOnTag(level._effect["wwq_trap_panel_spark_loop_fx"], level.s_electro_trap_loc.mdl_fx, "tag_origin");
    level thread play_trap_blow_vo();
  }
}

play_trap_blow_vo() {
  level endon("game_ended");
  level thread _id_0720::play_narration(["zm_cpm4_wws4_krft_wgc1", "zm_cpm4_wws4_krft_wgc2", "zm_cpm4_wws4_krft_wgc3"], 1, 0);
  level waittill("dialogue_finished");

  if(scripts\engine\utility::_id_5C00("wwq_circuit_breaker_in_hand")) {
    level thread _id_0720::play_narration(["zm_cpm4_wws4_blkr_wgd1", "zm_cpm4_wws4_blkr_wgd2", "zm_cpm4_wws4_blkr_wgd3"], 1, 0);
  }
}

play_repair_electro_trap_vo() {
  level endon("game_ended");
  level thread _id_0720::play_narration(["zm_cpm4_wws4_krft_wge1", "zm_cpm4_wws4_krft_wge2", "zm_cpm4_wws4_krft_wge3"], 1, 0);
  level waittill("dialogue_finished");
  level thread _id_0720::play_event_vo_from_selected_players("ally_confirmation", level.players, 1);
}

play_finish_charging_vacuum_tube_vo() {
  level endon("game_ended");
  level thread _id_0720::play_narration(["zm_cpm4_wws4_blkr_wgf1", "zm_cpm4_wws4_blkr_wgf2", "zm_cpm4_wws4_blkr_wgf3"], 1, 0);
}

on_interact_barrel(var_0, var_1) {
  if(isDefined(var_0.mdl_barrel)) {
    level scripts\engine\utility::_id_5C1B("wwq_barrel_in_hand");
    scripts\cp\utility::_id_B8EF("zmb_ww_barrel_pickup", var_0.origin);
    var_1 _meth_827A("cp_zm_s2_mq_shield_rumble", var_1.origin);
    var_0.mdl_barrel notify("death");
    var_0.mdl_barrel _meth_86BE();
    level thread play_pick_up_barrel_vo();
  }

  _id_0737::_id_C3C5(var_0);
}

init_interact_barrel(var_0) {
  if(!isDefined(var_0[0].mdl_barrel)) {
    var_0[0].mdl_barrel = _func_03C5("cploot_item_barrel", var_0[0].origin, var_0[0].angles);
    var_0[0].mdl_barrel thread show_hide_outline_listener();
  }
}

hint_interaction_radio_tower(var_0, var_1) {
  if(level scripts\engine\utility::_id_5C00("wwq_barrel_in_hand") && !level scripts\engine\utility::_id_5C00("wwq_win_defend")) {
    return &"CP_SUMPF/WWQ_INSERT_BARREL";
  } else if(!level scripts\engine\utility::_id_5C00("wwq_barrel_in_hand") && level scripts\engine\utility::_id_5C00("wwq_win_defend")) {
    return &"CP_SUMPF/WWQ_REMOVE_BARREL";
  } else {
    return "";
  }
}

hint_type_radio_tower(var_0, var_1) {
  return "HINT_NOICON";
}

on_interact_radio_tower(var_0, var_1) {
  if(level scripts\engine\utility::_id_5C00("wwq_barrel_in_hand") && !level scripts\engine\utility::_id_5C00("wwq_win_defend")) {
    scripts\cp\utility::_id_B8EF("zmb_ww_barrel_radio_tower", var_0.origin);
    var_1 _meth_827A("cp_zm_s2_mq_shield_rumble", var_1.origin);
    var_2 = scripts\engine\utility::getstruct(var_0.target, "script_noteworthy");

    if(!isDefined(level.mdl_barrel)) {
      level.mdl_barrel = scripts\cp\utility::_id_E190("s4_zm_dg2_components_barrel", var_2.origin, var_2.angles);
      level.mdl_barrel _meth_82CB("s4_zm_dg2_components_idle_01");
    }

    level scripts\engine\utility::_id_5C04("wwq_barrel_in_hand");
    level scripts\engine\utility::_id_5C1B("wwq_barrel_placed");
    level thread radio_tower_defend_event_start_watcher(level.mdl_barrel);
    level thread play_insert_barrel_vo();

    foreach(var_1 in level.players) {
      var_1 _id_0737::_id_C1A2();
    }
  } else if(!level scripts\engine\utility::_id_5C00("wwq_barrel_in_hand") && level scripts\engine\utility::_id_5C00("wwq_win_defend")) {
    scripts\cp\utility::_id_B8EF("zmb_ww_fuse_pickup", var_0.origin);
    var_1 _meth_827A("cp_zm_s2_mq_shield_rumble", var_1.origin);
    level.mdl_barrel delete();
    level scripts\engine\utility::_id_5C1B("wwq_barrel_in_hand");

    if(level scripts\engine\utility::_id_5C00("wwq_second_tube_in_hand")) {
      level scripts\engine\utility::_id_5C1B("wwq_second_tube_collected");
    }

    spawn_ww_parts_on_workbench("wwq_barrel_workbench_loc", "s4_zm_dg2_components_barrel", 0);
    _id_0737::_id_C4AB("wwq_radio_tower_trig_loc");
  }
}

init_interact_radio_tower(var_0) {}

hint_interaction_tube_02(var_0, var_1) {
  if(level scripts\engine\utility::_id_5C00("wwq_win_defend")) {
    return &"CP_SUMPF/WWQ_COLLECT_TUBE";
  } else if(!level scripts\engine\utility::_id_5C00("interact_with_tube_02_already")) {
    return &"CP_SUMPF/WWQ_CHECK_RADIO";
  } else {
    return &"CP_SUMPF/WWQ_POWER_UP_THE_RADIO";
  }
}

get_tube_02_hint_type(var_0, var_1) {
  if(!level scripts\engine\utility::_id_5C00("wwq_win_defend") && level scripts\engine\utility::_id_5C00("interact_with_tube_02_already")) {
    return "HINT_NOBUTTON";
  } else {
    return "HINT_NOICON";
  }
}

on_interact_tube_02(var_0, var_1) {
  if(level scripts\engine\utility::_id_5C00("wwq_win_defend")) {
    scripts\cp\utility::_id_B8EF("zmb_ww_tube_pickup", var_0.origin);
    var_1 _meth_827A("cp_zm_s2_mq_shield_rumble", var_1.origin);
    var_0.mdl_tube notify("death");
    var_0.mdl_tube _meth_86BE();

    if(isDefined(var_0.sound_proxy)) {
      var_0.sound_proxy _meth_83F8();
      var_0.sound_proxy delete();
    }

    level scripts\engine\utility::_id_5C1B("wwq_second_tube_in_hand");

    if(level scripts\engine\utility::_id_5C00("wwq_barrel_in_hand")) {
      level scripts\engine\utility::_id_5C1B("wwq_second_tube_collected");
    }

    spawn_ww_parts_on_workbench("wwq_tube_02_workbench_loc", "s4_zm_dg2_components_tube", 1);
    _id_0737::_id_C3C5(var_0);
  } else if(!level scripts\engine\utility::_id_5C00("interact_with_tube_02_already")) {
    level scripts\engine\utility::_id_5C1B("interact_with_tube_02_already");
    level thread play_interact_with_tube_02_vo();
  }
}

init_interact_tube(var_0) {
  var_1 = scripts\engine\utility::getstruct(var_0[0].target, "script_noteworthy");

  if(!isDefined(var_0[0].mdl_tube)) {
    if(istrue(var_0[0].b_should_pickup)) {
      var_0[0].mdl_tube = _func_03C5("cploot_item_tube", var_1.origin, var_1.angles);
      var_0[0].mdl_tube setscriptablepartstate("fx", "off");
      var_0[0].mdl_tube thread show_hide_outline_listener(var_0[0].wait_flag);
    } else
      var_0[0].mdl_tube = scripts\cp\utility::_id_E190("s4_zm_dg2_components_tube", var_1.origin, var_1.angles);
  }
}

show_hide_outline_listener(var_0) {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    if(isDefined(self)) {
      var_1 = 0;

      foreach(var_3 in level.players) {
        if(var_3 scripts\cp\utility::_id_8708()) {
          var_4 = distancesquared(self.origin, var_3.origin);

          if(var_4 <= _func_0219(400) && !istrue(var_1)) {
            if(isDefined(var_0)) {
              if(level scripts\engine\utility::_id_5C00(var_0)) {
                var_1 = 1;
              }
            } else
              var_1 = 1;

            break;
          }
        }
      }

      if(istrue(var_1)) {
        self setscriptablepartstate("cploot_base", "show");
      } else {
        self setscriptablepartstate("cploot_base", "hidden");
      }
    } else
      return;

    wait 0.5;
  }
}

radio_tower_defend_event_start_watcher(var_0) {
  level endon("game_ended");
  level endon("wwq_step_two_is_done");
  level endon("wwq_win_defend");
  level endon("wwq_lose_defend");
  wait 1;
  var_0 thread buzz_sound_watcher();
  level thread thunder_ambient_sound("zmb_ww_thunder_close", 15, 25, "round_start");

  if(level.next_special_round == level._id_11049 + 1) {
    level.next_special_round = level.next_special_round + 1;
  }

  level waittill("round_complete");
  level thread thunder_ambient_sound("zmb_ww_thunder_close", 15, 25, "wwq_win_defend", "wwq_lose_defend");

  for(;;) {
    foreach(var_2 in level.players) {
      if(isDefined(var_2) && distancesquared(var_2.origin, level.s_radio_tower.origin) < 250000 && !scripts\engine\utility::_id_5C00("start_rbz_exfil")) {
        scripts\engine\utility::_id_5C04("round_spawn_zombies");
        level.force_cleanup_all_zombies = 1;
        var_3 = _id_06FE::_id_6322();

        foreach(var_5 in var_3) {
          var_5 scripts\cp\zombies\zm_cleanup::cleanup_zombie();
        }

        level notify("complete_shooting_gallery");
        level.force_cleanup_all_zombies = 0;

        if(scripts\engine\utility::_id_5C00("in_special_round")) {
          level.rbz scripts\engine\utility::_id_5474("all_killed");
          level.next_special_round = level._id_11049 + 1;
        }

        level scripts\engine\utility::_id_5C1B("disallow_rbz_exfil");
        level thread main_thunder_fx_watcher();
        level thread sub_thunder_fx_watcher();
        scripts\cp\maps\cp_sumpf\cp_sumpf_dig_site_discovery::hide_breadcrumbs_quest();
        level thread play_defend_the_radio_tower_kickoff_vo();
        wait 10;
        _func_01E3("ww_tower_defend");
        level._id_A52A = 1;
        level.a_disabled_score_event = ["stun_grenade_stunned_enemy", "stun_mine_stunned_enemy", "juggernaut_backpack_destroyed", "energy_mine_stunned_enemy"];
        level.s_radio_tower add_radio_tower_marker();
        level thread show_radio_tower_defend_hint_monitor();
        level thread radio_tower_defend_progress_watcher();
        return;
      }
    }

    wait 1;
  }
}

radio_tower_defend_progress_watcher() {
  level endon("game_ended");
  level endon("wwq_step_two_is_done");
  level endon("wwq_win_defend");
  level endon("wwq_lose_defend");
  var_0 = level.players.size;
  var_1 = [5, 5, 5, 5];
  var_2 = [4, 4, 4, 4];
  var_3 = [3, 3, 3, 3];
  var_4 = [8, 8, 8, 8];
  var_5 = [6, 6, 6, 6];
  var_6 = [4, 4, 4, 4];
  var_7 = [20, 20, 20, 20];
  var_8 = [16, 16, 16, 16];
  var_9 = [12, 12, 12, 12];
  var_10 = [10, 10, 10, 10];
  var_11 = [15, 15, 15, 15];
  var_12 = [20, 20, 20, 20];
  var_13 = [2, 3, 4, 5];
  var_14 = [2, 3, 4, 5];
  var_15 = [3, 4, 5, 6];
  var_16 = [1, 1, 2, 2];
  var_17 = [1, 1, 2, 2];
  var_18 = [1, 1, 2, 2];
  level notify("wwq_radio_tower_defend_phase_one_started");
  level thread spawn_zombie_in_radio_tower_defend("base", "enemy_base_zombie_sumpf_cp", var_1[var_0 - 1], var_10[var_0 - 1], "wwq_radio_tower_defend_phase_two_started");
  wait 1;
  level thread spawn_zombie_in_radio_tower_defend("screamer", "enemy_zombie_screamer_cp", var_4[var_0 - 1], var_13[var_0 - 1], "wwq_radio_tower_defend_phase_two_started");
  wait 1;
  level thread spawn_zombie_in_radio_tower_defend("juggernaut", "enemy_zombie_juggernaut_cp", var_7[var_0 - 1], var_16[var_0 - 1], "wwq_radio_tower_defend_phase_two_started");
  wait 20;
  level notify("wwq_radio_tower_defend_phase_two_started");
  level thread spawn_zombie_in_radio_tower_defend("base", "enemy_base_zombie_sumpf_cp", var_2[var_0 - 1], var_11[var_0 - 1], "wwq_radio_tower_defend_phase_three_started");
  wait 1;
  level thread spawn_zombie_in_radio_tower_defend("screamer", "enemy_zombie_screamer_cp", var_5[var_0 - 1], var_14[var_0 - 1], "wwq_radio_tower_defend_phase_three_started");
  wait 1;
  level thread spawn_zombie_in_radio_tower_defend("juggernaut", "enemy_zombie_juggernaut_cp", var_8[var_0 - 1], var_17[var_0 - 1], "wwq_radio_tower_defend_phase_three_started");
  wait 20;
  level notify("wwq_radio_tower_defend_phase_three_started");
  level thread spawn_zombie_in_radio_tower_defend("base", "enemy_base_zombie_sumpf_cp", var_3[var_0 - 1], var_12[var_0 - 1], "wwq_defend_radio_stop_spawning");
  wait 1;
  level thread spawn_zombie_in_radio_tower_defend("screamer", "enemy_zombie_screamer_cp", var_6[var_0 - 1], var_15[var_0 - 1], "wwq_defend_radio_stop_spawning");
  wait 1;
  level thread spawn_zombie_in_radio_tower_defend("juggernaut", "enemy_zombie_juggernaut_cp", var_9[var_0 - 1], var_18[var_0 - 1], "wwq_defend_radio_stop_spawning");
  wait 20;
  level scripts\engine\utility::_id_5C1B("wwq_defend_radio_stop_spawning");
  level thread play_defend_success_sound();
  level thread fadetowhite(0.3);
  var_19 = _id_06FE::_id_6322();

  foreach(var_21 in var_19) {
    var_21 _meth_81FA();
  }

  level notify("complete_shooting_gallery");
  level scripts\engine\utility::_id_5C04("disallow_rbz_exfil");
  level._id_A52A = 0;
  level.a_disabled_score_event = undefined;
  level.s_tube_02_loc.mdl_tube setscriptablepartstate("fx", "playfx");
  level.s_tube_02_loc.sound_proxy = scripts\cp\utility::_id_E190("tag_origin", level.s_tube_02_loc.mdl_tube.origin);
  level.s_tube_02_loc.sound_proxy thread charged_sound_watcher();
  level.s_radio_tower cleanup_marker();
  playFX(level._effect["wwq_thunder_striker_fx"], level.s_radio_tower.origin);
  scripts\cp\utility::_id_B8EF("zmb_ww_lightning_strike", level.s_radio_tower.origin);
  level.s_radio_tower play_rumble_and_screenshake_to_players(500);
  _func_01E3("none");
  wait 2;
  scripts\engine\utility::_id_5C1B("round_spawn_zombies");
  scripts\cp\utility::_id_B8EF("zmb_ww_tube_charge", level.s_tube_02_loc.mdl_tube.origin);
  clear_radio_tower_defend_hint();
  wait 1;
  scripts\cp\maps\cp_sumpf\cp_sumpf_dig_site_discovery::show_breadcrumbs_quest();
  level thread play_defend_the_radio_tower_success_vo();
  level scripts\engine\utility::_id_5C1B("wwq_win_defend");
}

play_defend_success_sound() {
  level endon("game_ended");
  level endon("wwq_step_two_is_done");
  wait 1;

  foreach(var_1 in level.players) {
    level thread scripts\cp\utility::_id_B8F4("zmb_ww_tower_success", var_1);
  }
}

fadetowhite(var_0) {
  level endon("game_ended");
  level notify("FadeToWhite_singleton");
  level endon("FadeToWhite_singleton");
  _func_01EA("ui_total_fade_color", 1);

  foreach(var_2 in level.players) {
    if(!isDefined(var_2)) {
      continue;
    }
    level thread scripts\cp_mp\utility\game_utility::_id_58C7(var_2, 1, var_0);
  }

  wait(var_0 + 0.3);

  foreach(var_2 in level.players) {
    if(!isDefined(var_2)) {
      continue;
    }
    level thread scripts\cp_mp\utility\game_utility::_id_58C7(var_2, 0, var_0);
  }

  wait(var_0 + 0.3);
  _func_01EA("ui_total_fade_color", 0);
}

show_radio_tower_defend_hint_monitor(var_0) {
  level endon("game_ended");
  level endon("wwq_step_two_is_done");
  level endon("wwq_win_defend");
  level endon("wwq_lose_defend");
  level endon("wwq_defend_radio_tower_hint_cleared");

  for(;;) {
    foreach(var_2 in level.players) {
      if(isDefined(var_2)) {
        if(!isDefined(var_2.defend_radio_tower_hint)) {
          var_2.defend_radio_tower_hint = var_2 scripts\cp\utility::createfontstring("default", 1);
          var_2.defend_radio_tower_hint scripts\cp\utility::setpoint("LEFT", undefined, 30, -90);
          var_2.defend_radio_tower_hint.color = (1, 1, 1);
          var_2.defend_radio_tower_hint settext(&"CP_SUMPF/DEFEND_THE_RADIO_TOWER");
          var_2.defend_radio_tower_hint.alpha = 1;
        }

        if(!isDefined(var_2.radio_tower_health_bar)) {
          var_2.radio_tower_health_bar = var_2 scripts\cp\utility::_id_3F99((1, 1, 1), 100, 10);
          var_2.radio_tower_health_bar scripts\cp\utility::setpoint("LEFT", undefined, 30, -70);
          var_2.radio_tower_health_bar scripts\cp\utility::_id_FC11(level.s_radio_tower.n_health / 100);
        }
      }
    }

    wait 1;
  }
}

clear_radio_tower_defend_hint() {
  level notify("wwq_defend_radio_tower_hint_cleared");

  foreach(var_1 in level.players) {
    if(isDefined(var_1)) {
      if(isDefined(var_1.defend_radio_tower_hint)) {
        var_1.defend_radio_tower_hint fadeovertime(0.15);
        var_1.defend_radio_tower_hint.alpha = 0;
        var_1.defend_radio_tower_hint scripts\cp\utility::destroyelem();
      }

      if(isDefined(var_1.radio_tower_health_bar)) {
        var_1.radio_tower_health_bar scripts\cp\utility::destroyelem();
      }
    }
  }
}

spawn_zombie_in_radio_tower_defend(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  level endon(var_4);
  level endon("wwq_lose_defend");

  for(;;) {
    if(get_alive_zombies_count(var_0) < var_3) {
      if(scripts\engine\utility::is_equal(var_0, "screamer")) {
        var_5 = pick_random_spawner(level.a_s_commroom_screamer_spawners);
      } else {
        var_5 = pick_random_spawner(level.a_s_commroom_spawners);
      }

      var_6 = _id_09A4::_id_110AD(var_1, var_5.origin, var_5.angles, var_5);
      var_6.b_ignore_cleanup = 1;
      wait 0.5;

      if(isDefined(var_6) && isalive(var_6)) {
        var_6._id_4A75 = 1;
        var_6.on_zombie_killed_score_override_func = ::on_zombie_killed_step_two_give_score;

        if(scripts\engine\utility::is_equal(var_0, "base")) {
          if(level.a_ai_zombies_attacking_radio_tower.size < 5) {
            var_6 thread assign_attack_location();
            level.a_ai_zombies_attacking_radio_tower = scripts\engine\utility::array_add(level.a_ai_zombies_attacking_radio_tower, var_6);
          }

          if(level._id_11049 < 20) {
            if(isDefined(var_6._id_D603)) {
              var_6[[var_6._id_D603]]("sprint");
            }
          }
        }

        if(scripts\engine\utility::is_equal(var_0, "juggernaut")) {
          playFX(level._effect["zombie_spawn_flash_fx"], var_6.origin);
          var_6 thread force_go_to_position();
        }
      }
    }

    wait(var_2);
  }
}

force_go_to_position(var_0) {
  self endon("death");
  var_1 = undefined;

  while(!isDefined(var_1)) {
    var_2 = vectortoangles((self.origin[0], self.origin[1], level.s_radio_tower.origin[2]) - level.s_radio_tower.origin);
    var_3 = anglesToForward(var_2);

    if(isDefined(var_0)) {
      var_1 = var_0.origin + var_3 * randomintrange(100, 200);
    } else {
      var_1 = level.s_radio_tower.origin + var_3 * randomintrange(100, 200);
    }

    var_1 = _func_02A9(var_1, 50);
    waitframe();
  }

  self._id_CF4A = 1;
  self._id_0229 = 1;
  self _meth_8326(var_1);
  scripts\engine\utility::_id_5473("zombie_move_to_defend_position");
  thread check_juggernaut_move_to_defend_position_monitor();
  thread check_juggernaut_get_stuck_when_move_to_defend_position_monitor(var_1);
  scripts\engine\utility::_id_5476("zombie_move_to_defend_position");
  scripts\aitypes\zombie_juggernaut\combat::set_defend_location(var_1);
  self._id_CF4A = 0;
  self._id_0229 = 0;
  thread check_defending_juggernaut_has_no_target_monitor();
}

check_juggernaut_move_to_defend_position_monitor() {
  level endon("game_ended");
  self endon("death");
  self waittill("goal");
  scripts\engine\utility::_id_5474("zombie_move_to_defend_position");
}

check_juggernaut_get_stuck_when_move_to_defend_position_monitor(var_0) {
  level endon("game_ended");
  self endon("death");
  var_1 = var_0;

  while(!scripts\engine\utility::_id_546E("zombie_move_to_defend_position")) {
    if(scripts\engine\utility::is_equal(self _meth_86F8(var_1), (0, 0, 0))) {
      var_2 = undefined;

      while(!isDefined(var_2)) {
        var_3 = vectortoangles((self.origin[0], self.origin[1], level.s_radio_tower.origin[2]) - level.s_radio_tower.origin);
        var_4 = anglesToForward(var_3);
        var_2 = level.s_radio_tower.origin + var_4 * randomintrange(100, 200);
        var_2 = _func_02A9(var_2, 50);
        waitframe();

        if(!isDefined(self)) {
          return;
        }
      }

      self _meth_8326(var_2);
      var_1 = var_2;
    }

    wait 0.5;

    if(!isDefined(self)) {
      return;
    }
  }
}

check_defending_juggernaut_has_no_target_monitor() {
  level endon("game_ended");
  self endon("death");
  var_0 = 3;
  var_1 = scripts\engine\utility::getstructarray("wwq_defend_alternate_point", "script_noteworthy");

  for(;;) {
    if(!isDefined(self._id_0192) || !self _meth_8067(self._id_0192)) {
      wait(var_0);

      if(!isDefined(self)) {
        return;
      }
    }

    if(!isDefined(self._id_0192) || !self _meth_8067(self._id_0192)) {
      if(isDefined(var_1)) {
        if(isDefined(self.alternate_defend_location)) {
          scripts\aitypes\zombie_juggernaut\combat::set_defend_location(undefined);
          return;
        } else
          self.alternate_defend_location = scripts\engine\utility::array_random(var_1);

        force_go_to_position(self.alternate_defend_location);
        return;
      }

      scripts\aitypes\zombie_juggernaut\combat::set_defend_location(undefined);
      return;
    }

    wait 0.5;

    if(!isDefined(self)) {
      return;
    }
  }
}

assign_attack_location() {
  level endon("game_ended");
  level endon("wwq_step_two_is_done");
  self endon("death");
  level endon("wwq_win_defend");
  level endon("wwq_lose_defend");

  foreach(var_1 in level.a_s_radio_attacker_locs) {
    if(!istrue(var_1.b_is_occupied)) {
      var_1.b_is_occupied = 1;
      self.s_loc = var_1;
      self.b_is_target_radio_zombie = 1;
      self.v_goal = _func_02AB(self.s_loc.origin);

      if(!istrue(self._id_7598)) {
        self waittill("intro_vignette_done");
      }

      while(isDefined(self._id_86ED) && self._id_86ED) {
        waitframe();
      }

      self[[self._id_D603]]("sprint");
      self._id_CF4A = 1;
      self _meth_8326(self.v_goal);
      self._id_0229 = 1;
      self._id_0043 = 0;
      self.brain_rot_immune = 1;
      thread release_zombie_watcher();
      thread zombie_attack_radio_dist_watcher();
      wait 1;
      return;
    }
  }
}

zombie_attack_radio_dist_watcher() {
  level endon("game_ended");
  level endon("wwq_step_two_is_done");
  self endon("death");
  level endon("wwq_win_defend");
  level endon("wwq_lose_defend");

  for(;;) {
    var_0 = distancesquared(self.origin, self.v_goal);

    if(var_0 <= 100) {
      thread zombie_start_sacrifice();
      return;
    }

    waitframe();
  }
}

zombie_start_sacrifice() {
  level endon("game_ended");
  level endon("wwq_step_two_is_done");
  level endon("wwq_lose_defend");
  self endon("death");
  self.b_is_sacrificing = 1;
  self _meth_81B0("outline_assault_zombie");
  self _meth_8326(self.origin);
  self _meth_8251("face direction", level.s_radio_tower.origin - self.origin);
  wait 0.5;
  level.s_radio_tower.objective_param.setbackground = 5;
  level.s_radio_tower.objective_param.team = self.team;
  _id_0987::_id_FB90(level.s_radio_tower.objective_marker_index, level.s_radio_tower.objective_param);

  if(isDefined(self._id_110B0) && isDefined(self.try_do_scripted_anim)) {
    self notify("CancelAnimscriptMP");

    for(;;) {
      self[[self.try_do_scripted_anim]]("animscripted", "melee_stand");
      wait 1.2;
      scripts\cp\utility::_id_B8ED(level.s_radio_tower.origin, "zmb_ww_tower_hit");
      level.s_radio_tower.n_health = level.s_radio_tower.n_health - 5;

      foreach(var_1 in level.players) {
        if(isDefined(var_1) && isDefined(var_1.radio_tower_health_bar)) {
          var_1.radio_tower_health_bar thread scripts\cp\utility::_id_FC11(level.s_radio_tower.n_health / 100);
        }
      }

      if(level.s_radio_tower.n_health <= 0) {
        level thread reset_defend_event();
        return;
      }

      self waittill("AnimscriptMP_Complete");
    }
  }
}

release_zombie_watcher() {
  level endon("game_ended");
  level endon("wwq_step_two_is_done");
  self endon("death");
  level scripts\engine\utility::_id_10897("wwq_lose_defend", "wwq_win_defend");
  self._id_CF4A = 0;
  self._id_0229 = 0;
  self._id_0043 = 1;
  self.brain_rot_immune = 0;
}

send_trail_fx_to_raido() {
  level endon("game_ended");
  level endon("wwq_step_two_is_done");
  self endon("death");
  var_0 = scripts\cp\utility::_id_E190("tag_origin", self gettagorigin("j_spine4"));
  var_1 = distance(var_0.origin, level.s_radio_tower.origin) / 50;
  waitframe();
  playFXOnTag(level._effect["wwq_sacrifice_zombie_trail_fx"], var_0, "tag_origin");
  var_0 moveto(level.s_radio_tower.origin, var_1, 0, 0);
  var_0 waittill("movedone");
  _func_0130(var_0);
  var_0 delete();
}

reset_defend_event() {
  level endon("game_ended");
  level endon("wwq_step_two_is_done");
  level notify("wwq_lose_defend");
  _func_01E3("none");
  scripts\cp\utility::_id_B8EF("zmb_ww_radio_charge_fail", level.s_radio_tower.origin);
  level.s_radio_tower.n_health = 100;
  level.s_radio_tower cleanup_marker();
  clear_radio_tower_defend_hint();
  wait 1;
  scripts\cp\maps\cp_sumpf\cp_sumpf_dig_site_discovery::show_breadcrumbs_quest();
  level thread fadetowhite(0.3);
  var_0 = _id_06FE::_id_6322();

  foreach(var_2 in var_0) {
    var_2 _meth_81FA();
  }

  level notify("complete_shooting_gallery");
  level thread play_defend_the_radio_tower_fail_vo();
  level.a_disabled_score_event = undefined;
  level._id_A52A = 0;
  wait 1;
  level.mdl_barrel _meth_82CB("s4_zm_dg2_components_drop_01");
  wait 2;
  _id_0737::_id_C266("wwq_barrel_drop_loc", undefined, ::on_interact_drop_barrel, undefined);
  level._id_835D["wwq_barrel_drop_loc"] = &"CP_SUMPF/WWQ_COLLECT_BARREL";
  level.mdl_barrel thread show_hide_outline();
  wait 2;
  scripts\engine\utility::_id_5C1B("round_spawn_zombies");
  level scripts\engine\utility::_id_5C04("disallow_rbz_exfil");
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

on_interact_drop_barrel(var_0, var_1) {
  scripts\cp\utility::_id_B8EF("zmb_ww_barrel_pickup", var_0.origin);
  var_1 _meth_827A("cp_zm_s2_mq_shield_rumble", var_1.origin);
  level scripts\engine\utility::_id_5C1B("wwq_barrel_in_hand");
  level.mdl_barrel delete();
  _id_0737::_id_C3C5(var_0);
}

add_radio_tower_marker() {
  var_0 = spawnStruct();
  var_0._id_E747 = "current";
  var_0.label = &"CP_SUMPF/WWQ_DEFEND_RADIO_TOWER";
  var_0._id_96CF = self.origin;
  var_0._id_7C3B = "v_ui_icons_zombies_minimap_objective";
  var_0.minimapiconsize = "icon_regular";
  var_0.setbackground = 0;
  var_0.showsdistance = 1;
  self.objective_marker_index = _id_0987::_id_0FFD("wwq_radio_tower_marker", var_0);
  self.objective_param = var_0;
}

cleanup_marker() {
  _id_0987::_id_C413("wwq_radio_tower_marker", self.objective_marker_index);
  waitframe();
  self.objective_marker_index = undefined;
}

check_free_attacking_locations() {
  var_0 = 1;

  for(var_1 = 0; var_1 < level.a_ai_zombies_attacking_radio_tower.size; var_1++) {
    if(istrue(level.a_ai_zombies_attacking_radio_tower[var_1].b_is_sacrificing)) {
      var_0 = 0;
      return var_0;
    }
  }

  return var_0;
}

main_thunder_fx_watcher() {
  level endon("game_ended");
  level endon("wwq_step_two_is_done");
  level endon("wwq_win_defend");
  level endon("wwq_lose_defend");
  var_0 = getent("wwq_radio_tower_mdl", "script_noteworthy");
  var_1 = scripts\cp\utility::_id_E190("tag_origin", var_0.origin, var_0.angles + (0, 30, 0));
  var_1 thread play_radio_tower_ambient_fx();

  for(;;) {
    playFX(level._effect["wwq_thunder_striker_fx"], level.s_radio_tower.origin);
    playFX(level._effect["wwq_thunder_hit_radio_fx"], var_1.origin);
    scripts\cp\utility::_id_B8EF("zmb_ww_lightning_strike", level.s_radio_tower.origin);
    level.s_radio_tower play_rumble_and_screenshake_to_players(500);
    var_2 = randomintrange(8, 16);
    wait(var_2);
  }
}

play_radio_tower_ambient_fx() {
  level endon("game_ended");
  level endon("wwq_step_two_is_done");
  wait 0.5;
  playFXOnTag(level._effect["wwq_thunder_hit_radio_lp_fx"], self, "tag_origin");
  level scripts\engine\utility::_id_10897("wwq_win_defend", "wwq_lose_defend");
  stopFXOnTag(level._effect["wwq_thunder_hit_radio_lp_fx"], self, "tag_origin");
  self delete();
}

sub_thunder_fx_watcher() {
  level endon("game_ended");
  level endon("wwq_step_two_is_done");
  level endon("wwq_win_defend");
  level endon("wwq_lose_defend");
  var_0 = scripts\engine\utility::getstructarray("wwq_sub_thunder_loc", "script_noteworthy");

  for(;;) {
    var_1 = var_0[randomint(var_0.size)];
    playFX(level._effect["wwq_thunder_striker_fx"], var_1.origin);
    scripts\cp\utility::_id_B8EF("zmb_ww_lightning_strike", var_1.origin);
    var_1 play_rumble_and_screenshake_to_players(500);
    var_2 = randomintrange(3, 10);
    wait(var_2);
  }
}

buzz_sound_watcher() {
  level endon("game_ended");
  level endon("wwq_step_two_is_done");
  self endon("death");
  self playLoopSound("zmb_ww_radio_buzz_lp");
  level scripts\engine\utility::_id_10897("wwq_win_defend", "wwq_lose_defend");
  self stoploopsound("zmb_ww_radio_buzz_lp");
}

charged_sound_watcher() {
  level endon("game_ended");
  level endon("wwq_step_two_is_done");
  self endon("death");
  self playLoopSound("zmb_ww_radio_charged_lp");
}

thunder_ambient_sound(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  level endon("wwq_step_two_is_done");

  if(isDefined(var_3)) {
    level endon(var_3);
  }

  if(isDefined(var_4)) {
    level endon(var_4);
  }

  var_5 = 0;

  for(;;) {
    var_6 = randomint(700);
    var_7 = randomint(700);
    var_8 = level.s_radio_tower.origin + (var_6, var_7, 0);
    scripts\cp\utility::_id_B8EF(var_0, var_8);
    var_5 = randomintrange(var_1, var_2);
    wait(var_5);
  }
}

check_players_get_close_to_second_vacuum() {
  level endon("game_ended");
  level endon("wwq_second_tube_collected");
  level endon("wwq_win_defend");

  for(;;) {
    foreach(var_1 in level.players) {
      if(isDefined(var_1) && isDefined(level.s_tube_02_loc) && distancesquared(var_1.origin, level.s_tube_02_loc.origin) < 2500 && var_1 is_look_at(level.s_tube_02_loc, 60)) {
        level thread _id_0720::play_narration(["zm_cpm4_wws4_blkr_wgg1", "zm_cpm4_wws4_blkr_wgg2", "zm_cpm4_wws4_blkr_wgg3"], 1, 0);
        return;
      }
    }

    waitframe();
  }
}

play_interact_with_tube_02_vo() {
  level endon("game_ended");
  var_0 = ["zm_cpm4_wws4_vlst_wgha", "zm_cpm4_wws4_krft_wghb"];
  var_1 = ["zm_cpm4_wws4_vlst_wghc", "zm_cpm4_wws4_krft_wghd"];
  var_2 = ["zm_cpm4_wws4_vlst_wghe", "zm_cpm4_wws4_krft_wghf"];
  var_3 = scripts\engine\utility::random([var_0, var_1, var_2]);
  level thread _id_0720::play_narrations(var_3, 1, 0, "force_quit_current_dialogue");
}

play_pick_up_barrel_vo() {
  level endon("game_ended");
  level thread _id_0720::play_narration(["zm_cpm4_wws4_blkr_wgi1", "zm_cpm4_wws4_blkr_wgi2", "zm_cpm4_wws4_blkr_wgi3"], 1, 0);
}

play_insert_barrel_vo() {
  level endon("game_ended");

  if(!level scripts\engine\utility::_id_5C00("insert_barrel_vo_played")) {
    level scripts\engine\utility::_id_5C1B("insert_barrel_vo_played");
    var_0 = ["zm_cpm4_wws4_vlst_wgja", "zm_cpm4_wws4_krft_wgjb"];
    var_1 = ["zm_cpm4_wws4_vlst_wgjc", "zm_cpm4_wws4_krft_wgjd"];
    var_2 = ["zm_cpm4_wws4_vlst_wgje", "zm_cpm4_wws4_krft_wgjf"];
    var_3 = scripts\engine\utility::random([var_0, var_1, var_2]);
    level thread _id_0720::play_narrations(var_3, 1, 0, "force_quit_current_dialogue");
  }
}

play_defend_the_radio_tower_kickoff_vo() {
  level endon("game_ended");

  if(!level scripts\engine\utility::_id_5C00("defend_radio_tower_kickoff_vo_played")) {
    level scripts\engine\utility::_id_5C1B("defend_radio_tower_kickoff_vo_played");
    level thread _id_0720::play_narration(["zm_cpm4_wws4_vlst_wgk1", "zm_cpm4_wws4_vlst_wgk2", "zm_cpm4_wws4_vlst_wgk3"], 1, 0);
  }
}

play_defend_the_radio_tower_success_vo() {
  level endon("game_ended");
  var_0 = ["zm_cpm4_wws4_krft_wgla", "zm_cpm4_wws4_blkr_wglb"];
  var_1 = ["zm_cpm4_wws4_krft_wglc", "zm_cpm4_wws4_blkr_wgld"];
  var_2 = ["zm_cpm4_wws4_krft_wgle", "zm_cpm4_wws4_blkr_wglf"];
  var_3 = scripts\engine\utility::random([var_0, var_1, var_2]);
  level thread _id_0720::play_narrations(var_3, 1, 0, "force_quit_current_dialogue");
}

play_defend_the_radio_tower_fail_vo() {
  level endon("game_ended");
  var_0 = ["zm_cpm4_wws4_vlst_wgma", "zm_cpm4_wws4_krft_wgmb"];
  var_1 = ["zm_cpm4_wws4_vlst_wgmc", "zm_cpm4_wws4_krft_wgmd"];
  var_2 = ["zm_cpm4_wws4_vlst_wgme", "zm_cpm4_wws4_krft_wgmf"];
  var_3 = scripts\engine\utility::random([var_0, var_1, var_2]);
  level thread _id_0720::play_narrations(var_3, 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");
  level thread _id_0720::play_event_vo_from_selected_players("ally_confirmation", level.players, 1);
}

hint_interaction_tube_03(var_0, var_1) {
  if(level scripts\engine\utility::_id_5C00("wwq_tesla_charged")) {
    return &"CP_SUMPF/WWQ_COLLECT_TUBE";
  } else {
    return "";
  }
}

on_interact_tube_03(var_0, var_1) {
  if(level scripts\engine\utility::_id_5C00("wwq_tesla_charged")) {
    scripts\cp\utility::_id_B8EF("zmb_ww_tube_pickup", var_0.origin);
    var_1 _meth_827A("cp_zm_s2_mq_shield_rumble", var_1.origin);
    var_0.mdl_tube notify("death");
    var_0.mdl_tube _meth_86BE();
    level scripts\engine\utility::_id_5C1B("wwq_third_tube_collected");
    spawn_ww_parts_on_workbench("wwq_tube_03_workbench_loc", "s4_zm_dg2_components_tube", 1);
    _id_0737::_id_C3C5(var_0);
  }
}

tesla_device_dmg_watcher() {
  level endon("game_ended");
  level endon("wwq_step_two_is_done");
  level endon("wwq_tesla_charged_done");
  var_0 = getent("wwq_tesla_device", "script_noteworthy");
  var_1 = scripts\cp\utility::_id_E190("tag_origin", var_0.origin);

  for(;;) {
    self.t_dmg waittill("damage", var_2, var_3);

    if(scripts\engine\utility::is_equal(var_3._id_110B0, "trickster")) {
      level.n_tesla_charge_times++;
      level thread play_tesla_coil_charge_vo();
      scripts\cp\utility::_id_B8EF("zmb_ww_coil_charge_imp", level.s_tube_03_loc.mdl_tube.origin);
      var_1 play_charged_ambient_fx();

      if(level.n_tesla_charge_times >= 5) {
        scripts\cp\utility::_id_B8EF("zmb_ww_coil_charge_complete", level.s_tube_03_loc.mdl_tube.origin);
        level.s_tube_03_loc.mdl_tube setscriptablepartstate("fx", "playfx");
        level thread play_tesla_coil_charge_finish_vo();
        level scripts\engine\utility::_id_5C1B("wwq_tesla_charged");
        level notify("wwq_tesla_charged_done");
      }
    }

    wait 0;
  }
}

play_charged_ambient_fx() {
  if(level.n_tesla_charge_times > 5) {
    return;
  }
  switch (level.n_tesla_charge_times) {
    case 1:
      playFX(level._effect["wwq_tesla_charge_amb_fx_01"], self.origin);
      playFX(level._effect["wwq_tesla_charge_indicator_fx_01"], self.origin);
      break;
    case 2:
      playFX(level._effect["wwq_tesla_charge_amb_fx_02"], self.origin);
      playFX(level._effect["wwq_tesla_charge_indicator_fx_02"], self.origin);
      break;
    case 3:
      playFX(level._effect["wwq_tesla_charge_amb_fx_03"], self.origin);
      playFX(level._effect["wwq_tesla_charge_indicator_fx_03"], self.origin);
      break;
    case 4:
      playFX(level._effect["wwq_tesla_charge_amb_fx_04"], self.origin);
      playFX(level._effect["wwq_tesla_charge_indicator_fx_04"], self.origin);
      break;
    case 5:
      playFX(level._effect["wwq_tesla_charge_amb_fx_05"], self.origin);
      playFX(level._effect["wwq_tesla_charge_indicator_fx_05"], self.origin);
      break;
  }
}

check_players_get_close_to_third_vacuum() {
  level endon("game_ended");
  level endon("wwq_third_tube_collected");
  level endon("tesla_coil_charge_vo_played");
  level endon("wwq_tesla_charged_done");

  for(;;) {
    foreach(var_1 in level.players) {
      if(isDefined(var_1) && isDefined(level.s_tube_03_loc.mdl_tube) && distancesquared(var_1.origin, level.s_tube_03_loc.mdl_tube.origin) < 2500 && var_1 is_look_at(level.s_tube_03_loc.mdl_tube, 60)) {
        var_2 = ["zm_cpm4_wws4_blkr_wgna", "zm_cpm4_wws4_vrcn_wgnb"];
        var_3 = ["zm_cpm4_wws4_blkr_wgnc", "zm_cpm4_wws4_vrcn_wgnd"];
        var_4 = ["zm_cpm4_wws4_blkr_wgne", "zm_cpm4_wws4_vrcn_wgnf"];
        var_5 = scripts\engine\utility::random([var_2, var_3, var_4]);
        level thread _id_0720::play_narrations(var_5, 1, 0, "force_quit_current_dialogue");
        return;
      }
    }

    wait 1;
  }
}

play_tesla_coil_charge_vo() {
  level endon("game_ended");

  if(!level scripts\engine\utility::_id_5C00("tesla_coil_charge_vo_played")) {
    level scripts\engine\utility::_id_5C1B("tesla_coil_charge_vo_played");
    level thread _id_0720::play_narration(["zm_cpm4_wws4_blkr_wgo1", "zm_cpm4_wws4_blkr_wgo2", "zm_cpm4_wws4_blkr_wgo3"], 1, 0);
  }
}

play_tesla_coil_charge_finish_vo() {
  level endon("game_ended");

  if(istrue(level._id_493C)) {
    level waittill("dialogue_finished");
  }

  level thread _id_0720::play_narration(["zm_cpm4_wws4_blkr_wgp1", "zm_cpm4_wws4_blkr_wgp2", "zm_cpm4_wws4_blkr_wgp3"], 1, 0);
  level waittill("dialogue_finished");
  level thread _id_0720::play_event_vo_from_selected_players("ally_confirmation", level.players, 1);
}

init_step_three_assemble() {
  level.s_dg2_loc = scripts\engine\utility::getstruct("wwq_DG2_loc", "script_noteworthy");
}

do_step_three_soul_assemble() {
  level waittill("wwq_crafting_is_done");
}

cleanup_step_three_assemble() {
  scripts\engine\utility::_id_1BA4(level.a_e_ww_parts);
}

debug_step_three_assemble() {}

hint_type_workbench(var_0, var_1) {
  if(level scripts\engine\utility::_id_5C00("wwq_first_tube_collected") && level scripts\engine\utility::_id_5C00("wwq_second_tube_collected") && level scripts\engine\utility::_id_5C00("wwq_third_tube_collected")) {
    return "HINT_NOBUTTON";
  }

  return "HINT_NOICON";
}

ww_crafting_watcher(var_0) {
  level endon("game_ended");
  level endon("wwq_step_three_is_done");
  level endon("wwq_crafting_is_done");
  level endon("wwq_crafting_is_interrupted");
  self endon("death");
  var_1 = 0;

  for(;;) {
    if(isDefined(var_0.user) && !scripts\engine\utility::is_equal(var_0.user, self)) {
      return;
    }
    if(isDefined(self) && distancesquared(self.origin, var_0.origin) > 6400) {
      return;
    }
    if(self usebuttonpressed()) {
      if(!level scripts\engine\utility::_id_5C00("craft_btn_in_use")) {
        level scripts\engine\utility::_id_5C1B("craft_btn_in_use");
        var_0.user = self;
        var_2 = scripts\cp\utility::_id_E190("tag_origin", var_0.origin);
        var_2 thread craft_sound_watcher();
        thread craft_rumble_watcher();
        _id_0987::set_dg2_center_bar_state(1);
        _id_06E5::_id_D12B("shino_wwq_crafting_DG_2", "freezecontrols", 1);
        level thread play_assemble_dg2_vo();
      }

      var_1 = var_1 + 1.5;
      thread _id_0987::set_dg2_center_bar_progress(var_1 / 100);

      if(var_1 >= 100) {
        _id_06E5::_id_C5F9("shino_wwq_crafting_DG_2", "freezecontrols");
        _id_0987::set_dg2_center_bar_state(0);
        _id_0737::_id_C3C5(var_0);
        _id_0737::_id_C1A2();
        level thread drop_first_ww();
        level thread dg2_pickup_listener();
        scripts\cp\utility::_id_B8EF("zmb_craft_end_success", var_0.origin);
        var_0.user = undefined;
        level notify("wwq_crafting_is_done");
      }
    } else if(scripts\engine\utility::_id_5C00("craft_btn_in_use")) {
      _id_0737::_id_C1A2();
      _id_06E5::_id_C5F9("shino_wwq_crafting_DG_2", "freezecontrols");
      _id_0987::set_dg2_center_bar_state(0);
      scripts\cp\utility::_id_B8EF("zmb_craft_end_fail", var_0.origin);
      level scripts\engine\utility::_id_5C04("craft_btn_in_use");
      var_0.user = undefined;
      level notify("wwq_crafting_is_interrupted");
    }

    waitframe();
  }
}

drop_first_ww() {
  level endon("game_ended");
  _id_0737::_id_C266("wwq_workbench_loc", ::hint_interaction_dg2, ::on_interact_dg2);
  var_0 = scripts\cp\cp_weapon::buildweapon("s4_ar_tgun_mp");
  var_1 = scripts\cp\utility::_id_E190("tag_origin", level.s_dg2_loc.origin, level.s_dg2_loc.angles);
  var_2 = _id_092E::_id_E24D(var_0, level.s_dg2_loc.origin, level.s_dg2_loc.angles, undefined, undefined, 0, 1);
  var_2 setscriptablepartstate(var_2.type, "tgun_visible");
  var_2 _meth_8746(var_1);
  var_1 thread start_bobbing();
  playFX(level._effect["wwq_craft_complete_fx"], level.s_dg2_loc.origin + (0, 0, -13), anglesToForward(level.s_dg2_loc.angles + (0, 0, 90)));
  level waittill("pickup_dg2");
  var_2 _meth_86BE();
  var_1 delete();
}

hint_interaction_dg2(var_0, var_1) {
  return &"CP_SUMPF/PICK_UP_DG2";
}

on_interact_dg2(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.player = var_1;
  var_2.origin = var_0.origin;
  var_2.triggeringweapon = "s4_ar_tgun_mp";
  _id_0932::drop_relevant_weapon(var_2);
  var_3 = scripts\cp\cp_weapon::buildweapon("s4_ar_tgun_mp");
  var_1 giveweapon(var_3);
  var_1 switchtoweapon(var_3);
  var_1 thread player_disconnect_or_death_drop_dg2_watcher();
  var_1 thread has_dg2_check();
  _id_0737::_id_C3C5(var_0);
  level notify("pickup_dg2");
  var_1 _id_0720::queue_weapon_pickup_dialogue(var_2.triggeringweapon);
}

player_disconnect_or_death_drop_dg2_watcher() {
  level endon("game_ended");
  level endon("step_seven_is_done");
  self endon("kill_dg2_drop_thread");
  self waittill("death_or_disconnect");
  level thread drop_dg2_check(self);
}

player_death_drop_dg2_watcher() {
  level endon("game_ended");
  level endon("step_seven_is_done");
  self waittill("death");

  if(isDefined(self)) {
    level thread drop_dg2_check(self);
  }
}

has_dg2_check() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  for(var_0 = 1; var_0 || istrue(_id_073B::_id_B4EF(self)); var_0 = scripts\cp\utility::riotshield_hasweaponname("s4_ar_tgun_mp")) {
    wait 0.1;
  }

  waitframe();
  self notify("kill_dg2_drop_thread");
}

drop_dg2_check(var_0) {
  var_1 = 0;
  var_2 = (0, 0, 0);

  foreach(var_4 in level.players) {
    if(var_4 scripts\cp\utility::riotshield_hasweaponname("s4_ar_tgun_mp")) {
      var_1++;
    }
  }

  if(var_1 >= 1) {
    return;
  }
  var_6 = undefined;

  if(isDefined(var_0)) {
    var_2 = var_0.origin;
    var_6 = var_0;
  } else {
    foreach(var_4 in level.players) {
      if(var_4 scripts\cp\utility::_id_8708()) {
        var_2 = var_4.origin;
        break;
      }
    }
  }

  if(scripts\engine\utility::_id_5C00("in_saraxis_final_fight")) {
    var_9 = get_dg2_dropped_pap_level(var_6, var_0);
    var_10 = scripts\cp\cp_weapon::buildweapon("s4_ar_tgun_mp", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_9);
    var_11 = _id_092E::_id_E24D(var_10, var_2 + (0, 0, 8), undefined, undefined, var_9, 1, 1);
    var_11 thread time_out_listener();
  } else if(!scripts\engine\utility::_id_5C00("finish_shino_mq")) {
    var_9 = get_dg2_dropped_pap_level(var_6, var_0);
    var_10 = scripts\cp\cp_weapon::buildweapon("s4_ar_tgun_mp", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_9);
    var_11 = _id_092E::_id_E24D(var_10, var_2 + (0, 0, 8), undefined, undefined, var_9, 1);
    var_11 thread item_cleanup_listener();
  } else {}
}

get_dg2_dropped_pap_level(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_0)) {
    var_0.dropped_dg2 = 1;
    var_2 = var_0 scripts\cp\cp_weapon::_id_683D("s4_ar_tgun_mp") - 1;
  } else if(isDefined(var_1._id_AE0A) && isDefined(var_1._id_AE0A["tgun"]) && isDefined(var_1._id_AE0A["tgun"]._id_991E))
    var_2 = var_1._id_AE0A["tgun"]._id_991E - 1;
  else {
    var_2 = 0;
  }

  return var_2;
}

time_out_listener() {
  level endon("game_ended");
  self endon("death");
  level scripts\engine\utility::_id_5C24("finish_shino_mq");
  _id_092E::_id_4745(self, 180);
}

item_cleanup_listener() {
  level endon("game_ended");
  self waittill("time_out_cleanup");
  level thread drop_first_ww();
}

dg2_pickup_listener() {
  level endon("game_ended");
  level endon("finish_shino_mq");

  for(;;) {
    level waittill("weapon_picked_up", var_0, var_1, var_2);

    if(var_0.basename == "s4_ar_tgun_mp") {
      var_2 thread player_disconnect_or_death_drop_dg2_watcher();
      var_2 thread has_dg2_check();
    }
  }
}

start_bobbing() {
  level endon("game_ended");
  self endon("death");
  var_0 = 5;

  for(;;) {
    self movez(var_0, 3);
    self waittill("movedone");
    var_0 = var_0 * -1;
  }
}

craft_sound_watcher() {
  level endon("game_ended");
  level endon("wwq_step_three_is_done");
  self endon("death");
  self playLoopSound("zmb_craft_lp");
  level scripts\engine\utility::_id_10897("wwq_crafting_is_done", "wwq_crafting_is_interrupted");
  self stoploopsound("zmb_craft_lp");
  self delete();
}

craft_rumble_watcher() {
  level endon("game_ended");
  level endon("wwq_step_three_is_done");
  self endon("death");
  level endon("wwq_crafting_is_done");
  level endon("wwq_crafting_is_interrupted");

  for(;;) {
    self _meth_827A("cp_zm_s2_mq_shield_rumble", self.origin);
    wait 0.5;
  }
}

play_assemble_dg2_vo() {
  level endon("game_ended");

  if(!level scripts\engine\utility::_id_5C00("assemble_dg2_vo_played")) {
    level scripts\engine\utility::_id_5C1B("assemble_dg2_vo_played");
    var_0 = ["zm_cpm4_wws4_vlst_wgqa", "zm_cpm4_wws4_krft_wgqb"];
    var_1 = ["zm_cpm4_wws4_vlst_wgqc", "zm_cpm4_wws4_krft_wgqd"];
    var_2 = ["zm_cpm4_wws4_vlst_wgqe", "zm_cpm4_wws4_krft_wgqf"];
    var_3 = scripts\engine\utility::random([var_0, var_1, var_2]);
    level thread _id_0720::play_narrations(var_3, 1, 0, "force_quit_current_dialogue");
  }
}

play_rumble_and_screenshake_to_players(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2)) {
      var_3 = distance2dsquared(self.origin, var_2.origin);
      var_4 = var_0 * var_0;

      if(var_3 <= var_0 * var_0) {
        var_2 earthquakeforplayer(0.5, 1, var_2.origin, 100);
        var_2 _meth_827A("cp_zm_s2_mq_shield_rumble", var_2.origin);
      }
    }
  }
}

is_look_at(var_0, var_1) {
  var_2 = 0;
  var_3 = vectortoangles(var_0.origin - self getEye());

  if(isDefined(var_3)) {
    var_4 = self getplayerangles();
    var_2 = _func_000C(var_4, var_3);
  }

  if(var_2 <= var_1) {
    return 1;
  } else {
    return 0;
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

        if(var_3 <= _func_0219(150) && !istrue(var_0)) {
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