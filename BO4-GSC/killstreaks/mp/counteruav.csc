/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\mp\counteruav.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;

#namespace counteruav;

autoexec __init__system__() {
  system::register(#"counteruav", &__init__, undefined, #"killstreaks");
}

__init__() {
  clientfield::register("toplayer", "counteruav", 1, 1, "int", &counteruavchanged, 0, 1);
  level.var_8c4291cb = [];
}

counteruavchanged(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  player = function_5c10bd79(localclientnum);
  assert(isDefined(player));
  player setenemyglobalscrambler(newval);

  if(isDefined(level.var_8c4291cb[localclientnum])) {
    function_d48752e(localclientnum, level.var_8c4291cb[localclientnum], 1);
    level.var_8c4291cb[localclientnum] = undefined;
  }

  if(newval) {
    level.var_8c4291cb[localclientnum] = function_604c9983(localclientnum, "mpl_cuav_static");
  }
}