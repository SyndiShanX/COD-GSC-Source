/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2436.gsc
*************************************************/

init() {
  _id_0987::_id_C215("domination", ::_id_7FBE, ::setup, ::_id_8CE4, ::_id_385C, "domination", undefined, undefined, "domination", undefined, undefined, ::on_player_spawned);
  level _id_06CB::_id_AA4A(::_id_0C78);
  level._effect["domination_zombie_portal"] = loadfx("vfx/s4/zombie/vfx_obj_domination_portal_air.vfx");
  level._effect["domination_zombie_portal_ceiling"] = loadfx("vfx/s4/zombie/vfx_obj_domination_portal_ceiling.vfx");
  level._effect["domination_zombie_flash"] = loadfx("vfx/s4/zombie/vfx_obj_domination_portal_flash.vfx");
  level._effect["domination_rune_zombie_spawn"] = loadfx("vfx/s4/zombie/vfx_obj_domination_rune_zmb_spawn.vfx");
  level._effect["domination_rune_idle"] = loadfx("vfx/s4/zombie/vfx_obj_domination_rune_idle.vfx");
  level._effect["domination_rune_captured"] = loadfx("vfx/s4/zombie/vfx_obj_domination_rune_captured.vfx");
  level._effect["domination_rune_capturing_1"] = loadfx("vfx/s4/zombie/vfx_obj_domination_rune_progress_1.vfx");
  level._effect["domination_rune_capturing_2"] = loadfx("vfx/s4/zombie/vfx_obj_domination_rune_progress_2.vfx");
  level._effect["domination_rune_capturing_3"] = loadfx("vfx/s4/zombie/vfx_obj_domination_rune_progress_3.vfx");
  level._effect["domination_rune_capturing_4"] = loadfx("vfx/s4/zombie/vfx_obj_domination_rune_progress_4.vfx");
  level._effect["domination_portal_air"] = loadfx("vfx/s4/zombie/vfx_obj_domination_portal_air.vfx");
  level._effect["domination_portal_flash"] = loadfx("vfx/s4/zombie/vfx_obj_domination_portal_flash.vfx");
  level._effect["domination_portal_air_collapse"] = loadfx("vfx/s4/zombie/vfx_obj_domination_portal_air_collapse.vfx");
  level._effect["domination_portal_air_end"] = loadfx("vfx/s4/zombie/vfx_obj_domination_portal_air_end.vfx");
}

_id_7FBE(var_0) {
  var_0._id_0DF6 = var_0._id_3BE8["teleport_pt"];
  var_0._id_529C = 1;

  if(getdvarint("#x3ce6f1c71a4bdefaa", 0) == 1) {
    var_0.b_force_play_kickoff_vo = 1;
    var_0.override_vo_func = ::override_domination_vo_func;
    var_0.override_vo_cleanup_func = ::override_domination_vo_cleanup_func;
  }
}

override_domination_vo_func(var_0) {
  var_0.override_announce_vo = "zm_c2dm_o2dm_krft_d2aa";
  var_0.override_announce_resp_vo = "zm_c2dm_o2dm_dnrt_d2ab";

  if(_id_0987::is_dark_aether(var_0) && istrue(var_0.b_force_play_kickoff_vo)) {
    var_0.override_kickoff_vo = "zm_c2dm_o2dm_krft_d2ba";
  }
}

override_domination_vo_cleanup_func(var_0) {
  if(_id_0987::is_dark_aether(var_0) && istrue(var_0.b_force_play_kickoff_vo)) {
    var_0.override_kickoff_vo = undefined;
    var_0.b_force_play_kickoff_vo = 0;
  }
}

setup(var_0) {
  level.get_objective_item_positions_func = ::get_objective_positions;
  var_0 thread init_domination_runes();
  var_0 thread init_final_point();
  var_0 start_marker();
}

_id_385C() {
  if(istrue(self.b_is_quest)) {
    level._id_A52A = 0;
  }

  _id_06CB::_id_C388("zm_spawn_manager_zombie_spawned", ::on_ai_spawned, undefined);
  level thread scripts\cp\zombies\objective_barriers::toggle_objective_clip(self._id_3BE8["prop"], 0);
}

_id_8CE4(var_0) {
  _id_06CB::_id_0FA4("zm_spawn_manager_zombie_spawned", ::on_ai_spawned);
  level thread scripts\cp\zombies\objective_barriers::toggle_objective_clip(var_0._id_3BE8["prop"], 1);
  thread play_kickoff_vo(var_0);
  _func_01E3("domination");
  var_0 thread start_domination_runes();

  if(istrue(var_0.b_is_quest)) {
    level._id_A52A = 1;
  }

  foreach(var_2 in level.players) {
    var_2.n_capture_runes = 0;
  }

  wait 2;
  var_0 start_domination();
}

play_kickoff_vo(var_0) {
  wait 1;
  level.domination_count = scripts\cp\utility::_id_459B(level.domination_count, 1);
  var_0.last_spawn_vo_time = 0;

  if(istrue(var_0.b_is_quest) && _func_0121(var_0.override_vos)) {
    _id_0987::play_objective_kickoff_narration(var_0.override_vos, 1, var_0, 1);
  } else {
    _id_0987::play_objective_kickoff_narration("domination", level.domination_count, var_0, 1);
  }

  level.domination_count++;
  var_0.kickoff_vo_complete = 1;
}

start_domination() {
  self endon("players_dead");
  self endon("game_ended");
  thread ending_update();
  thread zombie_spawner_update();
  set_start_ui();
  thread _id_E65A();
}

start_final() {
  thread final_zombies_update();
}

