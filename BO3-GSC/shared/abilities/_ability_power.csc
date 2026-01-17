/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\_ability_power.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#namespace ability_power;

function autoexec __init__sytem__() {
  system::register("ability_power", &__init__, undefined, undefined);
}

function __init__() {}