/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4bac13d511590220.gsc
***********************************************/

_id_7DCAD89B9C0264A6() {
  if(!isDefined(level._id_6E5FF6CAE14C4081))
    level._id_6E5FF6CAE14C4081 = [];

  if(!isDefined(level._id_A8DC22C62BA69B88))
    level._id_A8DC22C62BA69B88 = [];
}

_id_28991B23DBA743D8(_id_BC36C55F86568C40) {
  if(!isDefined(self._id_324836DC0D03F0A4) || self._id_324836DC0D03F0A4 < 5) {
    if(distancesquared(self.origin, _id_BC36C55F86568C40) < squared(750)) {
      if(!isDefined(self._id_ED5B42425E687D18)) {
        self._id_ED5B42425E687D18 = 0;
        self._id_324836DC0D03F0A4 = 0;
      }

      if(gettime() > self._id_ED5B42425E687D18) {
        if(soundexists("veh_horn_mid_random"))
          self playsoundonmovingent("veh_horn_mid_random");

        self._id_324836DC0D03F0A4++;
        self._id_ED5B42425E687D18 = gettime() + randomintrange(200, 1000);
      }
    }
  }
}

_id_C3889ABF5CD6ABBF(_id_305797971B8E8DBA, speed, _id_5B69959DF7B5F457, _id_EEFDC14DD5275FD0) {
  self endon("death");
  self endon("unloaded");
  self notify("newFollowPath");
  self endon("newFollowPath");

  while(!isDefined(level._id_2814A8F25A392EAA))
    waitframe();

  for(;;) {
    _id_E8730CC0C5EAC096(_id_305797971B8E8DBA);
    _id_28991B23DBA743D8(_id_305797971B8E8DBA.path[_id_305797971B8E8DBA.index].origin);
    _id_1F25FD6DAC8F357E = _id_01D917EC593F5D37(_id_305797971B8E8DBA.path[_id_305797971B8E8DBA.index], speed);

    if(_id_1F25FD6DAC8F357E != speed)
      self _meth_77320E794D35465A("p2p", "goalThreshold", _id_1F25FD6DAC8F357E * 4);

    result = _id_8F40A2C8678F8304(self.origin, _id_305797971B8E8DBA.path[_id_305797971B8E8DBA.index].origin, _id_1F25FD6DAC8F357E, undefined, undefined, _id_EEFDC14DD5275FD0);

    if(isDefined(_id_5B69959DF7B5F457) && isDefined(result) && result == "path_blocked")
      [[_id_5B69959DF7B5F457]]();

    waitframe();
  }
}

_id_01D917EC593F5D37(node, speed) {
  if(!isDefined(node._id_0E8A3AE8CFC0A5EC))
    return speed;

  if(node._id_0E8A3AE8CFC0A5EC == "slow")
    return 20;
  else if(node._id_0E8A3AE8CFC0A5EC == "fast")
    return 80;
  else if(node._id_0E8A3AE8CFC0A5EC == "furious")
    return 128;
  else
    return speed;
}

_id_E8730CC0C5EAC096(_id_305797971B8E8DBA) {
  _id_305797971B8E8DBA.index = (_id_305797971B8E8DBA.index + _id_305797971B8E8DBA.direction) % _id_305797971B8E8DBA.path.size;

  if(_id_305797971B8E8DBA.index < 0)
    _id_305797971B8E8DBA.index = _id_305797971B8E8DBA.index + _id_305797971B8E8DBA.path.size;
}

_id_26E9E22860C819CE(start_point, end_point, speed, _id_91B19CFB0A78C588) {
  if(isDefined(_id_91B19CFB0A78C588)) {
    _id_A0EEC69077D8135E = findpathcustom(start_point, getclosestpointonnavmesh(_id_91B19CFB0A78C588, level._id_2814A8F25A392EAA), 0, 1, level._id_2814A8F25A392EAA);
    end_point = _id_24E4405CF93F20ED::_id_C06BD2EA8930EEBF(end_point, _id_A0EEC69077D8135E);
  } else
    _id_A0EEC69077D8135E = findpathcustom(start_point, getclosestpointonnavmesh(end_point, level._id_2814A8F25A392EAA), 0, 1, level._id_2814A8F25A392EAA);

  if(_id_A0EEC69077D8135E.size)
    thread _id_69695F8C7ED9C3F6(_id_A0EEC69077D8135E, speed);
  else
    self _meth_77320E794D35465A("p2p", "goalPoint", self.origin);
}

