/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_destructible.gsc
*************************************************/

#using scripts\mp\_challenges;
#using scripts\mp\gametypes\_battlechatter;
#using scripts\mp\gametypes\_globallogic_player;
#using scripts\shared\challenges_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using_animtree("mp_vehicles");
#namespace destructible;

function autoexec __init__sytem__() {
  system::register("destructible", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "start_destructible_explosion", 1, 10, "int");
  level.destructible_callbacks = [];
  destructibles = getEntArray("destructible", "targetname");
  if(destructibles.size <= 0) {
    return;
  }
  for(i = 0; i < destructibles.size; i++) {
    if(getsubstr(destructibles[i].destructibledef, 0, 4) == "veh_") {
      destructibles[i] thread car_death_think();
      destructibles[i] thread car_grenade_stuck_think();
      continue;
    }
    if(destructibles[i].destructibledef == "fxdest_upl_metal_tank_01") {
      destructibles[i] thread tank_grenade_stuck_think();
    }
  }
  init_explosions();
}

function init_explosions() {
  level.explosion_manager = spawnStruct();
  level.explosion_manager.count = 0;
  level.explosion_manager.a_explosions = [];
  for(i = 0; i < 32; i++) {
    sexplosion = spawn("script_model", (0, 0, 0));
    if(!isDefined(level.explosion_manager.a_explosions)) {
      level.explosion_manager.a_explosions = [];
    } else if(!isarray(level.explosion_manager.a_explosions)) {
      level.explosion_manager.a_explosions = array(level.explosion_manager.a_explosions);
    }
    level.explosion_manager.a_explosions[level.explosion_manager.a_explosions.size] = sexplosion;
  }
}

function get_unused_explosion() {
  foreach(explosion in level.explosion_manager.a_explosions) {
    if(!(isDefined(explosion.in_use) && explosion.in_use)) {
      return explosion;
    }
  }
  return level.explosion_manager.a_explosions[0];
}

function physics_explosion_and_rumble(origin, radius, physics_explosion) {
  sexplosion = get_unused_explosion();
  sexplosion.in_use = 1;
  sexplosion.origin = origin;
  assert(radius <= (pow(2, 10) - 1));
  if(isDefined(physics_explosion) && physics_explosion) {
    radius = radius + (1 << 9);
  }
  wait(0.05);
  sexplosion clientfield::set("start_destructible_explosion", radius);
  sexplosion.in_use = 0;
}

function event_callback(destructible_event, attacker, weapon) {
  explosion_radius = 0;
  if(issubstr(destructible_event, "explode") && destructible_event != "explode") {
    tokens = strtok(destructible_event, "_");
    explosion_radius = tokens[1];
    if(explosion_radius == "sm") {
      explosion_radius = 150;
    } else {
      if(explosion_radius == "lg") {
        explosion_radius = 450;
      } else {
        explosion_radius = int(explosion_radius);
      }
    }
    destructible_event = "explode_complex";
  }
  if(issubstr(destructible_event, "explosive")) {
    tokens = strtok(destructible_event, "_");
    explosion_radius_type = tokens[3];
    if(explosion_radius_type == "small") {
      explosion_radius = 150;
    } else {
      if(explosion_radius_type == "large") {
        explosion_radius = 450;
      } else {
        explosion_radius = 300;
      }
    }
  }
  if(issubstr(destructible_event, "simple_timed_explosion")) {
    self thread simple_timed_explosion(destructible_event, attacker);
    return;
  }
  switch (destructible_event) {
    case "destructible_car_explosion": {
      self car_explosion(attacker);
      if(isDefined(weapon)) {
        self.destroyingweapon = weapon;
      }
      break;
    }
    case "destructible_car_fire": {
      level thread battlechatter::on_player_near_explodable(self, "car");
      self thread car_fire_think(attacker);
      if(isDefined(weapon)) {
        self.destroyingweapon = weapon;
      }
      break;
    }
    case "explode": {
      self thread simple_explosion(attacker);
      break;
    }
    case "explode_complex": {
      self thread complex_explosion(attacker, explosion_radius);
      break;
    }
    case "destructible_explosive_incendiary_large":
    case "destructible_explosive_incendiary_small": {
      self explosive_incendiary_explosion(attacker, explosion_radius, 0);
      if(isDefined(weapon)) {
        self.destroyingweapon = weapon;
      }
      break;
    }
    case "destructible_explosive_electrical_large":
    case "destructible_explosive_electrical_small": {
      self explosive_electrical_explosion(attacker, explosion_radius, 0);
      if(isDefined(weapon)) {
        self.destroyingweapon = weapon;
      }
      break;
    }
    case "destructible_explosive_concussive_large":
    case "destructible_explosive_concussive_small": {
      self explosive_concussive_explosion(attacker, explosion_radius, 0);
      if(isDefined(weapon)) {
        self.destroyingweapon = weapon;
      }
      break;
    }
    default: {
      break;
    }
  }
  if(isDefined(level.destructible_callbacks[destructible_event])) {
    self thread[[level.destructible_callbacks[destructible_event]]](destructible_event, attacker, weapon);
  }
}

