/*********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_berlin_01\mp_berlin_01.gsc
*********************************************************/

main() {
  scripts\mp\maps\mp_berlin_01\mp_berlin_01_precache::main();
  scripts\mp\maps\mp_berlin_01\gen\mp_berlin_01_art::main();
  scripts\mp\maps\mp_berlin_01\mp_berlin_01_fx::main();
  scripts\mp\maps\mp_berlin_01\mp_berlin_01_lighting::main();
  _id_07EC::main();
  _id_07C0::_id_D88B("compass_map_mp_berlin_01");
  setDvar("#x32ee39981452e9751", 8);
  setDvar("#x33a46addf6d447ec3", 300);
  setDvar("#x331157d6a11c2a653", 3600.0);
  setDvar("#x3b94d9d617f14e388", 700.0);
  setDvar("#x36d8bf82840d880d2", 1);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  game["allies"] = "USMC";
  game["axis"] = "ALQ";
  level._id_AD0F = getEntArray("OutOfBounds", "targetname");
  level._id_8D0B = getEntArray("kill_border_trigger", "targetname");
  thread craneswing();
  thread craneswingshort();
  level.airstrikeheightoffset = 2500;
  thread fix_collision();
  level postshipspawns();
  thread fixladderbelowworldbugs();
  scripts\mp\s4_elf_poi::add_elf_poi_position((2036.38, 408.489, 175), (0, 90, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((1677, 780, 260.288), (0, 173, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((1865.16, 1213.65, 254.214), (0, 0, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((1069.85, 1415.99, 169.848), (0, 270, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-528, 1610, 111.158), (0, 270, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-224.01, 1096.23, 227.606), (0, 289, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1628.87, 1563.82, 230.042), (0, 343, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1675.07, 154.173, 280.25), (0, 270, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-734.634, 381.814, 390.748), (0, 121, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-414.926, 76.5065, 432), (0, 294, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-432, -416, 183), (0, 180, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-290, -416, 183), (0, 360, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1087, -243.023, 290), (0, 223, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1121.46, -989.923, 272), (0, 39, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-791.047, -659.453, 308), (0, 219, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-709.015, -1092.99, 287.587), (0, 90, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((114.917, -1231.05, 222.5), (0, 270, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((339.055, -416.215, 349.577), (0, 270, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((382.359, 248.348, 432.006), (0, 180, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((664, 405.5, 329.5), (0, 90, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((665.412, 524.44, 187.977), (0, 90, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((1511.91, -352.841, 175), (0, 173, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((2252.62, -151.717, 287), (0, 270, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((2046.62, -463.717, 175), (0, 45, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((805.215, -864.761, 176), (0, 45, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-562.411, -1449.58, 271.878), (0, 241, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((1383.86, -1727.04, 304), (0, 135, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((1696.36, -1534.54, 304), (0, 315, 0), "standing ");
  scripts\mp\s4_elf_poi::add_elf_poi_position((725, 1037, 249), (0, 180, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1294, 252, 437), (0, 180, 0), "sitting");
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("1", (-1358.06, -476.013, 272.125), (0, 0, 0), 0, (0, -142.991, 0));
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("2", (515.228, 871.743, 134.125), (0, 0, 0), 0, (0, -93.8817, 0));
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("3", (-1724.99, 778.614, 231.786), (0, 0, 0), 0, (0, -145.164, 0));
}

fixladderbelowworldbugs() {
  var_0 = spawn("trigger_radius", (1792, -1646, -20), 0, 256, 128);
  var_0 thread _id_8D46();
}

_id_8D46() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_0);

    if(isPlayer(var_0) && isalive(var_0)) {
      var_0 _meth_81FA(self.origin, self, self, "MOD_TRIGGER_HURT");
    }
  }
}

craneswing() {
  var_0 = getEntArray("crane_rope", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.target)) {
      var_2.cratemesh = getent(var_2.target, "targetname");
      var_2.cratemesh linkto(var_2);
    }

    var_2 thread craneswingthink();
  }
}

craneswingthink() {
  level endon("game_ended");
  var_0 = randomfloatrange(0.1, 1.0);
  var_1 = randomfloatrange(4.0, 5.0);
  var_2 = (-2, 32, -8);
  var_3 = (2, -32, 8);
  wait(var_0);

  for(;;) {
    self rotateto(var_2, var_1, 0.5, 0.5);
    self waittill("rotatedone");
    self rotateto(var_3, var_1, 0.5, 0.5);
    self waittill("rotatedone");
  }
}

craneswingshort() {
  level endon("game_ended");
  var_0 = getent("crane_rope_short", "targetname");
  var_1 = randomfloatrange(0.1, 1.0);
  var_2 = randomfloatrange(4.0, 5.0);
  var_3 = (0, 40, -3);
  var_4 = (0, -40, 3);
  wait(var_1);

  for(;;) {
    var_0 rotateto(var_3, var_2, 1, 1);
    var_0 waittill("rotatedone");
    var_0 rotateto(var_4, var_2, 1, 1);
    var_0 waittill("rotatedone");
  }
}

fix_collision() {
  var_0 = getent("clip128x128x8", "targetname");
  var_1 = spawn("script_model", (-769, 658, 501));
  var_1.angles = (0, 0, -90);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getent("clip64x64x256", "targetname");
  var_3 = spawn("script_model", (-2098, 8, 236));
  var_3.angles = (0, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getent("clip64x64x256", "targetname");
  var_5 = spawn("script_model", (-2082, 8, 236));
  var_5.angles = (0, 0, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = spawn("script_model", (-2116, -228, 220));
  var_6 setModel("s4_ger_berlin_tarp_cover_standing_full_08_wet");
  var_6.angles = (359.866, 220.187, -7.45168);
  var_7 = spawn("script_model", (-2160, -196, 226));
  var_7 setModel("s4_rus_sandbag_lrg_01");
  var_7.angles = (6.94011, 313.26, 1.80004);
  var_8 = spawn("script_model", (-2122, -292, 214));
  var_8 setModel("s4_rus_sandbag_lrg_01");
  var_8.angles = (6.94011, 313.26, 1.80004);
  var_9 = getent("clip32x32x256", "targetname");
  var_10 = spawn("script_model", (300, 1658, 128));
  var_10.angles = (0, 180, -180);
  var_10 clonebrushmodeltoscriptmodel(var_9);
}

postshipspawns() {
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
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (934, -2010, 192.5), (0, 146, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (1094, -704, 144), (0, 180, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (1078, 20, 156), (0, 202, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (-522, 550, 288), (0, 254, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (-910, 568, 175.711), (0, 270, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (2204, 1328, 162), (0, 181, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (-962, 458, 189.37), (0, 2, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (-1158, 254, 288), (0, 2, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (-1344, 36, 155.75), (0, 2, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (-1928, 406, 264), (0, 2, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (450, -806, 308), (0, 135, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (-778, -1362, 288), (0, 89, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (1733.25, 303, 191), (0, 270, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (887.25, 1069, 191), (0, 296, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (-404.75, -583, 150), (0, 342, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (-1266.75, 75, 161), (0, 342, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (-886.75, -651, 288), (0, 310, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (-1152.75, -877, 288), (0, 310, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (2422, -210, 191), (0, 180, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (2224, 1100, 162), (0, 196, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (-1478.25, 1423.25, 143.177), (0, 336, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (-966.25, 485.25, 185.707), (0, 2, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (-1158.25, 241.25, 288), (0, 2, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1378.25, 747.25, 229.611), (0, 2, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1782.25, 501.25, 264), (0, 2, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1826.25, 195.25, 264), (0, 2, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-2306.25, 533.25, 264.306), (0, 2, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-2288.25, 307.25, 264.306), (0, 2, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-2286.25, 133.25, 264.306), (0, 2, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1768.25, -128.75, 288), (0, 2, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1404.25, -900.75, 280.5), (0, 36, 0), undefined, "5");
      level._id_9FFA["-2312 56"]["mp_koth_spawn"]["remove"] = 1;
      level._id_9FFA["-2179 35"]["mp_koth_spawn"]["remove"] = 1;
      level._id_9FFA["-1748 -246"]["mp_koth_spawn"]["remove"] = 1;
      level._id_9FFA["-1600 -304"]["mp_koth_spawn"]["remove"] = 1;
      level._id_9FFA["-1396 -932"]["mp_koth_spawn"]["remove"] = 1;
      break;
    default:
      break;
  }

  _id_0817::_id_1127(var_0);
}