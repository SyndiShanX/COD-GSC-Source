/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zm_flogger.gsc
*************************************************/

init() {
  level._effect["flogger_trap_dust_effect"] = loadfx("vfx/s4/zombie/vfx_flogger_trap_start.vfx");
  level._effect["flogger_trap_blood_effect"] = loadfx("vfx/s4/zombie/vfx_flogger_trap_blood.vfx");
  level._effect["flogger_switch_green_light"] = loadfx("vfx/s4/zombie/vfx_light_cagelight_green.vfx");
  level._effect["flogger_switch_red_light"] = loadfx("vfx/s4/zombie/vfx_light_cagelight_red.vfx");
  level scripts\engine\utility::_id_5C11("flogger_trap_ready");
  level scripts\engine\utility::_id_5C11("flogger_trap_active");
  level thread flogger_init();
}

flogger_init() {
  var_0 = spawnStruct();
  var_1 = getEntArray("flogger_trap_parts", "targetname");

  foreach(var_3 in var_1) {
    if(var_3._id_039B == "pen") {
      var_0.logs = var_3;
      continue;
    }

    if(var_3._id_039B == "pulley") {
      var_0.gears = var_3;
    }
  }

  var_5 = anglesToForward(var_0.logs.angles) * 200;
  var_0.safe_loc[0] = var_0.logs.origin - var_5;
  var_0.safe_loc[1] = var_0.logs.origin + var_5;
  var_6 = spawn("trigger_rotatable_radius", var_0.logs.origin, 0, 25, 160);
  var_7 = spawn("trigger_rotatable_radius", var_0.logs.origin, 0, 25, 160);
  var_8 = anglestoup((0, 0, 90)) * 160 / 2;
  var_6 _meth_80DB();
  var_6 linkto(var_0.logs, "tag_origin", (100, 0, 0) - var_8, (0, 0, 90));
  var_6.center_offset = var_8;
  var_6.score_event_string = "cp_sumpf_trap";
  var_7 _meth_80DB();
  var_7 linkto(var_0.logs, "tag_origin", (-100, 0, 0) - var_8, (0, 0, 90));
  var_7.center_offset = var_8;
  var_7.score_event_string = "cp_sumpf_trap";
  var_0.trigger_left = var_6;
  var_0.trigger_right = var_7;
  var_0.pulleys = [];
  var_5 = anglestoright(var_0.logs.angles) * 115;
  var_0.pulleys[0] = spawn("script_model", var_0.logs.origin - var_5);
  var_0.pulleys[1] = spawn("script_model", var_0.logs.origin + var_5);
  var_5 = anglestoright(var_0.gears.angles) * 115;
  var_0.pulleys[2] = spawn("script_model", var_0.gears.origin - var_5);
  var_0.pulleys[3] = spawn("script_model", var_0.gears.origin + var_5);
  var_0.motors = [];
  var_5 = anglestoright(var_0.gears.angles) * 100;
  var_9 = anglestoup(var_0.gears.angles) * 30;
  var_0.motors[0] = spawn("script_model", var_0.gears.origin - var_5 - var_9);
  var_0.motors[1] = spawn("script_model", var_0.gears.origin + var_5 - var_9);
  level.flogger = var_0;
  level scripts\engine\utility::_id_5C24("interactions_initialized");
  level _id_0737::_id_C266("flogger_trap_interact", undefined, ::flogger_handle_activate, ::flogger_handle_init);
  level._id_8393["flogger_trap_interact"]._id_E3FF = "flogger_trap";
  level._id_8393["flogger_trap_interact"]._id_3D91 = 750;
  level._id_8393["flogger_trap_interact"]._id_7965 = ::flogger_show_hint_string;
  level._id_8393["flogger_trap_interact"].hint_type_func = ::flogger_get_hint_type;
  level._id_8393["flogger_trap_interact"].hintstring_show_cost = 1;
}

flogger_show_hint_string(var_0, var_1) {
  if(isDefined(level.flogger_zone_flag) && !level scripts\engine\utility::_id_5C00(level.flogger_zone_flag)) {
    return &"CP_SUMPF/FLOGGER_LOCKED";
  }

  if(isDefined(var_0._id_3D11)) {
    if(level scripts\engine\utility::_id_5C00("flogger_trap_active")) {
      return &"CP_SUMPF/TRAP_ACTIVE";
    } else {
      return &"CP_SUMPF/TRAP_COOLDOWN";
    }
  } else if(isDefined(level._id_8393["flogger_trap_interact"]._id_3D91) && !var_1 _id_074E::_id_B4C5(level._id_8393["flogger_trap_interact"]._id_3D91))
    return &"CP_SUMPF/TRAP_ACTIVATE_NEED_MONEY";
  else {
    return &"CP_SUMPF/TRAP_ACTIVATE";
  }
}

