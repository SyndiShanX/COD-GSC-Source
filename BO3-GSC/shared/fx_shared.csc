/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\fx_shared.csc
*************************************************/

#using scripts\shared\callbacks_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\sound_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace fx;

function autoexec __init__sytem__() {
  system::register("fx", &__init__, undefined, undefined);
}

function __init__() {
  callback::on_localclient_connect(&player_init);
}

function player_init(clientnum) {
  if(!isDefined(level.createfxent)) {
    return;
  }
  creatingexploderarray = 0;
  if(!isDefined(level.createfxexploders)) {
    creatingexploderarray = 1;
    level.createfxexploders = [];
  }
  for(i = 0; i < level.createfxent.size; i++) {
    ent = level.createfxent[i];
    if(!isDefined(level._createfxforwardandupset)) {
      if(!isDefined(level._createfxforwardandupset)) {
        ent set_forward_and_up_vectors();
      }
    }
    if(ent.v["type"] == "loopfx") {
      ent thread loop_thread(clientnum);
    }
    if(ent.v["type"] == "oneshotfx") {
      ent thread oneshot_thread(clientnum);
    }
    if(ent.v["type"] == "soundfx") {
      ent thread loop_sound(clientnum);
    }
    if(creatingexploderarray && ent.v["type"] == "exploder") {
      if(!isDefined(level.createfxexploders[ent.v["exploder"]])) {
        level.createfxexploders[ent.v["exploder"]] = [];
      }
      ent.v["exploder_id"] = exploder::getexploderid(ent);
      level.createfxexploders[ent.v["exploder"]][level.createfxexploders[ent.v["exploder"]].size] = ent;
    }
  }
  level._createfxforwardandupset = 1;
}

function validate(fxid, origin) {
  if(!isDefined(level._effect[fxid])) {
    assertmsg((("" + fxid) + "") + origin);
  }
}

function create_loop_sound() {
  ent = spawnStruct();
  if(!isDefined(level.createfxent)) {
    level.createfxent = [];
  }
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

function create_effect(type, fxid) {
  ent = spawnStruct();
  if(!isDefined(level.createfxent)) {
    level.createfxent = [];
  }
  level.createfxent[level.createfxent.size] = ent;
  ent.v = [];
  ent.v["type"] = type;
  ent.v["fxid"] = fxid;
  ent.v["angles"] = (0, 0, 0);
  ent.v["origin"] = (0, 0, 0);
  ent.drawn = 1;
  return ent;
}

function create_oneshot_effect(fxid) {
  ent = create_effect("oneshotfx", fxid);
  ent.v["delay"] = -15;
  return ent;
}

function create_loop_effect(fxid) {
  ent = create_effect("loopfx", fxid);
  ent.v["delay"] = 0.5;
  return ent;
}

function set_forward_and_up_vectors() {
  self.v["up"] = anglestoup(self.v["angles"]);
  self.v["forward"] = anglesToForward(self.v["angles"]);
}

function oneshot_thread(clientnum) {
  if(self.v["delay"] > 0) {
    waitrealtime(self.v["delay"]);
  }
  create_trigger(clientnum);
}

function report_num_effects() {}

function loop_sound(clientnum) {
  if(clientnum != 0) {
    return;
  }
  self notify("stop_loop");
  if(isDefined(self.v["soundalias"]) && self.v["soundalias"] != "nil") {
    if(isDefined(self.v["stopable"]) && self.v["stopable"]) {
      thread sound::loop_fx_sound(clientnum, self.v["soundalias"], self.v["origin"], "stop_loop");
    } else {
      thread sound::loop_fx_sound(clientnum, self.v["soundalias"], self.v["origin"]);
    }
  }
}

function lightning(normalfunc, flashfunc) {
  [[flashfunc]]();
  waitrealtime(randomfloatrange(0.05, 0.1));
  [[normalfunc]]();
}

function loop_thread(clientnum) {
  if(isDefined(self.fxstart)) {
    level waittill("start fx" + self.fxstart);
  }
  while(true) {
    create_looper(clientnum);
    if(isDefined(self.timeout)) {
      thread loop_stop(clientnum, self.timeout);
    }
    if(isDefined(self.fxstop)) {
      level waittill("stop fx" + self.fxstop);
    } else {
      return;
    }
    if(isDefined(self.looperfx)) {
      deletefx(clientnum, self.looperfx);
    }
    if(isDefined(self.fxstart)) {
      level waittill("start fx" + self.fxstart);
    } else {
      return;
    }
  }
}

function loop_stop(clientnum, timeout) {
  self endon("death");
  wait(timeout);
  if(isDefined(self.looper)) {
    deletefx(clientnum, self.looper);
  }
}

function create_looper(clientnum) {
  self thread loop(clientnum);
  loop_sound(clientnum);
}

function loop(clientnum) {
  validate(self.v["fxid"], self.v["origin"]);
  self.looperfx = playFX(clientnum, level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"], self.v["delay"], self.v["primlightfrac"], self.v["lightoriginoffs"]);
  while(true) {
    if(isDefined(self.v["delay"])) {
      waitrealtime(self.v["delay"]);
    }
    while(isfxplaying(clientnum, self.looperfx)) {
      wait(0.25);
    }
    self.looperfx = playFX(clientnum, level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"], 0, self.v["primlightfrac"], self.v["lightoriginoffs"]);
  }
}

function create_trigger(clientnum) {
  validate(self.v["fxid"], self.v["origin"]);
  if(getdvarint("") > 0) {
    println("" + self.v[""]);
  }
  self.looperfx = playFX(clientnum, level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"], self.v["delay"], self.v["primlightfrac"], self.v["lightoriginoffs"]);
  loop_sound(clientnum);
}

function blinky_light(localclientnum, tagname, friendlyfx, enemyfx) {
  self endon("entityshutdown");
  self endon("stop_blinky_light");
  self.lighttagname = tagname;
  self util::waittill_dobj(localclientnum);
  self thread blinky_emp_wait(localclientnum);
  while(true) {
    if(isDefined(self.stunned) && self.stunned) {
      wait(0.1);
      continue;
    }
    if(isDefined(self)) {
      if(util::friend_not_foe(localclientnum)) {
        self.blinkylightfx = playFXOnTag(localclientnum, friendlyfx, self, self.lighttagname);
      } else {
        self.blinkylightfx = playFXOnTag(localclientnum, enemyfx, self, self.lighttagname);
      }
    }
    util::server_wait(localclientnum, 0.5, 0.016);
  }
}

function stop_blinky_light(localclientnum) {
  self notify("stop_blinky_light");
  if(!isDefined(self.blinkylightfx)) {
    return;
  }
  stopfx(localclientnum, self.blinkylightfx);
  self.blinkylightfx = undefined;
}

function blinky_emp_wait(localclientnum) {
  self endon("entityshutdown");
  self endon("stop_blinky_light");
  self waittill("emp");
  self stop_blinky_light(localclientnum);
}