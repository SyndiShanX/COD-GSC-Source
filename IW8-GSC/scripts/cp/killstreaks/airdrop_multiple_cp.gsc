/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\airdrop_multiple_cp.gsc
**********************************************************/

function airdrop_multiple_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop_multiple", "monitorDamage", &airdrop_multiple_monitordamage);
}

function airdrop_multiple_monitordamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  ignore_player_silencer();
}

function ignore_player_silencer() {
  if(istrue(level.trial_target_thread_func)) {
    self setCanDamage(0);
    return;
  }
}