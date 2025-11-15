/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\jump_down_128.gsc
**************************************************/

#include common_scripts\utility;
#include animscripts\traverse\shared;
#include animscripts\anims;

main() {
  switch (self.type) {
    case "human":
      human();
      break;
    default:

      assertmsg("Traversal: 'jump_down_128' doesn't support entity type '" + self.type + "'.");

  }
}

human() {
  preparefortraverse();
  traversedata = [];
  traversedata["traverseAnim"] = animarray("jump_down_128", "move");
  dotraverse(traversedata);
}