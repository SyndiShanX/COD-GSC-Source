/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\rogue\rogue_lights.gsc
**************************************************/

main() {
  _id_AC23();
  thread _id_13441();
  _id_AC26();
  setsaveddvar("r_heightfieldSunShadow", 1);
  setsaveddvar("r_heightfieldSunShadowWidth", 1024);
  setsaveddvar("r_heightfieldSunShadowHeight", 1024);
  setsaveddvar("r_heightfieldSunShadowHeightBias", 0);
  setsaveddvar("r_heightfieldSunShadowDirBias", 0);
  setsaveddvar("r_heightfieldSunShadowNormBias", 0);
  setsaveddvar("r_heightfieldSunShadowFade", 175);
  setsaveddvar("r_heightfieldSunShadowBlur", 2);
  setsaveddvar("r_usePrebuiltSunShadow", 0);
}

_id_AC23() {
  scripts\engine\utility::flag_init("flag_lgt_hangar_start");
  scripts\engine\utility::flag_init("flag_lgt_dormitory_start");
  scripts\engine\utility::flag_init("flag_lgt_robot_start");
  scripts\engine\utility::flag_init("flag_lgt_depot_start");
  scripts\engine\utility::flag_init("flag_lgt_shipping_start");
  scripts\engine\utility::flag_init("flag_lgt_control_room_start");
  scripts\engine\utility::flag_init("flag_lgt_underground_start");
  scripts\engine\utility::flag_init("flag_lgt_finale_start");
  scripts\engine\utility::flag_init("flag_lgt_exfil_start");
}

_id_AC26() {
  if(!getdvarint("r_reflectionProbeGenerate")) {
    thread _id_AC3B();
    thread _id_AC38();
    thread _id_AC3D();
    thread _id_AC37();
    thread _id_AC3E();
    thread _id_AC36();
    thread _id_AC3F();
    thread _id_AC3A();
  }
}

_id_6F08(var_0, var_1, var_2, var_3) {
  self endon("stop_dynamic_light_behavior");
  self endon("death");

  if(!isDefined(var_2))
    var_2 = 0.2;

  if(!isDefined(var_3))
    var_3 = 1.5;

  var_4 = var_0;
  var_5 = 0;

  while(isDefined(self)) {
    for(var_5 = randomintrange(1, 10); var_5; var_5--) {
      wait(randomfloatrange(0.05, 0.175));

      if(var_4 > 0.2)
        var_4 = randomfloatrange(0, 0.3);
      else
        var_4 = var_0;

      self setlightintensity(var_4);
    }

    self setlightintensity(var_0);
    wait(randomfloatrange(var_2, var_3));
  }
}

_id_4CBB(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(self.script_parameters))
    var_0 = float(self.script_parameters);

  if(scripts\engine\utility::flag(var_2) == 0)
    self setlightintensity(var_1);

  while(scripts\engine\utility::flag(var_4) == 0) {
    scripts\engine\utility::flag_wait(var_2);
    thread _id_6F08(var_0 * 0.8, var_0 * 0.2);
    var_5 = randomfloatrange(0.5, 2);
    wait(var_5);
    self notify("stop_dynamic_light_behavior");
    scripts\sp\lights::_id_AB83(var_0, 0.2);
    scripts\engine\utility::flag_waitopen(var_2);
    scripts\sp\lights::_id_AB83(var_1, 1);
  }
}

_id_4CBC(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_6))
    _id_4CBB(var_0, var_1, var_2, var_3, var_4);
  else {
    if(!isDefined(var_5))
      var_5 = self _meth_8131();

    if(isDefined(self.script_parameters))
      var_0 = float(self.script_parameters);

    if(scripts\engine\utility::flag(var_2) == 0)
      self setlightintensity(var_1);

    while(scripts\engine\utility::flag(var_4) == 0) {
      scripts\engine\utility::flag_wait(var_2);
      thread _id_6F08(var_0 * 0.8, var_0 * 0.2);
      var_7 = randomfloatrange(0.5, 2);
      wait(var_7);
      self notify("stop_dynamic_light_behavior");
      scripts\sp\lights::_id_AB83(var_0, 0.2);
      self _meth_82FC(var_5);
      scripts\engine\utility::flag_waitopen(var_2);
      scripts\sp\lights::_id_AB83(var_1, 1);
      self _meth_82FC(var_6);
    }
  }
}

