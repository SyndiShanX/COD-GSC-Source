/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\vehicle_omnvar_utility.gsc
************************************************************/

function vehomn_init() {
  var0 = spawnStruct();
  level.vehicle.ref_11fd0 = var0;
  var0.vehicledata = [];
}

function vehomn_setvehicle(var0, var1) {
  var2 = ref_1427e(var0);
  var3 = var2.id;

  if(isDefined(var1)) {
    if(isarray(var1)) {
      foreach(var5 in var1) {
        if(isDefined(var5) && isPlayer(var5)) {
          var5 setclientomnvar("ui_veh_vehicle", var3);
        }
      }

      return;
    }

    if(isPlayer(var1)) {
      var1 setclientomnvar("ui_veh_vehicle", var3);
      return;
    }

    return;
  }
}

function vehomn_setcurrentseat(var0, var1, var2) {
  var3 = -1;

  if(isDefined(var0)) {
    var4 = ref_1427e(var0);

    if(isDefined(var1)) {
      var3 = var4.seatids[var1];
    }
  }

  var2 setclientomnvar("ui_veh_current_seat", var3);
}

function vehomn_setnextseat(var0, var1, var2) {
  var3 = -1;

  if(isDefined(var1)) {
    var4 = ref_1427e(var0);
    var3 = var4.seatids[var1];
  }

  var2 setclientomnvar("ui_veh_next_seat", var3);
}

function vehomn_setseatentity(var0, var1, var2, var3) {
  var4 = -1;

  if(isDefined(var0)) {
    var5 = ref_1427e(var0);

    if(isDefined(var1)) {
      var4 = var5.seatids[var1];
    }
  }

  var6 = undefined;

  switch (var4) {
    case 0:
      var6 = "ui_veh_occupant_0";
      break;
    case 1:
      var6 = "ui_veh_occupant_1";
      break;
    case 2:
      var6 = "ui_veh_occupant_2";
      break;
    case 3:
      var6 = "ui_veh_occupant_3";
      break;
    case 4:
      var6 = "ui_veh_occupant_4";
      break;
    case 5:
      var6 = "ui_veh_occupant_5";
      break;
    case 6:
      var6 = "ui_veh_occupant_6";
      break;
  }

  var7 = -1;

  if(isDefined(var2)) {
    var7 = var2 getentitynumber();
  }

  if(isDefined(var3)) {
    if(isarray(var3)) {
      foreach(var9 in var3) {
        if(isDefined(var9) && isPlayer(var9)) {
          var9 setclientomnvar(var6, var7);
        }
      }

      return;
    }

    if(isPlayer(var3)) {
      var3 setclientomnvar(var6, var7);
      return;
    }

    return;
  }
}

function vehomn_clearseatentity(var0, var1, var2) {
  vehomn_setseatentity(var0, var1, undefined, var2);
}

function vehomn_sethealthpercent(var0, var1) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(isDefined(var1)) {
    if(isarray(var1)) {
      foreach(var3 in var1) {
        if(isDefined(var3) && isPlayer(var3)) {
          var3 setclientomnvar("ui_veh_health_percent", int(var0));
        }
      }

      return;
    }

    if(isPlayer(var1)) {
      var1 setclientomnvar("ui_veh_health_percent", int(var0));
      return;
    }

    return;
  }
}

function vehomn_clearhealthpercent(var0) {
  vehomn_sethealthpercent(undefined, var0);
}

function vehomn_showhealth(var0) {
  if(isDefined(var0)) {
    if(isarray(var0)) {
      foreach(var2 in var0) {
        if(isDefined(var2) && isPlayer(var2)) {
          var2 setclientomnvar("ui_veh_show_health", 1);
        }
      }

      return;
    }

    if(isPlayer(var0)) {
      var0 setclientomnvar("ui_veh_show_health", 1);
      return;
    }

    return;
  }
}

function vehomn_hidehealth(var0) {
  if(isDefined(var0)) {
    if(isarray(var0)) {
      foreach(var2 in var0) {
        if(isDefined(var2) && isPlayer(var2)) {
          var2 setclientomnvar("ui_veh_show_health", 0);
        }
      }

      return;
    }

    if(isPlayer(var0)) {
      var0 setclientomnvar("ui_veh_show_health", 0);
      return;
    }

    return;
  }
}

function vehomn_clearshowhealth(var0) {
  if(false) {
    vehomn_showhealth(var0);
    return;
  }

  vehomn_hidehealth(var0);
}

