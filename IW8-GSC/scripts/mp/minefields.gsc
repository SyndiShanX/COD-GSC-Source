/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\minefields.gsc
***********************************************/

function minefields() {
  var0 = getEntArray("minefield", "targetname");

  if(var0.size > 0) {
    level._effect["mine_explosion"] = loadfx("vfx/core/expl/weap/gre/vfx_exp_gre_dirt_cg");
  }

  for(var1 = 0; var1 < var0.size; var1++) {
    thread minefield_think();
  }
}

function minefield_think() {
  scripts\mp\flags::gameflagwait("prematch_done");

  for(;;) {
    self waittill("trigger", var0);

    if(isPlayer(var0)) {
      thread minefield_kill(var0);
    }
  }
}

function minefield_kill(var0) {
  if(isDefined(self.minefield)) {
    return;
  }

  self.minefield = 1;
  wait 0.5;
  wait randomfloat(0.5);

  if(isDefined(self) && self istouching(var0)) {
    var1 = self getorigin();
    var2 = 300;
    var3 = 2000;
    var4 = 50;
    radiusdamage(var1, var2, var3, var4);
  }

  self.minefield = undefined;
}