/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_657bf1fc6a104ad1.gsc
***********************************************/

main() {
  _id_24E08B5F5DACCF9D::main();
  _id_49D8FEC6587791CE::main();
  _id_2B63F05999A45692::main();
  scripts\mp\load::main();
  _id_074922A76F9FD2DE = spawn("trigger_radius", (-1876, 1444, -284), 0, 256, 512);
  _id_074922A76F9FD2DE.angles = (0, 0, 0);
  _id_074922A76F9FD2DE.targetname = "OutOfBounds";
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_strike");
  _id_1311C5C284DD1537::_id_57D6A393B90824DC(600);
  setDvar("r_umbraAccurateOcclusionThreshold", 1024);
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "middle_east";
  thread _id_E30D49BED3DBED35();
  thread _id_B385569E197AE59B();
  wait 12;
  scripts\engine\utility::exploder("birds_flyaway");
}

_id_B385569E197AE59B() {
  scripts\engine\utility::flag_wait("rockable_cars_init");

  foreach(car in level.rockablecars.cars) {
    if(car getscriptableparthasstate("Window_Blast", "hide")) {
      car setscriptablepartstate("Window_Blast", "hide");
      continue;
    }

    car setscriptablepartstate("Window_Blast", "destroyed");
  }
}

_id_E30D49BED3DBED35() {
  level endon("disconnect");
  _id_322632ABECAA3FCC = spawn("trigger_radius", (-1804, -1248, 168), 0, 32, 32);
  _id_322632ABECAA3FCC.angles = (0, 0, 0);
  _id_322632ABECAA3FCC.targetname = "tacCameraInvalid";
  _id_322635ABECAA4665 = spawn("trigger_radius", (1236, 712, 12), 0, 32, 32);
  _id_322635ABECAA4665.angles = (0, 0, 0);
  _id_322635ABECAA4665.targetname = "tacCameraInvalid";
  _id_322634ABECAA4432 = spawn("trigger_radius", (-1428, 612, 68), 0, 32, 32);
  _id_322634ABECAA4432.angles = (0, 0, 0);
  _id_322634ABECAA4432.targetname = "tacCameraInvalid";
  _id_32262FABECAA3933 = spawn("trigger_radius", (-592, -1672, 140), 0, 32, 32);
  _id_32262FABECAA3933.angles = (0, 0, 0);
  _id_32262FABECAA3933.targetname = "tacCameraInvalid";
  _id_32262EABECAA3700 = spawn("trigger_radius", (624, -1144, 40), 0, 32, 32);
  _id_32262EABECAA3700.angles = (0, 0, 0);
  _id_32262EABECAA3700.targetname = "tacCameraInvalid";
  _id_322631ABECAA3D99 = spawn("trigger_radius", (-524, -2508, 200), 0, 32, 32);
  _id_322631ABECAA3D99.angles = (0, 0, 0);
  _id_322631ABECAA3D99.targetname = "tacCameraInvalid";
  _id_322630ABECAA3B66 = spawn("trigger_radius", (256, 1412, 20), 0, 32, 32);
  _id_322630ABECAA3B66.angles = (0, 0, 0);
  _id_322630ABECAA3B66.targetname = "tacCameraInvalid";
  _id_32263BABECAA5397 = spawn("trigger_radius", (664, -1304, 188), 0, 32, 32);
  _id_32263BABECAA5397.angles = (0, 0, 0);
  _id_32263BABECAA5397.targetname = "tacCameraInvalid";
  _id_32263AABECAA5164 = spawn("trigger_radius", (-844, -432, 144), 0, 32, 32);
  _id_32263AABECAA5164.angles = (0, 0, 0);
  _id_32263AABECAA5164.targetname = "tacCameraInvalid";
  _id_F4416C197A6AB734 = spawn("trigger_radius", (1308, -492, 76), 0, 32, 32);
  _id_F4416C197A6AB734.angles = (0, 0, 0);
  _id_F4416C197A6AB734.targetname = "tacCameraInvalid";
  _id_F4416D197A6AB967 = spawn("trigger_radius", (1206, 616, 58), 0, 16, 16);
  _id_F4416D197A6AB967.angles = (0, 0, 0);
  _id_F4416D197A6AB967.targetname = "tacCameraInvalid";
}