/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\supers\super_laser_charge.gsc
****************************************************/

_id_38A4F67440CF220E() {
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("laserRaise", ["allow_jump", "mantle", "melee", "usability", "killstreaks", "supers", "gesture", "allow_movement", "offhand_weapons", "crouch", "prone", "sprint", "execution_attack", "execution_victim"]);
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("laserFire", ["allow_jump", "mantle", "melee", "usability", "killstreaks", "supers", "gesture", "weapon_switch", "allow_movement", "offhand_weapons", "crouch", "prone", "sprint", "execution_attack", "execution_victim"]);
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("laserDrop", ["allow_jump", "mantle", "melee", "usability", "killstreaks", "supers", "gesture", "allow_movement", "offhand_weapons", "crouch", "prone", "sprint", "execution_attack", "execution_victim"]);
}

_id_37DDCDE87B74CC48() {
  result = _id_2B8F6CDB729062B4();

  if(!istrue(result))
    return 0;

  return 1;
}

_id_2B8F6CDB729062B4() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(self _meth_E40102956C887F7C()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("SUPER_MP/SUPER_CANNOT_USE_SWIM");

    return 0;
  }

  if(!self isonground()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("SUPER_MP/SUPER_CANNOT_USE_AIR");

    return 0;
  }

  if(scripts\cp_mp\utility\player_utility::isinvehicle(1))
    return 0;

  _id_424B1932C6E3004A = self _meth_29C14C6E321B9789("stand");

  if(istrue(_id_424B1932C6E3004A)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("SUPER_MP/SUPER_CANNOT_USE_SPACE");

    return 0;
  }

  _id_22C4300CE1D248E8 = self.origin + (0, 0, 5);
  _id_98C6610C2907BA2B = _id_22C4300CE1D248E8 + (0, 0, 80);
  contentoverride = scripts\engine\trace::create_contents(0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0);
  _id_11902ED3594B784B = scripts\engine\trace::ray_trace(_id_22C4300CE1D248E8, _id_98C6610C2907BA2B, self, contentoverride);

  if(isDefined(_id_11902ED3594B784B)) {
    if(_id_11902ED3594B784B["hittype"] != "hittype_none" || !scripts\engine\trace::sphere_trace_passed(_id_98C6610C2907BA2B, _id_98C6610C2907BA2B, 15, self, contentoverride)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("SUPER_MP/SUPER_CANNOT_USE_SPACE");

      return 0;
    }
  }

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    self setclientomnvar("ui_br_inventory_disabled", 1);

  _id_0E85BB71774631A2 = self getstance();

  if(_id_0E85BB71774631A2 != "stand")
    self setstance("stand");

  _id_DE3C27C551C3DFBD = self.pers["lastStanceChangeTime"];

  if(isDefined(_id_DE3C27C551C3DFBD)) {
    _id_31E819A78D024D77 = (gettime() - _id_DE3C27C551C3DFBD) / 1000;
    _id_E6D9634522574C56 = 0;

    if(_id_31E819A78D024D77 < 0.8)
      _id_E6D9634522574C56 = 0.8 - _id_31E819A78D024D77;

    if(_id_E6D9634522574C56 > 0)
      wait(_id_E6D9634522574C56);
  }

  _id_3B64EB40368C1450::_id_3633B947164BE4F3("laserRaise", 0);
  thread scripts\mp\hud_message::showsplash("super_laser_charge_activate", undefined, self, undefined, undefined, undefined, 1);
  self setclientomnvar("ui_field_upgrade_use", 0);
  scripts\mp\utility\perk::giveperk("specialty_super_protection");
  objweapon = makeweapon("super_laser_charge_mp", ["lasercustom_super_laser"]);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(objweapon);
  thread _id_F9C583614E43D70B();
  self setscriptablepartstate("superpowers", "laser_charge", 0);
  _id_D54D53EAF955518D = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(objweapon, 1, 1);

  if(!istrue(_id_D54D53EAF955518D)) {
    self setscriptablepartstate("superpowers", "off", 0);
    scripts\mp\utility\perk::removeperk("specialty_super_protection");
    _id_3B64EB40368C1450::_id_588F2307A3040610("laserRaise");
    thread scripts\cp_mp\utility\inventory_utility::getridofweapon(objweapon, 1);

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
      self setclientomnvar("ui_br_inventory_disabled", 0);

    return 0;
  }

  _id_57E6C0E97F405130(objweapon);
  return 1;
}

