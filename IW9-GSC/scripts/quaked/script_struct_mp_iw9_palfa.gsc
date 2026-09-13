/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\quaked\script_struct_mp_iw9_palfa.gsc
*********************************************************/

main() {
  scripts\cp_mp\vehicles\vehicle::_id_C0B3DDC9A6BDCC46("veh9_palfa", ::_id_3EF5F926204CBD9E);
}

_id_3EF5F926204CBD9E() {
  if(!scripts\cp_mp\vehicles\vehicle::_id_9697379150687859("veh9_palfa")) {
    return;
  }
  level._id_048E4BD8587968F9 = getdvarfloat("dvar_63997342447B8B87", 1.0);
  level._id_06D2D9D6D9A73CC7 = getdvarfloat("dvar_90E419F6D32EBA39", 1.0);
  level._id_3E1C52FB7C3F1BC9 = getdvarfloat("dvar_E2DA3B6E24619503", 1.2);
  level._id_6F19DD2299CCDE22 = getdvarfloat("dvar_B0AEAF5F49BC9880", 1.0);
  level._id_C7432004084941B0 = getdvarfloat("dvar_14A693E48CE554C2", 0.5);
  level._id_45A061F49E1C9A50 = getdvarfloat("dvar_6CA40904BCED7F47", 0.9);
  level._id_C5A60AF4413F9FA9 = getdvarfloat("dvar_48D77161E444423F", 0.5);
  level._id_D2EC30F44A87286D = getdvarfloat("dvar_5514BB61EC6780CB", 0.2);
  level._id_7B0C541BAA0443EF = getdvarfloat("dvar_CFA87DC67C8884DD", 0.05);
  level._id_5B4E83373390B0BE = getdvarfloat("dvar_0BE17AD18EDC41A8", 0.2);
  level._id_0BAB8EBDBB45D860 = getdvarfloat("dvar_6EE8BC7A35A3CDAA", 0.4);
  callbacks = [];
  callbacks["spawn"] = ::_id_31F42AD9450CB938;
  callbacks["enterStart"] = ::_id_C92DAF0D2D3B4C32;
  callbacks["enterEnd"] = ::_id_01238715FB4ADE17;
  callbacks["exitEnd"] = ::_id_B8EFEDE8329D0DF1;
  callbacks["reenter"] = ::_id_90EDB9E4CBF08215;
  callbacks["outOfFuel"] = ::_id_C2AE8B4F4DEF3709;
  callbacks["beginBurnDown"] = ::_id_D35260397FD3EBA0;
  callbacks["interactsWithOOBTrigger"] = ::_id_F7F993D241E44B19;
  callbacks["onStartRiding"] = ::_id_153A6ACCF001DFF6;
  callbacks["onEndRiding"] = ::_id_71ADB8F84C3DF6BB;
  callbacks["isInInterior"] = ::_id_3D25AF3A88AD31C3;
  callbacks["onEnterInterior"] = ::_id_3FFE455E5EA6D0F5;
  callbacks["onExitInterior"] = ::_id_B2CC563ED7324A8D;
  callbacks["forceOOBEnable"] = ::_id_DEC1987F9EE988C6;
  scripts\cp_mp\vehicles\vehicle::_id_08497E7E46B5E397("veh9_palfa", callbacks);
  _id_92B52877803F326A();
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setpremoddamagecallback("veh9_palfa", ::_id_1062A7FD4B6D46A5);
}

_id_92B52877803F326A() {
  _id_E2818AD39A3341B4 = scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_getleveldataforvehicle("veh9_palfa", 1);
  _id_E2818AD39A3341B4.ammoids["flares"] = 1;
}

_id_1062A7FD4B6D46A5(data) {
  return !isDefined(data) || !isDefined(data.inflictor) || !isDefined(data.inflictor.classname) || data.inflictor.classname != "trigger_hurt" || !isDefined(self) || !isDefined(self.origin) || ispointinvolume(self.origin, data.inflictor);
}

_id_F7F993D241E44B19(trigger, vehicle) {
  return ispointinvolume(vehicle.origin, trigger);
}

