/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\vehicle_omnvar_utility.gsc
************************************************************/

function vehomn_init() {
  var_0 = spawnStruct();
  level.vehicle.ref_11fd0 = var_0;
  var_0.vehicledata = [];
}

function vehomn_setvehicle(var_0, var_1) {
  var_2 = ref_1427e(var_0);
  var_3 = var_2.id;

  if(isDefined(var_1)) {
    if(isarray(var_1)) {
      foreach(var_5 in var_1) {
        if(isDefined(var_5) && isPlayer(var_5)) {
          var_5 setclientomnvar("ui_veh_vehicle", var_3);
        }
      }

      return;
    }

    if(isPlayer(var_1)) {
      var_1 setclientomnvar("ui_veh_vehicle", var_3);
      return;
    }

    return;
  }
}

function vehomn_setcurrentseat(var_0, var_1, var_2) {
  var_3 = -1;

  if(isDefined(var_0)) {
    var_4 = ref_1427e(var_0);

    if(isDefined(var_1)) {
      var_3 = var_4.seatids[var_1];
    }
  }

  var_2 setclientomnvar("ui_veh_current_seat", var_3);
}

function vehomn_setnextseat(var_0, var_1, var_2) {
  var_3 = -1;

  if(isDefined(var_1)) {
    var_4 = ref_1427e(var_0);
    var_3 = var_4.seatids[var_1];
  }

  var_2 setclientomnvar("ui_veh_next_seat", var_3);
}

function vehomn_setseatentity(var_0, var_1, var_2, var_3) {
  var_4 = -1;

  if(isDefined(var_0)) {
    var_5 = ref_1427e(var_0);

    if(isDefined(var_1)) {
      var_4 = var_5.seatids[var_1];
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
    if(isarray(var_3)) {
      foreach(var_9 in var_3) {
        if(isDefined(var_9) && isPlayer(var_9)) {
          var_9 setclientomnvar(var_6, var_7);
        }
      }

      return;
    }

    if(isPlayer(var_3)) {
      var_3 setclientomnvar(var_6, var_7);
      return;
    }

    return;
  }
}

function vehomn_clearseatentity(var_0, var_1, var_2) {
  vehomn_setseatentity(var_0, var_1, undefined, var_2);
}

function vehomn_sethealthpercent(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(isDefined(var_1)) {
    if(isarray(var_1)) {
      foreach(var_3 in var_1) {
        if(isDefined(var_3) && isPlayer(var_3)) {
          var_3 setclientomnvar("ui_veh_health_percent", int(var_0));
        }
      }

      return;
    }

    if(isPlayer(var_1)) {
      var_1 setclientomnvar("ui_veh_health_percent", int(var_0));
      return;
    }

    return;
  }
}

function vehomn_clearhealthpercent(var_0) {
  vehomn_sethealthpercent(undefined, var_0);
}

function vehomn_showhealth(var_0) {
  if(isDefined(var_0)) {
    if(isarray(var_0)) {
      foreach(var_2 in var_0) {
        if(isDefined(var_2) && isPlayer(var_2)) {
          var_2 setclientomnvar("ui_veh_show_health", 1);
        }
      }

      return;
    }

    if(isPlayer(var_0)) {
      var_0 setclientomnvar("ui_veh_show_health", 1);
      return;
    }

    return;
  }
}

function vehomn_hidehealth(var_0) {
  if(isDefined(var_0)) {
    if(isarray(var_0)) {
      foreach(var_2 in var_0) {
        if(isDefined(var_2) && isPlayer(var_2)) {
          var_2 setclientomnvar("ui_veh_show_health", 0);
        }
      }

      return;
    }

    if(isPlayer(var_0)) {
      var_0 setclientomnvar("ui_veh_show_health", 0);
      return;
    }

    return;
  }
}

function vehomn_clearshowhealth(var_0) {
  if(false) {
    vehomn_showhealth(var_0);
    return;
  }

  vehomn_hidehealth(var_0);
}

function vehomn_settimepercent(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(isDefined(var_1)) {
    if(isarray(var_1)) {
      foreach(var_3 in var_1) {
        if(isDefined(var_3) && isPlayer(var_3)) {
          var_3 setclientomnvar("ui_veh_time_percent", int(var_0));
        }
      }

      return;
    }

    if(isPlayer(var_1)) {
      var_1 setclientomnvar("ui_veh_time_percent", int(var_0));
      return;
    }

    return;
  }
}

function vehomn_cleartimepercent(var_0) {
  vehomn_settimepercent(undefined, var_0);
}

function vehomn_showtime(var_0) {
  if(isDefined(var_0)) {
    if(isarray(var_0)) {
      foreach(var_2 in var_0) {
        if(isDefined(var_2) && isPlayer(var_2)) {
          var_2 setclientomnvar("ui_veh_show_time", 1);
        }
      }

      return;
    }

    if(isPlayer(var_0)) {
      var_0 setclientomnvar("ui_veh_show_time", 1);
      return;
    }

    return;
  }
}

function vehomn_hidetime(var_0) {
  if(isDefined(var_0)) {
    if(isarray(var_0)) {
      foreach(var_2 in var_0) {
        if(isDefined(var_2) && isPlayer(var_2)) {
          var_2 setclientomnvar("ui_veh_show_time", 0);
        }
      }

      return;
    }

    if(isPlayer(var_0)) {
      var_0 setclientomnvar("ui_veh_show_time", 0);
      return;
    }

    return;
  }
}

function vehomn_clearshowtime(var_0) {
  if(false) {
    vehomn_showtime(var_0);
    return;
  }

  vehomn_hidetime(var_0);
}

function vehomn_setfuelpercent(var_0, var_1) {}

function vehomn_clearfuelpercent(var_0) {}

function vehomn_showfuel(var_0) {}

function vehomn_hidefuel(var_0) {}

function vehomn_clearshowfuel(var_0) {}

function vehomn_setammo(var_0, var_1, var_2, var_3) {
  var_4 = ref_1427e(var_0);
  var_5 = var_4.brtruck_initdialog[var_1];
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
  } else if(isstring(var_2) && var_2 == "infinite") {
    var_2 = -2;
  }

  if(isDefined(var_3)) {
    if(isarray(var_3)) {
      foreach(var_8 in var_3) {
        if(isDefined(var_8) && isPlayer(var_8)) {
          var_8 setclientomnvar(var_6, var_2);
        }
      }

      return;
    }

    if(isPlayer(var_3)) {
      var_3 setclientomnvar(var_6, var_2);
      return;
    }

    return;
  }
}

