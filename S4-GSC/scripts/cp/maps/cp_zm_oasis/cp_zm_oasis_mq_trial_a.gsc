/******************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_a.gsc
******************************************************************/

trial_a_init() {
  level._effect["oasis_mq_trial_of_mindfulness_glowing_orb_fx"] = loadfx("vfx/s4/zombie/vfx_energy_orb_runner_r_sm.vfx");
  level._effect["oasis_mq_trial_of_mindfulness_glowing_orb_spawn"] = loadfx("vfx/s4/zombie/vfx_energy_orb_spawn_r.vfx");
  level._effect["oasis_mq_trial_of_mindfulness_obelisk_idle"] = loadfx("vfx/s4/zombie/vfx_obj_sin_eater_obelisk_idle.vfx");
  level._effect["oasis_mq_trial_of_mindfulness_orb_charge"] = loadfx("vfx/s4/zombie/vfx_obelisk_energy_charge_r.vfx");
  level._effect["oasis_mq_trial_of_mindfulness_rune_idle"] = loadfx("vfx/s4/zombie/vfx_obj_domination_rune_idle.vfx");
  level._effect["oasis_mq_trial_of_mindfulness_rune_captured"] = loadfx("vfx/s4/zombie/vfx_obj_domination_rune_captured.vfx");
  level._effect["oasis_mq_cleanup_zombie_explosion"] = loadfx("vfx/s4/zombie/vfx_dome_clean");
  level._effect["oasis_mq_trial_if_mindfulness_totem_symbol_a"] = loadfx("vfx/s4/zombie/vfx_zm_totem_idle_a");
  level._effect["oasis_mq_trial_if_mindfulness_totem_symbol_b"] = loadfx("vfx/s4/zombie/vfx_zm_totem_idle_b");
  level._effect["oasis_mq_trial_if_mindfulness_totem_symbol_c"] = loadfx("vfx/s4/zombie/vfx_zm_totem_idle_c");
  level._effect["oasis_mq_trial_if_mindfulness_totem_symbol_d"] = loadfx("vfx/s4/zombie/vfx_zm_totem_idle_d");
  level._effect["oasis_mq_trial_if_mindfulness_totem_symbol_e"] = loadfx("vfx/s4/zombie/vfx_zm_totem_idle_e");
  level._effect["oasis_mq_trial_if_mindfulness_totem_symbol_f"] = loadfx("vfx/s4/zombie/vfx_zm_totem_idle_f");
  level._effect["oasis_mq_trial_if_mindfulness_totem_symbol_g"] = loadfx("vfx/s4/zombie/vfx_zm_totem_idle_g");
  level._effect["oasis_mq_trial_if_mindfulness_totem_symbol_h"] = loadfx("vfx/s4/zombie/vfx_zm_totem_idle_h");
  level._effect["oasis_mq_trial_if_mindfulness_totem_symbol_i"] = loadfx("vfx/s4/zombie/vfx_zm_totem_idle_i");
  level._effect["oasis_mq_trial_if_mindfulness_totem_symbol_j"] = loadfx("vfx/s4/zombie/vfx_zm_totem_idle_j");
  level._effect["oasis_mq_trial_if_mindfulness_totem_symbol_k"] = loadfx("vfx/s4/zombie/vfx_zm_totem_idle_k");
  level._effect["oasis_mq_trial_if_mindfulness_totem_symbol_l"] = loadfx("vfx/s4/zombie/vfx_zm_totem_idle_l");
  level._effect["oasis_mq_trial_if_mindfulness_totem_symbol_m"] = loadfx("vfx/s4/zombie/vfx_zm_totem_idle_m");
  level._effect["oasis_mq_trial_if_mindfulness_totem_symbol_n"] = loadfx("vfx/s4/zombie/vfx_zm_totem_idle_n");
  level._effect["oasis_mq_trial_if_mindfulness_totem_symbol_o"] = loadfx("vfx/s4/zombie/vfx_zm_totem_idle_o");
  level._effect["oasis_mq_trial_if_mindfulness_totem_symbol_a_sm"] = loadfx("vfx/s4/zombie/vfx_zm_totem_idle_runner_a_sm");
  level._effect["oasis_mq_trial_if_mindfulness_totem_symbol_b_sm"] = loadfx("vfx/s4/zombie/vfx_zm_totem_idle_runner_b_sm");
  level._effect["oasis_mq_trial_if_mindfulness_totem_symbol_c_sm"] = loadfx("vfx/s4/zombie/vfx_zm_totem_idle_runner_c_sm");
  level._effect["oasis_mq_trial_if_mindfulness_totem_symbol_d_sm"] = loadfx("vfx/s4/zombie/vfx_zm_totem_idle_runner_d_sm");
  level._effect["oasis_mq_trial_if_mindfulness_totem_symbol_e_sm"] = loadfx("vfx/s4/zombie/vfx_zm_totem_idle_runner_e_sm");
  level._effect["oasis_mq_trial_if_mindfulness_totem_symbol_f_sm"] = loadfx("vfx/s4/zombie/vfx_zm_totem_idle_runner_f_sm");
  level._effect["oasis_mq_trial_if_mindfulness_totem_symbol_g_sm"] = loadfx("vfx/s4/zombie/vfx_zm_totem_idle_runner_g_sm");
  level._effect["oasis_mq_trial_if_mindfulness_totem_symbol_h_sm"] = loadfx("vfx/s4/zombie/vfx_zm_totem_idle_runner_h_sm");
  level._effect["oasis_mq_trial_if_mindfulness_totem_symbol_i_sm"] = loadfx("vfx/s4/zombie/vfx_zm_totem_idle_runner_i_sm");
  level._effect["oasis_mq_trial_if_mindfulness_totem_symbol_j_sm"] = loadfx("vfx/s4/zombie/vfx_zm_totem_idle_runner_j_sm");
  level._effect["oasis_mq_trial_if_mindfulness_totem_symbol_k_sm"] = loadfx("vfx/s4/zombie/vfx_zm_totem_idle_runner_k_sm");
  level._effect["oasis_mq_trial_if_mindfulness_totem_symbol_l_sm"] = loadfx("vfx/s4/zombie/vfx_zm_totem_idle_runner_l_sm");
  level._effect["oasis_mq_trial_if_mindfulness_totem_symbol_m_sm"] = loadfx("vfx/s4/zombie/vfx_zm_totem_idle_runner_m_sm");
  level._effect["oasis_mq_trial_if_mindfulness_totem_symbol_n_sm"] = loadfx("vfx/s4/zombie/vfx_zm_totem_idle_runner_n_sm");
  level._effect["oasis_mq_trial_if_mindfulness_totem_symbol_o_sm"] = loadfx("vfx/s4/zombie/vfx_zm_totem_idle_runner_o_sm");
  level.a_totem_symbol = ["oasis_mq_trial_if_mindfulness_totem_symbol_a", "oasis_mq_trial_if_mindfulness_totem_symbol_b", "oasis_mq_trial_if_mindfulness_totem_symbol_c", "oasis_mq_trial_if_mindfulness_totem_symbol_d", "oasis_mq_trial_if_mindfulness_totem_symbol_e", "oasis_mq_trial_if_mindfulness_totem_symbol_f", "oasis_mq_trial_if_mindfulness_totem_symbol_g", "oasis_mq_trial_if_mindfulness_totem_symbol_h", "oasis_mq_trial_if_mindfulness_totem_symbol_i", "oasis_mq_trial_if_mindfulness_totem_symbol_j", "oasis_mq_trial_if_mindfulness_totem_symbol_k", "oasis_mq_trial_if_mindfulness_totem_symbol_l", "oasis_mq_trial_if_mindfulness_totem_symbol_m", "oasis_mq_trial_if_mindfulness_totem_symbol_n", "oasis_mq_trial_if_mindfulness_totem_symbol_o"];
  level.b_trial_of_mindfulness_obelisk_is_ready = 0;
  level.trial_gauntlet_out_of_area_hint = int(_func_0222("cp/cp_hints.csv", 1, "turn_back", 0));
  level.trial_of_mindfulness_area_volume = getent("trial_a_challenge_volume", "script_noteworthy");
  level thread trial_a_kick_off();
}

trial_a_kick_off() {
  level endon("game_ended");
  init_charging_obelisk();
  level waittill("trial_of_mindfulness_charging_finished");
}

