/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\dialogue.gsc
**************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace dialogue;

function say(alias, priority, timeout, overlap, delay, scope) {
  assert(isxhash(alias) || isstring(alias), "<dev string:x24>");

  if(!soundexists(alias) && !function_cf6c7d510f5a4b08(alias)) {
    iprintlnbold("<dev string:x50>" + getxhashsourcename(alias) + "<dev string:x5d>");

    return 0;
  }

  self endon("death");

  if(!isDefined(priority)) {
    priority = 0;
  }

  if(!isDefined(overlap)) {
    overlap = priority > 0;
  }

  if(!isDefined(scope)) {
    scope = "self";
  }

  assert(scope == "<dev string:x6e>" || scope == "<dev string:x76>" || scope == "<dev string:x7e>", "<dev string:x88>");
  speaker = self;

  if(self == level) {
    speaker = get_vo_emitter();
    speaker.var_2234510c97c706f9 = 1;
  }

  if(utility::is_dead_or_dying(speaker) || speaker.vo_disabled || level.vo_disabled) {
    return 0;
  }

  assert(scope != "<dev string:x76>" || isDefined(speaker.team), "<dev string:xc2>");

  if(isDefined(level.var_2cd2e0438f6f8231)) {
    function_d2d119b3f687c63c(level.var_2cd2e0438f6f8231, alias);
    level.var_2cd2e0438f6f8231 = undefined;
  }

  vo_data = spawnStruct();
  vo_data.alias = alias;
  vo_data.priority = priority;
  vo_data.timeout = timeout;
  vo_data.overlap = overlap;
  vo_data.speaker = speaker;
  vo_data.scope = scope;
  vo_data.scope_ents = speaker function_bf5715bcec0f160a();
  vo_data thread queue_say(speaker, alias, priority, timeout, overlap, delay);

  if(!vo_data.vo_done_or_cancelled) {
    vo_data waittill("vo_done_or_cancelled");
  }

  return vo_data.said_vo;
}

function function_d2d119b3f687c63c(radio_dist, alias) {
  assert(isfloat(radio_dist) || isint(radio_dist), "<dev string:xf5>");

  if(!isDefined(alias)) {
    level.var_2cd2e0438f6f8231 = radio_dist;
    return;
  }

  if(!isDefined(level.var_1ccd80f236e572c7)) {
    level.var_1ccd80f236e572c7 = [];
  }

  level.var_1ccd80f236e572c7[alias] = radio_dist;
}

function say_sequence(sequence, priority, timeout, overlap, delay, scope, endons) {
  vo_data = create_vo_data(sequence, priority, timeout, overlap ?? 0, delay, scope, endons);
  return wait_vo_data(vo_data);
}

function say_sequence_ended(endons, sequence, priority, timeout, overlap, delay, scope) {
  return say_sequence(sequence, priority, timeout, overlap, delay, scope, endons);
}

function say_sequence_delayed(delay, sequence, priority, timeout, overlap, scope, endons) {
  return say_sequence(sequence, priority, timeout, overlap, delay, scope, endons);
}

function say_global_sequence(sequence, priority, timeout, overlap, delay, endons) {
  return say_sequence(sequence, priority, timeout, overlap, delay, "global", endons);
}

function stop_dialogue(cancel_queued_vo, cancel_delayed_vo) {
  if(!isDefined(cancel_queued_vo) || cancel_queued_vo) {
    self notify("cancel_queued_vo");
  }

  if(!isDefined(cancel_delayed_vo) || cancel_delayed_vo) {
    self notify("cancel_delayed_vo");
  }

  self notify("stop_vo_sequence");
  self notify("stop_dialogue");
  self notify("stop_facialFiller");

  if(isDefined(self.var_6ad6546473593e72)) {
    self notify("scripted_face_" + getxhashhexname(self.var_6ad6546473593e72), "end");
  }

  self.var_861991271473c76 = undefined;
  emitter = self;

  if(utility::issp() && isPlayer(self) || isstruct(self) || isDefined(self.vo_emitter)) {
    emitter = get_vo_emitter();
  }

  thread function_f94a633a775187e1(emitter);
}

function disable_dialogue(include_chatter) {
  speaker = self;

  if(level == self) {
    speaker = get_vo_emitter();
  }

  speaker.vo_disabled = 1;

  if(include_chatter) {
    speaker utility::set_battlechatter(0);
  }

  speaker notify("cancel_queued_vo");
  speaker notify("cancel_delayed_vo");
}

function enable_dialogue(include_chatter) {
  speaker = self;

  if(level == self) {
    speaker = get_vo_emitter();
  }

  speaker.vo_disabled = 1;

  if(include_chatter) {
    speaker utility::set_battlechatter(1);
  }
}

function function_c6ba3c3dce99441(include_chatter) {
  level.vo_disabled = 1;

  if(include_chatter) {
    level.battlechatterdisabled = 1;
  }

  foreach(vo_data in arraycombine(level.vo_queue, level.vo_active)) {
    if(!include_chatter && vo_data.ischatter) {
      continue;
    }

    vo_data.speaker notify("cancel_queued_vo");
    vo_data.speaker notify("cancel_delayed_vo");
  }
}

function function_9097bbda63c20f58(include_chatter) {
  level.vo_disabled = 0;

  if(include_chatter) {
    level.battlechatterdisabled = 0;
  }
}

function say_self(alias, priority, timeout, overlap, delay) {
  return say(alias, priority, timeout, overlap, delay, "self");
}

function say_team(alias, priority, timeout, overlap, delay) {
  return say(alias, priority, timeout, overlap, delay, "team");
}

function say_global(alias, priority, timeout, overlap, delay) {
  return say(alias, priority, timeout, overlap, delay, "global");
}

function say_delayed(delay, alias, priority, timeout, overlap, scope) {
  return say(alias, priority, timeout, overlap, delay, scope);
}

function say_self_delayed(delay, alias, priority, timeout, overlap) {
  return say(alias, priority, timeout, overlap, delay, "self");
}

function say_team_delayed(delay, alias, priority, timeout, overlap) {
  return say(alias, priority, timeout, overlap, delay, "team");
}

function say_global_delayed(delay, alias, priority, timeout, overlap) {
  return say(alias, priority, timeout, overlap, delay, "global");
}

function function_92182b8f79533d55(team, cancel_queued_vo, cancel_delayed_vo) {
  assert(isDefined(team), "<dev string:x114>");

  if(!(isDefined(level.vo_teams) && isDefined(level.vo_teams[team]))) {
    return;
  }

  foreach(vo_data in level.vo_teams[team].vo_active) {
    vo_data.speaker stop_dialogue(cancel_queued_vo, cancel_delayed_vo);
  }
}

function function_2fe10366c7ca1ea1(cancel_queued_vo, cancel_delayed_vo) {
  if(!isDefined(level.vo_active)) {
    return;
  }

  foreach(vo_data in level.vo_active) {
    vo_data.speaker stop_dialogue(cancel_queued_vo, cancel_delayed_vo);
  }
}

function is_speaking() {
  speaker = self;

  if(self == level) {
    speaker = get_vo_emitter();
  }

  if(!isDefined(speaker.var_861991271473c76) || !isDefined(speaker.var_6ad6546473593e72) && !isDefined(speaker.var_cf0d3e00923233a5)) {
    return false;
  }

  if(isDefined(speaker.vo_active)) {
    return (speaker.vo_active.size > 0);
  }

  if(isDefined(speaker.var_cf0d3e00923233a5)) {
    duration_ms = get_holdtime(speaker.var_cf0d3e00923233a5) * 1000;
  } else {
    duration_ms = lookupsoundlength(speaker.var_6ad6546473593e72);
  }

  return gettime() <= speaker.var_861991271473c76 + duration_ms;
}

