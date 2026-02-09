/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_intel.gsc
****************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

INTEL_MODEL_NAME = "com_metal_briefcase_intel";
INTEL_ANIM_NAME = "mp_briefcase_spin";

init() {
  level thread populateIntelChallenges();
  level.intelActive = false;

  if(!isDefined(level.supportIntel) || level.supportIntel)
    level thread onPlayerConnect();

  if(isDefined(level.enableTeamIntel) && isDefined(level.enableTeamIntel))
    level thread runTeamIntel();

  SetDevDvarIfUninitialized("scr_devIntelChallengeName", "temp");
  SetDevDvarIfUninitialized("scr_devIntelChallengeNum", -1);
}

populateIntelChallenges() {
  level endon("game_ended");

  wait(0.05);

  level.intelChallengeArray = [];
  checkAvailability = (level.gameType == "sd" || level.gameType == "sr");
  rowIndex = 0;

  while(true) {
    challengeName = TableLookupByRow("mp/intelChallenges.csv", rowIndex, 0);
    challengeReward = int(TableLookupByRow("mp/intelChallenges.csv", rowIndex, 2));
    challengeTarget = int(TableLookupByRow("mp/intelChallenges.csv", rowIndex, 3));
    available = int(TableLookupByRow("mp/intelChallenges.csv", rowIndex, 4)) == 1;
    teamChallenge = int(TableLookupByRow("mp/intelChallenges.csv", rowIndex, 5)) == 1;
    juggChallenge = int(TableLookupByRow("mp/intelChallenges.csv", rowIndex, 6)) == 1;

    rowIndex++;

    if(challengeName == "") {
      break;
    }

    if(checkAvailability && !available) {
      continue;
    }
    level.intelChallengeArray[challengeName] = spawnStruct();

    level.intelChallengeArray[challengeName].challengeName = challengeName;
    level.intelChallengeArray[challengeName].challengeReward = challengeReward;
    level.intelChallengeArray[challengeName].challengeTarget = challengeTarget;
    level.intelChallengeArray[challengeName].teamChallenge = teamChallenge;
    level.intelChallengeArray[challengeName].juggChallenge = juggChallenge;
  }
}

runTeamIntel() {
  level endon("game_ended");

  level.numMeleeKillsIntel = 0;
  level.numHeadShotsIntel = 0;
  level.numKillStreakKillsIntel = 0;
  level.numEquipmentKillsIntel = 0;

  while(true) {
    level waittill("giveTeamIntel", team);

    validChallengesArray = [];

    foreach(challenge in level.intelChallengeArray) {
      if(!challenge.teamChallenge) {
        continue;
      }
      validChallengesArray[validChallengesArray.size] = challenge;
    }

    randChallenge = validChallengesArray[RandomInt(validChallengesArray.size)];
    challengeNameIndex = randChallenge.challengeName;

    devChallengeNum = GetDvarInt("scr_devIntelChallengeNum");
    if(devChallengeNum != -1) {
      randChallenge = validChallengesArray[devChallengeNum];
      challengeNameIndex = randChallenge.challengeName;
    }

    level maps\mp\gametypes\_intelchallenges::giveTeamChallenge(challengeNameIndex, team);
  }
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);

    player thread intelDeathWatcher();
  }
}

intelDeathWatcher(player) {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("death", attacker);

    if(isDefined(self.hasIntel) && self.hasIntel) {
      if((isDefined(self.OnHeliSniper) && self.OnHeliSniper) || self.sessionstate == "spectator") {
        self.hasIntel = false;
        level thread randAssignIntel();
      } else {
        self onDropIntel();
      }
    } else if(!level.intelActive) {
      if(level.teamBased && isDefined(attacker) && isDefined(attacker.team) && attacker.team == self.team) {
        continue;
      }
      level.intelActive = true;
      self onDropIntel(true);
    }
  }
}
CONST_INTEL_TRIG_RADIUS = 96;
CONST_INTEL_TRIG_RADIUS_EXIT = 192;
CONST_INTEL_TRIG_HEIGHT = 60;

