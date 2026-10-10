/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\killstreaks\auto_drone_mp.gsc
*******************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\auto_drone;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\script;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace auto_drone_mp;

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("auto_drone", &scripts\cp_mp\killstreaks\auto_drone::function_987a0ab2646445e1);
  scripts\engine\utility::registersharedfunc("auto_drone", "attachXRays", &function_76db348491610f8a);
}

function function_76db348491610f8a(autodrone) {
  autodrone function_5226227bce83ebe9(3, autodrone.team);
  return autodrone;
}