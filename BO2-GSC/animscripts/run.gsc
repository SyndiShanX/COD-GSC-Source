/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\run.gsc
**************************************/

#include animscripts\utility;
#include animscripts\combat_utility;
#include animscripts\setposemovement;
#include animscripts\debug;
#include animscripts\anims;
#include common_scripts\utility;
#include maps\_utility;
#include animscripts\cqb;
#include animscripts\move;
#include animscripts\shared;
#include animscripts\run;
#include animscripts\turn;
#include animscripts\shoot_behavior;

moverun() {
  self animscripts\debug::debugpushstate("MoveRun");

  desiredpose = self animscripts\utility::choosepose("stand");

  switch (desiredpose) {
    case "stand":
      if(beginstandrun()) {
        self animscripts\debug::debugpopstate("MoveRun", "now running");

        return;
      }

      if(reloadstandrun()) {
        self animscripts\debug::debugpopstate("MoveRun", "reloaded");

        return;
      }

      if(self animscripts\cqb::shouldcqb()) {
        self animscripts\debug::debugpushstate("MoveStandCombatNormal (CQB)");

        movestandcombatnormal();

        self animscripts\debug::debugpopstate("MoveStandCombatNormal (CQB)");

        self animscripts\debug::debugpopstate("MoveRun");

        return;
      }

      if(self animscripts\utility::isincombat()) {
        if(isDefined(self.run_combatanim)) {
          self animscripts\debug::debugpushstate("MoveStandCombatOverride");

          movestandcombatoverride();

          self animscripts\debug::debugpopstate("MoveStandCombatOverride");

        } else {
          self animscripts\debug::debugpushstate("MoveStandCombatNormal");

          movestandcombatnormal();

          self animscripts\debug::debugpopstate("MoveStandCombatNormal");

        }
      } else if(isDefined(self.run_noncombatanim)) {
        self animscripts\debug::debugpushstate("MoveStandNoncombatOverride");

        movestandnoncombatoverride();

        self animscripts\debug::debugpopstate("MoveStandNoncombatOverride");

      } else {
        self animscripts\debug::debugpushstate("MoveStandNoncombatNormal");

        movestandnoncombatnormal();

        self animscripts\debug::debugpopstate("MoveStandNoncombatNormal");

      }

      break;
    case "crouch":
      if(begincrouchrun()) {
        self animscripts\debug::debugpopstate("MoveRun", "already running");

        return;
      }

      if(isDefined(self.crouchrun_combatanim)) {
        self animscripts\debug::debugpushstate("MoveCrouchRunOverride");

        movecrouchrunoverride();

        self animscripts\debug::debugpopstate("MoveCrouchRunOverride");

      } else {
        self animscripts\debug::debugpushstate("MoveCrouchRunNormal");

        movecrouchrunnormal();

        self animscripts\debug::debugpopstate("MoveCrouchRunNormal");

      }

      break;
    default:
      assert(desiredpose == "prone");

      if(beginpronerun()) {
        self animscripts\debug::debugpopstate("MoveRun", "already running");

        return;
      }

      self animscripts\debug::debugpushstate("proneCrawl");

      pronecrawl();

      self animscripts\debug::debugpopstate();

      break;
  }

  self animscripts\debug::debugpopstate("MoveRun");
}

#using_animtree("generic_human");

movestandcombatoverride() {
  self clearanim( % combatrun, 0.6);
  self setanimknoball( % combatrun, % body, 1, 0.5, self.moveplaybackrate);
  self setflaggedanimknob("runanim", self.run_combatanim, 1, 0.5, self.moveplaybackrate);
  donotetracksnoshootstandcombat("runanim");
}