function vehomn_clearammo(var_0, var_1, var_2) {
  vehomn_setammo(var_0, var_1, undefined, var_2);
}

function vehomn_showammo(var_0, var_1, var_2, var_3) {
  vehomn_setammo(var_0, var_1, var_2, var_3);
}

function vehomn_hideammo(var_0, var_1, var_2) {
  vehomn_setammo(var_0, var_1, -1, var_2);
}

function vehomn_showwarning(var_0, var_1, var_2) {
  var_3 = ref_1427e(var_2);
  var_4 = var_3.ref_14422[var_0];

  if(isDefined(var_1)) {
    var_5 = var_3.ref_14426[var_0];

    if(isarray(var_1)) {
      foreach(var_7 in var_1) {
        if(isDefined(var_7) && isPlayer(var_7)) {
          var_7 setclientomnvarbit("ui_veh_warning", var_4, 1);

          if(isDefined(var_5)) {
            GscBinSkip1(0x74, var_5, var_7, "ui_veh_warning_omnvar_modified");
          }
        }
      }

      return;
    }

    if(isPlayer(var_1)) {
      var_1 setclientomnvarbit("ui_veh_warning", var_4, 1);

      if(isDefined(var_5)) {
        GscBinSkip1(0x74, var_5, var_1, "ui_veh_warning_omnvar_modified");
      }

      return;
    }

    return;
  }
}

function vehomn_hidewarning(var_0, var_1, var_2) {
  var_3 = ref_1427e(var_2);
  var_4 = var_3.ref_14422[var_0];

  if(isDefined(var_1)) {
    var_5 = var_3.ref_14424[var_0];

    if(isarray(var_1)) {
      foreach(var_7 in var_1) {
        if(isDefined(var_7) && isPlayer(var_7)) {
          var_7 setclientomnvarbit("ui_veh_warning", var_4, 0);

          if(isDefined(var_5)) {
            GscBinSkip1(0x74, var_5, var_7, "ui_veh_warning_omnvar_modified");
          }
        }
      }

      return;
    }

    if(isPlayer(var_1)) {
      var_1 setclientomnvarbit("ui_veh_warning", var_4, 0);

      if(isDefined(var_5)) {
        GscBinSkip1(0x74, var_5, var_1, "ui_veh_warning_omnvar_modified");
      }

      return;
    }

    return;
  }
}

