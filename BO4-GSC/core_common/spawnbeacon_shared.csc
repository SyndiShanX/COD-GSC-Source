/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\spawnbeacon_shared.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\util_shared;

#namespace spawn_beacon;

init_shared() {
  setupclientfields();
}

setupclientfields() {
  clientfield::register("scriptmover", "spawnbeacon_placed", 1, 1, "int", &spawnbeacon_placed, 0, 0);
  clientfield::register("clientuimodel", "hudItems.spawnbeacon.active", 1, 1, "int", undefined, 0, 0);
}

private spawnbeacon_placed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(localclientnum);

  if(!isDefined(self)) {
    return;
  }

  playtagfxset(localclientnum, "gadget_spawnbeacon_teamlight", self);
  self useanimtree("generic");
  self setanimrestart("o_spawn_beacon_deploy", 1, 0, 1);
}