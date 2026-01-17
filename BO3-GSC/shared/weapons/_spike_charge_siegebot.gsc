/*****************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\weapons\_spike_charge_siegebot.gsc
*****************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\system_shared;
#namespace spike_charge_siegebot;

function autoexec __init__sytem__() {
  system::register("spike_charge_siegebot", &__init__, undefined, undefined);
}

function __init__() {}

function watch_bolt_detonation(owner) {}