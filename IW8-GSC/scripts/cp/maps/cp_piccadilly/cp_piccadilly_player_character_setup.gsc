/**********************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_piccadilly\cp_piccadilly_player_character_setup.gsc
**********************************************************************************/

function switchtoteammatereviveweapon() {
  ref_12af2(1, "yes", "body_sas_urban_ar_rain", "viewhands_mp_base_iw8", "head_sas_urban_ar_rain", undefined, "p1_", "", "", 0, "", "", "", "");
  ref_12af2(2, "yes", "body_sas_urban_cqc_rain", "viewhands_mp_base_iw8", "head_sas_urban_lmg_rain", undefined, "p2_", "", "", 1, "", "", "", "");
  ref_12af2(3, "yes", "body_sas_urban_dmr_rain", "viewhands_mp_base_iw8", "head_sas_urban_mp_cqc_rain", undefined, "p3_", "", "", 2, "", "", "", "");
  ref_12af2(4, "yes", "body_sas_urban_lmg_rain", "viewhands_mp_base_iw8", "head_sas_urban_mp_dmr_rain", undefined, "p4_", "", "", 3, "", "", "", "");
  ref_12af2(5, "yes", "body_sas_urban_ar_rain", "viewhands_mp_base_iw8", "head_sas_urban_ar_rain", undefined, "p1_", "", "", 0, "", "", "", "");
  ref_12af2(6, "yes", "body_sas_urban_cqc_rain", "viewhands_mp_base_iw8", "head_sas_urban_lmg_rain", undefined, "p2_", "", "", 1, "", "", "", "");
  ref_12af2(7, "yes", "body_sas_urban_dmr_rain", "viewhands_mp_base_iw8", "head_sas_urban_mp_cqc_rain", undefined, "p3_", "", "", 2, "", "", "", "");
  ref_12af2(8, "yes", "body_sas_urban_lmg_rain", "viewhands_mp_base_iw8", "head_sas_urban_mp_dmr_rain", undefined, "p4_", "", "", 3, "", "", "", "");
}

function ref_12af2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  var_15 = spawnStruct();
  var_15.body_model = var_2;
  var_15.view_model = var_3;
  var_15.head_model = var_4;
  var_15.hair_model = var_5;
  var_15.vo_prefix = var_6;
  var_15.pap_gesture = var_7;
  var_15.revive_gesture = var_8;
  var_15.photo_index = var_9;
  var_15.fate_card_weapon = var_10;
  var_15.intro_music = var_11;
  var_15.intro_gesture = var_12;
  var_15.melee_weapon = asmdevgetallstates(var_13);
  var_15.post_setup_func = var_14;

  if(!isDefined(level.player_character_info)) {
    level.player_character_info = [];
  }

  if(!isDefined(level.available_player_characters)) {
    level.available_player_characters = [];
  }

  level.player_character_info[var_0] = var_15;

  if(var_1 == "yes") {
    level.available_player_characters[level.available_player_characters.size] = var_0;
    return;
  }
}