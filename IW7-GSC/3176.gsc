/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3176.gsc
************************/

func_51E8(var_0, var_1, var_2, var_3) {
  if(isDefined(self.asm.var_51E8)) {
    return;
  }

  self.asm.var_51E8 = 1;
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self.asm.var_4C86 = spawnStruct();
  self.asm.var_7360 = 0;
  self.var_22EE = 1;
  self.asm.var_77C1 = spawnStruct();
  thread lib_0A1E::func_234F();
  func_98A7(var_0);
  func_9810();
  func_97C3(var_0);
  if(weaponclass(self.var_394) == "mg") {
    self.var_BC = "cover_lmg";
  }
}

func_98A7(var_0) {
  if(!isDefined(level.var_C05A)) {
    anim.var_C05A = [];
  }

  if(isDefined(level.var_C05A[var_0])) {
    return;
  }

  var_1 = [];
  var_1["Cover Left"] = 0;
  var_1["Cover Right"] = -90;
  var_1["Cover Crouch"] = -90;
  var_1["Cover Stand"] = -90;
  var_1["Cover Stand 3D"] = -90;
  level.var_C05A[var_0] = var_1;
  var_1 = [];
  var_1["Cover Left"] = 180;
  var_1["Cover Left Crouch"] = 0;
  var_1["Cover Right"] = 180;
  var_1["Cover Crouch"] = 180;
  var_1["Cover Stand"] = 180;
  var_1["Cover Stand 3D"] = 180;
  level.var_7365[var_0] = var_1;
  var_2 = [];
  level.var_C046[var_0] = var_2;
  var_1 = [];
  var_1["Cover Left Crouch"] = 0;
  var_1["Cover Right"] = 0;
  var_1["Cover Right Crouch"] = 90;
  level.var_C04E[var_0] = var_1;
  var_2 = [];
  var_2["Cover Crouch"] = 45;
  level.var_C04D[var_0] = var_2;
  var_1 = [];
  var_1["Cover Left Crouch"] = 0;
  var_1["Cover Right"] = 180;
  var_1["Cover Right Crouch"] = 180;
  level.var_7364[var_0] = var_1;
  var_1 = [];
  var_1["Cover Crouch"] = 0;
  var_1["Cover Left Crouch"] = 0;
  level.var_7363[var_0] = var_1;
}

