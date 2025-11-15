/****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\equipment\exploding_drone.gsc
****************************************************/

func_69D5() {
  level.var_69D6 = [];
}

func_69D0(param_00) {
  thread func_69CC();
}

func_69D3() {
  self notify("exploding_drone_unset");
  self.var_D38B = undefined;
}

func_69D4(param_00, param_01) {
  param_01 = scripts\mp\utility::istrue(param_01);
  param_00.issmokeversion = param_01;
  param_00.throwtime = gettime();
  if(!param_01) {
    thread func_69CD();
    thread func_69CC();
    scripts\mp\utility::printgameaction("exploding drone spawn", param_00.triggerportableradarping);
  } else if(scripts\mp\equipment\phase_shift::isentityphaseshifted(self)) {
    return;
  }

  param_00 thread func_69C5();
  param_00 thread func_69D1();
  param_00 thread func_69C0();
}

func_69C6() {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  wait(0.1);
  thread func_69C8(self.triggerportableradarping);
}

func_69C8(param_00) {
  var_01 = self.triggerportableradarping;
  if(!isDefined(param_00)) {
    param_00 = var_01;
  }

  explodingdrone_awardpointsfordeath(param_00, var_01);
  self _meth_8593();
  self setscriptablepartstate("beacon", "neutral", 0);
  self setscriptablepartstate("primaryThruster", "neutral", 0);
  self setscriptablepartstate("secondaryThrusters", "neutral", 0);
  var_02 = undefined;
  if(!self.issmokeversion) {
    scripts\mp\utility::printgameaction("exploding drone exploded", var_01);
    self setscriptablepartstate("explode", "active", 0);
    var_02 = 0.1;
  } else {
    self setscriptablepartstate("destroySmoke", "active", 0);
    var_02 = 0.1;
  }

  thread func_69BF(var_02);
}

func_69C2(param_00) {
  var_01 = self.triggerportableradarping;
  if(!isDefined(param_00)) {
    param_00 = var_01;
  }

  explodingdrone_awardpointsfordeath(param_00, var_01);
  if(!self.issmokeversion) {
    scripts\mp\utility::printgameaction("exploding drone destroyed", var_01);
  }

  self _meth_8593();
  self setscriptablepartstate("beacon", "neutral", 0);
  self setscriptablepartstate("primaryThruster", "neutral", 0);
  self setscriptablepartstate("secondaryThrusters", "neutral", 0);
  if(!self.issmokeversion) {
    self setscriptablepartstate("destroy", "active", 0);
  } else {
    self setscriptablepartstate("destroySmoke", "active", 0);
  }

  thread func_69BF(0.1);
}

func_69BF(param_00) {
  self notify("death");
  self.exploding = 1;
  self forcehidegrenadehudwarning(1);
  self setCanDamage(0);
  wait(param_00);
  self delete();
}

explodingdrone_transform() {
  scripts\mp\utility::_launchgrenade(scripts\engine\utility::ter_op(self.issmokeversion, "power_smoke_drone_transform_mp", "power_exploding_drone_transform_mp"), self.origin, (0, 0, 0), 100, 1, self);
  thread explodingdrone_transforminternal();
}

explodingdrone_transforminternal() {
  self endon("death");
  self forcehidegrenadehudwarning(1);
  var_00 = 1 - gettime() - self.throwtime / 1000;
  if(self.issmokeversion) {
    var_00 = var_00 + 0.1;
  }

  wait(var_00);
  self forcehidegrenadehudwarning(0);
}

func_69D2() {
  self endon("death");
  if(!self.issmokeversion) {
    self setscriptablepartstate("transform", "active", 0);
  } else {
    self setscriptablepartstate("transformSmoke", "active", 0);
  }

  wait(0.4);
  self setscriptablepartstate("primaryThruster", "active", 0);
  wait(0.25);
  self setscriptablepartstate("secondaryThrusters", "active", 0);
  wait(0.4);
  if(!self.issmokeversion) {
    self setscriptablepartstate("beacon", "active", 0);
    return;
  }

  self setscriptablepartstate("smoke", "active", 0);
}

func_69C5() {
  self endon("death");
  self endon("exploding_drone_transform");
  self.triggerportableradarping endon("disconnect");
  self waittill("missile_stuck", var_00, var_01);
  self notify("exploding_drone_stuck");
  var_02 = isDefined(var_01) && var_01 == "tag_flicker";
  var_03 = isDefined(var_01) && var_01 == "tag_weapon";
  if(!self.issmokeversion) {
    if(isDefined(var_00) && isplayer(var_00) || isagent(var_00) && !var_03 && !var_02) {
      if(scripts\mp\equipment\phase_shift::areentitiesinphase(var_00, self)) {
        var_00 dodamage(35, self.origin, self.triggerportableradarping, self, "MOD_IMPACT", scripts\engine\utility::ter_op(self.issmokeversion, "power_smoke_drone_mp", "power_exploding_drone_mp"));
      }
    }
  }

  explodingdrone_transform();
  thread func_69C2();
  self delete();
}

