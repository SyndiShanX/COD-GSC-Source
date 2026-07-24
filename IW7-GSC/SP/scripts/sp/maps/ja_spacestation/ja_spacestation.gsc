/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\ja_spacestation\ja_spacestation.gsc
***************************************************************/

main() {
  scripts\sp\utility::_id_116CB("ja_spacestation");
  _id_10AE::_id_A0AB();
  scripts\sp\maps\ja_spacestation\gen\ja_spacestation_art::main();
  scripts\sp\maps\ja_spacestation\ja_spacestation_fx::main();
  scripts\sp\maps\ja_spacestation\ja_spacestation_precache::main();
  scripts\sp\utility::_id_F343("launch");
  scripts\sp\utility::_id_1749("launch", ::_id_10C98, "launch", ::_id_B209, undefined, undefined, 1);
  scripts\sp\utility::_id_1749("mission_complete", ::_id_10CAE, "mission_complete", ::_id_B20F, undefined, undefined, 1);
  scripts\sp\utility::_id_1749("destroyer_test", ::_id_10C16, "destroyer_test", ::_id_B1C0, undefined, undefined, 1);
  scripts\sp\load::main();

  if(getdvarint("shipcrib_nameplates", 22) == 0) {
    setDvar("shipcrib_nameplates", 1);
  }

  scripts\sp\utility::_id_241F(0);
  _id_10AE::_id_9637();
  _id_10AE::_id_9638();
  _id_A049();
  physics_setgravity((0, 0, 0));
  setsaveddvar("r_transShadowEnable", 1);
  setsaveddvar("r_heightfieldSunShadow", 0);
  setsaveddvar("sm_sunSampleSizeNear", 27.0);
  setsaveddvar("sm_sunCascadeSizeMultiplier2", 3);
  _id_1DE7();
  setglobalsoundcontext("atmosphere", "space", 1);
}

_id_A049() {
  _id_0BDC::_id_F435("jackal_landing_ja_spacestation");
  thread _id_10AE::_id_104D0("debris_cloud_struct", "vfx_space_debris_field_01");
  thread _id_10AE::_id_104D0("debris_pocket_sml_struct", "vfx_space_debris_field_debris_sml");
  thread _id_10AE::_id_104D0("debris_gas_struct", "vfx_ja_space_gas_cloud");
  thread _id_10AE::_id_A043();
}

_id_10C98() {}

_id_B209() {
  _id_10AE::_id_D7C9();
  var_0 = getEnt("player_jackal", "targetname");
  _id_0BDC::_id_10CD1(var_0);
  var_0 thread _id_10AE::_id_57C4("player_spline_intro", 400, 4.5);
  scripts\engine\utility::flag_wait("intro_start");
  thread _id_10AE::_id_57AC("skelters", "axis_arena_jackals", 14, 4, 8, 1, undefined, ::_id_10237);
  thread _id_10AE::_id_57A8("destroyers", "sdf_destroyers", 2, undefined, ::_id_5313);
  scripts\engine\utility::delaythread(0.05, ::_id_5315);
  thread _id_10AE::_id_5769("allyJackals", "ally_jackals", 7);
  thread _id_10AE::_id_E3B6(0);
  thread _id_10AE::_id_56B3("skelters", "jackal_objective_skelters", 0, &"JACKAL_OBJECTIVE_SKELTERS_MENU");
  thread _id_10AE::_id_56B3("destroyers", "jackal_objective_destroyers", 1, &"JACKAL_OBJECTIVE_DESTROYERS_MENU");
  scripts\engine\utility::delaythread(0.5, ::_id_BDEE);
  scripts\engine\utility::delaythread(0.5, _id_10AE::_id_CE81, ::_id_AAA1);
  thread _id_105F1();
  scripts\engine\utility::flag_wait("intro_done");
  thread _id_5317();
  thread _id_5314();
  thread _id_155A();
  thread _id_C507();
  scripts\engine\utility::flag_wait("skelterscomplete_vo_finished");
  scripts\engine\utility::flag_wait("destroyerscomplete_vo_finished");
  scripts\engine\utility::flag_wait("acescomplete_vo_finished");
}

_id_105F1() {
  thread _id_10AE::_id_5768("intro_jackals", "intro_jackal");
  _id_10AE::_id_E3A7("ret_goal1", 1500, 0, 0);
  _id_10AE::_id_E3A7("ret_goal2", 1000, 0, 0);
  _id_10AE::_id_E3A7("ret_goal3", 2000, 0, 0);
  thread _id_10AE::_id_E382("ret_pivot");
}

