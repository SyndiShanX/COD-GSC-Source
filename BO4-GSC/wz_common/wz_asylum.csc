/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_asylum.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace wz_asylum;

autoexec __init__system__() {
  system::register(#"wz_asylum", &__init__, undefined, undefined);
}

autoexec __init() {
  level.var_7ad3f6a0 = (isDefined(getgametypesetting(#"hash_3778ec3bd924f17c")) ? getgametypesetting(#"hash_3778ec3bd924f17c") : 0) && (isDefined(getgametypesetting(#"hash_6382d9dfeaeaa0f3")) ? getgametypesetting(#"hash_6382d9dfeaeaa0f3") : 0);
}

__init__() {
  clientfield::register("world", "toilet_ee_play", 19000, 2, "int", &toilet_ee_play, 0, 0);
}

toilet_ee_play(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval > 0) {
    toilet = getdynent(#"asylum_toilet");

    if(isDefined(toilet) && isDefined(toilet.target)) {
      s_sound = struct::get(toilet.target, "targetname");

      switch (newval) {
        case 1:
          playSound(localclientnum, #"hash_563cb1fd34cb48ea", s_sound.origin);
          break;
        case 2:
          playSound(localclientnum, #"hash_30b0e4167d2bd505", s_sound.origin);
          break;
        case 3:
          playSound(localclientnum, #"hash_7672866383ae1956", s_sound.origin);
          break;
      }
    }
  }
}