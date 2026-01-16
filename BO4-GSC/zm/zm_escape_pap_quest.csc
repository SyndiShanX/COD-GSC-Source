/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_escape_pap_quest.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;

#namespace pap_quest;

init() {
  level._effect[#"lightning_near"] = "maps/zm_escape/fx8_pap_lightning_near";
  level._effect[#"lightning_bridge"] = "maps/zm_escape/fx8_pap_lightning_bridge";
  init_clientfield();
}

init_clientfield() {
  clientfield::register("world", "" + #"lightning_far", 1, 1, "counter", &function_5cb90582, 0, 0);
  clientfield::register("scriptmover", "" + #"lightning_near", 1, 1, "counter", &lightning_near_fx, 0, 0);
}

lightning_near_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(self == level) {
    s_lightning_near = struct::get("lightning_near");
    v_origin = s_lightning_near.origin;
  } else {
    v_origin = self.origin;
  }

  playFX(localclientnum, level._effect[#"lightning_near"], v_origin);
}

function_5cb90582(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  s_lightning_bridge = struct::get("lightning_bridge");
  playFX(localclientnum, level._effect[#"lightning_bridge"], s_lightning_bridge.origin, vectornormalize(anglesToForward(s_lightning_bridge.angles)), vectornormalize(anglestoup(s_lightning_bridge.angles)));
}