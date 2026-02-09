/*******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_frontier\mp_frontier.gsc
*******************************************************/

main() {
  scripts\mp\maps\mp_frontier\mp_frontier_precache::main();
  scripts\mp\maps\mp_frontier\gen\mp_frontier_art::main();
  scripts\mp\maps\mp_frontier\mp_frontier_fx::main();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_frontier");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_volumetrics", 0);
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.var_C7B3 = getEntArray("OutOfBounds", "targetname");
  level._effect["launchSmoke"] = loadfx("vfx\iw7\core\smktrail\vfx_jackal_launch_smoke.vfx");
  level._effect["takeoffThrust2"] = loadfx("vfx\iw7\levels\mp_frontier\vfx_jkl_thrust_takeoff.vfx");
  level._effect["takeoffThrust"] = loadfx("vfx\iw7\levels\mp_frontier\vfx_jkl_boost_emit.vfx");
  level._effect["taxiThrust"] = loadfx("vfx\iw7\levels\mp_frontier\vfx_jackal_thrust_idle.vfx");
  thread fix_collision();
  thread func_A3FF();
  thread func_6F1A();
  thread func_CDA4("mp_frontier_forest");
  scripts\mp\utility::func_627A(1, -0.05);
  func_1F01();
  thread func_E837();
  runmodespecifictriggers();
}

fix_collision() {
  var_0 = spawn("script_model", (-256, -1336, 745));
  var_0.angles = (0, 0, -90);
  var_0 setModel("beacon_metal_panel_wall_quad_mp_frontier_patch");
  var_1 = spawn("script_model", (-256, -1336, 745));
  var_1.angles = (0, 0, 90);
  var_1 setModel("beacon_metal_panel_wall_quad_mp_frontier_patch");
  var_2 = spawn("script_model", (-256, -1432, 745));
  var_2.angles = (0, 0, -90);
  var_2 setModel("beacon_metal_panel_wall_double_mp_frontier_patch");
  var_3 = spawn("script_model", (-256, -1432, 745));
  var_3.angles = (0, 0, 90);
  var_3 setModel("beacon_metal_panel_wall_double_mp_frontier_patch");
  var_4 = getent("player512x512x8", "targetname");
  var_5 = spawn("script_model", (416, -72, 768));
  var_5.angles = (0, 0, 90);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = spawn("trigger_radius", (0, 0, 800), 0, 2500, 128);
  var_6.fgetarg = 2500;
  var_6.height = 128;
  var_6 thread kill_trigger_loop("script_vehicle");
  var_7 = getent("clip512x512x8", "targetname");
  var_8 = spawn("script_model", (0, 592, 240));
  var_8.angles = (0, 0, -90);
  var_8 clonebrushmodeltoscriptmodel(var_7);
  var_9 = spawn("script_model", (774, -1082, 502));
  var_9.angles = (0, 90, 0);
  var_9 setModel("building_support_steel_beam_04_mp_frontier_patch");
}

kill_trigger_loop(var_0) {
  for(;;) {
    self waittill("trigger", var_1);
    if(isDefined(var_1) && isDefined(var_1.classname) && var_1.classname == var_0) {
      if(isDefined(var_1.streakname)) {
        if(var_1.streakname == "minijackal") {
          var_1 notify("minijackal_end");
          continue;
        }

        if(var_1.streakname == "venom") {
          var_1 notify("venom_end", var_1.origin);
        }
      }
    }
  }
}

func_1F01() {
  precachempanim("machinery_floor_panel_popup_01_raise");
}

func_E837() {
  wait(5);
  thread func_E836();
  thread func_E834();
  thread func_E835();
}

func_A3FF() {
  level endon("game_ended");
  var_0 = func_A402("jackal01");
  var_1 = func_A402("jackal02");
  var_2 = func_A401();
  var_2 thread func_A400();
  var_1.origin = var_1.var_6106.origin;
  var_1.angles = var_1.var_6106.angles;
  var_1 func_A403();
  var_0 func_A3FE();
  for(;;) {
    level notify("elevator_open");
    wait(0.1);
    level notify("platform_raise");
    var_0 moveto(var_0.var_6106.origin, 10, 2.5, 2.5);
    wait(10);
    var_1 func_A3FD();
    var_0 thread func_A403();
    var_1 func_A3FE();
    wait(7);
    level notify("platform_lower");
    wait(5);
    level notify("elevator_close");
    wait(10);
    level notify("elevator_open");
    wait(0.1);
    level notify("platform_raise");
    var_1 moveto(var_1.var_6106.origin, 10, 2.5, 2.5);
    wait(10);
    var_0 func_A3FD();
    var_0 func_A3FE();
    var_1 thread func_A403();
    wait(7);
    level notify("platform_lower");
    wait(5);
    level notify("elevator_close");
    wait(10);
  }
}

