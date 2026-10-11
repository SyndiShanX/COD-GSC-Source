/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\vehicles\vehicle_occupancy.gsc
***********************************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_code;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\team_utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\vehicles\customization\battle_tracks;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_compass;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_dlog;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace vehicle_occupancy;

function vehicle_occupancy_getleveldataforvehicle(vehiclename, create) {
  if(istrue(create) && (!function_89dc39dc11f3988c(vehiclename) || !isDefined(function_29b4292c92443328(vehiclename).occupancy))) {
    data = undefined;

    if(!function_89dc39dc11f3988c(vehiclename)) {
      data = spawnStruct();
    } else {
      data = function_29b4292c92443328(vehiclename);
    }

    data.occupancy = spawnStruct();
    data.occupancy.seatdata = [];
    data.occupancy.restrictions = [];
    data.occupancy.damagemodifier = -1;
    data.occupancy.camera = "none";
    data.occupancy.threatbiasgroup = "Level_Vehicle";
    data.occupancy.exitextents = [];
    data.occupancy.exitoffsets = [];
    data.occupancy.exitdirections = [];
    data.occupancy.damagefeedbackgrouplight = "driver";
    data.occupancy.damagefeedbackgroupheavy = "all";
    level.var_a0b2c978ca57ffc5[vehiclename] = data;
  }

  if(function_89dc39dc11f3988c(vehiclename)) {
    return function_29b4292c92443328(vehiclename).occupancy;
  }
}

function private function_c9b87beb89ec12e2(player, vehicle, exitvehicle) {
  if(isDefined(player)) {
    if(player isvehicleactive()) {
      player leavevehicle(0, exitvehicle);
    }

    assert(!player isvehicleactive());
  }
}

function vehicle_occupancy_getleveldataforseat(vehiclename, seatid, create) {
  return vehicle_occupancy_getleveldataforvehicle(vehiclename).seatdata[seatid];
}

function vehicle_occupancy_registerinstance(vehicle) {
  vehicle.occupants = [];
  vehicle.occupantsreserving = [];
  vehicle.isempty = 1;

  leveldata = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldata();
  leveldata.debuginstances = array_removeundefined(leveldata.debuginstances);
  leveldata.debuginstances = array_add(leveldata.debuginstances, vehicle);

  if(issharedfuncdefined("vehicle_occupancy", "registerInstance")) {
    [[getsharedfunc("vehicle_occupancy", "registerInstance")]](vehicle);
  }
}

function vehicle_occupancy_deregisterinstance(vehicle) {
  vehicle.occupants = undefined;
  vehicle.occupantsreserving = undefined;
  vehicle.isempty = undefined;
  vehicle.preventspawninto = undefined;

  if(issharedfuncdefined("vehicle_occupancy", "deregisterInstance")) {
    [[getsharedfunc("vehicle_occupancy", "deregisterInstance")]](vehicle);
  }
}

function vehicle_occupancy_instanceisregistered(vehicle) {
  return isDefined(vehicle.occupants);
}

function vehicle_occupancy_getallvehicleseats(vehicle, var_6be731ec00f344cb) {
  assertex(isDefined(vehicle.vehiclename), "<dev string:x1c>");

  if(!isDefined(var_6be731ec00f344cb)) {
    var_6be731ec00f344cb = 1;
  }

  leveldataforvehicle = vehicle_occupancy_getleveldataforvehicle(vehicle.vehiclename);
  assertex(!var_6be731ec00f344cb || isDefined(leveldataforvehicle), "<dev string:x65>" + vehicle.vehiclename + "<dev string:x93>");

  if(isDefined(leveldataforvehicle) && isDefined(leveldataforvehicle.seatdata)) {
    return getarraykeys(leveldataforvehicle.seatdata);
  }

  return undefined;
}

function vehicle_occupancy_getavailablevehicleseats(vehicle) {
  availableseatids = [];
  seatids = vehicle_occupancy_getallvehicleseats(vehicle);

  foreach(seatid in seatids) {
    if(!vehicle_occupancy_seatisavailable(vehicle, seatid)) {
      continue;
    }

    availableseatids[availableseatids.size] = seatid;
  }

  return availableseatids;
}

function function_d3d95972f58ad2bc(vehicle) {
  availableseatids = vehicle_occupancy_getavailablevehicleseats(vehicle);

  if(!isDefined(availableseatids) || availableseatids.size <= 0) {
    return undefined;
  } else if(availableseatids.size == 1) {
    return availableseatids[0];
  }

  bestseat = availableseatids[0];
  bestpriority = -1;
  seatarray = vehicle_interact_getleveldataforvehicle(vehicle.vehiclename).var_9d0537be150542b3;
  assertex(isDefined(seatarray), "<dev string:xdb>");

  foreach(seatid in availableseatids) {
    leveldataforseat = vehicle_occupancy_getleveldataforseat(vehicle.vehiclename, seatid);
    spawnpriority = leveldataforseat.spawnpriority;
    seatorder = array_find(seatarray, seatid);

    if(!isDefined(spawnpriority) && isDefined(seatorder)) {
      spawnpriority = seatarray.size - seatorder;
    } else if(!isDefined(spawnpriority)) {
      spawnpriority = 0;
    } else {
      spawnpriority = int(max(0, spawnpriority));
    }

    if(spawnpriority > bestpriority) {
      bestseat = seatid;
      bestpriority = spawnpriority;
    }
  }

  return bestseat;
}

function vehicle_occupancy_seatisavailable(vehicle, seatid, player) {
  assertex(isDefined(vehicle.occupants) && isDefined(vehicle.occupantsreserving), "<dev string:x102>");
  occupant = vehicle.occupants[seatid];
  occupantreserving = vehicle.occupantsreserving[seatid];

  if(!isDefined(occupant) && !isDefined(occupantreserving)) {
    return true;
  }

  if(isDefined(player)) {
    if(isDefined(occupant) && occupant == player) {
      return true;
    }

    if(isDefined(occupantreserving) && occupantreserving == player) {
      return true;
    }
  }

  return false;
}

function vehicle_occupancy_getseatoccupant(vehicle, seatid, var_6be731ec00f344cb) {
  if(!isDefined(var_6be731ec00f344cb)) {
    var_6be731ec00f344cb = 1;
  }

  assertex(!var_6be731ec00f344cb || isDefined(vehicle.occupants), "<dev string:x16b>");

  if(isDefined(vehicle.occupants)) {
    return vehicle.occupants[seatid];
  }

  return undefined;
}

function vehicle_occupancy_getalloccupants(vehicle, var_6be731ec00f344cb) {
  if(!isDefined(var_6be731ec00f344cb)) {
    var_6be731ec00f344cb = 1;
  }

  assertex(!var_6be731ec00f344cb || isDefined(vehicle.occupants), "<dev string:x16b>");
  return vehicle.occupants;
}

function function_efa75aa7f0a1289(vehicle, var_6be731ec00f344cb) {
  if(!isDefined(var_6be731ec00f344cb)) {
    var_6be731ec00f344cb = 1;
  }

  assertex(!var_6be731ec00f344cb || isDefined(vehicle.occupants), "<dev string:x16b>");
  occupants = vehicle.occupants;

  if(isDefined(vehicle.ridingplayers)) {
    occupants = array_combine_unique(occupants, vehicle.ridingplayers);
  }

  if(isDefined(vehicle.turretoccupants)) {
    occupants = array_combine_unique(occupants, vehicle.turretoccupants);
  }

  return occupants;
}

function vehicle_occupancy_getalloccupantsandreserving(vehicle, var_6be731ec00f344cb) {
  if(!isDefined(var_6be731ec00f344cb)) {
    var_6be731ec00f344cb = 1;
  }

  assertex(!var_6be731ec00f344cb || isDefined(vehicle.occupants), "<dev string:x16b>");

  if(!isDefined(vehicle.occupants)) {
    return undefined;
  }

  return array_combine_unique(vehicle.occupants, vehicle.occupantsreserving);
}

function vehicle_occupancy_getreserving(vehicle, var_6be731ec00f344cb) {
  if(!isDefined(var_6be731ec00f344cb)) {
    var_6be731ec00f344cb = 1;
  }

  assertex(!var_6be731ec00f344cb || isDefined(vehicle.occupants), "<dev string:x16b>");

  if(!isDefined(vehicle.occupants)) {
    return undefined;
  }

  return vehicle.occupantsreserving;
}

function vehicle_occupancy_getoccupantseat(vehicle, player) {
  assertex(isDefined(vehicle.occupants), "<dev string:x16b>");

  foreach(seatid, occupant in vehicle.occupants) {
    if(occupant == player) {
      return seatid;
    }
  }

  return undefined;
}

function vehicle_occupancy_occupantisvehicledriver(player) {
  if(isDefined(player.vehicle)) {
    seatid = vehicle_occupancy_getoccupantseat(player.vehicle, player);
    leveldataforseat = vehicle_occupancy_getleveldataforseat(player.vehicle.vehiclename, seatid);

    if(isDefined(leveldataforseat.animtag)) {
      seattag = tolower(leveldataforseat.animtag);

      if(seattag == "tag_seat_0") {
        return true;
      }
    }
  }

  return false;
}

function vehicle_occupancy_getdriver(vehicle, var_6ecb77fd1f27c667) {
  driverseatid = vehicle_occupancy_getdriverseat(vehicle, var_6ecb77fd1f27c667);

  if(isDefined(driverseatid)) {
    return vehicle_occupancy_getseatoccupant(vehicle, driverseatid, !istrue(var_6ecb77fd1f27c667));
  }

  return undefined;
}

function vehicle_occupancy_getdriverseat(vehicle, var_6ecb77fd1f27c667) {
  leveldataforvehicle = vehicle_occupancy_getleveldataforvehicle(vehicle.vehiclename, !istrue(var_6ecb77fd1f27c667));

  if(!isDefined(leveldataforvehicle)) {
    return undefined;
  }

  driverseatid = leveldataforvehicle.driverseatid;

  if(!isDefined(driverseatid)) {
    if(isDefined(leveldataforvehicle.seatdata)) {
      foreach(seatid, seatdata in leveldataforvehicle.seatdata) {
        if(isDefined(seatdata.animtag) && tolower(seatdata.animtag) == "tag_seat_0") {
          driverseatid = seatid;
          break;
        }
      }
    }

    leveldataforvehicle.driverseatid = driverseatid;
  }

  return driverseatid;
}

function vehicle_occupancy_isdriverseat(vehicle, seatid) {
  leveldataforseat = vehicle_occupancy_getleveldataforseat(vehicle.vehiclename, seatid);

  if(!isDefined(leveldataforseat.animtag)) {
    return false;
  }

  if(tolower(leveldataforseat.animtag) != "tag_seat_0") {
    return false;
  }

  return true;
}

function vehicle_occupancy_enter(vehicle, seatid, player, data, immediate) {
  assertex(isDefined(vehicle.vehiclename), "<dev string:x1d8>");
  assertex(isDefined(vehicle_occupancy_getleveldataforvehicle(vehicle.vehiclename)), "<dev string:x65>" + vehicle.vehiclename + "<dev string:x223>");
  assertex(isDefined(vehicle.occupants) && isDefined(vehicle.occupantsreserving), "<dev string:x262>");
  assertex(!isDefined(data) || !isDefined(data.success), "<dev string:x2c3>");
  var_7c80ef8134378dea = 0;

  if(isDefined(data) && isDefined(data.useonspawn)) {
    var_7c80ef8134378dea = 1;
  }

  if(!var_7c80ef8134378dea && !player _isalive()) {
    return;
  }

  if(istrue(player.inlaststand)) {
    return;
  }

  if(istrue(vehicle.isdestroyed)) {
    return;
  }

  foreach(occupantreserving in vehicle.occupantsreserving) {
    if(isDefined(occupantreserving) && occupantreserving == player) {
      return;
    }
  }

  oldseatid = vehicle_occupancy_getoccupantseat(vehicle, player);

  if(istrue(vehicle_occupancy_seatisavailable(vehicle, seatid, player))) {
    vehicle_occupancy_stopmonitoringoccupant(player);

    if(!isDefined(data)) {
      data = spawnStruct();
    }

    data.immediate = istrue(immediate);
    data.raceendnotify = "vehicle_race_last_call";
    data.raceendon = "vehicle_race_finished";

    if(!data.immediate) {
      thread vehicle_occupancy_raceplayerdeathdisconnect(player, data);
      thread vehicle_occupancy_racevehicledeath(vehicle, data);
      thread vehicle_occupancy_raceseatunavailable(vehicle, player, seatid, oldseatid, data);
      thread vehicle_occupancy_racecomplete(oldseatid, seatid, data);
    }

    if(isDefined(oldseatid)) {
      thread vehicle_occupancy_exitstart(vehicle, oldseatid, seatid, player, data);
    }

    if(isDefined(seatid)) {
      thread vehicle_occupancy_enterstart(vehicle, seatid, oldseatid, player, data);
    }

    vehicle_occupancy_updatefull(vehicle);
    vehicle_occupancy_updateempty(vehicle);

    if(!data.immediate) {
      data waittill(data.raceendnotify);
      waittillframeend();
      data notify(data.raceendon);
    }

    if(!scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_instanceisregistered(vehicle)) {
      return;
    }

    success = vehicle_occupancy_raceresults(vehicle, player, oldseatid, seatid, data);

    if(isDefined(oldseatid)) {
      thread vehicle_occupancy_exitend(vehicle, oldseatid, seatid, player, data);
    }

    if(isDefined(seatid)) {
      thread vehicle_occupancy_enterend(vehicle, seatid, oldseatid, player, data);
    }

    vehicle_occupancy_updatefull(vehicle);
    vehicle_occupancy_updateempty(vehicle);

    if(success) {
      if(issharedfuncdefined("vehicle_occupancy", "changedSeats")) {
        [[getsharedfunc("vehicle_occupancy", "changedSeats")]](player, vehicle, oldseatid, seatid);
      }

      params = {
        #seatid: seatid, #player: player, #oldseatid: oldseatid, #vehicle: vehicle
      };
      level callback::callback("changedSeats", params);
      thread vehicle_occupancy_monitoroccupant(vehicle, player, seatid);
      player enablereloading();

      if(isDefined(oldseatid)) {
        isdriverseat = vehicle_occupancy_isdriverseat(vehicle, oldseatid);

        if(istrue(isdriverseat)) {
          player stopchallengetimer("driving");
        }
      }

      if(isDefined(seatid)) {
        isdriverseat = vehicle_occupancy_isdriverseat(vehicle, seatid);

        if(istrue(isdriverseat)) {
          vehicle function_9e710c9f3a15ffda();

          if(isDefined(player.vehiclecustomization)) {
            vehicleref = vehicle function_d93ec4635290febd();

            if(!isDefined(vehicle.mtx) && !istrue(vehicle.var_7ee6203c5532a9e6)) {
              mtx = function_471cde1983a05f66(player, vehicleref);
              function_4201160d49c885a7(vehicle, mtx);
            }

            if(isDefined(player.vehiclecustomization.horns[vehicleref])) {
              vehicle setvehiclehornsound(player.vehiclecustomization.horns[vehicleref]);
            } else if(isDefined(vehicle.mtx) && isDefined(vehicle.mtx.vehiclehorn)) {
              vehicle setvehiclehornsound(vehicle.mtx.vehiclehorn);
            } else {
              vehicle setvehiclehornsound("");
            }
          }

          player startchallengetimer("driving");
        }
      }

      if(!isDefined(oldseatid)) {
        entertype = "ENTERED_VEHICLE";

        if(issharedfuncdefined("pmc_missions", "onVehicleEnter")) {
          [[getsharedfunc("pmc_missions", "onVehicleEnter")]](player, vehicle);
        }

        player scripts\cp_mp\challenges::reportvehicleevent(vehicle, "enter_vehicle");
      } else {
        entertype = "SEAT_SWITCH";
      }

      scripts\cp_mp\vehicles\customization\battle_tracks::battle_tracks_vehicleoccupancyenter(vehicle, player, seatid, oldseatid);
      vehicle_dlog_enterevent(vehicle, player, seatid, entertype);
    } else if(isDefined(oldseatid) && !istrue(data.vehicledeath)) {
      if(istrue(data.playerdeath) || istrue(data.playerlaststand) || istrue(data.playerdisconnect)) {
        _data = spawnStruct();
        _data.playerdeath = data.playerdeath;
        _data.playerlaststand = data.playerlaststand;
        _data.playerliveragdoll = data.playerliveragdoll;
        _data.playerdisconnect = data.playerdisconnect;
        thread vehicle_occupancy_exit(vehicle, oldseatid, player, _data, 1);
      } else {
        vehicle_occupancy_reenter(vehicle, oldseatid, seatid, player, data);
      }
    }

    if(istrue(player.ksempd)) {
      if(!isDefined(player.var_3570f4b5b40c02e4)) {
        player thread scripts\cp_mp\emp_debuff::play_emp_scramble(4);
        player.var_3570f4b5b40c02e4 = 1;
      }
    }
  }
}

function vehicle_occupancy_exit(vehicle, seatid, player, data, immediate, specialexit) {
  assertex(isDefined(vehicle.vehiclename), "<dev string:x311>");
  assertex(isDefined(vehicle_occupancy_getleveldataforvehicle(vehicle.vehiclename)), "<dev string:x65>" + vehicle.vehiclename + "<dev string:x35b>");
  assertex(isDefined(vehicle.occupants) && isDefined(vehicle.occupantsreserving), "<dev string:x399>");

  if(isDefined(data)) {
    assertex(!isDefined(data.success), "<dev string:x3f9>");
  }

  if(isDefined(player) && player function_d09168b16803f5be()) {
    player notify("interrupt_roof_exit");
  }

  oldseatid = seatid;

  if(isDefined(player)) {
    if(!isDefined(oldseatid)) {
      oldseatid = vehicle_occupancy_getoccupantseat(vehicle, player);
    }

    if(!player _isalive()) {
      immediate = 1;
    }

    if(istrue(player.inlaststand)) {
      immediate = 1;
    }

    vehicle_occupancy_stopmonitoringoccupant(player);
  } else {
    immediate = 1;
    vehicle_occupancy_purgedataforseatinstance(vehicle, oldseatid);
  }

  if(istrue(vehicle.isdestroyed)) {
    immediate = 1;
  }

  assertex(isDefined(oldseatid), "<dev string:x446>");

  if(!isDefined(data)) {
    data = spawnStruct();
  }

  data.immediate = istrue(immediate);
  data.raceendnotify = "vehicle_race_last_call";
  data.raceendon = "vehicle_race_finished";

  if(!data.immediate) {
    thread vehicle_occupancy_raceplayerdeathdisconnect(player, data);
    thread vehicle_occupancy_racevehicledeath(vehicle, data);
    thread vehicle_occupancy_racecomplete(oldseatid, undefined, data);
  }

  thread vehicle_occupancy_exitstart(vehicle, oldseatid, undefined, player, data, specialexit);

  if(!data.immediate) {
    data waittill(data.raceendnotify);
    waittillframeend();
    data notify(data.raceendon);
  }

  success = vehicle_occupancy_raceresults(vehicle, player, oldseatid, undefined, data);
  thread vehicle_occupancy_exitend(vehicle, oldseatid, undefined, player, data, specialexit);
  vehicle_occupancy_updatefull(vehicle);
  vehicle_occupancy_updateempty(vehicle);

  if(istrue(vehicle.isheli) && istrue(vehicle.isempty)) {
    vehicle thread function_ba42cf4e5bb24367();
  }

  if(success) {
    if(isDefined(player)) {
      player enablereloading();
      isdriverseat = vehicle_occupancy_isdriverseat(vehicle, oldseatid);

      if(istrue(isdriverseat)) {
        player stopchallengetimer("driving");
      }
    }

    return;
  }

  if(!istrue(data.playerdeath) && !istrue(data.playerlaststand) && !istrue(data.playerliveragdoll) && !istrue(data.var_f276d4e53593ec9a) && !istrue(data.playerdisconnect) && !istrue(data.vehicledeath)) {
    vehicle_occupancy_reenter(vehicle, oldseatid, undefined, player, data);
  }
}

function vehicle_occupancy_isfriendlytoplayer(vehicle, player) {
  if(level.teambased) {
    return vehicle_occupancy_isfriendlytoteam(vehicle, player.team);
  }

  if(istrue(vehicle.friendlystatusdirty)) {
    vehicle vehicle_occupancy_cleanfriendlystatus(vehicle);
  }

  return isDefined(vehicle.playerfriendlyto) && vehicle.playerfriendlyto == player;
}

function vehicle_occupancy_isenemytoplayer(vehicle, player) {
  if(level.teambased) {
    return vehicle_occupancy_isenemytoteam(vehicle, player.team);
  }

  if(istrue(vehicle.friendlystatusdirty)) {
    vehicle vehicle_occupancy_cleanfriendlystatus(vehicle);
  }

  return isDefined(vehicle.playerfriendlyto) && vehicle.playerfriendlyto != player;
}

function vehicle_occupancy_isneutraltoplayer(vehicle, player) {
  if(level.teambased) {
    return vehicle_occupancy_isneutraltoteam(vehicle, player.team);
  }

  if(istrue(vehicle.friendlystatusdirty)) {
    vehicle vehicle_occupancy_cleanfriendlystatus(vehicle);
  }

  return !isDefined(vehicle.playerfriendlyto);
}

function vehicle_occupancy_getplayerfriendlyto(vehicle) {
  if(!level.teambased) {
    if(istrue(vehicle.friendlystatusdirty)) {
      vehicle vehicle_occupancy_cleanfriendlystatus(vehicle);
    }

    return vehicle.playerfriendlyto;
  }

  return undefined;
}

function vehicle_occupancy_isfriendlytoteam(vehicle, team) {
  if(level.teambased) {
    if(istrue(vehicle.friendlystatusdirty)) {
      vehicle vehicle_occupancy_cleanfriendlystatus(vehicle);
    }

    return (isDefined(vehicle.teamfriendlyto) && vehicle.teamfriendlyto == team);
  }

  return undefined;
}

function vehicle_occupancy_isenemytoteam(vehicle, team) {
  if(level.teambased) {
    if(istrue(vehicle.friendlystatusdirty)) {
      vehicle vehicle_occupancy_cleanfriendlystatus(vehicle);
    }

    return (isDefined(vehicle.teamfriendlyto) && vehicle.teamfriendlyto != team);
  }

  return undefined;
}

