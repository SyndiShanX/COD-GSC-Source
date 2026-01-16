/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\cover_behavior.gsc
******************************************/

#include animscripts\combat_utility;
#include animscripts\cover_utility;
#include animscripts\debug;
#include animscripts\shared;
#include animscripts\utility;
#include common_scripts\utility;
#include maps\_utility;
#include animscripts\shoot_behavior;

coverglobalsinit() {
  anim.coverglobals = spawnstruct();
  anim.coverglobals.desynched_time = 2500;
  anim.coverglobals.respond_to_death_retry_interval = 30000;
  anim.coverglobals.min_grenade_throw_distance_sq = 562500;
  anim.coverglobals.suppress_wait_min = 3000;
  anim.coverglobals.suppress_wait_ambush_min = 6000;
  anim.coverglobals.suppress_wait_max = 20000;
  anim.coverglobals.look_wait_min = 4000;
  anim.coverglobals.look_wait_max = 15000;
  anim.coverglobals.enemy_blindfire_wait_time_min = 3000;
  anim.coverglobals.enemy_blindfire_wait_time_max = 12000;
  anim.coverglobals.ally_blindfire_wait_time_min = 8000;
  anim.coverglobals.ally_blindfire_wait_time_max = 12000;
  anim.coverglobals.peekout_offset = 30;
  anim.coverglobals.corner_left_lean_yaw_max = -60;
  anim.coverglobals.corner_right_lean_yaw_max = 60;
  anim.coverglobals.corner_left_ab_yaw = 14;
  anim.coverglobals.corner_right_ab_yaw = -14;
}

main(behaviorcallbacks) {
  self.couldntseeenemypos = self.origin;
  behaviorstarttime = gettime();
  resetlookforbettercovertime();
  resetseekoutenemytime();
  resetrespondtodeathtime();
  self.a.lastencountertime = behaviorstarttime;
  self.a.nextallowedlooktime = behaviorstarttime;
  self.a.nextallowedsuppresstime = behaviorstarttime;
  self.a.idlingatcover = 0;
  self.a.movement = "stop";
  self thread watchplayeraim();
  self thread watchsuppression();
  self thread animscripts\utility::idlelookatbehavior(160, 1);
  desynched = gettime() > anim.coverglobals.desynched_time;
  correctangles = getcorrectcoverangles();

  for(;;) {
    if(isDefined(behaviorcallbacks.mainloopstart)) {
      starttime = gettime();
      self thread endidleatframeend();
      [
        [behaviorcallbacks.mainloopstart]
      ]();

      if(gettime() == starttime)
        self notify("dont_end_idle");
    }

    if(runforcedbehaviors(behaviorcallbacks)) {
      continue;
    }
    if(movetonearbycover()) {
      continue;
    }
    angles = (correctangles[0], angleclamp180(correctangles[1]), correctangles[2]);
    self teleport(self.covernode.origin, angles);

    if(!desynched) {
      idle(behaviorcallbacks, 0.05 + randomfloat(1.5));
      desynched = 1;
      continue;
    }

    if(throwgrenadeatenemyasap(behaviorcallbacks)) {
      continue;
    }
    if(dononattackcoverbehavior(behaviorcallbacks)) {
      continue;
    }
    if(respondtodeadteammate()) {
      return;
    }
    visibleenemy = 0;
    suppressableenemy = 0;

    if(isalive(self.enemy)) {
      visibleenemy = isenemyvisiblefromexposed();
      suppressableenemy = cansuppressenemyfromexposed();
    }

    if(visibleenemy) {
      if(self.a.getboredofthisnodetime < gettime()) {
        if(lookforbettercover())
          return;
      }

      attackvisibleenemy(behaviorcallbacks);
      continue;
    }

    if(isDefined(self.aggressivemode) && self.aggressivemode || enemyishiding()) {
      if(advanceonhidingenemy())
        return;
    }

    if(suppressableenemy) {
      attacksuppressableenemy(behaviorcallbacks);
      continue;
    }

    if(attacknothingtodo(behaviorcallbacks))
      return;
  }
}

