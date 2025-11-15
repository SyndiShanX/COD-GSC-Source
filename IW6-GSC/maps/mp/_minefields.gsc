/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_minefields.gsc
*****************************************************/

minefields() {
  minefields = getEntArray("minefield", "targetname");
  if(minefields.size > 0) {
    level._effect["mine_explosion"] = loadfx("vfx/gameplay/explosions/weap/gre/vfx_exp_gre_dirt_cg");
  }

  for(i = 0; i < minefields.size; i++) {
    minefields[i] thread minefield_think();
  }
}

minefield_think() {
  while(1) {
    self waittill("trigger", other);

    if(isPlayer(other))
      other thread minefield_kill(self);
  }
}

minefield_kill(trigger) {
  if(isDefined(self.minefield)) {
    return;
  }
  self.minefield = true;

  wait(.5);
  wait(randomFloat(.5));

  if(isDefined(self) && self istouching(trigger)) {
    origin = self getorigin();
    range = 300;
    maxdamage = 2000;
    mindamage = 50;

    radiusDamage(origin, range, maxdamage, mindamage);
  }

  self.minefield = undefined;
}