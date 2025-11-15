/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\exploder_shared.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\sound_shared;
#using scripts\shared\system_shared;
#namespace exploder;

function autoexec __init__sytem__() {
  system::register("exploder", & __init__, undefined, undefined);
}

function __init__() {
  if(sessionmodeiscampaigngame()) {
    callback::on_localclient_connect( & player_init);
  }
}

function player_init(clientnum) {
  script_exploders = [];
  ents = struct::get_array("script_brushmodel", "classname");
  smodels = struct::get_array("script_model", "classname");
  for(i = 0; i < smodels.size; i++) {
    ents[ents.size] = smodels[i];
  }
  for(i = 0; i < ents.size; i++) {
    if(isDefined(ents[i].script_prefab_exploder)) {
      ents[i].script_exploder = ents[i].script_prefab_exploder;
    }
  }
  potentialexploders = struct::get_array("script_brushmodel", "classname");
  for(i = 0; i < potentialexploders.size; i++) {
    if(isDefined(potentialexploders[i].script_prefab_exploder)) {
      potentialexploders[i].script_exploder = potentialexploders[i].script_prefab_exploder;
    }
    if(isDefined(potentialexploders[i].script_exploder)) {
      script_exploders[script_exploders.size] = potentialexploders[i];
    }
  }
  potentialexploders = struct::get_array("script_model", "classname");
  for(i = 0; i < potentialexploders.size; i++) {
    if(isDefined(potentialexploders[i].script_prefab_exploder)) {
      potentialexploders[i].script_exploder = potentialexploders[i].script_prefab_exploder;
    }
    if(isDefined(potentialexploders[i].script_exploder)) {
      script_exploders[script_exploders.size] = potentialexploders[i];
    }
  }
  for(i = 0; i < level.struct.size; i++) {
    if(isDefined(level.struct[i].script_prefab_exploder)) {
      level.struct[i].script_exploder = level.struct[i].script_prefab_exploder;
    }
    if(isDefined(level.struct[i].script_exploder)) {
      script_exploders[script_exploders.size] = level.struct[i];
    }
  }
  if(!isDefined(level.createfxent)) {
    level.createfxent = [];
  }
  acceptabletargetnames = [];
  acceptabletargetnames["exploderchunk visible"] = 1;
  acceptabletargetnames["exploderchunk"] = 1;
  acceptabletargetnames["exploder"] = 1;
  exploder_id = 1;
  for(i = 0; i < script_exploders.size; i++) {
    exploder = script_exploders[i];
    ent = createexploder(exploder.script_fxid);
    ent.v = [];
    ent.v["origin"] = exploder.origin;
    ent.v["angles"] = exploder.angles;
    ent.v["delay"] = exploder.script_delay;
    ent.v["firefx"] = exploder.script_firefx;
    ent.v["firefxdelay"] = exploder.script_firefxdelay;
    ent.v["firefxsound"] = exploder.script_firefxsound;
    ent.v["firefxtimeout"] = exploder.script_firefxtimeout;
    ent.v["trailfx"] = exploder.script_trailfx;
    ent.v["trailfxtag"] = exploder.script_trailfxtag;
    ent.v["trailfxdelay"] = exploder.script_trailfxdelay;
    ent.v["trailfxsound"] = exploder.script_trailfxsound;
    ent.v["trailfxtimeout"] = exploder.script_firefxtimeout;
    ent.v["earthquake"] = exploder.script_earthquake;
    ent.v["rumble"] = exploder.script_rumble;
    ent.v["damage"] = exploder.script_damage;
    ent.v["damage_radius"] = exploder.script_radius;
    ent.v["repeat"] = exploder.script_repeat;
    ent.v["delay_min"] = exploder.script_delay_min;
    ent.v["delay_max"] = exploder.script_delay_max;
    ent.v["target"] = exploder.target;
    ent.v["ender"] = exploder.script_ender;
    ent.v["physics"] = exploder.script_physics;
    ent.v["type"] = "exploder";
    if(!isDefined(exploder.script_fxid)) {
      ent.v["fxid"] = "No FX";
    } else {
      ent.v["fxid"] = exploder.script_fxid;
    }
    ent.v["exploder"] = exploder.script_exploder;
    if(!isDefined(ent.v["delay"])) {
      ent.v["delay"] = 0;
    }
    if(isDefined(exploder.script_sound)) {
      ent.v["soundalias"] = exploder.script_sound;
    } else if(ent.v["fxid"] != "No FX") {
      if(isDefined(level.scr_sound) && isDefined(level.scr_sound[ent.v["fxid"]])) {
        ent.v["soundalias"] = level.scr_sound[ent.v["fxid"]];
      }
    }
    fixup_set = 0;
    if(isDefined(ent.v["target"])) {
      ent.needs_fixup = exploder_id;
      exploder_id++;
      fixup_set = 1;
      temp_ent = struct::get(ent.v["target"], "targetname");
      if(isDefined(temp_ent)) {
        org = temp_ent.origin;
      }
      if(isDefined(org)) {
        ent.v["angles"] = vectortoangles(org - ent.v["origin"]);
      }
      if(isDefined(ent.v["angles"])) {
        ent fx::set_forward_and_up_vectors();
      }
    }
    if(isDefined(exploder.classname) && exploder.classname == "script_brushmodel" || isDefined(exploder.model)) {
      ent.model = exploder;
      if(fixup_set == 0) {
        ent.needs_fixup = exploder_id;
        exploder_id++;
      }
    }
    if(isDefined(exploder.targetname) && isDefined(acceptabletargetnames[exploder.targetname])) {
      ent.v["exploder_type"] = exploder.targetname;
      continue;
    }
    ent.v["exploder_type"] = "normal";
  }
  level.createfxexploders = [];
  for(i = 0; i < level.createfxent.size; i++) {
    ent = level.createfxent[i];
    if(ent.v["type"] != "exploder") {
      continue;
    }
    ent.v["exploder_id"] = getexploderid(ent);
    if(!isDefined(level.createfxexploders[ent.v["exploder"]])) {
      level.createfxexploders[ent.v["exploder"]] = [];
    }
    level.createfxexploders[ent.v["exploder"]][level.createfxexploders[ent.v["exploder"]].size] = ent;
  }
  reportexploderids();
}

