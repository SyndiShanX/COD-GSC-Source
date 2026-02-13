/*******************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_paradise\mp_paradise.gsc
*******************************************************/

main() {
  scripts\mp\maps\mp_paradise\mp_paradise_precache::main();
  scripts\mp\maps\mp_paradise\gen\mp_paradise_art::main();
  scripts\mp\maps\mp_paradise\mp_paradise_fx::main();
  scripts\mp\maps\mp_paradise\mp_paradise_lighting::main();
  _id_07EC::main();
  _id_07C0::_id_D88B("compass_map_mp_paradise");
  setDvar("#x32ee39981452e9751", 8);
  setDvar("#x33a46addf6d447ec3", 300);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  game["allies"] = "USMC";
  game["axis"] = "ALQ";
  level._id_F7AA = 0;
  level._id_AD0F = getEntArray("OutOfBounds", "targetname");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-3044.61, -1042.06, 98.8362), (0, 205, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-2512.76, 200.173, 81.5502), (0, 115, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-872.456, 1539.06, 79.9471), (0, 210, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-934.596, 2106.25, 97.4309), (0, 265, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1331.82, 526.002, 250.227), (0, 115, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((551.384, 527.103, 245.979), (0, 115, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((1603.5, 153.989, 183.652), (0, 260, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1028.1, -1416.31, -33.6304), (0, 260, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1871.15, -764.871, 68.4681), (0, 115, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-896.527, 1425.1, -150.149), (0, 290, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((101.701, 1761.12, 290.37), (0, 295, 0), "standing");
  level.airstrikeheightoffset = 800;
  setDvar("#x331157d6a11c2a653", 3500.0);
  setDvar("#x3b94d9d617f14e388", 1200);
  setDvar("#x36d8bf82840d880d2", 1);
  thread fixpostlaunchladderexploit();
  level fixpostlaunchspawns();
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("1", (53.8813, 1309.45, 36.3809), (0, 0, 0), 0, (0, 93.0951, 0));
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("3", (-895.69, 1490.35, -48.6179), (0, 0, 0), 1);
  thread fixcollision();
}

fixpostlaunchladderexploit() {
  var_0 = 100;
  var_1 = 128;
  var_2 = spawn("trigger_radius", (184, 1760, -20), 0, var_1, var_0);
  var_2 thread _id_8D46();
}

_id_8D46() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_0);

    if(isDefined(var_0) && !_func_0458(var_0) && isPlayer(var_0) && isalive(var_0)) {
      var_0 _meth_81FA(self.origin, self, self, "MOD_TRIGGER_HURT");
    }
  }
}

fixpostlaunchspawns() {
  removeunusedspawns();
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
      level._id_9FFA["1281 -2226"]["mp_dm_spawn_start"]["remove"] = 1;
      level._id_9FFA["402 1373"]["mp_dm_spawn_start"]["remove"] = 1;
      break;
    case "dom":
      break;
    case "conf":
    case "war":
      break;
    case "patrol":
    case "koth":
      break;
    default:
      break;
  }

  _id_0817::_id_1127(var_0);
}

removeunusedspawns() {
  level._id_9FFA["-9216 7936"]["mp_front_spawn_allies"]["remove"] = 1;
  level._id_9FFA["-9216 7744"]["mp_ball_spawn_allies_start"]["remove"] = 1;
  level._id_9FFA["-8704 7616"]["mp_ball_spawn"]["remove"] = 1;
  level._id_9FFA["-8192 7744"]["mp_ball_spawn_axis_start"]["remove"] = 1;
  level._id_9FFA["-8192 7936"]["mp_front_spawn_axis"]["remove"] = 1;
}

fixcollision() {
  var_0 = getent("clip128x128x256", "targetname");
  var_1 = spawn("script_model", (-3001, -2368, -176));
  var_1.angles = (353.127, 120.109, 1.8247);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getent("clip64x64x256", "targetname");
  var_3 = spawn("script_model", (-3070, -2413, -174));
  var_3.angles = (0, 29.999, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getent("clip64x64x256", "targetname");
  var_5 = spawn("script_model", (-3063, -2425, -176));
  var_5.angles = (0, 29.999, 9.99985);
  var_5 clonebrushmodeltoscriptmodel(var_4);
}