/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\vehicle_occupancy.gsc
********************************************************/

function vehicle_occupancy_getleveldataforvehicle(var_0, var_1) {
  var_2 = vehicle_occupancy_getleveldata();
  var_3 = var_2.vehicledata[var_0];

  if(!isDefined(var_3)) {
    if(isDefined(var_1)) {
      var_3 = spawnStruct();
      var_2.vehicledata[var_0] = var_3;
      var_3.seatdata = [];
      var_3.enterstartcallback = undefined;
      var_3.enterendcallback = undefined;
      var_3.exitstartcallback = undefined;
      var_3.exitendcallback = undefined;
      var_3.reentercallback = undefined;
      var_3.ref_11d02 = undefined;
      var_3.restrictions = [];
      var_3.damagemodifier = -1;
      var_3.hideoccupant = undefined;
      var_3.camera = "none";
      var_3.threatbiasgroup = "Level_Vehicle";
      var_3.exitextents = [];
      var_3.exitextents["front"] = undefined;
      var_3.exitextents["back"] = undefined;
      var_3.exitextents["left"] = undefined;
      var_3.exitextents["right"] = undefined;
      var_3.exitextents["top"] = undefined;
      var_3.exitextents["bottom"] = undefined;
      var_3.exitoffsets = [];
      var_3.exitdirections = [];
      var_3.exittopcastoffset = undefined;
      var_3.damagefeedbackgrouplight = "driver";
      var_3.damagefeedbackgroupheavy = "all";
    }
  }

  return var_3;
}

function vehicle_occupancy_getleveldataforseat(var_0, var_1, var_2) {
  var_3 = vehicle_occupancy_getleveldataforvehicle(var_0, var_2);
  var_4 = var_3.seatdata[var_1];

  if(!isDefined(var_4)) {
    if(istrue(var_2)) {
      var_4 = spawnStruct();
      var_3.seatdata[var_1] = var_4;
      var_4.vehicledata = var_3;
      var_4.seatswitcharray = [];
      var_4.exitids = [];
      var_4.spawnpriority = undefined;
      var_4.viewclamps = [];
      var_4.viewclamps["top"] = undefined;
      var_4.viewclamps["bottom"] = undefined;
      var_4.viewclamps["left"] = undefined;
      var_4.viewclamps["right"] = undefined;
      var_4.hideheldweapon = undefined;
      var_4.hidestowedweapon = undefined;
      var_4.ref_13345 = undefined;
      var_4.ref_13e8a = undefined;
      var_4.ref_13e8b = undefined;
      var_4.ref_13e92 = undefined;
    }
  }

  return var_4;
}

function vehicle_occupancy_registerinstance(var_0) {
  var_0.occupants = [];
  var_0.occupantsreserving = [];
  var_0.isempty = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "registerInstance")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "registerInstance")]](var_0);
    return;
  }
}

function vehicle_occupancy_deregisterinstance(var_0) {
  var_0.occupants = undefined;
  var_0.occupantsreserving = undefined;
  var_0.isempty = undefined;
  var_0.ref_1287d = undefined;
  var_0.brking_rankupdate = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "deregisterInstance")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "deregisterInstance")]](var_0);
    return;
  }
}

function ref_141de(var_0) {
  return isDefined(var_0.occupants);
}

function vehicle_occupancy_getallvehicleseats(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);

  if(isDefined(var_2)) {
    return getarraykeys(var_2.seatdata);
  }

  return [];
}

function vehicle_occupancy_getavailablevehicleseats(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = vehicle_occupancy_getallvehicleseats(var_0);

  foreach(var_6 in var_4) {
    if(!vehicle_occupancy_seatisavailable(var_0, var_6)) {
      continue;
    }

    var_3 = var_6;
  }

  if(istrue(var_1)) {
    if(var_3.size > 0) {
      var_8 = [];

      foreach(var_6 in var_3) {
        var_10 = vehicle_occupancy_getleveldataforseat(var_0.vehiclename, var_6);
        var_11 = var_10.spawnpriority;

        if(!isDefined(var_11)) {
          var_11 = 0;
        } else {
          var_11 = int(max(0, var_11));
        }

        var_8 = var_11;
      }

      if(istrue(var_2)) {
        for(var_13 = 0; var_13 < var_3.size - 1; var_13++) {
          var_14 = var_13;

          for(var_15 = var_13 + 1; var_15 < var_3.size; var_15++) {
            if(var_8[var_3[var_15]] > var_8[var_3[var_14]]) {
              var_14 = var_15;
            }
          }

          if(var_14 != var_13) {
            var_16 = var_3[var_13];
            var_3 = var_3[var_14];
            var_3 = var_16;
          }
        }
      } else {
        for(var_13 = 0; var_13 < var_5.size - 1; var_13++) {
          var_17 = var_5[var_13];

          for(var_15 = var_13 + 1; var_15 < var_5.size; var_15++) {
            var_18 = var_5[var_15];

            if(var_10[var_18] > var_10[var_17]) {
              var_16 = var_17;
              var_5 = var_18;
              var_5 = var_16;
            }
          }
        }
      }
    }
  }

  return var_5;
}

function vehicle_occupancy_seatisavailable(var_0, var_1, var_2) {
  var_3 = var_0.occupants[var_1];
  var_4 = var_0.occupantsreserving[var_1];

  if(istrue(var_0.brking_rankupdate)) {
    return false;
  }

  if(!isDefined(var_3) && !isDefined(var_4)) {
    return true;
  }

  if(isDefined(var_2)) {
    if(isDefined(var_3) && var_3 == var_2) {
      return true;
    }

    if(isDefined(var_4) && var_4 == var_2) {
      return true;
    }
  }

  return false;
}

function vehicle_occupancy_getseatoccupant(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(isDefined(var_0.occupants)) {
    return var_0.occupants[var_1];
  }

  return undefined;
}

function vehicle_occupancy_getalloccupants(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  return var_0.occupants;
}

function vehicle_occupancy_getalloccupantsandreserving(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(var_0.occupants)) {
    return undefined;
  }

  return scripts\engine\utility::array_combine_unique(var_0.occupants, var_0.occupantsreserving);
}

function ref_141d6(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(var_0.occupants)) {
    return undefined;
  }

  return var_0.occupantsreserving;
}

function vehicle_occupancy_getoccupantseat(var_0, var_1) {
  foreach(var_3 in var_0.occupants) {
    if(var_3 == var_1) {
      return var_4;
    }
  }

  return undefined;
}

function vehicle_occupancy_occupantisvehicledriver(var_0) {
  if(isDefined(var_0.vehicle)) {
    var_1 = vehicle_occupancy_getoccupantseat(var_0.vehicle, var_0);
    var_2 = vehicle_occupancy_getleveldataforseat(var_0.vehicle.vehiclename, var_1);

    if(isDefined(var_2.animtag)) {
      var_3 = tolower(var_2.animtag);

      if(var_3 == "tag_seat_0") {
        return true;
      }
    }
  }

  return false;
}

function vehicle_occupancy_getdriver(var_0, var_1) {
  var_2 = vehicle_occupancy_getdriverseat(var_0, var_1);

  if(isDefined(var_2)) {
    return vehicle_occupancy_getseatoccupant(var_0, var_2, !istrue(var_1));
  }

  return undefined;
}

function vehicle_occupancy_getdriverseat(var_0, var_1) {
  var_2 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename, !istrue(var_1));

  if(!isDefined(var_2)) {
    return undefined;
  }

  var_3 = var_2.driverseatid;

  if(!isDefined(var_3)) {
    foreach(var_5 in var_2.seatdata) {
      if(isDefined(var_5.animtag) && tolower(var_5.animtag) == "tag_seat_0") {
        var_3 = var_6;
        break;
      }
    }

    var_2.driverseatid = var_3;
  }

  return var_3;
}

function ref_141df(var_0, var_1) {
  var_2 = vehicle_occupancy_getleveldataforseat(var_0.vehiclename, var_1);

  if(!isDefined(var_2.animtag)) {
    return false;
  }

  if(tolower(var_2.animtag) != "tag_seat_0") {
    return false;
  }

  return true;
}

