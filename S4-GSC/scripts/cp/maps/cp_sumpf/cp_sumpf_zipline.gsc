/*********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_sumpf\cp_sumpf_zipline.gsc
*********************************************************/

init() {
  level._effect["zipline_switch_sparks_effect"] = loadfx("vfx/s4/level/cp_sumpf/vfx_switch_sparks_burst.vfx");
  level._effect["zipline_cabl_sparks_effect"] = loadfx("vfx/s4/level/cp_sumpf/vfx_cable_sparks_burst.vfx");
  level._effect["zipline_cable_spool_sparks_effect"] = loadfx("vfx/s4/level/cp_sumpf/vfx_cable_spool_sparks_burst_grp.vfx");
  level._effect["zipline_power_switch_green_light"] = loadfx("vfx/s4/zombie/vfx_light_cagelight_green.vfx");
  level._effect["zipline_power_switch_red_light"] = loadfx("vfx/s4/zombie/vfx_light_cagelight_red.vfx");
  level thread zipline_init();
  level.check_on_moving_platform_func = ::is_on_zipline;
  level.juggernaut_shoot_sweep_on_zipline_player = 1;
}

zipline_init() {
  level.zipline = getent("sumpf_zipline_wire", "targetname");
  var_0 = getent("zipline_col", "targetname");
  var_0 linkto(level.zipline);
  var_1 = getent("zipline_nav_col", "targetname");
  var_1 linkto(level.zipline);
  level.zipline.nav_clip = var_1;
  var_2 = getent("zipline_ai_block", "targetname");
  var_2 _meth_8093();
  level.zipline.nav_blocker = var_2;
  level.zipline.is_docked = 1;
  level zipline_path_init();
  var_3 = level.zipline_path.first_node;
  var_4 = spawn("script_model", var_3.origin);
  var_4.angles = var_3.angles;
  var_4 setModel("tag_origin");
  var_5 = level.zipline.origin - var_4.origin;
  level.zipline linkto(var_4, "tag_origin", var_5, (0, 0, 0));
  level.zipline._id_94E8 = var_4;
  var_6 = [];
  var_7 = scripts\engine\utility::getStructArray("zipline_motor_loc", "script_noteworthy");

  foreach(var_9 in var_7) {
    var_10 = spawn("script_model", var_9.origin);
    var_10.angles = var_9.angles;
    var_10 setModel("tag_origin");
    var_6 = scripts\engine\utility::array_add(var_6, var_10);
  }

  level.zipline.motors = var_6;
  var_12 = getEntArray("zipline_motor_rotate", "targetname");
  level.zipline.cable_spools = var_12;
  level scripts\engine\utility::_id_5C24("interactions_initialized");
  level _id_0737::_id_C266("zipline_power", undefined, ::zipline_power_on, ::zipline_power_init);
  level._id_8393["zipline_power"]._id_E3FF = "zipline_power";
  level._id_8393["zipline_power"]._id_3D91 = 0;
  level._id_8393["zipline_power"]._id_7965 = ::zipline_show_hint_string;
  level._id_8393["zipline_power"].hint_type_func = ::zipline_get_hint_type;
}

zipline_show_hint_string(var_0, var_1) {
  if(istrue(var_0._id_ACA3)) {
    return &"CP_SUMPF/ZIPLINE_NOT_AVAILABLE";
  }

  if(!level scripts\engine\utility::_id_5C00("zipline_ready")) {
    return &"CP_SUMPF/ZIPLINE_POWER_ON";
  }

  if(isDefined(var_0._id_3D11)) {
    return &"CP_SUMPF/ZIPLINE_COOLDOWN";
  } else if(isDefined(level._id_8393["zipline_power"]._id_3D91) && !var_1 _id_074E::_id_B4C5(level._id_8393["zipline_power"]._id_3D91)) {
    return &"CP_SUMPF/ZIPLINE_ACTIVATE_NEED_MONEY";
  } else {
    return &"CP_SUMPF/ZIPLINE_ACTIVATE";
  }
}

zipline_get_hint_type(var_0, var_1) {
  if(isDefined(var_0._id_3D11) || istrue(var_0._id_ACA3)) {
    return "HINT_NOBUTTON";
  }

  return "HINT_NOICON";
}

