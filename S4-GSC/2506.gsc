/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2506.gsc
*************************************************/

_id_1037C() {
  var_0 = spawnStruct();
  level.vehicle._id_AA41 = var_0;
  var_0._id_102F6 = [];
}

_id_1038A(var_0, var_1) {
  var_2 = _id_10373(var_0);
  var_3 = var_2._id_7C8C;

  if(isDefined(var_1)) {
    if(_func_0107(var_1)) {
      foreach(var_5 in var_1) {
        if(isDefined(var_5) && isPlayer(var_5)) {
          var_5 setclientomnvar("ui_veh_vehicle", var_3);
        }
      }
    } else if(isPlayer(var_1))
      var_1 setclientomnvar("ui_veh_vehicle", var_3);
  }
}

_id_10383(var_0, var_1, var_2) {
  var_3 = -1;

  if(isDefined(var_0)) {
    var_4 = _id_10373(var_0);

    if(isDefined(var_1)) {
      var_3 = var_4._id_CFC3[var_1];
    }
  }

  var_2 setclientomnvar("ui_veh_current_seat", var_3);
}

_id_10386(var_0, var_1, var_2) {
  var_3 = -1;

  if(isDefined(var_1)) {
    var_4 = _id_10373(var_0);
    var_3 = var_4._id_CFC3[var_1];
  }

  var_2 setclientomnvar("ui_veh_next_seat", var_3);
}

_id_10388(var_0, var_1, var_2, var_3) {
  var_4 = -1;

  if(isDefined(var_0)) {
    var_5 = _id_10373(var_0);

    if(isDefined(var_1)) {
      var_4 = var_5._id_CFC3[var_1];
    }
  }

  var_6 = undefined;

  switch (var_4) {
    case 0:
      var_6 = "ui_veh_occupant_0";
      break;
    case 1:
      var_6 = "ui_veh_occupant_1";
      break;
    case 2:
      var_6 = "ui_veh_occupant_2";
      break;
    case 3:
      var_6 = "ui_veh_occupant_3";
      break;
    case 4:
      var_6 = "ui_veh_occupant_4";
      break;
    case 5:
      var_6 = "ui_veh_occupant_5";
      break;
    case 6:
      var_6 = "ui_veh_occupant_6";
      break;
  }

  var_7 = -1;

  if(isDefined(var_2)) {
    var_7 = var_2 getentitynumber();
  }

  if(isDefined(var_3)) {
    if(_func_0107(var_3)) {
      foreach(var_9 in var_3) {
        if(isDefined(var_9) && isPlayer(var_9)) {
          var_9 setclientomnvar(var_6, var_7);
        }
      }
    } else if(isPlayer(var_3))
      var_3 setclientomnvar(var_6, var_7);
  }
}

_id_10368(var_0, var_1, var_2) {
  _id_10388(var_0, var_1, undefined, var_2);
}

_id_10385(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(isDefined(var_1)) {
    if(_func_0107(var_1)) {
      foreach(var_3 in var_1) {
        if(isDefined(var_3) && isPlayer(var_3)) {
          var_3 setclientomnvar("ui_veh_health_percent", int(var_0));
        }
      }
    } else if(isPlayer(var_1))
      var_1 setclientomnvar("ui_veh_health_percent", int(var_0));
  }
}

_id_10364(var_0) {
  _id_10385(undefined, var_0);
}

_id_1038E(var_0) {
  if(isDefined(var_0)) {
    if(_func_0107(var_0)) {
      foreach(var_2 in var_0) {
        if(isDefined(var_2) && isPlayer(var_2)) {
          var_2 setclientomnvar("ui_veh_show_health", 1);
        }
      }
    } else if(isPlayer(var_0))
      var_0 setclientomnvar("ui_veh_show_health", 1);
  }
}

_id_10379(var_0) {
  if(isDefined(var_0)) {
    if(_func_0107(var_0)) {
      foreach(var_2 in var_0) {
        if(isDefined(var_2) && isPlayer(var_2)) {
          var_2 setclientomnvar("ui_veh_show_health", 0);
        }
      }
    } else if(isPlayer(var_0))
      var_0 setclientomnvar("ui_veh_show_health", 0);
  }
}

_id_1036A(var_0) {
  if(0) {
    _id_1038E(var_0);
  } else {
    _id_10379(var_0);
  }
}

