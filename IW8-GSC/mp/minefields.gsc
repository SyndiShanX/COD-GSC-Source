/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\minefields.gsc
***********************************************/

minefields() {
  var_0 = getEntArray("_encstr_84D90AA20B9A5A6AE3208D59", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size > 0)
    level._effect["_encstr_88610F9A4B951F3F910B4044A87BAF252D"] = loadfx("_encstr_A7DB2B1B0D834EDBC8E3FF553948F0B2F0B7DFBFC9807282F020330F72992DAB374F4F7B5BC00A419053615689");

  for(var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1] thread minefield_think();
}

minefield_think() {
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(isPlayer(var_0))
      var_0 thread minefield_kill(self);
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