/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_nest2\mp_nest2.gsc
*************************************************/

main() {
  scripts\mp\maps\mp_nest2\mp_nest2_precache::main();
  scripts\mp\maps\mp_nest2\gen\mp_nest2_art::main();
  scripts\mp\maps\mp_nest2\mp_nest2_fx::main();
  scripts\mp\maps\mp_nest2\mp_nest2_lighting::main();
  _id_07EC::main();
  _id_07C0::_id_D88B("compass_map_mp_nest2");
  setDvar("#x32ee39981452e9751", 8);
  setDvar("#x396f2c38d84d614f", 2);
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
  level addpostlaunchspawns();
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1616.25, 56.945, 370.5), (0, 118, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1584, 954, 288), (0, 0, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1199, 167.5, 346.75), (0, 0, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-973.75, 187, 402.25), (0, 180, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-940.066, 483.278, 410), (0, 32, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-846.474, 669.524, 207), (0, 122.085, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-127.847, 1196.35, 228.845), (0, 266.896, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-17, 828, 282), (0, 356.896, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((150.5, 1112, 215.5), (0, 266.896, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-484, 366.5, 352.5), (0, 270, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((114.256, 441.548, 320), (0, 235, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-546.5, -16, 361.25), (0, 0, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((694, 200, 343), (0, 180, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((982.169, 12.0248, 256), (0, 42.8961, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((975.323, 498.892, 199.5), (0, 38.8961, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((760.173, -430.757, 296), (0, 180, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((465.414, 794.317, 351.5), (0, 42.709, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((586, 999, 207), (0, 180, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((613, 628, 256), (0, 225, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((209, 148, 256), (0, 360, 0), "laying");
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("1", (-511.239, 470.972, 2000), (0, 0, 0), 1);
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("2", (585.305, 942.264, 192.138), (0, 0, 0));
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("3", (-992.139, 185.091, 402.625), (0, 89.7482, 0), 1);
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("4", (546.012, 185.483, 2000), (0, 0, 0), 1);
}

addpostlaunchspawns() {
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
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (814, 1144, 180), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (804, 546, 272), (0, 194, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (796, -166, 272), (0, 162, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (356, -558, 191), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (-42, -484, 194), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (-896, -638, 225), (0, 190, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (-1632, -116.742, 336), (0, 270, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (-1105, -165, 336), (0, 360, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (-1275, 41, 336), (0, 40, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (-456, -18, 336), (0, 90, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (-1337, 377, 336), (0, 322, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (-1153, 533, 336), (0, 360, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (-1638, 814, 272), (0, 270, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (52, 594, 336), (0, 270, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (250, 1202, 199), (0, 360, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (100, 1202, 196), (0, 180, 0));
      break;
    case "dom":
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-2744.05, 38.18, 218.639), (0, 0, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-2744.05, -251.82, 236.839), (0, 0, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-2560.05, 332.178, 240.706), (0, 360, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-2485.99, 224.164, 203.236), (0, 40, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-2500.09, -457.764, 258.887), (0, 314, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-2346.09, -529.764, 266.61), (0, 360, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-2346.09, -637.764, 258.656), (0, 360, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-2120.09, 548.236, 258.967), (0, 360, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-2120.09, 478.236, 256.509), (0, 360, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-2032.07, -339.697, 232.989), (0, 316, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-2044.08, -415.71, 249.564), (0, 326, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-1723.82, 816.051, 272), (0, 270, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-1643.82, 816, 272), (0, 270, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-1839.79, -73.926, 146), (0, 90, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-1839.79, -169.926, 146.5), (0, 232, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-1643.82, -123.956, 336), (0, 120, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-1643.82, -191.949, 336), (0, 270, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (-1531.94, 329.27, 336), (0, 0, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (-1554.73, 9.94225, 336), (0, 360, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (-1327.94, 7.26999, 336), (0, 0, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (-1327.94, 337.27, 336), (0, 0, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (-1159.86, 538.116, 336), (0, 360, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (756.046, 590.703, 272), (0, 210, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (842.092, 315.742, 272), (0, 130, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (842, 39.8424, 272), (0, 226, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (606.092, -206.242, 272), (0, 140, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (2130.33, 351.984, 80.989), (0, 160, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (2080.32, 271.957, 82.989), (0, 140, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (2080.32, 126.045, 80.989), (0, 204, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (2082.33, 54.0312, 80.989), (0, 194, 0));
      break;
    case "war":
    case "conf":
      break;
    case "patrol":
    case "koth":
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1922.25, 824.5, 72.5918), (0, 180, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1865.93, 793.767, 78.9743), (0, 210, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1936.75, 578.5, 72.5918), (0, 180, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (2100.25, 467, 72.5918), (0, 180, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (2097.98, 295.825, 71.9284), (0, 146, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (2139.75, 168.25, 72.5918), (0, 180, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (2091.95, 35.8068, 71.9284), (0, 174, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (2072.25, -49.25, 72.5918), (0, 180, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1721.11, 285.239, 183.184), (0, 180, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1804.25, -286.5, 102.941), (0, 138.357, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1230, 70, 272), (0, 154, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1230, -102, 272), (0, 132, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1118.39, -479.442, 147.184), (0, 160, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1040.38, -489.456, 147.184), (0, 166, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (664, -506, 158), (0, 116, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (598, -506, 158), (0, 116, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (670, -510, 157.286), (0, 136, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (608, -514, 157.286), (0, 120, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (686, 766, 208), (0, 140, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (712, 1102, 188.18), (0, 180, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (776, 1160, 182.408), (0, 180, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (772, 1161.74, 182.872), (0, 180, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (708, 1077.74, 188.161), (0, 180, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (383.693, 1196.77, 196.446), (0, 180, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (104, 1195.74, 196), (0, 180, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-266, -520, 170.94), (0, 160, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-766, -574, 203.928), (0, 340, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1046.19, 663.072, 208), (0, 34.4536, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1148.36, 536.697, 336), (0, 360, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1322, 338, 336), (0, 360, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1322, 6, 336), (0, 360, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1631, -113.5, 336), (0, 270, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1633, -115.5, 336), (0, 270, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1634.49, -121.5, 336), (0, 270, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1839, -72.5, 148.382), (0, 90, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1839, -166.5, 148.382), (0, 237.73, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-2077, 722.5, 249.618), (0, 322, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-2079, 548.5, 249.618), (0, 360, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-2085, 488.5, 249.618), (0, 360, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1992, -729.748, 288.278), (0, 76, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-2082, -753.744, 281.491), (0, 54, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-2448, -611.74, 262.645), (0, 360, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-2570, -441.74, 262.094), (0, 336, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-2640, -487.74, 262.094), (0, 340, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-2707, -290.25, 240.195), (0, 313.73, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-2682.5, 76.75, 211.021), (0, 16.4537, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-2575.5, 288.75, 233.676), (0, 16.4537, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-2461, 472.5, 280.66), (0, 340, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-2433, 546.5, 292.438), (0, 12, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (681.283, -504.232, 155.93), (0, 124, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (607.284, -506.234, 155.93), (0, 120, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (673.647, 761.931, 208), (0, 120, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (247.745, 1196.01, 198.538), (0, 360, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (105.745, 1196.01, 196), (0, 180, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (-766.708, -569.54, 203.798), (0, 342, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (-1310, 660, 209.433), (0, 25, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (-1532.79, 344.922, 336), (0, 342, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (-1536.11, 342.557, 336), (0, 340, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (-1550.11, 14.557, 336), (0, 360, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (-1545.79, 12.097, 336), (0, 360, 0), undefined, "1");
      break;
    default:
      break;
  }

  _id_0817::_id_1127(var_0);
}