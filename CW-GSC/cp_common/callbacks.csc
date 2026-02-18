/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\callbacks.csc
***********************************************/

#using scripts\core_common\ai_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\footsteps_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\callbacks;
#using scripts\weapons\cp\explosive_bolt;
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
  level.callbackcreatingcorpse = &creating_corpse;
  level.callbackentityspawned = &entityspawned;
  level.callbackplayaifootstep = &footsteps::playaifootstep;
  level.var_4564d138 = &function_e551f1ce;
  level.var_6bd86801 = &function_1786cd9e;
  level.var_bad05810 = &function_c3238310;
  level._custom_weapon_cb_func = &spawned_weapon_type;
  level.var_6b11d5f6 = &function_cbfd8fd6;
}

function localclientconnect(localclientnum) {
  println("<dev string:x38>" + localclientnum);

  if(isDefined(level.charactercustomizationsetup)) {
    [[level.charactercustomizationsetup]](localclientnum);
  }

  if(isDefined(level.weaponcustomizationiconsetup)) {
    [[level.weaponcustomizationiconsetup]](localclientnum);
  }

  callback(#"on_localclient_connect", localclientnum);
}

function playerspawned(localclientnum) {
  self endon(#"death");
  util::function_89a98f85();

  if(isDefined(level.infraredvisionset)) {
    function_8608b950(localclientnum, level.infraredvisionset);
  }

  if(self function_21c0fa55()) {
    callback(#"on_localplayer_spawned", localclientnum);
  }

  callback(#"on_player_spawned", localclientnum);
}

function entityspawned(localclientnum) {
  self endon(#"death");
  util::function_89a98f85();

  if(!isDefined(self.type)) {
    println("<dev string:x68>");
    return;
  }

  if(isPlayer(self)) {
    if(isDefined(level._clientfaceanimonplayerspawned)) {
      self thread[[level._clientfaceanimonplayerspawned]](localclientnum);
    }
  }

  if(self.type == "missile") {
    if(isDefined(level._custom_weapon_cb_func)) {
      self thread[[level._custom_weapon_cb_func]](localclientnum);
    }

    switch (self.weapon.name) {
      case # "explosive_bolt":
        self thread explosive_bolt::spawned(localclientnum);
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

    if(self.vehicleclass == "plane" || self.vehicleclass == "helicopter") {
      self thread vehicle::aircraft_dustkick();
    }

    return;
  }

  if(self.type == "actor") {
    self enableonradar();

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

    return;
  }

  if(self function_8d8e91af()) {
    if(isDefined(level.var_9d3b5cf9)) {
      self thread[[level.var_9d3b5cf9]](localclientnum);
    }
  }
}

function creating_corpse(localclientnum, player) {}

function callback_stunned(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.stunned = bwastimejump;
  println("<dev string:x82>");

  if(bwastimejump) {
    self notify(#"stunned");
    return;
  }

  self notify(#"not_stunned");
}

function callback_emp(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.emp = bwastimejump;
  println("<dev string:x96>");

  if(bwastimejump) {
    self notify(#"emp");
    return;
  }

  self notify(#"not_emp");
}

function callback_proximity(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.enemyinproximity = bwastimejump;
}

function function_19bd6f4f() {
  for(localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
    foreach(luielems in level.var_a706401b) {
      foreach(luielem in luielems) {
        if([[luielem.var_34327e5a]] - > is_open(localclientnum)) {
          [[luielem.var_34327e5a]] - > close(localclientnum);
        }
      }
    }
  }
}

function function_a578d98() {
  if(!level.var_4fe1773a) {
    audio::function_d3790fe();
  }
}

function function_e551f1ce() {
  function_19bd6f4f();
}

function function_1786cd9e() {
  function_19bd6f4f();
}

function function_c3238310() {
  function_a578d98();
}