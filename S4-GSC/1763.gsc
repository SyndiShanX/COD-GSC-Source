/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1763.gsc
*************************************************/

_id_86F3(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  if(isDefined(var_0._id_00EC)) {
    return var_0._id_00EC == "misc_turret";
  } else {
    return 0;
  }
}

_id_8711(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  if(isDefined(var_0._id_00EC)) {
    return var_0._id_00EC == "script_vehicle" && !isnullweapon(var_0 _meth_8185());
  } else {
    return 0;
  }
}

_id_2DAA(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(var_0._id_CCD2) || isDefined(var_0._id_CCD0)) {
    [var_5, var_6] = _id_2DA7(var_0);
    var_7 = var_5 + randomfloat(var_6);

    if(var_2 > 0) {
      var_3 = var_7 / var_2;
    } else {
      var_3 = var_7 / 0.05;
    }
  } else
    var_3 = var_1._id_0B67._id_03CA;

  return int(var_3);
}

_id_2D9F(var_0) {
  if(var_0 == "delay") {
    return 0.2;
  } else if(var_0 == "delay_range") {
    return 0.5;
  } else if(var_0 == "burst") {
    return 0.5;
  } else if(var_0 == "burst_range") {
    return 1.5;
  } else if(var_0 == "burst_fire_rate") {
    return 0.05;
  } else {}
}

_id_2DA9(var_0) {
  var_1 = undefined;

  if(isDefined(var_0) && isDefined(var_0._id_CCCE)) {
    var_1 = var_0._id_CCCE;
  } else {
    var_1 = _id_2D9F("burst_fire_rate");
  }

  return var_1;
}

_id_2DA7(var_0) {
  if(isDefined(var_0) && isDefined(var_0._id_CCD2)) {
    var_1 = var_0._id_CCD2;
  } else {
    var_1 = _id_2D9F("burst");
  }

  if(isDefined(var_0) && isDefined(var_0._id_CCD0)) {
    var_2 = var_0._id_CCD0 - var_1;
  } else {
    var_2 = _id_2D9F("burst_range");
  }

  return [var_1, var_2];
}

_id_2DA8(var_0) {
  if(isDefined(var_0) && isDefined(var_0._id_CCD2)) {
    var_1 = var_0._id_CCD2;
  } else {
    var_1 = _id_2D9F("burst");
  }

  if(isDefined(var_0) && isDefined(var_0._id_CCD0)) {
    var_2 = var_0._id_CCD0;
  } else {
    var_3 = _id_2D9F("burst_range");
    var_2 = var_1 + var_3;
  }

  return [var_1, var_2];
}

_id_2DA5(var_0) {
  var_1 = undefined;

  if(isai(self)) {
    var_1 = self;
  }

  if(isDefined(var_0) && isDefined(var_0._id_CCFD)) {
    var_2 = var_0._id_CCFD;
  } else if(isDefined(var_1) && isDefined(var_1._id_10D1F) && isDefined(var_1._id_10D1F["turret"])) {
    var_2 = var_1._id_10D1F["turret"]._id_9EAF;
  } else {
    var_2 = _id_2D9F("delay");
  }

  if(isDefined(var_0) && isDefined(var_0._id_CCFB)) {
    var_3 = var_0._id_CCFB - var_2;
  } else if(isDefined(var_1) && isDefined(var_1._id_10D1F) && isDefined(var_1._id_10D1F["turret"])) {
    var_3 = var_1._id_10D1F["turret"]._id_9C59 - var_2;
  } else {
    var_3 = _id_2D9F("delay_range");
  }

  return [var_2, var_3];
}

_id_2DA6(var_0) {
  var_1 = undefined;

  if(isai(self)) {
    var_1 = self;
  }

  if(isDefined(var_0) && isDefined(var_0._id_CCFD)) {
    var_2 = var_0._id_CCFD;
  } else if(isDefined(var_1) && isDefined(var_1._id_10D1F) && isDefined(var_1._id_10D1F["turret"])) {
    var_2 = var_1._id_10D1F["turret"]._id_9EAF;
  } else {
    var_2 = _id_2D9F("delay");
  }

  if(isDefined(var_0) && isDefined(var_0._id_CCFB)) {
    var_3 = var_0._id_CCFB;
  } else if(isDefined(var_1) && isDefined(var_1._id_10D1F) && isDefined(var_1._id_10D1F["turret"])) {
    var_3 = var_1._id_10D1F["turret"]._id_9C59;
  } else {
    var_4 = _id_2D9F("delay_range");
    var_3 = var_2 + var_4;
  }

  return [var_2, var_3];
}

