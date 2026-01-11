/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2724.gsc
***************************************/

func_13A12() {
  var_00 = scripts\engine\utility::spawn_tag_origin();
  var_00 linkto(self);
  self.killcament = var_00;
  thread func_A639(var_00);
  thread scripts\mp\utility\game::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  var_01 = self.owner;
  self waittill("explode", var_02);
  thread func_0118(var_02, 256, var_01, var_00);
}

onweapondamage(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(var_00)) {
    return;
  }
  else if(var_02 == "MOD_IMPACT") {
    return;
  }
  if(issubstr(self.weapon_name, "iw7_tacburst_mpl")) {
    func_20BF(var_00, var_04);
  }

  func_20C3(var_00, var_04, var_01);
}

func_0118(var_00, var_01, var_02, var_03) {
  var_04 = "gltacburst";

  if(issubstr(self.weapon_name, "iw7_tacburst_mpl")) {
    var_04 = "gltacburst_big";
  }

  var_05 = scripts\mp\weapons::getempdamageents(var_00, var_01, 0);

  foreach(var_07 in var_05) {
    if(!isDefined(var_07)) {
      continue;
    }
    var_08 = scripts\engine\utility::ter_op(isDefined(var_7.owner), var_7.owner, var_07);

    if(!scripts\mp\weapons::friendlyfirecheck(var_02, var_08) && var_08 != var_02) {
      continue;
    }
    var_07 notify("emp_damage", var_02, 3, var_00, var_04, "MOD_EXPLOSIVE");
  }

  var_10 = scripts\mp\utility\game::clearscrambler(var_00, var_01);

  foreach(var_12 in var_10) {
    if(!isDefined(var_12)) {
      continue;
    }
    if(!scripts\mp\utility\game::isreallyalive(var_12)) {
      continue;
    }
    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_12)) {
      continue;
    }
    if(var_12 != var_02 && scripts\mp\utility\game::func_9E05(var_2.team, var_12)) {
      continue;
    }
    if(!var_12 scripts\mp\killstreaks\emp_common::func_FFC5()) {
      continue;
    }
    var_12 getrandomarmkillstreak(1, var_2.origin, var_02, var_03, "MOD_EXPLOSIVE", var_04);
    var_12 scripts\mp\killstreaks\emp_common::func_20C7(3);

    if(var_04 == "gltacburst_big") {
      var_12 func_20BF(self, var_02);
    }

    thread scripts\mp\gamescore::func_11ACF(var_02, var_12, var_04, 3);
  }
}

func_20C3(var_00, var_01, var_02) {
  if(!scripts\mp\killstreaks\emp_common::func_FFC5()) {
    if(var_01 != self) {
      var_01 scripts\mp\damagefeedback::updatedamagefeedback("hiticonempimmune", undefined, undefined, undefined, 1);
    }

    return;
  }

  var_03 = 3;

  if(self == var_01) {
    var_03 = 1;
  }

  scripts\mp\killstreaks\emp_common::func_20C7(var_03);
  thread scripts\mp\gamescore::func_11ACF(var_01, self, scripts\engine\utility::ter_op(issubstr(var_02, "iw7_tacburst_mpl"), "gltacburst_big", "gltacburst"), var_03);
}

func_20BF(var_00, var_01) {
  var_02 = 2;
  var_03 = 4;

  if(self == var_01) {
    var_02 = 0.75;
    var_03 = 1.5;
  }

  var_04 = 1 - distance(self.origin, var_0.origin) / 256;

  if(var_04 < 0) {
    var_04 = 0;
  }

  var_05 = var_02 + var_03 * var_04;
  var_05 = scripts\mp\perks\perkfunctions::applystunresistence(var_01, self, var_05);
  thread scripts\mp\gamescore::func_11ACF(var_01, self, "gltacburst_big", var_05);
  var_01 notify("stun_hit");
  self notify("concussed", var_01);
  scripts\mp\weapons::func_F7FC();
  thread scripts\mp\weapons::func_40EA(var_05);
  self shellshock("concussion_grenade_mp", var_05);
  self.concussionendtime = gettime() + var_05 * 1000;
}

empsitewatcher(var_00) {
  self endon("death");
  self endon("disconnect");
  self endon("emp_rumble_loop");
  self notify("emp_rumble_loop");
  var_01 = gettime() + var_00 * 1000;

  while(gettime() < var_01) {
    self playrumbleonentity("damage_light");
    wait 0.05;
  }
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

  if(var_04 != "gltacburst") {
    return var_00;
  }

  if(var_01 != var_02) {
    return var_00;
  }

  if(distancesquared(var_2.origin, var_3.origin) <= 16384) {
    return var_00;
  }

  return 0;
}