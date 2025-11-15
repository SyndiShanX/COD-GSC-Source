/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\animscripts\zm_dog_pain.gsc
***********************************************/

#include maps\mp\animscripts\utility;

main() {
  debug_anim_print("dog_pain::main() ");
  self endon("killanimscript");
  self setaimanimweights(0, 0);
}