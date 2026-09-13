/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\helper_drone.gsc
******************************************************/

init() {
  level.helperdronesettings = [];
  _id_6D68CFDF0836123C::init();
  _id_249F45D992AF1114::init();
  level.helperdronesettings["radar_drone_overwatch"] = spawnStruct();
  level.helperdronesettings["radar_drone_overwatch"].timeout = 45.0;
  level.helperdronesettings["radar_drone_overwatch"].maxhealth = 700;
  level.helperdronesettings["radar_drone_overwatch"].hitstokill = 3;
  level.helperdronesettings["radar_drone_overwatch"].speed = 100;
  level.helperdronesettings["radar_drone_overwatch"].accel = 10;
  level.helperdronesettings["radar_drone_overwatch"].halfsize = 50;
  level.helperdronesettings["radar_drone_overwatch"].spawndist = 100;
  level.helperdronesettings["radar_drone_overwatch"].streakname = "radar_drone_overwatch";
  level.helperdronesettings["radar_drone_overwatch"].vehicleinfo = "veh_radar_drone_overwatch_mp";
  level.helperdronesettings["radar_drone_overwatch"].modelbase = "veh8_mil_air_mquebec8_small";
  level.helperdronesettings["radar_drone_overwatch"].modelbasealt = "veh8_mil_air_mquebec8_small_east";
  level.helperdronesettings["radar_drone_overwatch"].teamsplash = "used_radar_drone_overwatch";
  level.helperdronesettings["radar_drone_overwatch"].destroyedsplash = "callout_destroyed_radar_drone_overwatch";
  level.helperdronesettings["radar_drone_overwatch"].sound_explode = "radar_drone_explode";
  level.helperdronesettings["radar_drone_overwatch"].vodestroyed = "destroyed_radar_drone_overwatch";
  level.helperdronesettings["radar_drone_overwatch"].votimedout = "timeout_radar_drone_overwatch";
  level.helperdronesettings["radar_drone_overwatch"].scorepopup = "destroyed_radar_drone_overwatch";
  level.helperdronesettings["radar_drone_overwatch"].playfxcallback = ::_id_56966B077270A18E;
  level.helperdronesettings["radar_drone_overwatch"].standupoffset = 120;
  level.helperdronesettings["radar_drone_overwatch"].crouchupoffset = 80;
  level.helperdronesettings["radar_drone_overwatch"].proneupoffset = 46;
  level.helperdronesettings["radar_drone_overwatch"].backoffset = 124;
  level.helperdronesettings["radar_drone_overwatch"].sideoffset = 55;
  level.helperdronesettings["radar_drone_overwatch"].primarymode = "RADAR";
  level.helperdronesettings["radar_drone_overwatch"].primarymodestring = &"KILLSTREAKS_HINTS/RCD_RADAR";
  level.helperdronesettings["radar_drone_overwatch"].primarymodefunc = ::setoverwatchmodesettings;
  level.helperdronesettings["radar_drone_overwatch"].premoddamagefunc = undefined;
  level.helperdronesettings["radar_drone_overwatch"].postmoddamagefunc = ::_id_CAF721CB23374E2B;
  level.helperdronesettings["radar_drone_overwatch"].deathfunc = ::_id_BA1C5496F8FC5F67;
  level.helperdronesettings["radar_drone_overwatch"].deployweaponname = "ks_gesture_generic_mp";
  level.helperdronesettings["scrambler_drone_guard"] = spawnStruct();
  level.helperdronesettings["scrambler_drone_guard"].timeout = 45.0;
  level.helperdronesettings["scrambler_drone_guard"].maxhealth = 150;
  level.helperdronesettings["scrambler_drone_guard"].speed = 140;
  level.helperdronesettings["scrambler_drone_guard"].accel = 20;
  level.helperdronesettings["scrambler_drone_guard"].halfsize = 50;
  level.helperdronesettings["scrambler_drone_guard"].spawndist = 100;
  level.helperdronesettings["scrambler_drone_guard"].streakname = "scrambler_drone_guard";
  level.helperdronesettings["scrambler_drone_guard"].modelbase = "veh9_mil_air_cuniform_mp";
  level.helperdronesettings["scrambler_drone_guard"].teamsplash = "used_scrambler_drone_guard";
  level.helperdronesettings["scrambler_drone_guard"].destroyedsplash = "callout_destroyed_scrambler_drone_guard";
  level.helperdronesettings["scrambler_drone_guard"].sound_explode = "scrambler_drone_explode";
  level.helperdronesettings["scrambler_drone_guard"].vodestroyed = undefined;
  level.helperdronesettings["scrambler_drone_guard"].votimedout = undefined;
  level.helperdronesettings["scrambler_drone_guard"].scorepopup = "destroyed_scrambler_drone_guard";
  level.helperdronesettings["scrambler_drone_guard"].playfxcallback = ::_id_56966B077270A18E;
  level.helperdronesettings["scrambler_drone_guard"].primarymodefunc = ::setguardmode;
  level.helperdronesettings["scrambler_drone_guard"].premoddamagefunc = undefined;
  level.helperdronesettings["scrambler_drone_guard"].postmoddamagefunc = undefined;
  level.helperdronesettings["scrambler_drone_guard"].deathfunc = undefined;
  level.helperdronesettings["scrambler_drone_guard"]._id_5D9D3E47B1B88B84 = ::_id_E89890DE385D2D9E;
  level.helperdronesettings["scrambler_drone_guard"].damagemonitorfunc = ::helperdrone_watchdamage;
  level.helperdronesettings["scrambler_drone_guard"].deployweaponname = "ks_gesture_phone_mp";
  level.helperdronesettings["scrambler_drone_guard"]._id_5C6A7212BF9FCBEA = 1;
  gametype = "";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType"))
    gametype = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();

  _id_E005D4B70D6F2611 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isBRStyleGameType") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isBRStyleGameType")]]();

  if(_id_E005D4B70D6F2611 || gametype == "cp_survival") {
    level.helperdronesettings["radar_drone_recon"].diewithowner = 1;
    level.helperdronesettings["scrambler_drone_guard"].diewithowner = 1;
    level.helperdronesettings["radar_drone_overwatch"].diewithowner = 1;
  }

  level.helperdronesettings["ammo_drop"] = spawnStruct();
  level.helperdronesettings["ammo_drop"].timeout = undefined;
  level.helperdronesettings["ammo_drop"].maxhealth = 100;
  level.helperdronesettings["ammo_drop"].hitstokill = 3;
  level.helperdronesettings["ammo_drop"].speed = 60;
  level.helperdronesettings["ammo_drop"].accel = 20;
  level.helperdronesettings["ammo_drop"].halfsize = 30;
  level.helperdronesettings["ammo_drop"].spawndist = 100;
  level.helperdronesettings["ammo_drop"].streakname = "ammo_drop";
  level.helperdronesettings["ammo_drop"].vehicleinfo = "veh_delivery_drone_recon_mp";
  level.helperdronesettings["ammo_drop"].modelbase = "veh8_mil_air_malfa_big";
  level.helperdronesettings["ammo_drop"].teamsplash = "used_radar_drone_recon";
  level.helperdronesettings["ammo_drop"].destroyedsplash = "callout_destroyed_radar_drone_overwatch";
  level.helperdronesettings["ammo_drop"].sound_explode = "radar_drone_explode";
  level.helperdronesettings["ammo_drop"].vodestroyed = "ball_drone_backup_destroy";
  level.helperdronesettings["ammo_drop"].votimedout = "ball_drone_backup_timeout";
  level.helperdronesettings["ammo_drop"].scorepopup = "destroyed_radar_drone_recon";
  level.helperdronesettings["ammo_drop"].playfxcallback = ::_id_56966B077270A18E;
  level.helperdronesettings["ammo_drop"].standupoffset = 120;
  level.helperdronesettings["ammo_drop"].crouchupoffset = 80;
  level.helperdronesettings["ammo_drop"].proneupoffset = 46;
  level.helperdronesettings["ammo_drop"].backoffset = 124;
  level.helperdronesettings["ammo_drop"].sideoffset = 55;
  level.helperdronesettings["ammo_drop"].primarymodefunc = ::setdeliverymodesettings;
  level.helperdronesettings["ammo_drop"].premoddamagefunc = undefined;
  level.helperdronesettings["ammo_drop"].postmoddamagefunc = ::_id_CAF721CB23374E2B;
  level.helperdronesettings["ammo_drop"].deathfunc = ::_id_BA1C5496F8FC5F67;
  level.helperdronesettings["ammo_drop"].deployweaponname = "ks_gesture_generic_mp";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("helper_drone", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("helper_drone", "init")]]();

  level.incominghelperdrones = [];
  init_helper_drone_vo();
  init_helper_drone_anim();
  _id_82D9DE71444F6E33();
}

init_helper_drone_vo() {
  game["dialog"]["scrambler_drone_guard_use"] = "killstreak_remote_operator_request_response";
  game["dialog"]["scrambler_drone_guard_timeout"] = "killstreak_remote_operator_timeout";
  game["dialog"]["scrambler_drone_guard_destroyed"] = "killstreak_remote_operator_crash";
}

#using_animtree("script_model");

init_helper_drone_anim() {
  level.scr_animtree["scrambler_drone_guard"] = #animtree;
  level.scr_anim["scrambler_drone_guard"]["rotor_spin"] = [%mp_cuniform_rotor_spin];
  level.scr_animname["scrambler_drone_guard"]["rotor_spin"] = "mp_cuniform_rotor_spin";
}

_id_82D9DE71444F6E33() {
  scripts\cp_mp\utility\killstreak_utility::_id_C0B0A582FF9E4D57("recon_drone_color_mp");
  scripts\cp_mp\utility\killstreak_utility::_id_C0B0A582FF9E4D57("recon_drone_color_dark_mp");
}

weapongivenhelperdrone(streakinfo) {
  return 1;
}

_id_29EACADFA638EDC1(streakinfo) {
  level.incominghelperdrones[level.incominghelperdrones.size] = spawnStruct();
  level.incominghelperdrones[level.incominghelperdrones.size - 1].type = streakinfo.streakname;
  level.incominghelperdrones[level.incominghelperdrones.size - 1].owner = self;
  level.incominghelperdrones[level.incominghelperdrones.size - 1].team = self.team;
}

_id_C3786C4FBA09C2F2(streakinfo) {
  if(level.incominghelperdrones.size == 0) {
    return;
  }
  _id_811E1AA75BA89A34 = [];

  foreach(drone in level.incominghelperdrones) {
    if(drone.type == streakinfo.streakname && drone.owner == self) {
      continue;
    }
    _id_811E1AA75BA89A34[_id_811E1AA75BA89A34.size] = drone;
  }

  level.incominghelperdrones = _id_811E1AA75BA89A34;
}

_id_E4EA3048D91B5EB1(streakinfo, _id_D7F72825D583F8FE) {
  _id_29EACADFA638EDC1(streakinfo);

  if(_id_289DDD64EC5B3010(streakinfo, self)) {
    _id_C3786C4FBA09C2F2(streakinfo);
    return 0;
  }

  return 1;
}

_id_4ACD3DE63E55EB6C(streakinfo, _id_D7F72825D583F8FE) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "currentActiveVehicleCount") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "currentActiveVehicleCount")]]() >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]() || level.fauxvehiclecount + 1 >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]()) {
      if(istrue(_id_D7F72825D583F8FE)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TOO_MANY_VEHICLES");
      }

      return 0;
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "incrementFauxVehicleCount"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "incrementFauxVehicleCount")]](1);

  return 1;
}

tryusehelperdrone(streakname) {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(streakname, self);
  return tryusehelperdronefromstruct(streakinfo);
}

