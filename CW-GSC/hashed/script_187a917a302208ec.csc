/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_187a917a302208ec.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#namespace namespace_98521e8b;

function event_handler[level_init] function_9347830c(eventstruct) {
  clientfield::register("world", "" + # "hash_6789a69336880f89", 10000, 1, "int", &function_e3b277ad, 0, 0);
}

function function_e3b277ad(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    forcestreamxmodel(#"vehicle_t9_mil_us_helicopter_large_mp_intro");
    return;
  }

  stopforcestreamingxmodel(#"vehicle_t9_mil_us_helicopter_large_mp_intro");
}