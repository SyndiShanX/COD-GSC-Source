/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_callbacks.csc
****************************************/

#include clientscripts\_utility;
#include clientscripts\_vehicle;
#include clientscripts\_lights;
#include clientscripts\_fx;

statechange(clientNum, system, newState) {
  if(!isDefined(level._systemStates)) {
    level._systemStates = [];
  }
  if(!isDefined(level._systemStates[system])) {
    level._systemStates[system] = spawnStruct();
  }
  level._systemStates[system].state = newState;
  if(isDefined(level._systemStates[system].callback)) {
    [[level._systemStates[system].callback]](clientNum, newState);
  } else {
    println("*** Unhandled client system state change - " + system + " - has no registered callback function.");
  }
}

maprestart() {
  println("*** Client script VM map restart.");
}

glass_smash(org, dir) {
  level notify("glass_smash", org, dir);
}

init_fx(clientNum) {
  waitforclient(clientNum);
  clientscripts\_fx::fx_init(clientNum);
}

AddCallback(event, func) {
  AssertEx(isDefined(event), "Trying to set a callback on an undefined event.");
  if(!isDefined(level._callbacks) || !isDefined(level._callbacks[event])) {
    level._callbacks[event] = [];
  }
  level._callbacks[event] = add_to_array(level._callbacks[event], func, false);
}

Callback(event, clientNum) {
  if(isDefined(level._callbacks) && isDefined(level._callbacks[event])) {
    for(i = 0; i < level._callbacks[event].size; i++) {
      callback = level._callbacks[event][i];
      if(isDefined(callback)) {
        self thread[[callback]](clientNum);
      }
    }
  }
}

localclientconnect(clientNum) {
  println("*** Client script VM : Local client connect " + clientNum);
  level.usetreadfx = 1;
  if(isDefined(level._load_done) && clientNum > 0) {
    level notify("kill_treads_forever");
    level.usetreadfx = 0;
  }
  if(!isDefined(level._laststand)) {
    level._laststand = [];
  }
  level._laststand[clientNum] = false;
  level notify("effects_init_" + clientNum);
  level notify("connected", clientNum);
  level thread localclientconnect_callback(clientNum);
}

localclientconnect_callback(clientNum) {
  wait .01;
  player = getLocalPlayers()[clientNum];
  player Callback("on_player_connect", clientNum);
}

localclientdisconnect(clientNum) {
  println("*** Client script VM : Local client disconnect " + clientNum);
}

playerspawned(localClientNum) {
  self endon("entityshutdown");
  self thread clientscripts\_flamethrower_plight::play_pilot_light_fx(localClientNum);
  if(isDefined(level._faceAnimCBFunc))
    self thread[[level._faceAnimCBFunc]](localClientNum);
  if(isDefined(level._playerCBFunc))
    self thread[[level._playerCBFunc]](localClientNum);
  level thread localclientspawned_callback(localClientNum);
}

localclientspawned_callback(localClientNum) {
  wait .01;
  player = getLocalPlayers()[localClientNum];
  player Callback("playerspawned", localClientNum);
}

CodeCallback_GibEvent(localClientNum, type, locations) {
  if(isDefined(level._gibEventCBFunc)) {
    self thread[[level._gibEventCBFunc]](localClientNum, type, locations);
  }
}

get_gib_def() {
  if(!isDefined(level._gibbing_actor_models)) {
    return -1;
  }
  for(i = 0; i < level._gibbing_actor_models.size; i++) {
    if(self[[level._gibbing_actor_models[i].matches_me]]()) {
      self._original_model = self.model;
      return i;
    }
  }
  return -1;
}

