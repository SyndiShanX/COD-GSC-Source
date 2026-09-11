/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\juggernaut\behaviors.gsc
****************************************************/

function juggernaut_init(var0) {
  self.spec = "juggernaut";
  self.wearing_helmet = 1;
  self allowedstances("stand");
  self.juggernaut = 1;
  self.dontmeleeme = 1;
  self.minpaindamage = 200;
  self.grenadeammo = 0;
  self.doorflashchance = 0.05;
  self.aggressivemode = 1;
  self.ignoresuppression = 1;
  self.disablepistol = 1;
  self.meleechargedistvsplayer = 120;
  self.meleechargedist = 120;
  self.meleestopattackdistsq = 14400;
  self.meleedamageoverride = 400;
  self.meleemaxzdiff = 500;
  self.meleetargetallowedoffmeshdistsq = 2500;
  self.meleetryhard = 0;
  self.meleeignorefinalzdiff = 0;
  self.meleeignoreplayerstance = 1;
  self.dontsyncmelee = 1;
  self.disablebulletwhizbyreaction = 1;
  self.combatmode = "no_cover";
  self.neversprintforvariation = 1;
  self.disablerunngun = 1;
  self.disabledodge = 1;
  self.pathenemyfightdist = 0;

  if(isDefined(self.a)) {
    self.a.disablelongdeath = 1;
  }

  self.runcooldown = 3000;
  self.juggernautwalkdist = 750;
  self.juggernautstopdistance = 300;
  self.juggernautvisionobscuredwalkdist = 750;
  self.juggernautvisionobscuredstopdistance = 300;
  self.juggernautgoalradius = 25;
  self.vehicle_occupancy_errormessage = 200;
  self.goalheight = 80;
  self.usechokepoints = 0;
  self.cautiousnavigation = 0;
  self.juggernautacceleration = 40;
  self.juggernautcanseeenemydelaymin = 1000;
  self.juggernautcanseeenemydelaymax = 2000;
  self.juggernautrundelaymin = 1000;
  self.juggernautrundelaymax = 2000;
  self.combat_func_active = 1;

  if(!scripts\common\utility::issp() && !scripts\engine\utility::is_equal(level.gametype, "trial")) {
    self giveweapon("iw8_lm_dblmg_execution");
    self giveexecution("jug_execution_000_stand_8", "iw8_lm_dblmg_execution");
    return;
  }
}

function get_closest_living_player() {
  var0 = 1073741824;
  var1 = undefined;

  foreach(var3 in level.players) {
    if(isDefined(level.ignoredbycheck) && [[level.ignoredbycheck]](self, var3)) {
      continue;
    }

    var4 = distancesquared(self.origin, var3.origin);

    if(isalive(var3) && !isDefined(var3.fauxdead) && var4 < var0) {
      var1 = var3;
      var0 = var4;
    }
  }

  return var1;
}

function juggernaut_lookforplayers(var0) {
  if(istrue(self.juggernautvisionobscured)) {
    return anim.failure;
  }

  if(!isDefined(self.juggernaut_lookforplayertime)) {
    self.juggernaut_lookforplayertime = 0;
  }

  if(gettime() > self.juggernaut_lookforplayertime) {
    var1 = get_closest_living_player();

    if(isDefined(var1)) {
      self getenemyinfo(var1);
    }

    self.juggernaut_lookforplayertime = gettime() + 3000;
  }

  return anim.failure;
}

function juggernaut_getenemy() {
  if(isDefined(self.favoriteenemy) && isalive(self.favoriteenemy)) {
    return self.favoriteenemy;
  }

  return self.enemy;
}

function juggernaut_getwalkdist() {
  if(istrue(self.juggernautvisionobscured)) {
    return self.juggernautvisionobscuredwalkdist;
  }

  return self.juggernautwalkdist;
}

function juggernaut_getstopdist() {
  if(istrue(self.juggernautvisionobscured)) {
    return self.juggernautvisionobscuredstopdistance;
  }

  return self.juggernautstopdistance;
}

function juggernaut_shouldmove(var0) {
  if(istrue(self.juggernautdisablemovebehavior)) {
    return anim.failure;
  }

  var1 = juggernaut_getenemy();

  if(!isDefined(var1)) {
    return anim.failure;
  }

  if(!issentient(var1)) {
    return anim.failure;
  }

  if(self lastknowntime(var1) <= 0) {
    return anim.failure;
  }

  if(isDefined(self.melee)) {
    self.juggernautlastmeleetime = gettime();
    return anim.failure;
  }

  return anim.success;
}

function markenemytarget(var0) {
  if(!isDefined(var0.juggernauts)) {
    var0.juggernauts = [];
  }

  var0.juggernauts[var0.juggernauts.size] = self;
}

function unmarkenemytarget(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(var0.juggernauts)) {
    return;
  }

  var0.juggernauts = scripts\engine\utility::array_remove(var0.juggernauts, self);

  if(var0.juggernauts.size <= 0) {
    var0.juggernauts = undefined;
    return;
  }
}

