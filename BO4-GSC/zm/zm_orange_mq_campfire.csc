/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_mq_campfire.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\util_shared;

#namespace zm_orange_mq_campfire;

preload() {}

campfire_flames(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self.fx_fire = util::playFXOnTag(localclientnum, level._effect[#"campfire_flames"], self, "tag_origin");
  }
}