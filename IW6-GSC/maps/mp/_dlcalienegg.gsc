/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_dlcalienegg.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

CONST_EGG_ID = "dlcEggStatus";
CONST_ALL_EGG_CHALLENGE = "ch_weekly_1";

init() {
  level.dlcAlienEggs = [];

  level.dlcAlienEggs["mp_boneyard_ns"] = 1 << 0;
  level.dlcAlienEggs["mp_swamp"] = 1 << 1;
  level.dlcAlienEggs["mp_ca_red_river"] = 1 << 2;
  level.dlcAlienEggs["mp_ca_rumble"] = 1 << 3;

  level.dlcAlienEggs["mp_dome_ns"] = 1 << 4;
  level.dlcAlienEggs["mp_battery3"] = 1 << 5;
  level.dlcAlienEggs["mp_ca_impact"] = 1 << 6;
  level.dlcAlienEggs["mp_ca_behemoth"] = 1 << 7;

  level.dlcAlienEggs["mp_dig"] = 1 << 8;
  level.dlcAlienEggs["mp_favela_iw6"] = 1 << 9;
  level.dlcAlienEggs["mp_pirate"] = 1 << 10;
  level.dlcAlienEggs["mp_zulu"] = 1 << 11;

  level.dlcAlienEggs["mp_conflict"] = 1 << 12;
  level.dlcAlienEggs["mp_mine"] = 1 << 13;
  level.dlcAlienEggs["mp_zerosub"] = 1 << 14;
  level.dlcAlienEggs["mp_shipment_ns"] = 1 << 15;

  level.dlcAliengEggMapToPack["mp_boneyard_ns"] = 0;
  level.dlcAliengEggMapToPack["mp_swamp"] = 0;
  level.dlcAliengEggMapToPack["mp_ca_red_river"] = 0;
  level.dlcAliengEggMapToPack["mp_ca_rumble"] = 0;

  level.dlcAliengEggMapToPack["mp_dome_ns"] = 1;
  level.dlcAliengEggMapToPack["mp_battery3"] = 1;
  level.dlcAliengEggMapToPack["mp_ca_impact"] = 1;
  level.dlcAliengEggMapToPack["mp_ca_behemoth"] = 1;

  level.dlcAliengEggMapToPack["mp_dig"] = 2;
  level.dlcAliengEggMapToPack["mp_favela_iw6"] = 2;
  level.dlcAliengEggMapToPack["mp_pirate"] = 2;
  level.dlcAliengEggMapToPack["mp_zulu"] = 2;

  level.dlcAliengEggMapToPack["mp_conflict"] = 3;
  level.dlcAliengEggMapToPack["mp_mine"] = 3;
  level.dlcAliengEggMapToPack["mp_zerosub"] = 3;
  level.dlcAliengEggMapToPack["mp_shipment_ns"] = 3;

  level.bitCounts = [0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4];

  level._effect["vfx_alien_easter_egg_hit"] = loadfx("vfx/gameplay/alien/vfx_alien_easter_egg_hit");
}

setupEggForMap(eggName) {
  if(level.rankedMatch) {
    init();

    flags = level.dlcAlienEggs[getMapName()];

    AssertEx(isDefined(flags), "dlcAlienEggs bit flag not set up for map: " + getMapName());

    egg = GetEnt(eggName, "targetname");
    if(isDefined(egg)) {
      if(egg.classname == "script_model") {
        egg setCanDamage(true);
      }

      egg thread eggTrackHits();
    }

    thread eggDebug();

  }
}

eggTrackHits() {
  level endon("game_ended");
  self.health = 99999;

  level.eggHits = [];

  while(true) {
    self waittill("damage", damage, attacker, direction, point, damageType);

    playFX(getfx("vfx_alien_easter_egg_hit"), point, anglesToForward(direction), AnglesToUp(direction));

    if(IsPlayer(attacker) && !IsAI(attacker)) {
      attackerNum = attacker getUniqueId();

      if(!isDefined(level.eggHits[attackerNum])) {
        level.eggHits[attackerNum] = 1;
        self eggRegisterHit(damage, attacker, direction, point, damageType);
      }
    }
  }

}