function function_de5820ddcfc41a92() {
  speaker = self;

  if(self == level) {
    speaker = get_vo_emitter();
  }

  return speaker is_speaking() || isDefined(speaker.vo_delaystart);
}

function function_ef3bb46d2024effd() {
  speaker = self;

  if(self == level) {
    speaker = get_vo_emitter();
  }

  return speaker is_speaking() || speaker.var_ec03032865e57470;
}

function function_8231932c5efc0648() {
  speaker = self;

  if(self == level) {
    speaker = get_vo_emitter();
  }

  return speaker is_speaking() || speaker.var_ec03032865e57470 || isDefined(speaker.vo_delaystart);
}

function function_fb4cd0ece2b37b9(team = self.team) {
  assert(isDefined(team), "<dev string:x143>");

  if(!(isDefined(level.vo_teams) && isDefined(level.vo_teams[team]))) {
    return false;
  }

  return level.vo_teams[team].vo_active.size > 0;
}

function function_d365322ed7891bc0(speaker_array, cooldown = 15) {
  assert(isDefined(speaker_array), "<dev string:x16e>");
  assert(isarray(speaker_array), "<dev string:x193>");

  foreach(speaker in speaker_array) {
    if(speaker function_ef3bb46d2024effd()) {
      return true;
    }

    var_5b9e3cdd7554d82d = speaker function_842a649e126d7644();

    if(isDefined(var_5b9e3cdd7554d82d) && var_5b9e3cdd7554d82d < cooldown) {
      return true;
    }
  }

  return false;
}

function function_364375dbc0613c64() {
  if(!isDefined(level.vo_active)) {
    return false;
  }

  return level.vo_active.size > 0;
}

function function_5d66ac3cec47b60(timeout) {
  speaker = self;

  if(isDefined(timeout)) {
    struct = spawnStruct();
    struct endon("end");
    childthread function_66cf8056d9200040(timeout, "end", struct);
  }

  if(self == level) {
    speaker = get_vo_emitter();
  }

  if(!speaker function_de5820ddcfc41a92()) {
    return false;
  }

  speaker endon("death");

  if(isDefined(speaker.vo_active) && speaker.vo_active.size > 0) {
    speaker waittill("vo_done_or_cancelled");
  } else {
    var_44d17ac6cace9165 = gettime() - speaker.var_861991271473c76;

    if(isDefined(speaker.var_6ad6546473593e72)) {
      duration_ms = lookupsoundlength(speaker.var_6ad6546473593e72);
    } else {
      duration_ms = get_holdtime(speaker.var_cf0d3e00923233a5) * 1000;
    }

    time_remaining = (duration_ms - var_44d17ac6cace9165) / 1000;
    wait time_remaining;
  }

  return true;
}

function wait_finish_speaking() {
  speaker = self;

  if(self == level) {
    speaker = get_vo_emitter();
  }

  if(!speaker.var_ec03032865e57470) {
    return function_5d66ac3cec47b60();
  }

  speaker endon("cancel_queued_vo");
  speaker endon("death");

  while(speaker.var_ec03032865e57470 > 0) {
    speaker waittill("vo_done_or_cancelled");
  }

  return true;
}

function function_842a649e126d7644() {
  speaker = self;

  if(self == level) {
    speaker = get_vo_emitter();
  }

  if(!(isDefined(speaker.var_861991271473c76) && isDefined(speaker.var_6ad6546473593e72))) {
    return undefined;
  }

  var_71bb217d1560b0ed = speaker.var_861991271473c76 + lookupsoundlength(speaker.var_6ad6546473593e72);

  if(gettime() < var_71bb217d1560b0ed) {
    return undefined;
  }

  return (gettime() - var_71bb217d1560b0ed) / 1000;
}

function function_dcf12370fd4e45e6() {
  speaker = self;

  if(self == level) {
    speaker = get_vo_emitter();
  }

  is_time_delayed = isDefined(speaker.vo_delaystart) && isnumber(speaker.vo_delayvalue);

  if(!is_time_delayed && !isDefined(speaker.var_861991271473c76) || !isDefined(speaker.var_6ad6546473593e72)) {
    return undefined;
  }

  if(is_time_delayed) {
    var_71bb217d1560b0ed = speaker.vo_delaystart + speaker.vo_delayvalue * 1000 + lookupsoundlength(speaker.var_6ad6546473593e72);
  } else {
    var_71bb217d1560b0ed = self.var_861991271473c76 + lookupsoundlength(self.var_6ad6546473593e72);
  }

  if(gettime() > var_71bb217d1560b0ed) {
    return undefined;
  }

  return (var_71bb217d1560b0ed - gettime()) / 1000;
}

function function_104de98887a584fc(var, value) {
  if(!isDefined(self.vo_nagvars)) {
    function_a1c8c71775715127();
  }

  assert(isDefined(var) && isDefined(self.nagvars[var]), "<dev string:x1b3>");
  self.vo_nagvars[var] = value;
}

function set_nagvars(priority, timeout, overlap, scope) {
  if(!isDefined(self.vo_nagvars)) {
    function_a1c8c71775715127();
  }

  self.vo_nagvars.priority = priority ?? self.vo_nagvars.priority;
  self.vo_nagvars.timeout = timeout ?? self.vo_nagvars.timeout;
  self.vo_nagvars.overlap = overlap ?? self.vo_nagvars.overlap;
  self.vo_nagvars.scope = scope ?? self.vo_nagvars.scope;
}

function function_a1c8c71775715127() {
  if(self != level && !isDefined(level.vo_nagvars)) {
    level function_a1c8c71775715127();
  }

  self.vo_nagvars = spawnStruct();
  self.vo_nagvars.priority = level.vo_nagvars.priority ?? 0;
  self.vo_nagvars.timeout = level.vo_nagvars.timeout ?? 1;
  self.vo_nagvars.overlap = level.vo_nagvars.overlap ?? 0;
  self.vo_nagvars.scope = level.vo_nagvars.scope ?? "team";
}

function nag_wait(flag_msg, nags, repeat_delay, initial_delay, loop_limit, invert_flag) {
  self endon("finished_nag_loop");

  if(invert_flag ? !utility::flag(flag_msg) : utility::flag(flag_msg)) {
    return;
  }

  endon_ent = spawnStruct();
  childthread nagtill([endon_ent, "stop"], nags, repeat_delay, initial_delay, loop_limit);

  if(invert_flag) {
    utility::flag_waitopen(flag_msg);
  } else {
    utility::flag_wait(flag_msg);
  }

  endon_ent notify("stop");
}

function nag_waitopen(flag_msg, nags, repeat_delay, initial_delay, loop_limit) {
  nag_wait(flag_msg, nags, repeat_delay, initial_delay, loop_limit, 1);
}

function nag_wait_any(flag_msgs, nags, repeat_delay, initial_delay, loop_limit, invert_flag) {
  self endon("finished_nag_loop");

  foreach(flag_msg in flag_msgs) {
    if(invert_flag ? !utility::flag(flag_msg) : utility::flag(flag_msg)) {
      return;
    }
  }

  endon_ent = spawnStruct();
  childthread nagtill([endon_ent, "stop"], nags, repeat_delay, initial_delay, loop_limit);

  while(true) {
    level utility::waittill_any_in_array(flag_msgs);

    foreach(flag_msg in flag_msgs) {
      if(invert_flag ? !utility::flag(flag_msg) : utility::flag(flag_msg)) {
        endon_ent notify("stop");
        return;
      }
    }
  }
}

