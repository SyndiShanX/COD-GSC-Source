/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\mantle_over_96.gsc
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

      assertmsg("Traversal: 'mantle_over_96' doesn't support entity type '" + self.type + "'.");

  }
}

human() {
  preparefortraverse();
  traversedata = [];
  traversedata["traverseAnim"] = animarray("mantle_over_96", "move");
  traversedata["traverseHeight"] = 96.0;
  traversedata["traverseStance"] = "stand";
  dotraverse(traversedata);
}