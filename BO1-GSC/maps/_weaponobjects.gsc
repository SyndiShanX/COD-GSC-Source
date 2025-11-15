/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_weaponobjects.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;

init() {
  level thread onPlayerConnect();
  level.claymoreFXid = LoadFX("weapon/claymore/fx_claymore_laser");
  level.watcherWeaponNames = [];
  level.watcherWeaponNames = getWatcherWeapons();
  level.retrievableWeapons = [];
  level.retrievableWeapons = getRetrievableWeapons();
  setup_retrievable_hint_strings();
  level.weaponobjectexplodethisframe = false;
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
    self create_base_watchers();
    self create_satchel_watcher();
    self create_ied_watcher();
    if(getDvar(#"zombiemode") == "1") {
      self create_claymore_watcher_zm();
      self create_ballistic_knife_watcher_zm("knife_ballistic", "knife_ballistic_zm");
      self create_ballistic_knife_watcher_zm("knife_ballistic_upgraded", "knife_ballistic_upgraded_zm");
      self create_ballistic_knife_watcher_zm("knife_ballistic_bowie", "knife_ballistic_bowie_zm");
      self create_ballistic_knife_watcher_zm("knife_ballistic_bowie_upgraded", "knife_ballistic_bowie_upgraded_zm");
    } else {
      self create_ballistic_knife_watcher();
    }
    self setup_retrievable_watcher();
    self thread watch_weapon_object_usage();
  }
}

setup_retrievable_hint_strings() {
  create_retrievable_hint("hatchet", & "WEAPON_HATCHET_PICKUP");
  create_retrievable_hint("satchel_charge", & "WEAPON_SATCHEL_CHARGE_PICKUP");
  create_retrievable_hint("claymore", & "WEAPON_CLAYMORE_PICKUP");
}

create_retrievable_hint(name, hint) {
  retrieveHint = spawnStruct();
  retrieveHint.name = name;
  retrieveHint.hint = hint;
  level.retrieveHints[name] = retrieveHint;
}

create_base_watchers() {
  for(i = 0; i < level.watcherWeaponNames.size; i++) {
    watcherName = GetSubStr(level.watcherWeaponNames[i], 0, level.watcherWeaponNames[i].size - 3);
    self create_weapon_object_watcher(watcherName, level.watcherWeaponNames[i], self.team);
  }
  for(i = 0; i < level.retrievableWeapons.size; i++) {
    watcherName = GetSubStr(level.retrievableWeapons[i], 0, level.retrievableWeapons[i].size - 3);
    self create_weapon_object_watcher(watcherName, level.retrievableWeapons[i], self.team);
  }
}

create_claymore_watcher() {
  watcher = self create_use_weapon_object_watcher("claymore", "claymore_sp", self.team);
  watcher.watchForFire = true;
  watcher.detonate = ::weapon_detonate;
  watcher.onSpawnFX = ::on_spawn_claymore_fx;
  watcher.activateSound = "wpn_claymore_alert";
  detectionConeAngle = weapons_get_dvar_int("scr_weaponobject_coneangle");
  watcher.detectionDot = cos(detectionConeAngle);
  watcher.detectionMinDist = weapons_get_dvar_int("scr_weaponobject_mindist");
  watcher.detectionGracePeriod = weapons_get_dvar("scr_weaponobject_graceperiod");
  watcher.detonateRadius = weapons_get_dvar_int("scr_weaponobject_radius");
}

create_claymore_watcher_zm() {
  watcher = self create_use_weapon_object_watcher("claymore", "claymore_zm", self.team);
  watcher.pickup = level.pickup_claymores;
  watcher.pickup_trigger_listener = level.pickup_claymores_trigger_listener;
  watcher.skip_weapon_object_damage = true;
}

on_spawn_claymore_fx() {
  self endon("death");
  while(1) {
    self waittill_not_moving();
    org = self getTagOrigin("tag_fx");
    ang = self getTagAngles("tag_fx");
    fx = spawnFx(level.claymoreFXid, org, anglesToForward(ang), anglesToUp(ang));
    triggerfx(fx);
    self thread clear_fx_on_death(fx);
    originalOrigin = self.origin;
    while(1) {
      wait .25;
      if(self.origin != originalOrigin) {
        break;
      }
    }
    fx delete();
  }
}

clear_fx_on_death(fx) {
  fx endon("death");
  self waittill("death");
  fx delete();
}

create_satchel_watcher() {
  watcher = self create_use_weapon_object_watcher("satchel_charge", "satchel_charge_sp", self.team);
  watcher.altDetonate = true;
  watcher.watchForFire = true;
  watcher.disarmable = true;
  watcher.headIcon = false;
  watcher.detonate = ::weapon_detonate;
  watcher.altWeapon = "satchel_charge_detonator_sp";
}

