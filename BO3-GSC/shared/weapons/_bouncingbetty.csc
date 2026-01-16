/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\weapons\_bouncingbetty.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_weaponobjects;
#using_animtree("bouncing_betty");
#namespace bouncingbetty;

function init_shared(localclientnum) {
  level.explode_1st_offset = 55;
  level.explode_2nd_offset = 95;
  level.explode_main_offset = 140;
  level._effect["fx_betty_friendly_light"] = "weapon/fx_betty_light_blue";
  level._effect["fx_betty_enemy_light"] = "weapon/fx_betty_light_orng";
  level._effect["fx_betty_exp"] = "weapon/fx_betty_exp";
  level._effect["fx_betty_exp_death"] = "weapon/fx_betty_exp_death";
  level._effect["fx_betty_launch_dust"] = "weapon/fx_betty_launch_dust";
  clientfield::register("missile", "bouncingbetty_state", 1, 2, "int", & bouncingbetty_state_change, 0, 0);
  clientfield::register("scriptmover", "bouncingbetty_state", 1, 2, "int", & bouncingbetty_state_change, 0, 0);
}

function bouncingbetty_state_change(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isdefined(self)) {
    return;
  }
  switch (newval) {
    case 1: {
      self thread bouncingbetty_detonating(localclientnum);
      break;
    }
    case 2: {
      self thread bouncingbetty_deploying(localclientnum);
      break;
    }
  }
}

function bouncingbetty_deploying(localclientnum) {
  self endon("entityshutdown");
  self useanimtree($bouncing_betty);
  self setanim( % bouncing_betty::o_spider_mine_deploy, 1, 0, 1);
}

function bouncingbetty_detonating(localclientnum) {
  self endon("entityshutdown");
  up = anglestoup(self.angles);
  forward = anglestoforward(self.angles);
  playfx(localclientnum, level._effect["fx_betty_launch_dust"], self.origin, up, forward);
  self playsound(localclientnum, "wpn_betty_jump");
  self useanimtree($bouncing_betty);
  self setanim( % bouncing_betty::o_spider_mine_detonate, 1, 0, 1);
  self thread watchforexplosionnotetracks(localclientnum, up, forward);
}

function watchforexplosionnotetracks(localclientnum, up, forward) {
  self endon("entityshutdown");
  while (true) {
    notetrack = self util::waittill_any_return("explode_1st", "explode_2nd", "explode_main", "entityshutdown");
    switch (notetrack) {
      case "explode_1st": {
        playfx(localclientnum, level._effect["fx_betty_exp"], self.origin + (up * level.explode_1st_offset), up, forward);
        break;
      }
      case "explode_2nd": {
        playfx(localclientnum, level._effect["fx_betty_exp"], self.origin + (up * level.explode_2nd_offset), up, forward);
        break;
      }
      case "explode_main": {
        playfx(localclientnum, level._effect["fx_betty_exp"], self.origin + (up * level.explode_main_offset), up, forward);
        playfx(localclientnum, level._effect["fx_betty_exp_death"], self.origin, up, forward);
        break;
      }
      default: {
        break;
      }
    }
  }
}