function nag_wait_all(flag_msgs, nags, repeat_delay, initial_delay, loop_limit, invert_flag) {
  self endon("finished_nag_loop");

  foreach(flag_msg in flag_msgs) {
    if(invert_flag ? utility::flag(flag_msg) : !utility::flag(flag_msg)) {
      continue;
    }

    return;
  }

  endon_ent = spawnStruct();
  childthread nagtill([endon_ent, "stop"], nags, repeat_delay, initial_delay, loop_limit);
  exit = 0;

  while(exit == 0) {
    level utility::waittill_any_in_array(flag_msgs);
    exit = 1;

    foreach(flag_msg in flag_msgs) {
      if(invert_flag ? utility::flag(flag_msg) : !utility::flag(flag_msg)) {
        exit = 0;
        break;
      }
    }
  }

  endon_ent notify("stop");
}

function nagtill(endon_data, nags, repeat_delay, initial_delay, loop_limit) {
  self endon("finished_nag_loop");
  assert(isDefined(repeat_delay), "<dev string:x1c5>");
  endon_ent = self;
  endon_msg = endon_data;

  if(isarray(endon_data)) {
    assert(endon_data.size == 2 && (isent(endon_data[0]) || isstruct(endon_data[0])) && isstring(endon_data[1]), "<dev string:x1ec>");
    endon_ent = endon_data[0];
    endon_msg = endon_data[1];
  }

  endon_ent endon(endon_msg);
  nag_loop(nags, repeat_delay, initial_delay, loop_limit);
}

function nagtill_any(endon_data, nags, repeat_delay, initial_delay, loop_limit) {
  endon_ent = self;

  foreach(endon_item in endon_data) {
    if(isent(endon_item) || isstruct(endon_item)) {
      endon_ent = endon_item;
      continue;
    }

    if(isstring(endon_item)) {
      endon_ent endon(endon_item);
      continue;
    }

    assertmsg("<dev string:x222>");
  }

  nag_loop(nags, repeat_delay, initial_delay, loop_limit);
}

function growing_delay(start, end, count) {
  delay = spawnStruct();
  delay.current = start;
  delay.maximum = end;
  delay.increment = (end - start) / count;
  return delay;
}

function waitfor(delay, params) {
  assert(isDefined(delay), "<dev string:x257>");

  if(isarray(delay)) {
    if(delay.size == 1 && isnumber(delay[0])) {
      delay = (delay[0] - gettime()) / 1000;
    } else if(isfunction(delay[0]) || isbuiltinmethod(delay[0]) || isbuiltinfunction(delay[0])) {
      params = arraycopy(delay);
      params[0] = undefined;

      if(isint(0)) {
        function_cdc669dbc8ea2101(params);
      }

      return call_with_params(delay[0], params);
    } else if(delay.size == 2 && (isent(delay[0]) || isstruct(delay[0])) && isstring(delay[1])) {
      delay[0] waittill(delay[1], value);
      return value;
    } else if(delay.size == 2 && isnumber(delay[0]) && isnumber(delay[1])) {
      assert(delay[0] >= 0 && delay[1] >= delay[1], "<dev string:x27e>");
      wait randomfloatrange(delay[0], delay[1]);
      return 1;
    } else {
      return waitfor_any(delay, params);
    }
  }

  if(isnumber(delay)) {
    if(delay <= 0) {
      return;
    }

    wait delay;
    return 1;
  }

  if(isstruct(delay) && isDefined(delay.current)) {
    wait delay.current;

    if(isDefined(delay.increment)) {
      delay.current += delay.increment;
    }

    if(isDefined(delay.maximum) && delay.current >= delay.maximum) {
      delay.current = delay.maximum;
      return 1;
    }

    return;
  }

  if(isstring(delay)) {
    self waittill(delay, value);
    return value;
  }

  if(isfunction(delay) || isbuiltinmethod(delay) || isbuiltinfunction(delay)) {
    return call_with_params(delay, params);
  }

  assertmsg("<dev string:x2db>");
}

function waitfor_any(delays, params) {
  if(!isarray(delays)) {
    waitfor(delays, params);
    return delays;
  }

  ent = spawnStruct();
  ent endon("kill");

  foreach(delay in delays) {
    childthread function_66cf8056d9200040(delay, "finished", ent, params);
  }

  ent waittill("finished", result, delay);
  ent utility::delaythread(0.05, &utility::send_notify, "kill");
  return result;
}

function function_66cf8056d9200040(delay, msg, notify_ent, params) {
  if(!isDefined(notify_ent)) {
    notify_ent = self;
  }

  result = waitfor(delay, params);
  notify_ent notify(msg, result, delay, self);
}

function function_5f93bf419368e0b3(delays, msg, notify_ent, params) {
  if(!isDefined(notify_ent)) {
    notify_ent = self;
  }

  result = waitfor_any(delays, params);
  notify_ent notify(msg, result, self);
}

function waitfor_ent(delay, params, msg) {
  struct = spawnStruct();
  thread function_66cf8056d9200040(delay, msg ?? "finish", struct, params);
  return struct;
}

function call_with_params(func, params) {
  if(isfunction(func)) {
    return call_with_params_script(func, params);
  }

  if(isbuiltinmethod(func)) {
    return call_with_params_builtin(func, params);
  }

  if(isbuiltinfunction(func)) {
    return call_with_params_builtin_noself(func, params);
  }

  assertmsg("<dev string:x2f2>");
}

function call_with_params_script(func, params) {
  assert(isfunction(func), "<dev string:x345>");

  if(!isDefined(params)) {
    return self[[func]]();
  }

  if(!isarray(params)) {
    return self[[func]](params);
  }

  switch (params.size) {
    case 0:
      return self[[func]]();
    case 1:
      return self[[func]](params[0]);
    case 2:
      return self[[func]](params[0], params[1]);
    case 3:
      return self[[func]](params[0], params[1], params[2]);
    case 4:
      return self[[func]](params[0], params[1], params[2], params[3]);
    case 5:
      return self[[func]](params[0], params[1], params[2], params[3], params[4]);
    case 6:
      return self[[func]](params[0], params[1], params[2], params[3], params[4], params[5]);
    case 7:
      return self[[func]](params[0], params[1], params[2], params[3], params[4], params[5], params[6]);
    case 8:
      return self[[func]](params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7]);
    case 9:
      return self[[func]](params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7], params[8]);
    default:
      assertmsg("<dev string:x368>");
      break;
  }
}

function call_with_params_builtin(func, params) {
  assert(isbuiltinmethod(func), "<dev string:x3a5>");

  if(!isDefined(params)) {
    return self[[func]]();
  }

  if(!isarray(params)) {
    return self builtin[[func]](params);
  }

  switch (params.size) {
    case 0:
      return self builtin[[func]]();
    case 1:
      return self builtin[[func]](params[0]);
    case 2:
      return self builtin[[func]](params[0], params[1]);
    case 3:
      return self builtin[[func]](params[0], params[1], params[2]);
    case 4:
      return self builtin[[func]](params[0], params[1], params[2], params[3]);
    case 5:
      return self builtin[[func]](params[0], params[1], params[2], params[3], params[4]);
    case 6:
      return self builtin[[func]](params[0], params[1], params[2], params[3], params[4], params[5]);
    case 7:
      return self builtin[[func]](params[0], params[1], params[2], params[3], params[4], params[5], params[6]);
    case 8:
      return self builtin[[func]](params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7]);
    case 9:
      return self builtin[[func]](params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7], params[8]);
    default:
      assertmsg("<dev string:x368>");
      break;
  }
}

