/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\vehicle_occupancy_cp.gsc
********************************************************/

function vehicle_occupancy_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "onEnterVehicle", &vehicle_occupancy_cp_onentervehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "onExitVehicle", &vehicle_occupancy_cp_onexitvehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "handleSuicideFromVehicles", &ref_141ce);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "takeRiotShield", &ref_141cf);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "giveRiotShield", &ref_141cd);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "updateRiotShield", &ref_141d0);
  scripts\mp\playeractions::registeractionset("vehicle", ["gesture", "killstreaks", "supers", "cp_munitions"]);
}

function vehicle_occupancy_cp_onentervehicle(var0, var1, var2, var3) {
  if(isDefined(var0.vehicle_specific_onentervehicle)) {
    [[var0.vehicle_specific_onentervehicle]](var0, var1, var2, var3);
  }

  var2 scripts\mp\playeractions::allowactionset("vehicle", 0);
  scripts\cp\cp_outofbounds::enableoobimmunity(var2);

  if(scripts\cp\cp_outofbounds::isoob(var0, 1)) {
    var0 thread scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_entercallbackforplayer(var2);
  }

  if(isDefined(var2.x1circletime)) {
    var2.x1circletime hide();
    var2.x1circletime unlink();
  }

  if(istrue(var0.bshouldoccupantsbeignored)) {
    var2 scripts\cp\utility::allow_player_ignore_me(1);
  }

  var2.binvehicle = 1;
  var2.dontmelee = 1;
  var2.dontmeleeme = 1;
  var2 notify("entered_vehicle");
}

function vehicle_occupancy_cp_onexitvehicle(var0, var1, var2, var3) {
  if(isDefined(var0.vehicle_specific_onexitvehicle)) {
    [[var0.vehicle_specific_onexitvehicle]](var0, var1, var2, var3);
  }

  if(!istrue(var3.playerdisconnect)) {
    if(!istrue(var3.playerdeath)) {
      var2 scripts\mp\playeractions::allowactionset("vehicle", 1);

      if(scripts\cp\cp_outofbounds::isoob(var0, 1)) {
        var0 thread scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_exitcallbackforplayer(var2);
      }

      scripts\cp\cp_outofbounds::disableoobimmunity(var2);
    }

    var2 notify("vehicle_exit");
  }

  if(istrue(var0.bshouldoccupantsbeignored)) {
    var2 scripts\cp\utility::allow_player_ignore_me(0);
  }

  if(isDefined(var2.x1circletime)) {
    var2.x1circletime linkTo(var2, "tag_shield_back", (5, 10, 0), (0, 0, 90));
    var2.x1circletime show();
  }

  var2.shouldskiplaststand = undefined;
  var2.binvehicle = 0;
  var2.dontmelee = undefined;
  var2.dontmeleeme = undefined;
  var2 notify("exited_vehicle");
}

function ref_141ce(var0) {
  var0.shouldskipdeathsshield = 1;
  var0.shouldskiplaststand = 1;
  var0 dodamage(var0.health + 50, var0.origin);
}

function ref_141cf(var0, var1, var2) {
  var3 = undefined;
  var4 = undefined;
  var5 = undefined;
  var6 = var0 getweaponslistprimaries();

  foreach(var8 in var6) {
    if(nullweapon(var8)) {
      continue;
    }

    if(scripts\cp\utility::isriotshield(var8)) {
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
      ref_141d0(var0, var1, var2);
    }

    var0 scripts\cp\cp_weapon::riotshieldonweaponchange(var5);
    var0 notify("modified_riot_shield");
    var0 endon("modified_riot_shield");
    var0 childthread scripts\cp_mp\utility\inventory_utility::forcevalidweapon(var5);
    return;
  }
}

function ref_141cd(var0, var1, var2) {
  if(isDefined(var0.ref_12d53)) {
    if(!istrue(var1) && !istrue(var2)) {
      var0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var0.ref_12d53);
      var0 scripts\cp\cp_weapon::ref_13c5c();

      if(istrue(var0.ref_12d4f)) {
        var0 notify("modified_riot_shield");
        var0 endon("modified_riot_shield");
        var0 childthread scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var0.ref_12d53);
      }
    } else if(!istrue(var1) && istrue(var2)) {
      var0.ref_12d4d = var0.ref_12d53;
    }

    var0.ref_12d53 = undefined;
    var0.ref_12d4f = undefined;
    var0 notify("modified_riot_shield");
    return;
  }
}

function ref_141d0(var0, var1, var2) {
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