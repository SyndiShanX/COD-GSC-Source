/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\clockwork_scriptedlights.gsc
*********************************************/

main() {
  init_lights();
  cw_snowmobile_headlight_cg();
  check_trigger_moon_off();
  set_flag_moon_off();
  check_trigger_moon_on();
}

init_lights() {
  var_0 = getEntArray("cw_thermite_charge_light", "targetname");
  common_scripts\utility::array_thread(var_0, ::cw_thermite_charge_light);
  var_1 = getEntArray("cw_lights_out_script_1", "targetname");
  common_scripts\utility::array_thread(var_1, ::cw_lights_out_script_1);
  var_2 = getEntArray("cw_lights_out_script_2", "targetname");
  common_scripts\utility::array_thread(var_2, ::cw_lights_out_script_2);
  var_3 = getEntArray("cw_lights_out_script_3", "targetname");
  common_scripts\utility::array_thread(var_3, ::cw_lights_out_script_3);
  var_4 = getEntArray("cw_lights_out_script_4", "targetname");
  common_scripts\utility::array_thread(var_4, ::cw_lights_out_script_4);
  var_5 = getEntArray("cw_lights_out_script_5", "targetname");
  common_scripts\utility::array_thread(var_5, ::cw_lights_out_script_5);
  var_6 = getEntArray("cw_snowmobile_light", "targetname");
  common_scripts\utility::array_thread(var_6, ::cw_snowmobile_light);
  var_7 = getEntArray("cw_thermite_charge_light", "targetname");
  common_scripts\utility::array_thread(var_7, ::cw_chaos_vault_light);
  var_8 = getEntArray("cw_snowmobile_headlight", "targetname");
  common_scripts\utility::array_thread(var_8, ::cw_snowmobile_headlight);
  var_9 = getEntArray("cw_lights_out_ng", "targetname");
  common_scripts\utility::array_thread(var_9, ::cw_lights_out_ng);
}

cw_lights_out_ng() {
  var_0 = self getlightintensity();
  var_1 = self getlightradius();
  var_2 = var_0;
  common_scripts\utility::flag_wait("lights_out");
  self setlightintensity(0.01);
  self setlightradius(12);
  common_scripts\utility::flag_wait("lights_on");
  maps\_utility::vision_set_changes("clockwork_indoor", 3);
  self setlightintensity(var_0);
  self setlightradius(var_1);
}

cw_snowmobile_headlight() {
  self getlightintensity();
  common_scripts\utility::flag_wait("FLAG_intro_light_off");
  self setlightintensity(0.0);
  self setlightradius(12);
}

cw_snowmobile_headlight_cg() {
  if(!maps\_utility::is_gen4()) {
    var_0 = getent("cw_light_card", "targetname");
    common_scripts\utility::flag_wait("FLAG_intro_light_off");
    var_0 delete();
  }
}

cw_thermite_charge_light() {
  self getlightradius();
  self setlightintensity(0.1);
  self setlightradius(12);
  self setlightcolor((1, 0.9, 0.6));
  common_scripts\utility::flag_wait("glow_start");
  common_scripts\utility::flag_wait("thermite_start");
  self setlightradius(350);
  self setlightcolor((1, 0.85, 0.65));
  self setlightfovrange(119, 10);
  self setlightintensity(0.25);
  wait 0.5;
  self setlightintensity(0.5);
  wait 0.5;
  self setlightintensity(0.75);
  wait 0.5;
  self setlightintensity(0.5);
  wait 0.5;
  self setlightintensity(0.25);
  common_scripts\utility::flag_wait("thermite_start");
  common_scripts\utility::flag_wait("thermite_start");
  self setlightintensity(0.6);
  var_0 = self getlightintensity();
  var_1 = var_0;
  self setlightradius(400);

  for(var_2 = gettime() + 6000; !common_scripts\utility::flag("thermite_stop"); var_1 = var_3) {
    var_3 = randomfloatrange(var_0 * 1.0, var_0 * 9.0);
    var_4 = randomfloatrange(0.05, 0.1);
    var_4 = var_4 * 15;

    for(var_5 = 0; var_5 < var_4; var_5++) {
      var_6 = var_3 * (var_5 / var_4) + var_1 * ((var_4 - var_5) / var_4);
      self setlightintensity(var_6);
      wait 0.05;
    }
  }

  self setlightradius(350);
  self setlightcolor((1, 0.85, 0.65));
  self setlightintensity(0.75);
  self setlightfovrange(119, 10);
  wait 30;
  self setlightintensity(0.1);
  self setlightradius(12);
  common_scripts\utility::flag_wait("lights_on");
  self setlightradius(300);
  self setlightintensity(0.4);
  self setlightcolor((0.87, 0.87, 1));
}

