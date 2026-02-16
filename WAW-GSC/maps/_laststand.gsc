/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_laststand.gsc
**************************************/

#include maps\_utility;
#include maps\_hud_util;

init() {
  PrecacheItem("syrette");
  PrecacheItem("colt_dirty_harry");
  precachestring(&"GAME_BUTTON_TO_REVIVE_PLAYER");
  precachestring(&"GAME_PLAYER_NEEDS_TO_BE_REVIVED");
  precachestring(&"GAME_PLAYER_IS_REVIVING_YOU");
  precachestring(&"GAME_REVIVING");

  if(!isDefined(level.laststandpistol)) {
    level.laststandpistol = "colt";
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

  if(getDvar("revive_trigger_radius") == "") {
    setDvar("revive_trigger_radius", "40");
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
  if(sMeansOfDeath == "MOD_CRUSH") {
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
  dvarName = "player" + self GetEntityNumber() + "downs";
  setDvar(dvarName, self.downs);

  if(isDefined(level.script) && level.script == "nazi_zombie_sumpf") {
    self AllowJump(false);
  }

  if(isDefined(level.playerlaststand_func)) {
    [[level.playerlaststand_func]]();
  }

  maps\_challenges_coop::doMissionCallback("playerDied", self);

  if(!laststand_allowed(sWeapon, sMeansOfDeath, sHitLoc)) {
    self mission_failed_during_laststand(self);
    return;
  }

  if(player_all_players_in_laststand()) {
    self mission_failed_during_laststand(self);
    return;
  }

  self VisionSetLastStand("laststand", 1);

  self.health = 1;

  self thread maps\_arcademode::arcadeMode_player_laststand();

  self revive_trigger_spawn();

  self laststand_take_player_weapons();
  self laststand_give_pistol();
  self thread laststand_give_grenade();

  self.ignoreme = true;

  self thread laststand_bleedout(GetDvarFloat("player_lastStandBleedoutTime"));

  self notify("player_downed");
}

laststand_allowed(sWeapon, sMeansOfDeath, sHitLoc) {
  if(sMeansOfDeath != "MOD_PISTOL_BULLET" &&
    sMeansOfDeath != "MOD_RIFLE_BULLET" &&
    sMeansOfDeath != "MOD_HEAD_SHOT" &&
    sMeansOfDeath != "MOD_MELEE" &&
    sMeansOfDeath != "MOD_BAYONET" &&
    sMeansOfDeath != "MOD_GRENADE" &&
    sMeansOfDeath != "MOD_GRENADE_SPLASH" &&
    sMeansOfDeath != "MOD_PROJECTILE" &&
    sMeansOfDeath != "MOD_PROJECTILE_SPLASH" &&
    sMeansOfDeath != "MOD_EXPLOSIVE" &&
    sMeansOfDeath != "MOD_BURNED") {
    return false;
  }

  if(level.laststandpistol == "none") {
    return false;
  }

  return true;
}
laststand_take_player_weapons() {
  self.weaponInventory = self GetWeaponsList();
  self.lastActiveWeapon = self GetCurrentWeapon();
  self.laststandpistol = undefined;

  self.weaponAmmo = [];

  for(i = 0; i < self.weaponInventory.size; i++) {
    weapon = self.weaponInventory[i];

    if(WeaponClass(weapon) == "pistol" && !isDefined(self.laststandpistol)) {
      self.laststandpistol = weapon;
    }

    switch (weapon) {
      case "syrette":

      case "zombie_perk_bottle_doubletap":
      case "zombie_perk_bottle_revive":
      case "zombie_perk_bottle_jugg":
      case "zombie_perk_bottle_sleight":
        self.lastActiveWeapon = "none";
        continue;
    }

    self.weaponAmmo[weapon]["clip"] = self GetWeaponAmmoClip(weapon);
    self.weaponAmmo[weapon]["stock"] = self GetWeaponAmmoStock(weapon);
  }

  self TakeAllWeapons();

  if(!isDefined(self.laststandpistol)) {
    self.laststandpistol = level.laststandpistol;
  }

  if(maps\_collectibles::has_collectible("collectible_dirtyharry")) {
    self.laststandpistol = "colt_dirty_harry";
  }
}
laststand_giveback_player_weapons() {
  ASSERTEX(isDefined(self.weaponInventory), "player.weaponInventory is not defined - did you run laststand_take_player_weapons() first?");

  self TakeAllWeapons();

  for(i = 0; i < self.weaponInventory.size; i++) {
    weapon = self.weaponInventory[i];

    switch (weapon) {
      case "syrette":

      case "zombie_perk_bottle_doubletap":
      case "zombie_perk_bottle_revive":
      case "zombie_perk_bottle_jugg":
      case "zombie_perk_bottle_sleight":
        continue;
    }

    self GiveWeapon(weapon);
    self SetWeaponAmmoClip(weapon, self.weaponAmmo[weapon]["clip"]);

    if(WeaponType(weapon) != "grenade") {
      self SetWeaponAmmoStock(weapon, self.weaponAmmo[weapon]["stock"]);
    }
  }

  if(self.lastActiveWeapon != "none" && self.lastActiveWeapon != "mortar_round" && self.lastActiveWeapon != "mine_bouncing_betty") {
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

  if(getDvar("zombiemode") == "1" || IsSubStr(level.script, "nazi_zombie_")) {
    self GiveWeapon(self.laststandpistol);
    ammoclip = WeaponClipSize(self.laststandpistol);

    if(self.laststandpistol == "ray_gun") {
      self SetWeaponAmmoClip(self.laststandpistol, ammoclip);
      self SetWeaponAmmoStock(self.laststandpistol, 0);
    } else {
      self SetWeaponAmmoStock(self.laststandpistol, ammoclip * 2);
    }

    self SwitchToWeapon(self.laststandpistol);
  } else {
    self GiveWeapon(self.laststandpistol);
    self GiveMaxAmmo(self.laststandpistol);
    self SwitchToWeapon(self.laststandpistol);
  }
}

laststand_give_grenade() {
  self endon("player_revived");
  self endon("disconnect");

  while(self isThrowingGrenade()) {
    wait(0.05);
  }
  if(level.campaign == "russian") {
    grenade_choice = "stick_grenade";
  } else {
    grenade_choice = "fraggrenade";
  }
  self GiveWeapon(grenade_choice);
  self SetWeaponAmmoClip(grenade_choice, 0);
  self SwitchToOffhand(grenade_choice);
}

laststand_bleedout(delay) {
  self endon("player_revived");
  self endon("disconnect");

  setClientSysState("lsm", "1", self);

  self.bleedout_time = delay;

  while(self.bleedout_time > Int(delay * 0.5)) {
    self.bleedout_time -= 1;
    wait(1);
  }

  self VisionSetLastStand("death", delay * 0.5);

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
  } else {
    self.ignoreme = false;
    self mission_failed_during_laststand(self);
  }
}
revive_trigger_spawn() {
  radius = GetDvarInt("revive_trigger_radius");

  self.revivetrigger = spawn("trigger_radius", self.origin, 0, radius, radius);
  self.revivetrigger setHintString("");
  self.revivetrigger setCursorHint("HINT_NOICON");

  self.revivetrigger EnableLinkTo();
  self.revivetrigger LinkTo(self);

  self.revivetrigger.beingRevived = 0;
  self.revivetrigger.createtime = gettime();

  if(maps\_collectibles::has_collectible("collectible_morphine")) {
    self maps\_collectibles_game::morphine_think();
  } else {
    self thread revive_trigger_think();
  }
}

revive_debug() {
  for(;;) {
    self waittill("trigger", player);

    if(!player player_is_in_laststand()) {
      iprintln("revive triggered!");
    }

    wait(0.05);
  }
}
revive_trigger_think() {
  self endon("disconnect");
  self endon("zombified");

  while(1) {
    wait(0.1);

    players = get_players();

    self.revivetrigger setHintString("");

    for(i = 0; i < players.size; i++) {
      is_sumpf = 0;
      d = 0;
      if(isDefined(level.script) && level.script == "nazi_zombie_sumpf") {
        is_sumpf = 1;
        d = self depthinwater();
      }

      if(players[i] can_revive(self) || (is_sumpf == 1 && d > 20)) {} {
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

      if(gun == "syrette") {
        continue;
      }
      reviver GiveWeapon("syrette");
      reviver SwitchToWeapon("syrette");
      reviver SetWeaponAmmoStock("syrette", 1);

      revive_success = reviver revive_do_revive(self, gun);

      reviver revive_give_back_weapons(gun);

      if(isDefined(level.script) && level.script == "nazi_zombie_sumpf") {
        self AllowJump(true);
      }

      if(revive_success) {
        self thread revive_success(reviver);
        return;
      }
    }
  }
}

revive_give_back_weapons(gun) {
  self TakeWeapon("syrette");

  if(gun != "none" && gun != "mine_bouncing_betty") {
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

  if(isDefined(level.script) && level.script == "nazi_zombie_sumpf" && (revivee depthinwater() > 10)) {
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
  }

  if(level.script == "nazi_zombie_asylum" && isDefined(self.is_drinking)) {
    return false;
  }

  if(level.script == "nazi_zombie_sumpf" && isDefined(self.is_drinking)) {
    return false;
  }

  return true;
}

is_reviving(revivee) {
  return (can_revive(revivee) && self useButtonPressed());
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
  self.reviveTextHud.y = -148;
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

  if(!revived) {
    playerBeingRevived stoprevive(self);
  }

  playerBeingRevived.revivetrigger setHintString(&"GAME_BUTTON_TO_REVIVE_PLAYER");
  playerBeingRevived.revivetrigger.beingRevived = 0;

  return revived;
}

say_reviving_vo() {
  if(getDvar("zombiemode") == "1" || IsSubStr(level.script, "nazi_zombie_")) {
    players = get_players();
    for(i = 0; i < players.size; i++) {
      if(players[i] == self) {
        self playSound("plr_" + i + "_vox_reviving" + "_" + randomintrange(0, 2));
      }
    }
  }
}

say_revived_vo() {
  if(getDvar("zombiemode") == "1" || IsSubStr(level.script, "nazi_zombie_")) {
    players = get_players();
    for(i = 0; i < players.size; i++) {
      if(players[i] == self) {
        self playSound("plr_" + i + "_vox_revived" + "_" + randomintrange(0, 2));
      }
    }
  }
}

revive_success(reviver) {
  self notify("player_revived");
  self reviveplayer();

  reviver.revives++;
  reviver.stats["revives"] = reviver.revives;

  reviver thread maps\_arcademode::arcadeMode_player_revive();

  if(isDefined(level.missionCallbacks)) {
    maps\_challenges_coop::doMissionCallback("playerRevived", reviver);
  }

  setClientSysState("lsm", "0", self);

  self.revivetrigger delete();
  self.revivetrigger = undefined;

  self laststand_giveback_player_weapons();

  self.ignoreme = false;

  self thread say_revived_vo();
}

revive_force_revive(reviver) {
  assert(isDefined(self));
  assert(isPlayer(self));
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

  if(getDvar("zombiemode") == "1") {
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

revive_hud_hide() {
  assert(isDefined(self));
  assert(isDefined(self.revive_hud));

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
      players[i] thread maps\_quotes::displayMissionFailed();
      if(players[i] == self) {
        players[i] thread maps\_quotes::displayPlayerDead();
        println("Player #" + i + " is dead");
      } else {
        players[i] thread maps\_quotes::displayTeammateDead(dead_player);
        println("Player #" + i + " is alive");
      }
    }
  }
  missionfailed();
}