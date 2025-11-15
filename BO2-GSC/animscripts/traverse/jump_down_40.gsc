/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\jump_down_40.gsc
*************************************************/

#include common_scripts\utility;
#include animscripts\traverse\shared;
#include animscripts\anims;

main() {
  switch (self.type) {
    case "human":
      human();
      break;
    case "dog":
      dog();
      break;
    default:

      assertmsg("Traversal: 'jump_down_40' doesn't support entity type '" + self.type + "'.");

  }
}

human() {
  preparefortraverse();
  traversedata = [];
  traversedata["traverseAnim"] = animarray("jump_down_40", "move");
  dotraverse(traversedata);
}

dog() {
  dog_jump_down(40, 5);
}