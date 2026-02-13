/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2592.gsc
*************************************************/

_id_10FB8() {
  level._effect["wristrocket_explode"] = loadfx("vfx/iw7/_requests/mp/power/vfx_wrist_rocket_exp.vfx");
  level._effect["wristrocket_thruster"] = loadfx("vfx/iw7/_requests/mp/power/vfx_wrist_rocket_thruster");
}

_id_10FAC() {
  thread _id_10FAE();
}

_id_10FAD() {
  self notify("wristRocket_unset");
}

_id_10FB9(var_0) {
  if(var_0._id_F1DF == 1) {
    return;
  }
  var_1 = _id_10FA8(var_0);
  var_1._id_0203 = var_0;
  var_0 = scripts\mp\utility\weapon::_id_0C48("pop_rocket_mp", self.origin, (0, 0, 0), 100, 1, var_0);
  var_0 _meth_85A3(1);
  var_0 linkto(var_1);
  var_0 thread _id_10FA7(var_1);
  var_0 thread _id_10FA6(self);
  var_1 setscriptablepartstate("launch", "active", 0);
  var_1 thread _id_10FB5(2);
  var_1 thread _id_10FB6();
}

_id_10FB5(var_0) {
  self endon("death");
  self.owner endon("disconnect");
  self notify("wristRocket_watchFuse");
  self endon("wristRocket_watchFuse");
  wait(var_0);
  thread _id_10FAB();
}

_id_10FB6() {
  self endon("death");
  self.owner endon("disconnect");
  self waittill("missile_stuck", var_0);

  if(isPlayer(var_0)) {
    self.owner scripts\mp\weapons::_id_717C(self, var_0);
  }

  self stoploopsound();
  self setscriptablepartstate("stuck", "active", 0);
  self setscriptablepartstate("beacon", "active", 0);
  self._id_0203 _meth_85A3(0);
  thread _id_10FB5(1.35);
}

_id_10FAB() {
  self setscriptablepartstate("stuck", "neutral", 0);
  self setscriptablepartstate("beacon", "neutral", 0);
  self setscriptablepartstate("explode", "active", 0);
  thread _id_10FA9();
}

_id_10FA9() {
  self notify("death");
  self._id_57CE = 1;
  wait 0.1;
  self delete();
}

_id_10FA8(var_0) {
  var_1 = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("pop_rocket_proj_mp"), var_0.origin, var_0.origin + anglesToForward(self _meth_8599()), self);
  var_1.owner = self;
  var_1.team = self.team;
  var_1.weapon_name = "pop_rocket_proj_mp";
  var_1._id_BA94 = "power_wristrocket";
  var_1 setotherent(self);
  var_1 setentityowner(self);
  var_1 thread _id_10FA6(self);
  return var_1;
}

_id_10FAE() {
  self endon("disconnect");
  self notify("wristRocket_watchEffects");
  self endon("wristRocket_watchEffects");
  var_0 = 0;

  for(;;) {
    var_1 = spawnStruct();

    if(var_0) {
      childthread _id_10FB2(var_1);
    } else {
      childthread _id_10FB1(var_1);
    }

    childthread _id_10FB0(var_1);
    childthread _id_10FB3(var_1);
    childthread _id_10FAF(var_1);
    childthread _id_10FB4(var_1);
    var_0 = 0;
    self waittill("wristRocket_watchEffectsRaceStart");
    waittillframeend;
    var_2 = istrue(var_1._id_7171);
    var_3 = istrue(var_1._id_7163);
    var_4 = istrue(var_1._id_EB49);
    var_5 = istrue(var_1._id_0153);
    var_6 = istrue(var_1._id_F9B2);
    var_7 = istrue(var_1._id_766A);

    if(var_5) {
      self notify("wristRocket_watchEffectsRaceEnd");
      thread _id_10FAA();
      return;
    } else if(var_6) {
      self notify("wristRocket_watchEffectsRaceEnd");
      thread _id_10FAA();
      return;
    } else if(var_4)
      thread _id_10FAA();
    else if(var_7) {
      thread _id_10FAA();
    } else if(var_3) {
      thread _id_10FAA();
    } else if(var_2) {
      thread _id_10FA5();
      var_0 = 1;
    }

    self notify("wristRocket_watchEffectsRaceEnd");
  }
}

_id_10FB1(var_0) {
  self endon("wristRocket_watchEffectsRaceEnd");

  for(;;) {
    self waittill("grenade_pullback", var_1);

    if(var_1.basename == "pop_rocket_mp") {
      break;
    }
  }

  var_0._id_7171 = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

_id_10FB0(var_0) {
  self endon("wristRocket_watchEffectsRaceEnd");

  for(;;) {
    self waittill("grenade_fire", var_1, var_2);

    if(var_2.basename == "pop_rocket_mp") {
      break;
    }
  }

  var_0._id_7163 = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

_id_10FB3(var_0) {
  self endon("wristRocket_watchEffectsRaceEnd");
  self waittill("super_started");
  var_0._id_EB49 = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

_id_10FAF(var_0) {
  self endon("wristRocket_watchEffectsRaceEnd");
  self waittill("death");
  var_0._id_0153 = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

_id_10FB4(var_0) {
  self endon("wristRocket_watchEffectsRaceEnd");
  self waittill("wristRocket_unset");
  var_0._id_F9B2 = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

_id_10FB2(var_0) {
  self endon("wristRocket_watchEffectsRaceEnd");
  waitframe();
  var_1 = makeweapon("pop_rocket_mp");

  while(self getheldoffhand() == var_1) {
    waitframe();
  }

  var_0._id_766A = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

_id_10FA5() {
  self notify("wristRocket_beginEffects");
  self endon("wristRocket_beginEffects");
  self endon("wristRocket_endEffects");
  self setscriptablepartstate("wristRocketWorld", "neutral", 0);
  wait 0.15;
  self setscriptablepartstate("wristRocketWorld", "active", 0);
}

_id_10FAA() {
  self notify("wristRocket_endEffects");
  self setscriptablepartstate("wristRocketWorld", "neutral", 0);
}

_id_10FB7(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 != var_2) {
    return;
  }
  if(var_3 != "MOD_SUICIDE") {
    return;
  }
  if(!isDefined(var_0) || var_0 != var_1) {
    return;
  }
  if(!isDefined(var_4) || var_4.basename != "pop_rocket_mp") {
    return;
  }
  var_5 = var_2 gettagorigin("tag_weapon_left");
  _func_01BA(var_5, 175, 200, 70, var_1, "MOD_EXPLOSIVE", "pop_rocket_mp");
  _id_0814::_id_7144(var_5, 0.6);
  playFX(scripts\engine\utility::getfx("wristrocket_explode"), var_5);
}

_id_10FA7(var_0, var_1) {
  self endon("death");
  self notify("cleanupOnParentDeath");
  self endon("cleanupOnParentDeath");

  if(isDefined(var_0)) {
    var_0 waittill("death");
  }

  if(isDefined(var_1)) {
    wait(var_1);
  }

  self delete();
}

_id_10FA6(var_0) {
  self endon("death");
  var_0 waittill("disconnect");

  if(isDefined(self)) {
    self delete();
  }
}