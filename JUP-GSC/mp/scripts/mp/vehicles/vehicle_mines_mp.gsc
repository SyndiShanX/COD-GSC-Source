/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\vehicle_mines_mp.gsc
****************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle_mines;
#using scripts\engine\utility;
#namespace vehicle_mines_mp;

function vehicle_mines_mp_init() {
  registersharedfunc("vehicle_mines", "trigger", &vehicle_mines_mp_minetrigger);
}

function vehicle_mines_mp_minetrigger(vehicle, mine) {}