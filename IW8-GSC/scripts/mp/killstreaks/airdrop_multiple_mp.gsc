/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\airdrop_multiple_mp.gsc
**********************************************************/

function airdrop_multiple_init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("airdrop_multiple", &scripts\cp_mp\killstreaks\airdrop::tryuseairdropmarkerfromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop_multiple", "monitorDamage", &airdrop_multiple_monitordamage);
}

function airdrop_multiple_monitordamage(var0, var1, var2, var3, var4, var5, var6) {
  scripts\mp\damage::monitordamage(var0, var1, var2, var3, var4, var5, var6);
}