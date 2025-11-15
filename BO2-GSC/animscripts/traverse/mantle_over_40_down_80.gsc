/*****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\mantle_over_40_down_80.gsc
*****************************************************************/

#include common_scripts\utility;
#include animscripts\traverse\shared;
#include animscripts\anims;

main() {
  switch (self.type) {
    case "human":
      human();
      break;
    default:

      assertmsg("Traversal: 'mantle_over_40_down_80' doesn't support entity type '" + self.type + "'.");

  }
}

human() {
  preparefortraverse();
  traversedata = [];
  traversedata["traverseHeight"] = 40.0;
  traversedata["traverseAnim"] = animarray("mantle_over_40_down_80", "move");
  dotraverse(traversedata);
}