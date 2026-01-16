/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_utility.csc
**************************************/

#include clientscripts\_utility_code;
#include clientscripts\_fx;
#include clientscripts\_callbacks;

error(message) {
  println("^c * ERROR * ", message);
  wait 0.05;
}

getstruct(name, type) {
  if(!isDefined(level.struct_class_names))
    return undefined;

  array = level.struct_class_names[type][name];

  if(!isDefined(array)) {
    println("**** Getstruct returns undefined on " + name + " : " + " type.");

    return undefined;
  }

  if(array.size > 1) {
    assertmsg("getstruct used for more than one struct of type " + type + " called " + name + ".");

    return undefined;
  }

  return array[0];
}

getstructarray(name, type) {
  assert(isDefined(level.struct_class_names), "Tried to getstruct before the structs were init");
  array = level.struct_class_names[type][name];

  if(!isDefined(array))
    return [];
  else
    return array;
}

play_sound_in_space(localclientnum, alias, origin) {
  playsound(localclientnum, alias, origin);
}

vector_compare(vec1, vec2) {
  return abs(vec1[0] - vec2[0]) < 0.001 && abs(vec1[1] - vec2[1]) < 0.001 && abs(vec1[2] - vec2[2]) < 0.001;
}

array_func(entities, func, arg1, arg2, arg3, arg4, arg5) {
  if(!isDefined(entities)) {
    return;
  }
  if(isarray(entities)) {
    if(entities.size) {
      keys = getarraykeys(entities);

      for(i = 0; i < keys.size; i++)
        single_func(entities[keys[i]], func, arg1, arg2, arg3, arg4, arg5);
    }
  } else
    single_func(entities, func, arg1, arg2, arg3, arg4, arg5);
}

single_func(entity, func, arg1, arg2, arg3, arg4, arg5) {
  if(isDefined(arg5))
    entity[[func]](arg1, arg2, arg3, arg4, arg5);
  else if(isDefined(arg4))
    entity[[func]](arg1, arg2, arg3, arg4);
  else if(isDefined(arg3))
    entity[[func]](arg1, arg2, arg3);
  else if(isDefined(arg2))
    entity[[func]](arg1, arg2);
  else if(isDefined(arg1))
    entity[[func]](arg1);
  else
    entity[[func]]();
}

array_thread(entities, func, arg1, arg2, arg3, arg4, arg5) {
  if(!isDefined(entities)) {
    return;
  }
  if(isarray(entities)) {
    if(entities.size) {
      keys = getarraykeys(entities);

      for(i = 0; i < keys.size; i++)
        single_thread(entities[keys[i]], func, arg1, arg2, arg3, arg4, arg5);
    }
  } else
    single_thread(entities, func, arg1, arg2, arg3, arg4, arg5);
}

single_thread(entity, func, arg1, arg2, arg3, arg4, arg5) {
  if(isDefined(arg5))
    entity thread[[func]](arg1, arg2, arg3, arg4, arg5);
  else if(isDefined(arg4))
    entity thread[[func]](arg1, arg2, arg3, arg4);
  else if(isDefined(arg3))
    entity thread[[func]](arg1, arg2, arg3);
  else if(isDefined(arg2))
    entity thread[[func]](arg1, arg2);
  else if(isDefined(arg1))
    entity thread[[func]](arg1);
  else
    entity thread[[func]]();
}

add_to_array(array, ent, allow_dupes) {
  if(!isDefined(ent))
    return array;

  if(!isDefined(allow_dupes))
    allow_dupes = 1;

  if(!isDefined(array))
    array[0] = ent;
  else if(allow_dupes || !isinarray(array, ent))
    array[array.size] = ent;

  return array;
}

array_delete(array) {
  for(i = 0; i < array.size; i++)
    array[i] delete();
}

array_randomize(array) {
  for(i = 0; i < array.size; i++) {
    j = randomint(array.size);
    temp = array[i];
    array[i] = array[j];
    array[j] = temp;
  }

  return array;
}

array_reverse(array) {
  array2 = [];

  for(i = array.size - 1; i >= 0; i--)
    array2[array2.size] = array[i];

  return array2;
}

array_exclude(array, arrayexclude) {
  newarray = arraycopy(array);

  for(i = 0; i < arrayexclude.size; i++)
    arrayremovevalue(newarray, arrayexclude[i]);

  return newarray;
}

array_notify(ents, notifier) {
  for(i = 0; i < ents.size; i++)
    ents[i] notify(notifier);
}

