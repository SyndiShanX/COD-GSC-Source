/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\zombies\_zm_ai_quadrotor.csc
*************************************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\zombies\_zm_utility;
#include clientscripts\mp\zm_tomb_amb;

init() {
}

spawned(localclientnum) {
  self waittill_dobj(localclientnum);
  level thread clientscripts\mp\zm_tomb_amb::init();
  self thread clientscripts\mp\zm_tomb_amb::start_helicopter_sounds();
}