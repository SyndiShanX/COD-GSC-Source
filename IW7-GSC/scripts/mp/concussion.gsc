/*************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\concussion.gsc
*************************************/

func_44EE(param_00) {
  param_00 thread func_13A20();
}

func_13A20() {
  var_00 = scripts\engine\utility::spawn_tag_origin();
  var_00 linkto(self);
  self.killcament = var_00;
  thread func_A639(var_00);
  thread scripts\mp\utility::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  var_01 = self.triggerportableradarping;
  self waittill("explode", var_02);
  thread func_0118(var_02, 512, var_01, var_00);
}

func_0118(param_00, param_01, param_02, param_03) {
  var_04 = scripts\mp\weapons::getempdamageents(param_00, param_01, 0);
  foreach(var_06 in var_04) {
    if(!isDefined(var_06)) {
      continue;
    }

    var_07 = scripts\engine\utility::ter_op(isDefined(var_06.triggerportableradarping), var_06.triggerportableradarping, var_06);
    if(!scripts\mp\weapons::friendlyfirecheck(param_02, var_07) && var_07 != param_02) {
      continue;
    }

    var_06 notify("emp_damage", param_02, 3, param_00, "emp_grenade_mp", "MOD_EXPLOSIVE");
    param_02 scripts\mp\damage::combatrecordtacticalstat("power_concussionGrenade");
  }
}

onweapondamage(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_00)) {
    return;
  } else if(param_02 == "MOD_IMPACT") {
    return;
  }

  func_20BF(param_00, param_04);
  func_20C3(param_00, param_04);
  param_04 scripts\mp\damage::combatrecordtacticalstat("power_concussionGrenade");
}

func_20BF(param_00, param_01) {
  var_02 = 2;
  var_03 = 4;
  if(self == param_01) {
    var_02 = 0.75;
    var_03 = 1.5;
  }

  var_04 = 1 - distance(self.origin, param_00.origin) / 512;
  if(var_04 < 0) {
    var_04 = 0;
  }

  var_05 = var_02 + var_03 * var_04;
  var_05 = scripts\mp\perks\_perkfunctions::applystunresistence(param_01, self, var_05);
  thread scripts\mp\gamescore::func_11ACF(param_01, self, "concussion_grenade_mp", var_05);
  param_01 notify("stun_hit");
  self notify("concussed", param_01);
  scripts\mp\weapons::func_F7FC();
  thread scripts\mp\weapons::func_40EA(var_05);
  self shellshock("concussion_grenade_mp", var_05);
  self.concussionendtime = gettime() + var_05 * 1000;
}

func_20C3(param_00, param_01) {
  if(!scripts\mp\killstreaks\_emp_common::func_FFC5()) {
    if(param_01 != self) {
      param_01 scripts\mp\damagefeedback::updatedamagefeedback("hiticonempimmune", undefined, undefined, undefined, 1);
    }

    return;
  }

  var_02 = 3;
  if(self == param_01) {
    var_02 = 1;
  }

  scripts\mp\killstreaks\_emp_common::func_20C7(var_02);
  thread scripts\mp\gamescore::func_11ACF(param_01, self, "emp_grenade_mp", var_02);
}

func_A639(param_00) {
  param_00 endon("death");
  self waittill("death");
  wait(5);
  param_00 delete();
}

func_B92C(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_03) || !isDefined(param_04) || !isDefined(param_01) || !isDefined(param_02)) {
    return param_00;
  }

  if(param_04 != "concussion_grenade_mp" && param_04 != "emp_grenade_mp") {
    return param_00;
  }

  if(param_01 != param_02) {
    return param_00;
  }

  if(distancesquared(param_02.origin, param_03.origin) <= 65536) {
    return param_00;
  }

  return 0;
}