function call_with_params_builtin_noself(func, params) {
  assert(isbuiltinfunction(func), "<dev string:x3ef>");

  if(!isDefined(params)) {
    return builtin[[func]]();
  }

  if(!isarray(params)) {
    return builtin[[func]](params);
  }

  switch (params.size) {
    case 0:
      return builtin[[func]]();
    case 1:
      return builtin[[func]](params[0]);
    case 2:
      return builtin[[func]](params[0], params[1]);
    case 3:
      return builtin[[func]](params[0], params[1], params[2]);
    case 4:
      return builtin[[func]](params[0], params[1], params[2], params[3]);
    case 5:
      return builtin[[func]](params[0], params[1], params[2], params[3], params[4]);
    case 6:
      return builtin[[func]](params[0], params[1], params[2], params[3], params[4], params[5]);
    case 7:
      return builtin[[func]](params[0], params[1], params[2], params[3], params[4], params[5], params[6]);
    case 8:
      return builtin[[func]](params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7]);
    case 9:
      return builtin[[func]](params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7], params[8]);
    default:
      assertmsg("<dev string:x368>");
      break;
  }
}

function function_69cef4d93358c993(timeout, func, params) {
  ent = spawnStruct();
  ent utility::delaythread(timeout, &utility::send_notify, "kill");
  ent endon("kill");
  return call_with_params(func, params);
}

function create_vo_data(sequence, priority, timeout, overlap, delay, scope, endons) {
  assert(isDefined(sequence), "<dev string:x437>");
  speaker = self;

  if(self == level) {
    speaker = get_vo_emitter();
  }

  if(utility::is_dead_or_dying(speaker) || speaker.vo_disabled || level.vo_disabled) {
    return;
  }

  default_scope = isDefined(speaker.team) ? "team" : "global";

  if(!isDefined(scope)) {
    scope = default_scope;
  }

  assert(scope == "<dev string:x6e>" || scope == "<dev string:x76>" || scope == "<dev string:x7e>", "<dev string:x88>");
  assert(scope != "<dev string:x76>" || isDefined(speaker.team), "<dev string:xc2>");
  vo_data = spawnStruct();
  vo_data.owner = self;
  vo_data.speaker = speaker;
  vo_data.scope_ents = speaker function_bf5715bcec0f160a();
  vo_data.isvodata = 1;

  if(!isarray(sequence)) {
    sequence = [sequence];
  }

  vo_data.index = 0;
  vo_data.sequence = sequence;
  vo_data.priority = priority ?? 0;
  vo_data.overlap = overlap ?? 1;
  vo_data.endons = endons ?? [];
  vo_data.timeout = timeout;
  vo_data.delay = delay;
  vo_data.scope = scope;

  if(!isarray(vo_data.endons)) {
    vo_data.endons = [vo_data.endons];
  }

  return vo_data;
}

function wait_vo_data(vo_data) {
  if(!isDefined(vo_data)) {
    return 0;
  }

  vo_data thread queue_sequence();

  if(!vo_data.finished_or_cancelled) {
    vo_data waittill("finished_or_cancelled");
  }

  return vo_data.finished;
}

function queue_say(speaker, alias, priority, timeout, overlap, delay) {
  self.finished = 0;
  speaker.var_e4fec99876f6a732 = self.scope;
  speaker notify("started_queue_wait", self);
  cancelled = self.scope_ents[self.scope] wait_vo_queue(self, timeout);
  speaker notify("finished_queue_wait", self, cancelled);

  if(!cancelled && !utility::is_dead_or_dying(speaker) && !speaker.vo_disabled && !level.vo_disabled) {
    speaker.var_569f79b89b587aba = priority;

    foreach(ent in self.scope_ents) {
      ent add_vo_data(self);
    }

    self notify("proceeded");
    cancelled = speaker delay_dialogue(delay, alias);
    speaker.vo_delaystart = undefined;
    speaker.vo_delayvalue = undefined;
    speaker notify("stop_bcs_sequence");

    if(isDefined(cancelled) && !cancelled) {
      check_interrupt(overlap, self.scope_ents[self.scope]);
      self.said_vo = speaker say_dialogue(alias, self.receivers);
    }

    if(utility::is_dead_or_dying(speaker)) {
      speaker stop_dialogue(0, 0);
    }

    foreach(ent in self.scope_ents) {
      ent remove_vo_data(self);
    }
  } else {
    self notify("proceeded");
  }

  function_d621ed37c021620a(self.scope_ents);
  self.vo_done_or_cancelled = 1;
  speaker notify("vo_done_or_cancelled", self);
  self notify("vo_done_or_cancelled");
}

function check_interrupt(overlap, scope_ent) {
  if(!overlap) {
    speaker = self.vo_parent ?? self;

    foreach(vo_data in scope_ent.vo_active) {
      if(vo_data == self) {
        continue;
      }

      other_speaker = vo_data.speaker;
      force_interrupt = utility::issp() || isstruct(speaker) || isstruct(other_speaker);

      if(force_interrupt || distance2dsquared(speaker.origin, other_speaker.origin) <= level.var_822444fd128d6523) {
        other_speaker stop_dialogue(0, 1);
      }
    }
  }
}

function queue_sequence() {
  self.finished = 0;
  self.finished_or_cancelled = 0;
  self.speaker.var_e4fec99876f6a732 = self.scope;
  self.speaker notify("started_queue_wait", self);
  cancelled = self.scope_ents[self.scope] wait_vo_queue(self, self.timeout, self.endons);
  self.speaker notify("finished_queue_wait", self, cancelled);

  if(!cancelled && !utility::is_dead_or_dying(self.speaker) && !self.speaker.vo_disabled && !level.vo_disabled) {
    execute_sequence();
  } else {
    self notify("proceeded");
  }

  if(!isDefined(self.finished)) {
    if(isDefined(self.var_3b53a3523603664)) {
      self thread[[self.var_3b53a3523603664]]();
    }
  } else if(!self.finished) {
    if(isDefined(self.oncancelfunc)) {
      self thread[[self.oncancelfunc]]();
    }
  } else if(isDefined(self.onfinishedfunc)) {
    self thread[[self.onfinishedfunc]]();
  }

  function_d621ed37c021620a(self.scope_ents);
  self.speaker notify("vo_finished_or_cancelled", self);
  level notify("vo_finished_or_cancelled", self);
  self.finished_or_cancelled = 1;
  self notify("finished_or_cancelled");
  return self.finished;
}

function execute_sequence() {
  level notify("vo_sequence_started", self);
  self.speaker.var_569f79b89b587aba = self.priority;

  foreach(ent in self.scope_ents) {
    ent add_vo_data(self);
  }

  self notify("proceeded");
  cancelled = self.speaker delay_dialogue(self.delay, self.alias);
  self.speaker.vo_delaystart = undefined;
  self.speaker.vo_delayvalue = undefined;

  if(isDefined(cancelled) && !cancelled) {
    if(getdvarint(@ "hash_62a9dffcf730f69")) {
      thread function_d45775e0776dd5df();
    }

    check_interrupt(self.overlap, self.scope_ents[self.scope]);

    while(isDefined(self.finished) && !self.finished) {
      self.finished = function_76e84ffb6bfb071d();
    }

    if(utility::is_dead_or_dying(self.speaker)) {
      self.speaker stop_dialogue(0, 0);

      if(isDefined(self.var_cbe8926fa6df89ef)) {
        self thread[[self.var_cbe8926fa6df89ef]]();
      }
    }
  }

  foreach(ent in self.scope_ents) {
    ent remove_vo_data(self);
  }

  level notify("vo_sequence_ended", self);
}

