/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\horde.gsc
***************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\bots\_bots_util;
#include maps\mp\agents\_agent_utility;
#include maps\mp\gametypes\_horde_util;
#include maps\mp\gametypes\_horde_laststand;
#include maps\mp\gametypes\_horde_crates;

CONST_PLAYER_TEAM = "allies";
CONST_ENEMY_TEAM = "axis";
CONST_DATA_TABLE_END = 20;
CONST_AI_MAX_ALIVE = 20;
CONST_ROUND_INTERMISSION = 20;
CONST_ENEMY_HEALTH_INCREASE = 20;
CONST_LOOT_ROUND_TIMER = 25;
CONST_WEAPON_LEVEL_INCREASE = 0.10;
CONST_TABLE_NAME = "mp/hordeSettings.csv";
CONST_MAX_ENEMY_COLUMN = 1;
CONST_MAX_ALIVE_COLUMN = 2;
CONST_AVG_SCORE_PER_KILL = 45;
CONST_DOG_ROUND_CHANCE = 20;

CONST_PLAYER_START_WEAPON = "iw6_mp443";
CONST_PLAYER_ATTACHMENT = "xmags";
CONST_PLAYER_START_LETHAL = "proximity_explosive_mp";
CONST_PLAYER_START_TACTICAL = "concussion_grenade_mp";
CONST_PLAYER_DAMAGE_SCALE = 0.125;

CONST_FORCE_PICKUP_DROP = false;
CONST_FORCE_TEAM_INTEL = false;
CONST_GAME_END_ON_DEATH = true;
CONST_GIVE_ALL_PERKS = false;
CONST_CRATE_DEBUG = false;
CONST_MAX_DROP_NUMBER = false;

main() {
  maps\mp\gametypes\_globallogic::init();
  maps\mp\gametypes\_callbacksetup::SetupCallbacks();
  maps\mp\gametypes\_globallogic::SetupCallbacks();

  if(isUsingMatchRulesData()) {
    level.initializeMatchRules = ::initializeMatchRules;
    [
      [level.initializeMatchRules]
    ]();
    level thread reInitializeMatchRulesOnMigration();
  } else {
    registerRoundSwitchDvar(level.gameType, 0, 0, 9);
    registerTimeLimitDvar(level.gameType, 0);
    registerScoreLimitDvar(level.gameType, 0);
    registerRoundLimitDvar(level.gameType, 1);
    registerWinLimitDvar(level.gameType, 1);
    registerNumLivesDvar(level.gameType, 1);
    registerHalfTimeDvar(level.gameType, 0);
  }

  SetDynamicDvar("r_hudOutlineWidth", 1);
  SetDynamicDvar("scr_horde_timeLimit", 0);
  SetDynamicDvar("scr_horde_numLives", 1);

  registerTimeLimitDvar(level.gameType, 0);

  SetDevDvarIfUninitialized("scr_hordeSetRound", "0");

  setSpecialLoadouts();
  initPickups();
  loadEffects();

  level.enableSpecialRound = true;
  level.specialRoundTime = CONST_LOOT_ROUND_TIMER;

  if(CONST_CRATE_DEBUG) {
    level.specialRoundTime = 6000;
    level.spawnMaxCrates = true;
  }

  level.teamBased = true;
  level.isHorde = true;
  level.disableForfeit = true;
  level.noBuddySpawns = true;
  level.alwaysdrawfriendlyNames = true;
  level.scoreLimitOverride = true;
  level.allowLateComers = true;
  level.skipLivesXPScalar = true;
  level.highLightAirDrop = true;
  level.noCrateTimeOut = true;
  level.noAirDropKills = true;
  level.allowLastStandAI = true;
  level.enableTeamIntel = true;
  level.isTeamIntelComplete = true;
  level.removeKillStreakIcons = true;
  level.assists_disabled = true;
  level.skipPointDisplayXP = true;
  level.forceRanking = true;
  level.allowCamoSwap = false;
  level.allowFauxDeath = false;
  level.killstreakRewards = false;
  level.supportIntel = false;
  level.gameHasStarted = false;
  level.doNotTrackGamesPlayed = true;
  level.disableWeaponStats = true;
  level.playerTeam = CONST_PLAYER_TEAM;
  level.enemyTeam = CONST_ENEMY_TEAM;
  level.lastStandUseTime = 2000;
  level.currentTeamIntelName = "";
  level.timerOmnvars = [];

  level.onStartGameType = ::onStartGameType;
  level.getSpawnPoint = ::getSpawnPoint;
  level.onNormalDeath = ::onNormalDeath;
  level.onSpawnPlayer = ::onSpawnPlayer;
  level.modifyPlayerDamage = ::modifyPlayerDamageHorde;
  level.callbackPlayerLastStand = ::Callback_PlayerLastStandHorde;
  level.onDeadEvent = ::onDeadEvent;
  level.customCrateFunc = ::createHordeCrates;
  level.onSuicideDeath = ::onNormalDeath;
  level.weaponDropFunction = ::dropWeaponForDeathHorde;

  level.skipRoundFunc = ::skipRound;
  level.hordeReviveAll = ::respawnEliminatedPlayers;
  level.hordeShowDropLocations = ::hordeShowDropLocations;
}

setupDialog() {
  game["dialog"]["gametype"] = "infct_hint";
  game["dialog"]["offense_obj"] = "null";
  game["dialog"]["defense_obj"] = "null";

  game["dialog"]["mission_success"] = "sgd_end";
  game["dialog"]["mission_failure"] = "sgd_end_fail";
  game["dialog"]["mission_draw"] = "sgd_end_fail";

  game["dialog"]["round_end"] = "sgd_rnd_end";
  game["dialog"]["round_start"] = "sgd_rnd_start";
  game["dialog"]["round_loot"] = "sgd_plr_join";

  game["dialog"]["weapon_level"] = "sgd_prf_inc";
  game["dialog"]["max_ammo"] = "sgd_team_restock";
  game["dialog"]["support_drop"] = "sgd_supply_drop";

  game["dialog"]["ally_down"] = "sgd_ally_down";
  game["dialog"]["ally_dead"] = "sgd_ally_dead";

  game["dialog"]["dc"] = "sgd_plr_quit";
  game["dialog"]["squadmate"] = "sgd_squad";
}

loadEffects() {
  level._effect["dropLocation"] = LoadFX("smoke/signal_smoke_airdrop");
  level._effect["spawn_effect"] = LoadFX("fx/maps/mp_siege_dam/mp_siege_spawn");
  level._effect["crate_teleport"] = LoadFX("vfx/gameplay/mp/core/vfx_teleport_player");
  level._effect["loot_crtae"] = LoadFX("vfx/gameplay/mp/core/vfx_marker_base_cyan");
  level._effect["weapon_level"] = LoadFX("vfx/gameplay/mp/killstreaks/vfx_3d_world_ping");
}

initPickups() {
  level.maxPickupsPerRound = getMaxPickupsPerRound();
  level.maxAmmoPickupsPerRound = 1;
  level.currentPickupCount = 0;
  level.currentAmmoPickupCount = 0;
  level.percentChanceToDrop = getPercentChanceToDrop();

  level.weaponPickupModel = "mp_weapon_level_pickup_badge";
  level.weaponPickupFunc = ::weaponPickup;

  level.ammoPickupModel = "prop_mp_max_ammo_pickup";
  level.ammoPickupFunc = ::ammoPickup;
}

waitThenFlashHudTimer(waitTime) {
  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(waitTime);

  setTimerOmnvar("ui_cranked_bomb_timer_final_seconds", 1);
}

setHudTimer(timerLabel, timeInS) {
  level thread waitThenFlashHudTimer(timeInS - 5);

  setTimerOmnvar("ui_cranked_bomb_timer_text", timerLabel);
  setTimerOmnvar("ui_cranked_bomb_timer_end_milliseconds", int(GetTime() + timeInS * 1000));
}

clearHudTimer() {
  setTimerOmnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
}

setTimerOmnvar(varName, varValue) {
  level.timerOmnvars[varName] = varValue;
  foreach(player in level.players) {
    player SetClientOmnvar(varName, varValue);
  }
}

updateTimerOmnvars(player) {
  foreach(varName, varValue in level.timerOmnvars) {
    player SetClientOmnvar(varName, varValue);
  }
}

getMaxPickupsPerRound() {
  if(CONST_FORCE_PICKUP_DROP)
    return 100;

  maxPickupsPerRound = getNumPlayers() + 1;

  return clamp(maxPickupsPerRound, 3, 5);
}

getPercentChanceToDrop() {
  if(CONST_FORCE_PICKUP_DROP)
    return 100;

  percentChanceToDrop = 0;
  numPlayers = getNumPlayers();

  switch (numPlayers) {
    case 0:
      percentChanceToDrop = 0;
      break;
    case 1:
      percentChanceToDrop = 14;
      break;
    case 2:
      percentChanceToDrop = 13;
      break;
    case 3:
      percentChanceToDrop = 12;
      break;
    case 4:
    default:
      percentChanceToDrop = 10;
      break;
  }

  return percentChanceToDrop;
}