init_charging_obelisk() {
  level endon("game_ended");
  level.trial_of_mindfulness_obelisk = scripts\engine\utility::getstruct("obelisk_trial_of_mindfulness", "script_noteworthy");

  if(!isDefined(level.trial_of_mindfulness_obelisk)) {
    return;
  }
  level.trial_of_mindfulness_obelisk.mdl = _id_06EF::_id_E1E5(level.trial_of_mindfulness_obelisk, "s4_zm_sin_eater_obelisk_01", 0);
  waitframe();
  level.trial_of_mindfulness_obelisk.mdl playLoopSound("zmb_obelisk_base_lp");
  playFXOnTag(level._effect["oasis_mq_trial_of_mindfulness_obelisk_idle"], level.trial_of_mindfulness_obelisk.mdl, "tag_origin");
  level.trial_of_mindfulness_obelisk.mdl thread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::obelisk_model_bob(6, 4, 0, 0, 1);
  trial_a_oblesik_clip(1);
  level.trial_of_mindfulness_orb = scripts\engine\utility::getstruct("orb_trial_of_mindfulness_loc", "script_noteworthy");

  if(!isDefined(level.trial_of_mindfulness_orb)) {
    return;
  }
  level.trial_of_mindfulness_charging_phase = 0;
  level.trial_of_mindfulness_orb._id_832C = scripts\engine\utility::getstruct("orb_trial_of_mindfulness_trigger", "script_noteworthy");

  if(!isDefined(level.trial_of_mindfulness_orb._id_832C)) {
    return;
  }
  level.a_trial_of_mindfulness_rune_symbols = scripts\engine\utility::getstructarray("symbol_rune_trial_of_mindfulness", "script_noteworthy");
  waitframe();
  level.a_trial_of_mindfulness_rune_symbols = scripts\engine\utility::array_randomize(level.a_trial_of_mindfulness_rune_symbols);
  handle_dig_out_orb();
  level thread play_close_to_obelisk_vo_monitor();
}

handle_dig_out_orb() {
  _id_0737::_id_C266("trial_of_mindfulness_digging_loc", ::hint_interact_dig_pile, ::on_interact_dig_pile, ::init_dig_piles);
  _id_0737::addinteractionhinttypecallback("trial_of_mindfulness_digging_loc", ::trial_a_dig_pile_hint_type);
}

init_dig_piles(var_0) {
  var_1 = scripts\engine\utility::array_randomize(var_0);
  var_2 = var_1[0];
  var_2.mdl = scripts\cp\utility::_id_E190("s4_zm_dust_pile", var_2.origin, var_2.angles);
  var_2._id_605B = scripts\cp\utility::_id_E190("tag_origin", var_2.origin, var_2.angles);
  playFXOnTag(scripts\engine\utility::getfx("dig_site_dust_fx"), var_2._id_605B, "tag_origin");

  for(var_3 = 1; var_3 < var_1.size; var_3++) {
    _id_0737::_id_C3C5(var_1[var_3]);
  }
}

hint_interact_dig_pile(var_0, var_1) {
  if(!istrue(var_1.b_got_shovel)) {
    return "";
  } else {
    return &"CP_SKORPION/DIG_SOID";
  }
}

trial_a_dig_pile_hint_type(var_0, var_1) {
  if(!istrue(var_1.b_got_shovel)) {
    return "HINT_NOBUTTON";
  }

  return "HINT_NOICON";
}

on_interact_dig_pile(var_0, var_1) {
  if(!istrue(var_1.b_got_shovel)) {
    return;
  }
  stopFXOnTag(scripts\engine\utility::getfx("dig_site_dust_fx"), var_0._id_605B, "tag_origin");
  scripts\cp\utility::_id_B8ED(var_0.origin, "zmb_dig");
  playFX(scripts\engine\utility::getfx("fx_dig_dust"), var_0.origin + (0, 0, 5), anglesToForward(var_0.angles + (0, 0, 90)), anglestoup(var_0.angles));
  level thread play_script_mover(var_0);
  level thread dig_out_orb(var_0.origin, var_0.angles);
  _id_0737::_id_C3C5(var_0);
}

play_script_mover(var_0) {
  level endon("game_ended");

  if(isDefined(var_0.mdl)) {
    var_0.mdl moveto(var_0.mdl.origin - (0, 0, 30), 1);
  }

  var_0.mdl waittill("movedone");
  var_0.mdl delete();
}

dig_out_orb(var_0, var_1) {
  level endon("game_ended");
  level.trial_of_mindfulness_orb._id_605B = scripts\cp\utility::_id_E190("tag_origin", var_0, var_1);
  waitframe();
  playFXOnTag(level._effect["oasis_mq_trial_of_mindfulness_glowing_orb_spawn"], level.trial_of_mindfulness_orb._id_605B, "tag_origin");
  level.trial_of_mindfulness_orb._id_605B playSound("zmb_trail_orb_spawn");
  level.trial_of_mindfulness_orb._id_605B playLoopSound("zmb_trial_orb_lp");
  playFXOnTag(level._effect["oasis_mq_trial_of_mindfulness_glowing_orb_fx"], level.trial_of_mindfulness_orb._id_605B, "tag_origin");
  level.trial_of_mindfulness_orb._id_605B moveto(level.trial_of_mindfulness_orb.origin, 3);
  level.trial_of_mindfulness_orb._id_605B waittill("movedone");
  wait 1;

  if(level scripts\engine\utility::_id_5C00("trial_a_intro_vo_is_in_queue")) {
    level scripts\engine\utility::_id_5C36("trial_a_intro_vo_is_in_queue", 70);
  }

  level thread play_vo_to_affected_players("zm_cpm5_mqs5_dnrt_qikc", undefined, "trial_of_mindfulness_orb_vo_playing");
  level thread arrange_clear_flag(20, "trial_of_mindfulness_orb_vo_playing");
  _id_0737::_id_C266(level.trial_of_mindfulness_orb._id_832C._id_039B, ::hint_interact_orb, ::on_interact_orb, ::init_interact_orb);
}

arrange_clear_flag(var_0, var_1) {
  level endon("game_ended");

  if(isDefined(var_0)) {
    wait(var_0);
  }

  if(isDefined(var_1) && level scripts\engine\utility::_id_5C00(var_1)) {
    level scripts\engine\utility::_id_5C04(var_1);
  }
}

hint_interact_orb(var_0, var_1) {
  if(istrue(level.b_trial_of_mindfulness_is_charging_obelisk) || level scripts\engine\utility::_id_5C00("start_rbz_exfil") || level scripts\engine\utility::_id_5C00("trial_of_mindfulness_orb_vo_playing") || isDefined(var_1.active_curse)) {
    return "";
  } else {
    return &"CP_ZM_OASIS/TRIAL_OF_MINDFULNESS_START_CHARGING";
  }
}

on_interact_orb(var_0, var_1) {
  if(istrue(level.b_trial_of_mindfulness_is_charging_obelisk) || level scripts\engine\utility::_id_5C00("start_rbz_exfil") || level scripts\engine\utility::_id_5C00("trial_of_mindfulness_orb_vo_playing") || isDefined(var_1.active_curse)) {
    return;
  }
  level.b_trial_of_mindfulness_is_charging_obelisk = 1;
  level.trial_of_mindfulness_charging_phase++;
  var_2 = (0, 0, 20);
  var_0.hint_image_location._id_605B = scripts\cp\utility::_id_E190("tag_origin", var_0.hint_image_location.origin + var_2, var_0.hint_image_location.angles);
  var_3 = 0;

  switch (level.trial_of_mindfulness_charging_phase) {
    case 1:
      var_3 = 3;
      break;
    case 2:
      var_3 = 4;
      break;
    case 3:
      var_3 = 5;
      break;
    default:
      break;
  }

  if(!isDefined(level.current_random_totem_symbol_sequence)) {
    var_4 = scripts\engine\utility::array_randomize(level.a_totem_symbol);

    if(var_3 > var_4.size) {
      return;
    }
    for(var_5 = 0; var_5 < 6; var_5++) {
      level.current_random_totem_symbol_sequence[var_5] = var_4[var_5];
    }
  }

  level thread play_vo_to_affected_players(["zm_cpm5_mqs5_dnrt_qikd", "zm_cpm5_mqs5_dnrt_qike", "zm_cpm5_mqs5_dnrt_qikf", "zm_cpm5_mqs5_dnrt_qikg", "zm_cpm5_mqs5_dnrt_qikh", "zm_cpm5_mqs5_dnrt_qiki"]);
  var_0 thread show_hint_image_sequence(level.current_random_totem_symbol_sequence, var_3);
}

show_hint_image_sequence(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  level endon("start_rbz_exfil");

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = "_sm";
    var_4 = scripts\engine\utility::getfx(var_0[var_2] + var_3);
    playFXOnTag(var_4, self.hint_image_location._id_605B, "tag_origin");
    scripts\cp\utility::_id_B8ED(self.hint_image_location._id_605B.origin, "zmb_trial_rune_appear");
    wait 2;
    _func_012F(var_4, self.hint_image_location._id_605B, "tag_origin");
  }

  self.hint_image_location._id_605B delete();
  wait 0.5;
  level thread check_rune_symbol_capture_sequence(var_0, var_1);
  level thread play_vo_to_affected_players(["zm_cpm5_mqs5_dnrt_qikl", "zm_cpm5_mqs5_dnrt_qikm", "zm_cpm5_mqs5_dnrt_qikn", "zm_cpm5_mqs5_dnrt_qiko"]);
  show_rune_symbols(var_0);
  level thread exit_capture_rune_monitor();
}

