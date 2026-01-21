/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_weapons.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;

init() {
  level.weaponIDs = [];
  max_weapon_num = 149;
  attachment_num = 150;
  for(i = 0; i <= max_weapon_num; i++) {
    weapon_name = tablelookup("mp/statstable.csv", 0, i, 4);
    if(!isDefined(weapon_name) || weapon_name == "") {
      level.weaponIDs[i] = "";
      continue;
    }
    level.weaponIDs[i] = weapon_name + "_mp";
    attachment = tablelookup("mp/statstable.csv", 0, i, 8);
    if(!isDefined(attachment) || attachment == "") {
      continue;
    }
    attachment_tokens = strtok(attachment, " ");
    if(!isDefined(attachment_tokens)) {
      continue;
    }
    if(attachment_tokens.size == 0) {
      level.weaponIDs[attachment_num] = weapon_name + "_" + attachment + "_mp";
      attachment_num++;
    } else {
      for(k = 0; k < attachment_tokens.size; k++) {
        level.weaponIDs[attachment_num] = weapon_name + "_" + attachment_tokens[k] + "_mp";
        attachment_num++;
      }
    }
  }
  level.weaponNames = [];
  for(index = 0; index < max_weapon_num; index++) {
    if(!isDefined(level.weaponIDs[index]) || level.weaponIDs[index] == "") {
      continue;
    }
    level.weaponNames[level.weaponIDs[index]] = index;
  }
  level.weaponlist = [];
  assertex(isDefined(level.weaponIDs.size), "level.weaponIDs is corrupted");
  for(i = 0; i < level.weaponIDs.size; i++) {
    if(!isDefined(level.weaponIDs[i]) || level.weaponIDs[i] == "") {
      continue;
    }
    level.weaponlist[level.weaponlist.size] = level.weaponIDs[i];
  }
  for(index = 0; index < level.weaponList.size; index++) {
    precacheItem(level.weaponList[index]);
    println("Precached weapon: " + level.weaponList[index]);
  }
  precacheItem("frag_grenade_short_mp");
  precacheModel("weapon_mp_bazooka_attach");
  precacheItem("napalmblob_mp");
  precacheItem("t34_mp_explosion_mp");
  precacheItem("panzer4_mp_explosion_mp");
  precacheShellShock("default");
  precacheShellShock("tabun_gas_mp");
  thread maps\mp\_flashgrenades::main();
  thread maps\mp\_entityheadicons::init();
  if(!isDefined(level.grenadeLauncherDudTime))
    level.grenadeLauncherDudTime = 0;
  level.bettyDetonateRadius = weapons_get_dvar_int("bettyDetonateRadius", "150");
  level.bettyUpVelocity = weapons_get_dvar_int("bettyUpVelocity", "296");
  level.bettyTimeBeforeDetonate = weapons_get_dvar("bettyTimeBeforeDetonate", "0.45");
  level.bettyTriggerDamageTraceEnabled = weapons_get_dvar_int("scr_bettyTriggerDamageTraceEnabled", "1");
  level.bettyTriggerLoopWait = weapons_get_dvar("scr_bettyTriggerLoopWait", 0.1);
  level.tabunInitialGasShockDuration = weapons_get_dvar_int("tabunInitialGasShockDuration", "7");
  level.tabunWalkInGasShockDuration = weapons_get_dvar_int("tabunWalkInGasShockDuration", "4");
  level.tabunGasShockRadius = weapons_get_dvar_int("tabun_shock_radius", "150");
  level.tabunGasPoisonRadius = weapons_get_dvar_int("tabun_effect_radius", "150");
  level.tabunGasDuration = weapons_get_dvar_int("tabunGasDuration", "3");
  level.poisonDuration = weapons_get_dvar_int("poisonDuration", "8");
  level.slappedWithMolotovDamage = 35;
  level.bettyFXid = loadfx("weapon/bouncing_betty/fx_betty_trail");
  level thread onPlayerConnect();
  level.satchelexplodethisframe = false;
  level.bettyexplodethisframe = false;
}

isStrStart(string1, subStr) {
  return (getSubStr(string1, 0, subStr.size) == subStr);
}

onPlayerConnect() {
  for(;;) {
    level waittill("connecting", player);
    player.usedWeapons = false;
    player.hits = 0;
    player thread onPlayerSpawned();
  }
}

onPlayerSpawned() {
  self endon("disconnect");
  for(;;) {
    self waittill("spawned_player");
    self.concussionEndTime = 0;
    self.hasDoneCombat = false;
    self thread watchWeaponUsage();
    self thread watchGrenadeUsage();
    self thread watchWeaponChange();
    self.droppedDeathWeapon = undefined;
    self.tookWeaponFrom = [];
    self thread updateStowedWeapon();
  }
}

watchWeaponChange() {
  self endon("death_or_disconnect");
  self.lastDroppableWeapon = self getCurrentWeapon();
  while(1) {
    self waittill("weapon_change", newWeapon);
    if(mayDropWeapon(newWeapon))
      self.lastDroppableWeapon = newWeapon;
  }
}

isPistol(weapon) {
  return isDefined(level.side_arm_array[weapon]);
}

hasScope(weapon) {
  if(isSubStr(weapon, "_acog_"))
    return true;
  if(weapon == "m21_mp")
    return true;
  if(weapon == "aw50_mp")
    return true;
  if(weapon == "barrett_mp")
    return true;
  if(weapon == "dragunov_mp")
    return true;
  if(weapon == "m40a3_mp")
    return true;
  if(weapon == "remington700_mp")
    return true;
  return false;
}

isHackWeapon(weapon) {
  if(weapon == "radar_mp" || weapon == "artillery_mp" || weapon == "dogs_mp")
    return true;
  if(weapon == "briefcase_bomb_mp")
    return true;
  return false;
}

