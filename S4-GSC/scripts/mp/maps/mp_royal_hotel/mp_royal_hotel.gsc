/*************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_royal_hotel\mp_royal_hotel.gsc
*************************************************************/

main() {
  scripts\mp\maps\mp_royal_hotel\mp_royal_hotel_precache::main();
  scripts\mp\maps\mp_royal_hotel\gen\mp_royal_hotel_art::main();
  scripts\mp\maps\mp_royal_hotel\mp_royal_hotel_fx::main();
  scripts\mp\maps\mp_royal_hotel\mp_royal_hotel_lighting::main();
  _id_07EC::main();
  _id_07C0::_id_D88B("compass_map_mp_royal_hotel");
  setDvar("#x32ee39981452e9751", 8);
  setDvar("#x331157d6a11c2a653", 3000.0);
  setDvar("#x3b94d9d617f14e388", 1200);
  setDvar("#x36d8bf82840d880d2", 1);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  game["allies"] = "USMC";
  game["axis"] = "ALQ";
  level.gameobjectsoutofboundsz = -1000;
  _func_0446(48);
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1.07956, -289.977, 53.25), (0, 99.782, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-532.58, 491.773, -98.75), (0, 99.782, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-12.3835, 74.754, -85.25), (0, 255.593, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-78.5, 558.5, 81), (0, 0, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((1001.84, -775.119, 56.75), (0, 153.975, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((20.9737, 460.326, 510.25), (0, 357.394, 0), "s4_mp_elf_pose_hang_03");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1382.25, 694.5, 173.5), (0, 0, 0), "s4_mp_elf_pose_hang_03");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-408.759, -375.168, 355.5), (0, 281.741, 0), "s4_mp_elf_pose_hang_01");
  scripts\mp\s4_elf_poi::add_elf_poi_position((345.82, 624.146, -136.25), (0, 105.878, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((1214.71, -95.6882, -35), (0, 66.758, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((576.086, 232.116, -117.75), (0, 164.388, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((26.8728, -660.504, -60.25), (0, 275.686, 0), "laying");
  thread fixbadpathnodes();
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("1", (-282.032, 192.066, 0.442521), (0, 0, 0), 1);
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("3", (562.556, -415.509, 54.5212), (0, 0, 0), 1);
}

fixbadpathnodes() {
  var_0 = [];
  var_0[var_0.size] = _func_03E0(1096);
  var_0[var_0.size] = _func_03E0(1097);
  var_0[var_0.size] = _func_03E0(589);
  var_0[var_0.size] = _func_03E0(590);

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