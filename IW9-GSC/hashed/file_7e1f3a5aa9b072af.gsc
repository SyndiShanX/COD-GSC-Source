/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7e1f3a5aa9b072af.gsc
***********************************************/

_id_62B8CD48622D789C() {
  level._effect["breach_explode"] = loadfx("vfx/iw8_mp/breaches/vfx_gen_door_breach_thick.vfx");
  level._effect["timedbomb_red_light"] = loadfx("vfx/iw9/cp/vfx_mine_light_en.vfx");
  level._effect["timedbomb_green_light"] = loadfx("vfx/iw9/cp/vfx_green_light_en.vfx");
}

_id_6B91D65174113D68() {
  scripts\cp\utility\cp_controlled_callbacks::registercontrolledcallback("Earthquake", ::earthquake, 5, scripts\cp\utility::_id_97196D9C69A91E2B, 0, 0, 0, 1, 1);
}

_id_1086536B8E7022CA(_id_6AAA6A5DCFA4D64D, _id_E945EC7354E2B638) {
  _id_C2763411714B23F0 = spawn("script_model", _id_6AAA6A5DCFA4D64D.origin);
  _id_C2763411714B23F0.angles = scripts\engine\utility::ter_op(isDefined(_id_6AAA6A5DCFA4D64D.angles), _id_6AAA6A5DCFA4D64D.angles, (0, 0, 0));
  _id_C2763411714B23F0._id_1B2E117ECD1E7A67 = spawnStruct();
  _id_C2763411714B23F0._id_1B2E117ECD1E7A67.origin = _id_C2763411714B23F0.origin;
  _id_C2763411714B23F0._id_1B2E117ECD1E7A67.angles = _id_C2763411714B23F0.angles;
  _id_C2763411714B23F0 thread _id_468D0C734A291084(_id_E945EC7354E2B638);
  _id_C2763411714B23F0 thread _id_6579DF697EFD751B();
  return _id_C2763411714B23F0;
}

_id_BA9AF0BC3B5CF4D7(_id_B512F2C3531420FC) {
  _id_B512F2C3531420FC delete();
}

_id_B1CA15CE46804F07(_id_B512F2C3531420FC) {
  level endon("game_ended");
  self endon("death");
  _id_B512F2C3531420FC waittill("death");
  self delete();
}

_id_6579DF697EFD751B() {
  level endon("game_ended");
  self endon("death");
  _id_7E86C3D129AD81A8 = spawn("script_model", self.origin);
  _id_7E86C3D129AD81A8 setModel("tag_origin");
  _id_7E86C3D129AD81A8 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_TIMED_BOMBS/CREATE_NEW_TB", 25, "duration_medium", "hide", 256, 65, 64, 65);
  _id_7E86C3D129AD81A8 _meth_DFB78B3E724AD620(0);
  _id_7E86C3D129AD81A8 thread _id_B1CA15CE46804F07(self);
  laststate = "active";
  thread _id_8859D02DBEBAF6B9(self, _id_7E86C3D129AD81A8);

  for(;;) {
    if(_id_933F1C2EE43C7436(self)) {
      if(laststate == "inactive") {
        _id_7E86C3D129AD81A8 _meth_DFB78B3E724AD620(1);
        laststate = "active";
      }
    } else if(laststate == "active") {
      _id_7E86C3D129AD81A8 _meth_DFB78B3E724AD620(0);
      laststate = "inactive";
    }

    waitframe();
  }
}

_id_8859D02DBEBAF6B9(_id_B512F2C3531420FC, interaction) {
  level endon("game_ended");
  _id_B512F2C3531420FC endon("death");

  for(;;) {
    interaction waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(isDefined(_id_B512F2C3531420FC._id_7F140FFE9C439F78)) {
      if(istrue(_id_B512F2C3531420FC._id_7F140FFE9C439F78._id_4B7189D9CF490337))
        level thread _id_0EBCD595172837C0(_id_B512F2C3531420FC._id_7F140FFE9C439F78);
      else
        _id_B512F2C3531420FC._id_7F140FFE9C439F78 _id_CD614026289BB9E8(0.1);
    }

    wait 2;
  }
}

_id_468D0C734A291084(bombtimer) {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    _id_5306229AF56E99C8(self, self.origin, self.angles, bombtimer);
    self waittill("dispense_time_bomb");
    wait 1;
  }
}

_id_5306229AF56E99C8(_id_B512F2C3531420FC, origin, angles, _id_E945EC7354E2B638) {
  _id_44C812327327E609 = spawn("script_model", origin);
  _id_44C812327327E609.angles = scripts\engine\utility::ter_op(isDefined(angles), angles, (0, 0, 0));
  _id_44C812327327E609._id_CE4B47E2A63B34D2 = _id_E945EC7354E2B638 * 1000;
  _id_44C812327327E609.remainingtime = _id_44C812327327E609._id_CE4B47E2A63B34D2;
  _id_44C812327327E609.starttime = 0;
  _id_44C812327327E609._id_2CB76382F111F1E7 = undefined;
  _id_44C812327327E609._id_B512F2C3531420FC = _id_B512F2C3531420FC;
  _id_44C812327327E609 setModel("military_nuke_core_ball");

  if(_id_E945EC7354E2B638 < 0)
    _id_44C812327327E609._id_4B7189D9CF490337 = 1;

  _id_44C812327327E609 _id_6FABA6219A5A20C0();
  _id_44C812327327E609 thread _id_9166BC34A1125282(0);
  level _id_3A27106991B266A4(_id_44C812327327E609);
}

_id_3A27106991B266A4(_id_44C812327327E609) {
  if(!isDefined(level._id_E228536A74E47AD2))
    level._id_E228536A74E47AD2 = [];

  level._id_E228536A74E47AD2[level._id_E228536A74E47AD2.size] = _id_44C812327327E609;
}

