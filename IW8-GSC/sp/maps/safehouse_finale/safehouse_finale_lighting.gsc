/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\safehouse_finale\safehouse_finale_lighting.gsc
******************************************************************/

main() {
  scripts\engine\sp\utility::post_load_precache(::post_load);
  thread armory_lights();
  thread truck_lights();
  thread hellcannon_lights();
  thread charge_explosion_01();
  thread tarmac_hangar_lights();
  thread hadir_hero_lights();
  thread hangar_fire_lights();
  thread town_truck_lights();
  thread hadir_boost_lights();
  thread fly_in_lights();
}

post_load() {
  scripts\engine\sp\utility::motion_blur_enable(1, 1);
  lighting_setup_dvars();
}

lighting_setup_dvars() {
  setsaveddvar("MPOKKOPMTN", "256 512 1024 2048");
  setsaveddvar("LTQMSPKRKO", 6);
  setsaveddvar("MROOOROPKL", 8);
  setsuncolorandintensity(0.0);
  setsaveddvar("MQRQQONQSL", 0);
  setsaveddvar("LKOLRONRNQ", 750);
}

fly_in_lights() {
  wait 0.5;
  scripts\engine\utility::flag_wait("fly_attack_done");
  var_0 = getEntArray("fly_in_lights", "targetname");

  foreach(var_2 in var_0)
  var_2 setlightintensity(0);
}

hadir_boost_lights() {
  wait 0.1;
  var_0 = getEntArray("hadir_boost", "targetname");

  foreach(var_2 in var_0) {
    var_2.og = var_2 getlightintensity();
    var_2 setlightintensity(0);
  }

  scripts\engine\utility::flag_wait("hadir_go_to_hatch");

  foreach(var_2 in var_0)
  var_2 setlightintensity(var_2.og);

  scripts\engine\utility::flag_wait("player_in_armory_02");

  foreach(var_2 in var_0)
  var_2 setlightintensity(0);
}

town_truck_lights() {
  wait 0.1;
  var_0 = getEntArray("truck_lights", "targetname");

  foreach(var_2 in var_0) {
    var_2.og = var_2 getlightintensity();
    var_2 setlightintensity(0);
  }

  while(!scripts\engine\utility::flag_exist("fly_attack_done"))
    waitframe();

  scripts\engine\utility::flag_wait("fly_attack_done");

  foreach(var_2 in var_0)
  var_2 setlightintensity(var_2.og);
}

lt_interior_main_start() {
  visionsetnaked("safehouse_finale_house_hadir", 0);
  level.player enablephysicaldepthoffieldscripting();

  while(!isDefined(level.hadir))
    waitframe();

  setsaveddvar("LKOLRONRNQ", 300);
  setsaveddvar("LTQMSPKRKO", 6);
  setsaveddvar("MROOOROPKL", 6);
  level.hadir thread scripts\engine\sp\utility::dof_enable_autofocus(2.8, 5, undefined, undefined, "tag_eye");
  wait 3.5;
  level.molotov thread scripts\engine\sp\utility::dof_enable_autofocus(2.8, 2.5, undefined, undefined, "tag_accessory");
  wait 2.0;
  level.hadir thread scripts\engine\sp\utility::dof_enable_autofocus(2.8, 3, undefined, undefined, "tag_eye");
  wait 5.25;
  level.player disablephysicaldepthoffieldscripting();
  visionsetnaked("", 1.0);
  setsaveddvar("LKOLRONRNQ", 750);
  setsaveddvar("LTQMSPKRKO", 6);
  setsaveddvar("MROOOROPKL", 8);
}

hadir_hero_lights() {
  while(!isDefined(level.hadir))
    waitframe();

  level waittill("enable_guns_intro");
  wait 1;
  var_0 = getEntArray("intro_rim_light", "targetname");

  foreach(var_2 in var_0)
  var_2 thread lerp_value_charge_explosion(var_2 getlightintensity(), 0, 2);
}

hangar_fire_lights() {
  while(!scripts\engine\utility::flag_exist("power_kill"))
    waitframe();

  var_0 = getEntArray("hangar_end_fire", "targetname");

  foreach(var_2 in var_0) {
    var_2.og = var_2 getlightintensity();
    var_2 setlightintensity(0.0);
  }

  scripts\engine\utility::flag_wait("power_kill");

  foreach(var_2 in var_0)
  var_2 setlightintensity(var_2.og);
}

