/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\equipment\stimpistol.gsc
**************************************************/

_id_62123C11D393EF66(reviver) {
  self endon("last_stand_finished");
  self endon("last_stand_heal_active");
  level endon("game_ended");

  for(;;) {
    while(!reviver isonground())
      waitframe();

    _id_22F7E2F7E3607528 = 0;
    self notify("handle_revive_message");
    reviver.revivingteammate = 1;

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {}

    _id_22F7E2F7E3607528 = 1;
    reviver notify("finish_buddy_reviving");

    if(_id_22F7E2F7E3607528)
      return;
  }
}

_id_76CA0B3D8B2555CA(weaponobj) {
  if(!isDefined(weaponobj))
    return 0;

  return weaponobj.basename == "iw9_pi_stimpistol_mp";
}

_id_31AFE9D7B373900F() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  waitframe();
  waitframe();
}

_id_807B3B0A3B4128F9() {
  if(isDefined(self._id_B24E609023CE8208))
    self._id_B24E609023CE8208 = undefined;

  if(isDefined(self._id_98D31D9CE04B2B81))
    self._id_98D31D9CE04B2B81 = undefined;
}

_id_7FC69415FB24CAE1() {
  self notify("super_stimPistol_watchHits");
  self endon("super_stimPistol_watchHits");
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("bullet_first_impact", _id_9D7CA6252F103A3B, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, _id_5E8EDE0EF6D7F3AB, surfacetype, weapon, _id_F07322C0D6CA069C, _id_25DE37BAEC255643, hitloc);

    if(isDefined(_id_1D9FB21B4F3023F3)) {
      _id_8A99CEBBC265563E(_id_1D9FB21B4F3023F3, _id_25DE37BAEC255643, weapon);
      continue;
    }

    if(isDefined(_id_3DC5BB206E7E98AC(_id_25DE37BAEC255643))) {
      _id_E242752B8F2C334F = _id_3DC5BB206E7E98AC(_id_25DE37BAEC255643, 1);

      if(isDefined(_id_E242752B8F2C334F))
        _id_8A99CEBBC265563E(_id_E242752B8F2C334F, _id_25DE37BAEC255643, weapon);

      continue;
    }

    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "stat_C8122B0900BA529D");
  }
}

_id_8A99CEBBC265563E(_id_1D9FB21B4F3023F3, _id_25DE37BAEC255643, weapon) {
  if(!istrue(_id_76CA0B3D8B2555CA(weapon)))
    return 0;

  if(!istrue(isPlayer(_id_1D9FB21B4F3023F3) || isagent(_id_1D9FB21B4F3023F3)))
    return 0;

  if(isai(_id_1D9FB21B4F3023F3))
    return 0;

  if(_id_1D9FB21B4F3023F3.team != self.team)
    return 0;

  _id_B25CA392892D7A80 = _id_1D9FB21B4F3023F3.reviveent;

  if(isDefined(_id_B25CA392892D7A80)) {
    _id_354C862768CFE202::updatedamagefeedback("hitlaststand_stimpistol");
    _id_B25CA392892D7A80 thread _id_0AFB7E332AEE4BF2::_id_656840B28EB4C279(self.team, 1, self);
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "stat_572347275DFB41AB");
    thread _id_293BC33BD79CABD1::killeventtextpopup("stat_AB2FA142759B4C26", 0);
    _id_1D9FB21B4F3023F3 thread _id_293BC33BD79CABD1::killeventtextpopup("stat_AB2FB342759B6ABC", 0);
  } else if(_id_0AFB7E332AEE4BF2::player_in_laststand(_id_1D9FB21B4F3023F3) && !istrue(_id_1D9FB21B4F3023F3.beingrevived)) {
    _id_354C862768CFE202::updatedamagefeedback("hitlaststand_stimpistol");
    _id_1D9FB21B4F3023F3 thread _id_0AFB7E332AEE4BF2::_id_656840B28EB4C279(self.team, 1, self);
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "stat_572347275DFB41AB");
    thread _id_293BC33BD79CABD1::killeventtextpopup("stat_AB2FA142759B4C26", 0);
    _id_1D9FB21B4F3023F3 thread _id_293BC33BD79CABD1::killeventtextpopup("stat_AB2FB342759B6ABC", 0);
  }
}

_id_ADA94A4D4DEECF34(_id_B25CA392892D7A80, reviver) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(isDefined(_id_B25CA392892D7A80.onbeginuse))
    _id_B25CA392892D7A80[[_id_B25CA392892D7A80.onbeginuse]](reviver, 0);

  thread _id_02ED51B25DF0D7D8(reviver, _id_B25CA392892D7A80, _id_5ACB5DCA46088661());
  reviver thread _id_2901549184BDC736(reviver, _id_B25CA392892D7A80, _id_5ACB5DCA46088661());
  thread _id_5B9F43D57BFBADDF(_id_B25CA392892D7A80);
  self waittill("super_stim_revive_other_end");

  if(isDefined(_id_B25CA392892D7A80.onenduse))
    _id_B25CA392892D7A80[[_id_B25CA392892D7A80.onenduse]](reviver.team, reviver, 1, 0);

  waitframe();

  if(isDefined(_id_B25CA392892D7A80.onuse))
    _id_B25CA392892D7A80[[_id_B25CA392892D7A80.onuse]](reviver);
}