_id_8E7C4C1269FD55CB(_id_0B57C12373402D26, effect) {
  level endon("game_ended");
  vfxtag = spawn("script_model", _id_0B57C12373402D26.origin + (0, 0, 2));
  vfxtag setModel("tag_origin");
  vfxtag linkTo(_id_0B57C12373402D26);
  playFXOnTag(level._effect[effect], vfxtag, "tag_origin");

  while(isDefined(_id_0B57C12373402D26))
    wait 1;

  wait 3;
  vfxtag delete();
}

_id_9166BC34A1125282(_id_551E31EE44BE06CC) {
  level endon("game_ended");
  self endon("death");
  scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_TIMED_BOMBS/PICKUP", 25, "duration_medium", "hide", 256, 180, 64, 165);
  self _meth_DFB78B3E724AD620(1);

  for(;;) {
    self waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    self _meth_DFB78B3E724AD620(0);

    if(istrue(_id_551E31EE44BE06CC))
      _id_FC480D2E2F742E1F(self, player, 0);
    else
      _id_FC480D2E2F742E1F(self, player, 1);

    return;
  }
}

_id_FC480D2E2F742E1F(_id_E32B6A1A69F12BF4, player, _id_51BEE2F5B3B4E278) {
  _id_17372FFC28DC7D78 = player getcurrentweapon();
  _id_2CB76382F111F1E7 = makeweapon("iw8_nukecore_mp");
  player scripts\cp\utility::_giveweapon(_id_2CB76382F111F1E7);
  player switchtoweapon(_id_2CB76382F111F1E7);
  _id_E32B6A1A69F12BF4._id_2CB76382F111F1E7 = _id_2CB76382F111F1E7;
  player._id_59A029E01A365AA5 = _id_E32B6A1A69F12BF4;
  player allowmountside(0);
  player allowmounttop(0);
  player _id_4A31369FB5F2F290(_id_E32B6A1A69F12BF4, _id_17372FFC28DC7D78);
  player thread _id_FDF47630EEF036AB();
  player thread _id_A712CEBBD6CE82BC(_id_E32B6A1A69F12BF4);

  if(isDefined(_id_E32B6A1A69F12BF4.objindex))
    objective_pinforclient(_id_E32B6A1A69F12BF4.objindex, player);

  _id_E32B6A1A69F12BF4 setModel("tag_origin");
  _id_E32B6A1A69F12BF4 linkTo(player);
  player._id_017DB6BFBBC56F15 = _id_2CB76382F111F1E7;
  _id_E32B6A1A69F12BF4._id_16E3F5AB016DBF91 = player;
  _id_2606D4EF2AD45F25(_id_E32B6A1A69F12BF4);
  _id_E32B6A1A69F12BF4._id_50F6022944135103 = 0;

  if(!istrue(_id_E32B6A1A69F12BF4._id_4B7189D9CF490337)) {
    if(istrue(_id_51BEE2F5B3B4E278)) {
      _id_E32B6A1A69F12BF4 thread watchbombtimer(player);
      _id_E32B6A1A69F12BF4._id_B512F2C3531420FC._id_7F140FFE9C439F78 = _id_E32B6A1A69F12BF4;
    } else
      _id_E32B6A1A69F12BF4 thread _id_AB4046711114B50D(player);
  } else
    _id_E32B6A1A69F12BF4._id_B512F2C3531420FC._id_7F140FFE9C439F78 = _id_E32B6A1A69F12BF4;

  _id_E32B6A1A69F12BF4._id_B512F2C3531420FC notify("timed_bomb_picked");
}

_id_CD614026289BB9E8(_id_424141F29FCAEAB8) {
  self._id_132D8B969F488D67 = gettime() + _id_424141F29FCAEAB8 * 1000;
}

_id_AB4046711114B50D(player) {
  if(isDefined(self.objindex)) {
    objective_setshowprogress(self.objindex, 1);
    objective_setprogress(self.objindex, 1);

    if(isDefined(player) && isPlayer(player))
      objective_removeclientfrommask(self.objindex, player);

    objective_hidefromplayersinmask(self.objindex);
  }

  hintstring = &"CP_TIMED_BOMBS/TB_LABEL";
  player thread scripts\cp\utility::setlowermessage("setup", hintstring, self.remainingtime / 1000, 1, 1);
}

watchbombtimer(player) {
  level endon("game_ended");
  self endon("death");

  if(isDefined(self.objindex)) {
    objective_setshowprogress(self.objindex, 1);
    objective_setprogress(self.objindex, 1);
    objective_addalltomask(self.objindex);
    objective_hidefromplayersinmask(self.objindex);

    if(isDefined(player) && isPlayer(player))
      objective_removeclientfrommask(self.objindex, player);
  }

  self.starttime = gettime();
  self._id_132D8B969F488D67 = self.starttime + self._id_CE4B47E2A63B34D2;
  level thread _id_F89A53D516BC2001(player, self);

  for(;;) {
    if(isDefined(self.remainingtime) && isDefined(self.objindex))
      objective_setprogress(self.objindex, clamp(self.remainingtime / self._id_CE4B47E2A63B34D2, 0, 1));

    if(istrue(self._id_50F6022944135103) || istrue(self._id_108DAFB01072400F)) {
      wait 1;
      continue;
    }

    self.remainingtime = self._id_132D8B969F488D67 - gettime();

    if(getdvarint("dvar_189277BBDC5D9A07", 0) > 0) {}

    if(gettime() > self._id_132D8B969F488D67) {
      if(isDefined(self.objindex))
        objective_setprogress(self.objindex, 0);

      level thread _id_0EBCD595172837C0(self);
      return;
    }

    waitframe();
  }
}

_id_F89A53D516BC2001(player, bomb) {
  hintstring = &"CP_TIMED_BOMBS/TB_LABEL";
  player thread scripts\cp\utility::clearlowermessages();
  waitframe();
  player thread scripts\cp\utility::setlowermessage("setup", hintstring, bomb.remainingtime / 1000, 1, 1);
}