hellcannon_lights() {
  var_0 = 150;
  var_1 = 0.15;
  var_2 = 1.0;
  level.lt_charge_explosion_02 = getEnt("charge_explosion_02", "targetname");
  level.lt_charge_explosion_02 setlightintensity(0);
  level waittill("level_hellCannonImpact");
  waitframe();
  level.lt_charge_explosion_02 thread lerp_value_charge_explosion(0, var_0, var_1);
  wait 0.15;
  level.lt_charge_explosion_02 thread lerp_value_charge_explosion(var_0, 0, var_2);
  level waittill("level_hellCannonImpact");
  waitframe();
  level.lt_charge_explosion_02 thread lerp_value_charge_explosion(0, var_0, var_1);
  wait 0.2;
  level.lt_charge_explosion_02 thread lerp_value_charge_explosion(var_0, 0, var_2);
}

lerp_value_charge_explosion(var_0, var_1, var_2) {
  var_3 = var_1 - var_0;
  var_4 = 0.05;
  var_5 = int(var_2 / var_4);

  if(var_5 > 0) {
    for(var_6 = var_3 / var_5; var_5; var_5--) {
      var_0 = var_0 + var_6;
      self setlightintensity(var_0);
      wait(var_4);
    }
  }
}

armory_lights() {
  while(!scripts\engine\utility::flag_exist("hangar_defend_start"))
    waitframe();

  if(scripts\engine\utility::flag("killstreak_complete")) {
    return;
  }
  var_0 = getEntArray("emergency_hangar", "targetname");

  foreach(var_2 in var_0) {
    var_2.og = var_2 getlightintensity();
    var_2 setlightintensity(0);
  }

  level waittill("power_kill");
  var_4 = getEntArray("hangar_armory_lights", "targetname");

  foreach(var_2 in var_4)
  var_2 setlightintensity(0.0);

  var_7 = getEntArray("armory_lights_caged_on", "targetname");

  foreach(var_2 in var_7)
  var_2 setModel("me_light_ceiling_fluorescent_tube_small_cage");

  var_10 = getEntArray("armory_red_light_fixtures", "targetname");

  foreach(var_2 in var_10)
  var_2 setModel("lighting_red_emergency_01_on");

  var_13 = getEntArray("hangar_armory_door_light", "targetname");

  foreach(var_2 in var_13)
  var_2 setModel("ee_light_mounted_exterior_industrial_caged_02");

  var_0 = getEntArray("emergency_hangar", "targetname");

  foreach(var_2 in var_0)
  var_2 setlightintensity(var_2.og);

  var_18 = getEntArray("hangar_lights", "targetname");

  foreach(var_2 in var_18)
  var_2 setModel("uk_industrial_light_01");

  var_21 = getEntArray("hangar_lights_back_fixture", "targetname");

  foreach(var_2 in var_21)
  var_2 setModel("un_painters_light_01");

  var_24 = getEntArray("hangar_lights_front", "targetname");

  foreach(var_2 in var_24)
  var_2 setlightintensity(0.0);

  var_27 = getEntArray("hangar_lights_mid", "targetname");

  foreach(var_2 in var_27)
  var_2 setlightintensity(0.0);

  var_30 = getEntArray("hangar_lights_back", "targetname");

  foreach(var_2 in var_30)
  var_2 setlightintensity(0.0);
}

