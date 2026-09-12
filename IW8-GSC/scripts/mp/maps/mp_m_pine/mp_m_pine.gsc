/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_m_pine\mp_m_pine.gsc
***************************************************/

function main() {
  scripts\mp\maps\mp_m_pine\mp_m_pine_precache::main();
  scripts\mp\maps\mp_m_pine\gen\mp_m_pine_art::main();
  scripts\mp\maps\mp_m_pine\mp_m_pine_fx::main();
  scripts\mp\maps\mp_m_pine\mp_m_pine_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_m_pine", "codcaster_compass_map_mp_m_pine");
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.requiresminstartspawns = 0;
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_sunIntensityHeatOverride", 0.01);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "woodland";
  game["axis_outfit"] = "woodland";
  thread ref_121f4();
}

function ref_121f4() {
  var_0 = spawn("script_model", (-89.5, 105.5, 98));
  var_0 setModel("lm_pipes_high_pressure_128");
  var_0.angles = (90, 290, 40);
  var_1 = spawn("script_model", (136.5, -24.5, 98));
  var_1 setModel("lm_pipes_high_pressure_128");
  var_1.angles = (90, 270, 0);
  var_2 = spawn("script_model", (89.5, -106, 98));
  var_2 setModel("lm_pipes_high_pressure_128");
  var_2.angles = (90, 280, 55);
  var_3 = spawn("script_model", (295, -398.5, 25.5));
  var_3 setModel("me_construction_plank_bridge_a_16");
  var_3.angles = (270, 330, 0);
  var_4 = spawn("script_model", (-300, 406, 15.5));
  var_4 setModel("me_construction_plank_bridge_a_16");
  var_4.angles = (274, 240, 90);
  var_5 = spawn("script_model", (-374, 291.5, 28));
  var_5 setModel("me_construction_plank_bridge_a_11");
  var_5.angles = (90, 352, 6);
  var_6 = spawn("script_model", (0, 0, 0));
  var_6 setModel("mp_m_pine_shot_block");
  var_6.angles = (0, 0, 0);
}