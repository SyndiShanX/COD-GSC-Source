/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: common_scripts\_pipes.gsc
*****************************************************/

#include common_scripts\utility;

level_limit_pipe_fx = 8;
max_fires_from_entity = 4;
level_pipe_fx_chance = 33;

main() {
  if(isDefined(level.pipes_init)) {
    return;
  }
  level.pipes_init = true;

  pipes = getEntArray("pipe_shootable", "targetname");
  if(!pipes.size) {
    return;
  }
  level._pipes = spawnStruct();
  level._pipes.num_pipe_fx = 0;

  pipes thread precacheFX();
  pipes thread methodsInit();

  thread post_load(pipes);
}

post_load(pipes) {
  waittillframeend;
  if(level.createFX_enabled) {
    return;
  }
  array_thread(pipes, ::pipesetup);
}

pipesetup() {
  self setCanDamage(true);
  self setCanRadiusDamage(false);
  self.pipe_fx_array = [];

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

  self thread pipe_wait_loop();
}

pipe_wait_loop() {
  P = (0, 0, 0);

  hasTakenDamage = false;
  remaining = max_fires_from_entity;

  while(1) {
    self waittill("damage", damage, attacker, direction_vec, P, type);

    if(hasTakenDamage) {
      if(randomint(100) <= level_pipe_fx_chance) {
        continue;
      }
    }
    hasTakenDamage = true;

    result = self pipe_logic(direction_vec, P, type, attacker);
    if(result) {
      remaining--;
    }

    if(remaining <= 0) {
      break;
    }
  }

  self setCanDamage(false);
}

pipe_logic(direction_vec, P, type, damageOwner) {
  if(level._pipes.num_pipe_fx > level_limit_pipe_fx) {
    return false;
  }

  if(!isDefined(level._pipes._pipe_methods[type])) {
    P = self pipe_calc_nofx(P, type);
  }
  else {
    P = self[[level._pipes._pipe_methods[type]]](P, type);
  }

  if(!isDefined(P)) {
    return false;
  }

  if(isDefined(damageOwner.classname) && damageOwner.classname == "worldspawn") {
    return false;
  }

  foreach(value in self.pipe_fx_array) {
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

    self thread pipefx(P, vec, damageOwner);
    return true;
  }
  return false;
}

pipefx(P, vec, damageOwner) {
  time = level._pipes.fx_time[self.script_noteworthy];
  fx_time = level._pipes._pipe_fx_time[self.script_noteworthy];
  intervals = Int(fx_time / time);
  intervals_end = 30;
  hitsnd = level._pipes._sound[self.script_noteworthy + "_hit"];
  loopsnd = level._pipes._sound[self.script_noteworthy + "_loop"];
  endsnd = level._pipes._sound[self.script_noteworthy + "_end"];

  snd = spawn("script_origin", P);

  snd playSound(hitsnd);
  snd playLoopSound(loopsnd);
  self.pipe_fx_array[self.pipe_fx_array.size] = snd;

  if(isSP() || self.script_noteworthy != "steam") {
    self thread pipe_damage(P, vec, damageOwner, snd);
  }

  if(self.script_noteworthy == "oil_leak") {
    efx_rot = spawn("script_model", P);
    efx_rot setModel("tag_origin");
    efx_rot.angles = VectorToAngles(vec);
    playFXOnTag(level._pipes._effect[self.script_noteworthy], efx_rot, "tag_origin");
    level._pipes.num_pipe_fx++;
    efx_rot RotatePitch(90, time, 1, 1);
    wait time;
    stopFXOnTag(level._pipes._effect[self.script_noteworthy], efx_rot, "tag_origin");
    intervals--;
  } else {
    playFX(level._pipes._effect[self.script_noteworthy], P, vec);
    level._pipes.num_pipe_fx++;
    wait time;
    intervals--;
  }

  while(level._pipes.num_pipe_fx <= level_limit_pipe_fx && intervals > 0) {
    if(self.script_noteworthy == "oil_leak") {
      efx_rot = spawn("script_model", P);
      efx_rot setModel("tag_origin");
      efx_rot.angles = VectorToAngles(vec);
      playFXOnTag(level._pipes._effect[self.script_noteworthy], efx_rot, "tag_origin");
      level._pipes.num_pipe_fx++;
      efx_rot RotatePitch(90, time, 1, 1);
      wait time;
      stopFXOnTag(level._pipes._effect[self.script_noteworthy], efx_rot, "tag_origin");
    } else {
      playFX(level._pipes._effect[self.script_noteworthy], P, vec);
      wait time;
      intervals--;
    }
  }

  snd playSound(endsnd);
  wait(.5);
  snd StopLoopSound(loopsnd);
  snd Delete();
  self.pipe_fx_array = array_removeUndefined(self.pipe_fx_array);

  level._pipes.num_pipe_fx--;
}

pipe_damage(P, vec, damageOwner, fx) {
  if(!allow_pipe_damage()) {
    return;
  }
  fx endon("death");

  origin = fx.origin + (VectorNormalize(vec) * 40);
  dmg = level._pipes._dmg[self.script_noteworthy];

  while(1) {
    if(!isDefined(self.damageOwner)) {
      self RadiusDamage(origin, 36, dmg, dmg * 0.75, undefined, "MOD_TRIGGER_HURT");
    } else {
      self RadiusDamage(origin, 36, dmg, dmg * 0.75, damageOwner, "MOD_TRIGGER_HURT");
    }

    wait(0.4);
  }
}

