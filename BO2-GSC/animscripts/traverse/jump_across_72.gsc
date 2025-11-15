/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\jump_across_72.gsc
***************************************************/

#include common_scripts\utility;
#include animscripts\traverse\shared;
#include animscripts\anims;

main() {
  preparefortraverse();
  traversedata["traverseAnim"] = animarray("jump_across_72", "move");
  traversedata["traverseStance"] = "stand";
  dotraverse(traversedata);
}