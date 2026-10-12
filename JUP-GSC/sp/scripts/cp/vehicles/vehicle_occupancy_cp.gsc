/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\vehicle_occupancy_cp.gsc
********************************************************/



#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_outofbounds;
#using scripts\cp\objective_trigger;
#using scripts\cp\utility;
#using scripts\cp\vehicles\vehicle_oob_cp;
#using scripts\cp\weapon;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;
#namespace vehicle_occupancy_cp;

function vehicle_occupancy_cp_init() {
  registersharedfunc("vehicle_occupancy", "onEnterVehicle", &vehicle_occupancy_cp_onentervehicle);
  registersharedfunc("vehicle_occupancy", "onExitVehicle", &vehicle_occupancy_cp_onexitvehicle);
  registersharedfunc("vehicle_occupancy", "handleSuicideFromVehicles", &vehicle_occupancy_cp_handlesuicidefromvehicles);
  registersharedfunc("vehicle_occupancy", "takeRiotShield", &vehicle_occupancy_cp_takeriotshield);
  registersharedfunc("vehicle_occupancy", "giveRiotShield", &vehicle_occupancy_cp_giveriotshield);
  registersharedfunc("vehicle_occupancy", "updateRiotShield", &vehicle_occupancy_cp_updateriotshield);
  val::group_register("vehicle", ["gesture", "killstreaks", "supers", "cp_munitions"]);
}

function vehicle_occupancy_cp_onentervehicle(vehicle, newseatid, player, data) {
  if(isDefined(vehicle.vehicle_specific_onentervehicle)) {
    [[vehicle.vehicle_specific_onentervehicle]](vehicle, newseatid, player, data);
  }

  player val::group_set("vehicle", 0);

  if(scripts\cp\cp_outofbounds::isoob(vehicle, 1)) {
    vehicle thread scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_entercallbackforplayer(player);
  }

  if(isDefined(player.linkedsaw)) {
    player.linkedsaw hide();
    player.linkedsaw unlink();
  }

  if(istrue(vehicle.bshouldoccupantsbeignored)) {
    player scripts\cp\utility::allow_player_ignore_me(1);
  }

  if(scripts\cp\objective_trigger::function_ab29f5844aa437fb()) {
    scripts\cp\objective_trigger::function_b0637efa07ab9df9(vehicle, "killstreak");
  }

  player.binvehicle = 1;
  player.dontmeleeme = 1;
  player notify("entered_vehicle");
  player notify("force_regeneration");
}

function vehicle_occupancy_cp_onexitvehicle(vehicle, oldseatid, player, data) {
  if(isDefined(vehicle.vehicle_specific_onexitvehicle)) {
    [[vehicle.vehicle_specific_onexitvehicle]](vehicle, oldseatid, player, data);
  }

  if(!istrue(data.playerdisconnect)) {
    if(!istrue(data.playerdeath)) {
      player val::group_reset("vehicle");

      if(scripts\cp\cp_outofbounds::isoob(vehicle, 1)) {
        vehicle thread scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_exitcallbackforplayer(player);
      }
    }

    if(scripts\cp\objective_trigger::function_ab29f5844aa437fb()) {
      scripts\cp\objective_trigger::function_51ac8764c365bc6e(vehicle);
    }

    player notify("vehicle_exit");
  }

  if(istrue(vehicle.bshouldoccupantsbeignored)) {
    player scripts\cp\utility::allow_player_ignore_me(0);
  }

  if(isDefined(player.linkedsaw)) {
    player.linkedsaw linkTo(player, "tag_shield_back", (5, 10, 0), (0, 0, 90));
    player.linkedsaw show();
  }

  player.shouldskiplaststand = undefined;
  player.binvehicle = 0;
  player.dontmeleeme = 0;
  player notify("exited_vehicle");
}

function vehicle_occupancy_cp_handlesuicidefromvehicles(player) {
  player.shouldskipdeathsshield = 1;
  player.shouldskiplaststand = 1;
  player dodamage(player.health + 50, player.origin);
}

function vehicle_occupancy_cp_takeriotshield(player, vehicle, newseatid) {
  riotshieldweapon = undefined;
  riotshieldiscurrentprimary = undefined;
  var_102d661b1caa8bc1 = undefined;
  primaryweapons = player getweaponslistprimaries();

  foreach(weapon in primaryweapons) {
    if(isnullweapon(weapon)) {
      continue;
    }

    if(isriotshield(weapon)) {
      assertex(!isDefined(riotshieldweapon), "vehicle_occupancy_cp_takeRiotShield found two riot shields in player's inventory.");
      riotshieldweapon = weapon;

      if(issameweapon(riotshieldweapon, player getcurrentprimaryweapon())) {
        riotshieldiscurrentprimary = 1;
      }

      continue;
    }

    if(!isDefined(var_102d661b1caa8bc1)) {
      noaltweapon = weapon getnoaltweapon();

      if(noaltweapon.inventorytype != "primary") {
        continue;
      }

      var_102d661b1caa8bc1 = weapon;
    }
  }

  if(isDefined(riotshieldweapon)) {
    player _takeweapon(riotshieldweapon);
    player.riotshieldtaken = riotshieldweapon;
    player.riotshieldiscurrentprimary = riotshieldiscurrentprimary;

    if(istrue(riotshieldiscurrentprimary)) {
      vehicle_occupancy_cp_updateriotshield(player, vehicle, newseatid);
    }

    assertex(isDefined(var_102d661b1caa8bc1), "vehicle_occupancy_cp_takeRiotShield took riot shield, but cannot find a weapon to switch to.");
    player scripts\cp\weapon::riotshieldonweaponchange(var_102d661b1caa8bc1);
    player notify("modified_riot_shield");
    player endon("modified_riot_shield");
    player childthread forcevalidweapon(var_102d661b1caa8bc1);
  }
}

function vehicle_occupancy_cp_giveriotshield(player, fromdeath, fromlaststand) {
  if(isDefined(player.riotshieldtaken)) {
    if(!istrue(fromdeath) && !istrue(fromlaststand)) {
      player _giveweapon(player.riotshieldtaken);
      player scripts\cp\weapon::trackriotshield_tryreset();

      if(istrue(player.riotshieldiscurrentprimary)) {
        player notify("modified_riot_shield");
        player endon("modified_riot_shield");
        player childthread _switchtoweaponimmediate(player.riotshieldtaken);
      }
    } else if(!istrue(fromdeath) && istrue(fromlaststand)) {
      player.riotshield_return = player.riotshieldtaken;
    }

    player.riotshieldtaken = undefined;
    player.riotshieldiscurrentprimary = undefined;
    player notify("modified_riot_shield");
  }
}

function vehicle_occupancy_cp_updateriotshield(player, vehicle, newseatid) {
  if(isDefined(player.riotshieldtaken) && istrue(player.riotshieldiscurrentprimary)) {
    if(!isDefined(newseatid)) {
      return;
    }

    if(vehicle_occupancy_isdriverseat(vehicle, newseatid)) {
      return;
    }

    if(vehicle_shouldhideoccupantforseat(vehicle, newseatid)) {
      return;
    }

    leveldataforseat = vehicle_occupancy_getleveldataforseat(vehicle.vehiclename, newseatid);

    if(isDefined(leveldataforseat.turretobjweapon)) {
      return;
    }

    player.riotshieldiscurrentprimary = undefined;
  }
}