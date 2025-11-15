/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_weapons.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;

init() {
  level thread on_player_connect();
  maps\_flashgrenades::main();
  maps\_weaponobjects::init();
  maps\_explosive_bolt::init();
  maps\_flamethrower_plight::init();
  maps\_ballistic_knife::init();
}

on_player_connect() {
  while(true) {
    level waittill("connecting", player);
    player.usedWeapons = false;
    player.hits = 0;
    player thread on_player_spawned();
  }
}

on_player_spawned() {
  self endon("disconnect");
  self endon("death");
  self.usedWeapons = false;
  self.hits = 0;
  while(true) {
    self waittill("spawned_player");
    self thread watch_weapon_usage();
    self thread watch_grenade_usage();
  }
}

watch_weapon_usage() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  while(true) {
    self waittill("begin_firing");
    curWeapon = self GetCurrentWeapon();
    switch (WeaponClass(curWeapon)) {
      case "rifle":
      case "pistol":
      case "mg":
      case "smg":
      case "spread":
        break;
      case "rocketlauncher":
      case "grenade":
        self thread maps\_shellshock::rocket_earthQuake();
        break;
      default:
        break;
    }
    self waittill("end_firing");
  }
}

watch_grenade_usage() {
  self endon("death");
  self endon("disconnect");
  self thread begin_other_grenade_tracking();
  while(true) {
    self waittill("grenade_pullback", weaponName);
    if(weaponName == "claymore_mp") {
      continue;
    }
    self begin_grenade_tracking();
  }
}

begin_grenade_tracking() {
  self endon("death");
  self endon("disconnect");
  startTime = GetTime();
  self waittill("grenade_fire", grenade, weaponName);
  if((getTime() - startTime > 1000)) {
    grenade.isCooked = true;
  }
  switch (weaponName) {
    case "frag_grenade_sp":
    case "sticky_grenade_mp":
      grenade thread maps\_shellshock::grenade_earthQuake();
      grenade.originalOwner = self;
      break;
    case "satchel_charge_mp":
      grenade thread maps\_shellshock::satchel_earthQuake();
      break;
    case "c4_mp":
      grenade thread maps\_shellshock::c4_earthQuake();
      break;
  }
  self.throwingGrenade = false;
}

begin_other_grenade_tracking() {
  self notify("grenadeTrackingStart");
  self endon("grenadeTrackingStart");
  self endon("disconnect");
  while(true) {
    self waittill("grenade_fire", grenade, weaponName, parent);
    switch (weaponName) {
      case "flash_grenade_sp":
        break;
      case "signal_flare_mp":
        break;
      case "tabun_gas_mp":
        break;
      case "vc_grenade_sp":
        break;
      case "willy_pete_sp":
      case "m8_orange_smoke_sp":
        grenade thread watchSmokeGrenadeDetonation();
        break;
      case "sticky_grenade_mp":
      case "satchel_charge_mp":
      case "c4_mp":
        break;
    }
  }
}

getDamageableEnts(pos, radius, doLOS, startRadius) {
  ents = [];
  if(!isDefined(doLOS))
    doLOS = false;
  if(!isDefined(startRadius))
    startRadius = 0;
  players = GetPlayers();
  for(i = 0; i < players.size; i++) {
    if(!isalive(players[i]) || players[i].sessionstate != "playing")
      continue;
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
  guys = getAIarray("axis", "allies", "neutral");
  for(i = 0; i < guys.size; i++) {
    entpos = guys[i].origin;
    dist = distance(pos, entpos);
    if(dist < radius && (!doLOS || weaponDamageTracePassed(pos, entpos, startRadius, guys[i]))) {
      newent = spawnStruct();
      newent.isPlayer = false;
      newent.isADestructable = false;
      newent.entity = guys[i];
      newent.damageCenter = entpos;
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
  return (trace["fraction"] == 1);
}

damageEnt(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, damagepos, damagedir) {
  if(self.isPlayer) {
    self.damageOrigin = damagepos;
    self.entity thread[[level.callbackPlayerDamage]](
      eInflictor,
      eAttacker,
      iDamage,
      0,
      sMeansOfDeath,
      sWeapon,
      damagepos,
      damagedir,
      "none",
      0,
      0
    );
  } else if(IsAlive(self.entity)) {
    self.entity DoDamage(iDamage, damagepos, eAttacker, eInflictor, sMeansOfDeath, 0);
  } else {
    if(self.isADestructable && (sWeapon == "artillery_mp" || sWeapon == "mine_bouncing_betty_mp"))
      return;
    self.entity damage_notify_wrapper(iDamage, eAttacker, (0, 0, 0), (0, 0, 0), "mod_explosive", "", "");
  }
}

watchSmokeGrenadeDetonation() {
  self waittill("explode", position, surface);
  smokeSound = spawn("script_origin", (0, 0, 1));
  smokeSound.origin = position;
  smokeSound playSound("wpn_smoke_hiss_start");
  smokeSound playLoopSound("wpn_smoke_hiss_lp");
  wait(6);
  playsoundatposition("wpn_smoke_hiss_end", position);
  smokeSound stopLoopSound(.5);
  wait(.5);
  smokeSound delete();
}