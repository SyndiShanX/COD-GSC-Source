/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\equipment\battle_slide.gsc
*************************************************/

func_28F2() {
  level.var_28C9 = loadfx("vfx\core\mp\core\vfx_battle_slide_camera");
  thread func_28EC();
}

func_28F6() {
  self notify("battleSlide_unset");
  func_28E5();
}

func_28EC() {
  self endon("death");
  self endon("disconnect");
  self endon("battleSlide_unset");
  for(;;) {
    self waittill("sprint_slide_begin");
    func_28E2();
    scripts\engine\utility::waittill_any_timeout_1(0.45, "sprint_slide_end");
    thread func_28E5();
  }
}

func_28E2() {
  self.var_28E1 = 1;
  self.var_28F7 = [];
  thread func_28F3();
  thread func_28ED();
}

func_28E5() {
  self notify("battleSlide_end");
  self.var_28E1 = undefined;
  self.var_28F7 = undefined;
}

func_28ED() {
  self endon("death");
  self endon("disconnect");
  self endon("battleSlide_end");
  for(;;) {
    var_00 = self getvelocity();
    var_01 = lengthsquared(var_00);
    var_02 = anglestoup(self.angles);
    var_03 = anglesToForward(self.angles);
    var_04 = (0, 0, 0);
    var_05 = (0, 0, 0);
    var_06 = var_04;
    var_07 = var_05;
    var_08 = scripts\common\trace::create_contents(0, 1, 1, 0, 1, 0);
    if(var_01 > 100) {
      var_09 = vectortoangles(var_00);
      var_03 = anglesToForward(var_09);
      var_02 = anglestoup(var_09);
      var_04 = var_03 * 40;
      var_05 = var_02 * -20;
      var_06 = var_04;
      var_07 = var_05 + var_02 * 38;
      var_0A = physics_raycast(self getEye(), self.origin + var_04 + var_07, var_08, undefined, 0, "physicsquery_closest");
      if(isDefined(var_0A) && var_0A.size > 0) {
        var_04 = var_03 * vectordot(var_0A[0]["position"] - self.origin, var_03);
        var_04 = var_04 - var_03 * 3;
        var_06 = var_04;
      }
    }

    var_0B = undefined;
    if(level.teambased) {
      var_0B = scripts\mp\utility::getteamarray(scripts\mp\utility::getotherteam(self.team));
    } else {
      var_0B = level.characters;
    }

    foreach(var_0D in var_0B) {
      if(!isDefined(var_0D) || var_0D == self || !scripts\mp\utility::isreallyalive(var_0D)) {
        continue;
      }

      if(func_28EA(var_0D)) {
        continue;
      }

      if(!scripts\mp\utility::func_D64A(5184, 76, self.origin + var_04 + var_05, var_02, var_0D gettagorigin("j_mainroot"))) {
        continue;
      }

      if(func_28E8(var_0D, var_03)) {
        continue;
      }

      if(func_28E9(var_0D, self.origin + var_06)) {
        continue;
      }

      if(func_28E7(var_0D, self.origin + var_06 + var_07, var_08)) {
        continue;
      }

      func_28F5(var_0D);
      func_28E3(var_0D);
      if(scripts\mp\utility::isreallyalive(var_0D)) {
        func_28EB(var_0D, var_03);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_28EE(param_00) {
  var_01 = param_00 getentitynumber();
  self endon("death");
  self endon("disconnect");
  self endon("battleSlide_monitorKnockbackEnded_" + var_01);
  scripts\mp\utility::_enablecollisionnotifies(1);
  scripts\engine\utility::allow_doublejump(0);
  thread func_28EF(param_00);
  for(;;) {
    self waittill("collided", var_02, var_03, var_04, var_05, var_06);
    if(var_06 != "hittype_world") {
      continue;
    }

    var_02 = (var_02[0], var_02[1], max(0, var_02[2]));
    var_07 = -1 * vectordot(var_02, var_04);
    if(var_07 < 185) {
      continue;
    }

    if(isDefined(param_00)) {
      self dodamage(35, var_03, param_00, undefined, "MOD_IMPACT", "battleslide_mp");
    }

    break;
  }

  scripts\engine\utility::allow_doublejump(1);
  scripts\mp\utility::_enablecollisionnotifies(0);
  self notify("battleSlide_monitorKnockbackEnded_" + param_00 getentitynumber());
}

func_28EF(param_00) {
  var_01 = param_00 getentitynumber();
  self endon("death");
  self endon("disconnect");
  self endon("battleSlide_monitorKnockbackEnded_" + var_01);
  wait(0.35);
  scripts\engine\utility::allow_doublejump(1);
  scripts\mp\utility::_enablecollisionnotifies(0);
  self notify("battleSlide_monitorKnockbackEnded_" + var_01);
}

func_28F5(param_00) {
  if(!isDefined(self.var_28F7)) {
    self.var_28F7 = [];
  }

  if(!func_28EA(param_00)) {
    self.var_28F7[self.var_28F7.size] = param_00 getentitynumber();
    return 1;
  }

  return 0;
}

func_28E3(param_00) {
  var_01 = 65;
  if(scripts\mp\utility::_hasperk("specialty_battleslide_offense")) {
    var_01 = scripts\mp\perks\_perkfunctions::getbattleslideoffensedamage();
  }

  if(var_01 >= self.health) {
    self.customdeath = 1;
    thread func_28F0(param_00);
  }

  param_00 dodamage(var_01, self.origin, self, self, "MOD_IMPACT", "battleslide_mp");
  thread func_28E4(param_00);
}

func_28EB(param_00, param_01) {
  var_02 = param_00.origin - self.origin;
  var_03 = length(var_02);
  if(var_03 != 0) {
    var_04 = var_02 / var_03;
    var_05 = param_00 getvelocity();
    var_05 = var_05 - var_04 * vectordot(var_05, var_04);
    var_05 = var_05 + var_04 * 400;
    var_05 = var_05 + (0, 0, 225);
    param_00 setvelocity(var_05);
    param_00 shellshock("battleslide_mp", 1.5);
  }

  param_00 thread func_28EE(self);
}

func_28E8(param_00, param_01) {
  return vectordot(param_01, param_00.origin - self.origin) < 0;
}

func_28E7(param_00, param_01, param_02) {
  var_03 = physics_raycast(param_01, param_00 gettagorigin("j_mainroot"), param_02, undefined, 0, "physicsquery_closest");
  if(isDefined(var_03) && var_03.size > 0) {
    return 1;
  }

  return 0;
}

func_28E9(param_00, param_01) {
  if(isDefined(param_00.hasriotshield) && param_00.hasriotshield) {
    var_02 = param_01 - param_00.origin;
    var_03 = vectornormalize((var_02[0], var_02[1], 0));
    var_04 = anglesToForward(param_00.angles);
    var_05 = vectordot(var_04, var_02);
    if(param_00.hasriotshieldequipped) {
      if(var_05 > 0.766) {
        return 1;
      }
    } else if(var_05 < -0.766) {
      return 1;
    }
  }

  return 0;
}

func_28EA(param_00) {
  if(!isDefined(self.var_28F7)) {
    return 0;
  }

  var_01 = param_00 getentitynumber();
  return scripts\engine\utility::array_contains(self.var_28F7, var_01);
}

func_28E6(param_00) {
  return isDefined(param_00.var_28E6);
}

func_28E4(param_00) {
  self playrumbleonentity("artillery_rumble");
  param_00 playrumbleonentity("artillery_rumble");
  playrumbleonposition("slide_collision", self.origin);
  earthquake(0.5, 0.5, self.origin, 144);
  playsoundatpos(self.origin, "slide_impact");
  self setclientomnvar("ui_hud_shake", 1);
  scripts\mp\damagefeedback::updatedamagefeedback("hitcritical");
}

func_28F3() {
  self endon("death");
  self endon("disconnect");
  self endon("sprint_slide_end");
  self playlocalsound("melee_boost");
  self playsoundonmovingent("melee_boost_npc");
  var_00 = 0;
  var_01 = 5;
  while(var_01 > var_00) {
    if(isplayer(self)) {
      var_02 = spawnfxforclient(level.var_28C9, self getEye(), self);
      thread func_28F4(var_02, 0.1);
      triggerfx(var_02);
    }

    earthquake(0.2, 0.25, self.origin, 144);
    var_00++;
    scripts\engine\utility::waitframe();
  }
}

func_28F4(param_00, param_01) {
  wait(param_01);
  if(isDefined(param_00)) {
    param_00 delete();
  }
}

func_28F0(param_00) {
  param_00 endon("disconnect");
  var_01 = self.origin;
  self waittill("start_instant_ragdoll");
  wait(0.1);
  physicsexplosionsphere(var_01, 92, 72, 2.5);
}