function vehicle_occupancy_enter(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;

  if(isDefined(var_3) && isDefined(var_3.useonspawn)) {
    var_5 = 1;
  }

  if(!var_5 && !var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }

  if(istrue(var_2.inlaststand)) {
    return;
  }

  if(istrue(var_0.isdestroyed)) {
    return;
  }

  if(istrue(var_0.oob)) {
    if(isDefined(var_0.oobendtime) && var_0.oobendtime - gettime() < 100) {
      return;
    }
  }

  if(isDefined(var_0.vehicletype) && var_0.vehicletype == "motorcycle_physics_mp") {
    var_6 = [var_0];
    var_7 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_glass", "physicscontents_item"];
    var_8 = physics_createcontents(var_7);

    if(isDefined(var_8)) {
      var_9 = (0, 0, 1);
      var_10 = getdvarfloat("scr_motoEnterRaycastHeight", 30);
      var_11 = getdvarfloat("scr_motoEnterRaycastRadius", 0.5);
      var_12 = var_0 physics_getentitycenterofmass()["unscaled"];

      if(isDefined(var_12)) {
        var_13 = var_12 + var_9 * var_10;
        var_14 = scripts\engine\trace::sphere_trace(var_12, var_13, var_11, var_6, var_8);

        if(isDefined(var_14)) {
          var_15 = distance(var_12, var_14["position"]);

          if(var_15 < var_10) {
            return;
          }
        }
      }
    }
  }

  if(!scripts\cp_mp\vehicles\vehicle_tracking::_wakeupvehicle(var_0, 0, 0)) {
    return 0;
  }

  foreach(var_17 in var_0.occupantsreserving) {
    if(isDefined(var_17) && var_17 == var_2) {
      return;
    }
  }

  var_19 = vehicle_occupancy_getoccupantseat(var_0, var_2);

  if(istrue(vehicle_occupancy_seatisavailable(var_0, var_1, var_2))) {
    vehicle_occupancy_stopmonitoringoccupant(var_2);

    if(!isDefined(var_3)) {
      var_3 = spawnStruct();
    }

    var_3.immediate = istrue(var_4);
    var_3.raceendnotify = "vehicle_race_last_call";
    var_3.raceendon = "vehicle_race_finished";

    if(!var_3.immediate) {
      thread vehicle_occupancy_raceplayerdeathdisconnect(var_2, var_3);
      thread vehicle_occupancy_racevehicledeath(var_0, var_3);
      thread vehicle_occupancy_raceseatunavailable(var_0, var_2, var_1, var_19, var_3);
      thread vehicle_occupancy_racecomplete(var_19, var_1, var_3);
    }

    if(isDefined(var_19)) {
      thread vehicle_occupancy_exitstart(var_0, var_19, var_1, var_2, var_3);
    }

    if(isDefined(var_1)) {
      thread vehicle_occupancy_enterstart(var_0, var_1, var_19, var_2, var_3);
    }

    vehicle_occupancy_updatefull(var_0);
    vehicle_occupancy_updateempty(var_0);

    if(!var_3.immediate) {
      var_3 waittill(var_3.raceendnotify);
      waittillframeend();
      var_3 notify(var_3.raceendon);
    }

    if(!scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_instanceisregistered(var_0)) {
      var_3.success = 0;

      if(isDefined(var_1)) {
        thread vehicle_occupancy_enterend(var_0, var_1, var_19, var_2, var_3);
      }

      return;
    }

    var_20 = vehicle_occupancy_raceresults(var_0, var_2, var_19, var_1, var_3);

    if(isDefined(var_19)) {
      thread vehicle_occupancy_exitend(var_0, var_19, var_1, var_2, var_3);
    }

    if(isDefined(var_1)) {
      thread vehicle_occupancy_enterend(var_0, var_1, var_19, var_2, var_3);
    }

    vehicle_occupancy_updatefull(var_0);
    vehicle_occupancy_updateempty(var_0);

    if(var_20) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "changedSeats")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "changedSeats")]](var_2, var_0, var_19, var_1);
      }

      thread vehicle_occupancy_monitoroccupant(var_0, var_2, var_1);
      var_2 cancelreloading();

      if(istrue(var_2.tracking_max_health)) {
        var_2 notify("br_try_armor_cancel");
      }

      if(isDefined(var_19)) {
        var_21 = ref_141df(var_0, var_19);

        if(istrue(var_21) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "stopChallengeTimer")) {
          var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "stopChallengeTimer")]]("driving");
        }
      }

      if(isDefined(var_1)) {
        var_21 = ref_141df(var_0, var_1);

        if(istrue(var_21) && !istrue(level.loadoutbrfieldupgrade)) {
          var_22 = 0;
          var_23 = "";
          var_24 = "";
          var_25 = "";
          var_26 = "";

          switch (var_0.targetname) {
            case "apc_russian":
              var_23 = var_2.ref_14238.apc;
              var_24 = var_2.ref_14238.c4_pick_up_listener;
              var_22 = 1;
              var_25 = var_2.ref_14238.c130airdrop_heightoverride;
              break;
            case "atv":
              var_23 = var_2.ref_14238.check_cannot_spawn_tank;
              var_25 = var_2.ref_14238.check_carrier_status;
              var_26 = var_2.ref_14238.check_for_damage_scalar_change;
              break;
            case "cargo_truck_mg":
            case "cargo_truck":
              var_23 = var_2.ref_14238.get_extra_focus_fire_multipler;
              var_25 = var_2.ref_14238.get_fake_digit_from_pool;
              break;
            case "jeep":
              var_23 = var_2.ref_14238.vehicle_damage_endburndown;
              var_25 = var_2.ref_14238.vehicle_damage_enginevisualclearcallback;
              break;
            case "little_bird_mg":
            case "little_bird":
              var_23 = var_2.ref_14238.x1opsenableelimination;
              var_25 = var_2.ref_14238.x1opsendgame;
              var_26 = var_2.ref_14238.zombieingas;
              break;
            case "tac_rover":
              var_23 = var_2.ref_14238.ref_139f7;
              var_25 = var_2.ref_14238.ref_139f8;
              var_26 = var_2.ref_14238.ref_139fc;
              break;
            case "light_tank":
              var_23 = scripts\engine\utility::ter_op(isDefined(var_0.spawndata.usealtmodel), var_2.ref_14238.ref_13a47, var_2.ref_14238.ref_13a52);
              var_24 = scripts\engine\utility::ter_op(isDefined(var_0.spawndata.usealtmodel), var_2.ref_14238.ref_13a48, var_2.ref_14238.ref_13a53);
              var_22 = 1;
              break;
            case "motorcycle":
              var_23 = var_2.ref_14238.ref_11d4d;
              var_25 = var_2.ref_14238.ref_11d5f;
              var_26 = var_2.ref_14238.ref_11d70;
              break;
            case "veh_a10fd":
              var_23 = var_2.ref_14238.br_is_allowed_armor_insert;
              var_26 = var_2.ref_14238.br_isplayerbeforeinitialinfildeploy;
              break;
            case "bomber":
              var_23 = var_2.ref_14238.create_head_icon_for_crate;
              var_26 = var_2.ref_14238.createjuggdroplocation;
              break;
            case "cargo_truck_susp_aa":
            case "cargo_truck_susp":
              var_23 = "";
              var_25 = var_2.ref_14238.get_fake_digit_from_pool;
              break;
            case "open_jeep":
              var_23 = "";
              var_25 = var_2.ref_14238.vehicle_damage_enginevisualclearcallback;
              break;
            case "open_jeep_carpoc":
              var_23 = var_2.ref_14238.open_jeep_carpoc;
              var_24 = var_2.ref_14238.open_jeep_carpoc_turret;
              var_22 = 1;
              var_25 = var_2.ref_14238.open_jeep_carpoc_horn;
              break;
            default:
              var_23 = "";
              var_25 = "";
              break;
          }

          var_0 setfacialindexfromasm(var_25);

          if(var_23 != "" && !isDefined(var_0.gasfxair)) {
            var_0 setvehiclecamo();
            var_0 getmountconfigenabled(var_23);

            if(var_22) {
              foreach(var_28 in var_0.turrets) {
                var_28 sendclientmatchdataforclient(var_24);
                break;
              }
            }

            var_0.ref_1426c = var_26;
            var_0.gasfxair = 1;
          }

          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "startChallengeTimer")) {
            var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "startChallengeTimer")]]("driving");
          }
        }
      }

      if(!isDefined(var_19)) {
        var_30 = "ENTERED_VEHICLE";
      } else {
        var_30 = "SEAT_SWITCH";
      }

      abilityleft::cleanuparenamolotovs(var_1, var_3, var_2, var_20);
      scripts\cp_mp\vehicles\vehicle_dlog::ref_1418a(var_1, var_3, var_2, var_30);
      return;
    }

    if(isDefined(var_20) && !istrue(var_4.vehicledeath)) {
      if(istrue(var_4.playerdeath) || istrue(var_4.playerlaststand) || istrue(var_4.playerdisconnect)) {
        var_31 = spawnStruct();
        var_31.playerdeath = var_4.playerdeath;
        var_31.playerlaststand = var_4.playerlaststand;
        var_31.playerdisconnect = var_4.playerdisconnect;
        thread vehicle_occupancy_exit(var_1, var_20, var_3, var_31, 1);
        return;
      }

      vehicle_occupancy_reenter(var_1, var_20, var_2, var_3, var_4);
      return;
    }

    return;
  }
}

function vehicle_occupancy_exit(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_1;

  if(isDefined(var_2)) {
    if(!isDefined(var_5)) {
      var_5 = vehicle_occupancy_getoccupantseat(var_0, var_2);
    }

    if(!var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_4 = 1;
    }

    if(istrue(var_2.inlaststand)) {
      var_4 = 1;
    }

    vehicle_occupancy_stopmonitoringoccupant(var_2);
  } else {
    var_4 = 1;
    vehicle_occupancy_purgedataforseatinstance(var_0, var_5);
  }

  if(istrue(var_0.isdestroyed)) {
    var_4 = 1;
  }

  if(!isDefined(var_3)) {
    var_3 = spawnStruct();
  }

  var_3.immediate = istrue(var_4);
  var_3.raceendnotify = "vehicle_race_last_call";
  var_3.raceendon = "vehicle_race_finished";

  if(!var_3.immediate) {
    thread vehicle_occupancy_raceplayerdeathdisconnect(var_2, var_3);
    thread vehicle_occupancy_racevehicledeath(var_0, var_3);
    thread vehicle_occupancy_racecomplete(var_5, undefined, var_3);
  }

  thread vehicle_occupancy_exitstart(var_0, var_5, undefined, var_2, var_3);

  if(!var_3.immediate) {
    var_3 waittill(var_3.raceendnotify);
    waittillframeend();
    var_3 notify(var_3.raceendon);
  }

  var_6 = vehicle_occupancy_raceresults(var_0, var_2, var_5, undefined, var_3);
  thread vehicle_occupancy_exitend(var_0, var_5, undefined, var_2, var_3);
  vehicle_occupancy_updatefull(var_0);
  vehicle_occupancy_updateempty(var_0);

  if(!var_6) {
    if(!istrue(var_3.playerdeath) && !istrue(var_3.playerlaststand) && !istrue(var_3.playerdisconnect) && !istrue(var_3.vehicledeath)) {
      vehicle_occupancy_reenter(var_0, var_5, undefined, var_2, var_3);
      return;
    }

    return;
  }

  if(isDefined(var_2)) {
    var_2 cancelreloading();
    var_7 = ref_141df(var_0, var_5);

    if(istrue(var_7) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "stopChallengeTimer")) {
      var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "stopChallengeTimer")]]("driving");
      return;
    }

    return;
  }
}

function ref_141e2(var_0, var_1) {
  if(level.teambased) {
    return ref_141e3(var_0, var_1.team);
  }

  if(istrue(var_0.playersetattractionoff)) {
    ref_141c8(var_0, var_0);
  }

  return isDefined(var_0.ref_12564) && var_0.ref_12564 == var_1;
}

function ref_141e0(var_0, var_1) {
  if(level.teambased) {
    return ref_141e1(var_0, var_1.team);
  }

  if(istrue(var_0.playersetattractionoff)) {
    ref_141c8(var_0, var_0);
  }

  return isDefined(var_0.ref_12564) && var_0.ref_12564 != var_1;
}

function ref_141e4(var_0, var_1) {
  if(level.teambased) {
    return ref_141e5(var_0, var_1.team);
  }

  if(istrue(var_0.playersetattractionoff)) {
    ref_141c8(var_0, var_0);
  }

  return !isDefined(var_0.ref_12564);
}

function ref_141d5(var_0) {
  if(!level.teambased) {
    if(istrue(var_0.playersetattractionoff)) {
      ref_141c8(var_0, var_0);
    }

    return var_0.ref_12564;
  }

  return undefined;
}

function ref_141e3(var_0, var_1) {
  if(level.teambased) {
    if(istrue(var_0.playersetattractionoff)) {
      ref_141c8(var_0, var_0);
    }

    return (isDefined(var_0.ref_13aad) && var_0.ref_13aad == var_1);
  }

  return undefined;
}

function ref_141e1(var_0, var_1) {
  if(level.teambased) {
    if(istrue(var_0.playersetattractionoff)) {
      ref_141c8(var_0, var_0);
    }

    return (isDefined(var_0.ref_13aad) && var_0.ref_13aad != var_1);
  }

  return undefined;
}

function ref_141e5(var_0, var_1) {
  if(level.teambased) {
    if(istrue(var_0.playersetattractionoff)) {
      ref_141c8(var_0, var_0);
    }

    return !isDefined(var_0.ref_13aad);
  }

  return undefined;
}

function ref_141d7(var_0) {
  if(level.teambased) {
    if(istrue(var_0.playersetattractionoff)) {
      ref_141c8(var_0, var_0);
    }

    return var_0.ref_13aad;
  }

  return undefined;
}

function ref_141f4(var_0) {
  var_0.playersetattractionoff = 1;
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setvehicledirty(var_0);
}

function ref_141c8(var_0) {
  if(level.teambased) {
    var_1 = 0;
    var_2 = var_0.ref_13aad;

    if(isDefined(var_0.team) && var_0.team != "neutral") {
      var_0.ref_13aad = var_0.team;
      var_0.playersetattractionoff = undefined;
      var_1 = 1;
    }

    if(!var_1) {
      foreach(var_4 in var_0.occupants) {
        if(isDefined(var_4)) {
          var_0.ref_13aad = var_4.team;
          var_0.playersetattractionoff = undefined;
          var_1 = 1;
          break;
        }
      }
    }

    if(!var_1) {
      var_0.ref_13aad = undefined;
      var_0.playersetattractionoff = undefined;
    }

    if(!isDefined(var_2) && !isDefined(var_0.ref_13aad)) {
      return 0;
    }

    if(isDefined(var_2) && isDefined(var_0.ref_13aad) && var_2 == var_0.ref_13aad) {
      return 0;
    }

    ref_141d4(var_0, var_2, var_0.ref_13aad);
    return 1;
  }

  var_1 = 0;
  var_6 = var_2.ref_12564;

  if(isDefined(var_2.originalowner)) {
    var_2.ref_12564 = var_2.originalowner;
    var_2.playersetattractionoff = undefined;
    var_1 = 1;
  }

  if(!var_1) {
    var_7 = vehicle_occupancy_getalloccupants(var_2);

    foreach(var_4 in var_7) {
      if(isDefined(var_4)) {
        var_2.ref_12564 = var_4;
        var_2.playersetattractionoff = undefined;
        return;
      }
    }
  }

  if(!isDefined(var_6) && !isDefined(var_2.ref_12564)) {
    return 0;
  }

  if(isDefined(var_6) && isDefined(var_2.ref_12564) && var_6 == var_2.ref_12564) {
    return 0;
  }

  ref_141d4(var_2, var_6, var_2.ref_12564);
  return 1;
}

function ref_141d4(var_0, var_1, var_2) {
  _calloutmarkerping_predicted_timeout::ref_14121(var_0, var_1, var_2);
  var_3 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);

  if(!isDefined(var_3.playersetattractionlocationindex)) {
    return;
  }

  GscBinSkip1(0x74, var_3.playersetattractionlocationindex, var_0, var_1, var_2);
}

function vehicle_occupancy_setoriginalowner(var_0, var_1) {
  var_0.originalowner = var_1;
  vehicle_occupancy_updateowner(var_0);
}

