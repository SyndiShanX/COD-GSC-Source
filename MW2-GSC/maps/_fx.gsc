/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_fx.gsc
********************************************************/

#include common_scripts\utility;
#include common_scripts\_fx;
#include common_scripts\_createfx;
#include maps\_utility;
#include maps\_createfx;

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

watersheeting(trigger) {
  duration = 3;
  if(isDefined(trigger.script_duration)) {
    duration = trigger.script_duration;
  }

  while(true) {
    trigger waittill("trigger", other);
    if(isPlayer(other)) {
      other SetWaterSheeting(1, duration);
      wait duration * 0.2;
    }
  }
}