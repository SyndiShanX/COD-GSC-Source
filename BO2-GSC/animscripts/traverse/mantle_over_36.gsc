/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\mantle_over_36.gsc
***************************************************/

#include common_scripts\utility;
#include animscripts\traverse\shared;
#include animscripts\anims;

main() {
  switch (self.type) {
    case "human":
      human();
      break;
    default:

      assertmsg("Traversal: 'mantle_over_36' doesn't support entity type '" + self.type + "'.");

  }
}

human() {
  preparefortraverse();
  traversedata = [];
  traversedata["traverseAnim"] = animarray("mantle_over_36", "move");
  traversedata["traverseHeight"] = 36.0;
  traversedata["traverseStance"] = "stand";
  dotraverse(traversedata);
}