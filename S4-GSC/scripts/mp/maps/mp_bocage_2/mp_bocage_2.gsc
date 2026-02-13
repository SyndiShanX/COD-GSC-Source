/*******************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_bocage_2\mp_bocage_2.gsc
*******************************************************/

main() {
  scripts\mp\maps\mp_bocage_2\mp_bocage_2_precache::main();
  scripts\mp\maps\mp_bocage_2\gen\mp_bocage_2_art::main();
  scripts\mp\maps\mp_bocage_2\mp_bocage_2_fx::main();
  scripts\mp\maps\mp_bocage_2\mp_bocage_2_lighting::main();
  _id_07EC::main();
  _id_07C0::_id_D88B("compass_map_mp_bocage_2");
  setDvar("#x32ee39981452e9751", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  game["allies"] = "USMC";
  game["axis"] = "ALQ";
  level._id_AD0F = getEntArray("OutOfBounds", "targetname");
  setDvar("#x331157d6a11c2a653", 3000.0);
  setDvar("#x3b94d9d617f14e388", 1000);
  setDvar("#x36d8bf82840d880d2", 1);
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1207, -1053, -3), (0, 88, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((946, -820, -58), (0, 196, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((45, 1574, 112), (22, 267, -1), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1307, 1078, -10), (0, 0, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((720, 566, 0), (0, 133, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-600, 650, 137), (0, 299, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-171, -750, 34), (0, 36, 0), "laying");
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("3", (1129.15, -101.471, 53), (0, 0, 0), 1);
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("4", (-328.972, 447.82, 273.037), (0, 0, 0), 1);
  level addpostlaunchspawns();
  thread addpostlaunchmesh();
}

addpostlaunchspawns() {
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "ctf":
      break;
    case "patrol":
    case "koth":
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1602, 884, 27), (0, 226, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (2006, 366, 10.5389), (0, 180, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1062, -1005, -44.2521), (0, 26, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1341, -705, -44.2521), (0, 50, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1753.06, 872.96, 8), (0, 2, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1523.06, 1193.96, 12.9978), (0, 2, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1896, -87, -56), (0, 36, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1025, -1081, -77.2585), (0, 81, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (978.01, 61.88, -128.483), (0, 93, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1070.12, -95.99, 17), (0, 178, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (2023.37, 374.18, 12.5741), (0, 180, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (2408.37, -360.82, -20.0316), (0, 180, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1980.68, 371.921, 15.0005), (0, 193, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1007.04, -595.4, -19.6736), (0, 11, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1535.69, 1187.68, 14.9994), (0, 1.5, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1616, 870, 29.7069), (0, 219, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1298, -661, 20), (0, 132, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (860.39, -889.94, -102.702), (0, 169, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1384, -679, -45.9078), (0, 63, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-2322, 274, -52), (0, 0, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1889.55, -36.4399, -45.1206), (0, 341, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1807.6, 940.454, 14.9739), (0, 351, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-682.8, 819.034, 11.377), (0, 283, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1587, 927.5, 26.3698), (0, 244, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1958, 393.5, 0.0636539), (0, 206, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (2123, -797.5, 7.47545), (0, 175, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1972.5, -1393.5, -6.94321), (0, 176, 0), undefined, "5");
      break;
    case "control":
      break;
    case "sd":
      break;
    case "dm":
    case "gun":
      level._id_9FFA["951 1422"]["mp_dm_spawn"]["remove"] = 1;
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (1026, -692, 16), (0, 0, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (-88, -766, 28), (0, 90, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (-154, -486, 28), (0, 348, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (-1610, -483, -24), (0, 22.4, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (358, -7, 24), (0, 144, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (345, 245, 10.8), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (-869, 287, 18), (0, 246, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (-1500, 770, 9.2), (0, 321, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (-759, 695, 16.75), (0, 59, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (803, 921, 9), (0, 170, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (555, 1547, -104.7), (0, 248, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (167, 1573, -105), (0, 278.4, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (-95, 1567, -105), (0, 304, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (831, 1326, -115), (0, 180, 0));
      break;
    case "dom":
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (1612.45, 891.431, 12.3467), (0, 239, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-1535.69, -540.089, -24.4398), (0, 72, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-1817.69, -82.0894, -40.14), (0, 21, 0));
      break;
    case "war":
    case "conf":
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (1612.45, 891.431, 12.3467), (0, 239, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-1535.69, -540.089, -24.4398), (0, 72, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-1817.69, -82.0894, -40.14), (0, 21, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (1078, -81, 21), (0, 180, 0));
      break;
    default:
      break;
  }

  _id_0817::_id_1127(var_0);
}

addpostlaunchmesh() {
  var_0 = spawn("script_model", (-1008.02, 1487.42, -22));
  var_0 setModel("me_construction_plank_bridge_a_20");
  var_0.angles = (271.823, 69.1018, -138.58);
  var_1 = spawn("script_model", (-1012.58, 1624.02, -28));
  var_1 setModel("me_construction_plank_bridge_a_20");
  var_1.angles = (271.536, 29.6038, 148.895);
  var_2 = spawn("script_model", (-997.98, 1760.58, -22));
  var_2 setModel("me_construction_plank_bridge_a_20");
  var_2.angles = (271.009, 41.208, 47.2775);
  var_3 = spawn("script_model", (-1068.02, 1925.42, -24));
  var_3 setModel("me_construction_plank_bridge_a_20");
  var_3.angles = (271.009, 243.208, 47.2766);
  var_4 = spawn("script_model", (-1010.58, 1526.58, -34.082));
  var_4 setModel("me_construction_plank_bridge_a_10");
  var_4.angles = (89.9, 293.891, 115.89);
  var_5 = spawn("script_model", (-1007.45, 1588.63, -36.082));
  var_5 setModel("me_construction_plank_bridge_a_10");
  var_5.angles = (89.9, 293.891, 115.891);
  var_6 = spawn("script_model", (-1003.45, 1658.63, -32.082));
  var_6 setModel("me_construction_plank_bridge_a_10");
  var_6.angles = (89.9, 293.891, 115.891);
  var_7 = spawn("script_model", (-999.45, 1720.63, -32.082));
  var_7 setModel("me_construction_plank_bridge_a_10");
  var_7.angles = (89.9, 293.891, 115.891);
  var_8 = spawn("script_model", (-1006.98, 1788.88, -32.082));
  var_8 setModel("me_construction_plank_bridge_a_10");
  var_8.angles = (88.0895, 108.691, -91.3099);
  var_9 = spawn("script_model", (-1030.05, 1844.95, -25.7746));
  var_9 setModel("me_construction_plank_bridge_a_10");
  var_9.angles = (87.6986, 145.671, -62.2927);
  var_10 = spawn("script_model", (-1058.05, 1896.95, -31.7746));
  var_10 setModel("me_construction_plank_bridge_a_10");
  var_10.angles = (87.6986, 145.671, -62.2927);
}