/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5f71ed065b9cea1e.gsc
*************************************************/

#using script_3edd0c7a3b472b81;
#using script_6b684505b9959a08;
#using scripts\engine\utility;
#namespace reward_cache_settings;

function function_ec54b8019f59c0ef(bundlename) {
  bundlestruct = getscriptbundle(hashcat(%"rewardcache:", bundlename));

  if(!isDefined(bundlestruct)) {
    assertmsg("<dev string:x1c>" + bundlename + "<dev string:x40>");
    return undefined;
  }

  return function_bc22efd431359bb2(bundlestruct);
}

function function_bc22efd431359bb2(bundlestruct) {
  var_904193de245f0270 = bundle_rewardcache::function_80e85ac92007c6a0(bundlestruct);
  interactionpointscriptablename = bundle_rewardcache::function_c97c6b2daa70a875(bundlestruct);
  lootcachescriptablename = bundle_rewardcache::function_5eb71fb76e2f0f3f(bundlestruct);
  var_ca7c93a8aa8ae096 = reward_cache::function_3ee75bc4270d9687(var_904193de245f0270, 0);
  var_c474f92d8773c359 = reward_cache::function_3ee75bc4270d9687(interactionpointscriptablename, 1);
  var_a8d556aca6e954c9 = reward_cache::function_3ee75bc4270d9687(lootcachescriptablename, 2);
  struct = function_9b26107cdb11c652(bundle_rewardcache::function_5390d04c91335fd1(bundlestruct), bundle_rewardcache::function_b26772b7ec0e7091(bundlestruct), var_ca7c93a8aa8ae096, var_c474f92d8773c359, var_a8d556aca6e954c9);
  return struct;
}

function function_9b26107cdb11c652(objectivemarkerbundlename, objectivemarkerzoffset, var_ca7c93a8aa8ae096, var_c474f92d8773c359, var_a8d556aca6e954c9) {
  struct = spawnStruct();
  struct.var_ca97045f00d9e8d1 = 1;
  struct.objectivemarkerbundlename = objectivemarkerbundlename;
  struct.objectivemarkerzoffset = objectivemarkerzoffset;
  struct.var_ca7c93a8aa8ae096 = var_ca7c93a8aa8ae096;
  struct.var_c474f92d8773c359 = var_c474f92d8773c359;
  struct.var_a8d556aca6e954c9 = var_a8d556aca6e954c9;
  struct.var_f17c677c4e4e37bf = undefined;
  return struct;
}

function getobjectivemarkerbundlename(rewardcachesettings) {
  if(isDefined(rewardcachesettings)) {
    return rewardcachesettings.objectivemarkerbundlename;
  }

  return undefined;
}

function function_ced4245a2bfd6ced(rewardcachesettings) {
  if(isDefined(rewardcachesettings)) {
    return rewardcachesettings.objectivemarkerzoffset;
  }

  return undefined;
}

function function_ed764cfb3d7fa4b8(rewardcachesettings) {
  if(isDefined(rewardcachesettings)) {
    return rewardcachesettings.var_ca7c93a8aa8ae096;
  }

  return undefined;
}

function function_ce8227d6345431bb(rewardcachesettings) {
  if(isDefined(rewardcachesettings)) {
    return rewardcachesettings.var_c474f92d8773c359;
  }

  return undefined;
}

function function_c2eace8af0fb7923(rewardcachesettings) {
  if(isDefined(rewardcachesettings)) {
    return rewardcachesettings.var_a8d556aca6e954c9;
  }

  return undefined;
}

function function_8d8cf89aaa1f6541(rewardcachesettings) {
  if(isDefined(rewardcachesettings)) {
    return rewardcachesettings.var_f17c677c4e4e37bf;
  }

  return undefined;
}

function function_3a6f51417a1eccbd(rewardcachesettings, boolvaluetoset) {
  if(isDefined(rewardcachesettings)) {
    rewardcachesettings.var_f17c677c4e4e37bf = boolvaluetoset;
  }
}

#namespace namespace_81b7e1672a7e54da;

function function_4d6ae01e1e47320c(bundlename) {
  bundlestruct = getscriptbundle(hashcat(%"hash_2ad645e0d0c60ba7", bundlename));

  if(!isDefined(bundlestruct)) {
    assertmsg("<dev string:x58>" + bundlename + "<dev string:x40>");
    return undefined;
  }

  return function_2d81488c136e7154(bundlestruct);
}

