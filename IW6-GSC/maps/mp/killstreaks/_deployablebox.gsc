/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_deployablebox.gsc
**************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

BOX_TIMEOUT_UPDATE_INTERVAL = 1.0;
DEFAULT_USE_TIME = 3000;
BOX_DEFAULT_HEALTH = 999999;

init() {
  if(!isDefined(level.boxSettings)) {
    level.boxSettings = [];
  }
}

beginDeployableViaMarker(lifeId, boxType) {
  self thread watchDeployableMarkerCancel(boxType);
  self thread watchDeployableMarkerPlacement(boxType, lifeId);

  while(true) {
    result = self waittill_any_return("deployable_canceled", "deployable_deployed", "death", "disconnect");

    return (result == "deployable_deployed");
  }
}

tryUseDeployable(lifeId, boxType) {
  self thread watchDeployableMarkerCancel(boxType);
  self thread watchDeployableMarkerPlacement(boxType, lifeId);

  while(true) {
    result = self waittill_any_return("deployable_canceled", "deployable_deployed", "death", "disconnect");

    return (result == "deployable_deployed");
  }
}

watchDeployableMarkerCancel(boxType) {
  self endon("death");
  self endon("disconnect");
  self endon("deployable_deployed");

  boxConfig = level.boxSettings[boxType];
  currentWeapon = self getCurrentWeapon();

  while(currentWeapon == boxConfig.weaponInfo) {
    self waittill("weapon_change", currentWeapon);
  }

  self notify("deployable_canceled");
}

watchDeployableMarkerPlacement(boxType, lifeId) {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("deployable_canceled");

  while(true) {
    self waittill("grenade_fire", marker, weaponName);

    if(isReallyAlive(self)) {
      break;
    } else {
      marker Delete();
    }
  }

  marker MakeCollideWithItemClip(true);

  self notify("deployable_deployed");

  marker.owner = self;
  marker.weaponName = weaponName;
  self.marker = marker;

  marker PlaySoundToPlayer(level.boxSettings[boxType].deployedSfx, self);

  marker thread markerActivate(lifeId, boxType, ::box_setActive);
}

override_box_moving_platform_death(data) {
  self notify("death");
}

markerActivate(lifeId, boxType, usedCallback) {
  self notify("markerActivate");
  self endon("markerActivate");

  self waittill("missile_stuck");
  owner = self.owner;
  position = self.origin;

  if(!isDefined(owner)) {
    return;
  }
  box = createBoxForPlayer(boxType, position, owner);

  data = spawnStruct();
  data.linkParent = self GetLinkedParent();

  if(isDefined(data.linkParent) && isDefined(data.linkParent.model) && DeployableExclusion(data.linkParent.model)) {
    box.origin = data.linkParent.origin;

    grandParent = data.linkParent GetLinkedParent();

    if(isDefined(grandParent))
      data.linkParent = grandParent;
    else
      data.linkParent = undefined;
  }

  data.deathOverrideCallback = ::override_box_moving_platform_death;
  box thread maps\mp\_movers::handle_moving_platforms(data);

  box.moving_platform = data.linkParent;

  box SetOtherEnt(owner);

  wait 0.05;

  box thread[[usedCallback]]();

  self delete();

  if(isDefined(box) && (box touchingBadTrigger())) {
    box notify("death");
  }
}

DeployableExclusion(parentModel) {
  if(parentModel == "mp_satcom")
    return true;
  else if(IsSubStr(parentModel, "paris_catacombs_iron"))
    return true;
  else if(IsSubStr(parentModel, "mp_warhawk_iron_gate"))
    return true;

  return false;
}

isHoldingDeployableBox() {
  curWeap = self GetCurrentWeapon();
  if(isDefined(curWeap)) {
    foreach(deplBoxWeap in level.boxSettings) {
      if(curWeap == deplBoxWeap.weaponInfo)
        return true;
    }
  }

  return false;
}

