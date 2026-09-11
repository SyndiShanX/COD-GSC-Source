/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\fresno\fresno_utilities.gsc
************************************************************/

function ref_142d3(var0, var1, var2) {
  level endon("game_ended");

  if(isDefined(var2)) {
    wait var2;
  }

  var0 = scripts\engine\utility::drop_to_ground(var0);
  var3 = easepower("vfx_br_x2_bomber_exp", var0, self.angles);

  if(!isDefined(var3)) {
    return;
  }

  playsoundatpos(var0, "car_explode");
  var3 setscriptablepartstate("base", "active", 0);
  radiusdamage(var0, 300, var1, var1, self, "MOD_EXPLOSIVE", "artillery_mp");
  wait 1;
  var3 freescriptable();
}