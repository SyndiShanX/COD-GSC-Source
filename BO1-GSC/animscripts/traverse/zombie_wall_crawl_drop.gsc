/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\zombie_wall_crawl_drop.gsc
***********************************************************/

#include animscripts\traverse\zombie_shared;
#include maps\_utility;
#include animscripts\zombie_Utility;
#using_animtree("generic_human");
main() {
  zombie_wall_crawl();
}

debug_draw_orient() {}
zombie_wall_crawl() {
  self endon("killanimscript");
  self thread debug_draw_orient();
  if(isDefined(self.zombie_move_speed) && self.zombie_move_speed == "walk") {
    traverseAnim = % ai_zombie_quad_crawl_sprint_wall_intro;
  } else {
    traverseAnim = % ai_zombie_quad_crawl_sprint_wall_intro_2;
  }
  self.desired_anim_pose = "stand";
  animscripts\zombie_utility::UpdateAnimPose();
  self.vertical_fall = false;
  startnode = self getNegotiationStartNode();
  endNode = self getNegotiationEndNode();
  assert(isDefined(startnode));
  assert(isDefined(endNode));
  self OrientMode("face angle", startnode.angles[1]);
  self thread wait_on_vertical_death();
  self.traverseStartNode = startnode;
  self traverseMode("nogravity");
  self traverseMode("noclip");
  self.traverseStartZ = self.origin[2];
  if(!animHasNotetrack(traverseAnim, "traverse_align")) {
    self handleTraverseAlignment();
  }
  self ZombieTraverseStartRagdollDeath();
  self.traverseAnim = traverseAnim;
  self setFlaggedAnimKnoballRestart("traverseAnim", traverseAnim, %body, 1, .2, 1);
  self.traverseDeathIndex = 0;
  self animscripts\zombie_shared::DoNoteTracks("traverseAnim", ::handleTraverseNotetracks);
  self.vertical_fall = true;
  fallAnim = % ai_zombie_quad_crawl_sprint_wall;
  fallBlend = 0.05;
  animDist = abs(GetMoveDelta(fallAnim, 0, 1)[2]);
  physDist = abs(self.origin[2] - groundpos(self.origin)[2] - 55);
  cycles = physDist / animDist;
  time = (cycles * GetAnimLength(fallAnim));
  self setFlaggedAnimKnobRestart("traverseAnim", fallAnim, 1, 0.00, 1.0);
  self.traverseDeathIndex = 0;
  self thread animscripts\zombie_shared::DoNoteTracks("traverseAnim", ::handleTraverseNotetracks);
  wait(time);
  self setFlaggedAnimKnobRestart("dismountAnim", %ai_zombie_quad_wall_jump_off, 1, 0.00, 1.0);
  self thread animscripts\zombie_shared::DoNoteTracks("dismountAnim", ::handleTraverseNotetracks);
  wait(GetAnimLength(%ai_zombie_quad_wall_jump_off));
  self ZombieTraverseStopRagdollDeath();
  if(!isAlive(self)) {
    return;
  }
  self.a.nodeath = false;
  self traverseMode("gravity");
  self.a.movement = "run";
  self.a.pose = "crouch";
  self.a.alertness = "alert";
  self setAnimKnobAllRestart(animscripts\zombie_run::GetCrouchRunAnim(), %body, 1, 0.1, 1);
  self.can_explode = true;
  self notify("quad_end_traverse_anim");
}

ZombieTraverseStartRagdollDeath() {
  self.prevDelayedDeath = self.delayedDeath;
  self.prevAllowDeath = self.allowDeath;
  self.prevDeathFunction = self.deathFunction;
  self.delayedDeath = false;
  self.allowDeath = true;
  self.deathFunction = animscripts\traverse\zombie_wall_crawl_drop::ZombieRagdollSimple;
}

ZombieTraverseStopRagdollDeath() {
  if(!isDefined(self) || !isAlive(self)) {
    return;
  }
  self.delayedDeath = self.prevDelayedDeath;
  self.allowDeath = self.prevAllowDeath;
  self.deathFunction = self.prevDeathFunction;
  self.prevDelayedDeath = undefined;
  self.prevAllowDeath = undefined;
  self.prevDeathFunction = undefined;
}

ZombieRagdollSimple() {
  self animscripts\traverse\zombie_shared::TraverseRagdollDeathSimple();
  level maps\_zombiemode_spawner::zombie_death_points(self.origin, self.damagemod, self.damagelocation, self.attacker, self);
}

play_blended_death(vertAnim, horzAnim) {
  level maps\_zombiemode_spawner::zombie_death_points(self.origin, self.damagemod, self.damagelocation, self.attacker, self);
  pitch = self GetTagAngles("tag_sync")[0];
  vertWeight = sin(pitch);
  if(vertWeight < 0) {
    vertWeight = 0;
  }
  if(vertWeight > 1) {
    vertWeight = 1;
  }
  horzWeight = 1 - vertWeight;
  self setAnimLimited(vertAnim, vertWeight, 0);
  self setAnimLimited(horzAnim, horzWeight, 0);
  self setFlaggedAnimKnob("falling_death", %wall_death, 1);
  self animscripts\zombie_shared::DoNotetracks("falling_death");
}

wait_on_vertical_death() {
  self endon("death");
  self endon("traverse_death");
  self waittill("zombie_vertical");
  self.vertical_fall = true;
}