/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\vehicle_damage.gsc
*****************************************************/

vehicle_damage_setCanDamage(_id_E3108E412AFB3811) {
  linkedents = self getlinkedchildren(1);

  if(isDefined(linkedents)) {
    foreach(linkedent in linkedents) {
      if(isDefined(linkedent.code_classname) && linkedent.code_classname == "misc_turret") {
        if(_id_E3108E412AFB3811) {
          linkedent thread vehicle_damage_keepturretalive(self);
          continue;
        }

        linkedent vehicle_damage_keepturretaliveend();
      }
    }
  }

  self setCanDamage(_id_E3108E412AFB3811);
  vehicle_damage_cleareventlog(self);
}

vehicle_damage_getleveldataforvehicle(_id_7731ADEF63E19B0C, create, _id_6ECB77FD1F27C667) {
  if(istrue(create) && (!scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C(_id_7731ADEF63E19B0C) || !isDefined(scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(_id_7731ADEF63E19B0C).damage) || !isDefined(scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(_id_7731ADEF63E19B0C).damage.class))) {
    data = undefined;

    if(!scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C(_id_7731ADEF63E19B0C))
      data = spawnStruct();
    else
      data = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(_id_7731ADEF63E19B0C);

    if(!isDefined(data.damage))
      data.damage = spawnStruct();

    data.damage.damagestatedata = [];
    data.damage.class = "none";
    data.damage.visualpercents = [];
    data.damage.visualcallbacks = [];
    data.damage.visualclearcallbacks = [];
    level._id_A0B2C978CA57FFC5[_id_7731ADEF63E19B0C] = data;
  }

  if(scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C(_id_7731ADEF63E19B0C))
    return scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(_id_7731ADEF63E19B0C).damage;
}

vehicle_damage_getinstancedataforvehicle(vehicle, create, _id_6ECB77FD1F27C667) {
  _id_72141EAB56FB408F = vehicle.damagedata;

  if(!isDefined(_id_72141EAB56FB408F)) {
    if(istrue(create)) {
      _id_72141EAB56FB408F = spawnStruct();
      vehicle.damagedata = _id_72141EAB56FB408F;
      _id_72141EAB56FB408F.destroyscoreevent = undefined;
      _id_72141EAB56FB408F.destroyscorelaunchonly = undefined;
      _id_72141EAB56FB408F.destroyaward = undefined;
      _id_72141EAB56FB408F.destroyawardlaunchonly = undefined;
      _id_72141EAB56FB408F.heavydamagescoreevent = undefined;
      _id_72141EAB56FB408F.heavydamagescorelaunchonly = undefined;
      _id_72141EAB56FB408F.heavydamageaward = undefined;
      _id_72141EAB56FB408F.heavydamageawardlaunchonly = undefined;
    } else if(!istrue(_id_6ECB77FD1F27C667)) {}
  }

  return _id_72141EAB56FB408F;
}

vehicle_damage_deregisterinstance(vehicle) {
  vehicle.damagedata = undefined;
}

vehicle_damage_getleveldatafordamagestate(_id_7731ADEF63E19B0C, _id_CB322750051A892B, create, _id_6ECB77FD1F27C667) {
  _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(_id_7731ADEF63E19B0C, create, _id_6ECB77FD1F27C667);
  _id_D2E455D494F8D46E = _id_E2818AD39A3341B4.damagestatedata[_id_CB322750051A892B];

  if(!isDefined(_id_D2E455D494F8D46E)) {
    if(istrue(create)) {
      _id_D2E455D494F8D46E = spawnStruct();
      _id_E2818AD39A3341B4.damagestatedata[_id_CB322750051A892B] = _id_D2E455D494F8D46E;
      _id_D2E455D494F8D46E.maxhealth = undefined;
      _id_D2E455D494F8D46E.onentercallback = undefined;
      _id_D2E455D494F8D46E.onexitcallback = undefined;
    } else if(!istrue(_id_6ECB77FD1F27C667)) {}
  }

  return _id_D2E455D494F8D46E;
}

vehicle_damage_clearvisuals(data, _id_D7D8FAA73DE16FAF, _id_FCEF8D217A441961) {
  _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD(), 0, 1);

  if(isDefined(_id_E2818AD39A3341B4)) {
    foreach(callback in _id_E2818AD39A3341B4.visualclearcallbacks)
    self thread[[callback]](data, _id_D7D8FAA73DE16FAF, _id_FCEF8D217A441961);
  }
}

_id_B0662E99FCC0B8E0() {
  _id_653B96CE8310763E(self.maxhealth);
}

_id_653B96CE8310763E(_id_CA12FF65FD9D113E) {
  self.health = int(min(self.health + _id_CA12FF65FD9D113E, self.maxhealth));
  _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD(), undefined, 1);

  if(!isDefined(_id_E2818AD39A3341B4)) {
    return;
  }
  _id_E1D544CB065687F0(undefined, 0, 1);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsondamage(self);
}

_id_9CAC3AF67EE6B40A(vehicle, player, idamage, idflags, shitloc, smeansofdeath, eattacker, objweapon) {
  seatid = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(vehicle, player);
  _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());

  if(isDefined(seatid)) {
    seatdata = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD(), seatid);

    if(isDefined(_id_E2818AD39A3341B4._id_B7B1DDCAAF4BF2DB) && isDefined(_id_E2818AD39A3341B4._id_B7B1DDCAAF4BF2DB[seatid]))
      idamage = idamage * _id_E2818AD39A3341B4._id_B7B1DDCAAF4BF2DB[seatid];

    if(isDefined(_id_E2818AD39A3341B4._id_8F793C5830904E92) && isDefined(_id_E2818AD39A3341B4._id_8F793C5830904E92[seatid]))
      idamage = clamp(idamage, 0, _id_E2818AD39A3341B4._id_8F793C5830904E92[seatid]);

    if(isDefined(seatdata) && isDefined(seatdata._id_DCFC487F4EF1103C) && isDefined(idflags) && idflags &level.idflags_penetration && !(idflags &level.idflags_penetration_player_only) && !player _meth_A7DE57196F4B5D16() && !(scripts\cp_mp\utility\damage_utility::isheadshot(shitloc, smeansofdeath, eattacker) && isDefined(objweapon) && weaponclass(objweapon) == "sniper"))
      idamage = idamage * seatdata._id_DCFC487F4EF1103C;
  }

  return idamage;
}

_id_F7123F6D38D50909() {
  self endon("death");
  _id_A913D098054D5BCE();
  castcontents = physics_createcontents(["physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water", "physicscontents_item"]);

  for(;;) {
    if(!isDefined(self._id_B31F13A4E30B5AA5) || self._id_B31F13A4E30B5AA5.size == 0 || !isDefined(self.origin)) {
      break;
    }

    if(istrue(self._id_0285A0756C95A7A5)) {
      waitframe();
      continue;
    }

    _id_AC6CA28A64718193 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getteamfriendlyto(self);
    scripts\cp_mp\utility\game_utility::_id_F5E8B13ACC5B4E24();

    foreach(_id_0AC9FE0AFFFB8EF7 in level._id_715AA7F8DE54C394 scripts\engine\utility::_id_0DF633F460888A47(self.origin)) {
      foreach(projectile in _id_0AC9FE0AFFFB8EF7) {
        if(!isDefined(projectile) || !isDefined(projectile.origin)) {
          continue;
        }
        if(distancesquared(projectile.origin, self.origin) > 160000) {
          continue;
        }
        owner = projectile.owner;

        if(!isDefined(owner) && isDefined(projectile.weapon_name) && weaponclass(projectile.weapon_name) == "grenade")
          owner = getmissileowner(projectile);

        _id_F31940D93AFC41DB = 1;

        if(_id_F31940D93AFC41DB && isDefined(owner) && scripts\engine\utility::is_equal(_id_AC6CA28A64718193, owner.team)) {
          continue;
        }
        _id_7133A9D4A8862078 = projectile.origin;

        foreach(tagname, data in self._id_B31F13A4E30B5AA5) {
          tagorigin = self gettagorigin(tagname);
          _id_9814372C47655550 = _id_7133A9D4A8862078 - tagorigin;
          angle = scripts\engine\math::anglebetweenvectors(_id_9814372C47655550, anglesToForward(self gettagangles(tagname)));

          if(angle > 30) {
            continue;
          }
          _id_E021C2744CC7ED68 = physics_raycast(tagorigin, _id_7133A9D4A8862078, castcontents, [self, projectile], 0, "physicsquery_closest");

          if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0) {
            continue;
          }
          _id_ED478E32F316BD8C = issubstr(tagname, "left");
          _id_EABA477D71B264E6 = undefined;

          foreach(_id_D51D85D97D08BFE7, data in scripts\engine\utility::array_randomize_objects(self._id_B31F13A4E30B5AA5)) {
            if(_id_D51D85D97D08BFE7 == tagname || issubstr(_id_D51D85D97D08BFE7, "left") != _id_ED478E32F316BD8C) {
              continue;
            }
            _id_EABA477D71B264E6 = _id_D51D85D97D08BFE7;
            break;
          }

          self._id_AAB9695C92B0ED96[tagname]._id_A776F097EB36E500 = 0;
          _id_77DB32AA48A42A76(self, tagname, undefined, 1);

          if(isDefined(_id_EABA477D71B264E6)) {
            self._id_AAB9695C92B0ED96[_id_EABA477D71B264E6]._id_A776F097EB36E500 = 0;
            _id_77DB32AA48A42A76(self, _id_EABA477D71B264E6, undefined, 1);
          }

          _id_577BB0F5A3FCC2BC(projectile);
          break;
        }
      }
    }

    waitframe();
  }
}

_id_577BB0F5A3FCC2BC(target) {
  target setCanDamage(0);
  target.exploding = 1;
  target stopsounds();

  if(!isDefined(target.owner)) {
    return;
  }
  if(isPlayer(target.owner))
    target.owner _id_5762AC2F22202BA2::updatedamagefeedback("reactivearmorexplosion");

  self._id_AA2660B54E981080 dontinterpolate();
  self._id_AA2660B54E981080.origin = target.origin;
  up = target.origin - self.origin;
  right = up + (1, 0, 0);
  forward = vectorcross(up, right);
  right = vectorcross(forward, up);
  self._id_AA2660B54E981080.angles = axistoangles(forward, right, up);

  if(istrue(self.explode1available)) {
    self._id_AA2660B54E981080 setscriptablepartstate("explode1", "activeDirectional", 0);
    self.explode1available = 0;
  } else {
    self._id_AA2660B54E981080 setscriptablepartstate("explode2", "activeDirectional", 0);
    self.explode1available = 1;
  }

  if(isDefined(target.streakname) && target.streakname == "cruise_predator")
    target notify("trophy_blocked");
  else
    target delete();
}

_id_A913D098054D5BCE() {
  explosion = spawn("script_model", self.origin);
  explosion setModel("trophy_system_mp_explode");
  self.explode1available = 1;
  self._id_AA2660B54E981080 = explosion;
}

_id_870CBF6CA47076B6(_id_7731ADEF63E19B0C) {
  return vehicle_damage_getleveldataforvehicle(_id_7731ADEF63E19B0C)._id_9D70F02394C136DA;
}

_id_32B9B5D07BB56C31(_id_7731ADEF63E19B0C) {
  return vehicle_damage_getleveldataforvehicle(_id_7731ADEF63E19B0C)._id_CCFDE1208EF2964B;
}

_id_BC320CF9A1B27CB5(_id_7731ADEF63E19B0C, tagname, _id_B4FCCC158C681073, _id_1C60586652067D4C) {
  _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(_id_7731ADEF63E19B0C);

  if(isDefined(_id_B4FCCC158C681073))
    _id_E2818AD39A3341B4._id_AAB9695C92B0ED96[tagname]._id_B4FCCC158C681073 = _id_B4FCCC158C681073;

  if(isDefined(_id_1C60586652067D4C))
    _id_E2818AD39A3341B4._id_AAB9695C92B0ED96[tagname]._id_1C60586652067D4C = _id_1C60586652067D4C;
}

_id_1F39191797C711B6(_id_7731ADEF63E19B0C, _id_08490F7216313A83) {
  _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(_id_7731ADEF63E19B0C);
  _id_E2818AD39A3341B4._id_08490F7216313A83 = _id_08490F7216313A83;
}

_id_268E0E5863858DCF(vehicle, spawndata) {
  _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD(), 0, 1);
  _id_5E1984DBB5848080 = vehicle scripts\cp_mp\vehicles\vehicle::_id_B7148A3BFC4DEFB2();
  tags = undefined;

  if(isDefined(spawndata._id_AAB9695C92B0ED96))
    tags = spawndata._id_AAB9695C92B0ED96;
  else if(_id_5E1984DBB5848080)
    tags = _id_E2818AD39A3341B4._id_CCFDE1208EF2964B;
  else
    tags = _id_E2818AD39A3341B4._id_9D70F02394C136DA;

  if(isDefined(tags)) {
    vehicle._id_AAB9695C92B0ED96 = [];

    foreach(tagname, _id_BAFA22FCDEFFF511 in tags) {
      if(istrue(_id_BAFA22FCDEFFF511.inactive)) {
        continue;
      }
      _id_1C09C3E40955F379 = spawnStruct();
      _id_1C09C3E40955F379._id_A776F097EB36E500 = _id_BAFA22FCDEFFF511._id_A776F097EB36E500;
      _id_1C09C3E40955F379._id_92894EF28E2B8800 = _id_BAFA22FCDEFFF511._id_92894EF28E2B8800;
      vehicle._id_AAB9695C92B0ED96[tagname] = _id_1C09C3E40955F379;

      if(istrue(_id_BAFA22FCDEFFF511._id_EA596CAE0D362D35) && !_id_5E1984DBB5848080) {
        if(!isDefined(vehicle._id_B31F13A4E30B5AA5))
          vehicle._id_B31F13A4E30B5AA5 = [];

        vehicle._id_B31F13A4E30B5AA5[tagname] = _id_1C09C3E40955F379;
      }
    }
  }

  if(isDefined(vehicle._id_B31F13A4E30B5AA5))
    vehicle thread _id_F7123F6D38D50909();
}

_id_9B27177AD97BB8D8(vehicle) {
  if(!isDefined(vehicle) || !vehicle scripts\cp_mp\vehicles\vehicle::isvehicle() || vehicle scripts\cp_mp\vehicles\vehicle::_id_B7148A3BFC4DEFB2()) {
    return;
  }
  data = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());
  tags = data.damage._id_9D70F02394C136DA;

  if(!isDefined(data) || !isDefined(data.interact) || !isDefined(data.interact.lights) || !isDefined(vehicle._id_AAB9695C92B0ED96) || !isDefined(tags)) {
    return;
  }
  foreach(tag, light in data.interact.lights) {
    if(!isDefined(vehicle._id_AAB9695C92B0ED96[tag]) || !_id_853C0063F08B55E1(vehicle._id_AAB9695C92B0ED96[tag])) {
      continue;
    }
    if(!isDefined(tags[tag])) {
      return;
    }
    vehicle._id_AAB9695C92B0ED96[tag] = spawnStruct();
    vehicle._id_AAB9695C92B0ED96[tag]._id_A776F097EB36E500 = tags[tag]._id_A776F097EB36E500;
    vehicle._id_AAB9695C92B0ED96[tag]._id_92894EF28E2B8800 = tags[tag]._id_92894EF28E2B8800;
    state = "off";

    if(istrue(vehicle._id_6A73F11D95750B87)) {
      if(light.type == "engine_is_on_day_and_night")
        state = "on";
      else if(scripts\cp_mp\vehicles\vehicle_interact::_id_5519F4E75A7E2D2B() && light.type == "engine_is_on_at_night")
        state = "on";
    }

    vehicle setscriptablepartstate(tag, state);
    break;
  }
}