check_rune_symbol_capture_sequence(var_0, var_1) {
  level endon("game_ended");
  level endon("trial_of_mindfulness_rune_capture_time_expired");
  level thread rune_capture_time_monitor();
  _func_0343();
  _id_06CB::_id_AA4A(::no_corpse_on_ai_killed_in_trial_area);

  for(var_2 = 0; var_2 < var_1; var_2++) {
    level waittill("trial_of_mindfulness_rune_captured");

    if(!isDefined(level.trial_of_mindfulness_last_rune_captured) || level.trial_of_mindfulness_last_rune_captured != var_0[var_2]) {
      level notify("trial_of_mindfulness_rune_capture_fail");
      clear_rune_symbols(level.a_trial_of_mindfulness_rune_symbols);
      reset_trial(0);
      level thread play_vo_to_affected_players(["zm_cpm5_mqs5_vlst_qikp", "zm_cpm5_mqs5_vlst_qikq", "zm_cpm5_mqs5_vlst_qikr", "zm_cpm5_mqs5_vlst_qiks", "zm_cpm5_mqs5_vlst_qikt", "zm_cpm5_mqs5_vlst_qiku"]);
      return;
    }
  }

  level notify("trial_of_mindfulness_rune_capture_success");
  reset_trial(1);
  clear_rune_symbols(level.a_trial_of_mindfulness_rune_symbols);
  level thread play_vo_to_affected_players(["zm_cpm5_mqs5_dnrt_qikv", "zm_cpm5_mqs5_dnrt_qikw", "zm_cpm5_mqs5_dnrt_qikx", "zm_cpm5_mqs5_dnrt_qiky", "zm_cpm5_mqs5_dnrt_qikz", "zm_cpm5_mqs5_dnrt_qik1"]);
  wait 0.5;
  level thread random_gauntlet_challenge_kickoff(level.trial_of_mindfulness_last_rune_captured_by);
}

no_corpse_on_ai_killed_in_trial_area(var_0) {
  if(isDefined(level.a_trial_of_mindfulness_rune_symbols)) {
    foreach(var_2 in level.a_trial_of_mindfulness_rune_symbols) {
      if(isDefined(var_2._id_04ED) && distance2dsquared(self.origin, var_2.origin) < 14400) {
        self._id_A546 = 1;
        return;
      }
    }
  }
}

clear_all_players_timer() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1)) {
      var_1 scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_gauntlet::clear_timer();
    }
  }
}

rune_capture_time_monitor() {
  level endon("game_ended");
  level endon("trial_of_mindfulness_rune_capture_success");
  level endon("trial_of_mindfulness_rune_capture_fail");
  var_0 = [60, 60, 60];

  if(!isDefined(level.trial_of_mindfulness_charging_phase) || level.trial_of_mindfulness_charging_phase > var_0.size || level.trial_of_mindfulness_charging_phase < 1) {
    return;
  }
  foreach(var_2 in level.players) {
    if(isPlayer(var_2) && !isDefined(var_2._id_F245) && !isDefined(var_2.active_curse)) {
      var_2 scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_gauntlet::create_timer(30, -50, var_0[level.trial_of_mindfulness_charging_phase - 1]);

      if(!isDefined(var_2.trial_a_rune_symbol_capture_hint)) {
        var_2.trial_a_rune_symbol_capture_hint = var_2 scripts\cp\utility::createfontstring("default", 1);
        var_2.trial_a_rune_symbol_capture_hint scripts\cp\utility::setpoint("LEFT", undefined, 12, -90);
        var_2.trial_a_rune_symbol_capture_hint.color = (1, 1, 1);
        var_2.trial_a_rune_symbol_capture_hint settext(&"CP_ZM_OASIS/TRIAL_OF_MINDFULNESS_COMPLETE_SEQUENCE");
        var_2.trial_a_rune_symbol_capture_hint.alpha = 1;
      }

      var_2 thread clear_ui_when_pick_up_cursed_item();
    }
  }

  wait(var_0[level.trial_of_mindfulness_charging_phase - 1]);
  clear_rune_symbols(level.a_trial_of_mindfulness_rune_symbols);
  reset_trial(0);
  level thread play_vo_to_affected_players(["zm_cpm5_mqs5_vlst_qikp", "zm_cpm5_mqs5_vlst_qikq", "zm_cpm5_mqs5_vlst_qikr", "zm_cpm5_mqs5_vlst_qiks", "zm_cpm5_mqs5_vlst_qikt", "zm_cpm5_mqs5_vlst_qiku"]);
  level notify("trial_of_mindfulness_rune_capture_time_expired");
}

clear_ui_when_pick_up_cursed_item() {
  level endon("game_ended");
  level endon("trial_of_mindfulness_rune_capture_success");
  level endon("trial_of_mindfulness_rune_capture_fail");
  self waittill("active_curse");

  if(isDefined(self)) {
    if(isDefined(self.trial_a_rune_symbol_capture_hint)) {
      self.trial_a_rune_symbol_capture_hint fadeovertime(0.15);
      self.trial_a_rune_symbol_capture_hint.alpha = 0;
      self.trial_a_rune_symbol_capture_hint scripts\cp\utility::destroyelem();
    }

    scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_gauntlet::clear_timer();
  }
}

exit_capture_rune_monitor() {
  level endon("game_ended");
  level endon("trial_of_mindfulness_rune_capture_success");
  level endon("trial_of_mindfulness_rune_capture_fail");
  level endon("trial_of_mindfulness_rune_capture_time_expired");
  level scripts\engine\utility::_id_5C27("disallow_rbz_exfil", "start_rbz_exfil");
  clear_rune_symbols(level.a_trial_of_mindfulness_rune_symbols);
  reset_trial(0);
  level notify("trial_of_mindfulness_rune_capture_fail");
}

show_rune_symbols(var_0) {
  level endon("game_ended");

  if(!isDefined(level.a_trial_of_mindfulness_rune_symbols)) {
    return;
  }
  if(level.a_trial_of_mindfulness_rune_symbols.size < var_0.size || !isDefined(var_0) || !_func_0107(var_0)) {
    return;
  }
  for(var_1 = 0; var_1 < level.a_trial_of_mindfulness_rune_symbols.size; var_1++) {
    if(var_1 >= var_0.size) {
      break;
    }

    level.a_trial_of_mindfulness_rune_symbols[var_1].symbol_fx_name = var_0[var_1];
    level.a_trial_of_mindfulness_rune_symbols[var_1]._id_2958 = spawn("trigger_radius", level.a_trial_of_mindfulness_rune_symbols[var_1].origin, 0, 55, 55);
    level.a_trial_of_mindfulness_rune_symbols[var_1] show_rune();
    level.a_trial_of_mindfulness_rune_symbols[var_1] thread rune_update();
    waitframe();
  }
}

rune_update() {
  level endon("game_ended");
  var_0 = 0.05;
  var_1 = var_0;
  self.dominationduration = 0;

  for(;;) {
    if(!isDefined(self._id_2958)) {
      break;
    }

    self.players = [];

    foreach(var_3 in level.players) {
      if(var_3 istouching(self._id_2958) && isalive(var_3) && !istrue(var_3.inlaststand) && !isDefined(var_3.active_curse)) {
        self.players[self.players.size] = var_3;

        if(!isDefined(var_3.currentrune)) {
          var_3 playlocalsound("zmb_cap_progress_bar");
        }

        var_3.currentrune = self;
        continue;
      }

      if(isDefined(var_3.currentrune)) {
        if((!var_3 istouching(var_3.currentrune._id_2958) || !isalive(var_3) || istrue(var_3.inlaststand)) && istrue(var_3.iscapturinguion)) {
          hide_capturing_ui(var_3);
          var_3.currentrune = undefined;
        }
      }
    }

    if(self.players.size > 0) {
      var_5 = var_1;

      if(level.players.size > 1) {
        var_6 = (self.players.size - 1) / (level.players.size - 1);
        var_5 = var_1 + var_1 * 0.6 * var_6;
      }

      self.dominationduration = self.dominationduration + var_5;
      rune_capturing_update();

      if(self.dominationduration >= 4) {
        on_captured_rune();
        break;
      }
    } else if(self.dominationduration > 0) {
      self.dominationduration = self.dominationduration - var_0;
      on_exit_rune();
    }

    wait(var_0);
  }
}

on_exit_rune() {
  if(isDefined(self.dominationduration) && self.dominationduration > 0) {
    foreach(var_1 in level.players) {
      if(scripts\engine\utility::is_equal(var_1.currentrune, self)) {
        hide_capturing_ui(var_1);
      }
    }

    return;
  }

  foreach(var_1 in level.players) {
    if(scripts\engine\utility::is_equal(var_1.currentrune, self)) {
      hide_capturing_ui(var_1);
      var_1.currentrune = undefined;
      self.dominationduration = 0;
    }
  }
}

