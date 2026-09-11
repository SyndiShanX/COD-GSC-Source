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

function ref_12af2(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14) {
  var15 = spawnStruct();
  var15.body_model = var2;
  var15.view_model = var3;
  var15.head_model = var4;
  var15.hair_model = var5;
  var15.vo_prefix = var6;
  var15.pap_gesture = var7;
  var15.revive_gesture = var8;
  var15.photo_index = var9;
  var15.fate_card_weapon = var10;
  var15.intro_music = var11;
  var15.intro_gesture = var12;
  var15.melee_weapon = asmdevgetallstates(var13);
  var15.post_setup_func = var14;

  if(!isDefined(level.player_character_info)) {
    level.player_character_info = [];
  }

  if(!isDefined(level.available_player_characters)) {
    level.available_player_characters = [];
  }

  level.player_character_info[var0] = var15;

  if(var1 == "yes") {
    level.available_player_characters[level.available_player_characters.size] = var0;
    return;
  }
}