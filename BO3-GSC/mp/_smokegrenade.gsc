/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_smokegrenade.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_smokegrenade;
#namespace smokegrenade;

function autoexec __init__sytem__() {
  system::register("smokegrenade", & __init__, undefined, undefined);
}

function __init__() {
  init_shared();
}