_id_13441() {
  if(scripts\engine\utility::flag("power_on") == 0) {
    if(scripts\engine\utility::flag("sun_vision_blend") && !scripts\engine\utility::flag("disable_alt_vision_calls"))
      visionsetalternate(1, 1.5);

    wait 0.1;
  }

  for(;;) {
    level scripts\engine\utility::waittill_any("power_on", "power_off", "disable_alt_vision_calls");

    if(scripts\engine\utility::flag("disable_alt_vision_calls")) {
      visionsetalternate(0, 1.5);
      scripts\engine\utility::flag_waitopen("disable_alt_vision_calls");
      continue;
    }

    if(scripts\engine\utility::flag("sun_vision_blend") && scripts\engine\utility::flag("power_on")) {
      visionsetalternate(0, 1.5);
      continue;
    }

    if(scripts\engine\utility::flag("sun_vision_blend") && scripts\engine\utility::flag("power_off"))
      visionsetalternate(1, 1.5);
  }
}

_id_4CCA(var_0, var_1, var_2) {
  while(scripts\engine\utility::flag(var_2) == 0) {
    scripts\engine\utility::flag_wait(var_0);
    self setscriptablepartstate("tv_model", 0);
    scripts\engine\utility::flag_waitopen(var_0);
    self setscriptablepartstate("tv_model", 1);
  }
}

_id_AC3C() {}

_id_AC3B() {
  scripts\engine\utility::flag_wait("flag_lgt_hangar_start");
  var_0 = getEntArray("lgt_hangar_main", "script_noteworthy");
  var_1 = getEntArray("lgt_surface_stations", "script_noteworthy");
  wait 2;
  scripts\engine\utility::array_thread(var_0, ::_id_4CBB, 3, 0, "power_on", "power_off", "flag_lgt_dormitory_start");
  scripts\engine\utility::array_thread(var_1, ::_id_4CBB, 4, 0, "power_on", "power_off", "flag_lgt_dormitory_start");
  scripts\engine\utility::flag_wait("flag_lgt_dormitory_start");
}

_id_AC38() {
  scripts\engine\utility::flag_wait("flag_lgt_dormitory_start");
  var_0 = getEntArray("lgt_dorm_rooms", "script_noteworthy");
  var_1 = getEntArray("lgt_dorm_hallway", "script_noteworthy");
  var_2 = getEntArray("lgt_dorm_emergency", "script_noteworthy");
  var_3 = getEntArray("lgt_dorm_floor", "script_noteworthy");
  wait 2;
  scripts\engine\utility::array_thread(var_0, ::_id_4CBB, 2, 0, "power_on", "power_off", "flag_lgt_robot_start");
  scripts\engine\utility::array_thread(var_1, ::_id_4CBB, 4, 0, "power_on", "power_off", "flag_lgt_robot_start");
  scripts\engine\utility::array_thread(var_2, ::_id_4CBB, 0.5, 0, "power_off", "power_on", "flag_lgt_robot_start");
  scripts\engine\utility::array_thread(var_3, ::_id_4CBC, 0.5, 0, "power_off", "power_on", "flag_lgt_robot_start", undefined, (0.984314, 0.294118, 0.121569));
  var_4 = getEnt("dorm_tv_model", "targetname");

  if(isDefined(var_4))
    var_4 thread _id_4CCA("power_on", "power_off", "flag_lgt_robot_start");

  scripts\engine\utility::flag_wait("flag_lgt_robot_start");
}

_id_AC3D() {
  scripts\engine\utility::flag_wait("flag_lgt_robot_start");
  var_0 = getEntArray("lgt_robot_hallway", "script_noteworthy");
  var_1 = getEntArray("lgt_robot_emergency", "script_noteworthy");
  wait 2;
  scripts\engine\utility::array_thread(var_1, ::_id_4CBB, 0.5, 0, "power_off", "power_on", "flag_lgt_shipping_start");
  scripts\engine\utility::array_thread(var_0, ::_id_4CBB, 8, 0, "power_on", "power_off", "flag_lgt_shipping_start");
  scripts\engine\utility::flag_wait("flag_lgt_depot_start");
}

