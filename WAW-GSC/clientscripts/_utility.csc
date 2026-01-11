/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_utility.csc
*****************************************************/

#include clientscripts\_utility_code;
#include clientscripts\_fx;

error(message) {
  println("^c * ERROR * ", message);
  wait 0.05;
}

getstruct(name, type) {
  if(!isDefined(level.struct_class_names)) {
    return undefined;
  }
  array = level.struct_class_names[type][name];
  if(!isDefined(array)) {
    println("**** Getstruct returns undefined on " + name + " : " + " type.");
    return undefined;
  }
  if(array.size > 1) {
    assertMsg("getstruct used for more than one struct of type " + type + " called " + name + ".");
    return undefined;
  }
  return array[0];
}

getstructarray(name, type) {
  assertEx(isDefined(level.struct_class_names), "Tried to getstruct before the structs were init");
  array = level.struct_class_names[type][name];
  if(!isDefined(array)) {
    return [];
  } else {
    return array;
  }
}

play_sound_in_space(localClientNum, alias, origin) {
  playSound(localClientNum, alias, origin);
}

vectorScale(vector, scale) {
  vector = (vector[0] * scale, vector[1] * scale, vector[2] * scale);
  return vector;
}

vector_multiply(vec, dif) {
  vec = (vec[0] * dif, vec[1] * dif, vec[2] * dif);
  return vec;
}

array_thread(entities, process, var1, var2, var3) {
  keys = getArrayKeys(entities);
  if(isDefined(var3)) {
    for(i = 0; i < keys.size; i++) {
      entities[keys[i]] thread[[process]](var1, var2, var3);
    }
    return;
  }
  if(isDefined(var2)) {
    for(i = 0; i < keys.size; i++) {
      entities[keys[i]] thread[[process]](var1, var2);
    }
    return;
  }
  if(isDefined(var1)) {
    for(i = 0; i < keys.size; i++) {
      entities[keys[i]] thread[[process]](var1);
    }
    return;
  }
  for(i = 0; i < keys.size; i++) {
    entities[keys[i]] thread[[process]]();
  }
}

registerSystem(sSysName, cbFunc) {
  if(!isDefined(level._systemStates)) {
    level._systemStates = [];
  }
  if(level._systemStates.size >= 32) {
    error("Max num client systems exceeded.");
    return;
  }
  if(isDefined(level._systemStates[sSysName])) {
    error("Attempt to re-register client system : " + sSysName);
    return;
  } else {
    level._systemStates[sSysName] = spawnStruct();
    level._systemStates[sSysName].callback = cbFunc;
  }
}

loop_sound_Delete(ender, entId) {
  self waittill(ender);
  deletefakeent(0, entId);
}

loop_fx_sound(clientNum, alias, origin, ender) {
  entId = spawnfakeent(clientNum);
  if(isDefined(ender)) {
    thread loop_sound_Delete(ender, entId);
    self endon(ender);
  }
  setfakeentorg(clientNum, entId, origin);
  playLoopSound(clientNum, entId, alias);
}

waitforclient(client) {
  while(!clienthassnapshot(client)) {
    wait(0.01);
  }
  syncsystemstates(client);
}

within_fov(start_origin, start_angles, end_origin, fov) {
  normal = VectorNormalize(end_origin - start_origin);
  forward = anglesToForward(start_angles);
  dot = VectorDot(forward, normal);
  return dot >= fov;
}

add_to_array(array, ent) {
  if(!isDefined(ent)) {
    return array;
  }
  if(!isDefined(array)) {
    array[0] = ent;
  }
  else {
    array[array.size] = ent;
  }
  return array;
}

setFootstepEffect(name, fx) {
  assertEx(isDefined(name), "Need to define the footstep surface type.");
  assertEx(isDefined(fx), "Need to define the mud footstep effect.");
  if(!isDefined(level._optionalStepEffects)) {
    level._optionalStepEffects = [];
  }
  level._optionalStepEffects[level._optionalStepEffects.size] = name;
  level._effect["step_" + name] = fx;
}

getExploderId(ent) {
  if(!isDefined(level._exploder_ids)) {
    level._exploder_ids = [];
    level._exploder_id = 1;
  }
  if(!isDefined(level._exploder_ids[ent.v["exploder"]])) {
    level._exploder_ids[ent.v["exploder"]] = level._exploder_id;
    level._exploder_id++;
  }
  return level._exploder_ids[ent.v["exploder"]];
}

