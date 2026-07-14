/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_4db4e7f305ce5a21.gsc
*****************************************************/

#using script_159e727e83aed322;
#using script_7a5f832593a7dde9;
#namespace reward_cache_settings;

function function_4d826d8eeb27d5c2(bundlename) {
  bundlestruct = getscriptbundle(hashcat(%"rewardcache:", bundlename));

  if(!isDefined(bundlestruct)) {
    assertmsg("<dev string:x24>" + bundlename + "<dev string:x48>");
    return undefined;
  }

  return function_81ad76b69bd5e0df(bundlestruct);
}

function function_81ad76b69bd5e0df(bundlestruct) {
  var_44d8f0ef07a9c55d = bundle_rewardcache::function_690326a0abf579a9(bundlestruct);
  interactionpointscriptablename = bundle_rewardcache::function_424c4be23ba0a468(bundlestruct);
  lootcachescriptablename = bundle_rewardcache::function_19b5902c649fd346(bundlestruct);
  var_f7e52fe99cee5c4f = reward_cache::function_8ecbb0faf9d65732(var_44d8f0ef07a9c55d, 0);
  var_24cf838052cdffc0 = reward_cache::function_8ecbb0faf9d65732(interactionpointscriptablename, 1);
  var_14432df023f04570 = reward_cache::function_8ecbb0faf9d65732(lootcachescriptablename, 2);
  struct = function_20a96ff88a64b8af(bundle_rewardcache::function_d1885980e75f3da4(bundlestruct), bundle_rewardcache::function_5ee0753b0c090dd8(bundlestruct), var_f7e52fe99cee5c4f, var_24cf838052cdffc0, var_14432df023f04570);
  return struct;
}

function function_20a96ff88a64b8af(objectivemarkerbundlename, objectivemarkerzoffset, var_f7e52fe99cee5c4f, var_24cf838052cdffc0, var_14432df023f04570) {
  struct = spawnStruct();
  struct.var_d0b574cdce921bac = 1;
  struct.objectivemarkerbundlename = objectivemarkerbundlename;
  struct.objectivemarkerzoffset = objectivemarkerzoffset;
  struct.var_f7e52fe99cee5c4f = var_f7e52fe99cee5c4f;
  struct.var_24cf838052cdffc0 = var_24cf838052cdffc0;
  struct.var_14432df023f04570 = var_14432df023f04570;
  struct.var_78b821d15cc5da52 = undefined;
  return struct;
}

function getobjectivemarkerbundlename(rewardcachesettings) {
  if(isDefined(rewardcachesettings)) {
    return rewardcachesettings.objectivemarkerbundlename;
  }

  return undefined;
}

function function_90aa538e6aecc690(rewardcachesettings) {
  if(isDefined(rewardcachesettings)) {
    return rewardcachesettings.objectivemarkerzoffset;
  }

  return undefined;
}

function function_d5c8876ac47d4c25(rewardcachesettings) {
  if(isDefined(rewardcachesettings)) {
    return rewardcachesettings.var_f7e52fe99cee5c4f;
  }

  return undefined;
}

function function_674b646615680cde(rewardcachesettings) {
  if(isDefined(rewardcachesettings)) {
    return rewardcachesettings.var_24cf838052cdffc0;
  }

  return undefined;
}

function function_736ba1d975721ace(rewardcachesettings) {
  if(isDefined(rewardcachesettings)) {
    return rewardcachesettings.var_14432df023f04570;
  }

  return undefined;
}

function function_39e6a3ea3837fc28(rewardcachesettings) {
  if(isDefined(rewardcachesettings)) {
    return rewardcachesettings.var_78b821d15cc5da52;
  }

  return undefined;
}

function function_32e3a2ffcaf700fc(rewardcachesettings, boolvaluetoset) {
  if(isDefined(rewardcachesettings)) {
    rewardcachesettings.var_78b821d15cc5da52 = boolvaluetoset;
  }
}

#namespace namespace_a7ab1233794fcbbb;

function function_92a544e324964891(bundlename) {
  bundlestruct = getscriptbundle(hashcat(%"hash_2ad645e0d0c60ba7", bundlename));

  if(!isDefined(bundlestruct)) {
    assertmsg("<dev string:x60>" + bundlename + "<dev string:x48>");
    return undefined;
  }

  return function_da3078bbaf2df9a5(bundlestruct);
}

