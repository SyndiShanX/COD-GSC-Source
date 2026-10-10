/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7eba29b89650250f.gsc
*************************************************/

#using script_1311c5c284dd1537;
#using script_214d58c008016194;
#using script_42f4027537fab342;
#using script_47b0fd77895a43e2;
#using script_72e23080a62e4487;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\anim;
#using scripts\mp\animation_suite;
#using scripts\mp\compass;
#using scripts\mp\equipment\tactical_cover;
#using scripts\mp\flags;
#using scripts\mp\load;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\game;
#namespace mp_farm_18;

function main() {
  namespace_f782afdc4d02c105::main();
  namespace_2a5e4638dbbb96fe::main();
  namespace_f034001b30a40fa2::main();
  namespace_3b30c0a4c6fee448::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  namespace_5633828963c62e57::function_57d6a393b90824dc(350);
  scripts\mp\compass::setupminimap("compass_map_mp_farm_18");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level function_3c37e8e4377aa2b3();
  thread play_movie("mp_farm18_screens");
  thread scripts\mp\animation_suite::animationsuite();
  function_a1bd461c63d9c43b();
  level.modifiedspawnpoints["-1272 -1872"]["mp_dm_spawn_start"]["origin"] = (-1280, -1664, 24);
  level thread function_31dc060e85f4a689();
}

function function_1682cf22619a5e55() {}

function function_a1bd461c63d9c43b() {
  if(getdvarint(@ "hash_cefb6aed35221a1d", 1)) {
    var_3fafc39ac7463e68 = spawn("trigger_radius", (517, -156, 1055), 0, 4000, 1000);
    level.outofboundstriggers[level.outofboundstriggers.size] = var_3fafc39ac7463e68;
  }
}

function play_movie(bink) {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") == 1) {
    return;
  }

  while(true) {
    if(flag("nuke_bink_done")) {
      break;
    }

    setDvar(@ "hash_d3ee5a6578fe61de", "0");
    playcinematicforalllooping(bink);
    wait 3;
  }
}

function function_3c37e8e4377aa2b3() {
  scripts\mp\equipment\tactical_cover::function_c5d3d6e10bd8c8ab((1016, 93, 8), 0);
  scripts\mp\equipment\tactical_cover::function_c5d3d6e10bd8c8ab((-824, -820, 66), 0);
  scripts\mp\equipment\tactical_cover::function_c5d3d6e10bd8c8ab((64, -468, 8), 0);
  scripts\mp\equipment\tactical_cover::function_c5d3d6e10bd8c8ab((64, -220, 8), 0);
  scripts\mp\equipment\tactical_cover::function_c5d3d6e10bd8c8ab((-842, 162, -128), 0);
  scripts\mp\equipment\tactical_cover::function_c5d3d6e10bd8c8ab((-780.005, -735.283, 8), 1);
  scripts\mp\equipment\tactical_cover::function_c5d3d6e10bd8c8ab((-959.417, -824.306, -80.4122), 1);
  scripts\mp\equipment\tactical_cover::function_c5d3d6e10bd8c8ab((1202, 306, 16), 0);
  scripts\mp\equipment\tactical_cover::function_c5d3d6e10bd8c8ab((1422, 426, 16), 0);
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
    case #"hash_3a17de6e294210d2":
    case #"hash_7485fa6c474ec865":
    case #"hash_b0eb18371d980895":
    case #"hash_b9458959b10637f8":
    case #"hash_c3668076a0827ce0":
    case #"hash_dd5b900f435d3f36":
    case #"hash_ea061d29bbd1f237":
    case #"hash_ec24570718a340f5":
      level.modifiedspawnpoints["1018 -2705"]["mp_tdm_spawn_allies_start"]["remove"] = 1;
      level.modifiedspawnpoints["970 -2705"]["mp_tdm_spawn_allies_start"]["remove"] = 1;
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn_allies_start", (344, -1855, 24), (0, 90, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn_allies_start", (400, -1855, 24), (0, 90, 0), undefined, undefined);
      break;
    case #"hash_6efb0f59a62300fb":
      break;
    case #"hash_fa0ed9f6bd4f4e9a":
    case #"hash_fb5b5e6c07253005":
      break;
    case #"hash_f4a9126c03d3385b":
      break;
  }

  if(spawns.size > 0) {
    scripts\mp\spawnlogic::addscriptedspawnpoints(spawns);
  }
}