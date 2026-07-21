/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\highway\highway_lighting.gsc
************************************************/

init_lighting() {
  scripts\engine\sp\utility::motion_blur_enable(1, 1);
  thread lighting_setup_dvars();
  var_0 = lighting_get_bunker_lights();

  foreach(var_2 in var_0) {
    var_2.originalintensity = var_2 getlightintensity();
    var_2 setlightintensity(0);
  }
}

lighting_setup_dvars() {
  level.sunangles = getmapsunangles();
  level.introsunangles = (-15, -8, 0);
  setsaveddvar("TMNTMTQRM", 1);
  setsaveddvar("MPOKKOPMTN", "128 384 640 1024");
  setsaveddvar("NPONLLLSPL", 0.35);
  level.sunsamplesizenear = getdvarfloat("NPONLLLSPL");
  setsaveddvar("LSNRQTOKRR", 3);
  level.suncascademult1 = getdvarint("LSNRQTOKRR");
  setsaveddvar("NTLKNLNPLK", 2);
  level.suncascademult2 = getdvarint("NTLKNLNPLK");
  setsaveddvar("LTQMSPKRKO", 8);
  setsaveddvar("MROOOROPKL", 10);
  setsaveddvar("LKOLRONRNQ", 750);
  level.spotdistcull = getdvarint("LKOLRONRNQ");
}

ride_lighting(var_0) {
  lerpsunangles(level.sunangles, level.introsunangles, 0.01);
  setsaveddvar("LSNRQTOKRR", 2);
  setsaveddvar("NLOTLQMORR", 0.999);
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

ride_dof(var_0) {
  level scripts\engine\sp\utility::dof_enable(1, 5, 500);
  wait 0.5;
  var_0 scripts\engine\sp\utility::dof_enable_autofocus(3.5, 10, undefined, undefined, "tag_eye", undefined, 1);
  wait 23.25;
  lerpsunangles(level.introsunangles, level.sunangles, 0.01);
}

ride_end() {
  level.farah_main_light setlightintensity(0);
  level.farah_kick_light setlightintensity(0);
  setsaveddvar("NPONLLLSPL", level.sunsamplesizenear);
  setsaveddvar("LSNRQTOKRR", level.suncascademult1);
  setsaveddvar("NTLKNLNPLK", level.suncascademult2);
  scripts\engine\sp\utility::dof_disable_autofocus();
  setsaveddvar("NLOTLQMORR", 0.9);
}

lighting_bunker() {
  sun_disable();
  var_0 = lighting_get_bunker_lights();

  foreach(var_2 in var_0)
  var_2 setlightintensity(var_2.originalintensity);
}

lighting_get_bunker_lights() {
  return getEntArray("hwy_bnkr_end", "targetname");
}

lighting_dof_bunker() {
  var_0 = scripts\sp\maps\highway\highway.gsc::level_getfarah();
  var_1 = scripts\sp\maps\highway\highway.gsc::level_gethadir();
  var_0 scripts\engine\sp\utility::dof_enable_autofocus(2.0, 10, undefined, undefined, "tag_eye", undefined, 1);
  wait 20;
  var_1 scripts\engine\sp\utility::dof_enable_autofocus(2.0, 10, undefined, undefined, "tag_eye", undefined, 1);
  wait 22;
  var_0 scripts\engine\sp\utility::dof_enable_autofocus(2.0, 10, undefined, undefined, "tag_eye", undefined, 1);
  wait 7;
  level thread scripts\engine\sp\utility::dof_disable_autofocus();
}

sun_disable() {
  setsuncolorandintensity(0.0);
  waitframe();
  waitframe();
  setsaveddvar("MQRQQONQSL", 0);
}