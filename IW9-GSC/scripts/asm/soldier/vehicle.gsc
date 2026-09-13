/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\vehicle.gsc
***********************************************/

setvehiclearchetype(asmname, statename, params) {
  self setoverridearchetype("vehicle", self._blackboard.currentvehicleanimalias, 1);
}

clearvehiclearchetype(asmname, statename, params) {
  self clearoverridearchetype("vehicle", 0, 1);
}

_id_35BAEB62E712B6B4(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!isDefined(self._blackboard.currentvehicle))
    return 1;

  _id_A7F05F87335B6C63 = distancesquared(self.origin, self._blackboard.currentvehicle.origin);

  if(_id_A7F05F87335B6C63 > 50000)
    return 0;

  return 1;
}

_id_B3BB4D116F5A79CB(currentvehicle, position) {
  if(isDefined(currentvehicle)) {
    aianims = scripts\common\vehicle_aianim::anim_pos(currentvehicle, position);

    if(isDefined(aianims._id_8AF43E63A663DBD6) && istrue(aianims._id_8AF43E63A663DBD6))
      return 1;
  }

  return 0;
}

_id_EF715D817B10B063(aianims) {
  alias = "";

  if(istrue(aianims._id_8DBB2562EC7AB3ED))
    alias = alias + "_4";
  else
    alias = alias + "_6";

  if(isDefined(self.enemy)) {
    _id_9001DA663C7CDFEC = self.enemy.origin - self.origin;
    _id_E5FADE7863F125E7 = angleclamp180(vectortoyaw(_id_9001DA663C7CDFEC) - self.angles[1]);

    if(_id_E5FADE7863F125E7 < 0)
      alias = alias + "_turn6";
    else
      alias = alias + "_turn4";
  } else if(istrue(aianims._id_8DBB2562EC7AB3ED))
    alias = alias + "_turn4";
  else
    alias = alias + "_turn6";

  return alias;
}

_id_AD6244629719D941(aianims) {
  alias = "";

  if(_id_B3BB4D116F5A79CB(self._blackboard.currentvehicle, self._blackboard._id_9176CAE5619D7FBA)) {
    if(aianims._id_8DBB2562EC7AB3ED)
      alias = alias + "_4";
    else
      alias = alias + "_6";
  }

  flashed = scripts\engine\utility::isflashed();

  if(isDefined(self.damageyaw) && !flashed) {
    if(self.damageyaw > 135)
      alias = alias + "_2";
    else if(self.damageyaw > 45)
      alias = alias + "_4";
    else if(self.damageyaw > -45)
      alias = alias + "_8";
    else if(self.damageyaw > -135)
      alias = alias + "_6";
    else
      alias = alias + "_2";
  }

  if(istrue(self._id_58E8388F04ABB64E))
    alias = alias + "_lean";

  return alias;
}

_id_37DA44A7CF24FDAD(aianims) {
  alias = "";

  if(_id_B3BB4D116F5A79CB(self._blackboard.currentvehicle, self._blackboard._id_9176CAE5619D7FBA)) {
    if(aianims._id_8DBB2562EC7AB3ED)
      alias = alias + "_4";
    else
      alias = alias + "_6";
  }

  if(istrue(self._id_58E8388F04ABB64E))
    alias = alias + "_lean";

  return alias;
}

chooseanim_vehicle(asmname, statename, params) {
  return scripts\asm\asm::asm_lookupanimfromalias(statename, scripts\engine\utility::string(self._blackboard._id_9176CAE5619D7FBA));
}

_id_93584FE710642BD2(asmname, statename, params) {
  _id_38548703EA2BDADC = self._blackboard.currentvehicleanimalias;
  alias = scripts\engine\utility::string(self._blackboard._id_9176CAE5619D7FBA);

  if(isDefined(self._blackboard.currentvehicle)) {
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard._id_9176CAE5619D7FBA;
    aianims = scripts\common\vehicle_aianim::anim_pos(vehicle, position);
    alias = alias + _id_AD6244629719D941(aianims);
  }

  _id_0EABF81B5BE8DDB5 = archetypegetrandomalias(_id_38548703EA2BDADC, statename, alias, scripts\asm\asm::asm_isfrantic());

  if(isDefined(_id_0EABF81B5BE8DDB5))
    return scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
  else
    return scripts\asm\asm::asm_lookupanimfromalias(statename, scripts\engine\utility::string(self._blackboard._id_9176CAE5619D7FBA));
}

_id_47A713AA81F9AE9E(asmname, statename, params) {
  _id_38548703EA2BDADC = self._blackboard.currentvehicleanimalias;
  alias = scripts\engine\utility::string(self._blackboard._id_9176CAE5619D7FBA);

  if(isDefined(self._blackboard.currentvehicle)) {
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard._id_9176CAE5619D7FBA;
    aianims = scripts\common\vehicle_aianim::anim_pos(vehicle, position);
    alias = alias + _id_37DA44A7CF24FDAD(aianims);
  }

  return scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
}

_id_179D01A77DC31F73(alias) {
  _id_9001DA663C7CDFEC = self.enemy.origin - self.origin;
  _id_E5FADE7863F125E7 = angleclamp180(vectortoyaw(_id_9001DA663C7CDFEC) - self.angles[1]);

  if(_id_E5FADE7863F125E7 > 135)
    alias = alias + "_2";
  else if(_id_E5FADE7863F125E7 > 45)
    alias = alias + "_4";
  else if(_id_E5FADE7863F125E7 > -45)
    alias = alias + "_8";
  else if(_id_E5FADE7863F125E7 > -135)
    alias = alias + "_6";
  else
    alias = alias + "_2";

  return alias;
}

_id_5B4B5FFFAC712ED5(asmname, statename, params) {
  alias = scripts\engine\utility::string(self._blackboard._id_9176CAE5619D7FBA);

  if(_id_B3BB4D116F5A79CB(self._blackboard.currentvehicle, self._blackboard._id_9176CAE5619D7FBA)) {
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard._id_9176CAE5619D7FBA;
    aianims = scripts\common\vehicle_aianim::anim_pos(vehicle, position);

    if(aianims._id_8DBB2562EC7AB3ED)
      alias = alias + "_4";
    else
      alias = alias + "_6";
  }

  alias = _id_179D01A77DC31F73(alias);
  return scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
}