mayDropWeapon(weapon) {
  if(weapon == "none")
    return false;
  if(isHackWeapon(weapon))
    return false;
  invType = WeaponInventoryType(weapon);
  if(invType != "primary")
    return false;
  if(weapon == "none")
    return false;
  return true;
}

dropWeaponForDeath(attacker) {
  weapon = self.lastDroppableWeapon;
  if(isDefined(self.droppedDeathWeapon)) {
    return;
  }
  if(!isDefined(weapon)) {
    if(getdvar("scr_dropdebug") == "1")
      println("didn't drop weapon: not defined");
    return;
  }
  if(weapon == "none") {
    if(getdvar("scr_dropdebug") == "1")
      println("didn't drop weapon: weapon == none");
    return;
  }
  if(!self hasWeapon(weapon)) {
    if(getdvar("scr_dropdebug") == "1")
      println("didn't drop weapon: don't have it anymore (" + weapon + ")");
    return;
  }
  if(!(self AnyAmmoForWeaponModes(weapon))) {
    if(getdvar("scr_dropdebug") == "1")
      println("didn't drop weapon: no ammo for weapon modes");
    return;
  }
  clipAmmo = self GetWeaponAmmoClip(weapon);
  if(!clipAmmo) {
    if(getdvar("scr_dropdebug") == "1")
      println("didn't drop weapon: no ammo in clip");
    return;
  }
  stockAmmo = self GetWeaponAmmoStock(weapon);
  stockMax = WeaponMaxAmmo(weapon);
  if(stockAmmo > stockMax)
    stockAmmo = stockMax;
  item = self dropItem(weapon);
  if(getdvar("scr_dropdebug") == "1")
    println("dropped weapon: " + weapon);
  self.droppedDeathWeapon = true;
  item ItemWeaponSetAmmo(clipAmmo, stockAmmo);
  item itemRemoveAmmoFromAltModes();
  item.owner = self;
  item.ownersattacker = attacker;
  item thread watchPickup();
  item thread deletePickupAfterAWhile();
}

deletePickupAfterAWhile() {
  self endon("death");
  wait 60;
  if(!isDefined(self)) {
    return;
  }
  self delete();
}

getItemWeaponName() {
  classname = self.classname;
  assert(getsubstr(classname, 0, 7) == "weapon_");
  weapname = getsubstr(classname, 7);
  return weapname;
}

watchPickup() {
  self endon("death");
  weapname = self getItemWeaponName();
  while(1) {
    self waittill("trigger", player, droppedItem);
    if(isDefined(droppedItem)) {
      break;
    }
  }
  if(getdvar("scr_dropdebug") == "1")
    println("picked up weapon: " + weapname + ", " + isDefined(self.ownersattacker));
  assert(isDefined(player.tookWeaponFrom));
  droppedWeaponName = droppedItem getItemWeaponName();
  if(isDefined(player.tookWeaponFrom[droppedWeaponName])) {
    droppedItem.owner = player.tookWeaponFrom[droppedWeaponName];
    droppedItem.ownersattacker = player;
    player.tookWeaponFrom[droppedWeaponName] = undefined;
  }
  droppedItem thread watchPickup();
  if(isDefined(self.ownersattacker) && self.ownersattacker == player) {
    player.tookWeaponFrom[weapname] = self.owner;
  } else {
    player.tookWeaponFrom[weapname] = undefined;
  }
}

itemRemoveAmmoFromAltModes() {
  origweapname = self getItemWeaponName();
  curweapname = weaponAltWeaponName(origweapname);
  altindex = 1;
  while(curweapname != "none" && curweapname != origweapname) {
    self itemWeaponSetAmmo(0, 0, altindex);
    curweapname = weaponAltWeaponName(curweapname);
    altindex++;
  }
}

dropOffhand() {
  grenadeTypes = [];
  for(index = 0; index < grenadeTypes.size; index++) {
    if(!self hasWeapon(grenadeTypes[index])) {
      continue;
    }
    count = self getAmmoCount(grenadeTypes[index]);
    if(!count) {
      continue;
    }
    self dropItem(grenadeTypes[index]);
  }
}

getWeaponBasedGrenadeCount(weapon) {
  return 2;
}

getWeaponBasedSmokeGrenadeCount(weapon) {
  return 1;
}

getFragGrenadeCount() {
  grenadetype = "frag_grenade_mp";
  count = self getammocount(grenadetype);
  return count;
}

getSmokeGrenadeCount() {
  grenadetype = "smoke_grenade_mp";
  count = self getammocount(grenadetype);
  return count;
}

watchWeaponUsage() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self.firingWeapon = false;
  for(;;) {
    self waittill("begin_firing");
    self.hasDoneCombat = true;
    self.firingWeapon = true;
    curWeapon = self getCurrentWeapon();
    switch (weaponClass(curWeapon)) {
      case "rifle":
      case "pistol":
      case "mg":
      case "smg":
      case "spread":
        self thread watchCurrentFiring(curWeapon);
        break;
      default:
        break;
    }
    self waittill("end_firing");
    self.firingWeapon = false;
    if(curWeapon == "bazooka_mp") {
      self setStatLBByName(curWeapon, 1, "shots");
    }
  }
}

