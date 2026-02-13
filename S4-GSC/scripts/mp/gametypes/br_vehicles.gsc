/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_vehicles.gsc
*************************************************/

_id_2C46() {
  level._id_9FC8 = 1;
  level._id_7D38 = 1;
  var_0 = getdvarint("#x346d5cfabd9345366", 24);
  level._id_2AC3 = 128 - var_0;
  level._id_2AC4 = 0;
  level._id_2A5B = getdvarint("#x33047ff3fcaeac680", 3);
  level._id_2ACB = [];
  level._id_2ACB["atv_spawn"] = "atv";
  level._id_2ACB["cargotruck_spawn"] = "cargo_truck";
  level._id_2ACB["copcar_spawn"] = "cop_car";
  level._id_2ACB["hoopty_spawn"] = "hoopty";
  level._id_2ACB["hooptytruck_spawn"] = "hoopty_truck";
  level._id_2ACB["jeep_spawn"] = "jeep";
  level._id_2ACB["largetransport_spawn"] = "large_transport";
  level._id_2ACB["littlebird_spawn"] = "little_bird";
  level._id_2ACB["mediumtransport_spawn"] = "medium_transport";
  level._id_2ACB["pickuptruck_spawn"] = "pickup_truck";
  level._id_2ACB["tacrover_spawn"] = "tac_rover";
  level._id_2ACB["technical_spawn"] = "technical";
  level._id_2ACB["van_spawn"] = "van";
  level._effect["vehicle_flares"] = loadfx("vfx/iw8_mp/killstreak/vfx_apache_angel_flares.vfx");
}

_id_2C47() {
  _id_D8BE();
  _id_2C49();
}

_id_D8BE() {
  var_0 = "vehicle_volume";

  if(getdvarint("#x397eadb4d35c9a0ee", 1)) {
    var_0 = "vehicle_volume_simplified";
  }

  level._id_2C4A = getEntArray(var_0, "script_noteworthy");

  foreach(var_2 in level._id_2C4A) {
    _id_82B4(var_2);
  }

  level._id_2AC9 = [];
  level._id_2ACA = [];
  level._id_2A5C = [];
  var_4 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10275();

  foreach(var_14, var_6 in var_4._id_4356) {
    var_7 = [[var_6._id_6D5D]]();
    level._id_2AC9 = scripts\engine\utility::_id_1B9D(level._id_2AC9, var_7);

    foreach(var_9 in var_7) {
      if(isDefined(var_9._id_CE2B) && var_9._id_CE2B > 0) {
        var_10 = level._id_2ACA.size;
        level._id_2ACA[var_10] = var_9;
        continue;
      }

      if(isDefined(var_9._id_0481) && var_9._id_0481 == "littlebird_spawn") {
        level._id_2A5C[level._id_2A5C.size] = var_9;
        continue;
      }

      foreach(var_2 in level._id_2C4A) {
        if(_func_011A(var_9.origin, var_2)) {
          var_10 = var_2._id_10353.size;
          var_2._id_10353[var_10] = var_9;
          break;
        }
      }
    }
  }
}

_id_82B4(var_0) {
  var_0._id_10353 = [];
  var_0._id_10354 = 0;
  _id_1D28(var_0);
}

_id_1D28(var_0) {
  var_0._id_9F47 = 0;

  switch (var_0._id_0481) {
    case "boneyard":
      var_0._id_9F47 = 2;
      break;
    case "dam":
      var_0._id_9F47 = 2;
      break;
    case "downtown":
      var_0._id_9F47 = 4;
      break;
    case "downtownpark":
      var_0._id_9F47 = 1;
      break;
    case "farm":
      var_0._id_9F47 = 4;
      break;
    case "gulag":
      var_0._id_9F47 = 1;
      break;
    case "hospital":
      var_0._id_9F47 = 0;
      break;
    case "junkyard":
      var_0._id_9F47 = 1;
      break;
    case "layover":
      var_0._id_9F47 = 3;
      break;
    case "lumber":
      var_0._id_9F47 = 2;
      break;
    case "militarybase":
      var_0._id_9F47 = 3;
      break;
    case "port":
      var_0._id_9F47 = 2;
      break;
    case "quarry":
      var_0._id_9F47 = 2;
      break;
    case "stadium":
      var_0._id_9F47 = 1;
      break;
    case "storagewars":
      var_0._id_9F47 = 1;
      break;
    case "super":
      var_0._id_9F47 = 1;
      break;
    case "torez":
      var_0._id_9F47 = 1;
      break;
    case "transit":
      var_0._id_9F47 = 2;
      break;
    case "tvstation":
      var_0._id_9F47 = 1;
      break;
    case "test_zone":
      var_0._id_9F47 = 1;
      break;
  }
}

