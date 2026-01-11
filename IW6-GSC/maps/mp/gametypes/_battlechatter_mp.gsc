/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_battlechatter_mp.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

BC_DISTANCE_LIMIT = 3000 * 3000;
CASUALTY_DISTANCE_LIMIT = 512 * 512;
LOCATION_REPEAT_LIMIT = 25 * 1000;
MAX_CALLOUT_DISTSQ_ADS = 2500 * 2500;
MAX_CALLOUT_DISTSQ = 2000 * 2000;
TEAMPLAYER_DISTSQ = 512 * 512;
FRIENDLY_IN_RANGE_DIST = 2200 * 2200;

init() {
  if(level.multiTeamBased) {
    foreach(teamName in level.teamNameList) {
      level.isTeamSpeaking[teamName] = false;
      level.speakers[teamName] = [];
    }
  } else {
    level.isTeamSpeaking["allies"] = false;
    level.isTeamSpeaking["axis"] = false;

    level.speakers["allies"] = [];
    level.speakers["axis"] = [];
  }

  level.bcSounds = [];
  level.bcSounds["reload"] = "inform_reloading_generic";
  level.bcSounds["frag_out"] = "inform_attack_grenade";
  level.bcSounds["flash_out"] = "inform_attack_flashbang";
  level.bcSounds["smoke_out"] = "inform_attack_smoke";
  level.bcSounds["conc_out"] = "inform_attack_stun";
  level.bcSounds["c4_plant"] = "inform_attack_thwc4";
  level.bcSounds["claymore_plant"] = "inform_plant_claymore";
  level.bcSounds["semtex_out"] = "semtex_use";
  level.bcSounds["kill"] = "inform_killfirm_infantry";
  level.bcSounds["casualty"] = "reaction_casualty_generic";
  level.bcSounds["suppressing_fire"] = "cmd_suppressfire";
  level.bcSounds["moving"] = "order_move_combat";
  level.bcSounds["callout_generic"] = "threat_infantry_generic";
  level.bcSounds["callout_response_generic"] = "response_ack_yes";
  level.bcSounds["damage"] = "inform_taking_fire";

  level.bcSounds["semtex_incoming"] = "semtex_incoming";
  level.bcSounds["c4_incoming"] = "c4_incoming";
  level.bcSounds["flash_incoming"] = "flash_incoming";
  level.bcSounds["stun_incoming"] = "stun_incoming";
  level.bcSounds["grenade_incoming"] = "grenade_incoming";
  level.bcSounds["rpg_incoming"] = "rpg_incoming";

  level.bcInfo = [];

  level.bcInfo["timeout"]["suppressing_fire"] = 5 * 1000;
  level.bcInfo["timeout"]["moving"] = 45 * 1000;
  level.bcInfo["timeout"]["callout_generic"] = 15 * 1000;
  level.bcInfo["timeout"]["callout_location"] = 3 * 1000;

  level.bcInfo["timeout_player"]["suppressing_fire"] = 10 * 1000;
  level.bcInfo["timeout_player"]["moving"] = 120 * 1000;
  level.bcInfo["timeout_player"]["callout_generic"] = 5 * 1000;
  level.bcInfo["timeout_player"]["callout_location"] = 5 * 1000;

  foreach(key, value in level.speakers) {
    level.bcInfo["last_say_time"][key]["suppressing_fire"] = -99999;
    level.bcInfo["last_say_time"][key]["moving"] = -99999;
    level.bcInfo["last_say_time"][key]["callout_generic"] = -99999;
    level.bcInfo["last_say_time"][key]["callout_location"] = -99999;

    level.bcInfo["last_say_pos"][key]["suppressing_fire"] = (0, 0, -9000);
    level.bcInfo["last_say_pos"][key]["moving"] = (0, 0, -9000);
    level.bcInfo["last_say_pos"][key]["callout_generic"] = (0, 0, -9000);
    level.bcInfo["last_say_pos"][key]["callout_location"] = (0, 0, -9000);

    level.voice_count[key][""] = 0;
    level.voice_count[key]["w"] = 0;
  }

  common_scripts\_bcs_location_trigs::bcs_location_trigs_init();

  gametype = getdvar("g_gametype");
  level.istactical = true;
  if(gametype == "war" || gametype == "kc" || gametype == "dom") {
    level.istactical = false;
  }

  level thread onPlayerConnect();

  SetDevDvarIfUninitialized("debug_bcprint", "off");
  SetDevDvarIfUninitialized("debug_bcprintdump", "off");
  SetDevDvarIfUninitialized("debug_bcprintdumptype", "csv");
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);

    player thread onPlayerSpawned();
  }
}

onPlayerSpawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");

    self.bcinfo = [];
    self.bcInfo["last_say_time"]["suppressing_fire"] = -99999;
    self.bcInfo["last_say_time"]["moving"] = -99999;
    self.bcInfo["last_say_time"]["callout_generic"] = -99999;
    self.bcInfo["last_say_time"]["callout_location"] = -99999;

    factionPrefix = maps\mp\gametypes\_teams::getTeamVoicePrefix(self.team);

    {
      mf = "";
      if(!isAgent(self) && self hasFemaleCustomizationModel()) {
        mf = "w";
      }
      self.pers["voiceNum"] = level.voice_count[self.team][mf];
      level.voice_count[self.team][mf] = (level.voice_count[self.team][mf] + 1) % 3;

      self.pers["voicePrefix"] = factionPrefix + mf + self.pers["voiceNum"] + "_";
    }

    if(level.splitscreen) {
      continue;
    }
    if(!level.teambased) {
      continue;
    }
    self thread claymoreTracking();
    self thread reloadTracking();
    self thread grenadeTracking();
    self thread grenadeProximityTracking();
    self thread suppressingFireTracking();
    self thread casualtyTracking();

    self thread damageTracking();
    self thread sprintTracking();
    self thread threatCalloutTracking();
  }
}

grenadeProximityTracking() {
  self endon("disconnect");
  self endon("death");

  position = self.origin;
  grenande_close_limit_sq = 384 * 384;

  for(;;) {
    grenades = ter_op(isDefined(level.grenades), level.grenades, []);
    missiles = ter_op(isDefined(level.missiles), level.missiles, []);
    if(grenades.size + missiles.size < 1 || !isReallyAlive(self)) {
      wait(.05);
      continue;
    }

    grenades = array_combine(grenades, missiles);

    foreach(grenade in grenades) {
      wait(.05);

      if(!isDefined(grenade)) {
        continue;
      }
      if(isDefined(grenade.weapon_name)) {
        switch (grenade.weapon_name) {
          case "throwingknife_mp":
          case "proximity_explosive_mp":
          case "trophy_mp":
          case "motion_sensor_mp":
          case "smoke_grenade_mp":
            continue;
        }

        if(WeaponInventoryType(grenade.weapon_name) != "offhand" && WeaponClass(grenade.weapon_name) == "grenade") {
          continue;
        }
        if(!isDefined(grenade.owner)) {
          grenade.owner = GetMissileOwner(grenade);
        }

        if(isDefined(grenade.owner) && level.teamBased && grenade.owner.team == self.team) {
          continue;
        }
        grenadeDistanceSquared = DistanceSquared(grenade.origin, self.origin);

        if(grenadeDistanceSquared < grenande_close_limit_sq) {
          if(cointoss()) {
            wait 5;
            continue;
          }

          if(BulletTracePassed(grenade.origin, self.origin, false, self)) {
            if(grenade.weapon_name == "concussion_grenade_mp") {
              level thread sayLocalSound(self, "stun_incoming");
              wait 5;
            } else if(grenade.weapon_name == "flash_grenade_mp") {
              level thread sayLocalSound(self, "flash_incoming");
              wait 5;
            } else if(WeaponClass(grenade.weapon_name) == "rocketlauncher") {
              level thread sayLocalSound(self, "rpg_incoming");
              wait 5;
            } else if(grenade.weapon_name == "c4_mp") {
              level thread sayLocalSound(self, "c4_incoming");
              wait 5;
            } else if(grenade.weapon_name == "semtex_mp") {
              level thread sayLocalSound(self, "semtex_incoming");
              wait 5;
            } else {
              if(getDvarInt("g_debugDamage")) {
                println("Grenade Incoming played");
              }

              level thread sayLocalSound(self, "grenade_incoming");
              wait 5;
            }
          }
        }
      }
    }
  }
}

