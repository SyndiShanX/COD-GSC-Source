/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_294d813e5d00b68c.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\helper_drone;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace namespace_ea330d0bf6ebd3d9;

function recondrone_init() {
  level thread function_344254816bb001eb();
}

function function_344254816bb001eb() {
  waitframe();
  level.helperdronesettings["radar_drone_recon"].maxhealth = 150;
  level.helperdronesettings["radar_drone_recon"].repeatuse = 1;
  level.helperdronesettings["radar_drone_recon"].var_cb2c3fe0819193eb = 36000000;
  level.helperdronesettings["radar_drone_recon"].var_1947a47c2174d02c = 0;
}