create_ied_watcher() {
  watcher = self create_use_weapon_object_watcher("ied", "ied_sp", self.team);
  watcher.altDetonate = true;
  watcher.watchForFire = true;
  watcher.disarmable = false;
  watcher.headIcon = false;
  watcher.detonate = ::weapon_detonate;
  watcher.altWeapon = "satchel_charge_detonator_sp";
}

create_ballistic_knife_watcher() {
  watcher = self create_use_weapon_object_watcher("knife_ballistic", "knife_ballistic_sp", self.team);
  watcher.onSpawn = maps\_ballistic_knife::on_spawn;
  watcher.onSpawnRetrieveTriggers = maps\_ballistic_knife::on_spawn_retrieve_trigger;
  watcher.storeDifferentObject = true;
}

create_ballistic_knife_watcher_zm(name, weapon) {
  watcher = self create_use_weapon_object_watcher(name, weapon, self.team);
  watcher.onSpawn = maps\_ballistic_knife::on_spawn;
  watcher.onSpawnRetrieveTriggers = maps\_ballistic_knife::on_spawn_retrieve_trigger;
  watcher.storeDifferentObject = true;
  self notify("zmb_lost_knife");
}

create_use_weapon_object_watcher(name, weapon, ownerTeam) {
  weaponObjectWatcher = create_weapon_object_watcher(name, weapon, ownerTeam);
  return weaponObjectWatcher;
}

weapon_detonate(attacker) {
  if(isDefined(attacker)) {
    self Detonate(attacker);
  } else {
    self Detonate();
  }
}