_id_1CFDBE8F9FB1EF00(_id_59A029E01A365AA5) {
  level endon("game_ended");
  _id_59A029E01A365AA5 endon("timedbomb_exploded");
  _id_59A029E01A365AA5 notify("timed_bombs_beeps_single_thread");
  _id_59A029E01A365AA5 endon("timed_bombs_beeps_single_thread");

  for(;;) {
    if(!isDefined(_id_59A029E01A365AA5.remainingtime)) {
      wait 2;
      continue;
    }

    _id_B3CC1BFB924F218C = int(_id_59A029E01A365AA5.remainingtime / 1000);
    _id_F7DD536EB8B3D570 = 2;

    if(_id_B3CC1BFB924F218C > 10) {
      _id_F7DD536EB8B3D570 = 2;

      if(soundexists("breach_warning_beep_01"))
        playsoundatpos(_id_59A029E01A365AA5.origin, "breach_warning_beep_01");
    } else if(_id_B3CC1BFB924F218C <= 10 && _id_B3CC1BFB924F218C > 5) {
      _id_F7DD536EB8B3D570 = 1;

      if(soundexists("breach_warning_beep_01"))
        playsoundatpos(_id_59A029E01A365AA5.origin, "breach_warning_beep_01");
    } else if(_id_B3CC1BFB924F218C <= 5) {
      _id_F7DD536EB8B3D570 = 0.5;

      if(soundexists("breach_warning_beep_02"))
        playsoundatpos(_id_59A029E01A365AA5.origin, "breach_warning_beep_02");
    }

    wait(_id_F7DD536EB8B3D570);
  }
}

_id_869EBF41FE702346(player, _id_2CB76382F111F1E7) {
  level endon("game_ended");
  wait 0.5;

  if(isalive(player))
    _id_12891FD47C174D3D(player, _id_2CB76382F111F1E7, "takebombifgod");
}

_id_0EBCD595172837C0(_id_59A029E01A365AA5) {
  level endon("game_ended");
  _id_1A305763F670DCE9 = 3000;
  _id_9FA829C447BFA7C9 = gettime();
  removeheadicon(_id_59A029E01A365AA5);

  if(isDefined(_id_59A029E01A365AA5._id_16E3F5AB016DBF91)) {
    _id_59A029E01A365AA5._id_16E3F5AB016DBF91.shouldskipdeathsshield = 1;
    _id_59A029E01A365AA5._id_16E3F5AB016DBF91 dodamage(_id_59A029E01A365AA5._id_16E3F5AB016DBF91.maxhealth + 100000, _id_59A029E01A365AA5._id_16E3F5AB016DBF91.origin, _id_59A029E01A365AA5._id_16E3F5AB016DBF91, undefined, "MOD_SUICIDE");
    _id_59A029E01A365AA5._id_16E3F5AB016DBF91 thread _id_963CC955D5471272(_id_59A029E01A365AA5._id_16E3F5AB016DBF91);
    _id_59A029E01A365AA5._id_16E3F5AB016DBF91._id_017DB6BFBBC56F15 = undefined;
  }

  radiusdamage(_id_59A029E01A365AA5.origin, 200, 1000, 1000, undefined, "MOD_EXPLOSIVE");
  scripts\cp\utility\cp_controlled_callbacks::runcontrolledcallback("Earthquake", 1.0, 0.6, _id_59A029E01A365AA5.origin, 256);
  earthquake(1.0, 0.6, _id_59A029E01A365AA5.origin, 256);
  level thread _id_E92B323B6314FDE1(_id_59A029E01A365AA5.origin, _id_59A029E01A365AA5.angles);

  foreach(player in level.players) {
    if(distance(_id_59A029E01A365AA5.origin, player.origin) <= 200) {
      player.shouldskipdeathsshield = 1;
      player dodamage(player.maxhealth + 100000, player.origin, player, undefined, "MOD_SUICIDE");
      player thread _id_963CC955D5471272(player);
    }
  }

  _id_59A029E01A365AA5 notify("timedbomb_exploded");
  level notify("timedbomb_explosion", _id_59A029E01A365AA5.origin);
  _id_59A029E01A365AA5._id_7F140FFE9C439F78 = undefined;
  _id_59A029E01A365AA5._id_B512F2C3531420FC notify("dispense_time_bomb");

  if(isDefined(self.objindex)) {
    objective_delete(_id_59A029E01A365AA5.objindex);
    scripts\cp\cp_objectives::freeworldidbyobjid(_id_59A029E01A365AA5.objindex);
    _id_59A029E01A365AA5.objindex = undefined;
  }

  _id_1CCA140358DF0C1F(_id_59A029E01A365AA5);
  wait 1;
  _id_59A029E01A365AA5 delete();
}

_id_1CCA140358DF0C1F(bomb) {
  if(!isDefined(level._id_E228536A74E47AD2) || !scripts\engine\utility::array_contains(level._id_E228536A74E47AD2, bomb)) {
    return;
  }
  scripts\engine\utility::array_remove(level._id_E228536A74E47AD2, bomb);
}

_id_963CC955D5471272(player) {
  level endon("game_ended");
  player endon("disconnect");

  while(!isalive(player) || istrue(player.inlaststand) || istrue(player.respawn_in_progress))
    wait 1;

  player scripts\engine\utility::waittill_any_2("revive", "death");
  player.shouldskipdeathsshield = 0;
}

_id_E92B323B6314FDE1(origin, angles) {
  level endon("game_ended");
  _id_EFDFC6EBE7A152C5 = spawnfx(level._effect["breach_explode"], origin, anglesToForward(angles) * -1.0, (0, 0, 1));
  triggerfx(_id_EFDFC6EBE7A152C5);

  if(soundexists("breach_c4_expl_trans"))
    playsoundatpos(origin, "breach_c4_expl_trans");

  wait 2;
  _id_EFDFC6EBE7A152C5 delete();
}

