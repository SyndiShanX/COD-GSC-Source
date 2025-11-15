/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\flak_drone.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\duplicaterender_mgr;

#namespace flak_drone;

init_shared() {
  if(!isDefined(level.var_5460023b)) {
    level.var_5460023b = {};
    clientfield::register("vehicle", "flak_drone_camo", 1, 3, "int", &active_camo_changed, 0, 0);
  }
}

active_camo_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  flags_changed = self duplicate_render::set_dr_flag("active_camo_flicker", newval == 2);
  flags_changed = self duplicate_render::set_dr_flag("active_camo_on", 0) || flags_changed;
  flags_changed = self duplicate_render::set_dr_flag("active_camo_reveal", 1) || flags_changed;

  if(flags_changed) {
    self duplicate_render::update_dr_filters(localclientnum);
  }

  self notify(#"endtest");
  self thread doreveal(localclientnum, newval != 0);
}

doreveal(localclientnum, direction) {
  self notify(#"endtest");
  self endon(#"endtest");
  self endon(#"death");

  if(direction) {
    startval = 1;
  } else {
    startval = 0;
  }

  while(startval >= 0 && startval <= 1) {
    self mapshaderconstant(localclientnum, 0, "scriptVector0", startval, 0, 0, 0);

    if(direction) {
      startval -= 0.032;
    } else {
      startval += 0.032;
    }

    waitframe(1);
  }

  flags_changed = self duplicate_render::set_dr_flag("active_camo_reveal", 0);
  flags_changed = self duplicate_render::set_dr_flag("active_camo_on", direction) || flags_changed;

  if(flags_changed) {
    self duplicate_render::update_dr_filters(localclientnum);
  }
}