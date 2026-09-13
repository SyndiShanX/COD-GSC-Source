/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7af29c0d11278dba.gsc
***********************************************/

_id_9C5F65BACCB9CCEC() {
  level._id_3D5926814791F8C2 = scripts\engine\utility::_id_53C4C53197386572(level._id_3D5926814791F8C2, []);
  setdvarifuninitialized("dvar_9F216FBCA05ADD65", 1);
  setdvarifuninitialized("dvar_BDB51F40F2309C7B", 1);
  setdvarifuninitialized("dvar_85D826E87FD8EA7E", 6);
  setdvarifuninitialized("dvar_C6DE790720B61CF6", 0);
  heli = _id_A742F2D93265DBE7();

  if(!isDefined(heli))
    return undefined;

  heli.death_fx_on_self = 1;
  heli.circle_radius = 3500;
  heli._id_A2838155288F4E2D = 0.5;
  heli.flaresreservecount = getdvarint("dvar_9F216FBCA05ADD65", 1);
  heli.flareslive = [];
  heli.target_ent = scripts\engine\utility::spawn_tag_origin();
  heli.target_ent show();
  heli.vehicle_skipdeathmodel = 1;
  heli._id_78DA61277C9DEE0A = ::heli_crash;
  heli._id_1F6F35745B7F63FE = 1;
  heli._id_6F81C60BA2B5B081 = (0, 0, 1500);
  heli thread scripts\engine\utility::delete_on_death(heli.target_ent);
  heli thread _id_3B1380574CDF5738();
  heli scripts\cp\helicopter\cp_helicopter::heli_mg_create("veh8_mil_air_ahotel64_turret_wm", "chopper_gunner_turret_cp", "tag_turret");
  scripts\cp\helicopter\cp_helicopter::_id_01F281293E100467(heli);
  heli thread _id_2CE7E339E2B77ACC();
  heli thread scripts\cp\helicopter\cp_helicopter::heli_damagemonitor(undefined, undefined, 25);
  heli thread scripts\cp\helicopter\cp_helicopter::_id_0208126A1361C976();
  level thread _id_2BBAFD88C0646D49(heli);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "handleIncomingStinger"))
    heli thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "handleIncomingStinger")]]();

  scripts\cp\helicopter\cp_helicopter::_id_D025DD1F241613D6(heli);
  heli._id_9ED6827753DB2370 = 50;
  heli._id_F9FF3A209AA9DB43 = 25;
  heli._id_434136CAD96E6F3A = 25;
  level._id_3D5926814791F8C2 = scripts\engine\utility::array_add(level._id_3D5926814791F8C2, heli);
  return heli;
}

_id_3B1380574CDF5738() {
  self waittill("crashing");
  level._id_3D5926814791F8C2 = scripts\engine\utility::array_remove(level._id_3D5926814791F8C2, self);
}

_id_0D80EE6CCE6D911A() {
  if(!isDefined(level._id_3D5926814791F8C2))
    return 0;

  return level._id_3D5926814791F8C2.size > 0;
}

_id_DE1818C76C17FB34(spawner, _id_A12B7492006BFEE6) {
  spawner._id_79FA6BD3C9BF6A0D = 1;
  heli = scripts\cp\cp_spawning_util::_id_94E3A9862B435632(spawner);

  if(!isDefined(heli))
    return undefined;

  if(istrue(_id_A12B7492006BFEE6))
    heli._id_DE3E96CD2601F574 = 1;

  level thread _id_F3BA59477F6DA148(heli);
  scripts\cp\helicopter\cp_helicopter::_id_D025DD1F241613D6(heli);
  heli.isheli = 1;
  heli vehicle_settopspeedforward(120);
  heli setscriptablepartstate("engine", "on");
  return heli;
}

_id_2CE7E339E2B77ACC() {
  _id_F204DACE25365C76 = "tag_pilot";

  if(!self tagexists(_id_F204DACE25365C76))
    _id_F204DACE25365C76 = "tag_pilot1";

  self.pilot = spawn("script_model", self gettagorigin(_id_F204DACE25365C76));
  self.pilot setModel("aq_pilot_fullbody_1");
  self.pilot linkTo(self, _id_F204DACE25365C76, (0, 0, -5), (0, 0, 0));
  self.pilot scriptmodelplayanimdeltamotion("vh_mindia8_pilot_idle");
  thread scripts\engine\utility::delete_on_death(self.pilot);
}

_id_17FE07A8B882F69C() {
  self endon("death");
  self.target_ent endon("death");

  for(;;) {
    wait 0.05;

    if(istrue(self._id_8901CB3DFA63E875)) {
      continue;
    }
    _id_55A01E81BDA4CC0C = _id_E7EA66BA00A0FA5B();

    if(!isDefined(_id_55A01E81BDA4CC0C)) {
      continue;
    }
    self.target_ent moveTo(_id_55A01E81BDA4CC0C, 0.05);
  }
}

_id_2BBAFD88C0646D49(heli) {
  heli endon("death");
  heli endon("crashing");
  level endon("game_ended");
  heli.rockets_ready = 1;
  heli._id_8901CB3DFA63E875 = 0;
  heli._id_4B048EED990A0102 = 1;
  heli._id_0EDFF35A4F2CD74E = 2;
  heli._id_116AD1E054E41093 = (0, 0, 1200);
  heli thread _id_17FE07A8B882F69C();
  _id_1CA6A8DDC71EF09F = 0;
  heli thread _id_A804E95AA955EF7B();

  for(;;) {
    vehicle = _id_AEAB160D1452A77E();

    if(!isDefined(vehicle)) {
      wait 1;

      if(!istrue(heli._id_8901CB3DFA63E875)) {
        heli clearlookatent();
        level thread _id_6EFE8AD8F8527B46(heli);
        heli._id_8901CB3DFA63E875 = 1;
      }

      continue;
    }

    heli._id_8901CB3DFA63E875 = 0;
    heli notify("stop_think");
    offset = (0, 0, 0);

    if(isDefined(vehicle.model)) {
      if(vehicle.model == "veh9_mil_lnd_cargo_truck_vehphys_cp")
        offset = (0, 0, -100);
      else if(vehicle.model == "veh9_civ_lnd_techo_rebel_armor_vehphys_cp")
        offset = (0, 0, -50);
    }

    heli.minigun settargetentity(vehicle, offset);
    _id_FECE2C56170697AD = heli _id_050FBAAA04630B77(vehicle);
    _id_CE0F3178F55FFF1E = (0, 0, 1200);

    if(getdvarint("dvar_FB550B9014E4AF8D", 850) != 850)
      _id_CE0F3178F55FFF1E = (0, 0, getdvarint("dvar_FB550B9014E4AF8D", 850));

    _id_FECE2C56170697AD = getgroundposition(_id_FECE2C56170697AD, 128, 1000, 1000) + _id_CE0F3178F55FFF1E;
    veh_speed = vehicle vehicle_getspeed();
    distsq = distance2dsquared(heli.origin, _id_FECE2C56170697AD);

    if(distsq > squared(2700) && !_id_1CA6A8DDC71EF09F)
      heli clearlookatent();
    else {
      heli setlookatent(vehicle);
      _id_1CA6A8DDC71EF09F = 1;
    }

    if(distsq > squared(2000)) {
      heli vehicle_setspeed(80, 60, 60);
      heli thread _id_B06360BE83F3EE98(_id_FECE2C56170697AD, 1, vehicle);
    } else {
      heli vehicle_setspeed(70, 35, 35);

      if(distsq > 512)
        heli thread _id_B06360BE83F3EE98(_id_FECE2C56170697AD, 1, vehicle);

      if(!istrue(heli._id_BAF5FEC88743C60C))
        heli thread scripts\cp\helicopter\cp_helicopter::shoot_at_target(vehicle);

      if(istrue(heli.rockets_ready)) {
        heli setlookatent(heli.target_ent);
        heli scripts\cp\helicopter\cp_helicopter::hover_and_shoot_rockets(heli.target_ent, "tag_gun_l", "tag_gun_r", (0, -90, 0), (0, 90, 0));
      }
    }

    wait 0.1;
  }
}

