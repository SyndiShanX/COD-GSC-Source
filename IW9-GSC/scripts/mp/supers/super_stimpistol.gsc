/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\supers\super_stimpistol.gsc
**************************************************/

_id_C916427F116F1206() {
  level._id_B5F053A7FF75210E = getdvarint("dvar_660A6D69270C9D7C", 1);
  level._id_7DDBBB03DA35CBA6 = getdvarint("dvar_3A7A4BF29F0F6E78", 0);
  level._id_D6A1A4D7B320F72B = getdvarint("dvar_BD6AD02D326BBFFC", 1);
  level._id_73A59765D6944026 = getdvarint("dvar_9F96B49415B4AFAB", 0);
}

_id_76CA0B3D8B2555CA(weaponobj) {
  if(!isDefined(weaponobj))
    return 0;

  return weaponobj.basename == "iw9_pi_stimpistol_mp";
}

_id_0A377D33613E0C83() {}

_id_C61EE6D60763E771() {
  return level._id_B5F053A7FF75210E || level._id_7DDBBB03DA35CBA6;
}

_id_31AFE9D7B373900F() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  _id_19163E14365D9264 = scripts\mp\supers::getcurrentsuper();
  scripts\mp\supers::setsuperisinuse(1);
  scripts\mp\supers::_id_330825804EBBD918(1);
  scripts\mp\supers::_id_A4496878854AE85B(_id_19163E14365D9264.staticdata.useweapon, undefined, 100);
  _id_7E52B56769FA7774::resetsuper();
}

_id_807B3B0A3B4128F9() {
  if(isDefined(self._id_B24E609023CE8208))
    self._id_B24E609023CE8208 = undefined;

  if(isDefined(self._id_98D31D9CE04B2B81))
    self._id_98D31D9CE04B2B81 = undefined;
}

_id_A35FFF2FF233592A() {
  _id_D3C112E63BF53EE5 = scripts\mp\supers::getcurrentsuper();

  if(!isDefined(_id_D3C112E63BF53EE5))
    return 0;

  if(_id_D3C112E63BF53EE5.staticdata.ref != "super_stimpistol")
    return 0;

  _id_A063A7CEBBE73076 = scripts\mp\supers::_id_3889D69492A93008();

  if(_id_A063A7CEBBE73076 > 0 || scripts\mp\supers::issuperready())
    return 1;

  return 0;
}

_id_7FC69415FB24CAE1() {
  self notify("super_stimPistol_watchHits");
  self endon("super_stimPistol_watchHits");
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("bullet_first_impact", _id_9D7CA6252F103A3B, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, _id_5E8EDE0EF6D7F3AB, surfacetype, weapon, _id_F07322C0D6CA069C, _id_25DE37BAEC255643, hitloc);

    if(isDefined(_id_1D9FB21B4F3023F3) && _id_76CA0B3D8B2555CA(weapon))
      thread _id_8A99CEBBC265563E(_id_1D9FB21B4F3023F3, _id_25DE37BAEC255643, weapon);
  }
}

_id_CE78FACE7E6DA5DE(_id_DE6D964CA3FB3603) {
  return isDefined(_id_DE6D964CA3FB3603) && isDefined(_id_DE6D964CA3FB3603._id_FF06B80996E03E04);
}

_id_40BCB765CC81E05F(_id_DE6D964CA3FB3603) {
  return isDefined(_id_DE6D964CA3FB3603) && isDefined(_id_DE6D964CA3FB3603._id_516A933930EB2C27);
}

_id_17EE2968B719A27E(_id_DF0969D1FC3F7545) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self notify("super_stimPistol_tagEntAsHit");
  self endon("super_stimPistol_tagEntAsHit");

  if(!isDefined(self._id_2E5DE68612C3DE1B))
    self._id_2E5DE68612C3DE1B = _id_DF0969D1FC3F7545;

  if(isDefined(self._id_65A2B57B2B474C00) && !istrue(self._id_65A2B57B2B474C00.inuse))
    self._id_65A2B57B2B474C00.inuse = 1;

  wait 3;

  while(scripts\mp\utility\player::getbeingrevivedinternal())
    wait 0.1;

  self._id_2E5DE68612C3DE1B = undefined;
}

