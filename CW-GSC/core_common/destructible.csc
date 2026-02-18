/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\destructible.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace destructible;

function private autoexec __init__system__() {
  system::register(#"destructible", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("scriptmover", "start_destructible_explosion", 1, 10, "int", &doexplosion, 0, 0);
}

function playgrenaderumble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playrumbleonposition(bwastimejump, "grenade_rumble", self.origin);
  earthquake(bwastimejump, 0.5, 0.5, self.origin, 800);
}

function doexplosion(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 0) {
    return;
  }

  physics_explosion = 0;

  if(bwastimejump & 1 << 9) {
    physics_explosion = 1;
    bwastimejump -= 1 << 9;
  }

  physics_force = 0.3;

  if(physics_explosion && bwastimejump > 0) {
    physicsexplosionsphere(fieldname, self.origin, bwastimejump, bwastimejump - 1, physics_force, 25, 400);
  }

  playgrenaderumble(fieldname, self.origin);
}