onDropIntel(first_drop) {
  self.hasIntel = false;
  if(!isDefined(first_drop))
    first_drop = false;

  pos = self.origin;

  if(isDefined(self.intelDeathPosition)) {
    pos = self.intelDeathPosition;
    self.intelDeathPosition = undefined;
  }

  new_origin = GetGroundPosition(pos, 42, 1000, 72);
  pos_model = pos + (0, 0, 32);

  if(first_drop) {
    intelCase = spawn("script_model", pos_model);
    intelCase.angles = (0, 0, 0);
    intelCase setModel(INTEL_MODEL_NAME);
    intelTrigger = spawn("trigger_radius", pos, 0, CONST_INTEL_TRIG_RADIUS, CONST_INTEL_TRIG_HEIGHT);
    intelTrigger.id = "intel";
    intelEnt = [];
    intelEnt["visuals"] = intelCase;
    intelEnt["trigger"] = intelTrigger;
    intelEnt["owner"] = "none";
    intelEnt["isActive"] = true;
    intelEnt["firstTriggerPlayer"] = undefined;
    intelEnt["useRate"] = 1;
    intelEnt["useTime"] = 0.5;
    intelEnt["useProgress"] = 0;
    intelEnt["dropped_time"] = GetTime();

    level.intelEnt = intelEnt;

    level.intelEnt["trigger"] EnableLinkTo();
  } else {
    if(isDefined(level.intelEnt["visuals"] GetLinkedParent())) {
      level.intelEnt["visuals"] Unlink();
      level.intelEnt["trigger"] Unlink();
    }

    level.intelEnt["visuals"] Hide();
    level.intelEnt["visuals"].origin = pos_model;
    level.intelEnt["trigger"].origin = new_origin;
  }

  if(level.intelEnt["visuals"] touchingBadTrigger()) {
    level.intelEnt["isActive"] = false;
    level.intelEnt["visuals"] Hide();
    level thread randAssignIntel();
    return;
  }

  level.intelEnt["owner"] = "none";
  level.intelEnt["isActive"] = true;
  level.intelEnt["dropped_time"] = GetTime();

  level.intelEnt["visuals"] ScriptModelPlayAnim(INTEL_ANIM_NAME);

  self thread intelTriggerWatcher();

  level.intelEnt thread intelEmergencyRespawnTimer();
}

intelDeathOverride(data) {
  level.intelEnt["isActive"] = false;
  level.intelEnt["visuals"] Hide();
  level thread randAssignIntel();
}

intelTriggerWatcher() {
  level notify("intelTriggerWatcher");
  level endon("intelTriggerWatcher");

  level endon("game_ended");
  level.intelEnt["visuals"] endon("pickedUp");

  intelTrigger = level.intelEnt["trigger"];

  data = spawnStruct();
  data.linkparent = self GetMovingPlatformParent();
  data.endonString = "intelTriggerWatcher";
  data.deathOverrideCallback = ::intelDeathOverride;
  level.intelEnt["visuals"] thread maps\mp\_movers::handle_moving_platforms(data);
  level.intelEnt["trigger"] LinkTo(level.intelEnt["visuals"]);

  wait 0.05;

  level.intelEnt["visuals"] Show();

  for(;;) {
    intelTrigger waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(isAI(player)) {
      continue;
    }
    if(!isAlive(player) || (isDefined(player.fauxDead) && player.fauxDead)) {
      continue;
    }

    if(level.intelEnt["isActive"]) {
      if(isDefined(player.hasIntel) && player.hasIntel) {
        continue;
      }
      result = intelTrigger proximityThink(player);

      if(result)
        player onPickupIntel();
    }
  }
}

intelEmergencyRespawnTimer() {
  level.intelEnt["visuals"] endon("pickedUp");

  for(;;) {
    if(GetTime() > (level.intelEnt["dropped_time"] + 60000)) {
      break;
    }

    wait 1;
  }

  level.intelEnt["isActive"] = false;
  level.intelEnt["visuals"] Hide();

  level thread randAssignIntel();
}

