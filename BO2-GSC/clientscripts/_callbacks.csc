/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_callbacks.csc
****************************************/

#include clientscripts\_utility;
#include clientscripts\_vehicle;
#include clientscripts\_lights;
#include clientscripts\_fx;
#include clientscripts\_ambientpackage;
#include clientscripts\_flamethrower_plight;
#include clientscripts\_audio;
#include clientscripts\_explosive_bolt;
#include clientscripts\_claw_grenade;
#include clientscripts\_network_intruder;
#include clientscripts\_explosive_dart;
#include clientscripts\_sticky_grenade;
#include clientscripts\_treadfx;
#include clientscripts\_helicopter_sounds;
#include clientscripts\_napalm;
#include clientscripts\_footsteps;

statechange(clientnum, system, newstate) {
  if(!isDefined(level._systemstates))
    level._systemstates = [];

  if(!isDefined(level._systemstates[system]))
    level._systemstates[system] = spawnstruct();

  level._systemstates[system].state = newstate;

  if(isDefined(level._systemstates[system].callback))
    [[level._systemstates[system].callback]](clientnum, newstate);
  else {
    println("*** Unhandled client system state change - " + system + " - has no registered callback function.");

  }
}

maprestart() {
  println("*** Client script VM map restart.");
}

glass_smash(org, dir) {
  level notify("glass_smash", org, dir);
}

soundsetambientstate(ambientroom, ambientpackage, roomcollidercent, packagecollidercent, defaultroom) {
  clientscripts\_ambientpackage::setcurrentambientstate(ambientroom, ambientpackage, roomcollidercent, packagecollidercent, defaultroom);
}

soundsetaiambientstate(triggers, actors, numtriggers) {
  self thread clientscripts\_ambientpackage::setcurrentaiambientstate(triggers, actors, numtriggers);
}

init_fx(clientnum) {
  waitforclient(clientnum);
  clientscripts\_fx::fx_init(clientnum);
}

addcallback(event, func) {
  assert(isDefined(event), "Trying to set a callback on an undefined event.");

  if(!isDefined(level._callbacks) || !isDefined(level._callbacks[event]))
    level._callbacks[event] = [];

  level._callbacks[event] = add_to_array(level._callbacks[event], func, 0);
}

callback(event, clientnum) {
  if(isDefined(level._callbacks) && isDefined(level._callbacks[event])) {
    for(i = 0; i < level._callbacks[event].size; i++) {
      callback = level._callbacks[event][i];

      if(isDefined(callback))
        self thread[[callback]](clientnum);
    }
  }
}

localclientconnect(clientnum) {
  println("*** Client script VM : Local client connect " + clientnum);

  level.usetreadfx = 1;

  if(isDefined(level._load_done) && clientnum > 0) {
    level notify("kill_treads_forever");
    level.usetreadfx = 0;
  }

  if(!isDefined(level._laststand))
    level._laststand = [];

  level._laststand[clientnum] = 0;
  level notify("connected", clientnum);
  level thread localclientconnect_callback(clientnum);
}

localclientconnect_callback(clientnum) {
  for(player = level.localplayers[clientnum]; !isDefined(player); player = level.localplayers[clientnum])
    wait 0.01;

  player callback("on_player_connect", clientnum);
}

localclientdisconnect(clientnum) {
  println("*** Client script VM : Local client disconnect " + clientnum);
}

playerspawned(localclientnum) {
  self endon("entityshutdown");
  self thread clientscripts\_flamethrower_plight::play_pilot_light_fx(localclientnum);

  if(isDefined(level._faceanimcbfunc))
    self thread[[level._faceanimcbfunc]](localclientnum);

  if(isDefined(level._playercbfunc))
    self thread[[level._playercbfunc]](localclientnum);
}

codecallback_gibevent(localclientnum, type, locations) {
  if(isDefined(level._gibeventcbfunc))
    self thread[[level._gibeventcbfunc]](localclientnum, type, locations);
}

get_gib_def() {
  if(!isDefined(level._gibbing_actor_models))
    return -1;

  for(i = 0; i < level._gibbing_actor_models.size; i++) {
    if(self[[level._gibbing_actor_models[i].matches_me]]()) {
      self._original_model = self.model;
      return i;
    }
  }

  return -1;
}

