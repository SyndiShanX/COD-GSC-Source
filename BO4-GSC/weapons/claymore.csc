/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\claymore.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace claymore;

autoexec __init__system__() {
  system::register(#"claymore", &__init__, undefined, undefined);
}

__init__() {
  callback::add_weapon_type(#"claymore", &claymore_spawned);
}

claymore_spawned(localclientnum) {
  self endon(#"death");
  self util::waittill_dobj(localclientnum);

  while(true) {
    if(isDefined(self.stunned) && self.stunned) {
      wait 0.1;
      continue;
    }

    self.claymorelaserfxid = util::playFXOnTag(localclientnum, #"_t6/weapon/claymore/fx_claymore_laser", self, "tag_fx");
    self waittill(#"stunned");
    stopfx(localclientnum, self.claymorelaserfxid);
  }
}