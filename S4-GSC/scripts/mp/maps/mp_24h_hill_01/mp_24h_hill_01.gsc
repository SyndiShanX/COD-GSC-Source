/*************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_24h_hill_01\mp_24h_hill_01.gsc
*************************************************************/

main() {
  scripts\mp\maps\mp_24h_hill_01\mp_24h_hill_01_precache::main();
  scripts\mp\maps\mp_24h_hill_01\gen\mp_24h_hill_01_art::main();
  scripts\mp\maps\mp_24h_hill_01\mp_24h_hill_01_fx::main();
  scripts\mp\maps\mp_24h_hill_01\mp_24h_hill_01_lighting::main();
  _id_07EC::main();
  _id_07C0::_id_D88B("compass_map_mp_24h_hill_01");
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
  thread addnavmodfordoors();
  thread addpostshipcollision();
  thread addpostshipmodels();
  thread fixpostshipbadpathnodes();
  level fixpostlaunchspawns();
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1107, 423.387, 124.131), (0, 214.199, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1634.91, 46.7328, 165.509), (0, 310.697, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-871.724, -127.308, 263.178), (0, 101.599, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1423.61, -1322.81, 148.653), (0, 46.3391, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-9.14795, -1332.73, 182.828), (0, 90, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((1470.01, -1282.88, 180.304), (0, 72.3976, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((1716.7, -483.744, 173.62), (0, 176.395, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((1153.9, -231.518, 217.049), (0, 239.099, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((1609.66, -30.2048, 118.526), (0, 157.195, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((484.422, -159.574, 348.024), (0, 118.1, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-35.6224, -49.105, 312.451), (0, 161.4, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-387.685, -3.34898, 250.547), (0, 265.398, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-532.596, -322.206, 358), (0, 43.5995, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-862.615, -1029.61, 140.144), (0, 226.339, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((636.815, -672.167, 362.846), (0, 329.398, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((617.609, 522.13, 275.461), (0, 141.599, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-471.05, 1594.47, 384.747), (0, 350, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((477.851, 1961.6, 89.976), (0, 270, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((13.9045, 990.608, 353.672), (0, 315.498, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((28.7803, -458.734, 296.279), (0, 97.5997, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((1214.06, -59.3287, 98), (0, 159.595, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((1127.81, 364.578, 196.037), (1.27848, 83.095, 3.86669), "sitting");
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("2", (47.3261, -1175.16, 92.3695), (0, 0, 0), 0, (0, 146.054, 0));
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("3", (1463.06, -348.977, 89.1329), (0, 0, 0), 0, (0, 15, 0));
}

fixpostshipbadpathnodes() {
  var_0 = [];
  var_0 = scripts\engine\utility::_id_1B9D(var_0, _func_00B5((1380.08, 927.382, 156.926), 32, 0, 32));
  var_0 = scripts\engine\utility::_id_1B9D(var_0, _func_00B5((1397.29, 689.137, 148.937), 32, 0, 32));

  foreach(var_2 in var_0) {
    var_2 _meth_80B4();

    if(isDefined(level._id_20EC)) {
      level._id_20EC[level._id_20EC.size] = var_2;
      continue;
    }

    level._id_20EC = [];
    level._id_20EC[level._id_20EC.size] = var_2;
  }
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
      level._id_9FFA["-1421 -1088"]["mp_dom_spawn"]["remove"] = 1;
      level._id_9FFA["-1457 -1142"]["mp_dom_spawn"]["remove"] = 1;
      level._id_9FFA["-1510 -1113"]["mp_dom_spawn"]["remove"] = 1;
      level._id_9FFA["-1269 -1414"]["mp_dom_spawn"]["remove"] = 1;
      level._id_9FFA["-1062 -1450"]["mp_dom_spawn"]["remove"] = 1;
      level._id_9FFA["-1620 -39"]["mp_dom_spawn"]["remove"] = 1;
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-1783.92, -12.0701, 90), (0, 356, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-722.07, -422.08, 192), (0, 28, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-1044.07, -1068.08, 84), (0, 48, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-1146, -700, 68), (0, 116, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-652, -1184, 66), (0, 354, 0));
      break;
    case "conf":
    case "war":
      level._id_9FFA["-1421 -1088"]["mp_tdm_spawn"]["remove"] = 1;
      level._id_9FFA["-1452 -1143"]["mp_tdm_spawn"]["remove"] = 1;
      level._id_9FFA["-1510 -1113"]["mp_tdm_spawn"]["remove"] = 1;
      level._id_9FFA["-1269 -1414"]["mp_tdm_spawn"]["remove"] = 1;
      level._id_9FFA["-1062 -1450"]["mp_tdm_spawn"]["remove"] = 1;
      level._id_9FFA["-1618 -41"]["mp_tdm_spawn"]["remove"] = 1;
      level._id_9FFA["-844 -856"]["mp_tdm_spawn_secondary"]["remove"] = 1;
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-1044.07, -1068.08, 84), (0, 48, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-722.07, -422.08, 192), (0, 28, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-398.07, 839.92, 216), (0, 302, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-820.07, 487.92, 198), (0, 266, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-1783.92, -12.0701, 90), (0, 356, 0));
      break;
    case "patrol":
    case "koth":
      break;
    default:
      break;
  }

  _id_0817::_id_1127(var_0);
}

addnavmodfordoors() {
  wait 1;
  var_0 = (-1168, -840, 72);
  var_1 = (0, 45, 0);
  var_2 = (-680, -1308, 64);
  var_3 = (0, 45, 0);
  var_4 = (30, 4, 20);
  var_5 = _func_046D(var_0, var_4, var_1);
  var_6 = _func_046D(var_2, var_4, var_3);
}

addpostshipmodels() {
  var_0 = spawn("script_model", (1657.95, -163.221, 125.073));
  var_0 setModel("s4_jpn_trenches_plank_log_01a");
  var_0.angles = (327.183, 328.093, 58.292);
  var_1 = spawn("script_model", (1684.57, -194.395, 142.475));
  var_1 setModel("s4_jpn_trenches_plank_log_01a");
  var_1.angles = (22.8302, 307.768, 72.4907);
  var_2 = spawn("script_model", (1683.59, -247.082, 109.837));
  var_2 setModel("s4_jpn_trenches_plank_log_03a");
  var_2.angles = (40.2197, 263.312, 52.8875);
  var_3 = spawn("script_model", (1696.42, -271.324, 121.356));
  var_3 setModel("s4_jpn_trenches_plank_log_03a");
  var_3.angles = (33.5253, 285.62, 60.6797);
  var_4 = spawn("script_model", (1688.44, -286.474, 111.727));
  var_4 setModel("s4_jpn_trenches_plank_log_03a");
  var_4.angles = (7.09541, 299.793, 64.0842);
  var_5 = spawn("script_model", (1707.16, -294.438, 128.694));
  var_5 setModel("s4_jpn_trenches_plank_log_03a");
  var_5.angles = (7.09541, 299.793, 64.0842);
  var_6 = spawn("script_model", (1702.84, -311.382, 118.54));
  var_6 setModel("s4_jpn_trenches_plank_log_03a");
  var_6.angles = (3.69568, 301.911, 60.2832);
  var_7 = spawn("script_model", (1713.5, -317.564, 123.39));
  var_7 setModel("s4_jpn_trenches_plank_log_04a");
  var_7.angles = (1.95797, 302.903, 60.3325);
  var_8 = spawn("script_model", (1716.24, -347.271, 97.5131));
  var_8 setModel("s4_jpn_trenches_plank_log_04a");
  var_8.angles = (1.95797, 302.903, 60.3325);
  var_9 = spawn("script_model", (1720.01, -278.301, 144.535));
  var_9 setModel("s4_jpn_trenches_plank_log_01a");
  var_9.angles = (8.89798, 298.905, 63.0538);
  var_10 = spawn("script_model", (1725.47, -287.495, 149.704));
  var_10 setModel("s4_jpn_trenches_plank_log_01a");
  var_10.angles = (8.89943, 298.905, 59.9534);
  var_11 = spawn("script_model", (1722.7, -297.09, 146.965));
  var_11 setModel("s4_jpn_trenches_plank_log_01a");
  var_11.angles = (7.16684, 299.914, 60.0943);
  var_12 = spawn("script_model", (1730.98, -303.8, 152.612));
  var_12 setModel("s4_jpn_trenches_plank_log_01a");
  var_12.angles = (3.69607, 301.911, 62.2836);
  var_13 = spawn("script_model", (1725.34, -313.57, 143.439));
  var_13 setModel("s4_jpn_trenches_plank_log_01a");
  var_13.angles = (29.8912, 22.4957, 84.5189);
  var_14 = spawn("script_model", (1726.33, -327.352, 131.713));
  var_14 setModel("s4_jpn_trenches_plank_log_01a");
  var_14.angles = (0.36052, 304.134, 62.3547);
  var_15 = spawn("script_model", (1737.75, -326.055, 135.532));
  var_15 setModel("s4_jpn_trenches_plank_log_01a");
  var_15.angles = (356.887, 306.113, 58.3045);
  var_16 = spawn("script_model", (1699.44, -238.154, 123.933));
  var_16 setModel("s4_rus_sandbag_lrg_single_01");
  var_16.angles = (9.69218, 107.16, -59.6514);
  var_17 = spawn("script_model", (1715.84, -235.167, 128.813));
  var_17 setModel("s4_rus_sandbag_lrg_single_03");
  var_17.angles = (359.792, 105.146, -78.6196);
  var_18 = spawn("script_model", (1706.26, -342.031, 98.6746));
  var_18 setModel("s4_rus_sandbag_lrg_single_01");
  var_18.angles = (306.4, 33.4004, 0);
  var_19 = spawn("script_model", (1692.85, -240.14, 98.0982));
  var_19 setModel("s4_rus_sandbag_lrg_single_04");
  var_19.angles = (2.01339, 280.292, 5.2272);
  var_20 = spawn("script_model", (1682.91, -310.236, 92.198));
  var_20 setModel("s4_rus_sandbag_lrg_single_04");
  var_20.angles = (0, 315.5, 0);
}

addpostshipcollision() {
  var_0 = getent("clip64x64x8", "targetname");
  var_1 = spawn("script_model", (-308, 1140, 176));
  var_1.angles = (347.949, 243.289, 3.284);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getent("clip64x64x8", "targetname");
  var_3 = spawn("script_model", (-320, 1134, 172));
  var_3.angles = (347.949, 243.289, 3.284);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getent("clip64x64x8", "targetname");
  var_5 = spawn("script_model", (-328, 1126, 166));
  var_5.angles = (348.358, 237.173, 4.54182);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getent("clip64x64x8", "targetname");
  var_7 = spawn("script_model", (-338, 1124, 160));
  var_7.angles = (348.358, 237.173, 4.541);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getent("clip8x8x256", "targetname");
  var_9 = spawn("script_model", (1064.6, -101.779, 192));
  var_9.angles = (9.99, 18.1, 178.013);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getent("clip8x8x256", "targetname");
  var_11 = spawn("script_model", (1068.6, -99.779, 190));
  var_11.angles = (0, 18.4102, 178.043);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getent("clip8x8x256", "targetname");
  var_13 = spawn("script_model", (1233, 33, -44));
  var_13.angles = (0, 18, 0);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getent("clip8x8x256", "targetname");
  var_15 = spawn("script_model", (1063, -15, -44));
  var_15.angles = (0, 18, 0);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_16 = getent("clip8x8x256", "targetname");
  var_17 = spawn("script_model", (1034.6, 32.2212, 198));
  var_17.angles = (6.011, 17.575, -176.066);
  var_17 clonebrushmodeltoscriptmodel(var_16);
  var_18 = getent("clip8x8x256", "targetname");
  var_19 = spawn("script_model", (1026.6, 22.2212, 200));
  var_19.angles = (11.998, 17.997, -176);
  var_19 clonebrushmodeltoscriptmodel(var_18);
}