onPickupIntel() {
  self.hasIntel = true;
  level.intelEnt["isActive"] = false;
  level.intelEnt["visuals"] Hide();
  level.intelEnt["owner"] = self;

  validChallengesArray = [];

  self thread maps\mp\gametypes\_rank::giveRankXP("challenge", 100);

  if(self isJuggernaut()) {
    foreach(challenge in level.intelChallengeArray) {
      challengeName = challenge.challengeName;

      if(!challenge.juggChallenge) {
        continue;
      }

      if((isDefined(self.isJuggernautManiac) && self.isJuggernautManiac == true)) {
        if(!IsSubStr(challengeName, "maniac")) {
          continue;
        }
      } else if((isDefined(self.isJuggernautRecon) && self.isJuggernautRecon == true)) {
        if(!IsSubStr(challengeName, "recon")) {
          continue;
        }
      } else {
        if(!IsSubStr(challengeName, "assault")) {
          continue;
        }
      }

      validChallengesArray[validChallengesArray.size] = challenge;
    }
  } else {
    otherTeam = getOtherTeam(self.team);
    numEnemies = level.teamcount[otherTeam];
    otherTeamAliveCount = level.aliveCount[otherteam];
    isInfiniteLives = undefined;
    isInfiniteLives = GetDvarInt("scr_player_lives") == 0;
    weapons = self GetWeaponsListPrimaries();

    foreach(challenge in level.intelChallengeArray) {
      challengeName = challenge.challengeName;
      killsToComplete = challenge.challengeTarget;

      if(!isInfiniteLives) {
        if(challengeName == "ch_intel_tbag" || killsToComplete > otherTeamAliveCount) {
          continue;
        }
      }

      if(challengeName == "ch_intel_secondarykills" && intelCanComplete_secondaryKills(self, weapons) == false) {
        continue;
      }

      if(challengeName == "ch_intel_explosivekill" && intelCanComplete_explosiveKill(self, weapons) == false) {
        continue;
      }

      if(challenge.teamChallenge) {
        continue;
      }

      if(challenge.juggChallenge) {
        continue;
      }

      validChallengesArray[validChallengesArray.size] = challenge;
    }
  }

  randChallenge = validChallengesArray[RandomInt(validChallengesArray.size)];
  challengeNameIndex = randChallenge.challengeName;

  devChallengeName = getDvar("scr_devIntelChallengeName");
  if(devChallengeName != "temp")
    challengeNameIndex = devChallengeName;

  if(self isJuggernaut()) {
    self maps\mp\gametypes\_intelchallenges::giveJuggernautChallenge(challengeNameIndex);
  } else {
    self maps\mp\gametypes\_intelchallenges::giveChallenge(challengeNameIndex);
    self thread watchForJuggernaut();
  }
  self thread watchForPlayerDisconnect();

  self thread watchForRemoteKillstreak();

  level.intelEnt["visuals"] notify("pickedUp");
}

intelCanComplete_secondaryKills(player, weapons) {
  result = false;

  foreach(weapon in weapons) {
    if(isCACSecondaryWeapon(weapon)) {
      if(player GetAmmoCount(weapon) > 0) {
        result = true;
        break;
      }
    }
  }
  return result;
}

intelCanComplete_explosiveKill(player, weapons) {
  result = false;

  if(self.loadoutPerkEquipment != "specialty_null" && !IsSubStr(self.loadoutPerkEquipment, "throwingknife")) {
    offhandAmmoCount = player GetAmmoCount(self.loadoutPerkEquipment);
    if(offhandAmmoCount > 0) {
      result = true;
    }
  }

  if(result == false) {
    foreach(weapon in weapons) {
      weapClass = WeaponClass(weapon);

      if((weapClass == "rocketlauncher" || weapClass == "grenade") && player GetAmmoCount(weapon) > 0) {
        result = true;
        break;
      } else {
        altWeapon = WeaponAltWeaponName(weapon);
        if(isDefined(altWeapon) && WeaponClass(altWeapon) == "grenade" && player GetAmmoCount(altWeapon) > 0) {
          result = true;
          break;
        }
      }
    }
  }
  return result;
}

watchForJuggernaut() {
  self endon("death");
  self endon("intel_cleanup");

  while(1) {
    level waittill("juggernaut_equipped");

    waittillframeend;

    if(self isJuggernaut()) {
      self thread updateJuggIntel();
    }
  }
}

