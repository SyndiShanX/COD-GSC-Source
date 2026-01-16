/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\door.gsc
********************************/

doorenterexitcheck() {
  self endon("killanimscript");

  if(isdefined(self.disabledoorbehavior)) {
    return;
  }
  for (;;) {
    var_0 = self getdoorpathnode();

    if(isdefined(var_0)) {
      break;
    }

    wait 0.2;
  }

  var_1 = var_0.type == "Door Interior" || self comparenodedirtopathdir(var_0);

  if(var_1)
    doorenter(var_0);
  else
    doorexit(var_0);

  for (;;) {
    var_2 = self getdoorpathnode();

    if(!isdefined(var_2) || var_2 != var_0) {
      break;
    }

    wait 0.2;
  }

  thread doorenterexitcheck();
}

teamflashbangimmune() {
  self endon("killanimscript");
  self.teamflashbangimmunity = 1;
  wait 5;
  self.teamflashbangimmunity = undefined;
}

#using_animtree("generic_human");

dodoorgrenadethrow(var_0) {
  thread teamflashbangimmune();

  if(self.grenadeweapon == "flash_grenade")
    self notify("flashbang_thrown");

  self orientmode("face current");
  var_0.nextdoorgrenadetime = gettime() + 5000;
  self.minindoortime = gettime() + 100000;
  self notify("move_interrupt");
  self.update_move_anim_type = undefined;
  self clearanim( % combatrun, 0.2);
  self.a.movement = "stop";
  self waittill("done_grenade_throw");
  self orientmode("face default");
  self.minindoortime = gettime() + 5000;
  self.grenadeweapon = self.oldgrenadeweapon;
  self.oldgrenadeweapon = undefined;
  animscripts\run::endfaceenemyaimtracking();
  thread animscripts\move::pathchangelistener();
  thread animscripts\move::restartmoveloop(1);
}

doorenter_trygrenade(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;
  var_6 = 3;
  var_7 = undefined;
  var_7 = % cqb_stand_grenade_throw;
  var_8 = anglestoforward(var_0.angles);

  if(var_0.type == "Door Interior" && !self comparenodedirtopathdir(var_0))
    var_8 = -1 * var_8;

  var_9 = (var_0.origin[0], var_0.origin[1], var_0.origin[2] + 64);
  var_10 = var_9;

  if(var_2) {
    var_11 = anglestoright(var_0.angles);
    var_12 = var_0.origin - self.origin;
    var_13 = vectordot(var_11, var_12);

    if(var_13 > 20)
      var_13 = 20;
    else if(var_13 < -20)
      var_13 = -20;

    var_10 = var_9 + var_13 * var_11;
  }

  while (var_6 > 0) {
    if(isdefined(self.grenade) || !isdefined(self.enemy)) {
      return;
    }
    if(onsamesideofdoor(var_0, var_8)) {
      return;
    }
    if(!self seerecently(self.enemy, 0.2) && self.a.pose == "stand" && distance2dandheightcheck(self.enemy.origin - var_0.origin, 360000, 16384)) {
      if(isdefined(var_0.nextdoorgrenadetime) && var_0.nextdoorgrenadetime > gettime()) {
        return;
      }
      if(self canshootenemy()) {
        return;
      }
      var_12 = var_0.origin - self.origin;

      if(lengthsquared(var_12) < var_3) {
        return;
      }
      if(vectordot(var_12, var_8) < 0) {
        return;
      }
      self.oldgrenadeweapon = self.grenadeweapon;
      self.grenadeweapon = var_1;
      animscripts\combat_utility::setactivegrenadetimer(self.enemy);

      if(!var_5) {
        var_14 = var_9 + var_8 * 100;

        if(!animscripts\combat_utility::isgrenadepossafe(self.enemy, var_14, 128))
          return;
      }

      var_5 = 1;

      if(animscripts\combat_utility::trygrenadethrow(self.enemy, var_10, var_7, animscripts\combat_utility::getgrenadethrowoffset(var_7), 1, 0, 1)) {
        dodoorgrenadethrow(var_0);
        return;
      }
    }

    var_6--;
    wait(var_4);
    var_15 = self getdoorpathnode();

    if(!isdefined(var_15) || var_15 != var_0)
      return;
  }
}

indoorcqbtogglecheck() {
  self endon("killanimscript");

  if(isdefined(self.disabledoorbehavior)) {
    return;
  }
  self.isindoor = 0;

  for (;;) {
    if(self isindoor() && !self.doingambush)
      doorenter_enable_cqbwalk();
    else if(!isdefined(self.minindoortime) || self.minindoortime < gettime()) {
      self.minindoortime = undefined;
      doorexit_disable_cqbwalk();
    }

    wait 0.2;
  }
}

doorenter_enable_cqbwalk() {
  if(!isdefined(self.neverenablecqb) && !self.doingambush) {
    self.isindoor = 1;

    if(!isdefined(self.cqbwalking) || !self.cqbwalking)
      maps\_utility::enable_cqbwalk(1);
  }
}

doorexit_disable_cqbwalk() {
  if(!isdefined(self.cqbenabled)) {
    self.isindoor = 0;

    if(isdefined(self.cqbwalking) && self.cqbwalking)
      maps\_utility::disable_cqbwalk();
  }
}

distance2dandheightcheck(var_0, var_1, var_2) {
  return var_0[0] * var_0[0] + var_0[1] * var_0[1] < var_1 && var_0[2] * var_0[2] < var_2;
}

onsamesideofdoor(var_0, var_1) {
  var_2 = var_0.origin - self.origin;
  var_3 = var_0.origin - self.enemy.origin;
  return vectordot(var_2, var_1) * vectordot(var_3, var_1) > 0;
}

doorenter(var_0) {
  for (;;) {
    if(isdefined(self.doorfragchance) && (self.doorfragchance == 0 || self.doorfragchance < randomfloat(1))) {
      break;
    }

    if(distance2dandheightcheck(self.origin - var_0.origin, 562500, 25600)) {
      doorenter_trygrenade(var_0, "fraggrenade", 0, 302500, 0.3);
      var_0 = self getdoorpathnode();

      if(!isdefined(var_0)) {
        return;
      }
      break;
    }

    wait 0.1;
  }

  for (;;) {
    if(distance2dandheightcheck(self.origin - var_0.origin, 36864, 6400)) {
      doorenter_enable_cqbwalk();
      self.minindoortime = gettime() + 6000;

      if(isdefined(self.doorflashchance) && (self.doorflashchance == 0 || self.doorflashchance < randomfloat(1))) {
        return;
      }
      doorenter_trygrenade(var_0, "flash_grenade", 1, 4096, 0.2);
      return;
    }

    wait 0.1;
  }
}

doorexit(var_0) {
  for (;;) {
    if(!self.isindoor || distancesquared(self.origin, var_0.origin) < 1024) {
      return;
    }
    wait 0.1;
  }
}