/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1943.gsc
*************************************************/

_id_8251() {
  setdvarifuninitialized("#x3c5bd7686c75cbbe6", 256);
  setdvarifuninitialized("#x38a2495b4769b72b1", 0);
  setdvarifuninitialized("#x38a1144d8ebd5138c", (0, 0, 0));
  setdvarifuninitialized("#x3dac8fd271ef51b3a", 2);
  setdvarifuninitialized("#x3759b6a99b69252f", 1);
  setdvarifuninitialized("#x392cf538796e52a4a", 1);
  setdvarifuninitialized("#x3403246ee4bdb3828", 0.5);
  setdvarifuninitialized("#x31b5e3000ec3193fe", 0.0);
  setdvarifuninitialized("#x32b8380135cc239ae", 0.0);
  setdvarifuninitialized("#x31709bc0f7a3c89c0", 5000.0);
  setdvarifuninitialized("#x3d607333c2655cfc6", 10.0);
  setdvarifuninitialized("#x329190c0062aed76c", 2.0);
  setdvarifuninitialized("#x3adbdb597f505e393", 10000.0);
  setdvarifuninitialized("#x364116cd57f987b05", 7500.0);
  setdvarifuninitialized("#x3180751c0ce9d2d0d", -2.0);
  setdvarifuninitialized("#x34430ca9834ddd360", 1);
  setdvarifuninitialized("#x318bc14d0bd64d21b", 0.6);
  level._id_AE25 = getdvarint("#x36ec82504aa532492", 1);
  level._id_AE26 = getdvarint("#x3f874994c5db94a27", 1);
  level._id_AE2E = 1;
  level._id_0F53 = [];

  if(!isDefined(level._id_4DAE)) {
    level._id_4DAE = 1;
  }

  if(!isDefined(level._id_5F50)) {
    level._id_5F50 = ::_id_5F51;
  }

  if(!isDefined(level._id_AE30)) {
    level._id_AE30 = ::_id_AE31;
  }

  if(!isDefined(level._id_AE29)) {
    level._id_AE29 = ::_id_AE2A;
  }

  if(!isDefined(level._id_AE3B)) {
    level._id_AE3B = ::_id_916B;
  }

  if(!isDefined(level._id_AE38)) {
    level._id_AE38 = ::_id_A5BD;
  }

  if(!isDefined(level._id_AE36)) {
    level._id_AE36 = ::_id_AE37;
  }

  level._id_DDD6 = spawnStruct();
  level._id_DDD6._id_EA1C = getdvarint("#x392cf538796e52a4a", 1);
  level._id_DDD6._id_10FDF = getdvarfloat("#x3d607333c2655cfc6", 0.0);
  level._id_DDD6._id_10FE0 = getdvarfloat("#x329190c0062aed76c", 0.0);
  level._id_DDD6._id_10FE1 = getdvarfloat("#x3adbdb597f505e393", 0.0);
  level._id_DDD6._id_10FDE = getdvarfloat("#x364116cd57f987b05", 0.0);
  level._id_DDD6._id_11008 = getdvarfloat("#x3403246ee4bdb3828", 0.0);
  level._id_DDD6._id_11012 = getdvarfloat("#x31b5e3000ec3193fe", 0.0);
  level._id_DDD6._id_110F3 = getdvarfloat("#x32b8380135cc239ae", 0.0);
  level._id_DDD6._id_1100D = getdvarfloat("#x31709bc0f7a3c89c0", 0.0);
  level._id_DDD6._id_596B = getdvarfloat("#x3180751c0ce9d2d0d", 0.0);
}

initplayerparachutesettings(var_0) {
  while(!level._id_AE2E) {
    waitframe();
  }

  if(!isDefined(var_0)) {
    var_0 = self;
  }

  if(istrue(level._id_AE25)) {
    var_0 _meth_876C();
  } else {
    var_0 _meth_876D();
  }

  if(istrue(level._id_AE26)) {
    var_0 _meth_876A();
  } else {
    var_0 _meth_876B();
  }
}