_id_51C9() {
  if(!isDefined(level.vehicle) || !isDefined(level.vehicle._id_8300)) {
    return;
  }
  foreach(var_5, var_1 in level.vehicle._id_8300) {
    foreach(var_3 in var_1) {
      if(scripts\cp_mp\vehicles\vehicle_occupancy::_id_101BB(var_3)) {
        scripts\cp_mp\vehicles\vehicle_occupancy::_id_1017D(var_3);
      }
    }
  }
}

_id_476D() {
  if(!isDefined(level.vehicle) || !isDefined(level.vehicle._id_8300)) {
    return;
  }
  scripts\cp_mp\vehicles\vehicle_spawn::_id_10268();
  level._id_EBC3 = 1;

  foreach(var_6, var_1 in level.vehicle._id_8300) {
    var_2 = _id_0AAF::_id_643E(var_6);

    foreach(var_4 in var_1) {
      scripts\cp_mp\vehicles\vehicle_spawn::_id_10288(var_4);
      var_4[[var_2]](undefined);
    }
  }

  level._id_EBC3 = 0;
}

_id_F75D(var_0, var_1, var_2, var_3) {
  if(var_0 == "little_bird" && scripts\mp\gametypes\br_gametypes::_id_8853("littleBirdSpawns")) {
    return;
  }
  if(scripts\cp_mp\vehicles\vehicle_spawn::_id_10269(var_0)) {
    var_4 = _id_E26B(var_0, var_1, var_3);

    if(isDefined(var_4)) {
      return var_4;
    }
  }

  return undefined;
}

_id_E26B(var_0, var_1, var_2) {
  var_3 = var_1.origin;
  var_4 = var_1.angles;

  if(!isDefined(var_4)) {
    var_4 = (0, randomfloat(360), 0);
  }

  var_5 = spawnStruct();
  var_5.origin = var_3;
  var_5.angles = var_4;
  var_5.spawntype = "GAME_MODE";
  var_6 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle(var_0, var_5, var_2);

  if(isDefined(var_6)) {
    scripts\mp\gametypes\br_analytics::_id_2B0D(var_6, var_0);
  }

  return var_6;
}

