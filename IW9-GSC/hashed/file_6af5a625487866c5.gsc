/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6af5a625487866c5.gsc
***********************************************/

main() {
  _id_5121A41C5586F690::main();
  _id_6FC26E76E4CD913E::main();
  _id_0BAFB85FAD2A45C4::main();
  scripts\mp\load::main();
  _id_A5AE893A7C81B560 = spawn("trigger_rotatable_radius", (1568, -5052, -4456), 0, 16384, 4096);
  _id_A5AE893A7C81B560.angles = (355, 2.5, -30);
  _id_A5AE893A7C81B560.targetname = "kill_border_trigger";
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_arn_zone1");
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";

  if(getdvarint("dvar_8610CCD25560C117") == 0)
    thread play_movie("mp_arn_zone_video_wall_01");
}

play_movie(bink) {
  if(getdvarint("r_reflectionprobegenerate") == 1) {
    return;
  }
  for(;;) {
    _func_CE942237D1ECA7D8(bink);
    wait 10;
  }
}