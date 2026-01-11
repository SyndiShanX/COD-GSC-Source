/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_laststand.gsc
**************************************/

#include common_scripts\utility;
#include maps\mp\_utility;

initLastStand() {
  precacheitem("syrette_mp");
  level.reviveTriggerRadius = GetDvarFloat(#"player_reviveTriggerRadius");
  level.howLongToDoLastStandForWithRevive = GetDvarFloat(#"player_lastStandBleedoutTime");
  level.howLongToDoLastStandForWithoutRevive = GetDvarFloat(#"player_lastStandBleedoutTimeNoRevive");
  level.aboutToBleedOutTime = 5;
  level.amountOfLastStandPistolAmmoInClip = 0;
  level.amountOfLastStandPistolAmmoInStock = 0;
  level.lastStandCount = undefined;
  if(!isDefined(level.laststandpistol)) {
    level.laststandpistol = "m1911_mp";
    PrecacheItem(level.laststandpistol);
  }
  level.allies_needs_revive = false;
  level.axis_needs_revive = false;
  if(GetDvar(#"revive_time_taken") == "") {
    SetDvar("revive_time_taken", "1.15");
  }
  precacherumble("dtp_rumble");
  precacherumble("slide_rumble");
}
keep_weapons() {
  return (set_dvar_int_if_unset("scr_laststand_keep_weapons", 0) > 0);
}
LastStandTime() {
  if(self HasPerk("specialty_finalstand")) {
    return level.howLongToDoLastStandForWithRevive;
  }
  return level.howLongToDoLastStandForWithoutRevive;
}
PlayerLastStand(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration) {
  self.lastStandParams = spawnStruct();
  self.lastStandParams.eInflictor = eInflictor;
  self.lastStandParams.attacker = attacker;
  if(isPlayer(attacker)) {
    if(isDefined(attacker.lastStand) && attacker.laststand == true) {
      self.lastStandParams.attackerStance = "laststand";
    } else {
      self.lastStandParams.attackerStance = attacker getStance();
    }
  }
  self.lastStandParams.iDamage = iDamage;
  self.lastStandParams.sMeansOfDeath = sMeansOfDeath;
  self.lastStandParams.sWeapon = sWeapon;
  self.lastStandParams.vDir = vDir;
  self.lastStandParams.sHitLoc = sHitLoc;
  self.lastStandParams.lastStandStartTime = gettime();
  if(isDefined(attacker)) {
    self.lastStandParams.vAttackerOrigin = attacker.origin;
  }
  mayDoLastStand = mayDoLastStand(sWeapon, sMeansOfDeath, sHitLoc);
  self.useLastStandParams = true;
  if(!mayDoLastStand) {
    self ensureLastStandParamsValidity();
    return;
  }
  if(!isDefined(self.lastStandThisLife)) {
    self.lastStandThisLife = 0;
  }
  self.lastStandThisLife++;
  self.health = 1;
  self thread maps\mp\gametypes\_gameobjects::onPlayerLastStand();
  self notify("entering_last_stand");
  self playlocalsound("mus_last_stand");
  weaponslist = self getweaponslist();
  assertex(isDefined(weaponslist) && weaponslist.size > 0, "Player's weapon(s) missing before dying -=Last Stand=-");
  self.previousweaponslist = self getweaponslist();
  self.previousAmmoClip = [];
  self.previousAmmoStock = [];
  self.laststandpistol = level.laststandpistol;
  self.previousPrimary = self GetCurrentWeapon();
  self.hadPistol = false;
  for(i = 0; i < self.previousweaponslist.size; i++) {
    if(WeaponClass(self.previousweaponslist[i]) == "pistol" &&
      self.previousweaponslist[i] != "knife_ballistic_mp" &&
      !IsSubStr(self.previousweaponslist[i], "_auto_") &&
      !IsSubStr(self.previousweaponslist[i], "dw_")) {
      self.laststandpistol = self.previousweaponslist[i];
      self.hadPistol = true;
    }
  }
  self notify("cancel_location");
  gun = self GetCurrentWeapon();
  if(gun == "syrette_mp") {
    self takeWeapon("syrette_mp");
    gun = self.previousprimary;
    self giveWeapon(self.previousprimary);
  }
  self SetLastStandPrevWeap(gun);
  self DisableOffhandWeapons();
  self DisableWeaponCycling();
  self.previousweaponslist = self getweaponslist();
  for(i = 0; i < self.previousweaponslist.size; i++) {
    weapon = self.previousweaponslist[i];
    self.previousAmmoClip[i] = self GetWeaponAmmoClip(weapon);
    self.previousAmmoStock[i] = self GetWeaponAmmoStock(weapon);
  }
  if((!level.hardcoreMode || self.team != attacker.team) && self HasPerk("specialty_finalstand")) {
    revive_trigger_spawn();
  }
  if(!keep_weapons()) {
    if(!self.hadPistol) {
      self GiveWeapon(self.laststandpistol);
      self GiveWeapon("knife_mp");
    }
    self switchToWeapon(self.laststandpistol);
    if(level.amountOfLastStandPistolAmmoInClip == 0 && level.amountOfLastStandPistolAmmoInStock == 0) {
      self GiveMaxAmmo(self.laststandpistol);
    } else {
      self SetWeaponAmmoClip(self.laststandpistol, level.amountOfLastStandPistolAmmoInClip);
      self SetWeaponAmmoStock(self.laststandpistol, level.amountOfLastStandPistolAmmoInStock);
    }
    if(self isThrowingGrenade()) {
      self thread waittillGrenadeThrown();
    }
  }
  self lastStandTimer(LastStandTime());
}
waittillGrenadeThrown() {
  self endon("disconnect");
  self endon("death");
  self endon("player revived");
  self waittill("grenade_fire", grenade, weapname);
  for(i = self.previousweaponslist.size - 1; i >= 0; i--) {
    weapon = self.previousweaponslist[i];
    if(weapon == weapname) {
      self.previousAmmoClip[i] -= 1;
      self.previousAmmoStock[i] -= 1;
    }
  }
}
mayDoLastStand(sWeapon, sMeansOfDeath, sHitLoc) {
  if(sMeansOfDeath != "MOD_PISTOL_BULLET" &&
    sMeansOfDeath != "MOD_RIFLE_BULLET") {
    return false;
  }
  if(level.laststandpistol == "none") {
    return false;
  }
  if(isDefined(self.enteringVehicle) && self.enteringVehicle) {
    return false;
  }
  if(self IsInVehicle()) {
    return false;
  }
  if(self IsRemoteControlling()) {
    return false;
  }
  if(isDefined(self.selectingLocation) && self.selectingLocation == true) {
    return false;
  }
  if(isDefined(self.laststand)) {
    return false;
  }
  if(isDefined(self.revivingTeammate) && self.revivingTeammate) {
    return false;
  }
  if(isDefined(self.isPlanting) && self.isPlanting) {
    return false;
  }
  if(isDefined(self.isDefusing) && self.isDefusing) {
    return false;
  }
  if(isDefined(level.lastStandCount)) {
    if(isDefined(self.lastStandThisLife) && self.lastStandThisLife >= level.lastStandCount) {
      return false;
    }
  }
  if(isDefined(sWeapon) && weaponClass(sWeapon) == "spread") {
    return false;
  }
  return true;
}
lastStandTimer(delay) {
  self thread lastStandWaittillDeath();
  self.aboutToBleedOut = undefined;
  self.lastStand = true;
  self setLowerMessage(&"PLATFORM_COWARDS_WAY_OUT");
  self.lowerMessage.hideWhenInDemo = true;
  self thread lastStandBleedout(delay);
}
lastStandWaittillDeath() {
  self endon("disconnect");
  self endon("player revived");
  self waittill("death", attacker, isHeadShot, weapon);
  teamMateNeedsRevive = false;
  if(isDefined(attacker) && isDefined(isHeadShot) && isHeadShot && isplayer(attacker)) {
    if(level.teambased) {
      if(attacker.team != self.team) {
        attacker maps\mp\_medals::execution(weapon);
      }
    } else {
      if(attacker != self) {
        attacker maps\mp\_medals::execution(weapon);
      }
    }
  }
  self.thisPlayerisinlaststand = false;
  self clearLowerMessage();
  self.lastStand = undefined;
  if(!allowRevive()) {
    return;
  }
  players = get_players();
  if(isDefined(self.revivetrigger)) {
    self.revivetrigger delete();
  }
  for(i = 0; i < players.size; i++) {
    if(self.team == players[i].team) {
      if(isDefined(players[i].revivetrigger)) {
        teammateNeedsRevive = true;
      }
    }
  }
  for(index = 0; index < 4; index++) {
    self.reviveIcons[index].alpha = 0;
    self.reviveIcons[index] setWaypoint(false);
  }
  self setTeamRevive(teammateNeedsRevive);
}
cleanupTeammateNeedsReviveList() {
  if(!allowRevive()) {
    return;
  }
  players = get_players();
  teamMateNeedsRevive = false;
  for(i = 0; i < players.size; i++) {
    if("allies" == players[i].team) {
      if(isDefined(players[i].revivetrigger)) {
        teammateNeedsRevive = true;
      }
    }
  }
  level.allies_needs_revive = teammateNeedsRevive;
  teamMateNeedsRevive = false;
  for(i = 0; i < players.size; i++) {
    if("axis" == players[i].team) {
      if(isDefined(players[i].revivetrigger)) {
        teammateNeedsRevive = true;
      }
    }
  }
  level.axis_needs_revive = teammateNeedsRevive;
}
setTeamRevive(needsRevive) {
  if(self.team == "allies") {
    level.allies_needs_revive = needsRevive;
  } else if(self.team == "axis") {
    level.axis_needs_revive = needsRevive;
  }
}
teamMateNeedsRevive() {
  teamMateNeedsRevive = false;
  if(isDefined(self.team)) {
    if(self.team == "allies") {
      teamMateNeedsRevive = level.allies_needs_revive;
    } else if(self.team == "axis") {
      teamMateNeedsRevive = level.axis_needs_revive;
    }
  }
  return teamMateNeedsRevive;
}
revive_trigger_spawn() {
  if(allowRevive()) {
    reviveobituary(self);
    self setTeamRevive(true);
    self.revivetrigger = spawn("trigger_radius", self.origin, 0, level.reviveTriggerRadius, level.reviveTriggerRadius);
    self thread clearUpOnDisconnect(self);
    self.revivetrigger setrevivehintstring(&"GAME_BUTTON_TO_REVIVE_PLAYER", self.team);
    self.revivetrigger setCursorHint("HINT_NOICON");
    self thread revive_trigger_think();
    self thread cleanUpOnDeath();
    self needsRevive(true);
  }
}
cleanUpOnDeath() {
  self endon("disconnect");
  self waittill("death");
  if(isDefined(self.revivetrigger)) {
    self.revivetrigger delete();
  }
}
revive_trigger_think() {
  self setTeamRevive(true);
  detectTeam = self.team;
  self.currentlyBeingRevived = false;
  self.thisPlayerIsInLastStand = true;
  self detectReviveIconWaiter();
  while(isDefined(self) && IsAlive(self) && isDefined(self.thisPlayerIsInLastStand) && self.thisPlayerIsInLastStand == true) {
    players = level.aliveplayers[detectTeam];
    if(DistanceSquared(self.revivetrigger.origin, self.origin) > 1) {
      self.revivetrigger delete();
      self.revivetrigger = spawn("trigger_radius", self.origin, 0, level.reviveTriggerRadius, level.reviveTriggerRadius);
      self.revivetrigger setrevivehintstring(&"GAME_BUTTON_TO_REVIVE_PLAYER", self.team);
      self.revivetrigger setCursorHint("HINT_NOICON");
      self thread clearUpOnDisconnect(self);
    }
    for(i = 0; i < players.size; i++) {
      if(can_revive(players[i])) {
        if(players[i] != self && !isDefined(players[i].revivetrigger)) {
          if((!isDefined(self.currentlyBeingRevived) || !self.currentlyBeingRevived) && !players[i].revivingTeammate) {
            if(players[i].health > 0 &&
              isDefined(self.revivetrigger) &&
              players[i] istouching(self.revivetrigger) &&
              players[i] useButtonPressed()) {
              players[i].revivingTeammate = true;
              players[i] thread cleanUpRevivingTeamate(self);
              gun = players[i] GetCurrentWeapon();
              if(gun == "syrette_mp") {
                players[i].gun = players[i].previousprimary;
              } else {
                players[i].previousprimary = gun;
                players[i].gun = gun;
              }
              players[i] GiveWeapon("syrette_mp");
              players[i] SwitchToWeapon("syrette_mp");
              players[i] SetWeaponAmmoStock("syrette_mp", 1);
              players[i] notify("snd_ally_revive");
              players[i] player_being_revived(self);
              if(isDefined(self)) {
                self.currentlyBeingRevived = false;
              }
              players[i] TakeWeapon("syrette_mp");
              if(players[i].previousprimary == "none" || maps\mp\gametypes\_hardpoints::isKillstreakWeapon(players[i].previousprimary)) {
                players[i] switchToValidWeapon();
              } else if(IsWeaponEquipment(players[i].previousprimary) && players[i] GetWeaponAmmoClip(players[i].previousprimary) <= 0) {
                players[i] switchToValidWeapon();
              } else {
                players[i] SwitchToWeapon(players[i].previousprimary);
              }
              players[i].previousprimary = undefined;
              players[i] notify("completedRevive");
              wait(0.1);
              players[i].revivingTeammate = false;
            }
          }
        }
      }
    }
    wait(0.1);
  }
}
switchToValidWeapon() {
  if(self hasWeapon(self.lastNonKillstreakWeapon)) {
    self switchToWeapon(self.lastNonKillstreakWeapon);
  } else if(self hasWeapon(self.lastDroppableWeapon)) {
    self switchToWeapon(self.lastDroppableWeapon);
  } else {
    primaries = self GetWeaponsListPrimaries();
    assert(primaries.size > 0);
    self SwitchToWeapon(primaries[0]);
  }
}
cleanUpRevivingTeamate(revivee) {
  self endon("death");
  self endon("disconnect");
  self endon("completedRevive");
  revivee waittill("death");
  self.revivingTeammate = false;
}
player_being_revived(playerBeingRevived) {
  self endon("death");
  self endon("disconnect");
  reviveTime = GetDvarInt(#"revive_time_taken");
  if(!isDefined(playerBeingRevived.currentlyBeingRevived)) {
    playerBeingRevived.currentlyBeingRevived = false;
  }
  if(reviveTime > 0) {
    timer = 0;
    revivetrigger = playerBeingRevived.revivetrigger;
    while(self.health > 0 && isDefined(revivetrigger) && self istouching(revivetrigger) && self useButtonPressed() && isDefined(playerBeingRevived)) {
      playerBeingRevived.currentlyBeingRevived = true;
      wait(0.05);
      timer += 0.05;
      if(timer >= reviveTime) {
        obituary(playerBeingRevived, self, "syrette_mp", "MOD_UNKNOWN");
        self maps\mp\_medals::revives();
        self maps\mp\gametypes\_persistence::statAdd("REVIVES", 1, false);
        if(level.rankedmatch) {
          self maps\mp\gametypes\_missions::doMissionCallback("medic", self);
        }
        playerBeingRevived.thisPlayerIsInLastStand = false;
        playerBeingRevived thread takePlayerOutOfLastStand();
      }
    }
    return false;
  } else {
    playerBeingRevived.thisPlayerIsInLastStand = false;
    playerBeingRevived thread takePlayerOutOfLastStand();
  }
}
takePlayerOutOfLastStand() {
  self notify("player revived");
  self clearLowerMessage();
  self playlocalsound("mus_last_stand_revive");
  if(!keep_weapons()) {
    if(self.hadPistol == false) {
      self TakeWeapon(self.laststandpistol);
    }
    for(i = self.previousweaponslist.size - 1; i >= 0; i--) {
      weapon = self.previousweaponslist[i];
      self GiveWeapon(weapon);
      self SetWeaponAmmoClip(weapon, self.previousAmmoClip[i]);
      self SetWeaponAmmoStock(weapon, self.previousAmmoStock[i]);
    }
    if(isDefined(self.previousPrimary) && self.previousPrimary != "none") {
      if(!IsWeaponEquipment(self.previousPrimary) && !IsWeaponSpecificUse(self.previousPrimary) && !isDefined(level.grenade_array[self.previousPrimary])) {
        self SwitchToWeapon(self.previousPrimary);
      } else {
        for(i = self.previousweaponslist.size - 1; i >= 0; i--) {
          if(!IsWeaponEquipment(self.previousweaponslist[i]) && !IsWeaponSpecificUse(self.previousweaponslist[i]) && IsWeaponPrimary(self.previousweaponslist[i])) {
            self SwitchToWeapon(self.previousweaponslist[i]);
            break;
          }
        }
      }
    } else {
      for(i = self.previousweaponslist.size - 1; i >= 0; i--) {
        if(!IsWeaponEquipment(self.previousweaponslist[i]) && !IsWeaponSpecificUse(self.previousweaponslist[i]) && IsWeaponPrimary(self.previousweaponslist[i])) {
          self SwitchToWeapon(self.previousweaponslist[i]);
          break;
        }
      }
    }
  }
  self revive();
  self needsRevive(false);
  if(isDefined(self.revivetrigger)) {
    self.revivetrigger delete();
  }
  self.aboutToBleedOut = undefined;
  self clearLowerMessage();
  self thread maps\mp\gametypes\_hardpoints::giveOwnedKillstreak();
  self.laststandpistol = level.laststandpistol;
  self.lastStand = undefined;
  self EnableOffhandWeapons();
  self EnableWeaponCycling();
  self.useLastStandParams = undefined;
  self.lastStandParams = undefined;
  players = get_players();
  anyPlayerLeftInLastStand = false;
  for(i = 0; i < players.size; i++) {
    if(isDefined(players[i].revivetrigger) && players[i].team == self.team) {
      anyPlayerLeftInLastStand = true;
    }
  }
  if(!anyPlayerLeftInLastStand) {
    self setTeamRevive(false);
  }
}
reviveFromConsole() {
  self endon("player revived");
  for(;;) {
    if(GetDvar(#"scr_reviveme") != "") {
      self.thisPlayerIsInLastStand = false;
      setdvar("scr_reviveme", "");
      self thread takePlayerOutOfLastStand();
    }
    wait(0.1);
  }
}
lastStandBleedout(delay) {
  self endon("player revived");
  self endon("disconnect");
  self endon("death");
  self thread cowardsWayOut();
  self thread lastStandHealthOverlay();
  self thread lastStandEndOnForceCrouch();
  wait(delay - level.aboutToBleedOutTime);
  self.aboutToBleedOut = true;
  wait(level.aboutToBleedOutTime);
  self notify("end coward");
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] notify("stop revive pulse");
  }
  self needsRevive(false);
  self ensureLastStandParamsValidity();
  self suicide();
}
lastStandEndOnForceCrouch() {
  self endon("player revived");
  self endon("disconnect");
  self endon("death");
  self endon("end coward");
  self waittill("force crouch");
  self needsRevive(false);
  self ensureLastStandParamsValidity();
  self suicide();
}
cowardsWayOut() {
  self endon("player revived");
  self endon("disconnect");
  self endon("death");
  self endon("end coward");
  while(1) {
    if(self useButtonPressed()) {
      pressStartTime = gettime();
      while(self useButtonPressed()) {
        wait .05;
        if(gettime() - pressStartTime > 700) {
          break;
        }
      }
      if(gettime() - pressStartTime > 700) {
        break;
      }
    }
    wait .05;
  }
  self needsRevive(false);
  self ensureLastStandParamsValidity();
  duration = self doCowardsWayAnims();
  wait(duration);
  self.suicideWeapon = self GetCurrentWeapon();
  wait(0.05);
  self suicide();
}
clearUpOnDisconnect(player) {
  reviveTrigger = self.revivetrigger;
  self notify("clearing revive on disconnect");
  self endon("clearing revive on disconnect");
  self waittill("disconnect");
  self.lastStand = undefined;
  cleanupTeammateNeedsReviveList();
  if(isDefined(revivetrigger)) {
    revivetrigger delete();
  }
  teamMateNeedsRevive = false;
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(self.team == players[i].team) {
      if(isDefined(players[i].revivetrigger)) {
        teammateNeedsRevive = true;
      }
    }
  }
  self setTeamRevive(teammateNeedsRevive);
}
allowRevive() {
  if(!level.teambased) {
    return false;
  }
  if(maps\mp\gametypes\_tweakables::getTweakableValue("player", "allowrevive") == 0) {
    return false;
  }
  return true;
}
setupRevive() {
  if(!allowRevive()) {
    return;
  }
  self.aboutToBleedOut = undefined;
  for(index = 0; index < 4; index++) {
    if(!isDefined(self.reviveIcons[index])) {
      self.reviveIcons[index] = newClientHudElem(self);
    }
    self.reviveIcons[index].x = 0;
    self.reviveIcons[index].y = 0;
    self.reviveIcons[index].z = 0;
    self.reviveIcons[index].alpha = 0;
    self.reviveIcons[index].archived = true;
    self.reviveIcons[index] setShader("waypoint_second_chance", 14, 14);
    self.reviveIcons[index] setWaypoint(false);
    self.reviveIcons[index].reviveId = -1;
    self.reviveIcons[index].overrridewhenindemo = true;
  }
  players = get_players();
  iconCount = 4;
  for(i = 0; i < players.size && iconCount > 0; i++) {
    if(!isDefined(players[i].team)) {
      continue;
    }
    if(self.team != players[i].team) {
      continue;
    }
    if(!isDefined(players[i].lastStand) || !players[i].lastStand) {
      continue;
    }
    iconCount--;
    self thread showReviveIcon(players[i]);
  }
}
lastStandHealthOverlay() {
  self endon("player revived");
  self endon("death");
  self endon("disconnect");
  self endon("game_ended");
  while(1) {
    self.health = 2;
    wait .05;
    self.health = 1;
    wait .5;
  }
}
ensureLastStandParamsValidity() {
  if(!isDefined(self.lastStandParams.attacker)) {
    self.lastStandParams.attacker = self;
  }
}
detectReviveIconWaiter() {
  level endon("game_ended");
  if(!allowRevive()) {
    return;
  }
  players = get_players();
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(player.team != self.team) {
      continue;
    }
    if(player == self) {
      continue;
    }
    if(!(can_revive(player))) {
      continue;
    }
    if(isai(player)) {
      continue;
    }
    player thread showReviveIcon(self);
  }
}
showReviveIcon(lastStandPlayer) {
  self endon("disconnect");
  if(!allowRevive()) {
    return;
  }
  triggerreviveId = lastStandPlayer getentitynumber();
  useId = -1;
  for(index = 0;
    (index < 4) && (useId == -1); index++) {
    if(!isDefined(self.reviveIcons) || !isDefined(self.reviveIcons[index]) || !isDefined(self.reviveIcons[index].reviveId)) {
      continue;
    }
    reviveId = self.reviveIcons[index].reviveId;
    if(reviveId == triggerreviveId) {
      return;
    }
    if(reviveId == -1) {
      useId = index;
    }
  }
  if(useId < 0) {
    return;
  }
  looptime = 0.05;
  self.reviveIcons[useId] setWaypoint(true, "waypoint_second_chance");
  reviveIconAlpha = 0.8;
  self.reviveIcons[useId].alpha = reviveIconAlpha;
  self.reviveIcons[useId].reviveId = triggerreviveId;
  self.reviveIcons[useId] SetTargetEnt(lastStandPlayer);
  while(isDefined(laststandplayer.revivetrigger)) {
    if(isDefined(laststandplayer.aboutToBleedOut)) {
      self.reviveIcons[useId] fadeOverTime(level.aboutToBleedOutTime);
      self.reviveIcons[useId].alpha = 0;
      while(isDefined(laststandplayer.revivetrigger)) {
        wait(0.1);
      }
      wait(level.aboutToBleedOutTime);
      self.reviveIcons[useId].reviveId = -1;
      self.reviveIcons[useId] setWaypoint(false);
      return;
    } else if(self IsInVehicle()) {
      self.reviveIcons[useId].alpha = 0;
    } else {
      self.reviveIcons[useId].alpha = reviveIconAlpha;
    }
    wait(loopTime);
  }
  if(!isDefined(self)) {
    return;
  }
  self.reviveIcons[useId] fadeOverTime(0.25);
  self.reviveIcons[useId].alpha = 0;
  wait 1;
  self.reviveIcons[useId].reviveId = -1;
  self.reviveIcons[useId] setWaypoint(false);
}
can_revive(reviver) {
  if(isDefined(reviver)) {
    return true;
  }
  return false;
}