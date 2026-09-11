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
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "takeRiotShield", &ref_141f0);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "giveRiotShield", &ref_141ed);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "updateRiotShield", &ref_141f2);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "hideCashBag", &ref_141ee);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "showCashBag", &ref_141ef);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "changedSeats", &ref_141ec);
  scripts\mp\playeractions::registeractionset("vehicle", ["gesture", "killstreaks", "supers", "cp_munitions"]);
  scripts\mp\playeractions::registeractionset("vehicle_passenger", ["gesture", "supers", "cp_munitions"]);
  level.vehicle.ref_1424e = getdvarint("scr_vehicle_lights", 1);
}

function vehicle_occupancy_mp_onentervehicle(var0, var1, var2, var3) {
  var2 scripts\mp\utility\perk::giveperk("specialty_ghost");
  var2 scripts\mp\utility\perk::giveperk("specialty_tracker_jammer");
  var4 = level.gametype == "br";

  if(!var4 || scripts\cp_mp\vehicles\vehicle_occupancy::ref_141df(var0, var1)) {
    var2 scripts\mp\playeractions::allowactionset("vehicle", 0);
  } else if(var4) {
    var2 scripts\mp\playeractions::allowactionset("vehicle_passenger", 0);
  }

  if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war") {
    scripts\mp\gametypes\br_plunder::ref_12781(var2, 0, 1);
  }

  ref_141f0(var2);
  scripts\mp\outofbounds::enableoobimmunity(var2);

  if(scripts\mp\outofbounds::isoob(var0, 1)) {
    var0 thread scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_entercallbackforplayer(var2);
  }

  if(isDefined(var2.team) && isDefined(var2.squadindex) && istrue(var0.israllypointvehicle)) {
    thread scripts\mp\spawnselection::ref_12acb(var2.team, var2.squadindex);
  }

  if(isDefined(level.playerconnectwatcher) && var2[[level.playerconnectwatcher]]()) {
    if(isDefined(level.playerexecutionsenable)) {
      var2[[level.playerexecutionsenable]]();
    }
  }

  vehicle_occupancy_mp_updatemarkfilter(var0);
  ref_141f1(var0);
  ref_141f3(var0);
}

function vehicle_occupancy_mp_onexitvehicle(var0, var1, var2, var3) {
  if(!istrue(var3.playerdisconnect) && isDefined(var2)) {
    if(!istrue(var3.playerdeath)) {
      var2 scripts\mp\utility\perk::removeperk("specialty_ghost");
      var2 scripts\mp\utility\perk::removeperk("specialty_tracker_jammer");
      var4 = level.gametype == "br";

      if(!var4 || scripts\cp_mp\vehicles\vehicle_occupancy::ref_141df(var0, var1)) {
        var2 scripts\mp\playeractions::allowactionset("vehicle", 1);
      } else if(var4) {
        var2 scripts\mp\playeractions::allowactionset("vehicle_passenger", 1);
      }

      if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war") {
        scripts\mp\gametypes\br_plunder::ref_12781(var2, 1, 1);
      }

      if(scripts\mp\outofbounds::isoob(var0, 1)) {
        var0 thread scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_exitcallbackforplayer(var2);
      }

      scripts\mp\outofbounds::disableoobimmunity(var2);
    }

    ref_141ed(var2, var3.playerdeath, var3.playerlaststand);

    if(isDefined(var2.team) && isDefined(var2.squadindex) && istrue(var0.israllypointvehicle)) {
      thread scripts\mp\spawnselection::ref_12acb(var3.team, var3.squadindex);
    }

    if(isDefined(level.playerconnectwatcher) && var2[[level.playerconnectwatcher]]()) {
      if(isDefined(level.playerexitcombatarea)) {
        var2[[level.playerexitcombatarea]]();
      }
    }

    var2 notify("vehicle_exit");
  }

  vehicle_occupancy_mp_updatemarkfilter(var0);
  ref_141f1(var0);
  ref_141f3(var0);
}