_id_9CC47D66814E0219(asmname, statename, params) {
  alias = scripts\engine\utility::string(self._blackboard._id_9176CAE5619D7FBA);

  if(_id_B3BB4D116F5A79CB(self._blackboard.currentvehicle, self._blackboard._id_9176CAE5619D7FBA)) {
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard._id_9176CAE5619D7FBA;
    aianims = scripts\common\vehicle_aianim::anim_pos(vehicle, position);

    if(aianims._id_8DBB2562EC7AB3ED)
      alias = alias + "_4";
    else
      alias = alias + "_6";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
}

_id_71542E68D0FA0478(asmname, statename, params) {
  return chooseanim_vehicle(asmname, statename, params);
}

_id_B2E6831F01246042(asmname, statename, params) {
  alias = scripts\engine\utility::string(self._blackboard._id_9176CAE5619D7FBA);
  vehicle = self._blackboard.currentvehicle;
  position = self._blackboard._id_9176CAE5619D7FBA;
  aianims = scripts\common\vehicle_aianim::anim_pos(vehicle, position);

  if(isDefined(aianims._id_8DBB2562EC7AB3ED)) {
    _id_019F92FA83D7CD69 = _id_EF715D817B10B063(aianims);
    alias = alias + _id_019F92FA83D7CD69;
    aianims._id_8DBB2562EC7AB3ED = !aianims._id_8DBB2562EC7AB3ED;
  }

  return scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
}

_id_7F09702CF0B2E4B5(asmname, statename, params) {
  alias = scripts\engine\utility::string(self._blackboard._id_9176CAE5619D7FBA);

  if(_id_B3BB4D116F5A79CB(self._blackboard.currentvehicle, self._blackboard._id_9176CAE5619D7FBA)) {
    if(isDefined(self.enemy)) {
      vehicle = self._blackboard.currentvehicle;
      position = self._blackboard._id_9176CAE5619D7FBA;
      aianims = scripts\common\vehicle_aianim::anim_pos(vehicle, position);
      _id_A33650E1C3AD7920 = self.enemy.origin - vehicle.origin;
      _id_B948350EE67E31FB = angleclamp180(vectortoyaw(_id_A33650E1C3AD7920) - vehicle.angles[1]);

      if(_id_B948350EE67E31FB < 0)
        alias = alias + "_6";
      else
        alias = alias + "_4";

      if(isDefined(aianims._id_8DBB2562EC7AB3ED) && (_id_B948350EE67E31FB < 0 && aianims._id_8DBB2562EC7AB3ED || _id_B948350EE67E31FB > 0 && !aianims._id_8DBB2562EC7AB3ED))
        aianims._id_8DBB2562EC7AB3ED = !aianims._id_8DBB2562EC7AB3ED;
    }
  }

  return scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
}

_id_F96DCCE7D9CC58A5(asmname, statename, params) {
  if(_id_B3BB4D116F5A79CB(self._blackboard.currentvehicle, self._blackboard._id_9176CAE5619D7FBA)) {
    vehicle = self._blackboard.currentvehicle;

    if(isDefined(vehicle._id_C4EC8708D1CBA967) && isDefined(vehicle._id_C50F7508D1F1C989))
      self._id_5C7A1CD1128675F5 = gettime() + randomintrange(vehicle._id_C4EC8708D1CBA967, vehicle._id_C50F7508D1F1C989);
  }

  return _id_9CC47D66814E0219(asmname, statename, params);
}

_id_6FD8668B4581EF1C(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!isDefined(self._blackboard.currentvehicle))
    return 0;

  if(!_id_B3BB4D116F5A79CB(self._blackboard.currentvehicle, self._blackboard._id_9176CAE5619D7FBA))
    return 0;

  if(!isDefined(self.enemy))
    return 0;

  if(!isDefined(self._blackboard._id_9176CAE5619D7FBA) || !isDefined(self._blackboard.currentvehicle))
    return 0;

  vehicle = self._blackboard.currentvehicle;
  position = self._blackboard._id_9176CAE5619D7FBA;
  aianims = scripts\common\vehicle_aianim::anim_pos(vehicle, position);
  _id_A33650E1C3AD7920 = self.enemy.origin - vehicle.origin;
  _id_B948350EE67E31FB = angleclamp180(vectortoyaw(_id_A33650E1C3AD7920) - vehicle.angles[1]);

  if(abs(_id_B948350EE67E31FB) > 179 || abs(_id_B948350EE67E31FB) < 1)
    return 0;

  if(isDefined(aianims._id_8DBB2562EC7AB3ED) && (_id_B948350EE67E31FB < 0 && aianims._id_8DBB2562EC7AB3ED || _id_B948350EE67E31FB > 0 && !aianims._id_8DBB2562EC7AB3ED))
    return 1;

  return 0;
}

_id_E692591195808B8A(asmname, statename, _id_F2B19B25D457C2A6, param) {
  return vehiclehasalias(asmname, statename, _id_F2B19B25D457C2A6, param) && self[[self.fnisinstealthidle]]();
}

_id_6BC1A54175023072(asmname, statename, _id_F2B19B25D457C2A6, param) {
  return self[[self.fnisinstealthidle]]();
}

_id_5CFC1F1B9C10E164(asmname, statename, _id_F2B19B25D457C2A6, param) {
  return vehiclehasalias(asmname, statename, _id_F2B19B25D457C2A6, param) && self[[self.fnisinstealthcombat]]();
}

vehicleincombat(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(weaponclass(self.weapon) == "rocketlauncher" && !istrue(self._id_76DDDEEF63852FDA))
    return 0;

  return scripts\asm\asm::asm_getdemeanor() == "combat" && !self[[self.fnisinstealthhunt]]();
}

_id_222EF5B005C37D77(asmname, statename, _id_F2B19B25D457C2A6, param) {
  if(!isDefined(self._blackboard.currentvehicle))
    return 0;

  if(!_id_B3BB4D116F5A79CB(self._blackboard.currentvehicle, self._blackboard._id_9176CAE5619D7FBA))
    return 0;

  vehicle = self._blackboard.currentvehicle;

  if(!isDefined(vehicle._id_C4EC8708D1CBA967) || !isDefined(vehicle._id_C50F7508D1F1C989))
    return 0;

  if(!isDefined(self._id_5C7A1CD1128675F5))
    self._id_5C7A1CD1128675F5 = gettime() + randomintrange(vehicle._id_C4EC8708D1CBA967, vehicle._id_C50F7508D1F1C989);

  if(gettime() > self._id_5C7A1CD1128675F5) {
    self._id_5C7A1CD1128675F5 = gettime() + randomintrange(vehicle._id_C4EC8708D1CBA967, vehicle._id_C50F7508D1F1C989);
    return 1;
  }

  return 0;
}

_id_925C10BFB5DB43D0(asmname, statename, _id_F2B19B25D457C2A6, param) {
  if(!isDefined(self._blackboard.currentvehicle) || !isDefined(self._blackboard.currentvehicle._id_DF380F11ABA27F75))
    return 0;

  if(!isDefined(self.enemy))
    return 0;

  aianims = scripts\common\vehicle_aianim::anim_pos(self._blackboard.currentvehicle, self._blackboard._id_9176CAE5619D7FBA);
  _id_5345A5D80B9177ED = gettime() > self._blackboard.currentvehicle._id_DF380F11ABA27F75 || istrue(aianims._id_B6CFB5B21C28C002);

  if(_id_1746AD7C74EAD3E8(asmname, statename, _id_F2B19B25D457C2A6, param) && _id_5345A5D80B9177ED) {
    self._blackboard.currentvehicle._id_DF380F11ABA27F75 = gettime() + self._blackboard.currentvehicle._id_13B94E70465E220D;
    return 1;
  }

  return 0;
}

_id_1EF6637EA6BF8C1F(asmname, statename, _id_F2B19B25D457C2A6, param) {
  return vehiclehasalias(asmname, statename, _id_F2B19B25D457C2A6, param) && scripts\asm\asm_bb::bb_iswhizbyrequested();
}

_id_D4533DCC81147462(asmname, statename, param) {
  alias = scripts\engine\utility::string(self._blackboard._id_9176CAE5619D7FBA);

  if(isDefined(archetypegetrandomalias(self._blackboard.currentvehicleanimalias, statename, alias, scripts\asm\asm::asm_isfrantic())))
    return scripts\asm\asm::asm_lookupanimfromalias(statename, alias);

  alias = alias + "_" + self._blackboard._id_B79347F04F2C0672;
  vehicle = self._blackboard.currentvehicle;
  forward = anglesToForward(vehicle.angles);
  normal = self._id_FBE92F71B3BAB094.normal;
  _id_535F605646D65A4D();
  _id_8A4D4017EAB53AB6 = 0.70711;
  _id_CDB7A0EF79EB2457 = vectordot(forward, normal);

  if(_id_CDB7A0EF79EB2457 > _id_8A4D4017EAB53AB6) {
    alias = alias + "_2";
    return scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
  } else if(_id_CDB7A0EF79EB2457 < -1 * _id_8A4D4017EAB53AB6) {
    alias = alias + "_8";
    return scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
  }

  _id_82623B1112D975B4 = vectorcross(forward, normal);

  if(_id_82623B1112D975B4[2] > 0.0) {
    alias = alias + "_6";
    return scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
  }

  alias = alias + "_4";
  return scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
}

_id_03A547F046D6592A(asmname, statename, params) {
  _id_38548703EA2BDADC = self._blackboard.currentvehicleanimalias;
  alias = scripts\engine\utility::string(self._blackboard._id_9176CAE5619D7FBA);

  if(_id_B3BB4D116F5A79CB(self._blackboard.currentvehicle, self._blackboard._id_9176CAE5619D7FBA)) {
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard._id_9176CAE5619D7FBA;
    aianims = scripts\common\vehicle_aianim::anim_pos(vehicle, position);

    if(aianims._id_8DBB2562EC7AB3ED)
      alias = alias + "_4";
    else
      alias = alias + "_6";
  } else if(isDefined(self._blackboard._id_B79347F04F2C0672) && self._blackboard._id_B79347F04F2C0672 != 8)
    alias = alias + "_" + self._blackboard._id_B79347F04F2C0672;

  _id_7D9D8A88D65590D1 = "_" + weaponclass(self.weapon);
  _id_FDC520E439FFB47C = archetypegetrandomalias(_id_38548703EA2BDADC, statename, alias + _id_7D9D8A88D65590D1, scripts\asm\asm::asm_isfrantic());

  if(isDefined(_id_FDC520E439FFB47C))
    return scripts\asm\asm::asm_lookupanimfromalias(statename, alias + _id_7D9D8A88D65590D1);
  else {
    _id_0EABF81B5BE8DDB5 = archetypegetrandomalias(_id_38548703EA2BDADC, statename, alias, scripts\asm\asm::asm_isfrantic());

    if(isDefined(_id_0EABF81B5BE8DDB5))
      return scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
    else {
      _id_FDC520E439FFB47C = archetypegetrandomalias(_id_38548703EA2BDADC, statename, scripts\engine\utility::string(self._blackboard._id_9176CAE5619D7FBA) + _id_7D9D8A88D65590D1, scripts\asm\asm::asm_isfrantic());

      if(isDefined(_id_FDC520E439FFB47C))
        return scripts\asm\asm::asm_lookupanimfromalias(statename, scripts\engine\utility::string(self._blackboard._id_9176CAE5619D7FBA) + _id_7D9D8A88D65590D1);
      else
        return scripts\asm\asm::asm_lookupanimfromalias(statename, scripts\engine\utility::string(self._blackboard._id_9176CAE5619D7FBA));
    }
  }
}