_id_10389(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(isDefined(var_1)) {
    if(_func_0107(var_1)) {
      foreach(var_3 in var_1) {
        if(isDefined(var_3) && isPlayer(var_3)) {
          var_3 setclientomnvar("ui_veh_time_percent", int(var_0));
        }
      }
    } else if(isPlayer(var_1))
      var_1 setclientomnvar("ui_veh_time_percent", int(var_0));
  }
}

_id_1036C(var_0) {
  _id_10389(undefined, var_0);
}

_id_1038F(var_0) {
  if(isDefined(var_0)) {
    if(_func_0107(var_0)) {
      foreach(var_2 in var_0) {
        if(isDefined(var_2) && isPlayer(var_2)) {
          var_2 setclientomnvar("ui_veh_show_time", 1);
        }
      }
    } else if(isPlayer(var_0))
      var_0 setclientomnvar("ui_veh_show_time", 1);
  }
}

_id_1037A(var_0) {
  if(isDefined(var_0)) {
    if(_func_0107(var_0)) {
      foreach(var_2 in var_0) {
        if(isDefined(var_2) && isPlayer(var_2)) {
          var_2 setclientomnvar("ui_veh_show_time", 0);
        }
      }
    } else if(isPlayer(var_0))
      var_0 setclientomnvar("ui_veh_show_time", 0);
  }
}

_id_1036B(var_0) {
  if(0) {
    _id_1038F(var_0);
  } else {
    _id_1037A(var_0);
  }
}

_id_10384(var_0, var_1) {}

_id_10363(var_0) {}

_id_1038D(var_0) {}

_id_10378(var_0) {}

_id_10369(var_0) {}

_id_10382(var_0, var_1, var_2, var_3) {
  var_4 = _id_10373(var_0);
  var_5 = var_4._id_171A[var_1];
  var_6 = undefined;

  switch (var_5) {
    case 0:
      var_6 = "ui_veh_ammo_0";
      break;
    case 1:
      var_6 = "ui_veh_ammo_1";
      break;
    case 2:
      var_6 = "ui_veh_ammo_2";
      break;
  }

  if(!isDefined(var_2)) {
    var_2 = -1;
  } else if(_func_0121(var_2) && var_2 == "infinite") {
    var_2 = -2;
  }

  if(isDefined(var_3)) {
    if(_func_0107(var_3)) {
      foreach(var_8 in var_3) {
        if(isDefined(var_8) && isPlayer(var_8)) {
          var_8 setclientomnvar(var_6, var_2);
        }
      }
    } else if(isPlayer(var_3))
      var_3 setclientomnvar(var_6, var_2);
  }
}

_id_10360(var_0, var_1, var_2) {
  _id_10382(var_0, var_1, undefined, var_2);
}

_id_1038B(var_0, var_1, var_2, var_3) {
  _id_10382(var_0, var_1, var_2, var_3);
}

_id_10376(var_0, var_1, var_2) {
  _id_10382(var_0, var_1, -1, var_2);
}

_id_10390(var_0, var_1, var_2) {
  var_3 = _id_10373(var_2);
  var_4 = var_3._id_109E9[var_0];

  if(isDefined(var_1)) {
    var_5 = var_3._id_109F9[var_0];

    if(_func_0107(var_1)) {
      foreach(var_7 in var_1) {
        if(isDefined(var_7) && isPlayer(var_7)) {
          var_7 _meth_82F8("ui_veh_warning", var_4, 1);

          if(isDefined(var_5)) {
            thread[[var_5]](var_7, "ui_veh_warning_omnvar_modified");
          }
        }
      }
    } else if(isPlayer(var_1)) {
      var_1 _meth_82F8("ui_veh_warning", var_4, 1);

      if(isDefined(var_5)) {
        thread[[var_5]](var_1, "ui_veh_warning_omnvar_modified");
      }
    }
  }
}

_id_1037B(var_0, var_1, var_2) {
  var_3 = _id_10373(var_2);
  var_4 = var_3._id_109E9[var_0];

  if(isDefined(var_1)) {
    var_5 = var_3._id_109EE[var_0];

    if(_func_0107(var_1)) {
      foreach(var_7 in var_1) {
        if(isDefined(var_7) && isPlayer(var_7)) {
          var_7 _meth_82F8("ui_veh_warning", var_4, 0);

          if(isDefined(var_5)) {
            thread[[var_5]](var_7, "ui_veh_warning_omnvar_modified");
          }
        }
      }
    } else if(isPlayer(var_1)) {
      var_1 _meth_82F8("ui_veh_warning", var_4, 0);

      if(isDefined(var_5)) {
        thread[[var_5]](var_1, "ui_veh_warning_omnvar_modified");
      }
    }
  }
}