_id_B66F1712709E29E1(_id_9E2CE04B5AD662F7, _id_BD37B214227476CA) {
  if(!isDefined(_id_9E2CE04B5AD662F7)) {
    return;
  }
  if(!isPlayer(_id_9E2CE04B5AD662F7) || !isbot(_id_9E2CE04B5AD662F7)) {
    return;
  }
  if(!istrue(_id_9E2CE04B5AD662F7.inlaststand) && !istrue(_id_9E2CE04B5AD662F7._id_C4C8B91E0B16AA5E)) {
    return;
  }
  if(_id_BD37B214227476CA == 1)
    _id_5762AC2F22202BA2::updatehitmarker("standard", 0, 0, 0, "hitlaststand_stimpistol", self getentitynumber());
  else if(_id_BD37B214227476CA == 2)
    _id_5762AC2F22202BA2::updatehitmarker("standard", 0, 0, 0, "hitcyber_stimpistol", self getentitynumber());
  else
    _id_5762AC2F22202BA2::updatehitmarker("standard", 0, 0, 0, undefined, self getentitynumber());
}

_id_F0D1C9C39359EFFF() {
  return isDefined(self._id_2E5DE68612C3DE1B);
}

_id_4BDCD177675C91BA(_id_22F7E3F7E360775B) {
  _id_DE6D964CA3FB3603 = spawnStruct();
  _id_DE6D964CA3FB3603.reviver = self;
  _id_DE6D964CA3FB3603._id_22F7E3F7E360775B = scripts\engine\utility::ter_op(isDefined(_id_22F7E3F7E360775B), _id_22F7E3F7E360775B, undefined);
  _id_DE6D964CA3FB3603._id_FF06B80996E03E04 = _id_22F7E3F7E360775B scripts\mp\teamrevive::_id_15933E1583288208();
  _id_DE6D964CA3FB3603._id_516A933930EB2C27 = scripts\engine\utility::ter_op(isDefined(_id_22F7E3F7E360775B._id_65A2B57B2B474C00), _id_22F7E3F7E360775B._id_65A2B57B2B474C00, undefined);
  _id_DE6D964CA3FB3603._id_5FCB2D7778DDDC58 = _id_44C1A12F54EC6A4F();
  _id_DE6D964CA3FB3603._id_5C9E2171F24A94D8 = _id_FA06085052105F5C();
  return _id_DE6D964CA3FB3603;
}

_id_22044A9973AA399C(_id_2ADFF297ED7EA301, _id_FAB59A8DC2F2BADC) {
  _id_DD515FCF025B2E79 = makeweapon("iw9_pi_stimpistol_mp");
  _id_2ADFF297ED7EA301 _id_8A99CEBBC265563E(_id_FAB59A8DC2F2BADC, _id_FAB59A8DC2F2BADC.origin, _id_DD515FCF025B2E79);
}

