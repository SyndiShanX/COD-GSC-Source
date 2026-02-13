/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2441.gsc
*************************************************/

_id_C1EF() {
  _id_0737::_id_C266("idol", ::get_demonic_idol_hint_string, ::interaction_deposit_complete);
  _id_0737::_id_10C8("idol", ::demonic_idol_set_hint);
  _id_0737::_id_10C9("idol", ::demonic_idol_unset_hint);
  level._id_8393["idol"].override_interaction_use_duration_func = ::set_interaction_struct_hold_duration;
  _id_0737::_id_C4AB("idol");
  level._effect["sin_eater_deliver"] = loadfx("vfx/s4/zombie/vfx_obj_sin_eater_obelisk_activate.vfx");
  level._effect["sin_eater_idle"] = loadfx("vfx/s4/zombie/vfx_obj_sin_eater_obelisk_idle.vfx");
  level._effect["sin_eater_destroy"] = loadfx("vfx/s4/zombie/vfx_obj_sin_eater_obelisk_destroy.vfx");
  level._effect["sin_eater_arrive"] = loadfx("vfx/s4/zombie/vfx_obj_sin_eater_obelisk_move_arrive.vfx");
  level._effect["sin_eater_depart"] = loadfx("vfx/s4/zombie/vfx_obj_sin_eater_obelisk_move_depart.vfx");
  level._effect["sin_eater_ground_rune"] = loadfx("vfx/s4/zombie/vfx_obj_sin_eater_obelisk_rune.vfx");
  _id_06CB::_id_AA65(::on_player_spawned);
}

init() {
  _id_06CB::_id_AA4A(::_id_AA6D);
  _id_06CB::_id_0FA4("soul_collected", ::soul_collected);
  _id_0987::_id_C215("soul_capture", ::_id_7FBE, ::setup, ::_id_8CE4, ::_id_385C, "soul_capture", undefined, undefined, 13, undefined, undefined, ::on_player_spawned);
}

_id_7FBE(var_0) {
  var_0._id_0DF6 = var_0._id_3BE8["teleport_pt"];
  var_0._id_0DF7 = var_0._id_3BE8["spawn_manager_spawner"];
  var_0._id_529C = 1;
}

setup(var_0) {
  level.get_objective_item_positions_func = ::get_objective_positions;
  level thread scripts\cp\zombies\objective_barriers::toggle_objective_clip(var_0._id_3BE8["prop"], 1);
  var_0 spawn_sin_eater_rune("idol_1");
}

spawn_sin_eater_rune(var_0) {
  self.sin_eater_rune_ent = spawn("script_model", self._id_3BE8[var_0][0].origin);
  self.sin_eater_rune_ent setModel("tag_origin");
  play_sin_eater_fx(self.sin_eater_rune_ent, "sin_eater_ground_rune", "ground_rune", 0);
}

move_sin_eater_rune(var_0) {
  if(isDefined(self.sin_eater_rune_ent)) {
    self.sin_eater_rune_ent delete();
  }

  spawn_sin_eater_rune(var_0);
}

cleanup_sin_eater_rune(var_0, var_1) {
  level endon("game_ended");

  if(!isDefined(self.sin_eater_rune_ent)) {
    return;
  }
  if(isDefined(var_1)) {
    wait(var_1);
  }

  _func_012F(scripts\engine\utility::getfx("sin_eater_ground_rune"), self.sin_eater_rune_ent, "tag_origin");

  if(scripts\engine\utility::is_equal(var_0, 1)) {
    self.sin_eater_rune_ent delete();
  }
}

_id_8CE4(var_0) {
  var_0 notify("teleport_go");

  if(isDefined(var_0._id_3BE8["idol_1"])) {
    var_0.idol_interact_structs = scripts\engine\utility::array_combine(var_0._id_3BE8["idol_1"], var_0._id_3BE8["idol_2"], var_0._id_3BE8["idol_3"]);
  } else {
    var_0.idol_interact_structs = var_0._id_3BE8["idol"];
  }

  var_0.idol_moves = 0;
  var_0.n_max_idol_moves = 3;
  level thread setup_objective_ui();
  var_0 thread set_new_active_idol_struct();
  _func_01E3("sin_eater");
  var_0 thread start_sequence();
}

start_sequence() {
  level endon("game_ended");
  self endon("players_dead");
  self endon("objective_ended");
  self endon("soul_capture_complete");
  wait 1;
  thread play_kickoff_vo(self);
  self waittill("kickoff_vo_complete");
  _id_E61E(self);
}