initializeMatchRules() {
  setCommonRulesFromMatchRulesData();

  SetDynamicDvar("scr_horde_roundswitch", 0);
  registerRoundSwitchDvar("horde", 0, 0, 9);
  SetDynamicDvar("scr_horde_roundlimit", 1);
  registerRoundLimitDvar("horde", 1);
  SetDynamicDvar("scr_horde_winlimit", 1);
  registerWinLimitDvar("horde", 1);
  SetDynamicDvar("scr_horde_halftime", 0);
  registerHalfTimeDvar("horde", 0);
  SetDynamicDvar("scr_horde_promode", 0);
  SetDynamicDvar("scr_horde_timeLimit", 0);
  registerTimeLimitDvar(level.gameType, 0);
  SetDynamicDvar("scr_horde_numLives", 1);
  registerNumLivesDvar(level.gameType, 1);

  SetDynamicDvar("scr_horde_difficulty", GetMatchRulesData("hordeData", "difficulty"));
  SetDynamicDvar("r_hudOutlineWidth", 1);
}

onStartGameType() {
  setClientNameMode("auto_change");

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = false;

  setObjectiveText("allies", & "HORDE_OBJECTIVE");
  setObjectiveText("axis", & "HORDE_OBJECTIVE");
  setObjectiveScoreText("allies", & "HORDE_OBJECTIVE_SCORE");
  setObjectiveScoreText("axis", & "HORDE_OBJECTIVE_SCORE");

  setObjectiveHintText("allies", & "HORDE_OBJECTIVE_HINT");
  setObjectiveHintText("axis", & "HORDE_OBJECTIVE_HINT");

  initSpawns();
  setupDialog();

  allowed[0] = level.gameType;
  maps\mp\gametypes\_gameobjects::main(allowed);

  initHordeSettings();

  level thread onPlayerConnectHorde();
  level thread runHordeMode();
  level thread runDropLocations();
}

initHordeSettings() {
  SetDvar("g_keyboarduseholdtime", 250);

  level.hordeDropLocations = getstructarray("horde_drop", "targetname");
  AssertEx(isDefined(level.hordeDropLocations) && (level.hordeDropLocations.size > 11), "map needs horde game objects");

  level.blastShieldMod = 0.75;
  level.intelMiniGun = "iw6_minigunjugg_mp";

  level.hordeDifficultyLevel = int(clamp(GetDvarInt("scr_horde_difficulty", 3), 1, 3));
  level.maxRounds = getMaxRounds(level.hordeDifficultyLevel);
  level.currentRoundNumber = 0;
  level.currentPointTotal = 0;
  level.enemyOutlineColor = 4;
  level.dropLocationIndex = 0;
  hordeDropLocationTrace();

  level.chanceToSpawnDog = 0;
  level.lastDogRound = 0;

  level.pointEvents = [];
  level.pointEvents["damage_body"] = 10;
  level.pointEvents["damage_head"] = 30;
  level.pointEvents["kill_normal"] = 20;
  level.pointEvents["kill_melee"] = 50;
  level.pointEvents["kill_head"] = 50;

  level.HudLeftSpace = 50;
  level.HudDownSpace = 395;
}

hordeDropLocationTrace() {
  foreach(dropLocation in level.hordeDropLocations) {
    start = dropLocation.origin + (0, 0, 32);
    end = dropLocation.origin - (0, 0, 256);
    trace = bulletTrace(start, end, false);

    dropLocation.traceLocation = dropLocation.origin;

    if(trace["fraction"] < 1)
      dropLocation.traceLocation = trace["position"];
  }
}

onPlayerConnectHorde() {
  while(true) {
    level waittill("connected", player);

    player.gameModefirstSpawn = true;
    player.hasUsedSquadMate = false;

    if(level.currentRoundNumber > 10)
      player.hasUsedSquadMate = true;

    level thread createPlayerVariables(player);
    level thread monitorDoubleTap(player);
    level thread monitorStuck(player);
    level thread updateOutlines(player);
  }
}

createPlayerVariables(player) {
  player.weaponState = [];
  player.horde_perks = [];
  player.pointNotifyLUA = [];
  player.beingRevived = false;

  player.killz = 0;
  player.numRevives = 0;
  player.numCrtaesCaptured = 0;
  player.roundsPlayed = 0;
  player.maxWeaponLevel = 1;

  level.playerStartWeaponName = CONST_PLAYER_START_WEAPON + "_mp_" + CONST_PLAYER_ATTACHMENT;
  baseWeaponNameStartWeapon = GetWeaponBaseName(level.playerStartWeaponName);

  createHordeWeaponState(player, level.playerStartWeaponName, false);
  createHordeWeaponState(player, level.intelMiniGun, false);

  level thread activatePlayerHUD(player);
  level thread monitorWeaponProgress(player);
  level thread monitorPointNotifyLUA(player);
}

createHordeWeaponState(player, weaponName, bSetBarSize) {
  baseWeaponName = GetWeaponBaseName(weaponName);

  if(hasWeaponState(player, baseWeaponName)) {
    return;
  }
  player.weaponState[baseWeaponName]["level"] = 1;
  player.weaponState[baseWeaponName]["vaule"] = 0;
  player.weaponState[baseWeaponName]["barSize"] = 0;

  if(bSetBarSize)
    player.weaponState[baseWeaponName]["barSize"] = getWeaponBarSize(1, baseWeaponName);
}

hasWeaponState(player, baseWeaponName) {
  return (isDefined(baseWeaponName) && isDefined(player.weaponState[baseWeaponName]));
}

onSpawnPlayer() {
  AssertEx(!IsBot(self), "no bots allowed in horde mode");

  if(self.gameModefirstSpawn) {
    self.pers["class"] = "gamemode";
    self.pers["lastClass"] = "";
    self.pers["gamemodeLoadout"] = level.hordeLoadouts[level.playerTeam];
    self.class = self.pers["class"];
    self.lastClass = self.pers["lastClass"];
  }

  if(IsAgent(self)) {
    if(!isOnHumanTeam(self)) {
      setEnemyAgentHealth(self);
      setEnemyDifficultySettings(self);

      loadout = getHordeEnemyLoadOut();
      self.pers["gamemodeLoadout"] = loadout;
      self.agentname = loadout["name_localized"];
      self.horde_type = loadout["type"];

      self thread maps\mp\agents\_agents_gametype_horde::playAISpawnEffect();
    } else {
      self.pers["gamemodeLoadout"] = level.hordeLoadouts["squadmate"];

      self bot_set_personality("camper");
      self bot_set_difficulty("regular");
      self BotSetDifficultySetting("allowGrenades", 1);
    }

    self.avoidKillstreakOnSpawnTimer = 0;
  }

  self thread onSpawnFinished();
}

setEnemyDifficultySettings(agent) {
  agent bot_set_personality("run_and_gun");

  if(level.currentRoundNumber < 41) {
    agent bot_set_difficulty("recruit");

    agent BotSetDifficultySetting("visionBlinded", 0.05);
    agent BotSetDifficultySetting("hearingDeaf", 0.05);

    agent BotSetDifficultySetting("meleeReactAllowed", 1);
    agent BotSetDifficultySetting("meleeReactionTime", 600);
    agent BotSetDifficultySetting("meleeDist", 85);
    agent BotSetDifficultySetting("meleeChargeDist", 100);

    agent BotSetDifficultySetting("minGraceDelayFireTime", 0);
    agent BotSetDifficultySetting("maxGraceDelayFireTime", 0);

    agent BotSetDifficultySetting("minInaccuracy", 1.25);
    agent BotSetDifficultySetting("maxInaccuracy", 1.75);
    agent BotSetDifficultySetting("strafeChance", 0.25);

    if(level.currentRoundNumber > 8) {
      agent BotSetDifficultySetting("minInaccuracy", 0.75);
      agent BotSetDifficultySetting("maxInaccuracy", 1.50);
    }

    if(level.currentRoundNumber > 20) {
      agent BotSetDifficultySetting("adsAllowed", 1);
      agent BotSetDifficultySetting("diveChance", 0.15);
    }
  } else {
    if(level.currentRoundNumber > 50) {
      agent bot_set_difficulty("veteran");
    } else {
      agent bot_set_difficulty("hardened");
    }
  }

  agent BotSetDifficultySetting("allowGrenades", 0);
  agent BotSetDifficultySetting("avoidSkyPercent", 0);
}

giveEnemyPerks() {
  if(level.currentRoundNumber > 15)
    self givePerk("specialty_fastreload", false);

  if(level.currentRoundNumber > 20)
    self givePerk("specialty_fastsprintrecovery", false);

  if(level.currentRoundNumber > 30)
    self givePerk("specialty_lightweight", false);

  if(level.currentRoundNumber > 35)
    self givePerk("specialty_quickdraw", false);

  if(level.currentRoundNumber > 40)
    self givePerk("specialty_stalker", false);

  if(level.currentRoundNumber > 45)
    self givePerk("specialty_marathon", false);

  if(level.currentRoundNumber > 50)
    self givePerk("specialty_regenfaster", false);
}

