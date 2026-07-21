/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitypes\combat.gsc
***********************************************/

soldier_init_common() {
  level thread low_cover_combat_areas();
  self.boredofcoverinterval = randomintrange(10000, 15000);
}

updateeveryframe_noncombat(var_0) {
  scripts\asm\asm_bb::bb_requestweapon(weaponclass(self.primaryweapon));
  var_1 = scripts\asm\asm::asm_getephemeraleventdata("ai_notify", "bulletwhizby");

  if(isDefined(var_1)) {
    if(!isDefined(self.disablebulletwhizbyreaction)) {
      var_2 = var_1[0];
      var_3 = isDefined(var_2) && distancesquared(self.origin, var_2.origin) < 160000;

      if(var_3 || scripts\engine\utility::cointoss()) {
        var_4 = spawnStruct();
        var_4.gametime = gettime() - 50;
        var_4.params = var_1;
        scripts\asm\asm_bb::bb_requestwhizby(var_4);
      }
    }
  } else {
    var_5 = 100;
    var_1 = scripts\asm\asm_bb::bb_getrequestedwhizby();

    if(!isDefined(var_1) || gettime() > var_1.gametime + var_5)
      scripts\asm\asm_bb::bb_requestwhizby(undefined);
  }

  self.looktarget = undefined;
  return anim.success;
}

shouldbefrantic() {
  if(isDefined(self.frantic))
    return self.frantic;

  return 0;
}

updateeveryframe_global(var_0) {
  if(istrue(self.in_melee_death) || istrue(self.a.doinglongdeath))
    return anim.failure;

  var_1 = isDefined(self.enemy) || isDefined(self.fnisinstealthcombat) && [[self.fnisinstealthcombat]]();
  self.bisincombat = var_1;

  if(istrue(self.shouldjoinsquad))
    scripts\aitypes\squad::updatesquad();

  if(istrue(self.domagicdoorchecks))
    scripts\aitypes\common::updateeveryframe_magicdoorchecks();

  self.smartfacingpos = self updateaiminfo();
  var_2 = getmovetype();
  scripts\asm\asm_bb::bb_requestmovetype(var_2);
  return anim.success;
}

updatewhizby(var_0) {
  var_1 = scripts\asm\asm::asm_getephemeraleventdata("ai_notify", "bulletwhizby");

  if(isDefined(var_1) && isDefined(self.a)) {
    if(randomfloat(1) < self.a.reacttobulletchance) {
      var_2 = spawnStruct();
      var_2.gametime = gettime() - 50;
      var_2.params = var_1;
      scripts\asm\asm_bb::bb_requestwhizby(var_2);
    }
  } else {
    var_3 = 100;
    var_1 = scripts\asm\asm_bb::bb_getrequestedwhizby();

    if(!isDefined(var_1) || gettime() > var_1.gametime + var_3)
      scripts\asm\asm_bb::bb_requestwhizby(undefined);
  }

  return anim.success;
}

getmovetype() {
  if(isDefined(self.grenade))
    return "combat";

  var_0 = scripts\aitypes\bt_util::bt_getdemeanor();
  return var_0;
}

hasammoinclip() {
  var_0 = getusedturret();

  if(isDefined(var_0))
    return 1;

  if(!isDefined(self.weapon))
    return 0;

  if(self.bulletsinclip > 0 || istrue(self.disablereload))
    return 1;

  return 0;
}

islowonammo(var_0, var_1) {
  if(scripts\anim\utility_common.gsc::needtoreload(var_1))
    return anim.success;

  return anim.failure;
}

withindistancetoenemy(var_0, var_1) {
  if(!isDefined(self.enemy))
    return anim.failure;

  if(distancesquared(self.origin, self.enemy.origin) <= var_1 * var_1)
    return anim.success;

  return anim.failure;
}

iscoverblockedbywall(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1000;

  if(scripts\asm\asm_bb::bb_getrequestedcoverstate() != "exposed")
    return anim.failure;

  if(isDefined(self._blackboard.initialcovergunblockedbywalltime)) {
    if(gettime() - self._blackboard.initialcovergunblockedbywalltime > var_1) {
      if(scripts\asm\shared\utility::blockedbywall(0))
        return anim.success;
    }
  }

  return anim.failure;
}

