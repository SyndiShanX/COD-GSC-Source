/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_lightninggun.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_lightninggun;
#namespace lightninggun;

function autoexec __init__sytem__() {
  system::register("lightninggun", & __init__, undefined, undefined);
}

function __init__() {
  init_shared();
}