function vehomn_settimepercent(var0, var1) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(isDefined(var1)) {
    if(isarray(var1)) {
      foreach(var3 in var1) {
        if(isDefined(var3) && isPlayer(var3)) {
          var3 setclientomnvar("ui_veh_time_percent", int(var0));
        }
      }

      return;
    }

    if(isPlayer(var1)) {
      var1 setclientomnvar("ui_veh_time_percent", int(var0));
      return;
    }

    return;
  }
}

function vehomn_cleartimepercent(var0) {
  vehomn_settimepercent(undefined, var0);
}

function vehomn_showtime(var0) {
  if(isDefined(var0)) {
    if(isarray(var0)) {
      foreach(var2 in var0) {
        if(isDefined(var2) && isPlayer(var2)) {
          var2 setclientomnvar("ui_veh_show_time", 1);
        }
      }

      return;
    }

    if(isPlayer(var0)) {
      var0 setclientomnvar("ui_veh_show_time", 1);
      return;
    }

    return;
  }
}

function vehomn_hidetime(var0) {
  if(isDefined(var0)) {
    if(isarray(var0)) {
      foreach(var2 in var0) {
        if(isDefined(var2) && isPlayer(var2)) {
          var2 setclientomnvar("ui_veh_show_time", 0);
        }
      }

      return;
    }

    if(isPlayer(var0)) {
      var0 setclientomnvar("ui_veh_show_time", 0);
      return;
    }

    return;
  }
}

function vehomn_clearshowtime(var0) {
  if(false) {
    vehomn_showtime(var0);
    return;
  }

  vehomn_hidetime(var0);
}

function vehomn_setfuelpercent(var0, var1) {}

function vehomn_clearfuelpercent(var0) {}

function vehomn_showfuel(var0) {}

function vehomn_hidefuel(var0) {}

function vehomn_clearshowfuel(var0) {}

function vehomn_setammo(var0, var1, var2, var3) {
  var4 = ref_1427e(var0);
  var5 = var4.brtruck_initdialog[var1];
  var6 = undefined;

  switch (var5) {
    case 0:
      var6 = "ui_veh_ammo_0";
      break;
    case 1:
      var6 = "ui_veh_ammo_1";
      break;
    case 2:
      var6 = "ui_veh_ammo_2";
      break;
  }

  if(!isDefined(var2)) {
    var2 = -1;
  } else if(isstring(var2) && var2 == "infinite") {
    var2 = -2;
  }

  if(isDefined(var3)) {
    if(isarray(var3)) {
      foreach(var8 in var3) {
        if(isDefined(var8) && isPlayer(var8)) {
          var8 setclientomnvar(var6, var2);
        }
      }

      return;
    }

    if(isPlayer(var3)) {
      var3 setclientomnvar(var6, var2);
      return;
    }

    return;
  }
}

function vehomn_clearammo(var0, var1, var2) {
  vehomn_setammo(var0, var1, undefined, var2);
}

function vehomn_showammo(var0, var1, var2, var3) {
  vehomn_setammo(var0, var1, var2, var3);
}

function vehomn_hideammo(var0, var1, var2) {
  vehomn_setammo(var0, var1, -1, var2);
}

function vehomn_showwarning(var0, var1, var2) {
  var3 = ref_1427e(var2);
  var4 = var3.ref_14422[var0];

  if(isDefined(var1)) {
    var5 = var3.ref_14426[var0];

    if(isarray(var1)) {
      foreach(var7 in var1) {
        if(isDefined(var7) && isPlayer(var7)) {
          var7 setclientomnvarbit("ui_veh_warning", var4, 1);

          if(isDefined(var5)) {
            GscBinSkip1(0x74, var5, var7, "ui_veh_warning_omnvar_modified");
          }
        }
      }

      return;
    }

    if(isPlayer(var1)) {
      var1 setclientomnvarbit("ui_veh_warning", var4, 1);

      if(isDefined(var5)) {
        GscBinSkip1(0x74, var5, var1, "ui_veh_warning_omnvar_modified");
      }

      return;
    }

    return;
  }
}

function vehomn_hidewarning(var0, var1, var2) {
  var3 = ref_1427e(var2);
  var4 = var3.ref_14422[var0];

  if(isDefined(var1)) {
    var5 = var3.ref_14424[var0];

    if(isarray(var1)) {
      foreach(var7 in var1) {
        if(isDefined(var7) && isPlayer(var7)) {
          var7 setclientomnvarbit("ui_veh_warning", var4, 0);

          if(isDefined(var5)) {
            GscBinSkip1(0x74, var5, var7, "ui_veh_warning_omnvar_modified");
          }
        }
      }

      return;
    }

    if(isPlayer(var1)) {
      var1 setclientomnvarbit("ui_veh_warning", var4, 0);

      if(isDefined(var5)) {
        GscBinSkip1(0x74, var5, var1, "ui_veh_warning_omnvar_modified");
      }

      return;
    }

    return;
  }
}

