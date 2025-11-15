/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\dog_pain.gsc
**************************************/

#include animscripts\shared;
#using_animtree("dog");

main() {
  self endon("killanimscript");

  if(isDefined(self.enemy) && isDefined(self.enemy.syncedmeleetarget) && self.enemy.syncedmeleetarget == self) {
    self unlink();
    self.enemy.syncedmeleetarget = undefined;
  }

  self clearanim( % root, 0.2);
  self setflaggedanimrestart("dog_pain_anim", % german_shepherd_run_pain, 1, 0.2, 1);
  self animscripts\shared::donotetracks("dog_pain_anim");
}