function function_76e84ffb6bfb071d() {
  if(self.index >= self.sequence.size) {
    return 1;
  }

  if(utility::is_dead_or_dying(self.speaker)) {
    if(isDefined(self.var_76b9cc4019a35161)) {
      self[[self.var_76b9cc4019a35161]]();
    }

    if(utility::is_dead_or_dying(self.speaker)) {
      return function_2d30515a2dd46b52("DEAD SPEAKER");
    }
  }

  if(self.speaker.vo_disabled || level.vo_disabled) {
    return function_2d30515a2dd46b52("VO DISABLED");
  }

  self.scope_ents[self.scope] endon("stop_vo_sequence");
  self.speaker endon("stop_vo_sequence");
  self.speaker endon("death");
  self notify("new_segment");
  endon_ent = self.speaker;

  foreach(endon_data in self.endons) {
    if(isent(endon_data) || isstruct(endon_data)) {
      endon_ent = endon_data;
      continue;
    }

    if(isstring(endon_data)) {
      endon_ent endon(endon_data);
    }
  }

  self.alias = undefined;
  segment = self.sequence[self.index];
  self.index++;

  if(isstring(segment) || isxhash(segment)) {
    self.alias = segment;

    if(!soundexists(self.alias) && !function_cf6c7d510f5a4b08(self.alias)) {
      iprintlnbold("<dev string:x50>" + self.alias + "<dev string:x5d>");

      return function_2d30515a2dd46b52("MISSING ALIAS");
    }

    finished = self.speaker say_dialogue(self.alias, self.receivers);

    if(!finished) {
      return function_2d30515a2dd46b52("SAY INTERRUPTED");
    }

    return 0;
  } else if(isnumber(segment)) {
    if(segment <= 0) {
      return 0;
    }

    wait segment;
    return 0;
  } else if(isent(segment) || isstruct(segment)) {
    result = switch_speaker(segment);
    return 0;
  } else if(isfunction(segment)) {
    result = self[[segment]]();

    if(isDefined(result)) {
      if(isint(result) && result == 0) {
        return function_2d30515a2dd46b52("FUNC RETURNED FALSE");
      }

      self.index--;
      self.sequence[self.index] = result;
    }

    return 0;
  } else if(isarray(segment)) {
    self.index--;
    sequence = [];

    for(i = 0; i < self.sequence.size; i++) {
      if(i == self.index) {
        foreach(item in segment) {
          sequence[sequence.size] = item;
        }

        continue;
      }

      sequence[sequence.size] = self.sequence[i];
    }

    self.sequence = sequence;
    return 0;
  }

  return function_2d30515a2dd46b52("UNDEFINED SEGMENT");
}

function function_2d30515a2dd46b52(reason) {
  if(!getdvarint(@ "hash_62a9dffcf730f69")) {
    return;
  }

  iprintlnbold("<dev string:x454>" + reason + "<dev string:x45a>" + (self.name ?? "<dev string:x462>"));
}

function function_d45775e0776dd5df() {
  self endon("<dev string:x473>");

  for(;;) {
    sequence = self.sequence;
    ln_height = 0;

    for(i = 0; i < sequence.size; i++) {
      display_ln = undefined;
      segment = sequence[i];

      if(isstring(segment) || isxhash(segment)) {
        display_ln = "<dev string:x48f>" + getxhashsourcename(segment);
      } else if(isnumber(segment)) {
        display_ln = "<dev string:x498>" + segment + "<dev string:x4a2>";
      } else if(isent(segment)) {
        ent_num = "<dev string:x4aa>" + segment getentitynumber();
        display_ln = "<dev string:x4af>";

        if(isDefined(segment.animname)) {
          display_ln += segment.animname + "<dev string:x4c6>" + ent_num + "<dev string:x4cc>";
        } else {
          display_ln += ent_num;
        }
      }

      if(isDefined(display_ln)) {
        is_index = i == self.index - 1;
        setdvarifuninitialized(@ "bcs_debug_x", 1350);
        setdvarifuninitialized(@ "bcs_debug_y", 500);
        base_x = getdvarint(@ "bcs_debug_x");
        base_y = getdvarint(@ "bcs_debug_y");

        if(isDefined(self.name)) {
          event_info = "<dev string:x4d1>" + self.speaker getentitynumber() + "<dev string:x4da>" + self.name + "<dev string:x4e0>";
          printtoscreen2d(base_x, base_y + 22, event_info, (0, 0, 0), 1.75);
          printtoscreen2d(base_x - 2, base_y + 20, event_info, (1, 1, 0), 1.75);
        }

        color = is_index ? (0, 0.85, 0) : (1, 1, 1);
        space = is_index ? 35 : 25;
        scale = is_index ? 2 : 1.5;
        printtoscreen2d(base_x + 2, base_y + 52 + ln_height + is_index * 10, display_ln, (0, 0, 0), scale);
        printtoscreen2d(base_x + 2, base_y + 52 + ln_height + is_index * 10, display_ln, (0, 0, 0), scale);
        printtoscreen2d(base_x, base_y + 50 + ln_height + is_index * 10, display_ln, color, scale);
        ln_height += space;
      }
    }

    waitframe();
  }
}

function switch_speaker(new_speaker) {
  foreach(ent in self.scope_ents) {
    ent remove_vo_data(self);
  }

  if(new_speaker == level) {
    new_speaker = new_speaker get_vo_emitter();
  }

  self.listener = self.speaker;
  self.speaker = new_speaker;
  self.speaker.var_569f79b89b587aba = self.priority;
  self.scope_ents = self.speaker function_bf5715bcec0f160a();

  foreach(ent in self.scope_ents) {
    ent add_vo_data(self);
  }
}

function delay_dialogue(delay, var_cdcf9973d877788) {
  if(!isDefined(delay)) {
    return false;
  }

  self endon("death");
  self endon("cancel_delayed_vo");
  self.var_6ad6546473593e72 = undefined;
  self.var_cf0d3e00923233a5 = undefined;
  self.vo_delaystart = gettime();
  self.vo_delayvalue = delay;

  if(isDefined(var_cdcf9973d877788) && function_cf6c7d510f5a4b08(var_cdcf9973d877788)) {
    self.var_cf0d3e00923233a5 = var_cdcf9973d877788;
  } else {
    self.var_6ad6546473593e72 = var_cdcf9973d877788;
  }

  result = waitfor(delay);
  return isint(result) && result == 0;
}

function say_dialogue(alias, receivers) {
  if(utility::is_dead_or_dying(self)) {
    return 0;
  }

  self notify("started_saying", alias);

  if(isDefined(self.vo_startfunc)) {
    self thread[[self.vo_startfunc]](alias);
  }

  if(function_cf6c7d510f5a4b08(alias)) {
    finished = function_c5c10e87844edd3f(alias);
  } else if(soundexists(alias)) {
    finished = play_dialogue_sound(alias, receivers);
  } else {
    finished = 0;
  }

  if(isDefined(self)) {
    self notify("done_saying", alias, finished);
  }

  return finished;
}

