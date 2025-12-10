/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_flashgrenades.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\shared\weapons\_flashgrenades;
#namespace flashgrenades;

function autoexec __init__sytem__() {
  system::register("flashgrenades", &__init__, undefined, undefined);
}

function __init__(localclientnum) {
  init_shared();
}