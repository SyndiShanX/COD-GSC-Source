/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\prisoner\gen\prisoner_art.gsc
*********************************************************/

main() {
  level.tweakfile = 1;
  level.player = getEntArray("player", "classname")[0];
  init_level_variables();
  _id_96FB();
  _id_96FC();
  setsaveddvar("r_umbraMinObjectContribution", 8);
  setsaveddvar("r_offloadPrimaryLights", 2);
  thread _id_CF7E();
  thread _id_CF7F();
  thread _id_95E6();
  thread _id_95E0();
  thread _id_246D();
  thread _id_CC2A();
  thread _id_5E37();
  thread _id_13548();
  thread _id_111FC();
  thread _id_12B36();
  thread _id_1A40();
}

init_level_variables() {
  level._id_1A41 = 0;
}

_id_96FB() {
  scripts\engine\utility::flag_init("street_attach_light_to_lookat_ship");
  scripts\engine\utility::flag_init("prison_start_collapse_flicker_lights");
  scripts\engine\utility::flag_init("sun_shadow_collapse_smoke_enter");
  scripts\engine\utility::flag_init("sun_shadow_collapse_smoke_exit");
  scripts\engine\utility::flag_init("sun_shadow_collapse_post_truck");
  scripts\engine\utility::flag_init("sun_shadow_alleys_enter");
  scripts\engine\utility::flag_init("sun_shadow_post_alleys_enter");
  scripts\engine\utility::flag_init("sun_shadow_streets_enter");
  scripts\engine\utility::flag_init("sun_shadow_bikeshop_inside_enter");
  scripts\engine\utility::flag_init("sun_shadow_courtyard_enter");
  scripts\engine\utility::flag_init("sun_shadow_terrace_enter");
  scripts\engine\utility::flag_init("sun_shadow_churchroad_enter");
  scripts\engine\utility::flag_init("sun_shadow_churchend_enter");
  scripts\engine\utility::flag_init("dynamic_sunshadow_street");
  scripts\engine\utility::flag_init("sunshadow_churchend_on");
  scripts\engine\utility::flag_init("sun_shadow_churchend_transition_off");
  scripts\engine\utility::flag_init("sun_shadow_churchend_transitioning");
  scripts\engine\utility::flag_init("umbra_spaceship_view_open");
  scripts\engine\utility::flag_init("umbra_churchroad_view_open");
  scripts\engine\utility::flag_init("umbra_churchroad_view_close");
  scripts\engine\utility::flag_init("umbra_purseshop_view_open");
  scripts\engine\utility::flag_init("umbra_purseshop_view_close");
  scripts\engine\utility::flag_init("umbra_bedroom_view_open");
  scripts\engine\utility::flag_init("umbra_bedroom_view_close");
  scripts\engine\utility::flag_init("umbra_mdlf_courtyard_view_open");
  scripts\engine\utility::flag_init("umbra_mdrt_courtyard_view_open");
  scripts\engine\utility::flag_init("umbra_md_courtyard_view_close");
  scripts\engine\utility::flag_init("umbra_mdlf_courtyard_view_close");
  scripts\engine\utility::flag_init("umbra_mdrt_courtyard_view_close");
  scripts\engine\utility::flag_init("umbra_apartment_view_open");
  scripts\engine\utility::flag_init("umbra_apartment_view_close");
  scripts\engine\utility::flag_init("umbra_cafe_view_open");
  scripts\engine\utility::flag_init("umbra_cafe_view_close");
  scripts\engine\utility::flag_init("truck_car_show");
  scripts\engine\utility::flag_init("truck_car_hide");
  scripts\engine\utility::flag_init("portal_mdlf_courtyard_view");
  scripts\engine\utility::flag_init("portal_mdrt_courtyard_view");
  scripts\engine\utility::flag_init("portal_cafe_view");
  scripts\engine\utility::flag_init("portal_bedroom_view");
  scripts\engine\utility::flag_init("portal_purseshop_view");
  scripts\engine\utility::flag_init("portal_churchroad_view");
  scripts\engine\utility::flag_init("portal_apartment_view");
  scripts\engine\utility::flag_init("robot_hacking_mode");
  scripts\engine\utility::flag_init("aiming_mode");
  scripts\engine\utility::flag_init("timing_check");
  scripts\engine\utility::flag_init("aiming_check_enabled");
}

_id_1A40() {
  scripts\engine\utility::flag_wait("aiming_check_enabled");
  level.player waittill("aim");
  wait 0.2;

  if(!scripts\engine\utility::flag("aiming_mode")) {
    setumbraportalstate("umbra_mdlf_courtyard_view", 1);
    setumbraportalstate("umbra_mdrt_courtyard_view", 1);
    setumbraportalstate("umbra_purseshop_view", 1);
    setumbraportalstate("umbra_l_churchroad_view", 1);
    setumbraportalstate("umbra_r_churchroad_view", 1);
    scripts\engine\utility::flag_set("aiming_mode");
  }

  level._id_1A41 = gettime();

  if(!scripts\engine\utility::flag("timing_check")) {
    scripts\engine\utility::flag_set("timing_check");
    thread _id_1193E();
  }

  wait 0.05;
  thread _id_1A40();
}

