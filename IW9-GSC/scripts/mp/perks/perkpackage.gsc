/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\perks\perkpackage.gsc
***********************************************/

perkpackage_initperkpackages() {
  perkpackage_initpersdata();
  thread perkpackage_updateifchanged();
  thread perkpackage_checkifready();
}

perkpackage_checkifready() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("giveLoadout_start");
  _id_8EF825FBC5430D59 = 0;

  for(;;) {
    if(!self.perkpackagedata.isusing && scripts\mp\supers::issuperready()) {
      if(self.perkpackagedata.istwomode) {
        perkpackage_setstate(1);

        if(1) {
          _id_FBFF879439B14D48();

          if(isDefined(level.perkpackage_checkifready_callback))
            [[level.perkpackage_checkifready_callback]]();
        }
      }

      if(_id_8EF825FBC5430D59)
        thread scripts\mp\supers::showsuperremindersplash();
    }

    self waittill("super_ready", _id_8EF825FBC5430D59);
  }
}

perkpackage_updateifchanged() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("giveLoadout_start");
  firstupgrade = perkpackage_getfirstfieldupgrade();
  secondupgrade = perkpackage_getsecondfieldupgrade();
  _id_746040613A0352BA = isDefined(self.super);
  _id_FB362A84D7BD0E19 = !isDefined(self.perkpackagedata.firstupgrade) || self.perkpackagedata.firstupgrade != firstupgrade;
  _id_07195CC142F4DBB5 = !isDefined(self.perkpackagedata.secondupgrade) || self.perkpackagedata.secondupgrade != secondupgrade;

  if(!_id_746040613A0352BA || _id_FB362A84D7BD0E19 || _id_07195CC142F4DBB5 || self.perkpackagedata.forcereset) {
    _id_1073D2B465F8A419 = scripts\mp\supers::getsuperid(firstupgrade);
    self setclientomnvar("ui_perk_package_super1", _id_1073D2B465F8A419);
    _id_41297BE0F018B86D = scripts\mp\supers::getsuperid(secondupgrade);
    self setclientomnvar("ui_perk_package_super2", _id_41297BE0F018B86D);

    if(isDefined(scripts\mp\supers::getcurrentsuper())) {
      if(self.perkpackagedata.forcereset)
        scripts\mp\supers::setsuperbasepoints(0);
      else {
        _id_7460D810DB8A0BA9 = scripts\mp\supers::getcurrentsuperpoints();
        _id_FB3D43F4D6D424EE = _id_7460D810DB8A0BA9 - 0;
        _id_FB3D43F4D6D424EE = max(_id_FB3D43F4D6D424EE, 0);

        if(!scripts\mp\supers::issuperinuse() && scripts\mp\supers::getcurrentsuperpoints() < scripts\mp\supers::getsuperpointsneeded())
          scripts\mp\supers::setsuperbasepoints(_id_FB3D43F4D6D424EE, 1);
      }
    }

    if(firstupgrade == "none" && secondupgrade == "none") {
      self.perkpackagedata.istwomode = 0;
      scripts\mp\supers::_id_E78F07EFBCDB9E97();
      perkpackage_setstate(0);
      self.perkpackagedata.super = undefined;
      scripts\mp\supers::clearsuper();
    } else if(secondupgrade == "none") {
      self.perkpackagedata.istwomode = 0;
      scripts\mp\supers::_id_E78F07EFBCDB9E97();
      perkpackage_setstate(3);
      self.perkpackagedata.super = firstupgrade;

      if(isDefined(self._id_678855513F5076CA) && scripts\mp\perks\perkfunctions::_id_66F0CBD5FF8458FE())
        scripts\mp\supers::givesuper(self.perkpackagedata.super, 0, 0);
      else
        scripts\mp\supers::givesuper(self.perkpackagedata.super, 1, 0);
    } else if(firstupgrade == "none") {
      self.perkpackagedata.istwomode = 0;
      scripts\mp\supers::_id_E78F07EFBCDB9E97();
      perkpackage_setstate(4);
      self.perkpackagedata.super = secondupgrade;

      if(isDefined(self._id_678855513F5076CA) && scripts\mp\perks\perkfunctions::_id_66F0CBD5FF8458FE())
        scripts\mp\supers::givesuper(self.perkpackagedata.super, 0, 0);
      else
        scripts\mp\supers::givesuper(self.perkpackagedata.super, 1, 0);
    } else {
      self.perkpackagedata.istwomode = 1;
      scripts\mp\supers::_id_C9491DF86B072612();
      perkpackage_setstate(0);
      _id_FBFF879439B14D48();
    }

    _id_35B042C5224A1646 = scripts\mp\supers::_id_D8F9E4158E12DE6B();

    if(_id_FB362A84D7BD0E19 || _id_07195CC142F4DBB5) {
      if(isDefined(_id_35B042C5224A1646)) {
        if(_id_35B042C5224A1646 != firstupgrade && _id_35B042C5224A1646 != secondupgrade)
          scripts\mp\supers::_id_26F98B45FB791C0E();
      }
    }

    if(!istrue(self.perkpackagedata.istwomode)) {
      if(isDefined(_id_35B042C5224A1646) && _id_35B042C5224A1646 != firstupgrade)
        scripts\mp\supers::_id_26F98B45FB791C0E();
    }

    if(scripts\mp\supers::issuperready())
      thread scripts\mp\supers::showsuperremindersplash();

    self.perkpackagedata.forcereset = 0;
    self.perkpackagedata.firstupgrade = firstupgrade;
    self.perkpackagedata.secondupgrade = secondupgrade;
  }
}

