/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_riotshield.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_util;
#using scripts\shared\clientfield_shared;
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