function vehicle_occupancy_setowner(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0.owners)) {
    var_0.owners = [];
  } else {
    vehicle_occupancy_clearowner(var_0, var_1);
    var_0.owners = scripts\engine\utility::array_removeundefined(var_0.owners);
  }

  var_0.owners[var_0.owners.size] = var_1;

  if(isDefined(var_3) && var_3 == -1) {} else {
    thread vehicle_occupancy_watchowner(var_0, var_1, var_2, var_3);
  }

  vehicle_occupancy_updateowner(var_0);
}

function vehicle_occupancy_updateowner(var_0) {
  var_0 notify("vehicle_owner_update");
  var_1 = var_0.owner;
  var_2 = var_0.ownerteam;
  var_3 = undefined;

  if(isDefined(var_0.owners)) {
    for(var_4 = var_0.owners.size - 1; var_4 >= 0; var_4--) {
      if(vehicle_occupancy_isplayervalidowner(var_0, var_0.owners[var_4])) {
        var_3 = var_0.owners[var_4];
        break;
      }
    }
  }

  if(!isDefined(var_3)) {
    if(vehicle_occupancy_isplayervalidowner(var_0, var_0.originalowner)) {
      var_3 = var_0.originalowner;
    }
  }

  var_0.owner = var_3;
  var_5 = 0;

  if(isDefined(var_3) || isDefined(var_1)) {
    if(!isDefined(var_3) && isDefined(var_1)) {
      var_5 = 1;
    } else if(isDefined(var_3) && !isDefined(var_1)) {
      var_5 = 1;
    } else if(var_3 != var_1) {
      var_5 = 1;
    }
  }

  var_6 = 0;

  if(isDefined(var_3)) {
    if(!isDefined(var_2) || var_2 != var_3.team) {
      var_6 = 1;
    }

    var_0.ownerteam = var_3.team;
    var_0 setvehicleteam(var_3.team);
    thread vehicle_occupancy_watchownerjoinedteam(var_0, var_3);
  } else {
    if(var_5) {
      var_6 = 1;
    }

    var_0.ownerteam = undefined;
  }

  if(var_5) {
    if(!level.teambased) {
      ref_141f4(var_0);
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "updateOwner")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "updateOwner")]](var_0);
  }

  var_7 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);

  if(isDefined(var_7) && isDefined(var_7.updateownercallback)) {
    [[var_7.updateownercallback]](var_0, var_3, var_5, var_6);
    return;
  }
}

function vehicle_occupancy_clearowner(var_0, var_1) {
  var_0 notify("vehicle_clear_owner_" + var_1 getentitynumber());

  if(isDefined(var_0.owners)) {
    var_0.owners = scripts\engine\utility::array_remove(var_0.owners, var_1);
  }

  if(isDefined(var_0.owner) && var_0.owner == var_1) {
    vehicle_occupancy_updateowner(var_0);
    return;
  }
}

function vehicle_occupancy_setteam(var_0, var_1) {
  var_2 = !isDefined(var_0.team) || var_0.team != var_1;
  var_0.team = var_1;

  if(var_0.classname == "script_vehicle") {
    var_0 setvehicleteam(var_1);
  }

  if(var_2) {
    if(level.teambased) {
      ref_141f4(var_0);
    }
  }

  var_3 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);

  if(isDefined(var_3) && isDefined(var_3.updateteamcallback)) {
    [[var_3.updateteamcallback]](var_0, var_1, var_2);
  }

  vehicle_occupancy_updateowner(var_0);
}

function vehicle_occupancy_init() {
  var_0 = spawnStruct();
  level.vehicle.occupancy = var_0;
  var_0.vehicledata = [];
  var_0.ref_13cea = getdvarint("scr_transitionHideEnabled", 1) > 0;

  if(var_0.ref_13cea) {
    var_0.ref_13ceb = 0;
    var_0.ref_13cec = [];
  }

  vehicle_occupancy_initdebug();
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "init")]]();
}

function vehicle_occupancy_enterstart(var_0, var_1, var_2, var_3, var_4) {
  var_4 endon(var_4.raceendon);
  var_0.occupantsreserving[var_1] = var_3;
  var_3.ref_1425d = var_0;
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setvehicledirty(var_0);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setpointsdirty(var_0);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(var_0);
  var_5 = undefined;

  if(var_4.immediate) {
    var_5 = gettime();
  }

  if(isDefined(var_4.enterstartwaitmsg)) {
    var_3 waittill(var_4.enterstartwaitmsg);
  }

  vehicle_occupancy_deleteseatcorpse(var_0, var_1, 1);

  if(isDefined(var_3) && var_3 isthrowinggrenade()) {
    if(!isDefined(var_4.enterstartcomplete)) {
      var_4.enterstartcomplete = 1;
    }

    var_4.success = 0;
    return;
  }

  var_6 = vehicle_occupancy_getenterstartcallbackforseat(var_0, var_1);

  if(isDefined(var_6)) {
    [[var_6]](var_0, var_1, var_2, var_3, var_4);
  }

  if(!isDefined(var_4.enterstartcomplete)) {
    var_4.enterstartcomplete = 1;
  }

  if(var_4.immediate) {
    return;
  }
}

function vehicle_occupancy_exitstart(var_0, var_1, var_2, var_3, var_4) {
  var_4 endon(var_4.raceendon);
  var_5 = undefined;

  if(var_4.immediate) {
    var_5 = gettime();
  }

  var_6 = vehicle_occupancy_getexitstartcallbackforseat(var_0, var_1);

  if(isDefined(var_6)) {
    [[var_6]](var_0, var_1, var_2, var_3, var_4);
  }

  if(!isDefined(var_4.exitstartcomplete)) {
    var_4.exitstartcomplete = 1;
  }

  if(var_4.immediate) {
    return;
  }
}

function vehicle_occupancy_exitstartcallback(var_0, var_1, var_2, var_3, var_4) {
  var_4 endon(var_4.raceendon);
  var_5 = vehicle_occupancy_findplayerexit(var_3, var_0, var_1, var_2, var_4);

  if(!var_5) {
    var_4.exitstartcomplete = 0;
    ref_141d1(var_3, 2);

    if(!istrue(var_4.immediate)) {
      waitframe();
      var_4 notify(var_4.raceendnotify);
      return;
    }

    return;
  }
}

function vehicle_occupancy_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    var_0.occupants[var_1] = var_3;
    var_0.occupantsreserving[var_1] = undefined;
    var_3.vehicle = var_0;
    var_3.ref_1425d = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "disableClassSwapAllowed")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "disableClassSwapAllowed")]]();
    }

    vehicle_occupancy_applyrestrictionstooccupant(var_0, var_1, var_3, var_4);
    ref_141f9(var_3, var_0, var_1);
    vehicle_occupancy_hideoccupant(var_0, var_1, var_3, var_4);
    vehicle_occupancy_applycameratooccupant(var_0, var_1, var_2, var_3, var_4);
    vehicle_occupancy_applydamagemodifiertooccupant(var_0, var_1, var_3, var_4);
    ref_141db(var_0, var_1, var_3, var_4);

    if(!isDefined(var_2)) {
      vehicle_occupancy_onentervehicle(var_0, var_1, var_3, var_4);
    }

    var_5 = vehicle_occupancy_getleveldataforseat(var_0.vehiclename, var_1);

    if(isDefined(var_5.animtag) && tolower(var_5.animtag) == tolower("tag_seat_0")) {
      vehicle_occupancy_setowner(var_0, var_3, 1);
    }

    if(!isDefined(var_2)) {
      var_3 notify("vehicle_enter");

      if(isDefined(var_5.ref_12023)) {
        thread ref_141da(var_3, var_5, 1);
      }
    } else {
      var_3 notify("vehicle_change_seat");

      if(isDefined(var_5.ref_12023)) {
        thread ref_141da(var_3, var_5, 0);
      }
    }
  } else {
    if(isDefined(var_3)) {
      var_3.ref_1425d = undefined;
      var_5 = vehicle_occupancy_getleveldataforseat(var_0.vehiclename, var_1);

      if(isDefined(var_5.ref_13e92)) {
        vehicle_occupancy_taketurret(var_3, var_0, var_5.ref_13e92, var_4, 1);
      }

      vehicle_occupancy_showoccupant(var_0, var_1, var_3, var_4, 1);
    }

    if(!istrue(var_4.vehicledeath)) {
      var_0.occupantsreserving[var_1] = undefined;
    }
  }

  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setvehicledirty(var_0);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setpointsdirty(var_0);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(var_0);
  var_6 = gettime();
  var_7 = vehicle_occupancy_getenterendcallbackforseat(var_0, var_1);

  if(isDefined(var_7)) {
    [[var_7]](var_0, var_1, var_2, var_3, var_4);
  }
}

function vehicle_occupancy_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(var_4.success) {
    var_0.occupants[var_1] = undefined;

    if(isDefined(var_3)) {
      var_3 notify("vehicle_seat_exit");
      var_5 = 0;

      if(!isDefined(var_2)) {
        var_3.vehicle = undefined;
        var_5 = 1;
      }

      vehicle_occupancy_removerestrictionsfromoccupant(var_0, var_1, var_3, var_4);
      ref_141f9(var_3, var_0, var_2);
      vehicle_occupancy_showoccupant(var_0, var_1, var_3, var_4, var_5);
      vehicle_occupancy_removecamerafromoccupant(var_0, var_2, var_3, var_4);
      vehicle_occupancy_removedamagemodifierfromoccupant(var_0, var_1, var_3, var_4);
      ref_141f5(var_0, var_1, var_3, var_4);
    }

    if(!isDefined(var_2)) {
      vehicle_occupancy_onexitvehicle(var_0, var_1, var_3, var_4);
    }

    if(!var_0 scripts\common\vehicle_code::vehicle_is_stopped() && ref_141df(var_0, var_1)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br", "challengeEvaluator")) {
        var_6 = spawnStruct();
        var_6.onplayerkillednew = 1;
        var_3 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("br", "challengeEvaluator")]]("br_mastery_ghostRideWhip", var_6);
      }
    }
  }

  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setvehicledirty(var_0);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setpointsdirty(var_0);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(var_0);
  var_7 = gettime();
  var_8 = vehicle_occupancy_getexitendcallbackforseat(var_0, var_1);

  if(isDefined(var_8)) {
    [[var_8]](var_0, var_1, var_2, var_3, var_4);
  }

  if(isDefined(var_3)) {
    var_3 usebuttondone();

    if(!isDefined(var_2)) {
      if(isDefined(var_3.ref_14277)) {
        var_3.ref_14277 = undefined;
      }

      if(isDefined(var_3.ref_14276)) {
        var_3.ref_14276 = undefined;
      }
    }
  }
}

function vehicle_occupancy_reenter(var_0, var_1, var_2, var_3, var_4) {
  thread vehicle_occupancy_monitoroccupant(var_0, var_3, var_1);
  var_5 = gettime();
  var_6 = vehicle_occupancy_getreentercallbackforseat(var_0, var_1);

  if(isDefined(var_6)) {
    [[var_6]](var_0, var_1, var_2, var_3, var_4);
  }
}

function vehicle_occupancy_getleveldata() {
  return level.vehicle.occupancy;
}

function ref_141da(var_0, var_1, var_2) {
  var_3 = 5000;

  if(istrue(var_2)) {
    var_0.ref_14277 = var_1.ref_12023;
    GscBinSkip1(0x74, scripts\cp_mp\utility\script_utility::getsharedfunc("game", "trySayLocalSound"), var_0, var_1.ref_12023, undefined, 1);
  }

  if(isDefined(var_0.ref_14277) && isDefined(var_0.ref_14276) && var_0.ref_14277 != var_1.ref_12023 && gettime() - var_0.ref_14276 > var_3) {
    GscBinSkip1(0x74, scripts\cp_mp\utility\script_utility::getsharedfunc("game", "trySayLocalSound"), var_0, var_1.ref_12023);
  }
}

function vehicle_occupancy_purgedataforseatinstance(var_0, var_1) {
  var_0.occupants[var_1] = undefined;
  var_0.occupantsreserving[var_1] = undefined;
}

function vehicle_occupancy_onentervehicle(var_0, var_1, var_2, var_3) {
  ref_141f4(var_0);
  var_0 scripts\cp_mp\vehicles\vehicle_spawn::ref_1421a();
  var_2 setstance("stand");
  var_2 scripts\common\utility::allow_array(vehicle_occupancy_getoccupantrestrictions(), 0);
  thread ref_141f8(var_2, var_0, var_1);
  abilityleft::claymore_crate_use(var_0, var_2);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "onEnterVehicle", 1)) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "onEnterVehicle")]](var_0, var_1, var_2, var_3);
    return;
  }
}

