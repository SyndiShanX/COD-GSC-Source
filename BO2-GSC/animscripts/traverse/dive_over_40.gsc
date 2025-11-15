/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\dive_over_40.gsc
*************************************************/

#include common_scripts\utility;
#include animscripts\traverse\shared;
#include animscripts\anims;

main() {
  switch (self.type) {
    case "human":
      human();
      break;
    default:

      assertmsg("Traversal: 'dive_over_40' doesn't support entity type '" + self.type + "'.");

  }
}

human() {
  preparefortraverse();
  traversedata = [];
  traversedata["traverseHeight"] = 40.0;
  traversedata["traverseAnim"] = array(animarray("dive_over_40", "move"));
  traversedata["traverseStance"] = "stand";
  traversedata["traverseMovement"] = "run";
  dotraverse(traversedata);
}