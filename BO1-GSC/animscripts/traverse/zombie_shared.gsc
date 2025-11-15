/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\zombie_shared.gsc
**************************************************/

#include common_scripts\utility;
#using_animtree("generic_human");
init_traverse() {
  point = getEnt(self.target, "targetname");
  if(isDefined(point)) {
    self.traverse_height = point.origin[2];
    point Delete();
  } else {
    point = getstruct(self.target, "targetname");
    if(isDefined(point)) {
      self.traverse_height = point.origin[2];
    }
  }
}

teleportThread(verticalOffset) {
  self endon("killanimscript");
  self notify("endTeleportThread");
  self endon("endTeleportThread");
  reps = 5;
  offset = (0, 0, verticalOffset / reps);
  for(i = 0; i < reps; i++) {
    self Teleport(self.origin + offset);
    wait .05;
  }
}

teleportThreadEx(verticalOffset, delay, frames) {
  self endon("killanimscript");
  self notify("endTeleportThread");
  self endon("endTeleportThread");
  if(verticalOffset == 0)
    return;
  wait delay;
  amount = verticalOffset / frames;
  if(amount > 10.0)
    amount = 10.0;
  else if(amount < -10.0)
    amount = -10.0;
  offset = (0, 0, amount);
  for(i = 0; i < frames; i++) {
    self Teleport(self.origin + offset);
    wait .05;
  }
}

PrepareForTraverse() {
  self.a.pose = "stand";
}

DoTraverse(traverseData) {
  self endon("killanimscript");
  self.traverseAnimIsSequence = (
    isDefined(traverseData["traverseAnimType"]) &&
    (traverseData["traverseAnimType"] == "sequence")
  );
  self.traverseAnim = traverseData["traverseAnim"];
  self.traverseAnimTransIn = traverseData["traverseAnimTransIn"];
  self.traverseAnimTransOut = traverseData["traverseAnimTransOut"];
  self.traverseSound = traverseData["traverseSound"];
  self.traverseAlertness = traverseData["traverseAlertness"];
  self.traverseStance = traverseData["traverseStance"];
  self.traverseHeight = traverseData["traverseHeight"];
  self.traverseMovement = traverseData["traverseMovement"];
  self.traverseToCoverAnim = traverseData["traverseToCoverAnim"];
  self.traverseToCoverSound = traverseData["traverseToCoverSound"];
  self.traverseDeathAnim = traverseData["interruptDeathAnim"];
  self.traverseDeathIndex = 0;
  self traverseMode("nogravity");
  self traverseMode("noclip");
  if(!isDefined(self.traverseStance)) {
    self.desired_anim_pose = "stand";
  } else {
    self.desired_anim_pose = self.traverseStance;
  }
  animscripts\zombie_utility::UpdateAnimPose();
  self.traverseStartNode = self GetNegotiationStartNode();
  self.traverseEndNode = self GetNegotiationEndNode();
  assert(isDefined(self.traverseStartNode));
  assert(isDefined(self.traverseEndNode));
  self OrientMode("face angle", self.traverseStartNode.angles[1]);
  self.traverseStartZ = self.origin[2];
  toCover = false;
  if(isDefined(self.traverseToCoverAnim) && isDefined(self.node) && self.node.type == traverseData["coverType"] && distanceSquared(self.node.origin, self.traverseEndNode.origin) < 25 * 25) {
    if(AbsAngleClamp180(self.node.angles[1] - self.traverseEndNode.angles[1]) > 160) {
      toCover = true;
      self.traverseAnim = self.traverseToCoverAnim;
    }
  }
  if(IsArray(self.traverseAnim) && !self.traverseAnimIsSequence) {
    self.traverseAnim = random(self.traverseAnim);
  }
  self DoTraverse_Animation();
  self traverseMode("gravity");
  if(self.delayedDeath) {
    return;
  }
  self.a.nodeath = false;
  if(toCover && isDefined(self.node) && distanceSquared(self.origin, self.node.origin) < 16 * 16) {
    self.a.movement = "stop";
    self Teleport(self.node.origin);
  } else {
    if(isDefined(self.traverseAlertness)) {
      self.a.alertness = self.traverseAlertness;
    }
    if(isDefined(self.traverseMovement)) {
      self.a.movement = self.traverseMovement;
    }
    self SetAnimKnobAllRestart(animscripts\zombie_run::GetRunAnim(), % body, 1, 0.2, 1);
    wait(.2);
  }
}

