/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_ballistic_knife.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\weapons\_ballistic_knife;
#namespace ballistic_knife;

function autoexec __init__sytem__() {
  system::register("ballistic_knife", & __init__, undefined, undefined);
}

function __init__() {
  init_shared();
}