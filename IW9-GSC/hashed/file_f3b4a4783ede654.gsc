/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_f3b4a4783ede654.gsc
***********************************************/

_id_2713FD656D03D0CE() {
  self._id_9ACFC0BD86B2E2C1 = ::_id_DF5D237DB38291AC;
  self._id_A9F96E33F612C828 = ::_id_6A0B2A08499A9842;
  _id_66B0113FE0BF4A88(self);
}

_id_DF5D237DB38291AC(_id_4211866DD591D756) {
  if(_id_4211866DD591D756 == "hitveharmorbreak")
    level notify("armorplate_broken", self);

  _id_354C862768CFE202::updatedamagefeedback(_id_4211866DD591D756);
}

_id_1719EB8CD9E18F2D() {
  self endon("drove_away");
  thread _id_F4D3D0EDD18649CB();
}

_id_AB23AE9A33E231FE() {
  self _meth_6A325F91941ED47C("p2p");
}

_id_F4D3D0EDD18649CB() {
  self endon("death");
  self endon("stop_chasing");
  self endon("unloaded");
  self endon("driverdeath");
  self _meth_D2E41C7603BA7697("p2p");
  self _meth_77320E794D35465A("p2p", "brakeAtGoal", 0);
  self _meth_77320E794D35465A("p2p", "goalThreshold", 128);
  self _meth_77320E794D35465A("p2p", "steeringMultiplier", 2.5);
  self _meth_77320E794D35465A("p2p", "stuckTime", 4);
  thread _id_58C9BBDDC21B16CA();
  level thread vehicle_watchflipped(self, ::_id_932055C45D2BC28D);

  if(!isDefined(level._id_6E5FF6CAE14C4081))
    level._id_6E5FF6CAE14C4081 = [];

  if(!scripts\engine\utility::array_contains(level._id_6E5FF6CAE14C4081, self))
    level._id_6E5FF6CAE14C4081[level._id_6E5FF6CAE14C4081.size] = self;

  veh_speed = 4000;

  if(isDefined(self.vehicle_spawner) && isDefined(self.vehicle_spawner.speed))
    veh_speed = self.vehicle_spawner.speed;

  thread _id_268D401AFDE15F5D();
  ticks = 0;
  _id_351502B59E0B2E47 = 0;
  _id_6519AB119008AAD4 = 100;
  _id_0F08A38441765C6F = 8;
  _id_28B139524196455B = 15;
  _id_182038C1B0416C06 = undefined;
  self._id_393832BCEC3AFD03 = self.riders;

  for(;;) {
    wait 0.2;
    veh_speed = 4000;

    if(isDefined(self.vehicle_spawner) && isDefined(self.vehicle_spawner.speed))
      veh_speed = self.vehicle_spawner.speed;

    _id_6D707EBC7D10DED8 = [];
    _id_BFFB55E2F8BE21EF = undefined;
    _id_C729D49D406ACED8 = undefined;

    foreach(player in level.players) {
      if(!isDefined(player.vehicle)) {
        continue;
      }
      _id_6D707EBC7D10DED8[_id_6D707EBC7D10DED8.size] = player.vehicle;
    }

    if(_id_6D707EBC7D10DED8.size)
      _id_BFFB55E2F8BE21EF = scripts\engine\utility::getclosest(self.origin, _id_6D707EBC7D10DED8);

    _id_BC36C55F86568C40 = undefined;

    if(isDefined(_id_BFFB55E2F8BE21EF) && _id_F32C4025F3271080(_id_BFFB55E2F8BE21EF)) {
      if(!istrue(_id_BFFB55E2F8BE21EF._id_11437DE736F62CB7)) {
        _id_BFFB55E2F8BE21EF thread _id_2BF62999798D0B53();
        _id_BFFB55E2F8BE21EF._id_11437DE736F62CB7 = 1;
      }

      waittillframeend;
      _id_815D30728A6EF9D9 = _id_BFFB55E2F8BE21EF _id_D866A6B5497200C5(self);
      _id_BC36C55F86568C40 = _id_815D30728A6EF9D9.origin;
      _id_DE18307EB53AA688 = 100;

      if(isDefined(self._id_038B9CF7E81E89E8))
        _id_DE18307EB53AA688 = self._id_038B9CF7E81E89E8;

      _id_FB957AB80E292860 = _id_BC36C55F86568C40 + anglesToForward(_id_BFFB55E2F8BE21EF.angles) * _id_DE18307EB53AA688;

      if(isnavmeshloaded("vehicle_med"))
        _id_FB957AB80E292860 = getclosestpointonnavmesh(_id_FB957AB80E292860, "vehicle_med");
      else
        _id_FB957AB80E292860 = getclosestpointonnavmesh(_id_FB957AB80E292860, "tank_med");
    } else {
      _id_C729D49D406ACED8 = scripts\cp\utility::get_closest_living_player();

      if(!isDefined(_id_C729D49D406ACED8)) {
        wait 1;
        continue;
      }

      if(!istrue(_id_C729D49D406ACED8._id_11437DE736F62CB7)) {
        _id_C729D49D406ACED8 thread _id_F0A7E47A3FFDEFB6();
        _id_C729D49D406ACED8._id_11437DE736F62CB7 = 1;
      }

      _id_815D30728A6EF9D9 = _id_C729D49D406ACED8 _id_D866A6B5497200C5(self);
      _id_BC36C55F86568C40 = _id_815D30728A6EF9D9.origin;
      _id_FB957AB80E292860 = _id_BC36C55F86568C40;

      if(isnavmeshloaded("vehicle_med"))
        _id_FB957AB80E292860 = getclosestpointonnavmesh(_id_FB957AB80E292860, "vehicle_med");
      else
        _id_FB957AB80E292860 = getclosestpointonnavmesh(_id_FB957AB80E292860, "tank_med");
    }

    if(distancesquared(_id_FB957AB80E292860, self.origin) > squared(800)) {
      if(isDefined(_id_182038C1B0416C06)) {
        if(distancesquared(_id_182038C1B0416C06, self.origin) < squared(100)) {
          _id_351502B59E0B2E47++;

          if(_id_351502B59E0B2E47 > _id_6519AB119008AAD4) {
            if(self isnearanyplayer(3000)) {
              thread _id_24E4405CF93F20ED::_id_FB7E5919765650EA();
              return;
            } else
              self dodamage(self.health + 10000, self.origin);
          }
        }
      }

      _id_182038C1B0416C06 = self.origin;
    } else
      _id_351502B59E0B2E47 = 0;

    if(isDefined(_id_BFFB55E2F8BE21EF)) {
      _id_D92A8EE9E2C8EEB6 = _id_BFFB55E2F8BE21EF vehicle_getspeed();

      if(_id_D92A8EE9E2C8EEB6 < 2 && distancesquared(self.origin, _id_BFFB55E2F8BE21EF.origin) < squared(750)) {
        ticks++;

        if(ticks > _id_28B139524196455B) {
          thread _id_24E4405CF93F20ED::_id_FB7E5919765650EA();
          return;
        }
      } else
        ticks = 0;
    } else if(isDefined(_id_C729D49D406ACED8)) {
      if(distancesquared(self.origin, _id_C729D49D406ACED8.origin) < squared(750)) {
        ticks++;

        if(ticks > _id_0F08A38441765C6F) {
          thread _id_24E4405CF93F20ED::_id_FB7E5919765650EA();
          return;
        }
      } else
        ticks = 0;
    }

    if(_id_B67104292A9DDCF6()) {
      _id_598F3BB771CB1027 = _id_FB08B61559C93460();

      if(_id_598F3BB771CB1027)
        return;
    } else {
      _id_B55351CF0020D1B8(_id_BC36C55F86568C40);

      if(distancesquared(self.origin, _id_BC36C55F86568C40) < squared(256))
        veh_speed = veh_speed * 0.5;

      _id_26E9E22860C819CE(self.origin, _id_BC36C55F86568C40, veh_speed, _id_FB957AB80E292860);
    }
  }
}