function juggernaut_moveinit(var0) {
  var1 = juggernaut_getenemy();
  var2 = spawnStruct();
  var2.nextupdatetime = 0;
  var2.runcooldown = 0;
  var2.currentmovespeed = length(self.velocity);
  var2.targetmovespeed = var2.currentmovespeed;
  var2.enemy = var1;

  if(lengthsquared(self.velocity) == 0) {
    var2.stopping = 1;
    var2.stopposition = self.origin;
  }

  markenemytarget(var1);
  self.bt.instancedata[var0] = var2;
  self.combatmode = "no_cover";
}

function vehicle_occupancy_allowspawninto(var0, var1) {
  var2 = 0;
  var3 = var0;

  foreach(var5 in var1.juggernauts) {
    if(var5 != self && distancesquared(var5.origin, var0) < 4096) {
      var6 = var0 - var5.origin;
      var6 = (var6[0], var6[1], 0);
      var3 += vectorNormalize(var6) * 64;
      var2 = 1;
    }
  }

  if(var2) {
    var0 = self getplayerip(var3);
    var0 = self getclosestreachablepointonnavmesh(var0);
  }

  return var0;
}

function juggernaut_move(var0) {
  var1 = self.bt.instancedata[var0];
  var2 = juggernaut_getenemy();

  if(var2 != var1.enemy) {
    unmarkenemytarget(var1.enemy);
    markenemytarget(var2);
    var1.enemy = var2;
  }

  self.pathenemyfightdist = 0;

  if(isDefined(self.juggernautlastmeleetime) && gettime() - self.juggernautlastmeleetime < 500) {
    self setbtgoalpos(0, self.origin);
    self setbtgoalRadius(0, self.juggernautgoalradius);
    return anim.running;
  }

  var3 = gettime();

  if(var3 >= var1.nextupdatetime) {
    var1.targetpos = self getclosestreachablepointonnavmesh(var1.enemy.origin);
    var1.ref_13a80 = !self iswithinscriptgoalRadius(var1.targetpos);

    if(var1.ref_13a80) {
      var1.targetpos = self getplayerip(var1.targetpos);
      var1.targetpos = self getclosestreachablepointonnavmesh(var1.targetpos);
    }

    self getenemyinfo(var1.enemy);
  }

  var4 = juggernaut_getstopdist();
  var5 = juggernaut_getwalkdist();
  var6 = self ispathdirect();
  var7 = self pathdisttogoal();

  if(var7 == 0) {
    var7 = distance(self.origin, var1.targetpos);
  }

  var8 = self cansee(var1.enemy) && self canshootenemy(249, 1, 1);

  if(var8) {
    var9 = angleclamp180(vectortopitch(var1.enemy.origin - self.origin));

    if(var9 < self.upaimlimit || var9 > self.downaimlimit) {
      var8 = 0;
    }
  }

  if(!var8) {
    var1.nosighttime = gettime();

    if(!isDefined(var1.canseeenemytime)) {
      var1.canseeenemytime = gettime() + randomintrange(self.juggernautcanseeenemydelaymin, self.juggernautcanseeenemydelaymax);
    }

    if(var1.canseeenemytime > gettime()) {
      var8 = 1;
    }
  } else {
    var1.canseeenemytime = undefined;
  }

  if(var1.ref_13a80 && var8) {
    self setbtgoalRadius(0, max(min(self.vehicle_occupancy_errormessage, self.goalradius / 2), 25));
  } else {
    self setbtgoalRadius(0, self.juggernautgoalradius);
  }

  if(var1.ref_13a80) {
    var8 = 0;
    var1.canseeenemytime = undefined;
  }

  var10 = undefined;
  var11 = 1;
  var12 = var1.enemy.origin;

  if(!var8 || !istrue(var1.stopping) && !var6 && (!isDefined(var1.nosighttime) || gettime() - var1.nosighttime < 2000)) {
    var13 = distance2dsquared(var1.targetpos, self.origin) < 4 && abs(var1.targetpos[2] - self.origin[2]) < 60;

    if(var13 || istrue(var1.backup)) {
      var12 = var1.targetpos;
    } else {
      var1.stopping = 0;
      var10 = var1.targetpos;
      var11 = 0;
    }
  }

  if(var11) {
    var14 = var4 + 150;
    var15 = 50;
    var16 = 150;

    if(distance(self.origin, var12) < var16) {
      if(!isDefined(var1.backuptime)) {
        var1.backuptime = gettime() + 1000;
      }

      if(var1.backuptime < gettime() && !istrue(var1.backup) || var3 >= var1.nextupdatetime) {
        var17 = self.origin - var12;
        var17 = (var17[0], var17[1], 0);
        var1.stopposition = var12 + vectorNormalize(var17) * var16;
        var18 = findopenlookdir(var1.stopposition, var16 / 2, var1.enemy.origin, var1.stopposition);

        if(isDefined(var18)) {
          var1.stopposition = var18;
        }

        var1.stopposition = self getclosestreachablepointonnavmesh(var1.stopposition);
        var1.stopping = 1;
        var1.backup = 1;
      }
    } else {
      var1.backup = 0;
      var1.backuptime = undefined;
    }

    if(istrue(var1.backup)) {
      var10 = var1.stopposition;
    } else {
      if(istrue(var1.stopping)) {
        var19 = var14 + var15;
      } else {
        var19 = var5 + var16;
      }

      if(var8 > var19) {
        var2.stopping = 0;
        var11 = var2.targetpos;
      } else if(!istrue(var2.stopping)) {
        var2.stopping = 1;
        var11 = self getposonpath(var16);
        var11 = vehicle_occupancy_allowspawninto(var11, var2.enemy);
        var2.stopposition = var11;
      } else {
        if(isDefined(self.juggernautpaintime) && gettime() - self.juggernautpaintime < 4000) {
          var2.stopposition = self.origin;
        }

        var11 = var2.stopposition;
      }
    }
  }

  self setbtgoalpos(0, var11);
  var20 = !istrue(self.juggernautforcewalk) && (!self cansee(var2.enemy) && istrue(self.juggernautvisionobscured) && var8 > 450 || var8 > var6);

  if(var20 && (!isDefined(var2.running) || !var2.running)) {
    if(!isDefined(var2.rundelay)) {
      var2.rundelay = gettime() + randomintrange(self.juggernautrundelaymin, self.juggernautrundelaymax);
    }

    if(var2.rundelay > gettime()) {
      var20 = 0;
    }
  }

  if(!isDefined(var2.running) || var2.runcooldown < gettime() && var20 != var2.running) {
    if(var20) {
      if(!isDefined(var2.running) || lengthsquared(self.velocity) > 0) {
        var2.runcooldown = gettime() + self.runcooldown;
        var2.running = 1;
      }

      var2.targetmovespeed = 170;
      var2.rundelay = undefined;
    } else {
      var2.runcooldown = gettime() + self.runcooldown;
      var2.running = 0;
      var2.targetmovespeed = 40;
    }
  }

  var21 = var2.targetmovespeed - var2.currentmovespeed;

  if(var21 < 0 || lengthsquared(self.velocity) > 0) {
    var22 = self.juggernautacceleration * level.framedurationseconds;
    var2.currentmovespeed += clamp(var21, var22 * -1, var22);
  }

  if(var2.currentmovespeed > 113) {
    self.allowstrafe = 0;
    self.dontshootwhilemoving = 1;
  } else {
    self.allowstrafe = 1;
    self.dontshootwhilemoving = 0;
  }

  var2.currentmovespeed = max(var2.currentmovespeed, 20);

  if(isDefined(self.juggernautpaintime) && gettime() - self.juggernautpaintime < 1000) {
    self aisettargetspeed(var2.currentmovespeed);
  }

  scripts\engine\utility::set_movement_speed(var2.currentmovespeed);

  if(var4 >= var2.nextupdatetime) {
    var2.nextupdatetime = var4 + 500;
  }

  return anim.running;
}