updateJuggIntel() {
  self notify("intel_cleanup");

  self SetClientOmnvar("ui_intel_active_index", -1);
  self onPickupIntel();
}

watchForPlayerDisconnect() {
  self endon("death");
  self endon("intel_cleanup");

  self waittill("disconnect");

  level thread randAssignIntel();
}

watchForRemoteKillstreak() {
  self endon("death");
  self endon("intel_cleanup");
  self endon("stopped_using_remote");

  self waittill("using_remote");

  self.intelDeathPosition = self.origin;

  self thread updateIntelDeathPosition();
}

updateIntelDeathPosition() {
  self endon("death");
  self endon("intel_cleanup");

  self waittill("stopped_using_remote");

  self.intelDeathPosition = undefined;

  self thread WatchForRemoteKillstreak();
}

randAssignIntel() {
  level notify("randAssignIntel");
  level endon("randAssignIntel");
  level endon("game_ended");

  for(;;) {
    wait(1);
    selectedPlayer = getRandomPlayingPlayer();

    if(!isDefined(selectedPlayer)) {
      continue;
    }
    selectedPlayer.hasIntel = true;
    level.intelEnt["owner"] = selectedPlayer;
    selectedPlayer thread watchForPlayerDisconnect();
    break;
  }
}

awardPlayerChallengeComplete(index) {
  self endon("disconnect");

  self replenishAmmo();
  self.hasIntel = false;
  challenge = level.intelChallengeArray[index];
  reference = challenge.challengeName;
  rewardXP = Int(challenge.challengeReward);

  self SetClientOmnvar("ui_intel_active_index", -1);

  self thread maps\mp\killstreaks\_killstreaks::giveKillstreak("airdrop_assault", false, false, self);

  self thread maps\mp\gametypes\_hud_message::SplashNotifyDelayed(reference, rewardXP);
  self thread maps\mp\gametypes\_rank::giveRankXP("intel", rewardXP);

  level thread randAssignIntel();

  self thread[[level.leaderDialogOnPlayer_func]]("achieve_carepackage", undefined, undefined, self.origin);

  self maps\mp\gametypes\_missions::processChallenge("ch_intelligence");

  self notify("intel_cleanup");
}

replenishAmmo() {
  weaponList = self GetWeaponsListAll();
  foreach(weaponName in weaponList) {
    if(isKillstreakWeapon(weaponName)) {
      continue;
    } else if(WeaponInventoryType(weaponName) == "offhand") {
      if((weaponName == self.loadoutPerkEquipment && self _hasPerk("specialty_extra_deadly")) || (weaponName == self.loadoutPerkOffhand && self _hasPerk("specialty_extra_equipment"))) {
        self SetWeaponAmmoClip(weaponName, 2);
      } else {
        self SetWeaponAmmoClip(weaponName, 1);
      }
    } else {
      self GiveMaxAmmo(weaponName);
    }
  }
}

proximityThink(player) {
  if(!isDefined(self))
    return false;

  self.inUse = true;

  result = self proximityThinkLoop(player);

  assert(isDefined(result));

  if(!isDefined(self))
    return false;

  level.intelEnt["useProgress"] = 0;

  return (result);
}

proximityThinkLoop(player) {
  self.useRate = level.intelEnt["useRate"];
  self.useTime = level.intelEnt["useTime"];
  self.curProgress = 0;

  while(!level.gameEnded && isDefined(self) && isReallyAlive(player)) {
    if(Distance2DSquared(self.origin, player.origin) > CONST_INTEL_TRIG_RADIUS_EXIT * CONST_INTEL_TRIG_RADIUS_EXIT) {
      break;
    }

    level.intelEnt["useProgress"] += 0.05 * self.useRate;
    self.curProgress = level.intelEnt["useProgress"];

    player maps\mp\gametypes\_gameobjects::updateUIProgress(self, true);

    if(level.intelEnt["useProgress"] >= self.useTime) {
      player maps\mp\gametypes\_gameobjects::updateUIProgress(self, false);
      return (isReallyAlive(player));
    }

    wait 0.05;
  }

  player maps\mp\gametypes\_gameobjects::updateUIProgress(self, false);
  return false;
}