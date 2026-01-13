/****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\emp_debuff_mp.gsc
****************************************/

func_13A12() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 linkto(self);
  self.killcament = var_0;
  thread func_A639(var_0);
  thread scripts\mp\utility::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  var_1 = self.triggerportableradarping;
  self waittill("explode", var_2);
  thread func_0118(var_2, 256, var_1, var_0);
}

onweapondamage(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    return;
  } else if(var_2 == "MOD_IMPACT") {
    return;
  }

  if(issubstr(self.weapon_name, "iw7_tacburst_mpl")) {
    func_20BF(var_0, var_4);
  }

  func_20C3(var_0, var_4, var_1);
}

func_0118(var_0, var_1, var_2, var_3) {
  var_4 = "gltacburst";
  if(issubstr(self.weapon_name, "iw7_tacburst_mpl")) {
    var_4 = "gltacburst_big";
  } else if(issubstr(self.weapon_name, "iw7_tacburst_mpl_epic2")) {
    var_4 = "gltacburst_regen";
  }

  var_5 = scripts\mp\weapons::getempdamageents(var_0, var_1, 0);
  foreach(var_7 in var_5) {
    if(!isDefined(var_7)) {
      continue;
    }

    if(!scripts\mp\equipment\phase_shift::areentitiesinphase(self, var_7)) {
      continue;
    }

    var_8 = scripts\engine\utility::ter_op(isDefined(var_7.triggerportableradarping), var_7.triggerportableradarping, var_7);
    if(!scripts\mp\weapons::friendlyfirecheck(var_2, var_8) && var_8 != var_2) {
      continue;
    }

    var_7 notify("emp_damage", var_2, 3, var_0, var_4, "MOD_EXPLOSIVE");
  }

  var_0A = scripts\mp\utility::clearscrambler(var_0, var_1);
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

    if(var_0C != var_2 && scripts\mp\utility::func_9E05(var_2.team, var_0C)) {
      continue;
    }

    if(!var_0C scripts\mp\killstreaks\_emp_common::func_FFC5()) {
      var_2 scripts\mp\damagefeedback::updatedamagefeedback("hiticonempimmune", undefined, undefined, undefined, 1);
      continue;
    }

    if(scripts\mp\utility::istrue(var_0C.var_9F72)) {
      continue;
    }

    var_0C dodamage(1, var_2.origin, var_2, var_3, "MOD_EXPLOSIVE", var_4);
    var_0C scripts\mp\killstreaks\_emp_common::func_20C7(3);
    if(var_4 == "gltacburst_big") {
      var_0C func_20BF(self, var_2);
    }

    thread scripts\mp\gamescore::func_11ACF(var_2, var_0C, var_4, 3);
  }
}

func_20C3(var_0, var_1, var_2) {
  if(!scripts\mp\killstreaks\_emp_common::func_FFC5()) {
    if(var_1 != self) {
      var_1 scripts\mp\damagefeedback::updatedamagefeedback("hiticonempimmune", undefined, undefined, undefined, 1);
    }

    return;
  }

  var_3 = 3;
  if(self == var_1) {
    var_3 = 1;
  }

  scripts\mp\killstreaks\_emp_common::func_20C7(var_3);
  thread scripts\mp\gamescore::func_11ACF(var_1, self, scripts\engine\utility::ter_op(issubstr(var_2, "iw7_tacburst_mpl"), "gltacburst_big", "gltacburst"), var_3);
}

func_20BF(var_0, var_1) {
  var_2 = 2;
  var_3 = 4;
  if(self == var_1) {
    var_2 = 0.75;
    var_3 = 1.5;
  }

  var_4 = 1 - distance(self.origin, var_0.origin) / 256;
  if(var_4 < 0) {
    var_4 = 0;
  }

  var_5 = var_2 + var_3 * var_4;
  var_5 = scripts\mp\perks\_perkfunctions::applystunresistence(var_1, self, var_5);
  thread scripts\mp\gamescore::func_11ACF(var_1, self, "gltacburst_big", var_5);
  var_1 notify("stun_hit");
  self notify("concussed", var_1);
  scripts\mp\weapons::func_F7FC();
  thread scripts\mp\weapons::func_40EA(var_5);
  self shellshock("concussion_grenade_mp", var_5);
  self.concussionendtime = gettime() + var_5 * 1000;
}

empsitewatcher(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("emp_rumble_loop");
  self notify("emp_rumble_loop");
  var_1 = gettime() + var_0 * 1000;
  while(gettime() < var_1) {
    self playrumbleonentity("damage_light");
    wait(0.05);
  }
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

  if(var_4 != "gltacburst") {
    return var_0;
  }

  if(var_1 != var_2) {
    return var_0;
  }

  if(distancesquared(var_2.origin, var_3.origin) <= 16384) {
    return var_0;
  }

  return 0;
}