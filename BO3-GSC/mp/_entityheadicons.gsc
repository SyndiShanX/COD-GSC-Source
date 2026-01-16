/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_entityheadicons.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\entityheadicons_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace entityheadicons;

function autoexec __init__sytem__() {
  system::register("entityheadicons", & __init__, undefined, undefined);
}

function __init__() {
  init_shared();
}