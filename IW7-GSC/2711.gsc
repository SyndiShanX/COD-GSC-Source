/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2711.gsc
***************************************/

func_44EE(var_00) {
  var_00 thread func_13A20();
}

func_13A20() {
  var_00 = scripts\engine\utility::spawn_tag_origin();
  var_00 linkto(self);
  self.killcament = var_00;
  thread func_A639(var_00);
  thread scripts\mp\utility\game::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  var_01 = self.owner;
  self waittill("explode", var_02);
  thread func_0118(var_02, 512, var_01, var_00);
}

func_0118(var_00, var_01, var_02, var_03) {
  var_04 = scripts\mp\weapons::getempdamageents(var_00, var_01, 0);

  foreach(var_06 in var_04) {
    if(!isDefined(var_06)) {
      continue;
    }
    var_07 = scripts\engine\utility::ter_op(isDefined(var_6.owner), var_6.owner, var_06);

    if(!scripts\mp\weapons::friendlyfirecheck(var_02, var_07) && var_07 != var_02) {
      continue;
    }
    var_06 notify("emp_damage", var_02, 3, var_00, "emp_grenade_mp", "MOD_EXPLOSIVE");
    var_02 scripts\mp\damage::combatrecordtacticalstat("power_concussionGrenade");
  }
}

onweapondamage(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(var_00)) {
    return;
  }
  else if(var_02 == "MOD_IMPACT") {
    return;
  }
  func_20BF(var_00, var_04);
  func_20C3(var_00, var_04);
  var_04 scripts\mp\damage::combatrecordtacticalstat("power_concussionGrenade");
}

func_20BF(var_00, var_01) {
  var_02 = 2;
  var_03 = 4;

  if(self == var_01) {
    var_02 = 0.75;
    var_03 = 1.5;
  }

  var_04 = 1 - distance(self.origin, var_0.origin) / 512;

  if(var_04 < 0) {
    var_04 = 0;
  }

  var_05 = var_02 + var_03 * var_04;
  var_05 = scripts\mp\perks\perkfunctions::applystunresistence(var_01, self, var_05);
  thread scripts\mp\gamescore::func_11ACF(var_01, self, "concussion_grenade_mp", var_05);
  var_01 notify("stun_hit");
  self notify("concussed", var_01);
  scripts\mp\weapons::func_F7FC();
  thread scripts\mp\weapons::func_40EA(var_05);
  self shellshock("concussion_grenade_mp", var_05);
  self.concussionendtime = gettime() + var_05 * 1000;
}

func_20C3(var_00, var_01) {
  if(!scripts\mp\killstreaks\emp_common::func_FFC5()) {
    if(var_01 != self) {
      var_01 scripts\mp\damagefeedback::updatedamagefeedback("hiticonempimmune", undefined, undefined, undefined, 1);
    }

    return;
  }

  var_02 = 3;

  if(self == var_01) {
    var_02 = 1;
  }

  scripts\mp\killstreaks\emp_common::func_20C7(var_02);
  thread scripts\mp\gamescore::func_11ACF(var_01, self, "emp_grenade_mp", var_02);
}

func_A639(var_00) {
  var_00 endon("death");
  self waittill("death");
  wait 5;
  var_00 delete();
}

func_B92C(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(var_03) || !isDefined(var_04) || !isDefined(var_01) || !isDefined(var_02)) {
    return var_00;
  }

  if(var_04 != "concussion_grenade_mp" && var_04 != "emp_grenade_mp") {
    return var_00;
  }

  if(var_01 != var_02) {
    return var_00;
  }

  if(distancesquared(var_2.origin, var_3.origin) <= 65536) {
    return var_00;
  }

  return 0;
}