mayshoot(var_0) {
  if(!isDefined(self.weapon))
    return anim.failure;

  var_1 = shouldshoot();

  if(var_1)
    var_1 = calcgoodshootpos();
  else
    self.goodshootpos = undefined;

  if(!var_1)
    return anim.failure;

  return anim.success;
}

updatelooktarget(var_0) {
  if(!isDefined(self.looktarget) || self.looktarget != self.enemy)
    self.looktarget = self.enemy;

  return anim.success;
}

shoot_clearconvergence() {
  self._blackboard.shootparams_bconvergeontarget = 0;
}

shoot_enableconvergence() {
  self._blackboard.shootparams_bconvergeontarget = 1;
}

shoot_init(var_0) {
  self.bt.m_bfiring = 0;
  self.looktarget = self.enemy;
  self.bc_looktarget = self.enemy;
  scripts\asm\asm_bb::bb_claimshootparams(var_0);

  if(scripts\anim\utility_common.gsc::isasniper()) {
    shoot_enableconvergence();
    self.snipershotcount = 0;
    self.sniperhitcount = 0;
  }
}

shoot_terminate(var_0) {
  if(istrue(self._blackboard.shootparams_valid) && self._blackboard.shootparams_taskid == var_0) {
    scripts\asm\asm_bb::bb_clearshootparams();
    shoot_clearconvergence();
  }

  self.bt.m_bfiring = 0;
  self.bc_looktarget = undefined;
  scripts\asm\asm_bb::bb_requestfire(0);
}

isaimedataimtarget() {
  return scripts\asm\track::aimedataimtarget();
}

resetmisstime() {
  if(isDefined(self.fnresetmisstime))
    return self[[self.fnresetmisstime]]();
}

getturretaimangles(var_0) {
  if(isDefined(self.fngetturretaimangles))
    return self[[self.fngetturretaimangles]](var_0);

  return 0;
}

shoot_update(var_0) {
  var_1 = getusedturret();

  if(isDefined(self.enemy) && !isPlayer(self.enemy) && istrue(self._blackboard.shootparams_valid) && self._blackboard.shootparams_starttime < gettime()) {
    var_2 = int(gettime() / 50);

    if(self getentitynumber() % 4 != var_2 % 4) {
      if(!istrue(self.baimedataimtarget) && !istrue(self.casualkiller)) {
        self.bt.m_bfiring = 0;
        scripts\asm\asm_bb::bb_requestfire(self.bt.m_bfiring);
      }

      return anim.running;
    }
  }

  var_3 = undefined;
  var_4 = undefined;
  var_5 = self.enemy;

  if(isDefined(var_1)) {
    var_6 = getturretaimangles(var_1);
    var_7 = anglesToForward(var_6);
    var_7 = rotatevector(var_7, self.angles);
    var_8 = scripts\asm\shared\utility::getshootfrompos();
    var_3 = var_8 + var_7 * 512.0;
    var_4 = 0;
  } else if(isDefined(self.goodshootpos)) {
    var_3 = self.goodshootpos;
    var_4 = 0;
  } else if(self cansee(self.enemy)) {
    var_3 = self.enemy getshootatpos();
    var_4 = 1;
  } else
    return anim.success;

  if(!istrue(self._blackboard.shootparams_valid))
    scripts\asm\asm_bb::bb_newshootparams(var_3, var_5, var_4);
  else
    scripts\asm\asm_bb::bb_updateshootparams(var_3, var_5, var_4);

  if(istrue(self.baimedataimtarget) || isaimedataimtarget()) {
    if(scripts\asm\shared\utility::blockedbywall(0))
      self.bt.m_bfiring = 0;
    else {
      if(!self.bt.m_bfiring)
        resetmisstime();

      chooseshootposandobjective();
      self.bt.m_bfiring = istrue(self._blackboard.shootparams_valid);
    }
  } else
    self.bt.m_bfiring = 0;

  if(!isDefined(self._blackboard.shootparams_pos) && !isDefined(self._blackboard.shootparams_ent))
    return anim.success;

  scripts\asm\asm_bb::bb_requestfire(self.bt.m_bfiring);
  return anim.running;
}