_id_1193E() {
  while(scripts\engine\utility::flag("timing_check")) {
    var_0 = gettime();
    var_1 = var_0 - level._id_1A41;

    if(var_1 > 250) {
      if(scripts\engine\utility::flag("aiming_mode")) {
        if(!scripts\engine\utility::flag("portal_mdlf_courtyard_view")) {
          setumbraportalstate("umbra_mdlf_courtyard_view", 0);
        }

        if(!scripts\engine\utility::flag("portal_mdrt_courtyard_view")) {
          setumbraportalstate("umbra_mdrt_courtyard_view", 0);
        }

        if(!scripts\engine\utility::flag("portal_purseshop_view")) {
          setumbraportalstate("umbra_purseshop_view", 0);
        }

        if(!scripts\engine\utility::flag("portal_churchroad_view")) {
          setumbraportalstate("umbra_l_churchroad_view", 0);
          setumbraportalstate("umbra_r_churchroad_view", 0);
        }

        scripts\engine\utility::flag_clear("timing_check");
      }

      return;
    }

    wait 0.02;
  }
}

_id_12B36() {
  thread _id_12B3E();
  thread _id_12B41();
  thread _id_12B3F();
  thread _id_12B35();
  thread _id_12B34();
  thread _id_12B3D();
  thread _id_12B3C();
  thread _id_12B39();
  thread _id_12B3B();
  thread _id_12B37();
  thread _id_12B38();
  thread _id_12B3A();
  thread _id_12B31();
  thread _id_12B30();
  thread _id_12B2F();
  thread _id_12B2E();
  thread _id_12B33();
  thread _id_12B32();
  thread _id_8EAB();
  thread _id_10104();
}

_id_12B3E() {
  var_0 = _id_0E29::_id_87F3();

  if(isDefined(var_0.targetname) && var_0.targetname == "van_c6") {
    scripts\engine\utility::flag_set("robot_hacking_mode");
    setumbraportalstate("umbra_purseshop_view", 1);
    setumbraportalstate("umbra_bedroom_view", 1);
    setumbraportalstate("umbra_mdlf_courtyard_view", 1);
    setumbraportalstate("umbra_mdrt_courtyard_view", 1);
    setumbraportalstate("umbra_apartment_view", 1);
    setumbraportalstate("umbra_cafe_view", 1);
    thread _id_8789();
  } else if(isDefined(var_0._id_ECE7) && var_0._id_ECE7 == "enemy_courtyard_suppress") {
    scripts\engine\utility::flag_set("robot_hacking_mode");
    setumbraportalstate("umbra_r_churchroad_view", 1);
    setumbraportalstate("umbra_l_churchroad_view", 1);
    thread _id_8789();
  } else
    thread _id_12B3E();
}

_id_8789() {
  for(;;) {
    var_0 = _id_0E29::_id_87A7();

    if(var_0 == "end") {
      scripts\engine\utility::flag_clear("robot_hacking_mode");

      if(!scripts\engine\utility::flag("portal_purseshop_view")) {
        setumbraportalstate("umbra_purseshop_view", 0);
      }

      if(!scripts\engine\utility::flag("portal_bedroom_view")) {
        setumbraportalstate("umbra_bedroom_view", 0);
      }

      if(!scripts\engine\utility::flag("portal_mdlf_courtyard_view")) {
        setumbraportalstate("umbra_mdlf_courtyard_view", 0);
      }

      if(!scripts\engine\utility::flag("portal_mdrt_courtyard_view")) {
        setumbraportalstate("umbra_mdrt_courtyard_view", 0);
      }

      if(!scripts\engine\utility::flag("portal_apartment_view")) {
        setumbraportalstate("umbra_apartment_view", 0);
      }

      if(!scripts\engine\utility::flag("portal_cafe_view")) {
        setumbraportalstate("umbra_cafe_view", 0);
      }

      if(!scripts\engine\utility::flag("portal_churchroad_view")) {
        setumbraportalstate("umbra_l_churchroad_view", 0);
        setumbraportalstate("umbra_r_churchroad_view", 0);
      }

      thread _id_12B3E();
      return;
    }

    wait 0.2;
  }
}

_id_12B41() {
  setumbraportalstate("umbra_spaceship_view", 0);
  setumbraportalstate("umbra_l_churchroad_view", 0);
  setumbraportalstate("umbra_r_churchroad_view", 0);
  setumbraportalstate("umbra_purseshop_view", 0);
  setumbraportalstate("umbra_bedroom_view", 0);
  setumbraportalstate("umbra_mdlf_courtyard_view", 0);
  setumbraportalstate("umbra_mdrt_courtyard_view", 0);
  setumbraportalstate("umbra_apartment_view", 0);
  setumbraportalstate("umbra_cafe_view", 0);
}

_id_12B3F() {
  scripts\engine\utility::flag_wait("umbra_spaceship_view_open");
  setumbraportalstate("umbra_spaceship_view", 1);
}