watchCurrentFiring(curWeapon) {
  self endon("disconnect");
  startAmmo = self getWeaponAmmoClip(curWeapon);
  wasInLastStand = isDefined(self.lastStand);
  self waittill("end_firing");
  if(!self hasWeapon(curWeapon)) {
    return;
  }
  if(isDefined(self.lastStand) && !wasInLastStand) {
    return;
  }
  shotsFired = startAmmo - (self getWeaponAmmoClip(curWeapon)) + 1;
  if(isDefined(self.lastStandParams) && self.lastStandParams.lastStandStartTime == getTime()) {
    self.hits = 0;
    return;
  }
  assertEx(shotsFired >= 0, shotsFired + " startAmmo: " + startAmmo + " clipAmmo: " + self getWeaponAmmoclip(curWeapon) + " w/ " + curWeapon);
  if(shotsFired <= 0) {
    return;
  }
  self setStatLBByName(curWeapon, shotsFired, "shots");
  self setStatLBByName(curWeapon, self.hits, "hits");
  statTotal = self maps\mp\gametypes\_persistence::statGet("total_shots") + shotsFired;
  statHits = self maps\mp\gametypes\_persistence::statGet("hits") + self.hits;
  statMisses = self maps\mp\gametypes\_persistence::statGet("misses") + shotsFired - self.hits;
  self maps\mp\gametypes\_persistence::statSet("total_shots", statTotal);
  self maps\mp\gametypes\_persistence::statSet("hits", statHits);
  self maps\mp\gametypes\_persistence::statSet("misses", int(max(0, statMisses)));
  self maps\mp\gametypes\_persistence::statSet("accuracy", int(statHits * 10000 / statTotal));
  self.hits = 0;
}

checkHit(sWeapon) {
  switch (weaponClass(sWeapon)) {
    case "rifle":
    case "pistol":
    case "mg":
    case "smg":
      self.hits++;
      break;
    case "spread":
      self.hits = 1;
      break;
    default:
      break;
  }
  if((sWeapon == "bazooka_mp") || isStrStart(sWeapon, "t34") || isStrStart(sWeapon, "panzer")) {
    self setStatLBByName(sWeapon, 1, "hits");
  }
}

friendlyFireCheck(owner, attacker, forcedFriendlyFireRule) {
  if(!isDefined(owner))
    return true;
  if(!level.teamBased)
    return true;
  friendlyFireRule = level.friendlyfire;
  if(isDefined(forcedFriendlyFireRule))
    friendlyFireRule = forcedFriendlyFireRule;
  if(friendlyFireRule != 0)
    return true;
  if(attacker == owner)
    return true;
  if(isplayer(attacker)) {
    if(!isDefined(attacker.pers["team"]))
      return true;
    if(attacker.pers["team"] != owner.pers["team"])
      return true;
  } else if(isai(attacker)) {
    if(attacker.aiteam != owner.pers["team"])
      return true;
  }
  return false;
}

inPoisonArea(player, gasEffectArea) {
  player endon("disconnect");
  player.inPoisonArea = true;
  player startPoisoning();
  while((isDefined(gasEffectArea)) && player istouching(gasEffectArea) && player.sessionstate == "playing") {
    wait(0.25);
  }
  player stopPoisoning();
  player.inPoisonArea = false;
}

watchTabunGrenadeDetonation(owner) {
  self waittill("explode", position);
  level.tabunGasPoisonRadius = weapons_get_dvar_int("tabun_effect_radius", level.tabunGasPoisonRadius);
  level.tabunGasShockRadius = weapons_get_dvar_int("tabun_shock_radius", level.tabunGasShockRadius);
  level.tabunInitialGasShockDuration = weapons_get_dvar_int("tabunInitialGasShockDuration", level.tabunInitialGasShockDuration);
  level.tabunWalkInGasShockDuration = weapons_get_dvar_int("tabunWalkInGasShockDuration", level.tabunWalkInGasShockDuration);
  level.tabunGasDuration = weapons_get_dvar_int("tabunGasDuration", level.tabunGasDuration);
  shockEffectArea = spawn("trigger_radius", position, 0, level.tabunGasShockRadius, level.tabunGasShockRadius * 2);
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(players[i] player_is_driver()) {
      continue;
    }
    if(players[i] istouching(shockEffectArea) && players[i].sessionstate == "playing") {
      players[i].lastPoisonedBy = owner;
      tabunInitialGasShockDuration = level.tabunInitialGasShockDuration;
      if(!players[i] hasPerk("specialty_gas_mask"))
        players[i] shellShock("tabun_gas_mp", tabunInitialGasShockDuration);
      thread inPoisonArea(players[i], shockEffectArea);
      players[i] thread maps\mp\gametypes\_battlechatter_mp::incomingSpecialGrenadeTracking("gas");
    }
  }
  owner thread maps\mp\_dogs::flash_dogs(shockEffectArea);
  gasEffectArea = spawn("trigger_radius", position, 0, level.tabunGasPoisonRadius, level.tabunGasPoisonRadius * 2);
  loopWaitTime = 0.5;
  durationOfTabun = level.tabunGasDuration;
  while(durationOfTabun > 0) {
    players = get_players();
    for(i = 0; i < players.size; i++) {
      if(players[i] player_is_driver())
        continue;
      if((!isDefined(players[i].inPoisonArea)) || (players[i].inPoisonArea == false)) {
        if(players[i] istouching(gasEffectArea) && players[i].sessionstate == "playing") {
          players[i].lastPoisonedBy = owner;
          if(!(players[i] hasPerk("specialty_gas_mask")))
            players[i] shellShock("tabun_gas_mp", level.tabunWalkInGasShockDuration);
          thread inPoisonArea(players[i], gasEffectArea);
        }
      }
    }
    owner thread maps\mp\_dogs::flash_dogs(gasEffectArea);
    wait(loopWaitTime);
    durationOfTabun -= loopWaitTime;
  }
  if(level.tabunGasDuration < level.poisonDuration)
    wait(level.poisonDuration - level.tabunGasDuration);
  shockEffectArea delete();
  gasEffectArea delete();
}