function vehicle_occupancy_isneutraltoteam(vehicle, team) {
  if(level.teambased) {
    if(istrue(vehicle.friendlystatusdirty)) {
      vehicle vehicle_occupancy_cleanfriendlystatus(vehicle);
    }

    return !isDefined(vehicle.teamfriendlyto);
  }

  return undefined;
}

function vehicle_occupancy_getteamfriendlyto(vehicle) {
  if(level.teambased) {
    if(istrue(vehicle.friendlystatusdirty)) {
      vehicle vehicle_occupancy_cleanfriendlystatus(vehicle);
    }

    return vehicle.teamfriendlyto;
  }

  return undefined;
}

function vehicle_occupancy_setfriendlystatusdirty(vehicle) {
  vehicle.friendlystatusdirty = 1;
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setvehicledirty(vehicle);
}

function vehicle_occupancy_cleanfriendlystatus(vehicle) {
  if(level.teambased) {
    cleaned = 0;
    oldteamfriendlyto = vehicle.teamfriendlyto;

    if(isDefined(vehicle.team) && vehicle.team != "neutral") {
      vehicle.teamfriendlyto = vehicle.team;
      vehicle.friendlystatusdirty = undefined;
      cleaned = 1;
    }

    if(!cleaned) {
      foreach(occupant in vehicle.occupants) {
        if(isDefined(occupant)) {
          vehicle.teamfriendlyto = occupant.team;
          vehicle.friendlystatusdirty = undefined;
          cleaned = 1;
          break;
        }
      }
    }

    if(!cleaned) {
      vehicle.teamfriendlyto = undefined;
      vehicle.friendlystatusdirty = undefined;
    }

    if(!isDefined(oldteamfriendlyto) && !isDefined(vehicle.teamfriendlyto)) {
      return 0;
    }

    if(isDefined(oldteamfriendlyto) && isDefined(vehicle.teamfriendlyto) && oldteamfriendlyto == vehicle.teamfriendlyto) {
      return 0;
    }

    vehicle_occupancy_friendlystatuschangedcallback(vehicle, oldteamfriendlyto, vehicle.teamfriendlyto);
    return 1;
  }

  cleaned = 0;
  oldplayerfriendlyto = vehicle.playerfriendlyto;

  if(isDefined(vehicle.originalowner)) {
    vehicle.playerfriendlyto = vehicle.originalowner;
    vehicle.friendlystatusdirty = undefined;
    cleaned = 1;
  }

  if(!cleaned) {
    occupants = vehicle_occupancy_getalloccupants(vehicle);

    foreach(occupant in occupants) {
      if(isDefined(occupant)) {
        vehicle.playerfriendlyto = occupant;
        vehicle.friendlystatusdirty = undefined;
        return;
      }
    }
  }

  if(!isDefined(oldplayerfriendlyto) && !isDefined(vehicle.playerfriendlyto)) {
    return 0;
  }

  if(isDefined(oldplayerfriendlyto) && isDefined(vehicle.playerfriendlyto) && oldplayerfriendlyto == vehicle.playerfriendlyto) {
    return 0;
  }

  vehicle_occupancy_friendlystatuschangedcallback(vehicle, oldplayerfriendlyto, vehicle.playerfriendlyto);
  return 1;
}

function vehicle_occupancy_friendlystatuschangedcallback(vehicle, var_965ea26e6eb230b9, var_52312180ef1940be) {
  if(level.teambased) {
    assertex(!isDefined(var_965ea26e6eb230b9) || isstring(var_965ea26e6eb230b9), "<dev string:x47d>");
    assertex(!isDefined(var_52312180ef1940be) || isstring(var_52312180ef1940be), "<dev string:x4c5>");
  } else {
    assertex(!isDefined(var_965ea26e6eb230b9) || isPlayer(var_965ea26e6eb230b9), "<dev string:x50d>");
    assertex(!isDefined(var_52312180ef1940be) || isPlayer(var_52312180ef1940be), "<dev string:x555>");
  }

  scripts\cp_mp\vehicles\vehicle_compass::vehicle_compass_friendlystatuschangedcallback(vehicle, var_965ea26e6eb230b9, var_52312180ef1940be);

  if(utility::issharedfuncdefined("game", "checkInvalidOOBTriggers") && scripts\cp_mp\utility\player_utility::function_1e4a0e61fdb00e32(vehicle)) {
    vehicle callsharedfunc("game", "checkInvalidOOBTriggers");
  }

  leveldataforvehicle = vehicle_occupancy_getleveldataforvehicle(vehicle.vehiclename);

  if(!isDefined(leveldataforvehicle.friendlystatuschangedcallback)) {
    return;
  }

  thread[[leveldataforvehicle.friendlystatuschangedcallback]](vehicle, var_965ea26e6eb230b9, var_52312180ef1940be);
}

function vehicle_occupancy_setoriginalowner(vehicle, player) {
  assertex(!isDefined(vehicle.originalowner), "<dev string:x59d>");
  vehicle.originalowner = player;
  vehicle_occupancy_updateowner(vehicle);
}

function vehicle_occupancy_setowner(vehicle, player, var_57c14bf60c5be4ab, timeroverride) {
  if(!isDefined(vehicle.owners)) {
    vehicle.owners = [];
  } else {
    vehicle_occupancy_clearowner(vehicle, player);
    vehicle.owners = array_removeundefined(vehicle.owners);
  }

  vehicle.owners[vehicle.owners.size] = player;

  if(isDefined(timeroverride) && timeroverride == -1) {} else {
    thread vehicle_occupancy_watchowner(vehicle, player, var_57c14bf60c5be4ab, timeroverride);
  }

  vehicle_occupancy_updateowner(vehicle);
}

function vehicle_occupancy_updateowner(vehicle) {
  vehicle notify("vehicle_owner_update");
  previousowner = vehicle.owner;
  previousownerteam = vehicle.ownerteam;
  bestowner = undefined;

  if(isDefined(vehicle.owners)) {
    for(i = vehicle.owners.size - 1; i >= 0; i--) {
      if(vehicle_occupancy_isplayervalidowner(vehicle, vehicle.owners[i])) {
        bestowner = vehicle.owners[i];
        break;
      }
    }
  }

  if(!isDefined(bestowner)) {
    if(vehicle_occupancy_isplayervalidowner(vehicle, vehicle.originalowner)) {
      bestowner = vehicle.originalowner;
    }
  }

  vehicle.owner = bestowner;
  ownerchanged = 0;

  if(isDefined(bestowner) || isDefined(previousowner)) {
    if(!isDefined(bestowner) && isDefined(previousowner)) {
      ownerchanged = 1;
    } else if(isDefined(bestowner) && !isDefined(previousowner)) {
      ownerchanged = 1;
    } else if(bestowner != previousowner) {
      ownerchanged = 1;
    }
  }

  ownerteamchanged = 0;

  if(isDefined(bestowner)) {
    if(!isDefined(previousownerteam) || previousownerteam != bestowner.team) {
      ownerteamchanged = 1;
    }

    vehicle.ownerteam = bestowner.team;
    scripts\cp_mp\vehicles\vehicle_compass::vehicle_compass_setteamfriendlyto(vehicle, bestowner.team);
    thread vehicle_occupancy_watchownerjoinedteam(vehicle, bestowner);
  } else {
    if(ownerchanged) {
      ownerteamchanged = 1;
    }

    vehicle.ownerteam = undefined;
  }

  if(ownerchanged) {
    if(!level.teambased) {
      vehicle_occupancy_setfriendlystatusdirty(vehicle);
    }

    vehicle function_a2d1400bcf46869a();
  }

  if(issharedfuncdefined("vehicle_occupancy", "updateOwner")) {
    [[getsharedfunc("vehicle_occupancy", "updateOwner")]](vehicle);
  }

  if(issharedfuncdefined(vehicle.vehiclename, "updateOwner")) {
    [[getsharedfunc(vehicle.vehiclename, "updateOwner")]](vehicle, bestowner, ownerchanged, ownerteamchanged);
  }
}

function vehicle_occupancy_clearowner(vehicle, player) {
  vehicle notify("vehicle_clear_owner_" + player getentitynumber());

  if(isDefined(vehicle.owners)) {
    vehicle.owners = array_remove(vehicle.owners, player);
  }

  if(isDefined(vehicle.owner) && vehicle.owner == player) {
    vehicle_occupancy_updateowner(vehicle);
  }
}

function vehicle_occupancy_setteam(vehicle, team) {
  teamchanged = !isDefined(vehicle.team) || vehicle.team != team;
  vehicle.team = team;

  if(vehicle.classname == "script_vehicle") {
    vehicle setvehicleteam(team);
  }

  if(teamchanged) {
    if(level.teambased) {
      vehicle_occupancy_setfriendlystatusdirty(vehicle);
    }
  }

  if(issharedfuncdefined(vehicle.vehiclename, "updateTeam")) {
    [[getsharedfunc(vehicle.vehiclename, "updateTeam")]](vehicle, team, teamchanged);
  }

  vehicle_occupancy_updateowner(vehicle);
}

#using_animtree("script_model");

function vehicle_occupancy_init() {
  assertex(isDefined(level.vehicle), "<dev string:x5fa>");
  assertex(!isDefined(level.vehicle.occupancy), "<dev string:x634>");
  leveldata = spawnStruct();
  level.vehicle.occupancy = leveldata;
  leveldata.vehicledata = [];
  leveldata.var_77b46b8810cb73f3 = getdvarint(@ "hash_4bf0d02ff4ac62ed", 1) > 0;

  if(leveldata.var_77b46b8810cb73f3) {
    leveldata.var_51c0466d6f15a77f = 0;
    leveldata.var_df81eeab4c9e5f64 = [];
  }

  vehicle_occupancy_initdebug();

  issharedfuncdefined("<dev string:x66c>", "<dev string:x681>", 1);

  [[getsharedfunc("vehicle_occupancy", "init")]]();
  level.var_73d6c6366970020 = getdvarint(@ "hash_abd3bd3c25a13d43", 1);
  level.var_351aab391da578a8 = getdvarint(@ "hash_2bf0e47506040359", 1) == 1;
  level.var_abe9bcb8a67ff917 = getdvarfloat(@ "hash_83928d2d50dc276c") + 50;
  level.var_d9dc5b053fb57856 = getdvarfloat(@ "hash_c9b7b0f34821b869") + 50;
  level.var_df44f8cc05382071 = getdvarfloat(@ "hash_94db90babe43cdc4", 100);
  level.vehiclelightsenabled = getdvarint(@ "hash_a459bb531af563b7", 1);

  if(isusingmatchrulesdata()) {
    vehicleunmannedkillprotectiontimeout = getmatchrulesdata("commonOption", "vehicleUnmannedKillProtectionTimeout");

    if(!isDefined(vehicleunmannedkillprotectiontimeout) || vehicleunmannedkillprotectiontimeout == 0) {
      vehicleunmannedkillprotectiontimeout = 4;
    }

    leveldata.var_772978c4701134fc = vehicleunmannedkillprotectiontimeout;
  }

  if(istrue(level.var_351aab391da578a8)) {
    level.scr_animtree["player_exit_vehicle_to_roof"] = #animtree;
  }
}

function vehicle_occupancy_enterstart(vehicle, seatid, oldseatid, player, data) {
  data endon(data.raceendon);

  if(istrue(player.insertingarmorplate)) {
    player notify("try_armor_cancel", "vehicle_enter");
  }

  function_eae2223216b7712c(vehicle, player);
  vehicle.occupantsreserving[seatid] = player;
  player.vehiclereserved = vehicle;
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setvehicledirty(vehicle);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setpointsdirty(vehicle);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(vehicle);
  timestamp = undefined;

  if(data.immediate) {
    timestamp = gettime();
  }

  if(isDefined(data.enterstartwaitmsg)) {
    player waittill(data.enterstartwaitmsg);
  }

  vehicle_occupancy_deleteseatcorpse(vehicle, seatid, 1);
  enterstartcallback = vehicle_occupancy_getenterstartcallbackforseat(vehicle, seatid);

  if(isDefined(enterstartcallback)) {
    [[enterstartcallback]](vehicle, seatid, oldseatid, player, data);
  }

  if(!isDefined(data.enterstartcomplete)) {
    data.enterstartcomplete = 1;
  }

  if(data.immediate) {
    assertex(timestamp == gettime(), "<dev string:x689>");
  }
}

function vehicle_occupancy_exitstart(vehicle, seatid, newseatid, player, data, specialexit) {
  data endon(data.raceendon);
  timestamp = undefined;

  if(data.immediate) {
    timestamp = gettime();
  }

  if(isDefined(player)) {
    seatdata = vehicle_occupancy_getleveldataforseat(vehicle function_d93ec4635290febd(), seatid);

    if(player isinvehicleleanout()) {
      player.var_8bce248ce93882f2 = 1;
    } else {
      player.var_8bce248ce93882f2 = undefined;
    }
  }

  exitstartcallback = vehicle_occupancy_getexitstartcallbackforseat(vehicle, seatid);

  if(isDefined(exitstartcallback)) {
    [[exitstartcallback]](vehicle, seatid, newseatid, player, data, specialexit);
  } else {
    vehicle_occupancy_exitstartcallback(vehicle, seatid, newseatid, player, data, specialexit);
  }

  if(!isDefined(data.exitstartcomplete)) {
    data.exitstartcomplete = 1;
  }

  if(data.immediate) {
    assertex(timestamp == gettime(), "<dev string:x6da>");
  }
}

function function_2966f7ab8ae9ccc6(tag) {
  return tag + "_window";
}

function function_43c2c433b8b9b12d(vehicle, seatid, oldseatid, player, data) {
  if(istrue(data.success)) {
    function_5004590331017d88(vehicle, seatid, oldseatid, player, data);
  }
}

function function_5004590331017d88(vehicle, seatid, oldseatid, player, data) {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(vehicle, oldseatid, seatid, player);
}

function function_857bf4201a249a99(vehicle, seatid, newseatid, player, data) {
  if(istrue(data.success)) {
    function_cb4191526e56163c(vehicle, seatid, newseatid, player, data);
  }
}

