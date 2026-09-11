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
  setDvar("PKKMTTRQO", 8);
  setDvar("NSSMQLPRNT", 0.01);
  setDvar("MQPQKNPQOK", 3);
  setDvar("MRNRKKOPLN", 3);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "woodland";
  game["axis_outfit"] = "woodland";
  thread player_exfil_struct();
  thread show_hint_after_delay();
}

function player_exfil_struct() {
  var0 = spawn("script_model", (1016, -1233, 45));
  var0 setModel("me_construction_plank_bridge_a_17");
  var0.angles = (0, 0, 0);
  var1 = getEnt("clip512x512x8", "targetname");
  var2 = spawn("script_model", (1178, -1004, -88));
  var2.angles = (90, 0, 0);
  var2 clonebrushmodeltoscriptmodel(var1);
  var3 = getEnt("clip256x256x8", "targetname");
  var4 = spawn("script_model", (1056, -908, 40));
  var4.angles = (0, 0, -90);
  var4 clonebrushmodeltoscriptmodel(var3);
  var5 = getEnt("clip128x128x8", "targetname");
  var6 = spawn("script_model", (-952, -1368, 12));
  var6.angles = (22, 15, 0);
  var6 clonebrushmodeltoscriptmodel(var5);
  var7 = getEnt("nosight256x256x8", "targetname");
  var8 = spawn("script_model", (1060, -892, 48));
  var8.angles = (0, 0, -90);
  var8 clonebrushmodeltoscriptmodel(var7);
  var9 = getEnt("nosight128x128x8", "targetname");
  var10 = spawn("script_model", (868, -892, 160));
  var10.angles = (0, 0, -90);
  var10 clonebrushmodeltoscriptmodel(var9);
  var11 = getEnt("clip64x64x64", "targetname");
  var12 = spawn("script_model", (-405, -1725, 35));
  var12.angles = (0, 0, 0);
  var12 clonebrushmodeltoscriptmodel(var11);
  var13 = getEnt("clip128x128x128", "targetname");
  var14 = spawn("script_model", (-956, 1408, 28));
  var14.angles = (3, 345, 22);
  var14 clonebrushmodeltoscriptmodel(var13);
  var15 = getEnt("clip64x64x64", "targetname");
  var16 = spawn("script_model", (-516, -948, -40));
  var16.angles = (0, 320, 0);
  var16 clonebrushmodeltoscriptmodel(var15);
  var17 = getEnt("clip64x64x64", "targetname");
  var18 = spawn("script_model", (-168, -900, -30));
  var18.angles = (347, 297, 31);
  var18 clonebrushmodeltoscriptmodel(var17);
}

function show_hint_after_delay() {
  var0 = spawn("script_model", (-2337.07, 647.259, 158.378));
  var0 setModel("hat_beanie_oversize_easteregg");
  var0.angles = (295.692, 75.6707, 96.2589);
  var1 = spawn("script_model", (1158.6, -1321.99, 69.144));
  var1 setModel("hat_beanie_oversize_easteregg");
  var1.angles = (276.6, 207.401, 62.2173);
}