watchGrenadeUsage() {
  self endon("death_or_disconnect");
  self.throwingGrenade = false;
  self.gotPullbackNotify = false;
  if(getdvar("scr_deleteexplosivesonspawn") == "")
    setdvar("scr_deleteexplosivesonspawn", "1");
  if(getdvarint("scr_deleteexplosivesonspawn") == 1) {
    if(isDefined(self.satchelarray)) {
      for(i = 0; i < self.satchelarray.size; i++) {
        if(isDefined(self.satchelarray[i]))
          self.satchelarray[i] delete();
      }
    }
    self.satchelarray = [];
    if(isDefined(self.bettyarray)) {
      for(i = 0; i < self.bettyarray.size; i++) {
        if(isDefined(self.bettyarray[i]))
          self.bettyarray[i] delete();
      }
    }
    self.bettyarray = [];
  } else {
    if(!isDefined(self.bettyarray))
      self.bettyarray = [];
    if(!isDefined(self.satchelarray))
      self.satchelarray = [];
  }
  thread watchBettys();
  thread deleteSatchelAndBettysOnDisconnect();
  thread watchSatchel();
  thread watchSatchelDetonation();
  thread watchSatchelAltDetonation();
  thread deleteSatchelsAndBettysOnDisconnect();
  self thread beginSpecialGrenadeTracking();
  self thread watchForThrowbacks();
  thread watchForGrenadeDuds();
  thread watchForGrenadeLauncherDuds();
  for(;;) {
    self waittill("grenade_pullback", weaponName);
    self setStatLBByName(weaponName, 1, "shots");
    self.hasDoneCombat = true;
    if(weaponName == "mine_bouncing_betty_mp") {
      continue;
    }
    self.throwingGrenade = true;
    self.gotPullbackNotify = true;
    if(weaponName == "satchel_charge_mp")
      self beginSatchelTracking();
    else
      self beginGrenadeTracking();
  }
}

beginGrenadeTracking() {
  self endon("death_or_disconnect");
  startTime = getTime();
  self waittill("grenade_fire", grenade, weaponName);
  if((getTime() - startTime > 1000))
    grenade.isCooked = true;
  if(weaponName == "frag_grenade_mp") {
    grenade thread maps\mp\gametypes\_shellshock::grenade_earthQuake();
    grenade.originalOwner = self;
  }
  self.throwingGrenade = false;
}

beginSpecialGrenadeTracking() {
  self notify("grenadeTrackingStart");
  self endon("grenadeTrackingStart");
  self endon("disconnect");
  for(;;) {
    self waittill("grenade_fire", grenade, weaponName, parent);
    if(weaponName == "tabun_gas_mp") {
      grenade thread watchTabunGrenadeDetonation(self);
    } else if(weaponName == "signal_flare_mp") {
      grenade thread maps\mp\_flare::watchFlareDetonation(self);
    } else if(weaponName == "sticky_grenade_mp" || weaponName == "satchel_charge_mp") {
      grenade thread checkStuckToPlayer();
    }
  }
}

checkStuckToPlayer() {
  self waittill("stuck_to_player");
  self.stuckToPlayer = true;
}

beginSatchelTracking() {
  self endon("death_or_disconnect");
  self waittill_any("grenade_fire", "weapon_change");
  self.throwingGrenade = false;
}

watchForThrowbacks() {
  self endon("death_or_disconnect");
  for(;;) {
    self waittill("grenade_fire", grenade, weapname);
    if(self.gotPullbackNotify) {
      self.gotPullbackNotify = false;
      continue;
    }
    if(!isSubStr(weapname, "frag_")) {
      continue;
    }
    grenade.threwBack = true;
    grenade thread maps\mp\gametypes\_shellshock::grenade_earthQuake();
    grenade.originalOwner = self;
  }
}

watchSatchel() {
  self endon("spawned_player");
  self endon("disconnect");
  while(1) {
    self waittill("grenade_fire", satchel, weapname);
    if(weapname == "satchel_charge" || weapname == "satchel_charge_mp") {
      if(!self.satchelarray.size)
        self thread watchsatchelAltDetonate();
      self.satchelarray[self.satchelarray.size] = satchel;
      satchel.owner = self;
      satchel thread bombDetectionTrigger_wait(self.pers["team"]);
      satchel thread maps\mp\gametypes\_shellshock::satchel_earthQuake();
      satchel thread satchelDamage();
    }
  }
}

turnGrenadeIntoADud(weapname) {
  if(level.grenadeLauncherDudTime >= (maps\mp\gametypes\_globallogic::getTimePassed() / 1000)) {
    if(isSubStr(weapname, "gl_")) {
      self makeGrenadeDud();
    }
  }
}

watchForGrenadeDuds() {
  self endon("spawned_player");
  self endon("disconnect");
  while(1) {
    self waittill("grenade_fire", grenade, weapname);
    grenade turnGrenadeIntoADud(weapname);
  }
}

watchForGrenadeLauncherDuds() {
  self endon("spawned_player");
  self endon("disconnect");
  while(1) {
    self waittill("grenade_launncher_fire", grenade, weapname);
    grenade turnGrenadeIntoADud(weapname);
  }
}

watchBettys() {
  self endon("spawned_player");
  self endon("disconnect");
  self.bettyarray = [];
  while(1) {
    self waittill("grenade_fire", betty, weapname);
    if(weapname == "mine_bouncing_betty_mp") {
      self.bettyarray[self.bettyarray.size] = betty;
      betty.owner = self;
      betty thread bettyDetonation();
      betty thread bombDetectionTrigger_wait(self.pers["team"]);
      betty maps\mp\_entityheadicons::setEntityHeadIcon(self.pers["team"], (0, 0, 20));
      betty thread bettyDamage();
    }
  }
}

waitTillNotMoving() {
  prevorigin = self.origin;
  while(1) {
    wait .15;
    if(self.origin == prevorigin) {
      break;
    }
    prevorigin = self.origin;
  }
}

