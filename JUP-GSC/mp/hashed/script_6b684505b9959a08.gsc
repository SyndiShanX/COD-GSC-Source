/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6b684505b9959a08.gsc
*************************************************/

#using script_3a13b8032b62a5e6;
#using script_5f71ed065b9cea1e;
#using script_6d16894933fe11bb;
#using script_756e1a95e0937249;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\objidpoolmanager;
#namespace reward_cache;

function spawnrewardcache(rewardcachesettings, playergroups, placementstruct, func_openlootablecontainer, var_5110040e4247ddb8, lootfunctionargs, func_oncacheitemtaken, func_onitemadded, var_3c99a2a84c4b850f) {
  if(getdvarint(@ "hash_f5047643143a3941", 0) == 1) {
    thread function_30fd5c2bb4199790(rewardcachesettings, playergroups, placementstruct, func_openlootablecontainer, var_5110040e4247ddb8, lootfunctionargs, func_oncacheitemtaken, func_onitemadded, var_3c99a2a84c4b850f);
    return;
  }

  var_4d8d2468e56303c1 = function_2f9979bc854d735d(rewardcachesettings, playergroups, placementstruct, func_openlootablecontainer, var_5110040e4247ddb8, lootfunctionargs, func_oncacheitemtaken, func_onitemadded, var_3c99a2a84c4b850f);

  if(!var_4d8d2468e56303c1.success) {
    function_f269427c9e37c270(var_3c99a2a84c4b850f, 1);
    return;
  }

  lootfunctionargs = var_4d8d2468e56303c1.lootfunctionargs;
  func_oncacheitemtaken = var_4d8d2468e56303c1.func_oncacheitemtaken;
  func_onitemadded = var_4d8d2468e56303c1.func_onitemadded;
  thread function_d5efc18924db80b1(rewardcachesettings, playergroups, placementstruct, func_openlootablecontainer, var_5110040e4247ddb8, lootfunctionargs, func_oncacheitemtaken, func_onitemadded, var_3c99a2a84c4b850f);
}

function cleanuprewardcache(rewardcache) {
  function_e39ee5e9730a31a3(rewardcache);
}

function function_fb4fb51dbc0ad916(rewardcache, player, lootcontents) {
  if(!isrewardcache(rewardcache)) {
    function_e02e37e34dec2042("Could not add loot to player's group reward. Invalid rewardCache!", undefined, player);
    return;
  }

  if(!isPlayer(player)) {
    function_e02e37e34dec2042("Could not add loot to player's group reward. Invalid player!", rewardcache, undefined);
    return;
  }

  if(!function_66808eff13dbe014(lootcontents)) {
    function_e02e37e34dec2042("Could not add loot to player's group reward. Invalid loot contents!", rewardcache, player);
    return;
  }

  grouprewardcache = function_f0c9a03489275ce5(rewardcache, player);

  if(isDefined(grouprewardcache)) {
    function_c848c150de4f73b3(grouprewardcache, lootcontents);
    return;
  }
}

function function_1f4c33cae718bc25(rewardcache, player) {
  if(!isrewardcache(rewardcache)) {
    function_e02e37e34dec2042("Could not add reserved item slot. Invalid rewardCache!", rewardcache, player);
    return -1;
  }

  if(!isPlayer(player)) {
    function_e02e37e34dec2042("Could not add reserved item slot. Invalid player!", rewardcache, player);
    return -1;
  }

  grouprewardcache = function_f0c9a03489275ce5(rewardcache, player);

  if(!isDefined(grouprewardcache)) {
    function_1c5f030d48fdff4c("Could not add reserved item slot. No group reward exists for the player in this reward cache.");
    return -1;
  }

  return function_f64bcd74450424eb(grouprewardcache);
}

function function_77eb3b9f9e4993c6(rewardcache, player, reservedslotindex, item) {
  if(!isrewardcache(rewardcache)) {
    function_e02e37e34dec2042("Could not add item to player group's reserved slot. Invalid rewardCache!", rewardcache, player);
    return;
  }

  if(!isPlayer(player)) {
    function_e02e37e34dec2042("Could not add item to player group's reserved slot. Invalid player!", rewardcache, player);
    return;
  }

  if(!isint(reservedslotindex)) {
    function_e02e37e34dec2042("Could not add item to player group's reserved slot. Reserved slot index is not an integer!", rewardcache, player);
    return;
  }

  if(!function_66808eff13dbe014([item])) {
    function_e02e37e34dec2042("Could not add item to player group's reserved slot. Invalid item!", rewardcache, player);
    return;
  }

  grouprewardcache = function_f0c9a03489275ce5(rewardcache, player);

  if(!isDefined(grouprewardcache)) {
    function_1c5f030d48fdff4c("Could not add item to player group's reserved slot. No group reward exists for the player in this reward cache.", rewardcache, player);
    return;
  }

  if(reservedslotindex >= grouprewardcache.contents.size) {
    function_e02e37e34dec2042("Could not add item to player group's reserved slot. Reserved slot index " + reservedslotindex + " is larger than the cache's contents size!", rewardcache, player);
    return;
  }

  reserveditem = grouprewardcache.contents[reservedslotindex];

  if(!istrue(reserveditem.var_a265da1ac2aef0d5)) {
    function_e02e37e34dec2042("Could not add item to player group's reserved slot. Slot " + reservedslotindex + " is not reserved!", rewardcache, player);
    return;
  }

  item.var_a265da1ac2aef0d5 = 1;
  function_505cfc0b2a049ae3(grouprewardcache, item, reservedslotindex);
}

function isrewardcache(rewardcache) {
  return isstruct(rewardcache) && istrue(rewardcache.isrewardcache);
}

function function_2f75f3a22eb7b56f(grouprewardcache) {
  rewardcache = grouprewardcache.rewardcacheowner;
  nonplayerfound = 0;

  foreach(player in grouprewardcache.playerowners) {
    if(isPlayer(player)) {
      function_baa579f9e5c2a023(rewardcache, player, 2);
      function_dcdfc8710385e1a8(rewardcache, player);
      continue;
    }

    nonplayerfound = 1;
  }

  if(nonplayerfound) {
    function_e882ec9e31af5ae1(rewardcache);
  }
}

function function_49baf487775e6ddb(rewardcache) {
  foreach(grouprewardcache in rewardcache.grouprewardcaches) {
    function_2f75f3a22eb7b56f(grouprewardcache);
  }
}

function function_706b9cce1dad33e3(instance, part, state, player, bautouse, usestring) {
  if(!istrue(instance.var_e377da4c0a8ddb62)) {
    return;
  }

  interactionpoint = instance;
  rewardcache = interactionpoint.rewardcacheowner;
  assert(isDefined(rewardcache));
  function_b4fee1d258d4b097(rewardcache, player);
}

function function_e94f3e14a7107b53(rewardcache, connectedplayer) {
  function_dcb5b533ee36ee85(rewardcache, connectedplayer);
}

function function_511d55926d101fd1(rewardcache, disconnectedplayer) {
  if(!array_contains(rewardcache.playerowners, disconnectedplayer)) {
    return;
  }

  function_9a1e525ce976a312(rewardcache, disconnectedplayer);
  function_8b3827772a6bad4b(rewardcache, disconnectedplayer);

  foreach(grouprewardcache in rewardcache.grouprewardcaches) {
    if(array_contains(grouprewardcache.playerowners, disconnectedplayer)) {
      grouprewardcache.playerowners = array_remove(grouprewardcache.playerowners, disconnectedplayer);
    }
  }

  var_50e4a2b1882ba081 = [];
  var_4a32e78da289b5e6 = undefined;

  foreach(var_dc1cdeb65fa05ec4 in rewardcache.var_b3dc82144db04c75) {
    if(var_dc1cdeb65fa05ec4.playerowner == disconnectedplayer) {
      var_4a32e78da289b5e6 = var_dc1cdeb65fa05ec4;
      continue;
    }

    var_50e4a2b1882ba081[var_50e4a2b1882ba081.size] = var_dc1cdeb65fa05ec4;
  }

  rewardcache.var_b3dc82144db04c75 = var_50e4a2b1882ba081;
  function_c664125500c6946f(var_4a32e78da289b5e6);
}

