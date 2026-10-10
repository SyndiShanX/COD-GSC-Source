/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\killstreaks\assault_drone_mp.gsc
**********************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\helper_drone;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\utility\game;
#namespace assault_drone_mp;

function function_c260cd16a5c5a2d9() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("assault_drone", &tryusehelperdronefromstruct);
}