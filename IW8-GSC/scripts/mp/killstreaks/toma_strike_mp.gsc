/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\toma_strike_mp.gsc
*****************************************************/

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("toma_strike", &scripts\cp_mp\killstreaks\toma_strike::tryusetomastrikefromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("toma_strike", "monitorDamage", &toma_strike_monitordamage);
  scripts\cp_mp\utility\script_utility::registersharedfunc("toma_strike", "molotov_branch_draw_hits", &toma_strike_molotov_branch_draw_hits);
}

function toma_strike_monitordamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  scripts\mp\damage::monitordamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

function toma_strike_molotov_branch_draw_hits() {}