/**************************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\maps\mp_jup_slaughterhouse_oct\mp_jup_slaughterhouse_oct.gsc
**************************************************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_slaughterhouse_oct\gen\mp_jup_slaughterhouse_oct_art;
#using scripts\mp\maps\mp_jup_slaughterhouse_oct\mp_jup_slaughterhouse_oct_fx;
#using scripts\mp\maps\mp_jup_slaughterhouse_oct\mp_jup_slaughterhouse_oct_lighting;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\game;
#namespace mp_jup_slaughterhouse_oct;

function main() {
  scripts\mp\maps\mp_jup_slaughterhouse_oct\gen\mp_jup_slaughterhouse_oct_art::main();
  scripts\mp\maps\mp_jup_slaughterhouse_oct\mp_jup_slaughterhouse_oct_fx::main();
  scripts\mp\maps\mp_jup_slaughterhouse_oct\mp_jup_slaughterhouse_oct_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_jup_slaughterhouse_oct");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
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
      level.var_651db79b41b7e7c9 = 0;
      level.modifiedspawnpoints["-1649 -640"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-1559 -504"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-1649 -406"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-1643 -314"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-1567 -246"]["mp_tdm_spawn"]["remove"] = 1;
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (986.01, 717.99, 20), (0, 265, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (1178.01, 669.99, 32), (0, 265, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (1129.99, -242.01, 15.0375), (0, 120, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (1118.01, -326.01, 15.0375), (0, 245, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (993.994, -458.01, 8.00001), (0, 225, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (737.994, -774.01, 8.00001), (0, 220, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (-197.99, -798.006, 8), (0, 50, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (-1101.99, -842.006, 16), (0, 45, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (-1113.99, -742.006, 16), (0, 30, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (-1117.99, -642.006, 16), (0, 0, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (-1661.99, -190.006, 33), (0, 0, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (-1569.99, -150.006, 33), (0, 0, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (-1485.99, -138.006, 33), (0, 0, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (-709.99, 97.994, 68), (0, 0, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (-822, -468, 4), (0, 66, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (-284, -562, -4), (0, 270, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (-440, -560, -4), (0, 306, 0), undefined, undefined);
      break;
    case #"hash_6efb0f59a62300fb":
    case #"hash_fa34c5f6bd6d4432":
      level.var_69ce64f9d9c5dfb9 = 1;
      level.modifiedspawnpoints["1183.5, -841.5, -23"]["mp_koth_spawn"]["removeradius"] = 75;
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (1028, -766, -4), (0, 180, 0), undefined, "4");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (740, -778, -4), (0, 90, 0), undefined, "1");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (740, -778, -4), (0, 90, 0), undefined, "2");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (740, -778, -4), (0, 90, 0), undefined, "3");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (740, -778, -4), (0, 90, 0), undefined, "4");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (740, -778, -4), (0, 90, 0), undefined, "5");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-224, 396, 72), (0, 358, 0), undefined, "4");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (186, 568, 72), (0, 336, 0), undefined, "4");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (298, 786, 80), (0, 336, 0), undefined, "4");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (420, 804, 72), (0, 336, 0), undefined, "4");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (982, 722, 20), (0, 270, 0), undefined, "4");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (1120, 738, 20), (0, 270, 0), undefined, "4");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (1026, -750, -4), (0, 180, 0), undefined, "4");
      break;
    case #"hash_c51506c10984515":
    case #"hash_21eed743fb721f4a":
    case #"hash_31104ebc01bd9ba9":
    case #"hash_3696c16c262a0862":
    case #"hash_77eb1179a728005e":
    case #"hash_fa0ed9f6bd4f4e9a":
    case #"hash_fb5b5e6c07253005":
      break;
    case #"hash_f4a9126c03d3385b":
      level.var_651db79b41b7e7c9 = 0;
      level.modifiedspawnpoints["-1645 -641"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-1564 -497"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-1645 -407"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-1639 -315"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-1576 -245"]["mp_tdm_spawn"]["remove"] = 1;
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (986.01, 717.99, 20), (0, 265, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (1178.01, 669.99, 32), (0, 265, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (1129.99, -242.01, 15.0375), (0, 120, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (1118.01, -326.01, 15.0375), (0, 245, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (993.994, -458.01, 8.00001), (0, 225, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (737.994, -774.01, 8.00001), (0, 220, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (-197.99, -798.006, 8), (0, 50, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (-1101.99, -842.006, 16), (0, 45, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (-1113.99, -742.006, 16), (0, 30, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (-1117.99, -642.006, 16), (0, 0, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (-1661.99, -190.006, 33), (0, 0, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (-1569.99, -150.006, 33), (0, 0, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (-1485.99, -138.006, 33), (0, 0, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (-709.99, 97.994, 68), (0, 0, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (-822, -468, 4), (0, 66, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (-284, -562, -4), (0, 270, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (-440, -560, -4), (0, 306, 0), undefined, undefined);
      break;
  }

  if(spawns.size > 0) {
    scripts\mp\spawnlogic::addscriptedspawnpoints(spawns);
  }
}