_id_2D9B(var_0, var_1) {
  var_2 = undefined;
  self endon("death");
  self endon("turretstatechange");
  self notify("kill_burst_fire_do_shoot_nonstop");
  self endon("kill_burst_fire_do_shoot_nonstop");

  if(istrue(var_1)) {
    self endon("turretmodeset");
  }

  if(isDefined(var_0)) {
    var_2 = var_0;
  } else {
    var_2 = _id_2DA9(self);
  }

  for(;;) {
    if(isDefined(self._id_DA18)) {
      self _meth_83C1(self._id_DA18);
    } else {
      self _meth_83C1();
    }

    wait(var_2);
  }
}

set_turret_shoot_params() {
  var_0 = "turret";

  if(isDefined(self._id_10D1F) && isDefined(self._id_10D1F[var_0])) {
    var_1 = 100;
    var_2 = self._id_10D1F[var_0].minpercentcliptofire;
    var_3 = self._id_10D1F[var_0].maxpercentcliptofire;

    if(var_2 > var_3) {}

    var_4 = randomfloatrange(var_2, var_3);
    self._id_0B67._id_03D0 = int(var_1 * var_4);
  }
}

_id_F879() {
  self notify("kill_turret_vm_playeranims_think");
  self endon("kill_turret_vm_playeranims_think");
  var_0 = self _meth_8185();

  if(!var_0._id_04C9 || var_0._id_005B == "none") {
    return;
  }
  for(;;) {
    var_1 = scripts\engine\utility::waittill_any_return("turretownerchange", "death");

    if(var_1 == "death") {
      return;
    }
    var_2 = self _meth_8183();
    var_3 = undefined;
    var_0 = undefined;

    if(isDefined(var_2) && isPlayer(var_2) && !isbot(var_2)) {
      var_2 giveweapon(self.weaponinfo);
      var_3 = var_2 getcurrentweapon();
      var_0 = self _meth_8185();
      var_2 switchtoweaponimmediate(var_0);
    }

    var_1 = scripts\engine\utility::waittill_any_return("turretownerchange", "death");

    if(isDefined(var_2) && isPlayer(var_2) && !isbot(var_2)) {
      var_2 switchtoweaponimmediate(var_3);
      var_2 takeweapon(var_0);
    }

    if(var_1 == "death") {
      return;
    }
  }
}

_id_FEF9() {
  var_0 = self _meth_8182();

  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = var_0 _meth_8183();

  if(!isDefined(var_1)) {
    return 0;
  }

  return var_1 == self;
}

_id_F868() {
  var_0 = "turret";

  if(scripts\common\utility::_id_871D(var_0)) {
    if(!isDefined(self._id_10D1F[var_0])) {
      self._id_10D1F[var_0] = spawnStruct();
      self._id_10D1F[var_0]._id_9EAF = scripts\common\utility::_id_6857(var_0, 2);
      self._id_10D1F[var_0]._id_9C59 = scripts\common\utility::_id_6857(var_0, 3);
      self._id_10D1F[var_0].minpercentcliptofire = scripts\common\utility::_id_6857(var_0, 10);
      self._id_10D1F[var_0].maxpercentcliptofire = scripts\common\utility::_id_6857(var_0, 11);
    }
  }
}

#using_animtree("turret");

play_paired_turret_anim_if_needed(var_0, var_1, var_2) {
  if(!isDefined(var_1) || var_1 != "PlayPairedTurretAnim") {
    return;
  }
  if(!isDefined(var_2)) {
    var_2 = self _meth_8182();

    if(!isDefined(var_2)) {
      var_2 = _id_06BD::_id_23C8();
    }
  }

  if(!isDefined(var_2)) {
    return;
  }
  self notify("kill_play_paired_turret_anim");
  self endon("kill_play_paired_turret_anim");
  var_3 = get_paired_turret_anim(var_0);

  if(isDefined(var_3)) {
    var_2 _meth_8849(1);
    var_2 useanimtree(#animtree);
    var_4 = _func_0079(var_3);
    var_2 _meth_82E5(var_3, 1.0, 0.05);
    wait(var_4);
    var_5 = var_2 _id_06C5::_id_67F4();

    if(var_5 == "stand") {
      wait 0.3;
    } else if(var_5 == "crouch") {
      wait 0.15;
    }

    var_2 _meth_83F9();
    var_2 _meth_8849(0);
  }
}

get_paired_turret_anim(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = _func_00C1(var_0);

  if(isDefined(level.turret_paired_anims) && isDefined(level.turret_paired_anims[var_1])) {
    return level.turret_paired_anims[var_1];
  }
}