bettyDetonation() {
  self endon("death");
  self waitTillNotMoving();
  level.bettyDetonateRadius = weapons_get_dvar_int("bettyDetonateRadius", level.bettyDetonateRadius);
  level.bettyUpVelocity = weapons_get_dvar_int("bettyUpVelocity", level.bettyUpVelocity);
  level.bettyTimeBeforeDetonate = weapons_get_dvar("bettyTimeBeforeDetonate", level.bettyTimeBeforeDetonate);
  damagearea = spawn("trigger_radius", self.origin + (0, 0, 0 - level.bettyDetonateRadius), level.aiTriggerSpawnFlags, level.bettyDetonateRadius, level.bettyDetonateRadius + 36);
  self thread deleteOnDeath(damagearea);
  rangeOrigin = damagearea.origin + (0, 0, level.bettyDetonateRadius);
  while(1) {
    damagearea waittill("trigger", triggerer);
    if(getdvarint("scr_bettydebug") != 1) {
      if(isDefined(self.owner) && triggerer == self.owner)
        continue;
      if(!friendlyFireCheck(self.owner, triggerer, 0))
        continue;
      if(triggerer.origin[2] < rangeOrigin[2] - 24)
        continue;
    }
    if((weapons_get_dvar_int("scr_bettyTriggerDamageTraceEnabled", level.bettyTriggerDamageTraceEnabled)) == 1) {
      if(triggerer damageConeTrace(self.origin + (0, 0, 12), self) > 0) {
        break;
      }
      wait(weapons_get_dvar("scr_bettyTriggerLoopWait", level.bettyTriggerLoopWait));
    } else {
      break;
    }
  }
  triggerer thread deathDodger();
  detonateTime = gettime();
  self playSound("betty_activated");
  self maps\mp\_entityheadicons::setEntityHeadIcon("none");
  self shootup(level.bettyUpVelocity);
  fx = playFXOnTag(level.bettyFXid, self, "tag_flash");
  level.bettyTimeBeforeDetonate = weapons_get_dvar("bettyTimeBeforeDetonate", level.bettyTimeBeforeDetonate);
  self thread waitAndDetonate(level.bettyTimeBeforeDetonate);
}

deathDodger() {
  self endon("death_or_disconnect");
  wait(0.2 + level.bettyTimeBeforeDetonate);
  self notify("death_dodger");
}

deleteOnDeath(ent) {
  self waittill("death");
  wait .05;
  if(isDefined(ent))
    ent delete();
}

watchSatchelAltDetonation() {
  self endon("death_or_disconnect");
  while(1) {
    self waittill("alt_detonate");
    weap = self getCurrentWeapon();
    if(weap != "satchel_charge_mp") {
      newarray = [];
      for(i = 0; i < self.satchelarray.size; i++) {
        satchel = self.satchelarray[i];
        if(isDefined(self.satchelarray[i]))
          satchel thread waitAndDetonate(0.1);
      }
      self.satchelarray = newarray;
      self notify("detonated");
    }
  }
}

watchSatchelAltDetonate() {
  self endon("death_or_disconnect");
  self endon("detonated");
  level endon("game_ended");
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
      if(!self.satchelarray.size) {
        return;
      }
      self notify("alt_detonate");
    }
    wait(0.05);
  }
}

watchSatchelDetonation() {
  self endon("death_or_disconnect");
  while(1) {
    self waittill("detonate");
    weap = self getCurrentWeapon();
    if(weap == "satchel_charge_mp") {
      for(i = 0; i < self.satchelarray.size; i++) {
        if(isDefined(self.satchelarray[i]))
          self.satchelarray[i] thread waitAndDetonate(0.1);
      }
      self.satchelarray = [];
    }
  }
}

waitAndDetonate(delay) {
  self endon("death");
  wait(delay);
  self detonate();
}

deleteSatchelAndbettysOnDisconnect() {
  self endon("death");
  self waittill("disconnect");
  bettyarray = self.bettyarray;
  satchelarray = self.satchelarray;
  wait .05;
  for(i = 0; i < bettyarray.size; i++) {
    if(isDefined(bettyarray[i]))
      bettyarray[i] delete();
  }
  for(i = 0; i < satchelarray.size; i++) {
    if(isDefined(satchelarray[i]))
      satchelarray[i] delete();
  }
}

deleteSatchelsAndbettysOnDisconnect() {
  self endon("death");
  self waittill("disconnect");
  satchelarray = self.satchelarray;
  bettyarray = self.bettyarray;
  wait .05;
  for(i = 0; i < satchelarray.size; i++) {
    if(isDefined(satchelarray[i]))
      satchelarray[i] delete();
  }
  for(i = 0; i < bettyarray.size; i++) {
    if(isDefined(bettyarray[i]))
      bettyarray[i] delete();
  }
}

bettyDamage() {
  self endon("death");
  self setCanDamage(true);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  attacker = undefined;
  starttime = gettime();
  while(1) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelName, tagName, partName, iDFlags);
    if(!isplayer(attacker)) {
      continue;
    }
    if(!friendlyFireCheck(self.owner, attacker)) {
      continue;
    }
    if(damage < 5) {
      continue;
    }
    break;
  }
  if(level.bettyexplodethisframe)
    wait .1 + randomfloat(.4);
  else
    wait .05;
  if(!isDefined(self)) {
    return;
  }
  level.bettyexplodethisframe = true;
  thread resetbettyExplodeThisFrame();
  self maps\mp\_entityheadicons::setEntityHeadIcon("none");
  if(isDefined(type) && (isSubStr(type, "MOD_GRENADE") || isSubStr(type, "MOD_EXPLOSIVE")))
    self.wasChained = true;
  if(isDefined(iDFlags) && (iDFlags &level.iDFLAGS_PENETRATION))
    self.wasDamagedFromBulletPenetration = true;
  self.wasDamaged = true;
  if(isDefined(attacker) && isDefined(attacker.pers["team"]) && isDefined(self.owner) && isDefined(self.owner.pers["team"])) {
    if((attacker.pers["team"] != self.owner.pers["team"]) || ((game["dialog"]["gametype"] == "freeforall") && (attacker != self.owner))) {
      attacker notify("destroyed_explosive");
      detonateTime = gettime();
      if(startTime + 3000 > detonateTime) {
        if(attacker != self.owner)
          self.wasJustPlanted = true;
      }
    }
  }
  self detonate(attacker);
}