chooseanim_vehicleturret(asmname, statename, params) {
  return scripts\asm\asm::asm_lookupanimfromalias(statename, "blank");
}

chooseanim_vehicleturretdeath(asmname, statename, params) {
  return scripts\asm\asm::asm_lookupanimfromalias(statename, "vehicle_turret_death");
}

getvehicleanimtargetoriginandangles(vehicle, _id_DE99D908F027883A, _id_CBFBB4EFA1348391, _id_7661FCE9997CC9A4, _id_9DFDF50ED960E7F3, _id_47B4BDC915CFF70D) {
  result = [];

  if(!isDefined(_id_47B4BDC915CFF70D))
    _id_47B4BDC915CFF70D = 1.0;

  if(isDefined(vehicle) && isDefined(_id_CBFBB4EFA1348391)) {
    tagorigin = vehicle gettagorigin(_id_CBFBB4EFA1348391);
    _id_A43B0202C06E0907 = vehicle gettagangles(_id_CBFBB4EFA1348391);
    startorigin = getstartorigin(tagorigin, _id_A43B0202C06E0907, _id_DE99D908F027883A);
    startangles = getstartangles(tagorigin, _id_A43B0202C06E0907, _id_DE99D908F027883A);
    movedelta = getmovedelta(_id_DE99D908F027883A, 0.0, _id_47B4BDC915CFF70D);
    anglesdelta = getangledelta3d(_id_DE99D908F027883A, 0.0, _id_47B4BDC915CFF70D)[1];
    result["startOrigin"] = startorigin;
    result["startAngles"] = startangles;
    result["targetOrigin"] = rotatevector(movedelta, startangles) + startorigin;
    result["targetAngles"] = (startangles[0], angleclamp(startangles[1] + anglesdelta), startangles[2]);
  } else {
    result["startOrigin"] = self.origin;
    result["startAngles"] = self.angles;
    result["targetOrigin"] = _id_7661FCE9997CC9A4;
    result["targetAngles"] = _id_9DFDF50ED960E7F3;
  }

  return result;
}

linktovehicle(org, _id_8BC14603A27FA3E7, linktoblend, sittag) {
  self forceteleport(org, _id_8BC14603A27FA3E7);

  if(istrue(linktoblend))
    self linktoblendtotag(self._blackboard.currentvehicle, sittag, 0);
  else {
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard._id_9176CAE5619D7FBA;
    aianims = scripts\common\vehicle_aianim::anim_pos(vehicle, position);

    if(isDefined(aianims.linkoffset) && isDefined(aianims._id_03630FFA8EDAFEF8))
      self linktomoveoffset(self._blackboard.currentvehicle, sittag, aianims.linkoffset, aianims._id_03630FFA8EDAFEF8);
    else
      self linktomoveoffset(self._blackboard.currentvehicle, sittag, (0, 0, 0), (0, 0, 0));
  }

  vehicle = self._blackboard.currentvehicle;
  position = self._blackboard._id_9176CAE5619D7FBA;

  if(isDefined(vehicle) && isDefined(position)) {
    aianims = scripts\common\vehicle_aianim::anim_pos(vehicle, position);

    if(isDefined(aianims._id_8DBB2562EC7AB3ED) && isDefined(aianims._id_FD77F04C5BD828BC))
      aianims._id_8DBB2562EC7AB3ED = aianims._id_FD77F04C5BD828BC;
  }

  if(isagent(self)) {
    self playerlinkedoffsetenable();
    self fixlinktointerpolationbug(1);
  }

  self._blackboard.linkedtovehicle = 1;
}

faceenemyincombat(asmname, statename) {
  self endon(statename + "_finished");

  for(;;) {
    canshootinvehicle = istrue(self._blackboard._id_6A69FA6B0B354C93) && istrue(self.canshootinvehicle);
    _id_48000663B117F7A6 = isDefined(self._blackboard.currentvehicle) && !istrue(self._blackboard.currentvehicle.vehicledisableturningwhileshooting);
    _id_8C0E7B4F9142B8A4 = isDefined(self.enemy) && (!(isPlayer(self.enemy) || isai(self.enemy)) || isalive(self.enemy));
    _id_046ABBA9D70107BE = vehicleincombat(asmname, statename, statename);

    if(_id_046ABBA9D70107BE && _id_8C0E7B4F9142B8A4 && canshootinvehicle && _id_48000663B117F7A6) {
      axis = anglestoaxis(self._blackboard.currentvehicle.angles);
      forward = axis["forward"];
      up = axis["up"];
      yaw = scripts\engine\utility::getyaw(self.enemy.origin) - self._blackboard.currentvehicle.angles[1];
      yaw = angleclamp180(yaw);
      _id_9D142161A92F87D3 = rotatepointaroundvector(up, forward, yaw);
      _id_179A55CD72DDBAD8 = axistoangles(_id_9D142161A92F87D3, vectorcross(_id_9D142161A92F87D3, up), up);
      self orientmode("face angle 3d", _id_179A55CD72DDBAD8);
    } else
      self orientmode("face current angles");

    waitframe();
  }
}

playanim_vehicleidle(asmname, statename, params) {
  self endon(statename + "_finished");
  self.leftaimlimit = 180;
  self.rightaimlimit = -180;
  self.aimyawspeed = 108;
  setvehiclearchetype();

  if(!istrue(self._blackboard.linkedtovehicle) && isDefined(self._blackboard.currentvehicle)) {
    _id_917B4946225E8ABA = scripts\asm\asm::asm_getanim(asmname, "vehicle_idle");
    _id_0E3FE8E8FA41EFB4 = scripts\asm\asm::asm_getxanim("vehicle_idle", _id_917B4946225E8ABA);
    self.asm.targetvalues = getvehicleanimtargetoriginandangles(self._blackboard.currentvehicle, _id_0E3FE8E8FA41EFB4, self._blackboard._id_1745D2B69C72C627, self._blackboard._id_D59400D26AEE998E, self._blackboard._id_A3111C437379D9E9);
    linktovehicle(self.asm.targetvalues["targetOrigin"], self.asm.targetvalues["targetAngles"], self._blackboard._id_F6D06D1E68F4F4E5, self._blackboard._id_1745D2B69C72C627);
  }

  self animmode("nogravity");
  self orientmode("face current angles");
  animindex = scripts\asm\asm::asm_getanim(asmname, statename);
  self aisetanim(statename, animindex);
  scripts\asm\asm::asm_donotetracks(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename));
}

_id_7D994706653F02B4(asmname, statename, params) {
  self endon("death");
  self endon(statename + "_finished");
  _id_767A8707BDC87A4E = randomfloatrange(0.0, 1.25);
  wait(_id_767A8707BDC87A4E);
  setvehiclearchetype();
  scripts\asm\asm::asm_playanimstate(asmname, statename, params);
}

_id_E985E877247D21E9(asmname, statename, params) {
  setvehiclearchetype();
  scripts\asm\soldier\pain::playpainanim(asmname, statename, params);
}

_id_3CB7671EF707BC14(asmname, statename, params) {
  setvehiclearchetype();
  scripts\asm\soldier\pain::playanim_flashed(asmname, statename, params);
}

