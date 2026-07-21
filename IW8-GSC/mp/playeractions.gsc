/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\playeractions.gsc
***********************************************/

init() {
  var_0 = spawnStruct();
  level.actionglobals = var_0;
  var_0.actions = [];
  var_0.actionsets = [];
  addaction("_encstr_9BE40A0BC09BCEF7C0F33441", scripts\common\utility::allow_usability);
  addaction("_encstr_AC20072B9FA9487832", scripts\common\utility::allow_weapon);
  addaction("_encstr_A60F0E030703D180A0665F43BA558F28", scripts\common\utility::allow_weapon_switch);
  addaction("_encstr_A1AF107FB41FA3596A69773FD20858C85627", scripts\common\utility::allow_offhand_weapons);
  addaction("_encstr_880718D8F70AB9490ECBA9C88B5180E33358585C8FD25170E6BF", scripts\common\utility::allow_offhand_primary_weapons);
  addaction("_encstr_85DF1AF633CC0D0B9B197DE695D8F6734685C95EFABBCA0B0EDB9BDC", scripts\common\utility::allow_offhand_secondary_weapons);
  addaction("_encstr_85190CAB8B3971B0A4DB2BCAC253", scripts\common\utility::allow_killstreaks);
  addaction("_encstr_BEF4071AA87BDF5220", scripts\common\utility::allow_supers);
  addaction("_encstr_8F0508CE59DCA357392B", scripts\mp\utility\player::allow_gesture);
  addaction("_encstr_AD1904291F7B", scripts\common\utility::allow_ads);
  addaction("_encstr_AF4D07932B1BDE5846", scripts\common\utility::allow_reload);
  addaction("_encstr_96EB0B0BABD1DB39598DF616C8", scripts\common\utility::allow_autoreload);
  addaction("_encstr_B8840F32A81197F3C9E32F3E9B303FCB45", scripts\common\utility::allow_movement);
  addaction("_encstr_964E0BB08D63B7BBF553EA5BC1", scripts\common\utility::allow_jump);
  addaction("_encstr_92100762872552A643", scripts\common\utility::allow_sprint);
  addaction("_encstr_B13D076BED70539F23", scripts\common\utility::allow_crouch);
  addaction("_encstr_922406F1A6FD5E05", scripts\common\utility::allow_prone);
  addaction("_encstr_A5AD069B231F0BAF", scripts\common\utility::allow_stand);
  addaction("_encstr_88780599B4E495", scripts\common\utility::allow_fire);
  addaction("_encstr_BD6B06A64C87A9E3", scripts\common\utility::allow_slide);
  addaction("_encstr_A6C7065BACB1CA95", scripts\common\utility::allow_melee);
  addaction("_encstr_8CF40B9B3BFD1849BB9CC8C6B4", scripts\common\utility::allow_shellshock);
  addaction("_encstr_A1760D221BB8AF4350FB44519F388A", scripts\common\utility::brjugg_initdroplocations);
  addaction("_encstr_AC19044DE657", scripts\common\utility::brjugg_oncrateuse);
}

addaction(var_0, var_1) {
  level.actionglobals.actions[var_0] = var_1;
}

getactionallowfunc(var_0) {
  return level.actionglobals.actions[var_0];
}

registeractionset(var_0, var_1) {
  level.actionglobals.actionsets[var_0] = var_1;
}

allowactionset(var_0, var_1) {
  foreach(var_3 in level.actionglobals.actionsets[var_0]) {
    var_4 = getactionallowfunc(var_3);
    [[var_4]](var_1, var_0);
  }
}