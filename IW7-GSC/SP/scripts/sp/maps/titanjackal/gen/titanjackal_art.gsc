/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\titanjackal\gen\titanjackal_art.gsc
***************************************************************/

main() {
  level.tweakfile = 1;
  level.player = getEntArray("player", "classname")[0];
  thread _id_979D();
  thread _id_1343D();
  var_0 = 0.0;
  var_1 = 0.0;
  var_2 = 3.9;
  var_3 = 140000;
  var_4 = 150000;
  var_5 = 1.5;
  var_6 = 0.1;
  setsaveddvar("r_usePrebuiltSunShadow", 3);
  setsaveddvar("r_sdfShadowPenumbra", 0.45);
  thread _id_8EAD();
}

_id_8EAD() {
  var_0 = getEntArray("turbine_destruction_chunks", "targetname");
  var_1 = 0;

  foreach(var_3 in var_0) {
    var_3._id_10CCA = var_3.origin;
    var_3._id_10BA1 = var_3.angles;
    var_3 hide();
  }
}

_id_979D() {
  scripts\engine\utility::flag_init("jackal_arena_begin_vision_fx");
  scripts\engine\utility::flag_init("jackal_first_building_vision_fx");
  scripts\engine\utility::flag_init("landed_turbine_vision_fx");
  scripts\engine\utility::flag_init("jackal_second_building_exit_vision_fx");
  scripts\engine\utility::flag_init("tower_destruction_vision_fx");
  scripts\engine\utility::flag_init("hot_landing_vision_fx");
  scripts\engine\utility::flag_init("turn_off_building_01_curtain_lights");
  scripts\engine\utility::flag_init("start_hot_landing_robot_romance_dof");
  scripts\engine\utility::flag_init("end_hot_landing_robot_romance_dof");
}

_id_1343D() {
  thread _id_A087();
  thread _id_A1C7();
  thread _id_A7D3();
  thread _id_A30F();
  thread _id_11A5B();
  thread _id_90BD();
  thread _id_12949();
}

_id_4FE8(var_0, var_1, var_2) {
  var_3 = 1.0;
  var_4 = 10.0;
  var_5 = 0.0;
  var_6 = 35500.0;
  var_7 = 149500.0;
  var_8 = 1.08;
  var_9 = 2.0;

  if(isDefined(var_0))
    var_8 = var_0;

  if(isDefined(var_1))
    var_6 = var_1;

  if(isDefined(var_2))
    var_7 = var_2;

  thread _id_0B0A::_id_583F(var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

_id_A087() {
  scripts\engine\utility::flag_wait("jackal_arena_begin_vision_fx");
  setsaveddvar("sm_sunsamplesizenear", 32);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 1);
}

_id_A1C7() {
  scripts\engine\utility::flag_wait("jackal_first_building_vision_fx");
  setsaveddvar("sm_sunsamplesizenear", 32);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 1);
}

_id_A7D3() {
  scripts\engine\utility::flag_wait("landed_turbine_vision_fx");
  setsaveddvar("sm_sunsamplesizenear", 2.06);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 3);
}

_id_A30F() {
  scripts\engine\utility::flag_wait("jackal_second_building_exit_vision_fx");
  setsaveddvar("sm_sunEnable", 0);
  setsaveddvar("sm_sunsamplesizenear", 32);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 1);
  var_0 = getEntArray("refinery_pipe_script_collision", "targetname");
  scripts\engine\utility::array_thread(var_0, ::_id_51CF);
}

_id_51CF() {
  if(isDefined(self))
    self delete();
}

_id_11A5B() {
  scripts\engine\utility::flag_wait("tower_destruction_vision_fx");
  wait 30;
  setsaveddvar("sm_sunEnable", 1);
  setsaveddvar("sm_sunsamplesizenear", 4.5);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 2);
  var_0 = getEntArray("refinery_pipe_script_collision", "targetname");
  scripts\engine\utility::array_thread(var_0, ::_id_51CF);
}

_id_90BD() {
  scripts\engine\utility::flag_wait("hot_landing_vision_fx");
  setsaveddvar("sm_sunsamplesizenear", 4.5);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 2);
  var_0 = getEnt("periph_titan_jackal_arena_01", "targetname");
  var_0 hide();
  thread _id_10C80();
  var_1 = getEntArray("refinery_pipe_script_collision", "targetname");
  scripts\engine\utility::array_thread(var_1, ::_id_51CF);
}

_id_10C80() {
  scripts\engine\utility::flag_wait("start_hot_landing_robot_romance_dof");
  setsaveddvar("r_dof_hq", 1);
  wait 46;
  thread _id_0B0A::_id_583F(0, 0, 6, 0, 254.42, 4.6125, 3);
  wait 24;
  thread _id_E5A6();
  wait 42;
  scripts\engine\utility::flag_set("end_hot_landing_robot_romance_dof");
  setsaveddvar("r_dof_hq", 0);
}

_id_E5A6() {
  var_0 = 3.0;
  var_1 = 100.0;
  var_2 = 1.0;
  var_3 = 1;
  var_4 = 7000;
  var_5 = 10;
  var_6 = 2.0;

  while(!scripts\engine\utility::flag("end_hot_landing_robot_romance_dof")) {
    wait(randomfloatrange(1.0, 3.0));
    thread _id_0B0A::_id_583F(var_0, var_1, randomfloatrange(3.0, 10.0), var_3, var_4, var_5, var_6);
    wait(randomfloatrange(1.0, 4.0));

    if(randomfloatrange(0, 1) > 0.5) {
      level.player playSound("scn_titan_blackout");
      visionsetnaked("titan_hotlanding_blackout", 0.5);
      wait 0.5;
    }

    visionsetnaked("titan_hotlanding_02", 0.5);
    thread _id_0B0A::_id_583D(randomfloatrange(1.0, 2.0));
  }

  thread _id_0B0A::_id_583F(var_0, var_1, 10, var_3, var_4, var_5, 3.0);
  level.player notify("dof_fun_clear");
  visionsetnaked("titan_hotlanding_blackout", 3.0);
}

_id_12949() {
  scripts\engine\utility::flag_wait("turn_off_building_01_curtain_lights");

  for(var_0 = 1; var_0 < 4; var_0++) {
    var_1 = "building_01_curtain_light_" + scripts\sp\utility::string(var_0);
    var_2 = getEnt(var_1, "targetname");

    if(isDefined(var_2)) {
      var_2 setlightintensity(0.1);
      var_2 _meth_8300(13);
      var_3 = var_2 _meth_8134();
      var_4 = var_2 _meth_8134();
    }
  }
}

handle_near_tower_sunshadow() {
  var_0 = getEnt("towerSunShadowRefPoint", "targetname");
  var_1 = getEnt("towerSunShadowDirRefPoint", "targetname");
  var_2 = 46000.0;

  for(;;) {
    if(isDefined(level._id_A056)) {
      var_3 = distance(var_0.origin, level._id_A056._id_12F96[0].origin);
      var_3 = var_3 / var_2;
      var_4 = clamp(var_3, 0.0, 1.0);
      var_4 = 1.0 - var_4;
      var_5 = vectorNormalize(var_1.origin - level.player.origin);
      var_6 = anglesToForward(level.player.angles);
      var_7 = vectordot(var_5, var_6);
      var_8 = clamp(var_7, 0, 1);
      var_9 = var_4 * var_8;
      var_10 = 14 * var_9 + 32 * (1 - var_9);
      setsaveddvar("sm_sunsamplesizenear", var_10);
    }

    wait 0.35;
  }

  thread handle_near_tower_sunshadow();
}