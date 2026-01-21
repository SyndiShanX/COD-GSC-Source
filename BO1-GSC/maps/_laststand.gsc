/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_laststand.gsc
**************************************/

#include maps\_utility;
#include maps\_hud_util;

init() {
  if(level.script == "frontend")
    return;
  PrecacheItem("syrette_sp");
  precachestring(&"GAME_BUTTON_TO_REVIVE_PLAYER");
  precachestring(&"GAME_PLAYER_NEEDS_TO_BE_REVIVED");
  precachestring(&"GAME_PLAYER_IS_REVIVING_YOU");
  precachestring(&"GAME_REVIVING");
  if(!isDefined(level.laststandpistol)) {
    level.laststandpistol = "m1911";
    PrecacheItem(level.laststandpistol);
  }
  if(!arcadeMode()) {
    level thread revive_hud_think();
  }
  level.primaryProgressBarX = 0;
  level.primaryProgressBarY = 110;
  level.primaryProgressBarHeight = 4;
  level.primaryProgressBarWidth = 120;
  if(IsSplitScreen()) {
    level.primaryProgressBarY = 280;
  }
  if(getDvar(#"revive_trigger_radius") == "") {
    SetDvar("revive_trigger_radius", "40");
  }
}

player_is_in_laststand() {
  return (isDefined(self.revivetrigger));
}

player_num_in_laststand() {
  num = 0;
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(players[i] player_is_in_laststand()) {
      num++;
    }
  }
  return num;
}

player_all_players_in_laststand() {
  return (player_num_in_laststand() == get_players().size);
}

player_any_player_in_laststand() {
  return (player_num_in_laststand() > 0);
}

