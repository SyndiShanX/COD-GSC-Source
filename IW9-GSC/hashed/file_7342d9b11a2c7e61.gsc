/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7342d9b11a2c7e61.gsc
***********************************************/

_id_56BDD015D9DECAF5() {
  if(_id_1CE31D513CB66606::_id_97F034F0AEF48475()) {
    _id_21A2A75C4BB69733();
    level thread _id_67F45EF19DBD2FE0();
  }
}

_id_8E805DA4AEF86965(_id_7E52ABE2FACBCCD1) {
  if(!_id_1CE31D513CB66606::_id_7F788F4B6412959C(_id_7E52ABE2FACBCCD1)) {
    return;
  }
  _id_21A2A75C4BB69733();
  level._id_CF22157205C34916._id_2B6807C7DF9A2B2D scripts\engine\utility::_id_24BBEFB4BEDA630D(_id_7E52ABE2FACBCCD1);
}

_id_21A2A75C4BB69733() {
  if(isDefined(level._id_CF22157205C34916) && level._id_CF22157205C34916._id_5E775CBE1E4B789F) {
    return;
  }
  level._id_CF22157205C34916 = spawnStruct();
  level._id_CF22157205C34916._id_2B6807C7DF9A2B2D = scripts\engine\utility::_id_21A6A1C613B50A28([], 2000);
  level._id_CF22157205C34916._id_C404BFA6BAEA85E5 = [];
  level._id_CF22157205C34916._id_5E775CBE1E4B789F = 1;
}

_id_7254A85E981BEE68() {
  if(!isDefined(self) || !isDefined(level._id_CF22157205C34916)) {
    return;
  }
  array = level._id_CF22157205C34916._id_C404BFA6BAEA85E5;

  if(!scripts\engine\utility::array_contains(array, self)) {
    level._id_CF22157205C34916._id_C404BFA6BAEA85E5[array.size] = self;
    thread _id_D626E7F4F6CDBA5D();
  }
}

_id_F39E6A792512552D() {
  if(!isDefined(self) || !isDefined(level._id_CF22157205C34916)) {
    return;
  }
  _id_41ACF9FA5508BA44 = scripts\engine\utility::array_find(level._id_CF22157205C34916._id_C404BFA6BAEA85E5, self);

  if(isDefined(_id_41ACF9FA5508BA44)) {
    self notify("haunting_radar_unsub");
    self._id_E7A9752E4F4C7D97["ghostfinder_assigned_ghost"] = undefined;
    level._id_CF22157205C34916._id_C404BFA6BAEA85E5[_id_41ACF9FA5508BA44] = undefined;
  }
}

_id_D5489F0F94DB01E6(dropcount, _id_FD26F60CC35B3E73, attacker, position) {
  if(isDefined(attacker) && dropcount > 0 && _id_0CBB0697DE4C5728::_id_4AE1058D4433F19D(attacker)) {
    while(_id_FD26F60CC35B3E73 > 0) {
      attacker thread _id_909186CE6AB7BD3B(position, 1);
      dropcount--;
      _id_FD26F60CC35B3E73--;
    }
  }

  return dropcount;
}

_id_909186CE6AB7BD3B(_id_0121BB966B0183A9, _id_439F0781DBD8A339) {
  _id_EAAD315E916DFC83();
  _id_BD92D56A9A258903(_id_0121BB966B0183A9, _id_439F0781DBD8A339);

  if(!_id_49C5EC298FFE8C05())
    _id_40929B6A7B6F6B0B(_id_439F0781DBD8A339);
}

