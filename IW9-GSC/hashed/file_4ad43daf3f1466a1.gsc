/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4ad43daf3f1466a1.gsc
***********************************************/

main() {
  _id_60047945354CCA38::main();
  _id_7837DF31EB083B82::main();
  _id_30831EEAD8908398::main();
  scripts\mp\load::main();
  level._id_B6A3186C09D2DD34 = getEntArray("dcover_invalid", "targetname");
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_showdown2");
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "middle_east";
}