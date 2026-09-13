/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1d1ef0f036ac0ed.gsc
***********************************************/

main() {
  scripts\cp_mp\vehicles\vehicle::_id_C0B3DDC9A6BDCC46("apc_russian", ::apc_rus_init);
}

apc_rus_init() {
  if(!scripts\cp_mp\vehicles\vehicle::_id_9697379150687859("apc_russian") && scripts\engine\utility::getStructArray("rallyPointAPC", "targetname").size == 0) {
    return;
  }
  scripts\engine\utility::create_func_ref("set_vehicle_anims_apc", ::set_vehicle_anims_apc);
  scripts\engine\utility::create_func_ref("set_vehicle_anims_vindia", ::set_vehicle_anims_vindia);
  callbacks["enterEnd"] = ::apc_rus_enterend;
  callbacks["exitEnd"] = ::apc_rus_exitend;
  callbacks["update"] = ::apc_rus_update;
  callbacks["spawn"] = ::apc_rus_create;
  scripts\cp_mp\vehicles\vehicle::_id_08497E7E46B5E397("apc_russian", callbacks);
  apc_rus_initomnvars();
  apc_rus_initdamage();
  apc_rus_initfx();
  scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328("apc_russian")._id_528C63BF357FB963 = getdvarint("dvar_F73768D95DD26D25", 8);
}

#using_animtree("mp_vehicles_always_loaded");

set_vehicle_anims_apc(_id_E4B7E99A96C8829F) {
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim = % vh_apc_org_unload_door_l;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_clear = 0;
  _id_E4B7E99A96C8829F[2].vehicle_getoutanim = % vh_apc_org_unload_door_r;
  _id_E4B7E99A96C8829F[2].vehicle_getoutanim_clear = 0;
  _id_E4B7E99A96C8829F[4].vehicle_getoutanim = % vh_apc_org_unload_door_back;
  _id_E4B7E99A96C8829F[4].vehicle_getoutanim_clear = 0;
  return _id_E4B7E99A96C8829F;
}

set_vehicle_anims_vindia(_id_E4B7E99A96C8829F) {
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim = % vh_vindia_back_door_exit_combat_idle;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_clear = 0;
  _id_E4B7E99A96C8829F[4].vehicle_getoutanim = % vh_vindia_left_door_exit_combat_idle;
  _id_E4B7E99A96C8829F[4].vehicle_getoutanim_clear = 0;
  _id_E4B7E99A96C8829F[5].vehicle_getoutanim = % vh_vindia_right_door_exit_combat_idle;
  _id_E4B7E99A96C8829F[5].vehicle_getoutanim_clear = 0;
  return _id_E4B7E99A96C8829F;
}

apc_rus_initomnvars() {
  _id_E2818AD39A3341B4 = scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_getleveldataforvehicle("apc_russian", 1);
  _id_E2818AD39A3341B4.ammoids["driverTurret"] = 0;
  _id_E2818AD39A3341B4.rotationids["chassis"] = 0;
  _id_E2818AD39A3341B4.rotationids["turret"] = 1;
  _id_E2818AD39A3341B4.rotationrefsbyseatandweapon["driver"]["apc_rus_mp"] = "chassis";
  _id_E2818AD39A3341B4.rotationrefsbyseatandweapon["driver"]["iw9_tur_apc_russian_mp"] = "turret";
  _id_E2818AD39A3341B4.rotationrefsbyseatandweapon["front_left"]["apc_rus_mp"] = "chassis";
  _id_E2818AD39A3341B4.rotationrefsbyseatandweapon["front_left"]["iw9_tur_apc_russian_mp"] = "turret";
  _id_E2818AD39A3341B4.rotationrefsbyseatandweapon["front_right"]["apc_rus_mp"] = "chassis";
  _id_E2818AD39A3341B4.rotationrefsbyseatandweapon["front_right"]["iw9_tur_apc_russian_mp"] = "turret";
  _id_E2818AD39A3341B4.rotationrefsbyseatandweapon["back_right"]["apc_rus_mp"] = "chassis";
  _id_E2818AD39A3341B4.rotationrefsbyseatandweapon["back_right"]["iw9_tur_apc_russian_mp"] = "turret";
  _id_E2818AD39A3341B4.rotationrefsbyseatandweapon["back_left"]["apc_rus_mp"] = "chassis";
  _id_E2818AD39A3341B4.rotationrefsbyseatandweapon["back_left"]["iw9_tur_apc_russian_mp"] = "turret";
  _id_E2818AD39A3341B4.rotationrefsbyseatandweapon["back"]["apc_rus_mp"] = "chassis";
  _id_E2818AD39A3341B4.rotationrefsbyseatandweapon["back"]["iw9_tur_apc_russian_mp"] = "turret";
}

