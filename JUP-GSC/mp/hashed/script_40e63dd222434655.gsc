/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_40e63dd222434655.gsc
*************************************************/

#using script_110fd2130c2ed1fe;
#using script_26ccbfe3954cacf4;
#using script_3904cfff5ce7fdcb;
#using script_40e63dd222434655;
#using script_4a6760982b403bad;
#using script_4c9bd9a3bf3f8cf7;
#using script_5120873d6d2bb7e2;
#using script_59ff79d681bb860c;
#using script_6388860e9e2a83bd;
#using script_64acb6ce534155b7;
#using script_72af5a878a9d3397;
#using script_d74ae0b4aa21186;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\gasmask;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots_gametype_br;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\bots\bots_util;
#using scripts\mp\class;
#using scripts\mp\equipment;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_armory_kiosk;
#using scripts\mp\gametypes\br_assassination_quest;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_spectate;
#using scripts\mp\gametypes\br_vip_quest;
#using scripts\mp\gametypes\br_weapons;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#namespace namespace_7823423e849112c7;

function onmain() {
  level.bot_funcs["player_spawned_gamemode"] = &spawned;
  level.bot_funcs["gametype_think"] = &function_f7453e13040e1140;
  level.bot_funcs["select_class_from_airdrop"] = &function_5b54ecc3b227f84d;
  level.bot_funcs["revive_think"] = &void;
  namespace_56b9cc3deb6e3f5e::globalinitialize(level.var_18c3a736721cd3a4);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("accelerateBotsGulagMatch", &function_b5e22620a8778c4a);

  function_c8cc3e3589f34923(level.br_level.var_61321b51908d55cb);
  function_c8cc3e3589f34923(level.br_level.var_61321c51908d57fe);
}

function function_5865e18adb02de38() {
  function_c31d67862e4c9341();
  level.var_7d43ccdc62f43db3 = &onmain;
  level.bots_gametype_handles_class_choice = !istrue(level.var_66113aa6fc12be57);
  registerbrgametypefunc("onSpawnPlayer", &onspawnplayer);
  registerbrgametypefunc("mayConsiderPlayerDead", &function_98ba4f8e00e49831);

  if(namespace_95d8d8ec67e3e074::isenabled()) {
    registerbrgametypefunc("onPlayerConnect", &namespace_95d8d8ec67e3e074::onplayerconnect);
    registerbrgametypefunc("onPlayerDisconnect", &namespace_95d8d8ec67e3e074::onplayerdisconnect);
    registerbrgametypefunc("isTeamEliminated", &namespace_95d8d8ec67e3e074::isteameliminated);
  }

  scripts\mp\autopilot::initialize(undefined, &function_bb8b7cdce37ccab, &function_eac6ce0d8138984b);

  if(scripts\mp\utility\game::matchmakinggame()) {
    level thread function_f4cd8d89e37b4888();
  }
}

function private function_c31d67862e4c9341() {
  if(isusingmatchrulesdata() && !getdvarint(@ "hash_4f22ec718d3c74f6", 0)) {
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "brBotSurvivalCurveEnabled");
    setdynamicdvar(@ "hash_79500dabf3e1a102", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "botMindCombatExtraGrenadeThrow");
    setdynamicdvar(@ "hash_d118fed8f0c59f4d", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "botMindBrSniperCombatExtraGrenadeThrow");
    setdynamicdvar(@ "hash_7fc4f004028aa76", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "brBotRecycleEnabled");
    setdynamicdvar(@ "hash_b7fcb658021d7931", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "brBotUiBotMaxCount");
    setdynamicdvar(@ "hash_f3a6b99340f5a95f", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "brBotRespawnRecycleAllowed");
    setdynamicdvar(@ "hash_417e3b8c61f58e03", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "brBotRecycleDelaySec");
    setdynamicdvar(@ "hash_de394b7049bf2445", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "brBotRecycleNormal2DDistance");
    setdynamicdvar(@ "hash_d0dc9e305f43690", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "brBotRecycleLanding2DDistance");
    setdynamicdvar(@ "hash_81156fddeb6b5508", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "brBotRecycleInactiveTimeMs");
    setdynamicdvar(@ "hash_8f312094be1c23b0", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "brBotRandomFightIntervalSec");
    setdynamicdvar(@ "hash_e0ec70c334cf532a", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "brBotDormantToUiBotTimeMs");
    setdynamicdvar(@ "hash_3b0dbf95a91a8233", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "brBotDeployAroundHumanRadius");
    setdynamicdvar(@ "hash_358164e65d640280", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "brBotHumanUnengagedTimeMs");
    setdynamicdvar(@ "hash_e32340e297efbbdd", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "brIdlePenaltyTimeForUnengagedHuman");
    setdynamicdvar(@ "hash_9be4e2fbbfe8d9c5", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "brBotAirDeployChance");
    setdynamicdvar(@ "hash_e4a177febf5c5689", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "brBotClearPlotArmorTriggerHurtTimeoutSec");
    setdynamicdvar(@ "hash_b7f8b4b89ea6ced1", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "brBotPrematchActivePlayerMaxCount");
    setdynamicdvar(@ "hash_e82992eec48cf830", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "brBotGiveLoadoutDelay");
    setdynamicdvar(@ "hash_b18793f70e0f6b34", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "brBotGiveLoadoutDistance");
    setdynamicdvar(@ "hash_3da4efd986f095de", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "botDifficultyProportionRecruit");
    setdynamicdvar(@ "hash_60ae0d4490076046", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "botDifficultyProportionRegular");
    setdynamicdvar(@ "hash_55ccab727e144f34", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "botDifficultyProportionHardened");
    setdynamicdvar(@ "hash_b3f66372fb38fccb", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "botDifficultyProportionVeteran");
    setdynamicdvar(@ "hash_ff9490c8b80cf74f", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "botMindPersonalityProportionDefault");
    setdynamicdvar(@ "hash_dfd0051082e1f237", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "botMindPersonalityProportionSniper");
    setdynamicdvar(@ "hash_8a746ee0f068d111", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "botMindPersonalityProportionAutomation");
    setdynamicdvar(@ "scr_bot_mind_personality_proportion_automation", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "brMindCombatExpectedKillMaxInput");
    setdynamicdvar(@ "hash_b1dfabb180ed75b1", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "brMindCombatExpectedKillMaxOutput");
    setdynamicdvar(@ "hash_5057e020d534d5ee", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "botTargetTypeIncludeAgent");
    setdynamicdvar(@ "hash_484a3169a5caef10", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "damageRatioBotToBot");
    setdynamicdvar(@ "hash_19b1deee03b39dce", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "damageRatioBotToBotWithHumanTeammate");
    setdynamicdvar(@ "hash_72dce163d860183a", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "damageRatioBotToHumanFactorRecruit");
    setdynamicdvar(@ "hash_27c78d2661500e49", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "damageRatioBotToHumanFactorRegular");
    setdynamicdvar(@ "hash_1ab2939c54efab3f", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "damageRatioBotToHumanFactorHardened");
    setdynamicdvar(@ "hash_3fe6928216982556", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "damageRatioBotToHumanFactorVeteran");
    setdynamicdvar(@ "hash_9ee861df3ee7281c", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "damageRatioBotToHumanAddendRecruit");
    setdynamicdvar(@ "hash_c6db8f289a513376", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "damageRatioBotToHumanAddendRegular");
    setdynamicdvar(@ "hash_71720d5fda9ada04", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "damageRatioBotToHumanAddendHardened");
    setdynamicdvar(@ "hash_d3f0c08b944e8c3b", var_fce3d6d6d9b8fa75);
    var_fce3d6d6d9b8fa75 = getmatchrulesdata("ftueBotsData", "damageRatioBotToHumanAddendVeteran");
    setdynamicdvar(@ "hash_cc3a6aab020970df", var_fce3d6d6d9b8fa75);
  }
}

function spawned() {
  function_543a0a3113ff89f7();
  onbotspawnedcommon("Skydive");
  self.var_ab5f5270cb22e3c8 = 0;
  var_2eb0354a11a56b73 = isDefined(self.uibot) && isDefined(self.uibot.var_7dbb8165d792b06c);
  var_da17fcd71681c773 = isDefined(self.gulaguses) && self.gulaguses > 0;
  var_d2c758dfb50b7949 = !var_2eb0354a11a56b73 && !var_da17fcd71681c773 && !istrue(self.respawningfromtoken);

  if(var_d2c758dfb50b7949) {
    function_d9dcf5d9abdd5998();
  }

  self.initdifficulty = self botgetdifficulty();
  self botsetflag("allow_laststand_decision", 1);
  namespace_c50b30148766aa59::function_c827480e6d21a271();

  if(var_d2c758dfb50b7949 && !scripts\mp\gamelogic::inprematch()) {
    var_21e1f88e3b6c27bb = getmatchrulesdata("brData", "plunderStartAmount");
    var_d437bea518f94dd0 = getmatchrulesdata("brData", "plunderBotStartAmount");
    scripts\mp\gametypes\br_plunder::playersetplundercount(var_d437bea518f94dd0);
  }
}

function registerbrgametypefunc(name, func) {
  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined(name)) {
    assertmsg("<dev string:x1c>" + name + "<dev string:x32>");
    return;
  }

  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc(name, func);
}

function onspawnplayer() {
  val::nuke_all();

  if(!isbot(self) && isPlayer(self)) {
    vehicle_allowplayeruse(self, 1);
    thread namespace_27cc7cdc2e4475be::function_608ad5a3783431d9();
  }
}

function function_98ba4f8e00e49831(player) {
  if(isbot(player)) {
    return namespace_95d8d8ec67e3e074::function_fb4771e79218146b(player);
  }

  return undefined;
}

function function_f4cd8d89e37b4888() {
  function_6acbb2af086c64fa();
  level waittill("br_prematchEnded");
  function_6acbb2af086c64fa();

  foreach(player in level.players) {
    if(isbot(player)) {
      player function_d9dcf5d9abdd5998();
    }
  }

  if(isDefined(level.var_7b37b2193f163b9b)) {
    foreach(uibot in level.var_7b37b2193f163b9b.uibots) {
      uibot.difficulty = function_f09bcfcfe853f63f();
    }
  }
}

function function_d9dcf5d9abdd5998() {
  if(scripts\mp\utility\game::matchmakinggame()) {
    difficulty = function_f09bcfcfe853f63f();
  } else {
    difficulty = function_d55289ceec7cf934();
  }

  bot_set_difficulty(difficulty);
  function_8771893f1bcb49bb(self, difficulty);

  if(scripts\mp\utility\game::getsubgametype() == "rumble_mgl") {
    var_3dfe644341de1e18 = self botgetdifficultysetting("strafeWeaponMaxRangeMultiplier");
    self botsetdifficultysetting("strafeWeaponMaxRangeMultiplier", var_3dfe644341de1e18 + 0.5);
    var_2e222bbaea1f163a = self botgetdifficultysetting("strafeWeaponMinRangeMultiplier");
    self botsetdifficultysetting("strafeWeaponMinRangeMultiplier", var_2e222bbaea1f163a + 0.5);
  }
}

function function_8771893f1bcb49bb(bot, difficulty) {
  var_7e2c53b0bcf117d9 = spawnStruct();
  var_7e2c53b0bcf117d9.bot = bot;
  var_7e2c53b0bcf117d9.difficulty = difficulty;
  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_on_bot_set_difficulty", var_7e2c53b0bcf117d9);
}

