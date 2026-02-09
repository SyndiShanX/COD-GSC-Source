/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\zombie_jump_down_40.gsc
********************************************************/

#include animscripts\utility;
#include animscripts\traverse\zombie_shared;
#using_animtree("generic_human");

main() {
  if(isDefined(self.is_zombie) && self.is_zombie) {
    if(!self.isdog) {
      if(self.animname == "monkey_zombie") {
        jump_down_monkey();
      } else {
        jump_down_zombie();
      }
    } else {
      dog_jump_down(40, 7);
    }
  }
}
jump_down_zombie() {
  traverseData = [];
  traverseData["traverseAnim"] = % ai_zombie_jump_down_40;
  DoTraverse(traverseData);
}
jump_down_monkey() {
  traverseData = [];
  traverseData["traverseAnim"] = % ai_zombie_monkey_jump_down_40;
  DoTraverse(traverseData);
}