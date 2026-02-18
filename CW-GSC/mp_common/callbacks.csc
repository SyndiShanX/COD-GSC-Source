/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\callbacks.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\footsteps_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\airsupport;
#using scripts\killstreaks\helicopter_shared;
#using scripts\mp_common\callbacks;
#using scripts\mp_common\vehicle;
#namespace callback;

function private autoexec __init__system__() {
  system::register(#"callback", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level thread set_default_callbacks();
}

function set_default_callbacks() {
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
}

function localclientconnect(localclientnum) {
  println("<dev string:x38>" + localclientnum);

  if(isDefined(level.charactercustomizationsetup)) {
    [[level.charactercustomizationsetup]](localclientnum);
  }

  callback(#"on_localclient_connect", localclientnum);
}

function function_27cbba18(localclientnum) {
  self callback(#"hash_781399e15b138a4e", localclientnum);
}

function playerlaststand(localclientnum) {
  self endon(#"death");
  callback(#"on_player_laststand", localclientnum);
}

function playerspawned(localclientnum) {
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

function entityspawned(localclientnum) {
  self endon(#"death");

  if(isPlayer(self)) {
    if(isDefined(level._clientfaceanimonplayerspawned)) {
      self thread[[level._clientfaceanimonplayerspawned]](localclientnum);
    }
  }

  if(isDefined(level._entityspawned_override)) {
    self thread[[level._entityspawned_override]](localclientnum);
    return;
  }

  if(!isDefined(self.type)) {
    println("<dev string:x68>");
    return;
  }

  if(self.type == "missile") {
    if(isDefined(level._custom_weapon_cb_func)) {
      self thread[[level._custom_weapon_cb_func]](localclientnum);
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
    }

    return;
  }

  if(self.type == "scriptmover") {
    if(isDefined(level.var_83485e06)) {
      self thread[[level.var_83485e06]](localclientnum);
    }

    if(isDefined(self.weapon)) {
      if(isDefined(level.var_6b11d5f6)) {
        self thread[[level.var_6b11d5f6]](localclientnum);
      }
    }

    return;
  }

  if(self.type == "script_model") {
    if(isDefined(self.weapon)) {
      if(isDefined(level.var_6b11d5f6)) {
        self thread[[level.var_6b11d5f6]](localclientnum);
      }
    }

    return;
  }

  if(self.type == "actor") {
    if(isDefined(level._customactorcbfunc)) {
      self thread[[level._customactorcbfunc]](localclientnum);
    }

    self callback(#"hash_1fc6e31d0d02aa3", localclientnum);
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

function entervehicle(localclientnum, vehicle) {
  profilestart();

  if(isDefined(level.var_e583fd9b)) {
    self thread[[level.var_e583fd9b]](localclientnum, vehicle);
  }

  profilestop();
}

function exitvehicle(localclientnum, vehicle) {
  profilestart();

  if(isDefined(level.var_8e36d09b)) {
    self thread[[level.var_8e36d09b]](localclientnum, vehicle);
  }

  profilestop();
}

function airsupport(localclientnum, x, y, z, type, yaw, team, teamfaction, owner, exittype, time, height) {
  pos = (y, z, type);

  switch (owner) {
    case # "v":
      owner = # "vietcong";
      break;
    case # "nva":
    case # "n":
      owner = # "nva";
      break;
    case # "j":
      owner = # "japanese";
      break;
    case # "m":
      owner = # "marines";
      break;
    case # "s":
      owner = # "specops";
      break;
    case # "r":
      owner = # "russian";
      break;
    default:
      println("<dev string:x82>");
      println("<dev string:xbf>" + owner + "<dev string:xd9>");
      owner = # "marines";
      break;
  }

  switch (teamfaction) {
    case # "x":
      teamfaction = # "axis";
      break;
    case # "l":
      teamfaction = # "allies";
      break;
    case # "r":
      teamfaction = # "none";
      break;
    default:
      println("<dev string:xde>" + teamfaction + "<dev string:xd9>");
      teamfaction = # "allies";
      break;
  }

  data = spawnStruct();
  data.team = teamfaction;
  data.owner = exittype;
  data.bombsite = pos;
  data.yaw = team;
  direction = (0, team, 0);
  data.direction = direction;
  data.flyheight = height;

  if(yaw == "a") {
    planehalfdistance = 12000;
    data.planehalfdistance = planehalfdistance;
    data.startpoint = pos + vectorscale(anglesToForward(direction), -1 * planehalfdistance);
    data.endpoint = pos + vectorscale(anglesToForward(direction), planehalfdistance);
    data.planemodel = "t5_veh_air_b52";
    data.flybysound = "null";
    data.washsound = # "veh_b52_flyby_wash";
    data.apextime = 6145;
    data.exittype = -1;
    data.flyspeed = 2000;
    data.flytime = planehalfdistance * 2 / data.flyspeed;
    planetype = "airstrike";
    return;
  }

  if(yaw == "n") {
    planehalfdistance = 24000;
    data.planehalfdistance = planehalfdistance;
    data.startpoint = pos + vectorscale(anglesToForward(direction), -1 * planehalfdistance);
    data.endpoint = pos + vectorscale(anglesToForward(direction), planehalfdistance);
    data.planemodel = airsupport::getplanemodel(owner);
    data.flybysound = "null";
    data.washsound = # "evt_us_napalm_wash";
    data.apextime = 2362;
    data.exittype = time;
    data.flyspeed = 7000;
    data.flytime = planehalfdistance * 2 / data.flyspeed;
    planetype = "napalm";
    return;
  }

  println("<dev string:x114>");
  println("<dev string:x118>");
  println(yaw);
  println("<dev string:x114>");

  return;
}

function creating_corpse(localclientnum, player) {
  params = spawnStruct();
  params.player = player;

  if(isDefined(player)) {
    params.playername = player getplayername();
    params.playernum = player getentitynumber();
  }

  self callback(#"on_player_corpse", localclientnum, params);
}

function callback_emp(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.emp = bwastimejump;
  println("<dev string:x162>");

  if(bwastimejump) {
    self notify(#"emp");
    return;
  }

  self notify(#"not_emp");
}

function callback_proximity(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.enemyinproximity = bwastimejump;
}