_id_E6AD(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(scripts\mp\utility\game::isarmsracegametype() && getdvarint("#x34430ca9834ddd360", 0)) {
    thread parachuteenforcecuttoopentime();
  }

  if(getdvarint("#x3759b6a99b69252f", 0)) {
    thread _id_5F4F(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
    return;
  }

  self endon("death_or_disconnect");
  thread _id_AE2F();
  self _meth_86B4();

  if(!isDefined(var_5)) {
    var_5 = 1;
  }

  if(!istrue(level._id_AE2E)) {
    _id_8251();
  }

  initplayerparachutesettings();

  if(!isDefined(level._id_4DAE)) {
    level._id_4DAE = 1;
  }

  if(!isDefined(level._id_5F50)) {
    level._id_5F50 = ::_id_5F51;
  }

  if(!isDefined(level._id_AE30)) {
    level._id_AE30 = ::_id_AE31;
  }

  if(!isDefined(level._id_AE29)) {
    level._id_AE29 = ::_id_AE2A;
  }

  if(!isDefined(level._id_AE3B)) {
    level._id_AE3B = ::_id_916B;
  }

  if(!isDefined(level._id_AE38)) {
    level._id_AE38 = ::_id_A5BD;
  }

  if(!isDefined(var_0)) {
    var_0 = 4.0;
  }

  if(var_5) {
    self[[level._id_AE3B]]();
  }

  self[[level._id_5F50]]();

  if(_id_8970()) {
    self setclientomnvar("ui_br_altimeter_state", 1);
  }

  if(!isDefined(var_2)) {
    self notifyonplayercommand("open_parachute", "+gostand");
  }

  self _meth_8698(1);

  if(isDefined(var_3)) {
    self setvelocity(var_3);
  }

  self _meth_86B0();

  if(getdvarint("#x3dac8fd271ef51b3a", 1) != 2) {
    self _meth_86B5(1);
  }

  if(level.gametype == "br" && (!istrue(var_4) || getDvar("#x3f59526763711edc4", "") == "dmz") && getdvarint("#x35dc1f061ec8591ce", 1)) {
    thread _id_7E72(getdvarint("#x3b12ee941f695b238", 1) == 1 && getDvar("#x3f59526763711edc4", "") == "dmz");
  }

  if(level.gametype == "base" && (!istrue(var_4) || getDvar("#x3f59526763711edc4", "") == "dmz") && getdvarint("#x35dc1f061ec8591ce", 1)) {
    thread _id_7E72(getdvarint("#x3b12ee941f695b238", 1) == 1 && getDvar("#x3f59526763711edc4", "") == "dmz");
  }

  if(!istrue(var_1)) {
    waittill_parachute_deploy_trigger(var_0, var_6);
  }

  thread _id_BE1A(var_2, var_1);
}

waittill_parachute_deploy_trigger(var_0, var_1) {
  if(isDefined(var_0) && var_0 > 0 && isDefined(var_1)) {
    thread monitorplayerheightfromground(var_1);
    scripts\engine\utility::_id_108A7(var_0, "distance_from_ground_reached");
  } else if(isDefined(var_0) && var_0 > 0 && !isDefined(var_1))
    scripts\engine\utility::_id_108A7(var_0, "open_parachute");
  else if(isDefined(var_1)) {
    thread monitorplayerheightfromground(var_1);
    self waittill("distance_from_ground_reached");
  }
}

monitorplayerheightfromground(var_0, var_1) {
  self endon("death");
  var_2 = physics_createcontents(["physicscontents_glass", "physicscontents_playerclip", "physicscontents_playernosight", "physicscontents_vehicle", "physicscontents_vehicleclip", "physicscontents_water"]);
  var_3 = [];

  while(var_3.size == 0) {
    var_3 = _func_02C1(self.origin, self.origin + (0, 0, 0 - var_0), var_2, undefined, 0, "physicsquery_closest");

    if(isDefined(var_1)) {
      wait(var_1);
      continue;
    }

    wait 0.1;
  }

  self notify("distance_from_ground_reached", var_0);
}

_id_7E72(var_0) {
  var_1 = self;
  level endon("game_ended");
  var_1 endon("disconnect");
  var_1 = self;
  wait 1.0;
  var_1 setscriptablepartstate("skydiveVfx", "enabled", 0);
  var_1 _meth_86BA(1);
  wait 2.0;

  while(isalive(var_1) && !var_1 _meth_86B9()) {
    wait 0.25;
  }

  if(var_0) {
    while(isalive(var_1) && !var_1 isonground()) {
      wait 0.25;
    }
  }

  var_1 setscriptablepartstate("skydiveVfx", "default", 0);
  var_1 _meth_86BA(0);
}

_id_C876(var_0, var_1) {
  var_2 = undefined;

  if(var_0) {
    self._id_C887 = var_1;
    var_2 = "tag_weapon_right";
  } else {
    self._id_C888 = var_1;
    var_2 = "tag_shield_back";
  }

  self _meth_8021(var_1, var_2);
  self._id_75A5 = _id_C87E();
}

_id_C87B() {
  return "weapon_wm_riotshield";
}

_id_C87E() {
  var_0 = 0;
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(_id_8A0A(var_3)) {
      var_0 = 1;
      break;
    }
  }

  return var_0;
}

