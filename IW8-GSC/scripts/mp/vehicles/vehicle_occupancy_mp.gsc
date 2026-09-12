/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\vehicle_occupancy_mp.gsc
********************************************************/

function vehicle_occupancy_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "onEnterVehicle", &vehicle_occupancy_mp_onentervehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "onExitVehicle", &vehicle_occupancy_mp_onexitvehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "registerInstance", &vehicle_occupancy_mp_registerinstance);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "deregisterInstance", &vehicle_occupancy_mp_deregisterinstance);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "updateOwner", &vehicle_occupancy_mp_updateowner);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "registerSentient", &vehicle_occupancy_mp_registersentient);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "unregisterSentient", &vehicle_occupancy_mp_unregistersentient);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "isSentient", &vehicle_occupancy_mp_issentient);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "takeRiotShield", &ref_141F0);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "giveRiotShield", &ref_141ED);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "updateRiotShield", &ref_141F2);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "hideCashBag", &ref_141EE);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "showCashBag", &ref_141EF);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "changedSeats", &ref_141EC);
  scripts\mp\playeractions::registeractionset("vehicle", ["gesture", "killstreaks", "supers", "cp_munitions"]);
  scripts\mp\playeractions::registeractionset("vehicle_passenger", ["gesture", "supers", "cp_munitions"]);
  level.vehicle.ref_1424E = getdvarint("scr_vehicle_lights", 1);
}

function vehicle_occupancy_mp_onentervehicle(var_0, var_1, var_2, var_3) {
  var_2 scripts\mp\utility\perk::giveperk("specialty_ghost");
  var_2 scripts\mp\utility\perk::giveperk("specialty_tracker_jammer");
  var_4 = level.gametype == "br";

  if(!var_4 || scripts\cp_mp\vehicles\vehicle_occupancy::ref_141DF(var_0, var_1)) {
    var_2 scripts\mp\playeractions::allowactionset("vehicle", 0);
  } else if(var_4) {
    var_2 scripts\mp\playeractions::allowactionset("vehicle_passenger", 0);
  }

  if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war") {
    scripts\mp\gametypes\br_plunder::ref_12781(var_2, 0, 1);
  }

  ref_141F0(var_2);
  scripts\mp\outofbounds::enableoobimmunity(var_2);

  if(scripts\mp\outofbounds::isoob(var_0, 1)) {
    var_0 thread scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_entercallbackforplayer(var_2);
  }

  if(isDefined(var_2.team) && isDefined(var_2.squadindex) && istrue(var_0.israllypointvehicle)) {
    thread scripts\mp\spawnselection::ref_12ACB(var_2.team, var_2.squadindex);
  }

  if(isDefined(level.playerconnectwatcher) && var_2[[level.playerconnectwatcher]]()) {
    if(isDefined(level.playerexecutionsenable)) {
      var_2[[level.playerexecutionsenable]]();
    }
  }

  vehicle_occupancy_mp_updatemarkfilter(var_0);
  ref_141F1(var_0);
  ref_141F3(var_0);
}

function vehicle_occupancy_mp_onexitvehicle(var_0, var_1, var_2, var_3) {
  if(!istrue(var_3.playerdisconnect) && isDefined(var_2)) {
    if(!istrue(var_3.playerdeath)) {
      var_2 scripts\mp\utility\perk::removeperk("specialty_ghost");
      var_2 scripts\mp\utility\perk::removeperk("specialty_tracker_jammer");
      var_4 = level.gametype == "br";

      if(!var_4 || scripts\cp_mp\vehicles\vehicle_occupancy::ref_141DF(var_0, var_1)) {
        var_2 scripts\mp\playeractions::allowactionset("vehicle", 1);
      } else if(var_4) {
        var_2 scripts\mp\playeractions::allowactionset("vehicle_passenger", 1);
      }

      if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war") {
        scripts\mp\gametypes\br_plunder::ref_12781(var_2, 1, 1);
      }

      if(scripts\mp\outofbounds::isoob(var_0, 1)) {
        var_0 thread scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_exitcallbackforplayer(var_2);
      }

      scripts\mp\outofbounds::disableoobimmunity(var_2);
    }

    ref_141ED(var_2, var_3.playerdeath, var_3.playerlaststand);

    if(isDefined(var_2.team) && isDefined(var_2.squadindex) && istrue(var_0.israllypointvehicle)) {
      thread scripts\mp\spawnselection::ref_12ACB(var_3.team, var_3.squadindex);
    }

    if(isDefined(level.playerconnectwatcher) && var_2[[level.playerconnectwatcher]]()) {
      if(isDefined(level.playerexitcombatarea)) {
        var_2[[level.playerexitcombatarea]]();
      }
    }

    var_2 notify("vehicle_exit");
  }

  vehicle_occupancy_mp_updatemarkfilter(var_0);
  ref_141F1(var_0);
  ref_141F3(var_0);
}

