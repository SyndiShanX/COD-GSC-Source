/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitypes\suicidebomber\combat.gsc
***********************************************/

bomber_init(var_0) {
  self.pathenemyfightdist = 0;
  self.pathenemylookahead = 0;
  self.allowstrafe = 0;
  self.a.disablelongdeath = 1;

  if(isagent(self)) {
    self.bombercanexplodebehindtarget = 1;
    self.bomberusegrenade = 0;
    self.domagicdoorchecks = 1;
  } else
    self.bomberusegrenade = 1;

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
  self.bomberexplodeangle = 65.0;
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
  var_1 = undefined;

  if(self tagexists("j_sling_pivot"))
    var_1 = "j_sling_pivot";
  else
    var_1 = "j_cosmetic_4";

  playFXOnTag(scripts\engine\utility::getfx("suicide_bomber_clicker_flash"), self, var_1);
  self attach("offhand_wm_clacker", "tag_accessory_right");

  if(!isDefined(self.repulsorname)) {
    self.repulsorname = "suicideguy " + self getentitynumber();
    createnavrepulsor(self.repulsorname, -1, self, 200, 1, "axis", "allies");
  }

  self setbtgoalRadius(0, 32);
  thread dochants();
  thread expl_dmg_monitor();

  if(scripts\common\utility::issp()) {
    if(level.gameskill < 2)
      self.health = 300;
  }

  return anim.success;
}

expl_dmg_monitor() {
  self endon("death");
  var_0 = 0;

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_3, var_4, var_3, var_3, var_3, var_3, var_5, var_3, var_3, var_3, var_6);

    if(scripts\engine\utility::is_equal(var_2, self)) {
      continue;
    }
    if(isDefined(var_4) && var_1 >= 100 && isexplosivedamagemod(var_4) && !var_0) {
      var_0 = 1;
      self.instantexplode = 1;
      self.explode = 1;

      if(istrue(self.magic_bullet_shield))
        scripts\common\ai::stop_magic_bullet_shield();

      self kill(self.origin, self.lastattacker, self.lastattacker, var_4);
    }
  }
}

dochants() {
  self endon("death");
  var_0 = "dx_vom_aq1_bomber_mantra_";
  var_1 = 10;

  if(!isDefined(self.suicidebomberchants))
    self.suicidebomberchants = 1;

  while(self.suicidebomberchants) {
    var_2 = var_0 + var_1;
    self thread[[anim.callbacks["PlaySoundAtViewHeight"]]](var_2, "sound_done");
    self waittill("sound_done");
    var_1 = var_1 + 10;

    if(var_1 > 30)
      var_1 = 10;

    wait(0.7 + randomfloat(0.7));
  }
}

bomber_gettarget() {
  if(isDefined(self.bombertarget))
    return self.bombertarget;

  return self.enemy;
}

bomber_terminate(var_0) {
  if(isDefined(self.repulsorname)) {
    destroynavrepulsor(self.repulsorname);
    self.repulsorname = undefined;
  }

  return anim.success;
}