is_on_zipline() {
  if(!isPlayer(self)) {
    return 0;
  }

  if(!level scripts\engine\utility::_id_5C00("zipline_moving")) {
    return 0;
  }

  if(isDefined(level.zipline) && isDefined(level.zipline.nav_clip)) {
    var_0 = self _meth_815A();
    return isDefined(var_0) && var_0 == level.zipline.nav_clip;
  }

  return 0;
}

set_zipline_disabled(var_0) {
  var_1 = scripts\engine\utility::array_combine(level.zipline_switch._id_E59D, level.zipline_switch._id_5284);

  foreach(var_3 in var_1) {
    var_3._id_ACA3 = var_0;
  }

  level _id_0737::refresh_all_players_interaction(var_1);
}

zipline_path_init() {
  var_0 = spawnStruct();
  var_0.tracks = [];
  var_1 = scripts\engine\utility::getstruct("zipline_start_node", "targetname");
  var_0.first_node = var_1;

  while(isDefined(var_1)) {
    if(isDefined(var_1.target)) {
      var_2 = spawnStruct();
      var_3 = var_1;
      var_1 = scripts\engine\utility::getstruct(var_1.target, "targetname");
      var_2._id_A578 = [var_3, var_1];
      var_2._id_4B85 = distance(var_3.origin, var_1.origin);
      var_2._id_F1E8 = var_2._id_4B85 / 100;
      var_0.tracks = scripts\engine\utility::array_add(var_0.tracks, var_2);
      continue;
    }

    var_0.last_node = var_1;
    break;
  }

  level.zipline_path = var_0;
}

zipline_power_init(var_0) {
  if(!level scripts\engine\utility::_id_5C0C("zipline_ready")) {
    level scripts\engine\utility::_id_5C11("zipline_ready");
    var_1 = spawnStruct();
    var_1._id_E59D = var_0;
    var_1._id_5284 = [];
    level.zipline_switch = var_1;
    var_2 = spawnStruct();
    var_2.model = getent("zipline_blocker", "targetname");
    var_2._id_39A7 = getent("zipline_blocker_col", "targetname");
    var_2.trigger = spawn("script_model", var_2.model.origin + (50, 50, 50));
    var_2.trigger setModel("tag_origin");
    var_2.trigger makeuseable();
    var_2.trigger setusefov(120);
    var_2.trigger sethintstring(&"CP_SUMPF/ZIPLINE_BLOCKED");
    var_2.trigger setcursorhint("HINT_NOBUTTON");
    level.zipline_blocker = var_2;

    foreach(var_4 in var_0) {
      var_5 = getent(var_4.target, "script_noteworthy");
      var_5 thread zipline_power_handle_set_state("off");
      var_6 = getent(var_4.target, "targetname");
      var_4._id_73E3 = var_5;
      var_4._id_0278 = var_6;
      var_4.marker_label = "zipline_power";
      var_4.marker_params = _id_0737::instantiate_interaction_marker_params(var_4, var_4.marker_label, "v_ui_icons_zombies_minimap_zipline_power");
    }

    level thread zipline_monitor_door_open(var_0);
  }
}

zipline_monitor_door_open(var_0) {
  level endon("game_ended");

  if(isDefined(level.zipline_zone_flag)) {
    level scripts\engine\utility::_id_5C24(level.zipline_zone_flag);
  }

  foreach(var_2 in var_0) {
    var_2.marker_instance = _id_0987::add_instanced_objective_marker(var_2.marker_label, var_2.marker_params);

    if(isDefined(var_2._id_0278)) {
      playFXOnTag(scripts\engine\utility::getfx("zipline_power_switch_green_light"), var_2._id_0278, "tag_origin");
    }
  }
}

