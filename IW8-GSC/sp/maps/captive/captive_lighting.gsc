/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\captive\captive_lighting.gsc
************************************************/

main() {
  scripts\engine\sp\utility::post_load_precache(::post_load);
}

post_load() {
  scripts\engine\sp\utility::motion_blur_enable(1, 1);
  light_dvars();
}

light_dvars() {
  setsaveddvar("LKOLRONRNQ", 400);
  setsaveddvar("SLSMSSTQP", 1);
  setsaveddvar("MPOKKOPMTN", "64 128 256 512");
  setsaveddvar("LTQMSPKRKO", 6);
  setsaveddvar("MROOOROPKL", 8);
}

setup_lighting() {
  init_lights("pre_explosion");
  init_lights("post_explosion");
  init_lights("main_cell");
  init_lights("waterboarding");
  init_lights("hadir_cell");
  init_lights("break_final");
  init_lights("barkov_rim");
  init_lights("fallen_grate");
  init_lights("upstairs");
  init_lights("find_hadir_pre");
  init_lights("find_hadir_post");
  lights_off("post_explosion");
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

sas_hero_sun() {
  level.sunangles = getmapsunangles();
  level.introsunangles = (-45, -158, 0);
  lerpsunangles(level.sunangles, level.introsunangles, 0.1);
}

explore_dof() {
  level.player_rig thread scripts\engine\sp\utility::dof_enable_autofocus(3.0, 15, undefined, undefined, "j_thumb_ri_3", undefined, 1);
}

shackle_dof() {
  level.player_rig thread scripts\engine\sp\utility::dof_enable_autofocus(6.0, 16, undefined, undefined, "j_thumb_ri_3", undefined, 1);
}

button_dof(var_0) {
  var_0 thread scripts\engine\sp\utility::dof_enable_autofocus(2.8, 8, undefined, undefined, "push_button", undefined, 1);
}

hadir_dof() {
  level.hadir thread scripts\engine\sp\utility::dof_enable_autofocus(1.2, 8, undefined, undefined, "tag_eye", undefined, 1);
}

find_hadir_dof() {
  level.hadir thread scripts\engine\sp\utility::dof_enable_autofocus(3.0, 8, undefined, undefined, "tag_eye", undefined, 1);
}

key_dof() {
  level.key thread scripts\engine\sp\utility::dof_enable_autofocus(2.8, 1, undefined, undefined, "tag_origin", undefined, 1);
}

barkov_dof() {
  level.barkov thread scripts\engine\sp\utility::dof_enable_autofocus(2.8, 8, undefined, undefined, "tag_eye", undefined, 1);
}

waterboarding_dof_barkov() {
  level.barkov thread scripts\engine\sp\utility::dof_enable_autofocus(3.4, 8, undefined, undefined, undefined, undefined, 1);
}

foodbowl_dof() {
  level.foodbowl thread scripts\engine\sp\utility::dof_enable_autofocus(12, 8, undefined, undefined, undefined, undefined, 1);
  wait 14;
}

azadeh_brought_in() {
  level.femaleprisoner thread scripts\engine\sp\utility::dof_enable_autofocus(6.0, 8, undefined, undefined, "tag_eye", undefined, 1);
  wait 18;
  level.barkov thread scripts\engine\sp\utility::dof_enable_autofocus(2.0, 8, undefined, undefined, "tag_eye", undefined, 1);
}

check_kill_azadeh() {
  level waittill("kill_azadeh");
  level.femaleprisoner thread scripts\engine\sp\utility::dof_enable_autofocus(6.0, 8, undefined, undefined, "tag_eye", undefined, 1);
  wait 8;
  level.barkov thread scripts\engine\sp\utility::dof_enable_autofocus(2.0, 8, undefined, undefined, "tag_eye", undefined, 1);
}

price_dof() {
  level thread scripts\engine\sp\utility::dof_enable(4.8, 22, 10.0, 10.0, undefined, undefined);
  wait 2.25;
  level thread scripts\engine\sp\utility::dof_enable(4.8, 50, 10.0, 10.0, undefined, undefined);
  level waittill("enemy_dead");
  level.price thread scripts\engine\sp\utility::dof_enable_autofocus(2.2, 15, undefined, undefined, undefined, undefined, 1);
}

dof_off() {
  scripts\engine\sp\utility::dof_disable_autofocus();
}

cells_cascade() {
  setsaveddvar("NPONLLLSPL", 0.2);
  setsaveddvar("LSNRQTOKRR", 2);
  setsaveddvar("NTLKNLNPLK", 1);
}

warehouse_cascade() {
  setsaveddvar("NPONLLLSPL", 0.41);
  setsaveddvar("LSNRQTOKRR", 2);
  setsaveddvar("NTLKNLNPLK", 1);
}

factory_cascade() {
  setsaveddvar("NPONLLLSPL", 0.48);
  setsaveddvar("LSNRQTOKRR", 2);
  setsaveddvar("NTLKNLNPLK", 1);
}

exterior_cascade() {
  setsaveddvar("NPONLLLSPL", 0.6);
  setsaveddvar("LSNRQTOKRR", 2);
  setsaveddvar("NTLKNLNPLK", 2);
}

explosion_flicker() {
  wait 3.5;
  lights_off("break_final");
  lights_off("main_cell");
  wait 0.15;
  lights_on("break_final");
  lights_on("main_cell");
  wait 0.07;
  lights_off("break_final");
  lights_off("main_cell");
  wait 0.1;
  lights_on("break_final");
  lights_on("main_cell");
  wait 0.05;
  lights_off("break_final");
  lights_off("main_cell");
  wait 0.075;
  lights_on("break_final");
  lights_on("main_cell");
}