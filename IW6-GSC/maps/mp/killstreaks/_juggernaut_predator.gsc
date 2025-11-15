/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_juggernaut_predator.gsc
********************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

CONST_JUGG_TYPE = "juggernaut_predator";
CONST_AIRDROP_TYPE = "airdrop_" + CONST_JUGG_TYPE;
CONST_JUGG_CRATE_WEIGHT = 85;
CONST_JUGG_CRATE_STRING = & "MP_JUGG_PREDATOR_PICKUP";

CONST_CANNON_WEAPON = "iw6_predatorcannon_mp";
CONST_PREDATOR_COMPUTER = "iw6_predatorwristcpu_mp";
CONST_PREDATOR_SELF_DESTRUCT = "iw6_predatorsuicide_mp";

CONST_CLOAK_ON_DELAY = 500;
CONST_CLOAK_OFF_DELAY = 1000;

CONST_CLOAK_PENALTY_SPRINT = 1250;
CONST_CLOAK_PENALTY_CANNON = 3000;
CONST_CLOAK_PENALTY_MELEE = 1000;
CONST_CLOAK_PENALTY_FORCED_OFF = 1000;

CONST_DEBUG_DVAR = "scr_pred_nocloak";
CONST_DEBUG_LASTSTAND_DVAR = "scr_pred_laststand";

CONST_MOVEMENT_CHECK_FREQ = 0.1;
CONST_MOVEMENT_THRESHOLD = 135 * 135;

CANNON_LOCK_TIME = 0.375;
CANNON_RELOAD_TIME = 8;
CANNON_FOV = 65;
CANNON_TARGET_RADIUS_READY = 80;
CANNON_TARGET_RADIUS_LOCKED = 150;
CANNON_TARGET_OFFSET = (0, 0, 32);
CANNON_TARGET_BONE = "j_spineupper";
CANNON_MAX_RANGE_SQ = 720 * 720;

CANNON_STATE_RELOADING = -1;
CANNON_STATE_READY = 0;
CANNON_STATE_LOCKING = 1;
CANNON_STATE_LOCKED = 2;

CONST_VISIONSET_TRANSITION_TIME = 0.25;
CONST_OUTLINE_COLOR_ENEMY = "red";
CONST_OUTLINE_COLOR_FRIENDLY = "cyan";

CONST_VOICE_CLICK_MIN = 10;
CONST_VOICE_CLICK_MAX = 15;
CONST_TENSION_MUSIC_FREQ = 50;

CONST_EYE_FLASH_MIN_TIME = 500;

CONST_PREDATOR_SUICIDE_RADIUS = 800;
CONST_LAST_STAND_TIME = 8;

juggPredatorInit() {
  maps\mp\killstreaks\_juggernaut::initLevelCustomJuggernaut(::juggPredatorCreate, ::setJuggPredatorClass, ::setJuggPredatorModel, "callout_killed_juggernaut_predator");

  level.mapCustomCrateFunc = ::customCrateFunc;
  level.mapCustomKillstreakFunc = ::customKillstreakFunc;
  level.mapCustomBotKillstreakFunc = ::customBotKillstreakFunc;

  level._effect["predator_uncloak_sparks"] = LoadFX("vfx/_requests/pred/vfx_fade_distortion");
  level._effect["predator_uncloak_chest"] = LoadFX("vfx/_requests/pred/vfx_fade_distortion_chest");
  level._effect["predator_uncloak_limbs"] = LoadFX("vfx/_requests/pred/vfx_fade_distortion_long");
  level._effect["predator_eyes"] = LoadFX("vfx/gameplay/mp/events/vfx_mp_battery3_glowing_eyes");
  level._effect["predator_kill"] = LoadFX("vfx/gameplay/mp/events/vfx_mp_battery3_pred_kill");
  level._effect["predator_self_destruct"] = LoadFX("vfx/_requests/pred/vfx_pred_self_dest");

  level.previousLastStandCallback = level.callbackPlayerLastStand;
  level.callbackPlayerLastStand = ::Callback_PlayerLastStandPredator;

  SetDvarIfUninitialized(CONST_DEBUG_DVAR, 0);
  SetDvarIfUninitialized(CONST_DEBUG_LASTSTAND_DVAR, 0);
}

juggPredatorCreate(juggType) {
  AssertEx(juggType == CONST_JUGG_TYPE);

  self.isJuggernautLevelCustom = true;

  self.juggMoveSpeedScaler = 1.05;
  self maps\mp\gametypes\_class::giveLoadout(self.pers["team"], juggType, false);

  self givePerk("specialty_spygame", false);

  self givePerk("specialty_longersprint", false);
  self givePerk("specialty_falldamage", false);
  self givePerk("specialty_pistoldeath", false);
  self givePerk("specialty_selectivehearing", false);
  self givePerk("specialty_quieter", false);
  self.moveSpeedScaler = 1.05;
  self.healthRegenDisabled = true;
  self.breathingStopTime = 0;

  self playSound("scn_predator_spawn_whip");

  self thread juggTurnOnPredatorAudioZoneUponCreate();

  self SetClientOmnvar("ui_predator_hud", 1);
  self thread watchJuggHostMigrationFinishedInit();
  self SetSurfaceType("fruit");

  self thread juggPredatorOnDeath();
  self thread juggPredatorOnDisconnect();
  self thread juggPredatorOnGameEnded();
  self thread predatorCannonUpdate();
  self thread predatorOnEnemyKilled();
  self thread watchEMPDamage();
  self thread watchEMPEvent();
  self thread predatorVocalClicks();
  self thread predatorPainCry();

  self thread teamPlayerCardSplash("used_juggernaut_predator", self);

  if(!IsAI(self)) {
    self NotifyOnPlayerCommand("player_melee", "+melee_zoom");
  }

  self initTimeStamp("victoryCry");
  self initTimeStamp("painCry");

  self.canUseKillstreakCallback = ::juggPredatorCanUseOtherKillstreaks;
  self.killstreakErrorMsg = ::juggPredatorKillsteakErrorMsg;

  self thread predatorBeginMusic();

  maps\mp\gametypes\_battlechatter_mp::disableBattleChatter(self);
  self playSound("scn_predator_first_raise_shing_npc");

  level notify("update_bombsquad");

  self thread debugDvarWatcher();

  level.predatorUser = self;

  return false;
}

