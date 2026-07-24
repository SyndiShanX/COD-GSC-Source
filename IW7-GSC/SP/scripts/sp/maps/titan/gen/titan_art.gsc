/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\titan\gen\titan_art.gsc
***************************************************/

main() {
  level.tweakfile = 1;
  level._id_4BCE = "titan";
  level.player = getEntArray("player", "classname")[0];
  level.player scripts\sp\utility::_id_65E0("facing_wind");
  _id_96F3();
  setsaveddvar("r_umbraMinObjectContribution", 8);
  thread _id_D6D0();
  setsaveddvar("r_usePrebuiltSunShadow", 3);
  setsaveddvar("r_sdfShadowPenumbra", 0.45);
  var_0 = getEnt("supercell_cloud_small_front", "targetname");
  var_1 = getEnt("supercell_cloud_medium_front", "targetname");
  var_0 hide();
  var_1 hide();
}

_id_4FE8(var_0, var_1, var_2) {
  var_3 = 1.0;
  var_4 = 10.0;
  var_5 = 3.9;
  var_6 = 3340.0;
  var_7 = 52550.0;
  var_8 = 1.08;
  var_9 = 1.0;

  if(isDefined(var_0))
    var_8 = var_0;

  if(isDefined(var_1))
    var_6 = var_1;

  if(isDefined(var_2))
    var_7 = var_2;

  thread _id_0B0A::_id_583F(var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

_id_99F6(var_0, var_1, var_2, var_3, var_4, var_5) {
  setsaveddvar("r_dof_hq", 1);
  var_6 = 0.0;
  var_7 = 0.0;
  var_8 = 0.0;
  var_9 = 5;
  var_10 = 90;
  var_11 = 2.0;

  if(isDefined(var_3))
    var_9 = var_3;

  if(isDefined(var_4))
    var_10 = var_4;

  if(isDefined(var_5))
    var_11 = var_5;

  var_12 = 2.0;
  wait(var_0);
  thread _id_0B0A::_id_583F(var_6, var_7, var_8, var_9, var_10, var_11, var_12);

  if(isDefined(var_1))
    wait(var_1);
  else if(isDefined(var_2))
    scripts\engine\utility::flag_wait(var_2);

  setsaveddvar("r_dof_hq", 0);
  thread _id_0B0A::_id_583D(1.0);
}

_id_96F3() {
  scripts\engine\utility::flag_init("titan_apc_targetting_off");
  scripts\engine\utility::flag_set("titan_apc_targetting_off");
  scripts\engine\utility::flag_init("dynamic_dof_enabled");
  scripts\engine\utility::flag_init("enable_dynamic_sunshadow_first_steps");
  scripts\engine\utility::flag_init("enable_dynamic_shadow_canyon_to_pod_a");
  scripts\engine\utility::flag_init("enable_dynamic_sunshadow_jump_platforms");
  scripts\engine\utility::flag_init("enable_sun_shadow");
  scripts\engine\utility::flag_init("dynamicSunSampleRefinery");
  scripts\engine\utility::flag_init("endDynamicSunSampleRefinery");
  scripts\engine\utility::flag_init("dropship_door_fill_lighting");
  scripts\engine\utility::flag_init("fly_in_grab_gun_post_fx");
  scripts\engine\utility::flag_init("fly_in_vision_fx");
  scripts\engine\utility::flag_init("first_steps_vision_fx");
  scripts\engine\utility::flag_init("titan_enable_thrusters");
  scripts\engine\utility::flag_init("enable_volumetrics_first_steps");
  scripts\engine\utility::flag_init("disable_volumetrics_first_steps");
  scripts\engine\utility::flag_init("start_canyon_to_pod_a_vision_fx");
  scripts\engine\utility::flag_init("enter_building_1_volumetrics");
  scripts\engine\utility::flag_init("exit_building_1_volumetrics");
  scripts\engine\utility::flag_init("exit_building_1_vision_fx");
  scripts\engine\utility::flag_init("stealth_street_1_vision_fx");
  scripts\engine\utility::flag_init("stealth_street_2_vision_fx");
  scripts\engine\utility::flag_init("stealth_street_2_flicker_light");
  scripts\engine\utility::flag_init("stealth_street_3_vision_fx");
  scripts\engine\utility::flag_init("through_here_vision_fx");
  scripts\engine\utility::flag_init("squeeze_through_vision_fx");
  scripts\engine\utility::flag_init("squeeze_through_flicker_light");
  scripts\engine\utility::flag_init("second_encounter_vision_fx");
  scripts\engine\utility::flag_init("second_encounter_spot_shadow_4");
  scripts\engine\utility::flag_init("second_encounter_spot_shadow_8");
  scripts\engine\utility::flag_init("beacon_vision_fx");
  scripts\engine\utility::flag_init("apc_dropoff_vision_fx");
  scripts\engine\utility::flag_init("apc_dropoff_sun_ext");
  scripts\engine\utility::flag_init("apc_dropoff_sun_int");
  scripts\engine\utility::flag_init("apc_attack_vision_fx");
  scripts\engine\utility::flag_init("refinery_turn_off_sun");
  scripts\engine\utility::flag_init("refinery_turn_on_sun");
  scripts\engine\utility::flag_init("c12fight_transition_vision_fx");
  scripts\engine\utility::flag_init("c12fight_dropoff_vision_fx");
  scripts\engine\utility::flag_init("c12fight_charge_vision_fx");
  scripts\engine\utility::flag_init("c12_crash_in_physics");
  scripts\engine\utility::flag_init("mons_pickup_vision_fx");
  scripts\engine\utility::flag_init("mons_door_vision_fx");
  scripts\engine\utility::flag_init("mons_bunker_vision_fx");
  scripts\engine\utility::flag_init("mons_overwatch_vision_fx");
  scripts\engine\utility::flag_init("supercell_methane_storm_init_main");
  scripts\engine\utility::flag_init("supercell_methane_storm_init_main_done");
  scripts\engine\utility::flag_init("supercell_methane_storm_medium_fog");
  scripts\engine\utility::flag_init("supercell_methane_storm_fx_part_1");
  scripts\engine\utility::flag_init("supercell_methane_storm_fx_part_2");
  scripts\engine\utility::flag_init("supercell_methane_storm_tower_lightning_strike");
  scripts\engine\utility::flag_init("enable_sim_lightning_around_player");
  scripts\engine\utility::flag_init("enable_sim_rain_around_player");
  scripts\engine\utility::flag_init("supercell_methane_storm_end");
  scripts\engine\utility::flag_init("supercell_methane_storm_ents_moving");
  scripts\engine\utility::flag_init("clear_vision_set_naked");
  scripts\engine\utility::flag_init("titan_pod_interior_clear_a");
  scripts\engine\utility::flag_init("titan_pod_interior_clear_a_vision");
  scripts\engine\utility::flag_init("titan_interior_clear_vision");
  scripts\engine\utility::flag_init("titan_storm_interior_vision");
  scripts\engine\utility::flag_init("titan_storm_medium_vision");
  scripts\engine\utility::flag_init("titan_storm_medium_b_vision");
  scripts\engine\utility::flag_init("titan_storm_heavy_vision");
  scripts\engine\utility::flag_init("titan_storm_heavy_dark_vision");
  scripts\engine\utility::flag_init("titan_squeeze_through_vision");
  scripts\engine\utility::flag_init("titan_through_here_vision");
  scripts\engine\utility::flag_init("titan_apc_dropoff_vision");
  scripts\engine\utility::flag_init("titan_canyon_a_vision");
  scripts\engine\utility::flag_init("titan_refinery_reveal_vision");
  scripts\engine\utility::flag_init("titan_refinery_vision");
  scripts\engine\utility::flag_init("titan_refinery_b_vision");
  scripts\engine\utility::flag_init("titan_refinery_mons_intro_vision");
  scripts\engine\utility::flag_init("titan_refinery_elevator_vision");
  scripts\engine\utility::flag_init("titan_vision");
  scripts\engine\utility::flag_init("enable_volumetrics");
  scripts\engine\utility::flag_init("disable_volumetrics");
  scripts\engine\utility::flag_init("hide_sky_background_clouds");
  scripts\engine\utility::flag_init("show_sky_background_clouds");
  scripts\engine\utility::flag_init("hm_flicker_light_start");
  scripts\engine\utility::flag_init("enable_building_1_sirens");
  scripts\engine\utility::flag_init("enable_streets_1_sirens");
  scripts\engine\utility::flag_init("titan_building_1_turn_on_lights");
  scripts\engine\utility::flag_init("c12_dropoff_attach_fence_lights");
  scripts\engine\utility::flag_init("init_player_foot_splash_trigs");
}

_id_D6D0() {
  thread _id_5DB8();
  thread _id_6FA4();
  thread _id_6DDB();
  scripts\engine\utility::flag_wait("titan_base_tr_loaded");
  thread _id_10BD8();
  thread _id_6942();
  thread _id_10F21();
  thread _id_10F23();
  thread _id_10F22();
  thread _id_10F24();
  thread _id_6241();
  thread _id_117F8();
  thread _id_10B26();
  thread _id_10B1E();
  thread _id_F0A1();
  thread _id_F09B();
  thread _id_F09C();
  thread _id_2A13();
  thread _id_2070();
  thread _id_206E();
  thread _id_206F();
  thread _id_205B();
  thread _id_DE54();
  thread _id_DE55();
  thread _id_3642();
  thread _id_3640();
  thread _id_352F();
  thread _id_363E();
  thread _id_BAE2();
  thread _id_BA76();
  thread _id_BA61();
  thread _id_BAE1();
  thread _id_8EA4();
  thread _id_100FB();
  thread _id_354A();
  thread _id_95E6();
}

_id_F4A0() {
  var_0 = getEnt("destroyed_refinery_bridge", "targetname");

  if(isDefined(var_0))
    var_0 castspotshadows(0);
}

_id_96A8() {
  var_0 = 1;

  for(;;) {
    if(!level.player issprinting() && !level.player isreloading()) {
      var_1 = level.player getcurrentweapon();
      var_2 = level.player _meth_816D();
      var_3 = scripts\engine\utility::getfx("vfx_hms_water_splash_small_01");

      if(isDefined(level.player._id_B56F)) {
        var_4 = getnumparts(level.player._id_1E9C.model);
        var_5 = getpartname(level.player._id_1E9C.model, randomintrange(0, var_4));

        if(level.player scripts\sp\utility::_id_9D27()) {
          var_6 = level.player gettagorigin("j_gun");
          playFX(var_3, var_6);
        } else {
          var_6 = level.player._id_1E9C gettagorigin(var_5);
          playFX(var_3, var_6);
        }
      }
    }

    wait(randomfloatrange(0.05, 0.1));
  }
}

_id_96DD() {
  if(scripts\engine\utility::flag("init_player_foot_splash_trigs")) {
    return;
  }
  var_0 = getEntArray("player_foot_splash_trigs", "targetname");
  scripts\engine\utility::array_thread(var_0, ::_id_D07E);
  scripts\engine\utility::flag_set("init_player_foot_splash_trigs");
}

_id_D07E() {
  level endon("building1_exit");
  var_0 = scripts\engine\utility::getfx("vfx_hms_foot_splashes_player");
  var_1 = scripts\engine\utility::getfx("vfx_hms_foot_splashes_player_idle");
  var_2 = (0, 0, 0);
  self waittill("trigger");
  var_3 = 0;
  var_4 = (0, 0, 0);

  for(;;) {
    if(level.player istouching(self)) {
      if(var_3 == 0) {
        var_5 = level.player.origin + (0, 0, 10);
        var_6 = var_5 + (0, 0, -1000);
        var_7 = bulletTrace(var_5, var_6, 0, level.player);
        var_4 = var_7["position"];
        var_3 = 1;
      } else if(var_3 < 3)
        var_3 = var_3 + 1;
      else if(var_3 >= 3)
        var_3 = 0;

      var_8 = (level.player.origin[0], level.player.origin[1], var_4[2]);

      if(distance(var_2, level.player.origin) > 10)
        playFX(var_0, var_8);

      playFX(var_1, var_8);
    }

    var_2 = level.player.origin;
    wait 0.2;
  }
}

_id_5DB8() {
  scripts\engine\utility::flag_wait("dropship_door_fill_lighting");
  var_0 = getEntArray("script_light_drop_ship", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2 _meth_8134() * 0.2;
    var_2 setlightintensity(var_3);
    var_2._id_10CCA = var_2.origin + (0, 0, 65000);
  }

  level._id_5D6C _id_0BBF::_id_F451(1);
  var_5 = getEnt("drop_ship_door_fill_a", "targetname");

  if(isDefined(var_5)) {
    var_5.origin = (0, 0, 0);
    var_5 setlightintensity(0.2);
    var_5 _meth_8300(150);
  }

  var_6 = scripts\engine\utility::spawn_tag_origin();
  var_6 linkTo(level._id_5D6C, level._id_5D6C._id_E6E8, (140, -16, 118), (0, 0, 0));

  if(isDefined(var_5))
    var_5 linkTo(var_6, "tag_origin");

  var_7 = scripts\engine\utility::spawn_tag_origin();
  var_7 linkTo(level._id_5D6C, level._id_5D6C._id_E6E8, (0, 0, 0), (0, 0, 0));

  foreach(var_2 in var_0) {
    var_2.origin = var_2._id_10CCA;
    var_2 linkTo(var_7, "tag_origin");
  }

  scripts\engine\utility::flag_wait("player_dropship_door_open");
  wait 1.0;

  if(isDefined(var_5)) {
    var_5 thread _id_ABB5(3, 2);
    var_5 thread _id_ABB4((0.792157, 0.701961, 0.482353), 2);
  }

  wait 2.0;
  wait 14;
  var_5 thread _id_ABB5(0.1, 12);
  var_5 thread _id_ABB6(100, 12);
  wait 12.0;

  foreach(var_2 in var_0)
  var_2 delete();

  var_5 delete();
}

_id_6FA4() {
  scripts\engine\utility::flag_wait("fly_in_vision_fx");
  thread _id_D906();
  thread _id_0B0A::_id_583F(0, 80, 6.0, 0.05, 90, 5, 0);
  setsaveddvar("sm_sunSampleSizeNear", 0.85);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 1);
  setsaveddvar("r_volumetrics", 1);
  setsaveddvar("r_usePrebuiltSunShadow", 3);
  var_0 = getEnt("saturn_test", "targetname");
  var_0.origin = (87432, -372992, 65000);
  var_0.angles = (-32, 295, -25);
  thread delaydoffunc(3, 0, 80, 6.0, 0.05, 70, 5, 1);
  thread delaydoffunc(5.7, 0, 30, 6.0, 0.05, 90, 5, 0.5);
  scripts\engine\utility::delaythread(8, ::_id_4FE8);
}

delaydoffunc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  wait(var_0);
  _id_0B0A::_id_583F(var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

_id_D906() {}

_id_6DDB() {
  scripts\engine\utility::flag_wait("first_steps_vision_fx");
  setsaveddvar("sm_sunSampleSizeNear", 0.6);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 3);
  setsaveddvar("r_volumetrics", 1);
  setsaveddvar("r_usePrebuiltSunShadow", 0);
  var_0 = 1;
  thread _id_4FE8();
  var_1 = getEnt("saturn_test", "targetname");
  var_1.origin = (87432, -372992, 65000);
  var_1.angles = (-32, 295, -25);
  thread _id_96DD();
  _id_1123F(100);
}

_id_6253() {
  scripts\engine\utility::flag_wait("enable_volumetrics_first_steps");
  wait 0.05;

  if(!level.console)
    waitforalltransients();

  setsaveddvar("r_volumetrics", 1);
  scripts\engine\utility::flag_clear("enable_volumetrics_first_steps");
  wait 1.0;
  thread _id_6253();
}

_id_55A0() {
  scripts\engine\utility::flag_wait("disable_volumetrics_first_steps");
  setsaveddvar("r_volumetrics", 0);
  scripts\engine\utility::flag_clear("disable_volumetrics_first_steps");
  wait 1.0;
  thread _id_55A0();
}

_id_10BD8() {
  scripts\engine\utility::flag_wait("start_canyon_to_pod_a_vision_fx");
  wait 0.05;

  if(!level.console)
    waitforalltransients();

  setsaveddvar("sm_sunSampleSizeNear", 0.3);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 3);
  setsaveddvar("sm_spotEnable", 1);
  setsaveddvar("r_volumetrics", 1);
  setsaveddvar("sm_roundRobinPrioritySpotShadows", "4");
  setsaveddvar("r_usePrebuiltSunShadow", 0);
  thread _id_0B0A::_id_583D(3.0);
  var_0 = getEnt("saturn_test", "targetname");
  var_0.origin = (87432, -372992, 65000);
  var_0.angles = (-32, 295, -25);
  _id_1123F(100);
  scripts\engine\utility::flag_set("supercell_methane_storm_fx_part_1");
  thread _id_11957();
  thread _id_96DD();
}