suppressingFireTracking() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  timeStartFired = undefined;

  for(;;) {
    self waittill("begin_firing");

    self thread suppressWaiter();
    self thread suppressTimeout();

    self waittill("stoppedFiring");
  }

}

suppressTimeout() {
  self thread waitSuppressTimeout();
  self endon("begin_firing");
  self waittill("end_firing");
  wait(0.3);
  self notify("stoppedFiring");
}

waitSuppressTimeout() {
  self endon("stoppedFiring");
  self waittill("begin_firing");
  self thread suppressTimeout();
}

suppressWaiter() {
  self notify("suppressWaiter");
  self endon("suppressWaiter");

  self endon("death");
  self endon("disconnect");
  self endon("stoppedFiring");

  wait(1);
  if(self canSay("suppressing_fire")) {
    level thread sayLocalSound(self, "suppressing_fire");
  }
}

claymoreTracking() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  while(1) {
    self waittill("begin_firing");
    weaponName = self getCurrentWeapon();
    if(weaponName == "claymore_mp") {
      level thread sayLocalSound(self, "claymore_plant");
    }
  }
}

reloadTracking() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("reload_start");
    level thread sayLocalSound(self, "reload");
  }
}

grenadeTracking() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("grenade_fire", grenade, weaponName);

    if(weaponName == "frag_grenade_mp") {
      level thread sayLocalSound(self, "frag_out");
    }
    else if(weaponName == "semtex_mp") {
      level thread sayLocalSound(self, "semtex_out");
    }
    else if(weaponName == "flash_grenade_mp") {
      level thread sayLocalSound(self, "flash_out");
    }
    else if(weaponName == "concussion_grenade_mp") {
      level thread sayLocalSound(self, "conc_out");
    }
    else if(weaponName == "smoke_grenade_mp") {
      level thread sayLocalSound(self, "smoke_out");
    }
    else if(weaponName == "c4_mp") {
      level thread sayLocalSound(self, "c4_plant");
    }
  }
}

sprintTracking() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  while(1) {
    self waittill("sprint_begin");
    if(self canSay("moving")) {
      level thread sayLocalSound(self, "moving", false, false);
    }
  }
}

damageTracking() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  while(1) {
    self waittill("damage", amount, attacker);

    if(!isDefined(attacker)) {
      continue;
    }
    if(!isDefined(attacker.classname)) {
      continue;
    }
    if(attacker != self && attacker.classname != "worldspawn") {
      wait(1.5);
      level thread sayLocalSound(self, "damage");
      wait(3);
    }
  }
}

casualtyTracking() {
  self endon("disconnect");
  self endon("faux_spawn");

  self waittill("death");

  foreach(player in level.participants) {
    if(!isDefined(player)) {
      continue;
    }
    if(player == self) {
      continue;
    }
    if(!isReallyAlive(player)) {
      continue;
    }
    if(player.team != self.team) {
      continue;
    }
    if(DistanceSquared(self.origin, player.origin) <= CASUALTY_DISTANCE_LIMIT) {
      level thread sayLocalSoundDelayed(player, "casualty", 0.75);
      break;
    }
  }
}

