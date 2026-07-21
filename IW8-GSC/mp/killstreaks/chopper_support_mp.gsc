/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\chopper_support_mp.gsc
*************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3", scripts\cp_mp\killstreaks\chopper_support::tryusechoppersupportfromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3", "_encstr_95831CCD95E8EBEC9534D2C6C6CA7DD04B477DC8C2B52C3B957D8C858E16", ::chopper_support_set_vehicle_hit_damage_data);
}

chopper_support_set_vehicle_hit_damage_data(var_0, var_1) {
  scripts\mp\vehicles\damage::set_vehicle_hit_damage_data(var_0, var_1);
}