function function_da3078bbaf2df9a5(var_8beb0c6e90a6bbb3, var_759e99c3b88e050) {
  struct = function_eecb59bb9883d54d(namespace_7cfe88666512c112::function_149284db68d18248(var_8beb0c6e90a6bbb3), namespace_7cfe88666512c112::function_b702351da2536339(var_8beb0c6e90a6bbb3), namespace_7cfe88666512c112::function_aefd4e4d89d8ee8f(var_8beb0c6e90a6bbb3), namespace_7cfe88666512c112::function_9e43d60800bc173a(var_8beb0c6e90a6bbb3), namespace_7cfe88666512c112::function_eee19b152306aca3(var_8beb0c6e90a6bbb3), namespace_7cfe88666512c112::function_6bb519a880b09daa(var_8beb0c6e90a6bbb3), var_759e99c3b88e050);
  return struct;
}

function function_eecb59bb9883d54d(despawndistance, despawntimerseconds, var_d0cf07857479e35a, var_a144e2627df0b66f, objectivemarkervisibilitydistance, spawndelayseconds, var_759e99c3b88e050 = 1) {
  struct = spawnStruct();
  struct.var_9c3dada8c6954f92 = 1;
  struct.despawndistance = despawndistance;
  struct.despawntimerseconds = despawntimerseconds;
  struct.var_d0cf07857479e35a = var_d0cf07857479e35a;
  struct.var_a144e2627df0b66f = var_a144e2627df0b66f;
  struct.objectivemarkervisibilitydistance = objectivemarkervisibilitydistance;
  struct.spawndelayseconds = spawndelayseconds;

  if(var_759e99c3b88e050) {
    function_b1ad1130d84a1849(struct);
  }

  return struct;
}

function getdespawndistance(rewardcachebehaviorsettings) {
  if(isDefined(rewardcachebehaviorsettings)) {
    return rewardcachebehaviorsettings.despawndistance;
  }

  return undefined;
}

function function_bc5e72275cc071c8(rewardcachebehaviorsettings) {
  if(isDefined(rewardcachebehaviorsettings)) {
    return rewardcachebehaviorsettings.despawntimerseconds;
  }

  return undefined;
}

function function_7615e5975e523bf8(rewardcachebehaviorsettings) {
  if(isDefined(rewardcachebehaviorsettings)) {
    return rewardcachebehaviorsettings.var_d0cf07857479e35a;
  }

  return undefined;
}

function function_c10d9e882f218b09(rewardcachebehaviorsettings) {
  if(isDefined(rewardcachebehaviorsettings)) {
    return rewardcachebehaviorsettings.var_a144e2627df0b66f;
  }

  return undefined;
}