_id_11957() {
  var_0 = getEntArray("building_1_toggle_lights", "targetname");
  var_1 = [];
  var_2 = 0;

  foreach(var_4 in var_0) {
    var_5 = [];
    var_5[0] = var_4;
    var_5[1] = var_4 _meth_8134();
    var_1[var_2] = var_5;
    var_2++;
  }

  foreach(var_4 in var_0)
  var_4 setlightintensity(0.0);

  scripts\engine\utility::flag_wait("titan_building_1_turn_on_lights");

  foreach(var_4 in var_1) {
    var_4[0] thread _id_11956(var_4[1]);
    wait 1.2;
  }

  setsaveddvar("sm_roundRobinPrioritySpotShadows", "10");
}

_id_11956(var_0) {
  var_1 = 4.0;
  _id_11955();

  while(var_1 >= 1.0) {
    self setlightintensity(var_0 * var_1);
    var_1 = var_1 - 0.2;
    wait 0.5;
  }
}

_id_11955() {
  var_0 = 0.0;

  while(var_0 < 10) {
    var_1 = randomfloatrange(0.05, 20.0);
    self setlightintensity(var_1);
    var_0 = var_0 + 0.25;
    wait 0.05;
  }
}

_id_6942() {
  scripts\engine\utility::flag_wait("exit_building_1_vision_fx");
  setsaveddvar("sm_sunSampleSizeNear", 0.3);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 1);
  setsaveddvar("r_volumetrics", 1);
  setsaveddvar("sm_sunEnable", 0);
  setsaveddvar("sm_spotEnable", 1);
  setsaveddvar("sm_roundRobinPrioritySpotShadows", "4");
  setsaveddvar("r_usePrebuiltSunShadow", 0);
  thread _id_4FE8();
  level._id_1124C = 60;
  var_0 = getEnt("saturn_test", "targetname");
  var_0.origin = (244873, -257788, 75240);
  var_0.angles = (325, 323, -18);
  _id_1123F(100);
  scripts\engine\utility::flag_set("enable_sim_rain_around_player");
  scripts\engine\utility::flag_set("enable_sim_lightning_around_player");
  scripts\engine\utility::flag_set("supercell_methane_storm_fx_part_2");
  scripts\engine\utility::flag_set("enable_streets_1_sirens");
}