_id_1036E(var_0, var_1) {
  if(isDefined(var_0)) {
    var_2 = undefined;

    if(isDefined(var_1)) {
      var_2 = _id_10373(var_1, undefined, 1);
    }

    if(_func_0107(var_0)) {
      foreach(var_4 in var_0) {
        if(isDefined(var_4) && isPlayer(var_4)) {
          var_4 setclientomnvar("ui_veh_warning", 0);

          if(isDefined(var_2)) {
            foreach(var_6 in var_2._id_109EB) {
              if(isDefined(var_6)) {
                thread[[var_6]](var_4);
              }
            }
          }
        }
      }
    } else if(isPlayer(var_0)) {
      var_0 setclientomnvar("ui_veh_warning", 0);

      if(isDefined(var_2)) {
        foreach(var_6 in var_2._id_109EB) {
          if(isDefined(var_6)) {
            thread[[var_6]](var_0);
          }
        }
      }
    }
  }
}

_id_10387(var_0, var_1, var_2, var_3) {
  var_4 = _id_10373(var_0);
  var_5 = var_4._id_C930[var_1];
  var_6 = undefined;

  switch (var_5) {
    case 0:
      var_6 = "ui_veh_degrees_0";
      break;
    case 1:
      var_6 = "ui_veh_degrees_1";
      break;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(isDefined(var_3)) {
    var_7 = var_2 - floor(var_2);

    if(var_7 >= 0.5) {
      var_2 = _func_0037(var_2);
    } else {
      var_2 = floor(var_2);
    }

    if(_func_0107(var_3)) {
      foreach(var_9 in var_3) {
        if(isDefined(var_9) && isPlayer(var_9)) {
          var_9 setclientomnvar(var_6, var_2);
        }
      }
    } else if(isPlayer(var_3))
      var_3 setclientomnvar(var_6, var_2);
  }
}

_id_10367(var_0, var_1, var_2) {
  _id_10387(var_0, var_1, undefined, var_2);
}

_id_1038C(var_0) {
  if(isDefined(var_0)) {
    if(_func_0107(var_0)) {
      foreach(var_2 in var_0) {
        if(isDefined(var_2) && isPlayer(var_2)) {
          var_2 notify("vehOmn_modified_controls");
          var_2._id_10397 = "show";
          var_2 setclientomnvar("ui_veh_controls", 1);
        }
      }
    } else if(isPlayer(var_0)) {
      var_0 notify("vehOmn_modified_controls");
      var_0._id_10397 = "show";
      var_0 setclientomnvar("ui_veh_controls", 1);
    }
  }
}

_id_10377(var_0) {
  if(isDefined(var_0)) {
    if(_func_0107(var_0)) {
      foreach(var_2 in var_0) {
        if(isDefined(var_2) && isPlayer(var_2)) {
          var_2 notify("vehOmn_modified_controls");
          var_2._id_10397 = "hide";
          var_2 setclientomnvar("ui_veh_controls", 0);
        }
      }
    } else if(isPlayer(var_0)) {
      var_0 notify("vehOmn_modified_controls");
      var_0._id_10397 = "hide";
      var_0 setclientomnvar("ui_veh_controls", 0);
    }
  }
}

_id_10370(var_0) {
  if(isDefined(var_0)) {
    if(_func_0107(var_0)) {
      foreach(var_2 in var_0) {
        if(isDefined(var_2) && isPlayer(var_2)) {
          thread _id_10371(var_2);
        }
      }
    } else if(isPlayer(var_0))
      thread _id_10371(var_0);
  }
}

_id_10371(var_0) {
  var_0 endon("death_or_disconnect");
  var_0 endon("vehOmn_modified_controls");

  if(!isDefined(var_0._id_10397) || var_0._id_10397 != "hide" && var_0._id_10397 != "fadeOut") {
    var_0._id_10397 = "fadeOut";
    var_0 setclientomnvar("ui_veh_controls", 2);
    wait 3;
    thread _id_10377(var_0);
  }
}

_id_10361(var_0) {
  if(isDefined(var_0)) {
    if(_func_0107(var_0)) {
      foreach(var_2 in var_0) {
        if(isDefined(var_2) && isPlayer(var_2)) {
          var_2._id_10397 = undefined;
          var_2 setclientomnvar("ui_veh_controls", 0);
        }
      }
    } else if(isPlayer(var_0)) {
      var_0 setclientomnvar("ui_veh_controls", 0);
      var_0._id_10397 = undefined;
    }
  }
}

_id_1036F(var_0) {
  return !isDefined(var_0._id_10397) || var_0._id_10397 == "fadeOut" || var_0._id_10397 == "hide";
}

_id_10372() {
  return level.vehicle._id_AA41;
}

_id_10373(var_0, var_1, var_2) {
  var_3 = _id_10372();
  var_4 = var_3._id_102F6[var_0];

  if(!isDefined(var_4)) {
    if(istrue(var_1)) {
      var_4 = spawnStruct();
      var_3._id_102F6[var_0] = var_4;
      var_4._id_CFC3 = [];
      var_4._id_171A = [];
      var_4._id_C930 = [];
      var_4._id_109E9 = [];
      var_4._id_109F9 = [];
      var_4._id_109EE = [];
      var_4._id_109EB = [];
      var_4._id_C931 = [];
      var_4._id_7C8C = undefined;
      var_4._id_109E9["burningDown"] = 1;
      var_4._id_109E9["missileLocking"] = 2;
      var_4._id_109E9["missileIncoming"] = 4;
      var_4._id_109E9["movementDisabled"] = 3;
    } else if(!istrue(var_2)) {}
  }

  return var_4;
}

_id_10365(var_0, var_1, var_2) {
  var_3 = _id_10373(var_0, var_1, var_2);

  if(isDefined(var_3)) {
    var_3._id_CFC3 = [];
    var_3._id_171A = [];
    var_3._id_C930 = [];
    var_3._id_109E9 = [];
    var_3._id_109F9 = [];
    var_3._id_109EE = [];
    var_3._id_109EB = [];
    var_3._id_7C8C = undefined;
  }

  return var_3;
}

_id_1035E(var_0, var_1) {
  if(_func_0107(var_0)) {
    foreach(var_3 in var_0) {
      _id_1035F(var_3, var_1);
    }
  } else
    _id_1035F(var_0, var_1);
}

_id_1035F(var_0, var_1) {
  if(isDefined(var_0) && isPlayer(var_0)) {
    var_0 setclientomnvar("ui_veh_vehicle", -1);
    var_0 setclientomnvar("ui_veh_current_seat", -1);
    var_0 setclientomnvar("ui_veh_next_seat", -1);
    var_0 setclientomnvar("ui_veh_occupant_0", -1);
    var_0 setclientomnvar("ui_veh_occupant_1", -1);
    var_0 setclientomnvar("ui_veh_occupant_2", -1);
    var_0 setclientomnvar("ui_veh_occupant_3", -1);
    var_0 setclientomnvar("ui_veh_occupant_4", -1);
    var_0 setclientomnvar("ui_veh_occupant_5", -1);
    var_0 setclientomnvar("ui_veh_occupant_6", -1);
    var_0 setclientomnvar("ui_veh_health_percent", 0);
    var_0 setclientomnvar("ui_veh_show_health", 0);
    var_0 setclientomnvar("ui_veh_time_percent", 0);
    var_0 setclientomnvar("ui_veh_show_time", 0);
    var_0 setclientomnvar("ui_veh_ammo_0", -1);
    var_0 setclientomnvar("ui_veh_ammo_1", -1);
    _id_1036E(var_0, var_1);
    var_0 setclientomnvar("ui_veh_degrees_0", 0);
    var_0 setclientomnvar("ui_veh_degrees_1", 0);
    _id_10361(var_0);
  }
}

_id_10393(var_0, var_1, var_2, var_3) {
  _id_1038A(var_0._id_1031E, var_3);
  _id_10383(var_0._id_1031E, var_2, var_3);
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(var_0);

  if(isDefined(var_1)) {
    _id_10368(var_0._id_1031E, var_1, var_4);
  } else {
    foreach(var_7, var_6 in var_4) {
      if(isDefined(var_6) && var_6 != var_3) {
        _id_10388(var_0._id_1031E, var_7, var_6, var_3);
      }
    }
  }

  _id_10388(var_0._id_1031E, var_2, var_3, var_4);
  _id_10391(var_0);
  _id_10392(var_0);
  _id_1038C(var_3);
  _id_FFF2(var_0, var_3, var_2);
  var_8 = _id_10373(var_0._id_1031E);

  if(scripts\cp_mp\utility\weapon_utility::_id_8915(var_0)) {
    if(isDefined(var_8._id_109E9["missileLocking"])) {
      _id_10390("missileLocking", var_3, var_0._id_1031E);
    }
  }

  if(scripts\cp_mp\utility\weapon_utility::_id_7575(var_0)) {
    if(isDefined(var_8._id_109E9["missileIncoming"])) {
      _id_10390("missileIncoming", var_3, var_0._id_1031E);
    }
  }

  if(!scripts\cp_mp\vehicles\vehicle_occupancy::_id_101D1(var_0)) {
    if(isDefined(var_8._id_109E9["movementDisabled"])) {
      _id_10390("movementDisabled", var_3, var_0._id_1031E);
    }
  }

  if(var_0 scripts\cp_mp\vehicles\vehicle_damage::_id_10052()) {
    if(isDefined(var_8._id_109E9["burningDown"])) {
      _id_10390("burningDown", var_3, var_0._id_1031E);
    }
  }
}

_id_10394(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    if(isDefined(var_1)) {
      _id_1035E(var_3, var_0._id_1031E);

      if(isDefined(var_0)) {
        var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(var_0);
        _id_10368(var_0._id_1031E, var_1, var_4);
        _id_10391(var_0);
      }
    }
  }
}

