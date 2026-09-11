/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\combat.gsc
***********************************************/

function soldier_init_common() {
  thread low_cover_combat_areas();
  self.boredofcoverinterval = randomintrange(10000, 15000);
}

function updateeveryframe_noncombat(var0) {
  scripts\asm\asm_bb::bb_requestweapon(weaponclass(self.primaryweapon));
  var1 = scripts\asm\asm::asm_getephemeraleventdata("ai_notify", "bulletwhizby");

  if(isDefined(var1)) {
    if(!isDefined(self.disablebulletwhizbyreaction)) {
      var2 = var1[0];
      var3 = isDefined(var2) && distancesquared(self.origin, var2.origin) < 160000;

      if(var3 || scripts\engine\utility::cointoss()) {
        var4 = spawnStruct();
        var4.gametime = gettime() - 50;
        var4.params = var1;
        scripts\asm\asm_bb::bb_requestwhizby(var4);
      }
    }
  } else {
    var5 = 100;
    var1 = scripts\asm\asm_bb::bb_getrequestedwhizby();

    if(!isDefined(var1) || gettime() > var1.gametime + var5) {
      scripts\asm\asm_bb::bb_requestwhizby(undefined);
    }
  }

  self.looktarget = undefined;
  return anim.success;
}

function shouldbefrantic() {
  if(isDefined(self.frantic)) {
    return self.frantic;
  }

  return 0;
}

function updateeveryframe_global(var0) {
  if(istrue(self.in_melee_death) || istrue(self.a.doinglongdeath)) {
    return anim.failure;
  }

  var1 = isDefined(self.enemy) || isDefined(self.fnisinstealthcombat) && [[self.fnisinstealthcombat]]();
  self.bisincombat = var1;

  if(istrue(self.shouldjoinsquad)) {
    scripts\aitypes\squad::updatesquad();
  }

  if(istrue(self.domagicdoorchecks)) {
    scripts\aitypes\common::updateeveryframe_magicdoorchecks();
  }

  self.smartfacingpos = self updateaiminfo();
  var2 = getmovetype();
  scripts\asm\asm_bb::bb_requestmovetype(var2);
  return anim.success;
}

function updatewhizby(var0) {
  var1 = scripts\asm\asm::asm_getephemeraleventdata("ai_notify", "bulletwhizby");

  if(isDefined(var1) && isDefined(self.a)) {
    if(randomfloat(1) < self.a.reacttobulletchance) {
      var2 = spawnStruct();
      var2.gametime = gettime() - 50;
      var2.params = var1;
      scripts\asm\asm_bb::bb_requestwhizby(var2);
    }
  } else {
    var3 = 100;
    var1 = scripts\asm\asm_bb::bb_getrequestedwhizby();

    if(!isDefined(var1) || gettime() > var1.gametime + var3) {
      scripts\asm\asm_bb::bb_requestwhizby(undefined);
    }
  }

  return anim.success;
}

function getmovetype() {
  if(isDefined(self.grenade)) {
    return "combat";
  }

  var0 = scripts\aitypes\bt_util::bt_getdemeanor();
  return var0;
}

function hasammoinclip() {
  var0 = getusedturret();

  if(isDefined(var0)) {
    return true;
  }

  if(!isDefined(self.weapon)) {
    return false;
  }

  if(self.bulletsinclip > 0 || istrue(self.disablereload)) {
    return true;
  }

  return false;
}

function islowonammo(var0, var1) {
  if(scripts\anim\utility_common::needtoreload(var1)) {
    return anim.success;
  }

  return anim.failure;
}

function withindistancetoenemy(var0, var1) {
  if(!isDefined(self.enemy)) {
    return anim.failure;
  }

  if(distancesquared(self.origin, self.enemy.origin) <= var1 * var1) {
    return anim.success;
  }

  return anim.failure;
}

function iscoverblockedbywall(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 1000;
  }

  if(scripts\asm\asm_bb::bb_getrequestedcoverstate() != "exposed") {
    return anim.failure;
  }

  if(isDefined(self._blackboard.initialcovergunblockedbywalltime)) {
    if(gettime() - self._blackboard.initialcovergunblockedbywalltime > var1) {
      if(scripts\asm\shared\utility::blockedbywall(0)) {
        return anim.success;
      }
    }
  }

  return anim.failure;
}

