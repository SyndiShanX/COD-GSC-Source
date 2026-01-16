/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\cover_corner.gsc
****************************************/

#include animscripts\anims;
#include animscripts\combat_utility;
#include animscripts\cover_utility;
#include animscripts\utility;
#include common_scripts\utility;
#include maps\_utility;
#include animscripts\shared;
#include animscripts\cover_behavior;
#include animscripts\debug;
#include animscripts\shoot_behavior;
#include maps\_gameskill;
#include animscripts\weaponlist;
#include animscripts\combat;

corner_think(direction, nodeangleoffset) {
  self endon("killanimscript");
  self.covernode = self.node;
  assert(isDefined(self.covernode));
  self.waschangingcoverpos = 0;
  setcornerdirection(direction);
  self.covernode.desiredcornerdirection = direction;
  self.a.cornermode = "unknown";
  self.a.standidlethread = undefined;
  animscripts\cover_utility::turntomatchnodedirection(nodeangleoffset);

  if(self.a.pose != "stand" && self.a.pose != "crouch") {
    assert(self.a.pose == "prone");
    self exitpronewrapper(1);
    self.a.pose = "crouch";
  }

  self.isshooting = 0;
  self.tracking = 0;
  self.corneraiming = 0;
  animscripts\shared::setanimaimweight(0);
  self.havegonetocover = 0;
  behaviorcallbacks = spawnstruct();
  behaviorcallbacks.mainloopstart = ::mainloopstart;
  behaviorcallbacks.reload = ::cornerreload;
  behaviorcallbacks.leavecoverandshoot = ::stepoutandshootenemy;
  behaviorcallbacks.look = ::lookforenemy;
  behaviorcallbacks.fastlook = ::fastlook;
  behaviorcallbacks.idle = ::idle;
  behaviorcallbacks.flinch = ::flinch;
  behaviorcallbacks.grenade = ::trythrowinggrenade;
  behaviorcallbacks.grenadehidden = ::trythrowinggrenadestayhidden;
  behaviorcallbacks.blindfire = animscripts\cover_utility::blindfire;
  behaviorcallbacks.resetweaponanims = ::resetweaponanims;
  behaviorcallbacks.switchsides = ::switchsides;
  behaviorcallbacks.rambo = ::rambo;
  animscripts\cover_behavior::main(behaviorcallbacks);
}

end_script_corner() {
  self.blockingpain = 0;
}

mainloopstart() {
  desiredstance = "stand";

  if(self.a.pose == "crouch") {
    desiredstance = "crouch";

    if(self.covernode doesnodeallowstance("stand")) {
      if(!self.covernode doesnodeallowstance("crouch") || shouldchangestanceforfun())
        desiredstance = "stand";
    }
  } else if(self.covernode doesnodeallowstance("crouch")) {
    if(!self.covernode doesnodeallowstance("stand") || shouldchangestanceforfun())
      desiredstance = "crouch";
  }

  if(shouldforcebehavior("force_stand") && doesnodeallowstance("stand"))
    desiredstance = "stand";
  else if(shouldforcebehavior("force_crouch") && doesnodeallowstance("crouch"))
    desiredstance = "crouch";

  if(self.havegonetocover)
    self transitiontostance(desiredstance);
  else {
    if(self.a.pose == desiredstance)
      gotocover(animarray("alert_idle"), 0.4, 0.4);
    else {
      stancechangeanim = animarray("stance_change");
      gotocover(stancechangeanim, 0.4, getanimlength(stancechangeanim));
    }

    assert(self.a.pose == desiredstance);
    self.havegonetocover = 1;
  }
}

shouldchangestanceforfun() {
  if(!isDefined(self.enemy))
    return false;

  if(!isDefined(self.changestanceforfuntime))
    self.changestanceforfuntime = gettime() + randomintrange(5000, 20000);

  if(gettime() > self.changestanceforfuntime) {
    self.changestanceforfuntime = gettime() + randomintrange(5000, 20000);

    if(isDefined(self.rambochance) && self.a.pose == "stand")
      return false;

    self.a.prevattack = undefined;
    return true;
  }

  return false;
}

shootposoutsidelegalyawrange() {
  if(!isDefined(self.shootpos))
    return false;

  yaw = self.covernode getyawtoorigin(self.shootpos);

  if(self.a.cornermode == "over" || self.a.cornermode == "blind_over")
    return yaw < self.leftaimlimit || self.rightaimlimit < yaw;

  if(!isDefined(self.cornerdirection))
    return yaw < self.leftaimlimit || self.rightaimlimit < yaw;

  if(self.a.atpillarnode)
    cornerleftdirection = self.cornerdirection == "right";
  else
    cornerleftdirection = self.cornerdirection == "left";

  if(cornerleftdirection) {
    if(self.a.cornermode == "B")
      return yaw < 0 - self.abanglecutoff || yaw > 14;
    else if(self.a.cornermode == "A")
      return yaw > 0 - self.abanglecutoff;
    else if(self.a.cornermode == "blindfire")
      return yaw < 0;
    else {
      assert(self.a.cornermode == "lean");
      return yaw < anim.coverglobals.corner_left_lean_yaw_max || yaw > 8;
    }
  } else {
    assert(!cornerleftdirection);

    if(self.a.cornermode == "B")
      return yaw > self.abanglecutoff || yaw < -12;
    else if(self.a.cornermode == "A")
      return yaw < self.abanglecutoff;
    else if(self.a.cornermode == "blindfire")
      return yaw > 0;
    else {
      assert(self.a.cornermode == "lean");
      return yaw > anim.coverglobals.corner_right_lean_yaw_max || yaw < -8;
    }
  }
}

