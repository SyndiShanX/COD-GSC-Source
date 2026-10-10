/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_3ecbe29e8a099d07.gsc
*************************************************/

#using script_419b3e6ec78424cb;
#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace namespace_f0deed88c8a69860;

function setup_map_specific_devgui() {
  function_cab08c75e0639ea0();
  thread function_fe7190fff126ce();
}

function function_d8fb18a58a875db6(player) {
  playername = player.name;
  playernum = undefined;

  for(i = 0; i < level.players.size; i++) {
    if(level.players[i] == player) {
      player thread function_cab08c75e0639ea0(player, playername, i);
      break;
    }
  }
}

function function_cab08c75e0639ea0(player, name, num) {
  cmd = "<dev string:x1c>";
  addentrytodevgui(cmd);
  cmd = "<dev string:x61>";
  addentrytodevgui(cmd);
  cmd = "<dev string:xaf>";
  addentrytodevgui(cmd);
}

function function_fe7190fff126ce() {
  while(true) {
    cmdline = getDvar(@ "hash_3410fc59996bd12c", "<dev string:x100>");

    if(cmdline != "<dev string:x100>") {
      args = strtok(cmdline, "<dev string:x101>");

      switch (args[0]) {
        case #"hash_289aea6c1f0ef491":
          if(args.size > 1 && args[1] == "<dev string:x107>") {
            level.player scripts\cp\utility::showminimap();
            break;
          }

          level.player scripts\cp\utility::hideminimap(1);
          break;
        case #"hash_fa18b9f6bd576aff":
          idx = 0;

          if(args.size > 1) {
            idx = int(args[1]);
            setDvar(@ "ai_debugentindex", idx);
          }

          setDvar(@ "hash_2ecb315411595807", 1);
          setDvar(@ "ai_showpaths", 1);
          setDvar(@ "hash_88d8ab419125d09", 0);
          break;
        case #"hash_bd2b14a6c78f31a8":
          thread function_303aaef49bfc3f73(args);
          break;
        case #"hash_7c31479cf04292f":
          thread function_c857f9a4ec4b18ea();
          break;
        case #"hash_d40a63f1689e8aa3":
          thread function_3e6f9d87c692ab36(args);
          break;
        case #"hash_3825a35ac39f7f6e":
          function_dd39f97faf3d4769(args);
          break;
        case #"hash_3d2f51a412dd32f7":
          function_7b26e08d11e4921e(args);
          break;
        case #"hash_7c2d091e6337bf54":
          function_9e9974a1c4b2dac5(args);
          break;
      }

      setDvar(@ "hash_3410fc59996bd12c", "<dev string:x100>");
    }

    wait 0.1;
  }
}

function function_7b26e08d11e4921e(args) {
  if(args.size > 4) {
    color = (0, 0, 0);
    size = 1;
    duration = 999999;
    text = args[1];
    pos = (float(args[2]), float(args[3]), float(args[4]));

    if(args.size > 5) {
      size = float(args[5]);

      if(args.size > 6) {
        duration = float(args[6]);

        if(args.size > 9) {
          color = (float(args[7]), float(args[8]), float(args[9]));
        }
      }
    }

    debugstar(pos, color, duration, text, size, size);
  }
}

function function_9e9974a1c4b2dac5(args) {
  if(args.size > 3) {
    facing = (0, 0, 0);
    size = 10;
    duration = 999999;
    test = 1;
    pos = (float(args[1]), float(args[2]), float(args[3]));
    facing = (0, 0, 0);

    if(args.size > 6) {
      facing = (float(args[4]), float(args[5]), float(args[6]));

      if(args.size > 7) {
        size = float(args[7]);

        if(args.size > 8) {
          duration = float(args[8]);

          if(args.size > 8) {
            test = 0;
          }
        }
      }
    }

    debugaxis(pos, facing, size, 1, test, duration);
  }
}

function function_dd39f97faf3d4769(args) {
  if(args.size == 10) {
    level.var_6866db93450a8730 = [];

    for(i = 1; i < 10; i++) {
      level.var_6866db93450a8730[i - 1] = float(args[i]);
    }

    iprintln("<dev string:x13d>");
  }
}