resetbettyExplodeThisFrame() {
  wait .05;
  level.bettyexplodethisframe = false;
}

satchelDamage() {
  self endon("death");
  self setCanDamage(true);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  attacker = undefined;
  while(1) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelName, tagName, partName, iDFlags);
    if(!isplayer(attacker)) {
      continue;
    }
    if(!friendlyFireCheck(self.owner, attacker)) {
      continue;
    }
    if(damage < 5) {
      continue;
    }
    break;
  }
  if(level.satchelexplodethisframe)
    wait .1 + randomfloat(.4);
  else
    wait .05;
  if(!isDefined(self)) {
    return;
  }
  level.satchelexplodethisframe = true;
  thread resetSatchelExplodeThisFrame();
  self maps\mp\_entityheadicons::setEntityHeadIcon("none");
  if(isDefined(type) && (isSubStr(type, "MOD_GRENADE_SPLASH") || isSubStr(type, "MOD_GRENADE") || isSubStr(type, "MOD_EXPLOSIVE")))
    self.wasChained = true;
  if(isDefined(iDFlags) && (iDFlags &level.iDFLAGS_PENETRATION))
    self.wasDamagedFromBulletPenetration = true;
  self.wasDamaged = true;
  if(isDefined(attacker) && isDefined(attacker.pers["team"]) && isDefined(self.owner) && isDefined(self.owner.pers["team"])) {
    if(attacker.pers["team"] != self.owner.pers["team"])
      attacker notify("destroyed_explosive");
  }
  self detonate(attacker);
}

resetSatchelExplodeThisFrame() {
  wait .05;
  level.satchelexplodethisframe = false;
}

saydamaged(orig, amount) {
  for(i = 0; i < 60; i++) {
    print3d(orig, "damaged! " + amount);
    wait .05;
  }
}

bombDetectionTrigger_wait(ownerTeam) {
  self endon("death");
  waitTillNotMoving();
  if(level.oldschool) {
    return;
  }
  self thread bombDetectionTrigger(ownerTeam);
}

bombDetectionTrigger(ownerTeam) {
  trigger = spawn("trigger_radius", self.origin - (0, 0, 128), 0, 512, 256);
  trigger.detectId = "trigger" + getTime() + randomInt(1000000);
  trigger thread detectIconWaiter(level.otherTeam[ownerTeam]);
  self waittill("death");
  trigger notify("end_detection");
  if(isDefined(trigger.bombSquadIcon))
    trigger.bombSquadIcon destroy();
  trigger delete();
}

detectIconWaiter(detectTeam) {
  self endon("end_detection");
  level endon("game_ended");
  while(!level.gameEnded) {
    self waittill("trigger", player);
    if(isai(player)) {
      continue;
    }
    if(!isDefined(player.detectExplosives) || !player.detectExplosives) {
      continue;
    }
    if(player.team != detectTeam && game["dialog"]["gametype"] != "freeforall") {
      continue;
    }
    if(isDefined(player.bombSquadIds[self.detectId])) {
      continue;
    }
    player thread showHeadIcon(self);
  }
}

setupBombSquad() {
  self.bombSquadIds = [];
  if(self.detectExplosives && !self.bombSquadIcons.size) {
    for(index = 0; index < 4; index++) {
      self.bombSquadIcons[index] = newClientHudElem(self);
      self.bombSquadIcons[index].x = 0;
      self.bombSquadIcons[index].y = 0;
      self.bombSquadIcons[index].z = 0;
      self.bombSquadIcons[index].alpha = 0;
      self.bombSquadIcons[index].archived = true;
      self.bombSquadIcons[index] setShader("waypoint_bombsquad", 14, 14);
      self.bombSquadIcons[index] setWaypoint(false);
      self.bombSquadIcons[index].detectId = "";
    }
  } else if(!self.detectExplosives) {
    for(index = 0; index < self.bombSquadIcons.size; index++)
      self.bombSquadIcons[index] destroy();
    self.bombSquadIcons = [];
  }
}

showHeadIcon(trigger) {
  triggerDetectId = trigger.detectId;
  useId = -1;
  for(index = 0; index < 4; index++) {
    detectId = self.bombSquadIcons[index].detectId;
    if(detectId == triggerDetectId) {
      return;
    }
    if(detectId == "")
      useId = index;
  }
  if(useId < 0) {
    return;
  }
  self.bombSquadIds[triggerDetectId] = true;
  self.bombSquadIcons[useId].x = trigger.origin[0];
  self.bombSquadIcons[useId].y = trigger.origin[1];
  self.bombSquadIcons[useId].z = trigger.origin[2] + 24 + 128;
  self.bombSquadIcons[useId] fadeOverTime(0.25);
  self.bombSquadIcons[useId].alpha = 1;
  self.bombSquadIcons[useId].detectId = trigger.detectId;
  while(isAlive(self) && isDefined(trigger) && self isTouching(trigger))
    wait(0.05);
  if(!isDefined(self)) {
    return;
  }
  self.bombSquadIcons[useId].detectId = "";
  self.bombSquadIcons[useId] fadeOverTime(0.25);
  self.bombSquadIcons[useId].alpha = 0;
  self.bombSquadIds[triggerDetectId] = undefined;
}

