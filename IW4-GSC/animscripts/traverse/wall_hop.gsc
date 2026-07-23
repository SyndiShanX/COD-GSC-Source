/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: animscripts\traverse\wall_hop.gsc
********************************************************/

#include animscripts\traverse\shared;

main() {
  if(self.type == "dog") {
    dog_wall_and_window_hop("wallhop", 40);
  } else {
    wall_hop_human();
  }
}

#using_animtree("generic_human");

wall_hop_human() {
  if(randomint(100) < 30) {
    self advancedTraverse(%traverse_wallhop_3, 39.875);
  } else {
    self advancedTraverse(%traverse_wallhop, 39.875);
  }
}