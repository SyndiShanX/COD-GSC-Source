/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\zombie_dog_pain.gsc
*******************************************/

#using_animtree("zombie_dog");
main() {
  self endon("killanimscript");
  if(self.a.disablePain) {
    return;
  }
  if(isDefined(self.enemy) && isDefined(self.enemy.syncedMeleeTarget) && self.enemy.syncedMeleeTarget == self) {
    self Unlink();
    self.enemy.syncedMeleeTarget = undefined;
  }
  speed = length(self getaivelocity());
  pain_set = "pain";
  pain_direction = getAnimDirection(self.damageyaw);
  if(speed > level.dogRunPainSpeed) {
    pain_set = "pain_run";
  }
  self ClearAnim( % root, 0.2);
  self SetFlaggedAnimRestart("dog_pain_anim", anim.dogAnims[self.animSet].pain[pain_set][pain_direction], 1, 0.2, 1);
  self animscripts\zombie_shared::DoNoteTracksForTime(0.2, "dog_pain_anim");
}

getAnimDirection(damageyaw) {
  if((damageyaw > 135) || (damageyaw <= -135)) {
    return 2;
  } else if((damageyaw > 45) && (damageyaw <= 135)) {
    return 6;
  } else if((damageyaw > -45) && (damageyaw <= 45)) {
    return 8;
  } else {
    return 4;
  }
  return "front";
}