array_wait(array, msg, timeout) {
  keys = getarraykeys(array);
  structs = [];

  for(i = 0; i < keys.size; i++) {
    key = keys[i];
    structs[key] = spawnstruct();
    structs[key]._array_wait = 1;
    structs[key] thread array_waitlogic1(array[key], msg, timeout);
  }

  for(i = 0; i < keys.size; i++) {
    key = keys[i];

    if(isDefined(array[key]) && structs[key]._array_wait)
      structs[key] waittill("_array_wait");
  }
}

array_waitlogic1(ent, msg, timeout) {
  self array_waitlogic2(ent, msg, timeout);
  self._array_wait = 0;
  self notify("_array_wait");
}

array_waitlogic2(ent, msg, timeout) {
  ent endon(msg);
  ent endon("death");

  if(isDefined(timeout))
    wait(timeout);
  else
    ent waittill(msg);
}

array_check_for_dupes(array, single) {
  for(i = 0; i < array.size; i++) {
    if(array[i] == single)
      return false;
  }

  return true;
}

array_swap(array, index1, index2) {
  assert(index1 < array.size, "index1 to swap out of range");
  assert(index2 < array.size, "index2 to swap out of range");
  temp = array[index1];
  array[index1] = array[index2];
  array[index2] = temp;
  return array;
}

random(array) {
  return array[randomint(array.size)];
}

registersystem(ssysname, cbfunc) {
  if(!isDefined(level._systemstates))
    level._systemstates = [];

  if(level._systemstates.size >= 32) {
    error("Max num client systems exceeded.");

    return;
  }

  if(isDefined(level._systemstates[ssysname])) {
    error("Attempt to re-register client system : " + ssysname);

    return;
  } else {
    level._systemstates[ssysname] = spawnstruct();
    level._systemstates[ssysname].callback = cbfunc;
  }
}

loop_sound_delete(ender, entid) {
  self waittill(ender);
  deletefakeent(0, entid);
}

loop_fx_sound(clientnum, alias, origin, ender) {
  entid = spawnfakeent(clientnum);

  if(isDefined(ender)) {
    thread loop_sound_delete(ender, entid);
    self endon(ender);
  }

  setfakeentorg(clientnum, entid, origin);
  playloopsound(clientnum, entid, alias);
}

waitforallclients() {
  for(localclient = 0; localclient < level.localplayers.size; localclient++)
    waitforclient(localclient);
}

waitforclient(client) {
  while(!clienthassnapshot(client))
    wait 0.01;
}

waittill_string(msg, ent) {
  if(msg != "death")
    self endon("death");

  ent endon("die");
  self waittill(msg);
  ent notify("returned", msg);
}

