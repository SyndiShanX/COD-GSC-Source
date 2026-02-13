/************************************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zm_skorpion\cp_zm_skorpion_player_character_setup.gsc
************************************************************************************/

_id_8058() {
  _id_C20B(1, "yes", "c_s4_mp_ger_roland_01", "viewhands_mp_base_iw8", "head_mp_d_scivner_01", undefined, "p2_", "iw7_pap_zm_nerd", "ges_zombies_revive_nerd", 0, "iw7_nerdcard_zm", "mus_zombies_nerd", "iw7_loadoutnerd_zm", "s4_knife_eng");
}

_id_C20B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  var_15 = spawnStruct();
  var_15._id_25D7 = var_2;
  var_15._id_103CE = var_3;
  var_15._id_75E1 = var_4;
  var_15._id_73B5 = var_5;
  var_15._id_105F0 = var_6;
  var_15._id_AE0F = var_7;
  var_15._id_C7C2 = var_8;
  var_15._id_B042 = var_9;
  var_15._id_59D7 = var_10;
  var_15._id_8482 = var_11;
  var_15._id_8463 = var_12;
  var_15._id_9D61 = var_13;
  var_15._id_BA3D = var_14;

  if(!isDefined(level._id_B3DE)) {
    level._id_B3DE = [];
  }

  if(!isDefined(level._id_1F8C)) {
    level._id_1F8C = [];
  }

  level._id_B3DE[var_0] = var_15;

  if(var_1 == "yes") {
    level._id_1F8C[level._id_1F8C.size] = var_0;
  }
}