/************************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\status_effects\status_effect_dot.csc
************************************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace status_effect_dot;

function private autoexec __init__system__() {
  system::register(#"status_effect_dot", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("toplayer", "dot_splatter", 1, 1, "counter", &on_dot_splatter, 0, 0);
  clientfield::register("toplayer", "dot_no_splatter", 1, 1, "counter", &on_dot_no_splatter, 0, 0);
}

function on_dot_splatter(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.dot_damaged = 1;
}

function on_dot_no_splatter(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.dot_no_splatter = 1;
}