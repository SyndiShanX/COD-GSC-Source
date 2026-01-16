/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\decoy_grenade.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace decoygrenade;

autoexec __init__system__() {
  system::register(#"decoygrenade", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("missile", "decoy_grenade_footsteps", 1, 1, "int", &function_52b6cd8b, 0, 0);
}

function_52b6cd8b(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue == 1 && newvalue !== oldvalue) {
    self monitor_footsteps(localclientnum);
  }
}

monitor_footsteps(localclientnum) {
  while(clientfield::get("decoy_grenade_footsteps") === 1) {
    self playSound(localclientnum, #"hash_4990634cec4a1aff");
    wait 0.23;
  }
}