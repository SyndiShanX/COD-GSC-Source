/****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\equipment\exploding_drone.gsc
****************************************************/

func_69D5() {
  level.var_69D6 = [];
}

func_69D0(var_0) {
  thread func_69CC();
}

func_69D3() {
  self notify("exploding_drone_unset");
  self.var_D38B = undefined;
}

func_69D4(var_0, var_1) {
  var_1 = scripts\mp\utility::istrue(var_1);
  var_0.issmokeversion = var_1;
  var_0.throwtime = gettime();
  if(!var_1) {
    thread func_69CD();
    thread func_69CC();
    scripts\mp\utility::printgameaction("exploding drone spawn", var_0.triggerportableradarping);
  } else if(scripts\mp\equipment\phase_shift::isentityphaseshifted(self)) {
    return;
  }

  var_0 thread func_69C5();
  var_0 thread func_69D1();
  var_0 thread func_69C0();
}

func_69C6() {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  wait(0.1);
  thread func_69C8(self.triggerportableradarping);
}

func_69C8(var_0) {
  var_1 = self.triggerportableradarping;
  if(!isDefined(var_0)) {
    var_0 = var_1;
  }

  explodingdrone_awardpointsfordeath(var_0, var_1);
  self func_8593();
  self setscriptablepartstate("beacon", "neutral", 0);
  self setscriptablepartstate("primaryThruster", "neutral", 0);
  self setscriptablepartstate("secondaryThrusters", "neutral", 0);
  var_2 = undefined;
  if(!self.issmokeversion) {
    scripts\mp\utility::printgameaction("exploding drone exploded", var_1);
    self setscriptablepartstate("explode", "active", 0);
    var_2 = 0.1;
  } else {
    self setscriptablepartstate("destroySmoke", "active", 0);
    var_2 = 0.1;
  }

  thread func_69BF(var_2);
}

