/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\airdrop_multiple_cp.gsc
**********************************************************/



#using scripts\common\utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\engine\utility;
#namespace airdrop_multiple_cp;

function airdrop_multiple_init() {
  scripts\engine\utility::registersharedfunc("airdrop_multiple", "monitorDamage", &airdrop_multiple_monitordamage);
}

function airdrop_multiple_monitordamage(maxhealth, damagefeedback, ondeathfunc, modifydamagefunc, biskillstreak, rumble, resetdamagetaken) {
  coop_handle_invuln_ac130();
}

function coop_handle_invuln_ac130() {
  if(istrue(level.invulnerable_airdropmultiple_ac130s)) {
    self setCanDamage(0);
  }
}