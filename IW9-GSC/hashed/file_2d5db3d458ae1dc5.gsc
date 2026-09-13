/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2d5db3d458ae1dc5.gsc
***********************************************/

main() {
  _id_116B16251A6FF950::main();
  _id_3BFCBBD02540CE3E::main();
  _id_66843F0D9500DAC4::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::registersmallmap();
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_m_exhibit");
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread scripts\mp\animation_suite::animationsuite();
  _id_DA52D377FF534ECC();
}

_id_DA52D377FF534ECC() {
  _id_29D9D2428185616D = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "oic":
    case "aon":
    case "gun":
    case "dm":
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn_start", scripts\engine\utility::drop_to_ground((656, -1008, -144), 100, -100), (0, 180, 0));
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn_start", scripts\engine\utility::drop_to_ground((656, -464, -48), 100, -100), (0, 135, 0));
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn_start", scripts\engine\utility::drop_to_ground((384, -128, -48), 100, -100), (0, 270, 0));
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn_start", scripts\engine\utility::drop_to_ground((240, 456, -48), 100, -100), (0, 270, 0));
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn_start", scripts\engine\utility::drop_to_ground((-352, -1472, -48), 100, -100), (0, 90, 0));
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn_start", scripts\engine\utility::drop_to_ground((-512, -896, -48), 100, -100), (0, 90, 0));
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn_start", scripts\engine\utility::drop_to_ground((-752, -560, -48), 100, -100), (0, 315, 0));
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn_start", scripts\engine\utility::drop_to_ground((-784, -8, -144), 100, -100), (0, 0, 0));
      break;
  }

  if(_id_29D9D2428185616D.size > 0)
    scripts\mp\spawnlogic::addscriptedspawnpoints(_id_29D9D2428185616D);
}