get_objective_positions() {
  var_0 = level._id_3BE9._id_0F51;

  if(!isDefined(var_0)) {
    return undefined;
  }

  if(!isDefined(var_0.active_idol)) {
    return undefined;
  }

  var_1 = [];
  var_1[var_1.size] = var_0.active_idol.origin;
  return var_1;
}

play_kickoff_vo(var_0) {
  wait 1;
  level.soul_capture_count = scripts\cp\utility::_id_459B(level.soul_capture_count, 1);
  _id_0987::play_objective_kickoff_narration("soul_capture", level.soul_capture_count, var_0, 0);
  level.soul_capture_count++;
}

_id_E61E(var_0) {
  var_0 thread _id_E04A();
}

setup_objective_ui() {
  if(istrue(level.soak_testing) && !isDefined(level._id_3BE9._id_0F51)) {
    return;
  }
  _id_0987::set_objective_ui_state(1, 0, 1);
  level._id_3BE9._id_0F51 set_player_max_souls();
  level._id_3BE9._id_0F51 set_souls_needed();
  _id_0987::set_objective_ui_bar_progress(0);
  _id_0987::set_objective_ui_bar_progress_numerical(0, level._id_3BE9._id_0F51.n_idol_first_move_threshold);

  foreach(var_1 in level.players) {
    var_1 _id_0987::set_objective_ui_counter(0, level._id_3BE9._id_0F51.n_player_max_souls);
  }

  _id_0987::set_objective_phase_count(1, level._id_3BE9._id_0F51.n_max_idol_moves);
}

_id_E04A(var_0) {
  self endon("objective_ended");
  self endon("players_dead");
  self.n_souls_collected = 0;
  set_souls_needed();
  self._id_A38B = 0;
  self._id_0DE3 = [];
  self._id_0DE4 = [];
  var_1 = "Failed";
  thread idol_watcher();
  self waittill("soul_capture_complete");
  var_2 = 0;
  var_1 = "Failed";

  if(self._id_A38B >= self.n_souls_needed) {
    var_2 = 1;
    var_1 = "Success";
  }

  set_soul_capture_completed(var_2);
}

set_soul_capture_completed(var_0) {
  self notify("started_end_flow");
  level thread _id_0991::_id_E8E2(1);
  cleanup_marker();
  level thread cleanup_hud();
  thread cleanup_demonic_idol_interact();
  _id_0987::play_objective_complete_sfx();
  wait 0.7;
  _id_0987::set_objective_ui_state(1, 0, 2);
  _func_01E3("none");
  _id_0987::_id_A871(self, var_0);
}

add_demonic_idol_marker() {
  var_0 = spawnStruct();
  var_0._id_E747 = "current";

  if(!isDefined(level.soulcapturedemonicidoliconent)) {
    level.soulcapturedemonicidoliconent = spawn("script_model", self.demonic_idol_interact.origin);
    waitframe();
  }

  level.soulcapturedemonicidoliconent.origin = self.demonic_idol_interact.origin;
  var_0.label = &"CP_ZMB_INTERACTIONS/SOUL_CAPTURE_DEMONIC_IDOL";
  var_0._id_96CF = level.soulcapturedemonicidoliconent;
  var_0._id_11012 = 110;
  var_0._id_7C3B = "v_ui_icons_zombies_minimap_objective";
  var_0.minimapiconsize = "icon_regular";
  self.demonicidolmarkernum = _id_0987::_id_0FFD("soul_capture_demonic_idol", var_0);
}

update_demonic_idol_marker(var_0) {
  level endon("game_ended");
  var_1 = spawnStruct();
  var_1._id_E747 = "invisible";
  _id_0987::_id_FB90(self.demonicidolmarkernum, var_1);
  wait 1;
  var_1._id_E747 = "current";
  var_1._id_96CF = level.soulcapturedemonicidoliconent;
  _id_0987::_id_FB90(self.demonicidolmarkernum, var_1);
}

cleanup_marker() {
  if(isDefined(level.soulcapturedemonicidoliconent)) {
    level.soulcapturedemonicidoliconent delete();
    waitframe();
    _id_0987::_id_C413("soul_capture_demonic_idol", self.demonicidolmarkernum);
    waitframe();
    self.demonicidolmarkernum = undefined;
  }
}

