/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_162fa4c633ed9a35.gsc
***********************************************/

main() {
  _id_553FED92E00BE772::main();
  _id_7084EBF53F3BB58E::main();
  _id_1A6B6463763C95D4::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::registersmallmap();
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_m_lounge");
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread play_movie("mp_lounge_video_wall_anim_01");
}

play_movie(bink) {
  if(getdvarint("r_reflectionprobegenerate") == 1) {
    return;
  }
  for(;;) {
    _func_CE942237D1ECA7D8(bink);
    wait 3;
  }
}