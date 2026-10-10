/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4a941421347ff7df.gsc
*************************************************/

#using script_1076881dd9127338;
#using script_1129f4e2809425c6;
#using script_150fee7943687302;
#using script_167e09f10d782e78;
#using script_1e222fe3807b7bbc;
#using script_220c6074df4c7bdf;
#using script_22594d942a4f2fa9;
#using script_25a72681f753607e;
#using script_25b55d37e1b51db1;
#using script_2cf4d0a5e1f4c42d;
#using script_2ec1c057e82a640b;
#using script_3007ab53fd0a8edd;
#using script_3268ad8ab0c4f9b1;
#using script_32abd1c08a25abb5;
#using script_35db96c50ef6a61d;
#using script_3745817abb376b9d;
#using script_37d9a569491ff1e0;
#using script_3cb249814629d5e0;
#using script_47366beb5ba9fa22;
#using script_4ae1a952802852f7;
#using script_4f76bee355450e6d;
#using script_501c83126d4115ec;
#using script_5120873d6d2bb7e2;
#using script_59ff79d681bb860c;
#using script_5adad3b6e57811aa;
#using script_60e4c40d98acb785;
#using script_626264ce9b97c032;
#using script_634fa918fe0019d;
#using script_67bad8bd9685e057;
#using script_6a3a688cced14074;
#using script_74a406321183b21c;
#using script_7845ba34dcf9b77b;
#using script_7a9487f45303d680;
#using script_7bf46d34c10761a4;
#using script_7c79573f6d201a19;
#using script_7f01b0f20c9a2371;
#using script_7fc58c95ee47d870;
#using script_9963540126262c0;
#using script_ca34b05781dbece;
#using script_d74ae0b4aa21186;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\utility\game;
#namespace namespace_908c3afba93448e0;

function createevents() {
  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    function_8cda6b3ceb41b954();
    return;
  }

  function_8cc46f3ceb298eed();
}

function function_8cda6b3ceb41b954() {
  var_a98b3380019fd8a1 = 16000;
  namespace_5524884c16a95af2::createevent(var_a98b3380019fd8a1);
  var_e217a69d1c18e3a4 = 500;
  var_aa0962b79aaca485 = 2000;
  var_c30b9eb47d7fc21c = 9750;
  var_dc4d6d091a7eaa09 = 15;
  var_daf0a79cbe5456f6 = 10;
  var_23ede9cf81e42751 = 5;
  var_f529e9d51b8862 = 100;
  var_19c46b946fcc822d = 2000;
  namespace_10ca308be68952f::createevent(var_e217a69d1c18e3a4, var_dc4d6d091a7eaa09, var_aa0962b79aaca485, var_daf0a79cbe5456f6, var_c30b9eb47d7fc21c, var_23ede9cf81e42751, var_f529e9d51b8862, var_19c46b946fcc822d);
  var_baaae12f3f1cdad5 = 2000;
  namespace_9d48dceb90164d92::createevent(var_baaae12f3f1cdad5);
  var_5a44d4572d4ec0e2 = 2000;
  namespace_a88fd88e39d4308::createevent(var_5a44d4572d4ec0e2);
  var_1d965b1314661f15 = 9750;
  namespace_bfa2898056f8354::createevent(var_1d965b1314661f15);
  var_58ee5ff98f39e423 = 3900;
  var_c4344c311d1fbf32 = 30;
  namespace_e3ef90d32ac66277::createevent(var_58ee5ff98f39e423, var_c4344c311d1fbf32);
  var_d2e251950c7cdfd = 7800;
  namespace_1bebff3a2e9afaca::createevent(var_d2e251950c7cdfd);
  var_2e702a0cbfbafa9e = 1500;
  var_6338ff0c91dfe49d = 5;
  namespace_27cc7cdc2e4475be::createevent(var_2e702a0cbfbafa9e, var_6338ff0c91dfe49d);
  var_1f1bda3809ebbd35 = 30000;
  namespace_3df563b7c04eb8eb::createevent(var_1f1bda3809ebbd35);
}

function function_8cc46f3ceb298eed() {
  var_a98b3380019fd8a1 = 7800;
  namespace_5524884c16a95af2::createevent(var_a98b3380019fd8a1);
  namespace_45524b6bc7f1f3ac::createevent();
  namespace_ba8cfebbc70bb00b::createevent();
}

function function_6930ba7fa0669dba() {
  function_572268dda1c23c7();

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return function_d8f79220efc2d24e();
  }

  return function_d8f28a20efbc97df();
}