function ref_141ec(var0, var1, var2, var3) {
  var4 = level.gametype == "br";

  if(var4 && isDefined(var2) && isDefined(var3)) {
    if(scripts\cp_mp\vehicles\vehicle_occupancy::ref_141df(var1, var2)) {
      var0 scripts\mp\playeractions::allowactionset("vehicle", 1);
      var0 scripts\mp\playeractions::allowactionset("vehicle_passenger", 0);
      return;
    }

    if(scripts\cp_mp\vehicles\vehicle_occupancy::ref_141df(var1, var3)) {
      var0 scripts\mp\playeractions::allowactionset("vehicle_passenger", 1);
      var0 scripts\mp\playeractions::allowactionset("vehicle", 0);
      return;
    }

    return;
  }
}

function vehicle_occupancy_mp_updatemarkfilter(var0) {
  if(!isDefined(var0.occupants)) {
    return;
  }

  if(!isDefined(var0.ref_11b19)) {
    var0.ref_11b19 = 1;
  }

  var1 = var0.ref_11b19;
  var2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var0);
  var0.ref_11b19 = var2.size > 0;

  if(var1 && !var0.ref_11b19) {
    var0 disableplayermarks("killstreak");
  } else if(!var1 && var0.ref_11b19) {
    var0 enableplayermarks("killstreak");
  }

  if(var0.ref_11b19) {
    if(level.teambased) {
      var3 = [];

      foreach(var5 in var2) {
        if(!scripts\engine\utility::array_contains(var3, var5.team)) {
          var3 = var5.team;
        }
      }

      var0 filteroutplayermarks(var3);
      return;
    }

    var0 filteroutplayermarks(var2);
    return;
  }
}

function vehicle_occupancy_mp_registerinstance(var0) {}

function vehicle_occupancy_mp_deregisterinstance(var0) {}

function ref_141ee(var0, var1, var2, var3) {
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(var0.vehiclename, var1);

  if(istrue(var4.ref_13345)) {
    return;
  }

  if(isDefined(level.ref_11a32) && scripts\engine\utility::array_contains(level.ref_11a32, var2)) {
    if(isDefined(var2.carriable_set_dropped)) {
      killfxontag(level._effect["vfx_br_cashLeaderBag"], var2, "j_bag_left");
      var5 = "accessory_money_bag_large_closed_player";

      if(scripts\mp\gametypes\br_public::shouldusegoldbarassets()) {
        var5 = "accessory_gold_bar_bag_player";
      }

      var2 hidepart("j_bag_left", var5);
      return;
    }

    return;
  }
}

function ref_141ef(var0, var1, var2, var3) {
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(var0.vehiclename, var1);

  if(istrue(var4.ref_13345)) {
    return;
  }

  if(isDefined(level.ref_11a32) && scripts\engine\utility::array_contains(level.ref_11a32, var2)) {
    if(isDefined(var2.carriable_set_dropped)) {
      var5 = "accessory_money_bag_large_closed_player";

      if(scripts\mp\gametypes\br_public::shouldusegoldbarassets()) {
        var5 = "accessory_gold_bar_bag_player";
      }

      var2 showpart("j_bag_left", var5);
      playFXOnTag(level._effect["vfx_br_cashLeaderBag"], var2, "j_bag_left");
      return;
    }

    return;
  }
}

function vehicle_occupancy_mp_updateowner(var0) {
  vehicle_occupancy_mp_updatemarkfilter(var0);
}

function ref_141f0(var0, var1, var2) {
  var3 = undefined;
  var4 = undefined;
  var5 = undefined;
  var6 = var0 getweaponslistprimaries();

  foreach(var8 in var6) {
    if(nullweapon(var8)) {
      continue;
    }

    if(scripts\mp\riotshield::isriotshield(var8)) {
      var3 = var8;

      if(isnullweapon(var3, var0 getcurrentprimaryweapon())) {
        var4 = 1;
      }

      continue;
    }

    if(!isDefined(var5)) {
      var9 = var8 getnoaltweapon();

      if(var9.inventorytype != "primary") {
        continue;
      }

      var5 = var8;
    }
  }

  if(isDefined(var3)) {
    var0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var3);
    var0.ref_12d53 = var3;
    var0.ref_12d4f = var4;

    if(istrue(var4)) {
      ref_141f2(var0, var1, var2);
    }

    var0 scripts\mp\class::riotshieldonweaponchange(var5);
    var0 notify("modified_riot_shield");
    var0 endon("modified_riot_shield");
    var0 childthread scripts\cp_mp\utility\inventory_utility::forcevalidweapon(var5);
    return;
  }
}

