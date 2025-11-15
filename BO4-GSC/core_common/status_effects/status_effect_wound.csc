/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\status_effects\status_effect_wound.csc
**************************************************************/

#namespace status_effect_wound;

function_ea37c549(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval != 0) {
    self thread function_9b4598a4();
    return;
  }

  self thread function_94ce9f97();
}

function_9b4598a4() {}

function_94ce9f97() {}