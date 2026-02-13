/*****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_gavutu2\mp_gavutu2.gsc
*****************************************************/

main() {
  scripts\mp\maps\mp_gavutu2\mp_gavutu2_precache::main();
  scripts\mp\maps\mp_gavutu2\gen\mp_gavutu2_art::main();

  if(!getdvarint("#x3a8fb0620196c6263")) {
    scripts\mp\maps\mp_gavutu2\mp_gavutu2_fx::main();
  }

  scripts\mp\maps\mp_gavutu2\mp_gavutu2_lighting::main();
  _id_07EC::main();
  _id_0847::_id_DEEC();
  _id_07C0::_id_D88B("compass_map_mp_gavutu2");
  setDvar("#x32ee39981452e9751", 8);
  setDvar("#x3d16c9a360648a055", 1);
  setDvar("#x3e634b52165a47381", 4096);
  setDvar("#x3d2f3327c3c633b22", 4096);
  setDvar("#x33daa745c39326583", 5);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  game["allies"] = "USMC";
  game["axis"] = "ALQ";
  level._id_F7AA = undefined;
  level._id_AD0F = getEntArray("OutOfBounds", "targetname");
  level._id_8D0B = getEntArray("kill_border_trigger", "targetname");
  setDvar("#x331157d6a11c2a653", 3600.0);
  setDvar("#x3b94d9d617f14e388", 1500);
  setDvar("#x36d8bf82840d880d2", 1);
  thread _id_98D7();
  level fixpostlaunchspawns();
  thread fixladderbelowworldbugs();
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1047.16, -1314.95, 1628.75), (0, 252.964, 0), "s4_mp_elf_pose_hang_03");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-2677.94, 786.257, 1208.75), (0, 251.222, 0), "s4_mp_elf_pose_hang_02");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-2041.65, 187.18, 1280.51), (7.80144, 248.534, -2.30142), "s4_mp_elf_pose_hang_02");
  scripts\mp\s4_elf_poi::add_elf_poi_position((720.622, 582.838, 1171.5), (0, 144.057, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1137.01, 2455.75, 1482.25), (0, 260.424, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1586.26, 416.131, 1480.51), (0, 146.185, 6), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1486.81, -488.932, 1340), (0, 261.582, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-2200.2, -488.82, 1267.75), (0, 148.212, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-915.158, 1281.35, 1184.25), (0, 248.061, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((102.75, 492, 1309), (0, 0, 0), "standing");
}

fixladderbelowworldbugs() {
  var_0 = spawn("trigger_radius", (-2584, 772, 928), 0, 256, 128);
  var_0 thread _id_8D46();
  var_1 = spawn("trigger_radius", (-2634, 300, 1036), 0, 96, 64);
  var_1 thread _id_8D46();
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

fixpostlaunchspawns() {
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "ctf":
      break;
    case "control":
      level._id_9FFA["-22 2108"]["mp_control_spawn_attacker"]["remove"] = 1;
      level._id_9FFA["64 2900"]["mp_control_spawn_attacker"]["remove"] = 1;
      level._id_9FFA["-198 3296"]["mp_control_spawn_attacker"]["remove"] = 1;
      level._id_9FFA["74 3470"]["mp_control_spawn_attacker"]["remove"] = 1;
      level._id_9FFA["-58 3662"]["mp_control_spawn_attacker"]["remove"] = 1;
      level._id_9FFA["128 3758"]["mp_control_spawn_attacker"]["remove"] = 1;
      level._id_9FFA["72 3472"]["mp_control_spawn_attacker"]["remove"] = 1;
      level._id_9FFA["-308 3598"]["mp_control_spawn_attacker"]["remove"] = 1;
      level._id_9FFA["-302 2807"]["mp_control_spawn_attacker"]["remove"] = 1;
      level._id_9FFA["-24 2110"]["mp_control_spawn_attacker"]["remove"] = 1;
      break;
    case "sd":
      break;
    case "dm":
    case "gun":
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (-1675.5, 2340.5, 1261.01), (0, 265, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (-1952.5, 1745.5, 1347.33), (0, 29, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (-2160.5, 1145.5, 1107.56), (0, 349, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (-1348, -2372, 1226.78), (0, 59, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dm_spawn", (-2678, 206, 1134.38), (0, 349, 0));
      break;
    case "dom":
      break;
    case "war":
    case "conf":
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (-2190, 606, 1122), (0, 351, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (-106, 524, 1312), (0, 275, 0));
      break;
    case "patrol":
    case "koth":
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1318, -2366, 1224.93), (0, 48, 0), undefined, "1");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-240, 3530, 1198.05), (0, 270, 0), undefined, "2");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-916, 2400, 1352.51), (0, 266, 0), undefined, "3");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (58, -390, 1205.52), (0, 211, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1784, 1862, 1336.05), (0, 232, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1220, 1916, 1276.15), (0, 270, 0), undefined, "5");
      var_0[var_0.size] = _id_0817::_id_4046("mp_koth_spawn", (-1188, 2244, 1345.68), (0, 211, 0), undefined, "5");
      break;
    default:
      break;
  }

  _id_0817::_id_1127(var_0);
}

