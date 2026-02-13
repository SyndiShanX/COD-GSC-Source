/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2532.gsc
*************************************************/

vehicle_spawn_getleveldataforvehicle(var_0, var_1) {
  var_2 = _id_10275();
  var_3 = var_2._id_4356[var_0];

  if(!isDefined(var_3) && istrue(var_1)) {
    var_3 = spawnStruct();
    var_2._id_4356[var_0] = var_3;
    var_3._id_C189 = var_0;
    var_3._id_9C7B = 0;
    var_3._id_BD27 = 50;
    var_3._id_6D5D = undefined;
    var_3._id_E274 = undefined;
    var_3._id_31DD = undefined;
    var_3._id_3923 = undefined;
    var_3._id_391F = undefined;
    var_3._id_3922 = undefined;
    var_3._id_3921 = undefined;
    var_3._id_F233 = undefined;
    var_3._id_C69E = undefined;
    var_3._id_F234 = undefined;
  }

  return var_3;
}

_id_10269(var_0, var_1, var_2) {
  var_3 = _id_10275();

  if(_id_10273() < var_3._id_9C7B) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_spawn", "canSpawnVehicle")]](var_0)) {
      if(isDefined(var_0)) {
        if(!scripts\cp_mp\vehicles\vehicle_tracking::_id_102C1(var_0) || !scripts\cp_mp\vehicles\vehicle_tracking::_id_102B9(var_0, var_1, var_2)) {
          var_4 = vehicle_spawn_getleveldataforvehicle(var_0);

          if(isDefined(var_4)) {
            if(istrue(level._id_7D38) || !isDefined(var_4._id_9C7B) || _id_10274(var_0) < var_4._id_9C7B) {
              if(isDefined(var_4._id_31DD)) {
                return [[var_4._id_31DD]](var_1, var_2);
              } else {
                return 1;
              }
            }
          }
        }
      }
    }
  }

  return 0;
}

vehicle_spawn_spawnvehicle(var_0, var_1, var_2) {
  var_3 = vehicle_spawn_getleveldataforvehicle(var_0);

  if(_id_1027C()) {
    var_4 = scripts\cp_mp\utility\game_utility::_id_6B2D();
    var_5 = scripts\cp_mp\vehicles\vehicle_tracking::_id_102BC(var_0);

    if(var_5.size > 0) {
      return;
    }
    if(var_0 == "tac_rover") {
      if(var_4 == "mp_downtown_gw") {
        var_1.origin = (44455, -12715, 108);
        var_1.angles = (360, 315, 0);
      } else if(var_4 == "mp_farms2_gw") {
        var_1.origin = (45735, -12397, 121);
        var_1.angles = (0, 358, 0);
      } else if(var_4 == "mp_quarry2") {
        var_1.origin = (29480, 33349, 589);
        var_1.angles = (0, 202, 0);
      }
    } else if(var_0 == "large_transport") {
      if(var_4 == "mp_downtown_gw") {
        var_1.origin = (20845, -12233, -57);
        var_1.angles = (7, 81, 0);
      } else if(var_4 == "mp_farms2_gw")
        return;
      else if(var_4 == "mp_quarry2") {
        return;
      }
    } else if(var_0 == "apc_russian") {
      if(var_4 == "mp_downtown_gw") {
        var_1.origin = (20845, -12233, -57);
        var_1.angles = (7, 81, 0);
      } else if(var_4 == "mp_farms2_gw") {
        var_1.origin = (44559, -12331, 87);
        var_1.angles = (0, 11, 0);
      } else if(var_4 == "mp_quarry2") {
        var_1.origin = (29135, 33754, 605);
        var_1.angles = (0, 7, 0);
      }
    } else if(var_0 == "atv") {
      if(var_4 == "mp_downtown_gw") {
        var_1.origin = (22421, -13456, -48);
        var_1.angles = (13, 36, 0);
      } else if(var_4 == "mp_farms2_gw") {
        var_1.origin = (45202, -11294, 149);
        var_1.angles = (0, 283, 0);
      } else if(var_4 == "mp_quarry2") {
        var_1.origin = (29250, 35115, 616);
        var_1.angles = (0, 321, 0);
      }
    } else if(var_0 == "technical") {
      if(var_4 == "mp_downtown_gw") {
        var_1.origin = (22742, -12693, -56);
        var_1.angles = (360, 315, 0);
      } else if(var_4 == "mp_farms2_gw")
        return;
      else if(var_4 == "mp_quarry2") {
        return;
      }
    } else if(var_0 == "light_tank") {
      if(var_4 == "mp_downtown_gw") {
        var_1.origin = (22787, -13503, -56);
        var_1.angles = (3, 269, 0);
      } else if(var_4 == "mp_farms2_gw") {
        var_1.origin = (45259, -12740, 63);
        var_1.angles = (0, 274, 0);
      } else if(var_4 == "mp_quarry2") {
        var_1.origin = (32524, 34558, 599);
        var_1.angles = (0, 107, 0);
      }
    } else if(var_0 == "little_bird") {
      if(var_4 == "mp_downtown_gw") {
        var_1.origin = (21108, -12603, 100);
        var_1.angles = (6, 353, 0);
      } else if(var_4 == "mp_farms2_gw") {
        var_1.origin = (46478, -12482, 400);
        var_1.angles = (0, 84, 0);
      } else if(var_4 == "mp_quarry2") {
        var_1.origin = (28735, 34000, 767);
        var_1.angles = (0, 80, 0);
      }
    } else if(var_0 == "cargo_truck") {
      if(var_4 == "mp_downtown_gw") {
        var_1.origin = (23503, -12799, -56);
        var_1.angles = (6, 359, 0);
      } else if(var_4 == "mp_farms2_gw") {
        var_1.origin = (45644, -11370, 160);
        var_1.angles = (0, 80, 0);
      } else if(var_4 == "mp_quarry2") {
        var_1.origin = (29280, 35546, 626);
        var_1.angles = (0, 148, 0);
      }
    } else if(var_0 == "jeep") {
      if(var_4 == "mp_downtown_gw") {
        var_1.origin = (22781, -14070, -56);
        var_1.angles = (5, 86, 0);
      } else if(var_4 == "mp_farms2_gw") {
        var_1.origin = (46119, -11995, 168);
        var_1.angles = (0, 4, 0);
      } else if(var_4 == "mp_quarry2") {
        var_1.origin = (30351, 34420, 593);
        var_1.angles = (0, 31, 0);
      }
    } else
      return;
  }

  var_6 = [[var_3._id_E274]](var_1, var_2);

  if(isDefined(var_6)) {
    _id_10289(var_6);
  }

  return var_6;
}

