/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\quaked\script_struct_mp_iw9_apc_8x8.gsc
***********************************************************/

main() {
  scripts\cp_mp\vehicles\vehicle::_id_C0B3DDC9A6BDCC46("veh9_apc_8x8", ::_id_488998CACB2BD88D);
}

_id_488998CACB2BD88D() {
  if(!scripts\cp_mp\vehicles\vehicle::_id_9697379150687859("veh9_apc_8x8")) {
    return;
  }
  callbacks["enterEnd"] = ::_id_8CD2392376DB14B4;
  callbacks["exitEnd"] = ::_id_6896DF4F69C410F0;
  callbacks["update"] = ::_id_A7FA2D6F6BC0B312;
  callbacks["spawn"] = ::_id_2C74B512A59DDBE3;
  scripts\cp_mp\vehicles\vehicle::_id_08497E7E46B5E397("veh9_apc_8x8", callbacks);
  _id_A4DA9E788F6EAC5F();
  _id_299E9968E72A6BD8();
  scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328("veh9_apc_8x8")._id_528C63BF357FB963 = getdvarint("dvar_F73768D95DD26D25", 8);
}

_id_A4DA9E788F6EAC5F() {
  _id_E2818AD39A3341B4 = scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_getleveldataforvehicle("veh9_apc_8x8", 1);
  _id_E2818AD39A3341B4.ammoids["driverTurret"] = 0;
  _id_E2818AD39A3341B4.rotationids["chassis"] = 0;
  _id_E2818AD39A3341B4._id_5A086ECCE9CE54AE = "iw9_tur_apc_russian_mp";
  _id_E2818AD39A3341B4.rotationrefsbyseatandweapon["driver"]["apc_rus_mp"] = "chassis";
  _id_E2818AD39A3341B4.rotationrefsbyseatandweapon["front_left"]["iw9_tur_apc_russian_mp"] = "chassis";
  _id_E2818AD39A3341B4.rotationrefsbyseatandweapon["front_right"]["iw9_tur_apc_russian_mp"] = "chassis";
  _id_E2818AD39A3341B4.rotationrefsbyseatandweapon["back_right"]["iw9_tur_apc_russian_mp"] = "chassis";
  _id_E2818AD39A3341B4.rotationrefsbyseatandweapon["back_left"]["iw9_tur_apc_russian_mp"] = "chassis";
  _id_E2818AD39A3341B4.rotationrefsbyseatandweapon["back"]["iw9_tur_apc_russian_mp"] = "chassis";
}

_id_299E9968E72A6BD8() {
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setpremoddamagecallback("veh9_apc_8x8", ::_id_80A2F71BFA81E0D2);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setpostmoddamagecallback("veh9_apc_8x8", ::_id_E0560A4879EF9415);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setweaponhitdamagedata("iw9_tur_apc_russian_mp", 2);
}

_id_2C74B512A59DDBE3(spawndata, _id_EE8DA5624236DC89) {
  vehicle = scripts\cp_mp\vehicles\vehicle::_id_BBA34CF920370FF4("veh9_apc_8x8", spawndata, _id_EE8DA5624236DC89);
  _id_B101137988B007D7 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getinstancedataforvehicle(vehicle, 1);
  _id_B101137988B007D7.destroyscoreevent = "none";
  _id_B101137988B007D7.destroyaward = "kill_apc_rus";
  _id_B101137988B007D7.destroyawardlaunchonly = 1;
  vehicle thread _id_A3413BA13B12F41F();
  return vehicle;
}

_id_80A2F71BFA81E0D2(data) {
  if(scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_isselfdamage(self, data))
    return 0;

  _id_6B11D3047F506FB6 = self.origin - data.point;
  normal = anglestoup(self.angles);
  dist = vectordot(_id_6B11D3047F506FB6, normal);
  _id_D74074AD5396E58A = data.point + normal * dist;
  _id_C47F1816352556DD = vectorNormalize(_id_D74074AD5396E58A - self.origin);
  forward = anglesToForward(self.angles);
  right = anglestoright(self.angles);
  _id_D726822C713445C2 = getdvarfloat("dvar_45D4631DF7323C01", -0.892);

  if(vectordot(_id_C47F1816352556DD, forward) < _id_D726822C713445C2)
    data.isrearcriticaldamage = _id_F9CFC875FAFF6DBE(data);

  return 1;
}

_id_E0560A4879EF9415(data) {
  if(istrue(data.isrearcriticaldamage))
    data.damage = int(data.damage * 1.6);

  return 1;
}

_id_F9CFC875FAFF6DBE(data) {
  if(isDefined(data.inflictor) && isDefined(data.inflictor.weapon_name) && data.inflictor.weapon_name == "gl")
    return isDefined(data.meansofdeath) && data.meansofdeath == "MOD_GRENADE";

  if(isDefined(data.objweapon) && isDefined(data.objweapon.basename)) {
    switch (data.objweapon.basename) {
      case "iw9_tur_light_tank_mp":
        return isDefined(data.meansofdeath) && (data.meansofdeath == "MOD_PROJECTILE" || data.meansofdeath == "MOD_RIFLE_BULLET");
      case "iw8_la_rpapa7_mp":
      case "iw9_tur_apc_russian_mp":
      case "pac_sentry_turret_mp":
      case "iw8_la_gromeoks_mp":
      case "iw8_la_gromeo_mp":
      case "iw9_la_gromeo_mp":
        return isDefined(data.meansofdeath) && data.meansofdeath == "MOD_PROJECTILE";
      case "iw8_la_kgolf_mp":
        return isDefined(data.meansofdeath) && data.meansofdeath == "MOD_GRENADE";
    }
  }

  return 0;
}

