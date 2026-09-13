/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\equipment\geiger_counter.gsc
******************************************************/

_id_58BF160252F94E21() {
  if(isDefined(level._id_216A5E72460DE468)) {
    return;
  }
  level._id_216A5E72460DE468 = 1;
  level._id_BCB3E1F6F7CD3CB7 = spawnStruct();
  level._id_BCB3E1F6F7CD3CB7._id_2B6807C7DF9A2B2D = scripts\engine\utility::_id_21A6A1C613B50A28([], 4000);
  level._id_BCB3E1F6F7CD3CB7._id_7838030D3C23488E = getdvarint("dvar_E4A881A4B29B1041", 1000.0);
}

_id_60CBA38635FD35CB(equipmentref, _id_CBB2B3D05E48BD27, variantid) {
  if(equipmentref != "equip_geigercounter") {
    return;
  }
  _id_58BF160252F94E21();
  self notifyonplayercommand("pullout_gc", "+smoke");
  self notify("geigercounter_take");
  thread _id_7E40241842784520();
  _id_C8B79F6694C62EE8(-1.0);
}

_id_BDD02627BCAFE359(equipmentref, _id_CBB2B3D05E48BD27) {
  if(equipmentref != "equip_geigercounter") {
    return;
  }
  self notifyonplayercommandremove("pullout_gc", "+smoke");
  self notify("geigercounter_take");
  _id_C8B79F6694C62EE8(-1.0);
}

_id_3D5C1674387C936E(grenade) {
  waitframe();

  if(isDefined(grenade))
    grenade delete();

  self notify("geigercounter_putaway");
  _id_CE0FEF2F2C7F1717();
}

_id_7E40241842784520() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("geigercounter_watchForDevicePullout");
  self endon("geigercounter_watchForDevicePullout");
  _id_C05958D616DDF1C5 = spawnStruct();
  childthread _id_9B3C029182BF2647(_id_C05958D616DDF1C5);
  childthread _id_F668EED31B686B60(_id_C05958D616DDF1C5);

  for(;;) {
    death = istrue(_id_C05958D616DDF1C5.death);
    take = istrue(_id_C05958D616DDF1C5.take);
    _id_4B47429F8D0D3EE5 = istrue(_id_C05958D616DDF1C5._id_4B47429F8D0D3EE5);

    if(death || take) {
      self notify("geigercounter_watchRaceEnd");
      return;
    }

    if(istrue(self.inlaststand)) {
      waitframe();
      continue;
    }

    if(!isDefined(self._id_BCB3E1F6F7CD3CB7))
      self._id_BCB3E1F6F7CD3CB7 = spawnStruct();

    _id_1DA8B97412F66D4B = 1;
    self._id_BCB3E1F6F7CD3CB7._id_E91C9347E638750D = _id_EFF6D6DB587F143D();

    if(isDefined(self._id_BCB3E1F6F7CD3CB7._id_E91C9347E638750D)) {
      _id_01E331291FA3BD60 = _id_296CAD0FB60AB083(self._id_BCB3E1F6F7CD3CB7._id_E91C9347E638750D);

      if(_id_4385C3A2905EEF3B(self, _id_01E331291FA3BD60)) {
        _id_1DA8B97412F66D4B = 0;
        _id_BCBFF1C1B64843B6(_id_01E331291FA3BD60);
      } else
        _id_1DA8B97412F66D4B = _id_F6AE22A0EF39407B();
    } else
      _id_1DA8B97412F66D4B = _id_F6AE22A0EF39407B();

    if(istrue(_id_1DA8B97412F66D4B))
      _id_C8B79F6694C62EE8(-1.0);

    waitframe();
  }
}

_id_F6AE22A0EF39407B() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("radiation", "radiation_isInit") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("radiation", "radiation_signedDistanceFromRadiationCircle")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("radiation", "radiation_isInit")]]()) {
      _id_7541C0EA78D6CDAF = [[scripts\cp_mp\utility\script_utility::getsharedfunc("radiation", "radiation_signedDistanceFromRadiationCircle")]](self.origin);

      if(_id_7541C0EA78D6CDAF < level._id_BCB3E1F6F7CD3CB7._id_7838030D3C23488E) {
        _id_BCBFF1C1B64843B6(99999999999);
        return 0;
      }
    }
  }

  return 1;
}

