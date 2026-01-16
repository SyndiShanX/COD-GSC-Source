/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\fx_shared.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\sound_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace fx;

autoexec __init__system__() {
  system::register(#"fx", &__init__, undefined, undefined);
}

__init__() {
  callback::on_localclient_connect(&player_init);
}

player_init(clientnum) {
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

    if(ent.v[#"type"] == "loopfx") {
      ent thread loop_thread(clientnum);
    }

    if(ent.v[#"type"] == "oneshotfx") {
      ent thread oneshot_thread(clientnum);
    }

    if(ent.v[#"type"] == "soundfx") {
      ent thread loop_sound(clientnum);
    }

    if(creatingexploderarray && ent.v[#"type"] == "exploder") {
      if(!isDefined(level.createfxexploders[ent.v[#"exploder"]])) {
        level.createfxexploders[ent.v[#"exploder"]] = [];
      }

      ent.v[#"exploder_id"] = exploder::getexploderid(ent);
      level.createfxexploders[ent.v[#"exploder"]][level.createfxexploders[ent.v[#"exploder"]].size] = ent;
    }
  }

  level._createfxforwardandupset = 1;
}

validate(fxid, origin) {
  if(!isDefined(level._effect[fxid])) {
    assertmsg("<dev string:x38>" + fxid + "<dev string:x4e>" + origin);
  }

}

create_loop_sound() {
  ent = spawnStruct();

  if(!isDefined(level.createfxent)) {
    level.createfxent = [];
  }

  level.createfxent[level.createfxent.size] = ent;
  ent.v = [];
  ent.v[#"type"] = "soundfx";
  ent.v[#"fxid"] = "No FX";
  ent.v[#"soundalias"] = "nil";
  ent.v[#"angles"] = (0, 0, 0);
  ent.v[#"origin"] = (0, 0, 0);
  ent.drawn = 1;
  return ent;
}

create_effect(type, fxid) {
  ent = spawnStruct();

  if(!isDefined(level.createfxent)) {
    level.createfxent = [];
  }

  level.createfxent[level.createfxent.size] = ent;
  ent.v = [];
  ent.v[#"type"] = type;
  ent.v[#"fxid"] = fxid;
  ent.v[#"angles"] = (0, 0, 0);
  ent.v[#"origin"] = (0, 0, 0);
  ent.drawn = 1;
  return ent;
}

create_oneshot_effect(fxid) {
  ent = create_effect("oneshotfx", fxid);
  ent.v[#"delay"] = -15;
  return ent;
}

create_loop_effect(fxid) {
  ent = create_effect("loopfx", fxid);
  ent.v[#"delay"] = 0.5;
  return ent;
}

set_forward_and_up_vectors() {
  self.v[#"up"] = anglestoup(self.v[#"angles"]);
  self.v[#"forward"] = anglesToForward(self.v[#"angles"]);
}

oneshot_thread(clientnum) {
  if(self.v[#"delay"] > 0) {
    wait self.v[#"delay"];
  }

  create_trigger(clientnum);
}

report_num_effects() {}

loop_sound(clientnum) {
  if(clientnum != 0) {
    return;
  }

  self notify(#"stop_loop");

  if(isDefined(self.v[#"soundalias"]) && self.v[#"soundalias"] != "nil") {
    if(isDefined(self.v[#"stopable"]) && self.v[#"stopable"]) {
      thread sound::loop_fx_sound(clientnum, self.v[#"soundalias"], self.v[#"origin"], "stop_loop");
      return;
    }

    thread sound::loop_fx_sound(clientnum, self.v[#"soundalias"], self.v[#"origin"]);
  }
}

lightning(normalfunc, flashfunc) {
  [[flashfunc]]();
  wait randomfloatrange(0.05, 0.1);
  [[normalfunc]]();
}

loop_thread(clientnum) {
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
      continue;
    }

    return;
  }
}

loop_stop(clientnum, timeout) {
  self endon(#"death");
  wait timeout;

  if(isDefined(self.looper)) {
    deletefx(clientnum, self.looper);
  }
}

create_looper(clientnum) {
  self thread loop(clientnum);
  loop_sound(clientnum);
}

loop(clientnum) {
  validate(self.v[#"fxid"], self.v[#"origin"]);
  self.looperfx = playFX(clientnum, level._effect[self.v[#"fxid"]], self.v[#"origin"], self.v[#"forward"], self.v[#"up"], self.v[#"delay"], self.v[#"primlightfrac"], self.v[#"lightoriginoffs"]);

  while(true) {
    if(isDefined(self.v[#"delay"])) {
      wait self.v[#"delay"];
    }

    while(isfxplaying(clientnum, self.looperfx)) {
      wait 0.25;
    }

    self.looperfx = playFX(clientnum, level._effect[self.v[#"fxid"]], self.v[#"origin"], self.v[#"forward"], self.v[#"up"], 0, self.v[#"primlightfrac"], self.v[#"lightoriginoffs"]);
  }
}

create_trigger(clientnum) {
  validate(self.v[#"fxid"], self.v[#"origin"]);

  if(getdvarint(#"debug_fx", 0) > 0) {
    println("<dev string:x57>" + self.v[#"fxid"]);
  }

  self.looperfx = playFX(clientnum, level._effect[self.v[#"fxid"]], self.v[#"origin"], self.v[#"forward"], self.v[#"up"], self.v[#"delay"], self.v[#"primlightfrac"], self.v[#"lightoriginoffs"]);
  loop_sound(clientnum);
}

function_3539a829(local_client_num, friendly_fx, enemy_fx, tag) {
  if(self function_4e0ca360()) {
    return util::playFXOnTag(local_client_num, friendly_fx, self, tag);
  }

  return util::playFXOnTag(local_client_num, enemy_fx, self, tag);
}

function_94d3d1d(local_client_num, friendly_fx, enemy_fx, origin) {
  if(self function_4e0ca360()) {
    return playFX(local_client_num, friendly_fx, origin);
  }

  return playFX(local_client_num, enemy_fx, origin);
}

blinky_light(localclientnum, tagname, friendlyfx, enemyfx) {
  self endon(#"death");
  self endon(#"stop_blinky_light");
  self.lighttagname = tagname;
  self util::waittill_dobj(localclientnum);
  self thread blinky_emp_wait(localclientnum);

  while(true) {
    if(isDefined(self.stunned) && self.stunned) {
      wait 0.1;
      continue;
    }

    if(isDefined(self)) {
      self function_3539a829(localclientnum, friendlyfx, enemyfx, self.lighttagname);
    }

    util::server_wait(localclientnum, 0.5, 0.016);
  }
}

stop_blinky_light(localclientnum) {
  self notify(#"stop_blinky_light");

  if(!isDefined(self.blinkylightfx)) {
    return;
  }

  stopfx(localclientnum, self.blinkylightfx);
  self.blinkylightfx = undefined;
}

blinky_emp_wait(localclientnum) {
  self endon(#"death");
  self endon(#"stop_blinky_light");
  self waittill(#"emp");
  self stop_blinky_light(localclientnum);
}