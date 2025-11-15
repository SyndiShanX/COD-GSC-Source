/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\util_shared.csc
***********************************************/

#include script_72d4466ce2e2cc7b;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace util;

autoexec __init__system__() {
  system::register(#"util_shared", &__init__, undefined, undefined);
}

__init__() {
  function_73fab74d();
  register_clientfields();
  namespace_1e38a8f6::init();
}

register_clientfields() {
  clientfield::register("world", "cf_team_mapping", 1, 1, "int", &cf_team_mapping, 0, 0);
  clientfield::register("world", "preload_frontend", 1, 1, "int", &preload_frontend, 0, 0);
  clientfield::register("allplayers", "ClearStreamerLoadingHints", 1, 1, "int", &function_7d955209, 0, 0);
  clientfield::register("allplayers", "StreamerSetSpawnHintIndex", 1, 4, "int", &function_4fdf4063, 1, 0);
}

function_7d955209(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!self function_21c0fa55()) {
    return;
  }

  if(newval) {
    clearstreamerloadinghints();
  }
}

function_4fdf4063(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!self function_21c0fa55()) {
    return;
  }

  streamersetspawnhintindex(newval);
}

empty(a, b, c, d, e) {}

waitforallclients() {
  localclient = 0;

  if(!isDefined(level.localplayers)) {
    while(!isDefined(level.localplayers)) {
      waitframe(1);
    }
  }

  while(level.localplayers.size <= 0) {
    waitframe(1);
  }

  while(localclient < level.localplayers.size) {
    waitforclient(localclient);
    localclient++;
  }
}