hasatleastammo(var_0) {
  if(nullweapon(self.weapon))
    return 0;

  return self.bulletsinclip >= weaponclipsize(self.weapon) * var_0;
}

reload_cheatammo() {
  var_0 = weaponclipsize(self.weapon);
  self.bulletsinclip = int(var_0 * 0.5);
  self.bulletsinclip = int(clamp(self.bulletsinclip, 0, var_0));
}

chooseshootstyle() {
  var_0 = 62500;
  var_1 = 810000;
  var_2 = 2560000;
  var_3 = weaponclass(self.weapon);
  var_4 = getusedturret();
  var_5 = isDefined(var_4);

  if(isDefined(self.shootstyleoverride)) {
    var_6 = 0;

    if(isDefined(self.bt.shootstylefastburst))
      var_6 = self.bt.shootstylefastburst;

    return setshootstyle(self.shootstyleoverride, var_6);
  }

  if(var_3 == "mg" || var_5)
    return setshootstyle("mg", 0);

  if(isDefined(self._blackboard.shootparams_ent) && isDefined(self._blackboard.shootparams_ent.enemy) && isDefined(self._blackboard.shootparams_ent.enemy.syncedmeleetarget))
    return setshootstyle("single", 0);

  if(scripts\anim\utility_common.gsc::isasniper())
    return setshootstyle("single", 0);

  if(var_3 == "rocketlauncher" || var_3 == "pistol")
    return setshootstyle("single", 0);

  if(scripts\anim\utility_common.gsc::isshotgun(self.weapon)) {
    if(scripts\anim\utility_common.gsc::weapon_pump_action_shotgun())
      return setshootstyle("single", 0);
    else
      return setshootstyle("semi", 0);
  }

  if(var_3 == "grenade")
    return setshootstyle("single", 0);

  if(weaponburstcount(self.weapon) > 0)
    return setshootstyle("burst", 0);

  var_7 = distancesquared(self getshootatpos(), self._blackboard.shootparams_pos);

  if(var_7 < var_0) {
    if(isDefined(self._blackboard.shootparams_ent) && isDefined(self._blackboard.shootparams_ent.magic_bullet_shield))
      return setshootstyle("single", 0);
    else
      return setshootstyle("full", 0);
  } else if(var_7 < var_1 || shouldbeajerk()) {
    if(weaponissemiauto(self.weapon) || shoulddosemiforvariety(var_7))
      return setshootstyle("semi", 1);
    else
      return setshootstyle("burst", 1);
  } else if(self.providecoveringfire || var_7 < var_2) {
    if(shoulddosemiforvariety(var_7))
      return setshootstyle("semi", 0);
    else
      return setshootstyle("burst", 0);
  } else if(shoulddosemiforvariety(var_7))
    return setshootstyle("semi", 0);
  else
    return setshootstyle("single", 0);
}

setshootstyle(var_0, var_1) {
  self._blackboard.shootparams_style = var_0;
  self._blackboard.shootparams_fastburst = var_1;
}

shouldbeajerk() {
  if(!isDefined(level.gameskill))
    return 0;

  return level.gameskill == 3 && isPlayer(self.enemy);
}

shoulddosemiforvariety(var_0) {
  var_1 = randomfloat(1);
  var_2 = shoulddosemiprobabilityline(var_0);
  return var_1 <= var_2;
}

shoulddosemiprobabilityline(var_0) {
  if(var_0 < 2560000.0)
    return -1;

  return -0.0000000465839 * var_0 - -0.119255 + 0.5;
}

getusedturret() {
  if(isDefined(self.fngetusedturret))
    return [[self.fngetusedturret]]();
}

shouldshoot() {
  if(!self aimayshoot())
    return 0;

  if(istrue(self._blackboard.partialgestureplaying))
    return 0;

  if(isDefined(self.pathgoalpos) && !scripts\asm\track::canaimwhilemoving())
    return 0;

  return 1;
}

