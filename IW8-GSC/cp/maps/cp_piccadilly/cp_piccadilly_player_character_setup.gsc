/**************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_piccadilly\cp_piccadilly_player_character_setup.gsc
**************************************************************************/

switchtoteammatereviveweapon() {
  _id_12AF2(1, "_encstr_AC190463F552", "_encstr_B6C017D6F899C3073368A70FD0CBF28A75189E4A481D1A49F8", "_encstr_9ADA1667D2ACBBD0B0E6466EFAAD07AF310B6E59F5A5DD1C", "_encstr_929517C8C9AF69680841E357B8AEC930103FB63BAE085B5988", undefined, "_encstr_B119045043D9", "_encstr_B40101", "_encstr_B40101", 0, "_encstr_B40101", "_encstr_B40101", "_encstr_B40101", "_encstr_B40101");
  _id_12AF2(2, "_encstr_AC190463F552", "_encstr_BAF11889ED195ED7B9C26EF5574E4C2CCDF5B1B86CD74E85B4E6", "_encstr_9ADA1667D2ACBBD0B0E6466EFAAD07AF310B6E59F5A5DD1C", "_encstr_8E761830222EB1964FE93638D563F903552988907AC9D569FF1E", undefined, "_encstr_831904D9F2F7", "_encstr_B40101", "_encstr_B40101", 1, "_encstr_B40101", "_encstr_B40101", "_encstr_B40101", "_encstr_B40101");
  _id_12AF2(3, "_encstr_AC190463F552", "_encstr_9A2618C47B4697EBDC2C37D7BAE4C485DCBE466B4EFA4EC25AE6", "_encstr_9ADA1667D2ACBBD0B0E6466EFAAD07AF310B6E59F5A5DD1C", "_encstr_AF731B68B5D92159EF4A7F705D18B9E98649E510C0C65F3F59FA0B3050", undefined, "_encstr_B4190483CCFA", "_encstr_B40101", "_encstr_B40101", 2, "_encstr_B40101", "_encstr_B40101", "_encstr_B40101", "_encstr_B40101");
  _id_12AF2(4, "_encstr_AC190463F552", "_encstr_A93F18137B23CBBECD58CDD75739265837F58D6B3BBE93C2A5B9", "_encstr_9ADA1667D2ACBBD0B0E6466EFAAD07AF310B6E59F5A5DD1C", "_encstr_AC2A1B34CA8532AFE616CDAFAEC931B0DCD75B0EEB23DA9CAF93C25ADC", undefined, "_encstr_86190483D0AF", "_encstr_B40101", "_encstr_B40101", 3, "_encstr_B40101", "_encstr_B40101", "_encstr_B40101", "_encstr_B40101");
  _id_12AF2(5, "_encstr_AC190463F552", "_encstr_B6C017D6F899C3073368A70FD0CBF28A75189E4A481D1A49F8", "_encstr_9ADA1667D2ACBBD0B0E6466EFAAD07AF310B6E59F5A5DD1C", "_encstr_929517C8C9AF69680841E357B8AEC930103FB63BAE085B5988", undefined, "_encstr_B119045043D9", "_encstr_B40101", "_encstr_B40101", 0, "_encstr_B40101", "_encstr_B40101", "_encstr_B40101", "_encstr_B40101");
  _id_12AF2(6, "_encstr_AC190463F552", "_encstr_BAF11889ED195ED7B9C26EF5574E4C2CCDF5B1B86CD74E85B4E6", "_encstr_9ADA1667D2ACBBD0B0E6466EFAAD07AF310B6E59F5A5DD1C", "_encstr_8E761830222EB1964FE93638D563F903552988907AC9D569FF1E", undefined, "_encstr_831904D9F2F7", "_encstr_B40101", "_encstr_B40101", 1, "_encstr_B40101", "_encstr_B40101", "_encstr_B40101", "_encstr_B40101");
  _id_12AF2(7, "_encstr_AC190463F552", "_encstr_9A2618C47B4697EBDC2C37D7BAE4C485DCBE466B4EFA4EC25AE6", "_encstr_9ADA1667D2ACBBD0B0E6466EFAAD07AF310B6E59F5A5DD1C", "_encstr_AF731B68B5D92159EF4A7F705D18B9E98649E510C0C65F3F59FA0B3050", undefined, "_encstr_B4190483CCFA", "_encstr_B40101", "_encstr_B40101", 2, "_encstr_B40101", "_encstr_B40101", "_encstr_B40101", "_encstr_B40101");
  _id_12AF2(8, "_encstr_AC190463F552", "_encstr_A93F18137B23CBBECD58CDD75739265837F58D6B3BBE93C2A5B9", "_encstr_9ADA1667D2ACBBD0B0E6466EFAAD07AF310B6E59F5A5DD1C", "_encstr_AC2A1B34CA8532AFE616CDAFAEC931B0DCD75B0EEB23DA9CAF93C25ADC", undefined, "_encstr_86190483D0AF", "_encstr_B40101", "_encstr_B40101", 3, "_encstr_B40101", "_encstr_B40101", "_encstr_B40101", "_encstr_B40101");
}

_id_12AF2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
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

  if(!isDefined(level.player_character_info))
    level.player_character_info = [];

  if(!isDefined(level.available_player_characters))
    level.available_player_characters = [];

  level.player_character_info[var_0] = var_15;

  if(var_1 == "_encstr_AC190463F552")
    level.available_player_characters[level.available_player_characters.size] = var_0;
}