/******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\cover_behavior.gsc
******************************************/

main(var_0) {
  self.couldntseeenemypos = self.origin;
  var_1 = gettime();
  var_2 = spawnstruct();
  var_2.nextallowedlooktime = var_1 - 1;
  var_2.nextallowedsuppresstime = var_1 - 1;
  resetlookforbettercovertime();
  resetrespondtodeathtime();
  self.seekoutenemytime = gettime();
  self.a.lastencountertime = var_1;
  self.a.idlingatcover = 0;
  self.a.movement = "stop";
  self.meleecoverchargemintime = var_1 + 3000;
  thread watchsuppression();
  var_3 = gettime() > 2500;

  for (;;) {
    if(isdefined(self.cover) && isdefined(self.cover.fnoverlord)) {
      var_4 = gettime();
      thread endidleatframeend();
      [
        [self.cover.fnoverlord]
      ]();

      if(gettime() == var_4)
        self notify("dont_end_idle");
    }

    if(animscripts\combat_utility::shouldhelpadvancingteammate()) {
      if(animscripts\combat_utility::tryrunningtoenemy(1)) {
        wait 0.05;
        continue;
      }
    }

    if(isdefined(var_0.mainloopstart))
      calloptionalbehaviorcallback(var_0.mainloopstart, "mainLoopStart");

    if(isdefined(var_0.movetonearbycover)) {
      if(calloptionalbehaviorcallback(var_0.movetonearbycover, "moveToNearByCover"))
        continue;
    }

    if(animscripts\utility::isspaceai())
      self safeteleport(self.covernode.origin);
    else
      self safeteleport(self.covernode.origin, getcorrectcoverangles());

    if(!var_3) {
      idle(var_0, 0.05 + randomfloat(1.5));
      var_3 = 1;
      continue;
    }

    if(dononattackcoverbehavior(var_0)) {
      continue;
    }
    if(isdefined(anim.throwgrenadeatplayerasap) && isalive(level.player)) {
      if(trythrowinggrenade(var_0, level.player))
        continue;
    }

    if(respondtodeadteammate()) {
      return;
    }
    var_5 = 0;
    var_6 = 0;

    if(isalive(self.enemy)) {
      var_5 = isenemyvisiblefromexposed();
      var_6 = animscripts\utility::cansuppressenemyfromexposed();
    }

    if(var_5) {
      if(self.a.getboredofthisnodetime < gettime()) {
        if(animscripts\combat_utility::lookforbettercover())
          return;
      }

      attackvisibleenemy(var_0);
      continue;
    }

    if(isdefined(self.aggressivemode) || enemyishiding()) {
      if(advanceonhidingenemy())
        return;
    }

    if(var_6) {
      attacksuppressableenemy(var_0, var_2);
      continue;
    }

    if(attacknothingtodo(var_0, var_2))
      return;
  }
}

#using_animtree("generic_human");

end_script(var_0) {
  self.turntomatchnode = undefined;
  self.a.prevattack = undefined;

  if(isdefined(self.meleecoverchargemintime) && self.meleecoverchargemintime <= gettime()) {
    self.meleecoverchargegraceendtime = gettime() + 5000;
    self.meleecoverchargemintime = undefined;
  }

  self clearanim( % head, 0.2);
  self.facialidx = undefined;
}

getcorrectcoverangles() {
  if(self.swimmer)
    return animscripts\swim::getnodeforwardangles(self.covernode);

  var_0 = (self.covernode.angles[0], animscripts\utility::getnodeforwardyaw(self.covernode), self.covernode.angles[2]);
  return var_0;
}

respondtodeadteammate() {
  if(self atdangerousnode() && self.a.respondtodeathtime < gettime()) {
    if(animscripts\combat_utility::lookforbettercover())
      return 1;

    self.a.respondtodeathtime = gettime() + 30000;
  }

  return 0;
}

dononattackcoverbehavior(var_0) {
  if(suppressedbehavior(var_0)) {
    if(isenemyvisiblefromexposed())
      resetseekoutenemytime();

    self.a.lastencountertime = gettime();
    return 1;
  }

  if(coverreload(var_0, 0))
    return 1;

  return 0;
}

attackvisibleenemy(var_0) {
  if(distancesquared(self.origin, self.enemy.origin) > 562500) {
    if(trythrowinggrenade(var_0, self.enemy))
      return;
  }

  if(leavecoverandshoot(var_0, "normal")) {
    resetseekoutenemytime();
    self.a.lastencountertime = gettime();
  } else
    idle(var_0);
}

