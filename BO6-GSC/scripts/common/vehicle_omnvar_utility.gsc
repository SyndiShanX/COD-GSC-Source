/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\vehicle_omnvar_utility.gsc
*****************************************************/

#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\engine\utility;
#namespace vehicle_omnvar;

function set_vehicle(vehicleref, clients) {
  leveldataforvehicle = get_data(vehicleref);
  id = undefined;

  if(getdvarint(@ "hash_dc6d2fe87aa001f", 0) == 0) {
    id = leveldataforvehicle.id;
  } else if(level.projectbundle.var_53c4124af039142e) {
    id = function_43b5ed5a14a56573(#"vehicle", vehicleref) ?? leveldataforvehicle.id;
  } else {
    name = vehicle::function_451bd53633bae879(vehicleref);
    id = function_43b5ed5a14a56573(#"scriptbundle_vehiclebundle", name) ?? leveldataforvehicle.id;
  }

  assert(isDefined(id), "<dev string:x24>" + getxhashsourcename(vehicleref) + "<dev string:x40>");

  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(client in clients) {
        if(isPlayer(client)) {
          client function_476aa03004b524d4("ui_veh_vehicle", id);
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients function_476aa03004b524d4("ui_veh_vehicle", id);
    }
  }
}

function function_ee70edd4b038cf14(vehicle, seatref, client) {
  if(!isDefined(client)) {
    return;
  }

  vehicleref = vehicle vehicle::get_ref();
  id = -1;

  if(isDefined(vehicleref)) {
    leveldataforvehicle = get_data(vehicleref);

    if(isDefined(seatref)) {
      id = leveldataforvehicle.seatids[seatref];

      if((leveldataforvehicle.hasdoors || leveldataforvehicle.canleanout) && seatref != "gunner" && vehicle vehicle_damage::function_e8fd01c9b2bad245(seatref)) {
        id |= 16;
      }

      assert(isDefined(id), "<dev string:x24>" + vehicle.vehiclename + "<dev string:x5c>" + seatref + "<dev string:x81>");
    }
  }

  client setclientomnvar("ui_veh_current_seat", id);
}

function function_4b83df64697b99ce(vehicleref, seatref, client) {
  if(!isDefined(client)) {
    return;
  }

  id = -1;

  if(isDefined(seatref)) {
    leveldataforvehicle = get_data(vehicleref);
    id = leveldataforvehicle.seatids[seatref];
    assert(isDefined(id), "<dev string:x24>" + getxhashsourcename(vehicleref) + "<dev string:x5c>" + seatref + "<dev string:x81>");
  }

  client function_476aa03004b524d4("ui_veh_next_seat", id);
}

function function_c237260b420cba80(vehicleref, seatref, seatentity, clients) {
  id = -1;

  if(isDefined(vehicleref)) {
    leveldataforvehicle = get_data(vehicleref);

    if(isDefined(seatref)) {
      id = leveldataforvehicle.seatids[seatref];
      assert(isDefined(id), "<dev string:x24>" + getxhashsourcename(vehicleref) + "<dev string:x5c>" + seatref + "<dev string:x81>");
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

  assert(isDefined(omnvar), "<dev string:x86>");
  seatentityid = -1;

  if(isDefined(seatentity)) {
    seatentityid = seatentity getentitynumber();
  }

  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(client in clients) {
        if(isPlayer(client)) {
          client function_476aa03004b524d4(omnvar, seatentityid);
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients function_476aa03004b524d4(omnvar, seatentityid);
    }
  }
}

function function_6fccbdc0754fe059(vehicleref, seatref, clients) {
  function_c237260b420cba80(vehicleref, seatref, undefined, clients);
}

function set_health_percent(healthpercentvalue, clients) {
  if(!isDefined(healthpercentvalue)) {
    healthpercentvalue = 0;
  }

  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(client in clients) {
        if(isPlayer(client)) {
          client setclientomnvar("ui_veh_health_percent", int(healthpercentvalue));
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients setclientomnvar("ui_veh_health_percent", int(healthpercentvalue));
    }
  }
}

function function_daae9fe4c46822c8(clients) {
  set_health_percent(undefined, clients);
}

function show_health(clients) {
  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(client in clients) {
        if(isPlayer(client)) {
          client function_476aa03004b524d4("ui_veh_show_health", 1);
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients function_476aa03004b524d4("ui_veh_show_health", 1);
    }
  }
}

function hide_health(clients) {
  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(client in clients) {
        if(isPlayer(client)) {
          client function_476aa03004b524d4("ui_veh_show_health", 0);
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients function_476aa03004b524d4("ui_veh_show_health", 0);
    }
  }
}

function clear_show_health(clients) {
  if(false) {
    show_health(clients);
    return;
  }

  hide_health(clients);
}

function function_a7d2d06e335799fc(timepercentvalue, clients) {
  if(!isDefined(timepercentvalue)) {
    timepercentvalue = 0;
  }

  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(client in clients) {
        if(isPlayer(client)) {
          client function_476aa03004b524d4("ui_veh_time_percent", int(timepercentvalue));
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients function_476aa03004b524d4("ui_veh_time_percent", int(timepercentvalue));
    }
  }
}

function function_8d88df6bc31d0783(clients) {
  function_a7d2d06e335799fc(undefined, clients);
}

function show_time(clients) {
  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(client in clients) {
        if(isPlayer(client)) {
          client function_476aa03004b524d4("ui_veh_show_time", 1);
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients function_476aa03004b524d4("ui_veh_show_time", 1);
    }
  }
}

function hide_time(clients) {
  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(client in clients) {
        if(isPlayer(client)) {
          client function_476aa03004b524d4("ui_veh_show_time", 0);
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients function_476aa03004b524d4("ui_veh_show_time", 0);
    }
  }
}

function clear_show_time(clients) {
  if(false) {
    show_time(clients);
    return;
  }

  hide_time(clients);
}

function function_9f4759fcb3acdc4(currentfuel, maxfuel) {
  fuelpercentage = function_cf5f7fbcc73a8f0d(currentfuel, maxfuel);
  occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5(self);
  function_d6d4afa9f4865e61(fuelpercentage, occupants);
}

function function_20347e94284fa3ed(player, currentfuel, maxfuel) {
  fuelpercentage = function_cf5f7fbcc73a8f0d(currentfuel, maxfuel);
  function_d6d4afa9f4865e61(fuelpercentage, player);
}

function private function_cf5f7fbcc73a8f0d(currentfuel, maxfuel) {
  if(!isDefined(currentfuel)) {
    currentfuel = self.fuel;
  }

  if(!isDefined(maxfuel)) {
    maxfuel = vehicle_interact::function_92f7f63d74bc91bc();
  }

  if(maxfuel == -1) {
    return 100;
  }

  assert(isDefined(currentfuel) && isDefined(maxfuel), "<dev string:xac>");
  return currentfuel / maxfuel * 100;
}

function function_d6d4afa9f4865e61(var_6779d30d1fcfe10, clients) {
  if(!isDefined(var_6779d30d1fcfe10)) {
    var_6779d30d1fcfe10 = 100;
  }

  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(client in clients) {
        if(isPlayer(client)) {
          client function_476aa03004b524d4("ui_veh_fuel_percent", int(var_6779d30d1fcfe10));
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients function_476aa03004b524d4("ui_veh_fuel_percent", int(var_6779d30d1fcfe10));
    }
  }
}

function set_ammo(vehicleref, ammoref, ammovalue, clients) {
  leveldataforvehicle = get_data(vehicleref);
  id = leveldataforvehicle.ammoids[ammoref];
  assert(isDefined(id), "<dev string:x24>" + getxhashsourcename(vehicleref) + "<dev string:x113>" + ammoref + "<dev string:x81>");
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

  assert(isDefined(omnvar), "<dev string:x13b>");

  if(!isDefined(ammovalue)) {
    ammovalue = -1;
  } else if(isstring(ammovalue) && ammovalue == "infinite") {
    ammovalue = -2;
  }

  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(client in clients) {
        if(isPlayer(client)) {
          client function_476aa03004b524d4(omnvar, ammovalue);
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients function_476aa03004b524d4(omnvar, ammovalue);
    }
  }
}

function clear_ammo(vehicleref, ammoref, clients) {
  set_ammo(vehicleref, ammoref, undefined, clients);
}

function show_ammo(vehicleref, ammoref, ammovalue, clients) {
  assert(isstring(ammovalue) || ammovalue != -1, "<dev string:x161>" + -1 + "<dev string:x81>");
  set_ammo(vehicleref, ammoref, ammovalue, clients);
}

function hide_ammo(vehicleref, ammoref, clients) {
  set_ammo(vehicleref, ammoref, -1, clients);
}

function show_warning(warningref, clients, vehicleref) {
  leveldataforvehicle = get_data(vehicleref, 1);
  id = leveldataforvehicle.warningbits[warningref];
  assert(id < 12, "<dev string:x196>" + id + "<dev string:x1ca>" + 12 + "<dev string:x81>");

  if(isDefined(clients)) {
    warningstartcallback = leveldataforvehicle.warningstartcallbacks[warningref];

    if(isarray(clients)) {
      foreach(client in clients) {
        if(isPlayer(client)) {
          client setclientomnvarbit("ui_veh_warning", id, 1);

          if(isDefined(warningstartcallback)) {
            thread[[warningstartcallback]](client, "ui_veh_warning" + "_omnvar_modified");
          }
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients setclientomnvarbit("ui_veh_warning", id, 1);

      if(isDefined(warningstartcallback)) {
        thread[[warningstartcallback]](clients, "ui_veh_warning" + "_omnvar_modified");
      }
    }
  }
}

function hide_warning(warningref, clients, vehicleref) {
  leveldataforvehicle = get_data(vehicleref, 1);
  id = leveldataforvehicle.warningbits[warningref];
  assert(id < 12, "<dev string:x196>" + id + "<dev string:x1ca>" + 12 + "<dev string:x81>");

  if(isDefined(clients)) {
    warningendcallback = leveldataforvehicle.warningendcallbacks[warningref];

    if(isarray(clients)) {
      foreach(client in clients) {
        if(isPlayer(client)) {
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

function clear_warnings(clients, vehicleref) {
  if(isDefined(clients)) {
    leveldataforvehicle = undefined;

    if(isDefined(vehicleref)) {
      leveldataforvehicle = get_data(vehicleref, undefined, 1);
    }

    if(isarray(clients)) {
      foreach(client in clients) {
        if(isPlayer(client)) {
          client setclientomnvar("ui_veh_warning", 0);
          function_1a352107e1a26fb2(client);

          if(isDefined(leveldataforvehicle)) {
            foreach(warningclearcallback in leveldataforvehicle.warningclearcallbacks) {
              if(isDefined(warningclearcallback)) {
                thread[[warningclearcallback]](client);
              }
            }
          }
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients setclientomnvar("ui_veh_warning", 0);
      function_1a352107e1a26fb2(clients);

      if(isDefined(leveldataforvehicle)) {
        foreach(warningclearcallback in leveldataforvehicle.warningclearcallbacks) {
          if(isDefined(warningclearcallback)) {
            thread[[warningclearcallback]](clients);
          }
        }
      }
    }
  }
}

function function_1a352107e1a26fb2(client) {
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

function set_rotation(vehicleref, rotationref, rotationvalue, clients) {
  leveldataforvehicle = get_data(vehicleref);
  id = leveldataforvehicle.rotationids[rotationref];
  assert(isDefined(id), "<dev string:x24>" + getxhashsourcename(vehicleref) + "<dev string:x1e0>" + rotationref + "<dev string:x81>");
  omnvar = undefined;

  switch (id) {
    case 0:
      omnvar = "ui_veh_degrees_0";
      break;
    case 1:
      omnvar = "ui_veh_degrees_1";
      break;
  }

  assert(isDefined(omnvar), "<dev string:x20c>");

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
        if(isPlayer(client)) {
          client function_476aa03004b524d4(omnvar, rotationvalue);
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      clients function_476aa03004b524d4(omnvar, rotationvalue);
    }
  }
}

function clear_rotation(vehicleref, rotationref, clients) {
  set_rotation(vehicleref, rotationref, undefined, clients);
}

function show_controls(clients) {
  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(client in clients) {
        if(isPlayer(client)) {
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

function hide_controls(clients) {
  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(client in clients) {
        if(isPlayer(client)) {
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

function fade_out_controls(clients) {
  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(client in clients) {
        if(isPlayer(client)) {
          thread function_96ae647221cfe804(client);
        }
      }

      return;
    }

    if(isPlayer(clients)) {
      thread function_96ae647221cfe804(clients);
    }
  }
}

function function_96ae647221cfe804(client) {
  client endon("death_or_disconnect");
  client endon("vehOmn_modified_controls");

  if(!isDefined(client.vehomncontrols) || client.vehomncontrols != "hide" && client.vehomncontrols != "fadeOut") {
    client.vehomncontrols = "fadeOut";
    client setclientomnvar("ui_veh_controls", 2);
    wait 3;
    thread hide_controls(client);
  }
}

function clear_controls(clients) {
  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(client in clients) {
        if(isPlayer(client)) {
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

function function_3a46307fb9c3a02(client) {
  return !isDefined(client.vehomncontrols) || client.vehomncontrols == "fadeOut" || client.vehomncontrols == "hide";
}

function get_data(vehicleref, create, var_e6c819f806ce2c86) {
  if(create && (!vehicle::has_data(vehicleref) || !isDefined(vehicle::get_data(vehicleref).occupancy) || !isDefined(vehicle::get_data(vehicleref).occupancy.seatids))) {
    data = undefined;

    if(vehicle::has_data(vehicleref)) {
      data = vehicle::get_data(vehicleref);
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
    data.occupancy.warningbits["broken"] = 11;
    vehicle::add_data(vehicleref, data);
  }

  if(vehicle::has_data(vehicleref)) {
    return vehicle::get_data(vehicleref).occupancy;
  }
}

function clear_data(vehicleref, create, var_e6c819f806ce2c86) {
  leveldataforvehicle = get_data(vehicleref, create, var_e6c819f806ce2c86);

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

function clear_all(clients, vehicleref) {
  if(isarray(clients)) {
    foreach(client in clients) {
      clear_all_internal(client, vehicleref);
    }

    return;
  }

  clear_all_internal(clients, vehicleref);
}

function private clear_all_internal(client, vehicleref) {
  if(isPlayer(client)) {
    client setclientomnvar("ui_veh_vehicle", -1);
    client setclientomnvar("ui_veh_current_seat", -1);
    client function_476aa03004b524d4("ui_veh_next_seat", -1);
    client function_476aa03004b524d4("ui_veh_occupant_0", -1);
    client function_476aa03004b524d4("ui_veh_occupant_1", -1);
    client function_476aa03004b524d4("ui_veh_occupant_2", -1);
    client function_476aa03004b524d4("ui_veh_occupant_3", -1);
    client function_476aa03004b524d4("ui_veh_occupant_4", -1);
    client function_476aa03004b524d4("ui_veh_occupant_5", -1);
    client function_476aa03004b524d4("ui_veh_occupant_6", -1);
    client setclientomnvar("ui_veh_health_percent", 0);
    client function_476aa03004b524d4("ui_veh_show_health", 0);
    client function_476aa03004b524d4("ui_veh_time_percent", 0);
    client function_476aa03004b524d4("ui_veh_show_time", 0);
    client function_476aa03004b524d4("ui_veh_fuel_percent", 100);
    client function_476aa03004b524d4("ui_veh_ammo_0", -1);
    client function_476aa03004b524d4("ui_veh_ammo_1", -1);
    clear_warnings(client, vehicleref);
    client function_476aa03004b524d4("ui_veh_degrees_0", 0);
    client function_476aa03004b524d4("ui_veh_degrees_1", 0);
    clear_controls(client);
  }
}

function function_e0aa0be8e3297e0d(vehicle, oldseatid, newseatid, player) {
  set_vehicle(vehicle vehicle::get_ref(), player);
  function_ee70edd4b038cf14(vehicle, newseatid, player);
  lowfuelsound = "uin_veh_warning_low_fuel";
  outoffuelsound = "uin_veh_warning_out_of_fuel";

  if(vehicle vehicle::ishelicopter()) {
    lowfuelsound = "uin_veh_warning_low_fuel_heli";
    outoffuelsound = "uin_veh_warning_out_of_fuel_heli";
  }

  occupants = vehicle_occupancy::get_all_occupants(vehicle);

  if(isDefined(oldseatid)) {
    function_6fccbdc0754fe059(vehicle vehicle::get_ref(), oldseatid, occupants);
  } else {
    foreach(seatid, occupant in occupants) {
      if(isDefined(occupant) && occupant != player) {
        function_c237260b420cba80(vehicle vehicle::get_ref(), seatid, occupant, player);
      }
    }
  }

  function_c237260b420cba80(vehicle vehicle::get_ref(), newseatid, player, occupants);
  function_2c9ed144f176f7d8(vehicle);

  if(vehicle.health < vehicle.maxhealth) {
    function_ca8a66bb3a611610(vehicle);
  }

  if(vehicle_interact::fuel_is_enabled() && isDefined(vehicle.fuel)) {
    vehicle function_20347e94284fa3ed(player);
  }

  show_controls(player);
  function_f5732979a745bce0(vehicle, player, newseatid);
  leveldataforvehicle = get_data(vehicle vehicle::get_ref());

  if(vehicle.var_4c567014a63269e) {
    if(isDefined(leveldataforvehicle.warningbits["BunkerBusterAttached"])) {
      show_warning("BunkerBusterAttached", player, vehicle vehicle::get_ref());
    }
  }

  if(utility::callsharedfunc(#"weapons", #"islockedonto", vehicle)) {
    if(isDefined(leveldataforvehicle.warningbits["missileLocking"])) {
      show_warning("missileLocking", player, vehicle vehicle::get_ref());
    }
  }

  if(utility::callsharedfunc(#"weapons", #"hasincoming", vehicle)) {
    if(isDefined(leveldataforvehicle.warningbits["missileIncoming"])) {
      show_warning("missileIncoming", player, vehicle vehicle::get_ref());
    }
  }

  if(!vehicle_occupancy::function_8e768221dfa2f8a9(vehicle)) {
    if(vehicle vehicle_occupancy::is_locked()) {
      if(isDefined(leveldataforvehicle.warningbits["locked"])) {
        show_warning("locked", player, vehicle vehicle::get_ref());
      }
    } else if(vehicle.isbroken) {
      if(isDefined(leveldataforvehicle.warningbits["broken"])) {
        show_warning("broken", player, vehicle vehicle::get_ref());
      }
    } else if(vehicle utility::callsharedfunc(#"emp", #"is_empd") && !isDefined(vehicle.ksempd)) {
      show_warning("DDoSed", player, vehicle vehicle::get_ref());
    } else if(vehicle.fuel <= 0 && isDefined(leveldataforvehicle.warningbits["outOfFuel"])) {
      show_warning("outOfFuel", player, vehicle vehicle::get_ref());
    } else if(isDefined(leveldataforvehicle.warningbits["movementDisabled"]) && !isDefined(vehicle.ksempd)) {
      show_warning("movementDisabled", player, vehicle vehicle::get_ref());
    }

    if(soundexists(outoffuelsound) && !isDefined(oldseatid)) {
      player stoplocalsound(outoffuelsound);
      player playlocalsound(outoffuelsound);
    }
  }

  if(vehicle vehicle_damage::function_b06b0d26ac291477()) {
    if(isDefined(leveldataforvehicle.warningbits["burningDown"])) {
      show_warning("burningDown", player, vehicle vehicle::get_ref());
    }
  }

  if(vehicle.fuel <= 25 && vehicle.fuel > 0) {
    if(isDefined(leveldataforvehicle.warningbits["lowFuel"])) {
      show_warning("lowFuel", player, vehicle vehicle::get_ref());

      if(soundexists(outoffuelsound) && !isDefined(oldseatid)) {
        player stoplocalsound(lowfuelsound);
        player playlocalsound(lowfuelsound);
      }
    }
  }
}

function function_fc8e70f33a941b3d(vehicle, player) {
  if(getdvarint(@ "mgl", 0)) {
    return;
  }

  set_vehicle(vehicle vehicle::get_ref(), player);
  lowfuelsound = "uin_veh_warning_low_fuel";
  outoffuelsound = "uin_veh_warning_out_of_fuel";

  if(vehicle::ishelicopter()) {
    lowfuelsound = "uin_veh_warning_low_fuel_heli";
    outoffuelsound = "uin_veh_warning_out_of_fuel_heli";
  }

  if(vehicle.health < vehicle.maxhealth) {
    function_ca8a66bb3a611610(vehicle);
  }

  if(vehicle_interact::fuel_is_enabled() && isDefined(vehicle.fuel)) {
    vehicle function_20347e94284fa3ed(player);
  }

  leveldataforvehicle = get_data(vehicle vehicle::get_ref());

  if(utility::callsharedfunc(#"weapons", #"hasBunkerBustersAttached", vehicle)) {
    if(isDefined(leveldataforvehicle.warningbits["missileLocking"])) {
      show_warning("missileLocking", player, vehicle vehicle::get_ref());
    }
  }

  if(utility::callsharedfunc(#"weapons", #"islockedonto", vehicle)) {
    if(isDefined(leveldataforvehicle.warningbits["missileLocking"])) {
      show_warning("missileLocking", player, vehicle vehicle::get_ref());
    }
  }

  if(utility::callsharedfunc(#"weapons", #"hasincoming", vehicle)) {
    if(isDefined(leveldataforvehicle.warningbits["missileIncoming"])) {
      show_warning("missileIncoming", player, vehicle vehicle::get_ref());
    }
  }

  if(!vehicle_occupancy::function_8e768221dfa2f8a9(vehicle)) {
    if(vehicle.fuel <= 0 && isDefined(leveldataforvehicle.warningbits["outOfFuel"])) {
      show_warning("outOfFuel", player, vehicle vehicle::get_ref());

      if(soundexists(outoffuelsound)) {
        player playlocalsound(outoffuelsound);
      }
    } else if(isDefined(leveldataforvehicle.warningbits["movementDisabled"])) {
      show_warning("movementDisabled", player, vehicle vehicle::get_ref());
    }
  }

  if(vehicle vehicle_damage::function_b06b0d26ac291477()) {
    if(isDefined(leveldataforvehicle.warningbits["burningDown"])) {
      show_warning("burningDown", player, vehicle vehicle::get_ref());
    }
  }

  if(vehicle.fuel <= 25 && vehicle.fuel > 0) {
    if(isDefined(leveldataforvehicle.warningbits["lowFuel"])) {
      show_warning("lowFuel", player, vehicle vehicle::get_ref());

      if(soundexists(lowfuelsound)) {
        player playlocalsound(lowfuelsound);
      }
    }
  }
}

function function_1f2d7e52383cc345(vehicle, oldseatid, newseatid, player) {
  if(!isDefined(newseatid)) {
    if(isDefined(oldseatid)) {
      clear_all(player, vehicle vehicle::get_ref());

      if(isDefined(vehicle)) {
        occupants = vehicle_occupancy::get_all_occupants(vehicle);
        function_6fccbdc0754fe059(vehicle vehicle::get_ref(), oldseatid, occupants);
        function_2c9ed144f176f7d8(vehicle);
      }
    }
  }
}

function function_a9e60d4916911fc6(vehicle, player) {
  clear_all(player, vehicle vehicle::get_ref());
}

function function_ca8a66bb3a611610(vehicle, data) {
  if(!isDefined(vehicle.maxhealth)) {
    assertmsg("<dev string:x236>");
    return;
  }

  occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5(vehicle, 0);

  if(vehicle.maxhealth == 0) {
    healthpercent = 0;
  } else if(!isDefined(data.damage)) {
    healthpercent = int(clamp(vehicle.health / vehicle.maxhealth * 100, 0, 100));
  } else if(utility::issp()) {
    healthpercent = int(clamp(vehicle.health / vehicle.maxhealth * 100, 0, 100));
  } else {
    healthpercent = int(clamp((vehicle.health - data.damage) / vehicle.maxhealth * 100, 0, 100));
  }

  show_health(occupants);
  set_health_percent(healthpercent, occupants);
}

function function_b7e5944543c97cfa(vehicle, data) {
  if(!isDefined(data)) {
    data = spawnStruct();
  }

  leveldataforvehicle = get_data(vehicle vehicle::get_ref(), undefined, 1);
  occupants = vehicle_occupancy::get_all_occupants(vehicle);

  if(isDefined(occupants) && isDefined(leveldataforvehicle)) {
    if(isDefined(occupants) && occupants.size > 0) {
      foreach(seatid, occupant in occupants) {
        if(isPlayer(occupant) && occupant utility::callsharedfunc(#"player", #"playerisalive")) {
          function_f5732979a745bce0(vehicle, occupant, seatid, data);
        }
      }
    }
  }
}

function function_f5732979a745bce0(vehicle, client, seatid, data) {
  if(!isDefined(seatid)) {
    seatid = vehicle_occupancy::function_338f50d73ebf6fe4(vehicle, client);
  }

  assert(isDefined(seatid), "<dev string:x289>" + client getentitynumber() + "<dev string:x81>");
  function_ac478526d789c733(vehicle, client, seatid, data);
}

function function_2c9ed144f176f7d8(vehicle) {
  occupants = vehicle_occupancy::get_all_occupants(vehicle);

  foreach(seatid, occupant in occupants) {
    nextseatid = vehicle_occupancy::function_79f80964bb18e6c6(vehicle, occupant, seatid);
    function_4b83df64697b99ce(vehicle vehicle::get_ref(), nextseatid, occupant);
  }
}

function function_ac478526d789c733(vehicle, client, seatid, data) {
  leveldataforvehicle = get_data(vehicle vehicle::get_ref());

  if(leveldataforvehicle.rotationrefsbyseatandweapon.size > 0 && isDefined(leveldataforvehicle.rotationrefsbyseatandweapon[seatid])) {
    if(vehicle_occupancy::function_d4f0603190ab379f(vehicle, seatid)) {
      if(isDefined(vehicle.objweapon)) {
        rotationref = leveldataforvehicle.rotationrefsbyseatandweapon[seatid][vehicle.objweapon.basename];

        if(isDefined(rotationref)) {
          invertedangles = invertangles(client getplayerangles());
          angles = vehicle.angles;
          entangles = combineangles(invertedangles, angles);
          entrotation = angleclamp(entangles[1]);
          set_rotation(vehicle vehicle::get_ref(), rotationref, entrotation, client);
        }
      }
    }

    anglesarr = function_958654161cd92cc8(vehicle, data);

    if(isDefined(anglesarr)) {
      foreach(weaponname, rotationref in leveldataforvehicle.rotationrefsbyseatandweapon[seatid]) {
        entangles = anglesarr[weaponname];

        if(isDefined(entangles)) {
          entrotation = angleclamp(entangles[1]);
          set_rotation(vehicle vehicle::get_ref(), rotationref, entrotation, client);
        }
      }
    }
  }
}

function function_958654161cd92cc8(vehicle, data) {
  if(isDefined(data) && isDefined(data.localangles)) {
    return data.rotationentangles;
  }

  leveldataforvehicle = get_data(vehicle vehicle::get_ref(), 1);
  ents = vehicle::get_turrets(vehicle);

  if(isDefined(leveldataforvehicle.mainturretweapon) && isDefined(vehicle gettagorigin("tag_flash"))) {
    ents[leveldataforvehicle.mainturretweapon] = vehicle;
  }

  if(isDefined(ents) && ents.size > 0) {
    entangles = [];
    vehicleanglesinverted = invertangles(vehicle.angles);

    foreach(weaponname, ent in ents) {
      entangles[weaponname] = combineangles(vehicleanglesinverted, ent gettagangles("tag_flash"));
    }

    if(isDefined(data)) {
      data.rotationentangles = entangles;
    }

    return entangles;
  }

  return undefined;
}

function private function_476aa03004b524d4(omnvar, value) {
  if(self function_5c766d1d0140b86(omnvar)) {
    self setclientomnvar(omnvar, value);
  }
}