function function_e882ec9e31af5ae1(rewardcache) {
  function_1cbadf99d0acbfbf(rewardcache);
  var_50e4a2b1882ba081 = [];
  var_4a32e78da289b5e6 = undefined;

  foreach(var_dc1cdeb65fa05ec4 in rewardcache.var_b3dc82144db04c75) {
    if(!isDefined(var_dc1cdeb65fa05ec4.playerowner)) {
      function_c664125500c6946f(var_4a32e78da289b5e6);
      continue;
    }

    var_50e4a2b1882ba081[var_50e4a2b1882ba081.size] = var_dc1cdeb65fa05ec4;
  }

  rewardcache.var_b3dc82144db04c75 = var_50e4a2b1882ba081;
}

function function_f0c9a03489275ce5(rewardcache, player) {
  foreach(grouprewardcache in rewardcache.grouprewardcaches) {
    if(array_contains(grouprewardcache.playerowners, player)) {
      return grouprewardcache;
    }
  }

  return undefined;
}

function isempty(rewardcache) {
  foreach(grouprewardcache in rewardcache.grouprewardcaches) {
    if(!function_baba3a8fbc912f3d(grouprewardcache)) {
      return false;
    }
  }

  return true;
}

function function_baba3a8fbc912f3d(grouprewardcache) {
  contents = default_to(grouprewardcache.contents, []);
  items_remaining = 0;

  foreach(item in contents) {
    items_remaining += item.quantity;
  }

  return items_remaining == 0;
}

function function_4952f5234b065969(rewardcache) {
  return rewardcache.interactionpoint.origin;
}

function function_607b0b2d4d1fadf7(rewardcache) {
  return rewardcache.interactionpoint.angles;
}

function function_de47cfc2f8f4d71d(rewardcache) {
  return array_difference(level.players, getplayerowners(rewardcache));
}

function getplayerowners(rewardcache) {
  return rewardcache.playerowners;
}

function function_b804f364121242d3(rewardcache) {
  return array_difference(getplayerowners(rewardcache), function_f8a89d731386bd1e(rewardcache));
}

function function_f8a89d731386bd1e(rewardcache) {
  return rewardcache.var_aea068c0e66dab61;
}

function private function_30fd5c2bb4199790(rewardcachesettings, playergroups, placementstruct, func_openlootablecontainer, var_5110040e4247ddb8, lootfunctionargs, func_oncacheitemtaken, func_onitemadded, var_3c99a2a84c4b850f) {
  var_26faaa31d0b8f90 = 0;

  if(!isDefined(playergroups) || !isarray(playergroups)) {
    function_f269427c9e37c270(var_3c99a2a84c4b850f, !var_26faaa31d0b8f90);
    function_e02e37e34dec2042("Reward cache could not be spawned. Reason: playerGroups is not an array.");
    return;
  }

  if(!function_e14049204539f02a(placementstruct)) {
    function_f269427c9e37c270(var_3c99a2a84c4b850f, !var_26faaa31d0b8f90);
    function_e02e37e34dec2042("Reward cache could not be spawned. Reason: invalid placement struct (must be a struct with a .origin and .angles property).");
    return;
  }

  if(!isDefined(func_openlootablecontainer) || !isfunction(func_openlootablecontainer)) {
    function_f269427c9e37c270(var_3c99a2a84c4b850f, !var_26faaa31d0b8f90);
    function_e02e37e34dec2042("Reward cache could not be spawned. Reason: openLootableContainer function is undefined or not a function.");
    return;
  }

  if(!isDefined(var_5110040e4247ddb8) || !isfunction(var_5110040e4247ddb8)) {
    function_f269427c9e37c270(var_3c99a2a84c4b850f, !var_26faaa31d0b8f90);
    function_e02e37e34dec2042("Reward cache could not be spawned. Reason: getLootContents function is undefined or not a function.");
    return;
  }

  if(!isDefined(lootfunctionargs)) {
    lootfunctionargs = spawnStruct();
  } else if(!isstruct(lootfunctionargs)) {
    function_f269427c9e37c270(var_3c99a2a84c4b850f, !var_26faaa31d0b8f90);
    function_e02e37e34dec2042("reward cache could not be spawned. Reason: lootFunctionArgs must be a struct");
    return;
  }

  if(isDefined(func_oncacheitemtaken) && !isfunction(func_oncacheitemtaken)) {
    function_469b7ea0b94baae6("func_onCacheItemTaken is defined but is not a function! The reward cache will still spawn but without any onItemTaken functionality.");
    func_oncacheitemtaken = undefined;
  }

  if(isDefined(func_onitemadded) && !isfunction(func_onitemadded)) {
    function_469b7ea0b94baae6("func_onItemAdded is defined but is not a function! The reward cache will still spawn but without any onItemAdded functionality.");
    func_onitemadded = undefined;
  }

  playergrouplootstructs = [];
  spawnorigin = namespace_6257bf0db64cb539::getplacementorigin(placementstruct);
  spawnangles = namespace_6257bf0db64cb539::function_5b2e856ac722692e(placementstruct);

  foreach(playergroup in playergroups) {
    if(!isarray(playergroup)) {
      function_469b7ea0b94baae6("Invalid reward group passed to reward cache. Reward groups must be arrays. The reward cache will continue attempting to spawn but without this malformed reward group.");
      continue;
    }

    if(playergroup.size == 0) {
      continue;
    }

    lootfunctionargs.reward_group = playergroup;
    lootcontents = [[var_5110040e4247ddb8]](lootfunctionargs);
    playergrouplootstructs[playergrouplootstructs.size] = {
      #lootcontents: lootcontents, #playergroup: playergroup
    };
  }

  if(playergrouplootstructs.size == 0) {
    function_f269427c9e37c270(var_3c99a2a84c4b850f, !var_26faaa31d0b8f90);
    function_469b7ea0b94baae6("Reward cache will not be spawned. Reason: playerGroups must contain at least one player");
    return;
  }

  var_6c1956fd6ce84917 = namespace_6257bf0db64cb539::function_f06552e950665aa9(placementstruct);

  if(istrue(var_6c1956fd6ce84917)) {
    function_4eb1ac313bc7d586(playergroups, placementstruct, placementstruct);
    placementstruct waittill("FindNearbySpawnPointGuaranteed_DONE", spawnorigin);
    playergrouplootstructs = function_f434d12840148e1b(playergrouplootstructs);
    var_26faaa31d0b8f90 = 1;
  }

  if(playergrouplootstructs.size == 0) {
    function_f269427c9e37c270(var_3c99a2a84c4b850f, !var_26faaa31d0b8f90);
    function_469b7ea0b94baae6("Reward cache could not be spawned. Reason: No players to spawn the reward cache for. All players in the reward cache's playerGroups were invalid by the time the Reward was spawned (rewards can take 1-8 frames to spawn once the request is made).");
    return;
  }

  rewardcache = function_a5bf382439c269ff(rewardcachesettings, spawnorigin, spawnangles, func_openlootablecontainer, func_oncacheitemtaken, func_onitemadded);

  if(!isDefined(rewardcache)) {
    function_f269427c9e37c270(var_3c99a2a84c4b850f, !var_26faaa31d0b8f90);
    function_e02e37e34dec2042("Reward cache could not be spawned. Reason: failed to create reward cache struct. See log for details.");
    return;
  }

  success = function_aab44fb14323f306(rewardcache, playergrouplootstructs);

  if(!success) {
    cleanuprewardcache(rewardcache);
    function_e02e37e34dec2042("Reward cache could not be spawned. Reason: unable to add reward groups. This could be a problem with the reward group or the loot function for this reward cache returning malformed loot for the group. See log for details.");
    return;
  }

  function_445350567fa2042c(rewardcache);

  if(isDefined(var_3c99a2a84c4b850f)) {
    if(!var_26faaa31d0b8f90) {
      waitframe();
    }

    var_3c99a2a84c4b850f notify("reward_cache_spawn_done", rewardcache);
  }

  function_5769976c6051f91b(rewardcache);
}