juggTurnOnPredatorAudioZoneUponCreate() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  self SetClientOmnvar("enableCustomAudioZone", true);
}

juggPredatorOnGameEnded() {
  self endon("jugg_removed");
  self endon("disconnect");

  level waittill("game_ended");

  self juggPredatorCleanup();
}

juggPredatorOnDeath() {
  self endon("disconnect");
  level endon("game_ended");

  self waittill_any("death", "joined_team", "joined_spectators", "lost_juggernaut");

  self resetCannonLock();
  self predatorUnsetCloaked(false);

  self juggPredatorCleanup();
}

juggPredatorOnDisconnect() {
  self endon("death");

  self waittill("disconnect");

  thread predatorEndMusic();
}

juggPredatorCleanup() {
  self predatorVisionDisable();

  self SetClientOmnvar("enableCustomAudioZone", false);
  self SetClientOmnvar("ui_predator_hud", 0);
  self SetClientOmnvar("ui_predator_hud_scanline", false);

  self SetSurfaceType("flesh");

  if(!IsAI(self)) {
    self NotifyOnPlayerCommand("", "+speed_throw");
    if(!level.console) {
      self NotifyOnPlayerCommand("", "+toggleads_throw");
    }
    self NotifyOnPlayerCommand("", "+melee");
  }

  self resetTimeStamps();

  self.cloakTimeStamp = undefined;
  self.predatorVisionEnabled = undefined;
  self.canUseKillstreakCallback = undefined;
  self.killstreakErrorMsg = undefined;
  self.predMoveSlowTimeStamp = undefined;
  self.predFastSlowTimeStamp = undefined;
  self.healthRegenDisabled = undefined;
  self.breathingStopTime = undefined;

  thread predatorEndMusic();

  maps\mp\gametypes\_battlechatter_mp::enableBattleChatter(self);

  level notify("update_bombsquad");

  self notify("jugg_removed");
}

setJuggPredatorClass(class) {
  loadout = [];
  loadout["loadoutPrimary"] = "iw6_predatorcannon";
  loadout["loadoutPrimaryBuff"] = "specialty_null";
  loadout["loadoutSecondaryBuff"] = "specialty_null";
  loadout["loadoutEquipment"] = "specialty_null";

  return loadout;
}

setJuggPredatorModel() {
  if(isDefined(self.headModel)) {
    self Detach(self.headModel, "");
    self.headModel = undefined;
  }

  self SetClothType("nylon");

  self.predatorVisionEnabled = false;
  self.isCloaked = true;

  self predatorUnsetCloaked(false, true);
  self thread setInitialCloak();
}

setInitialCloak() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  wait(3);

  self thread predatorVisionToggle();

  if(!self isEMPed()) {
    self predatorSetCloaked(false);
  }

  self thread predatorCloakMovementMonitor();
}

watchJuggHostMigrationFinishedInit() {
  level endon("game_ended");

  while(true) {
    level waittill("host_migration_end");

    if(isDefined(self) && isDefined(self.isJuggernautLevelCustom) && self.isJuggernautLevelCustom) {
      self SetClientOmnvar("enableCustomAudioZone", true);
      self SetClientOmnvar("ui_predator_hud", 1);
    }
  }
}

juggPredatorCanUseOtherKillstreaks(streakName) {
  return false;
}

juggPredatorKillsteakErrorMsg() {
  self IPrintLnBold(&"MP_JUGG_PREDATOR_NO_KILLSTREAKS");
}

tryUseCustomJuggernaut(lifeId, streakName) {
  maps\mp\killstreaks\_juggernaut::giveJuggernaut(streakName);
  game["player_holding_level_killstrek"] = false;
  return true;
}

enable_level_killstreak() {
  maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", CONST_JUGG_TYPE, CONST_JUGG_CRATE_WEIGHT);
}

disable_level_killstreak() {
  maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", CONST_JUGG_TYPE, 0);
}

customCrateFunc() {
  if(!isDefined(game["player_holding_level_killstrek"]))
    game["player_holding_level_killstrek"] = false;

  if(!allowLevelKillstreaks() || game["player_holding_level_killstrek"]) {
    return;
  }
  maps\mp\killstreaks\_airdrop::addCrateType(
    "airdrop_assault",
    CONST_JUGG_TYPE,
    CONST_JUGG_CRATE_WEIGHT,
    maps\mp\killstreaks\_airdrop::juggernautCrateThink,
    maps\mp\killstreaks\_airdrop::get_friendly_juggernaut_crate_model(),
    maps\mp\killstreaks\_airdrop::get_enemy_juggernaut_crate_model(),
    CONST_JUGG_CRATE_STRING
  );
  level thread watch_for_jugg_crate();
}