function vehomn_clearwarnings(var0, var1) {
  if(isDefined(var0)) {
    var2 = undefined;

    if(isDefined(var1)) {
      var2 = ref_1427e(var1, undefined, 1);
    }

    if(isarray(var0)) {
      foreach(var4 in var0) {
        if(isDefined(var4) && isPlayer(var4)) {
          var4 setclientomnvar("ui_veh_warning", 0);

          if(isDefined(var2)) {
            foreach(var6 in var2.ref_14423) {
              if(isDefined(var6)) {
                GscBinSkip1(0x74, var6, var4);

              }
            }
          }
        }
      }

      return;
    }

    if(isPlayer(var0)) {
      var0 setclientomnvar("ui_veh_warning", 0);

      if(isDefined(var2)) {
        foreach(var6 in var2.ref_14423) {
          if(isDefined(var6)) {
            GscBinSkip1(0x74, var6, var0);
          }
        }

        return;
      }

      return;
    }

    return;
  }
}

function vehomn_setrotation(var0, var1, var2, var3) {
  var4 = ref_1427e(var0);
  var5 = var4.ref_12da2[var1];
  var6 = undefined;

  switch (var5) {
    case 0:
      var6 = "ui_veh_degrees_0";
      break;
    case 1:
      var6 = "ui_veh_degrees_1";
      break;
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(isDefined(var3)) {
    var7 = var2 - floor(var2);

    if(var7 >= 0.5) {
      var2 = ceil(var2);
    } else {
      var2 = floor(var2);
    }

    if(isarray(var3)) {
      foreach(var9 in var3) {
        if(isDefined(var9) && isPlayer(var9)) {
          var9 setclientomnvar(var6, var2);
        }
      }

      return;
    }

    if(isPlayer(var3)) {
      var3 setclientomnvar(var6, var2);
      return;
    }

    return;
  }
}

function vehomn_clearrotation(var0, var1, var2) {
  vehomn_setrotation(var0, var1, undefined, var2);
}

function ref_14281(var0) {
  if(isDefined(var0)) {
    if(isarray(var0)) {
      foreach(var2 in var0) {
        if(isDefined(var2) && isPlayer(var2)) {
          var2 notify("vehOmn_modified_controls");
          var2.ref_14284 = "show";
          var2 setclientomnvar("ui_veh_controls", 1);
        }
      }

      return;
    }

    if(isPlayer(var0)) {
      var0 notify("vehOmn_modified_controls");
      var0.ref_14284 = "show";
      var0 setclientomnvar("ui_veh_controls", 1);
      return;
    }

    return;
  }
}

function ref_14280(var0) {
  if(isDefined(var0)) {
    if(isarray(var0)) {
      foreach(var2 in var0) {
        if(isDefined(var2) && isPlayer(var2)) {
          var2 notify("vehOmn_modified_controls");
          var2.ref_14284 = "hide";
          var2 setclientomnvar("ui_veh_controls", 0);
        }
      }

      return;
    }

    if(isPlayer(var0)) {
      var0 notify("vehOmn_modified_controls");
      var0.ref_14284 = "hide";
      var0 setclientomnvar("ui_veh_controls", 0);
      return;
    }

    return;
  }
}

function ref_1427b(var0) {
  if(isDefined(var0)) {
    if(isarray(var0)) {
      foreach(var2 in var0) {
        if(isDefined(var2) && isPlayer(var2)) {
          thread ref_1427c(var2);
        }
      }

      return;
    }

    if(isPlayer(var0)) {
      thread ref_1427c(var0);
      return;
    }

    return;
  }
}

function ref_1427c(var0) {
  var0 endon("death_or_disconnect");
  var0 endon("vehOmn_modified_controls");

  if(!isDefined(var0.ref_14284) || var0.ref_14284 != "hide" && var0.ref_14284 != "fadeOut") {
    var0.ref_14284 = "fadeOut";
    var0 setclientomnvar("ui_veh_controls", 2);
    wait 3;
    thread ref_14280(var0);
    return;
  }
}

function ref_14278(var0) {
  if(isDefined(var0)) {
    if(isarray(var0)) {
      foreach(var2 in var0) {
        if(isDefined(var2) && isPlayer(var2)) {
          var2.ref_14284 = undefined;
          var2 setclientomnvar("ui_veh_controls", 0);
        }
      }

      return;
    }

    if(isPlayer(var0)) {
      var0 setclientomnvar("ui_veh_controls", 0);
      var0.ref_14284 = undefined;
      return;
    }

    return;
  }
}

function ref_1427a(var0) {
  return !isDefined(var0.ref_14284) || var0.ref_14284 == "fadeOut" || var0.ref_14284 == "hide";
}

function ref_1427d() {
  return level.vehicle.ref_11fd0;
}

function ref_1427e(var0, var1, var2) {
  var3 = ref_1427d();
  var4 = var3.vehicledata[var0];

  if(!isDefined(var4)) {
    if(istrue(var1)) {
      var4 = spawnStruct();
      var3.vehicledata[var0] = var4;
      var4.seatids = [];
      var4.brtruck_initdialog = [];
      var4.ref_12da2 = [];
      var4.ref_14422 = [];
      var4.ref_14426 = [];
      var4.ref_14424 = [];
      var4.ref_14423 = [];
      var4.ref_12da3 = [];
      var4.id = undefined;
      var4.ref_14422["burningDown"] = 1;
      var4.ref_14422["missileLocking"] = 2;
      var4.ref_14422["missileIncoming"] = 4;
      var4.ref_14422["movementDisabled"] = 3;
    } else if(istrue(var2)) {}
  }

  return var4;
}

function ref_14279(var0, var1, var2) {
  var3 = ref_1427e(var0, var1, var2);

  if(isDefined(var3)) {
    var3.seatids = [];
    var3.brtruck_initdialog = [];
    var3.ref_12da2 = [];
    var3.ref_14422 = [];
    var3.ref_14426 = [];
    var3.ref_14424 = [];
    var3.ref_14423 = [];
    var3.id = undefined;
  }

  return var3;
}

function vehomn_clearall(var0, var1) {
  if(isarray(var0)) {
    foreach(var3 in var0) {
      vehomn_clearallinternal(var3, var1);
    }

    return;
  }

  vehomn_clearallinternal(var0, var1);
}

function vehomn_clearallinternal(var0, var1) {
  if(isDefined(var0) && isPlayer(var0)) {
    var0 setclientomnvar("ui_veh_vehicle", -1);
    var0 setclientomnvar("ui_veh_current_seat", -1);
    var0 setclientomnvar("ui_veh_next_seat", -1);
    var0 setclientomnvar("ui_veh_occupant_0", -1);
    var0 setclientomnvar("ui_veh_occupant_1", -1);
    var0 setclientomnvar("ui_veh_occupant_2", -1);
    var0 setclientomnvar("ui_veh_occupant_3", -1);
    var0 setclientomnvar("ui_veh_occupant_4", -1);
    var0 setclientomnvar("ui_veh_occupant_5", -1);
    var0 setclientomnvar("ui_veh_occupant_6", -1);
    var0 setclientomnvar("ui_veh_health_percent", 0);
    var0 setclientomnvar("ui_veh_show_health", 0);
    var0 setclientomnvar("ui_veh_time_percent", 0);
    var0 setclientomnvar("ui_veh_show_time", 0);
    var0 setclientomnvar("ui_veh_ammo_0", -1);
    var0 setclientomnvar("ui_veh_ammo_1", -1);
    vehomn_clearwarnings(var0, var1);
    var0 setclientomnvar("ui_veh_degrees_0", 0);
    var0 setclientomnvar("ui_veh_degrees_1", 0);
    ref_14278(var0);
    return;
  }
}

function vehomn_updateomnvarsonseatenter(var0, var1, var2, var3) {
  vehomn_setvehicle(var0.vehiclename, var3);
  vehomn_setcurrentseat(var0.vehiclename, var2, var3);
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var0);

  if(isDefined(var1)) {
    vehomn_clearseatentity(var0.vehiclename, var1, var4);
  } else {
    foreach(var6 in var4) {
      if(isDefined(var6) && var6 != var3) {
        vehomn_setseatentity(var0.vehiclename, var7, var6, var3);
      }
    }
  }

  vehomn_setseatentity(var0.vehiclename, var2, var3, var4);
  vehomn_updatenextseatomnvars(var0);
  vehomn_updateomnvarsondamage(var0);
  ref_14281(var3);
  ref_140ff(var0, var3, var2);
  var8 = ref_1427e(var0.vehiclename);

  if(scripts\cp_mp\utility\weapon_utility::islockedonto(var0)) {
    if(isDefined(var8.ref_14422["missileLocking"])) {
      vehomn_showwarning("missileLocking", var3, var0.vehiclename);
    }
  }

  if(scripts\cp_mp\utility\weapon_utility::hasincoming(var0)) {
    if(isDefined(var8.ref_14422["missileIncoming"])) {
      vehomn_showwarning("missileIncoming", var3, var0.vehiclename);
    }
  }

  if(!scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_movementisallowed(var0)) {
    if(isDefined(var8.ref_14422["movementDisabled"])) {
      vehomn_showwarning("movementDisabled", var3, var0.vehiclename);
    }
  }

  if(var0 scripts\cp_mp\vehicles\vehicle_damage::ref_1415b()) {
    if(isDefined(var8.ref_14422["burningDown"])) {
      vehomn_showwarning("burningDown", var3, var0.vehiclename);
      return;
    }

    return;
  }
}

