/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2301.gsc
*************************************************/

_id_87E7(var_0, var_1, var_2, var_3) {
  if(!self._id_014C) {
    return scripts\engine\utility::_id_430E("right_arm_upper", "right_arm_lower", "right_hand");
  }

  return 0;
}

_id_87E8(var_0, var_1, var_2, var_3) {
  if(!self._id_014C) {
    return scripts\engine\utility::_id_430E("right_leg_upper", "right_foot", "right_leg_lower");
  }

  return 0;
}

_id_87E6(var_0, var_1, var_2, var_3) {
  if(!self._id_014C) {
    return scripts\engine\utility::_id_430E("left_leg_upper", "left_foot", "left_leg_lower");
  }

  return 0;
}

_id_87E4(var_0, var_1, var_2, var_3) {
  if(!self._id_014C) {
    return scripts\engine\utility::_id_430E("left_arm_upper", "left_arm_lower", "left_hand");
  }

  return 0;
}

_id_87E9(var_0, var_1, var_2, var_3) {
  if(!self._id_014C) {
    return scripts\engine\utility::_id_430E("torso_upper", "torso_lower");
  }

  return 0;
}

_id_87E3(var_0, var_1, var_2, var_3) {
  if(!self._id_014C) {
    return scripts\engine\utility::_id_430E("head", "neck", "helmet");
  }

  return 0;
}

_id_87E5(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::_id_430E("left_hand", "left_arm_upper", "left_arm_lower", "left_leg_upper", "left_leg_lower", "left_foot", "torso_lower");
}

_id_87E2(var_0, var_1, var_2, var_3) {
  if(!self._id_014C) {
    if(_id_08F1::_id_6AAB() == 1 && !scripts\engine\utility::_id_430E("left_leg_upper", "left_leg_lower", "left_foot", "right_leg_upper", "right_leg_lower", "right_foot")) {
      return 1;
    }
  }

  return 0;
}

_id_87EA(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::_id_430E("right_arm_upper", "right_arm_lower", "right_hand", "left_hand", "left_arm_upper", "left_arm_lower", "left_leg_upper", "left_leg_lower", "left_foot", "right_leg_upper", "right_leg_lower", "right_foot", "torso_upper", "torso_lower");
}

_id_7491() {
  self endon("death");
  self notify("new_secondary_pain");
  self endon("new_secondary_pain");
  self._id_1C30._id_CFE8 = 1;
  wait 0.5;
  self._id_1C30._id_CFE8 = 0;
}

_id_10825(var_0, var_1) {
  self endon(var_1 + "_finished");

  for(;;) {
    self waittill("damage");

    if(!isalive(self)) {
      break;
    }

    var_2 = _id_359F(var_0, var_1);
    var_3 = _id_0009::_id_1C6E(var_1, var_2);
    self _meth_85F8(var_3, 1.0, 0.01, 1);
    thread _id_7491();
    wait 0.35;
  }
}

_id_359F(var_0, var_1) {
  var_2 = [];

  if(scripts\engine\utility::_id_430E("torso_upper", "torso_lower")) {
    var_2[var_2.size] = _id_0009::_id_1C7D(var_1, "add_torso");
  } else if(scripts\engine\utility::_id_430E("head", "helmet", "neck")) {
    var_2[var_2.size] = _id_0009::_id_1C7D(var_1, "add_head");
  } else if(scripts\engine\utility::_id_430E("right_arm_upper", "right_arm_lower")) {
    var_2[var_2.size] = _id_0009::_id_1C7D(var_1, "add_right_arm");
  } else if(scripts\engine\utility::_id_430E("left_arm_upper", "left_arm_lower")) {
    var_2[var_2.size] = _id_0009::_id_1C7D(var_1, "add_left_arm");
  } else if(scripts\engine\utility::_id_430E("left_leg_upper", "left_leg_lower", "left_foot")) {
    var_2[var_2.size] = _id_0009::_id_1C7D(var_1, "add_left_leg");
  } else if(scripts\engine\utility::_id_430E("right_leg_upper", "right_leg_lower", "right_foot")) {
    var_2[var_2.size] = _id_0009::_id_1C7D(var_1, "add_right_leg");
  }

  if(var_2.size < 2) {
    var_2[var_2.size] = _id_0009::_id_1C7D(var_1, "add_default");
  }

  return var_2[randomint(var_2.size)];
}

_id_361B(var_0, var_1, var_2) {
  return _id_0009::_id_1C7D(var_1, "shock_loop_" + self._id_0131);
}

_id_B8E8() {
  if(scripts\common\utility::_id_87EC(makeweapon("iw7_sonic")) && scripts\common\utility::_id_8B04(self.damageweapon)) {
    playFXOnTag(level._id_60A1["soldier_shock"], self, "j_knee_ri");
    playFXOnTag(level._id_60A1["soldier_shock"], self, "j_shoulder_ri");
  }
}

_id_B8D5(var_0, var_1, var_2) {
  self endon("death");
  self endon(var_1 + "_finished");
  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  var_4 = scripts\engine\utility::ter_op(isDefined(self._id_51C2), self._id_51C2, 3.5);
  _id_B8E8();
  self _meth_8019("zonly_physics", 0);
  wait(randomfloat(0.3));

  if(self._id_1CB8 == "c6" || self._id_1CB8 == "c6_worker") {
    thread _id_D9EC(self._id_1CB8, var_1, 1, 0, 1);
    self playSound("generic_flashbang_c6_1");
  } else
    thread _id_D9EC(self._id_1CB8, var_1, 1, 0);

  wait(var_4);
  self notify("painloop_end");
  _id_0009::_id_1C53(var_0, "stop_loop_pain");
  self._id_51B7 = undefined;
  _id_5B1B(var_0, var_1, var_2);
}

_id_D9EB(var_0, var_1, var_2) {
  self _meth_83F8();
}