_id_12B3D() {
  scripts\engine\utility::flag_wait("umbra_purseshop_view_open");

  if(scripts\engine\utility::flag("portal_purseshop_view") || scripts\engine\utility::flag("robot_hacking_mode")) {
    scripts\engine\utility::flag_clear("umbra_purseshop_view_open");
    wait 0.5;
    thread _id_12B3D();
    return;
  }

  setumbraportalstate("umbra_purseshop_view", 1);
  scripts\engine\utility::flag_set("portal_purseshop_view");
  scripts\engine\utility::flag_clear("umbra_purseshop_view_open");
  wait 0.5;
  thread _id_12B3D();
}

_id_12B3C() {
  scripts\engine\utility::flag_wait("umbra_purseshop_view_close");
  scripts\engine\utility::flag_set("aiming_check_enabled");

  if(!scripts\engine\utility::flag("portal_purseshop_view") || scripts\engine\utility::flag("robot_hacking_mode")) {
    scripts\engine\utility::flag_clear("umbra_purseshop_view_close");
    wait 0.5;
    thread _id_12B3C();
    return;
  }

  if(!scripts\engine\utility::flag("aiming_mode")) {
    setumbraportalstate("umbra_purseshop_view", 0);
  }

  scripts\engine\utility::flag_clear("portal_purseshop_view");
  scripts\engine\utility::flag_clear("umbra_purseshop_view_close");
  wait 0.5;
  thread _id_12B3C();
}

_id_12B31() {
  scripts\engine\utility::flag_wait("umbra_bedroom_view_open");

  if(scripts\engine\utility::flag("portal_bedroom_view") || scripts\engine\utility::flag("robot_hacking_mode")) {
    scripts\engine\utility::flag_clear("umbra_bedroom_view_open");
    wait 0.5;
    thread _id_12B31();
    return;
  }

  setumbraportalstate("umbra_bedroom_view", 1);
  scripts\engine\utility::flag_set("portal_bedroom_view");
  scripts\engine\utility::flag_clear("umbra_bedroom_view_open");
  wait 0.5;
  thread _id_12B31();
}

_id_12B30() {
  scripts\engine\utility::flag_wait("umbra_bedroom_view_close");

  if(!scripts\engine\utility::flag("portal_bedroom_view") || scripts\engine\utility::flag("robot_hacking_mode")) {
    scripts\engine\utility::flag_clear("umbra_bedroom_view_close");
    wait 0.5;
    thread _id_12B30();
    return;
  }

  setumbraportalstate("umbra_bedroom_view", 0);
  scripts\engine\utility::flag_clear("portal_bedroom_view");
  scripts\engine\utility::flag_clear("umbra_bedroom_view_close");
  wait 0.5;
  thread _id_12B30();
}

_id_12B39() {
  scripts\engine\utility::flag_wait("umbra_mdlf_courtyard_view_open");

  if(scripts\engine\utility::flag("portal_mdlf_courtyard_view") || scripts\engine\utility::flag("robot_hacking_mode")) {
    scripts\engine\utility::flag_clear("umbra_mdlf_courtyard_view_open");
    wait 0.5;
    thread _id_12B39();
    return;
  }

  setumbraportalstate("umbra_mdlf_courtyard_view", 1);
  scripts\engine\utility::flag_set("portal_mdlf_courtyard_view");
  scripts\engine\utility::flag_clear("umbra_mdlf_courtyard_view_open");
  wait 0.5;
  thread _id_12B39();
}

_id_12B3B() {
  scripts\engine\utility::flag_wait("umbra_mdrt_courtyard_view_open");

  if(scripts\engine\utility::flag("portal_mdrt_courtyard_view") || scripts\engine\utility::flag("robot_hacking_mode")) {
    scripts\engine\utility::flag_clear("umbra_mdrt_courtyard_view_open");
    wait 0.5;
    thread _id_12B3B();
    return;
  }

  setumbraportalstate("umbra_mdrt_courtyard_view", 1);
  scripts\engine\utility::flag_set("portal_mdrt_courtyard_view");
  scripts\engine\utility::flag_clear("umbra_mdrt_courtyard_view_open");
  wait 0.5;
  thread _id_12B3B();
}

_id_12B38() {
  scripts\engine\utility::flag_wait("umbra_mdlf_courtyard_view_close");

  if(!scripts\engine\utility::flag("portal_mdlf_courtyard_view") || scripts\engine\utility::flag("robot_hacking_mode")) {
    scripts\engine\utility::flag_clear("umbra_mdlf_courtyard_view_close");
    wait 0.5;
    thread _id_12B38();
    return;
  }

  if(!scripts\engine\utility::flag("aiming_mode")) {
    setumbraportalstate("umbra_mdlf_courtyard_view", 0);
  }

  scripts\engine\utility::flag_clear("portal_mdlf_courtyard_view");
  scripts\engine\utility::flag_clear("umbra_mdlf_courtyard_view_close");
  wait 0.5;
  thread _id_12B38();
}

_id_12B3A() {
  scripts\engine\utility::flag_wait("umbra_mdrt_courtyard_view_close");

  if(!scripts\engine\utility::flag("portal_mdrt_courtyard_view") || scripts\engine\utility::flag("robot_hacking_mode")) {
    scripts\engine\utility::flag_clear("umbra_mdrt_courtyard_view_close");
    wait 0.5;
    thread _id_12B3A();
    return;
  }

  if(!scripts\engine\utility::flag("aiming_mode")) {
    setumbraportalstate("umbra_mdrt_courtyard_view", 0);
  }

  scripts\engine\utility::flag_clear("portal_mdrt_courtyard_view");
  scripts\engine\utility::flag_clear("umbra_mdrt_courtyard_view_close");
  wait 0.5;
  thread _id_12B3A();
}

