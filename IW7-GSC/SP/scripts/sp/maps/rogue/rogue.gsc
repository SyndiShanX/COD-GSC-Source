/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\rogue\rogue.gsc
*******************************************/

main() {
  scripts\sp\utility::_id_116CB("rogue");
  scripts\sp\utility::_id_1263F("rogue_hangar_tr");
  scripts\sp\utility::_id_1263F("rogue_surface_tr");
  scripts\sp\utility::_id_1263F("rogue_dorm_tr");
  scripts\sp\utility::_id_1263F("rogue_dorm_int_tr");
  scripts\sp\utility::_id_1263F("rogue_shipping_tr");
  scripts\sp\utility::_id_1263F("rogue_control_tr");
  scripts\sp\utility::_id_1263F("rogue_depot_tr");
  scripts\sp\utility::_id_1263F("rogue_civilian_tr");
  scripts\sp\utility::_id_1263F("rogue_finale_tr");
  scripts\sp\utility::_id_1263F("rogue_base_tr");

  if(getdvarint("r_reflectionProbeGenerate") == 1)
    _id_894E();

  scripts\sp\maps\rogue\gen\rogue_art::main();
  scripts\sp\maps\rogue\rogue_fx::main();
  scripts\sp\maps\rogue\rogue_precache::main();
  _id_E612();
  setsaveddvar("sm_sunMoving", 1);
  scripts\sp\utility::_id_16CC("large_medium_constant", 0.45, 2, 2048);
  scripts\sp\load::main();
  setsaveddvar("sm_roundRobinPrioritySpotShadows", 8);
  scripts\sp\maps\rogue\rogue_anim::main();
  scripts\sp\maps\rogue\rogue_audio::main();
  _id_E668();
  _id_E64E();
  _id_E673();
  _id_0F21::main();
  scripts\sp\maps\rogue\rogue_lights::main();
  thread _id_E667();
  _id_E66B();
  level._id_3373 = 0.25;
  level thread _id_0A2F::_id_3D61();
  _id_0E29::hack_enable_enemy_melee(1);
}

_id_D428() {
  return level.player issprinting();
}

_id_894E() {
  var_0 = getEnt("dorm_tv_screen", "targetname");

  if(isDefined(var_0))
    var_0 hide();
}

_id_E612() {
  var_0 = ["rogue_hangar_tr"];
  var_1 = ["rogue_hangar_tr", "rogue_surface_tr", "rogue_base_tr"];
  var_2 = ["rogue_hangar_tr", "rogue_surface_tr", "rogue_dorm_tr", "rogue_base_tr"];
  var_3 = ["rogue_dorm_tr", "rogue_dorm_int_tr", "rogue_shipping_tr", "rogue_base_tr"];
  var_4 = ["rogue_dorm_int_tr", "rogue_shipping_tr", "rogue_base_tr"];
  var_5 = ["rogue_shipping_tr", "rogue_base_tr"];
  var_6 = ["rogue_shipping_tr", "rogue_control_tr", "rogue_base_tr"];
  var_7 = ["rogue_control_tr", "rogue_depot_tr", "rogue_base_tr"];
  var_8 = ["rogue_depot_tr", "rogue_civilian_tr", "rogue_base_tr"];
  var_9 = ["rogue_depot_tr", "rogue_civilian_tr", "rogue_finale_tr", "rogue_base_tr"];
  var_10 = ["rogue_civilian_tr", "rogue_finale_tr", "rogue_base_tr"];
  scripts\sp\utility::_id_1749("infil_land", ::_id_10C87, "Infil Land", ::_id_9464, var_1, scripts\sp\maps\rogue\infil::_id_3B76);
  scripts\sp\utility::_id_1749("hangar", ::_id_10C71, "Hangar", ::_id_8A0D, var_1, scripts\sp\maps\rogue\hangar::_id_3B6D);
  scripts\sp\utility::_id_1749("surface", ::_id_10D3F, "Surface", ::_id_112D4, var_1, scripts\sp\maps\rogue\surface::_id_112D7);
  scripts\sp\utility::_id_1749("dorm_run", ::_id_10C1D, "Dorm Run", ::_id_5A9B, var_2, scripts\sp\maps\rogue\dormitory::_id_5A68);
  scripts\sp\utility::_id_1749("dorm_airlock", ::_id_10C1C, "Dorm Airlock", ::_id_5A93, var_3, undefined);
  scripts\sp\utility::_id_1749("dorm_explore", ::_id_10C1B, "Dormitory Exploration", ::_id_5A92, var_3, undefined);
  scripts\sp\utility::_id_1749("corpse_airlock", ::_id_10C04, "Corpse Airlock", ::_id_466D, var_4, undefined);
  scripts\sp\utility::_id_1749("creep_hallway", ::_id_10C07, "Creep Hallway", ::_id_4A54, var_4, undefined);
  scripts\sp\utility::_id_1749("creep_buddy", ::_id_10C06, "Creep Buddy", ::_id_4A44, var_4, undefined);
  scripts\sp\utility::_id_1749("shipping", ::_id_10D19, "Shipping", ::_id_FE16, var_4, scripts\sp\maps\rogue\shipping::_id_3B89);
  scripts\sp\utility::_id_1749("shipping_defend_a", ::_id_10D1A, "Shipping Defend A", ::_id_FE19, var_5, undefined);
  scripts\sp\utility::_id_1749("shipping_defend_b", ::_id_10D1B, "Shipping Defend B", ::_id_FE1C, var_5, undefined);
  scripts\sp\utility::_id_1749("shipping_defend_exit", ::_id_10D1C, "Shipping Defend Exit", ::_id_FE1F, var_5, undefined);
  scripts\sp\utility::_id_1749("control_room", ::_id_10C02, "Control Room", ::_id_45B1, var_6, scripts\sp\maps\rogue\control_room::_id_3B50);
  scripts\sp\utility::_id_1749("depot", ::_id_10C13, "Depot", ::_id_5238, var_7, scripts\sp\maps\rogue\depot::_id_3B54);
  scripts\sp\utility::_id_1749("depot_pit", ::_id_10C14, "Depot Pit", ::_id_5245, var_8, scripts\sp\maps\rogue\depot::_id_3B55);
  scripts\sp\utility::_id_1749("civilians", ::_id_10BEE, "Civilians", ::_id_3FDD, var_9, undefined);
  scripts\sp\utility::_id_1749("finale_combat", ::_id_10C4B, "Finale", ::_id_6C2E, var_10, ::_id_6C31);
  scripts\sp\utility::_id_1749("finale_drag", ::_id_10C4C, "Finale", ::_id_6C35, var_10, undefined);
}