zipline_power_on(var_0, var_1) {
  if(!level scripts\engine\utility::_id_5C00("zipline_ready")) {
    if(isDefined(level.zipline_blocker.model)) {
      level.zipline_blocker.model delete();
    }

    if(isDefined(level.zipline_blocker._id_39A7)) {
      level.zipline_blocker._id_39A7 _meth_8093();
      level.zipline_blocker._id_39A7 delete();
    }

    if(isDefined(level.zipline_blocker.trigger)) {
      level.zipline_blocker.trigger delete();
    }

    playsoundatpos(var_0.origin, "zmb_zip_line_power");
    level scripts\engine\utility::_id_5C11("zipline_moving");
    level _id_0737::_id_C266("zipline_switch", undefined, ::zipline_switch_activate, ::zipline_switch_init);
    level._id_8393["zipline_switch"]._id_E3FF = "zipline_switch";
    level._id_8393["zipline_switch"]._id_3D91 = 500;
    level._id_8393["zipline_switch"]._id_7965 = ::zipline_show_hint_string;
    level._id_8393["zipline_switch"].hint_type_func = ::zipline_get_hint_type;
    level._id_8393["zipline_switch"].hintstring_show_cost = 1;
    level._id_8393["zipline_power"]._id_3D91 = 500;
    level._id_8393["zipline_power"].hintstring_show_cost = 1;
    var_2 = spawnStruct();
    var_2._id_E747 = "active";
    var_2._id_96CF = level.zipline;
    var_2._id_7C3B = "v_ui_icons_zombies_minimap_zipline";
    var_2._id_11012 = 40;
    var_2.minimapiconsize = "icon_regular";
    var_2.hideonminimapwhenclipped = 1;
    var_2.setbackground = 1;
    level.zipline.marker_index = _id_0987::_id_0FFD("zipline", var_2);
  }

  level zipline_activate(var_0);

  if(!level scripts\engine\utility::_id_5C00("zipline_ready")) {
    level scripts\engine\utility::_id_5C1B("zipline_ready");

    if(isDefined(var_0) && isDefined(var_0._id_0278)) {
      _func_012F(scripts\engine\utility::getfx("zipline_power_switch_green_light"), var_0._id_0278, "tag_origin");
      playFXOnTag(scripts\engine\utility::getfx("zipline_power_switch_red_light"), var_0._id_0278, "tag_origin");
    }
  }
}

zipline_cooldown(var_0) {
  level endon("game_ended");
  var_1 = scripts\engine\utility::array_combine(level.zipline_switch._id_E59D, level.zipline_switch._id_5284);

  foreach(var_3 in var_1) {
    var_3._id_3D11 = 1;

    if(isDefined(var_3._id_0278) && !var_3._id_4A88) {
      _func_012F(scripts\engine\utility::getfx("zipline_power_switch_green_light"), var_3._id_0278, "tag_origin");
      playFXOnTag(scripts\engine\utility::getfx("zipline_power_switch_red_light"), var_3._id_0278, "tag_origin");
    }
  }

  wait(var_0);

  foreach(var_3 in var_1) {
    var_3._id_3D11 = undefined;

    if(isDefined(var_3._id_0278) && !var_3._id_4A88) {
      _func_012F(scripts\engine\utility::getfx("zipline_power_switch_red_light"), var_3._id_0278, "tag_origin");
      playFXOnTag(scripts\engine\utility::getfx("zipline_power_switch_green_light"), var_3._id_0278, "tag_origin");
    }

    if(var_3._id_039B == "zipline_power" && !var_3._id_4A88 && isDefined(var_3._id_73E3)) {
      var_3._id_73E3 thread zipline_power_handle_set_state("off");
    }
  }

  level _id_0737::refresh_all_players_interaction(var_1);
}

zipline_switch_init(var_0) {
  foreach(var_2 in var_0) {
    var_3 = getent(var_2.target, "script_noteworthy");
    var_3 linkto(level.zipline, "tag_handle");
    var_3 thread zipline_power_handle_set_state("off");
    var_2._id_73E3 = var_3;
    var_2._id_4A88 = 1;

    if(var_2._id_CD99 == "start") {
      level.zipline_switch._id_E59D = scripts\engine\utility::array_add(level.zipline_switch._id_E59D, var_2);
      continue;
    }

    if(var_2._id_CD99 == "end") {
      var_2._id_0375 = 1;
      var_2.dock = 1;
      level.zipline_switch._id_5284 = scripts\engine\utility::array_add(level.zipline_switch._id_5284, var_2);
    }
  }
}

zipline_switch_change(var_0) {
  level endon("game_ended");

  if(var_0) {
    var_1 = level.zipline_switch._id_5284;
    var_2 = level.zipline_switch._id_E59D;
  } else {
    var_1 = level.zipline_switch._id_E59D;
    var_2 = level.zipline_switch._id_5284;
  }

  foreach(var_4 in var_1) {
    var_4._id_4A88 = 1;

    if(isDefined(var_4.marker_instance) && isDefined(var_4.marker_label)) {
      _id_0987::remove_instanced_objective_marker(var_4.marker_label, var_4.marker_instance);
      var_4.marker_instance = undefined;
    }
  }

  level scripts\engine\utility::_id_5C30("zipline_moving");
  wait 1;

  foreach(var_4 in var_2) {
    var_4._id_4A88 = 0;

    if(!isDefined(var_4.marker_instance) && isDefined(var_4.marker_label)) {
      var_4.marker_instance = _id_0987::add_instanced_objective_marker(var_4.marker_label, var_4.marker_params);
    }
  }
}