vehicleturretshootthread(turret) {
  self endon("death");
  self endon("stop_shooting");
  turret startfiring();
  turret scripts\engine\utility::self_func("SetAISpread", 2);
  turret setmode("manual");
  self linktoblendtotag(turret, "tag_gunner", 0);
  _id_545FCAA06CEA9A1B = 0;
  _id_E787B215E9FD1517 = 2;

  for(;;) {
    if(isDefined(self.enemy)) {
      turret settargetentity(self.enemy);
      turret waittill("turret_on_target");
      burst = randomintrange(12, 18);
      _id_58E50AEE46852766 = 0;
      _id_3746EC1BEFD86AE8 = randomintrange(7, 12);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < burst; _id_AC0E594AC96AA3A8++) {
        _id_58E50AEE46852766++;
        turret shootturret();
        wait 0.05;

        if(randomint(100) < 25)
          wait(randomfloatrange(0.1, 0.2));

        target = turret getturrettarget(0);

        if(isDefined(target) && isPlayer(target) && _id_545FCAA06CEA9A1B < _id_E787B215E9FD1517 && target.health < 60) {
          _id_545FCAA06CEA9A1B++;
          wait 3;
        }

        if(_id_58E50AEE46852766 > _id_3746EC1BEFD86AE8) {
          if(isDefined(target) && issentient(target) && !isalive(target)) {
            break;
          }
        }
      }
    } else
      turret cleartargetentity();

    wait(0.8 + randomfloat(1));
  }
}

playanim_vehicleturret(asmname, statename, params) {
  self endon(statename + "_finished");

  if(isDefined(self._blackboard.currentvehicle.mgturret[0]) && !istrue(self._blackboard.currentvehicle.mgturret[0]._id_9A120B82CC83C49E)) {
    self useturret(self._blackboard.currentvehicle.mgturret[0]);

    if(isDefined(self._blackboard.currentvehicle._id_3F8BA6301EE08FF0))
      self._blackboard.currentvehicle thread[[self._blackboard.currentvehicle._id_3F8BA6301EE08FF0]]();
    else
      thread vehicleturretshootthread(self._blackboard.currentvehicle.mgturret[0]);

    self._blackboard.currentvehicle.mgturret[0]._id_9A120B82CC83C49E = 1;
  }

  setvehiclearchetype();
  self animmode("nogravity");
  self orientmode("face current angles");
  animindex = scripts\asm\asm::asm_getanim(asmname, statename);
  self aisetanim(statename, animindex);
  scripts\asm\asm::asm_donotetracks(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename));
}

playanim_vehicleturret_terminate(asmname, statename, params) {
  clearvehiclearchetype();
  self stopuseturret();

  if(isDefined(self._blackboard.currentvehicle) && isDefined(self._blackboard.currentvehicle.mgturret)) {
    if(isDefined(self._blackboard.currentvehicle.mgturret[0])) {
      self._blackboard.currentvehicle.mgturret[0] cleartargetentity();
      self._blackboard.currentvehicle.mgturret[0] setmode("manual");
    }
  }
}

rotatetocurrentangles() {
  self endon("death");
  self endon("EndVehicleMotionWarp");
  self endon("EndRotateToCurrentAngles");

  for(;;) {
    self orientmode("face angle 3d", self.angles);
    waitframe();
  }
}

enterexitvehiclemotionwarp(asmname, statename, xanim, _id_CBFBB4EFA1348391, exiting, _id_D1B180EE30493E0B) {
  if(isPlayer(self))
    self endon("death_or_disconnect");
  else
    self endon("death");

  self endon("EndVehicleMotionWarp");
  animlength = getanimlength(xanim);
  _id_67B5A24409D655F0 = 0.0;
  _id_B9460E0CB9B449A3 = undefined;

  if(animhasnotetrack(xanim, "motion_warp_begin")) {
    _id_67B5A24409D655F0 = getnotetracktimes(xanim, "motion_warp_begin")[0];
    _id_B9460E0CB9B449A3 = "motion_warp_begin";
  }

  _id_47B4BDC915CFF70D = 1.0;
  endnote = undefined;

  if(animhasnotetrack(xanim, "motion_warp_end")) {
    _id_47B4BDC915CFF70D = getnotetracktimes(xanim, "motion_warp_end")[0];
    endnote = "motion_warp_end";
  }

  animindex = scripts\asm\asm::asm_getanim(asmname, statename);
  waittime = animlength * _id_67B5A24409D655F0;

  if(exiting) {
    if(isDefined(self._blackboard._id_E5EC3A6AFD92645D))
      thread rotatetocurrentangles();
    else {
      if(isDefined(_id_D1B180EE30493E0B))
        self.asm.targetvalues = getvehicleanimtargetoriginandangles(self._blackboard.currentvehicle, _id_D1B180EE30493E0B, _id_CBFBB4EFA1348391, self._blackboard._id_D59400D26AEE998E, self._blackboard._id_A3111C437379D9E9, _id_47B4BDC915CFF70D);
      else
        self.asm.targetvalues = getvehicleanimtargetoriginandangles(self._blackboard.currentvehicle, xanim, _id_CBFBB4EFA1348391, self._blackboard._id_D59400D26AEE998E, self._blackboard._id_A3111C437379D9E9, _id_47B4BDC915CFF70D);

      self orientmode("face angle 3d", self.asm.targetvalues["startAngles"]);
    }
  } else {
    self aisetanim(statename, animindex);
    _id_88AD5FE1080B1129 = self._blackboard.currentvehicle gettagorigin(_id_CBFBB4EFA1348391);
    _id_90FF9AE0521AC213 = self._blackboard.currentvehicle gettagangles(_id_CBFBB4EFA1348391);
    _id_7B1C8FCEBB9C392D = self.origin - _id_88AD5FE1080B1129;
    _id_ED38213B0A9AF604 = invertangles(_id_90FF9AE0521AC213);
    _id_AE7383494EA7FEF1 = rotatevector(_id_7B1C8FCEBB9C392D, _id_ED38213B0A9AF604);
    _id_B6C5DE4898B7F63B = _func_848155BE2B7DA2CB(_id_90FF9AE0521AC213, self.angles);
    self linktomoveoffset(self._blackboard.currentvehicle, _id_CBFBB4EFA1348391, _id_AE7383494EA7FEF1, _id_B6C5DE4898B7F63B);
    scripts\engine\utility::motionwarpwithnotetracks(xanim, self._blackboard._id_D59400D26AEE998E, self._blackboard._id_A3111C437379D9E9, undefined, _id_B9460E0CB9B449A3, int(waittime * 1000));
  }

  wait(waittime);
  self motionwarpcancel();

  if(!isDefined(self.asm)) {
    return;
  }
  self notify("EndRotateToCurrentAngles");

  if(isDefined(_id_D1B180EE30493E0B))
    self.asm.targetvalues = getvehicleanimtargetoriginandangles(self._blackboard.currentvehicle, _id_D1B180EE30493E0B, _id_CBFBB4EFA1348391, self._blackboard._id_D59400D26AEE998E, self._blackboard._id_A3111C437379D9E9, _id_47B4BDC915CFF70D);
  else
    self.asm.targetvalues = getvehicleanimtargetoriginandangles(self._blackboard.currentvehicle, xanim, _id_CBFBB4EFA1348391, self._blackboard._id_D59400D26AEE998E, self._blackboard._id_A3111C437379D9E9, _id_47B4BDC915CFF70D);

  _id_91BE2B7482F940BA = self.asm.targetvalues["targetOrigin"];

  if(exiting) {
    self.asm.targetvalues["targetAngles"] = (0, self.asm.targetvalues["targetAngles"][1], 0);
    _id_91BE2B7482F940BA = getclosestpointonnavmesh(self.asm.targetvalues["targetOrigin"]);
    contents = scripts\engine\trace::create_solid_ai_contents(1);
    ignorelist = [];

    if(isDefined(self))
      ignorelist = scripts\engine\utility::array_add(ignorelist, self);

    if(isDefined(self._blackboard.currentvehicle))
      ignorelist = scripts\engine\utility::array_add(ignorelist, self._blackboard.currentvehicle);

    _id_F8BAA18DE1F819B9 = _id_91BE2B7482F940BA + (0, 0, 72);
    _id_D88DCBCDD09A0BA8 = _id_91BE2B7482F940BA + (0, 0, -1000);
    _id_0BCEE9CD35C91EB3 = physics_spherecast(_id_F8BAA18DE1F819B9, _id_D88DCBCDD09A0BA8, 12, contents, ignorelist, "physicsquery_closest");

    if(isDefined(_id_0BCEE9CD35C91EB3) && _id_0BCEE9CD35C91EB3.size > 0)
      _id_91BE2B7482F940BA = _id_0BCEE9CD35C91EB3[0]["position"];

    self orientmode("face angle 3d", self.asm.targetvalues["targetAngles"]);
  }

  _id_6040E7EBA5E09557 = (_id_47B4BDC915CFF70D - _id_67B5A24409D655F0) * animlength;
  self animmode("noclip");
  scripts\engine\utility::motionwarpwithnotetracks(xanim, _id_91BE2B7482F940BA, self.asm.targetvalues["targetAngles"], _id_B9460E0CB9B449A3, endnote, int(_id_6040E7EBA5E09557 * 1000));
  wait(_id_6040E7EBA5E09557);

  if(exiting) {
    if(!isDefined(self._blackboard)) {
      return;
    }
    if(istrue(self._blackboard.linkedtovehicle)) {
      self unlink();
      self._blackboard.linkedtovehicle = 0;
      self orientmode("face angle", self.asm.targetvalues["targetAngles"][1]);
      self animmode("gravity");
    }
  } else {
    self motionwarpcancel();
    self aiclearanim(statename, animindex, 0);
    self animmode("noclip");
    self orientmode("face current");
    self aisetanim(statename, animindex);
    self aisetanimtime(xanim, _id_47B4BDC915CFF70D);
    tagorigin = self._blackboard.currentvehicle gettagorigin(_id_CBFBB4EFA1348391);
    _id_A43B0202C06E0907 = self._blackboard.currentvehicle gettagangles(_id_CBFBB4EFA1348391);
    _id_88E63D3AA1307C00 = distance2dsquared(self.origin, _id_91BE2B7482F940BA) < 4.0 && abs(self.angles[0], self.asm.targetvalues["targetAngles"][0]) < 1 && abs(self.angles[1], self.asm.targetvalues["targetAngles"][1]) < 1 && abs(self.angles[2], self.asm.targetvalues["targetAngles"][2]) < 1;
    self.asm.targetvalues = undefined;

    if(!_id_88E63D3AA1307C00 && _id_47B4BDC915CFF70D < 1.0) {
      _id_33DB3A06C680BC05 = int(1000 * animlength * (1.0 - _id_47B4BDC915CFF70D));
      scripts\engine\utility::motionwarpwithtimes(xanim, tagorigin, _id_A43B0202C06E0907, _id_47B4BDC915CFF70D, 1.0, _id_33DB3A06C680BC05);
      _id_9473D6DA1303637E = _id_33DB3A06C680BC05 * 0.5 / 1000;
      _id_6AD3F3636DBBEBED = _id_33DB3A06C680BC05 * 0.5 / 1000;
      movedelta = getmovedelta(xanim, 1.0 - (1.0 - _id_47B4BDC915CFF70D) * 0.5, 1.0);
      angledelta = getangledelta3d(xanim, 1.0 - (1.0 - _id_47B4BDC915CFF70D) * 0.5, 1.0);
      _id_1858A5A3ADF74AE6 = tagorigin - movedelta;
      _id_2B59495B388D8170 = _id_A43B0202C06E0907 - angledelta;
      thread _id_710D997BA5906931(_id_9473D6DA1303637E, _id_1858A5A3ADF74AE6, _id_2B59495B388D8170, tagorigin, _id_A43B0202C06E0907, _id_6AD3F3636DBBEBED);
    }

    scripts\asm\asm::asm_donotetracks(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename));

    if(!isDefined(self._blackboard) || !isDefined(self)) {
      return;
    }
    if(!istrue(self._blackboard.linkedtovehicle))
      linktovehicle(self.origin, self.angles, self._blackboard._id_F6D06D1E68F4F4E5, self._blackboard._id_1745D2B69C72C627);
  }
}

