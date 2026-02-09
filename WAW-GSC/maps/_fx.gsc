/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_fx.gsc
**************************************/

#include maps\_utility;
#include maps\_createfx;
#include common_scripts\Utility;

print_org(fxcommand, fxId, fxPos, waittime) {
  if(getDvar("debug") == "1") {
    println("{");
    println("\"origin\" \"" + fxPos[0] + " " + fxPos[1] + " " + fxPos[2] + "\"");
    println("\"classname\" \"script_model\"");
    println("\"model\" \"fx\"");
    println("\"script_fxcommand\" \"" + fxcommand + "\"");
    println("\"script_fxid\" \"" + fxId + "\"");
    println("\"script_delay\" \"" + waittime + "\"");
    println("}");
  }
}

OneShotfx(fxId, fxPos, waittime, fxPos2) {}

OneShotfxthread() {
  maps\_spawner::waitframe();

  if(self.v["delay"] > 0) {
    wait self.v["delay"];
  }

  create_triggerfx();
}

create_triggerfx() {
  self.looper = spawnFx_wrapper(self.v["fxid"], self.v["origin"], self.v["forward"], self.v["up"]);
  triggerFx(self.looper, self.v["delay"]);
  create_loopsound();
}

exploderfx(num, fxId, fxPos, waittime, fxPos2, fireFx, fireFxDelay, fireFxSound, fxSound, fxQuake, fxDamage, soundalias, repeat, delay_min, delay_max, damage_radius, fireFxTimeout, exploder_group) {
  if(1) {
    ent = createExploder(fxId);
    ent.v["origin"] = fxPos;
    ent.v["angles"] = (0, 0, 0);
    if(isDefined(fxPos2)) {
      ent.v["angles"] = vectortoangles(fxPos2 - fxPos);
    }
    ent.v["delay"] = waittime;
    ent.v["exploder"] = num;

    return;
  }
  fx = spawn("script_origin", (0, 0, 0));
  fx.origin = fxPos;
  fx.angles = vectortoangles(fxPos2 - fxPos);
  fx.script_exploder = num;
  fx.script_fxid = fxId;
  fx.script_delay = waittime;

  fx.script_firefx = fireFx;
  fx.script_firefxdelay = (fireFxDelay);
  fx.script_firefxsound = fireFxSound;

  fx.script_sound = fxSound;
  fx.script_earthquake = fxQuake;
  fx.script_damage = (fxDamage);
  fx.script_radius = (damage_radius);
  fx.script_soundalias = soundalias;
  fx.script_firefxtimeout = (fireFxTimeout);
  fx.script_repeat = (repeat);
  fx.script_delay_min = (delay_min);
  fx.script_delay_max = (delay_max);
  fx.script_exploder_group = exploder_group;

  forward = anglesToForward(fx.angles);
  forward = vectorScale(forward, 150);
  fx.targetPos = fxPos + forward;

  if(!isDefined(level._script_exploders)) {
    level._script_exploders = [];
  }
  level._script_exploders[level._script_exploders.size] = fx;

  maps\_createfx::createfx_showOrigin(fxid, fxPos, waittime, fxpos2, "exploderfx", fx, undefined, fireFx, fireFxDelay, fireFxSound, fxSound, fxQuake, fxDamage, soundalias, repeat, delay_min, delay_max, damage_radius, fireFxTimeout);
}

loopfx(fxId, fxPos, waittime, fxPos2, fxStart, fxStop, timeout) {
  println("Loopfx is deprecated!");
  ent = createLoopEffect(fxId);
  ent.v["origin"] = fxPos;
  ent.v["angles"] = (0, 0, 0);
  if(isDefined(fxPos2)) {
    ent.v["angles"] = vectortoangles(fxPos2 - fxPos);
  }
  ent.v["delay"] = waittime;
}

create_looper() {
  self.looper = playLoopedFx(level._effect[self.v["fxid"]], self.v["delay"], self.v["origin"], 0, self.v["forward"], self.v["up"]);
  create_loopsound();
}

