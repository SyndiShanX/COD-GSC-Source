/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_tomb_classic.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#using scripts\zm\zm_tomb_craftables;
#namespace zm_tomb_classic;

function precache() {}

function premain() {
  zm_tomb_craftables::include_craftables();
  zm_tomb_craftables::init_craftables();
}

function main() {}