tracknonoobplayerlocation() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("dropped_timed_bomb");
  self notify("trackNonOOBPlayerLocationTB");
  self endon("trackNonOOBPlayerLocationTB");
  self.last_good_drop_pos = self.origin;

  for(;;) {
    wait 1;

    if(scripts\cp\cp_outofbounds::isoob(self, 0)) {
      continue;
    }
    self.last_good_drop_pos = self.origin;
  }
}

showplayerlowermessagehint(_id_5F8F3EA5F27D65F4) {
  self notify("showPlayerLowerMessageHint");
  self endon("showPlayerLowerMessageHint");
  scripts\cp\utility::hint_prompt(_id_5F8F3EA5F27D65F4, 1, 3);
}

_id_FDF47630EEF036AB() {
  self endon("dropped_timed_bomb");

  for(;;) {
    self waittill("finish_pickup_of_weapon", _id_F42F309550E65575, _id_4DA99B8AAFF6E52A);
    scripts\cp\utility::_giveweapon(_id_F42F309550E65575);
    self notify("switched_from_timed_bomb", _id_F42F309550E65575);
  }
}

_id_4A31369FB5F2F290(_id_9BE92F3277DFDD4D, _id_6E8ABB5CB9BFD417) {
  self notify("watchTBWeaponEndUse");
  self endon("watchTBWeaponEndUse");
  _id_37CE959DD95FBC24 = _id_9BE92F3277DFDD4D._id_2CB76382F111F1E7;
  self notifyonplayercommand("manual_weapon_switch", "+weapnext");
  self notifyonplayercommand("manual_drop_timed_bomb", "+attack");
  thread _id_DDBDB18933397D9C(_id_37CE959DD95FBC24, _id_6E8ABB5CB9BFD417);
  thread tracknonoobplayerlocation();
  thread showplayerlowermessagehint("stow_time_bomb");
  thread _id_D58CEF3D82E352A0("death", _id_6E8ABB5CB9BFD417);
  thread _id_D58CEF3D82E352A0("last_stand", _id_6E8ABB5CB9BFD417);
  thread _id_D58CEF3D82E352A0("armed_bomb", _id_6E8ABB5CB9BFD417);
  thread _id_D58CEF3D82E352A0("manual_drop_timed_bomb", _id_6E8ABB5CB9BFD417);
  thread watchforcarrierdisconnect(_id_37CE959DD95FBC24);
  thread _id_7184C0FE7B2DD665(_id_9BE92F3277DFDD4D);
}

_id_7184C0FE7B2DD665(_id_9BE92F3277DFDD4D) {
  self endon("dropped_timed_bomb");
  self notify("watchForAscenderUse");
  self endon("watchForAscenderUse");
  _id_37CE959DD95FBC24 = _id_9BE92F3277DFDD4D._id_2CB76382F111F1E7;

  while(!istrue(self.usingascender))
    wait 1;

  if(getdvarint("dvar_A24172489F2B8A69", 0) <= 0)
    level thread _id_A3F5AC1DB4D2D77C(self, 10, "finished_ascender");

  _id_9BE92F3277DFDD4D._id_50F6022944135103 = 1;
  _id_7BEFEBA36094168A = _id_9BE92F3277DFDD4D.remainingtime / 1000;

  while(istrue(self.usingascender))
    waitframe();

  self notify("finished_ascender");
  _id_9BE92F3277DFDD4D _id_CD614026289BB9E8(_id_7BEFEBA36094168A);
  _id_9BE92F3277DFDD4D._id_50F6022944135103 = 0;
  waitframe();
  scripts\engine\utility::waittill_any_timeout_1(1, "weapon_change");
  self switchtoweapon(_id_37CE959DD95FBC24);
}

_id_A3F5AC1DB4D2D77C(player, timeout, _id_9AAA62DB79A0AA5C) {
  level endon("game_ended");
  player endon("disconnect");
  player.ignoreme = 1;
  player scripts\engine\utility::waittill_any_timeout_1(timeout, _id_9AAA62DB79A0AA5C);
  player.ignoreme = 0;
}

watchforcarrierdisconnect(_id_37CE959DD95FBC24) {
  self endon("dropped_timed_bomb");
  self notify("watchForTBCarrierDisconnect");
  self endon("watchForTBCarrierDisconnect");
  self waittill("disconnect");
  level thread _id_12891FD47C174D3D(undefined, _id_37CE959DD95FBC24);
}

_id_DDBDB18933397D9C(_id_37CE959DD95FBC24, _id_6E8ABB5CB9BFD417) {
  self endon("death");
  self endon("disconnect");
  self endon("dropped_timed_bomb");
  level endon("game_ended");
  self notify("watchTBWeaponSwitch");
  self endon("watchTBWeaponSwitch");

  for(;;) {
    self waittill("manual_weapon_switch", _id_C8D59C3D5FFF3543, inlaststand);

    if(self getcurrentweapon() == _id_37CE959DD95FBC24)
      continue;
    else
      thread showplayerlowermessagehint("drop_time_bomb");
  }
}

_id_D58CEF3D82E352A0(action, _id_6E8ABB5CB9BFD417) {
  if(!isDefined(action)) {
    return;
  }
  self endon("disconnect");
  self endon("dropped_timed_bomb");
  level endon("game_ended");
  self notify("removeTBWeaponOnAction" + action);
  self endon("removeTBWeaponOnAction" + action);

  for(;;) {
    self waittill(action, _id_870F0A60F1265700);

    if(action == "death") {
      return;
    }
    if(action == "manual_drop_timed_bomb" && self getcurrentweapon().basename != "iw8_nukecore_mp") {
      continue;
    }
    if(isDefined(_id_870F0A60F1265700))
      level thread _id_12891FD47C174D3D(self, self._id_017DB6BFBBC56F15, action, _id_6E8ABB5CB9BFD417, _id_870F0A60F1265700);
    else
      level thread _id_12891FD47C174D3D(self, self._id_017DB6BFBBC56F15, action, _id_6E8ABB5CB9BFD417);

    return;
  }
}