func_97C3(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = [];
  var_1["exposed_idle"] = var_3;
  var_3 = [];
  var_2["exposed_idle"] = var_3;
  var_3 = [];
  var_3["down"] = 15;
  var_1["cover_crouch_lean"] = var_3;
  var_3 = [];
  var_3["down"] = 15;
  var_2["cover_crouch_lean"] = var_3;
  var_3 = [];
  var_2["cover_crouch_aim"] = var_3;
  var_3 = [];
  var_3["right"] = -15;
  var_1["cover_left_lean"] = var_3;
  var_3 = [];
  var_3["right"] = -15;
  var_2["cover_left_lean"] = var_3;
  var_3 = [];
  var_3["right"] = -15;
  var_1["cover_left_crouch_lean"] = var_3;
  var_3 = [];
  var_3["right"] = -15;
  var_2["cover_left_crouch_lean"] = var_3;
  var_3 = [];
  var_3["left"] = 15;
  var_1["cover_right_lean"] = var_3;
  var_3 = [];
  var_3["down"] = 37;
  var_3["left"] = 24;
  var_2["cover_right_lean"] = var_3;
  var_3 = [];
  var_3["left"] = 25;
  var_1["cover_right_crouch_lean"] = var_3;
  var_3 = [];
  var_3["left"] = 15;
  var_2["cover_right_crouch_lean"] = var_3;
  if(!isDefined(level.var_43FE)) {
    level.var_43FE = [];
    level.var_7361 = [];
    level.var_1A43 = [];
  }

  level.var_43FE[var_0] = var_1;
  level.var_7361[var_0] = var_2;
  var_4 = [];
  var_4["cover_stand_exposed"] = "cover_stand_exposed";
  var_4["cover_stand_hide_to_exposed"] = "cover_stand_exposed";
  var_4["cover_stand_full_exposed"] = "exposed_idle";
  var_4["cover_stand_hide_to_full_exposed"] = "exposed_idle";
  var_4["cover_stand_to_exposed_idle"] = "exposed_idle";
  var_4["wall_run_exit"] = "exposed_idle";
  var_4["wall_run_continue"] = "exposed_idle";
  var_4["wall_run_left_shoot"] = "exposed_idle";
  var_4["wall_run_right_shoot"] = "exposed_idle";
  var_4["wall_run_attach_left_shoot"] = "exposed_idle";
  var_4["wall_run_attach_right_shoot"] = "exposed_idle";
  var_4["cover_crouch_hide_to_stand"] = "exposed_idle";
  var_4["cover_crouch_hide_to_aim"] = "cover_crouch_aim";
  var_4["cover_crouch_hide_to_right"] = "cover_crouch_aim";
  var_4["cover_crouch_hide_to_left"] = "cover_crouch_aim";
  var_4["cover_crouch_hide_to_lean"] = "cover_crouch_lean";
  var_4["cover_crouch_aim"] = "cover_crouch_aim";
  var_4["cover_crouch_lean"] = "cover_crouch_lean";
  var_4["cover_crouch_exposed_left"] = "cover_crouch_aim";
  var_4["cover_crouch_exposed_right"] = "cover_crouch_aim";
  var_4["cover_crouch_stand"] = "exposed_idle";
  var_4["cover_crouch_to_exposed_idle"] = "exposed_idle";
  var_4["cover_right_exposed_A"] = "exposed_idle";
  var_4["cover_right_hide_to_A"] = "exposed_idle";
  var_4["cover_right_exposed_B"] = "exposed_idle";
  var_4["cover_right_hide_to_B"] = "exposed_idle";
  var_4["cover_right_A_to_B"] = "exposed_idle";
  var_4["cover_right_B_to_A"] = "exposed_idle";
  var_4["cover_right_crouch_exposed_A"] = "exposed_idle";
  var_4["cover_right_crouch_exposed_B"] = "exposed_idle";
  var_4["cover_right_crouch_hide_to_A"] = "exposed_idle";
  var_4["cover_right_crouch_hide_to_B"] = "exposed_idle";
  var_4["cover_right_crouch_A_to_B"] = "exposed_idle";
  var_4["cover_right_crouch_B_to_A"] = "exposed_idle";
  var_4["cover_right_lean"] = "cover_right_lean";
  var_4["cover_right_hide_to_lean"] = "cover_right_lean";
  var_4["cover_right_crouch_hide_to_lean"] = "cover_right_crouch_lean";
  var_4["cover_right_crouch_lean"] = "cover_right_crouch_lean";
  var_4["cover_right_to_exposed_idle"] = "exposed_idle";
  var_4["cover_left_exposed_A"] = "exposed_idle";
  var_4["cover_left_exposed_B"] = "exposed_idle";
  var_4["cover_left_hide_to_A"] = "exposed_idle";
  var_4["cover_left_hide_to_B"] = "exposed_idle";
  var_4["cover_left_A_to_B"] = "exposed_idle";
  var_4["cover_left_B_to_A"] = "exposed_idle";
  var_4["cover_left_hide_to_lean"] = "cover_left_lean";
  var_4["cover_left_lean"] = "cover_left_lean";
  var_4["cover_left_crouch_hide_to_lean"] = "cover_left_crouch_lean";
  var_4["cover_left_crouch_lean"] = "cover_left_crouch_lean";
  var_4["cover_left_to_exposed_idle"] = "exposed_idle";
  var_4["cqb_idle"] = "exposed_idle";
  var_4["cqb_stand_loop"] = "exposed_idle";
  var_4["cqb_stand_strafe_loop"] = "exposed_idle";
  var_4["stand_run_strafe_loop"] = "exposed_idle";
  var_4["Exposed_Reload"] = "exposed_idle";
  var_4["Exposed_WeaponSwitch"] = "exposed_idle";
  var_4["exposed_stand_turn"] = "exposed_idle";
  var_4["exposed_idle"] = "exposed_idle";
  var_4["exposed_prone"] = "exposed_idle";
  var_4["exposed_stand_infantry_reaction"] = "exposed_idle";
  level.var_1A43[var_0] = var_4;
}

