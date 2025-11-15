/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_riotshield.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\killstreaks_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_riotshield;
#namespace riotshield;

function autoexec __init__sytem__() {
  system::register("riotshield", & __init__, undefined, undefined);
}

function __init__() {
  init_shared();
}