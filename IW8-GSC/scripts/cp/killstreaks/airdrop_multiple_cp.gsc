/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\airdrop_multiple_cp.gsc
**********************************************************/

function airdrop_multiple_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop_multiple", "monitorDamage", &airdrop_multiple_monitordamage);
}

function airdrop_multiple_monitordamage(var0, var1, var2, var3, var4, var5, var6) {
  ignore_player_silencer();
}

function ignore_player_silencer() {
  if(istrue(level.trial_target_thread_func)) {
    self setCanDamage(0);
    return;
  }
}