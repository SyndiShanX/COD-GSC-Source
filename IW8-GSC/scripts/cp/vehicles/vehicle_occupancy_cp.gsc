/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\vehicle_occupancy_cp.gsc
********************************************************/

function vehicle_occupancy_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "onEnterVehicle", &vehicle_occupancy_cp_onentervehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "onExitVehicle", &vehicle_occupancy_cp_onexitvehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "handleSuicideFromVehicles", &ref_141CE);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "takeRiotShield", &ref_141CF);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "giveRiotShield", &ref_141CD);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "updateRiotShield", &ref_141D0);
  scripts\mp\playeractions::registeractionset("vehicle", ["gesture", "killstreaks", "supers", "cp_munitions"]);
}

function vehicle_occupancy_cp_onentervehicle(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0.vehicle_specific_onentervehicle)) {
    [[var_0.vehicle_specific_onentervehicle]](var_0, var_1, var_2, var_3);
  }

  var_2 scripts\mp\playeractions::allowactionset("vehicle", 0);
  scripts\cp\cp_outofbounds::enableoobimmunity(var_2);

  if(scripts\cp\cp_outofbounds::isoob(var_0, 1)) {
    var_0 thread scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_entercallbackforplayer(var_2);
  }

  if(isDefined(var_2.x1circletime)) {
    var_2.x1circletime hide();
    var_2.x1circletime unlink();
  }

  if(istrue(var_0.bshouldoccupantsbeignored)) {
    var_2 scripts\cp\utility::allow_player_ignore_me(1);
  }

  var_2.binvehicle = 1;
  var_2.dontmelee = 1;
  var_2.dontmeleeme = 1;
  var_2 notify("entered_vehicle");
}

function vehicle_occupancy_cp_onexitvehicle(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0.vehicle_specific_onexitvehicle)) {
    [[var_0.vehicle_specific_onexitvehicle]](var_0, var_1, var_2, var_3);
  }

  if(!istrue(var_3.playerdisconnect)) {
    if(!istrue(var_3.playerdeath)) {
      var_2 scripts\mp\playeractions::allowactionset("vehicle", 1);

      if(scripts\cp\cp_outofbounds::isoob(var_0, 1)) {
        var_0 thread scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_exitcallbackforplayer(var_2);
      }

      scripts\cp\cp_outofbounds::disableoobimmunity(var_2);
    }

    var_2 notify("vehicle_exit");
  }

  if(istrue(var_0.bshouldoccupantsbeignored)) {
    var_2 scripts\cp\utility::allow_player_ignore_me(0);
  }

  if(isDefined(var_2.x1circletime)) {
    var_2.x1circletime linkTo(var_2, "tag_shield_back", (5, 10, 0), (0, 0, 90));
    var_2.x1circletime show();
  }

  var_2.shouldskiplaststand = undefined;
  var_2.binvehicle = 0;
  var_2.dontmelee = undefined;
  var_2.dontmeleeme = undefined;
  var_2 notify("exited_vehicle");
}

function ref_141CE(var_0) {
  var_0.shouldskipdeathsshield = 1;
  var_0.shouldskiplaststand = 1;
  var_0 dodamage(var_0.health + 50, var_0.origin);
}

function ref_141CF(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = var_0 getweaponslistprimaries();

  foreach(var_8 in var_6) {
    if(nullweapon(var_8)) {
      continue;
    }

    if(scripts\cp\utility::isriotshield(var_8)) {
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
      ref_141D0(var_0, var_1, var_2);
    }

    var_0 scripts\cp\cp_weapon::riotshieldonweaponchange(var_5);
    var_0 notify("modified_riot_shield");
    var_0 endon("modified_riot_shield");
    var_0 childthread scripts\cp_mp\utility\inventory_utility::forcevalidweapon(var_5);
    return;
  }
}

function ref_141CD(var_0, var_1, var_2) {
  if(isDefined(var_0.ref_12D53)) {
    if(!istrue(var_1) && !istrue(var_2)) {
      var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0.ref_12D53);
      var_0 scripts\cp\cp_weapon::ref_13C5C();

      if(istrue(var_0.ref_12D4F)) {
        var_0 notify("modified_riot_shield");
        var_0 endon("modified_riot_shield");
        var_0 childthread scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_0.ref_12D53);
      }
    } else if(!istrue(var_1) && istrue(var_2)) {
      var_0.ref_12D4D = var_0.ref_12D53;
    }

    var_0.ref_12D53 = undefined;
    var_0.ref_12D4F = undefined;
    var_0 notify("modified_riot_shield");
    return;
  }
}

function ref_141D0(var_0, var_1, var_2) {
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