movestandcombatnormal() {
  self clearanim( % walk_and_run_loops, 0.2);
  self setanimknob( % combatrun, 1.0, 0.5, self.moveplaybackrate);
  shouldsprint = shouldfullsprint();
  decidedanimation = 0;
  mayshootwhilemoving = animscripts\move::mayshootwhilemoving();
  aimingoff();
  self orientmode("face default");

  if(!self.bulletsinclip && mayshootwhilemoving)
    cheatammoifnecessary();

  rundebuginfo();

  if(!shouldsprint && mayshootwhilemoving && self.bulletsinclip > 0 && isvalidenemy(self.enemy)) {
    self animscripts\shared::updatelaserstatus(1);
    animscripts\run::stopupdaterunanimweights();
    runshootwhilemovingthreads();
    cheatammoifrunningbackward();

    if(isplayer(self.enemy))
      self updateplayersightaccuracy();

    if(shouldtacticalwalk()) {
      tacticalwalkforwardtobackwardtransition();
      decidedanimation = tacticalwalk();
    } else if(shouldrunngun())
      decidedanimation = runngunforward();
  }

  if(!decidedanimation) {
    self animscripts\shared::updatelaserstatus(0);
    stoptacticalwalk();
    stoprunngun();

    if(shouldsprintforvariation() || shouldsprint)
      fullsprint();
    else {
      stopfullsprint();
      combatrun();
    }
  }

  donotetracksnoshootstandcombat("runanim");
  self thread stopshootwhilemovingthreads();
}

cheatammoifrunningbackward() {
  if(shouldtacticalwalk() || shouldrunngun()) {
    if(shouldshootwhilerunningbackward())
      self.bulletsinclip = weaponclipsize(self.weapon);
  }
}

shouldfullsprint() {
  if(isDefined(self.sprint) && self.sprint)
    return true;

  if(isDefined(self.grenade) && isDefined(self.enemy))
    return distance2dsquared(self.origin, self.enemy.origin) > 90000;

  return false;
}

fullsprint() {
  if(!isDefined(self.a.fullsprintanim)) {
    if(isDefined(self.cqb) && self.cqb && !(self animscripts\utility::weaponanims() == "pistol"))
      self.a.fullsprintanim = animarraypickrandom("cqb_sprint_f");
    else
      self.a.fullsprintanim = animarraypickrandom("sprint");
  }

  self orientmode("face motion");
  self setflaggedanimknob("runanim", self.a.fullsprintanim, 1, 0.5, self.moveplaybackrate);
  return true;
}

stopfullsprint() {
  self.a.fullsprintanim = undefined;
}

shouldsprintforvariation() {
  if(isDefined(self.cqb) && self.cqb && !(self animscripts\utility::weaponanims() == "pistol") || self.iswounded)
    return false;

  if(isDefined(self.a.neversprintforvariation) && self.a.neversprintforvariation)
    return false;

  time = gettime();

  if(isDefined(self.a.dangersprinttime)) {
    if(time < self.a.dangersprinttime)
      return true;

    if(time - self.a.dangersprinttime < 6000)
      return false;
  }

  if(!isDefined(self.enemy) || !issentient(self.enemy))
    return false;

  isallowedtosprint = self lastknowntime(self.enemy) + 2000 > time || distancesquared(self.enemy.origin, self.origin) > 360000;

  if(randomint(100) < 40 && isallowedtosprint) {
    self.a.dangersprinttime = time + 2000 + randomint(1000);
    return true;
  }

  return false;
}

shouldtacticalwalk() {
  if(isDefined(self.pathgoalpos)) {
    if(!self shouldfacemotionwhilerunning())
      return true;
  }

  return false;
}

tacticalwalk() {
  self.a.tacticalwalking = 1;
  relativedir = anim.moveglobals.relativediranimmap[self.relativedir];

  if(relativedir == "f")
    aimingon("tactical_f", 45);
  else if(relativedir == "b")
    aimingon("tactical_b", 45);
  else
    aimingon("tactical_l", 45);

  self orientmode("face default");
  motionangle = self getmotionangle();

  if(abs(motionangle) < 10)
    blendtime = 0.4;
  else
    blendtime = 0.2;

  runforwardanimname = "tactical_walk_" + relativedir;
  runforwardanim = animarraypickrandom(runforwardanimname, "move", 1);
  self setflaggedanimknob("runanim", runforwardanim, 1, blendtime, self.tacticalwalkrate);
  return true;
}

