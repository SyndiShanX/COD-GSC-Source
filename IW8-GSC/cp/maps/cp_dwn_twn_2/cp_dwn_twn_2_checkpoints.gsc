/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_dwn_twn_2\cp_dwn_twn_2_checkpoints.gsc
*************************************************************/

_id_131ED() {
  level.getplunderextractionsites = ::getplatformweaponrankxpmultiplier;
  level.getnextpayloadspawnmodule = ::getnexthelimodule;
}

getplatformweaponrankxpmultiplier() {
  var_0 = [];
  var_0[var_0.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_B47A06BDB537ABF6", (20185.7, -9432.83, -351.636), (0, 55, 0));
  var_0[var_0.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_B47A06BDB537ABF6", (20229, -9460.09, -351.636), (0, 55, 0));
  var_0[var_0.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_B47A06BDB537ABF6", (20302.5, -9518.39, -351.636), (0, 55, 0));
  var_0[var_0.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_B47A06BDB537ABF6", (20358.1, -9557.29, -351.636), (0, 55, 0));
  var_1 = [];
  var_1[var_1.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_957A062DA3C7A23F", (27424.4, -6045.83, -444.125), (0, 145, 0));
  var_1[var_1.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_957A062DA3C7A23F", (27385.2, -6088.72, -444.125), (0, 145, 0));
  var_1[var_1.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_957A062DA3C7A23F", (27347.7, -6137.65, -444.125), (0, 145, 0));
  var_1[var_1.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_957A062DA3C7A23F", (27320.4, -6180.94, -444.125), (0, 145, 0));
  var_2 = [];
  var_2[var_2.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_A27A069DF177CBE3", (19487.4, -11073.6, -320), (0, 135, 0));
  var_2[var_2.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_A27A069DF177CBE3", (19454.5, -11105.7, -320), (0, 135, 0));
  var_2[var_2.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_A27A069DF177CBE3", (19412.4, -11156.4, -320), (0, 135, 0));
  var_2[var_2.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_A27A069DF177CBE3", (19383.4, -11184.6, -320), (0, 135, 0));
  var_3 = scripts\engine\utility::array_combine(var_0, var_1, var_2);
  return var_3;
}

getnexthelimodule() {
  var_0 = scripts\mp\brclientmatchdata::getminigundamagescale("_encstr_8C780B1C3D6FCBE23920276390", (19303.5, -21674, -16.25), (0, 314.408, 0));
  var_1 = scripts\mp\brclientmatchdata::getmaxoutofboundsbrtime("_encstr_B47A06BDB537ABF6", (20106.7, -9039.42, -360), (0, 45, 0));
  var_2 = scripts\mp\brclientmatchdata::getminigundamagescale("_encstr_B47A06BDB537ABF6", (20053.7, -9080.83, -360), (0, 135, 0));
  var_3 = scripts\mp\brclientmatchdata::getmaxoutofboundsbrtime("_encstr_957A062DA3C7A23F", (27296, -5870.12, -456), (0, 135, 0));
  var_4 = scripts\mp\brclientmatchdata::getminigundamagescale("_encstr_957A062DA3C7A23F", (27192, -5800.12, -456), (0, 73, 0));
  var_5 = scripts\mp\brclientmatchdata::getmaxoutofboundsbrtime("_encstr_A27A069DF177CBE3", (19151.4, -10911.9, -355.274), (0, 135, 0));
  var_6 = scripts\mp\brclientmatchdata::getminigundamagescale("_encstr_A27A069DF177CBE3", (18961.4, -11083.9, -344.274), (358.035, 178.999, 2.035));
  var_7 = scripts\mp\brclientmatchdata::getminigundamagescale("_encstr_A27C0A1AFD2D3ABE39C85F0B", (30192.3, -8168.76, -423), (0, 20, 0));
  return [var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7];
}

_id_11C58() {
  if(scripts\engine\utility::flag_exist("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0"))
    scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");

  thread scripts\cp\cp_objectives::run_objective("_encstr_99260FC87D37E87681E74B61EF1A15D0A9", "_encstr_BA7F0830B3A7859B60B0");
}

_id_11C5B() {
  if(scripts\engine\utility::flag_exist("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0"))
    scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");

  level.getoverridedvarexceptmatchrulesvalues = "_encstr_971D1169B131E332C1B7B2C03B5D55EF7987C7";
  thread scripts\cp\cp_objectives::run_objective("_encstr_971D1169B131E332C1B7B2C03B5D55EF7987C7", "_encstr_BA7F0830B3A7859B60B0");
}

_id_11C5C() {
  if(scripts\engine\utility::flag_exist("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0"))
    scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");

  thread scripts\cp\cp_objectives::run_objective("_encstr_A6F40CE08A377FDAE951EDC1450D", "_encstr_BA7F0830B3A7859B60B0");
}