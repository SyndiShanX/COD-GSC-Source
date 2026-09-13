/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\rewards_cp.gsc
***********************************************/

init() {
  thread _id_C23F6A9DE8CBD94E();
}

_id_A48A39A256E53D99() {
  self setplayerdata("cp", "lastRaidReward", "None");
  self setplayerdata("cp", "lastRaidVeteranReward", "None");
  self setplayerdata("cp", "lastRaidOperatorReward", "None");
}

_id_C23F6A9DE8CBD94E() {
  wait 15;

  foreach(player in level.players) {
    if(!isDefined(game["resetClassifiedRewards"])) {
      player setplayerdata("cp", "lastRaidClassifiedReward", "None");
      game["resetClassifiedRewards"] = 1;
    }
  }
}

_id_4EC90E865BD62BF5() {
  foreach(player in level.players) {
    _id_A0897B14E0F4554B = _id_3093B5325D166784(player, "currentCPOperatorRewards", 6, "operatorReward");

    if(!isDefined(_id_A0897B14E0F4554B) || _id_A0897B14E0F4554B == "None" || _id_A0897B14E0F4554B == "") {
      player setplayerdata("cp", "lastRaidOperatorReward", "None");
      return;
    }

    player setplayerdata("cp", "lastRaidOperatorReward", _id_A0897B14E0F4554B);
    _id_11D65784F0B6AFA2 = undefined;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 6; _id_AC0E594AC96AA3A8++) {
      _id_571243C3116B8611 = player getplayerdata("cp", "currentCPOperatorRewards", _id_AC0E594AC96AA3A8);

      if(_id_571243C3116B8611 == "") {
        _id_11D65784F0B6AFA2 = _id_AC0E594AC96AA3A8;
        break;
      }
    }

    if(isDefined(_id_11D65784F0B6AFA2))
      player setplayerdata("cp", "currentCPOperatorRewards", _id_11D65784F0B6AFA2, _id_A0897B14E0F4554B);
  }
}

_id_31124F4DD33AD7F2() {
  foreach(player in level.players) {
    _id_1A2A9E3820387FE1 = player getplayerdata("cp", "lastRaidClassifiedReward");

    if(!isDefined(_id_1A2A9E3820387FE1) || _id_1A2A9E3820387FE1 == "") {
      return;
    }
    _id_11D65784F0B6AFA2 = undefined;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
      _id_571243C3116B8611 = player getplayerdata("cp", "currentCPClassifiedRewards", _id_AC0E594AC96AA3A8);

      if(_id_571243C3116B8611 == "") {
        _id_11D65784F0B6AFA2 = _id_AC0E594AC96AA3A8;
        break;
      }
    }

    if(isDefined(_id_11D65784F0B6AFA2))
      player setplayerdata("cp", "currentCPClassifiedRewards", _id_11D65784F0B6AFA2, _id_1A2A9E3820387FE1);
  }
}

_id_E0E2F13DEC46E52E() {
  foreach(player in level.players) {
    _id_A0897B14E0F4554B = _id_3093B5325D166784(player, "currentCPVeteranRewards", 6, "veteranReward");

    if(!isDefined(_id_A0897B14E0F4554B) || _id_A0897B14E0F4554B == "None" || _id_A0897B14E0F4554B == "") {
      player setplayerdata("cp", "lastRaidVeteranReward", "None");
      return;
    }

    player setplayerdata("cp", "lastRaidVeteranReward", _id_A0897B14E0F4554B);
    _id_11D65784F0B6AFA2 = undefined;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 6; _id_AC0E594AC96AA3A8++) {
      _id_571243C3116B8611 = player getplayerdata("cp", "currentCPVeteranRewards", _id_AC0E594AC96AA3A8);

      if(_id_571243C3116B8611 == "") {
        _id_11D65784F0B6AFA2 = _id_AC0E594AC96AA3A8;
        break;
      }
    }

    if(isDefined(_id_11D65784F0B6AFA2))
      player setplayerdata("cp", "currentCPVeteranRewards", _id_11D65784F0B6AFA2, _id_A0897B14E0F4554B);
  }
}