setEnemyAgentHealth(agent) {
  agent.maxhealth = 60 + (CONST_ENEMY_HEALTH_INCREASE * level.currentRoundNumber);
  agent.health = agent.maxhealth;
}

onSpawnFinished() {
  selfendon("death");
  selfendon("disconnect");
  level endon("game_ended");

  self waittill("giveLoadout");

  self maps\mp\killstreaks\_killstreaks::clearKillstreaks();

  if(isOnHumanTeam(self)) {
    self GiveMaxAmmo(level.playerStartWeaponName);
    self thread playerAmmoRegen(level.playerStartWeaponName);

    if(IsPlayer(self)) {
      self SetWeaponAmmoClip(CONST_PLAYER_START_LETHAL, 1);
      self SetWeaponAmmoClip(CONST_PLAYER_START_TACTICAL, 1);
      self givePerk("specialty_pistoldeath", false);

      if(!self.hasUsedSquadMate) {
        self thread maps\mp\killstreaks\_killstreaks::giveKillstreak("agent", false, false, self);
      }

      self childthread updateRespawnSplash(self.gameModefirstSpawn);

      removePerkHUD(self);
      updateTimerOmnvars(self);
    }

    if(IsAgent(self)) {
      self.agentname = & "HORDE_BUDDY";
      self.horde_type = "Buddy";

      self childthread ammoRefillPrimary();
      self thread maps\mp\bots\_bots::bot_think_revive();

      if(isDefined(self.owner))
        self.owner.hasUsedSquadMate = true;
    }
  } else {
    self childthread ammoRefillPrimary();
    self childthread ammoRefillSecondary();

    switch (self.horde_type) {
      case "Ravager":
        self setRavagerModel();
        break;
      case "Enforcer":
        self setEnforcerModel();
        break;
      case "Striker":
        self setStrikerModel();
        self BotSetFlag("path_traverse_wait", true);
        break;
      case "Blaster":
        self setBlasterModel();
        self BotSetDifficultySetting("maxFireTime", 2800);
        self BotSetDifficultySetting("minFireTime", 1500);
        break;
      case "Hammer":
        self setHammerModel();
        break;
      default:
        AssertMsg("Unhandeled enemy type");
    }

    self SetViewmodel("viewhands_juggernaut_ally");
    self SetClothType("cloth");

    self giveEnemyPerks();
  }

  self.gameModefirstSpawn = false;
}

updateRespawnSplash(isFirstSpawn) {
  self waittill("spawned_player");

  if(!isFirstSpawn)
    self thread maps\mp\gametypes\_hud_message::SplashNotify("horde_respawn");
}

monitorStuck(player) {
  player endon("disconnect");

  while(true) {
    player waittill("unresolved_collision");

    maps\mp\_movers::unresolved_collision_nearest_node(player, false);

    wait(0.5);
  }
}

updateOutlines(player) {
  player endon("disconnect");

  if(level.currentRoundNumber == 0) {
    return;
  }
  if(!isDefined(level.carePackages)) {
    return;
  }
  foreach(dropCrate in level.carePackages) {
    if(isDefined(dropCrate.outlineColor)) {
      dropCrate.friendlyModel HudOutlineEnable(dropCrate.outlineColor, false);
    }
  }

  waitframe();

  if(!isDefined(level.characters)) {
    return;
  }
  foreach(agent in level.characters) {
    if(isDefined(agent.outlineColor)) {
      agent HudOutlineEnable(agent.outlineColor, false);
    }
  }
}

setRavagerModel() {
  self setModel("mp_body_infected_a");

  if(isDefined(self.headModel))
    self Detach(self.headModel, "");

  self.headModel = "head_mp_infected";
  self Attach(self.headModel, "", true);
}

setEnforcerModel() {
  self setModel("mp_body_juggernaut_light_black");

  if(isDefined(self.headModel))
    self Detach(self.headModel, "");

  self.headModel = "head_juggernaut_light_black";
  self Attach(self.headModel, "", true);
}

setStrikerModel() {
  self setModel("mp_body_infected_a");

  if(isDefined(self.headModel))
    self Detach(self.headModel, "");

  self.headModel = "head_mp_infected";
  self Attach(self.headModel, "", true);
}

setBlasterModel() {
  self setModel("mp_fullbody_juggernaut_heavy_black");

  if(isDefined(self.headModel)) {
    self Detach(self.headModel, "");
    self.headModel = undefined;
  }
}

setHammerModel() {
  self setModel("mp_body_juggernaut_light_black");

  if(isDefined(self.headModel))
    self Detach(self.headModel, "");

  self.headModel = "head_juggernaut_light_black";
  self Attach(self.headModel, "", true);
}

playerAmmoRegen(item) {
  selfendon("death");
  selfendon("disconnect");
  level endon("game_ended");

  weapList = self GetWeaponsListPrimaries();
  foreach(weap in weapList) {
    clipSize = WeaponClipSize(weap);
    self SetWeaponAmmoClip(weap, clipSize);
  }

  regen_interval = 1.5;

  while(true) {
    weapList = self GetWeaponsListPrimaries();
    foreach(weap in weapList) {
      if(weap == item) {
        ammoStock = self GetWeaponAmmoStock(weap);
        self SetWeaponAmmoStock(weap, ammoStock + 1);
      }
    }

    wait(regen_interval);
  }
}

ammoRefillPrimary() {
  if(self.primaryWeapon == "none") {
    return;
  }
  while(true) {
    self giveMaxAmmo(self.primaryWeapon);
    wait(12);
  }
}

ammoRefillSecondary() {
  if(self.secondaryWeapon == "none") {
    return;
  }
  while(true) {
    self giveMaxAmmo(self.secondaryWeapon);
    wait(8);
  }
}

runHordeMode() {
  level endon("game_ended");

  waitUntilMatchStart();

  foreach(player in level.players) {
    if(player.class == "") {
      player notify("luinotifyserver", "class_select", 0);
      player thread closeClassMenu();
    }
  }

  while(true) {
    updateHordeSettings();
    showNextRoundMessage();

    level notify("start_round");
    level.gameHasStarted = true;
    assignIntel();
    level childthread monitorRoundEnd();
    level waittill("round_ended");
  }
}

closeClassMenu() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  waitframe();
  self SetClientOmnvar("ui_options_menu", -1);
}

assignIntel() {
  if(CONST_FORCE_TEAM_INTEL && level.isTeamIntelComplete)
    level notify("giveTeamIntel", level.playerTeam);

  if(!(level.currentRoundNumber % 4) && level.isTeamIntelComplete)
    level notify("giveTeamIntel", level.playerTeam);

  if((level.currentRoundNumber == 21) && (getNumPlayers() == 1) && !hasAgentSquadMember(level.players[0])) {
    level.players[0] thread maps\mp\killstreaks\_killstreaks::giveKillstreak("agent", false, false, level.players[0]);
  }
}

monitorRoundEnd() {
  if(isSpecialRound()) {
    monitorSpecialRoundEnd();
  } else {
    monitorNormalRoundEnd();
  }
}

monitorNormalRoundEnd() {
  while(true) {
    level waittill("enemy_death");

    if((level.currentEnemyCount == level.maxEnemyCount) && (level.currentAliveEnemyCount == 0)) {
      notifyRoundOver();
      return;
    }
  }
}

monitorSpecialRoundEnd() {
  specialRoundTime = getSpecialRoundTimer();
  level thread showTeamSplashHorde("horde_special_round");

  setHudTimer("round_time", specialRoundTime);

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(specialRoundTime);

  clearHudTimer();
  notifyRoundOver();
}

getSpecialRoundTimer() {
  return level.specialRoundTime;
}

notifyRoundOver() {
  level notify("round_ended");
  level thread respawnEliminatedPlayers();
  level thread playSoundToAllPlayers("mp_safe_round_end");

  if(!isSpecialRound())
    level thread leaderDialog("round_end", level.playerTeam, "status");
}

respawnEliminatedPlayers() {
  level endon("game_ended");

  foreach(player in level.players) {
    if(!isOnHumanTeam(player)) {
      continue;
    }
    if(isPlayerInLastStand(player) && !player.beingRevived) {
      player notify("revive_trigger", player);
    }

    if(player.sessionstate == "spectator") {
      player.pers["lives"] = 1;
      player thread maps\mp\gametypes\_playerlogic::spawnClient();
    }
  }
}

updateAchievements() {
  if(level.currentRoundNumber > 19) {
    foreach(player in level.players) {
      player giveAchievement("EXTRA1");
    }
  }
}

