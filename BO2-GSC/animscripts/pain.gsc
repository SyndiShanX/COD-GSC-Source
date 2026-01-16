/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\pain.gsc
**************************************/

#include animscripts\utility;
#include animscripts\weaponlist;
#include common_scripts\utility;
#include animscripts\anims;
#include animscripts\combat_utility;
#include maps\_utility;
#include animscripts\balcony;
#include animscripts\face;
#include animscripts\death;
#include animscripts\shared;
#include animscripts\cover_utility;
#include animscripts\run;

main() {
  if(self animscripts\balcony::trybalcony()) {
    return;
  }
  self setflashbanged(0);
  self flamethrower_stop_shoot();

  if(isDefined(self.doinglongdeath)) {
    self waittill("killanimscript");
    return;
  }

  self notify("kill_long_death");
  self.a.paintime = gettime();

  if(self.a.flamepaintime > self.a.paintime) {
    return;
  }
  if(self.a.nextstandinghitdying)
    self.health = 1;

  ratio = self.health / self.maxhealth;
  self trackscriptstate("Pain Main", "code");
  self notify("anim entered pain");
  self endon("killanimscript");
  animscripts\utility::initialize("pain");
  self animmode("gravity");
  self animscripts\face::saygenericdialogue("pain_bullet");
  painhelmetpop();
  trywoundedanimset(ratio);

  if(isDefined(self.painoverridefunc)) {
    [
      [self.painoverridefunc]
    ]();
    return;
  }

  if(crawlingpain()) {
    return;
  }
  if(specialpain(self.a.special)) {
    return;
  }
  painanim = getpainanim();

  if(getdvarint(#"_id_FBE667DB") == 1) {
    recordenttext("Pain - " + self getentitynumber() + " hit at " + self.damagelocation, self, level.color_debug["yellow"], "Animscript");
    println("^2Pain - ", painanim, " ; pose is ", self.a.pose);
  }

  playpainanim(painanim);
}

paingloabalsinit() {
  if(!isDefined(anim.painglobals)) {
    anim.painglobals = spawnstruct();
    anim.painglobals.numdeathsuntilcrawlingpain = randomintrange(0, 15);
    anim.painglobals.nextcrawlingpaintime = gettime() + randomintrange(0, 20000);
    anim.painglobals.nextcrawlingpaintimefromlegdamage = gettime() + randomintrange(0, 10000);
    anim.painglobals.min_running_pain_dist_sq = 4096;
    anim.painglobals.run_pain_short = 120;
    anim.painglobals.run_pain_med = 200;
    anim.painglobals.run_pain_long = 300;
  }
}

painhelmetpop() {
  if(self.damagelocation == "helmet") {
    self animscripts\death::helmetpop();
    self playsound("prj_bullet_impact_headshot_helmet_nodie");
  } else if(self wasdamagedbyexplosive() && randomint(2) == 0)
    self animscripts\death::helmetpop();
}

trywoundedanimset(ratio) {
  if(!shouldtrywoundedanimset()) {
    return;
  }
  self.a.disablebackwardrunngun = 1;
  self.a.allow_sidearm = 0;
  self disable_tactical_walk();
  self disable_react();
  self.a.dontpeek = 1;
  self.a.disable120runngun = 1;

  if(ratio < 0.75 && isDefined(level.setup_wounded_anims_callback))
    self[[level.setup_wounded_anims_callback]]();
}

shouldtrywoundedanimset() {
  if(isDefined(self.a.disablewoundedset) && self.a.disablewoundedset)
    return false;

  if(isDefined(self.iswounded) && self.iswounded)
    return false;

  if(isDefined(self.nowoundedrushing) && self.nowoundedrushing)
    return false;

  if(isDefined(self.cqb) && self.cqb && !(self animscripts\utility::weaponanims() == "pistol"))
    return false;

  if(aihasonlypistol())
    return false;

  if(self.a.prevscript == "move" || self.a.prevscript == "combat")
    return true;

  if(isDefined(self.overrideactordamage))
    return false;

  return false;
}

crawlingpain() {
  if(getdvarint(#"_id_B0E130B4") == 1 && !isDefined(self.magic_bullet_shield))
    self.forcelongdeath = 1;

  if(!shouldcrawlingpain())
    return false;

  anim.painglobals.nextcrawlingpaintime = gettime() + 3000;
  anim.painglobals.nextcrawlingpaintimefromlegdamage = gettime() + 3000;
  self thread crawlingpistol();
  self waittill("killanimscript");
  return true;
}

shouldcrawlingpain() {
  if(isDefined(self.forcelongdeath)) {
    self.health = 10;
    self thread crawlingpistol();
    self waittill("killanimscript");
    return true;
  }

  if(self.team == "allies")
    return false;

  if(self.damagemod == "MOD_BURNED" || self.damagemod == "MOD_GAS")
    return false;

  if(self.a.pose != "prone" && self.a.pose != "crouch" && self.a.pose != "stand")
    return false;

  if(isDefined(self.deathfunction))
    return false;

  if(!animscripts\death::longdeathallowed() || shoulddiequietly())
    return false;

  if(self depthinwater() > 8)
    return false;

  if(self damagelocationisany("head", "helmet", "gun", "right_hand", "left_hand"))
    return false;

  leghit = self damagelocationisany("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower", "left_foot", "right_foot");

  if(leghit && self.health < self.maxhealth * 0.4) {
    if(gettime() < anim.painglobals.nextcrawlingpaintimefromlegdamage)
      return false;
  } else {
    if(anim.painglobals.numdeathsuntilcrawlingpain > 0)
      return false;

    if(gettime() < anim.painglobals.nextcrawlingpaintime)
      return false;
  }

  if(isanyplayernearby(256))
    return false;

  if(weaponisgasweapon(self.weapon))
    return false;

  if(self.weapon == self.sidearm)
    return false;

  if(!(self.sidearm != "" && self.sidearm != "none"))
    return false;

  return true;
}

#using_animtree("generic_human");

crawlingpistol() {
  self endon("kill_long_death");
  self endon("death");
  self setplayercollision(0);
  self thread preventpainforashorttime("crawling");
  self.a.special = "none";
  self thread paindeathnotify();
  self.issniper = 0;
  self setanimknoball( % dying, % body, 1, 0.1, 1);

  if(!self dyingcrawl()) {
    return;
  }
  assert(self.a.pose == "stand" || self.a.pose == "crouch" || self.a.pose == "prone");
  transanimslot = self.a.pose + "_2_back";
  transanim = animarraypickrandom(transanimslot);
  self setflaggedanimknob("transition", transanim, 1, 0.5, 1);
  self animscripts\shared::donotetracksintercept("transition", ::handlebackcrawlnotetracks);

  if(self.a.pose != "back") {
    println("Anim \"", transanim, "\" is missing an 'anim_pose = \"back\"' notetrack.");

    assert(self.a.pose == "back");
  }

  self.a.special = "dying_crawl";
  self thread dyingcrawlbackaim();
  decidenumcrawls();

  while(shouldkeepcrawling()) {
    crawlanim = animarray("back_crawl");
    delta = getmovedelta(crawlanim, 0, 1);
    endpos = self localtoworldcoords(delta);

    if(!self maymovetopoint(endpos)) {
      break;
    }

    self setflaggedanimknobrestart("back_crawl", crawlanim, 1, 0.1, 1.0);
    self animscripts\shared::donotetracksintercept("back_crawl", ::handlebackcrawlnotetracks);
  }

  self.desiredtimeofdeath = gettime() + randomintrange(4000, 20000);

  while(shouldstayalive()) {
    if(self canseeenemy() && self aimedsomewhatatenemy()) {
      backanim = animarray("back_fire");
      self setflaggedanimknobrestart("back_idle_or_fire", backanim, 1, 0.2, 1.0);
      self animscripts\shared::donotetracks("back_idle_or_fire");
    } else {
      backanim = animarray("back_idle");

      if(randomfloat(1) < 0.4)
        backanim = animarraypickrandom("back_idle_twitch");

      self setflaggedanimknobrestart("back_idle_or_fire", backanim, 1, 0.1, 1.0);
      timeremaining = getanimlength(backanim);

      while(timeremaining > 0) {
        if(self canseeenemy() && self aimedsomewhatatenemy()) {
          break;
        }

        interval = 0.5;

        if(interval > timeremaining) {
          interval = timeremaining;
          timeremaining = 0;
        } else
          timeremaining = timeremaining - interval;

        self animscripts\shared::donotetracksfortime(interval, "back_idle_or_fire");
      }
    }
  }

  self notify("end_dying_crawl_back_aim");
  self clearanim( % dying_back_aim_4_wrapper, 0.3);
  self clearanim( % dying_back_aim_6_wrapper, 0.3);
  self.a.nodeath = 1;
  deathanim = animarraypickrandom("back_death");
  self setflaggedanimknobrestart("back_death", deathanim, 1, 0.1, 1.0);
  self animscripts\shared::donotetracksfortime(getanimlength(deathanim) * 0.9, "back_death");
  self dodamage(self.health + 5, (0, 0, 0));
  self.a.special = "none";
}

preventpainforashorttime(type) {
  self endon("kill_long_death");
  self endon("death");
  self.flashbangimmunity = 1;
  self.doinglongdeath = 1;
  self notify("long_death");
  self.a.mayonlydie = 1;

  if(type == "crawling") {
    anybody_nearby = isanyplayernearby(1024);

    if(anybody_nearby) {
      anim.painglobals.numdeathsuntilcrawlingpain = randomintrange(10, 30);
      anim.painglobals.nextcrawlingpaintime = gettime() + randomintrange(15000, 60000);
    } else {
      anim.painglobals.numdeathsuntilcrawlingpain = randomintrange(5, 12);
      anim.painglobals.nextcrawlingpaintime = gettime() + randomintrange(5000, 25000);
    }

    anim.painglobals.nextcrawlingpaintimefromlegdamage = gettime() + randomintrange(7000, 13000);

    if(getdebugdvarint("scr_crawldebug") == 1) {
      thread printlongdeathdebugtext(self.origin + vectorscale((0, 0, 1), 64.0), "crawl death");
      return;
    }

  }
}

decidenumcrawls() {
  self.a.numcrawls = randomintrange(0, 5);
}

shouldkeepcrawling() {
  assert(isDefined(self.a.numcrawls));

  if(!self.a.numcrawls) {
    self.a.numcrawls = undefined;
    return false;
  }

  self.a.numcrawls--;
  return true;
}

shouldstayalive() {
  if(!enemyisingeneraldirection(anglestoforward(self.angles)))
    return false;

  return gettime() < self.desiredtimeofdeath;
}

dyingcrawl() {
  if(self.a.pose == "prone")
    return true;

  if(self.a.movement == "stop") {
    if(randomfloat(1) < 0.2) {
      if(randomfloat(1) < 0.5)
        return true;
    } else if(abs(self.damageyaw) > 90)
      return true;
  } else if(abs(self getmotionangle()) > 90)
    return true;

  self setflaggedanimknob("falling", animarraypickrandom(self.a.pose + "_2_crawl"), 1, 0.5, 1);
  self animscripts\shared::donotetracks("falling");
  assert(self.a.pose == "prone");
  self.a.special = "dying_crawl";
  decidenumcrawls();

  while(shouldkeepcrawling()) {
    crawlanim = animarray("crawl");
    delta = getmovedelta(crawlanim, 0, 1);
    endpos = self localtoworldcoords(delta);

    if(!self maymovetopoint(endpos))
      return true;

    self setflaggedanimknobrestart("crawling", crawlanim, 1, 0.1, 1.0);
    self animscripts\shared::donotetracks("crawling");
  }

  if(enemyisingeneraldirection(anglestoforward(self.angles) * -1))
    return true;

  self.a.nodeath = 1;
  deathanim = animarraypickrandom("death");
  self setflaggedanimknobrestart("crawl_death", deathanim, 1, 0.1, 1.0);
  self animscripts\shared::donotetracksfortime(getanimlength(deathanim) * 0.9, "crawl_death");
  self.a.special = "none";
  return false;
}

dyingcrawlbackaim() {
  self endon("kill_long_death");
  self endon("death");
  self endon("end_dying_crawl_back_aim");

  if(isDefined(self.dyingcrawlaiming)) {
    return;
  }
  self.dyingcrawlaiming = 1;
  self setanimlimited(animarray("aim_left"), 1, 0);
  self setanimlimited(animarray("aim_right"), 1, 0);
  prevyaw = 0;

  while(true) {
    aimyaw = self getyawtoenemy();
    diff = angleclamp180(aimyaw - prevyaw);

    if(abs(diff) > 3)
      diff = sign(diff) * 3;

    aimyaw = angleclamp180(prevyaw + diff);

    if(aimyaw < 0) {
      if(aimyaw < -45.0)
        aimyaw = -45.0;

      weight = aimyaw / -45.0;
      self setanim( % dying_back_aim_4_wrapper, weight, 0.05);
      self setanim( % dying_back_aim_6_wrapper, 0, 0.05);
    } else {
      if(aimyaw > 45.0)
        aimyaw = 45.0;

      weight = aimyaw / 45.0;
      self setanim( % dying_back_aim_6_wrapper, weight, 0.05);
      self setanim( % dying_back_aim_4_wrapper, 0, 0.05);
    }

    prevyaw = aimyaw;
    wait 0.05;
  }
}

startdyingcrawlbackaimsoon() {
  self endon("kill_long_death");
  self endon("death");
  wait 0.5;
  self thread dyingcrawlbackaim();
}

handlebackcrawlnotetracks(note) {
  if(note == "fire_spray") {
    if(!self canseeenemy())
      return true;

    if(!self aimedsomewhatatenemy())
      return true;

    self shootenemywrapper();
    return true;
  } else if(note == "pistol_pickup") {
    self thread startdyingcrawlbackaimsoon();
    return false;
  }

  return false;
}

aimedsomewhatatenemy() {
  assert(isvalidenemy(self.enemy));
  enemyshootatpos = self.enemy getshootatpos();
  weaponangles = self gettagangles("tag_weapon");
  anglestoenemy = vectortoangles(enemyshootatpos - self gettagorigin("tag_weapon"));
  absyawdiff = absangleclamp180(weaponangles[1] - anglestoenemy[1]);

  if(absyawdiff > 25) {
    if(distancesquared(self getshootatpos(), enemyshootatpos) > 4096 || absyawdiff > 45)
      return false;
  }

  return absangleclamp180(weaponangles[0] - anglestoenemy[0]) <= 30;
}

enemyisingeneraldirection(dir) {
  if(!isvalidenemy(self.enemy))
    return false;

  toenemy = vectornormalize(self.enemy getshootatpos() - self geteye());
  return vectordot(toenemy, dir) > 0.5;
}

specialpainblocker() {
  self endon("killanimscript");
  self.blockingpain = 1;
  wait 1.5;
  self.blockingpain = 0;
}

specialpain(anim_special) {
  if(anim_special == "none")
    return 0;

  animscripts\cover_utility::resetanimspecial();

  if(weaponisgasweapon(self.weapon))
    return 0;

  if(iscrossbowexplosive(self.damageweapon))
    return 0;

  handled = 0;

  if(self.team != "allies")
    self thread specialpainblocker();
  else
    self.blockingpain = 1;

  switch (anim_special) {
    case "cover_left":
      if(self.a.pose == "stand" || self.a.pose == "crouch" && usingpistol()) {
        painarray = [];

        if(self damagelocationisany("head", "neck"))
          painarray[painarray.size] = animarray("cover_left_head");

        if(self damagelocationisany("torso_lower", "left_leg_upper", "right_leg_upper") || randomfloat(10) < 3)
          painarray[painarray.size] = animarray("cover_left_groin");

        if(self damagelocationisany("torso_lower", "torso_upper", "left_arm_upper", "right_arm_upper", "neck") || randomfloat(10) < 3)
          painarray[painarray.size] = animarray("cover_left_chest");

        if(self damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot") || randomfloat(10) < 3)
          painarray[painarray.size] = animarray("cover_left_left_leg");

        if(self damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot") || randomfloat(10) < 3)
          painarray[painarray.size] = animarray("cover_left_right_leg");

        if(painarray.size < 2)
          painarray[painarray.size] = animarray("cover_left_head");

        dopainfromarray(painarray);
        handled = 1;
      } else if(self.a.pose == "crouch") {
        dopainfromarray(animarray(anim_special));
        handled = 1;
      }

      break;
    case "cover_left_A":
    case "cover_left_B":
    case "cover_left_lean":
      if(self.a.pose == "stand" || self.a.pose == "crouch") {
        dopainfromarray(animarray(anim_special), undefined, 1);
        handled = 1;
      }

      break;
    case "cover_left_blindfire":
      if(self.a.pose == "stand") {
        dopainfromarray(animarray(anim_special));
        handled = 1;
      }

      break;
    case "cover_left_over":
      if(self.a.pose == "crouch") {
        dopainfromarray(animarray(anim_special));
        handled = 1;
      }

      break;
    case "cover_right":
    case "cover_right_blindfire":
    case "cover_right_lean":
      if(anim_special == "cover_right_lean" && animarrayanyexist("cover_right_lean")) {
        dopainfromarray(animarray("cover_right_lean"));
        handled = 1;
      } else if(self.a.pose == "stand" || self.a.pose == "crouch" && (isDefined(level.supportspistolanimations) && level.supportspistolanimations) && usingpistol()) {
        painarray = [];

        if(self damagelocationisany("right_arm_upper", "torso_upper", "neck") || randomfloat(10) < 3)
          painarray[painarray.size] = animarray("cover_right_chest");

        if(self damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot") || randomfloat(10) < 3)
          painarray[painarray.size] = animarray("cover_right_right_leg");

        if(self damagelocationisany("torso_lower", "left_leg_upper", "right_leg_upper") || randomfloat(10) < 3)
          painarray[painarray.size] = animarray("cover_right_groin");

        if(painarray.size == 0) {
          painarray[0] = animarray("cover_right_chest");
          painarray[1] = animarray("cover_right_right_leg");
          painarray[2] = animarray("cover_right_groin");
        }

        dopainfromarray(painarray);
        handled = 1;
      } else if(self.a.pose == "crouch") {
        dopainfromarray(animarray("cover_right"));
        handled = 1;
      }

      break;
    case "cover_right_A":
    case "cover_right_B":
      if(self.a.pose == "stand" || self.a.pose == "crouch") {
        dopainfromarray(animarray(anim_special), undefined, 1);
        handled = 1;
      }

      break;
    case "cover_right_over":
      if(self.a.pose == "crouch") {
        dopainfromarray(animarray(anim_special));
        handled = 1;
      }

      break;
    case "cover_crouch":
      painarray = [];

      if(self.damageyaw > 135 || self.damageyaw <= -135)
        painarray[painarray.size] = animarray("cover_crouch_front");
      else if(self.damageyaw > 45 && self.damageyaw < 135)
        painarray[painarray.size] = animarray("cover_crouch_right");
      else if(self.damageyaw > -135 && self.damageyaw < -45)
        painarray[painarray.size] = animarray("cover_crouch_left");
      else
        painarray[painarray.size] = animarray("cover_crouch_back");

      dopainfromarray(painarray);
      handled = 1;
      break;
    case "cover_crouch_aim":
    case "cover_crouch_aim_left":
    case "cover_crouch_aim_right":
      if(self.a.pose == "crouch") {
        dopainfromarray(animarray(anim_special));
        handled = 1;
      }

      break;
    case "cover_stand":
      painarray = [];

      if(self damagelocationisany("torso_lower", "left_leg_upper", "right_leg_upper") || randomfloat(10) < 3)
        painarray[painarray.size] = animarray("cover_stand_groin");

      if(self damagelocationisany("torso_lower", "torso_upper", "left_arm_upper", "right_arm_upper", "neck") || randomfloat(10) < 3)
        painarray[painarray.size] = animarray("cover_stand_chest");

      if(self damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot") || randomfloat(10) < 3)
        painarray[painarray.size] = animarray("cover_stand_left_leg");

      if(self damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot") || randomfloat(10) < 3)
        painarray[painarray.size] = animarray("cover_stand_right_leg");

      if(painarray.size < 2)
        painarray[painarray.size] = animarray("cover_stand_right_leg");

      dopainfromarray(painarray);
      handled = 1;
      break;
    case "cover_stand_aim":
      if(animarrayanyexist(anim_special)) {
        dopainfromarray(animarray(anim_special));
        handled = 1;
      }

      break;
    case "cover_pillar_lean":
      if(!isDefined(self.waschangingcoverpos) || isDefined(self.waschangingcoverpos) && !self.waschangingcoverpos) {
        painarray = [];

        if(self.cornerdirection == "left")
          painarray[painarray.size] = animarraypickrandom("cover_pillar_l_return");
        else if(self.cornerdirection == "right")
          painarray[painarray.size] = animarraypickrandom("cover_pillar_r_return");

        dopainfromarray(painarray);
        handled = 1;
      }

      break;
    case "cover_pillar_left_A":
    case "cover_pillar_left_B":
    case "cover_pillar_right_A":
    case "cover_pillar_right_B":
      if(self.a.pose == "stand" || self.a.pose == "crouch") {
        painarray = [];
        painarray = animarray(anim_special);
        dopainfromarray(painarray, 1.2);
        handled = 1;
      }

      break;
    case "cover_pillar":
      if(!isDefined(self.waschangingcoverpos) || isDefined(self.waschangingcoverpos) && !self.waschangingcoverpos) {
        dopainfromarray(animarray(anim_special));
        handled = 1;
      }

      break;
    case "saw":
      painanim = animarray("saw_chest");
      self setflaggedanimknob("painanim", painanim, 1, 0.3, 1);
      self animscripts\shared::donotetracks("painanim");
      handled = 1;
      break;
    case "mg42":
      mg42pain(self.a.pose);
      handled = 1;
      break;
    case "dying_crawl":
    case "rambo":
    case "rambo_left":
    case "rambo_right":
      handled = 0;
      break;
    default:

      println("Unexpected anim_special value : " + anim_special + " in specialPain.");

      handled = 0;
      break;
  }

  if(self.team == "allies")
    self.blockingpain = 0;

  return handled;
}

dopainfromarray(painanims, rate, usestopaimnotetrack) {
  if(isarray(painanims))
    painanim = painanims[randomint(painanims.size)];
  else
    painanim = painanims;

  if(!isDefined(rate))
    rate = 1;

  hasstopaim = 0;

  if(isDefined(usestopaimnotetrack) && usestopaimnotetrack) {
    hasstopaim = animhasnotetrack(painanim, "stop_aim");

    if(!hasstopaim) {
      if(getdvarint(#"_id_B142FD65") == 1)
        println("^2StopStartAim Debug - ", painanim + " didn't have \"stop_aim\" notetrack");

    }
  }

  if(hasstopaim) {
    self setflaggedanimrestart("painanim", painanim, 1, 0.1, rate);
    self thread painstopaiming();
    self animscripts\shared::donotetracks("painanim");
  } else {
    self setflaggedanimknobrestart("painanim", painanim, 1, 0.1, rate);
    self animscripts\shared::donotetracks("painanim");
  }
}

painstopaiming() {
  self endon("killanimscript");
  self waittillmatch("painanim", "stop_aim");
  self clearanim( % aim_4, 0.1);
  self clearanim( % aim_6, 0.1);
  self clearanim( % aim_2, 0.1);
  self clearanim( % aim_8, 0.1);
  self clearanim( % exposed_aiming, 0.1);
}

getpainanim() {
  if(self.a.pose == "stand") {
    closetonode = isDefined(self.node) && distancesquared(self.origin, self.node.origin) < anim.painglobals.min_running_pain_dist_sq;

    if(isDefined(self.damagemod) && self.damagemod == "MOD_BURNED")
      return get_flamethrower_stand_pain();
    else if(!closetonode && self.a.movement == "run" && abs(self getmotionangle()) < 60) {
      if(iscrossbowexplosive(self.damageweapon))
        return get_explosive_crossbow_run_pain();
      else
        return getrunningforwardpainanim();
    } else {
      if(getdvarint(#"_id_FBE667DB") == 1) {
        if(self.a.movement == "run" && abs(self getmotionangle()) < 60)
          recordenttext("Pain - not playing running forward anim as close to the node", self, level.color_debug["yellow"], "Animscript");
      }

      self.a.movement = "stop";

      if(iscrossbowexplosive(self.damageweapon))
        return get_explosive_crossbow_pain();
      else
        return getstandpainanim();
    }
  } else if(self.a.pose == "crouch") {
    if(isDefined(self.damagemod) && self.damagemod == "MOD_BURNED")
      return get_flamethrower_crouch_pain();

    if(iscrossbowexplosive(self.damageweapon)) {
      self.a.pose = "stand";
      return get_explosive_crossbow_pain();
    }

    self.a.movement = "stop";
    return getcrouchpainanim();
  } else if(self.a.pose == "prone") {
    self.a.movement = "stop";
    return getpronepainanim();
  } else {
    assert(self.a.pose == "back");
    self.a.movement = "stop";
    return animarray("chest");
  }
}

get_flamethrower_stand_pain() {
  painarray = animarray("burn_chest");
  assert(isarray(painarray) && painarray.size > 0);
  tagarray = array("J_Elbow_RI", "J_Wrist_LE", "J_Wrist_RI", "J_Head");
  painarray = removeblockedanims(painarray);

  if(!painarray.size) {
    self.a.movement = "stop";
    return getstandpainanim();
  }

  anim_num = randomint(painarray.size);

  if(self.team == "axis" && isDefined(level._effect["character_fire_pain_sm"]))
    playfxontag(level._effect["character_fire_pain_sm"], self, tagarray[anim_num]);
  else {
    println("^3ANIMSCRIPT WARNING: You are missing level._effect[\"character_fire_pain_sm\"], please set it in your levelname_fx.gsc. Use \"env/fire/fx_fire_player_sm\"");

  }

  pain_anim = painarray[anim_num];
  time = getanimlength(pain_anim);
  self.a.flamepaintime = gettime() + time * 1000;
  return pain_anim;
}

get_flamethrower_crouch_pain() {
  painarray = animarray("burn_chest");
  assert(isarray(painarray) && painarray.size > 0);
  tagarray = array("J_Elbow_LE", "J_Wrist_LE", "J_Wrist_RI", "J_Head");
  painarray = removeblockedanims(painarray);

  if(!painarray.size) {
    self.a.movement = "stop";
    return getcrouchpainanim();
  }

  anim_num = randomint(painarray.size);

  if(self.team == "axis" && isDefined(level._effect["character_fire_pain_sm"]))
    playfxontag(level._effect["character_fire_pain_sm"], self, tagarray[anim_num]);
  else {
    println("^3ANIMSCRIPT WARNING: You are missing level._effect[\"character_fire_pain_sm\"], please set it in your levelname_fx.gsc. Use \"env/fire/fx_fire_player_sm\"");

  }

  pain_anim = painarray[anim_num];
  time = getanimlength(pain_anim);
  self.a.flamepaintime = gettime() + time * 1000;
  return pain_anim;
}

getrunningforwardpainanim() {
  painarray = [];
  allowlongrunningpain = self.lookaheaddist >= anim.painglobals.run_pain_long * 0.7;
  allowmedrunningpain = self.lookaheaddist >= anim.painglobals.run_pain_med * 0.7;
  allowshortrunningpain = self.lookaheaddist >= anim.painglobals.run_pain_long * 0.7;

  if(getdvarint(#"_id_FBE667DB") == 1)
    println("Running Pain - Long = " + allowlongrunningpain + "Med = " + allowmedrunningpain + "Short = " + allowshortrunningpain);

  if(allowlongrunningpain && self maymovetopoint(self localtoworldcoords((anim.painglobals.run_pain_long, 0, 0))))
    painarray[painarray.size] = animarraypickrandom("run_long");

  if(allowmedrunningpain && self maymovetopoint(self localtoworldcoords((anim.painglobals.run_pain_med, 0, 0))))
    painarray[painarray.size] = animarraypickrandom("run_medium");

  if(allowshortrunningpain && self maymovetopoint(self localtoworldcoords((anim.painglobals.run_pain_short, 0, 0))))
    painarray[painarray.size] = animarraypickrandom("run_short");

  if(!painarray.size) {
    self.a.movement = "stop";
    return getstandpainanim();
  }

  return painarray[randomint(painarray.size)];
}

get_explosive_crossbow_pain() {
  painarray = [];

  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield)
    return getstandpainanim();

  if(damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot")) {
    painarray[painarray.size] = animarray("crossbow_l_leg_explode_v1");
    painarray[painarray.size] = animarray("crossbow_l_leg_explode_v2");
  } else if(damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot")) {
    painarray[painarray.size] = animarray("crossbow_r_leg_explode_v1");
    painarray[painarray.size] = animarray("crossbow_r_leg_explode_v2");
  } else if(damagelocationisany("left_arm_upper", "left_arm_lower", "left_hand")) {
    painarray[painarray.size] = animarray("crossbow_l_arm_explode_v1");
    painarray[painarray.size] = animarray("crossbow_l_arm_explode_v2");
  } else if(damagelocationisany("right_arm_upper", "right_arm_lower", "right_arm")) {
    painarray[painarray.size] = animarray("crossbow_r_arm_explode_v1");
    painarray[painarray.size] = animarray("crossbow_r_arm_explode_v2");
  } else if(self.damageyaw > 135 || self.damageyaw <= -135) {
    painarray[painarray.size] = animarray("crossbow_front_explode_v1");
    painarray[painarray.size] = animarray("crossbow_front_explode_v2");
  } else if(self.damageyaw > -45 && self.damageyaw <= 45) {
    painarray[painarray.size] = animarray("crossbow_back_explode_v1");
    painarray[painarray.size] = animarray("crossbow_back_explode_v2");
  } else
    return getstandpainanim();

  assert(painarray.size > 0, painarray.size);
  self.blockingpain = 1;
  return painarray[randomint(painarray.size)];
}

get_explosive_crossbow_run_pain() {
  painarray = [];

  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield)
    return getrunningforwardpainanim();

  if(damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot"))
    painarray[painarray.size] = animarray("crossbow_run_l_leg_explode");
  else if(damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot"))
    painarray[painarray.size] = animarray("crossbow_run_r_leg_explode");
  else if(damagelocationisany("left_arm_upper", "left_arm_lower", "left_hand"))
    painarray[painarray.size] = animarray("crossbow_run_l_arm_explode");
  else if(damagelocationisany("right_arm_upper", "right_arm_lower", "right_arm"))
    painarray[painarray.size] = animarray("crossbow_run_r_arm_explode");
  else if(self.damageyaw > 135 || self.damageyaw <= -135)
    painarray[painarray.size] = animarray("crossbow_run_front_explode");
  else if(self.damageyaw > -45 && self.damageyaw <= 45)
    painarray[painarray.size] = animarray("crossbow_run_back_explode");
  else
    return getrunningforwardpainanim();

  assert(painarray.size > 0, painarray.size);
  self.blockingpain = 1;
  return painarray[randomint(painarray.size)];
}

mg42pain(pose) {
  assert(isDefined(level.mg_animmg), "You're missing maps\\_mganim::main();Add it to your level.");
  println("\\tmaps\\_mganim::main();");
  return;

  self setflaggedanimknob("painanim", level.mg_animmg["pain_" + pose], 1, 0.1, 1);
  self animscripts\shared::donotetracks("painanim");
}

getstandpainanim() {
  painarray = [];

  if(weaponanims() == "pistol") {
    if(self damagelocationisany("torso_upper", "torso_lower", "left_arm_upper", "right_arm_upper", "neck"))
      painarray[painarray.size] = animarray("chest");

    if(self damagelocationisany("torso_lower", "left_foot", "right_foot", "left_leg_lower", "right_leg_lower")) {
      if(animarrayanyexist("leg"))
        painarray[painarray.size] = animarraypickrandom("leg");
    }

    if(self damagelocationisany("torso_lower", "left_leg_upper", "right_leg_upper")) {
      if(animarrayanyexist("leg"))
        painarray[painarray.size] = animarraypickrandom("leg");
      else
        painarray[painarray.size] = animarray("groin");
    }

    if(self damagelocationisany("head", "neck"))
      painarray[painarray.size] = animarray("head");

    if(self damagelocationisany("left_arm_lower", "left_arm_upper", "torso_upper"))
      painarray[painarray.size] = animarray("left_arm");

    if(self damagelocationisany("right_arm_lower", "right_arm_upper", "torso_upper"))
      painarray[painarray.size] = animarray("right_arm");

    if(painarray.size < 1)
      painarray[painarray.size] = animarray("chest");
  } else if(weaponisgasweapon(self.weapon))
    painarray[painarray.size] = animarray("chest");
  else {
    damageamount = self.damagetaken / self.maxhealth;

    if(damageamount > 0.4 && !damagelocationisany("left_hand", "right_hand", "left_foot", "right_foot", "helmet"))
      painarray[painarray.size] = animarray("big");

    if(self damagelocationisany("head", "neck"))
      painarray[painarray.size] = animarray("head");

    if(self damagelocationisany("torso_upper", "torso_lower", "left_arm_upper", "right_arm_upper", "neck"))
      painarray[painarray.size] = animarray("chest");

    if(self damagelocationisany("right_hand", "right_arm_upper", "right_arm_lower", "torso_upper"))
      painarray[painarray.size] = animarray("drop_gun");

    if(self damagelocationisany("torso_lower", "left_leg_upper", "right_leg_upper")) {
      painarray[painarray.size] = animarraypickrandom("lower_torso_extended");
      painarray[painarray.size] = animarray("groin");
    }

    if(self damagelocationisany("left_hand", "left_arm_lower", "left_arm_upper"))
      painarray[painarray.size] = animarray("left_arm");

    if(self damagelocationisany("right_hand", "right_arm_lower", "right_arm_upper"))
      painarray[painarray.size] = animarray("right_arm");

    if(self damagelocationisany("left_foot", "right_foot", "left_leg_lower", "right_leg_lower", "left_leg_upper", "right_leg_upper")) {
      painarray[painarray.size] = animarraypickrandom("legs_extended");
      painarray[painarray.size] = animarraypickrandom("leg");
    }

    if(self damagelocationisany("torso_upper", "head", "helmet", "neck"))
      painarray[painarray.size] = animarraypickrandom("upper_torso_extended");

    if(painarray.size < 2)
      painarray[painarray.size] = animarray("chest");

    if(painarray.size < 2)
      painarray[painarray.size] = animarray("drop_gun");
  }

  assert(painarray.size > 0, painarray.size);
  return painarray[randomint(painarray.size)];
}

getcrouchpainanim() {
  painarray = [];

  if(weaponisgasweapon(self.weapon))
    painarray[painarray.size] = animarray("chest");
  else {
    if(damagelocationisany("torso_upper", "torso_lower", "left_arm_upper", "right_arm_upper", "neck"))
      painarray[painarray.size] = animarray("chest");

    if(damagelocationisany("head", "neck", "torso_upper"))
      painarray[painarray.size] = animarray("head");

    if(damagelocationisany("left_hand", "left_arm_lower", "left_arm_upper"))
      painarray[painarray.size] = animarray("left_arm");

    if(damagelocationisany("right_hand", "right_arm_lower", "right_arm_upper"))
      painarray[painarray.size] = animarray("right_arm");

    if(painarray.size < 2)
      painarray[painarray.size] = animarray("flinch");
  }

  assert(painarray.size > 0, painarray.size);
  return painarray[randomint(painarray.size)];
}

getpronepainanim() {
  return animarraypickrandom("chest");
}

playpainanim(painanim) {
  if(self.animplaybackrate > 1.5)
    rate = 1.5;
  else
    rate = self.animplaybackrate;

  self setflaggedanimknoballrestart("painanim", painanim, % body, 1, 0.1, rate);

  if(self.a.pose == "prone")
    self updateprone( % prone_legs_up, % prone_legs_down, 1, 0.1, 1);

  if(animhasnotetrack(painanim, "start_aim")) {
    self thread notifystartaim("painanim");
    self endon("start_aim");
  }

  if(self.a.movement == "run") {
    self thread animscripts\shared::donotetracks("painanim");
    self runpainblendout(painanim, rate);
  } else
    self animscripts\shared::donotetracks("painanim");
}

runpainblendout(painanim, rate) {
  if(!isDefined(rate))
    rate = 1.0;

  animplaybacktime = getanimlength(painanim) / rate - 0.2;
  wait(animplaybacktime);

  if(getdvarint(#"_id_FBE667DB") == 1)
    recordenttext("Pain - " + self getentitynumber() + " + blending out from pain to run ", self, level.color_debug["yellow"], "Animscript");

  nextanim = animscripts\run::getrunanim();
  self clearanim( % body, 0.2);
  self setflaggedanimrestart("run_anim", nextanim, 1, 0.2);
}

notifystartaim(animflag) {
  self endon("killanimscript");
  self waittillmatch(animflag, "start_aim");
  self notify("start_aim");
}

additive_pain_think(enable_regular_pain_on_low_health) {
  self endon("death");
  assert(!isDefined(self.a.additivepain), "Calling additive pain twice on the same AI");
  self disable_pain();
  self.a.additivepain = 1;
  starting_health = self.health;

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, type);

    if(isDefined(enable_regular_pain_on_low_health) && enable_regular_pain_on_low_health) {
      if(self.health / starting_health < 0.3) {
        self enable_pain();
        self.a.additivepain = 0;
      }
    }

    self additive_pain();
  }
}

additive_pain() {
  self endon("death");

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.doingadditivepain)) {
    return;
  }
  if(!self.a.additivepain) {
    return;
  }
  self.doingadditivepain = 1;
  painanimarray = array( % pain_add_standing_belly, % pain_add_standing_left_arm, % pain_add_standing_right_arm);
  painanim = % pain_add_standing_belly;

  if(self damagelocationisany("left_arm_lower", "left_arm_upper", "left_hand"))
    painanim = % pain_add_standing_left_arm;

  if(self damagelocationisany("right_arm_lower", "right_arm_upper", "right_hand"))
    painanim = % pain_add_standing_right_arm;
  else if(self damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot"))
    painanim = % pain_add_standing_left_leg;
  else if(self damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot"))
    painanim = % pain_add_standing_right_leg;
  else
    painanim = painanimarray[randomint(painanimarray.size)];

  self setanimlimited( % juggernaut_pain, 1, 0.1, 1);
  self setanimlimited(painanim, 1, 0, 1);
  wait 0.4;
  self clearanim(painanim, 0.2);
  self clearanim( % juggernaut_pain, 0.2);
  self.doingadditivepain = undefined;
}

isanyplayernearby(dist) {
  players = getplayers();
  anybody_nearby = 0;

  for(i = 0; i < players.size; i++) {
    if(isDefined(players[i]) && distancesquared(self.origin, players[i].origin) < dist * dist) {
      anybody_nearby = 1;
      break;
    }
  }

  if(anybody_nearby)
    return true;
  else
    return false;
}

isexplosivedamagemod(mod) {
  if(!isDefined(mod))
    return false;

  if(mod == "MOD_GRENADE" || mod == "MOD_GRENADE_SPLASH" || mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH" || mod == "MOD_EXPLOSIVE")
    return true;

  return false;
}

wasdamagedbyexplosive() {
  if(isexplosivedamagemod(self.damagemod)) {
    self.maydoupwardsdeath = 0;
    return true;
  }

  if(gettime() - anim.lastcarexplosiontime <= 50) {
    rangesq = anim.lastcarexplosionrange * anim.lastcarexplosionrange * 1.2 * 1.2;

    if(distancesquared(self.origin, anim.lastcarexplosiondamagelocation) < rangesq) {
      upwardsdeathrangesq = rangesq * 0.5 * 0.5;
      self.maydoupwardsdeath = distancesquared(self.origin, anim.lastcarexplosionlocation) < upwardsdeathrangesq;
      return true;
    }
  }

  return false;
}

wasdamagedbychargedsnipershot() {
  if(isDefined(self.forcechargedsniperdeath) && self.forcechargedsniperdeath)
    return true;

  if(isDefined(self.damageweapon))
    self.damagedbychargedsnipershot = ischargedshotsniperrifle(self.damageweapon) && isplayer(self.attacker);

  if(isDefined(self.damagedbychargedsnipershot) && self.damagedbychargedsnipershot)
    return true;

  return false;
}

removeblockedanims(array) {
  newarray = [];

  for(index = 0; index < array.size; index++) {
    localdeltavector = getmovedelta(array[index], 0, 1);
    endpoint = self localtoworldcoords(localdeltavector);

    if(self maymovetopoint(endpoint))
      newarray[newarray.size] = array[index];
  }

  return newarray;
}

paindeathnotify() {
  self endon("death");
  wait 0.05;
  self notify("pain_death");
}

printlongdeathdebugtext(loc, text) {
  for(i = 0; i < 100; i++) {
    print3d(loc, text);
    wait 0.05;
  }

}

end_script() {
  self.blockingpain = 0;
}