_id_963F1CB109B9C186(vehicle, tag) {
  if(!isDefined(vehicle) || !isDefined(tag))
    return 0;

  data = vehicle_damage_getleveldataforvehicle(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());
  tags = undefined;

  if(vehicle scripts\cp_mp\vehicles\vehicle::_id_B7148A3BFC4DEFB2())
    tags = data._id_CCFDE1208EF2964B;
  else
    tags = data._id_9D70F02394C136DA;

  if(!isDefined(tags[tag]))
    return 0;

  _id_BAFA22FCDEFFF511 = spawnStruct();
  _id_BAFA22FCDEFFF511._id_A776F097EB36E500 = tags[tag]._id_A776F097EB36E500;
  _id_BAFA22FCDEFFF511._id_92894EF28E2B8800 = tags[tag]._id_92894EF28E2B8800;

  if(!isDefined(vehicle._id_AAB9695C92B0ED96))
    vehicle._id_AAB9695C92B0ED96 = [];

  vehicle._id_AAB9695C92B0ED96[tag] = _id_BAFA22FCDEFFF511;
  vehicle setscriptablepartstate(tag, "default");
}

_id_152437480E61A8A2(vehicle, damagedata, _id_69CFD14B4398C458) {
  damagemultiplier = 1.0;
  _id_F1A0290E8F712715 = _id_786C7EC25AAD5005(vehicle, damagedata);
  ref = vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();
  vehicledata = vehicle_damage_getleveldataforvehicle(ref);

  foreach(tagname in _id_F1A0290E8F712715) {
    if(!_id_6E87D9E8601D9029(vehicle, tagname, damagedata)) {
      continue;
    }
    _id_FC00C9EFA9CEBDBC = vehicle._id_AAB9695C92B0ED96[tagname]._id_A776F097EB36E500;
    damage = max(0, _id_69CFD14B4398C458 - _id_C9F618F05861C2C5(ref, tagname));
    _id_F943483E687A2247 = max(0, _id_FC00C9EFA9CEBDBC - damage);
    vehicle._id_AAB9695C92B0ED96[tagname]._id_A776F097EB36E500 = _id_F943483E687A2247;

    if(isDefined(damagedata) && isDefined(damagedata.objweapon) && scripts\cp_mp\utility\damage_utility::iscrossbowdamage(damagedata.objweapon)) {
      if(_id_EE1FF9EED64D1E5D(vehicle, tagname))
        vehicle._id_AAB9695C92B0ED96[tagname]._id_A776F097EB36E500 = 0;
    }

    if(isexplosivedamagemod(damagedata.meansofdeath)) {
      _id_858E06144FFAAF87 = vehicle._id_AAB9695C92B0ED96[tagname]._id_92894EF28E2B8800;
      _id_9824258C4E398DAA = _id_858E06144FFAAF87 - _id_69CFD14B4398C458;
      vehicle._id_AAB9695C92B0ED96[tagname]._id_92894EF28E2B8800 = max(0, _id_9824258C4E398DAA);

      if(istrue(vehicledata._id_AAB9695C92B0ED96[tagname]._id_C2436C09C1535A40))
        damagemultiplier = damagemultiplier * 0.33;
    } else if(istrue(vehicledata._id_AAB9695C92B0ED96[tagname]._id_6B0CFEBBBBB62B27))
      damagemultiplier = 0.0001;

    if(_id_853C0063F08B55E1(vehicle._id_AAB9695C92B0ED96[tagname])) {
      _id_77DB32AA48A42A76(vehicle, tagname, damagedata);
      continue;
    }

    _id_CF8EAF8BC98090A6 = _id_DDE06C2157EC8895(ref, tagname);

    if(isDefined(_id_CF8EAF8BC98090A6))
      vehicle thread[[_id_CF8EAF8BC98090A6]](vehicle, damagedata);
  }

  return damagemultiplier;
}

_id_9B1B715FEB24F29F(vehicle, damagedata) {
  ref = vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();

  if(!isDefined(ref)) {
    return;
  }
  vehicledata = vehicle_damage_getleveldataforvehicle(ref);

  if(!isDefined(vehicledata)) {
    return;
  }
  _id_99137F3B2D0EC5F0 = vehicledata._id_AAB9695C92B0ED96;

  if(!isDefined(_id_99137F3B2D0EC5F0)) {
    return;
  }
  _id_F1A0290E8F712715 = _id_786C7EC25AAD5005(vehicle, damagedata);

  foreach(tagname in _id_F1A0290E8F712715) {
    if(_id_6E87D9E8601D9029(vehicle, tagname, damagedata)) {
      if(!isDefined(_id_99137F3B2D0EC5F0[tagname]) || !isDefined(_id_99137F3B2D0EC5F0[tagname]._id_9EB2AF3A3212B936)) {
        continue;
      }
      if(isexplosivedamagemod(damagedata.meansofdeath)) {
        _id_9824258C4E398DAA = vehicle._id_AAB9695C92B0ED96[tagname]._id_92894EF28E2B8800 - damagedata.damage;
        vehicle._id_AAB9695C92B0ED96[tagname]._id_92894EF28E2B8800 = max(0, _id_9824258C4E398DAA);
      } else {
        damage = max(0, damagedata.damage - _id_C9F618F05861C2C5(ref, tagname));
        _id_F943483E687A2247 = max(0, vehicle._id_AAB9695C92B0ED96[tagname]._id_A776F097EB36E500 - damage);
        vehicle._id_AAB9695C92B0ED96[tagname]._id_A776F097EB36E500 = _id_F943483E687A2247;
      }

      if(_id_853C0063F08B55E1(vehicle._id_AAB9695C92B0ED96[tagname])) {
        _id_77DB32AA48A42A76(vehicle, tagname, damagedata);
        continue;
      }

      _id_CF8EAF8BC98090A6 = _id_DDE06C2157EC8895(ref, tagname);

      if(isDefined(_id_CF8EAF8BC98090A6))
        vehicle thread[[_id_CF8EAF8BC98090A6]](vehicle, damagedata);
    }
  }
}

_id_77DB32AA48A42A76(vehicle, tagname, damagedata, _id_AA2660B54E981080) {
  _id_B3D6CABF18E8CAF1 = _id_82CAD97B4499E421(vehicle, tagname, _id_AA2660B54E981080);
  vehicle setscriptablepartstate(tagname, _id_B3D6CABF18E8CAF1);
  _id_B4FCCC158C681073 = _id_BAD6C0E32FF1E092(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD(), tagname);
  _id_BAFA22FCDEFFF511 = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD()).damage._id_AAB9695C92B0ED96[tagname];

  if(isDefined(_id_BAFA22FCDEFFF511) && isDefined(_id_BAFA22FCDEFFF511._id_7CBFFE9DE982BCAD)) {
    if(!isDefined(vehicle._id_F2B4D0E8470F108B))
      vehicle._id_F2B4D0E8470F108B = [];

    vehicle._id_F2B4D0E8470F108B[tagname] = _id_BAFA22FCDEFFF511;
  }

  if(isDefined(_id_BAFA22FCDEFFF511) && isDefined(_id_BAFA22FCDEFFF511._id_9EB2AF3A3212B936))
    vehicle scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("pmc_missions", "onShatterWindow", damagedata);

  if(isDefined(_id_BAFA22FCDEFFF511) && isDefined(_id_BAFA22FCDEFFF511._id_49CF4824F012BFEA)) {
    if(!isDefined(vehicle._id_41E6777F1FA66044))
      vehicle._id_41E6777F1FA66044 = [];

    vehicle._id_41E6777F1FA66044[_id_BAFA22FCDEFFF511._id_49CF4824F012BFEA] = 1;

    if(vehicle _id_452936099DCD1B94(_id_BAFA22FCDEFFF511._id_49CF4824F012BFEA))
      vehicle _id_14219D4C7D83499F(_id_BAFA22FCDEFFF511._id_49CF4824F012BFEA);

    _id_F85572CD5F6117C6 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(vehicle, _id_BAFA22FCDEFFF511._id_49CF4824F012BFEA);

    if(isDefined(_id_F85572CD5F6117C6)) {
      _id_F85572CD5F6117C6 _id_3B64EB40368C1450::set("vehicle_occupant", "vehicle_lean_out", 0);
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setcurrentseat(vehicle, _id_BAFA22FCDEFFF511._id_49CF4824F012BFEA, _id_F85572CD5F6117C6);
    }
  }

  if(isDefined(_id_BAFA22FCDEFFF511) && istrue(_id_BAFA22FCDEFFF511._id_EA596CAE0D362D35) && isDefined(vehicle._id_B31F13A4E30B5AA5))
    vehicle._id_B31F13A4E30B5AA5[tagname] = undefined;

  if(isDefined(vehicle._id_AAB9695C92B0ED96[tagname]._id_673C6895D1418E1C)) {
    foreach(_id_E314A4412AFF5E4A in vehicle._id_AAB9695C92B0ED96[tagname]._id_673C6895D1418E1C) {
      if(isDefined(_id_E314A4412AFF5E4A) && istrue(_id_E314A4412AFF5E4A.iscrossbowbolt))
        _id_E314A4412AFF5E4A scripts\cp_mp\crossbow::boltunlink();
    }
  }

  if(isDefined(_id_B4FCCC158C681073))
    vehicle thread[[_id_B4FCCC158C681073]](vehicle, damagedata);
}

_id_B9D5A379EB1AEFC7(_id_199B7EB356C9D5A9) {
  return !isDefined(self) || !isDefined(self._id_41E6777F1FA66044) || !istrue(self._id_41E6777F1FA66044[_id_199B7EB356C9D5A9]);
}

_id_EC4B6F058D183338(vehicle, damagedata) {
  if(isDefined(vehicle._id_AAB9695C92B0ED96)) {
    foreach(tagname, data in vehicle._id_AAB9695C92B0ED96) {
      if(!_id_853C0063F08B55E1(data))
        _id_77DB32AA48A42A76(vehicle, tagname, damagedata);
    }
  }
}

_id_19953FF235374847(vehicle) {
  data = vehicle_damage_getleveldataforvehicle(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());
  tags = undefined;

  if(vehicle scripts\cp_mp\vehicles\vehicle::_id_B7148A3BFC4DEFB2())
    tags = data._id_CCFDE1208EF2964B;
  else
    tags = data._id_9D70F02394C136DA;

  foreach(tag, data in tags)
  _id_963F1CB109B9C186(vehicle, tag);
}

_id_9542EAC6997B9060(vehicle) {
  if(isDefined(vehicle._id_AAB9695C92B0ED96)) {
    _id_BAFA22FCDEFFF511 = _id_2265B277A0DAD0F1(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());

    if(!isDefined(vehicle._id_6D29AD415AC001B3)) {
      _id_771800B6FB3A4C46 = [];

      foreach(tagname, data in vehicle._id_AAB9695C92B0ED96) {
        if(isDefined(_id_BAFA22FCDEFFF511[tagname]._id_9EB2AF3A3212B936))
          _id_771800B6FB3A4C46[tagname] = data;
      }

      vehicle._id_6D29AD415AC001B3 = scripts\engine\utility::array_randomize_objects(_id_771800B6FB3A4C46);
    }

    foreach(tagname, data in vehicle._id_6D29AD415AC001B3) {
      if(!_id_853C0063F08B55E1(data)) {
        data._id_A776F097EB36E500 = max(0, data._id_A776F097EB36E500 - randomintrange(50, 125));

        if(_id_853C0063F08B55E1(data)) {
          _id_77DB32AA48A42A76(vehicle, tagname);
          vehicle._id_6D29AD415AC001B3[tagname] = undefined;
        }

        break;
      }

      vehicle._id_6D29AD415AC001B3[tagname] = undefined;
    }
  }
}

_id_66AC97EBA6B35B4A(vehicle, tagname, damagedata) {
  _id_DA9F4CD603F44758 = _id_F7DF41D3AD15DCA8(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD(), tagname);
  vehicle setscriptablepartstate(_id_DA9F4CD603F44758, "hide");
  _id_B4FCCC158C681073 = _id_BAD6C0E32FF1E092(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD(), tagname);

  if(isDefined(_id_B4FCCC158C681073))
    vehicle thread[[_id_B4FCCC158C681073]](vehicle, damagedata);
}

_id_4B3EF3D76F7E39B6(vehicle, damagedata) {
  _id_7143B00F866EF1EC(vehicle, 0, damagedata);
}

_id_D4C899AFE6CBF533(vehicle, damagedata) {
  _id_7143B00F866EF1EC(vehicle, 1, damagedata);
}

_id_1C35D2BEE2C14D7B(vehicle, damagedata) {
  _id_7143B00F866EF1EC(vehicle, 2, damagedata);
}

_id_2E20B5A5D4F70228(vehicle, damagedata) {
  _id_7143B00F866EF1EC(vehicle, 3, damagedata);
}

_id_79B9F63570444468(vehicle, damagedata) {
  _id_7143B00F866EF1EC(vehicle, 4, damagedata);
}

_id_4C7A8D0B6C6C16CD(vehicle, damagedata) {
  _id_7143B00F866EF1EC(vehicle, 5, damagedata);
}

_id_1CBE55C0515820B5(vehicle, damagedata) {
  _id_7143B00F866EF1EC(vehicle, 6, damagedata);
}

_id_6469EA91038491E2(vehicle, damagedata) {
  _id_7143B00F866EF1EC(vehicle, 7, damagedata);
}