_id_D626E7F4F6CDBA5D() {
  self endon("death");
  self endon("game_ended");
  self endon("disconnect");
  self endon("haunting_radar_unsub");
  _id_620FC78DF44AA9A3 = 1;
  self._id_E7A9752E4F4C7D97["ghostfunder_pulse_toggle_bit"] = 0;
  self._id_E7A9752E4F4C7D97["ghostfunder_dot_intensity"] = 0;

  for(;;) {
    if(isDefined(self._id_E7A9752E4F4C7D97["ghostfinder_assigned_ghost"])) {
      _id_7E0BC6E2FA7D45C2 = self._id_E7A9752E4F4C7D97["ghostfinder_assigned_ghost"] _id_1CE31D513CB66606::_id_08FF59B0F0FA5F33();
      _id_8001E54D56C4A952 = self getEye();
      _id_10D38F4DC0D37164 = self getplayerangles();
      _id_14D9D4FFFC09A76D = anglestoaxis(_id_10D38F4DC0D37164);
      _id_FB77C3987F32F5E5 = vectorNormalize(_id_7E0BC6E2FA7D45C2 - _id_8001E54D56C4A952);
      _id_365E577147C80881 = vectordot(_id_FB77C3987F32F5E5, _id_14D9D4FFFC09A76D["forward"]);
      _id_3BDC9AC8AE512860 = vectordot(_id_FB77C3987F32F5E5, _id_14D9D4FFFC09A76D["right"]);
      _id_A623E853D7395697 = vectordot(_id_FB77C3987F32F5E5, _id_14D9D4FFFC09A76D["up"]);
      dist = distance(_id_8001E54D56C4A952, _id_7E0BC6E2FA7D45C2);
      _id_79A264DBA37C162D = 1 - scripts\engine\math::normalize_value(350, 2400, dist);
      _id_0F2880E0C45F523E = scripts\engine\math::normalize_value(-0.5, 0.975, _id_365E577147C80881);
      _id_56022DDD18BBDE58 = scripts\engine\math::factor_value(0.7, 1, _id_0F2880E0C45F523E);
      _id_D4FBF994DDA25611 = scripts\engine\math::factor_value(0, _id_56022DDD18BBDE58, _id_79A264DBA37C162D);

      if(!sighttracepassed(_id_8001E54D56C4A952, _id_7E0BC6E2FA7D45C2, 0, undefined)) {
        _id_620FC78DF44AA9A3 = _id_620FC78DF44AA9A3 - 0.1;
        _id_620FC78DF44AA9A3 = max(_id_620FC78DF44AA9A3, 0.6);
      } else
        _id_620FC78DF44AA9A3 = 1;

      _id_D4FBF994DDA25611 = min(_id_D4FBF994DDA25611, _id_620FC78DF44AA9A3);
      _id_55381E70A94050AC = scripts\engine\math::factor_value(1.4, 0.2, _id_D4FBF994DDA25611);
      _id_CFE94CA0F03D9481(_id_D4FBF994DDA25611, _id_365E577147C80881, _id_3BDC9AC8AE512860, _id_A623E853D7395697);
      _id_57C1A42FAFE2BB6D(dist, _id_55381E70A94050AC);
    } else
      _id_55381E70A94050AC = 1;

    wait(_id_55381E70A94050AC);
  }
}

_id_CFE94CA0F03D9481(intensity, _id_365E577147C80881, _id_3BDC9AC8AE512860, _id_A623E853D7395697) {
  _id_7E774A977ABA3B57 = 0.99;
  _id_7E9A58977AE0A1D9 = 0.992;
  _id_ACA151D5015D3BE5 = scripts\engine\math::normalize_value(_id_7E774A977ABA3B57, _id_7E9A58977AE0A1D9, _id_365E577147C80881);
  intensity = int(intensity * 100);
  _id_ACA151D5015D3BE5 = int(_id_ACA151D5015D3BE5 * 100);
  _id_5DC34D4B5804EDF8 = int(_id_8BF7B973E9460176(_id_3BDC9AC8AE512860, _id_A623E853D7395697));

  if(self._id_E7A9752E4F4C7D97["ghostfunder_pulse_toggle_bit"] == 1)
    self._id_E7A9752E4F4C7D97["ghostfunder_pulse_toggle_bit"] = 0;
  else
    self._id_E7A9752E4F4C7D97["ghostfunder_pulse_toggle_bit"] = 1;

  if(_id_ACA151D5015D3BE5 > self._id_E7A9752E4F4C7D97["ghostfunder_dot_intensity"]) {
    self._id_E7A9752E4F4C7D97["ghostfunder_dot_intensity"] = int(self._id_E7A9752E4F4C7D97["ghostfunder_dot_intensity"] + 35);
    self._id_E7A9752E4F4C7D97["ghostfunder_dot_intensity"] = int(min(self._id_E7A9752E4F4C7D97["ghostfunder_dot_intensity"], _id_ACA151D5015D3BE5));
  } else if(_id_ACA151D5015D3BE5 < self._id_E7A9752E4F4C7D97["ghostfunder_dot_intensity"]) {
    self._id_E7A9752E4F4C7D97["ghostfunder_dot_intensity"] = int(self._id_E7A9752E4F4C7D97["ghostfunder_dot_intensity"] - 35);
    self._id_E7A9752E4F4C7D97["ghostfunder_dot_intensity"] = int(max(self._id_E7A9752E4F4C7D97["ghostfunder_dot_intensity"], _id_ACA151D5015D3BE5));
  }

  _id_46229209D316F487 = 0;
  _id_46229209D316F487 = scripts\cp_mp\utility\omnvar_utility::_id_8B532402EE55336E(0, 7, _id_46229209D316F487, intensity);
  _id_46229209D316F487 = scripts\cp_mp\utility\omnvar_utility::_id_8B532402EE55336E(7, 7, _id_46229209D316F487, self._id_E7A9752E4F4C7D97["ghostfunder_dot_intensity"]);
  _id_46229209D316F487 = scripts\cp_mp\utility\omnvar_utility::_id_8B532402EE55336E(14, 9, _id_46229209D316F487, _id_5DC34D4B5804EDF8);
  _id_46229209D316F487 = scripts\cp_mp\utility\omnvar_utility::_id_8B532402EE55336E(23, 1, _id_46229209D316F487, self._id_E7A9752E4F4C7D97["ghostfunder_pulse_toggle_bit"]);
  self setclientomnvar("ui_ghostfinder_screen_data", _id_46229209D316F487);
}

