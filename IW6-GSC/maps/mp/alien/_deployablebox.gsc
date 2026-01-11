/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_deployablebox.gsc
********************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\alien\_utility;

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

    if(isDefined(grandParent)) {
      data.linkParent = grandParent;
    }
    else {
      data.linkParent = undefined;
    }
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
  if(parentModel == "weapon_alien_laser_drill") {
    return true;
  }
  else if(IsSubStr(parentModel, "crafting")) {
    return true;
  }
  else if(IsSubStr(parentModel, "scorpion_body")) {
    return true;
  }

  return false;
}

isHoldingDeployableBox() {
  curWeap = self GetCurrentWeapon();
  if(isDefined(curWeap)) {
    foreach(deplBoxWeap in level.boxSettings) {
      if(curWeap == deplBoxWeap.weaponInfo) {
        return true;
      }
    }
  }

  return false;
}

get_box_icon(resourceType, dpadName, upgrade_rank) {
  return level.alien_combat_resources[resourceType][dpadName].upgrades[upgrade_rank].dpad_icon;
}

get_resource_type(dpadName) {
  if(!isDefined(dpadName)) {
    return undefined;
  }

  foreach(resource_type_name, resource_type in level.alien_combat_resources) {
    if(isDefined(resource_type[dpadName])) {
      return resource_type_name;
    }
  }

  return undefined;
}

createBoxForPlayer(boxType, position, owner) {
  assertEx(isDefined(owner), "createBoxForPlayer() called without owner specified");

  boxConfig = level.boxSettings[boxType];

  box = spawn("script_model", position);
  box setModel(boxConfig.modelBase);
  box.health = BOX_DEFAULT_HEALTH;
  box.maxHealth = boxConfig.maxHealth;
  box.angles = owner.angles;
  box.boxType = boxType;
  box.owner = owner;
  box.team = owner.team;
  if(isDefined(boxConfig.dpadName)) {
    box.dpadName = boxConfig.dpadName;
  }
  if(isDefined(boxConfig.maxUses)) {
    box.usesRemaining = boxConfig.maxUses;
  }

  player = box.owner;
  resource_type = get_resource_type(box.dpadName);

  if(is_combat_resource(resource_type)) {
    box.upgrade_rank = player maps\mp\alien\_persistence::get_upgrade_level(resource_type);
    box.icon_name = get_box_icon(resource_type, box.dpadName, box.upgrade_rank);
  } else {
    AssertEx(isDefined(boxConfig.icon_name), "For non-combat-resource box, the .icon_name must be specified in the boxConfig struct");

    box.upgrade_rank = 0;
    box.icon_name = boxConfig.icon_name;
  }

  level.alienBBData["team_item_deployed"]++;
  player maps\mp\alien\_persistence::eog_player_update_stat("deployables", 1);

  box box_setInactive();
  box thread box_handleOwnerDisconnect();
  box addBoxToLevelArray();

  return box;
}

is_combat_resource(resource_type) {
  return isDefined(resource_type);
}

