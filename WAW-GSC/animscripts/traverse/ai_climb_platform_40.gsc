/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: \animscripts\traverse\ai_climb_platform_40.gsc
**********************************************************/

#include animscripts\Utility;
#include animscripts\traverse\shared;
#using_animtree("generic_human");

main() {
  self.traverseDeath = 1;
  self advancedTraverse2( % ai_climb_platform_40, 40);
}

advancedTraverse2(traverseAnim, normalHeight) {
  self.desired_anim_pose = "crouch";
  animscripts\utility::UpdateAnimPose();
  self.old_anim_movement = self.a.movement;
  self.old_anim_alertness = self.a.alertness;
  self endon("killanimscript");
  self traverseMode("nogravity");
  self traverseMode("noclip");
  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  self OrientMode("face angle", startnode.angles[1]);
  self setFlaggedAnimKnoballRestart("traverse", traverseAnim, % body, 1, 0.2, 1.1);
  self animscripts\shared::DoNoteTracks("traverse");
  self setAnimRestart( % combatrun_forward_1, 1, 0.1);
  self.a.movement = self.old_anim_movement;
  self.a.alertness = self.old_anim_alertness;
}

handle_death(note) {
  println(note);
  if(note != "traverse_death") {
    return;
  }
  self endon("killanimscript");
  if(self.health == 1) {
    self.a.nodeath = true;
    if(self.traverseDeath > 1) {
      if(randomFloat(1) > 0.5) {
        self setFlaggedAnimKnobAll("deathanim", % traverse40_death_end_2, % body, 1, .2, 1);
      } else {
        self setFlaggedAnimKnobAll("deathanim", % traverse40_death_end, % body, 1, .2, 1);
      }
    } else {
      if(randomFloat(1) > 0.5) {
        self setFlaggedAnimKnobAll("deathanim", % traverse40_death_start_2, % body, 1, .2, 1);
      } else {
        self setFlaggedAnimKnobAll("deathanim", % traverse40_death_start, % body, 1, .2, 1);
      }
    }
    self animscripts\face::SayGenericDialogue("death");
  }
  self.traverseDeath++;
}