function vehicle_occupancy_onexitvehicle(var_0, var_1, var_2, var_3) {
  if(!istrue(var_3.playerdisconnect)) {
    vehicle_occupancy_stopmovefeedbackforplayer(var_2);
    vehicle_occupancy_cleardamagefeedbackforplayer(var_2);

    if(!istrue(var_3.playerdeath)) {
      if(istrue(var_3.playerlaststand)) {
        var_3.onprematchfadedone2 = "DEATH";
      } else if(!isDefined(var_3.onprematchfadedone2)) {
        var_3.onprematchfadedone2 = "VOLUNTARY";
      }

      var_2 scripts\common\utility::allow_array(vehicle_occupancy_getoccupantrestrictions(), 1);
      thread scripts\cp_mp\vehicles\vehicle::ref_14203(var_0, var_2);
    } else {
      var_3.onprematchfadedone2 = "DEATH";
    }

    thread ref_141d9(var_2, var_3.playerdeath, var_3.playerlaststand);
  } else {
    var_3.onprematchfadedone2 = "DISCONNECT";
  }

  ref_141f4(var_0);

  if(scripts\cp_mp\vehicles\vehicle_spawn::ref_14214() && var_0.occupants.size == 0) {
    var_0 thread scripts\cp_mp\vehicles\vehicle_spawn::ref_1421d();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "onExitVehicle", 1)) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "onExitVehicle")]](var_0, var_1, var_2, var_3);
  }

  var_2 notify("player_vehicle_exit");
  scripts\cp_mp\vehicles\vehicle_dlog::vehicle_dlog_exitevent(var_0, var_2, var_1, var_3.onprematchfadedone2);
  abilityleft::claymore_forceclampangles(var_0, var_2, var_1);
}

function vehicle_occupancy_updatefull(var_0) {
  var_1 = vehicle_occupancy_getavailablevehicleseats(var_0).size <= 0;

  if(var_1) {
    if(!istrue(var_0.isfull)) {
      scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setpointdirty(var_0, "single");
      scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(var_0);
      var_0.isfull = 1;
      return;
    }

    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(var_0);
    return;
  }

  if(istrue(var_0.isfull)) {
    var_0.isfull = undefined;
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setpointdirty(var_0, "single");
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(var_0);
    return;
  }

  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(var_0);
}

function vehicle_occupancy_updateempty(var_0) {
  var_1 = vehicle_occupancy_getavailablevehicleseats(var_0);
  var_2 = vehicle_occupancy_getallvehicleseats(var_0);
  var_3 = var_1.size == var_2.size;

  if(!istrue(var_0.isempty) && var_3) {
    scripts\cp_mp\vehicles\vehicle_tracking::vehiclecannotbesuspended(var_0, 0);
  }

  if(istrue(var_0.isempty) && !var_3) {
    var_4 = scripts\cp_mp\vehicles\vehicle_tracking::vehiclecannotbesuspended(var_0, 1, 0);
  }

  var_0.isempty = var_3;
}

function vehicle_occupancy_getenterstartcallbackforseat(var_0, var_1) {
  var_2 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);
  var_3 = var_2.seatdata[var_1];
  return scripts\engine\utility::ter_op(isDefined(var_3.enterstartcallback), var_3.enterstartcallback, var_2.enterstartcallback);
}

function vehicle_occupancy_getenterendcallbackforseat(var_0, var_1) {
  var_2 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);
  var_3 = var_2.seatdata[var_1];
  return scripts\engine\utility::ter_op(isDefined(var_3.enterendcallback), var_3.enterendcallback, var_2.enterendcallback);
}

function vehicle_occupancy_getexitstartcallbackforseat(var_0, var_1) {
  var_2 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);
  var_3 = var_2.seatdata[var_1];
  return scripts\engine\utility::ter_op(isDefined(var_3.exitstartcallback), var_3.exitstartcallback, var_2.exitstartcallback);
}

function vehicle_occupancy_getexitendcallbackforseat(var_0, var_1) {
  var_2 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);
  var_3 = var_2.seatdata[var_1];
  return scripts\engine\utility::ter_op(isDefined(var_3.exitendcallback), var_3.exitendcallback, var_2.exitendcallback);
}

function vehicle_occupancy_getreentercallbackforseat(var_0, var_1) {
  var_2 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);
  var_3 = var_2.seatdata[var_1];
  return scripts\engine\utility::ter_op(isDefined(var_3.reentercallback), var_3.reentercallback, var_2.reentercallback);
}

function vehicle_occupancy_applyrestrictionstooccupant(var_0, var_1, var_2, var_3) {
  if(!vehicle_occupancy_movementisallowed(var_0)) {
    if(var_1 == vehicle_occupancy_getdriverseat(var_0)) {
      vehicle_occupancy_allowmovementplayer(var_0, var_2, 0, var_1);
    }
  }

  var_4 = vehicle_occupancy_getrestrictionsforseat(var_0, var_1);
  var_2 scripts\common\utility::allow_array(var_4, 0);
  var_2 _calloutmarkerping_isvehicleoccupiedbyenemy::loadout_finalizeweapons("vehicle");
}

function vehicle_occupancy_removerestrictionsfromoccupant(var_0, var_1, var_2, var_3) {
  if(!istrue(var_3.playerdeath)) {
    vehicle_occupancy_allowmovementplayer(var_0, var_2, 1, undefined);
    var_4 = vehicle_occupancy_getrestrictionsforseat(var_0, var_1);
    var_2 scripts\common\utility::allow_array(var_4, 1);
    var_2 _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs("vehicle");
    return;
  }
}

function ref_141dd() {
  if(!isDefined(level.spawn_deceleration)) {
    level.spawn_deceleration = getdvarint("scr_hideOccupantWithStack", 1);
  }

  return level.spawn_deceleration;
}

function vehicle_occupancy_hideoccupant(var_0, var_1, var_2, var_3) {
  if(vehicle_shouldhideoccupantforseat(var_0, var_1)) {
    var_2.nocorpse = 1;

    if(ref_141dd()) {
      var_2 scripts\cp_mp\utility\player_utility::allowunresolvedcollision();
    } else {
      var_2 playerhide();
    }

    var_2 _calloutmarkerping_isvehicleoccupiedbyenemy::loadout_finalizeweapons("vehicle");
    return;
  }
}

function ref_141dc(var_0, var_1) {
  var_2 = vehicle_occupancy_getleveldata();

  if(!var_2.ref_13cea) {
    return;
  }

  var_3 = var_2.ref_13ceb;
  var_2.ref_13ceb++;
  var_0 scripts\cp_mp\utility\player_utility::allowunresolvedcollision();
  var_2.ref_13cec[var_3] = var_0;

  if(!isDefined(var_1.ref_13cec)) {
    var_1.ref_13cec = [];
  }

  var_1.ref_13cec[var_3] = var_0;
  var_0 _calloutmarkerping_isvehicleoccupiedbyenemy::loadout_finalizeweapons("vehicle");
  return var_3;
}

function ref_141f7(var_0, var_1, var_2) {
  var_3 = vehicle_occupancy_getleveldata();

  if(!var_3.ref_13cea) {
    return;
  }

  if(istrue(var_2)) {
    waitframe();
    waitframe();
  }

  if(!var_3.ref_13cea) {
    return;
  }

  if(!isDefined(var_3.ref_13cec[var_0])) {
    return;
  }

  var_4 = var_3.ref_13cec[var_0];

  if(isDefined(var_1) && isDefined(var_1.ref_13cec)) {
    var_1.ref_13cec[var_0] = undefined;
  }

  if(isDefined(var_4)) {
    var_4 scripts\cp_mp\utility\player_utility::allplayers_clearphysicaldof();
    var_4 _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs("vehicle");
    return;
  }
}

function ref_141f6(var_0, var_1) {
  var_2 = vehicle_occupancy_getleveldata();

  if(!var_2.ref_13cea) {
    return;
  }

  if(istrue(var_1)) {
    waitframe();
    waitframe();
  }

  if(!isDefined(var_0.ref_13cec)) {
    return;
  }

  foreach(var_4 in var_0.ref_13cec) {
    if(isDefined(var_2.ref_13cec[var_5])) {
      var_2.ref_13cec[var_5] = undefined;

      if(isDefined(var_4)) {
        var_4 scripts\cp_mp\utility\player_utility::allplayers_clearphysicaldof();
      }
    }
  }

  var_0.ref_13cec = undefined;
}

function ref_141c9() {
  var_0 = vehicle_occupancy_getleveldata();

  if(!var_0.ref_13cea) {
    return;
  }

  foreach(var_2 in var_0.ref_13cec) {
    if(!isDefined(var_2)) {
      var_0.ref_13cec[var_3] = undefined;
    }
  }
}

function vehicle_occupancy_showoccupant(var_0, var_1, var_2, var_3, var_4) {
  if(!istrue(var_3.playerdeath)) {
    var_2.nocorpse = undefined;
  }

  if(vehicle_shouldhideoccupantforseat(var_0, var_1) || istrue(var_4)) {
    if(ref_141dd()) {
      if(istrue(var_4)) {
        var_2 scripts\cp_mp\utility\player_utility::ref_125d0();
        var_2 playershow();
        var_2 _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs("vehicle");
        return;
      }

      var_2 scripts\cp_mp\utility\player_utility::allplayers_clearphysicaldof();
      var_2 _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs("vehicle");
      return;
    }

    var_2 playershow();
    var_2 _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs("vehicle");
    return;
  }
}

function vehicle_occupancy_applycameratooccupant(var_0, var_1, var_2, var_3, var_4) {
  var_5 = vehicle_getcameraforseat(var_0, var_1);

  if(isDefined(var_5) && var_5 != "none") {
    var_6 = vehicle_getcameraforseat(var_0, var_2);

    if(var_6 != var_5) {
      var_3 cameraset(var_5);
      return;
    }

    return;
  }
}

function vehicle_occupancy_removecamerafromoccupant(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1)) {
    var_4 = vehicle_getcameraforseat(var_0, var_1);

    if(var_4 == "none") {
      var_2 cameradefault();
      return;
    }

    return;
  }

  var_2 cameradefault();
}

function vehicle_occupancy_applydamagemodifiertooccupant(var_0, var_1, var_2, var_3) {
  var_4 = vehicle_occupancy_getdamagemodifierforseat(var_0, var_1);

  if(isDefined(var_4) && var_4 != -1) {
    var_2 scripts\cp_mp\utility\damage_utility::adddamagemodifier(var_0.vehiclename + "_" + var_1, var_4, 0, &vehicle_occupancy_damagemodifierignorefunc);
    return;
  }
}

function vehicle_occupancy_removedamagemodifierfromoccupant(var_0, var_1, var_2, var_3) {
  if(!istrue(var_3.playerdeath)) {
    var_4 = vehicle_occupancy_getdamagemodifierforseat(var_0, var_1);

    if(isDefined(var_4) && var_4 != -1) {
      var_2 scripts\cp_mp\utility\damage_utility::removedamagemodifier(var_0.vehiclename + "_" + var_1, 0);
      return;
    }

    return;
  }
}

function vehicle_occupancy_getrestrictionsforseat(var_0, var_1) {
  var_2 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);
  var_3 = var_2.seatdata[var_1];
  return scripts\engine\utility::ter_op(isDefined(var_3.restrictions), var_3.restrictions, var_2.restrictions);
}

function vehicle_shouldhideoccupantforseat(var_0, var_1) {
  var_2 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);
  var_3 = var_2.seatdata[var_1];

  if(isDefined(var_3.hideoccupant)) {
    return istrue(var_3.hideoccupant);
  }

  return istrue(var_2.hideoccupant);
}

function vehicle_getcameraforseat(var_0, var_1) {
  var_2 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);

  if(isDefined(var_1)) {
    var_3 = var_2.seatdata[var_1];
    var_4 = var_2.camera;

    if(isDefined(var_3.camera)) {
      var_4 = var_3.camera;
    }

    if(isDefined(var_3.animtag) && tolower(var_3.animtag) == "tag_seat_0") {
      var_4 = "none";
    }
  } else {
    var_4 = "none";
  }

  return var_4;
}