_id_7143B00F866EF1EC(vehicle, _id_8E0F089D34CCBF55, damagedata) {
  if(vehicle _meth_76FA53E72547FF02())
    vehicle _meth_792B01BD9710F266(_id_8E0F089D34CCBF55);

  if(!isDefined(vehicle._id_58053EABD77A8C48))
    vehicle._id_58053EABD77A8C48 = 0;

  vehicle._id_58053EABD77A8C48 = vehicle._id_58053EABD77A8C48 | 1 << _id_8E0F089D34CCBF55;
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::_id_0EFA75AA7F0A1289(self, 0);

  if(isDefined(occupants)) {
    foreach(_id_F85572CD5F6117C6 in occupants)
    _id_EAE2223216B7712C(vehicle, _id_F85572CD5F6117C6);
  }

  tagname = undefined;

  if(isDefined(damagedata) && isDefined(damagedata.partname) && isstring(damagedata.partname) && damagedata.partname != "")
    tagname = damagedata.partname;
  else if(isDefined(damagedata) && isDefined(damagedata._id_799F234362ADB813) && isstring(damagedata._id_799F234362ADB813) && damagedata._id_799F234362ADB813 != "")
    tagname = damagedata._id_799F234362ADB813;

  if(isDefined(vehicle) && isDefined(vehicle.origin) && isDefined(tagname) && vehicle vehicle_isphysveh()) {
    data = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());
    speed = vehicle vehicle_getspeed();
    maxspeed = vehicle vehicle_gettopspeedforward();
    _id_F8048727716242B0 = scripts\engine\math::normalize_value(0, maxspeed / 2, speed);
    _id_F8048727716242B0 = _id_F8048727716242B0 * 0.8 + 0.2;
    _id_F8048727716242B0 = _id_F8048727716242B0 * data.damage._id_96F121D1EDFDB0CB;
    self _meth_E0201404A8B6F664(vehicle.origin - vehicle gettagorigin(tagname) + (0, 0, 300), int(255 * _id_F8048727716242B0), 1);
  }

  if(!vehicle scripts\cp_mp\vehicles\vehicle::_id_B7148A3BFC4DEFB2() && isDefined(damagedata) && isDefined(damagedata.attacker) && isPlayer(damagedata.attacker)) {
    isenemy = scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer(vehicle, damagedata.attacker);
    damagedata.givepointsandxp = isenemy;
    damagedata.attacker vehicle_damage_givescoreandxpatframeend("stat_5DB50BF1147F0F52", undefined, damagedata, vehicle);
    vehicle scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("pmc_missions", "onPopTire", damagedata.attacker, isenemy);
  }
}

_id_79A4D42EF833438A() {
  scripts\engine\scriptable::scriptable_addusedcallback(::_id_4B8D35D7AF7FD960);
}

_id_4B8D35D7AF7FD960(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(_id_CC38472E36BE1B61) || !isDefined(instance) || !isDefined(instance.entity) || !instance.entity scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    return;
  }
  if(_id_CC38472E36BE1B61 == "row1_left" || _id_CC38472E36BE1B61 == "row1_right" || _id_CC38472E36BE1B61 == "row2_left" || _id_CC38472E36BE1B61 == "row2_right" || _id_CC38472E36BE1B61 == "row3_left" || _id_CC38472E36BE1B61 == "row3_right" || _id_CC38472E36BE1B61 == "row4_left" || _id_CC38472E36BE1B61 == "row4_right")
    _id_000770F9F7300665(instance.entity, instance, part, _id_CC38472E36BE1B61, player, 0);
}

_id_E6F68A61BFFC259A(vehicle) {
  if(isDefined(vehicle._id_F2B4D0E8470F108B)) {
    foreach(part, data in vehicle._id_F2B4D0E8470F108B) {
      _id_000770F9F7300665(vehicle, vehicle, part, data._id_7CBFFE9DE982BCAD, undefined, 1);
      break;
    }
  }
}

_id_09AE605ED3DC3BD1(vehicle) {
  if(isDefined(vehicle._id_F2B4D0E8470F108B)) {
    foreach(part, data in vehicle._id_F2B4D0E8470F108B)
    vehicle thread _id_000770F9F7300665(vehicle, vehicle, part, data._id_7CBFFE9DE982BCAD, undefined, 1);
  }
}

_id_000770F9F7300665(vehicle, scriptable, part, _id_13223604B8FCEA0C, player, _id_2B5043846177FBC9) {
  vehicle endon("death");

  if(isDefined(player))
    player thread _id_3BDE2944D834B090();

  scriptable setscriptablepartstate(part, "repaired");
  wait 0.1;
  _id_8E0F089D34CCBF55 = _id_948C6C379E1A9B52(_id_13223604B8FCEA0C);
  vehicle _meth_22A4A7E20BFE463B(_id_8E0F089D34CCBF55);

  if(isDefined(vehicle._id_F2B4D0E8470F108B) && isDefined(vehicle._id_F2B4D0E8470F108B[part])) {
    vehicle._id_AAB9695C92B0ED96[part]._id_A776F097EB36E500 = vehicle._id_F2B4D0E8470F108B[part]._id_A776F097EB36E500;
    vehicle._id_AAB9695C92B0ED96[part]._id_92894EF28E2B8800 = vehicle._id_F2B4D0E8470F108B[part]._id_92894EF28E2B8800;
  }

  if(!isDefined(vehicle._id_58053EABD77A8C48))
    vehicle._id_58053EABD77A8C48 = 0;

  vehicle._id_58053EABD77A8C48 = vehicle._id_58053EABD77A8C48 &~(1 << _id_8E0F089D34CCBF55);
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::_id_0EFA75AA7F0A1289(vehicle, 0);

  if(isDefined(occupants)) {
    foreach(_id_F85572CD5F6117C6 in occupants)
    _id_EAE2223216B7712C(vehicle, _id_F85572CD5F6117C6);
  }

  vehicle._id_F2B4D0E8470F108B[part] = undefined;

  if(vehicle._id_F2B4D0E8470F108B.size == 0)
    vehicle._id_F2B4D0E8470F108B = undefined;

  _id_C3DA7BB5F5499152(vehicle, part, _id_2B5043846177FBC9);
}

_id_3BDE2944D834B090() {
  self endon("death_or_disconnect");
  _id_A7408DBFED49F3F9 = makeweapon("iw8_ges_plyr_loot_pickup");
  self giveandfireoffhand(_id_A7408DBFED49F3F9);
  wait 1.17;

  if(self hasweapon(_id_A7408DBFED49F3F9))
    self takeweapon(_id_A7408DBFED49F3F9);
}

_id_C3DA7BB5F5499152(vehicle, part, _id_2B5043846177FBC9) {
  _id_5E2E7EC5E4FD55A0 = vehicle gettagorigin(part);
  _id_313FE1D8B82F6DF7 = "veh_repair_tire";

  if(_id_2B5043846177FBC9)
    _id_313FE1D8B82F6DF7 = "veh_repair_tire_at_station";

  playsoundatpos(_id_5E2E7EC5E4FD55A0, _id_313FE1D8B82F6DF7);
}

_id_948C6C379E1A9B52(_id_13223604B8FCEA0C) {
  switch (_id_13223604B8FCEA0C) {
    case "row1_left":
      return 0;
    case "row1_right":
      return 1;
    case "row2_left":
      return 2;
    case "row2_right":
      return 3;
    case "row3_left":
      return 4;
    case "row3_right":
      return 5;
    case "row4_left":
      return 6;
    case "row4_right":
      return 7;
    default:
  }
}

_id_EAE2223216B7712C(vehicle, player) {
  if(!isDefined(vehicle._id_58053EABD77A8C48))
    vehicle._id_58053EABD77A8C48 = 0;

  player setclientomnvar("ui_veh_flat_tire_mask", vehicle._id_58053EABD77A8C48);
}

_id_B9D933A7B78A67AD(data) {
  if(!isDefined(data.inflictor) || !isagent(data.inflictor))
    return data.damage;

  ref = scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();

  if(!isDefined(ref) || !scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C(ref))
    return data.damage;

  vehicledata = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(ref);

  if(!isDefined(vehicledata) || !isDefined(vehicledata.damage) || !isDefined(vehicledata.damage._id_7F6AE564D3463C3C))
    return data.damage;

  return data.damage * vehicledata.damage._id_7F6AE564D3463C3C;
}

_id_C5A55810ED63C87D(data) {
  if(!isDefined(data.point) || !isDefined(data.objweapon) || !isDefined(data.objweapon.damageradius))
    return 1;

  ref = scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();

  if(!isDefined(ref) || !scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C(ref))
    return 1;

  vehicledata = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(ref);

  if(!isDefined(vehicledata) || !isDefined(vehicledata.damage) || !isDefined(vehicledata.damage._id_C0D2F358F2E54245))
    return 1;

  radius = data.objweapon.damageradius;
  _id_DC8625458EE5ED14 = vehicledata.damage._id_C0D2F358F2E54245;
  _id_EA3B9640A6AD3C8E = _func_D559A384B9C4E7D9(data.point, self.origin, self.angles);
  return _id_EA3B9640A6AD3C8E[0] > (_id_DC8625458EE5ED14.back + radius) * -1 && _id_EA3B9640A6AD3C8E[0] < _id_DC8625458EE5ED14._id_CFF021654A47B60C + radius && _id_EA3B9640A6AD3C8E[1] > (_id_DC8625458EE5ED14.left + radius) * -1 && _id_EA3B9640A6AD3C8E[1] < _id_DC8625458EE5ED14.right + radius && _id_EA3B9640A6AD3C8E[2] > (_id_DC8625458EE5ED14._id_8A925332BA34F25E + radius) * -1 && _id_EA3B9640A6AD3C8E[2] < _id_DC8625458EE5ED14.top + radius;
}

vehicle_damage_init() {
  _id_962A30A9BB8C0F09 = spawnStruct();
  level.vehicle.damage = _id_962A30A9BB8C0F09;
  level._id_EC75CA2494D74DAB = getdvarint("dvar_4421544B585F6BE5", scripts\common\utility::ismp()) == 1;
  level._id_ECA89E600E05E79E = getdvarint("dvar_6FC86A5E3CEDBD94", 0) == 1;
  _id_962A30A9BB8C0F09.vehicledata = [];
  _id_962A30A9BB8C0F09.heavystatehealthadd = getdvarint("dvar_A3B9B8945213C089", 350);
  _id_962A30A9BB8C0F09.mediumstatehealthratio = getdvarfloat("dvar_4217D1E671E33953", 0.5);
  _id_962A30A9BB8C0F09.burndowntime = getdvarfloat("dvar_1021D59D6F0D99A0", 8);
  vehicle_damage_loadtable();
  vehicle_damage_initdebug();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "init")]]();

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    vehicle_damage_inithitdamage_br();
  else
    vehicle_damage_inithitdamage();

  vehicle_damage_initmoddamage();
  _id_79A4D42EF833438A();
}

vehicle_damage_loadtable() {
  _id_962A30A9BB8C0F09 = vehicle_damage_getleveldata();
  table = spawnStruct();
  _id_962A30A9BB8C0F09.table = table;
  table.modsforclass = [];
  table.modsforvehicle = [];
  table.hitsperattackforclass = [];
  table.hitsperattackforvehicle = [];
  table.skipburndownforclass = [];
  table.skipburndownforvehicle = [];
  _id_B271A3D0C941CD5C = [];
  _id_B271A3D0C941CD5C["class"] = [];
  _id_B271A3D0C941CD5C["vehicle"] = [];
  _id_870D49F076632BF2 = [];
  _id_870D49F076632BF2["weaponMod"] = [];
  _id_870D49F076632BF2["weaponHPA"] = [];
  _id_870D49F076632BF2["weaponSkipBurnDown"] = [];

  if(getDvar("dvar_6EDEBC535543F0BC", "") != "")
    table = getDvar("dvar_6EDEBC535543F0BC", "");
  else
    table = "mp_cp/vehicleDamageTable.csv";

  _id_206C9737E935CCE1 = undefined;
  _id_24C416453B6F670C = tablelookupgetnumcols(table);

  for(_id_6722B84D6C5368B7 = 1; _id_6722B84D6C5368B7 < _id_24C416453B6F670C; _id_6722B84D6C5368B7++) {
    _id_B41F483278C9B1A0 = tablelookupbyrow(table, 0, _id_6722B84D6C5368B7);

    if(isDefined(_id_B41F483278C9B1A0) && _id_B41F483278C9B1A0 != "") {
      if(getsubstr(_id_B41F483278C9B1A0, 0, 1) == "*") {
        _id_206C9737E935CCE1 = getsubstr(_id_B41F483278C9B1A0, 1, _id_B41F483278C9B1A0.size);
        continue;
      }

      if(isDefined(_id_B271A3D0C941CD5C[_id_206C9737E935CCE1]))
        _id_B271A3D0C941CD5C[_id_206C9737E935CCE1][_id_B41F483278C9B1A0] = _id_6722B84D6C5368B7;
    }
  }

  _id_E3CEEC859E0DF323 = undefined;
  _id_8D626A4CCCA80F2D = 0;
  _id_977F24E61599CBBA = tablelookupgetnumrows(table);

  for(_id_8D626A4CCCA80F2D = 0; _id_8D626A4CCCA80F2D < _id_977F24E61599CBBA; _id_8D626A4CCCA80F2D++) {
    _id_929A919F782B1C96 = tablelookupbyrow(table, _id_8D626A4CCCA80F2D, 1);

    if(isDefined(_id_929A919F782B1C96) && _id_929A919F782B1C96 != "") {
      if(getsubstr(_id_929A919F782B1C96, 0, 1) == "*") {
        _id_E3CEEC859E0DF323 = getsubstr(_id_929A919F782B1C96, 1, _id_929A919F782B1C96.size);
        continue;
      }

      if(isDefined(_id_870D49F076632BF2[_id_E3CEEC859E0DF323]))
        _id_870D49F076632BF2[_id_E3CEEC859E0DF323][_id_929A919F782B1C96] = _id_8D626A4CCCA80F2D;
    }
  }

  foreach(_id_E3CEEC859E0DF323, _id_247C537DA346FFDE in _id_870D49F076632BF2) {
    foreach(_id_929A919F782B1C96, _id_09DD5D9E57E7E36D in _id_247C537DA346FFDE) {
      foreach(_id_206C9737E935CCE1, _id_2E078AF567792360 in _id_B271A3D0C941CD5C) {
        foreach(_id_B41F483278C9B1A0, _id_E78EC0335B297403 in _id_2E078AF567792360) {
          _id_F9430C437671AA54 = tablelookup(table, 0, _id_09DD5D9E57E7E36D, _id_E78EC0335B297403);

          if(isDefined(_id_F9430C437671AA54) && _id_F9430C437671AA54 != "")
            vehicle_damage_loadtablecell(_id_F9430C437671AA54, _id_929A919F782B1C96, _id_E3CEEC859E0DF323, _id_B41F483278C9B1A0, _id_206C9737E935CCE1);
        }
      }
    }
  }
}