_id_D9EC(var_0, var_1, var_2, var_3, var_4) {
  self endon(var_1 + "_finished");
  self endon("painloop_end");

  if(isDefined(var_3) && var_3) {
    var_5 = _id_0009::_id_1C7E("knobs", "move");

    if(isDefined(var_5)) {
      self _meth_851E(var_5);
    }
  }

  var_6 = _id_0009::_id_1C5E();
  var_7 = _id_0009::_id_1C5C(var_0, var_1);

  for(;;) {
    if(isDefined(var_4)) {
      var_7 = _id_0009::_id_1C5C(var_0, var_1);
    }

    var_8 = _id_0009::_id_1C6E(var_1, var_7);
    self _meth_85ED(var_1, var_7, var_2);
    _id_0009::_id_1C8E(var_0, var_1, var_8);
    var_6 = var_7;
    _id_0009::_id_1C48(var_0, var_1, var_8, _id_0009::_id_1C6A(var_0, var_1));
  }
}

_id_3621(var_0, var_1, var_2) {
  return _id_0009::_id_1C7D(var_1, "shock_finish_" + self._id_0131);
}

_id_B8AA(var_0, var_1, var_2) {
  _id_B8B1(var_0, var_1, var_2, 0);
}

_id_B8B3(var_0, var_1, var_2) {
  _id_B8B1(var_0, var_1, var_2, 1);
}

_id_B8B2(var_0, var_1, var_2) {
  self._id_0B67._id_82C7 = 1;
  self.playing_mg_pain = 1;
  _id_B8B1(var_0, var_1, var_2, 0);
}

_id_ADD8(var_0, var_1) {
  if(var_0 == "pain_can_end") {
    return 1;
  }
}

_id_DB92(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_0323)) {
    return 0;
  }

  if(self _meth_8473() < 36) {
    return 0;
  }

  var_4 = length(self._id_04DF);

  if(var_4 < 20) {
    return 0;
  }

  var_5 = self._id_04DF / var_4;

  if(self._id_0280 > 12) {
    var_6 = self._id_027F;
  } else {
    var_6 = vectornormalize(self _meth_84A6(36) - self.origin);
  }

  return vectordot(var_6, var_5) < 0.5;
}

_id_896F(var_0, var_1, var_2, var_3) {
  var_4 = "rifle";
  var_5 = self.damageweapon;

  if(isDefined(var_5) && var_5.basename != "iw8_sn_mike14") {
    var_4 = var_5.classname;
  }

  if(var_4 == "spread") {
    if(isDefined(self._id_026E) && distancesquared(self._id_026E.origin, self.origin) <= 62500) {
      return 1;
    }
  } else if(var_4 == "sniper" || var_4 == "mg")
    return 1;

  return 0;
}

_id_6C0D() {
  var_0 = "_md";
  var_1 = "rifle";
  var_2 = self.damageweapon;

  if(isDefined(var_2) && var_2.basename != "iw8_sn_mike14") {
    var_1 = var_2.classname;
  }

  if(var_1 == "pistol" || var_1 == "smg") {
    var_0 = "_md";
  } else if(var_1 == "spread") {
    var_0 = "_md";

    if(isDefined(self._id_026E) && distancesquared(self._id_026E.origin, self.origin) <= 62500) {
      var_0 = "_lg";
    }
  } else if(var_1 == "sniper" || var_1 == "mg")
    var_0 = "_lg";
  else if(var_1 == "grenade" && isDefined(self.damagemod) && self.damagemod == "MOD_IMPACT") {
    var_0 = "_lg";
  }

  if(isDefined(level._id_5D66)) {
    var_0 = self[[level._id_5D66]](var_0);
  }

  return var_0;
}

_id_6C0E() {
  var_0 = "_md";
  var_1 = "rifle";
  var_2 = self.damageweapon;

  if(isDefined(var_2) && var_2.basename != "iw8_sn_mike14") {
    var_1 = var_2.classname;
  }

  if(var_1 == "pistol" || var_1 == "smg") {
    var_0 = "_md";
  } else if(var_1 == "spread") {
    var_0 = "_md";

    if(isDefined(self._id_026E) && distancesquared(self._id_026E.origin, self.origin) <= 62500) {
      var_0 = "_lg";
    }
  } else if(var_1 == "sniper" || var_1 == "mg")
    var_0 = "_lg";

  if(isDefined(level._id_5D66)) {
    var_0 = self[[level._id_5D66]](var_0);
  }

  return var_0;
}

_id_6C0B() {
  if(isDefined(self._id_0150) && self._id_0150 >= -45 && self._id_0150 <= 45) {
    var_0 = "_b";
    return var_0;
  } else if(isDefined(self._id_0150) && self._id_0150 < -45 && self._id_0150 > -135) {
    var_0 = "_l";
    return var_0;
  } else if(isDefined(self._id_0150) && self._id_0150 > 45 && self._id_0150 < 135) {
    var_0 = "_r";
    return var_0;
  } else {
    var_0 = "_f";
    return var_0;
  }
}

