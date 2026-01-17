/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_scrambler.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\shared\clientfield_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_scrambler;
#namespace scrambler;

function autoexec __init__sytem__() {
  system::register("scrambler", &__init__, undefined, undefined);
}

function __init__() {
  init_shared();
}