threatCalloutTracking() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  while(1) {
    self waittill("enemy_sighted");

    if(GetOmnvar("ui_prematch_period")) {
      level waittill("prematch_over");
      continue;
    }

    if(!self canSay("callout_location") && !self canSay("callout_generic")) {
      continue;
    }
    enemies = self getSightedPlayers();

    if(!isDefined(enemies)) {
      continue;
    }
    found_enemy = false;
    dist = MAX_CALLOUT_DISTSQ;

    if(self PlayerAds() > 0.7) {
      dist = MAX_CALLOUT_DISTSQ_ADS;
    }

    foreach(enemy in enemies) {
      if(isDefined(enemy) && isReallyAlive(enemy) && !enemy _hasPerk("specialty_coldblooded") && DistanceSquared(self.origin, enemy.origin) < dist) {
        location = enemy getValidLocation(self);
        found_enemy = true;

        if(isDefined(location) && self canSay("callout_location") && self friendly_nearby(FRIENDLY_IN_RANGE_DIST)) {
          if(self _hasPerk("specialty_quieter") || !self friendly_nearby(TEAMPLAYER_DISTSQ)) {
            level thread sayLocalSound(self, location.locationAliases[0], false);
          } else {
            level thread sayLocalSound(self, location.locationAliases[0], true);
          }

          break;
        }

      }
    }

    if(found_enemy && self canSay("callout_generic")) {
      level thread sayLocalSound(self, "callout_generic");
    }
  }
}

sayLocalSoundDelayed(player, soundType, delay, hearMyselfSpeak, playDistant) {
  player endon("death");
  player endon("disconnect");

  wait(delay);

  sayLocalSound(player, soundType, hearMyselfSpeak, playDistant);
}

sayLocalSound(player, soundType, hearMyselfSpeak, playDistant) {
  player endon("death");
  player endon("disconnect");

  if(isDefined(player.bcDisabled) && player.bcDisabled == true) {
    return;
  }

  if(isSpeakerInRange(player)) {
    return;
  }
  if(player.team != "spectator") {
    prefix = player.pers["voicePrefix"];

    if(isDefined(level.bcSounds[soundType])) {
      soundAlias = prefix + level.bcSounds[soundType];
    } else {
      location_add_last_callout_time(soundType);
      soundAlias = prefix + "co_loc_" + soundType;
      player thread doThreatCalloutResponse(soundAlias, soundType);
      soundType = "callout_location";
    }
    player updateChatter(soundType);
    player thread doSound(soundAlias, hearMyselfSpeak, playDistant);
  }
}

doSound(soundAlias, hearMyselfSpeak, playDistant) {
  battleChatter_debugPrint(soundAlias);

  if(!isDefined(playDistant)) {
    playDistant = true;
  }

  team = self.pers["team"];
  level addSpeaker(self, team);

  relevantToEnemies = (!level.istactical || (!self _hasPerk("specialty_coldblooded") && (isAgent(self) || self IsSighted())));

  if(playDistant && relevantToEnemies) {
    if(isAgent(self) || level.alivecount[team] > 3) {
      self thread doSoundDistant(soundalias, team);
    }
  }

  if(isAgent(self) || (isDefined(hearMyselfSpeak) && hearMyselfSpeak)) {
    self playSoundToTeam(soundAlias, team);
  } else {
    self playSoundToTeam(soundAlias, team, self);
  }

  self thread timeHack(soundAlias);
  self waittill_any(soundAlias, "death", "disconnect");
  level removeSpeaker(self, team);
}

doSoundDistant(soundalias, team) {
  org = spawn("script_origin", self.origin + (0, 0, 256));
  newalias = soundalias + "_n";

  if(soundexists(newalias)) {
    assert(isDefined(level.teamNameList));
    foreach(teamName in level.teamNameList) {
      if(teamName != team) {
        org playSoundToTeam(newalias, teamName);
      }
    }
  }
  wait(3);
  org delete();
}

