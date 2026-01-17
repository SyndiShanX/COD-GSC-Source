/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\weapons\_sticky_grenade.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\system_shared;
#namespace sticky_grenade;

function autoexec __init__sytem__() {
  system::register("sticky_grenade", &__init__, undefined, undefined);
}

function __init__() {}

function watch_bolt_detonation(owner) {}