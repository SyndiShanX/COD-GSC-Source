/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\util\ai_brutus_util.csc
***********************************************/

#include scripts\core_common\ai\archetype_brutus;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\zm\ai\zm_ai_brutus;

#namespace zombie_brutus_util;

autoexec __init__system__() {
  system::register(#"zombie_brutus_util", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("actor", "brutus_lock_down", 1, 1, "int", &function_6f198c81, 0, 0);
}

function_6f198c81(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    return;
  }

  if(bnewent) {
    println("<dev string:x38>");
  }

  if(binitialsnap) {
    println("<dev string:x47>");
  }

  playrumbleonposition(localclientnum, "explosion_generic", self.origin);
}