/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\vehicles\_attack_drone.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\math_shared;
#using scripts\shared\statemachine_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_ai_shared;
#using scripts\shared\vehicle_death_shared;
#using scripts\shared\vehicle_shared;
#namespace attack_drone;

function autoexec __init__sytem__() {
  system::register("attack_drone", & __init__, undefined, undefined);
}

function __init__() {}