function function_3e6f9d87c692ab36(args) {
  truck = getEnt("<dev string:x150>", "<dev string:x15f>");

  if(isDefined(truck)) {
    if(!isDefined(level.var_50a0684b0a1482da)) {
      level.var_50a0684b0a1482da = truck.origin;
      level.var_9a2f342170c7e6bb = truck.angles;
    }

    truck.origin = level.var_50a0684b0a1482da;
    truck.angles = level.var_9a2f342170c7e6bb;
    truck function_9a3c79d82c551ad3();
    turn_rate = 0.5;
    var_86c320d267e05dbf = 300;
    accel_time = 4;
    route = "<dev string:x16a>";

    if(args.size > 1) {
      var_86c320d267e05dbf = float(args[1]);

      if(args.size > 2) {
        accel_time = float(args[2]);
      }

      if(isDefined(truck.route)) {
        truck function_433477a58b907e72(var_86c320d267e05dbf, turn_rate, accel_time);
      }
    }

    if(!isDefined(truck.route)) {
      truck function_f9031efeb0ff63ee(route, var_86c320d267e05dbf, turn_rate, accel_time);
    }

    truck thread function_c075187fa91e017e();
    truck thread function_bd7c27015139353d();
    truck waittill("<dev string:x178>");

    iprintln("<dev string:x184>");
  }
}

function function_c857f9a4ec4b18ea() {
  truck = getEnt("<dev string:x150>", "<dev string:x15f>");
  container = getEnt("<dev string:x197>", "<dev string:x15f>");
  var_903344103f8edf9d = getEnt("<dev string:x1ad>", "<dev string:x15f>");

  if(!isDefined(truck) || !isDefined(container)) {
    iprintln("<dev string:x1c2>");

    return;
  }

  spot = truck.origin;
  facing = truck.angles;
  var_fd2645e4cbcaa406 = container.origin;
  var_385d2c3804c73488 = container.angles;
  var_fcdb07958cada8f6 = var_903344103f8edf9d.origin;
  flag_clear("<dev string:x1db>");
  function_c1cadb469d19553c();
  utility::flag_wait("<dev string:x1db>");

  iprintln("<dev string:x1f7>");

  container unlink();
  truck.origin = spot;
  truck.angles = facing;
  container.origin = var_fd2645e4cbcaa406;
  container.angles = var_385d2c3804c73488;
  var_903344103f8edf9d.origin = var_fcdb07958cada8f6;
}

function function_303aaef49bfc3f73(args) {
  var_eae0fadb0abd54d2 = "<dev string:x150>";
  truck = getEnt("<dev string:x203>", "<dev string:x15f>");

  if(isDefined(truck)) {
    if(!isDefined(level.var_704e02c05b3853d3)) {
      level.var_704e02c05b3853d3 = truck.origin + (0, 0, 160);
      level.var_ff3e078c44ab604c = truck.angles;
    }

    truck.origin = level.var_704e02c05b3853d3;
    truck.angles = level.var_ff3e078c44ab604c;
    var_1916952f44cb8dae = rotatevector((-180, 0, 100), truck.angles);
    container = spawn("<dev string:x212>", truck.origin + var_1916952f44cb8dae);
    container.angles = angleclamp180(truck.angles + (0, 90, 0));
    container setModel("<dev string:x21f>");
    container linkTo(truck);

    if(isDefined(level.var_66fa80df747c0495)) {
      sphere(truck.origin + (0, 0, 50), 50, undefined, 0, 999999);
      debugaxis(truck.origin, truck.angles, 60, 1, 0, 999999);
    }

    turn_rate = 0.5;
    var_86c320d267e05dbf = 300;
    accel_time = 4;
    route = "<dev string:x24b>";

    if(args.size > 1) {
      route = args[1];

      if(args.size > 2) {
        var_86c320d267e05dbf = float(args[2]);

        if(args.size > 3) {
          accel_time = float(args[3]);
        }

        if(isDefined(truck.route)) {
          truck function_433477a58b907e72(var_86c320d267e05dbf, turn_rate, accel_time);
        }
      }
    }

    if(!isDefined(truck.route)) {
      truck function_f9031efeb0ff63ee(route, var_86c320d267e05dbf, turn_rate, accel_time);
    }

    truck thread function_c075187fa91e017e();
    truck thread function_bd7c27015139353d();
    truck waittill("<dev string:x178>");

    iprintln("<dev string:x184>");
  }
}

