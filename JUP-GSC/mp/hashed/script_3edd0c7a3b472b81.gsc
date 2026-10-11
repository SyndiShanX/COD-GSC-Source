/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3edd0c7a3b472b81.gsc
*************************************************/

#namespace bundle_rewardcache;

function function_5390d04c91335fd1(bundlestruct_rewardcache) {
  parent = function_3a33f2ddc873def8(bundlestruct_rewardcache);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.objectivemarkerbundle;
    } else {
      return parent.objectivemarkerbundle;
    }
  }

  return undefined;
}

function function_b26772b7ec0e7091(bundlestruct_rewardcache) {
  parent = function_3a33f2ddc873def8(bundlestruct_rewardcache);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.zoffset;
    } else {
      return parent.zoffset;
    }
  }

  return undefined;
}

function function_80e85ac92007c6a0(bundlestruct_rewardcache) {
  parent = function_eb85190cd674b6e8(bundlestruct_rewardcache);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.var_b7f5e040b031e30b;
    } else {
      return parent.var_b7f5e040b031e30b;
    }
  }

  return undefined;
}

function function_c97c6b2daa70a875(bundlestruct_rewardcache) {
  parent = function_eb85190cd674b6e8(bundlestruct_rewardcache);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.interactionpointscriptable;
    } else {
      return parent.interactionpointscriptable;
    }
  }

  return undefined;
}

function function_5eb71fb76e2f0f3f(bundlestruct_rewardcache) {
  parent = function_eb85190cd674b6e8(bundlestruct_rewardcache);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.lootcachescriptable;
    } else {
      return parent.lootcachescriptable;
    }
  }

  return undefined;
}

function private function_8498d448a405d127(bundlestruct_rewardcache) {
  return bundlestruct_rewardcache;
}

function private function_3a33f2ddc873def8(bundlestruct_rewardcache) {
  parent = function_8498d448a405d127(bundlestruct_rewardcache);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.objectivemarkersettings;
    } else {
      return parent.objectivemarkersettings;
    }
  }

  return undefined;
}

function private function_eb85190cd674b6e8(bundlestruct_rewardcache) {
  parent = function_8498d448a405d127(bundlestruct_rewardcache);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.scriptables;
    } else {
      return parent.scriptables;
    }
  }

  return undefined;
}

#namespace namespace_56c5428a8222c81f;

function function_1a203db01e2637dd(var_3eff889a24d68fb6) {
  parent = function_edf5571214ce45d3(var_3eff889a24d68fb6);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.despawndistance;
    } else {
      return parent.despawndistance;
    }
  }

  return undefined;
}

function function_750a38717f7e6e94(var_3eff889a24d68fb6) {
  parent = function_edf5571214ce45d3(var_3eff889a24d68fb6);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.despawntimerseconds;
    } else {
      return parent.despawntimerseconds;
    }
  }

  return undefined;
}

function function_f936d1c4ecdbeefe(var_3eff889a24d68fb6) {
  parent = function_edf5571214ce45d3(var_3eff889a24d68fb6);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.var_d99131f23781644f;
    } else {
      return parent.var_d99131f23781644f;
    }
  }

  return undefined;
}

function function_c96e29006c55fa8b(var_3eff889a24d68fb6) {
  parent = function_edf5571214ce45d3(var_3eff889a24d68fb6);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.var_dcbc42d7f8d81f9a;
    } else {
      return parent.var_dcbc42d7f8d81f9a;
    }
  }

  return undefined;
}

function function_f67c8d5225e081fe(var_3eff889a24d68fb6) {
  parent = function_edf5571214ce45d3(var_3eff889a24d68fb6);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.objectivemarkervisibilitydistance;
    } else {
      return parent.objectivemarkervisibilitydistance;
    }
  }

  return undefined;
}

function function_486b703e2f4725d3(var_3eff889a24d68fb6) {
  parent = function_edf5571214ce45d3(var_3eff889a24d68fb6);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.spawndelayseconds;
    } else {
      return parent.spawndelayseconds;
    }
  }

  return undefined;
}

function private function_cab2244903765611(var_3eff889a24d68fb6) {
  return var_3eff889a24d68fb6;
}

function private function_edf5571214ce45d3(var_3eff889a24d68fb6) {
  parent = function_cab2244903765611(var_3eff889a24d68fb6);

  if(isDefined(parent)) {
    if(isDefined(parent.variant_object)) {
      return parent.variant_object.behaviorsettings;
    } else {
      return parent.behaviorsettings;
    }
  }

  return undefined;
}