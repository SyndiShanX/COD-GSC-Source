/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\trophy_system.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#namespace trophy_system;

function init_shared() {
  clientfield::register("missile", "" + # "hash_644cb829d0133e99", 1, 1, "int", &function_a485f3cf, 0, 0);
  clientfield::register("missile", "" + # "hash_78a094001c919359", 1, 7, "float", &function_799a68b6, 0, 0);
}

function function_a485f3cf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (bwastimejump) {
    case 1:
      self thread function_82dd67c1(fieldname);
      break;
    case 0:
      self thread function_ce24311a(fieldname);
      break;
  }
}

function function_82dd67c1(localclientnum) {
  self endon(#"death");
  self util::waittill_dobj(localclientnum);
  self useanimtree("generic");
  self setanim(#"hash_70b2041b1f6ad89", 1, 0, 0);
}

function function_ce24311a(localclientnum) {
  self endon(#"death");
  self util::waittill_dobj(localclientnum);
  self useanimtree("generic");
  self setanim(#"hash_70b2041b1f6ad89");
  wait getanimlength(#"hash_70b2041b1f6ad89");

  if(!self hasanimtree()) {
    return;
  }

  self clearanim(#"hash_70b2041b1f6ad89", 0);
  self setanim(#"hash_3c4ee18df7d43dc7", 1, 0, 2);
}

function function_799a68b6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}