/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_69a61780e1cc21a9.gsc
***********************************************/

main() {
  scripts\cp_mp\vehicles\vehicle::_id_C0B3DDC9A6BDCC46("little_bird", ::little_bird_init);
}

little_bird_init() {
  if(!scripts\cp_mp\vehicles\vehicle::_id_9697379150687859("little_bird")) {
    return;
  }
  level.lb_dmg_factor_fuselage = getdvarfloat("dvar_00CAAF89C827EC21", 1.0);
  level.lb_dmg_factor_tail_stabilizer = getdvarfloat("dvar_B169F648E4E1B87F", 1.0);
  level.lb_dmg_factor_main_rotor = getdvarfloat("dvar_78352418B2460F21", 1.2);
  level.lb_dmg_factor_tail_rotor = getdvarfloat("dvar_B522E174EC772A4A", 1.0);
  level.lb_dmg_factor_landing_gear = getdvarfloat("dvar_C2DC6A2C32C62F18", 0.5);
  level.lb_dmg_factor_driverless_collision = getdvarfloat("dvar_E85CDA72D3C3C14B", 3.0);
  level.lb_impulse_dmg_threshold_top = getdvarfloat("dvar_3D4B0C0E7008D889", 0.9);
  level.lb_impulse_dmg_threshold_mid = getdvarfloat("dvar_EEACED8FD62D7D31", 0.5);
  level.lb_impulse_dmg_threshold_low = getdvarfloat("dvar_FADA138FDE409535", 0.2);
  level.lb_impulse_dmg_factor_low = getdvarfloat("dvar_12C7A9C89BF6ED57", 0.1);
  level.lb_impulse_dmg_factor_mid_low = getdvarfloat("dvar_DC50E2E689514B56", 0.2);
  level.lb_impulse_dmg_factor_mid_high = getdvarfloat("dvar_555A8558A6D3B598", 0.75);
  level.lb_pitch_roll_dmg_threshold = getdvarfloat("dvar_F1D6BA97F092C311", 55.0);
  level.lb_pitch_roll_dmg_factor = getdvarfloat("dvar_C606EFB22605E501", 10.0);
  level.lb_wood_surf_dmg_scalar = getdvarfloat("dvar_4D381994CF7E3FAA", 0.6);
  callbacks = [];
  callbacks["spawn"] = ::little_bird_create;
  callbacks["enterStart"] = ::little_bird_enterstart;
  callbacks["enterEnd"] = ::little_bird_enterend;
  callbacks["exitEnd"] = ::little_bird_exitend;
  scripts\cp_mp\vehicles\vehicle::_id_08497E7E46B5E397("little_bird", callbacks);
  little_bird_initdamage();
  little_bird_initomnvars();
}

little_bird_initomnvars() {
  _id_E2818AD39A3341B4 = scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_getleveldataforvehicle("little_bird");
  _id_E2818AD39A3341B4.ammoids["flares"] = 1;
}

little_bird_initdamage() {
  _id_D2E455D494F8D46E = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldatafordamagestate("little_bird", "heavy", 1);
  _id_D2E455D494F8D46E.onentercallback = ::little_bird_onenterheavydamagestate;
  _id_D2E455D494F8D46E.onexitcallback = ::little_bird_onexitheavydamagestate;
}