_id_050FBAAA04630B77(vehicle) {
  _id_CC9972999D64CE4B = _id_88E279BB33C8EFE2(vehicle, vehicle._id_8C7951652AC9E489);
  _id_E0A635BF64F59E37 = _id_88E279BB33C8EFE2(vehicle, vehicle._id_8D2274D3195EE96B);
  _id_3229BB72BFB810AD = _id_88E279BB33C8EFE2(vehicle, vehicle._id_DDBFDA638CEC2AF9);
  _id_BB176F868156A226 = _id_88E279BB33C8EFE2(vehicle, vehicle._id_7D880633D0E7301A);
  _id_B47B18AA19C52684 = [_id_CC9972999D64CE4B, _id_E0A635BF64F59E37, _id_3229BB72BFB810AD, _id_BB176F868156A226];
  debug_draw = getdvarint("dvar_C6DE790720B61CF6", 0) > 0;

  if(debug_draw) {
    thread scripts\cp\utility::drawsphere(vehicle.origin + vehicle._id_8C7951652AC9E489, 50, 0.1, (1, 0, 0));
    thread scripts\cp\utility::drawsphere(vehicle.origin + vehicle._id_8D2274D3195EE96B, 50, 0.1, (1, 0, 0));
    thread scripts\cp\utility::drawsphere(vehicle.origin + vehicle._id_DDBFDA638CEC2AF9, 50, 0.1, (1, 0, 0));
    thread scripts\cp\utility::drawsphere(vehicle.origin + vehicle._id_7D880633D0E7301A, 50, 0.1, (1, 0, 0));
    thread scripts\cp\utility::drawsphere(_id_CC9972999D64CE4B, 50, 0.1, (0, 1, 0));
    thread scripts\cp\utility::drawsphere(_id_E0A635BF64F59E37, 50, 0.1, (0, 1, 0));
    thread scripts\cp\utility::drawsphere(_id_3229BB72BFB810AD, 50, 0.1, (0, 1, 0));
    thread scripts\cp\utility::drawsphere(_id_BB176F868156A226, 50, 0.1, (0, 1, 0));

    foreach(_id_0F117359045A417F in _id_B47B18AA19C52684) {
      trace = scripts\engine\trace::ray_trace(vehicle.origin, _id_0F117359045A417F, [self, vehicle]);
      thread scripts\engine\trace::draw_trace(trace, undefined, 1, 10);
    }
  }

  foreach(_id_0F117359045A417F in _id_B47B18AA19C52684) {
    if(scripts\engine\trace::ray_trace_passed(vehicle.origin, _id_0F117359045A417F, [self, vehicle])) {
      dir = (_id_0F117359045A417F[0], _id_0F117359045A417F[1], _id_0F117359045A417F[2] - scripts\cp\helicopter\cp_helicopter::_id_68C2534A5EA3CD2B(undefined));
      dir = dir - vehicle.origin;
      return vehicle.origin + dir;
    }
  }

  return _id_CC9972999D64CE4B;
}

_id_88E279BB33C8EFE2(vehicle, _id_136631D2261FDCC9) {
  _id_219DC5088946667F = vehicle.origin + _id_136631D2261FDCC9;
  _id_219DC5088946667F = (_id_219DC5088946667F[0], _id_219DC5088946667F[1], _id_219DC5088946667F[2] + scripts\cp\helicopter\cp_helicopter::_id_68C2534A5EA3CD2B(undefined));
  return _id_219DC5088946667F;
}