zipline_switch_activate(var_0, var_1) {
  playFXOnTag(scripts\engine\utility::getfx("zipline_switch_sparks_effect"), level.zipline, "tag_origin");
  level zipline_activate(var_0);
}

zipline_activate(var_0) {
  var_1 = istrue(var_0._id_0375);
  var_2 = istrue(var_0.dock);

  if(level scripts\engine\utility::_id_5C00("zipline_ready")) {
    level thread zipline_cooldown(45);
  }

  level.zipline._id_94E8 thread zipline_move(var_1, var_2);
}

zipline_sway_motion_start(var_0) {
  var_1 = scripts\engine\utility::ter_op(istrue(var_0), -1, 1) * 3;
  self rotateroll(-1 * var_1, 0.5);
  self waittill("rotatedone");
  self rotateroll(var_1, 0.5);
  self waittill("rotatedone");
}

zipline_sway_motion_stop(var_0) {
  var_1 = scripts\engine\utility::ter_op(istrue(var_0), -1, 1) * 3;
  var_2 = scripts\engine\utility::ter_op(istrue(var_0), -1, 1) * 1;
  self rotateroll(var_1, 0.2, 0, 0.2);
  self waittill("rotatedone");
  self rotateroll(-1 * (var_1 + var_2), 0.4, 0.4, 0);
  self waittill("rotatedone");
  self rotateroll(var_2, 0.2, 0.2, 0);
  self waittill("rotatedone");
}

zipline_rotate() {}

zipline_motor_play_sound() {
  level endon("game_ended");
  self endon("death");
  playsoundatpos(self.origin, "zmb_zip_line_motor_start");
  wait 1.7;
  self playLoopSound("zmb_zip_line_motor_lp");
  level scripts\engine\utility::_id_5C30("zipline_moving");
  self stoploopsound();
  playsoundatpos(self.origin, "zmb_zip_line_motor_stop");
}

zipline_motor_play_effect() {
  level endon("game_ended");
  self endon("death");
  var_0 = scripts\engine\utility::getfx("zipline_cable_spool_sparks_effect");
  playFXOnTag(var_0, self, "tag_origin");
  level scripts\engine\utility::_id_5C30("zipline_moving");
  stopFXOnTag(var_0, self, "tag_origin");
}

zipline_spool_rotate(var_0) {
  level endon("game_ended");
  var_1 = scripts\engine\utility::ter_op(istrue(var_0), -1, 1) * 5.0;

  while(level scripts\engine\utility::_id_5C00("zipline_moving")) {
    self _meth_8003(var_1);
    waitframe();
  }
}