func_69D1() {
  self endon("death");
  self endon("exploding_drone_stuck");
  self.triggerportableradarping endon("disconnect");
  var_00 = self.triggerportableradarping;
  self setentityowner(var_00);
  self setotherent(var_00);
  var_01 = anglesToForward(var_00 getgunangles());
  var_02 = var_00 getEye() + var_01 * 2500;
  var_03 = scripts\engine\utility::ter_op(self.issmokeversion, 0.1, 0.2);
  wait(var_03);
  self notify("exploding_drone_transform");
  var_04 = self.origin;
  var_05 = self.angles;
  explodingdrone_transform();
  self.origin = var_04;
  self.angles = var_05;
  self setentityowner(var_00);
  self setotherent(var_00);
  var_00 func_69BC(self);
  thread func_69D2();
  var_06 = var_00 scripts\mp\utility::_hasperk("specialty_rugged_eqp");
  if(var_06) {
    self.hasruggedeqp = 1;
  }

  var_07 = scripts\engine\utility::ter_op(var_06, 57, 38);
  var_08 = scripts\engine\utility::ter_op(var_06, "hitequip", "");
  thread scripts\mp\damage::monitordamage(var_07, var_08, ::func_69CA, ::explodingdrone_handledamage, 0, 0);
  self missilethermal();
  self missileoutline();
  if(!self.issmokeversion) {
    scripts\mp\sentientpoolmanager::registersentient("Lethal_Moving", var_00, 1);
  }

  thread func_69C9(var_02);
  thread func_69C3();
  thread func_69C4();
  thread scripts\mp\perks\_perk_equipmentping::runequipmentping();
  thread scripts\mp\weapons::outlineequipmentforowner(self, var_00);
  var_09 = scripts\engine\utility::spawn_tag_origin();
  var_09 thread func_69C1(self);
  self linkto(var_09);
  var_0A = 4;
  if(self.issmokeversion) {
    if(issubstr(var_00 getcurrentweapon(), "iw7_unsalmg_mpl")) {
      var_0A = 10;
    } else {
      var_0A = 6;
    }
  }

  var_09 moveto(var_02, var_0A, 3, 0);
  wait(var_0A);
  thread func_69C8();
}

func_69C9(param_00) {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  var_01 = vectornormalize(param_00 - self.origin);
  var_02 = scripts\common\trace::create_contents(1, 1, 1, 0, 1, 1, 0);
  for(;;) {
    if(physics_spherecast(self.origin, self.origin + var_01 * 12, 6, var_02, [self, self.triggerportableradarping], "physicsquery_any")) {
      thread func_69C8();
    }

    scripts\engine\utility::waitframe();
  }
}

func_69C3() {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  self waittill("emp_damage", var_00, var_01, var_02, var_03, var_04);
  if(isDefined(var_03) && var_03 == "emp_grenade_mp") {
    if(scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.triggerportableradarping, var_00))) {
      var_00 scripts\mp\missions::func_D991("ch_tactical_emp_eqp");
    }
  }

  explodingdrone_givedamagefeedback(var_00);
  thread func_69C2(var_00);
}

func_69C4() {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  level scripts\engine\utility::waittill_any_3("game_ended", "bro_shot_start");
  thread func_69C2();
}

explodingdrone_validdetonationstate() {
  if(!scripts\mp\utility::isreallyalive(self)) {
    return 0;
  }

  if(scripts\mp\utility::isusingremote()) {
    return 0;
  }

  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(self)) {
    return 0;
  }

  if(isusingreaper()) {
    return 0;
  }

  if(self _meth_84CA()) {
    return 0;
  }

  if(self _meth_8568()) {
    return 0;
  }

  return 1;
}

func_69BD() {
  return gettime() - self.throwtime / 1000 > 0.3;
}

func_69CD() {
  self endon("death");
  self endon("disconnect");
  self endon("exploding_drone_unset");
  level endon("game_ended");
  self notify("explodingDrone_listenForDetonate");
  self endon("explodingDrone_listenForDetonate");
  for(;;) {
    self waittillmatch("power_exploding_drone_mp", "detonate");
    if(explodingdrone_validdetonationstate()) {
      func_69C7();
    }
  }
}

func_69CC() {
  self endon("death");
  self endon("disconnect");
  self endon("exploding_drone_unset");
  level endon("game_ended");
  self notify("explodingDrone_listenForAltDetonate");
  self endon("explodingDrone_listenForAltDetonate");
  var_00 = 0;
  for(;;) {
    if(self usebuttonpressed()) {
      var_00 = 0;
      while(self usebuttonpressed()) {
        var_00 = var_00 + 0.05;
        wait(0.05);
      }

      if(var_00 >= 0.5) {
        continue;
      }

      var_00 = 0;
      while(!self usebuttonpressed() && var_00 < 0.5) {
        var_00 = var_00 + 0.05;
        wait(0.05);
      }

      if(var_00 >= 0.5) {
        continue;
      }

      if(!scripts\mp\equipment\phase_shift::isentityphaseshifted(self) && !scripts\mp\utility::isusingremote()) {
        func_69C7();
      }
    }

    wait(0.05);
  }
}

