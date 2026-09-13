/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\oxygenmask.gsc
***********************************************/

_id_234851F94416F178() {
  level._id_F6BAD8618358A031 = spawnStruct();
  level._id_F6BAD8618358A031._id_3D605BC71C5D48E3 = "iw9_oxygenmask";
  level._id_F6BAD8618358A031._id_1DF8739F84D611AE = 99;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("oxygenmask", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("oxygenmask", "init")]]();
}

_id_24A2E2FA6ADC7F55() {
  if(istrue(self._id_23A6763562820C70) && scripts\common\utility::iscp())
    return 0;

  thread _id_80143A61B671BDD3();
  return 1;
}

_id_23A6763562820C70() {
  return istrue(self._id_23A6763562820C70);
}

_id_8FC85383E9F1B6E6() {
  if(istrue(self._id_23A6763562820C70)) {
    if(soundexists("cp_oxygenmask_hiss"))
      playsoundatpos(self.origin, "cp_oxygenmask_hiss");

    thread _id_A51CB31233EACF9E();

    if(isDefined(self._id_72F72F6558F6A22A))
      self._id_72F72F6558F6A22A delete();

    return 1;
  }

  return 0;
}

_id_80143A61B671BDD3() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("drop_oxygenmask");
  self notify("give_oxygenmask");
  self endon("give_oxygenmask");
  _id_893FF9B814E04F95 = self getcurrentweapon();

  if(_id_893FF9B814E04F95.basename != "none") {
    if(getdvarint("dvar_44F86DD3C04FBA8F", 0)) {
      if(scripts\common\utility::iscp())
        self forceplaygestureviewmodel("ges_magma_gas_mask_on");
      else
        self forceplaygestureviewmodel("ges_visor_down");
    }
  }

  if(scripts\common\utility::iscp()) {
    _id_3B64EB40368C1450::set("oxygenmask", "weapon_switch", 0);
    _id_3B64EB40368C1450::set("oxygenmask", "melee", 0);
    _id_3B64EB40368C1450::set("oxygenmask", "equipment_primary", 0);
    _id_3B64EB40368C1450::set("oxygenmask", "equipment_secondary", 0);
    _id_3B64EB40368C1450::set("oxygenmask", "weapon_pickup", 0);
  }

  _id_02F21B35828315A0(0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("oxygenmask", "onGive"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("oxygenmask", "onGive")]]();

  self._id_23A6763562820C70 = 1;
  self._id_C0EB949C54277B2C = undefined;

  if(scripts\common\utility::iscp()) {
    _id_4B87F2871B6B025C::_id_A05DE828303D4BED();
    childthread _id_4B87F2871B6B025C::_id_8C3428AEB7C8B1F4(10);
    _id_0C2EE77402D52BE9(level._id_F6BAD8618358A031._id_3D605BC71C5D48E3);
    wait 0.5;
  }

  thread _id_7D8291A3B08FA039();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("oxygenmask", "onEquip"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("oxygenmask", "onEquip")]]();

  _id_7823F77F978A3360();
}

_id_7823F77F978A3360() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("drop_oxygenmask");
  self endon("give_oxygenmask");

  for(;;) {
    wait 0.05;
    can_use = _id_67506C2318CA4DA2();
    _id_19D942C88226F136 = _id_027E7B88EA18125F();
    _id_D45CA71A300E2C90 = isDefined(self getcurrentweapon()) && isDefined(self getcurrentweapon().basename) && self getcurrentweapon().basename == level._id_F6BAD8618358A031._id_3D605BC71C5D48E3;
    _id_A7C6D05B37DCDE8E = isDefined(self.vehicle) && scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self.vehicle) == self || scripts\cp_mp\utility\player_utility::isusingremote();

    if(!_id_D45CA71A300E2C90 && !_id_A7C6D05B37DCDE8E)
      thread _id_A51CB31233EACF9E();

    if(_id_19D942C88226F136 && can_use) {
      _id_44524A0826F0975A(1);
      _id_EAE1981AB021806B();
      continue;
    }

    if(_id_19D942C88226F136 && !can_use) {
      _id_44524A0826F0975A(0);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("oxygenmask", "onUnusable"))
        self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("oxygenmask", "onUnusable")]]();

      continue;
    }

    if(can_use && !_id_19D942C88226F136) {
      _id_44524A0826F0975A(1);

      if(scripts\common\utility::iscp())
        _id_8B61DAC63B58C6CE("Ready");

      continue;
    }

    _id_44524A0826F0975A(0);

    if(scripts\common\utility::iscp())
      _id_8B61DAC63B58C6CE("Not Usable");
  }
}

_id_2E4CD4D627C30C24() {
  return _id_24A2E2FA6ADC7F55();
}