vehicle_damage_loadtablecell(_id_F9430C437671AA54, _id_929A919F782B1C96, _id_E3CEEC859E0DF323, _id_B41F483278C9B1A0, _id_206C9737E935CCE1) {
  _id_962A30A9BB8C0F09 = vehicle_damage_getleveldata();
  table = _id_962A30A9BB8C0F09.table;

  if(_id_E3CEEC859E0DF323 == "weaponMod") {
    _id_2E70C59B43CA1E56 = float(_id_F9430C437671AA54);

    if(_id_206C9737E935CCE1 == "class") {
      if(!isDefined(table.modsforclass[_id_B41F483278C9B1A0]))
        table.modsforclass[_id_B41F483278C9B1A0] = [];

      table.modsforclass[_id_B41F483278C9B1A0][_id_929A919F782B1C96] = _id_2E70C59B43CA1E56;
    } else if(_id_206C9737E935CCE1 == "vehicle") {
      if(!isDefined(table.modsforvehicle[_id_B41F483278C9B1A0]))
        table.modsforvehicle[_id_B41F483278C9B1A0] = [];

      table.modsforvehicle[_id_B41F483278C9B1A0][_id_929A919F782B1C96] = _id_2E70C59B43CA1E56;
    }
  }

  if(_id_E3CEEC859E0DF323 == "weaponHPA") {
    _id_2E70C59B43CA1E56 = int(_id_F9430C437671AA54);

    if(_id_206C9737E935CCE1 == "class") {
      if(!isDefined(table.hitsperattackforclass[_id_B41F483278C9B1A0]))
        table.hitsperattackforclass[_id_B41F483278C9B1A0] = [];

      table.hitsperattackforclass[_id_B41F483278C9B1A0][_id_929A919F782B1C96] = _id_2E70C59B43CA1E56;
    } else if(_id_206C9737E935CCE1 == "vehicle") {
      if(!isDefined(table.hitsperattackforvehicle[_id_B41F483278C9B1A0]))
        table.hitsperattackforvehicle[_id_B41F483278C9B1A0] = [];

      table.hitsperattackforvehicle[_id_B41F483278C9B1A0][_id_929A919F782B1C96] = _id_2E70C59B43CA1E56;
    }
  }

  if(_id_E3CEEC859E0DF323 == "weaponSkipBurnDown") {
    _id_2E70C59B43CA1E56 = int(_id_F9430C437671AA54) != 0;

    if(_id_206C9737E935CCE1 == "class") {
      if(!isDefined(table.skipburndownforclass[_id_B41F483278C9B1A0]))
        table.skipburndownforclass[_id_B41F483278C9B1A0] = [];

      table.skipburndownforclass[_id_B41F483278C9B1A0][_id_929A919F782B1C96] = _id_2E70C59B43CA1E56;
    } else if(_id_206C9737E935CCE1 == "vehicle") {
      if(!isDefined(table.skipburndownforvehicle[_id_B41F483278C9B1A0]))
        table.skipburndownforvehicle[_id_B41F483278C9B1A0] = [];

      table.skipburndownforvehicle[_id_B41F483278C9B1A0][_id_929A919F782B1C96] = _id_2E70C59B43CA1E56;
    }
  }
}

vehicle_damage_applytabletovehicle(_id_7731ADEF63E19B0C, _id_6ECB77FD1F27C667) {
  _id_962A30A9BB8C0F09 = vehicle_damage_getleveldata();
  table = _id_962A30A9BB8C0F09.table;
  _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(_id_7731ADEF63E19B0C, undefined, _id_6ECB77FD1F27C667);

  if(!isDefined(_id_E2818AD39A3341B4)) {
    return;
  }
  class = _id_E2818AD39A3341B4.class;

  if(isDefined(table.modsforclass[class])) {
    foreach(weaponclass, mod in table.modsforclass[class])
    vehicle_damage_setweaponclassmoddamageforvehicle(weaponclass, mod, 0, _id_7731ADEF63E19B0C);
  }

  if(isDefined(table.modsforvehicle[_id_7731ADEF63E19B0C])) {
    foreach(weaponclass, mod in table.modsforvehicle[_id_7731ADEF63E19B0C])
    vehicle_damage_setweaponclassmoddamageforvehicle(weaponclass, mod, 0, _id_7731ADEF63E19B0C);
  }

  if(isDefined(table.hitsperattackforclass[class])) {
    foreach(weaponref, hitsperattack in table.hitsperattackforclass[class]) {
      vehicle_damage_setweaponhitdamagedataforvehicle(weaponref, hitsperattack, _id_7731ADEF63E19B0C);
      vehicle_damage_setvehiclehitdamagedataforweapon(_id_7731ADEF63E19B0C, 100, weaponref);
    }
  }

  if(isDefined(table.hitsperattackforvehicle[_id_7731ADEF63E19B0C])) {
    foreach(weaponref, hitsperattack in table.hitsperattackforvehicle[_id_7731ADEF63E19B0C]) {
      vehicle_damage_setweaponhitdamagedataforvehicle(weaponref, hitsperattack, _id_7731ADEF63E19B0C);
      vehicle_damage_setvehiclehitdamagedataforweapon(_id_7731ADEF63E19B0C, 100, weaponref);
    }
  }
}

vehicle_damage_inithitdamage() {
  vehicle_damage_setweaponhitdamagedata("iw8_la_gromeo_mp", 5);
  vehicle_damage_setweaponhitdamagedata("iw8_la_kgolf_mp", 5);
  vehicle_damage_setweaponhitdamagedata("iw8_la_rpapa7_mp", 5);
  vehicle_damage_setweaponhitdamagedata("iw8_la_juliet_mp", 6);
  vehicle_damage_setweaponhitdamagedata("iw8_la_gromeoks_mp", 4);
  vehicle_damage_setweaponhitdamagedata("iw8_la_mike32_mp", 3);
  vehicle_damage_setweaponhitdamagedata("iw8_ar_mike4_mp", 3);
  vehicle_damage_setweaponhitdamagedata("iw8_ar_akilo47_mp", 3);
  vehicle_damage_setweaponhitdamagedata("iw9_la_gromeo_mp", 5);
  vehicle_damage_setweaponhitdamagedata("iw9_la_juliet_mp", 6);
  vehicle_damage_setweaponhitdamagedata("frag_grenade_mp", 3);
  vehicle_damage_setweaponhitdamagedata("t10_frag_grenade_mp", 3);
  vehicle_damage_setweaponhitdamagedata("semtex_mp", 3);
  vehicle_damage_setweaponhitdamagedata("c4_mp", 3);
  vehicle_damage_setweaponhitdamagedata("at_mine_ap_mp", 3);
  vehicle_damage_setweaponhitdamagedata("at_mine_mp", 3);
  vehicle_damage_setweaponhitdamagedata("claymore_mp", 3);
  vehicle_damage_setweaponhitdamagedata("molotov_mp", 2);
  vehicle_damage_setweaponhitdamagedata("thermite_mp", 1);
  vehicle_damage_setweaponhitdamagedata("thermite_av_mp", 1);
  vehicle_damage_setweaponhitdamagedata("thermite_bolt_mp", 1);
  vehicle_damage_setweaponhitdamagedata("semtex_bolt_mp", 4);
  vehicle_damage_setweaponhitdamagedata("thermite_xmike109_mp", 0.5);
  vehicle_damage_setweaponhitdamagedata("semtex_xmike109_mp", 2);
  vehicle_damage_setweaponhitdamagedata("chopper_gunner_proj_mp", 3);
  vehicle_damage_setweaponhitdamagedata("toma_proj_mp", 3);
  vehicle_damage_setweaponhitdamagedata("cruise_proj_mp", 15);
  vehicle_damage_setweaponhitdamagedata("artillery_mp", 3);
  vehicle_damage_setweaponhitdamagedata("nuke_mp", 15);
  vehicle_damage_setweaponhitdamagedata("gunship_hellfire_mp", 15);
  vehicle_damage_setweaponhitdamagedata("gunship_105mm_mp", 15);
  vehicle_damage_setweaponhitdamagedata("gunship_40mm_mp", 5);
  vehicle_damage_setweaponhitdamagedata("gunship_25mm_mp", 1);
  vehicle_damage_setweaponhitdamagedata("hover_jet_proj_mp", 3);
  vehicle_damage_setweaponhitdamagedata("chopper_gunner_turret_dmz", 40);
  vehicle_damage_setweaponhitdamagedata("emp_drone_non_player_mp", 3);
  vehicle_damage_setweaponhitdamagedata("emp_drone_non_player_direct_mp", 5);
}

vehicle_damage_inithitdamage_br() {
  vehicle_damage_setweaponhitdamagedata("iw8_la_gromeo_mp", 10);
  vehicle_damage_setweaponhitdamagedata("iw8_la_kgolf_mp", 10);
  vehicle_damage_setweaponhitdamagedata("iw8_la_rpapa7_mp", 10);
  vehicle_damage_setweaponhitdamagedata("iw8_la_juliet_mp", 20);
  vehicle_damage_setweaponhitdamagedata("iw8_la_gromeoks_mp", 10);
  vehicle_damage_setweaponhitdamagedata("iw8_la_mike32_mp", 6);
  vehicle_damage_setweaponhitdamagedata("iw8_ar_mike4_mp", 6);
  vehicle_damage_setweaponhitdamagedata("iw8_ar_akilo47_mp", 6);
  vehicle_damage_setweaponhitdamagedata("iw9_la_gromeo_mp", 10);
  vehicle_damage_setweaponhitdamagedata("iw9_la_juliet_mp", 20);
  vehicle_damage_setweaponhitdamagedata("c4_mp", 13);
  vehicle_damage_setweaponhitdamagedata("semtex_mp", 4);
  vehicle_damage_setweaponhitdamagedata("frag_grenade_mp", 4);
  vehicle_damage_setweaponhitdamagedata("t10_frag_grenade_mp", 4);
  vehicle_damage_setweaponhitdamagedata("pop_rocket_mp", 4);
  vehicle_damage_setweaponhitdamagedata("molotov_mp", 2);
  vehicle_damage_setweaponhitdamagedata("at_mine_ap_mp", 5);
  vehicle_damage_setweaponhitdamagedata("at_mine_mp", 13);
  vehicle_damage_setweaponhitdamagedata("thermite_mp", 1);
  vehicle_damage_setweaponhitdamagedata("thermite_av_mp", 1);
  vehicle_damage_setweaponhitdamagedata("emp_grenade_mp", 4);
  vehicle_damage_setweaponhitdamagedata("claymore_mp", 13);
  vehicle_damage_setweaponhitdamagedata("thermite_bolt_mp", 1);
  vehicle_damage_setweaponhitdamagedata("semtex_bolt_mp", 4);
  vehicle_damage_setweaponhitdamagedata("thermite_xmike109_mp", 0.5);
  vehicle_damage_setweaponhitdamagedata("semtex_xmike109_mp", 2);
  vehicle_damage_setweaponhitdamagedata("toma_proj_mp", 12);
  vehicle_damage_setweaponhitdamagedata("cruise_proj_mp", 15);
  vehicle_damage_setweaponhitdamagedata("artillery_mp", 10);
  vehicle_damage_setweaponhitdamagedata("nuke_mp", 20);
  vehicle_damage_setweaponhitdamagedata("gunship_hellfire_mp", 15);
  vehicle_damage_setweaponhitdamagedata("gunship_105mm_mp", 15);
  vehicle_damage_setweaponhitdamagedata("gunship_40mm_mp", 5);
  vehicle_damage_setweaponhitdamagedata("gunship_25mm_mp", 1);
  vehicle_damage_setweaponhitdamagedata("hover_jet_proj_mp", 3);
  vehicle_damage_setweaponhitdamagedata("emp_drone_non_player_mp", 3);
  vehicle_damage_setweaponhitdamagedata("emp_drone_non_player_direct_mp", 5);
}

vehicle_damage_initmoddamage() {
  vehicle_damage_setperkmoddamage("specialty_armorpiercing", 0.25, 0);
  vehicle_damage_setperkmoddamage("specialty_armorpiercingks", 0.75, 0);
  vehicle_damage_setperkmoddamage("specialty_incendiary", 0.55, 0);
  vehicle_damage_setperkmoddamage("specialty_explosivebullet", 0.75, 0);
}

vehicle_damage_getleveldata() {
  return level.vehicle.damage;
}

vehicle_damage_isselfdamage(vehicle, data) {
  if(isDefined(data.inflictor)) {
    if(data.inflictor == vehicle)
      return 1;

    turrets = scripts\cp_mp\vehicles\vehicle::vehicle_getturrets(vehicle);

    foreach(turret in turrets) {
      if(data.inflictor == turret)
        return 1;
    }

    if(data.inflictor.classname == "rocket" && isDefined(data.inflictor.vehicle) && data.inflictor.vehicle == vehicle)
      return 1;
  }

  return 0;
}

vehicle_damage_enableownerdamage(vehicle) {
  vehicle.ownerdamageenabled = 1;
}

vehicle_damage_isownerdamageenabled(vehicle) {
  return istrue(vehicle.ownerdamageenabled);
}

vehicle_damage_logevent(vehicle, data) {
  if(!isDefined(vehicle.damageevents))
    vehicle.damageevents = [];

  vehicle.damageevents[vehicle.damageevents.size] = data;

  if(isDefined(data.attacker) && isDefined(data.attacker.overridefieldupgrade1) && isDefined(data.attacker.super) && data.attacker.overridefieldupgrade1 == "super_suppression_rounds") {
    if(isDefined(data.attacker.super._id_DB8424389DCBBE9B))
      data.attacker.super._id_DB8424389DCBBE9B++;
    else
      data.attacker.super._id_DB8424389DCBBE9B = 1;
  }

  thread vehicle_damage_cleareventlogatframeend(vehicle);
}

vehicle_damage_cleareventlog(vehicle) {
  vehicle notify("vehicle_damage_clearEventLog");
  vehicle.damageevents = undefined;
}

vehicle_damage_cleareventlogatframeend(vehicle) {
  vehicle endon("death");
  vehicle endon("vehicle_damage_clearEventLog");
  vehicle notify("vehicle_damage_clearEventLogAtFrameEnd");
  vehicle endon("vehicle_damage_clearEventLogAtFrameEnd");
  waittillframeend;
  thread vehicle_damage_cleareventlog(vehicle);
}

vehicle_damage_referevent(vehicle, turret, data) {
  if(!isDefined(data.meansofdeath))
    return 0;

  if(!isexplosivedamagemod(data.meansofdeath))
    return 0;

  if(!isDefined(data.eventid))
    return 0;

  if(isDefined(vehicle.damageevents)) {
    foreach(_id_84DCD1AB2AE1DFFA in vehicle.damageevents) {
      if(_id_84DCD1AB2AE1DFFA.eventid == data.eventid)
        return 0;
    }
  }

  if(!isDefined(data.inflictor))
    data.inflictor = undefined;

  vehicle endon("death");
  vehicle endon("vehicle_damage_clearEventLog");
  vehicle dodamage(data.damage, data.point, data.attacker, data.inflictor, data.meansofdeath, data.objweapon, data.hitlocation);
  vehicle_damage_logevent(vehicle, data);
}

vehicle_damage_keepturretalive(vehicle) {
  self endon("death");
  self endon("vehicle_damage_keepTurretAliveEnd");
  self setCanDamage(1);
  self.health = 2147483647;
  self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor, eventid);
  data = scripts\cp_mp\utility\damage_utility::packdamagedata(attacker, self, damage, objweapon, meansofdeath, inflictor, point, direction_vec, modelname, partname, tagname, idflags, eventid);
  vehicle_damage_referevent(vehicle, self, data);
  self.health = 2147483647;
}

vehicle_damage_keepturretaliveend(turret) {
  self notify("vehicle_damage_keepTurretAliveEnd");
  self setCanDamage(0);
}