apc_rus_initdamage() {
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setpremoddamagecallback("apc_russian", ::apc_rus_premoddamagecallback);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setpostmoddamagecallback("apc_russian", ::apc_rus_postmoddamagecallback);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setweaponhitdamagedata("iw9_tur_apc_russian_mp", 2);
}

apc_rus_initfx() {
  level._effect["apc_rus_explode_alt"] = loadfx("vfx/iw8_mp/vehicle/vfx_rusapc_mp_death_west_exp.vfx");
}

apc_rus_create(spawndata, _id_EE8DA5624236DC89) {
  if(!isDefined(spawndata.angles))
    spawndata.angles = (0, 0, 0);

  if(istrue(spawndata.usealtmodel))
    spawndata.modelname = "veh8_mil_lnd_vindia_a1_physics_mp_composite";
  else
    spawndata.modelname = "veh8_mil_lnd_vindia_a1_physics_mp_composite";

  spawndata.targetname = "apc_russian";
  spawndata.vehicletype = "vindia_physics_mp";
  vehicle = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(spawndata, _id_EE8DA5624236DC89);

  if(!isDefined(vehicle))
    return undefined;

  scripts\cp_mp\vehicles\vehicle::vehicle_create(vehicle, "apc_russian", spawndata);
  vehicle.objweapon = makeweapon("apc_rus_mp");
  _id_B101137988B007D7 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getinstancedataforvehicle(vehicle, 1);
  _id_B101137988B007D7.destroyscoreevent = "none";
  _id_B101137988B007D7.destroyaward = "kill_apc_rus";
  _id_B101137988B007D7.destroyawardlaunchonly = 1;
  scripts\cp_mp\vehicles\vehicle::vehicle_createlate(vehicle, spawndata);
  vehicle thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped();
  vehicle thread scripts\cp_mp\vehicles\vehicle::_id_1B69321FF9937FC5();
  vehicle thread apc_rus_monitordriverturretfire();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("apc_russian", "create"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("apc_russian", "create")]](vehicle);

  return vehicle;
}

apc_rus_premoddamagecallback(data) {
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
    data.isrearcriticaldamage = apc_rus_damagecancriticalhit(data);

  return 1;
}

apc_rus_postmoddamagecallback(data) {
  if(istrue(data.isrearcriticaldamage))
    data.damage = int(data.damage * 1.6);

  return 1;
}