_id_35EE(var_0, var_1, var_2) {
  var_3 = _id_6C0D();
  var_4 = _id_6C0B();
  var_5 = "torso";
  var_6 = "midbody";
  var_7 = [];

  if(scripts\engine\utility::_id_430E("head", "helmet", "neck")) {
    var_5 = "head";
    var_6 = "head";
    var_7[var_7.size] = _id_0009::_id_1C7D(var_1, "head" + var_3 + var_4);
  } else if(scripts\engine\utility::_id_430E("torso_upper", "torso_lower")) {
    var_5 = "torso";
    var_6 = "midbody";
    var_7[var_7.size] = _id_0009::_id_1C7D(var_1, "torso" + var_3 + var_4);
  } else if(scripts\engine\utility::_id_430E("right_arm_upper", "right_arm_lower", "right_hand")) {
    var_5 = "rarm";
    var_6 = "midbody";
    var_7[var_7.size] = _id_0009::_id_1C7D(var_1, "rarm" + var_3 + var_4);
  } else if(scripts\engine\utility::_id_430E("left_arm_upper", "left_arm_lower", "left_hand")) {
    var_5 = "larm";
    var_6 = "midbody";
    var_7[var_7.size] = _id_0009::_id_1C7D(var_1, "larm" + var_3 + var_4);
  } else if(scripts\engine\utility::_id_430E("left_leg_upper", "left_leg_lower", "left_foot")) {
    var_5 = "lleg";
    var_6 = "lowerbody";
    var_7[var_7.size] = _id_0009::_id_1C7D(var_1, "lleg" + var_3 + var_4);
  } else if(scripts\engine\utility::_id_430E("right_leg_upper", "right_leg_lower", "right_foot")) {
    var_5 = "rleg";
    var_6 = "lowerbody";
    var_7[var_7.size] = _id_0009::_id_1C7D(var_1, "rleg" + var_3 + var_4);
  } else {
    var_5 = "torso";
    var_6 = "midbody";
    var_7[var_7.size] = _id_0009::_id_1C7D(var_1, "torso" + var_3 + var_4);
  }

  var_8 = var_5 + var_3 + var_4;
  var_9 = "_2";

  if(var_4 == "_b") {
    var_9 = "_8";
  } else if(var_4 == "_l") {
    var_9 = "_6";
  } else if(var_4 == "_r") {
    var_9 = "_4";
  }

  self._id_1C30._id_144D = var_8;
  self._id_1C30._id_ADEB = var_6;
  self._id_1C30._id_ADF0 = var_3;
  return var_7[randomint(var_7.size)];
}

_id_35EA(var_0, var_1, var_2) {
  var_3 = _id_6C0B();
  var_4 = "torso";
  var_5 = "midbody";
  var_6 = [];

  if(scripts\engine\utility::_id_430E("head", "helmet", "neck")) {
    var_4 = "head";
    var_5 = "head";
    var_6[var_6.size] = _id_0009::_id_1C7D(var_1, "head" + var_3);
  } else if(scripts\engine\utility::_id_430E("torso_upper")) {
    var_4 = "torso_upper";
    var_5 = "midbody";
    var_6[var_6.size] = _id_0009::_id_1C7D(var_1, "torso_upper" + var_3);
  } else if(scripts\engine\utility::_id_430E("torso_lower")) {
    var_4 = "torso_lower";
    var_5 = "midbody";
    var_6[var_6.size] = _id_0009::_id_1C7D(var_1, "torso_lower" + var_3);
  } else if(scripts\engine\utility::_id_430E("right_arm_upper")) {
    var_4 = "rarm_upper";
    var_5 = "midbody";
    var_6[var_6.size] = _id_0009::_id_1C7D(var_1, "rarm_upper" + var_3);
  } else if(scripts\engine\utility::_id_430E("right_arm_lower", "right_hand")) {
    var_4 = "rarm_lower";
    var_5 = "midbody";
    var_6[var_6.size] = _id_0009::_id_1C7D(var_1, "rarm_lower" + var_3);
  } else if(scripts\engine\utility::_id_430E("left_arm_upper")) {
    var_4 = "larm_upper";
    var_5 = "midbody";
    var_6[var_6.size] = _id_0009::_id_1C7D(var_1, "larm_upper" + var_3);
  } else if(scripts\engine\utility::_id_430E("left_arm_lower", "left_hand")) {
    var_4 = "larm_lower";
    var_5 = "midbody";
    var_6[var_6.size] = _id_0009::_id_1C7D(var_1, "larm_lower" + var_3);
  } else if(scripts\engine\utility::_id_430E("left_leg_upper")) {
    var_4 = "lleg_upper";
    var_5 = "lowerbody";
    var_6[var_6.size] = _id_0009::_id_1C7D(var_1, "lleg_upper" + var_3);
  } else if(scripts\engine\utility::_id_430E("left_leg_lower", "left_foot")) {
    var_4 = "lleg_lower";
    var_5 = "lowerbody";
    var_6[var_6.size] = _id_0009::_id_1C7D(var_1, "lleg_lower" + var_3);
  } else if(scripts\engine\utility::_id_430E("right_leg_upper")) {
    var_4 = "rleg_upper";
    var_5 = "lowerbody";
    var_6[var_6.size] = _id_0009::_id_1C7D(var_1, "rleg_upper" + var_3);
  } else if(scripts\engine\utility::_id_430E("right_leg_lower", "right_foot")) {
    var_4 = "rleg_lower";
    var_5 = "lowerbody";
    var_6[var_6.size] = _id_0009::_id_1C7D(var_1, "rleg_lower" + var_3);
  } else {
    var_4 = "torso_lower";
    var_5 = "midbody";
    var_6[var_6.size] = _id_0009::_id_1C7D(var_1, "torso_lower" + var_3);
  }

  var_7 = var_4 + var_3;
  var_8 = "_2";

  if(var_3 == "_b") {
    var_8 = "_8";
  } else if(var_3 == "_l") {
    var_8 = "_6";
  } else if(var_3 == "_r") {
    var_8 = "_4";
  }

  self._id_1C30._id_144D = var_7;
  self._id_1C30._id_ADEB = var_5;
  return var_6[randomint(var_6.size)];
}

_id_35EF(var_0, var_1, var_2) {
  if(isDefined(self._id_1C30._id_144D)) {
    var_3 = self._id_1C30._id_144D;
    return _id_0009::_id_1C7D(var_1, var_3);
  }

  return _id_0009::_id_1C6C(var_1);
}

