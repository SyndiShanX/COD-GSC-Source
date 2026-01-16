/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\move.gsc
**************************************/

#include animscripts\setposemovement;
#include animscripts\combat_utility;
#include animscripts\utility;
#include animscripts\shared;
#include animscripts\debug;
#include animscripts\anims;
#include common_scripts\utility;
#include maps\_utility;
#include animscripts\cover_arrival;
#include animscripts\run;
#include animscripts\cover_prone;
#include animscripts\rush;
#include animscripts\face;
#include animscripts\turn;
#include animscripts\walk;
#include animscripts\melee;

main() {
  self endon("killanimscript");
  [[self.exception["move"]]]();
  self trackscriptstate("Move Main", "code");
  self flamethrower_stop_shoot();
  getupifpronebeforemoving();
  animscripts\utility::initialize("move");
  wasincover = self waspreviouslyincover() && isDefined(self.prevnode);

  if(wasincover && !(isDefined(self.shufflemove) && self.shufflemove)) {
    if(isDefined(self.node) && canshuffletonode(self.node)) {
      if(distancesquared(self.origin, self.prevnode.origin) < 256 && self isshufflecovernode(self.node) && !aihasonlypistol()) {
        self.shufflemove = 1;
        self.shufflenode = self.node;
      }
    }
  }

  if(wasincover && (isDefined(self.shufflemove) && self.shufflemove)) {
    movecovertocover();
    movecovertocoverfinish();
  }

  if(self.team == "allies")
    self.blockingpain = 1;

  self animscripts\cover_arrival::startmovetransition();
  self thread animscripts\cover_arrival::setupapproachnode(1);

  if(self.team == "allies")
    self.blockingpain = 0;

  moveinit();
  movemainloop();
}

moveinit() {
  if((self.combatmode == "ambush" || self.combatmode == "ambush_nodes_only" || self.combatmode == "exposed_nodes_only") && (isDefined(self.pathgoalpos) && distancesquared(self.origin, self.pathgoalpos) > 10000))
    self.tacticalwalkrate = 1.5;
  else if(self aihasonlypistolorsmg())
    self.tacticalwalkrate = 1.2 + randomfloat(0.3);
  else
    self.tacticalwalkrate = 0.9 + randomfloat(0.4);

  self.tacticalwalkrate = self.tacticalwalkrate * self.moveplaybackrate;
  self.runngunrate = 0.8 + randomfloat(0.2);
  self.runngunrate = self.runngunrate * self.moveplaybackrate;
  self.arrivalstartdist = undefined;
  self.shoot_while_moving_thread = undefined;
  animscripts\run::stopupdaterunanimweights();
}

moveglobalsinit() {
  anim.moveglobals = spawnstruct();
  anim.moveglobals.max_distance_to_shoot_sq = 2250000;
  anim.moveglobals.motion_angle_offset = 60;
  anim.moveglobals.aim_yaw_threshold = 45;
  anim.moveglobals.try_face_enemy_distsq = 250000;
  anim.moveglobals.code_face_enemy_dist = 500;
  anim.moveglobals.runbackwards_distsq = anim.moveglobals.try_face_enemy_distsq;
  anim.moveglobals.runbackwards_cqb_distsq = 262144;
  anim.moveglobals.min_reload_distsq = 65536;
  anim.moveglobals.relativediranimmap = array("f", "f", "l", "r", "b");
  anim.moveglobals.max_run_n_gun_angle = 145;
  anim.moveglobals.min_distsq_120 = 5625;
  anim.moveglobals.serverfps = 20;
  anim.moveglobals.serverspf = 0.05;
  anim.moveglobals.shuffle_door_max_distsq = 8100;
  anim.moveglobals.shuffle_cover_min_distsq = 1024;
  moveturnglobalsinit();
}

getupifpronebeforemoving() {
  if(self.a.pose == "prone") {
    newpose = self animscripts\utility::choosepose("stand");

    if(newpose != "prone") {
      self animmode("zonly_physics", 0);
      rate = 1;

      if(isDefined(self.grenade))
        rate = 2;

      self animscripts\cover_prone::proneto(newpose, rate);
      self animmode("none", 0);
      self orientmode("face default");
    }
  }
}