createBoxForPlayer(boxType, position, owner) {
  assertEx(isDefined(owner), "createBoxForPlayer() called without owner specified");

  boxConfig = level.boxSettings[boxType];

  box = spawn("script_model", position - (0, 0, 1));
  box setModel(boxConfig.modelBase);
  box.health = BOX_DEFAULT_HEALTH;
  box.maxHealth = boxConfig.maxHealth;
  box.angles = owner.angles;
  box.boxType = boxType;
  box.owner = owner;
  box.team = owner.team;
  box.id = boxConfig.id;

  if(isDefined(boxConfig.dpadName)) {
    box.dpadName = boxConfig.dpadName;
  }
  if(isDefined(boxConfig.maxUses)) {
    box.usesRemaining = boxConfig.maxUses;
  }

  box box_setInactive();
  box thread box_handleOwnerDisconnect();
  box addBoxToLevelArray();

  return box;
}

box_setActive(skipOwnerUse) {
  self setCursorHint("HINT_NOICON");
  boxConfig = level.boxSettings[self.boxType];
  self setHintString(boxConfig.hintString);

  self.inUse = false;

  curObjID = maps\mp\gametypes\_gameobjects::getNextObjID();
  Objective_Add(curObjID, "invisible", (0, 0, 0));

  if(!isDefined(self GetLinkedParent()))
    Objective_Position(curObjID, self.origin);
  else
    Objective_OnEntity(curObjID, self);

  Objective_State(curObjID, "active");
  Objective_Icon(curObjID, boxConfig.shaderName);
  self.objIdFriendly = curObjID;

  if(level.teamBased) {
    Objective_Team(curObjID, self.team);
    foreach(player in level.players) {
      if(self.team == player.team && (!isDefined(boxConfig.canUseCallback) || player[[boxConfig.canUseCallback]](self))) {
        self box_SetIcon(player, boxConfig.streakName, boxConfig.headIconOffset);
      }
    }
  } else {
    Objective_Player(curObjID, self.owner GetEntityNumber());

    if(!isDefined(boxConfig.canUseCallback) || self.owner[[boxConfig.canUseCallback]](self)) {
      self box_SetIcon(self.owner, boxConfig.streakName, boxConfig.headIconOffset);
    }
  }

  self MakeUsable();
  self.isUsable = true;
  self setCanDamage(true);
  self thread box_handleDamage();
  self thread box_handleDeath();
  self thread box_timeOut();
  self thread disableWhenJuggernaut();
  self make_entity_sentient_mp(self.team, true);
  if(IsSentient(self)) {
    self SetThreatBiasGroup("DogsDontAttack");
  }

  if(isDefined(self.owner))
    self.owner notify("new_deployable_box", self);

  if(level.teamBased) {
    foreach(player in level.participants) {
      _box_setActiveHelper(player, self.team == player.team, boxConfig.canUseCallback);

      if(!IsAI(player)) {
        self thread box_playerJoinedTeam(player);
      }
    }
  } else {
    foreach(player in level.participants) {
      _box_setActiveHelper(player, isDefined(self.owner) && self.owner == player, boxConfig.canUseCallback);
    }
  }

  level thread teamPlayerCardSplash(boxConfig.splashName, self.owner, self.team);

  self thread box_playerConnected();
  self thread box_agentConnected();

  if(isDefined(boxConfig.onDeployCallback)) {
    self[[boxConfig.onDeployCallback]](boxConfig);
  }

  self thread createBombSquadModel(self.boxType);
}

_box_setActiveHelper(player, bActivate, canUseFunc) {
  if(bActivate) {
    if(!isDefined(canUseFunc) || player[[canUseFunc]](self)) {
      self box_enablePlayerUse(player);
    } else {
      self box_disablePlayerUse(player);

      self thread doubleDip(player);
    }
    self thread boxThink(player);
  } else {
    self box_disablePlayerUse(player);
  }
}

