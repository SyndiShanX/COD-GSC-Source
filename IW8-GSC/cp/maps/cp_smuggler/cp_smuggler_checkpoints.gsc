/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_smuggler\cp_smuggler_checkpoints.gsc
***********************************************************/

_id_131ED() {
  level.getplunderextractionsites = ::getplatformweaponrankxpmultiplier;
  level.getnextpayloadspawnmodule = ::getnexthelimodule;
}

getplatformweaponrankxpmultiplier() {
  var_0 = [];
  var_0[var_0.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_8A12071CD08B1F423B", (9492.81, 29096.4, 1147.75), (0, 44.9994, 0));
  var_0[var_0.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_8A12071CD08B1F423B", (9466.8, 29005.6, 1137.25), (0, 44.9994, 0));
  var_0[var_0.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_8A12071CD08B1F423B", (9513.28, 28961.6, 1136.5), (0, 44.9994, 0));
  var_0[var_0.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_8A12071CD08B1F423B", (9603.36, 28973.6, 1148.5), (0, 44.9994, 0));
  var_0[var_0.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_8C2F157778E06CFFEA03391FFD5F033BE5EFEB40A32D43", (32056, 41206, 798), (0, 20, 0));
  var_0[var_0.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_8C2F157778E06CFFEA03391FFD5F033BE5EFEB40A32D43", (32122, 41141, 798), (0, 20, 0));
  var_0[var_0.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_8C2F157778E06CFFEA03391FFD5F033BE5EFEB40A32D43", (32174, 41081, 798), (0, 20, 0));
  var_0[var_0.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_8C2F157778E06CFFEA03391FFD5F033BE5EFEB40A32D43", (32281, 41036, 798), (0, 20, 0));
  var_1 = var_0;
  return var_1;
}

getnexthelimodule() {
  var_0 = scripts\mp\brclientmatchdata::getminigundamagescale("_encstr_BD320BCDD6BA3B3BC6CAC9BEC4", (-4170, 33407, 206), (0, 60.096, 0));
  var_1 = scripts\mp\brclientmatchdata::getmaxoutofboundsbrtime("_encstr_8A12071CD08B1F423B", (9797.73, 29319.9, 1176.06), (1.08426, 209.978, -1.1709));
  var_2 = scripts\mp\brclientmatchdata::getminigundamagescale("_encstr_8A12071CD08B1F423B", (9695.73, 29341.9, 1170.06), (354.438, 337.89, 2.255));
  var_3 = scripts\mp\brclientmatchdata::getminigundamagescale("_encstr_88320B3668030F7A08AA96D16B", (22819, 29131, 1089.5), (0, 180, 0));
  var_4 = scripts\mp\brclientmatchdata::getmaxoutofboundsbrtime("_encstr_8C2F157778E06CFFEA03391FFD5F033BE5EFEB40A32D43", (32823, 41662, 706), (1.08426, 0, -1.1709));
  var_5 = scripts\mp\brclientmatchdata::getminigundamagescale("_encstr_8C2F157778E06CFFEA03391FFD5F033BE5EFEB40A32D43", (32963, 41558, 706), (0, 298, 0));
  return [var_0, var_1, var_2, var_4, var_5, var_3];
}

_id_11C58() {
  level.skip_nav_check_on_spectate_respawn = 1;

  if(scripts\engine\utility::flag_exist("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0"))
    scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");

  thread scripts\cp\cp_objectives::run_objective("_encstr_9A0A0FDB134DFA47573BAFED33D7DD584E", "_encstr_BA7F0830B3A7859B60B0");
}

_id_11C5B() {
  if(scripts\engine\utility::flag_exist("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0"))
    scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");

  thread scripts\cp\cp_objectives::run_objective("_encstr_8C2F157778E06CFFEA03391FFD5F033BE5EFEB40A32D43", "_encstr_BA7F0830B3A7859B60B0");
}

_id_11C5C() {}