_id_69695F8C7ED9C3F6(_id_A0EEC69077D8135E, speed) {
  self endon("death");
  self notify("path_updated");
  self endon("path_updated");

  foreach(index, point in _id_A0EEC69077D8135E) {
    while(istrue(self._id_3D2AFA5C9A1B1A32))
      wait 0.05;

    if(isstruct(point))
      point = point.origin;

    self _meth_77320E794D35465A("p2p", "goalPoint", point);
    dist = distancesquared(self.origin, point);
    time = undefined;

    if(dist > 0)
      time = _id_24E4405CF93F20ED::_id_CBC170D40C70CDDF(self.origin, point, speed);

    key = _func_906E53C2FB9D3F9C("p2p", "targetTime");

    if(isDefined(time))
      self _meth_77320E794D35465A(key, time);
    else
      self _meth_77320E794D35465A(key, 0.2);

    while(distancesquared(self.origin, point) > squared(200))
      waitframe();
  }

  self notify("path_finished");
}

_id_DF5D237DB38291AC(_id_4211866DD591D756) {
  if(_id_4211866DD591D756 == "hitveharmorbreak")
    level notify("armorplate_broken", self);

  if(isPlayer(self)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]](_id_4211866DD591D756);
  }
}

_id_6A0B2A08499A9842() {
  if(isDefined(self._id_FE321E008E65C319))
    self._id_FE321E008E65C319._id_71C1911E983F326D = undefined;

  origin = self.origin + (0, 0, 40);

  foreach(rider in self.riders) {
    if(!isalive(rider)) {
      continue;
    }
    rider.do_immediate_ragdoll = 1;
    rider.ragdoll_immediate = 1;

    if(!istrue(rider._blackboard._id_3D633E73BBCDC23D)) {
      anim_pos = scripts\common\vehicle_aianim::anim_pos(self, rider.vehicle_position);
      rider scripts\vehicle\vehicle_common::requestentervehicle(self, 0, rider.vehicle_position, anim_pos);
    }

    if(isDefined(rider._blackboard) && isDefined(rider._blackboard.chosenvehicleanimpos)) {
      if(istrue(rider._blackboard._id_41C9F8C7891F19DA))
        rider._blackboard._id_80912EC8ADE08716 = 1;
    }

    rider dodamage(rider.health + 100, self.origin + (0, 0, -100), undefined, undefined, "MOD_EXPLOSIVE");
  }
}

_id_6A9574988F246F34(vehicle, _id_7F2253BD1B8CFA5E, _id_90A4404FCEED797F, _id_FF8E35622C1CD1C3) {
  vehicle endon("death");
  level endon("game_ended");
  vehicle endon("stop_chasing");

  if(isDefined(_id_FF8E35622C1CD1C3))
    vehicle endon(_id_FF8E35622C1CD1C3);

  _id_6EF53048A884F4E0 = 0;
  endtime = undefined;
  _id_4F951428959D4D04 = cos(91);

  for(;;) {
    dot = anglestoup(vehicle.angles)[2];

    if(dot <= _id_4F951428959D4D04) {
      if(isDefined(_id_7F2253BD1B8CFA5E))
        thread[[_id_7F2253BD1B8CFA5E]](vehicle);

      _id_DD9707A466EFA528 = 0;
      endtime = gettime() + 3000;

      for(;;) {
        if(vectordot(anglestoup(vehicle.angles), (0, 0, 1)) > _id_4F951428959D4D04) {
          break;
        }

        if(gettime() >= endtime) {
          _id_DD9707A466EFA528 = 1;
          break;
        }

        waitframe();
      }

      endtime = undefined;

      if(isDefined(_id_90A4404FCEED797F))
        thread[[_id_90A4404FCEED797F]](vehicle, _id_DD9707A466EFA528);
    }

    wait 1;
  }
}