tryusehelperdronefromstruct(streakinfo) {
  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo))
      return 0;
  }

  helperdronetype = streakinfo.streakname;
  config = level.helperdronesettings[helperdronetype];
  _id_9B1DEB5E9D32BBE3 = undefined;
  _id_52A5BE2E2F91D710 = undefined;
  _id_8E9BCE85FBF3F459 = 0;

  if(isDefined(config._id_1C606430B81B28FF)) {
    _id_8E9BCE85FBF3F459 = 1;
    _id_9B1DEB5E9D32BBE3 = self[[config._id_1C606430B81B28FF]](streakinfo);
  } else {
    nonvehicle = !isDefined(config.vehicleinfo);

    if(!nonvehicle) {
      if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle())
        return 0;
    }

    deployweaponname = level.helperdronesettings[streakinfo.streakname].deployweaponname;
    deployweaponobj = makeweapon(deployweaponname);

    if(scripts\cp_mp\utility\killstreak_utility::_id_9DEB86C4684340E1(deployweaponobj))
      _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(streakinfo, deployweaponobj, 1, ::weapongivenhelperdrone);
    else if(scripts\cp_mp\utility\killstreak_utility::_id_3FFC7FD85F5754E9(deployweaponobj))
      _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(streakinfo, deployweaponobj, 1, ::weapongivenhelperdrone);
    else if(scripts\cp_mp\utility\killstreak_utility::_id_92AB1470F48812C2(deployweaponobj))
      _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(streakinfo, deployweaponobj);
    else if(scripts\cp_mp\utility\killstreak_utility::_id_6C58C6FDCC87E387(deployweaponobj))
      _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(streakinfo);
    else
      _id_9B1DEB5E9D32BBE3 = 0;

    if(!istrue(_id_9B1DEB5E9D32BBE3)) {
      if(!nonvehicle)
        scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

      return 0;
    }

    if(isDefined(level.killstreakbeginusefunc)) {
      if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
        if(!nonvehicle)
          scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

        if(deployweaponname != "ks_gesture_generic_mp")
          streakinfo notify("killstreak_finished_with_deploy_weapon");

        return 0;
      }
    }

    if(helperdronetype != "scrambler_drone_guard" || deployweaponname == "ks_gesture_generic_mp") {
      _id_CE7E572BA798F2F7 = tryusehelperdroneearlyout(streakinfo, 1);

      if(_id_CE7E572BA798F2F7) {
        if(!nonvehicle)
          scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

        if(deployweaponname != "ks_gesture_generic_mp")
          streakinfo notify("killstreak_finished_with_deploy_weapon");

        return 0;
      }
    }

    startpos = _id_34280B807C23A453(helperdronetype);

    if(deployweaponname == "ks_remote_device_mp") {
      if(!isDefined(startpos)) {
        if(!nonvehicle)
          scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/NOT_ENOUGH_SPACE");

        streakinfo notify("killstreak_finished_with_deploy_weapon");
        return 0;
      }
    }

    if(deployweaponname == "ks_remote_drone_mp") {
      _id_FC4AA9DB408D9420 = 0.6;
      _id_E5C7FFB094DC9EEC = 2;
      result = scripts\engine\utility::waittill_any_timeout_2(_id_FC4AA9DB408D9420, "death", "weapon_switch_started");

      if(!isDefined(result) || result != "timeout") {
        if(!nonvehicle)
          scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

        streakinfo notify("killstreak_finished_with_deploy_weapon");
        return 0;
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
        _id_8E9BCE85FBF3F459 = 1;
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, streakinfo.streakname);
        _id_52A5BE2E2F91D710 = 0.5;
      }

      _id_3B64EB40368C1450::set("helperDrone", "weapon_switch", 0);
      result = scripts\engine\utility::waittill_any_timeout_1(_id_E5C7FFB094DC9EEC - _id_FC4AA9DB408D9420, "death");

      if(!isDefined(result) || result != "timeout") {
        if(!nonvehicle)
          scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

        _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("helperDrone");
        streakinfo notify("killstreak_finished_with_deploy_weapon");
        return 0;
      }

      _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("helperDrone");
    }

    mappointinfo = undefined;

    if(deployweaponname == "ks_remote_map_mp") {
      mappointinfo = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "getSelectMapPoint"))
        mappointinfo = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "getSelectMapPoint")]](streakinfo, 1);

      if(!isDefined(mappointinfo)) {
        if(!nonvehicle)
          scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount"))
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();

        return 0;
      }
    } else if(helperdronetype == "scrambler_drone_guard") {
      location = self.origin;

      if(isDefined(level.traceselectedmaplocation)) {
        _id_BDF908D5D1AAE9F2 = [[level.traceselectedmaplocation]](self.origin);
        location = _id_BDF908D5D1AAE9F2["position"];
      }

      _id_0B21E2E887C161B9 = spawnStruct();
      _id_0B21E2E887C161B9.location = location;
      mappointinfo = [];
      mappointinfo[0] = _id_0B21E2E887C161B9;
    }

    startang = self.angles;

    if(isDefined(mappointinfo)) {
      if(helperdronetype == "scrambler_drone_guard") {
        scripts\cp_mp\utility\killstreak_utility::_id_F772994FA2FB7FFC(self, self.team, 15000, helperdronetype, mappointinfo[0].location);
        _id_F4BA81DDFB51EEBF = mappointinfo[0].location + (0, 0, 3000);
        helperdrone = createhelperdrone(_id_F4BA81DDFB51EEBF, startang, helperdronetype, streakinfo, nonvehicle, !nonvehicle);

        if(!isDefined(helperdrone)) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
            self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/UNAVAILABLE");

          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount"))
            [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();

          _id_C3786C4FBA09C2F2(streakinfo);
          return 0;
        }

        helperdrone.mappointinfo = mappointinfo;
        helperdrone thread perkengineer_manageminimap();
        _id_C3786C4FBA09C2F2(streakinfo);
        thread starthelperdrone(helperdrone);
      }
    } else {
      if(helperdronetype == "radar_drone_escort" || helperdronetype == "radar_drone_recon")
        startpos = _id_34280B807C23A453(helperdronetype);

      if(helperdronetype == "radar_drone_overwatch")
        startpos = self.origin + (0, 0, 1500) - anglesToForward(self.angles) * 5000;

      helperdrone = createhelperdrone(startpos, startang, helperdronetype, streakinfo, nonvehicle, !nonvehicle);

      if(!isDefined(helperdrone)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/NOT_ENOUGH_SPACE");

        helperdronecreationfailedfx(helperdronetype, startpos);
        streakinfo notify("killstreak_finished_with_deploy_weapon");

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount"))
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();

        _id_C3786C4FBA09C2F2(streakinfo);
        return 0;
      }

      if(helperdronetype == "assault_drone")
        thread helperdrone_giveplayerfauxremote(streakinfo);

      _id_C3786C4FBA09C2F2(streakinfo);
      thread starthelperdrone(helperdrone);
    }
  }

  if(!istrue(_id_9B1DEB5E9D32BBE3))
    return 0;

  if(!istrue(_id_8E9BCE85FBF3F459)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, streakinfo.streakname);
      _id_52A5BE2E2F91D710 = 2.5;
    }

    thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(streakinfo.streakname, streakinfo.streakname + "_use", 1, _id_52A5BE2E2F91D710);
  }

  teamsplash = config.teamsplash;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash"))
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]](teamsplash, self);

  if(streakinfo.streakname == "assault_drone") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "doOnActionScoreEvent"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "doOnActionScoreEvent")]](2, "bombDroneUsed");
  }

  return 1;
}

helperdronecreationfailedfx(helperdronetype, _id_39C9EC41466DA42E) {
  if(!isDefined(_id_39C9EC41466DA42E))
    _id_39C9EC41466DA42E = self getEye() + (0, 0, 80);

  fxent = spawn("script_model", _id_39C9EC41466DA42E);
  fxent setModel("ks_" + helperdronetype + "_mp");
  fxent setscriptablepartstate("exit", "on", 0);
  fxent thread delay_deletescriptable();
}

tryusehelperdroneearlyout(streakinfo, _id_D7F72825D583F8FE) {
  if(scripts\cp_mp\utility\player_utility::isusingremote())
    return 1;

  if(istrue(self.drones_disabled)) {
    if(istrue(_id_D7F72825D583F8FE)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/UNAVAILABLE");
    }

    return 1;
  }

  if(streakinfo.streakname == "radar_drone_recon") {
    _id_234BEA9EADDC1EDC = !isDefined(scripts\cp_mp\killstreaks\killstreakdeploy::candeploykillstreakweapon(streakinfo));

    if(!istrue(_id_234BEA9EADDC1EDC) && istrue(_id_D7F72825D583F8FE)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/CANNOT_USE_GENERIC");

      return 1;
    }
  }

  _id_9C16986EC4A8FF68 = _id_4ACD3DE63E55EB6C(streakinfo, _id_D7F72825D583F8FE);

  if(!_id_9C16986EC4A8FF68)
    return 1;

  _id_F2E9119C4FBA561A = _id_E4EA3048D91B5EB1(streakinfo, _id_D7F72825D583F8FE);

  if(!_id_F2E9119C4FBA561A) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]](1);

    return 1;
  }

  return 0;
}

delay_deletescriptable() {
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
  self delete();
}

createhelperdrone(startpos, startang, helperdronetype, streakinfo, nonvehicle, vehiclereserved) {
  clearvehiclereservation = !istrue(nonvehicle) && istrue(vehiclereserved);

  if(!isDefined(startpos)) {
    if(!istrue(clearvehiclereservation))
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  } else {
    config = level.helperdronesettings[helperdronetype];
    _id_B923287498A8519A = config.modelbase;
    drone = undefined;

    if(istrue(nonvehicle)) {
      drone = spawn("script_model", startpos);
      drone setModel(_id_B923287498A8519A);
      drone.nonvehicle = 1;
    } else {
      if(clearvehiclereservation)
        scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

      drone = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(self, startpos, startang, config.vehicleinfo, _id_B923287498A8519A);
    }

    if(!isDefined(drone)) {
      return;
    }
    drone enableaimassist();
    drone setnodeploy(1);
    drone.health = config.maxhealth;
    drone.maxhealth = config.maxhealth;
    drone.currenthealth = config.maxhealth;
    drone.damagetaken = 0;
    drone.speed = config.speed;
    drone.accel = config.accel;
    drone.angles = startang;
    drone.manualspeed = 50;
    drone.owner = self;
    drone.team = self.team;
    drone.helperdronetype = helperdronetype;
    drone.combatmode = config.primarymode;
    drone.currentstring = config.secondarymodestring;
    drone.streakinfo = streakinfo;
    drone._id_D0D1AF898ACDC9AF = "default";
    drone._id_52C3B4BC88132AEE = config._id_52C3B4BC88132AEE;
    drone.timeout = config.timeout;
    drone _id_49197CD063A740EA(::_id_BA1C5496F8FC5F67);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("helper_drone", "attachXRays"))
      drone = [[scripts\cp_mp\utility\script_utility::getsharedfunc("helper_drone", "attachXRays")]](drone);

    _id_7164F727CAF950CE = 0;

    if(istrue(drone.nonvehicle))
      drone scripts\mp\sentientpoolmanager::registersentient("Tactical_Moving", self, undefined, undefined, 0, 1);
    else {
      _id_7164F727CAF950CE = 1;
      drone thread _id_7C5C7844EB8DB8BB();
      drone setvehicleteam(drone.team);
    }

    if(istrue(drone._id_52C3B4BC88132AEE)) {
      scripts\cp_mp\utility\weapon_utility::setlockedoncallback(drone, ::helperdrone_lockedoncallback);
      scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback(drone, ::helperdrone_lockedonremovedcallback);
    }

    drone _id_CC4DD1078CF1B365(streakinfo.streakname);

    if(isDefined(config.flarescount))
      drone.flaresreservecount = config.flarescount;

    drone setotherent(self);
    drone setCanDamage(1);

    if(istrue(nonvehicle)) {
      drone scriptmoveroutline();
      drone scriptmoverthermal();
    } else {
      drone vehicle_invoketriggers(1);
      drone vehicle_breakglass(1);
    }

    _id_5AE5E6CD7F0CC727 = 12;

    switch (helperdronetype) {
      case "radar_drone_overwatch":
        _id_5AE5E6CD7F0CC727 = 60;
        break;
      case "scrambler_drone_escort":
        scrambler = drone helperdrone_spawnnewscrambler("medium");
        drone.scrambler = scrambler;
        break;
      case "scrambler_drone_guard":
        if(istrue(level.makedroneguardscrambler)) {
          scrambler = drone helperdrone_spawnnewscrambler("large");
          drone.scrambler = scrambler;
        }

        _id_5AE5E6CD7F0CC727 = 100;
        break;
      default:
        break;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList"))
      drone[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](streakinfo.streakname, "Killstreak_Air", drone.owner, 0, 1, _id_5AE5E6CD7F0CC727);

    drone.attract_strength = 10000;
    drone.attract_range = 150;
    drone.attractor = missile_createattractorent(drone, drone.attract_strength, drone.attract_range);
    drone.stunned = 0;
    drone.inactive = 0;
    drone thread helperdrone_play_lightfx();
    data = spawnStruct();
    data.validateaccuratetouching = 1;
    data.deathoverridecallback = ::helperdrone_moving_platform_death;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "handlemovingplatforms"))
      drone[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "handlemovingplatforms")]](data);

    if(isDefined(level.helperdronesettings[drone.helperdronetype].streakname)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent"))
        drone.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](config.streakname, drone.targetpos);
    }

    thread _id_4DCB82341876E985(_id_7164F727CAF950CE, drone);

    if(isDefined(level.elevators)) {
      foreach(elevators in level.elevators)
      elevators thread _id_5F903436642211AF::_id_5C07037726AE5001(drone);
    }
  }
}

_id_7C5C7844EB8DB8BB() {
  self endon("death");
  self.owner endon("disconnect");

  if(_id_C76228A77A70C9EA()) {
    return;
  }
  wait 5;
  scripts\mp\sentientpoolmanager::registersentient("Drone", self.owner);
  self notify("registered_sentient");
}

_id_C76228A77A70C9EA() {
  switch (self.helperdronetype) {
    case "radar_drone_recon":
      return 1;
    default:
      return 0;
  }
}

_id_4DCB82341876E985(_id_7164F727CAF950CE, drone) {
  drone endon("death");
  self endon("disconnect");

  if(istrue(_id_7164F727CAF950CE))
    drone waittill("registered_sentient");

  self _meth_FD165588822885F4(drone);
}

helperdrone_notifyenemyplayersinrange(helperdronetype, _id_3A932869EE475827) {
  _id_67C6AC74ED1FA737 = 3000;

  if(isDefined(_id_3A932869EE475827))
    _id_67C6AC74ED1FA737 = _id_3A932869EE475827;

  scripts\cp_mp\utility\killstreak_utility::_id_F772994FA2FB7FFC(self.owner, self.team, _id_67C6AC74ED1FA737, helperdronetype, self.origin);
}

helperdrone_handleteamvisibility() {
  foreach(player in level.players) {
    if(level.teambased && player.team == self.team || !level.teambased && player == self.owner)
      self hidefromplayer(player);
  }

  thread helperdrone_managevisibilityonteamjoin();
}