set_new_active_idol_struct() {
  level endon("game_ended");
  self endon("players_dead");
  self endon("objective_ended");
  self endon("soul_capture_complete");

  if(!isDefined(self.idol_interact_structs) || self.idol_interact_structs.size == 0) {
    return;
  }
  if(isDefined(self.active_idol)) {
    _id_0737::_id_C3C5(self.active_idol);
  }

  level thread _id_0991::_id_E8E2(1);
  waittillframeend;
  level thread scripts\cp\zombies\powerups\zm_powerup_soul::cleanup_all_soul_powerups();

  if(isDefined(self.demonic_idol_interact)) {
    thread play_sin_eater_teleport_fx("depart", 1);
    self.demonic_idol_interact hide();
    thread cleanup_sin_eater_rune(0, 1);
  }

  level notify("demonic_idol_moving");
  self.idol_moves = scripts\cp\utility::_id_459B(self.idol_moves, 0);

  if(self.idol_moves != 0) {
    soul_capture_start_wave(self.next_idol);
    wait 4.5;
  }

  if(isDefined(self.demonic_idol_interact)) {
    self.demonic_idol_interact delete();
    level thread toggle_idol_clip(self.active_idol, 0);
  }

  if(self.idol_moves == 0) {
    get_idol_struct("idol_1", "idol_2");
  } else if(self.idol_moves == 1) {
    get_idol_struct("idol_2", "idol_3");
  } else {
    get_idol_struct("idol_3", "idol_3");
  }

  self.idol_moves++;
  self._id_CAB9 = self.active_idol;
  thread spawn_demonic_idol_model(self._id_CAB9, self, "s4_zm_sin_eater_obelisk_01");
  thread toggle_sin_eater_loop_sfx();

  if(self.idol_moves == 1) {
    thread spawn_streamer_demonic_idol(self._id_CAB9, self, "s4_zm_sin_eater_obelisk_01");
    self waittill("kickoff_vo_complete");
    soul_capture_start_wave(self.active_idol);
  }

  activate_demonic_idol_marker();
  _id_0737::_id_1037(self.active_idol);
  _id_0987::reset_all_player_objective_kill_tracking();
}

get_idol_struct(var_0, var_1) {
  var_2 = undefined;

  for(var_3 = 0; var_3 < self.idol_interact_structs.size; var_3++) {
    if(self.idol_interact_structs[var_3]._id_3BE4 == var_0) {
      self.active_idol = self.idol_interact_structs[var_3];
      var_2 = self.active_idol;
    }

    if(isDefined(var_1) && self.idol_interact_structs[var_3]._id_3BE4 == var_1) {
      self.next_idol = self.idol_interact_structs[var_3];
    }
  }

  if(!isDefined(var_2)) {
    self.active_idol = self.idol_interact_structs[0];
    self.next_idol = self.idol_interact_structs[0];
  }
}

set_souls_needed() {
  var_0 = level.players.size;

  switch (var_0) {
    case 1:
      self.n_souls_needed = 15;
      break;
    case 2:
      self.n_souls_needed = 15;
      break;
    case 3:
      self.n_souls_needed = 21;
      break;
    default:
      self.n_souls_needed = 27;
      break;
  }

  self.n_idol_first_move_threshold = int(_func_0438(self.n_souls_needed * 0.33));
  self.n_idol_second_move_threshold = int(_func_0438(self.n_souls_needed * 0.33)) * 2;
}

set_player_max_souls() {
  var_0 = level.players.size;

  switch (var_0) {
    case 1:
      self.n_player_max_souls = 5;
      break;
    case 2:
      self.n_player_max_souls = 5;
      break;
    case 3:
      self.n_player_max_souls = 5;
      break;
    default:
      self.n_player_max_souls = 5;
      break;
  }
}

create_sin_eater_move_hud_elem() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1.sin_eater_move_text)) {
      var_1.sin_eater_move_text = var_1 scripts\cp\utility::createfontstring("default", 1);
    }

    var_1.sin_eater_move_text scripts\cp\utility::setpoint("CENTER", undefined, 0, -150);
    var_1.sin_eater_move_text settext(&"CP_ZMB/OBJECTIVE_SOUL_CAPTURE_SIN_EATER_MOVE");
    var_1.sin_eater_move_text.fontscale = 2;
    var_1.sin_eater_move_text.alpha = 1;
  }
}

cleanup_sin_eater_move_hud_elem() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1.sin_eater_move_text)) {
      var_1.sin_eater_move_text fadeovertime(0.15);
      var_1.sin_eater_move_text.alpha = 0;
    }
  }
}