_id_E667() {
  thread scripts\sp\maps\rogue\rogue_util::_id_D726();

  switch (level._id_10CDA) {
    case "surface":
    case "hangar":
    case "infil_land":
      scripts\sp\maps\rogue\rogue_util::_id_1730("hangar");
      scripts\sp\maps\rogue\rogue_util::_id_1730("run1");
      thread scripts\sp\maps\rogue\rogue_util::_id_6E55("player_jumped_chasm", scripts\sp\maps\rogue\rogue_util::_id_E078, "hangar");
      thread scripts\sp\maps\rogue\rogue_util::_id_6E55("player_jumped_chasm", scripts\sp\maps\rogue\rogue_util::_id_E078, "run1");
    case "dorm_airlock":
    case "dorm_run":
      scripts\sp\maps\rogue\rogue_util::_id_1730("solararray");
      scripts\sp\maps\rogue\rogue_util::_id_1730("run2");
      level.doors["creep_exit_doors"] thread scripts\sp\maps\rogue\rogue_util::_id_65E5("door_sequence_complete", scripts\sp\maps\rogue\rogue_util::_id_E078, "run2");
      scripts\engine\utility::flag_wait("airlocks_setup");
      level._id_1AE3["dormitory_entrance_airlock"] scripts\sp\utility::_id_65E3("cycling_complete");
      scripts\sp\maps\rogue\rogue_util::_id_E078("solararray");
      scripts\engine\utility::flag_wait("flag_lgt_dormitory_start");
    case "creep_buddy":
    case "creep_hallway":
    case "corpse_airlock":
    case "dorm_explore":
      scripts\sp\maps\rogue\rogue_util::_id_1730("dorm");
      level.doors["creep_exit_doors"] scripts\sp\utility::_id_65E3("begin_opening");
      level.doors["creep_exit_doors"] thread scripts\sp\maps\rogue\rogue_util::_id_65E5("door_sequence_complete", scripts\sp\maps\rogue\rogue_util::_id_E078, "dorm");
    case "shipping":
      scripts\sp\maps\rogue\rogue_util::_id_1730("shippinghall");
      level.doors["shipping_exit_doors"] thread scripts\sp\maps\rogue\rogue_util::_id_65E5("door_sequence_complete", scripts\sp\maps\rogue\rogue_util::_id_E078, "shippinghall");
    case "shipping_defend_b":
    case "shipping_defend_a":
      scripts\sp\maps\rogue\rogue_util::_id_1730("shippingdefend");
      scripts\engine\utility::flag_wait("flag_defend_cleanup");
      scripts\sp\maps\rogue\rogue_util::_id_E078("shippingdefend");
    case "control_room":
    case "shipping_defend_exit":
      scripts\sp\maps\rogue\rogue_util::_id_1730("controlroom");
      scripts\engine\utility::flag_wait("activate_peek_bots");
      scripts\sp\maps\rogue\rogue_util::_id_E078("controlroom");
    case "depot_pit":
    case "depot":
      scripts\sp\maps\rogue\rogue_util::_id_1730("depot");
      level.doors["civilian_buddydoor"] scripts\sp\utility::_id_65E3("begin_opening");
      level.doors["civilian_buddydoor"] thread scripts\sp\maps\rogue\rogue_util::_id_65E5("door_sequence_complete", scripts\sp\maps\rogue\rogue_util::_id_E078, "depot");
    case "finale_combat":
    case "civilians":
      scripts\sp\maps\rogue\rogue_util::_id_1730("finale");
    case "finale_drag":
      scripts\sp\maps\rogue\rogue_util::_id_1730("finale");
      break;
    default:
      break;
  }
}

_id_E66B() {
  setsaveddvar("r_dof_hq", 0);
  thread _id_ABE0();
  thread scripts\sp\maps\rogue\rogue_util::_id_D74A();
  thread scripts\sp\maps\rogue\rogue_util::_id_E664();
  thread scripts\sp\maps\rogue\rogue_util::_id_E666();
  thread scripts\sp\maps\rogue\rogue_util::setup_rogue_back_blockers();
  thread scripts\sp\maps\rogue\rogue_util::rogue_gameskill_watcher();
  scripts\sp\utility::_id_22C9("melee_c6", scripts\sp\maps\rogue\rogue_util::_id_C63F, 1);
  scripts\sp\utility::_id_22C9("security_c6", scripts\sp\maps\rogue\rogue_util::_id_C63F, 0);
  enableforcedsunshadows();
  level._id_4055 = [];
  scripts\sp\maps\rogue\rogue_util::_id_4A9B();
  scripts\sp\maps\rogue\rogue_util::_id_111ED();
  thread scripts\sp\maps\rogue\rogue_util::_id_D26D();
  scripts\engine\utility::array_thread(getEntArray("day_duration_trig", "targetname"), scripts\sp\maps\rogue\rogue_util::_id_4D9D);
  scripts\sp\maps\rogue\rogue_util::_id_D1D8();
  thread scripts\sp\maps\rogue\rogue_util::_id_111E6();
  level._id_649C = [];
  thread scripts\sp\maps\rogue\rogue_util::_id_118CC();
  thread scripts\engine\pipes::main();
  scripts\sp\utility::_id_28D7("axis");
  thread scripts\sp\maps\rogue\rogue_util::_id_F8B1();
  thread scripts\sp\maps\rogue\rogue_util::_id_C855();
  _id_1AE4();
  thread scripts\sp\maps\rogue\rogue_util::_id_1AC5("red");
  thread scripts\sp\maps\rogue\shipping::_id_973B();
  level._id_5246 = getEntArray("depot_pit_catwalk", "script_noteworthy");
  level._id_5247 = getEntArray("depot_pit_catwalk_destroyed", "script_noteworthy");
  scripts\engine\utility::array_call(level._id_5247, ::hide);
  scripts\engine\utility::array_call(getEntArray("model_salter_pipship", "targetname"), ::hide);
  scripts\engine\utility::flag_clear("flashlight_desired");
  scripts\engine\utility::flag_clear("in_creep_hallway");
  thread scripts\sp\maps\rogue\rogue_util::_id_54FF();
  thread _id_960C();
  thread scripts\sp\maps\rogue\rogue_util::_id_11208();
  thread scripts\sp\maps\rogue\rogue_util::_id_111CC();
  thread _id_0B0A::_id_583F(getdvarint("scr_dof_nearStart"), getdvarint("scr_dof_nearEnd"), getdvarfloat("scr_dof_nearBlur"), 0, 150000, 1, 0);
  thread scripts\sp\maps\rogue\rogue_util::_id_43E1();
}