_id_1026F(var_0, var_1) {
  var_2 = _id_10275();

  if(isDefined(var_2._id_8301[var_0])) {
    var_2._id_8301[var_0][var_1] = undefined;
  }
}

_id_1028A(var_0, var_1) {
  if(getdvarint("#x3db08ae519ae0552b", 0) == 1) {
    return var_0;
  }

  var_2 = 1 >> var_1 - 1;
  var_3 = [];

  foreach(var_5 in var_0) {
    if(isDefined(var_5._id_03EA) && var_5._id_03EA &var_2) {
      continue;
    }
    var_3[var_3.size] = var_5;
  }

  return var_3;
}

_id_10272() {
  return [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_spawn", "gameModeSupportsRespawn")]]();
}

_id_10277() {
  var_0 = spawnStruct();
  level.vehicle._id_E09E = var_0;
  var_0._id_9C7B = 128;
  var_0._id_4356 = [];
  var_0._id_8301 = [];
  var_0._id_E2EE = 5;
  var_0._id_C69F = getdvarint("#x3d7d4e2488a9bf900", 0);
  var_0._id_0E03 = getdvarint("#x398f346c729436128", 0);
  var_0._id_C69E = getdvarint("#x36e9d605f54103ab0", 60);
  var_0._id_0E02 = getdvarint("#x34d4e3c1a2a8279b8", 30);
  _id_1027A();
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_spawn", "init")]]();
  _id_10279();
}

_id_10279() {
  thread _id_1028C();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_spawn", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_spawn", "initLate")]]();
  }
}

