/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2438.gsc
*************************************************/

init() {
  _id_06CB::_id_AA4A(::_id_AA6D);
  level thread _id_0991::init("cp/zombies/cp_zod_spawn_managers.json");
  _id_0987::_id_C215("holdout", ::_id_7FBE, ::setup, ::_id_8CE4, ::_id_385C, "holdout", undefined, undefined, 10, undefined, undefined, ::on_player_spawned);
  _id_06CB::_id_AA65(::on_player_spawned);
  _id_06CB::_id_0FA4("on_host_migration_end", _id_06CB::on_host_migration_end);
}

_id_7FBE(var_0) {
  var_0._id_0DF6 = var_0._id_3BE8["teleport_pt"];
  var_0._id_529C = 1;
}

setup(var_0) {
  level thread scripts\cp\zombies\objective_barriers::toggle_objective_clip(var_0._id_3BE8["prop"], 1);
}

_id_8CE4(var_0) {
  var_0 notify("teleport_go");
  var_0 notify("holdout_go");
  var_0 setup_holdout_wave_spawners(1);
  _id_06CB::_id_0FA4("zm_spawn_manager_zombie_spawned", ::on_zombie_spawned);
  _func_01E3("holdout");
  thread play_kickoff_vo(var_0);
  _id_E61B(var_0);
  var_0 thread play_wave_2_vo();
  var_0 thread play_wave_3_vo();
  var_0 thread start_waves();
}

start_waves() {
  level endon("game_ended");
  self endon("players_dead");
  self endon("objective_ended");
  self endon("holdout_complete");
  self waittill("kickoff_vo_complete");
  thread _id_9A14();
  level.holdoutperfectdefense = 1;
}

play_kickoff_vo(var_0) {
  wait 1;
  level.holdout_count = scripts\cp\utility::_id_459B(level.holdout_count, 1);
  _id_0987::play_objective_kickoff_narration("holdout", level.holdout_count, var_0, 0);
  level.holdout_count++;
  var_0 thread play_wave_1_vo();
}

play_wave_1_vo() {
  self endon("players_dead");
  level endon("game_ended");
  self endon("objective_ended");
  self endon("holdout_complete");
  thread _id_0720::play_narration("zm_cmcp_obhd_vlst_hw1t");
  level waittill("dialogue_finished");
}

play_wave_2_vo() {
  self endon("players_dead");
  level endon("game_ended");
  self endon("objective_ended");
  self endon("holdout_complete");

  if(self.objective_duration < 120) {
    return;
  }
  wait(self.objective_duration * 0.4);
  thread _id_0720::play_narration("zm_cmcp_obhd_dnvk_hw2e");
  level waittill("dialogue_finished");
}

play_wave_3_vo() {
  self endon("players_dead");
  level endon("game_ended");
  self endon("objective_ended");
  self endon("holdout_complete");

  if(self.objective_duration < 180) {
    return;
  }
  wait(self.objective_duration * 0.7);
  thread _id_0720::play_narration("zm_cmcp_obhd_krtx_hw3t");
  level waittill("dialogue_finished");
}

_id_E61B(var_0) {
  var_0 thread _id_79CF();
}

holdout_setup_ui() {
  set_wave_duration();
  self.holdout_start_time = gettime();
  _id_0987::set_objective_ui_time(self.objective_duration);
  _id_0987::set_objective_ui_state(0, 0, 1);
}

_id_79CF() {
  self endon("players_dead");
  level endon("game_ended");
  thread _id_482C();
  holdout_setup_ui();
  self.objective_start_time = gettime();
  thread holdout_countdown_sfx();
  _id_0987::_id_E65C(self.objective_duration, "holdout");
  _id_0987::set_objective_ui_state(0, 0, 2);
  level thread _id_0991::_id_E8E2(1);
  self notify("holdout_complete");
  self notify("return");
}