_id_57C1A42FAFE2BB6D(dist, _id_55381E70A94050AC) {
  _id_282FF7D1C9BC0EA4 = 2500;
  _id_7AF86B77199A21EB = 850;
  _id_32749E76E4747370 = 650;
  _id_5D363E6361173A7A = 400;

  if(dist > _id_282FF7D1C9BC0EA4) {
    return;
  }
  distance = "dist";
  _id_FFEE66DD168C0BDF = "slow";

  if(dist < _id_5D363E6361173A7A)
    distance = "close";
  else if(dist < _id_32749E76E4747370)
    distance = "med";
  else if(dist < _id_7AF86B77199A21EB)
    distance = "far";

  if(_id_55381E70A94050AC < 0.1)
    _id_FFEE66DD168C0BDF = "fast";
  else if(_id_55381E70A94050AC < 0.25)
    _id_FFEE66DD168C0BDF = "med";

  if(soundexists("iw9_haunt_ghost_detector_" + _id_FFEE66DD168C0BDF + "_" + distance))
    self playlocalsound("iw9_haunt_ghost_detector_" + _id_FFEE66DD168C0BDF + "_" + distance);
}

_id_8BF7B973E9460176(_id_3BDC9AC8AE512860, _id_A623E853D7395697) {
  _id_45C4BEE623CE2BF8 = abs(_id_3BDC9AC8AE512860) + abs(_id_A623E853D7395697);

  if(_id_45C4BEE623CE2BF8 > 0) {
    _id_2753E57904B85655 = _id_3BDC9AC8AE512860 / _id_45C4BEE623CE2BF8;
    _id_B4B3AC63E415ECFC = _id_A623E853D7395697 / _id_45C4BEE623CE2BF8;
  } else {
    _id_2753E57904B85655 = 1;
    _id_B4B3AC63E415ECFC = 1;
  }

  if(_id_B4B3AC63E415ECFC < 0)
    angle = 90 * _id_2753E57904B85655;
  else {
    angle = 90 + 90 * _id_B4B3AC63E415ECFC;

    if(_id_2753E57904B85655 < 0)
      angle = angle * -1;
  }

  angle = angle + 180;
  return angle;
}

_id_67F45EF19DBD2FE0() {
  level endon("game_ended");
  level notify("ghostPartitionSubscritionThread");
  level endon("ghostPartitionSubscritionThread");

  if(!scripts\engine\utility::flag("scriptables_ready"))
    scripts\engine\utility::flag_wait("scriptables_ready");

  for(;;) {
    _id_CD5730C36781977E();

    foreach(playerent in level._id_CF22157205C34916._id_C404BFA6BAEA85E5) {
      playerent _id_8FE35DF18BA92EA3();
      waitframe();
    }

    wait 0.5;
  }
}

_id_CD5730C36781977E() {
  level._id_CF22157205C34916._id_C404BFA6BAEA85E5 = scripts\engine\utility::array_removeundefined(level._id_CF22157205C34916._id_C404BFA6BAEA85E5);
}