check_kill_ending_condition() {
  var_0 = level._id_3BE9._id_0F51;

  if(!istrue(level.dominationshouldcheckendcount) || !isDefined(var_0)) {
    return;
  }
  var_0 thread final_zombie_spawner_safe_check();

  if(level.dominationfinalkillcount >= level.dominationcounter) {
    level notify("domination_completed");
  }
}

complete_objective() {
  level notify("domination_completed");
}

ending_update() {
  self endon("players_dead");
  self endon("game_ended");
  level waittill("domination_completed");
  waitframe();
  level thread _id_0991::_id_E8E2(1);
  level thread _id_0987::kill_all_objective_zombies();
  give_ending_rewards(self);
  self.finalpoint playSound("zmb_dom_orb_burst");
  var_0 = scripts\engine\utility::getfx("domination_portal_air_end");
  playFX(var_0, self.finalpoint.origin);
  wait 1.5;
  _func_01E3("none");
  set_end_ui();
  level thread _id_0987::_id_A871(self, 1);
  cleanup_visuals();

  if(istrue(self.b_is_quest)) {
    level notify("domination_quest_completed");
  }
}

give_ending_rewards(var_0) {
  if(get_are_all_runes_captured(var_0)) {
    foreach(var_2 in level.players) {
      var_0 thread give_player_rewards(var_2);
    }
  }
}

give_player_rewards(var_0) {
  var_0 _id_BB0F(3);
  var_0 notify("zmb_max_ammo");
  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(scripts\cp\utility::_id_88F6(var_3.basename)) {
      continue;
    }
    var_0 givemaxammo(var_3);
    var_0 setweaponammoclip(var_3, weaponclipsize(var_3));
  }

  waitframe();

  if(isDefined(var_0._id_1B3D) && var_0._id_1B3D > 0) {
    var_0 _id_BB0F(8);
    _id_0707::_id_6ECA(var_0, var_0._id_1B3D);
  }

  waitframe();
  var_0 _id_BB0F(6);
  var_0 thread _id_0752::_id_7003("bonus_points_powerup");
}

_id_BB0F(var_0) {
  self setclientomnvar("ui_powerup_splash", var_0);
}

cleanup_visuals() {
  thread cleanup_zombies();
  thread cleanup_marker();
  cleanup_domination_runes();
  cleanup_final_point();
  cleanup_timer();
}

set_start_ui() {
  foreach(var_1 in level.players) {
    var_1 _id_0987::set_objective_ui_counter(0, self.runes.size);
  }

  self.objective_state = 1;
  self.domination_start_time = gettime();
  _id_0987::set_objective_ui_time(120);
  _id_0987::set_objective_ui_state(4, 1, 1);
}

set_final_ui() {
  final_ui_update();
  self.objective_state = 0;
  _id_0987::set_objective_ui_state(4, 0, 4);
}

final_ui_update() {
  var_0 = level.dominationfinalkillcount;
  var_1 = level.dominationcounter;

  foreach(var_3 in level.players) {
    var_3 thread _id_0987::set_objective_ui_counter(level.dominationfinalkillcount, level.dominationcounter);
  }
}

set_end_ui() {
  level thread _id_0987::set_objective_ui_state(4, 0, 2);
}

set_temp_text(var_0) {
  var_1 = (1, 1, 1);
  var_2 = 10;

  foreach(var_4 in level.players) {
    var_4 iprintlnbold(var_0);
  }
}

start_marker() {}

cleanup_marker() {}

update_marker(var_0) {}

cleanup_domination_runes() {
  remove_all_runes();
  self.capturedrunecount = 0;
  self.runes = undefined;
  self.activerunezombiespawners = undefined;
  self.idleduration = undefined;
  self.idlerunes = undefined;
}

get_runes() {
  if(isDefined(self.runes)) {
    return self.runes;
  }

  self.runes = [];
  var_0 = get_rune_limit();
  var_1 = self._id_3BE8["domination_rune_cluster"];
  var_1 = scripts\engine\utility::array_randomize(var_1);
  var_2 = 0;

  foreach(var_4 in var_1) {
    if(var_2 >= var_1.size || var_2 == var_0) {
      break;
    }

    var_5 = manual_rune_filter(var_4);
    var_6 = randomintrange(0, var_5.size);
    self.runes[self.runes.size] = var_5[var_6];
    var_2++;
  }

  return self.runes;
}

get_objective_positions() {
  var_0 = level._id_3BE9._id_0F51;

  if(!isDefined(var_0.runes)) {
    return undefined;
  }

  var_1 = [];

  foreach(var_3 in var_0.runes) {
    if(!is_rune_removed(var_3)) {
      var_1[var_1.size] = var_3.origin;
    }
  }

  return var_1;
}

get_runes_from_map(var_0) {
  var_1 = "domination_rune";
  var_2 = var_0._id_3BE8[var_1];

  if(!isDefined(var_2) || var_2.size == 0) {
    var_2 = [];
    var_3 = spawnStruct();
    var_3._id_0481 = var_1;
    var_3.origin = var_0.origin;
    var_3.angles = var_0.angles;
    var_3.target = var_0._id_0481;
    var_2[var_2.size] = var_3;
  }

  return var_2;
}

get_rune_limit() {
  if(getdvarint("#x35ebf78b157e35afa", 0) > 0) {
    return getdvarint("#x35ebf78b157e35afa", 0);
  }

  var_0 = level.players.size;

  switch (var_0) {
    case 1:
      return 10;
    case 2:
      return 17;
    case 3:
      return 24;
    default:
      return 30;
  }
}

init_domination_runes() {
  self.capturedrunecount = 0;
  var_0 = get_runes();

  foreach(var_2 in var_0) {
    var_2 init_rune(var_2.origin, (0, 0, 0));
  }
}