flogger_get_hint_type(var_0, var_1) {
  if(!isDefined(level.flogger_zone_flag) || level scripts\engine\utility::_id_5C00(level.flogger_zone_flag)) {
    if(!isDefined(var_0._id_3D11)) {
      return "HINT_NOICON";
    }
  }

  return "HINT_NOBUTTON";
}

flogger_handle_init(var_0) {
  if(isDefined(level.flogger.handle_interacts)) {
    return;
  }
  foreach(var_2 in var_0) {
    var_3 = getent(var_2.target, "script_noteworthy");
    var_3 thread floggle_handle_set_state("off");
    var_4 = getent(var_2.target, "targetname");
    var_2._id_73E3 = var_3;
    var_2._id_0278 = var_4;
    var_2._id_ACA3 = 1;
  }

  level.flogger.handle_interacts = var_0;
  level thread flogger_monitor_door_open(var_0);
}

flogger_monitor_door_open(var_0) {
  level endon("game_ended");

  if(isDefined(level.flogger_zone_flag)) {
    level scripts\engine\utility::_id_5C24(level.flogger_zone_flag);
  }

  foreach(var_2 in var_0) {
    _id_0737::add_interaction_marker_internal(var_2, "flogger_trap_interact", "v_ui_icons_zombies_minimap_flogger", 0);
    playFXOnTag(scripts\engine\utility::getfx("flogger_switch_green_light"), var_2._id_0278, "tag_origin");
    var_2._id_ACA3 = undefined;
  }

  level scripts\engine\utility::_id_5C1B("flogger_trap_ready");
}

floggle_handle_set_state(var_0) {
  self endon("death");
  self._id_E747 = scripts\cp\utility::_id_459B(self._id_E747, "off");

  if(!isDefined(var_0)) {
    return;
  }
  if(self._id_E747 != var_0) {
    switch (var_0) {
      case "on":
        self rotatepitch(-180, 0.5, 0, 0.1);
        break;
      case "off":
        self rotatepitch(180, 0.5, 0.1, 0);
        break;
    }

    playsoundatpos(self.origin, "zmb_log_trap_motor_switch");
    self waittill("rotatedone");
    self._id_E747 = var_0;
  }
}

flogger_trap_cooldown(var_0, var_1) {
  level endon("game_ended");
  var_2 = scripts\engine\utility::getfx("flogger_switch_green_light");
  var_3 = scripts\engine\utility::getfx("flogger_switch_red_light");

  foreach(var_5 in var_0) {
    var_5._id_3D11 = 1;
    _func_012F(var_2, var_5._id_0278, "tag_origin");
    playFXOnTag(var_3, var_5._id_0278, "tag_origin");
  }

  wait(var_1);

  foreach(var_5 in var_0) {
    var_5._id_3D11 = undefined;
    _func_012F(var_3, var_5._id_0278, "tag_origin");
    playFXOnTag(var_2, var_5._id_0278, "tag_origin");
  }

  playsoundatpos(var_0[0].origin, "zmb_electrical_trap_ready_alert");
  level _id_0737::refresh_all_players_interaction(var_0);
}

flogger_play_rumble() {
  self endon("death");
  var_0 = gettime() + scripts\cp\utility::_id_CFF0(33);
  wait 2;

  while(gettime() <= var_0) {
    playrumbleonposition("flogger_rumble", self.origin);
    wait 0.5;
  }
}

