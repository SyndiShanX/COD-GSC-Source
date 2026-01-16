/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_ee_zombie_bathtub.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;

#namespace namespace_87f097c4;

autoexec __init__system__() {
  system::register(#"hash_7551e984c9a42af9", &__init__, undefined, undefined);
}

__init__() {
  level.var_6e0c26c7 = (isDefined(getgametypesetting(#"hash_30b11d064f146fcc")) ? getgametypesetting(#"hash_30b11d064f146fcc") : 0) || (isDefined(getgametypesetting(#"hash_697d65a68cc6c6f1")) ? getgametypesetting(#"hash_697d65a68cc6c6f1") : 0);

  if(level.var_6e0c26c7) {
    clientfield::register("world", "zombie_arm_blood_splash", 20000, 1, "counter", &zombie_arm_blood_splash, 0, 0);
    clientfield::register("world", "bathtub_fake_soul_sfx", 20000, 1, "counter", &bathtub_fake_soul_sfx, 0, 0);
  }
}

zombie_arm_blood_splash(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  bathtub = struct::get(#"zombie_bathub", "targetname");

  if(isDefined(bathtub)) {
    playFX(localclientnum, #"hash_6e2b2bcea07134d1", bathtub.origin, (0, 0, 1));
  }
}

bathtub_fake_soul_sfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  wait 0.2;
  bathtub = struct::get(#"zombie_bathub", "targetname");

  if(isDefined(bathtub)) {
    playSound(localclientnum, #"zmb_sq_souls_impact", bathtub.origin);
  }
}