tacticalwalkforwardtobackwardtransition() {
  if(isDefined(self.pathgoalpos) && distancesquared(self.origin, self.pathgoalpos) < 22500) {
    return;
  }
  if(self.lookaheaddist < 150) {
    return;
  }
  toenemyyaw = vectortoangles(self.enemy.origin - self.origin)[1];
  anglediff = angleclamp180(toenemyyaw - self.angles[1]);
  isrunningforward = absangleclamp180(self getmotionangle()) < 20;
  facedir = vectorscale(self.lookaheaddir, -1);
  faceangle = vectortoangles(facedir)[1];
  yawtoenemy = absangleclamp180(self.angles[1] - faceangle);

  if(isrunningforward) {
    if(anim.moveglobals.relativediranimmap[self.relativedir] == "b") {
      self thread stopshootwhilemovingthreads();
      self animscripts\shared::stoptracking();

      if(isDefined(self.cqb) && self.cqb && !(self animscripts\utility::weaponanims() == "pistol"))
        animpostfix = "_cqb";
      else
        animpostfix = "";

      if(anglediff > 0)
        transitionanim = animarray("run_f_to_bR" + animpostfix, "move");
      else
        transitionanim = animarray("run_f_to_bL" + animpostfix, "move");

      runanimname = "tactical_walk";
      self.a.turnangle = yawtoenemy * sign(anglediff);
      self animscripts\turn::doturn(transitionanim, animarray(runanimname + "_b"), -180, 1);
      self animscripts\shared::setaiminganims( % run_aim_2, % run_aim_4, % run_aim_6, % run_aim_8);
      runshootwhilemovingthreads();
      self animscripts\shared::trackloopstart();
      self orientmode("face default");
    }
  }
}

stoptacticalwalk() {
  self.a.tacticalwalking = 0;
}

shouldrunngun() {
  if(aihasonlypistol())
    return false;

  toenemyyaw = vectortoangles(self.enemy.origin - self.origin)[1];
  anglediff = angleclamp180(toenemyyaw - self.angles[1]);

  if(abs(anglediff) > anim.moveglobals.max_run_n_gun_angle)
    return false;

  if(self.shootstyle != "none" || isDefined(self.scriptenemy) && self.scriptenemy == self.enemy)
    return true;

  return false;
}

runngunchooserunanimname() {
  runanimname = "run_n_gun";

  if(isDefined(self.cqb) && self.cqb && !(self animscripts\utility::weaponanims() == "pistol"))
    runanimname = "cqb_run_n_gun";

  return runanimname;
}

runngunchooseaimanimnameprefix() {
  aimanimname = "add";

  if(isDefined(self.cqb) && self.cqb && !(self animscripts\utility::weaponanims() == "pistol"))
    aimanimname = "cqb_add";

  return aimanimname;
}

runngunforward() {
  runanimname = runngunchooserunanimname();
  aimanimname = runngunchooseaimanimnameprefix();
  runbackwardanimname = animarraypickrandom(runanimname + "_b", "move", 1);
  toenemyyaw = vectortoangles(self.enemy.origin - self.origin)[1];
  anglediff = angleclamp180(toenemyyaw - self.angles[1]);

  if(canshootwhilerunningforward()) {
    runforwardanimname = runanimname + "_f";
    aimingon(aimanimname + "_f", 45);
  } else if(abs(anglediff) < 100) {
    if(anglediff > 0) {
      runforwardanimname = runanimname + "_l";
      aimingon(aimanimname + "_l", 45);
    } else {
      runforwardanimname = runanimname + "_r";
      aimingon(aimanimname + "_r", 45);
    }
  } else if(!(isDefined(self.a.disable120runngun) && self.a.disable120runngun) && !(isDefined(self.cqb) && self.cqb && !(self animscripts\utility::weaponanims() == "pistol")) && abs(anglediff) < 135 && canshootwhilerunningforward120() && (animarrayexist("run_n_gun_l_120") && animarrayexist("run_n_gun_r_120"))) {
    if(anglediff > 0) {
      runforwardanimname = runanimname + "_l_120";
      aimingon(aimanimname + "_l_120", 45);
    } else {
      runforwardanimname = runanimname + "_r_120";
      aimingon(aimanimname + "_r_120", 45);
    }
  } else
    return false;

  runforwardanimname = animarraypickrandom(runforwardanimname, "move", 1);
  self setflaggedanimknob("runanim", runforwardanimname, 1, 0.2, self.runngunrate);
  self.a.allowedpartialreloadontheruntime = gettime() + 600;
  return true;
}