doThreatCalloutResponse(soundAlias, location) {
  notify_string = self waittill_any_return(soundAlias, "death", "disconnect");
  if(notify_string == soundAlias) {
    team = self.team;
    if(!IsAgent(self)) {
      mf = self hasFemaleCustomizationModel();
    }
    else {
      mf = false;
    }
    voiceNum = self.pers["voiceNum"];
    pos = self.origin;

    wait(0.5);

    foreach(player in level.participants) {
      if(!isDefined(player)) {
        continue;
      }
      if(player == self) {
        continue;
      }
      if(!isReallyAlive(player)) {
        continue;
      }
      if(player.team != team) {
        continue;
      }
      if(!IsAgent(player)) {
        playerMF = player HasFemaleCustomizationModel();
      }
      else {
        playerMF = false;
      }

      if(isDefined(player.pers["voiceNum"]) && (voiceNum != player.pers["voiceNum"] || mf != playerMF) &&
        DistanceSquared(pos, player.origin) <= CASUALTY_DISTANCE_LIMIT &&
        !isSpeakerInRange(player)) {
        prefix = player.pers["voicePrefix"];
        echoAlias = prefix + "co_loc_" + location + "_echo";
        if(SoundExists(echoAlias) && cointoss()) {
          newAlias = echoAlias;
        }
        else {
          newAlias = prefix + level.bcSounds["callout_response_generic"];
        }

        player thread doSound(newAlias, false, true);
        break;
      }
    }
  }
}

timeHack(soundAlias) {
  self endon("death");
  self endon("disconnect");

  wait(2.0);
  self notify(soundAlias);
}

isSpeakerInRange(player, max_dist) {
  player endon("death");
  player endon("disconnect");

  if(!isDefined(max_dist)) {
    max_dist = 1000;
  }
  distSq = max_dist * max_dist;

  if(isDefined(player) && isDefined(player.team) && player.team != "spectator") {
    for(index = 0; index < level.speakers[player.team].size; index++) {
      teammate = level.speakers[player.team][index];
      if(teammate == player) {
        return true;
      }

      if(!isDefined(teammate)) {
        continue;
      }
      if(distancesquared(teammate.origin, player.origin) < distSq) {
        return true;
      }
    }
  }

  return false;
}

addSpeaker(player, team) {
  level.speakers[team][level.speakers[team].size] = player;
}

removeSpeaker(player, team) {
  newSpeakers = [];
  for(index = 0; index < level.speakers[team].size; index++) {
    if(level.speakers[team][index] == player) {
      continue;
    }
    newSpeakers[newSpeakers.size] = level.speakers[team][index];
  }

  level.speakers[team] = newSpeakers;
}

disableBattleChatter(player) {
  player.bcDisabled = true;
}

enableBattleChatter(player) {
  player.bcDisabled = undefined;
}

canSay(soundType) {
  self_pers_team = self.pers["team"];
  if(self_pers_team == "spectator") {
    return false;
  }

  limit = level.bcInfo["timeout_player"][soundType];
  time = GetTime() - self.bcInfo["last_say_time"][soundType];
  if(limit > time) {
    return false;
  }
  limit = level.bcInfo["timeout"][soundType];
  time = GetTime() - level.bcInfo["last_say_time"][self_pers_team][soundType];
  if(
    limit < time

  ) {
    return true;
  }
  return false;
}

updateChatter(soundType) {
  self_pers_team = self.pers["team"];
  self.bcInfo["last_say_time"][soundType] = GetTime();
  level.bcInfo["last_say_time"][self_pers_team][soundType] = GetTime();
  level.bcInfo["last_say_pos"][self_pers_team][soundType] = self.origin;
}

updateLocation(location) {}

getLocation() {
  prof_begin("getLocation");
  myLocations = self get_all_my_locations();
  myLocations = array_randomize(myLocations);

  if(myLocations.size) {
    foreach(location in myLocations) {
      if(!location_called_out_ever(location)) {
        prof_end("getLocation");
        return location;
      }
    }

    foreach(location in myLocations) {
      if(!location_called_out_recently(location)) {
        prof_end("getLocation");
        return location;
      }
    }
  }

  prof_end("getLocation");
  return undefined;
}