helperdrone_managevisibilityonteamjoin() {
  self endon("death");
  self endon("leaving");
  self endon("explode");

  for(;;) {
    level waittill("joined_team", player);

    if(level.teambased && player.team == self.team) {
      self hidefromplayer(player);
      continue;
    }

    self showtoplayer(player);
  }
}

_id_CC4DD1078CF1B365(streakname) {
  config = level.helperdronesettings[self.helperdronetype];

  if(!istrue(self.nonvehicle)) {
    _id_E25F9B0DE2CC7B81 = self;
    scorepopup = config.scorepopup;
    vodestroyed = config.vodestroyed;
    destroyedsplash = config.destroyedsplash;
    _id_8DFC256103CCE53E = config._id_0C25A8137257A96D;
    _id_191284E2E2837328 = config._id_F992CA11EF2B22BF;
    _id_BACC6DD14316758C = config.premoddamagefunc;
    _id_7DA88D9C69433487 = config.postmoddamagefunc;
    deathcallback = config.deathfunc;
    scripts\cp_mp\utility\killstreak_utility::_id_836A81868136192D(streakname, _id_E25F9B0DE2CC7B81, scorepopup, vodestroyed, destroyedsplash, _id_8DFC256103CCE53E, _id_191284E2E2837328, _id_BACC6DD14316758C, _id_7DA88D9C69433487, deathcallback);
    scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(self, self.owner, self.owner.team);
  }

  scripts\cp_mp\utility\killstreak_utility::_id_CFC5E3633EF950FD(1, self.maxhealth * 0.75, ::_id_F6914D06B20AEE20);
  scripts\cp_mp\utility\killstreak_utility::_id_CFC5E3633EF950FD(2, self.maxhealth * 0.5, ::_id_3AD98C4F7524B525);
  scripts\cp_mp\utility\killstreak_utility::_id_CFC5E3633EF950FD(3, self.maxhealth * 0.25, ::_id_E68A206899CAFBE5);
  self._id_96419179A661CF96 = ::_id_1A4B3B6063EC7390;
}

_id_1A4B3B6063EC7390(_id_1A914C651971E2F5, _id_D71630B8BAF84FA8) {
  if(!isDefined(_id_1A914C651971E2F5)) {
    return;
  }
  if(_id_D71630B8BAF84FA8 > 0) {
    if(istrue(_id_1A914C651971E2F5.isdestroyed)) {
      return;
    }
    _id_1A914C651971E2F5 thread _id_06EDFDA4764129E3(1);
  }
}

helperdrone_endscramblereffect() {
  self notify("scramble_super_finished");

  if(isDefined(self._id_88F72D2C0421F8B1) && self._id_88F72D2C0421F8B1.size > 0) {
    foreach(enemy in self._id_88F72D2C0421F8B1) {
      if(isDefined(enemy)) {
        _id_A2AA6CE7E3A5AC0C = enemy;

        if(isDefined(_id_A2AA6CE7E3A5AC0C.owner))
          _id_A2AA6CE7E3A5AC0C = _id_A2AA6CE7E3A5AC0C.owner;

        _id_A2AA6CE7E3A5AC0C notify("scramble_off" + self getentitynumber());
      }
    }
  }

  if(isDefined(self.friendliesaffectedbyscrambler) && self.friendliesaffectedbyscrambler.size > 0) {
    foreach(_id_3E2EF879EE8848E2 in self.friendliesaffectedbyscrambler) {
      if(isDefined(_id_3E2EF879EE8848E2))
        _id_3E2EF879EE8848E2 notify("scramble_off" + self getentitynumber());
    }
  }
}

helperdrone_watchscramblereffectdist(owner) {
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("scramble_super_finished");

  if(!isDefined(owner))
    owner = self.owner;

  self._id_88F72D2C0421F8B1 = [];
  _id_04EFAF0D84225539 = 0;
  _id_105FCA5E47D7EE56 = getdvarfloat("compassscramblerradius", 1000);
  _id_F3B7CC3138382DFB = _id_105FCA5E47D7EE56 * _id_105FCA5E47D7EE56;
  _id_556DB0B72A96514E = physics_createcontents(["physicscontents_characterproxy"]);
  _id_863C619037F3AC74 = self.origin - (0, 0, 3000);
  _id_B65B7AEAB526E1AC = (_id_105FCA5E47D7EE56, _id_105FCA5E47D7EE56, 3000);
  _id_80745CF3E2877DF5 = _id_863C619037F3AC74 - _id_B65B7AEAB526E1AC;
  _id_809746F3E2AD954B = _id_863C619037F3AC74 + _id_B65B7AEAB526E1AC;

  for(;;) {
    _id_E5B984FC3E961023 = physics_aabbbroadphasequery(_id_80745CF3E2877DF5, _id_809746F3E2AD954B, _id_556DB0B72A96514E, []);

    foreach(_id_D5DB6D3276688D8F in _id_E5B984FC3E961023) {
      _id_780166328E815D00 = 0;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk"))
        _id_780166328E815D00 = _id_D5DB6D3276688D8F[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_scrambler_resist");

      if(isDefined(_id_D5DB6D3276688D8F) && _id_D5DB6D3276688D8F scripts\cp_mp\utility\player_utility::_isalive() && !_id_780166328E815D00) {
        if(distance2dsquared(self.origin, _id_D5DB6D3276688D8F.origin) > _id_F3B7CC3138382DFB) {
          continue;
        }
        if(_id_04EFAF0D84225539 || level.teambased && _id_D5DB6D3276688D8F.team != self.team && _id_D5DB6D3276688D8F.team != "spectator" || !level.teambased && _id_D5DB6D3276688D8F != self.owner) {
          if(_id_D5DB6D3276688D8F scripts\cp_mp\utility\player_utility::isusingremote()) {
            continue;
          }
          if(_id_D5DB6D3276688D8F helperdrone_entaffectedbyscramble(self, _id_04EFAF0D84225539)) {
            continue;
          }
          _id_D5DB6D3276688D8F helperdrone_setscramblerjammed(1, self, _id_04EFAF0D84225539);
        }

        continue;
      }

      if(isDefined(_id_D5DB6D3276688D8F.scrambledby) && scripts\engine\utility::array_contains(_id_D5DB6D3276688D8F.scrambledby, self))
        _id_D5DB6D3276688D8F notify("scramble_off" + self getentitynumber());
    }

    waitframe();
  }
}

helperdrone_setscramblerplayerbuffs(_id_2327284215F2EB30, _id_5E3A489F0B2B59A5) {
  if(helperdrone_entaffectedbyscramble(_id_5E3A489F0B2B59A5) && istrue(_id_2327284215F2EB30)) {
    return;
  }
  if(istrue(_id_2327284215F2EB30)) {
    _id_5E3A489F0B2B59A5.friendliesaffectedbyscrambler[_id_5E3A489F0B2B59A5.friendliesaffectedbyscrambler.size] = self;
    thread helperdrone_managescramblerplayerbuff(_id_5E3A489F0B2B59A5);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "givePerk"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "givePerk")]]("specialty_blindeye");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "givePerk"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "givePerk")]]("specialty_noscopeoutline");
  } else if(isDefined(self)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "removePerk"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "removePerk")]]("specialty_blindeye");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "removePerk"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "removePerk")]]("specialty_noscopeoutline");
  }
}

helperdrone_managescramblerplayerbuff(_id_5E3A489F0B2B59A5) {
  scripts\engine\utility::waittill_any_2("death_or_disconnect", "scramble_off" + _id_5E3A489F0B2B59A5 getentitynumber());
  helperdrone_setscramblerplayerbuffs(0, _id_5E3A489F0B2B59A5);
}

helperdrone_setscramblerjammed(_id_28E6DF0414CB4897, _id_479E3F358A1F244E, _id_04EFAF0D84225539, _id_699323575339379A) {
  _id_682BF17FA458886C = self;

  if(istrue(_id_28E6DF0414CB4897)) {
    _id_682BF17FA458886C.scrambledby = scripts\engine\utility::_id_53C4C53197386572(_id_682BF17FA458886C.scrambledby, []);
    _id_682BF17FA458886C.scrambledby = scripts\engine\utility::_id_6D6AF8144A5131F1(_id_682BF17FA458886C.scrambledby, _id_479E3F358A1F244E);

    if(!scripts\engine\utility::array_contains(_id_479E3F358A1F244E._id_88F72D2C0421F8B1, _id_682BF17FA458886C))
      _id_479E3F358A1F244E._id_88F72D2C0421F8B1[_id_479E3F358A1F244E._id_88F72D2C0421F8B1.size] = _id_682BF17FA458886C;

    _id_682BF17FA458886C thread helperdrone_managescramblereffect(_id_479E3F358A1F244E, _id_04EFAF0D84225539, _id_699323575339379A);
    _id_682BF17FA458886C thread helperdrone_watchscramblestrength(_id_479E3F358A1F244E, _id_699323575339379A);
  } else if(isDefined(_id_479E3F358A1F244E) && isDefined(_id_682BF17FA458886C) && isDefined(_id_682BF17FA458886C.scrambledby)) {
    if(scripts\engine\utility::array_contains(_id_682BF17FA458886C.scrambledby, _id_479E3F358A1F244E)) {
      _id_682BF17FA458886C.scrambledby = scripts\engine\utility::array_remove(_id_682BF17FA458886C.scrambledby, _id_479E3F358A1F244E);

      if(isDefined(_id_479E3F358A1F244E._id_EF42676D437AB065)) {
        _id_8CE1ABD1A0602291 = _id_479E3F358A1F244E._id_EF42676D437AB065[self getentitynumber()];

        if(isDefined(_id_8CE1ABD1A0602291)) {
          _id_479E3F358A1F244E._id_EF42676D437AB065[self getentitynumber()] = undefined;
          _id_682BF17FA458886C scripts\cp_mp\emp_debuff::_id_AE54EEE1DC461971(_id_8CE1ABD1A0602291, _id_699323575339379A);
          _id_479E3F358A1F244E._id_EF42676D437AB065[_id_682BF17FA458886C getentitynumber()] = undefined;
        }
      }
    }
  }
}

helperdrone_managescramblereffect(_id_479E3F358A1F244E, _id_04EFAF0D84225539, _id_699323575339379A) {
  level endon("game_ended");
  scripts\engine\utility::waittill_any_2("death", "scramble_off" + _id_479E3F358A1F244E getentitynumber());

  if(isDefined(self)) {
    helperdrone_setscramblerjammed(0, _id_479E3F358A1F244E, _id_04EFAF0D84225539, _id_699323575339379A);

    if(isDefined(_id_479E3F358A1F244E) && isDefined(_id_479E3F358A1F244E._id_88F72D2C0421F8B1))
      _id_479E3F358A1F244E._id_88F72D2C0421F8B1 = scripts\engine\utility::array_remove(_id_479E3F358A1F244E._id_88F72D2C0421F8B1, self);
  } else if(isDefined(_id_479E3F358A1F244E) && isDefined(_id_479E3F358A1F244E._id_88F72D2C0421F8B1))
    _id_479E3F358A1F244E._id_88F72D2C0421F8B1 = scripts\engine\utility::array_removeundefined(_id_479E3F358A1F244E._id_88F72D2C0421F8B1);
}

helperdrone_watchremotescrambledent(_id_479E3F358A1F244E, _id_04EFAF0D84225539) {
  _id_479E3F358A1F244E endon("death");
  level endon("game_ended");
  self waittill("death");

  if(isDefined(self.owner)) {
    if(self.owner helperdrone_entaffectedbyscramble(_id_479E3F358A1F244E, _id_04EFAF0D84225539))
      self.owner helperdrone_setscramblerjammed(0, _id_479E3F358A1F244E, _id_04EFAF0D84225539);
  }
}

helperdrone_watchscramblestrength(_id_479E3F358A1F244E, _id_699323575339379A) {
  self endon("death");
  self endon("scramble_off" + self getentitynumber());
  self endon("disconnect");
  _id_479E3F358A1F244E endon("death");
  _id_479E3F358A1F244E._id_EF42676D437AB065 = scripts\engine\utility::_id_53C4C53197386572(_id_479E3F358A1F244E._id_EF42676D437AB065, []);
  _id_D0F37CCCE4E88C3D = 0;
  _id_8CE1ABD1A0602291 = 0;
  _id_105FCA5E47D7EE56 = getdvarfloat("compassscramblerradius", 1000);

  if(isDefined(_id_479E3F358A1F244E._id_32EFB854DF6D5296))
    _id_105FCA5E47D7EE56 = _id_479E3F358A1F244E._id_32EFB854DF6D5296;

  _id_F3B7CC3138382DFB = _id_105FCA5E47D7EE56 * _id_105FCA5E47D7EE56;

  for(;;) {
    _id_3BF809E113AE4C12 = 0;

    if(istrue(_id_479E3F358A1F244E._id_CE8EF6E68DF034C7))
      _id_3BF809E113AE4C12 = distancesquared(_id_479E3F358A1F244E.origin, self.origin);
    else
      _id_3BF809E113AE4C12 = distance2dsquared(_id_479E3F358A1F244E.origin, self.origin);

    if(_id_3BF809E113AE4C12 > _id_F3B7CC3138382DFB)
      _id_8CE1ABD1A0602291 = 0;
    else if(_id_3BF809E113AE4C12 >= _id_F3B7CC3138382DFB * 0.8)
      _id_8CE1ABD1A0602291 = 1;
    else if(_id_3BF809E113AE4C12 >= _id_F3B7CC3138382DFB * 0.6)
      _id_8CE1ABD1A0602291 = 2;
    else if(_id_3BF809E113AE4C12 >= _id_F3B7CC3138382DFB * 0.4)
      _id_8CE1ABD1A0602291 = 3;
    else if(_id_3BF809E113AE4C12 >= _id_F3B7CC3138382DFB * 0.2)
      _id_8CE1ABD1A0602291 = 4;
    else
      _id_8CE1ABD1A0602291 = 5;

    _id_4893B9A18CF47D6C = _id_8CE1ABD1A0602291 != _id_D0F37CCCE4E88C3D;

    if(_id_D0F37CCCE4E88C3D == 0 || _id_4893B9A18CF47D6C) {
      _id_479E3F358A1F244E._id_EF42676D437AB065[self getentitynumber()] = _id_8CE1ABD1A0602291;
      scripts\cp_mp\emp_debuff::_id_AE54EEE1DC461971(_id_D0F37CCCE4E88C3D, _id_699323575339379A);
      scripts\cp_mp\emp_debuff::_id_73FD4DD382874EF7(_id_8CE1ABD1A0602291, _id_699323575339379A);
      _id_D0F37CCCE4E88C3D = _id_8CE1ABD1A0602291;
    }

    waitframe();
  }
}