function private function_d5efc18924db80b1(rewardcachesettings, playergroups, placementstruct, func_openlootablecontainer, var_5110040e4247ddb8, lootfunctionargs, func_oncacheitemtaken, func_onitemadded, var_3c99a2a84c4b850f) {
  var_26faaa31d0b8f90 = 0;
  spawnangles = namespace_6257bf0db64cb539::function_5b2e856ac722692e(placementstruct);
  spawnoriginworkresult = function_4a71c5cd075ec3d3();
  var_48924e1f05b1e588 = function_4a71c5cd075ec3d3();
  thread function_8f0ea7b45a92fe4c(spawnoriginworkresult, playergroups, placementstruct);
  thread function_4d1ed1e796e9b5fb(var_48924e1f05b1e588, playergroups, var_5110040e4247ddb8, lootfunctionargs);
  workresults = [spawnoriginworkresult, var_48924e1f05b1e588];
  frameswaited = 0;

  while(!function_9b4ae88527b27180(workresults)) {
    waitframe();
    var_26faaa31d0b8f90 = 1;
    frameswaited++;

    if(getdvarint(@ "hash_94f4c6adf1621cb4", 0) != 1) {
      function_1c972fc13937297c("Spawning Over Time: Waiting for loot and spawn origin to be computed (waited for " + frameswaited + " frames so far)");
    }
  }

  function_1c972fc13937297c("Spawning Over Time: Loot and spawn origin ready (took " + frameswaited + " frames total)");

  if(function_715bc45d25964e75(workresults)) {
    function_f269427c9e37c270(var_3c99a2a84c4b850f, !var_26faaa31d0b8f90);
    return;
  }

  playergrouplootstructs = var_48924e1f05b1e588.resultobject;
  spawnorigin = spawnoriginworkresult.resultobject;
  playergrouplootstructs = function_f434d12840148e1b(playergrouplootstructs);

  if(playergrouplootstructs.size == 0) {
    function_f269427c9e37c270(var_3c99a2a84c4b850f, !var_26faaa31d0b8f90);
    function_469b7ea0b94baae6("Reward cache could not be spawned. Reason: No players to spawn the reward cache for. All players in the reward cache's playerGroups were invalid by the time the Reward was ready to spawn (rewards can take 1-8 frames to spawn once the request is made).");
    return;
  }

  rewardcache = function_a5bf382439c269ff(rewardcachesettings, spawnorigin, spawnangles, func_openlootablecontainer, func_oncacheitemtaken, func_onitemadded);

  if(!isDefined(rewardcache)) {
    function_f269427c9e37c270(var_3c99a2a84c4b850f, !var_26faaa31d0b8f90);
    function_e02e37e34dec2042("Reward cache could not be spawned. Reason: failed to create reward cache struct. See log for details.");
    return;
  }

  success = function_aab44fb14323f306(rewardcache, playergrouplootstructs);

  if(!success) {
    cleanuprewardcache(rewardcache);
    function_e02e37e34dec2042("Reward cache could not be spawned. Reason: unable to add reward groups. This could be a problem with the reward group or the loot function for this reward cache returning malformed loot for the group. See log for details.");
    return;
  }

  function_445350567fa2042c(rewardcache);
  function_da28992467528c6(var_3c99a2a84c4b850f, rewardcache, !var_26faaa31d0b8f90);
  function_5769976c6051f91b(rewardcache);
}

function private function_da28992467528c6(var_26a8fe3c4a4bc8ae, rewardcache, var_def3787b33084fb9) {
  if(isDefined(var_26a8fe3c4a4bc8ae)) {
    if(var_def3787b33084fb9) {
      waitframe();
    }

    var_26a8fe3c4a4bc8ae notify("reward_cache_spawn_done", rewardcache);
  }
}

function private function_f269427c9e37c270(var_26a8fe3c4a4bc8ae, var_def3787b33084fb9) {
  if(isDefined(var_26a8fe3c4a4bc8ae)) {
    if(istrue(var_def3787b33084fb9)) {
      waitframe();
    }

    var_26a8fe3c4a4bc8ae notify("reward_cache_spawn_done", undefined);
  }
}

function private function_eccb22c0a7e7f691(rewardcache, players, contents) {
  if(!function_ae3199d790b1588a(players)) {
    function_469b7ea0b94baae6(" Reward group could not be added to the reward cache. Reason: the specified reward group is not an array of players.");
    return 0;
  }

  if(!function_66808eff13dbe014(contents)) {
    function_469b7ea0b94baae6(" Reward group could not be added to the reward cache. Reason: the loot contents returned by the cache's loot generate function are not valid. The loot function must return an array of structs with a .lootId and .quantity property.");
    return 0;
  }

  grouprewardcache = function_98e8ea9283c5db42(rewardcache, players, contents);

  if(isDefined(grouprewardcache)) {
    rewardcache.grouprewardcaches[rewardcache.grouprewardcaches.size] = grouprewardcache;
  } else {
    function_469b7ea0b94baae6(" Reward group could not be added to the reward cache. Reason: unable to spawn groupRewardCache struct (also referred to as the lootCache). See log for details.");
    return 0;
  }

  var_e40e14559fdd8f71 = 1;

  foreach(player in grouprewardcache.playerowners) {
    function_deeda1af884e33ab(rewardcache, player);
    success = function_4269532b2cd3272e(rewardcache, player);

    if(!success) {
      function_469b7ea0b94baae6(" Failed to create client visual cache for a player in the reward group. See log for details.");
      var_e40e14559fdd8f71 = 0;
    }
  }

  return var_e40e14559fdd8f71;
}

function private function_aab44fb14323f306(rewardcache, playergrouplootstructs) {
  foreach(playergrouplootstruct in playergrouplootstructs) {
    playergroup = playergrouplootstruct.playergroup;
    lootcontents = playergrouplootstruct.lootcontents;
    success = function_eccb22c0a7e7f691(rewardcache, playergroup, lootcontents);

    if(!success) {
      return false;
    }
  }

  return true;
}

function private function_4eb1ac313bc7d586(playergroups, placementstruct, var_8dd4051dae605f66) {
  spawnposition = namespace_6257bf0db64cb539::getplacementorigin(placementstruct);
  searchradius = namespace_6257bf0db64cb539::function_c9f7a7753d62589(placementstruct);
  var_8542b7103ded25cc = namespace_6257bf0db64cb539::function_3a34f98d9ca6c35e(placementstruct);
  var_5f32f9c3f5685477 = namespace_6257bf0db64cb539::function_79fe8de70e58b32(placementstruct);
  var_e14eaea3c7dcd934 = function_575a0d160a23ff42(playergroups);
  var_c921b7b980aae8e6 = namespace_7e4700be8ab64610::function_1ccac97aaa70e4cc(var_8542b7103ded25cc, var_5f32f9c3f5685477, var_e14eaea3c7dcd934);
  var_46f55e79bf424ab3 = namespace_7e4700be8ab64610::function_48d03a548cabbbaa();
  namespace_7e4700be8ab64610::findnearbyspawnpointguaranteed(spawnposition, searchradius, var_c921b7b980aae8e6, var_46f55e79bf424ab3, var_8dd4051dae605f66);
}

function private function_575a0d160a23ff42(playergroups) {
  var_f5b15eff9acb82e1 = array_random(playergroups);
  var_e14eaea3c7dcd934 = array_random(var_f5b15eff9acb82e1);
  return var_e14eaea3c7dcd934;
}

function private function_905acacd2e23179d(rewardcache, parent, offset, angles, var_e792568a60aaaae7) {
  if(default_to(var_e792568a60aaaae7, 1)) {
    thread function_33f66492eeb1f475(rewardcache);
  }

  allscriptables = function_5575eec2f593d3eb(rewardcache);

  foreach(scriptable in allscriptables) {
    scriptable scriptable_setparententity(parent, offset, angles);
  }
}