entityspawned(localClientNum) {
  self endon("entityshutdown");
  if(!isDefined(self.type)) {
    PrintLn("Entity type undefined!");
    return;
  }
  if(self.type == "missile") {
    switch (self.weapon) {
      case "explosive_bolt_sp":
        self thread clientscripts\_explosive_bolt::spawned(localClientNum, true, false);
        break;
      case "explosive_bolt_zm":
        self thread clientscripts\_explosive_bolt::spawned(localClientNum, true, false);
        break;
      case "explosive_bolt_upgraded_zm":
        self thread clientscripts\_explosive_bolt::spawned(localClientNum, true, true);
        break;
      case "crossbow_explosive_sp":
        self thread clientscripts\_explosive_bolt::spawned(localClientNum, true, false);
        break;
      case "crossbow_explosive_zm":
        self thread clientscripts\_explosive_bolt::spawned(localClientNum, true, false);
        break;
      case "crossbow_explosive_upgraded_zm":
        self thread clientscripts\_explosive_bolt::spawned(localClientNum, false, true);
        break;
      case "sticky_grenade_zm":
        if(isDefined(level.zombie_sticky_grenade_spawned_func)) {
          self thread[[level.zombie_sticky_grenade_spawned_func]](localClientNum, true);
        }
        break;
      case "zombie_quantum_bomb":
        if(isDefined(level.zombie_quantum_bomb_spawned_func)) {
          self thread[[level.zombie_quantum_bomb_spawned_func]](localClientNum, true);
        }
    }
  }
  if(self.type == "vehicle") {
    if(!isDefined(level.vehicles_inited)) {
      clientscripts\_vehicle::init_vehicles();
    }
    clientscripts\_treadfx::loadtreadfx(self);
    if(isDefined(level._customVehicleCBFunc)) {
      self thread[[level._customVehicleCBFunc]](localClientNum);
    }
    if(!(self is_plane()) && !(self is_helicopter()) && level.usetreadfx == 1) {
      assert(isDefined(self.rumbleType));
      precacherumble(self.rumbleType);
      if(isDefined(self.exhaustfxname) && self.exhaustfxname != "") {
        self.exhaust_fx = loadfx(self.exhaustfxname);
      }
      self thread vehicle_treads(localClientNum);
      self thread playTankExhaust(localClientNum);
      self thread vehicle_rumble(localClientNum);
      self thread vehicle_variants(localClientNum);
      self thread vehicle_weapon_fired();
    } else if(self is_plane()) {
      self thread aircraft_dustkick();
    } else if(self is_helicopter()) {
      assert(isDefined(self.rumbleType));
      precacherumble(self.rumbleType);
      if(isDefined(self.exhaustfxname) && self.exhaustfxname != "") {
        self.exhaust_fx = loadfx(self.exhaustfxname);
      }
      self thread play_rotor_fx(localClientNum);
      self thread delete_rotor_fx_on_save_restore(localClientNum);
      self thread play_exhaust(localClientNum);
      self thread aircraft_dustkick();
      self clientscripts\_helicopter_sounds::start_helicopter_sounds();
    }
    self thread vehicle_clientmain(localClientNum);
  } else if(self.type == "actor" && GetDvarInt(#"zombiemode") > 0) {
    if(isDefined(level._zombieCBFunc)) {
      players = getLocalPlayers();
      for(i = 0; i < players.size; i++) {
        self thread[[level._zombieCBFunc]](i);
      }
    }
  }
  if(self.type == "actor") {
    if(isDefined(level._faceAnimCBFunc))
      self thread[[level._faceAnimCBFunc]](localClientNum);
    if(localClientNum == 0) {
      self._gib_def = get_gib_def();
      if(self._gib_def == -1) {
        PrintLn("*** Actor with model " + self.model + " not set for client-side gibbing.");
      }
    }
  }
  self.entity_spawned = true;
  self notify("entity_spawned");
}

entityshutdown_callback(localClientNum, entity) {
  if(isDefined(level._entityShutDownCBFunc)) {
    [[level._entityShutDownCBFunc]](localClientNum, entity);
  }
}

airsupport(localClientNum, x, y, z, type, yaw, team, teamfaction, owner, exittype) {
  pos = (x, y, z);
  switch (teamFaction) {
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
      println(teamFaction + "\n");
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
      println("Invalid team used with playclientAirstike/napalm: " + team + "\n");
      team = "allies";
      break;
  }
  switch (exitType) {
    case "l":
      exitType = "left";
      break;
    case "r":
      exitType = "right";
      break;
    case "s":
      exitType = "straight";
      break;
    case "b":
      exitType = "barrelroll";
      break;
    default:
      println("Warning: Incorret exit type, defaulting to left");
      println(exitType + "\n");
      team = "left";
      break;
  }
  if(type == "n") {
    clientscripts\_napalm::startNapalm(localClientNum, pos, yaw, teamfaction, team, owner, exitType);
  } else {
    println("");
    println("Unhandled airsupport type, only A (airstrike) and N (napalm) supported");
    println(type);
    println("");
  }
}

scriptmodelspawned(local_client_num, ent, destructable_index) {
  if(destructable_index == 0)
    return;
  if(!isDefined(level.createFXent))
    return;
  fixed = false;
  for(i = 0; i < level.createFXent.size; i++) {
    if(level.createFXent[i].v["type"] != "exploder")
      continue;
    exploder = level.createFXent[i];
    if(!isDefined(exploder.needs_fixup))
      continue;
    if(exploder.needs_fixup == destructable_index) {
      exploder.v["angles"] = VectorToAngles(ent.origin - exploder.v["origin"]);
      exploder clientscripts\_fx::set_forward_and_up_vectors();
      exploder.needs_fixup = undefined;
      fixed = true;
    }
  }
}

callback_activate_exploder(exploder_id) {
  if(!isDefined(level._exploder_ids))
    return;
  keys = getarraykeys(level._exploder_ids);
  exploder = undefined;
  for(i = 0; i < keys.size; i++) {
    if(level._exploder_ids[keys[i]] == exploder_id) {
      exploder = keys[i];
      break;
    }
  }
  if(!isDefined(exploder)) {
    println("*** Client : Exploder id " + exploder_id + " unknown.");
    return;
  }
  println("*** Client callback - activate exploder " + exploder_id + " : " + exploder);
  clientscripts\_fx::activate_exploder(exploder);
}

callback_deactivate_exploder(exploder_id) {
  if(!isDefined(level._exploder_ids))
    return;
  keys = getarraykeys(level._exploder_ids);
  exploder = undefined;
  for(i = 0; i < keys.size; i++) {
    if(level._exploder_ids[keys[i]] == exploder_id) {
      exploder = keys[i];
      break;
    }
  }
  if(!isDefined(exploder)) {
    println("*** Client : Exploder id " + exploder_id + " unknown.");
    return;
  }
  println("*** Client callback - deactivate exploder " + exploder_id + " : " + exploder);
  clientscripts\_fx::deactivate_exploder(exploder);
}

level_notify(notify_name, param1, param2) {
  level notify(notify_name, param1, param2);
}

sound_notify(client_num, entity, note) {
  if(note == "sound_dogstep_run_default") {
    entity playSound(client_num, "fly_dog_step_run_default");
    return true;
  }
  prefix = getsubstr(note, 0, 5);
  if(prefix != "sound")
    return false;
  alias = "aml" + getsubstr(note, 5);
  entity play_dog_sound(client_num, alias);
}

dog_sound_print(message) {}
play_dog_sound(localClientNum, sound, position) {
  dog_sound_print("SOUND " + sound);
  if(isDefined(position)) {
    return self playSound(localClientNum, sound, position);
  }
  return self playSound(localClientNum, sound);
}

client_flag_callback(localClientNum, flag, set, newEnt) {
  if((self.type == "vehicle" || self.type == "actor" || self.type == "missle") && !isDefined(self.entity_spawned)) {
    self waittill("entity_spawned");
  }
  if(isDefined(level._client_flag_callbacks) && isDefined(level._client_flag_callbacks[self.type]) && isDefined(level._client_flag_callbacks[self.type][flag])) {
    self thread[[level._client_flag_callbacks[self.type][flag]]](localClientNum, set, newEnt);
  } else {}
}

client_flagasval_callback(localClientNum, val) {
  if(isDefined(level._client_flagasval_callbacks) && isDefined(level._client_flagasval_callbacks[self.type])) {
    self thread[[level._client_flagasval_callbacks[self.type]]](localClientNum, val);
  }
}

CodeCallback_PlayerFootstep(client_num, player, movementtype, ground_type, firstperson, quiet) {
  clientscripts\_footsteps::playerFootstep(client_num, player, movementtype, ground_type, firstperson, quiet);
}

CodeCallback_CreatingCorpse(localClientNum, player) {
  player notify("face", "face_death");
}

CodeCallback_PlayerJump(client_num, player, ground_type, firstperson, quiet) {
  clientscripts\_footsteps::playerJump(client_num, player, ground_type, firstperson, quiet);
}

CodeCallback_PlayerLand(client_num, player, ground_type, firstperson, quiet, damagePlayer) {
  clientscripts\_footsteps::playerLand(client_num, player, ground_type, firstperson, quiet, damagePlayer);
}

CodeCallback_PlayerFoliage(client_num, player, firstperson, quiet) {
  clientscripts\_footsteps::playerFoliage(client_num, player, firstperson, quiet);
}

AddPlayWeaponDeathEffectsCallback(weaponname, func) {
  if(!isDefined(level._playweapondeatheffectscallbacks)) {
    level._playweapondeatheffectscallbacks = [];
  }
  level._playweapondeatheffectscallbacks[weaponname] = func;
}

CodeCallback_PlayWeaponDeathEffects(localClientNum, weaponname, userdata) {
  if(isDefined(level._playweapondeatheffectscallbacks) && isDefined(level._playweapondeatheffectscallbacks[weaponname])) {
    self thread[[level._playweapondeatheffectscallbacks[weaponname]]](localClientNum, weaponname, userdata);
  }
}

AddPlayWeaponDamageEffectsCallback(weaponname, func) {
  if(!isDefined(level._playweapondamageeffectscallbacks)) {
    level._playweapondamageeffectscallbacks = [];
  }
  level._playweapondamageeffectscallbacks[weaponname] = func;
}

CodeCallback_PlayWeaponDamageEffects(localClientNum, weaponname, userdata) {
  if(isDefined(level._playweapondamageeffectscallbacks) && isDefined(level._playweapondamageeffectscallbacks[weaponname])) {
    self thread[[level._playweapondamageeffectscallbacks[weaponname]]](localClientNum, weaponname, userdata);
  }
}