/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\zombies\_zm_clone.csc
**************************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\_fx;
#include clientscripts\mp\zombies\_zm_utility;

init() {
  init_mover_tree();
}

#using_animtree("zm_ally");

init_mover_tree() {
  scriptmodelsuseanimtree(#animtree);
}