_id_A54DE66F66B654FB(playerowner, _id_38A4C729748AD94C) {
  groundpos = scripts\engine\utility::drop_to_ground(playerowner.origin, 32);

  if(istrue(_id_38A4C729748AD94C))
    groundpos = getclosestpointonnavmesh(groundpos);

  return groundpos + (0, 0, 16);
}

_id_12891FD47C174D3D(player, _id_2CB76382F111F1E7, action, _id_6E8ABB5CB9BFD417, _id_870F0A60F1265700) {
  _id_0B57C12373402D26 = player._id_59A029E01A365AA5;
  droporigin = (0, 0, 0);
  dropangles = (0, 0, 0);

  if(!isDefined(action))
    action = "";

  if(isDefined(_id_0B57C12373402D26))
    _id_0B57C12373402D26 unlink();

  if(isDefined(player)) {
    player.drop_in_progress = 1;
    player.playerstreakspeedscale = undefined;
    player allowmountside(1);
    player allowmounttop(1);

    if(isDefined(_id_0B57C12373402D26) && isDefined(_id_0B57C12373402D26.objindex)) {
      objective_unpinforclient(_id_0B57C12373402D26.objindex, player);
      objective_addclienttomask(_id_0B57C12373402D26.objindex, player);
      objective_hidefromplayersinmask(_id_0B57C12373402D26.objindex);
    }

    player thread scripts\cp\utility::clearlowermessages();
    _id_38A4C729748AD94C = action != "armed_bomb" && action != "takebombifgod";
    droporigin = _id_A54DE66F66B654FB(player, _id_38A4C729748AD94C);
    dropangles = scripts\engine\utility::ter_op(isDefined(player.angles), player.angles, (0, 0, 0));
    player notifyonplayercommandremove("manual_weapon_switch", "+weapnext");
    player notifyonplayercommandremove("manual_drop_timed_bomb", "+attack");
    player scripts\cp\utility::hint_prompt("drop_timed_bomb", 0);
    player scripts\cp\utility::hint_prompt("arm_timed_bomb", 0);
    currentweapon = player getcurrentweapon();

    if(!isDefined(currentweapon) || currentweapon.basename == "none")
      currentweapon = makeweapon("iw8_nukecore_mp");

    if(currentweapon.basename == "iw8_lm_dblmg_mp")
      player scripts\cp_mp\utility\inventory_utility::_takeweapon(makeweapon("iw8_nukecore_mp"));
    else {
      foreach(weapon in player.weaponlist) {
        if(weapon.basename == "iw8_nukecore_mp")
          player scripts\cp_mp\utility\inventory_utility::_takeweapon(weapon);
      }
    }

    if(isDefined(_id_870F0A60F1265700)) {
      if(isweapon(_id_870F0A60F1265700)) {
        player.lastdroppableweaponobj = _id_870F0A60F1265700;
        player switchtoweaponimmediate(_id_870F0A60F1265700);
      } else if(isstring(_id_870F0A60F1265700)) {
        _id_A7408DBFED49F3F9 = makeweapon(_id_870F0A60F1265700);
        player.lastdroppableweaponobj = _id_A7408DBFED49F3F9;
        player switchtoweaponimmediate(_id_A7408DBFED49F3F9);
      }
    } else if(isDefined(_id_6E8ABB5CB9BFD417)) {
      player.lastdroppableweaponobj = _id_6E8ABB5CB9BFD417;
      player switchtoweaponimmediate(_id_6E8ABB5CB9BFD417);
    }

    player._id_017DB6BFBBC56F15 = undefined;
    player._id_59A029E01A365AA5 = undefined;
    player notify("dropped_timed_bomb");
  }

  if(!isDefined(_id_0B57C12373402D26)) {
    return;
  }
  _id_0B57C12373402D26._id_16E3F5AB016DBF91 = undefined;
  _id_0B57C12373402D26._id_2CB76382F111F1E7 = undefined;
  _id_0B57C12373402D26.origin = droporigin;
  _id_0B57C12373402D26.angles = dropangles;
  _id_0B57C12373402D26 setModel("military_nuke_core_ball");

  if(action != "armed_bomb" && action != "takebombifgod")
    _id_2606D4EF2AD45F25(_id_0B57C12373402D26);

  if(action == "armed_bomb") {
    _id_500B35DF42581024 = _id_B060EA055C2A96C8(_id_0B57C12373402D26);

    if(isDefined(_id_500B35DF42581024))
      _id_0B57C12373402D26 thread _id_C28CC8D6BDA53BB8(_id_0B57C12373402D26, _id_500B35DF42581024);
  }

  _id_0B57C12373402D26 thread _id_9166BC34A1125282(1);
}

_id_BCFEF831FE790539(player) {
  return isDefined(player._id_017DB6BFBBC56F15);
}

_id_9A1D3560DC014479(player) {
  weapon = player getcurrentweapon();
  return weapon.basename == "iw8_nukecore_mp";
}

_id_087F623BE54CDB8D(player) {
  if(!isDefined(level._id_535D9FDDE5AE4774))
    return undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_535D9FDDE5AE4774.size; _id_AC0E594AC96AA3A8++) {
    _id_05B1782182517D5A = level._id_535D9FDDE5AE4774[_id_AC0E594AC96AA3A8]._id_B758EC776888DA7C * level._id_535D9FDDE5AE4774[_id_AC0E594AC96AA3A8]._id_B758EC776888DA7C;

    if(distancesquared(player.origin, level._id_535D9FDDE5AE4774[_id_AC0E594AC96AA3A8].origin) <= _id_05B1782182517D5A)
      return level._id_535D9FDDE5AE4774[_id_AC0E594AC96AA3A8];
  }

  return undefined;
}