attacksuppressableenemy(var_0, var_1) {
  if(self.doingambush) {
    if(leavecoverandshoot(var_0, "ambush"))
      return;
  } else if(self.providecoveringfire || gettime() >= var_1.nextallowedsuppresstime) {
    var_2 = "suppress";

    if(!self.providecoveringfire && gettime() - self.lastsuppressiontime > 5000 && randomint(3) < 2)
      var_2 = "ambush";
    else if(!animscripts\shoot_behavior::shouldsuppress())
      var_2 = "ambush";

    if(leavecoverandshoot(var_0, var_2)) {
      var_1.nextallowedsuppresstime = gettime() + randomintrange(3000, 20000);

      if(isenemyvisiblefromexposed())
        self.a.lastencountertime = gettime();

      return;
    }
  }

  if(trythrowinggrenade(var_0, self.enemy)) {
    return;
  }
  idle(var_0);
}

attacknothingtodo(var_0, var_1) {
  if(coverreload(var_0, 0.1))
    return 0;

  if(isdefined(self.enemy)) {
    if(trythrowinggrenade(var_0, self.enemy))
      return 0;
  }

  if(!self.doingambush && gettime() >= var_1.nextallowedlooktime) {
    if(lookforenemy(var_0)) {
      var_1.nextallowedlooktime = gettime() + randomintrange(4000, 15000);
      return 0;
    }
  }

  if(gettime() > self.a.getboredofthisnodetime) {
    if(cantfindanythingtodo())
      return 1;
  }

  if(self.doingambush || gettime() >= var_1.nextallowedsuppresstime && isdefined(self.enemy)) {
    if(leavecoverandshoot(var_0, "ambush")) {
      if(isenemyvisiblefromexposed())
        resetseekoutenemytime();

      self.a.lastencountertime = gettime();
      var_1.nextallowedsuppresstime = gettime() + randomintrange(6000, 20000);
      return 0;
    }
  }

  idle(var_0);
  return 0;
}

isenemyvisiblefromexposed() {
  if(!isdefined(self.enemy))
    return 0;

  if(distancesquared(self.enemy.origin, self.couldntseeenemypos) < 256)
    return 0;
  else
    return animscripts\utility::canseeenemyfromexposed();
}

suppressedbehavior(var_0) {
  if(!animscripts\utility::issuppressedwrapper())
    return 0;

  var_1 = gettime();
  var_2 = 1;

  while (animscripts\utility::issuppressedwrapper()) {
    var_2 = 0;
    self safeteleport(self.covernode.origin);
    var_3 = 1;

    if(isdefined(self.favor_blindfire))
      var_3 = common_scripts\utility::cointoss();

    if(var_3) {
      if(trytogetoutofdangeroussituation(var_0)) {
        self notify("killanimscript");
        return 1;
      }
    }

    if(self.a.atconcealmentnode && animscripts\utility::canseeenemy())
      return 0;

    var_4 = isenemyvisiblefromexposed() || animscripts\utility::cansuppressenemyfromexposed();

    if(var_4 && isdefined(anim.throwgrenadeatplayerasap) && isalive(level.player)) {
      if(trythrowinggrenade(var_0, level.player))
        continue;
    }

    if(coverreload(var_0, 0)) {
      continue;
    }
    if(self.team != "allies" && gettime() >= var_1) {
      if(blindfire(var_0)) {
        var_1 = gettime();

        if(!isdefined(self.favor_blindfire))
          var_1 = var_1 + randomintrange(3000, 12000);

        continue;
      }
    }

    if(var_4 && trythrowinggrenade(var_0, self.enemy)) {
      var_2 = 1;
      continue;
    }

    if(coverreload(var_0, 0.1)) {
      continue;
    }
    idle(var_0);
  }

  if(!var_2 && randomint(2) == 0)
    lookfast(var_0);

  return 1;
}

getpermutation(var_0) {
  var_1 = [];

  if(var_0 == 1)
    var_1[0] = 0;
  else if(var_0 == 2) {
    var_1[0] = randomint(2);
    var_1[1] = 1 - var_1[0];
  } else {
    for (var_2 = 0; var_2 < var_0; var_2++)
      var_1[var_2] = var_2;

    for (var_2 = 0; var_2 < var_0; var_2++) {
      var_3 = var_2 + randomint(var_0 - var_2);
      var_4 = var_1[var_3];
      var_1[var_3] = var_1[var_2];
      var_1[var_2] = var_4;
    }
  }

  return var_1;
}