_id_F3BA59477F6DA148(heli) {
  level endon("game_ended");
  heli endon("death");
  heli endon("flyaway");
  heli endon("driverdeath");
  _id_8D5D032EC9BC0F78 = spawnStruct();
  _id_356534A9032DB60D = spawnStruct();
  heli setmaxpitchroll(10, 20);
  heli setneargoalnotifydist(150);
  heli sethoverparams(50, 5, 5);
  heli setyawspeed(50, 45, 45);
  waitframe();

  if(!istrue(heli._id_DE3E96CD2601F574))
    heli thread _id_12557B95E5704F0D();

  _id_A90BB3F133280245 = 0;
  heliheight = (0, 0, 550);

  if(istrue(heli._id_DE3E96CD2601F574))
    heliheight = (0, 0, 275);

  while(isDefined(heli)) {
    vehicle = _id_AEAB160D1452A77E();

    if(!isDefined(vehicle)) {
      wait 0.1;
      thread _id_003D73BBFB0A2B2A(heli, 1000);
      target = heli scripts\cp\helicopter\cp_helicopter::heli_get_target(heli.origin + (0, 0, -100));

      if(!isDefined(target)) {
        continue;
      }
      if(distance2dsquared(target.origin, heli.origin) < squared(1100))
        continue;
      else {
        if(istrue(heli._id_7C8EBCD9C1AFA8D2))
          _id_6A0C0918A7BEE72D(heli);

        continue;
      }
    } else if(vehicle vehicle_getspeed() < 5) {
      _id_A90BB3F133280245++;

      if(_id_A90BB3F133280245 > 15) {
        _id_003D73BBFB0A2B2A(heli);
        wait 0.1;
        continue;
      }

      wait 0.1;
      continue;
    }

    if(istrue(heli._id_7C8EBCD9C1AFA8D2))
      _id_6A0C0918A7BEE72D(heli);

    if(!istrue(heli._id_DE3E96CD2601F574))
      heli._id_14F57F43F6A3A6A1 = 1;

    if(!isDefined(vehicle._id_F052A2BF872947B0)) {
      vehicle._id_F052A2BF872947B0 = 1;
      vehicle thread _id_2D3A0D35632F1495();
    }

    if(!isDefined(vehicle._id_DDBFDA638CEC2AF9) || !isDefined(vehicle._id_7D880633D0E7301A)) {
      waitframe();
      continue;
    }

    _id_356534A9032DB60D.origin = vehicle.origin + vehicle._id_DDBFDA638CEC2AF9;
    _id_8D5D032EC9BC0F78.origin = vehicle.origin + vehicle._id_7D880633D0E7301A;
    _id_E4B7E99A96C8829F = [_id_356534A9032DB60D, _id_8D5D032EC9BC0F78];

    if(isDefined(heli._id_3FA54C79A0AE806D)) {
      if(heli._id_3FA54C79A0AE806D == "left")
        _id_FECE2C56170697AD = _id_356534A9032DB60D.origin + heliheight;
      else
        _id_FECE2C56170697AD = _id_8D5D032EC9BC0F78.origin + heliheight;
    } else {
      riders = heli _id_6A2F8CB0900186C3();

      if(riders._id_D1968CB5559F63BC.size == riders._id_F75B7A2AF0ADD669.size)
        _id_FECE2C56170697AD = scripts\engine\utility::getclosest(heli.origin, _id_E4B7E99A96C8829F).origin + heliheight;
      else if(riders._id_D1968CB5559F63BC.size > riders._id_F75B7A2AF0ADD669.size)
        _id_FECE2C56170697AD = _id_8D5D032EC9BC0F78.origin + heliheight;
      else
        _id_FECE2C56170697AD = _id_356534A9032DB60D.origin + heliheight;
    }

    _id_A90BB3F133280245 = 0;
    _id_6A0C0918A7BEE72D(heli);

    if(istrue(heli._id_14F57F43F6A3A6A1))
      _id_529EEC3DFB612F5D(vehicle, heli);

    _id_8C1D7E7AE38471BD = distance2dsquared(heli.origin, _id_FECE2C56170697AD);
    heli vehicle_setspeed(75, 40, 40);

    if(!isDefined(vehicle)) {
      wait 0.1;
      continue;
    }

    heli thread _id_B06360BE83F3EE98(_id_FECE2C56170697AD, 1, vehicle);
    wait 0.1;

    if(heli _id_E940E1068711ABB0())
      return;
  }
}

_id_529EEC3DFB612F5D(vehicle, heli) {
  heli endon("stop_throwing");
  heli endon("death");
  heli endon("flyaway");

  if(!istrue(heli._id_14F57F43F6A3A6A1)) {
    return;
  }
  _id_265706100D1E0891 = spawnStruct();
  heli setyawspeed(50, 25, 25);

  while(istrue(heli._id_14F57F43F6A3A6A1)) {
    vehicle = _id_AEAB160D1452A77E();

    if(!isDefined(vehicle) || vehicle vehicle_getspeed() < 10) {
      return;
    }
    _id_265706100D1E0891.origin = vehicle.origin + vehicle._id_F7222EFAC2245CA3 + (0, 0, 550);
    _id_FECE2C56170697AD = _id_265706100D1E0891.origin;

    if(_id_FECE2C56170697AD[2] < vehicle.origin[2])
      _id_FECE2C56170697AD = (_id_FECE2C56170697AD[0], _id_FECE2C56170697AD[1], vehicle.origin[2]) + (0, 0, 550);

    distsq = distance2dsquared(heli.origin, _id_FECE2C56170697AD);

    if(distsq > squared(1200)) {
      if(!scripts\engine\utility::flag("pause_c4_throwing"))
        scripts\engine\utility::flag_set("pause_c4_throwing");
    } else if(scripts\engine\utility::flag("pause_c4_throwing"))
      scripts\engine\utility::flag_clear("pause_c4_throwing");

    if(distsq > squared(2500)) {
      heli vehicle_setspeed(75, 25, 25);
      heli thread _id_B06360BE83F3EE98(_id_FECE2C56170697AD, 1, vehicle);
    } else {
      if(!istrue(heli._id_2FAB64D73F45C5B8)) {
        thread _id_60FCF5A70A2AC8FB(heli, vehicle);
        heli._id_2FAB64D73F45C5B8 = 1;
      }

      speed = vehicle vehicle_getspeed();
      heli vehicle_setspeed(speed + 25, 25, 25);
      heli thread _id_B06360BE83F3EE98(_id_FECE2C56170697AD, 1, vehicle);
    }

    heli.goalpos = _id_FECE2C56170697AD;

    if(heli _id_E940E1068711ABB0()) {
      return;
    }
    wait 0.1;
  }
}

_id_12557B95E5704F0D() {
  self endon("death");
  self endon("flyaway");

  for(;;) {
    self._id_14F57F43F6A3A6A1 = 1;
    self waittill("stop_throwing");
    self._id_14F57F43F6A3A6A1 = 0;
    wait(randomintrange(3, 5));
  }
}

_id_AEAB160D1452A77E(player) {
  vehicles = [];

  foreach(player in level.players) {
    if(!player scripts\cp_mp\utility\player_utility::isinvehicle()) {
      continue;
    }
    vehicles[vehicles.size] = player.vehicle;
  }

  if(vehicles.size) {
    vehicle = scripts\engine\utility::random(vehicles);

    if(!isDefined(vehicle._id_F052A2BF872947B0)) {
      vehicle thread _id_2D3A0D35632F1495();
      vehicle._id_F052A2BF872947B0 = 1;
    }

    return vehicle;
  } else
    return undefined;
}

_id_2D3A0D35632F1495() {
  self notify("calc_enemy_heli_pos");
  self endon("calc_enemy_heli_pos");
  self endon("death");
  level endon("game_ended");
  _id_CE0F3D78F5601982 = 4000;

  for(;;) {
    fwd = anglesToForward((0, self.angles[1], 0));
    _id_CBAC2203146AE84A = anglestoright((0, self.angles[1], 0));
    self._id_8C7951652AC9E489 = fwd * _id_CE0F3D78F5601982;
    self._id_8D2274D3195EE96B = (-1, -1, -1) * (fwd * _id_CE0F3D78F5601982);
    self._id_7406A4B155EC4D92 = _id_CBAC2203146AE84A * 200 + fwd * _id_CE0F3D78F5601982;
    self._id_C7364CBCD79B0831 = _id_CBAC2203146AE84A * -200 + fwd * _id_CE0F3D78F5601982;
    self._id_7D880633D0E7301A = _id_CBAC2203146AE84A * 550 + fwd * 750;
    self._id_DDBFDA638CEC2AF9 = _id_CBAC2203146AE84A * -550 + fwd * 750;
    self._id_F7222EFAC2245CA3 = fwd * 2500;
    wait 0.05;
  }
}