_id_A3775811155639EA() {
  self endon("death");
  self endon("stop_chasing");
  _id_94348DD22D1C22E0 = cos(25);

  for(;;) {
    wait 0.05;
    _id_D4F1557B16691AFB = [];

    foreach(vehicle in level._id_6E5FF6CAE14C4081) {
      if(!isalive(vehicle)) {
        continue;
      }
      if(vehicle == self) {
        continue;
      }
      if(istrue(vehicle._id_3D2AFA5C9A1B1A32)) {
        continue;
      }
      if(distancesquared(self.origin, vehicle.origin) < squared(128)) {
        self._id_3D2AFA5C9A1B1A32 = 1;
        self vehicle_setspeedimmediate(20, 150, 150);
        wait 2;
        self._id_3D2AFA5C9A1B1A32 = undefined;
        self resumespeed(150);
        continue;
      }

      if(distancesquared(self.origin, vehicle.origin) < squared(250) && scripts\engine\utility::within_fov(self.origin, self.angles, vehicle.origin, _id_94348DD22D1C22E0)) {
        self._id_3D2AFA5C9A1B1A32 = 1;
        self vehicle_setspeedimmediate(20, 150, 150);
        wait 2;
        self._id_3D2AFA5C9A1B1A32 = undefined;
        self resumespeed(150);
      }
    }
  }
}

_id_BE6D24EA93BCADF7(vehicle) {
  _id_A0EEC69077D8135E = _id_24E4405CF93F20ED::_id_3A2F47EA8B6A51B3(vehicle.origin, 16, 1024);

  while(isDefined(vehicle) && vehicle vehicle_getspeed() < 2) {
    thread _id_69695F8C7ED9C3F6(_id_A0EEC69077D8135E, 300);
    self waittill("path_finished");
  }

  self notify("path_updated");
}

_id_CBA4FF426A2F58AB(pos, delay) {
  self endon("death");

  if(isDefined(delay))
    wait(delay);
  else
    wait 2;

  self.vehicle_position = pos;
  self.script_startingposition = pos;
}

_id_1DA2C31423C2676A(veh_speed) {
  if(!isDefined(self.riders))
    self.riders = [];

  if(!isDefined(self.unloadque))
    self.unloadque = [];

  self _meth_D2E41C7603BA7697("p2p");
  thread _id_24E4405CF93F20ED::_id_4808177C29F56FB9();
}

_id_8F40A2C8678F8304(start_point, end_point, speed, _id_F388271F11F8DEDA, _id_A967646668185A6D, _id_EEFDC14DD5275FD0) {
  _id_EEFDC14DD5275FD0 = scripts\engine\utility::_id_53C4C53197386572(_id_EEFDC14DD5275FD0, level._id_2814A8F25A392EAA);
  _id_ACB8205B4EAE2FA0 = undefined;

  if(!isDefined(_id_F388271F11F8DEDA))
    _id_F388271F11F8DEDA = 1;

  if(!isDefined(_id_A967646668185A6D))
    _id_A967646668185A6D = 0;

  if(distancesquared(start_point, end_point) < 62500)
    _id_ACB8205B4EAE2FA0 = [getclosestpointonnavmesh(end_point, _id_EEFDC14DD5275FD0)];
  else {
    _id_ACB8205B4EAE2FA0 = findpathcustom(start_point, getclosestpointonnavmesh(end_point, _id_EEFDC14DD5275FD0), 1, 1, _id_EEFDC14DD5275FD0);

    if(!isDefined(_id_ACB8205B4EAE2FA0))
      _id_ACB8205B4EAE2FA0 = [];

    _id_ACB8205B4EAE2FA0[0] = undefined;
  }

  if(_id_ACB8205B4EAE2FA0.size >= 1)
    return _id_AA85EB39828A4D80(_id_ACB8205B4EAE2FA0, speed, _id_F388271F11F8DEDA, _id_A967646668185A6D);
}

