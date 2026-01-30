/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_explosive_gel.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\gametypes\_hostmigration;
#include maps\mp\perks\_perkfunctions;

CONST_Mine_DamageRadius = 192;
CONST_Mine_DamageMax = 100;
CONST_Mine_DamageMin = 100;

watchExplosiveGelUsage() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");

  while(1) {
    self waittill("grenade_fire", grenade, weapname);
    if(weapname == "explosive_gel_mp") {
      if(!IsAlive(self)) {
        grenade delete();
        return;
      }

      thread tryUseExplosiveGel(grenade);
    }
  }
}

init() {
  precacheModel("weapon_c4");
  precacheModel("weapon_c4_bombsquad");

  level.explosiveGelSettings = spawnStruct();
  level.explosiveGelSettings.stuckMesh = "weapon_c4";
  level.explosiveGelSettings.gelBombSquadMesh = "weapon_c4_bombsquad";
  level.explosiveGelSettings.gelExplosionFx = LoadFX("vfx/explosion/frag_grenade_default");
  level.explosiveGelSettings.beacon["enemy"] = loadfx("vfx/lights/light_c4_blink");
  level.explosiveGelSettings.beacon["friendly"] = loadfx("vfx/lights/light_mine_blink_friendly");
}

tryUseExplosiveGel(grenade) {
  thread LaunchExplosiveGel(grenade);

  return true;
}

LaunchExplosiveGel(grenade) {
  thread watchExplosiveGelAltDetonate(grenade);
  Mine = self StickExplosiveGel(grenade);
}

watchExplosiveGelAltDetonate(grenade) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("change_owner");
  grenade endon("missile_stuck");
  grenade endon("death");

  buttonTime = 0;
  for(;;) {
    if(self UseButtonPressed()) {
      buttonTime = 0;
      while(self UseButtonPressed()) {
        buttonTime += 0.05;
        wait(0.05);
      }

      println("pressTime1: " + buttonTime);
      if(buttonTime >= 0.5) {
        continue;
      }

      buttonTime = 0;
      while(!self UseButtonPressed() && buttonTime < 0.5) {
        buttonTime += 0.05;
        wait(0.05);
      }

      println("delayTime: " + buttonTime);
      if(buttonTime >= 0.5) {
        continue;
      }

      self thread EarlyDetonate(grenade);
    }
    wait(0.05);
  }
}

StickExplosiveGel(grenade) {
  self endon("earlyNotify");
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

  ExplosiveGel = spawn("script_model", SpawnOrigin);

  ExplosiveGel.IsUp = IsUp;
  ExplosiveGel.IsForward = IsForward;

  normal = vectornormalize(trace["normal"]);
  angles = vectortoangles(normal);

  angles += (90, 0, 0);

  ExplosiveGel.angles = angles;

  ExplosiveGel setModel(level.explosiveGelSettings.stuckMesh);
  ExplosiveGel.owner = self;
  ExplosiveGel SetOtherEnt(self);
  ExplosiveGel.killCamOffset = (0, 0, 55);
  ExplosiveGel.killCamEnt = spawn("script_model", ExplosiveGel.origin + ExplosiveGel.killCamOffset);
  ExplosiveGel.stunned = false;

  ExplosiveGel.weaponname = "explosive_gel_mp";

  grenade delete();

  level.mines[level.mines.size] = ExplosiveGel;

  ExplosiveGel thread createBombSquadModel(level.explosiveGelSettings.gelBombSquadMesh, "tag_origin", self);
  ExplosiveGel thread mineBeacon();
  ExplosiveGel thread setExplosiveGelTeamHeadIcon(self.team);
  ExplosiveGel thread mineDamageMonitor();
  ExplosiveGel thread ExplosiveGelCountdownDetonation(self);

  return ExplosiveGel;
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
  effect["friendly"] = SpawnFx(level.explosiveGelSettings.beacon["friendly"], self getTagOrigin("tag_fx"));
  effect["enemy"] = SpawnFx(level.explosiveGelSettings.beacon["enemy"], self getTagOrigin("tag_fx"));

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

setExplosiveGelTeamHeadIcon(team) {
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
  playFX(level.explosiveGelSettings.gelExplosionFx, tagOrigin);

  wait(0.05);
  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }

  self Hide();

  self RadiusDamage(self.origin, CONST_Mine_DamageRadius, CONST_Mine_DamageMax, CONST_Mine_DamageMin, attacker, "MOD_EXPLOSIVE");

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

EarlyDetonate(grenade) {
  self notify("earlyNotify");

  tagOrigin = grenade GetTagOrigin("tag_fx");
  playFX(level.explosiveGelSettings.gelExplosionFx, tagOrigin);

  grenade Detonate();
}

apm_mine_deleteKillCamEnt() {
  wait(3);
  self.killCamEnt delete();
  self delete();

  level.mines = array_removeUndefined(level.mines);
}

ExplosiveGelCountdownDetonation(Owner) {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");

  wait 3;

  self notify("mine_triggered");

  self thread mineExplode();
}