_id_BCBFF1C1B64843B6(dist) {
  if(getweaponbasename(self getheldoffhand()) == "geiger_counter_mp") {
    self._id_BCB3E1F6F7CD3CB7._id_4B47429F8D0D3EE5 = 1;
    self._id_BCB3E1F6F7CD3CB7._id_F458338F4188859E = _id_F6F6E00677F36E98(dist, self._id_BCB3E1F6F7CD3CB7._id_E91C9347E638750D);

    if(!isDefined(self._id_BCB3E1F6F7CD3CB7._id_7D4AF218F4963C47))
      self._id_BCB3E1F6F7CD3CB7._id_7D4AF218F4963C47 = 0.0;

    if(isDefined(self._id_BCB3E1F6F7CD3CB7._id_E91C9347E638750D)) {
      object = self._id_BCB3E1F6F7CD3CB7._id_E91C9347E638750D;

      if(isDefined(object._id_9D4873A013FB19AB) && isDefined(self.team) && !scripts\engine\utility::array_contains(object._id_F967E4DE0363EA83, self.team)) {
        _id_3C141DF65714D228 = object._id_44C91F16317BB5C2;

        if(!isDefined(_id_3C141DF65714D228) || isDefined(_id_3C141DF65714D228) && _id_3C141DF65714D228 <= 1.4 - self._id_BCB3E1F6F7CD3CB7._id_F458338F4188859E) {
          scripts\cp_mp\challenges::_id_8359CADD253F9604(self, object._id_9D4873A013FB19AB, 1);
          object._id_F967E4DE0363EA83[object._id_F967E4DE0363EA83.size] = self.team;
        }
      }
    }

    _id_C8B79F6694C62EE8(clamp(1.4 - self._id_BCB3E1F6F7CD3CB7._id_F458338F4188859E, 0.0, 1.4));

    if(self._id_BCB3E1F6F7CD3CB7._id_7D4AF218F4963C47 >= self._id_BCB3E1F6F7CD3CB7._id_F458338F4188859E) {
      _id_018AD59D3ABD30F4();
      self._id_BCB3E1F6F7CD3CB7._id_7D4AF218F4963C47 = 0;
    }

    self._id_BCB3E1F6F7CD3CB7._id_7D4AF218F4963C47 = self._id_BCB3E1F6F7CD3CB7._id_7D4AF218F4963C47 + level.framedurationseconds;
  } else
    _id_C8B79F6694C62EE8(-0.25);
}

_id_A9D03825299DD6BF() {
  if(getweaponbasename(self getheldoffhand()) == "geiger_counter_mp")
    return 1;

  return 0;
}

_id_9B3C029182BF2647(_id_C05958D616DDF1C5) {
  self endon("geigercounter_watchRaceEnd");
  self waittill("death");
  _id_C05958D616DDF1C5.death = 1;
  self notify("geigercounter_watchRaceStart");
}

_id_F668EED31B686B60(_id_C05958D616DDF1C5) {
  self endon("geigercounter_watchRaceEnd");
  self waittill("geigercounter_take");
  _id_C05958D616DDF1C5.take = 1;
  self notify("geigercounter_watchRaceStart");
}

_id_841D127CB52727A9(_id_C05958D616DDF1C5) {
  self endon("geigercounter_watchRaceEnd");
  self waittill("pullout_gc", weapon);

  for(;;) {
    if(getweaponbasename(self getheldoffhand()) == "geiger_counter_mp") {
      break;
    }
  }

  _id_C05958D616DDF1C5._id_4B47429F8D0D3EE5 = 1;
  self notify("geigercounter_watchRaceStart");
}

_id_B33A67426542B0C5(_id_C05958D616DDF1C5) {
  self endon("geigercounter_watchRaceEnd");

  for(;;) {
    if(getweaponbasename(self getheldoffhand()) == "geiger_counter_mp") {
      break;
    }
  }

  _id_C05958D616DDF1C5._id_69B82C8E2D0CF148 = 1;
  self notify("geigercounter_watchRaceEnd");
}

_id_CE0FEF2F2C7F1717() {
  self notify("geigercounter_putaway");

  if(isDefined(self._id_BCB3E1F6F7CD3CB7)) {
    self._id_BCB3E1F6F7CD3CB7._id_4B47429F8D0D3EE5 = undefined;
    self._id_BCB3E1F6F7CD3CB7 = undefined;
    _id_5600972DE1B79706();
    _id_C5211DEB59BC819A();
  }
}

_id_27B913C5A2199F7F() {
  return isDefined(self._id_BCB3E1F6F7CD3CB7) && istrue(self._id_BCB3E1F6F7CD3CB7._id_4B47429F8D0D3EE5);
}

_id_C5211DEB59BC819A() {
  self setclientomnvar("ui_geigercounter_meter", 0);
}

_id_7842C49C4D21BD5B(data) {
  self setclientomnvar("ui_geigercounter_meter", data);
}

_id_018AD59D3ABD30F4() {
  self playlocalsound("iw9_geiger_counter_tick");
}

_id_5600972DE1B79706() {
  self stoplocalsound("iw9_geiger_counter_tick");
}

_id_C8B79F6694C62EE8(_id_17B73AA1820974EE) {
  if(isDefined(_id_17B73AA1820974EE))
    _id_7842C49C4D21BD5B(_id_17B73AA1820974EE);
  else
    _id_7842C49C4D21BD5B(self._id_BCB3E1F6F7CD3CB7._id_F458338F4188859E);
}

