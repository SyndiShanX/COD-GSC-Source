/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_nuke.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;

init() {
  level._effect["nuke_flash"] = loadfx("vfx/explosion/dna_bomb_flash_mp");
  level._effect["nuke_aftermath"] = loadfx("vfx/dust/nuke_aftermath_mp");
  level._effect["dna_bomb_body_gas"] = loadfx("vfx/explosion/dna_bomb_body_gas");

  game["strings"]["nuclear_strike"] = &"KILLSTREAKS_TACTICAL_NUKE";

  level.killstreakFuncs["nuke"] = ::tryUseNuke;
  level.killstreakWieldWeapons["nuke_mp"] = "nuke";

  SetDvarIfUninitialized("scr_nukeTimer", 10);
  SetDvarIfUninitialized("scr_nukeCancelMode", 0);

  level.nukeTimer = getDvarInt("scr_nukeTimer");
  level.cancelMode = getDvarInt("scr_nukeCancelMode");

  level.nukeEmpTimeout = 60.0;
  level.nukeEmpTimeRemaining = int(level.nukeEmpTimeout);
  level.nukeInfo = spawnStruct();
  level.nukeInfo.xpScalar = 2;
  level.nukeDetonated = undefined;

  level thread onPlayerConnect();

  SetDevDvarIfUninitialized("scr_nukeDistance", 5000);
  SetDevDvarIfUninitialized("scr_nukeEndsGame", true);
  SetDevDvarIfUninitialized("scr_nukeDebugPosition", false);
}

tryUseNuke(lifeId, modules, allowCancel) {
  if(isDefined(level.nukeIncoming)) {
    self iPrintLnBold(&"KILLSTREAKS_NUKE_ALREADY_INBOUND");
    return false;
  }

  if(self isUsingRemote()) {
    return false;
  }

  if(!isDefined(allowCancel)) {
    allowCancel = true;
  }

  self thread doNuke(allowCancel);

  self maps\mp\_matchdata::logKillstreakEvent("nuke", self.origin);

  return true;
}

delaythread_nuke(delay, func) {
  level endon("nuke_cancelled");

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(delay);

  thread[[func]]();
}

doNuke(allowCancel) {
  level endon("nuke_cancelled");

  level.nukeInfo.player = self;
  level.nukeInfo.team = self.pers["team"];

  level.nukeIncoming = true;

  SetOmnvar("ui_bomb_timer", 4);

  if(level.teambased) {
    thread teamPlayerCardSplash("used_nuke", self, self.team);
  } else {
    if(!level.hardcoreMode) {
      self IPrintLnBold(&"MP_FRIENDLY_TACTICAL_NUKE");
    }
  }

  level thread delaythread_nuke((level.nukeTimer - 3.3), ::nukeSoundIncoming);
  level thread delaythread_nuke(level.nukeTimer, ::nukeSoundExplosion);
  level thread delaythread_nuke(level.nukeTimer, ::nukeSlowMo);
  level thread delaythread_nuke((level.nukeTimer - 0.32), ::nukeEffects);
  level thread delaythread_nuke((level.nukeTimer - 0.1), ::nukeVision);
  level thread delaythread_nuke((level.nukeTimer + 0.5), ::nukeDeath);
  level thread delaythread_nuke((level.nukeTimer + 1.5), ::nukeEarthquake);
  level thread nukeAftermathEffect();
  level thread update_ui_timers();

  if(level.cancelMode && allowCancel) {
    level thread cancelNukeOnDeath(self);
  }

  if(!isDefined(level.nuke_clockObject)) {
    level.nuke_clockObject = spawn("script_origin", (0, 0, 0));
    level.nuke_clockObject hide();
  }
  if(!isDefined(level.nuke_soundObject)) {
    level.nuke_soundObject = spawn("script_origin", (0, 0, 1));
    level.nuke_soundObject hide();
  }

  nukeTimer = level.nukeTimer;
  while(nukeTimer > 0) {
    level.nuke_clockObject playSound("ks_dna_warn_timer");
    wait(1.0);
    nukeTimer--;
  }
}

cancelNukeOnDeath(player) {
  player waittill_any("death", "disconnect");

  SetOmnvar("ui_bomb_timer", 0);
  level.nukeIncoming = undefined;

  level notify("nuke_cancelled");
}

nukeSoundIncoming() {
  level endon("nuke_cancelled");

  if(isDefined(level.nuke_soundObject)) {
    level.nuke_soundObject playSound("ks_dna_incoming");
  }
}

nukeSoundExplosion() {
  level endon("nuke_cancelled");

  if(isDefined(level.nuke_soundObject)) {
    level.nuke_soundObject playSound("ks_dna_explosion");
    level.nuke_soundObject playSound("ks_dna_wave");
  }
}

nukeEffects() {
  level endon("nuke_cancelled");

  foreach(player in level.players) {
    playerForward = anglesToForward(player.angles);
    playerForward = (playerForward[0], playerForward[1], 0);
    playerForward = VectorNormalize(playerForward);

    nukeDistance = 300;

    nukeEnt = spawn("script_model", player.origin + (playerForward * nukeDistance));
    nukeEnt setModel("tag_origin");
    nukeEnt.angles = (0, (player.angles[1] + 180), 90);

    if(getDvarInt("scr_nukeDebugPosition")) {
      lineTop = (nukeEnt.origin[0], nukeEnt.origin[1], (nukeEnt.origin[2] + 500));
      thread draw_line_for_time(nukeEnt.origin, lineTop, 1, 0, 0, 10);
    }

    nukeEnt thread nukeEffect(player);
  }
}

