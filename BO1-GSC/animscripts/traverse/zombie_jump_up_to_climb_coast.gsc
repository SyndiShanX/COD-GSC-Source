/******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\zombie_jump_up_to_climb_coast.gsc
******************************************************************/

#include animscripts\zombie_Utility;
#include animscripts\traverse\zombie_shared;
#using_animtree("generic_human");

main() {
  if(isDefined(self.is_zombie) && self.is_zombie && self.has_legs == true && !self.isdog) {
    if(self.animname == "director_zombie") {
      low_wall_director();
    } else {
      low_wall_zombie();
    }
  } else if(isDefined(self.is_zombie) && self.is_zombie && self.has_legs == false) {
    low_wall_crawler();
  } else if(self.isdog) {
    dog_jump_up(96, 7);
  }
}
low_wall_zombie() {
  traverseData = [];
  traverseData["traverseAnim"] = % ai_zombie_jump_up_2_climb_coast;
  DoTraverse(traverseData);
}
low_wall_director() {
  traverseData = [];
  traverseData["traverseAnim"] = % ai_zombie_boss_jump_up_2_climb_coast;
  DoTraverse(traverseData);
}
low_wall_crawler() {
  traverseData = [];
  traverseData["traverseAnim"] = % ai_zombie_crawl_jump_up_2_climb;
  DoTraverse(traverseData);
}