end_script() {
  self.turntomatchnode = 0;
  self.a.prevattack = undefined;

  if(isDefined(self.meleecoverchargemintime) && self.meleecoverchargemintime <= gettime()) {
    self.meleecoverchargegraceendtime = gettime() + 0;
    self.meleecoverchargemintime = undefined;
  }
}

getcorrectcoverangles() {
  correctangles = (self.covernode.angles[0], getnodeforwardyaw(self.covernode), self.covernode.angles[2]);
  return correctangles;
}

resetrespondtodeathtime() {
  self.a.respondtodeathtime = 0;
}

resetlookforbettercovertime() {
  currenttime = gettime();

  if(isDefined(self.didshufflemove) && currenttime > self.a.getboredofthisnodetime)
    self.a.getboredofthisnodetime = currenttime + randomintrange(2000, 5000);
  else if(isDefined(self.enemy)) {
    dist = distance2d(self.origin, self.enemy.origin);

    if(dist < self.engagemindist)
      self.a.getboredofthisnodetime = currenttime + randomintrange(5000, 10000);
    else if(dist > self.engagemaxdist && dist < self.goalradius)
      self.a.getboredofthisnodetime = currenttime + randomintrange(2000, 5000);
    else
      self.a.getboredofthisnodetime = currenttime + randomintrange(10000, 15000);
  } else
    self.a.getboredofthisnodetime = currenttime + randomintrange(5000, 15000);
}

respondtodeadteammate() {
  if(self atdangerousnode() && self.a.respondtodeathtime < gettime()) {
    if(lookforbettercover())
      return true;

    self.a.respondtodeathtime = gettime() + anim.coverglobals.respond_to_death_retry_interval;
  }

  return false;
}

dononattackcoverbehavior(behaviorcallbacks) {
  if(isDefined(self.covernode.script_onlyidle) && self.covernode.script_onlyidle || isDefined(self.a.coveridleonly) && self.a.coveridleonly) {
    idle(behaviorcallbacks);
    return true;
  }

  if(shouldswitchsides(1)) {
    if(switchsides(behaviorcallbacks))
      return true;
  }

  if(suppressedbehavior(behaviorcallbacks)) {
    if(isenemyvisiblefromexposed())
      resetseekoutenemytime();

    self.a.lastencountertime = gettime();
    return true;
  }

  if(coverreload(behaviorcallbacks, 0))
    return true;

  if(animscripts\shared::shouldswitchweapons()) {
    animscripts\shared::switchweapons();

    if(isDefined(behaviorcallbacks.resetweaponanims))
      [[behaviorcallbacks.resetweaponanims]]();

    return true;
  }

  return false;
}

throwgrenadeatenemyasap(behaviorcallbacks) {
  if(isDefined(anim.throwgrenadeatplayerasap) && anim.throwgrenadeatplayerasap) {
    players = getplayers();

    if(isalive(players[0])) {
      self.grenadeammo++;

      if(trythrowinggrenade(behaviorcallbacks, players[0], 1))
        return true;
    }
  }

  if(isDefined(anim.throwgrenadeatenemyasap) && anim.throwgrenadeatenemyasap) {
    if(isDefined(self.enemy) && isalive(self.enemy)) {
      self.grenadeammo++;

      if(trythrowinggrenade(behaviorcallbacks, self.enemy, 1))
        return true;
    }
  }

  return false;
}

providecoveringfire(behaviorcallbacks) {
  if(shouldprovidecoveringfire()) {
    if(leavecoverandshoot(behaviorcallbacks, "suppress")) {
      resetseekoutenemytime();
      self.a.lastencountertime = gettime();
      return true;
    }
  }

  return false;
}