func_9810() {
  if(!isDefined(level.var_85DF)) {
    anim.var_85DF = [];
  }

  if(isDefined(level.var_85DF["soldier"])) {
    return;
  }

  level.var_85DF["soldier"] = [];
  level.var_85E1["soldier"] = [];
  level.var_85DF["soldier"]["grenade_return_throw"]["throw_short"] = self[[self.var_7190]]("soldier", "grenade_return_throw", "throw_short");
  level.var_85E1["soldier"]["grenade_return_throw"]["throw_short"] = [];
  level.var_85E1["soldier"]["grenade_return_throw"]["throw_short"][0] = (78.9794, 10.7276, 26.4898);
  level.var_85E1["soldier"]["grenade_return_throw"]["throw_short"][1] = (78.9794, 10.7276, 26.4898);
  level.var_85DF["soldier"]["grenade_return_throw"]["throw_long"] = self[[self.var_7190]]("soldier", "grenade_return_throw", "throw_long");
  level.var_85E1["soldier"]["grenade_return_throw"]["throw_long"] = [];
  level.var_85E1["soldier"]["grenade_return_throw"]["throw_long"][0] = (78.9794, 10.7276, 26.4898);
  level.var_85E1["soldier"]["grenade_return_throw"]["throw_long"][1] = (108.037, 19.9336, 58.7762);
  level.var_85DF["soldier"]["grenade_return_throw"]["throw_default"] = self[[self.var_7190]]("soldier", "grenade_return_throw", "throw_default");
  level.var_85E1["soldier"]["grenade_return_throw"]["throw_default"] = [];
  level.var_85E1["soldier"]["grenade_return_throw"]["throw_default"][0] = (108.037, 19.9336, 58.7762);
  level.var_85DF["soldier"]["cover_stand_grenade"]["grenade_exposed"] = self[[self.var_7190]]("soldier", "cover_stand_grenade", "grenade_exposed");
  level.var_85E1["soldier"]["cover_stand_grenade"]["grenade_exposed"] = [];
  level.var_85E1["soldier"]["cover_stand_grenade"]["grenade_exposed"][0] = (-10.4497, 12.4254, 63.2582);
  level.var_85E1["soldier"]["cover_stand_grenade"]["grenade_exposed"][1] = (0.852884, 19.6649, 55.6843);
  level.var_85E1["soldier"]["cover_stand_grenade"]["grenade_exposed"][2] = (-4.36139, 16.7827, 65.348);
  level.var_85E1["soldier"]["cover_stand_grenade"]["grenade_exposed"][3] = (16.8571, -2.85471, 67.4137);
  level.var_85DF["soldier"]["cover_stand_grenade"]["grenade_safe"] = self[[self.var_7190]]("soldier", "cover_stand_grenade", "grenade_safe");
  level.var_85E1["soldier"]["cover_stand_grenade"]["grenade_safe"] = [];
  level.var_85E1["soldier"]["cover_stand_grenade"]["grenade_safe"][0] = (-10.4497, 12.4254, 63.2582);
  level.var_85E1["soldier"]["cover_stand_grenade"]["grenade_safe"][1] = (0.852884, 19.6649, 55.6843);
  level.var_85E1["soldier"]["cover_stand_grenade"]["grenade_safe"][2] = (-4.36139, 16.7827, 65.348);
  level.var_85E1["soldier"]["cover_stand_grenade"]["grenade_safe"][3] = (16.8571, -2.85471, 67.4137);
  level.var_85DF["soldier"]["cover_crouch_grenade"]["grenade_exposed"] = self[[self.var_7190]]("soldier", "cover_crouch_grenade", "grenade_exposed");
  level.var_85E1["soldier"]["cover_crouch_grenade"]["grenade_exposed"] = [];
  level.var_85E1["soldier"]["cover_crouch_grenade"]["grenade_exposed"][0] = (-3.96449, 8.40924, 48.214);
  level.var_85E1["soldier"]["cover_crouch_grenade"]["grenade_exposed"][1] = (-3.96449, 8.40924, 48.214);
  level.var_85E1["soldier"]["cover_crouch_grenade"]["grenade_exposed"][2] = (14.468, 19.9791, 60.7223);
  level.var_85DF["soldier"]["cover_crouch_grenade"]["grenade_safe"] = self[[self.var_7190]]("soldier", "cover_crouch_grenade", "grenade_safe");
  level.var_85E1["soldier"]["cover_crouch_grenade"]["grenade_safe"] = [];
  level.var_85E1["soldier"]["cover_crouch_grenade"]["grenade_safe"][0] = (-3.96449, 8.40924, 48.214);
  level.var_85E1["soldier"]["cover_crouch_grenade"]["grenade_safe"][1] = (-3.96449, 8.40924, 48.214);
  level.var_85E1["soldier"]["cover_crouch_grenade"]["grenade_safe"][2] = (16.2637, 3.38162, 58.6737);
  level.var_85DF["soldier"]["cover_right_grenade"]["grenade_exposed"] = self[[self.var_7190]]("soldier", "cover_right_grenade", "grenade_exposed");
  level.var_85E1["soldier"]["cover_right_grenade"]["grenade_exposed"] = [];
  level.var_85E1["soldier"]["cover_right_grenade"]["grenade_exposed"][0] = (56.0294, 7.45257, 79.3614);
  level.var_85E1["soldier"]["cover_right_grenade"]["grenade_exposed"][1] = (41.56, -28.3555, 72.3737);
  level.var_85E1["soldier"]["cover_right_grenade"]["grenade_exposed"][2] = (37.3503, 13.1342, 34.1788);
  level.var_85DF["soldier"]["cover_right_grenade"]["grenade_safe"] = self[[self.var_7190]]("soldier", "cover_right_grenade", "grenade_safe");
  level.var_85E1["soldier"]["cover_right_grenade"]["grenade_safe"] = [];
  level.var_85E1["soldier"]["cover_right_grenade"]["grenade_safe"][0] = (47.1728, -17.3886, 25.1343);
  level.var_85E1["soldier"]["cover_right_grenade"]["grenade_safe"][1] = (31.7398, -34.8025, 76.2959);
  level.var_85E1["soldier"]["cover_right_grenade"]["grenade_safe"][2] = (37.703, 10.9166, 24.6772);
  level.var_85DF["soldier"]["cover_right_crouch_grenade"]["grenade_exposed"] = self[[self.var_7190]]("soldier", "cover_right_crouch_grenade", "grenade_exposed");
  level.var_85E1["soldier"]["cover_right_crouch_grenade"]["grenade_exposed"] = [];
  level.var_85E1["soldier"]["cover_right_crouch_grenade"]["grenade_exposed"][0] = (1.8289, 24.2055, 36.719);
  level.var_85E1["soldier"]["cover_right_crouch_grenade"]["grenade_exposed"][1] = (33.0665, 3.91717, 15.3247);
  level.var_85DF["soldier"]["cover_right_crouch_grenade"]["grenade_safe"] = self[[self.var_7190]]("soldier", "cover_right_crouch_grenade", "grenade_safe");
  level.var_85E1["soldier"]["cover_right_crouch_grenade"]["grenade_safe"] = [];
  level.var_85E1["soldier"]["cover_right_crouch_grenade"]["grenade_safe"][0] = (-8.86994, 17.8445, 17.8727);
  level.var_85E1["soldier"]["cover_right_crouch_grenade"]["grenade_safe"][1] = (30.3572, 3.9653, 21.9085);
  level.var_85DF["soldier"]["cover_left_grenade"]["grenade_exposed"] = self[[self.var_7190]]("soldier", "cover_left_grenade", "grenade_exposed");
  level.var_85E1["soldier"]["cover_left_grenade"]["grenade_exposed"] = [];
  level.var_85E1["soldier"]["cover_left_grenade"]["grenade_exposed"][0] = (31.1908, -24.4541, 70.8929);
  level.var_85E1["soldier"]["cover_left_grenade"]["grenade_exposed"][1] = (18.5238, 31.0193, 68.1704);
  level.var_85DF["soldier"]["cover_left_grenade"]["grenade_safe"] = self[[self.var_7190]]("soldier", "cover_left_grenade", "grenade_safe");
  level.var_85E1["soldier"]["cover_left_grenade"]["grenade_safe"] = [];
  level.var_85E1["soldier"]["cover_left_grenade"]["grenade_safe"][0] = (-17.6088, -34.2477, 40.1995);
  level.var_85E1["soldier"]["cover_left_grenade"]["grenade_safe"][1] = (14.1129, 35.2797, 29.8152);
  level.var_85DF["soldier"]["cover_left_crouch_grenade"]["grenade_exposed"] = self[[self.var_7190]]("soldier", "cover_left_crouch_grenade", "grenade_exposed");
  level.var_85E1["soldier"]["cover_left_crouch_grenade"]["grenade_exposed"] = [];
  level.var_85E1["soldier"]["cover_left_crouch_grenade"]["grenade_exposed"][0] = (5.58822, 24.4606, 56.0111);
  level.var_85E1["soldier"]["cover_left_crouch_grenade"]["grenade_exposed"][1] = (19.2915, 30.552, 26.9116);
  level.var_85DF["soldier"]["cover_left_crouch_grenade"]["grenade_safe"] = self[[self.var_7190]]("soldier", "cover_left_crouch_grenade", "grenade_safe");
  level.var_85E1["soldier"]["cover_left_crouch_grenade"]["grenade_safe"] = [];
  level.var_85E1["soldier"]["cover_left_crouch_grenade"]["grenade_safe"][0] = (19.2915, 30.552, 26.9116);
  level.var_85DF["soldier"]["exposed_throw_grenade"]["exposed_grenade"] = self[[self.var_7190]]("soldier", "exposed_throw_grenade", "exposed_grenade");
  level.var_85E1["soldier"]["exposed_throw_grenade"]["exposed_grenade"] = [];
  level.var_85E1["soldier"]["exposed_throw_grenade"]["exposed_grenade"][0] = (38.1638, -0.911074, 71.8421);
  level.var_85DF["soldier"]["exposed_prone_throw_grenade"]["exposed_grenade"] = self[[self.var_7190]]("soldier", "exposed_prone_throw_grenade", "exposed_grenade");
  level.var_85E1["soldier"]["exposed_prone_throw_grenade"]["exposed_grenade"] = [];
  level.var_85E1["soldier"]["exposed_prone_throw_grenade"]["exposed_grenade"][0] = (31.8573, 6.47854, 40.1133);
  level.var_85DF["soldier"]["exposed_throw_seeker"]["exposed_seeker_throw"] = self[[self.var_7190]]("soldier", "exposed_throw_seeker", "exposed_seeker_throw");
  level.var_85E1["soldier"]["exposed_throw_seeker"]["exposed_seeker_throw"] = [];
  level.var_85E1["soldier"]["exposed_throw_seeker"]["exposed_seeker_throw"][0] = (23.6411, -21.534, 59.3983);
}