watch_for_jugg_crate() {
  while(true) {
    level waittill("createAirDropCrate", dropCrate);

    if(isDefined(dropCrate) && isDefined(dropCrate.crateType) && dropCrate.crateType == CONST_JUGG_TYPE) {
      disable_level_killstreak();
      captured = wait_for_capture(dropCrate);

      if(!captured) {
        enable_level_killstreak();
      } else {
        game["player_holding_level_killstrek"] = true;
        break;
      }
    }
  }
}

wait_for_capture(dropCrate) {
  result = watch_for_air_drop_death(dropCrate);
  return !isDefined(result);
}

watch_for_air_drop_death(dropCrate) {
  dropCrate endon("captured");

  dropCrate waittill("death");
  waittillframeend;

  return true;
}

customKillstreakFunc() {
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Event:5/Care Package/Predator\" \"set scr_devgivecarepackage " + CONST_JUGG_TYPE + "; set scr_devgivecarepackagetype airdrop_assault\"\n");
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Event:5/Predator\" \"set scr_givekillstreak " + CONST_JUGG_TYPE + "\"\n");

  AddDebugCommand("bind p \"set scr_givekillstreak " + CONST_JUGG_TYPE + "\"\n");
  AddDebugCommand("bind semicolon \"set " + CONST_DEBUG_LASTSTAND_DVAR + " 2\"\n");

  level.killStreakFuncs[CONST_JUGG_TYPE] = ::tryUseCustomJuggernaut;
}

customBotKillstreakFunc() {
  AddDebugCommand("devgui_cmd\"MP/Bots(Killstreak)/Level Events:5/Predator\" \"set scr_testclients_givekillstreak " + CONST_JUGG_TYPE + "\"\n");
  maps\mp\bots\_bots_ks::bot_register_killstreak_func(CONST_JUGG_TYPE, maps\mp\bots\_bots_ks::bot_killstreak_simple_use);
}

predatorSetCloaked(useWrist) {
  if(!self.isCloaked) {
    self.isCloaked = true;
    self.cloakTimeStamp = GetTime() + CONST_CLOAK_ON_DELAY;

    if(useWrist) {
      self PlayLocalSound("scn_predator_plr_cloak_on");
      self playSound("scn_predator_npc_cloak_on");

    }

    self thread predatorPlayUnloakVfx();
    self SetViewModel("viewhands_mp_predator_proto_cloaked");

    self setModel("fullbody_mp_predator_a_cloaked");

    self givePerk("specialty_blindeye", false);
    self givePerk("specialty_noscopeoutline", false);

    self thread predatorEyeFlashUpdate();
  }
}

predatorUnsetCloaked(useWrist, isFirstTime) {
  if(self.isCloaked) {
    self.isCloaked = false;
    self.cloakTimeStamp = GetTime() + CONST_CLOAK_OFF_DELAY;

    if(useWrist) {
      self PlayLocalSound("scn_predator_plr_cloak_off");
      self playSound("scn_predator_npc_cloak_off");

    } else if(isDefined(self.inWater) && self.inWater) {
      self PlayLocalSound("scn_predator_plr_cloak_off_waterfall");
      self playSound("scn_predator_npc_cloak_off_waterfall");
    }

    self thread predatorPlayUnloakVfx();
    self SetViewModel("viewhands_mp_predator_proto");

    if(IsAlive(self) && !isDefined(isFirstTime)) {
      wait(0.25);
    }

    self setModel("fullbody_mp_predator_a");

    self _unsetPerk("specialty_blindeye");
    self _unsetPerk("specialty_noscopeoutline");
  }
}

predatorPlayUnloakVfx() {
  self endon("death");

  playFXOnTag(getfx("predator_uncloak_chest"), self, "j_spineupper");
  playFXOnTag(getfx("predator_uncloak_chest"), self, "j_spinelower");

  wait(0.05);

  playFXOnTag(getfx("predator_uncloak_sparks"), self, "j_head");
  playFXOnTag(getfx("predator_uncloak_limbs"), self, "j_knee_ri");
  playFXOnTag(getfx("predator_uncloak_limbs"), self, "j_knee_le");

  wait(0.05);

  playFXOnTag(getfx("predator_uncloak_limbs"), self, "j_elbow_ri");
  playFXOnTag(getfx("predator_uncloak_limbs"), self, "j_elbow_le");

  wait(0.05);

  playFXOnTag(getfx("predator_uncloak_sparks"), self, "j_wrist_le");
  playFXOnTag(getfx("predator_uncloak_sparks"), self, "j_wrist_ri");

  wait(0.05);

  playFXOnTag(getfx("predator_uncloak_limbs"), self, "j_ankle_le");
  playFXOnTag(getfx("predator_uncloak_limbs"), self, "j_ankle_ri");
}

predatorUseWristComputer() {
  self _giveWeapon(CONST_PREDATOR_COMPUTER);
  self SwitchToWeapon(CONST_PREDATOR_COMPUTER);

  wait(1);

  self SwitchToWeapon(CONST_CANNON_WEAPON);
  self TakeWeapon(CONST_PREDATOR_COMPUTER);
}

