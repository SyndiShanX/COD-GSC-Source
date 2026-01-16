/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_minefields.gsc
**************************************/

#include maps\_utility;

main() {
  minefields = getentarray("minefield", "targetname");

  if(minefields.size > 0)
    level._effect["mine_explosion"] = loadfx("explosions/fx_grenadeExp_dirt");

  for(i = 0; i < minefields.size; i++)
    minefields[i] thread minefield_think();
}

minefield_think() {
  while(true) {
    self waittill("trigger", other);

    if(issentient(other))
      other thread minefield_kill(self);
  }
}

minefield_kill(trigger) {
  if(isDefined(self.minefield)) {
    return;
  }
  self.minefield = 1;
  self playsound("minefield_click");
  wait 0.5;
  wait(randomfloat(0.2));

  if(!isDefined(self)) {
    return;
  }
  if(self istouching(trigger)) {
    if(isplayer(self)) {
      level notify("mine death");
      self playsound("explo_mine");
    } else
      level thread maps\_utility::play_sound_in_space("explo_mine", self.origin);

    origin = self getorigin();
    playfx(level._effect["mine_explosion"], origin);
    playsoundatposition("mortar_dirt", origin);
    self enablehealthshield(0);
    radiusdamage(origin, 300, 2000, 50);
    self enablehealthshield(1);
  }

  self.minefield = undefined;
}