complete_objective() {
  _id_0987::set_objective_ui_state(0, 0, 2);
  level notify("timer_stop");
  level thread _id_0991::_id_E8E2(1);
  level._id_3BE9._id_0F51 notify("holdout_complete");
  level._id_3BE9._id_0F51 notify("return");
}

setup_holdout_wave_spawners(var_0) {
  self.holdout_waves = [];

  if(!isDefined(self._id_3BE8[self._id_0481 + "_wave_a"])) {
    return;
  }
  self.holdout_waves_spawners["wave_a_spawners"] = self._id_3BE8[self._id_0481 + "_wave_a"][0]._id_3BE8["spawn_manager_spawner"];
  self.holdout_waves_spawners["wave_b_spawners"] = self._id_3BE8[self._id_0481 + "_wave_b"][0]._id_3BE8["spawn_manager_spawner"];
  self.holdout_waves_spawners["wave_c_spawners"] = self._id_3BE8[self._id_0481 + "_wave_c"][0]._id_3BE8["spawn_manager_spawner"];
  self.holdout_waves_spawners["all_spawners"] = ::scripts\engine\utility::array_combine(self.holdout_waves_spawners["wave_a_spawners"], self.holdout_waves_spawners["wave_b_spawners"], self.holdout_waves_spawners["wave_c_spawners"]);

  if(scripts\engine\utility::is_equal(var_0, 1)) {
    var_1 = ["_wave_a", "_wave_b", "_wave_c"];
    var_2 = randomint(var_1.size);
    var_3 = var_1[var_2];
    self.holdout_waves_spawners["wave_a_spawners"] = self._id_3BE8[self._id_0481 + var_3][0]._id_3BE8["spawn_manager_spawner"];
    var_1 = scripts\engine\utility::array_remove_index(var_1, var_2);
    var_2 = randomint(var_1.size);
    var_3 = var_1[var_2];
    self.holdout_waves_spawners["wave_b_spawners"] = self._id_3BE8[self._id_0481 + var_3][0]._id_3BE8["spawn_manager_spawner"];
    var_1 = scripts\engine\utility::array_remove_index(var_1, var_2);
    var_3 = var_1[0];
    self.holdout_waves_spawners["wave_c_spawners"] = self._id_3BE8[self._id_0481 + var_3][0]._id_3BE8["spawn_manager_spawner"];
  }
}

set_wave_duration() {
  switch (level._id_11049) {
    case 1:
      self.objective_duration = 60;
      break;
    case 2:
      self.objective_duration = 90;
      break;
    case 3:
      self.objective_duration = 120;
      break;
    case 4:
      self.objective_duration = 150;
      break;
    default:
      self.objective_duration = 180;
      break;
  }

  var_0 = getdvarint("#x34ceb1562bb393694", 0);

  if(var_0 > 0) {
    self.objective_duration = var_0;
  }

  self.wave_1_duration = self.objective_duration * 0.15;
  self.wave_2_duration = self.objective_duration * 0.33;
  self.wave_3_duration = self.objective_duration * 0.22;
  self.wave_4_duration = self.objective_duration * 0.3;
}

