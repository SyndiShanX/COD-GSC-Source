/*************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_destruct_01\mp_destruct_01.gsc
*************************************************************/

main() {
  scripts\mp\maps\mp_destruct_01\mp_destruct_01_precache::main();
  scripts\mp\maps\mp_destruct_01\gen\mp_destruct_01_art::main();
  scripts\mp\maps\mp_destruct_01\mp_destruct_01_fx::main();
  scripts\mp\maps\mp_destruct_01\mp_destruct_01_lighting::main();
  _id_07EC::main();
  _id_07C0::_id_D88B("compass_map_mp_destruct_01");
  setDvar("#x32ee39981452e9751", 8);
  setDvar("#x331157d6a11c2a653", 3000.0);
  setDvar("#x3b94d9d617f14e388", 400);
  setDvar("#x36d8bf82840d880d2", 1);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  game["allies"] = "USMC";
  game["axis"] = "ALQ";
  level._id_AD0F = getEntArray("OutOfBounds", "targetname");
  thread reducescriptables();
  thread fixcollision();
  thread rotateturbine();
  level fixpostlaunchspawns();
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("1", (1235.79, 247.065, 385.272), (0, 0, 0), 1);
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("2", (-422.939, -786.762, 150.151), (0, 0, 0), 0, (0, 67.2775, 0));
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("3", (1119.49, 1254.23, 148.149), (0, 0, 0), 0, (0, -81.1917, 0));
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("4", (553.991, -1105.41, 107.41), (0, 0, 0), 0, (0, -9.17064, 0));
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("5", (161.985, 485.163, 115.65), (0, 0, 0), 0, (0, 66.7553, 0));
}

rotateturbine() {
  level endon("game_ended");
  var_0 = getent("turbine", "targetname");
  var_1 = (0, 360, 0);
  var_2 = 60;

  for(;;) {
    var_0 rotatevelocity(var_1, var_2);
    var_0 waittill("rotatedone");
  }
}

fixcollision() {
  var_0 = getent("clip128x128x256", "targetname");
  var_1 = spawn("script_model", (-380, 1634, 84));
  var_1.angles = (0, 3.61461, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getent("clip256x256x8", "targetname");
  var_3 = spawn("script_model", (-397, 1446, 212));
  var_3.angles = (270, 0, 15.8515);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getent("clip128x128x256", "targetname");
  var_5 = spawn("script_model", (-380, 1634, 340));
  var_5.angles = (0, 3.61461, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getent("clip256x256x8", "targetname");
  var_7 = spawn("script_model", (-397, 1446, 468));
  var_7.angles = (270, 0, 15.8515);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getent("clip256x256x8", "targetname");
  var_9 = spawn("script_model", (809, 563, 399));
  var_9.angles = (270, 89.5, -164.649);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getent("clip256x256x8", "targetname");
  var_11 = spawn("script_model", (703, 535, 399));
  var_11.angles = (270, 89.5, -164.649);
  var_11 clonebrushmodeltoscriptmodel(var_10);
}

fixportaling() {
  var_0 = spawn("script_model", (398.48, -805.783, 105.5));
  var_0 setModel("s4_metal_pipe_straight_x32_01");
  var_0.angles = (270, 0, -11);
  var_1 = spawn("script_model", (398.48, -805.783, 168.5));
  var_1 setModel("s4_metal_pipe_straight_x32_01");
  var_1.angles = (270, 0, -11);
  var_2 = spawn("script_model", (400.48, -802.283, 100.5));
  var_2 setModel("s4_metal_pipe_straight_x32_01");
  var_2.angles = (270, 0, -176);
  var_3 = spawn("script_model", (400.48, -802.283, 163.5));
  var_3 setModel("s4_metal_pipe_straight_x32_01");
  var_3.angles = (270, 0, -176);
  var_4 = spawn("script_model", (396.276, -808.531, 234.5));
  var_4 setModel("s4_metal_pipe_90_corner_01");
  var_4.angles = (90, 0, -53.9995);
}

reducescriptables() {
  level.disableambientcorpsespawn = 1;
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
      break;
    case "dom":
      break;
    case "war":
    case "conf":
      break;
    case "patrol":
    case "koth":
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (916, 1940, 136.393), (0, 250, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (576, 1930, 136.393), (0, 250, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-112, 2152, 117.503), (0, 274, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-10, 1598, 120.975), (0, 274, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1688, 1126, 91.4147), (0, 226, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1940, 564, 77.4483), (0, 192, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1650, 132, 76.3441), (0, 192, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1066, -774, 80), (0, 74, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-182, -1046, 144.449), (0, 60, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-516, -866, 138.833), (0, 40, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-442, -440, 182), (0, 64, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1442, 252, 76.5924), (0, 258, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1916, 574, 77.4639), (0, 236, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (950, 788, 142.701), (0, 276, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1484, 932, 86.0891), (0, 266, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1578, 1228, 110.411), (0, 266, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1148, 1362, 167.347), (0, 296, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (812, 1254, 167.347), (0, 308, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (916, 1940, 136.393), (0, 250, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (576, 1930, 136.393), (0, 250, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-10, 1598, 120.975), (0, 274, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-112, 2152, 117.503), (0, 274, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-196, 1284, 115.625), (0, 284, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-420, 1220, 116.457), (0, 284, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-434, 812, 135.422), (0, 292, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1466, -634, 74.4124), (0, 154, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1254, -916, 73.3168), (0, 118, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (400, -1480, 141), (0, 62, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (336, -1830, 94.5807), (0, 106, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-186, -1070, 143.989), (0, 64, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-512, -852, 143.989), (0, 44, 0), undefined, "5");
      break;
    default:
      break;
  }

  _id_0817::_id_1127(var_0);
}