predatorCloakMovementMonitor() {
  self endon("death");
  self endon("disconnect");
  self endon("predator_lastStand");
  level endon("game_ended");

  self.predMoveFastTimeStamp = 0;
  self.predMoveSlowTimeStamp = 0;
  self.predCloakDeniedUntilTime = 0;
  self childthread predatorCloakWaitForForceEnd();

  while(true) {
    if(GetDvarInt(CONST_DEBUG_DVAR, 0) != 0) {
      if(self.isCloaked) {
        self thread predatorUnsetCloaked(true);
      }
      wait(1);
      continue;
    }

    if(self.isCloaked) {
      result = self waittill_any_return("sprint_begin", "predator_force_uncloak");

      if(result == "sprint_begin") {
        self thread predatorUnsetCloaked(true);
      }
    } else {
      if((isDefined(self.inWater) && self.inWater) ||
        self isEMPed()
      ) {
        self.predCloakDeniedUntilTime = GetTime() + CONST_CLOAK_PENALTY_FORCED_OFF;
      } else if(self IsOnGround() &&
        !self IsMantling()
      ) {
        speedSq = LengthSquared(self GetVelocity());
        curTime = GetTime();

        if(speedSq < CONST_MOVEMENT_THRESHOLD && !self IsSprinting()) {
          if(curTime >= self.predCloakDeniedUntilTime) {
            self predatorSetCloaked(true);
            continue;
          }
        } else {
          self.predCloakDeniedUntilTime = curTime + CONST_CLOAK_PENALTY_SPRINT;
        }
      }
    }

    wait(CONST_MOVEMENT_CHECK_FREQ);
  }
}

predatorCloakWaitForInput() {
  self endon("death");
  self endon("disconnect");
  self endon("predator_lastStand");
  level endon("game_ended");

  self childthread predatorCloakWaitForForceEnd();

  while(true) {
    self waittill("predator_cloak_toggle");

    if(GetTime() < self.cloakTimeStamp) {
      continue;
    }
    if(self IsMantling() ||
      self IsMeleeing() ||
      self isEMPed()
    ) {
      wait(0.05);
      continue;
    }

    if(self.isCloaked) {
      self thread predatorUnsetCloaked(true);
    } else {
      if(isDefined(self.inWater) && self.inWater) {
        self thread predatorPlayUnloakVfx();

        wait(0.05);
        continue;
      } else {
        self predatorSetCloaked(true);
      }
    }
  }
}

predatorCloakWaitForForceEnd() {
  while(true) {
    self waittill("predator_force_uncloak");

    while(self IsMantling()

    ) {
      wait 0.05;
    }

    if(self.isCloaked) {
      self predatorUnsetCloaked(false);
    }
  }
}

predatorCloakForceEnd(penaltyTime) {
  self.predCloakDeniedUntilTime = GetTime() + penaltyTime;

  self notify("predator_force_uncloak");
}

predatorCannonUpdate() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("predator_lastStand");

  self.cannonState = CANNON_STATE_READY;

  while(true) {
    if(self.cannonState == CANNON_STATE_READY) {
      newTarget = self findTargetInReticle(CANNON_FOV, CANNON_TARGET_RADIUS_READY);

      if(isDefined(newTarget)) {
        self startCannonLock(newTarget);
      } else {
        wait(0.5);
      }
    } else if(self.cannonState == CANNON_STATE_LOCKING) {
      target = self.cannonTarget;

      if(isDefined(target) &&
        isReallyAlive(target) &&
        self WorldPointInReticle_Circle(target getEye(), CANNON_FOV, CANNON_TARGET_RADIUS_LOCKED) &&
        !(self isEMPed())
      ) {
        if(GetTime() >= self.cannonLockReadyTime) {
          self finalizeCannonLock(self.cannonTarget);
          self childthread waittillCannonFire(self.cannonTarget);
        }
      } else {
        self resetCannonLock(true);
      }

      wait(0.05);
    } else if(self.cannonState == CANNON_STATE_LOCKED) {
      if((!isDefined(self.cannonTarget) || !isReallyAlive(self.cannonTarget)) ||
        Distance2DSquared(self.origin, self.cannonTarget.origin) > CANNON_MAX_RANGE_SQ ||
        self isEMPed()
      ) {
        self resetCannonLock(true);
      }

      wait(0.05);
    } else if(self.cannonState == CANNON_STATE_RELOADING) {
      self reloadCannon();
    }
  }
}

findTargetInReticle(cameraFOV, reticleRadius) {
  targetsInReticle = self findAllTargetsInReticle(cameraFOV, reticleRadius);
  return targetsInReticle[0];
}

findAllTargetsInReticle(cameraFOV, reticleRadius) {
  targetsInReticle = [];
  if(!(self isEMPed())) {
    foreach(participant in level.characters) {
      if(isDefined(participant) &&
        isReallyAlive(participant) &&
        self isEnemy(participant) &&
        !participant _hasPerk("specialty_blindeye") &&
        Distance2DSquared(self.origin, participant.origin) <= CANNON_MAX_RANGE_SQ
      ) {
        targetPoint = participant getEye();

        if(self WorldPointInReticle_Circle(targetPoint, cameraFOV, reticleRadius) &&
          SightTracePassed(self getEye(), targetPoint, false, undefined, undefined)) {
          targetsInReticle[targetsInReticle.size] = participant;
        }
      }
    }

    if(targetsInReticle.size > 1) {
      return SortByDistance(targetsInReticle, self.origin);
    }
  }

  return targetsInReticle;
}