helperdrone_entaffectedbyscramble(_id_4BD0CE1C61384825, _id_04EFAF0D84225539) {
  scrambled = 0;
  _id_0BE77424D6EF051C = undefined;

  if(isDefined(level.supportdrones) && level.supportdrones.size > 0) {
    foreach(drone in level.supportdrones) {
      if(drone.helperdronetype != "scrambler_drone_guard") {
        continue;
      }
      if(level.teambased) {
        if(!isDefined(_id_04EFAF0D84225539) && drone.team == self.team)
          _id_0BE77424D6EF051C = drone.friendliesaffectedbyscrambler;
        else
          _id_0BE77424D6EF051C = drone._id_88F72D2C0421F8B1;
      } else if(!isDefined(_id_04EFAF0D84225539) && drone.owner == self)
        _id_0BE77424D6EF051C = drone.friendliesaffectedbyscrambler;
      else
        _id_0BE77424D6EF051C = drone._id_88F72D2C0421F8B1;

      if(!isDefined(_id_0BE77424D6EF051C)) {
        continue;
      }
      if(_id_0BE77424D6EF051C.size > 0) {
        foreach(ent in _id_0BE77424D6EF051C) {
          if(self == ent || isDefined(ent.owner) && self == ent.owner) {
            scrambled = 1;
            break;
          }
        }

        if(istrue(scrambled)) {
          break;
        }
      }
    }
  }

  return scrambled;
}

helperdrone_enableradar(_id_2DBCBBE66AA95FAF) {
  radar = spawn("script_model", self.origin);
  radar.owner = self.owner;
  radar.team = self.owner.team;
  self.radar = radar;

  if(_id_2DBCBBE66AA95FAF == "auto_radar")
    radar makeportableradar(self.owner);
  else if(_id_2DBCBBE66AA95FAF == "escort_radar") {
    radar setentityowner(self.owner);
    radar setotherent(self.owner);
    radar setModel("ks_radar_drone_escort_mp");
  }

  radar linkTo(self);
}

helperdrone_disableradar() {
  if(isDefined(self.radar))
    self.radar delete();
}

helperdrone_spawnnewscrambler(_id_07F0BBC79E1DAE81, _id_E9FFA55994E4C9BE, _id_EE91862B850C90E5) {
  scrambler = spawn("script_model", self.origin);
  scrambler.team = self.owner.team;
  scrambler makescrambler(self.owner, _id_07F0BBC79E1DAE81);
  scrambler linkTo(self);
  return scrambler;
}

helperdrone_moving_platform_death(data) {
  if(!isDefined(data.lasttouchedplatform.destroydroneoncollision) || data.lasttouchedplatform.destroydroneoncollision)
    self notify("death");
}

helperdrone_play_lightfx() {
  settings = level.helperdronesettings[self.helperdronetype];

  if(isent(self)) {
    if(isDefined(settings.playfxcallback))
      self[[settings.playfxcallback]]();
  }
}

_id_56966B077270A18E() {
  self setscriptablepartstate("lights", "on", 0);

  if(self.helperdronetype == "radar_drone_overwatch") {
    self setscriptablepartstate("glint", "on", 0);
    self setscriptablepartstate("engine", "on", 0);
  }

  if(self.helperdronetype == "radar_drone_recon")
    self setscriptablepartstate("glint", "on", 0);

  if(self.helperdronetype == "ammo_drop")
    self setscriptablepartstate("glint", "on", 0);
}

starthelperdrone(helperdrone) {
  level endon("game_ended");
  helperdrone endon("death");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();

  config = level.helperdronesettings[helperdrone.helperdronetype];
  helperdrone thread _id_207C13CDC424E93B();
  helperdrone.owner setclientomnvar("ui_killstreak_health", helperdrone.currenthealth / helperdrone.maxhealth);
  helperdrone.owner setclientomnvar("ui_killstreak_damage_state", 0);
  helperdrone thread helperdrone_watchtimeout();
  helperdrone thread helperdrone_watchownerloss();
  helperdrone thread helperdrone_watchownerdeath();
  helperdrone thread helperdrone_watchroundend();
  helperdrone thread helperdrone_destroyongameend();
  helperdrone setCanDamage(1);

  if(isDefined(config.damagemonitorfunc))
    helperdrone thread[[config.damagemonitorfunc]]();

  if(istrue(_id_DE3C015E3C7130E7(helperdrone.helperdronetype))) {
    helperdrone thread helperdrone_monitorcollision(config);
    helperdrone thread _id_109F8639AEBF2DA9(config);
    helperdrone thread helperdrone_watchearlyexit(config);
    helperdrone thread _id_1D24E8F818E18244();

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
      gametype = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();

      if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
        helperdrone thread helperdrone_watchaltitude(self);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "registerEntForOOB"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "registerEntForOOB")]](helperdrone, "killstreak");

    helperdrone thread _id_B25CED7F149BE057();
  }

  helperdrone thread[[config.primarymodefunc]](config);
}

helperdrone_followplayer(_id_42A0537F1AE3E42E) {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("target_assist");
  self endon("player_defend");

  if(!isDefined(self.owner)) {
    thread helperdrone_leave();
    return;
  }

  self.owner endon("disconnect");
  self endon("owner_gone");

  for(;;) {
    _id_0E85BB71774631A2 = self.owner getstance();

    if(!isDefined(self.last_owner_stance) || _id_0E85BB71774631A2 != self.last_owner_stance || istrue(self.stoppedatlocation)) {
      if(istrue(self.stoppedatlocation))
        self.stoppedatlocation = undefined;

      self.last_owner_stance = _id_0E85BB71774631A2;
      helperdrone_movetoplayer(self.owner, _id_42A0537F1AE3E42E);
    }

    wait 0.5;
  }
}

helperdrone_overwatchplayer() {
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "showMiniMap"))
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "showMiniMap")]]();

  self.owner.showuavminimaponspawn = 1;
  self.owner thread helperdrone_showminimaponspawn(self);
  _id_0BB89186DC852508 = 1;
  self vehicle_setspeed(200, 50, 10);

  for(;;) {
    _id_691AA1D5DA533612 = undefined;

    if(istrue(_id_0BB89186DC852508)) {
      _id_0454EBDDE3D9DCF4 = self.origin;
      _id_2ECA7B12D2EE27BA = self.owner.origin * (1, 1, 0) + (0, 0, self.origin[2]);
      _id_691AA1D5DA533612 = scripts\engine\trace::ray_trace(_id_0454EBDDE3D9DCF4, _id_2ECA7B12D2EE27BA, self);
    }

    _id_81954D580B24281B = self.owner.origin[0];
    _id_E4F34F3A01C6FFF2 = self.owner.origin[1];

    if(isDefined(_id_691AA1D5DA533612)) {
      if(_id_691AA1D5DA533612["hittype"] != "hittype_none") {
        _id_81954D580B24281B = _id_691AA1D5DA533612["position"][0];
        _id_E4F34F3A01C6FFF2 = _id_691AA1D5DA533612["position"][1];
      }
    }

    _id_7504C8791E34DC73 = getcorrectheight(_id_81954D580B24281B, _id_E4F34F3A01C6FFF2, 20);
    _id_6E281DBD69FC980E = (_id_81954D580B24281B, _id_E4F34F3A01C6FFF2, _id_7504C8791E34DC73);
    self setlookatent(self.owner);
    self setvehgoalpos(_id_6E281DBD69FC980E, 1);
    scripts\engine\utility::waittill_any_2("goal", "begin_evasive_maneuvers");

    if(istrue(_id_0BB89186DC852508)) {
      _id_0BB89186DC852508 = undefined;
      self vehicle_setspeed(level.helperdronesettings[self.helperdronetype].speed, 10, 10);
    }

    self clearlookatent();
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
  }
}

getcorrectheight(x, y, _id_00AE14C5A8B1B582) {
  _id_DC8BB6300463CF1E = 1500;
  _id_E7A7D619F927D791 = tracegroundpoint(x, y);
  _id_1DC672CFE0F0128E = _id_E7A7D619F927D791 + _id_DC8BB6300463CF1E;
  _id_1DC672CFE0F0128E = _id_1DC672CFE0F0128E + randomint(_id_00AE14C5A8B1B582);
  return _id_1DC672CFE0F0128E;
}

tracegroundpoint(x, y) {
  self endon("death");
  self endon("leaving");
  z = -99999;
  _id_E531AFBE1391F499 = self.origin[2] + 2000;
  _id_3C590B0EE220AFA3 = level.averagealliesz;
  ignorelist = [self];
  _id_E96577032A7740FC = scripts\engine\trace::sphere_trace((x, y, _id_E531AFBE1391F499), (x, y, z), 256, ignorelist, undefined, 1);

  if(_id_E96577032A7740FC["position"][2] < _id_3C590B0EE220AFA3)
    _id_0FA83E3A4C4E6902 = _id_3C590B0EE220AFA3;
  else
    _id_0FA83E3A4C4E6902 = _id_E96577032A7740FC["position"][2];

  return _id_0FA83E3A4C4E6902;
}

helperdrone_pingnearbyenemies() {
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  _id_91B19ADF7D92417C = 300;
  _id_4EAB3940342455CC = 1200;

  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    _id_91B19ADF7D92417C = 1000;
    _id_4EAB3940342455CC = 2500;
  }

  self.pingedenemies = [];

  for(;;) {
    _id_EF269077A28646EB = scripts\common\utility::playersinsphere(self.owner.origin, _id_4EAB3940342455CC);

    foreach(player in _id_EF269077A28646EB) {
      if(player == self.owner) {
        continue;
      }
      if(level.teambased && player.team == self.owner.team) {
        continue;
      }
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
        if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](player))
          continue;
      }

      if(player helperdrone_isbeingpingedbydrone(self)) {
        continue;
      }
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
        if(player[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_ghost"))
          continue;
      }

      triggerportableradarping(player.origin, self.owner, _id_91B19ADF7D92417C, 3000);
      thread helperdrone_watchpingedstatus(player, self.owner);
    }

    waitframe();
  }
}

helperdrone_watchpingedstatus(_id_77380882CCBFE2F5, _id_2D1828E3F6DF9C24) {
  self endon("death");
  _id_77380882CCBFE2F5 endon("disconnect");
  level endon("game_ended");

  if(isDefined(_id_2D1828E3F6DF9C24))
    _id_77380882CCBFE2F5 playsoundtoplayer("recondrone_marker", _id_2D1828E3F6DF9C24);

  self.pingedenemies[self.pingedenemies.size] = _id_77380882CCBFE2F5;
  _id_77380882CCBFE2F5 scripts\engine\utility::waittill_any_timeout_1(3, "death");
  self.pingedenemies = scripts\engine\utility::array_remove(self.pingedenemies, _id_77380882CCBFE2F5);
}

helperdrone_isbeingpingedbydrone(drone) {
  _id_5000BB58F1128C5C = 0;

  foreach(enemy in drone.pingedenemies) {
    if(isDefined(enemy) && self == enemy) {
      _id_5000BB58F1128C5C = 1;
      break;
    }
  }

  return _id_5000BB58F1128C5C;
}

helperdrone_getheightoffset(config) {
  heightoffset = config.standupoffset;
  _id_E8BE66AEC958DE65 = self.owner getstance();

  switch (_id_E8BE66AEC958DE65) {
    case "stand":
      heightoffset = config.standupoffset;
      break;
    case "crouch":
      heightoffset = config.crouchupoffset;
      break;
    case "prone":
      heightoffset = config.proneupoffset;
      break;
  }

  return heightoffset;
}