updateHordeSettings() {
  level.hordeDifficultyLevel = int(clamp(GetDvarInt("scr_horde_difficulty", 3), 1, 3));
  level.maxRounds = getMaxRounds(level.hordeDifficultyLevel);

  updateAchievements();

  if(level.currentRoundNumber == level.maxRounds) {
    level.finalKillCam_winner = level.playerTeam;
    level thread maps\mp\gametypes\_gamelogic::endGame(level.playerTeam, game["end_reason"][level.enemyTeam + "_eliminated"]);
  }

  level.currentRoundNumber = getNextRoundNumber();

  level.maxEnemyCount = getMaxEnemyCount(level.currentRoundNumber);
  level.currentEnemyCount = 0;

  level.maxAliveEnemyCount = getMaxAliveEnemyCount(level.currentRoundNumber);
  level.currentAliveEnemyCount = 0;

  level.maxPickupsPerRound = getMaxPickupsPerRound();
  level.percentChanceToDrop = getPercentChanceToDrop();
  level.currentPickupCount = 0;
  level.currentAmmoPickupCount = 0;
  level.chanceToSpawnDog = 0;

  if(chanceForDogRound()) {
    level.chanceToSpawnDog = 55;
    level.lastDogRound = level.currentRoundNumber;
  }

  if(level.currentRoundNumber > 4)
    SetNoJIPScore(true);

  foreach(player in level.players) {
    player.roundsPlayed++;

    if((player.roundsPlayed != level.currentRoundNumber) && (player.roundsPlayed > 9))
      player.roundsPlayed = level.currentRoundNumber;

    awardHordeRoundNumber(player, player.roundsPlayed);
  }

  AssertEx((level.maxEnemyCount >= level.maxAliveEnemyCount), "level.maxAliveEnemyCount is more than level.maxEnemyCount");
}

chanceForDogRound() {
  if(level.currentRoundNumber < 4)
    return false;

  if(isSpecialRound(level.currentRoundNumber))
    return false;

  if(level.lastDogRound == (level.currentRoundNumber - 1))
    return false;

  if(RandomIntRange(1, 101) < CONST_DOG_ROUND_CHANCE)
    return true;

  if((level.currentRoundNumber - level.lastDogRound) > 4)
    return true;

  return false;
}

getNextRoundNumber() {
  nextRoundNumber = level.currentRoundNumber + 1;

  if(GetDvarInt("scr_hordeSetRound") > 0) {
    nextRoundNumber = GetDvarInt("scr_hordeSetRound");
    SetDevDvar("scr_hordeSetRound", 0);
  }

  return nextRoundNumber;
}

getRowNumber(roundNumber) {
  roundNumber = int(clamp(roundNumber, 1, CONST_DATA_TABLE_END));
  roundNumber = roundNumber - 1;
  return (roundNumber * 4) + getNumPlayers();
}

getMaxRounds(difficultyLevel) {
  maxRounds = 100;

  switch (difficultyLevel) {
    case 0:
    case 1:
      maxRounds = 20;
      break;
    case 2:
      maxRounds = 40;
      break;
    case 3:
      maxRounds = 100;
      break;
    default:
      maxRounds = 100;
      break;
  }

  return maxRounds;
}

getMaxEnemyCount(roundNumber) {
  rowNumber = getRowNumber(roundNumber);
  maxEnemyCount = int(TableLookupByRow(CONST_TABLE_NAME, rowNumber, CONST_MAX_ENEMY_COLUMN));

  if(roundNumber > CONST_DATA_TABLE_END) {
    roundsPastDataTable = roundNumber - CONST_DATA_TABLE_END;
    maxEnemyCount = maxEnemyCount + roundsPastDataTable;
  }

  return maxEnemyCount;
}

getMaxAliveEnemyCount(roundNumber) {
  rowNumber = getRowNumber(roundNumber);
  maxAliveEnemyCount = int(TableLookupByRow(CONST_TABLE_NAME, rowNumber, CONST_MAX_ALIVE_COLUMN));

  if(roundNumber > CONST_DATA_TABLE_END) {
    roundsPastDataTable = roundNumber - CONST_DATA_TABLE_END;
    scalar = 1 + int(roundsPastDataTable / 5);
    maxAliveEnemyCount = maxAliveEnemyCount + (2 * scalar);

    maxAliveEnemyCount = min(maxAliveEnemyCount, CONST_AI_MAX_ALIVE);
  }

  return maxAliveEnemyCount;
}

waitUntilMatchStart() {
  gameFlagWait("prematch_done");

  while(!isDefined(level.bot_loadouts_initialized) || (level.bot_loadouts_initialized == false)) {
    waitframe();
  }

  while(!level.players.size) {
    waitframe();
  }
}

showNextRoundMessage() {
  if(showIntermissionTimer())
    setHudTimer("start_time", getRoundIntermissionTimer());

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(getRoundIntermissionTimer());

  clearHudTimer();

  SetOmnvar("ui_horde_round_number", level.currentRoundNumber);
  level thread respawnEliminatedPlayers();

  if(!isSpecialRound()) {
    soundName = "mp_safe_round_start";

    if(isDogRound())
      soundName = "mp_safe_round_boss";

    level childthread playSoundToAllPlayers(soundName);
    level thread leaderDialog("round_start", level.playerTeam, "status");
  } else {
    level thread leaderDialog("round_loot", level.playerTeam, "status");
  }
}

showIntermissionTimer() {
  if(level.currentRoundNumber == 1)
    return false;

  if(isSpecialRound(level.currentRoundNumber))
    return false;

  if(isSpecialRound(level.currentRoundNumber - 1))
    return false;

  return true;
}

getRoundIntermissionTimer() {
  if(!showIntermissionTimer())
    return 5;

  return CONST_ROUND_INTERMISSION;
}

runDropLocations() {
  level endon("game_ended");

  waitUntilMatchStart();

  if(!isDefined(level.hordeDropLocations) || !level.hordeDropLocations.size) {
    return;
  }
  level childthread monitorSupportDropProgress();

  while(true) {
    level waittill("airSupport");

    level childthread displayIncomingAirDropMessage();

    dropNum = getNumPlayers() + 1;
    dropNum = min(dropNum, 4);

    if(CONST_MAX_DROP_NUMBER)
      dropNum = 4;

    sortDropLocations();

    for(i = 0; i < dropNum; i++) {
      dropLocation = level.hordeDropLocations[level.dropLocationIndex];
      level thread callAirSupport(dropLocation.traceLocation);
      level.dropLocationIndex = getNextDropLocationIndex(level.dropLocationIndex);
    }
  }
}

sortDropLocations() {
  totalPlayerPosition = (0, 0, 0);
  numPlayers = 0;

  foreach(player in level.players) {
    if(!isOnHumanTeam(player) || !IsAlive(player)) {
      continue;
    }
    numPlayers++;
    totalPlayerPosition = totalPlayerPosition + (player.origin[0], player.origin[1], player.origin[2]);
  }

  averagePlayerPosition = totalPlayerPosition / numPlayers;

  level.hordeDropLocations = SortByDistance(level.hordeDropLocations, averagePlayerPosition);
  level.dropLocationIndex = RandomInt(3);
}

getNextDropLocationIndex(previousIndex) {
  nextIndex = previousIndex + 1;

  if(nextIndex == level.hordeDropLocations.size)
    return 0;

  return nextIndex;
}

monitorSupportDropProgress() {
  barSize = getSupportBarSize();

  while(true) {
    level waittill_any("pointsEarned", "host_migration_end");

    if(level.currentPointTotal >= barSize) {
      level notify("airSupport");

      level.currentPointTotal -= barSize;
      barSize = getSupportBarSize();
    }

    SetOmnvar("ui_horde_support_drop_progress", int(level.currentPointTotal / barSize * 100));
  }
}

getSupportBarSize() {
  enemyCount = getMaxEnemyCount(level.currentRoundNumber);

  scalar = int(level.currentRoundNumber / 4);
  averageScorePerKill = CONST_AVG_SCORE_PER_KILL + (scalar * 15);

  return enemyCount * averageScorePerKill;
}

activatePlayerHUD(player) {
  levelendon("game_ended");
  player endon("disconnect");

  player waittill("spawned_player");

  waitframe();

  baseWeaponNames = GetArrayKeys(player.weaponState);

  foreach(baseWeaponName in baseWeaponNames)
  player.weaponState[baseWeaponName]["barSize"] = getWeaponBarSize(1, baseWeaponName);

  player SetClientOmnvar("ui_horde_weapon_progress", 0);
  player SetClientOmnvar("ui_horde_weapon_level", 1);

  roundNumber = int(max(level.currentRoundNumber, 1));
  SetOmnvar("ui_horde_round_number", roundNumber);

  self thread watchForHostMigrationSetRound();

  if(CONST_GIVE_ALL_PERKS) {
    while(!isDefined(level.scriptPerks)) {
      waitframe();
    }

    wait(0.5);

    foreach(perk, icon in level.hordeIcon) {
      if(!string_starts_with(perk, "specialty") && !string_starts_with(perk, "_specialty")) {
        continue;
      }
      player givePerk(perk, false);

      perkTableIndex = TableLookup("mp/hordeIcons.csv", 1, perk, 0);
      player SetClientOmnvar("ui_horde_update_perk", int(perkTableIndex));

      numPerks = player.horde_perks.size;
      player.horde_perks[numPerks]["name"] = perk;
      player.horde_perks[numPerks]["index"] = int(perkTableIndex);

      wait(0.5);
    }
  }

}

