/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_destructible.csc
*************************************************/

#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#namespace destructible;

function autoexec __init__sytem__() {
  system::register("destructible", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "start_destructible_explosion", 1, 11, "int", & doexplosion, 0, 0);
}

function playgrenaderumble(localclientnum, position) {
  playrumbleonposition(localclientnum, "grenade_rumble", position);
  getlocalplayer(localclientnum) earthquake(0.5, 0.5, position, 800);
}

function doexplosion(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 0) {
    return;
  }
  var_824b40e2 = newval & (1 << 10);
  if(var_824b40e2) {
    newval = newval - (1 << 10);
  }
  physics_force = 0.3;
  var_34aa7e9b = newval & (1 << 9);
  if(var_34aa7e9b) {
    physics_force = 0.5;
    newval = newval - (1 << 9);
  }
  if(isDefined(var_824b40e2) && var_824b40e2) {
    physicsexplosionsphere(localclientnum, self.origin, newval, newval / 2, physics_force, 25, 400);
  } else {
    physicsexplosionsphere(localclientnum, self.origin, newval, newval - 1, physics_force, 25, 400);
  }
  playgrenaderumble(localclientnum, self.origin);
  soundrattle(self.origin, 200, 800);
}