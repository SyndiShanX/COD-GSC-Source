/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\trigger_shared.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\teleport_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\vehicle_shared;

#namespace trigger;

autoexec __init__system__() {
  system::register(#"trigger", &__init__, undefined, undefined);
}

__init__() {
  callback::on_trigger_spawned(&trigger_think);
}

add_handler(var_60ffbed2, func_handler, func_init, var_114fa26c = 1) {
  if(isfunctionptr(var_60ffbed2) ? [[var_60ffbed2]]() : isDefined(self.(var_60ffbed2))) {
    if(isDefined(func_handler)) {
      if(var_114fa26c) {
        self callback::on_trigger_once(func_handler);
      } else {
        self callback::on_trigger(func_handler);
      }
    }

    if(isfunctionptr(func_init)) {
      [
        [func_init]
      ](var_60ffbed2);
    }
  }
}

init_flags(str_kvp) {
  tokens = util::create_flags_and_return_tokens(self.(str_kvp));
  add_tokens_to_trigger_flags(tokens);
  update_based_on_flags();
}

trigger_think() {
  self endon(#"death");
  add_handler("target", &trigger_spawner);
  add_handler("script_flag_true", undefined, &init_flags);
  add_handler("script_flag_true_any", undefined, &init_flags);
  add_handler("script_flag_false_any", undefined, &init_flags);
  add_handler("script_flag_false", undefined, &init_flags);
  add_handler("script_flag_set", &flag_set_trigger, &init_flags);
  add_handler("script_flag_clear", &flag_clear_trigger, &init_flags);
  add_handler("script_trigger_group", &trigger_group);
  add_handler("script_notify", &trigger_notify);
  add_handler("script_killspawner", &kill_spawner_trigger);
  add_handler("script_teleport_location", &teleport::team);
  add_handler(&is_trigger_once, &trigger_once);

  if(isDefined(self.script_flag_set_on_touching) || isDefined(self.script_flag_set_on_not_touching)) {
    level thread script_flag_set_touching(self);
  }

  if(is_look_trigger()) {
    level thread look_trigger(self);
    s_info = self waittill(#"trigger_look");
    self thread callback::codecallback_trigger(s_info, 1);
  }
}

function_1792c799(flags) {
  trigger_flags = function_27f2ef17(self);
  function_4e3bb793(self, trigger_flags | flags);
}

get_trigger_look_target() {
  if(isDefined(self.target)) {
    a_potential_targets = getEntArray(self.target, "targetname");
    a_targets = [];

    foreach(target in a_potential_targets) {
      if(target.classname === "script_origin") {
        if(!isDefined(a_targets)) {
          a_targets = [];
        } else if(!isarray(a_targets)) {
          a_targets = array(a_targets);
        }

        a_targets[a_targets.size] = target;
      }
    }

    a_potential_target_structs = struct::get_array(self.target);
    a_targets = arraycombine(a_targets, a_potential_target_structs, 1, 0);

    if(a_targets.size > 0) {
      assert(a_targets.size == 1, "<dev string:x38>" + self.origin + "<dev string:x4a>");
      e_target = a_targets[0];
    }
  }

  if(!isDefined(e_target)) {
    e_target = self;
  }

  return e_target;
}

look_trigger(trigger) {
  trigger endon(#"death");
  e_target = trigger get_trigger_look_target();

  if(isDefined(trigger.script_flag) && !isDefined(level.flag[trigger.script_flag])) {
    level function_ac2f203a(trigger.script_flag);
  }

  a_parameters = [];

  if(isDefined(trigger.script_parameters)) {
    a_parameters = strtok(trigger.script_parameters, ", ; ");
  }

  b_ads_check = isinarray(a_parameters, "check_ads");

  while(true) {
    waitresult = trigger waittill(#"trigger");
    e_other = waitresult.activator;

    if(isplayer(e_other)) {
      while(isDefined(e_other) && e_other istouching(trigger)) {
        if(e_other util::is_looking_at(e_target, trigger.script_dot, isDefined(trigger.script_trace) && trigger.script_trace) && (!b_ads_check || !e_other util::is_ads())) {
          trigger notify(#"trigger_look", waitresult);
        }

        waitframe(1);
      }

      continue;
    }

    assertmsg("<dev string:x6f>");
  }
}

trigger_spawner(s_info) {
  a_ai_spawners = getspawnerarray(self.target, "targetname");

  foreach(sp in a_ai_spawners) {
    if(isDefined(sp)) {
      if(isvehiclespawner(sp)) {
        level thread vehicle::_vehicle_spawn(sp);
        continue;
      }

      assert(isactorspawner(sp));
      sp thread trigger_spawner_spawn();
    }
  }
}

trigger_spawner_spawn() {
  self endon(#"death");
  self flag::script_flag_wait();
  self util::script_delay();
  self spawner::spawn();
}

trigger_notify(s_info) {
  if(isDefined(self.target)) {
    a_target_ents = getEntArray(self.target, "targetname");

    foreach(notify_ent in a_target_ents) {
      notify_ent notify(self.script_notify, s_info);
    }
  }

  level notify(self.script_notify, s_info);
}

function_ac2f203a(str_flag) {
  if(!level flag::exists(str_flag)) {
    level flag::init(str_flag);
  }

  if(!isDefined(level.trigger_flags)) {
    level.trigger_flags = [];
  }

  if(!isDefined(level.trigger_flags[str_flag])) {
    level.trigger_flags[str_flag] = [];
  }
}

flag_set_trigger() {
  a_str_flags = util::create_flags_and_return_tokens(self.script_flag_set);

  foreach(str_flag in a_str_flags) {
    level flag::set(str_flag);
  }
}

flag_clear_trigger(s_info) {
  a_str_flags = util::create_flags_and_return_tokens(self.script_flag_clear);

  foreach(str_flag in a_str_flags) {
    level flag::clear(str_flag);
  }
}

add_tokens_to_trigger_flags(tokens) {
  for(i = 0; i < tokens.size; i++) {
    flag = tokens[i];

    if(!isDefined(level.trigger_flags[flag])) {
      level.trigger_flags[flag] = [];
    } else if(!isarray(level.trigger_flags[flag])) {
      level.trigger_flags[flag] = array(level.trigger_flags[flag]);
    }

    if(!isinarray(level.trigger_flags[flag], self)) {
      level.trigger_flags[flag][level.trigger_flags[flag].size] = self;
    }
  }
}

friendly_respawn_trigger(trigger) {
  trigger endon(#"death");
  spawners = getEntArray(trigger.target, "targetname");
  assert(spawners.size == 1, "<dev string:x95>" + trigger.target + "<dev string:xda>");
  spawner = spawners[0];
  assert(!isDefined(spawner.script_forcecolor), "<dev string:xfc>" + spawner.origin + "<dev string:x113>");
  spawners = undefined;
  spawner endon(#"death");

  while(true) {
    trigger waittill(#"trigger");

    if(isDefined(trigger.script_forcecolor)) {
      level.respawn_spawners_specific[trigger.script_forcecolor] = spawner;
    } else {
      level.respawn_spawner = spawner;
    }

    level flag::set("respawn_friendlies");
    wait 0.5;
  }
}

friendly_respawn_clear(trigger) {
  trigger endon(#"death");

  while(true) {
    trigger waittill(#"trigger");
    level flag::clear("respawn_friendlies");
    wait 0.5;
  }
}

script_flag_set_touching(trigger) {
  trigger endon(#"death");

  if(isDefined(trigger.script_flag_set_on_touching)) {
    level function_ac2f203a(trigger.script_flag_set_on_touching);
  }

  if(isDefined(trigger.script_flag_set_on_not_touching)) {
    level function_ac2f203a(trigger.script_flag_set_on_not_touching);
  }

  trigger thread _detect_touched();

  while(true) {
    trigger.script_touched = 0;
    waitframe(1);
    waittillframeend();

    if(!trigger.script_touched) {
      waitframe(1);
      waittillframeend();
    }

    if(trigger.script_touched) {
      if(isDefined(trigger.script_flag_set_on_touching)) {
        level flag::set(trigger.script_flag_set_on_touching);
      }

      if(isDefined(trigger.script_flag_set_on_not_touching)) {
        level flag::clear(trigger.script_flag_set_on_not_touching);
      }

      continue;
    }

    if(isDefined(trigger.script_flag_set_on_touching)) {
      level flag::clear(trigger.script_flag_set_on_touching);
    }

    if(isDefined(trigger.script_flag_set_on_not_touching)) {
      level flag::set(trigger.script_flag_set_on_not_touching);
    }
  }
}

_detect_touched() {
  self endon(#"death");

  while(true) {
    self waittill(#"trigger");
    self.script_touched = 1;
  }
}

trigger_delete_on_touch(trigger) {
  while(true) {
    waitresult = trigger waittill(#"trigger");
    other = waitresult.activator;

    if(isDefined(other)) {
      other delete();
    }
  }
}

trigger_once(s_info) {
  waittillframeend();
  waittillframeend();

  if(isDefined(self)) {
    println("<dev string:x13d>");
    println("<dev string:x140>" + self getentitynumber() + "<dev string:x172>" + self.origin);
    println("<dev string:x13d>");

    self delete();
  }
}

get_all(...) {
  if(vararg.size == 1 && isarray(vararg[0])) {
    a_vararg = vararg[0];
  } else {
    a_vararg = vararg;
  }

  a_all = getentarraybytype(20);

  if(a_vararg.size) {
    for(i = a_all.size - 1; i >= 0; i--) {
      if(!isinarray(a_vararg, a_all[i].classname)) {
        arrayremoveindex(a_all, i);
      }
    }
  }

  return a_all;
}

is_trigger_of_type(...) {
  if(vararg.size == 1 && isarray(vararg[0])) {
    a_vararg = vararg[0];
  } else {
    a_vararg = vararg;
  }

  return isinarray(a_vararg, self.classname);
}

wait_till(str_name, str_key = "targetname", e_entity, b_assert = 1) {
  if(isDefined(str_name)) {
    triggers = getEntArray(str_name, str_key);
    assert(!b_assert || triggers.size > 0, "<dev string:x181>" + str_name + "<dev string:x197>" + str_key);

    if(triggers.size > 0) {
      if(triggers.size == 1) {
        trigger_hit = triggers[0];
        trigger_hit _trigger_wait(e_entity);
      } else {
        s_tracker = spawnStruct();
        array::thread_all(triggers, &_trigger_wait_think, s_tracker, e_entity);
        waitresult = s_tracker waittill(#"trigger");
        trigger_hit = waitresult.trigger;
        trigger_hit.who = waitresult.activator;
      }

      return trigger_hit;
    }

    return;
  }

  _trigger_wait(e_entity);
  return self;
}

_trigger_wait(e_entity) {
  self endon(#"death");

  if(isDefined(e_entity)) {
    e_entity endon(#"death");
  }

  if(!isDefined(self.delaynotify)) {
    self.delaynotify = 0;
  }

  if(is_look_trigger()) {
    assert(!isarray(e_entity), "<dev string:x1a0>");
  } else if(self.classname === "<dev string:x1cd>") {
    assert(!isarray(e_entity), "<dev string:x1de>");
  }

  while(true) {
    if(is_look_trigger()) {
      waitresult = self waittill(#"trigger_look");
      wait self.delaynotify;
      e_other = waitresult.activator;

      if(isDefined(e_entity)) {
        if(e_other !== e_entity) {
          continue;
        }
      }
    } else if(self.classname === "trigger_damage") {
      waitresult = self waittill(#"trigger");
      wait self.delaynotify;
      e_other = waitresult.activator;

      if(isDefined(e_entity)) {
        if(e_other !== e_entity) {
          continue;
        }
      }
    } else {
      waitresult = self waittill(#"trigger");
      wait self.delaynotify;
      e_other = waitresult.activator;

      if(isDefined(e_entity)) {
        if(isarray(e_entity)) {
          if(!array::is_touching(e_entity, self)) {
            continue;
          }
        } else if(!e_entity istouching(self) && e_entity !== e_other) {
          continue;
        }
      }
    }

    break;
  }

  self.who = e_other;
  return e_other;
}

_trigger_wait_think(s_tracker, e_entity) {
  self endon(#"death");
  s_tracker endon(#"trigger");
  e_other = _trigger_wait(e_entity);
  s_tracker notify(#"trigger", {
    #activator: e_other, 
    #trigger: self
  });
}

use(str_name, str_key = "targetname", ent = getplayers()[0], b_assert = 1) {
  if(isDefined(str_name)) {
    e_trig = getent(str_name, str_key);

    if(!isDefined(e_trig)) {
      if(b_assert) {
        assertmsg("<dev string:x181>" + str_name + "<dev string:x197>" + str_key);
      }

      return;
    }
  } else {
    e_trig = self;
    str_name = self.targetname;
  }

  if(isDefined(ent)) {
    e_trig useby(ent);
  } else {
    e_trig useby(e_trig);
  }

  level notify(str_name, ent);

  if(e_trig is_look_trigger()) {
    e_trig notify(#"trigger_look", {
      #entity: ent
    });
  }

  return e_trig;
}

set_flag_permissions(msg) {
  if(!isDefined(level.trigger_flags) || !isDefined(level.trigger_flags[msg])) {
    return;
  }

  level.trigger_flags[msg] = array::remove_undefined(level.trigger_flags[msg]);
  array::thread_all(level.trigger_flags[msg], &update_based_on_flags);
}

update_based_on_flags() {
  true_on = 1;

  if(isDefined(self.script_flag_true)) {
    tokens = util::create_flags_and_return_tokens(self.script_flag_true);

    for(i = 0; i < tokens.size; i++) {
      if(!level flag::get(tokens[i])) {
        true_on = 0;
        break;
      }
    }
  }

  false_on = 1;

  if(isDefined(self.script_flag_false)) {
    tokens = util::create_flags_and_return_tokens(self.script_flag_false);

    for(i = 0; i < tokens.size; i++) {
      if(level flag::get(tokens[i])) {
        false_on = 0;
        break;
      }
    }
  }

  var_369930e5 = 1;

  if(isDefined(self.script_flag_true_any)) {
    var_369930e5 = 0;
    tokens = util::create_flags_and_return_tokens(self.script_flag_true_any);

    for(i = 0; i < tokens.size; i++) {
      if(level flag::get(tokens[i])) {
        var_369930e5 = 1;
        break;
      }
    }
  }

  var_95bf6d6c = 1;

  if(isDefined(self.script_flag_false_any)) {
    var_95bf6d6c = 0;
    tokens = util::create_flags_and_return_tokens(self.script_flag_false_any);

    for(i = 0; i < tokens.size; i++) {
      if(!level flag::get(tokens[i])) {
        var_95bf6d6c = 1;
        break;
      }
    }
  }

  self triggerenable(true_on && false_on && var_369930e5 && var_95bf6d6c);
}

is_look_trigger() {
  return isDefined(self.spawnflags) && (self.spawnflags&256) == 256 && !is_trigger_of_type("trigger_damage") && !is_trigger_of_type("trigger_damage_new");
}

is_trigger_once() {
  return isDefined(self.spawnflags) && (self.spawnflags&1024) == 1024 || is_trigger_of_type("trigger_once", "trigger_once_new");
}

wait_till_any(...) {
  ent = spawnStruct();

  if(isarray(vararg[0])) {
    a_str_targetnames = vararg[0];
  } else {
    a_str_targetnames = vararg;
  }

  assert(a_str_targetnames.size, "<dev string:x20d>");
  a_triggers = [];
  a_triggers = arraycombine(a_triggers, getEntArray(a_str_targetnames[0], "targetname"), 1, 0);

  for(i = 1; i < a_str_targetnames.size; i++) {
    a_triggers = arraycombine(a_triggers, getEntArray(a_str_targetnames[i], "targetname"), 1, 0);
  }

  for(i = 0; i < a_triggers.size; i++) {
    ent thread _ent_waits_for_trigger(a_triggers[i]);
  }

  waitresult = ent waittill(#"done");
  return waitresult.trigger;
}

wait_for_either(str_targetname1, str_targetname2) {
  trigger = wait_till_any(str_targetname1, str_targetname2);
  return trigger;
}

_ent_waits_for_trigger(trigger) {
  self endon(#"done");
  trigger wait_till();
  self notify(#"done", {
    #trigger: trigger
  });
}

wait_or_timeout(n_time, str_name, str_key) {
  if(isDefined(n_time)) {
    __s = spawnStruct();
    __s endon(#"timeout");
    __s util::delay_notify(n_time, "timeout");
  }

  wait_till(str_name, str_key);
}

trigger_on_timeout(n_time, b_cancel_on_triggered = 1, str_name, str_key = "targetname") {
  trig = self;

  if(isDefined(str_name)) {
    trig = getent(str_name, str_key);
  }

  if(b_cancel_on_triggered) {
    if(trig is_look_trigger()) {
      trig endon(#"trigger_look");
    } else {
      trig endon(#"trigger");
    }
  }

  trig endon(#"death");
  wait n_time;
  trig use();
}

multiple_waits(str_trigger_name, str_trigger_notify) {
  foreach(trigger in getEntArray(str_trigger_name, "targetname")) {
    trigger thread multiple_wait(str_trigger_notify);
  }
}

multiple_wait(str_trigger_notify) {
  level endon(str_trigger_notify);
  self waittill(#"trigger");
  level notify(str_trigger_notify);
}

add_function(trigger, str_remove_on, func, param_1, param_2, param_3, param_4, param_5, param_6) {
  self thread _do_trigger_function(trigger, str_remove_on, func, param_1, param_2, param_3, param_4, param_5, param_6);
}

_do_trigger_function(trigger, str_remove_on, func, param_1, param_2, param_3, param_4, param_5, param_6) {
  self endon(#"death");
  trigger endon(#"death");

  if(isDefined(str_remove_on)) {
    trigger endon(str_remove_on);
  }

  while(true) {
    if(isstring(trigger)) {
      wait_till(trigger);
    } else {
      trigger wait_till();
    }

    util::single_thread(self, func, param_1, param_2, param_3, param_4, param_5, param_6);
  }
}

kill_spawner_trigger(s_info) {
  a_spawners = getspawnerarray(self.script_killspawner, "script_killspawner");

  foreach(sp in a_spawners) {
    sp delete();
  }

  a_ents = getEntArray(self.script_killspawner, "script_killspawner");

  foreach(ent in a_ents) {
    if(ent.classname === "spawn_manager" && ent != self) {
      ent delete();
    }
  }
}

trigger_group(s_info) {
  foreach(trig in getEntArray(self.script_trigger_group, "script_trigger_group")) {
    if(trig != self) {
      trig delete();
    }
  }
}

function_thread(ent, on_enter_payload, on_exit_payload) {
  ent endon(#"death");

  if(!isDefined(self)) {
    return;
  }

  myentnum = self getentitynumber();

  if(ent ent_already_in(myentnum)) {
    return;
  }

  add_to_ent(ent, myentnum);

  if(isDefined(on_enter_payload)) {
    [[on_enter_payload]](ent);
  }

  while(isDefined(ent) && isDefined(self) && ent istouching(self)) {
    waitframe(1);
  }

  if(isDefined(ent)) {
    if(isDefined(on_exit_payload)) {
      [
        [on_exit_payload]
      ](ent);
    }

    remove_from_ent(ent, myentnum);
  }
}

ent_already_in(var_d35ff8d8) {
  if(!isDefined(self._triggers)) {
    return false;
  }

  if(!isDefined(self._triggers[var_d35ff8d8])) {
    return false;
  }

  if(!self._triggers[var_d35ff8d8]) {
    return false;
  }

  return true;
}

add_to_ent(ent, var_d35ff8d8) {
  if(!isDefined(ent._triggers)) {
    ent._triggers = [];
  }

  ent._triggers[var_d35ff8d8] = 1;
}

remove_from_ent(ent, var_d35ff8d8) {
  if(!isDefined(ent._triggers)) {
    return;
  }

  if(!isDefined(ent._triggers[var_d35ff8d8])) {
    return;
  }

  ent._triggers[var_d35ff8d8] = 0;
}

trigger_wait() {
  self endon(#"trigger");

  if(isDefined(self.targetname)) {
    trig = getent(self.targetname, "target");

    if(isDefined(trig)) {
      trig wait_till();
    }
  }
}

run(func, ...) {
  var_3bdd90c2 = 0;

  if(isDefined(self.targetname)) {
    foreach(trig in getentarraybytype(20)) {
      if(trig.target === self.targetname) {
        trig callback::on_trigger(&function_996dfbe2, undefined, self, func, vararg);
        var_3bdd90c2 = 1;
      }
    }
  }

  if(!var_3bdd90c2) {
    util::single_thread_argarray(self, func, vararg);
  }
}

function_996dfbe2(s_info, ent, func, a_args) {
  util::single_func_argarray(ent, func, a_args);
}