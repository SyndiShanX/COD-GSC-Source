/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_50baf2ef084cce5b.gsc
*************************************************/

#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\currency;
#using scripts\cp_mp\playerhealth;
#using scripts\cp_mp\zombie_perks;
#using scripts\engine\utility;
#using scripts\mp\utility\dvars;
#namespace perk_quick_revive;

function function_5282518f868ab7b6(str_currency, var_fe59c44529c721a0) {
  level thread function_f3a23df892bf82f6("specialty_quickrevive", str_currency, var_fe59c44529c721a0, &give_quick_revive_perk, &take_quick_revive_perk);
  function_93cd34979e0adbdd(&function_736b6262165f91e);
}

function give_quick_revive_perk() {
  function_c90f0f12e436d73c();
}

function take_quick_revive_perk(b_pause, str_perk, str_result, n_slot) {
  function_b55fab7706270fe();
}

function function_c90f0f12e436d73c() {
  regendelay = default_to(level.perkbundles["specialty_quickrevive"].var_530928eed957ea07, 0.5);
  scripts\cp_mp\playerhealth::function_5457f0107a845374("regenDelayReduce_quickRevive", regendelay);
  function_ab7a3ff9f75e4867("specialty_quickrevive");
}

function function_b55fab7706270fe() {
  scripts\cp_mp\playerhealth::function_4f8b5efd1816f6c3("regenDelayReduce_quickRevive");
  function_fe0d28e6f0008329("specialty_quickrevive");
}

function function_736b6262165f91e(healthperframe) {
  var_efd5d24a200cd8c1 = undefined;
  return var_efd5d24a200cd8c1;
}