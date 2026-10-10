/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp_mp\utility\vehicle_omnvar_utility.gsc
***************************************************************/

#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;
#namespace vehicle_omnvar_utility;

function vehomn_init() {
  assertex(isDefined(level.vehicle), "vehOmn_init() called before vehicle_init().");
  assertex(!isDefined(level.vehicle.omnvars), "vehOmn_init() should only be called once.");
  leveldata = spawnStruct();
  level.vehicle.omnvars = leveldata;
  leveldata.vehicledata = [];
}

function vehomn_setvehicle(vehicleref, clients) {
  leveldataforvehicle = vehomn_getleveldataforvehicle(vehicleref);
  id = leveldataforvehicle.id;
  assertex(isDefined(id), "levelDataForVehicle for " + vehicleref + " failed to define an ID.");

  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(client in clients) {
        if(isDefined(client) && isPlayer(client)) {
          client setclientomnvar("ui_veh_vehicle", id);
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients setclientomnvar("ui_veh_vehicle", id);
    }
  }
}

function vehomn_setcurrentseat(vehicle, seatref, client) {
  if(!isDefined(client)) {
    return;
  }

  vehicleref = vehicle function_d93ec4635290febd();
  id = -1;

  if(isDefined(vehicleref)) {
    leveldataforvehicle = vehomn_getleveldataforvehicle(vehicleref);

    if(isDefined(seatref)) {
      id = leveldataforvehicle.seatids[seatref];
      var_ce438350733fad27 = vehicleref == "veh_jup_orav";

      if((var_ce438350733fad27 || istrue(leveldataforvehicle.hasdoors) && vehicle scripts\cp_mp\vehicles\vehicle_damage::function_b9d5a379eb1aefc7(seatref)) && seatref != "gunner") {
        id |= 16;
      }

      assertex(isDefined(id), "levelDataForVehicle for " + vehicleref + " failed to define an ID for seat " + seatref + ".");
    }
  }

  client setclientomnvar("ui_veh_current_seat", id);
}

function vehomn_setnextseat(vehicleref, seatref, client) {
  if(!isDefined(client)) {
    return;
  }

  id = -1;

  if(isDefined(seatref)) {
    leveldataforvehicle = vehomn_getleveldataforvehicle(vehicleref);
    id = leveldataforvehicle.seatids[seatref];
    assertex(isDefined(id), "levelDataForVehicle for " + vehicleref + " failed to define an ID for seat " + seatref + ".");
  }

  client setclientomnvar("ui_veh_next_seat", id);
}

function vehomn_setseatentity(vehicleref, seatref, seatentity, clients) {
  id = -1;

  if(isDefined(vehicleref)) {
    leveldataforvehicle = vehomn_getleveldataforvehicle(vehicleref);

    if(isDefined(seatref)) {
      id = leveldataforvehicle.seatids[seatref];
      assertex(isDefined(id), "levelDataForVehicle for " + vehicleref + " failed to define an ID for seat " + seatref + ".");
    }
  }

  omnvar = undefined;

  switch (id) {
    case 0:
      omnvar = "ui_veh_occupant_0";
      break;
    case 1:
      omnvar = "ui_veh_occupant_1";
      break;
    case 2:
      omnvar = "ui_veh_occupant_2";
      break;
    case 3:
      omnvar = "ui_veh_occupant_3";
      break;
    case 4:
      omnvar = "ui_veh_occupant_4";
      break;
    case 5:
      omnvar = "ui_veh_occupant_5";
      break;
    case 6:
      omnvar = "ui_veh_occupant_6";
      break;
  }

  assertex(isDefined(omnvar), "seatRef does not map to an omnvar.");
  var_8a36524e347d4ac2 = -1;

  if(isDefined(seatentity)) {
    var_8a36524e347d4ac2 = seatentity getentitynumber();
  }

  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(client in clients) {
        if(isDefined(client) && isPlayer(client)) {
          client setclientomnvar(omnvar, var_8a36524e347d4ac2);
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients setclientomnvar(omnvar, var_8a36524e347d4ac2);
    }
  }
}

function vehomn_clearseatentity(vehicleref, seatref, clients) {
  vehomn_setseatentity(vehicleref, seatref, undefined, clients);
}

function vehomn_sethealthpercent(var_52616aae7b55d981, clients) {
  if(!isDefined(var_52616aae7b55d981)) {
    var_52616aae7b55d981 = 0;
  }

  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(client in clients) {
        if(isDefined(client) && isPlayer(client)) {
          client setclientomnvar("ui_veh_health_percent", int(var_52616aae7b55d981));
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients setclientomnvar("ui_veh_health_percent", int(var_52616aae7b55d981));
    }
  }
}

