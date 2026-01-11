/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_barrels_leak.gsc
*****************************************************/

#include common_scripts\utility;

level_limit_barrel_fx = 8;
max_fires_from_entity = 4;
level_barrel_fx_chance = 33;

main() {
  if(isDefined(level.barrels_init)) {
    return;
  }
  level.barrels_init = true;

  barrels = getEntArray("barrel_shootable", "targetname");
  if(!barrels.size) {
    return;
  }
  level._barrels = spawnStruct();
  level._barrels.num_barrel_fx = 0;

  barrels thread precacheFX();
  barrels thread methodsInit();

  thread post_load(barrels);
}

post_load(barrels) {
  waittillframeend;
  if(level.createFX_enabled) {
    return;
  }
  array_thread(barrels, ::barrelsetup);
}

barrelsetup() {
  self setCanDamage(true);
  self setCanRadiusDamage(false);
  self.barrel_fx_array = [];

  node = undefined;

  if(isDefined(self.target)) {
    node = getstruct(self.target, "targetname");
    self.A = node.origin;
    vec = anglesToForward(node.angles);
    vec = (vec * 128);
    self.B = self.A + vec;
  } else {
    vec = anglesToForward(self.angles);
    vec1 = (vec * 64);
    self.A = self.origin + vec1;
    vec1 = (vec * -64);
    self.B = self.origin + vec1;
  }

  self thread barrel_wait_loop();
}

barrel_wait_loop() {
  P = (0, 0, 0);

  hasTakenDamage = false;
  remaining = max_fires_from_entity;

  while(1) {
    self waittill("damage", damage, attacker, direction_vec, P, type);

    if(hasTakenDamage) {
      if(randomint(100) <= level_barrel_fx_chance) {
        continue;
      }
    }
    hasTakenDamage = true;

    result = self barrel_logic(direction_vec, P, type, attacker);
    if(result) {
      remaining--;
    }

    if(remaining <= 0) {
      break;
    }
  }

  self setCanDamage(false);
}

barrel_logic(direction_vec, P, type, damageOwner) {
  if(level._barrels.num_barrel_fx > level_limit_barrel_fx) {
    return false;
  }

  if(!isDefined(level._barrels._barrel_methods[type])) {
    P = self barrel_calc_nofx(P, type);
  }
  else {
    P = self[[level._barrels._barrel_methods[type]]](P, type);
  }

  if(!isDefined(P)) {
    return false;
  }

  if(isDefined(damageOwner.classname) && damageOwner.classname == "worldspawn") {
    return false;
  }

  foreach(value in self.barrel_fx_array) {
    if(DistanceSquared(P, value.origin) < 25) {
      return false;
    }
  }

  E = undefined;
  if(IsAI(damageOwner)) {
    E = damageOwner getEye();
  }
  else {
    E = damageOwner.origin;
  }

  temp_vec = P - E;

  trace = bulletTrace(E, E + 1.5 * temp_vec, false, damageOwner, false);
  if(isDefined(trace["normal"]) && isDefined(trace["entity"]) && trace["entity"] == self) {
    vec = trace["normal"];

    self thread barrelfx(P, vec, damageOwner);
    return true;
  }
  return false;
}

barrelfx(P, vec, damageOwner) {
  time = level._barrels.fx_time[self.script_noteworthy];
  fx_time = level._barrels._barrel_fx_time[self.script_noteworthy];
  intervals = Int(fx_time / time);
  intervals_end = 30;
  hitsnd = level._barrels._sound[self.script_noteworthy + "_hit"];
  loopsnd = level._barrels._sound[self.script_noteworthy + "_loop"];
  endsnd = level._barrels._sound[self.script_noteworthy + "_end"];

  snd = spawn("script_origin", P);

  snd playSound(hitsnd);
  snd playLoopSound(loopsnd);
  self.barrel_fx_array[self.barrel_fx_array.size] = snd;

  if(isSP()) {
    self thread barrel_damage(P, vec, damageOwner, snd);
  }

  efx_rot = spawn("script_model", P);
  efx_rot setModel("tag_origin");
  efx_rot.angles = VectorToAngles(vec);
  wait .05;
  playFXOnTag(level._barrels._effect[self.script_noteworthy], efx_rot, "tag_origin");
  level._barrels.num_barrel_fx++;
  efx_rot RotatePitch(90, time, 1, 1);
  wait time;
  stopFXOnTag(level._barrels._effect[self.script_noteworthy], efx_rot, "tag_origin");
  intervals--;

  while(level._barrels.num_barrel_fx <= level_limit_barrel_fx && intervals > 0) {
    efx_rot = spawn("script_model", P);
    efx_rot setModel("tag_origin");
    efx_rot.angles = VectorToAngles(vec);
    wait .05;
    playFXOnTag(level._barrels._effect[self.script_noteworthy], efx_rot, "tag_origin");
    level._barrels.num_barrel_fx++;
    efx_rot RotatePitch(90, time, 1, 1);
    wait time;
    stopFXOnTag(level._barrels._effect[self.script_noteworthy], efx_rot, "tag_origin");
  }

  wait(.5);

  snd Delete();
  self.barrel_fx_array = array_removeUndefined(self.barrel_fx_array);

  level._barrels.num_barrel_fx--;
}