_id_6EFE8AD8F8527B46(_id_8FDFAD46F0546243) {
  _id_8FDFAD46F0546243 endon("death");
  _id_8FDFAD46F0546243 endon("stop_think");
  _id_8FDFAD46F0546243 endon("crashing");
  _id_8FDFAD46F0546243.minigun setmode("manual");
  _id_8FDFAD46F0546243.nextfiretime = gettime() + 2000;
  _id_ECBF90442E065A5F = 0;
  timeout = 5;
  _id_8FDFAD46F0546243 vehicle_setspeed(50, 30);
  _id_EC80496532425417 = _id_8FDFAD46F0546243 scripts\cp\helicopter\cp_helicopter::heli_get_target(undefined, 0);

  for(;;) {
    while(!isDefined(_id_EC80496532425417) && _id_ECBF90442E065A5F < timeout) {
      wait 1;
      _id_EC80496532425417 = _id_8FDFAD46F0546243.best_target;

      if(!isDefined(_id_EC80496532425417))
        _id_EC80496532425417 = _id_8FDFAD46F0546243 scripts\cp\helicopter\cp_helicopter::heli_get_target(undefined, 0);

      _id_ECBF90442E065A5F++;
    }

    _id_ECBF90442E065A5F = 0;

    for(;;) {
      _id_EC80496532425417 = _id_8FDFAD46F0546243 scripts\cp\helicopter\cp_helicopter::heli_get_target(undefined, 0);

      if(!isDefined(_id_EC80496532425417)) {
        if(!istrue(_id_8FDFAD46F0546243._id_7C8EBCD9C1AFA8D2))
          _id_8FDFAD46F0546243 thread _id_DEB910371E928A67();

        wait 3;
        continue;
      }

      if(istrue(_id_8FDFAD46F0546243._id_7C8EBCD9C1AFA8D2)) {
        _id_8FDFAD46F0546243._id_7C8EBCD9C1AFA8D2 = 0;
        _id_8FDFAD46F0546243 notify("stop_circling");
      }

      if(_id_8FDFAD46F0546243 scripts\cp\helicopter\cp_helicopter::should_move_to_target(_id_8FDFAD46F0546243.minigun, _id_EC80496532425417)) {
        _id_8FDFAD46F0546243 thread _id_B537E925545EE973(_id_EC80496532425417);
        _id_8FDFAD46F0546243 scripts\engine\utility::waittill_any_timeout_4(1, "goal", "goal_reached", "near_goal", "needs_to_evade");
        continue;
      }

      break;
    }

    while(istrue(_id_8FDFAD46F0546243._id_666174DB4AC38377))
      wait 0.05;

    _id_8FDFAD46F0546243 _id_AAD441C4AC4402BB(_id_EC80496532425417);

    if(istrue(_id_8FDFAD46F0546243.nocircle))
      _id_8FDFAD46F0546243 thread scripts\cp\helicopter\cp_helicopter::engage_target_from_pos(_id_EC80496532425417);
    else {
      chopper_height = _id_8FDFAD46F0546243 scripts\cp\helicopter\cp_helicopter::_id_68C2534A5EA3CD2B(_id_EC80496532425417);
      _id_8FDFAD46F0546243 thread scripts\cp\helicopter\cp_helicopter::engage_target_circle_strafe(_id_EC80496532425417, chopper_height);
    }

    _id_8FDFAD46F0546243 scripts\engine\utility::waittill_any_timeout_2(60, "target_engaged", "needs_to_evade");
    _id_8FDFAD46F0546243.nocircle = 0;
  }
}

_id_AAD441C4AC4402BB(_id_EC80496532425417) {
  self endon("needs_to_evade");
  self endon("death");
  self endon("crashing");
  _id_EC80496532425417 endon("last_stand");
  _id_EC80496532425417 endon("disconnect");
  self.hovering = 1;
  self sethoverparams(25, 15, 10);
  self vehicle_setspeed(10, 10, 10);
  thread scripts\cp\helicopter\cp_helicopter::shoot_at_target(_id_EC80496532425417);
  _id_0884B64AC436A0E3 = getdvarint("dvar_85D826E87FD8EA7E", 6);
  wait(_id_0884B64AC436A0E3);
  self.hovering = 0;
}

_id_A804E95AA955EF7B() {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");

  for(;;) {
    self._id_E73F138658D7C538 = 0;
    speed = self vehicle_getspeed();
    wait 2;
    fwd = anglesToForward((0, self.angles[1], 0));
    trace = scripts\engine\trace::ray_trace(self.origin, self.origin + fwd * 500, self, undefined, undefined, 1, 1);
    str = "";

    if(trace["fraction"] < 1) {
      type = trace["hittype"];
      str = str + "[ forward ] " + type + ",";
    }

    trace = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 550), self, undefined, undefined, 1, 1);

    if(trace["fraction"] < 0.9) {
      type = trace["hittype"];
      str = str + "[ below ] " + type + ",";
    }

    wait 2;
  }
}

_id_B537E925545EE973(target) {
  self endon("death");
  self endon("crashing");
  self notify("movetotarget");
  self endon("movetotarget");
  self cleartargetyaw();
  self cleargoalyaw();
  self setlookatent(target);
  chopper_height = scripts\cp\helicopter\cp_helicopter::_id_68C2534A5EA3CD2B();
  _id_119D71E3F7006F18 = (self.gotopos[0], self.gotopos[1], chopper_height);

  if(distance2dsquared(self.origin, _id_119D71E3F7006F18) > 640000) {
    self setneargoalnotifydist(300);
    self vehicle_setspeed(120, 30, 30);
    _id_B06360BE83F3EE98(_id_119D71E3F7006F18, 1);
  } else {
    self vehicle_setspeed(15, 12, 12);
    _id_B06360BE83F3EE98(_id_119D71E3F7006F18, 1);
  }

  scripts\engine\utility::waittill_any_timeout_3(1, "goal", "goal_reached", "near_goal");
}

_id_A742F2D93265DBE7(spawnpos) {
  _id_6F95079FFDBCDD1A = getdvarint("dvar_BDB51F40F2309C7B", 1) > 0;
  _id_60F7CB484EC61F6C = undefined;

  if(_id_6F95079FFDBCDD1A) {
    _id_07132F053DB6712D = scripts\engine\utility::getStructArray("script_apache_spawn_point", "targetname");
    _id_60F7CB484EC61F6C = scripts\engine\utility::random(_id_07132F053DB6712D);
  } else {
    _id_60F7CB484EC61F6C = spawnStruct();
    _id_60F7CB484EC61F6C.origin = (-46656, -18240, 2880);
    _id_60F7CB484EC61F6C.angles = (0, 0, 0);
  }

  spawn_point = spawnStruct();
  spawn_point.origin = _id_60F7CB484EC61F6C.origin;
  spawn_point.angles = _id_60F7CB484EC61F6C.angles;
  spawn_point.classname_mp = "script_vehicle_apache_east";
  spawn_point.script_modelname = "veh9_mil_air_ahotel64_ks_mp";
  spawn_point.vehicletype = "veh_apache_cp";
  spawn_point.vehiclename = "veh_apache_cp";
  heli = scripts\common\vehicle::vehicle_spawn(spawn_point);

  if(!isDefined(heli))
    return undefined;

  heli.vehiclename = "veh_apache_cp";
  heli.isheli = 1;
  heli._id_0BB41F994EE0FD70 = 1;
  heli.health = 30000;
  heli.maxhealth = 30000;
  heli.team = "axis";
  heli setvehicleteam(heli.team);
  heli setmaxpitchroll(25, 25);
  heli.health_remaining = 2500;
  heli thread scripts\cp\helicopter\cp_helicopter::rumble_nearby_players();
  heli setscriptablepartstate("blinking_lights", "on");
  heli solid();
  return heli;
}

