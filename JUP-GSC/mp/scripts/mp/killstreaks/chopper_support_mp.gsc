/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\killstreaks\chopper_support_mp.gsc
************************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\chopper_support;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\print;
#using scripts\mp\utility\weapon;
#using scripts\mp\vehicles\damage;
#namespace chopper_support_mp;

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("chopper_support", &scripts\cp_mp\killstreaks\chopper_support::tryusechoppersupportfromstruct);
  scripts\engine\utility::registersharedfunc("chopper_support", "set_vehicle_hit_damage_data", &chopper_support_set_vehicle_hit_damage_data);
}

function chopper_support_set_vehicle_hit_damage_data(ref, hitstokill) {
  scripts\mp\vehicles\damage::set_vehicle_hit_damage_data(ref, hitstokill);
}