barrel_damage(P, vec, damageOwner, fx) {
  if(!allow_barrel_damage()) {
    return;
  }
  fx endon("death");

  origin = fx.origin + (VectorNormalize(vec) * 40);
  dmg = level._barrels._dmg[self.script_noteworthy];

  while(1) {
    if(!isDefined(self.damageOwner)) {
      self RadiusDamage(origin, 36, dmg, dmg * 0.75, undefined, "MOD_TRIGGER_HURT");
    } else {
      self RadiusDamage(origin, 36, dmg, dmg * 0.75, damageOwner, "MOD_TRIGGER_HURT");
    }

    wait(0.4);
  }
}

allow_barrel_damage() {
  if(!isSP()) {
    return false;
  }

  if(!isDefined(level.barrelsDamage)) {
    return false;
  }

  return (level.barrelsDamage);
}

methodsInit() {
  level._barrels._barrel_methods = [];
  level._barrels._barrel_methods["MOD_UNKNOWN"] = ::barrel_calc_splash;
  level._barrels._barrel_methods["MOD_PISTOL_BULLET"] = ::barrel_calc_ballistic;
  level._barrels._barrel_methods["MOD_RIFLE_BULLET"] = ::barrel_calc_ballistic;
  level._barrels._barrel_methods["MOD_GRENADE"] = ::barrel_calc_splash;
  level._barrels._barrel_methods["MOD_GRENADE_SPLASH"] = ::barrel_calc_splash;
  level._barrels._barrel_methods["MOD_PROJECTILE"] = ::barrel_calc_splash;
  level._barrels._barrel_methods["MOD_PROJECTILE_SPLASH"] = ::barrel_calc_splash;
  level._barrels._barrel_methods["MOD_TRIGGER_HURT"] = ::barrel_calc_splash;
  level._barrels._barrel_methods["MOD_EXPLOSIVE"] = ::barrel_calc_splash;
  level._barrels._barrel_methods["MOD_EXPLOSIVE_BULLET"] = ::barrel_calc_splash;
}

barrel_calc_ballistic(P, type) {
  return P;
}

barrel_calc_splash(P, type) {
  vec = VectorNormalize(VectorFromLineToPoint(self.A, self.B, P));
  P = PointOnSegmentNearestToPoint(self.A, self.B, P);
  return (P + (vec * 4));
}

barrel_calc_nofx(P, type) {
  return undefined;
}

precacheFX() {
  oil_leak = false;
  oil_cap = false;
  beer_leak = false;
  foreach(value in self) {
    if(value.script_noteworthy == "oil_leak") {
      value willNeverChange();
      oil_leak = true;
    } else if(value.script_noteworthy == "oil_cap") {
      value willNeverChange();
      oil_cap = true;
    } else if(value.script_noteworthy == "beer_leak") {
      value willNeverChange();
      beer_leak = true;
    } else {
      println("Unknown 'barrel_shootable' script_noteworthy type '%s'\n", value.script_noteworthy);
    }
  }

  if(oil_leak) {
    level._barrels._effect["oil_leak"] = loadfx("fx/impacts/pipe_oil_barrel_spill");

    level._barrels.fx_time["oil_leak"] = 6;
    level._barrels._barrel_fx_time["oil_leak"] = 6;
    level._barrels._dmg["oil_leak"] = 5;
  }
  if(oil_cap) {
    level._barrels._effect["oil_cap"] = loadfx("fx/impacts/pipe_oil_barrel_squirt");

    level._barrels.fx_time["oil_cap"] = 3;
    level._barrels._dmg["oil_cap"] = 5;
    level._barrels._barrel_fx_time["oil_cap"] = 5;
  }
  if(beer_leak) {
    level._barrels._effect["beer_leak"] = loadfx("fx/impacts/beer_barrel_spill");
    level._barrels._sound["beer_leak_hit"] = "mtl_beer_keg_hit";
    level._barrels._sound["beer_leak_loop"] = "mtl_beer_keg_hiss_loop";
    level._barrels._sound["beer_leak_end"] = "mtl_beer_keg_hiss_loop_end";
    level._barrels.fx_time["beer_leak"] = 6;
    level._barrels._barrel_fx_time["beer_leak"] = 6;
    level._barrels._dmg["beer_leak"] = 5;
  }
}