/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_challenges.csc
***********************************************/

#include scripts\core_common\clientfield_shared;

#namespace zm_orange_challenges;

init() {
  clientfield::register("allplayers", "zm_orange_force_challenge_model", 24000, 1, "int", &function_a1d393ad, 0, 0);
  forcestreamxmodel("p8_zm_ora_kitchenware_soup_pot");
}

function

function_a1d393ad(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    forcestreamxmodel(#"p8_zm_gla_heart_zombie");
    return;
  }

  stopforcestreamingxmodel(#"p8_zm_gla_heart_zombie");
}