tarmac_hangar_lights() {
  var_0 = [];

  while(!scripts\engine\utility::flag_exist("tarmac_mid"))
    waitframe();

  if(scripts\engine\utility::flag("tarmac_mid")) {
    return;
  }
  var_1 = getEntArray("hangar_lights_front", "targetname");
  var_1 = scripts\engine\utility::array_combine(var_1, getEntArray("hangar_lights_mid", "targetname"));
  var_1 = scripts\engine\utility::array_combine(var_1, getEntArray("hangar_lights_back", "targetname"));

  foreach(var_3 in var_1) {
    var_3.og_intensity = var_3 getlightintensity();
    var_0[var_0.size] = var_3;
    var_3 setlightintensity(0);
  }

  scripts\engine\utility::flag_wait("chu_entrance");

  foreach(var_3 in var_1)
  var_3 setlightintensity(var_3.og_intensity);

  var_7 = getEntArray("hangar_lights_front", "targetname");

  foreach(var_3 in var_7) {
    var_3.og_intensity = var_3 getlightintensity();
    var_0[var_0.size] = var_3;
    var_3 setlightintensity(10);
  }

  var_10 = getEntArray("hangar_lights_mid", "targetname");

  foreach(var_3 in var_10) {
    var_3.og_intensity = var_3 getlightintensity();
    var_0[var_0.size] = var_3;
    var_3 setlightintensity(3);
  }

  var_13 = getEntArray("hangar_lights_back", "targetname");

  foreach(var_3 in var_13) {
    var_3.og_intensity = var_3 getlightintensity();
    var_0[var_0.size] = var_3;
    var_3 setlightintensity(3);
  }

  while(!scripts\engine\utility::flag_exist("tarmac_mid"))
    waitframe();

  scripts\engine\utility::flag_wait("tarmac_mid");
  scripts\engine\utility::array_thread(var_0, ::dim_hangar_lights);
}

ending_scene_lights() {
  while(!scripts\engine\utility::flag_exist("killstreak_complete"))
    waitframe();

  scripts\engine\utility::flag_wait("killstreak_complete");
  var_0 = getEntArray("emergency_hangar", "targetname");

  foreach(var_2 in var_0) {
    var_2.og = var_2 getlightintensity();
    var_2 setlightintensity(0);
  }

  var_4 = getEntArray("hangar_end_fire", "targetname");

  foreach(var_2 in var_4)
  var_2 setlightintensity(0.0);

  var_7 = getEntArray("hangar_armory_lights", "targetname");

  foreach(var_2 in var_7)
  var_2 setlightintensity(0.0);

  var_10 = getEntArray("armory_lights_caged_on", "targetname");

  foreach(var_2 in var_10)
  var_2 setModel("me_light_ceiling_fluorescent_tube_small_cage");

  var_0 = getEntArray("emergency_hangar", "targetname");

  foreach(var_2 in var_0)
  var_2 setlightintensity(0);

  var_15 = getEntArray("hangar_lights", "targetname");

  foreach(var_2 in var_15)
  var_2 setModel("uk_industrial_light_01");

  var_18 = getEntArray("hangar_lights_front", "targetname");

  foreach(var_2 in var_18)
  var_2 setlightintensity(0.0);

  var_21 = getEntArray("hangar_lights_mid", "targetname");

  foreach(var_2 in var_21)
  var_2 setlightintensity(0.0);

  var_24 = getEntArray("hangar_lights_back", "targetname");

  foreach(var_2 in var_24)
  var_2 setlightintensity(0.0);
}

dim_hangar_lights() {
  thread lerp_value_charge_explosion(self getlightintensity(), self.og_intensity, 6);
}

truck_lights() {
  var_0 = getEntArray("truck_lights", "targetname");

  foreach(var_2 in var_0)
  var_2 setlightintensity(0.8);

  var_0 = getEntArray("gate_truck_lights", "targetname");

  foreach(var_2 in var_0)
  var_2 setlightintensity(0.8);

  var_0 = getEntArray("vindia_spotlight", "targetname");

  foreach(var_2 in var_0)
  var_2 setlightintensity(15.0);
}

charge_explosion_01() {
  var_0 = 150;
  var_1 = 0.15;
  var_2 = 1.0;
  var_3 = getEntArray("charge_explosion_01", "targetname");

  foreach(var_5 in var_3) {
    var_5.og_intensity = var_5 getlightintensity();
    var_5 setlightintensity(0);
  }

  level waittill("level_hellCannonImpact");
  waitframe();

  foreach(var_5 in var_3)
  var_5 thread lerp_value_charge_explosion(0, var_5.og_intensity, var_1);

  wait(var_1);

  foreach(var_5 in var_3)
  var_5 thread lerp_value_charge_explosion(var_5.og_intensity, 0, var_1);
}