_id_8FE35DF18BA92EA3() {
  _id_9BC62D5BED1C423F = _id_0D34A825CB73465D(level._id_CF22157205C34916._id_2B6807C7DF9A2B2D, self.origin);
  self._id_E7A9752E4F4C7D97["ghostfinder_assigned_ghost"] = _id_9BC62D5BED1C423F;
}

_id_0D34A825CB73465D(_id_7423D7752DFBFA6A, position) {
  _id_F421322F7385FD6E = _id_7423D7752DFBFA6A scripts\engine\utility::_id_0DF633F460888A47(position);
  _id_9BC62D5BED1C423F = undefined;
  _id_42CA41C7DADAE0C0 = -1;

  foreach(_id_16B9D82475F96AA9 in _id_F421322F7385FD6E) {
    if(!isDefined(_id_16B9D82475F96AA9)) {
      continue;
    }
    _id_AAFD78058EF058B8 = undefined;
    _id_AAFD78058EF058B8 = _id_115F54657C121222(_id_7423D7752DFBFA6A, _id_16B9D82475F96AA9, position);

    if(!isDefined(_id_AAFD78058EF058B8)) {
      continue;
    }
    _id_5C1EE5AB8012EA11 = distancesquared(_id_AAFD78058EF058B8.origin, position);

    if(_id_5C1EE5AB8012EA11 > 5760000) {
      continue;
    }
    if(!isDefined(_id_9BC62D5BED1C423F) || _id_42CA41C7DADAE0C0 > _id_5C1EE5AB8012EA11) {
      _id_9BC62D5BED1C423F = _id_AAFD78058EF058B8;
      _id_42CA41C7DADAE0C0 = _id_5C1EE5AB8012EA11;
    }
  }

  return _id_9BC62D5BED1C423F;
}

_id_115F54657C121222(_id_7423D7752DFBFA6A, _id_E57077CD9CCD38A1, position) {
  if(!isDefined(_id_E57077CD9CCD38A1) || !isDefined(_id_E57077CD9CCD38A1.size) || _id_E57077CD9CCD38A1.size < 1)
    return undefined;

  _id_DFDD438871090D04 = sortbydistance(_id_E57077CD9CCD38A1, position);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_DFDD438871090D04.size; _id_AC0E594AC96AA3A8++) {
    _id_7E52ABE2FACBCCD1 = _id_DFDD438871090D04[_id_AC0E594AC96AA3A8];
    _id_3715B1B2500AFB71 = _id_7E52ABE2FACBCCD1 getscriptablepartstate("eventGhost_model");

    if(_id_3715B1B2500AFB71 == "active")
      return _id_7E52ABE2FACBCCD1;
  }

  return undefined;
}

_id_EAAD315E916DFC83() {
  if(!isDefined(level._id_F8FF77AC1F72D7C8))
    level._id_F8FF77AC1F72D7C8 = [];

  if(!isDefined(self._id_E7A9752E4F4C7D97["ghost_orbs_absorbing"])) {
    self._id_E7A9752E4F4C7D97["ghost_orbs_absorbing"] = 0;
    self._id_E7A9752E4F4C7D97["ghost_orbs_collected"] = 0;
    self._id_E7A9752E4F4C7D97["ghost_orbs_active"] = [];
    self._id_E7A9752E4F4C7D97["ghost_orbs_queued"] = [];
  }
}

_id_BD92D56A9A258903(_id_0121BB966B0183A9, _id_439F0781DBD8A339) {
  if(_id_439F0781DBD8A339)
    scriptable = "vfx_scriptable_ghosthunter_soul_trophy_entityless";
  else
    scriptable = "vfx_scriptable_ghosthunter_soul_entityless";

  if(self._id_E7A9752E4F4C7D97["ghost_orbs_queued"].size > 0) {
    randomangle = (randomfloat(360), randomfloat(360), 0);
    _id_A76189155F382805 = anglesToForward(randomangle);
    offset = _id_A76189155F382805 * 15;
    _id_0121BB966B0183A9 = _id_0121BB966B0183A9 + offset;
  }

  _id_54237F043461EC2E = spawnscriptable(scriptable, _id_0121BB966B0183A9);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pickups", "registerScriptableInstance"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("pickups", "registerScriptableInstance")]](_id_54237F043461EC2E);

  _id_54237F043461EC2E setscriptablepartstate("soulEater", "hover");
  _id_54237F043461EC2E.origin = _id_0121BB966B0183A9;
  _id_54237F043461EC2E._id_F2A8F2B283B7D205 = gettime() + _id_DC70D6717581D051();
  self._id_E7A9752E4F4C7D97["ghost_orbs_queued"][self._id_E7A9752E4F4C7D97["ghost_orbs_queued"].size] = _id_54237F043461EC2E;
}