func_100A9(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\asm_bb::bb_getrequestedweapon();
  if(!isDefined(var_4)) {
    return 0;
  }

  if(weaponclass(self.var_394) == var_4) {
    return 0;
  }

  return 1;
}

func_BEA0(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  if(scripts\asm\asm_bb::func_2985()) {
    if(isDefined(self._blackboard.shootparams.pos)) {
      var_4 = self._blackboard.shootparams.pos;
    } else if(isDefined(self._blackboard.shootparams.ent)) {
      var_4 = self._blackboard.shootparams.ent.origin;
    }
  }

  if(!isDefined(var_4) && scripts\engine\utility::func_9DA3()) {
    var_4 = self.isnodeoccupied.origin;
  }

  if(!isDefined(var_4) && isDefined(self.target_getindexoftarget) && self.target_getindexoftarget.type == "Exposed" && distancesquared(self.target_getindexoftarget.origin, self.origin) < 36) {
    var_4 = self.target_getindexoftarget.origin + anglesToForward(self.target_getindexoftarget.angles) * 384;
  }

  if(!isDefined(var_4)) {
    return 0;
  }

  var_5 = self.angles[1] - vectortoyaw(var_4 - self.origin);
  var_6 = distancesquared(self.origin, var_4);
  if(var_6 < 65536) {
    var_7 = sqrt(var_6);
    if(var_7 > 3) {
      var_5 = var_5 + asin(-3 / var_7);
    }
  }

  return abs(angleclamp180(var_5)) > self.var_129AF;
}