_id_35ED(var_0, var_1, var_2) {
  var_3 = _id_6C0D();
  var_4 = _id_6C0B();
  var_5 = "torso";
  var_6 = "midbody";
  var_7 = [];

  if(scripts\engine\utility::_id_430E("head", "helmet", "neck")) {
    var_5 = "head";
    var_6 = "head";
    var_7[var_7.size] = _id_0009::_id_1C7D(var_1, "head" + var_3 + var_4);
  } else if(scripts\engine\utility::_id_430E("left_leg_upper", "left_leg_lower", "left_foot", "right_leg_upper", "right_leg_lower", "right_foot")) {
    var_5 = "legs";
    var_6 = "lowerbody";
    var_7[var_7.size] = _id_0009::_id_1C7D(var_1, "legs" + var_3 + var_4);
  } else {
    var_5 = "torso";
    var_6 = "midbody";
    var_7[var_7.size] = _id_0009::_id_1C7D(var_1, "torso" + var_3 + var_4);
  }

  var_8 = var_5 + var_3 + var_4;
  var_9 = "_2";

  if(var_4 == "_b") {
    var_9 = "_8";
  } else if(var_4 == "_l") {
    var_9 = "_6";
  } else if(var_4 == "_r") {
    var_9 = "_4";
  }

  self._id_1C30._id_144D = var_8;
  self._id_1C30._id_ADEB = var_6;
  self._id_1C30._id_ADF0 = var_3;
  return var_7[randomint(var_7.size)];
}

_id_35EC(var_0, var_1, var_2) {
  var_3 = _id_6C0D();
  var_4 = _id_6C0B();
  var_5 = "torso";
  var_6 = "midbody";
  var_7 = [];

  if(scripts\engine\utility::_id_430E("head", "helmet", "neck")) {
    var_5 = "head";
    var_6 = "head";
    var_7[var_7.size] = _id_0009::_id_1C7D(var_1, "head" + var_3 + var_4);
  } else {
    var_5 = "torso";
    var_6 = "midbody";
    var_7[var_7.size] = _id_0009::_id_1C7D(var_1, "torso" + var_3 + var_4);
  }

  var_8 = var_5 + var_3 + var_4;
  var_9 = "_2";

  if(var_4 == "_b") {
    var_9 = "_8";
  } else if(var_4 == "_l") {
    var_9 = "_6";
  } else if(var_4 == "_r") {
    var_9 = "_4";
  }

  self._id_1C30._id_144D = var_8;
  self._id_1C30._id_ADEB = var_6;
  self._id_1C30._id_ADF0 = var_3;
  return var_7[randomint(var_7.size)];
}

_id_360E(var_0, var_1, var_2) {
  var_3 = _id_6C0D();
  var_4 = "pain";
  var_5 = [];
  var_5[var_5.size] = _id_0009::_id_1C7D(var_1, var_4 + var_3);
  var_6 = var_4 + var_3;
  self._id_1C30._id_144D = var_6;
  return var_5[randomint(var_5.size)];
}

_id_6C0C() {
  var_0 = "head";
  var_1 = "head";

  if(scripts\engine\utility::_id_430E("head", "helmet", "neck")) {
    var_0 = "head";
    var_1 = "head";
  } else if(scripts\engine\utility::_id_430E("torso_upper")) {
    var_0 = "torso_upper";
    var_1 = "midbody";
  } else if(scripts\engine\utility::_id_430E("torso_lower")) {
    var_0 = "torso_lower";
    var_1 = "midbody";
  } else if(scripts\engine\utility::_id_430E("left_leg_upper", "left_leg_lower", "left_foot")) {
    var_0 = "l_leg";
    var_1 = "lowerbody";
  } else if(scripts\engine\utility::_id_430E("right_leg_upper", "right_leg_lower", "right_foot")) {
    var_0 = "r_leg";
    var_1 = "lowerbody";
  } else if(scripts\engine\utility::_id_430E("left_arm_upper", "left_arm_lower", "left_hand")) {
    var_0 = "l_arm";
    var_1 = "lowerbody";
  } else if(scripts\engine\utility::_id_430E("right_arm_upper", "right_arm_lower", "right_hand")) {
    var_0 = "r_arm";
    var_1 = "lowerbody";
  }

  return [var_0, var_1];
}

_id_35F0(var_0, var_1, var_2) {
  var_3 = _id_6C0D();
  [var_5, var_6] = _id_6C0C();
  self._id_1C30._id_144D = var_5;
  self._id_1C30._id_ADEB = var_6;
  self._id_1C30._id_ADF0 = var_3;
  var_7 = _id_0009::_id_1C7D(var_1, var_5);
  return var_7;
}

choosesimpledirectionalpainanim(var_0, var_1, var_2) {
  var_3 = _id_6C0B();
  var_4 = undefined;

  if(var_3 == "_b") {
    var_4 = "back";
  } else if(var_3 == "_l") {
    var_4 = "left";
  } else if(var_3 == "_r") {
    var_4 = "right";
  } else if(var_3 == "_f") {
    var_4 = "front";
  }

  var_5 = var_4;
  return _id_0009::_id_1C7D(var_1, var_5);
}