_id_F0D61E14DFDE9CCD(object) {
  level._id_BCB3E1F6F7CD3CB7._id_2B6807C7DF9A2B2D scripts\engine\utility::_id_24BBEFB4BEDA630D(object);
}

_id_A67007B5AF86FF0B(object) {
  level._id_BCB3E1F6F7CD3CB7._id_2B6807C7DF9A2B2D scripts\engine\utility::_id_9CD3F5F067AFEA37(object);
}

_id_38C53210A5291D71(object) {
  if(!isDefined(object))
    return 0;

  if(!isstruct(object)) {
    if(!isent(object) && object _meth_73CC0F04C4C5001D() && object getscriptablehaspart("brloot_valuable_fuelrods") && object getscriptablepartstate("brloot_valuable_fuelrods", 1) == "hidden")
      return 1;
  }

  return 0;
}

_id_EFF6D6DB587F143D() {
  object = level._id_BCB3E1F6F7CD3CB7._id_2B6807C7DF9A2B2D scripts\engine\utility::_id_60DBE20F8385F1B0(self.origin);

  while(_id_38C53210A5291D71(object)) {
    _id_A67007B5AF86FF0B(object);
    object = level._id_BCB3E1F6F7CD3CB7._id_2B6807C7DF9A2B2D scripts\engine\utility::_id_60DBE20F8385F1B0(self.origin);

    if(!isDefined(object))
      return undefined;
  }

  return object;
}

_id_296CAD0FB60AB083(_id_476BA0CAD41D3B92) {
  _id_5D1A77C029C6A066 = _id_476BA0CAD41D3B92.origin;
  _id_01E331291FA3BD60 = distancesquared(_id_5D1A77C029C6A066, self.origin);
  return _id_01E331291FA3BD60;
}

_id_4385C3A2905EEF3B(player, _id_01E331291FA3BD60) {
  return _id_01E331291FA3BD60 < 16000000;
}

_id_F6F6E00677F36E98(_id_01E331291FA3BD60, object) {
  self notify("_geigercounter_calculateGeigerCounterPulseRate");
  self endon("_geigercounter_calculateGeigerCounterPulseRate");
  self endon("disconnect");
  _id_9068CB3A62D2CCD4 = 0.1;
  _id_704A30A3B4461E92 = lookupsoundlength("iw9_geiger_counter_tick") / 1000;
  _id_395712E8D9AD1D10 = 1.4;
  _id_636C8575D7A7768B = 0;
  maxdist = 4000;
  dist = sqrt(_id_01E331291FA3BD60);
  waittime = _id_704A30A3B4461E92;
  _id_ED5F1E37B41969E0 = _id_704A30A3B4461E92;
  _id_406567975EAD0D9A = _id_704A30A3B4461E92;
  _id_488D4C5202017ACD = 0;
  _id_E1A6796D6725E569 = clamp(-1.0 * ((dist - _id_636C8575D7A7768B) / (maxdist - _id_636C8575D7A7768B)) + 1.0, 0.0, 1.0);
  _id_96CE362A2E74A8E2 = 0.0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("radiation", "radiation_isInit") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("radiation", "radiation_signedDistanceFromRadiationCircle")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("radiation", "radiation_isInit")]]()) {
      _id_7541C0EA78D6CDAF = [[scripts\cp_mp\utility\script_utility::getsharedfunc("radiation", "radiation_signedDistanceFromRadiationCircle")]](self.origin);
      _id_50DC5744A73EAA32 = _id_7541C0EA78D6CDAF <= 0.0;

      if(_id_50DC5744A73EAA32)
        _id_96CE362A2E74A8E2 = 1.0;
      else
        _id_96CE362A2E74A8E2 = clamp(-1.0 * (_id_7541C0EA78D6CDAF / level._id_BCB3E1F6F7CD3CB7._id_7838030D3C23488E) + 1.0, 0.0, 1.0);
    }
  }

  _id_63783FA82077E962 = 0.0;

  if(isDefined(object)) {
    _id_70222FBC47330166 = anglesToForward(self getplayerangles());
    _id_4712089F9A28931D = vectorNormalize(object.origin - self.origin);
    _id_FCE87949C9B65851 = vectordot(_id_70222FBC47330166, _id_4712089F9A28931D);
    _id_63783FA82077E962 = clamp(20.0 * _id_E1A6796D6725E569, 0.0, 1.0) * (_id_FCE87949C9B65851 + 1.0) / 2.0;
  }

  _id_488D4C5202017ACD = clamp(_id_E1A6796D6725E569 * 0.8 + _id_63783FA82077E962 * 0.2 + _id_96CE362A2E74A8E2 * 1.0, 0.0, 1.0);
  waittime = (-1.0 * _id_488D4C5202017ACD + 1) * _id_395712E8D9AD1D10;
  return waittime;
}