func_A403() {
  playFXOnTag(scripts\engine\utility::getfx("taxiThrust"), self, "tag_thrust_rear_le");
  playFXOnTag(scripts\engine\utility::getfx("taxiThrust"), self, "tag_thrust_rear_ri");
  thread func_A252();
  var_0 = abs(distance(self.origin, self.var_BE1B.origin) * 0.01);
  self moveto(self.var_BE1B.origin, var_0, 2, 0);
  wait(var_0);
  self.var_BF7A = scripts\engine\utility::getstruct(self.var_BE1B.target, "targetname");
  while(isDefined(self.var_BF7A)) {
    var_0 = abs(distance(self.origin, self.var_BF7A.origin) * 0.01);
    if(isDefined(self.var_BF7A.target)) {
      self moveto(self.var_BF7A.origin, var_0, 0, 0);
      self rotateto(self.var_BF7A.angles, var_0, 0, 0);
      wait(var_0);
      self.var_BF7A = scripts\engine\utility::getstruct(self.var_BF7A.target, "targetname");
      continue;
    }

    self moveto(self.var_BF7A.origin, var_0, 0, var_0 * 0.5);
    self rotateto(self.var_BF7A.angles, var_0, 0, var_0 * 0.5);
    wait(var_0);
    self.var_BF7A = undefined;
  }

  stopFXOnTag(scripts\engine\utility::getfx("taxiThrust"), self, "tag_thrust_rear_le");
  stopFXOnTag(scripts\engine\utility::getfx("taxiThrust"), self, "tag_thrust_rear_ri");
}

func_A252() {
  self playsoundonmovingent("frontier_jackal_launch_01");
  wait(12.45);
  self playsoundonmovingent("frontier_jackal_launch_01b");
  wait(9.65);
  self playsoundonmovingent("frontier_jackal_launch_01c");
}

func_6F1A() {
  var_0 = [];
  var_0[0] = "emt_frontier_control_vo_1";
  var_0[1] = "emt_frontier_control_vo_2";
  var_0[2] = "emt_frontier_control_vo_3";
  var_0[3] = "emt_frontier_control_vo_4";
  var_0[4] = "emt_frontier_control_vo_5";
  var_0[5] = "emt_frontier_control_vo_6";
  var_0[6] = "emt_frontier_control_vo_7";
  var_0[7] = "emt_frontier_control_vo_8";
  var_0[8] = "emt_frontier_control_vo_9";
  var_0[9] = "emt_frontier_control_vo_10";
  var_0[10] = "emt_frontier_control_vo_11";
  var_0[11] = "emt_frontier_control_vo_12";
  var_0[12] = "emt_frontier_control_vo_13";
  var_0[13] = "emt_frontier_control_vo_14";
  var_0[14] = "emt_frontier_control_vo_15";
  var_0[15] = "emt_frontier_control_vo_16";
  var_0[16] = "emt_frontier_control_vo_17";
  var_0[17] = "emt_frontier_control_vo_18";
  var_0[18] = "emt_frontier_control_vo_19";
  var_1 = 0;
  wait(5);
  var_2 = [];
  var_2[0] = spawn("script_origin", (-1172.29, 1822.21, 560.74));
  var_2[1] = spawn("script_origin", (752.399, -1607.05, 581.218));
  var_2[2] = spawn("script_origin", (-665.927, 130.851, 666.278));
  wait(1);
  for(;;) {
    if(var_1 < var_0.size) {
      foreach(var_4 in var_2) {
        var_4 playSound(var_0[var_1]);
      }

      wait(randomfloatrange(7.5, 15));
      var_1 = var_1 + 1;
      continue;
    }

    var_1 = 0;
  }
}