runngunforwardtobackwardtransition() {
  toenemyyaw = vectortoangles(self.enemy.origin - self.origin)[1];
  anglediff = angleclamp180(toenemyyaw - self.angles[1]);
  facedir = vectorscale(self.lookaheaddir, -1);
  faceangle = vectortoangles(facedir)[1];
  yawtoenemy = absangleclamp180(self.angles[1] - faceangle);

  if(yawtoenemy > 175) {
    self thread stopshootwhilemovingthreads();
    self animscripts\shared::stoptracking();

    if(anglediff > 0)
      transitionanim = animarray("run_f_to_bR", "move");
    else
      transitionanim = animarray("run_f_to_bL", "move");

    runanimname = "run_n_gun";
    self.a.turnangle = yawtoenemy * sign(anglediff);
    self animscripts\turn::doturn(transitionanim, animarray(runanimname + "_b"), -180, 1);
    self orientmode("face angle", self.angles[1]);
    self animscripts\shared::setaiminganims( % run_aim_2, % run_aim_4, % run_aim_6, % run_aim_8);
    runshootwhilemovingthreads();
    self animscripts\shared::trackloopstart();
  }
}

runngunbackward() {
  runanimname = runngunchooserunanimname();
  runforwardanimname = animarraypickrandom(runanimname + "_f", "move", 1);
  runbackwardanimname = animarraypickrandom(runanimname + "_b", "move", 1);
  aimingon("add_f", 50);
  facedir = vectorscale(self.lookaheaddir, -1);
  faceangle = vectortoangles(facedir)[1];
  self orientmode("face angle", faceangle);
  self setflaggedanimknob("runanim", runbackwardanimname, 1, 0.2, self.runngunrate);
  return true;
}

stoprunngun() {
  self clearanim( % run_n_gun_f, 0.3);
  self clearanim( % run_n_gun_r, 0.3);
  self clearanim( % run_n_gun_l, 0.3);
  self clearanim( % ai_run_n_gun_l_120, 0.3);
  self clearanim( % ai_run_n_gun_l_120, 0.3);
  aimingoff(0.3);
}

combatrun() {
  if(isDefined(self.cqb) && self.cqb && !(self animscripts\utility::weaponanims() == "pistol") && isDefined(self.cqb_point_of_interest) || isDefined(self.cqb_target))
    aimingon("cqb_f", 45);

  self orientmode("face motion");
  runanim = getrunanim();
  self setflaggedanimknob("runanim", runanim, 1, 0.1, self.moveplaybackrate);
}

movestandnoncombatnormal() {
  self endon("movemode");
  self clearanim( % combatrun, 0.6);
  self setanimknoball( % combatrun, % body, 1, 0.2, self.moveplaybackrate);
  prerunanim = getrunanim();
  self setflaggedanimknob("runanim", prerunanim, 1, 0.3, self.moveplaybackrate);
  self thread updaterunanimweightsthread("NonCombat", % combatrun_forward, animarray("combat_run_b"), animarray("combat_run_l"), animarray("combat_run_r"));
  donotetracksnoshootstandcombat("runanim");
}

movestandnoncombatoverride() {
  self endon("movemode");
  self clearanim( % combatrun, 0.6);
  self setflaggedanimknoball("runanim", self.run_noncombatanim, % body, 1, 0.3, self.moveplaybackrate);
  donotetracksnoshootstandcombat("runanim");
}

shouldreloadwhilerunning() {
  if(shouldforcebehavior("reload"))
    return true;

  if(shouldforcebehavior("force_cheat_ammo")) {
    self.bulletsinclip = 10;

    if(self.bulletsinclip > weaponclipsize(self.weapon))
      self.bulletsinclip = weaponclipsize(self.weapon);

    return false;
  }

  reloadifempty = isDefined(self.a.allowedpartialreloadontheruntime) && self.a.allowedpartialreloadontheruntime > gettime();
  reloadifempty = reloadifempty || isDefined(self.enemy) && distancesquared(self.origin, self.enemy.origin) < anim.moveglobals.min_reload_distsq;

  if(reloadifempty) {
    if(!self needtoreload(0))
      return false;
  } else if(!self needtoreload(0.5))
    return false;

  if(shouldtacticalwalk())
    return false;

  canshootwhilerunning = animscripts\move::mayshootwhilemoving() && isvalidenemy(self.enemy) && (canshootwhilerunningforward() || canshootwhilerunningbackward());

  if(canshootwhilerunning && !self needtoreload(0))
    return false;

  if(!isDefined(self.pathgoalpos) || distancesquared(self.origin, self.pathgoalpos) < anim.moveglobals.min_reload_distsq)
    return false;

  motionangle = angleclamp180(self getmotionangle());

  if(abs(motionangle) > 25)
    return false;

  if(self weaponanims() != "rifle") {
    if(!(self weaponanims() == "pistol" && isDefined(self.forcesidearm) && self.forcesidearm))
      return false;
  }

  if(self is_rusher())
    return false;

  if(!runloopisnearbeginning())
    return false;

  return true;
}