_id_FF6FDDBFE2863E87(_id_439F0781DBD8A339) {
  foreach(_id_54237F043461EC2E in self._id_E7A9752E4F4C7D97["ghost_orbs_queued"]) {
    if(!isDefined(_id_54237F043461EC2E)) {
      continue;
    }
    _id_A18C67600040E511(_id_54237F043461EC2E, _id_439F0781DBD8A339);
    level thread _id_1EDE5E7AA1B373EF(_id_54237F043461EC2E);
  }

  self._id_E7A9752E4F4C7D97["ghost_orbs_queued"] = [];
}

_id_1EDE5E7AA1B373EF(_id_54237F043461EC2E) {
  wait 2;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pickups", "tryDeregisterScriptableInstance"))
    _id_54237F043461EC2E[[scripts\cp_mp\utility\script_utility::getsharedfunc("pickups", "tryDeregisterScriptableInstance")]]();

  _id_54237F043461EC2E freescriptable();
}

_id_40929B6A7B6F6B0B(_id_439F0781DBD8A339) {
  if(!isDefined(self)) {
    return;
  }
  _id_FDDF6DEC4B30ACA9();

  for(;;) {
    _id_4A86C2059578EAFF = undefined;
    success = 0;

    if(!_id_463B5F8E3214D062()) {
      break;
    }

    _id_4A86C2059578EAFF = _id_ED8AD4DB92185CD0(_id_439F0781DBD8A339);

    if(isDefined(_id_4A86C2059578EAFF)) {
      success = _id_435A7738BAA9E92D(_id_4A86C2059578EAFF, _id_439F0781DBD8A339);

      if(!istrue(success))
        _id_A18C67600040E511(_id_4A86C2059578EAFF, _id_439F0781DBD8A339);
    }

    if(istrue(success))
      _id_754CB80AA8948656(_id_439F0781DBD8A339);

    _id_024298ABDA5CAD25(_id_4A86C2059578EAFF);
  }

  _id_FF6FDDBFE2863E87(_id_439F0781DBD8A339);

  if(_id_49C5EC298FFE8C05())
    _id_D4E58629DB79E818();
}