_id_B8B1(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon(var_1 + "_finished");

  if(var_0 == "dog") {
    thread scripts\sound\snd_dogs::play_dog_pain_sound();
  }

  if(isDefined(self._id_0DDF._id_ADFA)) {
    self._id_0DDF._id_9024 = self._id_0DDF._id_ADFA;
  } else {
    self._id_0DDF._id_9024 = 0;
  }

  self._id_0DDF._id_ADFA = gettime();

  if(self._id_03FF != "none") {
    self._id_0DDF._id_ADED = 1;
  } else {
    self._id_0DDF._id_ADED = undefined;
  }

  self _meth_8019("gravity");

  if(!istrue(var_6)) {
    self _meth_8251("face angle", self.angles[1]);
  }

  if(!isDefined(self._id_A522)) {
    scripts\anim\face::_id_CB6D("pain");
  }

  if(_id_08F6::_id_DB6E(scripts\common\utility::_id_10A0D())) {
    _id_08F6::_id_780D();
  }

  var_7 = var_1;

  if(isDefined(var_5)) {
    var_7 = var_5;
  }

  var_8 = _id_0009::_id_1C5C(var_0, var_1);
  var_9 = _id_0009::_id_1C6E(var_1, var_8);
  thread _id_06E3::play_paired_turret_anim_if_needed(var_9, var_2);
  self _meth_85ED(var_7, var_8);

  if(var_3 == 1) {
    self._id_1C30._id_CFE8 = 0;
    thread _id_10825(var_0, var_1);
  }

  var_10 = _id_0009::_id_1C6E(var_7, var_8);
  _id_0009::_id_1C8E(var_0, var_1, var_10);
  self._id_036F = 1;

  if(_func_0011(var_10, "code_move")) {
    _id_0009::_id_1C45(var_0, var_1, undefined, undefined, var_7);
  }

  _id_0009::_id_1C45(var_0, var_1, undefined, undefined, var_7);

  if(istrue(var_4)) {
    _id_5B1B(var_0, var_1, var_2);
  } else {
    _id_5B1B(var_0, var_1);
  }
}

_id_ADE6(var_0, var_1) {
  switch (var_1) {
    case "pain_can_end":
      return 1;
  }
}

_id_3DE4(var_0, var_1, var_2) {
  if(isDefined(self._id_0B67._id_011D) && self._id_0B67._id_011D == "A") {
    return 1;
  } else {
    return 0;
  }
}

_id_5B1B(var_0, var_1, var_2) {
  self notify("killanimscript");

  if(isDefined(self._id_1C30._id_CFE8)) {
    self._id_1C30._id_CFE8 = undefined;
  }

  var_3 = undefined;

  if(isDefined(var_2)) {
    if(_func_0107(var_2)) {
      var_3 = var_2[0];
    } else {
      var_3 = var_2;
    }
  }

  if(!isDefined(var_3)) {
    return;
  }
  thread _id_0009::_id_1CA1(var_3, undefined);
}

_id_B37B(var_0, var_1, var_2) {
  self._id_0260 = 1;
  _id_B8B1(var_0, var_1, var_2, 1);
}

_id_B37A(var_0, var_1, var_2) {
  self._id_0260 = 1;
  _id_B8AA(var_0, var_1, var_2);
}

_id_DC01() {
  if(self._id_014C && !isDefined(self._id_4A8F)) {
    if(self._id_0131 == "prone") {
      return 0;
    }

    if(isDefined(self._id_026E) && isDefined(self._id_026E.team) && self._id_026E.team == self.team) {
      return 0;
    }

    if(self._id_4328 > 0) {
      return 0;
    }

    return 1;
  }

  return 0;
}

_id_DB1D(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_014C) && self._id_014C && !isDefined(self._id_4A8F)) {
    if(isDefined(self._id_026E) && isDefined(self._id_026E._id_04B9) && self._id_026E._id_04B9 == "c8") {
      var_4 = self.damageweapon;

      if(isDefined(var_4) && var_4._id_0247) {
        return 1;
      }
    }
  }

  return 0;
}

_id_B8AB(var_0, var_1, var_2) {
  self._id_1C30._id_250A = 1;
  _id_B8B1(var_0, var_1, var_2, 0, 1);
}

_id_B8AC(var_0, var_1, var_2) {
  self._id_1C30._id_250A = undefined;
}

_id_35A8(var_0, var_1, var_2) {
  return _id_0009::_id_1C7D(var_1, "pain");
}

_id_3617(var_0, var_1, var_2) {
  if(self._id_90AC == "torso_upper") {
    var_3 = _id_0009::_id_1C7D(var_1, "torso_upper");
  } else if(self._id_90AC == "torso_lower") {
    var_3 = _id_0009::_id_1C7D(var_1, "torso_lower");
  } else {
    var_3 = _id_0009::_id_1C7D(var_1, "default");
  }

  self._id_90AC = undefined;
  return var_3;
}

_id_3616(var_0, var_1, var_2) {
  if(scripts\engine\utility::_id_430E("torso_upper")) {
    self._id_90AC = "torso_upper";
    return _id_0009::_id_1C7D(var_1, "torso_upper");
  } else if(scripts\engine\utility::_id_430E("torso_lower")) {
    self._id_90AC = "torso_lower";
    return _id_0009::_id_1C7D(var_1, "torso_lower");
  } else {
    self._id_90AC = "default";
    return _id_0009::_id_1C7D(var_1, "default");
  }
}

_id_3615(var_0, var_1, var_2) {
  if(_id_DC01()) {
    if(self._id_0131 == "crouch") {
      return _id_0009::_id_1C7D(var_1, "damage_shield_crouch");
    } else if(self._id_0131 == "stand") {
      return _id_0009::_id_1C7D(var_1, "damage_shield_stand");
    }
  }

  if(scripts\anim\utility_common::_id_8AD4()) {
    return _id_3613(var_0, var_1, var_2);
  }

  var_3 = [];

  if(scripts\engine\utility::_id_430E("torso_upper")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "torso_upper");
  } else if(scripts\engine\utility::_id_430E("torso_lower")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "torso_lower");
  } else if(scripts\engine\utility::_id_430E("head", "helmet", "neck")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "head");
  } else if(scripts\engine\utility::_id_430E("right_arm_upper", "right_arm_lower")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "right_arm");
  } else if(scripts\engine\utility::_id_430E("left_arm_upper", "left_arm_lower")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "left_arm");
  } else if(scripts\engine\utility::_id_430E("left_leg_upper", "left_leg_lower", "left_foot")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "left_leg");
  } else if(scripts\engine\utility::_id_430E("right_leg_upper", "right_leg_lower", "right_foot")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "right_leg");
  }

  if(var_3.size < 2) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "default");
  }

  return var_3[randomint(var_3.size)];
}

