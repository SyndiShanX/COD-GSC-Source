/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\window_down.gsc
************************************************/

#include animscripts\traverse\shared;
#include maps\_utility;
#using_animtree("generic_human");

main() {
  traverseAnim = % windowclimb_fall;
  landAnim = % windowclimb_land;
  normalHeight = 35;

  self.desired_anim_pose = "crouch";
  animscripts\utility::UpdateAnimPose();

  self.old_anim_movement = self.a.movement;
  self.old_anim_alertness = self.a.alertness;

  self endon("killanimscript");
  self traverseMode("noclip");

  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  self OrientMode("face angle", startnode.angles[1]);
  realHeight = startnode.traverse_height - startnode.origin[2];

  self setFlaggedAnimKnoballRestart("traverse", traverseAnim, %body, 1, 0.15, 1);
  thread animscripts\shared::DoNoteTracksForever("traverse", "stop_traverse_notetracks");

  wait 1.5;
  angles = (0, startnode.angles[1], 0);
  forward = anglesToForward(angles);
  forward = vector_multiply(forward, 85);
  trace = bulletTrace(startnode.origin + forward, startnode.origin + forward + (0, 0, -500), false, undefined);
  endheight = trace["position"][2];

  finaldif = startnode.origin[2] - endheight;
  heightChange = 0;
  for(i = 0; i < level.window_down_height.size; i++) {
    if(finaldif < level.window_down_height[i]) {
      continue;
    }
    heightChange = finaldif - level.window_down_height[i];
  }
  assertEx(heightChange > 0, "window_jump at " + startnode.origin + " is too high off the ground");
  self thread teleportThread(heightChange * -1);

  oldheight = self.origin[2];
  change = 0;
  level.traverseFall = [];
  for(;;) {
    change = oldheight - self.origin[2];
    if(self.origin[2] - change < endheight) {
      break;
    }
    oldheight = self.origin[2];
    wait(0.05);
  }
  if(isDefined(self.groundtype)) {
    self playSound("Land_" + self.groundtype);
  }

  self notify("stop_traverse_notetracks");
  self setFlaggedAnimKnoballRestart("traverse", landAnim, %body, 1, 0.15, 1);
  self traverseMode("gravity");
  self animscripts\shared::DoNoteTracks("traverse");

  self.a.movement = self.old_anim_movement;
  self.a.alertness = self.old_anim_alertness;
  self setAnimKnobAllRestart(animscripts\run::GetRunAnim(), %body, 1, 0.2, 1);
  thread animscripts\run::MakeRunSounds("killSoundThread");
}

printer(org) {
  level notify("print_this_" + org);
  level endon("print_this_" + org);
  for(;;) {
    print3d(org, ".", (1, 1, 1), 5);
    wait(0.05);
  }
}

showline(start, end) {
  for(;;) {
    line(start, end + (-1, -1, -1), (1, 0, 0));
    wait(0.05);
  }
}

printerdebugger(msg, org) {
  level notify("prrint_this_" + org);
  level endon("prrint_this_" + org);
  for(;;) {
    print3d(org, msg, (1, 1, 1), 5);
    wait(0.05);
  }
}