create_loopsound() {
  self notify("stop_loop");
  if(isDefined(self.v["soundalias"]) && (self.v["soundalias"] != "nil")) {
    if(isDefined(self.v["stopable"]) && self.v["stopable"]) {
      if(isDefined(self.looper)) {
        self.looper thread maps\_utility::loop_fx_sound(self.v["soundalias"], self.v["origin"], "death");
      } else {
        thread maps\_utility::loop_fx_sound(self.v["soundalias"], self.v["origin"], "stop_loop");
      }
    } else {
      if(isDefined(self.looper)) {
        self.looper thread maps\_utility::loop_fx_sound(self.v["soundalias"], self.v["origin"]);
      } else {
        thread maps\_utility::loop_fx_sound(self.v["soundalias"], self.v["origin"]);
      }
    }
  }
}

create_trail_loopsound() {
  self notify("stop_loop");
  if(isDefined(self.v["soundalias"]) && (self.v["soundalias"] != "nil")) {
    self.trailfx_looper thread maps\_utility::loop_fx_sound(self.v["soundalias"], self.v["origin"], "death");
  }
}

stop_loopsound() {
  self notify("stop_loop");
}

loopfxthread() {
  maps\_spawner::waitframe();

  if(isDefined(self.fxStart)) {
    level waittill("start fx" + self.fxStart);
  }

  while(1) {
    create_looper();

    if(isDefined(self.timeout)) {
      thread loopfxStop(self.timeout);
    }

    if(isDefined(self.fxStop)) {
      level waittill("stop fx" + self.fxStop);
    } else {
      return;
    }

    if(isDefined(self.looper)) {
      self.looper delete();
    }

    if(isDefined(self.fxStart)) {
      level waittill("start fx" + self.fxStart);
    } else {
      return;
    }
  }
}

loopfxChangeID(ent) {
  self endon("death");
  ent waittill("effect id changed", change);
}

loopfxChangeOrg(ent) {
  self endon("death");
  for(;;) {
    ent waittill("effect org changed", change);
    self.origin = change;
  }
}

loopfxChangeDelay(ent) {
  self endon("death");
  ent waittill("effect delay changed", change);
}

loopfxDeletion(ent) {
  self endon("death");
  ent waittill("effect deleted");
  self delete();
}

loopfxStop(timeout) {
  self endon("death");
  wait(timeout);
  self.looper delete();
}

loopSound(sound, Pos, waittime) {
  level thread loopSoundthread(sound, Pos, waittime);
}

loopSoundthread(sound, pos, waittime) {
  org = spawn("script_origin", (pos));

  org.origin = pos;
  org playLoopSound(sound);
}

gunfireloopfx(fxId, fxPos, shotsMin, shotsMax, shotdelayMin, shotdelayMax, betweenSetsMin, betweenSetsMax) {
  thread gunfireloopfxthread(fxId, fxPos, shotsMin, shotsMax, shotdelayMin, shotdelayMax, betweenSetsMin, betweenSetsMax);
}

gunfireloopfxthread(fxId, fxPos, shotsMin, shotsMax, shotdelayMin, shotdelayMax, betweenSetsMin, betweenSetsMax) {
  level endon("stop all gunfireloopfx");
  maps\_spawner::waitframe();

  if(betweenSetsMax < betweenSetsMin) {
    temp = betweenSetsMax;
    betweenSetsMax = betweenSetsMin;
    betweenSetsMin = temp;
  }

  betweenSetsBase = betweenSetsMin;
  betweenSetsRange = betweenSetsMax - betweenSetsMin;

  if(shotdelayMax < shotdelayMin) {
    temp = shotdelayMax;
    shotdelayMax = shotdelayMin;
    shotdelayMin = temp;
  }

  shotdelayBase = shotdelayMin;
  shotdelayRange = shotdelayMax - shotdelayMin;

  if(shotsMax < shotsMin) {
    temp = shotsMax;
    shotsMax = shotsMin;
    shotsMin = temp;
  }

  shotsBase = shotsMin;
  shotsRange = shotsMax - shotsMin;

  fxEnt = spawnFx_wrapper(fxId, fxPos);
  for(;;) {
    shotnum = shotsBase + randomint(shotsRange);
    for(i = 0; i < shotnum; i++) {
      triggerFx(fxEnt);

      wait(shotdelayBase + randomfloat(shotdelayRange));
    }
    wait(betweenSetsBase + randomfloat(betweenSetsRange));
  }
}

gunfireloopfxVec(fxId, fxPos, fxPos2, shotsMin, shotsMax, shotdelayMin, shotdelayMax, betweenSetsMin, betweenSetsMax) {
  thread gunfireloopfxVecthread(fxId, fxPos, fxPos2, shotsMin, shotsMax, shotdelayMin, shotdelayMax, betweenSetsMin, betweenSetsMax);
}