function mayshoot(var0) {
  if(!isDefined(self.weapon)) {
    return anim.failure;
  }

  var1 = shouldshoot();

  if(var1) {
    var1 = calcgoodshootpos();
  } else {
    self.goodshootpos = undefined;
  }

  if(!var1) {
    return anim.failure;
  }

  return anim.success;
}

function updatelooktarget(var0) {
  if(!isDefined(self.looktarget) || self.looktarget != self.enemy) {
    self.looktarget = self.enemy;
  }

  return anim.success;
}

function shoot_clearconvergence() {
  self._blackboard.shootparams_bconvergeontarget = 0;
}

function shoot_enableconvergence() {
  self._blackboard.shootparams_bconvergeontarget = 1;
}

function shoot_init(var0) {
  self.bt.m_bfiring = 0;
  self.looktarget = self.enemy;
  self.bc_looktarget = self.enemy;
  scripts\asm\asm_bb::bb_claimshootparams(var0);

  if(scripts\anim\utility_common::isasniper()) {
    shoot_enableconvergence();
    self.snipershotcount = 0;
    self.sniperhitcount = 0;
    return;
  }
}

function shoot_terminate(var0) {
  if(istrue(self._blackboard.shootparams_valid) && self._blackboard.shootparams_taskid == var0) {
    scripts\asm\asm_bb::bb_clearshootparams();
    shoot_clearconvergence();
  }

  self.bt.m_bfiring = 0;
  self.bc_looktarget = undefined;
  scripts\asm\asm_bb::bb_requestfire(0);
}

function isaimedataimtarget() {
  return scripts\asm\track::aimedataimtarget();
}

function resetmisstime() {
  if(isDefined(self.fnresetmisstime)) {
    return self[[self.fnresetmisstime]]();
  }
}

function getturretaimangles(var0) {
  if(isDefined(self.fngetturretaimangles)) {
    return self[[self.fngetturretaimangles]](var0);
  }

  return 0;
}

function shoot_update(var0) {
  var1 = getusedturret();

  if(isDefined(self.enemy) && !isPlayer(self.enemy) && istrue(self._blackboard.shootparams_valid) && self._blackboard.shootparams_starttime < gettime()) {
    var2 = int(gettime() / 50);

    if(self getentitynumber() % 4 != var2 % 4) {
      if(!istrue(self.baimedataimtarget) && !istrue(self.casualkiller)) {
        self.bt.m_bfiring = 0;
        scripts\asm\asm_bb::bb_requestfire(self.bt.m_bfiring);
      }

      return anim.running;
    }
  }

  var3 = undefined;
  var4 = undefined;
  var5 = self.enemy;

  if(isDefined(var1)) {
    var6 = getturretaimangles(var1);
    var7 = anglesToForward(var6);
    var7 = rotatevector(var7, self.angles);
    var8 = scripts\asm\shared\utility::getshootfrompos();
    var3 = var8 + var7 * 512;
    var4 = 0;
  } else if(isDefined(self.goodshootpos)) {
    var3 = self.goodshootpos;
    var4 = 0;
  } else if(self cansee(self.enemy)) {
    var3 = self.enemy getshootatpos();
    var4 = 1;
  } else {
    return anim.success;
  }

  if(!istrue(self._blackboard.shootparams_valid)) {
    scripts\asm\asm_bb::bb_newshootparams(var3, var5, var4);
  } else {
    scripts\asm\asm_bb::bb_updateshootparams(var3, var5, var4);
  }

  if(istrue(self.baimedataimtarget) || isaimedataimtarget()) {
    if(scripts\asm\shared\utility::blockedbywall(0)) {
      self.bt.m_bfiring = 0;
    } else {
      if(!self.bt.m_bfiring) {
        resetmisstime();
      }

      chooseshootposandobjective();
      self.bt.m_bfiring = istrue(self._blackboard.shootparams_valid);
    }
  } else {
    self.bt.m_bfiring = 0;
  }

  if(!isDefined(self._blackboard.shootparams_pos) && !isDefined(self._blackboard.shootparams_ent)) {
    return anim.success;
  }

  scripts\asm\asm_bb::bb_requestfire(self.bt.m_bfiring);
  return anim.running;
}

