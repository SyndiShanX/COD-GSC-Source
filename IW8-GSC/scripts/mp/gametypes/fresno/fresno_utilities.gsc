/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\fresno\fresno_utilities.gsc
************************************************************/

function ref_142d3(var_0, var_1, var_2) {
  level endon("game_ended");

  if(isDefined(var_2)) {
    wait var_2;
  }

  var_0 = scripts\engine\utility::drop_to_ground(var_0);
  var_3 = easepower("vfx_br_x2_bomber_exp", var_0, self.angles);

  if(!isDefined(var_3)) {
    return;
  }

  playsoundatpos(var_0, "car_explode");
  var_3 setscriptablepartstate("base", "active", 0);
  radiusdamage(var_0, 300, var_1, var_1, self, "MOD_EXPLOSIVE", "artillery_mp");
  wait 1;
  var_3 freescriptable();
}