gunfireloopfxVecthread(fxId, fxPos, fxPos2, shotsMin, shotsMax, shotdelayMin, shotdelayMax, betweenSetsMin, betweenSetsMax) {
  level endon("stop all gunfireloopfx");
  maps\_spawner::waitframe();

  if(betweenSetsMax < betweenSetsMin) {
    temp = betweenSetsMax;
    betweenSetsMax = betweenSetsMin;
    betweenSetsMin = temp;
  }

  betweenSetsBase = betweenSetsMin;
  betweenSetsRange = betweenSetsMax - betweenSetsMin;

  if(shotdelayMax < shotdelayMin) {
    temp = shotdelayMax;
    shotdelayMax = shotdelayMin;
    shotdelayMin = temp;
  }

  shotdelayBase = shotdelayMin;
  shotdelayRange = shotdelayMax - shotdelayMin;

  if(shotsMax < shotsMin) {
    temp = shotsMax;
    shotsMax = shotsMin;
    shotsMin = temp;
  }

  shotsBase = shotsMin;
  shotsRange = shotsMax - shotsMin;

  fxPos2 = vectornormalize(fxPos2 - fxPos);

  fxEnt = spawnFx_wrapper(fxId, fxPos, fxPos2);

  for(;;) {
    shotnum = shotsBase + randomint(shotsRange);
    for(i = 0; i < int(shotnum / level.fxfireloopmod); i++) {
      triggerFx(fxEnt);
      delay = ((shotdelayBase + randomfloat(shotdelayRange)) * level.fxfireloopmod);
      if(delay < .05) {
        delay = .05;
      }
      wait delay;
    }
    wait(shotdelayBase + randomfloat(shotdelayRange));
    wait(betweenSetsBase + randomfloat(betweenSetsRange));
  }
}

setfireloopmod(value) {
  level.fxfireloopmod = 1 / value;
}

setup_fx() {
  if((!isDefined(self.script_fxid)) || (!isDefined(self.script_fxcommand)) || (!isDefined(self.script_delay))) {
    return;
  }
  if(isDefined(self.model)) {
    if(self.model == "toilet") {
  }
      self thread burnville_paratrooper_hack();
      return;
    }

  org = undefined;
  if(isDefined(self.target)) {
    ent = getent(self.target, "targetname");
    if(isDefined(ent)) {
      org = ent.origin;
    }
  }

  fxStart = undefined;
  if(isDefined(self.script_fxstart)) {
    fxStart = self.script_fxstart;
  }

  fxStop = undefined;
  if(isDefined(self.script_fxstop)) {
    fxStop = self.script_fxstop;
  }

  if(self.script_fxcommand == "OneShotfx") {
    OneShotfx(self.script_fxId, self.origin, self.script_delay, org);
  }
  if(self.script_fxcommand == "loopfx") {
    loopfx(self.script_fxId, self.origin, self.script_delay, org, fxStart, fxStop);
  }
  if(self.script_fxcommand == "loopsound") {
    loopsound(self.script_fxId, self.origin, self.script_delay);
  }

  self delete();
}

burnville_paratrooper_hack() {
  normal = (0, 0, self.angles[1]);
  id = level._effect[self.script_fxId];
  origin = self.origin;

  wait 1;
  level thread burnville_paratrooper_hack_loop(normal, origin, id);
  self delete();
}

burnville_paratrooper_hack_loop(normal, origin, id) {
  while(1) {
    playFX(id, origin);
    wait(30 + randomfloat(40));
  }
}

script_print_fx() {
  if((!isDefined(self.script_fxid)) || (!isDefined(self.script_fxcommand)) || (!isDefined(self.script_delay))) {
    println("Effect at origin ", self.origin, " doesn't have script_fxid/script_fxcommand/script_delay");
    self delete();
    return;
  }

  if(isDefined(self.target)) {
    org = getent(self.target).origin;
  } else {
    org = "undefined";
  }
  if(self.script_fxcommand == "OneShotfx") {
    println("maps\_fx::OneShotfx(\"" + self.script_fxid + "\", " + self.origin + ", " + self.script_delay + ", " + org + ");");
  }

  if(self.script_fxcommand == "loopfx") {
    println("maps\_fx::LoopFx(\"" + self.script_fxid + "\", " + self.origin + ", " + self.script_delay + ", " + org + ");");
  }

  if(self.script_fxcommand == "loopsound") {
    println("maps\_fx::LoopSound(\"" + self.script_fxid + "\", " + self.origin + ", " + self.script_delay + ", " + org + ");");
  }
}

