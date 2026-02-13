/***************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_tuscan\mp_tuscan.gsc
***************************************************/

main() {
  scripts\mp\maps\mp_tuscan\mp_tuscan_precache::main();
  scripts\mp\maps\mp_tuscan\gen\mp_tuscan_art::main();
  scripts\mp\maps\mp_tuscan\mp_tuscan_fx::main();
  scripts\mp\maps\mp_tuscan\mp_tuscan_lighting::main();
  _id_07EC::main();
  _id_07C0::_id_D88B("compass_map_mp_tuscan");
  setDvar("#x32ee39981452e9751", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  game["allies"] = "USMC";
  game["axis"] = "ALQ";
  setDvar("#x331157d6a11c2a653", 3000.0);
  setDvar("#x3b94d9d617f14e388", 1200);
  setDvar("#x36d8bf82840d880d2", 1);
  scripts\mp\s4_elf_poi::add_elf_poi_position((70, 384, 330), (0, 92, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((1432, 244, 136), (0, 242, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((80, -280, 470), (0, 278, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((702, -1674, 160), (0, 338, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-168, -734, 346), (0, 313, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1576, -690, 160), (0, 133, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1846, -1512, 312), (0, 93, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1040, 458, 238), (0, 97, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1138, -1838, 334), (0, 48, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1266, -1204, 398), (0, 305, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-412, -1446, 422), (0, 202, 0), "sitting");
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("4", (245.238, -246.376, 267.741), (0, 0, 0), 1);
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("5", (-621.152, -1744.73, 280.208), (0, 0, 0), 1);
  level.airstrikeheightoffset = 3000;
  level thread postshipspawns();
}

postshipspawns() {
  removeunusedspawns();
  addpostlaunchspawns();
}

removeunusedspawns() {
  level._id_9FFA["-9280 8384"]["mp_dd_spawn_attacker_a"]["remove"] = 1;
  level._id_9FFA["-9280 8320"]["mp_dd_spawn_attacker"]["remove"] = 1;
  level._id_9FFA["-9280 8256"]["mp_dd_spawn_attacker_b"]["remove"] = 1;
  level._id_9FFA["-9216 8320"]["mp_dd_spawn_attacker_start"]["remove"] = 1;
  level._id_9FFA["-8192 8320"]["mp_dd_spawn_defender_start"]["remove"] = 1;
  level._id_9FFA["-8128 8384"]["mp_dd_spawn_defender_a"]["remove"] = 1;
  level._id_9FFA["-8128 8320"]["mp_dd_spawn_defender"]["remove"] = 1;
  level._id_9FFA["-8128 8256"]["mp_dd_spawn_attacker_b"]["remove"] = 1;
  level._id_9FFA["-9216 7936"]["mp_front_spawn_allies"]["remove"] = 1;
  level._id_9FFA["-8192 7936"]["mp_front_spawn_axis"]["remove"] = 1;
  level._id_9FFA["-9216 7744"]["mp_ball_spawn_allies_start"]["remove"] = 1;
  level._id_9FFA["-8704 7616"]["mp_ball_spawn"]["remove"] = 1;
  level._id_9FFA["-8192 7744"]["mp_ball_spawn_axis_start"]["remove"] = 1;
  level._id_9FFA["80 -964"]["mp_koth_spawn_secondary"]["remove"] = 1;
  level._id_9FFA["-474 -1030"]["mp_koth_spawn_secondary"]["remove"] = 1;
  level._id_9FFA["-458 -560"]["mp_koth_spawn"]["remove"] = 1;
  level._id_9FFA["-648 852"]["mp_koth_spawn"]["remove"] = 1;
  level._id_9FFA["-512 468"]["mp_koth_spawn"]["remove"] = 1;
  level._id_9FFA["-382 594"]["mp_koth_spawn"]["remove"] = 1;
  level._id_9FFA["-382 474"]["mp_koth_spawn"]["remove"] = 1;
  level._id_9FFA["1906 -171"]["mp_control_spawn_defender_start"]["remove"] = 1;
  level._id_9FFA["1902 -273"]["mp_control_spawn_defender_start"]["remove"] = 1;
  level._id_9FFA["1837 -165"]["mp_control_spawn_defender_start"]["remove"] = 1;
  level._id_9FFA["1839 -220"]["mp_control_spawn_defender_start"]["remove"] = 1;
  level._id_9FFA["1839 -271"]["mp_control_spawn_defender_start"]["remove"] = 1;
  level._id_9FFA["1836 -338"]["mp_control_spawn_defender_start"]["remove"] = 1;
  level._id_9FFA["1751 -168"]["mp_control_spawn_defender_start"]["remove"] = 1;
  level._id_9FFA["1765 -217"]["mp_control_spawn_defender_start"]["remove"] = 1;
  level._id_9FFA["1751 -289"]["mp_control_spawn_defender_start"]["remove"] = 1;
  level._id_9FFA["1760 -355"]["mp_control_spawn_defender_start"]["remove"] = 1;
  level._id_9FFA["1781 -433"]["mp_control_spawn_defender_start"]["remove"] = 1;
  level._id_9FFA["1687 -176"]["mp_control_spawn_defender_start"]["remove"] = 1;
  level._id_9FFA["1687 -253"]["mp_control_spawn_defender_start"]["remove"] = 1;
  level._id_9FFA["1684 -330"]["mp_control_spawn_defender_start"]["remove"] = 1;
  level._id_9FFA["1627 -206"]["mp_control_spawn_defender_start"]["remove"] = 1;
  level._id_9FFA["1610 -287"]["mp_control_spawn_defender_start"]["remove"] = 1;
}

addpostlaunchspawns() {
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "ctf":
      break;
    case "patrol":
    case "koth":
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (-474.75, -1342.75, 53.25), (0, 125, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (92.5, 614, 145.5), (0, 187, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (396, 750, 146), (0, 187, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (582, 142, 146), (0, 145, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (616, -38, 150), (0, 180, 0), undefined, "3");
      break;
    case "control":
      var_0[var_0.size] = _id_0817::_id_4046("mp_control_spawn_defender_start", (2528, -236, 139), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_control_spawn_defender_start", (2452, -186, 139), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_control_spawn_defender_start", (2448, -288, 139), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_control_spawn_defender_start", (2444, -406, 139), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_control_spawn_defender_start", (2376, -154, 139), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_control_spawn_defender_start", (2378, -226, 139), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_control_spawn_defender_start", (2378, -288, 139), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_control_spawn_defender_start", (2374, -350, 139), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_control_spawn_defender_start", (2294, -182, 139), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_control_spawn_defender_start", (2294, -270, 139), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_control_spawn_defender_start", (2290, -388, 139), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_control_spawn_defender_start", (2202, -308, 139), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_control_spawn_defender_start", (2206, -230, 139), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_control_spawn_defender_start", (2206, -140, 139), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_control_spawn_defender_start", (2140, -176, 139), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_control_spawn_defender_start", (2122, -258, 139), (0, 180, 0));
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
    default:
      break;
  }

  _id_0817::_id_1127(var_0);
}