function hasatleastammo(var0) {
  if(nullweapon(self.weapon)) {
    return false;
  }

  return self.bulletsinclip >= weaponclipsize(self.weapon) * var0;
}

function reload_cheatammo() {
  var0 = weaponclipsize(self.weapon);
  self.bulletsinclip = int(var0 * 0.5);
  self.bulletsinclip = int(clamp(self.bulletsinclip, 0, var0));
}

function chooseshootstyle() {
  var0 = 62500;
  var1 = 810000;
  var2 = 2560000;
  var3 = weaponclass(self.weapon);
  var4 = getusedturret();
  var5 = isDefined(var4);

  if(isDefined(self.shootstyleoverride)) {
    var6 = 0;

    if(isDefined(self.bt.shootstylefastburst)) {
      var6 = self.bt.shootstylefastburst;
    }

    return setshootstyle(self.shootstyleoverride, var6);
  }

  if(var4 == "mg" || var6) {
    return setshootstyle("mg", 0);
  }

  if(isDefined(self._blackboard.shootparams_ent) && isDefined(self._blackboard.shootparams_ent.enemy) && isDefined(self._blackboard.shootparams_ent.enemy.syncedmeleetarget)) {
    return setshootstyle("single", 0);
  }

  if(scripts\anim\utility_common::isasniper()) {
    return setshootstyle("single", 0);
  }

  if(var4 == "rocketlauncher" || var4 == "pistol") {
    return setshootstyle("single", 0);
  }

  if(scripts\anim\utility_common::isshotgun(self.weapon)) {
    if(scripts\anim\utility_common::weapon_pump_action_shotgun()) {
      return setshootstyle("single", 0);
    } else {
      return setshootstyle("semi", 0);
    }
  }

  if(var4 == "grenade") {
    return setshootstyle("single", 0);
  }

  if(weaponburstcount(self.weapon) > 0) {
    return setshootstyle("burst", 0);
  }

  var7 = distancesquared(self getshootatpos(), self._blackboard.shootparams_pos);

  if(var7 < var1) {
    if(isDefined(self._blackboard.shootparams_ent) && isDefined(self._blackboard.shootparams_ent.magic_bullet_shield)) {
      return setshootstyle("single", 0);
    }

    return setshootstyle("full", 0);
  }

  if(var7 < var2 || shouldbeajerk()) {
    if(weaponissemiauto(self.weapon) || shoulddosemiforvariety(var7)) {
      return setshootstyle("semi", 1);
    }

    return setshootstyle("burst", 1);
  }

  if(self.providecoveringfire || var7 < var3) {
    if(shoulddosemiforvariety(var7)) {
      return setshootstyle("semi", 0);
    }

    return setshootstyle("burst", 0);
  }

  if(shoulddosemiforvariety(var7)) {
    return setshootstyle("semi", 0);
  }

  return setshootstyle("single", 0);
}

function setshootstyle(var0, var1) {
  self._blackboard.shootparams_style = var0;
  self._blackboard.shootparams_fastburst = var1;
}

function shouldbeajerk() {
  if(!isDefined(level.gameskill)) {
    return false;
  }

  return level.gameskill == 3 && isPlayer(self.enemy);
}

function shoulddosemiforvariety(var0) {
  var1 = randomfloat(1);
  var2 = shoulddosemiprobabilityline(var0);
  return var1 <= var2;
}

function shoulddosemiprobabilityline(var0) {
  if(var0 < 2.56e+06) {
    return -1;
  }

  return -4.65839e-08 * var0 - -0.119255 + 0.5;
}

function getusedturret() {
  if(isDefined(self.fngetusedturret)) {
    return [[self.fngetusedturret]]();
  }
}