_id_10F21() {
  scripts\engine\utility::flag_wait("stealth_street_1_vision_fx");
  setsaveddvar("sm_sunEnable", 0);
  setsaveddvar("r_usePrebuiltSunShadow", 0);
  setsaveddvar("sm_sunSampleSizeNear", 0.3);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 1);
  setsaveddvar("r_volumetrics", 1);
  thread _id_0B0A::_id_583D(1.0);
  setsaveddvar("sm_spotEnable", 1);
  var_0 = getEnt("saturn_test", "targetname");
  var_0.origin = (253833, -147068, 75240);
  var_0.angles = (325, 323, -18);
  _id_1123F(100);
  scripts\engine\utility::flag_set("enable_sim_rain_around_player");
  scripts\engine\utility::flag_set("enable_sim_lightning_around_player");
  scripts\engine\utility::flag_set("supercell_methane_storm_fx_part_2");
}

_id_10F23() {
  scripts\engine\utility::flag_wait("stealth_street_2_vision_fx");
  setsaveddvar("sm_sunenable", 0);
  setsaveddvar("r_usePrebuiltSunShadow", 0);
  setsaveddvar("sm_sunSampleSizeNear", 0.3);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 1);
  setsaveddvar("r_volumetrics", 1);
  setsaveddvar("sm_roundRobinPrioritySpotShadows", "6");
  setsaveddvar("sm_spotEnable", 1);
  var_0 = getEnt("saturn_test", "targetname");
  var_0.origin = (253833, -147068, 75240);
  var_0.angles = (325, 323, -18);
  _id_1123F(100);
  scripts\engine\utility::flag_set("enable_sim_rain_around_player");
  scripts\engine\utility::flag_set("enable_sim_lightning_around_player");
  scripts\engine\utility::flag_set("supercell_methane_storm_fx_part_2");
  scripts\engine\utility::flag_set("stealth_street_2_flicker_light");
}

_id_10F22() {
  thread _id_6F0D("stealth_street_2_flicker_light", "stealth_street_2_flicker_light", "stealth_street_2_flicker_light_on", "stealth_street_2_flicker_light_off");
}

_id_10F24() {
  scripts\engine\utility::flag_wait("stealth_street_3_vision_fx");
  setsaveddvar("sm_sunenable", 0);
  setsaveddvar("r_usePrebuiltSunShadow", 0);
  setsaveddvar("sm_sunSampleSizeNear", 0.3);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 1);
  setsaveddvar("r_volumetrics", 1);
  setsaveddvar("sm_roundRobinPrioritySpotShadows", "6");
  setsaveddvar("sm_spotEnable", 1);
  var_0 = getEnt("saturn_test", "targetname");
  var_0.origin = (253833, -147068, 75240);
  var_0.angles = (325, 323, -18);
  _id_1123F(100);
  scripts\engine\utility::flag_set("enable_sim_rain_around_player");
  scripts\engine\utility::flag_set("enable_sim_lightning_around_player");
  scripts\engine\utility::flag_set("supercell_methane_storm_fx_part_2");
  scripts\engine\utility::flag_set("stealth_street_2_flicker_light");
}

_id_6241() {
  scripts\engine\utility::flag_wait("enable_sun_shadow");
  setsaveddvar("sm_sunenable", 1);
}

_id_117F8() {
  scripts\engine\utility::flag_wait("through_here_vision_fx");
  setsaveddvar("sm_sunenable", 1);
  setsaveddvar("r_usePrebuiltSunShadow", 3);
  setsaveddvar("sm_sunSampleSizeNear", 0.3);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 1);
  setsaveddvar("r_volumetrics", 1);
  setsaveddvar("sm_spotEnable", 1);
  setsaveddvar("sm_roundRobinPrioritySpotShadows", "4");
  var_0 = getEnt("saturn_test", "targetname");
  var_0.origin = (253833, -147068, 75240);
  var_0.angles = (325, 323, -18);
  _id_1123F(100);
  scripts\engine\utility::flag_set("enable_sim_rain_around_player");
  scripts\engine\utility::flag_set("supercell_methane_storm_fx_part_2");
  scripts\engine\utility::flag_set("squeeze_through_flicker_light");
}

_id_10B26() {
  scripts\engine\utility::flag_wait("squeeze_through_vision_fx");
  scripts\engine\utility::flag_set("clear_vision_set_naked");
  scripts\engine\utility::flag_set("c12_dropoff_attach_fence_lights");
  scripts\engine\utility::flag_set("squeeze_through_flicker_light");
  thread _id_11251();
  setsaveddvar("sm_sunSampleSizeNear", 0.3);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 2);
  setsaveddvar("r_usePrebuiltSunShadow", 3);
  setsaveddvar("sm_spotEnable", 1);
  setsaveddvar("r_volumetrics", 0);
  setsaveddvar("sm_roundRobinPrioritySpotShadows", "8");
  var_0 = getEnt("saturn_test", "targetname");
  var_0.origin = (215433, -183868, 96680);
  var_0.angles = (325, 323, -18);
  var_0 hide();

  if(isDefined(level._id_6457))
    level._id_6457 castspotshadows(0);

  var_1 = getEnt("sky_background_clouds", "targetname");
  var_1 show();
}

_id_10B1E() {
  thread _id_6F0D("squeeze_through_flicker_light", "squeeze_through_flicker_light", "squeeze_through_flicker_light_on", "squeeze_through_flicker_light_off");
}

_id_354A() {
  scripts\engine\utility::flag_wait("c12_dropoff_attach_fence_lights");
  var_0 = scripts\engine\utility::getfx("vfx_hms_lensflare_light_06c");
  var_1 = getEnt("gate_crash_1_sides", "targetname");
  var_2 = getEnt("left_gate_light_a", "targetname");
  var_3 = getEnt("left_gate_light_b", "targetname");
  var_4 = getEnt("left_gate_light_c", "targetname");
  var_5 = getEnt("right_gate_light_a", "targetname");
  var_6 = getEnt("right_gate_light_b", "targetname");

  if(isDefined(var_1) && isDefined(var_2) && isDefined(var_3) && isDefined(var_4) && isDefined(var_5) && isDefined(var_6)) {
    var_7 = var_1 gettagorigin("c12_gate_bone_07");
    var_8 = var_1 gettagorigin("c12_gate_bone_15");
    var_9 = (20, -10, 20);
    var_10 = (25, -53, 11);
    var_11 = (-17, -55, -5);
    var_12 = (15, -10, 20);
    var_13 = (18, -54, 15);
    var_14 = (-65, -35, 0);
    var_15 = (-50, -35, 0);
    var_16 = (65, -35, 0);
    var_17 = (-115, 30, 30);
    var_18 = (-120, 30, 30);
    var_19 = scripts\engine\utility::spawn_tag_origin();
    var_19 linkTo(var_1, "c12_gate_bone_07", var_9, var_14);
    var_2.origin = (0, 0, 0);
    var_2.angles = (0, 0, 0);
    var_2 linkTo(var_19, "tag_origin");
    playFXOnTag(var_0, var_19, "tag_origin");
    var_20 = scripts\engine\utility::spawn_tag_origin();
    var_20 linkTo(var_1, "c12_gate_bone_07", var_10, var_15);
    var_3.origin = (0, 0, 0);
    var_3.angles = (0, 0, 0);
    var_3 linkTo(var_20, "tag_origin");
    playFXOnTag(var_0, var_20, "tag_origin");
    var_21 = scripts\engine\utility::spawn_tag_origin();
    var_21 linkTo(var_1, "c12_gate_bone_07", var_11, var_16);
    var_4.origin = (0, 0, 0);
    var_4.angles = (0, 0, 0);
    var_4 linkTo(var_21, "tag_origin");
    playFXOnTag(var_0, var_21, "tag_origin");
    var_22 = scripts\engine\utility::spawn_tag_origin();
    var_22 linkTo(var_1, "c12_gate_bone_15", var_12, var_17);
    var_5.origin = (0, 0, 0);
    var_5.angles = (0, 0, 0);
    var_5 linkTo(var_22, "tag_origin");
    playFXOnTag(var_0, var_22, "tag_origin");
    var_23 = scripts\engine\utility::spawn_tag_origin();
    var_23 linkTo(var_1, "c12_gate_bone_15", var_13, var_18);
    var_6.origin = (0, 0, 0);
    var_6.angles = (0, 0, 0);
    var_6 linkTo(var_23, "tag_origin");
    playFXOnTag(var_0, var_23, "tag_origin");
  }
}

