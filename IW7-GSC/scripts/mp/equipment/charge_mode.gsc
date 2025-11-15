/************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\equipment\charge_mode.gsc
************************************************/

func_3CED() {
  level._effect["chargemode_expl"] = loadfx("vfx\iw7\_requests\mp\super\vfx_chargemode_expl.vfx");
}

func_3D0E() {}

func_3D19() {
  self notify("chargeMode_unset");
  if(self _meth_84CA()) {
    func_3CDD();
  }
}

func_3D1A() {
  self.chargemode_epicimpactents = [];
  scripts\mp\utility::_enablecollisionnotifies(1);
  scripts\engine\utility::allow_usability(0);
  scripts\mp\utility::blockperkfunction("specialty_lightweight");
  scripts\mp\utility::giveperk("specialty_stun_resistance");
  var_00 = self getcurrentweapon();
  if(issubstr(var_00, "iw7_nunchucks") || issubstr(var_00, "iw7_katana")) {
    if(!self.loadoutprimary == "iw7_fists" || self.loadoutsecondary == "iw7_fists") {
      scripts\mp\utility::_giveweapon("iw7_fists_mp");
    }

    scripts\mp\utility::_switchtoweaponimmediate("iw7_fists_mp");
    self.savedbullchargeweapon = var_00;
  }

  func_3CD3();
  thread func_3CF7();
  thread chargemode_monitorkillstreakusage();
  thread chargemode_monitorshield();
  thread chargemode_monitorarmor();
  thread func_3CFA();
  thread func_3D04();
  thread func_3CFB();
  thread func_3D02();
  thread func_3CF9();
  if(!scripts\mp\utility::isanymlgmatch()) {
    thread scripts\mp\supers::watchobjuse(125);
  }

  return 1;
}

func_3CDD(param_00) {
  self notify("chargeMode_end");
  self notify("obj_drain_end");
  if(self _meth_84CA()) {
    self _meth_84CB();
  }

  self setscriptablepartstate("chargeModeMove", "neutral", 0);
  var_01 = self.var_3D11;
  self.var_3D11 = undefined;
  self.var_3D10 = undefined;
  self.var_3CEA = undefined;
  self.var_3CEC = undefined;
  self.var_3CEB = undefined;
  self.chargemode_epicimpactents = undefined;
  if(!scripts\mp\utility::istrue(param_00)) {
    self setscriptablepartstate("chargeMode", "activeEnd", 0);
    scripts\mp\utility::_enablecollisionnotifies(0);
    scripts\engine\utility::allow_usability(1);
    scripts\mp\utility::unblockperkfunction("specialty_lightweight");
    scripts\mp\utility::removeperk("specialty_stun_resistance");
    if(isDefined(var_01)) {
      foreach(var_03 in var_01) {
        if(isDefined(var_03)) {
          var_03 delete();
        }
      }
    }

    func_3CD7();
    if(isDefined(self.savedbullchargeweapon)) {
      if(!self.loadoutprimary == "iw7_fists" || self.loadoutsecondary == "iw7_fists") {
        scripts\mp\utility::_takeweapon("iw7_fists_mp");
      }

      scripts\mp\utility::_switchtoweaponimmediate(self.savedbullchargeweapon);
      self.savedbullchargeweapon = undefined;
      return;
    }

    return;
  }

  self setscriptablepartstate("chargeMode", "neutral", 0);
}

func_3CFB() {
  self endon("death");
  self endon("disconnect");
  self endon("chargemode_end");
  var_00 = cos(30);
  for(;;) {
    self waittill("collided", var_01, var_02, var_03, var_04, var_05);
    if(!chargemode_validdatapoint(var_02, var_03)) {
      continue;
    }

    var_06 = anglestoup(self.angles);
    var_07 = anglesToForward(self.angles);
    var_08 = var_02 - self.origin;
    var_09 = vectornormalize(var_08 - var_06 * vectordot(var_06, var_08));
    var_0A = vectordot(var_01, var_09);
    if(var_0A < 85) {
      continue;
    }

    if(vectordot(var_07, var_09) <= var_00) {
      continue;
    }

    self.chargemode_lastimpacttime = gettime();
  }
}

