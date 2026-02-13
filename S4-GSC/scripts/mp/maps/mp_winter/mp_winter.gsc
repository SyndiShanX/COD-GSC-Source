/***************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_winter\mp_winter.gsc
***************************************************/

main() {
  scripts\mp\maps\mp_winter\mp_winter_precache::main();
  scripts\mp\maps\mp_winter\gen\mp_winter_art::main();
  scripts\mp\maps\mp_winter\mp_winter_fx::main();
  scripts\mp\maps\mp_winter\mp_winter_lighting::main();
  _id_07EC::main();
  _id_07C0::_id_D88B("compass_map_mp_winter");
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
  level postshipspawns();
  level thread removepostshipscriptables();
  thread postshipgeofixes();
  thread postshipbadpathnodes();
  thread postshiphurttriggers();
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1049.95, 396.18, 412.5), (0, 148, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((1503.41, 936.432, 183.25), (0, 267.662, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-505.379, 1144.66, 208.75), (0, 280, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-2211.13, 52.8, 172.75), (0, 158, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((1229.77, 282.572, 124.75), (0, 82.504, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((508.507, 464.831, 96.25), (0, 0, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((1482.27, 744.655, 168.5), (0, 344.378, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-829.7, 424.93, 328.25), (0, 148, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((1035.95, -1062.04, 86.75), (0, 239.632, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-941.554, -814.576, 41.5), (0, 166, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((589.836, -171.451, 103.25), (0, 13, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-2356.79, 1726, 14), (0, 210.814, 0), "standing");
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("2", (-1484.09, 148.525, 152.112), (0, 0, 0), 0, (0, 0, 0));
}

postshiphurttriggers() {
  var_0 = 140;
  var_1 = 400;
  var_2 = spawn("trigger_radius", (-1182, 448, 4), 0, var_1, var_0);
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

postshipbadpathnodes() {
  var_0 = _func_03E0(1238);

  if(isDefined(var_0)) {
    var_0 _meth_80B4();

    if(isDefined(level._id_20EC)) {
      level._id_20EC[level._id_20EC.size] = var_0;
    } else {
      level._id_20EC = [];
      level._id_20EC[level._id_20EC.size] = var_0;
    }
  }
}

postshipspawns() {
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
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (-2065.61, 1222.03, 51.25), (0, 1.5, 0));
      break;
    case "dom":
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-2148.66, -257.17, 137.985), (0, 349.69, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-2022.66, -689.173, 100.074), (0, 355, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-2080.66, -893.173, 93.8027), (0, 8, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (744.34, 1517.33, 163.566), (0, 193, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (1074.34, 1477.33, 166.366), (0, 193, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (727.34, 703.33, 128.177), (0, 175, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (333.5, 1375.5, 170.548), (0, 177, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (207.5, 1145.5, 188.312), (0, 149, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (803.5, -240.5, 146.584), (0, 185, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (1147.5, -1148.5, 53.821), (0, 159, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (-1434.66, -1011.17, 57.6492), (0, 8, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (-1830.66, -801.17, 82.1889), (0, 8, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (-1786.66, -491.17, 143.634), (0, 8, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (-1260.66, 188.827, 166), (0, 10, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (-1144.66, 646.827, 184.5), (0, 346, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (-1126.66, 1070.83, 156.442), (0, 12, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (-1498.66, 1466.83, 51.25), (0, 8, 0));
      break;
    case "war":
    case "conf":
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-2148.66, -257.17, 137.985), (0, 349.69, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-2022.66, -689.173, 100.074), (0, 355, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-2080.66, -893.173, 93.8027), (0, 8, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (727.34, 703.33, 128.177), (0, 175, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (744.34, 1517.33, 163.566), (0, 193, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (1074.34, 1477.33, 166.366), (0, 193, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (333.5, 1375.5, 170.548), (0, 177, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (207.5, 1145.5, 188.312), (0, 149, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (803.5, -240.5, 146.584), (0, 185, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (1147.5, -1148.5, 53.821), (0, 159, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (-1434.66, -1011.17, 57.6492), (0, 8, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (-1830.66, -801.17, 82.1889), (0, 8, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (-1786.66, -491.17, 143.634), (0, 8, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (-1260.66, 188.827, 166), (0, 10, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (-1394.66, 708.827, 192.13), (0, 52, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (-1144.66, 646.827, 184.5), (0, 346, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (-1126.66, 1070.83, 156.442), (0, 12, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (-1498.66, 1466.83, 51.25), (0, 8, 0));
      break;
    case "patrol":
    case "koth":
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (-2022.09, 1302.48, 51.25), (0, 344, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (-1402.09, 594.48, 160), (0, 344, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (-1110.09, 980.48, 178.14), (0, 344, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (-1138.09, 620.48, 160), (0, 344, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (-1262.09, 188.48, 160), (0, 0, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (604, 1508, 172.854), (0, 276, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn_secondary", (788, 568, 118), (0, 234, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (674, 794, 121.429), (0, 210, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1236, 1028, 138.024), (0, 264, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1106, 1438, 159.991), (0, 264, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-2020, -689, 99.9395), (0, 350, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-2178, -243, 138.908), (0, 350, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1631, 1241, 51.25), (0, 30, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1875, 1697, 31), (0, 300, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1533, 2039, 88.4818), (0, 300, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1544, -827, 70.5466), (0, 161, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1064, 255, 131.301), (0, 195, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (762, 559, 112), (0, 223, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (738, 701, 128.44), (0, 181, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (994, 1424, 161.088), (0, 216, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-2420, 495, 169.911), (0, 345, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-2102, -263, 137.309), (0, 345, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1533.5, -615.5, 99.1118), (0, 9, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1640, 95, 181.572), (0, 345, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1812, 397, 181.22), (0, 345, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1220, 203, 181.22), (0, 9, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1374, 573, 181.22), (0, 345, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1128, 579, 181.22), (0, 345, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-586.44, 1340.5, 36.2441), (0, 300, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-528.44, 1408.5, 36.2441), (0, 300, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-194.502, 1939.56, 185.329), (0, 294, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1854, -869, 74.8777), (0, 76, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1622, -707, 85.982), (0, 76, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1222, -855, 72.4307), (0, 104, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-976, -605, 93.6647), (0, 100, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1745, -498.5, 74.689), (0, 132, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1257, 387.5, 134.267), (0, 162, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (735, 695.5, 128.579), (0, 174, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1681, 793.5, 156.01), (0, 180, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (562, 1489, 171.637), (0, 193, 0), undefined, "4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-2454.46, 199.75, 134), (0, 64, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-2074.46, 143.75, 168), (0, 76, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1776, -592, 114.635), (0, 70, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1534, -943.5, 53.6389), (0, 136, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1750.5, -429, 83.1399), (0, 143, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (720, 326.5, 128), (0, 191, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (704, 776.5, 123.676), (0, 191, 0), undefined, "5");
      break;
    default:
      break;
  }

  _id_0817::_id_1127(var_0);
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
}

removepostshipscriptables() {
  waitframe();
  var_0 = (-1528, 267, 156);
  _func_01BA(var_0, 10, 50, 50, undefined, undefined, undefined, 1, 0);
}

postshipgeofixes() {
  if(level.gametype == "control") {
    var_0 = getEntArray("vis_control_capture_b", "targetname");

    if(isDefined(var_0)) {
      foreach(var_2 in var_0) {
        if(isDefined(var_2)) {
          var_2 delete();
        }
      }
    }
  }
}