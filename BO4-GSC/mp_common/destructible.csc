/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\destructible.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;

#namespace destructible;

autoexec __init__system__() {
  system::register(#"destructible", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("scriptmover", "start_destructible_explosion", 1, 10, "int", &doexplosion, 0, 0);
}

playgrenaderumble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playrumbleonposition(localclientnum, "grenade_rumble", self.origin);
  earthquake(localclientnum, 0.5, 0.5, self.origin, 800);
}

doexplosion(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 0) {
    return;
  }

  physics_explosion = 0;

  if(newval&1 << 9) {
    physics_explosion = 1;
    newval -= 1 << 9;
  }

  physics_force = 0.3;

  if(physics_explosion && newval > 0) {
    physicsexplosionsphere(localclientnum, self.origin, newval, newval - 1, physics_force, 25, 400);
  }

  playgrenaderumble(localclientnum, self.origin);
}