flogger_handle_activate(var_0, var_1) {
  level endon("game_ended");

  if(!level scripts\engine\utility::_id_5C00("flogger_trap_ready") || level scripts\engine\utility::_id_5C00("flogger_trap_active")) {
    return;
  }
  level.flogger._id_0025 = var_1;
  level.flogger.activation_time = gettime();
  level thread play_flogger_use_vo();
  var_2 = undefined;

  if(isDefined(var_0) && isDefined(var_0._id_039B)) {
    var_2 = scripts\engine\utility::getStructArray(var_0._id_039B, "script_noteworthy");
    level thread flogger_trap_cooldown(var_2, 75);
  }

  level scripts\engine\utility::_id_5C1B("flogger_trap_active");
  _id_06CB::_id_AA49(::flogger_on_ai_damage);
  _id_06CB::_id_AA4A(::flogger_on_ai_killed);

  if(isDefined(var_0) && isDefined(var_0._id_73E3)) {
    var_0._id_73E3 thread floggle_handle_set_state("on");
  }

  var_3 = level.flogger.logs;

  if(isDefined(var_3)) {
    var_3 rotatevelocity((-360, 0, 0), 35, 5, 5);
    var_4 = scripts\engine\utility::getfx("flogger_trap_dust_effect");
    playFX(var_4, var_3.origin);
  }

  var_5 = level.flogger.gears;

  if(isDefined(var_5)) {
    var_5 rotatevelocity((-720, 0, 0), 35, 5, 5);
  }

  foreach(var_7 in level.flogger.pulleys) {
    var_7 thread flogger_pulley_play_sound();
  }

  foreach(var_10 in level.flogger.motors) {
    var_10 thread flogger_motor_play_sound();
  }

  if(isDefined(var_0)) {
    playsoundatpos(var_0.origin, "zmb_log_trap_motor_switch");
  }

  level.flogger thread flogger_whoosh();
  level.flogger.trigger_left thread flogger_do_damage();
  level.flogger.trigger_right thread flogger_do_damage();
  level.flogger.logs thread flogger_play_rumble();
  wait 35;

  if(isDefined(var_0) && isDefined(var_0._id_73E3)) {
    var_0._id_73E3 thread floggle_handle_set_state("off");
  }

  _id_06CB::_id_C416(::flogger_on_ai_damage);
  _id_06CB::_id_C417(::flogger_on_ai_killed);
  level scripts\engine\utility::_id_5C04("flogger_trap_active");

  if(isDefined(var_2)) {
    level _id_0737::refresh_all_players_interaction(var_2);
  }

  level.flogger._id_0025 = undefined;
}

play_flogger_use_vo() {
  level endon("game_ended");

  if(!level scripts\engine\utility::_id_5C00("flogger_use_vo_played")) {
    level thread _id_0720::play_narration(["zm_cpm4_rbm4_krft_mgn1", "zm_cpm4_rbm4_krft_mgn2", "zm_cpm4_rbm4_krft_mgn3", "zm_cpm4_rbm4_krft_mgn4"], 1, 0);
    level waittill("dialogue_finished");
    level scripts\engine\utility::_id_5C1B("flogger_use_vo_played");
  }
}

flogger_whoosh() {
  level endon("game_ended");
  var_0 = self.trigger_left;
  var_1 = self.trigger_right;
  var_2 = -90;

  while(level scripts\engine\utility::_id_5C00("flogger_trap_active")) {
    var_3 = self.logs.angles[0];

    if(var_3 <= var_2) {
      var_4 = var_0.origin + var_0.center_offset;
      var_5 = var_1.origin + var_1.center_offset;

      if(var_4[2] > var_5[2]) {
        var_6 = var_4;
        var_7 = var_5;
      } else {
        var_6 = var_5;
        var_7 = var_4;
      }

      playsoundatpos(var_6, "zmb_log_trap_whoosh_top");
      playsoundatpos(var_7, "zmb_log_trap_whoosh_bottom");
      var_2 = var_2 - 180;
    }

    waitframe();
  }
}

flogger_pulley_play_sound() {
  level endon("game_ended");
  self endon("death");
  self playLoopSound("zmb_log_trap_wheel_lp");
  level scripts\engine\utility::_id_5C30("flogger_trap_active");
  self stoploopsound();
}

flogger_motor_play_sound() {
  level endon("game_ended");
  self endon("death");
  playsoundatpos(self.origin, "zmb_log_trap_motor_start");
  wait 1.7;
  self playLoopSound("zmb_log_trap_motor_lp");
  level scripts\engine\utility::_id_5C30("flogger_trap_active");
  self stoploopsound();
  playsoundatpos(self.origin, "zmb_log_trap_motor_stop");
}

flogger_damage_player(var_0) {
  self endon("death_or_disconnect");
  wait 0.1;
  var_1 = self gettagorigin("j_spine4");
  playFX(var_0, var_1);
  playsoundatpos(var_1, "zmb_flogger_impact");
  self dodamage(self.maxhealth, var_1, self, undefined, "MOD_CRUSH");
  self setvelocity((400, 0, 0));
}