_id_10392(var_0, var_1) {
  var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(var_0, 0);

  if(!isDefined(var_1)) {
    var_3 = int(clamp(var_0.health / var_0.maxhealth * 100, 0, 100));
  } else {
    var_3 = int(clamp((var_0.health - var_1.damage) / var_0.maxhealth * 100, 0, 100));
  }

  _id_1038E(var_2);
  _id_10385(var_3, var_2);
}

_id_10395(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = spawnStruct();
  }

  var_2 = _id_10373(var_0._id_1031E, undefined, 1);
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(var_0);

  if(isDefined(var_3) && isDefined(var_2)) {
    if(isDefined(var_3) && var_3.size > 0) {
      foreach(var_6, var_5 in var_3) {
        if(isDefined(var_5) && isPlayer(var_5) && var_5 scripts\cp_mp\utility\player_utility::_isalive()) {
          _id_FFF2(var_0, var_5, var_6, var_1);
        }
      }
    }
  }
}

_id_FFF2(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A6(var_0, var_1);
  }

  _id_10396(var_0, var_1, var_2, var_3);
}

_id_10391(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(var_0);

  foreach(var_5, var_3 in var_1) {
    var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A4(var_0, var_3, var_5);
    _id_10386(var_0._id_1031E, var_4, var_3);
  }
}