_id_FBFF879439B14D48() {
  if(isDefined(self.perkpackagedata.super) && self.perkpackagedata.super != "super_select") {
    self.perkpackagedata._id_E5DA01E1954B6734 = self.perkpackagedata.super;

    if(scripts\mp\supers::_id_04B10D71720FC4A4(self.perkpackagedata._id_E5DA01E1954B6734))
      scripts\mp\supers::_id_7ABBEE267D3AAD2F(self.perkpackagedata._id_E5DA01E1954B6734);
  }

  self.perkpackagedata.super = "super_select";

  if(isDefined(self._id_678855513F5076CA) && scripts\mp\perks\perkfunctions::_id_66F0CBD5FF8458FE())
    scripts\mp\supers::givesuper(self.perkpackagedata.super, 0, 0);
  else
    scripts\mp\supers::givesuper(self.perkpackagedata.super, 1, 0);
}

perkpackage_isreadytoupgrade() {
  if(!isDefined(self.perkpackagedata))
    return 0;

  if(self.perkpackagedata.state != 1)
    return 0;

  return 1;
}

perkpackage_setstate(_id_9B1941CB7354665E) {
  self setclientomnvar("ui_perk_package_state", _id_9B1941CB7354665E);
  self.perkpackagedata.state = _id_9B1941CB7354665E;
}

perkpackage_getfirstfieldupgrade() {
  _id_B5F07F928D5E50C1 = self.loadoutfieldupgrade1;

  if(isDefined(self.overridefieldupgrade1))
    _id_B5F07F928D5E50C1 = self.overridefieldupgrade1;

  return _id_B5F07F928D5E50C1;
}

perkpackage_getsecondfieldupgrade() {
  _id_B5F07F928D5E50C1 = self.loadoutfieldupgrade2;

  if(isDefined(self.overridefieldupgrade2))
    _id_B5F07F928D5E50C1 = self.overridefieldupgrade2;

  return _id_B5F07F928D5E50C1;
}

perkpackage_initpersdata() {
  self.perkpackagedata = self.pers["perkPackageData"];

  if(!isDefined(self.perkpackagedata)) {
    self.perkpackagedata = spawnStruct();
    self.perkpackagedata.state = 0;
    self.perkpackagedata.forcereset = 0;
    self.perkpackagedata.isusing = 0;
    self.perkpackagedata.firstupgrade = undefined;
    self.perkpackagedata.secondupgrade = undefined;
    self.perkpackagedata.super = "super_select";
    self.perkpackagedata.istwomode = 0;
    self.perkpackagedata._id_E5DA01E1954B6734 = undefined;
    self.pers["perkPackageData"] = self.perkpackagedata;

    if(!isagent(self))
      self setclientomnvar("ui_perk_package_state", self.perkpackagedata.state);

    if(isDefined(self.perkpackagedata.overridepointsneeded))
      scripts\mp\supers::_id_E78F07EFBCDB9E97();
  }
}

perkpackage_getperkicon() {
  return "hud_icon_perk_blast_shield";
}

perkpackage_openselect() {
  _id_955C555BA29302C2 = perkpackagemenu_canactivatesuper();
  isready = perkpackage_isreadytoupgrade();

  if(!_id_955C555BA29302C2)
    return 0;
  else if(!isready)
    return 0;
  else {
    thread perkpackagemenu_openmenu();
    self notify("perkPackage_endThink");
    thread _id_A33BBA529DA2A532();
    return 1;
  }
}

_id_A33BBA529DA2A532() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  waitframe();
  self notify("superWeaponForceHoldSucceed");
}

