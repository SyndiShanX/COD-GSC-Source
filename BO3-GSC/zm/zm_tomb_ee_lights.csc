/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_tomb_ee_lights.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#namespace zm_tomb_ee_lights;

function main() {
  clientfield::register("world", "light_show", 21000, 2, "int", &function_b6f5f7f5, 0, 0);
}

function function_b6f5f7f5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  switch (newval) {
    case 1: {
      level.var_fdb98849 = vectorscale((1, 1, 1), 2);
      level.var_656c2f5 = vectorscale((1, 1, 1), 0.25);
      break;
    }
    case 2: {
      level.var_fdb98849 = (2, 0.1, 0.1);
      level.var_656c2f5 = (0.5, 0.1, 0.1);
      break;
    }
    case 3: {
      level.var_fdb98849 = (0.1, 2, 0.1);
      level.var_656c2f5 = (0.1, 0.5, 0.1);
      break;
    }
    default: {
      level.var_fdb98849 = undefined;
      level.var_656c2f5 = undefined;
      break;
    }
  }
}