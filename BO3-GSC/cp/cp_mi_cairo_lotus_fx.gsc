/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_mi_cairo_lotus_fx.gsc
*************************************************/

#using scripts\codescripts\struct;
#namespace cp_mi_cairo_lotus_fx;

function main() {
  precache_scripted_fx();
}

function precache_scripted_fx() {
  level._effect["fx_snow_lotus"] = "weather/fx_snow_player_os_lotus";
}