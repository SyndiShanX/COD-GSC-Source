/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_trophy_system.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_trophy_system;
#namespace trophy_system;

function autoexec __init__sytem__() {
  system::register("trophy_system", &__init__, undefined, undefined);
}

function __init__(localclientnum) {
  init_shared();
}