function simple_explosion(attacker) {
  if(isDefined(self.exploded) && self.exploded) {
    return;
  }
  self.exploded = 1;
  offset = vectorscale((0, 0, 1), 5);
  self radiusdamage(self.origin + offset, 256, 300, 75, attacker, "MOD_EXPLOSIVE", getweapon("explodable_barrel"));
  physics_explosion_and_rumble(self.origin, 255, 1);
  if(isDefined(attacker)) {
    self dodamage(self.health + 10000, self.origin + offset, attacker);
  } else {
    self dodamage(self.health + 10000, self.origin + offset);
  }
}

function simple_timed_explosion(destructible_event, attacker) {
  self endon("death");
  wait_times = [];
  str = getsubstr(destructible_event, 23);
  tokens = strtok(str, "_");
  for(i = 0; i < tokens.size; i++) {
    wait_times[wait_times.size] = int(tokens[i]);
  }
  if(wait_times.size <= 0) {
    wait_times[0] = 5;
    wait_times[1] = 10;
  }
  wait(randomintrange(wait_times[0], wait_times[1]));
  simple_explosion(attacker);
}

function complex_explosion(attacker, max_radius) {
  offset = vectorscale((0, 0, 1), 5);
  if(isDefined(attacker)) {
    self radiusdamage(self.origin + offset, max_radius, 300, 100, attacker);
  } else {
    self radiusdamage(self.origin + offset, max_radius, 300, 100);
  }
  physics_explosion_and_rumble(self.origin, max_radius, 1);
  if(isDefined(attacker)) {
    self dodamage(20000, self.origin + offset, attacker);
  } else {
    self dodamage(20000, self.origin + offset);
  }
}

function car_explosion(attacker, physics_explosion) {
  if(isDefined(self.car_dead) && self.car_dead) {
    return;
  }
  if(!isDefined(physics_explosion)) {
    physics_explosion = 1;
  }
  self notify("car_dead");
  self.car_dead = 1;
  if(isDefined(attacker)) {
    self radiusdamage(self.origin, 256, 300, 75, attacker, "MOD_EXPLOSIVE", getweapon("destructible_car"));
  } else {
    self radiusdamage(self.origin, 256, 300, 75);
  }
  physics_explosion_and_rumble(self.origin, 255, physics_explosion);
  if(isDefined(attacker)) {
    attacker thread challenges::destroyed_car();
  }
  level.globalcarsdestroyed++;
  if(isDefined(attacker)) {
    self dodamage(self.health + 10000, self.origin + (0, 0, 1), attacker);
  } else {
    self dodamage(self.health + 10000, self.origin + (0, 0, 1));
  }
  self markdestructibledestroyed();
}

function tank_grenade_stuck_think() {
  self endon("destructible_base_piece_death");
  self endon("death");
  for(;;) {
    self waittill("grenade_stuck", missile);
    if(!isDefined(missile) || !isDefined(missile.model)) {
      continue;
    }
    if(missile.model == "t5_weapon_crossbow_bolt" || missile.model == "t6_wpn_grenade_semtex_projectile" || missile.model == "wpn_t7_c4_world") {
      self thread tank_grenade_stuck_explode(missile);
    }
  }
}

function tank_grenade_stuck_explode(missile) {
  self endon("destructible_base_piece_death");
  self endon("death");
  owner = getmissileowner(missile);
  if(isDefined(owner) && missile.model == "wpn_t7_c4_world") {
    owner endon("disconnect");
    owner endon("weapon_object_destroyed");
    missile endon("picked_up");
    missile thread tank_hacked_c4(self);
  }
  missile waittill("explode");
  if(isDefined(owner)) {
    self dodamage(self.health + 10000, self.origin + (0, 0, 1), owner);
  } else {
    self dodamage(self.health + 10000, self.origin + (0, 0, 1));
  }
}

function tank_hacked_c4(tank) {
  tank endon("destructible_base_piece_death");
  tank endon("death");
  self endon("death");
  self waittill("hacked");
  self notify("picked_up");
  tank thread tank_grenade_stuck_explode(self);
}

function car_death_think() {
  self endon("car_dead");
  self.car_dead = 0;
  self thread car_death_notify();
  self waittill("destructible_base_piece_death", attacker);
  if(isDefined(self)) {
    self thread car_explosion(attacker, 0);
  }
}

