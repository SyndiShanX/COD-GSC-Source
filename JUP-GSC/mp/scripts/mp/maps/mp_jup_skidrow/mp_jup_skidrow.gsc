/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\maps\mp_jup_skidrow\mp_jup_skidrow.gsc
****************************************************************/

#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\anim;
#using scripts\mp\compass;
#using scripts\mp\flags;
#using scripts\mp\gametypes\robj;
#using scripts\mp\gametypes\xfire;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_skidrow\gen\mp_jup_skidrow_art;
#using scripts\mp\maps\mp_jup_skidrow\mp_jup_skidrow_fx;
#using scripts\mp\maps\mp_jup_skidrow\mp_jup_skidrow_lighting;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\game;
#namespace mp_jup_skidrow;

function main() {
  scripts\mp\maps\mp_jup_skidrow\gen\mp_jup_skidrow_art::main();
  scripts\mp\maps\mp_jup_skidrow\mp_jup_skidrow_fx::main();
  scripts\mp\maps\mp_jup_skidrow\mp_jup_skidrow_lighting::main();
  scripts\mp\load::main();
  level.var_3ac8a33643641ede = &scripts\mp\gametypes\robj::main;
  level.var_3ac8a33643641ede = &scripts\mp\gametypes\xfire::main;
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_jup_skidrow");
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
      break;
    case #"hash_6efb0f59a62300fb":
    case #"hash_fa34c5f6bd6d4432":
      level.modifiedspawnpoints["-316 -636"]["mp_koth_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-397 753"]["mp_koth_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-706 922"]["mp_koth_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["120 -412"]["mp_koth_spawn"]["remove"] = 1;
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (1027, -160, 31.5202), (0, 180, 0), undefined, "1");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (1121, -890, 27.6562), (0, 180, 0), undefined, "1");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (869, -1514, 23.3356), (0, 135, 0), undefined, "1");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (389, -1430, 22), (0, 105, 0), undefined, "1");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-286, 916, 104), (0, 311, 0), undefined, "2");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-1078, 896, 104), (0, 319, 0), undefined, "2");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-980, 344, 160), (0, 335, 0), undefined, "2");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-1880, -1927, 11.0446), (0, 14, 0), undefined, "2");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-947, -1170, 22.1151), (0, 274, 0), undefined, "2");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-1228, -1733, 10), (0, 4, 0), undefined, "2");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (1552, 442, 27.5866), (0, 213, 0), undefined, "2");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (1820, -662, 28.4652), (0, 191, 0), undefined, "2");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (1310, -32, 33.96), (0, 185, 0), undefined, "2");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (196, 298, 38.0655), (0, 293, 0), undefined, "2");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-1908, -2115, 0.749998), (0, 32, 0), undefined, "2");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-1894, -1677, 0.749998), (0, 346, 0), undefined, "2");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-2252, 206, 28), (0, 0, 0), undefined, "3");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-1910, 98, 28), (0, 6, 0), undefined, "3");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-2204, -1276, 64), (0, 20, 0), undefined, "3");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-2036, -1514, -31.1065), (0, 76, 0), undefined, "3");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-954, -2222, 105.836), (0, 66, 0), undefined, "3");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (1038, -1886, 56), (0, 106, 0), undefined, "3");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (1050, -1865, 56), (0, 180, 0), undefined, "4");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (1246, -1537, 25.5117), (0, 180, 0), undefined, "4");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (1058, -899, 29.3387), (0, 210, 0), undefined, "4");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (838, -587, 30.3361), (0, 244, 0), undefined, "4");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (256, -565, 29), (0, 268, 0), undefined, "4");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (396, 223, 34.1571), (0, 240, 0), undefined, "4");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (296, -9, 26.677), (0, 240, 0), undefined, "4");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (1054, -137, 30.831), (0, 184, 0), undefined, "4");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (1824, -669, 29.0055), (0, 182, 0), undefined, "4");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (580, -565, 28.026), (0, 270, 0), undefined, "4");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (1370, -451, 24.224), (0, 246, 0), undefined, "4");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (1144, -1081, 25.932), (0, 210, 0), undefined, "4");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (1243, 254, 37.5505), (0, 236, 0), undefined, "4");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-1764, 275, 21.3463), (0, 312, 0), undefined, "4");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-2220, 243, 36), (0, 272, 0), undefined, "4");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-1364, 911, 16), (0, 270, 0), undefined, "4");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-2032, 261, 8), (0, 342, 0), undefined, "4");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-976, -2225, 105.722), (0, 50, 0), undefined, "5");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-1274, -1821, 14), (0, 347, 0), undefined, "5");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-1424, -1633, 16), (0, 347, 0), undefined, "5");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-1494, 687, 17.1991), (0, 0, 0), undefined, "5");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-978, 363, 160.587), (0, 333, 0), undefined, "5");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-742, 779, 104), (0, 359, 0), undefined, "5");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-344, 915, 104), (0, 323, 0), undefined, "5");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-864, -177, 158), (0, 0, 0), undefined, "5");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-842, -2217, 105.722), (0, 49, 0), undefined, "5");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-1272, -1633, 16), (0, 325, 0), undefined, "5");
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_koth_spawn", (-1742, -1969, 13.6875), (0, 15, 0), undefined, "5");
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
      break;
  }

  if(spawns.size > 0) {
    scripts\mp\spawnlogic::addscriptedspawnpoints(spawns);
  }
}