reportExploderIds() {
  if(!isDefined(level._exploder_ids)) {
    return;
  }
  keys = GetArrayKeys(level._exploder_ids);
  println("Client Exploder dictionary : ");
  for(i = 0; i < keys.size; i++) {
    println(keys[i] + " : " + level._exploder_ids[keys[i]]);
  }
}

init_exploders() {
  println("*** Init exploders...");
  script_exploders = [];
  ents = GetStructArray("script_brushmodel", "classname");
  println("Client : s_bm " + ents.size);
  smodels = GetStructArray("script_model", "classname");
  println("Client : sm " + smodels.size);
  for(i = 0; i < smodels.size; i++) {
    ents[ents.size] = smodels[i];
  }
  for(i = 0; i < ents.size; i++) {
    if(isDefined(ents[i].script_prefab_exploder)) {
      ents[i].script_exploder = ents[i].script_prefab_exploder;
    }
  }
  potentialExploders = GetStructArray("script_brushmodel", "classname");
  println("Client : Potential exploders from script_brushmodel " + potentialExploders.size);
  for(i = 0; i < potentialExploders.size; i++) {
    if(isDefined(potentialExploders[i].script_prefab_exploder)) {
      potentialExploders[i].script_exploder = potentialExploders[i].script_prefab_exploder;
    }
    if(isDefined(potentialExploders[i].script_exploder)) {
      script_exploders[script_exploders.size] = potentialExploders[i];
    }
  }
  potentialExploders = GetStructArray("script_model", "classname");
  println("Client : Potential exploders from script_model " + potentialExploders.size);
  for(i = 0; i < potentialExploders.size; i++) {
    if(isDefined(potentialExploders[i].script_prefab_exploder)) {
      potentialExploders[i].script_exploder = potentialExploders[i].script_prefab_exploder;
    }
    if(isDefined(potentialExploders[i].script_exploder)) {
      script_exploders[script_exploders.size] = potentialExploders[i];
    }
  }
  for(i = 0; i < level.struct.size; i++) {
    if(isDefined(level.struct[i].script_prefab_exploder)) {
      level.struct[i].script_exploder = level.struct[i].script_prefab_exploder;
    }
    if(isDefined(level.struct[i].script_exploder)) {
      script_exploders[script_exploders.size] = level.struct[i];
    }
  }
  if(!isDefined(level.createFXent)) {
    level.createFXent = [];
  }
  acceptableTargetnames = [];
  acceptableTargetnames["exploderchunk visible"] = true;
  acceptableTargetnames["exploderchunk"] = true;
  acceptableTargetnames["exploder"] = true;
  exploder_id = 1;
  for(i = 0; i < script_exploders.size; i++) {
    exploder = script_exploders[i];
    ent = createExploder(exploder.script_fxid);
    ent.v = [];
    if(!isDefined(exploder.origin)) {
      println("************** NO EXPLODER ORIGIN." + i);
    }
    ent.v["origin"] = exploder.origin;
    ent.v["angles"] = exploder.angles;
    ent.v["delay"] = exploder.script_delay;
    ent.v["firefx"] = exploder.script_firefx;
    ent.v["firefxdelay"] = exploder.script_firefxdelay;
    ent.v["firefxsound"] = exploder.script_firefxsound;
    ent.v["firefxtimeout"] = exploder.script_firefxtimeout;
    ent.v["trailfx"] = exploder.script_trailfx;
    ent.v["trailfxtag"] = exploder.script_trailfxtag;
    ent.v["trailfxdelay"] = exploder.script_trailfxdelay;
    ent.v["trailfxsound"] = exploder.script_trailfxsound;
    ent.v["trailfxtimeout"] = exploder.script_firefxtimeout;
    ent.v["earthquake"] = exploder.script_earthquake;
    ent.v["rumble"] = exploder.script_rumble;
    ent.v["damage"] = exploder.script_damage;
    ent.v["damage_radius"] = exploder.script_radius;
    ent.v["repeat"] = exploder.script_repeat;
    ent.v["delay_min"] = exploder.script_delay_min;
    ent.v["delay_max"] = exploder.script_delay_max;
    ent.v["target"] = exploder.target;
    ent.v["ender"] = exploder.script_ender;
    ent.v["physics"] = exploder.script_physics;
    ent.v["type"] = "exploder";
    if(!isDefined(exploder.script_fxid)) {
      ent.v["fxid"] = "No FX";
    } else {
      ent.v["fxid"] = exploder.script_fxid;
    }
    ent.v["exploder"] = exploder.script_exploder;
    if(!isDefined(ent.v["delay"])) {
      ent.v["delay"] = 0;
    }
    if(isDefined(exploder.script_sound)) {
      ent.v["soundalias"] = exploder.script_sound;
    } else if(ent.v["fxid"] != "No FX") {
      if(isDefined(level.scr_sound) && isDefined(level.scr_sound[ent.v["fxid"]])) {
        ent.v["soundalias"] = level.scr_sound[ent.v["fxid"]];
      }
    }
    fixup_set = false;
    if(isDefined(ent.v["target"])) {
      ent.needs_fixup = exploder_id;
      exploder_id++;
      fixup_set = true;
      {
        temp_ent = GetStruct(ent.v["target"], "targetname");
        org = temp_ent.origin;
      }
      if(isDefined(org)) {
        ent.v["angles"] = VectorToAngles(org - ent.v["origin"]);
      } else {
        println("*** Client : Exploder " + exploder.script_fxid + " Failed to find target ");
      }
      if(isDefined(ent.v["angles"])) {
        ent set_forward_and_up_vectors();
      } else {
        println("*** Client " + exploder.script_fxid + " has no angles.");
      }
    }
    if(exploder.classname == "script_brushmodel" || isDefined(exploder.model)) {
      if(isDefined(exploder.model)) {
        println("*** exploder " + exploder_id + " model " + exploder.model);
      }
      ent.model = exploder;
      if(fixup_set == false) {
        ent.needs_fixup = exploder_id;
        exploder_id++;
      }
    }
    if(isDefined(exploder.targetname) && isDefined(acceptableTargetnames[exploder.targetname])) {
      ent.v["exploder_type"] = exploder.targetname;
    } else {
      ent.v["exploder_type"] = "normal";
    }
  }
  for(i = 0; i < level.createFXent.size; i++) {
    ent = level.createFXent[i];
    if(ent.v["type"] != "exploder") {
      continue;
    }
    ent.v["exploder_id"] = getExploderId(ent);
  }
  reportExploderIds();
  println("*** Client : " + script_exploders.size + " exploders.");
}