function getexploderid(ent) {
  if(!isDefined(level._exploder_ids)) {
    level._exploder_ids = [];
    level._exploder_id = 1;
  }
  if(!isDefined(level._exploder_ids[ent.v["exploder"]])) {
    level._exploder_ids[ent.v["exploder"]] = level._exploder_id;
    level._exploder_id++;
  }
  return level._exploder_ids[ent.v["exploder"]];
}

function reportexploderids() {
  if(!isDefined(level._exploder_ids)) {
    return;
  }
  keys = getarraykeys(level._exploder_ids);
}

function exploder(exploder_id, n_localclientnumber) {
  if(isint(exploder_id)) {
    activate_exploder(exploder_id);
  } else {
    activate_radiant_exploder(exploder_id, n_localclientnumber);
  }
}

function activate_exploder(num) {
  num = int(num);
  if(isDefined(level.createfxexploders) && isDefined(level.createfxexploders[num])) {
    for(i = 0; i < level.createfxexploders[num].size; i++) {
      level.createfxexploders[num][i] activate_individual_exploder();
    }
  }
  if(exploder_is_lightning_exploder(num)) {
    if(isDefined(level.lightningnormalfunc) && isDefined(level.lightningflashfunc)) {
      thread fx::lightning(level.lightningnormalfunc, level.lightningflashfunc);
    }
  }
}

function activate_individual_exploder() {
  if(!isDefined(self.v["angles"])) {
    self.v["angles"] = (0, 0, 0);
    self fx::set_forward_and_up_vectors();
  }
  if(isDefined(self.v["firefx"])) {
    self thread fire_effect();
  }
  if(isDefined(self.v["fxid"]) && self.v["fxid"] != "No FX") {
    self thread cannon_effect();
  }
  if(isDefined(self.v["earthquake"])) {
    self thread exploder_earthquake();
  }
}

function activate_radiant_exploder(string, n_localclientnumber) {
  if(isDefined(n_localclientnumber)) {
    playradiantexploder(n_localclientnumber, string);
  } else {
    for(localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
      playradiantexploder(localclientnum, string);
    }
  }
}