_id_8A0A(var_0) {
  if(isweapon(var_0) && isnullweapon(var_0)) {
    return 0;
  }

  if(_func_0121(var_0) && var_0 == "none") {
    return 0;
  }

  return weapontype(var_0) == "riotshield";
}

_id_8970() {
  return isDefined(level.gametype) && (level.gametype == "br" || level.gametype == "arm" || level.gametype == "base" || level.gametype == "war" || level.gametype == "cp_survival" || level.gametype == "trial");
}

_id_693D() {
  if(isDefined(level._id_2A73) && isDefined(level._id_2A73._id_2E15)) {
    return level._id_2A73._id_2E15;
  }

  return 24000;
}

_id_693C() {
  if(isDefined(level._id_2E27)) {
    return level._id_2E27;
  }

  return 24000;
}

_id_693F() {
  if(isDefined(level._id_2A73) && isDefined(level._id_2A73._id_2E1B)) {
    return level._id_2A73._id_2E1B;
  }

  return 650;
}

_id_E82E(var_0) {
  var_1 = spawn("script_model", self.origin);
  var_1.angles = self.angles;
  var_1 setModel("viewhands_base_iw8");
  var_1 hide();
  self playerlinktodelta(var_1, "tag_player");
  _id_E82F(var_1, var_0);
  var_1 delete();
}

_id_E82F(var_0, var_1) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("freefall_complete");
  self endon("parachute_complete");
  self notify("steerFalling()");
  self endon("steerFalling()");
  var_2 = 13.8;
  var_3 = 0.0001;
  var_4 = -1350.0;
  var_5 = 1400.0;
  var_6 = 1600.0;
  var_7 = -100.0;

  if(level.gametype == "arm") {
    var_4 = -1750.0;
    var_5 = 400.0;
    var_6 = 400.0;
  }

  if(isDefined(var_1)) {
    var_5 = var_5 * var_1;
    var_6 = var_6 * var_1;
  }

  var_8 = level._id_5F3A * var_3;
  var_0._id_10399 = (0, 0, var_7);
  waitframe();
  var_9 = getdvarint("#x33c01342f08fa6256");
  var_10 = (0, 0, 0);

  for(;;) {
    var_11 = self getnormalizedmovement();
    var_12 = var_11[0];
    var_13 = var_11[1];
    var_14 = self getplayerangles(1);
    var_15 = anglesToForward(var_14) * var_12;
    var_16 = anglestoright(var_14) * var_13;
    var_17 = var_16 + var_15;
    var_18 = vectornormalize(var_17) * var_6;
    var_10 = var_10 + vectornormalize(var_18 - var_10) * level._id_5F3A * var_5;
    var_10 = var_10 - var_10 * length(var_10) * var_8;
    var_19 = var_0._id_10399[2] - var_2 * 39.37 * level._id_5F3A;
    var_19 = max(var_4, var_19);
    var_20 = (0, 0, var_19);
    var_0._id_10399 = var_20 + var_10;
    var_0.origin = var_0.origin + level._id_5F3A * var_0._id_10399;
    var_21 = _func_0218(var_0._id_10399[0] * var_0._id_10399[0] + var_0._id_10399[1] * var_0._id_10399[1]);
    var_22 = _id_103A3(var_0._id_10399[2] * -1);
    var_23 = _id_103A3(var_21);
    var_24 = min(1, (self.origin[2] - _id_693F()) / (_id_693D() - _id_693F()));

    if(_id_8970()) {
      self setclientomnvar("ui_br_altimeter_height", var_24);
      self setclientomnvar("ui_br_altimeter_vertical_speed", int(var_22));
      self setclientomnvar("ui_br_altimeter_horizontal_speed", int(var_23));
    }

    waitframe();
  }
}