_id_AC37() {
  scripts\engine\utility::flag_wait("flag_lgt_depot_start");
  var_0 = getEntArray("lgt_robot_hallway", "script_noteworthy");
  var_1 = getEntArray("lgt_robot_emergency", "script_noteworthy");
  var_2 = getEntArray("lgt_depot_track", "script_noteworthy");
  var_3 = getEntArray("lgt_depot_hallway", "script_noteworthy");
  var_4 = getEntArray("lgt_depot_stair", "script_noteworthy");
  wait 2;
  scripts\engine\utility::array_thread(var_1, ::_id_4CBB, 0.5, 0, "power_off", "power_on", "flag_lgt_shipping_start");
  scripts\engine\utility::array_thread(var_0, ::_id_4CBB, 8, 0, "power_on", "power_off", "flag_lgt_shipping_start");
  scripts\engine\utility::array_thread(var_2, ::_id_4CBB, 5, 0, "power_on", "power_off", "flag_lgt_shipping_start");
  scripts\engine\utility::array_thread(var_3, ::_id_4CBB, 8, 0, "power_on", "power_off", "flag_lgt_shipping_start");
  scripts\engine\utility::array_thread(var_4, ::_id_4CBB, 5, 0, "power_on", "power_off", "flag_lgt_shipping_start");
  scripts\engine\utility::flag_wait("flag_lgt_shipping_start");
}

_id_AC3E() {
  scripts\engine\utility::flag_wait("flag_lgt_shipping_start");
  var_0 = getEntArray("lgt_shipping_start", "script_noteworthy");
  var_1 = getEntArray("lgt_shipping_emergency", "script_noteworthy");
  wait 2;
  scripts\engine\utility::array_thread(var_1, ::_id_4CBB, 0.5, 0, "power_off", "power_on", "flag_lgt_control_room_start");
  scripts\engine\utility::array_thread(var_0, ::_id_4CBB, 6, 0, "power_on", "power_off", "flag_lgt_control_room_start");
  scripts\engine\utility::flag_wait("flag_lgt_control_room_start");
}

_id_AC36() {
  scripts\engine\utility::flag_wait("flag_lgt_control_room_start");
  var_0 = getEntArray("lgt_control_room_start", "script_noteworthy");
  var_1 = getEntArray("lgt_underground_emergency", "script_noteworthy");
  wait 2;
  scripts\engine\utility::array_thread(var_0, ::_id_4CBB, 6, 0, "power_on", "power_off", "flag_lgt_underground_start");
  scripts\engine\utility::array_thread(var_1, ::_id_4CBB, 2.5, 0, "power_off", "power_on", "flag_lgt_finale_start");
  scripts\engine\utility::flag_wait("flag_lgt_underground_start");
}

_id_AC3F() {
  scripts\engine\utility::flag_wait("flag_lgt_underground_start");
  var_0 = getEntArray("lgt_underground_start", "script_noteworthy");
  wait 2;
  scripts\engine\utility::array_thread(var_0, ::_id_4CBB, 16, 0.01, "power_on", "power_off", "flag_lgt_finale_start");
  scripts\engine\utility::flag_wait("flag_lgt_finale_start");
}

_id_AC3A() {
  scripts\engine\utility::flag_wait("flag_lgt_finale_start");
  var_0 = getEntArray("lgt_finale", "script_noteworthy");
  var_1 = getEntArray("lgt_finale_emergency", "script_noteworthy");
  wait 2;
  scripts\engine\utility::array_thread(var_0, ::_id_4CBB, 5.4, 0.01, "power_on", "power_off", "flag_lgt_exfil_start");
  scripts\engine\utility::array_thread(var_1, ::_id_4CBB, 0.01, 2, "power_on", "power_off", "flag_lgt_exfil_start");
  scripts\engine\utility::flag_wait("flag_lgt_exfil_start");
}

_id_AC39() {}