perkpackagemenu_openmenu() {
  _id_3B64EB40368C1450::set("ppmenu", "killstreaks", 0);
  _id_3B64EB40368C1450::set("ppmenu", "offhand_weapons", 0);
  self notifyonplayercommand("perkPackageMenu_option1", "+smoke");
  self notifyonplayercommand("perkPackageMenu_option2", "+frag");
  thread perkpackagemenu_closeinputthink();
  success = perkpackagemenu_menuthink();
  success = istrue(success);

  if(isDefined(self)) {
    self notify("perkPackage_endMenuThink");
    _id_3179AFAA208DEFA2 = !success;

    if(scripts\mp\utility\player::isreallyalive(self)) {
      self notifyonplayercommandremove("perkPackageMenu_option1", "+smoke");
      self notifyonplayercommandremove("perkPackageMenu_option2", "+frag");
      scripts\mp\supers::superusefinished(_id_3179AFAA208DEFA2, 1);
      _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("ppmenu");
    } else if(!scripts\mp\utility\player::isreallyalive(self) && _id_3179AFAA208DEFA2)
      thread _id_A7FBAF375D6D6BFA();

    if(success)
      perkpackage_awardperkpackageupgrade();
    else
      self.perkpackagedata.super = "super_select";
  }
}

perkpackagemenu_menuthink() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("giveLoadout_start");
  perkpackage_setstate(2);
  _id_8DAF361258C0DC41(1);
  _id_1FA6614C0C6F0FCF = getdvarfloat("dvar_6BAABDF45E17ACC1", 0.0);
  wait(_id_1FA6614C0C6F0FCF);
  result = scripts\engine\utility::waittill_any_return_5("perkPackageMenu_option1", "perkPackageMenu_option2", "perkPackageMenu_close", "death", "super_disable_start");
  _id_74FA01BD3626F0B7 = 0;
  _id_8DAF361258C0DC41(0);

  if(result == "perkPackageMenu_option1") {
    perkpackage_setstate(3);
    _id_74FA01BD3626F0B7 = 1;
  } else if(result == "perkPackageMenu_option2") {
    perkpackage_setstate(4);
    _id_74FA01BD3626F0B7 = 1;
  } else {
    perkpackage_setstate(1);
    _id_74FA01BD3626F0B7 = 0;
    wait 0.3;
  }

  if(!perkpackagemenu_canactivatesuper())
    _id_74FA01BD3626F0B7 = 0;

  return _id_74FA01BD3626F0B7;
}

_id_8DAF361258C0DC41(isdisabled) {
  if(isdisabled) {
    _id_3B64EB40368C1450::set("perkpackage_menu", "usability", 0);
    _id_3B64EB40368C1450::set("perkpackage_menu", "ascender_use", 0);
    _id_3B64EB40368C1450::set("perkpackage_menu", "vehicle_use", 0);
  } else
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("perkpackage_menu");
}

_id_A7FBAF375D6D6BFA() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("perkPackage_endMenuThink");
  scripts\engine\utility::waittill_any_2("spawned_player", "laststand_revived");

  if(!isDefined(self))
    return 0;

  _id_19163E14365D9264 = scripts\mp\supers::getcurrentsuper();

  if(isDefined(_id_19163E14365D9264)) {
    scripts\mp\supers::setsuperexpended(0);
    _id_19163E14365D9264.wasrefunded = 1;
    scripts\mp\supers::setsuperbasepoints(scripts\mp\supers::getsuperpointsneeded());
  }
}

perkpackagemenu_closeinputthink() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("giveLoadout_start");
  self endon("perkPackage_endMenuThink");

  for(;;) {
    if(!perkpackagemenu_canactivatesuper())
      self notify("perkPackageMenu_close");

    wait 0.05;
  }
}

perkpackagemenu_canactivatesuper() {
  if(self useButtonPressed() || self attackButtonPressed() || self adsButtonPressed() || self meleeButtonPressed())
    return 0;

  if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("supers"))
    return 0;

  if(self isonladder())
    return 0;

  return 1;
}

perkpackage_awardperkpackageupgrade() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("giveLoadout_start");
  _id_EBEC497FF8B18A45 = undefined;

  if(self.perkpackagedata.state == 3)
    _id_EBEC497FF8B18A45 = perkpackage_getfirstfieldupgrade();
  else if(self.perkpackagedata.state == 4)
    _id_EBEC497FF8B18A45 = perkpackage_getsecondfieldupgrade();

  if(isDefined(_id_EBEC497FF8B18A45)) {
    _id_19163E14365D9264 = scripts\mp\supers::getcurrentsuper();
    self.perkpackagedata.super = _id_EBEC497FF8B18A45;
    scripts\mp\supers::givesuper(self.perkpackagedata.super, 0, 1);
    self.perkpackagedata._id_E5DA01E1954B6734 = _id_EBEC497FF8B18A45;

    if(scripts\mp\supers::_id_04B10D71720FC4A4(self.perkpackagedata._id_E5DA01E1954B6734))
      scripts\mp\supers::_id_7ABBEE267D3AAD2F(self.perkpackagedata._id_E5DA01E1954B6734);

    if(1) {
      result = perkpackage_forceusesuper();

      if(!istrue(result)) {
        self notify("perkPackage_failed_super");
        return;
      }
    } else
      thread perkpackagemenu_disableoffhanduse(0.3);
  }
}

