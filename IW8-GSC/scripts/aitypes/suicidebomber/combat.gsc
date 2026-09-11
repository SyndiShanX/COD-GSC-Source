/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\suicidebomber\combat.gsc
****************************************************/

function bomber_init(var0) {
  self.pathenemyfightdist = 0;
  self.pathenemylookahead = 0;
  self.allowstrafe = 0;
  self.a.disablelongdeath = 1;

  if(isagent(self)) {
    self.bombercanexplodebehindtarget = 1;
    self.bomberusegrenade = 0;
    self.domagicdoorchecks = 1;
  } else {
    self.bomberusegrenade = 1;
  }

  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self.leftaimlimit = 34;
  self.rightaimlimit = -31;
  self.upaimlimit = -22;
  self.downaimlimit = 26;
  anim.aimyawdifffartolerance = 10;
  anim.aimyawdiffclosedistsq = 4096;
  anim.aimyawdiffclosetolerance = 45;
  anim.aimpitchdifftolerance = 20;
  self enabletraversals(0, "soldier");
  self.skipdetonation = 0;
  self.bomberexplodedistance = 256;
  self.bomberexplodeangle = 65;
  self.bombersecondaryexplodedistance = 100;
  self.bomberraisearmdistsquared = 250000;
  self.bomberraisearmtime = 0;
  self.bomberlookatdistance = 500;
  self.bomberlookattargettime = 0;
  self.bomberlookattarget = 0;
  self.framesclosetotarget = 0;
  self.framescloserequired = 60;
  self.disablebulletwhizbyreaction = 1;
  self.script_group = 1;
  self.nodrop = 1;
  self.a.nodeath = 0;
  var1 = undefined;

  if(self tagexists("j_sling_pivot")) {
    var1 = "j_sling_pivot";
  } else {
    var1 = "j_cosmetic_4";
  }

  playFXOnTag(scripts\engine\utility::getfx("suicide_bomber_clicker_flash"), self, var1);
  self attach("offhand_wm_clacker", "tag_accessory_right");

  if(!isDefined(self.repulsorname)) {
    self.repulsorname = "suicideguy " + self getentitynumber();
    createnavrepulsor(self.repulsorname, -1, self, 200, 1, "axis", "allies");
  }

  self setbtgoalRadius(0, 32);
  thread dochants();
  thread expl_dmg_monitor();

  if(scripts\common\utility::issp()) {
    if(level.gameskill < 2) {
      self.health = 300;
    }
  }

  return anim.success;
}

function expl_dmg_monitor() {
  self endon("death");
  var0 = 0;

  for(;;) {
    self waittill("damage", var1, var2, var3, var3, var4, var3, var3, var3, var3, var5, var3, var3, var3, var6);

    if(scripts\engine\utility::is_equal(var2, self)) {
      continue;
    }

    if(isDefined(var4) && var1 >= 100 && isexplosivedamagemod(var4) && !var0) {
      var0 = 1;
      self.instantexplode = 1;
      self.explode = 1;

      if(istrue(self.magic_bullet_shield)) {
        scripts\common\ai::stop_magic_bullet_shield();
      }

      self kill(self.origin, self.lastattacker, self.lastattacker, var4);
    }
  }
}

function dochants() {
  self endon("death");
  var0 = "dx_vom_aq1_bomber_mantra_";
  var1 = 10;
  jumpiftrue(isDefined(self.suicidebomberchants)) LOC_00000023;
  self.suicidebomberchants = 1;

  while(self.suicidebomberchants) {
    var2 = var0 + var1;
    self thread[[anim.callbacks["PlaySoundAtViewHeight"]]](var2, "sound_done");
    self waittill("sound_done");
    var1 += 10;

    if(var1 > 30) {
      var1 = 10;
    }

    wait 0.7 + randomfloat(0.7);
  }
}

function bomber_gettarget() {
  if(isDefined(self.bombertarget)) {
    return self.bombertarget;
  }

  return self.enemy;
}

function bomber_terminate(var0) {
  if(isDefined(self.repulsorname)) {
    destroynavrepulsor(self.repulsorname);
    self.repulsorname = undefined;
  }

  return anim.success;
}