function function_f09bcfcfe853f63f() {
  randompick = randomfloat(1);
  randompick -= level.var_9f9aee78f75f1519[0];

  if(randompick <= 0) {
    return "recruit";
  }

  randompick -= level.var_9f9aee78f75f1519[1];

  if(randompick <= 0) {
    return "regular";
  }

  randompick -= level.var_9f9aee78f75f1519[2];

  if(randompick <= 0) {
    return "hardened";
  }

  randompick -= level.var_9f9aee78f75f1519[3];

  if(randompick <= 0) {
    return "veteran";
  }

  assertmsg("<dev string:x4a>");
  return "regular";
}

function function_6acbb2af086c64fa() {
  var_3d1db28cd6cdd65e = function_de4dbfc4bf8e46b7();
  var_22ba435fe8f3e8f6 = function_9467e76f2bdbd0eb(var_3d1db28cd6cdd65e);
  var_f8793c23a0ec47ab = var_22ba435fe8f3e8f6[0] + var_22ba435fe8f3e8f6[1] + var_22ba435fe8f3e8f6[2] + var_22ba435fe8f3e8f6[3];
  var_22ba435fe8f3e8f6[0] /= var_f8793c23a0ec47ab;
  var_22ba435fe8f3e8f6[1] /= var_f8793c23a0ec47ab;
  var_22ba435fe8f3e8f6[2] /= var_f8793c23a0ec47ab;
  var_22ba435fe8f3e8f6[3] /= var_f8793c23a0ec47ab;
  level.var_9f9aee78f75f1519 = var_22ba435fe8f3e8f6;
}

function function_de4dbfc4bf8e46b7() {
  partymembers = getpartyinfo();
  var_3a8bf6b9f6916e85 = [];

  foreach(memberinfo in partymembers) {
    if(!memberinfo.isai && isDefined(memberinfo.performance)) {
      var_3a8bf6b9f6916e85[var_3a8bf6b9f6916e85.size] = memberinfo.performance;
    }
  }

  assert(var_3a8bf6b9f6916e85.size > 0);
  var_3a8bf6b9f6916e85 = array_sort_with_func(var_3a8bf6b9f6916e85, &function_b0b032b5db8cdd66);
  return var_3a8bf6b9f6916e85[int(var_3a8bf6b9f6916e85.size / 2)];
}

function function_b0b032b5db8cdd66(value1, value2) {
  return value1 < value2;
}

function function_9467e76f2bdbd0eb(performancevalue) {
  assert(performancevalue <= 1000 && performancevalue >= -1000);
  performancevalue /= 1000;
  var_60ca8d97eb9cab53 = function_6c4f073450168827();
  lastmin = -1;
  returnindex = -1;

  for(index = 0; index < var_60ca8d97eb9cab53.size; index++) {
    maxrange = var_60ca8d97eb9cab53[index][0];

    if(performancevalue >= lastmin && performancevalue <= maxrange) {
      returnindex = index;
      break;
    }

    lastmin = maxrange;
  }

  if(returnindex < 0) {
    assertmsg("<dev string:xaf>");
    returnindex = var_60ca8d97eb9cab53.size - 1;
  }

  return [var_60ca8d97eb9cab53[returnindex][1], var_60ca8d97eb9cab53[returnindex][2], var_60ca8d97eb9cab53[returnindex][3], var_60ca8d97eb9cab53[returnindex][4]];
}

function function_6c4f073450168827() {
  rowcount = getdvarint(@ "hash_8b89c88ebbde4299");

  if(rowcount <= 0) {
    return function_b5b189c89f00beb8("The value of config dvar 'scr_skill_based_bot_difficulties_config_count' is invalid.");
  }

  var_60ca8d97eb9cab53 = [];
  previousmaxrange = -1;

  for(index = 1; index <= rowcount; index++) {
    dvar = hashcat(@ "scr_skill_based_bot_difficulties_config_", index);
    rowstr = getDvar(dvar);

    if(rowstr == "") {
      return function_b5b189c89f00beb8("The config dvar 'scr_skill_based_bot_difficulties_config_" + index + "' is empty.");
    }

    columns = [];
    values = strtok(rowstr, ",");

    foreach(value in values) {
      columns[columns.size] = float(value);
    }

    if(columns.size != 5) {
      return function_b5b189c89f00beb8("The columns count of the dvar 'scr_skill_based_bot_difficulties_config_" + index + "' is not valid.");
    }

    if(columns[0] <= previousmaxrange || columns[0] > 1) {
      return function_b5b189c89f00beb8("The performance max range is not valid in the dvar 'scr_skill_based_bot_difficulties_config_" + index + "' .");
    }

    previousmaxrange = columns[0];
    var_60ca8d97eb9cab53[var_60ca8d97eb9cab53.size] = columns;
  }

  if(previousmaxrange != 1) {
    var_60ca8d97eb9cab53[var_60ca8d97eb9cab53.size - 1][0] = 1;
  }

  return var_60ca8d97eb9cab53;
}

function function_b5b189c89f00beb8(errormsg) {
  assertmsg(errormsg);
  return [[-0.2, 10, 0, 0, 0], [-0.15, 7, 3, 0, 0], [0, 5, 3, 2, 0], [0.3, 3, 3, 3, 1], [0.8, 1, 3, 3, 3], [0.9, 0, 1, 1, 8], [1, 0, 0, 1, 9]];
}

function function_92a85a0dda6ca085(damagedata) {
  var_dfabe685a74f1b33 = isDefined(damagedata.victim) && isbot(damagedata.victim) && damagedata.victim namespace_c50b30148766aa59::function_6f6c5cb39cd095b0();
  modifieddamage = namespace_41f4dfb71dd08362::function_d111733407f6518(damagedata.meansofdeath, damagedata.victim, damagedata.attacker, damagedata.damage, 1, var_dfabe685a74f1b33);
  return modifieddamage;
}

function function_a12de8d6fa23a4d9() {
  if(scripts\mp\gamelogic::inprematch()) {
    return undefined;
  }

  if(!istrue(level.var_c61af0e49678f2ba)) {
    level.var_c61af0e49678f2ba = 1;
    var_3d1db28cd6cdd65e = undefined;

    if(scripts\mp\utility\game::matchmakinggame()) {
      var_3d1db28cd6cdd65e = function_de4dbfc4bf8e46b7();
    } else {
      var_3d1db28cd6cdd65e = getdvarfloat(@ "hash_502ea1a19a22a22f", 0);
    }

    level.var_935fc4498c2f463d = clamp(var_3d1db28cd6cdd65e / 1000, -1, 1);
    level.var_6916d2bb0277da6e = function_ac985998f660d63d();
  }

  if(!isDefined(level.var_6916d2bb0277da6e) || level.var_6916d2bb0277da6e.size < 1) {
    return undefined;
  }

  rowindex = level.var_6916d2bb0277da6e.size - 1;

  for(index = 0; index < level.var_6916d2bb0277da6e.size; index++) {
    if(level.var_935fc4498c2f463d <= level.var_6916d2bb0277da6e[index][0]) {
      rowindex = index;
      break;
    }
  }

  return level.var_6916d2bb0277da6e[rowindex];
}

function function_ac985998f660d63d() {
  rowcount = getdvarint(@ "hash_eff52385b9663477");

  if(rowcount <= 0) {
    assertmsg("<dev string:xee>");
    return [];
  }

  var_a95a701fc50363c9 = [];

  for(index = 1; index <= rowcount; index++) {
    dvar = hashcat(@ "hash_9e9368fde1b1a498", index);
    rowstr = getDvar(dvar);

    if(rowstr == "") {
      assertmsg("<dev string:x14f>" + index + "<dev string:x195>");
      return [];
    }

    values = strtok(rowstr, ",");

    if(values.size != 3) {
      assertmsg("<dev string:x1a4>" + index + "<dev string:x1f8>");
      return [];
    }

    var_a95a701fc50363c9[var_a95a701fc50363c9.size] = (float(values[0]), float(values[1]), float(values[2]));
  }

  var_a95a701fc50363c9 = array_sort_with_func(var_a95a701fc50363c9, &function_41ee7f6310c3975a);
  return var_a95a701fc50363c9;
}

function function_41ee7f6310c3975a(lhs, rhs) {
  return lhs[0] < rhs[0];
}

function function_f7453e13040e1140() {
  self.var_deb55e4a0429ef1 = 1;
  self.desiredlandingspot = undefined;
  self notify("bot_br_super_think");
  self endon("bot_br_super_think");
  self endon("bot_suspended");
  self endon("death_or_disconnect");
  level endon("game_ended");
  namespace_c50b30148766aa59::function_83574001589fb42d();

  if(scripts\mp\gamelogic::inprematch()) {
    if(namespace_95d8d8ec67e3e074::tryrecycle(1, 0)) {
      return;
    }
  } else if(istrue(level.skipprematch) && !istrue(level.br_infils_disabled)) {
    if(namespace_95d8d8ec67e3e074::tryrecycle(2, 0)) {
      return;
    }
  }

  childthread function_3b14fd3847fb5fe6();
  childthread function_290494c263cb346d();
  childthread function_b4b715fd038025c6();

  while(true) {
    if(getdvarint(@ "hash_c2de8ca6dc8512c1") || self.sessionstate == "<dev string:x20b>") {
      wait 0.05;
      continue;
    }

    if(namespace_95d8d8ec67e3e074::isuibot()) {
      wait 0.05;
      continue;
    }

    if(!scripts\mp\gametypes\br_public::function_55b494a07469298a()) {
      if(infilthink()) {
        continue;
      }
    }

    if(scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) {
      namespace_2913f85acadc353f::function_88039a31ef9e74dd();
      wait 1;
    }

    if(isDefined(level.br_circle) && isnavmeshloaded() && !bot_is_remote_or_linked()) {
      nextstatus = function_9230bcb84b43d245();
      wasprematch = scripts\mp\gamelogic::inprematch();

      switch (nextstatus) {
        case #"hash_b276405783bce7ac":
          if(function_4f54e90396961e78()) {
            self botsetflag("disable_all_ai", 0);
            self botclearscriptgoal();

            if(isaliveplayer(self.var_69652181699375d4) && !wasprematch && !istrue(self.infil_complete)) {
              followparachute();
            }

            if(!isDefined(self.desiredlandingspot)) {
              function_85686f0d8a5667da(wasprematch);
            }

            parachute(wasprematch);
            self.desiredlandingspot = undefined;

            if(wasprematch && !scripts\mp\gamelogic::inprematch()) {
              function_1e8fe34f5dfdea49("Skydive");
            } else {
              function_1e8fe34f5dfdea49("Combat");
            }
          }

          break;
        case #"hash_f4773cddc9292f61":
          val::set("brBotCombat", "vehicle_use", 0);
          var_da73a5ef27ba3fba = combatthink(wasprematch);
          namespace_56b9cc3deb6e3f5e::function_cd40e795b7776f14();

          if(istrue(var_da73a5ef27ba3fba) || wasprematch && !scripts\mp\gamelogic::inprematch()) {
            function_1e8fe34f5dfdea49("Skydive");

            if(istrue(var_da73a5ef27ba3fba)) {
              continue;
            }
          }

          break;
        default:
          assertex(0, "<dev string:x218>" + nextstatus + "<dev string:x235>");
          break;
      }
    }

    wait 0.05;
  }
}

function infilthink() {
  if(!istrue(self.jumped)) {
    botsuspend(1);

    if(function_15217dc6e3e6ac8e()) {
      return true;
    }
  }

  botsuspend(0);
  return false;
}