_id_60FCF5A70A2AC8FB(heli, vehicle) {
  heli endon("death");
  heli endon("stop_throwing");
  heli endon("flyaway");
  vehicle endon("death");
  _id_C3FBB6661B91750F = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 0, 0, 1);
  _id_2FC7B90001702E5C = scripts\engine\utility::array_combine(vehicle.riders, [vehicle]);
  _id_A5E8134E45969956 = 0;
  wait 1;

  while(istrue(heli._id_2FAB64D73F45C5B8) && isDefined(vehicle)) {
    scripts\engine\utility::flag_waitopen("pause_c4_throwing");

    if(!isDefined(heli.riders) || !isDefined(heli.riders[2])) {
      heli notify("flyaway");
      return;
    }

    start = heli.riders[2].origin + (0, 0, 40) + anglesToForward(heli.riders[2].angles) * 10;
    _id_C323AF0DDB204E4F = scripts\engine\math::get_mid_point(vehicle.origin, start);
    _id_C323AF0DDB204E4F = scripts\engine\math::get_mid_point(_id_C323AF0DDB204E4F, start);
    angles = vectortoangles(vehicle.origin - _id_C323AF0DDB204E4F);
    end = _id_C323AF0DDB204E4F + anglesToForward(angles) * 500;
    _id_7FE710B31B2B752D = end + (0, 0, 500);
    end = _id_7FE710B31B2B752D - (0, 0, 1000);
    trace = scripts\engine\trace::ray_trace_detail(_id_7FE710B31B2B752D, end, _id_2FC7B90001702E5C, _id_C3FBB6661B91750F, 1);
    end = trace["position"];
    thread _id_646D79878C201354(start, end, vehicle);
    _id_A5E8134E45969956++;

    if(_id_A5E8134E45969956 >= 35 && !istrue(heli._id_B33E044C86152195)) {
      heli._id_2FAB64D73F45C5B8 = undefined;
      heli notify("stop_throwing");
      return;
    }

    _id_A966A3DD1C4A812F = randomintrange(6, 9);

    if(_id_A5E8134E45969956 >= _id_A966A3DD1C4A812F) {
      _id_A5E8134E45969956 = 0;
      wait(randomfloatrange(2, 4));
    }

    wait(randomfloatrange(0.35, 1));
  }
}

_id_646D79878C201354(start, end, vehicle) {
  level notify("dropping_bombs");
  _id_B61BE01993461EB8 = spawn("script_model", start);
  _id_B61BE01993461EB8 setModel("offhand_wm_c4_bomb_heli");
  _id_7FC17D435D2F9AC6 = vectortoangles(end - vehicle.origin);
  _id_B61BE01993461EB8.angles = (0, _id_7FC17D435D2F9AC6[1], 0) + (-90, 180, 0);
  _id_A50EED8877A7EA1E = vectortoangles(end - start);
  _id_B61BE01993461EB8 physicslaunchserver(start, _id_A50EED8877A7EA1E);
  _id_B61BE01993461EB8 thread _id_BDC4229A3F1FDA1B();
  _id_B61BE01993461EB8 scripts\engine\utility::waittill_any_timeout_1(8, "detonate");
  _id_B61BE01993461EB8 setscriptablepartstate("effects", "explode");
  wait 1;
  _id_B61BE01993461EB8 delete();
}

_id_BDC4229A3F1FDA1B(vehicle) {
  self endon("entitydeleted");

  for(;;) {
    _id_99786F84F0705A7F = 0;

    foreach(player in level.players) {
      if(!player scripts\cp_mp\utility\player_utility::isinvehicle()) {
        if(distance2d(self.origin, player.origin) < 200)
          _id_99786F84F0705A7F = 1;

        continue;
      }

      if(distance2d(self.origin, player.vehicle.origin) < 275)
        _id_99786F84F0705A7F = 1;
    }

    if(_id_99786F84F0705A7F) {
      break;
    }

    waitframe();
  }

  level notify("c4_damaged");
  self notify("detonate");
}

_id_E7EA66BA00A0FA5B(_id_D5685B7BAEE6505E, _id_3C891A0EE2552CDD) {
  _id_DAFD1CFDC4DA09B6 = int(150);
  ent = _id_AEAB160D1452A77E();

  if(!isDefined(ent)) {
    ent = scripts\cp\utility::get_closest_living_player();

    if(!isDefined(ent))
      return undefined;
  }

  ent endon("death");
  _id_A5BB1FA786D5B61E = distance(self.origin, ent.origin);
  _id_45353FC34D0B4031 = mph_travel_time(_id_DAFD1CFDC4DA09B6, _id_A5BB1FA786D5B61E);
  maxspeed = 0;

  if(!isPlayer(ent)) {
    _id_216AA8D841F7C224 = 0;
    _id_243CC3B50304E6CE = (0, 0, 0);
    maxspeed = 0;
    _id_1FF426B6DE9CA538 = 2;
    _id_2EF08D4CDF09CE9D = 150;
    point1 = undefined;
    _id_BF69DB3C5A539FAD = undefined;
    _id_F595234B61D94E5C = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1FF426B6DE9CA538; _id_AC0E594AC96AA3A8++) {
      if(_id_AC0E594AC96AA3A8 == 0)
        point1 = ent.origin;

      if(_id_AC0E594AC96AA3A8 == _id_1FF426B6DE9CA538 - 1)
        _id_BF69DB3C5A539FAD = ent.origin;

      _id_216AA8D841F7C224 = ent vehicle_getspeed();
      _id_F595234B61D94E5C = _id_F595234B61D94E5C + _id_216AA8D841F7C224;
      maxspeed = max(maxspeed, _id_216AA8D841F7C224);
      waitframe();
    }

    if(istrue(_id_3C891A0EE2552CDD))
      maxspeed = maxspeed * 1.25;

    _id_FF8A73939086EBAA = _id_F595234B61D94E5C / _id_1FF426B6DE9CA538;
    _id_A474C9C03DF90F98 = scripts\engine\utility::mph_to_ips(_id_FF8A73939086EBAA);
    angles = vectortoangles(_id_BF69DB3C5A539FAD - point1);
  } else {
    _id_2EF08D4CDF09CE9D = 0;
    _id_A474C9C03DF90F98 = length(ent getvelocity());
    angles = ent.angles;
  }

  start = self.origin;
  _id_48BD8D850D8A3BE6 = _id_A474C9C03DF90F98 * _id_45353FC34D0B4031;
  _id_48BD8D850D8A3BE6 = _id_48BD8D850D8A3BE6 + _id_2EF08D4CDF09CE9D;
  _id_48BD8D850D8A3BE6 = int(_id_48BD8D850D8A3BE6);
  _id_7BBC01D44D8BFDF1 = ent.origin + anglesToForward(angles) * _id_48BD8D850D8A3BE6;
  _id_DBDB6416D2651728 = getgroundposition(_id_7BBC01D44D8BFDF1, 16, 5000, 5000);
  return _id_DBDB6416D2651728;
}