startCannonLock(target) {
  Assert(isDefined(target) && isReallyAlive(target));

  self PlayLocalSound("scn_predator_weap_plr_lock_01");

  self.cannonTarget = target;
  self.cannonLockReadyTime = GetTime() + CANNON_LOCK_TIME * 1000;
  self.cannonState = CANNON_STATE_LOCKING;
  self WeaponLockStart(target);

  self SetClientOmnvar("ui_predator_target_ent", target GetEntityNumber());
  self SetClientOmnvar("ui_predator_hud_reticle", 1);

  self LaserOn();

  self thread playCannonLockSound();
}

playCannonLockSound() {
  self endon("death");
  self endon("disconnect");
  self endon("predatorLockEnded");

  wait(CANNON_LOCK_TIME * 0.5);
}

finalizeCannonLock(target) {
  self.cannonState = CANNON_STATE_LOCKED;

  offset = (0, 0, 0);
  self WeaponLockFinalize(target, offset, false);

  self StopLocalSound("scn_predator_weap_plr_lock_01");
  self PlayLocalSound("scn_predator_weap_plr_lock_03");
  self SetClientOmnvar("ui_predator_hud_reticle", 2);
}

detachReticleVfxFromTarget(target, lockFailed) {
  self SetClientOmnvar("ui_predator_hud_reticle", 0);

  self StopLocalSound("scn_predator_weap_plr_lock_03");

  if(isDefined(lockFailed) && lockFailed) {
    self StopLocalSound("scn_predator_weap_plr_lock_01");
    self PlayLocalSound("scn_predator_weap_plr_lose_lock");
  }
}

waittillCannonFire(target) {
  self endon("predatorLockEnded");

  self waittill("missile_fire", projectile, weapname);

  AssertEx(weapname == CONST_CANNON_WEAPON, "Instead of predator cannon, somehow fired unknown weapon: " + weapName);

  self predatorCloakForceEnd(CONST_CLOAK_PENALTY_CANNON);

  self childthread clearLockOnProjectileImpact(projectile);

  self SetClientOmnvar("ui_predator_hud_reticle", 0);
  self.cannonState = CANNON_STATE_RELOADING;
}

reloadCannon() {
  wait(CANNON_RELOAD_TIME - 0.85);

  self PlayLocalSound("scn_predator_weap_plr_reload_done");

  wait(0.85);

  self SetWeaponAmmoClip(CONST_CANNON_WEAPON, 1);

  self resetCannonLock();
}

resetCannonLock(loseLock) {
  self detachReticleVfxFromTarget(self.cannonTarget, loseLock);

  self.cannonTarget = undefined;
  self.cannonLockReadyTime = undefined;
  self.cannonState = CANNON_STATE_READY;

  self WeaponLockFree();
  self WeaponLockTargetTooClose(false);
  self WeaponLockNoClearance(false);

  self LaserOff();

  self notify("predatorLockEnded");

  self SetClientOmnvar("ui_predator_target_ent", -1);
}

isLocking() {
  return (self PlayerAds() > 0.95);
}

clearLockOnProjectileImpact(projectile) {
  self endon("predatorLockEnded");

  projectile waittill("death");

  self detachReticleVfxFromTarget(self.cannonTarget);

  self notify("predatorLockEnded");
}

predatorVisionToggle() {
  self endon("death");
  self endon("disconnect");
  self endon("predator_lastStand");
  level endon("game_ended");

  if(!IsAI(self)) {
    self NotifyOnPlayerCommand("predator_vision", "+speed_throw");
    if(!level.console) {
      self NotifyOnPlayerCommand("predator_vision", "+toggleads_throw");
    }
  }

  if(!self isEMPed()) {
    self predatorVisionEnable();
  }

  while(true) {
    self waittill("predator_vision");

    if(!self IsThrowingGrenade() &&
      !(self isEMPed())
    ) {
      if(self.predatorVisionEnabled) {
        self predatorVisionDisable();
      } else {
        self predatorVisionEnable();
      }

      wait(0.5);
    }
  }
}

predatorVisionEnable() {
  if(!self.predatorVisionEnabled) {
    self.predatorVisionEnabled = true;

    self playlocalsound("scn_predator_plr_switch_vision_to_predator");
    self SetClientOmnvar("ui_predator_hud_scanline", true);

    self predatorOutlinesOn();
  }
}

predatorVisionDisable() {
  if(self.predatorVisionEnabled) {
    self.predatorVisionEnabled = false;

    self playlocalsound("scn_predator_plr_switch_vision_to_normal");

    self VisionSetNakedForPlayer("", 0.1);

    self SetClientOmnvar("ui_predator_vision", false);
    self predatorOutlinesOff();

    self SetClientOmnvar("ui_predator_hud_scanline", true);
  }
}

predatorOutlinesOn() {
  self SetClientOmnvar("ui_predator_vision", true);

  foreach(character in level.characters) {
    if(isReallyAlive(character) &&
      character != self &&
      (IsAgent(character) || character.sessionstate == "playing")
    ) {
      outlineColor = CONST_OUTLINE_COLOR_FRIENDLY;
      if(self isEnemy(character)) {
        outlineColor = CONST_OUTLINE_COLOR_ENEMY;
      }

      if(!character _hasPerk("specialty_incog")) {
        self thread outlinePredatorTarget(character, outlineColor);
      }
    }
  }

  self thread watchPlayersSpawning();
  self thread watchAgentsSpawning();
  self thread watchOwnerDisconnect();
}

watchForPerkRemoval(targetPlayer) {
  self endon("death");
  self endon("disconnect");
  self endon("endPredatorVision");
  level endon("game_ended");
  targetPlayer endon("death");

  targetPlayer waittill("starting_perks_unset");

  if(self isEnemy(targetPlayer))
    self thread outlinePredatorTarget(targetPlayer, CONST_OUTLINE_COLOR_ENEMY);
  else
    self thread outlinePredatorTarget(targetPlayer, CONST_OUTLINE_COLOR_FRIENDLY);
}

