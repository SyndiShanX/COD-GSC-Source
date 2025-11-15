/****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\emp_debuff_mp.gsc
****************************************/

func_13A12() {
  var_00 = scripts\engine\utility::spawn_tag_origin();
  var_00 linkto(self);
  self.killcament = var_00;
  thread func_A639(var_00);
  thread scripts\mp\utility::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  var_01 = self.triggerportableradarping;
  self waittill("explode", var_02);
  thread func_0118(var_02, 256, var_01, var_00);
}

onweapondamage(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_00)) {
    return;
  } else if(param_02 == "MOD_IMPACT") {
    return;
  }

  if(issubstr(self.weapon_name, "iw7_tacburst_mpl")) {
    func_20BF(param_00, param_04);
  }

  func_20C3(param_00, param_04, param_01);
}

func_0118(param_00, param_01, param_02, param_03) {
  var_04 = "gltacburst";
  if(issubstr(self.weapon_name, "iw7_tacburst_mpl")) {
    var_04 = "gltacburst_big";
  } else if(issubstr(self.weapon_name, "iw7_tacburst_mpl_epic2")) {
    var_04 = "gltacburst_regen";
  }

  var_05 = scripts\mp\weapons::getempdamageents(param_00, param_01, 0);
  foreach(var_07 in var_05) {
    if(!isDefined(var_07)) {
      continue;
    }

    if(!scripts\mp\equipment\phase_shift::areentitiesinphase(self, var_07)) {
      continue;
    }

    var_08 = scripts\engine\utility::ter_op(isDefined(var_07.triggerportableradarping), var_07.triggerportableradarping, var_07);
    if(!scripts\mp\weapons::friendlyfirecheck(param_02, var_08) && var_08 != param_02) {
      continue;
    }

    var_07 notify("emp_damage", param_02, 3, param_00, var_04, "MOD_EXPLOSIVE");
  }

  var_0A = scripts\mp\utility::clearscrambler(param_00, param_01);
  foreach(var_0C in var_0A) {
    if(!isDefined(var_0C)) {
      continue;
    }

    if(!scripts\mp\utility::isreallyalive(var_0C)) {
      continue;
    }

    if(!scripts\mp\equipment\phase_shift::areentitiesinphase(var_0C, self)) {
      continue;
    }

    if(var_0C != param_02 && scripts\mp\utility::func_9E05(param_02.team, var_0C)) {
      continue;
    }

    if(!var_0C scripts\mp\killstreaks\_emp_common::func_FFC5()) {
      param_02 scripts\mp\damagefeedback::updatedamagefeedback("hiticonempimmune", undefined, undefined, undefined, 1);
      continue;
    }

    if(scripts\mp\utility::istrue(var_0C.var_9F72)) {
      continue;
    }

    var_0C dodamage(1, param_02.origin, param_02, param_03, "MOD_EXPLOSIVE", var_04);
    var_0C scripts\mp\killstreaks\_emp_common::func_20C7(3);
    if(var_04 == "gltacburst_big") {
      var_0C func_20BF(self, param_02);
    }

    thread scripts\mp\gamescore::func_11ACF(param_02, var_0C, var_04, 3);
  }
}

func_20C3(param_00, param_01, param_02) {
  if(!scripts\mp\killstreaks\_emp_common::func_FFC5()) {
    if(param_01 != self) {
      param_01 scripts\mp\damagefeedback::updatedamagefeedback("hiticonempimmune", undefined, undefined, undefined, 1);
    }

    return;
  }

  var_03 = 3;
  if(self == param_01) {
    var_03 = 1;
  }

  scripts\mp\killstreaks\_emp_common::func_20C7(var_03);
  thread scripts\mp\gamescore::func_11ACF(param_01, self, scripts\engine\utility::ter_op(issubstr(param_02, "iw7_tacburst_mpl"), "gltacburst_big", "gltacburst"), var_03);
}

func_20BF(param_00, param_01) {
  var_02 = 2;
  var_03 = 4;
  if(self == param_01) {
    var_02 = 0.75;
    var_03 = 1.5;
  }

  var_04 = 1 - distance(self.origin, param_00.origin) / 256;
  if(var_04 < 0) {
    var_04 = 0;
  }

  var_05 = var_02 + var_03 * var_04;
  var_05 = scripts\mp\perks\_perkfunctions::applystunresistence(param_01, self, var_05);
  thread scripts\mp\gamescore::func_11ACF(param_01, self, "gltacburst_big", var_05);
  param_01 notify("stun_hit");
  self notify("concussed", param_01);
  scripts\mp\weapons::func_F7FC();
  thread scripts\mp\weapons::func_40EA(var_05);
  self shellshock("concussion_grenade_mp", var_05);
  self.concussionendtime = gettime() + var_05 * 1000;
}

empsitewatcher(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("emp_rumble_loop");
  self notify("emp_rumble_loop");
  var_01 = gettime() + param_00 * 1000;
  while(gettime() < var_01) {
    self playrumbleonentity("damage_light");
    wait(0.05);
  }
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

  if(param_04 != "gltacburst") {
    return param_00;
  }

  if(param_01 != param_02) {
    return param_00;
  }

  if(distancesquared(param_02.origin, param_03.origin) <= 16384) {
    return param_00;
  }

  return 0;
}