_id_F0A1() {
  scripts\engine\utility::flag_wait("second_encounter_vision_fx");
  scripts\engine\utility::flag_set("clear_vision_set_naked");
  scripts\engine\utility::flag_set("c12_dropoff_attach_fence_lights");
  scripts\engine\utility::flag_set("squeeze_through_flicker_light");
  thread _id_11251();
  setsaveddvar("r_usePrebuiltSunShadow", 3);
  setsaveddvar("sm_sunSampleSizeNear", 0.53);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 3);
  setsaveddvar("r_volumetrics", 0);
  setsaveddvar("sm_spotEnable", 1);
  var_0 = getEnt("saturn_test", "targetname");
  var_0.origin = (215433, -183868, 96680);
  var_0.angles = (325, 323, -18);
  var_0 hide();
  var_1 = getEnt("sky_background_clouds", "targetname");
  var_1 hide();

  if(isDefined(level._id_EF4E))
    level._id_EF4E castspotshadows(0);
}

_id_F09B() {
  scripts\engine\utility::flag_wait("second_encounter_spot_shadow_4");
  setsaveddvar("sm_roundRobinPrioritySpotShadows", "4");
  scripts\engine\utility::flag_clear("second_encounter_spot_shadow_4");
  wait 0.2;
  thread _id_F09B();
}

_id_F09C() {
  scripts\engine\utility::flag_wait("second_encounter_spot_shadow_8");
  setsaveddvar("sm_roundRobinPrioritySpotShadows", "8");
  scripts\engine\utility::flag_clear("second_encounter_spot_shadow_8");
  wait 0.2;
  thread _id_F09C();
}

_id_2A13() {
  scripts\engine\utility::flag_wait("beacon_vision_fx");
  scripts\engine\utility::flag_set("c12_dropoff_attach_fence_lights");
  scripts\engine\utility::flag_clear("squeeze_through_flicker_light");
  scripts\engine\utility::flag_set("clear_vision_set_naked");
  thread _id_11251();
  setsaveddvar("r_usePrebuiltSunShadow", 0);
  setsaveddvar("sm_sunSampleSizeNear", 0.53);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 3);
  setsaveddvar("sm_spotEnable", 1);
  setsaveddvar("r_volumetrics", 0);
  var_0 = getEnt("saturn_test", "targetname");
  var_0.origin = (215433, -183868, 96680);
  var_0.angles = (325, 323, -18);
  var_0 hide();
  var_1 = getEnt("sky_background_clouds", "targetname");
  var_1 hide();

  if(isDefined(level._id_EF4E))
    level._id_EF4E castspotshadows(0);
}

_id_206E() {
  scripts\engine\utility::flag_wait("apc_dropoff_sun_ext");
  setsaveddvar("sm_sunSampleSizeNear", 0.53);
  setsaveddvar("r_volumetrics", 0);
  scripts\engine\utility::flag_clear("apc_dropoff_sun_ext");
  thread _id_206E();
}

_id_206F() {
  scripts\engine\utility::flag_wait("apc_dropoff_sun_int");
  setsaveddvar("sm_sunSampleSizeNear", 0.53);
  setsaveddvar("r_volumetrics", 0);
  scripts\engine\utility::flag_clear("apc_dropoff_sun_int");
  thread _id_206F();
}

_id_2070() {
  scripts\engine\utility::flag_wait("apc_dropoff_vision_fx");
  scripts\engine\utility::flag_set("c12_dropoff_attach_fence_lights");
  scripts\engine\utility::flag_set("clear_vision_set_naked");
  thread _id_11251();
  setsaveddvar("r_usePrebuiltSunShadow", 3);
  setsaveddvar("sm_sunSampleSizeNear", 0.53);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 3);
  setsaveddvar("sm_spotEnable", 1);
  setsaveddvar("r_volumetrics", 0);
  var_0 = getEnt("saturn_test", "targetname");
  var_0.origin = (215433, -183868, 96680);
  var_0.angles = (325, 323, -18);
  var_0 hide();
  var_1 = getEnt("sky_background_clouds", "targetname");
  var_1 hide();

  if(isDefined(level._id_EF4E))
    level._id_EF4E castspotshadows(0);
}

_id_205B() {
  scripts\engine\utility::flag_wait("apc_attack_vision_fx");
  scripts\engine\utility::flag_set("c12_dropoff_attach_fence_lights");
  level._id_4BCE = "titan_refinery_reveal";
  scripts\engine\utility::flag_set("clear_vision_set_naked");
  thread _id_11251();
  setsaveddvar("r_usePrebuiltSunShadow", 0);
  setsaveddvar("sm_sunSampleSizeNear", 0.3);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 4);
  setsaveddvar("r_volumetrics", 0);
  thread _id_4FE8(1.0, 18000, 22000);
  thread _id_11251();
  var_0 = getEnt("saturn_test", "targetname");
  var_0.origin = (240717, 124615, 65000);
  var_0.angles = (321.904, 28.6054, -4.5804);
  var_0 show();
  var_1 = getEnt("sky_background_clouds", "targetname");
  var_1 show();

  if(isDefined(level._id_EF4E))
    level._id_EF4E castspotshadows(0);

  thread _id_5F94();
}

_id_5F94() {
  if(isDefined(level._id_739C)) {
    if(scripts\engine\utility::flag("dynamicSunSampleRefinery")) {
      return;
    }
    scripts\engine\utility::flag_set("dynamicSunSampleRefinery");
    var_0 = 0.3;

    while(isalive(level._id_739C)) {
      var_1 = level._id_739C.origin - level.player.origin;
      var_2 = vectorNormalize(var_1);
      var_3 = anglesToForward(level.player.angles);
      var_4 = vectordot(var_2, var_3);
      var_5 = clamp(var_4, 0.0, 1.0);
      var_6 = 0.35 * (1 - var_5) + 0.23 * var_5;
      var_7 = abs(var_0 - var_6);

      if(var_7 > 0.02) {
        setsaveddvar("sm_sunSampleSizeNear", var_6);
        var_0 = var_6;
      }

      wait 0.35;

      if(scripts\engine\utility::flag("endDynamicSunSampleRefinery")) {
        setsaveddvar("sm_sunSampleSizeNear", 0.3);
        return;
      }
    }
  }
}

_id_DE54() {
  scripts\engine\utility::flag_wait("refinery_turn_off_sun");
  setsaveddvar("r_usePrebuiltSunShadow", 3);
  scripts\engine\utility::flag_clear("refinery_turn_off_sun");
  wait 0.25;
  thread _id_DE54();
}

_id_DE55() {
  scripts\engine\utility::flag_wait("refinery_turn_on_sun");
  setsaveddvar("r_usePrebuiltSunShadow", 0);
  scripts\engine\utility::flag_clear("refinery_turn_on_sun");
  wait 0.25;
  thread _id_DE55();
}

_id_100FB() {
  scripts\engine\utility::flag_wait("show_sky_background_clouds");
  var_0 = getEnt("sky_background_clouds", "targetname");
  var_0 show();
  scripts\engine\utility::flag_clear("show_sky_background_clouds");
  wait 0.2;
  thread _id_100FB();
}

_id_8EA4() {
  scripts\engine\utility::flag_wait("hide_sky_background_clouds");
  var_0 = getEnt("sky_background_clouds", "targetname");
  var_0 hide();
  scripts\engine\utility::flag_clear("hide_sky_background_clouds");
  wait 0.2;
  thread _id_8EA4();
}