function vehomn_clearhealthpercent(clients) {
  vehomn_sethealthpercent(undefined, clients);
}

function vehomn_showhealth(clients) {
  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(client in clients) {
        if(isDefined(client) && isPlayer(client)) {
          client setclientomnvar("ui_veh_show_health", 1);
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients setclientomnvar("ui_veh_show_health", 1);
    }
  }
}

function vehomn_hidehealth(clients) {
  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(client in clients) {
        if(isDefined(client) && isPlayer(client)) {
          client setclientomnvar("ui_veh_show_health", 0);
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients setclientomnvar("ui_veh_show_health", 0);
    }
  }
}

function vehomn_clearshowhealth(clients) {
  if(false) {
    vehomn_showhealth(clients);
    return;
  }

  vehomn_hidehealth(clients);
}

function vehomn_settimepercent(var_3b0524215d2eae6, clients) {
  if(!isDefined(var_3b0524215d2eae6)) {
    var_3b0524215d2eae6 = 0;
  }

  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(client in clients) {
        if(isDefined(client) && isPlayer(client)) {
          client setclientomnvar("ui_veh_time_percent", int(var_3b0524215d2eae6));
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients setclientomnvar("ui_veh_time_percent", int(var_3b0524215d2eae6));
    }
  }
}

function vehomn_cleartimepercent(clients) {
  vehomn_settimepercent(undefined, clients);
}

function vehomn_showtime(clients) {
  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(client in clients) {
        if(isDefined(client) && isPlayer(client)) {
          client setclientomnvar("ui_veh_show_time", 1);
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients setclientomnvar("ui_veh_show_time", 1);
    }
  }
}

function vehomn_hidetime(clients) {
  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(client in clients) {
        if(isDefined(client) && isPlayer(client)) {
          client setclientomnvar("ui_veh_show_time", 0);
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients setclientomnvar("ui_veh_show_time", 0);
    }
  }
}

function vehomn_clearshowtime(clients) {
  if(false) {
    vehomn_showtime(clients);
    return;
  }

  vehomn_hidetime(clients);
}

function function_9da76b0be4b2a2d4(currentfuel, maxfuel) {
  fuelpercentage = function_f1c6c7fa7cc97826(currentfuel, maxfuel);
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289(self);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setfuelpercent(fuelpercentage, occupants);
}

function function_272f4112182763bd(player, currentfuel, maxfuel) {
  fuelpercentage = function_f1c6c7fa7cc97826(currentfuel, maxfuel);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setfuelpercent(fuelpercentage, player);
}

function private function_f1c6c7fa7cc97826(currentfuel, maxfuel) {
  if(!isDefined(currentfuel)) {
    currentfuel = self.fuel;
  }

  if(!isDefined(maxfuel)) {
    maxfuel = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle(self.vehiclename).maxfuel;
  }

  if(maxfuel == -1) {
    return 100;
  }

  assertex(isDefined(currentfuel) && isDefined(maxfuel), "vehOmn_getFuelPercent: Called while self.fuel or (vehicle interact level data).maxFuel is undefined");
  return currentfuel / maxfuel * 100;
}

function vehomn_setfuelpercent(var_15174a10eca23d37, clients) {
  if(!isDefined(var_15174a10eca23d37)) {
    var_15174a10eca23d37 = 100;
  }

  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(client in clients) {
        if(isDefined(client) && isPlayer(client)) {
          client setclientomnvar("ui_veh_fuel_percent", int(var_15174a10eca23d37));
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients setclientomnvar("ui_veh_fuel_percent", int(var_15174a10eca23d37));
    }
  }
}

function vehomn_clearfuelpercent(clients) {}

function vehomn_showfuel(clients) {
  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(client in clients) {
        if(isDefined(client) && isPlayer(client)) {
          client setclientomnvar("ui_veh_show_fuel", 1);
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients setclientomnvar("ui_veh_show_fuel", 1);
    }
  }
}

function vehomn_hidefuel(clients) {}

function vehomn_clearshowfuel(clients) {}