_id_3E2362D4C51EE0D6(_id_223D75FAD90D2F84) {
  level endon("game_ended");
  _id_223D75FAD90D2F84._id_B5F33954B6B6C3C7 endon("death");
  _id_223D75FAD90D2F84 endon("receptor_deregistered");
  _id_223D75FAD90D2F84._id_7E86C3D129AD81A8 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_TIMED_BOMBS/PLANT_BOMB", -10, "duration_medium", "show", 256, 180, 64, 165);
  waitframe();
  _id_223D75FAD90D2F84._id_7E86C3D129AD81A8 _meth_DFB78B3E724AD620(0);

  for(;;) {
    _id_223D75FAD90D2F84._id_7E86C3D129AD81A8 waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(!_id_BCFEF831FE790539(player)) {
      player scripts\cp\cp_hud_message::tutorialprint(&"CP_TIMED_BOMBS/NEED_TB", 2);
      continue;
    }

    _id_223D75FAD90D2F84._id_7E86C3D129AD81A8 _meth_DFB78B3E724AD620(0);
    _id_9BE92F3277DFDD4D = player._id_017DB6BFBBC56F15;
    player notify("armed_bomb");

    if(!istrue(_id_223D75FAD90D2F84._id_BE44CBEF01411E47))
      return;
  }
}

_id_A712CEBBD6CE82BC(_id_9BE92F3277DFDD4D) {
  level endon("game_ended");
  self endon("dropped_timed_bomb");
  self endon("death");
  self endon("disconnect");
  self endon("last_stand");
  _id_41C6FA631C5019A5 = undefined;
  thread _id_4B4CD699E4A18C2E(self);

  for(;;) {
    _id_7998C1C302950D8D = _id_087F623BE54CDB8D(self);

    if(!isDefined(_id_7998C1C302950D8D)) {
      if(isDefined(_id_41C6FA631C5019A5))
        thread _id_1D2567C8DE211A9E(self, _id_41C6FA631C5019A5, _id_9BE92F3277DFDD4D);

      _id_41C6FA631C5019A5 = undefined;
      wait 0.5;
      continue;
    }

    if(!isDefined(_id_41C6FA631C5019A5)) {
      thread _id_802E6E305DB8E494(self, _id_7998C1C302950D8D, _id_9BE92F3277DFDD4D);
      _id_41C6FA631C5019A5 = _id_7998C1C302950D8D;
    }

    wait 1;
  }
}

_id_4B4CD699E4A18C2E(player) {
  level endon("game_ended");
  player endon("disconnect");
  player waittill("dropped_timed_bomb");

  if(isDefined(player._id_4D472E55333CFC8E)) {
    foreach(_id_34B904EC46C07061 in player._id_4D472E55333CFC8E)
    _id_34B904EC46C07061._id_7E86C3D129AD81A8 _meth_DFB78B3E724AD620(0);
  }
}

_id_802E6E305DB8E494(player, _id_34B904EC46C07061, _id_9BE92F3277DFDD4D) {
  level endon("game_ended");
  player endon("death");
  player endon("disconnect");
  player endon("last_stand");
  _id_34B904EC46C07061._id_7E86C3D129AD81A8 _meth_DFB78B3E724AD620(1);
  _id_34B904EC46C07061._id_7E86C3D129AD81A8 setuseprioritymax();

  if(!isDefined(player._id_4D472E55333CFC8E))
    player._id_4D472E55333CFC8E = [];

  if(!scripts\engine\utility::array_contains(player._id_4D472E55333CFC8E, _id_34B904EC46C07061))
    player._id_4D472E55333CFC8E[player._id_4D472E55333CFC8E.size] = _id_34B904EC46C07061;
}

_id_1D2567C8DE211A9E(player, _id_34B904EC46C07061, _id_9BE92F3277DFDD4D) {
  _id_34B904EC46C07061._id_7E86C3D129AD81A8 _meth_DFB78B3E724AD620(0);

  if(!isDefined(player._id_4D472E55333CFC8E)) {
    return;
  }
  if(scripts\engine\utility::array_contains(player._id_4D472E55333CFC8E, _id_34B904EC46C07061))
    scripts\engine\utility::array_remove(player._id_4D472E55333CFC8E, _id_34B904EC46C07061);
}

_id_919155B4CBBA80B4(player, _id_34B904EC46C07061) {
  _id_C5D3D8FF129F88BA = scripts\cp\utility::createuseent(_id_34B904EC46C07061._id_B5F33954B6B6C3C7.origin);
  _id_C5D3D8FF129F88BA thread _id_890F207DDC0D4436(player);
  result = _id_19B9CBFAA523FD89(player, _id_34B904EC46C07061, _id_C5D3D8FF129F88BA, 1500);
  return result;
}

_id_19B9CBFAA523FD89(player, _id_34B904EC46C07061, _id_C5D3D8FF129F88BA, use_time) {
  _id_A4E6480D3C1A2279(player);
  thread _id_CB49CBE96AC935BD(player, _id_C5D3D8FF129F88BA);
  _id_14C1392E5D9436BC = 0;
  result = 0;

  while(_id_DCB45B25FCDE029B(player)) {
    if(_id_14C1392E5D9436BC >= use_time) {
      result = 1;
      break;
    }

    _id_5D3A428E1F92C6BA = _id_14C1392E5D9436BC / use_time;
    player setclientomnvar("ui_securing", 18);
    player setclientomnvar("ui_securing_progress", _id_5D3A428E1F92C6BA);
    _id_14C1392E5D9436BC = _id_14C1392E5D9436BC + 50;
    waitframe();
  }

  if(istrue(result))
    _id_C5D3D8FF129F88BA notify("use_hold_think_success");
  else
    _id_C5D3D8FF129F88BA notify("use_hold_think_fail");

  _id_C5D3D8FF129F88BA waittill("exit_use_hold_think_complete");
  return result;
}

_id_CB49CBE96AC935BD(player, _id_C5D3D8FF129F88BA) {
  result = scripts\engine\utility::waittill_any_ents_return(_id_C5D3D8FF129F88BA, "use_hold_think_success", _id_C5D3D8FF129F88BA, "use_hold_think_fail", player, "death", player, "disconnect");

  if(isPlayer(player)) {
    player setclientomnvar("ui_securing", 0);
    player setclientomnvar("ui_securing_progress", 0);
    player allowstand(1);
    player allowcrouch(1);
    player allowprone(1);
    player.anim_scene_stance_override = undefined;
    player scripts\cp\cp_powers::power_enablepower();
  }

  _id_C5D3D8FF129F88BA notify("exit_use_hold_think_complete");
}