function private function_5575eec2f593d3eb(rewardcache) {
  scriptables = [rewardcache.interactionpoint];

  foreach(grouprewardcache in rewardcache.grouprewardcaches) {
    scriptables[scriptables.size] = grouprewardcache;
  }

  foreach(var_dc1cdeb65fa05ec4 in rewardcache.var_b3dc82144db04c75) {
    scriptables[scriptables.size] = var_dc1cdeb65fa05ec4;
  }

  return scriptables;
}

function private function_deeda1af884e33ab(rewardcache, player) {
  rewardcache.playerowners = function_6d6af8144a5131f1(rewardcache.playerowners, player);
}

function private function_9a1e525ce976a312(rewardcache, player) {
  rewardcache.playerowners = array_remove(rewardcache.playerowners, player);
}

function private function_1cbadf99d0acbfbf(rewardcache) {
  rewardcache.playerowners = array_removeundefined(rewardcache.playerowners);
  rewardcache.var_aea068c0e66dab61 = array_removeundefined(rewardcache.var_aea068c0e66dab61);
}

function private function_dcdfc8710385e1a8(rewardcache, player) {
  rewardcache.var_aea068c0e66dab61[rewardcache.var_aea068c0e66dab61.size] = player;
}

function private function_8b3827772a6bad4b(rewardcache, player) {
  rewardcache.var_aea068c0e66dab61 = array_remove(rewardcache.var_aea068c0e66dab61, player);
}

function private function_a5bf382439c269ff(rewardcachesettings, origin, angles, func_openlootablecontainer, func_oncacheitemtaken, func_onitemadded) {
  rewardcache = spawnStruct();
  rewardcache.isrewardcache = 1;
  rewardcache.settings = rewardcachesettings;
  rewardcache.func_openlootablecontainer = func_openlootablecontainer;
  rewardcache.func_oncacheitemtaken = func_oncacheitemtaken;
  rewardcache.func_onitemadded = func_onitemadded;
  rewardcache.objectivemarkerid = function_7a33191e3c13b5ce(rewardcachesettings, origin);
  rewardcache.interactionpoint = function_eb0c6a46ce634c52(rewardcache, origin, angles);

  if(!isDefined(rewardcache.interactionpoint)) {
    function_469b7ea0b94baae6("The reward cache struct could not be created. Reason: Unable to spawn reward cache interaction point.");
    return undefined;
  }

  rewardcache.grouprewardcaches = [];
  rewardcache.var_b3dc82144db04c75 = [];
  rewardcache.playerowners = [];
  rewardcache.var_aea068c0e66dab61 = [];
  return rewardcache;
}

function private function_e39ee5e9730a31a3(rewardcache) {
  rewardcache notify("cleanup");
  rewardcache endon("cleanup");

  foreach(grouprewardcache in rewardcache.grouprewardcaches) {
    function_b44cac31aed153a6(grouprewardcache);
  }

  foreach(var_dc1cdeb65fa05ec4 in rewardcache.var_b3dc82144db04c75) {
    function_c664125500c6946f(var_dc1cdeb65fa05ec4);
  }

  function_bce8631f36bc1cd6(rewardcache.interactionpoint);
  function_5e776c4debd7a058(rewardcache.objectivemarkerid);
}

function private function_98e8ea9283c5db42(rewardcacheowner, players, cachecontents) {
  var_a8d556aca6e954c9 = reward_cache_settings::function_c2eace8af0fb7923(rewardcacheowner.settings);
  origin = function_4952f5234b065969(rewardcacheowner);
  angles = function_607b0b2d4d1fadf7(rewardcacheowner);
  var_a8d556aca6e954c9 = function_e050b08db44e0d63(var_a8d556aca6e954c9, origin, angles);

  if(!function_8e8b8d36cec59a9f(var_a8d556aca6e954c9, 2, 1)) {
    function_469b7ea0b94baae6("<dev string:x1c>");
    function_1d23a5c9faafcf44(var_a8d556aca6e954c9);
    return undefined;
  }

  grouprewardcache = var_a8d556aca6e954c9;
  grouprewardcache.var_4fb72376c6665823 = 1;
  grouprewardcache.rewardcacheowner = rewardcacheowner;
  grouprewardcache.contents = [];
  grouprewardcache.func_oncacheitemtaken = rewardcacheowner.func_oncacheitemtaken;
  grouprewardcache.onitemtaken = &function_6edbc34f275777ce;
  grouprewardcache.func_onitemadded = rewardcacheowner.func_onitemadded;
  grouprewardcache.playerowners = players;
  grouprewardcache.currentopener = undefined;
  function_c848c150de4f73b3(grouprewardcache, cachecontents, 1);
  thread function_db0a8fab5ff7bd4d(grouprewardcache);
  return grouprewardcache;
}

function private function_b44cac31aed153a6(grouprewardcache) {
  grouprewardcache notify("cleanup");
  function_1d23a5c9faafcf44(grouprewardcache);
}

function private function_b4fee1d258d4b097(rewardcache, player) {
  grouprewardcache = function_f0c9a03489275ce5(rewardcache, player);

  if(isDefined(grouprewardcache)) {
    function_a1537ccc9badee51(grouprewardcache, player);
    argsstruct = spawnStruct();
    argsstruct.cache = grouprewardcache;
    argsstruct.player = player;
    [[rewardcache.func_openlootablecontainer]](argsstruct);
  }
}

function private function_c848c150de4f73b3(grouprewardcache, newcontents, var_511ac4f652abd05) {
  if(!isDefined(var_511ac4f652abd05)) {
    var_511ac4f652abd05 = 0;
  }

  if(isDefined(newcontents) && isarray(newcontents)) {
    foreach(item in newcontents) {
      containerindex = grouprewardcache.contents.size;
      function_505cfc0b2a049ae3(grouprewardcache, item, containerindex, var_511ac4f652abd05);
    }
  }
}

function private function_f64bcd74450424eb(grouprewardcache) {
  newcontents = [];
  reserveditem = spawnStruct();
  reserveditem.var_a265da1ac2aef0d5 = 1;
  reserveditem.lootid = 0;
  reserveditem.quantity = 0;
  reserveditemslotindex = grouprewardcache.contents.size;
  grouprewardcache.contents[reserveditemslotindex] = reserveditem;
  return reserveditemslotindex;
}

function private function_505cfc0b2a049ae3(grouprewardcache, item, index, var_511ac4f652abd05) {
  if(!isDefined(var_511ac4f652abd05)) {
    var_511ac4f652abd05 = 0;
  }

  grouprewardcache.contents[index] = item;

  if(!var_511ac4f652abd05 && isDefined(grouprewardcache.func_onitemadded)) {
    argsstruct = function_1302487d62106118(grouprewardcache, item.lootid, item.quantity, index, grouprewardcache.currentopener);
    [[grouprewardcache.func_onitemadded]](argsstruct);
  }
}

function private function_1302487d62106118(grouprewardcache, lootid, quantity, containerindex, currentopener) {
  return {
    #currentopener: currentopener, #containerindex: containerindex, #quantity: quantity, #lootid: lootid, #grouprewardcache: grouprewardcache
  };
}

function private function_d1b4513090f45cdc(grouprewardcache) {
  newcontents = [];

  foreach(item in grouprewardcache.contents) {
    var_e34b60eaffd24b88 = isDefined(item) && item.lootid != 0;
    var_1642a4d4e85cd1e2 = isDefined(item.quantity) && item.quantity != 0;

    if(var_e34b60eaffd24b88 && var_1642a4d4e85cd1e2) {
      newcontents[newcontents.size] = item;
    }
  }

  grouprewardcache.contents = newcontents;
}

function private function_db0a8fab5ff7bd4d(grouprewardcache) {
  grouprewardcache endon("cleanup");

  while(true) {
    grouprewardcache waittill("closed");
    function_5fb98fd5d29f8228(grouprewardcache);
  }
}

function private function_a1537ccc9badee51(grouprewardcache, player) {
  function_4311ace6b3e80b79(grouprewardcache);
  rewardcache = grouprewardcache.rewardcacheowner;
  var_9ae49f75af0eca8e = function_8839eccded74a214(rewardcache, player);
  function_fa331a2fee762f38(var_9ae49f75af0eca8e);
  grouprewardcache.currentopener = player;
}

