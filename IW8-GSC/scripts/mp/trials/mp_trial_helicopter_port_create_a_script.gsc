/**************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\mp_trial_helicopter_port_create_a_script.gsc
**************************************************************************/

function ref_1348d(var0, var1, var2) {
  var3 = scripts\asm\soldier\pain::getpaindirectiontoactor();
  var4 = "torso";
  var5 = "midbody";
  var6 = [];

  if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck")) {
    var4 = "head";
    var5 = "head";
    GscBinSkip0(0x2e, var6.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "head" + var3));
  }

  if(scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower", "right_hand")) {
    var4 = "rarm";
    var5 = "midbody";
    GscBinSkip0(0x2e, var6.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "rarm" + var3));
  }

  if(scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower", "left_hand")) {
    var4 = "larm";
    var5 = "midbody";
    GscBinSkip0(0x2e, var6.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "larm" + var3));
  }

  if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot")) {
    var4 = "lleg";
    var5 = "lowerbody";
    GscBinSkip0(0x2e, var6.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "lleg" + var3));
  }

  if(scripts\engine\utility::damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot")) {
    var4 = "rleg";
    var5 = "lowerbody";
    GscBinSkip0(0x2e, var6.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "rleg" + var3));
  }

  var4 = "torso";
  var5 = "midbody";
  GscBinSkip0(0x2e, var6.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "torso" + var3));
}

function ref_1348f(var0, var1, var2) {
  var3 = 30;
  var4 = 150;
  var5 = 300;
  var6 = [];
  var7 = 0;
  var8 = 0;
  var9 = 0;
  var10 = navtrace(self.origin, self localtoworldcoords((var5, 0, 0)), self, 1);

  if(var10["fraction"] > 0.9) {
    var8 = 1;
  }

  if(var10["fraction"] > 0.9 * var4 / var5) {
    var7 = 1;
  }

  if(isDefined(self.a.disablelongpain)) {
    var8 = 0;
    var7 = 0;
  }

  var11 = length(self.velocity);
  var12 = scripts\asm\shared\utility::getbasearchetype();
  var13 = scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349e();

  if(var8) {
    var14 = "long" + var13;
    var6 = scripts\asm\asm::asm_lookupanimfromalias(var1, var14);
  } else if(var7) {
    var14 = "medium" + var13;
    var6 = scripts\asm\asm::asm_lookupanimfromalias(var1, var14);
  } else if(var10["fraction"] > 0.9 * var3 / var5) {
    var14 = "short" + var13;
    var6 = scripts\asm\asm::asm_lookupanimfromalias(var1, var14);
  }

  if(var6.size == 0) {
    return scripts\asm\asm::asm_lookupanimfromalias(var1, "emergency_backup");
  }

  return var6[randomint(var6.size)];
}