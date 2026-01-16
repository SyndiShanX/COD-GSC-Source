/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_hms_util.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;

#namespace zm_hms_util;

autoexec __init__system__() {
  system::register(#"zm_hms_util", &__init__, undefined, undefined);
}

__init__() {

  if(getdvarint(#"hash_79f58c97fc43e423", 0)) {
    callback::on_localplayer_spawned(&function_774b42ac);
  }

}

function_774b42ac() {
  localclientnum = self getlocalclientnumber();

  if(!isDefined(localclientnum)) {
    return;
  }

  while(true) {
    a_ents = getEntArray(localclientnum);
    debug2dtext((5, 1035, 0), "<dev string:x38>" + a_ents.size, (1, 1, 0), 1, (0, 0, 0), 0.5, 1, 30);
    waitframe(30);
  }
}