_id_31F42AD9450CB938(spawndata, _id_EE8DA5624236DC89) {
  vehicle = scripts\cp_mp\vehicles\vehicle::_id_BBA34CF920370FF4("veh9_palfa", spawndata, _id_EE8DA5624236DC89);

  if(!isDefined(vehicle))
    return undefined;

  vehicle.borntime = gettime();
  vehicle.flareslive = [];
  vehicle.flareready = 1;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    vehicle.flarecooldown = 35;
  else
    vehicle.flarecooldown = 10;

  vehicle.entstouching = [];
  vehicle thread vehicle_handleflarerecharge();
  vehicle thread collision_damage_watcher();

  if(istrue(spawndata._id_CAE20238EE346E02)) {
    vehicle.ishovering = 1;
    vehicle _meth_D2E41C7603BA7697("p2p");
  }

  return vehicle;
}

_id_C2AE8B4F4DEF3709() {
  if(istrue(self.ishovering)) {
    self.ishovering = 0;
    self _meth_6A325F91941ED47C("p2p");
  }
}

_id_D35260397FD3EBA0() {
  if(istrue(self.ishovering)) {
    self.ishovering = 0;
    self _meth_6A325F91941ED47C("p2p");
  }

  self._id_E114008648967BFB = 1;
}

collision_damage_watcher() {
  self endon("death");
  self vehphys_enablecollisioncallback(1);

  for(;;) {
    self waittill("collision", body0, body1, flag0, flag1, position, normal, normalspeed, ent, partenum);

    if(gettime() - self.borntime < 5000) {
      continue;
    }
    if(isDefined(ent) && istrue(ent.iscrossbowbolt)) {
      continue;
    }
    if(isDefined(ent) && isDefined(ent.helperdronetype) && ent.helperdronetype == "radar_drone_recon") {
      continue;
    }
    damagefactor = normalspeed;

    if(isDefined(self._id_70EC04F736523DD0))
      damagefactor = damagefactor * (self vehicle_gettopspeedforward() / self._id_70EC04F736523DD0);

    _id_2D65C754072C9542 = 0;

    if(damagefactor > level._id_C5A60AF4413F9FA9) {
      range = level._id_45A061F49E1C9A50 - level._id_C5A60AF4413F9FA9;
      _id_6D3017665EC227E0 = (damagefactor - level._id_C5A60AF4413F9FA9) / range;
      _id_ED91F3EC33AF8C15 = self.maxhealth * level._id_5B4E83373390B0BE;
      _id_8516B2BF8F4DA6D7 = self.maxhealth * level._id_0BAB8EBDBB45D860;
      _id_2D65C754072C9542 = scripts\engine\math::lerp(_id_ED91F3EC33AF8C15, _id_8516B2BF8F4DA6D7, _id_6D3017665EC227E0);
    } else if(damagefactor > level._id_D2EC30F44A87286D)
      _id_2D65C754072C9542 = self.maxhealth * level._id_7B0C541BAA0443EF;
    else
      continue;

    if(istrue(self._id_E114008648967BFB) && (length(self vehicle_getvelocity()) > 264.0 || isDefined(ent) && ent scripts\cp_mp\vehicles\vehicle::isvehicle() && length(ent vehicle_getvelocity()) > 264.0))
      _id_2D65C754072C9542 = self.maxhealth;

    if(_id_2D65C754072C9542 > 0) {
      scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_disablestatedamagefloor(1);
      self dodamage(_id_2D65C754072C9542, position, undefined, undefined, "MOD_CRUSH");
      scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_disablestatedamagefloor(0);
    }

    wait 0.5;
  }
}