_id_F9C583614E43D70B() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  _id_CC9E0298558036CF = self.suit;
  _id_ACD43AAE173CBA08 = "iw9_laser_eye_mp";
  scripts\mp\utility\player::_setsuit(_id_ACD43AAE173CBA08);
  self waittill("superLaserCharge_finished");
  scripts\mp\utility\player::_setsuit(_id_CC9E0298558036CF);
}

_id_57E6C0E97F405130(_id_76CE32A62B846A64) {
  self.super.isactive = 1;
  scripts\mp\utility\perk::giveperk("specialty_third_person");
  self _meth_912BCA3D116ED827("tempvlaser");
  _id_3A9F59811A994A17();
  thread _id_0C3BA229B98DC584();
  _id_3AE043BBB7B2FDF0 = spawn("script_model", self gettagorigin("tag_eye"));
  _id_3AE043BBB7B2FDF0 setModel("super_laser_charge_impact");
  _id_3AE043BBB7B2FDF0 dontinterpolate();
  thread _id_D962BEF837CC0B26(_id_76CE32A62B846A64, _id_3AE043BBB7B2FDF0);
  thread _id_701F65BFF172B328(_id_3AE043BBB7B2FDF0);
}

_id_D962BEF837CC0B26(_id_76CE32A62B846A64, _id_3AE043BBB7B2FDF0) {
  self endon("disconnect");
  _id_3B64EB40368C1450::_id_588F2307A3040610("laserRaise");
  _id_3B64EB40368C1450::_id_3633B947164BE4F3("laserFire", 0);
  thread _id_2FD73AEAB5C5946D(_id_3AE043BBB7B2FDF0);
  thread _id_FC9013FB22941577();
  _id_EB3AA4092C07D861 = 0;
  _id_DC9CDB0DDE14C2E3 = 1;
  _id_117A5F27B3FFAB8E = 0;
  _id_3F53C2D5D19E37C1 = 0;
  _id_F5AF0B5D26948D94 = 0;
  _id_A7BE10E54A3A4B99 = weaponclipsize(_id_76CE32A62B846A64);

  while(!istrue(self._id_2DD3E994A0214AD1)) {
    currentweapon = self getcurrentweapon();
    _id_B971E09CE070BD58 = self getweaponammoclip(_id_76CE32A62B846A64);

    if(currentweapon == _id_76CE32A62B846A64 && _id_B971E09CE070BD58 < _id_A7BE10E54A3A4B99) {
      if(!istrue(_id_3F53C2D5D19E37C1)) {
        _id_3F53C2D5D19E37C1 = 1;
        self notify("superLaserCharge_start_fire");
      }
    }

    if(!istrue(_id_769566AB9E727F94(currentweapon, _id_76CE32A62B846A64))) {
      _id_117A5F27B3FFAB8E = 1;

      if(!scripts\mp\utility\player::isreallyalive(self) || scripts\mp\utility\player::isinlaststand(self))
        _id_EB3AA4092C07D861 = 1;

      if(istrue(_id_3F53C2D5D19E37C1))
        _id_DC9CDB0DDE14C2E3 = 0;
      else
        _id_F5AF0B5D26948D94 = 1;

      break;
    }

    if(_id_B971E09CE070BD58 <= 10) {
      break;
    }

    waitframe();
  }

  self notify("superLaserCharge_stop_fire");

  if(istrue(_id_117A5F27B3FFAB8E) || istrue(self._id_2DD3E994A0214AD1)) {
    _id_3B64EB40368C1450::_id_588F2307A3040610("laserFire");
    thread scripts\cp_mp\utility\inventory_utility::getridofweapon(_id_76CE32A62B846A64, 1);
    self notify("superLaserCharge_finished");
    scripts\mp\utility\perk::removeperk("specialty_third_person");
    scripts\mp\utility\perk::removeperk("specialty_super_protection");

    if(istrue(self._id_2DD3E994A0214AD1)) {
      self._id_2DD3E994A0214AD1 = undefined;
      self _meth_05C5C9CBAE3114B0();
    }
  } else {
    _id_3B64EB40368C1450::_id_588F2307A3040610("laserFire");
    _id_3B64EB40368C1450::_id_3633B947164BE4F3("laserDrop", 0);
    thread scripts\cp_mp\utility\inventory_utility::getridofweapon(_id_76CE32A62B846A64);
    wait 1;
    self notify("superLaserCharge_finished");
    scripts\mp\utility\perk::removeperk("specialty_third_person");
    scripts\mp\utility\perk::removeperk("specialty_super_protection");
    _id_3B64EB40368C1450::_id_588F2307A3040610("laserDrop");
  }

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    self setclientomnvar("ui_br_inventory_disabled", 0);

  _id_104E3370B024F998::_id_269B97F3D86EB172(_id_EB3AA4092C07D861, _id_DC9CDB0DDE14C2E3);

  if(istrue(_id_F5AF0B5D26948D94))
    _id_76AC6722CB845C98();
}

