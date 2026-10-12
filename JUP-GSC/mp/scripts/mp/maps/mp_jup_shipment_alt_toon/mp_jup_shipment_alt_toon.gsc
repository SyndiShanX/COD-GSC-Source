/*********************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_shipment_alt_toon\mp_jup_shipment_alt_toon.gsc
*********************************************************************************/

#using scripts\common\anim;
#using scripts\common\exploder;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\anim;
#using scripts\mp\animation_suite;
#using scripts\mp\compass;
#using scripts\mp\equipment\tactical_cover;
#using scripts\mp\flags;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_shipment_alt_toon\gen\mp_jup_shipment_alt_toon_art;
#using scripts\mp\maps\mp_jup_shipment_alt_toon\mp_jup_shipment_alt_toon_fx;
#using scripts\mp\maps\mp_jup_shipment_alt_toon\mp_jup_shipment_alt_toon_lighting;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\game;
#namespace mp_jup_shipment_alt_toon;

function main() {
  scripts\mp\maps\mp_jup_shipment_alt_toon\gen\mp_jup_shipment_alt_toon_art::main();
  scripts\mp\maps\mp_jup_shipment_alt_toon\mp_jup_shipment_alt_toon_fx::main();
  scripts\mp\maps\mp_jup_shipment_alt_toon\mp_jup_shipment_alt_toon_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_jup_shipment_xmas");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  setDvar(@ "r_umbraaccurateocclusionthreshold", 384);
  scripts\cp_mp\utility\game_utility::registersmallmap();

  if(level.gametype == "arena") {
    scripts\cp_mp\utility\game_utility::registerarenamap();
  }

  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread function_e182fb0acb8f13db();
  thread scripts\mp\animation_suite::animationsuite();
  thread function_31dc060e85f4a689();
  level function_3c37e8e4377aa2b3();
  level.var_5cd0b14f081d7d7a = 1;
  level.gethillspawnshutoffradius = &function_69fcdbec24a02352;
}

function function_69fcdbec24a02352() {
  return getdvarint(@ "hash_c0cf50f594cc8ecc", 512);
}

function function_e182fb0acb8f13db() {
  wait 1;
  exploder("shipsplash_back_l");
}

function function_3c37e8e4377aa2b3() {
  scripts\mp\equipment\tactical_cover::function_c5d3d6e10bd8c8ab((-356, -292, -184), 1);
  scripts\mp\equipment\tactical_cover::function_c5d3d6e10bd8c8ab((-348, -856, -184), 1);
  scripts\mp\equipment\tactical_cover::function_c5d3d6e10bd8c8ab((-1032, -356, -184), 1);
  scripts\mp\equipment\tactical_cover::function_c5d3d6e10bd8c8ab((-1100, -120, -184), 0);
  scripts\mp\equipment\tactical_cover::function_c5d3d6e10bd8c8ab((-596, 336, -184), 1);
  scripts\mp\equipment\tactical_cover::function_c5d3d6e10bd8c8ab((140, -112, -184), 1);
  scripts\mp\equipment\tactical_cover::function_c5d3d6e10bd8c8ab((80, -356, -184), 0);
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
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (-1024, -870, -174), (0, 36, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (-790, -496, -174), (0, 92, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (-1126, -394, -174), (0, 296, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (-1026, -380, -174), (0, 288, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (-1014, -118, -174), (0, 90, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (-1110, -72, -174), (0, 54, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (-550, 352, -174), (0, 180, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (62, -94, -174), (0, 98, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (146, -78, -174), (0, 122, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (170, -332, -180), (0, 270, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (170, -390, -180), (0, 196, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn", (-304, 380, -180), (0, 270, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn_secondary", (-430, 340, -174), (0, 180, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn_secondary", (126, -164, -174), (0, 70, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn_secondary", (90, -294, -174), (0, 70, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn_secondary", (-374, -490, -174), (0, 82, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn_secondary", (-430, -870, -176), (0, 0, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn_secondary", (-1056, -288, -174), (0, 286, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_tdm_spawn_secondary", (-1140, -314, -174), (0, 278, 0), undefined, undefined);
      break;
    case #"hash_6efb0f59a62300fb":
    case #"hash_fa34c5f6bd6d4432":
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-1024, -870, -174), (0, 36, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-790, -496, -174), (0, 92, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-1126, -394, -174), (0, 296, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-1026, -380, -174), (0, 288, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-1014, -118, -174), (0, 90, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-1110, -72, -174), (0, 54, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-550, 352, -174), (0, 180, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (62, -94, -174), (0, 98, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (146, -78, -174), (0, 122, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (170, -332, -180), (0, 270, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (170, -390, -180), (0, 196, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-304, 380, -180), (0, 270, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_secondary", (-430, 340, -174), (0, 180, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_secondary", (126, -164, -174), (0, 70, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_secondary", (90, -294, -174), (0, 70, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_secondary", (-374, -490, -174), (0, 82, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_secondary", (-430, -870, -176), (0, 0, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_secondary", (-1056, -288, -174), (0, 286, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn_secondary", (-1140, -314, -174), (0, 278, 0), undefined, undefined);
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
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (-1024, -870, -174), (0, 36, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (-790, -496, -174), (0, 92, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (-1126, -394, -174), (0, 296, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (-1026, -380, -174), (0, 288, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (-1014, -118, -174), (0, 90, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (-1110, -72, -174), (0, 54, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (-550, 352, -174), (0, 180, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (62, -94, -174), (0, 98, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (146, -78, -174), (0, 122, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (170, -332, -180), (0, 270, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn", (170, -390, -180), (0, 196, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn_secondary", (-430, 340, -174), (0, 180, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn_secondary", (126, -164, -174), (0, 70, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn_secondary", (90, -294, -174), (0, 70, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn_secondary", (-430, -870, -176), (0, 0, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn_secondary", (-1056, -288, -174), (0, 286, 0), undefined, undefined);
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dom_spawn_secondary", (-1140, -314, -174), (0, 278, 0), undefined, undefined);
      break;
  }

  if(spawns.size > 0) {
    scripts\mp\spawnlogic::addscriptedspawnpoints(spawns);
  }
}