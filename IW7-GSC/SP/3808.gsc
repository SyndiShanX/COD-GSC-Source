/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3808.gsc
**************************************/

#using_animtree("script_model");

_id_E3BC(var_0) {
  _id_0EFB::_id_E3F7();
  var_1 = ["jackal_bay_1", "jackal_bay_2", "jackal_bay_3", "jackal_bay_4"];

  if(isDefined(var_0))
    var_1 = [var_0];

  foreach(var_0 in var_1) {
    level._id_E35D._id_AA5F[var_0] = spawnStruct();
    level._id_E35D._id_AA5F[var_0]._id_102DD = _id_0EFB::_id_798A(var_0, "script_noteworthy", "slide");
    level._id_E35D._id_AA5F[var_0]._id_3FFB = _id_0EFB::_id_798A(var_0, "script_noteworthy", "clamp");
    level._id_E35D._id_AA5F[var_0]._id_3FFB _meth_83D0(#animtree);
    var_3 = _id_0EFB::_id_7991(var_0, "script_noteworthy", "door_1");
    level._id_E35D._id_AA5F[var_0]._id_5979 = var_3[0];

    if(var_3.size > 1) {
      var_3 = scripts\engine\utility::array_remove(var_3, var_3[0]);

      foreach(var_5 in var_3)
      var_5 linkTo(level._id_E35D._id_AA5F[var_0]._id_5979);
    }

    var_3 = _id_0EFB::_id_7991(var_0, "script_noteworthy", "door_2");
    level._id_E35D._id_AA5F[var_0]._id_597A = var_3[0];

    if(var_3.size > 1) {
      var_3 = scripts\engine\utility::array_remove(var_3, var_3[0]);

      foreach(var_5 in var_3)
      var_5 linkTo(level._id_E35D._id_AA5F[var_0]._id_597A);
    }

    level._id_E35D._id_AA5F[var_0]._id_5979._id_101EE = _id_0EFB::_id_798A(var_0, "script_noteworthy", "signal_lamp_1_red");
    level._id_E35D._id_AA5F[var_0]._id_5979._id_101EF = _id_0EFB::_id_798A(var_0, "script_noteworthy", "signal_lamp_1_yellow");
    level._id_E35D._id_AA5F[var_0]._id_5979._id_101ED = _id_0EFB::_id_798A(var_0, "script_noteworthy", "signal_lamp_1_green");
    level._id_E35D._id_AA5F[var_0]._id_5979._id_101EF hide();
    level._id_E35D._id_AA5F[var_0]._id_5979._id_101ED hide();
    var_9 = _id_0EFB::_id_7991(var_0, "script_noteworthy", "door_2_top");

    foreach(var_11 in var_9) {
      if(var_11.classname == "script_brushmodel") {
        level._id_E35D._id_AA5F[var_0]._id_597B = var_11;
        var_9 = scripts\engine\utility::array_remove(var_9, level._id_E35D._id_AA5F[var_0]._id_597B);
      }
    }

    scripts\engine\utility::array_call(var_9, ::linkto, level._id_E35D._id_AA5F[var_0]._id_597B);

    foreach(var_11 in var_9) {
      if(isDefined(var_11.model)) {
        switch (var_11.model) {
          case "un_dropship_signal_lamp_02_red":
            level._id_E35D._id_AA5F[var_0]._id_597B._id_101EE = var_11;
            break;
          case "un_dropship_signal_lamp_02_yellow":
            level._id_E35D._id_AA5F[var_0]._id_597B._id_101EF = var_11;
            var_11 hide();
            break;
          case "un_dropship_signal_lamp_02_green":
            level._id_E35D._id_AA5F[var_0]._id_597B._id_101ED = var_11;
            var_11 hide();
            break;
        }
      }
    }

    level._id_E35D._id_AA5F[var_0]._id_597E = _id_0EFB::_id_798A(var_0, "script_noteworthy", "door_end_top");
    level._id_E35D._id_AA5F[var_0]._id_597E._id_4285 = level._id_E35D._id_AA5F[var_0]._id_597E.angles;
    var_15 = getEnt(level._id_E35D._id_AA5F[var_0]._id_597E.target, "targetname");
    var_15 linkTo(level._id_E35D._id_AA5F[var_0]._id_597E);
    level._id_E35D._id_AA5F[var_0]._id_597D = _id_0EFB::_id_798A(var_0, "script_noteworthy", "door_end_bottom");
    level._id_E35D._id_AA5F[var_0]._id_597D._id_4285 = level._id_E35D._id_AA5F[var_0]._id_597D.angles;
    var_15 = getEnt(level._id_E35D._id_AA5F[var_0]._id_597D.target, "targetname");
    var_15 linkTo(level._id_E35D._id_AA5F[var_0]._id_597D);
    level._id_E35D._id_AA5F[var_0]._id_7691 = _id_0EFB::_id_798A(var_0, "script_noteworthy", "loading_gantry");
    level._id_E35D._id_AA5F[var_0]._id_7691._id_12BC9 = level._id_E35D._id_AA5F[var_0]._id_7691.origin;
    level._id_E35D._id_AA5F[var_0]._id_7691._id_B450 = level._id_E35D._id_AA5F[var_0]._id_7691.origin + anglesToForward(level._id_E35D._id_AA5F[var_0]._id_7691.angles) * 310;
    level._id_E35D._id_AA5F[var_0]._id_7691._id_A2CA = level._id_E35D._id_AA5F[var_0]._id_7691.origin + anglesToForward(level._id_E35D._id_AA5F[var_0]._id_7691.angles) * 220;
    level._id_E35D._id_AA5F[var_0]._id_7691 _meth_83D0(#animtree);
    level._id_E35D._id_AA5F[var_0]._id_7691._id_45D5 = _id_0EFB::_id_798A(var_0, "script_noteworthy", "controls_front");
    level._id_E35D._id_AA5F[var_0]._id_7691._id_45D5 linkTo(level._id_E35D._id_AA5F[var_0]._id_7691);
    level._id_E35D._id_AA5F[var_0]._id_102DD._id_D695 = level._id_E35D._id_AA5F[var_0]._id_102DD.origin;
    level._id_E35D._id_AA5F[var_0]._id_102DD._id_D696 = _id_0EFB::_id_7CBC(var_0, "script_noteworthy", "slide_pos2").origin;
    level._id_E35D._id_AA5F[var_0]._id_3FFB._id_D695 = level._id_E35D._id_AA5F[var_0]._id_3FFB.origin;
    level._id_E35D._id_AA5F[var_0]._id_3FFB._id_D696 = _id_0EFB::_id_7CBC(var_0, "script_noteworthy", "clamp_pos1").origin;
    level._id_E35D._id_AA5F[var_0]._id_3FFB._id_D697 = _id_0EFB::_id_7CBC(var_0, "script_noteworthy", "clamp_pos1b").origin;
    level._id_E35D._id_AA5F[var_0]._id_3FFB._id_D698 = _id_0EFB::_id_7CBC(var_0, "script_noteworthy", "clamp_pos2").origin;
    level._id_E35D._id_AA5F[var_0]._id_3FFB.start = _id_0EFB::_id_7CBC(var_0, "script_noteworthy", "clamp_start").origin;
    level._id_E35D._id_AA5F[var_0]._id_5979._id_C630 = _id_0EFB::_id_7CBC(var_0, "script_noteworthy", "door_1_open_pos").origin;
    level._id_E35D._id_AA5F[var_0]._id_5979._id_4291 = level._id_E35D._id_AA5F[var_0]._id_5979.origin;
    level._id_E35D._id_AA5F[var_0]._id_597A._id_C630 = _id_0EFB::_id_7CBC(var_0, "script_noteworthy", "door_2_open_pos").origin;
    level._id_E35D._id_AA5F[var_0]._id_597A._id_4291 = level._id_E35D._id_AA5F[var_0]._id_597A.origin;
    level._id_E35D._id_AA5F[var_0]._id_597B._id_C630 = _id_0EFB::_id_7CBC(var_0, "script_noteworthy", "door_2_top_open").origin;
    level._id_E35D._id_AA5F[var_0]._id_597B._id_4291 = level._id_E35D._id_AA5F[var_0]._id_597B.origin;
  }

  level._effect["jackal_engine_idle"] = loadfx("vfx/iw7/core/vehicle/jackal/vfx_jackal_thrust_idle.vfx");
  level._effect["jackal_engine_max"] = loadfx("vfx/iw7/core/vehicle/jackal/vfx_jackal_thrust_max.vfx");
  level._effect["jackal_engine_build"] = loadfx("vfx/iw7/core/vehicle/jackal/vfx_jackal_thrust_build.vfx");
  level._effect["jackal_engine_build_player"] = loadfx("vfx/iw7/levels/ship_crib/europa/vfx_jackal_thrust_build_player.vfx");
  level._effect["vfx_sc_jackal_launch_ground_smk"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_jackal_launch_ground_smk.vfx");
  level._effect["vfx_klaxon_flare"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_klaxon_flare.vfx");
  level._effect["vfx_airlock_vent_lrg_press"] = loadfx("vfx/iw7/core/mechanics/airlock/vfx_airlock_vent_lrg_press.vfx");
  level._effect["vfx_sc_baydoor_decompress_01"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_baydoor_decompress_01.vfx");
  level._effect["vfx_sc_baydoor_decompress_thin_01"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_baydoor_decompress_thin_01.vfx");
  level._effect["vfx_sc_baydoor_decompress_02"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_baydoor_decompress_02.vfx");
  level._effect["vfx_airlock_vent_sml_press"] = loadfx("vfx/iw7/core/mechanics/airlock/vfx_airlock_vent_sml_press.vfx");
  level._effect["vfx_jackal_canopy_airlock_fog_01"] = loadfx("vfx/iw7/core/vehicle/jackal/vfx_jackal_canopy_airlock_fog_01.vfx");
  level._effect["vfx_sc_airlock_steam_lrg_fast_01"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_airlock_steam_lrg_fast_01.vfx");
}

_id_EF3E(var_0) {
  scripts\engine\utility::waitframe();
  self._id_101EC = _id_0EFB::_id_7C34(var_0, "script_noteworthy", "signal_lamp_1");
}

_id_E3C4(var_0, var_1) {
  level.player endon("death");

  if(level._id_FD6E.jackals[var_0] == level._id_D127) {
    switch (var_1) {
      case "airlock":
        level._id_D127.anchor linkTo(level._id_E35D._id_AA5F[var_0]._id_102DD);
        level._id_E35D._id_AA5F[var_0]._id_102DD moveTo(level._id_E35D._id_AA5F[var_0]._id_102DD._id_D696, 0.05);
        break;
      case "launch_tube":
        level._id_D127.anchor linkTo(level._id_E35D._id_AA5F[var_0]._id_102DD);
        level._id_E35D._id_AA5F[var_0]._id_102DD moveTo(level._id_E35D._id_AA5F[var_0]._id_102DD._id_D696, 0.05);
        wait 0.15;
        level._id_D127.anchor linkTo(level._id_E35D._id_AA5F[var_0]._id_3FFB);
        level._id_E35D._id_AA5F[var_0]._id_3FFB moveTo(level._id_E35D._id_AA5F[var_0]._id_3FFB._id_D696, 0.05);
        break;
      case "ship_assault":
        level._id_D127.anchor linkTo(level._id_E35D._id_AA5F[var_0]._id_102DD);
        level._id_E35D._id_AA5F[var_0]._id_102DD moveTo(level._id_E35D._id_AA5F[var_0]._id_102DD._id_D696, 0.05);
        wait 0.15;
        level._id_D127.anchor linkTo(level._id_E35D._id_AA5F[var_0]._id_3FFB);
        level._id_E35D._id_AA5F[var_0]._id_597A moveTo(level._id_E35D._id_AA5F[var_0]._id_597A._id_C630, 0.05);
        break;
    }
  } else {
    switch (var_1) {
      case "airlock":
        level._id_FD6E.jackals[var_0] linkTo(level._id_E35D._id_AA5F[var_0]._id_102DD);
        level._id_E35D._id_AA5F[var_0]._id_102DD moveTo(level._id_E35D._id_AA5F[var_0]._id_102DD._id_D696, 0.05);
        break;
      case "launch_tube":
        level._id_FD6E.jackals[var_0] linkTo(level._id_E35D._id_AA5F[var_0]._id_102DD);
        level._id_E35D._id_AA5F[var_0]._id_102DD moveTo(level._id_E35D._id_AA5F[var_0]._id_102DD._id_D696, 0.05);
        wait 0.15;
        level._id_FD6E.jackals[var_0] linkTo(level._id_E35D._id_AA5F[var_0]._id_3FFB);
        level._id_E35D._id_AA5F[var_0]._id_3FFB moveTo(level._id_E35D._id_AA5F[var_0]._id_3FFB._id_D696, 0.05);
        break;
      case "ship_assault":
        level._id_FD6E.jackals[var_0] linkTo(level._id_E35D._id_AA5F[var_0]._id_102DD);
        level._id_E35D._id_AA5F[var_0]._id_102DD moveTo(level._id_E35D._id_AA5F[var_0]._id_102DD._id_D696, 0.05);
        wait 0.15;
        level._id_FD6E.jackals[var_0] linkTo(level._id_E35D._id_AA5F[var_0]._id_3FFB);
        level._id_E35D._id_AA5F[var_0]._id_597A moveTo(level._id_E35D._id_AA5F[var_0]._id_597A._id_C630, 0.05);
        break;
    }
  }
}

_id_E3C0(var_0) {
  _id_0EFB::_id_FE05();
  _id_0EFB::_id_E3F7();
  level.player endon("death");
  level._id_E35D._id_AA5F[var_0] endon("death");
}

_id_E3BE(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 1;

  if(!isDefined(var_3))
    var_3 = 0;

  level _id_E3C0(var_0);
  level _id_E3C1(var_0, var_2);

  if(!isDefined(var_1)) {
    setsaveddvar("bg_cinematicFullScreen", "1");
    setsaveddvar("bg_cinematicCanPause", "1");
    cinematicingame("sc_assault_maptrans_jackal_launch");

    while(!iscinematicplaying())
      scripts\engine\utility::waitframe();

    while(iscinematicplaying())
      scripts\engine\utility::waitframe();

    stopcinematicingame();
  }

  if(var_2) {
    level._id_D127 _id_0BDC::_id_A228();
    setomnvar("ui_jackal_atmo_launch", 1);
    setomnvar("ui_jackal_autopilot", 0);
    setomnvar("ui_jackal_show_horizon", 0);
    _id_E3BF();
  }

  if(var_3)
    level._id_D127 waittill("notify_player_launch");

  level _id_E3C2(var_0, var_2);
}

_id_E3BF() {
  level._id_D127 thread _id_0BDB::_id_11479();
  thread _id_0BDB::_id_1147B(4);
  level._id_D127 notify("notify_player_can_launch");
  level._id_D127 waittill("notify_player_launch");
}

#using_animtree("jackal");

_id_E3C1(var_0, var_1) {
  level _id_E3C0(var_0);
  var_2 = level._id_E35D._id_AA5F[var_0];

  if(!isDefined(var_1))
    var_1 = 1;

  if(level._id_FD6E.jackals[var_0] == level._id_D127)
    level._id_D127.anchor linkTo(var_2._id_102DD);
  else
    level._id_FD6E.jackals[var_0] linkTo(var_2._id_102DD);

  if(var_1) {
    scripts\engine\utility::exploder("1st_airlock_open");
    level.player playSound("scn_jackal_launch_door_open");
  }

  if(var_0 == "jackal_bay_3")
    level thread _id_E3BA();

  var_2._id_5979 _id_E3B9("open", 3, 1);

  if(var_1) {
    level thread _id_0BDC::_id_A2B0(%jackal_pilot_reaction_start, %jackal_vehicle_shipcrib_landed);
    var_2._id_102DD _id_E3BB("decompress", 5, var_0);
    level thread _id_0BDC::_id_A2B0(%jackal_pilot_reaction_stop, %jackal_vehicle_shipcrib_landed);
  } else {
    var_2._id_102DD _id_E3BB("decompress", 14.8, var_0);
    level._id_FD6E.jackals[var_0] setModel("veh_mil_air_un_jackal_02");
  }

  var_2._id_5979 thread _id_E3B9("close", 3);
  var_2._id_3FFB _id_E3B8("start", 2, var_0);
  level._id_FD6E.jackals[var_0] unlink();
  scripts\engine\utility::waitframe();

  if(level._id_FD6E.jackals[var_0] == level._id_D127)
    level._id_D127.anchor linkTo(level._id_E35D._id_AA5F[var_0]._id_3FFB);
  else
    level._id_FD6E.jackals[var_0] linkTo(level._id_E35D._id_AA5F[var_0]._id_3FFB, "tag_origin", (0, 0, -140), (0, 0, 0));

  if(var_1) {
    level thread _id_0BDC::_id_A2B0(%jackal_pilot_reaction_crane_start, %jackal_vehicle_shipcrib_landed);
    var_2._id_3FFB thread _id_E3B8("start_down", 0.75, var_0);
  } else
    var_2._id_3FFB thread _id_E3B8("start_down", 0.75, var_0);

  var_2._id_5979 waittill("close");
  level _id_E3BD(var_0, var_1);

  if(var_1) {
    scripts\engine\utility::exploder("2nd_airlock_open");
    playFXOnTag(scripts\engine\utility::getfx("vfx_jackal_canopy_airlock_fog_01"), level._id_FD6E.jackals[var_0], "j_canopy");
    level scripts\engine\utility::delaythread(0.5, ::_id_A404);
  }

  var_2._id_597A thread _id_E3B9("open", 3, 1);
  var_2._id_597B _id_E3B9("open", 3);

  if(var_1) {
    level thread _id_0BDC::_id_A2B0(%jackal_pilot_reaction_start, %jackal_vehicle_shipcrib_landed);
    var_2._id_3FFB _id_E3B8("launch_start", 5, var_0);
    level thread _id_0BDC::_id_A2B0(%jackal_pilot_reaction_stop, %jackal_vehicle_shipcrib_landed);
  } else {
    var_2._id_3FFB _id_E3B8("launch_start_forward", 5, var_0);
    level scripts\engine\utility::delaythread(0.75, ::_id_EAE7);
    level._id_FD6E.jackals[var_0] scripts\engine\utility::delaycall(0.75, ::playsound, "scn_ship_jackal_build_launch_npc");
    scripts\engine\utility::noself_delaycall(1.25, ::playfxontag, scripts\engine\utility::getfx("jackal_engine_build"), level._id_FD6E.jackals[var_0], "tag_thrust_rear_le");
    scripts\engine\utility::noself_delaycall(1.25, ::playfxontag, scripts\engine\utility::getfx("jackal_engine_build"), level._id_FD6E.jackals[var_0], "tag_thrust_rear_ri");
  }

  level scripts\engine\utility::delaythread(1, ::_id_E3CA, var_0, "open", 4);

  if(var_1)
    level.player scripts\engine\utility::delaycall(1, ::playsound, "scn_jackal_launch_ret_ext_doors");

  var_2._id_597A thread _id_E3B9("close", 3);
  var_2._id_597B _id_E3B9("close", 3);
}

_id_E3BD(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  if(var_1)
    scripts\engine\utility::exploder("airlock_depressurize");

  wait 1;

  if(var_1)
    level notify("launch_decompression_done");
}

_id_E3C2(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  level _id_E3C0(var_0);
  var_2 = level._id_E35D._id_AA5F[var_0];

  if(var_1) {
    level thread scripts\sp\utility::_id_C12D("player_jackal_launch_actual_started", 1.1);
    setsaveddvar("r_mbEnable", 0);
    setsaveddvar("spaceshipRadialMotionBlurMaxStrength", 0.0);
    setsaveddvar("spaceshipRadialMotionBlurMaxRadius", 0.0);
    level.player playSound("scn_jackal_launch");
    thread _id_0BDC::_id_A2B0(%jackal_pilot_reaction_launch, %jackal_vehicle_shipcrib_landed);
    var_2._id_3FFB _id_E3B8("launch_end", 0.85, var_0);
  } else {
    var_2._id_3FFB _id_E3B8("launch_end_salter", 0.425, var_0);
    level._id_FD6E.jackals[var_0] hide();
    var_2._id_3FFB hide();
    killfxontag(scripts\engine\utility::getfx("jackal_engine_max"), level._id_FD6E.jackals[var_0], "tag_thrust_rear_le");
    killfxontag(scripts\engine\utility::getfx("jackal_engine_max"), level._id_FD6E.jackals[var_0], "tag_thrust_rear_ri");
  }

  var_2.launched = 1;
}

_id_E3C3(var_0) {
  level _id_E3C0(var_0);
  level._id_E35D._id_AA5F[var_0].launched = undefined;
  level._id_E35D._id_AA5F[var_0]._id_597A moveTo(level._id_E35D._id_AA5F[var_0]._id_597A._id_C630, 3);
  wait 3;
  level._id_E35D._id_AA5F[var_0]._id_3FFB moveTo(level._id_E35D._id_AA5F[var_0]._id_3FFB._id_D695, 2);
  wait 2;
  level._id_E35D._id_AA5F[var_0]._id_597A moveTo(level._id_E35D._id_AA5F[var_0]._id_597A._id_4291, 3);
  wait 3;

  if(level._id_FD6E.jackals[var_0] == level._id_D127)
    level._id_D127.anchor linkTo(level._id_E35D._id_AA5F[var_0]._id_102DD);
  else
    level._id_FD6E.jackals[var_0] linkTo(level._id_E35D._id_AA5F[var_0]._id_102DD);

  level._id_E35D._id_AA5F[var_0]._id_5979 moveTo(level._id_E35D._id_AA5F[var_0]._id_5979._id_C630, 3);
  wait 3;
  level._id_E35D._id_AA5F[var_0]._id_102DD moveTo(level._id_E35D._id_AA5F[var_0]._id_102DD._id_D695, 5);
  wait 5;
  level._id_E35D._id_AA5F[var_0]._id_5979 moveTo(level._id_E35D._id_AA5F[var_0]._id_5979._id_4291, 3);
  wait 3;
}

_id_E3B9(var_0, var_1, var_2) {
  self endon("death");

  if(!isDefined(var_2))
    var_2 = 0;

  var_3 = 0.25;
  var_4 = var_1;

  if(var_1 > var_3 && var_2) {
    var_4 = var_1 - var_3;
    self _meth_8291(0.25, 0.25, 0.25, var_3, 0, 0, 1024, 14, 14, 14);
  }

  switch (var_0) {
    case "open":
      if(isDefined(self._id_101EE)) {
        self._id_101EE hide();
        self._id_101ED hide();
        self._id_101EF show();
      }

      self moveTo(self._id_C630, var_4);
      break;
    case "close":
      if(isDefined(self._id_101EE)) {
        self._id_101EE hide();
        self._id_101ED hide();
        self._id_101EF show();
      }

      self moveTo(self._id_4291, var_4);
      break;
  }

  wait(var_4);

  if(var_1 > var_3 && var_2)
    self _meth_8291(0.5, 0.5, 0.5, var_3, 0, 0, 1024, 14, 14, 14);

  wait(var_3);

  if(isDefined(self._id_101EE)) {
    switch (var_0) {
      case "open":
        self._id_101EE hide();
        self._id_101ED show();
        self._id_101EF hide();
        break;
      case "close":
        self._id_101EE show();
        self._id_101ED hide();
        self._id_101EF hide();
        break;
    }
  }

  self notify(var_0);
}

_id_E3BB(var_0, var_1, var_2) {
  self endon("death");
  var_3 = level._id_FD6E.jackals[var_2];
  var_4 = 0.25;
  var_5 = var_1 - var_4;

  switch (var_0) {
    case "start":
      self moveTo(self._id_D695, var_5);
      break;
    case "decompress":
      self moveTo(self._id_D696, var_5);
      break;
  }

  wait(var_5);
  self notify(var_0);
}

#using_animtree("script_model");

_id_E3B8(var_0, var_1, var_2) {
  self endon("death");
  var_3 = level._id_FD6E.jackals[var_2];
  var_4 = 0.25;
  var_5 = var_1 - var_4;

  switch (var_0) {
    case "start":
      self moveTo(self.start, var_5);
      wait(var_5);
      break;
    case "start_down":
      self moveTo(self.start + anglestoup(self.angles) * -40, var_5, var_5);
      wait(var_5);
      break;
    case "launch_start":
      self moveTo(self._id_D696 + anglestoup(self.angles) * -40, var_5);
      wait(var_5);
      break;
    case "launch_start_forward":
      self moveTo(self._id_D697, var_5);
      wait(var_5);
      break;
    case "launch_end":
      var_3 scripts\sp\utility::_id_75C4("jackal_boost_speed", "tag_origin");
      scripts\engine\utility::noself_delaycall(0, ::playfx, scripts\engine\utility::getfx("jackal_engine_build_player"), level.player.origin);
      level.player _meth_81DE(90, 0.05);
      level.player scripts\engine\utility::delaycall(0.2, ::_meth_81DE, 65, 0.75);
      thread _id_AB98(1, 0.05);
      thread _id_AB97(1, -0.33);
      thread _id_AB96(1, 0.025);
      self _meth_82A2(%shipcrib_jackal_launch_crane);
      wait(getanimlength(%shipcrib_jackal_launch_crane));
      thread _id_AB98(5, 0);
      thread _id_AB97(5, 0);
      thread _id_AB96(5, 0);
      break;
    case "launch_end_salter":
      stopFXOnTag(scripts\engine\utility::getfx("jackal_engine_build"), level._id_FD6E.jackals[var_2], "tag_thrust_rear_le");
      stopFXOnTag(scripts\engine\utility::getfx("jackal_engine_build"), level._id_FD6E.jackals[var_2], "tag_thrust_rear_ri");
      playFXOnTag(scripts\engine\utility::getfx("jackal_engine_max"), level._id_FD6E.jackals[var_2], "tag_thrust_rear_le");
      playFXOnTag(scripts\engine\utility::getfx("jackal_engine_max"), level._id_FD6E.jackals[var_2], "tag_thrust_rear_ri");
      scripts\engine\utility::noself_delaycall(0.1, ::playfx, scripts\engine\utility::getfx("vfx_sc_jackal_launch_ground_smk"), level._id_FD6E.jackals[var_2].origin);
      var_6 = 1;
      self _meth_82A2(%shipcrib_jackal_launch_crane);
      wait(getanimlength(%shipcrib_jackal_launch_crane) * var_6);
      self _meth_82B0(%shipcrib_jackal_launch_crane, var_6);
      break;
  }

  self notify(var_0);
}

_id_AB98(var_0, var_1) {
  var_2 = "r_mbRadialOverrideStrength";
  scripts\sp\utility::_id_AB9A(var_2, var_1, var_0);
}

_id_AB97(var_0, var_1) {
  var_2 = "r_mbRadialOverrideRadius";
  scripts\sp\utility::_id_AB9A(var_2, var_1, var_0);
}

_id_AB96(var_0, var_1) {
  var_2 = "r_mbRadialOverrideDistortion";
  scripts\sp\utility::_id_AB9A(var_2, var_1, var_0);
}

_id_E3CA(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 1;

  switch (var_1) {
    case "open":
      level._id_E35D._id_AA5F[var_0]._id_597E rotateTo(level._id_E35D._id_AA5F[var_0]._id_597E.angles + (110, 0, 0), var_2);
      level._id_E35D._id_AA5F[var_0]._id_597D rotateTo(level._id_E35D._id_AA5F[var_0]._id_597D.angles + (-110, 0, 0), var_2);
      break;
    case "close":
      level._id_E35D._id_AA5F[var_0]._id_597E rotateTo(level._id_E35D._id_AA5F[var_0]._id_597E._id_4285, var_2);
      level._id_E35D._id_AA5F[var_0]._id_597D rotateTo(level._id_E35D._id_AA5F[var_0]._id_597D._id_4285, var_2);
  }

  wait(var_2);
}

_id_E3BA() {
  _id_0EE4::_id_E389("jackal_launch_claxon_lf");
  _id_0EE4::_id_E389("jackal_launch_claxon_rf");
  wait 0.25;
  _id_0EE4::_id_E389("jackal_launch_claxon_lr");
  _id_0EE4::_id_E389("jackal_launch_claxon_rr");
}

_id_EAE7() {
  screenshake(level._id_FD6E.jackals["jackal_bay_4"].origin, 0.25, 0.25, 0.25, 5, 5, 0, 4048, 14, 14, 14);
  wait 5;
  level._id_FD6E.jackals["jackal_bay_4"] _meth_8291(0.5, 0.5, 0.5, 0.8, 0, 0, 4048, 14, 14, 14);
}

_id_A404() {
  self endon("death");
  self endon("disconnect");
  level notify("lgt_ntfy_launch_tube_3");
  level notify("lgt_ntfy_launch_tube_4");
  wait 5.5;
  var_0 = getEntArray("launch_red_lights_prac_01", "targetname");
  var_1 = getEntArray("launch_red_lights_prac_02", "targetname");
  var_2 = getEntArray("launch_red_lights_prac_03", "targetname");
  var_3 = getscriptablearray("launch_red_lights_01", "targetname");
  var_4 = getscriptablearray("launch_red_lights_02", "targetname");
  var_5 = getscriptablearray("launch_red_lights_03", "targetname");
  var_6 = getscriptablearray("launch_red_lights_04", "targetname");
  var_7 = getscriptablearray("launch_red_lights_05", "targetname");
  var_8 = getscriptablearray("launch_red_lights_06", "targetname");
  var_9 = getscriptablearray("launch_red_lights_07", "targetname");
  var_10 = getscriptablearray("launch_red_lights_08", "targetname");
  var_11 = getscriptablearray("launch_red_lights_09", "targetname");
  var_12 = getscriptablearray("launch_red_lights_10", "targetname");
  var_13 = getscriptablearray("launch_red_lights_11", "targetname");
  var_14 = getscriptablearray("launch_red_lights_12", "targetname");
  var_15 = [var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14];
  var_16 = 0.075;
  var_17 = 0.135;
  var_18 = 5;
  var_19 = 7;

  for(var_20 = 0; var_20 < var_18; var_20++) {
    var_21 = 1;

    foreach(var_23 in var_15) {
      scripts\engine\utility::array_thread(var_23, ::_id_4CCD, var_16);
      wait(var_16);
      var_21 = var_21 + 1;

      if(var_21 > 3)
        var_21 = 0;
    }
  }

  foreach(var_23 in var_15) {
    scripts\engine\utility::array_thread(var_23, ::_id_129AE);
    wait(var_16);
  }

  for(var_20 = 0; var_20 < var_19; var_20++) {
    foreach(var_23 in var_15)
    scripts\engine\utility::array_thread(var_23, ::_id_4CCE, var_16);

    wait(var_16 * 2);
  }
}

_id_4CCD(var_0) {
  self endon("death");
  self endon("disconnect");
  self setscriptablepartstate("onoff", "on");
  wait(var_0);
  self setscriptablepartstate("onoff", "off");
}

_id_4CCE(var_0) {
  self endon("death");
  self endon("disconnect");
  self setscriptablepartstate("onoff", "off");
  wait(var_0);
  self setscriptablepartstate("onoff", "on");
}

_id_129AE() {
  self endon("death");
  self endon("disconnect");
  self setscriptablepartstate("onoff", "on");
}

_id_4CCF(var_0) {
  self endon("death");
  self endon("disconnect");
  self setlightintensity(0.75);
  wait(var_0);
  self setlightintensity(0.0);
}