_id_98D7() {
  _func_01B4(&"MP/ELEVATOR_USE");
  _func_01B4(&"MP_GAVUTU2/MOVE_PLATFORM");
  _func_01B4(&"MP_GAVUTU2/PLATFORM_IN_USE");
  var_0 = getent("platform_ent_01", "targetname");
  level.lst_platform = var_0;
  var_0.triggerplatformhurt = getent("trigger_platform", "targetname");
  var_0.triggerplatformhurt._id_AD49 = 1;
  var_0.platform_bottom = getent("platform_bottom", "targetname");
  var_0.platform_bottom._id_A1C0 = 1;
  var_1 = getEntArray("elevator_button", "targetname");
  var_0._id_2DCF = var_1;
  var_0._id_AED6 = getent("boat_path_blocker", "targetname");
  var_2 = _func_00B4((-1866.25, 406.25, 1133.88), 90, 1, 96);

  foreach(var_4 in var_2) {
    var_4 _meth_80B4();
  }

  var_6 = getEntArray("boat_platform", "targetname");

  foreach(var_8 in var_6) {
    if(isDefined(var_8.model) && var_8.model == "s4_usa_landing_ship_elevator_platform_01") {
      wait 0.1;
      var_8 dontinterpolate();
      var_8.origin = (-1979.03, 424.348, 1115.64);
      wait 0.1;
      break;
    }
  }

  var_0._id_AED6.origin = var_0._id_AED6.origin + (0, 0, -2000);

  foreach(var_8 in var_6) {
    var_8 linkto(var_0);
    var_8._id_F9A8 = 1;
    var_8._id_A1C0 = 1;
  }

  var_12 = getEntArray("tank_01", "targetname");

  foreach(var_8 in var_12) {
    var_8 linkto(var_0);
    var_8._id_F9A8 = 1;
    var_8._id_A1C0 = 1;
  }

  var_0._id_B1DD = 150;
  var_0._id_B1DE = 5;
  var_0.flag_angles = (358, 351, -3.5);
  var_0.flag_offset3d = (-2, 7, 100);
  var_0._id_E9C4 = var_0.origin;
  var_0.move_up_pos = var_0.origin + var_0._id_B1DD * anglestoup(var_0.angles);
  var_0._id_E747 = 0;
  var_0._id_A280 = 0;

  if(!isDefined(level.dynamicmapelementsdisabled) || !level.dynamicmapelementsdisabled) {
    foreach(var_16 in var_1) {
      var_16._id_FEE7 = int(50.0);
      var_16 sethintstring(&"MP_GAVUTU2/MOVE_PLATFORM");
      var_16 thread _id_F62F(var_0);
    }

    if(getDvar("#x3a30c33efc8281eb1") == "dom") {
      thread attachdombtoplatform(var_0);
    }
  }
}

attachdombtoplatform(var_0) {
  for(;;) {
    wait 1;

    if(isDefined(level._id_A8E8)) {
      level._id_A8E8["_b"]._id_A8E5 = 1;
      level._id_A8E8["_b"]._id_A97E = var_0.flag_offset3d;

      if(isDefined(level._id_A8E8["_b"]._id_03A9)) {
        level._id_A8E8["_b"]._id_03A9 linkto(var_0);
      }

      if(isDefined(level._id_A8E8["_b"]._id_10430)) {
        foreach(var_2 in level._id_A8E8["_b"]._id_10430) {
          if(isDefined(level._id_A8E8["_b"]._id_03A9)) {
            var_2.origin = level._id_A8E8["_b"]._id_03A9.origin + 100 * anglesToForward(level._id_A8E8["_b"]._id_03A9.angles);
            thread setdombhudheight();
          }

          var_2 linkto(var_0);
        }
      }

      if(isDefined(level._id_A8E8["_b"].trigger)) {
        var_0.domtrigger = level._id_A8E8["_b"].trigger;
      }

      return;
    }
  }
}

setdombhudheight() {
  for(;;) {
    if(isDefined(level._id_A8E8["_b"]._id_A908) && isDefined(level._id_A8E8["_b"]._id_10430[0])) {
      _id_07F9::_id_FB93(level._id_A8E8["_b"]._id_A908, level._id_A8E8["_b"]._id_10430[0]);
      return;
    }

    wait 0.25;
  }
}

