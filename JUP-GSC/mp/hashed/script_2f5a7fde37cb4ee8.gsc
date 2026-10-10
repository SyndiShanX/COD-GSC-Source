/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2f5a7fde37cb4ee8.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\hover_jet;
#using scripts\cp_mp\utility\turret_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#using scripts\mp\vehicles\damage;
#namespace namespace_1e1e8fdc0b6e3977;

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("hover_jet", &scripts\cp_mp\killstreaks\hover_jet::tryusehoverjetfromstruct);
  scripts\engine\utility::registersharedfunc("hover_jet", "set_vehicle_hit_damage_data", &function_c414d20013783e62);
  scripts\engine\utility::registersharedfunc("hover_jet", "registerSentient", &function_c8ababcac24ad291);
}

function function_c414d20013783e62(ref, hitstokill) {
  scripts\mp\vehicles\damage::set_vehicle_hit_damage_data(ref, hitstokill);
}

function function_c8ababcac24ad291(threatbiasgroup, var_5c00772332ce642c) {
  scripts\mp\sentientpoolmanager::registersentient(threatbiasgroup, var_5c00772332ce642c);
}