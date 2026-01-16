/****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\dog\dog_pain.gsc
****************************************/

#using_animtree("dog");

main() {
  self endon("killanimscript");

  if(isdefined(self.enemy) && isdefined(self.enemy.syncedmeleetarget) && self.enemy.syncedmeleetarget == self) {
    self unlink();
    self.enemy.syncedmeleetarget = undefined;
  }

  self clearanim( % root, 0.2);
  self setflaggedanimrestart("dog_pain_anim", % german_shepherd_run_pain, 1, 0.2, 1);
  animscripts\shared::donotetracks("dog_pain_anim");
}