_id_8A99CEBBC265563E(_id_1D9FB21B4F3023F3, _id_25DE37BAEC255643, weapon) {
  level endon("game_ended");

  if(isDefined(_id_1D9FB21B4F3023F3))
    _id_1D9FB21B4F3023F3 endon("death_or_disconnect");

  if(!istrue(_id_76CA0B3D8B2555CA(weapon)))
    return 0;

  if(!isDefined(_id_1D9FB21B4F3023F3))
    return 0;

  if(!istrue(isPlayer(_id_1D9FB21B4F3023F3) || isagent(_id_1D9FB21B4F3023F3)))
    return 0;

  if(!isDefined(_id_1D9FB21B4F3023F3.team))
    return 0;

  if(!istrue(level._id_B5F053A7FF75210E || level._id_7DDBBB03DA35CBA6)) {
    if(_id_1D9FB21B4F3023F3.team != self.team)
      return 0;
  }

  _id_1D9FB21B4F3023F3 thread _id_17EE2968B719A27E(self);
  _id_DE6D964CA3FB3603 = _id_4BDCD177675C91BA(_id_1D9FB21B4F3023F3);

  if(istrue(level._id_D6A1A4D7B320F72B)) {
    if(isDefined(_id_DE6D964CA3FB3603._id_22F7E3F7E360775B) && _id_40BCB765CC81E05F(_id_DE6D964CA3FB3603) && scripts\mp\utility\player::isinlaststand(_id_DE6D964CA3FB3603._id_22F7E3F7E360775B)) {
      _id_466EB9801A8F5A59(_id_DE6D964CA3FB3603);
      scripts\cp_mp\challenges::_id_D997435895422ECC("super_stimpistol", 1);
      _id_B66F1712709E29E1(_id_1D9FB21B4F3023F3, 1);
      return;
    }
  }

  if(istrue(level._id_73A59765D6944026)) {
    if(_id_1D9FB21B4F3023F3.team != self.team && !istrue(level._id_7DDBBB03DA35CBA6))
      return 0;

    if(_id_CE78FACE7E6DA5DE(_id_DE6D964CA3FB3603)) {
      _id_ADA94A4D4DEECF34(_id_DE6D964CA3FB3603);
      scripts\cp_mp\challenges::_id_D997435895422ECC("super_stimpistol", 1);
      _id_B66F1712709E29E1(_id_1D9FB21B4F3023F3, 2);
    }

    thread _id_C40C231EAB2AF499(_id_1D9FB21B4F3023F3);
  }
}

_id_466EB9801A8F5A59(_id_DE6D964CA3FB3603) {
  _id_DE6D964CA3FB3603._id_22F7E3F7E360775B playsoundtoplayer("weap_stimpistol_plr_hit_revive", _id_DE6D964CA3FB3603._id_22F7E3F7E360775B);
  _id_DE6D964CA3FB3603._id_516A933930EB2C27._id_2EFB40714A6E9468 = 1;

  if(istrue(level._id_B5F053A7FF75210E))
    _id_DE6D964CA3FB3603._id_516A933930EB2C27._id_FD7344B9978191BE = 1;

  _id_DE6D964CA3FB3603.reviver._id_383E041E3E341315 = 1;
  _id_DE6D964CA3FB3603._id_516A933930EB2C27 notify("trigger", _id_DE6D964CA3FB3603.reviver);

  if(isDefined(_id_DE6D964CA3FB3603._id_22F7E3F7E360775B) && _id_DE6D964CA3FB3603._id_22F7E3F7E360775B.team == _id_DE6D964CA3FB3603.reviver.team)
    _id_74B851B7AA1EF32D::_id_693D12AA2C1C02C5(1, "superStimHeal");

  _id_6A8EC730B2BFA844::_id_C0A3853F9497FAD3(_id_DE6D964CA3FB3603);
}

_id_ADA94A4D4DEECF34(_id_DE6D964CA3FB3603) {
  _id_DE6D964CA3FB3603._id_22F7E3F7E360775B playsoundtoplayer("weap_stimpistol_plr_hit_revive", _id_DE6D964CA3FB3603._id_22F7E3F7E360775B);
  _id_DE6D964CA3FB3603._id_FF06B80996E03E04._id_2EFB40714A6E9468 = 1;
  _id_DE6D964CA3FB3603._id_FF06B80996E03E04._id_070814AA80E0D3D1 = 1;
  _id_DE6D964CA3FB3603._id_FF06B80996E03E04.useweapon = undefined;
  _id_DE6D964CA3FB3603._id_FF06B80996E03E04._id_C99A7A6AF360DABE = 1;

  if(istrue(level._id_7DDBBB03DA35CBA6))
    _id_DE6D964CA3FB3603._id_FF06B80996E03E04._id_C0EE3288DBEC12C6 = 1;

  scripts\mp\teamrevive::_id_301C4EC489F9BD39(_id_DE6D964CA3FB3603._id_FF06B80996E03E04, scripts\mp\teamrevive::_id_692CDF5F87A8667B(), undefined, _id_DE6D964CA3FB3603.reviver, undefined, undefined);

  if(isDefined(_id_DE6D964CA3FB3603._id_22F7E3F7E360775B) && _id_DE6D964CA3FB3603._id_22F7E3F7E360775B.team == _id_DE6D964CA3FB3603.reviver.team)
    _id_74B851B7AA1EF32D::_id_693D12AA2C1C02C5(1, "superStimHeal");
}