_id_960C() {
  level.player endon("death");

  if(!isDefined(level._id_8632)) {
    level._id_8632 = spawn("script_model", (0, 0, 0));
    level._id_8632 rotateTo((0, 0, 0), 0.01);
  }

  thread scripts\sp\maps\rogue\rogue_util::_id_59C6();
  level._id_8632 = spawn("script_model", (0, 0, 0));
  level._id_8632 rotateTo((0, 0, 0), 0.01);
  scripts\engine\utility::waitframe();
  level.player _meth_823F(level._id_8632);
  thread _id_10AC5();
  var_0 = undefined;
  var_1 = 1;
  var_2 = undefined;

  for(;;) {
    var_3 = ["hangar", "run1", "solararray", "run2"];
    var_4 = ["dorm", "shippinghall", "controlroom", "depot"];

    if(isalive(level.player)) {
      if(isDefined(var_0) && var_0 == "player_in_scene" || scripts\engine\utility::flag("player_in_scene")) {
        level._id_8632 rotateTo((0, 0, 0), 1);
        scripts\engine\utility::flag_waitopen("player_in_scene");
        var_1 = 3.5;
      } else
        var_1 = 1;

      if(isDefined(level._id_1158[0])) {
        var_5 = 0;

        if(isDefined(level._id_1158[1])) {
          if(level._id_1158[1] == "dorm")
            var_5 = 1;
        }

        var_6 = 0;

        if(level._id_1158[0] == "finale")
          var_6 = 1;
        else if(isDefined(level._id_1158[1])) {
          if(level._id_1158[1] == "finale")
            var_6 = 1;
        }

        var_7 = 0;
        var_8 = 0;

        if((level._id_1158[0] == "hangar" || level._id_1158[0] == "solararray") && scripts\engine\utility::flag("player_is_outside") == 1)
          var_7 = 15;
        else if(level._id_1158[0] == "hangar" || level._id_1158[0] == "solararray")
          var_7 = 10;
        else if(scripts\engine\utility::array_contains(var_4, level._id_1158[0]) || var_5 == 1)
          var_7 = 3;
        else
          var_7 = 5;

        if(var_7 >= 15) {
          var_8 = randomfloatrange(7, 10);

          if(level._id_111C3.time >= 0 && level._id_111C3.time < 12)
            level._id_8632 rotateTo((20, 0, 0), var_8);
          else if(level._id_111C3.time >= 12)
            level._id_8632 rotateTo((-20, 0, 0), var_8);

          level.player _meth_8251((level._id_111C3.time / 24 * 10 - 10, 0, 0), 0);
        } else {
          var_8 = randomfloatrange(0.25, 0.5) * var_1;
          level._id_8632 rotateTo((randomfloatrange(var_7, var_7 + 0.5), randomfloatrange(var_7, var_7 + 0.5), 0), var_8 * var_1);
          level.player _meth_8251((0, 0, 0), 0);
        }

        if(isDefined(var_0) && var_0 == "rogue_quake" && !scripts\engine\utility::flag("outdoor_surface_physics_on")) {
          if(!(scripts\engine\utility::array_contains(var_4, level._id_1158[0]) || var_5 || var_6)) {
            var_9 = 900;
            var_10 = 500;
            var_11 = -100;
            thread _id_DC60(var_9, var_10, var_11, 1);
          } else if(!var_6) {
            var_9 = 400;
            var_10 = 200;
            var_11 = -200;
            var_12 = 0;

            if(scripts\engine\utility::flag("power_on"))
              var_12 = 0.01;
            else
              var_12 = -0.01;

            thread _id_DC60(var_9, var_10, var_11);
          } else
            thread _id_DC60(0, 0, -389);
        } else if(scripts\engine\utility::flag("outdoor_surface_physics_on")) {
          if(!isDefined(var_2)) {
            thread _id_13858();
            var_2 = 1;
          }

          var_9 = 200;
          var_10 = 100;
          var_11 = -80;
          physics_setgravity((var_9, var_10, var_11));
        }
      }
    }

    var_0 = level scripts\engine\utility::waittill_any_return("rogue_quake", "player_in_scene", "power_on", "power_off");
    wait 0.1;
  }
}

_id_DC60(var_0, var_1, var_2, var_3) {
  level endon("rogue_quake");

  if(getdvarint("override_rogue_physics", 0) == 1) {
    if(getdvarint("rogue_grav_x", 0) != 0)
      var_0 = getdvarint("rogue_grav_x", 0);

    if(getdvarint("rogue_grav_y", 0) != 0)
      var_1 = getdvarint("rogue_grav_y", 0);

    if(getdvarint("rogue_grav_z", 0) != 0)
      var_2 = getdvarint("rogue_grav_z", 0);
  }

  var_4 = 0.75;
  var_5 = var_4 / 0.05;
  var_6 = var_0 / var_5;
  var_7 = var_1 / var_5;
  var_8 = (-389 - var_2) / var_5 * -1.5;

  while(var_0 != 0 || var_1 != 0 || var_2 != -389) {
    physics_setgravity((var_0, var_1, var_2));

    if(var_0 - var_6 <= 0)
      var_0 = 0;
    else
      var_0 = var_0 - var_6;

    if(var_1 - var_7 <= 0)
      var_1 = 0;
    else
      var_1 = var_1 - var_7;

    if(var_2 - var_8 <= -389)
      var_2 = -389;
    else
      var_2 = var_2 - var_8;

    wait 0.05;
  }
}

