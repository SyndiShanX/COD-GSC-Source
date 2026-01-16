/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_fx.gsc
**************************************/

#include maps\_utility;
#include maps\_createfx;
#include common_scripts\Utility;

OneShotfx(fxId, fxPos, waittime, fxPos2) {}
OneShotfxthread() {
  maps\_spawner::waitframe();
  if(self.v["delay"] > 0)
    wait self.v["delay"];
  create_triggerfx();
}

create_triggerfx() {
  self.looper = spawnFx_wrapper(self.v["fxid"], self.v["origin"], self.v["forward"], self.v["up"]);
  triggerFx(self.looper, self.v["delay"]);
  create_loopsound();
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

setup_fx() {
  if((!isDefined(self.script_fxid)) || (!isDefined(self.script_fxcommand)) || (!isDefined(self.script_delay))) {
    return;
  }
  org = undefined;
  if(isDefined(self.target)) {
    ent = getEnt(self.target, "targetname");
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
  fx_object = SpawnFx(level._effect[fx_id], origin, forward, up);
  return fx_object;
}