_id_C40C231EAB2AF499(_id_1D9FB21B4F3023F3) {
  _id_1D9FB21B4F3023F3 notify("super_stimPistol_startCyberRevive_retryThread");
  _id_1D9FB21B4F3023F3 endon("super_stimPistol_startCyberRevive_retryThread");
  _id_1D9FB21B4F3023F3 endon("last_stand_start");
  _id_1D9FB21B4F3023F3 endon("death_or_disconnect");
  _id_DE6D964CA3FB3603 = _id_4BDCD177675C91BA(_id_1D9FB21B4F3023F3);
  _id_15AB0F77EAB429FC = 0;

  while(!_id_CE78FACE7E6DA5DE(_id_DE6D964CA3FB3603) && istrue(_id_1D9FB21B4F3023F3._id_C4C8B91E0B16AA5E) && scripts\mp\utility\game::isteamreviveenabled()) {
    _id_15AB0F77EAB429FC++;
    wait 1;
    _id_1D9FB21B4F3023F3 _id_17EE2968B719A27E(self);

    if(_id_CE78FACE7E6DA5DE(_id_DE6D964CA3FB3603)) {
      _id_ADA94A4D4DEECF34(_id_DE6D964CA3FB3603);
      scripts\cp_mp\challenges::_id_D997435895422ECC("super_stimpistol", 1);
      break;
    }

    if(_id_15AB0F77EAB429FC >= 5) {
      break;
    }
  }
}

_id_FA06085052105F5C() {
  _id_54427304348423AB = scripts\engine\utility::ter_op(isDefined(level._id_04B91C5DB6B16C58), level._id_04B91C5DB6B16C58, 5);
  return scripts\engine\utility::ter_op(isDefined(_id_54427304348423AB), _id_54427304348423AB, undefined);
}

_id_44C1A12F54EC6A4F() {
  _id_54427304348423AB = scripts\mp\laststand::getdefaultlaststandrevivetimervalue();
  return scripts\engine\utility::ter_op(isDefined(_id_54427304348423AB), _id_54427304348423AB, undefined);
}

_id_321C7891711E583F() {
  thread _id_7FC69415FB24CAE1();
  _id_AD32396BD89936BB(0);
  scripts\cp_mp\challenges::_id_D997435895422ECC("super_stimpistol", 0);
  return 1;
}

_id_F5037BA4A5399B63(_id_FCEF8D217A441961) {
  self notify("super_stimPistol_watchHits");
  _id_AD32396BD89936BB(1);
  self._id_BF5B10918F8418A1 = undefined;
}

_id_9DB6A100A4046D0C() {
  scripts\mp\utility\perk::giveperk("specialty_pistoldeath");
}

_id_3F29F7CEB8C0EC6D() {
  self._id_B24E609023CE8208 = undefined;
  self._id_98D31D9CE04B2B81 = undefined;
  scripts\mp\utility\perk::removeperk("specialty_pistoldeath");
}

_id_AD32396BD89936BB(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  if(_id_77C892C2CEC7A0EB)
    self enableweaponpickup();
  else
    self disableweaponpickup();
}

_id_D44B1FE27EE0494F() {
  waittime = 10;
  thread _id_2CEDCC356F1B9FC8::playerplaygestureweaponanim("iw9_vm_ges_stimpistol_dart_remove", waittime);
}