function function_d8f79220efc2d24e() {
  descriptions = [];
  descriptions["Combat"] = function_4e8e4b3605e73a33(&namespace_9cdb9a9d76703787::function_eda57308516bfc5f, &combatconstants);
  descriptions["Wander"] = function_4e8e4b3605e73a33(&namespace_ea0055094e5fd26a::function_eda57308516bfc5f, &wanderconstants);
  descriptions["EscapeGas"] = function_4e8e4b3605e73a33(&namespace_83735fc2f7d3661a::function_eda57308516bfc5f, &function_5d12156b320f8674);
  descriptions["Pickup"] = function_4e8e4b3605e73a33(&namespace_351e75b9d115392f::function_eda57308516bfc5f, &pickupconstants);
  descriptions["KillstreakUAV"] = function_4e8e4b3605e73a33(&namespace_c8150390fc0bf61e::function_eda57308516bfc5f, &function_d5a3be7287e9a86a);
  descriptions["KillstreakAirstrike"] = function_4e8e4b3605e73a33(&namespace_afdc3db19e194d5c::function_eda57308516bfc5f, &function_7a44b3ec454cfba0);
  descriptions["EquipArmor"] = function_4e8e4b3605e73a33(&namespace_44e61c324d97fb99::function_eda57308516bfc5f, &function_5c136b5eb48ca3cf);
  descriptions["ReviveTeammate"] = function_4e8e4b3605e73a33(&namespace_503872f9ebd8a16f::function_eda57308516bfc5f, &function_5bf82db35aea77e5);
  descriptions["BuyItem"] = function_4e8e4b3605e73a33(&namespace_30e7da3797ac6a02::function_eda57308516bfc5f, &function_aee45e6f09410216);
  descriptions["BuyBackTeammate"] = function_4e8e4b3605e73a33(&namespace_81bf0a6af1cb8b9b::function_eda57308516bfc5f, &function_bcfc6cfe13faa2f2);
  descriptions["SearchThreatPlus"] = function_4e8e4b3605e73a33(&namespace_1580a10821910b9d::function_eda57308516bfc5f, &function_8f613fdda808e996);
  descriptions["SearchThreat"] = function_4e8e4b3605e73a33(&namespace_f579db4f1fdf0250::function_eda57308516bfc5f, &function_d4bd9ff9c32e7fd6);
  descriptions["GoToCampPosition"] = function_4e8e4b3605e73a33(&namespace_a3991156b838ed2d::function_eda57308516bfc5f, &function_2ca23c5b750be895);
  descriptions["SniperCombat"] = function_4e8e4b3605e73a33(&namespace_82adac1fd015a505::function_eda57308516bfc5f, &function_194933a246c12c3f);
  descriptions["LastStand"] = function_4e8e4b3605e73a33(&namespace_da6770cba19d3de9::function_eda57308516bfc5f, undefined);
  descriptions["UseFieldUpgradeBox"] = function_4e8e4b3605e73a33(&namespace_7943786f962b6434::function_eda57308516bfc5f, &function_222ab0653b177ae);
  descriptions["EvadeCars"] = function_4e8e4b3605e73a33(&namespace_f8811166da0885e6::function_eda57308516bfc5f, &function_40064f9911317199);
  descriptions["Retreat"] = function_4e8e4b3605e73a33(&namespace_2730bb41e47f262e::function_eda57308516bfc5f, &retreatconstants);

  if(getdvarint(@ "hash_82bde055b11e6698", 0)) {
    descriptions["PerformReconContract"] = function_4e8e4b3605e73a33(&namespace_f36e2473a69e9caf::function_eda57308516bfc5f, &function_6e26a8349c0590a8);
  }

  return descriptions;
}

function function_d8f28a20efbc97df() {
  descriptions = [];
  descriptions["Combat"] = function_4e8e4b3605e73a33(&namespace_784dc078726182cc::function_eda57308516bfc5f, &namespace_5b4dcb5b6fd9c18::combatconstants);
  descriptions["Wander"] = function_4e8e4b3605e73a33(&namespace_37deded6c75bc7e5::function_eda57308516bfc5f, &namespace_5b4dcb5b6fd9c18::wanderconstants);
  descriptions["CaptureFlag"] = function_4e8e4b3605e73a33(&namespace_4c49d1b7e0800f5::function_eda57308516bfc5f, &namespace_5b4dcb5b6fd9c18::function_a785de697f238498);
  descriptions["CaptureFlagGW"] = function_4e8e4b3605e73a33(&namespace_500245c51ae01944::function_eda57308516bfc5f, &namespace_5b4dcb5b6fd9c18::function_9a5ee96584bc41da);
  descriptions["CaptureHardpoint"] = function_4e8e4b3605e73a33(&namespace_ef3d9df38f736e0::function_eda57308516bfc5f, &namespace_5b4dcb5b6fd9c18::function_1715d4b0af35742b);
  descriptions["ControlFob"] = function_4e8e4b3605e73a33(&namespace_3c545500807c3c91::function_eda57308516bfc5f, &namespace_5b4dcb5b6fd9c18::function_8c99be760680f663);
  return descriptions;
}

function function_572268dda1c23c7() {
  if(isDefined(level.mind.personalities)) {
    return;
  }

  personalities = [];
  var_2b22a39e9c6dc326 = 0;
  proportions = function_d34639184a627e9c();

  foreach(name, proportion in proportions) {
    assertex(proportion >= 0, "<dev string:x1c>" + name + "<dev string:x40>");
    var_2b22a39e9c6dc326 += proportion;
    personality = spawnStruct();
    personality.proportion = proportion;
    personality.var_141f7edd65e37a2d = function_3d84d2156c8e641a(name);
    personalities[name] = personality;
  }

  assert(var_2b22a39e9c6dc326 > 0);

  foreach(personality in personalities) {
    personality.proportion /= var_2b22a39e9c6dc326;
  }

  level.mind.personalities = personalities;
}

