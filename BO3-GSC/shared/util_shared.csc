/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\util_shared.csc
*************************************************/

#using scripts\shared\flagsys_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#namespace util;

function empty(a, b, c, d, e) {}

function waitforallclients() {
  localclient = 0;
  if(!isDefined(level.localplayers)) {
    while(!isDefined(level.localplayers)) {
      wait(0.016);
    }
  }
  while(level.localplayers.size <= 0) {
    wait(0.016);
  }
  while(localclient < level.localplayers.size) {
    waitforclient(localclient);
    localclient++;
  }
}

function waitforclient(client) {
  while(!clienthassnapshot(client)) {
    wait(0.016);
  }
}

function get_dvar_float_default(str_dvar, default_val) {
  value = getdvarstring(str_dvar);
  return (value != "" ? float(value) : default_val);
}

function get_dvar_int_default(str_dvar, default_val) {
  value = getdvarstring(str_dvar);
  return (value != "" ? int(value) : default_val);
}

function spawn_model(n_client, str_model, origin = (0, 0, 0), angles = (0, 0, 0)) {
  model = spawn(n_client, origin, "script_model");
  model setModel(str_model);
  model.angles = angles;
  return model;
}

function waittill_string(msg, ent) {
  if(msg != "entityshutdown") {
    self endon("entityshutdown");
  }
  ent endon("die");
  self waittill(msg);
  ent notify("returned", msg);
}

function waittill_multiple(...) {
  s_tracker = spawnStruct();
  s_tracker._wait_count = 0;
  for(i = 0; i < vararg.size; i++) {
    self thread _waitlogic(s_tracker, vararg[i]);
  }
  if(s_tracker._wait_count > 0) {
    s_tracker waittill("waitlogic_finished");
  }
}

function waittill_multiple_ents(...) {
  a_ents = [];
  a_notifies = [];
  for(i = 0; i < vararg.size; i++) {
    if(i % 2) {
      if(!isDefined(a_notifies)) {
        a_notifies = [];
      } else if(!isarray(a_notifies)) {
        a_notifies = array(a_notifies);
      }
      a_notifies[a_notifies.size] = vararg[i];
      continue;
    }
    if(!isDefined(a_ents)) {
      a_ents = [];
    } else if(!isarray(a_ents)) {
      a_ents = array(a_ents);
    }
    a_ents[a_ents.size] = vararg[i];
  }
  s_tracker = spawnStruct();
  s_tracker._wait_count = 0;
  for(i = 0; i < a_ents.size; i++) {
    ent = a_ents[i];
    if(isDefined(ent)) {
      ent thread _waitlogic(s_tracker, a_notifies[i]);
    }
  }
  if(s_tracker._wait_count > 0) {
    s_tracker waittill("waitlogic_finished");
  }
}

function _waitlogic(s_tracker, notifies) {
  s_tracker._wait_count++;
  if(!isDefined(notifies)) {
    notifies = [];
  } else if(!isarray(notifies)) {
    notifies = array(notifies);
  }
  notifies[notifies.size] = "entityshutdown";
  waittill_any_array(notifies);
  s_tracker._wait_count--;
  if(s_tracker._wait_count == 0) {
    s_tracker notify("waitlogic_finished");
  }
}

