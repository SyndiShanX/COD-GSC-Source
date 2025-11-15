/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\mantle_on_36.gsc
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

      assertmsg("Traversal: 'mantle_on_36' doesn't support entity type '" + self.type + "'.");

  }
}

human() {
  preparefortraverse();
  traversedata = [];
  traversedata["traverseAnim"] = array(animarray("mantle_on_36", "move"));
  traversedata["traverseHeight"] = 36.0;
  traversedata["traverseStance"] = "stand";
  traversedata["traverseAlertness"] = "casual";
  traversedata["traverseMovement"] = "run";
  traversedata["interruptDeathAnim"][0] = animarray("traverse_40_death_start", "move");
  traversedata["interruptDeathAnim"][1] = animarray("traverse_40_death_end", "move");
  dotraverse(traversedata);
}