on_captured_rune() {
  var_0 = undefined;

  if(istrue(self.b_is_trial_of_mindfulness_final_challenge_rune)) {
    level.n_trial_of_mindfulness_challenge_rune_captured++;
    challenge_rune_capture_progress_check();
  }

  level.trial_of_mindfulness_last_rune_captured = self.symbol_fx_name;
  level.trial_of_mindfulness_last_rune_captured_by = [];

  foreach(var_2 in level.players) {
    if(scripts\engine\utility::is_equal(var_2.currentrune, self)) {
      level.trial_of_mindfulness_last_rune_captured_by[level.trial_of_mindfulness_last_rune_captured_by.size] = var_2;
    }
  }

  scripts\cp\utility::_id_B8ED(self.origin, "zmb_trial_rune_capture");
  var_0 = "oasis_mq_trial_of_mindfulness_rune_captured";
  cleanup_rune(var_0);
  level notify("trial_of_mindfulness_rune_captured");
}

rune_capturing_update() {
  if(!isDefined(self.players)) {
    return;
  }
  show_rune_capturing_ui();
}

show_rune_capturing_ui() {
  if(!isDefined(self.previous_capture_percentage) || !isDefined(self.current_capture_percentage)) {
    self.previous_capture_percentage = get_rune_percentage();
  } else {
    self.previous_capture_percentage = self.current_capture_percentage;
  }

  self.current_capture_percentage = get_rune_percentage();

  foreach(var_1 in level.players) {
    if(scripts\engine\utility::is_equal(var_1.currentrune, self)) {
      if(!istrue(var_1.iscapturinguion)) {
        var_1 _id_0987::set_center_bar_state(1);
        var_1.iscapturinguion = 1;
      }

      var_1 thread _id_0987::set_center_bar_progress(self.current_capture_percentage / 100);
    }
  }
}

get_rune_percentage() {
  var_0 = int(self.dominationduration * 100 / 4);
  return var_0;
}

hide_capturing_ui(var_0) {
  var_0 _meth_83EF("zmb_cap_progress_bar");
  var_0.b_disable_player_intersection_tracker = undefined;

  if(istrue(var_0.iscapturinguion)) {
    var_0 thread _id_0987::set_center_bar_state(0);
    var_0 thread _id_0987::set_center_bar_progress(0);
    var_0.iscapturinguion = 0;
  }
}

cleanup_rune(var_0) {
  if(!isDefined(self._id_2958)) {
    return;
  }
  foreach(var_2 in self.players) {
    var_2 _meth_83EF("zmb_cap_progress_bar");
  }

  foreach(var_2 in level.players) {
    if(scripts\engine\utility::is_equal(var_2.currentrune, self)) {
      hide_capturing_ui(var_2);
      var_2.iscapturingrunecluster = undefined;
      var_2.currentrune = undefined;
      var_2.iscapturinguion = undefined;
      var_2.dominationzombierunecluster = undefined;
    }
  }

  self.players = undefined;
  self._id_2958 delete();
  self._id_2958 = undefined;
  self.dominationduration = 0;

  if(isDefined(self.mdl)) {
    self.mdl delete();
  }

  if(isDefined(self.floating_visual)) {
    _func_0130(self.floating_visual);
    self.floating_visual delete();
    self.floating_visual = undefined;
  }

  if(isDefined(self._id_04ED)) {
    thread hide_rune(var_0);
  }
}

hide_rune(var_0) {
  if(isDefined(self.capturingfx)) {
    _func_012F(scripts\engine\utility::getfx(self.capturingfx), self._id_04ED, "tag_origin");
  }

  if(isDefined(var_0)) {
    switch (var_0) {
      case "oasis_mq_trial_of_mindfulness_rune_captured":
        self._id_04ED stoploopsound("zmb_cap_rune_lp");
        self._id_04ED playSound("zmb_cap_rune_capped");
        var_1 = scripts\engine\utility::getfx(var_0);
        playFXOnTag(var_1, self._id_04ED, "tag_origin");
        wait 0.3;

        if(isDefined(self.symbol_fx_name)) {
          _func_012F(scripts\engine\utility::getfx(self.symbol_fx_name), self._id_04ED, "tag_origin");
        } else {
          _func_012F(scripts\engine\utility::getfx("oasis_mq_trial_of_mindfulness_rune_idle"), self._id_04ED, "tag_origin");
        }

        wait 1;
        _func_012F(var_1, self._id_04ED, "tag_origin");
        break;
      default:
        break;
    }
  }

  if(isDefined(self._id_04ED)) {
    _func_0130(self._id_04ED);
    self._id_04ED delete();
    self._id_04ED = undefined;
  }
}

clear_rune_symbols(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_2 in var_0) {
    if(isDefined(var_2.mdl) || isDefined(var_2._id_04ED)) {
      var_2 thread cleanup_rune();
    }
  }

  var_0 = undefined;
}

init_interact_orb(var_0) {
  foreach(var_2 in var_0) {
    var_2.hint_image_location = scripts\engine\utility::getstruct("symbol_hint_trial_of_mindfulness_loc", "script_noteworthy");

    if(!isDefined(var_2.hint_image_location)) {
      return;
    }
    if(isDefined(var_2._id_0359)) {
      var_2._id_425E = var_2._id_0359;
      continue;
    }

    var_2._id_425E = 80;
  }
}

reset_trial(var_0) {
  _id_06CB::_id_C417(::no_corpse_on_ai_killed_in_trial_area);
  clear_all_players_timer();
  level thread clear_gauntlet_zombies();

  foreach(var_2 in level.players) {
    if(isDefined(var_2) && isDefined(var_2.trial_a_rune_symbol_capture_hint)) {
      var_2.trial_a_rune_symbol_capture_hint fadeovertime(0.15);
      var_2.trial_a_rune_symbol_capture_hint.alpha = 0;
      var_2.trial_a_rune_symbol_capture_hint scripts\cp\utility::destroyelem();
    }
  }

  if(!istrue(var_0) && level.trial_of_mindfulness_charging_phase > 0) {
    level thread enable_trial_in_next_round();
    level.trial_of_mindfulness_charging_phase--;
  }
}

enable_trial_in_next_round() {
  level endon("game_ended");
  level waittill("round_start");
  level.b_trial_of_mindfulness_is_charging_obelisk = 0;
}

random_gauntlet_challenge_kickoff(var_0) {
  level endon("game_ended");
  level endon("gauntlet_fail");
  level thread play_vo_to_affected_players(["zm_cpm5_mqs5_vlst_qila", "zm_cpm5_mqs5_vlst_qilb", "zm_cpm5_mqs5_vlst_qilc", "zm_cpm5_mqs5_vlst_qild", "zm_cpm5_mqs5_vlst_qile", "zm_cpm5_mqs5_vlst_qilf"], var_0);
  var_1 = ["damage_during_movement", "kill_enemies_for_health", "disable_health_regen", "enemies_do_double_damage", "only_regen_when_prone", "take_no_damage", "headshot_only", "use_given_pistol_only"];

  if(isDefined(level.previous_gauntlet)) {
    var_1 = scripts\engine\utility::array_remove(var_1, level.previous_gauntlet);
  }

  var_2 = scripts\engine\utility::array_random(var_1);
  level.previous_gauntlet = var_2;

  if(!scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_gauntlet::begin_gauntlet(var_0, var_2, 60)) {
    return;
  }
  var_3 = !scripts\engine\utility::is_equal(var_2, "take_no_damage");
  level thread set_spawn_zombie_during_gauntlet(var_0, var_3);
  level thread gauntlet_challenge_player_go_away_monitor(var_0, var_2);
  level thread gauntlet_fail_listner(var_0);
  level scripts\engine\utility::_id_108A7(60, "gauntlet_finish");
  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_gauntlet::end_gauntlet(var_0);
  level thread clear_gauntlet_zombies();
  level notify("gauntlet_finish");

  if(scripts\engine\utility::is_equal(level.trial_of_mindfulness_charging_phase, 3)) {
    level thread do_charging_obelisk();
    level thread play_vo_to_affected_players(["zm_cpm5_mqs5_krft_qils", "zm_cpm5_mqs5_krft_qilt", "zm_cpm5_mqs5_krft_qilu", "zm_cpm5_mqs5_krft_qilv", "zm_cpm5_mqs5_krft_qilw", "zm_cpm5_mqs5_krft_qilx"]);
  } else
    level thread play_vo_to_affected_players(["zm_cpm5_mqs5_vlst_qilm", "zm_cpm5_mqs5_vlst_qiln", "zm_cpm5_mqs5_vlst_qilo", "zm_cpm5_mqs5_vlst_qilp", "zm_cpm5_mqs5_vlst_qilq", "zm_cpm5_mqs5_vlst_qilr"]);

  level.a_trial_of_mindfulness_rune_symbols = scripts\engine\utility::array_randomize(level.a_trial_of_mindfulness_rune_symbols);
  level.current_random_totem_symbol_sequence = undefined;
  level.b_trial_of_mindfulness_is_charging_obelisk = 0;
}