func_BE9F(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::istrue(self.var_B3E9) && isDefined(self.target_getindexoftarget)) {
    return 0;
  }

  var_4 = _meth_81DD();
  if(abs(var_4) > self.var_129AF) {
    return 1;
  }

  var_5 = laststandrevive();
  if(abs(var_5) > self.var_CBF8) {
    return 1;
  }

  return 0;
}

_meth_81DE() {
  var_0 = 0.25;
  var_1 = undefined;
  var_2 = undefined;
  if(scripts\asm\asm_bb::func_2985()) {
    if(isDefined(self._blackboard.shootparams.ent)) {
      var_1 = self._blackboard.shootparams.ent;
    } else if(isDefined(self._blackboard.shootparams.pos)) {
      var_2 = self._blackboard.shootparams.pos;
    }
  } else if(isDefined(self.isnodeoccupied) && scripts\engine\utility::func_9DA3()) {
    var_1 = self.isnodeoccupied;
  }

  if(isDefined(var_1) && !issentient(var_1)) {
    var_0 = 1.5;
  }

  var_3 = scripts\engine\utility::getpredictedaimyawtoshootentorpos(var_0, var_1, var_2);
  return var_3;
}

_meth_81DD() {
  var_0 = 0.25;
  var_1 = undefined;
  var_2 = undefined;
  if(scripts\asm\asm_bb::func_2985()) {
    if(isDefined(self._blackboard.shootparams.ent)) {
      var_1 = self._blackboard.shootparams.ent;
    } else if(isDefined(self._blackboard.shootparams.pos)) {
      var_2 = self._blackboard.shootparams.pos;
    }
  } else if(isDefined(self.isnodeoccupied)) {
    var_1 = self.isnodeoccupied;
  }

  if(isDefined(var_1) && !issentient(var_1)) {
    var_0 = 1.5;
  }

  var_3 = scripts\engine\utility::getpredictedaimyawtoshootentorpos3d(var_0, var_1, var_2);
  return var_3;
}

