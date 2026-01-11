/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_beast_men.gsc
*****************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\gametypes\_hostmigration;
#include maps\mp\agents\_agent_utility;
#include maps\mp\bots\_bots_util;
#include maps\mp\bots\_bots_strategy;

CONST_MAX_ACTIVE_KILLSTREAK_AGENTS_PER_GAME = 5;
CONST_MAX_ACTIVE_KILLSTREAK_AGENTS_PER_PLAYER = 3;
CONST_AGENT_TYPE = "beastmen";
CONST_AGENT_HEALTH = 500;

init() {}

setupCallbacks() {
  level.agent_funcs[CONST_AGENT_TYPE] = level.agent_funcs["squadmate"];

  level.agent_funcs[CONST_AGENT_TYPE]["spawn"] = ::spawn_agent_beast;
  level.agent_funcs[CONST_AGENT_TYPE]["think"] = ::squadmate_agent_think;
  level.agent_funcs[CONST_AGENT_TYPE]["on_killed"] = ::on_agent_squadmate_killed;
}

tryUseAgentKillstreak(lifeId, streakName) {
  setupCallbacks();

  self.beastCount = 0;

  self thread delayedSpawnBeast(5);

  return true;
}

spawnBeast() {
  agent = createSquadmate();
  if(isDefined(agent)) {
    self.beastCount++;

    if(self.beastCount < CONST_MAX_ACTIVE_KILLSTREAK_AGENTS_PER_PLAYER) {
      self thread delayedSpawnBeast(0.5);
    }

    return true;
  }

  return false;
}

delayedSpawnBeast(delayTime) {
  self endon("disconnect");
  level endon("game_ended");

  wait(delayTime);

  self spawnBeast();
}

createSquadmate(spawnOverride) {
  spawnOrigin = findSpawnLocation();

  if(isDefined(spawnOverride)) {
    spawnOrigin = spawnOverride;
  }

  spawnAngles = VectorToAngles(self.origin - spawnOrigin);

  agent = maps\mp\agents\_agents::add_humanoid_agent(CONST_AGENT_TYPE, self.team, "reconAgent", spawnOrigin, spawnAngles, self, false, false, "veteran");
  if(!isDefined(agent)) {
    self iPrintLnBold(&"KILLSTREAKS_AGENT_MAX");
    return false;
  }

  agent.killStreakType = "agent";

  return agent;
}

