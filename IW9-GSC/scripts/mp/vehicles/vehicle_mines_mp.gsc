/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\vehicle_mines_mp.gsc
****************************************************/

vehicle_mines_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_mines", "trigger", ::vehicle_mines_mp_minetrigger);
}

vehicle_mines_mp_minetrigger(vehicle, mine) {}