movemainloop() {
  startedaiming = 0;
  self animscripts\rush::sidestepinit();
  self thread meleeattackwhilemoving();

  for(;;) {
    self animscripts\face::setidlefacedelayed(anim.alertface);

    if(!startedaiming && self.a.isaiming && (self.a.pose == "stand" || self.a.pose == "crouch")) {
      startaiming();
      startedaiming = 1;
    }

    shouldturn = self animscripts\turn::shouldturn();

    if(shouldturn) {
      self animscripts\turn::doturn();
      startedaiming = 0;
      continue;
    }

    istacticalwalking = !self shouldfacemotion();

    if(self.movemode == "run" || istacticalwalking || self.a.pose == "prone")
      self animscripts\run::moverun();
    else
      self animscripts\walk::movewalk();

    animscripts\rush::trysidestep();
  }
}

mayshootwhilemoving() {
  if(self.weapon == "none")
    return false;

  weapclass = self.weaponclass;

  if(weapclass != "rifle" && weapclass != "smg" && weapclass != "spread" && weapclass != "mg" && weapclass != "grenade" && weapclass != "pistol")
    return false;

  if(isvalidenemy(self.enemy) && distancesquared(self.origin, self.enemy.origin) > anim.moveglobals.max_distance_to_shoot_sq)
    return false;

  if((self issniper() || self aihasonlypistol()) && self shouldfacemotion())
    return false;

  if(isDefined(self.dontshootwhilemoving)) {
    assert(self.dontshootwhilemoving);
    return false;
  }

  return true;
}

shootwhilemoving() {
  self endon("killanimscript");
  self endon("stopShooting");
  self notify("doing_shootWhileMoving");
  self endon("doing_shootWhileMoving");

  self animscripts\debug::debugpushstate("shootWhileMoving");

  while(true) {
    if(!self.bulletsinclip) {
      if(isDefined(self.cqb) && self.cqb && !(self animscripts\utility::weaponanims() == "pistol") || self is_rusher())
        cheatammoifnecessary();

      if(!self.bulletsinclip) {
        wait 0.5;
        continue;
      }
    }

    self shootuntilshootbehaviorchange();
  }

  self animscripts\debug::debugpopstate();
}

meleeattackwhilemoving() {
  self endon("killanimscript");

  while(true) {
    if(isDefined(self.enemy)) {
      if(abs(self getmotionangle()) <= 135)
        animscripts\melee::melee_tryexecuting();
    }

    wait 0.1;
  }
}

#using_animtree("generic_human");

startaiming() {
  self.rightaimlimit = 50;
  self.leftaimlimit = -50;
  self.upaimlimit = 50;
  self.downaimlimit = -50;
  self animscripts\shared::setaiminganims( % run_aim_2, % run_aim_4, % run_aim_6, % run_aim_8);
  self animscripts\shared::trackloopstart();
}

