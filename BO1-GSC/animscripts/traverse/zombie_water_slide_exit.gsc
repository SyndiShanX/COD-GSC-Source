/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\zombie_water_slide_exit.gsc
************************************************************/

#include animscripts\utility;
#include animscripts\traverse\zombie_shared;
#using_animtree("generic_human");
main() {
  if(isDefined(self.is_zombie) && self.is_zombie) {
    if(self.has_legs == true) {
      if(self.animname == "monkey_zombie") {
        jump_up_monkey();
      } else {
        jump_up_zombie();
      }
    } else {
      jump_up_crawler();
    }
  }
}

jump_up_zombie() {
  traverseData = [];
  traverseData["traverseAnim"] = % ai_zombie_temple_slide_exit;
  DoTraverse(traverseData);
}

jump_up_crawler() {
  traverseData = [];
  traverseData["traverseAnim"] = % ai_zombie_crawl_temple_slide_exit;
  DoTraverse(traverseData);
}

jump_up_monkey() {
  traverseData = [];
  traverseData["traverseAnim"] = % ai_zombie_monkey_temple_slide_exit;
  DoTraverse(traverseData);
}