getDamageableEnts(pos, radius, doLOS, startRadius) {
  ents = [];
  if(!isDefined(doLOS))
    doLOS = false;
  if(!isDefined(startRadius))
    startRadius = 0;
  players = level.players;
  for(i = 0; i < players.size; i++) {
    if(!isalive(players[i]) || players[i].sessionstate != "playing") {
      continue;
    }
    playerpos = players[i].origin + (0, 0, 32);
    dist = distance(pos, playerpos);
    if(dist < radius && (!doLOS || weaponDamageTracePassed(pos, playerpos, startRadius, undefined))) {
      newent = spawnStruct();
      newent.isPlayer = true;
      newent.isADestructable = false;
      newent.entity = players[i];
      newent.damageCenter = playerpos;
      ents[ents.size] = newent;
    }
  }
  grenades = getEntArray("grenade", "classname");
  for(i = 0; i < grenades.size; i++) {
    entpos = grenades[i].origin;
    dist = distance(pos, entpos);
    if(dist < radius && (!doLOS || weaponDamageTracePassed(pos, entpos, startRadius, grenades[i]))) {
      newent = spawnStruct();
      newent.isPlayer = false;
      newent.isADestructable = false;
      newent.entity = grenades[i];
      newent.damageCenter = entpos;
      ents[ents.size] = newent;
    }
  }
  destructibles = getEntArray("destructible", "targetname");
  for(i = 0; i < destructibles.size; i++) {
    entpos = destructibles[i].origin;
    dist = distance(pos, entpos);
    if(dist < radius && (!doLOS || weaponDamageTracePassed(pos, entpos, startRadius, destructibles[i]))) {
      newent = spawnStruct();
      newent.isPlayer = false;
      newent.isADestructable = false;
      newent.entity = destructibles[i];
      newent.damageCenter = entpos;
      ents[ents.size] = newent;
    }
  }
  destructables = getEntArray("destructable", "targetname");
  for(i = 0; i < destructables.size; i++) {
    entpos = destructables[i].origin;
    dist = distance(pos, entpos);
    if(dist < radius && (!doLOS || weaponDamageTracePassed(pos, entpos, startRadius, destructables[i]))) {
      newent = spawnStruct();
      newent.isPlayer = false;
      newent.isADestructable = true;
      newent.entity = destructables[i];
      newent.damageCenter = entpos;
      ents[ents.size] = newent;
    }
  }
  return ents;
}

weaponDamageTracePassed(from, to, startRadius, ignore) {
  midpos = undefined;
  diff = to - from;
  if(lengthsquared(diff) < startRadius * startRadius)
    midpos = to;
  dir = vectornormalize(diff);
  midpos = from + (dir[0] * startRadius, dir[1] * startRadius, dir[2] * startRadius);
  trace = bulletTrace(midpos, to, false, ignore);
  if(getdvarint("scr_damage_debug") != 0) {
    if(trace["fraction"] == 1) {
      thread debugline(midpos, to, (1, 1, 1));
    } else {
      thread debugline(midpos, trace["position"], (1, .9, .8));
      thread debugline(trace["position"], to, (1, .4, .3));
    }
  }
  return (trace["fraction"] == 1);
}

damageEnt(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, damagepos, damagedir) {
  if(self.isPlayer) {
    self.damageOrigin = damagepos;
    self.entity thread[[level.callbackPlayerDamage]](eInflictor, eAttacker, iDamage, 0, sMeansOfDeath, sWeapon, damagepos, damagedir, "none", 0);
  } else {
    if(self.isADestructable && (sWeapon == "artillery_mp" || sWeapon == "mine_bouncing_betty_mp")) {
      return;
    }
    self.entity notify("damage", iDamage, eAttacker, (0, 0, 0), (0, 0, 0), "mod_explosive", "", "");
  }
}

debugline(a, b, color) {
  for(i = 0; i < 30 * 20; i++) {
    line(a, b, color);
    wait .05;
  }
}

onWeaponDamage(eInflictor, sWeapon, meansOfDeath, damage) {
  self endon("death_or_disconnect");
  switch (sWeapon) {
    case "concussion_grenade_mp":
      radius = 512;
      scale = 1 - (distance(self.origin, eInflictor.origin) / radius);
      if(scale < 0)
        scale = 0;
      time = 2 + (4 * scale);
      wait(0.05);
      self.concussionEndTime = getTime() + (time * 1000);
      break;
    default:
      maps\mp\gametypes\_shellshock::shellshockOnDamage(meansOfDeath, damage);
      break;
  }
}

isPrimaryWeapon(weaponname) {
  return isDefined(level.primary_weapon_array[weaponname]);
}

isSideArm(weaponname) {
  return isDefined(level.side_arm_array[weaponname]);
}

isInventory(weaponname) {
  return isDefined(level.inventory_array[weaponname]);
}

isGrenade(weaponname) {
  return isDefined(level.grenade_array[weaponname]);
}

getWeaponClass_array(current) {
  if(isPrimaryWeapon(current))
    return level.primary_weapon_array;
  else if(isSideArm(current))
    return level.side_arm_array;
  else if(isGrenade(current))
    return level.grenade_array;
  else
    return level.inventory_array;
}

