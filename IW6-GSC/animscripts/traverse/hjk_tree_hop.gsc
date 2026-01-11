/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\hjk_tree_hop.gsc
*************************************************/

main() {
  if(self.type == "dog") {
    animscripts\traverse\shared::dog_wall_and_window_hop("wallhop", 40);
  }
  else {
    tree_hop_human();
  }
}

#using_animtree("generic_human");

tree_hop_human() {
  if(isDefined(self.type) && self.type == "civilian") {
    animscripts\traverse\shared::advancedtraverse( % so_hijack_civ_log_jump, 39.875);
  }
  else {
    animscripts\traverse\shared::advancedtraverse( % traverse_wallhop_3, 39.875);
  }
}