set_spawn_zombie_during_gauntlet(var_0, var_1) {
  var_2 = scripts\engine\utility::getstructarray("trial_of_mindfulness_agent_spawn", "targetname");
  var_3 = level.players.size;
  var_4 = [3, 3, 2, 1];
  var_5 = [4, 6, 8, 12];
  level thread spawn_zombie_gauntlet("base", "enemy_base_zombie_cp", var_4[var_3 - 1], var_5[var_3 - 1], var_2, var_0);

  if(var_1) {
    var_6 = [3, 3, 2, 2];
    var_7 = [1, 2, 3, 3];
    level thread spawn_zombie_gauntlet("screamer", "enemy_zombie_screamer_cp", var_6[var_3 - 1], var_7[var_3 - 1], var_2, var_0);
  }
}

spawn_zombie_gauntlet(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  level endon("gauntlet_finish");
  level endon("gauntlet_fail");
  var_6 = 0;

  for(;;) {
    if(get_alive_gauntlet_zombies_count(var_0) < var_3) {
      var_7 = scripts\engine\utility::array_random(var_4);
      var_8 = _id_09A4::_id_110AD(var_1, var_7.origin, var_7.angles, var_7);
      var_6++;
      waitframe();

      if(isDefined(var_8) && isalive(var_8)) {
        var_8.spawned_in_gauntlet = 1;
        var_8.brain_rot_immune = 1;
        var_8._id_4A75 = 1;
        var_8._id_A52A = 1;
        var_8.on_zombie_killed_score_override_func = scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_root::on_zombie_killed_give_no_score;
        var_9 = [];

        foreach(var_11 in var_5) {
          if(isalive(var_11) && !istrue(var_11.inlaststand)) {
            var_9[var_9.size] = var_11;
          }
        }

        if(var_9.size > 0) {
          var_13 = var_5[var_6 % var_5.size];

          if(isPlayer(var_13)) {
            var_8._id_01BD = var_13;
          }
        }

        if(scripts\engine\utility::is_equal(var_0, "base")) {
          if(level._id_11049 < 20) {
            var_8 thread wait_and_set_move_mode(0.5);
            var_8.maxhealth = 1230;
            var_8.health = 1230;
          }
        }

        var_8 thread wait_and_set_zombie_fx(0.5);
      }
    }

    wait(var_2);
  }
}

clear_gauntlet_zombies() {
  level endon("game_ended");
  var_0 = _id_06FE::_id_6322();
  var_1 = [];

  foreach(var_3 in var_0) {
    if(istrue(var_3.spawned_in_gauntlet)) {
      var_3._id_5FF5 = 1;
      var_4 = scripts\engine\utility::ter_op(var_3 tagexists("j_spinelower"), "j_spinelower", "tag_origin");
      playFXOnTag(scripts\engine\utility::getfx("powerup_nuke_zombie_fire"), var_3, var_4);
      var_1[var_1.size] = var_3;
      var_3 _id_0B05::_id_D602("walk");
    }
  }

  _id_0746::_id_B8F1("zmb_trial_clear_zombies");

  for(var_6 = 0; var_6 < var_1.size; var_6++) {
    wait(randomfloatrange(0.1, 0.3));

    if(!isalive(var_1[var_6])) {
      continue;
    }
    var_1[var_6] _meth_81FA();
  }
}

get_alive_gauntlet_zombies_count(var_0) {
  var_1 = 0;
  var_2 = _id_06FE::_id_6322();

  foreach(var_4 in var_2) {
    if(scripts\engine\utility::is_equal(var_4._id_110B0, var_0) && istrue(var_4.spawned_in_gauntlet)) {
      var_1++;
    }
  }

  return var_1;
}

quit_scripte_mode_after_reach_goal() {
  level endon("game_ended");
  self endon("death");
  self waittill("goal");
  self._id_CF4A = 0;
  self._id_0229 = 0;
}

gauntlet_challenge_player_go_away_monitor(var_0, var_1) {
  level endon("game_ended");
  level endon("gauntlet_finish");
  level endon("gauntlet_fail");

  for(;;) {
    var_2 = 0;

    foreach(var_4 in var_0) {
      if(isPlayer(var_4) && isalive(var_4) && scripts\engine\utility::is_equal(var_4.activate_gauntlet, var_1)) {
        var_5 = distance2dsquared(var_4.origin, level.trial_of_mindfulness_obelisk.origin);

        if(var_5 > 490000) {
          if(isDefined(level.trial_gauntlet_out_of_area_hint) && var_4 _meth_876E("zm_hint_index") != level.trial_gauntlet_out_of_area_hint) {
            var_4 thread show_gauntlet_out_of_area_hint();
          }
        }

        if(var_5 < 1000000) {
          var_2 = 1;
          break;
        } else {
          scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_gauntlet::end_gauntlet([var_4]);
          play_vo_to_affected_players(["zm_cpm5_mqs5_krft_qilg", "zm_cpm5_mqs5_krft_qilh", "zm_cpm5_mqs5_krft_qili", "zm_cpm5_mqs5_krft_qilj", "zm_cpm5_mqs5_krft_qilk", "zm_cpm5_mqs5_krft_qill"], [var_4]);
        }
      }
    }

    if(!var_2) {
      level notify("gauntlet_fail");
    }

    waitframe();
  }
}

show_gauntlet_out_of_area_hint() {
  level endon("game_ended");
  level endon("gauntlet_finish");
  level endon("gauntlet_fail");
  self endon("death");

  if(!isDefined(level.trial_gauntlet_out_of_area_hint)) {
    return;
  }
  self setclientomnvar("zm_hint_index", level.trial_gauntlet_out_of_area_hint);

  while(distance2dsquared(self.origin, level.trial_of_mindfulness_obelisk.origin) > 490000) {
    wait 1;
  }

  if(isDefined(level.trial_gauntlet_out_of_area_hint) && self _meth_876E("zm_hint_index") == level.trial_gauntlet_out_of_area_hint) {
    self setclientomnvar("zm_hint_index", 0);
  }
}

gauntlet_fail_listner(var_0) {
  level endon("game_ended");
  level endon("gauntlet_finish");
  level scripts\engine\utility::waittill_any_2("gauntlet_fail", "start_rbz_exfil");
  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_gauntlet::end_gauntlet(var_0);
  reset_trial(0);
}

do_charging_obelisk() {
  level endon("game_ended");
  _id_0737::_id_C4AB(level.trial_of_mindfulness_orb._id_832C._id_039B);
  var_0 = 3;
  var_1 = (0, 0, 120);
  level.trial_of_mindfulness_orb._id_605B moveto(level.trial_of_mindfulness_obelisk.origin + var_1, var_0);
  wait(var_0);
  playFXOnTag(level._effect["oasis_mq_trial_of_mindfulness_orb_charge"], level.trial_of_mindfulness_orb._id_605B, "tag_origin");
  scripts\cp\utility::_id_B8ED(level.trial_of_mindfulness_obelisk.origin + var_1, "zmb_trial_obelisk_lit_up");
  _id_0737::_id_C266("mq_trial_of_mindfulness_obelisk_trigger", ::hint_interact_obelisk, ::on_interact_obelisk, ::init_interact_obelisk);
  level.b_trial_of_mindfulness_obelisk_is_ready = 1;
}

hint_interact_obelisk(var_0, var_1) {
  if(!level scripts\engine\utility::_id_5C00("trial_of_mindfulness_challenge_is_cooling_down") && !level scripts\engine\utility::_id_5C00("trial_of_mindfulness_challenge_is_voting") && !scripts\engine\utility::_id_5C00("start_rbz_exfil")) {
    return &"CP_ZM_OASIS/TRIAL_OF_MINDFULNESS_ACTIVATE_CHALLENGE";
  }

  return "";
}

on_interact_obelisk(var_0, var_1) {
  if(!level scripts\engine\utility::_id_5C00("trial_of_mindfulness_challenge_is_cooling_down") && !level scripts\engine\utility::_id_5C00("trial_of_mindfulness_challenge_is_voting") && !scripts\engine\utility::_id_5C00("start_rbz_exfil")) {
    level scripts\engine\utility::_id_5C1B("trial_of_mindfulness_challenge_is_voting");
    _id_0746::_id_B8F1("zmb_obelisk_interact");
    var_2 = _id_0992::_id_106AF(var_1, 13, "trial of mindfulness challenge start failed");

    if(istrue(var_2)) {
      _id_0746::_id_B8F1("zmb_obelisk_activate");
      level thread trial_of_mindfulness_challenge_kickoff();
    }

    level scripts\engine\utility::_id_5C04("trial_of_mindfulness_challenge_is_voting");
  }
}

