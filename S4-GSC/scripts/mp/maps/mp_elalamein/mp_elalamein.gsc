/*********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_elalamein\mp_elalamein.gsc
*********************************************************/

main() {
  scripts\mp\maps\mp_elalamein\mp_elalamein_precache::main();
  scripts\mp\maps\mp_elalamein\gen\mp_elalamein_art::main();

  if(!getdvarint("#x3a8fb0620196c6263")) {
    scripts\mp\maps\mp_elalamein\mp_elalamein_fx::main();
  }

  scripts\mp\maps\mp_elalamein\mp_elalamein_lighting::main();
  _id_07EC::main();
  _id_07C0::_id_D88B("compass_map_mp_elalamein");
  setDvar("#x32ee39981452e9751", 8);
  setDvar("#x3e634b52165a47381", 4096);
  setDvar("#x3d2f3327c3c633b22", 4096);
  setDvar("#x33daa745c39326583", 60);
  setDvar("#x3d6f082c7b7955947", 0.001);
  setDvar("#x32a190b02937abbe9", "0.05 1 0");
  setDvar("#x3eeef8b5b6242bc4e", 3);
  setDvar("#x3d83a10633ff87306", 0.1);
  setDvar("#x3c7a99337defff3a3", 500);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  game["allies"] = "USMC";
  game["axis"] = "ALQ";
  level._id_AD0F = getEntArray("OutOfBounds", "targetname");
  setDvar("#x331157d6a11c2a653", 3500.0);
  setDvar("#x3b94d9d617f14e388", 1000);
  setDvar("#x36d8bf82840d880d2", 1);
  scripts\mp\s4_elf_poi::add_elf_poi_position((307.806, -10.726, 172), (359.728, 92.272, -0.266), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1218.29, -492.778, 165.133), (0, 17.98, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((1211.31, -615.615, 505.643), (0, 131.209, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((382.036, 1262.05, 254.5), (0, 29.51, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1481.51, 467.055, 280), (357.145, 113.951, -1.46), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1962.64, 2404.56, 201.365), (0, 34.14, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1297.65, 1025.78, 625.721), (0, 226.116, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-171.854, 1950.92, 322.586), (0, 0, -7.078), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((1439.73, 1372.64, 579), (0, 207.074, 0), "sitting");
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("4", (-1015.98, 1777.61, 232.851), (0, 0, 0));
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("5", (342.981, 1462.62, 1094.73), (0, 0, 0), 1);
  level.airstrikeheightoffset = 800;
  level fixpostlaunchspawns();
  thread disconnectbadpathnodes();
  thread fix_collision();
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
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (-2641.75, 1927, 268.104), (0, 328, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (-1935.75, 2249, 262.462), (0, 328, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (765, 1593.75, 262.462), (0, 182, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (1459, 2141.75, 259.795), (0, 182, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (2501, 1321.75, 93.4207), (0, 182, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (2717.75, 943, 91.1481), (0, 184, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (3239, 925.75, 43.5548), (0, 230, 0));
      break;
    case "dom":
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (1909.87, -174.58, 227.5), (0, 89, 0));
      break;
    case "conf":
    case "war":
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-1862.95, -512.985, 113.851), (0, 1.7, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (-1446.95, -720.98, 101.517), (0, 1.7, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (-407.05, 246.98, 145.096), (0, 179, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (1306.95, -973.02, 215.861), (0, 182, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (1152.95, 132.98, 191.096), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (1478.95, 140.98, 240.945), (0, 196, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (336, 544, 268), (0, 132, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (854.95, 748.98, 191.096), (0, 204, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (580.95, 1164.98, 251.096), (0, 179, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (594.95, 1262.98, 251.096), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (2798.95, 474.98, 106.974), (0, 182, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (1998.95, 1838.98, 100.945), (0, 156, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (1654.95, 1990.98, 196.945), (0, 162, 0));
      break;
    case "patrol":
    case "koth":
      level._id_9FFA["-2396 756"]["mp_koth_spawn_allies_start"]["remove"] = 1;
      level._id_9FFA["-139 -154"]["mp_koth_spawn"]["remove"] = 1;
      level._id_9FFA["-156 -26"]["mp_koth_spawn"]["remove"] = 1;
      level._id_9FFA["281 -232"]["mp_koth_spawn"]["remove"] = 1;
      level._id_9FFA["22 -152"]["mp_koth_spawn"]["remove"] = 1;
      level._id_9FFA["47 -332"]["mp_koth_spawn"]["remove"] = 1;
      level._id_9FFA["-25 -496"]["mp_koth_spawn"]["remove"] = 1;
      level._id_9FFA["711 540"]["mp_koth_spawn"]["remove"] = 1;
      level._id_9FFA["581 425"]["mp_koth_spawn"]["remove"] = 1;
      level._id_9FFA["574 302"]["mp_koth_spawn"]["remove"] = 1;
      break;
    default:
      break;
  }

  _id_0817::_id_1127(var_0);
}

disconnectbadpathnodes() {
  var_0 = _func_00B5((2209.32, -68.3217, 180.169), 64, 0, 64);

  if(isDefined(var_0[0])) {
    var_0[0] _meth_80B4();

    if(isDefined(level._id_20EC)) {
      level._id_20EC[level._id_20EC.size] = var_0[0];
    } else {
      level._id_20EC = [];
      level._id_20EC[level._id_20EC.size] = var_0[0];
    }
  }
}

fix_collision() {
  if(scripts\mp\utility\game::getgametype() == "sd") {
    var_0 = getent("clip32x32x32", "targetname");
    var_1 = spawn("script_model", (494, 1894.5, 255));
    var_1.angles = (0, 0, 0);
    var_1 clonebrushmodeltoscriptmodel(var_0);
    var_2 = getent("clip32x32x32", "targetname");
    var_3 = spawn("script_model", (494, 1894.5, 240));
    var_3.angles = (0, 0, 0);
    var_3 clonebrushmodeltoscriptmodel(var_2);
  }

  var_4 = getent("clip256x256x256", "targetname");
  var_5 = spawn("script_model", (1664.81, 1289.7, 542.26));
  var_5.angles = (0, 0, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getent("clip256x256x256", "targetname");
  var_7 = spawn("script_model", (1533.92, 1367.58, 542.26));
  var_7.angles = (0, 0, 0);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getent("player32x32x256", "targetname");
  var_9 = spawn("script_model", (1296.54, 1559.98, 482.603));
  var_9.angles = (0, 0, 0);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getent("clip256x256x256", "targetname");
  var_11 = spawn("script_model", (-2127.31, 2403.24, 112.362));
  var_11.angles = (0, 341.787, 0);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getent("clip256x256x256", "targetname");
  var_13 = spawn("script_model", (-2058.92, 2622.48, 112.362));
  var_13.angles = (0, 341.787, 0);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getent("clip512x512x8", "targetname");
  var_15 = spawn("script_model", (1990, 2061, 498.75));
  var_15.angles = (0, 0, -90);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_16 = getent("clip512x512x8", "targetname");
  var_17 = spawn("script_model", (2142.75, 2249.25, 498.75));
  var_17.angles = (0, 90, -90);
  var_17 clonebrushmodeltoscriptmodel(var_16);
  var_18 = getent("clip256x256x256", "targetname");
  var_19 = spawn("script_model", (2485, -731.5, 79.5));
  var_19.angles = (0, 270, 0);
  var_19 clonebrushmodeltoscriptmodel(var_18);
  var_20 = getent("clip256x256x256", "targetname");
  var_21 = spawn("script_model", (2485, -731.5, 335.25));
  var_21.angles = (0, 270, 0);
  var_21 clonebrushmodeltoscriptmodel(var_20);
}