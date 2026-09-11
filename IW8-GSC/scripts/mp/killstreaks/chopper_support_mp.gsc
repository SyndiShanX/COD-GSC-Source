/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\chopper_support_mp.gsc
*********************************************************/

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("chopper_support", &scripts\cp_mp\killstreaks\chopper_support::tryusechoppersupportfromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_support", "set_vehicle_hit_damage_data", &chopper_support_set_vehicle_hit_damage_data);
}

function chopper_support_set_vehicle_hit_damage_data(var0, var1) {
  scripts\mp\vehicles\damage::set_vehicle_hit_damage_data(var0, var1);
}