_id_710D997BA5906931(_id_193BA10DFA6671B4, _id_91BE2B7482F940BA, targetangles, tagorigin, _id_A43B0202C06E0907, _id_6040E7EBA5E09557) {
  self endon("death");
  self endon("EndVehicleMotionWarp");
  wait(_id_193BA10DFA6671B4);
  _id_539A5CF0803A5CFE = distance2dsquared(self.origin, _id_91BE2B7482F940BA) < 40.0 && abs(self.angles[0], targetangles[0]) < 5 && abs(self.angles[1], targetangles[1]) < 5 && abs(self.angles[2], targetangles[2]) < 5;

  if(!_id_539A5CF0803A5CFE) {
    self motionwarpcancel();
    self motionwarp(tagorigin, _id_A43B0202C06E0907, int(_id_6040E7EBA5E09557 * 1000));
  }
}

playanim_entervehicle(asmname, statename, params) {
  self endon(statename + "_finished");
  setvehiclearchetype();
  self._id_0A41EDF45BB0FF97 = undefined;
  self._blackboard.startedenteringvehicle = 1;
  animindex = scripts\asm\asm::asm_getanim(asmname, statename);
  xanim = scripts\asm\asm::asm_getxanim(statename, animindex);
  self animmode("noclip");
  self orientmode("face current angles");

  if(isDefined(self._blackboard.currentvehicle)) {
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard._id_9176CAE5619D7FBA;
    aianims = scripts\common\vehicle_aianim::anim_pos(vehicle, position);
    _id_917B4946225E8ABA = scripts\asm\asm::asm_getanim(asmname, "vehicle_idle");
    _id_0E3FE8E8FA41EFB4 = scripts\asm\asm::asm_getxanim("vehicle_idle", _id_917B4946225E8ABA);
    thread enterexitvehiclemotionwarp(asmname, statename, xanim, self._blackboard._id_1745D2B69C72C627, 0, undefined);
  }
}

entervehicle_terminate(asmname, statename, params) {
  clearvehiclearchetype();

  if(isalive(self)) {
    if(!istrue(self._blackboard.linkedtovehicle) && isalive(self._blackboard.currentvehicle)) {
      linktovehicle(self.asm.targetvalues["targetOrigin"], self.asm.targetvalues["targetAngles"], self._blackboard._id_F6D06D1E68F4F4E5, self._blackboard._id_1745D2B69C72C627);
      self.asm.targetvalues = undefined;
    }

    if(isalive(self._blackboard.currentvehicle))
      self._blackboard.enteredvehicle = 1;
  } else {
    setvehiclearchetype();
    xanim = scripts\asm\asm::asm_getxanim(statename, self._blackboard._id_9176CAE5619D7FBA);
    _id_EB5B1F36E255152D = self aigetanimtime(statename, self._blackboard._id_9176CAE5619D7FBA);
    animlength = getanimlength(xanim);
    _id_B18D3429CF88F29F = getnotetracktimes(xanim, "vehicle_cab_transition")[0];

    if(isDefined(_id_B18D3429CF88F29F)) {
      if(_id_EB5B1F36E255152D < _id_B18D3429CF88F29F)
        self._id_0AA0214E1292A7B3 = 1;
      else {
        self._blackboard.vehicledeathwait = (1.0 - _id_EB5B1F36E255152D) * animlength;
        self._blackboard._id_C191EDDDBACADD2A = _id_EB5B1F36E255152D;
        self._blackboard._id_DD5DD40921B4615C = statename;
        self._id_442EEEABC15EDD0A = 1;
      }
    } else
      self._id_0AA0214E1292A7B3 = 1;
  }

  self motionwarpcancel();
}

exitvehiclewatchpath(statename) {
  self endon(statename + "_finished");

  for(;;) {
    if(isDefined(self.pathgoalpos)) {
      self animmode("gravity");
      self orientmode("face motion");
      return;
    }

    waitframe();
  }
}

playanim_exitvehicle(asmname, statename, params) {
  self endon(statename + "_finished");
  self setdefaultaimlimits();
  self.requestopendoor = 1;
  self.requestopendoorparams = params;
  self.allowpain = 1;

  if(isDefined(self._blackboard.currentvehicle)) {
    if(isDefined(self._blackboard._id_A43D8E6E8A225CD2)) {
      anim_name = self._blackboard._id_A43D8E6E8A225CD2;
      self._blackboard.currentvehicle _meth_EB2255B847E6681C(anim_name);
    }
  }

  scripts\engine\utility::set_movement_speed(60);
  self aisettargetspeed(60);
  self.exitvehicle_oldturnrate = self.turnrate;
  self.turnrate = 0.3;

  if(istrue(self._blackboard._id_3299C329AD09645B))
    self.noragdoll = undefined;

  setvehiclearchetype();
  animindex = scripts\asm\asm::asm_getanim(asmname, statename);
  xanim = scripts\asm\asm::asm_getxanim(statename, animindex);
  self._blackboard.exitvehicleanimindex = animindex;

  if(isDefined(self._blackboard.currentvehicle))
    thread enterexitvehiclemotionwarp(asmname, statename, xanim, self._blackboard._id_1745D2B69C72C627, 1, undefined);

  self animmode("nogravity");
  self aisetanim(statename, animindex);
  endnote = scripts\asm\asm::asm_donotetracks(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename), undefined, undefined, 0);

  if(endnote == "code_move") {
    thread exitvehiclewatchpath(statename);
    scripts\asm\asm::asm_donotetracks(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename), undefined, undefined, 0);
  }

  scripts\asm\asm::asm_fireevent(asmname, "end");
}

