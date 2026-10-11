/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_39d11000e476a42a.gsc
*************************************************/

#using script_185660037b9236c1;
#using script_33135cb7affb7992;
#using script_41387eecc35b88bf;
#using script_482376d10f69832c;
#using script_5815a7cb4d944542;
#using script_5f71ed065b9cea1e;
#using script_64351208cb856df9;
#using script_6b684505b9959a08;
#using script_7956d56c4922bd1;
#using scripts\cp_mp\loot\common_cache;
#using scripts\engine\utility;
#namespace namespace_bd7428f3122be80f;

function function_69406b22706f2162(relevantparameters) {
  grouprewardcache = relevantparameters.cache;
  player = relevantparameters.player;

  if(!isDefined(grouprewardcache)) {
    reward_cache::function_e02e37e34dec2042("Could not open undefined group reward cache (lootable container).");
    return;
  }

  if(!isDefined(player)) {
    reward_cache::function_e02e37e34dec2042("Could not open group reward cache (lootable container) for undefined player!");
    return;
  }

  grouprewardcache.minimumslots = function_349ba59b91101535(grouprewardcache);
  common_cache::openlootablecontainer(grouprewardcache, player);
}

function function_aae7d234bf6eaaa9(relevantinfostruct) {
  currentopener = relevantinfostruct.currentopener;

  if(!isPlayer(currentopener)) {
    return;
  }

  lootid = relevantinfostruct.lootid;
  quantity = relevantinfostruct.quantity;
  containerindex = relevantinfostruct.containerindex;
  common_cache::function_eff2aed88a59ccfd(currentopener, containerindex, lootid, quantity);
}

function function_9302d6fba4ac736a(relevantinfostruct) {
  activityinstance = self;
  category = namespace_68dc261109a9503f::getactivitycategory(activityinstance);

  if(category == "Contract") {
    reward_instance = spawnStruct();
    reward_instance.difficulty_region = activityinstance namespace_e8853d3344e33cf6::function_208c5a28152e1218();
    reward_instance.activity_instance = activityinstance;
    reward_instance.reward_group = relevantinfostruct.reward_group;
    cache = spawnStruct();
    reward_instance namespace_e8853d3344e33cf6::function_d67ffd8ae22bf637(cache);
    return cache.contents;
  }

  reward_cache::function_469b7ea0b94baae6("The OB default GetRewardLoot implementation does not support non-contract activities. To generate loot for non-contract activities, please override this activity function for your activity.");
  return [];
}

function function_b64c78402ddc2359(relevantinfostruct) {
  activityinstance = self;
  rewardspawnlocationtype = relevantinfostruct.rewardspawnlocationtype;
  assert(isDefined(activityinstance));

  if(!isDefined(rewardspawnlocationtype)) {
    reward_cache::function_469b7ea0b94baae6("GetRewardSpawnLocation called without a relevantInfoStruct.rewardSpawnLocationType property. Did you pass one into RunActivityFunction?");
  }

  switch (rewardspawnlocationtype) {
    case #"hash_c7c061e869305a0b":
      return function_279caa69a00248fc(activityinstance);
    case #"hash_89ee46feec0f25b9":
      reward_cache::function_469b7ea0b94baae6("Unable to find a location to spawn the reward. Reason: \"Function Override\" was specified as the reward spawn location in the reward scriptbundle, but no such override has been set.");
      break;
    default:
      reward_cache::function_469b7ea0b94baae6("Unable to find a location to spawn the reward. Reason: rewardSpawnLocationType " + rewardspawnlocationtype + " is not recognized by the Nexus. Please check that your rewards bundle is configured correctly");
      break;
  }

  return undefined;
}

function function_3ae7f99339b96499(origin, var_6c1956fd6ce84917, var_89bf5d052616cfb) {
  return namespace_6257bf0db64cb539::function_facc1b52ce8080fb(origin, (0, 0, 0), default_to(var_6c1956fd6ce84917, 0), default_to(var_89bf5d052616cfb, 100), 22, 36);
}

function private function_349ba59b91101535(grouprewardcache) {
  return int(max(grouprewardcache.contents.size, 4));
}

function private function_279caa69a00248fc(activityinstance) {
  var_8671fb8fe10f6a7d = activityinstance namespace_eabc780d2f9ee9d2::function_6787cd2004f976e2();

  if(var_8671fb8fe10f6a7d.size > 0) {
    var_6cd7ebc66ad6f7ce = var_8671fb8fe10f6a7d[0];
    return var_6cd7ebc66ad6f7ce;
  }

  reward_cache::function_469b7ea0b94baae6("Unable to find a location to spawn the reward. Reason: No reward chest structs were found in your gamemode scriptbundle. At least one reward chest struct OR overriding the GetRewardStruct activity function is required to be able to spawn a reward.");
  return undefined;
}