function play_dialogue_sound(alias, receivers) {
  self endon("death");
  self.var_861991271473c76 = gettime();
  self.var_6ad6546473593e72 = alias;
  self.var_cf0d3e00923233a5 = undefined;

  if(isDefined(receivers) && utility::issp()) {
    thread playsound_receivers(alias, receivers);
  }

  return self[[level.vo_playsoundfunc]](alias);
}

function wait_vo_queue(vo_data, timeout, endons) {
  vo_data endon("proceed");

  if(self.vo_active.size == 0 || !vo_data.ischatter && vo_data.priority >= 0 && function_8221fe2b3bcdd1a7()) {
    return false;
  }

  vo_enqueue(vo_data);
  cancelled = !istrue(vo_data.speaker function_9c89b8fc548e7594(timeout, endons));
  function_68a62986785ac328(vo_data);

  if(cancelled || !vo_data has_priority(self.vo_active)) {
    return true;
  }

  return false;
}

function private function_8221fe2b3bcdd1a7() {
  foreach(vo_data in self.vo_active) {
    if(!vo_data.ischatter) {
      return false;
    }
  }

  return true;
}

function function_d621ed37c021620a(scope_ents) {
  foreach(scope_ent in scope_ents) {
    if(!isDefined(scope_ent.vo_queue) || scope_ent.vo_queue.size == 0) {
      continue;
    }

    next_struct = scope_ent.vo_queue[0];

    if(scope_ent.vo_active.size == 0 || next_struct function_16627087f1fa3fd5(scope_ent)) {
      scope_ent function_68a62986785ac328(next_struct);
      next_struct notify("proceed");
      next_struct waittill("proceeded");
      return;
    }
  }
}

function private function_9c89b8fc548e7594(timeout, endons) {
  self endon("death");

  if(isDefined(endons)) {
    if(!isarray(endons)) {
      endons = [endons];
    }

    endon_ent = self;

    foreach(endon_data in endons) {
      if(isent(endon_data) || isstruct(endon_data)) {
        endon_ent = endon_data;
        continue;
      }

      if(isstring(endon_data)) {
        endon_ent endon(endon_data);
      }
    }
  }

  if(isDefined(timeout)) {
    self endon("cancel_queued_vo");
    result = waitfor(timeout);
    return (!isint(result) || result);
  }

  self waittill("cancel_queued_vo");
}

function private function_16627087f1fa3fd5(scope_ent) {
  return false;
}

function has_priority(scope_ent_array, allow_equal) {
  if(isstruct(scope_ent_array)) {
    scope_ent_array = scope_ent_array.vo_active;
  }

  speakers = [];

  if(utility::issp() || !isDefined(self.speaker.origin) || self.speaker.var_2234510c97c706f9 || self.speaker.is2demitter) {
    foreach(vo_data in scope_ent_array) {
      speakers[speakers.size] = vo_data.speaker;
    }
  } else {
    foreach(vo_data in scope_ent_array) {
      speaker = vo_data.speaker;

      if(isstruct(speaker) || speaker.is2demitter || distance2dsquared(self.speaker.origin, speaker.origin) <= level.var_822444fd128d6523) {
        speakers[speakers.size] = speaker;
      }
    }
  }

  if(self.priority >= 1 || speakers.size == 0) {
    return 1;
  }

  highest_priority = speakers[0].var_569f79b89b587aba;

  if(!isDefined(highest_priority)) {
    return 1;
  }

  if(allow_equal) {
    return (self.priority >= highest_priority);
  }

  return self.priority > highest_priority;
}

function private vo_enqueue(struct) {
  if(!isDefined(struct.speaker.var_ec03032865e57470)) {
    struct.speaker.var_ec03032865e57470 = 0;
  }

  struct.speaker.var_ec03032865e57470++;

  for(i = self.vo_queue.size; true; i--) {
    if(i == 0 || self.vo_queue[i - 1].priority >= struct.priority) {
      self.vo_queue[i] = struct;
      return;
    }

    self.vo_queue[i] = self.vo_queue[i - 1];
  }
}

function private function_68a62986785ac328(struct) {
  if(!(isDefined(self) && isDefined(self.vo_queue))) {
    return;
  }

  found = 0;

  for(i = 0; i < self.vo_queue.size; i++) {
    if(found) {
      self.vo_queue[i - 1] = self.vo_queue[i];
      continue;
    }

    if(self.vo_queue[i] == struct) {
      found = 1;
    }
  }

  if(found) {
    self.vo_queue[self.vo_queue.size - 1] = undefined;
  }

  if(isDefined(struct.speaker) && isDefined(struct.speaker.var_ec03032865e57470)) {
    struct.speaker.var_ec03032865e57470--;
  }
}

function add_vo_data(vo_data) {
  for(i = self.vo_active.size; true; i--) {
    if(i == 0 || isalive(self.vo_active[i - 1].speaker) && isDefined(self.vo_active[i - 1].priority) && self.vo_active[i - 1].priority >= vo_data.priority) {
      self.vo_active[i] = vo_data;
      return;
    }

    self.vo_active[i] = self.vo_active[i - 1];
  }
}

function remove_vo_data(vo_data) {
  if(!(isDefined(self) && isDefined(self.vo_active))) {
    return;
  }

  found = 0;

  for(i = 0; i < self.vo_active.size; i++) {
    if(found) {
      self.vo_active[i - 1] = self.vo_active[i];
      continue;
    }

    if(self.vo_active[i] == vo_data) {
      found = 1;
    }
  }

  if(found) {
    self.vo_active[self.vo_active.size - 1] = undefined;
  }
}

function function_bf5715bcec0f160a() {
  if(!isDefined(level.vo_teams)) {
    level.vo_teams = [];
  }

  if(isDefined(self.team) && !isDefined(level.vo_teams[self.team])) {
    level.vo_teams[self.team] = spawnStruct();
  }

  scope_ents = [];
  scope_ents["self"] = function_9281e8b99794ac72();

  if(isDefined(self.team)) {
    scope_ents["team"] = level.vo_teams[self.team] function_9281e8b99794ac72();
  }

  scope_ents["global"] = level function_9281e8b99794ac72();
  return scope_ents;
}

function private function_9281e8b99794ac72() {
  if(!isDefined(self.vo_active)) {
    self.vo_active = [];
  }

  if(!isDefined(self.vo_queue)) {
    self.vo_queue = [];
  }

  return self;
}

function dialogue_length(alias) {
  return lookupsoundlength(alias, 1) / 1000;
}

function function_511f573a5f91fa32(dialogue) {
  animname = self.animname ?? "generic";

  if(!(isDefined(level.scr_face) && isDefined(level.scr_face[animname]))) {
    return;
  }

  if(isDefined(level.scr_face[animname][dialogue])) {
    return level.scr_face[animname][dialogue];
  }
}

function playsound_receivers(alias, receivers) {
  if(!isarray(receivers)) {
    receivers = [receivers];
  }

  wait 0.1;

  foreach(receiver in receivers) {
    if(utility::is_dead_or_dying(receiver) || receiver == self) {
      continue;
    }

    receiver playcontextsound(alias, "dx_type", "dx_radio_3d");
  }
}

function get_vo_emitter(tag, originoffset, anglesoffset, istemp) {
  if(!isDefined(self.vo_emitter)) {
    self.vo_emitter = get_new_vo_emitter(tag, originoffset, anglesoffset, istemp);
  }

  return self.vo_emitter;
}

