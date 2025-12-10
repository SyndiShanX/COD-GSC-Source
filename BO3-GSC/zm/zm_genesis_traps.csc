/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_genesis_traps.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\zm\_zm_trap_electric;
#namespace zm_genesis_traps;

function autoexec __init__sytem__() {
  system::register("zm_genesis_traps", &__init__, &__main__, undefined);
}

function __init__() {
  precache_scripted_fx();
}

function __main__() {}

function precache_scripted_fx() {
  level._effect["zapper"] = "dlc1/castle/fx_elec_trap_castle";
}