spawn_agent_beast(optional_spawnOrigin, optional_spawnAngles, optional_owner, use_randomized_personality, respawn_on_death, difficulty) {
  self endon("disconnect");

  while(!isDefined(level.getSpawnPoint)) {
    waitframe();
  }

  if(self.hasDied) {
    wait(RandomIntRange(6, 10));
  }

  self initPlayerScriptVariables(true);

  if(isDefined(optional_spawnOrigin) && isDefined(optional_spawnAngles)) {
    spawnOrigin = optional_spawnOrigin;
    spawnAngles = optional_spawnAngles;

    self.lastSpawnPoint = spawnStruct();
    self.lastSpawnPoint.origin = spawnOrigin;
    self.lastSpawnPoint.angles = spawnAngles;
  } else {
    spawnPoint = self[[level.getSpawnPoint]]();
    spawnOrigin = spawnpoint.origin;
    spawnAngles = spawnpoint.angles;

    self.lastSpawnPoint = spawnpoint;
  }
  self activateAgent();
  self.lastSpawnTime = GetTime();
  self.spawnTime = GetTime();

  phys_trace_start = spawnOrigin + (0, 0, 25);
  phys_trace_end = spawnOrigin;
  newSpawnOrigin = PlayerPhysicsTrace(phys_trace_start, phys_trace_end);
  if(DistanceSquared(newSpawnOrigin, phys_trace_start) > 1) {
    spawnOrigin = newSpawnOrigin;
  }

  self SpawnAgent(spawnOrigin, spawnAngles);

  self maps\mp\bots\_bots_util::bot_set_personality("cqb");

  if(isDefined(difficulty)) {
    self maps\mp\bots\_bots_util::bot_set_difficulty(difficulty);
  }

  self maps\mp\agents\_agents::initPlayerClass();

  self maps\mp\agents\_agent_common::set_agent_health(CONST_AGENT_HEALTH);
  if(isDefined(respawn_on_death) && respawn_on_death) {
    self.respawn_on_death = true;
  }

  if(isDefined(optional_owner)) {
    self set_agent_team(optional_owner.team, optional_owner);
  }

  if(isDefined(self.owner)) {
    self thread maps\mp\agents\_agents::destroyOnOwnerDisconnect(self.owner);
  }

  self thread maps\mp\_flashgrenades::monitorFlash();

  self EnableAnimState(false);

  self[[level.onSpawnPlayer]]();
  self maps\mp\gametypes\_class::giveLoadout(self.team, self.class, true);
  self customizeSquadmate();

  self thread maps\mp\bots\_bots::bot_think_watch_enemy(true);

  self thread maps\mp\bots\_bots_strategy::bot_think_tactical_goals();
  self thread[[self agentFunc("think")]]();

  if(!self.hasDied) {
    self maps\mp\gametypes\_spawnlogic::addToParticipantsArray();
  }

  self.hasDied = false;

  self thread maps\mp\gametypes\_weapons::onPlayerSpawned();
  self thread maps\mp\gametypes\_healthoverlay::playerHealthRegen();

  level notify("spawned_agent_player", self);
  level notify("spawned_agent", self);
  self notify("spawned_player");

  self.environmentState = "outdoors";
  self thread delaySoundFX("zerosub_monster_breath_only_lp", 0.05);
  self thread delaySoundFX("zerosub_monster_steps_only_ext_lp", 0.10);
  self thread delayplayFXOnTag(level._effect["vfx_yeti_snowcover_upflip"], "tag_origin", 0.05, 0.5);
  self playEyeFX();

  self thread watchBeastMovement();
  self thread watchKillstreakEnd();
}

squadmate_agent_think() {
  self endon("death");
  level endon("game_ended");

  if(isDefined(self.owner)) {
    self endon("owner_disconnect");
  }

  self BotSetFlag("force_sprint", true);
}

on_agent_squadmate_killed(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration) {
  self maps\mp\agents\_agents::on_humanoid_agent_killed_common(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration, false);

  body = self GetCorpseEntity();

  playFX(level._effect["vfx_yeti_snowcover_dissolve"], self.origin);
  self playSound("mp_zerosub_monster_death");

  if(sMeansOfDeath == "MOD_MELEE") {
    wait(0.75);
  } else {
    wait(0.5);
  }

  self maps\mp\agents\_agent_utility::deactivateAgent();

  if(IsPlayer(eAttacker) && isDefined(self.owner) && eAttacker != self.owner) {
    self maps\mp\gametypes\_damage::onKillstreakKilled(eAttacker, sWeapon, sMeansOfDeath, iDamage, "destroyed_ks_beast_man");
  }

  body delete();
}

customizeSquadmate() {
  self setModel("mp_fullbody_beast_man");

  if(isDefined(self.headModel)) {
    self Detach(self.headModel, "");
    self.headModel = undefined;
  }

  playFX(level._effect["vfx_yeti_snowcover_upflip"], self.origin);

  mainWeapon = "iw6_knifeonlybeast_mp";

  self TakeAllWeapons();
  self GiveWeapon(mainWeapon);
  self SwitchToWeapon(mainWeapon);
  self BotSetFlag("prefer_melee", true);

  self givePerk("specialty_spygame", false);
  self givePerk("specialty_coldblooded", false);
  self givePerk("specialty_noscopeoutline", false);
  self givePerk("specialty_heartbreaker", false);
  self givePerk("specialty_quieter", false);

  self thread watchRemovePerks();

  self.health = CONST_AGENT_HEALTH;

  self.customMeleeDamageTaken = 100;

  self SetSurfaceType("snow");

  maps\mp\gametypes\_battlechatter_mp::disableBattleChatter(self);
}

