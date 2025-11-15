/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\jump_across_120.gsc
****************************************************/

#include common_scripts\utility;
#include animscripts\traverse\shared;
#include animscripts\anims;

main() {
  switch (self.type) {
    case "human":
      human();
      break;
    default:

      assertmsg("Traversal: 'jump_across_120' doesn't support entity type '" + self.type + "'.");

  }
}

human() {
  preparefortraverse();
  traversedata["traverseAnim"] = animarray("jump_across_120", "move");
  traversedata["traverseStance"] = "stand";
  dotraverse(traversedata);
}