helperdrone_guardlocation() {
  self.stoppedatlocation = 1;
  _id_1FA6573B990BCD4A = int(self.origin[2] * 0.65);
  _id_1BECBC015340BF8D = self.mappointinfo[0].location + (0, 0, _id_1FA6573B990BCD4A);
  _id_2113D7B30B4928CE = scripts\engine\trace::sphere_trace(self.origin, _id_1BECBC015340BF8D, 200, self);

  if(isDefined(_id_2113D7B30B4928CE)) {
    if(isDefined(_id_2113D7B30B4928CE["entity"])) {
      _id_1BECBC015340BF8D = _id_2113D7B30B4928CE["entity"].origin + (0, 0, randomintrange(100, 200));

      if(isDefined(_id_2113D7B30B4928CE["entity"].guardlocation))
        _id_1BECBC015340BF8D = _id_2113D7B30B4928CE["entity"].guardlocation + (0, 0, randomintrange(100, 200));
    } else if(isDefined(_id_2113D7B30B4928CE["hittype"]) && isDefined(_id_2113D7B30B4928CE["position"]) && _id_2113D7B30B4928CE["hittype"] != "hittype_none")
      _id_1BECBC015340BF8D = _id_2113D7B30B4928CE["position"] + (0, 0, randomintrange(300, 500));
  }

  thread helperdrone_moveintoplace(_id_1BECBC015340BF8D);
  self.guardlocation = _id_1BECBC015340BF8D;
}

helperdrone_moveintoplace(_id_1BECBC015340BF8D) {
  self endon("death");
  level endon("game_ended");
  self setscriptablepartstate("rotors", "on", 0);
  self playLoopSound("veh_scrambler_drone_idle_high");
  self moveTo(_id_1BECBC015340BF8D - (0, 0, 20), 3, 2, 1);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3.2);
  self moveTo(_id_1BECBC015340BF8D, 1, 0.5, 0.5);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1.2);

  for(;;) {
    _id_803270B249D3FE99 = randomintrange(-35, 35);
    _id_5FE85DAEEC942414 = randomintrange(-15, 15);
    _id_12B839D2A79160E2 = _id_1BECBC015340BF8D[0] + _id_803270B249D3FE99;
    _id_12B83AD2A7916315 = _id_1BECBC015340BF8D[1] + _id_803270B249D3FE99;
    _id_12B837D2A7915C7C = _id_1BECBC015340BF8D[2] + _id_5FE85DAEEC942414;
    _id_07CD652E507BF980 = (_id_12B839D2A79160E2, _id_12B83AD2A7916315, _id_12B837D2A7915C7C);
    self moveTo(_id_07CD652E507BF980, 3, 2, 1);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3.2);
  }
}

helperdrone_watchradarpulse() {
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");

  for(;;) {
    triggerportableradarping(self.origin, self.owner);
    self.owner playSound("oracle_radar_pulse_npc");
    wait 3;
  }
}

helperdrone_movetoplayer(player, _id_42A0537F1AE3E42E) {
  self setlookatent(player);
  targetoffset = helperdrone_gettargetoffset(self, player);

  if(isDefined(_id_42A0537F1AE3E42E))
    targetoffset = _id_42A0537F1AE3E42E;

  self setdronegoalent(player, targetoffset, 16, 10);
  self.intransit = 1;
  thread helperdrone_watchforgoal();
}

helperdrone_watchmodeswitch() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self endon("owner_gone");
  config = level.helperdronesettings[self.helperdronetype];

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "setKillstreakControlPriority"))
    self.useobj[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "setKillstreakControlPriority")]](self.owner, self.currentstring, 360, 360, 30000, 30000, 3);

  for(;;) {
    self.useobj waittill("trigger", player);

    if(player != self.owner) {
      continue;
    }
    if(self.owner scripts\cp_mp\utility\player_utility::isusingremote()) {
      continue;
    }
    if(!self.owner _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("usability")) {
      continue;
    }
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("entity", "isTouchingBoundsTrigger")) {
      if([[scripts\cp_mp\utility\script_utility::getsharedfunc("entity", "isTouchingBoundsTrigger")]](self.owner))
        continue;
    }

    _id_23B90B34FECC58CD = 0;
    result = undefined;
    _id_038FC7BD1495C4B2 = level.framedurationseconds;

    while(self.owner useButtonPressed()) {
      _id_23B90B34FECC58CD = _id_23B90B34FECC58CD + _id_038FC7BD1495C4B2;

      if(_id_23B90B34FECC58CD > 0.1) {
        self notify("switch_modes");
        _id_8CFA25D4A75D07EA = getothermode(self.combatmode, self.streakinfo);
        _id_E30EE4AE67D05D90 = "Empty String";

        if(_id_8CFA25D4A75D07EA == config.primarymode) {
          result = [[config.primarymodefunc]](config);
          _id_E30EE4AE67D05D90 = config.secondarymodestring;
        } else {
          result = [[config.secondarymodefunc]](config);
          _id_E30EE4AE67D05D90 = config.primarymodestring;
        }

        if(!istrue(result)) {
          return;
        }
        self.combatmode = _id_8CFA25D4A75D07EA;
        self.currentstring = _id_E30EE4AE67D05D90;
        self.useobj makeunusable();
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "setKillstreakControlPriority"))
          self.useobj[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "setKillstreakControlPriority")]](self.owner, self.currentstring, 360, 360, 30000, 30000, 3);

        break;
      }

      wait(_id_038FC7BD1495C4B2);
    }

    wait(_id_038FC7BD1495C4B2);
  }
}

getothermode(mode, streakinfo) {
  config = level.helperdronesettings[self.helperdronetype];

  if(mode == config.primarymode)
    mode = config.secondarymode;
  else
    mode = config.primarymode;

  return mode;
}

setescortmodesettings(config) {
  self vehicle_setspeed(self.speed, self.accel);
  self setyawspeed(120, 90);
  self setneargoalnotifydist(16);
  self sethoverparams(30, 10, 5);
  self setturningability(1);
  self setdroneturnparams(50, 1.3, 30, 20);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "showMiniMap"))
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "showMiniMap")]]();

  self.owner thread helperdrone_showminimaponspawn(self);
  helperdrone_enableradar("escort_radar");
  thread helperdrone_followplayer();
  return 1;
}

_id_207C13CDC424E93B() {
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  level endon("game_ended");
  timeoutduration = self.timeout;
  timeelapsed = 0;

  if(!isDefined(self.timeout)) {
    return;
  }
  self.owner setclientomnvar("ui_killstreak_countdown", 100);

  while(timeelapsed < timeoutduration) {
    _id_77B3F0514A25C019 = (timeoutduration - timeelapsed) / timeoutduration;
    _id_77B3F0514A25C019 = int(ceil(clamp(_id_77B3F0514A25C019, 0, 1) * 100));

    if(istrue(self.ispiloted))
      self.owner setclientomnvar("ui_killstreak_countdown", _id_77B3F0514A25C019);

    timeelapsed = timeelapsed + level.framedurationseconds;
    waitframe();
  }
}

helperdrone_lockedoncallback() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("missileLocking", self.owner, "killstreak");
}

helperdrone_lockedonremovedcallback() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("missileLocking", self.owner, "killstreak");
}

setoverwatchmodesettings(config) {
  thread helperdrone_overwatchplayer();
  thread helperdrone_pingnearbyenemies();
  helperdrone_handleteamvisibility();
  return 1;
}

setfollowmode(config) {
  thread helperdrone_followplayer();
  return 1;
}

setguardmode(config) {
  if(isent(self)) {
    helperdrone_guardlocation();
    helperdrone_handleteamvisibility();
    _id_1532EAE4FC92C4D3();
    self scriptmodelplayanim(level.scr_animname["scrambler_drone_guard"]["rotor_spin"]);
  }

  scramblerdrone_counteruavmodeon();
  return 1;
}

_id_1532EAE4FC92C4D3() {
  self setscriptablepartstate("looping_wave", "on", 0);
  self setscriptablepartstate("scramble_sfx", "on", 0);
}

setdeliverymodesettings(config) {
  thread helperdrone_deliver(config);
  return 1;
}

helperdrone_deliver(config) {
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self setneargoalnotifydist(10);
  speed = level.helperdronesettings[self.helperdronetype].speed;
  accel = level.helperdronesettings[self.helperdronetype].accel;
  self vehicle_setspeed(speed, accel, accel);
  _id_14E71B3B3DBF761C = self.deliverytarget + (0, 0, 4000);
  startpos = self.deliverytarget + (0, 0, 2500);
  endpos = self.deliverytarget + (0, 0, 100);
  halfsize = level.helperdronesettings[self.helperdronetype].halfsize;
  ignoreents = [];
  ignoreents[0] = self;
  contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1);
  _id_1F0571D36D0DF95B = scripts\engine\trace::sphere_trace(startpos, endpos, halfsize, ignoreents, contentoverride, 0);
  _id_5BF3E22BDB650432 = _id_1F0571D36D0DF95B["shape_position"] + (0, 0, 100);
  self setvehgoalpos(_id_5BF3E22BDB650432, 1);
  self waittill("goal");
  wait 0.5;
  [[self.ondelivercallback]]();
  self vehicle_setspeedimmediate(2);
  self vehicle_setspeed(0.1, 1, 1);
  wait 0.5;
  self vehicle_setspeed(speed, accel, accel);
  self setvehgoalpos(_id_14E71B3B3DBF761C, 0);
  self waittill("goal");
  _id_608250000FBFC89A(self.helperdronetype, config, 0);
}

helperdrone_watchearlyexit(config) {
  self.owner endon("disconnect");
  self endon("death");
  self endon("explode");

  for(;;) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "allowRideKillstreakPlayerExit"))
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "allowRideKillstreakPlayerExit")]]("leaving");

    self waittill("killstreakExit");

    if(!istrue(self.ispiloted)) {
      continue;
    }
    if(isDefined(config._id_BE3314F77FEF5D6B)) {
      self notify("drone_exit");
      self[[config._id_BE3314F77FEF5D6B]]();
      continue;
    }

    helperdrone_leave();
  }
}

_id_1D24E8F818E18244() {
  level endon("game_ended");
  _id_6D5A295AE3C46554 = self.owner;
  _id_6D5A295AE3C46554 endon("disconnect");
  _id_B2D2806C761E0C98 = 1;

  if(istrue(_id_B2D2806C761E0C98))
    _id_6D5A295AE3C46554 _id_6A275656141AC8D6(self);

  thread helperdrone_handlethermalswitchinternal();
}

helperdrone_handlethermalswitchinternal() {
  _id_6D5A295AE3C46554 = self.owner;
  _id_6D5A295AE3C46554 endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self.isthermalenabled = 0;
  _id_093B54405FDA960C = scripts\cp_mp\utility\killstreak_utility::_id_44E0BD95B98288AB();

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    self.isthermalenabled = 1;
    _id_6D5A295AE3C46554 scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785(_id_093B54405FDA960C);
    _id_6D5A295AE3C46554 scripts\cp_mp\utility\player_utility::setthermalvision(1, 12, 1000);
  }

  for(;;) {
    _id_6D5A295AE3C46554 waittill("switch_thermal_mode");

    if(!istrue(self.ispiloted)) {
      continue;
    }
    if(self.isthermalenabled) {
      self.isthermalenabled = 0;
      _id_6D5A295AE3C46554 scripts\cp_mp\utility\player_utility::setthermalvision(0);
      _id_6D5A295AE3C46554 _id_6A275656141AC8D6(self);
      _id_6D5A295AE3C46554 playlocalsound("weap_thermal_toggle_click");
      continue;
    }

    self.isthermalenabled = 1;
    _id_6D5A295AE3C46554 scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785(_id_093B54405FDA960C);
    _id_6D5A295AE3C46554 scripts\cp_mp\utility\player_utility::setthermalvision(1, 12, 1000);
    _id_6D5A295AE3C46554 playlocalsound("weap_thermal_toggle_click");
  }
}

_id_6A275656141AC8D6(drone) {
  _id_143BA8C547269A07 = level.helperdronesettings[drone.helperdronetype];

  if(level.mapname == "mp_hideout")
    scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785(_id_143BA8C547269A07._id_2215FA459D8250C0);
  else
    scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785(_id_143BA8C547269A07._id_A117852275E49E64);
}

helperdrone_monitorcollision(config) {
  self.owner endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("explode");

  for(;;) {
    self waittill("touch", ent);

    if(!isDefined(ent)) {
      continue;
    }
    vehicle = undefined;

    if(ent scripts\cp_mp\vehicles\vehicle::isvehicle())
      vehicle = ent;
    else if(ent scripts\cp_mp\utility\player_utility::isinvehicle())
      vehicle = ent.vehicle;

    if(!isDefined(vehicle)) {
      continue;
    }
    attacker = undefined;
    inflictor = undefined;

    if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, vehicle.owner))) {
      currentvehicle = vehicle.owner scripts\cp_mp\utility\player_utility::getvehicle();

      if(isDefined(currentvehicle) && currentvehicle == vehicle) {
        attacker = vehicle.owner;
        inflictor = vehicle;
      }
    }

    self dodamage(self.maxhealth, vehicle.origin, attacker, inflictor, "MOD_CRUSH");
    break;
  }
}

_id_109F8639AEBF2DA9(config) {
  self.owner endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  _id_0741196A281686EE = ["physicscontents_water"];
  contentoverride = physics_createcontents(_id_0741196A281686EE);
  self._id_51AB77B2BA57C5DD = 0;

  for(;;) {
    _id_B4331A150334BF61 = physics_querypoint(self.origin, 0, contentoverride, self, "physicsquery_any");

    if(istrue(_id_B4331A150334BF61) && !istrue(self._id_51AB77B2BA57C5DD)) {
      self._id_51AB77B2BA57C5DD = 1;
      attacker = self.owner;
      inflictor = self;
      self dodamage(10000, self.origin, attacker, inflictor, "MOD_CRUSH");
      break;
    } else if(!istrue(_id_B4331A150334BF61) && istrue(self._id_51AB77B2BA57C5DD)) {
      self._id_51AB77B2BA57C5DD = 0;
      self vehicle_setspeed(100, 10);
      self setyawspeed(120, 90);
      self sethoverparams(30, 10, 5);
      self setturningability(1);
      self setdroneturnparams(50, 1.3, 30, 20);
    }

    waitframe();
  }
}

