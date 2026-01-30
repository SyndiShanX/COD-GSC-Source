/********************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\streak_mp_refraction.gsc
********************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\_audio;

init() {
  level.mp_refraction_killstreak_duration = 25;

  level.mp_refraction_InUse = false;
  level.refraction_turrets_alive = 0;
  level.refraction_turrets_moved_down = 0;
  level.mp_refraction_owner = undefined;

  level.killstreakFuncs["mp_refraction"] = ::tryUseMPRefraction;
  level.mapKillStreak = "mp_refraction";
  level.mapKillstreakPickupString = &"MP_REFRACTION_MAP_KILLSTREAK_PICKUP";
  level.killstreakWieldWeapons["refraction_turret_mp"] = "refraction_turret_mp";

  if(!isDefined(level.sentrySettings)) {
    level.sentrySettings = [];
  }

  level.sentrySettings["refraction_turret"] = spawnStruct();
  level.sentrySettings["refraction_turret"].health = 999999;
  level.sentrySettings["refraction_turret"].maxHealth = 1000;
  level.sentrySettings["refraction_turret"].burstMin = 20;
  level.sentrySettings["refraction_turret"].burstMax = 120;
  level.sentrySettings["refraction_turret"].pauseMin = 0.15;
  level.sentrySettings["refraction_turret"].pauseMax = 0.35;
  level.sentrySettings["refraction_turret"].sentryModeOn = "sentry";
  level.sentrySettings["refraction_turret"].sentryModeOff = "sentry_offline";
  level.sentrySettings["refraction_turret"].timeOut = 90.0;
  level.sentrySettings["refraction_turret"].spinupTime = 0.05;
  level.sentrySettings["refraction_turret"].overheatTime = 8.0;
  level.sentrySettings["refraction_turret"].cooldownTime = 0.1;
  level.sentrySettings["refraction_turret"].fxTime = 0.3;
  level.sentrySettings["refraction_turret"].streakName = "sentry";
  level.sentrySettings["refraction_turret"].weaponInfo = "refraction_turret_mp";
  level.sentrySettings["refraction_turret"].modelBase = "ref_turret_01";
  level.sentrySettings["refraction_turret"].sentryType = "refraction_turret";
  level.sentrySettings["refraction_turret"].modelPlacement = "sentry_minigun_weak_obj";
  level.sentrySettings["refraction_turret"].modelPlacementFailed = "sentry_minigun_weak_obj_red";
  level.sentrySettings["refraction_turret"].modelDestroyed = "sentry_minigun_weak_destroyed";
  level.sentrySettings["refraction_turret"].hintString = &"SENTRY_PICKUP";
  level.sentrySettings["refraction_turret"].headIcon = true;
  level.sentrySettings["refraction_turret"].teamSplash = "used_sentry";
  level.sentrySettings["refraction_turret"].shouldSplash = false;
  level.sentrySettings["refraction_turret"].voDestroyed = "sentry_destroyed";

  level.refraction_turrets = turret_setup();

  level.turret_movement_sound = "mp_refraction_turret_movement1";
  level.turret_movement2_sound = "mp_refraction_turret_movement2";
  level.turret_movement3_sound = "mp_refraction_turret_movement3";
}

tryUseMPRefraction(lifeId, modules) {
  if(isDefined(level.mp_refraction_owner) || level.mp_refraction_InUse) {
    self iPrintLnBold(&"MP_REFRACTION_IN_USE");
    return false;
  }

  if(self isUsingRemote()) {
    return false;
  }

  if(self isAirDenied()) {
    return false;
  }

  if(self isEMPed()) {
    return false;
  }

  result = setRefractionTurretPlayer(self);

  if(isDefined(result) && result) {
    self maps\mp\_matchdata::logKillstreakEvent("mp_refraction", self.origin);
  }

  return result;
}

refractionTurretTimer() {
  self endon("game_ended");

  wait_time = level.mp_refraction_killstreak_duration;

  if(level.mp_refraction_owner _hasPerk("specialty_blackbox") && isDefined(level.mp_refraction_owner.specialty_blackbox_bonus)) {
    wait_time *= level.mp_refraction_owner.specialty_blackbox_bonus;
  }

  while(wait_time > 0) {
    wait(1);
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();
    wait_time -= 1.0;

    if(level.mp_refraction_InUse == false) {
      return;
    }
  }

  for(i = 0; i < level.refraction_turrets.size; i++) {
    level.refraction_turrets[i] notify("fake_refraction_death");
  }
}

monitorRefractionKillstreakOwnership() {
  level endon("game_ended");

  while(level.refraction_turrets_alive > 0 || level.refraction_turrets_moved_down < level.refraction_turrets.size) {
    wait(0.05);
  }

  unsetRefractionTurretPlayer();
}

setRefractionTurretPlayer(player) {
  if(isDefined(level.mp_refraction_owner)) {
    return false;
  }

  level.mp_refraction_InUse = true;
  level.mp_refraction_owner = player;

  thread teamPlayerCardSplash("used_mp_refraction", player);

  sentryType = "refraction_turret";

  for(i = 0; i < level.refraction_turrets.size; i++) {
    level.refraction_turrets_alive++;
    level.refraction_turrets_moved_down = 0;
    Assert(isDefined(level.refraction_turrets[i]));
    level.refraction_turrets[i] sentry_setOwner(player);
    level.refraction_turrets[i] SetLeftArc(45);
    level.refraction_turrets[i] SetRightArc(45);
    level.refraction_turrets[i] SetTopArc(10);
    level.refraction_turrets[i].shouldSplash = false;
    level.refraction_turrets[i].carriedBy = player;
    level.refraction_turrets[i] sentry_setPlaced();
    level.refraction_turrets[i] thread sentry_handleDamage();
    level.refraction_turrets[i] thread sentry_handleDeath();
    level.refraction_turrets[i] thread sentry_laserMark();
    level.refraction_turrets[i] thread aud_turrets_activate();
  }

  level thread refractionTurretTimer();
  level thread monitorRefractionKillstreakOwnership();

  return true;
}

aud_turrets_activate() {
  thread snd_play_in_space("turret_cover_explode", self.origin);
  thread snd_play_in_space("turret_rise_start", self.origin);
}

unsetRefractionTurretPlayer() {
  level.mp_refraction_owner = undefined;
  level.mp_refraction_InUse = false;
}

turret_setup() {
  turrets = getEntArray("turret_killer", "targetname");

  assertEx(isDefined(turrets), "no entities found with targetname of turret killer");

  foreach(turret in turrets) {
    parts = undefined;
    if(isDefined(turret.target)) {
      parts = getEntArray(turret.target, "targetname");
    }

    assertEx(isDefined(parts), "no entities found with targetname of " + turret.target);

    foreach(part in parts) {
      if(isDefined(part.script_noteworthy) && part.script_noteworthy == "turret_lifter") {
        turret.lifter = part;
        continue;
      } else if(isDefined(part.script_noteworthy) && part.script_noteworthy == "hatch") {
        turret.hatch = part;
        continue;
      } else {
        assertMsg("no parts with targetname turret_lifter or hatch were found");
      }
    }

    assertEx(isDefined(turret.lifter), "no lifter entity found for turret");
    assertEx(isDefined(turret.hatch), "no hatch entity found for turret");

    turret.lifter.animUp = "ref_turret_gun_raise";
    turret.lifter.animDown = "ref_turret_gun_lower";
    turret.lifter.IdleUp = "ref_turret_gun_idle_up";
    turret.lifter.IdleDown = "ref_turret_gun_idle_down";

    turret.hatch.animUp = "ref_turret_hatch_raise";
    turret.hatch.animDown = "ref_turret_hatch_lower";
    turret.hatch.IdleUp = "ref_turret_hatch_idle_up";
    turret.hatch.IdleDown = "ref_turret_hatch_idle_down";

    turret.collision = spawnStruct();
    collision = undefined;
    if(isDefined(turret.lifter.target)) {
      collision = getEntArray(turret.lifter.target, "targetname");
    }

    assertEx(isDefined(collision), "no collision entities found with targetname of " + turret.target);

    foreach(collision_part in collision) {
      if(isDefined(collision_part.script_noteworthy)) {
        switch (collision_part.script_noteworthy) {
          case "ref_turret_body_col":
            turret.collision.col_body = collision_part;
            break;
          case "ref_turret_head_col":
            turret.collision.col_head = collision_part;
            break;
          case "ref_turret_leg_r_col":
            turret.collision.col_leg_r = collision_part;
            break;
          case "ref_turret_leg_l_col":
            turret.collision.col_leg_l = collision_part;
            break;
          case "ref_turret_gun_col":
            turret.collision.col_gun = collision_part;
            break;
        }
      }
    }

    turret.sound_tag = spawn_tag_origin();
    turret.sound_tag.origin = turret.origin + (0, 0, 24);
    turret SetDefaultDropPitch(0);
    sentryType = level.sentrySettings["refraction_turret"].sentryType;
    turret sentry_initSentry(sentryType);
    turret makeTurretSolid();
    turret hide();

    turret.laser_tag = spawn("script_model", turret.origin);
    turret.laser_tag setModel("tag_laser");
  }

  return turrets;
}

LinkCollisionToTurret(turret, ShouldLink) {
  if(ShouldLink == false) {
    if(isDefined(turret.collision.col_body)) {
      turret.collision.col_body unlink();
    }
    if(isDefined(turret.collision.col_head)) {
      turret.collision.col_head unlink();
    }
    if(isDefined(turret.collision.col_leg_r)) {
      turret.collision.col_leg_r unlink();
    }
    if(isDefined(turret.collision.col_leg_l)) {
      turret.collision.col_leg_l unlink();
    }
    if(isDefined(turret.collision.col_gun)) {
      turret.collision.col_gun unlink();
    }
  } else if(ShouldLink == true) {
    if(isDefined(turret.collision.col_body)) {
      turret.collision.col_body linkto(self, "tag_origin");
    }
    if(isDefined(turret.collision.col_head)) {
      turret.collision.col_head linkto(self, "tag_aim_animated");
    }
    if(isDefined(turret.collision.col_leg_r)) {
      turret.collision.col_leg_r linkto(self, "arm_r");
    }
    if(isDefined(turret.collision.col_leg_l)) {
      turret.collision.col_leg_l linkto(self, "arm_l");
    }
    if(isDefined(turret.collision.col_gun)) {
      turret.collision.col_gun linkto(self, "tag_barrel");
    }
  }
}

sentry_laserMark() {
  level endon("game_ended");

  self waittill("refraction_turret_moved_up");

  self.laser_tag LaserOn();
  self.laser_tag.origin = self GetTagOrigin("tag_flash");
  self.laser_tag.angles = self GetTagAngles("tag_flash");
  self.laser_tag LinkTo(self, "tag_flash");

  self waittill("fake_refraction_death");

  self.laser_tag LaserOff();
}

turret_moveUP() {
  wait(RandomFloatRange(1, 1.5));

  self.killCamEnt = spawn("script_model", self GetTagOrigin("tag_player"));
  self.killCamEnt SetScriptMoverKillCam("explosive");

  self.lifter LinkCollisionToTurret(self, true);

  alias_array = [];

  alias_array["ref_turret_raise_doors_start"] = "ref_turret_raise_doors_start";
  alias_array["ref_turret_raise_doors_end"] = "ref_turret_raise_doors_end";
  alias_array["ref_turret_down_start"] = "ref_turret_down_start";
  alias_array["ref_turret_down_end"] = "ref_turret_down_end";
  alias_array["ref_turret_doors_close_start"] = "ref_turret_doors_close_start";
  alias_array["ref_turret_doors_close_end"] = "ref_turret_doors_close_end";
  alias_array["ref_turret_barrell_ext_start"] = "ref_turret_barrell_ext_start";
  alias_array["ref_turret_barrell_ext_end"] = "ref_turret_barrell_ext_end";

  self.hatch ScriptModelPlayAnimDeltaMotion(self.hatch.animUp);
  self.lifter ScriptModelPlayAnimDeltaMotion(self.lifter.animUp, "ref_turret_raise_doors_start");
  self.lifter thread snd_play_on_notetrack(alias_array, "ref_turret_raise_doors_start");

  self thread PlayFxTurretMoveUp();
  self thread playAudioTurretMoveUp();

  wait(4.17);

  self.lifter LinkCollisionToTurret(self, false);
  self show();

  self.lifter hide();

  self notify("refraction_turret_moved_up");
}

playFxTurretMoveUp() {
  level thread common_scripts\_exploder::activate_clientside_exploder(1);
  level thread common_scripts\_exploder::activate_clientside_exploder(2);
  level thread common_scripts\_exploder::activate_clientside_exploder(3);
  level thread common_scripts\_exploder::activate_clientside_exploder(4);
  level thread common_scripts\_exploder::activate_clientside_exploder(5);
  level thread common_scripts\_exploder::activate_clientside_exploder(6);
  level thread common_scripts\_exploder::activate_clientside_exploder(7);
  level thread common_scripts\_exploder::activate_clientside_exploder(8);
}

playAudioTurretMoveUp() {
  self.sound_tag thread Play_Sound_on_Tag(level.turret_movement_sound, "tag_origin");

  wait(1);

  self.sound_tag thread Play_Sound_on_Tag(level.turret_movement2_sound, "tag_origin");

  wait(1);

  self.sound_tag thread Play_Sound_on_Tag(level.turret_movement3_sound, "tag_origin");
}

turret_moveDOWN(turret) {
  wait(RandomFloatRange(1, 1.5));

  self.lifter show();
  self.lifter LinkCollisionToTurret(self, true);
  self hide();

  alias_array = [];

  alias_array["ref_turret_raise_doors_start"] = "ref_turret_raise_doors_start";
  alias_array["ref_turret_raise_doors_end"] = "ref_turret_raise_doors_end";
  alias_array["ref_turret_down_start"] = "ref_turret_down_start";
  alias_array["ref_turret_down_end"] = "ref_turret_down_end";
  alias_array["ref_turret_barrell_close_start"] = "ref_turret_barrell_close_start";
  alias_array["ref_turret_barrell_close_end"] = "ref_turret_barrell_close_end";
  alias_array["ref_turret_doors_close_start"] = "ref_turret_doors_close_start";
  alias_array["ref_turret_doors_close_end"] = "ref_turret_doors_close_end";
  alias_array["ref_turret_doors_lock_start"] = "ref_turret_doors_lock_start";
  alias_array["ref_turret_doors_lock_end"] = "ref_turret_doors_lock_end";

  fx_angles = self.hatch.angles + (-90, 0, 0);
  noself_delayCall(4.1, ::PlayFx, getfx("mp_ref_turret_steam_off"), self.hatch.origin, anglesToForward(fx_angles), AnglesToUp(fx_angles));
  self.hatch ScriptModelPlayAnimDeltaMotion(self.hatch.animDown);
  self.lifter ScriptModelPlayAnimDeltaMotion(self.lifter.animDown, "ref_turret_down_end");

  self.lifter thread snd_play_on_notetrack(alias_array, "ref_turret_down_end");

  wait(4.64);
  waittillframeend;
  self.lifter LinkCollisionToTurret(self, false);
  level.refraction_turrets_moved_down++;
}

sentry_setPlaced() {
  self setSentryCarrier(undefined);

  self.carriedBy forceUseHintOff();
  self.carriedBy = undefined;

  if(isDefined(self.owner)) {
    self.owner.isCarrying = false;
  }

  self thread sentry_setActive();

  self playSound("sentry_gun_plant");

  self notify("placed");
}

sentry_setActive() {
  self turret_moveUP();

  self setCanDamage(true);
  self setCanRadiusDamage(true);

  self SetMode(level.sentrySettings[self.sentryType].sentryModeOn);

  if(level.sentrySettings[self.sentryType].headIcon) {
    if(level.teamBased) {
      self maps\mp\_entityheadicons::setTeamHeadIcon(self.team, (0, 0, 95));
    } else {
      self maps\mp\_entityheadicons::setPlayerHeadIcon(self.owner, (0, 0, 95));
    }
  }
}

sentry_initSentry(sentryType) {
  self.sentryType = sentryType;
  self.canBePlaced = true;

  self setModel(level.sentrySettings[self.sentryType].modelBase);
  self makeTurretInoperable();
  self SetDefaultDropPitch(0.0);

  self setTurretModeChangeWait(true);

  self maps\mp\killstreaks\_autosentry::sentry_setInactive();

  self thread maps\mp\killstreaks\_autosentry::sentry_handleUse();
  self thread maps\mp\killstreaks\_autosentry::sentry_attackTargets();
}

sentry_handleDeath() {
  self waittill("fake_refraction_death");

  if(!isDefined(self)) {
    return;
  }

  self maps\mp\killstreaks\_autosentry::sentry_setInactive();
  self SetSentryOwner(undefined);
  self SetTurretMinimapVisible(false);

  self setCanDamage(false);
  self setCanRadiusDamage(false);

  self.laser_tag LaserOff();

  self turret_moveDOWN();

  level.refraction_turrets_alive--;

  if(isDefined(self.killCamEnt)) {
    self.killCamEnt Delete();
  }
}

sentry_setOwner(owner) {
  self.owner = owner;

  self SetSentryOwner(self.owner);
  self SetTurretMinimapVisible(true, self.sentryType);

  if(level.teamBased && isDefined(owner)) {
    self.team = self.owner.team;
    self setTurretTeam(self.team);
  }

  self thread sentry_handleOwnerDisconnect();
}

sentry_handleOwnerDisconnect() {
  level endon("game_ended");
  self endon("fake_refraction_death");

  self.owner waittill_any("disconnect", "joined_team", "joined_spectators");

  self notify("fake_refraction_death");
}

sentry_handleDamage() {
  self endon("fake_refraction_death");
  level endon("game_ended");

  self.health = level.sentrySettings[self.sentryType].health;
  self.maxHealth = level.sentrySettings[self.sentryType].maxHealth;
  self.damageTaken = 0;

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, meansOfDeath, modelName, tagName, partName, iDFlags, weapon);

    if(!maps\mp\gametypes\_weapons::friendlyFireCheck(self.owner, attacker)) {
      continue;
    }

    if(isDefined(iDFlags) && (iDFlags &level.iDFLAGS_PENETRATION)) {
      self.wasDamagedFromBulletPenetration = true;
    }

    modifiedDamage = 0;

    if(isDefined(weapon)) {
      shortWeapon = maps\mp\_utility::strip_suffix(weapon, "_lefthand");

      switch (shortWeapon) {
        case "emp_grenade_mp":
        case "emp_grenade_var_mp":
          self.largeProjectileDamage = false;
          modifiedDamage = self.maxHealth + 1;
          if(isPlayer(attacker)) {
            attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback("sentry");
          }
          break;
        default:
          modifiedDamage = 0;
          break;
      }

      maps\mp\killstreaks\_killstreaks::killstreakHit(attacker, weapon, self);
    }

    self.damageTaken += modifiedDamage;

    if(self.damageTaken >= self.maxHealth) {
      thread maps\mp\gametypes\_missions::vehicleKilled(self.owner, self, undefined, attacker, damage, meansOfDeath, weapon);

      if(isPlayer(attacker) && (!isDefined(self.owner) || attacker != self.owner)) {
        level thread maps\mp\gametypes\_rank::awardGameEvent("kill", attacker, weapon, undefined, meansOfDeath);
      }

      if(isDefined(self.owner)) {
        self.owner thread leaderDialogOnPlayer(level.sentrySettings[self.sentryType].voDestroyed, undefined, undefined, self.origin);
      }

      self notify("fake_refraction_death");
      return;
    }
  }
}