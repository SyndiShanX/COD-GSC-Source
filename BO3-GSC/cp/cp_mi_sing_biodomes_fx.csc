/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_mi_sing_biodomes_fx.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\fx_shared;
#namespace cp_mi_sing_biodomes_fx;

function main() {
  precache_scripted_fx();
}

function precache_scripted_fx() {
  level._effect["player_dust"] = "dirt/fx_dust_motes_player_loop";
}