function vehicle_occupancy_getdamagemodifierforseat(var_0, var_1) {
  var_2 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);
  var_3 = var_2.seatdata[var_1];
  return scripts\engine\utility::ter_op(isDefined(var_3.damagemodifier), var_3.damagemodifier, var_2.damagemodifier);
}

function vehicle_occupancy_damagemodifierignorefunc(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_1, var_2, var_3, var_5, var_4, var_0);

  if(var_4 == "MOD_TRIGGER_HURT") {
    return true;
  }

  if(isDefined(var_5) && var_5.basename == "bomb_site_mp") {
    return true;
  }

  if(var_2 scripts\cp_mp\utility\damage_utility::isstuckdamage(var_7)) {
    return true;
  }

  return false;
}

function vehicle_occupancy_monitoroccupant(var_0, var_1, var_2) {
  thread ref_141e8(var_0, var_1, var_2);
  thread vehicle_occupancy_monitorseatswitch(var_0, var_1, var_2, 1);
  thread vehicle_occupancy_monitorexit(var_0, var_1, var_2);
  thread ref_141e9(var_0, var_1, var_2);
}

function vehicle_occupancy_stopmonitoringoccupant(var_0) {
  var_0 notify("vehicle_occupancy_monitorControls");
  var_0 notify("vehicle_occupancy_monitorSeatSwitch");
  var_0 notify("vehicle_occupancy_monitorExit");
  var_0 notify("vehicle_occupancy_monitorGameEnded");
}

function vehicle_occupancy_monitorseatswitch(var_0, var_1, var_2, var_3) {
  var_1 endon("death_or_disconnect");
  var_1 endon("last_stand_start");
  var_0 endon("death");
  var_0 endon("predeath");
  level endon("game_ended");
  var_1 notify("vehicle_occupancy_monitorSeatSwitch");
  var_1 endon("vehicle_occupancy_monitorSeatSwitch");
  var_4 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);

  if(var_4.seatdata.size <= 1) {
    return;
  }

  var_5 = vehicle_occupancy_getleveldataforseat(var_0.vehiclename, var_2);

  if(!isDefined(var_5.seatswitcharray) || var_5.seatswitcharray.size <= 0) {
    return;
  }

  if(!isbot(var_1)) {
    if(var_3) {
      wait 0.2;
    }

    while(var_1 aicalcsuppressspot()) {
      waitframe();
    }

    while(!var_1 aicalcsuppressspot()) {
      waitframe();
    }

    var_6 = vehicle_occupancy_getnextavailableseat(var_0, var_1, var_2);

    if(isDefined(var_6)) {
      thread vehicle_occupancy_enter(var_0, var_6, var_1);
    }

    ref_141d1(var_1, 1);
    thread vehicle_occupancy_monitorseatswitch(var_0, var_1, var_2, 0);
    return;
  }
}

function vehicle_occupancy_getnextavailableseat(var_0, var_1, var_2) {
  var_3 = vehicle_occupancy_getleveldataforseat(var_0.vehiclename, var_2);

  if(!isDefined(var_3.seatswitcharray) || var_3.seatswitcharray.size <= 0) {
    return undefined;
  }

  foreach(var_5 in var_3.seatswitcharray) {
    if(vehicle_occupancy_seatisavailable(var_0, var_5, var_1)) {
      return var_5;
    }
  }
}

function vehicle_occupancy_monitorexit(var_0, var_1, var_2) {
  var_1 notify("vehicle_occupancy_monitorExit");
  var_1 endon("vehicle_occupancy_monitorExit");
  var_0 endon("death");
  level endon("game_ended");
  vehicle_occupancy_monitorexitinternal(var_0, var_1, var_2);
  var_3 = spawnStruct();

  if(isDefined(var_1)) {
    if(!var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_3.playerdeath = 1;
    }

    if(istrue(var_1.inlaststand)) {
      var_3.playerlaststand = 1;
    }
  } else {
    var_3.playerdisconnect = 1;
  }

  thread vehicle_occupancy_exit(var_0, var_2, var_1, var_3);
}

function vehicle_occupancy_monitorexitinternal(var_0, var_1, var_2) {
  var_1 endon("death_or_disconnect");
  var_1 endon("last_stand_start");
  var_3 = gettime() + 1000;
  var_4 = 0;
  var_1 setclientomnvar("ui_veh_exit_button_holdtime", 0);

  for(;;) {
    if(!var_1 useButtonPressed()) {
      var_4 = 1;
    }

    if(var_4 && gettime() >= var_3) {
      break;
    }

    waitframe();
  }

  var_5 = level.framedurationseconds;
  var_6 = getdvarint("bg_useholdtimeshort", 250) / 1000;

  for(;;) {
    var_7 = 0;
    var_8 = var_1 ismlgfreecamenabled();
    var_9 = 0;
    var_1 setclientomnvar("ui_veh_exit_button_holdtime", 0);
    var_10 = isDefined(var_0) && istrue(var_0.loadandplayholoeffect);

    while(var_1 useButtonPressed()) {
      var_1 forcereloading();
      var_1 startragdollfromvehicleimpact();
      var_9 = 1;
      var_7 += var_5;
      var_11 = var_1 usinggamepad();
      var_12 = var_1 setvehiclehornsound();
      var_13 = !var_11 && !var_12;
      var_14 = !var_11 && var_12;
      var_15 = var_11 && var_8 == 0;
      var_16 = var_11 && var_8 > 0;
      var_17 = var_15 || var_14;

      if(var_15 || var_14) {
        var_1 setclientomnvar("ui_veh_exit_button_holdtime", var_7 / 0.3);
      }

      if((var_17 && var_7 > 0.3 || var_13) && !var_10) {
        return;
      } else if(var_16 && var_7 >= var_6) {
        var_1 cancelreloading();
        var_1 reloadbuttonPressed();
      }

      wait var_5;
    }

    if(var_9 && var_1 usinggamepad() && var_8 > 0 && var_7 < var_6 && !var_10) {
      return;
    } else if(var_9) {
      var_1 cancelreloading();
      var_1 reloadbuttonPressed();
    }

    waitframe();
  }
}

function ref_141d1(var_0, var_1) {
  var_2 = undefined;

  switch (var_1) {
    case 1:
      var_2 = "VEHICLES/SEAT_SWITCH_OCCUPIED";
      break;
    case 2:
      var_2 = "VEHICLES/CANNOT_EXIT";
      break;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
    var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](var_2);
    return;
  }
}

function ref_141e9(var_0, var_1, var_2) {
  var_1 endon("death_or_disconnect");
  var_1 endon("last_stand_start");
  var_1 notify("vehicle_occupancy_monitorGameEnded");
  var_1 endon("vehicle_occupancy_monitorGameEnded");

  if(var_2 == vehicle_occupancy_getdriverseat(var_0)) {
    level waittill("game_ended");
    var_1 allowmovement(0);
    return;
  }
}

function ref_141e8(var_0, var_1, var_2) {
  var_1 endon("death_or_disconnect");
  var_1 endon("last_stand_start");
  var_0 endon("death");
  level endon("game_ended");
  var_1 notify("vehicle_occupancy_monitorControls");
  var_1 endon("vehicle_occupancy_monitorControls");

  if(scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427a(var_1)) {
    return;
  }

  if(true) {
    wait 1.5;
  }

  GscBinSkip4(0x35, var_0, var_1, var_2);
}

function ref_141d2(var_0) {
  scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427b(var_0);
  var_0 notify("vehicle_occupancy_monitorControls");
}

function ref_141ea(var_0, var_1, var_2) {
  var_3 = vehicle_occupancy_getdriverseat(var_0);

  if(var_2 == var_3) {
    var_4 = var_0 scripts\cp_mp\vehicles\vehicle::vehiclecanfly();
    jumpiffalse(var_4) LOC_00000081;

    for(;;) {
      var_5 = var_0 setstrafereverse(0);
      var_6 = var_0 setstrafereverse(2);
      var_7 = var_0 setstrafereverse(1);
      var_8 = var_0 setstrafereverse(3);

      if(abs(var_5) > 0 || abs(var_6) > 0 || abs(var_7) > 0 || abs(var_8) > 0) {
        ref_141d2(var_1);
      }

      wait 0.05;
    }

    return;
  }
}

function ref_141eb(var_0, var_1, var_2, var_3) {
  var_4 = vehicle_occupancy_getleveldataforseat(var_0.vehiclename, var_2);
  var_5 = var_4.ref_13e8a;

  if(istrue(var_3)) {
    var_5 = var_4.ref_13e8b;
  }

  if(var_0 _calloutmarkerping_isvehicleoccupiedbyenemy::unreachable_function() || var_0 _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr()) {
    return;
  }

  if(isDefined(var_5)) {
    var_6 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_0, var_5);

    if(isDefined(var_6)) {
      var_6 scripts\engine\utility::ref_143a5("turret_fire", "turret_reload");
      ref_141d2(var_1);
      return;
    }

    return;
  }
}

function vehicle_occupancy_raceplayerdeathdisconnect(var_0, var_1) {
  var_1 endon(var_1.raceendon);
  var_2 = var_0 scripts\engine\utility::ref_143b5("death", "disconnect", "last_stand_start");

  if(var_2 == "death") {
    var_1.playerdeath = 1;
  } else if(var_2 == "disconnect") {
    var_1.playerdisconnect = 1;
  } else if(var_2 == "last_stand_start") {
    var_1.playerlaststand = 1;
  }

  var_1 notify(var_1.raceendnotify);
}

function vehicle_occupancy_racevehicledeath(var_0, var_1) {
  var_1 endon(var_1.raceendon);
  var_0 waittill("death");
  var_1.vehicledeath = 1;
  var_1 notify(var_1.raceendnotify);
}

function vehicle_occupancy_raceseatunavailable(var_0, var_1, var_2, var_3, var_4) {
  var_4 endon(var_4.raceendon);

  while(isDefined(var_0)) {
    if(!vehicle_occupancy_seatisavailable(var_0, var_2, var_1)) {
      var_4.seatunavailable = 1;
      var_4 notify(var_4.raceendnotify);
      break;
    }

    waitframe();
  }
}

function vehicle_occupancy_racecomplete(var_0, var_1, var_2) {
  var_2 endon(var_2.raceendon);

  if(isDefined(var_0) && isDefined(var_1)) {
    while(!istrue(var_2.enterstartcomplete) || !istrue(var_2.exitstartcomplete)) {
      waitframe();
    }
  } else if(isDefined(var_0)) {
    while(!istrue(var_2.exitstartcomplete)) {
      waitframe();
    }
  } else {
    while(!istrue(var_2.enterstartcomplete)) {
      waitframe();
    }
  }

  var_2 notify(var_2.raceendnotify);
}

function vehicle_occupancy_raceresults(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4.success)) {
    var_4.success = 1;
  }

  if(var_4.immediate) {
    var_4.playerdisconnect = scripts\engine\utility::ter_op(isDefined(var_1), 0, 1);

    if(!var_4.playerdisconnect) {
      var_4.playerdeath = !var_1 scripts\cp_mp\utility\player_utility::_isalive();
      var_4.playerlaststand = istrue(var_1.inlaststand);
    }

    var_4.vehicledeath = istrue(var_0.isdestroyed);
  } else if(var_4.success) {
    if(isDefined(var_2) && !istrue(var_4.exitstartcomplete)) {
      var_4.success = 0;
    }

    if(isDefined(var_3) && !istrue(var_4.enterstartcomplete)) {
      var_4.success = 0;
    }

    if(istrue(var_4.vehicledeath)) {
      var_4.success = 0;
    }
  } else {
    return 0;
  }

  if(isDefined(var_3)) {
    if(istrue(var_4.playerdeath) || istrue(var_4.playerlaststand) || istrue(var_4.playerdisconnect) || istrue(var_4.vehicledeath) || istrue(var_4.seatunavailable)) {
      var_4.success = 0;
    }
  }

  return var_4.success;
}

function vehicle_occupancy_watchowner(var_0, var_1, var_2, var_3) {
  var_1 endon("disconnect");
  var_0 endon("death");
  var_0 endon("vehicle_clear_owner_" + var_1 getentitynumber());

  if(istrue(var_2)) {
    var_1 waittill("vehicle_seat_exit");
  }

  var_4 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, 20);
  wait var_4;
  thread vehicle_occupancy_clearowner(var_0, var_1);
}