_id_103A3(var_0) {
  var_1 = var_0 * 0.05682;
  return var_1;
}

_id_E834(var_0) {
  var_1 = spawn("script_model", self.origin);
  var_1.angles = self.angles;
  var_1 setModel("viewhands_base_iw8");
  var_1 hide();
  self playerlinktodelta(var_1, "tag_player");
  _id_E835(var_1, var_0);
  var_1 delete();
}

_id_E835(var_0, var_1) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("freefall_complete");
  self endon("parachute_landed");
  self notify("steerFalling()");
  self endon("steerFalling()");
  var_2 = 100.0;
  var_3 = -200.0;
  var_4 = 600.0;
  var_5 = 240.0;
  var_6 = 120.0;
  var_7 = 60.0;
  var_8 = 48;
  var_9 = 35.0;
  var_10 = 700.0;
  var_11 = 100.0;
  var_12 = 600.0;
  var_13 = 300.0;
  var_14 = 100.0;
  var_15 = -150.0;

  if(level.gametype == "arm") {
    var_15 = -200.0;
  }

  if(isDefined(var_1)) {
    var_2 = var_2 * var_1;
    var_3 = var_3 * var_1;
    var_4 = var_4 * var_1;
    var_5 = var_5 * var_1;
    var_6 = var_6 * var_1;
    var_7 = var_7 * var_1;
    var_10 = var_10 * var_1;
    var_12 = var_12 * var_1;
    var_13 = var_13 * var_1;
    var_14 = var_14 * var_1;
  }

  var_16 = 100.0;
  var_17 = 0;
  var_18 = 0;
  var_0._id_10399 = (0, 0, 0);

  for(;;) {
    var_19 = self getnormalizedmovement();
    var_20 = var_19[0];
    var_21 = var_19[1];
    var_22 = self getplayerangles(1);
    var_23 = anglesToForward(var_22);
    var_24 = anglestoright(var_22);
    var_25 = scripts\engine\utility::ter_op(var_20 > 0, var_5, var_6);
    var_16 = var_16 + var_20 * var_25 * level._id_5F3A;
    var_16 = var_16 + var_7 * level._id_5F3A * scripts\engine\utility::_id_DD3F(var_2 - var_16);
    var_16 = clamp(var_16, var_3, var_4);
    var_26 = -1 * var_20 * var_9;
    var_17 = var_17 + scripts\engine\utility::_id_DD3F(var_26 - var_17) * var_8 * level._id_5F3A;
    var_27 = _func_01C6(var_24, var_23, var_17);
    var_28 = var_16 * var_27;
    var_29 = var_23 * var_14 + (0, 0, var_15);
    var_18 = var_18 + var_12 * level._id_5F3A * var_21;
    var_18 = var_18 - var_13 * level._id_5F3A * scripts\engine\utility::_id_DD3F(var_18);
    var_18 = clamp(var_18, -1 * var_10, var_10);
    var_30 = var_18 * var_24;
    var_31 = var_11 * abs(var_21);
    var_30 = var_30 + (0, 0, -1 * var_31);
    var_0._id_10399 = var_28 + var_30 + var_29;
    var_0.origin = var_0.origin + var_0._id_10399 * level._id_5F3A;
    var_32 = _func_0218(var_0._id_10399[0] * var_0._id_10399[0] + var_0._id_10399[1] * var_0._id_10399[1]);
    var_33 = max(0, _id_103A3(var_0._id_10399[2] * -1));
    var_34 = max(0, _id_103A3(var_32));
    var_35 = min(1, (self.origin[2] - _id_693F()) / (_id_693D() - _id_693F()));

    if(_id_8970()) {
      self setclientomnvar("ui_br_altimeter_height", var_35);
      self setclientomnvar("ui_br_altimeter_vertical_speed", int(var_33));
      self setclientomnvar("ui_br_altimeter_horizontal_speed", int(var_34));
    }

    waitframe();
  }
}

_id_8A3B() {
  return isDefined(self._id_5A0F) && (self._id_5A0F == 5 || self._id_5A0F == 6);
}