trial_of_mindfulness_challenge_kickoff() {
  level endon("game_ended");
  level thread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::pause_round_base_spawn();
  level scripts\engine\utility::_id_5C1B("disallow_rbz_exfil");
  level scripts\engine\utility::_id_5C1B("trial_of_mindfulness_challenge_is_cooling_down");
  _id_06CB::_id_AA49(::on_ai_damage_in_challenge);
  level.n_trial_of_mindfulness_challenge_rune_captured = 0;
  level.trial_of_mindfulness_damage_dealt = 0;
  trial_a_wall_block(1);
  var_0 = scripts\engine\utility::getstructarray("mq_trial_a_teleport_loc", "script_noteworthy");
  var_1 = 0;
  var_2 = [];

  foreach(var_4 in level.players) {
    if(!_func_011A(var_4.origin, level.trial_of_mindfulness_area_volume)) {
      level thread teleport_to_challenge_area(var_0, var_4);
      var_1 = 1;
      continue;
    }

    var_2[var_2.size] = var_4;
  }

  level.trial_of_mindfulness_challenge_phase = 1;

  if(var_1) {
    level waittill("player_arrived_at_challenge_area");
  } else {
    level thread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_papq::fadetowhite(0.5);
  }

  level notify("trial_challenge_begin");
  level thread show_challenge_hint_monitor();
  trial_of_mindfulness_challenge_begin();
}

teleport_to_challenge_area(var_0, var_1) {
  var_1._id_0E05 = 1;
  _id_098A::warp_sepcific_player(var_0, var_1);
  var_1._id_0E05 = undefined;
  playFX(scripts\engine\utility::getfx("outofmap_teleport"), var_1.origin);
  level notify("player_arrived_at_challenge_area");
}

trial_a_oblesik_clip(var_0) {
  var_1 = getent("mq_trial_of_mindfulness_obelisk_clip", "script_noteworthy");

  if(istrue(var_0)) {
    var_1 show();
    var_1 solid();
    var_1 _meth_80B5();
  } else {
    var_1 hide();
    var_1 notsolid();
    var_1 _meth_8093();
  }
}

trial_a_wall_block(var_0) {
  var_1 = getEntArray("mq_trial_a_zone_barricade", "script_noteworthy");
  var_2 = getEntArray("mq_trial_a_path_clip", "script_noteworthy");

  if(istrue(var_0)) {
    scripts\engine\utility::_id_1B98(var_1, ::show);
    scripts\engine\utility::_id_1B98(var_2, ::solid);
    scripts\engine\utility::_id_1B98(var_2, ::_meth_80B5);
  } else {
    scripts\engine\utility::_id_1B98(var_1, ::hide);
    scripts\engine\utility::_id_1B98(var_2, ::notsolid);
    scripts\engine\utility::_id_1B98(var_2, ::_meth_8093);
  }
}

init_interact_obelisk(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_0359)) {
      var_2._id_425E = var_2._id_0359;
      continue;
    }

    var_2._id_425E = 80;
    wait 1;
  }
}

trial_of_mindfulness_challenge_begin() {
  set_challenge_zombie_spawn();
  set_challenge_rune_require_amount();
  var_0 = [90, 90];

  if(!isDefined(level.trial_of_mindfulness_challenge_phase) || level.trial_of_mindfulness_challenge_phase > var_0.size || level.trial_of_mindfulness_challenge_phase < 1) {
    return;
  }
  level thread play_vo_to_affected_players(["zm_cpm5_mqs5_vlst_qima", "zm_cpm5_mqs5_vlst_qimb", "zm_cpm5_mqs5_vlst_qimc", "zm_cpm5_mqs5_vlst_qimd"]);
  _func_01E3("trial_battle");
  var_1 = var_0[level.trial_of_mindfulness_challenge_phase - 1];
  level thread trial_of_mindfulness_challenge_time_monitor(var_1);
  level thread show_challenge_counter_monitor(var_1);
  show_challenge_runes();
}

set_challenge_zombie_spawn() {
  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_root::disable_none_kill_score_event();
  var_0 = scripts\engine\utility::getstructarray("trial_of_mindfulness_agent_spawn", "targetname");
  var_1 = level.players.size;
  var_2 = [2, 2, 1, 1];
  var_3 = [5, 8, 12, 16];
  var_4 = [90, 60, 45, 30];
  var_5 = [1, 1, 1, 1];
  level thread spawn_challenge_zombie("base", "enemy_base_zombie_cp", var_2[var_1 - 1], var_3[var_1 - 1], var_0);
  level thread spawn_challenge_zombie("trickster", "enemy_zombie_trickster_cp", var_4[var_1 - 1], var_5[var_1 - 1], var_0);
}

spawn_challenge_zombie(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  level endon("trial_of_mindfulness_challenge_phase_finish");
  level endon("trial_of_mindfulness_challenge_fail");
  var_5 = 0;

  for(;;) {
    if(get_alive_gauntlet_zombies_count(var_0) < var_3) {
      var_6 = scripts\engine\utility::array_random(var_4);
      var_7 = _id_09A4::_id_110AD(var_1, var_6.origin, var_6.angles, var_6);
      var_5++;
      waitframe();

      if(isDefined(var_7) && isalive(var_7)) {
        var_7.spawned_in_gauntlet = 1;
        var_7.brain_rot_immune = 1;
        var_7._id_4A75 = 1;
        var_7._id_A52A = 1;
        var_7.b_ignore_cleanup = 1;
        var_7.on_zombie_killed_score_override_func = scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_root::on_zombie_killed_give_no_score;

        if(scripts\engine\utility::is_equal(var_0, "base")) {
          if(level._id_11049 < 20) {
            var_7 thread wait_and_set_move_mode(0.5);
            var_7.maxhealth = 1230;
            var_7.health = 1230;
          }
        }

        var_7 thread wait_and_set_zombie_fx(0.5);
      }
    }

    wait(var_2);
  }
}

wait_and_set_move_mode(var_0) {
  level endon("game_ended");
  self endon("death");

  if(!isDefined(var_0)) {
    var_0 = 0.5;
  }

  wait(var_0);

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self._id_D603)) {
    self thread[[self._id_D603]]("sprint");
  }
}

wait_and_set_zombie_fx(var_0) {
  level endon("game_ended");
  self endon("death");

  if(!isDefined(var_0)) {
    var_0 = 0.5;
  }

  wait(var_0);

  if(!isDefined(self)) {
    return;
  }
  playFXOnTag(level._effect["mq_extra_spawned_zombie"], self, "j_spine4");
}

show_challenge_runes() {
  level endon("game_ended");
  level.a_trial_of_mindfulness_challenge_runes = scripts\engine\utility::getstructarray("rune_trial_of_mindfulness", "script_noteworthy");
  waitframe();

  if(!isDefined(level.a_trial_of_mindfulness_challenge_runes)) {
    return;
  }
  foreach(var_1 in level.a_trial_of_mindfulness_challenge_runes) {
    var_1._id_2958 = spawn("trigger_radius", var_1.origin, 0, 55, 55);
    var_1.b_is_trial_of_mindfulness_final_challenge_rune = 1;
    var_1 show_rune();
    var_1 thread rune_update();
    waitframe();
  }
}

set_challenge_rune_require_amount() {
  if(!isDefined(level.player)) {
    return;
  }
  var_0 = [];

  switch (level.trial_of_mindfulness_challenge_phase) {
    case 1:
      var_0 = [6, 9, 12, 15];
      break;
    case 2:
      var_0 = [6, 9, 12, 15];
      break;
    default:
      var_0 = [6, 9, 12, 15];
      break;
  }

  var_1 = level.players.size;

  if(var_1 <= var_0.size && var_1 > 0) {
    level.n_trial_of_mindfulness_challenge_require_rune_amount = var_0[var_1 - 1];
  } else {
    level.n_trial_of_mindfulness_challenge_require_rune_amount = var_0[0];
  }
}

challenge_rune_capture_progress_check() {
  if(!isDefined(level.n_trial_of_mindfulness_challenge_rune_captured)) {
    return;
  }
  if(!isDefined(level.n_trial_of_mindfulness_challenge_require_rune_amount)) {
    switch (level.players.size) {
      case 1:
        level.n_trial_of_mindfulness_challenge_require_rune_amount = 6;
        break;
      case 2:
        level.n_trial_of_mindfulness_challenge_require_rune_amount = 9;
        break;
      case 3:
        level.n_trial_of_mindfulness_challenge_require_rune_amount = 12;
        break;
      case 4:
        level.n_trial_of_mindfulness_challenge_require_rune_amount = 15;
        break;
      default:
        level.n_trial_of_mindfulness_challenge_require_rune_amount = 6;
        break;
    }

    if(!isDefined(level.n_trial_of_mindfulness_challenge_require_rune_amount) || level.n_trial_of_mindfulness_challenge_require_rune_amount < 6) {
      level.n_trial_of_mindfulness_challenge_require_rune_amount = 6;
    }
  }

  level thread update_challenge_counter();

  if(level.n_trial_of_mindfulness_challenge_rune_captured >= level.n_trial_of_mindfulness_challenge_require_rune_amount) {
    level thread clear_challenge_counter();
    level notify("trial_of_mindfulness_challenge_phase_finish");
    clear_rune_symbols(level.a_trial_of_mindfulness_challenge_runes);
    spawn_rewards();

    if(level.trial_of_mindfulness_challenge_phase == 1) {
      level thread play_vo_to_affected_players(["zm_cpm5_mqs5_krft_qina", "zm_cpm5_mqs5_krft_qinb", "zm_cpm5_mqs5_krft_qinc", "zm_cpm5_mqs5_krft_qind"]);
      trail_a_finalize();
      return;
    }

    level thread prepare_next_challenge_phase();
  }
}