_id_5ACB5DCA46088661() {
  return scripts\engine\utility::ter_op(isDefined(level._id_04B91C5DB6B16C58), level._id_04B91C5DB6B16C58, 5);
}

_id_2901549184BDC736(reviver, _id_B25CA392892D7A80, _id_246AEE6688CC8EAE) {
  self notify("super_stimPistol_progressReviverUi");
  self endon("super_stimPistol_progressReviverUi");
  self endon("death_or_disconnect");
  level endon("game_ended");
  _id_48974A7856F3CBAA = 0;
  self setclientomnvar("ui_securing", 5);

  while(_id_48974A7856F3CBAA < _id_246AEE6688CC8EAE) {
    _id_48974A7856F3CBAA = _id_48974A7856F3CBAA + level.framedurationseconds;
    self setclientomnvar("ui_securing_progress", clamp(_id_48974A7856F3CBAA / _id_246AEE6688CC8EAE, 0.01, 1));
    waitframe();
  }

  self setclientomnvar("ui_securing", 0);
}

_id_02ED51B25DF0D7D8(reviver, _id_B25CA392892D7A80, _id_246AEE6688CC8EAE) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  _id_48974A7856F3CBAA = 0;
  self setclientomnvar("ui_securing", 6);
  self setclientomnvar("ui_reviver_id", self getentitynumber());

  while(_id_48974A7856F3CBAA < _id_246AEE6688CC8EAE) {
    _id_48974A7856F3CBAA = _id_48974A7856F3CBAA + level.framedurationseconds;
    self setclientomnvar("ui_securing_progress", clamp(_id_48974A7856F3CBAA / _id_246AEE6688CC8EAE, 0.01, 1));
    waitframe();
  }

  self setclientomnvar("ui_securing", 0);
  self setclientomnvar("ui_reviver_id", -1);
  self notify("super_stim_revive_other_end");
}

_id_5B9F43D57BFBADDF(_id_B25CA392892D7A80, reviver) {
  level endon("game_ended");
  self endon("super_stim_revive_other_end");
  _id_B25CA392892D7A80._id_F99D56BCB582A8BA scripts\engine\utility::waittill_any_4("death_or_disconnect", "last_stand_finished", "trigger_removed", "team_eliminated");

  if(isDefined(_id_B25CA392892D7A80) && isDefined(_id_B25CA392892D7A80.onenduse))
    _id_B25CA392892D7A80[[_id_B25CA392892D7A80.onenduse]](reviver.team, reviver, 0, 0);
}

_id_3DC5BB206E7E98AC(_id_25DE37BAEC255643, _id_7FBFCA7EBE515D0B) {
  nearbyplayer = scripts\engine\utility::getclosest(_id_25DE37BAEC255643, level.players, 32);

  if(istrue(_id_7FBFCA7EBE515D0B) && isDefined(nearbyplayer)) {
    trace = scripts\engine\trace::ray_trace_passed(_id_25DE37BAEC255643, nearbyplayer.origin);

    if(!trace)
      return undefined;
  }

  return nearbyplayer;
}

_id_321C7891711E583F() {
  thread _id_F9FCA902E11F439C();
  _id_189B67B2735B981D::_id_55B08D6D71B41402(self, "equipment_deployed");
  thread _id_7FC69415FB24CAE1();
  _id_AD32396BD89936BB(0);
  thread _id_6BE5EEA08181B5E5();
  thread _id_F5037BA4A5399B63();
  thread _id_C65A15DEF6A7073C();
  return 1;
}

_id_6BE5EEA08181B5E5() {
  self endon("super_use_finished");
  _id_19163E14365D9264 = _id_56EF8D52FE1B48A1::getcurrentsuper();
  weaponobj = _id_19163E14365D9264.staticdata.useweapon;
  _id_893FF9B814E04F95 = undefined;

  for(;;) {
    self waittill("weapon_change", _id_8173B64CDECF7890);

    if(_id_8173B64CDECF7890 != weaponobj && _id_76CA0B3D8B2555CA(_id_893FF9B814E04F95)) {
      break;
    }

    _id_893FF9B814E04F95 = self getcurrentweapon();
    continue;
  }

  thread _id_C45AED53E3C471D2();
  _id_56EF8D52FE1B48A1::superusefinished();
}

_id_C45AED53E3C471D2() {
  self waittill("stim_pistol_returned");
  wait 0.2;
  _id_56EF8D52FE1B48A1::increase_super_progress(965);
}

