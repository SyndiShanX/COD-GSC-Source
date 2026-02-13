/******************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zm_round_accelerant.gsc
******************************************************/

init_round_accelerant() {
  level._effect["vfx_stone_glow_ambient"] = loadfx("vfx/s4/level/cp_sumpf/vfx_stone_glow_ambient.vfx");
  level._effect["vfx_stone_glow_ambient_weak"] = loadfx("vfx/s4/level/cp_sumpf/vfx_stone_glow_ambient_weak.vfx");
  level._effect["vfx_stone_spawn"] = loadfx("vfx/s4/level/cp_sumpf/vfx_stone_spawn.vfx");
  var_0 = scripts\engine\utility::getstruct("round_accelerant", "targetname");
  var_0.b_activate = 0;
  var_0.b_cool_down = 1;
  var_0.mdl = scripts\cp\utility::_id_E190("s4_zm_soul_capture_runestone_02", var_0.origin, var_0.angles);
  var_0.mdl notsolid();
  var_0.mdl thread start_bobbing();
  playFX(level._effect["vfx_stone_spawn"], var_0.mdl.origin, anglesToForward(var_0.mdl.angles), anglestoup(var_0.mdl.angles));
  var_0.mdl._id_605B = playFXOnTag(level._effect["vfx_stone_glow_ambient_weak"], var_0.mdl, "tag_origin");
  level.round_accelerant_super_sprinter_chance = 20;
  level.b_rampage_start = 0;
  level.n_round_count = 0;
  level scripts\engine\utility::_id_5C24("introscreen_over");
  _id_0737::_id_C266("round_accelerant_interaction", ::hint_interact_round_accelerant, ::on_interact_round_accelerant, undefined, undefined, undefined, undefined, undefined, 1, "v_ui_icons_zombies_minimap_objective", 64);
  _id_0737::addinteractionhinttypecallback("round_accelerant_interaction", ::round_accelerant_interact_type);
  level thread round_accelerant_adjust_check();
  level thread round_accelerant_listener();
}

start_bobbing() {
  level endon("game_ended");
  self endon("death");
  self playLoopSound("zmb_amb_rampage_stone_lp");
  var_0 = 3;

  for(;;) {
    self movez(var_0, 3);
    self waittill("movedone");
    var_0 = var_0 * -1;
  }
}

set_zombie_speed() {
  if(isDefined(self._id_1210) && self._id_1210 == "actor_enemy_zombie_screamer_cp") {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  wait 1;

  if(!isalive(self)) {
    return;
  }
  self.zombie_move_speed_restore = self._id_91A3._id_02D6;
  var_0 = randomintrange(0, 100);

  if(var_0 <= level.round_accelerant_super_sprinter_chance) {
    if(isDefined(self._id_D603)) {
      self thread[[self._id_D603]]("super_sprint");
    }
  } else if(self._id_91A3._id_02D6 != "sprint" && self._id_91A3._id_02D6 != "super_sprint") {
    if(isDefined(self._id_D603)) {
      self thread[[self._id_D603]]("sprint");
    }
  }
}

restore_zombie_speed() {
  var_0 = _func_0070(level._id_11056);

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isDefined(var_2.zombie_move_speed_restore) && isDefined(var_2._id_D603)) {
      var_2 thread[[var_2._id_D603]](var_2.zombie_move_speed_restore);
    }
  }
}

set_zombie_spawn_delay() {
  return 0.5;
}

set_zombie_round_dealy() {
  return 0.5;
}

hint_interact_round_accelerant(var_0, var_1) {
  if(!istrue(var_0.b_cool_down)) {
    return &"";
  } else if(istrue(var_0.b_activate)) {
    return &"CP_ZMB_INTERACTIONS_TUGOLF/RAMPAGE_DEACTIVATE";
  } else {
    return &"CP_ZMB_INTERACTIONS_TUGOLF/RAMPAGE_ACTIVATE";
  }
}

round_accelerant_interact_type(var_0, var_1) {
  return "HINT_NOICON";
}

