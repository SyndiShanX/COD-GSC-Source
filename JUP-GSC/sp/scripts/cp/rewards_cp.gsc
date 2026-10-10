/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\rewards_cp.gsc
***********************************************/

#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\cp\challenges_cp;
#using scripts\cp\progression;
#using scripts\engine\utility;
#namespace rewards_cp;

function init() {
  function_8b5ef490132a6ab9();
}

function function_8b5ef490132a6ab9() {
  foreach(player in level.players) {
    player setplayerdata("cp", "lastRaidReward", "None");
    player setplayerdata("cp", "lastRaidVeteranReward", "None");
    player setplayerdata("cp", "lastRaidOperatorReward", "None");

    if(!isDefined(game["resetClassifiedRewards"])) {
      player setplayerdata("cp", "lastRaidClassifiedReward", "None");
      game["resetClassifiedRewards"] = 1;
    }
  }
}

function function_4ec90e865bd62bf5() {
  foreach(player in level.players) {
    refid = function_3093b5325d166784(player, "currentCPOperatorRewards", 6, "operatorReward");

    if(!isDefined(refid) || refid == "None" || refid == "") {
      player setplayerdata("cp", "lastRaidOperatorReward", "None");
      return;
    }

    player setplayerdata("cp", "lastRaidOperatorReward", refid);
    rewardindex = undefined;

    for(i = 0; i < 6; i++) {
      currentreward = player getplayerdata("cp", "currentCPOperatorRewards", i);

      if(currentreward == "") {
        rewardindex = i;
        break;
      }
    }

    if(isDefined(rewardindex)) {
      player setplayerdata("cp", "currentCPOperatorRewards", rewardindex, refid);
    }
  }
}

function function_31124f4dd33ad7f2() {
  foreach(player in level.players) {
    var_1a2a9e3820387fe1 = player getplayerdata("cp", "lastRaidClassifiedReward");

    if(!isDefined(var_1a2a9e3820387fe1) || var_1a2a9e3820387fe1 == "") {
      return;
    }

    rewardindex = undefined;

    for(i = 0; i < 4; i++) {
      currentreward = player getplayerdata("cp", "currentCPClassifiedRewards", i);

      if(currentreward == "") {
        rewardindex = i;
        break;
      }
    }

    if(isDefined(rewardindex)) {
      player setplayerdata("cp", "currentCPClassifiedRewards", rewardindex, var_1a2a9e3820387fe1);
    }
  }
}

function function_e0e2f13dec46e52e() {
  foreach(player in level.players) {
    refid = function_3093b5325d166784(player, "currentCPVeteranRewards", 6, "veteranReward");

    if(!isDefined(refid) || refid == "None" || refid == "") {
      player setplayerdata("cp", "lastRaidVeteranReward", "None");
      return;
    }

    player setplayerdata("cp", "lastRaidVeteranReward", refid);
    rewardindex = undefined;

    for(i = 0; i < 6; i++) {
      currentreward = player getplayerdata("cp", "currentCPVeteranRewards", i);

      if(currentreward == "") {
        rewardindex = i;
        break;
      }
    }

    if(isDefined(rewardindex)) {
      player setplayerdata("cp", "currentCPVeteranRewards", rewardindex, refid);
    }
  }
}