function function_15217dc6e3e6ac8e() {
  if(getdvarint(@ "hash_5270e4999186a160", 0) == 1) {
    function_6eeca72e3e1f4be8();
    return false;
  }

  if(isDefined(level.br_c130spawndone) && !level.br_c130spawndone) {
    if(istrue(level.c130inbounds) && isDefined(self.br_infil_type)) {
      if(!isDefined(self.var_69652181699375d4) && !scripts\mp\gamelogic::inprematch() && !istrue(self.infil_complete)) {
        self.var_69652181699375d4 = function_56a8312d296b291a();
      }

      if(isaliveplayer(self.var_69652181699375d4)) {
        function_bd52989c7fd9eaa5();
      } else {
        function_88b1bc0a1f68a014();
      }

      function_6eeca72e3e1f4be8();
      return false;
    }

    wait 0.05;
    return true;
  }

  return false;
}

function function_6eeca72e3e1f4be8() {
  self.gulaguses = ter_op(getdvarint(@ "hash_3ff738f6200e3a65", 1) != 0, 0, 1);
  self.jumped = 1;

  while(isDefined(self.br_infil_type)) {
    wait 0.05;
  }
}

function botsuspend(suspend) {
  if(suspend) {
    self botclearscriptgoal();
    setenemy(undefined);
  }

  self.ignoreall = suspend;
  self botsetflag("suspended", suspend);
}

function function_56a8312d296b291a() {
  if(!function_6dd2dfeb41384764()) {
    return undefined;
  }

  squadleader = scripts\cp_mp\utility\squad_utility::getsquadleader(self.team, self.sessionsquadid);

  if(function_40034c2faf09a87b(squadleader) && !istrue(squadleader.jumped)) {
    return squadleader;
  }

  teammates = scripts\mp\utility\teams::getteamdata(self.team, "players");

  foreach(player in teammates) {
    if(player == self || isDefined(squadleader) && player == squadleader) {
      continue;
    }

    if(function_40034c2faf09a87b(player) && !istrue(player.jumped)) {
      return player;
    }
  }

  return undefined;
}

function function_bd52989c7fd9eaa5() {
  assert(isaliveplayer(self.var_69652181699375d4));
  self endon("br_jump");
  msg = self.var_69652181699375d4 waittill_any_in_array_return(["br_jump", "death_or_disconnect"]);

  if(isDefined(msg) && msg == "br_jump") {
    var_d17925e505d5039d = 500;
    var_cdb1d6030cfea6b = 3000;
    var_ccb34012fba88c34 = randomintrange(var_d17925e505d5039d, var_cdb1d6030cfea6b);
    wait var_ccb34012fba88c34 * 0.001;
    self notify("halo_jump_solo_c130");
    return;
  }

  function_88b1bc0a1f68a014();
}

function function_88b1bc0a1f68a014() {
  self.desiredzoneindex = function_b7799ae6d79c86c9();
  function_85686f0d8a5667da(scripts\mp\gamelogic::inprematch());
  var_c2e1d99c4cb9d658 = function_2e7e3e8a96b8690c(self.desiredlandingspot);
  wait var_c2e1d99c4cb9d658;

  if(scripts\mp\gametypes\br_public::isplayerbrsquadleader()) {
    self notify("halo_jump_c130");
    return;
  }

  self notify("halo_jump_solo_c130");
}

function function_85686f0d8a5667da(wasprematch) {
  var_221fa3ac27e4925e = undefined;

  if(isaliveplayer(self.var_6601ccd8ec4b0356)) {
    var_221fa3ac27e4925e = self.var_6601ccd8ec4b0356.origin;
    self.desiredzoneindex = function_89b90eaac28334c7(var_221fa3ac27e4925e);
  } else if(!isDefined(self.desiredzoneindex)) {
    if(wasprematch) {
      self.desiredzoneindex = function_3023eeef223a5594();
    } else {
      self.desiredzoneindex = function_e39354ebeca71c56();
    }
  }

  self.desiredlandingspot = function_9816d841f0f205e2(wasprematch, var_221fa3ac27e4925e);
  var_518bd7ffa76f3234 = 30;
  self.desiredlandingspot += randomvector(var_518bd7ffa76f3234);

  if(isDefined(self.var_6601ccd8ec4b0356)) {
    self.var_6601ccd8ec4b0356 = undefined;
  }
}

function function_3b14fd3847fb5fe6() {
  self endon("bot_suspended");
  ammo_manager(&function_da84567cda38847e);
}

function function_290494c263cb346d() {
  while(true) {
    msg = waittill_any_in_array_return(["last_stand_start", "last_stand_finished"]);
    self botsetflag("ignore_script_weapon", msg == "last_stand_finished");

    if(msg == "last_stand_start") {
      setenemy(undefined);
    }
  }
}

function function_b4b715fd038025c6() {
  if(isDefined(self.initdifficulty)) {
    if(self.initdifficulty != self botgetdifficulty()) {
      namespace_56b9cc3deb6e3f5e::function_b4c45ed36fa851d5();
    }

    self.initdifficulty = undefined;
  }

  while(true) {
    olddifficulty = self botgetdifficulty();
    self waittill("bot_difficulty_updated");
    newdifficulty = self botgetdifficulty();

    if(newdifficulty != olddifficulty) {
      namespace_56b9cc3deb6e3f5e::function_b4c45ed36fa851d5();
    }
  }
}

function function_9816d841f0f205e2(isprematch, closestpoint) {
  if(isDefined(level.br_circle) && isnavmeshloaded()) {
    landingspot = undefined;
    zoneindex = self.desiredzoneindex;

    if(isDefined(level.botzones) && isDefined(zoneindex) && isDefined(level.botzones.zones[zoneindex]) && isDefined(level.botzones.zones[zoneindex].landingspots)) {
      if(isprematch) {
        landingspots = level.botzones.zones[zoneindex].landingspots;
      } else {
        landingspots = function_1c7137099a813ae1(level.botzones.zones[zoneindex].landingspots);
      }

      availableindexes = [];

      if(landingspots.size == 0) {
        level.botzones.zones[zoneindex].var_bd664214823fbf8d = 1;

        foreach(index, zone in level.botzones.zones) {
          if(index != zoneindex && !istrue(zone.var_bd664214823fbf8d)) {
            availableindexes[availableindexes.size] = index;
          }
        }
      }

      while(landingspots.size == 0 && availableindexes.size > 0) {
        zoneindex = random(availableindexes);
        zone = level.botzones.zones[zoneindex];
        landingspots = function_1c7137099a813ae1(zone.landingspots);

        if(landingspots.size == 0) {
          zone.var_bd664214823fbf8d = 1;
          availableindexes = array_remove(availableindexes, zoneindex);
        }
      }

      if(zoneindex != self.desiredzoneindex) {
        self.desiredzoneindex = zoneindex;
      }

      if(landingspots.size == 0) {
        println("<dev string:x256>");
      }

      if(isDefined(closestpoint)) {
        mindistancesq = undefined;

        foreach(spot in landingspots) {
          distancesq = distancesquared(spot.origin, closestpoint);

          if(!isDefined(mindistancesq) || mindistancesq > distancesq) {
            landingspot = spot;
            mindistancesq = distancesq;
          }
        }
      } else {
        landingspot = random(landingspots);
      }
    }

    if(isDefined(landingspot)) {
      randompoint = landingspot.origin;
    } else {
      if(isDefined(zoneindex) && isDefined(level.botzones.zones[zoneindex])) {
        println("<dev string:x295>" + level.botzones.zones[zoneindex].name + "<dev string:x2c2>");
      } else {
        println("<dev string:x2f7>");
      }

      randompoint = function_61e3c952715399e0();
    }

    return function_f8350ab882cc2439(randompoint);
  }

  return undefined;
}

function function_1c7137099a813ae1(spotcandidates) {
  availablespots = [];

  foreach(spot in spotcandidates) {
    if(function_bcb0778bb33e86de(spot.origin)) {
      availablespots[availablespots.size] = spot;
    }
  }

  return availablespots;
}

function function_89b90eaac28334c7(origin) {
  closestzoneindex = undefined;

  if(isDefined(level.botzones)) {
    closestdistsq = undefined;

    foreach(zoneindex, zone in level.botzones.zones) {
      distsq = distancesquared(origin, function_774e0b129d4d22b8(zoneindex));

      if(!isDefined(closestdistsq) || closestdistsq > distsq) {
        closestdistsq = distsq;
        closestzoneindex = zoneindex;
      }
    }
  }

  return closestzoneindex;
}

function function_2e7e3e8a96b8690c(targetpos) {
  if(!isDefined(targetpos)) {
    return function_a4091ef2be7e55b0();
  }

  plane = level.br_ac130;
  startpos = plane.pathstruct.startptui;
  endpos = plane.pathstruct.endptui;
  pathdir = plane.pathstruct.pathdir;
  planepos = plane.origin;
  startpos = (startpos[0], startpos[1], planepos[2]);
  endpos = (endpos[0], endpos[1], planepos[2]);
  var_197025dbf2c26cc2 = targetpos - vectorfromlinetopoint(startpos, endpos, targetpos);
  var_b7070691fd070bc9 = length(var_197025dbf2c26cc2 - targetpos) / tan(75);
  var_9f418d46ed639267 = var_197025dbf2c26cc2 - pathdir * var_b7070691fd070bc9;
  var_b6c3c93e7fbd38f8 = var_197025dbf2c26cc2 + pathdir * var_b7070691fd070bc9;
  var_e5b79916651603b4 = vectordot(startpos - planepos, pathdir);
  var_7b9ffa2027e95f7b = vectordot(endpos - planepos, pathdir);
  var_29e91993665650d2 = vectordot(var_9f418d46ed639267 - planepos, pathdir);
  var_208bbcaa2d81395f = vectordot(var_b6c3c93e7fbd38f8 - planepos, pathdir);

  if(var_208bbcaa2d81395f <= var_e5b79916651603b4) {
    var_4f120df4104fc38a = max(var_e5b79916651603b4, 0);
  } else if(var_29e91993665650d2 >= var_7b9ffa2027e95f7b) {
    var_4f120df4104fc38a = max(var_7b9ffa2027e95f7b, 0);
  } else {
    var_208bbcaa2d81395f = min(var_208bbcaa2d81395f, var_7b9ffa2027e95f7b);

    if(var_208bbcaa2d81395f <= 0) {
      return 0;
    }

    var_29e91993665650d2 = max(max(var_29e91993665650d2, var_e5b79916651603b4), 0);
    var_4f120df4104fc38a = randomfloatrange(var_29e91993665650d2, var_208bbcaa2d81395f);
  }

  var_c2e1d99c4cb9d658 = var_4f120df4104fc38a / scripts\mp\gametypes\br_c130::getc130speed();
  return var_c2e1d99c4cb9d658;
}

function function_774e0b129d4d22b8(zoneindex) {
  if(!isDefined(level.botzones) || !isDefined(zoneindex) || !isDefined(level.botzones.zones[zoneindex])) {
    return undefined;
  }

  zone = level.botzones.zones[zoneindex];
  centralpoint = zone.centralpoint;

  if(!isDefined(centralpoint)) {
    if(zone.landingspots.size > 0) {
      centralpoint = zone.landingspots[0].origin;
    }
  }

  if(!isDefined(centralpoint)) {
    if(zone.destinationspots.size > 0) {
      centralpoint = zone.destinationspots[0].origin;
    }
  }

  return centralpoint;
}

function function_b7799ae6d79c86c9() {
  if(scripts\cp_mp\utility\squad_utility::issquadmode()) {
    squad = level.squaddata[self.team][self.sessionsquadid];
    zoneindex = squad.skydivezoneindex;

    if(isDefined(zoneindex)) {
      println("<dev string:x345>", "<dev string:x36c>", self.team, "<dev string:x376>", self.sessionsquadid, "<dev string:x38a>", self.name, "<dev string:x394>", zoneindex);
    } else {
      zoneindex = function_e39354ebeca71c56();
      squad.skydivezoneindex = zoneindex;
    }

    return zoneindex;
  }

  return function_e39354ebeca71c56();
}

