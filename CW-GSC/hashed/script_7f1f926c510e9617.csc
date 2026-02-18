/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_7f1f926c510e9617.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\util;
#namespace namespace_aff1f617;

function function_41e5864f(var_e3087505 = 1) {
  level.var_59cd6d34 = {
    #var_cd7d2e9f: 0, #var_846147d7: 1, #first_time: 1
  };
  function_77051d2b(var_e3087505);
}

function function_77051d2b(var_e3087505 = 1) {
  function_715de8e5(var_e3087505);

  if(!isDefined(level.var_59cd6d34.var_2844be06)) {
    level.var_59cd6d34.var_2844be06 = [];

    for(i = 1; i <= 20; i++) {
      if(var_e3087505) {
        level.var_59cd6d34.var_2844be06["district_" + i] = i - 1;
        continue;
      }

      level.var_59cd6d34.var_2844be06[i - 1] = "district_" + i;
    }
  }
}

function function_715de8e5(var_e3087505) {
  var_e5f80f4e = getmapfields();

  if(isarray(var_e5f80f4e.var_42200354) && var_e5f80f4e.var_42200354.size > 0) {
    if(var_e3087505) {
      level.var_59cd6d34.var_2844be06 = [];

      for(i = 0; i < var_e5f80f4e.var_42200354.size; i++) {
        level.var_59cd6d34.var_2844be06[var_e5f80f4e.var_42200354[i]] = i;
      }

      return;
    }

    level.var_59cd6d34.var_2844be06 = arraycopy(var_e5f80f4e.var_42200354);
  }
}