/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_17dc47fb18ded931.gsc
*************************************************/

#namespace namespace_e81b1392df0afa31;

function function_956d43b7266a97d9(var_f193360d1953ae9d) {
  if(isDefined(var_f193360d1953ae9d)) {
    if(isDefined(var_f193360d1953ae9d.variant_object)) {
      return var_f193360d1953ae9d.variant_object.activityrewardcaches;
    } else {
      return var_f193360d1953ae9d.activityrewardcaches;
    }
  }

  return undefined;
}

function function_e003d240da714433(var_f193360d1953ae9d) {
  if(!isDefined(var_f193360d1953ae9d)) {
    return undefined;
  }

  sharingsettings = var_f193360d1953ae9d.sharingsettings;

  if(!isDefined(sharingsettings)) {
    return undefined;
  }

  if(!isDefined(sharingsettings.var_18bdca8536682038)) {
    return undefined;
  }

  var_18bdca8536682038 = sharingsettings.var_18bdca8536682038.variant_object;
  return var_18bdca8536682038;
}

function function_1a30bd41682cb81f(var_f193360d1953ae9d) {
  parent = function_e003d240da714433(var_f193360d1953ae9d);

  if(isDefined(parent)) {
    return parent.activitycategory;
  }

  return undefined;
}

function function_58747b8d28c68355(var_f193360d1953ae9d) {
  parent = function_e003d240da714433(var_f193360d1953ae9d);

  if(isDefined(parent)) {
    return parent.sharingtype;
  }

  return undefined;
}

#namespace namespace_7ff959e229d749c3;

function function_35f874585c5fcfe6(var_7ff959e229d749c3) {
  parent = function_7f4d2fe53b77e64(var_7ff959e229d749c3);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.rewardcacheassetname;
    } else {
      return parent.rewardcacheassetname;
    }
  }

  return undefined;
}

function function_1864c93384760910(var_7ff959e229d749c3) {
  parent = function_7f4d2fe53b77e64(var_7ff959e229d749c3);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.var_c92e69a2dca65df1;
    } else {
      return parent.var_c92e69a2dca65df1;
    }
  }

  return undefined;
}

function function_a4db25b7af304698(var_7ff959e229d749c3) {
  parent = function_ecc5c444bdd53f44(var_7ff959e229d749c3);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.perplayerloot;
    } else {
      return parent.perplayerloot;
    }
  }

  return undefined;
}

function function_f63abb63847ab316(var_7ff959e229d749c3) {
  parent = function_60b0bbe7909381cc(var_7ff959e229d749c3);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.rewardgrouptype;
    } else {
      return parent.rewardgrouptype;
    }
  }

  return undefined;
}

function function_2dff7e1a10633ee1(var_7ff959e229d749c3) {
  parent = function_7ab0967c42293c5d(var_7ff959e229d749c3);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.rewardspawnlocationtype;
    } else {
      return parent.rewardspawnlocationtype;
    }
  }

  return undefined;
}

function function_5b87e83d21054cb(var_7ff959e229d749c3) {
  parent = function_348abcb1eafd2676(var_7ff959e229d749c3);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.activationname;
    } else {
      return parent.activationname;
    }
  }

  return undefined;
}

function function_f29715a4f86830ed(var_7ff959e229d749c3) {
  parent = function_348abcb1eafd2676(var_7ff959e229d749c3);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.activitymoment;
    } else {
      return parent.activitymoment;
    }
  }

  return undefined;
}

function private function_7f4d2fe53b77e64(var_7ff959e229d749c3) {
  return var_7ff959e229d749c3;
}

function private function_ecc5c444bdd53f44(var_7ff959e229d749c3) {
  parent = function_7f4d2fe53b77e64(var_7ff959e229d749c3);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.rewardgroupoptions;
    } else {
      return parent.rewardgroupoptions;
    }
  }

  return undefined;
}

function private function_60b0bbe7909381cc(var_7ff959e229d749c3) {
  parent = function_ecc5c444bdd53f44(var_7ff959e229d749c3);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.rewardgroupselection;
    } else {
      return parent.rewardgroupselection;
    }
  }

  return undefined;
}

function private function_3fde02830fbb2a02(var_7ff959e229d749c3) {
  parent = function_7f4d2fe53b77e64(var_7ff959e229d749c3);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.spawnlocationoptions;
    } else {
      return parent.spawnlocationoptions;
    }
  }

  return undefined;
}

function private function_7ab0967c42293c5d(var_7ff959e229d749c3) {
  parent = function_3fde02830fbb2a02(var_7ff959e229d749c3);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.rewardspawnlocation;
    } else {
      return parent.rewardspawnlocation;
    }
  }

  return undefined;
}

function private function_55c43278caa4ed7f(var_7ff959e229d749c3) {
  parent = function_7f4d2fe53b77e64(var_7ff959e229d749c3);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.spawnoptions;
    } else {
      return parent.spawnoptions;
    }
  }

  return undefined;
}

function private function_348abcb1eafd2676(var_7ff959e229d749c3) {
  parent = function_55c43278caa4ed7f(var_7ff959e229d749c3);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.spawnactivitymoment;
    } else {
      return parent.spawnactivitymoment;
    }
  }

  return undefined;
}