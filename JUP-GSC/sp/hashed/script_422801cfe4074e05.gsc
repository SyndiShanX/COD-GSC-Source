/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_422801cfe4074e05.gsc
*************************************************/

#using script_66e927a1c37cda66;
#using script_6ef052b7d38465d9;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace analytics;

function init() {
  if(false) {
    return;
  }

  flag_set("analytics");
  level.delayedeventtypes = [];

  if(true) {
    analyticsreset();
  }

  namespace_5b79e0098b7edf4d::init();
  namespace_30101e0cca498f6::init();
  level thread onendgame();
}

function function_90ab35efc8f0fb46(info, var_80ed4d4a2aaf5d44) {
  if(isdedicatedserver()) {
    setDvar(@ "hash_bd87b6ef2da571db", info);
  }

  if(istrue(var_80ed4d4a2aaf5d44)) {
    logstring("[KEY_MOMENT] " + info);
  }
}

function geteventtimestamp() {
  time = gettime();
  return time;
}

function function_b8b443d92560ecf4(type, origin, state, time, data, entnum) {
  if(!isDefined(data) || !isstring(data)) {
    data = "";
  }

  if(true) {
    analyticsaddevent(origin, type, state, time, data, entnum);
  }

  if(0 && type != "breadcrumb") {
    logstring("[GAE]," + time + "," + entnum + "," + origin[0] + "," + origin[1] + "," + type + "," + state + "," + data);
  }
}

function addevent(type, origin, state, data, ent) {
  if(!isDefined(origin)) {
    origin = (0, 0, 0);
  }

  if(!isDefined(state)) {
    state = 0;
  }

  if(!isDefined(data)) {
    data = "";
  }

  entnum = -1;

  if(isDefined(ent)) {
    entnum = ent getentitynumber();
  }

  time = geteventtimestamp();
  function_b8b443d92560ecf4(type, origin, state, time, data, entnum);

  if(isDefined(ent)) {
    ent updatebreadcrumb(time);
  }
}

function function_e18f9b7e01cd916f(type, ent) {
  if(!isDefined(ent)) {
    return;
  }

  addevent(type, ent.origin, 0, "", ent);
}

function function_a569c60476357392(type, ent, state, data) {
  if(!isDefined(ent)) {
    return;
  }

  addevent(type, ent.origin, state, data, ent);
}

function addeventdelayed(type, origin, ent, data) {
  assert(isDefined(level.delayedeventtypes));
  assert(isDefined(type));
  assert(isDefined(origin));
  assert(isDefined(ent));

  if(!isDefined(data)) {
    data = "";
  }

  if(!isDefined(level.delayedeventtypes[type])) {
    level.delayedeventtypes[type] = [];
  }

  evt = spawnStruct();
  evt.type = type;
  evt.origin = origin;
  evt.ent = ent;
  evt.data = data;
  evt.state = 0;
  evt.time = geteventtimestamp();
  evtindex = level.delayedeventtypes[type].size;
  level.delayedeventtypes[type][evtindex] = evt;
}

function seteventdelayedstate(type, ent, state) {
  if(!isDefined(type) || !isDefined(ent) || !isDefined(level.delayedeventtypes) || !isDefined(level.delayedeventtypes[type])) {
    return;
  }

  foreach(evt in level.delayedeventtypes[type]) {
    if(evt.ent == ent) {
      evt.time = geteventtimestamp();
      evt.state = state;
      return;
    }
  }
}

function onendgame() {
  level waittill("start_game_ended");

  foreach(typearray in level.delayedeventtypes) {
    foreach(ev in typearray) {
      function_b8b443d92560ecf4(ev.type, ev.origin, ev.state, ev.time, ev.data, -1);
    }
  }

  if(true) {
    analyticswritecsv();
  }
}

function function_3eb0a74e7ece96f9() {
  if(isPlayer(self)) {
    return true;
  }

  if(isagent(self)) {
    return true;
  }

  return false;
}

function function_5c0639c941555983() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  entnum = self getentitynumber();
  state = 0;
  data = "";
  nextstate = 0;
  nextdata = "";

  while(true) {
    wait 30;

    if(!isalive(self)) {
      continue;
    }

    if(isagent(self)) {
      if(isDefined(self.enemy)) {
        nextstate = self.enemy getentitynumber();
      } else {
        nextstate = 0;
      }

      if(isDefined(self.behaviorpackage)) {
        nextdata = self.behaviorpackage.behavior;
      } else {
        nextdata = "";
      }
    }

    time = geteventtimestamp();

    if(self.var_d5c444a3fbb7d030 < time - 30 || state != nextstate || data != nextdata) {
      self.var_d5c444a3fbb7d030 = time;
      state = nextstate;
      data = nextdata;
      function_b8b443d92560ecf4("breadcrumb", self.origin, state, time, data, entnum);
    }
  }
}

function updatebreadcrumb(time) {
  if(!function_3eb0a74e7ece96f9()) {
    return;
  }

  if(!isDefined(self.var_d5c444a3fbb7d030)) {
    self.var_d5c444a3fbb7d030 = time;
    thread function_5c0639c941555983();
    return;
  }

  self.var_d5c444a3fbb7d030 = time;
}