func_69C7() {
  if(!isDefined(self.var_D38B)) {
    return;
  }

  foreach(var_01 in self.var_D38B) {
    if(var_01 func_69BD()) {
      var_01 thread func_69C6();
    }
  }
}

func_69BC(param_00) {
  if(!isDefined(self.var_D38B)) {
    self.var_D38B = [];
  }

  if(!isDefined(level.var_69D6)) {
    level.var_69D6 = [];
  }

  var_01 = param_00 getentitynumber();
  if(!isDefined(self.var_D38B[var_01])) {
    self.var_D38B[var_01] = param_00;
  }

  if(!isDefined(level.var_69D6[var_01])) {
    level.var_69D6[var_01] = param_00;
  }

  thread func_69CF(param_00);
}

func_69CE(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = param_00 getentitynumber();
  }

  if(isDefined(self) && isDefined(self.var_D38B)) {
    self.var_D38B[param_01] = undefined;
  }

  if(isDefined(level.var_69D6)) {
    level.var_69D6[param_01] = undefined;
  }
}

func_69CF(param_00) {
  var_01 = param_00 getentitynumber();
  param_00 waittill("death");
  func_69CE(param_00, var_01);
}

isexplodingdrone() {
  var_00 = self getentitynumber();
  var_01 = level.var_69D6[var_00];
  return isDefined(var_01) && var_01 == self;
}

explodingdrone_givedamagefeedback(param_00) {
  var_01 = "";
  if(scripts\mp\utility::istrue(self.hasruggedeqp)) {
    var_01 = "hitequip";
  }

  if(isplayer(param_00)) {
    param_00 scripts\mp\damagefeedback::updatedamagefeedback(var_01);
  }
}

explodingdrone_awardpointsfordeath(param_00, param_01) {
  if(scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(param_01, param_00))) {
    self setentityowner(param_00);
    param_00 notify("destroyed_equipment");
    if(!self.issmokeversion) {
      param_00 notify("killed_exploding_drone", param_01);
    }

    param_00 thread scripts\mp\utility::giveunifiedpoints("destroyed_equipment");
  }
}

explodingdrone_makedamageimmune(param_00) {
  if(!isDefined(self.entsimmune)) {
    self.entsimmune = [];
  }

  self.entsimmune[param_00 getentitynumber()] = param_00;
}

explodingdrone_isdamageimmune(param_00) {
  if(!isexplodingdrone()) {
    return 0;
  }

  if(!isDefined(self.entsimmune)) {
    return 0;
  }

  return isDefined(self.entsimmune[param_00 getentitynumber()]);
}

explodingdrone_modifieddamage(param_00, param_01, param_02, param_03, param_04) {
  if(isDefined(param_00) && isDefined(param_03)) {
    if(param_03 explodingdrone_isdamageimmune(param_01)) {
      param_04 = 0;
    }
  }

  return param_04;
}

explodingdrone_handledamage(param_00, param_01, param_02, param_03, param_04) {
  if(!scripts\mp\equipment\phase_shift::areentitiesinphase(param_00, self)) {
    return 0;
  }

  if(scripts\engine\utility::isbulletdamage(param_02)) {
    if(isDefined(param_01)) {
      var_05 = getweaponbasename(param_01);
      switch (var_05) {
        case "iw7_steeldragon_mp":
          param_03 = param_03 * 3;
          break;

        case "micro_turret_gun_mp":
          param_03 = param_03 * 2;
          break;

        default:
          var_06 = 1;
          if(param_03 >= scripts\mp\weapons::minegettwohitthreshold()) {
            var_06 = var_06 + 1;
          }

          if(scripts\mp\utility::isfmjdamage(param_01, param_02)) {
            var_06 = var_06 * 2;
          }
          param_03 = var_06 * 19;
          break;
      }
    }
  }

  scripts\mp\powers::equipmenthit(self.triggerportableradarping, param_00, param_01, param_02);
  return param_03;
}

func_69CA(param_00, param_01, param_02, param_03) {
  self.damagedby = param_00;
  thread func_69C8(param_00);
}

func_69C0() {
  self endon("death");
  self.triggerportableradarping waittill("disconnect");
  self delete();
}

func_69C1(param_00) {
  self endon("death");
  param_00 waittill("death");
  self delete();
}

isusingreaper() {
  if(!isplayer(self)) {
    return 0;
  }

  if(!scripts\mp\utility::isreallyalive(self)) {
    return 0;
  }

  if(isDefined(self.super)) {
    var_00 = self.super.staticdata.ref;
    if(!isDefined(var_00) || var_00 != "super_reaper") {
      return 0;
    }

    return scripts\mp\utility::istrue(self.super.isinuse);
  }

  return 0;
}