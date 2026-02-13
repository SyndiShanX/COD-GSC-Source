/*******************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_oasis_v3\mp_oasis_v3.gsc
*******************************************************/

main() {
  scripts\mp\maps\mp_oasis_v3\mp_oasis_v3_precache::main();
  scripts\mp\maps\mp_oasis_v3\gen\mp_oasis_v3_art::main();
  scripts\mp\maps\mp_oasis_v3\mp_oasis_v3_fx::main();
  scripts\mp\maps\mp_oasis_v3\mp_oasis_v3_lighting::main();
  _id_07EC::main();
  _id_07C0::_id_D88B("compass_map_mp_oasis_v3");
  setDvar("#x32ee39981452e9751", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  game["allies"] = "USMC";
  game["axis"] = "ALQ";
  level._id_AD0F = getEntArray("OutOfBounds", "targetname");
  setDvar("#x331157d6a11c2a653", 3000.0);
  setDvar("#x3b94d9d617f14e388", 1200);
  setDvar("#x36d8bf82840d880d2", 1);
  scripts\mp\s4_elf_poi::add_elf_poi_position((-2028, -56, -288), (0, 286.577, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1377.51, 621.132, -415.288), (0, 237.522, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1100.22, -1223.63, -394.965), (0.985, 14.592, -3.779), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-640.238, 561.496, -437.987), (0, 221.071, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-771.105, -814.884, -388.651), (353.495, 322.245, 5.014), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((987.361, 270.217, -466.154), (0, 237.522, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((981.128, 1098.78, -344.775), (353.495, 53.064, 5.011), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((855.609, -342.922, -395.598), (0.985, 99.928, -3.778), "laying");
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("2", (1278.82, -58.969, -432.954), (0, 0, 0));
  level fixpostlaunchspawns();
}

fixpostlaunchspawns() {
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "ctf":
      break;
    case "control":
      break;
    case "sd":
      break;
    case "dm":
    case "gun":
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (1008, 2, -450), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (-664, 710, -412.142), (0, 359, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (-1948, -122, -384), (0, 0, 0));
      break;
    case "dom":
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (1250, -1430, -356.269), (0, 204, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (1882, 428, -432), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (1810, 664, -436.603), (0, 178, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (1030, -422, -370.78), (0, 218, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (932, 1172, -401.259), (0, 200, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (798, 1384, -435.212), (0, 208, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-1970, -1324, -364.845), (0, 354, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-1770, -1158, -380.228), (0, 0, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-1718, -570, -366.989), (0, 0, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-1720, -94, -390.989), (0, 0, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-1942, -386, -366.989), (0, 0, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-1968, -124, -390.989), (0, 0, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-1924, 452, -418.832), (0, 4, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (1320, -608, -332), (0, 88, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (852, -154, -453.662), (0, 190, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (1022, -26, -453.662), (0, 178, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (890, 212, -439.973), (0, 178, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (1058, 540, -432.271), (0, 178, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (306, 924, -430.72), (0, 220, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (218, 1110, -425.252), (0, 220, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (-718, 704, -411.768), (0, 354, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-756, -562, -416.499), (0, 326, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-1392, -946, -379.984), (0, 16, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-1520, -300, -404), (0, 2, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-1496, 362, -384), (0, 272, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-1572, 478, -384), (0, 2, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-1530, 838, -448.738), (0, 2, 0));
      break;
    case "war":
    case "conf":
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (1250, -1430, -356.269), (0, 204, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (1748, -448, -431.531), (0, 134, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (1714, -54, -429.662), (0, 178, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (1908, 90, -431.531), (0, 170, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (1882, 428, -432), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (1810, 664, -436.603), (0, 178, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (1030, -422, -370.78), (0, 218, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (932, 1172, -401.259), (0, 200, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (798, 1384, -435.212), (0, 208, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-1970, -1324, -364.845), (0, 354, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-1770, -1158, -380.228), (0, 0, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-1718, -570, -366.989), (0, 0, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-1720, -94, -390.989), (0, 0, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-2008, -554, -366.989), (0, 2, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-1942, -386, -366.989), (0, 0, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-1968, -124, -390.989), (0, 0, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-1924, 452, -418.832), (0, 4, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-2464, 194, -364.162), (0, 2, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-2568, -176, -352.168), (0, 2, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (1320, -608, -332), (0, 88, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (852, -154, -453.662), (0, 190, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (1022, -26, -453.662), (0, 178, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (890, 212, -439.973), (0, 178, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (1058, 540, -432.271), (0, 178, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (306, 924, -430.72), (0, 220, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (218, 1110, -425.252), (0, 220, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (-14, 680, -425.252), (0, 182, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (-298, 540, -415.791), (0, 272, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (-704, 534, -409.309), (0, 330, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (-756, -562, -416.499), (0, 326, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (-1392, -946, -379.984), (0, 16, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (-1520, -300, -404), (0, 2, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (-1496, 362, -384), (0, 272, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (-1572, 478, -384), (0, 2, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (-1530, 838, -448.738), (0, 2, 0));
      break;
    case "patrol":
    case "koth":
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-2392, -248, -352.663), (0, 0, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-2012, -580, -367.573), (0, 0, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1036, -420, -368), (0, 210, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1482, 106, -456), (0, 180, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1796, 446, -456), (0, 180, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1536, 1228, -408.524), (0, 192, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1468, 812, -449.799), (0, 0, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1814, 472, -412.101), (0, 0, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1888, -436, -384), (0, 0, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1696, -104, -396), (0, 0, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1710, -564, -377), (0, 0, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1246, -1444, -376.159), (0, 30, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1514, 1130, -418.762), (0, 307, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (200, -1548, -363.711), (0, 142, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (334, -978, -389.081), (0, 160, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (850, -166, -448.605), (0, 196, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (998, -2, -464), (0, 180, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (224, 1122, -442.285), (0, 224, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1668, 1526, -445.457), (0, 196, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1836, 428, -432), (0, 176, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1748, -60, -426.751), (0, 174, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1646, -300, -414.97), (0, 136, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1494, -556, -344.945), (0, 122, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1182, -578, -364.455), (0, 175, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1250, -1434, -380.47), (0, 24, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1768, -1164, -380.47), (0, 0, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1724, -560, -377), (0, 0, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1992, -564, -368.203), (0, 0, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-2396, -240, -352.565), (0, 0, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-2446, 206, -373.574), (0, 18, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1740, -98, -399.996), (0, 0, 0), undefined, "5");
      break;
    default:
      break;
  }

  _id_0817::_id_1127(var_0);
}