playfx_for_all_local_clients(fx_id, pos, forward_vec, up_vec) {
  localPlayers = getlocalplayers();
  if(isDefined(up_vec)) {
    for(i = 0; i < localPlayers.size; i++) {
      playFX(i, fx_id, pos, forward_vec, up_vec);
    }
  } else if(isDefined(forward_vec)) {
    for(i = 0; i < localPlayers.size; i++) {
      playFX(i, fx_id, pos, forward_vec);
    }
  } else {
    for(i = 0; i < localPlayers.size; i++) {
      playFX(i, fx_id, pos);
    }
  }
}

play_sound_on_client(sound_alias) {
  players = GetLocalPlayers();
  playSound(0, sound_alias, players[0].origin);
}

loop_sound_on_client(sound_alias, min_delay, max_delay, end_on) {
  players = GetLocalPlayers();
  if(isDefined(end_on)) {
    level endon(end_on);
  }
  for(;;) {
    play_sound_on_client(sound_alias);
    wait(min_delay + RandomFloat(max_delay));
  }
}

add_listen_thread(wait_till, func, param1, param2, param3, param4, param5) {
  level thread add_listen_thread_internal(wait_till, func, param1, param2, param3, param4, param5);
}

add_listen_thread_internal(wait_till, func, param1, param2, param3, param4, param5) {
  for(;;) {
    level waittill(wait_till);
    if(isDefined(param5)) {
      level thread[[func]](param1, param2, param3, param4, param5);
    } else if(isDefined(param4)) {
      level thread[[func]](param1, param2, param3, param4);
    } else if(isDefined(param3)) {
      level thread[[func]](param1, param2, param3);
    } else if(isDefined(param2)) {
      level thread[[func]](param1, param2);
    } else if(isDefined(param1)) {
      level thread[[func]](param1);
    } else {
      level thread[[func]]();
    }
  }
}

addLightningExploder(num) {
  if(!isDefined(level.lightningExploder)) {
    level.lightningExploder = [];
    level.lightningExploderIndex = 0;
  }
  level.lightningExploder[level.lightningExploder.size] = num;
}

splitscreen_populate_dvars(clientNum) {
  if(getlocalplayers().size <= 1) {
    return;
  }
  UpdateDvarsFromProfile(clientNum);
}

splitscreen_restore_dvars() {
  if(getlocalplayers().size <= 1) {
    return;
  }
  splitscreen_populate_dvars(0);
}