function vehomn_clearwarnings(var_0, var_1) {
  if(isDefined(var_0)) {
    var_2 = undefined;

    if(isDefined(var_1)) {
      var_2 = ref_1427e(var_1, undefined, 1);
    }

    if(isarray(var_0)) {
      foreach(var_4 in var_0) {
        if(isDefined(var_4) && isPlayer(var_4)) {
          var_4 setclientomnvar("ui_veh_warning", 0);

          if(isDefined(var_2)) {
            foreach(var_6 in var_2.ref_14423) {
              if(isDefined(var_6)) {
                GscBinSkip1(0x74, var_6, var_4);

              }
            }
          }
        }
      }

      return;
    }

    if(isPlayer(var_0)) {
      var_0 setclientomnvar("ui_veh_warning", 0);

      if(isDefined(var_2)) {
        foreach(var_6 in var_2.ref_14423) {
          if(isDefined(var_6)) {
            GscBinSkip1(0x74, var_6, var_0);
          }
        }

        return;
      }

      return;
    }

    return;
  }
}

function vehomn_setrotation(var_0, var_1, var_2, var_3) {
  var_4 = ref_1427e(var_0);
  var_5 = var_4.ref_12da2[var_1];
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
      var_2 = ceil(var_2);
    } else {
      var_2 = floor(var_2);
    }

    if(isarray(var_3)) {
      foreach(var_9 in var_3) {
        if(isDefined(var_9) && isPlayer(var_9)) {
          var_9 setclientomnvar(var_6, var_2);
        }
      }

      return;
    }

    if(isPlayer(var_3)) {
      var_3 setclientomnvar(var_6, var_2);
      return;
    }

    return;
  }
}

function vehomn_clearrotation(var_0, var_1, var_2) {
  vehomn_setrotation(var_0, var_1, undefined, var_2);
}

function ref_14281(var_0) {
  if(isDefined(var_0)) {
    if(isarray(var_0)) {
      foreach(var_2 in var_0) {
        if(isDefined(var_2) && isPlayer(var_2)) {
          var_2 notify("vehOmn_modified_controls");
          var_2.ref_14284 = "show";
          var_2 setclientomnvar("ui_veh_controls", 1);
        }
      }

      return;
    }

    if(isPlayer(var_0)) {
      var_0 notify("vehOmn_modified_controls");
      var_0.ref_14284 = "show";
      var_0 setclientomnvar("ui_veh_controls", 1);
      return;
    }

    return;
  }
}

function ref_14280(var_0) {
  if(isDefined(var_0)) {
    if(isarray(var_0)) {
      foreach(var_2 in var_0) {
        if(isDefined(var_2) && isPlayer(var_2)) {
          var_2 notify("vehOmn_modified_controls");
          var_2.ref_14284 = "hide";
          var_2 setclientomnvar("ui_veh_controls", 0);
        }
      }

      return;
    }

    if(isPlayer(var_0)) {
      var_0 notify("vehOmn_modified_controls");
      var_0.ref_14284 = "hide";
      var_0 setclientomnvar("ui_veh_controls", 0);
      return;
    }

    return;
  }
}

function ref_1427b(var_0) {
  if(isDefined(var_0)) {
    if(isarray(var_0)) {
      foreach(var_2 in var_0) {
        if(isDefined(var_2) && isPlayer(var_2)) {
          thread ref_1427c(var_2);
        }
      }

      return;
    }

    if(isPlayer(var_0)) {
      thread ref_1427c(var_0);
      return;
    }

    return;
  }
}

function ref_1427c(var_0) {
  var_0 endon("death_or_disconnect");
  var_0 endon("vehOmn_modified_controls");

  if(!isDefined(var_0.ref_14284) || var_0.ref_14284 != "hide" && var_0.ref_14284 != "fadeOut") {
    var_0.ref_14284 = "fadeOut";
    var_0 setclientomnvar("ui_veh_controls", 2);
    wait 3;
    thread ref_14280(var_0);
    return;
  }
}