perkpackage_forceusesuper() {
  thread perkpackage_waitforsuperfinish();
  _id_EBEC497FF8B18A45 = scripts\mp\supers::getcurrentsuperref();

  if(!isDefined(_id_EBEC497FF8B18A45))
    return 0;

  _id_641083E829D5514C = level.superglobals.staticsuperdata[_id_EBEC497FF8B18A45].weapon;

  if(!isDefined(_id_641083E829D5514C))
    return 0;

  _id_354F8655B711B4B1 = makeweapon(_id_641083E829D5514C);
  thread perkpackagemenu_disableoffhanduse(0.3);
  _id_25DB3863F345443E = 0;

  if("super_default_mp" != _id_641083E829D5514C)
    _id_25DB3863F345443E = !istrue(scripts\mp\supers::_id_C1C41A5273F29351(_id_354F8655B711B4B1));

  if(_id_25DB3863F345443E)
    result = 0;
  else
    result = scripts\mp\supers::trysuperusebegin(_id_354F8655B711B4B1);

  if(!istrue(result)) {
    perkpackage_setstate(1);
    self.perkpackagedata.super = "super_select";
    scripts\mp\supers::givesuper(self.perkpackagedata.super, 0, 1);
  }

  return result;
}

perkpackage_waitforsuperfinish() {
  self endon("disconnect");
  self.perkpackagedata.isusing = 1;
  msg = perkpackage_waitforsuperfinishinternal();
  self.perkpackagedata.isusing = 0;
}

perkpackage_waitforsuperfinishinternal() {
  level endon("game_ended");
  self endon("giveLoadout_start");
  self endon("perkPackage_failed_super");
  return scripts\engine\utility::waittill_any_return_1("super_use_finished");
}

perkpackage_waitforsupercanceled(_id_641083E829D5514C) {
  self endon("offhand_fired");
  _id_6733DE10D9782C78 = undefined;
  starttime = gettime();

  for(;;) {
    offhand = self getheldoffhand();

    if(isDefined(offhand) && offhand == _id_641083E829D5514C) {
      _id_6733DE10D9782C78 = offhand;
      break;
    }

    endtime = gettime();

    if(endtime - starttime > 400.0)
      return 1;

    wait 0.05;
  }

  for(;;) {
    offhand = self getheldoffhand();

    if(!isDefined(offhand) || offhand != _id_6733DE10D9782C78)
      return 1;

    wait 0.05;
  }
}

perkpackagemenu_disableoffhanduse(duration) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("giveLoadout_start");
  _id_3B64EB40368C1450::set("field_upgrade_pro", "offhand_primary_weapons", 0);
  _id_3B64EB40368C1450::set("field_upgrade_pro", "offhand_secondary_weapons", 0);
  wait(duration);
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("field_upgrade_pro");
}

perkpackage_givedebug(_id_EBEC497FF8B18A45) {
  perkpackage_giveimmediate(_id_EBEC497FF8B18A45);
}

perkpackage_giveimmediate(_id_EBEC497FF8B18A45) {
  perkpackage_initpersdata();
  self.perkpackagedata.istwomode = 0;
  scripts\mp\supers::_id_E78F07EFBCDB9E97();
  self.perkpackagedata.super = _id_EBEC497FF8B18A45;

  if(_id_EBEC497FF8B18A45 == "super_select") {
    self.perkpackagedata.istwomode = 1;
    scripts\mp\supers::_id_C9491DF86B072612();
    perkpackage_giveoverridefieldupgrades("super_deployed_decoy", "super_tac_camera");
  } else {
    perkpackage_giveoverridefieldupgrades(_id_EBEC497FF8B18A45);
    scripts\mp\supers::givesuper(self.perkpackagedata.super, 0, 1);
  }
}

perkpackage_giveoverridefieldupgrades(_id_7E397F4CE66BFFD0, _id_7E39824CE66C0669) {
  if(!isDefined(_id_7E397F4CE66BFFD0))
    _id_7E397F4CE66BFFD0 = "none";

  if(!isDefined(_id_7E39824CE66C0669))
    _id_7E39824CE66C0669 = "none";

  self.overridefieldupgrade1 = _id_7E397F4CE66BFFD0;
  self.overridefieldupgrade2 = _id_7E39824CE66C0669;
  perkpackage_updateifchanged();
}

perkpackage_resetoverridefieldupgrades() {
  self.overridefieldupgrade1 = undefined;
  self.overridefieldupgrade2 = undefined;
}

perkpackage_reset() {
  self.perkpackagedata.forcereset = 1;
  perkpackage_updateifchanged();
}