_id_12B37() {
  scripts\engine\utility::flag_wait("umbra_md_courtyard_view_close");

  if(scripts\engine\utility::flag("robot_hacking_mode")) {
    scripts\engine\utility::flag_clear("umbra_md_courtyard_view_close");
    wait 0.5;
    thread _id_12B37();
    return;
  }

  if(!scripts\engine\utility::flag("portal_mdrt_courtyard_view") && !scripts\engine\utility::flag("portal_mdlf_courtyard_view")) {
    scripts\engine\utility::flag_clear("umbra_md_courtyard_view_close");
    wait 0.5;
    thread _id_12B37();
    return;
  }

  if(!scripts\engine\utility::flag("aiming_mode")) {
    setumbraportalstate("umbra_mdrt_courtyard_view", 0);
    setumbraportalstate("umbra_mdlf_courtyard_view", 0);
  }

  scripts\engine\utility::flag_clear("portal_mdrt_courtyard_view");
  scripts\engine\utility::flag_clear("portal_mdlf_courtyard_view");
  scripts\engine\utility::flag_clear("umbra_md_courtyard_view_close");
  wait 0.5;
  thread _id_12B37();
}

_id_12B2F() {
  scripts\engine\utility::flag_wait("umbra_apartment_view_open");

  if(scripts\engine\utility::flag("portal_apartment_view") || scripts\engine\utility::flag("robot_hacking_mode")) {
    scripts\engine\utility::flag_clear("umbra_apartment_view_open");
    wait 0.5;
    thread _id_12B2F();
    return;
  }

  setumbraportalstate("umbra_apartment_view", 1);
  scripts\engine\utility::flag_set("portal_apartment_view");
  scripts\engine\utility::flag_clear("umbra_apartment_view_open");
  wait 0.5;
  thread _id_12B2F();
}

_id_12B2E() {
  scripts\engine\utility::flag_wait("umbra_apartment_view_close");

  if(!scripts\engine\utility::flag("portal_apartment_view") || scripts\engine\utility::flag("robot_hacking_mode")) {
    scripts\engine\utility::flag_clear("umbra_apartment_view_close");
    wait 0.5;
    thread _id_12B2E();
    return;
  }

  setumbraportalstate("umbra_apartment_view", 0);
  scripts\engine\utility::flag_clear("portal_apartment_view");
  scripts\engine\utility::flag_clear("umbra_apartment_view_close");
  wait 0.5;
  thread _id_12B2E();
}

_id_12B33() {
  scripts\engine\utility::flag_wait("umbra_cafe_view_open");

  if(scripts\engine\utility::flag("portal_cafe_view") || scripts\engine\utility::flag("robot_hacking_mode")) {
    scripts\engine\utility::flag_clear("umbra_cafe_view_open");
    wait 0.5;
    thread _id_12B33();
    return;
  }

  setumbraportalstate("umbra_cafe_view", 1);
  scripts\engine\utility::flag_set("portal_cafe_view");
  scripts\engine\utility::flag_clear("umbra_cafe_view_open");
  wait 0.5;
  thread _id_12B33();
}

_id_12B32() {
  scripts\engine\utility::flag_wait("umbra_cafe_view_close");

  if(!scripts\engine\utility::flag("portal_cafe_view") || scripts\engine\utility::flag("robot_hacking_mode")) {
    scripts\engine\utility::flag_clear("umbra_cafe_view_close");
    wait 0.5;
    thread _id_12B32();
    return;
  }

  setumbraportalstate("umbra_cafe_view", 0);
  scripts\engine\utility::flag_clear("portal_cafe_view");
  scripts\engine\utility::flag_clear("umbra_cafe_view_close");
  wait 0.5;
  thread _id_12B32();
}

_id_12B35() {
  scripts\engine\utility::flag_wait("umbra_churchroad_view_open");
  scripts\engine\utility::flag_clear("aiming_check_enabled");

  if(scripts\engine\utility::flag("portal_churchroad_view") || scripts\engine\utility::flag("robot_hacking_mode")) {
    scripts\engine\utility::flag_clear("umbra_churchroad_view_open");
    wait 0.5;
    thread _id_12B35();
    return;
  }

  setumbraportalstate("umbra_l_churchroad_view", 1);
  setumbraportalstate("umbra_r_churchroad_view", 1);
  scripts\engine\utility::flag_set("portal_churchroad_view");
  scripts\engine\utility::flag_clear("umbra_churchroad_view_open");
  wait 0.5;
  thread _id_12B35();
}