function function_2ca23024661e30ae() {
  foreach(player in level.players) {
    refid = function_3093b5325d166784(player, "currentCPRaidRewards", 36, "lootPool", 1);
    var_9cdde83413e9a220 = function_7042dad035dc176c(refid);
    aeeventname = #"collect_item";
    aeeventid = function_6e2deb013c9ca85e(aeeventname);
    self function_db073176839d77fb(aeeventid, [function_d6f771aedba70ce7(aeeventname, #"gamemode"), scripts\cp\challenges_cp::function_2b0b870d1cf29add(), function_d6f771aedba70ce7(aeeventname, #"gametype"), scripts\cp\challenges_cp::function_2ff6fac4cf0827a6(), function_d6f771aedba70ce7(aeeventname, #"version"), 1, function_d6f771aedba70ce7(aeeventname, #"value"), 1, function_d6f771aedba70ce7(aeeventname, #"string_ref"), var_9cdde83413e9a220]);

    if(!isDefined(refid)) {
      return;
    }

    player setplayerdata("cp", "lastRaidReward", refid);

    if(refid == "None" || refid == "raid_default_reward_xp") {
      return;
    }

    rewardindex = undefined;

    for(i = 0; i < 36; i++) {
      currentreward = player getplayerdata("cp", "currentCPRaidRewards", i);

      if(currentreward == "") {
        rewardindex = i;
        break;
      }
    }

    if(isDefined(rewardindex)) {
      player setplayerdata("cp", "currentCPRaidRewards", rewardindex, refid);
    }
  }
}

function private function_3093b5325d166784(player, var_3575406d63f16fbd, var_c3b6a33aba86a99f, rewardtype, israndom) {
  current_season = scripts\cp\challenges_cp::function_862a7d40f77a77d6(level.script);
  raidrewards = function_fa4c5faedacee161(current_season, rewardtype);

  if(!isDefined(raidrewards)) {
    return undefined;
  }

  var_24a619ea4813d4ba = [];

  for(i = 0; i < var_c3b6a33aba86a99f; i++) {
    var_24a619ea4813d4ba[var_24a619ea4813d4ba.size] = player getplayerdata("cp", var_3575406d63f16fbd, i);
  }

  var_8b11f807a986c94a = raidrewards;

  if(isDefined(var_24a619ea4813d4ba)) {
    foreach(reward in var_24a619ea4813d4ba) {
      if(reward == "") {
        continue;
      }

      rewardindex = 0;

      foreach(var_b4b2cb55cc84139b in raidrewards) {
        if(var_b4b2cb55cc84139b == reward) {
          var_8b11f807a986c94a = scripts\engine\utility::array_remove_index(var_8b11f807a986c94a, rewardindex, 1);
        }

        rewardindex++;
      }
    }
  }

  if(!isDefined(raidrewards) || !isDefined(var_8b11f807a986c94a) || var_8b11f807a986c94a.size <= 0) {
    return "None";
  }

  raidrewards = var_8b11f807a986c94a;

  if(istrue(israndom)) {
    return scripts\engine\utility::random(raidrewards);
  }

  return raidrewards[0];
}

function private function_c168d1e4f69482f6(current_season) {
  switch (current_season) {
    case #"hash_6a9b7bde55eb2f5e":
      return ["raids1_reward_blueprint_veteran"];
    case #"hash_6a9b7ade55eb2dcb":
      return ["raids2_reward_blueprint_veteran"];
    case #"hash_6a9b79de55eb2c38":
      return ["raids3_reward_camo_veteran"];
    case #"hash_6a9b80de55eb373d":
      return ["raids4_reward_veteran"];
    case #"hash_6a9b7fde55eb35aa":
    default:
      break;
  }

  return undefined;
}

function private function_688238ffea60e929(current_season) {
  switch (current_season) {
    case #"hash_6a9b7bde55eb2f5e":
      return ["raids1_operator_reward_gaz_base"];
    case #"hash_6a9b7ade55eb2dcb":
      return ["raids2_operator_reward_price_skin"];
    case #"hash_6a9b79de55eb2c38":
      return ["raids3_operator_reward_alex_base"];
    case #"hash_6a9b80de55eb373d":
      return ["raids4_operator_reward_farah_skin"];
    case #"hash_6a9b7fde55eb35aa":
    default:
      break;
  }

  return undefined;
}

function private function_57926be9277192bd(current_season) {
  switch (current_season) {
    case #"hash_6a9b7bde55eb2f5e":
      return ["raids1_reward_random_1", "raids1_reward_random_2", "raids1_reward_random_3", "raids1_reward_random_4", "raids1_reward_random_5", "raids1_reward_random_6", "raids1_reward_random_special", "raids1_reward_random_loot_camo"];
    case #"hash_6a9b7ade55eb2dcb":
      return ["raids2_reward_random_1", "raids2_reward_random_2", "raids2_reward_random_3", "raids2_reward_random_4", "raids2_reward_random_5", "raids2_reward_random_6", "raids2_reward_random_loot_camo"];
    case #"hash_6a9b79de55eb2c38":
      return ["raids3_reward_random_1", "raids3_reward_random_2", "raids3_reward_random_3", "raids3_reward_random_4", "raids3_reward_random_5"];
    case #"hash_6a9b7fde55eb35aa":
    case #"hash_6a9b80de55eb373d":
    default:
      break;
  }

  return undefined;
}

function private function_fa4c5faedacee161(current_season, rewardtype) {
  switch (rewardtype) {
    case #"hash_d1bcc6dcb2259d":
      return function_57926be9277192bd(current_season);
    case #"hash_268e853fb2548b03":
      return function_c168d1e4f69482f6(current_season);
    case #"hash_766fb788c9e6b312":
      return function_688238ffea60e929(current_season);
  }

  return undefined;
}

function function_1caa50f367871948() {
  var_e67e4cf4818d083f = function_7042dad035dc176c("collect_intel_single");
  aeeventname = #"collect_item";
  aeeventid = function_6e2deb013c9ca85e(aeeventname);
  self function_db073176839d77fb(aeeventid, [function_d6f771aedba70ce7(aeeventname, #"gamemode"), scripts\cp\challenges_cp::function_2b0b870d1cf29add(), function_d6f771aedba70ce7(aeeventname, #"gametype"), scripts\cp\challenges_cp::function_2ff6fac4cf0827a6(), function_d6f771aedba70ce7(aeeventname, #"version"), 1, function_d6f771aedba70ce7(aeeventname, #"value"), 1, function_d6f771aedba70ce7(aeeventname, #"string_ref"), var_e67e4cf4818d083f]);
}

function function_5da13cac404268cb() {
  totalintel = self getplayerdata("cp", "totalIntel");

  if(totalintel % 5 != 0) {
    return;
  }

  var_6a9c5706deb202ee = self getplayerdata("cp", "intelCollectFiveRewardAmount");
  self setplayerdata("cp", "intelCollectFiveRewardAmount", var_6a9c5706deb202ee + 1);
  scripts\cp\progression::function_9b50c58f20b295a0(2);
  var_3e5376d61bcad7ac = function_7042dad035dc176c("collect_intel_5");
  aeeventname = #"collect_item";
  aeeventid = function_6e2deb013c9ca85e(aeeventname);
  self function_db073176839d77fb(aeeventid, [function_d6f771aedba70ce7(aeeventname, #"gamemode"), scripts\cp\challenges_cp::function_2b0b870d1cf29add(), function_d6f771aedba70ce7(aeeventname, #"gametype"), scripts\cp\challenges_cp::function_2ff6fac4cf0827a6(), function_d6f771aedba70ce7(aeeventname, #"version"), 1, function_d6f771aedba70ce7(aeeventname, #"value"), 1, function_d6f771aedba70ce7(aeeventname, #"string_ref"), var_3e5376d61bcad7ac]);
}

function private function_a4c89ea948debca4() {
  locationname = scripts\cp\progression::function_3e1f4ec9f2ea7f0a();

  switch (locationname) {
    case #"hash_669c74f156249b88":
      return "saba_hydro";
    case #"hash_a2cea08b38879015":
      return "high_ground_cp";
    case #"hash_cbb70c11866ca750":
      return "denied_area_cp";
    case #"hash_444ff8acbd3c5ce7":
      return "saba_observatory";
    case #"hash_3446049904a6d9a0":
      return "raid_s1";
    case #"hash_3446079904a6de59":
      return "raid_s2";
    case #"hash_3446069904a6dcc6":
      return "raid_s3";
    case #"hash_3446099904a6e17f":
      return "raid_s4";
  }

  return undefined;
}