outlinePredatorTarget(target, outlineColor) {
  self endon("death");
  self endon("disconnect");
  self endon("endPredatorVision");
  level endon("game_ended");

  id = outlineEnableForPlayer(target, outlineColor, self, true, "killstreak_personal");
  targetId = target GetEntityNumber();

  level.predatorTargetsEnts[targetId] = target;
  level.predatorTargetsOutlines[targetId] = id;

  target waittill_any("death", "disconnect");

  if(isDefined(target)) {
    outlineDisable(level.predatorTargetsOutlines[targetId], target);
  }

  level.predatorTargetsEnts[targetId] = undefined;
  level.predatorTargetsOutlines[targetId] = undefined;
}

watchPlayersSpawning() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  self endon("endPredatorVision");

  while(true) {
    level waittill("player_spawned", player);

    if(player.sessionstate == "playing" && !player _hasPerk("specialty_incog"))
      self thread watchForPerkRemoval(player);
  }
}

watchAgentsSpawning() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  self endon("endPredatorVision");

  while(true) {
    level waittill("spawned_agent", agent);

    if(self isEnemy(agent)) {
      self thread outlinePredatorTarget(agent, CONST_OUTLINE_COLOR_ENEMY);
    } else {
      self thread outlinePredatorTarget(agent, CONST_OUTLINE_COLOR_FRIENDLY);
    }
  }
}

watchOwnerDisconnect() {
  self endon("death");
  level endon("game_ended");

  self waittill("disconnect");

  predatorOutlinesOff();
}

predatorOutlinesOff() {
  self notify("endPredatorVision");

  if(isDefined(level.predatorTargetsEnts)) {
    foreach(entNum, ent in level.predatorTargetsEnts) {
      if(IsAlive(ent)) {
        outlineDisable(level.predatorTargetsOutlines[entNum], ent);
      }
    }

    level.predatorTargetsEnts = undefined;
    level.predatorTargetsOutlines = undefined;
  }

  if(isDefined(self)) {
    self SetClientOmnvar("ui_predator_vision", false);
  }
}

Callback_PlayerLastStandPredator(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration) {
  if(isDefined(self.isJuggernautLevelCustom) && self.isJuggernautLevelCustom) {
    self resetCannonLock();
    self predatorUnsetCloaked(false);
    self predatorVisionDisable();

    lastStandParams = spawnStruct();
    lastStandParams.eInflictor = eInflictor;
    lastStandParams.attacker = attacker;
    lastStandParams.iDamage = iDamage;
    lastStandParams.attackerPosition = attacker.origin;
    if(attacker == self)
      lastStandParams.sMeansOfDeath = "MOD_SUICIDE";
    else
      lastStandParams.sMeansOfDeath = sMeansOfDeath;

    lastStandParams.sWeapon = sWeapon;
    if(isDefined(attacker) && IsPlayer(attacker) && attacker getCurrentPrimaryWeapon() != "none")
      lastStandParams.sPrimaryWeapon = attacker getCurrentPrimaryWeapon();
    else
      lastStandParams.sPrimaryWeapon = undefined;
    lastStandParams.vDir = vDir;
    lastStandParams.sHitLoc = sHitLoc;
    lastStandParams.lastStandStartTime = GetTime() + CONST_LAST_STAND_TIME * 1000;

    mayDoLastStand = mayDoLastStand(sWeapon, lastStandParams.sMeansOfDeath, sHitLoc);
    if(isDefined(self.endGame))
      mayDoLastStand = false;

    if(!mayDoLastStand) {
      lastStandParams.lastStandStartTime = GetTime();
      self.lastStandParams = lastStandParams;
      self.useLastStandParams = true;
      self _suicide();
      return;
    }

    self.inLastStand = true;
    self.health = 9999;

    foreach(player in level.players) {
      if(isDefined(player) && !IsAI(player)) {
        player PlayLocalSound("scn_predator_plr_vocal_laugh");
      }
    }

    if(isDefined(level.ac130player) && isDefined(attacker) && level.ac130player == attacker)
      level notify("ai_crawling", self);

    self.previousPrimary = self.lastdroppableweapon;
    self.lastStandParams = lastStandParams;

    self TakeAllWeapons();
    self GiveWeapon(CONST_PREDATOR_SELF_DESTRUCT, 0, false);
    self SwitchToWeapon(CONST_PREDATOR_SELF_DESTRUCT);
    self _disableUsability();
    self.inC4Death = true;

    self thread activatePredatorCountdown();
    self thread clearPredatorBombTimer();
    self thread lastStandTimer(CONST_LAST_STAND_TIME);

    self notify("predator_lastStand");

  } else if(isDefined(level.previousLastStandCallback)) {
    [[level.previousLastStandCallback]](eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration);
  }
}

mayDoLastStand(sWeapon, sMeansOfDeath, sHitLoc) {
  if(sMeansOfDeath == "MOD_TRIGGER_HURT")
    return false;

  if(sMeansOfDeath == "MOD_SUICIDE")
    return false;

  return true;
}

activatePredatorCountdown() {
  self endon("disconnect");
  self endon("joined_team");
  self endon("predator_detonate");
  level endon("game_ended");

  timeUntilDialEnd = 3;
  countdownTime = CONST_LAST_STAND_TIME - timeUntilDialEnd;

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(timeUntilDialEnd);

  SetOmnvar("ui_bomb_timer", 4);
  childthread update_pred_ui_timer(countdownTime);
}