function bomber_updateeveryframe(var0) {
  if(istrue(self.domagicdoorchecks)) {
    scripts\aitypes\common::updateeveryframe_magicdoorchecks();
  }

  var1 = bomber_gettarget();

  if(isDefined(var1)) {
    var2 = distance2dsquared(self.origin, var1.origin);

    if(isPlayer(var1) && !istrue(self.bomberplayerseesme)) {
      if(var2 < squared(300)) {
        if(vectordot(anglesToForward(var1.angles), self.origin - var1.origin) > 0) {
          self.bomberplayerseesme = 1;
        }

        self.framesclosetotarget++;
      } else if(var2 < squared(900)) {
        self.framesclosetotarget++;

        if(scripts\engine\utility::within_fov(var1.origin, var1.angles, self.origin, cos(45))) {
          if(scripts\engine\trace::ray_trace_passed(var1 getEye(), self getapproxeyepos(), [self, var1])) {
            self.bomberplayerseesme = 1;
          }
        }
      } else {
        self.framesclosetotarget = 0;
      }

      if(self.framesclosetotarget >= self.framescloserequired) {
        self.explode = 1;
      }
    }

    if(gettime() > self.bomberraisearmtime) {
      if(distancesquared(self.origin, var1.origin) < self.bomberraisearmdistsquared) {
        if(!istrue(self.bomberraisearm)) {
          self.bomberraisearmtime = gettime() + 4000;
        }

        self.bomberraisearm = 1;
      } else {
        if(istrue(self.bomberraisearm)) {
          self.bomberraisearmtime = gettime() + 4000;
        }

        self.bomberraisearm = 0;
      }
    }

    if(gettime() > self.bomberlookattargettime) {
      if(distancesquared(self.origin, var1.origin) < self.bomberlookatdistance * self.bomberlookatdistance) {
        if(!istrue(self.bomberlookattarget)) {
          self.bomberlookattargettime = gettime() + 3000;
        }

        self.bomberlookattarget = 1;
        scripts\common\utility::lookatentity(var1);
      } else {
        if(!istrue(self.bomberlookattarget)) {
          self.bomberlookattargettime = gettime() + 1500;
        }

        self.bomberlookattarget = 0;
        scripts\common\utility::lookatentity(undefined);
      }
    }
  }

  return anim.success;
}

function bomber_shouldmove(var0) {
  var1 = bomber_gettarget();

  if(!isDefined(var1)) {
    return anim.failure;
  }

  if(istrue(self.bomberdisablemovebehavior)) {
    return anim.failure;
  }

  return anim.success;
}

function bomber_moveinit(var0) {
  var1 = spawnStruct();
  var1.nextupdatetime = 0;
  self.bt.instancedata[var0] = var1;
}

function bomber_checktarget(var0) {
  var1 = var0.origin - self.origin;

  if(lengthsquared(var1) < self.bomberexplodedistance * self.bomberexplodedistance) {
    if(istrue(self.bombercanexplodebehindtarget)) {
      return true;
    } else {
      var2 = anglesToForward(self.angles);
      var3 = acos(clamp(vectordot(var2, vectorNormalize(var1)), -1, 1));

      if(var3 < self.bomberexplodeangle) {
        if(istrue(self.bomberplayerseesme) || !isPlayer(var0)) {
          return true;
        }
      }
    }
  }

  return false;
}

function bomber_move(var0) {
  var1 = bomber_gettarget();

  if(!istrue(self.explode)) {
    var2 = self.bt.instancedata[var0];
    var3 = gettime();

    if(var3 >= var2.nextupdatetime) {
      var2.nextupdatetime = var3 + 500;
      var2.targetpos = getclosestpointonnavmesh(var1.origin);
      self setbtgoalpos(0, var2.targetpos);
    }

    var4 = self getposonpath(self.bomberexplodedistance);

    if(bomber_checktarget(var1)) {
      self.explode = 1;
    } else if(!istrue(self.bomberignoresecondarytargets)) {
      if(isDefined(self.enemy) && var1 != self.enemy && bomber_checktarget(self.enemy) && distancesquared(self.enemy.origin, var4) < self.bombersecondaryexplodedistance * self.bombersecondaryexplodedistance) {
        self.explode = 1;
      } else {
        var5 = undefined;
        var6 = -1;
        var7 = self getsecondarytargets();

        if(isDefined(var7)) {
          foreach(var9 in var7) {
            if(bomber_checktarget(var9) && distancesquared(var9.origin, var4) < self.bombersecondaryexplodedistance * self.bombersecondaryexplodedistance) {
              var10 = distancesquared(var9.origin, self.origin);

              if(!isDefined(var5) || var10 < var6) {
                var5 = var9;
                var6 = var10;
              }
            }
          }
        }

        if(isDefined(var5)) {
          self.explode = 1;
        }
      }
    }
  }

  scripts\engine\utility::set_movement_speed(170);
  return anim.running;
}

function bomber_moveterminate(var0) {
  self.bt.instancedata[var0] = undefined;
  self clearbtgoal(0);
}