DoTraverse_Animation() {
  traverseAnim = self.traverseAnim;
  if(!IsArray(traverseAnim)) {
    traverseAnim = add_to_array(undefined, traverseAnim);
  }
  self ClearAnim( % body, 0.2);
  played_trans_in = false;
  if(isDefined(self.traverseAnimTransIn)) {
    played_trans_in = true;
    self SetFlaggedAnimKnobRestart("traverseAnim", self.traverseAnimTransIn, 1, 0.2, 1);
    if(traverseAnim.size || isDefined(self.traverseAnimTransOut)) {
      self animscripts\zombie_shared::DoNoteTracks("traverseAnim", ::handleTraverseNotetracks);
    } else {
      self thread animscripts\zombie_shared::DoNoteTracks("traverseAnim", ::handleTraverseNotetracks);
      wait_anim_length(self.traverseAnimTransIn, .2);
    }
  }
  blend = .2;
  for(i = 0; i < traverseAnim.size; i++) {
    if(played_trans_in || i > 0) {
      blend = 0;
    }
    DoMainTraverse_Animation(traverseAnim[i], blend);
  }
  if(isDefined(self.traverseAnimTransOut)) {
    self SetFlaggedAnimKnobRestart("traverseAnim", self.traverseAnimTransOut, 1, 0, 1);
    self thread animscripts\zombie_shared::DoNoteTracks("traverseAnim", ::handleTraverseNotetracks);
    wait_anim_length(self.traverseAnimTransOut, .2);
  }
}

DoMainTraverse_Animation(animation, blend) {
  self SetFlaggedAnimKnobRestart("traverseAnim", animation, 1, blend, 1);
  self thread TraverseRagdollDeath(animation);
  self animscripts\zombie_shared::DoNoteTracks("traverseAnim", ::handleTraverseNotetracks);
}

wait_anim_length(animation, blend) {
  len = GetAnimLength(animation) - blend;
  if(len > 0) {
    wait len;
  }
}

handleTraverseNotetracks(note) {
  if(note == "traverse_death") {
    return handleTraverseDeathNotetrack();
  }
}

handleTraverseDeathNotetrack() {
  self endon("killanimscript");
  if(self.delayedDeath) {
    self.a.noDeath = true;
    self.exception["move"] = ::doNothingFunc;
    self traverseDeath();
    return true;
  }
  self.traverseDeathIndex++;
}

handleTraverseAlignment() {
  self traverseMode("nogravity");
  self traverseMode("noclip");
  if(isDefined(self.traverseHeight) && isDefined(self.traverseStartNode.traverse_height)) {
    currentHeight = self.traverseStartNode.traverse_height - self.traverseStartZ;
    self thread teleportThread(currentHeight - self.traverseHeight);
  }
}

doNothingFunc() {
  self AnimMode("zonly_physics");
  self waittill("killanimscript");
}

traverseDeath() {
  self notify("traverse_death");
  if(!isDefined(self.triedTraverseRagdoll))
    self animscripts\zombie_death::PlayDeathSound();
  deathAnimArray = self.traverseDeathAnim[self.traverseDeathIndex];
  deathAnim = deathAnimArray[randomInt(deathAnimArray.size)];
  animscripts\zombie_death::play_death_anim(deathAnim);
  self DoDamage(self.health + 5, self.origin);
}

TraverseStartRagdollDeath() {
  self.prevDelayedDeath = self.delayedDeath;
  self.prevAllowDeath = self.allowDeath;
  self.prevDeathFunction = self.deathFunction;
  self.delayedDeath = false;
  self.allowDeath = true;
  self.deathFunction = ::TraverseRagdollDeathSimple;
}

TraverseStopRagdollDeath() {
  self.delayedDeath = self.prevDelayedDeath;
  self.allowDeath = self.prevAllowDeath;
  self.deathFunction = self.prevDeathFunction;
  self.prevDelayedDeath = undefined;
  self.prevAllowDeath = undefined;
  self.prevDeathFunction = undefined;
}

TraverseRagdollDeathSimple() {
  self animscripts\zombie_death::PlayDeathSound();
  self startRagdoll();
  deathAnim = animscripts\zombie_death::get_death_anim();
  self SetFlaggedAnimKnobAllRestart("deathanim", deathAnim, % body, 1, .1);
  if(AnimHasNotetrack(deathAnim, "death_neckgrab_spurt")) {
    playFXOnTag(level._effects["death_neckgrab_spurt"], self, "j_neck");
  }
  wait 0.5;
  return true;
}