watchRemovePerks() {
  self endon("death");
  level endon("game_over");

  self waittill("starting_perks_unset");

  self givePerk("specialty_blindeye", false);
}

delaySoundFX(sound, delayTime) {
  self endon("death");
  level endon("game_ended");

  wait(delayTime);

  self playLoopSound(sound);
}

delayplayFXOnTag(FX, tag, delayTime, intervalTime) {
  self endon("death");
  level endon("game_ended");

  wait(delayTime);

  while(true) {
    playFXOnTag(FX, self, tag);

    if(isDefined(intervalTime)) {
      wait(intervalTime);
    } else {
      break;
    }
  }
}

playEyeFX() {
  forwardVector = anglesToForward(self.angles) * 30;
  rightVector = AnglesToRight(self.angles) * 7;

  vertOffset = (0, 0, 65);
  self thread createEyeFX("left", self.origin + forwardVector + rightVector + vertOffset);

  self thread createEyeFX("right", self.origin + forwardVector - rightVector + vertOffset);
}

createEyeFX(eye, fxPos) {
  self endon("death");
  level endon("game_ended");

  if(eye == "left") {
    self.leftEyeObj = spawn("script_model", fxPos);
    self.leftEyeObj setModel("tag_origin");
    self.leftEyeObj LinkTo(self);
    self.leftEyeObj delayplayFXOnTag(level.zerosub_fx["beast"]["eyeglow"], "tag_origin", 0.05, 0.5);
  } else {
    self.rightEyeObj = spawn("script_model", fxPos);
    self.rightEyeObj setModel("tag_origin");
    self.rightEyeObj LinkTo(self);
    self.rightEyeObj delayplayFXOnTag(level.zerosub_fx["beast"]["eyeglow"], "tag_origin", 0.05, 0.5);
  }
}

watchBeastMovement() {
  level endon("game_ended");
  level endon("frost_clear");

  while(true) {
    if(!self maps\mp\mp_zerosub::isOutside()) {
      if(!level.beastAllowedIndoors) {
        newSpawnLocation = findSpawnLocation(self.origin);

        if(isDefined(newSpawnLocation)) {
          self DoDamage(10000, self.origin);

          wait(1);

          level.zerosub_killstreak_user createSquadmate(newSpawnLocation);
          break;
        }
      }

      if(self.environmentState != "indoors") {
        self.environmentState = "indoors";
        self StopSounds();

        wait(0.3);

        self thread delaySoundFX("zerosub_monster_breath_only_lp", 0.05);
        self thread delaySoundFX("zerosub_monster_steps_only_int_lp", 0.10);
      }
    } else {
      if(self.environmentState != "outdoors") {
        self.environmentState = "outdoors";
        self StopSounds();

        wait(0.3);

        self thread delaySoundFX("zerosub_monster_breath_only_lp", 0.05);
        self thread delaySoundFX("zerosub_monster_steps_only_ext_lp", 0.10);
      }
    }

    waitframe();
  }
}

findSpawnLocation(oldPosition) {
  spawnPoint = undefined;
  locations = getStructArray("zerosub_beast_spawn", "targetname");

  if(!isDefined(locations) || locations.size == 0) {
    AssertMsg("This should never happen.Locations should be defined for the beast men");
    return undefined;
  }

  if(isDefined(oldPosition)) {
    furthestDist = undefined;

    foreach(loc in locations) {
      newDist = Distance2DSquared(oldPosition, loc.origin);

      if(!isDefined(furthestDist) || furthestDist < newDist) {
        furthestDist = newDist;
        spawnPoint = loc.origin;
      }
    }
  } else {
    randomIndex = RandomInt(locations.size);
    spawnPoint = locations[randomIndex].origin;
  }

  return spawnPoint;
}

watchKillstreakEnd() {
  self endon("death");
  level endon("game_ended");

  level waittill("frost_clear");

  self DoDamage(10000, self.origin);
  self.leftEyeObj Delete();
  self.rightEyeObj Delete();
}