chargemode_validdatapoint(param_00, param_01) {
  var_02 = anglestoup(self.angles);
  var_03 = var_02 * -1;
  var_04 = self gettagorigin("j_helmet");
  var_05 = var_04 - param_00;
  var_06 = vectordot(var_05, var_02);
  if(var_06 >= 0 && var_06 <= 6) {
    if(acos(vectordot(param_01, var_03) <= 45)) {
      return 0;
    } else {
      return 1;
    }
  }

  var_07 = self gettagorigin("tag_origin");
  var_08 = var_07 - param_00;
  var_09 = vectordot(var_08, var_03);
  if(var_09 >= 0 || var_06 <= 6) {
    if(acos(vectordot(param_01, var_02) <= 45)) {
      return 0;
    } else {
      return 1;
    }
  }

  return 1;
}

func_3CFD(param_00) {
  var_01 = param_00 getentitynumber();
  self endon("death");
  self endon("disconnect");
  self endon("chargeMode_monitorKnockbackEnded_" + var_01);
  scripts\mp\utility::_enablecollisionnotifies(1);
  if(scripts\mp\utility::istrue(level.tactical)) {
    scripts\engine\utility::allow_doublejump(0);
  }

  thread func_3CFE(param_00);
  for(;;) {
    self waittill("collided", var_02, var_03, var_04, var_05, var_06);
    if(var_06 != "hittype_world") {
      continue;
    }

    var_02 = (var_02[0], var_02[1], max(0, var_02[2]));
    var_07 = -1 * vectordot(var_02, var_04);
    if(var_07 < 450) {
      continue;
    }

    if(isDefined(param_00)) {
      self dodamage(135, var_03, param_00, undefined, "MOD_EXPLOSIVE", "chargemode_mp");
    }

    break;
  }

  if(!level.tactical) {
    scripts\engine\utility::allow_doublejump(1);
  }

  scripts\mp\utility::_enablecollisionnotifies(0);
  self notify("chargeMode_monitorKnockbackEnded_" + var_01);
}

func_3CFE(param_00) {
  var_01 = param_00 getentitynumber();
  self endon("death");
  self endon("disconnect");
  self endon("chargeMode_monitorKnockbackEnded_" + var_01);
  wait(0.35);
  if(!level.tactical) {
    scripts\engine\utility::allow_doublejump(1);
  }

  scripts\mp\utility::_enablecollisionnotifies(0);
  self notify("chargeMode_monitorKnockbackEnded_" + var_01);
}

func_3CF7() {
  self endon("death");
  self endon("disconnect");
  self endon("chargeMode_end");
  self waittill("bullChargeEnd", var_00, var_01);
  if(scripts\mp\utility::istrue(var_01) || var_00 && func_3CDF()) {
    thread func_3CE9();
  }

  scripts\mp\supers::func_DE3B(9999);
}