calloptionalbehaviorcallback(var_0, var_1, var_2, var_3, var_4) {
  if(!isdefined(var_0))
    return 0;

  thread endidleatframeend();
  var_5 = gettime();
  var_6 = undefined;

  if(isdefined(var_4))
    var_6 = [
      [var_0]
    ](var_2, var_3, var_4);
  else if(isdefined(var_3))
    var_6 = [
      [var_0]
    ](var_2, var_3);
  else if(isdefined(var_2))
    var_6 = [
      [var_0]
    ](var_2);
  else
    var_6 = [
      [var_0]
    ]();

  if(!var_6)
    self notify("dont_end_idle");
  else {}

  return var_6;
}

watchsuppression() {
  self endon("killanimscript");
  self.lastsuppressiontime = gettime() - 100000;
  self.suppressionstart = self.lastsuppressiontime;

  for (;;) {
    self waittill("suppression");
    var_0 = gettime();

    if(self.lastsuppressiontime < var_0 - 700)
      self.suppressionstart = var_0;

    self.lastsuppressiontime = var_0;
  }
}

coverreload(var_0, var_1) {
  if(self.bulletsinclip > weaponclipsize(self.weapon) * var_1)
    return 0;

  self.isreloading = 1;
  var_2 = calloptionalbehaviorcallback(var_0.reload, "reload");
  self.isreloading = 0;
  return var_2;
}

leavecoverandshoot(var_0, var_1) {
  thread animscripts\shoot_behavior::decidewhatandhowtoshoot(var_1);

  if(!self.fixednode && !self.doingambush)
    thread breakoutofshootingifwanttomoveup();

  var_2 = calloptionalbehaviorcallback(var_0.leavecoverandshoot, "leaveCoverAndShoot");
  self notify("stop_deciding_how_to_shoot");
  return var_2;
}

lookforenemy(var_0) {
  if(self.a.atconcealmentnode && animscripts\utility::canseeenemy())
    return 0;

  if(self.a.lastencountertime + 6000 > gettime())
    return lookfast(var_0);
  else {
    var_1 = calloptionalbehaviorcallback(var_0.look, "look", 2 + randomfloat(2));

    if(var_1)
      return 1;

    return calloptionalbehaviorcallback(var_0.fastlook, "fastlook");
  }
}

lookfast(var_0) {
  var_1 = calloptionalbehaviorcallback(var_0.fastlook, "fastlook");

  if(var_1)
    return 1;

  return calloptionalbehaviorcallback(var_0.look, "look", 0);
}

idle(var_0, var_1) {
  self.flinching = 0;

  if(isdefined(var_0.flinch)) {
    if(!self.a.idlingatcover && gettime() - self.suppressionstart < 600) {
      if(calloptionalbehaviorcallback(var_0.flinch, "flinch"))
        return 1;
    } else
      thread flinchwhensuppressed(var_0);
  }

  if(!self.a.idlingatcover) {
    thread idlethread(var_0.idle);
    self.a.idlingatcover = 1;
  }

  if(isdefined(var_1))
    idlewait(var_1);
  else
    idlewaitabit();

  if(self.flinching)
    self waittill("flinch_done");

  self notify("stop_waiting_to_flinch");
}

idlewait(var_0) {
  self endon("end_idle");
  wait(var_0);
}

idlewaitabit() {
  self endon("end_idle");
  wait(0.3 + randomfloat(0.1));
  self waittill("do_slow_things");
}

idlethread(var_0) {
  var_1 = gettime();
  self endon("killanimscript");
  self[[var_0]]();
}

flinchwhensuppressed(var_0) {
  self endon("killanimscript");
  self endon("stop_waiting_to_flinch");
  var_1 = self.lastsuppressiontime;

  for (;;) {
    self waittill("suppression");
    var_2 = gettime();

    if(var_1 < var_2 - 2000) {
      break;
    }

    var_1 = var_2;
  }

  self.flinching = 1;
  var_3 = calloptionalbehaviorcallback(var_0.flinch, "flinch");
  self.flinching = 0;
  self notify("flinch_done");
}