entityspawned(localclientnum) {
  self endon("entityshutdown");

  if(!isDefined(self.type)) {
    println("Entity type undefined!");

    return;
  }

  if(self.type == "missile") {
    if(isdumbrocketlauncherweapon(self.weapon))
      self thread clientscripts\_audio::rpgwhizbywatcher();

    switch (self.weapon) {
      case "explosive_bolt_sp":
        self thread clientscripts\_explosive_bolt::spawned(localclientnum, 1, 0);
        break;
      case "explosive_bolt_zm":
        self thread clientscripts\_explosive_bolt::spawned(localclientnum, 1, 0);
        break;
      case "explosive_bolt_upgraded_zm":
        self thread clientscripts\_explosive_bolt::spawned(localclientnum, 1, 1);
        break;
      case "crossbow_explosive_sp":
        self thread clientscripts\_explosive_bolt::spawned(localclientnum, 1, 0);
        break;
      case "crossbow_explosive_zm":
        self thread clientscripts\_explosive_bolt::spawned(localclientnum, 1, 0);
        break;
      case "crossbow_explosive_upgraded_zm":
        self thread clientscripts\_explosive_bolt::spawned(localclientnum, 0, 1);
        break;
      case "bigdog_launcher":
      case "claw_grenade_sp":
        self thread clientscripts\_claw_grenade::spawned(localclientnum);
        break;
      case "network_intruder_sp":
        self thread clientscripts\_network_intruder::spawned(localclientnum);
        break;
      case "explosive_dart_sp":
      case "titus_explosive_dart_sp":
        self thread clientscripts\_explosive_dart::spawned(localclientnum);
        break;
      case "sticky_grenade_future_sp":
      case "sticky_grenade_sp":
        self thread clientscripts\_sticky_grenade::spawned(localclientnum, 1);
        break;
    }
  }

  if(self.type == "vehicle") {
    if(!isDefined(level.vehicles_inited))
      clientscripts\_vehicle::init_vehicles();

    clientscripts\_treadfx::loadtreadfx(self);

    if(isDefined(level._customvehiclecbfunc))
      self thread[[level._customvehiclecbfunc]](localclientnum);

    if(self is_4wheel())
      self thread clientscripts\_audio::play_death_fire_loop();

    self thread vehicle_flag_toggle_exhaustfx_handler(localclientnum, self clientflag(8), 1);
    self thread vehicle_flag_toggle_lights_handler(localclientnum, self clientflag(10), 1);

    if(!self is_plane() && !self is_helicopter() && level.usetreadfx == 1) {
      assert(isDefined(self.rumbletype));
      precacherumble(self.rumbletype);
      self thread vehicle_treads(localclientnum);
      self thread vehicle_rumble(localclientnum);
      self thread vehicle_variants(localclientnum);
      self thread vehicle_weapon_fired();
    } else if(self is_plane()) {
      self thread aircraft_dustkick();
      self clientscripts\_helicopter_sounds::start_helicopter_sounds();
    } else if(self is_helicopter()) {
      assert(isDefined(self.rumbletype));
      precacherumble(self.rumbletype);
      self thread aircraft_dustkick();
      self clientscripts\_helicopter_sounds::start_helicopter_sounds();
    }
  }

  if(self.type == "actor" && isDefined(level._faceanimcbfunc))
    self thread[[level._faceanimcbfunc]](localclientnum);

  self.entity_spawned = 1;
  self notify("entity_spawned");
}

entityshutdown_callback(localclientnum, entity) {
  if(isDefined(level._entityshutdowncbfunc))
    [[level._entityshutdowncbfunc]](localclientnum, entity);
}

localclientchanged_callback(localclientnum) {
  level.localplayers = getlocalplayers();
}

airsupport(localclientnum, x, y, z, type, yaw, team, teamfaction, owner, exittype) {
  pos = (x, y, z);

  switch (teamfaction) {
    case "v":
      teamfaction = "vietcong";
      break;
    case "n":
    case "nva":
      teamfaction = "nva";
      break;
    case "j":
      teamfaction = "japanese";
      break;
    case "m":
      teamfaction = "marines";
      break;
    case "s":
      teamfaction = "specops";
      break;
    case "r":
      teamfaction = "russian";
      break;
    default:

      println("Warning: Invalid team char provided, defaulted to marines");
      println(teamfaction + "\\n");

      teamfaction = "marines";
      break;
  }

  switch (team) {
    case "x":
      team = "axis";
      break;
    case "l":
      team = "allies";
      break;
    case "r":
      team = "free";
      break;
    default:

      println("Invalid team used with playclientAirstike/napalm: " + team + "\\n");

      team = "allies";
      break;
  }

  switch (exittype) {
    case "l":
      exittype = "left";
      break;
    case "r":
      exittype = "right";
      break;
    case "s":
      exittype = "straight";
      break;
    case "b":
      exittype = "barrelroll";
      break;
    default:

      println("Warning: Incorret exit type, defaulting to left");
      println(exittype + "\\n");

      team = "left";
      break;
  }

  if(type == "n")
    clientscripts\_napalm::startnapalm(localclientnum, pos, yaw, teamfaction, team, owner, exittype);
  else {
    println("");
    println("Unhandled airsupport type, only A (airstrike) and N (napalm) supported");
    println(type);
    println("");

  }
}

scriptmodelspawned(local_client_num, ent, destructable_index) {
  if(destructable_index == 0) {
    return;
  }
  if(!isDefined(level.createfxent)) {
    return;
  }
  fixed = 0;

  for(i = 0; i < level.createfxent.size; i++) {
    if(level.createfxent[i].v["type"] != "exploder") {
      continue;
    }
    exploder = level.createfxent[i];

    if(!isDefined(exploder.needs_fixup)) {
      continue;
    }
    if(exploder.needs_fixup == destructable_index) {
      exploder.v["angles"] = vectortoangles(ent.origin - exploder.v["origin"]);
      exploder clientscripts\_fx::set_forward_and_up_vectors();
      exploder.needs_fixup = undefined;
      fixed = 1;
    }
  }
}

