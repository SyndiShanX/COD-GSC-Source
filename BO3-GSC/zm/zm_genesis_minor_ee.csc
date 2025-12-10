/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_genesis_minor_ee.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\animation_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_bouncingbetty;
#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_utility;
#using scripts\zm\zm_genesis_util;
#namespace zm_genesis_minor_ee;

function autoexec __init__sytem__() {
  system::register("zm_genesis_minor_ee", &__init__, &__main__, undefined);
}

function __init__() {}

function __main__() {
  level.explode_1st_offset = 0;
  level.explode_2nd_offset = 0;
  level.explode_main_offset = 0;
}