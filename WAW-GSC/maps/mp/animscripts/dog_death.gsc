/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\animscripts\dog_death.gsc
*****************************************************/

#include maps\mp\animscripts\utility;

main() {
  debug_anim_print("dog_death::main()");
  self SetAimAnimWeights(0, 0);
  self endon("killanimscript");
  if(isDefined(self.a.nodeath)) {
    assertex(self.a.nodeath, "Nodeath needs to be set to true or undefined.");
    wait 3;
    return;
  }
  self unlink();
  if(isDefined(self.enemy) && isDefined(self.enemy.syncedMeleeTarget) && self.enemy.syncedMeleeTarget == self) {
    self.enemy.syncedMeleeTarget = undefined;
  }
  death_anim = "death_" + getAnimDirection(self.damageyaw);
  println(death_anim);
  self animMode("gravity");
  debug_anim_print("dog_death::main() - Setting " + death_anim);
  self setanimstate(death_anim);
  self maps\mp\animscripts\shared::DoNoteTracks("done");
}