function car_grenade_stuck_think() {
  self endon("destructible_base_piece_death");
  self endon("car_dead");
  self endon("death");
  for(;;) {
    self waittill("grenade_stuck", missile);
    if(!isDefined(missile) || !isDefined(missile.model)) {
      continue;
    }
    if(missile.model == "t5_weapon_crossbow_bolt" || missile.model == "t6_wpn_grenade_semtex_projectile" || missile.model == "wpn_t7_c4_world") {
      self thread car_grenade_stuck_explode(missile);
    }
  }
}

function car_grenade_stuck_explode(missile) {
  self endon("destructible_base_piece_death");
  self endon("car_dead");
  self endon("death");
  owner = getmissileowner(missile);
  if(isDefined(owner) && missile.model == "wpn_t7_c4_world") {
    owner endon("disconnect");
    owner endon("weapon_object_destroyed");
    missile endon("picked_up");
    missile thread car_hacked_c4(self);
  }
  missile waittill("explode");
  if(isDefined(owner)) {
    self dodamage(self.health + 10000, self.origin + (0, 0, 1), owner);
  } else {
    self dodamage(self.health + 10000, self.origin + (0, 0, 1));
  }
}

function car_hacked_c4(car) {
  car endon("destructible_base_piece_death");
  car endon("car_dead");
  car endon("death");
  self endon("death");
  self waittill("hacked");
  self notify("picked_up");
  car thread car_grenade_stuck_explode(self);
}

function car_death_notify() {
  self endon("car_dead");
  self waittill("death", attacker);
  self notify("destructible_base_piece_death", attacker);
}

function car_fire_think(attacker) {
  self endon("death");
  wait(randomintrange(7, 10));
  self thread car_explosion(attacker);
}

function codecallback_destructibleevent(event, param1, param2, param3, param4) {
  if(event == "broken") {
    notify_type = param1;
    attacker = param2;
    piece = param3;
    weapon = param4;
    event_callback(notify_type, attacker, weapon);
    self notify(event, notify_type, attacker);
  } else if(event == "breakafter") {
    piece = param1;
    time = param2;
    damage = param3;
    self thread breakafter(time, damage, piece);
  }
}

function breakafter(time, damage, piece) {
  self notify("breakafter");
  self endon("breakafter");
  wait(time);
  self dodamage(damage, self.origin, undefined, undefined);
}

function explosive_incendiary_explosion(attacker, explosion_radius, physics_explosion) {
  if(!isvehicle(self)) {
    offset = vectorscale((0, 0, 1), 5);
    if(isDefined(attacker)) {
      self radiusdamage(self.origin + offset, explosion_radius, 256, 75, attacker, "MOD_BURNED", getweapon("incendiary_fire"));
    } else {
      self radiusdamage(self.origin + offset, explosion_radius, 256, 75);
    }
    physics_explosion_and_rumble(self.origin, 255, physics_explosion);
  }
  if(isDefined(self.target)) {
    dest_clip = getent(self.target, "targetname");
    if(isDefined(dest_clip)) {
      dest_clip delete();
    }
  }
  self markdestructibledestroyed();
}

function explosive_electrical_explosion(attacker, explosion_radius, physics_explosion) {
  if(!isvehicle(self)) {
    offset = vectorscale((0, 0, 1), 5);
    if(isDefined(attacker)) {
      self radiusdamage(self.origin + offset, explosion_radius, 256, 75, attacker, "MOD_ELECTROCUTED");
    } else {
      self radiusdamage(self.origin + offset, explosion_radius, 256, 75);
    }
    physics_explosion_and_rumble(self.origin, 255, physics_explosion);
  }
  if(isDefined(self.target)) {
    dest_clip = getent(self.target, "targetname");
    if(isDefined(dest_clip)) {
      dest_clip delete();
    }
  }
  self markdestructibledestroyed();
}

function explosive_concussive_explosion(attacker, explosion_radius, physics_explosion) {
  if(!isvehicle(self)) {
    offset = vectorscale((0, 0, 1), 5);
    if(isDefined(attacker)) {
      self radiusdamage(self.origin + offset, explosion_radius, 256, 75, attacker, "MOD_GRENADE");
    } else {
      self radiusdamage(self.origin + offset, explosion_radius, 256, 75);
    }
    physics_explosion_and_rumble(self.origin, 255, physics_explosion);
  }
  if(isDefined(self.target)) {
    dest_clip = getent(self.target, "targetname");
    if(isDefined(dest_clip)) {
      dest_clip delete();
    }
  }
  self markdestructibledestroyed();
}