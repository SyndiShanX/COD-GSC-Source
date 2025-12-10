/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\killstreaks\_killstreak_detect.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\killstreaks\_killstreak_hacking;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_proximity_grenade;
#namespace killstreak_detect;

function autoexec __init__sytem__() {
  system::register("killstreak_detect", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("vehicle", "enemyvehicle", 1, 2, "int");
  clientfield::register("scriptmover", "enemyvehicle", 1, 2, "int");
  clientfield::register("helicopter", "enemyvehicle", 1, 2, "int");
  clientfield::register("missile", "enemyvehicle", 1, 2, "int");
  clientfield::register("actor", "enemyvehicle", 1, 2, "int");
  clientfield::register("vehicle", "vehicletransition", 1, 1, "int");
}

function killstreaktargetset(killstreakentity, offset = (0, 0, 0)) {
  target_set(killstreakentity, offset);
  killstreakentity thread killstreak_hacking::killstreak_switch_team(killstreakentity.owner);
}

function killstreaktargetclear(killstreakentity) {
  target_remove(killstreakentity);
  killstreakentity thread killstreak_hacking::killstreak_switch_team_end();
}