function function_3023eeef223a5594() {
  if(isDefined(level.prematchspawnorigins) && level.prematchspawnorigins.size > 0) {
    return function_89b90eaac28334c7(self.origin);
  }

  return function_e39354ebeca71c56();
}

function function_e39354ebeca71c56() {
  if(isDefined(level.botzones) && level.botzones.sumweight > 0) {
    debugzonename = getDvar(@ "hash_a2fdccd1d3ae6e9e", "<dev string:x3a3>");

    if(debugzonename != "<dev string:x3a3>") {
      foreach(index, zone in level.botzones.zones) {
        if(zone.name == debugzonename) {
          return index;
        }
      }
    }

    result = randomint(level.botzones.sumweight);
    left = 0;
    right = level.botzones.zones.size - 1;

    while(left <= right) {
      pivot = left + int((right - left) / 2);

      if(pivot == 0) {
        rangemin = 0;
      } else {
        rangemin = level.botzones.zones[pivot - 1].var_68e87685aa19da24;
      }

      rangemax = level.botzones.zones[pivot].var_68e87685aa19da24;

      if(result < rangemin) {
        right = pivot - 1;
        continue;
      }

      if(result >= rangemax) {
        left = pivot + 1;
        continue;
      }

      return pivot;
    }
  }

  return undefined;
}

function private function_4f54e90396961e78() {
  return self isskydiving() && (istrue(self.jumped) || scripts\mp\gamelogic::inprematch());
}

function followparachute() {
  assert(isaliveplayer(self.var_69652181699375d4));
  self.var_69652181699375d4 endon("death_or_disconnect");
  self.ignoreall = 1;
  function_142b713a2846f9ac("Parachuting - Following");
  var_82b713438181c528 = 3000;
  var_8d8b1541818e49bc = 1000;
  var_db0e9f8bcd027630 = 500;
  var_f68b4c88fdd8234e = 1;
  var_696ba03dd97c3224 = 1;

  while(self isskydiving()) {
    var_d459f6d98bfb8aad = function_82dc476c43087820();

    if(var_d459f6d98bfb8aad < var_82b713438181c528) {
      self.var_6601ccd8ec4b0356 = self;
      break;
    }

    if(!self.var_69652181699375d4 isskydiving()) {
      self.var_6601ccd8ec4b0356 = self.var_69652181699375d4;
      break;
    }

    deltaheight = self.origin[2] - self.var_69652181699375d4.origin[2];

    if(self isparachuting()) {
      if(deltaheight > var_8d8b1541818e49bc) {
        self botpressbutton("cut_chute");
      }
    } else if(deltaheight <= 0 || deltaheight <= var_8d8b1541818e49bc && self.var_69652181699375d4 isparachuting()) {
      self botpressbutton("jump");
    }

    var_3840f75fd5fc4336 = distance2d(self.origin, self.var_69652181699375d4.origin);

    if(var_3840f75fd5fc4336 <= var_db0e9f8bcd027630) {
      lookingdir = anglesToForward(self.var_69652181699375d4.angles);
      self botlookatpoint(self.origin + lookingdir * 1000, var_f68b4c88fdd8234e, "script_forced");
      targetvelocity = self.var_69652181699375d4 getvelocity();
      velocity = self getvelocity();
      deltavelocity = targetvelocity - velocity;
      var_b2bee1aed960f257 = vectortoangles(vectorNormalize(deltavelocity));
      self botsetscriptmove(var_b2bee1aed960f257[1], var_f68b4c88fdd8234e, var_696ba03dd97c3224);
    } else {
      function_c43469e7a5ae4ba4(self.var_69652181699375d4.origin, var_f68b4c88fdd8234e);
      var_b2bee1aed960f257 = bot_get_angles_to_goal(self, self.var_69652181699375d4.origin);
      self botsetscriptmove(var_b2bee1aed960f257[1], var_f68b4c88fdd8234e, var_696ba03dd97c3224);
    }

    wait var_f68b4c88fdd8234e;
  }
}

function parachute(isprematch) {
  if(isprematch) {
    level endon("prematch_over");
  }

  self.ignoreall = 1;

  if(getdvarint(@ "hash_ba0d232bde107bad") > 0) {
    thread function_fd1265363788e726();
  }

  var_443ac9ee37ed6bff = 0.05;
  var_c4672d91a23583fb = 1200;
  var_c4442391a20f2645 = 3000;
  parachuteheight = randomfloatrange(var_c4672d91a23583fb, var_c4442391a20f2645);
  var_9cd127607fba42b1 = 0;
  var_6ec7d15ca86b6b0a = 0;
  lastposition = undefined;
  var_b012001b3448e7c7 = undefined;
  stuck = 0;
  self.var_18b21e1e1191bcea = 2147483647;
  self.var_b7c77afce58bcac6 = 0;
  function_142b713a2846f9ac("Parachuting");

  while(self isskydiving()) {
    function_d0539e08120fcb08();
    var_26555d95dc188e56 = self.desiredlandingspot - self getEye();

    if(var_26555d95dc188e56[2] > 0 && !function_41a2827fb8521c44(var_26555d95dc188e56)) {
      self.desiredlandingspot = self.origin - (0, 0, 100);
    }

    curtime = gettime();
    var_d459f6d98bfb8aad = function_82dc476c43087820();

    if(var_d459f6d98bfb8aad <= parachuteheight && var_9cd127607fba42b1 <= 0) {
      self botpressbutton("jump");
      var_9cd127607fba42b1 = curtime;
      self.var_18b21e1e1191bcea = curtime;
    }

    if(var_9cd127607fba42b1 <= 0 && self isparachuting()) {
      var_9cd127607fba42b1 = curtime;
      self.var_18b21e1e1191bcea = curtime;
    }

    if(!var_6ec7d15ca86b6b0a && var_9cd127607fba42b1 > 0 && var_26555d95dc188e56[2] < 0 && curtime - var_9cd127607fba42b1 > 1000) {
      var_6ec7d15ca86b6b0a = function_ac55a70c78ec6aa5();
    }

    if(var_9cd127607fba42b1 > 0 && self function_3c6bb30ae7106b7a()) {
      function_4473b5af345c0b75(var_d459f6d98bfb8aad);
    }

    if(isDefined(lastposition) && distancesquared(self.origin, lastposition) > 10) {
      var_b012001b3448e7c7 = curtime;
    }

    lastposition = self.origin;

    if(isDefined(var_b012001b3448e7c7) && curtime - var_b012001b3448e7c7 > 1000) {
      stuck = 1;
      break;
    }

    function_f8866d90a44d0745(var_443ac9ee37ed6bff);
    wait var_443ac9ee37ed6bff;
  }

  if(!self.var_ab5f5270cb22e3c8 && !scripts\mp\gamelogic::inprematch()) {
    thread function_916e2512538553db();
  }

  self botlookatpoint(undefined);
  self.ignoreall = 0;
  var_4a564ebb47167dc9 = 0;

  if(!isprematch && !istrue(self.infil_complete)) {
    self.desiredzoneindex = undefined;
    self.infil_complete = 1;

    if(stuck) {
      recycletype = 3;
    } else {
      recycletype = 0;
    }

    recyclesuccess = namespace_95d8d8ec67e3e074::tryrecycle(recycletype, 1);

    if(recyclesuccess) {
      if(recycletype == 0) {
        return;
      }
    } else if(stuck) {
      var_4a564ebb47167dc9 = 1;
    }
  }

  if(stuck) {
    while(self isskydiving()) {
      if(namespace_95d8d8ec67e3e074::tryrecycle(3, var_4a564ebb47167dc9)) {
        return;
      }

      wait 1;
    }
  }
}

function function_fd1265363788e726() {
  self endon("<dev string:x3a7>");
  level endon("<dev string:x3be>");

  while(true) {
    if(isDefined(self.desiredlandingspot)) {
      var_12225bdacc8b6654 = (1, 0, 0);
      var_ef9d8bf7f4d7b604 = (0, 1, 0);
      var_b792c387402095b1 = (1, 1, 0);

      if(self isskydiving()) {
        line(self.origin, self.desiredlandingspot, var_ef9d8bf7f4d7b604, 1, 0, 3);
        circleorigin = scripts\mp\gametypes\br_circle::getsafecircleorigin();
        circleradius = scripts\mp\gametypes\br_circle::getsafecircleradius();
        spherecolor = var_ef9d8bf7f4d7b604;

        if(istrue(level.circleclosing)) {
          spherecolor = var_12225bdacc8b6654;
        }

        sphere(circleorigin, circleradius, spherecolor, 0, 5);
        sphere(self.desiredlandingspot, 128, spherecolor, 0, 5);
      } else {
        sphere(self.desiredlandingspot, 128, var_b792c387402095b1, 0, 5);
      }

      print3d(self.desiredlandingspot, self.name + "<dev string:x3cf>", var_b792c387402095b1, 1, 1, 5, 1);
    }

    wait 0.05;
  }
}

function function_c43469e7a5ae4ba4(targetpoint, seconds) {
  targetpoint = function_fc1a8616655393a5(targetpoint);
  self botlookatpoint(targetpoint, seconds, "script_forced");
}

function private function_fc1a8616655393a5(targetpoint) {
  if(!isDefined(targetpoint)) {
    return undefined;
  }

  if(function_79eb95c7588f2191(targetpoint)) {
    return targetpoint;
  }

  boteyepos = self getEye();
  var_c74535e72311f8b0 = targetpoint - boteyepos;
  height = var_c74535e72311f8b0[2];
  assert(height > 0);

  if(height < 1) {
    return undefined;
  }

  var_7443f3542b52786a = length2dsquared(var_c74535e72311f8b0);

  if(var_7443f3542b52786a < 1) {
    var_4821e22d1e800bf1 = anglesToForward(self.angles);
  } else {
    var_4821e22d1e800bf1 = var_c74535e72311f8b0;
  }

  var_4821e22d1e800bf1 = vectorNormalize((var_4821e22d1e800bf1[0], var_4821e22d1e800bf1[1], 0));
  var_d9a4e368b3862c16 = 0.46631;
  var_78ed320e488c3260 = height * var_d9a4e368b3862c16;
  var_9309d9ef2e527fff = var_78ed320e488c3260 * var_4821e22d1e800bf1;
  targetvector = var_9309d9ef2e527fff + (0, 0, height);
  return boteyepos + targetvector;
}

function function_79eb95c7588f2191(targetpoint) {
  var_c74535e72311f8b0 = targetpoint - self getEye();
  return function_41a2827fb8521c44(var_c74535e72311f8b0);
}

function function_41a2827fb8521c44(eyetopoint) {
  var_c7086d1ad1cbd95d = 0.939693;
  return vectordot(vectorNormalize(eyetopoint), (0, 0, 1)) <= var_c7086d1ad1cbd95d;
}