create_soul_capture_soul_count_text() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1.soul_capture_soul_count_text)) {
      var_1.soul_capture_soul_count_text = var_1 scripts\cp\utility::createfontstring("default", 2);
      var_1.soul_capture_soul_count_description_text = var_1 scripts\cp\utility::createfontstring("default", 1);
      var_1.soul_capture_progress_label = var_1 scripts\cp\utility::createfontstring("default", 1);
      var_1.soul_capture_divider_text = var_1 scripts\cp\utility::createfontstring("default", 1);
      var_1.soul_capture_max_count_text = var_1 scripts\cp\utility::createfontstring("default", 1);
    }

    var_1.soul_capture_soul_count_text scripts\cp\utility::setpoint("CENTER", undefined, -300, 125);
    var_1.soul_capture_soul_count_text _meth_83A3(0);
    var_1.soul_capture_soul_count_text.fontscale = 2;
    var_1.soul_capture_soul_count_text.alpha = 1;
    var_1.soul_capture_soul_count_description_text scripts\cp\utility::setpoint("CENTER", undefined, -300, 100);
    var_1.soul_capture_soul_count_description_text settext(&"CP_ZMB/OBJECTIVE_SOUL_CAPTURE_SOUL_COUNT_DESCRIPTION");
    var_1.soul_capture_soul_count_description_text.fontscale = 2;
    var_1.soul_capture_soul_count_description_text.alpha = 1;
    var_1.soul_capture_progress_label scripts\cp\utility::setpoint("CENTER", undefined, -300, -105);
    var_1.soul_capture_progress_label settext(&"CP_ZMB/OBJECTIVE_SOUL_CAPTURE_PROGRESS_LABEL");
    var_1.soul_capture_progress_label.fontscale = 2;
    var_1.soul_capture_progress_label.alpha = 1;
    var_1.soul_capture_divider_text scripts\cp\utility::setpoint("CENTER", undefined, -280, 125);
    var_1.soul_capture_divider_text _meth_83A3(self.n_player_max_souls);
    var_1.soul_capture_divider_text.fontscale = 2;
    var_1.soul_capture_divider_text.alpha = 1;
    var_1.soul_capture_max_count_text scripts\cp\utility::setpoint("CENTER", undefined, -290, 125);
    var_1.soul_capture_max_count_text settext(&"CP_ZMB/OBJECTIVE_SOUL_CAPTURE_MAX_SOUL_COUNT");
    var_1.soul_capture_max_count_text.fontscale = 2;
    var_1.soul_capture_max_count_text.alpha = 1;
  }
}

_id_AA6D(var_0) {
  if(isDefined(level._id_3BE9._id_0F51) && scripts\engine\utility::is_equal(level._id_3BE9._id_0F51._id_3BE5, "soul_capture") && isDefined(level._id_3BE9._id_0F51.demonic_idol_interact)) {
    level thread spawnsoul(self, var_0._id_50FF);
  }
}

update_soul_progress_ui() {
  var_0 = 0;
  var_1 = 0;

  if(self.idol_num_of_moves == 0) {
    var_0 = self._id_A38B;
    var_1 = self.n_idol_first_move_threshold;
  } else if(self.idol_num_of_moves == 1) {
    var_0 = self._id_A38B - self.n_idol_first_move_threshold;
    var_1 = self.n_idol_second_move_threshold - self.n_idol_first_move_threshold;
  } else {
    var_0 = self._id_A38B - self.n_idol_second_move_threshold;
    var_1 = self.n_souls_needed - self.n_idol_second_move_threshold;
  }

  _id_0987::set_objective_ui_bar_progress(var_0 / var_1);
  _id_0987::set_objective_ui_bar_progress_numerical(var_0, var_1);
}

_id_FBC6(var_0, var_1, var_2) {
  var_0 notify("zombie_kill");
  var_3 = 0;

  if(var_2.soul_count > 0) {
    var_3 = var_2.soul_count - 1;
  }

  if(var_1 > 0) {
    var_2.a_disable_grab_for_powerup["soul"] = 0;
  }

  if(var_0._id_A38B == 0) {
    thread _id_0720::play_narration("zm_cmcp_obsc_dsrx_s50e");
  }

  var_0._id_A38B = var_0._id_A38B + var_1;
  var_0 update_soul_progress_ui();
  var_2.soul_count = var_3;
  _id_0987::set_objective_ui_counter(var_2.soul_count, level._id_3BE9._id_0F51.n_player_max_souls);

  if(var_0._id_A38B >= var_0.n_souls_needed) {
    _id_0737::_id_C4AB("idol");
    var_0 notify("soul_capture_complete");
  }

  var_0.demonic_idol_interact playsoundtoplayer("zmb_soul_deposit_plr", var_2);
  var_0.demonic_idol_interact playsoundtoteam("zmb_soul_deposit_npc", var_2.team, var_2);
}

complete_objective() {
  var_0 = level._id_3BE9._id_0F51;
  var_0 thread force_complete_objective();
}

force_complete_objective() {
  level endon("game_ended");
  self endon("started_end_flow");
  self endon("objective_ended");
  self._id_A38B = self.n_souls_needed;
  _id_0737::_id_C4AB("idol");
  self notify("soul_capture_complete");
  wait 2.0;
  thread set_soul_capture_completed(1);
}