cw_lights_out_script_1() {
  var_0 = self getlightintensity();
  var_1 = self getlightradius();
  var_2 = var_0;
  wait 5;
  self setlightcolor((1, 1, 1));
  common_scripts\utility::flag_wait("lights_out");
  self setlightintensity(0.0);
  self setlightradius(12);
  common_scripts\utility::flag_wait("lights_on");
  maps\_utility::vision_set_changes("clockwork_indoor_security", 3);
  self setlightintensity(var_0);
  self setlightradius(var_1);
}

cw_lights_out_script_2() {
  var_0 = self getlightintensity();
  var_1 = self getlightradius();
  var_2 = var_0;
  wait 5;
  self setlightcolor((0.831373, 0.937255, 1));
  common_scripts\utility::flag_wait("lights_out");
  self setlightintensity(0.0);
  self setlightradius(12);
  common_scripts\utility::flag_wait("lights_on");
  maps\_utility::vision_set_changes("clockwork_indoor_security", 3);
  self setlightintensity(var_0);
  self setlightradius(var_1);
}

cw_lights_out_script_3() {
  var_0 = self getlightintensity();
  var_1 = self getlightradius();
  var_2 = var_0;
  wait 5;
  self setlightcolor((1, 0.87451, 0.701961));
  common_scripts\utility::flag_wait("lights_out");
  self setlightintensity(0.0);
  self setlightradius(12);
  common_scripts\utility::flag_wait("lights_on");
  maps\_utility::vision_set_changes("clockwork_indoor_security", 3);
  self setlightintensity(var_0);
  self setlightradius(var_1);
}

cw_lights_out_script_4() {
  var_0 = self getlightintensity();
  var_1 = self getlightradius();
  var_2 = var_0;
  wait 5;
  self setlightcolor((1, 0.976471, 0.921569));
  common_scripts\utility::flag_wait("lights_out");
  self setlightintensity(0.0);
  self setlightradius(12);
  common_scripts\utility::flag_wait("lights_on");
  maps\_utility::vision_set_changes("clockwork_indoor_security", 3);
  self setlightintensity(var_0);
  self setlightradius(var_1);
}

cw_lights_out_script_5() {
  var_0 = self getlightintensity();
  var_1 = self getlightradius();
  var_2 = var_0;
  wait 5;
  self setlightcolor((0.5137, 0.7019, 1));
  common_scripts\utility::flag_wait("lights_out");
  self setlightintensity(0.0);
  self setlightradius(12);
  common_scripts\utility::flag_wait("lights_on");
  maps\_utility::vision_set_changes("clockwork_indoor_security", 3);
  self setlightintensity(var_0);
  self setlightradius(var_1);
}

cw_snowmobile_light() {
  var_0 = self getlightintensity();
  var_1 = var_0;

  for(;;) {
    var_2 = randomfloatrange(var_0 * 0.3, var_0 * 1.1);
    var_3 = randomfloatrange(0.05, 0.1);
    var_3 = var_3 * 15;

    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = var_2 * (var_4 / var_3) + var_1 * ((var_3 - var_4) / var_3);
      self setlightintensity(var_5);
      wait 0.05;
    }

    var_1 = var_2;
  }
}

cw_chaos_vault_light() {
  common_scripts\utility::flag_wait("lights_on");
  self setlightradius(300);
  self setlightintensity(0.75);
  self setlightcolor((0.87, 0.87, 1));
}

check_trigger_moon_off(var_0) {
  var_1 = getEntArray("moon_off", "targetname");

  foreach(var_3 in var_1)
  var_3 thread set_flag_moon_off();
}

set_flag_moon_off() {
  self waittill("trigger");
  setsaveddvar("r_sunsprite_size_override", "0");
}

check_trigger_moon_on(var_0) {
  var_1 = getent("moon_on", "targetname");
  var_1 waittill("trigger");
  setsaveddvar("r_sunsprite_size_override", "24");
}