_id_FC9013FB22941577() {
  self endon("disconnect");
  self endon("superLaserCharge_start_fire");
  self endon("superLaserCharge_stop_fire");
  wait 2;
  self._id_2DD3E994A0214AD1 = 1;
}

_id_769566AB9E727F94(currentweapon, _id_76CE32A62B846A64) {
  _id_C68EFA84B7136F03 = istrue(level.gameended);
  _id_0A80FE11AED36C72 = currentweapon == _id_76CE32A62B846A64;
  return scripts\mp\utility\player::isreallyalive(self) && self isonground() && istrue(_id_0A80FE11AED36C72) && !scripts\mp\utility\player::isinlaststand(self) && !self _meth_E40102956C887F7C() && !self isonladder() && !_id_C68EFA84B7136F03;
}

_id_3A9F59811A994A17() {
  _id_5985D426AA39D205 = 50;
  _id_22C4300CE1D248E8 = self gettagorigin("j_spineupper");
  _id_4B787D72C87EDFD7 = _id_22C4300CE1D248E8 + anglestoright(self.angles) * _id_5985D426AA39D205;
  _id_D809CFCC948BB9FF = scripts\engine\trace::ray_trace(_id_22C4300CE1D248E8, _id_4B787D72C87EDFD7, self, scripts\engine\trace::create_default_contents(1));
  _id_D8B6B92DB6431A66 = undefined;

  if(isDefined(_id_D809CFCC948BB9FF) && _id_D809CFCC948BB9FF["hittype"] != "hittype_none")
    _id_D8B6B92DB6431A66 = distance2dsquared(_id_22C4300CE1D248E8, _id_D809CFCC948BB9FF["position"]);

  _id_61795BC1D5BE4F22 = _id_22C4300CE1D248E8 - anglestoright(self.angles) * _id_5985D426AA39D205;
  _id_BDF14B0D52E29044 = scripts\engine\trace::ray_trace(_id_22C4300CE1D248E8, _id_61795BC1D5BE4F22, self, scripts\engine\trace::create_default_contents(1));
  _id_E386728FD4C32E07 = undefined;

  if(isDefined(_id_BDF14B0D52E29044) && _id_BDF14B0D52E29044["hittype"] != "hittype_none")
    _id_E386728FD4C32E07 = distance2dsquared(_id_22C4300CE1D248E8, _id_BDF14B0D52E29044["position"]);

  _id_E4E4333961B8666A = 1;

  if(isDefined(_id_D8B6B92DB6431A66) && isDefined(_id_E386728FD4C32E07) && _id_D8B6B92DB6431A66 > _id_E386728FD4C32E07)
    _id_E4E4333961B8666A = 0;
  else if(!isDefined(_id_D8B6B92DB6431A66))
    _id_E4E4333961B8666A = 0;

  self _meth_2F14C0DD77FA8616(_id_E4E4333961B8666A);
}