_id_F5037BA4A5399B63(_id_FCEF8D217A441961, _id_2C718D1DC61A2D27) {
  self endon("disconnect");

  if(!istrue(_id_2C718D1DC61A2D27))
    self waittill("out_of_ammo");

  self notify("super_stimPistol_watchHits");
  _id_AD32396BD89936BB(1);
  self._id_BF5B10918F8418A1 = undefined;
  self.super_activated = 0;
  _id_56EF8D52FE1B48A1::end_super_meter_progress_early();
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("stim_pistol");
  _id_56EF8D52FE1B48A1::_id_C5EA07DAC9D83685();
  clientnum = self getentitynumber();
  setomnvar("ui_class_power_reloading", clientnum);
  _id_56EF8D52FE1B48A1::setsuperisinuse(0);
  self._id_4B6E638CB12A3E90 = 0;
  self notify("stim_pistol_returned");
}

_id_C65A15DEF6A7073C() {
  _id_19163E14365D9264 = _id_56EF8D52FE1B48A1::getcurrentsuper();
  weaponobj = _id_19163E14365D9264.staticdata.useweapon;
  self waittill("super_use_finished");
  wait 0.3;

  if(!istrue(self.insertingarmorplate) && istrue(_id_76CA0B3D8B2555CA(self getcurrentprimaryweapon()))) {
    _id_509D86412C9D7426 = self getweaponslistprimaries();

    foreach(_id_DE88CD14114C1E24 in _id_509D86412C9D7426) {
      if(_id_76CA0B3D8B2555CA(_id_DE88CD14114C1E24)) {
        continue;
      }
      self switchtoweapon(_id_DE88CD14114C1E24);
      break;
    }
  }

  self takeweapon(weaponobj);
  self notify("out_of_ammo");
}

_id_F9FCA902E11F439C() {
  self endon("disconnect");
  self.super_activated = 1;
  weaponobj = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("iw9_pi_stimpistol_mp");
  self notify("super_started");
  _id_19163E14365D9264 = _id_56EF8D52FE1B48A1::getcurrentsuper();
  _id_19163E14365D9264.usepercent = 0.0;
  _id_56EF8D52FE1B48A1::setsuperisinuse(0);
  _id_19163E14365D9264.staticdata.useweapon = weaponobj;
  _id_19163E14365D9264.staticdata.useweaponclipammo = 1;
  _id_19163E14365D9264.staticdata.useweaponstockammo = 0;
  _id_19163E14365D9264.staticdata.usedelay = 10;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "setHasDoneCombat"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "setHasDoneCombat")]](self, 1);

  if(isDefined(_id_19163E14365D9264) && !_id_19163E14365D9264.isinuse) {
    _id_62E9AFC6790FF7B2 = !istrue(self.inlaststand) || istrue(_id_19163E14365D9264.staticdata.canuseinlaststand);
    _id_1338411613704F7A = 1;

    if(isDefined(_id_19163E14365D9264.staticdata.useweapon)) {
      if(!_id_62E9AFC6790FF7B2)
        _id_1338411613704F7A = 0;
      else
        _id_1338411613704F7A = _id_56EF8D52FE1B48A1::trygiveuseweapon(_id_19163E14365D9264.staticdata.useweapon, _id_19163E14365D9264.staticdata.useweaponclipammo, _id_19163E14365D9264.staticdata.useweaponstockammo);
    }

    if(istrue(_id_1338411613704F7A) && istrue(_id_62E9AFC6790FF7B2) && (!isDefined(_id_19163E14365D9264.staticdata.beginusefunc) || istrue(self[[_id_19163E14365D9264.staticdata.beginusefunc]]()))) {
      _id_612C93CFB9F62839 = [];
      _id_612C93CFB9F62839[0] = "super_use_finished_lb";
      _id_612C93CFB9F62839[1] = "super_switched";
      _id_19163E14365D9264.basepoints = 0;
      _id_19163E14365D9264.extrapoints = 0;
      _id_3B64EB40368C1450::set("stim_pistol", "weapon_pickup", 0);
      _id_56EF8D52FE1B48A1::setsuperisinuse(1);
      _id_56EF8D52FE1B48A1::_id_330825804EBBD918(1);
      _id_19163E14365D9264.usestarttime = gettime();
      _id_19163E14365D9264.usepercent = 1.0;
      self notify("super_use_started");
      thread _id_56EF8D52FE1B48A1::_id_15FE9C03174D698D();
      thread _id_56EF8D52FE1B48A1::_id_C4C44E009D4F4C6B();
      thread scripts\cp\cp_player_battlechatter::_id_204AEBA40A2AA027("super_stimpistol");
      self.super_activated = 1;
      self._id_4B6E638CB12A3E90 = 1;
      return 1;
    } else {
      wait 0.2;
      thread _id_C45AED53E3C471D2();
      _id_56EF8D52FE1B48A1::superusefinished();
      return 0;
    }
  }

  iprintlnbold("Failed to give player stim pistol.");
  return 0;
}

_id_3F29F7CEB8C0EC6D() {
  self._id_B24E609023CE8208 = undefined;
  self._id_98D31D9CE04B2B81 = undefined;
}

_id_AD32396BD89936BB(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  if(_id_77C892C2CEC7A0EB)
    self enableweaponpickup();
  else
    self disableweaponpickup();
}