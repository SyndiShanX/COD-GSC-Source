/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\zm\zm_escape_fast_travel_hellholes.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#namespace fast_travel_hellholes;

init_clientfields() {
  clientfield::register("toplayer", "" + #"hash_275c4e6783b917f8", 1, 1, "int", &function_9997d53a, 0, 0);
}

function_9997d53a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self playrumblelooponentity(localclientnum, "zm_escape_fast_travel");
    return;
  }

  self stoprumble(localclientnum, "zm_escape_fast_travel");
}