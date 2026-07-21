/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\piccadilly\piccadilly_lighting.gsc
******************************************************/

setup_lighting() {
  init_lights("spec_hostage");
  init_lights("spec_pre_hostage");
  init_lights("price_intro");
}

init_lights(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1)
  var_3.og_intensity = var_3 getlightintensity();
}

lights_off(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1)
  var_3 setlightintensity(0);
}

lights_on(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1)
  var_3 setlightintensity(var_3.og_intensity);
}

main() {
  thread init_price_intro_lights();
  scripts\engine\sp\utility::post_load_precache(::post_load);
}

init_price_intro_lights() {
  var_0 = getEntArray("price_intro_on", "targetname");

  foreach(var_2 in var_0) {
    var_2.og_intensity = var_2 getlightintensity();
    var_2 setlightintensity(0);
  }
}

post_load() {
  scripts\engine\sp\utility::motion_blur_enable(1);
  thread light_dvars();
}

light_dvars() {
  setsaveddvar("LTQMSPKRKO", 6);
  setsaveddvar("MROOOROPKL", 8);
  wait 2.0;
  setsaveddvar("LKOLRONRNQ", 500);
}

infil_start() {
  level endon("intro_skipped");
  level.player enablephysicaldepthoffieldscripting();
  var_0 = [level.truck];
  level.kyledrone thread scripts\engine\sp\utility::dof_enable_autofocus(6.0, 8, undefined, undefined, "tag_eye", var_0, 1);
  wait 25;
  level thread scripts\engine\sp\utility::dof_enable(2.8, 31, 10.0, 10.0, undefined, undefined);
  wait 12.5;

  while(!isDefined(level.truck_driver))
    waitframe();

  level.truck_driver scripts\engine\sp\utility::dof_enable_autofocus(1.2, 1, undefined, undefined, "tag_eye", var_0, 1);
  wait 6.5;
  level thread scripts\engine\sp\utility::dof_enable_autofocus(1.8, 4, undefined);
  scripts\engine\utility::flag_wait("boots_on_the_ground");
  wait 0.5;
  level thread scripts\engine\sp\utility::dof_disable_autofocus();
}

price_intro_dof() {
  level.rig thread scripts\engine\sp\utility::dof_enable_autofocus(2.8, 32, undefined, undefined, "j_thumb_ri_2");
  wait 4;
  level.terry thread scripts\engine\sp\utility::dof_enable_autofocus(1.0, 64, undefined, undefined, "tag_eye");
  wait 2.5;
  level.price thread scripts\engine\sp\utility::dof_enable_autofocus(2.2, 32, undefined, undefined, "tag_eye");
  wait 15;
  scripts\engine\sp\utility::dof_disable_autofocus();
}

balcony_hostage_dof() {
  level.rig thread scripts\engine\sp\utility::dof_enable_autofocus(2.0, 8, undefined, undefined, "j_thumb_ri_2");
  wait 5;
  level.price thread scripts\engine\sp\utility::dof_enable_autofocus(1.8, 8, undefined, undefined, "tag_eye");
  wait 1.5;
  level.rig thread scripts\engine\sp\utility::dof_enable_autofocus(2.0, 8, undefined, undefined, "j_thumb_ri_2");
  wait 6;
  level.price thread scripts\engine\sp\utility::dof_enable_autofocus(1.8, 8, undefined, undefined, "tag_eye");
  wait 27;
  scripts\engine\sp\utility::dof_disable_autofocus();
}

setup_truck_lighting() {
  level.light_front_high = getEnt("infil_car_front_high", "targetname");
  level.light_front_high linkTo(self, "tag_origin", (35, -3, 62), (180, 0, 0));
  level.light_front_high setlightintensity(0.12);
  level.light_front_high setlightfovrange(110, 105);
  level.light_front_high setlightradius(40);
  level.light_front_high setlightcolor((0.6, 1, 0.701));
  level.light_front_low = getEnt("infil_car_front_low", "targetname");
  level.light_front_low linkTo(self, "tag_origin", (2, 22, 65), (200, 10, 0));
  level.light_front_low setlightintensity(0.13);
  level.light_front_low setlightfovrange(95, 85);
  level.light_front_low setlightradius(45);
  level.light_front_low setlightcolor((0.776, 0.976, 1));
  level.light_car_fill = getEnt("infil_car_fill", "targetname");
  level.light_car_fill linkTo(self, "tag_origin", (-5, 0, 59), (220, 60, 0));
  level.light_car_fill setlightintensity(0.05);
  level.light_car_fill setlightfovrange(95, 60);
  level.light_car_fill setlightradius(65);
  level.light_car_fill setlightcolor((0.776, 0.976, 1));
  level.light_car_rim = getEnt("infil_car_rim", "targetname");
  level.light_car_rim linkTo(self, "tag_origin", (15, -65, 70), (40, 110, 0));
  level.light_car_rim setlightintensity(2.0);
  level.light_car_rim setlightfovrange(110, 90);
  level.light_car_rim setlightradius(180);
  level.light_car_rim setlightcolor((0.776, 0.976, 1));
  level.light_car_back = getEnt("infil_car_back", "targetname");
  level.light_car_back linkTo(self, "tag_origin", (-80, -5, 86), (40, 18, 0));
  level.light_car_back setlightintensity(4.5);
  level.light_car_back setlightfovrange(115, 60);
  level.light_car_back setlightradius(100);
  level.light_car_back setlightcolor((0.776, 0.976, 1));
  var_0 = getEnt("light_truck_key1", "targetname");
  var_0 setlightintensity(0);
  var_1 = getEnt("light_truck_key2", "targetname");
  var_1 setlightintensity(0);
  level waittill("get_out_of_car");
  wait 6.5;
  var_2 = [level.light_front_high, level.light_front_low, level.light_car_back, level.light_car_fill, level.light_car_rim, var_0, var_1];

  foreach(var_4 in var_2)
  var_4 setlightintensity(0);
}