/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_afghan_v2\mp_jup_afghan_v2.gsc
*****************************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_afghan_v2\gen\mp_jup_afghan_v2_art;
#using scripts\mp\maps\mp_jup_afghan_v2\mp_jup_afghan_v2_fx;
#using scripts\mp\maps\mp_jup_afghan_v2\mp_jup_afghan_v2_lighting;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\game;
#namespace mp_jup_afghan_v2;

function main() {
  scripts\mp\maps\mp_jup_afghan_v2\gen\mp_jup_afghan_v2_art::main();
  scripts\mp\maps\mp_jup_afghan_v2\mp_jup_afghan_v2_fx::main();
  scripts\mp\maps\mp_jup_afghan_v2\mp_jup_afghan_v2_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_jup_afghan_v2");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level thread function_31dc060e85f4a689();
}

function function_31dc060e85f4a689() {
  spawns = [];
  var_923701ecd534bd51 = "hc";
  gametype = getgametype();
  tokens = strtok(gametype, "_");

  if(tokens[0] == var_923701ecd534bd51) {
    gametype = tokens[tokens.size - 1];
  }

  switch (gametype) {
    case #"hash_25397d96e5bc8403":
      break;
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
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn_allies_start", (-266, -770, -94.8919), (0, 30, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn_allies_start", (-298, -720, -106.069), (0, 30, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn_axis_start", (4013, 2534, 9.8848), (0, 180, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn_axis_start", (4023, 2458, 20.9982), (0, 180, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (-1278, 1676, 73.8424), (0, 282, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (-1237.5, 1273, 95.5531), (0, 12, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (-435.5, 277.5, 102.626), (0, 116, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (-440.5, 939, 235.066), (0, 86, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (175.5, 63, 37.4167), (0, 5, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (2105.5, -262.5, 144.795), (0, 95, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (2578, 33.5, 159.513), (0, 5, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (4433.5, 886, 137.484), (0, 180, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (3744, 1580, 133.184), (0, 149, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (3381.5, 1676.5, 95.5238), (0, 65, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (2741.5, 3253, 147.432), (0, 287, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (2115.5, 3078, 301.382), (0, 237, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (2377, 3518.5, 210.407), (0, 356, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (1448.5, 2848, 310.591), (0, 335, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (1081, 3073, 295.934), (0, 323, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (1168, 3784.5, 288.6), (0, 323, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (586, 2806.5, 284.296), (0, 260, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (540, 2068.5, 198.891), (0, 99, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (56, 2329, 211.967), (0, 61, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (68, 3198, 64.146), (0, 0, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (-301.5, 2957, 0.150673), (0, 11, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (-276, 2248, 156.165), (0, 5, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (-440, 2158, 100.199), (0, 275, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (68, 1723, 233.788), (0, 348, 0), undefined, undefined);
      break;
    case #"hash_6efb0f59a62300fb":
    case #"hash_fa34c5f6bd6d4432":
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_allies_start", (-291, -790, -98.3433), (0, 30, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_allies_start", (-333, -620, -101.948), (0, 30, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_axis_start", (3977, 2390, 31.8545), (0, 180, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_axis_start", (3977, 2326, 52.7917), (0, 180, 0), undefined, undefined);
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
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn_allies_start", (-310, -724, -108.176), (0, 30, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn_allies_start", (-330, -616, -100.955), (0, 30, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn_axis_start", (4009, 2450, 22.6466), (0, 180, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn_axis_start", (4005, 2386, 33.656), (0, 180, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (-1278, 1676, 73.8424), (0, 282, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (-1237.5, 1273, 95.5531), (0, 12, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (-435.5, 277.5, 102.626), (0, 322, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (-440.5, 939, 235.066), (0, 86, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (175.5, 63, 37.4167), (0, 5, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (2105.5, -262.5, 144.795), (0, 95, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (2578, 33.5, 159.513), (0, 5, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (4433.5, 886, 137.484), (0, 180, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (3744, 1580, 133.184), (0, 149, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (3381.5, 1676.5, 95.5238), (0, 65, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (2741.5, 3253, 147.432), (0, 287, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (2115.5, 3078, 301.382), (0, 237, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (2377, 3518.5, 210.407), (0, 356, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (1448.5, 2848, 310.591), (0, 335, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (1081, 3073, 295.934), (0, 323, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (1168, 3784.5, 288.6), (0, 323, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (586, 2806.5, 284.296), (0, 260, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (540, 2068.5, 198.891), (0, 99, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (56, 2329, 211.967), (0, 61, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (68, 3198, 64.146), (0, 0, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (-301.5, 2957, 0.150673), (0, 11, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (-276, 2248, 156.165), (0, 5, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (-440, 2158, 100.199), (0, 275, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (68, 1723, 233.788), (0, 348, 0), undefined, undefined);
      break;
  }

  if(spawns.size > 0) {
    scripts\mp\spawnlogic::addscriptedspawnpoints(spawns);
  }
}