function function_ac55a70c78ec6aa5() {
  var_26555d95dc188e56 = self.desiredlandingspot - self.origin;
  velocity = self getvelocity();
  estheight = abs(var_26555d95dc188e56[2]);
  verticalspeed = abs(velocity[2]);

  if(verticalspeed > 50 && estheight > 200) {
    var_4cf0e4661298ed8a = estheight / verticalspeed;
    var_5c530f8b9afd0804 = length2d(velocity);
    var_3840f75fd5fc4336 = length2d(var_26555d95dc188e56);

    if(var_5c530f8b9afd0804 < 200) {
      var_5c530f8b9afd0804 = 700;
    }

    var_8105af709f0adc35 = var_3840f75fd5fc4336 / var_5c530f8b9afd0804;

    if(var_4cf0e4661298ed8a < var_8105af709f0adc35 && var_4cf0e4661298ed8a > 1 && var_3840f75fd5fc4336 > 0) {
      var_2127d880e420797f = var_5c530f8b9afd0804 * (var_4cf0e4661298ed8a - 1) / 2;

      if(getdvarint(@ "hash_ba0d232bde107bad") > 0) {
        println("<dev string:x3e2>" + self.entity_number + "<dev string:x3eb>" + "<dev string:x3f2>" + "<dev string:x421>" + self.desiredlandingspot[0] + "<dev string:x42a>" + self.desiredlandingspot[1] + "<dev string:x42a>" + self.desiredlandingspot[2] + "<dev string:x42f>" + self.origin[0] + "<dev string:x42a>" + self.origin[1] + "<dev string:x42a>" + self.origin[2] + "<dev string:x438>" + var_4cf0e4661298ed8a + "<dev string:x438>" + var_8105af709f0adc35 + "<dev string:x44a>" + var_2127d880e420797f);
      }

      var_365b4b90d1e6a26c = function_30ddbfd5e5e2a771(self.origin, velocity, self.desiredlandingspot, var_2127d880e420797f, 1, 200, 700);

      if(isDefined(var_365b4b90d1e6a26c)) {
        self.desiredlandingspot = var_365b4b90d1e6a26c;

        if(getdvarint(@ "hash_ba0d232bde107bad") > 0) {
          sphere(var_365b4b90d1e6a26c, 128, (0, 1, 1), 0, 5000);
          debugmsg = "<dev string:x45c>" + var_365b4b90d1e6a26c[0] + "<dev string:x42a>" + var_365b4b90d1e6a26c[1] + "<dev string:x42a>" + var_365b4b90d1e6a26c[2] + "<dev string:x461>";
          print3d(var_365b4b90d1e6a26c, debugmsg, (0, 1, 1), 1, 1, 5000, 1);
          line(self.origin, var_365b4b90d1e6a26c, (0, 1, 0), 1, 0, 5000);
          pos = (var_365b4b90d1e6a26c[0], var_365b4b90d1e6a26c[1], self.origin[2]);
          line(pos, var_365b4b90d1e6a26c, (0, 1, 0), 1, 0, 5000);
        }

        return true;
      }
    }
  }

  return false;
}

function function_d0539e08120fcb08() {
  function_f42d549e3be7e8a1();
  function_9dd97fd712f1f9de();
}

function function_f42d549e3be7e8a1() {
  if(level.br_circle.circleindex > 0 && istrue(level.circleclosing) && !function_bcb0778bb33e86de(self.desiredlandingspot)) {
    self.desiredlandingspot = namespace_bc2665cbe6cf4e1f::function_61e3c952715399e0();
  }
}

function function_9dd97fd712f1f9de() {
  newpos = function_44ae04156d124e2();

  if(isDefined(newpos)) {
    self.desiredlandingspot = newpos;
    self.var_b7c77afce58bcac6 = 2147483647;
  }
}

function function_44ae04156d124e2() {
  if(!isDefined(self.var_18b21e1e1191bcea) || gettime() < self.var_18b21e1e1191bcea) {
    return;
  }

  var_5a131f8f7a5add85 = 1000;
  self.var_18b21e1e1191bcea = gettime() + var_5a131f8f7a5add85;
  var_b57907e360347347 = 2400;
  var_94264830825789e8 = 2500;
  var_364d2e6c896f4667 = var_b57907e360347347 * 2;
  var_74005c948f0bef90 = var_b57907e360347347 * var_b57907e360347347;
  var_23788b3a59f98f59 = var_94264830825789e8 * var_94264830825789e8;
  var_e6c45dad3f36fcf0 = var_364d2e6c896f4667 * var_364d2e6c896f4667;
  enemyoriginlist = [];
  var_a871590cb205e828 = [];
  nearestenemydistsq = undefined;

  foreach(player in level.players) {
    if(player.team == self.team || player isskydiving() || !function_40034c2faf09a87b(player)) {
      continue;
    }

    distsq = distance2dsquared(player.origin, self.desiredlandingspot);

    if(distsq <= var_e6c45dad3f36fcf0) {
      if(distsq <= var_74005c948f0bef90) {
        enemyoriginlist[enemyoriginlist.size] = player.origin;

        if(!isDefined(nearestenemydistsq) || distsq < nearestenemydistsq) {
          nearestenemydistsq = distsq;
        }

        continue;
      }

      var_a871590cb205e828[var_a871590cb205e828.size] = player.origin;
    }
  }

  if(enemyoriginlist.size == 0) {
    return;
  }

  if(enemyoriginlist.size == 1) {
    enemyorigin = enemyoriginlist[0];
    vec = self.desiredlandingspot - enemyorigin;

    if(length2dsquared(vec) < 10) {
      vec = function_e5b4b5992cddb221().origin - enemyorigin;
    }

    vec = vectornormalize2(vec) * var_94264830825789e8;
    newpos = enemyorigin + vec;

    if(function_bcb0778bb33e86de(newpos)) {
      newpos = utility::groundpos((newpos[0], newpos[1], self.origin[2]));

      if(isDefined(newpos)) {
        newpos = function_f8350ab882cc2439(newpos);

        if(isDefined(newpos)) {
          foreach(origin in var_a871590cb205e828) {
            if(distance2dsquared(origin, newpos) <= nearestenemydistsq) {
              return;
            }
          }

          return newpos;
        }
      }
    }

    return;
  }

  intersections = [];

  for(i = 0; i < enemyoriginlist.size - 1; i++) {
    for(j = i + 1; j < enemyoriginlist.size; j++) {
      pta = (enemyoriginlist[i][0], enemyoriginlist[i][1], 0);
      ptb = (enemyoriginlist[j][0], enemyoriginlist[j][1], 0);
      vecab = ptb - pta;
      vecao = 0.5 * vecab;
      vecop = (-1 * vecao[1], vecao[0], 0);
      vecop = vectornormalize2(vecop) * sqrt(var_23788b3a59f98f59 - length2dsquared(vecao));
      intersections[intersections.size] = pta + vecao + vecop;
      intersections[intersections.size] = pta + vecao - vecop;
    }
  }

  validintersection = undefined;
  candidateintersection = undefined;
  candidatedistsq = 0;

  foreach(intersection in intersections) {
    if(!function_bcb0778bb33e86de(intersection)) {
      continue;
    }

    var_fac4e1aa13aa4d48 = 0;

    foreach(origin in enemyoriginlist) {
      if(distance2dsquared(origin, intersection) <= var_74005c948f0bef90) {
        var_fac4e1aa13aa4d48 = 1;
        break;
      }
    }

    if(var_fac4e1aa13aa4d48) {
      continue;
    }

    nearestdistsq = undefined;

    foreach(origin in var_a871590cb205e828) {
      distsq = distance2dsquared(origin, intersection);

      if(!isDefined(nearestdistsq) || distsq < nearestdistsq) {
        nearestdistsq = distsq;
      }

      if(nearestdistsq <= nearestenemydistsq) {
        break;
      }
    }

    if(!isDefined(nearestdistsq) || nearestdistsq > var_74005c948f0bef90) {
      validintersection = intersection;
      break;
    }

    if(nearestdistsq <= nearestenemydistsq) {
      continue;
    }

    if(!isDefined(candidateintersection) || nearestdistsq > candidatedistsq) {
      candidateintersection = intersection;
      candidatedistsq = nearestdistsq;
    }
  }

  targetintersection = default_to(validintersection, candidateintersection);

  if(isDefined(targetintersection)) {
    newpos = utility::groundpos((targetintersection[0], targetintersection[1], self.origin[2]));

    if(isDefined(newpos)) {
      newpos = function_f8350ab882cc2439(newpos);

      if(isDefined(newpos)) {
        return newpos;
      }
    }
  }
}

function function_4473b5af345c0b75(startheight) {
  var_75bb4da43489d9ae = distance2d(self.origin, self.desiredlandingspot);
  var_e5da52ae39be43f3 = 1000;
  var_e5fef95b22eec246 = 350;

  if(var_75bb4da43489d9ae < var_e5da52ae39be43f3 && startheight > var_e5fef95b22eec246) {
    self botpressbutton("cut_chute");
    var_443ac9ee37ed6bff = 0.05;
    var_aa17a2b26eaf935f = 10000;
    endtime = gettime() + var_aa17a2b26eaf935f;

    while(true) {
      currenttime = gettime();

      if(currenttime >= endtime) {
        break;
      }

      function_d0539e08120fcb08();
      var_19ed8a8a2a03e81a = 50;
      var_d459f6d98bfb8aad = function_82dc476c43087820();
      var_c6f79a0dcb0aca65 = self.origin[2] - self.desiredlandingspot[2];

      if(var_c6f79a0dcb0aca65 < var_e5fef95b22eec246 && self isparachuting() || var_d459f6d98bfb8aad < var_19ed8a8a2a03e81a) {
        break;
      }

      var_6a8da31c699ef658 = 1;
      var_b8996303b685a203 = 800;
      gravity = getdvarint(@ "bg_gravity", var_b8996303b685a203);
      velocity = self getvelocity();
      var_966b732f6569a932 = abs(velocity[2]) * var_6a8da31c699ef658 + gravity * var_6a8da31c699ef658 * var_6a8da31c699ef658 * 0.5;
      var_ef86ab5709584341 = max(abs(velocity[2]) * var_6a8da31c699ef658, var_e5fef95b22eec246);
      var_4e25ddb1d88d3b34 = randomfloat(1) > 0.1;

      if(!self isparachuting() && var_d459f6d98bfb8aad < var_966b732f6569a932) {
        self botpressbutton("jump");
      } else if(self function_3c6bb30ae7106b7a() && var_d459f6d98bfb8aad > var_ef86ab5709584341) {
        if(var_4e25ddb1d88d3b34) {
          self botpressbutton("cut_chute");
        } else {
          function_ea3ada687ba0d0da();
        }
      }

      function_f8866d90a44d0745(var_443ac9ee37ed6bff);
      wait var_443ac9ee37ed6bff;
    }
  }
}

function private function_ea3ada687ba0d0da() {
  currenttime = gettime();

  if(!isDefined(self.var_b7c77afce58bcac6) || currenttime < self.var_b7c77afce58bcac6) {
    return;
  }

  newpos = function_15429c744a90c1d6();

  if(isDefined(newpos)) {
    self.desiredlandingspot = newpos;
    self.var_b7c77afce58bcac6 = 2147483647;
    return;
  }

  var_5a131f8f7a5add85 = 1000;
  self.var_b7c77afce58bcac6 = currenttime + var_5a131f8f7a5add85;
}

function private function_15429c744a90c1d6() {
  var_d459f6d98bfb8aad = function_82dc476c43087820();
  velocity = self getvelocity();
  verticalspeed = max(abs(velocity[2]), 0.1);
  time = var_d459f6d98bfb8aad / verticalspeed;
  dist = 200 * time * randomfloatrange(0.1, 1);
  theta = randomfloat(360);
  offset = (dist * cos(theta), dist * sin(theta), 0);
  var_79482d9017239c26 = self.origin + offset;
  var_49387f8edddd04ff = function_b55d34ecd65bda1d(var_79482d9017239c26);

  if(!isDefined(var_49387f8edddd04ff)) {
    return;
  }

  var_2f497091c602ad20 = getclosestpointonnavmesh(var_49387f8edddd04ff);

  if(!scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(var_2f497091c602ad20) || !scripts\engine\trace::ray_trace_passed(self getEye(), var_2f497091c602ad20, self)) {
    return;
  }

  var_8ed617ead6db792e = squared(100);
  var_601bc0ab1553c9b0 = 300;
  var_8c42560f91a47f86 = [(var_601bc0ab1553c9b0, 0, 0), (-1 * var_601bc0ab1553c9b0, 0, 0), (0, var_601bc0ab1553c9b0, 0), (0, -1 * var_601bc0ab1553c9b0, 0)];
  var_e99cefda2af19497 = (var_2f497091c602ad20[0], var_2f497091c602ad20[1], self.origin[2]);

  foreach(var_56c67f4bf6b5b811 in var_8c42560f91a47f86) {
    var_63a546bf88adbe4d = var_e99cefda2af19497 + var_56c67f4bf6b5b811;
    var_eb3c0310c69597de = function_b55d34ecd65bda1d(var_63a546bf88adbe4d);

    if(!isDefined(var_eb3c0310c69597de)) {
      return;
    }

    var_a6474803e58f4be7 = getclosestpointonnavmesh(var_eb3c0310c69597de);

    if(distancesquared(var_eb3c0310c69597de, var_a6474803e58f4be7) > var_8ed617ead6db792e) {
      return;
    }
  }

  return var_2f497091c602ad20;
}

