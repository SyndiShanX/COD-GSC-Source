/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
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
  level.bcSounds["semtex_out"] = "semtex_use";
  level.bcSounds["conc_out"] = "inform_attack_stun";
  level.bcSounds["smoke_out"] = "inform_attack_smoke";
  level.bcSounds["emp_out"] = "emp_use";
  level.bcSounds["threat_out"] = "threat_use";
  level.bcSounds["drone_out"] = "inform_drone_use";

  level.bcSounds["grenade_incoming"] = "grenade_incoming";
  level.bcSounds["semtex_incoming"] = "semtex_incoming";
  level.bcSounds["stun_incoming"] = "stun_incoming";
  level.bcSounds["emp_incoming"] = "incoming_emp";
  level.bcSounds["drone_incoming"] = "inform_drone_enemy";

  level.bcSounds["exo_cloak_use"] = "inform_cloaking_use";
  level.bcSounds["exo_overclock_use"] = "inform_overclock_use";
  level.bcSounds["exo_ping_use"] = "exo_ping";
  level.bcSounds["exo_shield_use"] = "exo_shield_use";

  level.bcSounds["callout_generic"] = "threat_infantry_generic";
  level.bcSounds["callout_sniper"] = "threat_sniper_generic";
  level.bcSounds["callout_hover"] = "enemy_hover";
  level.bcSounds["callout_shield"] = "exo_shield_enemy";
  level.bcSounds["callout_cloak"] = "inform_cloaking_enemy";
  level.bcSounds["callout_overclock"] = "inform_overclock_enemy";

  level.bcSounds["callout_response_generic"] = "response_ack_yes";

  level.bcSounds["kill"] = "inform_killfirm_infantry";
  level.bcSounds["casualty"] = "inform_casualty_generic";
  level.bcSounds["suppressing_fire"] = "cmd_suppressfire";
  level.bcSounds["moving"] = "order_move_combat";
  level.bcSounds["damage"] = "inform_taking_fire";

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
      if(level.currentgen) {
        numMaleVoices = 5;
        numFemaleVoices = 3;
      } else {
        numMaleVoices = 9;
        numFemaleVoices = 5;
      }

      mf = "";
      if(!isAgent(self) && self hasFemaleCustomizationModel()) {
        mf = "w";
      }
      self.pers["voiceNum"] = level.voice_count[self.team][mf];
      if(mf == "w") {
        level.voice_count[self.team][mf] = (level.voice_count[self.team][mf] + 1) % numFemaleVoices;
      } else {
        level.voice_count[self.team][mf] = (level.voice_count[self.team][mf] + 1) % numMaleVoices;
      }

      self.pers["voicePrefix"] = factionPrefix + mf + self.pers["voiceNum"] + "_";
    }

    if(level.splitscreen) {
      continue;
    }

    if(!level.teambased) {
      continue;
    }

    self thread reloadTracking();
    self thread grenadeTracking();
    self thread grenadeProximityTracking();
    self thread exoAbilityTracking();
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
    drones = ter_op(isDefined(level.trackingDrones), level.trackingDrones, []);

    if(grenades.size + missiles.size + drones.size < 1 || !isReallyAlive(self)) {
      wait(.05);
      continue;
    }

    grenades = array_combine(grenades, missiles);
    grenades = array_combine(grenades, drones);

    if(grenades.size < 1) {
      wait(.05);
      continue;
    }

    foreach(grenade in grenades) {
      wait(.05);

      if(!isDefined(grenade)) {
        continue;
      }

      isVehicle = isDefined(grenade.type) && (grenade.type == "explosive_drone" || grenade.type == "tracking_drone");

      if(isDefined(grenade.weaponName)) {
        switch (grenade.weaponName) {
          case "gamemode_ball":
            continue;
        }

        if(WeaponInventoryType(grenade.weaponName) != "offhand" && WeaponClass(grenade.weaponName) == "grenade") {
          continue;
        }
      }

      if(!isDefined(grenade.owner) && !isVehicle) {
        grenade.owner = GetMissileOwner(grenade);
      }

      if(isDefined(grenade.owner) && isDefined(grenade.owner.team) && level.teamBased && grenade.owner.team == self.team) {
        continue;
      }

      grenadeDistanceSquared = DistanceSquared(grenade.origin, self.origin);

      if(grenadeDistanceSquared < grenande_close_limit_sq) {
        if(cointoss()) {
          wait 5;
          continue;
        }

        if(BulletTracePassed(grenade.origin, self.origin, false, self)) {
          localSound = "";

          if(isVehicle) {
            localSound = "drone_incoming";
          } else if(isDefined(grenade.weaponName)) {
            switch (grenade.weaponName) {
              case "semtex_mp":
                localSound = "semtex_incoming";
                break;
              case "stun_grenade_mp":
              case "stun_grenade_var_mp":
                localSound = "stun_incoming";
                break;
              case "emp_grenade_mp":
              case "emp_grenade_var_mp":
                localSound = "emp_incoming";
            }
          }

          if(localSound == "") {
            localSound = "grenade_incoming";
          }

          if(getDvarInt("g_debugDamage")) {
            println("Grenade Incoming played");
          }

          level thread sayLocalSound(self, localSound);
          wait 5;
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

    self notify("stoppedFiring");
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

    shortWeaponName = maps\mp\_utility::strip_suffix(weaponName, "_lefthand");

    if(shortWeaponName == "frag_grenade_mp" || shortWeaponName == "frag_grenade_var_mp" || shortWeaponName == "contact_grenade_var_mp") {
      level thread sayLocalSound(self, "frag_out");
    } else if(shortWeaponName == "semtex_mp" || shortWeaponName == "semtex_grenade_var_mp") {
      level thread sayLocalSound(self, "semtex_out");
    } else if(shortWeaponName == "explosive_drone_mp" || shortWeaponName == "tracking_drone_mp") {
      level thread sayLocalSound(self, "drone_out");
    } else if(shortWeaponName == "concussion_grenade_mp" || shortWeaponName == "stun_grenade_mp" || shortWeaponName == "stun_grenade_var_mp") {
      level thread sayLocalSound(self, "conc_out");
    } else if(shortWeaponName == "smoke_grenade_mp" || shortWeaponName == "smoke_grenade_var_mp") {
      level thread sayLocalSound(self, "smoke_out");
    } else if(shortWeaponName == "emp_grenade_mp" || shortWeaponName == "emp_grenade_var_mp") {
      level thread sayLocalSound(self, "emp_out");
    } else if(shortWeaponName == "paint_grenade_mp" || shortWeaponName == "paint_grenade_var_mp") {
      level thread sayLocalSound(self, "threat_out");
    }
  }
}

exoAbilityTracking() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  exo_shield_weapon = maps\mp\_exo_shield::get_exo_shield_weapon();
  exo_cloak_weapon = maps\mp\_exo_cloak::get_exo_cloak_weapon();
  exo_ping_weapon = "exoping_equipment_mp";

  for(;;) {
    results = self waittill_any_return_parms("grenade_pullback", "grenade_fire", "exo_adrenaline_fire");
    waitframe();

    if(results[0] == "grenade_pullback" && isDefined(results[1]) && results[1] == exo_shield_weapon && isDefined(self.exo_shield_on) && self.exo_shield_on) {
      level thread sayLocalSound(self, "exo_shield_use");
    } else if(results[0] == "grenade_fire" && isDefined(results[2]) && results[2] == exo_cloak_weapon && isDefined(self.exo_cloak_on) && self.exo_cloak_on) {
      level thread sayLocalSound(self, "exo_cloak_use");
    } else if(results[0] == "grenade_fire" && isDefined(results[2]) && results[2] == exo_ping_weapon && isDefined(self.exo_ping_on) && self.exo_ping_on) {
      level thread sayLocalSound(self, "exo_ping_use");
    } else if(results[0] == "exo_adrenaline_fire" && isDefined(self.overclock_on) && self.overclock_on) {
      level thread sayLocalSound(self, "exo_overclock_use");
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

    if(isDefined(level.isHorde) && level.isHorde && isDefined(attacker.agent_type) && attacker.agent_type == "dog") {
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

  myTeam = self.team;

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

    if(player.team != myTeam) {
      continue;
    }

    if(isDefined(self) && DistanceSquared(self.origin, player.origin) <= CASUALTY_DISTANCE_LIMIT) {
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

    if(GetDvarInt("ui_inprematch")) {
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

    found_enemy = undefined;
    dist = MAX_CALLOUT_DISTSQ;

    if(self PlayerAds() > 0.7) {
      dist = MAX_CALLOUT_DISTSQ_ADS;
    }

    foreach(enemy in enemies) {
      if(isDefined(enemy) && isReallyAlive(enemy) && !enemy _hasPerk("specialty_coldblooded") && DistanceSquared(self.origin, enemy.origin) < dist) {
        location = enemy getValidLocation(self);
        found_enemy = enemy;

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

    if(isDefined(found_enemy) && self canSay("callout_generic")) {
      curWeapon = found_enemy GetCurrentPrimaryWeapon();

      guyIsCloaked = found_enemy IsCloaked();
      guyIsHovering = isDefined(found_enemy.exo_hover_on) && found_enemy.exo_hover_on;
      guyHasOverclock = isDefined(found_enemy.overclock_on) && found_enemy.overclock_on;
      guyIsShielded = isDefined(found_enemy.exo_shield_on) && found_enemy.exo_shield_on;
      guyIsShielded = guyIsShielded || isDefined(self.frontShieldModel);
      guyIsSniper = WeaponClass(curWeapon) == "sniper";

      if(guyIsCloaked) {
        level thread sayLocalSound(self, "callout_cloak");
      } else if(guyIsHovering) {
        level thread sayLocalSound(self, "callout_hover");
      } else if(guyHasOverclock) {
        level thread sayLocalSound(self, "callout_overclock");
      } else if(guyIsShielded) {
        level thread sayLocalSound(self, "callout_shield");
      } else if(guyIsSniper) {
        level thread sayLocalSound(self, "callout_sniper");
      } else {
        level thread sayLocalSound(self, "callout_generic");
      }
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

  if(isDefined(level.chatterDisabled) && level.chatterDisabled) {
    return;
  }

  if(isDefined(player.bcDisabled) && player.bcDisabled == true) {
    return;
  }

  if(isSpeakerInRange(player)) {
    return;
  }

  if(player maps\mp\killstreaks\_juggernaut::get_is_in_mech()) {
    return;
  }

  if(player.team != "spectator") {
    prefix = player.pers["voicePrefix"];

    if(isDefined(level.bcSounds[soundType])) {
      soundAlias = prefix + level.bcSounds[soundType];

      switch (soundType) {
        case "callout_sniper":
        case "callout_hover":
        case "callout_shield":
        case "callout_cloak":
        case "callout_overclock":
          soundType = "callout_generic";
          break;
      }
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

  if(!SoundExists(soundAlias)) {
    oldChannel = SetPrintChannel("error");
    PrintLn("^1Error: Missing BCS: " + soundAlias);
    SetPrintChannel(oldChannel);

    level removeSpeaker(self, team);
    return;
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
  if(!SoundExists(soundAlias)) {
    oldChannel = SetPrintChannel("error");
    PrintLn("^1Error: Missing BCS: " + soundAlias);
    SetPrintChannel(oldChannel);

    return;
  }

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
    } else {
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
      } else {
        playerMF = false;
      }

      if((voiceNum != player.pers["voiceNum"] || mf != playerMF) &&
        DistanceSquared(pos, player.origin) <= CASUALTY_DISTANCE_LIMIT &&
        !isSpeakerInRange(player)) {
        prefix = player.pers["voicePrefix"];
        echoAlias = prefix + "co_loc_" + location + "_echo";
        if(SoundExists(echoAlias) && cointoss()) {
          newAlias = echoAlias;
        } else {
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