watchForHostMigrationSetRound() {
  level endon("game_ended");

  for(;;) {
    level waittill("host_migration_end");
    roundNumber = int(max(level.currentRoundNumber, 1));
    SetOmnvar("ui_horde_round_number", roundNumber);

    foreach(player in level.players) {
      if(isAI(player)) {
        continue;
      }
      if(!isDefined(player)) {
        continue;
      }
      weaponName = getPlayerWeaponHorde(player);
      baseweaponName = GetWeaponBaseName(weaponName);
      barSize = player.weaponState[baseweaponName]["barSize"];

      player SetClientOmnvar("ui_horde_weapon_progress", int(player.weaponState[baseweaponName]["vaule"] / barSize * 100));
      player SetClientOmnvar("ui_horde_weapon_level", player.weaponState[baseweaponName]["level"]);
      if(!isDefined(player.horde_perks)) {
        continue;
      }
      if(!player.horde_perks.size) {
        continue;
      }
      numPerks = player.horde_perks.size;

      for(i = 0; i < numPerks; i++) {
        if(!isDefined(player)) {
          continue;
        }
        player SetClientOmnvar("ui_horde_update_perk", player.horde_perks[i]["index"]);
        wait(0.05);
      }
    }
  }
}

monitorWeaponProgress(player) {
  levelendon("game_ended");
  player endon("disconnect");

  waitUntilMatchStart();

  awardHordWeaponLevel(player, 1);

  while(true) {
    player waittill_any("weaponPointsEarned", "weapon_change");

    weaponName = getPlayerWeaponHorde(player);
    baseweaponName = GetWeaponBaseName(weaponName);

    if(!hasWeaponState(player, baseweaponName)) {
      continue;
    }
    barSize = player.weaponState[baseweaponName]["barSize"];

    if(player.weaponState[baseweaponName]["vaule"] >= barSize) {
      player playLocalSound("mp_safe_weapon_up");
      playFX(level._effect["weapon_level"], player.origin + (0, 0, getWeaponFXHeight(player)));
      level thread updateWeaponCamo(player, baseweaponName, weaponName);

      player.weaponState[baseweaponName]["level"]++;
      player.weaponState[baseweaponName]["vaule"] -= barSize;

      if(player.maxWeaponLevel < player.weaponState[baseweaponName]["level"]) {
        player.maxWeaponLevel = player.weaponState[baseweaponName]["level"];
        awardHordWeaponLevel(player, player.maxWeaponLevel);
      }

      player thread maps\mp\gametypes\_hud_message::SplashNotify("horde_weapon_level");
      player.weaponState[baseweaponName]["barSize"] = getWeaponBarSize(player.weaponState[baseweaponName]["level"], baseWeaponName);
    }

    player SetClientOmnvar("ui_horde_weapon_progress", int(player.weaponState[baseweaponName]["vaule"] / barSize * 100));
    player SetClientOmnvar("ui_horde_weapon_level", player.weaponState[baseweaponName]["level"]);
  }
}

updateWeaponCamo(player, baseweaponName, weaponName) {
  if(!allowCamo(baseweaponName)) {
    return;
  }
  level endon("game_ended");
  player endon("death");
  player endon("disconnect");
  player notify("camo_update");
  player endon("camo_update");

  currentClip = player GetWeaponAmmoClip(weaponName);
  currentStock = player GetWeaponAmmoStock(weaponName);

  player SetWeaponModelVariant(weaponName, getCamoIndex(player.weaponState[baseweaponName]["level"]));
}

allowCamo(baseweaponName) {
  if(!level.allowCamoSwap)
    return false;

  switch (baseweaponName) {
    case "iw6_mts255_mp":
    case "iw6_fp6_mp":
    case "iw6_vepr_mp":
    case "iw6_microtar_mp":
    case "iw6_ak12_mp":
    case "iw6_arx160_mp":
    case "iw6_m27_mp":
    case "iw6_kac_mp":
    case "iw6_usr_mp":
      return true;
    default:
      return false;
  }
}

getCamoIndex(weaponLevel) {
  camoIndex = 0;
  MODEL_VARIANT_COLUMN = 4;

  switch (weaponLevel) {
    case 0:
    case 1:
      camoIndex = 0;
      break;
    case 2:
      camoIndex = 1;
      break;
    case 3:
      camoIndex = 2;
      break;
    case 4:
      camoIndex = 3;
      break;
    case 5:
      camoIndex = 4;
      break;
    case 6:
    case 7:
      camoIndex = 5;
      break;
    case 8:
    case 9:
      camoIndex = 6;
      break;
    case 10:
    case 11:
      camoIndex = 7;
      break;
    case 12:
    case 13:
      camoIndex = 8;
      break;
    case 14:
    case 15:
      camoIndex = 9;
      break;
    case 16:
    case 17:
      camoIndex = 10;
      break;
    case 18:
    case 19:
      camoIndex = 11;
      break;
    case 20:
    case 21:
      camoIndex = 12;
      break;
    case 22:
    case 23:
    default:
      camoIndex = 13;
      break;
  }

  value = TableLookup("mp/camotable.csv", 0, camoIndex, MODEL_VARIANT_COLUMN);

  return int(value);
}

getWeaponFXHeight(player) {
  stance = player GetStance();

  if(stance == "stand") {
    return 48;
  }

  if(stance == "crouch") {
    return 32;
  }

  return 12;
}

getWeaponBarSize(weaponLevel, baseWeaponName) {
  AssertEx(weaponLevel > 0, "weapon level must be greater than 1");

  isSniper = (weaponClass(baseWeaponName) == "sniper");
  enemyCount = getMaxEnemyCount(weaponLevel);
  barSize = (enemyCount * 0.8 * CONST_AVG_SCORE_PER_KILL);

  if(isSniper)
    barSize = barSize / 2.5;

  return barSize;
}

displayIncomingAirDropMessage() {
  foreach(player in level.players) {
    if(!isOnHumanTeam(player)) {
      continue;
    }
    if(player.sessionstate == "spectator") {
      continue;
    }
    player playLocalSound("mp_safe_air_support");
    player thread maps\mp\gametypes\_hud_message::SplashNotify("horde_support_drop");
  }
}

callAirSupport(dropLocation) {
  playFX(level._effect["dropLocation"], dropLocation + (0, 0, 2));

  dropType = "one";

  switch (level.currentRoundNumber) {
    case 1:
    case 2:
    case 3:
      dropType = "a";
      break;
    case 4:
    case 5:
    case 6:
      dropType = "b";
      break;
    case 7:
    case 8:
    case 9:
      dropType = "c";
      break;
    case 10:
    case 11:
    case 12:
      dropType = "d";
      break;
    default:
      dropType = "e";
  }

  bestOwner = level.players[0];

  foreach(player in level.players) {
    if(!isReallyAlive(player)) {
      continue;
    }
    if(isPlayerInLastStand(player)) {
      continue;
    }
    bestOwner = player;
    break;
  }

  if((currentActiveVehicleCount() > maxVehiclesAllowed()) || ((level.fauxVehicleCount + 1) > maxVehiclesAllowed())) {
    return;
  }
  incrementFauxVehicleCount();
  level thread maps\mp\killstreaks\_airdrop::doFlyBy(bestOwner, dropLocation, RandomFloat(360), dropType);
}

initSpawns() {
  level.spawnMins = (0, 0, 0);
  level.spawnMaxs = (0, 0, 0);

  maps\mp\gametypes\_spawnlogic::addStartSpawnPoints("mp_tdm_spawn_allies_start");
  maps\mp\gametypes\_spawnlogic::addStartSpawnPoints("mp_tdm_spawn_axis_start");
  maps\mp\gametypes\_spawnlogic::addSpawnPoints("allies", "mp_tdm_spawn");
  maps\mp\gametypes\_spawnlogic::addSpawnPoints("axis", "mp_tdm_spawn");

  level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter(level.spawnMins, level.spawnMaxs);
  setMapCenter(level.mapCenter);
}

getSpawnPoint() {
  if(self.gameModefirstSpawn && IsPlayer(self)) {
    self maps\mp\gametypes\_menus::addToTeam(level.playerTeam, true);
  }

  spawnteam = self.team;

  if(isOnHumanTeam(self)) {
    spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints(spawnteam);

    if(level.inGracePeriod) {
      spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnPoints);
    } else {
      spawnPoint = maps\mp\gametypes\_spawnscoring::getSpawnpoint_NearTeam(spawnPoints);
    }

    return spawnPoint;
  }

  spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints(spawnteam);
  spawnPoint = maps\mp\gametypes\_spawnscoring::getSpawnpoint_Safeguard(spawnPoints);

  return spawnPoint;
}

getAgentDamageScalar() {
  agentDamageScaler = 0.25;
  numPlayers = getNumPlayers();

  switch (numPlayers) {
    case 0:
      agentDamageScaler = CONST_PLAYER_DAMAGE_SCALE - 0.035;
      break;
    case 1:
      agentDamageScaler = CONST_PLAYER_DAMAGE_SCALE - 0.035;
      break;
    case 2:
      agentDamageScaler = CONST_PLAYER_DAMAGE_SCALE - 0.025;
      break;
    case 3:
      agentDamageScaler = CONST_PLAYER_DAMAGE_SCALE;
      break;
    case 4:
    default:
      agentDamageScaler = CONST_PLAYER_DAMAGE_SCALE;
      break;
  }

  return agentDamageScaler;
}

