/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\stop.gsc
**************************************/

#include animscripts\combat_utility;
#include animscripts\utility;
#include animscripts\setposemovement;
#include animscripts\anims;
#include animscripts\debug;
#include animscripts\face;
#include animscripts\shared;
#include animscripts\cover_prone;
#using_animtree("generic_human");

main() {
  self notify("stopScript");
  self endon("killanimscript");

  if(getdebugdvar("anim_preview") != "") {
    return;
  }
  self thread animscripts\utility::idlelookatbehavior(160, 1);
  [[self.exception["stop_immediate"]]]();
  thread delayedexception();
  self trackscriptstate("Stop Main", "code");
  animscripts\utility::initialize("stop");
  self flamethrower_stop_shoot();
  self randomizeidleset();
  self thread setlaststoppedtime();
  self thread stancechangewatcher();
  transitionedtoidle = gettime() < 3000;

  if(!transitionedtoidle) {
    if(self.a.weaponpos["right"] == "none" && self.a.weaponpos["left"] == "none")
      transitionedtoidle = 1;
    else if(self.weapon == "none")
      transitionedtoidle = 1;
    else if(angleclamp180(self gettagangles("tag_weapon")[0]) > 20)
      transitionedtoidle = 1;
  }

  for(;;) {
    desiredpose = getdesiredidlepose();

    if(self.a.pose != desiredpose) {
      self clearanim( % root, 0.3);
      transitionedtoidle = 0;
    }

    self setposemovement(desiredpose, "stop");

    if(self.a.pose != "prone" && !transitionedtoidle) {
      self thread transitiontoidle();
      transitionedtoidle = 1;
      self waittill("endIdle");
      continue;
    }

    self thread playidle(desiredpose, self.a.idleset);
    self waittill("endIdle");
  }
}

stancechangewatcher() {
  self endon("death");
  self endon("killanimscript");

  while(true) {
    desiredpose = getdesiredidlepose();

    if(desiredpose != self.a.pose) {
      self animscripts\debug::debugpopstate("playIdle");

      self notify("endIdle");
    }

    wait 0.1;
  }
}

setlaststoppedtime() {
  self endon("death");
  self waittill("killanimscript");
  self.laststoppedtime = gettime();
}

getdesiredidlepose() {
  mynode = animscripts\utility::getclaimednode();

  if(isDefined(mynode)) {
    mynodeangle = mynode.angles[1];
    mynodetype = mynode.type;
  } else {
    mynodeangle = self.desiredangle;
    mynodetype = "node was undefined";
  }

  self animscripts\face::setidleface(anim.alertface);
  desiredpose = animscripts\utility::choosepose();

  if(mynodetype == "Cover Stand" || mynodetype == "Conceal Stand")
    desiredpose = animscripts\utility::choosepose("stand");
  else if(mynodetype == "Cover Crouch" || mynodetype == "Conceal Crouch")
    desiredpose = animscripts\utility::choosepose("crouch");
  else if(mynodetype == "Cover Prone" || mynodetype == "Conceal Prone")
    desiredpose = animscripts\utility::choosepose("prone");

  return desiredpose;
}

transitiontoidle() {
  self endon("endIdle");
  self endon("killanimscript");

  self animscripts\debug::debugpushstate("transitionToIdle");

  waittillframeend;
  special = "";

  if(isDefined(self.cqb) && self.cqb && !(self animscripts\utility::weaponanims() == "pistol") && self.a.pose == "stand")
    special = "_cqb";
  else if(self is_heavy_machine_gun() && self.a.pose == "stand")
    special = "_hmg";

  if(animarrayexist("idle_trans_in" + special)) {
    if(!weaponisgasweapon(self.weapon)) {
      idleanim = animarray("idle_trans_in" + special);
      self setflaggedanimknoballrestart("idle_transition", idleanim, % body, 1, 0.3, self.animplaybackrate);
      self animscripts\shared::donotetracks("idle_transition");
    }
  }

  self animscripts\debug::debugpopstate("transitionToIdle");

  self notify("endIdle");
}

playidle(pose, idleset) {
  self endon("endIdle");
  self endon("killanimscript");

  self animscripts\debug::debugpushstate("playIdle");

  waittillframeend;

  if(pose == "prone") {
    self pronestill();

    self animscripts\debug::debugpopstate("playIdle");

    self notify("endIdle");
    return;
  }

  special = "";

  if(isDefined(self.cqb) && self.cqb && !(self animscripts\utility::weaponanims() == "pistol") && self.a.pose == "stand")
    special = "_cqb";
  else if(self is_heavy_machine_gun())
    special = "_hmg";

  idleanimsetarray = animarray("idle" + special);
  assert(idleanimsetarray.size > 0);
  idleset = idleset % idleanimsetarray.size;
  idleanimarray = idleanimsetarray[idleset];
  assert(idleanimarray.size > 0);
  idleanim = idleanimarray[randomintrange(0, idleanimarray.size)];
  transtime = 0.2;

  if(gettime() == self.a.scriptstarttime)
    transtime = 0.5;

  self orientmode("face angle", self.angles[1]);
  self setflaggedanimknoballrestart("idle", idleanim, % body, 1, transtime, self.animplaybackrate);
  self animscripts\shared::donotetracks("idle");

  self animscripts\debug::debugpopstate("playIdle");

  self notify("endIdle");
}

pronestill() {
  self animscripts\debug::debugpushstate("ProneStill");

  if(self.a.pose != "prone") {
    transanim = animarray(self.a.pose + "_2_prone");
    assert(isDefined(transanim), self.a.pose);
    assert(animhasnotetrack(transanim, "anim_pose = \"prone\""));
    self setflaggedanimknoballrestart("trans", transanim, % body, 1, 0.2, 1.0);
    animscripts\shared::donotetracks("trans");
    assert(self.a.pose == "prone");
    self.a.movement = "stop";
    self setproneanimnodes(-45, 45, % prone_legs_down, % exposed_aiming, % prone_legs_up);

    self animscripts\debug::debugpopstate("ProneStill");

    return;
  }

  if(0) {
    twitchanim = animarraypickrandom("twitch");
    self setflaggedanimknoball("prone_idle", twitchanim, % prone_modern, 1, 0.2);
  } else {
    self setanim(animarray("straight_level"), 1, 0.2);
    self setflaggedanimknob("prone_idle", animarraypickrandom("idle")[0], 1, 0.2);
  }

  wait 0.05;
  self thread updatepronethread();
  self waittillmatch("prone_idle", "end");
  self notify("kill UpdateProneThread");

  self animscripts\debug::debugpopstate("ProneStill");
}

updatepronethread() {
  self endon("killanimscript");
  self endon("kill UpdateProneThread");
  self endon("endIdle");

  for(;;) {
    self animscripts\cover_prone::updatepronewrapper(0.1);
    wait 0.1;
  }
}

delayedexception() {
  self endon("killanimscript");
  wait 0.05;
  [[self.exception["stop"]]]();
}