_id_525C(var_0, var_1) {
  self endon("death_or_disconnect");

  if(isDefined(self)) {
    if(_id_8A3B()) {
      return;
    }
    if(!(isDefined(var_0) || isDefined(var_1))) {
      self _meth_86B2(1);
    }

    if(!(scripts\mp\utility\game::isarmsracegametype() && istrue(self.waitingforcuttoopentime))) {
      self _meth_86B3(1);
    } else {
      self.renablebasejumpaftercuttoopentime = 1;
    }
  }
}

_id_BE1A(var_0, var_1, var_2) {
  self endon("death_or_disconnect");
  thread _id_525C(0);
  self waittill("skydive_deployparachute");
  self _meth_86B2(0);
  self notify("freefall_complete");

  if(_id_8970()) {
    self setclientomnvar("ui_br_altimeter_state", 2);
  }

  if(!istrue(level._id_4DAE)) {
    self[[level._id_AE30]]();
  }

  thread _id_E708();
}

_id_AE2B(var_0) {
  self endon("death_or_disconnect");
  self endon("parachute_complete");
  var_0 endon("death");
  var_0 setCanDamage(1);
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = undefined;
  var_13 = undefined;
  var_0._id_DA6D = 0;

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_14, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);

    if(isDefined(var_4)) {
      if(scripts\engine\utility::_id_8794(var_4)) {
        var_0._id_DA6D++;
      }
    }
  }
}

_id_E708() {
  self endon("death_or_disconnect");

  if(getdvarint("#x3dac8fd271ef51b3a", 1) == 1) {
    self _meth_86B5(0);
  }

  self waittill("skydive_end");
  self._id_7D26 = gettime() + 5000;

  if(istrue(self._id_46E2)) {
    self._id_46E2 = 0;
  }

  waitframe();
  self[[level._id_AE38]]();

  if(istrue(level._id_4DAE)) {
    self[[level._id_AE29]]();
  }

  self notify("parachute_landed");
  self _meth_86B5(0);
  self notify("parachute_complete");
  self _meth_8698(0);

  if(_id_8970()) {
    self setclientomnvar("ui_br_altimeter_state", 0);
  }

  if(_id_8970()) {
    if(isDefined(level._id_AAED)) {
      self[[level._id_AAED]](self);
    }
  }
}

_id_AE2F() {
  self endon("parachute_complete");
  self waittill("death");

  if(_id_8970()) {
    self setclientomnvar("ui_br_altimeter_state", 0);
  }
}

_id_5F51() {
  self disableusability();
}

_id_AE31() {}

_id_AE2A() {
  self enableusability();

  if(!scripts\common\utility::_id_861B() && !istrue(self._id_88DF)) {
    scripts\common\utility::_id_154F(1);
  }

  if(isDefined(level._id_9FF1)) {
    self[[level._id_9FF1]]();
  }

  self._id_8CA7 = undefined;
}

_id_68E8() {
  return 0.25;
}

_id_E331() {
  self _meth_8697("camera_custom_orbit_0_noremote");
}

_id_C4F8() {
  self cameradefault();
}

_id_916B() {}

_id_A5BD() {}

_id_EDDD() {
  if(isDefined(self.primaryweaponobj)) {
    self.primaryweaponclipammo = self getweaponammoclip(self.primaryweaponobj);
    self.primaryweaponstockammo = self getweaponammostock(self.primaryweaponobj);
  }

  if(isDefined(self.secondaryweaponobj)) {
    self._id_CFEA = self getweaponammoclip(self.secondaryweaponobj);
    self._id_CFEC = self getweaponammostock(self.secondaryweaponobj);
  }

  var_0 = makeweapon("iw8_fists_mp");
  var_1 = makeweapon("none");
  self.weaponlist = self.primaryweapons;

  for(var_2 = 0; var_2 < self.weaponlist.size; var_2++) {
    var_3 = self.weaponlist[var_2];

    if(isDefined(var_3) && !issameweapon(var_0, var_3) && !issameweapon(var_1, var_3)) {
      self takeweapon(var_3);
    }
  }

  self clearaccessory();

  if(!self hasweapon(var_0)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, undefined, undefined, 1);
  }

  scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 1);
}