chargemode_monitorkillstreakusage() {
  self endon("death");
  self endon("disconnect");
  self endon("chargeMode_end");
  for(;;) {
    if(isDefined(self.var_13111)) {
      waittillframeend;
      self notify("bullChargeEnd", 0, 0, 1);
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

chargemode_monitorshield() {
  self endon("death");
  self endon("disconnect");
  self endon("chargeMode_end");
  for(;;) {
    if(!self _meth_853E()) {
      waittillframeend;
      self notify("bullChargeEnd", 0, 0, 1);
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

chargemode_monitorarmor() {
  self endon("death");
  self endon("disconnect");
  chargemode_monitorarmorendearly();
  if(isDefined(self) && scripts\mp\utility::isreallyalive(self)) {
    scripts\mp\lightarmor::setlightarmorvalue(self, 0, 1, 0);
  }
}

chargemode_monitorarmorendearly() {
  self endon("chargeMode_end");
  var_00 = gettime();
  var_01 = var_00 + 3000;
  for(;;) {
    if(gettime() > var_01) {
      return;
    }

    if(!isDefined(self.ball_carried) && !scripts\mp\utility::istrue(self.spawnprotection)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  scripts\mp\lightarmor::setlightarmorvalue(self, 19, 1, 0);
  var_02 = int(ceil(0.95));
  scripts\engine\utility::waitframe();
  for(;;) {
    if(gettime() > var_01) {
      return;
    }

    var_03 = scripts\mp\lightarmor::getlightarmorvalue(self);
    scripts\mp\lightarmor::setlightarmorvalue(self, var_03 + var_02, 1, 0);
    scripts\engine\utility::waitframe();
  }

  self waittill("forever");
}

func_3D02() {
  self endon("death");
  self endon("disconnect");
  self endon("chargeMode_end");
  self.var_3D11 = [];
  for(;;) {
    self waittill("shield_hit", var_00);
    self.var_3D11[self.var_3D11.size] = var_00;
  }
}

func_3CFA() {
  self endon("disconnect");
  self endon("chargemode_unset");
  self endon("gracePeriodRaceEnd");
  var_00 = spawnStruct();
  childthread func_3CE2(var_00);
  childthread func_3CE4(var_00);
  childthread func_3CE3(var_00);
  childthread func_3CE5(var_00);
  self waittill("gracePeriodRaceBegin");
  waittillframeend;
  if(!scripts\mp\utility::istrue(var_00._meth_8462)) {
    if(scripts\mp\utility::istrue(var_00.var_E6) || scripts\mp\utility::istrue(var_00.var_6ABF)) {
      scripts\mp\supers::refundsuper();
    } else {
      var_01 = getsubstr(self.loadoutarchetype, 10, self.loadoutarchetype.size);
      scripts\mp\missions::func_D991("ch_" + var_01 + "_super");
      scripts\mp\supers::combatrecordsuperuse("super_chargemode");
    }
  } else {
    var_01 = getsubstr(self.loadoutarchetype, 10, self.loadoutarchetype.size);
    scripts\mp\missions::func_D991("ch_" + var_01 + "_super");
    scripts\mp\supers::combatrecordsuperuse("super_chargemode");
  }

  self notify("gracePeriodRaceEnd");
}

func_3CE2(param_00) {
  self waittill("death");
  param_00.var_E6 = 1;
  self notify("gracePeriodRaceBegin");
}

func_3CE4(param_00) {
  for(;;) {
    self waittill("got_a_kill", var_01, var_02, var_03);
    if(var_02 == "chargemode_mp") {
      break;
    }
  }

  param_00._meth_8462 = 1;
  self notify("gracePeriodRaceBegin");
}

func_3CE3(param_00) {
  self waittill("bullChargeEnd", var_01, var_02, var_03);
  if(scripts\mp\utility::istrue(var_03)) {
    param_00.var_6ABF = 1;
  } else if(var_01 && !func_3CDF()) {
    param_00.var_6ABF = 1;
  }

  self notify("gracePeriodRaceBegin");
}

func_3CE5(param_00) {
  wait(1);
  param_00.timeout = 1;
  self notify("gracePeriodRaceBegin");
}

func_3D04() {
  self endon("disconnect");
  self endon("chargeMode_end");
  self endon("chargeMode_unset");
  var_00 = spawn("trigger_rotatable_radius", self.origin, 0, 30, 72);
  var_00 enablelinkto();
  var_00 endon("death");
  childthread func_3D07(var_00);
  childthread func_3D06(var_00);
  childthread chargemode_monitortriggerinteractionmanual(var_00);
  thread func_3D05(var_00);
}

func_3D07(param_00) {
  for(;;) {
    if(func_3D0C()) {
      var_01 = self getvelocity();
      var_02 = vectortoangles(var_01);
      var_03 = anglesToForward(var_02);
      var_04 = anglestoup(var_02);
      var_05 = self.origin + anglestoup(self.angles) * 36;
      var_06 = var_05 + var_03 * 40;
      var_07 = scripts\common\trace::create_contents(0, 1, 1, 0, 1, 0);
      var_08 = physics_raycast(var_05, var_06, var_07, undefined, 0, "physicsquery_closest");
      if(isDefined(var_08) && var_08.size > 0) {
        var_06 = var_08[0]["position"];
      }

      param_00 unlink();
      param_00 dontinterpolate();
      param_00.origin = var_06 - var_04 * 36;
      param_00.angles = var_02;
      param_00 linkto(self);
    }

    scripts\engine\utility::waitframe();
  }
}

func_3D06(param_00) {
  param_00.var_11AD2 = [];
  for(;;) {
    param_00 waittill("trigger", var_01);
    if(isDefined(param_00.var_11AD2[var_01 getentitynumber()])) {
      continue;
    }

    if(!scripts\mp\equipment\phase_shift::areentitiesinphase(var_01, self)) {
      continue;
    }

    if(var_01 == self) {
      continue;
    }

    var_02 = scripts\engine\utility::ter_op(isDefined(var_01.triggerportableradarping), var_01.triggerportableradarping, var_01);
    if(!level.friendlyfire && var_02 != self && !scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(var_02, self))) {
      continue;
    }

    if(vectordot(var_01.origin - self.origin, anglesToForward(self.angles)) <= 0) {
      continue;
    }

    if(!isplayer(var_01) && !scripts\mp\utility::func_9F22(var_01)) {
      continue;
    }

    func_3D18(param_00, var_01);
  }
}

func_3D18(param_00, param_01) {
  if(!scripts\mp\utility::isreallyalive(param_01)) {
    return;
  }

  if(isplayer(param_01)) {
    if(param_01 _meth_8569()) {
      return;
    }

    if(param_01 _meth_8568()) {
      return;
    }
  }

  var_02 = scripts\common\trace::create_contents(0, 1, 1, 0, 1, 0);
  var_03 = physics_raycast(self getEye(), param_01 getEye(), var_02, undefined, 0, "physicsquery_closest");
  if(isDefined(var_03) && var_03.size > 0) {
    return;
  }

  var_04 = self getvelocity();
  var_05 = vectortoangles(var_04);
  var_06 = anglesToForward(var_05);
  if(scripts\mp\utility::func_9F22(param_01)) {
    var_07 = vectornormalize(param_01.origin - self.origin * (1, 1, 0));
    var_08 = vectornormalize(var_06 * (1, 1, 0));
    var_09 = scripts\engine\utility::anglebetweenvectorsunit(var_07, var_08);
    thread func_3D14(param_00, param_01);
    if(!func_3CE7(param_01)) {
      func_3CD5(param_01);
    }

    if(var_09 <= 25) {
      func_3CE0();
      return;
    }

    return;
  }

  thread func_3D14(param_00, param_01);
  thread scripts\mp\gamescore::func_11ACF(self, param_01, "chargemode_mp", 5);
  if(!chargemode_isqueuedforepicimpact(param_01)) {
    if(param_01 _meth_84CA() && func_3CE8(param_01)) {
      if(param_01 func_3CE8(self)) {
        thread chargemode_queueforepicimpact(param_01);
        param_01 thread chargemode_queueforepicimpact(self);
        return;
      }

      func_3CF5(param_01, var_06);
      return;
    }

    func_3CF5(param_01, var_06);
    func_3CD5(param_01);
    return;
  }
}

chargemode_isqueuedforepicimpact(param_00) {
  if(!isDefined(self.chargemode_epicimpactents)) {
    return 0;
  }

  return isDefined(self.chargemode_epicimpactents[param_00 getentitynumber()]);
}

chargemode_queueforepicimpact(param_00) {
  self endon("death");
  self endon("disconnect");
  self notify("chargeMode_queueEpicImpact");
  self endon("chargeMode_queueEpicImpact");
  self.chargemode_epicimpactents[param_00 getentitynumber()] = param_00;
  waittillframeend;
  func_3CE0();
}

func_3D05(param_00) {
  param_00 endon("death");
  scripts\engine\utility::waittill_any_3("death", "disconnect", "chargeMode_end", "chargeMode_unset");
  param_00 delete();
}

chargemode_monitortriggerinteractionmanual(param_00) {
  var_01 = 36;
  var_02 = 4096;
  var_03 = scripts\common\trace::create_contents(0, 1, 1, 0, 1, 1);
  for(;;) {
    var_04 = param_00.origin + anglestoup(param_00.angles) * var_01;
    var_05 = chargemode_gettriggermanualents();
    foreach(var_07 in var_05) {
      if(isDefined(param_00.var_11AD2[var_07 getentitynumber()])) {
        continue;
      }

      if(!scripts\mp\equipment\phase_shift::areentitiesinphase(var_07, self)) {
        continue;
      }

      var_08 = scripts\engine\utility::ter_op(isDefined(var_07.triggerportableradarping), var_07.triggerportableradarping, var_07);
      if(!level.friendlyfire && var_08 != self && !scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(var_08, self))) {
        continue;
      }

      var_09 = var_07.origin - self.origin;
      if(vectordot(var_09, anglesToForward(self.angles)) <= 0) {
        continue;
      }

      var_0A = var_07.origin - var_04;
      if(lengthsquared(var_0A) > var_02) {
        continue;
      }

      var_0B = physics_raycast(var_04, var_07.origin, var_03, [var_07], 0, "physicsquery_closest", 1);
      if(isDefined(var_0B) && var_0B.size > 0) {
        continue;
      }

      if(var_07 scripts\mp\equipment\exploding_drone::isexplodingdrone()) {
        var_07 scripts\mp\equipment\exploding_drone::explodingdrone_makedamageimmune(self);
      } else if(var_07 scripts\mp\killstreaks\_venom::isvenom()) {
        var_07 scripts\mp\killstreaks\_venom::makedamageimmune(self);
      }

      thread func_3D14(param_00, var_07);
      func_3CD5(var_07);
    }

    scripts\engine\utility::waitframe();
  }
}

func_3CD5(param_00) {
  var_01 = 140;
  var_02 = param_00.streakname;
  if(isDefined(var_02)) {
    switch (var_02) {
      case "remote_c8":
        var_01 = int(ceil(param_00.maxhealth / 4));
        break;

      case "ball_drone_backup":
        var_01 = int(ceil(param_00.maxhealth / 1));
        break;

      case "minijackal":
        var_01 = int(ceil(param_00.maxhealth / 4));
        break;

      case "dronedrop":
        var_01 = int(ceil(param_00.maxhealth / 1));
        break;

      case "sentry_shock":
        var_01 = int(ceil(param_00.maxhealth / 2));
        break;
    }
  } else {
    var_03 = param_00.weapon_name;
    if(isDefined(var_03)) {
      switch (var_03) {
        case "super_trophy_mp":
          var_01 = int(ceil(param_00.maxhealth / 2));
          break;

        case "micro_turret_mp":
          var_01 = int(ceil(param_00.maxhealth / 1));
          break;
      }
    }
  }

  param_00 dodamage(var_01, self.origin, self, self, "MOD_EXPLOSIVE", "chargemode_mp");
  thread func_3CD6();
}

func_3CF5(param_00, param_01) {
  var_02 = param_00.origin - self.origin;
  var_03 = length(var_02);
  if(var_03 != 0) {
    var_04 = var_02 / var_03;
    var_05 = param_00 getvelocity();
    var_05 = var_05 - var_04 * vectordot(var_05, var_04);
    var_05 = var_05 + var_04 * 750;
    var_05 = var_05 + (0, 0, 250);
    var_06 = clamp(var_05[2], 100, 500);
    var_05 = (var_05[0], var_05[1], var_06);
    param_00 _meth_84DC(var_05, length(var_05));
    param_00 shellshock("chargemode_mp", 0.85);
  }
}

func_3CE9() {
  thread chargemode_monitordestructibleimpactimmunity();
  self radiusdamage(self.origin, 256, 140, 70, self, "MOD_EXPLOSIVE", "chargemode_mp");
  scripts\mp\shellshock::grenade_earthquakeatposition(self.origin);
  playFX(scripts\engine\utility::getfx("chargemode_expl"), self.origin);
  self playSound("heavy_charge_impact_wall");
  self setclientomnvar("ui_hud_shake", 1);
}

func_3CD3() {
  self attachshieldmodel("weapon_retract_shield_wm_mp", "tag_weapon_left");
  self.var_3D10 = 1;
}

func_3CD7() {
  self detachshieldmodel("weapon_retract_shield_wm_mp", "tag_weapon_left");
  self.var_3D10 = 0;
}

func_3D14(param_00, param_01) {
  param_00 endon("death");
  var_02 = param_01 getentitynumber();
  param_00.var_11AD2[var_02] = param_01;
  func_3D15(param_00, param_01);
  param_00.var_11AD2[var_02] = undefined;
}

func_3D15(param_00, param_01) {
  self endon("disconnect");
  self endon("chargeMode_end");
  param_01 endon("death");
  param_01 endon("disconnect");
  wait(0.2);
}

func_3CEE(param_00) {
  return param_00 _meth_84CA();
}

func_3D0C() {
  var_00 = self getvelocity();
  var_00 = (var_00[0], var_00[1], 0);
  var_01 = lengthsquared(var_00);
  return var_01 >= -10311 && vectordot(var_00, anglesToForward(self.angles)) > 0 && !self _meth_8499();
}

func_3CDF() {
  var_00 = self.chargemode_lastimpacttime;
  if(isDefined(var_00) && gettime() - var_00 <= 50) {
    return 1;
  }

  return 0;
}

func_3CE0() {
  self notify("bullChargeEnd", 1, 1);
}

func_3CE8(param_00) {
  var_01 = self.origin * (1, 1, 0);
  var_02 = param_00.origin * (1, 1, 0);
  if(var_01 == var_02) {
    return 0;
  }

  var_03 = var_01 - var_02;
  var_04 = anglesToForward(param_00.angles);
  var_05 = scripts\engine\utility::anglebetweenvectors(var_03, var_04);
  if(var_05 < 30) {
    return 1;
  }

  return 0;
}

func_3CE7(param_00) {
  var_01 = self.origin * (1, 1, 0);
  var_02 = param_00.origin * (1, 1, 0);
  if(var_01 == var_02) {
    return 0;
  }

  var_03 = var_01 - var_02;
  var_04 = anglesToForward(param_00.angles);
  var_05 = anglestoright(param_00.angles);
  var_06 = scripts\engine\utility::anglebetweenvectors(var_03, var_04);
  if(vectordot(var_05, var_03) < 0) {
    var_06 = var_06 * -1;
  }

  if(param_00 _meth_853E()) {
    if(var_06 >= -45 && var_06 <= 30) {
      return 1;
    }
  } else if(var_06 >= -75 && var_06 <= 0) {
    return 1;
  }

  return 0;
}

chargemode_gettriggermanualents() {
  var_00 = [];
  if(isDefined(level.turrets)) {
    var_00[var_00.size] = level.turrets;
  }

  if(isDefined(level.littlebirds)) {
    var_00[var_00.size] = level.littlebirds;
  }

  if(isDefined(level.var_105EA)) {
    var_00[var_00.size] = level.var_105EA;
  }

  if(isDefined(level.balldrones)) {
    var_00[var_00.size] = level.balldrones;
  }

  if(isDefined(level.supertrophy) && isDefined(level.supertrophy.trophies)) {
    var_00[var_00.size] = level.supertrophy.trophies;
  }

  if(isDefined(level.var_69D6)) {
    var_00[var_00.size] = level.var_69D6;
  }

  return scripts\engine\utility::array_combine_multiple(var_00);
}

chargemode_modifieddamage(param_00, param_01, param_02, param_03, param_04) {
  if(chargemode_isdamageimmune(param_00, param_01, param_02, param_03)) {
    param_04 = 0;
  }

  return param_04;
}

chargemode_isdamageimmune(param_00, param_01, param_02, param_03) {
  var_04 = 0;
  if(!var_04) {
    var_04 = var_04 || chargemode_isdamageimmuneepicimpact(param_00, param_01, param_02);
  }

  if(!var_04) {
    var_04 = var_04 || chargemode_isdamageimmunedestructibleimpact(param_00, param_01, param_02, param_03);
  }

  return var_04;
}

chargemode_isdamageimmuneepicimpact(param_00, param_01, param_02) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(!isDefined(param_02)) {
    return 0;
  }

  if(param_02 != "chargemode_mp") {
    return 0;
  }

  if(!isDefined(param_00.chargemode_epicimpactents)) {
    return 0;
  }

  return isDefined(param_00.chargemode_epicimpactents[param_01 getentitynumber()]);
}

chargemode_isdamageimmunedestructibleimpact(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03)) {
    return 0;
  }

  if(!isDefined(param_02)) {
    return 0;
  }

  if(!isDefined(param_00)) {
    return 0;
  }

  if(param_00 != param_01) {
    return 0;
  }

  if(!scripts\mp\utility::istrue(param_01.chargemode_destructibleimpactimmune)) {
    return 0;
  }

  if(!scripts\engine\utility::string_starts_with(param_02, "destructible")) {
    return 0;
  }

  var_04 = anglesToForward(param_01.angles);
  var_05 = vectornormalize(param_03 - param_01.origin);
  return scripts\engine\utility::anglebetweenvectorsunit(var_04, var_05) <= 65;
}

chargemode_monitordestructibleimpactimmunity() {
  self endon("disconnect");
  self.chargemode_destructibleimpactimmune = 1;
  wait(0.1);
  self.chargemode_destructibleimpactimmune = undefined;
}

func_3CD6() {
  if(isDefined(self.chargemode_damagefxtime) && self.chargemode_damagefxtime == gettime()) {
    return;
  }

  self.chargemode_damagefxtime = gettime();
  if(!isDefined(self.chargemode_damagefxindex)) {
    self.chargemode_damagefxindex = 1;
  }

  var_00 = "active" + self.chargemode_damagefxindex;
  self setclientomnvar("ui_hud_shake", 1);
  self setscriptablepartstate("chargeModeImpact", var_00, 0);
  self.chargemode_damagefxindex = 1 + scripts\engine\utility::mod(self.chargemode_damagefxindex, 3);
}

func_3CF9() {
  self endon("death");
  self endon("disconnect");
  self endon("chargemode_end");
  var_00 = 0;
  var_01 = undefined;
  self setscriptablepartstate("chargeMode", "active", 0);
  for(;;) {
    var_01 = func_3D0C();
    if(var_01 != var_00) {
      if(var_01) {
        self setscriptablepartstate("chargeModeMove", "active", 0);
      } else {
        self setscriptablepartstate("chargeModeMove", "neutral", 0);
      }
    }

    var_00 = var_01;
    wait(0.1);
  }
}