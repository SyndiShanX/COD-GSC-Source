/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_newtonian_negation.csc
********************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_bgb;

#namespace zm_bgb_newtonian_negation;

autoexec __init__system__() {
  system::register(#"zm_bgb_newtonian_negation", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  clientfield::register("world", "newtonian_negation", 1, 1, "int", &function_8622e664, 0, 0);
  bgb::register(#"zm_bgb_newtonian_negation", "time");
}

function_8622e664(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    setdvar(#"phys_gravity_dir", (0, 0, -1));
    self notify(#"end_dynent_touching");
    return;
  }

  setdvar(#"phys_gravity_dir", (0, 0, 1));
  self thread function_e752a980(localclientnum);
}

function_e752a980(localclientnum) {
  self endon(#"end_dynent_touching", #"disconnect");
  var_f42481ac = 0;
  a_dynents = getdynentarray();
  a_corpses = getentarraybytype(localclientnum, 17);
  var_f74f1323 = arraycombine(a_dynents, a_corpses, 1, 0);
  var_f74f1323 = array::randomize(var_f74f1323);

  foreach(var_863ce745 in var_f74f1323) {
    if(!isDefined(var_863ce745)) {
      continue;
    }

    physicsexplosionsphere(localclientnum, var_863ce745.origin, 2, 0, 5, undefined, undefined, 1, 1, 1);
    var_f42481ac++;

    if(var_f42481ac >= 5) {
      waitframe(1);
      var_f42481ac = 0;
    }
  }
}