/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_hive_gun.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_hive_gun;
#namespace hive_gun;

function autoexec __init__sytem__() {
  system::register("hive_gun", & __init__, undefined, undefined);
}

function __init__() {
  init_shared();
}