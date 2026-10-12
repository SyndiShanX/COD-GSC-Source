/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\toma_strike_mp.gsc
*****************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\toma_strike;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\equipment\molotov;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace toma_strike_mp;

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("toma_strike", &scripts\cp_mp\killstreaks\toma_strike::tryusetomastrikefromstruct);
  scripts\engine\utility::registersharedfunc("toma_strike", "monitorDamage", &toma_strike_monitordamage);
  scripts\engine\utility::registersharedfunc("toma_strike", "molotov_branch_draw_hits", &toma_strike_molotov_branch_draw_hits);
  bundle = level.streakglobals.streakbundles["toma_strike"];

  if(isDefined(bundle) && isDefined(bundle.var_d2a6e2899c72649b)) {
    [[getsharedfunc("killstreak", "registerKillstreakDamageDealingWeapon")]]("toma_strike", bundle.var_d2a6e2899c72649b, #"medium");
  }
}

function toma_strike_monitordamage(maxhealth, damagefeedback, ondeathfunc, modifydamagefunc, biskillstreak, rumble, resetdamagetaken) {
  scripts\mp\damage::monitordamage(maxhealth, damagefeedback, ondeathfunc, modifydamagefunc, biskillstreak, rumble, resetdamagetaken);
}

function toma_strike_molotov_branch_draw_hits() {
  thread scripts\mp\equipment\molotov::molotov_branch_draw_hits();
}