updateStowedWeapon() {
  self endon("spawned");
  self endon("killed_player");
  self endon("disconnect");
  self.tag_stowed_back = undefined;
  self.tag_stowed_hip = undefined;
  team = self.pers["team"];
  class = self.pers["class"];
  while(true) {
    self waittill("weapon_change", newWeapon);
    self.weapon_array_primary = [];
    self.weapon_array_sidearm = [];
    self.weapon_array_grenade = [];
    self.weapon_array_inventory = [];
    weaponsList = self GetWeaponsList();
    for(idx = 0; idx < weaponsList.size; idx++) {
      if(isPrimaryWeapon(weaponsList[idx]))
        self.weapon_array_primary[self.weapon_array_primary.size] = weaponsList[idx];
      else if(isSideArm(weaponsList[idx]))
        self.weapon_array_sidearm[self.weapon_array_sidearm.size] = weaponsList[idx];
      else if(isGrenade(weaponsList[idx]))
        self.weapon_array_grenade[self.weapon_array_grenade.size] = weaponsList[idx];
      else if(isInventory(weaponsList[idx]))
        self.weapon_array_inventory[self.weapon_array_inventory.size] = weaponsList[idx];
    }
    detach_all_weapons();
    stow_on_back();
    stow_on_hip();
  }
}

forceStowedWeaponUpdate() {
  detach_all_weapons();
  stow_on_back();
  stow_on_hip();
}

detachCarryObjectModel() {
  if(isDefined(self.carryObject) && isDefined(self.carryObject maps\mp\gametypes\_gameobjects::getVisibleCarrierModel())) {
    if(isDefined(self.tag_stowed_back)) {
      self detach(self.tag_stowed_back, "tag_stowed_back");
      self.tag_stowed_back = undefined;
    }
  }
}

detach_all_weapons() {
  if(isDefined(self.tag_stowed_back)) {
    self detach(self.tag_stowed_back, "tag_stowed_back");
    self.tag_stowed_back = undefined;
  }
  if(isDefined(self.tag_stowed_hip)) {
    detach_model = getWeaponModel(self.tag_stowed_hip);
    self detach(detach_model, "tag_stowed_hip_rear");
    self.tag_stowed_hip = undefined;
  }
}

stow_on_back() {
  current = self getCurrentWeapon();
  self.tag_stowed_back = undefined;
  if(isDefined(self.carryObject) && isDefined(self.carryObject maps\mp\gametypes\_gameobjects::getVisibleCarrierModel())) {
    self.tag_stowed_back = self.carryObject maps\mp\gametypes\_gameobjects::getVisibleCarrierModel();
  } else if(self hasWeapon("m2_flamethrower_mp")) {
    return;
  } else if(self hasWeapon("bazooka_mp") && current != "bazooka_mp") {
    self.tag_stowed_back = "weapon_mp_bazooka_attach";
  } else {
    for(idx = 0; idx < self.weapon_array_primary.size; idx++) {
      index_weapon = self.weapon_array_primary[idx];
      assertex(isDefined(index_weapon), "Primary weapon list corrupted.");
      if(index_weapon == current) {
        continue;
      }
      if(isSubStr(current, "gl_") || isSubStr(index_weapon, "gl_")) {
        index_weapon_tok = strtok(index_weapon, "_");
        current_tok = strtok(current, "_");
        for(i = 0; i < index_weapon_tok.size; i++) {
          if(!isSubStr(current, index_weapon_tok[i]) || index_weapon_tok.size != current_tok.size) {
            i = 0;
            break;
          }
        }
        if(i == index_weapon_tok.size)
          continue;
      }
      assertex(isDefined(self.curclass), "Player missing current class");
      if(isDefined(self.custom_class) && isDefined(self.custom_class[self.class_num]["camo_num"]) && isSubStr(index_weapon, self.pers["primaryWeapon"]) && isSubStr(self.curclass, "CUSTOM"))
        self.tag_stowed_back = getWeaponModel(index_weapon, self.custom_class[self.class_num]["camo_num"]);
      else
        self.tag_stowed_back = getWeaponModel(index_weapon, 0);
    }
  }
  if(!isDefined(self.tag_stowed_back)) {
    return;
  }
  self attach(self.tag_stowed_back, "tag_stowed_back", true);
}

stow_on_hip() {
  current = self getCurrentWeapon();
  self.tag_stowed_hip = undefined;
  for(idx = 0; idx < self.weapon_array_inventory.size; idx++) {
    if(self.weapon_array_inventory[idx] == current) {
      continue;
    }
    if(!self GetWeaponAmmoStock(self.weapon_array_inventory[idx])) {
      continue;
    }
    self.tag_stowed_hip = self.weapon_array_inventory[idx];
  }
  if(!isDefined(self.tag_stowed_hip)) {
    return;
  }
  if(self.tag_stowed_hip == "satchel_charge_mp" || self.tag_stowed_hip == "mine_bouncing_betty_mp") {
    self.tag_stowed_hip = undefined;
    return;
  }
  weapon_model = getWeaponModel(self.tag_stowed_hip);
  self attach(weapon_model, "tag_stowed_hip_rear", true);
}

stow_inventory(inventories, current) {
  if(isDefined(self.inventory_tag)) {
    detach_model = getweaponmodel(self.inventory_tag);
    self detach(detach_model, "tag_stowed_hip_rear");
    self.inventory_tag = undefined;
  }
  if(!isDefined(inventories[0]) || self GetWeaponAmmoStock(inventories[0]) == 0) {
    return;
  }
  if(inventories[0] != current) {
    self.inventory_tag = inventories[0];
    weapon_model = getweaponmodel(self.inventory_tag);
    self attach(weapon_model, "tag_stowed_hip_rear", true);
  }
}

weapons_get_dvar_int(dvar, def) {
  return int(weapons_get_dvar(dvar, def));
}

weapons_get_dvar(dvar, def) {
  if(getdvar(dvar) != "") {
    return getdvarfloat(dvar);
  } else {
    setdvar(dvar, def);
    return def;
  }
}

player_is_driver() {
  if(!isalive(self))
    return false;
  vehicle = self GetVehicleOccupied();
  if(isDefined(vehicle)) {
    seat = vehicle GetOccupantSeat(self);
    if(isDefined(seat) && seat == 0)
      return true;
  }
  return false;
}