update_pred_ui_timer(countdownTime) {
  predatorExplosionEndTime = (countdownTime * 1000) + gettime();
  SetOmnvar("ui_nuke_end_milliseconds", predatorExplosionEndTime);

  level waittill("host_migration_begin");

  timePassed = maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

  if(timePassed > 0) {
    SetOmnvar("ui_nuke_end_milliseconds", predatorExplosionEndTime + timePassed);
  }
}

clearPredatorBombTimer() {
  level endon("game_ended");

  self waittill_any("predator_detonate", "joined_team", "disconnect");

  SetOmnvar("ui_bomb_timer", 0);
}

lastStandTimer(delay) {
  self endon("disconnect");
  self endon("joined_team");
  level endon("game_ended");

  self waittill_any_timeout(delay, "death", "detonate");

  self predatorSuicideNuke();
}

detonateOnUse() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  level endon("game_ended");

  self waittill("detonate");

  self predatorSuicideNuke();
}

detonateOnDeath() {
  self endon("detonate");
  self endon("disconnect");
  self endon("joined_team");
  level endon("game_ended");

  self waittill("death");
  self predatorSuicideNuke();
}

predatorSuicideNuke() {
  self.useLastStandParams = true;

  self playSound("predator_explosion");

  foreach(player in level.players) {
    if(isDefined(player) && !IsAI(player)) {
      player PlayLocalSound("predator_explosion_boom_local");
    }
  }

  self VisionSetNakedForPlayer("coup_sunblind", 0.1);
  wait(0.2);

  playFX(getfx("predator_self_destruct"), self.origin, AnglesToUp(self.angles), anglesToForward(self.angles));
  RadiusDamage(self.origin, CONST_PREDATOR_SUICIDE_RADIUS, 100, 100, self);
  Earthquake(0.1, 3.0, self.origin, CONST_PREDATOR_SUICIDE_RADIUS);

  playPredatorExpVisionSequence();

  level notify("jugg_predator_killed", self);
  self notify("predator_detonate");

  if(IsAlive(self))
    self _suicide();
}

predatorEyeFlashUpdate() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    self waittill("player_melee");

    if(self.isCloaked) {
      self predatorCloakForceEnd(CONST_CLOAK_PENALTY_MELEE);
    } else {
      break;
    }
  }
}

predatorOnEnemyKilled() {
  self endon("death");
  self endon("disconnect");
  self endon("predator_lastStand");
  level endon("game_ended");

  while(true) {
    self waittill("killed_enemy", victim, sWeapon, sMeansOfDeath);

    if(sWeapon == CONST_CANNON_WEAPON) {
      if(isDefined(sMeansofDeath) && sMeansofDeath == "MOD_MELEE") {
        self predatorMeleeKillEffect(victim);
      }

    }

  }
}

predatorMeleeKillEffect(victim) {
  pos = victim.origin + (0, 0, 50);

  self playlocalsound("scn_predator_melee_swing_plr");

  attackDir = self.origin - victim.origin;
  hitPos = victim GetTagOrigin("j_neck");

  playFX(level._effect["predator_kill"], hitPos, VectorNormalize(attackDir), AnglesToUp(victim GetTagAngles("j_neck")));

  if(self checkTimeStamp("victoryCry") && self checkTimeStamp("painCry")) {
    self setTimeStamp("victoryCry", 10000);
    self predatorPlayVo("scn_predator_plr_vocal_victory_cry", "scn_predator_npc_vocal_victory_cry");
  }
}

watchEMPDamage() {
  self endon("death");
  self endon("disconnect");
  self endon("predator_lastStand");
  level endon("game_ended");

  while(true) {
    self waittill("emp_damage", attacker, duration);

    waitframe();

    if(self isEMPed()) {
      self predatorVisionDisable();
      self predatorCloakForceEnd(CONST_CLOAK_PENALTY_FORCED_OFF);
    }
  }
}

watchEMPEvent() {
  self endon("death");
  self endon("disconnect");
  self endon("predator_lastStand");
  level endon("game_ended");

  while(true) {
    level waittill("emp_update");

    if(self isEMPed()) {
      self predatorVisionDisable();
      self predatorCloakForceEnd(CONST_CLOAK_PENALTY_FORCED_OFF);
    }
  }
}

predatorVocalClicks() {
  self endon("death");
  self endon("disconnect");
  self endon("predator_lastStand");
  level endon("game_ended");

  while(true) {
    delay = RandomFloatRange(CONST_VOICE_CLICK_MIN, CONST_VOICE_CLICK_MAX);
    wait(delay);

    if(self checkTimeStamp("victoryCry") && self checkTimeStamp("painCry")) {
      self predatorPlayVo("scn_predator_plr_vocal_clicks", "scn_predator_npc_vocal_clicks");
    }
  }
}

predatorPainCry() {
  self endon("death");
  self endon("disconnect");
  self endon("predator_lastStand");
  level endon("game_ended");

  while(true) {
    self waittill("damage", amount, attacker, direction_vec, point, type);

    if(isDefined(attacker) &&
      attacker != self &&
      amount > 10 &&
      self checkTimeStamp("painCry", 1000)
    ) {
      self predatorPlayVo("scn_predator_plr_vocal_pain", "scn_predator_npc_vocal_pain");
    }

  }
}

