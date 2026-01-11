/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\look.gsc
*****************************************************/

#include animscripts\Utility;
#include animscripts\Combat_Utility;
#include animscripts\SetPoseMovement;
#using_animtree("generic_human");

trackWithHead(spot) {
  self endon("killanimscript");
  self endon("movemode");
  self.rightAimLimit = 60.0;
  self.leftAimLimit = -60.0;
  self.upAimLimit = 20;
  self.downAimLimit = -20;
  self.headHorizontalWeight = 0;
  self.headVerticalWeight = 0;
  if(!isDefined(self.enemy) && !isDefined(spot)) {
    return;
  }
  for(;;) {
    if(isDefined(spot)) {
      yawDelta = getYawToSpot(spot);
      pitchDelta = getPitchToSpot(spot);
    } else {
      break;
    }
    angleFudge = asin(-3 / distance(self.origin, spot));
    yawDelta += angleFudge;
    if(yawDelta > 0 && yawDelta < self.rightAimLimit) {
      self setanim( % combatrun_head_4, 0, 0);
      self setanim( % combatrun_head_6, 1, 0);
      self.headHorizontalWeight = yawDelta / self.rightAimLimit;
    }
    if(yawDelta < 0 && yawDelta > self.leftAimLimit) {
      self setanim( % combatrun_head_6, 0, 0);
      self setanim( % combatrun_head_4, 1, 0);
      self.headHorizontalWeight = yawDelta / self.leftAimLimit;
    }
    if(pitchDelta > 0 && pitchDelta < self.upAimLimit) {
      self setanim( % combatrun_head_2, 0, 0);
      self setanim( % combatrun_head_8, 1, 0);
      self.headVerticalWeight = pitchDelta / self.upAimLimit;
    }
    if(pitchDelta < 0 && pitchDelta > self.downAimLimit) {
      self setanim( % combatrun_head_8, 0, 0);
      self setanim( % combatrun_head_2, 1, 0);
      self.headVerticalWeight = pitchDelta / self.downAimLimit;
    }
    wait(0.05);
  }
}

glance(spot, duration, ignoreLOS) {
  if(!isDefined(spot)) {
    return;
  }
  if(!isDefined(ignoreLOS)) {
    ignoreLOS = false;
  }
  if(!bullettracepassed(self getshootatpos(), spot, false, undefined) && (ignoreLOS == false)) {
    return;
  }
  self thread trackWithHead(spot);
  glanceTransitionTime = .3;
  self setanim( % head_horizontal, self.headHorizontalWeight, glanceTransitionTime);
  self setanim( % head_vertical, self.headVerticalWeight, glanceTransitionTime);
  wait(duration);
  self setanim( % head_horizontal, 0, glanceTransitionTime);
  self setanim( % head_vertical, 0, glanceTransitionTime);
  wait(glanceTransitionTime);
}

cleanHeadOnKill() {
  self endon("death");
  for(;;) {
    self waittill("killanimscript");
    self setanim( % head_horizontal, 0, .1);
    self setanim( % head_vertical, 0, .1);
  }
}

lookThread() {
  self endon("death");
}

chooseSomethingToLookAt() {
  if(isDefined(self.enemy)) {
    return self.enemy getshootatpos();
  }
}

TryToGlanceAtThePlayerNow() {
  return false;
}

finishLookAt() {
  return;
}