function vehomn_updateomnvarsonseatexit(var0, var1, var2, var3) {
  if(!isDefined(var2)) {
    if(isDefined(var1)) {
      vehomn_clearall(var3, var0.vehiclename);

      if(isDefined(var0)) {
        var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var0);
        vehomn_clearseatentity(var0.vehiclename, var1, var4);
        vehomn_updatenextseatomnvars(var0);
        return;
      }

      return;
    }

    return;
  }
}

function vehomn_updateomnvarsondamage(var0, var1) {
  var2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var0, 0);

  if(!isDefined(var1)) {
    var3 = int(clamp(var0.health / var0.maxhealth * 100, 0, 100));
  } else {
    var3 = int(clamp((var1.health - var2.damage) / var1.maxhealth * 100, 0, 100));
  }

  vehomn_showhealth(var3);
  vehomn_sethealthpercent(var3, var3);
}

function ref_14282(var0, var1) {
  if(!isDefined(var1)) {
    var1 = spawnStruct();
  }

  var2 = ref_1427e(var0.vehiclename, undefined, 1);
  var3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var0);

  if(isDefined(var3) && isDefined(var2)) {
    if(isDefined(var3) && var3.size > 0) {
      foreach(var5 in var3) {
        if(isDefined(var5) && isPlayer(var5) && var5 scripts\cp_mp\utility\player_utility::_isalive()) {
          ref_140ff(var0, var5, var6, var1);
        }
      }

      return;
    }

    return;
  }
}