function shouldshoot() {
  if(!self aimayshoot()) {
    return false;
  }

  if(istrue(self._blackboard.partialgestureplaying)) {
    return false;
  }

  if(isDefined(self.pathgoalpos) && !scripts\asm\track::canaimwhilemoving()) {
    return false;
  }

  return true;
}

function calcgoodshootpos() {
  if(self cansee(self.enemy)) {
    if(self canshootenemy()) {
      scripts\anim\utility_common::dontgiveuponsuppressionyet();
      self.goodshootpos = self.enemy getshootatpos();
      return 1;
    }
  }

  var0 = scripts\anim\utility_common::cansuppressenemy();
  return var0;
}

function chooseshootposandobjective() {
  if(isDefined(self.shootposoverride)) {
    if(!isDefined(self.enemy)) {
      scripts\asm\asm_bb::bb_updateshootparams_pos(self.shootposoverride);
    }

    self.shootposoverride = undefined;
  }

  var0 = shootobjective();

  if(isDefined(var0) && var0 == "retry") {
    var0 = shootobjective();
  }
}

function shootobjective() {
  if(self._blackboard.shootparams_objective == "normal") {
    var0 = shootobjective_internal();
    return var0;
  }

  if(scripts\anim\utility_common::shouldshootenemyent()) {
    self._blackboard.shootparams_objective = "normal";
    return "retry";
  }

  var1 = scripts\anim\utility_common::cansuppressenemy();

  if(self._blackboard.shootparams_objective == "suppress" || self.team == "allies" && !isDefined(self.enemy) && !var1) {
    shootobjective_suppress(var1);
    return;
  }
}

function shootobjective_internal() {
  if(!scripts\anim\utility_common::shouldshootenemyent()) {
    if(!isDefined(self.enemy)) {
      havenothingtoshoot();
      return;
    }

    if((self.providecoveringfire || randomint(5) > 0) && shouldsuppress()) {
      self._blackboard.shootparams_objective = "suppress";
    } else {
      self._blackboard.shootparams_objective = "ambush";
    }

    return "retry";
  }

  setshootenttoenemy();
}

function shouldsuppress() {
  var0 = 40000;

  if(isDefined(self.enemy) && isDefined(self.pathgoalpos) && distance2dsquared(self.origin, self.enemy.origin) < var0) {
    return false;
  }

  return !self.doingambush;
}

function setshootenttoenemy() {
  var0 = self.enemy getshootatpos();
  scripts\asm\asm_bb::bb_updateshootparams(var0, self.enemy, 1);
}

function shootobjective_suppress(var0) {
  if(!var0) {
    havenothingtoshoot();
    return;
  }

  var1 = getenemysightpos();
  scripts\asm\asm_bb::bb_updateshootparams(var1, self.enemy, 0);
}

function getenemysightpos() {
  return self.goodshootpos;
}

function havenothingtoshoot() {
  self.bt.m_bfiring = 0;
  scripts\asm\asm_bb::bb_requestfire(0);
  scripts\asm\asm_bb::bb_clearshootparams();
}

function reacquire_checkadvanceonenemyconditions() {
  if(!isDefined(level.lastadvancetoenemytime) || !isDefined(level.lastadvancetoenemytime[self.team])) {
    return false;
  }

  if(shouldhelpadvancingteammate()) {
    return true;
  }

  if(level.lastadvancetoenemytime[self.team] > 0 && gettime() - level.lastadvancetoenemytime[self.team] < level.advancetoenemyinterval) {
    return false;
  }

  if(!issentient(self.enemy)) {
    return false;
  }

  if(level.advancetoenemygroup[self.team]) {
    level.advancetoenemygroup[self.team] = 0;
  }

  var0 = isDefined(self.advance_regardless_of_numbers) && self.advance_regardless_of_numbers;

  if(!var0 && getaicount(self.team) < getaicount(self.enemy.team)) {
    return false;
  }

  return true;
}

