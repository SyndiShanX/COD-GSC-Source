/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\jump_down_56.gsc
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

      assertmsg("Traversal: 'jump_down_56' doesn't support entity type '" + self.type + "'.");

  }
}

human() {
  preparefortraverse();
  traversedata = [];
  traversedata["traverseAnim"] = animarray("jump_down_56", "move");
  traversedata["traverseHeight"] = 56.0;
  traversedata["traverseStance"] = "crouch";
  traversedata["traverseAlertness"] = "alert";
  traversedata["traverseMovement"] = "walk";
  dotraverse(traversedata);
}

dog() {
  dog_jump_down(56, 5);
}