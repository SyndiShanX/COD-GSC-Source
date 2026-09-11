/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\piccadilly\piccadilly_lighting.gsc
**************************************************************/

function setup_lighting() {
  init_lights("spec_hostage");
  init_lights("spec_pre_hostage");
  init_lights("price_intro");
}

function init_lights(var0) {
  var1 = getEntArray(var0, "targetname");

  foreach(var3 in var1) {
    var3.og_intensity = var3 getlightintensity();
  }
}

function lights_off(var0) {
  var1 = getEntArray(var0, "targetname");

  foreach(var3 in var1) {
    var3 setlightintensity(0);
  }
}

function lights_on(var0) {
  var1 = getEntArray(var0, "targetname");

  foreach(var3 in var1) {
    var3 setlightintensity(var3.og_intensity);
  }
}

function main() {
  thread init_price_intro_lights();
  scripts\engine\sp\utility::post_load_precache(&post_load);
}

function init_price_intro_lights() {
  var0 = getEntArray("price_intro_on", "targetname");

  foreach(var2 in var0) {
    var2.og_intensity = var2 getlightintensity();
    var2 setlightintensity(0);
  }
}

function post_load() {
  scripts\engine\sp\utility::motion_blur_enable(1);
  thread light_dvars();
}

function light_dvars() {
  setsaveddvar("LTQMSPKRKO", 6);
  setsaveddvar("MROOOROPKL", 8);
  wait 2;
  setsaveddvar("LKOLRONRNQ", 500);
}

function infil_start() {
  level endon("intro_skipped");
  level.player enablephysicaldepthoffieldscripting();
  var0 = [level.truck];
  level.kyledrone thread scripts\engine\sp\utility::dof_enable_autofocus(6, 8, undefined, undefined, "tag_eye", var0, 1);
  wait 25;
  level thread scripts\engine\sp\utility::dof_enable(2.8, 31, 10, 10, undefined, undefined);
  wait 12.5;

  while(!isDefined(level.truck_driver)) {
    waitframe();
  }

  level.truck_driver scripts\engine\sp\utility::dof_enable_autofocus(1.2, 1, undefined, undefined, "tag_eye", var0, 1);
  wait 6.5;
  level thread scripts\engine\sp\utility::dof_enable_autofocus(1.8, 4, undefined);
  scripts\engine\utility::flag_wait("boots_on_the_ground");
  wait 0.5;
  level thread scripts\engine\sp\utility::dof_disable_autofocus();
}

function price_intro_dof() {
  level.rig thread scripts\engine\sp\utility::dof_enable_autofocus(2.8, 32, undefined, undefined, "j_thumb_ri_2");
  wait 4;
  level.terry thread scripts\engine\sp\utility::dof_enable_autofocus(1, 64, undefined, undefined, "tag_eye");
  wait 2.5;
  level.price thread scripts\engine\sp\utility::dof_enable_autofocus(2.2, 32, undefined, undefined, "tag_eye");
  wait 15;
  scripts\engine\sp\utility::dof_disable_autofocus();
}

function balcony_hostage_dof() {
  level.rig thread scripts\engine\sp\utility::dof_enable_autofocus(2, 8, undefined, undefined, "j_thumb_ri_2");
  wait 5;
  level.price thread scripts\engine\sp\utility::dof_enable_autofocus(1.8, 8, undefined, undefined, "tag_eye");
  wait 1.5;
  level.rig thread scripts\engine\sp\utility::dof_enable_autofocus(2, 8, undefined, undefined, "j_thumb_ri_2");
  wait 6;
  level.price thread scripts\engine\sp\utility::dof_enable_autofocus(1.8, 8, undefined, undefined, "tag_eye");
  wait 27;
  scripts\engine\sp\utility::dof_disable_autofocus();
}

function setup_truck_lighting() {
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
  level.light_car_rim setlightintensity(2);
  level.light_car_rim setlightfovrange(110, 90);
  level.light_car_rim setlightradius(180);
  level.light_car_rim setlightcolor((0.776, 0.976, 1));
  level.light_car_back = getEnt("infil_car_back", "targetname");
  level.light_car_back linkTo(self, "tag_origin", (-80, -5, 86), (40, 18, 0));
  level.light_car_back setlightintensity(4.5);
  level.light_car_back setlightfovrange(115, 60);
  level.light_car_back setlightradius(100);
  level.light_car_back setlightcolor((0.776, 0.976, 1));
  var0 = getEnt("light_truck_key1", "targetname");
  var0 setlightintensity(0);
  var1 = getEnt("light_truck_key2", "targetname");
  var1 setlightintensity(0);
  level waittill("get_out_of_car");
  wait 6.5;
  var2 = [level.light_front_high, level.light_front_low, level.light_car_back, level.light_car_fill, level.light_car_rim, var0, var1];

  foreach(var4 in var2) {
    var4 setlightintensity(0);
  }
}