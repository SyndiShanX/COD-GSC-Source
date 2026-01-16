/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\dog_death.gsc
**************************************/

#include animscripts\shared;
#using_animtree("dog");

main() {
  self endon("killanimscript");

  if(isDefined(self.a.nodeath)) {
    assert(self.a.nodeath, "Nodeath needs to be set to true or undefined.");
    wait 3;
    return;
  }

  self unlink();

  if(isDefined(self.enemy) && isDefined(self.enemy.syncedmeleetarget) && self.enemy.syncedmeleetarget == self)
    self.enemy.syncedmeleetarget = undefined;

  self clearanim( % root, 0.2);
  self setflaggedanimrestart("dog_anim", % german_shepherd_death_front, 1, 0.2, 1);
  self animscripts\shared::donotetracks("dog_anim");
}