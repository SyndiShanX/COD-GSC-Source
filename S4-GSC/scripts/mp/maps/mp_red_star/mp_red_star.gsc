/*******************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_red_star\mp_red_star.gsc
*******************************************************/

main() {
  scripts\mp\maps\mp_red_star\mp_red_star_precache::main();
  scripts\mp\maps\mp_red_star\gen\mp_red_star_art::main();
  scripts\mp\maps\mp_red_star\mp_red_star_fx::main();
  scripts\mp\maps\mp_red_star\mp_red_star_lighting::main();
  _id_07EC::main();
  _id_07C0::_id_D88B("compass_map_mp_red_star");
  setDvar("#x32ee39981452e9751", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  game["allies"] = "USMC";
  game["axis"] = "ALQ";
  _func_0446(48);
  setDvar("#x331157d6a11c2a653", 3000.0);
  setDvar("#x3b94d9d617f14e388", 1200);
  setDvar("#x36d8bf82840d880d2", 1);
  scripts\mp\s4_elf_poi::add_elf_poi_position((2255.51, -1020.28, 222.041), (0, 156.23, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((2237.67, 1730, 73.418), (0, 262.665, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((633.805, 2199.44, 279.562), (0, 216.135, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-41.301, 490.59, 237.601), (0, 22.336, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-44.316, -1322.98, 277.045), (0.339, 47.111, 3.286), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1194.97, -297.03, 528.5), (0, 318.466, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((921.358, -2378.23, 404), (0, 139.76, 0), "standing");
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("2", (225, 1991, 219), (0, 0, 0), 1);
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("3", (-1828.29, 647.708, 173.371), (0, 0, 0), 0, (0, -5.9098, 0));
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("4", (931.769, -1955.78, 518.902), (0, 0, 0), 1);
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("5", (1371.99, 1054.37, 169.238), (0, 0, 0), 0, (0, -84.9624, 0));
  level.airstrikeheightoffset = 1500;
}