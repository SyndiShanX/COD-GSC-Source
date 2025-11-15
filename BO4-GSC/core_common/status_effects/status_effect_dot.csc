/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\status_effects\status_effect_dot.csc
************************************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;

#namespace status_effect_dot;

autoexec __init__system__() {
  system::register(#"status_effect_dot", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("toplayer", "dot_splatter", 1, 1, "counter", &on_dot_splatter, 0, 0);
  clientfield::register("toplayer", "dot_no_splatter", 1, 1, "counter", &on_dot_no_splatter, 0, 0);
}

on_dot_splatter(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.dot_damaged = 1;
}

on_dot_no_splatter(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.dot_no_splatter = 1;
}