helperdrone_watchforgoal() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self.owner endon("death_or_disconnect");
  self endon("owner_gone");
  self notify("helperDrone_watchForGoal");
  self endon("helperDrone_watchForGoal");
  result = scripts\engine\utility::waittill_any_return_3("goal", "near_goal", "hit_goal");
  self.intransit = 0;
  self.inactive = 0;
  self notify("hit_goal");
}

helperdrone_watchdamage() {
  level endon("game_ended");
  self endon("death");
  self endon("explode");
  self.owner endon("disconnect");
  self endon("owner_gone");
  self.health = 2147483647;
  config = level.helperdronesettings[self.helperdronetype];

  for(;;) {
    self waittill("damage", amount, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    _id_1FAA3D3DEC8D49BD = undefined;

    if(isDefined(attacker)) {
      if(isDefined(attacker.owner))
        attacker = attacker.owner;

      if(isDefined(attacker.team) && attacker.team == self.team && attacker != self.owner)
        continue;
    }

    if(isDefined(objweapon)) {
      if(istrue(_id_1FAA3D3DEC8D49BD)) {} else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage"))
        amount = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](attacker, objweapon, meansofdeath, amount, config.maxhealth, 1, 1, 1);
    }

    self.currenthealth = self.currenthealth - amount;
    scripts\cp_mp\utility\killstreak_utility::_id_DB9562064A4DD635(self.currenthealth);

    if(isPlayer(attacker)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback"))
        attacker[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]]("");

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakHit"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakHit")]](attacker, objweapon, self, meansofdeath, amount);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "logAttackerKillstreak"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "logAttackerKillstreak")]](self, amount, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon);

      if(self.currenthealth <= 0) {
        attacker notify("destroyed_killstreak", objweapon);
        damage = amount;
        streakname = self.streakinfo.streakname;
        _id_D95DA0355CF4CCB4 = undefined;
        _id_DC695757F69ED065 = 1;

        if(isDefined(objweapon)) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "onKillstreakKilled"))
            _id_3737240CEFE2C793 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "onKillstreakKilled")]](self.helperdronetype, attacker, objweapon, _id_D95DA0355CF4CCB4, damage, config.scorepop, config.vodestroyed, config.destroyedsplash, _id_DC695757F69ED065);
        }

        thread _id_06EDFDA4764129E3(1);
      }
    }
  }
}

helperdrone_watchtimeout() {
  level endon("game_ended");
  self endon("death");
  self endon("explode");
  self.owner endon("disconnect");
  self endon("owner_gone");
  config = level.helperdronesettings[self.helperdronetype];

  if(!isDefined(self.timeout)) {
    return;
  }
  if(self.timeout > 0)
    wait(self.timeout);

  if(istrue(config._id_5C6A7212BF9FCBEA)) {
    if(self.helperdronetype == "radar_drone_recon")
      scripts\cp_mp\utility\killstreak_utility::_id_08959C1606F65E65(self.streakinfo.streakname, self.streakinfo.streakname + "_timeout");
    else
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(self.streakinfo.streakname, self.streakinfo.streakname + "_timeout", 1);
  }

  thread helperdrone_leave(1);
}

helperdrone_watchownerloss() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  childthread helperdrone_watchownerstatus("disconnect");
  childthread helperdrone_watchownerstatus("joined_team");
  childthread helperdrone_watchownerstatus("joined_spectators");
  childthread helperdrone_watchownerstatus("last_stand_start");
}

helperdrone_watchownerstatus(_id_70687E0CC558A009) {
  self.owner waittill(_id_70687E0CC558A009);
  self notify("owner_gone");
  thread helperdrone_leave();
}

helperdrone_watchownerdeath() {
  level endon("game_ended");
  self endon("death");
  self endon("explode");
  self endon("owner_gone");

  for(;;) {
    self.owner scripts\engine\utility::waittill_any_2("death", "last_stand_start");

    if(_id_7AC8FCCBFD39D8B9())
      thread helperdrone_leave();
  }
}

_id_7AC8FCCBFD39D8B9() {
  config = level.helperdronesettings[self.helperdronetype];

  if(istrue(config.diewithowner))
    return 1;

  if(scripts\cp_mp\utility\game_utility::_id_6AE03EFB52C52C29(self.owner) || getdvarint("dvar_896B182FBFA8D9DE", 0)) {
    if(istrue(self.ispiloted)) {
      switch (self.helperdronetype) {
        case "radar_drone_recon":
          if(!istrue(config._id_8316E01BE4051639))
            return 1;

          self notify("killstreakExit");
          return 0;
        default:
          return 1;
      }
    }
  }

  return 0;
}

helperdrone_watchroundend() {
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self.owner endon("disconnect");
  self endon("owner_gone");
  level scripts\engine\utility::waittill_any_3("start_game_ended", "game_ended", "prematch_cleanup");
  thread helperdrone_leave();
}

helperdrone_leave(timeout) {
  self endon("death");
  self endon("explode");
  config = level.helperdronesettings[self.helperdronetype];

  if(isDefined(config._id_63A39D0CEA63CBB2))
    self thread[[config._id_63A39D0CEA63CBB2]](timeout);
  else if(self.helperdronetype == "radar_drone_overwatch") {
    self clearlookatent();
    self setmaxpitchroll(0, 0);
    self notify("leaving");
    self vehicle_setspeed(50, 25);
    pathgoal = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
    pathgoal = pathgoal + (0, 0, 1000);
    self setvehgoalpos(pathgoal, 1);
    self setneargoalnotifydist(100);
    self waittill("near_goal");
    _id_8B79D0E3AD3FB617 = helperdrone_getpathend();
    self vehicle_setspeed(150, 50);
    self setvehgoalpos(_id_8B79D0E3AD3FB617, 1);
    self waittill("goal");
    self notify("gone");
    _id_608250000FBFC89A(self.helperdronetype, level.helperdronesettings[self.helperdronetype], 0);
  } else
    thread _id_06EDFDA4764129E3(0, 1, timeout);
}

helperdrone_getpathend() {
  _id_CE2E2CFD0619F6CA = 150;
  _id_90783CCFB7B260FB = 15000;
  yaw = self.angles[1];
  direction = (0, yaw, 0);
  endpoint = self.origin + anglesToForward(direction) * _id_90783CCFB7B260FB;
  return endpoint;
}

perkengineer_manageminimap() {
  _id_30F120A1EFC1DCBE = "hud_icon_minimap_killstreak_cuav";
  self.enemyobjid = scripts\mp\objidpoolmanager::createobjective_engineer(_id_30F120A1EFC1DCBE, 1, 1);

  foreach(player in level.players) {
    if(!isPlayer(player)) {
      continue;
    }
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
      if(player[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_engineer") && player.team != self.team) {
        if(self.enemyobjid != -1)
          scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.enemyobjid, player);
      }
    }
  }
}

_id_CAF721CB23374E2B(data) {
  type = data.meansofdeath;
  damage = data.damage;

  if(isDefined(self.owner) && self.owner scripts\cp_mp\utility\player_utility::isusingremote()) {
    if(isexplosivedamagemod(type)) {
      if(ceil(damage / self.maxhealth) >= 0.4) {
        earthquake(0.25, 0.2, self.origin, 150);
        self.owner playRumbleOnEntity("damage_heavy");
      } else {
        earthquake(0.15, 0.15, self.origin, 150);
        self.owner playRumbleOnEntity("damage_light");
      }
    }
  }

  self.currenthealth = self.currenthealth - damage;
  scripts\cp_mp\utility\killstreak_utility::_id_DB9562064A4DD635(self.currenthealth);
  return 1;
}

helperdrone_stunned(duration) {
  self notify("helperDrone_stunned");
  self endon("helperDrone_stunned");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self.owner endon("disconnect");
  level endon("game_ended");

  if(istrue(self.attackingtarget))
    self notify("disengage_target");

  self.stunned = 1;

  if(isDefined(level.helperdronesettings[self.helperdronetype].fxid_sparks))
    playFXOnTag(level.helperdronesettings[self.helperdronetype].fxid_sparks, self, "tag_origin");

  playFXOnTag(scripts\engine\utility::getfx("emp_stun"), self, "tag_origin");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(duration);
  stopFXOnTag(scripts\engine\utility::getfx("emp_stun"), self, "tag_origin");
  self.stunned = 0;
}

_id_7017058E21AC030F(data) {
  self.isdestroyed = 1;
  self._id_D31453E33D3E34CA = 1;
  config = level.helperdronesettings[self.helperdronetype];

  if(istrue(self._id_8316E01BE4051639))
    self._id_8316E01BE4051639 = 0;

  if(self.ispiloted) {
    self._id_75BB433488D96804 = spawn("script_model", self.origin);
    self._id_75BB433488D96804.angles = self.owner getplayerangles();
    self._id_75BB433488D96804 setModel("tag_origin");
    self._id_75BB433488D96804 linkTo(self, "tag_origin");

    if(self.helperdronetype == "radar_drone_recon")
      self.owner remotecontrolvehicleoff();
    else if(self.helperdronetype == "assault_drone")
      self.owner remotecontrolvehicleoff();

    self.owner cameraunlink();
    self.owner cameralinkTo(self._id_75BB433488D96804, "tag_origin", 1, 1);
    self clearlookatent();
  }

  _id_ECB39C9EECBD70AD = 3000;
  contents = scripts\engine\trace::create_contents(0, 1, 1, 0, 0, 1, 0, 0, 0);
  castend = self.origin + anglestoup(self.angles) * _id_ECB39C9EECBD70AD * -1 + (randomintrange(-500, 500), 0, randomintrange(-500, 500));
  trace = scripts\engine\trace::ray_trace(self.origin, castend, [self]);
  _id_4351410D12107DF3 = trace["position"] + trace["normal"] * 5;
  _id_E2CC7EC7C1272C62 = getdvarfloat("dvar_044E62153228221F", 30.2);
  _id_D99757891D1ED279 = getdvarfloat("dvar_CDB03278C6D17E78", 13.8);
  _id_ACDFCBF564707132 = getdvarfloat("dvar_ED85BAF3072C3FFF", 17.2);
  _id_F9CA3F557A387549 = getdvarfloat("dvar_3F6D20D42A18063B", 2500);
  distance = distance(_id_4351410D12107DF3, self.origin);
  _id_BDA1DE83E1856735 = sqrt(2 * distance / _id_D99757891D1ED279);
  _id_BDA1DE83E1856735 = min(_id_BDA1DE83E1856735, 2.0) - 0.2;
  self vehicle_setspeed(_id_E2CC7EC7C1272C62, _id_D99757891D1ED279, _id_ACDFCBF564707132);
  self setvehgoalpos(_id_4351410D12107DF3, 0);
  thread _id_9BFDFF1EE5A47652();
  time = 0;

  for(;;) {
    if(distancesquared(self.origin, _id_4351410D12107DF3) <= _id_F9CA3F557A387549 || time >= _id_BDA1DE83E1856735) {
      _id_566780FD588DD54A(data);
      break;
    }

    time = time + level.framedurationseconds;
    waitframe();
  }
}

_id_566780FD588DD54A(data) {
  if(isDefined(data.inflictor) && isDefined(data.inflictor.stuckto))
    data.inflictor notify("forceDeath");

  if(isDefined(self._id_75BB433488D96804)) {
    self.owner cameraunlink();
    self._id_75BB433488D96804 delete();
    self._id_75BB433488D96804 = undefined;
  }

  thread _id_06EDFDA4764129E3(1);
}

_id_9BFDFF1EE5A47652() {
  level endon("game_ended");
  self endon("explode");
  self setmaxpitchroll(60, 90);
  self setyawspeed(1000, 500, 500);

  for(;;) {
    _id_DEE36AD33D9E9755 = randomintrange(140, 170);
    self settargetyaw(self.angles[1] + _id_DEE36AD33D9E9755);
    wait 0.25;
  }
}

_id_BA1C5496F8FC5F67(data) {
  if(!isDefined(self) || istrue(self.isdestroyed)) {
    return;
  }
  if(isDefined(data) && isDefined(data.inflictor) && isDefined(data.inflictor.weapon_name) && data.inflictor.weapon_name == "shock_stick_mp")
    thread _id_7017058E21AC030F(data);
  else
    thread _id_06EDFDA4764129E3(1);

  return 0;
}

_id_F6914D06B20AEE20() {
  self setscriptablepartstate("body_damage_light", "on");
}

_id_3AD98C4F7524B525() {
  self setscriptablepartstate("body_damage_medium", "on");
}

_id_E68A206899CAFBE5() {
  self setscriptablepartstate("body_damage_heavy", "on");
}