function function_d34639184a627e9c() {
  proportions = [];
  proportions["default"] = getdvarfloat(@ "hash_dfd0051082e1f237", 1);
  proportions["sniper"] = getdvarfloat(@ "hash_8a746ee0f068d111", 0);
  proportions["automation"] = getdvarfloat(@ "scr_bot_mind_personality_proportion_automation", 0);
  proportions["babysitter"] = getdvarfloat(@ "hash_eaeeb4a12c7dcde5", 0);
  return proportions;
}

function function_3d84d2156c8e641a(mind_personality) {
  decisionset = function_63cc4ce09c4659a1("GetDecisionSet", mind_personality);

  if(isDefined(decisionset)) {
    return decisionset;
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return function_7820c266fca9bbae(mind_personality);
  }

  return function_781cba66fca5b43f(mind_personality);
}

function function_7820c266fca9bbae(mind_personality) {
  switch (mind_personality) {
    case #"hash_7038dec66d8275be":
    case #"hash_79cb20639fcda706":
      return function_72e3dda65a3b89b3();
    case #"hash_6191aaef9f922f96":
      return array_combine(function_72e3dda65a3b89b3(), function_72c9dc29c073ef29());
    case #"hash_2a3c28f3f1f0f8a":
      return function_910da6c2ab1873e1();
    default:
      assertmsg("<dev string:x5c>");
      return undefined;
  }
}

function function_72e3dda65a3b89b3() {
  var_577f45571c039a54 = ["Combat", "Wander", "EscapeGas", "Pickup", "KillstreakUAV", "KillstreakAirstrike", "EquipArmor", "ReviveTeammate", "BuyItem", "BuyBackTeammate", "LastStand", "UseFieldUpgradeBox", "EvadeCars", "Retreat"];

  if(getdvarint(@ "hash_82bde055b11e6698", 0)) {
    var_577f45571c039a54[var_577f45571c039a54.size] = "PerformReconContract";
  }

  if(getdvarint(@ "hash_ea782447055712da", 1)) {
    var_577f45571c039a54[var_577f45571c039a54.size] = "SearchThreatPlus";
  } else {
    var_577f45571c039a54[var_577f45571c039a54.size] = "SearchThreat";
  }

  return var_577f45571c039a54;
}

function function_72c9dc29c073ef29() {
  return ["GoToCampPosition", "SniperCombat"];
}

function function_910da6c2ab1873e1() {
  return ["Combat", "Wander", "EscapeGas", "Pickup", "KillstreakUAV", "KillstreakAirstrike", "EquipArmor", "ReviveTeammate", "BuyItem", "BuyBackTeammate", "SearchThreatPlus", "LastStand", "UseFieldUpgradeBox", "EvadeCars", "Retreat"];
}

function function_781cba66fca5b43f(mind_personality) {
  switch (mind_personality) {
    case #"hash_6191aaef9f922f96":
    case #"hash_7038dec66d8275be":
    case #"hash_79cb20639fcda706":
      return function_e65493518b3de050();
    case #"hash_2a3c28f3f1f0f8a":
      return function_bc926da9a7f24b80();
    default:
      assertmsg("<dev string:x5c>");
      return undefined;
  }
}

function function_e65493518b3de050() {
  return ["Combat", "Wander"];
}

function function_bc926da9a7f24b80() {
  decisionset = function_e65493518b3de050();

  if(scripts\cp_mp\utility\game_utility::function_22cd3d64fdb05892()) {
    decisionset[decisionset.size] = "CaptureFlagGW";
  }

  return decisionset;
}

function function_bfa5c0c232ced7eb() {
  assert(isDefined(self.mind_personality));
  personality = level.mind.personalities[self.mind_personality];
  assert(isDefined(personality));
  return personality.var_141f7edd65e37a2d;
}

function function_68397cb2cf3494e9() {
  return &namespace_41f4dfb71dd08362::function_6ddd1f755a24720f;
}

function function_dd6540682cd2ab87() {
  assert(isDefined(self.mind_personality));
  subgametype = getsubgametype();
  botmindpersonality = self.mind_personality;
  botdifficulty = self botgetdifficulty();
  return [subgametype + "." + botmindpersonality + "." + botdifficulty, subgametype + "." + botmindpersonality + ".*", subgametype + ".*." + botdifficulty, subgametype + ".*.*", "*." + botmindpersonality + "." + botdifficulty, "*." + botmindpersonality + ".*", "*.*." + botdifficulty, ""];
}

function function_f56bbc9f43769ff6(var_408125c9df18460e, matchlist) {
  for(index = 0; index < matchlist.size; index++) {
    metatag = matchlist[index];
    var_39b811fb3872bdb8 = var_408125c9df18460e[metatag];

    if(isDefined(var_39b811fb3872bdb8)) {
      return var_39b811fb3872bdb8;
    }
  }

  assertmsg("<dev string:x7d>");
  return undefined;
}