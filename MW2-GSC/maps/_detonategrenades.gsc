/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_detonategrenades.gsc
********************************************************/

#include common_scripts\utility;
#include maps\_utility;

init() {
  level._effect["c4_light_blink"] = loadfx("misc/light_c4_blink");
  level._effect["claymore_laser"] = loadfx("misc/claymore_laser");

  for(i = 0; i < level.players.size; i++) {
    level.players[i] thread watchGrenadeUsage();
  }
}

watchGrenadeUsage() {
  level.c4explodethisframe = false;
  self endon("death");
  self.c4array = [];
  self.throwingGrenade = false;

  thread watchC4();
  thread watchC4Detonation();
  thread watchC4AltDetonation();
  thread watchClaymores();
  thread begin_semtex_grenade_tracking();

  for(;;) {
    self waittill("grenade_pullback", weaponName);
    self.throwingGrenade = true;

    if(weaponName == "c4") {
      self beginC4Tracking();
    } else if(weaponName == "smoke_grenade_american") {
      self beginsmokegrenadetracking();
    } else {
      self beginGrenadeTracking();
    }
  }
}

beginsmokegrenadetracking() {
  self waittill("grenade_fire", grenade, weaponName);
  if(!isDefined(level.smokegrenades)) {
    level.smokegrenades = 0;
  }
  if(level.smokegrenades > 2 && getDvar("player_sustainAmmo") != "0") {
    grenade delete();
  } else {
    grenade thread smoke_grenade_death();
  }
}

begin_semtex_grenade_tracking() {
  while(1) {
    self waittill("grenade_fire", grenade, weaponName);
    if(weaponName == "semtex_grenade") {
      thread track_semtex_grenade(grenade);
      grenade thread semtex_sticky_handle(self);
    }
  }
}

track_semtex_grenade(grenade) {
  self.throwingGrenade = false;

  if(!isDefined(level.thrown_semtex_grenades)) {
    level.thrown_semtex_grenades = 1;
  } else {
    level.thrown_semtex_grenades++;
  }

  grenade waittill("death");

  waittillframeend;
  level.thrown_semtex_grenades--;
}

semtex_sticky_handle(attacker) {
  self waittill("missile_stuck", entity);

  if(!isDefined(entity)) {
    return;
  }

  if(entity.code_classname != "script_vehicle") {
    return;
  }
  entity.has_semtex_on_it = true;

  self waittill("explode");

  if(!isDefined(entity) || !isalive(entity)) {
    return;
  }
  if(entity maps\_vehicle::is_godmode() || entity maps\_vehicle::attacker_isonmyteam(attacker)) {
    entity.has_semtex_on_it = undefined;
    return;
  }

  entity kill(entity.origin, attacker);
}

smoke_grenade_death() {
  level.smokegrenades++;
  wait 50;
  level.smokegrenades--;
}

beginGrenadeTracking() {
  self endon("death");

  self waittill("grenade_fire", grenade, weaponName);
  if(weaponName == "fraggrenade") {
    grenade thread grenade_earthQuake();
  }

  self.throwingGrenade = false;
}

beginC4Tracking() {
  self endon("death");

  self waittill_any("grenade_fire", "weapon_change");
  self.throwingGrenade = false;
}

watchC4() {
  while(1) {
    self waittill("grenade_fire", c4, weapname);
    if(weapname == "c4") {
      if(!self.c4array.size) {
        self thread watchC4AltDetonate();
      }

      self.c4array[self.c4array.size] = c4;
      if(self.c4array.size > 15 && getDvar("player_sustainAmmo") != "0") {
        self.c4array[0] delete();
      }
      c4.owner = self;

      c4 thread c4Damage();
      self thread c4death(c4);
      c4 thread playC4Effects();
    }
  }
}

c4death(c4) {
  c4 waittill("death");
  self.c4array = array_remove_nokeys(self.c4array, c4);
}

watchClaymores() {
  self endon("spawned_player");
  self endon("disconnect");

  while(1) {
    self waittill("grenade_fire", claymore, weapname);
    if(weapname == "claymore" || weapname == "claymore_mp") {
      claymore.owner = self;
      claymore thread c4Damage();
      claymore thread claymoreDetonation();
      claymore thread playClaymoreEffects();
      claymore thread claymoreMakeSentient(self.team);
    }
  }
}

claymoreMakeSentient(team) {
  self endon("death");

  wait 1;

  self MakeEntitySentient(team, true);
  self.attackerAccuracy = 2;
  self.maxVisibleDist = 750;
  self.threatBias = -1000;
}

claymoreDetonation() {
  self endon("death");

  self waittill("missile_stuck");

  detonateRadius = 192;

  damagearea = spawn("trigger_radius", self.origin + (0, 0, 0 - detonateRadius), 9, detonateRadius, detonateRadius * 2);

  self thread deleteOnDeath(damagearea);

  if(!isDefined(level.claymores)) {
    level.claymores = [];
  }
  level.claymores = array_add(level.claymores, self);

  if(!is_specialop() && level.claymores.size > 15) {
    level.claymores[0] delete();
  }

  while(1) {
    damagearea waittill("trigger", ent);

    if(isDefined(self.owner) && ent == self.owner) {
      continue;
    }
    if(isPlayer(ent)) {
      continue;
    }
    if(ent damageConeTrace(self.origin, self) > 0) {
      self playSound("claymore_activated_SP");
      wait 0.4;
      if(isDefined(self.owner)) {
        self detonate(self.owner);
      } else {
        self detonate(undefined);
      }

      return;
    }
  }
}