_id_1028C() {
  if(istrue(level._id_9FC8)) {
    return;
  }
  var_0 = _id_10275();

  if(_func_0121(var_0._id_E2EE)) {
    level waittill(var_0._id_E2EE);
  } else {
    wait(var_0._id_E2EE);
  }

  var_1 = [];

  foreach(var_3 in var_0._id_4356) {
    if(isDefined(var_3._id_6D5D)) {
      var_3._id_BD27 = clamp(var_3._id_BD27, 0, 100);
      var_1[var_1.size] = var_3;
    }
  }

  if(var_1.size > 0) {
    if(var_1.size > 1) {
      var_1 = scripts\engine\utility::_id_1BD6(var_1, ::_id_1028D);
    }

    var_5 = isDefined(scripts\cp_mp\utility\game_utility::_id_6B18());

    if(_id_1027C()) {
      var_5 = 0;
    }

    foreach(var_3 in var_1) {
      var_7 = [[var_3._id_6D5D]]();

      foreach(var_9 in var_7) {
        if(var_5) {
          if(!isDefined(var_9._id_039B) || isDefined(var_9._id_039B) && var_9._id_039B != level._id_96CC) {
            continue;
          }
        }

        if(_id_10269(var_3._id_C189)) {
          var_10 = spawnStruct();
          var_10.origin = var_9.origin;
          var_10.angles = var_9.angles;
          var_10.spawntype = "LEVEL";
          var_11 = spawnStruct();
          var_12 = vehicle_spawn_spawnvehicle(var_3._id_C189, var_10, var_11);

          if(!isDefined(var_12)) {}

          continue;
        }

        break;
      }
    }
  }
}

_id_1028D(var_0, var_1) {
  return var_0._id_BD27 >= var_1._id_BD27;
}

_id_10289(var_0) {
  var_1 = _id_10275();

  if(!isDefined(var_1._id_8301[var_0._id_1031E])) {
    var_1._id_8301[var_0._id_1031E] = [];
  }

  var_1._id_8301[var_0._id_1031E][var_0 getentitynumber()] = var_0;
}

_id_10275() {
  return level.vehicle._id_E09E;
}

_id_10273() {
  var_0 = _id_10275();
  var_1 = 0;

  foreach(var_3 in var_0._id_8301) {
    var_1 = var_1 + var_3.size;
  }

  return var_1;
}

_id_10274(var_0) {
  var_1 = _id_10275();
  var_2 = 0;

  if(isDefined(var_1._id_8301[var_0])) {
    var_2 = var_1._id_8301[var_0].size;
  }

  return var_2;
}

_id_1027E() {
  var_0 = self._id_0481;

  if(isDefined(var_0)) {
    switch (var_0) {
      case "lighttank_spawn":
      case "largetransport_spawn":
      case "hoopty_spawn":
      case "copcar_spawn":
      case "jeep_spawn":
      case "hooptytruck_spawn":
      case "apcrussian_spawn":
      case "cargotruck_spawn":
      case "atv_spawn":
      case "van_spawn":
      case "technical_spawn":
      case "tacrover_spawn":
      case "pickuptruck_spawn":
      case "mediumtransport_spawn":
      case "littlebird_spawn":
        return 1;
      default:
        return 0;
    }
  }

  return 0;
}

_id_1027A() {
  var_0 = _id_10275();
  var_0._id_3920 = [];
}

_id_1026A(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_10275();
  var_6 = 200;
  var_7 = 200;
  var_8 = vehicle_spawn_getleveldataforvehicle(var_1);
  var_9 = var_8._id_3921;

  if(!isDefined(var_9)) {
    var_9 = var_5._id_3920[var_1];
  }

  if(isDefined(var_8._id_3923)) {
    var_6 = var_8._id_3923;
  }

  if(isDefined(var_8._id_391F)) {
    var_7 = var_8._id_391F;
  }

  if(isDefined(var_4)) {
    var_0 = var_0 + (0, 0, var_4);
  }

  var_10 = (var_6, var_6, var_7);
  var_11 = var_0 - var_10;
  var_12 = var_0 + var_10;
  var_13 = var_2;

  if(!isDefined(var_13)) {
    var_13 = physics_createcontents(["physicscontents_vehicle"]);
  }

  var_14 = var_3;

  if(!isDefined(var_14)) {
    var_14 = [];
    var_14[var_14.size] = ::scripts\cp_mp\vehicles\vehicle_tracking::_id_102BC("emp_drone");
    var_14[var_14.size] = ::scripts\cp_mp\vehicles\vehicle_tracking::_id_102BC("cruise_predator");

    if(isDefined(level._id_EB9A)) {
      var_14[var_14.size] = level._id_EB9A;
    }

    var_14 = scripts\engine\utility::_id_1B9B(var_14);
  }

  var_15 = _func_02BF(var_11, var_12, var_13, var_14);

  if(isDefined(var_15) && var_15.size > 0) {
    foreach(var_17 in var_15) {
      if(isDefined(var_17._id_1031E)) {
        var_18 = vehicle_spawn_getleveldataforvehicle(var_17._id_1031E);
        var_19 = undefined;

        if(isDefined(var_18)) {
          var_19 = var_18._id_3921;
        }

        if(!isDefined(var_19)) {
          var_19 = var_5._id_3920[var_17._id_1031E];
        }

        if(!isDefined(var_19)) {
          continue;
        }
        var_20 = _func_01A6(var_9 + var_19, 2);

        if(isDefined(var_20) && var_20 < distance2dsquared(var_17.origin, var_0)) {
          continue;
        }
        return 0;
      }
    }
  }

  return 1;
}