_id_3611(var_0, var_1, var_2) {
  if(_id_DC01()) {
    if(self._id_0131 == "crouch") {
      return _id_0009::_id_1C7D(var_1, "damage_shield_crouch");
    } else if(self._id_0131 == "stand") {
      return _id_0009::_id_1C7D(var_1, "damage_shield_stand");
    }
  }

  var_3 = [];

  if(var_3.size < 2) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "default");
  }

  return var_3[randomint(var_3.size)];
}

_id_35F8(var_0, var_1, var_2) {
  var_3 = [];
  var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "default");
  return var_3[randomint(var_3.size)];
}

_id_3610(var_0, var_1, var_2) {
  var_3 = [];
  var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "default");

  if(scripts\engine\utility::_id_430E("left_hand", "left_arm_lower", "left_arm_upper")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "left_arm");
  }

  if(scripts\engine\utility::_id_430E("right_hand", "right_arm_lower", "right_arm_upper")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "right_arm");
  }

  return var_3[randomint(var_3.size)];
}

_id_3613(var_0, var_1, var_2) {
  var_3 = [];

  if(scripts\engine\utility::_id_430E("torso_upper")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "pistol_torso_upper");
  } else if(scripts\engine\utility::_id_430E("torso_lower")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "pistol_torso_lower");
  } else if(scripts\engine\utility::_id_430E("neck")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "pistol_neck");
  } else if(scripts\engine\utility::_id_430E("head")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "pistol_head");
  } else if(scripts\engine\utility::_id_430E("left_leg_upper", "right_leg_upper")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "pistol_leg");
  } else if(scripts\engine\utility::_id_430E("left_arm_upper")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "pistol_left_arm_upper");
  } else if(scripts\engine\utility::_id_430E("left_arm_lower")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "pistol_left_arm_lower");
  } else if(scripts\engine\utility::_id_430E("right_arm_upper")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "pistol_right_arm_upper");
  } else if(scripts\engine\utility::_id_430E("right_arm_lower")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "pistol_right_arm_lower");
  }

  if(var_3.size < 2) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "pistol_default");
  }

  return var_3[randomint(var_3.size)];
}

_id_3614(var_0, var_1, var_2) {
  var_3 = 30;
  var_4 = 150;
  var_5 = 300;
  var_6 = [];
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = _func_02A6(self.origin, self _meth_8216((var_5, 0, 0)), self, 1);

  if(var_10["fraction"] > 0.9) {
    var_8 = 1;
  }

  if(var_10["fraction"] > 0.9 * (var_4 / var_5)) {
    var_7 = 1;
  }

  if(isDefined(self._id_0DDF._id_4AC5)) {
    var_8 = 0;
    var_7 = 0;
  }

  var_11 = length(self._id_04DF);
  var_12 = self _meth_87CE();
  var_13 = _func_03A6(var_12, var_11);

  if(var_8) {
    var_14 = "long" + var_13;
    var_6[var_6.size] = _id_0009::_id_1C7D(var_1, var_14);
  } else if(var_7) {
    var_14 = "medium" + var_13;
    var_6[var_6.size] = _id_0009::_id_1C7D(var_1, var_14);
  } else if(var_10["fraction"] > 0.9 * (var_3 / var_5)) {
    var_14 = "short" + var_13;
    var_6[var_6.size] = _id_0009::_id_1C7D(var_1, var_14);
  }

  if(var_6.size == 0) {
    return _id_0009::_id_1C7D(var_1, "emergency_backup");
  }

  return var_6[randomint(var_6.size)];
}

_id_3619(var_0, var_1, var_2, var_3) {
  return _id_0009::_id_1C38(var_0, var_1, var_2);
}

_id_3618(var_0, var_1, var_2) {
  return _id_08F4::_id_6D93(var_0, var_1, ::_id_3619);
}

_id_360B(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2) && isDefined(var_2[1])) {
    return _id_0009::_id_1C7D(var_1, var_2[1]);
  }

  if(self._id_0131 == "crouch") {
    return _id_0009::_id_1C7D(var_1, "crouch");
  } else {
    return _id_0009::_id_1C7D(var_1, "stand");
  }
}

_id_360C(var_0, var_1, var_2) {
  return _id_08F4::_id_6D93(var_0, var_1, ::_id_360B);
}

_id_360A(var_0, var_1, var_2) {
  return _id_360B(var_0, var_1, var_2, undefined);
}

_id_35F5(var_0, var_1, var_2) {
  var_3 = "back";
  return _id_0009::_id_1C7D(var_1, var_3);
}

_id_360D(var_0, var_1, var_2) {
  var_3 = "crouch";

  if(isDefined(var_2)) {
    var_3 = var_3 + "_" + var_2;
  }

  return _id_0009::_id_1C7D(var_1, var_3);
}

_id_35F6(var_0, var_1, var_2) {
  var_3 = [];

  if(scripts\engine\utility::_id_430E("torso_upper", "torso_lower")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "torso");
  } else if(scripts\engine\utility::_id_430E("head", "helmet", "neck")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "head");
  }

  if(var_3.size < 2) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "default");
  }

  return var_3[randomint(var_3.size)];
}

_id_360F(var_0, var_1, var_2) {
  var_3 = "stand";

  if(isDefined(var_2) && isDefined(var_2)) {
    var_3 = var_3 + "_" + var_2;
  }

  return _id_0009::_id_1C7D(var_1, var_3);
}