function ref_140ff(var0, var1, var2, var3) {
  if(!isDefined(var2)) {
    var2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var0, var1);
  }

  ref_14283(var0, var1, var2, var3);
}

function vehomn_updatenextseatomnvars(var0) {
  var1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var0);

  foreach(var3 in var1) {
    var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getnextavailableseat(var0, var3, var5);
    vehomn_setnextseat(var0.vehiclename, var4, var3);
  }
}

function ref_14283(var0, var1, var2, var3) {
  var4 = ref_1427e(var0.vehiclename);

  if(var4.ref_12da3.size > 0 && isDefined(var4.ref_12da3[var2])) {
    var5 = 0;

    if(scripts\cp_mp\vehicles\vehicle_occupancy::ref_141df(var0, var2)) {
      var5 = 1;
    } else {
      var6 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_getcameraforseat(var0, var2);

      if(isDefined(var6) && var6 != "none") {
        var5 = 1;
      }
    }

    var7 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(var0.vehiclename, var2);

    if(var5) {
      if(isDefined(var0.objweapon)) {
        var8 = var4.ref_12da3[var2][var0.objweapon.basename];

        if(isDefined(var8)) {
          var9 = invertangles(var1 getplayerangles());
          var10 = var0.angles;
          var11 = combineangles(var9, var10);
          var12 = angleclamp(var11[1]);
          vehomn_setrotation(var0.vehiclename, var8, var12, var1);
        }
      }
    }

    var13 = ref_1427f(var0, var3);

    if(isDefined(var13)) {
      foreach(var8 in var4.ref_12da3[var2]) {
        var11 = var13[var15];

        if(isDefined(var11)) {
          var12 = angleclamp(var11[1]);
          vehomn_setrotation(var0.vehiclename, var8, var12, var1);
        }
      }

      return;
    }

    return;
  }
}

function ref_1427f(var0, var1) {
  if(isDefined(var1) && isDefined(var1.ref_1196a)) {
    return var1.ref_12da1;
  }

  var2 = scripts\cp_mp\vehicles\vehicle::ref_14193(var0);

  if(isDefined(var2) && var2.size > 0) {
    var3 = [];
    var4 = invertangles(var0.angles);

    foreach(var6 in var2) {
      if(var6 scripts\engine\utility::hastag(var6.model, "tag_flash")) {
        var3 = combineangles(var4, var6 gettagangles("tag_flash"));
      }
    }

    if(isDefined(var1)) {
      var1.ref_12da1 = var3;
    }

    return var3;
  }

  return undefined;
}