script_playFX(id, pos, pos2) {
  if(!id) {
    return;
  }
  if(isDefined(pos2)) {
    playFX(id, pos, pos2);
  } else {
    playFX(id, pos);
  }
}

script_playFXOnTag(id, ent, tag) {
  if(!id) {
    return;
  }
  playFXOnTag(id, ent, tag);
}

GrenadeExplosionfx(pos) {
  playFX(level._effect["mechanical explosion"], pos);
  earthquake(0.15, 0.5, pos, 250);
}

soundfx(fxId, fxPos, endonNotify) {
  org = spawn("script_origin", (0, 0, 0));
  org.origin = fxPos;
  org playLoopSound(fxId);
  if(isDefined(endonNotify)) {
    org thread soundfxDelete(endonNotify);
  }
}

soundfxDelete(endonNotify) {
  level waittill(endonNotify);
  self delete();
}

rainfx(fxId, fxId2, fxPos) {
  org = spawn("script_origin", (0, 0, 0));
  org.origin = fxPos;
  org thread rainLoop(fxId, fxId2);
}

rainLoop(hardRain, lightRain) {
  self endon("death");
  blend = spawn("sound_blend", (0.0, 0.0, 0.0));
  blend.origin = self.origin;
  self thread blendDelete(blend);

  blend2 = spawn("sound_blend", (0.0, 0.0, 0.0));
  blend2.origin = self.origin;
  self thread blendDelete(blend2);

  blend setSoundBlend(lightRain + "_null", lightRain, 0);
  blend2 setSoundBlend(hardRain + "_null", hardRain, 1);
  rain = "hard";
  blendTime = undefined;
  for(;;) {
    level waittill("rain_change", change, blendTime);
    blendTime *= 20;
    assert(change == "hard" || change == "light" || change == "none");
    assert(blendtime > 0);

    if(change == "hard") {
      if(rain == "none") {
        blendTime *= 0.5;
        for(i = 0; i < blendtime; i++) {
          blend setSoundBlend(lightRain + "_null", lightRain, i / blendtime);
          wait(0.05);
        }
        rain = "light";
      }
      if(rain == "light") {
        for(i = 0; i < blendtime; i++) {
          blend setSoundBlend(lightRain + "_null", lightRain, 1 - (i / blendtime));
          blend2 setSoundBlend(hardRain + "_null", hardRain, i / blendtime);
          wait(0.05);
        }
      }
    }
    if(change == "none") {
      if(rain == "hard") {
        blendTime *= 0.5;
        for(i = 0; i < blendtime; i++) {
          blend setSoundBlend(lightRain + "_null", lightRain, (i / blendtime));
          blend2 setSoundBlend(hardRain + "_null", hardRain, 1 - (i / blendtime));
          wait(0.05);
        }
        rain = "light";
      }
      if(rain == "light") {
        for(i = 0; i < blendtime; i++) {
          blend setSoundBlend(lightRain + "_null", lightRain, 1 - (i / blendtime));
          wait(0.05);
        }
      }
    }
    if(change == "light") {
      if(rain == "none") {
        for(i = 0; i < blendtime; i++) {
          blend setSoundBlend(lightRain + "_null", lightRain, i / blendtime);
          wait(0.05);
        }
      }
      if(rain == "hard") {
        for(i = 0; i < blendtime; i++) {
          blend setSoundBlend(lightRain + "_null", lightRain, i / blendtime);
          blend2 setSoundBlend(hardRain + "_null", hardRain, 1 - (i / blendtime));
          wait(0.05);
        }
      }
    }

    rain = change;
  }
}

blendDelete(blend) {
  self waittill("death");
  blend delete();
}
spawnFX_wrapper(fx_id, origin, forward, up) {
  assertEx(isDefined(level._effect[fx_id]), "Missing level._effect[\"" + fx_id + "\"]. You did not setup the fx before calling it in createFx.");

  fx_object = SpawnFx(level._effect[fx_id], origin, forward, up);
  return fx_object;
}