/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\minefields.gsc
***********************************************/

minefields() {
  minefields = getEntArray("minefield", "targetname");

  if(minefields.size > 0)
    level._effect["mine_explosion"] = loadfx("vfx/core/expl/weap/gre/vfx_exp_gre_dirt_cg");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < minefields.size; _id_AC0E594AC96AA3A8++)
    minefields[_id_AC0E594AC96AA3A8] thread minefield_think();
}

minefield_think() {
  scripts\mp\flags::gameflagwait("prematch_done");

  for(;;) {
    self waittill("trigger", other);

    if(isPlayer(other))
      other thread minefield_kill(self);
  }
}

minefield_kill(trigger) {
  if(isDefined(self.minefield)) {
    return;
  }
  self.minefield = 1;
  wait 0.5;
  wait(randomfloat(0.5));

  if(isDefined(self) && self istouching(trigger)) {
    origin = self getorigin();
    range = 300;
    maxdamage = 2000;
    mindamage = 50;
    radiusdamage(origin, range, maxdamage, mindamage);
  }

  self.minefield = undefined;
}