box_playerConnected() {
  self endon("death");

  while(true) {
    level waittill("connected", player);
    self childthread box_waittill_player_spawn_and_add_box(player);
  }
}

box_agentConnected() {
  self endon("death");

  while(true) {
    level waittill("spawned_agent_player", agent);
    self box_addBoxForPlayer(agent);
  }
}

box_waittill_player_spawn_and_add_box(player) {
  player waittill("spawned_player");
  if(level.teamBased) {
    self box_addBoxForPlayer(player);

    self thread box_playerJoinedTeam(player);
  }
}

box_playerJoinedTeam(player) {
  self endon("death");
  player endon("disconnect");

  while(true) {
    player waittill("joined_team");
    if(level.teamBased) {
      self box_addBoxForPlayer(player);
    }
  }
}

box_addBoxForPlayer(player) {
  if(self.team == player.team) {
    self box_enablePlayerUse(player);
    self thread boxThink(player);
    self box_SetIcon(player, level.boxSettings[self.boxType].streakName, level.boxSettings[self.boxType].headIconOffset);
  } else {
    self box_disablePlayerUse(player);
    self maps\mp\_entityheadIcons::setHeadIcon(player, "", (0, 0, 0));
  }
}

box_SetIcon(player, streakName, vOffset) {
  self maps\mp\_entityheadIcons::setHeadIcon(player, getKillstreakOverheadIcon(streakName), (0, 0, vOffset), 14, 14, undefined, undefined, undefined, undefined, undefined, false);
}

box_enablePlayerUse(player) {
  if(IsPlayer(player))
    self EnablePlayerUse(player);

  self.disabled_use_for[player GetEntityNumber()] = false;
}

box_disablePlayerUse(player) {
  if(IsPlayer(player))
    self DisablePlayerUse(player);

  self.disabled_use_for[player GetEntityNumber()] = true;
}

box_setInactive() {
  self makeUnusable();
  self.isUsable = false;
  self maps\mp\_entityheadIcons::setHeadIcon("none", "", (0, 0, 0));
  if(isDefined(self.objIdFriendly))
    _objective_delete(self.objIdFriendly);
}

box_handleDamage() {
  boxConfig = level.boxSettings[self.boxType];

  self maps\mp\gametypes\_damage::monitorDamage(boxConfig.maxHealth, boxConfig.damageFeedback, ::box_handleDeathDamage, ::box_ModifyDamage, true);
}

box_ModifyDamage(attacker, weapon, type, damage) {
  modifiedDamage = damage;

  boxConfig = level.boxSettings[self.boxType];
  if(boxConfig.allowMeleeDamage) {
    modifiedDamage = self maps\mp\gametypes\_damage::handleMeleeDamage(weapon, type, modifiedDamage);
  }

  modifiedDamage = self maps\mp\gametypes\_damage::handleMissileDamage(weapon, type, modifiedDamage);
  modifiedDamage = self maps\mp\gametypes\_damage::handleGrenadeDamage(weapon, type, modifiedDamage);
  modifiedDamage = self maps\mp\gametypes\_damage::handleAPDamage(weapon, type, modifiedDamage, attacker);

  return modifiedDamage;
}

box_handleDeathDamage(attacker, weapon, type, damage) {
  boxConfig = level.boxSettings[self.boxType];
  notifyAttacker = self maps\mp\gametypes\_damage::onKillstreakKilled(attacker, weapon, type, damage, boxconfig.xpPopup, boxConfig.voDestroyed);
  if(notifyAttacker) {
    attacker notify("destroyed_equipment");
  }

}

box_handleDeath() {
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  self box_setInactive();
  self removeBoxFromLevelArray();

  boxConfig = level.boxSettings[self.boxType];
  playFX(boxConfig.deathVfx, self.origin);
  self playSound("mp_killstreak_disappear");

  if(isDefined(boxConfig.deathDamageMax)) {
    owner = undefined;
    if(isDefined(self.owner))
      owner = self.owner;

    RadiusDamage(self.origin + (0, 0, boxConfig.headIconOffset), boxConfig.deathDamageRadius, boxConfig.deathDamageMax, boxConfig.deathDamageMin, owner, "MOD_EXPLOSIVE", boxConfig.deathWeaponInfo);
  }

  self notify("deleting");

  self delete();
}