function get_new_vo_emitter(tag, originoffset, anglesoffset, istemp) {
  if(isent(self)) {
    if(self tagexists("j_head")) {
      if(!isDefined(tag)) {
        tag = "j_head";
      }
    }

    originoffset = originoffset ?? (0, 0, 0);

    if(!isDefined(anglesoffset)) {
      anglesoffset = (0, 0, 0);
    }

    emitter = spawn("script_origin", self.origin);

    if(isDefined(tag)) {
      emitter linkTo(self, tag, originoffset, anglesoffset);
    } else {
      emitter linkTo(self);
    }
  } else {
    emitter = spawn("script_origin", (0, 0, 0));
    emitter.is2demitter = 1;
    emitter.name = self.name;
  }

  emitter.targetname = "get_new_vo_emitter";
  emitter.isvoemitter = 1;
  emitter.team = self.team ?? "allies";
  emitter.istempemitter = istemp;

  if(!isDefined(level.vo_emitters)) {
    level.vo_emitters = [];
  }

  level.vo_emitters[level.vo_emitters.size] = emitter;
  level.vo_emitters = function_5713d46873b29625(level.vo_emitters);

  emitter thread function_49cf64b1d54c6269(self);
  return emitter;
}

function function_49cf64b1d54c6269(parent) {
  self endon("entitydeleted");
  parent waittill("death");
  self stopsounds();
  waitframe();
  self delete();
}

function get_radio_emitter(tag, originoffset, anglesoffset, istemp) {
  if(!isDefined(self.var_8d4f5e01dc1af2e8)) {
    origin = self.origin ?? originoffset;
    self.var_8d4f5e01dc1af2e8 = spawn("script_origin", origin);
    self.var_8d4f5e01dc1af2e8.targetname = "get_radio_emitter";

    if(isent(self)) {
      if(self tagexists("j_hip_ri")) {
        if(!isDefined(tag)) {
          tag = "j_hip_ri";
        }
      }

      originoffset = originoffset ?? (0, 0, 0);

      if(!isDefined(anglesoffset)) {
        anglesoffset = (0, 0, 0);
      }

      if(isDefined(tag)) {
        self.var_8d4f5e01dc1af2e8 linkTo(self, tag, originoffset, anglesoffset);
      } else {
        self.var_8d4f5e01dc1af2e8 linkTo(self);
      }
    }

    self.var_8d4f5e01dc1af2e8.isradioemitter = 1;
    self.var_8d4f5e01dc1af2e8.battlechatterallowed = 1;
    self.var_8d4f5e01dc1af2e8.team = self.team ?? "allies";
    self.var_8d4f5e01dc1af2e8.battlechatter = spawnStruct();

    if(isDefined(self.battlechatter)) {
      self.var_8d4f5e01dc1af2e8.battlechatter.countryid = self.battlechatter.countryid;
    }

    self.var_8d4f5e01dc1af2e8.istempemitter = istemp;
  }

  return self.var_8d4f5e01dc1af2e8;
}

function get_radio_alias(alias) {
  return alias;
}

function function_f94a633a775187e1(emitter) {
  if(!isDefined(emitter)) {
    return;
  }

  emitter endon("entitydeleted");
  waittillframeend();

  if(!isDefined(self.var_861991271473c76) && isDefined(emitter)) {
    emitter stopsounds();
  }
}

function function_b0689a1ab8b93fb5(emitter) {
  if(!isDefined(emitter) || emitter == self || !emitter.istempemitter) {
    return;
  }

  emitter.shoulddelete = 1;
  emitter endon("entitydeleted");
  waitframe();

  if(emitter.shoulddelete) {
    emitter delete();
  }
}

function function_cf6c7d510f5a4b08(text) {
  setdvarifuninitialized(@ "hash_ce3d6e5d48671653", 1);
  return getdvarint(@ "hash_ce3d6e5d48671653") && (isistring(text) || !soundexists(text) && !isxhash(text) && getsubstr(text, 0, 3) != "dx_");
}

function function_ec55269db42372b(hide2d = 1, hide3d = 0) {
  level.var_a21c2157a1f961f8 = hide2d;
  level.var_a2204757a1fdab61 = hide3d;

  if(!hide2d && !hide3d) {
    return;
  }

  if(!isDefined(level.vo_active)) {
    return;
  }

  foreach(vo_data in level.vo_active) {
    speaker = vo_data.speaker;

    if(speaker.var_569f79b89b587aba < 0) {
      if(hide2d) {
        speaker notify("stop_2d_text");
      }

      if(hide3d) {
        speaker notify("stop_3d_text");
      }
    }
  }
}

function function_35ca743c0a9403bd(text, duration) {
  self endon("death");
  self endon("stop_dialogue");
  self notify("stop_3d_text");
  self endon("stop_3d_text");
  alpha = 1;

  while(!isDefined(duration) || duration + 0.3 > 0) {
    if(self tagexists("j_head")) {
      origin = self gettagorigin("j_head") + (0, 0, 15);
    } else {
      origin = self.origin + (0, 0, 70);
    }

    if(isDefined(duration) && duration < 0) {
      alpha = 1 - duration * -1 / 0.3;
    }

    print3d(origin, text, (1, 1, 1), alpha, 0.3, 1, 1);

    if(isDefined(duration)) {
      duration -= 0.05;
    }

    waitframe();
  }
}

function get_holdtime(text) {
  word_count = strtok(text, " ").size;
  return max(1.5, word_count * 0.4);
}

function function_c5c10e87844edd3f(text) {
  self notify("stop_dialogue");
  self endon("death");
  self endon("stop_dialogue");
  assert(isent(self), "<dev string:x4e7>");
  emitter = self;
  player = undefined;

  if(isPlayer(self)) {
    player = self;
  }

  if(isDefined(player) || isDefined(self.vo_emitter)) {
    emitter = get_vo_emitter();
  }

  self.var_861991271473c76 = gettime();
  self.var_cf0d3e00923233a5 = text;
  self.var_6ad6546473593e72 = undefined;
  holdtime = get_holdtime(text);
  color = get_team_color();
  name = get_name();

  if(!isistring(text) && isstartstr(text, ">>")) {
    text = "(RADIO) " + getsubstr(text, 2, text.size);
  } else if(!level.var_a2204757a1fdab61 || self.var_569f79b89b587aba >= 0) {
    if(!level.var_a2204757a1fdab61) {
      thread function_35ca743c0a9403bd(text, holdtime);
    }
  }

  var_2f12db54da85fb09 = istrue(level.var_a21c2157a1f961f8) && self.var_569f79b89b587aba < 0;

  if(var_2f12db54da85fb09 || !utility::issp()) {
    wait holdtime;
    return 1;
  }

  var_1f2d1184e020963f = int(6.96);
  lineheight = int(17.4);
  var_3a80a7bd515e3e74 = int(5.075);
  is_istring = 0;

  if(isDefined(level.var_e8f02720f642ede2) && isDefined(level.var_e8f02720f642ede2[text])) {
    lines = [level.var_e8f02720f642ede2[text]];
    is_istring = 1;
  } else {
    text = color + name + ": ^7" + text;
    lines = utility::wrap_text(text, int(500 / var_1f2d1184e020963f));
  }

  width = int(clamp(text.size * var_1f2d1184e020963f, 0, 500));
  height = lineheight * lines.size + var_3a80a7bd515e3e74;
  endy = (level.var_7429d4b8287da6a4 ?? 300) - height;

  if(!isDefined(level.vo_hud)) {
    level.vo_hud = [];
  }

  foreach(hud_elem in level.vo_hud) {
    hud_elem moveovertime(0.2);
    hud_elem.y -= height - 2;
  }

  hud_elems = [];

  foreach(i, text_line in lines) {
    text_elem = newhudelem();
    text_elem.speaker = self;
    text_elem.alpha = 0;

    if(is_istring) {
      text_elem.label = text_line;

      if(isDefined(self.var_26b46b1b3125944a) && isistring(self.var_26b46b1b3125944a)) {
        text_elem settext(self.var_26b46b1b3125944a);
      } else {
        text_elem settext(&"dialogue_temp/name_test");
      }
    } else {
      text_elem settext(text_line);
    }

    text_elem.fontscale = 0.6525;
    text_elem.font = "bigfixed";
    text_elem.row = i;
    text_elem position_hud_elem(height, endy, lineheight, var_3a80a7bd515e3e74);
    hud_elems[hud_elems.size] = text_elem;
  }

  bg = newhudelem();
  bg.alpha = 0;
  bg setshader("black", width, height);
  bg position_hud_elem(height, endy);
  hud_elems[hud_elems.size] = bg;
  level.vo_hud = arraycombine(level.vo_hud, hud_elems);
  end_time = gettime() + (0.2 + holdtime) * 1000;
  thread function_c505efe643efbba1(hud_elems, holdtime);
  self waittill("text_display_done", finished);

  if(isDefined(finished) && finished == 0) {
    remaining_time = (end_time - gettime()) / 1000;

    if(remaining_time > 0) {
      wait remaining_time;
    }

    finished = 1;
  }

  return finished;
}