function vehomn_setammo(vehicleref, ammoref, ammovalue, clients) {
  leveldataforvehicle = vehomn_getleveldataforvehicle(vehicleref);
  id = leveldataforvehicle.ammoids[ammoref];
  assertex(isDefined(id), "levelDataForVehicle for " + vehicleref + " failed to define an ID for ammoRef " + ammoref + ".");
  omnvar = undefined;

  switch (id) {
    case 0:
      omnvar = "ui_veh_ammo_0";
      break;
    case 1:
      omnvar = "ui_veh_ammo_1";
      break;
    case 2:
      omnvar = "ui_veh_ammo_2";
      break;
  }

  assertex(isDefined(omnvar), "ammoRef does not map to an omnvar.");

  if(!isDefined(ammovalue)) {
    ammovalue = -1;
  } else if(isstring(ammovalue) && ammovalue == "infinite") {
    ammovalue = -2;
  }

  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(client in clients) {
        if(isDefined(client) && isPlayer(client)) {
          client setclientomnvar(omnvar, ammovalue);
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients setclientomnvar(omnvar, ammovalue);
    }
  }
}

function vehomn_clearammo(vehicleref, ammoref, clients) {
  vehomn_setammo(vehicleref, ammoref, undefined, clients);
}

function vehomn_showammo(vehicleref, ammoref, ammovalue, clients) {
  assertex(isstring(ammovalue) || ammovalue != -1, "vehOmn_showAmmo cannot be called with a value of " + -1 + ".");
  vehomn_setammo(vehicleref, ammoref, ammovalue, clients);
}

function vehomn_hideammo(vehicleref, ammoref, clients) {
  vehomn_setammo(vehicleref, ammoref, -1, clients);
}