_id_3642() {
  scripts\engine\utility::flag_wait("c12fight_transition_vision_fx");
  thread _id_11251();
  setsaveddvar("sm_sunEnable", 1);
  setsaveddvar("r_usePrebuiltSunShadow", 3);
  setsaveddvar("sm_sunSampleSizeNear", 0.3);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 3);
  setsaveddvar("r_volumetrics", 0);
  var_0 = getEnt("saturn_test", "targetname");
  var_0.origin = (240717, 124615, 65000);
  var_0.angles = (321.904, 28.6054, -4.5804);
  thread _id_5F94();
  thread scripts\sp\maps\titan\titan_apc_attack::_id_1294A();
}

_id_3640() {
  scripts\engine\utility::flag_wait("c12fight_dropoff_vision_fx");
  thread _id_11251();
  scripts\engine\utility::flag_set("endDynamicSunSampleRefinery");
  setsaveddvar("sm_sunEnable", 1);
  setsaveddvar("r_usePrebuiltSunShadow", 3);
  setsaveddvar("sm_sunSampleSizeNear", 0.3);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 3);
  setsaveddvar("r_volumetrics", 0);
  var_0 = getEnt("saturn_test", "targetname");
  var_0.origin = (240717, 124615, 65000);
  var_0.angles = (321.904, 28.6054, -4.5804);
  thread scripts\sp\maps\titan\titan_apc_attack::_id_1294A();
}

_id_352F() {
  var_0 = scripts\engine\utility::getStructArray("c12_crash_impulse", "targetname");
  var_1 = getEnt("c12_crash_scaffolding", "targetname");
  var_2 = getEnt("c12_crash_dest_scaffolding", "targetname");
  var_3 = getEnt("c12_crash_bullet_clip", "targetname");
  var_2 hide();
  var_4 = scripts\engine\utility::getfx("vfx_c12_smashing_wall_v2");
  var_5 = scripts\engine\utility::getfx("vfx_hms_steam_pipe_small_01");
  var_6 = scripts\engine\utility::getfx("vfx_hms_steam_pipe_large_01");
  var_7 = scripts\engine\utility::spawn_tag_origin();
  var_7 linkTo(var_2, "tag_origin", (0, 0, 150), (0, 0, 0));
  var_8 = scripts\engine\utility::spawn_tag_origin();
  var_8 linkTo(var_2, "tag_origin", (-24, -148, 112), (25, 90, 0));
  var_9 = scripts\engine\utility::spawn_tag_origin();
  var_9 linkTo(var_2, "tag_origin", (30, 84, 134), (28, -90, 0));
  scripts\engine\utility::flag_wait("c12_crash_in_physics");
  wait 1.8;
  playworldsound("scn_C12_titan_bridge_impact", (-29468, -41678, -64875));
  playFXOnTag(var_4, var_7, "tag_origin");
  playFXOnTag(var_5, var_8, "tag_origin");
  playFXOnTag(var_6, var_9, "tag_origin");
  var_1 delete();
  var_3 delete();
  var_2 show();
  var_10 = (0, 0, 0);

  foreach(var_12 in var_0) {
    physicsexplosionsphere(var_12.origin, 375, 5, 100.0);
    var_13 = var_12.origin + (randomfloatrange(-150, 150), randomfloatrange(-150, 150), randomfloatrange(-150, 150));
    physicsexplosionsphere(var_13, 375, 5, 200.0);
    var_10 = var_12.origin;
  }

  wait 0.5;
  thread _id_4D65(1, "damage_light", 0.8, 0.25, 0.35);
  wait 0.5;
  physicsexplosionsphere(var_10 + (0, 0, 250), 675, 5, 1350.0);
}

_id_363E() {
  scripts\engine\utility::flag_wait("c12fight_charge_vision_fx");
  thread _id_11251();
  setsaveddvar("sm_sunEnable", 1);
  setsaveddvar("r_usePrebuiltSunShadow", 3);
  setsaveddvar("sm_sunSampleSizeNear", 0.3);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 3);
  setsaveddvar("r_volumetrics", 0);
  var_0 = getEnt("saturn_test", "targetname");
  var_0.origin = (240717, 124615, 65000);
  var_0.angles = (321.904, 28.6054, -4.5804);
  thread scripts\sp\maps\titan\titan_apc_attack::_id_1294A();
}

_id_BAE2() {
  scripts\engine\utility::flag_wait("mons_pickup_vision_fx");
  thread _id_11251();
  scripts\engine\utility::flag_set("endDynamicSunSampleRefinery");
  setsaveddvar("sm_sunEnable", 1);
  setsaveddvar("r_usePrebuiltSunShadow", 3);
  setsaveddvar("sm_sunSampleSizeNear", 0.3);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 2);
  setsaveddvar("r_volumetrics", 0);
  thread _id_4FE8(1.16, 8000, 16000);
  var_0 = getEnt("saturn_test", "targetname");
  var_0.origin = (240717, 124615, 65000);
  var_0.angles = (321.904, 28.6054, -4.5804);
  thread scripts\sp\maps\titan\titan_apc_attack::_id_1294A();
}

_id_BA76() {
  scripts\engine\utility::flag_wait("mons_door_vision_fx");
  thread _id_11251();
  scripts\engine\utility::flag_set("endDynamicSunSampleRefinery");
  setsaveddvar("sm_sunEnable", 1);
  setsaveddvar("r_usePrebuiltSunShadow", 3);
  setsaveddvar("sm_sunSampleSizeNear", 0.3);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 4);
  thread _id_4FE8(1.16, 8000, 16000);
  var_0 = getEnt("saturn_test", "targetname");
  var_0.origin = (240717, 124615, 65000);
  var_0.angles = (321.904, 28.6054, -4.5804);
  thread scripts\sp\maps\titan\titan_apc_attack::_id_1294A();
}

_id_BA61() {
  scripts\engine\utility::flag_wait("mons_bunker_vision_fx");
  thread _id_11251();
  scripts\engine\utility::flag_set("endDynamicSunSampleRefinery");
  setsaveddvar("sm_sunEnable", 1);
  setsaveddvar("r_usePrebuiltSunShadow", 3);
  setsaveddvar("sm_sunSampleSizeNear", 0.3);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 2);
  thread _id_4FE8(1.16, 8000, 16000);
  var_0 = getEnt("saturn_test", "targetname");
  var_0.origin = (240717, 124615, 65000);
  var_0.angles = (321.904, 28.6054, -4.5804);
}

_id_BAE1() {
  scripts\engine\utility::flag_wait("mons_overwatch_vision_fx");
  thread _id_11251();
  scripts\engine\utility::flag_set("endDynamicSunSampleRefinery");
  setsaveddvar("sm_sunEnable", 1);
  setsaveddvar("sm_sunSampleSizeNear", 1.35);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 3);
  thread _id_4FE8(1.16, 8000, 16000);
  var_0 = getEnt("saturn_test", "targetname");
  var_0.origin = (240717, 124615, 65000);
  var_0.angles = (321.904, 28.6054, -4.5804);
}

_id_11244() {
  level endon("squeeze_through");
  scripts\engine\utility::flag_wait("supercell_methane_storm_fx_part_1");
  scripts\engine\utility::flag_set("enable_building_1_sirens");

  if(!scripts\engine\utility::flag("supercell_methane_storm_ents_moving"))
    thread _id_11246(100);
}

_id_11245() {
  level endon("squeeze_through");
  scripts\engine\utility::flag_wait("supercell_methane_storm_fx_part_2");

  if(!scripts\engine\utility::flag("supercell_methane_storm_ents_moving"))
    _id_11246(100);

  thread _id_11249(0.8, 0.001);
  thread _id_1124A(100);
  wait 1.0;
  scripts\engine\utility::flag_clear("supercell_methane_storm_fx_part_1");
}

_id_1123B() {
  level endon("squeeze_through");
  scripts\engine\utility::flag_wait("storm_building_event");
  var_0 = getEnt("first_storm_strike_a", "targetname");

  if(isDefined(var_0)) {
    var_1 = var_0.origin;
    var_2 = anglesToForward(var_0.angles);
    thread _id_11241("vfx_duststorm_lightning_02", "emt_titan_lightning_strike_pre_scripted", "emt_titan_lightning_strike_scripted", var_1, var_2, 3000, 0.3, "titan_storm_heavy_lightning", "titan_storm_medium_b", 0.4);
  }

  wait 1.0;
  var_3 = getEnt("first_storm_strike_b", "targetname");

  if(isDefined(var_3)) {
    var_1 = var_3.origin;
    var_2 = anglesToForward(var_3.angles);
    thread _id_11241("vfx_duststorm_lightning_02", "emt_titan_lightning_strike_pre_scripted_02", "emt_titan_lightning_strike_scripted_02", var_1, var_2, 3000, 0.3, "titan_storm_heavy_lightning", "titan_storm_medium_b", 0.01);
  }
}

