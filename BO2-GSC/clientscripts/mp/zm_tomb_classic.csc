/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\zm_tomb_classic.csc
************************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\zombies\_zm_weapons;
#include clientscripts\mp\zombies\_zm_utility;
#include clientscripts\mp\zm_tomb_craftables;

premain() {
  clientscripts\mp\zm_tomb_craftables::include_craftables();
  clientscripts\mp\zm_tomb_craftables::init_craftables();
}