/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_transformation.csc
***********************************************/

#include scripts\core_common\ai_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace zm_transform;

autoexec __init__system__() {
  system::register(#"zm_transform", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("actor", "transformation_spawn", 1, 1, "int", &function_201c2cb7, 0, 0);
  clientfield::register("actor", "transformation_stream_split", 1, 1, "int", &function_341e5a97, 0, 0);
}

function_201c2cb7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self playrenderoverridebundle(isDefined(self.var_fab3cf78) ? self.var_fab3cf78 : #"hash_435832b390f73dff");
}

function_341e5a97(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    settingsbundle = self ai::function_9139c839();

    if(isDefined(settingsbundle) && isDefined(settingsbundle.var_d354164e)) {
      foreach(var_127d3a7a in settingsbundle.var_d354164e) {
        if(self.model === var_127d3a7a.var_a3c9023c) {
          util::lock_model(var_127d3a7a.var_cdf1f53d);
          self thread function_8a817bd6(var_127d3a7a.var_cdf1f53d);
          break;
        }
      }
    }

    return;
  }

  self notify(#"unlock_model");
}

function_8a817bd6(model) {
  self waittilltimeout(60, #"death", #"unlock_model");
  util::unlock_model(model);
}