vehicle_damage_visualwatchspeedchange(_id_CB322750051A892B, data) {
  self notify("vehicle_damage_visualStopWatchingSpeedChange");
  self endon("vehicle_damage_visualStopWatchingSpeedChange");
  _id_C4BA4A0BE2EF63F6 = undefined;

  while(isDefined(self)) {
    _id_8707D88B63F131D1 = undefined;
    speed = int(self vehicle_getspeed());
    canfly = istrue(scripts\cp_mp\vehicles\vehicle::vehiclecanfly());

    if(canfly && self vehicle_isonground())
      _id_8707D88B63F131D1 = 0;
    else if(!canfly && speed <= 3)
      _id_8707D88B63F131D1 = 0;
    else if(speed <= 25)
      _id_8707D88B63F131D1 = 1;
    else
      _id_8707D88B63F131D1 = 2;

    if(isDefined(_id_C4BA4A0BE2EF63F6) && _id_8707D88B63F131D1 != _id_C4BA4A0BE2EF63F6) {
      _id_D2E455D494F8D46E = vehicle_damage_getleveldatafordamagestate(scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD(), _id_CB322750051A892B);
      self thread[[_id_D2E455D494F8D46E.onentercallback]](_id_CB322750051A892B, data);
      return;
    }

    _id_C4BA4A0BE2EF63F6 = _id_8707D88B63F131D1;
    wait 0.1;
  }
}

vehicle_damage_visualstopwatchingspeedchange() {
  self notify("vehicle_damage_visualStopWatchingSpeedChange");
}

vehicle_damage_lightvisualcallback(data, _id_D7D8FAA73DE16FAF) {
  speed = int(self vehicle_getspeed());
  canfly = istrue(scripts\cp_mp\vehicles\vehicle::vehiclecanfly());

  if(canfly && self vehicle_isonground())
    self setscriptablepartstate("damageLight", "stopped", 1);
  else if(!canfly && speed <= 3)
    self setscriptablepartstate("damageLight", "stopped", 1);
  else if(speed <= 25)
    self setscriptablepartstate("damageLight", "lowSpeed", 1);
  else
    self setscriptablepartstate("damageLight", "highSpeed", 1);

  thread vehicle_damage_visualwatchspeedchange("light", data);
}

vehicle_damage_lightvisualclearcallback(data, _id_D7D8FAA73DE16FAF, _id_FCEF8D217A441961) {
  vehicle_damage_visualstopwatchingspeedchange();

  if(!self isscriptable()) {
    if(isDefined(self.vehiclename))
      ref = self.vehiclename;
    else
      ref = "undefined";

    if(isDefined(self.vehicletype))
      type = self.vehicletype;
    else
      type = "undefined";

    _id_F580DE06A1C1891C = "Vehicle is not a scriptable: ref: " + ref + " type: " + type == undefined;
    return;
  }

  if(!self getscriptablehaspart("damageLight")) {
    if(isDefined(self.vehiclename))
      ref = self.vehiclename;
    else
      ref = "undefined";

    if(isDefined(self.vehicletype))
      type = self.vehicletype;
    else
      type = "undefined";

    _id_F580DE06A1C1891C = "Vehicle does not have damageLight part: ref: " + ref + " type: " + type == undefined;
    return;
  }

  if(!self getscriptableparthasstate("damageLight", "off")) {
    if(isDefined(self.vehiclename))
      ref = self.vehiclename;
    else
      ref = "undefined";

    if(isDefined(self.vehicletype))
      type = self.vehicletype;
    else
      type = "undefined";

    _id_F580DE06A1C1891C = "Vehicle does not have part damageLight with state off: ref: " + ref + " type: " + type == undefined;
    return;
  }

  self setscriptablepartstate("damageLight", "off", 1);
}

vehicle_damage_mediumvisualcallback(data, _id_D7D8FAA73DE16FAF) {
  speed = int(self vehicle_getspeed());
  canfly = istrue(scripts\cp_mp\vehicles\vehicle::vehiclecanfly());

  if(canfly && self vehicle_isonground())
    self setscriptablepartstate("damageMedium", "stopped", 1);
  else if(!canfly && speed <= 3)
    self setscriptablepartstate("damageMedium", "stopped", 1);
  else if(speed <= 25)
    self setscriptablepartstate("damageMedium", "lowSpeed", 1);
  else
    self setscriptablepartstate("damageMedium", "highSpeed", 1);

  thread vehicle_damage_visualwatchspeedchange("medium", data);
}

vehicle_damage_mediumvisualclearcallback(data, _id_D7D8FAA73DE16FAF, _id_FCEF8D217A441961) {
  vehicle_damage_visualstopwatchingspeedchange();
  self setscriptablepartstate("damageMedium", "off", 1);
}

vehicle_damage_heavyvisualcallback(data, _id_D7D8FAA73DE16FAF) {
  speed = int(self vehicle_getspeed());
  canfly = istrue(scripts\cp_mp\vehicles\vehicle::vehiclecanfly());

  if(canfly && self vehicle_isonground())
    self setscriptablepartstate("damageHeavy", "stopped", 1);
  else if(!canfly && speed <= 3)
    self setscriptablepartstate("damageHeavy", "stopped", 1);
  else if(speed <= 25)
    self setscriptablepartstate("damageHeavy", "lowSpeed", 1);
  else
    self setscriptablepartstate("damageHeavy", "highSpeed", 1);

  thread vehicle_damage_visualwatchspeedchange("heavy", data);
}

vehicle_damage_heavyvisualclearcallback(data, _id_D7D8FAA73DE16FAF, _id_FCEF8D217A441961) {
  vehicle_damage_visualstopwatchingspeedchange();
  self setscriptablepartstate("damageHeavy", "off", 1);
}

vehicle_damage_enginevisualcallback(data, _id_D7D8FAA73DE16FAF) {
  self setscriptablepartstate("damageEngine", "explode", 1);

  if(!istrue(scripts\cp_mp\vehicles\vehicle::vehiclecanfly()))
    scripts\cp_mp\vehicles\vehicle_occupancy::_id_D0092C44C5588870();
}

vehicle_damage_enginevisualclearcallback(data, _id_D7D8FAA73DE16FAF, _id_FCEF8D217A441961) {
  self setscriptablepartstate("damageEngine", "off", 1);
}

vehicle_damage_getstate() {
  if(!isDefined(self.damagestateref))
    return "pristine";

  return self.damagestateref;
}

vehicle_damage_setstate(_id_CB322750051A892B, _id_1AE0AEB37C917298, data) {
  self notify("damage_state_change");
  ref = scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();

  if(_id_1AE0AEB37C917298 != "pristine") {
    _id_1F1B237868B2B611 = vehicle_damage_getleveldatafordamagestate(ref, _id_1AE0AEB37C917298);

    if(isDefined(_id_1F1B237868B2B611.onexitcallback))
      self thread[[_id_1F1B237868B2B611.onexitcallback]](_id_CB322750051A892B, data);
  }

  if(_id_CB322750051A892B != "pristine") {
    _id_1F1B237868B2B611 = vehicle_damage_getleveldatafordamagestate(ref, _id_CB322750051A892B);

    if(isDefined(_id_1F1B237868B2B611.onentercallback))
      self thread[[_id_1F1B237868B2B611.onentercallback]](_id_1AE0AEB37C917298, data);
  }

  self.damagestateref = _id_CB322750051A892B;
}

vehicle_damage_updatestate(data, _id_FA10797979C24226, _id_6ECB77FD1F27C667) {
  _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD(), undefined, _id_6ECB77FD1F27C667);

  if(!isDefined(_id_E2818AD39A3341B4)) {
    return;
  }
  self.lasttimedamaged = gettime();
  _id_E1D544CB065687F0(data, _id_FA10797979C24226, _id_6ECB77FD1F27C667);
}

_id_E1D544CB065687F0(data, _id_FA10797979C24226, _id_6ECB77FD1F27C667) {
  _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD(), undefined, _id_6ECB77FD1F27C667);
  _id_29F04596CC8CFFA5 = self.health;

  if(isDefined(data) && isDefined(data.damage))
    _id_29F04596CC8CFFA5 = _id_29F04596CC8CFFA5 - int(data.damage);

  _id_416ADCA164C6F319 = "pristine";
  _id_47073CF5D0921B2C = undefined;
  _id_AD8EC7E8A1D06338 = undefined;

  foreach(_id_CB322750051A892B, _id_47BDB61121B1EC92 in _id_E2818AD39A3341B4.damagestatedata) {
    if((!isDefined(_id_AD8EC7E8A1D06338) || _id_47BDB61121B1EC92.maxhealth < _id_AD8EC7E8A1D06338) && _id_29F04596CC8CFFA5 <= _id_47BDB61121B1EC92.maxhealth && (!scripts\cp_mp\vehicles\vehicle::_id_B7148A3BFC4DEFB2() || _id_CB322750051A892B != "light" && _id_CB322750051A892B != "medium")) {
      _id_416ADCA164C6F319 = _id_CB322750051A892B;
      _id_47073CF5D0921B2C = _id_47BDB61121B1EC92;
      _id_AD8EC7E8A1D06338 = _id_47BDB61121B1EC92.maxhealth;
    }
  }

  _id_1AE0AEB37C917298 = vehicle_damage_getstate();

  if(_id_416ADCA164C6F319 != _id_1AE0AEB37C917298) {
    if(!istrue(_id_FA10797979C24226)) {
      if(_id_416ADCA164C6F319 == "heavy" && (!isDefined(_id_1AE0AEB37C917298) || _id_1AE0AEB37C917298 != "heavy")) {
        if(!istrue(self.disableheavystatedamagefloor)) {
          _id_4E49623DC4538A67 = vehicle_damage_getheavystatemaxhealth(undefined, scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());

          if(isDefined(_id_4E49623DC4538A67)) {
            if(isDefined(data) && isDefined(data.damage) && data.damage != 0)
              self.health = int(max(self.health, _id_4E49623DC4538A67 + data.damage));
          }
        }
      }
    }

    vehicle_damage_setstate(_id_416ADCA164C6F319, _id_1AE0AEB37C917298, data);
  }
}

vehicle_damage_disablestatedamagefloor(_id_E3108E412AFB3811) {
  if(_id_E3108E412AFB3811)
    self.disableheavystatedamagefloor = 1;
  else
    self.disableheavystatedamagefloor = undefined;
}

vehicle_damage_onenterstatelight(_id_1AE0AEB37C917298, data) {
  vehicle_damage_lightvisualcallback(data, 1);
}

vehicle_damage_onexitstatelight(_id_56182E19D2F0094F, data) {
  vehicle_damage_lightvisualclearcallback(data, 1);
}

vehicle_damage_onenterstatemedium(_id_1AE0AEB37C917298, data) {
  vehicle_damage_mediumvisualcallback(data, 1);
}

vehicle_damage_onexitstatemedium(_id_56182E19D2F0094F, data) {
  vehicle_damage_mediumvisualclearcallback(data, 1);
}

vehicle_damage_onenterstateheavy(_id_1AE0AEB37C917298, data) {
  if(scripts\cp_mp\vehicles\vehicle::_id_B7148A3BFC4DEFB2())
    _id_D06474F0BC53709D(data);
  else {
    vehicle_damage_heavyvisualcallback(data, 1);
    vehicle_damage_enginevisualcallback(data, 1);
  }

  if(!isDefined(_id_1AE0AEB37C917298) || _id_1AE0AEB37C917298 != "heavy") {
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement(self, 0);

    if(_id_734926FCDBAD1FD4())
      vehicle_damage_onenterstateheavyscore(_id_1AE0AEB37C917298, data);

    thread vehicle_damage_beginburndown(data);
  }
}

vehicle_damage_onexitstateheavy(_id_56182E19D2F0094F, data) {
  if(scripts\cp_mp\vehicles\vehicle::_id_B7148A3BFC4DEFB2())
    _id_27EC7BE8325EFA3C(data);
  else {
    vehicle_damage_heavyvisualclearcallback(data, 1);
    vehicle_damage_enginevisualclearcallback(data, 1);
  }

  if(!isDefined(_id_56182E19D2F0094F) || _id_56182E19D2F0094F != "heavy") {
    if(!scripts\cp_mp\vehicles\vehicle::_id_B7148A3BFC4DEFB2())
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement(self, 1);

    vehicle_damage_endburndown();
  }
}

vehicle_damage_registerdefaultstates(_id_7731ADEF63E19B0C) {
  _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(_id_7731ADEF63E19B0C, 1);
  _id_D2E455D494F8D46E = vehicle_damage_getleveldatafordamagestate(_id_7731ADEF63E19B0C, "light", 1);
  _id_D2E455D494F8D46E.onentercallback = ::vehicle_damage_onenterstatelight;
  _id_D2E455D494F8D46E.onexitcallback = ::vehicle_damage_onexitstatelight;
  _id_D2E455D494F8D46E = vehicle_damage_getleveldatafordamagestate(_id_7731ADEF63E19B0C, "medium", 1);
  _id_D2E455D494F8D46E.onentercallback = ::vehicle_damage_onenterstatemedium;
  _id_D2E455D494F8D46E.onexitcallback = ::vehicle_damage_onexitstatemedium;
  _id_D2E455D494F8D46E = vehicle_damage_getleveldatafordamagestate(_id_7731ADEF63E19B0C, "heavy", 1);
  _id_D2E455D494F8D46E.onentercallback = ::vehicle_damage_onenterstateheavy;
  _id_D2E455D494F8D46E.onexitcallback = ::vehicle_damage_onexitstateheavy;
  vehicle_damage_updatestatemaxhealthvalues(_id_7731ADEF63E19B0C);
}

_id_D06474F0BC53709D(data) {
  self setscriptablepartstate("damageHeavy", "on", 1);
}

_id_27EC7BE8325EFA3C(data) {
  self setscriptablepartstate("damageHeavy", "off", 1);
  _id_78EBF58592491D35 = scripts\cp_mp\vehicles\vehicle_spawn::_id_89CDA5BA9BFC8D56(self._id_5E7ED8E7A332998A);

  if(isDefined(_id_78EBF58592491D35)) {
    foreach(struct in _id_78EBF58592491D35)
    self setscriptablepartstate(struct._id_01FB6B56A662DF98, "off", 1);
  }
}

vehicle_damage_getmaxhealth(vehicle, _id_7731ADEF63E19B0C) {
  if(!isDefined(_id_7731ADEF63E19B0C))
    _id_7731ADEF63E19B0C = vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();

  _id_962A30A9BB8C0F09 = vehicle_damage_getleveldata();
  _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(_id_7731ADEF63E19B0C, 1);

  if(!isDefined(_id_E2818AD39A3341B4)) {
    if(isDefined(vehicle))
      return vehicle.maxhealth;

    return undefined;
  }

  if(!isDefined(_id_E2818AD39A3341B4.health)) {
    if(isDefined(vehicle))
      return vehicle.maxhealth;

    return undefined;
  }

  maxhealth = _id_E2818AD39A3341B4.health;
  heavystatehealthadd = vehicle_damage_getheavystatehealthadd(_id_7731ADEF63E19B0C);

  if(isDefined(heavystatehealthadd))
    maxhealth = maxhealth + heavystatehealthadd;

  return int(maxhealth);
}