idol_watcher() {
  self endon("objective_ended");
  self endon("soul_capture_complete");
  var_0 = level.players.size;
  self._id_10C93 = 1;
  self.idol_num_of_moves = 0;

  for(;;) {
    if(self.idol_num_of_moves == 0 && self._id_A38B >= self.n_idol_first_move_threshold) {
      thread set_new_active_idol_struct();
      wait 0.7;
      self.idol_num_of_moves++;
      _id_0987::set_objective_phase_count(self.idol_num_of_moves + 1, self.n_max_idol_moves);
      _id_0987::set_objective_ui_state(1, 1, 4);
      update_soul_progress_ui();
      scripts\engine\utility::delaythread(1.0, _id_0720::play_narration, "zm_cmcp_obsc_dsrx_sobm");
    } else if(self.idol_num_of_moves == 1 && self._id_A38B >= self.n_idol_second_move_threshold) {
      thread set_new_active_idol_struct();
      wait 0.7;
      self.idol_num_of_moves++;
      _id_0987::set_objective_phase_count(self.idol_num_of_moves + 1, self.n_max_idol_moves);
      _id_0987::set_objective_ui_state(1, 1, 4);
      update_soul_progress_ui();

      if(level._id_4169 != "zm_cmcp_obsc_dsrx_sobm") {
        scripts\engine\utility::delaythread(1.0, _id_0720::play_narration, "zm_cmcp_obsc_dsrx_sobm");
      }

      return;
    }

    wait 0.1;
  }
}

soul_capture_start_wave(var_0) {
  var_1 = var_0._id_3BE8["spawn_manager_spawner"];
  self._id_10C93 = scripts\cp\utility::_id_459B(self._id_10C93, 1);

  switch (self._id_10C93) {
    case 1:
      level thread _id_0991::_id_C9FC("cp_zm_zod_soul_capture_intensity_01", undefined, var_1);
      break;
    case 2:
      level thread _id_0991::_id_C9FC("cp_zm_zod_soul_capture_intensity_02", undefined, var_1);
      break;
    default:
      level thread _id_0991::_id_C9FC("cp_zm_zod_soul_capture_intensity_03", undefined, var_1);
      break;
  }

  self._id_10C93++;
}

_id_385C() {
  level thread scripts\cp\zombies\objective_barriers::toggle_objective_clip(self._id_3BE8["prop"], 0);
  _id_0737::_id_C4AB("idol");
  level thread cleanup_hud();

  foreach(var_1 in level.players) {
    var_1.soul_count = 0;
    var_1.a_disable_grab_for_powerup["soul"] = 0;
  }

  if(isDefined(self._id_EACB) && self._id_EACB) {
    return;
  }
}

cleanup_demonic_idol_interact() {
  level endon("game_ended");
  play_sin_eater_fx(self.demonic_idol_interact, "sin_eater_destroy", "destroy", 1);

  if(_func_0205("zmb_obelisk_finale")) {
    self.demonic_idol_interact playSound("zmb_obelisk_finale");
  }

  self.demonic_idol_interact hide();
  thread cleanup_sin_eater_rune(1, 3);
  level notify("demonic_idol_moving");
  wait 3;
  waittillframeend;

  if(isDefined(self.active_idol)) {
    level thread toggle_idol_clip(self.active_idol, 0);
  }

  if(isDefined(self.demonic_idol_interact)) {
    self.demonic_idol_interact delete();
  }
}

cleanup_hud() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1.soul_capture_soul_count_text)) {
      var_1.soul_capture_soul_count_text fadeovertime(0.15);
      var_1.soul_capture_soul_count_text.alpha = 0;
      var_1.soul_capture_soul_count_description_text fadeovertime(0.15);
      var_1.soul_capture_soul_count_description_text.alpha = 0;
      var_1.soul_capture_progress_label fadeovertime(0.15);
      var_1.soul_capture_progress_label.alpha = 0;
      var_1.soul_capture_divider_text fadeovertime(0.15);
      var_1.soul_capture_divider_text.alpha = 0;
      var_1.soul_capture_max_count_text fadeovertime(0.15);
      var_1.soul_capture_max_count_text.alpha = 0;
    }
  }

  _id_0987::_id_E8A5();
}