box_handleOwnerDisconnect() {
  self endon("death");
  level endon("game_ended");

  self notify("box_handleOwner");
  self endon("box_handleOwner");

  self.owner waittill("killstreak_disowned");

  self notify("death");
}

boxThink(player) {
  self endon("death");

  self thread boxCaptureThink(player);

  if(!isDefined(player.boxes)) {
    player.boxes = [];
  }
  player.boxes[player.boxes.size] = self;

  boxConfig = level.boxSettings[self.boxType];

  for(;;) {
    self waittill("captured", capturer);

    if(capturer == player) {
      player PlayLocalSound(boxConfig.onUseSfx);

      if(isDefined(boxConfig.onuseCallback)) {
        player[[boxConfig.onUseCallback]](self);
      }

      if(isDefined(self.owner) && player != self.owner) {
        self.owner thread maps\mp\gametypes\_rank::xpEventPopup(boxConfig.event);
        self.owner thread maps\mp\gametypes\_rank::giveRankXP("support", boxConfig.useXP);
      }

      if(isDefined(self.usesRemaining)) {
        self.usesRemaining--;
        if(self.usesRemaining == 0) {
          self box_leave();
          break;
        }
      }

      if(isDefined(boxConfig.canUseOtherBoxes) && boxConfig.canUseOtherBoxes) {
        foreach(box in level.deployable_box[boxConfig.streakName]) {
          box maps\mp\killstreaks\_deployablebox::box_disablePlayerUse(self);
          box maps\mp\_entityheadIcons::setHeadIcon(self, "", (0, 0, 0));
          box thread maps\mp\killstreaks\_deployablebox::doubleDip(self);
        }
      } else {
        self maps\mp\_entityheadIcons::setHeadIcon(player, "", (0, 0, 0));
        self box_disablePlayerUse(player);
        self thread doubleDip(player);
      }
    }
  }
}

doubleDip(player) {
  self endon("death");
  player endon("disconnect");

  player waittill("death");

  if(level.teamBased) {
    if(self.team == player.team) {
      self box_SetIcon(player, level.boxSettings[self.boxType].streakName, level.boxSettings[self.boxType].headIconOffset);
      self box_enablePlayerUse(player);
    }
  } else {
    if(isDefined(self.owner) && self.owner == player) {
      self box_SetIcon(player, level.boxSettings[self.boxType].streakName, level.boxSettings[self.boxType].headIconOffset);
      self box_enablePlayerUse(player);
    }
  }
}

boxCaptureThink(player) {
  level endon("game_ended");

  while(isDefined(self)) {
    self waittill("trigger", tiggerer);
    if(isDefined(level.boxSettings[self.boxType].noUseKillstreak) && level.boxSettings[self.boxType].noUseKillstreak && isKillstreakWeapon(player GetCurrentWeapon())) {
      continue;
    }

    if(tiggerer == player && self useHoldThink(player, level.boxSettings[self.boxType].useTime)) {
      self notify("captured", player);
    }
  }
}

isFriendlyToBox(box) {
  return (level.teamBased && self.team == box.team);
}

box_timeOut() {
  self endon("death");
  level endon("game_ended");

  boxConfig = level.boxSettings[self.boxType];
  lifeSpan = boxConfig.lifeSpan;
  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(lifeSpan);

  if(isDefined(boxConfig.voGone)) {
    self.owner thread leaderDialogOnPlayer(boxConfig.voGone);
  }

  self box_leave();
}

box_leave() {
  wait(0.05);

  self notify("death");
}