endidleatframeend() {
  self endon("killanimscript");
  self endon("dont_end_idle");
  waittillframeend;

  if(!isdefined(self)) {
    return;
  }
  self notify("end_idle");
  self.a.idlingatcover = 0;
}

trythrowinggrenade(var_0, var_1) {
  var_2 = anglestoforward(self.angles);
  var_3 = vectornormalize(var_1.origin - self.origin);

  if(vectordot(var_2, var_3) < 0)
    return 0;

  if(self.doingambush && !animscripts\utility::recentlysawenemy())
    return 0;

  if(animscripts\utility::ispartiallysuppressedwrapper())
    return calloptionalbehaviorcallback(var_0.grenadehidden, "grenadeHidden", var_1);
  else
    return calloptionalbehaviorcallback(var_0.grenade, "grenade", var_1);
}

blindfire(var_0) {
  if(!animscripts\utility::canblindfire())
    return 0;

  return calloptionalbehaviorcallback(var_0.blindfire, "blindfire");
}

breakoutofshootingifwanttomoveup() {
  self endon("killanimscript");
  self endon("stop_deciding_how_to_shoot");

  for (;;) {
    if(self.fixednode || self.doingambush) {
      return;
    }
    wait(0.5 + randomfloat(0.75));

    if(!isdefined(self.enemy)) {
      continue;
    }
    if(enemyishiding()) {
      if(advanceonhidingenemy())
        return;
    }

    if(!animscripts\utility::recentlysawenemy() && !animscripts\utility::cansuppressenemy()) {
      if(gettime() > self.a.getboredofthisnodetime) {
        if(cantfindanythingtodo())
          return;
      }
    }
  }
}

enemyishiding() {
  if(!isdefined(self.enemy))
    return 0;

  if(self.enemy common_scripts\utility::isflashed())
    return 1;

  if(isplayer(self.enemy)) {
    if(isdefined(self.enemy.health) && self.enemy.health < self.enemy.maxhealth)
      return 1;
  } else if(isai(self.enemy) && self.enemy animscripts\utility::issuppressedwrapper())
    return 1;

  if(isdefined(self.enemy.isreloading) && self.enemy.isreloading)
    return 1;

  return 0;
}

resetrespondtodeathtime() {
  self.a.respondtodeathtime = 0;
}

resetlookforbettercovertime() {
  var_0 = gettime();

  if(isdefined(self.didshufflemove) && var_0 > self.a.getboredofthisnodetime)
    self.a.getboredofthisnodetime = var_0 + randomintrange(2000, 5000);
  else if(isdefined(self.enemy)) {
    var_1 = distance2d(self.origin, self.enemy.origin);

    if(var_1 < self.engagemindist) {
      self.a.getboredofthisnodetime = var_0 + randomintrange(5000, 10000);
      return;
    }

    if(var_1 > self.engagemaxdist && var_1 < self.goalradius) {
      self.a.getboredofthisnodetime = var_0 + randomintrange(2000, 5000);
      return;
    }

    self.a.getboredofthisnodetime = var_0 + randomintrange(10000, 15000);
    return;
    return;
  } else
    self.a.getboredofthisnodetime = var_0 + randomintrange(5000, 15000);
}

resetseekoutenemytime() {
  if(isdefined(self.aggressivemode))
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

  if(isdefined(self.aggressivemode) && gettime() >= self.seekoutenemytime)
    return animscripts\combat_utility::tryrunningtoenemy(0);

  var_0 = 0;

  if(!isdefined(self.enemy) || !self.enemy common_scripts\utility::isflashed())
    var_0 = animscripts\combat_utility::lookforbettercover();

  if(!var_0 && isdefined(self.enemy) && !animscripts\utility::canseeenemyfromexposed()) {
    if(gettime() >= self.seekoutenemytime)
      return animscripts\combat_utility::tryrunningtoenemy(0);
  }

  return var_0;
}

trytogetoutofdangeroussituation(var_0) {
  if(isdefined(var_0.movetonearbycover)) {
    if(calloptionalbehaviorcallback(var_0.movetonearbycover, "moveToNearByCover"))
      return 1;
  }

  return animscripts\combat_utility::lookforbettercover();
}

copy_anim_array_to_a_array(var_0) {
  var_1 = animscripts\utility::lookupanimarray(var_0);

  foreach(var_4, var_3 in var_1)
  self.a.array[var_4] = var_3;
}

set_cqb_standing_turns() {
  copy_anim_array_to_a_array("cqb_stationary_turn");
}