_id_C759() {
  wait 0.2;

  if(!isDefined(level._id_CB16))
    return;
  else {
    if(level._id_CB16 == "right") {
      return;
    }
    return;
  }
}

_id_13858() {
  level endon("dorm_run_over");

  for(;;) {
    wait 0.15;

    if(isalive(level.player)) {
      var_0 = level.player getEye();
      var_1 = level.player getplayerangles();
      var_2 = anglesToForward(var_1);
      var_3 = 0;

      if(isDefined(level._id_1158[0])) {
        if(level._id_1158[0] == "dorm")
          var_3 = 1;

        if(isDefined(level._id_1158[1])) {
          if(level._id_1158[1] == "dorm")
            var_3 = 1;
        }
      }

      if(var_3 == 0)
        physicsexplosionsphere(var_0 + var_2 * 200, 400, 1, 0.01);
      else
        physicsexplosionsphere(var_0 + var_2 * 150, 300, 1, 0.01);
    }
  }
}

_id_10AC5() {
  level.player endon("death");

  for(;;) {
    if(scripts\engine\utility::flag("flashlight_desired")) {
      var_0 = 0;

      if(isDefined(level._id_1158[1])) {
        if(level._id_1158[1] == "dorm")
          var_0 = 1;
      }

      if(isDefined(level._id_1158[0])) {
        if((level._id_1158[0] == "dorm" || var_0) && scripts\engine\utility::flag("power_off"))
          scripts\engine\utility::flag_clear("force_flashlights_off");
        else {
          wait 4;
          scripts\engine\utility::flag_set("force_flashlights_off");
        }
      }
    }

    wait 0.1;
  }
}

_id_9714() {
  var_0 = getscriptablearray("scriptable_onoff", "script_noteworthy");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\rogue\rogue_util::_id_EF2A);
  var_1 = getscriptablearray("hangar_scriptable_onoff", "script_noteworthy");
  scripts\engine\utility::array_thread(var_1, scripts\sp\maps\rogue\rogue_util::_id_EF2A);
  level._id_6C41 = getscriptablearray("finale_fuel_tank", "targetname");
}

_id_1AE4() {
  thread scripts\sp\maps\rogue\hangar::_id_9614();
  var_0 = getEnt("hall_entrance_door", "targetname");
  var_1 = getEnt("hall_exit_door", "targetname");
  thread _id_0B1F::_id_1AB7(1, var_0, var_1);
  level._id_5061 = getEnt("defend_exit_door", "targetname");
  level._id_5061._id_12F9B = getEnt("defend_exit_door_button", "targetname") scripts\engine\utility::spawn_tag_origin();
  level._id_5061 scripts\sp\utility::_id_23B7("airlock_door");
  thread _id_0B1F::_id_1AB7(1, level._id_5061);
}

_id_E668() {
  precacherumble("steady_rumble");
  precachemodel("vm_hero_protagonist_helmet");
  precachemodel("tag_laser");
  scripts\sp\maps\rogue\infil::_id_F0D1();
  scripts\sp\maps\rogue\hangar::_id_F0D1();
  scripts\sp\maps\rogue\surface::_id_F0D1();
  scripts\sp\maps\rogue\dormitory::_id_5A87();
  scripts\sp\maps\rogue\dormitory::_id_5A6A();
  scripts\sp\maps\rogue\dormitory::_id_5A83();
  scripts\sp\maps\rogue\dormitory::_id_4675();
  scripts\sp\maps\rogue\depot::_id_F0D1();
  scripts\sp\maps\rogue\shipping::_id_F0D1();
  scripts\sp\maps\rogue\control_room::_id_F0D1();
  scripts\sp\maps\rogue\civilians::_id_F0D1();
  scripts\sp\maps\rogue\finale::_id_F0D1();
}

_id_E64E() {
  scripts\sp\maps\rogue\infil::_id_F0CB();
  scripts\sp\maps\rogue\hangar::_id_F0CB();
  scripts\sp\maps\rogue\surface::_id_F0CB();
  scripts\sp\maps\rogue\dormitory::_id_5A86();
  scripts\sp\maps\rogue\dormitory::_id_5A69();
  scripts\sp\maps\rogue\dormitory::_id_5A76();
  scripts\sp\maps\rogue\dormitory::_id_4671();
  scripts\sp\maps\rogue\depot::_id_F0CB();
  scripts\sp\maps\rogue\shipping::_id_F0CB();
  scripts\sp\maps\rogue\control_room::_id_F0CB();
  scripts\sp\maps\rogue\civilians::_id_F0CB();
  scripts\sp\maps\rogue\finale::_id_F0CB();
  scripts\engine\utility::flag_init("sun_vision_blend");
  scripts\engine\utility::flag_init("power_on");
  scripts\engine\utility::flag_init("power_off");
  scripts\engine\utility::flag_init("force_flashlights_on");
  scripts\engine\utility::flag_init("force_flashlights_off");
  scripts\engine\utility::flag_init("flashlight_desired");
  scripts\engine\utility::flag_init("reached_creep");
  scripts\engine\utility::flag_init("sun_burn");
  scripts\engine\utility::flag_init("sun_off");
  scripts\engine\utility::flag_init("night_kill");
  scripts\engine\utility::flag_init("scbt_ignore_combat");
  scripts\engine\utility::flag_init("player_is_outside");
  scripts\engine\utility::flag_init("fake_burn_player");
  scripts\engine\utility::flag_init("player_is_inside");
  scripts\engine\utility::flag_init("sun_safe_zone");
  scripts\engine\utility::flag_init("pa_active");
  scripts\engine\utility::flag_init("disable_sun_logic");
  scripts\engine\utility::flag_init("interior_quakes");
  scripts\engine\utility::flag_init("stop_shakes_and_quakes");
  scripts\engine\utility::flag_init("player_in_scene");
  scripts\engine\utility::flag_init("dorm_run_over");
  scripts\engine\utility::flag_init("in_creep_hallway");
  scripts\engine\utility::flag_init("second_half_fx_paused");
  scripts\engine\utility::flag_init("finale_fx_paused");
  scripts\engine\utility::flag_init("temp_pause_flash");
  scripts\engine\utility::flag_init("disable_alt_vision_calls");
}

