/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_moon\sa_moon_lighting.gsc
********************************************************/

main() {
  thread _id_F969();
  thread _id_BB20();
  thread _id_BB21();
  thread _id_BB1D();
  thread _id_DC76();
  thread _id_DC78();
  thread _id_DC79();
  thread _id_DC7A();
}

_id_E9C9() {
  setsaveddvar("sm_sunSampleSizeNear", 3.0);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 3);
  setsaveddvar("sm_sunCascadeSizeMultiplier2", 2);
  setsaveddvar("sm_spotUpdateLimit", 16);
  setsaveddvar("sm_roundRobinPrioritySpotShadows", 8);
  setsaveddvar("r_umbraShadowCasters", 1);
  scripts\engine\utility::flag_wait("samuels_jackal_down");
  setsaveddvar("sm_sunSampleSizeNear", 0.65);
  wait 2;
}

_id_30A9() {
  var_0 = getEnt("bridge_screen_flicker_light", "targetname");
  var_1 = getEnt("bridge_screen_flicker_light_02", "targetname");
  var_2 = 12;
  level endon("death");
  level endon("maintenance_begin");
  wait 3;

  for(;;) {
    var_3 = randomintrange(25, 30);
    var_4 = randomfloatrange(0.05, 0.25);
    wait 0.05;
    var_0 thread _id_30AA(var_3, var_2, var_4);
    var_1 thread _id_30AA(var_3, var_2, var_4);
    level waittill("flicker_lights_done");
    wait 0.05;
  }
}

_id_30AA(var_0, var_1, var_2) {
  while(var_1 > 0) {
    self setlightintensity(var_0);
    self _meth_82FC((1, 0.7, 0.31));
    wait(var_2);
    self setlightintensity(4);
    self _meth_82FC((1, 0.65, 0.35));
    wait 0.05;
    var_1 = var_1 - 1;
  }

  level notify("flicker_lights_done");
}

_id_F423() {
  setsunlight(0, 0, 0);
  visionsetalternate(1, 1.5);
  scripts\engine\utility::flag_wait("turkeyshoot_over");
  resetsunlight();
}