PlayerLastStand(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration) {
  if(getDvar(#"zombiemode") != "1" && sMeansOfDeath == "MOD_CRUSH") {
    if(self player_is_in_laststand()) {
      self mission_failed_during_laststand(self);
    }
    return;
  }
  if(self player_is_in_laststand()) {
    return;
  }
  self.downs++;
  self.stats["downs"] = self.downs;
  dvarName = "player" + self getEntityNumber() + "downs";
  setdvar(dvarName, self.downs);
  self AllowJump(false);
  if(isDefined(level.playerlaststand_func)) {
    [[level.playerlaststand_func]](eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration);
  }
  if(!laststand_allowed(sWeapon, sMeansOfDeath, sHitLoc)) {
    self mission_failed_during_laststand(self);
    return;
  }
  if(player_all_players_in_laststand()) {
    self mission_failed_during_laststand(self);
    return;
  }
  if(getDvar(#"zombiemode") == "1") {
    self VisionSetLastStand("zombie_last_stand", 1);
  } else {
    self VisionSetLastStand("laststand", 1);
  }
  self.health = 1;
  self revive_trigger_spawn();
  self laststand_disable_player_weapons();
  self laststand_give_pistol();
  self.ignoreme = true;
  self thread laststand_bleedout(GetDvarFloat(#"player_lastStandBleedoutTime"));
  self notify("player_downed");
}

laststand_allowed(sWeapon, sMeansOfDeath, sHitLoc) {
  if(getDvar(#"zombiemode") != "1" && sMeansOfDeath != "MOD_PISTOL_BULLET" && sMeansOfDeath != "MOD_RIFLE_BULLET" && sMeansOfDeath != "MOD_HEAD_SHOT" && sMeansOfDeath != "MOD_MELEE" && sMeansOfDeath != "MOD_BAYONET" && sMeansOfDeath != "MOD_GRENADE" && sMeansOfDeath != "MOD_GRENADE_SPLASH" && sMeansOfDeath != "MOD_PROJECTILE" && sMeansOfDeath != "MOD_PROJECTILE_SPLASH" && sMeansOfDeath != "MOD_EXPLOSIVE" && sMeansOfDeath != "MOD_BURNED") {
    return false;
  }
  if(level.laststandpistol == "none") {
    return false;
  }
  return true;
}

laststand_disable_player_weapons() {
  weaponInventory = self GetWeaponsList();
  self.lastActiveWeapon = self GetCurrentWeapon();
  self SetLastStandPrevWeap(self.lastActiveWeapon);
  self.laststandpistol = undefined;
  self.hadpistol = false;
  for(i = 0; i < weaponInventory.size; i++) {
    weapon = weaponInventory[i];
    if(WeaponClass(weapon) == "pistol" && !isDefined(self.laststandpistol)) {
      self.laststandpistol = weapon;
      self.hadpistol = true;
    }
    switch (weapon) {
      case "syrette_sp":
      case "zombie_perk_bottle_doubletap":
      case "zombie_perk_bottle_revive":
      case "zombie_perk_bottle_jugg":
      case "zombie_perk_bottle_sleight":
        self TakeWeapon(weapon);
        self.lastActiveWeapon = "none";
        continue;
    }
  }
  if(isDefined(self.hadpistol) && self.hadpistol == true && isDefined(level.zombie_last_stand_pistol_memory)) {
    self[[level.zombie_last_stand_pistol_memory]]();
  }
  if(!isDefined(self.laststandpistol)) {
    self.laststandpistol = level.laststandpistol;
  }
  self DisableWeaponCycling();
  if(getDvar(#"zombiemode") != "1") {
    self DisableOffhandWeapons();
  }
}

laststand_enable_player_weapons() {
  if(!self.hadpistol) {
    self TakeWeapon(self.laststandpistol);
  }
  if(isDefined(self.hadpistol) && self.hadpistol == true && isDefined(level.zombie_last_stand_ammo_return)) {
    [[level.zombie_last_stand_ammo_return]]();
  }
  self EnableWeaponCycling();
  self EnableOffhandWeapons();
  if(self.lastActiveWeapon != "none" && self.lastActiveWeapon != "mortar_round" && self.lastActiveWeapon != "mine_bouncing_betty" && self.lastActiveWeapon != "claymore_zm") {
    self SwitchToWeapon(self.lastActiveWeapon);
  } else {
    primaryWeapons = self GetWeaponsListPrimaries();
    if(isDefined(primaryWeapons) && primaryWeapons.size > 0) {
      self SwitchToWeapon(primaryWeapons[0]);
    }
  }
}

laststand_clean_up_on_disconnect(playerBeingRevived, reviverGun) {
  reviveTrigger = playerBeingRevived.revivetrigger;
  playerBeingRevived waittill("disconnect");
  if(isDefined(reviveTrigger)) {
    reviveTrigger delete();
  }
  if(isDefined(self.reviveProgressBar)) {
    self.reviveProgressBar destroyElem();
  }
  if(isDefined(self.reviveTextHud)) {
    self.reviveTextHud destroy();
  }
  self revive_give_back_weapons(reviverGun);
}

laststand_give_pistol() {
  assert(isDefined(self.laststandpistol));
  assert(self.laststandpistol != "none");
  if(isDefined(level.zombie_last_stand)) {
    [[level.zombie_last_stand]]();
  } else {
    self GiveWeapon(self.laststandpistol);
    self GiveMaxAmmo(self.laststandpistol);
    self SwitchToWeapon(self.laststandpistol);
  }
}

Laststand_Bleedout(delay) {
  self endon("player_revived");
  self endon("disconnect");
  setClientSysState("lsm", "1", self);
  self.bleedout_time = delay;
  while(self.bleedout_time > Int(delay * 0.5)) {
    self.bleedout_time -= 1;
    wait(1);
  }
  if(getDvar(#"zombiemode") == "1") {
    self VisionSetLastStand("zombie_death", delay * 0.5);
  } else {
    self VisionSetLastStand("death", delay * 0.5);
  }
  while(self.bleedout_time > 0) {
    self.bleedout_time -= 1;
    wait(1);
  }
  while(self.revivetrigger.beingRevived == 1) {
    wait(0.1);
  }
  setClientSysState("lsm", "0", self);
  if(isDefined(level.is_zombie_level) && level.is_zombie_level) {
    self[[level.player_becomes_zombie]]();
  } else if(isDefined(level.is_specops_level) && level.is_specops_level) {
    self thread[[level.spawnSpectator]]();
  } else {
    self.ignoreme = false;
    self mission_failed_during_laststand(self);
  }
}

revive_trigger_spawn() {
  radius = GetDvarInt(#"revive_trigger_radius");
  self.revivetrigger = spawn("trigger_radius", self.origin, 0, radius, radius);
  self.revivetrigger setHintString("");
  self.revivetrigger setCursorHint("HINT_NOICON");
  self.revivetrigger EnableLinkTo();
  self.revivetrigger LinkTo(self);
  self.revivetrigger.beingRevived = 0;
  self.revivetrigger.createtime = gettime();
  self thread revive_trigger_think();
}

revive_trigger_think() {
  self endon("disconnect");
  self endon("zombified");
  self endon("stop_revive_trigger");
  while(1) {
    wait(0.1);
    players = get_players();
    self.revivetrigger setHintString("");
    for(i = 0; i < players.size; i++) {
      d = 0;
      d = self depthinwater();
      if(players[i] can_revive(self) || d > 20) {
        self.revivetrigger setHintString(&"GAME_BUTTON_TO_REVIVE_PLAYER");
        break;
      }
    }
    for(i = 0; i < players.size; i++) {
      reviver = players[i];
      if(!reviver is_reviving(self)) {
        continue;
      }
      gun = reviver GetCurrentWeapon();
      assert(isDefined(gun));
      assert(gun != "syrette_sp");
      reviver GiveWeapon("syrette_sp");
      reviver SwitchToWeapon("syrette_sp");
      reviver SetWeaponAmmoStock("syrette_sp", 1);
      revive_success = reviver revive_do_revive(self, gun);
      reviver revive_give_back_weapons(gun);
      self AllowJump(true);
      if(revive_success) {
        self thread revive_success(reviver);
        return;
      }
    }
  }
}

revive_give_back_weapons(gun) {
  self TakeWeapon("syrette_sp");
  if(self player_is_in_laststand()) {
    return;
  }
  if(gun != "none" && gun != "mine_bouncing_betty" && gun != "claymore_zm") {
    self SwitchToWeapon(gun);
  } else {
    primaryWeapons = self GetWeaponsListPrimaries();
    if(isDefined(primaryWeapons) && primaryWeapons.size > 0) {
      self SwitchToWeapon(primaryWeapons[0]);
    }
  }
}

can_revive(revivee) {
  if(!isAlive(self)) {
    return false;
  }
  if(self player_is_in_laststand()) {
    return false;
  }
  if(!isDefined(revivee.revivetrigger)) {
    return false;
  }
  if(!self IsTouching(revivee.revivetrigger)) {
    return false;
  }
  if(revivee depthinwater() > 10) {
    return true;
  }
  if(!self is_facing(revivee)) {
    return false;
  }
  if(!SightTracePassed(self.origin + (0, 0, 50), revivee.origin + (0, 0, 30), false, undefined)) {
    return false;
  }
  if(!bullettracepassed(self.origin + (0, 0, 50), revivee.origin + (0, 0, 30), false, undefined)) {
    return false;
  }
  if(isDefined(level.is_zombie_level) && level.is_zombie_level) {
    if(isDefined(self.is_zombie) && self.is_zombie) {
      return false;
    }
    if(isDefined(level.can_revive)) {
      return [[level.can_revive]](revivee);
    }
  }
  return true;
}

is_reviving(revivee) {
  return (can_revive(revivee) && self UseButtonPressed());
}

is_facing(facee) {
  orientation = self getPlayerAngles();
  forwardVec = anglesToForward(orientation);
  forwardVec2D = (forwardVec[0], forwardVec[1], 0);
  unitForwardVec2D = VectorNormalize(forwardVec2D);
  toFaceeVec = facee.origin - self.origin;
  toFaceeVec2D = (toFaceeVec[0], toFaceeVec[1], 0);
  unitToFaceeVec2D = VectorNormalize(toFaceeVec2D);
  dotProduct = VectorDot(unitForwardVec2D, unitToFaceeVec2D);
  return (dotProduct > 0.9);
}

revive_do_revive(playerBeingRevived, reviverGun) {
  assert(self is_reviving(playerBeingRevived));
  reviveTime = 3;
  if(self HasPerk("specialty_quickrevive")) {
    reviveTime = reviveTime / 2;
  }
  timer = 0;
  revived = false;
  playerBeingRevived.revivetrigger.beingRevived = 1;
  playerBeingRevived.revive_hud setText(&"GAME_PLAYER_IS_REVIVING_YOU", self);
  playerBeingRevived revive_hud_show_n_fade(3.0);
  playerBeingRevived.revivetrigger setHintString("");
  playerBeingRevived startrevive(self);
  if(!isDefined(self.reviveProgressBar)) {
    self.reviveProgressBar = self createPrimaryProgressBar();
  }
  if(!isDefined(self.reviveTextHud)) {
    self.reviveTextHud = newclientHudElem(self);
  }
  self thread laststand_clean_up_on_disconnect(playerBeingRevived, reviverGun);
  self.reviveProgressBar updateBar(0.01, 1 / reviveTime);
  self.reviveTextHud.alignX = "center";
  self.reviveTextHud.alignY = "middle";
  self.reviveTextHud.horzAlign = "center";
  self.reviveTextHud.vertAlign = "bottom";
  self.reviveTextHud.y = -113;
  if(IsSplitScreen()) {
    self.reviveTextHud.y = -107;
  }
  self.reviveTextHud.foreground = true;
  self.reviveTextHud.font = "default";
  self.reviveTextHud.fontScale = 1.8;
  self.reviveTextHud.alpha = 1;
  self.reviveTextHud.color = (1.0, 1.0, 1.0);
  self.reviveTextHud setText(&"GAME_REVIVING");
  while(self is_reviving(playerBeingRevived)) {
    wait(0.05);
    timer += 0.05;
    if(self player_is_in_laststand()) {
      break;
    }
    if(isDefined(playerBeingRevived.revivetrigger.auto_revive) && playerBeingRevived.revivetrigger.auto_revive == true) {
      break;
    }
    if(timer >= reviveTime) {
      revived = true;
      break;
    }
  }
  if(isDefined(self.reviveProgressBar)) {
    self.reviveProgressBar destroyElem();
  }
  if(isDefined(self.reviveTextHud)) {
    self.reviveTextHud destroy();
  }
  if(isDefined(playerBeingRevived.revivetrigger.auto_revive) && playerBeingRevived.revivetrigger.auto_revive == true) {} else if(!revived) {
    playerBeingRevived stoprevive(self);
  }
  playerBeingRevived.revivetrigger setHintString(&"GAME_BUTTON_TO_REVIVE_PLAYER");
  playerBeingRevived.revivetrigger.beingRevived = 0;
  return revived;
}

say_revived_vo() {
  if(getDvar(#"zombiemode") == "1" || IsSubStr(level.script, "nazi_zombie_")) {
    players = get_players();
    for(i = 0; i < players.size; i++) {
      if(players[i] == self) {
        self playSound("plr_" + i + "_vox_revived" + "_" + randomintrange(0, 2));
      }
    }
  }
}

auto_revive(reviver) {
  if(isDefined(self.revivetrigger)) {
    self.revivetrigger.auto_revive = true;
    if(self.revivetrigger.beingRevived == 1) {
      while(1) {
        if(self.revivetrigger.beingRevived == 0) {
          break;
        }
        wait_network_frame();
      }
    }
    self.revivetrigger.auto_trigger = false;
  }
  self reviveplayer();
  if(isDefined(self.preMaxHealth)) {
    self SetMaxHealth(self.preMaxHealth);
  }
  setClientSysState("lsm", "0", self);
  self notify("stop_revive_trigger");
  self.revivetrigger delete();
  self.revivetrigger = undefined;
  self laststand_enable_player_weapons();
  self AllowJump(true);
  self.ignoreme = false;
  reviver.revives++;
  reviver.stats["revives"] = reviver.revives;
  self thread say_revived_vo();
  self notify("player_revived", reviver);
}

remote_revive(reviver) {
  if(!self player_is_in_laststand()) {
    return;
  }
  reviver giveachievement_wrapper("SP_ZOM_NODAMAGE");
  self auto_revive(reviver);
}

revive_success(reviver) {
  self notify("player_revived", reviver);
  self reviveplayer();
  if(isDefined(self.preMaxHealth)) {
    self SetMaxHealth(self.preMaxHealth);
  }
  reviver.revives++;
  reviver.stats["revives"] = reviver.revives;
  if(isDefined(level.missionCallbacks)) {}
  setClientSysState("lsm", "0", self);
  self.revivetrigger delete();
  self.revivetrigger = undefined;
  self laststand_enable_player_weapons();
  self.ignoreme = false;
  self thread say_revived_vo();
}

revive_force_revive(reviver) {
  assert(isDefined(self));
  assert(IsPlayer(self));
  assert(self player_is_in_laststand());
  self thread revive_success(reviver);
}

revive_hud_create() {
  self.revive_hud = newclientHudElem(self);
  self.revive_hud.alignX = "center";
  self.revive_hud.alignY = "middle";
  self.revive_hud.horzAlign = "center";
  self.revive_hud.vertAlign = "bottom";
  self.revive_hud.y = -50;
  self.revive_hud.foreground = true;
  self.revive_hud.font = "default";
  self.revive_hud.fontScale = 1.5;
  self.revive_hud.alpha = 0;
  self.revive_hud.color = (1.0, 1.0, 1.0);
  self.revive_hud setText("");
  if(getDvar(#"zombiemode") == "1") {
    self.revive_hud.y = -80;
  }
}

revive_hud_think() {
  self endon("disconnect");
  while(1) {
    wait(0.1);
    if(!player_any_player_in_laststand()) {
      continue;
    }
    players = get_players();
    playerToRevive = undefined;
    for(i = 0; i < players.size; i++) {
      if(!players[i] player_is_in_laststand() || !isDefined(players[i].revivetrigger.createtime)) {
        continue;
      }
      if(!isDefined(playerToRevive) || playerToRevive.revivetrigger.createtime > players[i].revivetrigger.createtime) {
        playerToRevive = players[i];
      }
    }
    if(isDefined(playerToRevive)) {
      for(i = 0; i < players.size; i++) {
        if(players[i] player_is_in_laststand()) {
          continue;
        }
        if(getDvar(#"g_gametype") == "vs") {
          if(players[i].team != playerToRevive.team) {
            continue;
          }
        }
        players[i] thread fadeReviveMessageOver(playerToRevive, 3.0);
      }
      playerToRevive.revivetrigger.createtime = undefined;
      wait(3.5);
    }
  }
}

fadeReviveMessageOver(playerToRevive, time) {
  revive_hud_show();
  self.revive_hud setText(&"GAME_PLAYER_NEEDS_TO_BE_REVIVED", playerToRevive);
  self.revive_hud fadeOverTime(time);
  self.revive_hud.alpha = 0;
}

revive_hud_show() {
  assert(isDefined(self));
  assert(isDefined(self.revive_hud));
  self.revive_hud.alpha = 1;
}

revive_hud_show_n_fade(time) {
  revive_hud_show();
  self.revive_hud fadeOverTime(time);
  self.revive_hud.alpha = 0;
}

drawcylinder(pos, rad, height) {
  currad = rad;
  curheight = height;
  for(r = 0; r < 20; r++) {
    theta = r / 20 * 360;
    theta2 = (r + 1) / 20 * 360;
    line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta2) * currad, sin(theta2) * currad, 0));
    line(pos + (cos(theta) * currad, sin(theta) * currad, curheight), pos + (cos(theta2) * currad, sin(theta2) * currad, curheight));
    line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta) * currad, sin(theta) * currad, curheight));
  }
}

mission_failed_during_laststand(dead_player) {
  if(isDefined(level.no_laststandmissionfail) && level.no_laststandmissionfail) {
    return;
  }
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(isDefined(players[i])) {
      if(players[i] == self) {
        println("Player #" + i + " is dead");
      } else {
        println("Player #" + i + " is alive");
      }
    }
  }
  missionfailed();
}