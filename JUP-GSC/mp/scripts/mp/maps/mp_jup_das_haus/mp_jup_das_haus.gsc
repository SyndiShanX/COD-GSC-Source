/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_das_haus\mp_jup_das_haus.gsc
***************************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_das_haus\gen\mp_jup_das_haus_art;
#using scripts\mp\maps\mp_jup_das_haus\mp_jup_das_haus_fx;
#using scripts\mp\maps\mp_jup_das_haus\mp_jup_das_haus_lighting;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\game;
#namespace mp_jup_das_haus;

function main() {
  scripts\mp\maps\mp_jup_das_haus\gen\mp_jup_das_haus_art::main();
  scripts\mp\maps\mp_jup_das_haus\mp_jup_das_haus_fx::main();
  scripts\mp\maps\mp_jup_das_haus\mp_jup_das_haus_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_jup_das_haus");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  scripts\cp_mp\utility\game_utility::registersmallmap();
  setDvar(@ "hash_b578e14e8fb9fcbf", 270);
  level thread function_31dc060e85f4a689();
}

function function_31dc060e85f4a689() {
  spawns = [];

  switch (getbasegametype()) {
    case #"hash_1a5d186c17c00d3c":
      break;
    case #"hash_a1313b745c17c07e":
      break;
    case #"hash_fa50b0f6bd82e972":
    case #"hash_fa50baf6bd82f930":
      break;
    case #"hash_2fcf99fb5dbdcffb":
    case #"hash_3a17de6e294210d2":
    case #"hash_515260130b210bff":
    case #"hash_7485fa6c474ec865":
    case #"hash_973d1db8b6644466":
    case #"hash_b0eb18371d980895":
    case #"hash_b9458959b10637f8":
    case #"hash_c3668076a0827ce0":
    case #"hash_dd5b900f435d3f36":
    case #"hash_ddd385f0a27d71bb":
    case #"hash_ea061d29bbd1f237":
    case #"hash_ec24570718a340f5":
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (-494, 256, 182), (0, 320, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (-490, 364, 184), (0, 303, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (-424, 378, 184), (0, 294, 0), undefined, undefined);
      break;
    case #"hash_6efb0f59a62300fb":
    case #"hash_fa34c5f6bd6d4432":
      break;
    case #"hash_c51506c10984515":
    case #"hash_21eed743fb721f4a":
    case #"hash_31104ebc01bd9ba9":
    case #"hash_3696c16c262a0862":
    case #"hash_77eb1179a728005e":
    case #"hash_fa0ed9f6bd4f4e9a":
    case #"hash_fb5b5e6c07253005":
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn", (-490, 364, 184), (0, 303, 0), undefined, undefined);
      break;
    case #"hash_f4a9126c03d3385b":
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (-494, 256, 182), (0, 320, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (-490, 364, 184), (0, 303, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (-424, 378, 184), (0, 294, 0), undefined, undefined);
      break;
  }

  if(spawns.size > 0) {
    scripts\mp\spawnlogic::addscriptedspawnpoints(spawns);
  }
}