_id_35F7(var_0, var_1, var_2) {
  var_3 = [];

  if(scripts\engine\utility::_id_430E("torso_upper")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "torso_upper");
  } else if(scripts\engine\utility::_id_430E("torso_lower")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "torso_lower");
  } else if(scripts\engine\utility::_id_430E("head", "helmet", "neck")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "head");
  } else if(scripts\engine\utility::_id_430E("right_arm_upper", "right_arm_lower")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "right_arm");
  } else if(scripts\engine\utility::_id_430E("left_arm_upper", "left_arm_lower")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "left_arm");
  } else if(scripts\engine\utility::_id_430E("left_leg_upper", "left_leg_lower", "left_foot")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "left_leg");
  } else if(scripts\engine\utility::_id_430E("right_leg_upper", "right_leg_lower", "right_foot")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "right_leg");
  }

  if(var_3.size < 2) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "default");
  }

  return var_3[randomint(var_3.size)];
}

_id_361A(var_0, var_1, var_2) {
  var_3 = 3;
  var_4 = "deaf_" + (randomint(var_3) + 1);
  return _id_0009::_id_1C7D(var_1, var_4);
}

_id_3899(var_0, var_1, var_2) {
  if(isDefined(self.script) && self.script == "pain") {
    self notify("killanimscript");
  } else {
    self notify("pain_end");
  }

  if(isDefined(self._id_432A)) {
    self._id_4328 = undefined;
    self._id_432A = undefined;
    self._id_0043 = 1;

    if(!isDefined(self._id_BB7A)) {
      self.ignoreme = 0;
    }

    self._id_BB7A = undefined;
  }

  if(isDefined(self._id_2599)) {
    self._id_2599 = undefined;
    self._id_0043 = 1;
  }

  _id_3966(var_0, var_1, var_2);

  if(istrue(self._id_0272)) {
    _id_0900::_id_F083(var_0, var_1, var_2);
  }

  if(!istrue(self._id_0229)) {
    if(isDefined(self._id_0192) && _func_0135(self._id_04DF) < 1 && isDefined(self._id_04F6) && !istrue(self._id_0192.ignoreme) && self _meth_8067(self._id_0192)) {
      self._id_036A = gettime() + 2000;
    }
  }
}

_id_F489(var_0, var_1, var_2, var_3) {
  if(!scripts\engine\utility::_id_8862()) {
    return 1;
  }

  if(gettime() > self._id_5CA2) {
    return 1;
  }

  return _id_0009::_id_1C50(var_0, "end") || _id_0009::_id_1C50(var_0, "finish");
}

_id_87C7(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_011F)) {
    return 0;
  }

  if(isDefined(self._id_011F.type) && self._id_011F.type == "Cover Crouch") {
    return 1;
  } else {
    return 0;
  }
}

_id_87D0(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_011F)) {
    return 0;
  }

  if(isDefined(self._id_011F.type) && self._id_011F.type == "Cover Stand") {
    return 1;
  } else {
    return 0;
  }
}

_id_87CE(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_011F)) {
    return 0;
  }

  if(isDefined(self._id_011F.type) && self._id_011F.type == "Cover Right" && (isDefined(self._id_0131) && self._id_0131 == "crouch")) {
    return 1;
  } else {
    return 0;
  }
}

_id_87CF(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_011F)) {
    return 0;
  }

  if(isDefined(self._id_011F.type) && self._id_011F.type == "Cover Right" && (isDefined(self._id_0131) && self._id_0131 == "stand")) {
    return 1;
  } else {
    return 0;
  }
}

_id_87C9(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_011F)) {
    return 0;
  }

  if(isDefined(self._id_011F.type) && self._id_011F.type == "Cover Left" && (isDefined(self._id_0131) && self._id_0131 == "crouch")) {
    return 1;
  } else {
    return 0;
  }
}

_id_87CA(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_011F)) {
    return 0;
  }

  if(isDefined(self._id_011F.type) && self._id_011F.type == "Cover Left" && (isDefined(self._id_0131) && self._id_0131 == "stand")) {
    return 1;
  } else {
    return 0;
  }
}

_id_8846(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_011F)) {
    return 0;
  }

  if(isDefined(self._id_011F.type) && self._id_011F.type == "Exposed" && (isDefined(self._id_0131) && self._id_0131 == "crouch")) {
    return 1;
  } else {
    return 0;
  }
}

_id_8847(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_011F)) {
    return 0;
  }

  if(isDefined(self._id_011F.type) && self._id_011F.type == "Exposed" && (isDefined(self._id_0131) && self._id_0131 == "prone")) {
    return 1;
  } else {
    return 0;
  }
}

_id_B32E(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  _id_B32F(var_0, var_1);
  thread _id_B333(var_0, var_1);
  _id_0009::_id_1C45(var_0, var_1);
}

_id_B32F(var_0, var_1) {
  var_2 = _id_0009::_id_1C5C(var_0, var_1);
  var_3 = 1;

  if(isDefined(self._id_5CA2)) {
    var_4 = self._id_5CA2 - gettime();
    var_5 = _id_0009::_id_1C6E(var_1, var_2);
    var_6 = _func_0079(var_5) * 1000;

    if(var_4 > 0) {
      var_3 = var_6 / var_4;
    }

    var_3 = var_3 + randomfloatrange(-0.2, 0.2);
    var_3 = clamp(var_3, 0.2, 1.65);
  }

  self _meth_85ED(var_1, var_2, var_3);
}

_id_B333(var_0, var_1) {
  self endon(var_1 + "_finished");
  var_2 = self._id_5CA2;

  while(isDefined(self._id_5CA2)) {
    if(var_2 != self._id_5CA2) {
      var_2 = self._id_5CA2;
      _id_B32F(var_0, var_1);
    }

    waitframe();
  }
}

_id_35AE(var_0, var_1, var_2) {
  var_3 = "med";

  if(isDefined(self._id_5CA2)) {
    var_4 = self._id_5CA2 - gettime();

    if(var_4 <= 3750) {
      var_3 = "short";
    } else if(var_4 >= 5250) {
      var_3 = "med";
    }
  }

  var_5 = _id_0009::_id_1C7D(var_1, var_3);
  return _id_08F1::_id_BC1C(var_1, var_3, var_5);
}

