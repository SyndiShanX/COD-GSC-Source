/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\bouncingbetty.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\util_shared;

#namespace bouncingbetty;

init_shared(localclientnum) {
  level.explode_1st_offset = 55;
  level.explode_2nd_offset = 95;
  level.explode_main_offset = 140;
  level._effect[#"fx_betty_friendly_light"] = #"hash_5f76ecd582d98e38";
  level._effect[#"fx_betty_enemy_light"] = #"hash_330682ff4f12f646";
  level._effect[#"fx_betty_exp"] = #"weapon/fx_betty_exp";
  level._effect[#"fx_betty_exp_death"] = #"weapon/fx_betty_exp_death";
  level._effect[#"fx_betty_launch_dust"] = #"weapon/fx_betty_launch_dust";
  clientfield::register("missile", "bouncingbetty_state", 1, 2, "int", &bouncingbetty_state_change, 0, 0);
  clientfield::register("scriptmover", "bouncingbetty_state", 1, 2, "int", &bouncingbetty_state_change, 0, 0);
}

bouncingbetty_state_change(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(localclientnum);

  if(!isDefined(self)) {
    return;
  }

  switch (newval) {
    case 1:
      self thread bouncingbetty_detonating(localclientnum);
      break;
    case 2:
      self thread bouncingbetty_deploying(localclientnum);
      break;
  }
}

bouncingbetty_deploying(localclientnum) {
  self endon(#"death");
  self useanimtree("generic");
}

bouncingbetty_detonating(localclientnum) {
  self endon(#"death");
  up = anglestoup(self.angles);
  forward = anglesToForward(self.angles);
  playFX(localclientnum, level._effect[#"fx_betty_launch_dust"], self.origin, up, forward);
  self playSound(localclientnum, #"wpn_betty_jump");
  self useanimtree("generic");
  self thread watchforexplosionnotetracks(localclientnum, up, forward);
}

watchforexplosionnotetracks(localclientnum, up, forward) {
  self endon(#"death");

  while(true) {
    notetrack = self waittill(#"explode_1st", #"explode_2nd", #"explode_main");

    switch (notetrack._notify) {
      case #"explode_1st":
        playFX(localclientnum, level._effect[#"fx_betty_exp"], self.origin + up * level.explode_1st_offset, up, forward);
        break;
      case #"explode_2nd":
        playFX(localclientnum, level._effect[#"fx_betty_exp"], self.origin + up * level.explode_2nd_offset, up, forward);
        break;
      case #"explode_main":
        playFX(localclientnum, level._effect[#"fx_betty_exp"], self.origin + up * level.explode_main_offset, up, forward);
        playFX(localclientnum, level._effect[#"fx_betty_exp_death"], self.origin, up, forward);
        break;
      default:
        break;
    }
  }
}