deleteOnOwnerDeath(owner) {
  wait(0.25);
  self linkTo(owner, "tag_origin", (0, 0, 0), (0, 0, 0));

  owner waittill("death");

  box_leave();
}

box_ModelTeamUpdater(showForTeam) {
  self endon("death");

  self hide();

  foreach(player in level.players) {
    if(player.team == showForTeam)
      self showToPlayer(player);
  }

  for(;;) {
    level waittill("joined_team");

    self hide();
    foreach(player in level.players) {
      if(player.team == showForTeam)
        self showToPlayer(player);
    }
  }
}

useHoldThink(player, useTime) {
  self maps\mp\_movers::script_mover_link_to_use_object(player);

  player _disableWeapon();

  player.boxParams = spawnStruct();
  player.boxParams.curProgress = 0;
  player.boxParams.inUse = true;
  player.boxParams.useRate = 0;
  player.boxParams.id = self.id;

  if(isDefined(useTime)) {
    player.boxParams.useTime = useTime;
  } else {
    player.boxParams.useTime = DEFAULT_USE_TIME;
  }

  result = useHoldThinkLoop(player);
  Assert(isDefined(result));

  if(isAlive(player)) {
    player _enableWeapon();
    maps\mp\_movers::script_mover_unlink_from_use_object(player);
  }

  if(!isDefined(self))
    return false;

  player.boxParams.inUse = false;
  player.boxParams.curProgress = 0;

  return (result);
}

useHoldThinkLoop(player) {
  config = player.boxParams;
  while(player isPlayerUsingBox(config)) {
    if(!player maps\mp\_movers::script_mover_use_can_link(self)) {
      player maps\mp\gametypes\_gameobjects::updateUIProgress(config, false);
      return false;
    }

    config.curProgress += (50 * config.useRate);

    if(isDefined(player.objectiveScaler))
      config.useRate = 1 * player.objectiveScaler;
    else
      config.useRate = 1;

    player maps\mp\gametypes\_gameobjects::updateUIProgress(config, true);

    if(config.curProgress >= config.useTime) {
      player maps\mp\gametypes\_gameobjects::updateUIProgress(config, false);
      return (isReallyAlive(player));
    }

    wait 0.05;
  }

  player maps\mp\gametypes\_gameobjects::updateUIProgress(config, false);
  return false;
}

disableWhenJuggernaut() {
  level endon("game_ended");
  self endon("death");

  while(true) {
    level waittill("juggernaut_equipped", player);
    self maps\mp\_entityheadIcons::setHeadIcon(player, "", (0, 0, 0));
    self box_disablePlayerUse(player);
    self thread doubleDip(player);
  }
}

addBoxToLevelArray() {
  level.deployable_box[self.boxType][self GetEntityNumber()] = self;
}

removeBoxFromLevelArray() {
  level.deployable_box[self.boxType][self GetEntityNumber()] = undefined;
}

createBombSquadModel(streakName) {
  config = level.boxSettings[streakName];

  if(isDefined(config.modelBombSquad)) {
    bombSquadModel = spawn("script_model", self.origin);
    bombSquadModel.angles = self.angles;
    bombSquadModel Hide();

    bombSquadModel thread maps\mp\gametypes\_weapons::bombSquadVisibilityUpdater(self.owner);
    bombSquadModel setModel(config.modelBombSquad);
    bombSquadModel LinkTo(self);
    bombSquadModel SetContents(0);
    self.bombSquadModel = bombSquadModel;

    self waittill("death");

    if(isDefined(bombSquadModel)) {
      bombSquadModel delete();
      self.bombSquadModel = undefined;
    }
  }
}

isPlayerUsingBox(box) {
  return (!level.gameEnded && isDefined(box) && isReallyAlive(self) && self UseButtonPressed() && !(self IsOnLadder()) && !(self MeleeButtonPressed()) && !(isDefined(self.throwingGrenade)) && box.curProgress < box.useTime && (!isDefined(self.teleporting) || !self.teleporting));
}