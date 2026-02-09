/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_callbacks.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\filter_shared;
#using scripts\shared\footsteps_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\vehicles\_driving_fx;
#using scripts\zm\_filter;
#using scripts\zm\_sticky_grenade;
#namespace callback;

function autoexec __init__sytem__() {
  system::register("callback", &__init__, undefined, undefined);
}

function __init__() {
  level thread set_default_callbacks();
}

function set_default_callbacks() {
  level.callbackplayerspawned = &playerspawned;
  level.callbacklocalclientconnect = &localclientconnect;
  level.callbackentityspawned = &entityspawned;
  level.callbackhostmigration = &host_migration;
  level.callbackplayaifootstep = &footsteps::playaifootstep;
  level.callbackplaylightloopexploder = &exploder::playlightloopexploder;
  level._custom_weapon_cb_func = &spawned_weapon_type;
}

function localclientconnect(localclientnum) {
  println("" + localclientnum);
  callback("hash_da8d7d74", localclientnum);
  if(isDefined(level.charactercustomizationsetup)) {
    [[level.charactercustomizationsetup]](localclientnum);
  }
}

function playerspawned(localclientnum) {
  self endon("entityshutdown");
  if(isDefined(level._playerspawned_override)) {
    self thread[[level._playerspawned_override]](localclientnum);
    return;
  }
  println("");
  if(self islocalplayer()) {
    callback("hash_842e788a", localclientnum);
  }
  callback("hash_bc12b61f", localclientnum);
  level.localplayers = getlocalplayers();
}

function entityspawned(localclientnum) {
  self endon("entityshutdown");
  if(self isPlayer()) {
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
    switch (self.weapon.name) {
      case "sticky_grenade": {
        self thread _sticky_grenade::spawned(localclientnum);
        break;
      }
    }
  } else {
    if(self.type == "vehicle" || self.type == "helicopter" || self.type == "plane") {
      if(isDefined(level._customvehiclecbfunc)) {
        self thread[[level._customvehiclecbfunc]](localclientnum);
      }
      self thread vehicle::field_toggle_exhaustfx_handler(localclientnum, undefined, 0, 1);
      self thread vehicle::field_toggle_lights_handler(localclientnum, undefined, 0, 1);
      if(self.type == "plane" || self.type == "helicopter") {
        self thread vehicle::aircraft_dustkick();
      } else {
        self thread driving_fx::play_driving_fx(localclientnum);
      }
    } else if(self.type == "actor") {
      if(isDefined(level._customactorcbfunc)) {
        self thread[[level._customactorcbfunc]](localclientnum);
      }
    }
  }
}

function host_migration(localclientnum) {
  level thread prevent_round_switch_animation();
}

function prevent_round_switch_animation() {
  wait(3);
}