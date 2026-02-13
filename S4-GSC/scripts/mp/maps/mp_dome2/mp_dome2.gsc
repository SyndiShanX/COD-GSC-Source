/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_dome2\mp_dome2.gsc
*************************************************/

main() {
  scripts\mp\maps\mp_dome2\mp_dome2_precache::main();
  scripts\mp\maps\mp_dome2\gen\mp_dome2_art::main();
  scripts\mp\maps\mp_dome2\mp_dome2_fx::main();
  scripts\mp\maps\mp_dome2\mp_dome2_lighting::main();
  _id_07EC::main();
  _id_07C0::_id_D88B("compass_map_mp_dome2");
  setDvar("#x32ee39981452e9751", 8);
  setDvar("#x33a46addf6d447ec3", 300);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  game["allies"] = "USMC";
  game["axis"] = "ALQ";
  level._id_AD0F = getEntArray("OutOfBounds", "targetname");
  level._id_8D0B = getEntArray("kill_border_trigger", "targetname");
  setDvar("#x331157d6a11c2a653", 3000.0);
  setDvar("#x3b94d9d617f14e388", 500);
  setDvar("#x36d8bf82840d880d2", 1);
  scripts\mp\s4_elf_poi::add_elf_poi_position((1050, 1460, 504), (0, 1, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((28, 2113, 298), (0, 77, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-859, 1777, 286), (0, 131, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((162, 927, 226), (0, 151, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((954, 2338, 228), (0, 254, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((352, 480, 240), (0, 328, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-452, 578, 176), (0, 80, 0), "standing");
  level.fire_damage_triggers = getEntArray("trigger_radius_fire", "classname");

  foreach(var_1 in level.fire_damage_triggers) {
    var_1 thread handle_fire_damage_trigger(var_1);
  }

  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("1", (312.261, 1901.5, 802.677), (0, 0, 0), 1);
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("3", (727.957, 1766.11, 889.2), (0, 0, 0), 1);
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("4", (-531.057, 1786.18, 913.277), (0, 0, 0), 1);
  thread fix_collision();
  level addpostlaunchspawns();
}

handle_fire_damage_trigger(var_0) {
  var_0 endon("death");

  if(isDefined(var_0._id_F5AC)) {
    var_0 endon(var_0._id_F5AC);
  }

  var_1 = 5;
  var_2 = 1;
  var_3 = 0;

  if(!isDefined(var_0._id_CCFD) && !isDefined(var_0._id_CCFB)) {
    var_0._id_CCFD = 4;
    var_0._id_CCFB = 4;
  }

  if(var_0._id_CCFD == var_0._id_CCFB) {
    var_0._id_0393 = var_0._id_CCFD;
  }

  if(isDefined(var_0._id_0392)) {
    var_1 = var_0._id_0392;
  }

  for(;;) {
    var_0 waittill("trigger", var_4);
    var_5 = var_0.origin;

    if(isPlayer(var_4)) {
      var_3 = var_1;

      if(isDefined(var_0._id_03A0)) {
        if(distance2dsquared(var_4.origin, var_0.origin) <= _func_0219(var_0._id_03A0)) {
          if(isDefined(var_0._id_CDEB) && _func_02B7(var_0._id_CDEB)) {
            var_2 = var_0._id_CDEB;
          }

          var_3 = var_3 * var_2;
        } else
          var_3 = 0.0;
      }
    }

    if(istrue(var_4._id_014C)) {
      continue;
    }
    if(var_3 > 0.01) {
      var_4 dodamage(var_3, var_5, self, self, "MOD_FIRE", undefined);

      if(var_3 < 6) {
        var_4 playrumbleonentity("damage_light");
      } else {
        var_4 playrumbleonentity("damage_heavy");
      }
    }

    var_0 scripts\engine\utility::_id_0393();
  }
}

fix_collision() {
  var_0 = getent("clip32x32x256", "targetname");
  var_1 = spawn("script_model", (-1280.4, 1039.62, 192.088));
  var_1.angles = (270, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = spawn("script_model", (-1536.4, 1039.62, 192.088));
  var_2.angles = (270, 0, 0);
  var_2 clonebrushmodeltoscriptmodel(var_0);
  var_3 = spawn("script_model", (-1792.4, 1039.62, 192.088));
  var_3.angles = (270, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_0);
  var_4 = spawn("script_model", (-2048.4, 1039.62, 192.088));
  var_4.angles = (270, 0, 0);
  var_4 clonebrushmodeltoscriptmodel(var_0);
  var_5 = getent("clip512x512x8", "targetname");
  var_6 = spawn("script_model", (-1888, 787.224, 104.911));
  var_6.angles = (0, 0, -157.452);
  var_6 clonebrushmodeltoscriptmodel(var_5);
  var_7 = spawn("script_model", (-1888, 1182.9, -32.3487));
  var_7.angles = (0, 0, -62.8009);
  var_7 clonebrushmodeltoscriptmodel(var_5);

  foreach(var_9 in level._id_AD0F) {
    if(var_9.origin == (-584, 2937, 348)) {
      var_9.origin = (-584, 2962, 348);
    }
  }

  var_11 = 500;
  var_12 = 500;
  var_13 = spawn("trigger_radius", (-2264, 824, -53), 0, var_12, var_11);
  var_13 thread _id_8D46();
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

addpostlaunchspawns() {
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
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-1226, 1340, 244), (0, 70, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-1208, 848, 244), (0, 44, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-1106, 848, 244), (0, 64, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-152, 448, 154), (0, 55, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (96, 310, 154), (0, 90, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (172, 516, 154), (0, 105, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (132, 796, 155), (0, 0, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (584, 756, 152), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (680, 620, 152), (0, 150, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (940, 848, 244), (0, 108, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (1018, 848, 244), (0, 104, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (878, 1344, 408), (0, 90, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (1126, 1460, 327), (0, 270, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (772, 1844, 242), (0, 180, 0));
      break;
    case "war":
    case "conf":
      level._id_9FFA["-809 1300 246"]["mp_tdm_spawn_secondary"]["origin"] = (-809, 1268, 244);
      level._id_9FFA["-50 2197 226"]["mp_tdm_spawn_secondary"]["origin"] = (-42, 2261, 242);
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-944, 2448, 400), (0, 270, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-880, 2376, 400), (0, 270, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-880, 2240, 400), (0, 315, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-864, 2000, 400), (0, 270, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-898.5, 1915.5, 238), (0, 240, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-920, 1896, 400), (0, 0, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-888, 1576, 400), (0, 0, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (871, 1329, 409), (0, 90, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (-868, 1749, 420), (0, 0, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (-767.996, 2000.77, 254), (0, 315, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (-160.5, 1605.5, 234), (0, 0, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (-37.5, 1607.5, 234), (0, 164.999, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (15.5, 1605.5, 234), (0, 14.9992, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (214, 2136, 249.057), (0, 0, 0));
      break;
    case "patrol":
    case "koth":
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-646, 742, 158.05), (0, 0, 0), undefined, "1 3 4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-646, 652, 152), (0, 20, 0), undefined, "1 3 4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-378, 334, 163.276), (0, 180, 0), undefined, "1 3 4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-304, 334, 156.524), (0, 0, 0), undefined, "1 3 4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-104, 558, 152.163), (0, 84, 0), undefined, "1 3 4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (4, 472, 154), (0, 90, 0), undefined, "1 3 4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (164, 518, 152), (0, 90, 0), undefined, "1 3 4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (302, 334, 164), (0, 180, 0), undefined, "1 3 4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (376, 334, 156.572), (0, 0, 0), undefined, "1 3 4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (668, 648, 152), (0, 152, 0), undefined, "1 3 4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (668, 742, 158.406), (0, 180, 0), undefined, "1 3 4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-80, 914, 240), (0, 90, 0), undefined, "2 4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (50, 916, 240), (0, 90, 0), undefined, "2 4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (718, 1116, 240), (0, 180, 0), undefined, "2 4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (718, 1194, 240), (0, 180, 0), undefined, "2 4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1000, 1178, 240), (0, 240, 0), undefined, "1 2 4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1246, 1444, 409), (0, 256, 0), undefined, "2 4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (1244, 1568, 409), (0, 180, 0), undefined, "2 4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (779.503, 1694.8, 242.556), (0, 180, 0), undefined, "2 4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (779.503, 1846.8, 242.801), (0, 188, 0), undefined, "2 4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (779.491, 1916.8, 242), (0, 202, 0), undefined, "2 4");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (591.2, 2283.51, 243.227), (0, 270, 0), undefined, "2 5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-53.5418, 1721.28, 243.855), (0, 246, 0), undefined, "2 5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (34.453, 1719.23, 244.09), (0, 306, 0), undefined, "2 5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (298.468, 2031.21, 243.346), (0, 328, 0), undefined, "2 4 5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (226.493, 2113.2, 243.018), (0, 0, 0), undefined, "2 5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (126.493, 2163.2, 242), (0, 0, 0), undefined, "2 5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-74.4931, 2162.8, 242), (0, 180, 0), undefined, "2 5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-212.493, 2110.8, 247.301), (0, 180, 0), undefined, "2 5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-308.545, 2028.77, 242), (0, 250, 0), undefined, "2 3 5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-773.54, 2251.22, 242), (0, 360, 0), undefined, "3 5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-773.54, 2165.22, 249.609), (0, 360, 0), undefined, "3 5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-781.54, 1785.22, 242), (0, 316, 0), undefined, "3 5");
      break;
    default:
      break;
  }

  _id_0817::_id_1127(var_0);
}