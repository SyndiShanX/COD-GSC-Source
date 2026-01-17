/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_destructible.csc
*************************************************/

#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#namespace destructible;

function autoexec __init__sytem__() {
  system::register("destructible", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "start_destructible_explosion", 1, 10, "int", &doexplosion, 0, 0);
}

function playgrenaderumble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playrumbleonposition(localclientnum, "grenade_rumble", self.origin);
  getlocalplayer(localclientnum) earthquake(0.5, 0.5, self.origin, 800);
}

function doexplosion(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 0) {
    return;
  }
  physics_explosion = 0;
  if(newval &(1 << 9)) {
    physics_explosion = 1;
    newval = newval - (1 << 9);
  }
  physics_force = 0.3;
  if(physics_explosion) {
    physicsexplosionsphere(localclientnum, self.origin, newval, newval - 1, physics_force, 25, 400);
  }
  playgrenaderumble(localclientnum, self.origin);
}