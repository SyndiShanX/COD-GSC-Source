/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\zombie_jump_down_96.gsc
********************************************************/

#include animscripts\utility;
#include animscripts\traverse\zombie_shared;
#using_animtree("generic_human");

main() {
  if(isDefined(self.is_zombie) && self.is_zombie) {
    if(!self.isdog) {
      if(self.has_legs == true) {
        if(self.animname == "director_zombie") {
          jump_down_director();
        } else {
          jump_down_zombie();
        }
      } else {
        jump_down_crawler();
      }
    } else {
      dog_jump_down(96, 7);
    }
  }
}
jump_down_director() {
  traverseData = [];
  traverseData["traverseAnim"] = % ai_zombie_boss_jump_down_97_coast;
  DoTraverse(traverseData);
}
jump_down_zombie() {
  traverseData = [];
  traverseData["traverseAnim"] = % ai_zombie_jump_down_96;
  DoTraverse(traverseData);
}
jump_down_crawler() {
  traverseData = [];
  traverseData["traverseAnim"] = % ai_zombie_crawl_jump_down_97;
  DoTraverse(traverseData);
}