/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\airdrop_multiple_mp.gsc
**********************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\utility\killstreak;
#namespace airdrop_multiple_mp;

function airdrop_multiple_init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("airdrop_multiple", &scripts\cp_mp\killstreaks\airdrop::tryuseairdropmarkerfromstruct);
  scripts\engine\utility::registersharedfunc("airdrop_multiple", "monitorDamage", &airdrop_multiple_monitordamage);
}

function airdrop_multiple_monitordamage(maxhealth, damagefeedback, ondeathfunc, modifydamagefunc, biskillstreak, rumble, resetdamagetaken) {
  scripts\mp\damage::monitordamage(maxhealth, damagefeedback, ondeathfunc, modifydamagefunc, biskillstreak, rumble, resetdamagetaken);
}