attackvisibleenemy(behaviorcallbacks) {
  if(providecoveringfire(behaviorcallbacks)) {
    return;
  }
  if(distancesquared(self.origin, self.enemy.origin) > anim.coverglobals.min_grenade_throw_distance_sq) {
    if(trythrowinggrenade(behaviorcallbacks, self.enemy))
      return;
  }

  if(leavecoverandshoot(behaviorcallbacks, "normal")) {
    resetseekoutenemytime();
    self.a.lastencountertime = gettime();
  } else
    idle(behaviorcallbacks);
}

attacksuppressableenemy(behaviorcallbacks) {
  if(self.doingambush) {
    if(leavecoverandshoot(behaviorcallbacks, "ambush"))
      return;
  } else if(self.providecoveringfire || gettime() >= self.a.nextallowedsuppresstime) {
    preferredactivity = "suppress";

    if(!self.providecoveringfire && gettime() - self.lastsuppressiontime > 5000 && randomint(3) < 2)
      preferredactivity = "ambush";
    else if(!self animscripts\shoot_behavior::shouldsuppress())
      preferredactivity = "ambush";

    if(leavecoverandshoot(behaviorcallbacks, preferredactivity)) {
      self.a.nextallowedsuppresstime = gettime() + randomintrange(anim.coverglobals.suppress_wait_min, anim.coverglobals.suppress_wait_max);

      if(isenemyvisiblefromexposed())
        self.a.lastencountertime = gettime();

      return;
    }
  }

  if(trythrowinggrenade(behaviorcallbacks, self.enemy)) {
    return;
  }
  idle(behaviorcallbacks);
}

attacknothingtodo(behaviorcallbacks) {
  if(coverreload(behaviorcallbacks, 0.1))
    return false;

  if(isvalidenemy(self.enemy)) {
    if(trythrowinggrenade(behaviorcallbacks, self.enemy))
      return false;
  }

  if(!self.doingambush && gettime() >= self.a.nextallowedlooktime) {
    if(lookforenemy(behaviorcallbacks)) {
      self.a.nextallowedlooktime = gettime() + randomintrange(anim.coverglobals.look_wait_min, anim.coverglobals.look_wait_max);
      return false;
    }
  }

  if(gettime() > self.a.getboredofthisnodetime) {
    if(cantfindanythingtodo())
      return true;
  }

  if(self.doingambush || gettime() >= self.a.nextallowedsuppresstime && isvalidenemy(self.enemy)) {
    if(leavecoverandshoot(behaviorcallbacks, "ambush")) {
      if(isenemyvisiblefromexposed())
        resetseekoutenemytime();

      self.a.lastencountertime = gettime();
      self.a.nextallowedsuppresstime = gettime() + randomintrange(anim.coverglobals.suppress_wait_ambush_min, anim.coverglobals.suppress_wait_max);
      return false;
    }
  }

  idle(behaviorcallbacks);
  return false;
}

isenemyvisiblefromexposed() {
  if(!isDefined(self.enemy))
    return 0;

  if(distancesquared(self.enemy.origin, self.couldntseeenemypos) < 256)
    return 0;
  else
    return canseeenemyfromexposed();
}