_id_AA85EB39828A4D80(_id_ACB8205B4EAE2FA0, speed, _id_F388271F11F8DEDA, _id_A967646668185A6D) {
  self notify("path_updated");
  self endon("path_updated");
  self endon("kill_thread_since_spotted");
  self endon("death");
  self endon("unloaded");

  if(!isDefined(speed) && !isDefined(self._id_5BBF95F73F01706E))
    return "path_blocked";

  if(istrue(_id_F388271F11F8DEDA) && isDefined(speed))
    _id_B3B7D0915DC445C7(speed);

  _id_A414823CB904BF00 = undefined;

  if(istrue(_id_A967646668185A6D))
    _id_A414823CB904BF00 = scripts\engine\utility::_id_350E192B13BEA45C(_id_ACB8205B4EAE2FA0);

  foreach(point in _id_ACB8205B4EAE2FA0) {
    _id_8FFA366EC68F0C8B = 62500;

    if(isDefined(self._id_8FFA366EC68F0C8B))
      _id_8FFA366EC68F0C8B = self._id_8FFA366EC68F0C8B;

    if(distancesquared(self.origin, point) < _id_8FFA366EC68F0C8B) {
      continue;
    }
    self _meth_77320E794D35465A("p2p", "goalPoint", point);

    if(istrue(_id_A967646668185A6D) && point == _id_A414823CB904BF00)
      self _meth_77320E794D35465A("p2p", "brakeAtGoal", 1);

    self._id_76A498119F4D69BC = point;

    if(!istrue(_id_F388271F11F8DEDA) && isDefined(speed)) {
      dist = distance(self.origin, point);
      time = undefined;

      if(dist > 0)
        time = _id_24E4405CF93F20ED::_id_CBC170D40C70CDDF(self.origin, point, speed);

      key = _func_906E53C2FB9D3F9C("p2p", "targetTime");

      if(isDefined(time))
        self _meth_77320E794D35465A(key, time);
      else
        self _meth_77320E794D35465A(key, 0.2);
    }

    result = scripts\engine\utility::waittill_any_return_2("near_goal", "path_blocked");

    if(result == "path_blocked")
      return "path_blocked";
  }

  return "near_goal";
}

_id_B3B7D0915DC445C7(speed) {
  manualspeed = _func_906E53C2FB9D3F9C("p2p", "manualSpeed");
  self _meth_77320E794D35465A(manualspeed, scripts\engine\utility::mph_to_ips(speed));
}

_id_9804C82501DE981B(_id_A0EEC69077D8135E, speed) {
  self endon("death");
  self notify("path_updated");
  self endon("path_updated");

  foreach(index, point in _id_A0EEC69077D8135E) {
    while(istrue(self._id_3D2AFA5C9A1B1A32))
      wait 0.05;

    if(isstruct(point))
      point = point.origin;

    self _meth_77320E794D35465A("p2p", "goalPoint", point);
    dist = distancesquared(self.origin, point);
    time = undefined;

    if(dist > 0)
      time = get_duration_between_points(self.origin, point, speed);

    key = _func_906E53C2FB9D3F9C("p2p", "targetTime");

    if(isDefined(time))
      self _meth_77320E794D35465A(key, time);
    else
      self _meth_77320E794D35465A(key, 0.2);

    while(distancesquared(self.origin, point) > squared(200))
      waitframe();
  }

  self notify("path_finished");
}

get_duration_between_points(startpos, endpos, speed, _id_AC43678ED65C8B44) {
  dist = distance(startpos, endpos);

  if(istrue(_id_AC43678ED65C8B44))
    dist = dist * 0.0568182;

  _id_58824A41B5315792 = dist / speed;

  if(_id_58824A41B5315792 < 0.05)
    _id_58824A41B5315792 = 0.05;

  return _id_58824A41B5315792;
}