/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_teamset.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\system_shared;
#namespace teamset;

function autoexec __init__sytem__() {
  system::register("teamset_seals", & __init__, undefined, undefined);
}

function __init__() {
  level.allies_team = "allies";
  level.axis_team = "axis";
}