_id_9A14() {
  self endon("players_dead");
  level endon("game_ended");
  self endon("objective_ended");
  self endon("holdout_complete");
  self.wave_number = 1;

  if(!isDefined(self._id_3BE8[self._id_0481 + "_wave_a"])) {
    level thread _id_0991::_id_C9FC("cp_zm_zod_holdout_intensity_01", self._id_3BE8["spawn_manager_spawner"][0]._id_0481);
  } else {
    level thread _id_0991::_id_C9FC("cp_zm_zod_holdout_intensity_01", undefined, self.holdout_waves_spawners["wave_a_spawners"]);
  }

  wait(self.wave_1_duration);
  level thread _id_0991::_id_E8E2(0);
  waittillframeend;
  self.wave_number = 2;

  if(!isDefined(self._id_3BE8[self._id_0481 + "_wave_b"])) {
    level thread _id_0991::_id_C9FC("cp_zm_zod_holdout_intensity_02", self._id_3BE8["spawn_manager_spawner"][0]._id_0481);
  } else {
    level thread _id_0991::_id_C9FC("cp_zm_zod_holdout_intensity_02", undefined, self.holdout_waves_spawners["wave_b_spawners"]);
  }

  wait(self.wave_2_duration);
  level thread _id_0991::_id_E8E2(0);
  waittillframeend;
  self.wave_number = 3;

  if(!isDefined(self._id_3BE8[self._id_0481 + "_wave_c"])) {
    level thread _id_0991::_id_C9FC("cp_zm_zod_holdout_intensity_03", self._id_3BE8["spawn_manager_spawner"][0]._id_0481);
  } else {
    level thread _id_0991::_id_C9FC("cp_zm_zod_holdout_intensity_03", undefined, self.holdout_waves_spawners["wave_c_spawners"]);
  }

  wait(self.wave_3_duration);
  level thread _id_0991::_id_E8E2(0);
  waittillframeend;
  self.wave_number = 4;

  if(!isDefined(self._id_3BE8[self._id_0481 + "_wave_a"])) {
    level thread _id_0991::_id_C9FC("cp_zm_zod_holdout_intensity_04", self._id_3BE8["spawn_manager_spawner"][0]._id_0481);
  } else {
    level thread _id_0991::_id_C9FC("cp_zm_zod_holdout_intensity_04", undefined, self.holdout_waves_spawners["all_spawners"]);
  }
}

_id_AA6D(var_0) {}

on_zombie_spawned(var_0) {
  if(!isDefined(var_0._id_82FC) || !isDefined(var_0._id_122C) || !isDefined(var_0._id_82FC.wave_number)) {
    return;
  }
  if(!isDefined(level.objective_default_zombie_speed_settings)) {
    _id_0991::setup_objective_zombie_speed_settings();
  }

  var_1 = var_0._id_122C;

  if(var_1._id_1210 == "actor_enemy_base_zombie_cp" || var_1._id_1210 == "actor_enemy_base_zombie_skorpion_cp" || var_1._id_1210 == "actor_enemy_base_zombie_sumpf_cp") {
    var_2 = level._id_11049;
    var_3 = level.players.size;
    var_4 = 0;
    var_5 = 0;
    var_6 = 0;

    switch (var_0._id_82FC.wave_number) {
      case 1:
        var_7 = level.objective_zombie_speed_settings["holdout"][1].roundspeedsetting[0];
        break;
      case 2:
        var_7 = level.objective_zombie_speed_settings["holdout"][2].roundspeedsetting[0];
        break;
      case 3:
        var_7 = level.objective_zombie_speed_settings["holdout"][3].roundspeedsetting[0];
        break;
      case 4:
        var_7 = level.objective_zombie_speed_settings["holdout"][4].roundspeedsetting[0];
        break;
      default:
        var_7 = level.objective_zombie_speed_settings["holdout"][0].roundspeedsetting[0];
        break;
    }

    if(isDefined(var_7)) {
      if(var_3 == 1) {
        if(isDefined(var_7.oneprunchance)) {
          var_6 = var_7.oneprunchance;
        }

        if(isDefined(var_7.onepsprintchance)) {
          var_5 = var_7.onepsprintchance;
        }

        if(isDefined(var_7.onepsupersprintchance)) {
          var_4 = var_7.onepsupersprintchance;
        }
      } else if(var_3 == 2) {
        if(isDefined(var_7.twoprunchance)) {
          var_6 = var_7.twoprunchance;
        }

        if(isDefined(var_7.twopsprintchance)) {
          var_5 = var_7.twopsprintchance;
        }

        if(isDefined(var_7.twopsupersprintchance)) {
          var_4 = var_7.twopsupersprintchance;
        }
      } else if(var_3 == 3) {
        if(isDefined(var_7.threeprunchance)) {
          var_6 = var_7.threeprunchance;
        }

        if(isDefined(var_7.threepsprintchance)) {
          var_5 = var_7.threepsprintchance;
        }

        if(isDefined(var_7.threepsupersprintchance)) {
          var_4 = var_7.threepsupersprintchance;
        }
      } else {
        if(isDefined(var_7.fourprunchance)) {
          var_6 = var_7.fourprunchance;
        }

        if(isDefined(var_7.fourpsprintchance)) {
          var_5 = var_7.fourpsprintchance;
        }

        if(isDefined(var_7.fourpsupersprintchance)) {
          var_4 = var_7.fourpsupersprintchance;
        }
      }
    }

    var_8 = var_4 * var_2;
    var_9 = var_5 * level._id_11049;
    var_10 = var_6 * level._id_11049;

    if(level._id_11049 < 10) {
      var_8 = 0;
    }

    if(var_8 > 0.7) {
      var_8 = 0.7;
    }

    if(var_9 > 0.7) {
      var_9 = 0.7;
    }

    var_11 = randomfloat(1);

    if(var_8 > 0 && var_11 <= var_8) {
      var_1[[var_1._id_D603]]("super_sprint");
    } else if(var_9 > 0 && var_11 <= var_9) {
      var_1[[var_1._id_D603]]("sprint");
    } else if(var_10 > 0 && var_11 <= var_10) {
      var_1[[var_1._id_D603]]("run");
    } else {
      var_1[[var_1._id_D603]]("walk");
    }
  }
}