set_casual_standing_turns() {
  copy_anim_array_to_a_array("casual_stationary_turn");
}

set_standing_turns() {
  copy_anim_array_to_a_array("exposed_turn");
}

set_standing_cover_turns() {
  copy_anim_array_to_a_array("coverstand_turn");
}

set_crouching_turns() {
  copy_anim_array_to_a_array("exposed_turn_crouch");
}

set_swimming_turns() {
  self.a.array["turn_left_45"] = animscripts\swim::getswimanim("turn_left_45");
  self.a.array["turn_left_90"] = animscripts\swim::getswimanim("turn_left_90");
  self.a.array["turn_left_135"] = animscripts\swim::getswimanim("turn_left_135");
  self.a.array["turn_left_180"] = animscripts\swim::getswimanim("turn_left_180");
  self.a.array["turn_right_45"] = animscripts\swim::getswimanim("turn_right_45");
  self.a.array["turn_right_90"] = animscripts\swim::getswimanim("turn_right_90");
  self.a.array["turn_right_135"] = animscripts\swim::getswimanim("turn_right_135");
  self.a.array["turn_right_180"] = animscripts\swim::getswimanim("turn_right_180");
}

turntomatchnodedirection(var_0) {
  if(isdefined(self.node)) {
    var_1 = self.node;
    var_2 = abs(angleclamp180(self.angles[1] - (var_1.angles[1] + var_0)));

    if(self.a.pose == "stand" && var_1 gethighestnodestance() != "stand") {
      if(var_2 > 45 && var_2 < 90)
        self orientmode("face angle", self.angles[1]);
      else
        self orientmode("face current");

      var_3 = 1.5;
      var_4 = % exposed_stand_2_crouch;

      if(isdefined(self.animarchetype) && self.animarchetype == "s1_soldier")
        var_4 = % s1_exposed_stand_2_crouch;

      var_5 = getnotetracktimes(var_4, "anim_pose = \"crouch\"")[0];
      var_5 = min(1, var_5 * 1.1);
      var_6 = var_5 * getanimlength(var_4) / var_3;
      self setflaggedanimknoballrestart("crouchanim", var_4, % body, 1, 0.2, var_3);
      animscripts\notetracks::donotetracksfortime(var_6, "crouchanim");
      self clearanim( % body, 0.2);
    }

    if(animscripts\utility::isspaceai()) {
      self notify("force_space_rotation_update", 0, 0);
      return;
    } else
      self orientmode("face angle", self.angles[1]);

    var_7 = angleclamp180(self.angles[1] - (var_1.angles[1] + var_0));

    if(abs(var_7) > 45) {
      if(self.swimmer)
        set_swimming_turns();
      else if(self.a.pose == "stand") {
        if(isdefined(self.animarchetype) && self.animarchetype == "s1_soldier") {
          if(isdefined(self.covertype)) {
            if(self.covertype == "stand")
              set_standing_cover_turns();
            else
              set_standing_turns();
          } else
            set_standing_turns();
        } else if(isdefined(self.cqbwalking) && self.cqbwalking)
          set_cqb_standing_turns();
        else if(animscripts\utility::is_in_casual_standing_stance())
          set_casual_standing_turns();
        else
          set_standing_turns();
      } else
        set_crouching_turns();

      self.turnthreshold = 45;
      self.turntomatchnode = 1;
      animscripts\combat::turntofacerelativeyaw(var_7);
      self.turntomatchnode = undefined;
    }
  }
}

movetonearbycover() {
  if(self isbadguy())
    return 0;

  if(!isdefined(self.enemy))
    return 0;

  if(isdefined(self.didshufflemove)) {
    self.didshufflemove = undefined;
    return 0;
  }

  if(!isdefined(self.node))
    return 0;

  if(animscripts\utility::isnodecover3d(self.node))
    return 0;

  if(randomint(3) == 0)
    return 0;

  if(self.fixednode || self.doingambush || self.keepclaimednode || self.keepclaimednodeifvalid)
    return 0;

  if(distancesquared(self.origin, self.node.origin) > 256)
    return 0;

  var_0 = self findshufflecovernode();

  if(isdefined(var_0) && var_0 != self.node && self usecovernode(var_0)) {
    self.shufflemove = 1;
    self.shufflenode = var_0;
    self.didshufflemove = 1;
    wait 0.5;
    return 1;
  }

  return 0;
}