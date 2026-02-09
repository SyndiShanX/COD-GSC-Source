/*****************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_killstreaks_init.gsc
*****************************************************/

#include maps\mp\killstreaks\_killstreaks;
#include maps\mp\_utility;

init() {
  level.KILLSTREAK_STRING_TABLE = "mp/killstreakTable.csv";
  level.KILLSTREAK_GIMME_SLOT = 0;
  level.KILLSTREAK_SLOT_1 = 1;
  level.KILLSTREAK_SLOT_2 = 2;
  level.KILLSTREAK_SLOT_3 = 3;
  level.KILLSTREAK_SLOT_4 = 4;
  level.KILLSTREAK_STACKING_START_SLOT = 5;

  level.KS_MODULES_TABLE = "mp/killstreakModules.csv";
  level.KS_MODULE_REF_COLUMN = 1;
  level.KS_MODULE_NAME_COLUMN = 2;
  level.KS_MODULE_KILLSTREAK_REF_COLUMN = 4;
  level.KS_MODULE_ADDED_POINTS_COLUMN = 5;
  level.KS_MODULE_SLOT_COLUMN = 6;
  level.KS_MODULE_SUPPORT_COLUMN = 7;

  level.killstreakRoundDelay = getIntProperty("scr_game_killstreakdelay", 10);
  level.killstreakFuncs = [];
  level.killstreakSetupFuncs = [];
  level.killstreakWieldWeapons = [];

  initKillstreakData();

  level thread onPlayerConnect();

  if(isDefined(level.isZombieGame) && level.isZombieGame) {
    return;
  }

  level thread maps\mp\killstreaks\_aerial_utility::init();
  level thread maps\mp\killstreaks\_coop_util::init();

  if(isDefined(level.mapCustomKillstreakFunc)) {
    [[level.mapCustomKillstreakFunc]]();
  }

  level thread maps\mp\killstreaks\_uav::init();
  level thread maps\mp\killstreaks\_airdrop::init();
  level thread maps\mp\killstreaks\_remoteturret::init();
  level thread maps\mp\killstreaks\_rippedturret::init();
  level thread maps\mp\killstreaks\_emp::init();
  level thread maps\mp\killstreaks\_nuke::init();
  level thread maps\mp\killstreaks\_juggernaut::init();
  level thread maps\mp\killstreaks\_orbital_strike::init();
  level thread maps\mp\killstreaks\_missile_strike::init();
  level thread maps\mp\killstreaks\_orbital_carepackage::init();
  level thread maps\mp\killstreaks\_warbird::init();
  level thread maps\mp\killstreaks\_drone_assault::init();
  level thread maps\mp\killstreaks\_drone_recon::init();
  level thread maps\mp\killstreaks\_orbitalsupport::init();
  level thread maps\mp\killstreaks\_airstrike::init();

  level thread maps\mp\killstreaks\_drone_carepackage::init();
  level thread maps\mp\killstreaks\_orbital_util::initStart();
}

initKillstreakData() {
  for(i = 0; true; i++) {
    streakRef = TableLookupByRow(level.KILLSTREAK_STRING_TABLE, i, 1);
    if(!isDefined(streakRef) || streakRef == "") {
      break;
    }

    if(streakRef == "b1" || streakRef == "none") {
      continue;
    }

    streakUseHint = TableLookupIStringByRow(level.KILLSTREAK_STRING_TABLE, i, 5);
    assert(streakUseHint != &"");

    streakEarnDialog = TableLookupByRow(level.KILLSTREAK_STRING_TABLE, i, 7);
    assert(streakEarnDialog != "");
    game["dialog"][streakRef] = streakEarnDialog;

    streakAlliesUseDialog = TableLookupByRow(level.KILLSTREAK_STRING_TABLE, i, 8);
    assert(streakAlliesUseDialog != "");
    game["dialog"]["allies_friendly_" + streakRef + "_inbound"] = "ks_" + streakAlliesUseDialog + "_allyuse";
    game["dialog"]["allies_enemy_" + streakRef + "_inbound"] = "ks_" + streakAlliesUseDialog + "_enemyuse";

    streakAxisUseDialog = TableLookupByRow(level.KILLSTREAK_STRING_TABLE, i, 9);
    assert(streakAxisUseDialog != "");
    game["dialog"]["axis_friendly_" + streakRef + "_inbound"] = "ks_" + streakAxisUseDialog + "_allyuse";
    game["dialog"]["axis_enemy_" + streakRef + "_inbound"] = "ks_" + streakAxisUseDialog + "_enemyuse";

    streakPoints = int(TableLookupByRow(level.KILLSTREAK_STRING_TABLE, i, 12));
    maps\mp\gametypes\_rank::registerXPEventInfo(streakRef + "_earned", streakPoints);
  }

  additionalVO();
}

additionalVO() {
  baseStringAlliesFriendly = "allies_friendly_emp_inbound";
  baseStringAlliesEnemy = "allies_enemy_emp_inbound";
  baseStringAxisFriendly = "axis_friendly_emp_inbound";
  baseStringAxisEnemy = "axis_enemy_emp_inbound";

  for(i = 1; i < 9; i++) {
    appendString = "_0" + i;
    game["dialog"][baseStringAlliesFriendly + appendString] = game["dialog"][baseStringAlliesFriendly] + appendString;
    game["dialog"][baseStringAlliesEnemy + appendString] = game["dialog"][baseStringAlliesEnemy] + appendString;
    game["dialog"][baseStringAxisFriendly + appendString] = game["dialog"][baseStringAxisFriendly] + appendString;
    game["dialog"][baseStringAxisEnemy + appendString] = game["dialog"][baseStringAxisEnemy] + appendString;
  }
}