_id_C716() {
  self takeweapon(self.weaponlist[0]);
  self clearaccessory();

  if(isDefined(self.primaryweaponobj)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(self.primaryweaponobj, undefined, undefined, 0);

    if(isDefined(self.primaryweaponclipammo)) {
      self setweaponammoclip(self.primaryweaponobj, self.primaryweaponclipammo);
      self setweaponammostock(self.primaryweaponobj, self.primaryweaponstockammo);
    }
  }

  if(isDefined(self.secondaryweaponobj)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(self.secondaryweaponobj, undefined, undefined, 1);

    if(isDefined(self.primaryweaponclipammo)) {
      self setweaponammoclip(self.secondaryweaponobj, self._id_CFEA);
      self setweaponammostock(self.secondaryweaponobj, self._id_CFEC);
    }
  }

  self.weaponlist = self getweaponslistprimaries();

  if(isDefined(self.weaponlist[0])) {
    scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self.weaponlist[0]);
  }

  if(isDefined(self.weaponlist) && isDefined(self.weaponlist[0])) {
    self.primaryweaponobj = self.weaponlist[0];
  }

  if(isDefined(self.weaponlist) && isDefined(self.weaponlist[1])) {
    self.secondaryweaponobj = self.weaponlist[1];
  }
}

_id_B81E() {
  level endon("game_ended");
  self endon("disconnect");

  if(scripts\common\utility::iscp()) {
    self endon("death");
  }

  var_0 = getdvarfloat("#x3c5bd7686c75cbbe6", 256);
  var_1 = 0;
  self._id_C16B = 1;

  for(;;) {
    if(istrue(self._id_C16B) && !self isonground() && _id_E07D() && !self isskydiving() && !self _meth_81CC() && !istrue(self._id_32E8)) {
      var_2 = 0;

      switch (getdvarint("#x38a2495b4769b72b1", 0)) {
        case 0:
          if(var_1 == 0 && self jumpbuttonpressed()) {
            var_2 = 1;
          }

          break;
        case 1:
          if(self jumpbuttonpressed() && var_1 + 500 < gettime()) {
            var_2 = 1;
          }

          break;
        case 2:
          if(!isDefined(self._id_4E9F)) {
            thread _id_10B09();
          }

          if(istrue(self._id_4E9F)) {
            var_2 = 1;
          }

          break;
        default:
          break;
      }

      if(var_2 || level.gametype == "base") {
        var_3 = scripts\common\utility::groundpos(self.origin);
        var_4 = self.origin[2] - var_3[2];

        if(var_4 > var_0) {
          self notify("skydive_deployparachute");
          self _meth_86B1();

          if(level.gametype == "base") {
            self._id_AE39 = 0;
            self._id_C16B = 0;
          }
        }
      }
    }

    if(isDefined(self) && _id_E07D()) {
      if(!self jumpbuttonpressed()) {
        var_1 = 0;
      } else if(var_1 == 0) {
        var_1 = gettime();
      }
    } else
      var_1 = 0;

    waitframe();
  }
}

_id_10B09() {
  level endon("game_ended");
  self endon("disconnect");
  self._id_4E9F = 0;

  for(;;) {
    if(self jumpbuttonpressed()) {
      var_0 = gettime();
      var_1 = 0;
      waitframe();

      for(;;) {
        if(!self jumpbuttonpressed()) {
          if(gettime() < var_0 + 500 && !self isonground()) {
            var_1 = gettime();
          }

          break;
        }

        if(gettime() > var_0 + 500) {
          break;
        }

        waitframe();
      }

      if(var_1 == 0) {
        continue;
      }
      waitframe();

      for(;;) {
        if(self jumpbuttonpressed()) {
          if(gettime() < var_1 + 500 && !self isonground()) {
            self._id_4E9F = 1;
            waitframe();
            self._id_4E9F = 0;
          }

          break;
        }

        if(gettime() > var_1 + 500) {
          break;
        }

        waitframe();
      }
    }

    waitframe();
  }
}

_id_AE37() {
  var_0 = self;

  if(level.gametype == "br") {
    if(isDefined(var_0._id_5A0F) && (var_0._id_5A0F == 1 || var_0._id_5A0F == 2)) {
      var_0 _id_5A0A();
      var_0._id_5A0F = 3;
    }
  } else if(level.gametype == "cp_survival") {
    var_0 setclientomnvar("ui_br_altimeter_state", 0);
    var_0 _id_5A0A(1);
  }
}