function vehicle_occupancy_watchownerjoinedteam(var_0, var_1) {
  var_1 endon("disconnect");
  var_0 endon("death");
  var_0 endon("vehicle_owner_update");
  var_1 scripts\engine\utility::ref_143a5("joined_team", "joined_spectators");
  thread vehicle_occupancy_updateowner(var_0);
}

function vehicle_occupancy_isplayervalidowner(var_0, var_1) {
  if(!isDefined(var_1)) {
    return false;
  }

  if(level.teambased && isDefined(var_0.team)) {
    if(var_0.team != "neutral" && var_1.team != var_0.team) {
      return false;
    }
  } else if(isDefined(var_0.originalowner)) {
    if(var_1 != var_0.originalowner) {
      return false;
    }
  }

  return true;
}

function vehicle_occupancy_animateplayer(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread vehicle_occupancy_stopanimatingplayer();
  self endon("vehicle_occupancy_stopAnimatingPlayer");
  var_6 = vehicle_occupancy_getleveldataforseat(var_0.vehiclename, var_1);

  if(!isDefined(var_6.animtag)) {
    return;
  }

  var_7 = spawn("script_model", var_0 gettagorigin(var_6.animtag));
  var_7.angles = var_0 gettagangles(var_6.animtag);
  var_7 linkTo(var_0, var_6.animtag, (0, 0, 0), (0, 0, 0));
  var_7 setModel("viewhands_base_iw8");
  var_7 hide();
  self.animrig = var_7;

  if(isDefined(var_4) || isDefined(var_5)) {
    allowfultondropondeath(var_4, var_5);
    thread allowleaderboardstatsupdates(1);
  }

  self animscriptentervehicle();

  if(tolower(var_6.animtag) == "tag_seat_0") {
    self vehicle_setstowedweaponvisibility(0);
    self vehicle_setheldweaponvisibility(0);
  } else if(vehicle_shouldhideoccupantforseat(var_0, var_1)) {
    self vehicle_setstowedweaponvisibility(0);
    self vehicle_setheldweaponvisibility(0);
  } else {
    if(istrue(var_6.hidestowedweapon)) {
      self vehicle_setstowedweaponvisibility(0);
    }

    if(istrue(var_6.hideheldweapon)) {
      self vehicle_setheldweaponvisibility(0);
    }
  }

  if(!isDefined(var_6.ref_13e8a)) {
    if(!isDefined(var_2)) {
      self setplayerangles(var_7.angles * (0, 1, 0));
    } else if(tolower(var_6.animtag) == "tag_seat_0") {
      self setplayerangles(var_7.angles * (0, 1, 0));
    }
  }

  self cancelmantle();
  var_8 = undefined;
  var_9 = istrue(var_6.ref_1409c);

  if(istrue(var_8)) {
    self playerlinktodelta(var_7, "tag_player", 0, getdvarfloat("scr_vehicleViewClampOverrideRight", 180), getdvarfloat("scr_vehicleViewClampOverrideLeft", 180), getdvarfloat("scr_vehicleViewClampOverrideTop", 180), getdvarfloat("scr_vehicleViewClampOverrideBottom", 180), var_9, 1, 0);
  } else if(var_6.viewclamps.size > 0) {
    self playerlinktodelta(var_7, "tag_player", 0, var_6.viewclamps["right"], var_6.viewclamps["left"], var_6.viewclamps["top"], var_6.viewclamps["bottom"], var_9, 1, 0);
  } else {
    self playerlinktodelta(var_7, "tag_player", 0, 180, 180, 180, 180, var_9, 1, 0);
  }

  if(istrue(var_6.ref_145e0)) {
    self.animrig.ref_145e0 = 1;
    self setworldupreference(var_0);
  }

  var_10 = vehicle_occupancy_getanimbasename(var_0.vehiclename, var_1);

  if(vehicle_occupancy_checkvalidanimtype(var_10, var_3)) {
    self.animname = var_10;
    var_7.animname = var_10;
    var_7 useanimtree(level.scr_animtree[var_10]);
    vehicle_occupancy_watchplayeranimate(var_0, var_3, var_6.animtag);
  } else {
    scripts\engine\utility::ref_143a5("death_or_disconnect", "last_stand_start");
  }

  if(isDefined(self)) {
    thread vehicle_occupancy_stopanimatingplayer();
  }

  var_7 delete();
}

function vehicle_occupancy_watchplayeranimate(var_0, var_1, var_2) {
  self endon("death_or_disconnect");
  self endon("last_stand_start");

  for(;;) {
    var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("anim", "player_solo")]](self, self.animrig, var_1, var_2);
  }
}

function vehicle_occupancy_stopanimatingplayer() {
  if(!isDefined(self.animrig)) {
    return;
  }

  self notify("vehicle_occupancy_stopAnimatingPlayer");
  self vehicle_setstowedweaponvisibility(1);
  self vehicle_setheldweaponvisibility(1);
  self animscriptexitvehicle();
  self stopanimscriptsceneevent();

  if(istrue(self.animrig.ref_145e0)) {
    self setworldupreference(undefined);
  }

  self.animname = undefined;
  self.animrig delete();
}

function allowfultondropondeath(var_0, var_1) {
  self notify("OverrideVehicleSeatAnimConditionals");
  self overridevehicleseatanimconditionals(var_0, var_1);
}

function allowleaderboardstatsupdates(var_0) {
  self endon("death_or_disconnect");
  self notify("OverrideVehicleSeatAnimConditionals");
  self endon("OverrideVehicleSeatAnimConditionals");

  if(istrue(var_0)) {
    waitframe();
  }

  self overridevehicleseatanimconditionals("", 0);
}

function vehicle_occupancy_checkvalidanimtype(var_0, var_1) {
  if(!isDefined(level.scr_anim[var_0])) {
    return false;
  }

  return isDefined(level.scr_anim[var_0][var_1]);
}

function vehicle_occupancy_getanimbasename(var_0, var_1) {
  return var_0 + "_" + var_1;
}

function vehicle_occupancy_allowmovement(var_0, var_1) {
  if(var_1) {
    var_0.movementdisabled--;

    if(var_0.movementdisabled == 0) {
      if(isDefined(var_0.occupants)) {
        scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("movementDisabled", var_0.occupants, var_0.vehiclename);

        foreach(var_4, var_3 in var_0.occupants) {
          vehicle_occupancy_allowmovementplayer(var_0, var_3, 1, var_4);
        }
      }

      return 1;
    }

    return;
  }

  if(!isDefined(var_0.movementdisabled)) {
    var_0.movementdisabled = 0;
  }

  var_0.movementdisabled++;

  if(var_0.movementdisabled == 1) {
    if(isDefined(var_0.occupants)) {
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("movementDisabled", var_0.occupants, var_0.vehiclename);

      foreach(var_3 in var_0.occupants) {
        vehicle_occupancy_allowmovementplayer(var_0, var_3, 0, var_4);
      }
    }

    return 0;
  }
}

function vehicle_occupancy_clearallowmovement(var_0) {
  if(isDefined(self.occupants)) {
    foreach(var_2 in self.occupants) {
      vehicle_occupancy_allowmovementplayer(1, var_2, var_3);
    }
  }

  var_0.movementdisabled = undefined;
}

function vehicle_occupancy_allowmovementplayer(var_0, var_1, var_2, var_3) {
  if(var_2) {
    if(istrue(var_1.vehicledisabledmovement)) {
      if(var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
        var_1 scripts\common\utility::allow_movement(1);
      }

      var_1.vehicledisabledmovement = undefined;
      return;
    }

    return;
  }

  var_4 = vehicle_occupancy_getleveldataforseat(var_0.vehiclename, var_3);

  if(isDefined(var_4.animtag) && var_4.animtag == "tag_seat_0") {
    if(!istrue(var_1.vehicledisabledmovement)) {
      if(var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
        var_1 scripts\common\utility::allow_movement(0);
        var_1.vehicledisabledmovement = 1;
        return;
      }

      return;
    }

    return;
  }
}

function ref_141ca(var_0, var_1) {
  if(!istrue(var_1) && istrue(var_0.vehicledisabledmovement)) {
    var_0 scripts\common\utility::allow_movement(1);
  }

  var_0.vehicledisabledmovement = undefined;
}

function vehicle_occupancy_movementisallowed(var_0) {
  return !isDefined(var_0.movementdisabled) || var_0.movementdisabled <= 0;
}

function vehicle_occupancy_getexitpositionandangles(var_0, var_1, var_2, var_3, var_4) {
  var_5 = vehicle_occupancy_getexitboundinginfo(var_0);
  var_6 = vehicle_occupancy_getleveldataforseat(var_0.vehiclename, var_2);
  var_7 = [];

  foreach(var_9 in var_6.exitids) {
    var_10 = vehicle_occupancy_getexitposition(var_0, var_1, var_9, var_5, var_3);

    if(isDefined(var_10)) {
      var_7 = var_10;
      var_11 = undefined;

      if(!isDefined(var_6.animtag) || var_6.animtag != "tag_seat_0") {
        var_11 = vehicle_occupancy_getexitangles(var_0, var_1, var_9, var_4);
      }

      if(isDefined(var_0.vehiclename) && (var_0.vehiclename == "veh_a10fd" || var_0.vehiclename == "veh_bt")) {
        var_11 = (0, var_0.angles[1], 0);
      }

      var_7 = var_11;
      return var_7;
    }
  }

  var_9 = undefined;
  var_11 = undefined;
  return undefined;
}

function vehicle_occupancy_getexitposition(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_3.exitsfailed[var_2])) {
    return undefined;
  }

  if(isDefined(var_3.exitpositions[var_2])) {
    return var_3.exitpositions[var_2];
  }

  var_5 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);
  var_6 = var_5.exitoffsets[var_2];
  var_7 = var_5.exitdirections[var_2];

  if(!isDefined(var_6)) {
    var_6 = (0, 0, 0);
  }

  var_8 = ["physicscontents_solid", "physicscontents_item", "physicscontents_sky", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_playerclip"];

  if(getdvarint("scr_vehicleExitWater", 1) == 0) {
    GscBinSkip0(0x2e, var_8.size, "physicscontents_water");
  }

  var_9 = physics_createcontents(var_8);
  var_10 = var_0 getlinkedchildren(1);

  if(!isDefined(var_10)) {
    var_10 = [];
  }

  GscBinSkip0(0x2e, var_10.size, var_0);
}

function vehicle_occupancy_getexitboundinginfo(var_0) {
  var_1 = undefined;

  if(isDefined(var_0.exitboundinginfo) && var_0.exitboundinginfo.timestamp == gettime()) {
    var_1 = var_0.exitboundinginfo;
  } else {
    var_2 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);

    if(isDefined(var_2) && isDefined(var_2.exitextents)) {
      var_3 = rotatevector((var_2.exitextents["front"], var_2.exitextents["left"] * -1, var_2.exitextents["top"]), var_0.angles);
      var_4 = rotatevector((var_2.exitextents["front"], var_2.exitextents["right"], var_2.exitextents["top"]), var_0.angles);
      var_5 = rotatevector((var_2.exitextents["back"] * -1, var_2.exitextents["left"] * -1, var_2.exitextents["top"]), var_0.angles);
      var_6 = rotatevector((var_2.exitextents["back"] * -1, var_2.exitextents["right"], var_2.exitextents["top"]), var_0.angles);
      var_7 = rotatevector((var_2.exitextents["front"], var_2.exitextents["left"] * -1, var_2.exitextents["bottom"] * -1), var_0.angles);
      var_8 = rotatevector((var_2.exitextents["front"], var_2.exitextents["right"], var_2.exitextents["bottom"] * -1), var_0.angles);
      var_9 = rotatevector((var_2.exitextents["back"] * -1, var_2.exitextents["left"] * -1, var_2.exitextents["bottom"] * -1), var_0.angles);
      var_10 = rotatevector((var_2.exitextents["back"] * -1, var_2.exitextents["right"], var_2.exitextents["bottom"] * -1), var_0.angles);
      var_11 = [var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10];
      var_12 = -99999;
      var_13 = 99999;
      var_14 = -99999;
      var_15 = 99999;
      var_16 = -99999;
      var_17 = 99999;
      var_18 = (0, var_0.angles[1], 0);

      foreach(var_20 in var_11) {
        var_20 = rotatevectorinverted(var_20, var_18);

        if(var_20[0] > var_12) {
          var_12 = var_20[0];
        }

        if(var_20[0] < var_13) {
          var_13 = var_20[0];
        }

        if(var_20[1] < var_15) {
          var_15 = var_20[1];
        }

        if(var_20[1] > var_14) {
          var_14 = var_20[1];
        }

        if(var_20[2] > var_16) {
          var_16 = var_20[2];
        }

        if(var_20[2] < var_17) {
          var_17 = var_20[2];
        }
      }

      var_1 = spawnStruct();
      var_0.exitboundinginfo = var_1;
      var_1 = var_1;
      var_1.vehicle = var_0;
      var_1.timestamp = gettime();
      var_1.offsets["front"] = var_12;
      var_1.offsets["back"] = var_13;
      var_1.offsets["left"] = var_14;
      var_1.offsets["right"] = var_15;
      var_1.offsets["top"] = var_16;
      var_1.offsets["bottom"] = var_17;
      var_1.exitsfailed = [];
      var_1.exitpositions = [];
      var_1.orientedboxpoints = [];
      var_1.unorientedboxpoints = [];
      var_1.flipleftright = abs(angleclamp180(var_0.angles[2])) > 90;
      thread vehicle_cleanupexitboundinginfo();
    }
  }

  return var_1;
}