function ref_141EC(var_0, var_1, var_2, var_3) {
  var_4 = level.gametype == "br";

  if(var_4 && isDefined(var_2) && isDefined(var_3)) {
    if(scripts\cp_mp\vehicles\vehicle_occupancy::ref_141DF(var_1, var_2)) {
      var_0 scripts\mp\playeractions::allowactionset("vehicle", 1);
      var_0 scripts\mp\playeractions::allowactionset("vehicle_passenger", 0);
      return;
    }

    if(scripts\cp_mp\vehicles\vehicle_occupancy::ref_141DF(var_1, var_3)) {
      var_0 scripts\mp\playeractions::allowactionset("vehicle_passenger", 1);
      var_0 scripts\mp\playeractions::allowactionset("vehicle", 0);
      return;
    }

    return;
  }
}

function vehicle_occupancy_mp_updatemarkfilter(var_0) {
  if(!isDefined(var_0.occupants)) {
    return;
  }

  if(!isDefined(var_0.ref_11B19)) {
    var_0.ref_11B19 = 1;
  }

  var_1 = var_0.ref_11B19;
  var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0);
  var_0.ref_11B19 = var_2.size > 0;

  if(var_1 && !var_0.ref_11B19) {
    var_0 disableplayermarks("killstreak");
  } else if(!var_1 && var_0.ref_11B19) {
    var_0 enableplayermarks("killstreak");
  }

  if(var_0.ref_11B19) {
    if(level.teambased) {
      var_3 = [];

      foreach(var_5 in var_2) {
        if(!scripts\engine\utility::array_contains(var_3, var_5.team)) {
          var_3 = var_5.team;
        }
      }

      var_0 filteroutplayermarks(var_3);
      return;
    }

    var_0 filteroutplayermarks(var_2);
    return;
  }
}

function vehicle_occupancy_mp_registerinstance(var_0) {}

function vehicle_occupancy_mp_deregisterinstance(var_0) {}

function ref_141EE(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(var_0.vehiclename, var_1);

  if(istrue(var_4.ref_13345)) {
    return;
  }

  if(isDefined(level.ref_11A32) && scripts\engine\utility::array_contains(level.ref_11A32, var_2)) {
    if(isDefined(var_2.carriable_set_dropped)) {
      killfxontag(level._effect["vfx_br_cashLeaderBag"], var_2, "j_bag_left");
      var_5 = "accessory_money_bag_large_closed_player";

      if(scripts\mp\gametypes\br_public::shouldusegoldbarassets()) {
        var_5 = "accessory_gold_bar_bag_player";
      }

      var_2 hidepart("j_bag_left", var_5);
      return;
    }

    return;
  }
}

function ref_141EF(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(var_0.vehiclename, var_1);

  if(istrue(var_4.ref_13345)) {
    return;
  }

  if(isDefined(level.ref_11A32) && scripts\engine\utility::array_contains(level.ref_11A32, var_2)) {
    if(isDefined(var_2.carriable_set_dropped)) {
      var_5 = "accessory_money_bag_large_closed_player";

      if(scripts\mp\gametypes\br_public::shouldusegoldbarassets()) {
        var_5 = "accessory_gold_bar_bag_player";
      }

      var_2 showpart("j_bag_left", var_5);
      playFXOnTag(level._effect["vfx_br_cashLeaderBag"], var_2, "j_bag_left");
      return;
    }

    return;
  }
}

function vehicle_occupancy_mp_updateowner(var_0) {
  vehicle_occupancy_mp_updatemarkfilter(var_0);
}

function ref_141F0(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = var_0 getweaponslistprimaries();

  foreach(var_8 in var_6) {
    if(nullweapon(var_8)) {
      continue;
    }

    if(scripts\mp\riotshield::isriotshield(var_8)) {
      var_3 = var_8;

      if(isnullweapon(var_3, var_0 getcurrentprimaryweapon())) {
        var_4 = 1;
      }

      continue;
    }

    if(!isDefined(var_5)) {
      var_9 = var_8 getnoaltweapon();

      if(var_9.inventorytype != "primary") {
        continue;
      }

      var_5 = var_8;
    }
  }

  if(isDefined(var_3)) {
    var_0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_3);
    var_0.ref_12D53 = var_3;
    var_0.ref_12D4F = var_4;

    if(istrue(var_4)) {
      ref_141F2(var_0, var_1, var_2);
    }

    var_0 scripts\mp\class::riotshieldonweaponchange(var_5);
    var_0 notify("modified_riot_shield");
    var_0 endon("modified_riot_shield");
    var_0 childthread scripts\cp_mp\utility\inventory_utility::forcevalidweapon(var_5);
    return;
  }
}