_id_F62F(var_0) {
  for(;;) {
    self waittill("trigger", var_1);
    var_0.user = var_1;
    thread snd_platform_start(var_1);

    if(var_0._id_A280 == 0) {
      _id_F63A(var_0._id_2DCF, &"MP_GAVUTU2/PLATFORM_IN_USE");
      var_0._id_A280 = 1;
      wait 0.5;

      if(isDefined(var_0.domtrigger)) {
        thread updatedomtrigger(var_0);
      }

      thread updatehurttrigger(var_0);

      if(var_0._id_E747 == 0) {
        var_0 moveto(var_0.move_up_pos, var_0._id_B1DE, 0.5, 0.5);
        var_0 _meth_827E("interact_platform_move");
        var_0 waittill("movedone");
        wait 1;
        var_0._id_E747 = 1;
        var_0._id_A280 = 0;
      } else {
        var_0 moveto(var_0._id_E9C4, var_0._id_B1DE, 0.5, 0.5);
        var_0 _meth_827E("interact_platform_move");
        var_0 waittill("movedone");
        wait 1;
        var_0._id_E747 = 0;
        var_0._id_A280 = 0;
      }

      _id_F63A(var_0._id_2DCF, &"MP_GAVUTU2/MOVE_PLATFORM");
    }
  }
}

updatehurttrigger(var_0) {
  var_0.triggerplatformhurt thread checkforfieldupgrades(var_0);
  var_0.triggerplatformhurt thread checkforgoliathsdogs(var_0);

  while(var_0._id_A280 == 1) {
    var_0.triggerplatformhurt.origin = var_0.origin;
    wait 0.05;
  }
}

checkforfieldupgrades(var_0) {
  var_0 endon("movedone");
  var_1 = undefined;

  if(isDefined(var_0.user) && isPlayer(var_0.user)) {
    var_1 = var_0.user;
  }

  while(var_0._id_A280 == 1) {
    if(var_0._id_E747 == 1) {
      var_2 = getallfieldupgrades();
      var_3 = self _meth_813D(var_2);

      foreach(var_5 in var_3) {
        if(isDefined(var_5) && !_func_0458(var_5) && !isPlayer(var_5)) {
          if(isDefined(var_5.owner) && var_5.owner == var_1 || isDefined(var_5.team) && var_5.team != var_1.team) {
            var_5 dodamage(10000, self.origin, var_1, self, "MOD_CRUSH");
            continue;
          }

          if(isDefined(var_5.owner) && isPlayer(var_5.owner)) {
            var_5 dodamage(10000, self.origin, var_5.owner, self, "MOD_CRUSH");
            continue;
          }

          var_5 dodamage(10000, self.origin, self, self, "MOD_CRUSH");
        }
      }
    }

    wait 0.05;
  }
}

getallfieldupgrades() {
  var_0 = [];

  foreach(var_2 in level._id_5A20) {
    foreach(var_4 in var_2) {
      var_0[var_0.size] = var_4;
    }
  }

  foreach(var_8 in level._id_8B78) {
    foreach(var_10 in var_8) {
      var_0[var_0.size] = var_10;
    }
  }

  foreach(var_14 in level._id_1491) {
    var_0[var_0.size] = var_14;
  }

  foreach(var_17 in level._id_ED0C) {
    var_0[var_0.size] = var_17;
  }

  foreach(var_20 in level._id_9EE2) {
    var_0[var_0.size] = var_20;
  }

  foreach(var_23 in level._id_4541) {
    var_0[var_0.size] = var_23;
  }

  return var_0;
}

checkforgoliathsdogs(var_0) {
  var_0 endon("movedone");
  var_1 = undefined;

  if(isDefined(var_0.user) && isPlayer(var_0.user)) {
    var_1 = var_0.user;
  }

  while(var_0._id_A280 == 1) {
    self waittill("trigger", var_2);

    if(var_0._id_E747 == 1 && isDefined(var_2) && !_func_0458(var_2) && !isPlayer(var_2)) {
      if(isDefined(var_1) && isDefined(var_1.team) && isDefined(var_2.team) && var_1.team == var_2.team) {
        var_2 dodamage(10000, self.origin, undefined, self, "MOD_CRUSH");
      } else {
        var_2 dodamage(10000, self.origin, var_1, self, "MOD_CRUSH");
      }

      wait 0.05;
    }
  }
}

updatedomtrigger(var_0) {
  var_0 endon("movedone");

  while(var_0._id_A280 == 1) {
    var_0.domtrigger.origin = level._id_A8E8["_b"]._id_03A9.origin;

    if(isDefined(level._id_A8E8["_b"]._id_A908) && isDefined(level._id_A8E8["_b"]._id_10430[0])) {
      _id_07F9::_id_FB93(level._id_A8E8["_b"]._id_A908, level._id_A8E8["_b"]._id_10430[0]);
    }

    wait 0.05;
  }
}

snd_platform_start(var_0) {
  playsoundatpos(var_0.origin, "interact_platform_button_start");
}

_id_F63A(var_0, var_1) {
  foreach(var_3 in var_0) {
    var_3 sethintstring(var_1);
  }
}