bomber_updateeveryframe(var_0) {
  if(istrue(self.domagicdoorchecks))
    scripts\aitypes\common::updateeveryframe_magicdoorchecks();

  var_1 = bomber_gettarget();

  if(isDefined(var_1)) {
    var_2 = distance2dsquared(self.origin, var_1.origin);

    if(isPlayer(var_1) && !istrue(self.bomberplayerseesme)) {
      if(var_2 < squared(300)) {
        if(vectordot(anglesToForward(var_1.angles), self.origin - var_1.origin) > 0)
          self.bomberplayerseesme = 1;

        self.framesclosetotarget++;
      } else if(var_2 < squared(900)) {
        self.framesclosetotarget++;

        if(scripts\engine\utility::within_fov(var_1.origin, var_1.angles, self.origin, cos(45))) {
          if(scripts\engine\trace::ray_trace_passed(var_1 getEye(), self getapproxeyepos(), [self, var_1]))
            self.bomberplayerseesme = 1;
        }
      } else
        self.framesclosetotarget = 0;

      if(self.framesclosetotarget >= self.framescloserequired)
        self.explode = 1;
    }

    if(gettime() > self.bomberraisearmtime) {
      if(distancesquared(self.origin, var_1.origin) < self.bomberraisearmdistsquared) {
        if(!istrue(self.bomberraisearm))
          self.bomberraisearmtime = gettime() + 4000;

        self.bomberraisearm = 1;
      } else {
        if(istrue(self.bomberraisearm))
          self.bomberraisearmtime = gettime() + 4000;

        self.bomberraisearm = 0;
      }
    }

    if(gettime() > self.bomberlookattargettime) {
      if(distancesquared(self.origin, var_1.origin) < self.bomberlookatdistance * self.bomberlookatdistance) {
        if(!istrue(self.bomberlookattarget))
          self.bomberlookattargettime = gettime() + 3000;

        self.bomberlookattarget = 1;
        scripts\common\utility::lookatentity(var_1);
      } else {
        if(!istrue(self.bomberlookattarget))
          self.bomberlookattargettime = gettime() + 1500;

        self.bomberlookattarget = 0;
        scripts\common\utility::lookatentity(undefined);
      }
    }
  }

  return anim.success;
}

bomber_shouldmove(var_0) {
  var_1 = bomber_gettarget();

  if(!isDefined(var_1))
    return anim.failure;

  if(istrue(self.bomberdisablemovebehavior))
    return anim.failure;

  return anim.success;
}

bomber_moveinit(var_0) {
  var_1 = spawnStruct();
  var_1.nextupdatetime = 0;
  self.bt.instancedata[var_0] = var_1;
}

bomber_checktarget(var_0) {
  var_1 = var_0.origin - self.origin;

  if(lengthsquared(var_1) < self.bomberexplodedistance * self.bomberexplodedistance) {
    if(istrue(self.bombercanexplodebehindtarget))
      return 1;
    else {
      var_2 = anglesToForward(self.angles);
      var_3 = acos(clamp(vectordot(var_2, vectorNormalize(var_1)), -1.0, 1.0));

      if(var_3 < self.bomberexplodeangle) {
        if(istrue(self.bomberplayerseesme) || !isPlayer(var_0))
          return 1;
      }
    }
  }

  return 0;
}

bomber_move(var_0) {
  var_1 = bomber_gettarget();

  if(!istrue(self.explode)) {
    var_2 = self.bt.instancedata[var_0];
    var_3 = gettime();

    if(var_3 >= var_2.nextupdatetime) {
      var_2.nextupdatetime = var_3 + 500;
      var_2.targetpos = getclosestpointonnavmesh(var_1.origin);
      self setbtgoalpos(0, var_2.targetpos);
    }

    var_4 = self getposonpath(self.bomberexplodedistance);

    if(bomber_checktarget(var_1))
      self.explode = 1;
    else if(!istrue(self.bomberignoresecondarytargets)) {
      if(isDefined(self.enemy) && var_1 != self.enemy && bomber_checktarget(self.enemy) && distancesquared(self.enemy.origin, var_4) < self.bombersecondaryexplodedistance * self.bombersecondaryexplodedistance)
        self.explode = 1;
      else {
        var_5 = undefined;
        var_6 = -1;
        var_7 = self getsecondarytargets();

        if(isDefined(var_7)) {
          foreach(var_9 in var_7) {
            if(bomber_checktarget(var_9) && distancesquared(var_9.origin, var_4) < self.bombersecondaryexplodedistance * self.bombersecondaryexplodedistance) {
              var_10 = distancesquared(var_9.origin, self.origin);

              if(!isDefined(var_5) || var_10 < var_6) {
                var_5 = var_9;
                var_6 = var_10;
              }
            }
          }
        }

        if(isDefined(var_5))
          self.explode = 1;
      }
    }
  }

  scripts\engine\utility::set_movement_speed(170);
  return anim.running;
}

bomber_moveterminate(var_0) {
  self.bt.instancedata[var_0] = undefined;
  self clearbtgoal(0);
}