func_A3FD() {
  playFXOnTag(scripts\engine\utility::getfx("takeoffThrust2"), self, "tag_thrust_rear_le");
  playFXOnTag(scripts\engine\utility::getfx("takeoffThrust2"), self, "tag_thrust_rear_ri");
  self playsoundonmovingent("frontier_jackal_launch_02");
  self rotateto(self.var_6F24.angles, 6, 2.5);
  self moveto(self.var_AAA7.origin, 2.5, 0.625);
  wait(2.5);
  playFXOnTag(scripts\engine\utility::getfx("takeoffThrust"), self, "tag_thrust_rear_le");
  playFXOnTag(scripts\engine\utility::getfx("takeoffThrust"), self, "tag_thrust_rear_ri");
  self playsoundonmovingent("frontier_jackal_launch_03");
  self moveto(self.var_6F24.origin, 3.5, 0.7);
  wait(3.5);
  playFXOnTag(scripts\engine\utility::getfx("takeoffThrust"), self, "tag_thrust_rear_le");
  playFXOnTag(scripts\engine\utility::getfx("takeoffThrust"), self, "tag_thrust_rear_ri");
  self moveto(self.var_6F26.origin, 3.5, 0.7);
  wait(3.5);
}

func_A3FE() {
  self.origin = self.areanynavvolumesloaded.origin;
  self.angles = self.areanynavvolumesloaded.angles;
}

func_A402(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1.areanynavvolumesloaded = scripts\engine\utility::getstruct("jackal_startPos", "targetname");
  var_1.var_BE12 = getent(var_0 + "_col", "targetname");
  var_1.var_BE12 linkto(var_1);
  var_1.var_BE12 hide();
  var_1.var_BE1D = getent(var_0 + "_thrusters", "targetname");
  var_1.var_BE1D linkto(var_1);
  var_1.var_BE1D hide();
  var_1.var_6106 = scripts\engine\utility::getstruct("jackal_elevatorTopPos", "targetname");
  var_1.var_BE1B = scripts\engine\utility::getstruct(var_0 + "_path", "targetname");
  var_1.var_AAA7 = scripts\engine\utility::getstruct(var_0 + "_launch", "targetname");
  var_1.var_6F24 = scripts\engine\utility::getstruct(var_0 + "_flight", "targetname");
  var_1.var_6F26 = scripts\engine\utility::getstruct(var_0 + "_flightEnd", "targetname");
  return var_1;
}

func_A401() {
  var_0["platform"] = getent("elevator_platform", "targetname");
  var_1 = scripts\engine\utility::getstruct("elevatorBot", "targetname");
  var_2 = scripts\engine\utility::getstruct("elevatorTop", "targetname");
  var_0["platform"].var_2EEA = var_1.origin;
  var_0["platform"].var_11A06 = var_2.origin;
  var_0["door_left"] = getent("elevator_doorLeft", "targetname");
  var_0["door_right"] = getent("elevator_doorRight", "targetname");
  var_0["door_left"].areanynavvolumesloaded = var_0["door_left"].origin;
  var_0["door_right"].areanynavvolumesloaded = var_0["door_right"].origin;
  var_3 = scripts\engine\utility::getstruct("elevatorOpenLeft", "targetname");
  var_4 = scripts\engine\utility::getstruct("elevatorOpenRight", "targetname");
  var_0["door_left"].var_C630 = var_3.origin;
  var_0["door_right"].var_C630 = var_4.origin;
  return var_0;
}

func_A400() {
  level endon("game_ended");
  self["platform"] thread func_BCB8();
  for(;;) {
    level waittill("elevator_open");
    self["door_left"] moveto(self["door_left"].var_C630, 2, 0.5, 0.5);
    self["door_right"] moveto(self["door_right"].var_C630, 2, 0.5, 0.5);
    level waittill("elevator_close");
    self["door_left"] moveto(self["door_left"].areanynavvolumesloaded, 2, 0.5, 0.5);
    self["door_right"] moveto(self["door_right"].areanynavvolumesloaded, 2, 0.5, 0.5);
  }
}

func_BCB8() {
  level endon("game_ended");
  for(;;) {
    var_0 = level scripts\engine\utility::waittill_any_return("platform_raise", "platform_lower");
    if(var_0 == "platform_raise") {
      self moveto(self.var_11A06, 10, 2.5, 2.5);
      continue;
    }

    self moveto(self.var_2EEA, 10, 2.5, 2.5);
  }
}

func_CDA4(var_0) {
  wait(30);
  playcinematicforalllooping(var_0);
}

func_E834() {
  level endon("game_ended");
  var_0 = getEntArray("anim_hydroponics", "targetname");
  foreach(var_2 in var_0) {
    var_2 thread func_1F9A();
  }
}

func_1F9A() {
  level endon("game_ended");
  var_0 = 20;
  for(;;) {
    self ghost_killed_update_func((0, 0, 360), var_0, 0, 0);
    wait(var_0);
  }
}