calcgoodshootpos() {
  if(self cansee(self.enemy)) {
    if(self canshootenemy()) {
      scripts\anim\utility_common.gsc::dontgiveuponsuppressionyet();
      self.goodshootpos = self.enemy getshootatpos();
      return 1;
    }
  }

  var_0 = scripts\anim\utility_common.gsc::cansuppressenemy();
  return var_0;
}

chooseshootposandobjective() {
  if(isDefined(self.shootposoverride)) {
    if(!isDefined(self.enemy))
      scripts\asm\asm_bb::bb_updateshootparams_pos(self.shootposoverride);

    self.shootposoverride = undefined;
  }

  var_0 = shootobjective();

  if(isDefined(var_0) && var_0 == "retry")
    var_0 = shootobjective();
}

shootobjective() {
  if(self._blackboard.shootparams_objective == "normal") {
    var_0 = shootobjective_internal();
    return var_0;
  } else {
    if(scripts\anim\utility_common.gsc::shouldshootenemyent()) {
      self._blackboard.shootparams_objective = "normal";
      return "retry";
    }

    var_1 = scripts\anim\utility_common.gsc::cansuppressenemy();

    if(self._blackboard.shootparams_objective == "suppress" || self.team == "allies" && !isDefined(self.enemy) && !var_1)
      shootobjective_suppress(var_1);
  }
}

shootobjective_internal() {
  if(!scripts\anim\utility_common.gsc::shouldshootenemyent()) {
    if(!isDefined(self.enemy))
      havenothingtoshoot();
    else {
      if((self.providecoveringfire || randomint(5) > 0) && shouldsuppress())
        self._blackboard.shootparams_objective = "suppress";
      else
        self._blackboard.shootparams_objective = "ambush";

      return "retry";
    }
  } else
    setshootenttoenemy();
}

shouldsuppress() {
  var_0 = 40000.0;

  if(isDefined(self.enemy) && isDefined(self.pathgoalpos) && distance2dsquared(self.origin, self.enemy.origin) < var_0)
    return 0;

  return !self.doingambush;
}

setshootenttoenemy() {
  var_0 = self.enemy getshootatpos();
  scripts\asm\asm_bb::bb_updateshootparams(var_0, self.enemy, 1);
}

shootobjective_suppress(var_0) {
  if(!var_0)
    havenothingtoshoot();
  else {
    var_1 = getenemysightpos();
    scripts\asm\asm_bb::bb_updateshootparams(var_1, self.enemy, 0);
  }
}

getenemysightpos() {
  return self.goodshootpos;
}

havenothingtoshoot() {
  self.bt.m_bfiring = 0;
  scripts\asm\asm_bb::bb_requestfire(0);
  scripts\asm\asm_bb::bb_clearshootparams();
}

reacquire_checkadvanceonenemyconditions() {
  if(!isDefined(level.lastadvancetoenemytime) || !isDefined(level.lastadvancetoenemytime[self.team]))
    return 0;

  if(shouldhelpadvancingteammate())
    return 1;

  if(level.lastadvancetoenemytime[self.team] > 0 && gettime() - level.lastadvancetoenemytime[self.team] < level.advancetoenemyinterval)
    return 0;

  if(!issentient(self.enemy))
    return 0;

  if(level.advancetoenemygroup[self.team])
    level.advancetoenemygroup[self.team] = 0;

  var_0 = isDefined(self.advance_regardless_of_numbers) && self.advance_regardless_of_numbers;

  if(!var_0 && getaicount(self.team) < getaicount(self.enemy.team))
    return 0;

  return 1;
}

shouldhelpadvancingteammate() {
  if(level.advancetoenemygroup[self.team] > 0 && level.advancetoenemygroup[self.team] < level.advancetoenemygroupmax) {
    if(gettime() - level.lastadvancetoenemytime[self.team] > 4000)
      return 0;

    var_0 = level.lastadvancetoenemyattacker[self.team];

    if(var_0 == self)
      return 0;

    var_1 = isDefined(var_0) && distancesquared(self.origin, var_0.origin) < 65536;

    if((var_1 || distancesquared(self.origin, level.lastadvancetoenemysrc[self.team]) < 65536) && (!isDefined(self.enemy) || distancesquared(self.enemy.origin, level.lastadvancetoenemydest[self.team]) < 262144))
      return 1;
  }

  return 0;
}