reloadstandrun() {
  if(!shouldreloadwhilerunning())
    return false;

  aimingoff();
  reloadstandruninternal();
  self notify("abort_reload");
  self orientmode("face default");
  return true;
}

runloopisnearbeginning() {
  animfraction = self getanimtime( % walk_and_run_loops);
  looplength = getanimlength(animscripts\run::getrunanim()) / 3.0;
  animfraction = animfraction * 3.0;

  if(animfraction > 3)
    animfraction = animfraction - 2.0;
  else if(animfraction > 2)
    animfraction = animfraction - 1.0;

  if(animfraction < 0.15 / looplength)
    return true;

  if(animfraction > 1 - 0.3 / looplength)
    return true;

  return false;
}

reloadstandruninternal() {
  self endon("movemode");
  self orientmode("face motion");
  self delay_thread(0.05, animscripts\shared::stoptracking);
  flagname = "reload_" + getuniqueflagnameindex();
  flagname = "reload_" + getuniqueflagnameindex();
  reloadanim = undefined;

  if(isDefined(self.cqb) && self.cqb && !(self animscripts\utility::weaponanims() == "pistol")) {
    if(self.movemode == "walk" || self.walk)
      reloadanim = animarraypickrandom("cqb_reload_walk");
    else
      reloadanim = animarraypickrandom("cqb_reload_run");
  } else
    reloadanim = animarraypickrandom("reload");

  assert(isDefined(reloadanim));
  self setflaggedanimknoballrestart(flagname, reloadanim, % body, 1, 0.25);
  animscripts\shared::donotetracks(flagname);
  self animscripts\shared::trackloopstart();
}

aimingon(aimanimname, aimlimit) {
  if(!isDefined(aimanimname))
    aimanimname = "add_f";

  self.a.isaiming = 1;
  ispistoltacticalwalkaim = issubstr(aimanimname, "tactical") && aihasonlypistol();

  if(aihasonlypistolorsmg()) {
    if(issubstr(aimanimname, "tactical"))
      ispistoltacticalwalkaim = 1;
    else {
      self clearanim( % tactical_walk_pistol_aim2, 0);
      self clearanim( % tactical_walk_pistol_aim4, 0);
      self clearanim( % tactical_walk_pistol_aim6, 0);
      self clearanim( % tactical_walk_pistol_aim8, 0);
    }
  }

  if(ispistoltacticalwalkaim)
    self animscripts\shared::setaiminganims( % tactical_walk_pistol_aim2, % tactical_walk_pistol_aim4, % tactical_walk_pistol_aim6, % tactical_walk_pistol_aim8);
  else
    self animscripts\shared::setaiminganims( % run_aim_2, % run_aim_4, % run_aim_6, % run_aim_8);

  if(!isDefined(aimlimit))
    aimlimit = 50;

  self.rightaimlimit = aimlimit;
  self.leftaimlimit = aimlimit * -1;
  self.upaimlimit = aimlimit;
  self.downaimlimit = aimlimit * -1;
  self setanimknoblimited(animarray(aimanimname + "_aim_up"), 1, 0.2);
  self setanimknoblimited(animarray(aimanimname + "_aim_down"), 1, 0.2);
  self setanimknoblimited(animarray(aimanimname + "_aim_left"), 1, 0.2);
  self setanimknoblimited(animarray(aimanimname + "_aim_right"), 1, 0.2);
}

aimingoff(blendouttime) {
  self.a.isaiming = 0;

  if(!isDefined(blendouttime))
    blendouttime = 0.2;

  self clearanim(self.a.aim_2, blendouttime);
  self clearanim(self.a.aim_4, blendouttime);
  self clearanim(self.a.aim_6, blendouttime);
  self clearanim(self.a.aim_8, blendouttime);
}