_id_E30A() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10275();
  level._id_2AC4 = 0;
  var_1 = 0;
  var_2 = [];
  var_3 = level._id_2AC9;
  var_4 = scripts\engine\utility::array_randomize(level._id_2ACA);

  foreach(var_6 in var_4) {
    var_7 = spawnStruct();
    var_8 = level._id_2ACB[var_6._id_0481];
    var_9 = _id_F75D(var_8, var_6, "alwaysSpawn", var_7);

    if(isDefined(var_9)) {
      level._id_2AC4++;
      var_2[var_2.size] = var_6;
      var_10 = 0;

      foreach(var_12 in level._id_2C4A) {
        if(_func_011A(var_6.origin, var_12)) {
          var_12._id_10354++;
          var_10 = 1;
          break;
        }
      }

      if(!var_10) {}

      if(level._id_2AC4 >= level._id_2AC3) {
        break;
      }

      waitframe();
      continue;
    }

    var_1++;
  }

  var_19 = 0;

  if(level._id_2AC4 < level._id_2AC3) {
    var_20 = scripts\engine\utility::array_randomize(level._id_2C4A);

    foreach(var_12 in var_20) {
      var_22 = var_12._id_9F47;

      if(isDefined(var_22) && var_22 > 0) {
        if(var_22 > var_12._id_10353.size) {}

        if(var_12._id_10354 < var_22 && var_12._id_10353.size > 0) {
          var_23 = scripts\engine\utility::array_randomize(var_12._id_10353);

          for(var_24 = 0; var_12._id_10354 < var_22 && var_24 < var_23.size; var_24++) {
            var_7 = spawnStruct();
            var_6 = var_23[var_24];
            var_8 = level._id_2ACB[var_6._id_0481];
            var_9 = _id_F75D(var_8, var_6, var_12._id_0481, var_7);

            if(!isDefined(var_9)) {
              var_19++;
              continue;
            }

            level._id_2AC4++;
            var_2[var_2.size] = var_6;
            var_12._id_10354++;

            if(level._id_2AC4 >= level._id_2AC3) {
              break;
            }

            waitframe();
          }

          if(level._id_2AC4 >= level._id_2AC3) {
            break;
          }
        }
      }
    }
  }

  if(level._id_2AC4 < level._id_2AC3) {
    var_26 = 0;
    var_27 = scripts\engine\utility::array_randomize(level._id_2A5C);

    foreach(var_6 in var_27) {
      var_7 = spawnStruct();
      var_8 = level._id_2ACB[var_6._id_0481];
      var_9 = _id_F75D(var_8, var_6, "heloSpawn", var_7);

      if(isDefined(var_9)) {
        level._id_2AC4++;
        var_2[var_2.size] = var_6;
        var_26++;

        if(var_26 >= level._id_2A5B) {
          break;
        }

        if(level._id_2AC4 >= level._id_2AC3) {
          break;
        }

        waitframe();
      }
    }
  }

  if(level._id_2AC4 < level._id_2AC3) {
    var_23 = 0;
    var_3 = scripts\engine\utility::_id_1BBF(var_3, var_2);
    var_3 = scripts\engine\utility::array_randomize(var_3);

    foreach(var_6 in var_3) {
      var_8 = level._id_2ACB[var_6._id_0481];

      while(!scripts\cp_mp\vehicles\vehicle_tracking::_id_31E1()) {
        wait 1;
      }

      var_7 = spawnStruct();
      var_9 = _id_F75D(var_8, var_6, "randomSpawns", var_7);
      level._id_2AC4++;
      var_23++;

      if(level._id_2AC4 >= level._id_2AC3) {
        break;
      }

      waitframe();
    }
  }

  var_32 = 0;
  var_40 = var_1 + var_19;

  if(var_32 > 0) {
    return;
  }
}

_id_2C48() {
  level._id_2AC4 = 0;
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10275();

  foreach(var_2 in level._id_2C4A) {
    var_2._id_10354 = 0;
  }
}

_id_10834() {
  level endon("game_ended");
  level notify("br_vehiclesWaitForDelete");
  level endon("br_vehiclesWaitForDelete");
  waitframe();
  waittillframeend;
  _id_E30A();
}

_id_2C49() {
  _id_51C9();
  _id_476D();
  _id_2C48();
  level thread _id_10834();
}

_id_2C45() {
  wait 1.5;
  _id_09E1::_id_100E6(0);
  _id_2C49();
  _id_09E1::_id_100E6(1);
}

_id_433F(var_0, var_1) {
  if(!isDefined(level.vehicle) || !isDefined(level.vehicle._id_8300)) {
    return;
  }
  var_2 = 160.0;
  var_3 = 36.0;
  var_4 = 100.0;
  var_5 = getdvarfloat("#x3eb6c28851dd19c43", var_4);
  var_6 = level.vehicle._id_8300["little_bird"];

  if(isDefined(var_6)) {
    foreach(var_8 in var_6) {
      var_9 = 0;
      var_10 = var_8.origin;
      var_11 = distance2d(var_0, var_10);

      if(var_11 + var_2 > var_1) {
        var_9 = 1;
      } else {
        var_12 = var_8 gettagorigin("tail_rotor_jnt");
        var_11 = distance2d(var_0, var_12);

        if(var_11 + var_3 > var_1) {
          var_9 = 1;
        }
      }

      if(var_9) {
        var_13 = var_8.health;
        var_14 = var_8.maxhealth;
        var_15 = 100;
        var_8 dodamage(var_5, var_10, undefined, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
      }
    }
  }
}