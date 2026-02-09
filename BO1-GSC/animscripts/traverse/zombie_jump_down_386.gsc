/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\zombie_jump_down_386.gsc
*********************************************************/

#include animscripts\utility;
#include animscripts\traverse\zombie_shared;
#using_animtree("generic_human");

main() {
  if(isDefined(self.is_zombie) && self.is_zombie) {
    if(self.type != "dog") {
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
      return;
    }
  }
}
jump_down_zombie() {
  traverseData = [];
  traverseData["traverseAnim"] = % ai_zombie_jump_down_386;
  DoTraverse(traverseData);
}
jump_down_quad() {
  traverseData = [];
  traverseData["traverseAnim"] = % ai_zombie_quad_jump_down_386;
  DoTraverse(traverseData);
}
jump_down_crawler() {
  traverseData = [];
  if(isDefined(level.on_the_moon) && level.on_the_moon == true) {
    traverseData["traverseAnim"] = % ai_zombie_crawl_jump_down_lowg_386;
  } else {
    traverseData["traverseAnim"] = % ai_zombie_crawl_jump_down_386;
  }
  DoTraverse(traverseData);
}