shouldattemptreacquirecharge() {
  return shouldattemptanyreacquire();
}

shouldattemptanyreacquire() {
  if(self.fixednode)
    return 0;

  if(scripts\engine\utility::actor_is3d())
    return 0;

  if(!isDefined(self.enemy))
    return 0;

  if(scripts\aitypes\squad::isinsquad())
    return 0;

  if(weaponclass(self.weapon) == "mg")
    return 0;

  if(self.combatmode == "ambush" || self.combatmode == "ambush_nodes_only")
    return 0;

  if(self cansee(self.enemy) && self canshootenemy())
    return 0;

  return 1;
}

reacquire_init(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
}

reacquire_terminate(var_0) {
  self.bt.instancedata[var_0] = undefined;
  self._blackboard.reacquiredtime = undefined;
}

reacquire_charge_terminate(var_0) {
  self.bt.instancedata[var_0] = undefined;
  self._blackboard.reacquiredtime = undefined;
}

reacquire_clear(var_0) {
  self reacquireclear();
}

reacquire_step(var_0, var_1) {
  var_2 = self.bt.instancedata[var_0];

  if(!istrue(var_2.binited)) {
    if(istrue(self.aggressivemode))
      return anim.failure;

    var_2.binited = 1;
    self._blackboard.reacquiresteptime = gettime();

    if(self reacquirestep(var_1))
      return anim.running;

    return anim.failure;
  }

  var_3 = self getreacquirestate();
  self._blackboard.reacquiresteptime = gettime();

  if(var_3 == "reacquired") {
    if(!isDefined(self._blackboard.reacquiredtime))
      self._blackboard.reacquiredtime = gettime() + 5000;

    if(!istrue(var_2.loweredreacquiredtime) && (!isDefined(self.enemy) || issentient(self.enemy) && !self seerecently(self.enemy, 2))) {
      self._blackboard.reacquiredtime = self._blackboard.reacquiredtime - 3000;
      var_2.loweredreacquiredtime = 1;
    }

    if(gettime() > self._blackboard.reacquiredtime) {
      self reacquireclear();
      return anim.success;
    }

    return anim.running;
  } else if(var_3 == "enabled") {
    if(istrue(var_2.bpossiblefail))
      return anim.failure;

    if(!self.arriving && !isDefined(self.pathgoalpos) && !istrue(self.pathpending))
      var_2.bpossiblefail = 1;

    return anim.running;
  }

  self reacquireclear();
  return anim.success;
}

reacquire_attemptcharge() {
  if(!self isingoal(self.enemy.origin))
    return 0;

  if(scripts\anim\utility_common.gsc::islongrangeai())
    return 0;

  self findreacquiredirectpath(0);

  if(self reacquiremove()) {
    self.keepclaimednodeifvalid = 0;
    self.keepclaimednode = 0;

    if(level.advancetoenemygroup[self.team] == 0) {
      level.lastadvancetoenemytime[self.team] = gettime();
      level.lastadvancetoenemyattacker[self.team] = self;
    }

    level.lastadvancetoenemysrc[self.team] = self.origin;
    level.lastadvancetoenemydest[self.team] = self.enemy.origin;
    level.advancetoenemygroup[self.team]++;
    return 1;
  }

  return 0;
}

reacquire_charge(var_0) {
  var_1 = self.bt.instancedata[var_0];

  if(!istrue(var_1.binited)) {
    if(!shouldattemptreacquirecharge())
      return anim.failure;

    var_1.binited = 1;

    if(!reacquire_checkadvanceonenemyconditions())
      return anim.success;

    if(reacquire_attemptcharge())
      return anim.running;

    return anim.failure;
  }

  var_2 = self getreacquirestate();
  self._blackboard.reacquiresteptime = gettime();

  if(var_2 == "reacquired") {
    if(!isDefined(self._blackboard.reacquiredtime))
      self._blackboard.reacquiredtime = gettime() + 5000;

    if(!istrue(var_1.loweredreacquiredtime) && (!isDefined(self.enemy) || issentient(self.enemy) && !self seerecently(self.enemy, 2))) {
      self._blackboard.reacquiredtime = self._blackboard.reacquiredtime - 3000;
      var_1.loweredreacquiredtime = 1;
    }

    if(gettime() > self._blackboard.reacquiredtime) {
      self reacquireclear();
      return anim.success;
    }

    return anim.running;
  } else if(var_2 == "enabled") {
    if(self isingoal(self.origin))
      return anim.failure;

    self findreacquiredirectpath(0);
    return anim.running;
  }

  return anim.failure;
}