create_weapon_object_watcher(name, weapon, ownerTeam) {
  if(!isDefined(self.weaponObjectWatcherArray)) {
    self.weaponObjectWatcherArray = [];
  }
  weaponObjectWatcher = get_weapon_object_watcher(name);
  if(!isDefined(weaponObjectWatcher)) {
    weaponObjectWatcher = spawnStruct();
    self.weaponObjectWatcherArray[self.weaponObjectWatcherArray.size] = weaponObjectWatcher;
  }
  if(getDvar(#"scr_deleteexplosivesonspawn") == "")
    setdvar("scr_deleteexplosivesonspawn", "1");
  if(GetDvarInt(#"scr_deleteexplosivesonspawn") == 1) {
    weaponObjectWatcher delete_weapon_object_array();
  }
  if(!isDefined(weaponObjectWatcher.objectArray))
    weaponObjectWatcher.objectArray = [];
  weaponObjectWatcher.name = name;
  weaponObjectWatcher.ownerTeam = ownerTeam;
  weaponObjectWatcher.type = "use";
  weaponObjectWatcher.weapon = weapon;
  weaponObjectWatcher.watchForFire = false;
  weaponObjectWatcher.disarmable = false;
  weaponObjectWatcher.altDetonate = false;
  weaponObjectWatcher.detectable = true;
  weaponObjectWatcher.headIcon = true;
  weaponObjectWatcher.activateSound = undefined;
  weaponObjectWatcher.altWeapon = undefined;
  weaponObjectWatcher.onSpawn = undefined;
  weaponObjectWatcher.onSpawnFX = undefined;
  weaponObjectWatcher.onSpawnRetrieveTriggers = undefined;
  weaponObjectWatcher.onDetonated = undefined;
  weaponObjectWatcher.detonate = undefined;
  return weaponObjectWatcher;
}

setup_retrievable_watcher() {
  for(i = 0; i < level.retrievableWeapons.size; i++) {
    watcher = get_weapon_object_watcher_by_weapon(level.retrievableWeapons[i]);
    if(!isDefined(watcher.onSpawnRetrieveTriggers))
      watcher.onSpawnRetrieveTriggers = ::on_spawn_retrievable_weapon_object;
    if(!isDefined(watcher.pickUp))
      watcher.pickUp = ::pick_up;
  }
}

watch_weapon_object_usage() {
  self endon("death");
  self endon("disconnect");
  if(!isDefined(self.weaponObjectWatcherArray)) {
    self.weaponObjectWatcherArray = [];
  }
  self thread watch_weapon_object_spawn();
  self thread watch_weapon_projectile_object_spawn();
  self thread watch_weapon_object_detonation();
  self thread watch_weapon_object_alt_detonation();
  self thread watch_weapon_object_alt_detonate();
  self thread delete_weapon_objects_on_disconnect();
}

watch_weapon_object_spawn() {
  self endon("disconnect");
  self endon("death");
  while(1) {
    self waittill("grenade_fire", weapon, weapname);
    watcher = get_weapon_object_watcher_by_weapon(weapname);
    if(isDefined(watcher)) {
      self add_weapon_object(watcher, weapon);
    }
  }
}

watch_weapon_projectile_object_spawn() {
  self endon("disconnect");
  self endon("death");
  while(1) {
    self waittill("missile_fire", weapon, weapname);
    watcher = get_weapon_object_watcher_by_weapon(weapname);
    if(isDefined(watcher)) {
      self add_weapon_object(watcher, weapon);
    }
  }
}

watch_weapon_object_detonation() {
  self endon("death");
  self endon("disconnect");
  while(1) {
    self waittill("detonate");
    weap = self GetCurrentWeapon();
    watcher = get_weapon_object_watcher_by_weapon(weap);
    if(isDefined(watcher)) {
      watcher detonate_weapon_object_array();
    }
  }
}

watch_weapon_object_alt_detonation() {
  self endon("death");
  self endon("disconnect");
  self endon("no_alt_detonate");
  while(1) {
    self waittill("alt_detonate");
    for(watcher = 0; watcher < self.weaponObjectWatcherArray.size; watcher++) {
      if(self.weaponObjectWatcherArray[watcher].altDetonate) {
        self.weaponObjectWatcherArray[watcher] detonate_weapon_object_array();
      }
    }
  }
}

watch_weapon_object_alt_detonate() {
  self endon("death");
  self endon("disconnect");
  self endon("detonated");
  level endon("game_ended");
  self endon("no_alt_detonate");
  for(;;) {
    self waittill("action_notify_use_doubletap");
    self notify("alt_detonate");
  }
}

delete_weapon_objects_on_disconnect() {
  self endon("death");
  self waittill("disconnect");
  if(!isDefined(self.weaponObjectWatcherArray))
    return;
  watchers = [];
  for(watcher = 0; watcher < self.weaponObjectWatcherArray.size; watcher++) {
    weaponObjectWatcher = spawnStruct();
    watchers[watchers.size] = weaponObjectWatcher;
    weaponObjectWatcher.objectArray = [];
    if(isDefined(self.weaponObjectWatcherArray[watcher].objectArray)) {
      weaponObjectWatcher.objectArray = self.weaponObjectWatcherArray[watcher].objectArray;
    }
  }
  wait .05;
  for(watcher = 0; watcher < watchers.size; watcher++) {
    watchers[watcher] delete_weapon_object_array();
  }
}

on_spawn_retrievable_weapon_object(watcher, player) {
  self endon("death");
  self SetOwner(player);
  self.owner = player;
  self waittill_not_moving();
  self.pickUpTrigger = spawn("trigger_radius_use", self.origin, 0, 64, 64);
  self.pickUpTrigger SetCursorHint("HINT_NOICON");
  if(isDefined(level.retrieveHints[watcher.name]))
    self.pickUpTrigger SetHintString(level.retrieveHints[watcher.name].hint);
  else
    self.pickUpTrigger SetHintString(&"WEAPON_GENERIC_PICKUP");
  player ClientClaimTrigger(self.pickUpTrigger);
  self.pickupTrigger enablelinkto();
  self.pickupTrigger linkto(self);
  thread watch_use_trigger(self.pickUpTrigger, watcher.pickUp);
  if(isDefined(watcher.pickup_trigger_listener)) {
    self thread[[watcher.pickup_trigger_listener]](self.pickUpTrigger, player);
  }
  self thread watch_shutdown(player);
}

weapons_get_dvar_int(dvar, def) {
  return int(weapons_get_dvar(dvar, def));
}

weapons_get_dvar(dvar, def) {
  if(getDvar(dvar) != "") {
    return GetDvarFloat(dvar);
  } else {
    SetDvar(dvar, def);
    return def;
  }
}

get_weapon_object_watcher(name) {
  if(!isDefined(self.weaponObjectWatcherArray)) {
    return undefined;
  }
  for(watcher = 0; watcher < self.weaponObjectWatcherArray.size; watcher++) {
    if(self.weaponObjectWatcherArray[watcher].name == name) {
      return self.weaponObjectWatcherArray[watcher];
    }
  }
  return undefined;
}

get_weapon_object_watcher_by_weapon(weapon) {
  if(!isDefined(self.weaponObjectWatcherArray)) {
    return undefined;
  }
  for(watcher = 0; watcher < self.weaponObjectWatcherArray.size; watcher++) {
    if(isDefined(self.weaponObjectWatcherArray[watcher].weapon) && self.weaponObjectWatcherArray[watcher].weapon == weapon) {
      return self.weaponObjectWatcherArray[watcher];
    }
    if(isDefined(self.weaponObjectWatcherArray[watcher].weapon) && isDefined(self.weaponObjectWatcherArray[watcher].altWeapon) && self.weaponObjectWatcherArray[watcher].altWeapon == weapon) {
      return self.weaponObjectWatcherArray[watcher];
    }
  }
  return undefined;
}

pick_up() {
  player = self.owner;
  self destroy_ent();
  clip_ammo = player GetWeaponAmmoClip(self.name);
  clip_max_ammo = WeaponClipSize(self.name);
  if(clip_ammo < clip_max_ammo) {
    clip_ammo++;
  }
  player SetWeaponAmmoClip(self.name, clip_ammo);
}

destroy_ent() {
  self delete();
}

add_weapon_object(watcher, weapon) {
  watcher.objectArray[watcher.objectArray.size] = weapon;
  weapon.owner = self;
  weapon.detonated = false;
  weapon.name = watcher.weapon;
  if(!is_true(watcher.skip_weapon_object_damage)) {
    weapon thread weapon_object_damage(watcher);
  }
  weapon.owner notify("weapon_object_placed", weapon);
  if(isDefined(watcher.onSpawn))
    weapon thread[[watcher.onSpawn]](watcher, self);
  if(isDefined(watcher.onSpawnFX))
    weapon thread[[watcher.onSpawnFX]]();
  if(isDefined(watcher.onSpawnRetrieveTriggers))
    weapon thread[[watcher.onSpawnRetrieveTriggers]](watcher, self);
  RefreshHudAmmoCounter();
}

detonate_weapon_object_array() {
  if(isDefined(self.disableDetonation) && self.disableDetonation)
    return;
  if(isDefined(self.objectArray)) {
    for(i = 0; i < self.objectArray.size; i++) {
      if(isDefined(self.objectArray[i]))
        self thread wait_and_detonate(self.objectArray[i], 0.1);
    }
  }
  self.objectArray = [];
}

delete_weapon_object_array() {
  if(isDefined(self.objectArray)) {
    for(i = 0; i < self.objectArray.size; i++) {
      if(isDefined(self.objectArray[i]))
        self.objectArray[i] delete();
    }
  }
  self.objectArray = [];
}

watch_use_trigger(trigger, callback) {
  self endon("delete");
  while(true) {
    trigger waittill("trigger", player);
    if(!IsAlive(player))
      continue;
    if(!player IsOnGround())
      continue;
    if(isDefined(trigger.triggerTeam) && (player.pers["team"] != trigger.triggerTeam))
      continue;
    if(isDefined(trigger.claimedBy) && (player != trigger.claimedBy))
      continue;
    if(player UseButtonPressed() && !player.throwingGrenade && !player MeleeButtonPressed())
      self thread[[callback]]();
  }
}

watch_shutdown(player) {
  player endon("disconnect");
  pickUpTrigger = self.pickUpTrigger;
  self waittill("death");
  pickUpTrigger delete();
}

weapon_object_damage(watcher) {
  self endon("death");
  self setCanDamage(true);
  self.health = 100000;
  attacker = undefined;
  while(1) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelName, tagName, partName, iDFlags);
    if(!isDefined(self.allowAIToAttack)) {
      if(!IsPlayer(attacker))
        continue;
    }
    if(damage < 5) {
      if(isDefined(watcher.specialGrenadeDisabledTime)) {
        self thread disabled_by_special_grenade(watcher.specialGrenadeDisabledTime);
      }
      continue;
    }
    break;
  }
  if(level.weaponobjectexplodethisframe)
    wait .1 + randomfloat(.4);
  else
    wait .05;
  if(!isDefined(self))
    return;
  level.weaponobjectexplodethisframe = true;
  thread reset_weapon_object_explode_this_frame();
  if(isDefined(type) && (IsSubStr(type, "MOD_GRENADE_SPLASH") || IsSubStr(type, "MOD_GRENADE") || IsSubStr(type, "MOD_EXPLOSIVE")))
    self.wasChained = true;
  if(isDefined(iDFlags) && (iDFlags & level.iDFLAGS_PENETRATION))
    self.wasDamagedFromBulletPenetration = true;
  self.wasDamaged = true;
  watcher thread wait_and_detonate(self, 0.0, attacker);
}

wait_and_detonate(object, delay, attacker) {
  object endon("death");
  if(delay)
    wait(delay);
  if(object.detonated)
    return;
  if(!isDefined(self.detonate))
    return;
  object.detonated = true;
  object notify("detonated");
  object[[self.detonate]](attacker);
}

disabled_by_special_grenade(disableTime) {
  self notify("damagedBySpecial");
  self endon("damagedBySpecial");
  self endon("death");
  self.disabledBySpecial = true;
  wait(disableTime);
  self.disabledBySpecial = false;
}

reset_weapon_object_explode_this_frame() {
  wait .05;
  level.weaponobjectexplodethisframe = false;
}