spawnsoul(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::is_equal(getdvarint("#x317c13cf8171a82f7", 0), 1)) {
    return;
  }
  if(isDefined(var_1) && !scripts\engine\utility::is_equal(var_0.spawn_manager_cleanup, 1) && !scripts\engine\utility::is_equal(var_0._id_A72E, 1)) {
    var_1.soul_drop_rate = scripts\cp\utility::_id_459B(var_1.soul_drop_rate, get_soul_drop_chance());

    if(!istrue(var_0._id_A52A) && scripts\cp\utility::_id_3A27(var_1.soul_drop_rate)) {
      var_1.soul_drop_rate = get_soul_drop_chance();
      var_4 = _id_0990::_id_E3DD("soul", var_0.origin);
      scripts\cp\zombies\powerups\zm_powerup_soul::track_soul_powerups(var_4);
    } else
      var_1.soul_drop_rate = var_1.soul_drop_rate + get_soul_drop_bad_luck_protection();
  }
}

get_soul_drop_chance() {
  if(isDefined(level._id_11049)) {
    switch (level._id_11049) {
      case 1:
        return 35;
      case 2:
        return 28;
      case 3:
        return 24;
      case 4:
        return 20;
      default:
        return 16;
    }
  }

  return 20;
}

get_soul_drop_bad_luck_protection() {
  if(isDefined(level._id_11049)) {
    switch (level._id_11049) {
      case 1:
        return 24.5;
      case 2:
        return 17.5;
      case 3:
        return 12.5;
      case 4:
        return 10;
      default:
        return 6;
    }
  }

  return 7.5;
}

soul_collected(var_0) {
  if(!isDefined(level._id_3BE9._id_0F51) || isDefined(level._id_3BE9._id_0F51.n_player_max_souls) && isDefined(var_0.player.soul_count) && var_0.player.soul_count >= level._id_3BE9._id_0F51.n_player_max_souls) {
    return;
  }
  var_0.player thread _id_0752::_id_7003("objective_soul_capture_pickup");
  var_0.player.soul_count = scripts\cp\utility::_id_459B(var_0.player.soul_count, 0);
  var_0.player.soul_count++;
  var_0.player _id_0987::set_objective_ui_counter(var_0.player.soul_count, level._id_3BE9._id_0F51.n_player_max_souls);
  var_0.player playrumbleonentity("damage_light");

  if(isDefined(level._id_3BE9._id_0F51.n_player_max_souls) && var_0.player.soul_count >= level._id_3BE9._id_0F51.n_player_max_souls) {
    var_0.player.a_disable_grab_for_powerup["soul"] = 1;
  }

  if(isDefined(level._id_3BE9._id_0F51) && scripts\engine\utility::is_equal(level._id_3BE9._id_0F51._id_3BE5, "soul_capture")) {
    level._id_3BE9._id_0F51.n_souls_collected++;
  }

  var_0.player _id_092E::show_pickup_notification(2, 1, 0);

  if(level._id_3BE9._id_0F51.n_souls_collected == 1) {
    thread _id_0720::play_narration("zm_cmcp_obsc_krtx_s25t");
  } else if(level._id_3BE9._id_0F51.n_souls_collected == int(level._id_3BE9._id_0F51.n_souls_needed * 0.75)) {
    thread _id_0720::play_narration("zm_cmcp_obsc_vlst_s75t");
  }
}

spawn_streamer_demonic_idol(var_0, var_1, var_2) {
  var_3 = (var_0.origin[0], var_0.origin[1], -300);

  if(scripts\engine\utility::is_equal(level.hubdestination, "cp_zm_skorpion_oasis_tr")) {
    var_3 = (var_0.origin[0], var_0.origin[1], -800);
  }

  var_1.demonic_idol_streamer_model = _id_06EF::_id_E1E5(var_0, var_2, 0, 1, var_3);
  wait 3;
  var_1.demonic_idol_streamer_model delete();
}

spawn_demonic_idol_model(var_0, var_1, var_2) {
  var_1.demonic_idol_interact = _id_06EF::_id_E1E5(var_0, var_2, 0);
  var_1.demonic_idol_interact hide();
  var_1.demonic_idol_interact notsolid();

  if(var_1.idol_moves > 1) {
    var_1 move_sin_eater_rune(var_0._id_3BE4);
  }

  var_1 play_sin_eater_fx(var_1.demonic_idol_interact, "sin_eater_idle", "idle", 0);
  var_1.demonic_idol_interact thread _id_0987::_id_CF90(var_1.demonic_idol_interact, 6, 4, 0, 0, 1);
  var_3 = getent("sin_eater_objective_clip_prop_singular", "targetname");

  if(isDefined(var_3)) {
    var_3.origin = var_0.origin + (0, 0, 24);
  }

  waitframe();
  var_1 thread play_sin_eater_teleport_fx("arrive", 1);
  level thread toggle_idol_clip(var_0, 1, 1);
  wait 3;
  var_1.demonic_idol_interact show();
  var_1.demonic_idol_interact _meth_81B0("outline_objective");
}

