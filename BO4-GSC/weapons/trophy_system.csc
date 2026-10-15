/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\trophy_system.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\util_shared;

#namespace trophy_system;

init_shared() {
  clientfield::register("missile", "trophy_system_state", 1, 2, "int", &trophy_state_change, 0, 0);
  clientfield::register("scriptmover", "trophy_system_state", 1, 2, "int", &trophy_state_change_recon, 0, 0);
}

trophy_state_change(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (newval) {
    case 1:
      self thread trophy_rolling_anim(localclientnum);
      break;
    case 2:
      self thread trophy_stationary_anim(localclientnum);
      break;
    case 3:
      break;
    case 0:
      break;
  }
}

trophy_state_change_recon(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (newval) {
    case 1:
      self thread trophy_rolling_anim(localclientnum);
      break;
    case 2:
      self thread trophy_stationary_anim(localclientnum);
      break;
    case 3:
      break;
    case 0:
      break;
  }
}

trophy_rolling_anim(localclientnum) {
  self endon(#"death");
  self util::waittill_dobj(localclientnum);
  self useanimtree("generic");
  self setanim(#"p8_fxanim_mp_eqp_trophy_system_world_anim", 1);
}

trophy_stationary_anim(localclientnum) {
  self endon(#"death");
  self util::waittill_dobj(localclientnum);
  self useanimtree("generic");
  self setanim(#"p8_fxanim_mp_eqp_trophy_system_world_anim", 0);
  self setanim(#"p8_fxanim_mp_eqp_trophy_system_world_open_anim", 1);
}