_id_2CA23024661E30AE() {
  foreach(player in level.players) {
    _id_A0897B14E0F4554B = _id_3093B5325D166784(player, "currentCPRaidRewards", 36, "lootPool", 1);
    _id_9CDDE83413E9A220 = _func_96B7FC7E35353254(_id_A0897B14E0F4554B);
    player _meth_DB073176839D77FB("49", [8, scripts\cp\challenges_cp::_id_2B0B870D1CF29ADD(), 9, scripts\cp\challenges_cp::_id_2FF6FAC4CF0827A6(), 32, 1, 31, 1, 46, _id_9CDDE83413E9A220]);

    if(!isDefined(_id_A0897B14E0F4554B)) {
      return;
    }
    player setplayerdata("cp", "lastRaidReward", _id_A0897B14E0F4554B);

    if(_id_A0897B14E0F4554B == "None" || _id_A0897B14E0F4554B == "raid_default_reward_xp") {
      return;
    }
    _id_11D65784F0B6AFA2 = undefined;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 36; _id_AC0E594AC96AA3A8++) {
      _id_571243C3116B8611 = player getplayerdata("cp", "currentCPRaidRewards", _id_AC0E594AC96AA3A8);

      if(_id_571243C3116B8611 == "") {
        _id_11D65784F0B6AFA2 = _id_AC0E594AC96AA3A8;
        break;
      }
    }

    if(isDefined(_id_11D65784F0B6AFA2))
      player setplayerdata("cp", "currentCPRaidRewards", _id_11D65784F0B6AFA2, _id_A0897B14E0F4554B);
  }
}

_id_3093B5325D166784(player, _id_3575406D63F16FBD, _id_C3B6A33ABA86A99F, _id_0F0B26F5F8DB069E, _id_EF2F7E4F923F3DDE) {
  _id_CE5E1C3A9C1157B6 = scripts\cp\challenges_cp::_id_862A7D40F77A77D6(level.script);
  _id_EA48CDFFC3F2753B = _id_FA4C5FAEDACEE161(_id_CE5E1C3A9C1157B6, _id_0F0B26F5F8DB069E);

  if(!isDefined(_id_EA48CDFFC3F2753B))
    return undefined;

  _id_24A619EA4813D4BA = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C3B6A33ABA86A99F; _id_AC0E594AC96AA3A8++)
    _id_24A619EA4813D4BA[_id_24A619EA4813D4BA.size] = player getplayerdata("cp", _id_3575406D63F16FBD, _id_AC0E594AC96AA3A8);

  _id_8B11F807A986C94A = _id_EA48CDFFC3F2753B;

  if(isDefined(_id_24A619EA4813D4BA)) {
    foreach(reward in _id_24A619EA4813D4BA) {
      if(reward == "") {
        continue;
      }
      _id_11D65784F0B6AFA2 = 0;

      foreach(_id_B4B2CB55CC84139B in _id_EA48CDFFC3F2753B) {
        if(_id_B4B2CB55CC84139B == reward)
          _id_8B11F807A986C94A = scripts\engine\utility::array_remove_index(_id_8B11F807A986C94A, _id_11D65784F0B6AFA2, 1);

        _id_11D65784F0B6AFA2++;
      }
    }
  }

  if(!isDefined(_id_EA48CDFFC3F2753B) || !isDefined(_id_8B11F807A986C94A) || _id_8B11F807A986C94A.size <= 0)
    return "None";

  _id_EA48CDFFC3F2753B = _id_8B11F807A986C94A;

  if(istrue(_id_EF2F7E4F923F3DDE))
    return scripts\engine\utility::random(_id_EA48CDFFC3F2753B);

  return _id_EA48CDFFC3F2753B[0];
}

_id_C168D1E4F69482F6(_id_CE5E1C3A9C1157B6) {
  switch (_id_CE5E1C3A9C1157B6) {
    case "raid_s1":
      return ["raids1_reward_blueprint_veteran"];
    case "raid_s2":
      return ["raids2_reward_blueprint_veteran"];
    case "raid_s3":
      return ["raids3_reward_camo_veteran"];
    case "raid_s4":
      return ["raids4_reward_camo_veteran"];
    case "raid_s5":
    default:
      break;
  }

  return undefined;
}