activate_demonic_idol_marker() {
  if(!isDefined(self.demonicidolmarkernum)) {
    add_demonic_idol_marker();
  } else if(isDefined(level.soulcapturedemonicidoliconent)) {
    level.soulcapturedemonicidoliconent.origin = self.active_idol.origin;
    thread update_demonic_idol_marker();
  }
}

play_sin_eater_teleport_fx(var_0, var_1) {
  level endon("game_ended");
  self endon("death ");

  switch (var_0) {
    case "arrive":
      play_sin_eater_fx(self.demonic_idol_interact, "sin_eater_arrive", "arrive", var_1);

      if(_func_0205("zmb_obelisk_appear")) {
        self.demonic_idol_interact playSound("zmb_obelisk_appear");
      }

      break;
    case "depart":
      play_sin_eater_fx(self.demonic_idol_interact, "sin_eater_depart", "depart", var_1);

      if(_func_0205("zmb_obelisk_disappear")) {
        self.demonic_idol_interact playSound("zmb_obelisk_disappear");
      }

      break;
    default:
      play_sin_eater_fx(self.demonic_idol_interact, "sin_eater_depart", "depart", var_1);

      if(_func_0205("zmb_obelisk_disappear")) {
        self.demonic_idol_interact playSound("zmb_obelisk_disappear");
      }

      break;
  }
}

toggle_sin_eater_loop_sfx() {
  if(!_func_0205("zmb_obelisk_base_lp")) {
    return;
  }
  var_0 = spawn("script_origin", self.demonic_idol_interact.origin);
  var_0 playLoopSound("zmb_obelisk_base_lp");
  level waittill("demonic_idol_moving");
  var_0 stoploopsound(2);
  var_0 delete();
}

interaction_deposit_complete(var_0, var_1) {}

get_hold_duration(var_0) {
  var_1 = level._id_3BE9._id_0F51;

  if(!isDefined(var_1) || !scripts\engine\utility::is_equal(var_1._id_3BE5, "soul_capture") || !isDefined(var_0) || !isPlayer(var_0) || (!isDefined(var_0.soul_count) || var_0.soul_count <= 0)) {
    return 500;
  }

  var_2 = 1;

  if(var_1.idol_num_of_moves == 0) {
    var_2 = var_1.n_idol_first_move_threshold - var_1._id_A38B;
  } else if(var_1.idol_num_of_moves == 1) {
    var_2 = var_1.n_idol_second_move_threshold - var_1._id_A38B;
  } else {
    var_2 = var_1.n_souls_needed - var_1._id_A38B;
  }

  if(var_0.soul_count <= var_2) {
    var_2 = var_0.soul_count;
  }

  if(var_2 < 0) {
    var_2 = 1;
  }

  return 500 * var_2;
}

set_interaction_struct_hold_duration(var_0, var_1) {
  return get_hold_duration(var_1);
}

toggle_idol_clip(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0._id_0481, "target");
  var_4 = getent("sin_eater_objective_clip_prop_singular", "targetname");

  if(isDefined(var_4)) {
    var_3[var_3.size] = var_4;
  }

  var_5 = getent("sin_eater_objective_clip_navmesh", "targetname");

  if(isDefined(var_5)) {
    if(var_1) {
      var_5.origin = var_0.origin;
      var_5 _meth_80B5();
      var_5 show();
    } else {
      var_5 _meth_8093();
      var_5 hide();
    }
  }

  foreach(var_7 in var_3) {
    if(var_1) {
      var_7 thread animate_demonic_idol_clip(var_2, self);
      continue;
    }

    var_7 notify("stop_scriptmodel_bob");
    var_7 _meth_8093();
    var_7 hide();
  }
}

animate_demonic_idol_clip(var_0, var_1) {
  self endon("death");
  self endon("stop_scriptmodel_bob");

  if(scripts\engine\utility::is_equal(var_0, 1)) {
    var_2 = self.origin + (0, 0, 25);
    self.origin = self.origin - (0, 0, 105);
    self moveto(var_2, 1.25, 0, 0);
  }

  self show();
  wait 1.25;
  self _meth_80B5();
  thread _id_0987::_id_CF90(self, 6, 4, 0, 0, 1);
}

demonic_idol_set_hint(var_0, var_1) {
  if(!isDefined(var_1) || !isPlayer(var_1) || !isDefined(level._id_3BE9._id_0F51)) {
    return;
  }
  set_interaction_struct_hold_duration(var_0, var_1);
  var_1 thread demonic_idol_interaction_watcher(level._id_3BE9._id_0F51, var_0);
  var_1 thread demonic_idol_hold_duration_watcher(level._id_3BE9._id_0F51, var_0);
  var_1 thread update_demonic_idol_hint(level._id_3BE9._id_0F51);
}