function shouldhelpadvancingteammate() {
  if(level.advancetoenemygroup[self.team] > 0 && level.advancetoenemygroup[self.team] < level.advancetoenemygroupmax) {
    if(gettime() - level.lastadvancetoenemytime[self.team] > 4000) {
      return false;
    }

    var0 = level.lastadvancetoenemyattacker[self.team];

    if(var0 == self) {
      return false;
    }

    var1 = isDefined(var0) && distancesquared(self.origin, var0.origin) < 65536;

    if((var1 || distancesquared(self.origin, level.lastadvancetoenemysrc[self.team]) < 65536) && (!isDefined(self.enemy) || distancesquared(self.enemy.origin, level.lastadvancetoenemydest[self.team]) < 262144)) {
      return true;
    }
  }

  return false;
}

function shouldattemptreacquirecharge() {
  return shouldattemptanyreacquire();
}

function shouldattemptanyreacquire() {
  if(self.fixednode) {
    return false;
  }

  if(scripts\engine\utility::actor_is3d()) {
    return false;
  }

  if(!isDefined(self.enemy)) {
    return false;
  }

  if(scripts\aitypes\squad::isinsquad()) {
    return false;
  }

  if(weaponclass(self.weapon) == "mg") {
    return false;
  }

  if(self.combatmode == "ambush" || self.combatmode == "ambush_nodes_only") {
    return false;
  }

  if(self cansee(self.enemy) && self canshootenemy()) {
    return false;
  }

  return true;
}

function reacquire_init(var0) {
  self.bt.instancedata[var0] = spawnStruct();
}

function reacquire_terminate(var0) {
  self.bt.instancedata[var0] = undefined;
  self._blackboard.reacquiredtime = undefined;
}

function reacquire_charge_terminate(var0) {
  self.bt.instancedata[var0] = undefined;
  self._blackboard.reacquiredtime = undefined;
}

function reacquire_clear(var0) {
  self reacquireclear();
}

function reacquire_step(var0, var1) {
  var2 = self.bt.instancedata[var0];

  if(!istrue(var2.binited)) {
    if(istrue(self.aggressivemode)) {
      return anim.failure;
    }

    var2.binited = 1;
    self._blackboard.reacquiresteptime = gettime();

    if(self reacquirestep(var1)) {
      return anim.running;
    }

    return anim.failure;
  }

  var3 = self getreacquirestate();
  self._blackboard.reacquiresteptime = gettime();

  if(var3 == "reacquired") {
    if(!isDefined(self._blackboard.reacquiredtime)) {
      self._blackboard.reacquiredtime = gettime() + 5000;
    }

    if(!istrue(var2.loweredreacquiredtime) && (!isDefined(self.enemy) || issentient(self.enemy) && !self seerecently(self.enemy, 2))) {
      self._blackboard.reacquiredtime -= 3000;
      var2.loweredreacquiredtime = 1;
    }

    if(gettime() > self._blackboard.reacquiredtime) {
      self reacquireclear();
      return anim.success;
    }

    return anim.running;
  } else if(var3 == "enabled") {
    if(istrue(var2.bpossiblefail)) {
      return anim.failure;
    }

    if(!self.arriving && !isDefined(self.pathgoalpos) && !istrue(self.pathpending)) {
      var2.bpossiblefail = 1;
    }

    return anim.running;
  }

  self reacquireclear();
  return anim.success;
}

function reacquire_attemptcharge() {
  if(!self isingoal(self.enemy.origin)) {
    return false;
  }

  if(scripts\anim\utility_common::islongrangeai()) {
    return false;
  }

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
    return true;
  }

  return false;
}

function reacquire_charge(var0) {
  var1 = self.bt.instancedata[var0];

  if(!istrue(var1.binited)) {
    if(!shouldattemptreacquirecharge()) {
      return anim.failure;
    }

    var1.binited = 1;

    if(!reacquire_checkadvanceonenemyconditions()) {
      return anim.success;
    }

    if(reacquire_attemptcharge()) {
      return anim.running;
    }

    return anim.failure;
  }

  var2 = self getreacquirestate();
  self._blackboard.reacquiresteptime = gettime();

  if(var2 == "reacquired") {
    if(!isDefined(self._blackboard.reacquiredtime)) {
      self._blackboard.reacquiredtime = gettime() + 5000;
    }

    if(!istrue(var1.loweredreacquiredtime) && (!isDefined(self.enemy) || issentient(self.enemy) && !self seerecently(self.enemy, 2))) {
      self._blackboard.reacquiredtime -= 3000;
      var1.loweredreacquiredtime = 1;
    }

    if(gettime() > self._blackboard.reacquiredtime) {
      self reacquireclear();
      return anim.success;
    }

    return anim.running;
  } else if(var2 == "enabled") {
    if(self isingoal(self.origin)) {
      return anim.failure;
    }

    self findreacquiredirectpath(0);
    return anim.running;
  }

  return anim.failure;
}