_id_E654F2C9EE8EA94A(_id_1AE0AEB37C917298, data) {
  self setscriptablepartstate("alarm", "engineFailure", 0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_onenterstateheavy(_id_1AE0AEB37C917298, data);
}

_id_FB5146A15CB434D2(_id_1AE0AEB37C917298, data) {
  self setscriptablepartstate("alarm", "off", 0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_onexitstateheavy(_id_1AE0AEB37C917298, data);
}

_id_C92DAF0D2D3B4C32(vehicle, seatid, _id_FC7C7A874B43A31A, player, data) {
  if(istrue(vehicle.israllypointvehicle)) {
    foreach(_id_B212D40302E8388D in level.players) {
      if(istrue(vehicle.revealed) || scripts\engine\utility::is_equal(_id_B212D40302E8388D.team, vehicle.team))
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(vehicle.marker.objidnum, _id_B212D40302E8388D);
    }

    foreach(_id_F85572CD5F6117C6 in vehicle.occupants)
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(vehicle.marker.objidnum, _id_F85572CD5F6117C6);

    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(vehicle.marker.objidnum, player);
  }
}

_id_01238715FB4ADE17(vehicle, seatid, _id_FC7C7A874B43A31A, player, data) {
  if(istrue(data.success)) {
    player scripts\cp_mp\parachute::parachutecleanup();
    _id_CB229DAEFB97C2EE(vehicle, seatid, _id_FC7C7A874B43A31A, player, data);
  }
}

_id_CB229DAEFB97C2EE(vehicle, seatid, _id_FC7C7A874B43A31A, player, data) {
  if(seatid == "driver") {
    vehicle thread vehicle_handleflarefire(player);
    vehicle notify("palfa_driver_enter");
    vehicle.ishovering = 0;
    vehicle _meth_6A325F91941ED47C("p2p");
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(vehicle, _id_FC7C7A874B43A31A, seatid, player);

  if(isDefined(level._id_9215E3A9DFE8A262))
    [[level._id_9215E3A9DFE8A262]](vehicle, seatid, _id_FC7C7A874B43A31A, player, data);
}

_id_B8EFEDE8329D0DF1(vehicle, seatid, _id_7558F98F3236963D, player, data) {
  if(istrue(data.success))
    _id_D2053CEC6126F014(vehicle, seatid, _id_7558F98F3236963D, player, data);
}

_id_D2053CEC6126F014(vehicle, seatid, _id_7558F98F3236963D, player, data) {
  if(seatid == "driver") {
    vehicle notify("palfa_driver_exit");
    vehicle thread _id_619D5050126CBFAE(player);
  }

  if(!istrue(data.playerdisconnect)) {
    success = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit(vehicle, seatid, _id_7558F98F3236963D, player, data);

    if(!success) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "handleSuicideFromVehicles"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "handleSuicideFromVehicles")]](player);
      else
        player suicide();
    } else if(istrue(vehicle.israllypointvehicle))
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(vehicle.marker.objidnum, player);
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(vehicle, seatid, _id_7558F98F3236963D, player);
}

_id_619D5050126CBFAE(player) {
  if(!isalive(player)) {
    self endon("death");
    self endon("palfa_driver_enter");
    wait 0.5;
  }

  if(!self vehicle_isonground() && distance(self.origin, _id_653B91B3EDF76C93()) > 350 && !istrue(self.ishovering) && !istrue(self._id_E114008648967BFB)) {
    self.ishovering = 1;
    self _meth_D2E41C7603BA7697("p2p");
  }
}

_id_653B91B3EDF76C93() {
  contents = scripts\engine\trace::create_solid_ai_contents(1);
  _id_41302AFFD456FCB3 = self.origin - anglestoup(self.angles) * 400;
  pos = scripts\engine\trace::sphere_trace(self.origin, _id_41302AFFD456FCB3, 100, [self], contents)["position"];
  return pos;
}

_id_90EDB9E4CBF08215(vehicle, _id_9DE41F2EE77C33BA, _id_3F68C37BAFD38606, player, data) {}

vehicle_handleflarerecharge() {
  self endon("death");

  for(;;) {
    driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self);

    if(self.flareready) {
      if(isDefined(driver)) {
        if(driver getclientomnvar("ui_veh_flares_charge_perc") < 1.05) {
          driver setclientomnvar("ui_veh_flares_charge_perc", 1.05);
          scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("veh9_palfa", "flares", 1, driver);
        }
      }
    } else {
      _id_C770D2AE1CC0B405 = 0;

      while(_id_C770D2AE1CC0B405 < self.flarecooldown) {
        wait 0.05;
        _id_C770D2AE1CC0B405 = _id_C770D2AE1CC0B405 + 0.05;
        _id_E9227A816ED1D671 = _id_C770D2AE1CC0B405 / self.flarecooldown;
        driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self);

        if(isDefined(driver))
          driver setclientomnvar("ui_veh_flares_charge_perc", _id_E9227A816ED1D671);
      }

      self.flareready = 1;
    }

    waitframe();
  }
}