suppressedbehavior(behaviorcallbacks) {
  if(!issuppressedwrapper())
    return false;

  nextallowedblindfiretime = gettime();
  justlooked = 1;

  self animscripts\debug::debugpushstate("suppressedBehavior");

  while(issuppressedwrapper()) {
    justlooked = 0;
    self teleport(self.covernode.origin);

    if(runforcedbehaviors(behaviorcallbacks))
      return false;

    trymovingnodes = 1;

    if(isDefined(self.a.favor_blindfire) && self.a.favor_blindfire)
      trymovingnodes = cointoss();

    if(trymovingnodes && trytogetoutofdangeroussituation()) {
      self notify("killanimscript");
      waittillframeend;

      self animscripts\debug::debugpopstate("suppressedBehavior", "found better cover");

      return true;
    }

    if(shouldprovidecoveringfire()) {
      self animscripts\debug::debugpopstate("suppressedBehavior", "should provide covering fire");

      return false;
    }

    if(self.a.atconcealmentnode && self canseeenemy()) {
      self animscripts\debug::debugpopstate("suppressedBehavior", "at unsafe concealment node");

      return false;
    }

    if(isenemyvisiblefromexposed() || cansuppressenemyfromexposed()) {
      if(throwgrenadeatenemyasap(behaviorcallbacks)) {
        continue;
      }
      if(coverreload(behaviorcallbacks, 0)) {
        continue;
      }
      if(gettime() >= nextallowedblindfiretime) {
        if(blindfire(behaviorcallbacks)) {
          if(!(isDefined(self.a.favor_blindfire) && self.a.favor_blindfire)) {
            if(self.team != "allies")
              nextallowedblindfiretime = nextallowedblindfiretime + randomintrange(anim.coverglobals.enemy_blindfire_wait_time_min, anim.coverglobals.enemy_blindfire_wait_time_max);
            else
              nextallowedblindfiretime = nextallowedblindfiretime + randomintrange(anim.coverglobals.ally_blindfire_wait_time_min, anim.coverglobals.ally_blindfire_wait_time_max);
          } else
            nextallowedblindfiretime = gettime();

          continue;
        }
      }

      if(trythrowinggrenade(behaviorcallbacks, self.enemy)) {
        justlooked = 1;
        continue;
      }
    }

    if(shouldswitchsides(0)) {
      if(switchsides(behaviorcallbacks))
        continue;
    }

    if(coverreload(behaviorcallbacks, 0.1)) {
      continue;
    }
    idle(behaviorcallbacks);
  }

  if(!justlooked && randomint(2) == 0)
    peekout(behaviorcallbacks);

  self animscripts\debug::debugpopstate("suppressedBehavior");

  return true;
}

calloptionalbehaviorcallback(callback, arg, arg2, arg3) {
  if(!isDefined(callback))
    return 0;

  self thread endidleatframeend();
  starttime = gettime();
  val = undefined;

  if(isDefined(arg3))
    val = [
      [callback]
    ](arg, arg2, arg3);
  else if(isDefined(arg2))
    val = [
      [callback]
    ](arg, arg2);
  else if(isDefined(arg))
    val = [
      [callback]
    ](arg);
  else
    val = [
      [callback]
    ]();

  assert(isDefined(val) && (val == 1 || val == 0), "behavior callback must return true or false");

  if(isDefined(val) && val)
    assert(gettime() != starttime, "behavior callback must return true only if its lets time pass");
  else
    assert(gettime() == starttime, "behavior callbacks returning false must not have a wait in them");

  if(!val)
    self notify("dont_end_idle");

  return val;
}

watchsuppression() {
  self endon("killanimscript");
  self.lastsuppressiontime = gettime() - 100000;
  self.suppressionstart = self.lastsuppressiontime;

  while(true) {
    self waittill("suppression");
    time = gettime();

    if(self.lastsuppressiontime < time - 700)
      self.suppressionstart = time;

    self.lastsuppressiontime = time;
  }
}

coverreload(behaviorcallbacks, threshold) {
  if(isDefined(self.covernode.turret))
    return 0;

  assert(isDefined(self.bulletsinclip));
  assert(isDefined(self.weapon));
  assert(isDefined(threshold));
  assert(isDefined(weaponclipsize(self.weapon)));
  forcebehavior = 0;

  forcebehavior = shouldforcebehavior("reload");

  if(!forcebehavior && self.bulletsinclip > weaponclipsize(self.weapon) * threshold)
    return 0;

  self.isreloading = 1;

  self animscripts\debug::debugpushstate("reload");

  result = calloptionalbehaviorcallback(behaviorcallbacks.reload);

  self animscripts\debug::debugpopstate("reload");

  self.isreloading = 0;
  return result;
}

rambo(behaviorcallbacks) {
  return calloptionalbehaviorcallback(behaviorcallbacks.rambo);
}