_id_E673() {
  scripts\sp\maps\rogue\infil::_id_F0D2();
  scripts\sp\maps\rogue\hangar::_id_F0D2();
  scripts\sp\maps\rogue\surface::_id_F0D2();
  scripts\sp\maps\rogue\dormitory::_id_5A88();
  scripts\sp\maps\rogue\dormitory::_id_5A6C();
  scripts\sp\maps\rogue\dormitory::_id_5A8D();
  scripts\sp\maps\rogue\dormitory::_id_4678();
  scripts\sp\maps\rogue\depot::_id_F0D2();
  scripts\sp\maps\rogue\shipping::_id_F0D2();
  scripts\sp\maps\rogue\control_room::_id_F0D2();
  scripts\sp\maps\rogue\civilians::_id_F0D2();
  scripts\sp\maps\rogue\finale::_id_F0D2();
  scripts\sp\pip_util::_id_CBAA();
}

_id_10C88() {
  _id_A4D0();
  level._id_A4EE = "infil_land";
  scripts\sp\maps\rogue\infil::_id_9468();
  scripts\engine\utility::exploder("ra_01");
}

_id_9466() {
  scripts\sp\maps\rogue\infil::_id_9467();
}

_id_10C87() {
  _id_A4D0();
  level._id_A4EE = "infil_land";
  scripts\sp\maps\rogue\infil::_id_9469();
  scripts\engine\utility::exploder("ra_01");
}

_id_9464() {
  scripts\engine\utility::delaythread(2, scripts\engine\utility::flag_set, "player_in_scene");
  thread _id_E65C();
  scripts\sp\maps\rogue\infil::_id_9465();
}

_id_10C71() {
  _id_A4D0();
  level._id_A4EE = "hangar";
  scripts\engine\utility::flag_clear("flashlight_desired");
  thread scripts\sp\maps\rogue\rogue_util::_id_54FF();
  scripts\sp\maps\rogue\hangar::_id_8AC7();
  thread scripts\sp\maps\rogue\rogue_util::_id_E643();
  scripts\engine\utility::exploder("ra_01");
  thread _id_E65C();
  scripts\sp\maps\rogue\rogue_util::_id_119AF(1);
}

_id_8A0D() {
  setsaveddvar("sm_spotDistCull", 2000);
  scripts\sp\maps\rogue\hangar::_id_8AA0();
}

_id_10D3F() {
  _id_A4D0();
  level._id_A4EE = "surface";
  scripts\engine\utility::flag_clear("flashlight_desired");
  thread scripts\sp\maps\rogue\rogue_util::_id_54FF();
  scripts\engine\utility::flag_set("sun_vision_blend");
  scripts\sp\maps\rogue\surface::_id_112DB();
  thread scripts\sp\maps\rogue\rogue_util::_id_E643("surface");
  scripts\engine\utility::exploder("ra_01");
  thread _id_E65C();
  scripts\engine\utility::flag_set("outdoor_surface_physics_on");
  scripts\sp\maps\rogue\rogue_util::_id_119AF(1);
}

_id_112D4() {
  setsaveddvar("sm_spotDistCull", 2000);
  scripts\sp\maps\rogue\surface::_id_112DA();
}

_id_10C1D() {
  _id_A4D0();
  thread scripts\sp\maps\rogue\rogue_util::_id_111E7(16, 90, 15, 10, 145);
  level._id_A4EE = "dormitory";
  scripts\engine\utility::flag_clear("flashlight_desired");
  thread scripts\sp\maps\rogue\rogue_util::_id_54FF();
  scripts\engine\utility::flag_set("sun_vision_blend");
  scripts\sp\maps\rogue\dormitory::_id_5A9E();
  thread scripts\sp\maps\rogue\rogue_util::_id_E643("surface");
  scripts\engine\utility::exploder("ra_01");
  thread _id_E65C();
  scripts\engine\utility::flag_set("outdoor_surface_physics_on");
  scripts\sp\maps\rogue\rogue_util::_id_119AF(1);
}

_id_5A9B() {
  setsaveddvar("sm_spotDistCull", 2000);
  scripts\sp\maps\rogue\dormitory::_id_5A9C();
}

_id_10C1C() {
  _id_A4D0();
  level._id_A4EE = "dormitory_airlock";
  scripts\engine\utility::flag_clear("flashlight_desired");
  scripts\engine\utility::flag_clear("sun_vision_blend");
  thread scripts\sp\maps\rogue\rogue_util::_id_54FF();
  scripts\sp\maps\rogue\dormitory::_id_5A97();
  thread scripts\sp\maps\rogue\rogue_util::_id_E643("dorms");
  scripts\sp\utility::_id_10FEC("ra_01");
  thread _id_E65B(1);
  scripts\sp\maps\rogue\rogue_util::_id_119AF(1);
  scripts\engine\utility::flag_set("disable_alt_vision_calls");
}

_id_5A93() {
  setsaveddvar("sm_spotDistCull", 800);
  scripts\sp\maps\rogue\dormitory::_id_5A96();
  scripts\sp\utility::_id_10FEC("ra_01");
}

