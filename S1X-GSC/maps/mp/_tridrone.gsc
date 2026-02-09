/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_tridrone.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\gametypes\_hostmigration;
#include maps\mp\perks\_perkfunctions;

CONST_Mine_TriggerDelay_Perk = 3;
CONST_Mine_TriggerDelay = 1;
CONST_Mine_TimOut = 120;

CONST_Mine_TriggerRadius = 192;
CONST_Mine_TriggerHeight = 192;
CONST_Mine_DamageRadius = 192;
CONST_Mine_DamageMax = 60;
CONST_Mine_DamageMin = 60;

CONST_Mine_ClipSize = 3;

watchTriDroneUsage() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");

  triDroneAmmoInit();

  while(1) {
    self waittill("grenade_fire", grenade, weapname);
    if(weapname == "tri_drone_mp") {
      if(!IsAlive(self)) {
        grenade delete();
        return;
      }

      thread tryUseTriDrone(grenade);
    }
  }
}

init() {
  PreCacheShellShock("flashbang_mp");
  precacheModel("projectile_bouncing_betty_grenade_small");
  precacheModel("projectile_bouncing_betty_grenade_small_bombsquad");

  level.triDroneSettings = spawnStruct();
  level.triDroneSettings.mineCountdown = 1;
  level.triDroneSettings.blastRadius = 132;
  level.triDroneSettings.droneBounceHeight = 128;
  level.triDroneSettings.droneMesh = "projectile_bouncing_betty_grenade_small";
  level.triDroneSettings.droneBombSquadMesh = "projectile_bouncing_betty_grenade_small_bombsquad";
  level.triDroneSettings.droneExplosionFx = LoadFX("vfx/explosion/frag_grenade_default");
  level.triDroneSettings.beacon["enemy"] = loadfx("vfx/lights/light_c4_blink");
  level.triDroneSettings.beacon["friendly"] = loadfx("vfx/lights/light_mine_blink_friendly");
  level.triDroneSettings.dome = LoadFX("vfx/unique/orbital_dome_ground_friendly");
}

triDroneAmmoInit() {
  if(!isDefined(self.triDroneAmmo)) {
    self.triDroneAmmo = 0;
    self thread showAmmoCount();
  }

  self.triDroneAmmo = 0;
  self.triDroneAmmo += CONST_Mine_ClipSize;

  if(!isDefined(self.triDroneDeployed)) {
    self.triDroneDeployed = [];
  }
}

tryUseTriDrone(grenade) {
  if(self.triDroneAmmo <= 0) {
    triDroneAmmoInit();
  }

  if(self.triDroneAmmo > 0) {
    thread LaunchTriDrone(grenade);
    self.triDroneAmmo--;

    if(self.triDroneAmmo >= 1) {
      self GiveWeapon("tri_drone_mp");
    }
  }

  return true;
}

LaunchTriDrone(grenade) {
  Mine = self SpawnMine(grenade);

  self.triDroneDeployed = array_add(self.triDroneDeployed, Mine);

  thread MonitorPlayerDeath(Mine);
}

ActivateGroupedTriDrones(Player) {
  self endon("death");

  foreach(triDrone in Player.triDroneDeployed) {
    if(isDefined(triDrone)) {
      if(triDrone != self) {
        triDrone.trigger notify("trigger");
        wait .25;
      }
    }
  }
}

RemoveGroupedTriDrone() {
  self.owner.triDroneDeployed = array_remove(self.owner.triDroneDeployed, self);
}

MonitorPlayerDeath(Mine) {
  Mine endon("death");
  self waittill("death");

  self.triDroneAmmo = 0;

  if(isDefined(Mine.pickuptrigger)) {
    Mine.pickuptrigger delete();
  }

  Mine delete();
}

