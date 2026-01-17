/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_callbacks.csc
*************************************************/

#using scripts\cp\_burnplayer;
#using scripts\cp\_callbacks;
#using scripts\cp\_claymore;
#using scripts\cp\_explosive_bolt;
#using scripts\shared\ai_shared;
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
  system::register("callback", &__init__, undefined, undefined);
}

function __init__() {
  level thread set_default_callbacks();
}

function set_default_callbacks() {
  level.callbackplayerspawned = &playerspawned;
  level.callbacklocalclientconnect = &localclientconnect;
  level.callbackcreatingcorpse = &creating_corpse;
  level.callbackentityspawned = &entityspawned;
  level.callbackplayaifootstep = &footsteps::playaifootstep;
  level.callbackplaylightloopexploder = &exploder::playlightloopexploder;
  level._custom_weapon_cb_func = &spawned_weapon_type;
}

function localclientconnect(localclientnum) {
  println("" + localclientnum);
  if(isDefined(level.charactercustomizationsetup)) {
    [[level.charactercustomizationsetup]](localclientnum);
  }
  if(isDefined(level.weaponcustomizationiconsetup)) {
    [[level.weaponcustomizationiconsetup]](localclientnum);
  }
  callback("hash_da8d7d74", localclientnum);
}

function playerspawned(localclientnum) {
  self endon("entityshutdown");
  player = getlocalplayer(localclientnum);
  assert(isDefined(player));
  if(isDefined(level.infraredvisionset)) {
    player setinfraredvisionset(level.infraredvisionset);
  }
  if(self islocalplayer()) {
    callback("hash_842e788a", localclientnum);
  }
  callback("hash_bc12b61f", localclientnum);
}

function entityspawned(localclientnum) {
  self endon("entityshutdown");
  if(!isDefined(self.type)) {
    println("");
    return;
  }
  if(self isplayer()) {
    if(isDefined(level._clientfaceanimonplayerspawned)) {
      self thread[[level._clientfaceanimonplayerspawned]](localclientnum);
    }
  }
  if(self.type == "missile") {
    if(isDefined(level._custom_weapon_cb_func)) {
      self thread[[level._custom_weapon_cb_func]](localclientnum);
    }
    switch (self.weapon.name) {
      case "explosive_bolt": {
        self thread _explosive_bolt::spawned(localclientnum);
        break;
      }
      case "claymore": {
        self thread _claymore::spawned(localclientnum);
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
      if(self.vehicleclass == "plane" || self.vehicleclass == "helicopter") {
        self thread vehicle::aircraft_dustkick();
      } else {
        self thread driving_fx::play_driving_fx(localclientnum);
        self thread vehicle::rumble(localclientnum);
      }
    } else if(self.type == "actor") {
      self enableonradar();
      if(isDefined(level._customactorcbfunc)) {
        self thread[[level._customactorcbfunc]](localclientnum);
      }
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