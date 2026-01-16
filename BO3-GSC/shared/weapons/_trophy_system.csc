/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\weapons\_trophy_system.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_weaponobjects;
#using_animtree("mp_trophy_system");
#namespace trophy_system;

function init_shared(localclientnum) {
  clientfield::register("missile", "trophy_system_state", 1, 2, "int", & trophy_state_change, 0, 1);
  clientfield::register("scriptmover", "trophy_system_state", 1, 2, "int", & trophy_state_change_recon, 0, 0);
}

function trophy_state_change(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isdefined(self)) {
    return;
  }
  switch (newval) {
    case 1: {
      self thread trophy_rolling_anim(localclientnum);
      break;
    }
    case 2: {
      self thread trophy_stationary_anim(localclientnum);
      break;
    }
    case 3: {
      break;
    }
    case 0: {
      break;
    }
  }
}

function trophy_state_change_recon(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isdefined(self)) {
    return;
  }
  switch (newval) {
    case 1: {
      self thread trophy_rolling_anim(localclientnum);
      break;
    }
    case 2: {
      self thread trophy_stationary_anim(localclientnum);
      break;
    }
    case 3: {
      break;
    }
    case 0: {
      break;
    }
  }
}

function trophy_rolling_anim(localclientnum) {
  self endon("entityshutdown");
  self useanimtree($mp_trophy_system);
  self setanim( % mp_trophy_system::o_trophy_deploy, 1);
}

function trophy_stationary_anim(localclientnum) {
  self endon("entityshutdown");
  self useanimtree($mp_trophy_system);
  self setanim( % mp_trophy_system::o_trophy_deploy, 0);
  self setanim( % mp_trophy_system::o_trophy_spin, 1);
}