function private function_5fb98fd5d29f8228(grouprewardcache) {
  function_e4e096fea63298b7(grouprewardcache);
  function_a39a190621095d86(grouprewardcache);
  grouprewardcache.currentopener = undefined;
}

function private function_6edbc34f275777ce(grouprewardcache, player) {
  rewardcache = grouprewardcache.rewardcacheowner;

  foreach(player in grouprewardcache.playerowners) {
    var_9ae49f75af0eca8e = function_8839eccded74a214(rewardcache, player);
    function_c6d16a48482b75c1(var_9ae49f75af0eca8e);
  }

  if(isDefined(grouprewardcache.func_oncacheitemtaken)) {
    [[grouprewardcache.func_oncacheitemtaken]](grouprewardcache, player);
  }
}

function private function_a39a190621095d86(grouprewardcache) {
  if(function_61e37af5c53d40e3(grouprewardcache)) {
    currentopener = grouprewardcache.currentopener;
    rewardcache = grouprewardcache.rewardcacheowner;
    var_9ae49f75af0eca8e = function_8839eccded74a214(rewardcache, currentopener);
    function_81010148cb67c61d(var_9ae49f75af0eca8e);
  }
}

function private function_61e37af5c53d40e3(grouprewardcache) {
  currentopener = grouprewardcache.currentopener;

  if(!isPlayer(currentopener)) {
    return false;
  }

  rewardcache = grouprewardcache.rewardcacheowner;
  var_9f2beef71cb8b388 = reward_cache_settings::function_8d8cf89aaa1f6541(rewardcache.settings);

  if(!istrue(var_9f2beef71cb8b388)) {
    if(function_baba3a8fbc912f3d(grouprewardcache)) {
      return false;
    }
  }

  return true;
}

function private function_4311ace6b3e80b79(grouprewardcache) {
  rewardcache = grouprewardcache.rewardcacheowner;

  foreach(player in grouprewardcache.playerowners) {
    if(function_4797f19e0b2e0547(rewardcache, player) == 0) {
      function_b4dbfe49ef9b3109(rewardcache, player);
    }
  }
}

function private function_e4e096fea63298b7(grouprewardcache) {
  rewardcache = grouprewardcache.rewardcacheowner;

  foreach(player in grouprewardcache.playerowners) {
    if(function_4797f19e0b2e0547(rewardcache, player) == 0) {
      function_1399f8c48b16a218(rewardcache, player);
    }
  }
}

function private function_eb0c6a46ce634c52(rewardcacheowner, origin, angles) {
  var_c474f92d8773c359 = reward_cache_settings::function_ce8227d6345431bb(rewardcacheowner.settings);
  scriptable_interactionpoint = function_e050b08db44e0d63(var_c474f92d8773c359, origin, angles);

  if(!function_8e8b8d36cec59a9f(scriptable_interactionpoint, 1, 1)) {
    function_1d23a5c9faafcf44(scriptable_interactionpoint);
    function_469b7ea0b94baae6("<dev string:x7d>");
    return undefined;
  }

  interactionpoint = scriptable_interactionpoint;
  interactionpoint.var_e377da4c0a8ddb62 = 1;
  interactionpoint.rewardcacheowner = rewardcacheowner;
  return interactionpoint;
}

function private function_bce8631f36bc1cd6(interactionpoint) {
  function_1d23a5c9faafcf44(interactionpoint);
}

function private function_d50b9d11c2d587eb(rewardcacheowner, playerowner) {
  var_ca7c93a8aa8ae096 = reward_cache_settings::function_ed764cfb3d7fa4b8(rewardcacheowner.settings);
  origin = function_4952f5234b065969(rewardcacheowner);
  angles = function_607b0b2d4d1fadf7(rewardcacheowner);
  var_9ae49f75af0eca8e = function_e050b08db44e0d63(var_ca7c93a8aa8ae096, origin, angles, playerowner);

  if(!function_8e8b8d36cec59a9f(var_9ae49f75af0eca8e, 0, 1)) {
    function_1d23a5c9faafcf44(var_9ae49f75af0eca8e);
    function_469b7ea0b94baae6("<dev string:xdc>");
    return undefined;
  }

  var_dc1cdeb65fa05ec4 = var_9ae49f75af0eca8e;
  var_dc1cdeb65fa05ec4.rewardcacheowner = rewardcacheowner;
  var_dc1cdeb65fa05ec4.playerowner = playerowner;
  return var_dc1cdeb65fa05ec4;
}

function private function_c664125500c6946f(var_dc1cdeb65fa05ec4) {
  function_1d23a5c9faafcf44(var_dc1cdeb65fa05ec4);
}

function private function_4269532b2cd3272e(rewardcache, player) {
  var_dc1cdeb65fa05ec4 = function_d50b9d11c2d587eb(rewardcache, player);

  if(!isDefined(var_dc1cdeb65fa05ec4)) {
    return false;
  }

  rewardcache.var_b3dc82144db04c75[rewardcache.var_b3dc82144db04c75.size] = var_dc1cdeb65fa05ec4;
  return true;
}

function private function_4b272a839a0ee8e8(rewardcache, player, rewardcachestate) {
  var_9ae49f75af0eca8e = function_8839eccded74a214(rewardcache, player);
  var_ca7c93a8aa8ae096 = reward_cache_settings::function_ed764cfb3d7fa4b8(rewardcache.settings);

  if(isDefined(var_9ae49f75af0eca8e)) {
    function_909ecf326f14f2e3(var_9ae49f75af0eca8e, var_ca7c93a8aa8ae096, rewardcachestate);
  }
}

function private function_8839eccded74a214(rewardcache, player) {
  foreach(var_dc1cdeb65fa05ec4 in rewardcache.var_b3dc82144db04c75) {
    if(var_dc1cdeb65fa05ec4.playerowner == player) {
      return var_dc1cdeb65fa05ec4;
    }
  }
}

function function_6305217aebc3f926(rewardcache, player) {
  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(rewardcache.objectivemarkerid, player);
}

function function_6b2d5732baa26e46(rewardcache, player) {
  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(rewardcache.objectivemarkerid, player);
}

function private function_33f66492eeb1f475(rewardcache) {
  rewardcache endon("cleanup");
  objectiveid = rewardcache.objectivemarkerid;

  while(true) {
    waitframe();
    scripts\mp\objidpoolmanager::update_objective_position(objectiveid, function_4952f5234b065969(rewardcache));
  }
}

function private function_7a33191e3c13b5ce(rewardcachesettings, origin) {
  markerbundlename = reward_cache_settings::getobjectivemarkerbundlename(rewardcachesettings);

  if(!isDefined(markerbundlename)) {
    function_1c5f030d48fdff4c("A marker bundle name was not found in the reward cache's settings. The reward cache will be spawned without an objective marker.");
    return -1;
  }

  objectiveid = namespace_871f41e67db0bf7a::function_40062e64625f8b19(markerbundlename);

  if(objectiveid == -1) {
    function_469b7ea0b94baae6("Marker failed to load from the bundle " + markerbundlename + ". The reward cache will be spawned without an objective marker.");
    return;
  }

  zoffset = reward_cache_settings::function_ced4245a2bfd6ced(rewardcachesettings);

  if(!isDefined(zoffset)) {
    function_1c5f030d48fdff4c("An objective marker is specified for this reward cache, but no zOffset was specified. The marker will likely not be placed above the cache.");
  } else if(!getdvarint(@ "hash_f0553fe7427447d4", 1)) {
    scripts\mp\objidpoolmanager::update_objective_setzoffset(objectiveid, zoffset);
  }

  if(getdvarint(@ "hash_f0553fe7427447d4", 1)) {
    scripts\mp\objidpoolmanager::update_objective_position(objectiveid, origin + (0, 0, zoffset));
  } else {
    scripts\mp\objidpoolmanager::update_objective_position(objectiveid, origin);
  }

  return objectiveid;
}