_id_ED8AD4DB92185CD0(_id_439F0781DBD8A339) {
  self endon("death_or_disconnect");
  self endon("haunting_radar_unsub");
  self endon("gameended");

  while(level._id_F8FF77AC1F72D7C8.size >= 20)
    waitframe();

  _id_E4A58B54D2098E59 = self._id_E7A9752E4F4C7D97["ghost_orbs_queued"][0];

  while(gettime() < _id_E4A58B54D2098E59._id_F2A8F2B283B7D205)
    waitframe();

  _id_94338662BA36A6C0 = _id_E4A58B54D2098E59.origin;
  self._id_E7A9752E4F4C7D97["ghost_orbs_queued"] = scripts\engine\utility::array_remove(self._id_E7A9752E4F4C7D97["ghost_orbs_queued"], _id_E4A58B54D2098E59);
  _id_E4A58B54D2098E59 setscriptablepartstate("soulEater", "vanish");
  level thread _id_1EDE5E7AA1B373EF(_id_E4A58B54D2098E59);
  _id_4A86C2059578EAFF = spawn("script_model", _id_94338662BA36A6C0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pickups", "registerScriptableInstance"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("pickups", "registerScriptableInstance")]](_id_4A86C2059578EAFF);

  if(_id_439F0781DBD8A339)
    _id_4A86C2059578EAFF setModel("vfx_scriptable_ghosthunter_soul_trophy");
  else
    _id_4A86C2059578EAFF setModel("vfx_scriptable_ghosthunter_soul");

  level._id_F8FF77AC1F72D7C8 scripts\engine\utility::array_add(level._id_F8FF77AC1F72D7C8, _id_4A86C2059578EAFF);
  self._id_E7A9752E4F4C7D97["ghost_orbs_active"] = scripts\engine\utility::array_add(self._id_E7A9752E4F4C7D97["ghost_orbs_active"], _id_4A86C2059578EAFF);
  return _id_4A86C2059578EAFF;
}

_id_024298ABDA5CAD25(_id_4A86C2059578EAFF) {
  if(!isDefined(_id_4A86C2059578EAFF)) {
    return;
  }
  if(isDefined(level._id_F8FF77AC1F72D7C8))
    level._id_F8FF77AC1F72D7C8 = scripts\engine\utility::array_remove(level._id_F8FF77AC1F72D7C8, _id_4A86C2059578EAFF);

  if(isDefined(self) && isDefined(self._id_E7A9752E4F4C7D97["ghost_orbs_active"]))
    self._id_E7A9752E4F4C7D97["ghost_orbs_active"] = scripts\engine\utility::array_remove(self._id_E7A9752E4F4C7D97["ghost_orbs_active"], _id_4A86C2059578EAFF);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pickups", "tryDeregisterScriptableInstance"))
    _id_4A86C2059578EAFF[[scripts\cp_mp\utility\script_utility::getsharedfunc("pickups", "tryDeregisterScriptableInstance")]]();

  _id_4A86C2059578EAFF delete();
}

_id_435A7738BAA9E92D(_id_4A86C2059578EAFF, _id_439F0781DBD8A339) {
  self endon("death_or_disconnect");
  self endon("haunting_radar_unsub");
  level endon("game_ended");
  movetime = _id_4125312B6E5393BE(_id_4A86C2059578EAFF.origin);
  _id_4A86C2059578EAFF setscriptablepartstate("soulEater", "suck");
  _id_9F854E807C5CD5AC = gettime();
  _id_7E4A937328305990 = undefined;
  _id_4F356C2154F446C3 = undefined;
  zoffset = undefined;
  yoffset = undefined;
  baseorigin = _id_4A86C2059578EAFF.origin;
  thread _id_1E11B7B4BFE8CCDD(_id_4A86C2059578EAFF, movetime);

  for(;;) {
    if(!isDefined(self))
      return 0;

    if(_id_439F0781DBD8A339 && scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_loot_soul_trophy", "canGatherTrophies")) {
      if(!self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_loot_soul_trophy", "canGatherTrophies")]]())
        return 0;
    }

    _id_3B5803E733581858 = gettime() - _id_9F854E807C5CD5AC;
    remainingtime = movetime - _id_3B5803E733581858;
    _id_C0F879FCE2BA3932 = min(1, (_id_3B5803E733581858 + level.frameduration) / movetime);
    _id_BC08E2B32A09AB5A = level.frameduration * _id_C0F879FCE2BA3932;

    if(remainingtime > _id_BC08E2B32A09AB5A)
      _id_A26C953F7C94B3EA = _id_BC08E2B32A09AB5A / remainingtime;
    else
      _id_A26C953F7C94B3EA = 1.0;

    if(remainingtime <= 0) {
      break;
    }

    _id_F16CF0133810CF98 = scripts\engine\math::factor_value(5, 0, self playerads());
    f = anglesToForward(self getplayerangles()) * 20;
    _id_AC0E454AC96A77AC = anglestoup(self getplayerangles()) * -9;
    r = anglestoright(self getplayerangles()) * _id_F16CF0133810CF98;
    targetorigin = self getEye() + f + _id_AC0E454AC96A77AC + r;
    _id_83395E644C2F02B1 = targetorigin - baseorigin;
    _id_0C6A939BB6B06ABC = vectorNormalize(_id_83395E644C2F02B1);
    dist = length(_id_83395E644C2F02B1);

    if(!isDefined(_id_7E4A937328305990)) {
      _id_7E4A937328305990 = _id_E992D6012E92AB53(dist);
      _id_4F356C2154F446C3 = randomfloatrange(-2, -0.7) * _id_7E4A937328305990;
    }

    zoffset = _id_52CE0FD30445C072(movetime, _id_3B5803E733581858 + level.frameduration, _id_7E4A937328305990);
    yoffset = _id_52CE0FD30445C072(movetime, _id_3B5803E733581858 + level.frameduration, _id_4F356C2154F446C3);
    _id_451B84725D725896 = rotatevector(_id_0C6A939BB6B06ABC, (0, 90, 0));
    yoffset = _id_451B84725D725896 * yoffset;
    zoffset = (0, 0, zoffset);
    offset = dist * _id_A26C953F7C94B3EA * _id_0C6A939BB6B06ABC;
    baseorigin = baseorigin + offset;
    _id_4A86C2059578EAFF.origin = baseorigin + zoffset + yoffset;
    waitframe();
  }

  return 1;
}

_id_4125312B6E5393BE(_id_4121DCC131AC7073) {
  dist = length(_id_4121DCC131AC7073 - self.origin);
  _id_CCBBA16287668F0A = scripts\engine\math::normalize_value(300, 2000, dist);
  return scripts\engine\math::factor_value(0.4, 1.2, _id_CCBBA16287668F0A) * 1000;
}

_id_DC70D6717581D051() {
  return 800.0;
}

_id_E992D6012E92AB53(_id_9C81708EDCFD5D10) {
  _id_CCBBA16287668F0A = scripts\engine\math::normalize_value(300, 1000, _id_9C81708EDCFD5D10);
  return scripts\engine\math::factor_value(7, 25, _id_CCBBA16287668F0A);
}

_id_52CE0FD30445C072(movetime, _id_3B5803E733581858, _id_C4C8C6F99AF13350) {
  if(_id_3B5803E733581858 > movetime)
    return 1;

  _id_30C242BD56F50DEC = movetime * 0.5;

  if(_id_3B5803E733581858 > _id_30C242BD56F50DEC)
    frac = (_id_3B5803E733581858 - _id_30C242BD56F50DEC) / _id_30C242BD56F50DEC;
  else
    frac = 1 - _id_3B5803E733581858 / _id_30C242BD56F50DEC;

  frac = 1 - frac * frac;
  return frac * _id_C4C8C6F99AF13350;
}

_id_A18C67600040E511(_id_1C1110C942B19579, _id_439F0781DBD8A339) {
  _id_1C1110C942B19579 setscriptablepartstate("soulEater", "vanish");

  if(_id_439F0781DBD8A339 && scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_loot_soul_trophy", "ghostFailTrophyDrop"))
    _id_1C1110C942B19579[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_loot_soul_trophy", "ghostFailTrophyDrop")]]();
}

_id_1E11B7B4BFE8CCDD(ent, movetime) {
  self endon("death_or_disconnet");
  level endon("game_ended");
  delay_time = (movetime - 300) / 1000;
  wait(delay_time);

  if(soundexists("iw9_haunt_ghost_absorb"))
    self playSound("iw9_haunt_ghost_absorb");
}

_id_463B5F8E3214D062() {
  if(!isDefined(self))
    return 0;

  if(!isalive(self))
    return 0;

  if(!_id_0CBB0697DE4C5728::_id_E514ED60E2C9F9FC(self.currentweapon))
    return 0;

  if(self._id_E7A9752E4F4C7D97["ghost_orbs_queued"].size > 0)
    return 1;

  return 0;
}

_id_49C5EC298FFE8C05() {
  return self._id_E7A9752E4F4C7D97["ghost_orbs_absorbing"];
}

_id_FDDF6DEC4B30ACA9() {
  self._id_E7A9752E4F4C7D97["ghost_orbs_absorbing"] = 1;
  scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_ghostfinder_soul_absorb", 0, 1, 1);
  _id_0CBB0697DE4C5728::_id_4BED606F84DC5DEF();
}

_id_D4E58629DB79E818() {
  self._id_E7A9752E4F4C7D97["ghost_orbs_absorbing"] = 0;
  scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_ghostfinder_soul_absorb", 0, 1, 0);
  _id_0CBB0697DE4C5728::_id_89F97780FE2DB098();
}

_id_754CB80AA8948656(_id_439F0781DBD8A339) {
  if(isDefined(self) && _id_439F0781DBD8A339 && scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_loot_soul_trophy", "bankTrophies"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_loot_soul_trophy", "bankTrophies")]](1, "ai_kill_ghost");
  else
    thread _id_098B53A7358927D9::_id_E800498086E36C29("stat_2D65862CE8CA39F9", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);

  _id_0CBB0697DE4C5728::_id_6CEBD056176C1511();
  _id_0CBB0697DE4C5728::_id_AB1746BEF02556AB();
  self._id_E7A9752E4F4C7D97["ghost_orbs_collected"]++;
  scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_ghostfinder_soul_absorb", 1, 10, self._id_E7A9752E4F4C7D97["ghost_orbs_collected"]);
}