runshootwhilemovingthreads() {
  self notify("want_shoot_while_moving");

  if(isDefined(self.shoot_while_moving_thread)) {
    return;
  }
  self.shoot_while_moving_thread = 1;
  self thread rundecidewhatandhowtoshoot();
  self thread runshootwhilemoving();
}

rundecidewhatandhowtoshoot() {
  self endon("killanimscript");
  self endon("end_shoot_while_moving");
  self animscripts\shoot_behavior::decidewhatandhowtoshoot("normal");
}

runshootwhilemoving() {
  self endon("killanimscript");
  self endon("end_shoot_while_moving");
  self animscripts\move::shootwhilemoving();
}

stopshootwhilemovingthreads() {
  self endon("killanimscript");
  self endon("want_shoot_while_moving");
  wait 0.05;
  self notify("end_shoot_while_moving");
  self.shoot_while_moving_thread = undefined;
}

updaterunanimweightsthread(moveanimtype, frontanim, backanim, leftanim, rightanim) {
  if(isDefined(self.a.update_move_anim_type) && self.a.update_move_anim_type == moveanimtype) {
    return;
  }
  self notify("stop_move_anim_update");
  self.a.update_move_anim_type = moveanimtype;
  self endon("killanimscript");
  self endon("stop_move_anim_update");

  while(true) {
    updaterunweightsonce(frontanim, backanim, leftanim, rightanim);
    wait 0.05;
  }
}

stopupdaterunanimweights() {
  self notify("stop_move_anim_update");
  self.a.update_move_anim_type = undefined;
}

updaterunweightsonce(frontanim, backanim, leftanim, rightanim) {
  if(self.facemotion) {
    self setanim(frontanim, 1, 0.1, 1);
    self clearanim(backanim, 0.2);

    if(isDefined(leftanim))
      self clearanim(leftanim, 0.2);

    if(isDefined(rightanim))
      self clearanim(rightanim, 0.2);
  } else {
    animweights = animscripts\utility::quadrantanimweights(self getmotionangle());

    if(animweights["back"] > 0) {
      animweights["back"] = 1;
      animweights["left"] = 0;
      animweights["right"] = 0;
    }

    self setanim(frontanim, animweights["front"], 0.1, 1);
    self setanim(backanim, animweights["back"], 0.1, 1);

    if(isDefined(leftanim))
      self setanim(leftanim, animweights["left"], 0.1, 1);

    if(isDefined(rightanim))
      self setanim(rightanim, animweights["right"], 0.1, 1);
  }
}

updaterunweights(notifystring, frontanim, backanim, leftanim, rightanim) {
  self endon("killanimscript");
  self endon(notifystring);

  if(gettime() == self.a.scriptstarttime) {
    updaterunweightsonce(frontanim, backanim, leftanim, rightanim);
    wait 0.05;
  }

  for(;;) {
    updaterunweightsonce(frontanim, backanim, leftanim, rightanim);
    wait(getrunanimupdatefrequency());
  }
}

movecrouchrunoverride() {
  self endon("movemode");
  self setflaggedanimknoball("runanim", self.crouchrun_combatanim, % body, 1, 0.4, self.moveplaybackrate);
  animscripts\shared::donotetracksfortime(0.2, "runanim");
}

movecrouchrunnormal() {
  self clearanim( % walk_and_run_loops, 0.2);
  self setanimknob( % combatrun, 1.0, 0.5, self.moveplaybackrate);
  aimingoff();
  self orientmode("face motion");

  if(!self.bulletsinclip)
    cheatammoifnecessary();

  if(animscripts\move::mayshootwhilemoving() && self.bulletsinclip > 0 && isvalidenemy(self.enemy)) {
    animscripts\run::stopupdaterunanimweights();
    runshootwhilemovingthreads();

    rundebuginfo();

    if(isplayer(self.enemy))
      self updateplayersightaccuracy();

    aimingon("add_f");
  }

  runanim = getcrouchrunanim();
  self setflaggedanimknob("runanim", runanim, 1, 0.5);
  donotetracksnoshootstandcombat("runanim");
  self thread stopshootwhilemovingthreads();
  return true;
}