_id_12B34() {
  scripts\engine\utility::flag_wait("umbra_churchroad_view_close");
  scripts\engine\utility::flag_set("aiming_check_enabled");

  if(!scripts\engine\utility::flag("portal_churchroad_view") || scripts\engine\utility::flag("robot_hacking_mode")) {
    scripts\engine\utility::flag_clear("umbra_churchroad_view_close");
    wait 0.5;
    thread _id_12B34();
    return;
  }

  if(!scripts\engine\utility::flag("aiming_mode")) {
    setumbraportalstate("umbra_l_churchroad_view", 0);
    setumbraportalstate("umbra_r_churchroad_view", 0);
  }

  scripts\engine\utility::flag_clear("portal_churchroad_view");
  scripts\engine\utility::flag_clear("umbra_churchroad_view_close");
  wait 0.5;
  thread _id_12B34();
}

_id_8EAB() {
  scripts\engine\utility::flag_wait("truck_car_hide");
  scripts\engine\utility::flag_clear("aiming_check_enabled");
  thread _id_8EAC();
  scripts\engine\utility::flag_clear("truck_car_hide");
  wait 0.5;
  thread _id_8EAB();
}

_id_8EAC() {
  var_0 = getEnt("model_terrace_truck", "targetname");
  var_1 = getscriptablearray("scriptable_churchroad_destroy", "script_noteworthy")[0];

  if(isDefined(var_1)) {
    var_1 hide();
  }

  if(isDefined(var_0)) {
    var_0 hide();
  }
}

_id_10104() {
  scripts\engine\utility::flag_wait("truck_car_show");
  thread _id_10105();
}

_id_10105() {
  var_0 = getEnt("model_terrace_truck", "targetname");
  var_1 = getscriptablearray("scriptable_churchroad_destroy", "script_noteworthy")[0];

  if(isDefined(var_1)) {
    var_1 show();
  }

  if(isDefined(var_0)) {
    var_0 show();
  }
}

_id_111FC() {
  thread _id_111FD();
  thread _id_111F7();
  thread _id_111F8();
  thread _id_111F5();
  thread _id_111EF();
  thread _id_11200();
  thread _id_11201();
  thread _id_111F0();
  thread _id_111FB();
  thread _id_11202();
  thread _id_111F4();
  thread _id_111F2();
}

_id_111FD() {
  thread _id_111FE();
}

_id_111FE() {
  setsaveddvar("sm_sunEnable", 1);
  setsaveddvar("sm_sunSampleSizeNear", 1);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 1);
}

_id_111F7() {
  scripts\engine\utility::flag_wait("sun_shadow_collapse_smoke_enter");
  thread _id_111F9();
}

_id_111F9() {
  setsaveddvar("sm_sunEnable", 1);
  setsaveddvar("sm_sunSampleSizeNear", 1);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 1);
}

_id_111F8() {
  scripts\engine\utility::flag_wait("sun_shadow_collapse_smoke_exit");
  thread _id_111FA();
}

_id_111FA() {
  setsaveddvar("sm_sunEnable", 0);
}

_id_111F5() {
  scripts\engine\utility::flag_wait("sun_shadow_collapse_post_truck");
  thread _id_111F6();
}

_id_111F6() {
  setsaveddvar("sm_sunEnable", 1);
  setsaveddvar("sm_sunSampleSizeNear", 0.3);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 1);
}

_id_111EF() {
  scripts\engine\utility::flag_wait("sun_shadow_alleys_enter");
  setsaveddvar("sm_sunEnable", 1);
  setsaveddvar("sm_sunSampleSizeNear", 0.3);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 1);
  scripts\engine\utility::flag_clear("sun_shadow_alleys_enter");
  wait 0.5;
  thread _id_111EF();
}

_id_11200() {
  scripts\engine\utility::flag_wait("sun_shadow_post_alleys_enter");
  scripts\engine\utility::flag_clear("dynamic_sunshadow_street");
  setsaveddvar("sm_sunEnable", 1);
  setsaveddvar("sm_sunSampleSizeNear", 1);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 1);
  scripts\engine\utility::flag_clear("sun_shadow_post_alleys_enter");
  wait 0.5;
  thread _id_11200();
}

_id_11201() {
  scripts\engine\utility::flag_wait("sun_shadow_streets_enter");
  setsaveddvar("sm_sunSampleSizeNear", 0.15);
  setsaveddvar("sm_sunEnable", 1);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 1);
  thread _id_111FF();
  scripts\engine\utility::flag_clear("sun_shadow_streets_enter");
  wait 0.5;
  thread _id_11201();
}

_id_111FF() {
  var_0 = 0.15;

  if(scripts\engine\utility::flag("dynamic_sunshadow_street")) {
    return;
  }
  scripts\engine\utility::flag_set("dynamic_sunshadow_street");

  for(;;) {
    if(isDefined(scripts\engine\utility::getStruct("lookat_dummy", "targetname"))) {
      var_1 = scripts\engine\utility::getStruct("lookat_dummy", "targetname");
      var_2 = vectorNormalize(var_1.origin - level.player.origin);
      var_2 = (var_2[0], var_2[1], 0);
      var_3 = anglesToForward(level.player.angles);
      var_4 = clamp(vectordot(var_2, var_3), 0, 1);
      var_5 = 0.5 * (1 - var_4) + 0.3 * var_4;
      var_6 = abs(var_5 - var_0);

      if(var_6 > 0.02) {
        setsaveddvar("sm_sunSampleSizeNear", var_5);
        var_0 = var_5;
      }
    }

    if(!scripts\engine\utility::flag("dynamic_sunshadow_street")) {
      return;
    }
    wait 0.35;
  }
}

