/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\lightning_chain.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace lightning_chain;

function private autoexec __init__system__() {
  system::register(#"lightning_chain", &init, undefined, undefined, undefined);
}

function init() {
  clientfield::register("actor", "lc_fx", 1, 2, "int", &lc_shock_fx, 0, 1);
  clientfield::register("vehicle", "lc_fx", 1, 2, "int", &lc_shock_fx, 0, 0);
  clientfield::register("actor", "lc_death_fx", 1, 2, "int", &lc_play_death_fx, 0, 0);
  clientfield::register("vehicle", "lc_death_fx", 1, 2, "int", &lc_play_death_fx, 0, 0);
}

function lc_shock_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}

function lc_play_death_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}