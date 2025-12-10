/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_acousticsensor.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_acousticsensor;
#namespace acousticsensor;

function autoexec __init__sytem__() {
  system::register("acousticsensor", &__init__, undefined, undefined);
}

function __init__() {
  init_shared();
}