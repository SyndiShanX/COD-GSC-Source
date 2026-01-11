/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\_utility.csc
*****************************************************/

#include clientscripts\mp\_utility_code;

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
  assertEx(isDefined(fx), "Need to define the " + name + " effect.");
  if(!isDefined(level._optionalStepEffects)) {
    level._optionalStepEffects = [];
  }
  level._optionalStepEffects[level._optionalStepEffects.size] = name;
  level._effect["step_" + name] = fx;
}