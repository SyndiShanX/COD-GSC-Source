/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitypes\juggernaut\behaviors.gsc
***********************************************/

juggernaut_init(var_0) {
  self.spec = "_encstr_8BFC0BC2CBD4F737E0A5E1FD79";
  self.wearing_helmet = 1;
  self allowedstances("_encstr_A5AD069B231F0BAF");
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
  self.combatmode = "_encstr_821109FAE81117DA568730";
  self.neversprintforvariation = 1;
  self.disablerunngun = 1;
  self.disabledodge = 1;
  self.pathenemyfightdist = 0;

  if(isDefined(self.a))
    self.a.disablelongdeath = 1;

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

  if(!scripts\common\utility::issp() && !scripts\engine\utility::is_equal(level.gametype, "_encstr_8CA606F38878410D")) {
    self giveweapon("_encstr_8CCE172DBB70AF1B5BEB1926636B3BBE591E95D8D5472DDBE6");
    self giveexecution("_encstr_882D1A535DD97DCA1E95B1AE1D5AEDCDD7C0C081F5CD472CE68CF51C", "_encstr_8CCE172DBB70AF1B5BEB1926636B3BBE591E95D8D5472DDBE6");
  }
}

get_closest_living_player() {
  var_0 = 1073741824;
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(isDefined(level.ignoredbycheck) && [[level.ignoredbycheck]](self, var_3)) {
      continue;
    }
    var_4 = distancesquared(self.origin, var_3.origin);

    if(isalive(var_3) && !isDefined(var_3.fauxdead) && var_4 < var_0) {
      var_1 = var_3;
      var_0 = var_4;
    }
  }

  return var_1;
}

juggernaut_lookforplayers(var_0) {
  if(istrue(self.juggernautvisionobscured))
    return anim.failure;

  if(!isDefined(self.juggernaut_lookforplayertime))
    self.juggernaut_lookforplayertime = 0;

  if(gettime() > self.juggernaut_lookforplayertime) {
    var_1 = get_closest_living_player();

    if(isDefined(var_1))
      self getenemyinfo(var_1);

    self.juggernaut_lookforplayertime = gettime() + 3000;
  }

  return anim.failure;
}

juggernaut_getenemy() {
  if(isDefined(self.favoriteenemy) && isalive(self.favoriteenemy))
    return self.favoriteenemy;

  return self.enemy;
}

juggernaut_getwalkdist() {
  if(istrue(self.juggernautvisionobscured))
    return self.juggernautvisionobscuredwalkdist;
  else
    return self.juggernautwalkdist;
}

juggernaut_getstopdist() {
  if(istrue(self.juggernautvisionobscured))
    return self.juggernautvisionobscuredstopdistance;
  else
    return self.juggernautstopdistance;
}

juggernaut_shouldmove(var_0) {
  if(istrue(self.juggernautdisablemovebehavior))
    return anim.failure;

  var_1 = juggernaut_getenemy();

  if(!isDefined(var_1))
    return anim.failure;

  if(!issentient(var_1))
    return anim.failure;

  if(self lastknowntime(var_1) <= 0)
    return anim.failure;

  if(isDefined(self.melee)) {
    self.juggernautlastmeleetime = gettime();
    return anim.failure;
  }

  return anim.success;
}

markenemytarget(var_0) {
  if(!isDefined(var_0.juggernauts))
    var_0.juggernauts = [];

  var_0.juggernauts[var_0.juggernauts.size] = self;
}

unmarkenemytarget(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0.juggernauts)) {
    return;
  }
  var_0.juggernauts = scripts\engine\utility::array_remove(var_0.juggernauts, self);

  if(var_0.juggernauts.size <= 0)
    var_0.juggernauts = undefined;
}

juggernaut_moveinit(var_0) {
  var_1 = juggernaut_getenemy();
  var_2 = spawnStruct();
  var_2.nextupdatetime = 0;
  var_2.runcooldown = 0;
  var_2.currentmovespeed = length(self.velocity);
  var_2.targetmovespeed = var_2.currentmovespeed;
  var_2.enemy = var_1;

  if(lengthsquared(self.velocity) == 0) {
    var_2.stopping = 1;
    var_2.stopposition = self.origin;
  }

  markenemytarget(var_1);
  self.bt.instancedata[var_0] = var_2;
  self.combatmode = "_encstr_821109FAE81117DA568730";
}

vehicle_occupancy_allowspawninto(var_0, var_1) {
  var_2 = 0;
  var_3 = var_0;

  foreach(var_5 in var_1.juggernauts) {
    if(var_5 != self && distancesquared(var_5.origin, var_0) < 4096) {
      var_6 = var_0 - var_5.origin;
      var_6 = (var_6[0], var_6[1], 0.0);
      var_3 = var_3 + vectorNormalize(var_6) * 64;
      var_2 = 1;
    }
  }

  if(var_2) {
    var_0 = self getplayerip(var_3);
    var_0 = self getclosestreachablepointonnavmesh(var_0);
  }

  return var_0;
}