getcrouchrunanim() {
  if(isDefined(self.a.crouchrunanim))
    return self.a.crouchrunanim;

  if(self.a.pose != "crouch")
    return animarray("crouch_run_f", "move");

  return animarray("combat_run_f", "move");
}

pronecrawl() {
  self.a.movement = "run";
  self setflaggedanimknob("runanim", animarray("combat_run_f"), 1, 0.3, self.moveplaybackrate);
  animscripts\shared::donotetracksfortime(0.25, "runanim");
}

canshootwhilerunningforward() {
  if(abs(self getmotionangle()) > anim.moveglobals.motion_angle_offset)
    return false;

  enemyyaw = self getpredictedyawtoenemy(0.2);

  if(abs(enemyyaw) <= anim.moveglobals.aim_yaw_threshold)
    return true;

  return false;
}

canshootwhilerunningforward120() {
  if(isDefined(self.pathstartpos) && distancesquared(self.pathstartpos, self.pathgoalpos) < anim.moveglobals.min_distsq_120)
    return false;

  if(isDefined(self.pathgoalpos) && distancesquared(self.origin, self.pathgoalpos) < anim.moveglobals.min_distsq_120)
    return false;

  return true;
}

canshootwhilerunningbackward() {
  if(180 - abs(self getmotionangle()) >= anim.moveglobals.motion_angle_offset)
    return false;

  enemyyaw = self getpredictedyawtoenemy(0.2);

  if(abs(enemyyaw) > anim.moveglobals.aim_yaw_threshold)
    return false;

  return true;
}

shouldshootwhilerunningbackward() {
  if(isDefined(self.cqb) && self.cqb && !(self animscripts\utility::weaponanims() == "pistol") && !self shouldtacticalwalk())
    return false;

  if(isDefined(self.a.disablebackwardrunngun) && self.a.disablebackwardrunngun)
    return false;

  if(isvalidenemy(self.enemy)) {
    toenemy = self.enemy.origin - self.origin;
    toenemyyaw = vectortoangles(toenemy)[1];
    togoalyaw = vectortoangles(self.lookaheaddir)[1];

    if(absangleclamp180(toenemyyaw - togoalyaw) >= anim.moveglobals.aim_yaw_threshold * 2) {
      closetogoal = 0;
      isalreadyrunningbackwards = abs(self getmotionangle()) >= anim.moveglobals.aim_yaw_threshold * 2;

      if(!isalreadyrunningbackwards) {
        if(!shouldtacticalwalk() && (isDefined(self.pathgoalpos) && distancesquared(self.origin, self.pathgoalpos) < 62500))
          closetogoal = 1;
      }

      if(self.lookaheaddist < 150 && !isalreadyrunningbackwards)
        return false;

      if(distancesquared(self.enemy.origin, self.origin) < getrunbackwardsdistancesquared() && !closetogoal)
        return true;
    }
  }

  return false;
}

getrunbackwardsdistancesquared() {
  if(shouldtacticalwalk()) {
    if(isDefined(self.cqb) && self.cqb && !(self animscripts\utility::weaponanims() == "pistol") || self aihasonlypistol())
      return anim.moveglobals.runbackwards_cqb_distsq;
    else
      return anim.moveglobals.runbackwards_distsq;
  }

  return 0;
}

shouldfacemotionwhilerunning() {
  if(self shouldfacemotion())
    return true;

  return false;
}

getlookaheadangle() {
  yawdiff = vectortoangles(self.lookaheaddir)[1] - self.angles[1];
  yawdiff = yawdiff * 0.00277778;
  yawdiff = (yawdiff - floor(yawdiff + 0.5)) * 360.0;
  return yawdiff;
}

donotetracksnoshootstandcombat(animname) {
  animscripts\shared::donotetracksfortime(anim.moveglobals.serverspf, animname);
}

getrunanimupdatefrequency() {
  return anim.moveglobals.serverspf;
}

