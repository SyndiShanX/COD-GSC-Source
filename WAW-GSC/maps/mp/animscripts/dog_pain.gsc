/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\animscripts\dog_pain.gsc
********************************************/

/using_animtree ("dog");#include maps\mp\animscripts\utility;

main() {
  debug_anim_print("dog_pain::main() ");

  self endon("killanimscript");
  self SetAimAnimWeights(0, 0);

  if(isDefined(self.enemy) && isDefined(self.enemy.syncedMeleeTarget) && self.enemy.syncedMeleeTarget == self) {
    self unlink();
    self.enemy.syncedMeleeTarget = undefined;
  }

  speed = length(self getvelocity());

  pain_anim = getAnimDirection(self.damageyaw);

  if(speed > level.dogRunPainSpeed) {
    pain_anim = "pain_run_" + pain_anim;
  } else {
    pain_anim = "pain_" + pain_anim;
  }

  self setanimstate(pain_anim);

  self maps\mp\animscripts\shared::DoNoteTracksForTime(0.2, "done");
}