function vehicle_cleanupexitboundinginfo() {
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

function vehicle_occupancy_getexitangles(var_0, var_1, var_2, var_3) {
  if(istrue(level.playerlocationtriggerexit)) {
    var_4 = (0, var_0.angles[1], 0);
    return var_4;
  }

  var_5 = vehicle_occupancy_getleveldataforvehicle(var_1.vehiclename);
  var_6 = vehicle_occupancy_getexitboundinginfo(var_1);
  var_7 = var_6.exitpositions[var_3];
  var_8 = undefined;
  var_9 = 0;

  if(istrue(var_4)) {
    var_8 = var_1.origin + rotatevector(var_5.exitoffsets[var_3], var_1.angles);
    var_9 = 1;
  }

  if(!isDefined(var_8)) {
    var_8 = var_2 getvieworigin() + anglesToForward(var_2 getplayerangles()) * 550;
  }

  var_10 = undefined;

  if(istrue(var_4)) {
    var_10 = var_7 + (0, 0, 22);
  } else {
    var_10 = var_7 + (0, 0, 60);
  }

  var_11 = vectorNormalize(var_8 - var_10);

  if(!var_9) {
    var_12 = physics_createcontents(["physicscontents_vehicle", "physicscontents_item"]);
    var_13 = physics_raycast(var_10, var_10 + var_11 * 300, var_12, undefined, 0, "physicsquery_closest", 1);

    if(isDefined(var_13) && var_13.size > 0) {
      var_14 = var_13[0]["entity"];
      var_15 = 0;

      if(isDefined(var_14)) {
        var_16 = var_1 getlinkedchildren(1);

        if(!isDefined(var_16)) {
          var_16[var_16.size] = var_0;
        }

        var_16[var_16.size] = var_0;

        foreach(var_18 in var_16) {
          if(var_14 == var_18) {
            var_15 = 1;
            break;
          }
        }
      }

      if(var_16) {
        var_20 = var_6.exitdirections[var_4];
        var_4 = (0, var_2.angles[1], 0);

        if(var_20 == "left" || var_20 == "right") {
          var_21 = anglestoright(var_4);
        } else {
          var_21 = anglesToForward(var_21);
        }

        var_13 -= var_21 * vectordot(var_13, var_21);
      }
    }
  }

  var_22 = vectortoangles(var_13);
  var_22 = (clamp(var_22[0], -12, 12), var_22[1], 0);
  return var_22;
}

function vehicle_occupancy_getfallbackexitpositionandangles(var_0, var_1, var_2) {
  var_3 = vectordot((0, 0, 1), anglestoup(var_0.angles)) < 0;
  var_4 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);
  var_5 = undefined;
  var_6 = undefined;

  if(var_3) {
    if(!isDefined(var_4.exitfallbackoffsetinverted)) {
      return undefined;
    }

    var_5 = var_4.exitfallbackoffsetinverted;
    var_6 = anglestoup(var_0.angles) * -1;
  } else {
    if(!isDefined(var_4.exitfallbackoffset)) {
      return undefined;
    }

    var_5 = var_4.exitfallbackoffset;
    var_6 = anglestoup(var_0.angles);
  }

  var_7 = vehicle_occupancy_getexitcastcontents();
  var_8 = vehicle_occupancy_getexitcastignorelist(var_0);
  var_9 = var_0.origin + var_6 * var_5;
  var_10 = physics_getclosestpointtocapsule(var_9, 16, 36, (0, 0, 0), 0, var_7, var_8, "physicsquery_closest");

  if(!isDefined(var_10) || var_10.size <= 0) {
    return [var_9, var_0.angles * (0, 1, 0)];
  }

  return undefined;
}

function vehicle_occupancy_findplayerexit(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0) || isDefined(var_3) || istrue(var_4.playerdeath) && !istrue(var_4.playerlaststand)) {
    return 1;
  }

  var_5 = vehicle_occupancy_getleveldataforvehicle(var_1.vehiclename);
  var_6 = istrue(var_5.allowairexit) || istrue(var_4.allowairexit) || !var_1 scripts\cp_mp\vehicles\vehicle_tracking::_issuspendedvehicle() && !var_1 vehicle_isonground();
  var_7 = vehicle_occupancy_getexitpositionandangles(var_1, var_0, var_2, var_6, var_4.playerlaststand);

  if(isDefined(var_7)) {
    var_4.exitposition = var_7[0];
    var_4.exitangles = var_7[1];
    return 1;
  }

  if(istrue(var_5.onprematchstarted2)) {
    var_8 = var_1 physics_getentitycenterofmass();
    var_9 = var_0 getboundsmidpoint();
    var_4.exitposition = var_8["unscaled"] - var_9;
    var_4.exitangles = undefined;
    return 1;
  }

  return 0;
}

function vehicle_occupancy_moveplayertoexit(var_0, var_1, var_2) {
  if(!isDefined(var_0) || istrue(var_2.playerdeath) && !istrue(var_2.playerlaststand) || isDefined(var_1)) {
    return 1;
  }

  if(isDefined(var_2.exitposition)) {
    var_0 unlink();
    var_0 dontinterpolate();
    var_0 setOrigin(var_2.exitposition, 1, 1);
    var_0 setstance("stand");

    if(isDefined(var_2.exitangles)) {
      var_0 setplayerangles(var_2.exitangles);
    }

    return 1;
  }

  return 0;
}

function vehicle_occupancy_getexitcastcontents() {
  return physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle", "physicscontents_playerclip"]);
}

function vehicle_occupancy_getexitcastignorelist(var_0) {
  var_1 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);
  var_2 = [var_0];

  if(isDefined(var_1.exitignorelistcallback)) {
    var_2 = [[var_1.exitignorelistcallback]](var_0);
  }

  return var_2;
}

function vehicle_occupancy_animtagtoexittag(var_0) {
  var_0 = tolower(var_0);
  var_1 = getsubstr(var_0, 8, var_0.size);
  return "tag_seat_exit" + var_1;
}

function vehicle_occupancy_watchmovefeedback(var_0) {
  self endon("death");

  for(;;) {
    vehicle_occupancy_updatemovefeedback(var_0);
    waitframe();
  }
}

function vehicle_occupancy_updatemovefeedback(var_0) {
  var_1 = vehicle_occupancy_getseatoccupant(self, var_0);
  var_2 = vehicle_occupancy_getalloccupants(self);

  if(isDefined(var_1)) {
    var_3 = var_1 getnormalizedmovement()[0];
    jumpiffalse(abs(var_3) > 0.15) LOC_00000062;

    foreach(var_5 in var_2) {
      if(var_5 scripts\cp_mp\utility\player_utility::_isalive()) {
        vehicle_occupancy_startmovefeedbackforplayer(var_5);
      }
    }

    return;
  }

  if(isDefined(var_5)) {
    foreach(var_5 in var_5) {
      if(var_5 scripts\cp_mp\utility\player_utility::_isalive()) {
        vehicle_occupancy_stopmovefeedbackforplayer(var_5);
      }
    }

    return;
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

function vehicle_occupancy_updatedamagefeedback(var_0) {
  var_1 = vehicle_occupancy_getleveldataforvehicle(self.vehiclename);

  if(!isDefined(var_1)) {
    return;
  }

  if(!isDefined(var_0.damage) || var_0.damage <= 0) {
    return;
  }

  if(!isDefined(var_0.meansofdeath)) {
    return;
  }

  var_2 = undefined;
  var_3 = undefined;

  switch (var_0.meansofdeath) {
    case "MOD_EXPLOSIVE_BULLET":
    case "MOD_GRENADE_SPLASH":
    case "MOD_GRENADE":
    case "MOD_PROJECTILE":
    case "MOD_PISTOL_BULLET":
    case "MOD_RIFLE_BULLET":
      var_2 = "light";
      var_3 = var_1.damagefeedbackgrouplight;
      break;
    case "MOD_EXPLOSIVE":
    case "MOD_PROJECTILE_SPLASH":
    case "MOD_IMPACT":
      var_2 = "heavy";
      var_3 = var_1.damagefeedbackgroupheavy;
      break;
  }

  if(!isDefined(var_2)) {
    return;
  }

  if(!isDefined(var_3) || var_3 == "none") {
    return;
  }

  var_4 = [];

  if(var_3 == "driver") {
    foreach(var_6 in var_1.seatdata) {
      if(!isDefined(var_6.animtag)) {
        continue;
      }

      if(var_6.animtag == "tag_seat_0") {
        var_4 = [vehicle_occupancy_getseatoccupant(self, var_7)];
        break;
      }
    }
  } else if(var_3 == "all") {
    var_4 = vehicle_occupancy_getalloccupants(self);
  }

  if(!isDefined(var_4) || var_4.size == 0) {
    return;
  }

  foreach(var_9 in var_4) {
    if(!isDefined(var_9)) {
      continue;
    }

    if(!var_9 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(var_2 == "light") {
      thread vehicle_occupancy_lightdamagefeedbackforplayer();
      continue;
    }

    if(var_2 == "heavy") {
      thread vehicle_occupancy_heavydamagefeedbackforplayer();
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
  self.vehiclelightdamagefeedbackid = 1 + scripts\engine\utility::mod(self.vehiclelightdamagefeedbackid + 1, 3);
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
  self.vehicleheavydamagefeedbackid = 1 + scripts\engine\utility::mod(self.vehicleheavydamagefeedbackid + 1, 3);
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

function vehicle_occupancy_giveturret(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2.raceendon)) {
    var_2 endon(var_2.raceendon);
  }

  if(istrue(var_3)) {
    GscBinSkip4(0x35, var_2, 1.5);
  }

  if(!var_0 hasweapon(var_1)) {
    var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1);
  }

  var_4 = undefined;

  if(var_0 scripts\cp_mp\utility\inventory_utility::iscurrentweapon(var_1)) {
    var_4 = 1;
  } else {
    thread ref_141d3(var_0, var_2);
    var_4 = var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_1, 1, 1);
  }

  ref_141cb(var_0);

  if(isDefined(var_2) && isDefined(var_4) && !var_4) {
    var_2.success = 0;
    var_2 notify(var_2.raceendnotify);
    return;
  }
}

function vehicle_occupancy_taketurret(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_3.raceendon)) {
    var_3 endon(var_3.raceendon);
  }

  if(istrue(var_4)) {
    GscBinSkip4(0x35, var_3, 1.5);
  }

  if(var_0 hasweapon(var_2)) {
    var_6 = undefined;
    thread ref_141cb(var_0);

    if(var_0 scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var_2)) {
      var_0 scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(getcompleteweaponname(var_2));
      var_6 = 1;
    } else {
      if(isDefined(var_5)) {
        var_7 = scripts\cp_mp\vehicles\vehicle::ref_14191(var_1, var_5);
      } else {
        var_7 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_2, var_3);
      }

      if(isDefined(var_7)) {
        var_1 controlturretoff(var_7);
      }

      if(var_1 hasweapon(var_3)) {
        var_8 = var_1 scripts\cp_mp\utility\inventory_utility::iscurrentweapon(var_3);

        if(var_8) {
          var_1 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_3);
          var_1 thread scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
        } else {
          var_1 thread scripts\cp_mp\utility\inventory_utility::getridofweapon(var_3, 1);
        }
      }

      var_7 = 1;
    }

    if(isDefined(var_7) && !var_7) {
      var_4.success = 0;
      var_4 notify(var_4.raceendnotify);
      return;
    }

    return;
  }
}