_id_BB20() {
  var_0 = getEnt("vision_interior_02", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_0 waittill("trigger");
  visionsetalternate(4, 2);
}

_id_BB21() {
  var_0 = getEnt("vision_interior_03", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_0 waittill("trigger");
  visionsetalternate(5, 2);
}

_id_F969() {
  scripts\engine\utility::flag_wait("player_jackal_grapple");
  setsaveddvar("sm_sunSampleSizeNear", 5.0);
  visionsetalternate(3, 3);
  wait 4;
  visionsetnaked("sa_moon_exfil_dark", 3);
  wait 3;
  scripts\engine\utility::flag_wait("lighting_sun_explosion");
  wait 3;
  wait 3;
  visionsetnaked("sa_moon_exfil_dark", 2);
}

_id_611A(var_0) {
  var_1 = getEntArray("cargobay_warning_light", "targetname");

  foreach(var_3 in var_1) {
    if(var_0 == 1) {
      var_3 _id_6119("on");
      continue;
    }

    var_3 _id_6119("off");
  }
}

_id_6EBB() {
  level endon("player_in_exfil_jackal");
  var_0 = getEntArray("light_blink_exfil", "targetname");

  for(;;) {
    var_1 = randomintrange(500, 850);
    var_2 = randomfloatrange(0.05, 0.07);
    var_3 = randomfloatrange(0.6, 0.65);
    scripts\engine\utility::array_thread(var_0, ::_id_611B, var_1, var_2);
    wait(var_3 + 0.05);
  }
}

_id_611B(var_0, var_1, var_2) {
  var_3 = getEntArray("bay_on_light", "targetname");
  var_4 = getEntArray("bay_off_light", "targetname");

  if(!var_3.size || !var_4.size) {
    return;
  }
  self setlightintensity(var_0);
  scripts\engine\utility::array_thread(var_3, ::_id_611D);
  scripts\engine\utility::array_thread(var_4, ::_id_611C);
  wait(var_1);
  self setlightintensity(0);
  scripts\engine\utility::array_thread(var_3, ::_id_611C);
  scripts\engine\utility::array_thread(var_4, ::_id_611D);
}

_id_611C() {
  self hide();
}

_id_611D() {
  self show();
}

_id_5D1D() {
  level endon("player_in_exfil_jackal");
  var_0 = 0.01;
  var_1 = 30;
  var_2 = 0.9;

  for(;;) {
    scripts\engine\utility::array_thread(getEntArray("light_exfil_1", "targetname"), ::_id_AC28, var_0, var_1, var_2);
    wait 0.3;
    scripts\engine\utility::array_thread(getEntArray("light_exfil_2", "targetname"), ::_id_AC28, var_0, var_1, var_2);
    wait 0.3;
    scripts\engine\utility::array_thread(getEntArray("light_exfil_3", "targetname"), ::_id_AC28, var_0, var_1, var_2);
    wait 0.3;
    scripts\engine\utility::array_thread(getEntArray("light_exfil_4", "targetname"), ::_id_AC28, var_0, var_1, var_2);
    wait 0.3;
    scripts\engine\utility::array_thread(getEntArray("light_exfil_5", "targetname"), ::_id_AC28, var_0, var_1, var_2);
    wait 0.3;
    scripts\engine\utility::array_thread(getEntArray("light_exfil_6", "targetname"), ::_id_AC28, var_0, var_1, var_2);
    wait 0.3;
  }
}

_id_AC28(var_0, var_1, var_2) {
  var_3 = var_2 * 20;
  var_4 = (var_1 - var_0) / var_3;

  for(var_5 = 0; var_5 < var_3; var_5 = var_5 + 1) {
    self setlightintensity(var_1 - var_5 * var_4);
    wait 0.05;
  }

  self setlightintensity(var_0);
}

_id_6119(var_0) {
  if(var_0 == "on") {
    if(isDefined(self.script_noteworthy) && self.script_noteworthy == "warningflash_player") {
      thread _id_611F(0, 40, 10, 50);
    }

    thread _id_611F(0, 450, 55, 500);
  } else {
    self notify("stop_emergency_lightstrobe");
    wait 0.05;
    self setlightintensity(0);
  }
}

_id_611F(var_0, var_1, var_2, var_3) {
  self endon("stop_emergency_lightstrobe");
  var_4 = 10;
  var_5 = 360 / var_4;
  var_6 = 0;

  for(;;) {
    self setlightintensity(var_0);
    thread _id_138F3(0);
    wait 1;
    var_7 = sin(var_6 * var_5) * 0.5 + 0.5;
    self setlightintensity(var_2 + (var_3 - var_2) * var_7);
    wait 0.05;
    var_6 = var_6 + 10;

    if(var_6 > var_4) {
      var_6 = var_6 - var_4;
    }

    wait 0.05;
    self setlightintensity(var_1);
    thread _id_138F3(1);
    wait 0.1;
  }
}

_id_138F3(var_0) {
  var_1 = getEntArray("exfil_warning_light_on", "targetname");

  foreach(var_3 in var_1) {
    if(var_0 == 0) {
      var_3 hide();
      continue;
    }

    var_3 show();
  }
}

_id_DC76() {
  var_0 = getEnt("high_flicker_light", "targetname");
  var_1 = randomintrange(80, 125);
  var_2 = 1;
  var_3 = getEnt("high_flicker_light_on", "targetname");
  var_4 = getEnt("high_flicker_light_off", "targetname");
  var_4 show();
  var_3 hide();
  var_5 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_5 thread scripts\sp\maps\sa_moon\sa_moon_fx::_id_13359("turkeyshoot_over");
  self endon("turkeyshoot_over");
  self endon("death");
  scripts\engine\utility::flag_wait("fleet_data_downloaded");

  for(;;) {
    var_6 = randomfloatrange(0.05, 1.5);
    playFXOnTag(scripts\engine\utility::getfx("vfx_sa_sparks_sizzle"), var_5, "tag_origin");
    var_0 setlightintensity(var_1);
    var_0 playSound("sfx_moon_sparks");
    var_0 playSound("hallway_arcing");
    var_4 hide();
    var_3 show();
    wait 0.05;
    var_0 setlightintensity(var_2);
    var_4 show();
    var_3 hide();
    wait 0.05;
    var_0 setlightintensity(var_1);
    var_4 hide();
    var_3 show();
    wait 0.05;
    var_0 setlightintensity(var_2);
    var_4 show();
    var_3 hide();
    var_0 playSound("sfx_moon_sparks");
    wait(var_6);
  }
}

_id_DC78() {
  var_0 = getEnt("high_flicker_light_02", "targetname");
  var_1 = randomintrange(80, 125);
  var_2 = 1;
  var_3 = getEnt("high_flicker_light_02_on", "targetname");
  var_4 = getEnt("high_flicker_light_02_off", "targetname");
  var_4 show();
  var_3 hide();
  self endon("turkeyshoot_over");
  self endon("death");
  scripts\engine\utility::flag_wait("fleet_data_downloaded");

  for(;;) {
    var_5 = randomfloatrange(0.05, 1.0);
    var_6 = randomfloatrange(1.0, 2.0);
    var_0 playSound("emt_fluorescent_light_flicker_3");
    var_0 setlightintensity(var_1);
    var_4 hide();
    var_3 show();
    wait 0.05;
    var_0 setlightintensity(var_2);
    var_4 show();
    var_3 hide();
    wait 0.1;
    var_0 setlightintensity(var_1);
    var_4 hide();
    var_3 show();
    wait 0.05;
    var_0 setlightintensity(var_2);
    var_4 show();
    var_3 hide();
    wait 0.1;
    var_0 setlightintensity(var_1);
    var_4 hide();
    var_3 show();
    wait(var_6);
    var_0 setlightintensity(var_2);
    var_4 show();
    var_3 hide();
    wait(var_5);
  }
}

_id_DC79() {
  var_0 = getEnt("low_flicker_light", "targetname");
  var_1 = randomintrange(70, 95);
  var_2 = 1;
  var_3 = getEnt("low_flicker_light_on", "targetname");
  var_4 = getEnt("low_flicker_light_off", "targetname");
  var_4 show();
  var_3 hide();
  var_5 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_5 thread scripts\sp\maps\sa_moon\sa_moon_fx::_id_13359("turkeyshoot_over");
  self endon("turkeyshoot_over");
  self endon("death");
  scripts\engine\utility::flag_wait("fleet_data_downloaded");

  for(;;) {
    var_6 = randomfloatrange(0.5, 3.0);
    playFXOnTag(scripts\engine\utility::getfx("vfx_sa_sparks_sizzle"), var_5, "tag_origin");
    var_0 playSound("sfx_moon_sparks");
    var_0 playSound("hallway_arcing");
    var_0 setlightintensity(var_1);
    var_4 hide();
    var_3 show();
    wait 0.05;
    var_0 setlightintensity(var_2);
    var_4 show();
    var_3 hide();
    wait 0.05;
    var_0 setlightintensity(var_1);
    var_4 hide();
    var_3 show();
    wait 0.05;
    var_0 setlightintensity(var_2);
    var_4 show();
    var_3 hide();
    wait(var_6);
  }
}

_id_DC7A() {
  var_0 = getEnt("low_flicker_light_02", "targetname");
  var_1 = randomintrange(70, 95);
  var_2 = 1;
  var_3 = getEnt("low_flicker_light_02_off", "targetname");
  var_4 = getEnt("low_flicker_light_02_on", "targetname");
  var_3 show();
  var_4 hide();
  self endon("turkeyshoot_over");
  self endon("death");

  for(;;) {
    var_5 = randomfloatrange(0.05, 2.0);
    var_0 setlightintensity(var_1);
    var_0 playSound("emt_fluorescent_light_flicker_2");
    var_3 hide();
    var_4 show();
    wait 0.05;
    var_0 setlightintensity(var_2);
    var_3 show();
    var_4 hide();
    wait 0.05;
    var_0 setlightintensity(var_1);
    var_3 hide();
    var_4 show();
    wait 0.05;
    var_0 setlightintensity(var_2);
    var_3 show();
    var_4 hide();
    wait(var_5);
  }
}

_id_BB1D() {
  level endon("death");
  var_0 = getEnt("flicker_on_off_light", "targetname");
  var_1 = 2;
  var_2 = 20;
  var_3 = getEnt("hallway_light_flicker_on", "targetname");
  var_4 = getEnt("hallway_light_flicker_off", "targetname");
  var_3 show();
  var_4 hide();
  wait 1;
  var_0 setlightintensity(85);
  scripts\engine\utility::flag_wait("hallway_wave3");
  var_5 = randomfloat(110);
  var_6 = 5;
  var_0 thread _id_BB1C(var_3, var_4, var_5, var_1, var_2);
  level waittill("flicker_lights_done");
  wait 0.05;
  var_7 = getEnt("constant_on_off_light_trig", "targetname");
  var_3 hide();
  var_4 show();
  var_2 = 15;
  var_0 thread _id_BB1C(var_3, var_4, var_1, var_5, var_2);
  level waittill("flicker_lights_done");
  var_3 show();
  var_4 hide();
  var_0 setlightintensity(130);
}

_id_BB1C(var_0, var_1, var_2, var_3, var_4) {
  while(var_4 > 0) {
    self setlightintensity(var_2);
    var_0 show();
    var_1 hide();
    wait 0.05;
    self setlightintensity(var_3);
    var_0 hide();
    var_1 show();
    wait 0.1;
    var_4 = var_4 - 1;
  }

  level notify("flicker_lights_done");
}