leavecoverandshoot(behaviorcallbacks, initialgoal) {
  self thread animscripts\shoot_behavior::decidewhatandhowtoshoot(initialgoal);

  if(!self.fixednode && !self.doingambush)
    self thread breakoutofshootingifwanttomoveup();

  self animscripts\debug::debugpushstate("leaveCoverAndShoot");

  val = rambo(behaviorcallbacks);

  if(!val)
    val = calloptionalbehaviorcallback(behaviorcallbacks.leavecoverandshoot);

  self animscripts\debug::debugpopstate("leaveCoverAndShoot");

  self notify("stop_deciding_how_to_shoot");
  return val;
}

lookforenemy(behaviorcallbacks) {
  if(self.a.atconcealmentnode && self canseeenemy())
    return 0;

  self animscripts\debug::debugpushstate("lookForEnemy");

  looked = 0;

  if(self.a.lastencountertime + 6000 > gettime())
    looked = peekout(behaviorcallbacks);
  else {
    if(weaponisgasweapon(self.weapon))
      looked = calloptionalbehaviorcallback(behaviorcallbacks.look, 5 + randomfloat(2));
    else
      looked = calloptionalbehaviorcallback(behaviorcallbacks.look, 2 + randomfloat(2));

    if(!looked) {
      looked = calloptionalbehaviorcallback(behaviorcallbacks.fastlook);

      self animscripts\debug::debugaddstateinfo("lookForEnemy", "look failed, used fastlook");

    }
  }

  self animscripts\debug::debugpopstate("lookForEnemy");

  return looked;
}

peekout(behaviorcallbacks) {
  self animscripts\debug::debugpushstate("peekOut");

  looked = calloptionalbehaviorcallback(behaviorcallbacks.fastlook);

  if(!looked) {
    looked = calloptionalbehaviorcallback(behaviorcallbacks.look, 0);

    self animscripts\debug::debugaddstateinfo("peekOut", "fastlook failed, used look");

  }

  self animscripts\debug::debugpopstate("peekOut");

  return looked;
}

idle(behaviorcallbacks, howlong) {
  self animscripts\debug::debugpushstate("idle");

  self.flinching = 0;

  if(isDefined(behaviorcallbacks.flinch)) {
    if(!self.a.idlingatcover && gettime() - self.suppressionstart < 600) {
      if([
          [behaviorcallbacks.flinch]
        ]()) {
        self animscripts\debug::debugpopstate("idle", "flinched");

        return true;
      }
    } else
      self thread flinchwhensuppressed(behaviorcallbacks);
  }

  if(!self.a.idlingatcover) {
    assert(isDefined(behaviorcallbacks.idle));
    self thread idlethread(behaviorcallbacks.idle);
    self.a.idlingatcover = 1;
  }

  if(isDefined(howlong))
    self idlewait(howlong);
  else
    self idlewaitabit();

  if(self.flinching)
    self waittill("flinch_done");

  self notify("stop_waiting_to_flinch");

  self animscripts\debug::debugpopstate("idle");
}

idlewait(howlong) {
  self endon("end_idle");
  wait(howlong);
}

idlewaitabit() {
  self endon("end_idle");
  wait(0.3 + randomfloat(0.1));
  self waittill("do_slow_things");
}

idlethread(idlecallback) {
  self endon("killanimscript");
  self[[idlecallback]]();
}

flinchwhensuppressed(behaviorcallbacks) {
  self endon("killanimscript");
  self endon("stop_waiting_to_flinch");

  for(lastsuppressiontime = self.lastsuppressiontime; 1; lastsuppressiontime = time) {
    self waittill("suppression");
    time = gettime();

    if(lastsuppressiontime < time - 2000) {
      break;
    }
  }

  self animscripts\debug::debugpushstate("flinchWhenSuppressed");

  self.flinching = 1;
  self thread endidleatframeend();
  assert(isDefined(behaviorcallbacks.flinch));
  val = [[behaviorcallbacks.flinch]]();

  if(!val)
    self notify("dont_end_idle");

  self.flinching = 0;
  self notify("flinch_done");

  self animscripts\debug::debugpopstate("flinchWhenSuppressed");
}