_id_155A() {
  var_0 = "skelters5_left";
  scripts\engine\utility::flag_wait(var_0);
  wait 2.5;
  thread _id_10AE::_id_57A7("aces", "sdf_ace", 1, ::_id_1550, ::_id_1551);
  thread _id_10AE::_id_56B3("aces", "jackal_objective_ace", 0, &"JACKAL_OBJECTIVE_ACE_MENU");
}

_id_E315() {
  var_0 = "skelters3_left";
  var_1 = "destroyers1_left";
  var_2 = scripts\engine\utility::flag_wait_any_return(var_0, var_1);
  level._id_A3A8["destroyers"]._id_FE2D = scripts\engine\utility::array_removeundefined(level._id_A3A8["destroyers"]._id_FE2D);

  if(level._id_A3A8["destroyers"]._id_FE2D.size > 1) {
    if(var_2 == var_0) {
      var_3 = undefined;
      var_4 = undefined;

      foreach(var_6 in level._id_A3A8["destroyers"]._id_FE2D) {
        var_7 = distance(level._id_E35D.origin, var_6.origin);

        if(!isDefined(var_4) || var_7 < var_3) {
          var_3 = var_7;
          var_4 = var_6;
        }
      }

      _id_10AE::_id_E3DD(var_4, 1, 30.0);
    } else
      _id_10AE::_id_E3DD(level._id_A3A8["destroyers"]._id_FE2D[0], 1, 30.0);
  }
}

_id_BDEE() {
  setmusicstate("mx_214_jackalassault_package");
}

_id_5314() {
  scripts\engine\utility::flag_wait("destroyerscomplete");
  _id_0A2F::_id_DA45("captain6", 2.0);
}

_id_5315() {
  var_0 = scripts\engine\utility::getStructArray("destroyer_pivot", "targetname");

  foreach(var_2 in level._id_A3A8["destroyers"]._id_FE2D) {
    var_3 = undefined;
    var_4 = undefined;

    foreach(var_6 in var_0) {
      var_7 = distance(var_2.origin, var_6.origin);

      if(!isDefined(var_4) || var_7 < var_4) {
        var_4 = var_7;
        var_3 = var_6;
      }
    }

    var_2 thread _id_52E8(var_3);
  }
}

_id_52E8(var_0) {
  level endon("stop_destroyer_circling");
  self endon("death");
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  var_2 = scripts\engine\utility::spawn_tag_origin(self._id_BCDA.origin, self._id_BCDA.angles);
  var_3 = anglesToForward(self.angles);
  var_4 = vectorNormalize(var_1.origin - var_2.origin);
  var_5 = vectorcross(var_3, var_4);
  var_6 = 1.0;

  if(vectordot(var_5, (0, 0, 1)) < 0) {
    var_6 = -1.0;
  }

  self._id_E720 = 0.08 * var_6;
  var_1.angles = (var_1.angles[0], self.angles[1], var_1.angles[2]);
  var_2 linkTo(var_1);

  for(;;) {
    var_1.angles = (var_1.angles[0], var_1.angles[1] + self._id_E720, var_1.angles[2]);
    self._id_BCDA.origin = var_2.origin;
    self._id_BCDA.angles = var_2.angles;
    wait 0.05;
  }
}

_id_C507() {
  var_0 = 0;

  for(;;) {
    var_1 = ["skelterscomplete_vo_finished", "destroyerscomplete_vo_finished", "acescomplete_vo_finished"];
    var_2 = level scripts\engine\utility::waittill_any_return(var_1[0], var_1[1], var_1[2]);
    var_3 = [];

    foreach(var_5 in var_1) {
      if(!scripts\engine\utility::flag_exist(var_5) || !scripts\engine\utility::flag(var_5)) {
        var_3[var_3.size] = var_5;
      }
    }

    if(!var_0 && var_3.size == 2) {
      var_7 = 0.8;
      thread _id_10AE::_id_CE80(::_id_12AD9, 0, var_7);
      var_0 = 1;
    }

    if(var_3.size == 1) {
      var_7 = 0.8;
      thread _id_10AE::_id_CE80(::_id_C506, 0, var_7);
      break;
    }

    wait 0.05;
  }
}

_id_10CAE() {
  var_0 = getEnt("player_jackal", "targetname");
  var_0 _id_0BDC::_id_1162F("start_destroyer_test");
  _id_0BDC::_id_10CD1(var_0);
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_6EEB();
  thread _id_10AE::_id_E3B6(1);
  thread _id_10AE::_id_E382("ret_pivot");

  if(getdvarint("ja_skip_preload", 0) == 0) {
    level thread scripts\sp\utility::_id_BF97();
  }

  scripts\engine\utility::flag_set("jackal_objectives_can_display");
}

