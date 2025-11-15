/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\zombie_dog_death.gsc
********************************************/

#using_animtree("zombie_dog");
main() {
  self endon("killanimscript");
  if(isDefined(self.a.nodeath)) {
    assertex(self.a.nodeath, "Nodeath needs to be set to true or undefined.");
    wait 3;
    return;
  }
  self Unlink();
  if(isDefined(self.enemy) && isDefined(self.enemy.syncedMeleeTarget) && self.enemy.syncedMeleeTarget == self) {
    self.enemy.syncedMeleeTarget = undefined;
  }
  if(isDefined(self.tesla_death) && self.tesla_death == true) {
    death_anims = [];
    death_anims[death_anims.size] = % zombie_dog_tesla_death_a;
    death_anims[death_anims.size] = % zombie_dog_tesla_death_b;
    death_anims[death_anims.size] = % zombie_dog_tesla_death_c;
    death_anims[death_anims.size] = % zombie_dog_tesla_death_d;
    death_anims[death_anims.size] = % zombie_dog_tesla_death_e;
    self animMode("gravity");
    self clearanim( % root, 0.2);
    self setflaggedanimrestart("dog_anim", death_anims[randomInt(death_anims.size)], 1, 0.2, 1);
    self animscripts\zombie_shared::DoNoteTracks("dog_anim");
  } else {
    death_direction = animscripts\zombie_dog_pain::getAnimDirection(self.damageyaw);
    self animMode("gravity");
    self clearanim( % root, 0.2);
    self setflaggedanimrestart("dog_anim", anim.dogAnims[self.animSet].death[death_direction], 1, 0.2, 1);
    self animscripts\zombie_shared::DoNoteTracks("dog_anim");
  }
}