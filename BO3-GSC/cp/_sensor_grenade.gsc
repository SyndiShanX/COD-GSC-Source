/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_sensor_grenade.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\weapons\_sensor_grenade;
#namespace sensor_grenade;

function autoexec __init__sytem__() {
  system::register("sensor_grenade", & __init__, undefined, undefined);
}

function __init__() {
  init_shared();
}