_id_E690609C7D9A8DBC(vehicle) {
  if(!isDefined(level._id_6E5FF6CAE14C4081))
    level._id_6E5FF6CAE14C4081 = [];

  if(!scripts\engine\utility::array_contains(level._id_6E5FF6CAE14C4081, vehicle))
    level._id_6E5FF6CAE14C4081[level._id_6E5FF6CAE14C4081.size] = vehicle;
}

_id_B55351CF0020D1B8(_id_BC36C55F86568C40) {
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

_id_268D401AFDE15F5D() {
  self endon("death");

  while(!isDefined(self._id_FE321E008E65C319))
    wait 0.5;

  self._id_FE321E008E65C319._id_71C1911E983F326D = ::_id_DC9B96BE6AA3C3C0;
}

_id_B67104292A9DDCF6() {
  if(!isDefined(level._id_DA571AA94AD22CE7) || level._id_DA571AA94AD22CE7.size == 0)
    return 0;

  return _id_1B81D51D30E14E95();
}

_id_2BF62999798D0B53() {
  self endon("death");
  self._id_3749EB0F11873D37 = spawnStruct();
  self._id_5DA685DB7D347340 = spawnStruct();
  self._id_29A8C62DD19D607E = spawnStruct();
  self._id_FD592BA2B21E3B2D = spawnStruct();
  self._id_4A35CE0251802293 = spawnStruct();
  self._id_ADEA6E80B5CBFBE2 = spawnStruct();

  for(;;) {
    fwd = anglesToForward((0, self.angles[1], 0));
    _id_CBAC2203146AE84A = anglestoright((0, self.angles[1], 0));
    _id_5445F9076B5621FA = 250;
    _id_6D5E7BAF4106D1DD = -250;

    if(isDefined(self._id_C72F42EBC770215F))
      _id_5445F9076B5621FA = self._id_C72F42EBC770215F;

    if(isDefined(self._id_B9428297ABB94A7E))
      _id_6D5E7BAF4106D1DD = self._id_B9428297ABB94A7E;

    self._id_3749EB0F11873D37.origin = getclosestpointonnavmesh(self.origin + _id_CBAC2203146AE84A * 190 + fwd * _id_5445F9076B5621FA, "tank_med");
    self._id_5DA685DB7D347340.origin = getclosestpointonnavmesh(self.origin + _id_CBAC2203146AE84A * -190 + fwd * _id_5445F9076B5621FA, "tank_med");
    self._id_4A35CE0251802293.origin = getclosestpointonnavmesh(self.origin + fwd * -500, "tank_med");
    wait 0.05;
  }
}

_id_F0A7E47A3FFDEFB6() {
  self endon("death");
  self._id_3749EB0F11873D37 = spawnStruct();
  self._id_5DA685DB7D347340 = spawnStruct();
  self._id_4A35CE0251802293 = spawnStruct();

  for(;;) {
    fwd = anglesToForward((0, self.angles[1], 0));
    _id_CBAC2203146AE84A = anglestoright((0, self.angles[1], 0));
    _id_5445F9076B5621FA = 250;
    _id_6D5E7BAF4106D1DD = -250;

    if(isDefined(self._id_C72F42EBC770215F))
      _id_5445F9076B5621FA = self._id_C72F42EBC770215F;

    if(isDefined(self._id_B9428297ABB94A7E))
      _id_6D5E7BAF4106D1DD = self._id_B9428297ABB94A7E;

    self._id_3749EB0F11873D37.origin = getclosestpointonnavmesh(self.origin + _id_CBAC2203146AE84A * 190 + fwd * _id_5445F9076B5621FA, "tank_med");
    self._id_5DA685DB7D347340.origin = getclosestpointonnavmesh(self.origin + _id_CBAC2203146AE84A * -190 + fwd * _id_5445F9076B5621FA, "tank_med");
    self._id_4A35CE0251802293.origin = getclosestpointonnavmesh(self.origin, "tank_med");
    wait 1;
  }
}

_id_D866A6B5497200C5(_id_434A337AB1F41DC7) {
  if(isDefined(_id_434A337AB1F41DC7._id_E350601F68FAF4E7) && gettime() <= _id_434A337AB1F41DC7._id_E350601F68FAF4E7._id_19798821F69BDB90)
    return _id_434A337AB1F41DC7._id_E350601F68FAF4E7;

  if(isDefined(_id_434A337AB1F41DC7._id_E350601F68FAF4E7)) {
    _id_434A337AB1F41DC7._id_E350601F68FAF4E7.claimed = undefined;
    _id_434A337AB1F41DC7._id_E350601F68FAF4E7 = undefined;
  }

  _id_440924CDE2BD48ED = [];
  _id_7EBB34CAE2C736F2 = undefined;
  level._id_6E5FF6CAE14C4081 = scripts\engine\utility::array_removeundefined(level._id_6E5FF6CAE14C4081);
  level._id_6E5FF6CAE14C4081 = scripts\engine\utility::array_removedead(level._id_6E5FF6CAE14C4081);
  _id_E4B7E99A96C8829F = [self._id_3749EB0F11873D37, self._id_5DA685DB7D347340];

  foreach(pos in _id_E4B7E99A96C8829F) {
    if(istrue(pos.blocked)) {
      continue;
    }
    if(isDefined(pos.claimed)) {
      continue;
    }
    _id_114AB88507847C50 = scripts\engine\utility::getclosest(pos.origin, level._id_6E5FF6CAE14C4081);

    if(isDefined(_id_114AB88507847C50) && _id_114AB88507847C50 != _id_434A337AB1F41DC7 && !isDefined(_id_114AB88507847C50._id_E350601F68FAF4E7) && distancesquared(_id_114AB88507847C50.origin, pos.origin) < distancesquared(_id_434A337AB1F41DC7.origin, pos.origin)) {
      continue;
    }
    _id_440924CDE2BD48ED[_id_440924CDE2BD48ED.size] = pos;
  }

  if(_id_440924CDE2BD48ED.size)
    _id_7EBB34CAE2C736F2 = scripts\engine\utility::getclosest(_id_434A337AB1F41DC7.origin, _id_440924CDE2BD48ED);
  else
    _id_7EBB34CAE2C736F2 = self._id_4A35CE0251802293;

  _id_7EBB34CAE2C736F2.claimed = _id_434A337AB1F41DC7;
  _id_7EBB34CAE2C736F2._id_19798821F69BDB90 = gettime() + 1000;
  _id_434A337AB1F41DC7._id_E350601F68FAF4E7 = _id_7EBB34CAE2C736F2;
  return _id_7EBB34CAE2C736F2;
}

_id_26E9E22860C819CE(start_point, end_point, speed, _id_91B19CFB0A78C588) {
  if(isDefined(_id_91B19CFB0A78C588)) {
    if(isnavmeshloaded("vehicle_med"))
      _id_A0EEC69077D8135E = findpathcustom(start_point, _id_91B19CFB0A78C588, 1, 1, "vehicle_med");
    else
      _id_A0EEC69077D8135E = findpathcustom(start_point, _id_91B19CFB0A78C588, 1, 1, "tank_med");

    end_point = _id_B3978EB0B7E5CD88(end_point, _id_A0EEC69077D8135E);
  } else if(isnavmeshloaded("vehicle_med"))
    _id_A0EEC69077D8135E = findpathcustom(start_point, end_point, 1, 1, "vehicle_med");
  else
    _id_A0EEC69077D8135E = findpathcustom(start_point, end_point, 1, 1, "tank_med");

  if(_id_A0EEC69077D8135E.size)
    thread _id_9804C82501DE981B(_id_A0EEC69077D8135E, speed);
  else if(distancesquared(self.origin, "goalPoint") > squared(512))
    self _meth_77320E794D35465A("p2p", "goalPoint", self.origin);
}

_id_9804C82501DE981B(_id_A0EEC69077D8135E, speed) {
  self endon("death");
  self endon("driverdeath");
  self notify("path_updated");
  self endon("path_updated");
  self._id_B7D9B54851A59550 = 1;
  _id_EA53BE4B354D1294 = speed;

  foreach(index, point in _id_A0EEC69077D8135E) {
    while(istrue(self._id_3D2AFA5C9A1B1A32))
      wait 0.05;

    if(isstruct(point))
      point = point.origin;

    self _meth_77320E794D35465A("p2p", "goalPoint", point);

    if(isDefined(speed)) {
      if(istrue(self._id_B7D9B54851A59550)) {
        speed = _id_EA53BE4B354D1294;
        _id_AA5F785752578765 = index + 2;
        _id_99F0A13B14F28C53 = cos(20);
        cur_node = point;
        _id_8BC14603A27FA3E7 = self.angles;
        _id_D91C820E8D146557 = 0;

        if(isDefined(_id_A0EEC69077D8135E[index + 1])) {
          next_node = _id_A0EEC69077D8135E[index + 1];
          _id_A3C032D45260DD10 = scripts\engine\utility::within_fov(cur_node, _id_8BC14603A27FA3E7, next_node, _id_99F0A13B14F28C53);

          if(!_id_A3C032D45260DD10) {
            speed = speed * 0.25;
            _id_D91C820E8D146557 = 1;
          }

          _id_8BC14603A27FA3E7 = vectortoangles(next_node - cur_node);

          if(!_id_D91C820E8D146557 && isDefined(_id_A0EEC69077D8135E[index + 2])) {
            _id_4F306FB3C32F2D49 = _id_A0EEC69077D8135E[index + 2];
            _id_A3C032D45260DD10 = scripts\engine\utility::within_fov(next_node, _id_8BC14603A27FA3E7, _id_4F306FB3C32F2D49, _id_99F0A13B14F28C53);

            if(!_id_A3C032D45260DD10)
              speed = speed * 0.5;

            _id_8BC14603A27FA3E7 = vectortoangles(_id_4F306FB3C32F2D49 - next_node);
          }
        }
      }

      dist = distancesquared(self.origin, point);
      time = undefined;

      if(dist > 0)
        time = _id_0E80538EF14D00E1::get_duration_between_points(self.origin, point, speed);

      if(isDefined(time))
        self _meth_77320E794D35465A("p2p", "targetTime", time);
      else
        self _meth_77320E794D35465A("p2p", "targetTime", 0.2);
    }

    _id_69BC8C927C6C970F = 200;

    if(isDefined(self._id_69BC8C927C6C970F))
      _id_69BC8C927C6C970F = self._id_69BC8C927C6C970F;

    while(distancesquared(self.origin, point) > squared(_id_69BC8C927C6C970F))
      waitframe();
  }

  self notify("path_finished");
}

_id_0F55C14F9168585A() {
  switch (self.model) {
    case "veh9_civ_lnd_techo_rebel_armor_mp":
    case "veh9_civ_lnd_techo_rebel_armor_cp":
      _id_02CC8A31F657F21D = spawnscriptable("cp_veh_cache", self.origin, self.angles);
      _id_02CC8A31F657F21D scripts\common\utility::_id_6E506F39F121EA8A(self, (-51, -5, 42), (0, 90, 0));
      _id_CB50110314060044 = spawnscriptable("cp_pickup_mike32", self.origin, self.angles);
      _id_CB50110314060044 scripts\common\utility::_id_6E506F39F121EA8A(self, (-57, 23, 60), (-60, 0, 0));
      thread scripts\cp\utility::_id_ED8121366A308031(_id_02CC8A31F657F21D);
      thread scripts\cp\utility::_id_ED8121366A308031(_id_CB50110314060044);
      break;
    case "veh8_civ_lnd_hindia_physics_mp":
      _id_02CC8A31F657F21D = spawnscriptable("cp_veh_cache", self.origin, self.angles);
      _id_02CC8A31F657F21D scripts\common\utility::_id_6E506F39F121EA8A(self, (-48, 0, 35), (0, 90, 0));
      _id_CB50110314060044 = spawnscriptable("cp_pickup_rpg", self.origin, self.angles);
      _id_CB50110314060044 scripts\common\utility::_id_6E506F39F121EA8A(self, (-65, 23, 43), (0, 180, 0));
      thread scripts\cp\utility::_id_ED8121366A308031(_id_02CC8A31F657F21D);
      thread scripts\cp\utility::_id_ED8121366A308031(_id_CB50110314060044);
      break;
  }
}

_id_DC9B96BE6AA3C3C0(idamage, smeansofdeath, sweapon, partname, _id_B17964B5DA7540EA) {
  if(isDefined(self._blackboard.currentvehicle)) {
    if(isDefined(self._blackboard.currentvehicle.healthbuffer)) {
      if(self._blackboard.currentvehicle.health - idamage < self._blackboard.currentvehicle.healthbuffer)
        return 1;
    }
  }

  if(isexplosivedamagemod(smeansofdeath))
    return 0;

  return 1;
}

_id_6A0B2A08499A9842() {
  if(isDefined(self._id_FE321E008E65C319))
    self._id_FE321E008E65C319._id_71C1911E983F326D = undefined;
}

vehicle_watchflipped(vehicle, _id_7F2253BD1B8CFA5E, _id_90A4404FCEED797F, _id_FF8E35622C1CD1C3) {
  vehicle endon("death");
  level endon("game_ended");
  vehicle endon("stop_chasing");

  if(isDefined(_id_FF8E35622C1CD1C3))
    vehicle endon(_id_FF8E35622C1CD1C3);

  _id_6EF53048A884F4E0 = 0;
  starttime = undefined;
  endtime = undefined;
  _id_4F951428959D4D04 = cos(91);

  for(;;) {
    _id_0D1D371436301D73 = 0;
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

_id_58C9BBDDC21B16CA() {
  self endon("death");
  self endon("stop_chasing");
  _id_94348DD22D1C22E0 = cos(25);

  for(;;) {
    wait 0.05;
    _id_1047A2D125E48B40 = 0;

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
      velocity = self vehicle_getvelocity();
      forward = anglesToForward(self.angles);

      if(distancesquared(self.origin, vehicle.origin) < squared(128)) {
        _id_1047A2D125E48B40 = 1;
        continue;
      }

      if(distancesquared(self.origin, vehicle.origin) < squared(500)) {
        if(vectordot(velocity, forward) >= 0) {
          if(!scripts\engine\utility::within_fov(self.origin, self.angles, vehicle.origin, _id_94348DD22D1C22E0))
            continue;
        } else if(!scripts\engine\utility::within_fov(self.origin, self.angles * -1, vehicle.origin, _id_94348DD22D1C22E0)) {
          continue;
        }
        _id_1047A2D125E48B40 = 1;
      }
    }

    if(_id_1047A2D125E48B40) {
      self._id_3D2AFA5C9A1B1A32 = 1;
      self _meth_77320E794D35465A("p2p", "brake", 1);
      wait 1;
      self._id_3D2AFA5C9A1B1A32 = undefined;
      self _meth_77320E794D35465A("p2p", "brake", -1);
    }
  }
}

_id_6FBBB66CABA5CE98(vehicle) {
  _id_A0EEC69077D8135E = create_radius_around_point(vehicle.origin, 16, 1024);

  while(isDefined(vehicle) && vehicle vehicle_getspeed() < 2) {
    thread _id_9804C82501DE981B(_id_A0EEC69077D8135E, 300);
    self waittill("path_finished");
  }

  self notify("path_updated");
}

create_radius_around_point(point, _id_037D6F0C041A42D0, _id_9973F603063C1FED) {
  _id_6F5F9433C7E91215 = 360 / _id_037D6F0C041A42D0;
  _id_E4B7E99A96C8829F = [];
  fwd = (1, 0, 0);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 360; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + _id_6F5F9433C7E91215) {
    _id_EACD072FEDC3FFAD = fwd * _id_9973F603063C1FED;
    _id_59C8F7E2D87D3710 = (cos(_id_AC0E594AC96AA3A8) * _id_EACD072FEDC3FFAD[0] - sin(_id_AC0E594AC96AA3A8) * _id_EACD072FEDC3FFAD[1], sin(_id_AC0E594AC96AA3A8) * _id_EACD072FEDC3FFAD[0] + cos(_id_AC0E594AC96AA3A8) * _id_EACD072FEDC3FFAD[1], _id_EACD072FEDC3FFAD[2]);
    pos = point + _id_59C8F7E2D87D3710;
    position = spawnStruct();
    position.origin = pos;
    position.origin = getgroundposition(position.origin, 128, 5000, 4000);
    position.origin = getclosestpointonnavmesh(position.origin, "tank_med");
    _id_E4B7E99A96C8829F[_id_E4B7E99A96C8829F.size] = position;
  }

  return _id_E4B7E99A96C8829F;
}

_id_05A5EED0DB2E9F17() {
  return istrue(self._id_F4E9A19962A09084);
}

_id_9C21FE56EDB135F2() {
  self notify("path_updated");
  self notify("stop_chasing");
  self endon("death");
  level._id_6E5FF6CAE14C4081 = scripts\engine\utility::array_remove(level._id_6E5FF6CAE14C4081, self);
  endpoint = _id_1BD9B45EAD8295A0();
  startpoint = self.origin;
  _id_A0EEC69077D8135E = findpathcustom(startpoint, getclosestpointonnavmesh(endpoint, "tank_med"), 0, 1, "tank_med");
  thread _id_9804C82501DE981B(_id_A0EEC69077D8135E, 3000);
  self waittill("path_finished");
  self._id_A9F96E33F612C828 = undefined;
  self delete();
}

_id_1BD9B45EAD8295A0() {
  return (-5439.94, 9003.53, 4657.86);
}

_id_932055C45D2BC28D(vehicle) {
  foreach(rider in vehicle.riders) {
    if(!isalive(rider)) {
      continue;
    }
    rider.do_immediate_ragdoll = 1;
    rider dodamage(rider.health + 1000, rider.origin);
  }

  vehicle notify("stop_chasing");
  vehicle notify("path_updated");
  vehicle dodamage(vehicle.health + 1000, (0, 0, 0));
  wait 1;
  level notify("vehicle_flipped");
}

_id_F32C4025F3271080(vehicle) {
  _id_E7F0E4260E1F48C6 = 0;

  foreach(player in level.players) {
    if(_id_0AFB7E332AEE4BF2::player_in_laststand(player)) {
      continue;
    }
    if(!isDefined(player.vehicle) && !istrue(player istouching(vehicle))) {
      continue;
    }
    _id_E7F0E4260E1F48C6 = 1;
  }

  return _id_E7F0E4260E1F48C6;
}

_id_DE56A2B6B7FA16B0(_id_AB1E83DDD1E40DB7) {
  wait 1;
  self _meth_E4FE23E19F4BF900(_id_AB1E83DDD1E40DB7);
}

_id_66B0113FE0BF4A88(vehicle) {
  if(!isDefined(level.special_lockon_target_list))
    level.special_lockon_target_list = [];

  level.special_lockon_target_list[level.special_lockon_target_list.size] = vehicle;
}

_id_FB08B61559C93460() {
  self endon("death");

  if(isDefined(level._id_DA571AA94AD22CE7)) {
    _id_7408ED52662703D3 = 0;
    _id_89BD9FE81E7A5877 = [];

    foreach(point in level._id_DA571AA94AD22CE7) {
      active = 0;

      foreach(player in level.players) {
        if(distancesquared(player.origin, point.origin) <= squared(point.radius)) {
          _id_7408ED52662703D3++;
          active = 1;
        }
      }

      if(active)
        _id_89BD9FE81E7A5877[_id_89BD9FE81E7A5877.size] = point;
    }

    if(_id_7408ED52662703D3 == level.players.size) {
      if(!isDefined(self._id_A8D8EE0C52FB743F))
        self._id_A8D8EE0C52FB743F = gettime() + 5000;

      if(gettime() < self._id_A8D8EE0C52FB743F)
        return 0;

      _id_0FB249E5742230F8 = scripts\engine\utility::getclosest(self.origin, _id_89BD9FE81E7A5877);
      _id_D5F7B3700D04322C = scripts\engine\utility::getclosest(self.origin, _id_0FB249E5742230F8._id_3D0EB27CDE95D306);

      if(!isDefined(_id_D5F7B3700D04322C._id_64E1820837556B52))
        _id_D5F7B3700D04322C._id_64E1820837556B52 = 0;

      _id_CF41A8A0E5C72C2B = getclosestpointonnavmesh(_id_D5F7B3700D04322C.origin, 0);

      if(_id_D5F7B3700D04322C._id_64E1820837556B52 > 0) {
        fwd = vectortoangles(_id_D5F7B3700D04322C.origin - self.origin);
        _id_CF41A8A0E5C72C2B = getclosestpointonnavmesh(_id_D5F7B3700D04322C.origin + anglesToForward(fwd) * (300 * _id_D5F7B3700D04322C._id_64E1820837556B52), 0);
      }

      _id_26E9E22860C819CE(self.origin, _id_CF41A8A0E5C72C2B, 4500);

      while(distance(self.origin, _id_CF41A8A0E5C72C2B) > 1500 && _id_1B81D51D30E14E95())
        wait 1;

      self notify("path_updated");
      _id_7408ED52662703D3 = 0;
      _id_89BD9FE81E7A5877 = [];

      foreach(point in level._id_DA571AA94AD22CE7) {
        active = 0;

        foreach(player in level.players) {
          if(distancesquared(player.origin, point.origin) <= squared(point.radius)) {
            _id_7408ED52662703D3++;
            active = 1;
          }
        }

        if(active)
          _id_89BD9FE81E7A5877[_id_89BD9FE81E7A5877.size] = point;
      }

      if(_id_7408ED52662703D3 != level.players.size)
        return 0;

      _id_D5F7B3700D04322C._id_64E1820837556B52++;
      thread _id_24E4405CF93F20ED::_id_FB7E5919765650EA();
      self notify("stop_chasing");
      return 1;
    }
  }
}

_id_1B81D51D30E14E95() {
  _id_7408ED52662703D3 = 0;

  foreach(point in level._id_DA571AA94AD22CE7) {
    foreach(player in level.players) {
      if(distancesquared(player.origin, point.origin) <= squared(point.radius))
        _id_7408ED52662703D3++;
    }
  }

  return _id_7408ED52662703D3 == level.players.size;
}

_id_B3978EB0B7E5CD88(org, array) {
  _id_114AB88507847C50 = array[0];

  foreach(point in array) {
    if(distancesquared(point, org) > distancesquared(_id_114AB88507847C50, org)) {
      continue;
    }
    _id_114AB88507847C50 = point;
  }

  return _id_114AB88507847C50;
}