_id_11248() {
  level endon("squeeze_through");
  scripts\engine\utility::flag_wait("supercell_methane_storm_tower_lightning_strike");
  var_0 = (-29691, -30585, -50661);
  var_1 = anglesToForward((0, 185, 0));
  thread _id_11241("vfx_duststorm_lightning_03", "emt_titan_lightning_strike_pre_scripted_big_tower", "emt_titan_lightning_strike_scripted_big_tower", var_0, var_1, 0, 0, "titan_storm_heavy_lightning", "titan_storm_heavy", 0.1);
  wait 2.0;
  thread _id_11241("vfx_duststorm_lightning_03", "emt_titan_lightning_strike_pre_scripted_big_tower", "emt_titan_lightning_strike_scripted_big_tower", var_0, var_1, 0, 0, "titan_storm_heavy_lightning", "titan_storm_heavy", 0.1);
}

_id_1123A() {
  level endon("squeeze_through");
  scripts\engine\utility::flag_wait("supercell_methane_storm_end");
  scripts\engine\utility::flag_clear("supercell_methane_storm_fx_part_1");
  scripts\engine\utility::flag_clear("supercell_methane_storm_fx_part_2");
  scripts\engine\utility::flag_clear("enable_sim_lightning_around_player");
  scripts\engine\utility::flag_clear("enable_sim_rain_around_player");
  scripts\engine\utility::flag_clear("supercell_methane_storm_ents_moving");
  scripts\sp\utility::_id_10FEC("cell_storm_2");

  if(isDefined(level._id_EB1B) && isDefined(level._id_EB1B.enabled))
    level._id_EB1B.enabled = 0;
}

_id_11246(var_0) {
  foreach(var_2 in level._id_11253) {
    var_2 show();
    var_2 thread _id_11242();
  }

  scripts\engine\utility::flag_set("supercell_methane_storm_ents_moving");
}

_id_1124A(var_0) {
  foreach(var_2 in level._id_11253)
  var_2._id_BCED = var_0;
}

_id_11249(var_0, var_1) {
  foreach(var_3 in level._id_11253) {
    var_4 = var_3._id_10DDF + var_3._id_BCB2 * (var_3._id_B4B2 * var_0);
    var_3 moveTo(var_4, var_1);
  }
}

_id_11241(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  thread _id_D527(var_1, var_3);
  wait(var_9);
  var_10 = scripts\engine\utility::getfx(var_0);
  visionsetalternate(1, 0.1);
  playFX(var_10, var_3, var_4, (0, 0, 1));
  wait 0.1;
  thread _id_D527(var_2, var_3);
  wait 0.001;
  var_11 = distance(var_3, level.player.origin);

  if(var_11 < var_5) {
    var_12 = (1 - var_11 / var_5) * var_6;
    thread _id_4D65(40 * var_12, "damage_light", 0.5, 0.5 * var_12, 1.0 * var_12);
    thread _id_D527("emt_titan_lightning_strike_ground_scrn_shake", var_3, undefined, var_12);
  }

  wait 0.3;
  visionsetalternate(0, 0.25);
}

_id_11243() {
  level endon("squeeze_through");
  scripts\engine\utility::flag_wait("enable_sim_lightning_around_player");
  var_0 = getEntArray("supercell_methan_storm_strike_position", "targetname");
  var_1 = 3500;
  var_2 = 800;
  var_3 = 0.3;
  var_4 = 0;

  while(scripts\engine\utility::flag("enable_sim_lightning_around_player")) {
    var_5 = _id_1123C(var_0, var_2, var_1);

    if(var_5.size > 0) {
      var_6 = randomintrange(0, var_5.size);

      if(var_4 == var_6)
        var_6 = randomintrange(0, var_5.size);

      var_7 = (1, -1, 0);
      _id_11241("vfx_duststorm_lightning_02", "emt_titan_lightning_strike_pre_ground", "emt_titan_lightning_strike_ground", var_5[var_6].origin, var_7, var_1, var_3, "titan_storm_heavy_lightning", level._id_4BCE, 0.1);
    }

    var_8 = randomfloatrange(2.0, 8.0);
    wait(var_8);
  }

  thread _id_11243();
}

_id_1123C(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = 0;

  foreach(var_6 in var_0) {
    var_7 = (0, 0, level.player _meth_8157());
    var_8 = vectorNormalize(var_6.origin - (level.player.origin + var_7));
    var_9 = distance(var_6.origin, level.player.origin);
    var_10 = vectorNormalize(anglesToForward(level.player getplayerangles()));
    var_11 = vectordot(var_8, var_10);

    if(var_11 > 0.65 && var_9 > var_1 && var_9 < var_2) {
      var_3[var_4] = var_6;
      var_4++;
    }
  }

  return var_3;
}

_id_11247() {
  level endon("squeeze_through");
  scripts\engine\utility::flag_wait("enable_sim_rain_around_player");
  var_0 = scripts\engine\utility::getfx("vfx_hms_rain_player_view_01");

  while(scripts\engine\utility::flag("enable_sim_rain_around_player")) {
    var_1 = level.player.origin;
    playFX(var_0, var_1, (1, -1, 0), (0, 0, 1));
    var_2 = randomfloatrange(0.3, 1.0);
    wait(var_2);
  }

  thread _id_11247();
}

_id_1123F(var_0) {
  level endon("squeeze_through");

  if(scripts\engine\utility::flag("supercell_methane_storm_init_main")) {
    return;
  }
  thread _id_1123B();
  thread _id_11244();
  thread _id_11245();
  thread _id_11243();
  thread _id_11248();
  thread _id_1123A();
  thread _id_11247();
  thread _id_11240();
  level._id_11253 = [];
  var_1 = (0, -1, 0);
  var_2 = (32720, 3648, 736);
  var_3 = length(var_2) * 0.85;
  var_4 = vectorNormalize(var_2);
  level._id_1124C = 90;
  var_5 = getEnt("supercell_cloud_small_front", "targetname");
  var_5 castspotshadows(0);
  _id_1123D("small", var_5, var_4, var_3 * 0.3, var_0);
  _id_1123E("small", "small_lightning", scripts\engine\utility::getfx("vfx_duststorm_lightning_01"), "emt_titan_lightning_sky", 0, 2, 10000, 1000, 0, var_1);
  _id_1123E("small", "small_thunder", scripts\engine\utility::getfx("vfx_duststorm_thunder_01"), undefined, 0, 2, 8000, 2000, 0, var_1);
  var_6 = getEnt("supercell_cloud_medium_front", "targetname");
  var_6 castspotshadows(0);
  _id_1123D("medium", var_6, var_4, var_3 * 0.4, var_0);
  _id_1123E("medium", "medium_lightning", scripts\engine\utility::getfx("vfx_duststorm_lightning_01"), "emt_titan_lightning_sky", 0, 1, 10000, 3000, 0, var_1);
  _id_1123E("medium", "medium_thunder", scripts\engine\utility::getfx("vfx_duststorm_thunder_01"), "emt_titan_thunder_sky", 0, 2, 10000, 3000, 0, var_1, 1, 1, 10);
  thread _id_11239();
  var_5 hide();
  var_6 hide();
  scripts\engine\utility::flag_set("supercell_methane_storm_init_main");
}

_id_1123D(var_0, var_1, var_2, var_3, var_4) {
  level._id_11253[var_0] = var_1;
  level._id_11253[var_0].fxtag = [];
  level._id_11253[var_0]._id_10DDF = var_1.origin;
  level._id_11253[var_0]._id_BCB2 = var_2;
  level._id_11253[var_0]._id_BCB3 = 0.01;
  level._id_11253[var_0]._id_B4B2 = var_3;
  level._id_11253[var_0]._id_BCED = var_4;
}

_id_1123E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = spawnStruct();
  var_13.fx = var_2;
  var_13._id_7640 = var_3;
  var_13._id_B757 = var_4;
  var_13._id_B489 = var_5;
  var_13._id_13E11 = var_6;
  var_13._id_13E59 = var_7;
  var_13.yoffset = var_8;
  var_13.forward = var_9;
  var_13.up = (0, 0, 1);
  var_13._id_101AD = (1, 0, 0);

  if(isDefined(var_10)) {
    var_13._id_12FA0 = var_10;
    var_13._id_1D4C = var_11;
    var_13._id_1D4B = var_12;
  } else
    var_13._id_12FA0 = 0;

  var_13._id_1D4D = 0;
  level._id_11253[var_0].fxtag[var_1] = var_13;
}