_id_111F0() {
  scripts\engine\utility::flag_wait("sun_shadow_bikeshop_inside_enter");
  scripts\engine\utility::flag_clear("dynamic_sunshadow_street");
  setsaveddvar("sm_sunEnable", 0);
  scripts\engine\utility::flag_clear("sun_shadow_bikeshop_inside_enter");
  wait 0.5;
  thread _id_111F0();
}

_id_111FB() {
  scripts\engine\utility::flag_wait("sun_shadow_courtyard_enter");
  setsaveddvar("sm_sunEnable", 0);
  scripts\engine\utility::flag_clear("sunshadow_churchend_on");
  scripts\engine\utility::flag_clear("sun_shadow_courtyard_enter");
  wait 0.5;
  thread _id_111FB();
}

_id_11202() {
  scripts\engine\utility::flag_wait("sun_shadow_terrace_enter");
  setsaveddvar("sm_sunEnable", 0);
  scripts\engine\utility::flag_clear("sunshadow_churchend_on");
  scripts\engine\utility::flag_clear("sun_shadow_terrace_enter");
  wait 0.5;
  thread _id_11202();
}

_id_111F4() {
  scripts\engine\utility::flag_wait("sun_shadow_churchroad_enter");
  setsaveddvar("sm_sunEnable", 0);
  scripts\engine\utility::flag_clear("sunshadow_churchend_on");
  scripts\engine\utility::flag_clear("sun_shadow_churchroad_enter");
  wait 0.5;
  thread _id_111F4();
}

_id_11230() {
  for(;;) {
    if(isDefined(scripts\engine\utility::getStruct("courtyard_dummy", "targetname"))) {
      var_0 = scripts\engine\utility::getStruct("courtyard_dummy", "targetname");
      var_1 = vectorNormalize(var_0.origin - level.player.origin);
      var_1 = (var_1[0], var_1[1], 0);
      var_2 = vectorNormalize(anglesToForward(level.player.angles));
      var_3 = clamp(vectordot(var_1, var_2), 0, 1);

      if(!scripts\engine\utility::flag("sun_shadow_churchend_transitioning")) {
        return;
      }
      if(var_3 >= 0.2) {
        setsaveddvar("sm_sunEnable", 1);
        setsaveddvar("sm_sunSampleSizeNear", 0.5);
        setsaveddvar("sm_sunCascadeSizeMultiplier1", 2);
        scripts\engine\utility::flag_set("sunshadow_churchend_on");
        return;
      }
    }

    wait 0.35;
  }
}

_id_111F3() {
  scripts\engine\utility::flag_wait("sun_shadow_churchend_transition_off");

  if(scripts\engine\utility::flag("sunshadow_churchend_on")) {
    return;
  }
  scripts\engine\utility::flag_clear("sun_shadow_churchend_transitioning");
}

_id_111F2() {
  scripts\engine\utility::flag_wait("sun_shadow_churchend_enter");

  if(scripts\engine\utility::flag("sunshadow_churchend_on")) {
    scripts\engine\utility::flag_clear("sun_shadow_churchend_enter");
    wait 0.5;
    thread _id_111F2();
    return;
  }

  scripts\engine\utility::flag_clear("sun_shadow_churchend_transition_off");
  scripts\engine\utility::flag_set("sun_shadow_churchend_transitioning");
  thread _id_111F3();
  _id_11230();
  scripts\engine\utility::flag_clear("sun_shadow_churchend_enter");
  wait 0.5;
  thread _id_111F2();
}

_id_CF7E() {
  wait 0.5;
  var_0 = scripts\engine\utility::getfx("vfx_pr_rain_player_prox_r");
  var_1 = getEntArray("rain_blocker", "targetname");

  if(isDefined(level._id_5D6C)) {
    level._id_5D6C waittill("goal");
    thread _id_5520(var_1);
  }

  while(!scripts\engine\utility::flag("flag_church_outside_end")) {
    var_2 = 1;

    for(var_3 = 0; var_3 < var_1.size; var_3++) {
      if(level.player istouching(var_1[var_3])) {
        var_2 = 0;
        break;
      }
    }

    if(var_2) {
      var_4 = level.player.origin;
      playFX(var_0, var_4, (1, -1, 0), (0, 0, 1));
    }

    var_5 = randomfloatrange(0.5, 1.0);
    wait(var_5);
  }
}

_id_CF7F() {
  wait 0.5;
  var_0 = scripts\engine\utility::getfx("vfx_pr_rain_player_prox_light_r");
  var_1 = getEntArray("light_rain_area", "targetname");
  scripts\engine\utility::flag_wait("flag_terrace_end");

  while(!scripts\engine\utility::flag("flag_churchroad_end")) {
    var_2 = level.player.origin;
    playFX(var_0, var_2, (1, -1, 0), (0, 0, 1));
    var_3 = randomfloatrange(0.5, 1.0);
    wait(var_3);
  }

  while(!scripts\engine\utility::flag("flag_church_outside_end")) {
    var_4 = 0;

    foreach(var_6 in var_1) {
      if(level.player istouching(var_6)) {
        var_4 = 1;
        break;
      }
    }

    if(var_4) {
      var_2 = level.player.origin;
      playFX(var_0, var_2, (1, -1, 0), (0, 0, 1));
    }

    var_3 = randomfloatrange(0.5, 1.0);
    wait(var_3);
  }
}

