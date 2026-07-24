/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3822.gsc
**************************************/

_id_FD90() {
  level._effect["vfx_veh_retr_ftl_00_panel_aggregate_a_startup_l"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_00_panel_aggregate_a_startup_l.vfx");
  level._effect["vfx_veh_retr_ftl_00_panel_aggregate_a_startup_r"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_00_panel_aggregate_a_startup_r.vfx");
  level._effect["vfx_veh_retr_ftl_00_panel_aggregate_b_travel_l"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_00_panel_aggregate_b_travel_l.vfx");
  level._effect["vfx_veh_retr_ftl_00_panel_aggregate_b_travel_r"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_00_panel_aggregate_b_travel_r.vfx");
  level._effect["vfx_veh_retr_ftl_00_panel_aggregate_c_stop_l"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_00_panel_aggregate_c_stop_l.vfx");
  level._effect["vfx_veh_retr_ftl_00_panel_aggregate_c_stop_r"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_00_panel_aggregate_c_stop_r.vfx");
  level._effect["vfx_veh_retr_ftl_02_panel_cool_charge_a_startup_small"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_02_panel_cool_charge_a_startup_small.vfx");
  level._effect["vfx_veh_retr_ftl_02_panel_cool_charge_a_startup_large"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_02_panel_cool_charge_a_startup_large.vfx");
  level._effect["vfx_veh_retr_ftl_04_energy_waves_a_startup_l"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_04_energy_waves_a_startup_l.vfx");
  level._effect["vfx_veh_retr_ftl_04_energy_waves_a_startup_r"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_04_energy_waves_a_startup_r.vfx");
  level._effect["vfx_veh_retr_ftl_05_dialation_sphere_a_startup"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_05_dialation_sphere_a_startup.vfx");
  level._effect["vfx_veh_retr_ftl_05_dialation_sphere_b_travel"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_05_dialation_sphere_b_travel.vfx");
  level._effect["vfx_veh_retr_ftl_05_dialation_sphere_c_stop"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_05_dialation_sphere_c_stop.vfx");
  level._effect["vfx_veh_retr_ftl_06_center_energy_point_a_startup"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_06_center_energy_point_a_startup.vfx");
  level._effect["vfx_veh_retr_ftl_06_center_energy_point_b_travel"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_06_center_energy_point_b_travel.vfx");
  level._effect["vfx_veh_retr_ftl_06_center_energy_point_c_stop"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_06_center_energy_point_c_stop.vfx");
  level._effect["vfx_veh_retr_ftl_08_sparks_b_travel"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_08_sparks_b_travel.vfx");
  level._effect["vfx_veh_retr_ftl_08_sparks_c_stop"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_08_sparks_c_stop.vfx");
  level._effect["vfx_veh_retr_ftl_11_panel_warm_charge_small"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_11_panel_warm_charge_small.vfx");
  level._effect["vfx_veh_retr_ftl_11_panel_warm_charge_large"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_11_panel_warm_charge_large.vfx");
  level._id_749E = spawn("script_origin", level.player.origin);
  level._id_749F = spawn("script_origin", level.player.origin);
}

_id_FDC7(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  scripts\sp\lights::_id_AB83(self._id_99E6, var_0);
}

_id_FD89(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    var_0 = "default";
  }

  level notify("ftl_prep");
  thread _id_25AF("buildup");
  thread _id_25B1();
  level.player _meth_82C0("shipcrib_ftl_go", var_4);
  var_5 = 0;
  var_6 = 7;

  if(!isDefined(var_4)) {
    var_4 = var_6;
  } else if(var_4 > var_6) {
    var_5 = var_4 - var_6;
  }

  var_7 = 6;

  if(var_7 < var_4) {
    var_7 = var_4 - var_7;
  }

  screenshake(level.player.origin, 0.2, 0.2, 0.2, var_4, -1, 0, 0, 12, 12, 12);
  visionsetalternate(1, var_4);
  level scripts\engine\utility::delaythread(0.0, _id_0EF5::_id_FDF6, var_0 + "_lp", 0.2, "navigation");
  level scripts\engine\utility::delaythread(0.0, _id_0EF5::_id_FDF6, var_0 + "_lp", 0.2, "navigation_l");
  level scripts\engine\utility::delaythread(0.0, _id_0EF5::_id_FDF6, var_0 + "_lp", 0.2, "navigation_c");
  level scripts\engine\utility::delaythread(0.0, _id_0EF5::_id_FDF6, var_0 + "_lp", 0.2, "navigation_r");
  level scripts\engine\utility::delaythread(1.0, _id_0EF5::_id_FDF6, var_0 + "_lp", 0.2, "opsmap");
  level scripts\engine\utility::delaythread(2.5, _id_0EF5::_id_FDF6, var_0 + "_lp", 0.2, "tactical");
  level scripts\engine\utility::delaythread(2.5, _id_0EF5::_id_FDF6, var_0 + "_lp", 0.2, "tactical_l");
  level scripts\engine\utility::delaythread(2.5, _id_0EF5::_id_FDF6, var_0 + "_lp", 0.2, "tactical_r");
  level scripts\engine\utility::delaythread(5.0, _id_0EF5::_id_FDF6, var_0 + "_lp", 0.2, "view");
  level scripts\engine\utility::delaythread(5.0, _id_0EF5::_id_FDF6, var_0 + "_lp", 0.2, "view_fore");
  level scripts\engine\utility::delaythread(5.0, _id_0EF5::_id_FDF6, var_0 + "_lp", 0.2, "view_aft");
  level scripts\engine\utility::delaythread(5.0, _id_0EF5::_id_FDF6, var_0 + "_lp", 0.2, "cic");
  level scripts\engine\utility::delaythread(5.0, _id_0EF5::_id_FDF6, var_0 + "_lp", 0.2, "cic_rear");
  level scripts\engine\utility::delaythread(5.0, _id_0EF5::_id_FDF6, var_0 + "_lp", 0.2, "systems");
  level scripts\engine\utility::delaythread(5.0, _id_0EF5::_id_FDF6, var_0 + "_lp", 0.2, "systems_corner");
  level scripts\engine\utility::delaythread(5.0, _id_0EF5::_id_FDF6, var_0 + "_lp", 0.2, "comms");
  level scripts\engine\utility::delaythread(5.0, _id_0EF5::_id_FDF6, var_0 + "_lp", 0.2, "comms_lower");
  level scripts\engine\utility::delaythread(5.0, _id_0EF5::_id_FDF6, var_0 + "_lp", 0.2, "misc");
  var_8 = getEntArray("lgt_cic_monitors", "script_noteworthy");
  var_9 = getEntArray("lgt_nav_monitors", "script_noteworthy");
  var_10 = getEntArray("lgt_tactical_monitors", "script_noteworthy");
  var_11 = getEntArray("lgt_view_monitors", "script_noteworthy");
  var_12 = getEntArray("lgt_systems_monitors", "script_noteworthy");
  var_13 = getEntArray("lgt_comms_monitors", "script_noteworthy");
  var_14 = getEntArray("lgt_bridge_dark", "script_noteworthy");
  var_15 = getEntArray("lgt_face_lights", "script_noteworthy");
  var_16 = scripts\engine\utility::array_combine(var_8, var_9);
  var_16 = scripts\engine\utility::array_combine(var_16, var_10);
  var_16 = scripts\engine\utility::array_combine(var_16, var_11);
  var_16 = scripts\engine\utility::array_combine(var_16, var_12);
  var_16 = scripts\engine\utility::array_combine(var_16, var_13);
  var_16 = scripts\engine\utility::array_combine(var_16, var_14);
  var_17 = scripts\engine\utility::array_combine(var_8, var_9);
  var_17 = scripts\engine\utility::array_combine(var_17, var_11);

  foreach(var_19 in var_16) {
    var_19._id_99E6 = scripts\sp\lights::_id_95A8([var_19.script_intensity_01, var_19 _meth_8134()]);
  }

  foreach(var_19 in var_15) {
    var_19._id_99E6 = scripts\sp\lights::_id_95A8([var_19.script_intensity_01, var_19 _meth_8134()]);
  }

  level thread scripts\engine\utility::array_thread(var_16, scripts\sp\lights::_id_AB83, 0, var_4);
  level thread scripts\engine\utility::array_thread(var_15, scripts\sp\lights::_id_AB83, 0, var_4);

  foreach(var_24 in level._id_E35D._id_6A38._id_747F) {
    playFXOnTag(scripts\engine\utility::getfx("vfx_veh_retr_ftl_04_energy_waves_a_startup" + var_24._id_101AD), var_24._id_7601, "tag_origin");
  }

  playFXOnTag(scripts\engine\utility::getfx("vfx_veh_retr_ftl_06_center_energy_point_a_startup"), level._id_E35D._id_6A38._id_74A1, "tag_origin");
  scripts\engine\utility::noself_delaycall(var_7, ::playfxontag, scripts\engine\utility::getfx("vfx_veh_retr_ftl_05_dialation_sphere_a_startup"), level._id_E35D._id_6A38._id_74A1, "tag_origin");
  level.player _meth_8244("subtle_tank_rumble");
  wait(var_4 - 1);
  thread _id_25AF("go");
  wait 1;
  thread _id_25B1();
  level notify("jump_started");
  level thread _id_0EFB::_id_FDBD(0, 0.05);
  var_26 = getDvar("r_mbRadialOverridePosition");
  var_27 = getDvar("r_mbRadialOverrideAngleAttenuation");
  var_28 = getDvar("r_mbRadialOverrideRadius");
  var_29 = getDvar("r_mbRadialOverrideFocusDir");
  level thread _id_7472();
  level.player playRumbleOnEntity("heavy_1s");

  if(isDefined(var_2)) {
    level thread[[var_2]]();
  }

  screenshake(level.player.origin, 1.5, 1.5, 1.5, 0.5, 0, 0, 0, 16, 16, 16);
  level thread _id_7498();
  level thread _id_748C();
  level.player _meth_81DE(30, 0.1);
  level.player scripts\engine\utility::delaycall(0.2, ::_meth_81DE, 65, 0.1);
  visionsetalternate(3, 0);
  scripts\engine\utility::noself_delaycall(0.25, ::visionsetalternate, 2, 0.5);
  level thread scripts\engine\utility::array_call(var_16, ::setlightintensity, 100);
  level thread scripts\engine\utility::array_thread(var_16, scripts\sp\lights::_id_AB83, 0, 1);
  playFXOnTag(scripts\engine\utility::getfx("vfx_veh_retr_ftl_05_dialation_sphere_b_travel"), level._id_E35D._id_6A38._id_74A1, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_veh_retr_ftl_06_center_energy_point_b_travel"), level._id_E35D._id_6A38._id_74A1, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_veh_retr_ftl_08_sparks_b_travel"), level._id_E35D._id_6A38._id_74A1, "tag_origin");
  thread scripts\engine\utility::exploder(74);
  scripts\engine\utility::waitframe();
  killfxontag(scripts\engine\utility::getfx("vfx_veh_retr_ftl_05_dialation_sphere_a_startup"), level._id_E35D._id_6A38._id_74A1, "tag_origin");
  killfxontag(scripts\engine\utility::getfx("vfx_veh_retr_ftl_06_center_energy_point_a_startup"), level._id_E35D._id_6A38._id_74A1, "tag_origin");

  foreach(var_31 in level._id_E35D._id_6A38._id_747E) {
    scripts\engine\utility::waitframe();

    foreach(var_24 in var_31) {
      killfxontag(scripts\engine\utility::getfx("vfx_veh_retr_ftl_00_panel_aggregate_a_startup" + var_24._id_101AD), var_24._id_7601, "tag_origin");
      killfxontag(scripts\engine\utility::getfx("vfx_veh_retr_ftl_04_energy_waves_a_startup" + var_24._id_101AD), var_24._id_7601, "tag_origin");
    }
  }

  level waittill("ftl_3_sec_left");
  scripts\engine\utility::delaythread(2.0, ::_id_25AF, "stop");
  scripts\engine\utility::noself_delaycall(1.5, ::visionsetalternate, 3, 1);
  level waittill("ftl_stop");
  thread _id_25B1();
  level.player clearclienttriggeraudiozone(5.0);
  level notify("ftl_stop_screenshake");
  screenshake(level.player.origin, 1.5, 1.5, 1.5, 0.25, 0, 0, 0, 16, 16, 16);
  level thread _id_748D();
  level thread _id_7473(var_26, var_27, var_28, var_29);
  visionsetalternate(1, 0);
  level notify("ftl_finished");
  level.player _meth_81DE(65.0, 1.0);
  level.player playRumbleOnEntity("heavy_1s");
  level.player scripts\engine\utility::delaycall(1.05, ::stoprumble, "subtle_tank_rumble");
  level thread scripts\engine\utility::array_thread(var_15, ::_id_FDC7, 0.3);
  level thread scripts\engine\utility::array_thread(var_16, ::_id_FDC7, 0.3);

  if(isDefined(var_3)) {
    level thread[[var_3]]();
  }

  level scripts\engine\utility::delaythread(0.0, _id_0EF5::_id_FDF6, var_0, 0.2, "navigation");
  level scripts\engine\utility::delaythread(0.0, _id_0EF5::_id_FDF6, var_0, 0.2, "navigation_l");
  level scripts\engine\utility::delaythread(0.0, _id_0EF5::_id_FDF6, var_0, 0.2, "navigation_c");
  level scripts\engine\utility::delaythread(0.0, _id_0EF5::_id_FDF6, var_0, 0.2, "navigation_r");
  level scripts\engine\utility::delaythread(1.0, _id_0EF5::_id_FDF6, var_0, 0.2, "opsmap");
  level scripts\engine\utility::delaythread(2.5, _id_0EF5::_id_FDF6, var_0, 0.2, "tactical");
  level scripts\engine\utility::delaythread(2.5, _id_0EF5::_id_FDF6, var_0, 0.2, "tactical_l");
  level scripts\engine\utility::delaythread(2.5, _id_0EF5::_id_FDF6, var_0, 0.2, "tactical_r");
  level scripts\engine\utility::delaythread(5.0, _id_0EF5::_id_FDF6, var_0, 0.2, "view");
  level scripts\engine\utility::delaythread(5.0, _id_0EF5::_id_FDF6, var_0, 0.2, "view_fore");
  level scripts\engine\utility::delaythread(5.0, _id_0EF5::_id_FDF6, var_0, 0.2, "view_aft");
  level scripts\engine\utility::delaythread(5.0, _id_0EF5::_id_FDF6, var_0, 0.2, "cic");
  level scripts\engine\utility::delaythread(5.0, _id_0EF5::_id_FDF6, var_0, 0.2, "cic_rear");
  level scripts\engine\utility::delaythread(5.0, _id_0EF5::_id_FDF6, var_0, 0.2, "systems");
  level scripts\engine\utility::delaythread(5.0, _id_0EF5::_id_FDF6, var_0, 0.2, "systems_corner");
  level scripts\engine\utility::delaythread(5.0, _id_0EF5::_id_FDF6, var_0, 0.2, "comms");
  level scripts\engine\utility::delaythread(5.0, _id_0EF5::_id_FDF6, var_0, 0.2, "comms_lower");
  level scripts\engine\utility::delaythread(5.0, _id_0EF5::_id_FDF6, var_0, 0.2, "misc");

  foreach(var_24 in level._id_E35D._id_6A38._id_747F) {
    playFXOnTag(scripts\engine\utility::getfx("vfx_veh_retr_ftl_11_panel_warm_charge" + var_24._id_EB9C), var_24._id_7601, "tag_origin");
  }

  playFXOnTag(scripts\engine\utility::getfx("vfx_veh_retr_ftl_05_dialation_sphere_c_stop"), level._id_E35D._id_6A38._id_74A1, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_veh_retr_ftl_06_center_energy_point_c_stop"), level._id_E35D._id_6A38._id_74A1, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_veh_retr_ftl_08_sparks_c_stop"), level._id_E35D._id_6A38._id_74A1, "tag_origin");
  scripts\engine\utility::waitframe();
  killfxontag(scripts\engine\utility::getfx("vfx_veh_retr_ftl_05_dialation_sphere_b_travel"), level._id_E35D._id_6A38._id_74A1, "tag_origin");
  killfxontag(scripts\engine\utility::getfx("vfx_veh_retr_ftl_06_center_energy_point_b_travel"), level._id_E35D._id_6A38._id_74A1, "tag_origin");
  killfxontag(scripts\engine\utility::getfx("vfx_veh_retr_ftl_08_sparks_b_travel"), level._id_E35D._id_6A38._id_74A1, "tag_origin");

  foreach(var_31 in level._id_E35D._id_6A38._id_747E) {
    scripts\engine\utility::waitframe();

    foreach(var_24 in var_31) {
      killfxontag(scripts\engine\utility::getfx("vfx_veh_retr_ftl_02_panel_cool_charge_a_startup" + var_24._id_EB9C), var_24._id_7601, "tag_origin");
    }
  }
}

_id_25AF(var_0) {
  var_1 = "";

  if(isDefined(var_0)) {
    if(isDefined(level.script)) {
      if(scripts\engine\utility::flag_exist("capops_ftl_triggered")) {
        if(scripts\engine\utility::flag("capops_ftl_triggered")) {
          var_1 = "shipcrib_captains_quarters_ftl_" + var_0 + "_lr";

          if(var_0 == "go") {
            level._id_749F playSound(var_1);
          } else {
            thread _id_25F9();
            level._id_749E playSound(var_1);
          }
        } else {
          var_1 = level.script + "_ftl_" + var_0 + "_lr";

          if(var_0 == "go") {
            level._id_749F playSound(var_1);
          } else {
            thread _id_25F9();
            level._id_749E playSound(var_1);
          }
        }
      } else {
        var_1 = level.script + "_ftl_" + var_0 + "_lr";

        if(var_0 == "go") {
          level._id_749F playSound(var_1);
        } else {
          thread _id_25F9();
          level._id_749E playSound(var_1);
        }
      }
    }
  }
}

_id_25F9() {
  wait 1.25;
  level._id_749F stopsounds();
}

_id_7472() {
  level endon("stop_ftl_aberration");
  var_0 = anglesToForward(level._id_E35D._id_3BB6.angles) * 5000;
  setsaveddvar("r_mbRadialOverrideChromaticAberration", 0.9);
  setsaveddvar("r_mbRadialOverridePosition", var_0);
  setsaveddvar("r_mbRadialOverridePositionActive", 1);
  setsaveddvar("r_mbRadialOverrideRadius", -0.2);
  setsaveddvar("r_mbRadialOverrideFocusDir", 0.2);
  setsaveddvar("r_mbRadialOverrideAngleAttenuation", 0.1);
  setsaveddvar("r_mbradialoverridestrength", 0.0);
  setsaveddvar("r_mbradialoverridedistortion", 0.05);
  thread scripts\sp\utility::_id_AB9A("r_mbradialoverridedistortion", 0.025, 0.1);
  scripts\sp\utility::_id_AB9A("r_mbradialoverridestrength", 0.015, 0.1);

  for(;;) {
    var_1 = randomfloatrange(0.05, 0.1);
    var_2 = randomfloatrange(0.005, 0.02);
    thread scripts\sp\utility::_id_AB9A("r_mbradialoverridedistortion", var_2 * 2, var_1);
    scripts\sp\utility::_id_AB9A("r_mbradialoverridestrength", var_2, var_1);
  }
}

_id_7473(var_0, var_1, var_2, var_3) {
  level notify("stop_ftl_aberration");
  wait 0.05;
  thread scripts\sp\utility::_id_AB9A("r_mbradialoverridedistortion", 0.0, 1.0);
  scripts\sp\utility::_id_AB9A("r_mbradialoverridestrength", 0.0, 1.0);
  setsaveddvar("r_mbRadialOverrideChromaticAberration", 0);
  setsaveddvar("r_mbRadialOverridePosition", var_0);
  setsaveddvar("r_mbRadialOverridePositionActive", 0);
  setsaveddvar("r_mbRadialOverrideRadius", var_2);
  setsaveddvar("r_mbRadialOverrideFocusDir", var_3);
  setsaveddvar("r_mbRadialOverrideAngleAttenuation", var_1);
  setsaveddvar("r_mbradialoverridestrength", 0.0);
  setsaveddvar("r_mbradialoverridedistortion", 0.0);
}

_id_FD8B(var_0) {
  level notify("ftl_drives_opening");
  thread _id_747D();

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  level._id_E35D._id_6A38 _id_0B51::_id_C5FC(var_0);
  level notify("ftl_drives_opened");
}

_id_FD8C() {
  level notify("ftl_drives_opening");
  thread _id_747D(0);
  level._id_E35D._id_6A38 _id_0B51::_id_C5FD();
  level notify("ftl_drives_opened");
}

_id_FD8A(var_0) {
  level notify("ftl_drives_closing");
  thread _id_747C();

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  level._id_E35D._id_6A38 _id_0B51::_id_4268(var_0);
  level notify("ftl_drives_closed");
}

_id_748B() {
  level endon("ftl_stop");

  for(;;) {
    var_0 = randomfloatrange(0.05, 0.15);
    scripts\sp\lights::_id_AB83(10, var_0);
    wait(var_0);
    var_0 = randomfloatrange(0.05, 0.15);
    scripts\sp\lights::_id_AB83(0, var_0);
    wait(var_0);
  }
}

_id_747D(var_0) {
  level endon("ftl_stop");
  var_1 = 2;

  if(isDefined(var_0)) {
    var_1 = var_0;
  }

  var_2 = 700;
  var_3 = 100;
  var_4 = getEntArray("lgt_ftl_drives_01", "script_noteworthy");
  var_5 = getEntArray("lgt_ftl_drives_02", "script_noteworthy");
  var_6 = getEntArray("lgt_ftl_drives_03", "script_noteworthy");
  var_7 = getEntArray("lgt_ftl_drives_04", "script_noteworthy");
  var_8 = getEntArray("lgt_ftl_drives_05", "script_noteworthy");
  var_9 = getEntArray("lgt_ftl_drives_06", "script_noteworthy");
  var_10 = getEntArray("lgt_ftl_drives_07", "script_noteworthy");
  var_11 = getEntArray("lgt_ftl_drives_08", "script_noteworthy");
  var_12 = getEntArray("lgt_ftl_drives_09", "script_noteworthy");
  var_13 = getEnt("lgt_ftl_blue", "script_noteworthy");
  scripts\engine\utility::array_thread(var_4, scripts\sp\lights::_id_AB83, var_2, 3.5);
  scripts\engine\utility::delaythread(2 * var_1, scripts\engine\utility::array_thread, var_5, scripts\sp\lights::_id_AB83, var_2, 3.5);
  scripts\engine\utility::delaythread(4 * var_1, scripts\engine\utility::array_thread, var_6, scripts\sp\lights::_id_AB83, var_2, 3.5);
  scripts\engine\utility::delaythread(6 * var_1, scripts\engine\utility::array_thread, var_7, scripts\sp\lights::_id_AB83, var_2, 3.5);
  scripts\engine\utility::delaythread(8 * var_1, scripts\engine\utility::array_thread, var_8, scripts\sp\lights::_id_AB83, var_2, 3.5);
  scripts\engine\utility::delaythread(10 * var_1, scripts\engine\utility::array_thread, var_9, scripts\sp\lights::_id_AB83, var_2, 3.5);
  scripts\engine\utility::delaythread(11 * var_1, scripts\engine\utility::array_thread, var_10, scripts\sp\lights::_id_AB83, var_2, 3.5);
  scripts\engine\utility::delaythread(12 * var_1, scripts\engine\utility::array_thread, var_11, scripts\sp\lights::_id_AB83, var_2, 3.5);
  scripts\engine\utility::delaythread(13 * var_1, scripts\engine\utility::array_thread, var_12, scripts\sp\lights::_id_AB83, var_2, 3.5);

  if(isDefined(var_13)) {
    wait(10 * var_1);
    var_13 thread scripts\sp\lights::_id_AB83(var_3, 7.5);
  }
}

_id_747C() {
  level endon("ftl_stop");
  var_0 = 2;
  var_1 = getEntArray("lgt_ftl_drives_01", "script_noteworthy");
  var_2 = getEntArray("lgt_ftl_drives_02", "script_noteworthy");
  var_3 = getEntArray("lgt_ftl_drives_03", "script_noteworthy");
  var_4 = getEntArray("lgt_ftl_drives_04", "script_noteworthy");
  var_5 = getEntArray("lgt_ftl_drives_05", "script_noteworthy");
  var_6 = getEntArray("lgt_ftl_drives_06", "script_noteworthy");
  var_7 = getEntArray("lgt_ftl_drives_07", "script_noteworthy");
  var_8 = getEntArray("lgt_ftl_drives_08", "script_noteworthy");
  var_9 = getEntArray("lgt_ftl_drives_09", "script_noteworthy");
  var_10 = getEnt("lgt_ftl_blue", "script_noteworthy");
  scripts\engine\utility::array_thread(var_9, scripts\sp\lights::_id_AB83, 0, 3.5);
  scripts\engine\utility::delaythread(var_0, scripts\engine\utility::array_thread, var_8, scripts\sp\lights::_id_AB83, 0, 3.5);
  scripts\engine\utility::delaythread(2 * var_0, scripts\engine\utility::array_thread, var_7, scripts\sp\lights::_id_AB83, 0, 3.5);
  scripts\engine\utility::delaythread(3 * var_0, scripts\engine\utility::array_thread, var_6, scripts\sp\lights::_id_AB83, 0, 3.5);
  scripts\engine\utility::delaythread(4 * var_0, scripts\engine\utility::array_thread, var_5, scripts\sp\lights::_id_AB83, 0, 3.5);
  scripts\engine\utility::delaythread(6 * var_0, scripts\engine\utility::array_thread, var_4, scripts\sp\lights::_id_AB83, 0, 3.5);
  scripts\engine\utility::delaythread(8 * var_0, scripts\engine\utility::array_thread, var_3, scripts\sp\lights::_id_AB83, 0, 3.5);
  scripts\engine\utility::delaythread(10 * var_0, scripts\engine\utility::array_thread, var_2, scripts\sp\lights::_id_AB83, 0, 3.5);
  scripts\engine\utility::delaythread(12 * var_0, scripts\engine\utility::array_thread, var_1, scripts\sp\lights::_id_AB83, 0, 3.5);

  if(isDefined(var_10)) {
    wait 6;
    var_10 thread scripts\sp\lights::_id_AB83(0, 7.5);
  }
}

_id_748C() {
  level endon("ftl_stop");
  var_0 = getEntArray("lgt_ftl_whitescroll", "script_noteworthy");

  if(var_0.size == 0) {
    return;
  }
  foreach(var_2 in var_0) {
    var_2.og_origin = var_2.origin;
    var_2._id_BC4A = var_2.origin + (-1800, 0, 0);
  }

  var_4 = 0.6;

  for(;;) {
    foreach(var_2 in var_0) {
      var_2 setlightintensity(400);
      var_2 moveTo(var_2._id_BC4A, var_4);
    }

    wait(var_4);

    foreach(var_2 in var_0) {
      var_2 setlightintensity(0);
      var_2 moveTo(var_2.og_origin, 0.01);
    }

    wait(var_4);
  }
}

_id_748D() {
  level endon("ftl_stop");
  var_0 = getEntArray("lgt_ftl_whitescroll", "script_noteworthy");

  if(var_0.size == 0) {
    return;
  }
  foreach(var_2 in var_0) {
    var_2 setlightintensity(0);
  }
}

_id_7498() {
  level endon("ftl_stop_screenshake");
  level _id_0EFB::_id_FE05();

  switch (level.script) {
    case "shipcrib_moon":
      thread _id_BB19();
      break;
    case "shipcrib_rogue":
      thread _id_E658();
      break;
    case "shipcrib_prisoner":
      thread _id_D941();
      break;
  }

  if(!isDefined(level._id_FD6E._id_7498)) {
    level._id_FD6E._id_7498 = [];
  }

  if(!isDefined(level._id_FD6E._id_7498["freq_min"])) {
    level._id_FD6E._id_7498["freq_min"] = 9;
    level._id_FD6E._id_7498["freq_max"] = 12;
  }

  if(!isDefined(level._id_FD6E._id_7498["pitch_min"])) {
    level._id_FD6E._id_7498["pitch_min"] = 0.25;
    level._id_FD6E._id_7498["pitch_max"] = 0.35;
  }

  if(!isDefined(level._id_FD6E._id_7498["yaw_min"])) {
    level._id_FD6E._id_7498["yaw_min"] = 0.25;
    level._id_FD6E._id_7498["yaw_max"] = 0.35;
  }

  if(!isDefined(level._id_FD6E._id_7498["roll_min"])) {
    level._id_FD6E._id_7498["roll_min"] = 0.6;
    level._id_FD6E._id_7498["roll_max"] = 0.8;
  }

  for(;;) {
    var_0 = randomfloatrange(level._id_FD6E._id_7498["freq_min"], level._id_FD6E._id_7498["freq_max"]);
    var_1 = randomfloatrange(level._id_FD6E._id_7498["pitch_min"], level._id_FD6E._id_7498["pitch_max"]);
    var_2 = randomfloatrange(level._id_FD6E._id_7498["yaw_min"], level._id_FD6E._id_7498["yaw_max"]);
    var_3 = randomfloatrange(level._id_FD6E._id_7498["roll_min"], level._id_FD6E._id_7498["roll_max"]);
    screenshake(level.player.origin, var_1, var_2, var_3, 0.5, 0, 0, 0, var_0, var_0, var_0);
    var_4 = randomfloatrange(0, 0.1);
    var_5 = randomfloatrange(0, 0.1);
    var_6 = randomfloatrange(0, 0.1);
    physicsjolt(level.player.origin, 501, 500, (var_4, var_5, var_6));
    wait 0.5;
  }
}

_id_BB19() {
  if(!isDefined(level._id_FD6E._id_7498)) {
    level._id_FD6E._id_7498 = [];
  }

  level._id_FD6E._id_7498["freq_min"] = 9;
  level._id_FD6E._id_7498["freq_max"] = 12;
  level._id_FD6E._id_7498["pitch_min"] = 0.25;
  level._id_FD6E._id_7498["pitch_max"] = 0.35;
  level._id_FD6E._id_7498["yaw_min"] = 0.25;
  level._id_FD6E._id_7498["yaw_max"] = 0.35;
  level._id_FD6E._id_7498["roll_max"] = 0.8;
  wait 2.0;
  level._id_FD6E._id_7498["freq_min"] = 4.5;
  level._id_FD6E._id_7498["freq_max"] = 6;
  wait 2.0;
  level._id_FD6E._id_7498["freq_min"] = 6;
  level._id_FD6E._id_7498["freq_max"] = 9;
  wait 1.0;
  level._id_FD6E._id_7498["freq_min"] = 11;
  level._id_FD6E._id_7498["freq_max"] = 15;
  level._id_FD6E._id_7498["pitch_min"] = 0.5;
  level._id_FD6E._id_7498["pitch_max"] = 0.7;
  level._id_FD6E._id_7498["yaw_min"] = 0.5;
  level._id_FD6E._id_7498["yaw_max"] = 0.7;
  level._id_FD6E._id_7498["roll_max"] = 1.6;
}

_id_E658() {
  if(!isDefined(level._id_FD6E._id_7498)) {
    level._id_FD6E._id_7498 = [];
  }

  level._id_FD6E._id_7498["freq_min"] = 9;
  level._id_FD6E._id_7498["freq_max"] = 12;
  level._id_FD6E._id_7498["pitch_min"] = 0.25;
  level._id_FD6E._id_7498["pitch_max"] = 0.35;
  level._id_FD6E._id_7498["yaw_min"] = 0.25;
  level._id_FD6E._id_7498["yaw_max"] = 0.35;
  level._id_FD6E._id_7498["roll_max"] = 0.8;
}

_id_D941() {
  if(!isDefined(level._id_FD6E._id_7498)) {
    level._id_FD6E._id_7498 = [];
  }

  if(isDefined(level._id_EB94) && level._id_EB94) {
    level._id_FD6E._id_7498["freq_min"] = 9;
    level._id_FD6E._id_7498["freq_max"] = 12;
    level._id_FD6E._id_7498["pitch_min"] = 0.25;
    level._id_FD6E._id_7498["pitch_max"] = 0.35;
    level._id_FD6E._id_7498["yaw_min"] = 0.25;
    level._id_FD6E._id_7498["yaw_max"] = 0.35;
    level._id_FD6E._id_7498["roll_min"] = 0.6;
    level._id_FD6E._id_7498["roll_max"] = 0.8;
  } else {
    level._id_FD6E._id_7498["freq_min"] = 9;
    level._id_FD6E._id_7498["freq_max"] = 12;
    level._id_FD6E._id_7498["pitch_min"] = 0.01;
    level._id_FD6E._id_7498["pitch_max"] = 0.02;
    level._id_FD6E._id_7498["yaw_min"] = 0.01;
    level._id_FD6E._id_7498["yaw_max"] = 0.02;
    level._id_FD6E._id_7498["roll_min"] = 0.06;
    level._id_FD6E._id_7498["roll_max"] = 0.08;
  }
}

_id_25B2() {
  level endon("jump_started");
  level._id_D8E5 = spawn("script_origin", (1854, 358, 241));
  level._id_D8E5 playSound("shipcrib_ftl_priming_lr");
  wait 20;
  thread _id_25B0();
}

_id_25B3() {
  level endon("jump_started");
  level._id_D8E5 = spawn("script_origin", (1854, 358, 241));
  level._id_D8E5 playSound("shipcrib_ftl_priming_fast_lr");
}

_id_25B0() {
  level._id_D8E4 = spawn("script_origin", level.player.origin);
  wait 0.5;
  level._id_D8E4 _meth_8278(0);
  wait 0.1;
  level._id_D8E4 playLoopSound("shipcrib_ftl_priming_constant_lp_lr");
  wait 0.1;
  level._id_D8E4 _meth_8278(1, 9);
}

_id_25B1() {
  wait 4.0;

  if(isDefined(level._id_D8E4)) {
    level._id_D8E4 _meth_8278(0, 3);
    wait 4.0;
    level._id_D8E4 stoploopsound();
    wait 1.0;
    level._id_D8E4 delete();
  }
}