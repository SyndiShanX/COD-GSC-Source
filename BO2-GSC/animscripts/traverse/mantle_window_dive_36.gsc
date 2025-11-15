/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\mantle_window_dive_36.gsc
***************************************************************/

#include common_scripts\utility;
#include animscripts\traverse\shared;
#include animscripts\anims;

main() {
  switch (self.type) {
    case "human":
      human();
      break;
    default:

      assertmsg("Traversal: 'mantle_window_dive_36' doesn't support entity type '" + self.type + "'.");

  }
}

human() {
  preparefortraverse();
  traversedata = [];
  traversedata["traverseHeight"] = 36.0;
  traversedata["traverseAnim"] = animarray("mantle_window_dive_36", "move");
  dotraverse(traversedata);
}