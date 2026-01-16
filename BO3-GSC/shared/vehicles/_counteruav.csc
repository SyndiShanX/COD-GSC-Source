/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\vehicles\_counteruav.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\archetype_shared\archetype_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\filter_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#namespace counteruav;

function autoexec __init__sytem__() {
  system::register("counteruav", & __init__, undefined, undefined);
}

function __init__() {}