/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_fx.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\_music;
#include clientscripts\_lights;
#include clientscripts\_destructibles;

createloopsound() {
  ent = spawnstruct();

  if(!isDefined(level.createfxent))
    level.createfxent = [];

  level.createfxent[level.createfxent.size] = ent;
  ent.v = [];
  ent.v["type"] = "soundfx";
  ent.v["fxid"] = "No FX";
  ent.v["soundalias"] = "nil";
  ent.v["angles"] = (0, 0, 0);
  ent.v["origin"] = (0, 0, 0);
  ent.drawn = 1;
  return ent;
}

createeffect(type, fxid) {
  ent = spawnstruct();

  if(!isDefined(level.createfxent))
    level.createfxent = [];

  level.createfxent[level.createfxent.size] = ent;
  ent.v = [];
  ent.v["type"] = type;
  ent.v["fxid"] = fxid;
  ent.v["angles"] = (0, 0, 0);
  ent.v["origin"] = (0, 0, 0);
  ent.drawn = 1;
  return ent;
}

exploder_delay() {
  if(!isDefined(self.v["delay"]))
    self.v["delay"] = 0;

  min_delay = self.v["delay"];
  max_delay = self.v["delay"] + 0.001;

  if(isDefined(self.v["delay_min"]))
    min_delay = self.v["delay_min"];

  if(isDefined(self.v["delay_max"]))
    max_delay = self.v["delay_max"];

  if(min_delay > 0)
    waitrealtime(randomfloatrange(min_delay, max_delay));
}

fire_effect() {
  forward = self.v["forward"];
  up = self.v["up"];
  firefxsound = self.v["firefxsound"];
  origin = self.v["origin"];
  firefx = self.v["firefx"];
  ender = self.v["ender"];

  if(!isDefined(ender))
    ender = "createfx_effectStopper";

  timeout = self.v["firefxtimeout"];
  firefxdelay = 0.5;

  if(isDefined(self.v["firefxdelay"]))
    firefxdelay = self.v["firefxdelay"];

  self exploder_delay();

  if(isDefined(firefxsound))
    level thread clientscripts\_utility::loop_fx_sound(firefxsound, origin, ender, timeout);

  players = level.localplayers;

  for(i = 0; i < players.size; i++)
    playfx(i, level._effect[firefx], self.v["origin"], forward, up, 0, self.v["primlightfrac"], self.v["lightoriginoffs"]);
}

exploder_playsound() {
  if(!isDefined(self.v["soundalias"]) || self.v["soundalias"] == "nil") {
    return;
  }
  play_sound_in_space(0, self.v["soundalias"], self.v["origin"]);
}

cannon_effect() {
  if(isDefined(self.v["repeat"])) {
    for(i = 0; i < self.v["repeat"]; i++) {
      players = level.localplayers;

      for(player = 0; player < players.size; player++)
        playfx(player, level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);

      self exploder_delay();
    }

    return;
  }

  self exploder_delay();
  players = level.localplayers;

  if(isDefined(self.loopfx)) {
    for(i = 0; i < self.loopfx.size; i++)
      stopfx(i, self.loopfx[i]);

    self.loopfx = [];
  }

  if(!isDefined(self.loopfx))
    self.loopfx = [];

  if(!isDefined(level._effect[self.v["fxid"]])) {
    assertmsg("*** Client : Effect " + self.v["fxid"] + " not precached in level_fx.csc.");

    return;
  }

  for(i = 0; i < players.size; i++) {
    if(isDefined(self.v["fxid"]))
      self.loopfx[i] = playfx(i, level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);
  }

  self exploder_playsound();
}

exploder_earthquake() {
  self exploder_delay();
  eq = level.earthquake[self.v["earthquake"]];

  if(isDefined(eq))
    level.localplayers[0] earthquake(eq["magnitude"], eq["duration"], self.v["origin"], eq["radius"]);
}

activate_individual_exploder() {
  if(!isDefined(self.v["angles"])) {
    self.v["angles"] = (0, 0, 0);
    self set_forward_and_up_vectors();
  }

  if(isDefined(self.v["firefx"]))
    self thread fire_effect();

  if(isDefined(self.v["fxid"]) && self.v["fxid"] != "No FX")
    self thread cannon_effect();

  if(isDefined(self.v["earthquake"]))
    self thread exploder_earthquake();
}

deactivate_exploder(num) {
  num = int(num);

  if(isDefined(level.createfxexploders[num])) {
    for(i = 0; i < level.createfxexploders[num].size; i++) {
      ent = level.createfxexploders[num][i];

      if(isDefined(ent.soundent)) {
        deletefakeent(0, ent.soundent);
        ent.soundent = undefined;
      }

      if(isDefined(ent.loopfx)) {
        for(j = 0; j < ent.loopfx.size; j++) {
          if(isDefined(ent.loopfx[j])) {
            stopfx(j, ent.loopfx[j]);
            ent.loopfx[j] = undefined;
          }
        }

        ent.loopfx = [];
      }
    }
  }
}