function function_cb4191526e56163c(vehicle, seatid, newseatid, player, data) {
  if(!istrue(data.playerdisconnect)) {
    success = vehicle_occupancy_moveplayertoexit(vehicle, seatid, newseatid, player, data);

    if(!success) {
      if(issharedfuncdefined("vehicle_occupancy", "handleSuicideFromVehicles")) {
        [[getsharedfunc("vehicle_occupancy", "handleSuicideFromVehicles")]](player);
      } else {
        player suicide();
      }
    }
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(vehicle, seatid, newseatid, player);
}

function vehicle_occupancy_exitstartcallback(vehicle, seatid, newseatid, player, data, specialexit) {
  data endon(data.raceendon);
  result = vehicle_occupancy_findplayerexit(player, vehicle, seatid, newseatid, data, specialexit);

  if(!result) {
    data.exitstartcomplete = 0;
    vehicle_occupancy_errormessage(player, 2);

    if(!istrue(data.immediate)) {
      waitframe();
      data notify(data.raceendnotify);
    }

    return;
  }

  if(isDefined(data.specialexit) && data.specialexit == "_to_roof") {
    result = function_c5819749db1604f5(player, vehicle, seatid, data);

    if(!istrue(result)) {
      player val::reset_all("vehicle_roof_exit");
      vehicle_occupancy_exitstartcallback(vehicle, seatid, newseatid, player, data, undefined);
    }
  }
}

function vehicle_occupancy_enterend(vehicle, seatid, oldseatid, player, data) {
  if(istrue(data.success)) {
    vehicle.occupants[seatid] = player;
    vehicle.occupantsreserving[seatid] = undefined;
    player.vehicle = vehicle;
    player.vehiclereserved = undefined;

    if(issharedfuncdefined("player", "disableClassSwapAllowed")) {
      self[[getsharedfunc("player", "disableClassSwapAllowed")]]();
    }

    vehicle_occupancy_applyrestrictionstooccupant(vehicle, seatid, player, data);
    vehicle_occupancy_updateriotshield(player, vehicle, seatid);
    vehicle_occupancy_hideoccupant(vehicle, seatid, player, data);
    vehicle_occupancy_applycameratooccupant(vehicle, seatid, oldseatid, player, data);
    vehicle_occupancy_applydamagemodifiertooccupant(vehicle, seatid, player, data);
    vehicle_occupancy_hidecashbag(vehicle, seatid, player, data);
    function_7c295748bbe46edf(vehicle, seatid, player, data);
    player thread function_a3428466c78231b0(vehicle, player);

    if(vehicle function_452936099dcd1b94(seatid)) {
      player thread function_e6ec777562579771(vehicle, seatid);
    }

    if(!isDefined(oldseatid)) {
      vehicle_occupancy_onentervehicle(vehicle, seatid, player, data);
      vehicle function_7394e322c553b3f0();

      if(isDefined(player.pers["telemetry"])) {
        var_6681408ac5fcc6cf = player.pers["telemetry"];
        isgroundvehicle = vehicle scripts\cp_mp\vehicles\vehicle::isgroundvehicle();

        if(isDefined(var_6681408ac5fcc6cf.ground_vehicle_used_count) && isgroundvehicle) {
          var_6681408ac5fcc6cf.ground_vehicle_used_count++;
        }

        isairvehicle = vehicle scripts\cp_mp\vehicles\vehicle::vehiclecanfly();

        if(isDefined(var_6681408ac5fcc6cf.air_vehicle_used_count) && isairvehicle) {
          var_6681408ac5fcc6cf.air_vehicle_used_count++;
        }
      }
    }

    leveldataforseat = vehicle_occupancy_getleveldataforseat(vehicle.vehiclename, seatid);

    if(isDefined(leveldataforseat.animtag) && tolower(leveldataforseat.animtag) == tolower("tag_seat_0")) {
      vehicle_occupancy_setowner(vehicle, player, 1);
    }

    if(!isDefined(oldseatid)) {
      player notify("vehicle_enter");

      if(isDefined(leveldataforseat.onenterbattlechatter)) {
        thread vehicle_occupancy_handleplayerbc(player, leveldataforseat, 1);
      }
    } else {
      player notify("vehicle_change_seat");

      if(isDefined(leveldataforseat.onenterbattlechatter)) {
        thread vehicle_occupancy_handleplayerbc(player, leveldataforseat, 0);
      }
    }

    wasdriver = vehicle_occupancy_isdriverseat(vehicle, seatid);

    if(wasdriver && istrue(function_29b4292c92443328(vehicle function_d93ec4635290febd()).isboat)) {
      vehicle function_3112242e4bc392de();
    }

    if(istrue(vehicle.isheli)) {
      vehicle function_a91927df280e94e4();
    }

    if(wasdriver && istrue(vehicle.var_6179b2eea75dbfe0)) {
      vehicle function_9a816e66a02ddb40();
    }
  } else {
    if(isDefined(player)) {
      player.vehiclereserved = undefined;
    }

    if(!istrue(data.vehicledeath)) {
      vehicle.occupantsreserving[seatid] = undefined;
    }
  }

  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setvehicledirty(vehicle);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setpointsdirty(vehicle);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(vehicle);
  timestamp = gettime();

  if(istrue(data.success)) {
    player thread vehicle_occupancy_animateplayer(vehicle, seatid, oldseatid);
    function_c84d89e51c871aa2(vehicle, seatid, player, data);

    if(vehicle function_72f871bf74995298() && vehicle vehicle_isphysveh()) {
      vehicle vehphys_parkingbrake(1);
    }
  }

  enterendcallback = vehicle_occupancy_getenterendcallbackforseat(vehicle, seatid);

  if(isDefined(enterendcallback)) {
    [[enterendcallback]](vehicle, seatid, oldseatid, player, data);
  } else {
    function_43c2c433b8b9b12d(vehicle, seatid, oldseatid, player, data);
  }

  assertex(timestamp == gettime(), "<dev string:x72a>");
}

function vehicle_occupancy_exitend(vehicle, seatid, newseatid, player, data, specialexit) {
  if(data.success) {
    vehicle.occupants[seatid] = undefined;

    if(isDefined(player)) {
      player notify("vehicle_seat_exit");

      if(!isDefined(newseatid)) {
        player.vehicle = undefined;
      }

      vehicle_occupancy_removerestrictionsfromoccupant(vehicle, seatid, player, data);
      vehicle_occupancy_updateriotshield(player, vehicle, newseatid);
      vehicle_occupancy_showoccupant(vehicle, seatid, player, data);
      function_edcb1116f9160367(vehicle, seatid, player, data);
      function_e157f2a83aa01ea2(vehicle, seatid, player, data);
      vehicle_occupancy_removecamerafromoccupant(vehicle, newseatid, player, data);
      vehicle_occupancy_removedamagemodifierfromoccupant(vehicle, seatid, player, data);
      vehicle_occupancy_showcashbag(vehicle, seatid, player, data);
    }

    if(!isDefined(newseatid)) {
      vehicle_occupancy_onexitvehicle(vehicle, seatid, player, data);
    }

    if(!vehicle scripts\common\vehicle_code::vehicle_is_stopped() && vehicle_occupancy_isdriverseat(vehicle, seatid)) {
      if(issharedfuncdefined("br", "challengeEvaluator")) {
        paramstruct = spawnStruct();
        paramstruct.exitdriver = 1;
        player thread[[getsharedfunc("br", "challengeEvaluator")]]("br_mastery_ghostRideWhip", paramstruct);
      }
    }

    if(vehicle_occupancy_isdriverseat(vehicle, seatid) && istrue(function_29b4292c92443328(vehicle function_d93ec4635290febd()).isboat)) {
      vehicle thread function_4e7868ef633f4b36();
    }
  }

  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setvehicledirty(vehicle);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setpointsdirty(vehicle);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(vehicle);
  timestamp = gettime();
  exitendcallback = vehicle_occupancy_getexitendcallbackforseat(vehicle, seatid);

  if(isDefined(exitendcallback)) {
    [[exitendcallback]](vehicle, seatid, newseatid, player, data);
  } else {
    function_857bf4201a249a99(vehicle, seatid, newseatid, player, data);
  }

  if(isDefined(player)) {
    player usebuttondone();

    if(!isDefined(newseatid)) {
      if(isDefined(player.vehoccupancy_lastseatbc)) {
        player.vehoccupancy_lastseatbc = undefined;
      }

      if(isDefined(player.vehoccupancy_lastbctime)) {
        player.vehoccupancy_lastbctime = undefined;
      }
    }
  }

  params = {
    #vehicle: vehicle, #newseatid: newseatid, #seatid: seatid, #player: player
  };
  player callback::callback("player_vehicle_exit", params);
  assertex(timestamp == gettime(), "<dev string:x765>");
}

function vehicle_occupancy_reenter(vehicle, reenterseatid, var_3f68c37bafd38606, player, data) {
  thread vehicle_occupancy_monitoroccupant(vehicle, player, reenterseatid);
  timestamp = gettime();
  reentercallback = vehicle_occupancy_getreentercallbackforseat(vehicle, reenterseatid);

  if(isDefined(reentercallback)) {
    [[reentercallback]](vehicle, reenterseatid, var_3f68c37bafd38606, player, data);
  } else {
    data.success = undefined;
    data.exitposition = undefined;
    data.exitangles = undefined;
    data.specialexit = undefined;
    data.exitdirection = undefined;
    data.exitoffset = undefined;
    thread vehicle_occupancy_enter(vehicle, reenterseatid, player, data, 1);
  }

  assertex(timestamp == gettime(), "<dev string:x79f>");
}

function vehicle_occupancy_getleveldata() {
  assertex(isDefined(level.vehicle), "<dev string:x7d9>");
  assertex(isDefined(level.vehicle.occupancy), "<dev string:x81b>");
  return level.vehicle.occupancy;
}

function vehicle_occupancy_handleplayerbc(player, seatdata, var_4cbe0c5ddb047549) {
  assert(issharedfuncdefined("<dev string:x867>", "<dev string:x86f>"));
  var_9d2442a09adbb305 = 5000;

  if(istrue(var_4cbe0c5ddb047549)) {
    player.vehoccupancy_lastseatbc = seatdata.onenterbattlechatter;
    thread[[getsharedfunc("game", "trySayLocalSound")]](player, seatdata.onenterbattlechatter, undefined, 1);
    player.vehoccupancy_lastbctime = gettime();
    return;
  }

  if(isDefined(player.vehoccupancy_lastseatbc) && isDefined(player.vehoccupancy_lastbctime) && player.vehoccupancy_lastseatbc != seatdata.onenterbattlechatter && gettime() - player.vehoccupancy_lastbctime > var_9d2442a09adbb305) {
    thread[[getsharedfunc("game", "trySayLocalSound")]](player, seatdata.onenterbattlechatter);
    player.vehoccupancy_lastseatbc = seatdata.onenterbattlechatter;
    player.vehoccupancy_lastbctime = gettime();
  }
}

function vehicle_occupancy_purgedataforseatinstance(vehicle, seatid) {
  vehicle.occupants[seatid] = undefined;
  vehicle.occupantsreserving[seatid] = undefined;
}

function vehicle_occupancy_onentervehicle(vehicle, newseatid, player, data) {
  level notify("enter_vehicle", vehicle, player);
  vehicle_occupancy_setfriendlystatusdirty(vehicle);
  function_e462819da430ac92(vehicle);
  vehicle scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_stopwatchingabandoned();
  player setstance("stand");
  player val::set_array("vehicle_occupant_common", vehicle_occupancy_getoccupantrestrictions(), 0);
  thread vehicle_occupancy_takeriotshield(player, vehicle, newseatid);
  scripts\cp_mp\vehicles\customization\battle_tracks::battle_tracks_onentervehicle(vehicle, player);
  scripts\cp_mp\vehicles\vehicle_interact::function_c5fe005f06fe5684(vehicle, player);

  if(issharedfuncdefined("vehicle_occupancy", "onEnterVehicle", 1)) {
    [[getsharedfunc("vehicle_occupancy", "onEnterVehicle")]](vehicle, newseatid, player, data);
  }

  params = {
    #data: data, #player: player, #newseatid: newseatid, #vehicle: vehicle
  };
  level callback::callback("onEnterVehicle", params);

  if(issharedfuncdefined("<dev string:x867>", "<dev string:x883>")) {
    host = [[getsharedfunc("<dev string:x867>", "<dev string:x883>")]]();

    if(isDefined(host) && player == host) {
      level.botvehicle = vehicle;
    }
  }

}

function vehicle_occupancy_onexitvehicle(vehicle, oldseatid, player, data) {
  level notify("exit_vehicle", vehicle, player);

  if(!istrue(data.playerdisconnect)) {
    player vehicle_occupancy_stopmovefeedbackforplayer();
    player vehicle_occupancy_cleardamagefeedbackforplayer();
    scripts\cp_mp\vehicles\vehicle_interact::function_deb83798a724a77e(vehicle, player);

    if(!istrue(data.playerdeath)) {
      if(istrue(data.playerlaststand) || istrue(data.playerliveragdoll)) {
        data.exittype = "DEATH";
      } else if(!isDefined(data.exittype)) {
        data.exittype = "VOLUNTARY";
      }

      thread vehicle_preventplayercollisiondamagefortimeafterexit(vehicle, player);
    } else {
      data.exittype = "DEATH";
    }

    thread vehicle_occupancy_giveriotshield(player, data.playerdeath, data.playerlaststand);
  } else {
    data.exittype = "DISCONNECT";
  }

  vehicle_occupancy_setfriendlystatusdirty(vehicle);
  function_e462819da430ac92(vehicle);
  vehicle thread scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_watchabandoned();
  vehicle thread scripts\cp_mp\vehicles\vehicle_spawn::function_6c65df1f40e10037();

  if(issharedfuncdefined("vehicle_occupancy", "onExitVehicle", 1)) {
    [[getsharedfunc("vehicle_occupancy", "onExitVehicle")]](vehicle, oldseatid, player, data);
  }

  params = {
    #data: data, #player: player, #oldseatid: oldseatid, #vehicle: vehicle
  };
  level callback::callback("onExitVehicle", params);
  player notify("exit_vehicle");
  vehicle_dlog_exitevent(vehicle, player, oldseatid, data.exittype);
  scripts\cp_mp\vehicles\customization\battle_tracks::battle_tracks_onexitvehicle(vehicle, player, oldseatid);
}

function vehicle_occupancy_updatefull(vehicle) {
  var_5e41ee78365ed202 = vehicle_occupancy_getavailablevehicleseats(vehicle).size <= 0;

  if(var_5e41ee78365ed202) {
    if(!istrue(vehicle.isfull)) {
      vehicle_interact_setpointdirty(vehicle, "single");
      vehicle_interact_updateusability(vehicle);
      vehicle.isfull = 1;
    } else {
      vehicle_interact_updateusability(vehicle);
    }

    return;
  }

  if(istrue(vehicle.isfull)) {
    vehicle.isfull = undefined;
    vehicle_interact_setpointdirty(vehicle, "single");
    vehicle_interact_updateusability(vehicle);
    return;
  }

  vehicle_interact_updateusability(vehicle);
}

function vehicle_occupancy_updateempty(vehicle) {
  availablevehicleseats = vehicle_occupancy_getavailablevehicleseats(vehicle);
  allvehicleseats = vehicle_occupancy_getallvehicleseats(vehicle);
  isempty = availablevehicleseats.size == allvehicleseats.size;
  vehicle.isempty = isempty;
}

function vehicle_occupancy_getenterstartcallbackforseat(vehicle, seatid) {
  if(issharedfuncdefined(vehicle.vehiclename, "enterStart")) {
    return getsharedfunc(vehicle.vehiclename, "enterStart");
  }
}

function vehicle_occupancy_getenterendcallbackforseat(vehicle, seatid) {
  if(issharedfuncdefined(vehicle.vehiclename, "enterEnd")) {
    return getsharedfunc(vehicle.vehiclename, "enterEnd");
  }
}

function vehicle_occupancy_getexitstartcallbackforseat(vehicle, seatid) {
  if(issharedfuncdefined(vehicle.vehiclename, "exitStart")) {
    return getsharedfunc(vehicle.vehiclename, "exitStart");
  }
}

function vehicle_occupancy_getexitendcallbackforseat(vehicle, seatid) {
  if(issharedfuncdefined(vehicle.vehiclename, "exitEnd")) {
    return getsharedfunc(vehicle.vehiclename, "exitEnd");
  }
}

function vehicle_occupancy_getreentercallbackforseat(vehicle, seatid) {
  if(issharedfuncdefined(vehicle.vehiclename, "reenter")) {
    return getsharedfunc(vehicle.vehiclename, "reenter");
  }
}

function vehicle_occupancy_applyrestrictionstooccupant(vehicle, newseatid, player, data) {
  if(!vehicle_occupancy_movementisallowed(vehicle) && !vehicle function_f654c168752ed299()) {
    if(newseatid == vehicle_occupancy_getdriverseat(vehicle)) {
      vehicle_occupancy_allowmovementplayer(vehicle, player, 0, newseatid);
    }
  }

  restrictions = vehicle_occupancy_getrestrictionsforseat(vehicle, newseatid);
  player val::set_array("vehicle_occupant", restrictions, 0);
}

function vehicle_occupancy_removerestrictionsfromoccupant(vehicle, oldseatid, player, data) {
  if(!istrue(data.playerdeath)) {
    vehicle_occupancy_allowmovementplayer(vehicle, player, 1, undefined);
    player val::reset_all("vehicle_occupant");
  }
}

function function_31609728116475f() {
  if(!isDefined(level.var_12a9aac58c679eca)) {
    level.var_12a9aac58c679eca = getdvarint(@ "hash_4f6bb46a93a86d18", 1);
  }

  return level.var_12a9aac58c679eca;
}

function vehicle_occupancy_hideoccupant(vehicle, newseatid, player, data) {
  if(vehicle_shouldhideoccupantforseat(vehicle, newseatid)) {
    player.nocorpse = 1;

    if(function_31609728116475f()) {
      player _playerhidestack();
      player function_379bb555405c16bb("vehicle_occupancy::vehicle_occupancy_hideOccupant() - _playerHideStack");
      return;
    }

    player function_a593971d75d82113();
    player function_379bb555405c16bb("vehicle_occupancy::vehicle_occupancy_hideOccupant()");
  }
}

function function_c84d89e51c871aa2(vehicle, oldseatid, player, data) {
  if(function_f3db2e446c1457f(vehicle, oldseatid, player)) {
    player vehicle_setstowedweaponvisibility(0);
  }
}

function function_23a58d26e5c53e1f(player, data) {
  leveldata = vehicle_occupancy_getleveldata();

  if(!leveldata.var_77b46b8810cb73f3) {
    return;
  }

  id = leveldata.var_51c0466d6f15a77f;
  leveldata.var_51c0466d6f15a77f++;
  player _playerhidestack();
  player function_379bb555405c16bb("vehicle_occupancy::vehicle_occupancy_hideOccupantDuringTransition() - _playerHideStack");
  leveldata.var_df81eeab4c9e5f64[id] = player;

  if(!isDefined(data.var_df81eeab4c9e5f64)) {
    data.var_df81eeab4c9e5f64 = [];
  }

  data.var_df81eeab4c9e5f64[id] = player;
  return id;
}

function function_1a067f7da28ca689(id, data, var_f4fedb549a5fa44b) {
  leveldata = vehicle_occupancy_getleveldata();

  if(!leveldata.var_77b46b8810cb73f3) {
    return;
  }

  if(istrue(var_f4fedb549a5fa44b)) {
    waitframe();
    waitframe();
  }

  if(!leveldata.var_77b46b8810cb73f3) {
    return;
  }

  if(!isDefined(leveldata.var_df81eeab4c9e5f64[id])) {
    return;
  }

  player = leveldata.var_df81eeab4c9e5f64[id];

  if(isDefined(data) && isDefined(data.var_df81eeab4c9e5f64)) {
    data.var_df81eeab4c9e5f64[id] = undefined;
  }

  if(isDefined(player)) {
    player _playershowstack();
    player function_985b0973f29da4f8("vehicle_occupancy::vehicle_occupancy_showOccupantAfterTransitionByEventID() - _playerShowStack");
  }
}

function function_914037c6a5cec6cd(data, var_f4fedb549a5fa44b) {
  leveldata = vehicle_occupancy_getleveldata();

  if(!leveldata.var_77b46b8810cb73f3) {
    return;
  }

  if(istrue(var_f4fedb549a5fa44b)) {
    waitframe();
    waitframe();
  }

  if(!isDefined(data.var_df81eeab4c9e5f64)) {
    return;
  }

  foreach(id, player in data.var_df81eeab4c9e5f64) {
    if(isDefined(leveldata.var_df81eeab4c9e5f64[id])) {
      leveldata.var_df81eeab4c9e5f64[id] = undefined;

      if(isDefined(player)) {
        player _playershowstack();
        player function_985b0973f29da4f8("vehicle_occupancy::vehicle_occupancy_showOccupantAfterTransitionByEventID() - _playerShowStack");
      }
    }
  }

  data.var_df81eeab4c9e5f64 = undefined;
}

function function_37bad8e4d4b6a7f() {
  leveldata = vehicle_occupancy_getleveldata();

  if(!leveldata.var_77b46b8810cb73f3) {
    return;
  }

  foreach(id, player in leveldata.var_df81eeab4c9e5f64) {
    if(!isDefined(player)) {
      leveldata.var_df81eeab4c9e5f64[id] = undefined;
    }
  }
}

function vehicle_occupancy_showoccupant(vehicle, oldseatid, player, data) {
  if(!istrue(data.playerdeath)) {
    if(vehicle_shouldhideoccupantforseat(vehicle, oldseatid)) {
      if(!istrue(data.nocorpse)) {
        player.nocorpse = undefined;
      }

      if(function_31609728116475f()) {
        player _playershowstack();
        player function_985b0973f29da4f8("vehicle_occupancy::vehicle_occupancy_showOccupant() - _playerShowStack");
        return;
      }

      player function_6fb380927695ee76();
      player function_985b0973f29da4f8("vehicle_occupancy::vehicle_occupancy_showOccupant()");
    }
  }
}

function function_edcb1116f9160367(vehicle, oldseatid, player, data) {
  if(!istrue(data.playerdeath)) {
    if(function_f3db2e446c1457f(vehicle, oldseatid, player)) {
      player vehicle_setstowedweaponvisibility(1);
    }
  }
}

function function_7c295748bbe46edf(vehicle, oldseatid, player, data) {
  if(function_e552d137b9591a4c(vehicle, oldseatid, player) && player tagexists("j_helmet_hide")) {
    player hidepart("j_helmet_hide", undefined, 1);
  }
}

function function_e157f2a83aa01ea2(vehicle, oldseatid, player, data) {
  if(function_e552d137b9591a4c(vehicle, oldseatid, player) && player tagexists("j_helmet_hide")) {
    player showpart("j_helmet_hide", undefined, 1);
  }
}

function function_e552d137b9591a4c(vehicle, seatid, player) {
  leveldataforvehicle = vehicle_occupancy_getleveldataforvehicle(vehicle.vehiclename);
  leveldataforseat = leveldataforvehicle.seatdata[seatid];
  return istrue(leveldataforseat.hidehelmet);
}

function vehicle_occupancy_applycameratooccupant(vehicle, seatid, oldseatid, player, data) {
  camera = vehicle_getcameraforseat(vehicle, seatid);

  if(isDefined(camera) && camera != "none") {
    oldcamera = vehicle_getcameraforseat(vehicle, oldseatid);

    if(oldcamera != camera) {
      player cameraset(camera);
    }
  }
}

function vehicle_occupancy_removecamerafromoccupant(vehicle, newseatid, player, data) {
  if(isDefined(newseatid)) {
    camera = vehicle_getcameraforseat(vehicle, newseatid);

    if(camera == "none") {
      player cameradefault();
    }

    return;
  }

  player cameradefault();
}

function vehicle_occupancy_applydamagemodifiertooccupant(vehicle, newseatid, player, data) {
  damagemodifier = vehicle_occupancy_getdamagemodifierforseat(vehicle, newseatid);

  if(isDefined(damagemodifier) && damagemodifier != -1) {
    player adddamagemodifier(vehicle.vehiclename + "_" + newseatid, damagemodifier, 0, &vehicle_occupancy_damagemodifierignorefunc);
  }
}

function vehicle_occupancy_removedamagemodifierfromoccupant(vehicle, oldseatid, player, data) {
  if(!istrue(data.playerdeath)) {
    damagemodifier = vehicle_occupancy_getdamagemodifierforseat(vehicle, oldseatid);

    if(isDefined(damagemodifier) && damagemodifier != -1) {
      player removedamagemodifier(vehicle.vehiclename + "_" + oldseatid, 0);
    }
  }
}

function vehicle_occupancy_getrestrictionsforseat(vehicle, seatid) {
  leveldataforvehicle = vehicle_occupancy_getleveldataforvehicle(vehicle.vehiclename);
  leveldataforseat = leveldataforvehicle.seatdata[seatid];
  restrictions = ter_op(isDefined(leveldataforseat.restrictions), leveldataforseat.restrictions, leveldataforvehicle.restrictions);

  if(istrue(leveldataforvehicle.canleanout)) {
    if(vehicle function_6c49fb45260b8c4c(seatid)) {
      restrictions[restrictions.size] = "vehicle_lean_out";
    } else {
      restrictions = function_6d6af8144a5131f1(restrictions, "melee");
    }
  } else {
    restrictions[restrictions.size] = "vehicle_lean_out";
  }

  if(vehicle function_80d84f556cc8017a() && function_1003e8d7c662a2ff(vehicle function_d93ec4635290febd(), seatid)) {
    restrictions[restrictions.size] = "fire";
  }

  return restrictions;
}

function vehicle_shouldhideoccupantforseat(vehicle, seatid) {
  leveldataforvehicle = vehicle_occupancy_getleveldataforvehicle(vehicle.vehiclename);
  leveldataforseat = leveldataforvehicle.seatdata[seatid];

  if(isDefined(leveldataforseat.hideoccupant)) {
    return istrue(leveldataforseat.hideoccupant);
  }

  return istrue(leveldataforvehicle.hideoccupant);
}

function function_f3db2e446c1457f(vehicle, seatid, player) {
  leveldataforvehicle = vehicle_occupancy_getleveldataforvehicle(vehicle.vehiclename);
  leveldataforseat = leveldataforvehicle.seatdata[seatid];
  return player isvehicleactive() && istrue(leveldataforseat.hidestowedweapon);
}

function vehicle_getcameraforseat(vehicle, seatid) {
  leveldataforvehicle = vehicle_occupancy_getleveldataforvehicle(vehicle.vehiclename);

  if(isDefined(seatid)) {
    leveldataforseat = leveldataforvehicle.seatdata[seatid];
    camera = leveldataforvehicle.camera;

    if(isDefined(leveldataforseat.camera)) {
      camera = leveldataforseat.camera;
    }

    if(isDefined(leveldataforseat.animtag) && tolower(leveldataforseat.animtag) == "tag_seat_0") {
      camera = "none";
    }
  } else {
    camera = "none";
  }

  return camera;
}

function vehicle_occupancy_getdamagemodifierforseat(vehicle, seatid) {
  leveldataforvehicle = vehicle_occupancy_getleveldataforvehicle(vehicle.vehiclename);
  leveldataforseat = leveldataforvehicle.seatdata[seatid];
  return ter_op(isDefined(leveldataforseat.damagemodifier), leveldataforseat.damagemodifier, leveldataforvehicle.damagemodifier);
}

function vehicle_occupancy_damagemodifierignorefunc(inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc) {
  data = packdamagedata(attacker, victim, damage, objweapon, meansofdeath, inflictor);

  if(meansofdeath == "MOD_TRIGGER_HURT") {
    return true;
  }

  if(isDefined(objweapon) && objweapon.basename == "bomb_site_mp") {
    return true;
  }

  if(victim isstuckdamage(data)) {
    return true;
  }

  return false;
}

function function_a3428466c78231b0(vehicle, player) {
  level endon("game_ended");
  vehicle endon("death");
  player endon("death_or_disconnect");
  wait 0.5;
  vehicleoobtriggers = vehicle.oobtriggers;
  playeroobtriggers = player.oobtriggers;

  if(isDefined(vehicleoobtriggers)) {
    foreach(vehicletrigger in vehicleoobtriggers) {
      refreshoob = 1;

      if(isDefined(playeroobtriggers) && playeroobtriggers.size > 0) {
        refreshoob = !array_contains(playeroobtriggers, vehicletrigger);
      }

      if(istrue(refreshoob)) {
        if(issharedfuncdefined("game", "onEnterOOBTrigger")) {
          [[getsharedfunc("game", "onEnterOOBTrigger")]](vehicletrigger, player, 1);
        }
      }
    }
  }

  if(isDefined(playeroobtriggers)) {
    foreach(playertrigger in playeroobtriggers) {
      refreshoob = 0;

      if(!isDefined(vehicleoobtriggers)) {
        refreshoob = 1;
      } else if(!array_contains(vehicleoobtriggers, playertrigger)) {
        refreshoob = 1;
      }

      if(istrue(refreshoob)) {
        if(issharedfuncdefined("game", "onExitOOBTrigger")) {
          [[getsharedfunc("game", "onExitOOBTrigger")]](playertrigger, player);
        }
      }
    }
  }
}

function vehicle_occupancy_monitoroccupant(vehicle, player, seatid) {
  thread vehicle_occupancy_monitorcontrols(vehicle, player, seatid);

  if(!istrue(level.var_15c7e6ec178feef1)) {
    thread vehicle_occupancy_monitorseatswitch(vehicle, player, seatid, 1);
    thread vehicle_occupancy_monitorexit(vehicle, player, seatid);
  }

  thread vehicle_occupancy_monitorgameended(vehicle, player, seatid);
  thread vehicle_occupancy_monitorleanblocked(vehicle, player);
}

function vehicle_occupancy_stopmonitoringoccupant(player) {
  player notify("vehicle_occupancy_monitorControls");
  player notify("vehicle_occupancy_monitorSeatSwitch");
  player notify("vehicle_occupancy_monitorExit");
  player notify("vehicle_occupancy_monitorGameEnded");
  player notify("vehicle_occupancy_monitorLeanBlocked");
}

function vehicle_occupancy_monitorleanblocked(vehicle, player) {
  player notify("vehicle_occupancy_monitorLeanBlocked");
  player endon("vehicle_occupancy_monitorLeanBlocked");
  player endon("death_or_disconnect");
  player endon("last_stand_start");

  while(true) {
    player waittill_any_2("vehicle_leanout_attempt_denied", "vehicle_leanout_forced_return");

    if(issharedfuncdefined("hud", "showErrorMessage")) {
      player[[getsharedfunc("hud", "showErrorMessage")]]("VEHICLES/LEAN_OUT_BLOCKED");
    }
  }
}

function vehicle_occupancy_monitorseatswitch(vehicle, player, seatid, applydelay) {
  player endon("death_or_disconnect");
  player endon("last_stand_start");
  vehicle endon("death");
  level endon("game_ended");
  player notify("vehicle_occupancy_monitorSeatSwitch");
  player endon("vehicle_occupancy_monitorSeatSwitch");
  leveldataforvehicle = vehicle_occupancy_getleveldataforvehicle(vehicle.vehiclename);

  if(leveldataforvehicle.seatdata.size <= 1) {
    return;
  }

  leveldataforseat = vehicle_occupancy_getleveldataforseat(vehicle.vehiclename, seatid);

  if(!isDefined(leveldataforseat.seatswitcharray) || leveldataforseat.seatswitcharray.size <= 0) {
    return;
  }

  if(!isbot(player)) {
    if(applydelay) {
      wait 0.2;
    }

    while(player vehswitchseatbuttonPressed() || player function_5919151dd97650d2()) {
      waitframe();
    }

    while(!player vehswitchseatbuttonPressed() && !player function_5919151dd97650d2() || istrue(player.var_ea02a8bfcfde7c4b)) {
      waitframe();
    }

    if(player function_5919151dd97650d2()) {
      switchseatid = function_795d10f52e5291cf(vehicle, player, seatid);
    } else {
      switchseatid = vehicle_occupancy_getnextavailableseat(vehicle, player, seatid);
    }

    if(isDefined(switchseatid)) {
      thread vehicle_occupancy_enter(vehicle, switchseatid, player);
    }

    vehicle_occupancy_errormessage(player, ter_op(istrue(vehicle.var_65da0a245b653cc), 3, 1));
    thread vehicle_occupancy_monitorseatswitch(vehicle, player, seatid, 0);
  }
}

function vehicle_occupancy_getnextavailableseat(vehicle, player, seatid) {
  leveldataforseat = vehicle_occupancy_getleveldataforseat(vehicle.vehiclename, seatid);

  if(!isDefined(leveldataforseat.seatswitcharray) || leveldataforseat.seatswitcharray.size <= 0) {
    return undefined;
  }

  foreach(switchseatid in leveldataforseat.seatswitcharray) {
    if(vehicle_occupancy_seatisavailable(vehicle, switchseatid, player)) {
      return switchseatid;
    }
  }
}

function function_795d10f52e5291cf(vehicle, player, seatid) {
  leveldataforseat = vehicle_occupancy_getleveldataforseat(vehicle.vehiclename, seatid);

  if(!isDefined(leveldataforseat.seatswitcharray) || leveldataforseat.seatswitcharray.size <= 0) {
    return undefined;
  }

  prevseatid = undefined;

  foreach(switchseatid in leveldataforseat.seatswitcharray) {
    if(vehicle_occupancy_seatisavailable(vehicle, switchseatid, player)) {
      prevseatid = switchseatid;
    }
  }

  return prevseatid;
}

function vehicle_occupancy_monitorexit(vehicle, player, seatid) {
  player notify("vehicle_occupancy_monitorExit");
  player endon("vehicle_occupancy_monitorExit");
  vehicle endon("death");
  level endon("game_ended");
  specialexit = vehicle_occupancy_monitorexitinternal(vehicle, player, seatid);
  data = spawnStruct();

  if(isDefined(player)) {
    if(!player _isalive()) {
      data.playerdeath = 1;
    }

    if(istrue(player.inlaststand)) {
      data.playerlaststand = 1;
    }

    if(istrue(player.liveragdoll)) {
      data.playerliveragdoll = 1;
    }
  } else {
    data.playerdisconnect = 1;
  }

  thread vehicle_occupancy_exit(vehicle, seatid, player, data, undefined, specialexit);
}

function vehicle_occupancy_monitorexitinternal(vehicle, player, seatid) {
  player endon("death_or_disconnect");
  player endon("last_stand_start");
  player endon("enter_live_ragdoll");
  endtime = gettime() + 300;
  buttonreleased = 0;
  roofexittype = vehicle_occupancy_getleveldataforvehicle(vehicle function_d93ec4635290febd()).roofexittype;
  var_7a888fdba3dfb003 = istrue(level.var_351aab391da578a8) && isDefined(roofexittype) && player function_46ca2675c0578280();
  var_edc035ec125029eb = istrue(level.var_73d6c6366970020);
  player setclientomnvar("ui_veh_exit_button_holdtime", 0);

  while(true) {
    if(!player useButtonPressed()) {
      buttonreleased = 1;
    }

    if(buttonreleased && gettime() >= endtime) {
      break;
    }

    waitframe();
  }

  updaterate = level.framedurationseconds;
  var_33193f537b85b6d4 = getdvarint(@ "hash_9402582f8123db99", 250) / 1000;
  var_b24cf95b8cf123c = 0;
  var_7f08bbc709d0effc = undefined;

  while(true) {
    timeused = 0;
    usereloadconfig = player getcurrentusereloadconfig();
    var_556640f47976049a = 0;
    player setclientomnvar("ui_veh_exit_button_holdtime", 0);

    while(player useButtonPressed()) {
      player disablereloading();
      player cancelreloading();
      var_556640f47976049a = 1;
      timeused += updaterate;
      isgamepad = player usinggamepad();
      var_b97750d9099a9b79 = player getuseholdkbmprofile();
      var_73780d1b420d7903 = !isgamepad && !var_b97750d9099a9b79;
      var_caaa0275d82bfee1 = !isgamepad && var_b97750d9099a9b79;
      var_8b3c790f008214a9 = isgamepad && usereloadconfig == 0;
      var_97e758980add17ef = isgamepad && usereloadconfig > 0;
      var_41bd24e292fb94e0 = var_8b3c790f008214a9 || var_caaa0275d82bfee1;

      if(var_8b3c790f008214a9 || var_caaa0275d82bfee1) {
        player setclientomnvar("ui_veh_exit_button_holdtime", timeused / 0.3);
      }

      if(var_41bd24e292fb94e0 && timeused > 0.3 || var_73780d1b420d7903) {
        return ter_op(var_edc035ec125029eb && player isinvehicleleanout() && vehicle vehicle_getspeed() > 10, "_to_dive", undefined);
      } else if(var_97e758980add17ef && timeused >= var_33193f537b85b6d4) {
        player enablereloading();
        player forcereloading();
      }

      wait updaterate;
    }

    if(var_556640f47976049a && player usinggamepad() && usereloadconfig > 0 && timeused < var_33193f537b85b6d4) {
      return ter_op(var_edc035ec125029eb && player isinvehicleleanout() && vehicle vehicle_getspeed() > 10, "_to_dive", undefined);
    } else if(var_556640f47976049a) {
      player enablereloading();
      player forcereloading();
    }

    if(var_7a888fdba3dfb003) {
      var_b24cf95b8cf123c |= player jumpbuttonPressed();

      if(player jumpbuttonPressed()) {
        var_7f08bbc709d0effc = gettime();
      } else if(var_b24cf95b8cf123c && isDefined(var_7f08bbc709d0effc) && var_7f08bbc709d0effc + 400 < gettime()) {
        var_b24cf95b8cf123c = 0;
      }

      if(var_b24cf95b8cf123c && !player function_e1b085052385d056() && player function_46ca2675c0578280()) {
        return "_to_roof";
      }
    }

    waitframe();
  }
}

function vehicle_occupancy_errormessage(player, errorref) {
  errorstr = undefined;

  switch (errorref) {
    case 1:
      errorstr = "VEHICLES/SEAT_SWITCH_OCCUPIED";
      break;
    case 2:
      errorstr = "VEHICLES/CANNOT_EXIT";
      break;
    case 3:
      errorstr = "VEHICLES/GRENADE_TURRET_LOCKED";
      break;
  }

  assertex(isDefined(errorstr), "<dev string:x894>");

  if(issharedfuncdefined("hud", "showErrorMessage")) {
    player[[getsharedfunc("hud", "showErrorMessage")]](errorstr);
  }
}

function vehicle_occupancy_monitorgameended(vehicle, player, seatid) {
  player endon("death_or_disconnect");
  player endon("last_stand_start");
  player notify("vehicle_occupancy_monitorGameEnded");
  player endon("vehicle_occupancy_monitorGameEnded");

  if(seatid == scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverseat(vehicle)) {
    level waittill("game_ended");
    player allowmovement(0);
  }
}

function vehicle_occupancy_monitorcontrols(vehicle, player, seatid) {
  player endon("death_or_disconnect");
  player endon("last_stand_start");
  vehicle endon("death");
  level endon("game_ended");
  player notify("vehicle_occupancy_monitorControls");
  player endon("vehicle_occupancy_monitorControls");

  if(scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_controlsarefadedoutorhidden(player)) {
    return;
  }

  if(true) {
    wait 1.5;
  }

  childthread vehicle_occupancy_monitormovementcontrols(vehicle, player, seatid);
  childthread vehicle_occupancy_monitorturretcontrols(vehicle, player, seatid);
  leveldataforvehicle = vehicle_occupancy_getleveldataforvehicle(vehicle.vehiclename);

  if(isDefined(leveldataforvehicle.monitorcontrolscallback)) {
    childthread[[leveldataforvehicle.monitorcontrolscallback]](vehicle, player, seatid, "vehicle_occupancy_monitorControls");
  }
}

function vehicle_occupancy_fadeoutcontrols(player) {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_fadeoutcontrols(player);
  player notify("vehicle_occupancy_monitorControls");
}

function vehicle_occupancy_monitormovementcontrols(vehicle, player, seatid) {
  driverseatid = vehicle_occupancy_getdriverseat(vehicle);

  if(seatid == driverseatid) {
    canfly = vehicle vehiclecanfly();

    if(canfly) {
      while(true) {
        forward = vehicle vehicle_getinputvalue(0);
        turn = vehicle vehicle_getinputvalue(2);
        strafe = vehicle vehicle_getinputvalue(1);
        ascend = vehicle vehicle_getinputvalue(3);

        if(abs(forward) > 0 || abs(turn) > 0 || abs(strafe) > 0 || abs(ascend) > 0) {
          vehicle_occupancy_fadeoutcontrols(player);
        }

        wait 0.05;
      }

      return;
    }

    while(true) {
      gasinput = vehicle vehicle_getinputvalue(4);

      if(abs(gasinput) >= 0.2) {
        vehicle_occupancy_fadeoutcontrols(player);
      }

      wait 0.05;
    }
  }
}

function vehicle_occupancy_monitorturretcontrols(vehicle, player, seatid) {
  leveldataforseat = vehicle_occupancy_getleveldataforseat(vehicle.vehiclename, seatid);

  if(isDefined(leveldataforseat.turretobjweapon)) {
    turret = vehicle_getturretbyweapon(vehicle, leveldataforseat.turretobjweapon);

    if(isDefined(turret)) {
      turret waittill_any_2("turret_fire", "turret_reload");
      vehicle_occupancy_fadeoutcontrols(player);
    }
  }
}

function function_2e58e7b01554419a(vehicleref, seatid) {
  leveldataforseat = vehicle_occupancy_getleveldataforseat(vehicleref, seatid);

  if(isDefined(leveldataforseat) && isDefined(leveldataforseat.turretobjweapon)) {
    return leveldataforseat.turretobjweapon;
  }

  return undefined;
}

function vehicle_occupancy_raceplayerdeathdisconnect(player, data) {
  data endon(data.raceendon);
  result = player waittill_any_return_no_endon_death_5("death", "disconnect", "last_stand_start", "enter_live_ragdoll", "interrupt_roof_exit");

  if(result == "death") {
    data.playerdeath = 1;
  } else if(result == "disconnect") {
    data.playerdisconnect = 1;
  } else if(result == "last_stand_start") {
    data.playerlaststand = 1;
  } else if(result == "enter_live_ragdoll") {
    data.playerliveragdoll = 1;
  } else if(result == "interrupt_roof_exit") {
    data.var_f276d4e53593ec9a = 1;
  }

  data notify(data.raceendnotify);
}

function vehicle_occupancy_racevehicledeath(vehicle, data) {
  data endon(data.raceendon);
  vehicle waittill("death");
  data.vehicledeath = 1;
  data notify(data.raceendnotify);
}

function vehicle_occupancy_raceseatunavailable(vehicle, player, seatid, oldseatid, data) {
  data endon(data.raceendon);

  while(isDefined(vehicle)) {
    if(!vehicle_occupancy_seatisavailable(vehicle, seatid, player)) {
      data.seatunavailable = 1;
      data notify(data.raceendnotify);
      break;
    }

    waitframe();
  }
}

function vehicle_occupancy_racecomplete(oldseatid, newseatid, data) {
  data endon(data.raceendon);

  if(isDefined(oldseatid) && isDefined(newseatid)) {
    while(!istrue(data.enterstartcomplete) || !istrue(data.exitstartcomplete)) {
      waitframe();
    }
  } else if(isDefined(oldseatid)) {
    while(!istrue(data.exitstartcomplete)) {
      waitframe();
    }
  } else {
    while(!istrue(data.enterstartcomplete)) {
      waitframe();
    }
  }

  data notify(data.raceendnotify);
}

function vehicle_occupancy_raceresults(vehicle, player, oldseatid, newseatid, data) {
  if(!isDefined(data.success)) {
    data.success = 1;
  }

  if(data.immediate) {
    data.playerdisconnect = ter_op(isDefined(player), 0, 1);

    if(!data.playerdisconnect) {
      data.playerdeath = !player _isalive();
      data.playerlaststand = istrue(player.inlaststand);
      data.playerliveragdoll = istrue(player.liveragdoll);
    }

    data.vehicledeath = istrue(vehicle.isdestroyed);
  } else if(data.success) {
    if(isDefined(oldseatid) && !istrue(data.exitstartcomplete)) {
      data.success = 0;
    }

    if(isDefined(newseatid) && !istrue(data.enterstartcomplete)) {
      data.success = 0;
    }

    if(istrue(data.vehicledeath)) {
      data.success = 0;
    }

    if(istrue(data.var_f276d4e53593ec9a)) {
      data.success = 0;
    }
  } else {
    return 0;
  }

  if(isDefined(newseatid)) {
    if(istrue(data.playerdeath) || istrue(data.playerliveragdoll) || istrue(data.playerlaststand) || istrue(data.playerdisconnect) || istrue(data.vehicledeath) || istrue(data.seatunavailable)) {
      data.success = 0;
    }
  }

  return data.success;
}

function vehicle_occupancy_watchowner(vehicle, player, var_57c14bf60c5be4ab, timeroverride) {
  player endon("disconnect");
  vehicle endon("death");
  vehicle endon("vehicle_clear_owner_" + player getentitynumber());

  if(istrue(var_57c14bf60c5be4ab)) {
    player waittill("vehicle_seat_exit");
  }

  var_f86fb0e66b52ea3b = ter_op(isDefined(timeroverride), timeroverride, 20);
  wait var_f86fb0e66b52ea3b;
  thread vehicle_occupancy_clearowner(vehicle, player);
}

function vehicle_occupancy_watchownerjoinedteam(vehicle, player) {
  player endon("disconnect");
  vehicle endon("death");
  vehicle endon("vehicle_owner_update");
  player waittill_any_2("joined_team", "joined_spectators");
  thread vehicle_occupancy_updateowner(vehicle);
}

function vehicle_occupancy_isplayervalidowner(vehicle, player) {
  if(!isDefined(player)) {
    return false;
  }

  if(level.teambased && isDefined(vehicle.team)) {
    if(vehicle.team != "neutral" && player.team != vehicle.team) {
      return false;
    }
  } else if(isDefined(vehicle.originalowner)) {
    if(player != vehicle.originalowner) {
      return false;
    }
  }

  return true;
}

function vehicle_occupancy_animateplayer(vehicle, seatid, oldseatid, animtype, var_d65ff23efe3b8aa9, var_3f9690fb0c8ebc84) {
  leveldataforseat = vehicle_occupancy_getleveldataforseat(vehicle.vehiclename, seatid);

  if(!isDefined(leveldataforseat.animtag)) {
    return;
  }

  if(isDefined(var_d65ff23efe3b8aa9) || isDefined(var_3f9690fb0c8ebc84)) {
    assertex(isDefined(var_d65ff23efe3b8aa9), "<dev string:x8d7>");
    assertex(isDefined(var_3f9690fb0c8ebc84), "<dev string:x8d7>");
    function_d1c52700cb7ddbf3(var_d65ff23efe3b8aa9, var_3f9690fb0c8ebc84);
    thread function_233275857335e4dc(1);
  }

  self cancelmantle();
  enterseatindex = 0;
  seattag = leveldataforseat.animtag;

  if(issubstr(seattag, "tag_seat_")) {
    enterseatindex = int(getsubstr(seattag, 9));
  } else if(issubstr(seattag, "tag_gunner")) {
    substr = getsubstr(seattag, 10);
    enterseatindex = int(substr) + 10 - 1;
  } else if(issubstr(seattag, "gunner_")) {
    enterseatindex = int(getsubstr(seattag, 7)) + 10 - 1;
  }

  isexitvehicle = !isDefined(seatid);
  function_c9b87beb89ec12e2(self, vehicle, isexitvehicle);
  isentervehicle = !isDefined(oldseatid) && isDefined(seatid);
  isroofentrance = self usevehicle(vehicle, enterseatindex, isentervehicle);

  if(istrue(isroofentrance) && vehicle function_452936099dcd1b94(seatid)) {
    vehicle function_14219d4c7d83499f(seatid);
  }
}

function function_d1c52700cb7ddbf3(type, seat) {
  self notify("OverrideVehicleSeatAnimConditionals");
  self overridevehicleseatanimconditionals(type, seat);
}

function function_233275857335e4dc(delayed) {
  self endon("death_or_disconnect");
  self notify("OverrideVehicleSeatAnimConditionals");
  self endon("OverrideVehicleSeatAnimConditionals");

  if(istrue(delayed)) {
    waitframe();
  }

  self overridevehicleseatanimconditionals("", 0);
}

function function_ee4b8b879b1b120c() {
  if(istrue(self.isheli) && self getscriptablehaspart("Exhaust")) {
    self setscriptablepartstate("Exhaust", "off");
  }
}

function function_ba42cf4e5bb24367() {
  hasexhaust = self getscriptablehaspart("Exhaust");
  haslights = self getscriptablehaspart("NaviLights");

  if(!hasexhaust && !haslights) {
    return;
  }

  self endon("death");
  self notify("stopHeliEffectsAfterTime");
  self endon("stopHeliEffectsAfterTime");
  self.var_19169da06f71a4f2 = "waitingToTurnOff";
  wait 6;

  while(istrue(self.ishovering)) {
    wait 2;
  }

  if(!isDefined(self.var_19169da06f71a4f2) || self.var_19169da06f71a4f2 != "waitingToTurnOff") {
    return;
  }

  self.var_19169da06f71a4f2 = undefined;

  if(hasexhaust && self getscriptablepartstate("Exhaust") == "on") {
    self setscriptablepartstate("Exhaust", "off");
  }

  if(haslights && self getscriptablepartstate("NaviLights") == "on") {
    self setscriptablepartstate("NaviLights", "off");
  }
}

function function_a91927df280e94e4() {
  if(!isDefined(self.var_19169da06f71a4f2)) {
    if(self getscriptablehaspart("Exhaust") && vehicle_damage_getstate() == "pristine" && (!isDefined(self.fuel) || self.fuel > 0)) {
      self setscriptablepartstate("Exhaust", "on");
    }

    if(self getscriptablehaspart("NaviLights")) {
      self setscriptablepartstate("NaviLights", "on");
    }
  }

  self.var_19169da06f71a4f2 = "playing";
}

function function_4e7868ef633f4b36() {
  self endon("death");
  self endon("unanchored");

  while(self vehicle_getspeed() > 2) {
    wait 0.2;
  }

  self function_481c2a63f2ba3332(-1, 100);
}

function function_3112242e4bc392de() {
  self notify("unanchored");
  self function_481c2a63f2ba3332(0);
}

function function_a1a583c3cc871645(bool) {
  if(bool) {
    assert(isDefined(self.firedisabled) && self.firedisabled > 0, "<dev string:x924>");
    self.firedisabled--;

    if(self.firedisabled == 0) {
      self.firedisabled = undefined;

      foreach(occupant in function_f6cb37189c84811b()) {
        occupant val::set("vehicle_occupant", "fire", 1);
      }

      if(isDefined(self.turretoccupants)) {
        foreach(occupant in self.turretoccupants) {
          occupant val::set("vehicle_turret", "fire", 1);
        }
      }
    }

    return;
  }

  if(!isDefined(self.firedisabled)) {
    self.firedisabled = 0;
  }

  self.firedisabled++;

  if(self.firedisabled == 1) {
    foreach(occupant in function_f6cb37189c84811b()) {
      occupant val::set("vehicle_occupant", "fire", 0);
    }

    if(isDefined(self.turretoccupants)) {
      foreach(occupant in self.turretoccupants) {
        occupant val::set("vehicle_turret", "fire", 0);
      }
    }
  }
}

function function_80d84f556cc8017a() {
  return isDefined(self) && isDefined(self.firedisabled) && self.firedisabled > 0;
}

function function_f6cb37189c84811b() {
  vehicleref = function_d93ec4635290febd();
  var_ff131bcd82ff52d9 = [];

  foreach(seatid in vehicle_occupancy_getallvehicleseats(self)) {
    if(function_1003e8d7c662a2ff(vehicleref, seatid)) {
      occupant = vehicle_occupancy_getseatoccupant(self, seatid, 0);

      if(isDefined(occupant) && isPlayer(occupant)) {
        var_ff131bcd82ff52d9[var_ff131bcd82ff52d9.size] = occupant;
      }
    }
  }

  return var_ff131bcd82ff52d9;
}

function function_1003e8d7c662a2ff(vehicleref, seatid) {
  seatdata = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(vehicleref, seatid);
  return isDefined(seatdata) && istrue(seatdata.hasvehicleweapon);
}

function function_f654c168752ed299() {
  return isDefined(self) && self vehicle_isphysveh() && self vehphys_isgroundvehicle();
}

function vehicle_occupancy_allowmovement(vehicle, bool, showwarning, var_f4942f1848b5b6ca) {
  if(bool) {
    assert(isDefined(vehicle.movementdisabled) && vehicle.movementdisabled > 0, "<dev string:x924>");
    vehicle.movementdisabled--;

    if(vehicle.movementdisabled == 0) {
      occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289(vehicle);

      if(isDefined(occupants)) {
        scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("movementDisabled", occupants, vehicle function_d93ec4635290febd());

        if(vehicle hascomponent("p2p")) {
          vehicle setconfigvalue("p2p", "resume", 1);
        }

        if(vehicle function_f654c168752ed299()) {
          vehicle function_64d8ae560c3ec9b6(0);
        } else {
          foreach(seatid, occupant in vehicle.occupants) {
            vehicle_occupancy_allowmovementplayer(vehicle, occupant, 1, seatid);
          }
        }
      }

      return 1;
    }

    return;
  }

  if(!isDefined(vehicle.movementdisabled)) {
    vehicle.movementdisabled = 0;
  }

  vehicle.movementdisabled++;

  if(vehicle.movementdisabled == 1) {
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289(vehicle);

    if(isDefined(occupants)) {
      if(!isDefined(showwarning) || showwarning == 1) {
        scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("movementDisabled", occupants, vehicle function_d93ec4635290febd());
      }

      if(vehicle hascomponent("p2p") && !istrue(var_f4942f1848b5b6ca)) {
        vehicle setconfigvalue("p2p", "pause", 1);
      }

      if(vehicle function_f654c168752ed299()) {
        vehicle function_64d8ae560c3ec9b6(1);
        vehicle.veh_throttle = 0;
      } else {
        foreach(seatid, occupant in vehicle.occupants) {
          vehicle_occupancy_allowmovementplayer(vehicle, occupant, 0, seatid);
        }
      }
    }

    return 0;
  }
}

function vehicle_occupancy_clearallowmovement(vehicle) {
  if(vehicle function_f654c168752ed299()) {
    vehicle function_64d8ae560c3ec9b6(0);
  } else if(isDefined(vehicle.occupants)) {
    foreach(seatid, occupant in vehicle.occupants) {
      vehicle_occupancy_allowmovementplayer(1, occupant, seatid);
    }
  }

  vehicle.movementdisabled = undefined;
}

function vehicle_occupancy_allowmovementplayer(vehicle, player, bool, seatid) {
  if(bool) {
    if(istrue(player.vehicledisabledmovement)) {
      if(player _isalive()) {
        player val::reset_all("vehicle_occupancy");
      }

      player.vehicledisabledmovement = undefined;
    }

    return;
  }

  leveldataforseat = vehicle_occupancy_getleveldataforseat(vehicle.vehiclename, seatid);

  if(isDefined(leveldataforseat.animtag) && leveldataforseat.animtag == "tag_seat_0") {
    if(!istrue(player.vehicledisabledmovement)) {
      if(player _isalive()) {
        player val::set("vehicle_occupancy", "allow_movement", 0);
        player.vehicledisabledmovement = 1;
      }
    }
  }
}

function vehicle_occupancy_clearallowmovementplayer(player, fromdeath) {
  if(!istrue(fromdeath) && istrue(player.vehicledisabledmovement)) {
    player val::reset_all("vehicle_occupancy");
  }

  player.vehicledisabledmovement = undefined;
}

function vehicle_occupancy_movementisallowed(vehicle) {
  return !isDefined(vehicle.movementdisabled) || vehicle.movementdisabled <= 0;
}

function function_ac0a3326d43eb8fd() {
  vehicle_occupancy_allowmovement(self, 0, 0);
  scripts\cp_mp\vehicles\vehicle_occupancy::function_d0092c44c5588870();

  if(self vehicle_isphysveh()) {
    self vehphys_parkingbrake(1);
  }

  self.islocked = 1;
  occupants = function_efa75aa7f0a1289(self);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("locked", occupants, function_d93ec4635290febd());
}

function function_474237292e64417e() {
  vehicle_occupancy_allowmovement(self, 1, 0);
  scripts\cp_mp\vehicles\vehicle_occupancy::function_7c81e0d41cbbce7f();
  scripts\cp_mp\vehicles\vehicle_occupancy::function_9e710c9f3a15ffda();

  if(self vehicle_isphysveh()) {
    self vehphys_parkingbrake(0);
  }

  self.islocked = undefined;
  occupants = function_efa75aa7f0a1289(self);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("locked", occupants, function_d93ec4635290febd());
}

function function_72f871bf74995298() {
  return isDefined(self) && istrue(self.islocked);
}

function vehicle_occupancy_getexitpositionandangles(vehicle, player, seatid, allowairexit, islaststand, specialexit) {
  exitboundinginfo = function_517f60905f08bf96(vehicle);
  leveldataforseat = vehicle_occupancy_getleveldataforseat(vehicle function_d93ec4635290febd(), seatid);
  leveldataforvehicle = vehicle_occupancy_getleveldataforvehicle(vehicle function_d93ec4635290febd());

  if(isDefined(specialexit)) {
    exitid = seatid + specialexit;
    exitdirection = leveldataforvehicle.exitdirections[exitid];
    position = vehicle_occupancy_getexitposition(vehicle, player, exitid, exitboundinginfo, 1);

    if(isDefined(position)) {
      angles = undefined;

      if(!isDefined(leveldataforseat.animtag) || leveldataforseat.animtag != "tag_seat_0") {
        angles = vehicle_occupancy_getexitangles(vehicle, player, exitid, islaststand);
      }

      if(specialexit == "_to_roof") {
        player notify("roof_exit");
      }

      return [position, angles, specialexit, exitdirection];
    }
  }

  skipexits = 0;

  skipexits = getdvarint(@ "hash_7ae0d88acb509143", 0);

  foreach(exitstruct in leveldataforseat.exitids) {
    exitid = exitstruct.exitdirection;
    exitdirection = leveldataforvehicle.exitdirections[exitid];

    if(exitdirection == "roof" || exitdirection == "dive") {
      continue;
    }

    if(skipexits > 0) {
      skipexits -= 1;
      continue;
    }

    position = vehicle_occupancy_getexitposition(vehicle, player, exitid, exitboundinginfo, allowairexit);

    if(isDefined(position)) {
      angles = undefined;

      if(!isDefined(leveldataforseat.animtag) || leveldataforseat.animtag != "tag_seat_0") {
        angles = vehicle_occupancy_getexitangles(vehicle, player, exitid, islaststand);
      }

      return [position, angles, undefined, exitdirection];
    }
  }

  if(getdvarint(@ "hash_9c95c78d2efca328", 1) == 1) {
    position = function_ca069b5427d4ff47(vehicle, player);

    if(isDefined(position)) {
      return [position, undefined, undefined, "front"];
    }
  }

  return undefined;
}

function vehicle_occupancy_getexitposition(vehicle, player, exitid, exitinfo, allowairexit) {
  if(!isDefined(vehicle) || !isDefined(player) || !isDefined(exitid)) {
    assertmsg("<dev string:x98c>" + isDefined(vehicle) + "<dev string:x9a6>" + isDefined(player) + "<dev string:x9c0>" + isDefined(exitid));
    return;
  }

  data = vehicle_occupancy_getleveldataforvehicle(vehicle function_d93ec4635290febd());

  if(!isDefined(data)) {
    assertmsg("<dev string:x9da>" + isDefined(data));
    return;
  }

  if(istrue(exitinfo.exitsfailed[exitid])) {
    return;
  }

  if(isDefined(exitinfo.exitpositions[exitid])) {
    return exitinfo.exitpositions[exitid];
  }

  if(!isDefined(data.exitoffsets[exitid])) {
    assertmsg("<dev string:x9f1>" + exitid + "<dev string:xa07>");
    return;
  }

  if(!isDefined(data.exitdirections[exitid])) {
    assertmsg("<dev string:xa1e>" + exitid + "<dev string:xa07>");
    return;
  }

  exitoffset = data.exitoffsets[exitid];
  exitdirection = data.exitdirections[exitid];

  if(getDvar(@ "hash_6d41518ba7b7fe27", "<dev string:xa37>") != "<dev string:xa37>") {
    exitoffset = getdvarvector(@ "hash_6d41518ba7b7fe27", exitoffset);
  }

  if(exitdirection == "roof" && data.roofexittype == "animated") {
    exitposition = vehicle.origin + rotatevector(exitoffset, vehicle.angles);
    exitinfo.exitpositions[exitid] = exitposition;
    return exitposition;
  }

  contents = physics_createcontents(["physicscontents_item", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_vehicleclip", "physicscontents_playerclip"]);
  ignorelist = [];

  foreach(ent in vehicle getlinkedchildren(1)) {
    if(!isPlayer(ent)) {
      ignorelist[ignorelist.size] = ent;
    }
  }

  ignorelist[ignorelist.size] = vehicle;
  ignorelist[ignorelist.size] = player;

  if(exitdirection == "inside" || exitdirection == "dive" || exitdirection == "roof" || exitdirection == "top") {
    caststart = vehicle.origin + rotatevector(exitoffset, vehicle.angles);
    castend = caststart;
    castend = function_fe33f8f45b65696e(player, caststart, castend, ignorelist, allowairexit, exitdirection);

    if(!isDefined(castend)) {
      exitinfo.exitsfailed[exitid] = 1;
      return;
    }

    exitinfo.exitpositions[exitid] = castend;
    return castend;
  }

  if(istrue(exitinfo.var_8f7c0dee5d7bdae)) {
    exitinfo.exitsfailed[exitid] = 1;
    return;
  }

  centertag = ter_op(vehicle tagexists("tag_body_animate"), "tag_body_animate", "tag_body");
  center = vehicle gettagorigin(centertag);
  isflipped = anglebetweenvectors(anglestoup(vehicle.angles), (0, 0, 1)) > 90;
  tiltoffset = 16;
  downoffset = 0;
  castingdown = 0;

  switch (exitdirection) {
    case #"hash_4b8799075d3a89b8":
      tiltangle = vehicle.angles[0];

      if(tiltangle == 90 || tiltangle == 270) {
        tilttan = 1;
      } else {
        tilttan = tan(tiltangle);
      }

      castingdown = tilttan > 0;

      if(castingdown) {
        downoffset += abs(sin(tiltangle)) * (data.exitextents["front"] + 16);
        hypotenuse = data.exitextents["front"] + abs(tilttan) * data.exitextents["top"];
        tiltoffset += abs(cos(tiltangle) * hypotenuse);
        exitoffset = (max(exitoffset[0], tiltoffset), exitoffset[1], exitoffset[2]);
      } else {
        tiltoffset += min(abs(tilttan), 1) * (data.exitextents["bottom"] + 10);
        exitoffset = (max(exitoffset[0], data.exitextents["front"] + tiltoffset), exitoffset[1], exitoffset[2]);
      }

      break;
    case #"hash_5163a22eb8c03302":
      tiltangle = vehicle.angles[0];

      if(tiltangle == 90 || tiltangle == 270) {
        tilttan = 1;
      } else {
        tilttan = tan(tiltangle);
      }

      castingdown = tilttan < 0;

      if(castingdown) {
        downoffset += abs(sin(tiltangle)) * (data.exitextents["back"] + 16);
        hypotenuse = data.exitextents["back"] + abs(tilttan) * data.exitextents["top"];
        tiltoffset += abs(cos(tiltangle) * hypotenuse);
        exitoffset = (min(exitoffset[0], -1 * tiltoffset), exitoffset[1], exitoffset[2]);
      } else {
        tiltoffset += min(abs(tilttan), 1) * (data.exitextents["bottom"] + 10);
        exitoffset = (min(exitoffset[0], -1 * (data.exitextents["back"] + tiltoffset)), exitoffset[1], exitoffset[2]);
      }

      break;
    case #"hash_c9b3133a17a3b2d0":
      tiltangle = vehicle.angles[2];

      if(tiltangle == 90 || tiltangle == 270) {
        tilttan = 1;
      } else {
        tilttan = tan(tiltangle);
      }

      castingdown = tilttan < 0;

      if(castingdown) {
        downoffset += abs(sin(tiltangle)) * (data.exitextents["left"] + 16);
        hypotenuse = data.exitextents["left"] + abs(tilttan) * data.exitextents["top"];
        tiltoffset += abs(cos(tiltangle)) * hypotenuse;
        exitoffset = (exitoffset[0], max(exitoffset[1], tiltoffset), exitoffset[2]);
      } else {
        tiltoffset += min(abs(tilttan), 1) * (data.exitextents["bottom"] + 10);
        exitoffset = (exitoffset[0], max(exitoffset[1], data.exitextents["left"] + tiltoffset), exitoffset[2]);
      }

      break;
    case #"hash_96815ce4f2a3dbc5":
      tiltangle = vehicle.angles[2];

      if(tiltangle == 90 || tiltangle == 270) {
        tilttan = 1;
      } else {
        tilttan = tan(tiltangle);
      }

      castingdown = tilttan > 0;

      if(castingdown) {
        downoffset += abs(sin(tiltangle)) * (data.exitextents["right"] + 16);
        hypotenuse = data.exitextents["right"] + abs(tilttan) * data.exitextents["top"];
        tiltoffset += abs(cos(tiltangle)) * hypotenuse;
        exitoffset = (exitoffset[0], min(exitoffset[1], -1 * tiltoffset), exitoffset[2]);
      } else {
        tiltoffset += min(abs(tilttan), 1) * (data.exitextents["bottom"] + 10);
        exitoffset = (exitoffset[0], min(exitoffset[1], -1 * (data.exitextents["right"] + tiltoffset)), exitoffset[2]);
      }

      break;
  }

  angles = ter_op(castingdown, (0, vehicle.angles[1], 0), vehicle.angles);
  exitoffset = center + rotatevector((exitoffset[0], exitoffset[1], 10), angles);

  if(isflipped) {
    exitoffset += (0, 0, 20);
  }

  if(!isDefined(exitinfo.spherecastradius)) {
    exitinfo.spherecastradius = 16;
  }

  spherecastradius = exitinfo.spherecastradius;

  for(var_145d0dc29d9bde7 = physics_spherecast(center, exitoffset, spherecastradius, contents, ignorelist, "physicsquery_closest", "physicsquery_any", 1); isDefined(var_145d0dc29d9bde7) && istrue(var_145d0dc29d9bde7[1]); var_145d0dc29d9bde7 = physics_spherecast(center, exitoffset, exitinfo.spherecastradius, contents, ignorelist, "physicsquery_closest", "physicsquery_any", 1)) {
    if(exitinfo.spherecastradius == 16) {
      exitinfo.spherecastradius = 10;
      continue;
    }

    if(exitinfo.spherecastradius == 10) {
      exitinfo.spherecastradius = 5;
      continue;
    }

    exitinfo.var_8f7c0dee5d7bdae = 1;
    exitinfo.exitsfailed[exitid] = 1;
    return;
  }

  if(isDefined(var_145d0dc29d9bde7) && (istrue(var_145d0dc29d9bde7[1]) || isDefined(var_145d0dc29d9bde7[0]) && isDefined(var_145d0dc29d9bde7[0][0]) && isDefined(var_145d0dc29d9bde7[0][0]["position"]))) {
    finalposition = exitoffset;

    if(isDefined(var_145d0dc29d9bde7[0]) && isDefined(var_145d0dc29d9bde7[0][0]) && isDefined(var_145d0dc29d9bde7[0][0]["<dev string:xa3c>"])) {
      finalposition = var_145d0dc29d9bde7[0][0]["<dev string:xa3c>"];
    }

    if(istrue(level.debugvehicleexit)) {
      if(isDefined(var_145d0dc29d9bde7[0]) && isDefined(var_145d0dc29d9bde7[0][0]) && isDefined(var_145d0dc29d9bde7[0][0]["<dev string:xa4e>"])) {
        level thread function_2127168686332a93(var_145d0dc29d9bde7[0][0]["<dev string:xa4e>"], 2, 60, (1, 0, 0));
      }

      level thread function_6bb041ee1ab70e18(center, finalposition, spherecastradius, 60, (0, 1, 0));
    }

    exitinfo.exitsfailed[exitid] = 1;
    return;
  }

  if(istrue(level.debugvehicleexit)) {
    level thread function_6bb041ee1ab70e18(center, exitoffset, spherecastradius, 60, (0, 1, 0));
  }

  castupposition = exitoffset + (0, 0, 72);
  castup = physics_raycast(exitoffset, castupposition, contents, ignorelist, 0, "physicsquery_closest", 1);

  if(isDefined(castup) && isDefined(castup[0]) && isDefined(castup[0]["position"])) {
    castupposition = castup[0]["position"];

    if(istrue(level.debugvehicleexit)) {
      level thread function_2127168686332a93(castupposition, 2, 60, (1, 0, 0));
    }
  }

  if(istrue(level.debugvehicleexit)) {
    level thread function_a03a1d77df140f9c(exitoffset, castupposition, 60, (0, 0, 1));
  }

  finalcaststart = castupposition - (0, 0, 72 + 10);
  finalcastend = castupposition - (0, 0, data.exitextents["bottom"] + 125 + downoffset);
  castend = function_fe33f8f45b65696e(player, finalcaststart, finalcastend, ignorelist, allowairexit, exitdirection);

  if(!isDefined(castend)) {
    exitinfo.exitsfailed[exitid] = 1;
    return;
  }

  exitinfo.exitpositions[exitid] = castend;
  return castend;
}

function function_ca069b5427d4ff47(vehicle, player) {
  throughwallexits = [];
  var_46b3d89477cbf92a = [];
  ignorelist = [player];
  contents = physics_createcontents(["physicscontents_item", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_vehicleclip", "physicscontents_playerclip", "physicscontents_characterproxy"]);

  if(isnavmeshloaded()) {
    leveldataforvehicle = vehicle_occupancy_getleveldataforvehicle(vehicle function_d93ec4635290febd());

    if(vehicle function_a24042975031e692()) {
      points = [vehicle.origin + rotatevector((0, leveldataforvehicle.exitextents["left"] + 50, 0), vehicle.angles), vehicle.origin + rotatevector((0, -1 * (leveldataforvehicle.exitextents["right"] + 50), 0), vehicle.angles), vehicle.origin + rotatevector((-1 * (leveldataforvehicle.exitextents["back"] + 50), 0, 0), vehicle.angles), vehicle.origin + rotatevector((leveldataforvehicle.exitextents["front"] + 50, 0, 0), vehicle.angles)];
    } else {
      points = [player.origin];
    }

    foreach(point in points) {
      onnavmesh = getclosestpointonnavmesh(point);
      castend = function_fe33f8f45b65696e(player, onnavmesh + (0, 0, 10), onnavmesh - (0, 0, 20), ignorelist, 1, "inside");

      if(isDefined(castend)) {
        castresults = physics_raycast(vehicle.origin, castend + (0, 0, 72 / 2), contents, [vehicle, player], 0, "physicsquery_all", 1);

        if(istrue(level.debugvehicleexit)) {
          thread function_a03a1d77df140f9c(vehicle.origin, castend + (0, 0, 72 / 2), 60, ter_op(isDefined(castresults) && castresults.size > 0, (1, 0, 0), (0, 1, 1)));
        }

        if(isDefined(castresults) && castresults.size > 0) {
          throughwall = 0;

          foreach(hit in castresults) {
            if(isDefined(hit["hittype"]) && hit["hittype"] != "hittype_entity") {
              throughwall = 1;
              break;
            }
          }

          if(throughwall) {
            throughwallexits[throughwallexits.size] = castend;
          } else {
            var_46b3d89477cbf92a[var_46b3d89477cbf92a.size] = castend;
          }

          continue;
        }

        return castend;
      }
    }
  }

  if(var_46b3d89477cbf92a.size > 0) {
    return var_46b3d89477cbf92a[0];
  }

  if(throughwallexits.size > 0) {
    return throughwallexits[0];
  }

  nodes = getnodesinradiussorted(vehicle.origin, 800, 0, 250, "path");

  if(!isDefined(nodes) || nodes.size <= 0) {
    vecs = getrandomnavpoints(vehicle.origin, 800, 6);

    if(!isDefined(vecs) || vecs.size <= 0) {
      return;
    }

    nodes = [];

    foreach(vec in vecs) {
      node = spawnStruct();
      node.origin = vec;
      nodes[nodes.size] = node;
    }

    nodes = sortbydistance(nodes, vehicle.origin);
  }

  nodestried = 0;

  foreach(node in nodes) {
    castend = function_fe33f8f45b65696e(player, node.origin, node.origin, ignorelist, 1, "inside");

    if(isDefined(castend)) {
      return castend;
    }

    nodestried += 1;

    if(nodestried > 5) {
      break;
    }
  }
}

function private function_136fea30dbedce0f(vehicle, player, origin) {
  ignorelist = [];

  foreach(ent in vehicle getlinkedchildren(1)) {
    if(!isPlayer(ent)) {
      ignorelist[ignorelist.size] = ent;
    }
  }

  ignorelist[ignorelist.size] = vehicle;
  castend = origin;
  castend = function_fe33f8f45b65696e(player, origin, castend, ignorelist, 1, "inside");
  return isDefined(castend);
}

function private function_fe33f8f45b65696e(player, caststart, castend, ignorelist, allowairexit, exitdirection) {
  castfailed = 0;
  debuglinestart = undefined;
  debuglineend = undefined;

  debuglinestart = caststart;
  debuglineend = castend;

  contents = physics_createcontents(["physicscontents_item", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_vehicleclip", "physicscontents_playerclip", "physicscontents_characterproxy"]);
  castresults = physics_charactercast(caststart, castend, player, 0, (0, 0, 0), contents, ignorelist, "physicsquery_closest", "physicsquery_any");

  if(isDefined(castresults) && castresults.size > 0) {
    if(castresults[1]) {
      debuglineend = debuglinestart;

      castfailed = 1;
    } else if(castresults[0].size == 0) {
      if(!istrue(allowairexit)) {
        debuglineend = debuglinestart;

        castfailed = 1;
      } else {
        if(exitdirection != "top" && exitdirection != "roof" && exitdirection != "inside") {
          castend += (0, 0, 40);
        }

        debuglineend = castend;
      }
    } else {
      castend = castresults[0][0]["shape_position"];

      debuglineend = castend;
    }
  }

  if(istrue(level.debugvehicleexit)) {
    drawframes = int(ceil(60 / level.framedurationseconds));
    thread function_dafe9f7ddcab9bf1(debuglinestart, 16, 72, undefined, (0, 1, 1), undefined, drawframes);
    thread function_a03a1d77df140f9c(debuglinestart, debuglineend, 60, (0, 1, 1));

    if(castfailed && isDefined(castresults[0][0]) && isDefined(castresults[0][0]["<dev string:xa4e>"])) {
      level thread function_2127168686332a93(castresults[0][0]["<dev string:xa4e>"], 2, 60, (1, 0, 0));
    }
  }

  if(castfailed) {
    return undefined;
  }

  if(istrue(level.debugvehicleexit)) {
    thread function_2127168686332a93(debuglineend, 2, 60, (0, 1, 0));
  }

  return castend;
}

function function_517f60905f08bf96(vehicle) {
  exitboundinginfo = undefined;

  if(isDefined(vehicle.exitboundinginfo) && vehicle.exitboundinginfo.timestamp == gettime()) {
    exitboundinginfo = vehicle.exitboundinginfo;
  } else {
    leveldataforvehicle = vehicle_occupancy_getleveldataforvehicle(vehicle function_d93ec4635290febd());

    if(isDefined(leveldataforvehicle) && isDefined(leveldataforvehicle.exitextents)) {
      assertex(isDefined(leveldataforvehicle.exitextents["<dev string:xa5a>"]), "<dev string:xa63>");
      assertex(isDefined(leveldataforvehicle.exitextents["<dev string:xaba>"]), "<dev string:xac2>");
      assertex(isDefined(leveldataforvehicle.exitextents["<dev string:xb18>"]), "<dev string:xb20>");
      assertex(isDefined(leveldataforvehicle.exitextents["<dev string:xb76>"]), "<dev string:xb7f>");
      assertex(isDefined(leveldataforvehicle.exitextents["<dev string:xbd6>"]), "<dev string:xbdd>");
      assertex(isDefined(leveldataforvehicle.exitextents["<dev string:xc32>"]), "<dev string:xc3c>");
      exitboundinginfo = spawnStruct();
      vehicle.exitboundinginfo = exitboundinginfo;
      exitboundinginfo = exitboundinginfo;
      exitboundinginfo.vehicle = vehicle;
      exitboundinginfo.timestamp = gettime();
      exitboundinginfo.exitsfailed = [];
      exitboundinginfo.exitpositions = [];
      exitboundinginfo.orientedboxpoints = [];
      exitboundinginfo.unorientedboxpoints = [];

      angles = vehicle.angles;
      topleftfront = rotatevector((leveldataforvehicle.exitextents["<dev string:xa5a>"], leveldataforvehicle.exitextents["<dev string:xb18>"] * -1, leveldataforvehicle.exitextents["<dev string:xbd6>"]), angles);
      toprightfront = rotatevector((leveldataforvehicle.exitextents["<dev string:xa5a>"], leveldataforvehicle.exitextents["<dev string:xb76>"], leveldataforvehicle.exitextents["<dev string:xbd6>"]), angles);
      topleftback = rotatevector((leveldataforvehicle.exitextents["<dev string:xaba>"] * -1, leveldataforvehicle.exitextents["<dev string:xb18>"] * -1, leveldataforvehicle.exitextents["<dev string:xbd6>"]), angles);
      toprightback = rotatevector((leveldataforvehicle.exitextents["<dev string:xaba>"] * -1, leveldataforvehicle.exitextents["<dev string:xb76>"], leveldataforvehicle.exitextents["<dev string:xbd6>"]), angles);
      bottomleftfront = rotatevector((leveldataforvehicle.exitextents["<dev string:xa5a>"], leveldataforvehicle.exitextents["<dev string:xb18>"] * -1, leveldataforvehicle.exitextents["<dev string:xc32>"] * -1), angles);
      bottomrightfront = rotatevector((leveldataforvehicle.exitextents["<dev string:xa5a>"], leveldataforvehicle.exitextents["<dev string:xb76>"], leveldataforvehicle.exitextents["<dev string:xc32>"] * -1), angles);
      bottomleftback = rotatevector((leveldataforvehicle.exitextents["<dev string:xaba>"] * -1, leveldataforvehicle.exitextents["<dev string:xb18>"] * -1, leveldataforvehicle.exitextents["<dev string:xc32>"] * -1), angles);
      bottomrightback = rotatevector((leveldataforvehicle.exitextents["<dev string:xaba>"] * -1, leveldataforvehicle.exitextents["<dev string:xb76>"], leveldataforvehicle.exitextents["<dev string:xc32>"] * -1), angles);
      points = [topleftfront, toprightfront, topleftback, toprightback, bottomleftfront, bottomrightfront, bottomleftback, bottomrightback];
      bestfront = -99999;
      bestback = 99999;
      bestleft = -99999;
      bestright = 99999;
      besttop = -99999;
      bestbot = 99999;
      anglesyawonly = (0, angles[1], 0);

      foreach(point in points) {
        point = rotatevectorinverted(point, anglesyawonly);

        if(point[0] > bestfront) {
          bestfront = point[0];
        }

        if(point[0] < bestback) {
          bestback = point[0];
        }

        if(point[1] < bestright) {
          bestright = point[1];
        }

        if(point[1] > bestleft) {
          bestleft = point[1];
        }

        if(point[2] > besttop) {
          besttop = point[2];
        }

        if(point[2] < bestbot) {
          bestbot = point[2];
        }
      }

      exitboundinginfo.orientedboxpoints["<dev string:xc94>"] = vehicle.origin + topleftfront;
      exitboundinginfo.orientedboxpoints["<dev string:xca4>"] = vehicle.origin + toprightfront;
      exitboundinginfo.orientedboxpoints["<dev string:xcb5>"] = vehicle.origin + topleftback;
      exitboundinginfo.orientedboxpoints["<dev string:xcc4>"] = vehicle.origin + toprightback;
      exitboundinginfo.orientedboxpoints["<dev string:xcd4>"] = vehicle.origin + bottomleftfront;
      exitboundinginfo.orientedboxpoints["<dev string:xce7>"] = vehicle.origin + bottomrightfront;
      exitboundinginfo.orientedboxpoints["<dev string:xcfb>"] = vehicle.origin + bottomleftback;
      exitboundinginfo.orientedboxpoints["<dev string:xd0d>"] = vehicle.origin + bottomrightback;
      exitboundinginfo.unorientedboxpoints["<dev string:xc94>"] = vehicle.origin + rotatevector((bestfront, bestleft, besttop), anglesyawonly);
      exitboundinginfo.unorientedboxpoints["<dev string:xca4>"] = vehicle.origin + rotatevector((bestfront, bestright, besttop), anglesyawonly);
      exitboundinginfo.unorientedboxpoints["<dev string:xcb5>"] = vehicle.origin + rotatevector((bestback, bestleft, besttop), anglesyawonly);
      exitboundinginfo.unorientedboxpoints["<dev string:xcc4>"] = vehicle.origin + rotatevector((bestback, bestright, besttop), anglesyawonly);
      exitboundinginfo.unorientedboxpoints["<dev string:xcd4>"] = vehicle.origin + rotatevector((bestfront, bestleft, bestbot), anglesyawonly);
      exitboundinginfo.unorientedboxpoints["<dev string:xce7>"] = vehicle.origin + rotatevector((bestfront, bestright, bestbot), anglesyawonly);
      exitboundinginfo.unorientedboxpoints["<dev string:xcfb>"] = vehicle.origin + rotatevector((bestback, bestleft, bestbot), anglesyawonly);
      exitboundinginfo.unorientedboxpoints["<dev string:xd0d>"] = vehicle.origin + rotatevector((bestback, bestright, bestbot), anglesyawonly);

      exitboundinginfo thread function_5142e9c0e6eebaa4();

      if(istrue(level.debugvehicleexit)) {
        function_6bdf9766fe9e319(exitboundinginfo);
      }
    }
  }

  return exitboundinginfo;
}

function private function_5142e9c0e6eebaa4() {
  waitframe();

  if(isDefined(self.vehicle)) {
    return;
  }

  if(!isDefined(self.vehicle.exitboundinginfo)) {
    return;
  }

  if(self.vehicle.exitboundinginfo.timestamp != self.timestamp) {
    return;
  }

  self.vehicle.exitboundinginfo = undefined;
}

function private vehicle_occupancy_getexitangles(vehicle, player, exitid, islaststand) {
  leveldataforvehicle = vehicle_occupancy_getleveldataforvehicle(vehicle function_d93ec4635290febd());
  exitboundinginfo = function_517f60905f08bf96(vehicle);
  exitposition = exitboundinginfo.exitpositions[exitid];
  focalpoint = undefined;
  ignorelos = 0;

  if(istrue(islaststand)) {
    focalpoint = vehicle.origin + rotatevector(leveldataforvehicle.exitoffsets[exitid], vehicle.angles);
    ignorelos = 1;
  }

  if(!isDefined(focalpoint)) {
    focalpoint = player getvieworigin() + anglesToForward(player getplayerangles()) * 550;
  }

  viewposition = undefined;

  if(istrue(islaststand)) {
    viewposition = exitposition + (0, 0, 22);
  } else {
    viewposition = exitposition + (0, 0, 60);
  }

  viewdirection = vectorNormalize(focalpoint - viewposition);

  if(!ignorelos) {
    contents = physics_createcontents(["physicscontents_vehicle", "physicscontents_item"]);
    castresults = physics_raycast(viewposition, viewposition + viewdirection * 300, contents, undefined, 0, "physicsquery_closest", 1);

    if(isDefined(castresults) && castresults.size > 0) {
      hitent = castresults[0]["entity"];
      viewblocked = 0;

      if(isDefined(hitent)) {
        hitlist = vehicle getlinkedchildren(1);

        if(!isDefined(hitlist)) {
          hitlist = [];
        }

        hitlist[hitlist.size] = vehicle;

        foreach(ent in hitlist) {
          if(hitent == ent) {
            viewblocked = 1;
            break;
          }
        }
      }

      if(viewblocked) {
        exitdirection = leveldataforvehicle.exitdirections[exitid];
        angles = (0, vehicle.angles[1], 0);

        if(exitdirection == "left" || exitdirection == "right") {
          canceldirection = anglestoright(angles);
        } else {
          canceldirection = anglesToForward(angles);
        }

        viewdirection -= canceldirection * vectordot(viewdirection, canceldirection);
      }
    }
  }

  viewangles = vectortoangles(viewdirection);
  viewangles = (clamp(viewangles[0], -12, 12), viewangles[1], 0);
  return viewangles;
}

function private vehicle_occupancy_findplayerexit(player, vehicle, oldseatid, newseatid, data, specialexit) {
  if(!isDefined(player) || isDefined(newseatid) || istrue(data.playerdeath) && !istrue(data.playerlaststand) && !istrue(data.playerliveragdoll) && !istrue(data.var_e6584ec3ffc0cb7e)) {
    return 1;
  }

  function_d3f0b37c88e04e33();

  leveldataforvehicle = vehicle_occupancy_getleveldataforvehicle(vehicle function_d93ec4635290febd());
  allowairexit = istrue(leveldataforvehicle.allowairexit) || istrue(data.allowairexit) || !vehicle vehicle_isonground();
  exitdata = vehicle_occupancy_getexitpositionandangles(vehicle, player, oldseatid, allowairexit, data.playerlaststand, specialexit);

  if(isDefined(exitdata)) {
    data.exitposition = exitdata[0];
    data.exitangles = exitdata[1];
    data.specialexit = exitdata[2];
    data.exitdirection = exitdata[3];
    data.exitoffset = rotatevectorinverted(data.exitposition - vehicle.origin, vehicle.angles);
    return 1;
  }

  return 0;
}

function function_a24042975031e692() {
  if(isDefined(function_d93ec4635290febd())) {
    leveldataforvehicle = vehicle_occupancy_getleveldataforvehicle(function_d93ec4635290febd());
    return (isDefined(leveldataforvehicle) && isDefined(leveldataforvehicle.exitextents) && isDefined(leveldataforvehicle.exitextents["front"]) && isDefined(leveldataforvehicle.exitextents["back"]) && isDefined(leveldataforvehicle.exitextents["left"]) && isDefined(leveldataforvehicle.exitextents["right"]) && isDefined(leveldataforvehicle.exitextents["top"]) && isDefined(leveldataforvehicle.exitextents["bottom"]));
  }

  return false;
}

function function_9d86fd9a89cd2702(player, vehicle, testpoint, skipmovementdirection) {
  if(!isDefined(player) || !isDefined(vehicle) || !isDefined(testpoint) || !isDefined(vehicle.origin) || !isDefined(vehicle.angles)) {
    return [undefined, undefined];
  }

  vehicleref = vehicle function_d93ec4635290febd();
  data = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(vehicleref);
  skipdirection = undefined;

  if(istrue(skipmovementdirection)) {
    forward = anglesToForward(vehicle.angles);
    moving = vehicle vehicle_getvelocity();
    between = math::anglebetweenvectors(forward, moving);

    if(between < 45) {
      skipdirection = "front";
    } else if(between > 135) {
      skipdirection = "back";
    }
  }

  exits = [];

  foreach(ref, offset in data.exitoffsets) {
    dir = data.exitdirections[ref];

    if(is_equal(skipdirection, dir) || dir == "dive" || dir == "roof") {
      continue;
    }

    exit = spawnStruct();
    exit.ref = ref;
    exit.dir = dir;
    exit.origin = vehicle.origin + rotatevector(offset, vehicle.angles);
    exits[exits.size] = exit;
  }

  exits = sortbydistance(exits, testpoint);
  exitboundinginfo = function_517f60905f08bf96(vehicle);
  isinside = istrue(vehicle callsharedfunc(vehicleref, "isInInterior", player));

  foreach(exit in exits) {
    exitinside = exit.dir == "top" || exit.dir == "inside";

    if(exitinside != isinside) {
      continue;
    }

    position = vehicle_occupancy_getexitposition(vehicle, player, exit.ref, exitboundinginfo, 1);

    if(isDefined(position)) {
      return [position, exit.dir];
    }
  }

  foreach(exit in exits) {
    exitinside = exit.dir == "top" || exit.dir == "inside";

    if(isinside == exitinside) {
      continue;
    }

    position = vehicle_occupancy_getexitposition(vehicle, player, exit.ref, exitboundinginfo, 1);

    if(isDefined(position)) {
      return [position, exit.dir];
    }
  }

  if(getdvarint(@ "hash_9c95c78d2efca328", 1) == 1) {
    position = function_ca069b5427d4ff47(vehicle, player);

    if(isDefined(position)) {
      return [position, undefined, undefined, "front"];
    }
  }

  return [undefined, undefined];
}

function vehicle_occupancy_moveplayertoexit(vehicle, seatid, newseatid, player, data) {
  if(!isDefined(player) || istrue(data.playerdeath) && !istrue(data.playerlaststand) && !istrue(data.playerliveragdoll) && !istrue(data.var_f276d4e53593ec9a) || isDefined(newseatid)) {
    if(isDefined(player) && !isDefined(newseatid)) {
      function_c9b87beb89ec12e2(player, vehicle, !isDefined(newseatid));
      player val::reset_all("vehicle_roof_exit");
      player val::reset_all("vehicle_occupant_common");
    }

    return 1;
  }

  movedexitposition = undefined;

  if(isDefined(data.exitoffset)) {
    movedexitposition = vehicle.origin + rotatevector(data.exitoffset, vehicle.angles);
  }

  if(isDefined(movedexitposition) && function_136fea30dbedce0f(vehicle, player, movedexitposition)) {
    exitposition = movedexitposition;
  } else {
    exitposition = data.exitposition;
  }

  if(isDefined(vehicle.var_927a3bee873e1d8f)) {
    exitposition = vehicle gettagorigin(vehicle.var_927a3bee873e1d8f);
  }

  if(isDefined(exitposition)) {
    if(isDefined(data.specialexit)) {
      if(data.specialexit == "_to_roof") {
        function_aea8bd0571b7a840(player, vehicle, seatid, data);
      } else {
        player function_2e8de69e35a63f1d();
        player leavevehicle(0, 1);
        player val::reset_all("vehicle_roof_exit");
        player val::reset_all("vehicle_occupant_common");
      }
    } else {
      function_c9b87beb89ec12e2(player, vehicle, !isDefined(newseatid));

      if(!isDefined(player.sessionstate) || player.sessionstate != "spectator") {
        player dontinterpolate();

        if(data.exitdirection == "inside" || data.exitdirection == "top") {
          player function_a055801da45d769(exitposition, vehicle);
        } else {
          player setOrigin(exitposition, 1, 1);
        }

        player setstance("stand");

        if(istrue(level.debugvehicleexit)) {
          drawframes = int(ceil(60 / level.framedurationseconds));
          scripts\engine\utility::draw_capsule(exitposition, 16, 72, undefined, (1, 1, 0), undefined, drawframes);
        }

        if(isDefined(data.exitangles)) {
          player setplayerangles(data.exitangles);
        }
      }

      player val::reset_all("vehicle_roof_exit");
      player val::reset_all("vehicle_occupant_common");
    }

    return 1;
  }

  function_c9b87beb89ec12e2(player, vehicle, !isDefined(newseatid));
  player val::reset_all("vehicle_roof_exit");
  player val::reset_all("vehicle_occupant_common");
  return 0;
}

function private function_aea8bd0571b7a840(player, vehicle, seatid, data) {
  vehicleref = vehicle function_d93ec4635290febd();
  var_2e7b44e2b456f504 = vehicle_occupancy_getleveldataforvehicle(vehicleref);

  if(var_2e7b44e2b456f504.roofexittype == "animated") {
    finalposition = player function_e5d1ae0cf82e3e7a() + (0, 0, 18);
  } else {
    offset = var_2e7b44e2b456f504.exitoffsets[seatid + "_to_roof"];
    finalposition = vehicle.origin + rotatevector(offset, vehicle.angles);
  }

  function_c9b87beb89ec12e2(player, vehicle, 1);
  player thread vehicle_preventplayercollisiondamagefortimeafterexit(vehicle, player);
  stance = ter_op(var_2e7b44e2b456f504.roofexittype == "stand_up", "stand", "crouch");

  if(isbot(player)) {
    player botsetstance(stance);
  }

  player setstance(stance, 1, 1, 1);
  player dontinterpolate();
  player function_a055801da45d769(finalposition, vehicle);
  player val::reset_all("vehicle_occupant_common");
  player val::reset_all("vehicle_roof_exit");
}

function function_bd0403ba33ab8b6c(startingposition, angles) {
  self notify("<dev string:xd20>");
  self endon("<dev string:xd20>");

  while(true) {
    iprintlnbold("<dev string:xd3b>" + rotatevector(self.origin - startingposition, angles) - (0, 0, 18));
    waitframe();
  }
}

function private function_c5819749db1604f5(player, vehicle, seatid, data) {
  vehicleref = vehicle function_d93ec4635290febd();
  var_2e7b44e2b456f504 = vehicle_occupancy_getleveldataforvehicle(vehicleref);

  if(!isDefined(var_2e7b44e2b456f504.roofexittype)) {
    assertmsg("<dev string:xd3f>");
    return;
  }

  vehicle thread function_7f925d6914fa15cc(8000);

  if(var_2e7b44e2b456f504.roofexittype == "animated") {
    player endon("death_or_disconnect");
    player endon("last_stand_start");
    player endon("enter_live_ragdoll");
    player endon("vehicle_roof_exit_collision_detected");
    player endon("interrupt_roof_exit");
    vehicle endon("death");
    player val::set_array("vehicle_roof_exit", ["script_weapon_switch", "weapon_switch", "melee", "vehicle_seat_switch", "allow_movement"], 0);
    player function_47a2fc8fdeeda75f();
    endtime = gettime() + ter_op(player isinvehicleleanout(), level.var_abe9bcb8a67ff917, level.var_d9dc5b053fb57856);

    while(!player function_d09168b16803f5be() && gettime() < endtime) {
      waitframe();
    }

    while(player function_d09168b16803f5be() && gettime() < endtime) {
      waitframe();
    }
  }

  return 1;
}

function private function_7f925d6914fa15cc(time) {
  if(isDefined(self.vehicletype)) {
    if(self.vehicletype == "veh9_civ_lnd_dirt_bike_physics_mp" || self.vehicletype == "veh9_civ_lnd_motorcycle_cruiser_2008_physics_mp" || self.vehicletype == "veh9_civ_lnd_scooter_eu_physics_mp") {
      return;
    }
  }

  self notify("maintainSpeedForTime");
  self endon("maintainSpeedForTime");

  if(vectordot(self vehicle_getvelocity(), anglesToForward(self.angles)) < 0 || self vehicle_getspeed() < 5) {
    return;
  }

  self endon("death");
  self.var_6179b2eea75dbfe0 = 1;
  self removecomponent("player");
  self addcomponent("p2p");
  maxspeed = self vehicle_getspeed();
  endtime = gettime() + time;

  while(gettime() < endtime && istrue(self.var_6179b2eea75dbfe0) && self vehicle_getspeed() > 5) {
    self setconfigvalue("p2p", "manualSpeed", scripts\engine\utility::mph_to_ips(min(maxspeed, self vehicle_getspeed())));
    self setconfigvalue("p2p", "goalPoint", self.origin + anglesToForward(self.angles) * 2000);
    waitframe();
  }

  if(!istrue(self.var_6179b2eea75dbfe0)) {
    return;
  }

  function_9a816e66a02ddb40();
}

function private function_9a816e66a02ddb40() {
  self.var_6179b2eea75dbfe0 = undefined;
  self setconfigvalue("p2p", "manualSpeed", 0);
  self removecomponent("p2p");
}

function vehicle_occupancy_getexitcastcontents() {
  return physics_createcontents(["physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle", "physicscontents_playerclip"]);
}

function vehicle_occupancy_getexitcastignorelist(vehicle) {
  leveldataforvehicle = vehicle_occupancy_getleveldataforvehicle(vehicle function_d93ec4635290febd());
  ignorelist = [vehicle];

  if(isDefined(leveldataforvehicle.exitignorelistcallback)) {
    ignorelist = [[leveldataforvehicle.exitignorelistcallback]](vehicle);
  }

  return ignorelist;
}

function vehicle_occupancy_watchmovefeedback(driverseatid) {
  self endon("death");

  while(true) {
    vehicle_occupancy_updatemovefeedback(driverseatid);
    waitframe();
  }
}

function vehicle_occupancy_updatemovefeedback(driverseatid) {
  driver = vehicle_occupancy_getseatoccupant(self, driverseatid);
  occupants = vehicle_occupancy_getalloccupants(self);

  if(isDefined(driver)) {
    driverinput = driver getnormalizedmovement()[0];

    if(abs(driverinput) > 0.15) {
      foreach(occupant in occupants) {
        if(occupant _isalive()) {
          occupant vehicle_occupancy_startmovefeedbackforplayer();
        }
      }
    } else {
      foreach(occupant in occupants) {
        if(occupant _isalive()) {
          occupant vehicle_occupancy_stopmovefeedbackforplayer();
        }
      }
    }

    return;
  }

  if(isDefined(occupants)) {
    foreach(occupant in occupants) {
      if(occupant _isalive()) {
        occupant vehicle_occupancy_stopmovefeedbackforplayer();
      }
    }
  }
}

function vehicle_occupancy_startmovefeedbackforplayer() {
  if(istrue(self.vehiclemoveshakeenabled)) {
    return;
  }

  self.vehiclemoveshakeenabled = 1;
  self setscriptablepartstate("vehicleMoveShake", "active1", 0);
}

function vehicle_occupancy_stopmovefeedbackforplayer() {
  if(!istrue(self.vehiclemoveshakeenabled)) {
    return;
  }

  self.vehiclemoveshakeenabled = undefined;
  self setscriptablepartstate("vehicleMoveShake", "neutral", 0);
}

function vehicle_occupancy_updatedamagefeedback(data) {
  leveldataforvehicle = vehicle_occupancy_getleveldataforvehicle(self.vehiclename);

  if(!isDefined(leveldataforvehicle)) {
    return;
  }

  if(!isDefined(data.damage) || data.damage <= 0) {
    return;
  }

  if(!isDefined(data.meansofdeath)) {
    return;
  }

  damagefeedbacktype = undefined;
  damagefeedbackgroup = undefined;

  switch (data.meansofdeath) {
    case #"hash_571e46e17a3cf2e3":
    case #"hash_5f1054c48d66fd1c":
    case #"hash_66cb246f3e55fbe2":
    case #"hash_966768b3f0c94767":
    case #"hash_a86d8c43482948a4":
    case #"hash_c22b13f81bed11f0":
      damagefeedbacktype = "light";
      damagefeedbackgroup = leveldataforvehicle.damagefeedbackgrouplight;
      break;
    case #"hash_3c20f39c73a1422b":
    case #"hash_a911a1880d996edb":
    case #"hash_b1078ff213fddba6":
      damagefeedbacktype = "heavy";
      damagefeedbackgroup = leveldataforvehicle.damagefeedbackgroupheavy;
      break;
  }

  if(!isDefined(damagefeedbacktype)) {
    return;
  }

  if(!isDefined(damagefeedbackgroup) || damagefeedbackgroup == "none") {
    return;
  }

  players = [];

  if(damagefeedbackgroup == "driver") {
    foreach(seatid, leveldataforseat in leveldataforvehicle.seatdata) {
      if(!isDefined(leveldataforseat.animtag)) {
        continue;
      }

      if(leveldataforseat.animtag == "tag_seat_0") {
        players = [vehicle_occupancy_getseatoccupant(self, seatid)];
        break;
      }
    }
  } else if(damagefeedbackgroup == "all") {
    players = vehicle_occupancy_getalloccupants(self);
  }

  if(!isDefined(players) || players.size == 0) {
    return;
  }

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    if(!player _isalive()) {
      continue;
    }

    if(damagefeedbacktype == "light") {
      player thread vehicle_occupancy_lightdamagefeedbackforplayer();
      continue;
    }

    if(damagefeedbacktype == "heavy") {
      player thread vehicle_occupancy_heavydamagefeedbackforplayer();
    }
  }
}

function vehicle_occupancy_lightdamagefeedbackforplayer() {
  self endon("disconnect");
  self endon("vehicle_occupancy_clearLightDamageFeedbackPlayer");

  if(!isDefined(self.vehiclelightdamagefeedbackid)) {
    self.vehiclelightdamagefeedbackid = 1;
  }

  self setscriptablepartstate("vehicleDamageShakeLight", "active" + self.vehiclelightdamagefeedbackid, 0);
  self.vehiclelightdamagefeedbackid = 1 + mod(self.vehiclelightdamagefeedbackid + 1, 3);
  wait 0.15;
  thread vehicle_occupancy_clearlightdamagefeedbackplayer();
}

function vehicle_occupancy_clearlightdamagefeedbackplayer() {
  self notify("vehicle_occupancy_clearLightDamageFeedbackPlayer");
  self setscriptablepartstate("vehicleDamageShakeLight", "neutral", 0);
  self.vehiclelightdamagefeedbackid = undefined;
}

function vehicle_occupancy_heavydamagefeedbackforplayer() {
  self endon("disconnect");
  self endon("vehicle_occupancy_clearHeavyDamageFeedbackPlayer");

  if(!isDefined(self.vehicleheavydamagefeedbackid)) {
    self.vehicleheavydamagefeedbackid = 1;
  }

  self setscriptablepartstate("vehicleDamageShakeHeavy", "active" + self.vehicleheavydamagefeedbackid, 0);
  self.vehicleheavydamagefeedbackid = 1 + mod(self.vehicleheavydamagefeedbackid + 1, 3);
  wait 0.3;
  thread vehicle_occupancy_clearheavydamagefeedbackplayer();
}

function vehicle_occupancy_clearheavydamagefeedbackplayer() {
  self notify("vehicle_occupancy_clearHeavyDamageFeedbackPlayer");
  self setscriptablepartstate("vehicleDamageShakeHeavy", "neutral", 0);
  self.vehicleheavydamagefeedbackid = undefined;
}

function vehicle_occupancy_cleardamagefeedbackforplayer() {
  vehicle_occupancy_clearlightdamagefeedbackplayer();
  vehicle_occupancy_clearheavydamagefeedbackplayer();
}

function vehicle_occupancy_giveturret(player, vehicle, objweapon, var_26ea07f74a18905d) {
  player endon("disconnect");
  player endon("takeTurret");
  player endon("death");
  wasinvehicle = player isvehicleactive();
  function_c9b87beb89ec12e2(player, vehicle);

  if(wasinvehicle) {
    waitframe();
  }

  player scripts\common\values::set("vehicle_turret", "unresolved_collisions", 0);
  player scripts\common\values::set("vehicle_turret", "killstreaks", 0);

  if(vehicle function_80d84f556cc8017a()) {
    player scripts\common\values::set("vehicle_turret", "fire", 0);
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    player setclientomnvar("ui_br_inventory_disabled", 1);
  }

  turret = vehicle_getturretbyweapon(vehicle, objweapon);
  turret.owner = player;
  turret setotherent(player);
  turret setentityowner(player);
  turret setsentryowner(player);
  player disableturretdismount();

  if(!player hasweapon(objweapon)) {
    player _giveweapon(objweapon);
  }

  if(!player iscurrentweapon(objweapon)) {
    if(istrue(var_26ea07f74a18905d)) {
      player domonitoredweaponswitch(objweapon, 1, 1);
    } else {
      player childthread domonitoredweaponswitch(objweapon, 1, 1);
    }
  }

  player controlturreton(turret);
}

function vehicle_occupancy_taketurret(player, vehicle, objweapon, data, shouldtimeout) {
  if(isDefined(data.raceendon)) {
    data endon(data.raceendon);
  }

  if(istrue(shouldtimeout)) {
    childthread vehicle_occupancy_givetaketurrettimeout(data, 1.5);
  }

  player scripts\common\values::reset_all("vehicle_turret");

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    player setclientomnvar("ui_br_inventory_disabled", 0);
  }

  player notify("takeTurret");

  if(player hasweapon(objweapon)) {
    result = undefined;
    thread vehicle_occupancy_clearforceweaponswitchallowed(player);

    if(player isswitchingtoweaponwithmonitoring(objweapon)) {
      assert(player getcurrentweapon().basename != objweapon);
      player abortmonitoredweaponswitch(makeweapon(objweapon));
      result = 1;
    } else {
      turret = vehicle_getturretbyweapon(vehicle, objweapon);

      if(isDefined(turret)) {
        player controlturretoff(turret);
      }

      if(player hasweapon(objweapon)) {
        holdingweapon = player iscurrentweapon(objweapon);

        if(holdingweapon) {
          player _takeweapon(objweapon);
          player thread forcevalidweapon();
        } else {
          player thread getridofweapon(objweapon, 1);
        }
      }

      result = 1;
    }

    if(isDefined(result) && !result) {
      data.success = 0;
      data notify(data.raceendnotify);
    }
  }
}

function vehicle_occupancy_givetaketurrettimeout(data, timeout) {
  wait timeout;
  data.success = 0;
  data notify(data.raceendnotify);
}

function vehicle_occupancy_clearforceweaponswitchallowed(player) {
  player notify("vehicle_occupancy_forceWeaponSwitchAllowed");

  if(player val::get("weapon_switch")) {
    player enableweaponswitch();
    return;
  }

  player disableweaponswitch();
}

function vehicle_occupancy_ejectalloccupants(vehicle) {
  if(vehicle scripts\cp_mp\vehicles\vehicle::isvehiclehusk()) {
    return;
  }

  seatids = vehicle_occupancy_getallvehicleseats(vehicle);

  foreach(seatid in seatids) {
    occupant = vehicle_occupancy_getseatoccupant(vehicle, seatid);

    if(isDefined(occupant)) {
      data = spawnStruct();
      data.allowairexit = 1;
      data.exittype = "INVOLUNTARY";
      thread vehicle_occupancy_exit(vehicle, seatid, occupant, data, 1);
    }
  }
}

function function_7d1a850ac1a81925(vehicle, weapon, spawndata, attachtag, model) {
  turret = spawnturret("misc_turret", vehicle gettagorigin(attachtag), weapon, 0);
  turret linkTo(vehicle, attachtag, (0, 0, 0), (0, 0, 0));

  if(isDefined(spawndata.skinoverride)) {
    model = spawndata.skinoverride + "::" + model;
  }

  turret setModel(model);
  turret setmode("sentry_offline");
  turret setsentryowner(undefined);
  turret makeunusable();
  turret setdefaultdroppitch(0);
  turret setturretmodechangewait(1);
  turret.angles = vehicle.angles;
  turret.vehicle = vehicle;
  return turret;
}

function function_d764f933c0054e16(vehicle, weaponname, normalraisetime, firstraisetime) {
  raisetime = 0;

  if(istrue(vehicle.playedfirstraise)) {
    raisetime = ter_op(isDefined(normalraisetime), normalraisetime, 850);
  } else {
    raisetime = ter_op(isDefined(firstraisetime), firstraisetime, 2200);
  }

  raisetime = max(raisetime, 1);
  level thread vehicle_occupancy_disablefirefortime(self, raisetime);
  thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(self, vehicle, weaponname);
  vehicle.playedfirstraise = 1;
}

function function_99ec1e87f279f082(data, vehicle, weaponname) {
  turret = vehicle_getturretbyweapon(vehicle, weaponname);

  if(!istrue(data.playerdisconnect)) {
    self enableturretdismount();
    self controlturretoff(turret);
    thread vehicle_occupancy_cleardisablefirefortime(self, data.playerdeath);

    if(!istrue(data.playerdeath)) {
      thread vehicle_occupancy_taketurret(self, vehicle, weaponname, data, 1);
    }
  }

  turret.owner = undefined;
  turret setotherent(undefined);
  turret setentityowner(undefined);
  turret setsentryowner(undefined);
}

function vehicle_occupancy_getoccupantrestrictions() {
  allows = ["crouch", "prone", "sprint", "mantle", "mount_top", "mount_side", "vehicle_use", "crate_use", "ladder_placement", "execution_attack", "execution_victim", "usability"];

  if(getdvarint(@ "hash_6c68604cd07d358", 0) == 1) {
    allows[allows.size] = "offhand_weapons";
  }

  return allows;
}

function vehicle_occupancy_getdriverrestrictions() {
  return ["usability", "offhand_weapons", "melee", "fire", "reload", "autoreload", "weapon_switch", "cough_gesture", "armor", "killstreaks"];
}

function function_b9cc4ad5c15d3cee() {
  return ["usability", "offhand_weapons", "melee", "reload", "autoreload", "weapon_switch", "cough_gesture", "armor", "killstreaks"];
}

function vehicle_occupancy_getcombatpassengerrestrictions() {
  return ["weapon_pickup"];
}

function vehicle_occupancy_getcombatcabpassengerrestrictions() {
  restrictions = vehicle_occupancy_getcombatpassengerrestrictions();
  return restrictions;
}

function vehicle_occupancy_getpassivepassengerrestrictions() {
  return vehicle_occupancy_getdriverrestrictions();
}

function vehicle_occupancy_getturretpassengerrestrictions() {
  restrictions = vehicle_occupancy_getcombatpassengerrestrictions();
  restrictions[restrictions.size] = "cough_gesture";
  restrictions[restrictions.size] = "offhand_weapons";
  restrictions[restrictions.size] = "armor";
  restrictions[restrictions.size] = "killstreaks";
  return array_remove_duplicates(restrictions);
}

function vehicle_occupancy_disablefirefortime(player, timems, var_7dfb5b86164129f9) {
  player endon("disconnect");
  player notify("vehicle_occupancy_disableFireForTime");
  player endon("vehicle_occupancy_disableFireForTime");

  if(!istrue(self.vehicledisablefire)) {
    player.vehicledisablefire = 1;
    player val::set("vehicleDisableFire", "fire", 0);
  }

  if(!isDefined(player.vehicledisablefireendtime) || !istrue(var_7dfb5b86164129f9)) {
    player.vehicledisablefireendtime = gettime() + timems;
  }

  while(isDefined(player.vehicledisablefireendtime) && gettime() < player.vehicledisablefireendtime) {
    wait 0.05;
  }

  thread vehicle_occupancy_cleardisablefirefortime(player);
}

function vehicle_occupancy_cleardisablefirefortime(player, fromdeath) {
  player notify("vehicle_occupancy_disableFireForTime");

  if(isDefined(player.vehicledisablefire)) {
    if(!istrue(fromdeath)) {
      player val::reset_all("vehicleDisableFire");
    }
  }

  player.vehicledisablefire = undefined;
  player.vehicledisablefireendtime = undefined;
}

function vehicle_occupancy_takeriotshield(player, vehicle, newseatid) {
  if(issharedfuncdefined("vehicle_occupancy", "takeRiotShield")) {
    [[getsharedfunc("vehicle_occupancy", "takeRiotShield")]](player, vehicle, newseatid);
  }
}

function vehicle_occupancy_giveriotshield(player, fromdeath, fromlaststand) {
  if(issharedfuncdefined("vehicle_occupancy", "giveRiotShield")) {
    [[getsharedfunc("vehicle_occupancy", "giveRiotShield")]](player, fromdeath, fromlaststand);
  }
}

function vehicle_occupancy_updateriotshield(player, vehicle, newseatid) {
  if(issharedfuncdefined("vehicle_occupancy", "updateRiotShield")) {
    [[getsharedfunc("vehicle_occupancy", "updateRiotShield")]](player, vehicle, newseatid);
  }
}

function vehicle_occupancy_hidecashbag(vehicle, seatid, player, data) {
  if(issharedfuncdefined("vehicle_occupancy", "hideCashBag")) {
    [[getsharedfunc("vehicle_occupancy", "hideCashBag")]](vehicle, seatid, player, data);
  }
}

function vehicle_occupancy_showcashbag(vehicle, seatid, player, data) {
  if(issharedfuncdefined("vehicle_occupancy", "showCashBag")) {
    [[getsharedfunc("vehicle_occupancy", "showCashBag")]](vehicle, seatid, player, data);
  }
}

function vehicle_occupancy_registersentient(vehicle) {
  if(isDefined(vehicle.sentientdisabled) && vehicle.sentientdisabled > 0) {
    return;
  }

  if(issharedfuncdefined("vehicle_occupancy", "registerSentient")) {
    [[getsharedfunc("vehicle_occupancy", "registerSentient")]](vehicle);
  }
}

function vehicle_occupancy_unregistersentient(vehicle) {
  if(issharedfuncdefined("vehicle_occupancy", "unregisterSentient")) {
    [[getsharedfunc("vehicle_occupancy", "unregisterSentient")]](vehicle);
  }
}

function vehicle_occupancy_issentient(vehicle) {
  if(issharedfuncdefined("vehicle_occupancy", "isSentient")) {
    return [[getsharedfunc("vehicle_occupancy", "isSentient")]](vehicle);
  }
}

function vehicle_occupancy_allowsentient(bool) {
  if(bool) {
    assert(isDefined(self.sentientdisabled) && self.sentientdisabled > 0, "<dev string:xd7e>");
    self.sentientdisabled--;

    if(self.sentientdisabled == 0) {
      vehicle_occupancy_registersentient(self);
    }

    return;
  }

  if(!isDefined(self.sentientdisabled)) {
    self.sentientdisabled = 0;
  }

  self.sentientdisabled++;

  if(self.sentientdisabled == 1) {
    vehicle_occupancy_unregistersentient(self);
  }
}

function vehicle_occupancy_linktooriginandangles(vehicle, var_6126d8436c986baf) {
  linktooriginandangles = spawnStruct();

  if(vehicle tagexists(var_6126d8436c986baf)) {
    linktooriginandangles.origin = vehicle gettagorigin(var_6126d8436c986baf);
    linktooriginandangles.angles = vehicle gettagangles(var_6126d8436c986baf);
  } else {
    leveldataforseat = vehicle_occupancy_getleveldataforseat(vehicle.vehiclename, var_6126d8436c986baf);

    if(isDefined(leveldataforseat.animtag)) {
      linktooriginandangles.origin = vehicle gettagorigin(leveldataforseat.animtag);
      linktooriginandangles.angles = vehicle gettagangles(leveldataforseat.animtag);
    } else {
      linktooriginandangles.origin = vehicle.origin;
      linktooriginandangles.angles = vehicle.angles;
    }
  }

  return linktooriginandangles;
}

function vehicle_occupancy_linkseatcorpse(corpse, vehicle, var_6126d8436c986baf) {
  if(vehicle tagexists(var_6126d8436c986baf)) {
    corpse enablelinkTo();
    corpse linkTo(vehicle, var_6126d8436c986baf);
    return;
  }

  leveldataforseat = vehicle_occupancy_getleveldataforseat(vehicle.vehiclename, var_6126d8436c986baf);

  if(isDefined(leveldataforseat.animtag)) {
    corpse enablelinkTo();
    corpse linkTo(vehicle, leveldataforseat.animtag);
    return;
  }

  corpse enablelinkTo();
  corpse linkTo(vehicle);
}

function vehicle_occupancy_assignseatcorpse(corpse, vehicle, var_6126d8436c986baf, deleteonseatenter) {
  assertex(!istrue(vehicle.isdestroyed), "<dev string:xde6>");

  if(!isDefined(vehicle.corpses)) {
    vehicle.corpses = [];
  }

  vehicle_occupancy_deleteseatcorpse(vehicle, var_6126d8436c986baf, 0);
  vehicle.corpses[var_6126d8436c986baf] = corpse;

  if(!deleteonseatenter) {
    corpse.dontdeleteonseatenter = 1;
  }
}

function vehicle_occupancy_clearseatcorpse(corpse, vehicle, var_6126d8436c986baf) {
  if(isDefined(vehicle.corpses) && isDefined(vehicle.corpses[var_6126d8436c986baf])) {
    vehicle.corpses[var_6126d8436c986baf] = undefined;
  }

  corpse.dontdeleteonseatenter = undefined;
}

function vehicle_occupancy_deleteseatcorpse(vehicle, var_6126d8436c986baf, var_a710fd9108240c6a) {
  if(isDefined(vehicle.corpses) && isDefined(vehicle.corpses[var_6126d8436c986baf])) {
    corpse = vehicle.corpses[var_6126d8436c986baf];

    if(isDefined(corpse)) {
      if(!istrue(corpse.dontdeleteonseatenter) || !var_a710fd9108240c6a) {
        vehicle.corpses[var_6126d8436c986baf] delete();
        vehicle.corpses[var_6126d8436c986baf] = undefined;
      }
    }
  }
}

function vehicle_occupancy_deleteseatcorpses(vehicle) {
  if(isDefined(vehicle.corpses)) {
    foreach(corpse in vehicle.corpses) {
      if(isDefined(corpse)) {
        corpse delete();
      }
    }
  }

  vehicle.corpses = undefined;
}

function vehicle_occupancy_allowspawninto(vehicle, bool) {
  if(istrue(vehicle.isdestroyed) || !isDefined(vehicle.occupants)) {
    vehicle.preventspawninto = undefined;
    return;
  }

  if(bool) {
    assert(isDefined(vehicle.preventspawninto) && vehicle.preventspawninto > 0, "<dev string:xe34>");
    vehicle.preventspawninto--;
    return;
  }

  if(!isDefined(vehicle.preventspawninto)) {
    vehicle.preventspawninto = 0;
  }

  vehicle.preventspawninto++;
}

function vehicle_occupancy_canspawninto(vehicle) {
  if(istrue(vehicle.isdestroyed) || !isDefined(vehicle.occupants)) {
    return false;
  }

  if(isDefined(vehicle.preventspawninto) && vehicle.preventspawninto > 0) {
    return false;
  }

  return true;
}

function vehicle_occupancy_generateseatswitcharray(seatid, seatidarr) {
  assertex(array_contains(seatidarr, seatid), "<dev string:xe9e>");
  seatswitcharr = [];
  foundseatid = 0;

  for(i = 0; true; i++) {
    if(!foundseatid) {
      if(seatid == seatidarr[i]) {
        foundseatid = 1;
      }

      continue;
    }

    i = mod(i, seatidarr.size);

    if(seatid == seatidarr[i]) {
      break;
    }

    seatswitcharr[seatswitcharr.size] = seatidarr[i];
  }

  return seatswitcharr;
}

function vehicle_occupancy_killoccupants(vehicle, damagedata, exitdata) {
  seatids = vehicle_occupancy_getallvehicleseats(self);

  if(!isDefined(seatids)) {
    return;
  }

  if(!isDefined(damagedata.inflictor)) {
    switch (damagedata.meansofdeath) {
      case #"hash_3c20f39c73a1422b":
      case #"hash_571e46e17a3cf2e3":
      case #"hash_66cb246f3e55fbe2":
      case #"hash_c22b13f81bed11f0":
        if(isDefined(vehicle.killcament)) {
          vehicle.killcament delete();
        }

        vehicle.killcament = damagedata.inflictor;
        damagedata.inflictor = vehicle;
        break;
    }
  }

  if(!isDefined(damagedata.inflictor)) {
    damagedata.inflictor = undefined;
  }

  meansofdeath = damagedata.meansofdeath;

  if(meansofdeath == "MOD_PROJECTILE") {
    meansofdeath = "MOD_PROJECTILE_SPLASH";
  } else if(meansofdeath == "MOD_GRENADE") {
    meansofdeath = "MOD_GRENADE_SPLASH";
  }

  foreach(seatid in seatids) {
    occupant = vehicle_occupancy_getseatoccupant(self, seatid);

    if(isDefined(occupant)) {
      curattacker = damagedata.attacker;

      if(utility::iscp()) {
        occupant.shouldskipdeathsshield = 1;

        if(!isDefined(curattacker)) {
          if(isDefined(damagedata.inflictor)) {
            curattacker = damagedata.inflictor;
          }
        }

        if(!isDefined(curattacker)) {
          curattacker = occupant;
        }

        if(isDefined(curattacker) && isDefined(curattacker.team)) {
          if(curattacker.team == occupant.team) {
            vehicle_occupancy_exit(self, seatid, occupant, undefined, 1);
            occupant.skipvehiclespashdamage = 1;
            continue;
          }
        }
      } else if(!isDefined(curattacker) || !playersareenemies(curattacker, occupant)) {
        curattacker = occupant;
      }

      occupant.donotmodifydamage = 1;
      var_ab7b2b4764cff0f5 = 0;

      if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && istrue(occupant.isjuggernaut)) {
        if(isDefined(occupant.juggcontext.juggconfig.vehiclecankillhealth) && occupant.health > occupant.juggcontext.juggconfig.vehiclecankillhealth) {
          var_ab7b2b4764cff0f5 = 1;
        }
      }

      if(!istrue(var_ab7b2b4764cff0f5) && occupant _isalive()) {
        occupant thread function_2700ef822671144a(vehicle, curattacker, damagedata, meansofdeath);

        if(isDefined(level.vehicleoccupantdeathcustomcallback)) {
          occupant thread[[level.vehicleoccupantdeathcustomcallback]]();
        }
      }

      occupant.donotmodifydamage = undefined;
      thread vehicle_occupancy_exit(vehicle, seatid, occupant, exitdata, 1);
    }
  }

  vehicle_occupancy_deleteseatcorpses(vehicle);
}

function private function_e462819da430ac92(vehicle) {
  if(!vehicle getscriptablehaspart("stability")) {
    return;
  }

  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(vehicle);
  var_1d3b3a7f125be55e = scripts\engine\utility::mph_to_ips(abs(vehicle vehicle_getspeed()));

  if(occupants.size > 0) {
    vehicle utility::function_3677f2be30fdd581("stability", "stable");
    return;
  }

  if(occupants.size == 0 && var_1d3b3a7f125be55e > vehicle.var_c335ed10c38975e) {
    vehicle utility::function_3677f2be30fdd581("stability", "unstable");
  }
}

function private function_2700ef822671144a(vehicle, curattacker, damagedata, meansofdeath) {
  self endon("death_or_disconnect");
  origin = vehicle.origin;

  while(self isvehicleactive()) {
    waitframe();
  }

  attacker = damagedata.attacker;
  inflictor = damagedata.inflictor;

  if(!isDefined(attacker)) {
    attacker = ter_op(isDefined(self.burndownattacker) && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self, self.burndownattacker)), self.burndownattacker, self);
  }

  if(!isDefined(attacker)) {
    if(isDefined(vehicle)) {
      attacker = vehicle;
    } else {
      attacker = self;
    }
  }

  if(!isDefined(inflictor)) {
    inflictor = self;
  }

  self dodamage(self.maxhealth, origin, attacker, inflictor, meansofdeath, damagedata.objweapon, "torso_upper");
}

function function_34d70aa8129b0d74() {
  self endon("death");
  ref = function_d93ec4635290febd();
  onstartriding = getsharedfunc(ref, "onStartRiding");
  onendriding = getsharedfunc(ref, "onEndRiding");
  isininterior = getsharedfunc(ref, "isInInterior");
  onenterinterior = getsharedfunc(ref, "onEnterInterior");
  onexitinterior = getsharedfunc(ref, "onExitInterior");
  hasinterior = isDefined(isininterior);
  self.ridingplayers = [];
  prevonground = self vehicle_isonground();

  while(true) {
    onground = self vehicle_isonground();
    validridingplayers = [];

    foreach(player in utility::playersnear(self.origin, 550)) {
      if(isDefined(player) && player _isalive() && isDefined(player.guid) && !player isvehicleactive() && function_f5174ac9916fe7a6(player, self) && (!function_997f45f1e19b9dc9(player.origin) || player ishanging() || player ismantling())) {
        validridingplayers[player.guid] = 1;

        if(!isDefined(self.ridingplayers[player.guid])) {
          self.ridingplayers[player.guid] = player;

          if(self.vehiclename == "veh9_palfa") {
            player.isridingvehicle = 1;
          }

          [[onstartriding]](player);

          if(!onground) {
            player vehicle_occupancy_startmovefeedbackforplayer();
          }
        }

        if(hasinterior) {
          ininterior = [[isininterior]](player);

          if(!istrue(player.var_1ecb70862bb22bb) && ininterior) {
            [[onenterinterior]](player);
          } else if(istrue(player.var_1ecb70862bb22bb) && !ininterior) {
            [[onexitinterior]](player);
          }

          player.var_1ecb70862bb22bb = ininterior;
        }
      }
    }

    foreach(guid, player in self.ridingplayers) {
      if(!istrue(validridingplayers[guid])) {
        self.ridingplayers[guid] = undefined;

        if(isDefined(player.isridingvehicle)) {
          player.isridingvehicle = undefined;
        }

        [[onendriding]](player);

        if(isDefined(player)) {
          player vehicle_occupancy_stopmovefeedbackforplayer();
        }

        if(hasinterior) {
          if(istrue(player.var_1ecb70862bb22bb)) {
            [[onexitinterior]](player);
          }

          if(isDefined(player)) {
            player.var_1ecb70862bb22bb = undefined;
          }
        }
      }
    }

    if(onground != prevonground) {
      if(!onground) {
        foreach(player in self.ridingplayers) {
          player vehicle_occupancy_startmovefeedbackforplayer();
        }
      } else {
        foreach(player in self.ridingplayers) {
          player vehicle_occupancy_stopmovefeedbackforplayer();
        }
      }
    }

    prevonground = onground;
    wait 0.25;
  }
}

function function_f5174ac9916fe7a6(player, vehicleplatform) {
  if(isDefined(vehicleplatform) && vehicleplatform scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    playerplatform = function_2e8745a2d6ec9fd1(player);

    if(isDefined(playerplatform) && playerplatform == vehicleplatform) {
      return true;
    }
  }

  playerplatformparent = player getmovingplatformparent();

  if(isDefined(vehicleplatform) && isDefined(vehicleplatform.e_navmesh) && isDefined(playerplatformparent) && playerplatformparent == vehicleplatform.e_navmesh) {
    return true;
  }

  return false;
}

function function_2e8745a2d6ec9fd1(player) {
  if(!isDefined(player)) {
    return undefined;
  }

  vehicleplatform = player getmovingplatformparent();

  if(isDefined(vehicleplatform) && istrue(vehicleplatform.var_102945aa439b7b3d)) {
    vehicleplatform = undefined;
  }

  if(!isDefined(vehicleplatform)) {
    vehicleplatform = player getgroundentity();

    if(isDefined(vehicleplatform) && !istrue(vehicleplatform.var_102945aa439b7b3d)) {
      vehicleplatform = undefined;
    }
  }

  var_5c7e5fe501d37e4a = function_b381868642836183(player);

  if(isDefined(var_5c7e5fe501d37e4a)) {
    vehicleplatform = var_5c7e5fe501d37e4a;
  }

  if(isDefined(vehicleplatform) && !vehicleplatform scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    return undefined;
  }

  return vehicleplatform;
}

function function_3dfe65e73a7d0c86(player, vehicle) {
  if(!isDefined(player)) {
    return;
  }

  if(isDefined(vehicle) && vehicle scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    player.var_8d553bc2f713d356 = vehicle;
    player thread function_7f56221b97c7a6c0();
  }
}

function private function_7f56221b97c7a6c0() {
  self endon("disconnect");
  self endon("disabled_force_ride");
  level endon("game_ended");
  self waittill("death");
  self.var_8d553bc2f713d356 = undefined;
}

function function_69f266af27c2689(player, vehicle) {
  if(!isDefined(player)) {
    return;
  }

  if(isDefined(vehicle) && vehicle scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    if(isreallyalive(player)) {
      player dontinterpolate();
      player function_a055801da45d769(player.origin, vehicle);
      player notify("disabled_force_ride");
      player thread vehicle_preventplayercollisiondamagefortimeafterexit(vehicle, player);
    }
  }

  player.var_8d553bc2f713d356 = undefined;
}

function function_b381868642836183(player) {
  if(!isDefined(player)) {
    return undefined;
  }

  return player.var_8d553bc2f713d356;
}

function function_d419e441d20e67ac() {
  return isDefined(self.enginedisabled);
}

function function_7c81e0d41cbbce7f() {
  if(!isDefined(self.enginedisabled)) {
    assertmsg(isDefined(self.enginedisabled), "<dev string:xec0>");
    return;
  }

  self.enginedisabled -= 1;

  if(self.enginedisabled <= 0) {
    self.enginedisabled = undefined;
  }
}

function function_d0092c44c5588870() {
  if(!isDefined(self.enginedisabled)) {
    self.enginedisabled = 0;
  }

  self.enginedisabled += 1;
  function_887b4e2cbe3ab92c();
}

function function_9e710c9f3a15ffda() {
  if(!function_d419e441d20e67ac()) {
    self vehicle_turnengineon();
    function_c01316c733e017b7();
  }
}

function function_887b4e2cbe3ab92c() {
  self vehicle_turnengineoff();
  function_49eff91715ae3c1b();
}

function function_4e4cf75e0f7e4184(point) {
  if(!function_a24042975031e692()) {
    return false;
  }

  localorigin = coordtransformtranspose(point, self.origin, self.angles);
  leveldataforvehicle = vehicle_occupancy_getleveldataforvehicle(function_d93ec4635290febd());
  return localorigin[0] > leveldataforvehicle.exitextents["back"] * -1 && localorigin[0] < leveldataforvehicle.exitextents["front"] && localorigin[1] > leveldataforvehicle.exitextents["left"] * -1 && localorigin[1] < leveldataforvehicle.exitextents["right"] && localorigin[2] > leveldataforvehicle.exitextents["bottom"] * -1 && localorigin[2] < leveldataforvehicle.exitextents["top"];
}

function function_997f45f1e19b9dc9(point) {
  if(!function_a24042975031e692()) {
    return false;
  }

  localorigin = coordtransformtranspose(point, self.origin, self.angles);
  leveldataforvehicle = vehicle_occupancy_getleveldataforvehicle(function_d93ec4635290febd());
  return localorigin[2] < leveldataforvehicle.exitextents["bottom"] * -1;
}

function vehicle_occupancy_initdebug() {
  leveldata = vehicle_occupancy_getleveldata();
  leveldata.debuginstances = [];

  thread function_866e78f157c1f5f3();
}

function function_866e78f157c1f5f3() {
  leveldata = vehicle_occupancy_getleveldata();
  wait 5;
  setdevdvarifuninitialized(@ "hash_2de891db9eeac685", 0);
  setdevdvarifuninitialized(@ "hash_6c296dda80496851", 0);
  setdevdvarifuninitialized(@ "hash_fdf60fe90077b559", 0);
  setdevdvarifuninitialized(@ "hash_a864c803709b59ce", 0);

  while(true) {
    if(getdvarint(@ "hash_5dd683c4da86681e", 0) > 0) {
      level.debugvehicleexit = 1;
    } else {
      level.debugvehicleexit = undefined;
    }

    foreach(vehicle in leveldata.debuginstances) {
      if(!isDefined(vehicle)) {
        continue;
      }

      if(istrue(level.debugvehicleexit)) {
        exitboundinginfo = function_517f60905f08bf96(vehicle);
      }
    }

    host = undefined;

    if(issharedfuncdefined("<dev string:x867>", "<dev string:x883>")) {
      host = [[getsharedfunc("<dev string:x867>", "<dev string:x883>")]]();
    }

    if(isDefined(host)) {
      function_511060fa3b5d7a06(host);
    }

    if(getdvarint(@ "hash_fdf60fe90077b559", 0) == 1) {
      setDvar(@ "hash_fdf60fe90077b559", 0);

      if(isDefined(level.botvehicle) && (isDefined(level.friendlyvehiclebot) || isDefined(level.enemyvehiclebot))) {
        bot = ter_op(isDefined(level.friendlyvehiclebot), level.friendlyvehiclebot, level.enemyvehiclebot);
        bot botpressbutton("<dev string:xf16>");
      }
    }

    if(getdvarint(@ "hash_a864c803709b59ce", 0) == 1) {
      setDvar(@ "hash_a864c803709b59ce", 0);

      if(isDefined(level.botvehicle) && (isDefined(level.friendlyvehiclebot) || isDefined(level.enemyvehiclebot))) {
        bot = ter_op(isDefined(level.friendlyvehiclebot), level.friendlyvehiclebot, level.enemyvehiclebot);
        bot botpressbutton("<dev string:xf1e>");
      }
    }

    if(getdvarint(@ "hash_6c296dda80496851", 0) == 1) {
      setDvar(@ "hash_6c296dda80496851", 0);

      if(isDefined(level.botvehicle) && (isDefined(level.friendlyvehiclebot) || isDefined(level.enemyvehiclebot))) {
        bot = ter_op(isDefined(level.friendlyvehiclebot), level.friendlyvehiclebot, level.enemyvehiclebot);
        seatid = vehicle_occupancy_getoccupantseat(level.botvehicle, bot);

        if(isDefined(seatid)) {
          switchseatid = vehicle_occupancy_getnextavailableseat(level.botvehicle, bot, seatid);

          if(isDefined(switchseatid)) {
            vehicle_occupancy_enter(level.botvehicle, switchseatid, bot);
          }
        }
      }
    }

    waitframe();
  }
}

function function_6bdf9766fe9e319(boundinginfo) {
  thread scripts\cp_mp\utility\debug_utility::drawboxfrompoints(boundinginfo.orientedboxpoints["<dev string:xc94>"], boundinginfo.orientedboxpoints["<dev string:xca4>"], boundinginfo.orientedboxpoints["<dev string:xcb5>"], boundinginfo.orientedboxpoints["<dev string:xcc4>"], boundinginfo.orientedboxpoints["<dev string:xcd4>"], boundinginfo.orientedboxpoints["<dev string:xce7>"], boundinginfo.orientedboxpoints["<dev string:xcfb>"], boundinginfo.orientedboxpoints["<dev string:xd0d>"], 0.05, (1, 1, 1));
  thread scripts\cp_mp\utility\debug_utility::drawboxfrompoints(boundinginfo.unorientedboxpoints["<dev string:xc94>"], boundinginfo.unorientedboxpoints["<dev string:xca4>"], boundinginfo.unorientedboxpoints["<dev string:xcb5>"], boundinginfo.unorientedboxpoints["<dev string:xcc4>"], boundinginfo.unorientedboxpoints["<dev string:xcd4>"], boundinginfo.unorientedboxpoints["<dev string:xce7>"], boundinginfo.unorientedboxpoints["<dev string:xcfb>"], boundinginfo.unorientedboxpoints["<dev string:xd0d>"], 0.05, (1, 1, 0));
}

function function_d3f0b37c88e04e33() {
  level notify("<dev string:xf27>");
}

function function_a03a1d77df140f9c(start, end, drawtimeseconds, color) {
  level endon("<dev string:xf27>");
  level childthread scripts\cp_mp\utility\debug_utility::drawline(start, end, drawtimeseconds, color);
}

function function_2127168686332a93(origin, radius, drawtimeseconds, color) {
  level endon("<dev string:xf27>");
  level childthread scripts\cp_mp\utility\debug_utility::drawsphere(origin, radius, drawtimeseconds, color);
}

function function_dafe9f7ddcab9bf1(pos, radius, height, angles, color, depthtest, duration) {
  level endon("<dev string:xf27>");
  drawframes = int(ceil(0.05 / level.framedurationseconds));
  endtime = gettime() + duration * 1000;

  while(gettime() < endtime) {
    level childthread scripts\engine\utility::draw_capsule(pos, radius, height, angles, color, depthtest, drawframes);
    wait 0.05;
  }
}

function function_6bb041ee1ab70e18(origin, otherorigin, radius, drawtimeseconds, color) {
  level endon("<dev string:xf27>");
  level childthread scripts\cp_mp\utility\debug_utility::drawsphere(origin, radius, drawtimeseconds, color);
  level childthread scripts\cp_mp\utility\debug_utility::drawsphere(otherorigin, radius, drawtimeseconds, color);

  foreach(offset in [(radius, 0, 0), (-1 * radius, 0, 0), (0, radius, 0), (0, -1 * radius, 0), (0, 0, radius), (0, 0, -1 * radius)]) {
    level childthread scripts\cp_mp\utility\debug_utility::drawline(origin + offset, otherorigin + offset, drawtimeseconds, color);
  }
}

function function_511060fa3b5d7a06(host) {
  switchseat = 0;
  addid = getdvarint(@ "hash_2de891db9eeac685", 0);
  bot = undefined;

  if(!isDefined(level.botvehicle) || istrue(level.botvehicle.isdestroyed)) {
    level.botvehicle = undefined;
  }

  if(addid == 0) {
    return;
  }

  if(isDefined(level.botvehicle)) {
    switch (addid) {
      case 1:
        setdevdvar(@ "hash_2de891db9eeac685", 0);
        bot = level.friendlyvehiclebot;

        if(isDefined(bot) && !playersareenemies(bot, host)) {
          if(isDefined(level.botvehicle)) {
            botvehicle = bot getvehicle();

            if(isDefined(botvehicle)) {
              if(botvehicle == level.botvehicle) {
                switchseat = 1;
                break;
              } else {
                bot = undefined;
              }
            }
          }
        }

        if(!isDefined(bot)) {
          players = getfriendlyplayers(host.team, 1);

          foreach(player in players) {
            if(!isbot(player)) {
              continue;
            }

            bot = player;
            break;
          }
        }

        level.friendlyvehiclebot = bot;
        break;
      case 2:
        setdevdvar(@ "hash_2de891db9eeac685", 0);
        bot = level.enemyvehiclebot;

        if(isDefined(bot) && playersareenemies(bot, host)) {
          if(isDefined(level.botvehicle)) {
            botvehicle = bot getvehicle();

            if(isDefined(botvehicle)) {
              if(botvehicle == level.botvehicle) {
                switchseat = 1;
                break;
              } else {
                bot = undefined;
              }
            }
          }
        }

        if(!isDefined(bot)) {
          players = getenemyplayers(host.team, 1);

          foreach(player in players) {
            if(!isbot(player)) {
              continue;
            }

            bot = player;
            break;
          }
        }

        level.enemyvehiclebot = bot;
        break;
      default:
        return;
    }

    if(isDefined(bot)) {
      if(switchseat) {
        function_80491ae71b928cfa(bot);
      } else {
        function_5993e49922687515(host, bot);
      }
    } else if(addid != 0) {
      iprintln("<dev string:xf35>");
    }
  } else if(addid != 0) {
    iprintln("<dev string:xf52>");
  }

  setdevdvar(@ "hash_2de891db9eeac685", 0);
}

function function_5993e49922687515(host, bot) {
  if(issharedfuncdefined("<dev string:x867>", "<dev string:x883>")) {
    host = [[getsharedfunc("<dev string:x867>", "<dev string:x883>")]]();
  }

  if(!isDefined(host)) {
    return 0;
  }

  vehicle = level.botvehicle;

  if(!isDefined(vehicle) || istrue(vehicle.isdestroyed)) {
    iprintln("<dev string:xf52>");
    return 0;
  }

  occupants = vehicle_occupancy_getalloccupantsandreserving(vehicle);
  hostvehicle = host getvehicle();

  if(vehicle_isenemytoplayer(vehicle, bot)) {
    if(occupants.size > 1) {
      iprintln("<dev string:xf71>");
      return 0;
    } else if(isDefined(hostvehicle) && hostvehicle == vehicle) {
      return function_62e42dbf117640e5(vehicle, bot, host);
    }

    return;
  }

  return function_40c538fb1bd10587(vehicle, bot);
}

function function_62e42dbf117640e5(vehicle, bot, host) {
  vehicle_interact_allowvehicleuse(vehicle, 0);
  thread vehicle_occupancy_ejectalloccupants(vehicle);

  while(true) {
    if(!isDefined(host)) {
      break;
    }

    if(!isDefined(bot)) {
      break;
    }

    if(!isDefined(vehicle)) {
      break;
    }

    hostvehicle = host getvehicle();

    if(!isDefined(hostvehicle) || hostvehicle != vehicle) {
      break;
    }

    waitframe();
  }

  if(!isDefined(vehicle) || istrue(vehicle.isdestroyed)) {
    iprintln("<dev string:xf8b>");
    return 0;
  } else {
    vehicle_interact_allowvehicleuse(vehicle, 1);
  }

  if(!isDefined(bot)) {
    iprintln("<dev string:xf8b>");
    return 0;
  }

  return function_40c538fb1bd10587(vehicle, bot);
}

function function_80491ae71b928cfa(bot) {
  vehicle = level.botvehicle;

  if(!isDefined(vehicle) || istrue(vehicle.isdestroyed)) {
    iprintln("<dev string:xf52>");
    return 0;
  }

  seatid = vehicle_occupancy_getoccupantseat(vehicle, bot);
  switchseatid = vehicle_occupancy_getnextavailableseat(vehicle, bot, seatid);

  if(!isDefined(switchseatid)) {
    iprintln("<dev string:xfa8>");
    return 0;
  }

  thread vehicle_occupancy_enter(vehicle, switchseatid, bot);
  return 1;
}

function function_40c538fb1bd10587(vehicle, bot) {
  pointrefs = function_c2f090b27fcd0e43(vehicle);
  state = function_d66fa700ce5b783();

  foreach(part in pointrefs) {
    if(isDefined(bot getvehicle())) {
      break;
    }

    vehicle_interact_scriptableused(vehicle getlinkedscriptableinstance(), part, state, bot, 0);
  }

  if(!isDefined(bot getvehicle())) {
    iprintln("<dev string:xf8b>");
    return 0;
  }

  return 1;
}

# /