_id_DCB45B25FCDE029B(player) {
  _id_870CC6C4892834C1 = !level.gameended && player scripts\cp_mp\utility\player_utility::_isalive() && player useButtonPressed() && isDefined(player._id_017DB6BFBBC56F15) && !_id_0AFB7E332AEE4BF2::player_in_laststand(player);
  return _id_870CC6C4892834C1;
}

_id_A4E6480D3C1A2279(player) {
  player setclientomnvar("ui_securing_progress", 0);
  player setclientomnvar("ui_securing", 1);

  if(isPlayer(player))
    player scripts\cp\cp_powers::power_disablepower();
}

_id_C66A538686C28653(player) {
  _id_E7AF06F7A4040877 = player getstance();

  switch (_id_E7AF06F7A4040877) {
    case "stand":
      player allowstand(1);
      player allowcrouch(0);
      player allowprone(0);
      return;
    case "crouch":
      player allowstand(0);
      player allowcrouch(1);
      player allowprone(0);
      return;
    case "prone":
      player allowstand(0);
      player allowcrouch(0);
      player allowprone(1);
      return;
  }
}

_id_890F207DDC0D4436(owner) {
  self endon("death");
  owner scripts\engine\utility::waittill_any_3("death", "disconnect", "armed_bomb");
  wait 2;
  self delete();
}

_id_EC91ECA54AEB938D(_id_03B819B9C304F403) {
  _id_73A5CBBDC1789297 = spawn("script_model", _id_03B819B9C304F403.origin);
  _id_73A5CBBDC1789297.origin = _id_03B819B9C304F403.origin;
  _id_73A5CBBDC1789297.angles = scripts\engine\utility::ter_op(isDefined(_id_03B819B9C304F403.angles), _id_03B819B9C304F403.angles, (0, 0, 0));
  _id_73A5CBBDC1789297 setModel("container_barrel_uranium_closed_01");
  _id_73A5CBBDC1789297._id_B758EC776888DA7C = scripts\engine\utility::ter_op(isDefined(_id_03B819B9C304F403.radius), _id_03B819B9C304F403.radius, 254);

  if(!isDefined(level._id_21A884E21D40A88A))
    level._id_21A884E21D40A88A = [];

  level._id_21A884E21D40A88A[level._id_21A884E21D40A88A.size] = _id_73A5CBBDC1789297;
  _id_73A5CBBDC1789297 thread _id_383A61CE8C03D09E();
}

_id_C44F88A6F215EC0F(bomb) {
  bomb _id_CD614026289BB9E8(int(bomb._id_CE4B47E2A63B34D2 / 1000));
  waitframe();

  if(isDefined(bomb._id_16E3F5AB016DBF91) && isPlayer(bomb._id_16E3F5AB016DBF91))
    level thread _id_F89A53D516BC2001(bomb._id_16E3F5AB016DBF91, bomb);
}

_id_383A61CE8C03D09E() {
  level endon("game_ended");
  self endon("disable_refresher");
  radiussqrd = self._id_B758EC776888DA7C * self._id_B758EC776888DA7C;

  for(;;) {
    if(!isDefined(level._id_E228536A74E47AD2) || level._id_E228536A74E47AD2.size <= 0) {
      wait 2;
      continue;
    }

    foreach(bomb in level._id_E228536A74E47AD2) {
      if(isDefined(bomb) && distancesquared(bomb.origin, self.origin) <= radiussqrd)
        _id_C44F88A6F215EC0F(bomb);
    }

    wait 2;
  }
}

_id_E845B7F0B2F4B71A(_id_E355CF7C5A5371F6, _id_A1B51E43634E777A, onexplodefunc, _id_D9E77E57E369FB63, _id_CAACE6041804C99A, _id_4EEA72A373570008) {
  if(!isDefined(level._id_535D9FDDE5AE4774))
    level._id_535D9FDDE5AE4774 = [];

  _id_7998C1C302950D8D = spawn("script_model", _id_E355CF7C5A5371F6.origin);
  _id_7998C1C302950D8D._id_B5F33954B6B6C3C7 = _id_E355CF7C5A5371F6;
  _id_7998C1C302950D8D.origin = _id_E355CF7C5A5371F6.origin;
  _id_7998C1C302950D8D.angles = scripts\engine\utility::ter_op(isDefined(_id_E355CF7C5A5371F6.angles), _id_E355CF7C5A5371F6.angles, (0, 0, 0));
  _id_7998C1C302950D8D setModel("tag_origin");
  _id_7998C1C302950D8D._id_BE44CBEF01411E47 = istrue(_id_D9E77E57E369FB63);
  _id_7998C1C302950D8D.onexplodefunc = onexplodefunc;
  _id_7998C1C302950D8D._id_B758EC776888DA7C = scripts\engine\utility::ter_op(isDefined(_id_CAACE6041804C99A), _id_CAACE6041804C99A, 128);
  _id_7998C1C302950D8D.attachtag = scripts\engine\utility::ter_op(isDefined(_id_A1B51E43634E777A), _id_A1B51E43634E777A, "tag_origin");

  if(!isDefined(_id_4EEA72A373570008))
    _id_4EEA72A373570008 = (0, 0, 0);

  _id_87E2E8F44C052486 = _id_E355CF7C5A5371F6.origin;

  if(isDefined(_id_A1B51E43634E777A))
    _id_87E2E8F44C052486 = _id_E355CF7C5A5371F6 gettagorigin(_id_A1B51E43634E777A);

  _id_F208EB71426FC5F5 = _id_87E2E8F44C052486 + _id_4EEA72A373570008;
  _id_7998C1C302950D8D._id_7E86C3D129AD81A8 = spawn("script_model", _id_F208EB71426FC5F5);
  _id_7998C1C302950D8D._id_7E86C3D129AD81A8.angles = scripts\engine\utility::ter_op(isDefined(_id_E355CF7C5A5371F6.angles), _id_E355CF7C5A5371F6.angles, (0, 0, 0));
  _id_7998C1C302950D8D._id_7E86C3D129AD81A8 setModel("tag_origin");
  _id_7998C1C302950D8D._id_7E86C3D129AD81A8 linkTo(_id_E355CF7C5A5371F6);
  _id_7998C1C302950D8D linkTo(_id_E355CF7C5A5371F6, _id_7998C1C302950D8D.attachtag);
  level._id_535D9FDDE5AE4774[level._id_535D9FDDE5AE4774.size] = _id_7998C1C302950D8D;
  _id_7998C1C302950D8D thread _id_3E2362D4C51EE0D6(_id_7998C1C302950D8D);
  _id_7998C1C302950D8D thread _id_AE810591DCC1E7DA();
}