juggernaut_move(var_0) {
  var_1 = self.bt.instancedata[var_0];
  var_2 = juggernaut_getenemy();

  if(var_2 != var_1.enemy) {
    unmarkenemytarget(var_1.enemy);
    markenemytarget(var_2);
    var_1.enemy = var_2;
  }

  self.pathenemyfightdist = 0;

  if(isDefined(self.juggernautlastmeleetime) && gettime() - self.juggernautlastmeleetime < 500) {
    self setbtgoalpos(0, self.origin);
    self setbtgoalRadius(0, self.juggernautgoalradius);
    return anim.running;
  }

  var_3 = gettime();

  if(var_3 >= var_1.nextupdatetime) {
    var_1.targetpos = self getclosestreachablepointonnavmesh(var_1.enemy.origin);
    var_1._id_13A80 = !self iswithinscriptgoalRadius(var_1.targetpos);

    if(var_1._id_13A80) {
      var_1.targetpos = self getplayerip(var_1.targetpos);
      var_1.targetpos = self getclosestreachablepointonnavmesh(var_1.targetpos);
    }

    self getenemyinfo(var_1.enemy);
  }

  var_4 = juggernaut_getstopdist();
  var_5 = juggernaut_getwalkdist();
  var_6 = self ispathdirect();
  var_7 = self pathdisttogoal();

  if(var_7 == 0)
    var_7 = distance(self.origin, var_1.targetpos);

  var_8 = self cansee(var_1.enemy) && self canshootenemy(249, 1, 1);

  if(var_8) {
    var_9 = angleclamp180(vectortopitch(var_1.enemy.origin - self.origin));

    if(var_9 < self.upaimlimit || var_9 > self.downaimlimit)
      var_8 = 0;
  }

  if(!var_8) {
    var_1.nosighttime = gettime();

    if(!isDefined(var_1.canseeenemytime))
      var_1.canseeenemytime = gettime() + randomintrange(self.juggernautcanseeenemydelaymin, self.juggernautcanseeenemydelaymax);

    if(var_1.canseeenemytime > gettime())
      var_8 = 1;
  } else
    var_1.canseeenemytime = undefined;

  if(var_1._id_13A80 && var_8)
    self setbtgoalRadius(0, max(min(self.vehicle_occupancy_errormessage, self.goalradius / 2), 25));
  else
    self setbtgoalRadius(0, self.juggernautgoalradius);

  if(var_1._id_13A80) {
    var_8 = 0;
    var_1.canseeenemytime = undefined;
  }

  var_10 = undefined;
  var_11 = 1;
  var_12 = var_1.enemy.origin;

  if(!var_8 || !istrue(var_1.stopping) && !var_6 && (!isDefined(var_1.nosighttime) || gettime() - var_1.nosighttime < 2000)) {
    var_13 = distance2dsquared(var_1.targetpos, self.origin) < 4 && abs(var_1.targetpos[2] - self.origin[2]) < 60;

    if(var_13 || istrue(var_1.backup))
      var_12 = var_1.targetpos;
    else {
      var_1.stopping = 0;
      var_10 = var_1.targetpos;
      var_11 = 0;
    }
  }

  if(var_11) {
    var_14 = var_4 + 150;
    var_15 = 50;
    var_16 = 150;

    if(distance(self.origin, var_12) < var_16) {
      if(!isDefined(var_1.backuptime))
        var_1.backuptime = gettime() + 1000;

      if(var_1.backuptime < gettime() && !istrue(var_1.backup) || var_3 >= var_1.nextupdatetime) {
        var_17 = self.origin - var_12;
        var_17 = (var_17[0], var_17[1], 0.0);
        var_1.stopposition = var_12 + vectorNormalize(var_17) * var_16;
        var_18 = findopenlookdir(var_1.stopposition, var_16 / 2, var_1.enemy.origin, var_1.stopposition);

        if(isDefined(var_18))
          var_1.stopposition = var_18;

        var_1.stopposition = self getclosestreachablepointonnavmesh(var_1.stopposition);
        var_1.stopping = 1;
        var_1.backup = 1;
      }
    } else {
      var_1.backup = 0;
      var_1.backuptime = undefined;
    }

    if(istrue(var_1.backup))
      var_10 = var_1.stopposition;
    else {
      if(istrue(var_1.stopping))
        var_19 = var_14 + var_15;
      else
        var_19 = var_4 + var_15;

      if(var_7 > var_19) {
        var_1.stopping = 0;
        var_10 = var_1.targetpos;
      } else if(!istrue(var_1.stopping)) {
        var_1.stopping = 1;
        var_10 = self getposonpath(var_15);
        var_10 = vehicle_occupancy_allowspawninto(var_10, var_1.enemy);
        var_1.stopposition = var_10;
      } else {
        if(isDefined(self.juggernautpaintime) && gettime() - self.juggernautpaintime < 4000)
          var_1.stopposition = self.origin;

        var_10 = var_1.stopposition;
      }
    }
  }

  self setbtgoalpos(0, var_10);
  var_20 = !istrue(self.juggernautforcewalk) && (!self cansee(var_1.enemy) && istrue(self.juggernautvisionobscured) && var_7 > 450 || var_7 > var_5);

  if(var_20 && (!isDefined(var_1.running) || !var_1.running)) {
    if(!isDefined(var_1.rundelay))
      var_1.rundelay = gettime() + randomintrange(self.juggernautrundelaymin, self.juggernautrundelaymax);

    if(var_1.rundelay > gettime())
      var_20 = 0;
  }

  if(!isDefined(var_1.running) || var_1.runcooldown < gettime() && var_20 != var_1.running) {
    if(var_20) {
      if(!isDefined(var_1.running) || lengthsquared(self.velocity) > 0) {
        var_1.runcooldown = gettime() + self.runcooldown;
        var_1.running = 1;
      }

      var_1.targetmovespeed = 170;
      var_1.rundelay = undefined;
    } else {
      var_1.runcooldown = gettime() + self.runcooldown;
      var_1.running = 0;
      var_1.targetmovespeed = 40;
    }
  }

  var_21 = var_1.targetmovespeed - var_1.currentmovespeed;

  if(var_21 < 0 || lengthsquared(self.velocity) > 0) {
    var_22 = self.juggernautacceleration * level.framedurationseconds;
    var_1.currentmovespeed = var_1.currentmovespeed + clamp(var_21, var_22 * -1, var_22);
  }

  if(var_1.currentmovespeed > 113) {
    self.allowstrafe = 0;
    self.dontshootwhilemoving = 1;
  } else {
    self.allowstrafe = 1;
    self.dontshootwhilemoving = 0;
  }

  var_1.currentmovespeed = max(var_1.currentmovespeed, 20);

  if(isDefined(self.juggernautpaintime) && gettime() - self.juggernautpaintime < 1000)
    self aisettargetspeed(var_1.currentmovespeed);

  scripts\engine\utility::set_movement_speed(var_1.currentmovespeed);

  if(var_3 >= var_1.nextupdatetime)
    var_1.nextupdatetime = var_3 + 500;

  return anim.running;
}