callback_activate_exploder(exploder_id) {
  if(!isDefined(level._exploder_ids)) {
    return;
  }
  keys = getarraykeys(level._exploder_ids);
  exploder = undefined;

  for(i = 0; i < keys.size; i++) {
    if(level._exploder_ids[keys[i]] == exploder_id) {
      exploder = keys[i];
      break;
    }
  }

  if(!isDefined(exploder)) {
    return;
  }
  clientscripts\_fx::activate_exploder(exploder);
}

callback_deactivate_exploder(exploder_id) {
  if(!isDefined(level._exploder_ids)) {
    return;
  }
  keys = getarraykeys(level._exploder_ids);
  exploder = undefined;

  for(i = 0; i < keys.size; i++) {
    if(level._exploder_ids[keys[i]] == exploder_id) {
      exploder = keys[i];
      break;
    }
  }

  if(!isDefined(exploder)) {
    return;
  }
  clientscripts\_fx::deactivate_exploder(exploder);
}

sound_notify(client_num, entity, note) {
  if(note == "sound_dogstep_run_default") {
    entity playsound(client_num, "fly_dog_step_run_default");
    return true;
  }

  prefix = getsubstr(note, 0, 5);

  if(prefix != "sound")
    return false;

  alias = "aml" + getsubstr(note, 5);
  entity play_dog_sound(client_num, alias);
}

dog_sound_print(message) {
  level.dog_debug_sound = 0;

  if(!level.dog_debug_sound) {
    return;
  }
  println("CLIENT DOG SOUND: " + message);
}

play_dog_sound(localclientnum, sound, position) {
  dog_sound_print("SOUND " + sound);

  if(isDefined(position))
    return self playsound(localclientnum, sound, position);

  return self playsound(localclientnum, sound);
}

client_flag_callback(localclientnum, flag, set, newent) {
  if((self.type == "vehicle" || self.type == "actor" || self.type == "missle") && !isDefined(self.entity_spawned))
    self waittill("entity_spawned");

  if(isDefined(level._client_flag_callbacks) && isDefined(level._client_flag_callbacks[self.type]) && isDefined(level._client_flag_callbacks[self.type][flag]))
    self thread[[level._client_flag_callbacks[self.type][flag]]](localclientnum, set, newent);
  else {
  }
}

client_flagasval_callback(localclientnum, val) {
  if(isDefined(level._client_flagasval_callbacks) && isDefined(level._client_flagasval_callbacks[self.type]))
    self thread[[level._client_flagasval_callbacks[self.type]]](localclientnum, val);
}

codecallback_creatingcorpse(localclientnum, player) {
  player notify("face", "face_death");
}

codecallback_playerjump(client_num, player, ground_type, firstperson, quiet, islouder) {
  clientscripts\_footsteps::playerjump(client_num, player, ground_type, firstperson, quiet);
}

codecallback_playerland(client_num, player, ground_type, firstperson, quiet, damageplayer, islouder) {
  clientscripts\_footsteps::playerland(client_num, player, ground_type, firstperson, quiet, damageplayer);
}

codecallback_playerfoliage(client_num, player, firstperson, quiet) {
  clientscripts\_footsteps::playerfoliage(client_num, player, firstperson, quiet);
}

addplayweapondeatheffectscallback(weaponname, func) {
  if(!isDefined(level._playweapondeatheffectscallbacks))
    level._playweapondeatheffectscallbacks = [];

  level._playweapondeatheffectscallbacks[weaponname] = func;
}

codecallback_playweapondeatheffects(localclientnum, weaponname, userdata) {
  if(isDefined(level._playweapondeatheffectscallbacks) && isDefined(level._playweapondeatheffectscallbacks[weaponname]))
    self thread[[level._playweapondeatheffectscallbacks[weaponname]]](localclientnum, weaponname, userdata);
}

addplayweapondamageeffectscallback(weaponname, func) {
  if(!isDefined(level._playweapondamageeffectscallbacks))
    level._playweapondamageeffectscallbacks = [];

  level._playweapondamageeffectscallbacks[weaponname] = func;
}

codecallback_playweapondamageeffects(localclientnum, weaponname, userdata) {
  if(isDefined(level._playweapondamageeffectscallbacks) && isDefined(level._playweapondamageeffectscallbacks[weaponname]))
    self thread[[level._playweapondamageeffectscallbacks[weaponname]]](localclientnum, weaponname, userdata);
}

codecallback_suimessage(localclientnum, param1, param2) {
  if(isDefined(level.onsuimessage))
    [[level.onsuimessage]](localclientnum, param1, param2);
}

codecallback_argusnotify(localclientnum, argusid, usertag, message) {
  if(isDefined(level.onargusnotify))
    return [
      [level.onargusnotify]
    ](localclientnum, argusid, usertag, message);

  return 1;
}