function vehicle_occupancy_givetaketurrettimeout(var_0, var_1) {
  wait var_1;
  var_0.success = 0;
  var_0 notify(var_0.raceendnotify);
}

function ref_141d3(var_0, var_1) {
  var_0 endon("death_or_disconnect");
  var_0 notify("vehicle_occupancy_forceWeaponSwitchAllowed");
  var_0 endon("vehicle_occupancy_forceWeaponSwitchAllowed");

  if(var_0 scripts\common\utility::is_weapon_switch_allowed()) {
    return;
  }

  var_0 enableweaponswitch();
  var_1 waittill(var_1.raceendon);
  thread ref_141cb(var_0);
}

function ref_141cb(var_0) {
  var_0 notify("vehicle_occupancy_forceWeaponSwitchAllowed");

  if(var_0 scripts\common\utility::is_weapon_switch_allowed()) {
    var_0 enableweaponswitch();
    return;
  }

  var_0 disableweaponswitch();
}

function vehicle_occupancy_ejectalloccupants(var_0) {
  var_1 = vehicle_occupancy_getallvehicleseats(var_0);

  foreach(var_3 in var_1) {
    var_4 = vehicle_occupancy_getseatoccupant(var_0, var_3);

    if(isDefined(var_4)) {
      var_5 = spawnStruct();
      var_5.allowairexit = 1;
      var_5.onprematchfadedone2 = "INVOLUNTARY";
      thread vehicle_occupancy_exit(var_0, var_3, var_4, var_5, 1);
    }
  }
}

function vehicle_occupancy_getoccupantrestrictions() {
  return ["crouch", "prone", "sprint", "mantle", "mount_top", "mount_side", "vehicle_use", "crate_use", "ladder_placement", "execution_attack", "execution_victim"];
}

function ref_141d8() {
  return ["usability_auto_use", "offhand_weapons", "melee", "reload", "autoreload", "weapon_switch", "cough_gesture"];
}

function vehicle_occupancy_getdriverrestrictions() {
  return ["usability_auto_use", "offhand_weapons", "melee", "fire", "reload", "autoreload", "weapon_switch", "cough_gesture"];
}

function vehicle_occupancy_getcombatpassengerrestrictions() {
  return ["weapon_pickup"];
}

function vehicle_occupancy_getcombatcabpassengerrestrictions() {
  var_0 = vehicle_occupancy_getcombatpassengerrestrictions();
  return var_0;
}

function vehicle_occupancy_getpassivepassengerrestrictions() {
  return vehicle_occupancy_getdriverrestrictions();
}

function vehicle_occupancy_getturretpassengerrestrictions() {
  var_0 = vehicle_occupancy_getcombatpassengerrestrictions();
  GscBinSkip0(0x2e, var_0.size, "cough_gesture");
}

function vehicle_occupancy_disablefirefortime(var_0, var_1, var_2) {
  var_0 endon("disconnect");
  var_0 notify("vehicle_occupancy_disableFireForTime");
  var_0 endon("vehicle_occupancy_disableFireForTime");

  if(!istrue(self.vehicledisablefire)) {
    var_0.vehicledisablefire = 1;
    var_0 scripts\common\utility::allow_fire(0, "vehicleDisableFire");
  }

  if(!isDefined(var_0.vehicledisablefireendtime) || !istrue(var_2)) {
    var_0.vehicledisablefireendtime = gettime() + var_1;
  }

  while(isDefined(var_0.vehicledisablefireendtime) && gettime() < var_0.vehicledisablefireendtime) {
    wait 0.05;
  }

  thread vehicle_occupancy_cleardisablefirefortime(var_0);
}

function vehicle_occupancy_cleardisablefirefortime(var_0, var_1) {
  var_0 notify("vehicle_occupancy_disableFireForTime");

  if(isDefined(var_0.vehicledisablefire)) {
    if(!istrue(var_1)) {
      var_0 scripts\common\utility::allow_fire(1, "vehicleDisableFire");
    }
  }

  var_0.vehicledisablefire = undefined;
  var_0.vehicledisablefireendtime = undefined;
}

function ref_141f8(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "takeRiotShield")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "takeRiotShield")]](var_0, var_1, var_2);
    return;
  }
}

function ref_141d9(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "giveRiotShield")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "giveRiotShield")]](var_0, var_1, var_2);
    return;
  }
}

function ref_141f9(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "updateRiotShield")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "updateRiotShield")]](var_0, var_1, var_2);
    return;
  }
}

function ref_141db(var_0, var_1, var_2, var_3) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "hideCashBag")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "hideCashBag")]](var_0, var_1, var_2, var_3);
    return;
  }
}

function ref_141f5(var_0, var_1, var_2, var_3) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "showCashBag")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "showCashBag")]](var_0, var_1, var_2, var_3);
    return;
  }
}

function vehicle_occupancy_registersentient(var_0) {
  if(isDefined(var_0.sentientdisabled) && var_0.sentientdisabled > 0) {
    return;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "registerSentient")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "registerSentient")]](var_0);
    return;
  }
}

function vehicle_occupancy_unregistersentient(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "unregisterSentient")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "unregisterSentient")]](var_0);
    return;
  }
}

function vehicle_occupancy_issentient(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "isSentient")) {
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "isSentient")]](var_0);
  }
}

function vehicle_occupancy_allowsentient(var_0) {
  if(var_0) {
    self.sentientdisabled--;

    if(self.sentientdisabled == 0) {
      vehicle_occupancy_registersentient(self);
      return;
    }

    return;
  }

  if(!isDefined(self.sentientdisabled)) {
    self.sentientdisabled = 0;
  }

  self.sentientdisabled++;

  if(self.sentientdisabled == 1) {
    vehicle_occupancy_unregistersentient(self);
    return;
  }
}

function ref_141e7(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.seatid = var_1;
  var_3 = vehicle_occupancy_getleveldataforseat(var_0.vehiclename, var_1);

  if(isDefined(var_3.animtag)) {
    var_2.origin = var_0 gettagorigin(var_3.animtag);
    var_2.angles = var_0 gettagangles(var_3.animtag);
  } else {
    var_2.origin = var_0.origin;
    var_2.angles = var_0.angles;
  }

  return var_2;
}

function vehicle_occupancy_linkseatcorpse(var_0, var_1, var_2) {
  var_3 = vehicle_occupancy_getleveldataforseat(var_1.vehiclename, var_2);

  if(isDefined(var_3.animtag)) {
    var_0 enablelinkTo();
    var_0 linkTo(var_1, var_3.animtag);
    return;
  }

  var_0 enablelinkTo();
  var_0 linkTo(var_1);
}

function vehicle_occupancy_assignseatcorpse(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1.corpses)) {
    var_1.corpses = [];
  }

  vehicle_occupancy_deleteseatcorpse(var_1, var_2, 0);
  var_1.corpses[var_2] = var_0;

  if(!var_3) {
    var_0.matchdata_logmultikill = 1;
    return;
  }
}

function ref_141cc(var_0, var_1, var_2) {
  if(isDefined(var_1.corpses) && isDefined(var_1.corpses[var_2])) {
    var_1.corpses[var_2] = undefined;
  }

  var_0.matchdata_logmultikill = undefined;
}

function vehicle_occupancy_deleteseatcorpse(var_0, var_1, var_2) {
  if(isDefined(var_0.corpses) && isDefined(var_0.corpses[var_1])) {
    var_3 = var_0.corpses[var_1];

    if(isDefined(var_3)) {
      if(!istrue(var_3.matchdata_logmultikill) || !var_2) {
        var_0.corpses[var_1] delete();
        var_0.corpses[var_1] = undefined;
        return;
      }

      return;
    }

    return;
  }
}

function vehicle_occupancy_deleteseatcorpses(var_0) {
  if(isDefined(var_0.corpses)) {
    foreach(var_2 in var_0.corpses) {
      if(isDefined(var_2)) {
        var_2 delete();
      }
    }
  }

  var_0.corpses = undefined;
}

function ref_141c6(var_0, var_1) {
  if(istrue(var_0.isdestroyed) || !isDefined(var_0.occupants)) {
    var_0.ref_1287d = undefined;
    return;
  }

  if(var_1) {
    var_0.ref_1287d--;
    return;
  }

  if(!isDefined(var_0.ref_1287d)) {
    var_0.ref_1287d = 0;
  }

  var_0.ref_1287d++;
}

function ref_141c7(var_0) {
  if(istrue(var_0.isdestroyed) || !isDefined(var_0.occupants)) {
    return false;
  }

  if(isDefined(var_0.ref_1287d) && var_0.ref_1287d > 0) {
    return false;
  }

  return true;
}

function vehicle_occupancy_generateseatswitcharray(var_0, var_1) {
  var_2 = [];
  var_3 = 0;

  for(var_4 = 0;; var_4++) {
    if(!var_3) {
      if(var_0 == var_1[var_4]) {
        var_3 = 1;
      }

      continue;
    }

    var_4 = scripts\engine\utility::mod(var_4, var_1.size);

    if(var_0 == var_1[var_4]) {
      break;
    }

    var_2 = var_1[var_4];
  }

  return var_2;
}

function vehicle_occupancy_killoccupants(var_0, var_1) {
  if(!isDefined(var_1.inflictor)) {
    switch (var_1.meansofdeath) {
      case "MOD_GRENADE_SPLASH":
      case "MOD_GRENADE":
      case "MOD_PROJECTILE_SPLASH":
      case "MOD_PROJECTILE":
        if(isDefined(var_0.killcament)) {
          var_0.killcament delete();
        }

        var_0.killcament = var_1.inflictor;
        var_1.inflictor = var_0;
        break;
    }
  }

  if(!isDefined(var_1.inflictor)) {
    var_1.inflictor = undefined;
  }

  var_2 = var_1.meansofdeath;

  if(var_2 == "MOD_PROJECTILE") {
    var_2 = "MOD_PROJECTILE_SPLASH";
  } else if(var_2 == "MOD_GRENADE") {
    var_2 = "MOD_GRENADE_SPLASH";
  }

  var_3 = vehicle_occupancy_getallvehicleseats(self);

  foreach(var_5 in var_3) {
    var_6 = vehicle_occupancy_getseatoccupant(self, var_5);

    if(isDefined(var_6) && var_6 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_7 = var_1.attacker;

      if(scripts\common\utility::iscp()) {
        var_6.shouldskipdeathsshield = 1;

        if(!isDefined(var_7)) {
          if(isDefined(var_1.inflictor)) {
            var_7 = var_1.inflictor;
          }
        }

        if(!isDefined(var_7)) {
          var_7 = var_6;
        }

        if(isDefined(var_7) && isDefined(var_7.team)) {
          if(var_7.team == var_6.team) {
            vehicle_occupancy_exit(self, var_5, var_6, undefined, 1);
            var_6.skipvehiclespashdamage = 1;
            continue;
          }
        }
      } else if(!isDefined(var_7) || !istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_7, var_6))) {
        var_7 = var_6;
      }

      var_6.donotmodifydamage = 1;
      var_8 = 0;

      if(level.gametype == "br" && istrue(var_6.isjuggernaut)) {
        if(isDefined(var_6.juggcontext.juggconfig.ref_14232) && var_6.health > var_6.juggcontext.juggconfig.ref_14232) {
          var_8 = 1;
        }
      }

      if(!istrue(var_8)) {
        var_9 = scripts\engine\utility::ter_op(isent(var_7), var_7, undefined);
        var_6 dodamage(var_6.maxhealth, var_0.origin, var_9, var_1.inflictor, var_2, var_1.objweapon, "torso_upper");

        if(isDefined(level.ref_14254)) {
          var_6 thread[[level.ref_14254]]();
        }
      }

      var_6.donotmodifydamage = undefined;
      thread vehicle_occupancy_exit(var_0, var_5, var_6, undefined, 1);
    }
  }

  vehicle_occupancy_deleteseatcorpses(var_0);
}

function vehicle_occupancy_initdebug() {
  var_0 = vehicle_occupancy_getleveldata();
  var_0.debuginstances = [];
}