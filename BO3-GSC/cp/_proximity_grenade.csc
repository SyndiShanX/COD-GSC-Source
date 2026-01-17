/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_proximity_grenade.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_proximity_grenade;
#namespace proximity_grenade;

function autoexec __init__sytem__() {
  system::register("proximity_grenade", &__init__, undefined, undefined);
}

function __init__() {
  init_shared();
}