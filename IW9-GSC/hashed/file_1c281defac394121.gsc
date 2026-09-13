/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1c281defac394121.gsc
***********************************************/

main() {
  _id_531126308CF12F02::main();
  _id_55058391CD43BB18::main();
  _id_7ACAA8F3ED4611ED::main();
  _id_7E4251BB1AF4180A::main();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_m_blacksite2");
  thread _id_132A917B60035B48();
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  setDvar("r_umbraMinObjectContribution", 8);
  thread scripts\mp\animation_suite::animationsuite();
  scripts\cp_mp\utility\game_utility::registersmallmap();
  scripts\cp_mp\utility\game_utility::registerarenamap();
  thread _id_6E3CCE6A02667476();
}

_id_DA7C9335E454C032(player) {
  if(getdvarint("camera_thirdPerson") == 1 || istrue(level._id_DC65C33DFDD9EFE8))
    setDvar("camera_thirdpersonforceinteriorcamera", 1);
}

_id_6E3CCE6A02667476() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);
    _id_DA7C9335E454C032(player);
    player thread _id_5B2361E97848CABD();
  }
}

_id_5B2361E97848CABD() {
  self endon("disconnect");
  level waittill("game_ended");
  setDvar("camera_thirdpersonforceinteriorcamera", 0);
}

_id_132A917B60035B48() {
  _id_9EFC16C371B26A71 = spawn("trigger_rotatable_radius", (265, 554, 8), 0, 256, 256);
  _id_9EFC16C371B26A71.angles = (90, 0, 0);
  _id_9EFC16C371B26A71.targetname = "callout_area";
  _id_9EFC16C371B26A71.script_noteworthy = "Cells";
  _id_B5F33DE5958A1664 = spawn("trigger_rotatable_radius", (-519, -227, 8), 0, 256, 600);
  _id_B5F33DE5958A1664.angles = (90, 90, 0);
  _id_B5F33DE5958A1664.targetname = "callout_area";
  _id_B5F33DE5958A1664.script_noteworthy = "Interrogation Rooms";
  _id_10FA32E77E7A9E9C = spawn("trigger_rotatable_radius", (437, -701, 1), 0, 256, 512);
  _id_10FA32E77E7A9E9C.angles = (90, 90, 0);
  _id_10FA32E77E7A9E9C.targetname = "callout_area";
  _id_10FA32E77E7A9E9C.script_noteworthy = "Prisoner Cage";
  _id_2A1B57069FF61256 = spawn("trigger_rotatable_radius", (-272, -945, 0), 0, 256, 512);
  _id_2A1B57069FF61256.angles = (90, 0, 0);
  _id_2A1B57069FF61256.targetname = "callout_area";
  _id_2A1B57069FF61256.script_noteworthy = "Firing Line";
  _id_3573A1006D871FA1 = spawn("trigger_rotatable_radius", (-386, 866, -2), 0, 256, 512);
  _id_3573A1006D871FA1.angles = (90, 0, 0);
  _id_3573A1006D871FA1.targetname = "callout_area";
  _id_3573A1006D871FA1.script_noteworthy = "Destroyed Van";
}