deleteOnDeath(ent) {
  self waittill("death");

  level.claymores = array_remove_nokeys(level.claymores, self);
  wait .05;
  if(isDefined(ent)) {
    ent delete();
  }
}

watchC4Detonation() {
  self endon("death");
  while(1) {
    self waittill("detonate");
    weap = self getCurrentWeapon();
    if(weap == "c4") {
      for(i = 0; i < self.c4array.size; i++) {
        if(isDefined(self.c4array[i])) {
          self.c4array[i] thread waitAndDetonate(0.1);
        }
      }
      self.c4array = [];
    }
  }
}

watchC4AltDetonation() {
  self endon("death");
  self endon("disconnect");

  while(1) {
    self waittill("alt_detonate");
    weap = self getCurrentWeapon();
    if(weap != "c4") {
      newarray = [];
      for(i = 0; i < self.c4array.size; i++) {
        c4 = self.c4array[i];
        if(isDefined(self.c4array[i])) {
          c4 thread waitAndDetonate(0.1);
        }
      }
      self.c4array = newarray;
      self notify("detonated");
    }
  }
}

waitAndDetonate(delay) {
  self endon("death");
  wait delay;

  self detonate();
}

c4Damage() {
  self.health = 100;
  self setCanDamage(true);
  self.maxhealth = 100000;
  self.health = self.maxhealth;

  attacker = undefined;

  while(1) {
    self waittill("damage", amount, attacker);

    break;
  }

  self playSound("claymore_activated_SP");

  if(level.c4explodethisframe) {
    wait .1 + randomfloat(.4);
  } else {
    wait .05;
  }

  if(!isDefined(self)) {
    return;
  }
  level.c4explodethisframe = true;

  thread resetC4ExplodeThisFrame();

  if(isPlayer(attacker)) {
    self detonate(attacker);
  } else {
    self detonate();
  }
}

resetC4ExplodeThisFrame() {
  wait .05;
  level.c4explodethisframe = false;
}

saydamaged(orig, amount) {
  for(i = 0; i < 60; i++) {
    print3d(orig, "damaged! " + amount);
    wait .05;
  }
}

playC4Effects() {
  self endon("death");

  self waittill("missile_stuck");

  playFXOnTag(getfx("c4_light_blink"), self, "tag_fx");
}

playClaymoreEffects() {
  self endon("death");

  self waittill("missile_stuck");

  playFXOnTag(getfx("claymore_laser"), self, "tag_fx");
}

clearFXOnDeath(fx) {
  self waittill("death");
  fx delete();
}
getDamageableEnts(pos, radius, doLOS, startRadius) {
  ents = [];

  if(!isDefined(doLOS)) {
    doLOS = false;
  }

  if(!isDefined(startRadius)) {
    startRadius = 0;
  }

  for(i = 0; i < level.players.size; i++) {
    if(!isalive(level.players[i]) || level.players[i].sessionstate != "playing") {
      continue;
    }
    playerpos = level.players[i].origin + (0, 0, 32);
    dist = distance(pos, playerpos);
    if(dist < radius && (!doLOS || weaponDamageTracePassed(pos, playerpos, startRadius, undefined))) {
      newent = spawnStruct();
      newent.isPlayer = true;
      newent.isADestructable = false;
      newent.entity = level.players[i];
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
  if(lengthsquared(diff) < startRadius * startRadius) {
    midpos = to;
  }
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
    if(self.isADestructable && (sWeapon == "artillery_mp" || sWeapon == "claymore_mp")) {
      return;
    }
    self.entity notify("damage", iDamage, eAttacker);
  }
}

debugline(a, b, color) {
  for(i = 0; i < 30 * 20; i++) {
    line(a, b, color);
    wait .05;
  }
}

onWeaponDamage(eInflictor, sWeapon, meansOfDeath, damage) {
  self endon("death");

  switch (sWeapon) {
    case "concussion_grenade_mp":

      radius = 512;
      scale = 1 - (distance(self.origin, eInflictor.origin) / radius);

      time = 1 + (4 * scale);

      wait(0.05);
      self shellShock("concussion_grenade_mp", time);
      break;
    default:

      break;
  }
}

watchC4AltDetonate() {
  self endon("death");
  self endon("disconnect");
  self endon("detonated");
  level endon("game_ended");

  buttonTime = 0;
  for(;;) {
    if(self useButtonPressed()) {
      buttonTime = 0;
      while(self useButtonPressed()) {
        buttonTime += 0.05;
        wait(0.05);
      }

      println("pressTime1: " + buttonTime);
      if(buttonTime >= 0.5) {
        continue;
      }
      buttonTime = 0;
      while(!self useButtonPressed() && buttonTime < 0.5) {
        buttonTime += 0.05;
        wait(0.05);
      }

      println("delayTime: " + buttonTime);
      if(buttonTime >= 0.5) {
        continue;
      }
      if(!self.c4Array.size) {
        return;
      }
      self notify("alt_detonate");
    }
    wait(0.05);
  }
}