function private function_5e776c4debd7a058(objectivemarkerid) {
  scripts\mp\objidpoolmanager::update_objective_state(objectivemarkerid, "done");
  scripts\mp\objidpoolmanager::returnobjectiveid(objectivemarkerid);
}

function private function_445350567fa2042c(rewardcache) {
  inactiveplayers = function_de47cfc2f8f4d71d(rewardcache);

  foreach(player in inactiveplayers) {
    function_baa579f9e5c2a023(rewardcache, player, 1);
  }

  activeplayers = function_b804f364121242d3(rewardcache);

  foreach(player in activeplayers) {
    function_baa579f9e5c2a023(rewardcache, player, 0);
  }

  var_8267360e451cbab6 = function_f8a89d731386bd1e(rewardcache);

  foreach(player in var_8267360e451cbab6) {
    function_baa579f9e5c2a023(rewardcache, player, 2);
  }
}

function function_dcb5b533ee36ee85(rewardcache, player) {
  state = function_4797f19e0b2e0547(rewardcache, player);
  function_baa579f9e5c2a023(rewardcache, player, state);
}

function private function_4797f19e0b2e0547(rewardcache, player) {
  if(array_contains(function_f8a89d731386bd1e(rewardcache), player)) {
    return 2;
  }

  if(array_contains(getplayerowners(rewardcache), player)) {
    return 0;
  }

  return 1;
}

function private function_1399f8c48b16a218(rewardcache, player) {
  rewardcache.interactionpoint enablescriptableplayeruse(player);
}

function private function_b4dbfe49ef9b3109(rewardcache, player) {
  rewardcache.interactionpoint disablescriptableplayeruse(player);
}

function private function_baa579f9e5c2a023(rewardcache, player, rewardcachestate) {
  if(rewardcachestate == 0) {
    function_1399f8c48b16a218(rewardcache, player);
    function_6305217aebc3f926(rewardcache, player);
  } else {
    function_b4dbfe49ef9b3109(rewardcache, player);
    function_6b2d5732baa26e46(rewardcache, player);
  }

  function_4b272a839a0ee8e8(rewardcache, player, rewardcachestate);
}

function function_3ee75bc4270d9687(scriptableassetname, var_be17e9d6ceb06a5b) {
  if(!isDefined(scriptableassetname)) {
    function_469b7ea0b94baae6(" could not create scriptable info from undefined scriptableAssetName (hint: rewardCacheScriptableType is " + default_to(var_be17e9d6ceb06a5b, "undefined"));
    return;
  }

  scriptableinfo = function_c138936a3dfcb83c(scriptableassetname);
  function_8a7225f2532a420c(scriptableinfo, var_be17e9d6ceb06a5b);
  return scriptableinfo;
}

function function_c138936a3dfcb83c(scriptable_assetname, scriptablepartname, var_809b1db77e03ff7f, var_9f783320f97e2fa5, var_b36fb5e0718142bd) {
  scriptableinfo = spawnStruct();
  scriptableinfo.assetname = scriptable_assetname;
  scriptableinfo.scriptablepartname = scriptablepartname;
  scriptableinfo.var_809b1db77e03ff7f = var_809b1db77e03ff7f;
  scriptableinfo.var_9f783320f97e2fa5 = var_9f783320f97e2fa5;
  scriptableinfo.var_b36fb5e0718142bd = var_b36fb5e0718142bd;
  return scriptableinfo;
}

function private function_8a7225f2532a420c(scriptableinfo, var_be17e9d6ceb06a5b) {
  switch (var_be17e9d6ceb06a5b) {
    case 0:
      function_a1ba6dc6fe85af2f(scriptableinfo);
      break;
    case 1:
      function_debcf9b3cdb7de4e(scriptableinfo);
      break;
    case 2:
      function_b4c40fbad4ff6b08(scriptableinfo);
      break;
    default:
      function_469b7ea0b94baae6("Could not set scriptable info for scriptableAssetName " + default_to(scriptableinfo.scriptableassetname, "undefined") + ". Reason: rewardCacheScriptableType " + var_be17e9d6ceb06a5b + " not recognized.");
      return undefined;
  }
}

function private function_debcf9b3cdb7de4e(scriptableinfo) {
  scriptableinfo.scriptablepartname = "body";
  scriptableinfo.var_809b1db77e03ff7f = "rewardcache_interactionpoint";
  scriptableinfo.var_9f783320f97e2fa5 = undefined;
  scriptableinfo.var_b36fb5e0718142bd = undefined;
}

function private function_b4c40fbad4ff6b08(scriptableinfo) {
  scriptableinfo.scriptablepartname = "body";
  scriptableinfo.var_809b1db77e03ff7f = "rewardcache_lootcache";
  scriptableinfo.var_9f783320f97e2fa5 = undefined;
  scriptableinfo.var_b36fb5e0718142bd = undefined;
}

function private function_a1ba6dc6fe85af2f(scriptableinfo) {
  scriptableinfo.scriptablepartname = "body";
  scriptableinfo.var_809b1db77e03ff7f = "rewardcache_active";
  scriptableinfo.var_9f783320f97e2fa5 = "rewardcache_inactive";
  scriptableinfo.var_b36fb5e0718142bd = "rewardcache_despawn";
}

