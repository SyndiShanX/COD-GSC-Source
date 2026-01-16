/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_fx.gsc
**************************************/

#include maps\_utility;
#include maps\_createfx;
#include common_scripts\utility;

oneshotfx(fxid, fxpos, waittime, fxpos2) {
}

oneshotfxthread() {
  wait 0.05;

  if(self.v["delay"] > 0)
    wait(self.v["delay"]);

  create_triggerfx();
}

create_triggerfx() {
  self.looper = spawnfx_wrapper(self.v["fxid"], self.v["origin"], self.v["forward"], self.v["up"], self.v["primlightfrac"], self.v["lightoriginoffs"]);
  triggerfx(self.looper, self.v["delay"]);
  create_loopsound();
}

loopfx(fxid, fxpos, waittime, fxpos2, fxstart, fxstop, timeout) {
  println("Loopfx is deprecated!");

  ent = createloopeffect(fxid);
  ent.v["origin"] = fxpos;
  ent.v["angles"] = (0, 0, 0);

  if(isDefined(fxpos2))
    ent.v["angles"] = vectortoangles(fxpos2 - fxpos);

  ent.v["delay"] = waittime;
}

create_looper() {
  self.looper = playloopedfx(level._effect[self.v["fxid"]], self.v["delay"], self.v["origin"], 0, self.v["forward"], self.v["up"], self.v["primlightfrac"], self.v["lightoriginoffs"]);
  create_loopsound();
}

create_loopsound() {
  self notify("stop_loop");

  if(isDefined(self.v["soundalias"]) && self.v["soundalias"] != "nil") {
    if(isDefined(self.v["stopable"]) && self.v["stopable"]) {
      if(isDefined(self.looper))
        self.looper thread maps\_utility::loop_fx_sound(self.v["soundalias"], self.v["origin"], "death");
      else
        thread maps\_utility::loop_fx_sound(self.v["soundalias"], self.v["origin"], "stop_loop");
    } else if(isDefined(self.looper))
      self.looper thread maps\_utility::loop_fx_sound(self.v["soundalias"], self.v["origin"]);
    else
      thread maps\_utility::loop_fx_sound(self.v["soundalias"], self.v["origin"]);
  }
}

stop_loopsound() {
  self notify("stop_loop");
}

loopfxthread() {
  wait 0.05;

  if(isDefined(self.fxstart))
    level waittill("start fx" + self.fxstart);

  while(true) {
    create_looper();

    if(isDefined(self.timeout))
      thread loopfxstop(self.timeout);

    if(isDefined(self.fxstop))
      level waittill("stop fx" + self.fxstop);
    else
      return;

    if(isDefined(self.looper))
      self.looper delete();

    if(isDefined(self.fxstart))
      level waittill("start fx" + self.fxstart);
    else
      return;
  }
}

loopfxstop(timeout) {
  self endon("death");
  wait(timeout);
  self.looper delete();
}

loopsound(sound, pos, waittime) {
  level thread loopsoundthread(sound, pos, waittime);
}

loopsoundthread(sound, pos, waittime) {
  org = spawn("script_origin", pos);
  org.origin = pos;
  org playloopsound(sound);
}

setup_fx() {
  if(!isDefined(self.script_fxid) || !isDefined(self.script_fxcommand) || !isDefined(self.script_delay)) {
    return;
  }
  org = undefined;

  if(isDefined(self.target)) {
    ent = getent(self.target, "targetname");

    if(isDefined(ent))
      org = ent.origin;
  }

  fxstart = undefined;

  if(isDefined(self.script_fxstart))
    fxstart = self.script_fxstart;

  fxstop = undefined;

  if(isDefined(self.script_fxstop))
    fxstop = self.script_fxstop;

  if(self.script_fxcommand == "OneShotfx")
    oneshotfx(self.script_fxid, self.origin, self.script_delay, org);

  if(self.script_fxcommand == "loopfx")
    loopfx(self.script_fxid, self.origin, self.script_delay, org, fxstart, fxstop);

  if(self.script_fxcommand == "loopsound")
    loopsound(self.script_fxid, self.origin, self.script_delay);

  self delete();
}

soundfx(fxid, fxpos, endonnotify) {
  org = spawn("script_origin", (0, 0, 0));
  org.origin = fxpos;
  org playloopsound(fxid);

  if(isDefined(endonnotify))
    org thread soundfxdelete(endonnotify);
}

soundfxdelete(endonnotify) {
  level waittill(endonnotify);
  self delete();
}

rainfx(fxid, fxid2, fxpos) {
  org = spawn("script_origin", (0, 0, 0));
  org.origin = fxpos;
  org thread rainloop(fxid, fxid2);
}

rainloop(hardrain, lightrain) {
  self endon("death");
  blend = spawn("sound_blend", (0, 0, 0));
  blend.origin = self.origin;
  self thread blenddelete(blend);
  blend2 = spawn("sound_blend", (0, 0, 0));
  blend2.origin = self.origin;
  self thread blenddelete(blend2);
  blend setsoundblend(lightrain + "_null", lightrain, 0);
  blend2 setsoundblend(hardrain + "_null", hardrain, 1);
  rain = "hard";
  blendtime = undefined;

  for(;;) {
    level waittill("rain_change", change, blendtime);
    blendtime = blendtime * 20;
    assert(change == "hard" || change == "light" || change == "none");
    assert(blendtime > 0);

    if(change == "hard") {
      if(rain == "none") {
        blendtime = blendtime * 0.5;

        for(i = 0; i < blendtime; i++) {
          blend setsoundblend(lightrain + "_null", lightrain, i / blendtime);
          wait 0.05;
        }

        rain = "light";
      }

      if(rain == "light") {
        for(i = 0; i < blendtime; i++) {
          blend setsoundblend(lightrain + "_null", lightrain, 1 - i / blendtime);
          blend2 setsoundblend(hardrain + "_null", hardrain, i / blendtime);
          wait 0.05;
        }
      }
    }

    if(change == "none") {
      if(rain == "hard") {
        blendtime = blendtime * 0.5;

        for(i = 0; i < blendtime; i++) {
          blend setsoundblend(lightrain + "_null", lightrain, i / blendtime);
          blend2 setsoundblend(hardrain + "_null", hardrain, 1 - i / blendtime);
          wait 0.05;
        }

        rain = "light";
      }

      if(rain == "light") {
        for(i = 0; i < blendtime; i++) {
          blend setsoundblend(lightrain + "_null", lightrain, 1 - i / blendtime);
          wait 0.05;
        }
      }
    }

    if(change == "light") {
      if(rain == "none") {
        for(i = 0; i < blendtime; i++) {
          blend setsoundblend(lightrain + "_null", lightrain, i / blendtime);
          wait 0.05;
        }
      }

      if(rain == "hard") {
        for(i = 0; i < blendtime; i++) {
          blend setsoundblend(lightrain + "_null", lightrain, i / blendtime);
          blend2 setsoundblend(hardrain + "_null", hardrain, 1 - i / blendtime);
          wait 0.05;
        }
      }
    }

    rain = change;
  }
}

blenddelete(blend) {
  self waittill("death");
  blend delete();
}

spawnfx_wrapper(fx_id, origin, forward, up, primlightfrac, lightoriginoffs) {
  assert(isDefined(level._effect[fx_id]), "Missing level._effect[\"" + fx_id + "\"]. You did not setup the fx before calling it in createFx.");
  fx_object = spawnfx(level._effect[fx_id], origin, forward, up, primlightfrac, lightoriginoffs);
  return fx_object;
}