mph_travel_time(speed, dist) {
  speed = speed * 17.6;
  time = dist / speed;
  return time;
}

_id_1421B6AF12212243() {
  level waittill("spawn_apache");
  _id_B85D8D5A0284FFB7 = _id_9C5F65BACCB9CCEC();
}

_id_E05C59AAD0D3EA4A(damage_data) {
  if(isDefined(damage_data.meansofdeath)) {
    if(scripts\engine\utility::isbulletdamage(damage_data.meansofdeath))
      return 5;
  }

  return damage_data.damage;
}

_id_6A0C0918A7BEE72D(heli) {
  heli._id_7C8EBCD9C1AFA8D2 = 0;
  heli notify("stop_circling");

  if(!istrue(heli._id_DE3E96CD2601F574)) {
    heli._id_14F57F43F6A3A6A1 = 1;

    foreach(rider in heli.riders)
    rider.ignoreall = 1;
  }
}

_id_003D73BBFB0A2B2A(heli, circleradius) {
  if(!istrue(heli._id_7C8EBCD9C1AFA8D2)) {
    heli notify("stop_throwing");
    heli._id_2FAB64D73F45C5B8 = 0;
    heli._id_14F57F43F6A3A6A1 = 0;
    heli thread _id_DEB910371E928A67(circleradius);

    if(isDefined(heli.riders)) {
      if(heli _id_E940E1068711ABB0()) {
        return;
      }
      foreach(rider in heli.riders) {
        rider.ignoreall = 0;
        rider.disablereload = 1;
        rider.combatmode = "no_cover";
        rider.goalradius = 9000;
        rider.baseaccuracy = 2;
        rider.maxsightdistsqrd = squared(9000);
        rider _meth_9215CE6FC83759B9(9000);
      }
    }
  }
}

_id_DEB910371E928A67(circleradius) {
  self endon("flyaway");
  self endon("death");
  self endon("stop_circling");
  self endon("stop_chasing");
  self endon("crashing");
  self notify("circle");
  self._id_7C8EBCD9C1AFA8D2 = 1;
  self clearlookatent();
  circle_radius = 2000;

  if(isDefined(self.circle_radius))
    circle_radius = self.circle_radius;

  if(isDefined(circleradius))
    circle_radius = circleradius;

  for(;;) {
    _id_5A0344E827DC5270 = (0, 0, 0);
    target_ent = scripts\cp\helicopter\cp_helicopter::heli_get_target(undefined, 0);

    if(!isDefined(target_ent)) {
      target_ent = self;
      _id_5A0344E827DC5270 = (0, 0, -100);
    }

    chopper_height = getgroundposition(target_ent.origin + _id_5A0344E827DC5270, 4) + (0, 0, 550);
    target = (target_ent.origin[0], target_ent.origin[1], chopper_height[2]);
    points = scripts\cp\helicopter\cp_helicopter::create_radius_around_point(target, 8, circle_radius);

    if(!_id_E5036E4A6FBE91F0())
      points = scripts\engine\utility::array_reverse(points);

    _id_2F05FDC372F83530 = 0;
    start_point = points[0];
    _id_7206821DC4564B24 = distance2dsquared(self.origin, points[0].origin);

    foreach(index, point in points) {
      if(scripts\engine\math::within_fov_2d(self.origin, self.angles, point.origin, cos(35))) {
        start_point = point;
        _id_2F05FDC372F83530 = index;
      }
    }

    self setvehgoalpos(points[_id_2F05FDC372F83530].origin, 1);
    self.goalpos = points[_id_2F05FDC372F83530].origin;
    self setneargoalnotifydist(150);
    self vehicle_setspeed(35, 20, 20);
    scripts\engine\utility::waittill_any_timeout_2(30, "near_goal", "adjusted");

    if(_id_E940E1068711ABB0()) {
      return;
    }
    _id_0DB715BCDE296BEC = 0;
    index = _id_2F05FDC372F83530 + 1;

    for(;;) {
      if(index >= points.size)
        index = 0;

      if(!isalive(target_ent)) {
        break;
      }

      self setvehgoalpos(points[index].origin);
      self.goalpos = points[_id_2F05FDC372F83530].origin;
      scripts\engine\utility::waittill_any_timeout_2(30, "near_goal", "adjusted");

      if(_id_E940E1068711ABB0()) {
        return;
      }
      _id_0DB715BCDE296BEC++;
      index++;
    }
  }
}

_id_E5036E4A6FBE91F0() {
  if(!istrue(self._id_D2AB00DC84B5E14A))
    return 1;

  if(!isDefined(self.riders))
    return 1;

  _id_B813657B8DF8D654 = _id_6A2F8CB0900186C3();
  return _id_B813657B8DF8D654._id_D1968CB5559F63BC.size >= _id_B813657B8DF8D654._id_F75B7A2AF0ADD669.size;
}

_id_6A2F8CB0900186C3() {
  _id_F75B7A2AF0ADD669 = [];
  _id_D1968CB5559F63BC = [];

  foreach(rider in self.riders) {
    if(isDefined(rider.vehicle_position)) {
      switch (rider.vehicle_position) {
        case 4:
        case 3:
        case 2:
          _id_D1968CB5559F63BC[_id_D1968CB5559F63BC.size] = rider;
          break;
        case 7:
        case 6:
        case 5:
          _id_F75B7A2AF0ADD669[_id_F75B7A2AF0ADD669.size] = rider;
          break;
      }
    }
  }

  riders = spawnStruct();
  riders._id_D1968CB5559F63BC = _id_D1968CB5559F63BC;
  riders._id_F75B7A2AF0ADD669 = _id_F75B7A2AF0ADD669;
  return riders;
}

_id_ACDEBFCCE1906051(spawner) {
  heli = _id_DE1818C76C17FB34(spawner, 1);

  if(!isDefined(heli)) {
    return;
  }
  heli._id_D2AB00DC84B5E14A = 1;
  level notify("heli_inbound");
  heli._id_DE3E96CD2601F574 = 1;
  heli.flaresreservecount = getdvarint("dvar_9F216FBCA05ADD65", 1);
  heli.flareslive = [];

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "handleIncomingStinger"))
    heli thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "handleIncomingStinger")]]();

  return heli;
}

