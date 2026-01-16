/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_destructible.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;

init() {
  destructibles = getentarray("destructible", "targetname");
  array_thread(destructibles, ::destructible_think);

  if(destructibles.size <= 0) {
    return;
  }
  for(i = 0; i < destructibles.size; i++) {
    if(issubstr(destructibles[i].destructibledef, "barrel"))
      destructibles[i] thread destructible_barrel_death_think();
  }
}

destructible_think() {
  self endon("death");

  if(self.destructibledef == "fxanim_gp_ceiling_fan_old_mod" || self.destructibledef == "fxanim_gp_ceiling_fan_modern_mod" || self.destructibledef == "fxdest_p6_ceiling_fan_modern" || self.destructibledef == "fxanim_airconditioner_mod") {
    self thread ceiling_fan_think();
    return;
  }
}

destructible_event_callback(destructible_event, attacker) {
  waittillframeend;
  explosion_radius = 0;

  if(issubstr(destructible_event, "explode") && destructible_event != "explode") {
    tokens = strtok(destructible_event, "_");
    explosion_radius = tokens[1];

    if(explosion_radius == "sm")
      explosion_radius = 150;
    else if(explosion_radius == "lg")
      explosion_radius = 450;
    else
      explosion_radius = int(explosion_radius);

    destructible_event = "explode_complex";
  }

  switch (destructible_event) {
    case "destructible_barrel_fire":
      self thread destructible_barrel_fire_think(attacker);
      break;
    case "destructible_barrel_explosion":
      self destructible_barrel_explosion(attacker);
      break;
    case "destructible_car_explosion":
      self destructible_car_explosion(attacker);
      break;
    case "destructible_car_fire":
      self thread destructible_car_fire_think(attacker);
      break;
    case "explode":
      self thread simple_explosion(attacker);
      break;
    case "explode_complex":
      self thread complex_explosion(attacker, explosion_radius);
      break;
    case "delete_collision":
      self thread delete_collision();
      break;
    case "nitrogen_gas_explosion":
      self thread nitorgen_gas_explosion();
      break;
    default:

      iprintln("_destructible.gsc: unknown destructible event: '" + destructible_event + "'");

      break;
  }
}

simple_explosion(attacker) {
  offset = vectorscale((0, 0, 1), 5.0);

  if(isDefined(attacker))
    self radiusdamage(self.origin + offset, 300, 300, 100, attacker);
  else
    self radiusdamage(self.origin + offset, 300, 300, 100);

  physicsexplosionsphere(self.origin + offset, 255, 254, 0.3);
  self dodamage(20000, self.origin + offset);
}

complex_explosion(attacker, max_radius) {
  offset = vectorscale((0, 0, 1), 5.0);

  if(isDefined(attacker))
    self radiusdamage(self.origin + offset, max_radius, 300, 100, attacker);
  else
    self radiusdamage(self.origin + offset, max_radius, 300, 100);

  physicsexplosionsphere(self.origin + offset, max_radius, max_radius - 1, 0.3);
  self dodamage(20000, self.origin + offset);
}

nitorgen_gas_explosion() {
  self radiusdamage(self.origin, 256, 300, 85, undefined, "MOD_GAS");
  playrumbleonposition("grenade_rumble", self.origin);
  earthquake(0.5, 0.5, self.origin, 800);
  self dodamage(self.health + 10000, self.origin + (0, 0, 1));
}

codecallback_destructibleevent(event, param1, param2, param3) {
  if(event == "broken") {
    notify_type = param1;
    attacker = param2;
    self notify(event, notify_type, attacker);
    self thread destructible_event_callback(notify_type, attacker);
  } else if(event == "breakafter") {
    piece = param1;
    time = param2;
    damage = param3;
    self thread breakafter(time, damage, piece);
  }
}

breakafter(time, damage, piece) {
  self notify("breakafter");
  self endon("breakafter");
  wait(time);
  self dodamage(damage, self.origin, undefined, piece);
}

#using_animtree("fxanim_props");

ceiling_fan_think() {
  self useanimtree(#animtree);
  self setflaggedanimknobrestart("idle", % fxanim_gp_ceiling_fan_old_slow_anim, 1, 0.0, 1);
  self waittill("broken", destructible_event, attacker);

  if(destructible_event == "stop_idle") {
    self dodamage(5000, self.origin);
    self setflaggedanimknobrestart("idle", % fxanim_gp_ceiling_fan_old_dest_anim, 1, 0.0, 1);
  }
}

delete_collision() {
  self endon("death");

  if(isDefined(self.target)) {
    dest_clip = getent(self.target, "targetname");
    wait 0.1;
    dest_clip delete();
  }
}

destructible_barrel_death_think() {
  self endon("barrel_dead");
  self waittill("death");
  self thread destructible_barrel_explosion(undefined, 0);
}

destructible_barrel_fire_think(attacker) {
  self endon("barrel_dead");
  self endon("explode");
  self endon("death");
  wait(randomintrange(7, 10));
  self thread destructible_barrel_explosion(attacker);
}

destructible_barrel_explosion(attacker, physics_explosion) {
  if(!isDefined(physics_explosion))
    physics_explosion = 1;

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.target)) {
    dest_clip = getent(self.target, "targetname");
    dest_clip delete();
  }

  self notify("barrel_dead");
  self radiusdamage(self.origin, 128, 300, 60, isDefined(attacker) ? attacker : undefined, "MOD_EXPLOSIVE", "frag_grenade_sp");
  playrumbleonposition("grenade_rumble", self.origin);
  earthquake(0.5, 0.5, self.origin, 800);

  if(physics_explosion)
    physicsexplosionsphere(self.origin, 255, 254, 0.3, 25, 400);

  self dodamage(self.health + 10000, self.origin + (0, 0, 1));
}

#using_animtree("vehicles");

destructible_car_explosion(attacker) {
  self useanimtree(#animtree);
  self setanim( % veh_car_destroy, 1.0, 0.0, 1.0);

  if(self.classname != "script_vehicle") {
    self.destructiblecar = 1;
    self radiusdamage(self.origin, 250, 500, 20, isDefined(attacker) ? attacker : self, "MOD_EXPLOSIVE");
    earthquake(0.4, 1, self.origin, 800);
  }

  playrumbleonposition("grenade_rumble", self.origin);
  self dodamage(self.health + 10000, self.origin + (0, 0, 1), isDefined(attacker) ? attacker : self);
  self notify("death", attacker);
}

destructible_car_fire_think(attacker) {
  self endon("death");
  burntime = randomintrange(7, 10);
  badplace_cylinder("car_fire_" + self getentitynumber(), burntime, self.origin, 256, 128, "all");
  wait(burntime);
  destructible_car_explosion(attacker);
}

getdamagetype(type) {
  if(!isDefined(type))
    return "unknown";

  type = tolower(type);

  switch (type) {
    case "melee":
    case "mod_crush":
    case "mod_melee":
      return "melee";
    case "bullet":
    case "mod_pistol_bullet":
    case "mod_rifle_bullet":
      return "bullet";
    case "mod_explosive":
    case "mod_grenade":
    case "mod_grenade_splash":
    case "mod_projectile":
    case "mod_projectile_splash":
    case "splash":
      return "splash";
    case "mod_impact":
      return "impact";
    case "unknown":
      return "unknown";
    default:
      return "unknown";
  }
}