function stop_exploder(exploder_id, n_localclientnumber) {
  if(isstring(exploder_id)) {
    if(isDefined(n_localclientnumber)) {
      stopradiantexploder(n_localclientnumber, exploder_id);
    } else {
      for(localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
        stopradiantexploder(localclientnum, exploder_id);
      }
    }
    return;
  }
  num = int(exploder_id);
  if(isDefined(level.createfxexploders[exploder_id])) {
    for(i = 0; i < level.createfxexploders[exploder_id].size; i++) {
      ent = level.createfxexploders[exploder_id][i];
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

function kill_exploder(exploder_id) {
  if(isstring(exploder_id)) {
    for(localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
      killradiantexploder(localclientnum, exploder_id);
    }
    return;
  }
  assertmsg("" + exploder_id);
}

function exploder_delay() {
  if(!isDefined(self.v["delay"])) {
    self.v["delay"] = 0;
  }
  min_delay = self.v["delay"];
  max_delay = self.v["delay"] + 0.001;
  if(isDefined(self.v["delay_min"])) {
    min_delay = self.v["delay_min"];
  }
  if(isDefined(self.v["delay_max"])) {
    max_delay = self.v["delay_max"];
  }
  if(min_delay > 0) {
    waitrealtime(randomfloatrange(min_delay, max_delay));
  }
}

function exploder_playSound() {
  if(!isDefined(self.v["soundalias"]) || self.v["soundalias"] == "nil") {
    return;
  }
  sound::play_in_space(0, self.v["soundalias"], self.v["origin"]);
}

function exploder_earthquake() {
  self exploder_delay();
  eq = level.earthquake[self.v["earthquake"]];
  if(isDefined(eq)) {
    getlocalplayers()[0] earthquake(eq["magnitude"], eq["duration"], self.v["origin"], eq["radius"]);
  }
}

function exploder_is_lightning_exploder(num) {
  if(isDefined(level.lightningexploder)) {
    for(i = 0; i < level.lightningexploder.size; i++) {
      if(level.lightningexploder[i] == num) {
        return true;
      }
    }
  }
  return false;
}

function stoplightloopexploder(exploderindex) {
  num = int(exploderindex);
  if(isDefined(level.createfxexploders[num])) {
    for(i = 0; i < level.createfxexploders[num].size; i++) {
      ent = level.createfxexploders[num][i];
      if(!isDefined(ent.looperfx)) {
        ent.looperfx = [];
      }
      for(clientnum = 0; clientnum < level.max_local_clients; clientnum++) {
        if(localclientactive(clientnum)) {
          if(isDefined(ent.looperfx[clientnum])) {
            for(looperfxcount = 0; looperfxcount < ent.looperfx[clientnum].size; looperfxcount++) {
              deletefx(clientnum, ent.looperfx[clientnum][looperfxcount]);
            }
          }
        }
        ent.looperfx[clientnum] = [];
      }
      ent.looperfx = [];
    }
  }
}

function playlightloopexploder(exploderindex) {
  num = int(exploderindex);
  if(isDefined(level.createfxexploders[num])) {
    for(i = 0; i < level.createfxexploders[num].size; i++) {
      ent = level.createfxexploders[num][i];
      if(!isDefined(ent.looperfx)) {
        ent.looperfx = [];
      }
      for(clientnum = 0; clientnum < level.max_local_clients; clientnum++) {
        if(localclientactive(clientnum)) {
          if(!isDefined(ent.looperfx[clientnum])) {
            ent.looperfx[clientnum] = [];
          }
          ent.looperfx[clientnum][ent.looperfx[clientnum].size] = ent playexploderfx(clientnum);
        }
      }
    }
  }
}

function createexploder(fxid) {
  ent = fx::create_effect("exploder", fxid);
  ent.v["delay"] = 0;
  ent.v["exploder_type"] = "normal";
  return ent;
}

function cannon_effect() {
  if(isDefined(self.v["repeat"])) {
    for(i = 0; i < self.v["repeat"]; i++) {
      players = getlocalplayers();
      for(player = 0; player < players.size; player++) {
        playFX(player, level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);
      }
      self exploder_delay();
    }
    return;
  }
  self exploder_delay();
  players = getlocalplayers();
  if(isDefined(self.loopfx)) {
    for(i = 0; i < self.loopfx.size; i++) {
      stopfx(i, self.loopfx[i]);
    }
    self.loopfx = [];
  }
  if(!isDefined(self.loopfx)) {
    self.loopfx = [];
  }
  if(!isDefined(level._effect[self.v["fxid"]])) {
    assertmsg(("" + self.v[""]) + "");
    return;
  }
  for(i = 0; i < players.size; i++) {
    if(isDefined(self.v["fxid"])) {
      self.loopfx[i] = playFX(i, level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);
    }
  }
  self exploder_playSound();
}

function fire_effect() {
  forward = self.v["forward"];
  if(!isDefined(forward)) {
    forward = anglesToForward(self.v["angles"]);
  }
  up = self.v["up"];
  if(!isDefined(up)) {
    up = anglestoup(self.v["angles"]);
  }
  firefxsound = self.v["firefxsound"];
  origin = self.v["origin"];
  firefx = self.v["firefx"];
  ender = self.v["ender"];
  if(!isDefined(ender)) {
    ender = "createfx_effectStopper";
  }
  firefxdelay = 0.5;
  if(isDefined(self.v["firefxdelay"])) {
    firefxdelay = self.v["firefxdelay"];
  }
  self exploder_delay();
  players = getlocalplayers();
  for(i = 0; i < players.size; i++) {
    if(isDefined(firefxsound)) {
      level thread sound::loop_fx_sound(i, firefxsound, origin, ender);
    }
    playFX(i, level._effect[firefx], self.v["origin"], forward, up, 0, self.v["primlightfrac"], self.v["lightoriginoffs"]);
  }
}

function playexploderfx(clientnum) {
  if(!isDefined(self.v[""])) {
    return;
  }
  if(!isDefined(self.v[""])) {
    return;
  }
  if(!isDefined(self.v[""])) {
    return;
  }
  return playFX(clientnum, level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"], 0, self.v["primlightfrac"], self.v["lightoriginoffs"]);
}

function stop_after_duration(name, duration) {
  wait(duration);
  stop_exploder(name);
}

function exploder_duration(name, duration) {
  if(!(isDefined(duration) && duration)) {
    return;
  }
  exploder(name);
  level thread stop_after_duration(name, duration);
}