vehicle_damage_getpristinestateminhealth(vehicle, _id_7731ADEF63E19B0C) {
  if(!isDefined(_id_7731ADEF63E19B0C))
    _id_7731ADEF63E19B0C = vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();

  _id_962A30A9BB8C0F09 = vehicle_damage_getleveldata();
  _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(_id_7731ADEF63E19B0C, 1);

  if(!isDefined(_id_E2818AD39A3341B4))
    return undefined;

  if(!isDefined(_id_E2818AD39A3341B4.health))
    return undefined;

  _id_6AD9AD03DC2FD0A0 = _id_E2818AD39A3341B4.health * 0.9;
  heavystatehealthadd = vehicle_damage_getheavystatehealthadd(_id_7731ADEF63E19B0C);

  if(isDefined(heavystatehealthadd))
    _id_6AD9AD03DC2FD0A0 = _id_6AD9AD03DC2FD0A0 + heavystatehealthadd;

  if(!isDefined(_id_6AD9AD03DC2FD0A0) || _id_6AD9AD03DC2FD0A0 <= 0)
    return undefined;

  return int(_id_6AD9AD03DC2FD0A0);
}

vehicle_damage_getheavystatemaxhealth(vehicle, _id_7731ADEF63E19B0C) {
  if(!isDefined(_id_7731ADEF63E19B0C))
    _id_7731ADEF63E19B0C = vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();

  _id_962A30A9BB8C0F09 = vehicle_damage_getleveldata();
  _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(_id_7731ADEF63E19B0C);

  if(!isDefined(_id_E2818AD39A3341B4))
    return undefined;

  if(!isDefined(_id_E2818AD39A3341B4.health))
    return undefined;

  heavystatehealthadd = vehicle_damage_getheavystatehealthadd(_id_7731ADEF63E19B0C);

  if(!isDefined(heavystatehealthadd) || heavystatehealthadd <= 0)
    return undefined;

  return int(heavystatehealthadd);
}

vehicle_damage_updatestatemaxhealthvalues(_id_7731ADEF63E19B0C) {
  _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(_id_7731ADEF63E19B0C);
  _id_ED42BF9CFFB5C5AD = undefined;
  maxhealth = undefined;

  foreach(_id_CB322750051A892B, _id_47BDB61121B1EC92 in _id_E2818AD39A3341B4.damagestatedata) {
    if(_id_CB322750051A892B == "light") {
      _id_47BDB61121B1EC92.maxhealth = vehicle_damage_getpristinestateminhealth(undefined, _id_7731ADEF63E19B0C);
      maxhealth = _id_47BDB61121B1EC92.maxhealth;
      continue;
    }

    if(_id_CB322750051A892B == "heavy") {
      _id_47BDB61121B1EC92.maxhealth = vehicle_damage_getheavystatemaxhealth(undefined, _id_7731ADEF63E19B0C);
      _id_ED42BF9CFFB5C5AD = _id_47BDB61121B1EC92.maxhealth;
    }
  }

  _id_47BDB61121B1EC92 = _id_E2818AD39A3341B4.damagestatedata["medium"];

  if(isDefined(_id_47BDB61121B1EC92)) {
    if(isDefined(_id_ED42BF9CFFB5C5AD) && isDefined(maxhealth)) {
      _id_6C8D21B2E54B2478 = vehicle_damage_getmediumstatehealthratio(_id_7731ADEF63E19B0C);

      if(isDefined(_id_6C8D21B2E54B2478))
        _id_47BDB61121B1EC92.maxhealth = int(scripts\engine\math::lerp(_id_ED42BF9CFFB5C5AD, maxhealth, _id_6C8D21B2E54B2478));
    }
  }
}

vehicle_damage_getheavystatehealthadd(_id_7731ADEF63E19B0C) {
  _id_962A30A9BB8C0F09 = vehicle_damage_getleveldata();
  _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(_id_7731ADEF63E19B0C);
  heavystatehealthadd = _id_E2818AD39A3341B4.heavystatehealthadd;

  if(!isDefined(heavystatehealthadd))
    heavystatehealthadd = _id_962A30A9BB8C0F09.heavystatehealthadd;

  if(!isDefined(heavystatehealthadd) || heavystatehealthadd <= 0)
    return undefined;

  return int(heavystatehealthadd);
}

vehicle_damage_getmediumstatehealthratio(_id_7731ADEF63E19B0C) {
  _id_962A30A9BB8C0F09 = vehicle_damage_getleveldata();
  _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(_id_7731ADEF63E19B0C);
  mediumstatehealthratio = _id_E2818AD39A3341B4.mediumstatehealthratio;

  if(!isDefined(mediumstatehealthratio))
    mediumstatehealthratio = _id_962A30A9BB8C0F09.mediumstatehealthratio;

  if(!isDefined(mediumstatehealthratio) || mediumstatehealthratio <= 0 || mediumstatehealthratio > 1)
    return undefined;

  return mediumstatehealthratio;
}

_id_1989BD346C21B68A(data) {
  if(isDefined(data.inflictor) && isDefined(data.inflictor.weapon_name) && data.inflictor.weapon_name == "gl")
    return isDefined(data.meansofdeath) && data.meansofdeath == "MOD_GRENADE";

  if(isDefined(data.objweapon) && isDefined(data.objweapon.basename)) {
    switch (data.objweapon.basename) {
      case "iw9_tur_light_tank_mp":
      case "iw9_tur_cougar_mp":
        return isDefined(data.meansofdeath) && (data.meansofdeath == "MOD_PROJECTILE" || data.meansofdeath == "MOD_RIFLE_BULLET");
      case "iw9_tur_apc_russian_mp":
      case "iw9_la_mike32_mp":
      case "iw9_la_rpapa7_mp":
      case "iw9_la_gromeo_mp":
      case "iw9_la_juliet_mp":
      case "pac_sentry_turret_mp":
        return isDefined(data.meansofdeath) && data.meansofdeath == "MOD_PROJECTILE";
      case "iw9_la_kgolf_mp":
        return isDefined(data.meansofdeath) && data.meansofdeath == "MOD_GRENADE";
      case "c4_mp":
        return isDefined(data.meansofdeath) && data.meansofdeath == "MOD_EXPLOSIVE";
    }
  }

  return 0;
}

_id_6E87D9E8601D9029(vehicle, tagname, damagedata) {
  if(!isDefined(vehicle._id_AAB9695C92B0ED96))
    return 0;

  if(!isDefined(tagname))
    return 0;

  if(!isDefined(vehicle._id_AAB9695C92B0ED96[tagname]))
    return 0;

  if(_id_853C0063F08B55E1(vehicle._id_AAB9695C92B0ED96[tagname]))
    return 0;

  if(isDefined(damagedata) && isDefined(damagedata.objweapon) && (istrue(scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("weapons", "isThrowingKnife", damagedata.objweapon)) || istrue(scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("weapons", "isThrowStar", damagedata.objweapon)))) {
    _id_BAFA22FCDEFFF511 = _id_2265B277A0DAD0F1(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());

    if(!isDefined(_id_BAFA22FCDEFFF511[tagname]._id_7CBFFE9DE982BCAD))
      return 0;
  }

  if(isDefined(damagedata) && isDefined(damagedata.objweapon) && isDefined(damagedata.meansofdeath) && damagedata.meansofdeath == "MOD_MELEE") {
    _id_BAFA22FCDEFFF511 = _id_2265B277A0DAD0F1(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());
    _id_0A3FEE791925DCBB = scripts\cp_mp\utility\weapon_utility::_id_CFAC6D60B7A14AB9(damagedata.objweapon);
    _id_D5791473BEC48061 = isDefined(_id_BAFA22FCDEFFF511[tagname]._id_9EB2AF3A3212B936);
    _id_74224BEB4580F9DF = isDefined(_id_BAFA22FCDEFFF511[tagname]._id_7CBFFE9DE982BCAD);

    if(_id_0A3FEE791925DCBB && !_id_D5791473BEC48061 && !_id_74224BEB4580F9DF)
      return 0;
    else if(!_id_0A3FEE791925DCBB && !_id_D5791473BEC48061)
      return 0;
  }

  if(isDefined(damagedata) && isDefined(damagedata.objweapon) && scripts\cp_mp\utility\damage_utility::iscrossbowdamage(damagedata.objweapon)) {
    if(scripts\cp_mp\utility\damage_utility::_id_0006065FCE6CDCAD(damagedata.objweapon) || scripts\cp_mp\utility\damage_utility::_id_D49206E61AC4F6DE(damagedata.objweapon))
      return 0;

    return _id_EE1FF9EED64D1E5D(vehicle, tagname);
  }

  state = vehicle getscriptablepartstate(tagname, 1);

  if(isDefined(state) && state == "start_hidden")
    return 0;

  _id_ECDFF35842734458 = _id_14CC373F72A021A8(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD(), tagname);

  if(isDefined(_id_ECDFF35842734458))
    return [[_id_ECDFF35842734458]](damagedata);

  return 1;
}

_id_452936099DCD1B94(seatid) {
  data = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());
  return isDefined(data.seatdata[seatid]) && isDefined(data.seatdata[seatid]._id_9A3DB3C861DA8D62) && isDefined(self._id_AAB9695C92B0ED96) && isDefined(self._id_AAB9695C92B0ED96[data.seatdata[seatid]._id_9A3DB3C861DA8D62]) && !_id_853C0063F08B55E1(self._id_AAB9695C92B0ED96[data.seatdata[seatid]._id_9A3DB3C861DA8D62]);
}

_id_14219D4C7D83499F(seatid) {
  data = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());

  if(isDefined(data.seatdata[seatid]) && isDefined(data.seatdata[seatid]._id_9A3DB3C861DA8D62)) {
    self._id_AAB9695C92B0ED96[data.seatdata[seatid]._id_9A3DB3C861DA8D62]._id_A776F097EB36E500 = 0;
    _id_77DB32AA48A42A76(self, data.seatdata[seatid]._id_9A3DB3C861DA8D62);
  }
}

_id_E6EC777562579771(vehicle, seatid) {
  self endon("death_or_disconnect");
  self endon("vehicle_seat_exit");
  scripts\engine\utility::waittill_any_2("vehicle_leanout_begin", "roof_exit");

  if(vehicle _id_452936099DCD1B94(seatid))
    vehicle _id_14219D4C7D83499F(seatid);
}

_id_14CC373F72A021A8(_id_7731ADEF63E19B0C, tagname) {
  _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(_id_7731ADEF63E19B0C);
  _id_CABB13CAAF7BAA1E = _id_E2818AD39A3341B4._id_AAB9695C92B0ED96[tagname]._id_CABB13CAAF7BAA1E;

  if(isDefined(_id_CABB13CAAF7BAA1E)) {
    switch (_id_CABB13CAAF7BAA1E) {
      case "explosive_only":
        return::_id_43C057BAACA777A5;
    }
  }

  return undefined;
}

_id_2265B277A0DAD0F1(_id_7731ADEF63E19B0C) {
  _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(_id_7731ADEF63E19B0C);
  return _id_E2818AD39A3341B4._id_AAB9695C92B0ED96;
}

_id_F7DF41D3AD15DCA8(_id_7731ADEF63E19B0C, tagname) {
  _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(_id_7731ADEF63E19B0C);
  return _id_E2818AD39A3341B4._id_AAB9695C92B0ED96[tagname]._id_DA9F4CD603F44758;
}

_id_BAD6C0E32FF1E092(_id_7731ADEF63E19B0C, tagname) {
  _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(_id_7731ADEF63E19B0C);
  return _id_E2818AD39A3341B4._id_AAB9695C92B0ED96[tagname]._id_B4FCCC158C681073;
}

_id_DDE06C2157EC8895(_id_7731ADEF63E19B0C, tagname) {
  _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(_id_7731ADEF63E19B0C);
  return _id_E2818AD39A3341B4._id_AAB9695C92B0ED96[tagname]._id_1C60586652067D4C;
}

_id_8A0E1B95ABC01E56(_id_7731ADEF63E19B0C, tagname) {
  _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(_id_7731ADEF63E19B0C);
  return scripts\engine\utility::_id_53C4C53197386572(_id_E2818AD39A3341B4._id_AAB9695C92B0ED96[tagname]._id_F0B290E6673EF286, 30);
}

_id_3DF56DED0597EB6E(_id_7731ADEF63E19B0C, tagname) {
  _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(_id_7731ADEF63E19B0C);
  return istrue(_id_E2818AD39A3341B4._id_AAB9695C92B0ED96[tagname]._id_9983055E997835BE);
}

_id_C9F618F05861C2C5(_id_7731ADEF63E19B0C, tagname) {
  _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(_id_7731ADEF63E19B0C);
  _id_40FF49AD8188ECC6 = _id_E2818AD39A3341B4._id_AAB9695C92B0ED96[tagname]._id_84872288B2E0CE95;

  if(!isDefined(_id_40FF49AD8188ECC6))
    _id_40FF49AD8188ECC6 = 0;

  return _id_40FF49AD8188ECC6;
}

_id_EE1FF9EED64D1E5D(vehicle, tagname, _id_E691C80BA12C3DA1) {
  if(!isDefined(_id_E691C80BA12C3DA1))
    _id_E691C80BA12C3DA1 = 1;

  if(!isDefined(tagname))
    return 0;

  if(!isDefined(vehicle._id_AAB9695C92B0ED96))
    return 0;

  if(!isDefined(vehicle._id_AAB9695C92B0ED96[tagname]))
    return 0;

  _id_BAFA22FCDEFFF511 = _id_2265B277A0DAD0F1(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());
  _id_D5791473BEC48061 = isDefined(_id_BAFA22FCDEFFF511[tagname]._id_9EB2AF3A3212B936);
  _id_74224BEB4580F9DF = isDefined(_id_BAFA22FCDEFFF511[tagname]._id_7CBFFE9DE982BCAD);

  if(_id_74224BEB4580F9DF)
    return 1;

  if(_id_E691C80BA12C3DA1) {
    if(_id_D5791473BEC48061)
      return 1;

    if(issubstr(tagname, "tag_light"))
      return 1;
  }

  return 0;
}

_id_82CAD97B4499E421(vehicle, tagname, _id_AA2660B54E981080) {
  data = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());
  _id_BAFA22FCDEFFF511 = data.damage._id_AAB9695C92B0ED96[tagname];

  if(istrue(_id_AA2660B54E981080))
    return "reactive_armor_explosion";
  else if(!vehicle scripts\cp_mp\vehicles\vehicle::_id_B7148A3BFC4DEFB2() && isDefined(_id_BAFA22FCDEFFF511._id_7CBFFE9DE982BCAD) && _id_BAFA22FCDEFFF511._id_7CBFFE9DE982BCAD != "not_a_wheel" && istrue(level._id_EC75CA2494D74DAB))
    return "death_usable";
  else
    return "death";
}

