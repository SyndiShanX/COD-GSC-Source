/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\fresno\fresno_utilities.gsc
****************************************************/

_id_142D3(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_2))
    wait(var_2);

  var_0 = scripts\engine\utility::drop_to_ground(var_0);
  var_3 = easepower("_encstr_917015FE4548591BAE76238F5E8E778DF03B724FEBF05A", var_0, self.angles);

  if(!isDefined(var_3)) {
    return;
  }
  playsoundatpos(var_0, "_encstr_BA570CB1859CEB2B0F1CB1F646B2");
  var_3 setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_930B07BB1B6B3854FF", 0);
  radiusdamage(var_0, 300, var_1, var_1, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_A2950D16C9E8D2361B59932FF55BC1");
  wait 1;
  var_3 freescriptable();
}