function badplaceavoid(var0) {
  if(scripts\asm\asm_bb::bb_moverequested()) {
    return anim.failure;
  }

  var1 = self getposoutsidebadplace(128);

  if(isDefined(var1)) {
    self setbtgoalpos(2, var1);
    self._blackboard.badplaceavoidstarttime = gettime();
    return anim.success;
  }

  return anim.failure;
}

function waituntilnotinbadplace(var0) {
  var1 = gettime();

  if(var1 > self._blackboard.badplaceavoidstarttime + 100 && !isDefined(self.pathgoalpos) && !istrue(self.pathpending)) {
    return anim.failure;
  }

  if(var1 > self._blackboard.badplaceavoidstarttime + 5000) {
    return anim.failure;
  }

  return anim.running;
}

function badplaceterminate(var0) {
  self clearbtgoal(2);
  self._blackboard.badplaceavoidstarttime = undefined;
}

function isenemyinlowcover(var0) {
  if(!isDefined(self.enemy) || !issentient(self.enemy)) {
    return anim.failure;
  }

  if(!isDefined(self.enemy.lowcovervolume)) {
    return anim.failure;
  }

  if(!isDefined(self.enemy.underlowcover)) {
    return anim.failure;
  }

  if(isDefined(self.melee)) {
    return anim.failure;
  }

  var1 = self lastknownpos(self.enemy);
  var2 = 0;

  if(istrue(self.aggressivelowcovermode)) {
    var3 = distancesquared(self.origin, var1);
    var4 = 3600;

    if(isDefined(self.aggressivelowcover_dist)) {
      var4 = self.aggressivelowcover_dist * self.aggressivelowcover_dist;
    }

    if(var3 < var4) {
      var2 = 1;
    } else if(distancesquared(self.origin, self.enemy.origin) < var4) {
      var2 = 1;
    }
  }

  if(!var2) {
    var5 = self lastknowntime(self.enemy);

    if(var5 <= gettime() - 5000) {
      return anim.failure;
    }

    if(!ispointinvolume(var1, self.enemy.lowcovervolume)) {
      return anim.failure;
    }
  }

  var6 = self.enemy.lowcovervolume scripts\engine\utility::get_linked_nodes();

  if(var6.size == 0) {
    return anim.failure;
  }

  var6 = sortbydistance(var6, var1);

  foreach(var8 in var6) {
    if(isDefined(showcinematicletterboxing(var8)) && showcinematicletterboxing(var8) != self) {
      continue;
    }

    self setbtgoalnode(1, var8);
    self setbtgoalRadius(1, 12);
    return anim.success;
  }

  return anim.failure;
}

function enemyinlowcover_init(var0) {
  var1 = self lastknownpos(self.enemy);
  var2 = spawnStruct();
  var2.enemy = self.enemy;
  var2.vol = self.enemy.lowcovervolume;
  var2.lastknownposatstart = var1;
  self.bt.instancedata[var0] = var2;
  self.dontgiveuponsuppression = 1;
  self.suppress_uselastenemysightpos = 1;
  var3 = scripts\anim\utility_common::getenemyeyepos();
  self.lastenemysightpos = var1 + (0, 0, var3[2] - self.enemy.origin[2]);
  self.benemyinlowcover = 1;
  self notify("enemyInLowCover", var2.vol);
}