spawn_rewards() {
  if(!isDefined(level.trial_of_mindfulness_obelisk)) {
    return;
  }
  var_0 = (-50, 0, 0);
  var_1 = (50, 0, 0);
  var_2 = level.trial_of_mindfulness_obelisk.origin;
  var_3 = _func_02AB(var_2 + var_0);
  var_4 = _func_02AB(var_2 + var_1);
  level thread _id_0990::_id_E3DD("armor_repair", var_3);
  level thread _id_0990::_id_E3DD("bonus_points_team", var_4);
}

prepare_next_challenge_phase() {
  level endon("game_ended");
  trial_a_wall_block(0);

  if(isDefined(level.trial_of_mindfulness_obelisk)) {
    playFX(level._effect["oasis_mq_cleanup_zombie_explosion"], level.trial_of_mindfulness_obelisk.origin);
  }

  clear_alive_zombies();
  wait 10;
  level.n_trial_of_mindfulness_challenge_rune_captured = 0;
  var_0 = scripts\engine\utility::getstructarray("mq_trial_a_teleport_loc", "script_noteworthy");

  foreach(var_2 in level.players) {
    level thread teleport_to_challenge_area(var_0, var_2);
  }

  trial_a_wall_block(1);
  level.trial_of_mindfulness_challenge_phase++;
  level waittill("player_arrived_at_challenge_area");
  trial_of_mindfulness_challenge_begin();
}

show_rune() {
  level endon("game_ended");
  self._id_04ED = scripts\cp\utility::_id_E190("tag_origin", self.origin, self.angles);
  waitframe();

  if(istrue(self.b_is_trial_of_mindfulness_final_challenge_rune)) {
    playFXOnTag(level._effect["oasis_mq_trial_of_mindfulness_rune_idle"], self._id_04ED, "tag_origin");
  } else if(isDefined(level._effect[self.symbol_fx_name])) {
    playFXOnTag(level._effect[self.symbol_fx_name], self._id_04ED, "tag_origin");
  }

  if(!_func_0205("zmb_cap_rune_lp")) {
    return;
  }
  scripts\cp\utility::_id_B8ED(self.origin, "zmb_trial_rune_appear");
  self._id_04ED playLoopSound("zmb_cap_rune_lp", self._id_04ED.origin);
}

show_challenge_hint_monitor() {
  level endon("game_ended");
  level endon("mq_trial_a_done");
  level endon("mq_trial_of_mindfulness_hint_cleared");

  for(;;) {
    foreach(var_1 in level.players) {
      if(isDefined(var_1)) {
        if(!isDefined(var_1.trial_a_challenge_hint)) {
          var_1.trial_a_challenge_hint = var_1 scripts\cp\utility::createfontstring("default", 1);
          var_1.trial_a_challenge_hint scripts\cp\utility::setpoint("LEFT", undefined, 12, -90);
          var_1.trial_a_challenge_hint.color = (1, 1, 1);
          var_1.trial_a_challenge_hint settext(&"CP_ZM_OASIS/TRIAL_OF_MINDFULNESS_KILL_ZOMBIE_AMOUNT");
          var_1.trial_a_challenge_hint.alpha = 1;
        }

        if(!isDefined(var_1.trial_a_progress_bar)) {
          var_1.trial_a_progress_bar = var_1 create_bar_with_small_gap((1, 1, 1), 100, 10);
          var_1.trial_a_progress_bar scripts\cp\utility::setpoint("LEFT", undefined, 12, -80);
          var_2 = 5000 - level.trial_of_mindfulness_damage_dealt;

          if(var_2 < 0) {
            var_2 = 0;
          }

          var_1.trial_a_progress_bar scripts\cp\utility::_id_FC11(var_2 / 5000);
        }
      }
    }

    wait 1;
  }
}

clear_challenge_hint() {
  level notify("mq_trial_of_mindfulness_hint_cleared");

  foreach(var_1 in level.players) {
    if(isDefined(var_1)) {
      if(isDefined(var_1.trial_a_challenge_hint)) {
        var_1.trial_a_challenge_hint fadeovertime(0.15);
        var_1.trial_a_challenge_hint.alpha = 0;
        var_1.trial_a_challenge_hint scripts\cp\utility::destroyelem();
      }

      if(isDefined(var_1.trial_a_progress_bar)) {
        var_1.trial_a_progress_bar scripts\cp\utility::destroyelem();
      }
    }
  }
}

update_damage_bar() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1) && isDefined(var_1.trial_a_progress_bar)) {
      var_2 = 5000 - level.trial_of_mindfulness_damage_dealt;

      if(var_2 < 0) {
        var_2 = 0;
      }

      var_1.trial_a_progress_bar scripts\cp\utility::_id_FC11(var_2 / 5000);
    }
  }
}

trial_of_mindfulness_challenge_time_monitor(var_0) {
  level endon("game_ended");
  level endon("mq_trial_a_done");
  level endon("trial_of_mindfulness_challenge_fail");
  level endon("trial_of_mindfulness_challenge_phase_finish");
  wait(var_0);
  level thread trial_of_mindfulness_challenge_lost_sequence();
}

show_challenge_counter_monitor(var_0) {
  level endon("game_ended");
  level endon("mq_trial_a_done");
  level endon("mq_trial_of_mindfulness_counter_cleared");

  for(;;) {
    foreach(var_2 in level.players) {
      if(isDefined(var_2)) {
        if(!isDefined(var_2.trial_a_counter_bar)) {
          var_2.trial_a_counter_bar = var_2 create_bar_with_small_gap((1, 1, 1), 100, 10);
          var_2.trial_a_counter_bar scripts\cp\utility::setpoint("LEFT", undefined, 12, -50);

          if(isDefined(level.n_trial_of_mindfulness_challenge_rune_captured) && isDefined(level.n_trial_of_mindfulness_challenge_require_rune_amount)) {
            var_2.trial_a_counter_bar scripts\cp\utility::_id_FC11(level.n_trial_of_mindfulness_challenge_rune_captured / level.n_trial_of_mindfulness_challenge_require_rune_amount);
          }
        }

        if(!isDefined(var_2.trial_a_challenge_counter)) {
          var_2.trial_a_challenge_counter = var_2 scripts\cp\utility::createfontstring("default", 1);
          var_2.trial_a_challenge_counter scripts\cp\utility::setpoint("LEFT", undefined, 12, -60);
          var_2.trial_a_challenge_counter.color = (1, 1, 1);
          var_2.trial_a_challenge_counter settext(&"CP_ZM_OASIS/TRIAL_OF_MINDFULNESS_RUNE_COUNTER");
          var_2.trial_a_challenge_counter.alpha = 1;
        }

        if(!isDefined(var_2._id_F245)) {
          var_2 scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_gauntlet::create_timer(30, -30, var_0);
        }
      }
    }

    wait 1;
  }
}

update_challenge_counter() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1) && isDefined(var_1.trial_a_counter_bar) && isDefined(level.n_trial_of_mindfulness_challenge_require_rune_amount)) {
      var_1.trial_a_counter_bar scripts\cp\utility::_id_FC11(level.n_trial_of_mindfulness_challenge_rune_captured / level.n_trial_of_mindfulness_challenge_require_rune_amount);
    }
  }
}

clear_challenge_counter() {
  level notify("mq_trial_of_mindfulness_counter_cleared");

  foreach(var_1 in level.players) {
    if(isDefined(var_1)) {
      if(isDefined(var_1.trial_a_challenge_counter)) {
        var_1.trial_a_challenge_counter fadeovertime(0.15);
        var_1.trial_a_challenge_counter.alpha = 0;
        var_1.trial_a_challenge_counter scripts\cp\utility::destroyelem();
      }

      if(isDefined(var_1.trial_a_counter_bar)) {
        var_1.trial_a_counter_bar scripts\cp\utility::destroyelem();
      }

      var_1 scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_gauntlet::clear_timer();
    }
  }
}

trail_a_finalize() {
  trial_a_wall_block(0);
  _func_01E3("none");
  _id_0737::_id_C4AB("mq_trial_of_mindfulness_obelisk_trigger");
  level scripts\engine\utility::_id_5C04("trial_of_mindfulness_challenge_is_cooling_down");
  _id_06CB::_id_C416(::on_ai_damage_in_challenge);
  level thread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_papq::fadetowhite(0.6);
  clear_alive_zombies();
  clear_challenge_hint();

  if(isDefined(level.trial_of_mindfulness_orb)) {
    if(isDefined(level.trial_of_mindfulness_orb._id_605B)) {
      _func_0130(level.trial_of_mindfulness_orb._id_605B);
      level.trial_of_mindfulness_orb._id_605B stoploopsound();
      level.trial_of_mindfulness_orb._id_605B delete();
    }

    level.trial_of_mindfulness_orb = undefined;
  }

  if(isDefined(level.trial_of_mindfulness_obelisk.mdl)) {
    playFXOnTag(level._effect["mq_trial_obelisk_success"], level.trial_of_mindfulness_obelisk.mdl, "tag_origin");
  }

  if(isDefined(level.e_timer_sfx)) {
    level.e_timer_sfx delete();
  }

  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_root::enable_none_kill_score_event();
  level scripts\engine\utility::_id_5C1B("round_spawn_zombies");
  level scripts\engine\utility::_id_5C04("disallow_rbz_exfil");
  scripts\engine\utility::_id_5C1B("mq_trial_a_done");
}

