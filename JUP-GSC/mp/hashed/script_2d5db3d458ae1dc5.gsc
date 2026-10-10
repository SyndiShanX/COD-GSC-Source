/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2d5db3d458ae1dc5.gsc
*************************************************/

#using script_116b16251a6ff950;
#using script_3bfcbbd02540ce3e;
#using script_66843f0d9500dac4;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\animation_suite;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\game;
#namespace mp_m_exhibit;

function main() {
  namespace_f1e819a79c9e0494::main();
  namespace_a346311e74b7c274::main();
  namespace_30b11c88a1afea02::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::registersmallmap();
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_m_exhibit");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread scripts\mp\animation_suite::animationsuite();
  function_da52d377ff534ecc();
}

function function_da52d377ff534ecc() {
  spawns = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case #"hash_c51506c10984515":
    case #"hash_21eed743fb721f4a":
    case #"hash_31104ebc01bd9ba9":
    case #"hash_3696c16c262a0862":
    case #"hash_77eb1179a728005e":
    case #"hash_fa0ed9f6bd4f4e9a":
    case #"hash_fb5b5e6c07253005":
      spawns[spawns.size] = createscriptedspawnpoint("mp_dm_spawn_start", drop_to_ground((656, -1008, -144), 100, -100), (0, 180, 0));
      spawns[spawns.size] = createscriptedspawnpoint("mp_dm_spawn_start", drop_to_ground((656, -464, -48), 100, -100), (0, 135, 0));
      spawns[spawns.size] = createscriptedspawnpoint("mp_dm_spawn_start", drop_to_ground((384, -128, -48), 100, -100), (0, 270, 0));
      spawns[spawns.size] = createscriptedspawnpoint("mp_dm_spawn_start", drop_to_ground((240, 456, -48), 100, -100), (0, 270, 0));
      spawns[spawns.size] = createscriptedspawnpoint("mp_dm_spawn_start", drop_to_ground((-352, -1472, -48), 100, -100), (0, 90, 0));
      spawns[spawns.size] = createscriptedspawnpoint("mp_dm_spawn_start", drop_to_ground((-512, -896, -48), 100, -100), (0, 90, 0));
      spawns[spawns.size] = createscriptedspawnpoint("mp_dm_spawn_start", drop_to_ground((-752, -560, -48), 100, -100), (0, 315, 0));
      spawns[spawns.size] = createscriptedspawnpoint("mp_dm_spawn_start", drop_to_ground((-784, -8, -144), 100, -100), (0, 0, 0));
      break;
  }

  if(spawns.size > 0) {
    addscriptedspawnpoints(spawns);
  }
}