function private function_e050b08db44e0d63(scriptableinfo, origin, angles, playerowner) {
  assetname = scriptableinfo.assetname;
  scriptable = undefined;

  if(isDefined(playerowner)) {
    payload = [#"teamselect", playerowner getentitynumber()];
    scriptable = spawnscriptable(assetname, origin, angles, undefined, payload);
  } else {
    scriptable = spawnscriptable(assetname, origin, angles);
  }

  if(!isDefined(scriptable)) {
    function_469b7ea0b94baae6(" unable to spawn reward cache scriptable with name " + default_to(assetname, "undefined") + ". Are you sure this scriptable exists and has been precached?");
    return undefined;
  }

  function_909ecf326f14f2e3(scriptable, scriptableinfo, 0);
  return scriptable;
}

function private function_1d23a5c9faafcf44(rewardcachescriptable) {
  if(!isDefined(rewardcachescriptable)) {
    return;
  }

  if(isent(rewardcachescriptable)) {
    rewardcachescriptable delete();
    return;
  }

  rewardcachescriptable freescriptable();
}

function private function_909ecf326f14f2e3(scriptable, scriptableinfo, rewardcachestate) {
  scriptablepartname = scriptableinfo.scriptablepartname;
  scriptablestatename = undefined;

  switch (rewardcachestate) {
    case 0:
      scriptablestatename = scriptableinfo.var_809b1db77e03ff7f;
      break;
    case 1:
      scriptablestatename = scriptableinfo.var_271cc40d01b6b6d4;
      break;
    case 2:
      scriptablestatename = scriptableinfo.var_b36fb5e0718142bd;
      break;
    default:
      assertmsg("<dev string:x13e>" + rewardcachestate + "<dev string:x155>");
      return;
  }

  function_f58f5f77adef707d(scriptable, scriptablepartname, scriptablestatename);
}

function private function_f58f5f77adef707d(scriptable, scriptablepartname, scriptablestatename) {
  if(scriptable getscriptableparthasstate(scriptablepartname, scriptablestatename)) {
    scriptable setscriptablepartstate(scriptablepartname, scriptablestatename);
    return;
  }

  function_e02e37e34dec2042("Could not initialize part " + scriptablepartname + " and state " + scriptablestatename + " on reward cache scriptable.");
}

function private function_ee13dfd43acfc3b0(scriptable, scriptablepartname, var_3a999b065b9e34bc, var_cddf574098957e21) {
  scriptable notify(scriptablepartname);
  scriptable endon(scriptablepartname);
  var_f4405fb4d1081eca = scriptable getscriptableparthasstate(scriptablepartname, var_3a999b065b9e34bc);
  var_93e2d466af96c8e3 = scriptable getscriptableparthasstate(scriptablepartname, var_cddf574098957e21);

  if(var_f4405fb4d1081eca && var_93e2d466af96c8e3) {
    function_f58f5f77adef707d(scriptable, scriptablepartname, var_3a999b065b9e34bc);
    waitframe();

    if(isDefined(scriptable)) {
      function_f58f5f77adef707d(scriptable, scriptablepartname, var_cddf574098957e21);
    }

    return;
  }

  if(var_f4405fb4d1081eca && !var_93e2d466af96c8e3) {
    function_1c5f030d48fdff4c("rewardcache scriptable has an onItemTaken part,state: " + scriptablepartname + ", " + var_3a999b065b9e34bc + " but no inactive state with the name " + var_cddf574098957e21 + " on the same part. A client visual cache must have both to play on item taken FX");
  }
}

function private function_c6d16a48482b75c1(scriptable) {
  thread function_ee13dfd43acfc3b0(scriptable, "onitemtaken", "rewardcache_onitemtaken", "rewardcache_inactive");
}

function private function_81010148cb67c61d(scriptable) {
  thread function_ee13dfd43acfc3b0(scriptable, "onclosed", "rewardcache_onclosed", "rewardcache_inactive");
}

function private function_fa331a2fee762f38(scriptable) {
  thread function_ee13dfd43acfc3b0(scriptable, "onopened", "rewardcache_onopened", "rewardcache_inactive");
}

function function_b7311db02b6c82b1() {
  if(!isDefined(level.var_10710e1c25e91b8e)) {
    level.var_10710e1c25e91b8e = playtest_logger::function_223a972e008c4a09(@ "hash_9a8fd13708d50583", @ "hash_9d0c095771c6026d", @ "hash_813ebb2dc2b30d1c", @ "hash_693c22d6aae40d2e", @ "hash_176196b9a9745584", @ "hash_56641085422a272c", @ "hash_bd0e9311e61ffefa", "REWARD_CACHE_LOG ");
  }

  return level.var_10710e1c25e91b8e;
}

function function_e02e37e34dec2042(assertmessage, rewardcache, relevantplayers) {
  assertmessage = function_984edb8383cfe272(assertmessage, rewardcache, relevantplayers);
  playtest_logger::logassert(assertmessage, function_b7311db02b6c82b1());
}

function function_469b7ea0b94baae6(msg, rewardcache, relevantplayers) {
  msg = function_984edb8383cfe272(msg, rewardcache, relevantplayers);
  playtest_logger::logerror(msg, function_b7311db02b6c82b1());
}

function function_1c5f030d48fdff4c(msg, rewardcache, relevantplayers) {
  msg = function_984edb8383cfe272(msg, rewardcache, relevantplayers);
  playtest_logger::logwarning(msg, function_b7311db02b6c82b1());
}

function function_1c972fc13937297c(msg, rewardcache, relevantplayers) {
  msg = function_984edb8383cfe272(msg, rewardcache, relevantplayers);
  playtest_logger::loginfo(msg, function_b7311db02b6c82b1());
}

function private function_984edb8383cfe272(msg, rewardcache, relevantplayers) {
  var_41148872a4288ef8 = msg;

  if(isrewardcache(rewardcache)) {
    var_41148872a4288ef8 += " ( Reward Cache: " + function_1a020d38f2327a5c(rewardcache) + " ) ";
  }

  if(isPlayer(relevantplayers) || isarray(relevantplayers)) {
    var_41148872a4288ef8 += " ( Relevant Players: " + function_f27f6ec22daf7fe9(relevantplayers) + " ) ";
  }

  return var_41148872a4288ef8;
}

function private function_5769976c6051f91b(rewardcache) {
  if(istrue(getdvarint(@ "hash_c81336f4624077f5", 0))) {
    return;
  }

  var_f1126f87cbfb3910 = !istrue(getdvarint(@ "hash_6d8a08730dfb4052", 0));
  infostring = function_1a020d38f2327a5c(rewardcache, var_f1126f87cbfb3910);
  function_1c972fc13937297c("Spawned " + infostring);
}

function private function_3a91397317ef6ceb(scriptableassetname, missingstates, var_84582a7af8ad2d63) {
  return "Scriptable created from asset " + scriptableassetname + " is missing these required states [" + string_join(missingstates, ",") + "] on the part " + default_to(var_84582a7af8ad2d63, "undefined") + ". You may see undefined behavior when looking at the cache.";
}

function function_1a020d38f2327a5c(rewardcache, var_f1126f87cbfb3910) {
  if(!isDefined(var_f1126f87cbfb3910)) {
    var_f1126f87cbfb3910 = 1;
  }

  grouprewardcaches = rewardcache.grouprewardcaches;

  if(!var_f1126f87cbfb3910) {
    return ("reward cache at origin " + function_4952f5234b065969(rewardcache) + " with " + grouprewardcaches.size + " reward groups.");
  }

  i = 0;
  var_5a43a48574104984 = "";

  foreach(grouprewardcache in rewardcache.grouprewardcaches) {
    i++;
    playergroup = grouprewardcache.playerowners;
    lootcontents = grouprewardcache.contents;
    playernamesstring = function_f27f6ec22daf7fe9(playergroup);

    if(lootcontents.size > 0) {
      var_e2d293b640f64920 = [];

      foreach(lootstruct in lootcontents) {
        var_e2d293b640f64920[var_e2d293b640f64920.size] = lootstruct.lootid + ":" + lootstruct.quantity;
      }

      lootinfostring = utility::string_join(var_e2d293b640f64920, ", ");
    } else {
      lootinfostring = "";
    }

    var_5a43a48574104984 += " GROUP " + i + ": (players: [" + playernamesstring + "], loot: " + lootcontents.size + " items with lootId:quantity [" + lootinfostring + "])";
  }

  infostring = "Reward cache at origin " + function_4952f5234b065969(rewardcache) + " with " + grouprewardcaches.size + " reward groups.";
  infostring += var_5a43a48574104984;
  return infostring;
}

function function_f27f6ec22daf7fe9(playerarray) {
  if(!isarray(playerarray)) {
    playerarray = [playerarray];
  }

  playernames = [];

  foreach(player in playerarray) {
    if(isPlayer(player)) {
      playernames[playernames.size] = player.name;
    }
  }

  playernamesstring = playernames.size > 0 ? utility::string_join(playernames, ", ") : "";
  return playernamesstring;
}

function private function_2f9979bc854d735d(rewardcachesettings, playergroups, placementstruct, func_openlootablecontainer, var_5110040e4247ddb8, lootfunctionargs, func_oncacheitemtaken, func_onitemadded, var_3c99a2a84c4b850f) {
  result = {
    #func_onitemadded: func_onitemadded, #func_oncacheitemtaken: func_oncacheitemtaken, #lootfunctionargs: lootfunctionargs, #success: 1
  };

  if(!isDefined(playergroups) || !isarray(playergroups)) {
    function_e02e37e34dec2042("Reward cache could not be spawned. Reason: playerGroups is not an array.");
    result.success = 0;
  } else if(playergroups.size == 0) {
    function_469b7ea0b94baae6("Reward cache will not be spawned. Reason: playerGroups must contain at least one player");
    result.success = 0;
  }

  if(!function_e14049204539f02a(placementstruct)) {
    function_e02e37e34dec2042("Reward cache could not be spawned. Reason: invalid placement struct (must be a struct with a .origin and .angles property).");
    result.success = 0;
  }

  if(!isDefined(func_openlootablecontainer) || !isfunction(func_openlootablecontainer)) {
    function_e02e37e34dec2042("Reward cache could not be spawned. Reason: openLootableContainer function is undefined or not a function.");
    result.success = 0;
  }

  if(!isDefined(var_5110040e4247ddb8) || !isfunction(var_5110040e4247ddb8)) {
    function_e02e37e34dec2042("Reward cache could not be spawned. Reason: getLootContents function is undefined or not a function.");
    result.success = 0;
  }

  if(!isDefined(lootfunctionargs)) {
    result.lootfunctionargs = spawnStruct();
  } else if(!isstruct(lootfunctionargs)) {
    function_e02e37e34dec2042("reward cache could not be spawned. Reason: lootFunctionArgs must be a struct");
    result.success = 0;
  }

  if(isDefined(func_oncacheitemtaken) && !isfunction(func_oncacheitemtaken)) {
    function_469b7ea0b94baae6("func_onCacheItemTaken is defined but is not a function! The reward cache will still spawn but without any onItemTaken functionality.");
    result.func_oncacheitemtaken = undefined;
  }

  if(isDefined(func_onitemadded) && !isfunction(func_onitemadded)) {
    function_469b7ea0b94baae6("func_onItemAdded is defined but is not a function! The reward cache will still spawn but without any onItemAdded functionality.");
    result.func_onitemadded = undefined;
  }

  return result;
}

function function_66808eff13dbe014(var_98af744a999ef18) {
  if(!isDefined(var_98af744a999ef18) || !isarray(var_98af744a999ef18)) {
    return false;
  }

  foreach(lootitem in var_98af744a999ef18) {
    if(!isstruct(lootitem) || !isDefined(lootitem.lootid) || !isDefined(lootitem.quantity)) {
      return false;
    }
  }

  return true;
}

function function_e14049204539f02a(var_b5f12a6fcfb787a8) {
  return isDefined(var_b5f12a6fcfb787a8) && isstruct(var_b5f12a6fcfb787a8) && isDefined(var_b5f12a6fcfb787a8.origin) && isDefined(var_b5f12a6fcfb787a8.angles);
}

function function_ae3199d790b1588a(rewardgroup) {
  if(!isDefined(rewardgroup) || !isarray(rewardgroup)) {
    return false;
  }

  foreach(player in rewardgroup) {
    if(!isPlayer(player)) {
      return false;
    }
  }

  return true;
}

function private function_f434d12840148e1b(playergrouplootstructs) {
  var_f3d4b024c55661e9 = [];

  foreach(grouplootstruct in playergrouplootstructs) {
    validplayers = function_7b3e0989d6429532(grouplootstruct.playergroup);

    if(validplayers.size > 0) {
      grouplootstruct.playergroup = validplayers;
      var_f3d4b024c55661e9[var_f3d4b024c55661e9.size] = grouplootstruct;
    }
  }

  return var_f3d4b024c55661e9;
}

function private function_7b3e0989d6429532(array) {
  validplayers = [];

  foreach(player in array) {
    if(isPlayer(player)) {
      validplayers[validplayers.size] = player;
    }
  }

  return validplayers;
}

function private function_8e8b8d36cec59a9f(scriptableinstance, var_be17e9d6ceb06a5b, logerrors) {
  logerrors = default_to(logerrors, 0);

  if(!isDefined(scriptableinstance)) {
    return false;
  }

  scriptableinfo = spawnStruct();
  function_8a7225f2532a420c(scriptableinstance, var_be17e9d6ceb06a5b);
  missingstates = function_5ca2928b25457e69(scriptableinstance, scriptableinfo);

  if(missingstates.size != 0) {
    if(logerrors) {
      errormsg = function_3a91397317ef6ceb(scriptableinfo.assetname, missingstates, scriptableinfo.scriptablepartname);
      function_469b7ea0b94baae6(errormsg);
    }

    return false;
  }

  return true;
}

function private function_5ca2928b25457e69(scriptableinstance, scriptableinfo) {
  requiredstates = [scriptableinfo.var_809b1db77e03ff7f, scriptableinfo.var_9f783320f97e2fa5, scriptableinfo.var_b36fb5e0718142bd];
  requiredstates = array_removeundefined(requiredstates);
  return function_f8713af73ab5adf1(scriptableinstance, scriptableinfo.scriptablepartname, requiredstates);
}

function private function_f8713af73ab5adf1(scriptableinstance, partnametocheck, var_2069b817a6c75351) {
  missingstates = [];

  foreach(statename in var_2069b817a6c75351) {
    if(!scriptableinstance getscriptableparthasstate(partnametocheck, statename)) {
      missingstates[missingstates.size] = statename;
    }
  }

  return missingstates;
}

function private function_4a71c5cd075ec3d3() {
  return {
    #resultstatus: 0, #resultobject: undefined
  };
}

function private function_9b4ae88527b27180(workresults) {
  foreach(workresult in workresults) {
    if(workresult.resultstatus == 0) {
      return false;
    }
  }

  return true;
}

function private function_715bc45d25964e75(workresults) {
  foreach(workresult in workresults) {
    if(workresult.resultstatus == 2) {
      return true;
    }
  }

  return false;
}

function private function_5894e5af5e7c3574() {
  return max(1, getdvarint(@ "hash_4e2904a76ce33e39", 8));
}

function private function_8f0ea7b45a92fe4c(spawnoriginworkresult, playergroups, placementstruct) {
  var_6c1956fd6ce84917 = namespace_6257bf0db64cb539::function_f06552e950665aa9(placementstruct);

  if(istrue(var_6c1956fd6ce84917)) {
    if(getdvarint(@ "hash_94f4c6adf1621cb4", 0) == 0) {
      function_1c972fc13937297c("Spawning Over Time: Waiting until nearby spawn origin is found " + namespace_6257bf0db64cb539::getplacementorigin(placementstruct));
    }

    var_8dd4051dae605f66 = spawnStruct();
    function_4eb1ac313bc7d586(playergroups, placementstruct, var_8dd4051dae605f66);
    var_8dd4051dae605f66 waittill("FindNearbySpawnPointGuaranteed_DONE", spawnorigin);

    if(getdvarint(@ "hash_94f4c6adf1621cb4", 0) == 0) {
      function_1c972fc13937297c("Spawning Over Time: Nearby spawn origin found " + spawnorigin);
    }
  } else {
    spawnorigin = namespace_6257bf0db64cb539::getplacementorigin(placementstruct);
  }

  spawnoriginworkresult.resultobject = spawnorigin;
  spawnoriginworkresult.resultstatus = 1;
}

function private function_4d1ed1e796e9b5fb(var_48924e1f05b1e588, playergroups, var_5110040e4247ddb8, lootfunctionargs) {
  playergrouplootstructs = [];
  var_51949fef4a2699bf = function_5894e5af5e7c3574();
  var_27cc8a90d02c5902 = ceil(playergroups.size / var_51949fef4a2699bf);
  var_a89692b149ca72b1 = 0;
  var_cc8e8209d2dc7247 = 0;
  function_1c972fc13937297c("Spawning Over Time: Computing loot for " + playergroups.size + " groups. (" + var_27cc8a90d02c5902 + " groups each frame)");

  foreach(playergroup in playergroups) {
    if(var_a89692b149ca72b1 == var_27cc8a90d02c5902) {
      waitframe();
      var_a89692b149ca72b1 = 0;
    }

    if(!isarray(playergroup)) {
      function_469b7ea0b94baae6("Invalid reward group passed to reward cache. Reward groups must be arrays. The reward cache will continue attempting to spawn but without this malformed reward group.");
      continue;
    }

    validplayersingroup = function_7b3e0989d6429532(playergroup);

    if(validplayersingroup.size == 0) {
      function_1c5f030d48fdff4c("No valid players in group. The reward cache will continue attempting to spawn without adding this empty group.");
      continue;
    }

    lootfunctionargs.reward_group = validplayersingroup;
    lootcontents = [[var_5110040e4247ddb8]](lootfunctionargs);
    playergrouplootstructs[playergrouplootstructs.size] = {
      #lootcontents: lootcontents, #playergroup: validplayersingroup
    };
    var_a89692b149ca72b1++;
    var_cc8e8209d2dc7247++;

    if(getdvarint(@ "hash_94f4c6adf1621cb4", 0) != 1) {
      function_1c972fc13937297c("Spawning Over Time: Computed loot for " + var_cc8e8209d2dc7247 + "/" + playergroups.size + " PLAYER GROUPS");
    }
  }

  function_1c972fc13937297c("Spawning Over Time: Done computing loot for " + playergroups.size + " groups");
  var_48924e1f05b1e588.resultobject = playergrouplootstructs;
  var_48924e1f05b1e588.resultstatus = 1;
}