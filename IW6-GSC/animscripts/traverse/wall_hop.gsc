/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\wall_hop.gsc
*********************************************/

main() {
  if(self.type == "dog")
    animscripts\traverse\shared::dog_wall_and_window_hop("wallhop", 40);
  else
    wall_hop_human();
}

#using_animtree("generic_human");

wall_hop_human() {
  if(randomint(100) < 30)
    animscripts\traverse\shared::advancedtraverse( % traverse_wallhop_3, 39.875);
  else
    animscripts\traverse\shared::advancedtraverse( % traverse_wallhop, 39.875);
}