predatorPlayVo(playerSound, npcSound) {
  self PlayLocalSound(playerSound);
  self PlaySoundOnMovingEnt(npcSound);
}

predatorBeginMusic() {
  self endon("death");
  self endon("disconnect");
  self endon("predator_lastStand");
  level endon("game_ended");

  maps\mp\gametypes\_music_and_dialog::disableMusic();

  level.predatorMusicEnt = spawn("script_origin", (0, 0, 0));
  level.predatorMusicEnt playSound("mus_predator_music_spawn");

  self childthread predatorTensionMusic();
}

predatorTensionMusic() {
  tensionMusic = ["mus_predator_music_tension_01", "mus_predator_music_tension_02"];
  curIndex = RandomInt(tensionMusic.size);
  while(true) {
    wait(CONST_TENSION_MUSIC_FREQ);

    level.predatorMusicEnt playSound(tensionMusic[curIndex]);

    curIndex++;
    if(curIndex >= tensionMusic.size)
      curIndex = 0;
  }
}

predatorEndMusic() {
  level.predatorMusicEnt StopSounds();

  thread maps\mp\gametypes\_music_and_dialog::enableMusic();

  waitframe();
  level.predatorMusicEnt Delete();
  level.predatorMusicEnt = undefined;
}

playPredatorExpVisionSequence() {
  level.predatorExpTimer = 0;

  level thread delaythread_predatorExp(level.predatorExpTimer, ::predatorExpSlowMo);
  level thread delaythread_predatorExp(level.predatorExpTimer, ::predatorExpVision);
  level thread delaythread_predatorExp(level.predatorExpTimer + 0.5, ::predatorExpDeath);
}

delaythread_predatorExp(delay, func) {
  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(delay);

  thread[[func]]();
}

predatorExpVision() {
  if(is_gen4()) {
    VisionSetPostApply("mpnuke", 0.2);
    maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(0.2);
    VisionSetPostApply("nuke_global_flash", 0.5);
    maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(0.3);
    VisionSetPostApply("", 1);
  } else {
    VisionSetPostApply("mpnuke", 0.7);
    maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(0.5);
    VisionSetPostApply("nuke_global_flash", 0.5);
    maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(0.5);
    VisionSetPostApply("", 0.5);
  }
}

predatorExpSlowMo() {
  SetSlowMotion(1.0, 0.25, 0.5);

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(1);

  SetSlowMotion(0.25, 1, 2.0);
}

predatorExpDeath() {
  maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

  if(isDefined(level.predatorUser)) {
    foreach(character in level.characters) {
      if(predatorExpCanKill(character)) {
        if(IsPlayer(character)) {
          if(isReallyAlive(character)) {
            character thread maps\mp\gametypes\_damage::finishPlayerDamageWrapper(level.predatorUser, level.predatorUser, 999999, 0, "MOD_EXPLOSIVE", "iw6_predatorsuicide_mp", character.origin, (0, 0, 1), "none", 0, 0);
          }
        } else {
          character maps\mp\agents\_agents::agent_damage_finished(level.predatorUser, level.predatorUser, 999999, 0, "MOD_EXPLOSIVE", "iw6_predatorsuicide_mp", character.origin, (0, 0, 1), "none", 0);
        }
      }
    }
  }

  victimTeam = getOtherTeam(level.predatorUser.team);
  level maps\mp\killstreaks\_jammer::destroyGroundObjects(level.predatorUser, victimTeam);
  level maps\mp\killstreaks\_air_superiority::destroyActiveVehicles(level.predatorUser, victimTeam);
}

predatorExpCanKill(player) {
  if(level.teambased) {
    if(player.team == level.predatorUser.team)
      return false;
  } else {
    isKillstreakPlayer = (player == level.predatorUser);
    ownerIsPlayer = isDefined(player.owner) && (player.owner == level.predatorUser);

    if(isKillstreakPlayer || ownerIsPlayer)
      return false;
  }

  return true;
}

initTimeStamp(key) {
  self._eventTimeStamps[key] = 0;
}

checkTimeStamp(key, minDelay) {
  Assert(isDefined(self._eventTimeStamps[key]));

  return (GetTime() >= self._eventTimeStamps[key]);
}

setTimeStamp(key, minDelay) {
  self._eventTimeStamps[key] = GetTime() + minDelay;
}

resetTimeStamps() {
  self._eventTimeStamps = undefined;
}

debugDvarWatcher() {
  self endon("death");
  self endon("disconnect");
  self endon("predator_lastStand");
  level endon("game_ended");

  while(true) {
    value = GetDvarInt(CONST_DEBUG_LASTSTAND_DVAR, 0);
    if(value > 0) {
      self childthread debugLastStand(value);
      SetDvar(CONST_DEBUG_LASTSTAND_DVAR, 0);
    }
    wait(0.5);
  }

}

debugLastStand(waitTime) {
  while(true) {
    wait waitTime;

    hitDir = (1, 0, 0);
    hitOrigin = self.origin;

    damage = 50 + RandomInt(50);
    IPrintLn("taking " + damage + " damage; use demigod to see anims");

    attacker = self;
    foreach(player in level.players) {
      if(isDefined(player) && isReallyAlive(player) && self isEnemy(player)) {
        attacker = player;
        break;
      }
    }

    self FinishPlayerDamage(attacker, attacker, damage, 0, "MOD_EXPLOSIVE", "iw6_honeybadger_mp", hitOrigin, hitDir, "none", 0, 0);
  }
}
# /