/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\gametypes\_weapons.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_challenges;
#using scripts\cp\_scoreevents;
#using scripts\cp\_util;
#using scripts\cp\gametypes\_globallogic_utils;
#using scripts\cp\gametypes\_shellshock;
#using scripts\cp\gametypes\_weapon_utils;
#using scripts\cp\gametypes\_weaponobjects;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_weapons;
#using scripts\shared\weapons_shared;
#namespace weapons;

function autoexec __init__sytem__() {
  system::register("weapons", & __init__, undefined, undefined);
}

function __init__() {
  init_shared();
}