SpawnMine(grenade) {
  grenade waittill("missile_stuck");

  Assert(isDefined(self));

  tracedown = bulletTrace(grenade.origin, grenade.origin - (0, 0, 4), false, grenade);

  traceup = bulletTrace(grenade.origin, grenade.origin + (0, 0, 4), false, grenade);

  ForwardAngles = anglesToForward(grenade.angles);

  traceforward = bulletTrace(grenade.origin + (0, 0, 4), (grenade.origin + (ForwardAngles * 4)), false, grenade);

  trace = undefined;
  IsUp = false;
  IsForward = false;

  if(traceforward["surfacetype"] != "none") {
    trace = traceforward;
    IsForward = true;
  } else if(traceup["surfacetype"] != "none") {
    trace = traceup;
    IsUp = true;
  } else if(tracedown["surfacetype"] != "none") {
    trace = tracedown;
  } else {
    trace = tracedown;
  }

  SpawnOrigin = trace["position"];

  if(SpawnOrigin == traceup["position"]) {
    SpawnOrigin += (0, 0, -5);
  }

  TriDrone = spawn("script_model", SpawnOrigin);

  TriDrone.IsUp = IsUp;
  TriDrone.IsForward = IsForward;

  normal = vectornormalize(trace["normal"]);
  angles = vectortoangles(normal);

  angles += (90, 0, 0);

  TriDrone.angles = angles;

  TriDrone setModel(level.triDroneSettings.droneMesh);
  TriDrone.owner = self;
  TriDrone SetOtherEnt(self);
  TriDrone.killCamOffset = (0, 0, 55);
  TriDrone.killCamEnt = spawn("script_model", TriDrone.origin + TriDrone.killCamOffset);
  TriDrone.stunned = false;

  TriDrone.weaponname = "tri_drone_mp";

  grenade delete();

  level.mines[level.mines.size] = TriDrone;

  TriDrone thread createBombSquadModel(level.triDroneSettings.droneBombSquadMesh, "tag_origin", self);
  TriDrone thread mineBeacon();
  TriDrone thread setTriDroneTeamHeadIcon(self.team);
  TriDrone thread mineDamageMonitor();
  TriDrone thread mineProximityTrigger(self);
  TriDrone thread mineSelfDestruct();
  TriDrone thread deleteMineOnTeamSwitch(self);
  TriDrone thread handleEMP(self, "apm_mine");

  return TriDrone;
}

showDebugRadius() {
  effect["dome"] = SpawnFx(level.triDroneSettings.dome, self getTagOrigin("tag_fx"));
  TriggerFx(effect["dome"]);

  self waittill("death");

  effect["dome"] delete();
}

showAmmoCount() {
  self endon("disconnect");

  while(1) {
    if("tri_drone_mp" == self GetLethalWeapon()) {
      self SetClientOmnvar("ui_tri_drone_count", self.triDroneAmmo);
    }

    waitframe();
  }
}

createBombSquadModel(modelName, tagName, owner) {
  apm_bombSquadModel = spawn("script_model", (0, 0, 0));
  apm_bombSquadModel hide();
  wait(0.05);

  apm_bombSquadModel thread maps\mp\gametypes\_weapons::bombSquadVisibilityUpdater(owner);
  apm_bombSquadModel setModel(modelName);
  apm_bombSquadModel linkTo(self, tagName, (0, 0, 0), (0, 0, 0));
  apm_bombSquadModel SetContents(0);

  self waittill("death");

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  apm_bombSquadModel delete();
}

mineBeacon() {
  effect["friendly"] = SpawnFx(level.triDroneSettings.beacon["friendly"], self getTagOrigin("tag_fx"));
  effect["enemy"] = SpawnFx(level.triDroneSettings.beacon["enemy"], self getTagOrigin("tag_fx"));

  self thread mineBeaconTeamUpdater(effect);
  self waittill("death");

  effect["friendly"] delete();
  effect["enemy"] delete();
}

mineBeaconTeamUpdater(effect, effect_flare) {
  self endon("death");

  ownerTeam = self.owner.team;

  wait(0.05);

  TriggerFx(effect["friendly"]);
  TriggerFx(effect["enemy"]);

  for(;;) {
    effect["friendly"] Hide();
    effect["enemy"] Hide();

    foreach(player in level.players) {
      if(level.teamBased) {
        if(player.team == ownerTeam) {
          effect["friendly"] ShowToPlayer(player);
        } else {
          effect["enemy"] ShowToPlayer(player);
        }
      } else {
        if(player == self.owner) {
          effect["friendly"] ShowToPlayer(player);
        } else {
          effect["enemy"] ShowToPlayer(player);
        }
      }
    }

    level waittill_either("joined_team", "player_spawned");
  }
}

