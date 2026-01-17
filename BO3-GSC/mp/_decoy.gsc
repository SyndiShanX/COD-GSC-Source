/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_decoy.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_decoy;
#namespace decoy;

function autoexec __init__sytem__() {
  system::register("decoy", &__init__, undefined, undefined);
}

function __init__() {
  init_shared();
}