_id_D94F() {
  scripts\engine\utility::waitframe();
  thread _id_D938();
  thread _id_D939();
}

_id_D938() {
  scripts\engine\utility::flag_wait("prisoner_collapse_a_vision_enable");
  wait 1.0;
}

_id_D939() {
  scripts\engine\utility::flag_wait("prisoner_collapse_b_vision_enable");
  wait 1.0;
}

_id_246D() {
  scripts\engine\utility::flag_wait("street_attach_light_to_lookat_ship");
  var_0 = getEntArray("ship_look_at_light", "targetname");
  scripts\engine\utility::array_thread(var_0, ::_id_CC1C);
}

_id_CC1C() {
  var_0 = getEnt("street_dest_ship_wing", "targetname");
  var_1 = parse_noteworthy_values();
  var_2 = float(var_1["x"]);
  var_3 = float(var_1["y"]);
  var_4 = float(var_1["z"]);
  self linkTo(var_0, "tag_origin", (var_2, var_3, var_4), (0, 0, 0));
}

_id_CC2A() {
  scripts\engine\utility::flag_wait("street_attach_light_to_lookat_ship");
  var_0 = [];
  var_0[0] = (803.768, -106.282, 85.474);
  var_0[1] = (803.768, -52.809, 85.474);
  var_1 = [];
  var_1[0] = (803.768, 20, 185.474);
  var_1[1] = (803.768, 30, 185.474);
  var_1[2] = (803.768, 40, 185.474);
  var_1[3] = (803.768, 30, 185.474);
  var_1[4] = (803.768, 20, 185.474);
  var_1[5] = (803.768, 10, 185.474);
  var_2 = scripts\engine\utility::getfx("vfx_pr_shipcrash_thruster_r");
  var_3 = scripts\engine\utility::getfx("vfx_pr_glass_explosion_shipcrash");
  var_4 = [];
  var_4[0] = (700, -400, 0);
  var_4[1] = (600, -400, 45);
  var_4[2] = (725, -420, 45);
  var_5 = [];
  var_5[0] = ::scripts\engine\utility::getfx("vfx_pr_fire_crash_ship_debris_med");
  var_5[1] = ::scripts\engine\utility::getfx("vfx_pr_fire_drips_r");
  var_5[2] = ::scripts\engine\utility::getfx("vfx_pr_crash_ship_debris_smk_sm");
  var_6 = [];
  var_6[0] = (270, 90, 180);
  var_6[1] = (0, 0, 0);
  var_6[2] = (-65, -70, 0);
  var_7 = getEnt("street_dest_ship_wing", "targetname");

  foreach(var_9 in var_0) {
    var_10 = scripts\engine\utility::spawn_tag_origin();
    var_10 linkTo(var_7, "tag_origin", var_9, (0, 0, 0));
    playFXOnTag(var_2, var_10, "tag_origin");
  }

  for(var_12 = 0; var_12 < var_5.size; var_12++) {
    var_13 = scripts\engine\utility::spawn_tag_origin();
    var_13 linkTo(var_7, "tag_origin", var_4[var_12], var_6[var_12]);
    playFXOnTag(var_5[var_12], var_13, "tag_origin");
  }

  wait 3.0;

  foreach(var_9 in var_1) {
    var_15 = randomintrange(-115, -75);
    var_16 = scripts\engine\utility::spawn_tag_origin();
    var_16 linkTo(var_7, "tag_origin", var_9, (0, var_15, 90));
    playFXOnTag(var_3, var_16, "tag_origin");
    var_17 = randomfloatrange(0.2, 0.75);
    wait(var_17);
  }
}

_id_95E0() {
  var_0 = getEntArray("fixture_flicker_light", "targetname");
  scripts\engine\utility::array_thread(var_0, ::_id_6E0D);
}

_id_6E0D() {
  var_0 = parse_noteworthy_values();
  self._id_AC97 = getEnt("light_fixture_flicker_off", "targetname");
  self._id_AC98 = getEnt("light_fixture_flicker_on", "targetname");
  self.frequency = 200;
  self._id_DCBE = 0.1;
  self.max_intensity = 150;
  self.min_intensity = 5;

  if(isDefined(var_0["frequency"])) {
    self.frequency = float(var_0["frequency"]);
  }

  if(isDefined(var_0["randomness"])) {
    self._id_DCBE = float(var_0["randomness"]);
  }

  if(isDefined(var_0["max_intensity"])) {
    self.max_intensity = float(var_0["max_intensity"]);
  }

  if(isDefined(var_0["min_intensity"])) {
    self.min_intensity = float(var_0["min_intensity"]);
  }

  thread _id_6E0C();
}

_id_6E0C() {
  for(;;) {
    var_0 = randomintrange(0, 100);

    if(var_0 >= 50) {
      self setlightintensity(self.max_intensity);
      self._id_AC97 hide();
      self._id_AC98 show();
    } else {
      self setlightintensity(self.min_intensity);
      self._id_AC97 show();
      self._id_AC98 hide();
    }

    wait(1 / self.frequency);
  }

  thread _id_6F0C();
}