setTriDroneTeamHeadIcon(team) {
  self endon("death");
  wait .05;
  if(level.teamBased) {
    if(self.IsUp == true || self.IsForward == true) {
      self maps\mp\_entityheadicons::setTeamHeadIcon(team, (0, 0, 28), undefined, true);
    } else {
      self maps\mp\_entityheadicons::setTeamHeadIcon(team, (0, 0, 28));
    }
  } else if(isDefined(self.owner)) {
    if(self.IsUp == true) {
      self maps\mp\_entityheadicons::setPlayerHeadIcon(self.owner, (28, 0, 28));
    } else {
      self maps\mp\_entityheadicons::setPlayerHeadIcon(self.owner, (0, 0, 28));
    }
  }
}

mineDamageMonitor() {
  self endon("mine_triggered");
  self endon("mine_selfdestruct");
  self endon("death");

  self setCanDamage(true);
  self.maxhealth = 100000;
  self.health = self.maxhealth;

  attacker = undefined;

  while(1) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelName, tagName, partName, iDFlags, weapon);

    if(!isPlayer(attacker)) {
      continue;
    }

    if(!maps\mp\gametypes\_weapons::friendlyFireCheck(self.owner, attacker)) {
      continue;
    }

    if(isDefined(weapon)) {
      shortWeapon = maps\mp\_utility::strip_suffix(weapon, "_lefthand");

      switch (shortWeapon) {
        case "smoke_grenade_mp":
        case "smoke_grenade_var_mp":
          continue;
      }
    }
    break;
  }

  self notify("mine_destroyed");

  self RemoveGroupedTriDrone();

  if(isDefined(type) && (isSubStr(type, "MOD_GRENADE") || isSubStr(type, "MOD_EXPLOSIVE"))) {
    self.wasChained = true;
  }

  if(isDefined(iDFlags) && (iDFlags &level.iDFLAGS_PENETRATION)) {
    self.wasDamagedFromBulletPenetration = true;
  }

  self.wasDamaged = true;

  if(isPlayer(attacker)) {
    attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback("bouncing_betty");
  }

  if(level.teamBased) {
    if(isDefined(attacker) && isDefined(attacker.pers["team"]) && isDefined(self.owner) && isDefined(self.owner.pers["team"])) {
      if(attacker.pers["team"] != self.owner.pers["team"]) {
        attacker notify("destroyed_explosive");
      }
    }
  } else {
    if(isDefined(self.owner) && isDefined(attacker) && attacker != self.owner) {
      attacker notify("destroyed_explosive");
    }
  }

  self thread mineExplode(attacker);
}

mineExplode(attacker) {
  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }

  if(!isDefined(attacker)) {
    attacker = self.owner;
  }

  self playSound("null");

  tagOrigin = self GetTagOrigin("tag_fx");
  playFX(level.triDroneSettings.droneExplosionFx, tagOrigin);

  wait(0.05);
  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }

  self Hide();

  self RadiusDamage(self.origin, CONST_Mine_DamageRadius, CONST_Mine_DamageMax, CONST_Mine_DamageMin, attacker, "MOD_EXPLOSIVE", "bouncingbetty_mp");

  foreach(player in level.players) {
    DistanceFromTriDrone = Distance(self.origin, player.origin);
    if(DistanceFromTriDrone < CONST_Mine_DamageRadius) {
      player ShellShock("flashbang_mp", 2.5);
    }
  }

  if(isDefined(self.owner) && isDefined(level.leaderDialogOnPlayer_func)) {
    self.owner thread[[level.leaderDialogOnPlayer_func]]("mine_destroyed", undefined, undefined, self.origin);
  }

  wait(0.2);
  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }

  self thread apm_mine_deleteKillCamEnt();

  self notify("death");

  if(isDefined(self.pickuptrigger)) {
    self.pickuptrigger delete();
  }

  self hide();
}

apm_mine_deleteKillCamEnt() {
  wait(3);
  self.killCamEnt delete();
  self delete();

  level.mines = array_removeUndefined(level.mines);
}

equipmentWatchUse() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("change_owner");

  self.pickupTrigger setCursorHint("HINT_NOICON");
  owner = self.pickupTrigger.owner;
  self equipmentEnableUse(owner);

  for(;;) {
    self.pickupTrigger waittill("trigger", owner);

    owner playLocalSound("scavenger_pack_pickup");

    owner.triDroneAmmo++;

    if(owner.triDroneAmmo == 1) {
      owner GiveWeapon("tri_drone_mp");
    }

    if(isDefined(self.pickuptrigger)) {
      self.pickuptrigger delete();
    }

    self.killCamEnt delete();
    self delete();

    level.mines = array_removeUndefined(level.mines);
  }
}