laststandrevive() {
  var_0 = 0.25;
  var_1 = undefined;
  var_2 = undefined;
  if(scripts\asm\asm_bb::func_2985()) {
    if(isDefined(self._blackboard.shootparams.ent)) {
      var_1 = self._blackboard.shootparams.ent;
    } else if(isDefined(self._blackboard.shootparams.pos)) {
      var_2 = self._blackboard.shootparams.pos;
    }
  } else if(isDefined(self.isnodeoccupied)) {
    var_1 = self.isnodeoccupied;
  }

  if(isDefined(var_1) && !issentient(var_1)) {
    var_0 = 1.5;
  }

  var_3 = scripts\engine\utility::getpredictedaimpitchtoshootentorpos3d(var_0, var_1, var_2);
  return var_3;
}

func_3F0A(var_0, var_1, var_2) {
  var_3 = _meth_81DE();
  if(var_3 < 0) {
    var_4 = "right";
  } else {
    var_4 = "left";
  }

  var_3 = abs(var_3);
  var_5 = 0;
  if(var_3 > 157.5) {
    var_5 = 180;
  } else if(var_3 > 112.5) {
    var_5 = 135;
  } else if(var_3 > 67.5) {
    var_5 = 90;
  } else {
    var_5 = 45;
  }

  var_6 = var_4 + "_" + var_5;
  var_7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_6);
  return var_7;
}

