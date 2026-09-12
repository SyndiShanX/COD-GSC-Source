/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\captive\captive_lighting.gsc
********************************************************/

function main() {
  scripts\engine\sp\utility::post_load_precache(&post_load);
}

function post_load() {
  scripts\engine\sp\utility::motion_blur_enable(1, 1);
  light_dvars();
}

function light_dvars() {
  setsaveddvar("sm_spotDistCull", 400);
  setsaveddvar("r_dof_physical_minFocusDistance", 1);
  setsaveddvar("r_volumetricDepth", "64 128 256 512");
  setsaveddvar("sm_spotUpdateLimit", 6);
  setsaveddvar("sm_roundRobinPrioritySpotShadows", 8);
}

function setup_lighting() {
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

function init_lights(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    var_3.og_intensity = var_3 getlightintensity();
  }
}

function lights_off(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    var_3 setlightintensity(0);
  }
}

function lights_on(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    var_3 setlightintensity(var_3.og_intensity);
  }
}

function sas_hero_sun() {
  level.sunangles = getmapsunangles();
  level.introsunangles = (-45, -158, 0);
  lerpsunangles(level.sunangles, level.introsunangles, 0.1);
}

function explore_dof() {
  level.player_rig thread scripts\engine\sp\utility::dof_enable_autofocus(3, 15, undefined, undefined, "j_thumb_ri_3", undefined, 1);
}

function shackle_dof() {
  level.player_rig thread scripts\engine\sp\utility::dof_enable_autofocus(6, 16, undefined, undefined, "j_thumb_ri_3", undefined, 1);
}

function button_dof(var_0) {
  var_0 thread scripts\engine\sp\utility::dof_enable_autofocus(2.8, 8, undefined, undefined, "push_button", undefined, 1);
}

function hadir_dof() {
  level.hadir thread scripts\engine\sp\utility::dof_enable_autofocus(1.2, 8, undefined, undefined, "tag_eye", undefined, 1);
}

function find_hadir_dof() {
  level.hadir thread scripts\engine\sp\utility::dof_enable_autofocus(3, 8, undefined, undefined, "tag_eye", undefined, 1);
}

function key_dof() {
  level.key thread scripts\engine\sp\utility::dof_enable_autofocus(2.8, 1, undefined, undefined, "tag_origin", undefined, 1);
}

function barkov_dof() {
  level.barkov thread scripts\engine\sp\utility::dof_enable_autofocus(2.8, 8, undefined, undefined, "tag_eye", undefined, 1);
}

function waterboarding_dof_barkov() {
  level.barkov thread scripts\engine\sp\utility::dof_enable_autofocus(3.4, 8, undefined, undefined, undefined, undefined, 1);
}

function foodbowl_dof() {
  level.foodbowl thread scripts\engine\sp\utility::dof_enable_autofocus(12, 8, undefined, undefined, undefined, undefined, 1);
  wait 14;
}

function azadeh_brought_in() {
  level.femaleprisoner thread scripts\engine\sp\utility::dof_enable_autofocus(6, 8, undefined, undefined, "tag_eye", undefined, 1);
  wait 18;
  level.barkov thread scripts\engine\sp\utility::dof_enable_autofocus(2, 8, undefined, undefined, "tag_eye", undefined, 1);
}

function check_kill_azadeh() {
  level waittill("kill_azadeh");
  level.femaleprisoner thread scripts\engine\sp\utility::dof_enable_autofocus(6, 8, undefined, undefined, "tag_eye", undefined, 1);
  wait 8;
  level.barkov thread scripts\engine\sp\utility::dof_enable_autofocus(2, 8, undefined, undefined, "tag_eye", undefined, 1);
}

function price_dof() {
  level thread scripts\engine\sp\utility::dof_enable(4.8, 22, 10, 10, undefined, undefined);
  wait 2.25;
  level thread scripts\engine\sp\utility::dof_enable(4.8, 50, 10, 10, undefined, undefined);
  level waittill("enemy_dead");
  level.price thread scripts\engine\sp\utility::dof_enable_autofocus(2.2, 15, undefined, undefined, undefined, undefined, 1);
}

function dof_off() {
  scripts\engine\sp\utility::dof_disable_autofocus();
}

function cells_cascade() {
  setsaveddvar("sm_sunSampleSizeNear", 0.2);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 2);
  setsaveddvar("sm_sunCascadeSizeMultiplier2", 1);
}

function warehouse_cascade() {
  setsaveddvar("sm_sunSampleSizeNear", 0.41);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 2);
  setsaveddvar("sm_sunCascadeSizeMultiplier2", 1);
}

function factory_cascade() {
  setsaveddvar("sm_sunSampleSizeNear", 0.48);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 2);
  setsaveddvar("sm_sunCascadeSizeMultiplier2", 1);
}

function exterior_cascade() {
  setsaveddvar("sm_sunSampleSizeNear", 0.6);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 2);
  setsaveddvar("sm_sunCascadeSizeMultiplier2", 2);
}

function explosion_flicker() {
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