function private function_82dc476c43087820() {
  groundpos = function_b55d34ecd65bda1d(self.origin);

  if(!isDefined(groundpos)) {
    return 0;
  }

  return self.origin[2] - groundpos[2];
}

function private function_b55d34ecd65bda1d(position) {
  var_c1d1fc4d9d46438d = -25000;
  endposition = position + (0, 0, var_c1d1fc4d9d46438d);
  contents = physics_createcontents(["physicscontents_aiclip", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_water"]);
  result = scripts\engine\trace::ray_trace(position, endposition, undefined, contents);

  if(result["hittype"] == "hittype_none") {
    return undefined;
  }

  return result["position"];
}

function private function_f8866d90a44d0745(duration) {
  velocity = self getvelocity();
  verticalvelocity = max(abs(velocity[2]), 0.1);
  var_c6f79a0dcb0aca65 = self.origin[2] - self.desiredlandingspot[2];
  timetoland = max(var_c6f79a0dcb0aca65 / verticalvelocity, 0.1);
  var_75bb4da43489d9ae = distance2d(self.origin, self.desiredlandingspot);
  var_4a1fb03882e4e567 = var_75bb4da43489d9ae / timetoland;
  targetdirection = self.desiredlandingspot - self.origin;
  targetdirection = vectorNormalize((targetdirection[0], targetdirection[1], 0));
  targetvelocity = targetdirection * var_4a1fb03882e4e567;
  var_696ba03dd97c3224 = 1;
  deltavelocity = targetvelocity - velocity;
  var_b2bee1aed960f257 = vectortoangles(vectorNormalize(deltavelocity));
  self botsetscriptmove(var_b2bee1aed960f257[1], duration, var_696ba03dd97c3224);
  function_c43469e7a5ae4ba4(self.desiredlandingspot, duration);
}

function function_916e2512538553db() {
  self notify("bot_delay_give_loadout");
  self endon("bot_delay_give_loadout");
  self endon("bot_suspended");
  self endon("death_or_disconnect");
  level endon("game_ended");
  delaysec = getdvarint(@ "hash_b18793f70e0f6b34", 30);
  assertex(delaysec > 0, "<dev string:x466>");
  wait delaysec;
  dist = getdvarint(@ "hash_3da4efd986f095de", 3900);
  assertex(dist > 0, "<dev string:x492>");

  while(!self.var_ab5f5270cb22e3c8 && !scripts\mp\utility\player::isinlaststand(self)) {
    if(!function_a094b75e2ab2c597(dist) && !function_b74cf5eb822312cb() && !function_da84567cda38847e()) {
      function_532c9aa14c794ff(function_3032314d524a3487());
      return;
    }

    wait 1;
  }
}

function function_3032314d524a3487() {
  if(!isDefined(level.br_circle.circleinittime)) {
    assertmsg("<dev string:x4c1>");
    return level.br_level.var_61321b51908d55cb;
  }

  if(!isDefined(level.br_level.var_67ba7c3c6b03a843)) {
    level.br_level.var_67ba7c3c6b03a843 = 0;

    for(circleindex = 0; circleindex < level.br_level.br_circleclosetimes.size - level.br_level.br_movingcirclecount; circleindex++) {
      level.br_level.var_67ba7c3c6b03a843 += level.br_level.br_circleclosetimes[circleindex];
      level.br_level.var_67ba7c3c6b03a843 += level.br_level.br_circledelaytimes[circleindex];
    }
  }

  curtimesec = (gettime() - level.br_circle.circleinittime) / 1000;

  if(curtimesec < level.br_level.var_67ba7c3c6b03a843 * 0.4) {
    return level.br_level.var_61321b51908d55cb;
  }

  return level.br_level.var_61321c51908d57fe;
}

function function_a094b75e2ab2c597(var_667b3eef65d8914) {
  radiussq = squared(var_667b3eef65d8914);

  foreach(player in level.players) {
    if(function_40034c2faf09a87b(player)) {
      if(distancesquared(self.origin, player.origin) <= radiussq) {
        return true;
      }
    }
  }

  return false;
}

function function_532c9aa14c794ff(table) {
  if(istrue(self.var_ab5f5270cb22e3c8)) {
    return;
  }

  assertex(isDefined(table), "<dev string:x517>");
  self.var_ab5f5270cb22e3c8 = 1;
  function_91774b01bc741d01(table);
}

function function_91774b01bc741d01(table) {
  var_7d958726e11b327 = scripts\mp\class::function_df2933f96d726d71(table);
  randomnum = randomintrange(0, var_7d958726e11b327);
  struct = scripts\mp\class::loadout_getclassstruct();
  struct = scripts\mp\class::function_1d52554d28b51cbc(struct, randomnum, table);
  var_e2154dbde4bd1cac = strtok(struct.loadoutprimary, "|");
  struct.loadoutprimary = var_e2154dbde4bd1cac[0];
  var_63cbf0be53790618 = strtok(struct.loadoutsecondary, "|");
  struct.loadoutsecondary = var_63cbf0be53790618[0];
  struct = scripts\mp\class::loadout_updateclass(struct, "juggernaut");

  if(isDefined(var_e2154dbde4bd1cac[1])) {
    fullname = function_8673b301658f7e88(struct.loadoutprimary, var_e2154dbde4bd1cac[1]);

    if(isDefined(fullname)) {
      struct.loadoutprimaryfullname = fullname;
      struct.loadoutprimaryobject = makeweaponfromstring(struct.loadoutprimaryfullname);
    }
  }

  if(isDefined(var_63cbf0be53790618[1])) {
    fullname = function_8673b301658f7e88(struct.loadoutsecondary, var_63cbf0be53790618[1]);

    if(isDefined(fullname)) {
      struct.loadoutsecondaryfullname = fullname;
      struct.loadoutsecondaryobject = makeweaponfromstring(struct.loadoutsecondaryfullname);
    }
  }

  scripts\mp\class::preloadandqueueclassstruct(struct, 1, 1);
  self takeallweapons();
  scripts\mp\class::giveloadout(self.team, "juggernaut", 1, 1);
  self switchtoweapon(self.primaryweapons[0]);
  scripts\mp\class::loadout_updateplayerkillstreaks(struct, "juggernaut");
}

function function_8673b301658f7e88(baseweaponname, rarity) {
  assert(isDefined(level.var_fb8e78837bc5ee6c));
  rarityint = function_2e145731f42005a8(rarity);
  assert(rarityint != -1);

  foreach(var_14004b68ddacb781, baseweapon in level.var_fb8e78837bc5ee6c) {
    itemrarity = level.br_pickups.br_itemrarity[var_14004b68ddacb781];

    if(baseweaponname == baseweapon && rarityint == itemrarity) {
      return level.br_lootiteminfo[var_14004b68ddacb781].fullweaponname;
    }
  }

  assertmsg("<dev string:x53d>" + baseweaponname + "<dev string:x55d>" + rarity + "<dev string:x563>");
  return undefined;
}

function function_2e145731f42005a8(rarity) {
  switch (rarity) {
    case #"hash_ea093629bbd45829":
      return 0;
    case #"hash_5643cb653f1cf91c":
      return 1;
    case #"hash_209fa8900070d83d":
      return 2;
    case #"hash_95068103fe897bc8":
      return 3;
    case #"hash_c9b6283a17a61276":
      return 4;
  }

  return -1;
}

function function_5b54ecc3b227f84d() {
  tablename = "classtable:classtable_br_bot_loadouts_airdrop_" + self.difficulty;
  function_91774b01bc741d01(tablename);
  return true;
}

function function_c8cc3e3589f34923(table) {
  if(isDefined(table)) {
    var_7d958726e11b327 = scripts\mp\class::function_df2933f96d726d71(table);

    while(!isDefined(level.var_a9350d89a2e4d752)) {
      wait 1;
    }

    wait 1;

    for(i = 0; i < var_7d958726e11b327; i++) {
      struct = scripts\mp\class::loadout_getclassstruct();
      struct = scripts\mp\class::function_1d52554d28b51cbc(struct, i, table);
      var_e2154dbde4bd1cac = strtok(struct.loadoutprimary, "<dev string:x56b>");
      var_63cbf0be53790618 = strtok(struct.loadoutsecondary, "<dev string:x56b>");
      assert(var_e2154dbde4bd1cac.size == 2 && isDefined(var_e2154dbde4bd1cac[0]) && isDefined(var_e2154dbde4bd1cac[1]));
      assert(var_63cbf0be53790618.size == 2 && isDefined(var_63cbf0be53790618[0]) && isDefined(var_63cbf0be53790618[1]));
      primaryweaponexist = 0;
      secondaryweaponexist = 0;
      var_9eea23b5420bb92e = 0;
      var_adc7a698896266e = 0;

      if(!istrue(level.var_a9350d89a2e4d752)) {
        lastrow = tablelookupgetnumrows(level.brloottablename);

        for(row = 0; row < lastrow; row++) {
          if(tablelookupbyrow(level.brloottablename, row, 0) != "<dev string:x570>") {
            continue;
          }

          var_c3ce54fc5fbe47c9 = 8;
          const_rarity = 3;
          baseweaponname = tablelookupbyrow(level.brloottablename, row, var_c3ce54fc5fbe47c9);
          rarity = int(tablelookupbyrow(level.brloottablename, row, const_rarity));

          if(!isDefined(baseweaponname)) {
            continue;
          }

          if(baseweaponname == var_e2154dbde4bd1cac[0] && rarity == function_2e145731f42005a8(var_e2154dbde4bd1cac[1])) {
            primaryweaponexist = 1;
          }

          if(baseweaponname == var_63cbf0be53790618[0] && rarity == function_2e145731f42005a8(var_63cbf0be53790618[1])) {
            secondaryweaponexist = 1;
          }

          if(baseweaponname == struct.loadoutequipmentprimary) {
            var_9eea23b5420bb92e = 1;
          }

          if(baseweaponname == struct.loadoutequipmentsecondary) {
            var_adc7a698896266e = 1;
          }
        }

        assertex(primaryweaponexist, "<dev string:x578>" + struct.loadoutprimary + "<dev string:x584>");
        assertex(secondaryweaponexist, "<dev string:x578>" + struct.loadoutsecondary + "<dev string:x584>");
        assertex(var_9eea23b5420bb92e, "<dev string:x5ad>" + struct.loadoutequipmentprimary + "<dev string:x584>");
        assertex(var_adc7a698896266e, "<dev string:x5ad>" + struct.loadoutequipmentsecondary + "<dev string:x584>");
        continue;
      }

      foreach(var_14004b68ddacb781, baseweaponname in level.var_fb8e78837bc5ee6c) {
        var_c3ce54fc5fbe47c9 = 8;
        const_rarity = 3;

        if(!isDefined(baseweaponname)) {
          continue;
        }

        rarity = level.br_pickups.br_itemrarity[var_14004b68ddacb781];

        if(isDefined(rarity)) {
          if(!primaryweaponexist && baseweaponname == var_e2154dbde4bd1cac[0] && rarity == function_2e145731f42005a8(var_e2154dbde4bd1cac[1]) && isDefined(level.br_lootiteminfo[var_14004b68ddacb781].fullweaponname) && isDefined(level.br_pickups.var_9e78b5ee377070a9[level.br_lootiteminfo[var_14004b68ddacb781].fullweaponname])) {
            primaryweaponexist = 1;
          }

          if(!secondaryweaponexist && baseweaponname == var_63cbf0be53790618[0] && rarity == function_2e145731f42005a8(var_63cbf0be53790618[1]) && isDefined(level.br_lootiteminfo[var_14004b68ddacb781].fullweaponname) && isDefined(level.br_pickups.var_9e78b5ee377070a9[level.br_lootiteminfo[var_14004b68ddacb781].fullweaponname])) {
            secondaryweaponexist = 1;
          }

          if(baseweaponname == struct.loadoutequipmentprimary) {
            var_9eea23b5420bb92e = 1;
          }

          if(baseweaponname == struct.loadoutequipmentsecondary) {
            var_adc7a698896266e = 1;
          }
        }
      }

      assertex(primaryweaponexist, "<dev string:x578>" + struct.loadoutprimary + "<dev string:x5bc>");
      assertex(secondaryweaponexist, "<dev string:x578>" + struct.loadoutsecondary + "<dev string:x5bc>");
      assertex(var_9eea23b5420bb92e, "<dev string:x5ad>" + struct.loadoutequipmentprimary + "<dev string:x5bc>");
      assertex(var_adc7a698896266e, "<dev string:x5ad>" + struct.loadoutequipmentsecondary + "<dev string:x5bc>");
    }
  }
}

function combatthink(isprematch) {
  if(isprematch) {
    level endon("prematch_over");
  } else {
    self notify("start_combat");
  }

  function_142b713a2846f9ac("Mind");
  self botsetflag("enable_deploy_parachute", 1);
  namespace_56b9cc3deb6e3f5e::initializeupdate();

  while(true) {
    if(function_4f54e90396961e78()) {
      landingspot = function_237329ef91427ab4();

      if(isDefined(landingspot)) {
        self.desiredlandingspot = landingspot;
        return 1;
      }
    }

    if(getdvarint(@ "hash_40d69a9ed755f536", 0)) {
      function_ab1937128f48283f();
    }

    namespace_56b9cc3deb6e3f5e::update();
  }
}

function private function_237329ef91427ab4() {
  var_ddb70f36e908d6d9 = 300;
  var_114ddaa982f009da = 50;
  var_bbaebd57060800ba = self.origin + (0, 0, var_ddb70f36e908d6d9);
  var_1e43c68a729a6d22 = self.origin[2] - var_114ddaa982f009da;
  return function_ec232ea2a444176b(var_bbaebd57060800ba, var_1e43c68a729a6d22);
}

function private function_ec232ea2a444176b(var_2561306388fc2c5a, var_1e43c68a729a6d22) {
  groundpos = function_b55d34ecd65bda1d(var_2561306388fc2c5a);

  if(isDefined(groundpos)) {
    navpos = getclosestpointonnavmesh(groundpos);

    if(navpos[2] <= var_1e43c68a729a6d22) {
      return navpos;
    } else {
      return undefined;
    }
  }

  var_2b4ec659a76b91e1 = 100;
  var_cd04fa5f7bd42a91 = 2000;
  var_312a8b1d0d4ed2a1 = 100;
  var_d611a066ee572469 = 360;
  var_f3d6fff24cf529fc = 8;
  var_1221cc6e7351ffe6 = var_d611a066ee572469 / var_f3d6fff24cf529fc;
  radius = var_2b4ec659a76b91e1;

  while(radius < var_cd04fa5f7bd42a91) {
    angle = randomfloat(var_d611a066ee572469);

    for(angleindex = 0; angleindex < var_f3d6fff24cf529fc; angleindex++) {
      offset = (radius * cos(angle), radius * sin(angle), 0);
      var_63a546bf88adbe4d = var_2561306388fc2c5a + offset;
      navpos = function_c1ffaeee7114310(var_63a546bf88adbe4d, var_1e43c68a729a6d22);

      if(isDefined(navpos)) {
        return navpos;
      }

      angle = mod(angle + var_1221cc6e7351ffe6, var_d611a066ee572469);
    }

    radius += var_312a8b1d0d4ed2a1;
  }

  return undefined;
}

function private function_c1ffaeee7114310(var_2561306388fc2c5a, var_1e43c68a729a6d22) {
  groundpos = function_b55d34ecd65bda1d(var_2561306388fc2c5a);

  if(isDefined(groundpos)) {
    navpos = getclosestpointonnavmesh(groundpos);

    if(navpos[2] <= var_1e43c68a729a6d22) {
      return navpos;
    }
  }

  return undefined;
}

function function_ab1937128f48283f() {
  if(scripts\mp\gametypes\br::isgulagshutdown() && !namespace_95d8d8ec67e3e074::isuibot() && self botgetdifficulty() == "recruit") {
    if(function_c4053e29135c5d27()) {
      self botsetdifficulty("regular");
      function_8771893f1bcb49bb(self, "regular");
    }
  }
}

function kickplayer(statusto, statusfrom) {
  if(!isDefined(statusto)) {
    statusto = "kickout";
  }

  namespace_92443376a63aa4bd::function_b1c37e649a5cd380(statusto, statusfrom);
  self.var_6a91d0e80cc504e = statusto == "uibot";

  if(statusto == "uibot") {
    kick(self getentitynumber(), "EXE/PLAYERKICKED_BOT_TO_UIBOT");
    return;
  }

  kick(self getentitynumber());
}

function function_f6e88d354cb8d3cd() {
  var_49a1f28198874781 = getdvarint(@ "hash_c794e905073b07a4", 5);
  var_24770e5472ff8c0b = getdvarint(@ "hash_cffa0859ef69d472", 20);
  assert(var_49a1f28198874781 < var_24770e5472ff8c0b);
  wait randomintrange(var_49a1f28198874781, var_24770e5472ff8c0b);

  if(isDefined(self) && (iseliminated() || isDefined(self getspectatingplayer()))) {
    kickplayer();
  }
}

function function_b74cf5eb822312cb(skipteammate) {
  foreach(player in level.players) {
    if(istrue(skipteammate) && self.team == player.team) {
      continue;
    }

    if(function_40034c2faf09a87b(player)) {
      var_c907d6a55798b4e = anglesToForward(player.angles);
      var_87c3be94eb77030f = self.origin - player.origin;

      if(vectordot(var_87c3be94eb77030f, var_c907d6a55798b4e) > 0) {
        if(player cansee_los(self)) {
          return true;
        }
      }
    }
  }

  return false;
}

function function_16a5388d4963e316() {
  if(!isDefined(self.var_23df2e87f39050f5) || self.var_23df2e87f39050f5 != gettime()) {
    self.var_23df2e87f39050f5 = gettime();
    self.var_fff6e27dea20881 = function_b74cf5eb822312cb();
  }

  assert(isDefined(self.var_fff6e27dea20881));
  return self.var_fff6e27dea20881;
}

function function_da84567cda38847e() {
  foreach(player in level.players) {
    if(!isai(player)) {
      playertospectate = player scripts\mp\gametypes\br_spectate::playergetspectatingplayer();

      if(isDefined(playertospectate) && playertospectate == self) {
        return true;
      }
    }
  }

  return false;
}

function cansee_los(targetplayer) {
  assert(isPlayer(targetplayer));
  return targetplayer sightconetrace(self getEye(), self) > 0;
}

function iseliminated() {
  return istrue(self.br_iseliminated);
}

function isvalidplayerbr(player) {
  return isaliveplayer(player) && !player iseliminated() && !player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag();
}

function function_40034c2faf09a87b(player) {
  return isvalidplayer(player) && !isai(player);
}

function isvalidbot(player) {
  return isvalidplayer(player) && isbot(player) && !player namespace_95d8d8ec67e3e074::isuibot();
}

function isvalidplayeronground(player) {
  return isvalidplayer(player) && !player isskydiving();
}

function iskillstreakavailable(type) {
  streakitem = scripts\mp\gametypes\br_armory_kiosk::function_601181692f53e4ed(type);

  if(!isDefined(streakitem)) {
    return 0;
  }

  return scripts\mp\gametypes\br_pickups::iskillstreakavailable(streakitem.ref);
}

function function_c4053e29135c5d27() {
  assert(isbot(self));
  var_b8bba9ccd960781 = getdvarint(@ "hash_946321d51f80b343", 3000);
  var_c3f669f8cd557637 = function_a0fbe39135ab0d35();
  var_ae5632495dfca986 = gettime() - var_c3f669f8cd557637;
  return var_ae5632495dfca986 > var_b8bba9ccd960781;
}

function function_a0fbe39135ab0d35() {
  var_c3f669f8cd557637 = 0;

  if(isDefined(self.lastdamagedtime)) {
    var_c3f669f8cd557637 = max(var_c3f669f8cd557637, self.lastdamagedtime);
  }

  if(isDefined(self.var_c826ab9d43c24233)) {
    var_c3f669f8cd557637 = max(var_c3f669f8cd557637, self.var_c826ab9d43c24233);
  }

  if(!isai(self)) {
    engageinfo = self.engageinfo;

    if(isDefined(engageinfo.var_f315b15bf1bd4b5e)) {
      var_c3f669f8cd557637 = max(var_c3f669f8cd557637, engageinfo.var_f315b15bf1bd4b5e);
    }
  }

  return var_c3f669f8cd557637;
}

function function_5f352fb76c54705c() {
  var_aea051c033b84a83 = undefined;
  var_7a8b23e91af57c28 = undefined;

  if(getdvarint(@ "hash_82bde055b11e6698", 0)) {
    var_aea051c033b84a83 = namespace_94f9b19ae91ab934::function_5f352fb76c54705c();
    var_7a8b23e91af57c28 = namespace_5a4a9f3e4a0baf2f::function_5f352fb76c54705c();
  } else {
    var_aea051c033b84a83 = scripts\mp\gametypes\br_assassination_quest::function_5f352fb76c54705c();
    var_7a8b23e91af57c28 = scripts\mp\gametypes\br_vip_quest::function_5f352fb76c54705c();
  }

  return var_aea051c033b84a83 || istrue(var_7a8b23e91af57c28);
}

function function_bbc2d6967287dc7(lootitemname, valuetable) {
  loottype = level.br_pickups.br_itemtype[lootitemname];

  if(lootitemname == "military_ammo_restock") {
    loottype = function_1823ff50bb28148d("ammo_restock");
  }

  assertex(isDefined(loottype), "<dev string:x5fd>" + lootitemname);

  switch (loottype) {
    case #"ammo":
      return scripts\mp\gametypes\br_pickups::canholdammobox(lootitemname);
    case #"gear":
      return !scripts\cp_mp\gasmask::hasgasmask(self);
    case #"health":
      return function_5ba1e582607305e4("health", lootitemname);
    case #"revive":
      return !scripts\mp\gametypes\br_public::hasselfrevivetoken();
    case #"lethal":
      return function_5ba1e582607305e4("primary", lootitemname, valuetable);
    case #"tactical":
      return function_5ba1e582607305e4("secondary", lootitemname, valuetable);
    case #"killstreak":
      if(!scripts\mp\gametypes\br_pickups::hasanykillstreak()) {
        return 1;
      } else if(isDefined(valuetable)) {
        defaultvalue = valuetable.typevalue[#"killstreak"];
        assert(isDefined(defaultvalue));
        equippedkillstreak = level.br_pickups.var_838863c4848d4c26[self.streakdata.streaks[1].streakname];
        var_82650800f1c44914 = ter_op(isDefined(valuetable.lootvalue[equippedkillstreak]), valuetable.lootvalue[equippedkillstreak], defaultvalue);
        var_452a165d9f2f19b3 = ter_op(isDefined(valuetable.lootvalue[lootitemname]), valuetable.lootvalue[lootitemname], defaultvalue);
        return (var_452a165d9f2f19b3 > var_82650800f1c44914);
      } else {
        return 0;
      }
    case #"super":
      return function_5ba1e582607305e4("super", lootitemname, valuetable);
    case #"weapon":
      classname = level.br_lootiteminfo[lootitemname].fullweaponobj.classname;
      var_f8a42b1fc9705ecf = undefined;

      if(!isDefined(classname)) {
        var_f8a42b1fc9705ecf = 0;
        assertmsg(lootitemname + "<dev string:x613>");
      } else {
        var_f8a42b1fc9705ecf = classname == "pistol" || classname == "rocketlauncher";
      }

      playerweaponrarity = 0;
      currentprimaryweapon = self getcurrentprimaryweapon();
      currentprimaryweaponclass = weaponclass(currentprimaryweapon);

      if(currentprimaryweaponclass == "pistol" || currentprimaryweaponclass == "melee") {
        playerweaponrarity = -1;
      } else {
        playerweaponrarity = scripts\mp\gametypes\br_pickups::getweaponpickuprarity(currentprimaryweapon);
      }

      pickweapon = level.br_lootiteminfo[lootitemname].fullweaponobj;
      var_167e430a395b12ba = scripts\mp\gametypes\br_pickups::getweaponpickuprarity(pickweapon);
      var_c946bb8bd070cc8b = playerweaponrarity < var_167e430a395b12ba;
      return (!var_f8a42b1fc9705ecf && var_c946bb8bd070cc8b);
    case #"cache":
      return 1;
    case #"ammo_restock":
      return 1;
    case #"plunder":
      return 1;
    case #"tablet":
      return !namespace_1eb3c4e0e28fac71::function_7094c7010c5e3827(self.team);
  }

  return 0;
}

function function_5ba1e582607305e4(slot, lootname, valuetable) {
  equippedloot = self.equipment[slot];

  if(!isDefined(equippedloot)) {
    return 1;
  }

  var_58f7650e8def9a65 = level.br_pickups.br_equipnametoscriptable[equippedloot];

  if(!isDefined(var_58f7650e8def9a65)) {
    println("<dev string:x63d>" + equippedloot + "<dev string:x64f>");
    return 0;
  }

  if(var_58f7650e8def9a65 == lootname) {
    var_5324597edfaff57c = scripts\mp\equipment::getequipmentslotammo(slot);
    var_b5cdf4d935e6ac13 = scripts\mp\equipment::getequipmentmaxammo(equippedloot);
    return (var_5324597edfaff57c < var_b5cdf4d935e6ac13);
  }

  if(isDefined(valuetable)) {
    loottype = level.br_pickups.br_itemtype[lootname];
    defaultvalue = valuetable.typevalue[loottype];
    assert(isDefined(defaultvalue));
    var_82650800f1c44914 = ter_op(isDefined(valuetable.lootvalue[var_58f7650e8def9a65]), valuetable.lootvalue[var_58f7650e8def9a65], defaultvalue);
    var_452a165d9f2f19b3 = ter_op(isDefined(valuetable.lootvalue[lootname]), valuetable.lootvalue[lootname], defaultvalue);
    return (var_452a165d9f2f19b3 > var_82650800f1c44914);
  }

  return 0;
}

function ispointincurrentsafecircle(point) {
  circleorigin = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  circleradius = scripts\mp\gametypes\br_circle::getsafecircleradius();
  return ispointinsidecircle(point, circleorigin, circleradius);
}

function function_e5b4b5992cddb221() {
  var_4f5c90c268d3ebf1 = scripts\mp\gametypes\br_circle_util::function_7d381171eae99b77();
  var_624c059685e285b3 = scripts\mp\gametypes\br_circle_util::function_bf15a5aa7e72aee9();
  result = spawnStruct();
  var_2c6a15308bc5c400 = -1;

  for(i = 0; i < var_4f5c90c268d3ebf1.size; i++) {
    var_7617c5ac71106ac5 = distance2dsquared(self.origin, var_4f5c90c268d3ebf1[i]);

    if(var_2c6a15308bc5c400 < 0 || var_7617c5ac71106ac5 < var_2c6a15308bc5c400) {
      var_2c6a15308bc5c400 = var_7617c5ac71106ac5;
      result.origin = var_4f5c90c268d3ebf1[i];
      result.radius = var_624c059685e285b3[i];
    }
  }

  return result;
}

function function_61e3c952715399e0() {
  circle = function_e5b4b5992cddb221();
  point = scripts\mp\gametypes\br_circle::getrandompointincircle(circle.origin, circle.radius, undefined, undefined, 1, 0, undefined, undefined);
  return scripts\mp\bots\bots_util::function_f8350ab882cc2439(point);
}

function function_c42a53b48c0a683e() {
  circle = function_e5b4b5992cddb221();
  point = function_fcc75af6225b896b(circle.origin, circle.radius);
  return function_207ba502560fa1d2(point);
}

function function_bcb0778bb33e86de(point) {
  if(scripts\mp\gamelogic::inprematch()) {
    return 1;
  }

  if(scripts\mp\gametypes\br_circle_util::ispointinmulticircledanger(self.origin)) {
    return scripts\mp\gametypes\br_circle_util::function_77cec84f05ca9418(self.origin, point);
  }

  circle = function_e5b4b5992cddb221();
  return distance2dsquared(point, circle.origin) < circle.radius * circle.radius;
}

function function_8b201bccc0aa3695(point, seconds) {
  self setplayerangles(vectortoangles(point - self.origin));
  function_c43469e7a5ae4ba4(point, seconds);
}

function function_d1acad1ee42b2b2f(entity, seconds, anglerange) {
  randomrange = randomintrange(anglerange * -1, anglerange);
  self botsetscriptmove(entity.angles[1] + randomrange, seconds, 0.1);
  wait seconds;
}

function function_6dd2dfeb41384764() {
  assertex(scripts\cp_mp\utility\game_utility::isbrstylegametype(), "<dev string:x674>");

  if(!scripts\cp_mp\utility\squad_utility::issquadmode()) {
    return 0;
  }

  if(scripts\mp\utility\game::matchmakinggame()) {
    return function_48dc7b5f7e9e4061();
  }

  return !getdvarint(@ "hash_d356a7876f773136", 0);
}

function nearestplace(places, inputarray, var_330c401bd2801f95, var_3b233cde4adf9cd0, var_bef59d5b603763b0, var_6681cebd53b80d74) {
  finalplace = undefined;
  var_f599866086ff8be = 0;

  if(istrue(var_3b233cde4adf9cd0)) {
    filterfunc = &ispointincurrentsafecircle;
  } else {
    filterfunc = &scripts\mp\bots\bots_gametype_br::ispointincurrentcircle;
  }

  foreach(place in places) {
    if(![[filterfunc]](place.origin)) {
      continue;
    }

    var_5ffe906c9d39a37f = distance(self.origin, place.origin);
    placescore = function_9d1ab012058221bb(var_5ffe906c9d39a37f, inputarray, var_330c401bd2801f95);

    if(isDefined(var_bef59d5b603763b0)) {
      var_7d9a6d00a336393b = scripts\mp\gametypes\br_circle_util::gettimetilldangerforpoint(place.origin);
      var_40f4b7920a0ca8a0 = function_9d1ab012058221bb(var_7d9a6d00a336393b, var_bef59d5b603763b0, var_6681cebd53b80d74);
      placescore += var_40f4b7920a0ca8a0;
    }

    if(placescore > var_f599866086ff8be) {
      var_f599866086ff8be = placescore;
      finalplace = place;
    }
  }

  if(!isDefined(finalplace)) {
    return undefined;
  }

  placeinfo = spawnStruct();
  placeinfo.score = var_f599866086ff8be;
  placeinfo.target = finalplace;
  return placeinfo;
}

function isammoenough(weaponobj, ratio) {
  ammotype = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(weaponobj);

  if(!isDefined(ammotype)) {
    return 0;
  }

  var_b76e538aee4d17aa = !isDefined(self.br_ammo) || !isDefined(self.br_ammo[ammotype]) || !isDefined(level.var_e6ea72fc5e3fcd00[ammotype]);

  if(var_b76e538aee4d17aa) {
    assertmsg("<dev string:x6af>" + ammotype + "<dev string:x6be>" + weaponobj.basename + "<dev string:x6db>");
    return 0;
  }

  weaponammo = self.br_ammo[ammotype] + self getweaponammoclip(weaponobj);
  maxstock = level.var_e6ea72fc5e3fcd00[ammotype];
  var_49fffc1ce970e26d = weaponammo / maxstock > ratio;
  return var_49fffc1ce970e26d;
}

function function_1c51f7c46a848ddd() {
  return float(level.br_circle.circleindex) / (level.br_level.br_circledelaytimes.size - level.br_level.br_movingcirclecount);
}

function function_c38398385afc10fc() {
  level waittill("player_spawned", player);

  if(!scripts\mp\utility\game::matchmakinggame()) {
    botcount = getdvarint(@ "hash_116700c9b39c1eba", 0);
    level thread function_f166b9f78beca5e6(botcount);
  }

  setupdevgui();
}

function function_f166b9f78beca5e6(count) {
  var_50ade409b1e5efcb = [];

  for(i = 1; i <= count; i++) {
    botinfo = spawnStruct();
    botinfo.name = "";
    var_50ade409b1e5efcb[var_50ade409b1e5efcb.size] = botinfo;
  }

  level spawnbots(var_50ade409b1e5efcb, "autoassign", undefined, undefined, "spawned_bots");
}

function function_b5e22620a8778c4a(arena) {
  if(!isDefined(arena)) {
    return;
  }

  if(arena.arenaplayers.size < 2) {
    return;
  }

  gulagplayers = array_combine(arena.arenaplayers, arena.jailedplayers);

  foreach(player in gulagplayers) {
    if(!isbot(player)) {
      return;
    }
  }

  foreach(player in gulagplayers) {
    if(player function_da84567cda38847e()) {
      return;
    }
  }

  winners = [];
  losers = [];
  winnerteam = arena.arenaplayers[ter_op(randomint(2) == 0, 0, 1)].team;

  foreach(player in arena.arenaplayers) {
    if(player.team == winnerteam) {
      winners[winners.size] = player;
      continue;
    }

    losers[losers.size] = player;
  }

  foreach(loser in losers) {
    loser dodamage(loser.health + 1000, winners[0].origin, winners[0], winners[0], "MOD_RIFLE_BULLET", winners[0] getcurrentweapon());
    println("<dev string:x6e0>" + loser.name + "<dev string:x709>");
  }
}

function private function_bb8b7cdce37ccab() {
  scripts\mp\bots\bots_gametype_br::function_543a0a3113ff89f7();
  namespace_41f4dfb71dd08362::onbotspawnedcommon("Combat");
  self botsetflag("allow_laststand_decision", 1);
  self.initdifficulty = self botgetdifficulty();
  self.difficulty = self botgetdifficulty();
  self.var_ab5f5270cb22e3c8 = 1;
}

function private function_eac6ce0d8138984b() {
  waitframe();
}