function function_2d81488c136e7154(var_3eff889a24d68fb6, var_6e2d453c747f49e5) {
  struct = function_3db94080a2ab11a4(namespace_56c5428a8222c81f::function_1a203db01e2637dd(var_3eff889a24d68fb6), namespace_56c5428a8222c81f::function_750a38717f7e6e94(var_3eff889a24d68fb6), namespace_56c5428a8222c81f::function_f936d1c4ecdbeefe(var_3eff889a24d68fb6), namespace_56c5428a8222c81f::function_c96e29006c55fa8b(var_3eff889a24d68fb6), namespace_56c5428a8222c81f::function_f67c8d5225e081fe(var_3eff889a24d68fb6), namespace_56c5428a8222c81f::function_486b703e2f4725d3(var_3eff889a24d68fb6), var_6e2d453c747f49e5);
  return struct;
}

function function_3db94080a2ab11a4(despawndistance, despawntimerseconds, var_d99131f23781644f, var_dcbc42d7f8d81f9a, objectivemarkervisibilitydistance, spawndelayseconds, var_6e2d453c747f49e5) {
  if(!isDefined(var_6e2d453c747f49e5)) {
    var_6e2d453c747f49e5 = 1;
  }

  struct = spawnStruct();
  struct.var_e87bbb6687a470cb = 1;
  struct.despawndistance = despawndistance;
  struct.despawntimerseconds = despawntimerseconds;
  struct.var_d99131f23781644f = var_d99131f23781644f;
  struct.var_dcbc42d7f8d81f9a = var_dcbc42d7f8d81f9a;
  struct.objectivemarkervisibilitydistance = objectivemarkervisibilitydistance;
  struct.spawndelayseconds = spawndelayseconds;

  if(var_6e2d453c747f49e5) {
    function_641b030c56bf77d8(struct);
  }

  return struct;
}

function getdespawndistance(rewardcachebehaviorsettings) {
  if(isDefined(rewardcachebehaviorsettings)) {
    return rewardcachebehaviorsettings.despawndistance;
  }

  return undefined;
}

function function_ac56ad97c1a63439(rewardcachebehaviorsettings) {
  if(isDefined(rewardcachebehaviorsettings)) {
    return rewardcachebehaviorsettings.despawntimerseconds;
  }

  return undefined;
}

function function_18ff06d7a702f239(rewardcachebehaviorsettings) {
  if(isDefined(rewardcachebehaviorsettings)) {
    return rewardcachebehaviorsettings.var_d99131f23781644f;
  }

  return undefined;
}

function function_7f6409712a4fed0(rewardcachebehaviorsettings) {
  if(isDefined(rewardcachebehaviorsettings)) {
    return rewardcachebehaviorsettings.var_dcbc42d7f8d81f9a;
  }

  return undefined;
}

function function_3ff17248ab8350f3(rewardcachebehaviorsettings) {
  if(isDefined(rewardcachebehaviorsettings)) {
    return rewardcachebehaviorsettings.objectivemarkervisibilitydistance;
  }

  return undefined;
}

function getspawndelayseconds(rewardcachebehaviorsettings) {
  if(isDefined(rewardcachebehaviorsettings)) {
    return rewardcachebehaviorsettings.spawndelayseconds;
  }

  return undefined;
}

function private function_641b030c56bf77d8(rewardcachebehaviorsettings) {
  function_5c44bd40cc4ac46d(rewardcachebehaviorsettings);
  function_b998806646cfb3e4(rewardcachebehaviorsettings);
  function_5fe8a4f9acb31d2e(rewardcachebehaviorsettings);
  function_41abefe8cf6a703b(rewardcachebehaviorsettings);
  function_71b9bce46b3430ae(rewardcachebehaviorsettings);
  function_3e37798d27618d83(rewardcachebehaviorsettings);
}

function private function_71b9bce46b3430ae(rewardcachebehaviorsettings) {
  objectivemarkervisibilitydistance = function_3ff17248ab8350f3(rewardcachebehaviorsettings);
  validationcondition = isDefined(objectivemarkervisibilitydistance) && objectivemarkervisibilitydistance > 0;

  if(!validationcondition) {
    reward_cache::function_1c5f030d48fdff4c("Invalid setting for objectiveMarkerVisibilityDistance. The value cannot be: " + default_to(objectivemarkervisibilitydistance, "undefined") + ". The default value " + 7500 + " will be used instead.");
    rewardcachebehaviorsettings.objectivemarkervisibilitydistance = 7500;
  }
}

function private function_5fe8a4f9acb31d2e(rewardcachebehaviorsettings) {
  var_d99131f23781644f = rewardcachebehaviorsettings.var_d99131f23781644f;
  validationcondition = isDefined(var_d99131f23781644f) && var_d99131f23781644f >= 0;

  if(!validationcondition) {
    reward_cache::function_1c5f030d48fdff4c("Invalid setting for despawnTriggerDelaySeconds. The value cannot be: " + default_to(var_d99131f23781644f, "undefined") + ". The default value " + 5 + " will be used instead.");
    rewardcachebehaviorsettings.var_d99131f23781644f = 5;
  }
}