allow_pipe_damage() {
  if(!isSP()) {
    return false;
  }

  if(!isDefined(level.pipesDamage)) {
    return true;
  }

  return (level.pipesDamage);
}

methodsInit() {
  level._pipes._pipe_methods = [];
  level._pipes._pipe_methods["MOD_UNKNOWN"] = ::pipe_calc_splash;
  level._pipes._pipe_methods["MOD_PISTOL_BULLET"] = ::pipe_calc_ballistic;
  level._pipes._pipe_methods["MOD_RIFLE_BULLET"] = ::pipe_calc_ballistic;
  level._pipes._pipe_methods["MOD_GRENADE"] = ::pipe_calc_splash;
  level._pipes._pipe_methods["MOD_GRENADE_SPLASH"] = ::pipe_calc_splash;
  level._pipes._pipe_methods["MOD_PROJECTILE"] = ::pipe_calc_splash;
  level._pipes._pipe_methods["MOD_PROJECTILE_SPLASH"] = ::pipe_calc_splash;
  level._pipes._pipe_methods["MOD_TRIGGER_HURT"] = ::pipe_calc_splash;
  level._pipes._pipe_methods["MOD_EXPLOSIVE"] = ::pipe_calc_splash;
  level._pipes._pipe_methods["MOD_EXPLOSIVE_BULLET"] = ::pipe_calc_splash;
}

pipe_calc_ballistic(P, type) {
  return P;
}

pipe_calc_splash(P, type) {
  vec = VectorNormalize(VectorFromLineToPoint(self.A, self.B, P));
  P = PointOnSegmentNearestToPoint(self.A, self.B, P);
  return (P + (vec * 4));
}

pipe_calc_nofx(P, type) {
  return undefined;
}

precacheFX() {
  steam = false;
  fire = false;
  steam_small = false;
  oil_leak = false;
  oil_cap = false;
  foreach(value in self) {
    if(value.script_noteworthy == "water") {
      value.script_noteworthy = "steam";
    }

    if(value.script_noteworthy == "steam") {
      value willNeverChange();
      steam = true;
    } else if(value.script_noteworthy == "fire") {
      value willNeverChange();
      fire = true;
    } else if(value.script_noteworthy == "steam_small") {
      value willNeverChange();
      steam_small = true;
    } else if(value.script_noteworthy == "oil_leak") {
      value willNeverChange();
      oil_leak = true;
    } else if(value.script_noteworthy == "oil_cap") {
      value willNeverChange();
      oil_cap = true;
    } else {
      println("Unknown 'pipe_shootable' script_noteworthy type '%s'\n", value.script_noteworthy);
    }
  }

  if(steam) {
    level._pipes._effect["steam"] = LoadFX("fx/impacts/pipe_steam");
    level._pipes._sound["steam_hit"] = "mtl_steam_pipe_hit";
    level._pipes._sound["steam_loop"] = "mtl_steam_pipe_hiss_loop";
    level._pipes._sound["steam_end"] = "mtl_steam_pipe_hiss_loop_end";
    level._pipes.fx_time["steam"] = 3;
    level._pipes._dmg["steam"] = 5;
    level._pipes._pipe_fx_time["steam"] = 25;
  }

  if(steam_small) {
    level._pipes._effect["steam_small"] = LoadFX("fx/impacts/pipe_steam_small");
    level._pipes._sound["steam_small_hit"] = "mtl_steam_pipe_hit";
    level._pipes._sound["steam_small_loop"] = "mtl_steam_pipe_hiss_loop";
    level._pipes._sound["steam_small_end"] = "mtl_steam_pipe_hiss_loop_end";
    level._pipes.fx_time["steam_small"] = 3;
    level._pipes._dmg["steam_small"] = 5;
    level._pipes._pipe_fx_time["steam_small"] = 25;
  }

  if(fire) {
    level._pipes._effect["fire"] = LoadFX("fx/impacts/pipe_fire");
    level._pipes._sound["fire_hit"] = "mtl_gas_pipe_hit";
    level._pipes._sound["fire_loop"] = "mtl_gas_pipe_flame_loop";
    level._pipes._sound["fire_end"] = "mtl_gas_pipe_flame_end";
    level._pipes.fx_time["fire"] = 3;
    level._pipes._dmg["fire"] = 5;
    level._pipes._pipe_fx_time["fire"] = 25;
  }

  if(oil_leak) {
    level._pipes._effect["oil_leak"] = LoadFX("fx/impacts/pipe_oil_barrel_spill");

    level._pipes._sound["oil_leak_hit"] = "mtl_oil_barrel_hit";
    level._pipes._sound["oil_leak_loop"] = "mtl_oil_barrel_hiss_loop";
    level._pipes._sound["oil_leak_end"] = "mtl_oil_barrel_hiss_loop_end";
    level._pipes.fx_time["oil_leak"] = 6;
    level._pipes._pipe_fx_time["oil_leak"] = 6;
    level._pipes._dmg["oil_leak"] = 5;
  }

  if(oil_cap) {
    level._pipes._effect["oil_cap"] = LoadFX("fx/impacts/pipe_oil_barrel_squirt");
    level._pipes._sound["oil_cap_hit"] = "mtl_steam_pipe_hit";
    level._pipes._sound["oil_cap_loop"] = "mtl_steam_pipe_hiss_loop";
    level._pipes._sound["oil_cap_end"] = "mtl_steam_pipe_hiss_loop_end";
    level._pipes.fx_time["oil_cap"] = 3;
    level._pipes._dmg["oil_cap"] = 5;
    level._pipes._pipe_fx_time["oil_cap"] = 5;
  }
}