getcornermode(node, point) {
  nostepout = 0;
  yaw = 0;

  if(isDefined(point))
    yaw = node getyawtoorigin(point);

  forcecornermode = shouldforcebehavior("force_corner_mode");

  if(forcecornermode == "lean" || forcecornermode == "A" || forcecornermode == "B")
    return forcecornermode;

  if(forcecornermode == "over") {
    stancesupported = self.a.pose == "crouch" && !self.a.atpillarnode;

    if(isDefined(node) && stancesupported && (yaw > self.leftaimlimit && self.rightaimlimit > yaw)) {
      modes = node getvalidcoverpeekouts();

      if(isinarray(modes, forcecornermode))
        return forcecornermode;
    }
  }

  modes = [];
  stancesupported = self.a.pose == "crouch";

  if(isDefined(node) && stancesupported && (yaw > self.leftaimlimit && self.rightaimlimit > yaw))
    modes = node getvalidcoverpeekouts();

  if(self.a.atpillarnode)
    modes = array_exclude(modes, array("over"));

  if(self.a.atpillarnode)
    cornerleftdirection = self.cornerdirection == "right";
  else
    cornerleftdirection = self.cornerdirection == "left";

  if(cornerleftdirection) {
    if(canlean(yaw, anim.coverglobals.corner_left_lean_yaw_max, 0)) {
      nostepout = shouldlean();
      modes[modes.size] = "lean";
    }

    if(!nostepout && yaw < anim.coverglobals.corner_left_ab_yaw && !usingpistol()) {
      if(yaw < 0 - self.abanglecutoff)
        modes[modes.size] = "A";
      else
        modes[modes.size] = "B";
    }
  } else {
    assert(!cornerleftdirection);

    if(canlean(yaw, 0, anim.coverglobals.corner_right_lean_yaw_max)) {
      nostepout = shouldlean();
      modes[modes.size] = "lean";
    }

    if(!nostepout && yaw > anim.coverglobals.corner_right_ab_yaw && !usingpistol()) {
      if(yaw > self.abanglecutoff)
        modes[modes.size] = "A";
      else
        modes[modes.size] = "B";
    }
  }

  if(self.iswounded || isDefined(self.disablecoverab) && self.disablecoverab) {
    modes = array_exclude(modes, array("over"));
    modes = array_exclude(modes, array("A"));
    modes = array_exclude(modes, array("B"));
  }

  return getrandomcovermode(modes);
}

