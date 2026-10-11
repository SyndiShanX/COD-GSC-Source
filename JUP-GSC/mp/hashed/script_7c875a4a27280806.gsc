/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7c875a4a27280806.gsc
*************************************************/

#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\currency;
#using scripts\cp_mp\zombie_perks;
#using scripts\engine\utility;
#using scripts\mp\tweakables;
#using scripts\mp\utility\dvars;
#namespace perk_juggernaut;

function function_1ddcb2ee8addbf81(str_currency, var_fe59c44529c721a0) {
  level thread function_f3a23df892bf82f6("specialty_juggernog", str_currency, var_fe59c44529c721a0, &give_juggernaut_perk, &take_juggernaut_perk);
  registerwatchdvarint("zombie_perk_juggernaut_health", 100);
  registerwatchdvarint("zombie_perk_juggernaut_health_upgrade", 150);
}

function init_juggernaut() {}

function juggernaut_register_clientfield() {}

function juggernaut_set_clientfield(state) {}

function give_juggernaut_perk() {
  function_c01376485eb8f25();
}

function take_juggernaut_perk(b_pause, str_perk, str_result, n_slot) {
  function_74553dbfe828d843();
}

function function_c01376485eb8f25() {
  bundle = level.perkbundles["specialty_juggernog"];
  n_max_total_health = self.maxhealth + bundle.var_e60d66d03350bc81;
  self.maxhealth = n_max_total_health;
  self.health = self.maxhealth;
}

function function_74553dbfe828d843() {
  n_max_total_health = scripts\mp\tweakables::gettweakablevalue("player", "maxhealth");
  self.maxhealth = n_max_total_health;
  self.health = n_max_total_health;
}