on_ai_damage_in_challenge(var_0) {
  if(isPlayer(var_0._id_50FF)) {
    if(isDefined(var_0._id_7C8D)) {
      level.trial_of_mindfulness_damage_dealt = level.trial_of_mindfulness_damage_dealt + var_0._id_7C8D;
    }

    update_damage_bar();

    if(level.trial_of_mindfulness_damage_dealt >= 5000) {
      if(!istrue(level.is_in_trial_of_mindfulness_challenge_lost_sequence)) {
        level thread waitframe_and_trial_of_mindfulness_challenge_lost_sequence();
        level.is_in_trial_of_mindfulness_challenge_lost_sequence = 1;
      }
    }
  }
}

waitframe_and_trial_of_mindfulness_challenge_lost_sequence() {
  level endon("game_ended");
  waitframe();
  trial_of_mindfulness_challenge_lost_sequence();
}

trial_of_mindfulness_challenge_lost_sequence() {
  level thread enable_challenge_in_next_round();
  level notify("trial_of_mindfulness_challenge_fail");
  _id_06CB::_id_C416(::on_ai_damage_in_challenge);
  _func_01E3("none");
  level thread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_papq::fadetowhite(0.6);
  clear_alive_zombies();
  level thread play_vo_to_affected_players(["zm_cpm5_mqs5_vlst_qime", "zm_cpm5_mqs5_vlst_qimf", "zm_cpm5_mqs5_vlst_qimg", "zm_cpm5_mqs5_vlst_qimh", "zm_cpm5_mqs5_vlst_qimi", "zm_cpm5_mqs5_vlst_qimj"]);
  clear_challenge_hint();
  clear_challenge_counter();
  clear_rune_symbols(level.a_trial_of_mindfulness_challenge_runes);
  trial_a_wall_block(0);

  if(isDefined(level.e_timer_sfx)) {
    level.e_timer_sfx delete();
  }

  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_root::enable_none_kill_score_event();
  level scripts\engine\utility::_id_5C1B("round_spawn_zombies");
  level scripts\engine\utility::_id_5C04("disallow_rbz_exfil");
  level.is_in_trial_of_mindfulness_challenge_lost_sequence = 0;
}

enable_challenge_in_next_round() {
  level endon("game_ended");
  level waittill("round_start");
  level scripts\engine\utility::_id_5C04("trial_of_mindfulness_challenge_is_cooling_down");
}

clear_alive_zombies() {
  var_0 = _id_06FE::_id_6322();

  foreach(var_2 in var_0) {
    var_2 _meth_81FA();
  }

  _id_0746::_id_B8F1("zmb_trial_clear_zombies");
}

create_bar_with_small_gap(var_0, var_1, var_2, var_3) {
  var_4 = newclienthudelem(self);
  var_4.x = 0;
  var_4.y = 0;
  var_4._id_5F33 = 0;
  var_4.color = var_0;
  var_4.sort = -2;
  var_4.shader = "progress_bar_fill";
  var_4 setshader("progress_bar_fill", var_1, var_2);
  var_4.hidden = 0;
  var_4.hidewheninmenu = 1;
  var_4.archived = 0;

  if(isDefined(var_3)) {
    var_4._id_5CA4 = var_3;
  }

  var_5 = newclienthudelem(self);
  var_5.elemtype = "bar";
  var_5.width = var_1;
  var_5.height = var_2;
  var_5.xoffset = 0;
  var_5.yoffset = 0;
  var_5.bar = var_4;
  var_5.children = [];
  var_5.sort = -3;
  var_5.color = (0, 0, 0);
  var_5.alpha = 0.5;
  var_5 scripts\cp\utility::setparent(level.uiparent);
  var_5 setshader("progress_bar_bg", var_1 + 2, var_2 + 4);
  var_5.hidden = 0;
  var_5.hidewheninmenu = 1;
  var_4.archived = 0;
  return var_5;
}

get_players_involved_in_trial() {
  var_0 = ["zone_merchant_road", "zone_merchant_road_east", "zone_merchant_road_west"];
  var_1 = [];

  foreach(var_3 in level.players) {
    if(isDefined(var_3) && isDefined(var_3.active_curse)) {
      continue;
    }
    var_4 = var_3 scripts\cp\zone_manager::_id_642F();

    if(isDefined(var_4) && isDefined(var_4.script_zone_name) && scripts\engine\utility::array_contains(var_0, var_4.script_zone_name) && isDefined(level.trial_of_mindfulness_obelisk) && distance2dsquared(var_3.origin, level.trial_of_mindfulness_obelisk.origin) < 1960000) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

play_close_to_obelisk_vo_monitor() {
  level endon("game_ended");
  level endon("mq_trial_a_done");
  level endon("trial_of_mindfulness_orb_vo_playing");

  while(!istrue(level.b_trial_of_mindfulness_is_charging_obelisk)) {
    foreach(var_1 in level.players) {
      if(isDefined(var_1) && isDefined(level.trial_of_mindfulness_obelisk) && distance2dsquared(var_1.origin, level.trial_of_mindfulness_obelisk.origin) < 336400) {
        level thread play_vo_sequence_to_affected_players(["zm_cpm5_mqs5_dnrt_qika", "zm_cpm5_mqs5_vlst_qikb"], undefined, "trial_a_intro_vo_is_in_queue");
        return;
      }
    }

    wait 1;
  }
}

play_vo_to_affected_players(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    level scripts\engine\utility::_id_5C1B(var_2);
  }

  if(_func_0107(var_0)) {
    var_0 = scripts\engine\utility::random(var_0);
  }

  var_3 = [];

  if(isDefined(var_1)) {
    var_3 = var_1;
  } else {
    var_3 = get_players_involved_in_trial();
  }

  foreach(var_5 in var_3) {
    var_5 thread _id_B2FB(var_0, var_2);
  }
}

_id_B2FB(var_0, var_1) {
  level endon("game_ended");
  self endon("death");

  if(!isPlayer(self)) {
    return;
  }
  if(istrue(level._id_493C)) {
    level _id_0720::waittill_dialogue_finished();
  }

  while(isDefined(self) && isDefined(self._id_4169) && self._id_4169 != "") {
    self waittill("dialogue_finished");
  }

  while(isDefined(self.trial_vo_list) && self.trial_vo_list.size > 0) {
    self waittill("trial_vo_finished");
  }

  if(isDefined(self)) {
    self setclientomnvar("ui_zm_comms", _id_0720::get_portrait_index(strtok(var_0, "_")[3]));
    _id_0720::_id_B309(self, var_0);
  }

  if(isDefined(self)) {
    self setclientomnvar("ui_zm_comms", -1);
  }

  if(isDefined(var_1) && level scripts\engine\utility::_id_5C00(var_1)) {
    level scripts\engine\utility::_id_5C04(var_1);
  }
}

play_vo_sequence_to_affected_players(var_0, var_1, var_2) {
  var_3 = [];

  if(isDefined(var_1)) {
    var_3 = var_1;
  } else {
    var_3 = get_players_involved_in_trial();
  }

  if(isDefined(var_2)) {
    level scripts\engine\utility::_id_5C1B(var_2);
  }

  foreach(var_5 in var_3) {
    var_5 thread play_vo_sequence(var_0, var_2);
  }
}

play_vo_sequence(var_0, var_1) {
  level endon("game_ended");
  self endon("death");

  if(!isPlayer(self) || !_func_0107(var_0)) {
    return;
  }
  if(istrue(level._id_493C)) {
    level _id_0720::waittill_dialogue_finished();
  }

  while(isDefined(self) && isDefined(self._id_4169) && self._id_4169 != "") {
    self waittill("dialogue_finished");
  }

  while(isDefined(self.trial_vo_list) && self.trial_vo_list.size > 0) {
    self waittill("trial_vo_finished");
  }

  foreach(var_3 in var_0) {
    if(isDefined(self)) {
      self setclientomnvar("ui_zm_comms", _id_0720::get_portrait_index(strtok(var_3, "_")[3]));
      _id_0720::_id_B309(self, var_3);
    }
  }

  if(isDefined(self)) {
    self setclientomnvar("ui_zm_comms", -1);
  }

  if(isDefined(var_1) && level scripts\engine\utility::_id_5C00(var_1)) {
    level scripts\engine\utility::_id_5C04(var_1);
  }
}