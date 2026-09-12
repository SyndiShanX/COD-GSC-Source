/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\highway\highway_lighting.gsc
********************************************************/

function init_lighting() {
  scripts\engine\sp\utility::motion_blur_enable(1, 1);
  thread lighting_setup_dvars();
  var_0 = lighting_get_bunker_lights();

  foreach(var_2 in var_0) {
    var_2.originalintensity = var_2 getlightintensity();
    var_2 setlightintensity(0);
  }
}

function lighting_setup_dvars() {
  level.sunangles = getmapsunangles();
  level.introsunangles = (-15, -8, 0);
  setsaveddvar("sm_sunDistantShadows", 1);
  setsaveddvar("r_volumetricDepth", "128 384 640 1024");
  setsaveddvar("sm_sunSampleSizeNear", 0.35);
  level.sunsamplesizenear = getdvarfloat("sm_sunSampleSizeNear");
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 3);
  level.suncascademult1 = getdvarint("sm_sunCascadeSizeMultiplier1");
  setsaveddvar("sm_sunCascadeSizeMultiplier2", 2);
  level.suncascademult2 = getdvarint("sm_sunCascadeSizeMultiplier2");
  setsaveddvar("sm_spotUpdateLimit", 8);
  setsaveddvar("sm_roundRobinPrioritySpotShadows", 10);
  setsaveddvar("sm_spotDistCull", 750);
  level.spotdistcull = getdvarint("sm_spotDistCull");
}

function ride_lighting(var_0) {
  lerpsunangles(level.sunangles, level.introsunangles, 0.01);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 2);
  setsaveddvar("r_lightGridTempSmoothingFactor", 0.999);
  level.farah_main_light = getEnt("farah_main", "targetname");
  level.farah_main_light setlightintensity(70);
  level.farah_main_light setlightradius(135);
  level.farah_main_light setlightfovrange(50, 35);
  level.farah_main_light linkTo(var_0, "tag_accessory_01", (0, -30, 30), (20, 130, 0));
  level.farah_kick_light = getEnt("farah_kick", "targetname");
  level.farah_kick_light setlightintensity(40);
  level.farah_kick_light setlightradius(90);
  level.farah_kick_light setlightfovrange(80, 35);
  level.farah_kick_light setlightcolor((1, 1, 0.95));
  level.farah_kick_light linkTo(var_0, "tag_accessory_02", (50, -15, 50), (10, -120, 0));
}

function ride_dof(var_0) {
  level scripts\engine\sp\utility::dof_enable(1, 5, 500);
  wait 0.5;
  var_0 scripts\engine\sp\utility::dof_enable_autofocus(3.5, 10, undefined, undefined, "tag_eye", undefined, 1);
  wait 23.25;
  lerpsunangles(level.introsunangles, level.sunangles, 0.01);
}

function ride_end() {
  level.farah_main_light setlightintensity(0);
  level.farah_kick_light setlightintensity(0);
  setsaveddvar("sm_sunSampleSizeNear", level.sunsamplesizenear);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", level.suncascademult1);
  setsaveddvar("sm_sunCascadeSizeMultiplier2", level.suncascademult2);
  scripts\engine\sp\utility::dof_disable_autofocus();
  setsaveddvar("r_lightGridTempSmoothingFactor", 0.9);
}

function lighting_bunker() {
  sun_disable();
  var_0 = lighting_get_bunker_lights();

  foreach(var_2 in var_0) {
    var_2 setlightintensity(var_2.originalintensity);
  }
}

function lighting_get_bunker_lights() {
  return getEntArray("hwy_bnkr_end", "targetname");
}

function lighting_dof_bunker() {
  var_0 = scripts\sp\maps\highway\highway::level_getfarah();
  var_1 = scripts\sp\maps\highway\highway::level_gethadir();
  var_0 scripts\engine\sp\utility::dof_enable_autofocus(2, 10, undefined, undefined, "tag_eye", undefined, 1);
  wait 20;
  var_1 scripts\engine\sp\utility::dof_enable_autofocus(2, 10, undefined, undefined, "tag_eye", undefined, 1);
  wait 22;
  var_0 scripts\engine\sp\utility::dof_enable_autofocus(2, 10, undefined, undefined, "tag_eye", undefined, 1);
  wait 7;
  level thread scripts\engine\sp\utility::dof_disable_autofocus();
}

function sun_disable() {
  setsuncolorandintensity(0);
  waitframe();
  waitframe();
  setsaveddvar("sm_sunEnable", 0);
}