_id_11239() {
  level._id_11254 = [];
  _id_11238("emt_titan_thunder_mtl_rattle_int", (-58103, -34584, -64565));
  _id_11238("emt_titan_thunder_mtl_rattle_int", (-58054, -34632, -64561));
  _id_11238("emt_titan_thunder_mtl_rattle_int", (-58072, -34372, -64561));
  _id_11238("emt_titan_thunder_mtl_rattle_int", (-57910, -34355, -64600));
  _id_11238("emt_titan_thunder_mtl_rattle_int", (-57954, -34524, -64600));
  _id_11238("emt_titan_thunder_mtl_rattle_int", (-57556, -34425, -64601));
  _id_11238("emt_titan_thunder_mtl_rattle_int", (-57796, -34585, -64568));
  _id_11238("emt_titan_thunder_mtl_rattle_int", (-57543, -34672, -64572));
  _id_11238("emt_titan_thunder_mtl_rattle_int", (-57436, -34657, -64562));
  _id_11238("emt_titan_thunder_mtl_rattle_int", (-57272, -34577, -64620));
  _id_11238("emt_titan_thunder_mtl_rattle_int", (-57027, -34689, -64561));
  _id_11238("emt_titan_thunder_mtl_rattle_int", (-57228, -34748, -64572));
  _id_11238("emt_titan_thunder_mtl_rattle_int", (-57027, -34689, -64561));
  _id_11238("emt_titan_thunder_mtl_rattle_int", (-57151, -34545, -64570));
  _id_11238("emt_titan_thunder_mtl_rattle_int", (-57982, -34379, -64546));
  _id_11238("emt_titan_thunder_mtl_rattle_int", (-58916, -33854, -64555));
  _id_11238("emt_titan_thunder_mtl_rattle_int", (-58816, -34165, -64594));
  _id_11238("emt_titan_thunder_mtl_rattle_int", (-59071, -34186, -64564));
  _id_11238("emt_titan_thunder_mtl_rattle_int", (-53245, -36643, -64620));
  _id_11238("emt_titan_thunder_mtl_rattle_int", (-53066, -36686, -64620));
  _id_11238("emt_titan_thunder_mtl_rattle_int", (-52930, -36235, -64620));
  _id_11238("emt_titan_thunder_mtl_rattle_int", (-52647, -36316, -64620));
  _id_11238("emt_titan_thunder_mtl_rattle_int", (-52436, -36370, -64620));
  _id_11238("emt_titan_thunder_mtl_rattle_int", (-51679, -38618, -64382));
  _id_11238("emt_titan_thunder_mtl_rattle_int", (-51893, -38691, -64382));
  _id_11238("emt_titan_thunder_mtl_rattle_int", (-51982, -38420, -64382));
  _id_11238("emt_titan_thunder_mtl_rattle_int", (-52099, -38934, -64382));
  _id_11238("emt_titan_thunder_mtl_rattle_int", (-52143, -39293, -64382));
  _id_11238("emt_titan_thunder_mtl_rattle_int", (-51797, -39296, -64382));
  _id_11238("emt_titan_thunder_mtl_rattle_int", (-51858, -39341, -64382));
  _id_11238("emt_titan_thunder_mtl_rattle_int_dist", (-48096, -39040, -64132));
  _id_11238("emt_titan_thunder_mtl_rattle_int_dist", (-48095, -39147, -64132));
  _id_11238("emt_titan_thunder_mtl_rattle_int_dist", (-47834, -38967, -64132));
  _id_11238("emt_titan_thunder_mtl_rattle_int_dist", (-47548, -39184, -64101));
  _id_11238("emt_titan_thunder_mtl_rattle_int_dist", (-47350, -39198, -64099));
  _id_11238("emt_titan_thunder_mtl_rattle_int_dist", (-47495, -39377, -64132));
  _id_11238("emt_titan_thunder_mtl_rattle_int_dist", (-47908, -39358, -64132));
  _id_11238("emt_titan_thunder_mtl_rattle_int_dist", (-47809, -39235, -64132));
  _id_11238("emt_titan_thunder_mtl_rattle_int_dist", (-47517, -39925, -64067));
  _id_11238("emt_titan_thunder_mtl_rattle_int_dist", (-47769, -40316, -63983));
  _id_11238("emt_titan_thunder_mtl_rattle_int_dist", (-47691, -40548, -63976));
  _id_11238("emt_titan_thunder_mtl_rattle_int_dist", (-47833, -40633, -64130));
  _id_11238("emt_titan_thunder_mtl_rattle_int_dist", (-47749, -40559, -63952));
}

_id_11238(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.sound = var_0;
  var_2.pos = var_1;
  level._id_11254[level._id_11254.size] = var_2;
}

_id_11240() {
  level endon("squeeze_through");
  scripts\engine\utility::flag_wait("supercell_methane_storm_ents_moving");
  wait 0.05;
  var_0 = 0;
  setglobalsoundcontext("storm", "storm_ext", 0.0);

  while(scripts\engine\utility::flag("supercell_methane_storm_ents_moving")) {
    var_1 = 0;
    var_2 = undefined;

    foreach(var_4 in level._id_BFDF) {
      if(level.player istouching(var_4)) {
        var_1 = 1;
        isDefined(var_4.script_noteworthy);
        var_2 = var_4.script_noteworthy;
        break;
      }
    }

    if(var_0 != var_1) {
      if(var_1) {
        if(isDefined(var_2))
          setglobalsoundcontext("storm", var_2, 0.5);
        else
          setglobalsoundcontext("storm", "storm_int", 0.5);
      } else
        setglobalsoundcontext("storm", "storm_ext", 0.5);

      var_0 = var_1;
    }

    wait 0.5;
  }
}

_id_11242() {
  var_0 = self._id_BCB2 * self._id_BCED;

  while(!scripts\engine\utility::flag("supercell_methane_storm_end")) {
    var_0 = var_0 * 0.9975;
    var_1 = length(var_0);
    self moveTo(self.origin + var_0, 1.0);
    self._id_BCB3 = self._id_BCB3 + var_1;

    foreach(var_3 in self.fxtag) {
      var_4 = randomintrange(0, 100);

      if(var_4 <= level._id_1124C)
        thread _id_1124E(self.origin, var_3);

      if(var_3._id_12FA0 && !var_3._id_1D4D)
        thread _id_1124D(self.origin, var_3);
    }

    wait 1.01;
  }
}

_id_1124B(var_0, var_1) {
  var_2 = var_1._id_101AD * randomintrange(var_1._id_13E11 * -1, var_1._id_13E11);
  var_3 = var_1.up * (randomintrange(var_1._id_13E59 * -1, var_1._id_13E59) + var_1.yoffset);
  var_4 = var_0 + var_2 + var_3 + (0, 10000, 0);
  return var_4;
}

_id_1124E(var_0, var_1) {
  var_2 = randomintrange(var_1._id_B757, var_1._id_B489);

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = _id_1124B(var_0, var_1);

    if(isDefined(var_1._id_7640) && !var_1._id_12FA0)
      thread _id_D527(var_1._id_7640, var_4);

    playFX(var_1.fx, var_4, var_1.forward, var_1.up);
    var_5 = randomfloatrange(0.05, 0.5);
    wait(var_5);
  }
}

_id_1124D(var_0, var_1) {
  var_1._id_1D4D = 1;
  var_2 = randomfloatrange(var_1._id_1D4C, var_1._id_1D4B);
  wait(var_2);
  var_3 = _id_1124B(var_0, var_1);
  thread _id_D527(var_1._id_7640, var_3);
  _id_1124F();
  var_1._id_1D4D = 0;
}

_id_1124F() {
  var_0 = _id_11252(level._id_11254);
  var_1 = min(4, var_0.size);

  for(var_2 = 0; var_2 < var_1; var_2++)
    thread _id_D527(var_0[var_2].sound, var_0[var_2].pos);
}

_id_11250(var_0, var_1, var_2) {
  var_3 = distance2dsquared(var_2, var_0.pos);
  var_4 = distance2dsquared(var_2, var_1.pos);
  return var_3 < var_4;
}

_id_11252(var_0) {
  var_1 = level.player.origin;

  for(var_2 = 1; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    for(var_4 = var_2 - 1; var_4 >= 0; var_4--) {
      if(_id_11250(var_0[var_4], var_3, var_1)) {
        break;
      }

      var_0[var_4 + 1] = var_0[var_4];
    }

    var_0[var_4 + 1] = var_3;
  }

  return var_0;
}

