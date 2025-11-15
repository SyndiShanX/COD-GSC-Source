/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\ultimate_turret_shared.csc
**************************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\util_shared;

#namespace ultimate_turret;

init_shared() {
  if(!isDefined(level.var_1427245)) {
    level.var_1427245 = {};
    clientfield::register("vehicle", "ultimate_turret_open", 1, 1, "int", &turret_open, 0, 0);
    clientfield::register("vehicle", "ultimate_turret_init", 1, 1, "int", &turret_init_anim, 0, 0);
    clientfield::register("vehicle", "ultimate_turret_close", 1, 1, "int", &turret_close_anim, 0, 0);
    clientfield::register("clientuimodel", "hudItems.ultimateTurretCount", 1, 3, "int", undefined, 0, 0);
  }
}

turret_init_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!newval) {
    return;
  }

  self endon(#"death");
  self util::waittill_dobj(localclientnum);
  self useanimtree("generic");
  self setanimrestart(#"o_turret_mini_deploy", 1, 0, 1);
  self setanimtime(#"o_turret_mini_deploy", 0);
}

turret_open(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!newval) {
    return;
  }

  self endon(#"death");
  self util::waittill_dobj(localclientnum);
  self useanimtree("generic");
  self setanimrestart(#"o_turret_mini_deploy", 1, 0, 1);
}

turret_close_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!newval) {
    return;
  }

  self useanimtree("generic");
  self setanimrestart(#"o_turret_sentry_close", 1, 0, 1);
}