func_69C2(var_0) {
  var_1 = self.triggerportableradarping;
  if(!isDefined(var_0)) {
    var_0 = var_1;
  }

  explodingdrone_awardpointsfordeath(var_0, var_1);
  if(!self.issmokeversion) {
    scripts\mp\utility::printgameaction("exploding drone destroyed", var_1);
  }

  self func_8593();
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

func_69BF(var_0) {
  self notify("death");
  self.exploding = 1;
  self forcehidegrenadehudwarning(1);
  self setCanDamage(0);
  wait(var_0);
  self delete();
}

explodingdrone_transform() {
  scripts\mp\utility::_launchgrenade(scripts\engine\utility::ter_op(self.issmokeversion, "power_smoke_drone_transform_mp", "power_exploding_drone_transform_mp"), self.origin, (0, 0, 0), 100, 1, self);
  thread explodingdrone_transforminternal();
}

explodingdrone_transforminternal() {
  self endon("death");
  self forcehidegrenadehudwarning(1);
  var_0 = 1 - gettime() - self.throwtime / 1000;
  if(self.issmokeversion) {
    var_0 = var_0 + 0.1;
  }

  wait(var_0);
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
  self waittill("missile_stuck", var_0, var_1);
  self notify("exploding_drone_stuck");
  var_2 = isDefined(var_1) && var_1 == "tag_flicker";
  var_3 = isDefined(var_1) && var_1 == "tag_weapon";
  if(!self.issmokeversion) {
    if(isDefined(var_0) && isplayer(var_0) || isagent(var_0) && !var_3 && !var_2) {
      if(scripts\mp\equipment\phase_shift::areentitiesinphase(var_0, self)) {
        var_0 dodamage(35, self.origin, self.triggerportableradarping, self, "MOD_IMPACT", scripts\engine\utility::ter_op(self.issmokeversion, "power_smoke_drone_mp", "power_exploding_drone_mp"));
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
  var_0 = self.triggerportableradarping;
  self setentityowner(var_0);
  self setotherent(var_0);
  var_1 = anglesToForward(var_0 getgunangles());
  var_2 = var_0 getEye() + var_1 * 2500;
  var_3 = scripts\engine\utility::ter_op(self.issmokeversion, 0.1, 0.2);
  wait(var_3);
  self notify("exploding_drone_transform");
  var_4 = self.origin;
  var_5 = self.angles;
  explodingdrone_transform();
  self.origin = var_4;
  self.angles = var_5;
  self setentityowner(var_0);
  self setotherent(var_0);
  var_0 func_69BC(self);
  thread func_69D2();
  var_6 = var_0 scripts\mp\utility::_hasperk("specialty_rugged_eqp");
  if(var_6) {
    self.hasruggedeqp = 1;
  }

  var_7 = scripts\engine\utility::ter_op(var_6, 57, 38);
  var_8 = scripts\engine\utility::ter_op(var_6, "hitequip", "");
  thread scripts\mp\damage::monitordamage(var_7, var_8, ::func_69CA, ::explodingdrone_handledamage, 0, 0);
  self missilethermal();
  self missileoutline();
  if(!self.issmokeversion) {
    scripts\mp\sentientpoolmanager::registersentient("Lethal_Moving", var_0, 1);
  }

  thread func_69C9(var_2);
  thread func_69C3();
  thread func_69C4();
  thread scripts\mp\perks\_perk_equipmentping::runequipmentping();
  thread scripts\mp\weapons::outlineequipmentforowner(self, var_0);
  var_9 = scripts\engine\utility::spawn_tag_origin();
  var_9 thread func_69C1(self);
  self linkto(var_9);
  var_0A = 4;
  if(self.issmokeversion) {
    if(issubstr(var_0 getcurrentweapon(), "iw7_unsalmg_mpl")) {
      var_0A = 10;
    } else {
      var_0A = 6;
    }
  }

  var_9 moveto(var_2, var_0A, 3, 0);
  wait(var_0A);
  thread func_69C8();
}

func_69C9(var_0) {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  var_1 = vectornormalize(var_0 - self.origin);
  var_2 = scripts\common\trace::create_contents(1, 1, 1, 0, 1, 1, 0);
  for(;;) {
    if(physics_spherecast(self.origin, self.origin + var_1 * 12, 6, var_2, [self, self.triggerportableradarping], "physicsquery_any")) {
      thread func_69C8();
    }

    scripts\engine\utility::waitframe();
  }
}

func_69C3() {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  self waittill("emp_damage", var_0, var_1, var_2, var_3, var_4);
  if(isDefined(var_3) && var_3 == "emp_grenade_mp") {
    if(scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.triggerportableradarping, var_0))) {
      var_0 scripts\mp\missions::func_D991("ch_tactical_emp_eqp");
    }
  }

  explodingdrone_givedamagefeedback(var_0);
  thread func_69C2(var_0);
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

  if(self func_84CA()) {
    return 0;
  }

  if(self func_8568()) {
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
  var_0 = 0;
  for(;;) {
    if(self usebuttonpressed()) {
      var_0 = 0;
      while(self usebuttonpressed()) {
        var_0 = var_0 + 0.05;
        wait(0.05);
      }

      if(var_0 >= 0.5) {
        continue;
      }

      var_0 = 0;
      while(!self usebuttonpressed() && var_0 < 0.5) {
        var_0 = var_0 + 0.05;
        wait(0.05);
      }

      if(var_0 >= 0.5) {
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

  foreach(var_1 in self.var_D38B) {
    if(var_1 func_69BD()) {
      var_1 thread func_69C6();
    }
  }
}

func_69BC(var_0) {
  if(!isDefined(self.var_D38B)) {
    self.var_D38B = [];
  }

  if(!isDefined(level.var_69D6)) {
    level.var_69D6 = [];
  }

  var_1 = var_0 getentitynumber();
  if(!isDefined(self.var_D38B[var_1])) {
    self.var_D38B[var_1] = var_0;
  }

  if(!isDefined(level.var_69D6[var_1])) {
    level.var_69D6[var_1] = var_0;
  }

  thread func_69CF(var_0);
}

func_69CE(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = var_0 getentitynumber();
  }

  if(isDefined(self) && isDefined(self.var_D38B)) {
    self.var_D38B[var_1] = undefined;
  }

  if(isDefined(level.var_69D6)) {
    level.var_69D6[var_1] = undefined;
  }
}

func_69CF(var_0) {
  var_1 = var_0 getentitynumber();
  var_0 waittill("death");
  func_69CE(var_0, var_1);
}

isexplodingdrone() {
  var_0 = self getentitynumber();
  var_1 = level.var_69D6[var_0];
  return isDefined(var_1) && var_1 == self;
}

explodingdrone_givedamagefeedback(var_0) {
  var_1 = "";
  if(scripts\mp\utility::istrue(self.hasruggedeqp)) {
    var_1 = "hitequip";
  }

  if(isplayer(var_0)) {
    var_0 scripts\mp\damagefeedback::updatedamagefeedback(var_1);
  }
}

explodingdrone_awardpointsfordeath(var_0, var_1) {
  if(scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(var_1, var_0))) {
    self setentityowner(var_0);
    var_0 notify("destroyed_equipment");
    if(!self.issmokeversion) {
      var_0 notify("killed_exploding_drone", var_1);
    }

    var_0 thread scripts\mp\utility::giveunifiedpoints("destroyed_equipment");
  }
}

explodingdrone_makedamageimmune(var_0) {
  if(!isDefined(self.entsimmune)) {
    self.entsimmune = [];
  }

  self.entsimmune[var_0 getentitynumber()] = var_0;
}

explodingdrone_isdamageimmune(var_0) {
  if(!isexplodingdrone()) {
    return 0;
  }

  if(!isDefined(self.entsimmune)) {
    return 0;
  }

  return isDefined(self.entsimmune[var_0 getentitynumber()]);
}

explodingdrone_modifieddamage(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0) && isDefined(var_3)) {
    if(var_3 explodingdrone_isdamageimmune(var_1)) {
      var_4 = 0;
    }
  }

  return var_4;
}

explodingdrone_handledamage(var_0, var_1, var_2, var_3, var_4) {
  if(!scripts\mp\equipment\phase_shift::areentitiesinphase(var_0, self)) {
    return 0;
  }

  if(scripts\engine\utility::isbulletdamage(var_2)) {
    if(isDefined(var_1)) {
      var_5 = getweaponbasename(var_1);
      switch (var_5) {
        case "iw7_steeldragon_mp":
          var_3 = var_3 * 3;
          break;

        case "micro_turret_gun_mp":
          var_3 = var_3 * 2;
          break;

        default:
          var_6 = 1;
          if(var_3 >= scripts\mp\weapons::minegettwohitthreshold()) {
            var_6 = var_6 + 1;
          }

          if(scripts\mp\utility::isfmjdamage(var_1, var_2)) {
            var_6 = var_6 * 2;
          }
          var_3 = var_6 * 19;
          break;
      }
    }
  }

  scripts\mp\powers::equipmenthit(self.triggerportableradarping, var_0, var_1, var_2);
  return var_3;
}

func_69CA(var_0, var_1, var_2, var_3) {
  self.damagedby = var_0;
  thread func_69C8(var_0);
}

func_69C0() {
  self endon("death");
  self.triggerportableradarping waittill("disconnect");
  self delete();
}

func_69C1(var_0) {
  self endon("death");
  var_0 waittill("death");
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
    var_0 = self.super.staticdata.ref;
    if(!isDefined(var_0) || var_0 != "super_reaper") {
      return 0;
    }

    return scripts\mp\utility::istrue(self.super.isinuse);
  }

  return 0;
}