_id_A48BAD21C6C1E0A9(struct) {
  _id_AC7930C851FE41C2 = scripts\engine\utility::getStruct("heli_postintro_heli", "targetname");

  if(isDefined(struct))
    _id_AC7930C851FE41C2 = struct;

  heli = _id_ACDEBFCCE1906051(_id_AC7930C851FE41C2);

  if(isDefined(heli)) {
    level._id_826A2E131D92A45A = heli;

    foreach(index, rider in heli.riders) {
      if(rider.vehicle_position == 0 || rider.vehicle_position == 1)
        continue;
    }
  }

  return heli;
}

_id_6C8E45C9F0D2ED69() {
  while(istrue(level._id_364D5EFBFB7D1FAC) || istrue(level._id_BDB99233B8F43C69))
    wait 0.1;
}

_id_8AB55654A453F80C() {
  heli = _id_DE1818C76C17FB34(scripts\engine\utility::getStruct("lbravo_plains_1", "targetname"));

  if(!isDefined(heli))
    return undefined;

  level._id_664E187FD885C2D5 = heli;
  level._id_664E187FD885C2D5._id_B33E044C86152195 = 1;
  level._id_664E187FD885C2D5._id_23ED994FF62C5EC9 = (0, 0, 600);
  level._id_664E187FD885C2D5.custom_death_script = scripts\cp\helicopter\cp_helicopter::_id_B7E4041A3C02D74A;
  level notify("heli_inbound");
  level._id_664E187FD885C2D5.flaresreservecount = 1;
  level._id_664E187FD885C2D5.flareslive = [];

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "handleIncomingStinger"))
    level._id_664E187FD885C2D5 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "handleIncomingStinger")]]();
}

_id_0F86BBD1CC392004() {
  self endon("death");
  self notify("flyaway");
  self setvehgoalpos((22114.9, 58654.1, 13590.3), 1);
  self waittill("goal");
  self dodamage(self.health + 100, self.origin, self, self, "MOD_EXPLOSIVE");
}

heli_crash(attacker) {
  self notify("crashing");
  self._id_07436690EA0E728C = 1;

  if(isDefined(self.headicon)) {
    deleteheadicon(self.headicon);
    self.headicon = undefined;
  }

  playsoundatpos(self.origin, "cp_blima_expl_air");
  playsoundatpos(self.origin, "veh_apache_explode_mp");
  ground_pos = getclosestpointonnavmesh(self.origin);
  pos = spawnStruct();
  pos.origin = ground_pos;
  pos.angles = (0, 0, 0);
  _id_CA5ADB87EB6F4461 = 0;
  _id_9B6934A7CDCDB995 = undefined;
  _id_A3354D21ABC52913 = undefined;
  _id_07BE4DAEEADA81DF = getscriptablearray("guard_tower", "script_noteworthy");

  foreach(_id_C6CD9D2C6AD18DD6 in _id_07BE4DAEEADA81DF) {
    if(!isDefined(_id_C6CD9D2C6AD18DD6.trigger)) {
      continue;
    }
    if(ispointinvolume(pos.origin, _id_C6CD9D2C6AD18DD6.trigger)) {
      _id_CA5ADB87EB6F4461 = 1;
      _id_9B6934A7CDCDB995 = pos + (0, 0, 100);
      _id_6C53D859D582A421 = getclosestpointonnavmesh(pos.origin + (0, 0, -200));
      pos.origin = _id_6C53D859D582A421;
      _id_A3354D21ABC52913 = _id_C6CD9D2C6AD18DD6;
    }
  }

  if(isDefined(_id_9B6934A7CDCDB995))
    thread _id_BB0DE127EC3F769E(_id_A3354D21ABC52913, _id_9B6934A7CDCDB995);

  self setvehgoalpos(pos.origin);
  speed = getdvarint("dvar_3BB964B2683FFA4F", 45);
  accel = getdvarint("dvar_440A4C558381B194", 20);
  decel = getdvarint("dvar_42B9FE6249D1673D", 20);
  self vehicle_setspeed(speed, accel, decel);
  thread _id_45913538E85CCB8E(pos.origin);
  _id_C37A0420F6893104(pos.origin);
  self stoploopsound();
  self notify("death", attacker, "MOD_EXPLOSIVE", undefined, self.origin);
  radiusdamage(self.origin, 750, 1000, 150, self, "MOD_EXPLOSIVE");

  if(istrue(level._id_AFB0B04E32B229FE)) {
    playsoundatpos(self.origin, "cp_blima_expl_corpse");
    playFX(level._effect["vfx_blima_explosion_ground"], self.origin);
    self delete();
    return;
  }

  if(istrue(self._id_A446C274174C1268) || getdvarint("dvar_BA8282E1A78AC163", 1) > 0) {
    trace = scripts\engine\trace::ray_trace(self.origin + (0, 0, 100), ground_pos + (0, 0, -10), [self]);
    corpse = spawn("script_model", trace["position"] + (0, 0, -10));
    corpse.angles = (trace["normal"][0], self.angles[1], trace["normal"][2]);
    corpse setModel("veh9_mil_air_ahotel64_dst_cp");
    corpse._id_B917E6F71A39183F = spawn("script_model", corpse.origin + anglesToForward(corpse.angles) * -285 + anglestoright(corpse.angles) * 50);
    corpse._id_B917E6F71A39183F setModel("veh9_mil_air_ahotel64_tail_dst_cp");
    trace = scripts\engine\trace::ray_trace(corpse._id_B917E6F71A39183F.origin + (0, 0, 100), corpse._id_B917E6F71A39183F.origin + (0, 0, -100), [corpse, corpse._id_B917E6F71A39183F, self]);
    corpse._id_B917E6F71A39183F.angles = (trace["normal"][0], corpse.angles[1], trace["normal"][2]);
    corpse._id_B917E6F71A39183F.origin = trace["position"] + (0, 0, -5);
    waitframe();
    self delete();
    level._id_AFB0B04E32B229FE = 1;
  }
}

_id_BB0DE127EC3F769E(_id_C6CD9D2C6AD18DD6, _id_9B6934A7CDCDB995) {
  self endon("death");

  while(distance(self.origin, _id_9B6934A7CDCDB995) > 100)
    waitframe();

  _id_C6CD9D2C6AD18DD6 dodamage(1000, _id_C6CD9D2C6AD18DD6.origin + (0, 0, 100), self, self, "MOD_CRUSH");
}

_id_E0359466C85F064B() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", ent);

    if(isPlayer(ent))
      thread _id_679DFE79DBAD3665(ent);
  }
}