endvehiclemotionwarp() {
  self notify("EndVehicleMotionWarp");
  self.asm.targetvalues = undefined;
  self motionwarpcancel();
}

exitvehicle_terminate(asmname, statename, params) {
  self._blackboard.invehicle = 0;
  scripts\common\utility::clear_movement_speed();

  if(isDefined(self.exitvehicle_oldturnrate)) {
    self.turnrate = self.exitvehicle_oldturnrate;
    self.exitvehicle_oldturnrate = undefined;
  }

  if(!isalive(self) && !istrue(self._blackboard._id_80912EC8ADE08716)) {
    if(!isDefined(self._blackboard.exitvehicleanimindex))
      self._blackboard.exitvehicleanimindex = scripts\asm\asm::asm_getanim(asmname, statename);

    xanim = scripts\asm\asm::asm_getxanim(statename, self._blackboard.exitvehicleanimindex);
    _id_EB5B1F36E255152D = self aigetanimtime(statename, self._blackboard.exitvehicleanimindex);
    animlength = getanimlength(xanim);
    waittime = getnotetracktimes(xanim, "vehicle_death_wait")[0];
    ragdolltime = getnotetracktimes(xanim, "vehicle_death_ragdoll")[0];
    _id_00A142374769D92D = isDefined(self._blackboard.currentvehicle) && self._blackboard.currentvehicle scripts\common\vehicle::ishelicopter() && self._blackboard.currentvehicle scripts\common\vehicle::vehicle_is_crashing();

    if(isDefined(waittime) && isDefined(ragdolltime)) {
      if(_id_EB5B1F36E255152D < waittime)
        self._blackboard.invehicle = 1;
      else if(_id_EB5B1F36E255152D < ragdolltime) {
        if(_id_00A142374769D92D)
          self._blackboard.invehicle = 1;
        else {
          self._blackboard.vehicledeathwait = (ragdolltime - _id_EB5B1F36E255152D) * animlength;
          self._blackboard._id_C191EDDDBACADD2A = _id_EB5B1F36E255152D;
          self._blackboard._id_DD5DD40921B4615C = statename;
        }
      }
    } else {
      self._id_0AA0214E1292A7B3 = 1;
      _id_B18D3429CF88F29F = getnotetracktimes(xanim, "vehicle_cab_transition")[0];

      if(isDefined(_id_B18D3429CF88F29F)) {
        if(_id_EB5B1F36E255152D < _id_B18D3429CF88F29F) {
          self._blackboard.vehicledeathwait = (_id_B18D3429CF88F29F - _id_EB5B1F36E255152D) * animlength;
          self._blackboard._id_C191EDDDBACADD2A = _id_EB5B1F36E255152D;
          self._blackboard._id_DD5DD40921B4615C = statename;
        }
      }
    }
  } else if(!isalive(self)) {
    self._id_0AA0214E1292A7B3 = 1;

    if(!isDefined(self._blackboard.exitvehicleanimindex))
      self._blackboard.exitvehicleanimindex = scripts\asm\asm::asm_getanim(asmname, statename);

    xanim = scripts\asm\asm::asm_getxanim(statename, self._blackboard.exitvehicleanimindex);
    _id_EB5B1F36E255152D = self aigetanimtime(statename, self._blackboard.exitvehicleanimindex);
    animlength = getanimlength(xanim);
    _id_B18D3429CF88F29F = getnotetracktimes(xanim, "vehicle_cab_transition")[0];

    if(isDefined(_id_B18D3429CF88F29F)) {
      if(_id_EB5B1F36E255152D < _id_B18D3429CF88F29F) {
        self._blackboard.vehicledeathwait = (_id_B18D3429CF88F29F - _id_EB5B1F36E255152D) * animlength;
        self._blackboard._id_C191EDDDBACADD2A = _id_EB5B1F36E255152D;
        self._blackboard._id_DD5DD40921B4615C = statename;
      }
    }
  } else if(istrue(self._blackboard.linkedtovehicle)) {
    self unlink();
    self._blackboard.linkedtovehicle = 0;
  }

  if(!isDefined(self._blackboard.vehicledeathwait)) {
    endvehiclemotionwarp();
    self._blackboard.exitvehicleanimindex = undefined;
  }

  self notify("jumpedout");
  self._blackboard.exitingvehicle = 0;
  self.requestopendoor = undefined;
  self.requestopendoorparams = undefined;
  clearvehiclearchetype();
}

_id_119026BD546DD180(asmname, statename, params) {
  if(!isalive(self))
    self._id_0AA0214E1292A7B3 = 1;

  clearvehiclearchetype();
}

watchvehicledeath() {
  self endon("entitydeleted");

  if(self isragdoll()) {
    return;
  }
  if(isDefined(self._blackboard.currentvehicle)) {
    vehicle = self._blackboard.currentvehicle;

    for(;;) {
      if(!isDefined(self)) {
        return;
      }
      if(!isDefined(vehicle) || vehicle scripts\common\vehicle_code::vehicle_iscorpse()) {
        endvehiclemotionwarp();
        self startragdoll();
        self.skipdeathcleanup = 0;
        self.vehicle_idling = 0;
        scripts\asm\soldier\death::deathcleanup();
        return;
      }

      waitframe();
    }
  }
}

playanim_vehicledeath(asmname, statename, params) {
  if(!isDefined(self)) {
    return;
  }
  self endon("entitydeleted");
  setvehiclearchetype();

  if(!isagent(self)) {
    if(istrue(self._id_0AA0214E1292A7B3) || isDefined(self.damagemod) && (self.damagemod == "MOD_FIRE" || self.damagemod == "MOD_IMPACT"))
      self._id_1447D8FEE27482B0 = (0, 0, 0);

    scripts\asm\soldier\death::handleburningtodeath();
    self.burningtodeath = 0;
    _id_FC8654AA4F8E7C51 = !isDefined(self._blackboard.currentvehicle) || self._blackboard.currentvehicle scripts\common\vehicle_code::vehicle_iscorpse();

    if(isDefined(self._blackboard.vehicledeathwait)) {
      if(!_id_FC8654AA4F8E7C51) {
        xanim = animsetgetanimfromindex(self._blackboard.currentvehicleanimalias, self._blackboard._id_DD5DD40921B4615C, self._blackboard._id_9176CAE5619D7FBA);
        self aisetanim(self._blackboard._id_DD5DD40921B4615C, self._blackboard._id_9176CAE5619D7FBA, 1);
        self aisetanimtime(xanim, self._blackboard._id_C191EDDDBACADD2A);
        self animmode("noclip");

        if(istrue(self._id_442EEEABC15EDD0A) && isDefined(self._blackboard.currentvehicle))
          scripts\engine\utility::_id_DF956D52BAE0B61D(xanim, self._blackboard.currentvehicle, self._blackboard._id_1745D2B69C72C627, (0, 0, 0), (0, 0, 0), self._blackboard._id_C191EDDDBACADD2A, 1.0);

        thread watchvehicledeath();
        wait(self._blackboard.vehicledeathwait);
        self._id_1447D8FEE27482B0 = (0, 0, 0);
        self._blackboard.exitvehicleanimindex = undefined;
        self._blackboard.vehicledeathwait = undefined;
      }

      endvehiclemotionwarp();
    }

    self orientmode("face current angles");
    _id_5D6E6D808C153D03 = undefined;
    self.noragdoll = 0;
    _id_41154210564D7C9C = scripts\asm\soldier\death::_id_EA379D7359BD10AE(asmname, statename, params);
    notetracks = _func_C8BCC9DBBF542CE3(_id_41154210564D7C9C[1], "start_ragdoll");

    if(notetracks.size != 0)
      _id_5D6E6D808C153D03 = 1;

    _id_10CCD1EB1D027B69 = _id_FC8654AA4F8E7C51 || istrue(self._blackboard._id_80912EC8ADE08716) || istrue(_id_5D6E6D808C153D03) || istrue(self._id_0AA0214E1292A7B3);
    _id_7DFBF656D13D1A6C = !_id_FC8654AA4F8E7C51 && (istrue(_id_5D6E6D808C153D03) || istrue(self._blackboard._id_86FE99780C9BC5F9));

    if(_id_10CCD1EB1D027B69) {
      self.skipdeathcleanup = 0;
      self.vehicle_idling = 0;

      if(istrue(self._id_0AA0214E1292A7B3)) {
        self.nogravityragdoll = 1;
        self.ragdoll_immediate = 1;
        self.deathstate = "vehicle_transition_death";
        self.deathalias = "death";
      } else if(_id_7DFBF656D13D1A6C) {
        self.nogravityragdoll = 1;
        self.ragdolltime = getanimlength(_id_41154210564D7C9C[1]) * notetracks[0]["time"];
      } else
        self.ragdoll_immediate = 1;
    } else {
      self animmode("nogravity");
      self.noragdoll = 1;
      self.skipdeathcleanup = 1;
      thread watchvehicledeath();
    }
  } else {
    self motionwarpcancel();
    self orientmode("face current angles");
  }

  scripts\asm\soldier\death::playdeathanim(asmname, statename, params);
}