_id_06EDFDA4764129E3(_id_4FAC8B8CE36E09F1, _id_D9B2677826930BF7, _id_28D4A6F776C18B73, _id_BD21744EB1B623FE) {
  self.owner scripts\cp_mp\utility\player_utility::stopwatchingthermalinputchange();
  self.isdestroyed = 1;
  config = level.helperdronesettings[self.helperdronetype];

  if(!istrue(_id_D9B2677826930BF7) && !istrue(_id_BD21744EB1B623FE)) {
    if(self.helperdronetype == "radar_drone_recon")
      scripts\cp_mp\utility\killstreak_utility::_id_08959C1606F65E65(self.helperdronetype, self.helperdronetype + "_destroyed");
    else
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(self.helperdronetype, self.helperdronetype + "_destroyed", 1);
  }

  if(isDefined(self.targetmarkergroup)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.targetmarkergroup);
    self.targetmarkergroup = undefined;
  }

  if(isDefined(self.minimapid)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.minimapid);
    self.minimapid = undefined;
  }

  helperdrone_endscramblereffect();

  if(isDefined(config._id_5D9D3E47B1B88B84))
    self[[config._id_5D9D3E47B1B88B84]](config, _id_4FAC8B8CE36E09F1, _id_D9B2677826930BF7, _id_28D4A6F776C18B73, _id_BD21744EB1B623FE);
  else
    _id_24085A0230958938();

  scripts\cp_mp\emp_debuff::allow_emp(0);
  self notify("explode");

  if(isDefined(self.streakinfo._id_EBEC497FF8B18A45)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "onFieldUpgradeEnd"))
      self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onFieldUpgradeEnd")]](self.streakinfo._id_EBEC497FF8B18A45, self.usedcount);
  }

  if(isDefined(self.streakinfo.superid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("dlog", "fieldUpgradeExpired"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("dlog", "fieldUpgradeExpired")]](self.owner, self.streakinfo.superid, self.usedcount, istrue(_id_4FAC8B8CE36E09F1));
  }

  owner = self.owner;

  if(isDefined(owner)) {
    if(isDefined(owner.super) && owner.super.isinuse) {
      if(isDefined(self.streakinfo._id_EBEC497FF8B18A45) && self.streakinfo._id_EBEC497FF8B18A45 == owner.super.staticdata.ref) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished"))
          self.owner thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]](0);
      }
    }
  }

  if(istrue(self.nonvehicle))
    waitframe();
  else
    wait 0.2;

  _id_608250000FBFC89A(self.helperdronetype, level.helperdronesettings[self.helperdronetype], _id_4FAC8B8CE36E09F1);

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && isDefined(owner) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("br", "superSlotCleanUp"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("br", "superSlotCleanUp")]](owner);
}

_id_FFBC19E1AEF5943C(_id_E036BEB70DA584EC) {
  if(_id_E036BEB70DA584EC) {
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("DDoSed", self.owner, self.vehiclename);
    self.owner scripts\cp_mp\emp_debuff::play_emp_scramble(4);
    self.owner scripts\cp_mp\utility\player_utility::_freezecontrols(1);
    self.owner scripts\cp_mp\utility\player_utility::_freezelookcontrols(1);
  } else {
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("DDoSed", self.owner, self.vehiclename);
    self.owner scripts\cp_mp\emp_debuff::stop_emp_scramble(4);
    self.owner scripts\cp_mp\utility\player_utility::_freezecontrols(0);
    self.owner scripts\cp_mp\utility\player_utility::_freezelookcontrols(0);
  }
}

_id_9FE87B841A44448F() {
  if(isent(self)) {
    _id_8F7DDE4490939B87 = "on";

    if(istrue(self._id_51AB77B2BA57C5DD)) {
      if(self getscriptableparthasstate("explode", "water"))
        _id_8F7DDE4490939B87 = "water";
    }

    self setscriptablepartstate("explode", _id_8F7DDE4490939B87, 0);
  }
}

_id_24085A0230958938() {
  if(isent(self)) {
    exitstate = "on";

    if(istrue(self._id_51AB77B2BA57C5DD)) {
      if(self getscriptableparthasstate("exit", "water"))
        exitstate = "water";
    }

    self setscriptablepartstate("exit", exitstate, 0);
  }
}

_id_608250000FBFC89A(_id_7C344645CC98E70D, config, _id_4FAC8B8CE36E09F1) {
  helperdrone_disableradar();
  self.ispiloted = undefined;
  self._id_8316E01BE4051639 = undefined;

  if(isDefined(self.useobj))
    self.useobj delete();

  if(isDefined(self.playersfx))
    self.playersfx delete();

  if(isDefined(self.scrambler))
    self.scrambler delete();

  if(isDefined(self.enemyobjid))
    scripts\mp\objidpoolmanager::returnobjectiveid(self.enemyobjid);

  if(isDefined(self.pulsedarts) && self.pulsedarts.size > 0) {
    foreach(_id_0334E9887A767EF7 in self.pulsedarts)
    _id_0334E9887A767EF7 notify("death");
  }

  if(!istrue(self.streakinfo.issuper)) {
    if(isDefined(level.killstreakfinishusefunc))
      level thread[[level.killstreakfinishusefunc]](self.streakinfo);
  }

  if(isDefined(self.owner)) {
    if(isDefined(self.owner.helperdrone))
      self.owner.helperdrone = undefined;

    self.owner clearsoundsubmix("mp_recon_drone", 1);
    self.owner notify("eng_drone_update", -1);
    self.owner scripts\cp_mp\utility\player_utility::stopwatchingthermalinputchange();

    if(_id_7C344645CC98E70D == "radar_drone_escort" || _id_7C344645CC98E70D == "radar_drone_overwatch") {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "hideMiniMap"))
        self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "hideMiniMap")]]();
    }

    self.streakinfo.expiredbydeath = istrue(_id_4FAC8B8CE36E09F1);
    self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);
  }

  if(_id_7C344645CC98E70D == "scrambler_drone_guard")
    scramblerdrone_counteruavmodeoff();

  if(istrue(self.nonvehicle))
    self delete();
  else
    scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isBRStyleGameType") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isBRStyleGameType")]]()) {
    if(isDefined(self.owner))
      self.owner setclientomnvar("ui_killstreak_countdown", 0);
  }
}

_id_F23D90F7483D67E4() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("droneStart");
  starttime = gettime();
  _id_FC36664F5893D75D = 1000;

  while(gettime() - starttime < _id_FC36664F5893D75D) {
    _id_89AF506D89AAD6ED(0);
    waitframe();
  }
}

_id_89AF506D89AAD6ED(state, drone) {
  _id_27903296234D1638 = 0;

  if(isDefined(drone))
    _id_27903296234D1638 = drone.helperdronetype == "assault_drone";

  if(state > 0 && _id_27903296234D1638)
    state = state + 2;

  self setclientomnvar("ui_rcd_controls", state);
}

_id_28368A23C20FF3E6(_id_C8462289EDFC0ACA, target, state) {
  _id_7CBB905F3204B5D0 = (state >> 0) % 2 == 1;
  _id_01F6FF6A3877BF04 = (state >> 1) % 2 == 1;
  targetmarkergroupsetentitystate(_id_C8462289EDFC0ACA, target, _id_7CBB905F3204B5D0);
  targetmarkergroupsetextrastate(_id_C8462289EDFC0ACA, target, _id_01F6FF6A3877BF04);
}

_id_289DDD64EC5B3010(streakinfo, owner) {
  if(!isDefined(level.supportdrones))
    return 0;

  if(level.incominghelperdrones.size > 0) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
      if(level.incominghelperdrones.size >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]())
        return 1;
    }

    foreach(drone in level.incominghelperdrones) {
      if(isDefined(drone.owner) && drone.owner == owner) {
        continue;
      }
      if(streakinfo.streakname == "radar_drone_recon" && drone.type == streakinfo.streakname) {
        if(level.teambased) {
          if(isDefined(drone.owner) && isDefined(drone.owner.team) && drone.owner.team == owner.team)
            return 1;
        }
      } else if(streakinfo.streakname == "assault_drone" && drone.type == streakinfo.streakname) {
        if(level.teambased) {
          if(isDefined(drone.owner) && isDefined(drone.owner.team) && drone.owner.team == owner.team)
            return 1;
        }
      } else if(streakinfo.streakname == "radar_drone_overwatch" && drone.type == streakinfo.streakname) {
        if(level.teambased) {
          if(helperdrone_getnumdrones("radar_drone_overwatch", level.incominghelperdrones, owner.team) >= 10)
            return 1;
        }

        if(helperdrone_getnumdrones("radar_drone_overwatch", level.incominghelperdrones) >= 20)
          return 1;
      } else if(streakinfo.streakname == "scrambler_drone_guard" && drone.type == streakinfo.streakname) {
        if(level.teambased) {
          if(helperdrone_getnumdrones("scrambler_drone_guard", level.incominghelperdrones, owner.team) >= 10)
            return 1;
        }
      }
    }
  }

  if(level.supportdrones.size > 0) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
      if(level.supportdrones.size >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]())
        return 1;
    }

    foreach(drone in level.supportdrones) {
      if(streakinfo.streakname == "radar_drone_escort" && drone.helperdronetype == streakinfo.streakname) {
        if(isDefined(drone.owner) && drone.owner == owner) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
            owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/COMPANION_ALREADY_EXISTS");

          return 1;
        }
      } else if(streakinfo.streakname == "radar_drone_recon" && drone.helperdronetype == streakinfo.streakname) {
        if(level.teambased) {
          if(drone.team == owner.team) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
              owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");

            return 1;
          }
        }
      } else if(streakinfo.streakname == "assault_drone" && drone.helperdronetype == streakinfo.streakname) {
        if(level.teambased) {
          if(drone.team == owner.team) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
              owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");

            return 1;
          }
        }
      } else if(streakinfo.streakname == "radar_drone_overwatch" && drone.helperdronetype == streakinfo.streakname) {
        if(helperdrone_getnumdrones("radar_drone_overwatch", level.supportdrones) >= 20) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
            owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");

          return 1;
        }

        if(level.teambased) {
          if(helperdrone_getnumdrones("radar_drone_overwatch", level.supportdrones, owner.team) >= 10) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
              owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_PERSONAL_RADAR");

            return 1;
          }
        }

        if(helperdrone_getnumdrones("radar_drone_overwatch", level.supportdrones, owner) >= 1) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
            owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/PERSONAL_RADAR_ALREADY_ACTIVE");

          return 1;
        }
      } else if(streakinfo.streakname == "scrambler_drone_guard" && drone.helperdronetype == streakinfo.streakname) {
        if(level.teambased) {
          if(helperdrone_getnumdrones("scrambler_drone_guard", level.supportdrones, owner.team) >= 10) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
              owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_COUNTER_UAV");

            return 1;
          }
        } else if(helperdrone_getnumdrones("scrambler_drone_guard", level.supportdrones, owner) >= 2) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
            owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_COUNTER_UAV");

          return 1;
        }
      }
    }
  }

  return 0;
}

helperdrone_getnumdrones(_id_7C344645CC98E70D, _id_EE9E55B40B28D806, _id_BACE6387B1D799AD) {
  _id_DC1A0178A2C53770 = 0;

  foreach(drone in _id_EE9E55B40B28D806) {
    if(isDefined(drone.type) && drone.type == _id_7C344645CC98E70D || isDefined(drone.helperdronetype) && drone.helperdronetype == _id_7C344645CC98E70D) {
      if(isDefined(_id_BACE6387B1D799AD)) {
        if(isPlayer(_id_BACE6387B1D799AD)) {
          if(drone.owner != _id_BACE6387B1D799AD)
            continue;
        } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isGameplayTeam") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isGameplayTeam")]](_id_BACE6387B1D799AD)) {
          if(drone.team != _id_BACE6387B1D799AD)
            continue;
        }
      }

      _id_DC1A0178A2C53770++;
    }
  }

  return _id_DC1A0178A2C53770;
}

helperdrone_destroyongameend() {
  self endon("death");
  self endon("leaving");
  self endon("explode");
  level scripts\engine\utility::waittill_any_2("bro_shot_start", "game_ended");
  _id_BA1C5496F8FC5F67();
}

helperdrone_watchaltitude(player) {
  self endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  _id_A4E731E18A4E789B = getdvarfloat("dvar_F983D652B2640512", 1500);
  _id_4F8E491037DCDFF7 = getdvarfloat("dvar_35BAB6C292A12242", 6000);
  _id_F203791DE5CA7907 = _id_A4E731E18A4E789B + _id_4F8E491037DCDFF7;
  _id_176E0A0AE11D3A7B = 0.0;
  _id_D7C5F779C1A8FC57 = 0.0;

  for(;;) {
    if(self.origin[2] > _id_4F8E491037DCDFF7) {
      if(self.origin[2] > _id_F203791DE5CA7907) {
        player setclientomnvar("ui_out_of_range", 0.0);
        _id_BA1C5496F8FC5F67();
      }

      _id_176E0A0AE11D3A7B = (self.origin[2] - _id_4F8E491037DCDFF7) / _id_A4E731E18A4E789B;
    } else
      _id_176E0A0AE11D3A7B = 0.0;

    if(_id_176E0A0AE11D3A7B != _id_D7C5F779C1A8FC57) {
      _id_D7C5F779C1A8FC57 = _id_176E0A0AE11D3A7B;
      player setclientomnvar("ui_out_of_range", _id_176E0A0AE11D3A7B);
    }

    waitframe();
  }
}

helperdrone_gettargetoffset(helperdrone, player) {
  config = level.helperdronesettings[helperdrone.helperdronetype];
  backoffset = config.backoffset;
  sideoffset = config.sideoffset;
  heightoffset = helperdrone helperdrone_getheightoffset(config);

  if(isDefined(helperdrone.low_entry))
    heightoffset = heightoffset * helperdrone.low_entry;

  targetoffset = (sideoffset, backoffset, heightoffset);
  return targetoffset;
}

