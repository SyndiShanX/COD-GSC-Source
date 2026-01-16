/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\callbacks.csc
***********************************************/

#include scripts\abilities\gadgets\gadget_vision_pulse;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\footsteps_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\vehicle_shared;
#include scripts\killstreaks\airsupport;
#include scripts\killstreaks\helicopter_shared;
#include scripts\mp_common\callbacks;
#include scripts\mp_common\vehicle;
#include scripts\weapons\acid_bomb;

#namespace callback;

autoexec __init__system__() {
  system::register(#"callback", &__init__, undefined, undefined);
}

__init__() {
  level thread set_default_callbacks();
}

set_default_callbacks() {
  level.callbackplayerspawned = &playerspawned;
  level.callbackplayerlaststand = &playerlaststand;
  level.var_beec2b1 = &function_27cbba18;
  level.callbacklocalclientconnect = &localclientconnect;
  level.callbackcreatingcorpse = &creating_corpse;
  level.callbackentityspawned = &entityspawned;
  level.var_69b47c50 = &entervehicle;
  level.var_db2ec524 = &exitvehicle;
  level.callbackairsupport = &airsupport;
  level.callbackplayaifootstep = &footsteps::playaifootstep;
  level._custom_weapon_cb_func = &spawned_weapon_type;
  level.var_6b11d5f6 = &function_cbfd8fd6;
  level.gadgetvisionpulse_reveal_func = &gadget_vision_pulse::gadget_visionpulse_reveal;
}

localclientconnect(localclientnum) {
  println("<dev string:x38>" + localclientnum);

  if(isDefined(level.charactercustomizationsetup)) {
    [[level.charactercustomizationsetup]](localclientnum);
  }

  callback(#"on_localclient_connect", localclientnum);
}

function_27cbba18(localclientnum) {
  self callback(#"hash_781399e15b138a4e", localclientnum);
}

playerlaststand(localclientnum) {
  self endon(#"death");
  callback(#"on_player_laststand", localclientnum);
}

playerspawned(localclientnum) {
  self endon(#"death");
  self notify(#"playerspawned_callback");
  self endon(#"playerspawned_callback");

  if(isDefined(level.infraredvisionset)) {
    function_8608b950(localclientnum, level.infraredvisionset);
  }

  if(isDefined(level._playerspawned_override)) {
    self thread[[level._playerspawned_override]](localclientnum);
    return;
  }

  if(self function_21c0fa55()) {
    level notify(#"localplayer_spawned");
    callback(#"on_localplayer_spawned", localclientnum);
  }

  callback(#"on_player_spawned", localclientnum);
}

entityspawned(localclientnum) {
  self endon(#"death");

  if(isplayer(self)) {
    if(isDefined(level._clientfaceanimonplayerspawned)) {
      self thread[[level._clientfaceanimonplayerspawned]](localclientnum);
    }
  }

  if(isDefined(level._entityspawned_override)) {
    self thread[[level._entityspawned_override]](localclientnum);
    return;
  }

  if(!isDefined(self.type)) {
    println("<dev string:x67>");
    return;
  }

  if(self.type == "missile") {
    if(isDefined(level._custom_weapon_cb_func)) {
      self thread[[level._custom_weapon_cb_func]](localclientnum);
    }

    if(self.weapon.name === "eq_acid_bomb") {
      self thread acid_bomb::spawned(localclientnum);
    }

    return;
  }

  if(self.type == "vehicle" || self.type == "helicopter" || self.type == "plane") {
    if(isDefined(level._customvehiclecbfunc)) {
      self thread[[level._customvehiclecbfunc]](localclientnum);
    }

    self thread vehicle::field_toggle_exhaustfx_handler(localclientnum, undefined, 0, 1);
    self thread vehicle::field_toggle_lights_handler(localclientnum, undefined, 0, 1);

    if(self.type == "plane" || self.type == "helicopter") {
      self thread vehicle::aircraft_dustkick();
    } else {
      self thread vehicle::vehicle_rumble(localclientnum);
    }

    if(self.type == "helicopter") {
      self thread helicopter::startfx_loop(localclientnum);
    }

    return;
  }

  if(self.type == "scriptmover") {
    if(isDefined(level.var_83485e06)) {
      self thread[[level.var_83485e06]](localclientnum);
    }

    return;
  }

  if(self.type == "actor") {
    if(isDefined(level._customactorcbfunc)) {
      self thread[[level._customactorcbfunc]](localclientnum);
    }

    return;
  }

  if(self.type == "NA") {
    if(isDefined(self.weapon)) {
      if(isDefined(level.var_6b11d5f6)) {
        self thread[[level.var_6b11d5f6]](localclientnum);
      }
    }
  }
}

entervehicle(localclientnum, vehicle) {
  profilestart();

  if(isDefined(level.var_e583fd9b)) {
    self thread[[level.var_e583fd9b]](localclientnum, vehicle);
  }

  profilestop();
}

exitvehicle(localclientnum, vehicle) {
  profilestart();

  if(isDefined(level.var_8e36d09b)) {
    self thread[[level.var_8e36d09b]](localclientnum, vehicle);
  }

  profilestop();
}

airsupport(localclientnum, x, y, z, type, yaw, team, teamfaction, owner, exittype, time, height) {
  pos = (x, y, z);

  switch (teamfaction) {
    case #"v":
      teamfaction = #"vietcong";
      break;
    case #"nva":
    case #"n":
      teamfaction = #"nva";
      break;
    case #"j":
      teamfaction = #"japanese";
      break;
    case #"m":
      teamfaction = #"marines";
      break;
    case #"s":
      teamfaction = #"specops";
      break;
    case #"r":
      teamfaction = #"russian";
      break;
    default:
      println("<dev string:x80>");
      println("<dev string:xbc>" + teamfaction + "<dev string:xd5>");
      teamfaction = #"marines";
      break;
  }

  switch (team) {
    case #"x":
      team = #"axis";
      break;
    case #"l":
      team = #"allies";
      break;
    case #"r":
      team = #"free";
      break;
    default:
      println("<dev string:xd9>" + team + "<dev string:xd5>");
      team = #"allies";
      break;
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
    data.startpoint = pos + vectorscale(anglesToForward(direction), -1 * planehalfdistance);
    data.endpoint = pos + vectorscale(anglesToForward(direction), planehalfdistance);
    data.planemodel = "t5_veh_air_b52";
    data.flybysound = "null";
    data.washsound = #"veh_b52_flyby_wash";
    data.apextime = 6145;
    data.exittype = -1;
    data.flyspeed = 2000;
    data.flytime = planehalfdistance * 2 / data.flyspeed;
    planetype = "airstrike";
    return;
  }

  if(type == "n") {
    planehalfdistance = 24000;
    data.planehalfdistance = planehalfdistance;
    data.startpoint = pos + vectorscale(anglesToForward(direction), -1 * planehalfdistance);
    data.endpoint = pos + vectorscale(anglesToForward(direction), planehalfdistance);
    data.planemodel = airsupport::getplanemodel(teamfaction);
    data.flybysound = "null";
    data.washsound = #"evt_us_napalm_wash";
    data.apextime = 2362;
    data.exittype = exittype;
    data.flyspeed = 7000;
    data.flytime = planehalfdistance * 2 / data.flyspeed;
    planetype = "napalm";
    return;
  }

  println("<dev string:x10e>");
  println("<dev string:x111>");
  println(type);
  println("<dev string:x10e>");

    return;
}

creating_corpse(localclientnum, player) {
  params = spawnStruct();
  params.player = player;

  if(isDefined(player)) {
    params.playername = player getplayername();
  }

  self callback(#"on_player_corpse", localclientnum, params);
}

callback_stunned(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.stunned = newval;
  println("<dev string:x15a>");

  if(newval) {
    self notify(#"stunned");
  } else {
    self notify(#"not_stunned");
  }

  if(isDefined(self.stunnedcallback)) {
    self[[self.stunnedcallback]](localclientnum, newval);
  }
}

callback_emp(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.emp = newval;
  println("<dev string:x16d>");

  if(newval) {
    self notify(#"emp");
    return;
  }

  self notify(#"not_emp");
}

callback_proximity(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.enemyinproximity = newval;
}