_id_10C1B() {
  _id_A4D0();
  scripts\engine\utility::delaythread(5, _id_0E4B::_id_8DEA);
  thread _id_0B1F::_id_1AD8("dormitory_entrance_airlock", 1);
  scripts\engine\utility::flag_clear("flashlight_desired");
  scripts\engine\utility::flag_clear("sun_vision_blend");
  thread scripts\sp\maps\rogue\rogue_util::_id_54FF();
  level._id_A4EE = "dormitory_explore";
  scripts\sp\maps\rogue\dormitory::_id_5AA0();
  thread scripts\sp\maps\rogue\rogue_util::_id_E643("dorms");
  scripts\sp\utility::_id_10FEC("ra_01");
  scripts\engine\utility::flag_set("flag_lgt_dormitory_start");
  thread _id_E65B(1);
  scripts\sp\maps\rogue\rogue_util::_id_119AF(1);
  scripts\engine\utility::flag_set("disable_alt_vision_calls");
}

_id_5A92() {
  setsaveddvar("sm_spotDistCull", 800);
  scripts\sp\maps\rogue\dormitory::_id_5A9A();
}

_id_10C04() {
  _id_A4D0();
  scripts\engine\utility::delaythread(5, _id_0E4B::_id_8DEA);
  level._id_A4EE = "corpse_airlock";
  scripts\sp\maps\rogue\dormitory::_id_4677();
  thread scripts\sp\maps\rogue\rogue_util::_id_E643("creep_hallway");
  scripts\sp\utility::_id_10FEC("ra_01");
  thread _id_E65B(1);
  scripts\sp\maps\rogue\rogue_util::_id_119AF(1);
  scripts\engine\utility::flag_set("disable_alt_vision_calls");
}

_id_466D() {
  scripts\engine\utility::flag_clear("flashlight_desired");
  thread scripts\sp\maps\rogue\rogue_util::_id_54FF();
  setsaveddvar("sm_spotDistCull", 800);
  scripts\sp\maps\rogue\dormitory::_id_4674();
}

_id_10C07() {
  _id_A4D0();
  level._id_A4EE = "creep_hallway";
  scripts\sp\maps\rogue\dormitory::_id_4A56();
  thread scripts\sp\maps\rogue\rogue_util::_id_E643("shipping_hall");
  scripts\sp\utility::_id_10FEC("ra_01");
  thread _id_E65B(1);
  scripts\sp\maps\rogue\rogue_util::_id_119AF(1);
  scripts\engine\utility::flag_set("disable_alt_vision_calls");
}

_id_4A54() {
  scripts\engine\utility::flag_clear("flashlight_desired");
  thread scripts\sp\maps\rogue\rogue_util::_id_54FF();
  setsaveddvar("sm_spotDistCull", 800);
  scripts\sp\maps\rogue\dormitory::_id_4A55();
}

_id_10C06() {
  _id_A4D0();
  scripts\engine\utility::delaythread(5, _id_0E4B::_id_8DEA);
  scripts\engine\utility::flag_clear("flashlight_desired");
  thread scripts\sp\maps\rogue\rogue_util::_id_54FF();
  scripts\engine\utility::flag_set("power_off");
  level._id_A4EE = "creep_hallway";
  scripts\sp\maps\rogue\dormitory::_id_4A46();
  thread scripts\sp\maps\rogue\rogue_util::_id_E643("shipping_hall");
  scripts\sp\utility::_id_10FEC("ra_01");
  thread _id_E65B(1);
  scripts\sp\maps\rogue\rogue_util::_id_119AF(1);
}

_id_4A44() {
  setsaveddvar("sm_spotDistCull", 800);
  scripts\sp\maps\rogue\dormitory::_id_4A45();
}

_id_10D19() {
  _id_A4D0();
  scripts\engine\utility::delaythread(5, _id_0E4B::_id_8DEA);
  level._id_A4EE = "shipping";
  scripts\sp\maps\rogue\rogue_util::_id_111EA((-44, -46, 0));
  scripts\engine\utility::flag_clear("flashlight_desired");
  thread scripts\sp\maps\rogue\rogue_util::_id_54FF();
  scripts\sp\maps\rogue\shipping::_id_FE2A();
  thread scripts\sp\maps\rogue\rogue_util::_id_E643("shipping_hall");
  scripts\engine\utility::exploder("ra_02");
  scripts\sp\utility::_id_10FEC("ra_01");
  thread _id_E65E(1);
}

_id_FE16() {
  setsaveddvar("sm_spotDistCull", 800);
  scripts\engine\utility::exploder("ra_02");
  scripts\sp\maps\rogue\shipping::_id_FE28();
}

_id_10D1A() {
  _id_A4D0();
  scripts\engine\utility::delaythread(5, _id_0E4B::_id_8DEA);
  level._id_A4EE = "shipping_defend";
  scripts\engine\utility::flag_clear("flashlight_desired");
  thread scripts\sp\maps\rogue\rogue_util::_id_54FF();
  scripts\sp\maps\rogue\shipping::_id_FE1B();
  thread scripts\sp\maps\rogue\rogue_util::_id_E643("shipping_defend");
  scripts\engine\utility::flag_set("sun_vision_blend");
  scripts\engine\utility::flag_set("combat_section_active");
  scripts\sp\utility::_id_10FEC("ra_01");
  scripts\engine\utility::exploder("ra_02");
  thread _id_E65E(1);
}

_id_FE19() {
  setsaveddvar("sm_spotDistCull", 800);
  thread scripts\sp\maps\rogue\shipping::_id_75D0();
  scripts\sp\maps\rogue\shipping::_id_FE1A();
}

_id_10D1B() {
  _id_A4D0();
  scripts\engine\utility::delaythread(5, _id_0E4B::_id_8DEA);
  level._id_A4EE = "shipping_defend_b";
  scripts\engine\utility::flag_clear("flashlight_desired");
  thread scripts\sp\maps\rogue\rogue_util::_id_54FF();
  scripts\sp\maps\rogue\shipping::_id_FE1E();
  thread scripts\sp\maps\rogue\rogue_util::_id_E643("shipping_defend");
  scripts\engine\utility::flag_set("sun_vision_blend");
  scripts\engine\utility::flag_set("combat_section_active");
  scripts\sp\utility::_id_10FEC("ra_01");
  scripts\engine\utility::exploder("ra_02");
  thread _id_E65E(1);
  thread scripts\sp\maps\rogue\shipping::_id_6DC8();
}

