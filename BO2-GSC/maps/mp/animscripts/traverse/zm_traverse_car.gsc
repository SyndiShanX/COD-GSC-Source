/*******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\animscripts\traverse\zm_traverse_car.gsc
*******************************************************************/

#include maps\mp\animscripts\traverse\shared;
#include maps\mp\animscripts\traverse\zm_shared;

main() {
  speed = "";

  if(!isDefined(self.isdog) || !self.isdog) {
    switch (self.zombie_move_speed) {
      case "walk":
      case "walk_slide":
        speed = "";
        break;
      case "run":
      case "run_slide":
        speed = "_run";
        break;
      case "sprint":
      case "sprint_slide":
      case "super_sprint":
        speed = "_sprint";
        break;
      default:
    }
  }

  dosimpletraverse("traverse_car" + speed, 1);
}