_id_B20F() {
  while(!isDefined(level._id_E35D)) {
    wait 0.05;
  }

  scripts\sp\utility::_id_CF8B();
  scripts\sp\utility::_id_28D7();
  scripts\sp\utility::_id_6EEA();
  wait 1.0;
  thread space_stopmusic();
  scripts\engine\utility::flag_init("mission_complete_vo_done");
  thread _id_10AE::_id_CE81(::_id_B8BD);
  _id_10AE::_id_E3F9();
  scripts\engine\utility::flag_wait("mission_complete_vo_done");
  _id_10AE::_id_E3F8();
  _id_10AE::_id_579D(::_id_A7DA, ::_id_A7D9, ::_id_A82F, ::_id_A7F4);
}

space_stopmusic() {
  setmusicstate("");
  wait 5;
  setmusicstate("mx_spacestation_victory");
}

_id_E3E7(var_0) {
  var_1 = scripts\engine\utility::getStruct("ret_pivot", "targetname");
  var_2 = scripts\engine\utility::spawn_tag_origin(var_1.origin, var_1.angles);
  var_3 = scripts\engine\utility::spawn_tag_origin(level._id_FD6E._id_E35D.origin, level._id_FD6E._id_E35D.angles);
  var_2.angles = (var_2.angles[0], level._id_FD6E._id_E35D.angles[1], var_2.angles[2]);
  var_3 linkTo(var_2);
  wait 0.05;
  var_2.angles = (var_2.angles[0], var_2.angles[1] + 180, var_2.angles[2]);
  wait 0.05;
  level._id_FD6E._id_E35D.origin = var_3.origin;
  level._id_FD6E._id_E35D.angles = var_3.angles;
}

_id_10C16() {
  var_0 = getEnt("player_jackal", "targetname");
  var_0 _id_0BDC::_id_1162F("start_destroyer_test");
  _id_0BDC::_id_10CD1(var_0);
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_6EEB();
  thread _id_10AE::_id_E3B6(0);
}

_id_B1C0() {
  wait 1;
  thread _id_10AE::_id_57A8("destroyers", "sdf_destroyers", 1, undefined, ::_id_5313);
  scripts\engine\utility::flag_set("jackal_objectives_can_display");
  thread _id_10AE::_id_56B3("destroyers", "jackal_objective_destroyer");

  while(!level.player buttonPressed("DPAD_DOWN")) {
    wait 0.05;
  }

  _id_10AE::_id_E3DD(level._id_A3A8["destroyers"]._id_FE2D[0], 1, 30.0);
  level waittill("never");
}

_id_AAA1() {
  scripts\sp\utility::_id_1034D("ja_spstation_plr_portops");
  scripts\sp\utility::_id_10350("ja_spstation_nav_multiplesdfcapital");
  scripts\sp\utility::_id_10350("ja_spstation_slt_wegotskelters");
  scripts\sp\utility::_id_1034D("ja_spstation_plr_retributionhitt");
  scripts\sp\utility::_id_1034D("ja_spstation_plr_scarsonmeconcen");
  scripts\sp\utility::_id_10350("ja_spstation_slt_letsgetintherer");
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_6EEB();
}

_id_B8BD() {
  scripts\sp\utility::_id_10350("ja_spstation_nav_zoneisclear");
  scripts\sp\utility::_id_1034D("ja_spstation_plr_outpostisstill");
  scripts\sp\utility::_id_10350("ja_spstation_slt_thankstoyou141");
  scripts\sp\utility::_id_10350("ja_spstation_nav_wehavesomeaces");
  scripts\sp\utility::_id_10350("ja_spstation_slt_suredo");
  scripts\engine\utility::delaythread(2.0, scripts\engine\utility::flag_set, "mission_complete_vo_done");
  scripts\sp\utility::_id_1034D("ja_spstation_plr_missionaccompli");
  scripts\sp\utility::_id_10350("ja_spstation_nav_towerissetfor");
}

_id_10237() {
  scripts\sp\utility::_id_10350("ja_spstation_nav_captainskelterseliminated");
  scripts\sp\utility::_id_10350("ja_spstation_slt_niceworkeveryone");

  if(scripts\engine\utility::flag_exist("acescomplete") && !scripts\engine\utility::flag("acescomplete")) {
    scripts\sp\utility::_id_10350("ja_spstation_slt_gotoneaceleft");
    scripts\sp\utility::_id_1034D("ja_spstation_plr_copuillboxhim");
  }
}

_id_1550() {
  scripts\sp\utility::_id_10350("ja_spstation_slt_goteyesonanaces");
  scripts\sp\utility::_id_1034D("ja_spstation_plr_hesmine");
}

