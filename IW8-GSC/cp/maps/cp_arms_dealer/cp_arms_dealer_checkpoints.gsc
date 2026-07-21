/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_arms_dealer\cp_arms_dealer_checkpoints.gsc
*****************************************************************/

_id_131ED() {
  level.getplunderextractionsites = ::getplatformweaponrankxpmultiplier;
  level.getnextpayloadspawnmodule = ::getnexthelimodule;
}

getplatformweaponrankxpmultiplier() {
  var_0 = [];
  var_0[var_0.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_87B80821127338B81BE6", (-16234.3, 69.74, -319.609), (0, 360, 0));
  var_0[var_0.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_87B80821127338B81BE6", (-16217.5, -4.8601, -319.509), (0, 30, 0));
  var_0[var_0.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_87B80821127338B81BE6", (-16172.3, -58.26, -317.641), (0, 45, 0));
  var_0[var_0.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_87B80821127338B81BE6", (-16106.3, -78.26, -304.312), (0, 60, 0));
  var_1 = [];
  var_1[var_1.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_A9CA0DDB6A4D88A0C312915919234F", (-2923.48, 10218.7, 55.9929), (0, 95.9991, 0));
  var_1[var_1.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_A9CA0DDB6A4D88A0C312915919234F", (-3009.48, 10212.7, 55.9929), (0, 85.9992, 0));
  var_1[var_1.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_A9CA0DDB6A4D88A0C312915919234F", (-3279.48, 10190.7, 55.9929), (0, 95.9991, 0));
  var_1[var_1.size] = scripts\mp\brclientmatchdata::getnearbyaliveplayer("_encstr_A9CA0DDB6A4D88A0C312915919234F", (-3365.48, 10184.7, 55.9929), (0, 85.9992, 0));
  var_2 = scripts\engine\utility::array_combine(var_0, var_1);
  return var_2;
}

getnexthelimodule() {
  var_0 = scripts\mp\brclientmatchdata::getminigundamagescale("_encstr_B8E508DA7711DAB4F8A8", (-18402.5, 1317.09, -147.93), (0, 35.649, 0));
  var_1 = scripts\mp\brclientmatchdata::getmaxoutofboundsbrtime("_encstr_87B80821127338B81BE6", (-16072, 64, -320.674), (0, 30, 0));
  var_2 = scripts\mp\brclientmatchdata::getminigundamagescale("_encstr_87B80821127338B81BE6", (-15932, 144, -320.674), (0, 200, 0));
  var_3 = scripts\mp\brclientmatchdata::getmaxoutofboundsbrtime("_encstr_A9CA0DDB6A4D88A0C312915919234F", (-2924.43, 10589.4, 43.8749), (0, 95.9991, 0));
  var_4 = scripts\mp\brclientmatchdata::getminigundamagescale("_encstr_A9CA0DDB6A4D88A0C312915919234F", (-3096.43, 10571.4, 43), (0, 107, 0));
  var_5 = scripts\mp\brclientmatchdata::getminigundamagescale("_encstr_91490A8D397B9B9BDDA537C8", (-18692.5, 8453.77, -272.01), (0, 180, 0));
  return [var_0, var_1, var_2, var_3, var_4, var_5];
}

c4_obj_and_progress() {
  if(!scripts\engine\utility::flag_exist("_encstr_A54D21DE700F7BBB2042F098DA7D75F05FBBDD437E8FC6878A9998E062D231A9F3256D"))
    scripts\engine\utility::flag_init("_encstr_A54D21DE700F7BBB2042F098DA7D75F05FBBDD437E8FC6878A9998E062D231A9F3256D");

  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");

  while(!scripts\engine\utility::flag_exist("_encstr_8430170EB0BFCB0B9012A0E8AA2DC5408F4B0DF32EFF96577A"))
    waitframe();

  scripts\engine\utility::flag_set("_encstr_8430170EB0BFCB0B9012A0E8AA2DC5408F4B0DF32EFF96577A");
  scripts\engine\utility::flag_wait("_encstr_A54D21DE700F7BBB2042F098DA7D75F05FBBDD437E8FC6878A9998E062D231A9F3256D");
  thread scripts\cp\cp_objectives::run_objective("_encstr_8D390C38162A378BE19F1010E73C", "_encstr_BA7F0830B3A7859B60B0");
}

camera_loadout_showcase_preview_large_sticker_alt2() {
  if(scripts\engine\utility::flag_exist("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0"))
    scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");

  thread scripts\cp\cp_objectives::run_objective("_encstr_967A0DBD269ABE2C275BDC4E16D859", "_encstr_BA7F0830B3A7859B60B0");
}

_id_11C5C() {}