nukeEffect(player) {
  level endon("nuke_cancelled");

  player endon("disconnect");

  waitframe();
  PlayFXOnTagForClients(level._effect["nuke_flash"], self, "tag_origin", player);
}

nukeAftermathEffect() {
  level endon("nuke_cancelled");

  level waittill("spawning_intermission");

  afermathEnt = getEntArray("mp_global_intermission", "classname");
  afermathEnt = afermathEnt[0];
  up = anglestoup(afermathEnt.angles);
  right = anglestoright(afermathEnt.angles);

  playFX(level._effect["nuke_aftermath"], afermathEnt.origin, up, right);
}

nukeSlowMo() {
  level endon("nuke_cancelled");

  SetOmnvar("ui_bomb_timer", 0);

  SetSlowMotion(1.0, 0.25, 0.5);
  level waittill("nuke_death");
  SetSlowMotion(0.25, 1, 2.0);
}

nukeVision() {
  level endon("nuke_cancelled");

  level.nukeVisionInProgress = true;
  foreach(player in level.players) {
    player SetClientTriggerVisionSet("dna_bomb", 0.5);
    player thread maps\mp\_flashgrenades::applyFlash(1.6, 0.35);
  }

  level waittill("nuke_death");

  wait 3.0;
  foreach(player in level.players) {
    player SetClientTriggerVisionSet("", 10);
  }

  level.nukeVisionInProgress = undefined;
}

nukeDeath() {
  level endon("nuke_cancelled");

  level notify("nuke_death");

  maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

  AmbientStop(1);

  counter = 0;
  foreach(player in level.players) {
    if(level.teambased) {
      if(isDefined(level.nukeInfo.team) && player.team == level.nukeInfo.team) {
        continue;
      }
    } else {
      if(isDefined(level.nukeInfo.player) && player == level.nukeInfo.player) {
        continue;
      }
    }

    player.nuked = true;
    if(isAlive(player)) {
      player thread maps\mp\gametypes\_damage::finishPlayerDamageWrapper(level.nukeInfo.player, level.nukeInfo.player, 999999, 0, "MOD_EXPLOSIVE", "nuke_mp", player.origin, player.origin, "none", 0, 0);

      if(isDefined(player.isJuggernaut) && player.isJuggernaut == true) {
        player DoDamage(1, player.origin, level.nukeInfo.player, level.nukeInfo.player, "MOD_EXPLOSIVE", "nuke_mp");
      }

      delayThread(counter + 1, ::bodyGasFX, player.body);
      counter += 0.05;
    }
  }

  level thread nuke_EMPJam();

  level.nukeIncoming = undefined;
}

bodyGasFX(ent) {
  if(isDefined(ent)) {
    playFXOnTag(getfx("dna_bomb_body_gas"), ent, "J_SPINELOWER");
  }
}

nukeEarthquake() {
  level endon("nuke_cancelled");

  level waittill("nuke_death");
}

nuke_EMPJam() {
  level endon("game_ended");

  level notify("nuke_EMPJam");
  level endon("nuke_EMPJam");
  if(level.multiTeamBased) {
    for(i = 0; i < level.teamNameList.size; i++) {
      if(level.nukeInfo.team != level.teamNameList[i]) {
        level maps\mp\killstreaks\_emp::destroyActiveVehicles(level.nukeInfo.player, level.teamNameList[i]);
      }
    }
  } else if(level.teambased) {
    level maps\mp\killstreaks\_emp::destroyActiveVehicles(level.nukeInfo.player, getOtherTeam(level.nukeInfo.team));
  } else {
    level maps\mp\killstreaks\_emp::destroyActiveVehicles(level.nukeInfo.player, getOtherTeam(level.nukeInfo.team));
  }

  level notify("nuke_emp_update");

  level.nukeEmpTimeout = GetDvarFloat("scr_nuke_empTimeout");

  level notify("nuke_emp_update");
  level notify("nuke_emp_ended");
}

keepNukeEMPTimeRemaining() {
  level notify("keepNukeEMPTimeRemaining");
  level endon("keepNukeEMPTimeRemaining");

  level endon("nuke_emp_ended");

  level.nukeEmpTimeRemaining = int(level.nukeEmpTimeout);
  while(level.nukeEmpTimeRemaining) {
    wait(1.0);
    level.nukeEmpTimeRemaining--;
  }
}

nuke_EMPTeamTracker() {
  level endon("game_ended");

  for(;;) {
    level waittill_either("joined_team", "nuke_emp_update");

    foreach(player in level.players) {
      if(player.team == "spectator") {
        continue;
      }

      if(level.teambased) {
        if(isDefined(level.nukeInfo.team) && player.team == level.nukeInfo.team) {
          continue;
        }
      } else {
        if(isDefined(level.nukeInfo.player) && player == level.nukeInfo.player) {
          continue;
        }
      }

      if(!level.teamNukeEMPed[player.team] && !player isEMPed()) {
        player SetEMPJammed(false);
      } else {
        player SetEMPJammed(true);
      }
    }
  }
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

    if(isDefined(level.nukeVisionInProgress)) {
      self SetClientTriggerVisionSet("dna_bomb");
      waitframe();
      self SetClientTriggerVisionSet("", 10);
    }
  }
}

update_ui_timers() {
  level endon("game_ended");
  level endon("disconnect");
  level endon("nuke_cancelled");
  level endon("nuke_death");

  nukeEndMilliseconds = (level.nukeTimer * 1000) + gettime();
  SetOmnvar("ui_nuke_end_milliseconds", nukeEndMilliseconds);

  level waittill("host_migration_begin");

  timePassed = maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

  if(timePassed > 0) {
    SetOmnvar("ui_nuke_end_milliseconds", nukeEndMilliseconds + timePassed);
  }
}