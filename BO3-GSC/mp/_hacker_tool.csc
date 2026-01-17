/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_hacker_tool.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_hacker_tool;
#namespace hacker_tool;

function autoexec __init__sytem__() {
  system::register("hacker_tool", &__init__, undefined, undefined);
}

function __init__() {
  init_shared();
}