zipline_move(var_0, var_1) {
  if(!isDefined(self) || level scripts\engine\utility::_id_5C00("zipline_moving")) {
    return;
  }
  level endon("game_ended");
  self endon("death");
  var_2 = scripts\engine\utility::array_combine(level.zipline_switch._id_E59D, level.zipline_switch._id_5284);

  foreach(var_4 in var_2) {
    if(isDefined(var_4._id_73E3)) {
      var_4._id_73E3 thread zipline_power_handle_set_state("on");
    }
  }

  wait 0.5;
  level scripts\engine\utility::_id_5C1B("zipline_moving");
  level thread zipline_switch_change(var_0);

  if(istrue(level.zipline.is_docked)) {
    level.zipline.nav_blocker _meth_80B5();
    level.zipline.is_docked = 0;
  }

  foreach(var_7 in level.zipline.motors) {
    var_7 thread zipline_motor_play_sound();
    var_7 thread zipline_motor_play_effect();
  }

  foreach(var_10 in level.zipline.cable_spools) {
    var_10 thread zipline_spool_rotate(var_0);
  }

  level.zipline thread zipline_monitor_collision();
  var_12 = level.zipline_path;

  if(istrue(var_0)) {
    var_13 = scripts\engine\utility::_id_1BD2(var_12.tracks);
    var_14 = var_12.last_node;
    var_15 = var_12.first_node;
    var_16 = 0;
  } else {
    var_13 = var_12.tracks;
    var_14 = var_12.first_node;
    var_15 = var_12.last_node;
    var_16 = 1;
  }

  self.origin = var_14.origin;
  self.angles = var_14.angles;
  waitframe();
  playFXOnTag(scripts\engine\utility::getfx("zipline_cabl_sparks_effect"), self, "tag_origin");
  self playLoopSound("zmb_zip_line_wheel_lp");
  childthread zipline_sway_motion_start(var_0);
  var_17 = var_13[0];
  var_18 = var_17._id_F1E8;
  self moveto(var_17._id_A578[var_16].origin, var_18, 1.0, 0);
  scripts\engine\utility::_id_108A7(var_18, "movedone");

  for(var_19 = 1; var_19 < var_13.size - 1; var_19++) {
    var_17 = var_13[var_19];
    var_18 = var_17._id_F1E8;
    self moveto(var_17._id_A578[var_16].origin, var_18);
    scripts\engine\utility::_id_108A7(var_18, "movedone");
  }

  var_17 = var_13[var_13.size - 1];
  var_18 = var_17._id_F1E8;
  self moveto(var_17._id_A578[var_16].origin, var_18, 0, 1.0);
  scripts\engine\utility::_id_108A7(var_18, "movedone");

  if(istrue(var_1)) {
    level.zipline.nav_blocker _meth_8093();
    level.zipline.is_docked = 1;
  }

  level scripts\engine\utility::_id_5C04("zipline_moving");
  zipline_sway_motion_stop(var_0);
  self stoploopsound();
  stopFXOnTag(scripts\engine\utility::getfx("zipline_cabl_sparks_effect"), self, "tag_origin");
  waitframe();
  self.origin = var_15.origin;
  self.angles = var_15.angles;

  foreach(var_4 in var_2) {
    if(var_4._id_039B != "zipline_power" && isDefined(var_4._id_73E3)) {
      var_4._id_73E3 thread zipline_power_handle_set_state("off");
    }
  }
}

zipline_collide_zombie(var_0) {
  if(isDefined(var_0._id_110B0) && var_0._id_110B0 == "trickster") {
    if(!isDefined(var_0.force_escape_position)) {
      var_1 = 120 * anglesToForward(self.angles);

      if(scripts\engine\utility::cointoss()) {
        var_1 = -1 * var_1;
      }

      var_2 = scripts\engine\utility::_id_5000(self.origin + var_1, 50);
      var_0.force_escape_position = _func_02AB(var_2, var_0);
    }
  } else
    var_0 _meth_81FA(var_0.origin, self, self, "MOD_CRUSH");
}

zipline_monitor_collision() {
  self endon("death");
  childthread zipline_kill_players();

  while(level scripts\engine\utility::_id_5C00("zipline_moving")) {
    var_0 = _func_0071(self.origin, 200, level._id_11056);

    foreach(var_2 in var_0) {
      if(_func_0458(var_2)) {
        continue;
      }
      var_3 = [self.nav_clip, self.nav_blocker];
      var_4 = var_2 _meth_813D(var_3);

      if(var_4.size > 0) {
        zipline_collide_zombie(var_2);
      }
    }

    wait 0.1;
  }
}

zipline_kill_players() {
  self endon("death");
  self.nav_clip endon("death");

  for(;;) {
    self.nav_clip waittill("unresolved_collision", var_0);

    if(var_0 scripts\cp\utility::_id_8708()) {
      var_1 = gettime();

      if(isDefined(var_0.zipline_collision_time) && var_0.zipline_collision_time - var_1 <= 100) {
        var_0 dodamage(var_0.maxhealth, var_0.origin, undefined, self, "MOD_CRUSH");
      } else {
        var_0.zipline_collision_time = var_1;
      }
    }
  }
}

zipline_power_handle_set_state(var_0) {
  self endon("death");
  self._id_E747 = scripts\cp\utility::_id_459B(self._id_E747, "off");

  if(!isDefined(var_0)) {
    return;
  }
  if(self._id_E747 != var_0) {
    var_1 = self _meth_8151();

    if(isDefined(var_1)) {
      self unlink();

      if(isDefined(self.pre_angles)) {
        self.angles = self.pre_angles;
        waitframe();
      }
    }

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

    if(isDefined(var_1)) {
      if(!isDefined(self.pre_angles)) {
        self.pre_angles = self.angles;
      } else {
        self.pre_angles = undefined;
      }

      self linkto(var_1, "tag_handle");
    }

    self._id_E747 = var_0;
  }
}