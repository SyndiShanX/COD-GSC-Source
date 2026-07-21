/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\utility\game_utility_cp.gsc
***********************************************/

game_utility_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_88220D9C76FAE3CE55CB5868A78CC2", "_encstr_B4B3167656E88AA5DACAA65ACDC656E8166B95A6A32CC947", ::game_utility_cp_gettimesincegamestart);
}

game_utility_cp_gettimesincegamestart() {
  return gettime() - level.starttime;
}