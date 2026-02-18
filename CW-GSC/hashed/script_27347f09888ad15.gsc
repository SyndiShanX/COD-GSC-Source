/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_27347f09888ad15.gsc
***********************************************/

#using scripts\core_common\array_shared;
#namespace namespace_679a22ba;

function function_3ba2f5dd(var_693839ad, var_bc631e23) {
  if(!isDefined(level.var_ce15b8c9)) {
    level.var_ce15b8c9 = [];
  }

  level.var_ce15b8c9[var_693839ad] = var_bc631e23;
}

function function_77be8a83(var_e98de867) {
  assert(isDefined(var_e98de867), "<dev string:x38>");
  bundle = getscriptbundle(var_e98de867);
  assert(isDefined(bundle), "<dev string:x73>" + (ishash(var_e98de867) ? function_9e72a96(var_e98de867) : var_e98de867));
  var_89592ba7 = {
    #var_7c88c117: [], #var_b0abb10e: isDefined(bundle.var_d961aeb3) ? bundle.var_d961aeb3 : 0
  };

  foreach(index, var_c1d870ac in bundle.var_210a8489) {
    var_89592ba7.var_7c88c117[index] = {
      #name: isDefined(level.var_ce15b8c9[var_c1d870ac.entryname]) ? level.var_ce15b8c9[var_c1d870ac.entryname] : var_c1d870ac.entryname, #spawned: 0, #var_cffbc08: var_c1d870ac.var_a949845f
    };
  }

  return var_89592ba7;
}

function function_ca209564(var_e98de867, var_ddb02c2b) {
  assert(isDefined(var_e98de867), "<dev string:xa8>");

  if(isDefined(var_e98de867)) {
    var_3561dd4b = getscriptbundle(var_e98de867);
    assert(isDefined(var_3561dd4b), "<dev string:xe6>" + (ishash(var_e98de867) ? function_9e72a96(var_e98de867) : var_e98de867));

    if(isDefined(var_ddb02c2b)) {
      return function_15541865(var_3561dd4b.var_210a8489, var_ddb02c2b.var_7c88c117, 1, var_ddb02c2b.var_b0abb10e);
    }

    return function_15541865(var_3561dd4b.var_210a8489, [], 0);
  }
}

function function_3e7317ca(var_e98de867) {
  assert(isDefined(var_e98de867), "<dev string:xa8>");
  var_3561dd4b = getscriptbundle(var_e98de867);
  assert(isDefined(var_3561dd4b), "<dev string:xe6>" + (ishash(var_e98de867) ? function_9e72a96(var_e98de867) : var_e98de867));
  var_29556c1a = [];
  function_cbafbbab(var_3561dd4b.var_210a8489, var_29556c1a);
  return var_29556c1a;
}

function function_266ee075(var_8452bcb9, var_ddb02c2b) {
  foreach(entry in var_ddb02c2b.var_7c88c117) {
    var_cffbc08 = function_b9ea4226(entry.var_cffbc08, var_ddb02c2b.var_b0abb10e);

    if(entry.name === var_8452bcb9 && var_cffbc08 - entry.spawned > 0) {
      entry.spawned++;
      break;
    }
  }
}

function function_898aced0(var_8452bcb9, var_ddb02c2b) {
  foreach(entry in var_ddb02c2b.var_7c88c117) {
    if(entry.name === var_8452bcb9 && entry.var_cffbc08 > 0) {
      entry.spawned--;
      break;
    }
  }
}

function function_ce65eab6(var_89592ba7) {
  spawned = 0;
  var_cffbc08 = 0;
  infinite = 0;

  foreach(entry in var_89592ba7.var_7c88c117) {
    if(entry.var_cffbc08 == -1) {
      infinite = 1;
    }

    spawned += entry.spawned;
    var_cffbc08 += function_b9ea4226(entry.var_cffbc08, var_89592ba7.var_b0abb10e);
  }

  return {
    #spawned: spawned, #var_cffbc08: infinite ? -1 : var_cffbc08
  };
}

function function_f6a07949(var_89592ba7) {
  var_aeb18f6 = function_ce65eab6(var_89592ba7);
  return var_aeb18f6.var_cffbc08 == -1 || var_aeb18f6.spawned < var_aeb18f6.var_cffbc08;
}