_id_9C23735BF7534AFA(vehicle, damage, point, radius) {
  if(!isDefined(vehicle) || !isDefined(vehicle._id_AAB9695C92B0ED96) || vehicle._id_AAB9695C92B0ED96.size == 0) {
    return;
  }
  ref = vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();
  _id_08490F7216313A83 = _id_90B374D856D14373(ref);
  _id_BAFA22FCDEFFF511 = _id_2265B277A0DAD0F1(ref);
  _id_8FA87D2C8780E014 = radius * radius;
  _id_1763B6CD86FF52F2 = undefined;
  _id_6AAEEA4A5B05A723 = undefined;
  _id_21528CF722158315 = undefined;

  foreach(tagname, _id_AEDB57673CF38E2B in vehicle._id_AAB9695C92B0ED96) {
    if(vehicle tagexists(tagname) && istrue(_id_BAFA22FCDEFFF511[tagname]._id_30BEABB585E60744)) {
      _id_C88D34BEE5A69C56 = distancesquared(point, vehicle gettagorigin(tagname));

      if(_id_C88D34BEE5A69C56 <= _id_8FA87D2C8780E014 && _id_6E87D9E8601D9029(vehicle, tagname) && (!isDefined(_id_1763B6CD86FF52F2) || _id_C88D34BEE5A69C56 < _id_1763B6CD86FF52F2)) {
        _id_1763B6CD86FF52F2 = _id_C88D34BEE5A69C56;
        _id_6AAEEA4A5B05A723 = tagname;
        _id_21528CF722158315 = _id_AEDB57673CF38E2B;
      }
    }
  }

  if(isDefined(_id_6AAEEA4A5B05A723) && isDefined(_id_21528CF722158315)) {
    _id_21528CF722158315._id_A776F097EB36E500 = max(0, _id_21528CF722158315._id_A776F097EB36E500 - damage);

    if(_id_853C0063F08B55E1(_id_21528CF722158315))
      _id_77DB32AA48A42A76(vehicle, _id_6AAEEA4A5B05A723);
  }
}

_id_ECDF1217E332C7D7(vehicle, damage, point, _id_5D5F540EC81C82A9) {
  if(!isDefined(vehicle) || !isDefined(vehicle._id_AAB9695C92B0ED96) || vehicle._id_AAB9695C92B0ED96.size == 0 || _id_5D5F540EC81C82A9 == 0) {
    return;
  }
  ref = vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();
  _id_BAFA22FCDEFFF511 = _id_2265B277A0DAD0F1(ref);
  wheels = [];

  foreach(tagname, _id_AEDB57673CF38E2B in vehicle._id_AAB9695C92B0ED96) {
    if(!vehicle tagexists(tagname) || !isDefined(_id_BAFA22FCDEFFF511[tagname]._id_7CBFFE9DE982BCAD) || !isDefined(vehicle._id_AAB9695C92B0ED96[tagname]) || _id_853C0063F08B55E1(vehicle._id_AAB9695C92B0ED96[tagname])) {
      continue;
    }
    _id_F03D6AEDC78419B8 = spawnStruct();
    _id_F03D6AEDC78419B8.origin = vehicle gettagorigin(tagname);
    _id_F03D6AEDC78419B8.tag = tagname;
    _id_F03D6AEDC78419B8.data = _id_AEDB57673CF38E2B;
    wheels[wheels.size] = _id_F03D6AEDC78419B8;
  }

  if(wheels.size == 0) {
    return;
  }
  foreach(_id_9A94DB657B4525D0 in sortbydistance(wheels, point)) {
    _id_9A94DB657B4525D0.data._id_A776F097EB36E500 = max(0, _id_9A94DB657B4525D0.data._id_A776F097EB36E500 - damage);

    if(_id_853C0063F08B55E1(_id_9A94DB657B4525D0.data))
      _id_77DB32AA48A42A76(vehicle, _id_9A94DB657B4525D0.tag);

    _id_5D5F540EC81C82A9 = _id_5D5F540EC81C82A9 - 1;

    if(_id_5D5F540EC81C82A9 <= 0)
      return;
  }
}

_id_786C7EC25AAD5005(vehicle, damagedata) {
  _id_F1A0290E8F712715 = [];
  _id_32665ADB2A4D8FC9 = [];

  if(isDefined(damagedata.partname) && isstring(damagedata.partname) && damagedata.partname != "" && vehicle tagexists(damagedata.partname))
    _id_F1A0290E8F712715[damagedata.partname] = damagedata.partname;

  if(isDefined(damagedata._id_799F234362ADB813) && isstring(damagedata._id_799F234362ADB813) && damagedata._id_799F234362ADB813 != "" && vehicle tagexists(damagedata._id_799F234362ADB813))
    _id_F1A0290E8F712715[damagedata._id_799F234362ADB813] = damagedata._id_799F234362ADB813;

  foreach(tag in _id_F1A0290E8F712715)
  _id_32665ADB2A4D8FC9[tag] = distancesquared(damagedata.point, vehicle gettagorigin(tag));

  if(isDefined(vehicle._id_AAB9695C92B0ED96) && vehicle._id_AAB9695C92B0ED96.size > 0 && isexplosivedamagemod(damagedata.meansofdeath)) {
    data = vehicle_damage_getleveldataforvehicle(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());
    _id_08490F7216313A83 = data._id_08490F7216313A83;
    _id_2F51E76299064178 = data._id_3259F2F4FAF8EAA8;

    foreach(tagname, _id_A776F097EB36E500 in vehicle._id_AAB9695C92B0ED96) {
      if(vehicle tagexists(tagname) && !_id_853C0063F08B55E1(_id_A776F097EB36E500) && !isDefined(_id_F1A0290E8F712715[tagname])) {
        _id_4EB801042B324702 = distancesquared(damagedata.point, vehicle gettagorigin(tagname));

        if(_id_4EB801042B324702 <= _id_08490F7216313A83) {
          _id_F1A0290E8F712715[tagname] = tagname;
          _id_32665ADB2A4D8FC9[tagname] = _id_4EB801042B324702;
        }
      }
    }

    if(isDefined(_id_2F51E76299064178) && _id_32665ADB2A4D8FC9.size > _id_2F51E76299064178) {
      _id_592B7F1A155451E0 = [];

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2F51E76299064178; _id_AC0E594AC96AA3A8++) {
        _id_114AB88507847C50 = undefined;
        _id_C1DA30005A22582B = undefined;

        foreach(tagname, _id_DA8ADD1D7D930260 in _id_32665ADB2A4D8FC9) {
          if(!isDefined(_id_C1DA30005A22582B) || _id_DA8ADD1D7D930260 < _id_C1DA30005A22582B) {
            _id_C1DA30005A22582B = _id_DA8ADD1D7D930260;
            _id_114AB88507847C50 = tagname;
          }
        }

        if(isDefined(_id_114AB88507847C50)) {
          _id_592B7F1A155451E0[_id_AC0E594AC96AA3A8] = _id_114AB88507847C50;
          _id_32665ADB2A4D8FC9[_id_114AB88507847C50] = undefined;
          continue;
        }

        return _id_592B7F1A155451E0;
      }

      return _id_592B7F1A155451E0;
    }
  }

  return _id_F1A0290E8F712715;
}

_id_7A5070220FC8CE9E(_id_7731ADEF63E19B0C, _id_AAB9695C92B0ED96) {
  _id_3102EA0DD30BBF11 = _id_32B9B5D07BB56C31(_id_7731ADEF63E19B0C);
  _id_DFDBCC779477D31C = [];

  foreach(tag, part in _id_3102EA0DD30BBF11) {
    if(istrue(part.inactive)) {
      continue;
    }
    if(isDefined(_id_AAB9695C92B0ED96[tag])) {
      _id_DFDBCC779477D31C[tag] = _id_AAB9695C92B0ED96[tag];
      continue;
    }

    _id_1C09C3E40955F379 = spawnStruct();
    _id_1C09C3E40955F379._id_A776F097EB36E500 = part._id_A776F097EB36E500;
    _id_1C09C3E40955F379._id_92894EF28E2B8800 = part._id_92894EF28E2B8800;
    _id_DFDBCC779477D31C[tag] = _id_1C09C3E40955F379;
  }

  return _id_DFDBCC779477D31C;
}

_id_CF63DB12F07ABF78(_id_7731ADEF63E19B0C, _id_AAB9695C92B0ED96) {
  if(!isDefined(_id_AAB9695C92B0ED96)) {
    return;
  }
  foreach(tagname, _id_1C09C3E40955F379 in _id_AAB9695C92B0ED96) {
    if(_id_0600FF5DF9DBF294(_id_7731ADEF63E19B0C, tagname, _id_1C09C3E40955F379)) {
      _id_1C09C3E40955F379._id_A776F097EB36E500 = 0;
      _id_66AC97EBA6B35B4A(self, tagname, undefined);
      continue;
    }

    if(_id_E531AD775DCBCA22(_id_7731ADEF63E19B0C, tagname, _id_1C09C3E40955F379)) {
      _id_1C09C3E40955F379._id_A776F097EB36E500 = 0;
      _id_77DB32AA48A42A76(self, tagname, undefined);
    }
  }
}

_id_E531AD775DCBCA22(_id_7731ADEF63E19B0C, _id_151B23F6C7D09CF8, _id_8178911A49BA9BE9) {
  _id_65E4A4E3E5E2766F = _id_8A0E1B95ABC01E56(_id_7731ADEF63E19B0C, _id_151B23F6C7D09CF8);
  return randomint(100) < _id_65E4A4E3E5E2766F;
}

_id_0600FF5DF9DBF294(_id_7731ADEF63E19B0C, _id_151B23F6C7D09CF8, _id_8178911A49BA9BE9) {
  return _id_3DF56DED0597EB6E(_id_7731ADEF63E19B0C, _id_151B23F6C7D09CF8) || _id_853C0063F08B55E1(_id_8178911A49BA9BE9);
}

_id_853C0063F08B55E1(_id_1C09C3E40955F379) {
  return _id_1C09C3E40955F379._id_A776F097EB36E500 == 0 || _id_1C09C3E40955F379._id_92894EF28E2B8800 == 0;
}

_id_90B374D856D14373(_id_7731ADEF63E19B0C) {
  _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(_id_7731ADEF63E19B0C);
  return _id_E2818AD39A3341B4._id_08490F7216313A83;
}

_id_43C057BAACA777A5(damagedata) {
  return isexplosivedamagemod(damagedata.meansofdeath);
}

vehicle_damage_beginburndown(data) {
  self endon("death");
  self endon("end_burn_down");
  ref = scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();

  if(!istrue(self.burningdown)) {
    _id_E2818AD39A3341B4 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle(ref);
    burndowntime = vehicle_damage_getburndowntime(ref);

    if(isDefined(burndowntime)) {
      self.burningdown = 1;

      if(isDefined(data)) {
        if(isDefined(data.attacker))
          self._id_9328DED553F15D2B = data.attacker;
        else
          self._id_9328DED553F15D2B = undefined;

        if(isDefined(data.objweapon))
          self._id_3D917147266DB534 = data.objweapon;
        else
          self._id_3D917147266DB534 = undefined;
      }

      occupants = scripts\cp_mp\vehicles\vehicle_occupancy::_id_0EFA75AA7F0A1289(self, 0);

      if(isDefined(occupants))
        scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("burningDown", occupants, ref);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(ref, "beginBurnDown"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc(ref, "beginBurnDown")]]();

      childthread _id_43536E2E28CC20C0(data, burndowntime);
      wait(burndowntime);
      self.burningdown = undefined;
      scripts\cp_mp\pet_watch::checkcarpuncherprogressgeneric();
      thread scripts\cp_mp\vehicles\vehicle::_id_AB08028468AB68F9(data, 0);
      return;
    }
  }
}

_id_43536E2E28CC20C0(data, burndowntime) {
  _id_CFABC0D1AB1AB2E9 = self.health;

  if(isDefined(data) && isDefined(data.damage))
    _id_CFABC0D1AB1AB2E9 = self.health - data.damage;

  _id_EC2B154791158E97 = int(ceil(burndowntime / 1));
  _id_76E563DB5D11A0EA = int(ceil(_id_CFABC0D1AB1AB2E9 / _id_EC2B154791158E97 / 0.25));

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_EC2B154791158E97; _id_AC0E594AC96AA3A8++) {
    wait 1;
    self dodamage(_id_76E563DB5D11A0EA, self.origin);
    _id_9542EAC6997B9060(self);
  }
}

vehicle_damage_endburndown(_id_FCEF8D217A441961) {
  if(!istrue(self.burningdown)) {
    return;
  }
  self notify("end_burn_down");
  scripts\cp_mp\pet_watch::checkcarpuncherprogressgeneric();

  if(!istrue(_id_FCEF8D217A441961)) {
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::_id_0EFA75AA7F0A1289(self, 0);

    if(isDefined(occupants))
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("burningDown", occupants, scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());
  }

  self.burningdown = undefined;
}

vehicle_damage_isburningdown() {
  return istrue(self.burningdown);
}

vehicle_damage_getburndowntime(_id_7731ADEF63E19B0C) {
  if(isDefined(self.burndowntime))
    return self.burndowntime;

  _id_962A30A9BB8C0F09 = vehicle_damage_getleveldata();
  _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(_id_7731ADEF63E19B0C);
  burndowntime = _id_E2818AD39A3341B4.burndowntime;

  if(!isDefined(burndowntime))
    burndowntime = _id_962A30A9BB8C0F09.burndowntime;

  if(!isDefined(burndowntime) || burndowntime <= 0)
    return undefined;

  return burndowntime;
}

vehicle_damage_shouldskipburndown(data) {
  if(isDefined(data.meansofdeath)) {
    if(!isexplosivedamagemod(data.meansofdeath) && data.meansofdeath != "MOD_FIRE")
      return 0;

    if(data.meansofdeath == "MOD_CRUSH")
      return 1;
  }

  if(isDefined(data.objweapon) && !isnullweapon(data.objweapon) && isDefined(scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD())) {
    _id_D6961EF4AB70843C = undefined;
    vehiclename = scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();
    weaponname = data.objweapon.basename;
    _id_962A30A9BB8C0F09 = vehicle_damage_getleveldata();
    table = _id_962A30A9BB8C0F09.table;

    if(isDefined(_id_962A30A9BB8C0F09.table.skipburndownforvehicle[vehiclename]))
      _id_D6961EF4AB70843C = _id_962A30A9BB8C0F09.table.skipburndownforvehicle[vehiclename][weaponname];

    if(isDefined(_id_D6961EF4AB70843C))
      return _id_D6961EF4AB70843C;

    _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(vehiclename, undefined, 1);

    if(isDefined(_id_E2818AD39A3341B4)) {
      classname = _id_E2818AD39A3341B4.class;

      if(!isDefined(classname) || classname == "none")
        return 1;

      if(istrue(_id_E2818AD39A3341B4.skipburndown))
        return 1;

      if(isDefined(_id_962A30A9BB8C0F09.table.skipburndownforclass[classname]))
        _id_D6961EF4AB70843C = _id_962A30A9BB8C0F09.table.skipburndownforclass[classname][weaponname];

      if(isDefined(_id_D6961EF4AB70843C))
        return _id_D6961EF4AB70843C;
    } else
      return 1;
  } else
    return 1;

  return 0;
}

_id_7AAA7AE503292F43(_id_7731ADEF63E19B0C) {
  return scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle(_id_7731ADEF63E19B0C).weapon;
}

_id_06C17ABF5C5D88CA(_id_7731ADEF63E19B0C) {
  data = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle(_id_7731ADEF63E19B0C);
  return scripts\engine\utility::ter_op(isDefined(data._id_FB41D1CA75009BF0.weapon), data._id_FB41D1CA75009BF0.weapon, data.weapon);
}