little_bird_create(spawndata, _id_EE8DA5624236DC89) {
  spawndata.cannotbesuspended = 1;
  vehicle = scripts\cp_mp\vehicles\vehicle::_id_BBA34CF920370FF4("little_bird", spawndata, _id_EE8DA5624236DC89);

  if(!isDefined(vehicle))
    return undefined;

  vehicle.borntime = gettime();
  vehicle.flareslive = [];
  vehicle.flareready = 1;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    vehicle.flarecooldown = 35;
  else
    vehicle.flarecooldown = 10;

  vehicle thread vehicle_handleflarerecharge();
  vehicle thread collision_damage_watcher();
  vehicledata = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328("little_bird");

  if(istrue(vehicledata.ai._id_289DF80E1DED586F) && istrue(spawndata._id_F16652E1462A3739)) {
    vehicle.unload_land_offset = 112;
    vehicle.unload_hover_offset = 120;
    vehicle.script_badplace = 0;
    vehicle vehicle_setspeed(60, 20, 10);
    vehicle._id_22AA4AA0CF0AA6BB = 1;
    vehicle._id_A8F4BB03B366AA80 = 1;
    vehicle.deathfunc = scripts\cp_mp\vehicles\vehicle::vehicle_death;
    vehicle scripts\cp_mp\vehicles\vehicle_occupancy::_id_A91927DF280E94E4();
  }

  return vehicle;
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
    if(istrue(self._id_A1A5D39C25C6D70B)) {
      continue;
    }
    damagefactor = normalspeed;

    if(isDefined(self._id_70EC04F736523DD0))
      damagefactor = damagefactor * (self vehicle_gettopspeedforward() / self._id_70EC04F736523DD0);

    driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self);

    if(!isDefined(driver))
      damagefactor = damagefactor * level.lb_dmg_factor_driverless_collision;

    pitch = self.angles[0];

    if(pitch > 180)
      pitch = pitch - 360;

    if(abs(pitch > level.lb_pitch_roll_dmg_threshold))
      damagefactor = damagefactor * level.lb_pitch_roll_dmg_factor;

    roll = self.angles[2];

    if(roll > 180)
      roll = roll - 360;

    if(abs(roll > level.lb_pitch_roll_dmg_threshold))
      damagefactor = damagefactor * level.lb_pitch_roll_dmg_factor;

    _id_2D65C754072C9542 = 0;

    if(damagefactor > level.lb_impulse_dmg_threshold_top)
      _id_2D65C754072C9542 = self.maxhealth;
    else if(damagefactor > level.lb_impulse_dmg_threshold_mid) {
      range = level.lb_impulse_dmg_threshold_top - level.lb_impulse_dmg_threshold_mid;
      _id_6D3017665EC227E0 = (damagefactor - level.lb_impulse_dmg_threshold_mid) / range;
      _id_ED91F3EC33AF8C15 = self.maxhealth * level.lb_impulse_dmg_factor_mid_low;
      _id_8516B2BF8F4DA6D7 = self.maxhealth * level.lb_impulse_dmg_factor_mid_high;
      _id_2D65C754072C9542 = scripts\engine\math::lerp(_id_ED91F3EC33AF8C15, _id_8516B2BF8F4DA6D7, _id_6D3017665EC227E0);
    } else if(damagefactor > level.lb_impulse_dmg_threshold_low)
      _id_2D65C754072C9542 = self.maxhealth * level.lb_impulse_dmg_factor_low;

    if(_id_2D65C754072C9542 > 0) {
      if(isDefined(driver) && flag1 == 11534336)
        _id_2D65C754072C9542 = _id_2D65C754072C9542 * level.lb_wood_surf_dmg_scalar;

      scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_disablestatedamagefloor(1);
      self dodamage(_id_2D65C754072C9542, position, undefined, undefined, "MOD_CRUSH");
      scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_disablestatedamagefloor(0);
    }

    wait 0.5;
  }
}

little_bird_onenterheavydamagestate(_id_1AE0AEB37C917298, data) {
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_onenterstateheavy(_id_1AE0AEB37C917298, data);
}

little_bird_onexitheavydamagestate(_id_1AE0AEB37C917298, data) {
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_onexitstateheavy(_id_1AE0AEB37C917298, data);
}

little_bird_enterstart(vehicle, seatid, _id_FC7C7A874B43A31A, player, data) {
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

little_bird_enterend(vehicle, seatid, _id_FC7C7A874B43A31A, player, data) {
  if(istrue(data.success)) {
    player scripts\cp_mp\parachute::parachutecleanup();
    little_bird_enterendinternal(vehicle, seatid, _id_FC7C7A874B43A31A, player, data);
  }
}

little_bird_enterendinternal(vehicle, seatid, _id_FC7C7A874B43A31A, player, data) {
  if(seatid == "driver") {
    vehicle thread vehicle_handleflarefire(player);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pmc_missions", "onEnterMediumBird"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("pmc_missions", "onEnterMediumBird")]](vehicle, seatid, _id_FC7C7A874B43A31A, player, data);
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(vehicle, _id_FC7C7A874B43A31A, seatid, player);

  if(isDefined(level._id_9215E3A9DFE8A262))
    [[level._id_9215E3A9DFE8A262]](vehicle, seatid, _id_FC7C7A874B43A31A, player, data);
}

little_bird_exitend(vehicle, seatid, _id_7558F98F3236963D, player, data) {
  if(istrue(data.success))
    little_bird_exitendinternal(vehicle, seatid, _id_7558F98F3236963D, player, data);
}

little_bird_exitendinternal(vehicle, seatid, _id_7558F98F3236963D, player, data) {
  if(seatid == "driver")
    vehicle notify("little_bird_driver_exit");

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

vehicle_handleflarerecharge() {
  _id_E9227A816ED1D671 = 1.05;
  self endon("death");

  for(;;) {
    driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self);

    if(self.flareready) {
      if(isDefined(driver)) {
        if(driver getclientomnvar("ui_veh_flares_charge_perc") < 1.05) {
          driver setclientomnvar("ui_veh_flares_charge_perc", 1.05);
          scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("little_bird", "flares", 1, driver);
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
  self endon("little_bird_driver_exit");
  player endon("death_or_disconnect");
  player endon("vehicle_exit");
  player notifyonplayercommand("shoot_flare", "+attack");
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("little_bird", "flares", scripts\engine\utility::ter_op(self.flareready, 1, 0), player);

  for(;;) {
    player waittill("shoot_flare");

    if(!self.flareready) {
      self playsoundtoplayer("lbravo_noflares_warning", player);
      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "playFx"))
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "playFx")]]();

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
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("little_bird", "flares", 0, player);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_fadeoutcontrols(player);
  }
}