function function_433477a58b907e72(var_86c320d267e05dbf, turn_rate, accel_time) {
  truck = self;

  if(isDefined(truck.route)) {
    var_f46ed9fd4394c1fa = isDefined(accel_time);
    var_862c223c63ea7699 = truck.origin;

    for(idx = 0; idx < truck.route.size; idx++) {
      loc = truck.route[idx];
      loc.duration = distance2d(loc.origin, var_862c223c63ea7699) / var_86c320d267e05dbf;

      if(loc.duration < 0.25) {
        continue;
      }

      var_3d9e474e17bdec4e = loc.origin - var_862c223c63ea7699;
      var_1584a380d2a73443 = vectorNormalize(var_3d9e474e17bdec4e);
      new_right = vectorcross(var_1584a380d2a73443, (0, 0, 1));
      new_up = vectorcross(new_right, var_1584a380d2a73443);
      loc.facing = axistoangles(var_1584a380d2a73443, new_right, (0, 0, 1));
      loc.var_3895e39af9db958d = min(loc.duration, turn_rate);

      if(var_f46ed9fd4394c1fa) {
        if(loc.duration > accel_time) {
          dist = accel_time * var_86c320d267e05dbf / 2;
          loc.var_a512b96448d21c80 = var_862c223c63ea7699 + var_1584a380d2a73443 * dist;
          loc.accel_time = accel_time;
          loc.duration -= dist / var_86c320d267e05dbf;
        } else {
          iprintln("<dev string:x259>");
          println("<dev string:x291>");
        }

        var_f46ed9fd4394c1fa = 0;
      }

      var_862c223c63ea7699 = loc.origin;

      if(isDefined(level.var_66fa80df747c0495)) {
        sphere(loc.origin + (0, 0, 50), 50, undefined, 0, 999999);
        debugaxis(loc.origin, loc.angles, 160, 1, 0, 999999);
      }
    }
  }
}

function function_bd7c27015139353d() {
  self endon("<dev string:x178>");
  truck = self;
  wait 0.3;
  var_2cc5dfd3b27fef31 = truck.origin;
  truck.var_29d57bc6fd2b7562 = 0;
  thread function_178dbfb397084710();

  while(true) {
    wait 0.1;
    truck.var_29d57bc6fd2b7562 = distance2d(truck.origin, var_2cc5dfd3b27fef31) * 10;
    var_2cc5dfd3b27fef31 = truck.origin;
  }
}

function function_178dbfb397084710() {
  self endon("<dev string:x178>");
  truck = self;

  while(true) {
    waitframe();

    printtoscreen2d(400, 400, "<dev string:x2ca>" + truck.var_29d57bc6fd2b7562 + "<dev string:x2d2>" + truck.origin, (1, 0.4, 1), 3, 1);
  }
}

function function_8c867b5137f48d9b() {
  level.var_c49fa55dcfd1d9f0.debug = spawnStruct();
  level.var_c49fa55dcfd1d9f0.debug.draw = 0;
  setdvarifuninitialized(@ "hash_3ce27c53425c5414", level.var_c49fa55dcfd1d9f0.debug.draw);
  thread function_e56714c62c9231();
}

function function_e56714c62c9231() {
  level endon("<dev string:x2d5>");

  while(true) {
    waitframe();
    level.var_c49fa55dcfd1d9f0.debug.draw = getdvarint(@ "hash_3ce27c53425c5414", 0);

    if(level.var_c49fa55dcfd1d9f0.debug.draw == 0) {
      continue;
    }

    ais = getaiarray("<dev string:x2e0>");

    foreach(ai in ais) {
      if(isDefined(ai.var_3aa342a8b045cbce)) {
        print3d(ai.origin, ai.var_3aa342a8b045cbce, (1, 1, 1), 1, 1, 1, 1);

        if(isDefined(ai.currentnode)) {
          orientedbox(ai.currentnode.origin, (16, 16, 16), ai.currentnode.angles, (1, 1, 1), 0, 1);
        }

        if(isDefined(ai.goalpos)) {
          debugaxis(ai.goalpos, (0, 0, 0));
        }
      }
    }

    foreach(crane in level.var_c49fa55dcfd1d9f0.cranes) {
      foreach(wheel in crane.wheels) {
        debugaxis(wheel.origin, wheel.angles, 20, 1, 0, 1);
      }

      if(isDefined(crane.rack.lights)) {
        foreach(light in crane.rack.lights) {
          orientedbox(light.origin, (10, 10, 10), light.angles, (1, 1, 1), 0, 1);
        }
      }

      if(isDefined(crane.var_ee8996934a480419)) {
        box(crane.var_ee8996934a480419.origin);
      }

      print3d(crane.base.origin, crane.debugname, (1, 0, 0), 1, 1, 1, 1);

      foreach(trigger in crane.var_f2ac11f347d3d17.var_ce71c0e533ffc9cd) {
        drawentitybounds(trigger, (1, 0, 0), 0, 1);

        if(isDefined(trigger.occluder) && isDefined(trigger.occluder.origin) && isDefined(trigger.occluder.extents) && isDefined(trigger.occluder.angles)) {
          orientedbox(trigger.occluder.origin, trigger.occluder.extents, trigger.occluder.angles, (0, 1, 0), 0, 1);
        }
      }

      foreach(trigger in crane.var_f2ac11f347d3d17.var_cf89a893c872a31d) {
        drawentitybounds(trigger, (1, 0, 0), 0, 1);
      }
    }
  }
}

# /