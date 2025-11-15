/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_callbacks.csc
*************************************************/

#using scripts\mp\_callbacks;
#using scripts\mp\_util;
#using scripts\mp\_vehicle;
#using scripts\mp\gametypes\_globallogic;
#using scripts\mp\gametypes\_globallogic_actor;
#using scripts\mp\killstreaks\_ai_tank;
#using scripts\mp\killstreaks\_airsupport;
#using scripts\mp\killstreaks\_helicopter;
#using scripts\mp\killstreaks\_qrdrone;
#using scripts\mp\killstreaks\_rcbomb;
#using scripts\shared\_burnplayer;
#using scripts\shared\abilities\gadgets\_gadget_vision_pulse;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\filter_shared;
#using scripts\shared\footsteps_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\vehicles\_driving_fx;
#using scripts\shared\weapons\_sticky_grenade;
#namespace callback;

function autoexec __init__sytem__() {
  system::register("callback", & __init__, undefined, undefined);
}

function __init__() {
  level thread set_default_callbacks();
}

function set_default_callbacks() {
  level.callbackplayerspawned = & playerspawned;
  level.callbacklocalclientconnect = & localclientconnect;
  level.callbackcreatingcorpse = & creating_corpse;
  level.callbackentityspawned = & entityspawned;
  level.callbackairsupport = & airsupport;
  level.callbackplayaifootstep = & footsteps::playaifootstep;
  level.callbackplaylightloopexploder = & exploder::playlightloopexploder;
  level._custom_weapon_cb_func = & spawned_weapon_type;
  level.gadgetvisionpulse_reveal_func = & gadget_vision_pulse::gadget_visionpulse_reveal;
}

function localclientconnect(localclientnum) {
  println("" + localclientnum);
  if(isDefined(level.charactercustomizationsetup)) {
    [[level.charactercustomizationsetup]](localclientnum);
  }
  callback("hash_da8d7d74", localclientnum);
}

function playerspawned(localclientnum) {
  self endon("entityshutdown");
  self notify("playerspawned_callback");
  self endon("playerspawned_callback");
  player = getlocalplayer(localclientnum);
  if(isDefined(level.infraredvisionset)) {
    player setinfraredvisionset(level.infraredvisionset);
  }
  if(isDefined(level._playerspawned_override)) {
    self thread[[level._playerspawned_override]](localclientnum);
    return;
  }
  println("");
  if(self islocalplayer()) {
    callback("hash_842e788a", localclientnum);
  }
  callback("hash_bc12b61f", localclientnum);
}

function entityspawned(localclientnum) {
  self endon("entityshutdown");
  if(self isplayer()) {
    if(isDefined(level._clientfaceanimonplayerspawned)) {
      self thread[[level._clientfaceanimonplayerspawned]](localclientnum);
    }
  }
  if(isDefined(level._entityspawned_override)) {
    self thread[[level._entityspawned_override]](localclientnum);
    return;
  }
  if(!isDefined(self.type)) {
    println("");
    return;
  }
  if(self.type == "missile") {
    if(isDefined(level._custom_weapon_cb_func)) {
      self thread[[level._custom_weapon_cb_func]](localclientnum);
    }
  } else if(self.type == "vehicle" || self.type == "helicopter" || self.type == "plane") {
    if(isDefined(level._customvehiclecbfunc)) {
      self thread[[level._customvehiclecbfunc]](localclientnum);
    }
    self thread vehicle::field_toggle_exhaustfx_handler(localclientnum, undefined, 0, 1);
    self thread vehicle::field_toggle_lights_handler(localclientnum, undefined, 0, 1);
    if(self.type == "plane" || self.type == "helicopter") {
      self thread vehicle::aircraft_dustkick();
    } else {
      self thread driving_fx::play_driving_fx(localclientnum);
      self thread vehicle::vehicle_rumble(localclientnum);
    }
    if(self.type == "helicopter") {
      self thread helicopter::startfx_loop(localclientnum);
    }
  }
  if(self.type == "actor") {
    if(isDefined(level._customactorcbfunc)) {
      self thread[[level._customactorcbfunc]](localclientnum);
    }
  }
}

function airsupport(localclientnum, x, y, z, type, yaw, team, teamfaction, owner, exittype, time, height) {
  pos = (x, y, z);
  switch (teamfaction) {
    case "v": {
      teamfaction = "vietcong";
      break;
    }
    case "n":
    case "nva": {
      teamfaction = "nva";
      break;
    }
    case "j": {
      teamfaction = "japanese";
      break;
    }
    case "m": {
      teamfaction = "marines";
      break;
    }
    case "s": {
      teamfaction = "specops";
      break;
    }
    case "r": {
      teamfaction = "russian";
      break;
    }
    default: {
      println("");
      println(("" + teamfaction) + "");
      teamfaction = "marines";
      break;
    }
  }
  switch (team) {
    case "x": {
      team = "axis";
      break;
    }
    case "l": {
      team = "allies";
      break;
    }
    case "r": {
      team = "free";
      break;
    }
    default: {
      println(("" + team) + "");
      team = "allies";
      break;
    }
  }
  data = spawnStruct();
  data.team = team;
  data.owner = owner;
  data.bombsite = pos;
  data.yaw = yaw;
  direction = (0, yaw, 0);
  data.direction = direction;
  data.flyheight = height;
  if(type == "a") {
    planehalfdistance = 12000;
    data.planehalfdistance = planehalfdistance;
    data.startpoint = pos + (vectorscale(anglesToForward(direction), -1 * planehalfdistance));
    data.endpoint = pos + vectorscale(anglesToForward(direction), planehalfdistance);
    data.planemodel = "t5_veh_air_b52";
    data.flybysound = "null";
    data.washsound = "veh_b52_flyby_wash";
    data.apextime = 6145;
    data.exittype = -1;
    data.flyspeed = 2000;
    data.flytime = (planehalfdistance * 2) / data.flyspeed;
    planetype = "airstrike";
  } else {
    if(type == "n") {
      planehalfdistance = 24000;
      data.planehalfdistance = planehalfdistance;
      data.startpoint = pos + (vectorscale(anglesToForward(direction), -1 * planehalfdistance));
      data.endpoint = pos + vectorscale(anglesToForward(direction), planehalfdistance);
      data.planemodel = airsupport::getplanemodel(teamfaction);
      data.flybysound = "null";
      data.washsound = "evt_us_napalm_wash";
      data.apextime = 2362;
      data.exittype = exittype;
      data.flyspeed = 7000;
      data.flytime = (planehalfdistance * 2) / data.flyspeed;
      planetype = "napalm";
    } else {
      println("");
      println("");
      println(type);
      println("");
      return;
    }
  }
}

function creating_corpse(localclientnum, player) {}

function callback_stunned(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.stunned = newval;
  println("");
  if(newval) {
    self notify("stunned");
  } else {
    self notify("not_stunned");
  }
}

function callback_emp(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.emp = newval;
  println("");
  if(newval) {
    self notify("emp");
  } else {
    self notify("not_emp");
  }
}

function callback_proximity(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.enemyinproximity = newval;
}