endidleatframeend() {
  self endon("killanimscript");
  self endon("dont_end_idle");
  waittillframeend;

  if(!isDefined(self)) {
    return;
  }
  self notify("end_idle");
  self.a.idlingatcover = 0;
}

trythrowinggrenade(behaviorcallbacks, throwat, forcethrow) {
  result = undefined;
  forcethrow = isDefined(forcethrow) && forcethrow;

  self animscripts\debug::debugpushstate("tryThrowingGrenade");

  assert(isDefined(throwat));

  if(!canthrowgrenade()) {
    self animscripts\debug::debugpopstate("tryThrowingGrenade", "Cant throw grenade, canThrowGrenade() failed");

  }

  forward = anglestoforward(self.angles);
  dir = vectornormalize(throwat.origin - self.origin);

  if(vectordot(forward, dir) < 0 && self.a.script != "cover_pillar") {
    self animscripts\debug::debugpopstate("tryThrowingGrenade", "don't want to throw backwards");

    return 0;
  }

  if(self.a.script == "cover_pillar" && isDefined(self.covernode)) {
    forward = anglestoforward(self.covernode.angles);
    dir = vectornormalize(throwat.origin - self.covernode.origin);

    if(vectordot(forward, dir) < 0) {
      self animscripts\debug::debugpopstate("tryThrowingGrenade", "don't want to throw backwards");

      return 0;
    }
  }

  if(!forcethrow && self.doingambush && !recentlysawenemy()) {
    self animscripts\debug::debugpopstate("tryThrowingGrenade", "doingAmbush and haven't seen enemy recently");

    return 0;
  }

  if(shouldswitchsides(0))
    switchsides(behaviorcallbacks);

  if(self ispartiallysuppressedwrapper() || isDefined(forcethrow) && forcethrow)
    result = calloptionalbehaviorcallback(behaviorcallbacks.grenadehidden, throwat, forcethrow);
  else
    result = calloptionalbehaviorcallback(behaviorcallbacks.grenade, throwat);

  self animscripts\debug::debugpopstate("tryThrowingGrenade");

  return result;
}

blindfire(behaviorcallbacks) {
  if(!canblindfire())
    return 0;

  if(isDefined(self.enemy))
    self animscripts\shoot_behavior::setshootent(self.enemy);

  self animscripts\debug::debugpushstate("blindfire");

  result = calloptionalbehaviorcallback(behaviorcallbacks.blindfire);

  self animscripts\debug::debugpopstate("blindfire");

  return result;
}

breakoutofshootingifwanttomoveup() {
  self endon("killanimscript");
  self endon("stop_deciding_how_to_shoot");

  while(true) {
    if(self.fixednode || self.doingambush) {
      return;
    }
    wait(0.5 + randomfloat(0.75));

    if(!isvalidenemy(self.enemy)) {
      continue;
    }
    if(enemyishiding()) {
      if(advanceonhidingenemy())
        return;
    }

    if(!self recentlysawenemy() && !self cansuppressenemy()) {
      if(gettime() > self.a.getboredofthisnodetime) {
        if(cantfindanythingtodo())
          return;
      }
    }
  }
}

enemyishiding() {
  if(!isDefined(self.enemy))
    return false;

  if(self.enemy isflashed())
    return true;

  if(isplayer(self.enemy)) {
    if(isDefined(self.enemy.health) && self.enemy.health < self.enemy.maxhealth)
      return true;
  } else if(issentient(self.enemy) && self.enemy issuppressedwrapper())
    return true;

  if(isDefined(self.enemy.isreloading) && self.enemy.isreloading)
    return true;

  return false;
}

wouldbesmartformyaitypetoseekoutenemy() {
  if(self weaponanims() == "rocketlauncher")
    return false;

  if(self issniper())
    return false;

  return true;
}

resetseekoutenemytime() {
  if(isDefined(self.aggressivemode) && self.aggressivemode)
    self.seekoutenemytime = gettime() + randomintrange(500, 1000);
  else
    self.seekoutenemytime = gettime() + randomintrange(3000, 5000);
}