lookatpath() {
  self endon("killanimscript");
  self thread stoplookatpathonkillanimscript();

  while(true) {
    if(shouldlookatpath()) {
      lookatpos = undefined;

      if(isDefined(self.enemy) && self cansee(self.enemy))
        lookatpos = undefined;
      else if(self canseepathgoal())
        lookatpos = self.pathgoalpos;
      else if(self.lookaheaddist > 100)
        lookatpos = self.origin + vectorscale(self.lookaheaddir, self.lookaheaddist) + (0, 0, 0);
      else {
        currentlookahead = self calclookaheadpos(self.origin, 0);

        if(isDefined(currentlookahead))
          lookatpos = currentlookahead["node"] + (0, 0, 0);
      }

      if(isDefined(lookatpos) && getdvarint(#"_id_76D4E0FF")) {
        recordline(self.origin, lookatpos, (1, 1, 0), "Animscript", self);
        record3dtext("lookAt", lookatpos, (1, 1, 0), "Animscript");
      }

      self lookatpos(lookatpos);
    } else {
      self lookatpos();
      wait 1;
    }

    wait 0.05;
  }
}

shouldlookatpath() {
  if(getdvarint(#"_id_F36C4D76")) {
    if(!self.facemotion)
      return false;

    return true;
  }

  return false;
}

stoplookatpathonkillanimscript() {
  self waittill("killanimscript");

  if(isDefined(self))
    self lookatpos();
}

waspreviouslyincover() {
  switch (self.a.prevscript) {
    case "concealment_crouch":
    case "concealment_prone":
    case "concealment_stand":
    case "cover_crouch":
    case "cover_left":
    case "cover_pillar":
    case "cover_prone":
    case "cover_right":
    case "cover_stand":
    case "cover_wide_left":
    case "cover_wide_right":
    case "hide":
    case "turret":
      return true;
  }

  return false;
}

canshuffletonode(node) {
  switch (node.type) {
    case "Conceal Crouch":
    case "Conceal Stand":
    case "Cover Crouch":
    case "Cover Left":
    case "Cover Right":
    case "Cover Stand":
      return true;
  }

  return false;
}

isshuffledirectionvalid(startnode, endnode, shuffleleft) {
  if(startnode.type == "Cover Left" && shuffleleft)
    return false;

  if(startnode.type == "Cover Right" && !shuffleleft)
    return false;

  if(endnode.type == "Cover Left" && !shuffleleft)
    return false;

  if(endnode.type == "Cover Right" && shuffleleft)
    return false;

  return true;
}

get_shuffle_to_corner_start_anim(shuffleleft, startnode) {
  if(startnode.type == "Cover Left") {
    assert(!shuffleleft);
    return animarray("cornerL_shuffle_start");
  } else if(startnode.type == "Cover Right") {
    assert(shuffleleft);
    return animarray("cornerR_shuffle_start");
  } else if(shuffleleft)
    return animarray("shuffleL_start");
  else
    return animarray("shuffleR_start");
}

movecovertocover_getshufflestartanim(shuffleleft, startnode, endnode) {
  assert(isDefined(startnode));
  assert(isDefined(endnode));
  shuffleanim = undefined;

  if(endnode.type == "Cover Left") {
    assert(shuffleleft);
    shuffleanim = get_shuffle_to_corner_start_anim(shuffleleft, startnode);
  } else if(endnode.type == "Cover Right") {
    assert(!shuffleleft);
    shuffleanim = get_shuffle_to_corner_start_anim(shuffleleft, startnode);
  } else if(endnode.type == "Cover Stand" && startnode.type == endnode.type) {
    if(shuffleleft)
      shuffleanim = animarray("coverStand_shuffleL_start");
    else
      shuffleanim = animarray("coverStand_shuffleR_start");
  } else if(shuffleleft)
    shuffleanim = get_shuffle_to_corner_start_anim(shuffleleft, startnode);
  else
    shuffleanim = get_shuffle_to_corner_start_anim(shuffleleft, startnode);

  return shuffleanim;
}

movecovertocover_getshuffleloopanim(shuffleleft, startnode, endnode) {
  assert(isDefined(startnode));
  assert(isDefined(endnode));
  shuffleanim = undefined;

  if(endnode.type == "Cover Left") {
    assert(shuffleleft);
    shuffleanim = animarray("shuffleL");
  } else if(endnode.type == "Cover Right")
    shuffleanim = animarray("shuffleR");
  else if(endnode.type == "Cover Stand" && startnode.type == endnode.type) {
    if(shuffleleft)
      shuffleanim = animarray("coverStand_shuffleL");
    else
      shuffleanim = animarray("coverStand_shuffleR");
  } else if(shuffleleft)
    shuffleanim = animarray("shuffleL");
  else
    shuffleanim = animarray("shuffleR");

  return shuffleanim;
}

movecovertocover_getshuffleendanim(shuffleleft, startnode, endnode) {
  assert(isDefined(startnode));
  assert(isDefined(endnode));
  shuffleanim = undefined;

  if(endnode.type == "Cover Left") {
    assert(shuffleleft);
    shuffleanim = animarray("cornerL_shuffle_end");
  } else if(endnode.type == "Cover Right") {
    assert(!shuffleleft);
    shuffleanim = animarray("cornerR_shuffle_end");
  } else if(endnode.type == "Cover Stand" && startnode.type == endnode.type) {
    if(shuffleleft)
      shuffleanim = animarray("coverStand_shuffleL_end");
    else
      shuffleanim = animarray("coverStand_shuffleR_end");
  } else if(shuffleleft)
    shuffleanim = animarray("shuffleL_end");
  else
    shuffleanim = animarray("shuffleR_end");

  return shuffleanim;
}

movecovertocover_checkstartpose(startnode, endnode) {
  if(self.a.pose == "stand" && (endnode.type != "Cover Stand" || startnode.type != "Cover Stand")) {
    self.a.pose = "crouch";
    return false;
  }

  return true;
}

movecovertocover_checkendpose(endnode) {
  if(self.a.pose == "crouch" && endnode.type == "Cover Stand") {
    self.a.pose = "stand";
    return false;
  }

  return true;
}

movecovertocover() {
  self endon("killanimscript");
  self endon("goal_changed");
  shufflenode = self.shufflenode;
  self.shufflemove = undefined;
  self.shufflenode = undefined;
  self.shufflemoveinterrupted = 1;

  if(!isDefined(self.prevnode)) {
    return;
  }
  if(!isDefined(self.node) || !isDefined(shufflenode) || self.node != shufflenode) {
    return;
  }
  startnode = self.prevnode;
  node = self.node;

  if((startnode.type == "Cover Left" || startnode.type == "Cover Right") && startnode.type == node.type) {
    return;
  }
  if(startnode.type == "Cover Pillar") {
    return;
  }
  movedir = node.origin - self.origin;

  if(lengthsquared(movedir) < 1) {
    return;
  }
  movedir = vectornormalize(movedir);
  forward = anglestoforward(node.angles);
  shuffleleft = forward[0] * movedir[1] - forward[1] * movedir[0] > 0;

  if(movedoorsidetoside(shuffleleft, startnode, node)) {
    return;
  }
  if(!isshuffledirectionvalid(startnode, node, shuffleleft)) {
    return;
  }
  if(movecovertocover_checkstartpose(startnode, node))
    blendtime = 0.1;
  else
    blendtime = 0.4;

  self animmode("zonly_physics", 0);
  self clearanim( % body, blendtime);
  startanim = movecovertocover_getshufflestartanim(shuffleleft, startnode, node);
  shuffleanim = movecovertocover_getshuffleloopanim(shuffleleft, startnode, node);
  endanim = movecovertocover_getshuffleendanim(shuffleleft, startnode, node);

  if(animhasnotetrack(startanim, "finish"))
    startendtime = getnotetracktimes(startanim, "finish")[0];
  else
    startendtime = 1;

  startdist = length(getmovedelta(startanim, 0, startendtime));
  shuffledist = length(getmovedelta(shuffleanim, 0, 1));
  enddist = length(getmovedelta(endanim, 0, 1));
  remainingdist = distance(self.origin, node.origin);

  if(remainingdist > startdist) {
    self orientmode("face angle", getnodeforwardyaw(startnode));
    self setflaggedanimrestart("shuffle_start", startanim, 1, blendtime);
    self animscripts\shared::donotetracks("shuffle_start");
    self clearanim(startanim, 0.2);
    remainingdist = remainingdist - startdist;
    blendtime = 0.2;
  } else
    self orientmode("face angle", node.angles[1]);

  playend = 0;

  if(remainingdist > enddist) {
    playend = 1;
    remainingdist = remainingdist - enddist;
  }

  looptime = getanimlength(shuffleanim);
  playtime = looptime * (remainingdist / shuffledist) * 0.9;
  playtime = floor(playtime * anim.moveglobals.serverfps) * anim.moveglobals.serverspf;
  self setflaggedanim("shuffle", shuffleanim, 1, blendtime);
  self donotetracksfortime(playtime, "shuffle");

  for(i = 0; i < 2; i++) {
    remainingdist = distance(self.origin, node.origin);

    if(playend)
      remainingdist = remainingdist - enddist;

    if(remainingdist < 4) {
      break;
    }

    playtime = looptime * (remainingdist / shuffledist) * 0.9;
    playtime = floor(playtime * anim.moveglobals.serverfps) * anim.moveglobals.serverspf;

    if(playtime < 0.05) {
      break;
    }

    self donotetracksfortime(playtime, "shuffle");
  }

  if(playend) {
    if(movecovertocover_checkendpose(node))
      blendtime = 0.2;
    else
      blendtime = 0.4;

    self clearanim(shuffleanim, blendtime);
    self setflaggedanim("shuffle_end", endanim, 1, blendtime);
    self animscripts\shared::donotetracks("shuffle_end");
  }

  self teleport(node.origin);
  self animmode("normal");
  self.shufflemoveinterrupted = undefined;
}

movecovertocoverfinish() {
  if(isDefined(self.shufflemoveinterrupted)) {
    self clearanim( % cover_shuffle, 0.2);
    self.shufflemoveinterrupted = undefined;
    self animmode("none", 0);
    self orientmode("face default");
  } else {
    wait 0.2;
    self clearanim( % cover_shuffle, 0.2);
  }
}

movedoorsidetoside(shuffleleft, startnode, endnode) {
  sidetosideanim = undefined;

  if(startnode.type == "Cover Right" && endnode.type == "Cover Left" && !shuffleleft)
    sidetosideanim = animarray("corner_door_R2L");
  else if(startnode.type == "Cover Left" && endnode.type == "Cover Right" && shuffleleft)
    sidetosideanim = animarray("corner_door_L2R");

  if(!isDefined(sidetosideanim))
    return false;

  if(distance2dsquared(startnode.origin, endnode.origin) > anim.moveglobals.shuffle_door_max_distsq)
    return false;

  self animmode("zonly_physics", 0);
  self orientmode("face current");
  self setflaggedanimrestart("sideToSide", sidetosideanim, 1, 0.2);
  assert(animhasnotetrack(sidetosideanim, "slide_start"));
  assert(animhasnotetrack(sidetosideanim, "slide_end"));
  self animscripts\shared::donotetracks("sideToSide", ::handlesidetosidenotetracks);
  slidestarttime = self getanimtime(sidetosideanim);
  slidedir = endnode.origin - startnode.origin;
  slidedir = vectornormalize((slidedir[0], slidedir[1], 0));
  animdelta = getmovedelta(sidetosideanim, slidestarttime, 1);
  remainingvec = endnode.origin - self.origin;
  remainingvec = (remainingvec[0], remainingvec[1], 0);
  slidedist = vectordot(remainingvec, slidedir) - abs(animdelta[1]);

  if(slidedist > 2) {
    slideendtime = getnotetracktimes(sidetosideanim, "slide_end")[0];
    slidetime = (slideendtime - slidestarttime) * getanimlength(sidetosideanim);
    assert(slidetime > 0);
    slideframes = int(ceil(slidetime / 0.05));
    slideincrement = slidedir * slidedist / slideframes;
    self thread slidefortime(slideincrement, slideframes);
  }

  self animscripts\shared::donotetracks("sideToSide");
  self teleport(endnode.origin);
  self animmode("none");
  self orientmode("face default");
  self.shufflemoveinterrupted = undefined;
  wait 0.2;
  return true;
}

handlesidetosidenotetracks(note) {
  if(note == "slide_start")
    return true;
}

slidefortime(slideincrement, slideframes) {
  self endon("killanimscript");
  self endon("goal_changed");

  while(slideframes > 0) {
    self teleport(self.origin + slideincrement);
    slideframes--;
    wait 0.05;
  }
}

end_script() {
  self.a.isturning = 0;
  self.blockingpain = 0;
  run_end_script();
}