function enemyinlowcover_update(var0) {
  var1 = self.bt.instancedata[var0];

  if(!isDefined(var1.enemy) || !isalive(var1.enemy)) {
    return anim.failure;
  }

  if(!isDefined(self.enemy) || self.enemy != var1.enemy) {
    return anim.failure;
  }

  var2 = gettime();
  var3 = self lastknownpos(self.enemy);

  if(distancesquared(var1.lastknownposatstart, var3) > 1 && !ispointinvolume(var3, var1.vol)) {
    return anim.failure;
  }

  var4 = isDefined(self.enemy.underlowcover) && ispointinvolume(self.enemy.origin, var1.vol);

  if(var4) {
    var1.timeenemyleftvolume = undefined;
  } else if(!isDefined(var1.timeenemyleftvolume)) {
    var1.timeenemyleftvolume = var2;
  }

  if(isDefined(var1.timeenemyleftvolume) && var2 > var1.timeenemyleftvolume + 5000) {
    return anim.failure;
  }

  self.lastenemysightpos = vectorlerp(self.lastenemysightpos, scripts\anim\utility_common::getenemyeyepos(), 0.1);
  return anim.running;
}

function enemyinlowcover_terminate(var0) {
  self.bt.instancedata[var0] = undefined;
  self.dontgiveuponsuppression = undefined;
  self.suppress_uselastenemysightpos = undefined;
  self.benemyinlowcover = undefined;
  self clearbtgoal(1);
  self notify("enemyLeftLowCover");
}

function valid_reaction_sound(var0) {
  switch (var0) {
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
      return true;
  }

  return false;
}

function turretrequested(var0) {
  if(isDefined(scripts\asm\asm_bb::bb_getrequestedturret())) {
    return anim.success;
  }

  return anim.failure;
}

function getplayerthatseesmyscope() {
  var0 = self getEye();

  foreach(var2 in level.players) {
    if(!self cansee(var2)) {
      continue;
    }

    var3 = var2 getEye();
    var4 = vectortoangles(var0 - var3);
    var5 = anglesToForward(var4);
    var6 = var2 getplayerangles();
    var7 = anglesToForward(var6);
    var8 = vectordot(var5, var7);

    if(var8 < 0.805) {
      continue;
    }

    if(scripts\engine\utility::cointoss() && var8 >= 0.996) {
      continue;
    }

    return var2;
  }

  return undefined;
}

function updatesniperglint(var0) {
  if(self.team != "axis") {
    return anim.success;
  }

  if(isDefined(self.disable_sniper_glint) && self.disable_sniper_glint) {
    return anim.success;
  }

  if(!scripts\anim\utility_common::isasniper()) {
    return anim.success;
  }

  var1 = createheadicon(self.weapon);

  if(self.weaponinfo[var1].position == "none") {
    return anim.success;
  }

  var2 = level.g_effect["sniper_glint"];

  if(!isDefined(var2)) {
    return anim.success;
  }

  if(!isDefined(self.next_sniper_glint_time)) {
    self.next_sniper_glint_time = gettime() + randomintrange(3000, 5000);
  }

  if(!isDefined(self.enemy) || !isalive(self.enemy)) {
    return anim.success;
  }

  if(gettime() < self.next_sniper_glint_time) {
    return anim.success;
  }

  self.next_sniper_glint_time = gettime() + 200;

  if(self.weapon != self.primaryweapon) {
    return anim.success;
  }

  var3 = getplayerthatseesmyscope();

  if(!isDefined(var3)) {
    return anim.success;
  }

  if(distancesquared(self.origin, var3.origin) < 65536) {
    return anim.success;
  }

  if(scripts\asm\asm_bb::bb_shootparamsvalid() && isDefined(self._blackboard.shootparams_pos)) {
    var4 = self getmuzzledir();
    var5 = vectorNormalize(self._blackboard.shootparams_pos - self getEye());
    var6 = vectordot(var4, var5);

    if(var6 < 0.906) {
      self.next_sniper_glint_time = undefined;
      return anim.success;
    }
  } else {
    self.next_sniper_glint_time = undefined;
    return anim.success;
  }

  playFXOnTag(var2, self, "tag_flash");
  self.next_sniper_glint_time = gettime() + randomintrange(3000, 5000);
  return anim.success;
}