_id_1551() {
  scripts\sp\utility::_id_1034D("ja_spstation_plr_gotemacedown");
  scripts\sp\utility::_id_10350("ja_spstation_slt_solidshots11");
}

_id_5317() {
  scripts\engine\utility::flag_wait("destroyers1_left");
  wait 3.0;
  _id_10AE::_id_1350F();
  scripts\sp\utility::_id_10350("ja_spstation_nav_splashgoodhitson");
  scripts\sp\utility::_id_10350("ja_spstation_nav_onemoretogo");
  scripts\sp\utility::_id_1034D("ja_spstation_plr_scarsdirectyour");
  scripts\sp\utility::_id_10350("ja_spstation_slt_letsknockitout");
  _id_10AE::_id_134D1();
}

_id_5313() {
  scripts\sp\utility::_id_10350("ja_spstation_slt_dismissed");
  scripts\sp\utility::_id_10350("ja_spstation_nav_finaldestroyerdown");
}

_id_C506() {
  if(scripts\engine\utility::flag_exist("destroyerscomplete") && scripts\engine\utility::flag("destroyerscomplete") && scripts\engine\utility::flag_exist("skelterscomplete") && scripts\engine\utility::flag("skelterscomplete") && scripts\engine\utility::flag_exist("acescomplete") && scripts\engine\utility::flag("acescomplete")) {
    return;
  }
  scripts\sp\utility::_id_10350("ja_spstation_slt_letsnotleavebrass");
  scripts\sp\utility::_id_1034D("ja_spstation_plr_letscleanupther");
}

_id_12AD9() {
  scripts\sp\utility::_id_1034D("ja_spstation_plr_gatorwhatsyourstatus");
  scripts\sp\utility::_id_10350("ja_spstation_nav_maintainingsir");
  scripts\sp\utility::_id_1034D("ja_spstation_plr_youneedhelp");
  scripts\sp\utility::_id_10350("ja_spstation_nav_negativestaydown");
  scripts\sp\utility::_id_1034D("ja_spstation_plr_roger2");
}

_id_A7DA() {
  level endon("ja_vo_interrupt");
  scripts\sp\utility::_id_10350("ja_spstation_slt_towerthisisscar12");
  scripts\sp\utility::_id_10350("ja_spstation_amb_rogerjackalsare");
}

_id_A7D9() {
  level endon("ja_vo_interrupt");
  scripts\sp\utility::_id_1034D("ja_spstation_plr_11inbound");
}

_id_A82F() {
  level endon("ja_vo_interrupt");
  scripts\sp\utility::_id_10350("ja_spstation_amb_droneassistis");
  scripts\sp\utility::_id_1034D("ja_spstation_plr_gearsoutfordrone");
}

_id_A7F4() {
  level endon("ja_vo_interrupt");
  scripts\sp\utility::_id_10350("ja_spstation_amb_goodlink11wel");
}

_id_1DE7() {
  var_0 = getEntArray("ambient_rotate_object", "script_noteworthy");
  level._id_E736 = [];

  foreach(var_2 in var_0) {
    if(!issubstr(var_2.classname, "script_brushmodel")) {
      var_3 = getEntArray(var_2.target, "targetname");

      if(isDefined(var_2.target)) {
        scripts\engine\utility::array_call(var_3, ::linkto, var_2);
      }

      level._id_E736[level._id_E736.size] = var_2;
      var_2 thread _id_1DE6();
    }
  }
}

_id_1DE6() {
  var_0 = 1;
  var_1 = 10;
  var_2 = 2;
  var_3 = [];

  if(isDefined(self.script_parameters)) {
    var_3 = strtok(self.script_parameters, " ");
  }

  var_4 = [];
  var_5 = [];
  var_2 = clamp(var_2, 2, 3);

  for(var_6 = 0; var_6 < var_2; var_6++) {
    if(!isDefined(var_3[var_6])) {
      if(var_3.size == 1) {
        var_4[var_6] = float(var_3[0]);
      } else {
        var_4[var_6] = randomintrange(var_0, var_1);
      }
    } else
      var_4[var_6] = float(var_3[var_6]);

    var_5[var_6] = ::scripts\engine\utility::random([-1, 1]);
  }

  for(;;) {
    var_7 = [];
    var_8 = "";

    for(var_6 = 0; var_6 < var_2; var_6++) {
      var_7[var_6] = self.angles[var_6] + var_4[var_6] / 20 * var_5[var_6];
      var_8 = var_8 + (var_4[var_6] + " ");
    }

    self.angles = (var_7[0], var_7[1], self.angles[2]);

    if(getdvarint("debug_rotate") == 1) {
      thread scripts\engine\utility::draw_ent_axis((1, 0, 0), 2, 1000);
    }

    scripts\engine\utility::waitframe();
  }
}