function ref_141ed(var0, var1, var2) {
  if(isDefined(var0.ref_12d53)) {
    var3 = level.gametype == "br";

    if(!istrue(var1) && (var3 || !istrue(var2))) {
      var0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var0.ref_12d53);
      var0 scripts\mp\class::ref_13c5c();

      if(istrue(var0.ref_12d4f)) {
        var0 notify("modified_riot_shield");
        var0 endon("modified_riot_shield");

        if(!istrue(var2)) {
          var0 childthread scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var0.ref_12d53);
        }
      }
    }

    var0.ref_12d53 = undefined;
    var0.ref_12d4f = undefined;
    var0 notify("modified_riot_shield");
    return;
  }
}

function ref_141f2(var0, var1, var2) {
  if(isDefined(var0.ref_12d53) && istrue(var0.ref_12d4f)) {
    if(!isDefined(var2)) {
      return;
    }

    if(scripts\cp_mp\vehicles\vehicle_occupancy::ref_141df(var1, var2)) {
      return;
    }

    if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_shouldhideoccupantforseat(var1, var2)) {
      return;
    }

    var3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(var1.vehiclename, var2);

    if(isDefined(var3.ref_13e8a)) {
      return;
    }

    var0.ref_12d4f = undefined;
    return;
  }
}

function ref_141f3(var0) {
  if(!var0 getscriptablehaspart("stability")) {
    return;
  }

  var1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var0);
  var2 = var0 vehicle_getspeed();

  if(var1.size > 0) {
    var0 setscriptablepartstate("stability", "stable", 1);
    return;
  }

  if(var1.size == 0 && var2 > 10) {
    var0 setscriptablepartstate("stability", "unstable", 1);
    return;
  }
}

function ref_141f1(var0) {
  if(!level.vehicle.ref_1424e) {
    return;
  }

  if(!ref_141e6()) {
    return;
  }

  if(!var0 getscriptablehaspart("lights")) {
    return;
  }

  if(!isDefined(var0.showmapchyron)) {
    var0.showmapchyron = 0;
  }

  var1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var0);

  if(var1.size > 0 && !var0.showmapchyron) {
    var0 setscriptablepartstate("lights", "on", 1);
    var0.showmapchyron = 1;
    return;
  }

  if(var1.size == 0 && var0.showmapchyron) {
    var0 setscriptablepartstate("lights", "off", 1);
    var0.showmapchyron = 0;
    return;
  }
}

function ref_141e6() {
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

function vehicle_occupancy_mp_registersentient(var0) {
  var1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(var0.vehiclename);

  if(!isDefined(var1.threatbiasgroup)) {
    return;
  }

  if(level.teambased) {
    var2 = var0.team;

    if(isDefined(var0.team) && var0.team == "neutral") {
      var2 = undefined;
    }

    if(!isDefined(var2) && isDefined(var0.owner)) {
      var2 = var0.owner.team;
    }

    if(isDefined(var2)) {
      if(!isDefined(var0.sentientteam) || var0.sentientteam != var2) {
        vehicle_occupancy_mp_unregistersentient(var0);
        var0 scripts\mp\sentientpoolmanager::registersentient(var1.threatbiasgroup, var2);
        var0.sentientteam = var2;
        return;
      }

      return;
    }

    if(isDefined(var0.sentientteam)) {
      vehicle_occupancy_mp_unregistersentient(var0);
      return;
    }

    return;
  }
}

function vehicle_occupancy_mp_unregistersentient(var0) {
  var0 notify("remove_sentient");
  var0.sentientteam = undefined;
}

function vehicle_occupancy_mp_issentient(var0) {
  return isDefined(var0.sentientteam);
}