function ifshoulddosmartobject(var0) {
  var1 = scripts\asm\asm_bb::bb_getrequestedsmartobject();

  if(!isDefined(var1)) {
    return anim.failure;
  }

  if(isDefined(self.disablesmartobjects)) {
    return anim.failure;
  }

  var2 = self.origin[2] - var1.origin[2];

  if(var2 * var2 > 5184) {
    return anim.failure;
  }

  if(distance2dsquared(self.origin, var1.origin) > 225) {
    return anim.failure;
  }

  return anim.success;
}

function dosmartobject_init(var0) {
  scripts\asm\asm_bb::bb_requestplaysmartobject();

  if(isDefined(self.asm.customdata.arrivalangles)) {
    self.asm.customdata.arrivalangles = undefined;
  }

  self.bt.instancedata[var0] = self.disableautolookat;
  self.disableautolookat = 1;
}

function dosmartobject(var0) {
  if(self asmephemeraleventfired("smartobject", "finished")) {
    var1 = scripts\asm\asm_bb::bb_getrequestedsmartobject();
    var1 scripts\smartobjects\utility::smartobject_setnextuse();
    return anim.success;
  }

  return anim.running;
}

function dosmartobjectterminate(var0) {
  scripts\smartobjects\utility::clearsmartobject(scripts\asm\asm_bb::bb_getrequestedsmartobject());
  self.disableautolookat = self.bt.instancedata[var0];
  self.bt.instancedata[var0] = undefined;
}

function low_cover_combat_areas() {
  if(istrue(level.low_cover_combat_setup)) {
    return;
  }

  level.low_cover_combat_setup = 1;

  for(;;) {
    var0 = getEntArray("low_cover_area", "targetname");

    foreach(var2 in level.players) {
      var3 = undefined;

      foreach(var5 in var0) {
        if(ispointinvolume(var2.origin, var5)) {
          var3 = var5;
          break;
        }
      }

      if(isDefined(var2.lowcovervolume) && (!isDefined(var3) || var2.lowcovervolume != var3)) {
        var2 notify("left_low_cover");
        var2.underlowcover = undefined;
      }

      if(isDefined(var3) && (!isDefined(var2.lowcovervolume) || var3 != var2.lowcovervolume)) {
        thread transfer_damage_to_player(var2);
        thread player_under_low_cover_monitor(var2);
      }

      var2.lowcovervolume = var3;
    }

    waitframe();
  }
}

function player_under_low_cover_monitor(var0) {
  self endon("left_low_cover");
  self endon("death");
  var1 = 1;

  if(isDefined(var0.script_trace) && var0.script_trace == 0) {
    var1 = 0;
  }

  for(;;) {
    if(var1 && !scripts\engine\trace::ray_trace_passed(self.origin, self.origin + (0, 0, 60), self)) {
      self.underlowcover = 1;
    } else if(!var1 && ispointinvolume(self.origin, var0)) {
      self.underlowcover = 1;
    } else {
      self.underlowcover = undefined;
    }

    wait 0.15;
  }
}

function transfer_damage_to_player(var0) {
  self endon("left_low_cover");
  self endon("death");
  var1 = var0 scripts\engine\utility::get_linked_ents()[0];

  if(!isDefined(var1)) {
    return;
  }

  var2 = 1;

  while(isDefined(var1)) {
    var1 waittill("damage", var3, var4, var5, var6, var7, var8, var9, var10, var11, var12);

    if(!isalive(var4)) {
      continue;
    }

    if(var4 == self) {
      continue;
    }

    if(!self istouching(var1)) {
      continue;
    }

    if(scripts\engine\utility::is_equal(var7, "MOD_MELEE")) {
      continue;
    }

    if(issubstr(var7, "BULLET")) {
      var13 = anglesToForward(var4 gettagangles("tag_flash"));
      var14 = vectorNormalize(self getEye() - var4 gettagorigin("tag_flash"));

      if(vectordot(var13, var14) < 0.9) {
        continue;
      }

      if(var2) {
        var2 = 0;
        wait 2;
        continue;
      }
    }

    self dodamage(var3, var4.origin, var4, var4, var7, var4.weapon);
  }
}