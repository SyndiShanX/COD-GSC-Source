/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\alien\_alien_idle.gsc
************************************************/

#include maps\mp\agents\_scriptedAgents;
#include common_scripts\utility;

MIN_IDLE_REPEAT_TIMES = 2;
MAX_POSTURE_REPEAT_TIMES = 2;
IDLE_POSTURE_VOICE = "alien_voice";

main() {
  self endon("killanimscript");

  self init_alien_idle();

  while(true) {
    if(isDefined(self.attractor_flare)) {
      play_attractor_idle();
    } else if(isDefined(self.enemy_downed) && self.enemy_downed) {
      play_enemy_downed_idle();

      if(level.gameEnded)
        self.enemy_downed = false;
    } else {
      play_idle();
    }
  }
}

init_alien_idle() {
  self.idle_anim_counter = 0;
  self.consecutive_posture_counter = 0;
  if(isDefined(self.xyanimscale))
    self ScrAgentSetAnimScale(self.xyanimscale, 1.0);

  if(isDefined(self.idle_state_locked) && self.idle_state_locked)
    self.stateLocked = true;
}

end_script() {
  self.previousAnimState = "idle";
  if(isDefined(self.idle_state_locked) && self.idle_state_locked) {
    self.stateLocked = false;
    self.idle_state_locked = false;
  }
}

play_enemy_downed_idle() {
  self faceTarget();
  self ScrAgentSetOrientMode("face angle abs", self.angles);
  self maps\mp\agents\_scriptedagents::PlayAnimUntilNotetrack("posture", "posture", "end");
}

play_attractor_idle() {
  facingAngles = VectorToAngles(self.attractor_flare.origin - self.origin);
  facingAngles = (self.angles[0], facingAngles[1], self.angles[2]);
  self ScrAgentSetAnimMode("anim deltas");
  self ScrAgentSetOrientMode("face angle abs", facingAngles);
  attactorIndex = GetRandomAnimEntry("idle_flare");
  self maps\mp\agents\_scriptedagents::PlayAnimNUntilNotetrack("idle_flare", attactorIndex, "idle_flare", "end");
}

play_idle() {
  self faceTarget();
  idleState = selectIdleAnimState();
  self ScrAgentSetAnimMode("anim deltas");
  self ScrAgentSetOrientMode("face angle abs", self.angles);
  self PlayAnimNUntilNotetrack(idleState, undefined, idleState, "end");
}

selectIdleAnimState() {
  if(isDefined(level.dlc_idle_anim_state_override_func)) {
    animState = self[[level.dlc_idle_anim_state_override_func]](self.enemy);
    if(isDefined(animState))
      return animState;
  }

  if(isAlive(self.enemy)) {
    if(cointoss() && self.consecutive_posture_counter < MAX_POSTURE_REPEAT_TIMES) {
      self.consecutive_posture_counter++;
      return "idle_posture";
    }
  }

  self.consecutive_posture_counter = 0;

  if(self.idle_anim_counter < MIN_IDLE_REPEAT_TIMES + RandomIntRange(0, 1)) {
    resultState = "idle_default";
    self.idle_anim_counter += 1;
  } else {
    resultState = "idle";
    self.idle_anim_counter = 0;
  }

  return resultState;
}

faceTarget() {
  faceTarget = undefined;
  if(IsAlive(self.enemy) && DistanceSquared(self.enemy.origin, self.origin) < 1600 * 1600)
    faceTarget = self.enemy;
  else if(isDefined(self.owner))
    faceTarget = self.owner;

  if(isDefined(faceTarget)) {
    self maps\mp\agents\alien\_alien_anim_utils::turnTowardsEntity(faceTarget);
  }
}

onDamage(eInflictor, eAttacker, iThatDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset) {
  if(isDefined(level.dlc_can_do_pain_override_func)) {
    painAllowed = [[level.dlc_can_do_pain_override_func]]("idle");
    if(!painAllowed)
      return;
  }

  if(maps\mp\alien\_utility::is_pain_available(eAttacker, sMeansOfDeath))
    self DoPain(iDFlags, vDir, sHitLoc, iThatDamage, sMeansOfDeath);
}

DoPain(iDFlags, damageDirection, hitLocation, iDamage, sMeansOfDeath) {
  self endon("killanimscript");

  is_stun = (iDFlags &level.iDFLAGS_STUN);

  if(sMeansOfDeath == "MOD_MELEE" || is_stun) {
    animState = "pain_pushback";
    animIndex = maps\mp\agents\alien\_alien_anim_utils::getPainAnimIndex("push_back", damageDirection);
    pain_notify = "pain_pushback";
  } else {
    baseAnimState = getBasePainAnimState();
    animState = self maps\mp\agents\alien\_alien_anim_utils::getPainAnimState(baseAnimState, iDamage, is_stun);
    animIndex = maps\mp\agents\alien\_alien_anim_utils::getPainAnimIndex("idle", damageDirection, hitLocation);
    pain_notify = "idle_pain";
  }

  anime = self GetAnimEntry(animState, animIndex);
  self maps\mp\alien\_utility::always_play_pain_sound(anime);
  self maps\mp\alien\_utility::register_pain(anime);
  self.stateLocked = true;

  if(isDefined(self.oriented) && self.oriented) {
    self ScrAgentSetAnimMode("code_move");
  } else {
    self ScrAgentSetAnimMode("anim deltas");
    self ScrAgentSetOrientMode("face angle abs", self.angles);
  }

  self PlayAnimNUntilNotetrack(animState, animIndex, pain_notify);

  if(!isDefined(self.idle_state_locked) || !self.idle_state_locked)
    self.stateLocked = false;

  self SetAnimState("idle");
}

getBasePainAnimState() {
  if(isDefined(level.dlc_alien_pain_anim_state_override_func)) {
    animState = [[level.dlc_alien_pain_anim_state_override_func]]("idle");
    if(isDefined(animState))
      return animState;
  }

  return "idle_pain";
}