vehicle_handleflarefire(player) {
  self endon("death");
  self endon("palfa_driver_exit");
  player endon("death_or_disconnect");
  player endon("vehicle_exit");
  player notifyonplayercommand("shoot_flare", "+attack");
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("veh9_palfa", "flares", scripts\engine\utility::ter_op(self.flareready, 1, 0), player);

  for(;;) {
    player waittill("shoot_flare");

    if(!self.flareready) {
      self playsoundtoplayer("lbravo_noflares_warning", player);
      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "playFx"))
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "playFx")]](undefined, "tag_deathfx");

    newtarget = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "deploy"))
      newtarget = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "deploy")]]();

    if(isDefined(level.missiles)) {
      foreach(missile in level.missiles) {
        if(!isDefined(missile.origin) || !isDefined(missile.lockontarget) || missile.lockontarget != self) {
          continue;
        }
        _id_6B40B4C28ABE0A05 = distance(self.origin, missile.origin);

        if(_id_6B40B4C28ABE0A05 < 4000) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "doScoreEvent"))
            player thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "doScoreEvent")]]("manual_flare_missile_redirect");

          scripts\cp_mp\utility\weapon_utility::clearprojectilelockedon(missile);
          missile missile_settargetEnt(newtarget);
          missile notify("missile_pairedWithFlare");
        }
      }
    }

    self.flareready = 0;
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("veh9_palfa", "flares", 0, player);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_fadeoutcontrols(player);
  }
}

_id_DEC1987F9EE988C6() {
  self._id_C499E51D0595F94B = 1;

  foreach(player in self._id_8784C427B1AF24A6)
  _id_6FF4F91590D55DF6(player);
}

_id_153A6ACCF001DFF6(player) {
  if(isDefined(self._id_675F44ED226AED7D))
    self[[self._id_675F44ED226AED7D]](player);

  if(!istrue(self._id_C547488F80D3EB28))
    scripts\cp_mp\utility\vehicle_omnvar_utility::_id_D2D9C09551D91164(self, player);

  if(!isDefined(level._id_B531611B8D662DB7))
    level._id_B531611B8D662DB7 = getdvarint("dvar_0DEE18061C0D4DFE", scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508(), 0, 1)) == 1;

  if(level._id_B531611B8D662DB7 || istrue(self._id_C499E51D0595F94B)) {
    vehicleteam = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getteamfriendlyto(self);

    if(istrue(self._id_C499E51D0595F94B) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "onEnterOOBTrigger"))
      _id_6FF4F91590D55DF6(player);
    else if(isDefined(vehicleteam) && isDefined(player.team) && vehicleteam != "neutral" && vehicleteam != player.team && scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "onEnterOOBTrigger"))
      _id_6FF4F91590D55DF6(player);
    else
      player._id_1F34845FDD0A6631 = undefined;
  }

  scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_stopwatchingabandoned();
}

_id_71ADB8F84C3DF6BB(player) {
  if(isDefined(player)) {
    if(!isDefined(player.vehicle) && !istrue(self._id_C547488F80D3EB28))
      scripts\cp_mp\utility\vehicle_omnvar_utility::_id_5211953231A09ED5(self, player);

    if(isDefined(self._id_7B468990DA46C73C))
      self[[self._id_7B468990DA46C73C]](player);

    if(istrue(player._id_1F34845FDD0A6631) && isDefined(player.oob) && player.oob > 0 && scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "onExitOOBTrigger"))
      _id_6307FFE7F40FC2D0(player);
  }

  thread scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_watchabandoned();
}

_id_6FF4F91590D55DF6(player) {
  player._id_1F34845FDD0A6631 = 1;
  scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("game", "onEnterOOBTrigger", self, player);
}

_id_6307FFE7F40FC2D0(player) {
  scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("game", "onExitOOBTrigger", self, player);
}

_id_3D25AF3A88AD31C3(player) {
  if(!isDefined(self) || !isalive(self) || !isDefined(self.origin) || !isDefined(player) || !isDefined(player.origin))
    return 0;

  return _id_53AAC5AE7D2AC1B4::_id_773691F1A617F7D9(player.origin);
}

_id_3FFE455E5EA6D0F5(player) {
  player setclienttriggeraudiozonepartial("iw9_palfa_interior", "reverb", "weapon_reflection");
}

_id_B2CC563ED7324A8D(player) {
  if(isDefined(player))
    player clearclienttriggeraudiozone(0.5);
}