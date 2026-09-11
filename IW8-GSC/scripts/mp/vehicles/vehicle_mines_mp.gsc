/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\vehicle_mines_mp.gsc
****************************************************/

function vehicle_mines_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_mines", "trigger", &vehicle_mines_mp_minetrigger);
}

function vehicle_mines_mp_minetrigger(var_0, var_1) {}