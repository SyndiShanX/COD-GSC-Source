/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_heatseekingmissile.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_heatseekingmissile;
#namespace heatseekingmissile;

function autoexec __init__sytem__() {
  system::register("heatseekingmissile", &__init__, undefined, undefined);
}

function __init__() {
  level.lockoncloserange = 220;
  level.lockoncloseradiusscaler = 1;
  init_shared();
}