equipmentEnableUse(owner) {
  self notify("equipmentWatchUse");

  self endon("spawned_player");
  self endon("disconnect");
  self endon("equipmentWatchUse");
  self endon("change_owner");

  self.pickupTrigger setCursorHint("HINT_NOICON");

  self.pickupTrigger setHintString(&"MP_PICKUP_TRI_DRONE");

  self.pickupTrigger setSelfUsable(owner);
}

equipmentDisableUse(owner) {
  self.trigger setHintString("");

  self.trigger setSelfUnusuable();
}

mineProximityTrigger(Owner) {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");

  wait(2);

  self.pickupTrigger = spawn("script_origin", self.origin);
  self.pickupTrigger.owner = Owner;
  self thread equipmentWatchUse();

  trigger = spawn("trigger_radius", (self.origin + (0, 0, ((CONST_Mine_TriggerHeight / 2) * -1))), 0, CONST_Mine_TriggerRadius, CONST_Mine_TriggerHeight);
  trigger.owner = self;

  self.trigger = trigger;

  self thread mineDeleteTrigger(trigger);

  player = undefined;
  while(1) {
    trigger waittill("trigger", player);

    if(!isDefined(player)) {
      break;
    }

    if(getdvarint("scr_minesKillOwner") != 1) {
      if(isDefined(self.owner)) {
        if(player == self.owner) {
          continue;
        }
        if(isDefined(player.owner) && player.owner == self.owner) {
          continue;
        }
      }

      if(!maps\mp\gametypes\_weapons::friendlyFireCheck(self.owner, player, 0)) {
        continue;
      }
    }

    if(lengthsquared(player getEntityVelocity()) < 10) {
      continue;
    }

    if(player damageConeTrace(self.origin, self) > 0) {
      break;
    }
  }

  self RemoveGroupedTriDrone();

  self notify("mine_triggered");

  self playSound("claymore_activated");

  self playSound("mine_betty_spin");
  playFX(level.mine_launch, self.origin);

  forward = AnglesToUp(self.angles);
  explodePos = self.origin + (forward * 64);

  self MoveTo(explodePos, 0.75, 0, .25);
  self.killCamEnt MoveTo(explodePos + self.killCamOffset, 0.75, 0, .25);

  self RotateVelocity((0, 750, 32), 0.7, 0, .65);
  self thread playSpinnerFX();

  if(isPlayer(player) && player _hasPerk("specialty_class_engineer")) {
    player notify("triggered_mine");
    wait CONST_Mine_TriggerDelay_Perk;
  } else {
    wait CONST_Mine_TriggerDelay;
  }

  self thread mineExplode();
}

playSpinnerFX() {
  self endon("death");

  timer = gettime() + 1000;

  while(gettime() < timer) {
    wait .05;
    playFXOnTag(level.mine_spin, self, "tag_fx_spin1");
    playFXOnTag(level.mine_spin, self, "tag_fx_spin3");
    wait .05;
    playFXOnTag(level.mine_spin, self, "tag_fx_spin2");
    playFXOnTag(level.mine_spin, self, "tag_fx_spin4");
  }
}

mineDeleteTrigger(trigger) {
  self waittill_any("mine_triggered", "mine_destroyed", "death");

  trigger delete();
}

mineSelfDestruct() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");

  wait(CONST_Mine_TimOut);

  self notify("mine_selfdestruct");

  if(isDefined(self.killCamEnt)) {
    self.killCamEnt delete();
  }

  playFX(level._effect["equipment_explode"], self.origin);
  self delete();
}

deleteMineOnTeamSwitch(player) {
  level endon("game_ended");
  player endon("disconnect");
  self endon("death");

  player waittill("joined_team");
  self Delete();
  self notify("death");
}

handleEMP(owner, type) {
  self endon("death");

  if(owner isEMPed()) {
    self notify("death");

    if(type == "apm_mine") {
      playFX(level._effect["equipment_explode"], self.origin);
      self Delete();
    }
    return;
  }

  for(;;) {
    level waittill("emp_update");

    if(!owner isEMPed()) {
      continue;
    }

    if(type == "apm_mine") {
      playFX(level._effect["equipment_explode"], self.origin);
      self Delete();
    }

    self notify("death");
  }
}