function waittill_any_return(string1, string2, string3, string4, string5, string6, string7) {
  if(!isDefined(string1) || string1 != "entityshutdown" && (!isDefined(string2) || string2 != "entityshutdown") && (!isDefined(string3) || string3 != "entityshutdown") && (!isDefined(string4) || string4 != "entityshutdown") && (!isDefined(string5) || string5 != "entityshutdown") && (!isDefined(string6) || string6 != "entityshutdown") && (!isDefined(string7) || string7 != "entityshutdown")) {
    self endon("entityshutdown");
  }
  ent = spawnStruct();
  if(isDefined(string1)) {
    self thread waittill_string(string1, ent);
  }
  if(isDefined(string2)) {
    self thread waittill_string(string2, ent);
  }
  if(isDefined(string3)) {
    self thread waittill_string(string3, ent);
  }
  if(isDefined(string4)) {
    self thread waittill_string(string4, ent);
  }
  if(isDefined(string5)) {
    self thread waittill_string(string5, ent);
  }
  if(isDefined(string6)) {
    self thread waittill_string(string6, ent);
  }
  if(isDefined(string7)) {
    self thread waittill_string(string7, ent);
  }
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_ex(...) {
  s_common = spawnStruct();
  e_current = self;
  n_arg_index = 0;
  if(strisnumber(vararg[0])) {
    n_timeout = vararg[0];
    n_arg_index++;
    if(n_timeout > 0) {
      s_common thread _timeout(n_timeout);
    }
  }
  if(isarray(vararg[n_arg_index])) {
    a_params = vararg[n_arg_index];
    n_start_index = 0;
  } else {
    a_params = vararg;
    n_start_index = n_arg_index;
  }
  for(i = n_start_index; i < a_params.size; i++) {
    if(!isstring(a_params[i])) {
      e_current = a_params[i];
      continue;
    }
    if(isDefined(e_current)) {
      e_current thread waittill_string(a_params[i], s_common);
    }
  }
  s_common waittill("returned", str_notify);
  s_common notify("die");
  return str_notify;
}

function waittill_any_array_return(a_notifies) {
  if(isinarray(a_notifies, "entityshutdown")) {
    self endon("entityshutdown");
  }
  s_tracker = spawnStruct();
  foreach(str_notify in a_notifies) {
    if(isDefined(str_notify)) {
      self thread waittill_string(str_notify, s_tracker);
    }
  }
  s_tracker waittill("returned", msg);
  s_tracker notify("die");
  return msg;
}

function waittill_any(str_notify1, str_notify2, str_notify3, str_notify4, str_notify5) {
  assert(isDefined(str_notify1));
  waittill_any_array(array(str_notify1, str_notify2, str_notify3, str_notify4, str_notify5));
}

function waittill_any_array(a_notifies) {
  assert(isDefined(a_notifies[0]), "");
  for(i = 1; i < a_notifies.size; i++) {
    if(isDefined(a_notifies[i])) {
      self endon(a_notifies[i]);
    }
  }
  self waittill(a_notifies[0]);
}

function waittill_any_timeout(n_timeout, string1, string2, string3, string4, string5) {
  if(!isDefined(string1) || string1 != "entityshutdown" && (!isDefined(string2) || string2 != "entityshutdown") && (!isDefined(string3) || string3 != "entityshutdown") && (!isDefined(string4) || string4 != "entityshutdown") && (!isDefined(string5) || string5 != "entityshutdown")) {
    self endon("entityshutdown");
  }
  ent = spawnStruct();
  if(isDefined(string1)) {
    self thread waittill_string(string1, ent);
  }
  if(isDefined(string2)) {
    self thread waittill_string(string2, ent);
  }
  if(isDefined(string3)) {
    self thread waittill_string(string3, ent);
  }
  if(isDefined(string4)) {
    self thread waittill_string(string4, ent);
  }
  if(isDefined(string5)) {
    self thread waittill_string(string5, ent);
  }
  ent thread _timeout(n_timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function _timeout(delay) {
  self endon("die");
  wait(delay);
  self notify("returned", "timeout");
}

function waittill_notify_or_timeout(msg, timer) {
  self endon(msg);
  wait(timer);
}

function waittill_any_ents(ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7) {
  assert(isDefined(ent1));
  assert(isDefined(string1));
  if(isDefined(ent2) && isDefined(string2)) {
    ent2 endon(string2);
  }
  if(isDefined(ent3) && isDefined(string3)) {
    ent3 endon(string3);
  }
  if(isDefined(ent4) && isDefined(string4)) {
    ent4 endon(string4);
  }
  if(isDefined(ent5) && isDefined(string5)) {
    ent5 endon(string5);
  }
  if(isDefined(ent6) && isDefined(string6)) {
    ent6 endon(string6);
  }
  if(isDefined(ent7) && isDefined(string7)) {
    ent7 endon(string7);
  }
  ent1 waittill(string1);
}

function waittill_any_ents_two(ent1, string1, ent2, string2) {
  assert(isDefined(ent1));
  assert(isDefined(string1));
  if(isDefined(ent2) && isDefined(string2)) {
    ent2 endon(string2);
  }
  ent1 waittill(string1);
}

function single_func(entity = level, func, arg1, arg2, arg3, arg4, arg5, arg6) {
  if(isDefined(arg6)) {
    return entity[[func]](arg1, arg2, arg3, arg4, arg5, arg6);
  }
  if(isDefined(arg5)) {
    return entity[[func]](arg1, arg2, arg3, arg4, arg5);
  }
  if(isDefined(arg4)) {
    return entity[[func]](arg1, arg2, arg3, arg4);
  }
  if(isDefined(arg3)) {
    return entity[[func]](arg1, arg2, arg3);
  }
  if(isDefined(arg2)) {
    return entity[[func]](arg1, arg2);
  }
  if(isDefined(arg1)) {
    return entity[[func]](arg1);
  }
  return entity[[func]]();
}

function new_func(func, arg1, arg2, arg3, arg4, arg5, arg6) {
  s_func = spawnStruct();
  s_func.func = func;
  s_func.arg1 = arg1;
  s_func.arg2 = arg2;
  s_func.arg3 = arg3;
  s_func.arg4 = arg4;
  s_func.arg5 = arg5;
  s_func.arg6 = arg6;
  return s_func;
}

function call_func(s_func) {
  return single_func(self, s_func.func, s_func.arg1, s_func.arg2, s_func.arg3, s_func.arg4, s_func.arg5, s_func.arg6);
}

function array_ent_thread(entities, func, arg1, arg2, arg3, arg4, arg5) {
  assert(isDefined(entities), "");
  assert(isDefined(func), "");
  if(isarray(entities)) {
    if(entities.size) {
      keys = getarraykeys(entities);
      for(i = 0; i < keys.size; i++) {
        single_thread(self, func, entities[keys[i]], arg1, arg2, arg3, arg4, arg5);
      }
    }
  } else {
    single_thread(self, func, entities, arg1, arg2, arg3, arg4, arg5);
  }
}

function single_thread(entity, func, arg1, arg2, arg3, arg4, arg5, arg6) {
  assert(isDefined(entity), "");
  if(isDefined(arg6)) {
    entity thread[[func]](arg1, arg2, arg3, arg4, arg5, arg6);
  } else {
    if(isDefined(arg5)) {
      entity thread[[func]](arg1, arg2, arg3, arg4, arg5);
    } else {
      if(isDefined(arg4)) {
        entity thread[[func]](arg1, arg2, arg3, arg4);
      } else {
        if(isDefined(arg3)) {
          entity thread[[func]](arg1, arg2, arg3);
        } else {
          if(isDefined(arg2)) {
            entity thread[[func]](arg1, arg2);
          } else {
            if(isDefined(arg1)) {
              entity thread[[func]](arg1);
            } else {
              entity thread[[func]]();
            }
          }
        }
      }
    }
  }
}

function add_listen_thread(wait_till, func, param1, param2, param3, param4, param5) {
  level thread add_listen_thread_internal(wait_till, func, param1, param2, param3, param4, param5);
}

function add_listen_thread_internal(wait_till, func, param1, param2, param3, param4, param5) {
  for(;;) {
    level waittill(wait_till);
    single_thread(level, func, param1, param2, param3, param4, param5);
  }
}

function timeout(n_time, func, arg1, arg2, arg3, arg4, arg5, arg6) {
  self endon("entityshutdown");
  if(isDefined(n_time)) {
    __s = spawnStruct();
    __s endon("timeout");
    __s delay_notify(n_time, "timeout");
  }
  single_func(self, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

function delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
  self thread _delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

function _delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
  self endon("entityshutdown");
  if(isDefined(str_endon)) {
    self endon(str_endon);
  }
  if(isstring(time_or_notify)) {
    self waittill(time_or_notify);
  } else {
    wait(time_or_notify);
  }
  single_func(self, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

function delay_notify(time_or_notify, str_notify, str_endon) {
  self thread _delay_notify(time_or_notify, str_notify, str_endon);
}

function _delay_notify(time_or_notify, str_notify, str_endon) {
  self endon("entityshutdown");
  if(isDefined(str_endon)) {
    self endon(str_endon);
  }
  if(isstring(time_or_notify)) {
    self waittill(time_or_notify);
  } else {
    wait(time_or_notify);
  }
  self notify(str_notify);
}

function new_timer(n_timer_length) {
  s_timer = spawnStruct();
  s_timer.n_time_created = gettime();
  s_timer.n_length = n_timer_length;
  return s_timer;
}

function get_time() {
  t_now = gettime();
  return t_now - self.n_time_created;
}

function get_time_in_seconds() {
  return get_time() / 1000;
}

function get_time_frac(n_end_time = self.n_length) {
  return lerpfloat(0, 1, get_time_in_seconds() / n_end_time);
}

function get_time_left() {
  if(isDefined(self.n_length)) {
    n_current_time = get_time_in_seconds();
    return max(self.n_length - n_current_time, 0);
  }
  return -1;
}

function is_time_left() {
  return get_time_left() != 0;
}

function timer_wait(n_wait) {
  if(isDefined(self.n_length)) {
    n_wait = min(n_wait, get_time_left());
  }
  wait(n_wait);
  n_current_time = get_time_in_seconds();
  return n_current_time;
}

function add_remove_list( & a = [], on_off) {
  if(on_off) {
    if(!isinarray(a, self)) {
      arrayinsert(a, self, a.size);
    }
  } else {
    arrayremovevalue(a, self, 0);
  }
}

function clean_deleted( & array) {
  done = 0;
  while(!done && array.size > 0) {
    done = 1;
    foreach(key, val in array) {
      if(!isDefined(val)) {
        arrayremoveindex(array, key, 0);
        done = 0;
        break;
      }
    }
  }
}

function get_eye() {
  if(sessionmodeiscampaigngame()) {
    if(self isplayer()) {
      linked_ent = self getlinkedent();
      if(isDefined(linked_ent) && getdvarint("cg_cameraUseTagCamera") > 0) {
        camera = linked_ent gettagorigin("tag_camera");
        if(isDefined(camera)) {
          return camera;
        }
      }
    }
  }
  pos = self getEye();
  return pos;
}

function spawn_player_arms() {
  arms = spawn(self getlocalclientnumber(), self.origin + (vectorscale((0, 0, -1), 1000)), "script_model");
  if(isDefined(level.player_viewmodel)) {
    arms setModel(level.player_viewmodel);
  } else {
    arms setModel("c_usa_cia_masonjr_viewhands");
  }
  return arms;
}

function lerp_dvar(str_dvar, n_start_val = getdvarfloat(str_dvar), n_end_val, n_lerp_time, b_saved_dvar, b_client_dvar, n_client = 0) {
  s_timer = new_timer();
  do {
    n_time_delta = s_timer timer_wait(0.01666);
    n_curr_val = lerpfloat(n_start_val, n_end_val, n_time_delta / n_lerp_time);
    if(isDefined(b_saved_dvar) && b_saved_dvar) {
      setsaveddvar(str_dvar, n_curr_val);
    } else {
      setdvar(str_dvar, n_curr_val);
    }
  }
  while(n_time_delta < n_lerp_time);
}

function is_valid_type_for_callback(type) {
  switch (type) {
    case "NA":
    case "actor":
    case "general":
    case "helicopter":
    case "missile":
    case "plane":
    case "player":
    case "scriptmover":
    case "trigger":
    case "turret":
    case "vehicle": {
      return true;
    }
    default: {
      return false;
    }
  }
}

function wait_till_not_touching(e_to_check, e_to_touch) {
  assert(isDefined(e_to_check), "");
  assert(isDefined(e_to_touch), "");
  e_to_check endon("entityshutdown");
  e_to_touch endon("entityshutdown");
  while(e_to_check istouching(e_to_touch)) {
    wait(0.05);
  }
}

function error(message) {
  println("", message);
  wait(0.05);
}

function register_system(ssysname, cbfunc) {
  if(!isDefined(level._systemstates)) {
    level._systemstates = [];
  }
  if(level._systemstates.size >= 32) {
    error("");
    return;
  }
  if(isDefined(level._systemstates[ssysname])) {
    error("" + ssysname);
    return;
  }
  level._systemstates[ssysname] = spawnStruct();
  level._systemstates[ssysname].callback = cbfunc;
}

function field_set_lighting_ent(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level.light_entity = self;
}

function field_use_lighting_ent(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}

function waittill_dobj(localclientnum) {
  while(isDefined(self) && !self hasdobj(localclientnum)) {
    wait(0.016);
  }
}

function server_wait(localclientnum, seconds, waitbetweenchecks, level_endon) {
  if(isDefined(level_endon)) {
    level endon(level_endon);
  }
  if(level.isdemoplaying && seconds != 0) {
    if(!isDefined(waitbetweenchecks)) {
      waitbetweenchecks = 0.2;
    }
    waitcompletedsuccessfully = 0;
    starttime = level.servertime;
    lasttime = starttime;
    endtime = starttime + (seconds * 1000);
    while(level.servertime < endtime && level.servertime >= lasttime) {
      lasttime = level.servertime;
      wait(waitbetweenchecks);
    }
    if(lasttime < level.servertime) {
      waitcompletedsuccessfully = 1;
    }
  } else {
    waitrealtime(seconds);
    waitcompletedsuccessfully = 1;
  }
  return waitcompletedsuccessfully;
}

function friend_not_foe(localclientindex, predicted) {
  player = getnonpredictedlocalplayer(localclientindex);
  if(isDefined(predicted) && predicted || (isDefined(player) && isDefined(player.team) && player.team == "spectator")) {
    player = getlocalplayer(localclientindex);
  }
  if(isDefined(player) && isDefined(player.team)) {
    team = player.team;
    if(team == "free") {
      owner = self getowner(localclientindex);
      if(isDefined(owner) && owner == player) {
        return true;
      }
    } else if(self.team == team) {
      return true;
    }
  }
  return false;
}

function friend_not_foe_team(localclientindex, team, predicted) {
  player = getnonpredictedlocalplayer(localclientindex);
  if(isDefined(predicted) && predicted || (isDefined(player) && isDefined(player.team) && player.team == "spectator")) {
    player = getlocalplayer(localclientindex);
  }
  if(isDefined(player) && isDefined(player.team)) {
    if(player.team == team) {
      return true;
    }
  }
  return false;
}

function isenemyplayer(player) {
  assert(isDefined(player));
  if(!player isplayer()) {
    return false;
  }
  if(player.team != "free") {
    if(player.team == self.team) {
      return false;
    }
  } else if(player == self) {
    return false;
  }
  return true;
}

function is_player_view_linked_to_entity(localclientnum) {
  if(self isdriving(localclientnum)) {
    return true;
  }
  if(self islocalplayerweaponviewonlylinked()) {
    return true;
  }
  return false;
}

function init_utility() {
  level.isdemoplaying = isdemoplaying();
  level.localplayers = [];
  level.numgametypereservedobjectives = [];
  level.releasedobjectives = [];
  maxlocalclients = getmaxlocalclients();
  for(localclientnum = 0; localclientnum < maxlocalclients; localclientnum++) {
    level.releasedobjectives[localclientnum] = [];
    level.numgametypereservedobjectives[localclientnum] = 0;
  }
  waitforclient(0);
  level.localplayers = getlocalplayers();
}

function within_fov(start_origin, start_angles, end_origin, fov) {
  normal = vectornormalize(end_origin - start_origin);
  forward = anglesToForward(start_angles);
  dot = vectordot(forward, normal);
  return dot >= fov;
}

function is_mature() {
  return ismaturecontentenabled();
}

function is_gib_restricted_build() {
  if(!(ismaturecontentenabled() && isshowgibsenabled())) {
    return true;
  }
  return false;
}

function registersystem(ssysname, cbfunc) {
  if(!isDefined(level._systemstates)) {
    level._systemstates = [];
  }
  if(level._systemstates.size >= 32) {
    error("");
    return;
  }
  if(isDefined(level._systemstates[ssysname])) {
    error("" + ssysname);
    return;
  }
  level._systemstates[ssysname] = spawnStruct();
  level._systemstates[ssysname].callback = cbfunc;
}

function getstatstablename() {
  if(sessionmodeiscampaigngame()) {
    return "gamedata/stats/cp/cp_statstable.csv";
  }
  if(sessionmodeiszombiesgame()) {
    return "gamedata/stats/zm/zm_statstable.csv";
  }
  return "gamedata/stats/mp/mp_statstable.csv";
}

function add_trigger_to_ent(ent, trig) {
  if(!isDefined(ent._triggers)) {
    ent._triggers = [];
  }
  ent._triggers[trig getentitynumber()] = 1;
}

function remove_trigger_from_ent(ent, trig) {
  if(!isDefined(ent._triggers)) {
    return;
  }
  if(!isDefined(ent._triggers[trig getentitynumber()])) {
    return;
  }
  ent._triggers[trig getentitynumber()] = 0;
}

function ent_already_in_trigger(trig) {
  if(!isDefined(self._triggers)) {
    return false;
  }
  if(!isDefined(self._triggers[trig getentitynumber()])) {
    return false;
  }
  if(!self._triggers[trig getentitynumber()]) {
    return false;
  }
  return true;
}

function trigger_thread(ent, on_enter_payload, on_exit_payload) {
  ent endon("entityshutdown");
  if(ent ent_already_in_trigger(self)) {
    return;
  }
  add_trigger_to_ent(ent, self);
  if(isDefined(on_enter_payload)) {
    [[on_enter_payload]](ent);
  }
  while(isDefined(ent) && ent istouching(self)) {
    wait(0.016);
  }
  if(isDefined(ent) && isDefined(on_exit_payload)) {
    [[on_exit_payload]](ent);
  }
  if(isDefined(ent)) {
    remove_trigger_from_ent(ent, self);
  }
}

function local_player_trigger_thread_always_exit(ent, on_enter_payload, on_exit_payload) {
  if(ent ent_already_in_trigger(self)) {
    return;
  }
  add_trigger_to_ent(ent, self);
  if(isDefined(on_enter_payload)) {
    [[on_enter_payload]](ent);
  }
  while(isDefined(ent) && ent istouching(self) && ent issplitscreenhost()) {
    wait(0.016);
  }
  if(isDefined(on_exit_payload)) {
    [[on_exit_payload]](ent);
  }
  if(isDefined(ent)) {
    remove_trigger_from_ent(ent, self);
  }
}

function local_player_entity_thread(localclientnum, entity, func, arg1, arg2, arg3, arg4) {
  entity endon("entityshutdown");
  entity waittill_dobj(localclientnum);
  single_thread(entity, func, localclientnum, arg1, arg2, arg3, arg4);
}

function local_players_entity_thread(entity, func, arg1, arg2, arg3, arg4) {
  players = level.localplayers;
  for(i = 0; i < players.size; i++) {
    players[i] thread local_player_entity_thread(i, entity, func, arg1, arg2, arg3, arg4);
  }
}

function debug_line(from, to, color, time) {
  level.debug_line = getdvarint("", 0);
  if(isDefined(level.debug_line) && level.debug_line == 1) {
    if(!isDefined(time)) {
      time = 1000;
    }
    line(from, to, color, 1, 1, time);
  }
}

function debug_star(origin, color, time) {
  level.debug_star = getdvarint("", 0);
  if(isDefined(level.debug_star) && level.debug_star == 1) {
    if(!isDefined(time)) {
      time = 1000;
    }
    if(!isDefined(color)) {
      color = (1, 1, 1);
    }
    debugstar(origin, time, color);
  }
}

function servertime() {
  for(;;) {
    level.servertime = getservertime(0);
    wait(0.016);
  }
}

function getnextobjid(localclientnum) {
  nextid = 0;
  if(level.releasedobjectives[localclientnum].size > 0) {
    nextid = level.releasedobjectives[localclientnum][level.releasedobjectives[localclientnum].size - 1];
    level.releasedobjectives[localclientnum][level.releasedobjectives[localclientnum].size - 1] = undefined;
  } else {
    nextid = level.numgametypereservedobjectives[localclientnum];
    level.numgametypereservedobjectives[localclientnum]++;
  }
  if(nextid > 31) {
    println("");
  }
  assert(nextid < 32);
  if(nextid > 31) {
    nextid = 31;
  }
  return nextid;
}

function releaseobjid(localclientnum, objid) {
  assert(objid < level.numgametypereservedobjectives[localclientnum]);
  for(i = 0; i < level.releasedobjectives[localclientnum].size; i++) {
    if(objid == level.releasedobjectives[localclientnum][i]) {
      return;
    }
  }
  level.releasedobjectives[localclientnum][level.releasedobjectives[localclientnum].size] = objid;
}

function get_next_safehouse(str_next_map) {
  switch (str_next_map) {
    case "cp_mi_sing_biodomes":
    case "cp_mi_sing_blackstation":
    case "cp_mi_sing_sgen": {
      return "cp_sh_singapore";
    }
    case "cp_mi_cairo_aquifer":
    case "cp_mi_cairo_infection":
    case "cp_mi_cairo_lotus": {
      return "cp_sh_cairo";
    }
    default: {
      return "cp_sh_mobile";
    }
  }
}

function is_safehouse(str_next_map = tolower(getdvarstring("mapname"))) {
  switch (str_next_map) {
    case "cp_sh_cairo":
    case "cp_sh_mobile":
    case "cp_sh_singapore": {
      return true;
    }
    default: {
      return false;
    }
  }
}

function button_held_think(which_button) {
  self endon("disconnect");
  if(!isDefined(self._holding_button)) {
    self._holding_button = [];
  }
  self._holding_button[which_button] = 0;
  time_started = 0;
  while(true) {
    if(self._holding_button[which_button]) {
      if(!self[[level._button_funcs[which_button]]]()) {
        self._holding_button[which_button] = 0;
      }
    } else {
      if(self[[level._button_funcs[which_button]]]()) {
        if(time_started == 0) {
          time_started = gettime();
        }
        if((gettime() - time_started) > 250) {
          self._holding_button[which_button] = 1;
        }
      } else if(time_started != 0) {
        time_started = 0;
      }
    }
    wait(0.016);
  }
}

function init_button_wrappers() {
  if(!isDefined(level._button_funcs)) {
    level._button_funcs[4] = & up_button_pressed;
    level._button_funcs[5] = & down_button_pressed;
  }
}

function up_button_held() {
  init_button_wrappers();
  if(!isDefined(self._up_button_think_threaded)) {
    self thread button_held_think(4);
    self._up_button_think_threaded = 1;
  }
  return self._holding_button[4];
}

function down_button_held() {
  init_button_wrappers();
  if(!isDefined(self._down_button_think_threaded)) {
    self thread button_held_think(5);
    self._down_button_think_threaded = 1;
  }
  return self._holding_button[5];
}

function up_button_pressed() {
  return self buttonpressed("") || self buttonpressed("");
}

function waittill_up_button_pressed() {
  while(!self up_button_pressed()) {
    wait(0.05);
  }
}

function down_button_pressed() {
  return self buttonpressed("") || self buttonpressed("");
}

function waittill_down_button_pressed() {
  while(!self down_button_pressed()) {
    wait(0.05);
  }
}