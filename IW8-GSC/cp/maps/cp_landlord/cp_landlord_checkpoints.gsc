/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_landlord\cp_landlord_checkpoints.gsc
***********************************************************/

_id_131ED() {
  level.getplunderextractionsites = ::getplatformweaponrankxpmultiplier;
  level.getnextpayloadspawnmodule = ::getnexthelimodule;
}

getplatformweaponrankxpmultiplier() {
  var_0 = [];
  var_0[var_0.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_8215098EAD8EBCB1AF1C26", (23048, 9186, -448), (0, 313, 0));
  var_0[var_0.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_8215098EAD8EBCB1AF1C26", (22920, 9242, -448), (0, 320, 0));
  var_0[var_0.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_8215098EAD8EBCB1AF1C26", (22852, 9154, -449.33), (0, 329.999, 0));
  var_0[var_0.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_8215098EAD8EBCB1AF1C26", (22940, 9054, -448), (0, 332.999, 0));
  var_1 = var_0;
  return var_1;
}

getnexthelimodule() {
  var_0 = scripts\mp\brclientmatchdata::getminigundamagescale("_encstr_811D0B60AF6F53294F409B09B3", (16013, -4376, 1616), (0, 0, 0));
  var_1 = scripts\mp\brclientmatchdata::getmaxoutofboundsbrtime("_encstr_8215098EAD8EBCB1AF1C26", (23359.3, 8854.99, -452.166), (1.30863, 139.975, -1.14992));
  var_2 = scripts\mp\brclientmatchdata::getminigundamagescale("_encstr_8215098EAD8EBCB1AF1C26", (23186.3, 8711, -451.166), (0, 240, 0));
  var_3 = scripts\mp\brclientmatchdata::getminigundamagescale("_encstr_967B0985969CCC2D561B19", (4015, 61279.5, 767), (0, 90, 0));
  return [var_0, var_1, var_2, var_3];
}

getplatformrankxpmultiplier() {
  if(scripts\engine\utility::flag_exist("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0"))
    scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");

  thread scripts\cp\cp_objectives::run_objective("_encstr_8A1B0E5AB87D711F5325E2FFCFFBE744", "_encstr_BA7F0830B3A7859B60B0");
}

_id_11C5B() {}

_id_11C5C() {}