on_interact_round_accelerant(var_0, var_1) {
  level endon("game_ended");

  if(!istrue(var_0.b_cool_down)) {
    return;
  }
  if(istrue(var_0.b_activate)) {
    var_0.b_cool_down = 0;
    var_2 = _id_0992::_id_106AF(var_1, 10, "failed deactivate rampage inducer");

    if(!var_2) {
      var_0.b_cool_down = 1;
      return;
    }

    var_0.b_activate = 0;
    level.b_rampage_start = 0;

    if(isDefined(var_0.mdl)) {
      var_0.mdl setModel("s4_zm_soul_capture_runestone_02");
    }

    stopFXOnTag(level._effect["vfx_stone_glow_ambient"], var_0.mdl, "tag_origin");
    scripts\cp\utility::_id_10839(2);
    playFXOnTag(level._effect["vfx_stone_glow_ambient_weak"], var_0.mdl, "tag_origin");
    level thread cleanup_round_accelerant();
    wait 3;
    var_0.b_cool_down = 1;
  } else {
    var_0.b_cool_down = 0;
    var_2 = _id_0992::_id_106AF(var_1, 9, "failed activate rampage inducer");

    if(!var_2) {
      var_0.b_cool_down = 1;
      return;
    }

    var_0.b_activate = 1;
    level.b_rampage_start = 1;
    stopFXOnTag(level._effect["vfx_stone_glow_ambient_weak"], var_0.mdl, "tag_origin");
    scripts\cp\utility::_id_10839(2);
    playFXOnTag(level._effect["vfx_stone_glow_ambient"], var_0.mdl, "tag_origin");

    foreach(var_4 in scripts\cp\utility::_id_6C5C()) {
      if(isPlayer(var_4)) {
        var_4 playsoundtoplayer("zmb_rampage_activate", var_4);
      }
    }

    if(isDefined(var_0.mdl)) {
      var_0.mdl setModel("s4_zm_soul_capture_runestone_02");
    }

    var_6 = _func_0070(level._id_11056);

    foreach(var_8 in var_6) {
      if(!isDefined(var_8._id_D603)) {
        continue;
      }
      var_8.zombie_move_speed_restore = var_8._id_91A3._id_02D6;
      var_9 = randomintrange(0, 100);

      if(var_9 <= level.round_accelerant_super_sprinter_chance && var_8._id_1210 != "actor_enemy_zombie_screamer_cp") {
        var_8 thread[[var_8._id_D603]]("super_sprint");
        continue;
      }

      var_8 thread[[var_8._id_D603]]("run");
    }

    level.override_zombie_speed_set = ::set_zombie_speed;
    level.override_zombie_spawn_delay = ::set_zombie_spawn_delay;
    level.override_zombie_round_delay = ::set_zombie_round_dealy;
    wait 3;
    var_0.b_cool_down = 1;
  }
}

cleanup_round_accelerant() {
  foreach(var_1 in scripts\cp\utility::_id_6C5C()) {
    if(isPlayer(var_1)) {
      var_1 playsoundtoplayer("zmb_rampage_deactivate", var_1);
    }
  }

  level thread restore_zombie_speed();
  level.override_zombie_speed_set = undefined;
  level.override_zombie_spawn_delay = undefined;
  level.override_zombie_round_delay = undefined;
  level notify("round_accelerant_closed");
}

round_accelerant_adjust_check() {
  level endon("game_ended");

  for(;;) {
    level waittill("round_complete");

    if(level._id_11049 % 5 == 0) {
      level.round_accelerant_super_sprinter_chance = level.round_accelerant_super_sprinter_chance + 5;
    }

    if(level._id_11049 >= 56) {
      level thread cleanup_round_accelerant();
      var_0 = scripts\engine\utility::getstruct("round_accelerant", "targetname");

      if(isDefined(var_0.mdl)) {
        var_0.mdl delete();
      }

      _id_0987::remove_instanced_objective_marker(var_0.markerlabel, var_0.instanceindex);
      _id_0737::_id_C3C5(var_0);
      break;
    }
  }
}

round_accelerant_listener() {
  level endon("game_ended");
  level endon("ray_gun_dig_complete");
  var_0 = randomintrange(4, 6);

  for(;;) {
    level waittill("round_complete");

    if(level.b_rampage_start) {
      level.n_round_count++;
    } else {
      level.n_round_count = 0;
      var_0 = randomintrange(4, 6);
    }

    if(level.n_round_count >= var_0) {
      if(!scripts\engine\utility::_id_5C00("setup_current_raygun_dig")) {
        level notify("raygun_dig_enable");
      }

      level.n_round_count = 0;
      var_0 = randomintrange(4, 6);
    }
  }
}