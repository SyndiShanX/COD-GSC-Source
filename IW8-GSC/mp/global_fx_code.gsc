/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\global_fx_code.gsc
***********************************************/

global_fx(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_5.size <= 0) {
    return;
  }
  if(!isDefined(var_2))
    var_2 = randomfloatrange(-20, -15);

  if(!isDefined(var_3))
    var_3 = var_1;

  foreach(var_7 in var_5) {
    if(!isDefined(level._effect))
      level._effect = [];

    if(!isDefined(level._effect[var_3]))
      level._effect[var_3] = loadfx(var_1);

    if(!isDefined(var_7.angles))
      var_7.angles = (0, 0, 0);

    var_8 = scripts\engine\utility::createoneshoteffect(var_3);
    var_8.v["_encstr_97FE07DE392D76D2CD"] = var_7.origin;
    var_8.v["_encstr_A7610758E6CED8569B"] = var_7.angles;
    var_8.v["_encstr_95780526F31FA7"] = var_3;
    var_8.v["_encstr_96750613A808E91B"] = var_2;

    if(isDefined(var_4))
      var_8.v["_encstr_8D760BA3EF33C54D42B1B4A19B"] = var_4;
  }
}