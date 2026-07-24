/*******************************************************
 * Decompiled and Edited by SyndiShanX
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
  level._id_C7B3 = getEntArray("OutOfBounds", "targetname");
  level._effect["launchSmoke"] = loadfx("vfx/iw7/core/smktrail/vfx_jackal_launch_smoke.vfx");
  level._effect["takeoffThrust2"] = loadfx("vfx/iw7/levels/mp_frontier/vfx_jkl_thrust_takeoff.vfx");
  level._effect["takeoffThrust"] = loadfx("vfx/iw7/levels/mp_frontier/vfx_jkl_boost_emit.vfx");
  level._effect["taxiThrust"] = loadfx("vfx/iw7/levels/mp_frontier/vfx_jackal_thrust_idle.vfx");
  thread _id_A3FF();
  thread _id_6F1A();
  thread _id_CDA4("mp_frontier_forest");
  scripts\mp\utility::_id_627A(1, -0.05);
  _id_1F01();
  thread _id_E837();
}

_id_1F01() {
  precachempanim("machinery_floor_panel_popup_01_raise");
}

_id_E837() {
  wait 5.0;
  thread _id_E836();
  thread _id_E834();
  thread _id_E835();
}

_id_A3FF() {
  level endon("game_ended");
  var_0 = _id_A402("jackal01");
  var_1 = _id_A402("jackal02");
  var_2 = _id_A401();
  var_2 thread _id_A400();
  var_1.origin = var_1._id_6106.origin;
  var_1.angles = var_1._id_6106.angles;
  var_1 _id_A403();

  for(;;) {
    var_0 _id_A3FE();
    level notify("elevator_open");
    wait 0.1;
    level notify("platform_raise");
    var_0 moveTo(var_0._id_6106.origin, 10, 2.5, 2.5);
    wait 10;
    var_1 _id_A3FD();
    var_0 thread _id_A403();
    wait 7;
    level notify("platform_lower");
    wait 5;
    level notify("elevator_close");
    wait 10;
    var_1 _id_A3FE();
    level notify("elevator_open");
    wait 0.1;
    level notify("platform_raise");
    var_1 moveTo(var_1._id_6106.origin, 10, 2.5, 2.5);
    wait 10;
    var_0 _id_A3FD();
    var_1 thread _id_A403();
    wait 7;
    level notify("platform_lower");
    wait 5;
    level notify("elevator_close");
    wait 10;
  }
}

_id_A403() {
  playFXOnTag(scripts\engine\utility::getfx("taxiThrust"), self, "tag_thrust_rear_le");
  playFXOnTag(scripts\engine\utility::getfx("taxiThrust"), self, "tag_thrust_rear_ri");
  thread _id_A252();
  var_0 = abs(distance(self.origin, self._id_BE1B.origin) * 0.01);
  self moveTo(self._id_BE1B.origin, var_0, 2, 0);
  wait(var_0);
  self._id_BF7A = scripts\engine\utility::getStruct(self._id_BE1B.target, "targetname");

  while(isDefined(self._id_BF7A)) {
    var_0 = abs(distance(self.origin, self._id_BF7A.origin) * 0.01);

    if(isDefined(self._id_BF7A.target)) {
      self moveTo(self._id_BF7A.origin, var_0, 0, 0);
      self rotateTo(self._id_BF7A.angles, var_0, 0, 0);
      wait(var_0);
      self._id_BF7A = scripts\engine\utility::getStruct(self._id_BF7A.target, "targetname");
      continue;
    }

    self moveTo(self._id_BF7A.origin, var_0, 0, var_0 * 0.5);
    self rotateTo(self._id_BF7A.angles, var_0, 0, var_0 * 0.5);
    wait(var_0);
    self._id_BF7A = undefined;
  }

  stopFXOnTag(scripts\engine\utility::getfx("taxiThrust"), self, "tag_thrust_rear_le");
  stopFXOnTag(scripts\engine\utility::getfx("taxiThrust"), self, "tag_thrust_rear_ri");
}

_id_A252() {
  self playsoundonmovingent("frontier_jackal_launch_01");
  wait 12.45;
  self playsoundonmovingent("frontier_jackal_launch_01b");
  wait 9.65;
  self playsoundonmovingent("frontier_jackal_launch_01c");
}

_id_6F1A() {
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
  wait 5;
  var_2 = [];
  var_2[0] = spawn("script_origin", (-1172.29, 1822.21, 560.74));
  var_2[1] = spawn("script_origin", (752.399, -1607.05, 581.218));
  var_2[2] = spawn("script_origin", (-665.927, 130.851, 666.278));
  wait 1;

  for(;;) {
    if(var_1 < var_0.size) {
      foreach(var_4 in var_2)
      var_4 playSound(var_0[var_1]);

      wait(randomfloatrange(7.5, 15.0));
      var_1 = var_1 + 1;
      continue;
    }

    var_1 = 0;
  }
}

_id_A3FD() {
  playFXOnTag(scripts\engine\utility::getfx("takeoffThrust2"), self, "tag_thrust_rear_le");
  playFXOnTag(scripts\engine\utility::getfx("takeoffThrust2"), self, "tag_thrust_rear_ri");
  self playsoundonmovingent("frontier_jackal_launch_02");
  self rotateTo(self._id_6F24.angles, 6.0, 2.5);
  self moveTo(self._id_AAA7.origin, 2.5, 0.625);
  wait 2.5;
  playFXOnTag(scripts\engine\utility::getfx("takeoffThrust"), self, "tag_thrust_rear_le");
  playFXOnTag(scripts\engine\utility::getfx("takeoffThrust"), self, "tag_thrust_rear_ri");
  self playsoundonmovingent("frontier_jackal_launch_03");
  self moveTo(self._id_6F24.origin, 3.5, 0.7);
  wait 3.5;
  self moveTo(self._id_6F26.origin, 3.5, 0.7);
  wait 3.5;
}

_id_A3FE() {
  self.origin = self.startpos.origin;
  self.angles = self.startpos.angles;
}

_id_A402(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_1.startpos = scripts\engine\utility::getStruct("jackal_startPos", "targetname");
  var_1._id_BE12 = getEnt(var_0 + "_col", "targetname");
  var_1._id_BE12 linkTo(var_1);
  var_1._id_BE12 hide();
  var_1._id_BE1D = getEnt(var_0 + "_thrusters", "targetname");
  var_1._id_BE1D linkTo(var_1);
  var_1._id_BE1D hide();
  var_1._id_6106 = scripts\engine\utility::getStruct("jackal_elevatorTopPos", "targetname");
  var_1._id_BE1B = scripts\engine\utility::getStruct(var_0 + "_path", "targetname");
  var_1._id_AAA7 = scripts\engine\utility::getStruct(var_0 + "_launch", "targetname");
  var_1._id_6F24 = scripts\engine\utility::getStruct(var_0 + "_flight", "targetname");
  var_1._id_6F26 = scripts\engine\utility::getStruct(var_0 + "_flightEnd", "targetname");
  return var_1;
}

_id_A401() {
  var_0["platform"] = getEnt("elevator_platform", "targetname");
  var_1 = scripts\engine\utility::getStruct("elevatorBot", "targetname");
  var_2 = scripts\engine\utility::getStruct("elevatorTop", "targetname");
  var_0["platform"]._id_2EEA = var_1.origin;
  var_0["platform"]._id_11A06 = var_2.origin;
  var_0["door_left"] = getEnt("elevator_doorLeft", "targetname");
  var_0["door_right"] = getEnt("elevator_doorRight", "targetname");
  var_0["door_left"].startpos = var_0["door_left"].origin;
  var_0["door_right"].startpos = var_0["door_right"].origin;
  var_3 = scripts\engine\utility::getStruct("elevatorOpenLeft", "targetname");
  var_4 = scripts\engine\utility::getStruct("elevatorOpenRight", "targetname");
  var_0["door_left"]._id_C630 = var_3.origin;
  var_0["door_right"]._id_C630 = var_4.origin;
  return var_0;
}

_id_A400() {
  level endon("game_ended");
  self["platform"] thread _id_BCB8();

  for(;;) {
    level waittill("elevator_open");
    self["door_left"] moveTo(self["door_left"]._id_C630, 2, 0.5, 0.5);
    self["door_right"] moveTo(self["door_right"]._id_C630, 2, 0.5, 0.5);
    level waittill("elevator_close");
    self["door_left"] moveTo(self["door_left"].startpos, 2, 0.5, 0.5);
    self["door_right"] moveTo(self["door_right"].startpos, 2, 0.5, 0.5);
  }
}

_id_BCB8() {
  level endon("game_ended");

  for(;;) {
    var_0 = level scripts\engine\utility::waittill_any_return("platform_raise", "platform_lower");

    if(var_0 == "platform_raise") {
      self moveTo(self._id_11A06, 10, 2.5, 2.5);
      continue;
    }

    self moveTo(self._id_2EEA, 10, 2.5, 2.5);
  }
}

_id_CDA4(var_0) {
  level scripts\engine\utility::waittill_either("allRigsBooted", "prematch_done");
  playcinematicforalllooping(var_0);
}

_id_E834() {
  level endon("game_ended");
  var_0 = getEntArray("anim_hydroponics", "targetname");

  foreach(var_2 in var_0)
  var_2 thread _id_1F9A();
}

_id_1F9A() {
  level endon("game_ended");
  var_0 = 20;

  for(;;) {
    self rotateby((0, 0, 360), var_0, 0, 0);
    wait(var_0);
  }
}

_id_E835() {
  level endon("game_ended");

  for(var_0 = 0; var_0 <= 3; var_0++) {
    var_1[var_0] = getEntArray("anim_hydroponic_pots_0" + (var_0 + 1), "script_noteworthy");
    var_2 = [];

    foreach(var_4 in var_1[var_0]) {
      if(isDefined(var_4.targetname)) {
        if(var_4.targetname == "cylinder_potted_kale_red" || var_4.targetname == "cylinder_potted_spinach" || var_4.targetname == "cylinder_potted_lettuce") {
          var_2[var_4.targetname] = var_4;
          var_2[var_4.targetname] thread _id_1F9E();
        }
      }
    }

    foreach(var_7 in var_2) {
      foreach(var_4 in var_1[var_0]) {
        if(isDefined(var_4.target))
          var_4 linkTo(var_2[var_4.target]);
      }
    }
  }
}

_id_1F9E() {
  level endon("game_ended");
  var_0 = 30;

  for(;;) {
    self rotateby((0, 360, 0), var_0, 0, 0);
    wait(var_0);
  }
}

_id_E836() {
  level endon("game_ended");
  var_0 = getscriptablearray("animating_cover", "targetname");
  var_1 = getEnt("trig_animating_cover", "targetname");

  foreach(var_3 in var_0) {
    switch (var_3.script_noteworthy) {
      case "green":
      case "red":
        var_3 thread _id_1F9B(var_1);
        break;
      case "start":
        var_3 thread _id_1F9B();
        break;
    }
  }
}

_id_1F9B(var_0) {
  if(isDefined(var_0))
    var_0 waittill("trigger");

  self playSound("frontier_cover_move_sfx");
  self setscriptablepartstate("root", "raise", 0);
}

_id_BD66() {
  precachemodel("opsmap_solar_system_large");
  level._effect["vfx_opsmap_3d_planet_sol_large"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_sun_large.vfx");
  level._effect["vfx_opsmap_3d_planet_mercury_large"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_mercury_large.vfx");
  level._effect["vfx_opsmap_3d_planet_venus_large"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_venus_large.vfx");
  level._effect["vfx_opsmap_3d_planet_earth_large"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_earth_large.vfx");
  level._effect["vfx_opsmap_3d_planet_mars_large"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_mars_large.vfx");
  level._effect["vfx_opsmap_3d_planet_jupiter_large"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_jupiter_large.vfx");
  level._effect["vfx_opsmap_3d_planet_saturn_large"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_saturn_large.vfx");
  level._effect["vfx_opsmap_3d_planet_uranus_large"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_uranus_large.vfx");
  level._effect["vfx_opsmap_3d_planet_neptune_large"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_neptune_large.vfx");
  level._effect["vfx_opsmap_3d_planet_sol_tag_large"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_sol_tag_large.vfx");
  level._effect["vfx_opsmap_3d_planet_mercury_tag_large"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_mercury_tag_large.vfx");
  level._effect["vfx_opsmap_3d_planet_venus_tag_large"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_venus_tag_large.vfx");
  level._effect["vfx_opsmap_3d_planet_earth_tag_large"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_earth_tag_large.vfx");
  level._effect["vfx_opsmap_3d_planet_mars_tag_large"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_mars_tag_large.vfx");
  level._effect["vfx_opsmap_3d_planet_jupiter_tag_large"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_jupiter_tag_large.vfx");
  level._effect["vfx_opsmap_3d_planet_saturn_tag_large"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_saturn_tag_large.vfx");
  level._effect["vfx_opsmap_3d_planet_uranus_tag_large"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_uranus_tag_large.vfx");
  level._effect["vfx_opsmap_3d_planet_neptune_tag_large"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_neptune_tag_large.vfx");
  level._effect["vfx_opsmap_3d_asteroid_cluster_large"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_asteroid_cluster_large.vfx");
  level._effect["vfx_opsmap_3d_ambient_large"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_ops_projection_under_glow_02_large.vfx");
}

_id_10CB4() {
  var_0 = scripts\engine\utility::getStruct("opsmap_org", "targetname");
  var_1 = var_0.origin + (0, 0, 48);
  var_2 = spawn("script_model", var_1);
  var_2.angles = var_0.angles;
  var_2 setModel("opsmap_solar_system_large");
  var_2 scriptmodelplayanim("opsmap_solar_system_large_idle");
  playFX(scripts\engine\utility::getfx("vfx_opsmap_3d_ambient_large"), var_1);
  wait 5;
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