function ref_14278(var_0) {
  if(isDefined(var_0)) {
    if(isarray(var_0)) {
      foreach(var_2 in var_0) {
        if(isDefined(var_2) && isPlayer(var_2)) {
          var_2.ref_14284 = undefined;
          var_2 setclientomnvar("ui_veh_controls", 0);
        }
      }

      return;
    }

    if(isPlayer(var_0)) {
      var_0 setclientomnvar("ui_veh_controls", 0);
      var_0.ref_14284 = undefined;
      return;
    }

    return;
  }
}

function ref_1427a(var_0) {
  return !isDefined(var_0.ref_14284) || var_0.ref_14284 == "fadeOut" || var_0.ref_14284 == "hide";
}

function ref_1427d() {
  return level.vehicle.ref_11fd0;
}

function ref_1427e(var_0, var_1, var_2) {
  var_3 = ref_1427d();
  var_4 = var_3.vehicledata[var_0];

  if(!isDefined(var_4)) {
    if(istrue(var_1)) {
      var_4 = spawnStruct();
      var_3.vehicledata[var_0] = var_4;
      var_4.seatids = [];
      var_4.brtruck_initdialog = [];
      var_4.ref_12da2 = [];
      var_4.ref_14422 = [];
      var_4.ref_14426 = [];
      var_4.ref_14424 = [];
      var_4.ref_14423 = [];
      var_4.ref_12da3 = [];
      var_4.id = undefined;
      var_4.ref_14422["burningDown"] = 1;
      var_4.ref_14422["missileLocking"] = 2;
      var_4.ref_14422["missileIncoming"] = 4;
      var_4.ref_14422["movementDisabled"] = 3;
    } else if(istrue(var_2)) {}
  }

  return var_4;
}

function ref_14279(var_0, var_1, var_2) {
  var_3 = ref_1427e(var_0, var_1, var_2);

  if(isDefined(var_3)) {
    var_3.seatids = [];
    var_3.brtruck_initdialog = [];
    var_3.ref_12da2 = [];
    var_3.ref_14422 = [];
    var_3.ref_14426 = [];
    var_3.ref_14424 = [];
    var_3.ref_14423 = [];
    var_3.id = undefined;
  }

  return var_3;
}

function vehomn_clearall(var_0, var_1) {
  if(isarray(var_0)) {
    foreach(var_3 in var_0) {
      vehomn_clearallinternal(var_3, var_1);
    }

    return;
  }

  vehomn_clearallinternal(var_0, var_1);
}

function vehomn_clearallinternal(var_0, var_1) {
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
    vehomn_clearwarnings(var_0, var_1);
    var_0 setclientomnvar("ui_veh_degrees_0", 0);
    var_0 setclientomnvar("ui_veh_degrees_1", 0);
    ref_14278(var_0);
    return;
  }
}

function vehomn_updateomnvarsonseatenter(var_0, var_1, var_2, var_3) {
  vehomn_setvehicle(var_0.vehiclename, var_3);
  vehomn_setcurrentseat(var_0.vehiclename, var_2, var_3);
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0);

  if(isDefined(var_1)) {
    vehomn_clearseatentity(var_0.vehiclename, var_1, var_4);
  } else {
    foreach(var_6 in var_4) {
      if(isDefined(var_6) && var_6 != var_3) {
        vehomn_setseatentity(var_0.vehiclename, var_7, var_6, var_3);
      }
    }
  }

  vehomn_setseatentity(var_0.vehiclename, var_2, var_3, var_4);
  vehomn_updatenextseatomnvars(var_0);
  vehomn_updateomnvarsondamage(var_0);
  ref_14281(var_3);
  ref_140ff(var_0, var_3, var_2);
  var_8 = ref_1427e(var_0.vehiclename);

  if(scripts\cp_mp\utility\weapon_utility::islockedonto(var_0)) {
    if(isDefined(var_8.ref_14422["missileLocking"])) {
      vehomn_showwarning("missileLocking", var_3, var_0.vehiclename);
    }
  }

  if(scripts\cp_mp\utility\weapon_utility::hasincoming(var_0)) {
    if(isDefined(var_8.ref_14422["missileIncoming"])) {
      vehomn_showwarning("missileIncoming", var_3, var_0.vehiclename);
    }
  }

  if(!scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_movementisallowed(var_0)) {
    if(isDefined(var_8.ref_14422["movementDisabled"])) {
      vehomn_showwarning("movementDisabled", var_3, var_0.vehiclename);
    }
  }

  if(var_0 scripts\cp_mp\vehicles\vehicle_damage::ref_1415b()) {
    if(isDefined(var_8.ref_14422["burningDown"])) {
      vehomn_showwarning("burningDown", var_3, var_0.vehiclename);
      return;
    }

    return;
  }
}

