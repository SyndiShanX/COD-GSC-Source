/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6dcc0d17d865af91.gsc
***********************************************/

main() {
  _id_1870E90529EB0822::main();
  _id_0D7628A6DFC41B52::main();
  _id_09510F49310DE468::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_shipment_iw9");
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_umbraAccurateOcclusionThreshold", 384);
  scripts\cp_mp\utility\game_utility::registersmallmap();

  if(level.gametype == "arena")
    scripts\cp_mp\utility\game_utility::registerarenamap();

  if(getdvarint("dvar_75C08B5D09E65C6C", 1) == 1)
    level._id_E886C825DC0634C0 = 1;

  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread _id_E182FB0ACB8F13DB();
  thread scripts\mp\animation_suite::animationsuite();
  level _id_3C37E8E4377AA2B3();
  level.gethillspawnshutoffradius = ::_id_69FCDBEC24A02352;
}

_id_69FCDBEC24A02352() {
  return getdvarint("dvar_C0CF50F594CC8ECC", 512);
}

_id_E182FB0ACB8F13DB() {
  wait 1.0;
  scripts\engine\utility::exploder("shipsplash_back_l");
}

_id_3C37E8E4377AA2B3() {
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((-356, -292, -184), 1);
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((-348, -856, -184), 1);
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((-1032, -356, -184), 1);
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((-1100, -120, -184), 0);
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((-596, 336, -184), 1);
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((140, -112, -184), 1);
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((80, -356, -184), 0);
}