eggRegisterHit(damage, attacker, direction, point, type) {
  self.health += damage;

  if(!(attacker eggHasCompletedForMap(getMapName()))) {
    attacker eggSetCompletedForMap(getMapName());
  } else if(attacker eggAllFound() && attacker ch_getState(CONST_ALL_EGG_CHALLENGE) < 2) {
    attacker eggAwardPatch();
  }
}

eggHasCompletedForMap(mapName) {
  eggState = self GetRankedPlayerDataReservedInt(CONST_EGG_ID);

  bitFlag = level.dlcAlienEggs[mapName];
  if(isDefined(bitFlag) && (eggState &bitFlag) != 0) {
    return true;
  }

  return false;
}

eggSetCompletedForMap(mapName) {
  bitFlag = level.dlcAlienEggs[mapName];

  if(isDefined(bitFlag)) {
    eggState = self GetRankedPlayerDataReservedInt(CONST_EGG_ID);

    eggState |= bitFlag;
    self SetRankedPlayerDataReservedInt(CONST_EGG_ID, eggState);

    packNum = level.dlcAliengEggMapToPack[mapName];
    AssertEx(isDefined(packNum), "MapPack ID not defined for " + mapName);

    numCompleted = eggCountCompletedEggsForPack(packNum, eggState);
    packNum++;
    if(numCompleted < 4) {
      self maps\mp\gametypes\_hud_message::playerCardSplashNotify("dlc_eggFound_" + packNum, self, numCompleted);
    } else {
      if(self eggAllFound() && ch_getState(CONST_ALL_EGG_CHALLENGE) < 2) {
        self eggAwardPatch();
      } else {
        self maps\mp\gametypes\_hud_message::playerCardSplashNotify("dlc_eggAllFound_" + packNum, self);
        self thread maps\mp\gametypes\_rank::giveRankXP("dlc_egg_hunt");
      }

    }

    self PlayLocalSound("ui_extinction_egg_splash");
  }
}

eggAwardPatch() {
  self maps\mp\gametypes\_hud_message::playerCardSplashNotify("dlc_eggAllFound", self);
  self thread maps\mp\gametypes\_rank::giveRankXP("dlc_egg_hunt_all");

  ch_setState(CONST_ALL_EGG_CHALLENGE, 2);
}

eggCountCompletedEggsForPack(packNum, eggState) {
  flags = eggState >> (packnum * 4);
  flags &= 15;

  return level.bitCounts[flags];
}

eggAllFoundForPack(packNum) {
  eggState = self GetRankedPlayerDataReservedInt(CONST_EGG_ID);
  packEggState = (eggState >> (packnum * 4)) & 15;

  return (packEggState != 0);
}

CONST_ALL_EGGS_MASK = (1 << 16) - 1;
eggAllFound() {
  eggState = self GetRankedPlayerDataReservedInt(CONST_EGG_ID);

  return (eggState == CONST_ALL_EGGS_MASK);
}

eggDebug() {
  level endon("game_ended");

  level waittill("connected", player);

  player thread eggDebugPlayer();
}

eggDebugPlayer() {
  level endon("game_ended");

  SetDvarIfUninitialized("scr_egg_set", "");
  SetDvarIfUninitialized("scr_egg_pack_set", 0);
  SetDvarIfUninitialized("scr_egg_clear", 0);

  while(true) {
    mapName = GetDvar("scr_egg_set");
    if(mapName != "") {
      self eggSetCompletedForMap(mapName);
      SetDvar("scr_egg_set", "");
    }

    if(GetDvarInt("scr_egg_clear") != 0) {
      self SetRankedPlayerDataReservedInt(CONST_EGG_ID, 0);
      SetDvar("scr_egg_clear", 0);
      level.eggHits = [];

      ch_setState(CONST_ALL_EGG_CHALLENGE, 0);
    }

    targetPackNum = GetDvarInt("scr_egg_pack_set");
    if(targetPackNum > 0) {
      targetPackNum--;

      foreach(mapName, packNum in level.dlcAliengEggMapToPack) {
        if(packNum == targetPackNum && !(self eggHasCompletedForMap(mapName))) {
          self eggSetCompletedForMap(mapName);
          wait(3.6);
        }
      }

      SetDvar("scr_egg_pack_set", "");
    }

    wait(0.25);
  }
}
# /