function vehomn_updateomnvarsonseatexit(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    if(isDefined(var_1)) {
      vehomn_clearall(var_3, var_0.vehiclename);

      if(isDefined(var_0)) {
        var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0);
        vehomn_clearseatentity(var_0.vehiclename, var_1, var_4);
        vehomn_updatenextseatomnvars(var_0);
        return;
      }

      return;
    }

    return;
  }
}

function vehomn_updateomnvarsondamage(var_0, var_1) {
  var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0, 0);

  if(!isDefined(var_1)) {
    var_3 = int(clamp(var_0.health / var_0.maxhealth * 100, 0, 100));
  } else {
    var_3 = int(clamp((var_1.health - var_2.damage) / var_1.maxhealth * 100, 0, 100));
  }

  vehomn_showhealth(var_3);
  vehomn_sethealthpercent(var_3, var_3);
}

function ref_14282(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = spawnStruct();
  }

  var_2 = ref_1427e(var_0.vehiclename, undefined, 1);
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0);

  if(isDefined(var_3) && isDefined(var_2)) {
    if(isDefined(var_3) && var_3.size > 0) {
      foreach(var_5 in var_3) {
        if(isDefined(var_5) && isPlayer(var_5) && var_5 scripts\cp_mp\utility\player_utility::_isalive()) {
          ref_140ff(var_0, var_5, var_6, var_1);
        }
      }

      return;
    }

    return;
  }
}

function ref_140ff(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var_0, var_1);
  }

  ref_14283(var_0, var_1, var_2, var_3);
}

function vehomn_updatenextseatomnvars(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0);

  foreach(var_3 in var_1) {
    var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getnextavailableseat(var_0, var_3, var_5);
    vehomn_setnextseat(var_0.vehiclename, var_4, var_3);
  }
}

function ref_14283(var_0, var_1, var_2, var_3) {
  var_4 = ref_1427e(var_0.vehiclename);

  if(var_4.ref_12da3.size > 0 && isDefined(var_4.ref_12da3[var_2])) {
    var_5 = 0;

    if(scripts\cp_mp\vehicles\vehicle_occupancy::ref_141df(var_0, var_2)) {
      var_5 = 1;
    } else {
      var_6 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_getcameraforseat(var_0, var_2);

      if(isDefined(var_6) && var_6 != "none") {
        var_5 = 1;
      }
    }

    var_7 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(var_0.vehiclename, var_2);

    if(var_5) {
      if(isDefined(var_0.objweapon)) {
        var_8 = var_4.ref_12da3[var_2][var_0.objweapon.basename];

        if(isDefined(var_8)) {
          var_9 = invertangles(var_1 getplayerangles());
          var_10 = var_0.angles;
          var_11 = combineangles(var_9, var_10);
          var_12 = angleclamp(var_11[1]);
          vehomn_setrotation(var_0.vehiclename, var_8, var_12, var_1);
        }
      }
    }

    var_13 = ref_1427f(var_0, var_3);

    if(isDefined(var_13)) {
      foreach(var_8 in var_4.ref_12da3[var_2]) {
        var_11 = var_13[var_15];

        if(isDefined(var_11)) {
          var_12 = angleclamp(var_11[1]);
          vehomn_setrotation(var_0.vehiclename, var_8, var_12, var_1);
        }
      }

      return;
    }

    return;
  }
}

function ref_1427f(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1.ref_1196a)) {
    return var_1.ref_12da1;
  }

  var_2 = scripts\cp_mp\vehicles\vehicle::ref_14193(var_0);

  if(isDefined(var_2) && var_2.size > 0) {
    var_3 = [];
    var_4 = invertangles(var_0.angles);

    foreach(var_6 in var_2) {
      if(var_6 scripts\engine\utility::hastag(var_6.model, "tag_flash")) {
        var_3 = combineangles(var_4, var_6 gettagangles("tag_flash"));
      }
    }

    if(isDefined(var_1)) {
      var_1.ref_12da1 = var_3;
    }

    return var_3;
  }

  return undefined;
}