apc_rus_damagecancriticalhit(data) {
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

apc_rus_enterend(vehicle, seatid, _id_FC7C7A874B43A31A, player, data) {
  if(istrue(data.success))
    apc_rus_enterendinternal(vehicle, seatid, _id_FC7C7A874B43A31A, player, data);

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

apc_rus_enterendinternal(vehicle, seatid, _id_FC7C7A874B43A31A, player, data) {
  if(seatid == "driver") {
    player cameradefault();
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(player, 100);
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(vehicle, _id_FC7C7A874B43A31A, seatid, player);
  apc_rus_updateomnvarsonseatenter(vehicle, _id_FC7C7A874B43A31A, seatid, player);

  if(seatid == "driver")
    vehicle thread apc_rus_monitordriverturretreload(player);
}

apc_rus_exitend(vehicle, seatid, _id_7558F98F3236963D, player, data) {
  if(istrue(data.success))
    apc_rus_exitendinternal(vehicle, seatid, _id_7558F98F3236963D, player, data);
}

apc_rus_exitendinternal(vehicle, seatid, _id_7558F98F3236963D, player, data) {
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

apc_rus_update(data) {
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_updatemovefeedback("driver");
}

apc_rus_monitordriverturretfire() {
  self endon("death");
  apc_rus_updatedriverturretammoui();

  for(;;) {
    scripts\engine\utility::waittill_any_2("vehicle_turret_fire", "vehicle_turret_reload_end");
    apc_rus_updatedriverturretammoui();
  }
}

apc_rus_driverturretreload() {
  turret = scripts\cp_mp\vehicles\vehicle::vehicle_getturretbyweapon(self, "iw9_tur_apc_russian_mp");
  turret turretfiredisable();
  driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "driver");

  if(isDefined(driver))
    driver playlocalsound("weap_bradley_reload_plr");

  foreach(_id_F90358454413407F in level.teamnamelist)
  self playsoundtoteam("weap_bradley_reload_npc", _id_F90358454413407F, driver);

  wait 2.7;
  apc_rus_adjustdriverturretammo(_id_96CDA9BDF4FD4440());
  wait 0.15;
  turret turretfireenable();
}

apc_rus_monitordriverturretreload(driver) {
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
          apc_rus_updatedriverturretammoui();
          break;
        } else {
          if(self _meth_AB2BDDB6CD03A29D() < weaponclipsize("iw9_tur_apc_russian_mp") && _id_930201649EAF32AF > 0 && holdtime >= _id_33193F537B85B6D4) {
            self _meth_4012509DBD1CEE6F();
            _id_72E25A59FCEF57B5 = 1;
            apc_rus_updatedriverturretammoui();
          }

          holdtime = holdtime + level.framedurationseconds;
          waitframe();
        }
      }

      if(!_id_72E25A59FCEF57B5 && driver usinggamepad() && self _meth_AB2BDDB6CD03A29D() < weaponclipsize("iw9_tur_apc_russian_mp") && (_id_930201649EAF32AF == 0 && holdtime > 0.0 && holdtime < 0.2 || _id_930201649EAF32AF > 0 && holdtime >= _id_33193F537B85B6D4)) {
        self _meth_4012509DBD1CEE6F();
        apc_rus_updatedriverturretammoui();
      }

      waitframe();
    }
  }
}

apc_rus_adjustdriverturretammo(amount) {
  turret = scripts\cp_mp\vehicles\vehicle::vehicle_getturretbyweapon(self, "iw9_tur_apc_russian_mp");
  turret.shotsleft = turret.shotsleft + amount;
  turret.shotsleft = int(clamp(turret.shotsleft, 0, _id_96CDA9BDF4FD4440()));
  apc_rus_updatedriverturretammoui();
}

_id_96CDA9BDF4FD4440() {
  if(isDefined(level._id_468B95F3865FA8D3)) {
    count = [[level._id_468B95F3865FA8D3]](self);

    if(isDefined(count))
      return count;
  }

  _id_E2818AD39A3341B4 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("apc_russian");
  return _id_E2818AD39A3341B4._id_528C63BF357FB963;
}

apc_rus_updateomnvarsonseatenter(vehicle, _id_FC7C7A874B43A31A, seatid, player) {
  if(seatid == "driver")
    vehicle apc_rus_updatedriverturretammoui();
}

apc_rus_updatedriverturretammoui() {
  driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "driver");

  if(isDefined(driver))
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("apc_russian", "driverTurret", self _meth_AB2BDDB6CD03A29D(), driver);
}