modifyPlayerDamageHorde(victim, eAttacker, iDamage, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc) {
  if(!isDefined(victim))
    return 0;

  if(isDefined(eAttacker) && isDefined(eAttacker.team) && (eAttacker.team == victim.team))
    return 0;

  if(isDefined(eAttacker) && IsPlayer(eAttacker)) {
    if((victim == eAttacker) && isKillstreakWeapon(sWeapon))
      iDamage = 0;

    baseWeaponName = GetWeaponBaseName(sWeapon);

    if(hasWeaponState(eAttacker, baseWeaponName)) {
      iDamage = int(iDamage + (iDamage * CONST_WEAPON_LEVEL_INCREASE * (eAttacker.weaponState[baseWeaponName]["level"] - 1)));
    }

    if((victim.team == level.enemyTeam) && (eAttacker.team == level.playerTeam)) {
      if(sMeansOfDeath == "MOD_MELEE") {
        iDamage = victim.maxhealth + 1;

        if(victim.horde_type == "Blaster")
          iDamage = Int(victim.maxhealth * 0.70);
      }

      if(isKillstreakWeapon(sWeapon))
        iDamage = int(iDamage + (CONST_ENEMY_HEALTH_INCREASE * level.currentRoundNumber));

      if(isDefined(level.killstreakWeildWeapons[sWeapon]) && (level.killstreakWeildWeapons[sWeapon] == "heli_sniper"))
        iDamage = Int(victim.maxhealth) + 1;

      if(maps\mp\gametypes\_class::isValidEquipment(sWeapon, false)) {
        if(IsExplosiveDamageMOD(sMeansOfDeath))
          iDamage = Int(victim.maxhealth) + 1;

        if(sWeapon == "throwingknife_mp") {
          iDamage = victim.maxhealth + 1;

          if(victim.horde_type == "Blaster")
            iDamage = Int(victim.maxhealth * 0.70);
        }
      }

      eAttacker givePointsForDamage(victim, iDamage, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, false);
    }
  }

  if(isDefined(eAttacker) && isDefined(eAttacker.owner) && IsPlayer(eAttacker.owner)) {
    bIsAgent = false;

    if(isKillstreakWeapon(sWeapon))
      iDamage = int(iDamage + (CONST_ENEMY_HEALTH_INCREASE * level.currentRoundNumber));

    if(IsAgent(eAttacker)) {
      iDamage = int(iDamage + (iDamage * CONST_WEAPON_LEVEL_INCREASE * (level.currentRoundNumber - 2)));
      bIsAgent = true;
    }

    eAttacker.owner givePointsForDamage(victim, iDamage, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, bIsAgent);
  }

  if(IsPlayer(victim) || isOnHumanTeam(victim)) {
    if(isPlayerInLastStand(victim) && !(victim touchingBadTrigger()))
      return 0;

    if(isDefined(victim.OnHeliSniper) && victim.OnHeliSniper)
      return 0;

    if(sWeapon == "semtexproj_mp")
      iDamage = iDamage * 3;

    if(IsPlayer(victim)) {
      iDamage = int(iDamage * CONST_PLAYER_DAMAGE_SCALE);
    } else {
      iDamage = int(iDamage * getAgentDamageScalar());
    }

    if(isDefined(eAttacker) && IsAgent(eAttacker)) {
      eAttacker HudOutlineEnable(level.enemyOutlineColor, false);
      eAttacker.outlineColor = level.enemyOutlineColor;

      if(sMeansOfDeath == "MOD_MELEE")
        iDamage = Int(victim.maxhealth / 2) + 1;

      if(eAttacker.agent_type == "dog")
        iDamage = Int(victim.maxhealth / 4) + 1;
    }

    if(isDefined(victim.isReviving) && victim.isReviving) {
      if(IsAgent(victim))
        iDamage = 0;

      if(IsPlayer(victim))
        iDamage = int(iDamage * 0.9);
    }

    if((victim isUsingRemote()) && (victim getRemoteName() == "remotemissile"))
      iDamage = int(iDamage * 0.9);
  }

  return iDamage;
}

givePointsForDamage(victim, iDamage, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, bIsAgent) {
  isHeadshot = isHeadShot(sWeapon, sHitLoc, sMeansOfDeath, self);
  isMelee = (sMeansOfDeath == "MOD_MELEE" || sMeansOfDeath == "MOD_IMPACT");
  isKillshot = (iDamage >= victim.health);

  if(isMelee && (sHitLoc == "shield")) {
    return;
  }
  eventName = undefined;

  if(isKillshot) {
    if(isMelee)
      eventName = "kill_melee";
    else if(isHeadshot)
      eventName = "kill_head";
    else
      eventName = "kill_normal";

    self notify("horde_kill", victim, sWeapon, sMeansOfDeath);
  } else {
    if(isHeadshot)
      eventName = "damage_head";
    else
      eventName = "damage_body";
  }

  self givePointsForEvent(eventName, sWeapon, bIsAgent);
}

givePointsForEvent(eventName, sWeapon, bIsAgent) {
  pointsToAdd = level.pointEvents[eventName];
  self.pointNotifyLUA[self.pointNotifyLUA.size] = pointsToAdd;

  self maps\mp\gametypes\_gamescore::givePlayerScore(eventName, self, undefined, true, true, true);
  self thread maps\mp\gametypes\_rank::giveRankXP(eventName);

  level.currentPointTotal += pointsToAdd;
  level notify("pointsEarned");

  if(bIsAgent) {
    return;
  }
  baseWeaponName = GetWeaponBaseName(sWeapon);

  if(hasWeaponState(self, baseWeaponName)) {
    self.weaponState[baseWeaponName]["vaule"] += pointsToAdd;
    self notify("weaponPointsEarned");
  }
}

monitorPointNotifyLUA(player) {
  levelendon("game_ended");
  player endon("disconnect");

  while(true) {
    if(player.pointNotifyLUA.size > 0) {
      player SetClientOmnvar("ui_horde_award_points", player.pointNotifyLUA[player.pointNotifyLUA.size - 1]);
      player.pointNotifyLUA = removeLastElement(player.pointNotifyLUA);
    }
    wait(0.05);
  }
}

removeLastElement(oldArray) {
  newArray = [];

  for(i = 0; i < (oldArray.size - 1); i++) {
    newArray[i] = oldArray[i];
  }

  return newArray;
}

onNormalDeath(victim, attacker, lifeId) {
  removePerkHUD(victim);

  if(!isDefined(attacker)) {
    return;
  }
  if(game["state"] == "postgame" && game["teamScores"][attacker.team] > game["teamScores"][level.otherTeam[attacker.team]])
    attacker.finalKill = true;
}

removePerkHUD(player) {
  if(IsPlayer(player)) {
    player SetClientOmnvar("ui_horde_update_perk", 0);
    player.horde_perks = [];
  }
}

chanceToSpawnPickup(victim) {
  if(level.currentPickupCount == level.maxPickupsPerRound) {
    return;
  }
  level endon("game_ended");

  chanceToSpawn = RandomIntRange(1, 101);

  if(chanceToSpawn > level.percentChanceToDrop) {
    return;
  }

  pickupModel = level.weaponPickupModel;
  pickupFunc = level.weaponPickupFunc;

  if((level.currentAmmoPickupCount < level.maxAmmoPickupsPerRound) && cointoss()) {
    pickupModel = level.ammoPickupModel;
    pickupFunc = level.ammoPickupFunc;
    level.currentAmmoPickupCount++;
  }

  spawnPickup(victim.origin + (0, 0, 14), pickupModel, pickupFunc);
}

spawnPickup(location, pickupModel, pickupFunc) {
  visuals[0] = spawn("script_model", (0, 0, 0));
  visuals[0] setModel(pickupModel);

  visuals[0] HudOutlineEnable(1, false);

  trigger = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
  pickup = maps\mp\gametypes\_gameobjects::createUseObject(level.playerTeam, trigger, visuals, (0, 0, 16));

  _objective_delete(pickup.teamObjIds["allies"]);
  _objective_delete(pickup.teamObjIds["axis"]);
  maps\mp\gametypes\_objpoints::deleteObjPoint(pickup.objPoints["allies"]);
  maps\mp\gametypes\_objpoints::deleteObjPoint(pickup.objPoints["axis"]);

  dropLocation = location;
  pickup.curOrigin = dropLocation;
  pickup.trigger.origin = dropLocation;
  pickup.visuals[0].origin = dropLocation;

  pickup maps\mp\gametypes\_gameobjects::setUseTime(0);
  pickup maps\mp\gametypes\_gameobjects::allowUse("friendly");
  pickup.onUse = pickupFunc;

  level.currentPickupCount++;
  pickup thread pickupBounce();
  pickup thread pickupTimer();
}