flogger_damage_zombie(var_0, var_1, var_2, var_3) {
  self endon("death");
  wait 0.1;
  var_4 = self gettagorigin("j_spine4");
  playsoundatpos(var_4, "zmb_flogger_impact");

  if(_id_06FE::is_zm_elite()) {
    var_5 = int(self.maxhealth * 0.15);

    if(var_5 < self.health) {
      self.flogger_immune_time = var_2 + 2000;
    }

    self dodamage(var_5, var_4, var_0, var_1, "MOD_CRUSH");
  } else {
    playFX(var_3, var_4);
    self dodamage(self.maxhealth, var_4, var_0, var_1, "MOD_CRUSH");
  }
}

flogger_do_damage() {
  level endon("game_ended");
  self endon("death");
  var_0 = scripts\engine\utility::getfx("flogger_trap_blood_effect");

  while(level scripts\engine\utility::_id_5C00("flogger_trap_active")) {
    self._id_4BEA = 0;
    var_1 = self.origin + self.center_offset;

    foreach(var_3 in level.players) {
      if(!var_3 scripts\cp\utility::_id_8708()) {
        continue;
      }
      var_4 = var_3 getstance();

      if(var_4 == "crouch" || var_4 == "prone") {
        continue;
      }
      if(var_3 issprintsliding()) {
        continue;
      }
      if(distancesquared(var_3.origin, var_1) < 22500) {
        if(var_3 istouching(self)) {
          var_3 thread flogger_damage_player(var_0);
          self._id_4BEA = 1;
        }
      }
    }

    var_6 = scripts\engine\utility::ter_op(isPlayer(level.flogger._id_0025), level.flogger._id_0025, self);
    var_7 = _func_0071(var_1, 150, level._id_11056);

    foreach(var_9 in var_7) {
      if(_func_0458(var_9)) {
        continue;
      }
      var_10 = gettime();

      if(isDefined(var_9.flogger_immune_time) && var_10 < var_9.flogger_immune_time) {
        continue;
      }
      if(var_9 istouching(self)) {
        var_9 thread flogger_damage_zombie(var_6, self, var_10, var_0);
        self._id_4BEA = 1;
      }
    }

    waitframe();
  }
}

is_hit_by_flogger(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  return var_0 == level.flogger.trigger_left || var_0 == level.flogger.trigger_right;
}

flogger_on_ai_damage(var_0) {
  if(is_hit_by_flogger(var_0._id_511D)) {
    var_1 = level.flogger;

    if(isDefined(self._id_110B0) && self._id_110B0 == "trickster") {
      if(!isDefined(self.force_escape_position)) {
        if(isDefined(self._id_0192)) {
          var_2 = self._id_0192.origin;
          var_3 = var_1.safe_loc[0];

          if(distancesquared(var_1.safe_loc[1], var_2) < distancesquared(var_3, var_2)) {
            var_3 = var_1.safe_loc[1];
          }
        } else
          var_3 = scripts\engine\utility::array_random(var_1.safe_loc);

        self.force_escape_position = _func_02A9(var_3, 150);
      }
    }
  }
}

calculate_impact_force(var_0) {
  var_1 = scripts\cp\utility::_id_A2B8(gettime() - self.activation_time);

  if(var_1 < 5) {
    var_2 = var_1 / 5;
  } else if(var_1 > 30) {
    var_2 = (35 - var_1) / 5;
  } else {
    return var_0;
  }

  return _func_025E((0, 0, 0), var_0, clamp(var_2, 0, 1));
}

flogger_on_ai_killed(var_0) {
  var_1 = is_hit_by_flogger(var_0._id_511D);

  if(istrue(var_1)) {
    if(isDefined(self._id_110B0) && self._id_110B0 == "juggernaut") {
      self._id_4C08 = 1;
      self._id_BF53 = level.flogger calculate_impact_force((4000, 0, 1));
    } else
      self._id_BF53 = level.flogger calculate_impact_force((10000, 0, 3));

    self._id_BF52 = "torso_upper";
    self.is_bleeding = 1;
  }

  if(isPlayer(var_0._id_50FF)) {
    level thread _id_070F::createfloggerkillevent(var_0._id_50FF);
  }
}