function_89a98f85() {
  num = getdvarint(#"splitscreen_playercount", 0);

  if(num < 1) {
    num = 1;
  }

  num = 1;

  for(localclient = 0; localclient < num; localclient++) {
    waitforclient(localclient);
  }
}

waitforclient(client) {
  while(!clienthassnapshot(client)) {
    waitframe(1);
  }
}

get_dvar_float_default(str_dvar, default_val) {
  value = getdvarstring(str_dvar);
  return value != "" ? float(value) : default_val;
}

get_dvar_int_default(str_dvar, default_val) {
  value = getdvarstring(str_dvar);
  return value != "" ? int(value) : default_val;
}

spawn_model(n_client, str_model, origin = (0, 0, 0), angles = (0, 0, 0)) {
  model = spawn(n_client, origin, "script_model");

  if(isDefined(model)) {
    model setModel(str_model);
    model.angles = angles;
  }

  return model;
}

spawn_anim_model(n_client, model_name, origin, angles) {
  model = spawn_model(n_client, model_name, origin, angles);

  if(isDefined(model)) {
    model useanimtree("generic");
    model.animtree = "generic";
  }

  return model;
}

waittill_string(msg, ent) {
  if(msg != "death") {
    self endon(#"death");
  }

  ent endon(#"die");
  self waittill(msg);
  ent notify(#"returned", {
    #msg: msg
  });
}

waittill_multiple(...) {
  s_tracker = spawnStruct();
  s_tracker._wait_count = 0;

  for(i = 0; i < vararg.size; i++) {
    self thread _waitlogic(s_tracker, vararg[i]);
  }

  if(s_tracker._wait_count > 0) {
    s_tracker waittill(#"waitlogic_finished");
  }
}

waittill_either(msg1, msg2) {
  self endon(msg1);
  self waittill(msg2);
}

waittill_multiple_ents(...) {
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
    s_tracker waittill(#"waitlogic_finished");
  }
}

_waitlogic(s_tracker, notifies) {
  s_tracker._wait_count++;

  if(!isDefined(notifies)) {
    notifies = [];
  } else if(!isarray(notifies)) {
    notifies = array(notifies);
  }

  notifies[notifies.size] = "death";
  self waittill(notifies);
  s_tracker._wait_count--;

  if(s_tracker._wait_count == 0) {
    s_tracker notify(#"waitlogic_finished");
  }
}

waittill_any_ents(ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7) {
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

function_e532f5da(n_timeout, ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5) {
  assert(isDefined(n_timeout));
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

  ent1 waittilltimeout(n_timeout, string1);
}

waittill_any_ents_two(ent1, string1, ent2, string2) {
  assert(isDefined(ent1));
  assert(isDefined(string1));

  if(isDefined(ent2) && isDefined(string2)) {
    ent2 endon(string2);
  }

  ent1 waittill(string1);
}

single_func(entity, func, ...) {
  return _single_func(entity, func, vararg);
}

single_func_argarray(entity, func, a_vars) {
  return _single_func(entity, func, a_vars);
}

_single_func(entity, func, a_vars) {
  _clean_up_arg_array(a_vars);

  switch (a_vars.size) {
    case 8:
      if(isDefined(entity)) {
        return entity[[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6], a_vars[7]);
      } else {
        return [
          [func]
        ](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6], a_vars[7]);
      }

      break;
    case 7:
      if(isDefined(entity)) {
        return entity[[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6]);
      } else {
        return [
          [func]
        ](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6]);
      }

      break;
    case 6:
      if(isDefined(entity)) {
        return entity[[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
      } else {
        return [
          [func]
        ](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
      }

      break;
    case 5:
      if(isDefined(entity)) {
        return entity[[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
      } else {
        return [
          [func]
        ](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
      }

      break;
    case 4:
      if(isDefined(entity)) {
        return entity[[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
      } else {
        return [
          [func]
        ](a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
      }

      break;
    case 3:
      if(isDefined(entity)) {
        return entity[[func]](a_vars[0], a_vars[1], a_vars[2]);
      } else {
        return [
          [func]
        ](a_vars[0], a_vars[1], a_vars[2]);
      }

      break;
    case 2:
      if(isDefined(entity)) {
        return entity[[func]](a_vars[0], a_vars[1]);
      } else {
        return [
          [func]
        ](a_vars[0], a_vars[1]);
      }

      break;
    case 1:
      if(isDefined(entity)) {
        return entity[[func]](a_vars[0]);
      } else {
        return [
          [func]
        ](a_vars[0]);
      }

      break;
    case 0:
      if(isDefined(entity)) {
        return entity[[func]]();
      } else {
        return [
          [func]
        ]();
      }

      break;
    default:
      assertmsg("<dev string:x38>");
      break;
  }
}

_clean_up_arg_array(&a_vars) {
  for(i = a_vars.size - 1; i >= 0; i--) {
    if(a_vars[i] === undefined) {
      arrayremoveindex(a_vars, i, 0);
      continue;
    }

    break;
  }
}

new_func(func, arg1, arg2, arg3, arg4, arg5, arg6) {
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

call_func(s_func) {
  return single_func(self, s_func.func, s_func.arg1, s_func.arg2, s_func.arg3, s_func.arg4, s_func.arg5, s_func.arg6);
}

array_ent_thread(entities, func, arg1, arg2, arg3, arg4, arg5) {
  assert(isDefined(entities), "<dev string:x49>");
  assert(isDefined(func), "<dev string:x83>");

  if(isarray(entities)) {
    if(entities.size) {
      foreach(entity in entities) {
        single_thread(self, func, entity, arg1, arg2, arg3, arg4, arg5);
      }
    }

    return;
  }

  single_thread(self, func, entities, arg1, arg2, arg3, arg4, arg5);
}

single_thread(entity, func, arg1, arg2, arg3, arg4, arg5, arg6) {
  assert(isDefined(entity), "<dev string:xb9>");

  if(isDefined(arg6)) {
    entity thread[[func]](arg1, arg2, arg3, arg4, arg5, arg6);
    return;
  }

  if(isDefined(arg5)) {
    entity thread[[func]](arg1, arg2, arg3, arg4, arg5);
    return;
  }

  if(isDefined(arg4)) {
    entity thread[[func]](arg1, arg2, arg3, arg4);
    return;
  }

  if(isDefined(arg3)) {
    entity thread[[func]](arg1, arg2, arg3);
    return;
  }

  if(isDefined(arg2)) {
    entity thread[[func]](arg1, arg2);
    return;
  }

  if(isDefined(arg1)) {
    entity thread[[func]](arg1);
    return;
  }

  entity thread[[func]]();
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

timeout(n_time, func, arg1, arg2, arg3, arg4, arg5, arg6) {
  self endon(#"death");

  if(isDefined(n_time)) {
    __s = spawnStruct();
    __s endon(#"timeout");
    __s delay_notify(n_time, "timeout");
  }

  single_func(self, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
  self thread _delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

_delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
  self endon(#"death");

  if(isDefined(str_endon)) {
    self endon(str_endon);
  }

  if(ishash(time_or_notify) || isstring(time_or_notify)) {
    self waittill(time_or_notify);
  } else {
    wait time_or_notify;
  }

  single_func(self, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

delay_notify(time_or_notify, str_notify, str_endon) {
  self thread _delay_notify(time_or_notify, str_notify, str_endon);
}

_delay_notify(time_or_notify, str_notify, str_endon) {
  self endon(#"death");

  if(isDefined(str_endon)) {
    self endon(str_endon);
  }

  if(ishash(time_or_notify) || isstring(time_or_notify)) {
    self waittill(time_or_notify);
  } else {
    wait time_or_notify;
  }

  self notify(str_notify);
}

new_timer(n_timer_length) {
  s_timer = spawnStruct();
  s_timer.n_time_created = gettime();
  s_timer.n_length = n_timer_length;
  return s_timer;
}

get_time() {
  t_now = gettime();
  return t_now - self.n_time_created;
}

get_time_in_seconds() {
  return float(get_time()) / 1000;
}

get_time_frac(n_end_time = self.n_length) {
  return lerpfloat(0, 1, get_time_in_seconds() / n_end_time);
}

get_time_left() {
  if(isDefined(self.n_length)) {
    n_current_time = get_time_in_seconds();
    return max(self.n_length - n_current_time, 0);
  }

  return -1;
}

is_time_left() {
  return get_time_left() != 0;
}

timer_wait(n_wait) {
  if(isDefined(self.n_length)) {
    n_wait = min(n_wait, get_time_left());
  }

  wait n_wait;
  n_current_time = get_time_in_seconds();
  return n_current_time;
}

add_remove_list(&a = [], on_off) {
  if(on_off) {
    if(!isinarray(a, self)) {
      arrayinsert(a, self, a.size);
    }

    return;
  }

  arrayremovevalue(a, self, 0);
}

clean_deleted(&array) {
  arrayremovevalue(array, undefined);
}

get_eye() {
  if(sessionmodeiscampaigngame()) {
    if(isplayer(self)) {
      linked_ent = self getlinkedent();

      if(isDefined(linked_ent) && getdvarint(#"cg_camerausetagcamera", 0) > 0) {
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

spawn_player_arms() {
  arms = spawn(self getlocalclientnumber(), self.origin + (0, 0, -1000), "script_model");

  if(isDefined(level.player_viewmodel)) {
    arms setModel(level.player_viewmodel);
  } else {
    arms setModel(#"c_usa_cia_masonjr_viewhands");
  }

  return arms;
}

lerp_dvar(str_dvar, n_start_val = getdvarfloat(str_dvar, 0), n_end_val, n_lerp_time, b_saved_dvar, b_client_dvar, n_client = 0) {
  s_timer = new_timer();

  do {
    n_time_delta = s_timer timer_wait(0.01666);
    n_curr_val = lerpfloat(n_start_val, n_end_val, n_time_delta / n_lerp_time);

    if(isDefined(b_saved_dvar) && b_saved_dvar) {
      setsaveddvar(str_dvar, n_curr_val);
      continue;
    }

    setdvar(str_dvar, n_curr_val);
  }
  while(n_time_delta < n_lerp_time);
}

is_valid_type_for_callback(type) {
  switch (type) {
    case #"scriptmover":
    case #"na":
    case #"missile":
    case #"general":
    case #"player":
    case #"turret":
    case #"actor":
    case #"helicopter":
    case #"trigger":
    case #"vehicle":
    case #"plane":
      return true;
    default:
      return false;
  }
}

wait_till_not_touching(e_to_check, e_to_touch) {
  assert(isDefined(e_to_check), "<dev string:xec>");
  assert(isDefined(e_to_touch), "<dev string:x12c>");
  e_to_check endon(#"death");
  e_to_touch endon(#"death");

  while(e_to_check istouching(e_to_touch)) {
    waitframe(1);
  }
}

error(message) {
  println("<dev string:x16c>", message);
  waitframe(1);
}

register_system(ssysname, cbfunc) {
  if(!isDefined(level._systemstates)) {
    level._systemstates = [];
  }

  if(level._systemstates.size >= 32) {
    error("<dev string:x17c>");

    return;
  }

  if(isDefined(level._systemstates[ssysname])) {
    error("<dev string:x19f>" + ssysname);

    return;
  }

  level._systemstates[ssysname] = spawnStruct();
  level._systemstates[ssysname].callback = cbfunc;
}

field_set_lighting_ent(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level.light_entity = self;
}

field_use_lighting_ent(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}

waittill_dobj(localclientnum) {
  while(isDefined(self) && !self hasdobj(localclientnum)) {
    waitframe(1);
  }
}

playFXOnTag(localclientnum, effect, entity, tagname) {
  if(isDefined(entity) && entity hasdobj(localclientnum)) {
    return function_239993de(localclientnum, effect, entity, tagname);
  }

  return undefined;
}

function_6d0694af() {
  while(isDefined(self) && !self hasplayerrole()) {
    waitframe(1);
  }
}

server_wait(localclientnum, seconds, waitbetweenchecks, level_endon) {
  if(isDefined(level_endon)) {
    level endon(level_endon);
  }

  if(seconds != 0 && isdemoplaying()) {
    if(!isDefined(waitbetweenchecks)) {
      waitbetweenchecks = 0.2;
    }

    waitcompletedsuccessfully = 0;
    starttime = getservertime(0);
    lasttime = starttime;
    endtime = starttime + int(seconds * 1000);

    while(getservertime(0) < endtime && getservertime(0) >= lasttime) {
      lasttime = getservertime(0);
      wait waitbetweenchecks;
    }

    if(lasttime < getservertime(0)) {
      waitcompletedsuccessfully = 1;
    }
  } else {
    wait seconds;
    waitcompletedsuccessfully = 1;
  }

  return waitcompletedsuccessfully;
}

get_other_team(str_team) {
  if(str_team == #"allies") {
    return #"axis";
  } else if(str_team == #"axis") {
    return #"allies";
  } else {
    return #"allies";
  }

  assertmsg("<dev string:x1c9>" + str_team);
}

function_fbce7263(team_a, team_b) {
  if(team_a === team_b) {
    return false;
  }

  if(!isDefined(team_a) || !isDefined(team_b)) {
    return true;
  }

  if(function_b37afded(team_a, team_b)) {
    return false;
  }

  return true;
}

isenemyteam(team) {
  return function_fbce7263(team, self.team);
}

isenemyplayer(player) {
  assert(isDefined(player));

  if(!isplayer(player)) {
    return false;
  }

  if(player.team != "free") {
    if(player.team === self.team) {
      return false;
    }

    if(function_b37afded(player.team, self.team)) {
      return false;
    }
  } else if(player == self) {
    return false;
  }

  return true;
}

function_50ed1561(localclientnum) {
  function_89a98f85();

  if(!isDefined(self)) {
    return false;
  }

  if(!self function_21c0fa55()) {
    return false;
  }

  if(function_65b9eb0f(localclientnum)) {
    return false;
  }

  if(localclientnum !== self getlocalclientnumber()) {
    return false;
  }

  if(isDefined(level.localplayers[localclientnum]) && self getentitynumber() != level.localplayers[localclientnum] getentitynumber()) {
    return false;
  }

  return true;
}

is_player_view_linked_to_entity(localclientnum) {
  if(function_fd3d58c7(localclientnum)) {
    return true;
  }

  if(function_e75c64a4(localclientnum)) {
    return true;
  }

  return false;
}

get_start_time() {
  return getmicrosecondsraw();
}

note_elapsed_time(start_time, label = "unspecified") {
  elapsed_time = get_elapsed_time(start_time, getmicrosecondsraw());

  if(!isDefined(start_time)) {
    return;
  }

  elapsed_time *= 0.001;

  if(!isDefined(level.orbis)) {
    level.orbis = getdvarstring(#"orbisgame") == "<dev string:x1e7>";
  }

  if(!level.orbis) {
    elapsed_time = int(elapsed_time);
  }

  msg = label + "<dev string:x1ee>" + elapsed_time + "<dev string:x200>";
  profileprintln(msg);
  iprintlnbold(msg);
}

record_elapsed_time(start_time, &elapsed_time_array) {
  elapsed_time = get_elapsed_time(start_time, getmicrosecondsraw());

  if(!isDefined(elapsed_time_array)) {
    elapsed_time_array = [];
  } else if(!isarray(elapsed_time_array)) {
    elapsed_time_array = array(elapsed_time_array);
  }

  elapsed_time_array[elapsed_time_array.size] = elapsed_time;
}

note_elapsed_times(&elapsed_time_array, label = "unspecified") {
  if(!isarray(elapsed_time_array)) {
    return;
  }

  msg = label + "<dev string:x206>" + elapsed_time_array.size;
  profileprintln(msg);

  if(elapsed_time_array.size == 0) {
    return;
  }

  if(!isDefined(level.orbis)) {
    level.orbis = getdvarstring(#"orbisgame") == "<dev string:x1e7>";
  }

  total_elapsed_time = 0;
  smallest_elapsed_time = 2147483647;
  largest_elapsed_time = 0;

  foreach(elapsed_time in elapsed_time_array) {
    elapsed_time *= 0.001;
    total_elapsed_time += elapsed_time;

    if(elapsed_time < smallest_elapsed_time) {
      smallest_elapsed_time = elapsed_time;
    }

    if(elapsed_time > largest_elapsed_time) {
      largest_elapsed_time = elapsed_time;
    }

    if(!level.orbis) {
      elapsed_time = int(elapsed_time);
    }

    msg = label + "<dev string:x1ee>" + elapsed_time + "<dev string:x200>";
    profileprintln(msg);
  }

  average_elapsed_time = total_elapsed_time / elapsed_time_array.size;
  msg = label + "<dev string:x213>" + average_elapsed_time + "<dev string:x200>";
  profileprintln(msg);
  iprintlnbold(msg);
  msg = label + "<dev string:x22d>" + largest_elapsed_time + "<dev string:x200>";
  profileprintln(msg);
  msg = label + "<dev string:x247>" + smallest_elapsed_time + "<dev string:x200>";
  profileprintln(msg);
}

get_elapsed_time(start_time, end_time = getmicrosecondsraw()) {
  if(!isDefined(start_time)) {
    return undefined;
  }

  elapsed_time = end_time - start_time;

  if(elapsed_time < 0) {
    elapsed_time += -2147483648;
  }

  return elapsed_time;
}

init_utility() {
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

within_fov(start_origin, start_angles, end_origin, fov) {
  normal = vectornormalize(end_origin - start_origin);
  forward = anglesToForward(start_angles);
  dot = vectordot(forward, normal);
  return dot >= fov;
}

is_mature() {
  return ismaturecontentenabled();
}

function_fa1da5cb() {
  return isshowbloodenabled();
}

function_2c435484() {
  return function_4e803413();
}

is_gib_restricted_build() {
  if(!(ismaturecontentenabled() && isshowgibsenabled())) {
    return true;
  }

  return false;
}

function_cd6c95db(localclientnum) {
  return function_d6e37bb1(localclientnum);
}

function_a0819fe3(localclientnum) {
  return colorblindmode(localclientnum);
}

registersystem(ssysname, cbfunc) {
  if(!isDefined(level._systemstates)) {
    level._systemstates = [];
  }

  if(level._systemstates.size >= 32) {
    error("<dev string:x17c>");

    return;
  }

  if(isDefined(level._systemstates[ssysname])) {
    error("<dev string:x19f>" + ssysname);

    return;
  }

  level._systemstates[ssysname] = spawnStruct();
  level._systemstates[ssysname].callback = cbfunc;
}

add_trigger_to_ent(ent, trig) {
  if(!isDefined(ent._triggers)) {
    ent._triggers = [];
  }

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

trigger_thread(ent, on_enter_payload, on_exit_payload) {
  ent endon(#"death");

  if(ent ent_already_in_trigger(self)) {
    return;
  }

  add_trigger_to_ent(ent, self);

  if(isDefined(on_enter_payload)) {
    [[on_enter_payload]](ent);
  }

  while(isDefined(ent) && ent istouching(self)) {
    waitframe(1);
  }

  if(isDefined(ent) && isDefined(on_exit_payload)) {
    [[on_exit_payload]](ent);
  }

  if(isDefined(ent)) {
    remove_trigger_from_ent(ent, self);
  }
}

local_player_trigger_thread_always_exit(ent, on_enter_payload, on_exit_payload) {
  if(ent ent_already_in_trigger(self)) {
    return;
  }

  add_trigger_to_ent(ent, self);

  if(isDefined(on_enter_payload)) {
    [[on_enter_payload]](ent);
  }

  while(isDefined(ent) && ent istouching(self) && ent issplitscreenhost()) {
    waitframe(1);
  }

  if(isDefined(on_exit_payload)) {
    [[on_exit_payload]](ent);
  }

  if(isDefined(ent)) {
    remove_trigger_from_ent(ent, self);
  }
}

local_player_entity_thread(localclientnum, entity, func, arg1, arg2, arg3, arg4) {
  entity endon(#"death");
  entity waittill_dobj(localclientnum);
  single_thread(entity, func, localclientnum, arg1, arg2, arg3, arg4);
}

local_players_entity_thread(entity, func, arg1, arg2, arg3, arg4) {
  players = level.localplayers;

  for(i = 0; i < players.size; i++) {
    players[i] thread local_player_entity_thread(i, entity, func, arg1, arg2, arg3, arg4);
  }
}

debug_line(from, to, color, time) {
  level.debug_line = getdvarint(#"scr_debug_line", 0);

  if(isDefined(level.debug_line) && level.debug_line == 1) {
    if(!isDefined(time)) {
      time = 1000;
    }

    line(from, to, color, 1, 1, time);
  }
}

debug_star(origin, color, time) {
  level.debug_star = getdvarint(#"scr_debug_star", 0);

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

getnextobjid(localclientnum) {
  nextid = 0;

  if(level.releasedobjectives[localclientnum].size > 0) {
    nextid = level.releasedobjectives[localclientnum][level.releasedobjectives[localclientnum].size - 1];
    level.releasedobjectives[localclientnum][level.releasedobjectives[localclientnum].size - 1] = undefined;
  } else {
    nextid = level.numgametypereservedobjectives[localclientnum];
    level.numgametypereservedobjectives[localclientnum]++;
  }

  if(nextid > 31) {
    println("<dev string:x262>");
  }

  assert(nextid < 32);

  if(nextid > 31) {
    nextid = 31;
  }

  return nextid;
}

releaseobjid(localclientnum, objid) {
  assert(objid < level.numgametypereservedobjectives[localclientnum]);

  for(i = 0; i < level.releasedobjectives[localclientnum].size; i++) {
    if(objid == level.releasedobjectives[localclientnum][i]) {
      return;
    }
  }

  level.releasedobjectives[localclientnum][level.releasedobjectives[localclientnum].size] = objid;
}

is_safehouse(str_next_map = get_map_name()) {
  return false;
}

button_held_think(which_button) {
  self endon(#"disconnect");

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
    } else if(self[[level._button_funcs[which_button]]]()) {
      if(time_started == 0) {
        time_started = gettime();
      }

      if(gettime() - time_started > 250) {
        self._holding_button[which_button] = 1;
      }
    } else if(time_started != 0) {
      time_started = 0;
    }

    waitframe(1);
  }
}

init_button_wrappers() {
  if(!isDefined(level._button_funcs)) {
    level._button_funcs[4] = &up_button_pressed;
    level._button_funcs[5] = &down_button_pressed;
  }
}

up_button_held() {
  init_button_wrappers();

  if(!isDefined(self._up_button_think_threaded)) {
    self thread button_held_think(4);
    self._up_button_think_threaded = 1;
  }

  return self._holding_button[4];
}

down_button_held() {
  init_button_wrappers();

  if(!isDefined(self._down_button_think_threaded)) {
    self thread button_held_think(5);
    self._down_button_think_threaded = 1;
  }

  return self._holding_button[5];
}

up_button_pressed() {
  return self buttonpressed("<dev string:x28f>") || self buttonpressed("<dev string:x299>");
}

waittill_up_button_pressed() {
  while(!self up_button_pressed()) {
    waitframe(1);
  }
}

down_button_pressed() {
  return self buttonpressed("<dev string:x2a3>") || self buttonpressed("<dev string:x2af>");
}

waittill_down_button_pressed() {
  while(!self down_button_pressed()) {
    waitframe(1);
  }
}

function_4c1656d5() {
  if(sessionmodeiswarzonegame()) {
    return getdvarfloat(#"hash_4e7a02edee964bf9", 250);
  }

  return getdvarfloat(#"hash_4ec50cedeed64871", 250);
}

function_16fb0a3b() {
  if(sessionmodeiswarzonegame()) {
    if(getdvarint(#"hash_23a1d3a9139af42b", 0) > 0) {
      return getdvarfloat(#"hash_608e7bb0e9517884", 250);
    } else {
      return getdvarfloat(#"hash_4e7a02edee964bf9", 250);
    }

    return;
  }

  if(getdvarint(#"hash_23fac9a913e70c03", 0) > 0) {
    return getdvarfloat(#"hash_606c79b0e9348eb8", 250);
  }

  return getdvarfloat(#"hash_4ec50cedeed64871", 250);
}

lerp_generic(localclientnum, duration, callback, ...) {
  starttime = getservertime(localclientnum);
  currenttime = starttime;
  elapsedtime = 0;
  defaultargs = array(currenttime, elapsedtime, localclientnum, duration);
  args = arraycombine(defaultargs, vararg, 1, 0);

  while(elapsedtime < duration) {
    if(isDefined(callback)) {
      args[0] = currenttime;
      args[1] = elapsedtime;
      _single_func(undefined, callback, args);
    }

    waitframe(1);
    currenttime = getservertime(localclientnum);

    if(currenttime < starttime) {
      return;
    }

    elapsedtime = currenttime - starttime;
  }

  if(isDefined(callback)) {
    args[0] = currenttime;
    args[1] = duration;
    _single_func(undefined, callback, args);
  }
}

function_c16f65a3(enemy_a, enemy_b) {
  assert(enemy_a != enemy_b, "<dev string:x2bb>");
  level.team_enemy_mapping[enemy_a] = enemy_b;
  level.team_enemy_mapping[enemy_b] = enemy_a;
}

function_73fab74d() {
  if(isDefined(level.var_1bbf77be)) {
    return;
  }

  level.var_1bbf77be = 1;
  function_c16f65a3(#"allies", #"axis");
  function_c16f65a3(#"team3", #"any");
  set_team_mapping(#"allies", #"axis");
}

cf_team_mapping(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (newval) {
    case 0:
      set_team_mapping(#"axis", #"allies");
      break;
    case 1:
      set_team_mapping(#"allies", #"axis");
      break;
    default:
      set_team_mapping(#"allies", #"axis");
      break;
  }
}

preload_frontend(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    preloadfrontend();
  }
}

set_team_mapping(str_team_for_sidea, str_team_for_sideb) {
  if(str_team_for_sidea == #"allies") {
    str_team_for_sidea = #"allies";
  } else if(str_team_for_sidea == #"axis") {
    str_team_for_sidea = #"axis";
  }

  if(str_team_for_sideb == #"axis") {
    str_team_for_sideb = #"axis";
  } else if(str_team_for_sideb == #"allies") {
    str_team_for_sideb = #"allies";
  }

  assert(str_team_for_sidea != str_team_for_sideb, "<dev string:x302>");
  level.team_mapping[#"sidea"] = str_team_for_sidea;
  level.team_mapping[#"sideb"] = str_team_for_sideb;
  level.team_mapping[#"attacker"] = str_team_for_sidea;
  level.team_mapping[#"defender"] = str_team_for_sideb;
  level.team_mapping[#"attackers"] = str_team_for_sidea;
  level.team_mapping[#"defenders"] = str_team_for_sideb;
  level.team_mapping[#"wun"] = #"allies";
  level.team_mapping[#"fpa"] = #"axis";
  level.team_mapping[#"teama"] = level.team_mapping[#"sidea"];
  level.team_mapping[#"teamb"] = level.team_mapping[#"sideb"];
  level.team_mapping[#"side3"] = #"team3";
}

get_team_mapping(str_team) {
  assert(isDefined(str_team));

  if(isDefined(level.team_mapping)) {
    result = level.team_mapping[str_team];

    if(isDefined(result)) {
      return result;
    }
  }

  return str_team;
}

get_enemy_team(team) {
  team = get_team_mapping(team);

  if(!isDefined(team)) {
    return undefined;
  }

  if(isDefined(level.team_enemy_mapping) && isDefined(level.team_enemy_mapping[team])) {
    return level.team_enemy_mapping[team];
  }

  return #"none";
}

function_35aed314(teama, teamb) {
  teama = get_team_mapping(teama);
  teamb = get_team_mapping(teamb);

  if(!isDefined(teama) || !isDefined(teamb)) {
    return false;
  }

  if(teama == teamb) {
    return false;
  }

  if(isDefined(level.team_enemy_mapping)) {
    if(isDefined(level.team_enemy_mapping[teama])) {
      if(#"any" == level.team_enemy_mapping[teama]) {
        return true;
      }

      if(teamb == level.team_enemy_mapping[teama]) {
        return true;
      }
    }

    if(isDefined(level.team_enemy_mapping[teamb])) {
      if(#"any" == level.team_enemy_mapping[teamb]) {
        return true;
      }

      if(teama == level.team_enemy_mapping[teamb]) {
        return true;
      }
    }
  }

  return false;
}

is_on_side(str_team) {
  return self.team === get_team_mapping(str_team);
}

get_game_type() {
  return tolower(getdvarstring(#"g_gametype"));
}

get_map_name() {
  return tolower(getdvarstring(#"sv_mapname"));
}

is_frontend_map() {
  return get_map_name() === "core_frontend";
}

function_26489405() {
  isnightmap = 0;
  mapname = get_map_name();

  switch (mapname) {
    case #"mp_casino":
      isnightmap = 1;
      break;
    case #"mp_austria":
      isnightmap = 1;
      break;
    default:
      break;
  }

  return isnightmap;
}

function_8570168d() {
  if(getdvar(#"hash_49e94b7aefac4f49", 0)) {
    return true;
  }

  if(sessionmodeismultiplayergame()) {
    mode = function_bea73b01();

    if(mode == 4) {
      return true;
    }
  }

  return false;
}

is_arena_lobby() {
  mode = function_bea73b01();

  if(mode == 3) {
    return true;
  }

  return false;
}

script_wait() {
  n_time = gettime();

  if(isDefined(self.script_wait)) {
    wait self.script_wait;

    if(isDefined(self.script_wait_add)) {
      self.script_wait += self.script_wait_add;
    }
  }

  n_min = isDefined(self.script_wait_min) ? self.script_wait_min : 0;
  n_max = isDefined(self.script_wait_max) ? self.script_wait_max : 0;

  if(n_max > n_min) {
    wait randomfloatrange(n_min, n_max);
    self.script_wait_min += isDefined(self.script_wait_add) ? self.script_wait_add : 0;
    self.script_wait_max += isDefined(self.script_wait_add) ? self.script_wait_add : 0;
  } else if(n_min > 0) {
    wait n_min;
    self.script_wait_min += isDefined(self.script_wait_add) ? self.script_wait_add : 0;
  }

  return gettime() - n_time;
}

lock_model(model) {
  if(isDefined(model)) {
    if(!isDefined(level.model_locks)) {
      level.model_locks = [];
    }

    if(!isDefined(level.model_locks[model])) {
      level.model_locks[model] = 0;
    }

    if(level.model_locks[model] < 1) {
      forcestreamxmodel(model);
    }

    level.model_locks[model]++;
  }
}

unlock_model(model) {
  if(!isDefined(level.model_locks)) {
    level.model_locks = [];
  }

  if(isDefined(model) && isDefined(level.model_locks[model])) {
    if(level.model_locks[model] > 0) {
      level.model_locks[model]--;

      if(level.model_locks[model] < 1) {
        stopforcestreamingxmodel(model);
      }
    }
  }
}

function_48e57e36(var_1f1d12d8) {
  base = 1;
  decimal = 0;

  for(i = var_1f1d12d8.size - 1; i >= 0; i--) {
    if(var_1f1d12d8[i] >= "0" && var_1f1d12d8[i] <= "9") {
      decimal += int(var_1f1d12d8[i]) * base;
      base *= 16;
      continue;
    }

    if(var_1f1d12d8[i] >= "a" && var_1f1d12d8[i] <= "f") {
      if(var_1f1d12d8[i] == "a") {
        number = 10;
      } else if(var_1f1d12d8[i] == "b") {
        number = 11;
      } else if(var_1f1d12d8[i] == "c") {
        number = 12;
      } else if(var_1f1d12d8[i] == "d") {
        number = 13;
      } else if(var_1f1d12d8[i] == "e") {
        number = 14;
      } else if(var_1f1d12d8[i] == "f") {
        number = 15;
      }

      decimal += number * base;
      base *= 16;
    }
  }

  return decimal;
}

add_devgui(localclientnum, menu_path, commands) {
  adddebugcommand(localclientnum, "<dev string:x34f>" + menu_path + "<dev string:x35e>" + commands + "<dev string:x364>");
}

remove_devgui(localclientnum, menu_path) {
  adddebugcommand(localclientnum, "<dev string:x369>" + menu_path + "<dev string:x364>");
}

