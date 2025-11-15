/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_mansion_a_skeet_fink.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\zm_common\load;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_pack_a_punch;
#include scripts\zm_common\zm_sq_modules;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_wallbuy;
#include scripts\zm_common\zm_weapons;

#namespace mansion_a_skeet_fink;

init() {
  clientfield::register("world", "" + #"hash_3b4f11e825b1f62b", 8000, 1, "int", &function_5980b4fd, 0, 0);
  clientfield::register("world", "" + #"hash_300ef0a8a2afdab9", 8000, 3, "int", &function_8b09185, 0, 0);
  clientfield::register("world", "" + #"hash_300eefa8a2afd906", 8000, 3, "int", &function_1a723508, 0, 0);
  clientfield::register("world", "" + #"hash_300eeea8a2afd753", 8000, 3, "int", &function_e34446ad, 0, 0);
  clientfield::register("world", "" + #"hash_300eeda8a2afd5a0", 8000, 3, "int", &function_f4fe6a21, 0, 0);
  clientfield::register("world", "" + #"hash_155407a9010f2b23", 8000, 1, "int", &function_1edcfaa9, 0, 0);
  clientfield::register("world", "" + #"hash_70b438bea0135fc8", 8000, 3, "int", &function_860933ea, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_693891d7b7f47419", 8000, 2, "int", &function_813aa911, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_c2169a9806df05e", 8000, 1, "int", &function_4a77ba1b, 0, 0);
  clientfield::register("vehicle", "" + #"hash_7a260c02e8c345c2", 8000, 1, "int", &function_6736abbe, 0, 0);
  clientfield::register("actor", "" + #"hash_7a260c02e8c345c2", 8000, 1, "int", &function_6736abbe, 0, 0);
  clientfield::register("world", "" + #"hash_5f0c4b68b2a6a75d", 16000, 1, "int", &function_36123d34, 0, 0);
  zm_sq_modules::function_d8383812("ee_asf_altar", 1, #"a_skeet_fink_charge", 400, level._effect[#"pap_projectile"], level._effect[#"pap_projectile_end"], undefined, undefined, 1);
  level._effect[#"hash_1a9940efe1d3ed25"] = #"hash_4fc9f92d9016ecad";
  level._effect[#"hash_7cd0c2ae0222691"] = #"hash_4a2a2a8ca5ef4c74";
  level._effect[#"hash_c2169a9806df05e"] = #"hash_34d06e6d2aa00b39";
  level._effect[#"hash_7a260c02e8c345c2"] = #"hash_65d0a2cee07e8664";
}

function_5980b4fd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump) {
  level.var_5e01899a = [];
  level.var_a791c3be = [];
  level.var_97a6ac9f = [];

  for(i = 0; i < 4; i++) {
    level.var_a791c3be[i] = [];
    level.var_a791c3be[i][0] = findvolumedecalindexarray("a_skeet_fink_carvel_0" + i + "_air");
    level.var_a791c3be[i][1] = findvolumedecalindexarray("a_skeet_fink_carvel_0" + i + "_earth");
    level.var_a791c3be[i][2] = findvolumedecalindexarray("a_skeet_fink_carvel_0" + i + "_fire");
    level.var_a791c3be[i][3] = findvolumedecalindexarray("a_skeet_fink_carvel_0" + i + "_water");

    foreach(var_9d4544e1 in level.var_a791c3be[i]) {
      foreach(var_97af50b7 in var_9d4544e1) {
        if(isDefined(var_97af50b7)) {
          hidevolumedecal(var_97af50b7);
        }
      }
    }
  }

  for(i = 0; i < 4; i++) {
    level.var_97a6ac9f[i] = [];
    level.var_97a6ac9f[i][0] = findvolumedecalindexarray("a_skeet_fink_step_2_carvel_0" + i + "_air");
    level.var_97a6ac9f[i][1] = findvolumedecalindexarray("a_skeet_fink_step_2_carvel_0" + i + "_earth");
    level.var_97a6ac9f[i][2] = findvolumedecalindexarray("a_skeet_fink_step_2_carvel_0" + i + "_fire");
    level.var_97a6ac9f[i][3] = findvolumedecalindexarray("a_skeet_fink_step_2_carvel_0" + i + "_water");
    level.var_97a6ac9f[i][4] = findvolumedecalindexarray("a_skeet_fink_step_2_carvel_0" + i + "_slash");

    foreach(var_9d4544e1 in level.var_97a6ac9f[i]) {
      foreach(var_97af50b7 in var_9d4544e1) {
        if(isDefined(var_97af50b7)) {
          hidevolumedecal(var_97af50b7);
        }
      }
    }
  }
}

function_8b09185(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newval) {
    level.var_5e01899a[0] = newval - 1;

    if(isDefined(level.var_a791c3be) && isDefined(level.var_a791c3be[0])) {
      var_1a257ffa = level.var_a791c3be[0][newval - 1];
    }

    if(isDefined(var_1a257ffa) && isarray(var_1a257ffa)) {
      foreach(var_97af50b7 in var_1a257ffa) {
        if(isDefined(var_97af50b7)) {
          unhidevolumedecal(var_97af50b7);
        }
      }
    }

    return;
  }

  foreach(var_9d4544e1 in level.var_a791c3be[0]) {
    foreach(var_97af50b7 in var_9d4544e1) {
      if(isDefined(var_97af50b7)) {
        hidevolumedecal(var_97af50b7);
      }
    }
  }
}

function_1a723508(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newval) {
    level.var_5e01899a[1] = newval - 1;

    if(isDefined(level.var_a791c3be) && isDefined(level.var_a791c3be[1])) {
      var_1a257ffa = level.var_a791c3be[1][newval - 1];
    }

    if(isDefined(var_1a257ffa) && isarray(var_1a257ffa)) {
      foreach(var_97af50b7 in var_1a257ffa) {
        if(isDefined(var_97af50b7)) {
          unhidevolumedecal(var_97af50b7);
        }
      }
    }

    return;
  }

  foreach(var_9d4544e1 in level.var_a791c3be[1]) {
    foreach(var_97af50b7 in var_9d4544e1) {
      if(isDefined(var_97af50b7)) {
        hidevolumedecal(var_97af50b7);
      }
    }
  }
}

function_e34446ad(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newval) {
    level.var_5e01899a[2] = newval - 1;

    if(isDefined(level.var_a791c3be) && isDefined(level.var_a791c3be[2])) {
      var_1a257ffa = level.var_a791c3be[2][newval - 1];
    }

    if(isDefined(var_1a257ffa) && isarray(var_1a257ffa)) {
      foreach(var_97af50b7 in var_1a257ffa) {
        if(isDefined(var_97af50b7)) {
          unhidevolumedecal(var_97af50b7);
        }
      }
    }

    return;
  }

  foreach(var_9d4544e1 in level.var_a791c3be[2]) {
    foreach(var_97af50b7 in var_9d4544e1) {
      if(isDefined(var_97af50b7)) {
        hidevolumedecal(var_97af50b7);
      }
    }
  }
}

function_f4fe6a21(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newval) {
    level.var_5e01899a[3] = newval - 1;

    if(isDefined(level.var_a791c3be) && isDefined(level.var_a791c3be[3])) {
      var_1a257ffa = level.var_a791c3be[3][newval - 1];
    }

    if(isDefined(var_1a257ffa) && isarray(var_1a257ffa)) {
      foreach(var_97af50b7 in var_1a257ffa) {
        if(isDefined(var_97af50b7)) {
          unhidevolumedecal(var_97af50b7);
        }
      }
    }

    return;
  }

  foreach(var_9d4544e1 in level.var_a791c3be[3]) {
    foreach(var_97af50b7 in var_9d4544e1) {
      if(isDefined(var_97af50b7)) {
        hidevolumedecal(var_97af50b7);
      }
    }
  }
}

function_1edcfaa9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(!isDefined(level.var_97a6ac9f)) {
    return;
  }

  if(newval) {
    for(i = 0; i < level.var_97a6ac9f.size; i++) {
      foreach(var_97af50b7 in level.var_97a6ac9f[i][level.var_5e01899a[i]]) {
        if(isDefined(var_97af50b7)) {
          unhidevolumedecal(var_97af50b7);
        }
      }
    }

    return;
  }

  for(i = 0; i < level.var_97a6ac9f.size; i++) {
    foreach(var_9d4544e1 in level.var_97a6ac9f[i]) {
      foreach(var_97af50b7 in var_9d4544e1) {
        if(isDefined(var_97af50b7)) {
          hidevolumedecal(var_97af50b7);
        }
      }
    }
  }
}

function_860933ea(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newval) {
    foreach(var_89319027 in level.var_97a6ac9f[newval - 1][4]) {
      if(isDefined(var_89319027)) {
        unhidevolumedecal(var_89319027);
      }
    }
  }
}

function_813aa911(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump) {
  switch (newval) {
    case 1:
      util::playFXOnTag(localclientnum, level._effect[#"hash_1a9940efe1d3ed25"], self, "tag_origin");
      break;
    case 2:
      util::playFXOnTag(localclientnum, level._effect[#"hash_7cd0c2ae0222691"], self, "tag_origin");
      break;
    default:
      break;
  }
}

function_4a77ba1b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(isDefined(self.var_2dd2a2dd)) {
    stopfx(localclientnum, self.var_2dd2a2dd);
    self.var_2dd2a2dd = undefined;
  }

  if(newval) {
    self.var_2dd2a2dd = util::playFXOnTag(localclientnum, level._effect[#"hash_c2169a9806df05e"], self, "tag_origin");
  }
}

function_6736abbe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newval) {
    util::playFXOnTag(localclientnum, level._effect[#"hash_7a260c02e8c345c2"], self, "j_neck");
  }
}

function_36123d34(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newval) {
    forcestreamxmodel(#"hash_1a8e66a7966f8086");
    return;
  }

  stopforcestreamingxmodel(#"hash_1a8e66a7966f8086");
}