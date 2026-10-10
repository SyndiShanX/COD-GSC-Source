/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7c1f11bc5588635c.gsc
*************************************************/

#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\currency;
#using scripts\cp_mp\zombie_perks;
#using scripts\engine\utility;
#using scripts\mp\utility\dvars;
#namespace perk_deadshot;

function function_d87a1d30e15f1c8b(str_currency, var_fe59c44529c721a0) {
  n_perk_cost = default_to(var_fe59c44529c721a0, 2000);
  level thread function_f3a23df892bf82f6("specialty_deadshot", str_currency, n_perk_cost, &give_deadshot_perk, &take_deadshot_perk, 1);
}

function give_deadshot_perk() {
  function_ab7a3ff9f75e4867("specialty_deadshot");
  var_985ea103b97c8abb = level.perkbundles["specialty_deadshot"].var_fee1a408c2a3d2d7;

  if(isDefined(var_985ea103b97c8abb)) {
    self.var_ae9b30f13abd35fc = var_985ea103b97c8abb;
  }
}

function take_deadshot_perk(b_pause, str_perk, str_result, n_slot) {
  function_888a7004c6bd50e9();
  self.var_ae9b30f13abd35fc = undefined;
}

function function_888a7004c6bd50e9() {
  function_fe0d28e6f0008329("specialty_deadshot");
}