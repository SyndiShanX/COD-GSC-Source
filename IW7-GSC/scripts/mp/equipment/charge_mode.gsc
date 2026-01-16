/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\equipment\charge_mode.gsc
************************************************/

func_3CED() {
  level._effect["chargemode_expl"] = loadfx("vfx\iw7\_requests\mp\super\vfx_chargemode_expl.vfx");
}

func_3D0E() {}

func_3D19() {
  self notify("chargeMode_unset");
  if(self func_84CA()) {
    func_3CDD();
  }
}

func_3D1A() {
  self.chargemode_epicimpactents = [];
  scripts\mp\utility::_enablecollisionnotifies(1);
  scripts\engine\utility::allow_usability(0);
  scripts\mp\utility::blockperkfunction("specialty_lightweight");
  scripts\mp\utility::giveperk("specialty_stun_resistance");
  var_0 = self getcurrentweapon();
  if(issubstr(var_0, "iw7_nunchucks") || issubstr(var_0, "iw7_katana")) {
    if(!self.loadoutprimary == "iw7_fists" || self.loadoutsecondary == "iw7_fists") {
      scripts\mp\utility::_giveweapon("iw7_fists_mp");
    }

    scripts\mp\utility::_switchtoweaponimmediate("iw7_fists_mp");
    self.savedbullchargeweapon = var_0;
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

func_3CDD(var_0) {
  self notify("chargeMode_end");
  self notify("obj_drain_end");
  if(self func_84CA()) {
    self func_84CB();
  }

  self setscriptablepartstate("chargeModeMove", "neutral", 0);
  var_1 = self.var_3D11;
  self.var_3D11 = undefined;
  self.var_3D10 = undefined;
  self.var_3CEA = undefined;
  self.var_3CEC = undefined;
  self.var_3CEB = undefined;
  self.chargemode_epicimpactents = undefined;
  if(!scripts\mp\utility::istrue(var_0)) {
    self setscriptablepartstate("chargeMode", "activeEnd", 0);
    scripts\mp\utility::_enablecollisionnotifies(0);
    scripts\engine\utility::allow_usability(1);
    scripts\mp\utility::unblockperkfunction("specialty_lightweight");
    scripts\mp\utility::removeperk("specialty_stun_resistance");
    if(isDefined(var_1)) {
      foreach(var_3 in var_1) {
        if(isDefined(var_3)) {
          var_3 delete();
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
  var_0 = cos(30);
  for(;;) {
    self waittill("collided", var_1, var_2, var_3, var_4, var_5);
    if(!chargemode_validdatapoint(var_2, var_3)) {
      continue;
    }

    var_6 = anglestoup(self.angles);
    var_7 = anglesToForward(self.angles);
    var_8 = var_2 - self.origin;
    var_9 = vectornormalize(var_8 - var_6 * vectordot(var_6, var_8));
    var_10 = vectordot(var_1, var_9);
    if(var_10 < 85) {
      continue;
    }

    if(vectordot(var_7, var_9) <= var_0) {
      continue;
    }

    self.chargemode_lastimpacttime = gettime();
  }
}

chargemode_validdatapoint(var_0, var_1) {
  var_2 = anglestoup(self.angles);
  var_3 = var_2 * -1;
  var_4 = self gettagorigin("j_helmet");
  var_5 = var_4 - var_0;
  var_6 = vectordot(var_5, var_2);
  if(var_6 >= 0 && var_6 <= 6) {
    if(acos(vectordot(var_1, var_3) <= 45)) {
      return 0;
    } else {
      return 1;
    }
  }

  var_7 = self gettagorigin("tag_origin");
  var_8 = var_7 - var_0;
  var_9 = vectordot(var_8, var_3);
  if(var_9 >= 0 || var_6 <= 6) {
    if(acos(vectordot(var_1, var_2) <= 45)) {
      return 0;
    } else {
      return 1;
    }
  }

  return 1;
}

func_3CFD(var_0) {
  var_1 = var_0 getentitynumber();
  self endon("death");
  self endon("disconnect");
  self endon("chargeMode_monitorKnockbackEnded_" + var_1);
  scripts\mp\utility::_enablecollisionnotifies(1);
  if(scripts\mp\utility::istrue(level.tactical)) {
    scripts\engine\utility::allow_doublejump(0);
  }

  thread func_3CFE(var_0);
  for(;;) {
    self waittill("collided", var_2, var_3, var_4, var_5, var_6);
    if(var_6 != "hittype_world") {
      continue;
    }

    var_2 = (var_2[0], var_2[1], max(0, var_2[2]));
    var_7 = -1 * vectordot(var_2, var_4);
    if(var_7 < 450) {
      continue;
    }

    if(isDefined(var_0)) {
      self dodamage(135, var_3, var_0, undefined, "MOD_EXPLOSIVE", "chargemode_mp");
    }

    break;
  }

  if(!level.tactical) {
    scripts\engine\utility::allow_doublejump(1);
  }

  scripts\mp\utility::_enablecollisionnotifies(0);
  self notify("chargeMode_monitorKnockbackEnded_" + var_1);
}

func_3CFE(var_0) {
  var_1 = var_0 getentitynumber();
  self endon("death");
  self endon("disconnect");
  self endon("chargeMode_monitorKnockbackEnded_" + var_1);
  wait(0.35);
  if(!level.tactical) {
    scripts\engine\utility::allow_doublejump(1);
  }

  scripts\mp\utility::_enablecollisionnotifies(0);
  self notify("chargeMode_monitorKnockbackEnded_" + var_1);
}

func_3CF7() {
  self endon("death");
  self endon("disconnect");
  self endon("chargeMode_end");
  self waittill("bullChargeEnd", var_0, var_1);
  if(scripts\mp\utility::istrue(var_1) || var_0 && func_3CDF()) {
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
    if(!self func_853E()) {
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
  var_0 = gettime();
  var_1 = var_0 + 3000;
  for(;;) {
    if(gettime() > var_1) {
      return;
    }

    if(!isDefined(self.ball_carried) && !scripts\mp\utility::istrue(self.spawnprotection)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  scripts\mp\lightarmor::setlightarmorvalue(self, 19, 1, 0);
  var_2 = int(ceil(0.95));
  scripts\engine\utility::waitframe();
  for(;;) {
    if(gettime() > var_1) {
      return;
    }

    var_3 = scripts\mp\lightarmor::getlightarmorvalue(self);
    scripts\mp\lightarmor::setlightarmorvalue(self, var_3 + var_2, 1, 0);
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
    self waittill("shield_hit", var_0);
    self.var_3D11[self.var_3D11.size] = var_0;
  }
}

func_3CFA() {
  self endon("disconnect");
  self endon("chargemode_unset");
  self endon("gracePeriodRaceEnd");
  var_0 = spawnStruct();
  childthread func_3CE2(var_0);
  childthread func_3CE4(var_0);
  childthread func_3CE3(var_0);
  childthread func_3CE5(var_0);
  self waittill("gracePeriodRaceBegin");
  waittillframeend;
  if(!scripts\mp\utility::istrue(var_0.func_8462)) {
    if(scripts\mp\utility::istrue(var_0.var_E6) || scripts\mp\utility::istrue(var_0.var_6ABF)) {
      scripts\mp\supers::refundsuper();
    } else {
      var_1 = getsubstr(self.loadoutarchetype, 10, self.loadoutarchetype.size);
      scripts\mp\missions::func_D991("ch_" + var_1 + "_super");
      scripts\mp\supers::combatrecordsuperuse("super_chargemode");
    }
  } else {
    var_1 = getsubstr(self.loadoutarchetype, 10, self.loadoutarchetype.size);
    scripts\mp\missions::func_D991("ch_" + var_1 + "_super");
    scripts\mp\supers::combatrecordsuperuse("super_chargemode");
  }

  self notify("gracePeriodRaceEnd");
}

func_3CE2(var_0) {
  self waittill("death");
  var_0.var_E6 = 1;
  self notify("gracePeriodRaceBegin");
}

func_3CE4(var_0) {
  for(;;) {
    self waittill("got_a_kill", var_1, var_2, var_3);
    if(var_2 == "chargemode_mp") {
      break;
    }
  }

  var_0.func_8462 = 1;
  self notify("gracePeriodRaceBegin");
}

func_3CE3(var_0) {
  self waittill("bullChargeEnd", var_1, var_2, var_3);
  if(scripts\mp\utility::istrue(var_3)) {
    var_0.var_6ABF = 1;
  } else if(var_1 && !func_3CDF()) {
    var_0.var_6ABF = 1;
  }

  self notify("gracePeriodRaceBegin");
}

func_3CE5(var_0) {
  wait(1);
  var_0.timeout = 1;
  self notify("gracePeriodRaceBegin");
}

func_3D04() {
  self endon("disconnect");
  self endon("chargeMode_end");
  self endon("chargeMode_unset");
  var_0 = spawn("trigger_rotatable_radius", self.origin, 0, 30, 72);
  var_0 enablelinkto();
  var_0 endon("death");
  childthread func_3D07(var_0);
  childthread func_3D06(var_0);
  childthread chargemode_monitortriggerinteractionmanual(var_0);
  thread func_3D05(var_0);
}

func_3D07(var_0) {
  for(;;) {
    if(func_3D0C()) {
      var_1 = self getvelocity();
      var_2 = vectortoangles(var_1);
      var_3 = anglesToForward(var_2);
      var_4 = anglestoup(var_2);
      var_5 = self.origin + anglestoup(self.angles) * 36;
      var_6 = var_5 + var_3 * 40;
      var_7 = scripts\common\trace::create_contents(0, 1, 1, 0, 1, 0);
      var_8 = physics_raycast(var_5, var_6, var_7, undefined, 0, "physicsquery_closest");
      if(isDefined(var_8) && var_8.size > 0) {
        var_6 = var_8[0]["position"];
      }

      var_0 unlink();
      var_0 dontinterpolate();
      var_0.origin = var_6 - var_4 * 36;
      var_0.angles = var_2;
      var_0 linkto(self);
    }

    scripts\engine\utility::waitframe();
  }
}

func_3D06(var_0) {
  var_0.var_11AD2 = [];
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(isDefined(var_0.var_11AD2[var_1 getentitynumber()])) {
      continue;
    }

    if(!scripts\mp\equipment\phase_shift::areentitiesinphase(var_1, self)) {
      continue;
    }

    if(var_1 == self) {
      continue;
    }

    var_2 = scripts\engine\utility::ter_op(isDefined(var_1.owner), var_1.owner, var_1);
    if(!level.friendlyfire && var_2 != self && !scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(var_2, self))) {
      continue;
    }

    if(vectordot(var_1.origin - self.origin, anglesToForward(self.angles)) <= 0) {
      continue;
    }

    if(!isplayer(var_1) && !scripts\mp\utility::func_9F22(var_1)) {
      continue;
    }

    func_3D18(var_0, var_1);
  }
}

func_3D18(var_0, var_1) {
  if(!scripts\mp\utility::isreallyalive(var_1)) {
    return;
  }

  if(isplayer(var_1)) {
    if(var_1 func_8569()) {
      return;
    }

    if(var_1 func_8568()) {
      return;
    }
  }

  var_2 = scripts\common\trace::create_contents(0, 1, 1, 0, 1, 0);
  var_3 = physics_raycast(self getEye(), var_1 getEye(), var_2, undefined, 0, "physicsquery_closest");
  if(isDefined(var_3) && var_3.size > 0) {
    return;
  }

  var_4 = self getvelocity();
  var_5 = vectortoangles(var_4);
  var_6 = anglesToForward(var_5);
  if(scripts\mp\utility::func_9F22(var_1)) {
    var_7 = vectornormalize(var_1.origin - self.origin * (1, 1, 0));
    var_8 = vectornormalize(var_6 * (1, 1, 0));
    var_9 = scripts\engine\utility::anglebetweenvectorsunit(var_7, var_8);
    thread func_3D14(var_0, var_1);
    if(!func_3CE7(var_1)) {
      func_3CD5(var_1);
    }

    if(var_9 <= 25) {
      func_3CE0();
      return;
    }

    return;
  }

  thread func_3D14(var_0, var_1);
  thread scripts\mp\gamescore::func_11ACF(self, var_1, "chargemode_mp", 5);
  if(!chargemode_isqueuedforepicimpact(var_1)) {
    if(var_1 func_84CA() && func_3CE8(var_1)) {
      if(var_1 func_3CE8(self)) {
        thread chargemode_queueforepicimpact(var_1);
        var_1 thread chargemode_queueforepicimpact(self);
        return;
      }

      func_3CF5(var_1, var_6);
      return;
    }

    func_3CF5(var_1, var_6);
    func_3CD5(var_1);
    return;
  }
}

chargemode_isqueuedforepicimpact(var_0) {
  if(!isDefined(self.chargemode_epicimpactents)) {
    return 0;
  }

  return isDefined(self.chargemode_epicimpactents[var_0 getentitynumber()]);
}

chargemode_queueforepicimpact(var_0) {
  self endon("death");
  self endon("disconnect");
  self notify("chargeMode_queueEpicImpact");
  self endon("chargeMode_queueEpicImpact");
  self.chargemode_epicimpactents[var_0 getentitynumber()] = var_0;
  waittillframeend;
  func_3CE0();
}

func_3D05(var_0) {
  var_0 endon("death");
  scripts\engine\utility::waittill_any("death", "disconnect", "chargeMode_end", "chargeMode_unset");
  var_0 delete();
}

chargemode_monitortriggerinteractionmanual(var_0) {
  var_1 = 36;
  var_2 = 4096;
  var_3 = scripts\common\trace::create_contents(0, 1, 1, 0, 1, 1);
  for(;;) {
    var_4 = var_0.origin + anglestoup(var_0.angles) * var_1;
    var_5 = chargemode_gettriggermanualents();
    foreach(var_7 in var_5) {
      if(isDefined(var_0.var_11AD2[var_7 getentitynumber()])) {
        continue;
      }

      if(!scripts\mp\equipment\phase_shift::areentitiesinphase(var_7, self)) {
        continue;
      }

      var_8 = scripts\engine\utility::ter_op(isDefined(var_7.owner), var_7.owner, var_7);
      if(!level.friendlyfire && var_8 != self && !scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(var_8, self))) {
        continue;
      }

      var_9 = var_7.origin - self.origin;
      if(vectordot(var_9, anglesToForward(self.angles)) <= 0) {
        continue;
      }

      var_10 = var_7.origin - var_4;
      if(lengthsquared(var_10) > var_2) {
        continue;
      }

      var_11 = physics_raycast(var_4, var_7.origin, var_3, [var_7], 0, "physicsquery_closest", 1);
      if(isDefined(var_11) && var_11.size > 0) {
        continue;
      }

      if(var_7 scripts\mp\equipment\exploding_drone::isexplodingdrone()) {
        var_7 scripts\mp\equipment\exploding_drone::explodingdrone_makedamageimmune(self);
      } else if(var_7 scripts\mp\killstreaks\_venom::isvenom()) {
        var_7 scripts\mp\killstreaks\_venom::makedamageimmune(self);
      }

      thread func_3D14(var_0, var_7);
      func_3CD5(var_7);
    }

    scripts\engine\utility::waitframe();
  }
}

func_3CD5(var_0) {
  var_1 = 140;
  var_2 = var_0.streakname;
  if(isDefined(var_2)) {
    switch (var_2) {
      case "remote_c8":
        var_1 = int(ceil(var_0.maxhealth / 4));
        break;

      case "ball_drone_backup":
        var_1 = int(ceil(var_0.maxhealth / 1));
        break;

      case "minijackal":
        var_1 = int(ceil(var_0.maxhealth / 4));
        break;

      case "dronedrop":
        var_1 = int(ceil(var_0.maxhealth / 1));
        break;

      case "sentry_shock":
        var_1 = int(ceil(var_0.maxhealth / 2));
        break;
    }
  } else {
    var_3 = var_0.weapon_name;
    if(isDefined(var_3)) {
      switch (var_3) {
        case "super_trophy_mp":
          var_1 = int(ceil(var_0.maxhealth / 2));
          break;

        case "micro_turret_mp":
          var_1 = int(ceil(var_0.maxhealth / 1));
          break;
      }
    }
  }

  var_0 dodamage(var_1, self.origin, self, self, "MOD_EXPLOSIVE", "chargemode_mp");
  thread func_3CD6();
}

func_3CF5(var_0, var_1) {
  var_2 = var_0.origin - self.origin;
  var_3 = length(var_2);
  if(var_3 != 0) {
    var_4 = var_2 / var_3;
    var_5 = var_0 getvelocity();
    var_5 = var_5 - var_4 * vectordot(var_5, var_4);
    var_5 = var_5 + var_4 * 750;
    var_5 = var_5 + (0, 0, 250);
    var_6 = clamp(var_5[2], 100, 500);
    var_5 = (var_5[0], var_5[1], var_6);
    var_0 func_84DC(var_5, length(var_5));
    var_0 shellshock("chargemode_mp", 0.85);
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

func_3D14(var_0, var_1) {
  var_0 endon("death");
  var_2 = var_1 getentitynumber();
  var_0.var_11AD2[var_2] = var_1;
  func_3D15(var_0, var_1);
  var_0.var_11AD2[var_2] = undefined;
}

func_3D15(var_0, var_1) {
  self endon("disconnect");
  self endon("chargeMode_end");
  var_1 endon("death");
  var_1 endon("disconnect");
  wait(0.2);
}

func_3CEE(var_0) {
  return var_0 func_84CA();
}

func_3D0C() {
  var_0 = self getvelocity();
  var_0 = (var_0[0], var_0[1], 0);
  var_1 = lengthsquared(var_0);
  return var_1 >= -10311 && vectordot(var_0, anglesToForward(self.angles)) > 0 && !self func_8499();
}

func_3CDF() {
  var_0 = self.chargemode_lastimpacttime;
  if(isDefined(var_0) && gettime() - var_0 <= 50) {
    return 1;
  }

  return 0;
}

func_3CE0() {
  self notify("bullChargeEnd", 1, 1);
}

func_3CE8(var_0) {
  var_1 = self.origin * (1, 1, 0);
  var_2 = var_0.origin * (1, 1, 0);
  if(var_1 == var_2) {
    return 0;
  }

  var_3 = var_1 - var_2;
  var_4 = anglesToForward(var_0.angles);
  var_5 = scripts\engine\utility::anglebetweenvectors(var_3, var_4);
  if(var_5 < 30) {
    return 1;
  }

  return 0;
}

func_3CE7(var_0) {
  var_1 = self.origin * (1, 1, 0);
  var_2 = var_0.origin * (1, 1, 0);
  if(var_1 == var_2) {
    return 0;
  }

  var_3 = var_1 - var_2;
  var_4 = anglesToForward(var_0.angles);
  var_5 = anglestoright(var_0.angles);
  var_6 = scripts\engine\utility::anglebetweenvectors(var_3, var_4);
  if(vectordot(var_5, var_3) < 0) {
    var_6 = var_6 * -1;
  }

  if(var_0 func_853E()) {
    if(var_6 >= -45 && var_6 <= 30) {
      return 1;
    }
  } else if(var_6 >= -75 && var_6 <= 0) {
    return 1;
  }

  return 0;
}

chargemode_gettriggermanualents() {
  var_0 = [];
  if(isDefined(level.turrets)) {
    var_0[var_0.size] = level.turrets;
  }

  if(isDefined(level.littlebirds)) {
    var_0[var_0.size] = level.littlebirds;
  }

  if(isDefined(level.var_105EA)) {
    var_0[var_0.size] = level.var_105EA;
  }

  if(isDefined(level.balldrones)) {
    var_0[var_0.size] = level.balldrones;
  }

  if(isDefined(level.supertrophy) && isDefined(level.supertrophy.trophies)) {
    var_0[var_0.size] = level.supertrophy.trophies;
  }

  if(isDefined(level.var_69D6)) {
    var_0[var_0.size] = level.var_69D6;
  }

  return scripts\engine\utility::array_combine_multiple(var_0);
}

chargemode_modifieddamage(var_0, var_1, var_2, var_3, var_4) {
  if(chargemode_isdamageimmune(var_0, var_1, var_2, var_3)) {
    var_4 = 0;
  }

  return var_4;
}

chargemode_isdamageimmune(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  if(!var_4) {
    var_4 = var_4 || chargemode_isdamageimmuneepicimpact(var_0, var_1, var_2);
  }

  if(!var_4) {
    var_4 = var_4 || chargemode_isdamageimmunedestructibleimpact(var_0, var_1, var_2, var_3);
  }

  return var_4;
}

chargemode_isdamageimmuneepicimpact(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isDefined(var_2)) {
    return 0;
  }

  if(var_2 != "chargemode_mp") {
    return 0;
  }

  if(!isDefined(var_0.chargemode_epicimpactents)) {
    return 0;
  }

  return isDefined(var_0.chargemode_epicimpactents[var_1 getentitynumber()]);
}

chargemode_isdamageimmunedestructibleimpact(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    return 0;
  }

  if(!isDefined(var_2)) {
    return 0;
  }

  if(!isDefined(var_0)) {
    return 0;
  }

  if(var_0 != var_1) {
    return 0;
  }

  if(!scripts\mp\utility::istrue(var_1.chargemode_destructibleimpactimmune)) {
    return 0;
  }

  if(!scripts\engine\utility::string_starts_with(var_2, "destructible")) {
    return 0;
  }

  var_4 = anglesToForward(var_1.angles);
  var_5 = vectornormalize(var_3 - var_1.origin);
  return scripts\engine\utility::anglebetweenvectorsunit(var_4, var_5) <= 65;
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

  var_0 = "active" + self.chargemode_damagefxindex;
  self setclientomnvar("ui_hud_shake", 1);
  self setscriptablepartstate("chargeModeImpact", var_0, 0);
  self.chargemode_damagefxindex = 1 + scripts\engine\utility::mod(self.chargemode_damagefxindex, 3);
}

func_3CF9() {
  self endon("death");
  self endon("disconnect");
  self endon("chargemode_end");
  var_0 = 0;
  var_1 = undefined;
  self setscriptablepartstate("chargeMode", "active", 0);
  for(;;) {
    var_1 = func_3D0C();
    if(var_1 != var_0) {
      if(var_1) {
        self setscriptablepartstate("chargeModeMove", "active", 0);
      } else {
        self setscriptablepartstate("chargeModeMove", "neutral", 0);
      }
    }

    var_0 = var_1;
    wait(0.1);
  }
}