_id_95E6() {
  var_0 = getEntArray("hm_flicker_light", "targetname");
  scripts\engine\utility::array_thread(var_0, ::_id_6F0F);
  var_1 = getEntArray("hm_siren_light", "targetname");
  scripts\engine\utility::array_thread(var_1, ::_id_1021D);
}

_id_6F0F() {
  var_0 = parse_noteworthy_values();
  self.frequency = 100;
  self._id_DCBE = 0.1;
  self.max_intensity = 150;
  self.min_intensity = 5;
  self._id_10C4F = "hm_flicker_light_start";

  if(isDefined(var_0["frequency"])) {
    self.frequency = float(var_0["frequency"]);
  }

  if(isDefined(var_0["randomness"])) {
    self._id_DCBE = float(var_0["randomness"]);
  }

  if(isDefined(var_0["max_intensity"])) {
    self.max_intensity = float(var_0["max_intensity"]);
  }

  if(isDefined(var_0["min_intensity"])) {
    self.min_intensity = float(var_0["min_intensity"]);
  }

  if(isDefined(var_0["start_flag"])) {
    self._id_10C4F = var_0["start_flag"];
  }

  thread _id_6F0C();
}

_id_1021D() {
  var_0 = parse_noteworthy_values();
  self._id_8C7B = 0;
  self._id_CBE9 = 1;
  self._id_E67D = 0;
  self.frequency = 1;
  self._id_99E5 = 0.5;
  self._id_54DA = 1;
  self._id_10C4F = "hm_siren_light_start";

  if(isDefined(var_0["heading"])) {
    self._id_8C7B = float(var_0["heading"]);
  }

  if(isDefined(var_0["pitch"])) {
    self._id_CBE9 = float(var_0["pitch"]);
  }

  if(isDefined(var_0["roll"])) {
    self._id_E67D = float(var_0["roll"]);
  }

  if(isDefined(var_0["frequency"])) {
    self.frequency = float(var_0["frequency"]);
  }

  if(isDefined(var_0["intensity"])) {
    self._id_99E5 = float(var_0["intensity"]);
  }

  if(isDefined(var_0["dir"])) {
    self._id_54DA = float(var_0["dir"]);
  }

  if(isDefined(var_0["start_flag"])) {
    self._id_10C4F = var_0["start_flag"];
  }

  thread _id_1021C();
}

_id_1021C() {
  scripts\engine\utility::flag_wait(self._id_10C4F);
  var_0 = self.angles;
  var_1 = 0.0;
  self setlightintensity(self._id_99E5);

  while(scripts\engine\utility::flag(self._id_10C4F)) {
    if(var_1 > 360) {
      var_1 = var_1 - 360;
    }

    var_2 = var_0[0] + var_1 * self._id_CBE9 * self._id_54DA;
    var_3 = var_0[1] + var_1 * self._id_8C7B * self._id_54DA;
    var_4 = var_0[2] + var_1 * self._id_E67D * self._id_54DA;
    self rotateTo((var_2, var_3, var_4), 0.09);
    var_1 = var_1 + 360 / (1 / self.frequency) / 100;
    wait 0.11;
  }

  self setlightintensity(0.01);
  thread _id_1021C();
}

_id_6F0C() {
  for(;;) {
    var_0 = randomfloatrange(self.min_intensity, self.max_intensity);
    self setlightintensity(var_0);
    wait(1 / self.frequency);
  }

  thread _id_6F0C();
}

parse_noteworthy_values() {
  var_0 = [];

  if(isDefined(self.script_noteworthy)) {
    var_1 = strtok(self.script_noteworthy, " ");

    foreach(var_3 in var_1) {
      var_4 = strtok(var_3, ":");
      var_0[var_4[0]] = var_4[1];
    }
  }

  return var_0;
}

_id_96FC() {
  scripts\engine\utility::flag_init("enable_volumetrics");
  scripts\engine\utility::flag_init("disable_volumetrics");
  scripts\engine\utility::flag_set("enable_volumetrics");
}

_id_13548() {
  thread _id_6252();
  thread _id_559F();
}

_id_6252() {
  scripts\engine\utility::flag_wait("enable_volumetrics");
  setsaveddvar("r_volumetrics", 1);
  scripts\engine\utility::flag_clear("enable_volumetrics");
  wait 1.0;
  thread _id_6252();
}

_id_559F() {
  scripts\engine\utility::flag_wait("disable_volumetrics");
  setsaveddvar("r_volumetrics", 0);
  scripts\engine\utility::flag_clear("disable_volumetrics");
  wait 1.0;
  thread _id_559F();
}

_id_5520(var_0) {
  scripts\engine\utility::flag_wait("collapse_out_of_dropship");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "dropship_rain_blocker") {
      var_2.origin = var_2.origin - (0, 0, 1000);
    }
  }

  _id_5D96();
}

_id_5D96() {
  wait 1.8;
  var_0 = getEnt("dropship_window_shadow", "targetname");

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_5E37() {
  wait 2.0;

  if(isDefined(level._id_5D6C)) {
    level._id_5D6C _id_0BBF::_id_F451(1);
  }
}