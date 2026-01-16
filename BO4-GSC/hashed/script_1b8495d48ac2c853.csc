/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_1b8495d48ac2c853.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace namespace_ba52581a;

autoexec __init__system__() {
  system::register(#"hash_14819f0ef5a24379", &__init__, undefined, undefined);
}

__init__() {
  init_clientfields();
}

init_clientfields() {
  clientfield::register("toplayer", "" + #"hash_7eefa4acee4c1d55", 1, 1, "counter", &function_f90464da, 0, 0);
}

function_f90464da(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(newval) {
    if(isDefined(self)) {
      self playrumbleonentity(localclientnum, #"hash_38a12b73c9342fd9");
    }

    wait 0.3;

    if(isDefined(self)) {
      self playrumbleonentity(localclientnum, #"hash_38a12b73c9342fd9");
    }

    wait 0.3;

    if(isDefined(self)) {
      self playrumbleonentity(localclientnum, #"hash_38a12b73c9342fd9");
    }
  }
}