_id_679DFE79DBAD3665(player) {
  player endon("disconnect");

  if(!istrue(player.onfire)) {
    player.onfire = 1;
    player dodamage(45, player.origin, undefined, undefined, "MOD_TRIGGER_HURT");
    wait 0.5;
    player.onfire = 0;
  }
}

_id_F5711AD28016CCBA() {
  self setscriptablepartstate("stage3", "on");
  self._id_B917E6F71A39183F setscriptablepartstate("stage3", "on");
  wait 60;
  playFX(level._effect["vfx_blima_explosion_ground"], self.origin);
  playsoundatpos(self.origin, "cp_blima_expl_corpse");
  self._id_B917E6F71A39183F.clip delete();
  self._id_B917E6F71A39183F._id_2E1259FB590696E9 delete();
  self._id_B917E6F71A39183F delete();
  self.clip delete();
  self._id_2E1259FB590696E9 delete();
  self delete();
}

_id_C37A0420F6893104(pos) {
  deathfx = 0;

  while(distance(self.origin, pos) > 100) {
    if(distance(self.origin, pos) < 250 && !deathfx) {
      playFX(level._effect["vfx_blima_explosion_ground"], pos);
      deathfx = 1;
    }

    wait 0.05;
  }
}

_id_45913538E85CCB8E(pos) {
  self endon("death");
  self clearlookatent();
  self setmaxpitchroll(60, 90);
  self setyawspeed(700, 200, 200);

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    _id_3F403475C9BCA3F7 = randomintrange(140, 170);
    self settargetyaw(self.angles[1] + _id_3F403475C9BCA3F7);
    wait 0.5;
  }
}

_id_F922C8D4735F96B2() {
  _id_C59CE7DB61C45862 = 0;
  _id_C3CE48ADC9A65BE3 = self.riders.size;

  foreach(rider in self.riders) {
    if(!isalive(rider) || rider.health < 0) {
      continue;
    }
    _id_C59CE7DB61C45862++;
  }

  return _id_C59CE7DB61C45862;
}

_id_E940E1068711ABB0() {
  if(istrue(self._id_0BB41F994EE0FD70))
    return 0;

  _id_C59CE7DB61C45862 = _id_F922C8D4735F96B2();

  if(_id_C59CE7DB61C45862 < 2) {
    self dodamage(self.health + 100, self.origin, self, self, "MOD_EXPLOSIVE");
    return 0;
  }

  return 0;
}

_id_B06360BE83F3EE98(_id_F33F587E225DE2AF, _id_E1F26216DAE25CB7, vehicle) {
  self endon("death");
  self endon("flyaway");
  self endon("circle");
  self endon("driverdeath");
  self notify("gotopos");
  self endon("gotopos");
  path = _id_556BAFA73F676724(_id_F33F587E225DE2AF, vehicle);

  foreach(index, node in path) {
    if(index == path.size - 1)
      self setvehgoalpos(node, _id_E1F26216DAE25CB7);
    else if(istrue(self._id_0BB41F994EE0FD70))
      self setvehgoalpos(node);
    else
      self setvehgoalpos(node, _id_E1F26216DAE25CB7);

    self waittill("near_goal");
  }
}

_id_556BAFA73F676724(_id_F33F587E225DE2AF, vehicle) {
  path = [];
  dir = vectortoangles(_id_F33F587E225DE2AF - self.origin);
  fwd = anglesToForward(dir);
  dist = length(self.origin - _id_F33F587E225DE2AF);
  _id_29B6333B64DE3FFD = (0, 0, 550);

  if(isDefined(self._id_116AD1E054E41093))
    _id_29B6333B64DE3FFD = self._id_116AD1E054E41093;

  _id_69E5E9C5F97FEE73 = self.origin[2];
  _id_2FC7B90001702E5C = [self, vehicle];

  if(!isDefined(vehicle))
    _id_2FC7B90001702E5C = [self];

  if(dist > 500) {
    _id_63F445469B886BF8 = dist / 500;

    for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < _id_63F445469B886BF8; _id_AC0E594AC96AA3A8++) {
      if(_id_AC0E594AC96AA3A8 > 5) {
        break;
      }

      _id_6CB568FEC1CF255A = _id_AC0E594AC96AA3A8 * 500;
      _id_6C53D859D582A421 = self.origin + fwd * _id_6CB568FEC1CF255A;
      _id_9F496648AFA9DCFB = _id_AC0E594AC96AA3A8 * 750;
      _id_E3E96F8EFCB39AAB = self.origin + fwd * _id_9F496648AFA9DCFB;
      _id_57F9B1A7F5F34A7D = _id_779747C02DCCA7B6(_id_6C53D859D582A421);

      if(isDefined(_id_57F9B1A7F5F34A7D)) {
        path[path.size] = _id_57F9B1A7F5F34A7D.origin;
        continue;
      }

      trace = scripts\engine\trace::ray_trace(_id_6C53D859D582A421 + (0, 0, 3000), _id_6C53D859D582A421 - (0, 0, 5000), _id_2FC7B90001702E5C, undefined, undefined, 1, 1);
      pos = trace["position"] + _id_29B6333B64DE3FFD;
      startpos = self.origin;

      if(path.size)
        startpos = path[path.size - 1];

      _id_2C009776DC6F509B = scripts\engine\trace::ray_trace(startpos, pos, _id_2FC7B90001702E5C, undefined, undefined, 1, 1);

      if(_id_2C009776DC6F509B["fraction"] < 1) {
        trace = scripts\engine\trace::ray_trace(_id_2C009776DC6F509B["position"] + (0, 0, 3000), _id_2C009776DC6F509B["position"] - (0, 0, 5000), _id_2FC7B90001702E5C, undefined, undefined, 1, 1);
        pos = trace["position"] + _id_29B6333B64DE3FFD;
      }

      if(pos[2] > _id_69E5E9C5F97FEE73)
        _id_69E5E9C5F97FEE73 = pos[2];

      path[path.size] = pos;
    }
  }

  foreach(pos in path)
  pos = (pos[0], pos[1], _id_69E5E9C5F97FEE73);

  trace = scripts\engine\trace::ray_trace(_id_F33F587E225DE2AF + (0, 0, 3000), _id_F33F587E225DE2AF - (0, 0, 5000), _id_2FC7B90001702E5C, undefined, undefined, 1, 1);
  pos = trace["position"] + _id_29B6333B64DE3FFD;
  path[path.size] = pos;
  return path;
}

_id_779747C02DCCA7B6(pos) {
  if(!isDefined(level._id_6B278DCE447D6034))
    return undefined;

  _id_114AB88507847C50 = scripts\engine\utility::getclosest(pos, level._id_6B278DCE447D6034);

  if(isDefined(_id_114AB88507847C50) && distancesquared(_id_114AB88507847C50.origin, pos) <= squared(_id_114AB88507847C50.radius))
    return _id_114AB88507847C50;

  return undefined;
}