func_E835() {
  level endon("game_ended");
  for(var_0 = 0; var_0 <= 3; var_0++) {
    var_1[var_0] = getEntArray("anim_hydroponic_pots_0" + var_0 + 1, "script_noteworthy");
    var_2 = [];
    foreach(var_4 in var_1[var_0]) {
      if(isDefined(var_4.var_336)) {
        if(var_4.var_336 == "cylinder_potted_kale_red" || var_4.var_336 == "cylinder_potted_spinach" || var_4.var_336 == "cylinder_potted_lettuce") {
          var_2[var_4.var_336] = var_4;
          var_2[var_4.var_336] thread func_1F9E();
        }
      }
    }

    foreach(var_7 in var_2) {
      foreach(var_4 in var_1[var_0]) {
        if(isDefined(var_4.target)) {
          var_4 linkto(var_2[var_4.target]);
        }
      }
    }
  }
}

func_1F9E() {
  level endon("game_ended");
  var_0 = 30;
  for(;;) {
    self ghost_killed_update_func((0, 360, 0), var_0, 0, 0);
    wait(var_0);
  }
}

func_E836() {
  level endon("game_ended");
  var_0 = getscriptablearray("animating_cover", "targetname");
  var_1 = getent("trig_animating_cover", "targetname");
  foreach(var_3 in var_0) {
    switch (var_3.script_noteworthy) {
      case "green":
      case "red":
        var_3 thread func_1F9B(var_1);
        break;

      case "start":
        var_3 thread func_1F9B();
        break;
    }
  }
}

func_1F9B(var_0) {
  if(isDefined(var_0)) {
    var_0 waittill("trigger");
  }

  self playSound("frontier_cover_move_sfx");
  self setscriptablepartstate("root", "raise", 0);
}

func_BD66() {
  precachemodel("opsmap_solar_system_large");
  level._effect["vfx_opsmap_3d_planet_sol_large"] = loadfx("vfx\iw7\levels\ship_crib\ops_table\vfx_opsmap_3d_solarsystem_sun_large.vfx");
  level._effect["vfx_opsmap_3d_planet_mercury_large"] = loadfx("vfx\iw7\levels\ship_crib\ops_table\vfx_opsmap_3d_solarsystem_mercury_large.vfx");
  level._effect["vfx_opsmap_3d_planet_venus_large"] = loadfx("vfx\iw7\levels\ship_crib\ops_table\vfx_opsmap_3d_solarsystem_venus_large.vfx");
  level._effect["vfx_opsmap_3d_planet_earth_large"] = loadfx("vfx\iw7\levels\ship_crib\ops_table\vfx_opsmap_3d_solarsystem_earth_large.vfx");
  level._effect["vfx_opsmap_3d_planet_mars_large"] = loadfx("vfx\iw7\levels\ship_crib\ops_table\vfx_opsmap_3d_solarsystem_mars_large.vfx");
  level._effect["vfx_opsmap_3d_planet_jupiter_large"] = loadfx("vfx\iw7\levels\ship_crib\ops_table\vfx_opsmap_3d_solarsystem_jupiter_large.vfx");
  level._effect["vfx_opsmap_3d_planet_saturn_large"] = loadfx("vfx\iw7\levels\ship_crib\ops_table\vfx_opsmap_3d_solarsystem_saturn_large.vfx");
  level._effect["vfx_opsmap_3d_planet_uranus_large"] = loadfx("vfx\iw7\levels\ship_crib\ops_table\vfx_opsmap_3d_solarsystem_uranus_large.vfx");
  level._effect["vfx_opsmap_3d_planet_neptune_large"] = loadfx("vfx\iw7\levels\ship_crib\ops_table\vfx_opsmap_3d_solarsystem_neptune_large.vfx");
  level._effect["vfx_opsmap_3d_planet_sol_tag_large"] = loadfx("vfx\iw7\core\ui\vfx_ui_opsmap_sol_tag_large.vfx");
  level._effect["vfx_opsmap_3d_planet_mercury_tag_large"] = loadfx("vfx\iw7\core\ui\vfx_ui_opsmap_mercury_tag_large.vfx");
  level._effect["vfx_opsmap_3d_planet_venus_tag_large"] = loadfx("vfx\iw7\core\ui\vfx_ui_opsmap_venus_tag_large.vfx");
  level._effect["vfx_opsmap_3d_planet_earth_tag_large"] = loadfx("vfx\iw7\core\ui\vfx_ui_opsmap_earth_tag_large.vfx");
  level._effect["vfx_opsmap_3d_planet_mars_tag_large"] = loadfx("vfx\iw7\core\ui\vfx_ui_opsmap_mars_tag_large.vfx");
  level._effect["vfx_opsmap_3d_planet_jupiter_tag_large"] = loadfx("vfx\iw7\core\ui\vfx_ui_opsmap_jupiter_tag_large.vfx");
  level._effect["vfx_opsmap_3d_planet_saturn_tag_large"] = loadfx("vfx\iw7\core\ui\vfx_ui_opsmap_saturn_tag_large.vfx");
  level._effect["vfx_opsmap_3d_planet_uranus_tag_large"] = loadfx("vfx\iw7\core\ui\vfx_ui_opsmap_uranus_tag_large.vfx");
  level._effect["vfx_opsmap_3d_planet_neptune_tag_large"] = loadfx("vfx\iw7\core\ui\vfx_ui_opsmap_neptune_tag_large.vfx");
  level._effect["vfx_opsmap_3d_asteroid_cluster_large"] = loadfx("vfx\iw7\levels\ship_crib\ops_table\vfx_opsmap_asteroid_cluster_large.vfx");
  level._effect["vfx_opsmap_3d_ambient_large"] = loadfx("vfx\iw7\levels\ship_crib\ops_table\vfx_ops_projection_under_glow_02_large.vfx");
}

