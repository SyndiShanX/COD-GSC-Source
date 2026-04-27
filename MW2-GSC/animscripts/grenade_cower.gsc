/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: animscripts\grenade_cower.gsc
********************************************************/

#include animscripts\Utility;
#using_animtree("generic_human");

main() {
  self endon("killanimscript");
  animscripts\utility::initialize("grenadecower");

  if(isDefined(self.grenadeCowerFunction)) {
    self[[self.grenadeCowerFunction]]();
    return;
  }

  if(self.a.pose == "prone") {
    animscripts\stop::main();
    return;
  }

  self AnimMode("zonly_physics");
  self OrientMode("face angle", self.angles[1]);

  grenadeAngle = 0;

  if(isDefined(self.grenade))
    grenadeAngle = AngleClamp180(vectorToAngles(self.grenade.origin - self.origin)[1] - self.angles[1]);
  else
    grenadeAngle = self.angles[1];

  if(self.a.pose == "stand") {
    if(isDefined(self.grenade) && TryDive(grenadeAngle)) {
      return;
    }
    self setFlaggedAnimKnobAllRestart("cowerstart", %exposed_squat_down_grenade_F, %body, 1, 0.2);
    self animscripts\shared::DoNoteTracks("cowerstart");
  }
  self.a.pose = "crouch";
  self.a.movement = "stop";

  self setFlaggedAnimKnobAllRestart("cower", %exposed_squat_idle_grenade_F, %body, 1, 0.2);
  self animscripts\shared::DoNoteTracks("cower");

  self waittill("never");
}

end_script() {
  self.safeToChangeScript = true;
}

TryDive(grenadeAngle) {
  if(randomint(2) == 0)
    return false;

  if(self.stairsState != "none")
    return false;

  diveAnim = undefined;
  if(abs(grenadeAngle) > 90) {
    diveAnim = % exposed_dive_grenade_B;
  } else {
    diveAnim = % exposed_dive_grenade_F;
  }

  moveBy = getMoveDelta(diveAnim, 0, 0.5);
  diveToPos = self localToWorldCoords(moveBy);

  if(!self MayMoveToPoint(diveToPos))
    return false;

  self.safeToChangeScript = false;

  self setFlaggedAnimKnobAllRestart("cowerstart", diveAnim, %body, 1, 0.2);
  self animscripts\shared::DoNoteTracks("cowerstart");

  self.safeToChangeScript = true;

  return true;
}