_id_6FABA6219A5A20C0() {
  level endon("game_ended");
  self endon("death");
  _id_F0F3ACF5EE96E0CE = createheadicon(self);
  setheadiconimage(_id_F0F3ACF5EE96E0CE, "waypoint_bomb");
  setheadiconmaxdistance(_id_F0F3ACF5EE96E0CE, 0);
  self.headicon = _id_F0F3ACF5EE96E0CE;
  addteamtoheadiconmask(_id_F0F3ACF5EE96E0CE, "allies");
  showheadicontoplayersinmask(_id_F0F3ACF5EE96E0CE);
}

_id_933F1C2EE43C7436(_id_B512F2C3531420FC) {
  return isDefined(_id_B512F2C3531420FC._id_7F140FFE9C439F78) && !_id_1AFF0918E21522B9(_id_B512F2C3531420FC._id_7F140FFE9C439F78);
}

_id_1AFF0918E21522B9(_id_0B57C12373402D26) {
  return isDefined(_id_0B57C12373402D26._id_16E3F5AB016DBF91) && isPlayer(_id_0B57C12373402D26._id_16E3F5AB016DBF91);
}

removeheadicon(bomb) {
  deleteheadicon(bomb.headicon);
}

_id_2606D4EF2AD45F25(bomb) {
  if(_id_1AFF0918E21522B9(bomb))
    hideheadiconfromplayersinmask(bomb.headicon);
  else
    showheadicontoplayersinmask(bomb.headicon);
}

_id_C28CC8D6BDA53BB8(_id_0B57C12373402D26, _id_500B35DF42581024) {
  _id_0B57C12373402D26 linkTo(_id_500B35DF42581024._id_B5F33954B6B6C3C7, _id_500B35DF42581024.attachtag);

  if(istrue(_id_0B57C12373402D26._id_4B7189D9CF490337))
    _id_0B57C12373402D26 thread _id_7AD7818B705D96AA(2);
  else
    _id_0B57C12373402D26 _id_CD614026289BB9E8(2);
}

_id_7AD7818B705D96AA(time) {
  level endon("game_ended");
  wait(time);
  level thread _id_0EBCD595172837C0(self);
}

_id_3F18C4DB43AAF7EC(_id_E355CF7C5A5371F6) {
  if(!isDefined(level._id_535D9FDDE5AE4774)) {
    return;
  }
  foreach(_id_34B904EC46C07061 in level._id_535D9FDDE5AE4774) {
    if(_id_34B904EC46C07061._id_B5F33954B6B6C3C7 == _id_E355CF7C5A5371F6) {
      level._id_535D9FDDE5AE4774 = scripts\engine\utility::array_remove(level._id_535D9FDDE5AE4774, _id_34B904EC46C07061);
      _id_34B904EC46C07061 notify("receptor_deregistered");
      return;
    }
  }
}

_id_0AC5ED67943F0E3B(_id_34B904EC46C07061) {
  if(!isDefined(level._id_535D9FDDE5AE4774)) {
    return;
  }
  level._id_535D9FDDE5AE4774 = scripts\engine\utility::array_remove(level._id_535D9FDDE5AE4774, _id_34B904EC46C07061);
}

_id_B060EA055C2A96C8(_id_78C6D76F126D76D4) {
  if(!isDefined(level._id_535D9FDDE5AE4774))
    return undefined;

  _id_076EB00C42D7D01C = [];

  foreach(_id_34B904EC46C07061 in level._id_535D9FDDE5AE4774) {
    if(_id_FBC55D240A869206(_id_78C6D76F126D76D4, _id_34B904EC46C07061))
      _id_076EB00C42D7D01C[_id_076EB00C42D7D01C.size] = _id_34B904EC46C07061;
  }

  return scripts\engine\utility::getclosest(_id_78C6D76F126D76D4.origin, _id_076EB00C42D7D01C);
}

_id_FBC55D240A869206(_id_78C6D76F126D76D4, _id_34B904EC46C07061) {
  _id_7F56B9D87F5452AF = 0;
  radius = 128;

  if(isDefined(_id_34B904EC46C07061._id_B758EC776888DA7C))
    radius = _id_34B904EC46C07061._id_B758EC776888DA7C;

  _id_7F56B9D87F5452AF = distance(_id_34B904EC46C07061._id_B5F33954B6B6C3C7.origin, _id_78C6D76F126D76D4.origin) <= radius;
  return _id_7F56B9D87F5452AF;
}

_id_AE810591DCC1E7DA() {
  level endon("game_ended");
  self._id_B5F33954B6B6C3C7 endon("death");
  self endon("receptor_deregistered");

  for(;;) {
    level waittill("timedbomb_explosion", _id_B085E4DE6D22E286);

    if(distance(self._id_B5F33954B6B6C3C7.origin, _id_B085E4DE6D22E286) <= 200 && isDefined(self.onexplodefunc)) {
      if(!istrue(self._id_BE44CBEF01411E47))
        _id_0AC5ED67943F0E3B(self);

      self thread[[self.onexplodefunc]]();
    }
  }
}