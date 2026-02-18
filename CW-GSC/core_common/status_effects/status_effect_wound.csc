/**************************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\status_effects\status_effect_wound.csc
**************************************************************/

#namespace status_effect_wound;

function function_ea37c549(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump != 0) {
    self thread function_9b4598a4();
    return;
  }

  self thread function_94ce9f97();
}

function function_9b4598a4() {}

function function_94ce9f97() {}