function function_7364a2546df6f9ea(rewardcachebehaviorsettings) {
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

function private function_b1ad1130d84a1849(rewardcachebehaviorsettings) {
  function_12fbc2178bc022d0(rewardcachebehaviorsettings);
  function_be05a18fe9f1e441(rewardcachebehaviorsettings);
  function_1558c3977ffa9717(rewardcachebehaviorsettings);
  function_472c6637584c2ff2(rewardcachebehaviorsettings);
  function_bda1ab14e0a34f6b(rewardcachebehaviorsettings);
  function_c097553182276512(rewardcachebehaviorsettings);
}

function private function_bda1ab14e0a34f6b(rewardcachebehaviorsettings) {
  objectivemarkervisibilitydistance = function_7364a2546df6f9ea(rewardcachebehaviorsettings);
  validationcondition = isDefined(objectivemarkervisibilitydistance) && objectivemarkervisibilitydistance > 0;

  if(!validationcondition) {
    reward_cache::function_8abc48b08a4b4075("wr\xfeB\x8f\x8e'\x8e\x8d\x86\x96\xc4\x02\x1e\xbf<\x92\xfa\f\x9d\xe5\xd3]\fAF\t\xd52\xf3\x8c\x1bS\x9a\xbb\xfa\xd6 )\xc1\x06\xea\xcf'Zg&\xe3\xd8\xc4\xd1HZO\xbb``a\x8d\xbcZf\xadj\xcb\x1f:\x8cVUNC\xc1\xf5\xc3\x04" + (objectivemarkervisibilitydistance ?? "\xed\x1d\va\x1e\xf6\xe5\x88\x8a") + "\xec\xb8\xa2\xe3uB\xea\f=\x9f\x7f\xd5\x86\xc0\x01\x8d\xb5\xa7\xfbl" + 7500 + "\xc9\xe3\xc4t\xef\xe7\x7f\xf2f\xafT\x7f\xb4P\n(\xfd\xd3ddo\x85");
    rewardcachebehaviorsettings.objectivemarkervisibilitydistance = 7500;
  }
}

function private function_1558c3977ffa9717(rewardcachebehaviorsettings) {
  var_d0cf07857479e35a = rewardcachebehaviorsettings.var_d0cf07857479e35a;
  validationcondition = isDefined(var_d0cf07857479e35a) && var_d0cf07857479e35a >= 0;

  if(!validationcondition) {
    reward_cache::function_8abc48b08a4b4075("v\xb2\x92\xaf\xee\xb6y\xd0T`\x112V\vg\xd8\b\xd5,\x10\xc3\b\xda\xcc]\xd4j\x1e\xf9\xa8\x80ef\xe3\x81\xf8\x95L\xf8Y\xc2\xddw\xbc\xf0XKc\x9fJ\xb9h-[v\x1f\x19'\xc0\xddN-\x18i\\\xfb\xd5:\xbf" + (var_d0cf07857479e35a ?? "\xed\x1d\va\x1e\xf6\xe5\x88\x8a") + "\xec\xb8\xa2\xe3uB\xea\f=\x9f\x7f\xd5\x86\xc0\x01\x8d\xb5\xa7\xfbl" + 5 + "\xc9\xe3\xc4t\xef\xe7\x7f\xf2f\xafT\x7f\xb4P\n(\xfd\xd3ddo\x85");
    rewardcachebehaviorsettings.var_d0cf07857479e35a = 5;
  }
}

function private function_472c6637584c2ff2(rewardcachebehaviorsettings) {
  var_a144e2627df0b66f = rewardcachebehaviorsettings.var_a144e2627df0b66f;
  validationcondition = isDefined(var_a144e2627df0b66f);

  if(!validationcondition) {
    reward_cache::function_8abc48b08a4b4075("\xa1Y\xb3\x9f\xd4\xfa\x96\xbf%\x94Y\xf8\x9b\xb0\v\xea\xd8\x1b3?1{\xb8=\xb5\xb0\x1aI\x1b\xd1\xda\xc1\x80\xe5\xf3\x93\xf5\xd3\xf6\xfd\x95\x1e\x192\x19\xd3\x0f\xea\xf0\a\xb0\x18uY\x1e\xad\x95*\xd3" + (var_a144e2627df0b66f ?? "\xed\x1d\va\x1e\xf6\xe5\x88\x8a") + "\xec\xb8\xa2\xe3uB\xea\f=\x9f\x7f\xd5\x86\xc0\x01\x8d\xb5\xa7\xfbl" + 0 + "\xc9\xe3\xc4t\xef\xe7\x7f\xf2f\xafT\x7f\xb4P\n(\xfd\xd3ddo\x85");
    rewardcachebehaviorsettings.var_a144e2627df0b66f = 0;
  }
}

function private function_be05a18fe9f1e441(rewardcachebehaviorsettings) {
  despawntimerseconds = rewardcachebehaviorsettings.despawntimerseconds;
  validationcondition = isDefined(despawntimerseconds);

  if(!validationcondition) {
    reward_cache::function_8abc48b08a4b4075("\x96 \xa3\xe1\x1ePO\xff\x826w\x1ewem\xa8D\xfd\xc8\xa7%\xc1\x97\xc9\xc8F\xaf\xf2\x0f@w\x19\x8aQ\xca\x12\xd0\xfd\xd1\xd2\x9d;V\xdb\xdc\b\xe2\n\x16>W\xfc6\x97\xb3H\x8f\x8e\xce\x95\x1f" + (despawntimerseconds ?? "\xed\x1d\va\x1e\xf6\xe5\x88\x8a") + "\xec\xb8\xa2\xe3uB\xea\f=\x9f\x7f\xd5\x86\xc0\x01\x8d\xb5\xa7\xfbl" + 180 + "\xc9\xe3\xc4t\xef\xe7\x7f\xf2f\xafT\x7f\xb4P\n(\xfd\xd3ddo\x85");
    rewardcachebehaviorsettings.despawntimerseconds = 180;
  }
}

function private function_12fbc2178bc022d0(rewardcachebehaviorsettings) {
  despawndistance = rewardcachebehaviorsettings.despawndistance;
  validationcondition = isDefined(despawndistance) && despawndistance > 0;

  if(!validationcondition) {
    reward_cache::function_8abc48b08a4b4075("\xac,\x0fy\x8f\x92\xd6\xde\a\xeb\xd3g9\x8d\xf8\xc8\x8a\x1c\x06\xc7 \xd1\t*B\x1e\xc8Z\xf6_\xe8\xdf7\xc0\xe0M\xe2\xdf\x1d\x14n\x03\xc7\xc5'8g\xedN^\xe3\xb4s\xc8\xba\xab4H" + (despawndistance ?? "\xed\x1d\va\x1e\xf6\xe5\x88\x8a") + "\xec\xb8\xa2\xe3uB\xea\f=\x9f\x7f\xd5\x86\xc0\x01\x8d\xb5\xa7\xfbl" + 12500 + "\xc9\xe3\xc4t\xef\xe7\x7f\xf2f\xafT\x7f\xb4P\n(\xfd\xd3ddo\x85");
    rewardcachebehaviorsettings.despawndistance = 12500;
  }
}

function private function_c097553182276512(rewardcachebehaviorsettings) {
  spawndelayseconds = rewardcachebehaviorsettings.spawndelayseconds;
  validationcondition = isDefined(spawndelayseconds) && spawndelayseconds >= 0;

  if(!validationcondition) {
    reward_cache::function_8abc48b08a4b4075("\x8a\x15=\xdfl\x8b\xd3\xee\x99\xb1\xe8\x96i\xf7\xe1\xd4P\x7f\xfc\xdf\xbdY\x96Y\x80\xcaF\xd4>\xb4\xf3\xfb\xfbN.\xc2\xa4,\x1a\xc7\xa9\x94(\v\x9a\xa7o\x19\xac\xf2\b$U\xbe\x11\xbd\xe6*}r" + (spawndelayseconds ?? "\xed\x1d\va\x1e\xf6\xe5\x88\x8a") + "\xec\xb8\xa2\xe3uB\xea\f=\x9f\x7f\xd5\x86\xc0\x01\x8d\xb5\xa7\xfbl" + 0 + "\xc9\xe3\xc4t\xef\xe7\x7f\xf2f\xafT\x7f\xb4P\n(\xfd\xd3ddo\x85");
    rewardcachebehaviorsettings.spawndelayseconds = 0;
  }
}

#namespace namespace_25b52ebe6ab1a0c8;

function function_3301625bce265892(origin, angles, var_c8dc13cf9f45833a, var_e6e705f002c2f5b2, var_2a6075dd79399649, var_308784ac9f43455d) {
  struct = spawnStruct();
  struct.origin = origin;
  struct.angles = angles;
  struct.var_c8dc13cf9f45833a = var_c8dc13cf9f45833a ?? 0;
  struct.var_e6e705f002c2f5b2 = var_e6e705f002c2f5b2 ?? 100;
  struct.var_2a6075dd79399649 = var_2a6075dd79399649 ?? 1;
  struct.var_308784ac9f43455d = var_308784ac9f43455d ?? 0;
  return struct;
}

function getplacementorigin(rewardcacheplacementstruct) {
  if(isDefined(rewardcacheplacementstruct)) {
    return rewardcacheplacementstruct.origin;
  }

  return undefined;
}

function function_96779bd79cb870df(rewardcacheplacementstruct) {
  if(isDefined(rewardcacheplacementstruct)) {
    return rewardcacheplacementstruct.angles;
  }

  return undefined;
}

function function_dec88be3feef4980(rewardcacheplacementstruct) {
  if(isDefined(rewardcacheplacementstruct)) {
    return rewardcacheplacementstruct.var_c8dc13cf9f45833a;
  }

  return undefined;
}

function function_9006e8a2256e2f54(rewardcacheplacementstruct) {
  if(isDefined(rewardcacheplacementstruct)) {
    return rewardcacheplacementstruct.var_e6e705f002c2f5b2;
  }

  return undefined;
}

function function_acd62d73fa67e5bf(rewardcacheplacementstruct) {
  if(isDefined(rewardcacheplacementstruct)) {
    return rewardcacheplacementstruct.var_2a6075dd79399649;
  }

  return undefined;
}

function function_845160e4c149a4cb(rewardcacheplacementstruct) {
  if(isDefined(rewardcacheplacementstruct)) {
    return rewardcacheplacementstruct.var_308784ac9f43455d;
  }

  return undefined;
}