_id_FE1C() {
  setsaveddvar("sm_spotDistCull", 800);
  thread scripts\sp\maps\rogue\shipping::_id_75D1();
  scripts\sp\maps\rogue\shipping::_id_FE1D();
}

_id_10D1C() {
  _id_A4D0();
  scripts\engine\utility::delaythread(5, _id_0E4B::_id_8DEA);
  level._id_A4EE = "shipping_defend_b";
  scripts\engine\utility::flag_clear("flashlight_desired");
  thread scripts\sp\maps\rogue\rogue_util::_id_54FF();
  scripts\sp\maps\rogue\shipping::_id_FE21();
  thread scripts\sp\maps\rogue\rogue_util::_id_E643("shipping_defend");
  scripts\engine\utility::flag_set("sun_vision_blend");
  scripts\engine\utility::flag_set("combat_section_active");
  scripts\sp\utility::_id_10FEC("ra_01");
  scripts\engine\utility::exploder("ra_04");
  thread _id_E65E(1);
  thread scripts\sp\maps\rogue\shipping::_id_6DC8();
}

_id_FE1F() {
  setsaveddvar("sm_spotDistCull", 800);
  scripts\sp\maps\rogue\shipping::_id_FE20();
  scripts\engine\utility::exploder("ra_04");
}

_id_10C02() {
  _id_A4D0();
  scripts\engine\utility::delaythread(3, _id_0E4B::_id_8DEA);
  level._id_A4EE = "control";
  scripts\engine\utility::flag_clear("flashlight_desired");
  thread scripts\sp\maps\rogue\rogue_util::_id_54FF();
  scripts\sp\maps\rogue\control_room::_id_45BC();
  thread scripts\sp\maps\rogue\rogue_util::_id_E643("control_room");
  scripts\sp\utility::_id_10FEC("ra_01");
  scripts\sp\utility::_id_10FEC("ra_02");
  scripts\engine\utility::exploder("ra_08");
  thread _id_E65E(1);
  scripts\sp\maps\rogue\rogue_util::_id_119AF(1);
  scripts\engine\utility::flag_set("disable_alt_vision_calls");
}

_id_45B1() {
  setsaveddvar("sm_spotDistCull", 800);
  thread _id_0B1F::_id_1AAA("control_room_airlock");
  scripts\sp\utility::_id_10FEC("ra_02");
  scripts\engine\utility::exploder("ra_08");
  thread scripts\sp\maps\rogue\control_room::_id_75D3();
  scripts\sp\maps\rogue\control_room::_id_45B6();
}

_id_10C13() {
  _id_A4D0();
  scripts\engine\utility::delaythread(3, _id_0E4B::_id_8DEA);
  level._id_A4EE = "depot";
  scripts\engine\utility::flag_clear("flashlight_desired");
  thread scripts\sp\maps\rogue\rogue_util::_id_54FF();
  scripts\sp\maps\rogue\depot::_id_5251();
  thread scripts\sp\maps\rogue\rogue_util::_id_E643("depot");
  scripts\sp\utility::_id_10FEC("ra_01");
  scripts\sp\utility::_id_10FEC("ra_02");
  scripts\sp\utility::_id_10FEC("ra_08");
  scripts\sp\utility::_id_10FEC("ra_04");
  thread _id_E65E(1);
  scripts\engine\utility::flag_set("disable_alt_vision_calls");
}

_id_5238() {
  setsaveddvar("sm_spotDistCull", 800);
  scripts\sp\utility::_id_10FEC("ra_08");
  scripts\sp\utility::_id_10FEC("ra_04");
  scripts\sp\maps\rogue\depot::_id_5244();
}

_id_10C14() {
  _id_A4D0();
  scripts\engine\utility::delaythread(3, _id_0E4B::_id_8DEA);
  level._id_A4EE = "depot_pit";
  thread scripts\sp\maps\rogue\rogue_util::_id_111E7(undefined, 26, 14, 195);
  scripts\engine\utility::flag_clear("flashlight_desired");
  thread scripts\sp\maps\rogue\rogue_util::_id_54FF();
  scripts\sp\maps\rogue\depot::_id_5249();
  thread scripts\sp\maps\rogue\rogue_util::_id_E643("depot");
  scripts\sp\utility::_id_10FEC("ra_01");
  scripts\sp\utility::_id_10FEC("ra_02");
  scripts\sp\utility::_id_10FEC("ra_08");
  scripts\sp\utility::_id_10FEC("ra_04");
  thread _id_E65E(1);
  scripts\sp\maps\rogue\rogue_util::_id_119AF(1);
  scripts\engine\utility::flag_set("disable_alt_vision_calls");
}

_id_5245() {
  setsaveddvar("sm_spotDistCull", 800);
  scripts\sp\utility::_id_10FEC("ra_08");
  scripts\sp\utility::_id_10FEC("ra_04");
  scripts\sp\maps\rogue\depot::_id_5248();
}

_id_10BEE() {
  _id_A4D0();
  scripts\engine\utility::delaythread(3, _id_0E4B::_id_8DEA);
  level._id_A4EE = "civilians";
  scripts\engine\utility::flag_clear("flashlight_desired");
  thread scripts\sp\maps\rogue\rogue_util::_id_54FF();
  scripts\sp\maps\rogue\civilians::_id_3FE0();
  thread scripts\sp\maps\rogue\rogue_util::_id_E643("civilians");
  scripts\sp\utility::_id_10FEC("ra_01");
  scripts\sp\utility::_id_10FEC("ra_02");
  scripts\sp\utility::_id_10FEC("ra_08");
  scripts\sp\utility::_id_10FEC("ra_04");
  scripts\sp\maps\rogue\rogue_util::_id_119AF(1);
  scripts\engine\utility::flag_set("disable_alt_vision_calls");
}

