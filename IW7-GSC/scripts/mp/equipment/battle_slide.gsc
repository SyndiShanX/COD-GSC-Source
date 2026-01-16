/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
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
    scripts\engine\utility::waittill_any_timeout(0.45, "sprint_slide_end");
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
    var_0 = self getvelocity();
    var_1 = lengthsquared(var_0);
    var_2 = anglestoup(self.angles);
    var_3 = anglesToForward(self.angles);
    var_4 = (0, 0, 0);
    var_5 = (0, 0, 0);
    var_6 = var_4;
    var_7 = var_5;
    var_8 = scripts\common\trace::create_contents(0, 1, 1, 0, 1, 0);
    if(var_1 > 100) {
      var_9 = vectortoangles(var_0);
      var_3 = anglesToForward(var_9);
      var_2 = anglestoup(var_9);
      var_4 = var_3 * 40;
      var_5 = var_2 * -20;
      var_6 = var_4;
      var_7 = var_5 + var_2 * 38;
      var_10 = physics_raycast(self getEye(), self.origin + var_4 + var_7, var_8, undefined, 0, "physicsquery_closest");
      if(isDefined(var_10) && var_10.size > 0) {
        var_4 = var_3 * vectordot(var_10[0]["position"] - self.origin, var_3);
        var_4 = var_4 - var_3 * 3;
        var_6 = var_4;
      }
    }

    var_11 = undefined;
    if(level.teambased) {
      var_11 = scripts\mp\utility::getteamarray(scripts\mp\utility::getotherteam(self.team));
    } else {
      var_11 = level.characters;
    }

    foreach(var_13 in var_11) {
      if(!isDefined(var_13) || var_13 == self || !scripts\mp\utility::isreallyalive(var_13)) {
        continue;
      }

      if(func_28EA(var_13)) {
        continue;
      }

      if(!scripts\mp\utility::func_D64A(5184, 76, self.origin + var_4 + var_5, var_2, var_13 gettagorigin("j_mainroot"))) {
        continue;
      }

      if(func_28E8(var_13, var_3)) {
        continue;
      }

      if(func_28E9(var_13, self.origin + var_6)) {
        continue;
      }

      if(func_28E7(var_13, self.origin + var_6 + var_7, var_8)) {
        continue;
      }

      func_28F5(var_13);
      func_28E3(var_13);
      if(scripts\mp\utility::isreallyalive(var_13)) {
        func_28EB(var_13, var_3);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_28EE(var_0) {
  var_1 = var_0 getentitynumber();
  self endon("death");
  self endon("disconnect");
  self endon("battleSlide_monitorKnockbackEnded_" + var_1);
  scripts\mp\utility::_enablecollisionnotifies(1);
  scripts\engine\utility::allow_doublejump(0);
  thread func_28EF(var_0);
  for(;;) {
    self waittill("collided", var_2, var_3, var_4, var_5, var_6);
    if(var_6 != "hittype_world") {
      continue;
    }

    var_2 = (var_2[0], var_2[1], max(0, var_2[2]));
    var_7 = -1 * vectordot(var_2, var_4);
    if(var_7 < 185) {
      continue;
    }

    if(isDefined(var_0)) {
      self dodamage(35, var_3, var_0, undefined, "MOD_IMPACT", "battleslide_mp");
    }

    break;
  }

  scripts\engine\utility::allow_doublejump(1);
  scripts\mp\utility::_enablecollisionnotifies(0);
  self notify("battleSlide_monitorKnockbackEnded_" + var_0 getentitynumber());
}

func_28EF(var_0) {
  var_1 = var_0 getentitynumber();
  self endon("death");
  self endon("disconnect");
  self endon("battleSlide_monitorKnockbackEnded_" + var_1);
  wait(0.35);
  scripts\engine\utility::allow_doublejump(1);
  scripts\mp\utility::_enablecollisionnotifies(0);
  self notify("battleSlide_monitorKnockbackEnded_" + var_1);
}

func_28F5(var_0) {
  if(!isDefined(self.var_28F7)) {
    self.var_28F7 = [];
  }

  if(!func_28EA(var_0)) {
    self.var_28F7[self.var_28F7.size] = var_0 getentitynumber();
    return 1;
  }

  return 0;
}

func_28E3(var_0) {
  var_1 = 65;
  if(scripts\mp\utility::_hasperk("specialty_battleslide_offense")) {
    var_1 = scripts\mp\perks\perkfunctions::getbattleslideoffensedamage();
  }

  if(var_1 >= self.health) {
    self.customdeath = 1;
    thread func_28F0(var_0);
  }

  var_0 dodamage(var_1, self.origin, self, self, "MOD_IMPACT", "battleslide_mp");
  thread func_28E4(var_0);
}

func_28EB(var_0, var_1) {
  var_2 = var_0.origin - self.origin;
  var_3 = length(var_2);
  if(var_3 != 0) {
    var_4 = var_2 / var_3;
    var_5 = var_0 getvelocity();
    var_5 = var_5 - var_4 * vectordot(var_5, var_4);
    var_5 = var_5 + var_4 * 400;
    var_5 = var_5 + (0, 0, 225);
    var_0 setvelocity(var_5);
    var_0 shellshock("battleslide_mp", 1.5);
  }

  var_0 thread func_28EE(self);
}

func_28E8(var_0, var_1) {
  return vectordot(var_1, var_0.origin - self.origin) < 0;
}

func_28E7(var_0, var_1, var_2) {
  var_3 = physics_raycast(var_1, var_0 gettagorigin("j_mainroot"), var_2, undefined, 0, "physicsquery_closest");
  if(isDefined(var_3) && var_3.size > 0) {
    return 1;
  }

  return 0;
}

func_28E9(var_0, var_1) {
  if(isDefined(var_0.hasriotshield) && var_0.hasriotshield) {
    var_2 = var_1 - var_0.origin;
    var_3 = vectornormalize((var_2[0], var_2[1], 0));
    var_4 = anglesToForward(var_0.angles);
    var_5 = vectordot(var_4, var_2);
    if(var_0.hasriotshieldequipped) {
      if(var_5 > 0.766) {
        return 1;
      }
    } else if(var_5 < -0.766) {
      return 1;
    }
  }

  return 0;
}

func_28EA(var_0) {
  if(!isDefined(self.var_28F7)) {
    return 0;
  }

  var_1 = var_0 getentitynumber();
  return scripts\engine\utility::array_contains(self.var_28F7, var_1);
}

func_28E6(var_0) {
  return isDefined(var_0.var_28E6);
}

func_28E4(var_0) {
  self playrumbleonentity("artillery_rumble");
  var_0 playrumbleonentity("artillery_rumble");
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
  var_0 = 0;
  var_1 = 5;
  while(var_1 > var_0) {
    if(isplayer(self)) {
      var_2 = spawnfxforclient(level.var_28C9, self getEye(), self);
      thread func_28F4(var_2, 0.1);
      triggerfx(var_2);
    }

    earthquake(0.2, 0.25, self.origin, 144);
    var_0++;
    scripts\engine\utility::waitframe();
  }
}

func_28F4(var_0, var_1) {
  wait(var_1);
  if(isDefined(var_0)) {
    var_0 delete();
  }
}

func_28F0(var_0) {
  var_0 endon("disconnect");
  var_1 = self.origin;
  self waittill("start_instant_ragdoll");
  wait(0.1);
  physicsexplosionsphere(var_1, 92, 72, 2.5);
}