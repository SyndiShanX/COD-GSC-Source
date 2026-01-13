/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2770.gsc
**************************************/

minefields() {
  var_0 = getEntArray("minefield", "targetname");

  if(var_0.size > 0) {
    level._effect["mine_explosion"] = loadfx("vfx\core\expl\weap\gre\vfx_exp_gre_dirt_cg");
  }

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] thread minefield_think();
  }
}

minefield_think() {
  for(;;) {
    self waittill("trigger", var_0);

    if(isplayer(var_0)) {
      var_0 thread minefield_kill(self);
    }
  }
}

minefield_kill(var_0) {
  if(isDefined(self.minefield)) {
    return;
  }
  self.minefield = 1;
  wait 0.5;
  wait(randomfloat(0.5));

  if(isDefined(self) && self istouching(var_0)) {
    var_1 = self getorigin();
    var_2 = 300;
    var_3 = 2000;
    var_4 = 50;
    radiusdamage(var_1, var_2, var_3, var_4);
  }

  self.minefield = undefined;
}