getpredictedyawtoenemy(lookaheadtime) {
  assert(isvalidenemy(self.enemy));

  if(isDefined(self.predictedyawtoenemy) && isDefined(self.predictedyawtoenemytime) && self.predictedyawtoenemytime == gettime())
    return self.predictedyawtoenemy;

  selfpredictedpos = self.origin;
  moveangle = self.angles[1] + self getmotionangle();
  selfpredictedpos = selfpredictedpos + (cos(moveangle), sin(moveangle), 0) * 200.0 * lookaheadtime;
  yaw = self.angles[1] - vectortoangles(self.enemy.origin - selfpredictedpos)[1];
  yaw = angleclamp180(yaw);
  self.predictedyawtoenemy = yaw;
  self.predictedyawtoenemytime = gettime();
  return yaw;
}

getrunanim() {
  run_anim = undefined;

  if(isDefined(self.cqb) && self.cqb && !(self animscripts\utility::weaponanims() == "pistol") && self.a.pose == "stand") {
    if(self.movemode == "walk" || self.walk)
      run_anim = animarraypickrandom("cqb_walk_f", "move", 1);
    else if(self.sprint)
      run_anim = animarraypickrandom("cqb_sprint_f", "move", 1);
    else
      run_anim = animarraypickrandom("cqb_run_f", "move", 1);
  } else if(isDefined(self.a.combatrunanim))
    run_anim = self.a.combatrunanim;
  else if(self.sprint && self.a.pose == "stand") {
    if(isDefined(self.a.fullsprintanim))
      run_anim = self.a.fullsprintanim;
    else {
      run_anim = animarraypickrandom("sprint", "move");
      self.a.fullsprintanim = run_anim;
    }
  } else if(self.a.isaiming && self.a.pose == "stand")
    run_anim = animarray("run_n_gun_f", "move");
  else
    run_anim = animarray("combat_run_f", "move");

  assert(isDefined(run_anim), "run.gsc - No run animation for this AI.");
  return run_anim;
}

run_end_script() {
  self.a.fullsprintanim = undefined;
  stoptacticalwalk();
}

rundebuginfo() {
  if(getdvarint(#"ai_showPaths") > 1) {
    if(isDefined(self.enemy)) {
      dist = distance2d(self.origin, self.enemy.origin);
      recordenttext("DistanceToEnemy - " + dist, self, level.color_debug["white"], "Script");
      faceangle = vectortoangles(self.lookaheaddir)[1];
      toenemyyaw = vectortoangles(self.enemy.origin - self.origin)[1];
      anglediff = angleclamp180(toenemyyaw - faceangle);
      recordenttext("Enemy Yaw: " + anglediff + " Predicted enemy yaw: " + self getpredictedyawtoenemy(0.2) + " motion angle: " + abs(self getmotionangle()), self, level.color_debug["yellow"], "Animscript");

      if(self.facemotion)
        recordenttext("FaceMotion", self, level.color_debug["yellow"], "Animscript");
      else
        recordenttext("FaceEnemy", self, level.color_debug["yellow"], "Animscript");

      if(isDefined(self.relativedir)) {
        relativedir = "UNKNOWN_DIRECTION";

        switch (self.relativedir) {
          case 1:
            relativedir = "FRONT";
            break;
          case 2:
            relativedir = "RIGHT";
            break;
          case 3:
            relativedir = "LEFT";
            break;
          case 4:
            relativedir = "BACK";
            break;
          case 0:
          default:
            relativedir = "NONE";
            break;
        }

        recordenttext(relativedir, self, level.color_debug["red"], "Animscript");
      }
    } else
      recordenttext("motion angle: " + abs(self getmotionangle()), self, level.color_debug["yellow"], "Animscript");

    if(isDefined(self.shootstyle))
      recordenttext("ShootStyle - " + self.shootstyle, self, level.color_debug["red"], "Script");

    if(isDefined(self.weapon))
      recordenttext("Bullets - " + self.bulletsinclip, self, level.color_debug["white"], "Script");

    if(isDefined(self.pathgoalpos)) {
      dist = distance(self.pathstartpos, self.pathgoalpos);
      recordenttext("DistanceFromStartToGoal - " + dist, self, level.color_debug["white"], "Script");
      dist = distance(self.origin, self.pathgoalpos);
      recordenttext("DistanceToGoal - " + dist, self, level.color_debug["white"], "Script");
      dist = distance(self.origin, self.pathgoalpos);
      recordenttext("LookAheadDist - " + self.lookaheaddist, self, level.color_debug["white"], "Script");
    }
  }

}