_id_482C() {
  self endon("objective_ended");
  level endon("game_ended");
  self waittill("return");
  _func_01E3("none");
  _id_0987::play_objective_complete_sfx();
  check_perfect_defense();
  _id_0987::_id_A871(self, 1);
}

_id_385C() {
  _id_06CB::_id_C388("zm_spawn_manager_zombie_spawned", ::on_zombie_spawned, undefined);
  level thread scripts\cp\zombies\objective_barriers::toggle_objective_clip(self._id_3BE8["prop"], 0);

  if(isDefined(self._id_EACB) && self._id_EACB) {
    return;
  }
}

on_player_spawned() {
  if(isDefined(level._id_3BE9) && isDefined(level._id_3BE9._id_0F51) && scripts\engine\utility::is_equal(level._id_3BE9._id_0F51._id_3BE5, "holdout")) {
    var_0 = 0;

    if(isDefined(level._id_3BE9._id_0F51.objective_duration) && isDefined(level._id_3BE9._id_0F51.holdout_start_time)) {
      var_1 = (gettime() - level._id_3BE9._id_0F51.holdout_start_time) / 1000;
      var_0 = int(_func_0037(level._id_3BE9._id_0F51.objective_duration - var_1));
    }

    _id_0987::set_objective_ui_time(var_0);
    _id_0987::set_objective_ui_state(0, 0, 5);
  }
}

check_perfect_defense() {
  if(istrue(level.holdoutperfectdefense)) {
    foreach(var_1 in level.players) {
      var_1 _id_0752::_id_7003("holdout_perfect_defense");
    }
  }

  level.holdoutperfectdefense = undefined;
}

holdout_countdown_sfx() {
  self endon("objective_ended");
  self endon("holdout_complete");
  self endon("return");
  level endon("game_ended");
  var_0 = 0;
  var_1 = self.objective_duration - 10;

  while(var_0 < 10) {
    wait 1;
    var_2 = gettime() - self.objective_start_time;

    if(var_2 < scripts\cp\utility::_id_CFF0(var_1)) {
      continue;
    }
    if(_func_0205("zmb_ui_timer_tick")) {
      foreach(var_4 in level.players) {
        var_4 playsoundtoplayer("zmb_ui_timer_tick", var_4);
      }
    }

    var_0++;
  }
}