function get_team_color(team = self.team) {
  if(!isDefined(team)) {
    team = "neutral";
  }

  if(isstartstr(team, "team_")) {
    return "^1";
  }

  switch (team) {
    case #"hash_7c2d091e6337bf54":
      return "^1";
    case #"hash_5f54b9bf7583687f":
    case #"hash_a571cacc018623b8":
      return "^2";
    default:
      return "^3";
  }
}

function get_name() {
  var_7237854e3be197ca = self.name;

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  var_7237854e3be197ca = self.ainame;

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  if(isPlayer(self)) {
    return "Player";
  }

  team = self.team ?? "neutral";

  if(isDefined(level.var_56bc7b213799b9a1) && isDefined(level.var_56bc7b213799b9a1[team])) {
    return level.var_56bc7b213799b9a1[team];
  }

  if(isstartstr(team, "team_")) {
    return "Enemy";
  }

  switch (self.team) {
    case #"hash_7c2d091e6337bf54":
      return "Enemy";
    case #"hash_5f54b9bf7583687f":
      return "Friendly";
    default:
      return "Civilian";
  }
}

function position_hud_elem(height, endy, lineheight, var_3a80a7bd515e3e74) {
  self.alignx = "center";
  self.aligny = "top";
  self.x = 320;
  self.y = 300 + height;
  self.sort = 5;

  if(isDefined(self.row)) {
    self.y += self.row * lineheight + var_3a80a7bd515e3e74;
  }

  self fadeovertime(0.2);

  if(isDefined(self.row)) {
    self.y = endy + self.row * lineheight + var_3a80a7bd515e3e74;
    self.alpha = 1;
    return;
  }

  self.y = endy;
  self.alpha = level.var_9e11ef2bd96ba3cf ?? 0;
}

function function_c505efe643efbba1(hud_elems, holdtime) {
  finished = function_b7382110602960a9(0.2 + holdtime);
  self notify("text_display_done", finished);

  foreach(hud_elem in hud_elems) {
    hud_elem fadeovertime(0.3);
    hud_elem.alpha = 0;
  }

  wait 0.3;
  level.vo_hud = arrayremove(level.vo_hud, hud_elems);

  if(!level.vo_hud.size) {
    level.vo_hud = undefined;
  }

  foreach(hud_elem in hud_elems) {
    hud_elem destroy();
  }
}

function function_b7382110602960a9(holdtime) {
  self endon("death");
  self endon("stop_dialogue");
  return utility::waittill_notify_or_timeout_return("stop_2d_text", holdtime) == "timeout";
}

function nag_loop(nags, repeat_delay, initial_delay, loop_limit) {
  self notify("stop_nag_loop");
  self endon("death");
  self endon("stop_nag_loop");

  if(!isDefined(initial_delay)) {
    initial_delay = repeat_delay;
  }

  if(!isDefined(level.vo_nagvars)) {
    level function_a1c8c71775715127();
  }

  assert(isDefined(nags), "<dev string:x518>");
  assert(isDefined(nags.items) && isstruct(nags) && isDefined(nags.index) || isarray(nags) || isfunction(nags), "<dev string:x531>");

  if(isarray(nags) && (nags.size == 0 || !isfunction(nags[0]))) {
    assert(nags.size, "<dev string:x55d>");
    nags = utility::create_deck(nags, 1, 0);
  }

  do_nag(nags, initial_delay);

  for(nag_count = 1; !isDefined(loop_limit) || nag_count / nags.items.size < loop_limit; nag_count++) {
    do_nag(nags, repeat_delay);
    waitframe();
  }

  self notify("finished_nag_loop");
}

function do_nag(nags, delay) {
  speaker = self;
  did_nag = 0;
  current = undefined;

  if(isarray(nags) && nags.size > 0 && isfunction(nags[0])) {
    params = arraycopy(nags);
    params[0] = undefined;

    if(isint(0)) {
      function_cdc669dbc8ea2101(params);
    }

    nags = speaker call_with_params(nags[0], params);
    assert(isDefined(nags.items) && isstruct(nags) && isDefined(nags.index) || isarray(nags) || isstring(nags), "<dev string:x58f>");
  } else if(isfunction(nags)) {
    nags = speaker call_with_params(nags);
    assert(isDefined(nags.items) && isstruct(nags) && isDefined(nags.index) || isarray(nags) || isstring(nags), "<dev string:x58f>");
  }

  if(isstruct(nags)) {
    nag = nags utility::deck_draw();
  } else {
    nag = nags;
  }

  if(isarray(nag)) {
    speaker = nag[0];
    nag = nag[1];
  }

  if(!isDefined(speaker)) {
    return;
  }

  if(isstruct(delay)) {
    current = delay.current;
  }

  result = speaker waitfor(delay);

  if(!isDefined(result) || result) {
    nagvars = self.vo_nagvars ?? level.vo_nagvars;
    did_nag = speaker say(nag, nagvars.priority, nagvars.timeout, nagvars.overlap, &started_nag, nagvars.scope);
  }

  if(!isDefined(did_nag)) {
    result = "interrupted";
  } else if(did_nag) {
    result = "finished";
  } else {
    result = "failed";

    if(isstruct(nags) && isDefined(nags.index)) {
      nags.index--;
    }

    if(isstruct(delay)) {
      delay.current = current;
    }
  }

  speaker notify("nag_" + result, nag);
  speaker notify("nag_done_or_cancelled", nag, result);
}

function started_nag() {
  if(isDefined(self.var_6ad6546473593e72)) {
    self notify("started_nag", getxhashhexname(self.var_6ad6546473593e72));
  } else {
    self notify("started_nag", undefined);
  }

  if(isDefined(self.var_51d9a95a033c556e)) {
    self thread[[self.var_51d9a95a033c556e]]();
  }

  if(isDefined(level.var_51d9a95a033c556e)) {
    level thread[[level.var_51d9a95a033c556e]]();
  }
}