_id_D0DF49DE517DED03() {
  ref = scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();
  data = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(ref);
  _id_5E1984DBB5848080 = scripts\cp_mp\vehicles\vehicle::_id_B7148A3BFC4DEFB2();
  _id_F48D20DFEF6AF564 = scripts\engine\utility::ter_op(_id_5E1984DBB5848080 || istrue(self._id_A8F4BB03B366AA80) && isDefined(data._id_EB61D7C4087C9207), data._id_EB61D7C4087C9207, data._id_14090BC312DBF6C8);
  _id_C094DB262CE4DFA0 = scripts\engine\utility::ter_op(_id_5E1984DBB5848080, _id_06C17ABF5C5D88CA(ref), _id_7AAA7AE503292F43(ref));
  _id_35FD13041DDE93E8 = self._id_35FD13041DDE93E8;
  waittillframeend;
  _id_240A4F3D560753FF = self gettagorigin(_id_F48D20DFEF6AF564.tag);
  _id_526FB1ABFF9D991F = _id_240A4F3D560753FF;

  if(isDefined(_id_F48D20DFEF6AF564._id_F66DDD6B1919C847))
    _id_526FB1ABFF9D991F = _id_526FB1ABFF9D991F + rotatevector((scripts\engine\utility::_id_53C4C53197386572(_id_F48D20DFEF6AF564._id_F66DDD6B1919C847.x, 0), scripts\engine\utility::_id_53C4C53197386572(_id_F48D20DFEF6AF564._id_F66DDD6B1919C847.y, 0), scripts\engine\utility::_id_53C4C53197386572(_id_F48D20DFEF6AF564._id_F66DDD6B1919C847.z, 0)), self.angles);

  attacker = scripts\engine\utility::ter_op(isDefined(self._id_9328DED553F15D2B), self._id_9328DED553F15D2B, self);
  self radiusdamage(_id_526FB1ABFF9D991F, _id_F48D20DFEF6AF564.radius, _id_F48D20DFEF6AF564.maxdamage, _id_F48D20DFEF6AF564.mindamage, attacker, "MOD_EXPLOSIVE", _id_C094DB262CE4DFA0);
  fxname = self.vehiclename + "_explosion";

  if(scripts\engine\utility::fxexists(fxname))
    playFX(scripts\engine\utility::getfx(fxname), _id_240A4F3D560753FF, anglesToForward(self.angles), anglestoup(self.angles));

  if(isDefined(_id_F48D20DFEF6AF564.sfx))
    playsoundatpos(_id_240A4F3D560753FF, _id_F48D20DFEF6AF564.sfx);

  self stopsounds();

  if(isDefined(_id_F48D20DFEF6AF564.scriptable)) {
    _id_FD1B8EFDE6ACAF63 = spawn("script_model", _id_240A4F3D560753FF);
    _id_FD1B8EFDE6ACAF63 setModel(_id_F48D20DFEF6AF564.scriptable);

    if(isDefined(_id_35FD13041DDE93E8) && isDefined(_id_35FD13041DDE93E8._id_C3606975AB404C5C) && _id_FD1B8EFDE6ACAF63 getscriptableparthasstate("explosion", _id_35FD13041DDE93E8._id_C3606975AB404C5C))
      _id_FD1B8EFDE6ACAF63 setscriptablepartstate("explosion", _id_35FD13041DDE93E8._id_C3606975AB404C5C);
    else
      _id_FD1B8EFDE6ACAF63 setscriptablepartstate("explosion", "on");

    _id_FD1B8EFDE6ACAF63.angles = self.angles;
    _id_FD1B8EFDE6ACAF63 thread _id_7D040E8B44F42B5F();
  }

  earthquake(_id_F48D20DFEF6AF564._id_2904DF1BE79620B6, _id_F48D20DFEF6AF564._id_0BDA0B1D6CCE0914, _id_240A4F3D560753FF, _id_F48D20DFEF6AF564._id_1CCED33303F26D02);
  playrumbleonposition("grenade_rumble", _id_240A4F3D560753FF);
  physicsexplosionsphere(_id_240A4F3D560753FF, _id_F48D20DFEF6AF564._id_A1939E49D568612B, _id_F48D20DFEF6AF564._id_9ED85C24DBCF8DA4, _id_F48D20DFEF6AF564._id_FDDF5FE707F47E54);
}

_id_7D040E8B44F42B5F() {
  wait 7;
  self delete();
}

_id_734926FCDBAD1FD4() {
  if(scripts\cp_mp\vehicles\vehicle::_id_B7148A3BFC4DEFB2())
    return 0;
  else
    return 1;
}

vehicle_damage_onenterstateheavyscore(_id_1AE0AEB37C917298, data) {
  if(isDefined(data) && isDefined(data.attacker)) {
    _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD(), undefined, 1);

    if(isDefined(_id_E2818AD39A3341B4)) {
      _id_72141EAB56FB408F = vehicle_damage_getinstancedataforvehicle(self, undefined, 1);
      _id_F0FA3B7B27926553 = undefined;
      _id_8D930BAA3B013616 = undefined;
      _id_A773025016ED337A = undefined;
      _id_49134347B50C0B0F = undefined;

      if(isDefined(_id_72141EAB56FB408F)) {
        _id_F0FA3B7B27926553 = _id_72141EAB56FB408F.heavydamagescoreevent;
        _id_8D930BAA3B013616 = _id_72141EAB56FB408F.heavydamagescorelaunchonly;
        _id_A773025016ED337A = _id_72141EAB56FB408F.heavydamageaward;
        _id_49134347B50C0B0F = _id_72141EAB56FB408F.heavydamageawardlaunchonly;
      }

      if(isDefined(_id_E2818AD39A3341B4.class)) {
        if(!isDefined(_id_F0FA3B7B27926553)) {
          switch (_id_E2818AD39A3341B4.class) {
            case "light":
            case "super_light":
              _id_F0FA3B7B27926553 = "stat_F9162CF6B4695651";
              break;
            case "medium_heavy":
            case "medium_light":
            case "medium":
              _id_F0FA3B7B27926553 = "stat_8D625B12EB84E958";
              break;
            case "heavy":
            case "super_heavy":
              _id_F0FA3B7B27926553 = "stat_CF6BAA13DAC1910A";
              break;
          }
        }

        if(!isDefined(_id_A773025016ED337A)) {}
      }

      if(isDefined(_id_F0FA3B7B27926553) && _id_F0FA3B7B27926553 == "stat_3C0D17BAD169557B")
        _id_F0FA3B7B27926553 = undefined;

      if(isDefined(_id_A773025016ED337A) && _id_A773025016ED337A == "none")
        _id_A773025016ED337A = undefined;

      if(!istrue(data.givepointsandxp) && isPlayer(data.attacker))
        data.givepointsandxp = scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer(self, data.attacker);

      if(isDefined(data.objweapon) && weaponclass(data.objweapon.basename) != "rocketlauncher") {
        if(istrue(_id_8D930BAA3B013616))
          data.scoreeventnoweaponxp = 1;

        if(istrue(_id_49134347B50C0B0F))
          data.awardnoweaponxp = 1;
      }

      data.attacker thread vehicle_damage_givescoreandxpatframeend(_id_F0FA3B7B27926553, _id_A773025016ED337A, data, self);
    }
  }
}

vehicle_damage_ondeathscore(data) {
  if(isDefined(data) && isDefined(data.attacker)) {
    _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD(), undefined, 1);

    if(isDefined(_id_E2818AD39A3341B4)) {
      _id_72141EAB56FB408F = vehicle_damage_getinstancedataforvehicle(self, undefined, 1);
      _id_F0FA3B7B27926553 = undefined;
      _id_8D930BAA3B013616 = undefined;
      _id_A773025016ED337A = undefined;
      _id_49134347B50C0B0F = undefined;

      if(isDefined(_id_72141EAB56FB408F)) {
        _id_F0FA3B7B27926553 = _id_72141EAB56FB408F.destroyscoreevent;
        _id_8D930BAA3B013616 = _id_72141EAB56FB408F.destroyscorelaunchonly;
        _id_A773025016ED337A = _id_72141EAB56FB408F.destroyaward;
        _id_49134347B50C0B0F = _id_72141EAB56FB408F.destroyawardlaunchonly;
      }

      if(istrue(self._id_4924D9899B8D3124))
        _id_F0FA3B7B27926553 = "stat_9071D593D874942D";

      if(istrue(self._id_47F322B0E1BD7A7C))
        _id_F0FA3B7B27926553 = "stat_9067D693D86C415B";

      if(isDefined(_id_E2818AD39A3341B4.class)) {
        if(!isDefined(_id_F0FA3B7B27926553)) {
          switch (_id_E2818AD39A3341B4.class) {
            case "light":
            case "super_light":
              _id_F0FA3B7B27926553 = "stat_838CFF6819237D00";
              break;
            case "medium_heavy":
            case "medium_light":
            case "medium":
              _id_F0FA3B7B27926553 = "stat_F82E57F24F4A4993";
              break;
            case "heavy":
            case "super_heavy":
              _id_F0FA3B7B27926553 = "stat_D4032A806BEEBC83";
              break;
            default:
              _id_F0FA3B7B27926553 = "stat_3C0D17BAD169557B";
              break;
          }
        }

        if(!isDefined(_id_A773025016ED337A)) {}
      }

      if(isDefined(_id_F0FA3B7B27926553) && _id_F0FA3B7B27926553 == "stat_3C0D17BAD169557B")
        _id_F0FA3B7B27926553 = undefined;

      if(isDefined(_id_A773025016ED337A) && _id_A773025016ED337A == "none")
        _id_A773025016ED337A = undefined;

      if(isPlayer(data.attacker)) {
        if(!isDefined(data.givepointsandxp))
          data.givepointsandxp = scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer(self, data.attacker);
        else if(data.givepointsandxp && scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer(self, data.attacker))
          data.givepointsandxp = 0;
        else if(!data.givepointsandxp && scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer(self, data.attacker))
          data.givepointsandxp = 1;
      } else
        data.givepointsandxp = 0;

      if(isDefined(data.objweapon) && weaponclass(data.objweapon.basename) != "rocketlauncher") {
        if(istrue(_id_8D930BAA3B013616))
          data.scoreeventnoweaponxp = 1;

        if(istrue(_id_49134347B50C0B0F))
          data.awardnoweaponxp = 1;
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "onVehicleKilled"))
        data.attacker thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onVehicleKilled")]](self, data.attacker, data.damage, data.objweapon);

      data.attacker vehicle_damage_givescoreandxp(_id_F0FA3B7B27926553, _id_A773025016ED337A, data, self getentitynumber());
    }
  }
}

vehicle_damage_givescoreandxpatframeend(_id_F0FA3B7B27926553, _id_A773025016ED337A, data, vehicle) {
  _id_9D9017E622FDF70B = vehicle getentitynumber();
  self endon("disconnect");
  self endon("vehicle_damage_giveScoreAndXP" + _id_9D9017E622FDF70B);
  waittillframeend;
  thread vehicle_damage_givescoreandxp(_id_F0FA3B7B27926553, _id_A773025016ED337A, data, _id_9D9017E622FDF70B);
}

vehicle_damage_givescoreandxp(_id_F0FA3B7B27926553, _id_A773025016ED337A, data, _id_9D9017E622FDF70B) {
  self notify("vehicle_damage_giveScoreAndXP" + _id_9D9017E622FDF70B);

  if(isDefined(_id_F0FA3B7B27926553) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "giveScore")) {
    objweapon = scripts\engine\utility::ter_op(istrue(data.scoreeventnoweaponxp), undefined, data.objweapon);
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "giveScore")]](_id_F0FA3B7B27926553, objweapon, !istrue(data.givepointsandxp));
  }

  if(isDefined(_id_A773025016ED337A) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "giveAward")) {
    objweapon = scripts\engine\utility::ter_op(istrue(data.awardnoweaponxp), undefined, data.objweapon);
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "giveAward")]](_id_A773025016ED337A, objweapon, !istrue(data.givepointsandxp));
  }
}

vehicle_damage_setweaponclassmoddamageforvehicle(weaponclass, mod, _id_21E99FCEC7E19345, _id_7731ADEF63E19B0C) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponClassModDamageForVehicle"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponClassModDamageForVehicle")]](weaponclass, mod, _id_21E99FCEC7E19345, _id_7731ADEF63E19B0C);
}

vehicle_damage_setperkmoddamage(ref, mod, _id_21E99FCEC7E19345) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setPerkModDamage"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setPerkModDamage")]](ref, mod, _id_21E99FCEC7E19345);
}

vehicle_damage_setweaponhitdamagedata(weaponref, hitsperattack) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageData"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageData")]](weaponref, hitsperattack);
}

vehicle_damage_setvehiclehitdamagedata(_id_7731ADEF63E19B0C, hitstokill) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageData"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageData")]](_id_7731ADEF63E19B0C, hitstokill);
}

vehicle_damage_setvehiclehitdamagedataforweapon(_id_7731ADEF63E19B0C, hitstokill, weaponref) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageDataForWeapon"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon")]](_id_7731ADEF63E19B0C, hitstokill, weaponref);
}

vehicle_damage_setweaponhitdamagedataforvehicle(weaponref, hitsperattack, _id_7731ADEF63E19B0C) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageDataForVehicle"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle")]](weaponref, hitsperattack, _id_7731ADEF63E19B0C);
}

vehicle_damage_setpremoddamagecallback(_id_7731ADEF63E19B0C, callback) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setPreModDamageCallback"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setPreModDamageCallback")]](_id_7731ADEF63E19B0C, callback);
}

vehicle_damage_setpostmoddamagecallback(_id_7731ADEF63E19B0C, callback) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setPostModDamageCallback"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setPostModDamageCallback")]](_id_7731ADEF63E19B0C, callback);
}

vehicle_damage_setdeathcallback(_id_7731ADEF63E19B0C, callback) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setDeathCallback"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setDeathCallback")]](_id_7731ADEF63E19B0C, callback);
}

_id_E5CDE837844C6112(_id_7731ADEF63E19B0C, seatid, _id_5528888BDD4C85D6) {
  _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(_id_7731ADEF63E19B0C, 1);

  if(!isDefined(_id_E2818AD39A3341B4._id_B7B1DDCAAF4BF2DB))
    _id_E2818AD39A3341B4._id_B7B1DDCAAF4BF2DB = [];

  _id_E2818AD39A3341B4._id_B7B1DDCAAF4BF2DB[seatid] = _id_5528888BDD4C85D6;
}

_id_42B7542E79DA627F(_id_7731ADEF63E19B0C, seatid, _id_512D1BC7ADD3EAA3) {
  _id_E2818AD39A3341B4 = vehicle_damage_getleveldataforvehicle(_id_7731ADEF63E19B0C, 1);

  if(!isDefined(_id_E2818AD39A3341B4._id_8F793C5830904E92))
    _id_E2818AD39A3341B4._id_8F793C5830904E92 = [];

  _id_E2818AD39A3341B4._id_8F793C5830904E92[seatid] = _id_512D1BC7ADD3EAA3;
}

vehicle_damage_initdebug() {
  setdvarifuninitialized("scr_vehiclegod", 0);
  setdvarifuninitialized("dvar_4827EBAE75561872", 0);
}