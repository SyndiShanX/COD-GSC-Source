/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_radar\mp_radar.gsc
*************************************************/

main() {
  scripts\mp\maps\mp_radar\mp_radar_precache::main();
  scripts\mp\maps\mp_radar\gen\mp_radar_art::main();
  scripts\mp\maps\mp_radar\mp_radar_fx::main();
  scripts\mp\maps\mp_radar\mp_radar_lighting::main();
  _id_07EC::main();
  _id_07C0::_id_D88B("compass_map_mp_radar");
  setDvar("#x32ee39981452e9751", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  game["allies"] = "USMC";
  game["axis"] = "ALQ";
  level._id_F7AA = 0;
  level._id_AD0F = getEntArray("OutOfBounds", "targetname");
  setDvar("#x331157d6a11c2a653", 3000.0);
  setDvar("#x3b94d9d617f14e388", 1200);
  setDvar("#x36d8bf82840d880d2", 1);
  thread fixpostlaunchspawns();
  thread fixpostshipbadpathnodes();
  thread fixcollision();
  level.airstrikeheightoffset = 2500;
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("1", (-544.176, 1025.02, -296.931), (0, 0, 0), 0, (0, -143.159, 0));
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("2", (1284.65, 781.417, -320.482), (0, 0, 0), 0, (0, 112.322, 0));
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("3", (555.629, -318.626, -391.471), (0, 0, 0), 0, (0, -171.044, 0));
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("4", (112.23, 2101.88, -279.771), (0, 0, 0), 0, (0, 39.9531, 0));
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("5", (-802.982, 173.047, -416.173), (0, 0, 0), 0, (0, -156.623, 0));
  scripts\mp\gametypes\mendota::mendota_register("kenosha", (-3701.9, -24985.2, -1548.5), (0, 234.727, 0));
  scripts\mp\gametypes\mendota::mendota_register("greenbay", (-11682.3, -27772.3, -1548.5), (0, 103.057, 0));
}

fixpostshipbadpathnodes() {
  var_0 = [];
  var_0 = scripts\engine\utility::_id_1B9D(var_0, _func_00B5((-8896, 8864, 0), 128, 0, 128));
  var_0 = scripts\engine\utility::_id_1B9D(var_0, _func_00B5((-8512, 8864, 0), 128, 0, 128));

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
    case "patrol":
    case "koth":
      level._id_9FFA["-927 1081"]["mp_patrol_spawn"]["remove"] = 1;
      break;
    case "control":
      break;
    case "sd":
      break;
    case "gun":
    case "dm":
      break;
    case "dom":
      break;
    case "conf":
    case "war":
      level._id_9FFA["992 -608 -384"]["mp_tdm_spawn_axis_start"]["origin"] = (1000, -576, -384);
      break;
    default:
      break;
  }

  _id_0817::_id_1127(var_0);
}

fixcollision() {
  var_0 = getent("clip128x128x8", "targetname");
  var_1 = spawn("script_model", (894, 803, -274));
  var_1.angles = (89.9997, 199.498, 28.7025);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getent("clip128x128x8", "targetname");
  var_3 = spawn("script_model", (839.913, 868.762, -274));
  var_3.angles = (89.9997, 199.017, 118.221);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getent("clip128x128x8", "targetname");
  var_5 = spawn("script_model", (722.162, 887.408, -274));
  var_5.angles = (89.9997, 199.017, 118.221);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getent("player32x32x256", "targetname");
  var_7 = spawn("script_model", (672.512, 880.306, -466));
  var_7.angles = (359.975, 80.8008, -0.00411004);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getent("player32x32x256", "targetname");
  var_9 = spawn("script_model", (667.512, 849.306, -466));
  var_9.angles = (359.975, 80.8008, -0.00411004);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getent("player32x32x256", "targetname");
  var_11 = spawn("script_model", (662.512, 818.306, -466));
  var_11.angles = (359.975, 80.8008, -0.00411004);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getent("clip128x128x8", "targetname");
  var_13 = spawn("script_model", (-133.929, 1226.79, -274));
  var_13.angles = (89.9997, 199.605, 50.7103);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getent("clip128x128x8", "targetname");
  var_15 = spawn("script_model", (-198.149, 1119.49, -274));
  var_15.angles = (89.9997, 199.605, 50.7103);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_16 = getent("clip128x128x8", "targetname");
  var_17 = spawn("script_model", (-255.149, 1154.49, -274));
  var_17.angles = (89.9997, 199.605, 50.7103);
  var_17 clonebrushmodeltoscriptmodel(var_16);
  var_18 = getent("clip128x128x8", "targetname");
  var_19 = spawn("script_model", (-189.929, 1262.79, -274));
  var_19.angles = (89.9997, 199.605, 50.7103);
  var_19 clonebrushmodeltoscriptmodel(var_18);
  var_20 = getent("player32x32x256", "targetname");
  var_21 = spawn("script_model", (-152.568, 1294.78, -466.021));
  var_21.angles = (359.976, 58.3997, 0.00539915);
  var_21 clonebrushmodeltoscriptmodel(var_20);
  var_22 = getent("player32x32x256", "targetname");
  var_23 = spawn("script_model", (-125.784, 1278.39, -466.01));
  var_23.angles = (359.976, 58.3997, 0.00539915);
  var_23 clonebrushmodeltoscriptmodel(var_22);
  var_24 = getent("player32x32x256", "targetname");
  var_25 = spawn("script_model", (-240.387, 1089.42, -466.095));
  var_25.angles = (359.976, 58.3997, 0.00539915);
  var_25 clonebrushmodeltoscriptmodel(var_24);
  var_26 = getent("player32x32x256", "targetname");
  var_27 = spawn("script_model", (-266.387, 1105.42, -466.095));
  var_27.angles = (359.976, 58.3997, 0.00539915);
  var_27 clonebrushmodeltoscriptmodel(var_26);
}