_id_3884(var_0, var_1, var_2) {
  _id_3899(var_0, var_1, var_2);
  scripts\common\utility::_id_5C9F();
}

_id_B324(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = _id_0009::_id_1C5C(var_0, var_1, var_2);
  var_4 = randomfloatrange(0.8, 1.2);
  self _meth_8251("face angle", self.angles[1]);
  self _meth_85ED(var_1, var_3, var_4);
  _id_0009::_id_1C45(var_0, var_1, ::_id_2D7A);
}

_id_2D7A(var_0) {
  if(isDefined(self._id_D09F)) {
    return;
  }
  switch (var_0) {
    case "burn_vfx_pain_start_head":
      playFXOnTag(level._id_60A1["vfx_burn_sml_head_low"], self, "j_helmet");
      break;
    case "burn_vfx_pain_start_arm_l":
      playFXOnTag(level._id_60A1["vfx_burn_sml_low"], self, "j_elbow_le");
      break;
    case "burn_vfx_pain_start_arm_r":
      playFXOnTag(level._id_60A1["vfx_burn_sml_low"], self, "j_shoulder_ri");
      break;
    case "burn_vfx_pain_start_leg_l":
      playFXOnTag(level._id_60A1["vfx_burn_med_low"], self, "j_knee_le");
      break;
    case "burn_vfx_pain_start_leg_r":
      playFXOnTag(level._id_60A1["vfx_burn_med_low"], self, "j_knee_ri");
      break;
  }
}

_id_35A6(var_0, var_1, var_2) {
  var_3 = var_1;

  if(self._id_0131 == "prone") {
    return _id_0009::_id_1C7D(var_1, "pain_burning_prone");
  }

  var_4 = scripts\engine\utility::ter_op(randomint(2) == 1, "arm", "leg");
  var_3 = var_3 + "_" + self._id_2D8A + "_" + var_4;
  var_5 = _id_0009::_id_1C7D(var_1, var_3);
  return _id_08F1::_id_BC1C(var_1, var_3, var_5);
}

_id_DB90(var_0, var_1, var_2, var_3) {
  var_4 = _id_6C0B();

  if(var_4 == "_f") {
    return 0;
  }

  self _meth_86DE();

  if(isDefined(self._id_0192) && isDefined(self._id_026E) && self._id_0192 == self._id_026E) {
    var_5 = vectornormalize(self.origin - self._id_0192.origin);

    if(vectordot(var_5, self._id_0147) > 0.866) {
      return 1;
    }
  }

  return 0;
}

_id_DB8F(var_0, var_1, var_2, var_3) {
  if(_id_DB90(var_0, var_1, var_2, var_3)) {
    var_4 = 1;

    if(isDefined(self._id_011F) && _id_06B0::_id_DB0B()) {
      var_4 = _id_06B0::_id_87D3(self._id_011F);
    } else {
      var_4 = _id_08F1::_id_87D2();
    }

    return !var_4;
  }

  return 0;
}

_id_DB91(var_0, var_1, var_2, var_3) {
  var_4 = _id_6C0B();

  if(var_4 == "_f") {
    return 0;
  }

  if(_func_0135(self._id_04DF) > 3600) {
    return 0;
  }

  self _meth_86DE();

  if(isDefined(self._id_0192) && isPlayer(self._id_0192)) {
    return 1;
  }

  return 0;
}

_id_3612(var_0, var_1, var_2) {
  var_3 = _id_6C0B();
  self._id_1C30._id_144D = "torso_md" + var_3;
  self._id_1C30._id_ADEB = "midbody";
  self._id_1C30._id_ADF0 = "_md";
  return _id_0009::_id_1C7D(var_1, self._id_1C30._id_144D);
}

_id_ADE3(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  var_4 = _id_0009::_id_1C6E(var_1, var_3);
  var_5 = _func_0079(var_4);
  var_6 = var_5 * 0.8;
  var_7 = var_5;
  var_8 = _func_00BB(var_4, "face_enemy")[0];

  if(isDefined(var_8)) {
    var_6 = var_8 * var_5;
  } else {
    if(_id_0009::_id_1C43(var_0, "notetrackAim")) {
      var_9 = _func_00BB(var_4, "start_aim")[0];

      if(isDefined(var_9)) {
        var_6 = min(var_6, max(0, var_9 - 0.3) * var_5);
        var_7 = var_9 * var_5;
      }
    }

    var_6 = min(var_6, max(0, var_5 - 0.5));
  }

  wait(var_6);

  if(isalive(var_2)) {
    self._id_ADEC = self._id_04A8;
    self._id_04A8 = 0.1;
    self _meth_8251("face enemy");
  }
}

_id_B8B0(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");

  if(isalive(self._id_0192) && isDefined(self._id_026E) && self._id_0192 == self._id_026E) {
    thread _id_ADE3(var_0, var_1, self._id_0192);
  }

  _id_B8B1(var_0, var_1, var_2, 0, 1, undefined, 1);
}

_id_B8AF(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");

  if(isalive(self._id_0192) && isDefined(self._id_026E) && self._id_0192 == self._id_026E) {
    thread _id_ADE3(var_0, var_1, self._id_0192);
  }

  _id_B8B1(var_0, var_1, var_2, 0, 1);
}

_id_B8AD(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self._id_ADE4 = self._id_026E;
  _id_B8B1(var_0, var_1, var_2, 0, 1);
}

_id_B8AE(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");

  if(isalive(self._id_0192) && isDefined(self._id_ADE4) && self._id_0192 == self._id_ADE4) {
    thread _id_ADE3(var_0, var_1, self._id_0192);
  }

  self._id_ADE4 = undefined;
  _id_08F1::_id_B31C(var_0, var_1, var_2);
}

_id_3966(var_0, var_1, var_2) {
  if(isDefined(self._id_ADEC)) {
    self._id_04A8 = self._id_ADEC;
    self._id_ADEC = undefined;
  }
}