pickupBounce() {
  level endon("game_ended");
  self endon("deleted");
  self endon("death");

  pickUpModel = self;
  bottomPos = self.curOrigin;
  topPos = self.curOrigin + (0, 0, 12);
  time = 1.25;

  if(isDefined(self.visuals) && isDefined(self.visuals[0]))
    pickUpModel = self.visuals[0];

  while(true) {
    pickUpModel moveTo(topPos, time, 0.15, 0.15);
    pickUpModel rotateYaw(180, time);

    wait(time);

    pickUpModel moveTo(bottomPos, time, 0.15, 0.15);
    pickUpModel rotateYaw(180, time);

    wait(time);
  }
}

pickupTimer() {
  self endon("deleted");

  if(CONST_FORCE_PICKUP_DROP) {
    return;
  }
  wait(15);
  self thread pickupStartFlashing();
  wait(8);
  level thread removePickup(self);
}

pickupStartFlashing() {
  self endon("deleted");

  while(true) {
    self.visuals[0] hide();
    wait(0.25);
    self.visuals[0] show();
    wait(0.25);
  }
}

removePickup(pickup) {
  pickup notify("deleted");
  wait(0.05);
  pickup.trigger delete();
  pickup.visuals[0] delete();
}

weaponPickup(player) {
  if(!IsPlayer(player)) {
    return;
  }
  weaponName = getPlayerWeaponHorde(player);
  baseWeaponName = GetWeaponBaseName(weaponName);

  if(hasWeaponState(player, baseWeaponName)) {
    barSize = player.weaponState[baseWeaponName]["barSize"];
    player.weaponState[baseWeaponName]["vaule"] = barSize;
    player notify("weaponPointsEarned");
  }

  level thread removePickup(self);
}

ammoPickup(player) {
  foreach(teamMate in level.players) {
    if(isOnHumanTeam(teamMate) && isReallyAlive(teamMate)) {
      teamMate thread maps\mp\gametypes\_hud_message::SplashNotify("horde_team_restock");
      refillAmmoHorde(teamMate);
      teamMate.health = teamMate.maxHealth;
    }
  }

  player playLocalSound("mp_safe_team_ammo");
  playFX(level._effect["weapon_level"], player.origin + (0, 0, getWeaponFXHeight(player)));

  level thread removePickup(self);
}

hordeMayDropWeapon(weaponName) {
  if(weaponName == level.playerStartWeaponName)
    return false;

  return true;
}

dropWeaponForDeathHorde(attacker, sMeansOfDeath) {
  dropWeaponName = getPlayerWeaponHorde(self);

  if(dropWeaponName == level.intelMiniGun)
    dropWeaponName = self maps\mp\killstreaks\_killstreaks::getFirstPrimaryWeapon();

  if(!hordeMayDropWeapon(dropWeaponName)) {
    return;
  }
  offset = (0, 0, 18);
  item = spawn("script_model", self.origin + offset);
  item hide();
  item setModel("mp_weapon_crate");
  item.owner = self;
  item.curOrigin = self.origin + offset;
  item.trackingWeaponName = dropWeaponName;
  item HudOutlineEnable(1, false);
  item.trigger = spawn("trigger_radius", self.origin + offset, 0, 32, 32);

  foreach(player in level.players) {
    if(item.owner == player)
      item ShowToPlayer(item.owner);
  }

  item thread pickupBounce();
  item thread watchWeaponPickUpHorde();
  item thread removeWeaponPickUpHorde();
}

watchWeaponPickUpHorde() {
  self endon("death");

  while(true) {
    self.trigger waittill("trigger", player);

    if(player == self.owner) {
      break;
    }
  }

  tryGiveHordeWeapon(player, self.trackingWeaponName);
  player thread maps\mp\gametypes\_hud_message::SplashNotify("horde_recycle");

  player playLocalSound("mp_safe_weapon_up");
  playFX(level._effect["weapon_level"], player.origin + (0, 0, getWeaponFXHeight(player)));

  self.trigger delete();
  self delete();
}

removeWeaponPickUpHorde() {
  self endon("death");
  level endon("game_ended");

  self.owner waittill_any("started_spawnPlayer", "disconnect");

  wait(22);
  self thread startWeaponPickUpFlashing();
  wait(8);

  if(!isDefined(self)) {
    return;
  }
  self.trigger delete();
  self delete();
}

startWeaponPickUpFlashing() {
  self endon("trigger");
  self endon("death");
  level endon("game_ended");

  while(true) {
    self hide();
    wait(0.25);
    self ShowToPlayer(self.owner);
    wait(0.25);
  }
}