idle_runes_update() {
  self endon("players_dead");
  self endon("game_ended");
  self endon("domination_capture_ended");
  level endon("domination_completed");
  self.idleduration = 0;
  var_0 = 0.1;

  for(;;) {
    waittillframeend;

    if(self.idleduration > get_spawner_trigger_elapsed_time() + 2) {
      check_in_idle_rune_zombie_spawner(self);
      self.idleduration = 0;
    }

    var_1 = var_0;

    foreach(var_3 in self.runes) {
      if(isDefined(var_3.dominationduration) && var_3.dominationduration > 0) {
        self.idleduration = 0;
        var_1 = 0;
        break;
      }
    }

    self.idleduration = self.idleduration + var_1;
    wait(var_0);
  }
}

cleanup_rune(var_0) {
  if(is_rune_removed(self)) {
    return;
  }
  foreach(var_2 in self.players) {
    var_2 _meth_83EF("zmb_cap_progress_bar");
  }

  foreach(var_2 in level.players) {
    if(get_is_in_rune(var_2, self)) {
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
  self.zombieboundary delete();
  self.zombieboundary = undefined;
  self.dominationduration = 0;
  thread hide_rune(var_0);
}

init_rune(var_0, var_1) {
  var_2 = var_0 + var_1;
  self._id_2958 = spawn("trigger_radius", var_2, 0, 55, 55);
  self.zombieboundary = spawn("trigger_radius", var_2, 0, 300, 300);
  var_3 = (0, 0, 0);
  self._id_04ED = spawn("script_model", var_2 + var_3);
  self._id_04ED setModel("tag_origin");
}

show_rune() {
  var_0 = scripts\engine\utility::getfx("domination_rune_idle");
  playFXOnTag(var_0, self._id_04ED, "tag_origin");

  if(!_func_0205("zmb_cap_rune_lp")) {
    return;
  }
  if(!isDefined(self._id_04ED)) {
    return;
  }
  self._id_04ED playLoopSound("zmb_cap_rune_lp", self._id_04ED.origin);
}

hide_rune(var_0) {
  if(isDefined(self.capturingfx)) {
    kill_rune_fx(scripts\engine\utility::getfx(self.capturingfx));
  }

  if(isDefined(var_0)) {
    switch (var_0) {
      case "domination_rune_captured":
        self._id_04ED stoploopsound("zmb_cap_rune_lp");
        self._id_04ED playSound("zmb_cap_rune_capped");
        var_1 = scripts\engine\utility::getfx(var_0);
        playFXOnTag(var_1, self._id_04ED, "tag_origin");
        wait 0.3;
        kill_rune_fx(scripts\engine\utility::getfx("domination_rune_idle"));
        wait 1;
        kill_rune_fx(var_1);
        break;
      case "domination_rune_zombie_spawn":
        var_1 = scripts\engine\utility::getfx(var_0);
        playFXOnTag(var_1, self._id_04ED, "tag_origin");
        wait 0.5;
        kill_rune_fx(scripts\engine\utility::getfx("domination_rune_idle"));
        wait 1;
        kill_rune_fx(var_1);
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

kill_rune_fx(var_0) {
  if(isDefined(self._id_04ED)) {
    _func_012F(var_0, self._id_04ED, "tag_origin");
  }
}

show_rune_capturing(var_0, var_1) {
  var_2 = "domination_rune_capturing_1";

  if(var_0 <= 25) {
    var_2 = "domination_rune_capturing_4";
  } else if(var_0 <= 50) {
    var_2 = "domination_rune_capturing_3";
  } else if(var_0 <= 75) {
    var_2 = "domination_rune_capturing_2";
  }

  var_3 = undefined;

  if(var_1 < 75 && var_0 >= 75) {
    var_3 = "zmb_cap_ring_4";
  } else if(var_1 < 50 && var_0 >= 50) {
    var_3 = "zmb_cap_ring_3";
  } else if(var_1 < 25 && var_0 >= 25) {
    var_3 = "zmb_cap_ring_2";
  } else if(var_0 == 0) {
    var_3 = "zmb_cap_ring_1";
  }

  if(isDefined(var_3)) {
    foreach(var_5 in self.players) {
      var_5 playlocalsound(var_3, self.origin);
    }
  }

  if(scripts\engine\utility::is_equal(self.capturingfx, var_2)) {
    return;
  }
  if(isDefined(self.capturingfx)) {
    _func_012F(scripts\engine\utility::getfx(self.capturingfx), self._id_04ED, "tag_origin");
  }

  self.capturingfx = var_2;
  playFXOnTag(scripts\engine\utility::getfx(self.capturingfx), self._id_04ED, "tag_origin");
}

hide_rune_capturing() {
  if(isDefined(self.capturingfx)) {
    _func_012F(scripts\engine\utility::getfx(self.capturingfx), self._id_04ED, "tag_origin");
  }
}

start_domination_runes() {
  foreach(var_1 in self.runes) {
    var_1 show_rune();
    var_1 thread rune_update(self);
    var_1 thread zombie_spwaner_trigger_update(self, var_1);
    waitframe();
  }

  idle_runes_update();
}

rune_update(var_0) {
  var_0 endon("players_dead");
  var_0 endon("game_ended");
  var_0 endon("domination_capture_ended");
  level endon("domination_completed");
  var_1 = 0.05;
  var_2 = var_1;
  self.dominationduration = 0;

  for(;;) {
    if(is_rune_removed(self)) {
      break;
    }

    self.players = [];

    foreach(var_4 in level.players) {
      if(var_4 istouching(self._id_2958) && isalive(var_4) && !istrue(var_4.inlaststand)) {
        self.players[self.players.size] = var_4;

        if(!isDefined(var_4.iscapturingrunecluster)) {
          var_4 playlocalsound("zmb_cap_progress_bar");
          var_4.b_disable_player_intersection_tracker = 1;
        }

        var_4.iscapturingrunecluster = self.target;
        var_4.currentrune = self;
        continue;
      }

      if(isDefined(var_4.currentrune)) {
        if((!var_4 istouching(var_4.currentrune._id_2958) || !isalive(var_4) || istrue(var_4.inlaststand)) && istrue(var_4.iscapturinguion)) {
          hide_capturing_ui(var_4);
          var_4.iscapturingrunecluster = undefined;
          var_4.currentrune = undefined;
        }
      }
    }

    if(self.players.size > 0) {
      if(self.dominationduration <= 0) {
        on_enter_rune();
      }

      var_6 = var_2;

      if(level.players.size > 1) {
        var_7 = (self.players.size - 1) / (level.players.size - 1);
        var_6 = var_2 + var_2 * 0.6 * var_7;
      }

      self.dominationduration = self.dominationduration + var_6;
      rune_capturing_update();

      if(self.dominationduration >= 6) {
        foreach(var_4 in self.players) {
          var_4.n_capture_runes = scripts\cp\utility::_id_459B(var_4.n_capture_runes, 0);
          var_4.n_capture_runes++;
        }

        on_captured_rune(var_0);
        cleanup_rune("domination_rune_captured");
        break;
      }
    } else if(self.dominationduration > 0) {
      self.dominationduration = self.dominationduration - var_1;
      on_exit_rune();
    }

    wait(var_1);
  }
}

rune_capturing_update() {
  if(!isDefined(self.players)) {
    return;
  }
  show_rune_capturing_ui();
}

on_enter_rune() {}

on_exit_rune() {
  if(isDefined(self.dominationduration) && self.dominationduration > 0) {
    foreach(var_1 in level.players) {
      if(get_is_in_rune(var_1, self)) {
        hide_capturing_ui(var_1);
      }
    }

    return;
  }

  hide_rune_capturing();

  foreach(var_1 in level.players) {
    if(get_is_in_rune(var_1, self)) {
      hide_capturing_ui(var_1);
      var_1.iscapturingrunecluster = undefined;
      var_1.currentrune = undefined;
      self.dominationduration = 0;
    }
  }
}

get_is_in_rune(var_0, var_1) {
  return isDefined(var_0.iscapturingrunecluster) && scripts\engine\utility::is_equal(var_1.target, var_0.iscapturingrunecluster);
}

get_rune_percentage() {
  var_0 = int(self.dominationduration * 100 / 6);
  return var_0;
}

get_rune_capturing_rate() {
  var_0 = 0;

  if(isDefined(self.dominationduration) && self.dominationduration > 0) {
    var_0 = float(self.dominationduration / 6);
  }

  return var_0;
}

show_rune_capturing_ui() {
  if(!isDefined(self.previous_capture_percentage) || !isDefined(self.current_capture_percentage)) {
    self.previous_capture_percentage = get_rune_percentage();
  } else {
    self.previous_capture_percentage = self.current_capture_percentage;
  }

  self.current_capture_percentage = get_rune_percentage();

  foreach(var_1 in level.players) {
    if(get_is_in_rune(var_1, self)) {
      if(get_is_in_rune(var_1, self)) {
        if(!isDefined(var_1.iscapturinguion) || !scripts\engine\utility::is_equal(var_1.iscapturinguion, 1)) {
          var_1 _id_0987::set_center_bar_state(1);
          var_1.iscapturinguion = 1;
        }

        var_1 thread _id_0987::set_center_bar_progress(self.current_capture_percentage / 100);
      }
    }
  }

  show_rune_capturing(self.current_capture_percentage, self.previous_capture_percentage);
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

toggle_ent(var_0, var_1) {
  if(var_1) {
    var_0 show();
  } else {
    var_0 hide();
  }
}

on_captured_rune(var_0) {
  var_0.capturedrunecount++;

  if(isDefined(self.players)) {
    foreach(var_2 in self.players) {
      var_2 thread _id_0752::_id_7003("domination_fully_capture_point");
    }
  }

  foreach(var_2 in level.players) {
    var_2 _id_0987::set_objective_ui_counter(var_0.capturedrunecount, var_0.runes.size);
  }

  var_6 = !isDefined(var_0.capture_vo_last_played_time) || gettime() - var_0.capture_vo_last_played_time > 30;
  var_7 = !istrue(var_0.capture_vo_played) || var_6 && randomfloat(1.0) < 0.1;

  if(istrue(var_0.kickoff_vo_complete) && var_7) {
    var_0.capture_vo_played = 1;
    var_0.capture_vo_last_played_time = gettime();

    if(_func_0121(var_0.override_capture_vo)) {
      thread _id_0720::play_narration(var_0.override_capture_vo, 0);
    } else {
      thread _id_0720::play_narration("zm_cmcp_obdm_krtx_dr1c");
    }
  }

  var_0 check_capture_ending_condition();
}

get_are_all_runes_captured(var_0) {
  return var_0.capturedrunecount >= var_0.runes.size;
}

is_rune_removed(var_0) {
  return !isDefined(var_0._id_2958);
}

remove_all_runes() {
  foreach(var_1 in self.runes) {
    var_1 cleanup_rune();
  }
}

check_capture_ending_condition() {
  if(self.capturedrunecount >= self.runes.size) {
    level notify("domination_completed");
  }
}

get_closest_rune(var_0, var_1) {
  var_2 = 999999999;
  var_3 = undefined;

  foreach(var_5 in self.runes) {
    if(!isDefined(var_5)) {
      continue;
    }
    if(!istrue(var_1) && is_rune_removed(var_5)) {
      continue;
    }
    var_6 = distancesquared(var_0.origin, var_5.origin);

    if(isDefined(var_6) && var_6 < var_2) {
      var_2 = var_6;
      var_3 = var_5;
    }
  }

  return var_3;
}

get_random_rune(var_0) {
  self endon("players_dead");
  self endon("game_ended");
  level endon("domination_completed");
  var_1 = scripts\engine\utility::array_randomize(self.runes);

  foreach(var_3 in var_1) {
    if(istrue(var_0)) {
      return var_3;
    }

    if(!is_rune_removed(var_3)) {
      return var_3;
    }
  }

  return undefined;
}

init_final_point() {
  var_0 = self._id_3BE8["domination_final_point"][0].origin;
  var_1 = scripts\engine\utility::getfx("domination_portal_air");
  self.finalpoint = spawn("script_model", var_0 + (0, 0, 96));
  self.finalpoint setModel("tag_origin");
  self.finalpoint.fx_final_portal = playFXOnTag(var_1, self.finalpoint, "tag_origin");
  self.finalpoint playLoopSound("zmb_dom_orb_lp");
}

set_final_point_active() {
  if(!isDefined(self.finalpoint)) {
    return;
  }
  if(isDefined(self.finalpoint.fx_final_portal)) {
    stopFXOnTag(scripts\engine\utility::getfx("domination_portal_air"), self.finalpoint, "tag_origin");
  }

  play_final_portal_zombie_spawn_fx();
  level.zombie_spawn_supplemental_fx = "domination_portal_flash";
}

play_final_portal_zombie_spawn_fx() {
  var_0 = scripts\engine\utility::getfx("domination_portal_air_collapse");
  self.finalpoint.fx_final_portal = playFXOnTag(var_0, self.finalpoint, "tag_origin");
  self.finalpoint playSound("zmb_dom_orb_tentacle_spawn");
}

cleanup_final_point() {
  self.finalpoint delete();
  self.finalpoint = undefined;
}

_id_E65A() {
  self endon("players_dead");
  self endon("game_ended");
  level endon("domination_completed");
  var_0 = 0;
  var_1 = 1;

  for(;;) {
    _id_0987::set_objective_ui_time(120 - var_0);
    update_marker(var_0 / 120);

    if(var_0 >= 120) {
      if(!get_are_all_runes_captured(self)) {
        self notify("domination_capture_ended");
        waitframe();
        start_final();
      }

      break;
    }

    if(var_0 == 40) {
      if(_func_0107(self.override_encouragement_vo1)) {
        thread play_encouragement_narration(self.override_encouragement_vo1["str_rune_prog_vo"], self.override_encouragement_vo1["str_rune_prog_vo_resp"]);
      } else {
        thread play_encouragement_narration("zm_cmcp_obdm_dnrt_dr2s", "zm_cmcp_obdm_krtx_dr2c");
      }
    }

    if(var_0 == 60) {
      if(_func_0107(self.override_encouragement_vo2)) {
        thread play_encouragement_narration(self.override_encouragement_vo2["str_rune_prog_vo"], self.override_encouragement_vo2["str_rune_prog_vo_resp"]);
      } else {
        thread play_encouragement_narration("zm_cmcp_obdm_dnrt_dr2s", "zm_cmcp_obdm_krtx_dr2c");
      }
    }

    wait(var_1);
    var_0 = var_0 + var_1;
  }
}

play_encouragement_narration(var_0, var_1) {
  if(_func_0121(var_0)) {
    thread _id_0720::play_narration(var_0);
    level waittill("dialogue_finished");
  }

  if(_func_0121(var_1)) {
    thread _id_0720::play_narration(var_1);
    level waittill("dialogue_finished");
  }
}

cleanup_timer() {}

zombie_spwaner_trigger_update(var_0, var_1) {
  var_0 endon("players_dead");
  var_0 endon("game_ended");
  var_0 endon("domination_capture_ended");
  level endon("domination_completed");
  var_2 = scripts\engine\utility::getstruct(var_1.target, "targetname");

  for(;;) {
    waittillframeend;

    if(is_rune_removed(var_1)) {
      break;
    }

    foreach(var_4 in level.players) {
      var_5 = var_1 get_is_in_allowing_spawn_range(var_4);

      if(var_5) {
        var_6 = check_in_rune_zombie_spawner(var_0, var_2);
      }
    }

    wait 1;
  }
}

get_spawner_trigger_elapsed_time() {
  if(isDefined(self.spawnertriggerelapsedtime)) {
    return self.spawnertriggerelapsedtime;
  }

  var_0 = 6;

  if(level._id_11049 > 1 && level._id_11049 < 100) {
    var_1 = int(_func_0218(level._id_11049 - 1) * 100);
    var_0 = (1 - var_1 * 0.001) * 6;
  }

  if(var_0 < 2 || level._id_11049 >= 100) {
    var_0 = 2;
  }

  self.spawnertriggerelapsedtime = var_0;
  return self.spawnertriggerelapsedtime;
}

get_is_in_allowing_spawn_range(var_0) {
  if(!isalive(var_0) || istrue(var_0.inlaststand)) {
    return 0;
  }

  if(isDefined(var_0.dominationzombierunecluster)) {
    return 0;
  }

  var_1 = get_is_in_rune_spawn_trigger(var_0);

  if(!istrue(var_1)) {
    return 0;
  }

  var_0.dominationzombierunecluster = self.target;
  thread player_zombie_rune_cluster_resetter(var_0);
  return var_1;
}

get_is_in_rune_spawn_trigger(var_0) {
  var_1 = var_0 istouching(self.zombieboundary);

  if(!istrue(var_1)) {
    return 0;
  }

  var_2 = abs(var_0.origin[2] - self.origin[2]);

  if(var_2 > 50) {
    return 0;
  }

  return 1;
}

player_zombie_rune_cluster_resetter(var_0) {
  var_1 = level._id_3BE9._id_0F51;
  var_1 endon("players_dead");
  var_1 endon("game_ended");
  var_1 endon("domination_capture_ended");
  level endon("domination_completed");
  var_0 endon("disconnect");
  level endon("game_ended");
  var_2 = var_1 get_spawner_trigger_elapsed_time();
  var_2 = scripts\cp\utility::_id_459B(var_2, 1);
  wait(var_2);

  if(isDefined(var_0.dominationzombierunecluster) && scripts\engine\utility::is_equal(var_0.dominationzombierunecluster, self.target)) {
    var_0.dominationzombierunecluster = undefined;
  } else {
    var_3 = var_1 get_closest_rune(var_0, 1);

    if(isDefined(var_3)) {
      var_4 = scripts\engine\utility::getstruct(var_3.target, "targetname");
      check_in_rune_zombie_spawner(var_1, var_4);
    }
  }
}

check_in_idle_rune_zombie_spawner(var_0) {
  if(!isDefined(var_0.idlerunes)) {
    var_0.idlerunes = [];
  }

  var_1 = [];

  foreach(var_3 in level.players) {
    var_4 = var_0 get_closest_rune(var_3, 0);

    if(isDefined(var_4)) {
      var_1[var_1.size] = var_4;
    }
  }

  if(var_1.size == 0) {
    return;
  }
  var_6 = randomint(var_1.size);
  var_0.idlerunes[var_0.idlerunes.size] = var_1[var_6];
}

check_in_rune_zombie_spawner(var_0, var_1) {
  if(!isDefined(var_1)) {
    return 0;
  }

  if(!isDefined(var_0.activerunezombiespawners)) {
    var_0.activerunezombiespawners = [];
  }

  var_2 = get_zombies_spawner_name(var_0, var_1);

  foreach(var_4 in var_0.activerunezombiespawners) {
    if(var_4 == var_2) {
      return 0;
    }
  }

  var_0.activerunezombiespawners[var_0.activerunezombiespawners.size] = var_2;
  return 1;
}

zombie_spawner_update() {
  self endon("players_dead");
  self endon("game_ended");
  self endon("domination_capture_ended");
  level endon("domination_completed");
  var_0 = 1;

  for(;;) {
    if(isDefined(self.activerunezombiespawners) && self.activerunezombiespawners.size > 0) {
      run_spawner_once(self.activerunezombiespawners[0]);
      self.activerunezombiespawners = scripts\engine\utility::array_remove_index(self.activerunezombiespawners, 0);
    } else if(isDefined(self.idlerunes) && self.idlerunes.size > 0)
      do_spawn_idle_rune_zombie();

    wait(var_0);
  }
}

do_spawn_idle_rune_zombie() {
  var_0 = self.idlerunes[0];
  var_1 = isDefined(self.idleduration) && self.idleduration > 0;

  if(var_1) {
    var_2 = 0;

    foreach(var_4 in level.players) {
      if(var_0 get_is_in_rune_spawn_trigger(var_4)) {
        var_2 = 1;
        break;
      }
    }

    if(istrue(var_2)) {
      var_6 = scripts\engine\utility::getstruct(var_0.target, "targetname");
      check_in_rune_zombie_spawner(self, var_6);
    } else
      run_spawner_once("none", get_rune_center_spawner_structs(var_0));
  }

  self.idlerunes = scripts\engine\utility::array_remove_index(self.idlerunes, 0);
}

run_spawner_once(var_0, var_1) {
  var_2 = get_manually_filtered_spawners(var_0, var_1);
  level thread _id_0991::_id_C9FC(get_zombies_spawner_intensity(), "none", var_2);
  waittillframeend;
  level thread _id_0991::_id_E8E2(0);
}

final_zombies_update() {
  self endon("players_dead");
  self endon("game_ended");
  level endon("domination_completed");
  level thread _id_0991::_id_E8E2(1);
  level thread _id_0987::kill_all_objective_zombies();
  level.dominationfinalstarted = 1;
  level.dominationfinalspawncount = 0;
  level.dominationfinalkillcount = 0;
  level.dominationfinallimit = get_final_zombies_limit(self);
  level.dominationcounter = level.dominationfinallimit;
  set_final_ui();
  wait 3.0;
  spawn_special_zombies();
  thread set_final_point_active();
  level thread _id_0991::_id_C9FC(get_final_zombies_spawner_intensity(self), get_final_zombies_spawner_name());
}

spawn_special_zombies() {
  foreach(var_1 in self.runes) {
    if(should_spawn_special_zombie(var_1)) {
      var_2 = get_rune_center_spawner_structs(var_1);
      level thread _id_0991::_id_C9FC("cp_zm_zod_domination_intensity_final_special", "none", var_2);
      waittillframeend;
      level thread _id_0991::_id_E8E2(0);
      waittillframeend;
    }

    var_1 cleanup_rune("domination_rune_zombie_spawn");
  }
}

get_rune_center_spawner_structs(var_0) {
  if(!isDefined(var_0._id_03E9)) {
    var_0._id_03E9 = spawnStruct();
    var_0._id_03E9._id_0481 = "domination_special_spawner_" + var_0.target;
    var_0._id_03E9._id_039B = "spawn_manager_spawner";
    var_0._id_03E9.origin = var_0.origin;
    var_0._id_03E9.angles = var_0.angles;
    var_0._id_03E9.script_num = 1;
  }

  var_1 = [];
  var_1[var_1.size] = var_0._id_03E9;
  return var_1;
}

should_spawn_special_zombie(var_0) {
  return !is_rune_removed(var_0) && var_0.dominationduration <= 0;
}

get_final_zombies_limit(var_0) {
  var_1 = 0;

  foreach(var_3 in self.runes) {
    if(should_spawn_special_zombie(var_3)) {
      var_1++;
    }
  }

  var_5 = var_0.capturedrunecount / var_0.runes.size;
  var_6 = 5 * level.players.size + 25 * level.players.size * (1 - var_5) + 3 * (level._id_11049 - 1) * level.players.size;
  var_6 = var_6 + var_1;
  var_7 = 200 * level.players.size;

  if(var_6 > var_7) {
    var_6 = var_7;
  }

  return int(var_6);
}

get_is_final_wave() {
  return istrue(level.dominationfinalstarted);
}

get_zombies_spawner_name(var_0, var_1) {
  var_2 = var_0._id_3BE8["domination_spawner_cluster_general"];
  var_3 = undefined;

  foreach(var_5 in var_2) {
    if(var_1._id_039B == var_5._id_0481) {
      var_3 = var_5;
      break;
    }
  }

  var_7 = var_3._id_3BE8["spawn_manager_spawner"];
  return var_7[0]._id_0481;
}

get_zombies_spawner_intensity() {
  return "cp_zm_zod_domination_first_intensity";
}

get_final_zombies_spawner_name() {
  var_0 = self._id_3BE8["domination_spawner_cluster_final"][0];

  if(!isDefined(var_0)) {
    return undefined;
  }

  var_1 = var_0._id_3BE8["spawn_manager_spawner"];
  return var_1[0]._id_0481;
}

get_final_zombies_spawner_intensity(var_0) {
  var_1 = var_0.capturedrunecount / var_0.runes.size;

  if(var_1 < 0.34) {
    return "cp_zm_zod_domination_final_intensity_01";
  } else if(var_1 < 0.67) {
    return "cp_zm_zod_domination_final_intensity_02";
  }

  return "cp_zm_zod_domination_final_intensity_03";
}

get_final_zombies_speedsettings(var_0) {
  if(isDefined(var_0.domination_final_zombie_speed_setting)) {
    return var_0.domination_final_zombie_speed_setting;
  }

  var_1 = var_0.capturedrunecount / var_0.runes.size;
  var_2 = 1;

  if(var_1 < 0.34) {
    var_2 = 3;
  } else if(var_1 < 0.67) {
    var_2 = 2;
  }

  var_0.domination_final_zombie_speed_setting = _id_0991::get_round_number_speed_settings(level.objective_zombie_speed_settings["domination"][var_2]);
  return var_0.domination_final_zombie_speed_setting;
}

cleanup_zombies() {
  level.dominationshouldcheckendcount = undefined;
  level.dominationaicount = undefined;
  level.dominationfinalspawncount = undefined;
  level.dominationcounter = undefined;
  level.dominationfinalkillcount = undefined;
  level.dominationfinalstarted = undefined;
  level.dominationfinallimit = undefined;
  self.spawnertriggerelapsedtime = undefined;
  level.dominationsafecheckon = undefined;
  self.domination_final_zombie_speed_setting = undefined;
  level.zombie_spawn_supplemental_fx = undefined;
}

final_zombie_spawner_safe_check() {
  if(istrue(level.dominationsafecheckon)) {
    return;
  }
  self endon("players_dead");
  self endon("game_ended");
  level endon("domination_completed");
  var_0 = _func_0070();

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = level.dominationcounter - level.dominationfinalkillcount;
  var_2 = var_1 - var_0.size;

  while(var_2 > 0) {
    level.dominationsafecheckon = 1;
    var_3 = get_random_rune(1);
    thread run_spawner_once("none", get_rune_center_spawner_structs(var_3));
    var_2--;

    if(var_2 <= 0) {
      level.dominationsafecheckon = 0;
      break;
    }

    wait 0.2;
  }
}

_id_0C78(var_0) {
  if(!isDefined(level.dominationaicount)) {
    return;
  }
  var_1 = level._id_3BE9._id_0F51;

  if(!isDefined(var_1)) {
    return;
  }
  level.dominationaicount--;

  if(get_is_final_wave()) {
    level.dominationfinalkillcount++;
    var_1 thread verify_kills();
  }
}

verify_kills() {
  self endon("players_dead");
  self endon("game_ended");
  level endon("domination_completed");
  waittillframeend;

  if(isDefined(level.dominationfinalkillcount)) {
    level final_ui_update();
    level check_kill_ending_condition();
  }
}

on_ai_spawned(var_0) {
  var_1 = level._id_3BE9._id_0F51;

  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(level.dominationaicount)) {
    level.dominationaicount = 0;
  }

  level.dominationaicount++;

  if(get_is_final_wave()) {
    set_filtered_ai_difficulty(var_0);
  } else if(randomfloat(1.0) < 0.15 && gettime() - var_0._id_82FC.last_spawn_vo_time > 60000) {
    if(_func_0121(var_1.override_enemy_spawn_vo)) {
      thread _id_0720::play_narration(var_1.override_enemy_spawn_vo, 0);
    } else {
      thread _id_0720::play_narration(["zm_cmcp_obdm_krft_drct", "zm_cmcp_obdm_krtx_drct"]);
    }

    var_0._id_82FC.last_spawn_vo_time = gettime();
  }

  if(isDefined(var_1) && isDefined(var_1.finalpoint) && scripts\engine\utility::is_equal(var_1.objective_state, 0)) {
    var_1.finalpoint.final_portal_fx_zombie_count = scripts\cp\utility::_id_459B(var_1.finalpoint.final_portal_fx_zombie_count, 0);
    var_1.finalpoint.final_portal_fx_zombie_count++;

    if(var_1.finalpoint.final_portal_fx_zombie_count >= 7) {
      var_1.finalpoint.final_portal_fx_zombie_count = 0;
      var_1 play_final_portal_zombie_spawn_fx();
    }
  }

  if(isDefined(level.dominationfinalspawncount)) {
    level.dominationfinalspawncount++;
    level thread check_final_zombie_spawning();
  }
}

check_final_zombie_spawning() {
  if(level.dominationfinalspawncount >= level.dominationfinallimit && !istrue(level.dominationshouldcheckendcount)) {
    waittillframeend;
    level thread _id_0991::_id_E8E2(0);
    level.dominationshouldcheckendcount = 1;
  }
}

set_filtered_ai_difficulty(var_0) {
  if(!isDefined(var_0._id_82FC) || !isDefined(var_0._id_122C)) {
    return;
  }
  var_1 = var_0._id_122C;

  if(var_1._id_1210 != "actor_enemy_base_zombie_cp") {
    return;
  }
  if(!isDefined(level.objective_default_zombie_speed_settings)) {
    _id_0991::setup_objective_zombie_speed_settings();
  }

  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = get_final_zombies_speedsettings(level._id_3BE9._id_0F51);

  if(isDefined(var_5)) {
    switch (level.players.size) {
      case 1:
        var_2 = var_5.onepsupersprintchance;
        var_3 = var_5.onepsprintchance;
        var_4 = var_5.oneprunchance;
        break;
      case 2:
        var_2 = var_5.twopsupersprintchance;
        var_3 = var_5.twopsprintchance;
        var_4 = var_5.twoprunchance;
        break;
      case 3:
        var_2 = var_5.threepsupersprintchance;
        var_3 = var_5.threepsprintchance;
        var_4 = var_5.threeprunchance;
        break;
      case 4:
        var_2 = var_5.fourpsupersprintchance;
        var_3 = var_5.fourpsprintchance;
        var_4 = var_5.fourprunchance;
        break;
    }
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  var_6 = "walk";
  var_7 = randomfloat(1);

  if(var_2 > 0 && var_7 <= var_2) {
    var_6 = "super_sprint";
  } else if(var_3 > 0 && var_7 <= var_3) {
    var_6 = "sprint";
  } else if(var_4 > 0 && var_7 <= var_4) {
    var_6 = "run";
  }

  var_1[[var_1._id_D603]](var_6);
}

on_player_spawned() {
  if(isDefined(level._id_3BE9) && isDefined(level._id_3BE9._id_0F51) && scripts\engine\utility::is_equal(level._id_3BE9._id_0F51._id_3BE5, "domination")) {
    if(scripts\engine\utility::is_equal(level._id_3BE9._id_0F51.objective_state, 0)) {
      _id_0987::set_objective_ui_state(4, 0, 5);

      if(isDefined(level.dominationfinalkillcount)) {
        thread _id_0987::set_objective_ui_counter(level.dominationfinalkillcount, level.dominationcounter);
      } else {
        thread _id_0987::set_objective_ui_counter(level.dominationcounter, level.dominationcounter);
      }
    } else {
      _id_0987::set_objective_ui_state(4, 1, 5);
      var_0 = 0;
      var_0 = 120;

      if(isDefined(level._id_3BE9._id_0F51.domination_start_time)) {
        var_1 = (gettime() - level._id_3BE9._id_0F51.domination_start_time) / 1000;
        var_0 = int(_func_0037(120 - var_1));
      }

      _id_0987::set_objective_ui_time(var_0);

      if(isDefined(level._id_3BE9._id_0F51.capturedrunecount)) {
        _id_0987::set_objective_ui_counter(level._id_3BE9._id_0F51.capturedrunecount, get_rune_limit());
      } else {
        _id_0987::set_objective_ui_counter(0, get_rune_limit());
      }
    }
  }
}

manual_rune_filter(var_0) {
  var_1 = get_runes_from_map(var_0);
  var_2 = [];

  switch (var_0._id_0481) {
    case "sumpf_domination_rune_cluster_26":
    case "sumpf_domination_rune_cluster_02":
    case "sumpf_domination_rune_cluster_09":
      var_3 = var_1[0];

      foreach(var_5 in var_1) {
        if(var_5.origin[1] > var_3.origin[1]) {
          var_3 = var_5;
        }
      }

      var_2[var_2.size] = var_3;
      break;
    case "red_star_alley_domination_rune_cluster_14":
    case "basement_outdoor_domination_rune_cluster_04":
    case "basement_outdoor_domination_rune_cluster_27":
      var_3 = var_1[0];

      foreach(var_5 in var_1) {
        if(var_5.origin[0] < var_3.origin[0]) {
          var_3 = var_5;
        }
      }

      var_2[var_2.size] = var_3;
      break;
    default:
      var_2 = var_1;
      break;
  }

  return var_2;
}

get_manually_filtered_spawners(var_0, var_1) {
  if(isDefined(var_1)) {
    return var_1;
  }

  var_2 = scripts\engine\utility::getStructArray(var_0, "targetname");

  switch (var_0) {
    case "basement_outdoor_domination_spawner_03":
      var_3 = var_2[0];

      foreach(var_5 in var_2) {
        if(var_3.origin[1] < var_5.origin[1]) {
          var_3 = var_5;
        }
      }

      var_2 = scripts\engine\utility::array_remove(var_2, var_3);
      break;
    default:
      break;
  }

  return var_2;
}