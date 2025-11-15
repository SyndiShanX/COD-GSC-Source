/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\_zm_ai_mechz_ffotd.gsc
**************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\zombies\_zm_utility;

spawn_start() {
  self.not_interruptable = 1;
}

spawn_end() {
  self.not_interruptable = 0;
}