TraverseRagdollDeath(traverseAnim) {
  self notify("TraverseRagdollDeath");
  self endon("TraverseRagdollDeath");
  self endon("traverse_death");
  self endon("killanimscript");
  while(1) {
    self waittill("damage");
    if(!self.delayedDeath) {
      continue;
    }
    scriptedDeathTimes = GetNotetrackTimes(traverseAnim, "traverse_death");
    currentTime = self GetAnimTime(traverseAnim);
    scriptedDeathTimes[scriptedDeathTimes.size] = 1.0;
    for(i = 0; i < scriptedDeathTimes.size; i++) {
      if(scriptedDeathTimes[i] > currentTime) {
        animLength = GetAnimLength(traverseAnim);
        timeUntilScriptedDeath = (scriptedDeathTimes[i] - currentTime) * animLength;
        if(timeUntilScriptedDeath < 0.5) {
          return;
        }
        break;
      }
    }
    self.deathFunction = ::postTraverseDeathAnim;
    self.exception["move"] = ::doNothingFunc;
    self animscripts\zombie_death::PlayDeathSound();
    behindMe = self.origin + (0, 0, 30) - anglesToForward(self.angles) * 20;
    self startRagdoll();
    thread physExplosionForRagdoll(behindMe);
    self.a.triedTraverseRagdoll = true;
    break;
  }
}

physExplosionForRagdoll(pos) {
  wait .1;
  physicsExplosionSphere(pos, 55, 35, 1);
}

postTraverseDeathAnim() {
  self endon("killanimscript");
  if(!isDefined(self))
    return;
  deathAnim = animscripts\zombie_death::get_death_anim();
  self SetFlaggedAnimKnobAllRestart("deathanim", deathAnim, % body, 1, .1);
  if(animHasNoteTrack(deathAnim, "death_neckgrab_spurt")) {
    playFXOnTag(level._effects["death_neckgrab_spurt"], self, "j_neck");
  }
}

#using_animtree("dog");
dog_wall_and_window_hop(traverseName, height) {
  self endon("killanimscript");
  self traverseMode("nogravity");
  self traverseMode("noclip");
  startnode = self GetNegotiationStartNode();
  assert(isDefined(startnode));
  self OrientMode("face angle", startnode.angles[1]);
  if(isDefined(startnode.traverse_height)) {
    realHeight = startnode.traverse_height - startnode.origin[2];
    self thread teleportThread(realHeight - height);
  }
  self ClearAnim( % root, 0.2);
  self SetFlaggedAnimRestart("dog_traverse", anim.dogAnims["zombie"].traverse[traverseName], 1, 0.2, 1);
  self animscripts\zombie_shared::DoNoteTracks("dog_traverse");
  self.traverseComplete = true;
}

dog_jump_down(height, frames) {
  self endon("killanimscript");
  self traverseMode("noclip");
  startnode = self GetNegotiationStartNode();
  assert(isDefined(startnode));
  self OrientMode("face angle", startnode.angles[1]);
  self thread teleportThreadEx(40.0 - height, 0.1, frames);
  self ClearAnim( % root, 0.2);
  self SetFlaggedAnimRestart("traverse", anim.dogAnims["zombie"].traverse["jump_down_40"], 1, 0.2, 1);
  self animscripts\zombie_shared::DoNoteTracks("traverse");
  self ClearAnim(anim.dogAnims["zombie"].traverse["jump_down_40"], 0);
  self traverseMode("gravity");
  self.traverseComplete = true;
}

dog_jump_up(height, frames) {
  self endon("killanimscript");
  self traverseMode("noclip");
  startnode = self GetNegotiationStartNode();
  assert(isDefined(startnode));
  self OrientMode("face angle", startnode.angles[1]);
  self thread teleportThreadEx(height - 40.0, 0.2, frames);
  self ClearAnim( % root, 0.25);
  self SetFlaggedAnimRestart("traverse", anim.dogAnims["zombie"].traverse["jump_up_40"], 1, 0.2, 1);
  self animscripts\zombie_shared::DoNoteTracks("traverse");
  self ClearAnim(anim.dogAnims["zombie"].traverse["jump_up_40"], 0);
  self traverseMode("gravity");
  self.traverseComplete = true;
}