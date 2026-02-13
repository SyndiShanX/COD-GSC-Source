/*****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_castle2\mp_castle2.gsc
*****************************************************/

main() {
  scripts\mp\maps\mp_castle2\mp_castle2_precache::main();
  scripts\mp\maps\mp_castle2\gen\mp_castle2_art::main();
  scripts\mp\maps\mp_castle2\mp_castle2_fx::main();
  scripts\mp\maps\mp_castle2\mp_castle2_lighting::main();
  _id_07EC::main();
  _id_07C0::_id_D88B("compass_map_mp_castle2");
  setDvar("#x32ee39981452e9751", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  game["allies"] = "USMC";
  game["axis"] = "ALQ";
  setDvar("#x331157d6a11c2a653", 3850.0);
  setDvar("#x3b94d9d617f14e388", 1000.0);
  setDvar("#x36d8bf82840d880d2", 1);
  level.airstrikeheightoffset = 2500;
  scripts\mp\s4_elf_poi::add_elf_poi_position((3006, -2512, -199.243), (0, 313.368, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((4355.37, -2056.88, -203.622), (0, 313.368, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((4396.15, -379.133, -374.944), (0, 115.266, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((920.636, -2279.8, -202.869), (0, 186.092, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((1013.13, -1293.36, -392.898), (0, 73.89, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((2767.36, -940.704, -569.292), (0, 296.59, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((1282.94, -2337.03, -176.866), (0, 305.59, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((3297.5, -839.429, -442.304), (0, 56.59, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((1715.88, -746.621, -443.394), (0, 211.889, 0), "laying");
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("1", (3418.02, -2491.8, -2.64797), (0, 0, 0), 1);
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("2", (1615.16, -1419.28, -264.331), (0, 0, 0), 0, (0, 178.581, 0));
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("3", (4696.5, -511.688, -248.267), (0, 0, 0), 0, (0, 31.1489, 0));
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("4", (867.269, -2456.74, -198.687), (0, 0, 0), 0, (0, 177.986, 0));
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("5", (2763.22, -145.054, -495.852), (0, 0, 0), 0, (0, 178.948, 0));
  thread fix_collision();
  level addpostlaunchspawns();
  thread addpostlaunchmesh();
}

fix_collision() {
  var_0 = getent("clip32x32x256", "targetname");
  var_1 = spawn("script_model", (1438, -463.5, -540.5));
  var_1.angles = (0, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getent("clip32x32x256", "targetname");
  var_3 = spawn("script_model", (1274.5, -672.5, -576));
  var_3.angles = (0, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getent("clip32x32x256", "targetname");
  var_5 = spawn("script_model", (1224.5, -603, -540.5));
  var_5.angles = (0, 0, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getent("clip64x64x64", "targetname");
  var_7 = spawn("script_model", (1668, -197.5, -391));
  var_7.angles = (0, 6.74088, 0);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getent("clip256x256x8", "targetname");
  var_9 = spawn("script_model", (4965.25, -1589.5, 119.75));
  var_9.angles = (0, 0, -90);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getent("clip64x64x8", "targetname");
  var_11 = spawn("script_model", (4020, -535, -489));
  var_11.angles = (60.1849, 177.372, 179.647);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getent("clip64x64x8", "targetname");
  var_13 = spawn("script_model", (4022, -489, -489));
  var_13.angles = (60.1849, 170.972, 179.647);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getent("clip64x64x8", "targetname");
  var_15 = spawn("script_model", (4076, -506, -492));
  var_15.angles = (55.7869, 357.587, -179.981);
  var_15 clonebrushmodeltoscriptmodel(var_14);
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
      break;
    case "dom":
      break;
    case "war":
    case "conf":
      level._id_9FFA["2376 48"]["mp_tdm_spawn_axis_start"]["remove"] = 1;
      level._id_9FFA["2280 48"]["mp_tdm_spawn_allies_start"]["remove"] = 1;
      break;
    case "patrol":
    case "koth":
      level._id_9FFA["472 -2968 -168"]["mp_koth_spawn"]["remove"] = 1;
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (534, -2974, -156.961), (0, 330, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (4806, -2174, -228), (0, 102, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (4734, -2174, -228), (0, 150, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (4814, -1786, -228), (0, 102, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (4815.54, -130.658, -232.137), (0, 180, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (4513.54, -194.658, -360), (0, 180, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (4136.41, -100.784, -409.851), (0, 312.9, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (4115.41, -478.784, -490.825), (0, 270, 0), undefined, "1");
      break;
    default:
      break;
  }

  _id_0817::_id_1127(var_0);
}

addpostlaunchmesh() {
  var_0 = spawn("script_model", (4052.8, -501.585, -510.617));
  var_0 setModel("hur_rocks_single_med_06_moss");
  var_0.angles = (332.46, 239.417, -38.9777);
  var_1 = spawn("script_model", (4047.8, -515.585, -494.617));
  var_1 setModel("hur_rocks_single_med_06_moss");
  var_1.angles = (283.898, 0, 0);
  var_2 = spawn("script_model", (4025.8, -537.585, -517.617));
  var_2 setModel("hur_rocks_single_med_06_moss");
  var_2.angles = (0, 11.0986, 0);
  var_3 = spawn("script_model", (4029, -509, -408));
  var_3 setModel("mkg_hanging_vines_04");
  var_3.angles = (0.0425011, 265.1, 0.498283);
  var_4 = spawn("script_model", (4029, -462, -412));
  var_4 setModel("mkg_hanging_vines_09");
  var_4.angles = (0.0424994, 85.0999, 0.498262);
  var_5 = spawn("script_model", (4062, -471, -411));
  var_5 setModel("mkg_hanging_vines_09");
  var_5.angles = (0.1187, 88.1029, 2.79668);
  var_6 = spawn("script_model", (4060, -503, -461));
  var_6 setModel("s4_barrier_wood_window_slats_single_wide_01");
  var_6.angles = (0, 270, 0);
  var_7 = spawn("script_model", (4060, -505, -452));
  var_7 setModel("day_trenches_wood_slats_single_06");
  var_7.angles = (0, 0, 0);
  var_8 = spawn("script_model", (4060, -503, -443));
  var_8 setModel("s4_barrier_wood_window_slats_single_wide_01");
  var_8.angles = (0, 270, 0);
  var_9 = spawn("script_model", (4060, -500, -434));
  var_9 setModel("day_trenches_wood_slats_single_06");
  var_9.angles = (0, 0, 0);
}