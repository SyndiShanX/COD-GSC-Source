/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_bb.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\bb_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#namespace bb;

function autoexec __init__sytem__() {
  system::register("bb", &__init__, undefined, undefined);
}

function __init__() {
  init_shared();
}