func_10CB4() {
  var_0 = scripts\engine\utility::getstruct("opsmap_org", "targetname");
  var_1 = var_0.origin + (0, 0, 48);
  var_2 = spawn("script_model", var_1);
  var_2.angles = var_0.angles;
  var_2 setModel("opsmap_solar_system_large");
  var_2 scriptmodelplayanim("opsmap_solar_system_large_idle");
  playFX(scripts\engine\utility::getfx("vfx_opsmap_3d_ambient_large"), var_1);
  wait(5);
  scripts\engine\utility::waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"), var_2, "tag_asteroid_1");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"), var_2, "tag_asteroid_2");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"), var_2, "tag_asteroid_3");
  scripts\engine\utility::waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"), var_2, "tag_asteroid_4");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"), var_2, "tag_asteroid_5");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"), var_2, "tag_asteroid_6");
  scripts\engine\utility::waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"), var_2, "tag_asteroid_7");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"), var_2, "tag_asteroid_8");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"), var_2, "tag_asteroid_9");
  scripts\engine\utility::waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"), var_2, "tag_asteroid_10");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"), var_2, "tag_asteroid_11");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"), var_2, "tag_asteroid_12");
  scripts\engine\utility::waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"), var_2, "tag_asteroid_13");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"), var_2, "tag_asteroid_14");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"), var_2, "tag_asteroid_15");
  scripts\engine\utility::waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"), var_2, "tag_asteroid_16");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_sol_tag_large"), var_2, "tag_planet_sun");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_mercury_tag_large"), var_2, "tag_planet_mercury");
  scripts\engine\utility::waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_venus_tag_large"), var_2, "tag_planet_venus");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_earth_tag_large"), var_2, "tag_planet_earth");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_mars_tag_large"), var_2, "tag_planet_mars");
  scripts\engine\utility::waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_jupiter_tag_large"), var_2, "tag_planet_jupiter");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_saturn_tag_large"), var_2, "tag_planet_saturn");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_uranus_tag_large"), var_2, "tag_planet_uranus");
  scripts\engine\utility::waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_neptune_tag_large"), var_2, "tag_planet_neptune");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_sol_large"), var_2, "tag_planet_sun");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_mercury_large"), var_2, "tag_planet_mercury");
  scripts\engine\utility::waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_venus_large"), var_2, "tag_planet_venus");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_earth_large"), var_2, "tag_planet_earth");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_mars_large"), var_2, "tag_planet_mars");
  scripts\engine\utility::waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_jupiter_large"), var_2, "tag_planet_jupiter");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_saturn_large"), var_2, "tag_planet_saturn");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_uranus_large"), var_2, "tag_planet_uranus");
  scripts\engine\utility::waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_neptune_large"), var_2, "tag_planet_neptune");
}

runmodespecifictriggers() {
  if(level.gametype == "ball" || level.gametype == "tdef") {
    var_0 = spawn("trigger_radius", (48, 1848, 716), 0, 75, 80);
    var_0.var_336 = "uplink_nozone";
    var_0 hide();
  }
}