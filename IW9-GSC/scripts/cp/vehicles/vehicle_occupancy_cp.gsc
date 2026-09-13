/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\vehicle_occupancy_cp.gsc
********************************************************/

vehicle_occupancy_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "onEnterVehicle", ::vehicle_occupancy_cp_onentervehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "onExitVehicle", ::vehicle_occupancy_cp_onexitvehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "handleSuicideFromVehicles", ::vehicle_occupancy_cp_handlesuicidefromvehicles);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "takeRiotShield", ::vehicle_occupancy_cp_takeriotshield);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "giveRiotShield", ::vehicle_occupancy_cp_giveriotshield);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "updateRiotShield", ::vehicle_occupancy_cp_updateriotshield);
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("vehicle", ["gesture", "killstreaks", "supers", "cp_munitions"]);
}

vehicle_occupancy_cp_onentervehicle(vehicle, _id_7558F98F3236963D, player, data) {
  if(isDefined(vehicle.vehicle_specific_onentervehicle))
    [[vehicle.vehicle_specific_onentervehicle]](vehicle, _id_7558F98F3236963D, player, data);

  player _id_3B64EB40368C1450::_id_3633B947164BE4F3("vehicle", 0);

  if(scripts\cp\cp_outofbounds::isoob(vehicle, 1))
    vehicle thread scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_entercallbackforplayer(player);

  if(isDefined(player.linkedsaw)) {
    player.linkedsaw hide();
    player.linkedsaw unlink();
  }

  if(istrue(vehicle.bshouldoccupantsbeignored))
    player scripts\cp\utility::allow_player_ignore_me(1);

  if(_id_476B6443E3798F5E::_id_AB29F5844AA437FB())
    _id_476B6443E3798F5E::_id_B0637EFA07AB9DF9(vehicle, "killstreak");

  player.binvehicle = 1;
  player.dontmeleeme = 1;
  player notify("entered_vehicle");
  player notify("force_regeneration");
}

vehicle_occupancy_cp_onexitvehicle(vehicle, _id_FC7C7A874B43A31A, player, data) {
  if(isDefined(vehicle.vehicle_specific_onexitvehicle))
    [[vehicle.vehicle_specific_onexitvehicle]](vehicle, _id_FC7C7A874B43A31A, player, data);

  if(!istrue(data.playerdisconnect)) {
    if(!istrue(data.playerdeath)) {
      player _id_3B64EB40368C1450::_id_588F2307A3040610("vehicle");

      if(scripts\cp\cp_outofbounds::isoob(vehicle, 1))
        vehicle thread scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_exitcallbackforplayer(player);
    }

    if(_id_476B6443E3798F5E::_id_AB29F5844AA437FB())
      _id_476B6443E3798F5E::_id_51AC8764C365BC6E(vehicle);

    player notify("vehicle_exit");
  }

  if(istrue(vehicle.bshouldoccupantsbeignored))
    player scripts\cp\utility::allow_player_ignore_me(0);

  if(isDefined(player.linkedsaw)) {
    player.linkedsaw linkTo(player, "tag_shield_back", (5, 10, 0), (0, 0, 90));
    player.linkedsaw show();
  }

  player.shouldskiplaststand = undefined;
  player.binvehicle = 0;
  player.dontmeleeme = 0;
  player notify("exited_vehicle");
}

vehicle_occupancy_cp_handlesuicidefromvehicles(player) {
  player.shouldskipdeathsshield = 1;
  player.shouldskiplaststand = 1;
  player dodamage(player.health + 50, player.origin);
}

vehicle_occupancy_cp_takeriotshield(player, vehicle, _id_7558F98F3236963D) {
  _id_EABB2F4030699112 = undefined;
  riotshieldiscurrentprimary = undefined;
  _id_102D661B1CAA8BC1 = undefined;
  primaryweapons = player getweaponslistprimaries();

  foreach(weapon in primaryweapons) {
    if(isnullweapon(weapon)) {
      continue;
    }
    if(scripts\cp_mp\utility\weapon_utility::isriotshield(weapon)) {
      _id_EABB2F4030699112 = weapon;

      if(issameweapon(_id_EABB2F4030699112, player getcurrentprimaryweapon()))
        riotshieldiscurrentprimary = 1;

      continue;
    }

    if(!isDefined(_id_102D661B1CAA8BC1)) {
      _id_DD9181EB18C4DB69 = weapon getnoaltweapon();

      if(_id_DD9181EB18C4DB69.inventorytype != "primary") {
        continue;
      }
      _id_102D661B1CAA8BC1 = weapon;
    }
  }

  if(isDefined(_id_EABB2F4030699112)) {
    player scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_EABB2F4030699112);
    player.riotshieldtaken = _id_EABB2F4030699112;
    player.riotshieldiscurrentprimary = riotshieldiscurrentprimary;

    if(istrue(riotshieldiscurrentprimary))
      vehicle_occupancy_cp_updateriotshield(player, vehicle, _id_7558F98F3236963D);

    player _id_74502A9E0EF1F19C::riotshieldonweaponchange(_id_102D661B1CAA8BC1);
    player notify("modified_riot_shield");
    player endon("modified_riot_shield");
    player childthread scripts\cp_mp\utility\inventory_utility::forcevalidweapon(_id_102D661B1CAA8BC1);
  }
}

vehicle_occupancy_cp_giveriotshield(player, _id_FCEF8D217A441961, _id_8FEAFCEA3627EB2B) {
  if(isDefined(player.riotshieldtaken)) {
    if(!istrue(_id_FCEF8D217A441961) && !istrue(_id_8FEAFCEA3627EB2B)) {
      player scripts\cp_mp\utility\inventory_utility::_giveweapon(player.riotshieldtaken);
      player _id_74502A9E0EF1F19C::trackriotshield_tryreset();

      if(istrue(player.riotshieldiscurrentprimary)) {
        player notify("modified_riot_shield");
        player endon("modified_riot_shield");
        player childthread scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(player.riotshieldtaken);
      }
    } else if(!istrue(_id_FCEF8D217A441961) && istrue(_id_8FEAFCEA3627EB2B))
      player.riotshield_return = player.riotshieldtaken;

    player.riotshieldtaken = undefined;
    player.riotshieldiscurrentprimary = undefined;
    player notify("modified_riot_shield");
  }
}

vehicle_occupancy_cp_updateriotshield(player, vehicle, _id_7558F98F3236963D) {
  if(isDefined(player.riotshieldtaken) && istrue(player.riotshieldiscurrentprimary)) {
    if(!isDefined(_id_7558F98F3236963D)) {
      return;
    }
    if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_isdriverseat(vehicle, _id_7558F98F3236963D)) {
      return;
    }
    if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_shouldhideoccupantforseat(vehicle, _id_7558F98F3236963D)) {
      return;
    }
    _id_0C50B485A43752FD = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(vehicle.vehiclename, _id_7558F98F3236963D);

    if(isDefined(_id_0C50B485A43752FD.turretobjweapon)) {
      return;
    }
    player.riotshieldiscurrentprimary = undefined;
  }
}