function private function_15541865(&var_8def964, &var_fcfdb752, var_e1be5b85 = 0, var_b0abb10e = 0) {
  var_8452bcb9 = function_622c131e(var_8def964, var_fcfdb752, var_e1be5b85, var_b0abb10e);

  if(!isDefined(var_8452bcb9)) {
    return undefined;
  }

  var_74142af1 = getscriptbundle(var_8452bcb9);

  if(var_74142af1.type === # "survivalailistentry") {
    return_struct = {
      #aitype_name: var_74142af1.var_5fa96b51[randomint(var_74142af1.var_5fa96b51.size)].var_1b48d0fc
    };

    if(var_e1be5b85) {
      return_struct.list_name = var_8452bcb9;
    }

    return return_struct;
  }

  if(!isDefined(var_74142af1.var_210a8489) || var_74142af1.var_210a8489.size == 0) {
    return undefined;
  }

  return_struct = function_15541865(var_74142af1.var_210a8489, var_fcfdb752, 0);

  if(var_e1be5b85) {
    return_struct.list_name = var_8452bcb9;
  }

  return return_struct;
}

function private function_cbafbbab(&var_8def964, &var_bcaf6518) {
  for(index = 0; index < var_8def964.size; index++) {
    entry = var_8def964[index];
    var_8452bcb9 = isDefined(level.var_ce15b8c9[entry.entryname]) ? level.var_ce15b8c9[entry.entryname] : entry.entryname;

    if(!isDefined(var_8452bcb9)) {
      return undefined;
    }

    var_74142af1 = getscriptbundle(var_8452bcb9);

    if(var_74142af1.type === # "survivalailistentry") {
      assert(isDefined(var_74142af1.var_5fa96b51) && var_74142af1.var_5fa96b51.size > 0, "<dev string:x139>");

      foreach(aitype in var_74142af1.var_5fa96b51) {
        name = aitype.var_1b48d0fc;
        array::add(var_bcaf6518, name, 0);
      }

      continue;
    }

    if(!isDefined(var_74142af1.var_210a8489) || var_74142af1.var_210a8489.size == 0) {
      return undefined;
    }

    function_cbafbbab(var_74142af1.var_210a8489, var_bcaf6518);
  }
}

function private function_622c131e(&var_5c120708, &var_fcfdb752, var_e1be5b85, var_b0abb10e) {
  total_weights = 0;
  var_5b34aaca = [];

  for(index = 0; index < var_5c120708.size; index++) {
    entry = var_5c120708[index];
    var_cffbc08 = function_b9ea4226(isDefined(var_fcfdb752[index].var_cffbc08) ? var_fcfdb752[index].var_cffbc08 : 0, var_b0abb10e);

    if(is_true(var_e1be5b85) && isDefined(var_fcfdb752[index]) && !function_9a90dff7(var_fcfdb752[index]) && var_cffbc08 - var_fcfdb752[index].spawned <= 0) {
      continue;
    }

    total_weights += isDefined(entry.var_857deb66) ? entry.var_857deb66 : 0;
    struct = {
      #weight: total_weights, #name: isDefined(level.var_ce15b8c9[entry.entryname]) ? level.var_ce15b8c9[entry.entryname] : entry.entryname
    };
    var_5b34aaca[var_5b34aaca.size] = struct;
  }

  if(!total_weights) {
    return;
  }

  random_weight = randomint(total_weights);

  for(index = 0; index < var_5b34aaca.size; index++) {
    if(random_weight < var_5b34aaca[index].weight) {
      return var_5b34aaca[index].name;
    }
  }
}

function function_b9ea4226(value, scale) {
  count = getplayers().size - 1;

  if(getdvarint(#"hash_4b8ad6985e0ad109", 0) > 0) {
    count = getdvarint(#"hash_4b8ad6985e0ad109", 0) - 1;
  }

  return int(value + value * (isDefined(scale) ? scale : 0) * count);
}

function function_c60389b6(var_e3c68634, var_b0abb10e) {
  count = getplayers().size - 1;

  if(getdvarint(#"hash_718bfcd5ab690a9c", 0) > 0) {
    count = getdvarint(#"hash_718bfcd5ab690a9c", 0) - 1;
  }

  scale = isDefined(var_b0abb10e) ? var_b0abb10e : 0;
  var_693db196 = var_e3c68634.var_cffbc08 + var_e3c68634.var_cffbc08 * scale * count;
  return var_693db196 - var_e3c68634.spawned;
}

function function_9a90dff7(var_e3c68634) {
  return var_e3c68634.var_cffbc08 === -1;
}