badplaceavoid(var_0) {
  if(scripts\asm\asm_bb::bb_moverequested())
    return anim.failure;

  var_1 = self getposoutsidebadplace(128.0);

  if(isDefined(var_1)) {
    self setbtgoalpos(2, var_1);
    self._blackboard.badplaceavoidstarttime = gettime();
    return anim.success;
  }

  return anim.failure;
}

waituntilnotinbadplace(var_0) {
  var_1 = gettime();

  if(var_1 > self._blackboard.badplaceavoidstarttime + 100 && !isDefined(self.pathgoalpos) && !istrue(self.pathpending))
    return anim.failure;

  if(var_1 > self._blackboard.badplaceavoidstarttime + 5000)
    return anim.failure;

  return anim.running;
}

badplaceterminate(var_0) {
  self clearbtgoal(2);
  self._blackboard.badplaceavoidstarttime = undefined;
}

isenemyinlowcover(var_0) {
  if(!isDefined(self.enemy) || !issentient(self.enemy))
    return anim.failure;

  if(!isDefined(self.enemy.lowcovervolume))
    return anim.failure;

  if(!isDefined(self.enemy.underlowcover))
    return anim.failure;

  if(isDefined(self.melee))
    return anim.failure;

  var_1 = self lastknownpos(self.enemy);
  var_2 = 0;

  if(istrue(self.aggressivelowcovermode)) {
    var_3 = distancesquared(self.origin, var_1);
    var_4 = 3600;

    if(isDefined(self.aggressivelowcover_dist))
      var_4 = self.aggressivelowcover_dist * self.aggressivelowcover_dist;

    if(var_3 < var_4)
      var_2 = 1;
    else if(distancesquared(self.origin, self.enemy.origin) < var_4)
      var_2 = 1;
  }

  if(!var_2) {
    var_5 = self lastknowntime(self.enemy);

    if(var_5 <= gettime() - 5000)
      return anim.failure;

    if(!ispointinvolume(var_1, self.enemy.lowcovervolume))
      return anim.failure;
  }

  var_6 = self.enemy.lowcovervolume scripts\engine\utility::get_linked_nodes();

  if(var_6.size == 0)
    return anim.failure;

  var_6 = sortbydistance(var_6, var_1);

  foreach(var_8 in var_6) {
    if(isDefined(showcinematicletterboxing(var_8)) && showcinematicletterboxing(var_8) != self) {
      continue;
    }
    self setbtgoalnode(1, var_8);
    self setbtgoalRadius(1, 12);
    return anim.success;
  }

  return anim.failure;
}

enemyinlowcover_init(var_0) {
  var_1 = self lastknownpos(self.enemy);
  var_2 = spawnStruct();
  var_2.enemy = self.enemy;
  var_2.vol = self.enemy.lowcovervolume;
  var_2.lastknownposatstart = var_1;
  self.bt.instancedata[var_0] = var_2;
  self.dontgiveuponsuppression = 1;
  self.suppress_uselastenemysightpos = 1;
  var_3 = scripts\anim\utility_common.gsc::getenemyeyepos();
  self.lastenemysightpos = var_1 + (0, 0, var_3[2] - self.enemy.origin[2]);
  self.benemyinlowcover = 1;
  self notify("enemyInLowCover", var_2.vol);
}