_id_10396(var_0, var_1, var_2, var_3) {
  var_4 = _id_10373(var_0._id_1031E);

  if(var_4._id_C931.size > 0 && isDefined(var_4._id_C931[var_2])) {
    var_5 = 0;

    if(scripts\cp_mp\vehicles\vehicle_occupancy::_id_101BC(var_0, var_2)) {
      var_5 = 1;
    } else {
      var_6 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_100B7(var_0, var_2);

      if(isDefined(var_6) && var_6 != "none") {
        var_5 = 1;
      }
    }

    var_7 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2(var_0._id_1031E, var_2);

    if(var_5) {
      if(isDefined(var_0.objweapon)) {
        var_8 = var_4._id_C931[var_2][var_0.objweapon.basename];

        if(isDefined(var_8)) {
          var_9 = _func_00FF(var_1 getplayerangles());
          var_10 = var_0.angles;
          var_11 = _func_0047(var_9, var_10);
          var_12 = _func_000A(var_11[1]);
          _id_10387(var_0._id_1031E, var_8, var_12, var_1);
        }
      }
    } else {}

    var_13 = _id_10375(var_0, var_3);

    if(isDefined(var_13)) {
      foreach(var_15, var_8 in var_4._id_C931[var_2]) {
        var_11 = var_13[var_15];

        if(isDefined(var_11)) {
          var_12 = _func_000A(var_11[1]);
          _id_10387(var_0._id_1031E, var_8, var_12, var_1);
        }
      }
    }
  }
}

_id_10375(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1._id_96C6)) {
    return var_1._id_C92E;
  }

  var_2 = scripts\cp_mp\vehicles\vehicle::_id_100CD(var_0);

  if(isDefined(var_2) && var_2.size > 0) {
    var_3 = [];
    var_4 = _func_00FF(var_0.angles);

    foreach(var_7, var_6 in var_2) {
      var_3[var_7] = _func_0047(var_4, var_6 gettagangles("tag_flash"));
    }

    if(isDefined(var_1)) {
      var_1._id_C92E = var_3;
    }

    return var_3;
  }

  return undefined;
}