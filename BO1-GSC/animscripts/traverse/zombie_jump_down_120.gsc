/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\zombie_jump_down_120.gsc
*********************************************************/

#include animscripts\utility;
#include animscripts\traverse\zombie_shared;
#using_animtree("generic_human");
main() {
  if(isDefined(self.is_zombie) && self.is_zombie) {
    if(!self.isdog) {
      if(self.has_legs == true) {
        if(self.animname == "quad_zombie") {
          self jump_down_quad();
        } else {
          jump_down_zombie();
        }
      } else {
        jump_down_crawler();
      }
    } else {
      dog_jump_down(120, 7);
    }
  }
}

jump_down_zombie() {
  traverseData = [];
  traverseData["traverseAnim"] = % ai_zombie_jump_down_120;
  DoTraverse(traverseData);
}

jump_down_quad() {
  traverseData = [];
  traverseData["traverseAnim"] = % ai_zombie_quad_jump_down_128;
  DoTraverse(traverseData);
  self notify("quad_end_traverse_anim");
}

jump_down_crawler() {
  traverseData = [];
  traverseData["traverseAnim"] = % ai_zombie_crawl_jump_down_120;
  DoTraverse(traverseData);
}