_id_2C9C3BC278844056() {}

_id_44524A0826F0975A(_id_41D8BF229CF29051) {
  if(isDefined(self._id_9C26D9C1EC7FDC65) && self._id_9C26D9C1EC7FDC65 == _id_41D8BF229CF29051) {
    return;
  }
  self._id_9C26D9C1EC7FDC65 = _id_41D8BF229CF29051;

  if(istrue(_id_41D8BF229CF29051))
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("oxygenmask_canfire");
  else
    _id_3B64EB40368C1450::set("oxygenmask_canfire", "fire", 0);
}

_id_02F21B35828315A0(_id_41D8BF229CF29051) {
  if(isDefined(self._id_58A1BD2C2C9338AD) && self._id_58A1BD2C2C9338AD == _id_41D8BF229CF29051) {
    return;
  }
  self._id_58A1BD2C2C9338AD = _id_41D8BF229CF29051;

  if(istrue(_id_41D8BF229CF29051))
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("oxygenmask_canads");
  else
    _id_3B64EB40368C1450::set("oxygenmask_canads", "ads", 0);
}

_id_0C2EE77402D52BE9(_id_848E355A646647A0) {
  self._id_9A46747153A02D2F = self getcurrentweapon();
  _id_4C31D0690F7E6D1D = makeweapon(_id_848E355A646647A0);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_4C31D0690F7E6D1D);
  self switchtoweaponimmediate(_id_4C31D0690F7E6D1D);
}

_id_581A506815C94633(deployweaponname) {
  self endon("death_or_disconnect");

  if(self isgestureplaying())
    self stopgestureviewmodel();

  if(self isviewmodelanimplaying())
    self stopviewmodelanim();

  objweapon = makeweapon(deployweaponname);
  result = scripts\cp_mp\utility\weapon_utility::_id_F19F8B4CF085ECBD(objweapon);
  return result;
}

_id_8B61DAC63B58C6CE(state) {
  if(self._id_FE2B9EE0479AD3CF != state) {
    self._id_FE2B9EE0479AD3CF = state;
    self notify("oxygenmask_changestate");
  }
}

_id_DDD53CC3C592BD02() {
  if(!isDefined(self._id_FE2B9EE0479AD3CF))
    return "";

  return self._id_FE2B9EE0479AD3CF;
}

_id_7D8291A3B08FA039() {
  self endon("disconnect");
  self notify("oxygenmask_handle_death");
  self endon("oxygenmask_handle_death");
  self waittill("death");

  if(!istrue(self._id_23A6763562820C70)) {
    return;
  }
  if(scripts\common\utility::iscp())
    self._id_72F72F6558F6A22A delete();

  thread _id_A51CB31233EACF9E();
  self waittill("spawned_player");
  wait 1;
  _id_24A2E2FA6ADC7F55();
}

_id_A51CB31233EACF9E() {
  self notify("drop_oxygenmask");
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("oxygenmask");
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("oxygenmask_canfire");
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("oxygenmask_canads");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("oxygenmask", "onRemove"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("oxygenmask", "onRemove")]]();

  self._id_23A6763562820C70 = undefined;
  self._id_A3BDE3B734D04764 = undefined;
  self._id_58A1BD2C2C9338AD = undefined;
  self._id_9C26D9C1EC7FDC65 = undefined;
  _id_893FF9B814E04F95 = self getcurrentweapon();

  if(_id_893FF9B814E04F95.basename != "none") {
    if(getdvarint("dvar_44F86DD3C04FBA8F", 0)) {
      if(scripts\common\utility::iscp())
        self forceplaygestureviewmodel("ges_magma_gas_mask_off");
      else
        self forceplaygestureviewmodel("ges_visor_up");
    }
  }
}

_id_027E7B88EA18125F() {
  if(self attackButtonPressed() || self buttonPressed("MOUSE1") || istrue(self._id_AF23415ABF13E8FA) && scripts\cp_mp\utility\player_utility::_id_988138367C74B1F5())
    return 1;

  return 0;
}