getValidLocation(speaker) {
  prof_begin("getValidLocation");
  myLocations = self get_all_my_locations();
  myLocations = array_randomize(myLocations);

  if(myLocations.size) {
    foreach(location in myLocations) {
      if(!location_called_out_ever(location) && speaker canCalloutLocation(location)) {
        prof_end("getValidLocation");
        return location;
      }
    }

    foreach(location in myLocations) {
      if(!location_called_out_recently(location) && speaker canCalloutLocation(location)) {
        prof_end("getValidLocation");
        return location;
      }
    }
  }

  prof_end("getValidLocation");
  return undefined;
}

get_all_my_locations() {
  allLocations = anim.bcs_locations;
  touchingLocations = self GetIsTouchingEntities(allLocations);
  myLocations = [];
  foreach(location in touchingLocations) {
    if(isDefined(location.locationAliases)) {
      myLocations[myLocations.size] = location;
    }
  }

  return myLocations;
}

update_bcs_locations() {
  if(isDefined(anim.bcs_locations)) {
    anim.bcs_locations = array_removeUndefined(anim.bcs_locations);
  }
}

is_in_callable_location() {
  myLocations = self get_all_my_locations();

  foreach(location in myLocations) {
    if(!location_called_out_recently(location)) {
      return true;
    }
  }

  return false;
}

location_called_out_ever(location) {
  lastCalloutTime = location_get_last_callout_time(location.locationAliases[0]);
  if(!isDefined(lastCalloutTime)) {
    return false;
  }

  return true;
}

location_called_out_recently(location) {
  lastCalloutTime = location_get_last_callout_time(location.locationAliases[0]);
  if(!isDefined(lastCalloutTime)) {
    return false;
  }

  nextCalloutTime = lastCalloutTime + LOCATION_REPEAT_LIMIT;
  if(GetTime() < nextCalloutTime) {
    return true;
  }

  return false;
}

location_add_last_callout_time(location) {
  anim.locationLastCalloutTimes[location] = GetTime();
}

location_get_last_callout_time(location) {
  if(isDefined(anim.locationLastCalloutTimes[location])) {
    return anim.locationLastCalloutTimes[location];
  }

  return undefined;
}

canCalloutLocation(location) {
  foreach(alias in location.locationAliases) {
    aliasNormal = self getLocCalloutAlias("co_loc_" + alias);
    aliasQA = self getQACalloutAlias(alias, 0);
    aliasConcat = self getLocCalloutAlias("concat_loc_" + alias);
    valid = SoundExists(aliasNormal) || SoundExists(aliasQA) || SoundExists(aliasConcat);
    if(valid) {
      return valid;
    }
  }
  return false;
}

canConcat(location) {
  aliases = location.locationAliases;
  foreach(alias in aliases) {
    if(IsCalloutTypeConcat(alias, self)) {
      return true;
    }
  }
  return false;
}

GetCannedResponse(speaker) {
  cannedResponseAlias = undefined;

  aliases = self.locationAliases;
  foreach(alias in aliases) {
    if(IsCalloutTypeQA(alias, speaker) && !isDefined(self.qaFinished)) {
      cannedResponseAlias = alias;
      break;
    }

    if(IsCalloutTypeReport(alias)) {
      cannedResponseAlias = alias;
    }
  }

  return cannedResponseAlias;
}

IsCalloutTypeReport(alias) {
  return IsSubStr(alias, "_report");
}

IsCalloutTypeConcat(alias, speaker) {
  tryQA = speaker GetLocCalloutAlias("concat_loc_" + alias);

  if(SoundExists(tryQA)) {
    return true;
  }

  return false;
}

IsCalloutTypeQA(alias, speaker) {
  if(IsSubStr(alias, "_qa") && SoundExists(alias)) {
    return true;
  }

  tryQA = speaker GetQACalloutAlias(alias, 0);

  if(SoundExists(tryQA)) {
    return true;
  }

  return false;
}

GetLocCalloutAlias(basealias) {
  alias = self.pers["voicePrefix"] + basealias;

  return alias;
}

