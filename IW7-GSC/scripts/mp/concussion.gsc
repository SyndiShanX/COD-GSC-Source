/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\concussion.gsc
*********************************************/

func_44EE(var_0) {
  var_0 thread func_13A20();
}

func_13A20() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 linkto(self);
  self.killcament = var_0;
  thread func_A639(var_0);
  thread scripts\mp\utility::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  var_1 = self.owner;
  self waittill("explode", var_2);
  thread func_0118(var_2, 512, var_1, var_0);
}

func_0118(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\weapons::getempdamageents(var_0, var_1, 0);
  foreach(var_6 in var_4) {
    if(!isDefined(var_6)) {
      continue;
    }

    var_7 = scripts\engine\utility::ter_op(isDefined(var_6.owner), var_6.owner, var_6);
    if(!scripts\mp\weapons::friendlyfirecheck(var_2, var_7) && var_7 != var_2) {
      continue;
    }

    var_6 notify("emp_damage", var_2, 3, var_0, "emp_grenade_mp", "MOD_EXPLOSIVE");
    var_2 scripts\mp\damage::combatrecordtacticalstat("power_concussionGrenade");
  }
}

onweapondamage(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    return;
  } else if(var_2 == "MOD_IMPACT") {
    return;
  }

  func_20BF(var_0, var_4);
  func_20C3(var_0, var_4);
  var_4 scripts\mp\damage::combatrecordtacticalstat("power_concussionGrenade");
}

func_20BF(var_0, var_1) {
  var_2 = 2;
  var_3 = 4;
  if(self == var_1) {
    var_2 = 0.75;
    var_3 = 1.5;
  }

  var_4 = 1 - distance(self.origin, var_0.origin) / 512;
  if(var_4 < 0) {
    var_4 = 0;
  }

  var_5 = var_2 + var_3 * var_4;
  var_5 = scripts\mp\perks\perkfunctions::applystunresistence(var_1, self, var_5);
  thread scripts\mp\gamescore::func_11ACF(var_1, self, "concussion_grenade_mp", var_5);
  var_1 notify("stun_hit");
  self notify("concussed", var_1);
  scripts\mp\weapons::func_F7FC();
  thread scripts\mp\weapons::func_40EA(var_5);
  self shellshock("concussion_grenade_mp", var_5);
  self.concussionendtime = gettime() + var_5 * 1000;
}

func_20C3(var_0, var_1) {
  if(!scripts\mp\killstreaks\emp_common::func_FFC5()) {
    if(var_1 != self) {
      var_1 scripts\mp\damagefeedback::updatedamagefeedback("hiticonempimmune", undefined, undefined, undefined, 1);
    }

    return;
  }

  var_2 = 3;
  if(self == var_1) {
    var_2 = 1;
  }

  scripts\mp\killstreaks\emp_common::func_20C7(var_2);
  thread scripts\mp\gamescore::func_11ACF(var_1, self, "emp_grenade_mp", var_2);
}

func_A639(var_0) {
  var_0 endon("death");
  self waittill("death");
  wait(5);
  var_0 delete();
}

func_B92C(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3) || !isDefined(var_4) || !isDefined(var_1) || !isDefined(var_2)) {
    return var_0;
  }

  if(var_4 != "concussion_grenade_mp" && var_4 != "emp_grenade_mp") {
    return var_0;
  }

  if(var_1 != var_2) {
    return var_0;
  }

  if(distancesquared(var_2.origin, var_3.origin) <= 65536) {
    return var_0;
  }

  return 0;
}