function vehomn_showwarning(warningref, clients, vehicleref) {
  leveldataforvehicle = vehomn_getleveldataforvehicle(vehicleref, 1);
  id = leveldataforvehicle.warningbits[warningref];
  assertex(id < 11, "vehOmn_showWarning called with warningRef index " + id + ". Should be below " + 11 + ".");

  if(isDefined(clients)) {
    var_721785e70a9bf412 = leveldataforvehicle.warningstartcallbacks[warningref];

    if(isarray(clients)) {
      foreach(client in clients) {
        if(isDefined(client) && isPlayer(client)) {
          client setclientomnvarbit("ui_veh_warning", id, 1);

          if(isDefined(var_721785e70a9bf412)) {
            thread[[var_721785e70a9bf412]](client, "ui_veh_warning" + "_omnvar_modified");
          }
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients setclientomnvarbit("ui_veh_warning", id, 1);

      if(isDefined(var_721785e70a9bf412)) {
        thread[[var_721785e70a9bf412]](clients, "ui_veh_warning" + "_omnvar_modified");
      }
    }
  }
}

function vehomn_hidewarning(warningref, clients, vehicleref) {
  leveldataforvehicle = vehomn_getleveldataforvehicle(vehicleref, 1);
  id = leveldataforvehicle.warningbits[warningref];
  assertex(id < 11, "vehOmn_showWarning called with warningRef index " + id + ". Should be below " + 11 + ".");

  if(isDefined(clients)) {
    warningendcallback = leveldataforvehicle.warningendcallbacks[warningref];

    if(isarray(clients)) {
      foreach(client in clients) {
        if(isDefined(client) && isPlayer(client)) {
          client setclientomnvarbit("ui_veh_warning", id, 0);

          if(isDefined(warningendcallback)) {
            thread[[warningendcallback]](client, "ui_veh_warning" + "_omnvar_modified");
          }
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients setclientomnvarbit("ui_veh_warning", id, 0);

      if(isDefined(warningendcallback)) {
        thread[[warningendcallback]](clients, "ui_veh_warning" + "_omnvar_modified");
      }
    }
  }
}

function vehomn_clearwarnings(clients, vehicleref) {
  if(isDefined(clients)) {
    leveldataforvehicle = undefined;

    if(isDefined(vehicleref)) {
      leveldataforvehicle = vehomn_getleveldataforvehicle(vehicleref, undefined, 1);
    }

    if(isarray(clients)) {
      foreach(client in clients) {
        if(isDefined(client) && isPlayer(client)) {
          client setclientomnvar("ui_veh_warning", 0);
          function_6f848816a946e419(client);

          if(isDefined(leveldataforvehicle)) {
            foreach(var_fdf4854fd7b654e7 in leveldataforvehicle.warningclearcallbacks) {
              if(isDefined(var_fdf4854fd7b654e7)) {
                thread[[var_fdf4854fd7b654e7]](client);
              }
            }
          }
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients setclientomnvar("ui_veh_warning", 0);
      function_6f848816a946e419(clients);

      if(isDefined(leveldataforvehicle)) {
        foreach(var_fdf4854fd7b654e7 in leveldataforvehicle.warningclearcallbacks) {
          if(isDefined(var_fdf4854fd7b654e7)) {
            thread[[var_fdf4854fd7b654e7]](clients);
          }
        }
      }
    }
  }
}

function function_6f848816a946e419(client) {
  if(soundexists("uin_veh_warning_low_fuel")) {
    client stoplocalsound("uin_veh_warning_low_fuel");
  }

  if(soundexists("uin_veh_warning_low_fuel_heli")) {
    client stoplocalsound("uin_veh_warning_low_fuel_heli");
  }

  if(soundexists("uin_veh_warning_out_of_fuel")) {
    client stoplocalsound("uin_veh_warning_out_of_fuel");
  }

  if(soundexists("uin_veh_warning_out_of_fuel_heli")) {
    client stoplocalsound("uin_veh_warning_out_of_fuel_heli");
  }

  if(soundexists("veh_warning_missile_locking")) {
    client stoplocalsound("veh_warning_missile_locking");
  }

  if(soundexists("veh_warning_missile_incoming")) {
    client stoplocalsound("veh_warning_missile_incoming");
  }
}

function vehomn_setrotation(vehicleref, rotationref, rotationvalue, clients) {
  leveldataforvehicle = vehomn_getleveldataforvehicle(vehicleref);
  id = leveldataforvehicle.rotationids[rotationref];
  assertex(isDefined(id), "levelDataForVehicle for " + vehicleref + " failed to define an ID for rotationRef " + rotationref + ".");
  omnvar = undefined;

  switch (id) {
    case 0:
      omnvar = "ui_veh_degrees_0";
      break;
    case 1:
      omnvar = "ui_veh_degrees_1";
      break;
  }

  assertex(isDefined(omnvar), "rotationRef does not map to an omnvar.");

  if(!isDefined(rotationvalue)) {
    rotationvalue = 0;
  }

  if(isDefined(clients)) {
    remainder = rotationvalue - floor(rotationvalue);

    if(remainder >= 0.5) {
      rotationvalue = ceil(rotationvalue);
    } else {
      rotationvalue = floor(rotationvalue);
    }

    if(isarray(clients)) {
      foreach(client in clients) {
        if(isDefined(client) && isPlayer(client)) {
          client setclientomnvar(omnvar, rotationvalue);
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients setclientomnvar(omnvar, rotationvalue);
    }
  }
}

function vehomn_clearrotation(vehicleref, rotationref, clients) {
  vehomn_setrotation(vehicleref, rotationref, undefined, clients);
}

function vehomn_showcontrols(clients) {
  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(client in clients) {
        if(isDefined(client) && isPlayer(client)) {
          client notify("vehOmn_modified_controls");
          client.vehomncontrols = "show";
          client setclientomnvar("ui_veh_controls", 1);
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients notify("vehOmn_modified_controls");
      clients.vehomncontrols = "show";
      clients setclientomnvar("ui_veh_controls", 1);
    }
  }
}

function vehomn_hidecontrols(clients) {
  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(client in clients) {
        if(isDefined(client) && isPlayer(client)) {
          client notify("vehOmn_modified_controls");
          client.vehomncontrols = "hide";
          client setclientomnvar("ui_veh_controls", 0);
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients notify("vehOmn_modified_controls");
      clients.vehomncontrols = "hide";
      clients setclientomnvar("ui_veh_controls", 0);
    }
  }
}

function vehomn_fadeoutcontrols(clients) {
  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(client in clients) {
        if(isDefined(client) && isPlayer(client)) {
          thread vehomn_fadeoutcontrolsforclient(client);
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      thread vehomn_fadeoutcontrolsforclient(clients);
    }
  }
}

function vehomn_fadeoutcontrolsforclient(client) {
  client endon("death_or_disconnect");
  client endon("vehOmn_modified_controls");

  if(!isDefined(client.vehomncontrols) || client.vehomncontrols != "hide" && client.vehomncontrols != "fadeOut") {
    client.vehomncontrols = "fadeOut";
    client setclientomnvar("ui_veh_controls", 2);
    wait 3;
    thread vehomn_hidecontrols(client);
  }
}

function vehomn_clearcontrols(clients) {
  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(client in clients) {
        if(isDefined(client) && isPlayer(client)) {
          client.vehomncontrols = undefined;
          client setclientomnvar("ui_veh_controls", 0);
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients setclientomnvar("ui_veh_controls", 0);
      clients.vehomncontrols = undefined;
    }
  }
}

function vehomn_controlsarefadedoutorhidden(client) {
  return !isDefined(client.vehomncontrols) || client.vehomncontrols == "fadeOut" || client.vehomncontrols == "hide";
}

function vehomn_getleveldata() {
  assertex(isDefined(level.vehicle), "vehOmn_getLevelData() called before vehicle_init().");
  assertex(isDefined(level.vehicle.omnvars), "vehOmn_getLevelData() called before vehOmn_init().");
  return level.vehicle.omnvars;
}

function vehomn_getleveldataforvehicle(vehicleref, create, var_6ecb77fd1f27c667) {
  if(istrue(create) && (!function_89dc39dc11f3988c(vehicleref) || !isDefined(function_29b4292c92443328(vehicleref).occupancy) || !isDefined(function_29b4292c92443328(vehicleref).occupancy.seatids))) {
    data = undefined;

    if(function_89dc39dc11f3988c(vehicleref)) {
      data = function_29b4292c92443328(vehicleref);
    } else {
      data = spawnStruct();
    }

    if(!isDefined(data.occupancy)) {
      data.occupancy = spawnStruct();
    }

    data.occupancy.seatids = [];
    data.occupancy.ammoids = [];
    data.occupancy.rotationids = [];
    data.occupancy.warningbits = [];
    data.occupancy.warningstartcallbacks = [];
    data.occupancy.warningendcallbacks = [];
    data.occupancy.warningclearcallbacks = [];
    data.occupancy.rotationrefsbyseatandweapon = [];
    data.occupancy.warningbits["burningDown"] = 1;
    data.occupancy.warningbits["missileLocking"] = 2;
    data.occupancy.warningbits["missileIncoming"] = 4;
    data.occupancy.warningbits["movementDisabled"] = 3;
    data.occupancy.warningbits["outOfFuel"] = 6;
    data.occupancy.warningbits["lowFuel"] = 5;
    data.occupancy.warningbits["BunkerBusterAttached"] = 7;
    data.occupancy.warningbits["shockStickAttached"] = 8;
    data.occupancy.warningbits["DDoSed"] = 9;
    data.occupancy.warningbits["locked"] = 10;
    level.var_a0b2c978ca57ffc5[vehicleref] = data;
  }

  if(function_89dc39dc11f3988c(vehicleref)) {
    return function_29b4292c92443328(vehicleref).occupancy;
  }
}

function vehomn_clearleveldataforvehicle(vehicleref, create, var_6ecb77fd1f27c667) {
  leveldataforvehicle = vehomn_getleveldataforvehicle(vehicleref, create, var_6ecb77fd1f27c667);

  if(isDefined(leveldataforvehicle)) {
    leveldataforvehicle.seatids = [];
    leveldataforvehicle.ammoids = [];
    leveldataforvehicle.rotationids = [];
    leveldataforvehicle.warningbits = [];
    leveldataforvehicle.warningstartcallbacks = [];
    leveldataforvehicle.warningendcallbacks = [];
    leveldataforvehicle.warningclearcallbacks = [];
    leveldataforvehicle.id = undefined;
  }

  return leveldataforvehicle;
}

function vehomn_clearall(clients, vehicleref) {
  if(isarray(clients)) {
    foreach(client in clients) {
      vehomn_clearallinternal(client, vehicleref);
    }

    return;
  }

  vehomn_clearallinternal(clients, vehicleref);
}

function private vehomn_clearallinternal(client, vehicleref) {
  if(isDefined(client) && isPlayer(client)) {
    client setclientomnvar("ui_veh_vehicle", -1);
    client setclientomnvar("ui_veh_current_seat", -1);
    client setclientomnvar("ui_veh_next_seat", -1);
    client setclientomnvar("ui_veh_occupant_0", -1);
    client setclientomnvar("ui_veh_occupant_1", -1);
    client setclientomnvar("ui_veh_occupant_2", -1);
    client setclientomnvar("ui_veh_occupant_3", -1);
    client setclientomnvar("ui_veh_occupant_4", -1);
    client setclientomnvar("ui_veh_occupant_5", -1);
    client setclientomnvar("ui_veh_occupant_6", -1);
    client setclientomnvar("ui_veh_health_percent", 0);
    client setclientomnvar("ui_veh_show_health", 0);
    client setclientomnvar("ui_veh_time_percent", 0);
    client setclientomnvar("ui_veh_show_time", 0);
    client setclientomnvar("ui_veh_fuel_percent", 100);
    client setclientomnvar("ui_veh_show_fuel", 0);
    client setclientomnvar("ui_veh_ammo_0", -1);
    client setclientomnvar("ui_veh_ammo_1", -1);
    vehomn_clearwarnings(client, vehicleref);
    client setclientomnvar("ui_veh_degrees_0", 0);
    client setclientomnvar("ui_veh_degrees_1", 0);
    vehomn_clearcontrols(client);
  }
}

function vehomn_updateomnvarsonseatenter(vehicle, var_fc7c7a874b43a31a, var_7558f98f3236963d, player) {
  vehomn_setvehicle(vehicle.vehiclename, player);
  vehomn_setcurrentseat(vehicle, var_7558f98f3236963d, player);
  var_94d4410a7169a784 = "uin_veh_warning_low_fuel";
  var_85dfce1880d8e71d = "uin_veh_warning_out_of_fuel";

  if(istrue(vehicle scripts\common\vehicle::ishelicopter())) {
    var_94d4410a7169a784 = "uin_veh_warning_low_fuel_heli";
    var_85dfce1880d8e71d = "uin_veh_warning_out_of_fuel_heli";
  }

  everyone = function_efa75aa7f0a1289(vehicle);

  if(isDefined(var_fc7c7a874b43a31a)) {
    vehomn_clearseatentity(vehicle.vehiclename, var_fc7c7a874b43a31a, everyone);
  } else {
    foreach(occupant in vehicle_occupancy_getalloccupants(vehicle)) {
      if(isDefined(occupant) && occupant != player) {
        vehomn_setseatentity(vehicle.vehiclename, seatid, occupant, player);
      }
    }
  }

  vehomn_setseatentity(vehicle.vehiclename, var_7558f98f3236963d, player, everyone);
  vehomn_updatenextseatomnvars(vehicle);

  if(vehicle.health < vehicle.maxhealth) {
    vehomn_updateomnvarsondamage(vehicle);
  }

  if(scripts\cp_mp\vehicles\vehicle_interact::function_a717a31ae35ba01c() && isDefined(vehicle.fuel)) {
    vehicle vehomn_showfuel(player);
    vehicle function_272f4112182763bd(player);
  }

  vehomn_showcontrols(player);
  veh_updateomnvarsperframeforclient(vehicle, player, var_7558f98f3236963d);
  leveldataforvehicle = vehomn_getleveldataforvehicle(vehicle.vehiclename);

  if(istrue(vehicle.var_15c05fe1c0f6de03)) {
    if(isDefined(leveldataforvehicle.warningbits["BunkerBusterAttached"])) {
      vehomn_showwarning("BunkerBusterAttached", player, vehicle.vehiclename);
    }
  }

  if(scripts\cp_mp\utility\weapon_utility::islockedonto(vehicle)) {
    if(isDefined(leveldataforvehicle.warningbits["missileLocking"])) {
      vehomn_showwarning("missileLocking", player, vehicle.vehiclename);
    }
  }

  if(scripts\cp_mp\utility\weapon_utility::hasincoming(vehicle)) {
    if(isDefined(leveldataforvehicle.warningbits["missileIncoming"])) {
      vehomn_showwarning("missileIncoming", player, vehicle.vehiclename);
    }
  }

  if(!scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_movementisallowed(vehicle)) {
    if(istrue(vehicle.islocked)) {
      if(isDefined(leveldataforvehicle.warningbits["locked"])) {
        vehomn_showwarning("locked", player, vehicle.vehiclename);
      }
    } else if(isDefined(vehicle.fuel) && vehicle.fuel <= 0 && isDefined(leveldataforvehicle.warningbits["outOfFuel"])) {
      vehomn_showwarning("outOfFuel", player, vehicle.vehiclename);
    } else if(isDefined(leveldataforvehicle.warningbits["movementDisabled"])) {
      vehomn_showwarning("movementDisabled", player, vehicle.vehiclename);
    }

    if(soundexists(var_85dfce1880d8e71d) && !isDefined(var_fc7c7a874b43a31a)) {
      player stoplocalsound(var_85dfce1880d8e71d);
      player playlocalsound(var_85dfce1880d8e71d);
    }
  }

  if(vehicle scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_isburningdown()) {
    if(isDefined(leveldataforvehicle.warningbits["burningDown"])) {
      vehomn_showwarning("burningDown", player, vehicle.vehiclename);
    }
  }

  if(isDefined(vehicle.fuel) && vehicle.fuel <= 25 && vehicle.fuel > 0) {
    if(isDefined(leveldataforvehicle.warningbits["lowFuel"])) {
      vehomn_showwarning("lowFuel", player, vehicle.vehiclename);

      if(soundexists(var_85dfce1880d8e71d) && !isDefined(var_fc7c7a874b43a31a)) {
        player stoplocalsound(var_94d4410a7169a784);
        player playlocalsound(var_94d4410a7169a784);
      }
    }
  }
}

function function_d2d9c09551d91164(vehicle, player) {
  if(getdvarint(@ "mgl", 0)) {
    return;
  }

  vehomn_setvehicle(vehicle.vehiclename, player);
  var_94d4410a7169a784 = "uin_veh_warning_low_fuel";
  var_85dfce1880d8e71d = "uin_veh_warning_out_of_fuel";

  foreach(occupant in vehicle_occupancy_getalloccupants(vehicle)) {
    if(isDefined(occupant) && occupant != player) {
      vehomn_setseatentity(vehicle.vehiclename, seatid, occupant, player);
    }
  }

  if(istrue(scripts\common\vehicle::ishelicopter())) {
    var_94d4410a7169a784 = "uin_veh_warning_low_fuel_heli";
    var_85dfce1880d8e71d = "uin_veh_warning_out_of_fuel_heli";
  }

  if(vehicle.health < vehicle.maxhealth) {
    vehomn_updateomnvarsondamage(vehicle);
  }

  if(scripts\cp_mp\vehicles\vehicle_interact::function_a717a31ae35ba01c() && isDefined(vehicle.fuel)) {
    vehicle vehomn_showfuel(player);
    vehicle function_272f4112182763bd(player);
  }

  leveldataforvehicle = vehomn_getleveldataforvehicle(vehicle.vehiclename);

  if(scripts\cp_mp\utility\weapon_utility::function_f18dbd353f3e1570(vehicle)) {
    if(isDefined(leveldataforvehicle.warningbits["missileLocking"])) {
      vehomn_showwarning("missileLocking", player, vehicle.vehiclename);
    }
  }

  if(scripts\cp_mp\utility\weapon_utility::islockedonto(vehicle)) {
    if(isDefined(leveldataforvehicle.warningbits["missileLocking"])) {
      vehomn_showwarning("missileLocking", player, vehicle.vehiclename);
    }
  }

  if(scripts\cp_mp\utility\weapon_utility::hasincoming(vehicle)) {
    if(isDefined(leveldataforvehicle.warningbits["missileIncoming"])) {
      vehomn_showwarning("missileIncoming", player, vehicle.vehiclename);
    }
  }

  if(!scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_movementisallowed(vehicle)) {
    if(istrue(vehicle.islocked)) {
      if(isDefined(leveldataforvehicle.warningbits["locked"])) {
        vehomn_showwarning("locked", player, vehicle.vehiclename);
      }
    } else if(isDefined(vehicle.fuel) && vehicle.fuel <= 0 && isDefined(leveldataforvehicle.warningbits["outOfFuel"])) {
      vehomn_showwarning("outOfFuel", player, vehicle.vehiclename);

      if(soundexists(var_85dfce1880d8e71d)) {
        player playlocalsound(var_85dfce1880d8e71d);
      }
    } else if(isDefined(leveldataforvehicle.warningbits["movementDisabled"])) {
      vehomn_showwarning("movementDisabled", player, vehicle.vehiclename);
    }
  }

  if(vehicle scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_isburningdown()) {
    if(isDefined(leveldataforvehicle.warningbits["burningDown"])) {
      vehomn_showwarning("burningDown", player, vehicle.vehiclename);
    }
  }

  if(isDefined(vehicle.fuel) && vehicle.fuel <= 25 && vehicle.fuel > 0) {
    if(isDefined(leveldataforvehicle.warningbits["lowFuel"])) {
      vehomn_showwarning("lowFuel", player, vehicle.vehiclename);

      if(soundexists(var_94d4410a7169a784)) {
        player playlocalsound(var_94d4410a7169a784);
      }
    }
  }
}

function vehomn_updateomnvarsonseatexit(vehicle, var_fc7c7a874b43a31a, var_7558f98f3236963d, player) {
  if(!isDefined(var_7558f98f3236963d)) {
    if(isDefined(var_fc7c7a874b43a31a)) {
      vehomn_clearall(player, vehicle.vehiclename);

      if(isDefined(vehicle)) {
        occupants = function_efa75aa7f0a1289(vehicle);
        vehomn_clearseatentity(vehicle.vehiclename, var_fc7c7a874b43a31a, occupants);
        vehomn_updatenextseatomnvars(vehicle);
      }
    }
  }
}

function function_5211953231a09ed5(vehicle, player) {
  vehomn_clearall(player, vehicle.vehiclename);
}

function vehomn_updateomnvarsondamage(vehicle, data) {
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289(vehicle, 0);

  if(!isDefined(data)) {
    healthpercent = int(clamp(vehicle.health / vehicle.maxhealth * 100, 0, 100));
  } else {
    healthpercent = int(clamp((vehicle.health - data.damage) / vehicle.maxhealth * 100, 0, 100));
  }

  vehomn_showhealth(occupants);
  vehomn_sethealthpercent(healthpercent, occupants);
}

function vehomn_updateomnvarsperframe(vehicle, data) {
  if(!isDefined(data)) {
    data = spawnStruct();
  }

  leveldataforvehicle = vehomn_getleveldataforvehicle(vehicle.vehiclename, undefined, 1);
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289(vehicle);

  if(isDefined(occupants) && isDefined(leveldataforvehicle)) {
    if(isDefined(occupants) && occupants.size > 0) {
      foreach(occupant in occupants) {
        if(isDefined(occupant) && isPlayer(occupant) && occupant scripts\cp_mp\utility\player_utility::_isalive()) {
          veh_updateomnvarsperframeforclient(vehicle, occupant, seatid, data);
        }
      }
    }
  }
}

function veh_updateomnvarsperframeforclient(vehicle, client, seatid, data) {
  if(!isDefined(seatid)) {
    seatid = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(vehicle, client);
  }

  assertex(isDefined(seatid), "veh_updateOmnvarsPerFrameForClient could not find a seatID for client " + client getentitynumber() + ".");
  vehomn_updaterotationomnvarsperframeforclient(vehicle, client, seatid, data);
}

function vehomn_updatenextseatomnvars(vehicle) {
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(vehicle);

  foreach(occupant in occupants) {
    var_9b1113f768b290d8 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getnextavailableseat(vehicle, occupant, seatid);
    vehomn_setnextseat(vehicle.vehiclename, var_9b1113f768b290d8, occupant);
  }
}

function vehomn_updaterotationomnvarsperframeforclient(vehicle, client, seatid, data) {
  leveldataforvehicle = vehomn_getleveldataforvehicle(vehicle.vehiclename);

  if(leveldataforvehicle.rotationrefsbyseatandweapon.size > 0 && isDefined(leveldataforvehicle.rotationrefsbyseatandweapon[seatid])) {
    usingcamera = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_isdriverseat(vehicle, seatid);
    leveldataforseat = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(vehicle.vehiclename, seatid);

    if(usingcamera) {
      if(isDefined(vehicle.objweapon)) {
        rotationref = leveldataforvehicle.rotationrefsbyseatandweapon[seatid][vehicle.objweapon.basename];

        if(isDefined(rotationref)) {
          var_451362a0c7f69e04 = invertangles(client getplayerangles());
          angles = vehicle.angles;
          entangles = combineangles(var_451362a0c7f69e04, angles);
          entrotation = angleclamp(entangles[1]);
          vehomn_setrotation(vehicle.vehiclename, rotationref, entrotation, client);
        }
      }
    }

    anglesarr = vehomn_getrotationentangles(vehicle, data);

    if(isDefined(anglesarr)) {
      foreach(rotationref in leveldataforvehicle.rotationrefsbyseatandweapon[seatid]) {
        entangles = anglesarr[weaponname];

        if(isDefined(entangles)) {
          entrotation = angleclamp(entangles[1]);
          vehomn_setrotation(vehicle.vehiclename, rotationref, entrotation, client);
        }
      }
    }
  }
}

function vehomn_getrotationentangles(vehicle, data) {
  if(isDefined(data) && isDefined(data.localangles)) {
    return data.rotationentangles;
  }

  leveldataforvehicle = vehomn_getleveldataforvehicle(vehicle function_d93ec4635290febd(), 1);
  ents = scripts\cp_mp\vehicles\vehicle::vehicle_getturrets(vehicle);

  if(isDefined(leveldataforvehicle.mainturretweapon) && isDefined(vehicle gettagorigin("tag_flash"))) {
    ents[leveldataforvehicle.mainturretweapon] = vehicle;
  }

  if(isDefined(ents) && ents.size > 0) {
    entangles = [];
    var_3199bd878b193472 = invertangles(vehicle.angles);

    foreach(ent in ents) {
      entangles[weaponname] = combineangles(var_3199bd878b193472, ent gettagangles("tag_flash"));
    }

    if(isDefined(data)) {
      data.rotationentangles = entangles;
    }

    return entangles;
  }

  return undefined;
}