_id_3FDD() {
  setsaveddvar("sm_spotDistCull", 800);
  scripts\sp\utility::_id_10FEC("ra_08");
  scripts\sp\utility::_id_10FEC("ra_04");
  scripts\sp\maps\rogue\civilians::_id_3FDE();
}

_id_10C4B() {
  _id_A4D0();
  scripts\engine\utility::delaythread(3, _id_0E4B::_id_8DEA);
  level._id_A4EE = "finale_drag";
  scripts\engine\utility::flag_clear("flashlight_desired");
  thread scripts\sp\maps\rogue\rogue_util::_id_54FF();
  scripts\sp\maps\rogue\finale::_id_6C54();
  scripts\engine\utility::flag_set("sun_vision_blend");
  scripts\sp\utility::_id_10FEC("ra_01");
  scripts\sp\utility::_id_10FEC("ra_02");
  scripts\sp\utility::_id_10FEC("ra_08");
  scripts\sp\utility::_id_10FEC("ra_04");
  scripts\engine\utility::exploder("ra_10");
  thread _id_E65D(1);
  scripts\sp\maps\rogue\rogue_util::_id_119AF(1);
  scripts\engine\utility::flag_set("disable_alt_vision_calls");
}

_id_6C2E() {
  setsaveddvar("sm_spotDistCull", 800);
  scripts\engine\utility::exploder("ra_10");
  scripts\sp\utility::_id_10FEC("ra_08");
  scripts\sp\utility::_id_10FEC("ra_04");
  scripts\sp\maps\rogue\finale::_id_6C45();
}

_id_6C31() {
  level.player._id_5942 = 1;
}

_id_10C4C() {
  _id_A4D0();
  scripts\engine\utility::delaythread(3, _id_0E4B::_id_8DEA);
  level._id_A4EE = "finale";
  scripts\engine\utility::flag_clear("flashlight_desired");
  thread scripts\sp\maps\rogue\rogue_util::_id_54FF();
  scripts\sp\maps\rogue\finale::_id_6C39();
  scripts\engine\utility::flag_set("sun_vision_blend");
  scripts\sp\utility::_id_10FEC("ra_01");
  scripts\sp\utility::_id_10FEC("ra_02");
  scripts\sp\utility::_id_10FEC("ra_08");
  scripts\sp\utility::_id_10FEC("ra_04");
  thread _id_E65D(1);
  scripts\sp\maps\rogue\rogue_util::_id_119AF(1);
  scripts\engine\utility::flag_set("disable_alt_vision_calls");
}

_id_6C35() {
  setsaveddvar("sm_spotDistCull", 800);
  scripts\sp\maps\rogue\finale::_id_6C37();
}

_id_10D42() {
  _id_A4D0();
  scripts\sp\maps\rogue\test::_id_11739();
}

_id_11718() {
  scripts\sp\maps\rogue\test::_id_1172F();
}

_id_A4D0() {}

_id_ABE0() {
  scripts\sp\utility::_id_C264("OBJECTIVE_LOCATE");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_LOCATE"), &"ROGUE_OBJECTIVE_LOCATE");
  scripts\sp\utility::_id_C264("OBJECTIVE_SURVIVORS");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_SURVIVORS"), &"ROGUE_OBJECTIVE_SURVIVORS");
  scripts\sp\utility::_id_C264("OBJECTIVE_COMMAND");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_COMMAND"), &"ROGUE_OBJECTIVE_COMMAND");
  scripts\sp\utility::_id_C264("OBJECTIVE_MINES");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_MINES"), &"ROGUE_OBJECTIVE_MINES");
  scripts\sp\utility::_id_C264("OBJECTIVE_CIVILIANS");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_CIVILIANS"), &"ROGUE_OBJECTIVE_CIVILIANS");
  objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_LOCATE"), "current");
  scripts\engine\utility::flag_wait("player_at_array2_scene");
  wait 0.1;
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_LOCATE"));
  objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_SURVIVORS"), "current");
  scripts\engine\utility::flag_wait("command_objective");
  wait 0.1;
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_SURVIVORS"));
  objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_COMMAND"), "current");
  scripts\engine\utility::flag_wait("objective_control");
  wait 0.1;
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_COMMAND"));
  objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_MINES"), "current");
  scripts\engine\utility::flag_wait("depot_finished");
  wait 0.1;
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_MINES"));
  objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_CIVILIANS"), "current");
}

_id_E65C() {
  scripts\engine\utility::flag_set("second_half_fx_paused");
  scripts\engine\utility::flag_set("finale_fx_paused");
  scripts\engine\utility::delaythread(1, scripts\sp\utility::_id_7616, "rogue_fx_vol_1");
  scripts\engine\utility::delaythread(1, scripts\sp\utility::_id_7616, "rogue_fx_vol_finale");
}

_id_E65B(var_0) {
  if(isDefined(var_0)) {
    scripts\engine\utility::delaythread(1, scripts\sp\utility::_id_7616, "rogue_fx_vol_1");
    scripts\engine\utility::flag_set("second_half_fx_paused");
  }

  scripts\sp\utility::_id_7616("rogue_fx_vol_0");
}

_id_E65E(var_0) {
  if(isDefined(var_0))
    scripts\engine\utility::delaythread(1, scripts\sp\utility::_id_7616, "rogue_fx_vol_0");

  scripts\engine\utility::delaythread(1, scripts\sp\utility::_id_7616, "rogue_fx_vol_dorm");

  if(scripts\engine\utility::flag("second_half_fx_paused"))
    scripts\sp\utility::_id_7619("rogue_fx_vol_1");
}

_id_E65D(var_0) {
  if(isDefined(var_0)) {
    scripts\engine\utility::delaythread(1, scripts\sp\utility::_id_7616, "rogue_fx_vol_0");
    scripts\engine\utility::delaythread(1, scripts\sp\utility::_id_7616, "rogue_fx_vol_dorm");
  }

  scripts\engine\utility::delaythread(1, scripts\sp\utility::_id_7616, "rogue_fx_vol_1");

  if(scripts\engine\utility::flag("finale_fx_paused"))
    scripts\sp\utility::_id_7619("rogue_fx_vol_finale");
}