playanim_vehicle(asmname, statename, params) {
  setvehiclearchetype();
  scripts\asm\asm::asm_playanimstate(asmname, statename, params);
}

_id_863EAACFE47CEDEE(asmname, statename, params) {
  setvehiclearchetype();
  self.useanimgoalweight = 1;
  scripts\asm\asm::asm_playanimstate(asmname, statename, params);
}

playanim_vehiclereload(asmname, statename, params) {
  self endon("reload_terminate");
  self endon(statename + "_finished");
  setvehiclearchetype();
  _id_2C8936D08F85C5C1 = scripts\asm\asm::asm_getanim(asmname, statename);
  self aisetanim(statename, _id_2C8936D08F85C5C1);
  xanim = scripts\asm\asm::asm_getxanim(statename, _id_2C8936D08F85C5C1);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, xanim);
  scripts\asm\asm::asm_donotetracks(asmname, statename, undefined, undefined, undefined, 1);
}

_id_59AF18A4AEE683FF(asmname, statename, params) {
  setvehiclearchetype();
  self._id_58E8388F04ABB64E = 1;
  self._blackboard._id_6A69FA6B0B354C93 = 1;

  if(isDefined(self._blackboard.currentvehicle)) {
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard._id_9176CAE5619D7FBA;
    aianims = scripts\common\vehicle_aianim::anim_pos(vehicle, position);
    self._id_26CAFCB7C9DACC27 = aianims.vehicle_death_ragdoll;
    aianims.vehicle_death_ragdoll = 1;
  }

  scripts\asm\asm::asm_playanimstate(asmname, statename, params);
}

_id_97519548BDED06BD(asmname, statename, params) {
  setvehiclearchetype();
  self._id_58E8388F04ABB64E = 0;
  self._blackboard._id_6A69FA6B0B354C93 = 0;

  if(isDefined(self._blackboard.currentvehicle)) {
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard._id_9176CAE5619D7FBA;
    aianims = scripts\common\vehicle_aianim::anim_pos(vehicle, position);
    aianims.vehicle_death_ragdoll = self._id_26CAFCB7C9DACC27;
  }

  scripts\asm\asm::asm_playanimstate(asmname, statename, params);
}

_id_E2CDB897D2F82507(asmname, statename, params) {
  self endon(statename + "_finished");
  self endon("death");
  setvehiclearchetype();
  vehicle = self._blackboard.currentvehicle;
  position = self._blackboard._id_9176CAE5619D7FBA;
  aianims = scripts\common\vehicle_aianim::anim_pos(vehicle, position);
  scripts\asm\soldier\melee::playmeleeattacksound();
  target = scripts\asm\asm_bb::bb_getmeleetarget();

  if(!isDefined(target))
    self orientmode("face current");
  else if(target == self.enemy)
    self orientmode("face enemy");
  else
    self orientmode("face point", target.origin);

  scripts\asm\asm::asm_fireephemeralevent("melee_attack", "begin");
  self aisetanim(statename, scripts\asm\asm::asm_getanim(asmname, statename));
  scripts\asm\soldier\melee::donotetracks_vsplayer(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename));
  scripts\asm\asm::asm_fireevent(asmname, "end");
}

vehiclereload_terminate(asmname, statename, params) {
  scripts\asm\soldier\script_funcs::reload_cleanup(asmname, statename, params);
  clearvehiclearchetype();
}

_id_3C5410E410CAA595(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return !isalive(self._blackboard.currentvehicle);
}

isnotinvehicle() {
  return !self._blackboard.invehicle;
}

_id_99CABDA949B9375A(asmname, statename, _id_F2B19B25D457C2A6, params) {
  vehicle = self._blackboard.currentvehicle;
  position = self._blackboard._id_9176CAE5619D7FBA;
  aianims = scripts\common\vehicle_aianim::anim_pos(vehicle, position);

  if(!isDefined(aianims) || !istrue(aianims._id_BCD0A0AFD54C6491))
    return 0;

  if(_id_B3BB4D116F5A79CB(self._blackboard.currentvehicle, self._blackboard._id_9176CAE5619D7FBA))
    return 0;

  if(self _meth_5B5D9B0857469A76())
    return 1;

  return 0;
}

_id_29FED6F5A8B07E74(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(isDefined(self._blackboard._id_B79347F04F2C0672))
    return self._blackboard._id_B79347F04F2C0672 == 0 || self._blackboard._id_B79347F04F2C0672 == 8;

  return 1;
}

_id_3E064916882C7B95(asmname, statename, params) {
  alias = scripts\engine\utility::string(self._blackboard._id_9176CAE5619D7FBA);
  vehicle = self._blackboard.currentvehicle;
  position = self._blackboard._id_9176CAE5619D7FBA;
  aianims = scripts\common\vehicle_aianim::anim_pos(vehicle, position);
  _id_E21AA8DD0F14CEA5 = self._blackboard._id_B79347F04F2C0672;
  alias = alias + ("_" + scripts\engine\utility::string(self._blackboard._id_B79347F04F2C0672));

  if(_id_E21AA8DD0F14CEA5 == 2)
    alias = alias + "_turn_2";
  else if(_id_E21AA8DD0F14CEA5 == 4)
    alias = alias + "_turn_6";
  else
    alias = alias + "_turn_4";

  return scripts\asm\asm::asm_lookupanimfromalias("vehicle_idle_combat_shoot_turn", alias);
}

_id_B6FB6CFFE3F92B36(asmname, statename, params) {
  self endon(statename + "_finished");
  setvehiclearchetype();
  self.useanimgoalweight = 1;
  _id_2C8936D08F85C5C1 = scripts\asm\asm::asm_getanim(asmname, statename);
  _id_1BE6952BB25E8AAB = "vehicle_idle_combat_shoot_turn";
  self aisetanim(_id_1BE6952BB25E8AAB, _id_2C8936D08F85C5C1);
  scripts\asm\asm::asm_playfacialanim(asmname, _id_1BE6952BB25E8AAB, scripts\asm\asm::asm_getxanim(_id_1BE6952BB25E8AAB, _id_2C8936D08F85C5C1));
  endnote = scripts\asm\asm::asm_donotetracks(asmname, _id_1BE6952BB25E8AAB, scripts\asm\asm::asm_getnotehandler(asmname, _id_1BE6952BB25E8AAB));

  if(endnote == "code_move")
    endnote = scripts\asm\asm::asm_donotetracks(asmname, _id_1BE6952BB25E8AAB, scripts\asm\asm::asm_getnotehandler(asmname, _id_1BE6952BB25E8AAB));
}

vehicleshouldstophide(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!self issuppressed() && isDefined(self._id_EDB88205B19560BD) && self._id_EDB88205B19560BD)
    return 1;
  else
    return gettime() > self._blackboard.vehiclehidetime;
}

_id_FDA43DA6E52AF4B5(asmname, statename, params) {
  self._blackboard._id_3769628964AC89C1 = 1;
  playanim_vehicle(asmname, statename, params);
}

