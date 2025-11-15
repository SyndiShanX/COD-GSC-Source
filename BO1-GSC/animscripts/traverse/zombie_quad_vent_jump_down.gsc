/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\zombie_quad_vent_jump_down.gsc
***************************************************************/

#include animscripts\utility;
#include animscripts\traverse\zombie_shared;
#using_animtree("generic_human");
main() {
  if(isDefined(self.is_zombie) && self.is_zombie) {
    if(!self.isdog) {
      if(self.has_legs == true) {
        if(self.animname == "quad_zombie") {
          self jump_down_quad();
        }
      }
    }
  }
}

jump_down_quad() {
  traverseData = [];
  traverseData["traverseAnim"] = % ai_zombie_quad_jump_down_vent;
  DoTraverse(traverseData);
  self notify("quad_end_traverse_anim");
}