_id_FCE8() {
  var_0 = self;
  var_1 = var_0 getvelocity();
  var_2 = clamp(var_0.origin[2], 0, level._id_DDD6._id_10FE1) / level._id_DDD6._id_10FE1;
  var_3 = level._id_DDD6._id_10FE0 + (level._id_DDD6._id_10FDF - level._id_DDD6._id_10FE0) * var_2;
  var_4 = var_1 * (1, 1, 0);
  var_5 = length(var_4);
  var_6 = var_4 * var_3;
  var_7 = var_5 * var_3;

  if(var_7 > level._id_DDD6._id_10FDE) {
    var_6 = var_6 * (level._id_DDD6._id_10FDE / var_7);
  }

  var_8 = 0;
  var_8 = var_8 - var_0.origin[2] * level._id_DDD6._id_11008;
  var_8 = var_8 + level._id_DDD6._id_11012;
  var_8 = var_8 + var_1[2] * level._id_DDD6._id_110F3;
  var_8 = clamp(var_8, -1 * level._id_DDD6._id_1100D, 0);
  var_9 = 1;

  if(var_5 < level._id_DDD6._id_596B * var_1[2]) {
    var_9 = 2;
  }

  var_0 _meth_86A3(var_0.origin + (var_6[0], var_6[1], var_8), 0, var_9);
}

_id_5F4F(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("freeFallFromPlaneStateMachine");
  self endon("freeFallFromPlaneStateMachine");
  var_7 = self;
  var_7._id_5A0F = 1;
  var_7._id_5A09 = istrue(var_4);
  var_7._id_5A0B = 0;
  var_7 _id_5A08(var_0, var_1, var_2, var_3, var_5, var_6);
  var_7 _id_5A0E();
  var_8 = gettime();

  for(;;) {
    if(var_7 isskydiving() || var_8 + 2000 < gettime() || var_7 _id_8A3B()) {
      break;
    }

    waitframe();
  }

  for(;;) {
    if(level._id_DDD6._id_EA1C && var_7._id_5A0B < gettime()) {
      var_7 _id_FCE8();
      var_7._id_5A0B = gettime() + 500;
    }

    if(var_7 _meth_86B7() && var_7._id_5A0F != 1) {
      var_7 _id_5A0E();
      var_7._id_5A0F = 1;
    }

    if(var_7 _meth_86B8() && var_7._id_5A0F != 2) {
      var_7 _id_5A0D();
      var_7._id_5A0F = 2;
    }

    if(!var_7 isskydiving() && var_7._id_5A0F != 3 && var_7._id_5A0F != 4 && var_7._id_5A0F != 6 || var_7._id_5A0F == 5) {
      var_7 _id_5A0A();

      if(var_7._id_5A0F != 5) {
        var_7._id_5A0F = 3;
      } else {
        var_7._id_5A0F = 6;
      }
    }

    var_9 = istrue(var_7.inlaststand);
    var_10 = var_7 isonground() && (var_7._id_5A0F == 3 || var_7 _id_8A3B());
    var_11 = var_7 isonladder();

    if(var_9 || var_10 || var_11) {
      var_7 _id_5A0C();
      var_7._id_5A0F = undefined;
      var_7._id_5A09 = undefined;
      var_7._id_5A0B = undefined;

      if(var_11) {
        var_7 _meth_86B4();
      }

      return;
    }

    waitframe();
  }
}

_id_5A08(var_0, var_1, var_2, var_3, var_4, var_5) {
  self _meth_86B4();

  if(!istrue(level._id_AE2E)) {
    _id_8251();
  }

  initplayerparachutesettings();

  if(!isDefined(var_0)) {
    var_0 = 4.0;
  }

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  if(var_4 && (!isDefined(level.gametype) || level.gametype != "br")) {
    self[[level._id_AE3B]]();
  }

  self[[level._id_5F50]]();

  if(!isDefined(var_2)) {
    self notifyonplayercommand("open_parachute", "+gostand");
  }

  self _meth_8698(1);

  if(isDefined(var_3)) {
    self setvelocity(var_3);
  }

  self _meth_86B0();

  if(istrue(var_1)) {
    thread _id_525C(0);
  } else {
    thread _id_525C(var_0, var_5);
  }

  if(getdvarint("#x3dac8fd271ef51b3a", 1) != 2) {
    self _meth_86B5(1);
  }

  if(isDefined(level.gametype) && level.gametype == "br" && (!istrue(self._id_5A09) || getDvar("#x3f59526763711edc4", "") == "dmz")) {
    thread _id_7E72(getdvarint("#x3b12ee941f695b238", 1) == 1 && getDvar("#x3f59526763711edc4", "") == "dmz");
  }

  if(isDefined(level.gametype) && level.gametype == "base" && (!istrue(self._id_5A09) || getDvar("#x3f59526763711edc4", "") == "dmz")) {
    thread _id_7E72(getdvarint("#x3b12ee941f695b238", 1) == 1 && getDvar("#x3f59526763711edc4", "") == "dmz");
  }

  self[[level._id_AE38]]();
}