lightning(normalfunc, flashfunc) {
  [[flashfunc]]();
  waitrealtime(randomfloatrange(0.05, 0.1));
  [[normalfunc]]();
}

exploder_is_lightning_exploder(num) {
  if(isDefined(level.lightningexploder)) {
    for(i = 0; i < level.lightningexploder.size; i++) {
      if(level.lightningexploder[i] == num)
        return true;
    }
  }

  return false;
}

glass_exploder_watcher(num, dist, alias) {
  ents = [];

  for(i = 0; i < level.createfxent.size; i++) {
    ent = level.createfxent[i];

    if(!isDefined(ent)) {
      continue;
    }
    if(ent.v["type"] != "exploder") {
      continue;
    }
    if(!isDefined(ent.v["exploder"])) {
      continue;
    }
    if(ent.v["exploder"] != num) {
      continue;
    }
    ents[ents.size] = ent;
  }

  if(ents.size == 0) {
    return;
  }
  dist_squared = dist * dist;

  while(true) {
    level waittill("glass_smash", pos, vec);

    for(i = 0; i < ents.size; i++) {
      ds = distancesquared(pos, ents[i].v["origin"]);

      if(ds <= dist_squared) {
        exploder(num);

        if(isDefined(alias)) {
          sound_ent = spawn(0, pos, "script_origin");
          sound_ent playloopsound(alias, 0.25);
          sound_ent thread delete_window_sound_ent();
        }

        return;
      }
    }
  }
}

exploder_is_glass_exploder(num, dist, alias) {
  if(!isDefined(dist))
    dist = 24;

  level thread glass_exploder_watcher(num, dist, alias);
}

delete_window_sound_ent() {
  wait 30;
  self stoploopsound(2);
  wait 2;
  self delete();
}

activate_exploder(num) {
  num = int(num);

  if(isDefined(level.createfxexploders[num])) {
    for(i = 0; i < level.createfxexploders[num].size; i++)
      level.createfxexploders[num][i] activate_individual_exploder();
  }

  if(exploder_is_lightning_exploder(num)) {
    if(isDefined(level.lightningnormalfunc) && isDefined(level.lightningflashfunc))
      thread lightning(level.lightningnormalfunc, level.lightningflashfunc);
  }
}

exploder(num) {
  activate_exploder(num);
}

createoneshoteffect(fxid) {
  ent = createeffect("oneshotfx", fxid);
  ent.v["delay"] = -15;
  return ent;
}

createloopeffect(fxid) {
  ent = createeffect("loopfx", fxid);
  ent.v["delay"] = 0.5;
  return ent;
}

createexploder(fxid) {
  ent = createeffect("exploder", fxid);
  ent.v["delay"] = 0;
  ent.v["exploder_type"] = "normal";
  return ent;
}

set_forward_and_up_vectors() {
  self.v["up"] = anglestoup(self.v["angles"]);
  self.v["forward"] = anglestoforward(self.v["angles"]);
}

