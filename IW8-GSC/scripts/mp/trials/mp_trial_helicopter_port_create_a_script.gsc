/**************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\mp_trial_helicopter_port_create_a_script.gsc
**************************************************************************/

function ref_1348D(var_0, var_1, var_2) {
  var_3 = scripts\asm\soldier\pain::getpaindirectiontoactor();
  var_4 = "torso";
  var_5 = "midbody";
  var_6 = [];

  if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck")) {
    var_4 = "head";
    var_5 = "head";
    GscBinSkip0(0x2e, var_6.size, scripts\asm\asm::asm_lookupanimfromalias(var_1, "head" + var_3));
  }

  if(scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower", "right_hand")) {
    var_4 = "rarm";
    var_5 = "midbody";
    GscBinSkip0(0x2e, var_6.size, scripts\asm\asm::asm_lookupanimfromalias(var_1, "rarm" + var_3));
  }

  if(scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower", "left_hand")) {
    var_4 = "larm";
    var_5 = "midbody";
    GscBinSkip0(0x2e, var_6.size, scripts\asm\asm::asm_lookupanimfromalias(var_1, "larm" + var_3));
  }

  if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot")) {
    var_4 = "lleg";
    var_5 = "lowerbody";
    GscBinSkip0(0x2e, var_6.size, scripts\asm\asm::asm_lookupanimfromalias(var_1, "lleg" + var_3));
  }

  if(scripts\engine\utility::damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot")) {
    var_4 = "rleg";
    var_5 = "lowerbody";
    GscBinSkip0(0x2e, var_6.size, scripts\asm\asm::asm_lookupanimfromalias(var_1, "rleg" + var_3));
  }

  var_4 = "torso";
  var_5 = "midbody";
  GscBinSkip0(0x2e, var_6.size, scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso" + var_3));
}

function ref_1348F(var_0, var_1, var_2) {
  var_3 = 30;
  var_4 = 150;
  var_5 = 300;
  var_6 = [];
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = navtrace(self.origin, self localtoworldcoords((var_5, 0, 0)), self, 1);

  if(var_10["fraction"] > 0.9) {
    var_8 = 1;
  }

  if(var_10["fraction"] > 0.9 * var_4 / var_5) {
    var_7 = 1;
  }

  if(isDefined(self.a.disablelongpain)) {
    var_8 = 0;
    var_7 = 0;
  }

  var_11 = length(self.velocity);
  var_12 = scripts\asm\shared\utility::getbasearchetype();
  var_13 = scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349E();

  if(var_8) {
    var_14 = "long" + var_13;
    var_6 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_14);
  } else if(var_7) {
    var_14 = "medium" + var_13;
    var_6 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_14);
  } else if(var_10["fraction"] > 0.9 * var_3 / var_5) {
    var_14 = "short" + var_13;
    var_6 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_14);
  }

  if(var_6.size == 0) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "emergency_backup");
  }

  return var_6[randomint(var_6.size)];
}