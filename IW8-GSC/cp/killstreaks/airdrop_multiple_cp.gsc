/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\killstreaks\airdrop_multiple_cp.gsc
**************************************************/

airdrop_multiple_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_933811582D932393DE38F5B6571B1D2D0ED82B", "_encstr_93790EDAEDCDA5D1F6E4110BDA0B3B56", ::airdrop_multiple_monitordamage);
}

airdrop_multiple_monitordamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  ignore_player_silencer();
}

ignore_player_silencer() {
  if(istrue(level.trial_target_thread_func))
    self setCanDamage(0);
}