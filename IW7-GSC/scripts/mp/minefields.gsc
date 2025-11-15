/*************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\minefields.gsc
*************************************/

minefields() {
  var_00 = getEntArray("minefield", "targetname");
  if(var_00.size > 0) {
    level._effect["mine_explosion"] = loadfx("vfx\core\expl\weap\gre\vfx_exp_gre_dirt_cg");
  }

  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    var_00[var_01] thread minefield_think();
  }
}

minefield_think() {
  for(;;) {
    self waittill("trigger", var_00);
    if(isplayer(var_00)) {
      var_00 thread minefield_kill(self);
    }
  }
}

minefield_kill(param_00) {
  if(isDefined(self.minefield)) {
    return;
  }

  self.minefield = 1;
  wait(0.5);
  wait(randomfloat(0.5));
  if(isDefined(self) && self istouching(param_00)) {
    var_01 = self getorigin();
    var_02 = 300;
    var_03 = 2000;
    var_04 = 50;
    radiusdamage(var_01, var_02, var_03, var_04);
  }

  self.minefield = undefined;
}