_id_8CD2392376DB14B4(vehicle, seatid, _id_FC7C7A874B43A31A, player, data) {
  if(istrue(data.success))
    _id_A9592FD0C9C9C19D(vehicle, seatid, _id_FC7C7A874B43A31A, player, data);

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

_id_A9592FD0C9C9C19D(vehicle, seatid, _id_FC7C7A874B43A31A, player, data) {
  if(seatid == "driver") {
    player cameradefault();
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(player, 100);
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(vehicle, _id_FC7C7A874B43A31A, seatid, player);
  _id_8A1EAB7C9242A820(vehicle, _id_FC7C7A874B43A31A, seatid, player);

  if(seatid == "driver")
    vehicle thread _id_8A5F78F0C60E3E1A(player);
}

_id_6896DF4F69C410F0(vehicle, seatid, _id_7558F98F3236963D, player, data) {
  if(istrue(data.success))
    _id_074ADB461A2BE931(vehicle, seatid, _id_7558F98F3236963D, player, data);
}

_id_074ADB461A2BE931(vehicle, seatid, _id_7558F98F3236963D, player, data) {
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

_id_A7FA2D6F6BC0B312(data) {
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_updatemovefeedback("driver");
}

_id_A3413BA13B12F41F() {
  self endon("death");
  _id_0F3B33FFCC3787A2();

  for(;;) {
    scripts\engine\utility::waittill_any_2("vehicle_turret_fire", "vehicle_turret_reload_end");
    _id_0F3B33FFCC3787A2();
  }
}

_id_8A5F78F0C60E3E1A(driver) {
  self endon("death");

  if(isDefined(driver)) {
    driver endon("vehicle_change_seat");
    driver endon("vehicle_seat_exit");
    driver endon("death_or_disconnect");

    while(driver reloadbuttonPressed())
      waitframe();

    _id_33193F537B85B6D4 = getdvarint("bg_useholdtimeshort", 250) / 1000;

    for(;;) {
      holdtime = 0.0;
      _id_930201649EAF32AF = driver getcurrentusereloadconfig();
      _id_72E25A59FCEF57B5 = 0;

      while(driver reloadbuttonPressed()) {
        if(!driver usinggamepad() && self _meth_AB2BDDB6CD03A29D() < weaponclipsize("iw9_tur_apc_russian_mp")) {
          self _meth_4012509DBD1CEE6F();
          _id_72E25A59FCEF57B5 = 1;
          _id_0F3B33FFCC3787A2();
          break;
        } else {
          if(self _meth_AB2BDDB6CD03A29D() < weaponclipsize("iw9_tur_apc_russian_mp") && _id_930201649EAF32AF > 0 && holdtime >= _id_33193F537B85B6D4) {
            self _meth_4012509DBD1CEE6F();
            _id_72E25A59FCEF57B5 = 1;
            _id_0F3B33FFCC3787A2();
          }

          holdtime = holdtime + level.framedurationseconds;
          waitframe();
        }
      }

      if(!_id_72E25A59FCEF57B5 && driver usinggamepad() && self _meth_AB2BDDB6CD03A29D() < weaponclipsize("iw9_tur_apc_russian_mp") && (_id_930201649EAF32AF == 0 && holdtime > 0.0 && holdtime < 0.2 || _id_930201649EAF32AF > 0 && holdtime >= _id_33193F537B85B6D4)) {
        self _meth_4012509DBD1CEE6F();
        _id_0F3B33FFCC3787A2();
      }

      waitframe();
    }
  }
}

_id_B26F847A5594D2A2(amount) {
  turret = scripts\cp_mp\vehicles\vehicle::vehicle_getturretbyweapon(self, "iw9_tur_apc_russian_mp");
  turret.shotsleft = turret.shotsleft + amount;
  turret.shotsleft = int(clamp(turret.shotsleft, 0, _id_7585A70307DF520F()));
  _id_0F3B33FFCC3787A2();
}

_id_7585A70307DF520F() {
  if(isDefined(level._id_468B95F3865FA8D3)) {
    count = [[level._id_468B95F3865FA8D3]](self);

    if(isDefined(count))
      return count;
  }

  _id_E2818AD39A3341B4 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("veh9_apc_8x8");
  return _id_E2818AD39A3341B4._id_528C63BF357FB963;
}

_id_8A1EAB7C9242A820(vehicle, _id_FC7C7A874B43A31A, seatid, player) {
  if(seatid == "driver")
    vehicle _id_0F3B33FFCC3787A2();
}

_id_0F3B33FFCC3787A2() {
  driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "driver");

  if(isDefined(driver))
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("veh9_apc_8x8", "driverTurret", self _meth_AB2BDDB6CD03A29D(), driver);
}