_id_67506C2318CA4DA2() {
  if(!scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(istrue(self.inlaststand))
    return 0;

  if(getdvarint("dvar_73621D9D9F54E301", 0))
    return 1;

  if(!self _meth_6F55D55CCFF20D14())
    return 0;

  if(self _meth_635E39FC16A64657())
    return 0;

  if(self israisingweapon())
    return 0;

  if(!isnullweapon(self getheldoffhand()))
    return 0;

  if(istrue(self._id_A3BDE3B734D04764))
    return 0;

  if(istrue(self._id_C0EB949C54277B2C))
    return 0;

  if(istrue(level._id_EC0BAA43406DE34A))
    return 0;

  if(istrue(self._id_8D47F4AF9323F11E))
    return 0;

  if(isDefined(self._id_984BD769A1E0201E)) {
    usetime = 4000;

    if(gettime() < self._id_984BD769A1E0201E + usetime)
      return 0;
  }

  return 1;
}

_id_BC75520A8C4707BA() {
  return getdvarfloat("dvar_C5320528E750D996", 0.75);
}

_id_EAE1981AB021806B() {
  self endon("death");
  self endon("oxygenmask_fail");
  _id_02F21B35828315A0(1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("oxygenmask", "onUse"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("oxygenmask", "onUse")]]();

  self._id_A3BDE3B734D04764 = 1;
  self._id_AF23415ABF13E8FA = undefined;
  self._id_984BD769A1E0201E = gettime();
  self playlocalsound("plr_breath_pain_init");
  thread _id_1AB4E7E73AD0C18E();
  thread _id_05EC8D8473D72B73();
  thread _id_2C9C3BC278844056();
  self notify("used_oxygen_mask");
  level notify("used_oxygen_mask", self);
  _id_110A8239B8D015BC = scripts\engine\utility::waittill_notify_or_timeout_return("weapon_fired", 4);

  if(_id_110A8239B8D015BC == "weapon_fired")
    thread _id_95812DCC553470BD();

  self notify("oxygenmask_fired");
  _id_9AC10CEC8E7B9D40();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("oxygenmask", "onUseComplete"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("oxygenmask", "onUseComplete")]]();

  if(getdvarint("dvar_1280AC8EF0DD0E07", 0))
    self waittill("can_use_mask_now");

  while(_id_027E7B88EA18125F())
    wait 0.05;
}

_id_1AB4E7E73AD0C18E() {
  self endon("oxygenmask_fail");
  self endon("drop_oxygenmask");
  self endon("death_or_disconnect");
  level endon("game_ended");
  wait 3.32;
  thread _id_44524A0826F0975A(0);
}

_id_9AC10CEC8E7B9D40() {
  self._id_A3BDE3B734D04764 = 0;
  _id_02F21B35828315A0(0);
}

_id_87A62A5519055B00() {
  self endon("death");
  delay = 1;

  if(istrue(self._id_D988FA5D07C2A5BD))
    delay = 0.1;

  self._id_D988FA5D07C2A5BD = 1;
  wait(delay);
  self _meth_05C5C9CBAE3114B0();
}

_id_64A40FAF54EFBDB0() {
  icon = "hud_icon_equipment_oxygen";
  offset = 16;
  _id_B9352C16DBBDC298 = 1;
  _id_1E440F4549D5E518 = [];

  if(level.players.size == 1) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    if(level.players[_id_AC0E594AC96AA3A8] != self)
      _id_1E440F4549D5E518[_id_1E440F4549D5E518.size] = level.players[_id_AC0E594AC96AA3A8];
  }

  self._id_0AFD8A16FCBA5B91 = scripts\cp_mp\entityheadicons::setheadicon_singleimage(_id_1E440F4549D5E518, icon, offset, 0, 512, 100, 0, 0, _id_B9352C16DBBDC298, undefined, 1);
}

_id_AFBABC657353367F() {
  if(isDefined(self._id_0AFD8A16FCBA5B91)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self._id_0AFD8A16FCBA5B91);
    self._id_0AFD8A16FCBA5B91 = undefined;
  }
}

_id_A6B42837C80F3C95() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_oxygenmask");
  currentstate = 0;

  for(;;) {
    if(self isufo() && currentstate == 0) {
      currentstate = 1;
      _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("debug_allow_shoot_while_ufoing");
    } else if(!self isufo() && currentstate == 1) {
      currentstate = 0;
      _id_3B64EB40368C1450::set("debug_allow_shoot_while_ufoing", "fire", 0);
    }

    wait 0.05;
  }
}

_id_95812DCC553470BD() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("give_oxygenmask");
  _id_96DA5F505495F48A = getdvarint("dvar_DBB8C128E4B02706", level._id_F6BAD8618358A031._id_1DF8739F84D611AE);
  _id_4B87F2871B6B025C::_id_8C3428AEB7C8B1F4(_id_96DA5F505495F48A, ::_id_BC75520A8C4707BA);
}

_id_05EC8D8473D72B73() {
  self endon("disconnect");
  level endon("game_ended");
  self _meth_9E7F47B1711DCA62();

  if(scripts\common\utility::iscp())
    childthread _id_87A62A5519055B00();
  else {
    scripts\engine\utility::waittill_any_2("oxygenmask_fail", "oxygenmask_fired");
    self _meth_05C5C9CBAE3114B0();
  }
}