_id_34280B807C23A453(helperdronetype) {
  if(!isDefined(helperdronetype))
    return undefined;

  if(!isDefined(level.helperdronesettings[helperdronetype]))
    return undefined;

  startang = self.angles;
  zoffset = (0, 0, 80);
  spawndist = level.helperdronesettings[helperdronetype].spawndist;
  heightoffset = (0, 0, zoffset[2]);
  halfsize = level.helperdronesettings[helperdronetype].halfsize;
  forward = anglesToForward(self.angles);
  right = anglestoright(self.angles);
  _id_1925D24D0AE333E6 = scripts\cp_mp\utility\player_utility::getstancetop();
  _id_50203232DAC6B01F = 50;
  _id_4EBA8B5AB3B85E92 = 20;

  if(scripts\cp_mp\utility\train_utility::player_standing_on_train()) {
    heightoffset = heightoffset + (0, 0, 150);
    _id_50203232DAC6B01F = 120;
    spawndist = 150;
    halfsize = halfsize * 3;
    _id_4EBA8B5AB3B85E92 = 120;
  } else if(scripts\cp_mp\utility\player_utility::_id_F8789F15330DE751(self)) {
    heightoffset = heightoffset + (0, 0, 100);
    _id_50203232DAC6B01F = 100;
    spawndist = 120;
    halfsize = halfsize * 2;
    _id_4EBA8B5AB3B85E92 = 100;
  } else if(self _meth_E40102956C887F7C())
    _id_1925D24D0AE333E6 = self.origin + (0, 0, getdvarint("dvar_D78C8ED504373EA5", 30));

  _id_08604E40DAE72EDD = physics_createcontents(["physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
  _id_214D77BB9D513C28 = scripts\engine\trace::ray_trace(self.origin + (0, 0, 20), _id_1925D24D0AE333E6, self, _id_08604E40DAE72EDD);

  if(_id_214D77BB9D513C28["hittype"] != "hittype_none")
    return undefined;

  _id_778F9AB8C1872412 = spawndist + _id_4EBA8B5AB3B85E92;

  if(self getstance() == "prone")
    _id_778F9AB8C1872412 = _id_778F9AB8C1872412 + 25;

  _id_676798DC94029F6C = [heightoffset + spawndist * forward, heightoffset - spawndist * forward, heightoffset + spawndist * right, heightoffset - spawndist * right, heightoffset, heightoffset + 0.707 * spawndist * (forward + right), heightoffset + 0.707 * spawndist * (forward - right), heightoffset + 0.707 * spawndist * (right - forward), heightoffset + 0.707 * spawndist * (-1 * forward - right), _id_778F9AB8C1872412 * forward, -1 * _id_778F9AB8C1872412 * forward, _id_778F9AB8C1872412 * right, -1 * _id_778F9AB8C1872412 * right, 0.707 * _id_778F9AB8C1872412 * (forward + right), 0.707 * _id_778F9AB8C1872412 * (forward - right), 0.707 * _id_778F9AB8C1872412 * (right - forward), 0.707 * _id_778F9AB8C1872412 * (-1 * forward - right)];
  _id_CCA213F58A72D7B7 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_676798DC94029F6C.size; _id_AC0E594AC96AA3A8++) {
    if(4 <= _id_CCA213F58A72D7B7) {
      _id_CCA213F58A72D7B7 = 0;
      wait 0.05;
    }

    _id_AD3758FD3576AE97 = _id_676798DC94029F6C[_id_AC0E594AC96AA3A8];
    spawnpos = _id_1925D24D0AE333E6 + _id_AD3758FD3576AE97;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isBRStyleGameType")) {
      if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isBRStyleGameType")]]()) {
        _id_A4E731E18A4E789B = getdvarfloat("dvar_F983D652B2640512", 1500);
        _id_4F8E491037DCDFF7 = getdvarfloat("dvar_35BAB6C292A12242", 6000);
        _id_F203791DE5CA7907 = _id_A4E731E18A4E789B + _id_4F8E491037DCDFF7;

        if(spawnpos[2] >= _id_F203791DE5CA7907) {
          break;
        }
      }
    }

    _id_719DA4AA69A9FC90 = vectorNormalize(_id_AD3758FD3576AE97) * _id_50203232DAC6B01F;
    _id_0965C36FE7C010B3 = _id_1925D24D0AE333E6 + _id_719DA4AA69A9FC90;
    _id_1BFA180C6FDD09DD = physics_createcontents(["physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot", "physicscontents_water"]);
    _id_214D77BB9D513C28 = scripts\engine\trace::ray_trace(_id_1925D24D0AE333E6, _id_0965C36FE7C010B3, self, _id_1BFA180C6FDD09DD);

    if(_id_214D77BB9D513C28["hittype"] != "hittype_none") {
      continue;
    }
    _id_E5354BE82A7990D5 = scripts\engine\trace::sphere_trace(_id_0965C36FE7C010B3, spawnpos, halfsize, self, _id_1BFA180C6FDD09DD);
    fraction = _id_E5354BE82A7990D5["fraction"];
    _id_84D0C5C148DA4A7A = fraction * (spawnpos - _id_0965C36FE7C010B3);
    _id_6E3F1A360851A19A = _id_0965C36FE7C010B3 + _id_84D0C5C148DA4A7A;

    if(fraction > 0) {
      self.recondronesafespawn = _id_6E3F1A360851A19A;
      return _id_6E3F1A360851A19A;
    }

    _id_CCA213F58A72D7B7++;
  }

  return undefined;
}

helperdrone_showminimaponspawn(drone) {
  self endon("disconnect");
  drone endon("death");
  drone endon("explode");
  drone endon("leaving");
  level endon("game_ended");
  ownerid = self.guid;
  level notify("helperDrone_show_minimap_" + ownerid);
  level endon("helperDrone_show_minimap_" + ownerid);

  if(istrue(level.istacops)) {
    return;
  }
  for(;;) {
    self waittill("spawned_player");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "showMiniMap"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "showMiniMap")]]();

    self.showuavminimaponspawn = 1;
  }
}

deliverydrone_delivertopoint(targetpos, ondelivercallback) {
  self endon("death_or_disconnect");
  self endon("reconDroneEnded");
  self endon("reconDroneUnset");
  streakinfo = spawnStruct();
  streakinfo.streakname = "ammo_drop";
  streakinfo.issuper = 1;
  streakinfo.superid = level.superglobals.staticsuperdata["super_weapon_drop"].id;
  streakinfo._id_EBEC497FF8B18A45 = level.superglobals.staticsuperdata["super_weapon_drop"].ref;

  if(tryusehelperdroneearlyout(streakinfo, 1)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();

    _id_C3786C4FBA09C2F2(streakinfo);
    return undefined;
  }

  startpos = targetpos + (0, 0, 4000) - anglesToForward(self.angles) * 0;
  _id_446DB1DC2FD8E89D = createhelperdrone(startpos, self.angles, streakinfo.streakname, streakinfo);

  if(!isDefined(_id_446DB1DC2FD8E89D))
    return undefined;

  _id_C3786C4FBA09C2F2(streakinfo);
  _id_446DB1DC2FD8E89D.deliverytarget = targetpos;
  _id_446DB1DC2FD8E89D.ondelivercallback = ondelivercallback;
  thread starthelperdrone(_id_446DB1DC2FD8E89D);
  return _id_446DB1DC2FD8E89D;
}

scramblerdrone_counteruavmodeon() {
  scripts\cp_mp\killstreaks\uav::_id_24D8B56676D4D3D1();
  level notify("uav_update");
}

scramblerdrone_counteruavmodeoff() {
  scripts\cp_mp\killstreaks\uav::_id_E02B5390559E651A();
  level notify("uav_update");
}

_id_B25CED7F149BE057() {
  self.owner endon("disconnect");
  self endon("death");
  _id_2F344609BBDBA105 = 0.0;
  self._id_97DA68F6ABB8EC80 = 0;
  _id_39B61D1F526B47D7 = 0;
  _id_5BEF4D0C7C1D06A8 = undefined;

  for(;;) {
    if(isDefined(level.outofboundstriggers)) {
      self._id_97DA68F6ABB8EC80 = 0;

      foreach(trigger in level.outofboundstriggers) {
        if(self istouching(trigger)) {
          if(isDefined(trigger.script_team) && self.team != trigger.script_team) {
            continue;
          }
          self._id_97DA68F6ABB8EC80 = 1;
          _id_5BEF4D0C7C1D06A8 = trigger;

          if(istrue(_id_39B61D1F526B47D7) && (!isDefined(self.oobtriggers) || self.oobtriggers.size == 0))
            _id_39B61D1F526B47D7 = 0;

          break;
        }
      }

      if(self._id_97DA68F6ABB8EC80) {
        _id_2F344609BBDBA105 = _id_2F344609BBDBA105 + 1.0 * level.framedurationseconds;

        if(!istrue(_id_39B61D1F526B47D7) && isDefined(_id_5BEF4D0C7C1D06A8)) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "onEnterOOBTrigger"))
            [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "onEnterOOBTrigger")]](_id_5BEF4D0C7C1D06A8, self);

          _id_39B61D1F526B47D7 = 1;
        }
      } else {
        _id_2F344609BBDBA105 = _id_2F344609BBDBA105 - 2.0 * level.framedurationseconds;

        if(istrue(_id_39B61D1F526B47D7) && isDefined(_id_5BEF4D0C7C1D06A8)) {
          _id_39B61D1F526B47D7 = 0;
          _id_5BEF4D0C7C1D06A8 = undefined;
        }
      }

      _id_2F344609BBDBA105 = clamp(_id_2F344609BBDBA105, 0.0, 0.5);
      self.owner setclientomnvar("ui_out_of_range", _id_2F344609BBDBA105);
    }

    waitframe();
  }
}

_id_DE3C015E3C7130E7(helperdronetype) {
  _id_17BCB5A652EC6088 = 0;

  switch (helperdronetype) {
    case "assault_drone":
    case "radar_drone_recon":
      _id_17BCB5A652EC6088 = 1;
      break;
  }

  return _id_17BCB5A652EC6088;
}

helperdrone_giveplayerfauxremote(streakinfo) {
  self endon("disconnect");
  scripts\cp_mp\utility\player_utility::setusingremote(streakinfo.streakname);
}

helperdrone_takeplayerfauxremote(streakinfo) {
  scripts\cp_mp\utility\player_utility::clearusingremote(1);
  streakinfo notify("killstreak_finished_with_deploy_weapon");
  objweapon = makeweapon("ks_remote_drone_mp");

  if(self hasweapon(objweapon))
    thread scripts\cp_mp\utility\inventory_utility::getridofweapon(objweapon);
}

_id_F9C33DF98457A9A2(target, _id_0B2CC25676B34BF9) {
  _id_027B697504D9397D = 0;
  _id_BFD06D83FEA8D89A = self.owner getvieworigin();

  if(istrue(_id_0B2CC25676B34BF9))
    _id_BFD06D83FEA8D89A = self.origin;

  if(isDefined(target.recondronetracecontents))
    contents = target.recondronetracecontents;
  else
    contents = physics_createcontents(["physicscontents_itemclip", "physicscontents_item", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_ainosight"]);

  _id_08A4EA3A3BAA22E4 = target.origin;

  if(isDefined(target.recondronetraceoffset))
    _id_08A4EA3A3BAA22E4 = _id_08A4EA3A3BAA22E4 + target.recondronetraceoffset;

  _id_D895C679F6A927E5 = [_id_08A4EA3A3BAA22E4];

  if(isPlayer(target)) {
    _id_295719F06C03407F = (0, 0, 0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive"))
      _id_295719F06C03407F = target[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getStanceTop")]]();

    _id_FC60036BA7BF253A = (0, 0, 0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive"))
      _id_FC60036BA7BF253A = target[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getStanceCenter")]]();

    _id_D895C679F6A927E5 = [_id_295719F06C03407F, _id_FC60036BA7BF253A, _id_08A4EA3A3BAA22E4];
  } else if(isagent(target))
    _id_D895C679F6A927E5 = [_id_08A4EA3A3BAA22E4 + (0, 0, 1)];

  ignorelist = [self, target];
  vehicle = target scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(vehicle)) {
    ignorelist[ignorelist.size] = vehicle;
    _id_BB7AC665413117FC = vehicle getlinkedchildren(1);

    foreach(child in _id_BB7AC665413117FC)
    ignorelist[ignorelist.size] = vehicle;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D895C679F6A927E5.size; _id_AC0E594AC96AA3A8++) {
    if(!scripts\engine\trace::ray_trace_passed(_id_BFD06D83FEA8D89A, _id_D895C679F6A927E5[_id_AC0E594AC96AA3A8], ignorelist, contents)) {
      continue;
    }
    _id_027B697504D9397D = 1;
    break;
  }

  return _id_027B697504D9397D;
}

_id_E89890DE385D2D9E(config, _id_4FAC8B8CE36E09F1, _id_D9B2677826930BF7, _id_28D4A6F776C18B73, _id_BD21744EB1B623FE) {
  _id_9FE87B841A44448F();
}

ishelperdrone() {
  if(isDefined(level.helperdronesettings)) {
    if(isDefined(self.streakinfo))
      return scripts\engine\utility::array_contains_key(level.helperdronesettings, self.streakinfo.streakname);
  }

  return 0;
}

_id_8C4AB0A7799E7AB8(weapon) {
  return weapon.basename == "ks_remote_drone_mp" || weapon.basename == "ks_assault_drone_mp" || weapon.basename == "ks_assault_drone_cp";
}

_id_49197CD063A740EA(_id_960061306B2CAAA6) {
  self._id_D1659ED0A33BF98F = _id_960061306B2CAAA6;
}