getbeststepoutpos() {
  yaw = 0;

  if(cansuppressenemy())
    yaw = self.covernode getyawtoorigin(getenemysightpos());
  else if(self.doingambush && isDefined(self.shootpos))
    yaw = self.covernode getyawtoorigin(self.shootpos);

  dvarval = getdvar(#"_id_C84E4F62");

  if(dvarval == "lean" || dvarval == "a" || dvarval == "b")
    return dvarval;

  if(self.a.cornermode == "lean")
    return "lean";
  else if(self.a.cornermode == "over")
    return "over";
  else if(self.a.cornermode == "B") {
    if(self.cornerdirection == "left") {
      if(yaw < 0 - self.abanglecutoff)
        return "A";
    } else if(self.cornerdirection == "right") {
      if(yaw > self.abanglecutoff)
        return "A";
    }

    return "B";
  } else if(self.a.cornermode == "A") {
    positiontoswitchto = "B";

    if(self.cornerdirection == "left") {
      if(yaw > 0 - self.abanglecutoff)
        return "B";
    } else if(self.cornerdirection == "right") {
      if(yaw < self.abanglecutoff)
        return "B";
    }

    return "A";
  }
}

changestepoutpos() {
  self endon("killanimscript");
  positiontoswitchto = getbeststepoutpos();

  if(positiontoswitchto == self.a.cornermode)
    return false;

  assert(self.a.cornermode != "lean" && positiontoswitchto != "lean");
  assert(self.a.cornermode != "over" && positiontoswitchto != "over");
  self.changingcoverpos = 1;
  self notify("done_changing_cover_pos");
  animname = self.a.cornermode + "_to_" + positiontoswitchto;
  assert(animarrayanyexist(animname));
  switchanim = animarraypickrandom(animname);
  midpoint = getpredictedpathmidpoint();

  if(!self maymovetopoint(midpoint))
    return false;

  if(!self maymovefrompointtopoint(midpoint, getanimendpos(switchanim)))
    return false;

  self endstandidlethread();
  hasstopaim = animhasnotetrack(switchanim, "stop_aim");

  if(!hasstopaim) {
    if(getdvarint(#"_id_B142FD65") == 1)
      println("^2StopStartAim Debug - ", switchanim + " in corner_" + self.cornerdirection + " " + self.a.pose + " didn't have \"stop_aim\" notetrack");

    self stopaiming(0.3);
    resetanimspecial(0.3);
  }

  if(self.team == "allies")
    self.blockingpain = 1;

  prev_anim_pose = self.a.pose;
  self setanimlimited(animarray("straight_level"), 0, 0.2);
  self setflaggedanimknob("changeStepOutPos", switchanim, 1, 0.2, 1);
  self thread donotetrackswithendon("changeStepOutPos");

  if(hasstopaim) {
    self waittillmatch("changeStepOutPos", "stop_aim");
    self stopaiming(0.1);
    resetanimspecial(0.1);
  }

  hasstartaim = animhasnotetrack(switchanim, "start_aim");

  if(hasstartaim)
    self waittillmatch("changeStepOutPos", "start_aim");
  else {
    if(getdvarint(#"_id_B142FD65") == 1)
      println("^2StopStartAim Debug - ", switchanim + " in corner_" + self.cornerdirection + " " + self.a.pose + " didn't have \"start_aim\" notetrack");

    self waittillmatch("changeStepOutPos", "end");
  }

  self startaiming(undefined, 0, 0.1);

  if(hasstartaim)
    self waittillmatch("changeStepOutPos", "end");

  self clearanim(switchanim, 0.1);
  self.a.cornermode = positiontoswitchto;
  setstepoutanimspecial(positiontoswitchto);

  if(self.team == "allies")
    self.blockingpain = 0;

  self.changingcoverpos = 0;
  self.coverposestablishedtime = gettime();
  assert(self.a.pose == "stand" || self.a.pose == "crouch");
  self changeaiming(undefined, 1, 0.3);
  return true;
}

canlean(yaw, yawmin, yawmax) {
  if(self.a.neverlean)
    return false;

  return yawmin <= yaw && yaw <= yawmax;
}

shouldlean() {
  if(self usingpistol())
    return true;

  if(isDefined(self.a.favor_lean) && self.a.favor_lean)
    return true;

  if(isDefined(self.coversafetopopout) && !self.coversafetopopout)
    return true;

  if(self ispartiallysuppressedwrapper())
    return true;

  return false;
}

donotetrackswithendon(animname) {
  self endon("killanimscript");
  self animscripts\shared::donotetracks(animname);
}

startaiming(spot, fullbody, transtime) {
  assert(!self.corneraiming);
  self.corneraiming = 1;
  self setaimingparams(spot, fullbody, transtime, 1);
}

changeaiming(spot, fullbody, transtime) {
  assert(self.corneraiming);
  self setaimingparams(spot, fullbody, transtime, 0);
}

#using_animtree("generic_human");

stopaiming(transtime) {
  assert(self.corneraiming);
  self.corneraiming = 0;
  self clearanim( % add_fire, transtime);
  animscripts\shared::setanimaimweight(0, transtime);
}

setaimingparams(spot, fullbody, transtime, start) {
  assert(isDefined(fullbody));
  self.spot = spot;
  self setanimlimited( % exposed_modern, 1, transtime);
  self setanimlimited( % exposed_aiming, 1, transtime);
  animscripts\shared::setanimaimweight(1, 0);
  aimanimprefix = "";

  if(self.a.cornermode == "over" || self.a.cornermode == "lean") {
    if(!start)
      self setanimlimited(animarray(self.a.cornermode + "_aim_straight"), 1, transtime);

    aimanimprefix = self.a.cornermode;
  } else if(fullbody) {
    self setanimlimited(animarray("straight_level"), 1, transtime);
    aimanimprefix = "add";
  } else {
    self setanimlimited(animarray("straight_level"), 0, transtime);
    aimanimprefix = "add_turn";
  }

  playadditiveaiminganims(aimanimprefix, transtime, 45);
}

stepoutandhidespeed() {
  if(self.a.cornermode == "over")
    return 1;

  return randomfasteranimspeed();
}

stepout() {
  self animscripts\debug::debugpushstate("stepOut");

  self.a.cornermode = "alert";
  self animmode("zonly_physics");

  if(self.a.pose == "stand")
    self.abanglecutoff = 38;
  else {
    assert(self.a.pose == "crouch");
    self.abanglecutoff = 31;
  }

  thisnodepose = self.a.pose;
  newcornermode = "none";

  if(hasenemysightpos())
    newcornermode = getcornermode(self.covernode, getenemysightpos());
  else
    newcornermode = getcornermode(self.covernode);

  if(!isDefined(newcornermode)) {
    self animscripts\debug::debugpopstate("stepOut", "newCornerMode is undefined");

    return false;
  }

  if(newcornermode == "lean" && !self ispeekoutposclear()) {
    self animscripts\debug::debugpopstate("stepOut", "no room to lean out");

    return false;
  }

  self animscripts\anims::clearanimcache();
  animname = "alert_to_" + newcornermode;
  assert(animarrayanyexist(animname), "Animation " + animname + " not found");
  switchanim = animarraypickrandom(animname);

  if(newcornermode != "over" && !ispathclear(switchanim, newcornermode != "lean")) {
    self animscripts\debug::debugpopstate("stepOut", "no room to step out");

    return false;
  }

  resetanimspecial();
  self.a.cornermode = newcornermode;
  self.a.prevattack = newcornermode;
  self set_aiming_limits();

  if(self.a.cornermode == "lean") {
    if(self.cornerdirection == "left")
      self.rightaimlimit = 0;
    else
      self.leftaimlimit = 0;
  }

  self.keepclaimednode = 1;
  self.pushable = 0;
  self.changingcoverpos = 1;
  self notify("done_changing_cover_pos");

  if(self.team == "allies")
    self.blockingpain = 1;

  animrate = stepoutandhidespeed();
  self setflaggedanimknoballrestart("stepout", switchanim, % root, 1, 0.2, animrate);
  self thread donotetrackswithendon("stepout");
  hasstartaim = animhasnotetrack(switchanim, "start_aim");

  if(hasstartaim)
    self waittillmatch("stepout", "start_aim");
  else {
    if(getdvarint(#"_id_B142FD65") == 1)
      println("^2StopStartAim Debug - ", switchanim + " in corner_" + self.cornerdirection + " " + self.a.pose + " didn't have \"start_aim\" notetrack");

    self waittillmatch("stepout", "end");
  }

  fullbody = newcornermode == "over";
  setstepoutanimspecial(newcornermode);
  self startaiming(undefined, fullbody, 0.1);
  self thread animscripts\shared::trackshootentorpos();

  if(hasstartaim)
    self waittillmatch("stepout", "end");

  if(self.team == "allies")
    self.blockingpain = 0;

  self changeaiming(undefined, 1, 0.2);
  self clearanim( % cover, 0.2);
  self clearanim( % corner, 0.2);
  self.changingcoverpos = 0;
  self.coverposestablishedtime = gettime();
  self.pushable = 1;

  self animscripts\debug::debugpopstate("stepOut");

  return true;
}

stepoutandshootenemy() {
  self animscripts\debug::debugpushstate("stepOutAndShootEnemy");

  self.keepclaimednode = 1;

  if(!stepout()) {
    self animscripts\debug::debugpopstate(undefined, "no room to step out");

    self.keepclaimednode = 0;
    return false;
  }

  shootastold();

  if(isDefined(self.shootpos)) {
    if(animscripts\shared::shouldthrowdownweapon()) {
      animscripts\shared::throwdownweapon();
      resetweaponanims();
      self changeaiming(undefined, 1, 0.2);
      self animmode("zonly_physics");
      shootastold();
    }
  }

  returntocover();
  self.keepclaimednode = 0;

  self animscripts\debug::debugpopstate("stepOutAndShootEnemy");

  return true;
}

rambo() {
  self animscripts\debug::debugpushstate("rambo");

  if(!hasenemysightpos())
    return false;

  shouldrambo = isDefined(self.covernode.script_forcerambo) || isDefined(self.rambochance) && randomfloat(1) < self.rambochance;

  if(shouldrambo && canrambo()) {
    if(rambostepout()) {
      self animscripts\debug::debugpopstate("rambo");

      return true;
    }
  }

  self animscripts\debug::debugpopstate("rambo", "not allowed or can't step out");

  return false;
}

rambostepout() {
  animtype = "rambo";

  if(randomfloat(1) < 0.2 && animarrayanyexist("rambo_jam"))
    animtype = "rambo_jam";

  if(animtype != "rambo_jam") {
    yawtoenemy = self.covernode getyawtoorigin(getenemysightpos());

    if(self.cornerdirection == "left" && yawtoenemy < 0)
      yawtoenemy = yawtoenemy * -1;

    if(yawtoenemy > anim.ramboswitchangle && animarrayanyexist("rambo_45"))
      animtype = "rambo_45";
  }

  assert(animarrayanyexist(animtype));
  ramboanim = animarraypickrandom(animtype);

  if(!isrambopathclear(ramboanim))
    return false;

  resetanimspecial();
  self animmode("zonly_physics");
  self.keepclaimednode = 1;
  self.keepclaimednodeifvalid = 1;
  self.isramboing = 1;
  self setflaggedanimknoballrestart("rambo", ramboanim, % body, 1, 0);

  if(canuseblindaiming("rambo") && animtype != "rambo_jam") {
    self thread startblindaiming(ramboanim, "rambo");
    self thread stopblindaiming(ramboanim, "rambo");
  }

  if(isDefined(self.enemy))
    self animscripts\shoot_behavior::setshootent(self.enemy);

  self animscripts\shared::donotetracks("rambo");
  self.keepclaimednode = 0;
  self.keepclaimednodeifvalid = 0;
  self.isramboing = 0;
  self.a.prevattack = "rambo";
  waittillframeend;
  return true;
}

isrambopathclear(theanim) {
  rambooutnotetrackcheck = animhasnotetrack(theanim, "rambo_out");
  assert(rambooutnotetrackcheck);
  stepouttimearray = getnotetracktimes(theanim, "rambo_out");
  assert(stepouttimearray.size == 1);
  movedelta = getmovedelta(theanim, 0, stepouttimearray[0]);
  rambooutpos = self localtoworldcoords(movedelta);
  disttopos = distance2d(self.origin, rambooutpos);
  angles = self.covernode.angles;
  right = anglestoright(angles);

  switch (self.a.script) {
    case "cover_left":
      rambooutpos = self.origin + vectorscale(right, disttopos * -1);
      break;
    case "cover_right":
      rambooutpos = self.origin + vectorscale(right, disttopos);
      break;
    default:
      assert("Rambo behavior is not supported on cover node " + self.a.script);
  }

  if(rambooutnotetrackcheck)
    self thread debugrambooutposition(rambooutpos);

  return self maymovetopoint(rambooutpos);
}

debugrambooutposition(rambooutpos) {
  if(getdvar(#"_id_7927E91F") != "1") {
    return;
  }
  self endon("death");

  for(i = 0; i < 600; i++)
    recordline(self.origin, rambooutpos, (1, 1, 1), "Animscript", self);
}

shootastold() {
  self endon("need_to_switch_weapons");
  self maps\_gameskill::didsomethingotherthanshooting();

  while(true) {
    self animscripts\debug::debugpushstate("shootAsTold");

    while(true) {
      if(self.shouldreturntocover) {
        self animscripts\debug::debugpopstate("shootAsTold", "shouldReturnToCover");

        break;
      }

      if(animscripts\cover_behavior::shouldswitchsides(0)) {
        self animscripts\debug::debugpopstate("shootAsTold", "shouldSwitchSides");

        break;
      }

      if(!isDefined(self.shootpos)) {
        assert(!isDefined(self.shootent));
        self waittill("do_slow_things");
        waittillframeend;

        if(isDefined(self.shootpos)) {
          continue;
        }
        self animscripts\debug::debugpopstate("shootAsTold", "no shootPos");

        break;
      }

      if(!self.bulletsinclip) {
        self animscripts\debug::debugpopstate("shootAsTold", "no ammo");

        break;
      }

      if(shootposoutsidelegalyawrange()) {
        if(!changestepoutpos()) {
          if(getbeststepoutpos() == self.a.cornermode) {
            self animscripts\debug::debugpopstate("shootAsTold", "shootPos outside yaw range and no better step out pos");

            break;
          }

          shootuntilshootbehaviorchangefortime(0.2);
          self flamethrower_stop_shoot();
          continue;
        }

        if(shootposoutsidelegalyawrange()) {
          self animscripts\debug::debugpopstate("shootAsTold", "shootPos outside yaw range");

          break;
        }

        continue;
      }

      shootuntilshootbehaviorchange_corner(1);
      self flamethrower_stop_shoot();
      self clearanim( % add_fire, 0.2);
    }

    domidpointcheck = self.a.cornermode != "lean" && self.a.cornermode != "over";

    if(self canreturntocover(domidpointcheck)) {
      break;
    }

    if(shootposoutsidelegalyawrange() && changestepoutpos()) {
      continue;
    }
    shootuntilshootbehaviorchangefortime(0.2);
    self flamethrower_stop_shoot();
  }
}

shootuntilshootbehaviorchangefortime(time) {
  self thread notifystopshootingaftertime(time);
  starttime = gettime();
  shootuntilshootbehaviorchange_corner(0);
  self notify("stopNotifyStopShootingAfterTime");
  timepassed = (gettime() - starttime) / 1000;

  if(timepassed < time)
    wait(time - timepassed);
}

notifystopshootingaftertime(time) {
  self endon("killanimscript");
  self endon("stopNotifyStopShootingAfterTime");
  wait(time);
  self notify("stopShooting");
}

shootuntilshootbehaviorchange_corner(runanglerangethread) {
  self endon("return_to_cover");

  if(runanglerangethread)
    self thread anglerangethread();

  self thread standidlethread();
  shootuntilshootbehaviorchange();
}

standidlethread() {
  self endon("killanimscript");

  if(isDefined(self.a.standidlethread)) {
    return;
  }
  self.a.standidlethread = 1;
  self setanim( % add_idle, 1, 0.2);
  standidlethreadinternal();
  self clearanim( % add_idle, 0.2);
}

endstandidlethread() {
  self.a.standidlethread = undefined;
  self notify("end_stand_idle_thread");
}

standidlethreadinternal() {
  self endon("killanimscript");
  self endon("end_stand_idle_thread");
  animarrayarg = "exposed_idle";

  if(self.a.cornermode == "lean")
    animarrayarg = "lean_idle";
  else if(self.a.cornermode == "over" && animarrayanyexist("over_idle"))
    animarrayarg = "over_idle";

  assert(animarrayanyexist(animarrayarg));
  i = 0;

  for(;;) {
    flagname = "idle" + i;
    idleanim = animarraypickrandom(animarrayarg);
    self setflaggedanimknoblimitedrestart(flagname, idleanim, 1, 0.2);
    self waittillmatch(flagname, "end");
    i++;
  }
}

anglerangethread() {
  self endon("killanimscript");
  self notify("newAngleRangeCheck");
  self endon("newAngleRangeCheck");
  self endon("take_cover_at_corner");

  while(true) {
    if(shootposoutsidelegalyawrange()) {
      break;
    }

    wait 0.1;
  }

  self notify("stopShooting");
}

canreturntocover(domidpointcheck) {
  if(domidpointcheck) {
    midpoint = getpredictedpathmidpoint();

    if(!self maymovetopoint(midpoint))
      return 0;

    return self maymovefrompointtopoint(midpoint, self.covernode.origin);
  } else
    return self maymovetopoint(self.covernode.origin);
}

returntocover() {
  self animscripts\debug::debugpushstate("returnToCover");

  assert(self canreturntocover(self.a.cornermode != "lean" && self.a.cornermode != "over"));
  self endstandidlethread();
  suppressed = issuppressedwrapper();
  self notify("take_cover_at_corner");
  self.changingcoverpos = 1;
  self notify("done_changing_cover_pos");

  if(self.a.cornermode != "lean")
    self thread resetanimspecial(0.2);

  animname = self.a.cornermode + "_to_alert";
  assert(animarrayanyexist(animname));
  switchanim = animarraypickrandom(animname);
  self stopaiming(0.3);
  self clearanim( % add_fire, 0.2);
  reloading = 0;

  if(self.a.cornermode != "lean" && self.subclass == "regular" && animarrayanyexist(animname + "_reload") && randomfloat(100) < 75) {
    switchanim = animarraypickrandom(animname + "_reload");
    reloading = 1;
  }

  if(self.a.cornermode == "lean" || self.a.cornermode == "over")
    self clearanim(animarray(self.a.cornermode + "_aim_straight"), 0);
  else
    self clearanim(animarray("straight_level"), 0);

  if(self.team == "allies")
    self.blockingpain = 1;

  rate = stepoutandhidespeed();
  self setflaggedanimrestart("hide", switchanim, 1, 0.1, rate);
  self animscripts\shared::donotetracks("hide");

  if(reloading)
    self animscripts\weaponlist::refillclip();

  self notify("stop updating angles");
  self animscripts\shared::stoptracking();
  self.changingcoverpos = 0;
  setanimspecial();
  self.keepclaimednode = 0;
  self clearanim( % exposed_modern, 0.2);

  if(self.team == "allies")
    self.blockingpain = 0;

  self animscripts\debug::debugpopstate("returnToCover");
}

trythrowinggrenadestayhidden(throwat, forcethrow) {
  return trythrowinggrenade(throwat, 1, forcethrow);
}

trythrowinggrenade(throwat, safe, forcethrow) {
  forcethrow = isDefined(forcethrow) && forcethrow;

  if(!self maymovetopoint(self getpredictedpathmidpoint())) {
    self animscripts\debug::debugpopstate(undefined, "no room to throw");

    return 0;
  }

  theanim = undefined;

  if(animarrayexist("grenade_rambo") && isDefined(self.rambochance) && randomfloat(1) < self.rambochance)
    theanim = animarray("grenade_rambo");
  else if(isDefined(safe) && safe) {
    if(!animarrayexist("grenade_safe")) {
      self animscripts\debug::debugpopstate(undefined, "no safe throw anim");

      return 0;
    }

    theanim = animarray("grenade_safe");
  } else {
    if(!animarrayexist("grenade_exposed")) {
      self animscripts\debug::debugpopstate(undefined, "no exposed throw anim");

      return 0;
    }

    theanim = animarray("grenade_exposed");
  }

  self animmode("zonly_physics");
  self.keepclaimednodeifvalid = 1;
  threwgrenade = trygrenade(throwat, theanim, forcethrow);
  self.keepclaimednodeifvalid = 0;
  return threwgrenade;
}

printyawtoenemy() {
  println("yaw: ", self getyawtoenemy());
}

lookforenemy(looktime) {
  if(!animarrayexist("alert_to_look")) {
    self animscripts\debug::debugpopstate(undefined, "no look anim");

    return false;
  }

  if(usingpistol()) {
    self animscripts\debug::debugpopstate(undefined, "no pistol anims");

    return false;
  }

  self animmode("zonly_physics");
  self.keepclaimednodeifvalid = 1;

  if(!peekout())
    return false;

  animscripts\shared::playlookanimation(animarray("look_idle"), looktime, ::canstoppeeking);
  lookanim = undefined;

  if(self issuppressedwrapper())
    lookanim = animarray("look_to_alert_fast");
  else
    lookanim = animarray("look_to_alert");

  self setflaggedanimknoballrestart("looking_end", lookanim, % body, 1, 0.1, 1.0);
  animscripts\shared::donotetracks("looking_end");
  self animmode("zonly_physics");
  self.keepclaimednodeifvalid = 0;
  return true;
}

ispeekoutposclear() {
  assert(isDefined(self.covernode));
  eyepos = self geteye();
  rightdir = anglestoright(self.covernode.angles);

  if(self.a.atpillarnode)
    cornerleftdirection = self.cornerdirection == "right";
  else
    cornerleftdirection = self.cornerdirection == "left";

  if(cornerleftdirection)
    eyepos = eyepos - rightdir * anim.coverglobals.peekout_offset;
  else
    eyepos = eyepos + rightdir * anim.coverglobals.peekout_offset;

  lookatpos = eyepos + anglestoforward(self.covernode.angles) * anim.coverglobals.peekout_offset;
  return sighttracepassed(eyepos, lookatpos, 1, self);
}

peekout() {
  if(isDefined(self.covernode.script_dontpeek)) {
    self animscripts\debug::debugpopstate(undefined, "cover node has script_dontpeek on");

    return false;
  }

  if(isDefined(self.a.dontpeek)) {
    self animscripts\debug::debugpopstate(undefined, "self.a.dontpeek on");

    return false;
  }

  if(isDefined(self.nextpeekoutattempttime) && gettime() < self.nextpeekoutattempttime) {
    self animscripts\debug::debugpopstate(undefined, "nextPeekOutAttemptTime > GetTime()");

    return false;
  }

  peekanim = animarray("alert_to_look");

  if(!self maymovetopoint(getanimendpos(peekanim)) || self.looking_at_entity) {
    self animscripts\debug::debugpopstate(undefined, "no room to step out or looking at ent");

    self.nextpeekoutattempttime = gettime() + 3000;
    return false;
  }

  self setflaggedanimknoball("looking_start", peekanim, % body, 1, 0.2, 1);
  animscripts\shared::donotetracks("looking_start");
  return true;
}

canstoppeeking() {
  return self maymovetopoint(self.covernode.origin);
}

fastlook() {
  if(!animarrayanyexist("look")) {
    self animscripts\debug::debugpopstate(undefined, "no fastlook anim");

    return false;
  }

  peekanim = animarraypickrandom("look");

  if(!self maymovetopoint(getanimendpos(peekanim)) || self.looking_at_entity) {
    self animscripts\debug::debugpopstate(undefined, "no room to fastlook out");

    return false;
  }

  self setflaggedanimknoballrestart("look", peekanim, % body, 1, 0.1);
  self animscripts\shared::donotetracks("look");
  return true;
}

cornerreload() {
  if(weaponisgasweapon(self.weapon))
    return flamethrower_reload();

  assert(animarrayanyexist("reload"));
  reloadanim = animarraypickrandom("reload");
  self setflaggedanimknobrestart("cornerReload", reloadanim, 1, 0.2);
  self animscripts\shared::donotetracks("cornerReload");
  self animscripts\weaponlist::refillclip();
  self setanimrestart(animarray("alert_idle"), 1, 0.2);
  self clearanim(reloadanim, 0.2);
  return 1;
}

ispathclear(stepoutanim, domidpointcheck) {
  if(domidpointcheck) {
    midpoint = getpredictedpathmidpoint();

    if(0) {
      recordline(self.origin, midpoint, (0, 1, 0), "Animscript", self);
      recordline(midpoint, getanimendpos(stepoutanim), (1, 0, 0), "Animscript", self);
      endpos = getanimendpos(stepoutanim);
      movedelta = endpos - self.origin;
      recordenttext("Delta: " + movedelta[0] + ", " + movedelta[1] + ", " + movedelta[2], self, (0, 1, 0), "Animscript");
    }

    if(!self maymovetopoint(midpoint))
      return 0;

    return self maymovefrompointtopoint(midpoint, getanimendpos(stepoutanim));
  } else
    return self maymovetopoint(getanimendpos(stepoutanim));
}

getpredictedpathmidpoint() {
  assert(isDefined(self.covernode), "Covernode undefined, AI's current animscript is " + self.a.script);
  angles = self.covernode.angles;
  right = anglestoright(angles);

  switch (self.a.script) {
    case "cover_left":
      right = vectorscale(right, -36);
      break;
    case "cover_right":
      right = vectorscale(right, 36);
      break;
    case "cover_pillar":
      if(self.cornerdirection == "left")
        right = vectorscale(right, -36);
      else
        right = vectorscale(right, 36);

      break;
    default:
      assert(0, "What kind of node is this????");
  }

  return self.covernode.origin + (right[0], right[1], 0);
}

idle() {
  self endon("end_idle");

  while(true) {
    usetwitch = randomint(2) == 0 && animarrayanyexist("alert_idle_twitch");

    if(usetwitch && !self.looking_at_entity)
      idleanim = animarraypickrandom("alert_idle_twitch");
    else
      idleanim = animarray("alert_idle");

    playidleanimation(idleanim, usetwitch);
  }
}

flinch() {
  if(!animarrayanyexist("alert_idle_flinch")) {
    self animscripts\debug::debugpopstate(undefined, "no flinch anim");

    return false;
  }

  playidleanimation(animarraypickrandom("alert_idle_flinch"), 1);
  return true;
}

playidleanimation(idleanim, needsrestart) {
  if(needsrestart)
    self setflaggedanimknoballrestart("idle", idleanim, % body, 1, 0.2, 1);
  else
    self setflaggedanimknoball("idle", idleanim, % body, 1, 0.2, 1);

  self animscripts\shared::donotetracks("idle");
}

transitiontostance(stance) {
  if(self.a.pose == stance) {
    return;
  }
  self setflaggedanimknoballrestart("changeStance", animarray("stance_change"), % body);
  self animscripts\shared::donotetracks("changeStance");
  assert(self.a.pose == stance);
  wait 0.2;
}

gotocover(coveranim, transtime, playtime) {
  cornerangle = getnodedirection();
  cornerorigin = getnodeorigin();
  desiredyaw = cornerangle + self.hideyawoffset;
  self orientmode("face angle", angleclamp180(desiredyaw));
  self animmode("normal");
  assert(transtime <= playtime);
  setanimspecial();
  self thread animscripts\shared::movetooriginovertime(cornerorigin, transtime);
  self setflaggedanimknoballrestart("coveranim", coveranim, % body, 1, transtime);
  self animscripts\shared::donotetracksfortime(playtime, "coveranim");

  while(absangleclamp180(self.angles[1] - desiredyaw) > 1)
    self animscripts\shared::donotetracksfortime(0.1, "coveranim");

  self animmode("zonly_physics");
  setanimspecial();
}

drawoffset() {
  self endon("killanimscript");

  for(;;) {
    line(self.node.origin + vectorscale((0, 0, 1), 20.0), vectorscale((0, 0, 1), 20.0) + self.node.origin + vectorscale(anglestoright(self.node.angles + (0, 0, 0)), 16));
    wait 0.05;
  }

}

set_aiming_limits() {
  self.rightaimlimit = 45;
  self.leftaimlimit = -45;
  self.upaimlimit = 45;
  self.downaimlimit = -45;
}

runcombat() {
  self notify("killanimscript");
  waittillframeend;
  self thread animscripts\combat::main();
}

resetweaponanims() {
  assert(self.a.pose == "stand" || self.a.pose == "crouch");
  self clearanim( % aim_4, 0);
  self clearanim( % aim_6, 0);
  self clearanim( % aim_2, 0);
  self clearanim( % aim_8, 0);
  self clearanim( % exposed_aiming, 0);
}

setcornerdirection(direction) {
  self.cornerdirection = direction;

  if(self.a.script == "cover_pillar")
    self.a.script_suffix = "_" + direction;
}

switchsides() {
  if(!self.a.atpillarnode)
    return false;

  if(self.cornerdirection == "left" && !self.covernode has_spawnflag(1024))
    setcornerdirection("right");
  else if(!self.covernode has_spawnflag(2048))
    setcornerdirection("left");

  forcecornermode = shouldforcebehavior("force_corner_direction");

  if(forcecornermode == "left" || forcecornermode == "right")
    setcornerdirection(forcecornermode);

  self clearanim( % exposed_aiming, 0.2);
  self animscripts\anims::clearanimcache();
  self notify("dont_end_idle");
  wait 0.05;
  return true;
}

setstepoutanimspecial(newcornermode) {
  if(self.a.script == "cover_pillar") {
    if(isDefined(self.a.cornermode) && self.a.cornermode == "lean")
      self.a.special = "cover_pillar_lean";

    if(newcornermode == "A" || newcornermode == "B")
      self.a.special = "cover_pillar_" + self.cornerdirection + "_" + newcornermode;
  } else if(aihasonlypistol() && newcornermode != "lean" && newcornermode != "over")
    setanimspecial();
  else if(newcornermode == "lean") {
    if(self.a.atpillarnode && aihasonlypistol()) {
      if(self.cornerdirection == "left")
        self.a.special = "cover_right_" + newcornermode;
      else
        self.a.special = "cover_left_" + newcornermode;
    } else
      self.a.special = "cover_" + self.cornerdirection + "_" + newcornermode;
  } else if(!aihasonlypistol() && (newcornermode == "A" || newcornermode == "B" || newcornermode == "blindfire"))
    self.a.special = "cover_" + self.cornerdirection + "_" + newcornermode;
  else if(newcornermode == "over")
    self.a.special = "cover_" + self.cornerdirection + "_" + newcornermode;
  else
    self.a.special = "none";
}

setanimspecial() {
  if(self.a.atpillarnode && self.a.script == "cover_pillar")
    self.a.special = "cover_pillar";
  else if(self.a.atpillarnode && aihasonlypistol()) {
    if(self.cornerdirection == "left")
      self.a.special = "cover_right";
    else
      self.a.special = "cover_left";
  } else if(self.cornerdirection == "left")
    self.a.special = "cover_left";
  else
    self.a.special = "cover_right";
}