/***********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\zombie_zipline_traverse_lighthouse.gsc
***********************************************************************/

#include animscripts\utility;
#include animscripts\traverse\zombie_shared;
#using_animtree("generic_human");
main() {
  if(isDefined(self.is_zombie) && self.is_zombie) {
    if(isDefined(level.scr_anim[self.animname]["zipline_traverse_lighthouse"])) {
      zipline_traverse_lighthouse(level.scr_anim[self.animname]["zipline_traverse_lighthouse"]);
    } else if(self.has_legs == true) {
      zipline_traverse_lighthouse( % ai_zombie_zipline_traverse_lighthouse);
    } else {
      zipline_traverse_lighthouse( % ai_zombie_crawler_zipline_traverse_lighthouse);
    }
  }
}

zipline_traverse_lighthouse(traverse_anim) {
  traverseData = [];
  traverseData["traverseAnim"] = traverse_anim;
  self.is_ziplining = true;
  DoTraverse(traverseData);
  self.is_ziplining = undefined;
}