cantfindanythingtodo() {
  return advanceonhidingenemy();
}

advanceonhidingenemy() {
  if(self.fixednode || self.doingambush)
    return 0;

  if(isDefined(self.aggressivemode) && self.aggressivemode && gettime() >= self.seekoutenemytime)
    return tryrunningtoenemy(0);

  foundbettercover = 0;

  if(!isvalidenemy(self.enemy) || !self.enemy isflashed())
    foundbettercover = lookforbettercover();

  if(!foundbettercover && isvalidenemy(self.enemy) && wouldbesmartformyaitypetoseekoutenemy() && !self canseeenemyfromexposed()) {
    if(gettime() >= self.seekoutenemytime || self.enemy isflashed())
      return tryrunningtoenemy(0);
  }

  return foundbettercover;
}

trytogetoutofdangeroussituation() {
  if(movetonearbycover())
    return 1;

  return lookforbettercover();
}

movetonearbycover() {
  if(!isDefined(self.enemy))
    return false;

  if(isDefined(self.didshufflemove) && self.didshufflemove) {
    self.didshufflemove = undefined;
    return false;
  }

  if(aihasonlypistol())
    return false;

  if(!isDefined(self.node))
    return false;

  if(self.fixednode || self.doingambush || self.keepclaimednode || self.keepclaimednodeifvalid)
    return false;

  if(distancesquared(self.origin, self.node.origin) > 256)
    return false;

  node = self findshufflecovernode();

  if(!isDefined(self.node))
    return false;

  if(isDefined(node) && distancesquared(node.origin, self.node.origin) <= anim.moveglobals.shuffle_cover_min_distsq)
    return false;

  if(isDefined(node) && node != self.node && self usecovernode(node)) {
    self.shufflemove = 1;
    self.shufflenode = node;
    self.didshufflemove = 1;
    self.keepclaimednode = 0;
    wait 0.5;
    return true;
  }

  return false;
}

shouldprovidecoveringfire() {
  return false;
}

watchplayeraim() {
  self endon("killanimscript");
  self endon("death");
  self endon("stop_watchPlayerAim");

  if(isDefined(self.coverlookattrigger))
    self.coverlookattrigger delete();

  assert(isDefined(self.covernode));
  self.coversafetopopout = 1;
  stepoutpos = self.covernode.origin;

  if(self.a.script == "cover_left" || self.a.script == "cover_pillar" && self.cornerdirection == "left")
    stepoutpos = stepoutpos - vectorscale(anglestoright(self.covernode.angles), 32);
  else if(self.a.script == "cover_right" || self.a.script == "cover_pillar" && self.cornerdirection == "right")
    stepoutpos = stepoutpos + vectorscale(anglestoright(self.covernode.angles), 32);

  triggerheight = 72;

  if(self.a.pose == "crouch")
    triggerheight = 48;

  self.coverlookattrigger = spawn("trigger_lookat", stepoutpos, 0, 15, triggerheight);

  while(true) {
    waittillframeend;
    self.coversafetopopout = 1;
    self.playeraimsuppression = 0;
    self.coverlookattrigger waittill("trigger", watcher);

    if(isDefined(watcher) && isDefined(self.enemy) && watcher == self.enemy) {
      self thread watchplayeraimdebug(12);

      self.coversafetopopout = 0;
      self.playeraimsuppression = randomfloat(1) < 0.9;
      wait 0.5;
    }

    wait 0.05;
  }

  self.coversafetopopout = 1;
  self.playeraimsuppression = 0;
  self.coverlookattrigger delete();
}

watchplayeraimdebug(numframes) {
  self endon("death");
  i = 0;

  while(i < numframes) {
    recordenttext("Cover Trigger Watched", self, level.color_debug["white"], "Suppression");
    i++;
    wait 0.05;
  }

}

