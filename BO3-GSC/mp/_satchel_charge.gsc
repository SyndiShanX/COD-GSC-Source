/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_satchel_charge.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#using scripts\shared\weapons\_satchel_charge;
#namespace satchel_charge;

function autoexec __init__sytem__() {
  system::register("satchel_charge", & __init__, undefined, undefined);
}

function __init__() {
  init_shared();
}