_id_2FD73AEAB5C5946D(_id_3AE043BBB7B2FDF0) {
  self endon("disconnect");
  self _meth_9E7F47B1711DCA62();
  self playlocalsound("weap_lasereyes_levitate");
  self playSound("weap_lasereyes_levitate_npc", self, self);
  _id_5E8542114221E306 = scripts\engine\utility::waittill_any_timeout_1(1.5, "superLaserCharge_stop_fire");

  if(!isDefined(_id_5E8542114221E306) || _id_5E8542114221E306 != "timeout") {
    self _meth_05C5C9CBAE3114B0();
    return;
  }

  thread scripts\mp\supers::updateusetimedecay();
  self playlocalsound("weap_laser_fire_start");
  self playSound("weap_laser_fire_start_npc", self, self);
  _id_3AE043BBB7B2FDF0 setscriptablepartstate("laser_impact", "on", 0);
  self waittill("superLaserCharge_stop_fire");
  self playlocalsound("weap_laser_fire_stop");
  self playSound("weap_laser_fire_stop_npc", self, self);
  self _meth_05C5C9CBAE3114B0();

  if(isDefined(_id_3AE043BBB7B2FDF0)) {
    _id_3AE043BBB7B2FDF0 setscriptablepartstate("laser_impact", "off", 0);
    _id_3AE043BBB7B2FDF0 delete();
  }
}

_id_701F65BFF172B328(_id_3AE043BBB7B2FDF0) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(isDefined(_id_3AE043BBB7B2FDF0)) {
    _id_6A31D62C64E37D60 = scripts\cp_mp\utility\player_utility::_id_A104C06453297036(self);

    if(isDefined(_id_6A31D62C64E37D60))
      _id_3AE043BBB7B2FDF0.origin = _id_6A31D62C64E37D60;

    wait 0.05;
  }
}

_id_4595A2E368E64B18(_id_FCEF8D217A441961) {
  self.super.isactive = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br", "superSlotCleanUp"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("br", "superSlotCleanUp")]](self);

  return 0;
}

_id_BE41FD9988F890D9() {
  if(scripts\mp\utility\game::getgametype() != "infect") {
    scripts\mp\supers::combatrecordsuperkill("super_laser_charge");
    self._id_E3CA8EBB9BA5260D++;
    _id_2A46027B0350B6AA = scripts\mp\supers::getcombatrecordsupermisc("super_laser_charge");

    if(self._id_E3CA8EBB9BA5260D > _id_2A46027B0350B6AA) {
      _id_2F977E27FA739602 = self._id_E3CA8EBB9BA5260D - _id_2A46027B0350B6AA;
      scripts\mp\supers::combatrecordsupermisc("super_laser_charge", _id_2F977E27FA739602);
    }
  }
}

_id_0C3BA229B98DC584() {
  self endon("death_or_disconnect");
  self endon("super_use_finished");
  self notify("superLaserCharge_watchForGameEnded");
  self endon("superLaserCharge_watchForGameEnded");
  level scripts\engine\utility::waittill_any_2("game_ended", "prematch_cleanup");
  thread scripts\mp\supers::superusefinished();
}

_id_76AC6722CB845C98() {
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    _id_7E52B56769FA7774::_givebrsuper("equip_laser_charge", "super_laser_charge", 1);
  else
    scripts\mp\perks\perkpackage::perkpackage_giveimmediate("super_laser_charge");
}