juggernaut_moveterminate(var_0) {
  unmarkenemytarget(self.bt.instancedata[var_0].enemy);
  self.bt.instancedata[var_0] = undefined;
  self clearbtgoal(0);
  scripts\common\utility::demeanor_override("_encstr_AA7C07466F9DA30713");
  self.moveplaybackrate = 1;
}

juggernaut_updatestance(var_0) {
  scripts\asm\asm_bb::bb_requeststance("_encstr_A5AD069B231F0BAF");
  return anim.success;
}

juggernaut_updateeveryframe_noncombat(var_0) {
  scripts\asm\asm_bb::bb_requestweapon(weaponclass(self.primaryweapon));
  scripts\asm\asm_bb::bb_requeststance("_encstr_A5AD069B231F0BAF");
  self.looktarget = undefined;
  return anim.success;
}

vehicle_occupancy_cp_giveriotshield(var_0) {
  var_1 = 10000;
  var_2 = 1;

  if(var_2 && !istrue(self.chopperexfil_skip_ascend2))
    return anim.failure;

  if(isDefined(self._id_13B80) && gettime() - self._id_13B80 < var_1)
    return anim.failure;

  if(istrue(self._id_12057)) {
    var_3 = self.origin - self.enemy.origin;
    var_4 = vectortoyaw(var_3);
    var_5 = angleclamp180(var_4 - self.enemy.angles[1]);

    if(var_5 < -45 || var_5 > 45)
      return anim.failure;
  }

  return anim.success;
}

vehicle_occupancy_clearseatcorpse(var_0) {
  self._id_13B80 = gettime();
  var_1 = self.origin - self.enemy.origin;
  var_2 = vectortoyaw(var_1);
  var_3 = angleclamp180(var_2 - self.enemy.angles[1]);
  var_4 = "_encstr_829C0FC8DBEF713D130F6743632A70A0BF";
  var_5 = "_encstr_8C0608279FD8263BB566";
  var_6 = "_encstr_9B0703C081";
  var_7 = "_encstr_864C02F9";

  if(var_3 < 45 && var_3 > -45) {
    var_8 = randomint(4);
    var_6 = var_6 + var_8;
  } else {
    var_8 = randomint(2);
    var_6 = var_6 + var_8;

    if(var_3 < -135 || var_3 > 135)
      var_7 = "_encstr_A74C0222";
    else if(var_3 >= 45)
      var_7 = "_encstr_AC4C024A";
    else
      var_7 = "_encstr_8F4C026A";
  }

  var_10 = var_4 + var_6 + var_5 + var_7;
  self giveexecution(var_10, "_encstr_8CCE172DBB70AF1B5BEB1926636B3BBE591E95D8D5472DDBE6");
  return anim.success;
}