onDeadEvent(team) {
  if(!CONST_GAME_END_ON_DEATH) {
    return;
  }
  if(team != level.enemyTeam) {
    iPrintLn(&"MP_GHOSTS_ELIMINATED");

    logString("team eliminated, win: opfor, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);

    level.finalKillCam_winner = "axis";
    level thread maps\mp\gametypes\_gamelogic::endGame("axis", game["end_reason"]["allies_eliminated"]);
  }
}

setSpecialLoadouts() {
  level.hordeLoadouts[CONST_PLAYER_TEAM]["loadoutPrimary"] = "none";
  level.hordeLoadouts[CONST_PLAYER_TEAM]["loadoutPrimaryAttachment"] = "none";
  level.hordeLoadouts[CONST_PLAYER_TEAM]["loadoutPrimaryAttachment2"] = "none";
  level.hordeLoadouts[CONST_PLAYER_TEAM]["loadoutPrimaryBuff"] = "specialty_null";
  level.hordeLoadouts[CONST_PLAYER_TEAM]["loadoutPrimaryCamo"] = "none";
  level.hordeLoadouts[CONST_PLAYER_TEAM]["loadoutPrimaryReticle"] = "none";
  level.hordeLoadouts[CONST_PLAYER_TEAM]["loadoutSecondary"] = CONST_PLAYER_START_WEAPON;
  level.hordeLoadouts[CONST_PLAYER_TEAM]["loadoutSecondaryAttachment"] = CONST_PLAYER_ATTACHMENT;
  level.hordeLoadouts[CONST_PLAYER_TEAM]["loadoutSecondaryAttachment2"] = "none";
  level.hordeLoadouts[CONST_PLAYER_TEAM]["loadoutSecondaryBuff"] = "specialty_null";
  level.hordeLoadouts[CONST_PLAYER_TEAM]["loadoutSecondaryCamo"] = "none";
  level.hordeLoadouts[CONST_PLAYER_TEAM]["loadoutSecondaryReticle"] = "none";
  level.hordeLoadouts[CONST_PLAYER_TEAM]["loadoutEquipment"] = CONST_PLAYER_START_LETHAL;
  level.hordeLoadouts[CONST_PLAYER_TEAM]["loadoutOffhand"] = CONST_PLAYER_START_TACTICAL;
  level.hordeLoadouts[CONST_PLAYER_TEAM]["loadoutStreakType"] = "assault";
  level.hordeLoadouts[CONST_PLAYER_TEAM]["loadoutKillstreak1"] = "none";
  level.hordeLoadouts[CONST_PLAYER_TEAM]["loadoutKillstreak2"] = "none";
  level.hordeLoadouts[CONST_PLAYER_TEAM]["loadoutKillstreak3"] = "none";
  level.hordeLoadouts[CONST_PLAYER_TEAM]["loadoutJuggernaut"] = false;
  level.hordeLoadouts[CONST_PLAYER_TEAM]["loadoutPerks"] = ["specialty_falldamage"];

  level.hordeLoadouts["squadmate"]["loadoutPrimary"] = "iw6_ak12";
  level.hordeLoadouts["squadmate"]["loadoutPrimaryAttachment"] = "none";
  level.hordeLoadouts["squadmate"]["loadoutPrimaryAttachment2"] = "none";
  level.hordeLoadouts["squadmate"]["loadoutPrimaryBuff"] = "specialty_null";
  level.hordeLoadouts["squadmate"]["loadoutPrimaryCamo"] = "none";
  level.hordeLoadouts["squadmate"]["loadoutPrimaryReticle"] = "none";
  level.hordeLoadouts["squadmate"]["loadoutSecondary"] = "none";
  level.hordeLoadouts["squadmate"]["loadoutSecondaryAttachment"] = "none";
  level.hordeLoadouts["squadmate"]["loadoutSecondaryAttachment2"] = "none";
  level.hordeLoadouts["squadmate"]["loadoutSecondaryBuff"] = "specialty_null";
  level.hordeLoadouts["squadmate"]["loadoutSecondaryCamo"] = "none";
  level.hordeLoadouts["squadmate"]["loadoutSecondaryReticle"] = "none";
  level.hordeLoadouts["squadmate"]["loadoutEquipment"] = CONST_PLAYER_START_LETHAL;
  level.hordeLoadouts["squadmate"]["loadoutOffhand"] = CONST_PLAYER_START_TACTICAL;
  level.hordeLoadouts["squadmate"]["loadoutStreakType"] = "assault";
  level.hordeLoadouts["squadmate"]["loadoutKillstreak1"] = "none";
  level.hordeLoadouts["squadmate"]["loadoutKillstreak2"] = "none";
  level.hordeLoadouts["squadmate"]["loadoutKillstreak3"] = "none";
  level.hordeLoadouts["squadmate"]["loadoutJuggernaut"] = false;
  level.hordeLoadouts["squadmate"]["loadoutPerks"] = ["specialty_falldamage"];

  level.hordeLoadouts[CONST_ENEMY_TEAM]["a"]["loadoutPrimary"] = "iw6_maul";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["a"]["loadoutPrimaryAttachment"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["a"]["loadoutPrimaryAttachment2"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["a"]["loadoutPrimaryBuff"] = "specialty_null";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["a"]["loadoutPrimaryCamo"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["a"]["loadoutPrimaryReticle"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["a"]["loadoutSecondary"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["a"]["loadoutSecondaryAttachment"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["a"]["loadoutSecondaryAttachment2"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["a"]["loadoutSecondaryBuff"] = "specialty_null";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["a"]["loadoutSecondaryCamo"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["a"]["loadoutSecondaryReticle"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["a"]["loadoutEquipment"] = "specialty_null";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["a"]["loadoutOffhand"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["a"]["loadoutStreakType"] = "assault";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["a"]["loadoutKillstreak1"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["a"]["loadoutKillstreak2"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["a"]["loadoutKillstreak3"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["a"]["loadoutJuggernaut"] = false;
  level.hordeLoadouts[CONST_ENEMY_TEAM]["a"]["name_localized"] = & "HORDE_RAVAGER";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["a"]["type"] = "Ravager";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["a"]["loadoutPerks"] = ["specialty_falldamage"];

  level.hordeLoadouts[CONST_ENEMY_TEAM]["b"]["loadoutPrimary"] = "iw6_vepr";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["b"]["loadoutPrimaryAttachment"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["b"]["loadoutPrimaryAttachment2"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["b"]["loadoutPrimaryBuff"] = "specialty_null";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["b"]["loadoutPrimaryCamo"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["b"]["loadoutPrimaryReticle"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["b"]["loadoutSecondary"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["b"]["loadoutSecondaryAttachment"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["b"]["loadoutSecondaryAttachment2"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["b"]["loadoutSecondaryBuff"] = "specialty_null";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["b"]["loadoutSecondaryCamo"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["b"]["loadoutSecondaryReticle"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["b"]["loadoutEquipment"] = "specialty_null";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["b"]["loadoutOffhand"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["b"]["loadoutStreakType"] = "assault";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["b"]["loadoutKillstreak1"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["b"]["loadoutKillstreak2"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["b"]["loadoutKillstreak3"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["b"]["loadoutJuggernaut"] = false;
  level.hordeLoadouts[CONST_ENEMY_TEAM]["b"]["name_localized"] = & "HORDE_ENFORCER";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["b"]["type"] = "Enforcer";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["b"]["loadoutPerks"] = ["specialty_falldamage"];

  level.hordeLoadouts[CONST_ENEMY_TEAM]["c"]["loadoutPrimary"] = "iw6_riotshield";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["c"]["loadoutPrimaryAttachment"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["c"]["loadoutPrimaryAttachment2"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["c"]["loadoutPrimaryBuff"] = "specialty_null";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["c"]["loadoutPrimaryCamo"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["c"]["loadoutPrimaryReticle"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["c"]["loadoutSecondary"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["c"]["loadoutSecondaryAttachment"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["c"]["loadoutSecondaryAttachment2"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["c"]["loadoutSecondaryBuff"] = "specialty_null";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["c"]["loadoutSecondaryCamo"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["c"]["loadoutSecondaryReticle"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["c"]["loadoutEquipment"] = "specialty_null";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["c"]["loadoutOffhand"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["c"]["loadoutStreakType"] = "assault";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["c"]["loadoutKillstreak1"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["c"]["loadoutKillstreak2"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["c"]["loadoutKillstreak3"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["c"]["loadoutJuggernaut"] = false;
  level.hordeLoadouts[CONST_ENEMY_TEAM]["c"]["name_localized"] = & "HORDE_STRIKER";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["c"]["type"] = "Striker";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["c"]["loadoutPerks"] = ["specialty_falldamage"];

  level.hordeLoadouts[CONST_ENEMY_TEAM]["d"]["loadoutPrimary"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["d"]["loadoutPrimaryAttachment"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["d"]["loadoutPrimaryAttachment2"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["d"]["loadoutPrimaryBuff"] = "specialty_null";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["d"]["loadoutPrimaryCamo"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["d"]["loadoutPrimaryReticle"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["d"]["loadoutSecondary"] = "iw6_mk32horde";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["d"]["loadoutSecondaryAttachment"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["d"]["loadoutSecondaryAttachment2"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["d"]["loadoutSecondaryBuff"] = "specialty_null";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["d"]["loadoutSecondaryCamo"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["d"]["loadoutSecondaryReticle"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["d"]["loadoutEquipment"] = "specialty_null";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["d"]["loadoutOffhand"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["d"]["loadoutStreakType"] = "assault";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["d"]["loadoutKillstreak1"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["d"]["loadoutKillstreak2"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["d"]["loadoutKillstreak3"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["d"]["loadoutJuggernaut"] = false;
  level.hordeLoadouts[CONST_ENEMY_TEAM]["d"]["name_localized"] = & "HORDE_BLASTER";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["d"]["type"] = "Blaster";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["d"]["loadoutPerks"] = ["specialty_falldamage"];

  level.hordeLoadouts[CONST_ENEMY_TEAM]["e"]["loadoutPrimary"] = "iw6_kac";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["e"]["loadoutPrimaryAttachment"] = "flashsuppress";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["e"]["loadoutPrimaryAttachment2"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["e"]["loadoutPrimaryBuff"] = "specialty_null";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["e"]["loadoutPrimaryCamo"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["e"]["loadoutPrimaryReticle"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["e"]["loadoutSecondary"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["e"]["loadoutSecondaryAttachment"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["e"]["loadoutSecondaryAttachment2"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["e"]["loadoutSecondaryBuff"] = "specialty_null";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["e"]["loadoutSecondaryCamo"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["e"]["loadoutSecondaryReticle"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["e"]["loadoutEquipment"] = "specialty_null";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["e"]["loadoutOffhand"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["e"]["loadoutStreakType"] = "assault";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["e"]["loadoutKillstreak1"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["e"]["loadoutKillstreak2"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["e"]["loadoutKillstreak3"] = "none";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["e"]["loadoutJuggernaut"] = false;
  level.hordeLoadouts[CONST_ENEMY_TEAM]["e"]["name_localized"] = & "HORDE_HAMMER";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["e"]["type"] = "Hammer";
  level.hordeLoadouts[CONST_ENEMY_TEAM]["e"]["loadoutPerks"] = ["specialty_falldamage"];
}

getHordeEnemyLoadOut() {
  loadout = level.hordeLoadouts[CONST_ENEMY_TEAM]["a"];

  if(level.currentRoundNumber < 5)
    return loadout;

  if(level.currentRoundNumber < 9) {
    if(cointoss())
      loadout = level.hordeLoadouts[CONST_ENEMY_TEAM]["b"];

    return loadout;
  }

  loadout = level.hordeLoadouts[CONST_ENEMY_TEAM]["b"];

  if(level.currentRoundNumber < 13) {
    if(RandomIntRange(1, 11) < 4)
      loadout = level.hordeLoadouts[CONST_ENEMY_TEAM]["c"];

    return loadout;
  }

  if(level.currentRoundNumber < 16) {
    loadoutChance = RandomIntRange(1, 11);

    if(loadoutChance < 4)
      loadout = level.hordeLoadouts[CONST_ENEMY_TEAM]["d"];

    return loadout;
  }

  if(level.currentRoundNumber < 24) {
    loadoutChance = RandomIntRange(1, 11);

    if(loadoutChance < 3) {
      loadout = level.hordeLoadouts[CONST_ENEMY_TEAM]["c"];
    } else if(loadoutChance < 5) {
      loadout = level.hordeLoadouts[CONST_ENEMY_TEAM]["d"];
    }

    return loadout;
  }

  loadout = level.hordeLoadouts[CONST_ENEMY_TEAM]["e"];

  loadoutChance = RandomIntRange(1, 11);

  if(loadoutChance < 3) {
    loadout = level.hordeLoadouts[CONST_ENEMY_TEAM]["c"];
  } else if(loadoutChance < 4) {
    loadout = level.hordeLoadouts[CONST_ENEMY_TEAM]["d"];
  }

  type_limit_hit = false;
  if(loadout["type"] == "Blaster") {
    num_blasters = 0;
    foreach(part in level.participants) {
      if(IsAI(part) && isDefined(part.horde_type)) {
        if(part.horde_type == loadout["type"]) {
          num_blasters++;
          if(num_blasters >= 4) {
            type_limit_hit = true;
            break;
          }
        }
      }
    }
  }

  if(type_limit_hit) {
    loadout = level.hordeLoadouts[CONST_ENEMY_TEAM]["a"];
    if(cointoss())
      loadout = level.hordeLoadouts[CONST_ENEMY_TEAM]["b"];
  }

  return loadout;
}

skipRound() {
  level notify("skipRound");
  level endon("skipRound");
  level endon("round_ended");

  while(true) {
    SetDevDvar("scr_devKillAgents", 1);
    wait(0.45);
  }
}
# /