func_3F09(var_0, var_1, var_2) {
  var_3 = _meth_81DD();
  var_4 = laststandrevive();
  if(abs(var_3) > self.var_129AF && abs(var_3) > abs(var_4)) {
    if(var_3 < 0) {
      var_5 = "right";
    } else {
      var_5 = "left";
    }

    var_3 = abs(var_3);
    var_6 = 0;
    if(var_3 > 157.5) {
      var_6 = 180;
    } else if(var_3 > 112.5) {
      var_6 = 135;
    } else if(var_3 > 67.5) {
      var_6 = 90;
    } else {
      var_6 = 45;
    }

    var_7 = var_5 + "_" + var_6;
    var_8 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_7);
    return var_8;
  }

  if(var_8 < 0) {
    var_5 = "up";
  } else {
    var_5 = "down";
  }

  var_7 = abs(var_7);
  var_6 = 0;
  if(var_6 > 157.5) {
    var_8 = 180;
  } else if(var_6 > 112.5) {
    var_8 = 135;
  } else if(var_6 > 67.5) {
    var_8 = 90;
  } else {
    var_8 = 45;
  }

  var_7 = var_7 + "_" + var_8;
  var_8 = scripts\asm\asm::asm_lookupanimfromalias(var_2, var_8);
  return var_8;
}

func_DF5B(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_reloadrequested();
}

func_2B9A(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::func_291A();
}

func_3ECC(var_0, var_1, var_2) {
  var_3 = _meth_81DE();
  if(var_3 < -135) {
    var_4 = "2r";
  } else if(var_4 > 135) {
    var_4 = "2l";
  } else if(var_4 < 0) {
    var_4 = "6";
  } else {
    var_4 = "4";
  }

  var_5 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_4);
  return var_5;
}

func_DF4F(var_0, var_1, var_2) {
  if(!isDefined(self.var_39B) || !isDefined(self.var_39B[self.var_394])) {
    return;
  }

  if(!scripts\asm\asm::func_232B(var_1, "drop clip")) {
    return;
  }

  if(self.var_39B[self.var_394].var_13053) {
    var_3 = getweaponclipmodel(self.var_394);
    if(isDefined(var_3)) {
      var_4 = scripts\asm\asm::func_232B(var_1, "attach clip left") || scripts\asm\asm::func_232B(var_1, "attach clip right");
      var_5 = scripts\asm\asm::func_232B(var_1, "detach clip left") || scripts\asm\asm::func_232B(var_1, "detach clip right") || scripts\asm\asm::func_232B(var_1, "detach clip nohand");
      if(!var_4) {
        self notify("abort_reload");
        return;
      }

      if(var_4 && !var_5) {
        if(scripts\asm\asm::func_232B(var_1, "attach clip left")) {
          var_6 = "tag_accessory_left";
        } else {
          var_6 = "tag_accessory_right";
        }

        self detach(var_3, var_6);
        self giveperk("tag_clip");
        self notify("clip_detached");
        self.var_39B[self.var_394].var_8BDE = 1;
        return;
      }

      return;
    }
  }
}