_id_5A0E() {
  if(_id_8970()) {
    self setclientomnvar("ui_br_altimeter_state", 1);
    level._id_0F53[self getxuid()] = self;
  }

  if(!self._id_5A09) {
    var_0 = "enabled";

    if(isDefined(self._id_AC3D) && isDefined(self._id_AC3D._id_2BD2)) {
      var_0 = var_0 + self._id_AC3D._id_2BD2;
    }
  }
}

_id_5A0D() {
  self notify("freefall_complete");

  if(isDefined(self._id_8C94) && self._id_8C94 == 1) {
    var_0 = game["music"]["br_plane_jump_parachute"].size - 1;
    var_1 = randomint(var_0);
    self setplayermusicstate(game["music"]["br_plane_jump_parachute"][var_1]);
    self._id_8C94 = 0;
  }

  level._id_0F53[self getxuid()] = self;

  if(_id_8970()) {
    self setclientomnvar("ui_br_altimeter_state", 2);
  }

  if(!istrue(level._id_4DAE)) {
    self[[level._id_AE30]]();
  }
}

_id_5A0A(var_0) {
  self._id_7D26 = gettime() + 5000;

  if(istrue(self._id_46E2)) {
    self._id_46E2 = 0;
  }

  if(istrue(level._id_4DAE)) {
    self[[level._id_AE29]]();
  }

  self notify("parachute_landed");
  self _meth_86B5(0);

  if(!_id_8A3B()) {
    if(!(scripts\mp\utility\game::isarmsracegametype() && istrue(self.waitingforcuttoopentime))) {
      self _meth_86B3(1);
    } else {
      self.renablebasejumpaftercuttoopentime = 1;
    }
  }

  if(istrue(self._id_C710)) {
    _id_C876(self._id_C710 == 1, _id_C87B());
    self._id_C710 = undefined;
  }

  level._id_0F53[self getxuid()] = undefined;
  self notify("parachute_complete");
  self _meth_8698(0);
}

_id_5A0C() {
  if(getdvarint("#x392cf538796e52a4a", 0)) {
    self _meth_86A4();
  }

  if(_id_8970()) {
    level._id_0F53[self getxuid()] = undefined;
    self setclientomnvar("ui_br_altimeter_state", 0);
    thread _id_B872();

    if(isDefined(level._id_AAED)) {
      self[[level._id_AAED]](self);
    }
  }
}

_id_B872() {
  wait 0.3;

  if(isalive(self)) {
    return;
  }
}

_id_AE27() {
  var_0 = self;
  var_0 _meth_86B4();

  if(isDefined(var_0._id_AE18)) {
    var_0._id_AE18 delete();
  }
}

_id_E07D() {
  return isalive(self) && !isDefined(self._id_59E0) && !istrue(self._id_46C3);
}

parachuteenforcecuttoopentime() {
  self endon("death_or_disconnect");
  self.waitingforcuttoopentime = 0;
  self.renablebasejumpaftercuttoopentime = 0;

  for(;;) {
    if(self _meth_86B8()) {
      if(!self.waitingforcuttoopentime) {
        self.waitingforcuttoopentime = 1;
        self _meth_86B2(0);
        self _meth_86B3(0);
      }
    } else if(self.waitingforcuttoopentime) {
      var_0 = getdvarfloat("#x318bc14d0bd64d21b", 0.6);
      wait(var_0);
      self _meth_86B2(1);

      if(self.renablebasejumpaftercuttoopentime) {
        self _meth_86B3(1);
      }

      self.waitingforcuttoopentime = 0;
    }

    waitframe();
  }
}