/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\wall_hop.gsc
*********************************************/

main() {
  if(self.type == "dog") {
    animscripts\traverse\shared::_id_3FF7("wallhop", 40);
  } else {
    _id_3FFC();
  }
}

#using_animtree("generic_human");

_id_3FFC() {
  if(randomint(100) < 30) {
    animscripts\traverse\shared::_id_3FE6( % traverse_wallhop_3, 39.875);
  } else {
    animscripts\traverse\shared::_id_3FE6( % traverse_wallhop, 39.875);
  }
}