box_setActive(skipOwnerUse) {
  self setCursorHint("HINT_NOICON");
  boxConfig = level.boxSettings[self.boxType];
  self setHintString(boxConfig.hintString);

  self.inUse = false;

  curObjID = maps\mp\gametypes\_gameobjects::getNextObjID();
  Objective_Add(curObjID, "invisible", (0, 0, 0));
  Objective_Position(curObjID, self.origin);
  Objective_State(curObjID, "active");

  if(isDefined(boxConfig.shaderName)) {
    Objective_Icon(curObjID, boxConfig.shaderName);
  }

  self.objIdFriendly = curObjID;

  if((!isDefined(skipOwnerUse) || !skipOwnerUse) && isDefined(boxConfig.onuseCallback) &&
    (!isDefined(boxconfig.canUseCallback) || (self.owner[[boxConfig.canUseCallback]]()))
  ) {
    if(isReallyAlive(self.owner)) {
      self.owner[[boxConfig.onUseCallback]](self);
    }
  }

  if(level.teamBased) {
    Objective_Team(curObjID, self.team);
    foreach(player in level.players) {
      if(self.team == player.team &&
        (!isDefined(boxConfig.canUseCallback) || player[[boxConfig.canUseCallback]](self))
      ) {
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

  self make_entity_sentient_mp(self.team, true);

  if(isDefined(self.owner)) {
    self.owner notify("new_deployable_box", self);
  }

  if(level.teamBased) {
    foreach(player in level.participants) {
      _box_setActiveHelper(player, self.team == player.team, boxConfig.canUseCallback);
    }
  } else {
    foreach(player in level.participants) {
      _box_setActiveHelper(player, isDefined(self.owner) && self.owner == player, boxConfig.canUseCallback);
    }
  }

  if((!isDefined(self.air_dropped) || !self.air_dropped) && !isPlayingSolo()) {
    level thread teamPlayerCardSplash(boxConfig.splashName, self.owner, self.team);
  }

  self thread box_playerConnected();
  self thread box_agentConnected();
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
  self maps\mp\_entityheadIcons::setHeadIcon(player, self.icon_name, (0, 0, vOffset), 14, 14, undefined, undefined, undefined, undefined, undefined, false);
}

box_enablePlayerUse(player) {
  if(IsPlayer(player)) {
    self EnablePlayerUse(player);
  }

  self.disabled_use_for[player GetEntityNumber()] = false;
}

box_disablePlayerUse(player) {
  if(IsPlayer(player)) {
    self DisablePlayerUse(player);
  }

  self.disabled_use_for[player GetEntityNumber()] = true;
}

box_setInactive() {
  self makeUnusable();
  self.isUsable = false;
  self maps\mp\_entityheadIcons::setHeadIcon("none", "", (0, 0, 0));
  if(isDefined(self.objIdFriendly)) {
    _objective_delete(self.objIdFriendly);
  }
}

box_handleDamage() {
  boxConfig = level.boxSettings[self.boxType];

  self maps\mp\gametypes\_damage::monitorDamage(
    boxConfig.maxHealth,
    boxConfig.damageFeedback, ::boxModifyDamage, ::boxHandleDeathDamage,
    true
  );
}

boxModifyDamage(attacker, weapon, type, damage) {
  modifiedDamage = damage;

  if(IsExplosiveDamageMOD(type)) {
    modifiedDamage = damage * 1.5;
  }

  modifiedDamage = self maps\mp\gametypes\_damage::handleMeleeDamage(weapon, type, modifiedDamage);
  modifiedDamage = self maps\mp\gametypes\_damage::handleMissileDamage(weapon, type, modifiedDamage);
  modifiedDamage = self maps\mp\gametypes\_damage::handleAPDamage(weapon, type, modifiedDamage, attacker);

  return modifiedDamage;
}

boxHandleDeathDamage(attacker, weapon, type, damage) {
  boxConfig = level.boxSettings[self.boxType];
  self maps\mp\gametypes\_damage::onKillstreakKilled(attacker, weapon, type, damage, boxConfig.xpPopup, boxConfig.voDestroyed);
}

box_handleDeath() {
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  self box_setInactive();
  self removeBoxFromLevelArray();

  boxConfig = level.boxSettings[self.boxType];
  playFX(getfx("deployablebox_crate_destroy"), self.origin);

  if(isDefined(boxConfig.deathDamageMax)) {
    owner = undefined;
    if(isDefined(self.owner)) {
      owner = self.owner;
    }

    RadiusDamage(self.origin + (0, 0, boxConfig.headIconOffset),
      boxConfig.deathDamageRadius,
      boxConfig.deathDamageMax,
      boxConfig.deathDamageMin,
      owner,
      "MOD_EXPLOSIVE",
      boxConfig.deathWeaponInfo
    );
  }

  wait(0.1);

  self notify("deleting");

  self delete();
}

box_handleOwnerDisconnect() {
  self endon("death");
  level endon("game_ended");

  self notify("box_handleOwner");
  self endon("box_handleOwner");

  old_owner = self.owner;
  self.owner waittill("killstreak_disowned");

  if(isDefined(self.air_dropped) && self.air_dropped) {
    foreach(player in level.players) {
      if(!isDefined(player) || (isDefined(old_owner) && old_owner == player)) {
        continue;
      }
      self.owner = player;
      self thread box_handleOwnerDisconnect();
      return;
    }
  }

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

        if(maps\mp\alien\_utility::is_chaos_mode()) {
          maps\mp\alien\_chaos::update_pickup_deployable_box_event();
        }
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

      self maps\mp\_entityheadIcons::setHeadIcon(player, "", (0, 0, 0));
      self box_disablePlayerUse(player);
      self thread doubleDip(player);
    }
  }
}

doubleDip(player) {
  self endon("death");
  player endon("disconnect");

  if(isDefined(self.air_dropped) && self.air_dropped) {
    return;
  }
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
  while(isDefined(self)) {
    self waittill("trigger", tiggerer);
    if(is_aliens()) {
      if([
          [level.boxCaptureThink_alien_func]
        ](tiggerer))
        continue;
    }
    if(is_chaos_mode()) {
      switch (self.boxType) {
        case "medic_skill":
        case "specialist_skill":
        case "tank_skill":
        case "engineer_skill":
          if(is_true(tiggerer.hasChaosClassSkill)) {
            tiggerer maps\mp\_utility::setLowerMessage("cant_use", &"ALIEN_CHAOS_CANT_PICKUP_BONUS", 3);
            continue;
          } else if(is_true(tiggerer.chaosClassSkillInUse)) {
            tiggerer maps\mp\_utility::setLowerMessage("skill_in_use", &"ALIEN_CHAOS_SKILL_IN_USE", 3);
            continue;
          }
          break;
        case "combo_freeze":
          if(is_true(tiggerer.hasComboFreeze)) {
            tiggerer maps\mp\_utility::setLowerMessage("cant_use", &"ALIEN_CHAOS_CANT_PICKUP_BONUS", 3);
            continue;
          }
          break;
        default:
          break;
      }
    }

    if(tiggerer == player &&
      self useHoldThink(player, level.boxSettings[self.boxType].useTime)
    ) {
      self notify("captured", player);
    }
  }
}

isFriendlyToBox(box) {
  return (level.teamBased &&
    self.team == box.team);
}

box_timeOut() {
  self endon("death");
  level endon("game_ended");

  if(box_should_leave_immediately()) {
    wait 0.05;
  } else {
    lifeSpan = level.boxSettings[self.boxType].lifeSpan;
    maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(lifeSpan);
  }

  self box_leave();
}

box_should_leave_immediately() {
  if((self.boxtype == "deployable_ammo" && self.upgrade_rank == 4) || (self.boxtype == "deployable_specialammo_comb" && self.upgrade_rank == 4)) {
    return false;
  }

  if(maps\mp\alien\_utility::isPlayingSolo() && (!isDefined(self.air_dropped) || !self.air_dropped)) {
    return true;
  }

  return false;
}

box_leave() {
  playFX(getfx("deployablebox_crate_destroy"), self.origin);

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
    if(player.team == showForTeam) {
      self showToPlayer(player);
    }
  }

  for(;;) {
    level waittill("joined_team");

    self hide();
    foreach(player in level.players) {
      if(player.team == showForTeam) {
        self showToPlayer(player);
      }
    }
  }
}