shouldswitchsides(forvariety) {
  if(!canswitchsides())
    return false;

  forcecornermode = shouldforcebehavior("force_corner_direction");

  if(forcecornermode == self.cornerdirection)
    return false;

  enemyrightbehindme = 0;

  if(self.cornerdirection != self.covernode.desiredcornerdirection)
    return true;
  else if(isDefined(self.enemy)) {
    yaw = self.covernode getyawtoorigin(self.enemy.origin);
    desiredcornerdirection = self.cornerdirection;

    if(yaw < -5 && !self.covernode has_spawnflag(1024))
      desiredcornerdirection = "right";
    else if(yaw > 5 && !self.covernode has_spawnflag(2048))
      desiredcornerdirection = "left";
    else
      enemyrightbehindme = 1;

    if(!enemyrightbehindme && self.cornerdirection != desiredcornerdirection) {
      self.covernode.desiredcornerdirection = desiredcornerdirection;
      return true;
    }
  }

  if((enemyrightbehindme || forvariety) && gettime() > self.a.nextallowedswitchsidestime) {
    if(self.cornerdirection == "left" && !self.covernode has_spawnflag(1024))
      self.covernode.desiredcornerdirection = "right";
    else if(!self.covernode has_spawnflag(2048))
      self.covernode.desiredcornerdirection = "left";

    return true;
  }

  return false;
}

switchsides(behaviorcallbacks) {
  self animscripts\debug::debugpushstate("switchSides");

  result = [[behaviorcallbacks.switchsides]]();

  if(result) {
    self notify("stop_watchPlayerAim");
    self thread watchplayeraim();
    self.a.nextallowedswitchsidestime = gettime() + randomintrange(5000, 7500);
    self.a.lastswitchsidestime = gettime();
  }

  self animscripts\debug::debugpopstate("switchSides");

  return result;
}

runforcedbehaviors(behaviorcallbacks) {
  didsomething = 0;

  if(!didsomething && shouldforcebehavior("idle")) {
    idle(behaviorcallbacks);
    didsomething = 1;
  }

  if(!didsomething && shouldforcebehavior("look")) {
    if(calloptionalbehaviorcallback(behaviorcallbacks.look, 2 + randomfloat(2)))
      didsomething = 1;
  }

  if(!didsomething && shouldforcebehavior("lookFast")) {
    if(calloptionalbehaviorcallback(behaviorcallbacks.fastlook))
      didsomething = 1;
  }

  if(!didsomething && shouldforcebehavior("reload")) {
    if(coverreload(behaviorcallbacks, 0))
      didsomething = 1;
  }

  if(!didsomething && shouldforcebehavior("switchSides")) {
    if(gettime() > self.a.nextallowedswitchsidestime) {
      if(switchsides(behaviorcallbacks))
        didsomething = 1;
    }
  }

  if(!didsomething && shouldforcebehavior("stepOut")) {
    if(leavecoverandshoot(behaviorcallbacks, "normal"))
      didsomething = 1;
  }

  if(!didsomething && shouldforcebehavior("advance")) {
    if(advanceonhidingenemy())
      didsomething = 1;
  }

  if(!didsomething && shouldforcebehavior("blindfire")) {
    if(blindfire(behaviorcallbacks))
      didsomething = 1;
  }

  if(!didsomething && shouldforcebehavior("grenade")) {
    if(self.grenadeammo <= 0)
      self.grenadeammo = 1;

    if(isDefined(self.enemy) && trythrowinggrenade(behaviorcallbacks, self.enemy))
      didsomething = 1;
  }

  if(!didsomething && shouldforcebehavior("flinch")) {
    if(calloptionalbehaviorcallback(behaviorcallbacks.flinch))
      didsomething = 1;
  }

  if(!didsomething && shouldforcebehavior("rambo")) {
    if(rambo(behaviorcallbacks))
      didsomething = 1;
  }

  if(!didsomething && shouldforcebehavior("switchWeapons")) {
    if(animscripts\shared::shouldswitchweapons()) {
      animscripts\shared::switchweapons();
      didsomething = 1;
    }
  }

  return didsomething;
}