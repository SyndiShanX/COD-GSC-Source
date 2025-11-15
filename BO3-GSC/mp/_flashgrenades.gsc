/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_flashgrenades.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#using scripts\shared\weapons\_flashgrenades;
#namespace flashgrenades;

function autoexec __init__sytem__() {
  system::register("flashgrenades", & __init__, undefined, undefined);
}

function __init__() {
  init_shared();
}