useHoldThink(player, useTime) {
  if(IsPlayer(player)) {
    player playerLinkTo(self);
  }
  else {
    player LinkTo(self);
  }
  player playerLinkedOffsetEnable();

  player.boxParams = spawnStruct();
  player.boxParams.curProgress = 0;
  player.boxParams.inUse = true;
  player.boxParams.useRate = 0;

  if(isDefined(useTime)) {
    player.boxParams.useTime = useTime;
  } else {
    player.boxParams.useTime = DEFAULT_USE_TIME;
  }

  player disable_weapon_timeout((useTime + 0.05), "deployable_weapon_management");

  if(IsPlayer(player)) {
    player thread personalUseBar(self);
  }

  result = useHoldThinkLoop(player);
  assert(isDefined(result));

  if(isAlive(player)) {
    player enable_weapon_wrapper("deployable_weapon_management");
    player unlink();
  }

  if(!isDefined(self)) {
    return false;
  }

  player.boxParams.inUse = false;
  player.boxParams.curProgress = 0;

  return (result);
}

personalUseBar(object) {
  self endon("disconnect");

  useBar = createPrimaryProgressBar(0, 25);
  useBarText = createPrimaryProgressBarText(0, 25);
  useBarText setText(level.boxSettings[object.boxType].capturingString);

  lastRate = -1;
  while(isReallyAlive(self) && isDefined(object) && self.boxParams.inUse && object.isUsable && !level.gameEnded) {
    if(lastRate != self.boxParams.useRate) {
      if(self.boxParams.curProgress > self.boxParams.useTime) {
        self.boxParams.curProgress = self.boxParams.useTime;
      }

      useBar updateBar(self.boxParams.curProgress / self.boxParams.useTime, (1000 / self.boxParams.useTime) * self.boxParams.useRate);

      if(!self.boxParams.useRate) {
        useBar hideElem();
        useBarText hideElem();
      } else {
        useBar showElem();
        useBarText showElem();
      }
    }
    lastRate = self.boxParams.useRate;
    wait(0.05);
  }

  useBar destroyElem();
  useBarText destroyElem();
}

useHoldThinkLoop(player) {
  while(!level.gameEnded && isDefined(self) && isReallyAlive(player) && player useButtonPressed() && player.boxParams.curProgress < player.boxParams.useTime) {
    player.boxParams.curProgress += (50 * player.boxParams.useRate);

    if(isDefined(player.objectiveScaler)) {
      player.boxParams.useRate = 1 * player.objectiveScaler;
    }
    else {
      player.boxParams.useRate = 1;
    }

    if(player.boxParams.curProgress >= player.boxParams.useTime) {
      return (isReallyAlive(player));
    }

    wait 0.05;
  }

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

default_canUseDeployable(boxEnt) {
  if((isDefined(boxEnt) && boxEnt.owner == self || self maps\mp\alien\_prestige::prestige_getNoDeployables() == 1.0) && !isDefined(boxEnt.air_dropped)) {
    return false;
  }
  return true;
}

default_OnUseDeployable(boxent) {
  self thread maps\mp\alien\_persistence::deployablebox_used_track(boxEnt);
  maps\mp\alien\_utility::deployable_box_onuse_message(boxent);
}

default_tryUseDeployable(lifeId, BOX_TYPE) {
  result = self maps\mp\alien\_combat_resources::alien_beginDeployableViaMarker(lifeId, BOX_TYPE);

  if((!isDefined(result) || !result)) {
    return false;
  }
  return true;
}

init_deployable(BOX_TYPE, boxconfig) {
  if(!isDefined(level.boxSettings)) {
    level.boxSettings = [];
  }

  level.boxSettings[BOX_TYPE] = boxConfig;

  if(!isDefined(level.killStreakFuncs)) {
    level.killStreakFuncs = [];
  }

  level.deployable_box[BOX_TYPE] = [];
}