demonic_idol_unset_hint(var_0, var_1) {
  var_1 notify("demonic_idol_unset_hint");
}

update_demonic_idol_hint(var_0) {
  if(!isDefined(self) || !isPlayer(self)) {
    return;
  }
  level endon("game_ended");
  level endon("demonic_idol_moving");
  var_0 endon("objective_ended");
  self endon("death");
  self endon("demonic_idol_unset_hint");
  self endon("disconnect");

  for(;;) {
    if(!scripts\engine\utility::is_equal(self.inlaststand, 1)) {
      var_1 = get_demonic_idol_hint_string(undefined, self);
      self._id_8388 sethintstring(var_1);
    }

    wait 1.0;
  }
}

get_demonic_idol_hint_string(var_0, var_1) {
  if(isDefined(self.soul_count) && self.soul_count > 0) {
    return &"CP_ZMB_INTERACTIONS/SOUL_CAPTURE_DEMONIC_IDOL_DEPOSIT";
  }

  return &"CP_ZMB_INTERACTIONS/SOUL_CAPTURE_NEED_MORE_RUNESTONES";
}

demonic_idol_hold_duration_watcher(var_0, var_1) {
  level endon("game_ended");
  level endon("demonic_idol_moving");
  var_0 endon("objective_ended");
  self endon("death ");
  self endon("demonic_idol_unset_hint");
  self endon("disconnect");

  for(;;) {
    if(isDefined(self._id_8388) && scripts\engine\utility::is_equal(self._id_8388._id_7D7E, 1) && isDefined(var_1) && scripts\engine\utility::is_equal(var_1._id_039B, "idol") && !self usebuttonpressed()) {
      self._id_8388 setuseholdduration(get_hold_duration(self));
    }

    wait 0.1;
  }
}

demonic_idol_interaction_watcher(var_0, var_1) {
  level endon("game_ended");
  level endon("demonic_idol_moving");
  var_0 endon("objective_ended");
  self endon("death ");
  self endon("demonic_idol_unset_hint");
  self endon("disconnect");

  for(;;) {
    if(isDefined(self._id_8388) && scripts\engine\utility::is_equal(self._id_8388._id_7D7E, 1) && isDefined(var_1) && scripts\engine\utility::is_equal(var_1._id_039B, "idol") && !scripts\engine\utility::is_equal(self.inlaststand, 1) && isDefined(var_0.demonic_idol_interact) && scripts\engine\utility::_id_10E76(self.origin, self getplayerangles(), var_0.demonic_idol_interact.origin, cos(85))) {
      if(self usebuttonpressed() && isDefined(self.soul_count) && self.soul_count > 0) {
        wait 0.4;

        if(self usebuttonpressed() && isDefined(self._id_8388)) {
          _id_FBC6(level._id_3BE9._id_0F51, 1, self);
          self playrumbleonentity("damage_light");
          var_0 play_sin_eater_fx(var_0.demonic_idol_interact, "sin_eater_deliver", "runestone_delivery", 0);
          thread _id_0752::_id_7003("objective_soul_capture_deposit");
        }
      }
    }

    wait 0.1;
  }
}

play_sin_eater_fx(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0._id_605B = scripts\cp\utility::_id_459B(var_0._id_605B, []);
  var_4 = scripts\engine\utility::getfx(var_1);

  if(var_3) {
    var_0._id_605B[var_2] = playFX(var_4, var_0.origin);
  } else {
    var_0._id_605B[var_2] = playFXOnTag(var_4, var_0, "tag_origin");
  }
}

on_player_spawned() {
  if(isDefined(level._id_3BE9) && isDefined(level._id_3BE9._id_0F51) && scripts\engine\utility::is_equal(level._id_3BE9._id_0F51._id_3BE5, "soul_capture")) {
    if(isDefined(level._id_3BE9._id_0F51.n_player_max_souls)) {
      _id_0987::set_objective_ui_counter(0, level._id_3BE9._id_0F51.n_player_max_souls);
    } else {
      _id_0987::set_objective_ui_counter(0, 5);
    }

    if(isDefined(level._id_3BE9._id_0F51._id_A38B) && isDefined(level._id_3BE9._id_0F51.n_souls_needed)) {
      level._id_3BE9._id_0F51 update_soul_progress_ui();
    } else {
      _id_0987::set_objective_ui_bar_progress(0);
    }

    _id_0987::set_objective_ui_state(1, 0, 5);
  }
}