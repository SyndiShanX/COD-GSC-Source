/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\callbacks.csc
***********************************************/

#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\footsteps_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#namespace callback;

function private autoexec __init__system__() {
  system::register(#"callback", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level thread set_default_callbacks();
}

function set_default_callbacks() {
  level.callbackplayerspawned = &playerspawned;
  level.callbacklocalclientconnect = &localclientconnect;
  level.callbackplayerlaststand = &playerlaststand;
  level.callbackentityspawned = &entityspawned;
  level.callbackhostmigration = &host_migration;
  level.callbackplayaifootstep = &footsteps::playaifootstep;
  level._custom_weapon_cb_func = &spawned_weapon_type;
  level.var_6b11d5f6 = &function_cbfd8fd6;
}

function localclientconnect(localclientnum) {
  println("<dev string:x38>" + localclientnum);
  callback(#"on_localclient_connect", localclientnum);

  if(isDefined(level.charactercustomizationsetup)) {
    [[level.charactercustomizationsetup]](localclientnum);
  }
}

function playerlaststand(localclientnum) {
  self endon(#"death");
  callback(#"on_player_laststand", localclientnum);
}

function playerspawned(localclientnum) {
  self endon(#"death");
  util::function_89a98f85();

  if(isDefined(level._playerspawned_override)) {
    self thread[[level._playerspawned_override]](localclientnum);
    return;
  }

  println("<dev string:x68>");

  if(self function_21c0fa55()) {
    callback(#"on_localplayer_spawned", localclientnum);
  }

  callback(#"on_player_spawned", localclientnum);
  level.localplayers = getlocalplayers();
}

function entityspawned(localclientnum) {
  self endon(#"death");
  util::function_89a98f85();

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
    println("<dev string:x7a>");
    return;
  }

  if(self.type == "missile") {
    if(isDefined(level._custom_weapon_cb_func)) {
      self thread[[level._custom_weapon_cb_func]](localclientnum);
    }

    switch (self.weapon.name) {
      case # "sticky_grenade":
        break;
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

    if(self.archetype === # "bat") {
      if(isDefined(level._customactorcbfunc)) {
        self thread[[level._customactorcbfunc]](localclientnum);
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

  if(self.type == "scriptmover") {
    if(isDefined(self.weapon)) {
      if(isDefined(level.var_6b11d5f6)) {
        self thread[[level.var_6b11d5f6]](localclientnum);
      }
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

function host_migration(localclientnum) {
  level thread prevent_round_switch_animation();
}

function prevent_round_switch_animation() {
  wait 3;
}