_id_B8F7A5C394A25131() {
  if(!isDefined(self._blackboard._id_E38C46BE257216D3))
    return "";

  alias = self._blackboard._id_9176CAE5619D7FBA + "_" + self._blackboard._id_E38C46BE257216D3;

  if(_id_B3BB4D116F5A79CB(self._blackboard.currentvehicle, self._blackboard._id_9176CAE5619D7FBA)) {
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard._id_9176CAE5619D7FBA;
    aianims = scripts\common\vehicle_aianim::anim_pos(vehicle, position);

    if(aianims._id_8DBB2562EC7AB3ED)
      alias = alias + "_4";
    else
      alias = alias + "_6";
  }

  return alias;
}

_id_9BF47724E18BBBEE(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!isDefined(self._blackboard._id_E38C46BE257216D3))
    return 0;

  alias = _id_B8F7A5C394A25131();
  _id_0EABF81B5BE8DDB5 = archetypegetrandomalias(self._blackboard.currentvehicleanimalias, _id_F2B19B25D457C2A6, alias, scripts\asm\asm::asm_isfrantic());
  return isDefined(_id_0EABF81B5BE8DDB5);
}

_id_7150EF4BC326B7F4(asmname, statename, params) {
  alias = _id_B8F7A5C394A25131();
  return scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
}

_id_B4B7FF53BE58DE23(asmname, statename, _id_F2B19B25D457C2A6, params) {
  _id_38548703EA2BDADC = self._blackboard.currentvehicleanimalias;
  alias = scripts\engine\utility::string(self._blackboard._id_9176CAE5619D7FBA);

  if(isDefined(self._blackboard.currentvehicle)) {
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard._id_9176CAE5619D7FBA;
    aianims = scripts\common\vehicle_aianim::anim_pos(vehicle, position);
    alias = alias + _id_37DA44A7CF24FDAD(aianims);
  }

  _id_0EABF81B5BE8DDB5 = archetypegetrandomalias(_id_38548703EA2BDADC, _id_F2B19B25D457C2A6, alias, scripts\asm\asm::asm_isfrantic());
  return isDefined(_id_0EABF81B5BE8DDB5);
}

vehiclehasalias(asmname, statename, _id_F2B19B25D457C2A6, params) {
  _id_38548703EA2BDADC = self._blackboard.currentvehicleanimalias;
  alias = scripts\engine\utility::string(self._blackboard._id_9176CAE5619D7FBA);

  if(_id_B3BB4D116F5A79CB(self._blackboard.currentvehicle, self._blackboard._id_9176CAE5619D7FBA)) {
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard._id_9176CAE5619D7FBA;
    aianims = scripts\common\vehicle_aianim::anim_pos(vehicle, position);

    if(aianims._id_8DBB2562EC7AB3ED)
      alias = alias + "_4";
    else
      alias = alias + "_6";
  }

  _id_0EABF81B5BE8DDB5 = archetypegetrandomalias(_id_38548703EA2BDADC, _id_F2B19B25D457C2A6, alias, scripts\asm\asm::asm_isfrantic());
  return isDefined(_id_0EABF81B5BE8DDB5);
}

_id_B0734010E3A7E4B3(asmname, statename, _id_F2B19B25D457C2A6, params) {
  _id_38548703EA2BDADC = self._blackboard.currentvehicleanimalias;
  alias = scripts\engine\utility::string(self._blackboard._id_9176CAE5619D7FBA);

  if(isDefined(self._blackboard.currentvehicle)) {
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard._id_9176CAE5619D7FBA;
    aianims = scripts\common\vehicle_aianim::anim_pos(vehicle, position);
    alias = alias + _id_AD6244629719D941(aianims);
  }

  _id_0EABF81B5BE8DDB5 = archetypegetrandomalias(_id_38548703EA2BDADC, _id_F2B19B25D457C2A6, alias, scripts\asm\asm::asm_isfrantic());

  if(isDefined(_id_0EABF81B5BE8DDB5))
    return 1;
  else {
    _id_0EABF81B5BE8DDB5 = archetypegetrandomalias(_id_38548703EA2BDADC, _id_F2B19B25D457C2A6, scripts\engine\utility::string(self._blackboard._id_9176CAE5619D7FBA), scripts\asm\asm::asm_isfrantic());
    return isDefined(_id_0EABF81B5BE8DDB5);
  }
}

_id_B373BC69137D18D1(asmname, statename, _id_F2B19B25D457C2A6, params) {
  _id_38548703EA2BDADC = self._blackboard.currentvehicleanimalias;
  alias = scripts\engine\utility::string(self._blackboard._id_9176CAE5619D7FBA);
  vehicle = self._blackboard.currentvehicle;
  position = self._blackboard._id_9176CAE5619D7FBA;
  aianims = scripts\common\vehicle_aianim::anim_pos(vehicle, position);

  if(isDefined(aianims._id_8DBB2562EC7AB3ED)) {
    _id_019F92FA83D7CD69 = _id_EF715D817B10B063(aianims);
    alias = alias + _id_019F92FA83D7CD69;
  }

  _id_0EABF81B5BE8DDB5 = archetypegetrandomalias(_id_38548703EA2BDADC, _id_F2B19B25D457C2A6, alias, scripts\asm\asm::asm_isfrantic());
  return isDefined(_id_0EABF81B5BE8DDB5);
}

_id_1746AD7C74EAD3E8(asmname, statename, _id_F2B19B25D457C2A6, params) {
  _id_38548703EA2BDADC = self._blackboard.currentvehicleanimalias;
  alias = scripts\engine\utility::string(self._blackboard._id_9176CAE5619D7FBA);

  if(_id_B3BB4D116F5A79CB(self._blackboard.currentvehicle, self._blackboard._id_9176CAE5619D7FBA)) {
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard._id_9176CAE5619D7FBA;
    aianims = scripts\common\vehicle_aianim::anim_pos(vehicle, position);

    if(aianims._id_8DBB2562EC7AB3ED)
      alias = alias + "_4";
    else
      alias = alias + "_6";
  }

  alias = _id_179D01A77DC31F73(alias);
  _id_0EABF81B5BE8DDB5 = archetypegetrandomalias(_id_38548703EA2BDADC, _id_F2B19B25D457C2A6, alias, scripts\asm\asm::asm_isfrantic());
  return isDefined(_id_0EABF81B5BE8DDB5);
}

vehicleshouldrunexit(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return istrue(self.vehiclerunexit);
}

_id_A1F0771E220C6C30(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return istrue(self._id_58E8388F04ABB64E) && !vehicleincombat(asmname, statename, _id_F2B19B25D457C2A6, params) && vehiclehasalias(asmname, statename, _id_F2B19B25D457C2A6, params);
}

vehiclegetoutcodemove(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(scripts\asm\asm::asm_eventfired(asmname, "code_move") && isDefined(self.pathgoalpos))
    return 1;

  return 0;
}

_id_EBA2C90EE8749A0F() {
  self endon("EndVehicleCollisionThread");
  self endon("death");

  if(!isDefined(self._blackboard.currentvehicle)) {
    return;
  }
  self._blackboard.currentvehicle waittill("collision", body0, body1, flag0, flag1, position, normal, _id_D71630B8BAF84FA8, ent);
  self._id_FBE92F71B3BAB094 = spawnStruct();
  self._id_FBE92F71B3BAB094.position = position;
  self._id_FBE92F71B3BAB094.normal = normal;
  self._id_FBE92F71B3BAB094._id_D71630B8BAF84FA8 = _id_D71630B8BAF84FA8;
  forward = anglesToForward(self.angles);
}

_id_C9C1B653ECDCAFFD(asmname, statename, params) {
  thread _id_EBA2C90EE8749A0F();
}

_id_535F605646D65A4D() {
  if(isDefined(self._id_FBE92F71B3BAB094))
    self._id_FBE92F71B3BAB094 = undefined;
}

_id_EA6FCDDDE1C07C00(asmname, statename, params) {
  self notify("EndVehicleCollisionThread");
}

_id_9E3CA0A0ABCF9CF0(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!isDefined(self._blackboard.currentvehicle) || !isDefined(self._blackboard._id_9176CAE5619D7FBA))
    return 0;

  vehicle = self._blackboard.currentvehicle;
  position = self._blackboard._id_9176CAE5619D7FBA;
  aianims = scripts\common\vehicle_aianim::anim_pos(vehicle, position);

  if(!isDefined(aianims) || !istrue(aianims._id_BCD0A0AFD54C6491))
    return 0;

  if(!isDefined(self._id_FBE92F71B3BAB094) || !istrue(aianims._id_70AA9EAF339DDB20))
    return 0;

  return 1;
}