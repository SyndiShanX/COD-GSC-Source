/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3833.gsc
**************************************/

#using_animtree("vehicles");

_id_FE03(var_0, var_1, var_2, var_3, var_4) {
  _id_0EFB::_id_FE05();

  if(!isDefined(var_3)) {
    var_3 = "landed_mode";
  }

  if(!isDefined(var_2)) {
    var_2 = "fake";
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  var_5 = undefined;

  if(isent(var_1)) {
    var_5 = var_1;
    var_1 = var_1.targetname;
  } else if(!isDefined(var_1)) {
    var_1 = "no info";
    var_5 = level._id_E35D._id_3BB6;
  } else {
    switch (var_1) {
      case "jackal_bay_4":
      case "jackal_bay_1":
      case "jackal_bay_3":
      case "jackal_bay_2":
        var_5 = _id_0EFB::_id_7CBC(var_1, "script_noteworthy", "jackal_launch_pos1");
        break;
      case "dropship_bay_2":
      case "dropship_bay_1":
        var_5 = _id_0EFB::_id_7CBC(var_1, "script_noteworthy", "dropship_pos1");
        break;
      default:
        if(!isDefined(_id_0EFB::_id_7D7A(var_1, 1))) {
          var_5 = level._id_E35D._id_3BB6;
        } else {
          var_5 = _id_0EFB::_id_7D7A(var_1);
        }

        break;
    }
  }

  var_6 = undefined;

  switch (var_0) {
    case "jackal":
      if(isDefined(level._id_FD6E.jackals)) {
        if(var_1 != "no info") {}
      }

      var_7 = _id_7C9E("jackal_spawner");
      level._id_FD6E.jackals[var_1] = var_7 scripts\sp\utility::_id_10808();
      level._id_FD6E.jackals[var_1] vehicle_teleport(var_5.origin, var_5.angles);
      level._id_FD6E.jackals[var_1] thread _id_0BDC::_id_F43D(var_2);
      level._id_FD6E.jackals[var_1] scripts\engine\utility::delaythread(0.1, _id_0BDC::_id_A167);
      level._id_FD6E.jackals[var_1] scripts\engine\utility::delaythread(0.0, _id_0BDC::_id_6B4C, var_3);

      if(var_2 == "player") {
        level._id_FD6E._id_D127 = level._id_FD6E.jackals[var_1];
        level._id_FD6E.jackals[var_1] _id_0BDC::_id_A07D();
      } else if(var_1 == level._id_E35D._id_1D05 || var_1 == "crane_b" || var_1 == "return_crane_b" || var_1 == "b")
        level._id_FD6E.jackals[var_1] setModel("veh_mil_air_un_jackal_02_clear");

      var_6 = level._id_FD6E.jackals[var_1];
      break;
    case "jackal_cheap":
      if(isDefined(level._id_FD6E.jackals)) {
        if(var_1 != "no info") {}
      }

      level._id_FD6E.jackals[var_1] = spawn("script_model", var_5.origin);
      level._id_FD6E.jackals[var_1].angles = var_5.angles;
      level._id_FD6E.jackals[var_1] setModel("veh_mil_air_un_jackal_landed_03b");
      level._id_FD6E.jackals[var_1] _id_A317();

      if(var_4) {
        level._id_FD6E.jackals[var_1].collision = level._id_FD6E.jackals[var_1] _id_A0AE();
      }

      var_6 = level._id_FD6E.jackals[var_1];
      break;
    case "dropship":
      if(isDefined(level._id_FD6E._id_5EE3)) {}

      var_8 = _id_7C9E("dropship_spawner", "dropship");
      var_9 = _id_0BBF::_id_5DFE();
      var_9._id_1325F = "dropship_player_parts" + getsubstr(var_8, var_8.size - 1, var_8.size);
      var_9._id_1325C = "col_dropship" + getsubstr(var_8, var_8.size - 1, var_8.size);
      level._id_FD6E._id_5EE3[var_1] = _id_0BBF::_id_106B8(var_8, var_5, undefined, undefined, undefined, var_9);
      level._id_FD6E._id_5EE3[var_1] _id_0BBF::_id_5EC6(var_5);
      level._id_FD6E._id_5EE3[var_1] notify("stop_kicking_up_dust");
      level._id_FD6E._id_5EE3[var_1] notify("turnengineoff");
      level._id_FD6E._id_5EE3[var_1] scripts\engine\utility::delaythread(0.05, scripts\sp\utility::_id_65DD, "thrusterEffects");
      level._id_FD6E._id_5EE3[var_1] _id_0BBC::_id_C5F1(["back"], undefined, 1);
      level._id_FD6E._id_5EE3[var_1]._id_4D94._id_4348 _meth_80AF();
      level._id_FD6E._id_5EE3[var_1] _id_0BBC::_id_5DC2();
      level._id_FD6E._id_5EE3[var_1] _meth_82A2(%vh_dropship_thrusters_up);
      level._id_FD6E._id_5EE3[var_1] _id_0BBE::_id_5DFB("down");
      var_6 = level._id_FD6E._id_5EE3[var_1];
      break;
    case "dropship_cheap":
      level._id_FD6E._id_5EE3[var_1] = spawn("script_model", var_5.origin);
      level._id_FD6E._id_5EE3[var_1].angles = var_5.angles;
      level._id_FD6E._id_5EE3[var_1] setModel("veh_mil_air_un_dropship_hero_player");
      level._id_FD6E._id_5EE3[var_1] _id_5E9C();
      level._id_FD6E._id_5EE3[var_1]._id_9A62 = [];
      level._id_FD6E._id_5EE3[var_1]._id_9A62["interior_main"] = spawn("script_model", var_5.origin);
      level._id_FD6E._id_5EE3[var_1]._id_9A62["interior_main"].angles = var_5.angles;
      level._id_FD6E._id_5EE3[var_1]._id_9A62["interior_main"] setModel("veh_mil_air_un_dropship_periph_interior");
      level._id_FD6E._id_5EE3[var_1] _meth_82A2(%vh_dropship_rear_doors_open, 1, 0.0, 100);
      level._id_FD6E._id_5EE3[var_1] _meth_82A2(%vh_dropship_landing_gear_down, 1, 0.0, 100);
      var_6 = level._id_FD6E._id_5EE3[var_1];
      break;
    case "forklift":
      var_10 = _id_7C9E("forklift_spawner", "forklift");
      level._id_FD6E._id_7316[var_1] = var_10 scripts\sp\utility::_id_10808();
      level._id_FD6E._id_7316[var_1] vehicle_teleport(var_5.origin, var_5.angles);
      level._id_FD6E._id_7316[var_1]._id_11083 = 0;
      level._id_FD6E._id_7316[var_1]._id_11B0E = 0;
      var_11 = _id_0EF8::_id_FE01("spawner_flightdeck_handler", level._id_FD6E._id_7316[var_1], "cheap");
      var_11 _id_0EFB::_id_FD6F("forklift_driver");
      level._id_FD6E._id_7316[var_1]._id_5BC8 = var_11;
      var_11._id_EEC9 = 0;
      level._id_FD6E._id_7316[var_1] thread scripts\sp\vehicle_aianim::_id_8739(var_11);
      var_6 = level._id_FD6E._id_7316[var_1];
      break;
    case "towcart":
      var_12 = _id_7C9E("towcart_spawner", "towcart");
      level._id_FD6E._id_11A55[var_1] = var_12 scripts\sp\utility::_id_10808();
      level._id_FD6E._id_11A55[var_1] vehicle_teleport(var_5.origin, var_5.angles);
      level._id_FD6E._id_11A55[var_1] _id_0BF1::_id_11A51();
      var_11 = _id_0EF8::_id_FE01("spawner_flightdeck_handler", level._id_FD6E._id_11A55[var_1], "cheap");
      var_11 _id_0EFB::_id_FD6F("forklift_driver");
      level._id_FD6E._id_11A55[var_1]._id_5BC8 = var_11;
      var_11._id_EEC9 = 0;
      level._id_FD6E._id_11A55[var_1] thread scripts\sp\vehicle_aianim::_id_8739(var_11);
      var_6 = level._id_FD6E._id_11A55[var_1];
      break;
    case "apc":
      var_13 = _id_7C9E("apc_spawner", "apc");
      level._id_FD6E._id_209C[var_1] = var_13 scripts\sp\utility::_id_10808();
      level._id_FD6E._id_209C[var_1] vehicle_teleport(var_5.origin, var_5.angles);
      var_6 = level._id_FD6E._id_209C[var_1];
      break;
  }

  return var_6;
}

_id_7C9E(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "normal";
  }

  var_2 = undefined;

  if(var_1 == "dropship") {
    var_3 = getEntArray(var_0, "script_noteworthy");
  } else {
    var_3 = getEntArray(var_0, "targetname");
  }

  for(;;) {
    foreach(var_5 in var_3) {
      if(!isDefined(var_5._id_1306F)) {
        var_2 = var_5;
        break;
      }
    }

    if(isDefined(var_2)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  if(var_1 == "dropship") {
    var_2 thread _id_10B52(1);
    return var_2.targetname;
  } else {
    var_2 thread _id_10B52();
    return var_2;
  }
}

_id_10B52(var_0) {
  self endon("death");
  self._id_1306F = 1;

  if(!isDefined(var_0)) {
    scripts\engine\utility::waitframe();
    self._id_1306F = undefined;
  }
}

#using_animtree("jackal");

_id_A317() {
  self _meth_83D0(#animtree);
}

#using_animtree("vehicles");

_id_5E9C() {
  self _meth_83D0(#animtree);
}

_id_A0AE() {
  var_0 = getEntArray("jackal_collision", "targetname");

  if(!isDefined(var_0)) {}

  foreach(var_2 in var_0) {
    if(isDefined(var_2.in_use)) {
      if(var_2.in_use) {
        continue;
      }
    } else {
      var_2.in_use = 1;

      if(var_2 islinked()) {
        var_2 unlink();
      }

      var_2 linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
      return var_2;
    }
  }

  return undefined;
}