/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_m_hill\mp_m_hill.gsc
***************************************************/

function main() {
  scripts\mp\maps\mp_m_hill\mp_m_hill_precache::main();
  scripts\mp\maps\mp_m_hill\gen\mp_m_hill_art::main();
  scripts\mp\maps\mp_m_hill\mp_m_hill_fx::main();
  scripts\mp\maps\mp_m_hill\mp_m_hill_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_m_hill", "codcaster_compass_map_mp_m_hill");
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.requiresminstartspawns = 0;
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_sunIntensityHeatOverride", 0.01);
  setDvar("cg_defaultWindAmplitudeScale", 3);
  setDvar("cg_defaultWindFrequencyScale", 3);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "woodland";
  game["axis_outfit"] = "woodland";
  thread player_exfil_struct();
  thread show_hint_after_delay();
}

function player_exfil_struct() {
  var_0 = spawn("script_model", (1016, -1233, 45));
  var_0 setModel("me_construction_plank_bridge_a_17");
  var_0.angles = (0, 0, 0);
  var_1 = getEnt("clip512x512x8", "targetname");
  var_2 = spawn("script_model", (1178, -1004, -88));
  var_2.angles = (90, 0, 0);
  var_2 clonebrushmodeltoscriptmodel(var_1);
  var_3 = getEnt("clip256x256x8", "targetname");
  var_4 = spawn("script_model", (1056, -908, 40));
  var_4.angles = (0, 0, -90);
  var_4 clonebrushmodeltoscriptmodel(var_3);
  var_5 = getEnt("clip128x128x8", "targetname");
  var_6 = spawn("script_model", (-952, -1368, 12));
  var_6.angles = (22, 15, 0);
  var_6 clonebrushmodeltoscriptmodel(var_5);
  var_7 = getEnt("nosight256x256x8", "targetname");
  var_8 = spawn("script_model", (1060, -892, 48));
  var_8.angles = (0, 0, -90);
  var_8 clonebrushmodeltoscriptmodel(var_7);
  var_9 = getEnt("nosight128x128x8", "targetname");
  var_10 = spawn("script_model", (868, -892, 160));
  var_10.angles = (0, 0, -90);
  var_10 clonebrushmodeltoscriptmodel(var_9);
  var_11 = getEnt("clip64x64x64", "targetname");
  var_12 = spawn("script_model", (-405, -1725, 35));
  var_12.angles = (0, 0, 0);
  var_12 clonebrushmodeltoscriptmodel(var_11);
  var_13 = getEnt("clip128x128x128", "targetname");
  var_14 = spawn("script_model", (-956, 1408, 28));
  var_14.angles = (3, 345, 22);
  var_14 clonebrushmodeltoscriptmodel(var_13);
  var_15 = getEnt("clip64x64x64", "targetname");
  var_16 = spawn("script_model", (-516, -948, -40));
  var_16.angles = (0, 320, 0);
  var_16 clonebrushmodeltoscriptmodel(var_15);
  var_17 = getEnt("clip64x64x64", "targetname");
  var_18 = spawn("script_model", (-168, -900, -30));
  var_18.angles = (347, 297, 31);
  var_18 clonebrushmodeltoscriptmodel(var_17);
}

function show_hint_after_delay() {
  var_0 = spawn("script_model", (-2337.07, 647.259, 158.378));
  var_0 setModel("hat_beanie_oversize_easteregg");
  var_0.angles = (295.692, 75.6707, 96.2589);
  var_1 = spawn("script_model", (1158.6, -1321.99, 69.144));
  var_1 setModel("hat_beanie_oversize_easteregg");
  var_1.angles = (276.6, 207.401, 62.2173);
}