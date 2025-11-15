/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_genesis_spiders.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\zm\_zm;
#namespace zm_genesis_spiders;

function autoexec __init__sytem__() {
  system::register("zm_island_spiders", & __init__, & __main__, undefined);
}

function __init__() {}

function __main__() {
  register_clientfields();
}

function register_clientfields() {}