_id_1028B(var_0, var_1) {
  var_2 = _id_10275();
  var_3 = vehicle_spawn_getleveldataforvehicle(var_0);

  if(isDefined(var_3)) {
    var_3._id_3921 = var_1;
    return;
  }

  var_2._id_3920[var_0] = var_1;
}

_id_10290(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("cancel_pending_vehicle_respawns");
  var_3 = vehicle_spawn_getleveldataforvehicle(var_0);

  if(!isDefined(var_3)) {
    return;
  }
  if(!isDefined(var_3._id_E274)) {
    return;
  }
  var_4 = _id_10275();
  var_5 = undefined;

  if(var_4._id_C69F != 0) {
    var_5 = var_4._id_C69F;
  } else if(isDefined(var_3._id_C69E)) {
    var_5 = var_3._id_C69E;
  } else {
    var_5 = var_4._id_C69E;
  }

  if(var_5 >= 1) {
    if(var_5 >= 9999) {
      return undefined;
    }
  } else
    var_5 = 1;

  for(;;) {
    wait(var_5);

    if(_id_10269(var_0)) {
      if(_id_1026A(var_1.origin, var_0)) {
        var_6 = vehicle_spawn_spawnvehicle(var_0, var_1, var_2);

        if(!isDefined(var_6)) {
          continue;
        }
        return var_6;
      }
    }
  }
}

_id_10288(var_0) {
  var_0._id_AAA9 = undefined;
}

_id_10268() {
  level notify("cancel_pending_vehicle_respawns");
}

_id_10271() {
  return [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_spawn", "gameModeSupportsAbandonedTimeout")]]();
}

_id_10291() {
  if(istrue(self._id_87FB)) {
    return;
  }
  if(istrue(self._id_4D76)) {
    return;
  }
  var_0 = vehicle_spawn_getleveldataforvehicle(self._id_1031E);

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0._id_0E01)) {
    return;
  }
  self endon("death");
  self endon("stop_watching_abandoned");
  var_1 = _id_10275();
  var_2 = undefined;

  if(var_1._id_0E03 != 0) {
    var_2 = var_1._id_0E03;
  } else if(isDefined(var_0._id_0E02)) {
    var_2 = var_0._id_0E02;
  } else {
    var_2 = var_1._id_0E02;
  }

  if(var_2 >= 1) {
    if(var_2 >= 9999) {
      return;
    }
  } else
    var_2 = 1;

  wait(var_2);
  thread _id_10266();
}

_id_1028F() {
  self notify("stop_watching_abandoned");
}

_id_10266() {
  _id_1028F();
  self._id_4D76 = 1;
  var_0 = vehicle_spawn_getleveldataforvehicle(self._id_1031E);
  self thread[[var_0._id_0E01]]();
}

_id_10267() {
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::_id_10046();

  if(var_0 != "heavy") {
    var_1 = scripts\cp_mp\vehicles\vehicle_damage::_id_1003D(self);

    if(isDefined(var_1)) {
      self.health = int(min(var_1, self.health));
      _id_09CA::_id_10392(self);
    }

    scripts\cp_mp\vehicles\vehicle_damage::_id_10072("heavy", var_0);
  }
}

_id_1027C() {
  var_0 = level._id_3A25;

  if(!isDefined(var_0)) {
    var_0 = getdvarint("#x31344961ad79decb0", 0) == 1;

    if(var_0 && _id_1027D()) {
      var_0 = 1;
    } else {
      var_0 = 0;
    }

    level._id_3A25 = var_0;
  }

  return var_0;
}

_id_1027D() {
  var_0 = scripts\cp_mp\utility\game_utility::_id_6B2D();

  switch (var_0) {
    case "mp_quarry2":
    case "mp_downtown_gw":
    case "mp_farms2_gw":
      return 1;
    default:
      return 0;
  }
}

_id_10278() {}