_id_688238FFEA60E929(_id_CE5E1C3A9C1157B6) {
  switch (_id_CE5E1C3A9C1157B6) {
    case "raid_s1":
      return ["raids1_operator_reward_gaz_base"];
    case "raid_s2":
      return ["raids2_operator_reward_price_skin"];
    case "raid_s3":
      return ["raids3_operator_reward_alex_base"];
    case "raid_s4":
      return ["raids4_operator_reward_farah_skin"];
    case "raid_s5":
    default:
      break;
  }

  return undefined;
}

_id_57926BE9277192BD(_id_CE5E1C3A9C1157B6) {
  switch (_id_CE5E1C3A9C1157B6) {
    case "raid_s1":
      return ["raids1_reward_random_1", "raids1_reward_random_2", "raids1_reward_random_3", "raids1_reward_random_4", "raids1_reward_random_5", "raids1_reward_random_6", "raids1_reward_random_7", "raids1_reward_random_special", "raids1_reward_random_loot_camo"];
    case "raid_s2":
      return ["raids2_reward_random_1", "raids2_reward_random_2", "raids2_reward_random_3", "raids2_reward_random_4", "raids2_reward_random_5", "raids2_reward_random_6", "raids2_reward_random_loot_camo"];
    case "raid_s3":
      return ["raids3_reward_random_1", "raids3_reward_random_2", "raids3_reward_random_3", "raids3_reward_random_4", "raids3_reward_random_5"];
    case "raid_s4":
      return ["raids4_reward_random_1", "raids4_reward_random_2", "raids4_reward_random_3"];
    case "raid_s5":
    default:
      break;
  }

  return undefined;
}

_id_FA4C5FAEDACEE161(_id_CE5E1C3A9C1157B6, _id_0F0B26F5F8DB069E) {
  switch (_id_0F0B26F5F8DB069E) {
    case "lootPool":
      return _id_57926BE9277192BD(_id_CE5E1C3A9C1157B6);
    case "veteranReward":
      return _id_C168D1E4F69482F6(_id_CE5E1C3A9C1157B6);
    case "operatorReward":
      return _id_688238FFEA60E929(_id_CE5E1C3A9C1157B6);
  }

  return undefined;
}

_id_1CAA50F367871948() {
  _id_E67E4CF4818D083F = _func_96B7FC7E35353254("collect_intel_single");
  self _meth_DB073176839D77FB("49", [8, scripts\cp\challenges_cp::_id_2B0B870D1CF29ADD(), 9, scripts\cp\challenges_cp::_id_2FF6FAC4CF0827A6(), 32, 1, 31, 1, 46, _id_E67E4CF4818D083F]);
}

_id_5DA13CAC404268CB() {
  _id_BA11A925EC503D8B = self getplayerdata("cp", "totalIntel");

  if(_id_BA11A925EC503D8B % 5 != 0) {
    return;
  }
  _id_6A9C5706DEB202EE = self getplayerdata("cp", "intelCollectFiveRewardAmount");
  self setplayerdata("cp", "intelCollectFiveRewardAmount", _id_6A9C5706DEB202EE + 1);
  _id_0998572FF3C96EE5::_id_9B50C58F20B295A0(2);
  _id_3E5376D61BCAD7AC = _func_96B7FC7E35353254("collect_intel_5");
  self _meth_DB073176839D77FB("49", [8, scripts\cp\challenges_cp::_id_2B0B870D1CF29ADD(), 9, scripts\cp\challenges_cp::_id_2FF6FAC4CF0827A6(), 32, 1, 31, 1, 46, _id_3E5376D61BCAD7AC]);
}

_id_A4C89EA948DEBCA4() {
  _id_9A1612BF33A317B1 = _id_0998572FF3C96EE5::_id_3E1F4EC9F2EA7F0A();

  switch (_id_9A1612BF33A317B1) {
    case "BadSituation":
      return "saba_hydro";
    case "HeliEscort":
      return "high_ground_cp";
    case "VehicleEscape":
      return "denied_area_cp";
    case "Observatory":
      return "saba_observatory";
    case "Raid1":
      return "raid_s1";
    case "Raid2":
      return "raid_s2";
    case "Raid3":
      return "raid_s3";
    case "Raid4":
      return "raid_s4";
  }

  return undefined;
}