enemyinlowcover_update(var_0) {
  var_1 = self.bt.instancedata[var_0];

  if(!isDefined(var_1.enemy) || !isalive(var_1.enemy))
    return anim.failure;

  if(!isDefined(self.enemy) || self.enemy != var_1.enemy)
    return anim.failure;

  var_2 = gettime();
  var_3 = self lastknownpos(self.enemy);

  if(distancesquared(var_1.lastknownposatstart, var_3) > 1 && !ispointinvolume(var_3, var_1.vol))
    return anim.failure;

  var_4 = isDefined(self.enemy.underlowcover) && ispointinvolume(self.enemy.origin, var_1.vol);

  if(var_4)
    var_1.timeenemyleftvolume = undefined;
  else if(!isDefined(var_1.timeenemyleftvolume))
    var_1.timeenemyleftvolume = var_2;

  if(isDefined(var_1.timeenemyleftvolume) && var_2 > var_1.timeenemyleftvolume + 5000)
    return anim.failure;

  self.lastenemysightpos = vectorlerp(self.lastenemysightpos, scripts\anim\utility_common.gsc::getenemyeyepos(), 0.1);
  return anim.running;
}

enemyinlowcover_terminate(var_0) {
  self.bt.instancedata[var_0] = undefined;
  self.dontgiveuponsuppression = undefined;
  self.suppress_uselastenemysightpos = undefined;
  self.benemyinlowcover = undefined;
  self clearbtgoal(1);
  self notify("enemyLeftLowCover");
}

valid_reaction_sound(var_0) {
  switch (var_0) {
    case "w2":
    case "w1":
    case "w0":
    case "5":
    case "4":
    case "3":
    case "omr":
    case "slt":
    case "2":
    case "0":
    case "1":
      return 1;
  }

  return 0;
}

turretrequested(var_0) {
  if(isDefined(scripts\asm\asm_bb::bb_getrequestedturret()))
    return anim.success;

  return anim.failure;
}

getplayerthatseesmyscope() {
  var_0 = self getEye();

  foreach(var_2 in level.players) {
    if(!self cansee(var_2)) {
      continue;
    }
    var_3 = var_2 getEye();
    var_4 = vectortoangles(var_0 - var_3);
    var_5 = anglesToForward(var_4);
    var_6 = var_2 getplayerangles();
    var_7 = anglesToForward(var_6);
    var_8 = vectordot(var_5, var_7);

    if(var_8 < 0.805) {
      continue;
    }
    if(scripts\engine\utility::cointoss() && var_8 >= 0.996) {
      continue;
    }
    return var_2;
  }

  return undefined;
}

updatesniperglint(var_0) {
  if(self.team != "axis")
    return anim.success;

  if(isDefined(self.disable_sniper_glint) && self.disable_sniper_glint)
    return anim.success;

  if(!scripts\anim\utility_common.gsc::isasniper())
    return anim.success;

  var_1 = createheadicon(self.weapon);

  if(self.weaponinfo[var_1].position == "none")
    return anim.success;

  var_2 = level.g_effect["sniper_glint"];

  if(!isDefined(var_2))
    return anim.success;

  if(!isDefined(self.next_sniper_glint_time))
    self.next_sniper_glint_time = gettime() + randomintrange(3000, 5000);

  if(!isDefined(self.enemy) || !isalive(self.enemy))
    return anim.success;

  if(gettime() < self.next_sniper_glint_time)
    return anim.success;

  self.next_sniper_glint_time = gettime() + 200;

  if(self.weapon != self.primaryweapon)
    return anim.success;

  var_3 = getplayerthatseesmyscope();

  if(!isDefined(var_3))
    return anim.success;

  if(distancesquared(self.origin, var_3.origin) < 65536)
    return anim.success;

  if(scripts\asm\asm_bb::bb_shootparamsvalid() && isDefined(self._blackboard.shootparams_pos)) {
    var_4 = self getmuzzledir();
    var_5 = vectorNormalize(self._blackboard.shootparams_pos - self getEye());
    var_6 = vectordot(var_4, var_5);

    if(var_6 < 0.906) {
      self.next_sniper_glint_time = undefined;
      return anim.success;
    }
  } else {
    self.next_sniper_glint_time = undefined;
    return anim.success;
  }

  playFXOnTag(var_2, self, "tag_flash");
  self.next_sniper_glint_time = gettime() + randomintrange(3000, 5000);
  return anim.success;
}

