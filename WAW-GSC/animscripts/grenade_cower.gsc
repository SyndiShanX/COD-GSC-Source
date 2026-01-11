/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\grenade_cower.gsc
*****************************************************/

#include animscripts\Utility;
#using_animtree("generic_human");

main() {
  self trackScriptState("GrenadeCower Main", "code");
  self endon("killanimscript");
  animscripts\utility::initialize("grenadecower");
  if(self.a.pose == "prone") {
    animscripts\stop::main();
    return;
  }
  self AnimMode("zonly_physics");
  self OrientMode("face angle", self.angles[1]);
  grenadeAngle = 0;
  assert(isDefined(self.grenade));
  if(isDefined(self.grenade)) {
    grenadeAngle = AngleClamp180(vectorToAngles(self.grenade.origin - self.origin)[1] - self.angles[1]);
  }
  if(self.a.pose == "stand") {
    if(TryDive(grenadeAngle)) {
      return;
    }
    if(!isDefined(self.exposedSet) || self.exposedSet == 0) {
      self setFlaggedAnimKnobAllRestart("cowerstart", % exposed_squat_down_grenade_F, % body, 1, 0.2);
    } else {
      self setFlaggedAnimKnobAllRestart("cowerstart", % exposed2_squat_down_grenade_F, % body, 1, 0.2);
    }
    self animscripts\shared::DoNoteTracks("cowerstart");
  }
  self.a.pose = "crouch";
  self.a.movement = "stop";
  if(!isDefined(self.exposedSet) || self.exposedSet == 0) {
    self setFlaggedAnimKnobAllRestart("cower", % exposed_squat_idle_grenade_F, % body, 1, 0.2);
  } else {
    self setFlaggedAnimKnobAllRestart("cower", % exposed2_squat_idle_grenade_F, % body, 1, 0.2);
  }
  self animscripts\shared::DoNoteTracks("cower");
  self waittill("never");
}

TryDive(grenadeAngle) {
  diveAnim = undefined;
  if(abs(grenadeAngle) > 90) {
    if(!isDefined(self.exposedSet) || self.exposedSet == 0) {
      diveAnim = % exposed_dive_grenade_B;
    } else {
      diveAnim = % exposed2_dive_grenade_B;
    }
  } else {
    if(!isDefined(self.exposedSet) || self.exposedSet == 0) {
      diveAnim = % exposed_dive_grenade_F;
    } else {
      diveAnim = % exposed2_dive_grenade_F;
    }
  }
  moveBy = getMoveDelta(diveAnim, 0, 0.5);
  diveToPos = self localToWorldCoords(moveBy);
  if(!self MayMoveToPoint(diveToPos)) {
    return false;
  }
  self setFlaggedAnimKnobAllRestart("cowerstart", diveAnim, % body, 1, 0.2);
  self animscripts\shared::DoNoteTracks("cowerstart");
  return true;
}