function private function_41abefe8cf6a703b(rewardcachebehaviorsettings) {
  var_dcbc42d7f8d81f9a = rewardcachebehaviorsettings.var_dcbc42d7f8d81f9a;
  validationcondition = isDefined(var_dcbc42d7f8d81f9a);

  if(!validationcondition) {
    reward_cache::function_1c5f030d48fdff4c("Invalid setting for despawnWhenEmpty. The value cannot be: " + default_to(var_dcbc42d7f8d81f9a, "undefined") + ". The default value " + 0 + " will be used instead.");
    rewardcachebehaviorsettings.var_dcbc42d7f8d81f9a = 0;
  }
}

function private function_b998806646cfb3e4(rewardcachebehaviorsettings) {
  despawntimerseconds = rewardcachebehaviorsettings.despawntimerseconds;
  validationcondition = isDefined(despawntimerseconds);

  if(!validationcondition) {
    reward_cache::function_1c5f030d48fdff4c("Invalid setting for despawnTimerSeconds The value cannot be: " + default_to(despawntimerseconds, "undefined") + ". The default value " + 180 + " will be used instead.");
    rewardcachebehaviorsettings.despawntimerseconds = 180;
  }
}

function private function_5c44bd40cc4ac46d(rewardcachebehaviorsettings) {
  despawndistance = rewardcachebehaviorsettings.despawndistance;
  validationcondition = isDefined(despawndistance) && despawndistance > 0;

  if(!validationcondition) {
    reward_cache::function_1c5f030d48fdff4c("Invalid setting for despawnDistance. The value cannot be: " + default_to(despawndistance, "undefined") + ". The default value " + 12500 + " will be used instead.");
    rewardcachebehaviorsettings.despawndistance = 12500;
  }
}

function private function_3e37798d27618d83(rewardcachebehaviorsettings) {
  spawndelayseconds = rewardcachebehaviorsettings.spawndelayseconds;
  validationcondition = isDefined(spawndelayseconds) && spawndelayseconds >= 0;

  if(!validationcondition) {
    reward_cache::function_1c5f030d48fdff4c("Invalid setting for spawnDelaySeconds. The value cannot be: " + default_to(spawndelayseconds, "undefined") + ". The default value " + 0 + " will be used instead.");
    rewardcachebehaviorsettings.spawndelayseconds = 0;
  }
}

#namespace namespace_6257bf0db64cb539;

function function_facc1b52ce8080fb(origin, angles, var_6c1956fd6ce84917, var_89bf5d052616cfb, var_1844d19221a80eb4, var_c623e4641ebabef0) {
  struct = spawnStruct();
  struct.origin = origin;
  struct.angles = angles;
  struct.var_6c1956fd6ce84917 = default_to(var_6c1956fd6ce84917, 0);
  struct.var_89bf5d052616cfb = default_to(var_89bf5d052616cfb, 100);
  struct.var_1844d19221a80eb4 = default_to(var_1844d19221a80eb4, 1);
  struct.var_c623e4641ebabef0 = default_to(var_c623e4641ebabef0, 0);
  return struct;
}

function getplacementorigin(rewardcacheplacementstruct) {
  if(isDefined(rewardcacheplacementstruct)) {
    return rewardcacheplacementstruct.origin;
  }

  return undefined;
}

function function_5b2e856ac722692e(rewardcacheplacementstruct) {
  if(isDefined(rewardcacheplacementstruct)) {
    return rewardcacheplacementstruct.angles;
  }

  return undefined;
}

function function_f06552e950665aa9(rewardcacheplacementstruct) {
  if(isDefined(rewardcacheplacementstruct)) {
    return rewardcacheplacementstruct.var_6c1956fd6ce84917;
  }

  return undefined;
}

function function_c9f7a7753d62589(rewardcacheplacementstruct) {
  if(isDefined(rewardcacheplacementstruct)) {
    return rewardcacheplacementstruct.var_89bf5d052616cfb;
  }

  return undefined;
}

function function_3a34f98d9ca6c35e(rewardcacheplacementstruct) {
  if(isDefined(rewardcacheplacementstruct)) {
    return rewardcacheplacementstruct.var_1844d19221a80eb4;
  }

  return undefined;
}

function function_79fe8de70e58b32(rewardcacheplacementstruct) {
  if(isDefined(rewardcacheplacementstruct)) {
    return rewardcacheplacementstruct.var_c623e4641ebabef0;
  }

  return undefined;
}