function juggernaut_moveterminate(var0) {
  unmarkenemytarget(self.bt.instancedata[var0].enemy);
  self.bt.instancedata[var0] = undefined;
  self clearbtgoal(0);
  scripts\common\utility::demeanor_override("combat");
  self.moveplaybackrate = 1;
}

function juggernaut_updatestance(var0) {
  scripts\asm\asm_bb::bb_requeststance("stand");
  return anim.success;
}

function juggernaut_updateeveryframe_noncombat(var0) {
  scripts\asm\asm_bb::bb_requestweapon(weaponclass(self.primaryweapon));
  scripts\asm\asm_bb::bb_requeststance("stand");
  self.looktarget = undefined;
  return anim.success;
}

function vehicle_occupancy_cp_giveriotshield(var0) {
  var1 = 10000;
  var2 = 1;

  if(var2 && !istrue(self.chopperexfil_skip_ascend2)) {
    return anim.failure;
  }

  if(isDefined(self.ref_13b80) && gettime() - self.ref_13b80 < var1) {
    return anim.failure;
  }

  if(istrue(self.ref_12057)) {
    var3 = self.origin - self.enemy.origin;
    var4 = vectortoyaw(var3);
    var5 = angleclamp180(var4 - self.enemy.angles[1]);

    if(var5 < -45 || var5 > 45) {
      return anim.failure;
    }
  }

  return anim.success;
}

function vehicle_occupancy_clearseatcorpse(var0) {
  self.ref_13b80 = gettime();
  var1 = self.origin - self.enemy.origin;
  var2 = vectortoyaw(var1);
  var3 = angleclamp180(var2 - self.enemy.angles[1]);
  var4 = "jug_execution_";
  var5 = "_stand_";
  var6 = "00";
  var7 = "8";

  if(var3 < 45 && var3 > -45) {
    var8 = randomint(4);
    var6 += var8;
  } else {
    var8 = randomint(2);
    var7 += var8;

    if(var4 < -135 || var4 > 135) {
      var8 = "2";
    } else if(var4 >= 45) {
      var8 = "4";
    } else {
      var8 = "6";
    }
  }

  var10 = var5 + var7 + var6 + var8;
  self giveexecution(var10, "iw8_lm_dblmg_execution");
  return anim.success;
}