create_triggerfx(clientnum) {
  self.looperfx = playfx(clientnum, level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"], self.v["delay"], self.v["primlightfrac"], self.v["lightoriginoffs"]);
  create_loopsound(clientnum);
}

create_looper(clientnum) {
  self thread loopfx(clientnum);
  create_loopsound(clientnum);
}

loopfx(clientnum) {
  self.looperfx = playfx(clientnum, level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"], self.v["delay"], self.v["primlightfrac"], self.v["lightoriginoffs"]);

  while(true) {
    if(isDefined(self.v["delay"]))
      waitrealtime(self.v["delay"]);

    while(isfxplaying(clientnum, self.looperfx))
      wait 0.1;

    self.looperfx = playfx(clientnum, level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"], 0, self.v["primlightfrac"], self.v["lightoriginoffs"]);
  }
}

loopfxstop(clientnum, timeout) {
  self endon("death");
  waitrealtime(timeout);

  if(isDefined(self.looper))
    self.looper delete();

  if(isDefined(self.looperfx))
    deletefx(clientnum, self.looperfx);
}

loopfxthread(clientnum) {
  if(isDefined(self.fxstart))
    level waittill("start fx" + self.fxstart);

  while(true) {
    create_looper(clientnum);

    if(isDefined(self.timeout))
      thread loopfxstop(clientnum, self.timeout);

    if(isDefined(self.fxstop))
      level waittill("stop fx" + self.fxstop);
    else
      return;

    if(isDefined(self.looperfx))
      deletefx(clientnum, self.looperfx);

    if(isDefined(self.fxstart))
      level waittill("start fx" + self.fxstart);
    else
      return;
  }
}

oneshotfxthread(clientnum) {
  if(self.v["delay"] > 0)
    waitrealtime(self.v["delay"]);

  create_triggerfx(clientnum);
}

create_loopsound(clientnum) {
  if(clientnum != 0) {
    return;
  }
  self notify("stop_loop");

  if(isDefined(self.v["soundalias"]) && self.v["soundalias"] != "nil") {
    if(isDefined(self.v["stopable"]) && self.v["stopable"])
      thread clientscripts\_utility::loop_fx_sound(clientnum, self.v["soundalias"], self.v["origin"], "stop_loop");
    else
      thread clientscripts\_utility::loop_fx_sound(clientnum, self.v["soundalias"], self.v["origin"]);
  }
}

fx_init(clientnum) {
  clientscripts\_lights::init_lights(clientnum);

  if(!isDefined(level.createfx_enabled)) {
    return;
  }
  clientscripts\_destructibles::init(clientnum);

  if(clientnum == 0)
    clientscripts\_utility::init_exploders();

  if(level.createfx_enabled) {
    return;
  }
  if(!isDefined(level.createfxent)) {
    return;
  }
  for(i = 0; i < level.createfxent.size; i++) {
    ent = level.createfxent[i];

    if(!isDefined(level._createfxforwardandupset)) {
      if(!isDefined(level.needs_fixup)) {
        if(isDefined(ent.v["angles"]))
          ent set_forward_and_up_vectors();
      }
    }

    if(ent.v["type"] == "loopfx")
      ent thread loopfxthread(clientnum);

    if(ent.v["type"] == "oneshotfx")
      ent thread oneshotfxthread(clientnum);

    if(ent.v["type"] == "soundfx")
      ent thread create_loopsound(clientnum);
  }

  level._createfxforwardandupset = 1;
}

reportnumeffects() {
}

playlightloopexploder(exploderindex) {
  num = int(exploderindex);

  if(isDefined(level.createfxexploders[num])) {
    for(i = 0; i < level.createfxexploders[num].size; i++) {
      ent = level.createfxexploders[num][i];

      if(!isDefined(ent.looperfx))
        ent.looperfx = [];

      for(clientnum = 0; clientnum < level.max_local_clients; clientnum++) {
        if(localclientactive(clientnum)) {
          if(!isDefined(ent.looperfx[clientnum]))
            ent.looperfx[clientnum] = [];

          ent.looperfx[clientnum][ent.looperfx[clientnum].size] = ent playexploderfx(clientnum);
        }
      }
    }
  }
}

playexploderfx(clientnum) {
  if(!isDefined(self.v["origin"])) {
    return;
  }
  if(!isDefined(self.v["forward"])) {
    return;
  }
  if(!isDefined(self.v["up"])) {
    return;
  }
  return playfx(clientnum, level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"], 0, self.v["primlightfrac"], self.v["lightoriginoffs"]);
}

stoplightloopexploder(exploderindex) {
  num = int(exploderindex);

  if(isDefined(level.createfxexploders[num])) {
    for(i = 0; i < level.createfxexploders[num].size; i++) {
      ent = level.createfxexploders[num][i];

      if(!isDefined(ent.looperfx))
        ent.looperfx = [];

      for(clientnum = 0; clientnum < level.max_local_clients; clientnum++) {
        if(localclientactive(clientnum)) {
          if(isDefined(ent.looperfx[clientnum])) {
            for(looperfxcount = 0; looperfxcount < ent.looperfx[clientnum].size; looperfxcount++)
              deletefx(clientnum, ent.looperfx[clientnum][looperfxcount]);
          }
        }

        ent.looperfx[clientnum] = [];
      }

      ent.looperfx = [];
    }
  }
}

blinky_light(localclientnum, tagname, fx) {
  self endon("entityshutdown");
  self endon("stop_blinky_light");
  self.lighttagname = tagname;
  self thread blinky_emp_wait(localclientnum);

  while(true) {
    if(isDefined(self.stunned) && self.stunned) {
      wait 0.1;
      continue;
    }

    self.blinkylightfx = playfxontag(localclientnum, fx, self, self.lighttagname);
    wait 0.5;
  }
}

stop_blinky_light(localclientnum) {
  self notify("stop_blinky_light");

  if(!isDefined(self.blinkylightfx)) {
    return;
  }
  stopfx(localclientnum, self.blinkylightfx);
  self.blinkylightfx = undefined;
}

blinky_emp_wait(localclientnum) {
  self endon("entityshutdown");
  self endon("stop_blinky_light");
  self waittill("emp");
  self stop_blinky_light(localclientnum);
}