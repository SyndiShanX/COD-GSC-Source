/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_detonategrenades.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;

init() {}

watchGrenadeUsage() {
  level.satchelexplodethisframe = false;
  self endon("death");
  self.satchelarray = [];
  self.bouncing_betty_array = [];
  self.throwingGrenade = false;

  thread watchSatchel();
  thread watchSatchelDetonation();
  thread watchBouncingBetty();
  thread watchClaymores();

  for(;;) {
    self waittill("grenade_pullback", weaponName);
    self.throwingGrenade = true;

    if(weaponName == "satchel_charge")
      self beginSatchelTracking();
    if(weaponName == "satchel_charge_new")
      self beginSatchelTracking();
    else if(weaponName == "smoke_grenade_american")
      self beginsmokegrenadetracking();

    else if(weaponName == "mortar_round")
      self beginMortarTracking();
    else
      self beginGrenadeTracking();
  }
}

beginsmokegrenadetracking() {
  self waittill("grenade_fire", grenade, weaponName);
  if(!isDefined(level.smokegrenades))
    level.smokegrenades = 0;
  if(level.smokegrenades > 2 && getDvar("player_sustainAmmo") != "0")
    grenade delete();
  else
    grenade thread smoke_grenade_death();
}

beginMortarTracking() {
  self endon("death");
  self endon("disconnect");
  self waittill("grenade_fire", mortar, weaponName);
  if(weaponName == "mortar_round") {
    mortar thread mortar_death();
  }
}

mortar_death() {
  self waitTillNotMoving();
  earthquake(.55, 3, self.origin, 1500);
  PlayRumbleOnPosition("explosion_generic", self.origin);
}

smoke_grenade_death() {
  level.smokegrenades++;
  wait 50;
  level.smokegrenades--;
}

beginGrenadeTracking() {
  self endon("death");

  self waittill("grenade_fire", grenade, weaponName);

  self.throwingGrenade = false;
}

beginSatchelTracking() {
  self endon("death");

  self waittill_any("grenade_fire", "weapon_change");
  self.throwingGrenade = false;
}

watchSatchel() {
  while(1) {
    self waittill("grenade_fire", satchel, weapname);
    if(weapname == "satchel_charge" || weapname == "satchel_charge_new") {
      self.satchelarray[self.satchelarray.size] = satchel;
      satchel.owner = self;
      satchel thread satchelDamage();
    }
  }
}
watchBouncingBetty() {
  while(1) {
    self waittill("grenade_fire", bouncing_betty, weapname);
    if(weapname == "bouncing_betty") {
      self.bouncing_betty_array[self.bouncing_betty_array.size] = bouncing_betty;
      bouncing_betty.owner = self;
      bouncing_betty thread betty_setup_trigger();
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
      claymore thread satchelDamage();
      claymore thread claymoreDetonation();
      claymore thread playClaymoreEffects();
    }
  }
}

waitTillNotMoving() {
  prevorigin = self.origin;
  while(1) {
    wait .1;
    if(self.origin == prevorigin) {
      break;
    }
    prevorigin = self.origin;
  }
}

claymoreDetonation() {
  self endon("death");

  self waitTillNotMoving();

  detonateRadius = 192;

  damagearea = spawn("trigger_radius", self.origin + (0, 0, 0 - detonateRadius), 9, detonateRadius, detonateRadius * 2);

  self thread deleteOnDeath(damagearea);

  if(!isDefined(level.claymores))
    level.claymores = [];
  level.claymores = array_add(level.claymores, self);

  if(level.claymores.size > 15 && getDvar("player_sustainAmmo") != "0")
    level.claymores[0] delete();

  while(1) {
    damagearea waittill("trigger", ent);

    if(isDefined(self.owner) && ent == self.owner) {
      continue;
    }
    if(ent == level.player) {
      continue;
    }
    if(ent damageConeTrace(self.origin, self) > 0) {
      self playSound("claymore_activated_SP");
      wait 0.4;
      if(isDefined(self.owner))
        self detonate(self.owner);
      else
        self detonate(undefined);

      return;
    }
  }
}

deleteOnDeath(ent) {
  self waittill("death");
  level.claymores = array_remove_nokeys(level.claymores, self);
  wait .05;
  if(isDefined(ent))
    ent delete();
}

watchSatchelDetonation() {
  self endon("death");
  while(1) {
    self waittill("detonate");
    weap = self getCurrentWeapon();
    if(weap == "satchel_charge" || weap == "satchel_charge_new") {
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
  wait delay;

  earthquake(.35, 3, self.origin, 1500);
  self detonate();
}

satchelDamage() {
  self.health = 100;
  self setCanDamage(true);
  self.maxhealth = 100000;
  self.health = self.maxhealth;

  attacker = undefined;

  while(1) {
    self waittill("damage", amount, attacker);
    if(!isPlayer(attacker)) {
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

  self detonate(attacker);
}
bouncingBettyDamage() {
  self.health = 100;
  self setCanDamage(true);
  self.maxhealth = 100000;
  self.health = self.maxhealth;

  attacker = undefined;

  while(1) {
    self waittill("damage", amount, attacker);
    if(!isPlayer(attacker)) {
      continue;
    }

    break;
  }

  if(!isDefined(self)) {
    return;
  }

  self detonate(attacker);
}
betty_setup_trigger() {
  betty_trig = spawn("trigger_radius", self.origin, 9, 80, 300);

  self thread maps\_bouncing_betties::betty_think_no_wires(betty_trig);
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

playC4Effects() {
  self endon("death");

  self waitTillNotMoving();
}

playClaymoreEffects() {
  self endon("death");

  self waitTillNotMoving();
}

clearFXOnDeath(fx) {
  self waittill("death");
  fx delete();
}
getDamageableEnts(pos, radius, doLOS, startRadius) {
  ents = [];

  if(!isDefined(doLOS))
    doLOS = false;

  if(!isDefined(startRadius))
    startRadius = 0;

  players = get_players();
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
    self.entity thread[[level.callbackPlayerDamage]](
      eInflictor, eAttacker, iDamage, 0, sMeansOfDeath, sWeapon, damagepos, damagedir, "none", 0
    );
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