GetQACalloutAlias(basealias, lineIndex) {
  alias = GetLocCalloutAlias(basealias);
  alias += "_qa" + lineIndex;

  return alias;
}

battleChatter_canPrint() {
  if(GetDvar("debug_bcprint") == self.team || GetDvar("debug_bcprint") == "all") {
    return (true);
  }

  return (false);
}

battleChatter_canPrintDump() {
  if(GetDvar("debug_bcprintdump") == self.team || GetDvar("debug_bcprintdump") == "all") {
    return true;
  }

  return (false);
}

battleChatter_print(alias) {
  if(!self battleChatter_canPrint()) {
    return;
  }

  PrintLn("^5" + alias);
}

battleChatter_printDump(alias) {
  if(!self battleChatter_canPrintDump()) {
    return;
  }

  dumpType = GetDvar("debug_bcprintdumptype", "csv");
  if(dumpType != "csv" && dumpType != "txt") {
    return;
  }

  secsSinceLastDump = -1;
  if(isDefined(level.lastDumpTime)) {
    secsSinceLastDump = (GetTime() - level.lastDumpTime) / 1000;
  }

  level.lastDumpTime = GetTime();

  if(dumpType == "csv") {
    if(!flag_exist("bcs_csv_dumpFileWriting")) {
      flag_init("bcs_csv_dumpFileWriting");
    }

    if(!isDefined(level.bcs_csv_dumpFile)) {
      filePath = "scriptgen/battlechatter/bcsDump_" + level.script + ".csv";
      level.bcs_csv_dumpFile = OpenFile(filePath, "write");
    }

    aliasType = getAliasTypeFromSoundalias(alias);

    prefix = self.pers["voicePrefix"];

    factionPrefix = maps\mp\gametypes\_teams::getTeamVoicePrefix(self.team);
    factionPrefix = GetSubStr(factionPrefix, 0, factionPrefix.size - 1);

    dumpString = level.script + "," +
      factionPrefix + "," +
      self.pers["voiceNum"] + "," +
      aliasType;

    battleChatter_printDumpLine(level.bcs_csv_dumpFile, dumpString, "bcs_csv_dumpFileWriting");
  } else if(dumpType == "txt") {
    if(!flag_exist("bcs_txt_dumpFileWriting")) {
      flag_init("bcs_txt_dumpFileWriting");
    }

    if(!isDefined(level.bcs_txt_dumpFile)) {
      filePath = "scriptgen/battlechatter/bcsDump_" + level.script + ".txt";
      level.bcs_txt_dumpFile = OpenFile(filePath, "write");
    }

    dumpString = "(" + secsSinceLastDump + " secs) ";
    dumpString += alias;

    battleChatter_printDumpLine(level.bcs_txt_dumpFile, dumpString, "bcs_txt_dumpFileWriting");
  }

}

battleChatter_debugPrint(alias) {
  self battleChatter_print(alias);
  self thread battleChatter_printDump(alias);
}

getAliasTypeFromSoundalias(alias) {
  prefix = self.pers["voicePrefix"] + "co_loc_";
  if(!IsSubStr(alias, prefix)) {
    prefix = self.pers["voicePrefix"];
  }
  AssertEx(IsSubStr(alias, prefix), "didn't find expected prefix info in alias '" + alias + "' with substr test of '" + prefix + "'.");

  aliasType = GetSubStr(alias, prefix.size, alias.size);

  return aliasType;
}

battleChatter_printDumpLine(file, str, controlFlag) {
  if(flag(controlFlag)) {
    flag_wait(controlFlag);
  }
  flag_set(controlFlag);

  FPrintLn(file, str);

  flag_clear(controlFlag);
}

friendly_nearby(max_dist) {
  if(!isDefined(max_dist)) {
    max_dist = TEAMPLAYER_DISTSQ;
  }

  foreach(player in level.players) {
    if(player.team == self.pers["team"]) {
      if(player != self && DistanceSquared(player.origin, self.origin) <= max_dist) {
        return true;
      }
    }
  }
  return false;
}