function ref_141ED(var_0, var_1, var_2) {
  if(isDefined(var_0.ref_12D53)) {
    var_3 = level.gametype == "br";

    if(!istrue(var_1) && (var_3 || !istrue(var_2))) {
      var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0.ref_12D53);
      var_0 scripts\mp\class::ref_13C5C();

      if(istrue(var_0.ref_12D4F)) {
        var_0 notify("modified_riot_shield");
        var_0 endon("modified_riot_shield");

        if(!istrue(var_2)) {
          var_0 childthread scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_0.ref_12D53);
        }
      }
    }

    var_0.ref_12D53 = undefined;
    var_0.ref_12D4F = undefined;
    var_0 notify("modified_riot_shield");
    return;
  }
}

function ref_141F2(var_0, var_1, var_2) {
  if(isDefined(var_0.ref_12D53) && istrue(var_0.ref_12D4F)) {
    if(!isDefined(var_2)) {
      return;
    }

    if(scripts\cp_mp\vehicles\vehicle_occupancy::ref_141DF(var_1, var_2)) {
      return;
    }

    if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_shouldhideoccupantforseat(var_1, var_2)) {
      return;
    }

    var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(var_1.vehiclename, var_2);

    if(isDefined(var_3.ref_13E8A)) {
      return;
    }

    var_0.ref_12D4F = undefined;
    return;
  }
}

function ref_141F3(var_0) {
  if(!var_0 getscriptablehaspart("stability")) {
    return;
  }

  var_1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0);
  var_2 = var_0 vehicle_getspeed();

  if(var_1.size > 0) {
    var_0 setscriptablepartstate("stability", "stable", 1);
    return;
  }

  if(var_1.size == 0 && var_2 > 10) {
    var_0 setscriptablepartstate("stability", "unstable", 1);
    return;
  }
}

function ref_141F1(var_0) {
  if(!level.vehicle.ref_1424E) {
    return;
  }

  if(!ref_141E6()) {
    return;
  }

  if(!var_0 getscriptablehaspart("lights")) {
    return;
  }

  if(!isDefined(var_0.showmapchyron)) {
    var_0.showmapchyron = 0;
  }

  var_1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0);

  if(var_1.size > 0 && !var_0.showmapchyron) {
    var_0 setscriptablepartstate("lights", "on", 1);
    var_0.showmapchyron = 1;
    return;
  }

  if(var_1.size == 0 && var_0.showmapchyron) {
    var_0 setscriptablepartstate("lights", "off", 1);
    var_0.showmapchyron = 0;
    return;
  }
}

function ref_141E6() {
  switch (level.script) {
    case "mp_kstenod":
    case "mp_br_mechanics":
    case "mp_escape2_pm":
      return true;
    default:
      break;
  }

  return false;
}

function vehicle_occupancy_mp_registersentient(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);

  if(!isDefined(var_1.threatbiasgroup)) {
    return;
  }

  if(level.teambased) {
    var_2 = var_0.team;

    if(isDefined(var_0.team) && var_0.team == "neutral") {
      var_2 = undefined;
    }

    if(!isDefined(var_2) && isDefined(var_0.owner)) {
      var_2 = var_0.owner.team;
    }

    if(isDefined(var_2)) {
      if(!isDefined(var_0.sentientteam) || var_0.sentientteam != var_2) {
        vehicle_occupancy_mp_unregistersentient(var_0);
        var_0 scripts\mp\sentientpoolmanager::registersentient(var_1.threatbiasgroup, var_2);
        var_0.sentientteam = var_2;
        return;
      }

      return;
    }

    if(isDefined(var_0.sentientteam)) {
      vehicle_occupancy_mp_unregistersentient(var_0);
      return;
    }

    return;
  }
}

function vehicle_occupancy_mp_unregistersentient(var_0) {
  var_0 notify("remove_sentient");
  var_0.sentientteam = undefined;
}

function vehicle_occupancy_mp_issentient(var_0) {
  return isDefined(var_0.sentientteam);
}