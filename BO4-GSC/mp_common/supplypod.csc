/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\supplypod.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace supplypod;

autoexec __init__system__() {
  system::register(#"supplypod", &__init__, undefined, #"killstreaks");
}

__init__() {
  clientfield::register("scriptmover", "supplypod_placed", 1, 1, "int", &supplypod_placed, 0, 0);
  clientfield::register("clientuimodel", "hudItems.goldenBullet", 1, 1, "int", undefined, 0, 0);
}

private supplypod_placed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(localclientnum);

  if(!isDefined(self)) {
    return;
  }

  playtagfxset(localclientnum, "gadget_spawnbeacon_teamlight", self);
  self useanimtree("generic");
}