waittill_any_return(string1, string2, string3, string4, string5, string6, string7) {
  if((!isDefined(string1) || string1 != "death") && (!isDefined(string2) || string2 != "death") && (!isDefined(string3) || string3 != "death") && (!isDefined(string4) || string4 != "death") && (!isDefined(string5) || string5 != "death") && (!isDefined(string6) || string6 != "death") && (!isDefined(string7) || string7 != "death"))
    self endon("death");

  ent = spawnstruct();

  if(isDefined(string1))
    self thread waittill_string(string1, ent);

  if(isDefined(string2))
    self thread waittill_string(string2, ent);

  if(isDefined(string3))
    self thread waittill_string(string3, ent);

  if(isDefined(string4))
    self thread waittill_string(string4, ent);

  if(isDefined(string5))
    self thread waittill_string(string5, ent);

  if(isDefined(string6))
    self thread waittill_string(string6, ent);

  if(isDefined(string7))
    self thread waittill_string(string7, ent);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_array_return(a_notifies) {
  if(isinarray(a_notifies, "death"))
    self endon("death");

  s_tracker = spawnstruct();

  foreach(str_notify in a_notifies) {
    if(isDefined(str_notify))
      self thread waittill_string(str_notify, s_tracker);
  }

  s_tracker waittill("returned", msg);
  s_tracker notify("die");
  return msg;
}

waittill_any(string1, string2, string3, string4, string5) {
  assert(isDefined(string1));

  if(isDefined(string2))
    self endon(string2);

  if(isDefined(string3))
    self endon(string3);

  if(isDefined(string4))
    self endon(string4);

  if(isDefined(string5))
    self endon(string5);

  self waittill(string1);
}

waittill_multiple(string1, string2, string3, string4, string5) {
  self endon("death");
  ent = spawnstruct();
  ent.threads = 0;

  if(isDefined(string1)) {
    self thread waittill_string(string1, ent);
    ent.threads++;
  }

  if(isDefined(string2)) {
    self thread waittill_string(string2, ent);
    ent.threads++;
  }

  if(isDefined(string3)) {
    self thread waittill_string(string3, ent);
    ent.threads++;
  }

  if(isDefined(string4)) {
    self thread waittill_string(string4, ent);
    ent.threads++;
  }

  if(isDefined(string5)) {
    self thread waittill_string(string5, ent);
    ent.threads++;
  }

  while(ent.threads) {
    ent waittill("returned");
    ent.threads--;
  }

  ent notify("die");
}

within_fov(start_origin, start_angles, end_origin, fov) {
  normal = vectornormalize(end_origin - start_origin);
  forward = anglestoforward(start_angles);
  dot = vectordot(forward, normal);
  return dot >= fov;
}

setfootstepeffect(name, fx, species) {
  assert(isDefined(name), "Need to define the footstep surface type.");
  assert(isDefined(fx), "Need to define the footstep effect.");

  if(!isDefined(species))
    species = "human";

  level._effect[species]["step_" + name] = fx;
}

getexploderid(ent) {
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

reportexploderids() {
  if(!isDefined(level._exploder_ids)) {
    return;
  }
  keys = getarraykeys(level._exploder_ids);
}

initlocalplayers() {
  level.localplayers = getlocalplayers();
}

init_exploders() {
  script_exploders = [];
  ents = getstructarray("script_brushmodel", "classname");
  smodels = getstructarray("script_model", "classname");

  for(i = 0; i < smodels.size; i++)
    ents[ents.size] = smodels[i];

  for(i = 0; i < ents.size; i++) {
    if(isDefined(ents[i].script_prefab_exploder))
      ents[i].script_exploder = ents[i].script_prefab_exploder;
  }

  potentialexploders = getstructarray("script_brushmodel", "classname");

  for(i = 0; i < potentialexploders.size; i++) {
    if(isDefined(potentialexploders[i].script_prefab_exploder))
      potentialexploders[i].script_exploder = potentialexploders[i].script_prefab_exploder;

    if(isDefined(potentialexploders[i].script_exploder))
      script_exploders[script_exploders.size] = potentialexploders[i];
  }

  potentialexploders = getstructarray("script_model", "classname");

  for(i = 0; i < potentialexploders.size; i++) {
    if(isDefined(potentialexploders[i].script_prefab_exploder))
      potentialexploders[i].script_exploder = potentialexploders[i].script_prefab_exploder;

    if(isDefined(potentialexploders[i].script_exploder))
      script_exploders[script_exploders.size] = potentialexploders[i];
  }

  for(i = 0; i < level.struct.size; i++) {
    if(isDefined(level.struct[i].script_prefab_exploder))
      level.struct[i].script_exploder = level.struct[i].script_prefab_exploder;

    if(isDefined(level.struct[i].script_exploder))
      script_exploders[script_exploders.size] = level.struct[i];
  }

  if(!isDefined(level.createfxent))
    level.createfxent = [];

  acceptabletargetnames = [];
  acceptabletargetnames["exploderchunk visible"] = 1;
  acceptabletargetnames["exploderchunk"] = 1;
  acceptabletargetnames["exploder"] = 1;
  exploder_id = 1;

  for(i = 0; i < script_exploders.size; i++) {
    exploder = script_exploders[i];
    ent = createexploder(exploder.script_fxid);
    ent.v = [];
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

    if(!isDefined(exploder.script_fxid))
      ent.v["fxid"] = "No FX";
    else
      ent.v["fxid"] = exploder.script_fxid;

    ent.v["exploder"] = exploder.script_exploder;

    if(!isDefined(ent.v["delay"]))
      ent.v["delay"] = 0;

    if(isDefined(exploder.script_sound))
      ent.v["soundalias"] = exploder.script_sound;
    else if(ent.v["fxid"] != "No FX") {
      if(isDefined(level.scr_sound) && isDefined(level.scr_sound[ent.v["fxid"]]))
        ent.v["soundalias"] = level.scr_sound[ent.v["fxid"]];
    }

    fixup_set = 0;

    if(isDefined(ent.v["target"])) {
      ent.needs_fixup = exploder_id;
      exploder_id++;
      fixup_set = 1;
      temp_ent = getstruct(ent.v["target"], "targetname");

      if(isDefined(temp_ent))
        org = temp_ent.origin;

      if(isDefined(org))
        ent.v["angles"] = vectortoangles(org - ent.v["origin"]);

      if(isDefined(ent.v["angles"]))
        ent set_forward_and_up_vectors();
    }

    if(isDefined(exploder.classname) && exploder.classname == "script_brushmodel" || isDefined(exploder.model)) {
      ent.model = exploder;

      if(fixup_set == 0) {
        ent.needs_fixup = exploder_id;
        exploder_id++;
      }
    }

    if(isDefined(exploder.targetname) && isDefined(acceptabletargetnames[exploder.targetname])) {
      ent.v["exploder_type"] = exploder.targetname;
      continue;
    }

    ent.v["exploder_type"] = "normal";
  }

  level.createfxexploders = [];

  for(i = 0; i < level.createfxent.size; i++) {
    ent = level.createfxent[i];

    if(ent.v["type"] != "exploder") {
      continue;
    }
    ent.v["exploder_id"] = getexploderid(ent);

    if(!isDefined(level.createfxexploders[ent.v["exploder"]]))
      level.createfxexploders[ent.v["exploder"]] = [];

    level.createfxexploders[ent.v["exploder"]][level.createfxexploders[ent.v["exploder"]].size] = ent;
  }

  reportexploderids();
}

playfx_for_all_local_clients(fx_id, pos, forward_vec, up_vec) {
  localplayers = level.localplayers;

  if(isDefined(up_vec)) {
    for(i = 0; i < localplayers.size; i++)
      playfx(i, fx_id, pos, forward_vec, up_vec);
  } else if(isDefined(forward_vec)) {
    for(i = 0; i < localplayers.size; i++)
      playfx(i, fx_id, pos, forward_vec);
  } else {
    for(i = 0; i < localplayers.size; i++)
      playfx(i, fx_id, pos);
  }
}

play_sound_on_client(sound_alias) {
  players = level.localplayers;
  playsound(0, sound_alias, players[0].origin);
}

loop_sound_on_client(sound_alias, min_delay, max_delay, end_on) {
  players = level.localplayers;

  if(isDefined(end_on))
    level endon(end_on);

  for(;;) {
    play_sound_on_client(sound_alias);
    wait(min_delay + randomfloat(max_delay));
  }
}

add_listen_thread(wait_till, func, param1, param2, param3, param4, param5) {
  level thread add_listen_thread_internal(wait_till, func, param1, param2, param3, param4, param5);
}

add_listen_thread_internal(wait_till, func, param1, param2, param3, param4, param5) {
  for(;;) {
    level waittill(wait_till);
    single_thread(level, func, param1, param2, param3, param4, param5);
  }
}

addlightningexploder(num) {
  if(!isDefined(level.lightningexploder)) {
    level.lightningexploder = [];
    level.lightningexploderindex = 0;
  }

  level.lightningexploder[level.lightningexploder.size] = num;
}

is_plane() {
  if(self.vehicleclass == "plane")
    return true;

  return false;
}

is_boat() {
  if(self.vehicleclass == "boat")
    return true;

  return false;
}

is_mig() {
  if(self.vehicletype == "plane_mig17" || self.vehicletype == "plane_mig21")
    return true;

  return false;
}

is_helicopter() {
  if(self.vehicleclass == "helicopter")
    return true;

  return false;
}

is_tank() {
  if(self.vehicleclass == "tank")
    return true;

  return false;
}

is_artillery() {
  if(self.vehicleclass == "artillery")
    return true;

  return false;
}

is_4wheel() {
  if(self.vehicleclass == "4 wheel")
    return true;

  return false;
}

add_trigger_to_ent(ent, trig) {
  if(!isDefined(ent._triggers))
    ent._triggers = [];

  ent._triggers[trig getentitynumber()] = 1;
}

remove_trigger_from_ent(ent, trig) {
  if(!isDefined(ent._triggers)) {
    return;
  }
  if(!isDefined(ent._triggers[trig getentitynumber()])) {
    return;
  }
  ent._triggers[trig getentitynumber()] = 0;
}

ent_already_in_trigger(trig) {
  if(!isDefined(self._triggers))
    return false;

  if(!isDefined(self._triggers[trig getentitynumber()]))
    return false;

  if(!self._triggers[trig getentitynumber()])
    return false;

  return true;
}

trigger_thread(ent, on_enter_payload, on_exit_payload) {
  ent endon("entityshutdown");
  ent endon("death");

  if(ent ent_already_in_trigger(self)) {
    return;
  }
  add_trigger_to_ent(ent, self);

  if(isDefined(on_enter_payload))
    [[on_enter_payload]](ent);

  while(isDefined(ent) && ent istouching(self))
    wait 0.01;

  if(ent isplayer()) {
    while(!clienthassnapshot(0))
      wait 0.01;
  }

  if(isDefined(ent) && isDefined(on_exit_payload))
    [[on_exit_payload]](ent);

  if(isDefined(ent))
    remove_trigger_from_ent(ent, self);
}

remove_triggers_from_ent(ent) {
  if(isDefined(ent._triggers))
    ent._triggers = [];
}

notify_delay(snotifystring, fdelay) {
  assert(isDefined(self));
  assert(isDefined(snotifystring));
  assert(isDefined(fdelay));
  assert(fdelay > 0);
  self endon("death");
  wait(fdelay);

  if(!isDefined(self)) {
    return;
  }
  self notify(snotifystring);
}

onplayerconnect_callback(func) {
  clientscripts\_callbacks::addcallback("on_player_connect", func);
}

set_player_viewmodel(viewmodel) {
  level.player_viewmodel = viewmodel;
}

spawn_player_arms() {
  arms = spawn(self getlocalclientnumber(), self getorigin() + vectorscale((0, 0, -1), 1000.0), "script_model");

  if(isDefined(level.player_viewmodel))
    arms setmodel(level.player_viewmodel);
  else
    arms setmodel("c_usa_cia_masonjr_viewhands");

  return arms;
}

get_eye() {
  if(self isplayer()) {
    linked_ent = self getlinkedent();

    if(isDefined(linked_ent) && getdvarint(#"_id_5AEFD7E9") > 0) {
      camera = linked_ent gettagorigin("tag_camera");

      if(isDefined(camera))
        return camera;
    }
  }

  pos = self geteye();
  return pos;
}

clamp(val, val_min, val_max) {
  if(val < val_min)
    val = val_min;
  else if(val > val_max)
    val = val_max;

  return val;
}

waittill_either(msg1, msg2) {
  self endon(msg1);
  self waittill(msg2);
}

is_valid_type_for_callback(type) {
  switch (type) {
    case "NA":
    case "actor":
    case "general":
    case "helicopter":
    case "missile":
    case "plane":
    case "player":
    case "scriptmover":
    case "turret":
    case "vehicle":
      return true;
    default:
      return false;
  }
}

register_clientflag_callback(type, flag, function) {
  if(!is_valid_type_for_callback(type)) {
    assertmsg(type + " is not a valid entity type to have a callback function registered.");

    return;
  }

  if(isDefined(level._client_flag_callbacks[type][flag])) {
    if(level._client_flag_callbacks[type][flag] == function) {
      return;
    }
    println("*** Free client flags for type " + type);
    free = "";

    for(i = 0; i < 16; i++) {
      if(!isDefined(level._client_flag_callbacks[type][i]))
        free = free + (i + " ");
    }

    if(free == "")
      free = "No free flags.";

    println("*** " + free);

    assertmsg("Flag " + flag + " is already registered for ent type " + type + ".Please use a different flag number.See console for list of free flags for this type.");

    return;
  }

  level._client_flag_callbacks[type][flag] = function;
}

is_mature() {
  if(level.onlinegame)
    return 1;

  return ismaturecontentenabled();
}

is_german_build() {
  if(getdvar(#"language") == "german")
    return true;

  return false;
}

getdvarfloatdefault(dvarname, defaultvalue) {
  value = getdvar(dvarname);

  if(value != "")
    return float(value);

  return defaultvalue;
}

getdvarintdefault(dvarname, defaultvalue) {
  value = getdvar(dvarname);

  if(value != "")
    return int(value);

  return defaultvalue;
}

isdumbrocketlauncherweapon(weapon) {
  switch (weapon) {
    case "m220_tow_sp":
    case "metalstorm_launcher":
    case "rpg_sp":
    case "usrpg_sp":
      return true;
    default:
      return false;
  }
}

new_timer() {
  s_timer = spawnstruct();
  s_timer.n_time_created = getrealtime();
  return s_timer;
}

get_time() {
  t_now = getrealtime();
  return t_now - self.n_time_created;
}

get_time_in_seconds() {
  return get_time() / 1000;
}

timer_wait(n_wait) {
  wait(n_wait);
  return get_time_in_seconds();
}

lerp_shader_constant(localclientnum, n_index, str_constant, n_trans_time, n_step, n_val_x, n_val_y, n_val_z, n_val_w) {
  if(!isDefined(n_step))
    n_step = 0.01;

  self notify("_lerp_shader_constant_" + str_constant);
  self endon("_lerp_shader_constant_" + str_constant);
  shader = init_shader_constant(localclientnum, n_index, str_constant);
  n_start_x = shader.x;
  n_start_y = shader.y;
  n_start_z = shader.z;
  n_start_w = shader.w;
  n_trans_time_x = isDefined(n_val_x) ? n_trans_time * abs(n_val_x - n_start_x) : 0;
  n_trans_time_y = isDefined(n_val_y) ? n_trans_time * abs(n_val_y - n_start_y) : 0;
  n_trans_time_z = isDefined(n_val_z) ? n_trans_time * abs(n_val_z - n_start_z) : 0;
  n_trans_time_w = isDefined(n_val_w) ? n_trans_time * abs(n_val_w - n_start_w) : 0;
  timer = new_timer();

  do {
    n_time = timer timer_wait(n_step);

    if(isDefined(self)) {
      if(n_trans_time_x > 0)
        shader.x = lerpfloat(n_start_x, n_val_x, n_time / n_trans_time_x);

      if(n_trans_time_y > 0)
        shader.y = lerpfloat(n_start_y, n_val_y, n_time / n_trans_time_y);

      if(n_trans_time_z > 0)
        shader.z = lerpfloat(n_start_z, n_val_z, n_time / n_trans_time_z);

      if(n_trans_time_w > 0)
        shader.w = lerpfloat(n_start_w, n_val_w, n_time / n_trans_time_w);

      self setshaderconstant(localclientnum, n_index, shader.x, shader.y, shader.z, shader.w);
    }
  }
  while(n_time < n_trans_time_x || n_time < n_trans_time_y || n_time < n_trans_time_z || n_time < n_trans_time_w);
}

init_shader_constant(localclientnum, n_index, str_constant) {
  if(!isDefined(self.shaders))
    self.shaders = [];

  if(!isDefined(self.shaders[str_constant]))
    self.shaders[str_constant] = spawnstruct();

  if(!isDefined(self.shaders[str_constant].x))
    self.shaders[str_constant].x = 0;

  if(!isDefined(self.shaders[str_constant].y))
    self.shaders[str_constant].y = 0;

  if(!isDefined(self.shaders[str_constant].z))
    self.shaders[str_constant].z = 0;

  if(!isDefined(self.shaders[str_constant].w))
    self.shaders[str_constant].w = 0;

  self mapshaderconstant(localclientnum, n_index, str_constant);
  return self.shaders[str_constant];
}

init_lighting_pairs() {
  register_clientflag_callback("scriptmover", 15, ::set_lighting_ent);
  register_clientflag_callback("scriptmover", 7, ::use_lighting_ent);
  register_clientflag_callback("actor", 15, ::set_lighting_ent);
  register_clientflag_callback("actor", 7, ::use_lighting_ent);
  register_clientflag_callback("vehicle", 15, ::set_lighting_ent);
  register_clientflag_callback("vehicle", 7, ::use_lighting_ent);
}

set_lighting_ent(localclientnum, set, newent) {
  level.light_entity = self;
}

use_lighting_ent(localclientnum, set, newent) {
  if(set)
    self setlightingentity(level.light_entity);
  else
    self setlightingentity(self);
}

lerp_dvar(str_dvar, n_start_val, n_end_val, n_lerp_time, b_saved_dvar, b_client_dvar, n_client) {
  if(!isDefined(n_client))
    n_client = 0;

  if(!isDefined(n_start_val))
    n_start_val = getdvarfloat(str_dvar);

  s_timer = new_timer();

  do {
    n_time_delta = s_timer timer_wait(0.01666);
    n_curr_val = lerpfloat(n_start_val, n_end_val, n_time_delta / n_lerp_time);

    if(isDefined(b_saved_dvar) && b_saved_dvar) {
      setsaveddvar(str_dvar, n_curr_val);
      continue;
    }

    if(isDefined(b_client_dvar) && b_client_dvar) {
      setclientdvar(n_client, str_dvar, n_curr_val);
      continue;
    }

    setdvarfloat(str_dvar, n_curr_val);
  }
  while(n_time_delta < n_lerp_time);
}