ifshoulddosmartobject(var_0) {
  var_1 = scripts\asm\asm_bb::bb_getrequestedsmartobject();

  if(!isDefined(var_1))
    return anim.failure;

  if(isDefined(self.disablesmartobjects))
    return anim.failure;

  var_2 = self.origin[2] - var_1.origin[2];

  if(var_2 * var_2 > 5184)
    return anim.failure;

  if(distance2dsquared(self.origin, var_1.origin) > 225)
    return anim.failure;

  return anim.success;
}

dosmartobject_init(var_0) {
  scripts\asm\asm_bb::bb_requestplaysmartobject();

  if(isDefined(self.asm.customdata.arrivalangles))
    self.asm.customdata.arrivalangles = undefined;

  self.bt.instancedata[var_0] = self.disableautolookat;
  self.disableautolookat = 1;
}

dosmartobject(var_0) {
  if(self asmephemeraleventfired("smartobject", "finished")) {
    var_1 = scripts\asm\asm_bb::bb_getrequestedsmartobject();
    var_1 scripts\smartobjects\utility::smartobject_setnextuse();
    return anim.success;
  }

  return anim.running;
}

dosmartobjectterminate(var_0) {
  scripts\smartobjects\utility::clearsmartobject(scripts\asm\asm_bb::bb_getrequestedsmartobject());
  self.disableautolookat = self.bt.instancedata[var_0];
  self.bt.instancedata[var_0] = undefined;
}

low_cover_combat_areas() {
  if(istrue(level.low_cover_combat_setup)) {
    return;
  }
  level.low_cover_combat_setup = 1;

  for(;;) {
    var_0 = getEntArray("low_cover_area", "targetname");

    foreach(var_2 in level.players) {
      var_3 = undefined;

      foreach(var_5 in var_0) {
        if(ispointinvolume(var_2.origin, var_5)) {
          var_3 = var_5;
          break;
        }
      }

      if(isDefined(var_2.lowcovervolume) && (!isDefined(var_3) || var_2.lowcovervolume != var_3)) {
        var_2 notify("left_low_cover");
        var_2.underlowcover = undefined;
      }

      if(isDefined(var_3) && (!isDefined(var_2.lowcovervolume) || var_3 != var_2.lowcovervolume)) {
        var_2 thread transfer_damage_to_player(var_3);
        var_2 thread player_under_low_cover_monitor(var_3);
      }

      var_2.lowcovervolume = var_3;
    }

    waitframe();
  }
}

player_under_low_cover_monitor(var_0) {
  self endon("left_low_cover");
  self endon("death");
  var_1 = 1;

  if(isDefined(var_0.script_trace) && var_0.script_trace == 0)
    var_1 = 0;

  for(;;) {
    if(var_1 && !scripts\engine\trace::ray_trace_passed(self.origin, self.origin + (0, 0, 60), self))
      self.underlowcover = 1;
    else if(!var_1 && ispointinvolume(self.origin, var_0))
      self.underlowcover = 1;
    else
      self.underlowcover = undefined;

    wait 0.15;
  }
}

transfer_damage_to_player(var_0) {
  self endon("left_low_cover");
  self endon("death");
  var_1 = var_0 scripts\engine\utility::get_linked_ents()[0];

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = 1;

  while(isDefined(var_1)) {
    var_1 waittill("damage", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);

    if(!isalive(var_4)) {
      continue;
    }
    if(var_4 == self) {
      continue;
    }
    if(!self istouching(var_1)) {
      continue;
    }
    if(scripts\engine\utility::is_equal(var_7, "MOD_MELEE")) {
      continue;
    }
    if(issubstr(var_7, "BULLET")) {
      var_13 = anglesToForward(var_4 gettagangles("tag_flash"));
      var_14 = vectorNormalize(self getEye() - var_4 gettagorigin("tag_flash"));

      if(vectordot(var_13, var_14) < 0.9) {
        continue;
      }
      if(var_2) {
        var_2 = 0;
        wait 2;
        continue;
      }
    }

    self dodamage(var_3, var_4.origin, var_4, var_4, var_7, var_4.weapon);
  }
}