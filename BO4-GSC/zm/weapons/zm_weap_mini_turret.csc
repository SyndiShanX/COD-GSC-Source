/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_mini_turret.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\visionset_mgr_shared;

#namespace mini_turret;

autoexec __init__system__() {
  system::register(#"mini_turret", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("vehicle", "mini_turret_open", 1, 1, "int", &turret_open, 0, 0);
}

turret_open(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!newval) {
    return;
  }

  self util::waittill_dobj(localclientnum);

  if(isDefined(self)) {
    self useanimtree("generic");
    self setanimrestart(#"o_turret_mini_deploy", 1, 0, 1);
  }
}