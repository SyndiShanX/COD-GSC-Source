/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\toma_strike_mp.gsc
***********************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_A2E60C6BC099B7E1A0A93A398F48", scripts\cp_mp\killstreaks\toma_strike::tryusetomastrikefromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A2E60C6BC099B7E1A0A93A398F48", "_encstr_93790EDAEDCDA5D1F6E4110BDA0B3B56", ::toma_strike_monitordamage);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A2E60C6BC099B7E1A0A93A398F48", "_encstr_8A3219F127FBA0B98D3B9978532655F903EF8DF6812FEEC97403C0", ::toma_strike_molotov_branch_draw_hits);
}

toma_strike_monitordamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  scripts\mp\damage::monitordamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

toma_strike_molotov_branch_draw_hits() {}