_id_11251() {
  if(isDefined(level._id_11253)) {
    foreach(var_1 in level._id_11253) {
      var_1 moveTo(var_1.origin + (-250000, 0, -255000), 0.1);
      var_1 delete();
    }
  }

  level._id_11253 = undefined;
  scripts\engine\utility::flag_set("supercell_methane_storm_end");
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

  if(isDefined(var_0["frequency"]))
    self.frequency = float(var_0["frequency"]);

  if(isDefined(var_0["randomness"]))
    self._id_DCBE = float(var_0["randomness"]);

  if(isDefined(var_0["max_intensity"]))
    self.max_intensity = float(var_0["max_intensity"]);

  if(isDefined(var_0["min_intensity"]))
    self.min_intensity = float(var_0["min_intensity"]);

  if(isDefined(var_0["start_flag"]))
    self._id_10C4F = var_0["start_flag"];

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

  if(isDefined(var_0["heading"]))
    self._id_8C7B = float(var_0["heading"]);

  if(isDefined(var_0["pitch"]))
    self._id_CBE9 = float(var_0["pitch"]);

  if(isDefined(var_0["roll"]))
    self._id_E67D = float(var_0["roll"]);

  if(isDefined(var_0["frequency"]))
    self.frequency = float(var_0["frequency"]);

  if(isDefined(var_0["intensity"]))
    self._id_99E5 = float(var_0["intensity"]);

  if(isDefined(var_0["dir"]))
    self._id_54DA = float(var_0["dir"]);

  if(isDefined(var_0["start_flag"]))
    self._id_10C4F = var_0["start_flag"];

  thread _id_1021C();
}

_id_1021C() {
  scripts\engine\utility::flag_wait(self._id_10C4F);
  var_0 = self.angles;
  var_1 = 0.0;
  self setlightintensity(self._id_99E5);

  while(scripts\engine\utility::flag(self._id_10C4F)) {
    if(var_1 > 360)
      var_1 = var_1 - 360;

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
  scripts\engine\utility::flag_wait(self._id_10C4F);

  while(scripts\engine\utility::flag(self._id_10C4F)) {
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

_id_ABB5(var_0, var_1) {
  var_2 = self _meth_8134();
  var_3 = 1.0 / (var_1 / 0.2);
  var_4 = 0.0;

  while(var_4 <= 1) {
    var_4 = var_4 + var_3;
    var_5 = var_2 * (1 - var_4) + var_0 * var_4;
    self setlightintensity(var_5);
    wait 0.2;
  }
}

_id_ABB6(var_0, var_1) {
  var_2 = self _meth_8136();
  var_3 = 1.0 / (var_1 / 0.2);
  var_4 = 0.0;

  while(var_4 <= 1) {
    var_4 = var_4 + var_3;
    var_5 = var_2 * (1 - var_4) + var_0 * var_4;
    self _meth_8300(var_5);
    wait 0.2;
  }
}

_id_ABB4(var_0, var_1) {
  var_2 = self _meth_8131();
  var_3 = 1.0 / (var_1 / 0.2);
  var_4 = 0.0;

  while(var_4 <= 1) {
    var_4 = var_4 + var_3;
    var_5 = vectorlerp(var_2, var_0, var_4);
    self _meth_82FC(var_5);
    wait 0.2;
  }
}

_id_6F0D(var_0, var_1, var_2, var_3) {
  scripts\engine\utility::flag_wait(var_0);
  var_4 = getEntArray(var_1, "targetname");
  var_5 = getEnt(var_2, "targetname");
  var_6 = getEnt(var_3, "targetname");
  var_7 = [];

  for(var_8 = 0; var_8 < var_4.size; var_8++)
    var_7[var_8] = var_4[var_8] _meth_8134();

  var_9 = "on";

  while(scripts\engine\utility::flag(var_0)) {
    if(var_9 == "on") {
      foreach(var_11 in var_4)
      var_11 setlightintensity(0);

      if(isDefined(var_5) && isDefined(var_6)) {
        var_5 hide();
        var_6 show();
      }

      var_9 = "off";
    } else {
      for(var_8 = 0; var_8 < var_4.size; var_8++)
        var_4[var_8] setlightintensity(var_7[var_8]);

      if(isDefined(var_5) && isDefined(var_6)) {
        var_5 show();
        var_6 hide();
      }

      var_9 = "on";
    }

    wait(randomfloatrange(0.05, 0.3));
  }
}

_id_41EA() {
  scripts\engine\utility::flag_wait("clear_vision_set_naked");
  scripts\engine\utility::flag_wait("titan_apc_targetting_off");
  visionsetnaked("", 0.5);
  scripts\engine\utility::flag_clear("clear_vision_set_naked");
  wait 0.2;
  thread _id_41EA();
}

_id_13480(var_0, var_1, var_2) {
  scripts\engine\utility::flag_wait(var_2);
  _id_FB10(var_0, var_1);
  scripts\engine\utility::flag_clear(var_2);
  wait(var_1 + 0.05);
  thread _id_13480(var_0, var_1, var_2);
}

_id_FB10(var_0, var_1, var_2) {
  scripts\engine\utility::flag_wait("titan_apc_targetting_off");
  visionsetnaked(var_0, var_1);

  if(!isDefined(var_2))
    level._id_4BCE = var_0;
  else if(var_2)
    level._id_4BCE = var_0;
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

_id_4D65(var_0, var_1, var_2, var_3, var_4) {
  var_5 = randomfloatrange(var_3, var_4);
  earthquake(var_5, var_2, level.player.origin, 800);
  wait(var_2);

  if(var_5 > 0.2) {
    level.player _meth_8244("damage_heavy");
    wait(var_2 * 2.0);
    level.player stoprumble("damage_heavy");
  } else if(var_5 > 0.1) {
    level.player _meth_8244("damage_light");
    wait(var_2);
    level.player stoprumble("damage_light");
  }
}

_id_BBC1() {
  setsaveddvar("r_mbVelocityScale", 1);
  scripts\sp\utility::_id_AB9A("r_mbVelocityScale", 1, 0.25);
}

_id_5F7D() {
  while(scripts\engine\utility::flag("dynamic_dof_enabled")) {
    var_0 = level.player getEye();
    var_1 = anglesToForward(level.player getplayerangles());
    var_2 = physicstrace(var_0, var_0 + var_1 * 32000);
    var_3 = distance(var_2, var_0);
    var_4 = var_3 * 0.975;
    var_5 = var_4 * 20.0;
    var_6 = 3.0;
    var_7 = 0.0;
    var_8 = var_4 * 0.25;
    var_9 = 3.0;
    var_10 = 0.2;
    thread _id_0B0A::_id_583F(var_7, var_8, var_9, var_4, var_5, var_6, var_10);
    wait 0.2;
  }

  thread _id_0B0A::_id_583D(1);
}

_id_5F6E(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\engine\utility::flag_wait(var_0);

  while(scripts\engine\utility::flag(var_0)) {
    var_6 = anglesToForward(level.player getplayerangles());
    var_7 = vectordot(var_6, var_2);
    var_8 = (var_7 + 1) * 0.5;
    var_9 = pow(var_8, var_1);
    var_10 = vectorlerp((var_3, 0, 0), (var_4, 0, 0), var_9);
    setsaveddvar("sm_sunSampleSizeNear", var_10[0]);
    wait 0.1;
  }

  setsaveddvar("sm_sunSampleSizeNear", var_5);
  thread _id_5F6E(var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_D527(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_origin", var_1);
  var_5 playSound(var_0, "sounddone");

  if(isDefined(var_2))
    var_5 _meth_8277(var_2, 0);

  if(isDefined(var_3))
    var_5 _meth_8278(var_3, 0);

  if(isDefined(var_4))
    var_5 linkTo(var_4);

  var_5 waittill("sounddone");
  var_5 delete();
}

_id_96F0() {
  var_0 = scripts\engine\utility::getfx("vfx_hms_water_splash_small_01");
  var_1 = level.player getcurrentweapon();
  var_2 = level.player _meth_816D();
  var_3 = getnumparts(var_2);
  var_4 = ["j_elbow_le", "j_wrist_le", "j_metaindex_le_1", "j_metamid_le_1", "j_metapinky_le_1", "j_wristfronttwist1_le", "j_elbowdq_le", "j_elbow_ri", "j_wrist_ri", "j_gun", "j_metaindex_ri_1", "j_metamid_ri_1", "j_metapinky_ri_1", "j_metaring_ri_1", "tag_weapon_left", "tag_weapon_right"];
  var_5 = [];
  var_6 = getnumparts(level.player.model);

  for(var_7 = 0; var_7 < var_6; var_7++)
    var_5[var_7] = getpartname(level.player.model, var_7);

  for(;;) {
    var_8 = scripts\engine\utility::spawn_tag_origin();
    var_9 = "j_gun";
    var_10 = (0, 0, 0);
    var_11 = 0;

    switch (var_11) {
      case 0:
        var_9 = var_4[randomintrange(0, var_4.size)];
        break;
      case 1:
        var_9 = "j_gun";
        var_12 = randomfloatrange(9, 35);
        var_13 = randomfloatrange(-1, 1);
        var_14 = randomfloatrange(-1, 1);
        var_10 = (var_12, var_13, var_14);
        break;
    }

    var_15 = level.player gettagorigin(var_9);
    var_16 = var_15 + var_10;
    playFX(var_0, var_16);
    wait 0.2;
    var_8 delete();
  }
}