/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_24e4405cf93f20ed.gsc
***********************************************/

_id_1686ECAABFDC542D() {
  self _meth_6A325F91941ED47C("p2p");
}

_id_4808177C29F56FB9() {
  while(!isDefined(self._id_FE321E008E65C319))
    wait 0.5;

  if(isDefined(self._id_FE321E008E65C319))
    self._id_FE321E008E65C319._id_71C1911E983F326D = ::_id_BAEFD5546EDE6550;
}

_id_EEE51130CC8DCE38() {
  return isDefined(self) && isDefined(self._id_FE321E008E65C319) && isDefined(self._id_FE321E008E65C319.health) && self._id_FE321E008E65C319.health < 1;
}

_id_8D531048CD1ABB65(_id_434A337AB1F41DC7) {
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

_id_BAEFD5546EDE6550(idamage, smeansofdeath, sweapon, partname, _id_B17964B5DA7540EA) {
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

_id_3A2F47EA8B6A51B3(point, _id_037D6F0C041A42D0, _id_9973F603063C1FED) {
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

_id_5FA782EC5794DA38(vehicle) {
  vehicleoccupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(vehicle);
  _id_E54346E77D062FBE = scripts\engine\utility::array_intersection(vehicleoccupants, level.players);

  if(_id_E54346E77D062FBE.size > 0)
    return 1;
  else {
    foreach(player in level.players) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isInLastStand")) {
        if([[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isInLastStand")]](player))
          continue;
      }

      if(!isDefined(player.vehicle) && !istrue(player istouching(vehicle))) {
        continue;
      }
      return 1;
    }
  }

  return 0;
}

_id_C06BD2EA8930EEBF(org, array) {
  _id_114AB88507847C50 = array[0];

  foreach(point in array) {
    if(distancesquared(point, org) > distancesquared(_id_114AB88507847C50, org)) {
      continue;
    }
    _id_114AB88507847C50 = point;
  }

  return _id_114AB88507847C50;
}

_id_AA7F0C3DEF8F14DB(_id_45E808DC306D0926, _id_908ECECF1B52292E) {
  _id_07296729673615C7 = scripts\engine\utility::ter_op(isDefined(_id_45E808DC306D0926), _id_45E808DC306D0926, 1073741824);
  _id_2A29B237DCC66FE5 = scripts\engine\utility::ter_op(isDefined(_id_908ECECF1B52292E), _id_908ECECF1B52292E, level.players);
  _id_C729D49D406ACED8 = undefined;

  foreach(player in _id_2A29B237DCC66FE5) {
    if(isDefined(level.ignoredbycheck) && [[level.ignoredbycheck]](self, player)) {
      continue;
    }
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isInLastStand")) {
      if([[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isInLastStand")]](player))
        continue;
    }

    _id_A9B6B677F6D0A010 = distancesquared(self.origin, player.origin);

    if(player scripts\cp_mp\utility\player_utility::_isalive() && _id_A9B6B677F6D0A010 < _id_07296729673615C7) {
      _id_C729D49D406ACED8 = player;
      _id_07296729673615C7 = _id_A9B6B677F6D0A010;
    }
  }

  return _id_C729D49D406ACED8;
}

_id_CBC170D40C70CDDF(startpos, endpos, speed, _id_AC43678ED65C8B44) {
  dist = distance(startpos, endpos);

  if(istrue(_id_AC43678ED65C8B44))
    dist = dist * 0.0568182;

  _id_58824A41B5315792 = dist / speed;
  return max(_id_58824A41B5315792, 0.05);
}

_id_7D8F81A94DC08A15(_id_DE361E39117AE3D1, exittype) {
  level endon("game_ended");
  self endon("death");
  self endon("vehicle_owner_update");
  self notify("path_updated");
  self _meth_77320E794D35465A("p2p", "manualSpeed", 0);
  self _meth_77320E794D35465A("p2p", "brakeAtGoal", 1);
  self _meth_77320E794D35465A("p2p", "goalPoint", self.origin);
  self vehicle_setspeedimmediate(0, 1, 1);
  self vehicle_cleardrivingstate();
  waitframe();
  childthread _id_C4D871CCF375FB3B();

  if(istrue(_id_DE361E39117AE3D1))
    thread _id_F4A6F33EECA44E04();

  foreach(rider in self.riders) {
    if(isDefined(rider) && isDefined(exittype) && exittype == "combat")
      rider setstealthstate("combat");

    if(!isDefined(rider) || !isDefined(rider.asmname) || !isDefined(rider._blackboard) || !isDefined(rider._blackboard._id_1745D2B69C72C627) || !isDefined(rider._blackboard._id_9176CAE5619D7FBA) || !isDefined(rider._blackboard.currentvehicleanimalias)) {
      continue;
    }
    animindex = archetypegetrandomalias(rider._blackboard.currentvehicleanimalias, "get_out_vehicle_combat", rider._blackboard._id_9176CAE5619D7FBA, 0);

    if(!isDefined(animindex)) {
      continue;
    }
    xanim = animsetgetanimfromindex(rider._blackboard.currentvehicleanimalias, "get_out_vehicle_combat", animindex);

    if(!isDefined(xanim)) {
      continue;
    }
    targetorigin = rider _id_A66D296B49CF74BF(self, xanim, rider._blackboard._id_1745D2B69C72C627, self.origin, self.angles, 1.0);

    if(distance2dsquared(targetorigin, getclosestpointonnavmesh(targetorigin)) > 6400) {
      _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(rider, "skipDeathCount", 1);
      rider kill();
    }
  }

  scripts\common\vehicle_code::_vehicle_unload("default");

  if(scripts\common\vehicle_aianim::riders_unloadable("default"))
    self waittill("unloaded");

  if(isDefined(level.vehicle._id_9442D439C225C3FE))
    [[level.vehicle._id_9442D439C225C3FE]](self);
}

_id_A66D296B49CF74BF(vehicle, _id_DE99D908F027883A, _id_CBFBB4EFA1348391, _id_7661FCE9997CC9A4, _id_9DFDF50ED960E7F3, _id_47B4BDC915CFF70D) {
  tagorigin = vehicle gettagorigin(_id_CBFBB4EFA1348391);
  _id_A43B0202C06E0907 = vehicle gettagangles(_id_CBFBB4EFA1348391);
  startorigin = getstartorigin(tagorigin, _id_A43B0202C06E0907, _id_DE99D908F027883A);
  startangles = getstartangles(tagorigin, _id_A43B0202C06E0907, _id_DE99D908F027883A);
  movedelta = getmovedelta(_id_DE99D908F027883A, 0.0, _id_47B4BDC915CFF70D);
  return rotatevector(movedelta, startangles) + startorigin;
}

_id_C4D871CCF375FB3B() {
  while(self vehicle_getspeed() > 0)
    waitframe();

  self _meth_65AA053C077C003A(1);
}

_id_F4A6F33EECA44E04() {
  self endon("death");
  _id_8A5E6A7DB939E7B3();
  self _meth_6A325F91941ED47C("p2p");
}

_id_8A5E6A7DB939E7B3() {
  self endon("vehicle_owner_update");

  while(self vehicle_getspeed() > 0)
    waitframe();
}

_id_FB7E5919765650EA() {
  self endon("death");

  if(istrue(self.unloading)) {
    return;
  }
  self.unloading = 1;
  riders = self.riders;
  _id_5D3DD28D4C5AF8B2(riders);
  _id_7D8F81A94DC08A15(1);
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_887B4E2CBE3AB92C();
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(self, "neutral");
}

_id_5D3DD28D4C5AF8B2(riders) {
  foreach(rider in riders) {
    if(isDefined(rider._id_58CC857EE7806CBF))
      rider.nocorpse = rider._id_58CC857EE7806CBF;
    else
      rider.nocorpse = undefined;

    if(isDefined(rider._id_DFDAC8CFFA760661))
      rider.dropweapon = rider._id_DFDAC8CFFA760661;

    if(isDefined(rider._id_6FAD0BE819FD216C))
      rider._id_AD799295A6692B29 = rider._id_6FAD0BE819FD216C;

    if(isDefined(rider._id_942B19D1F934DBCD))
      rider._id_0D932F46857D6D61 = rider._id_942B19D1F934DBCD;

    rider _meth_5847240C0F9900F2(1);
  }
}

_id_64D2D74AB85E00BB(riders) {
  foreach(rider in riders) {
    if(isDefined(rider.dropweapon))
      rider._id_DFDAC8CFFA760661 = rider.dropweapon;

    rider.dropweapon = 0;

    if(isDefined(rider._id_AD799295A6692B29))
      rider._id_6FAD0BE819FD216C = rider._id_AD799295A6692B29;

    rider._id_AD799295A6692B29 = 1;

    if(isDefined(rider._id_0D932F46857D6D61))
      rider._id_0FA586C70F3F42DA = rider._id_0D932F46857D6D61;

    rider._id_0D932F46857D6D61 = undefined;
    rider _meth_5847240C0F9900F2(0);
  }
}