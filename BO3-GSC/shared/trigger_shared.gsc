/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\trigger_shared.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace trigger;

function autoexec __init__sytem__() {
  system::register("trigger", &__init__, undefined, undefined);
}

function __init__() {
  level.fog_trigger_current = undefined;
  level.trigger_hint_string = [];
  level.trigger_hint_func = [];
  if(!isDefined(level.trigger_flags)) {
    init_flags();
  }
  trigger_funcs = [];
  trigger_funcs["trigger_unlock"] = &trigger_unlock;
  trigger_funcs["flag_set"] = &flag_set_trigger;
  trigger_funcs["flag_clear"] = &flag_clear_trigger;
  trigger_funcs["flag_set_touching"] = &flag_set_touching;
  trigger_funcs["friendly_respawn_trigger"] = &friendly_respawn_trigger;
  trigger_funcs["friendly_respawn_clear"] = &friendly_respawn_clear;
  trigger_funcs["trigger_delete"] = &trigger_turns_off;
  trigger_funcs["trigger_delete_on_touch"] = &trigger_delete_on_touch;
  trigger_funcs["trigger_off"] = &trigger_turns_off;
  trigger_funcs["delete_link_chain"] = &delete_link_chain;
  trigger_funcs["no_crouch_or_prone"] = &no_crouch_or_prone_think;
  trigger_funcs["no_prone"] = &no_prone_think;
  trigger_funcs["flood_spawner"] = &spawner::flood_trigger_think;
  trigger_funcs["trigger_spawner"] = &trigger_spawner;
  trigger_funcs["trigger_hint"] = &trigger_hint;
  trigger_funcs["exploder"] = &trigger_exploder;
  foreach(trig in get_all("trigger_radius", "trigger_multiple", "trigger_once", "trigger_box")) {
    if(isDefined(trig.spawnflags) && (trig.spawnflags & 256) == 256) {
      level thread trigger_look(trig);
    }
  }
  foreach(trig in get_all()) {
    trig check_spawnflags();
    if(trig.classname != "trigger_damage") {
      if(trig.classname != "trigger_hurt") {
        if(isDefined(trig.spawnflags) && (trig.spawnflags & 32) == 32) {
          level thread trigger_spawner(trig);
        }
      }
    }
    if(trig.classname != "trigger_once" && is_trigger_once(trig)) {
      level thread trigger_once(trig);
    }
    if(isDefined(trig.script_flag_true)) {
      level thread script_flag_true_trigger(trig);
    }
    if(isDefined(trig.script_flag_set)) {
      level thread flag_set_trigger(trig, trig.script_flag_set);
    }
    if(isDefined(trig.script_flag_set_on_touching) || isDefined(trig.script_flag_set_on_cleared)) {
      level thread script_flag_set_touching(trig);
    }
    if(isDefined(trig.script_flag_clear)) {
      level thread flag_clear_trigger(trig, trig.script_flag_clear);
    }
    if(isDefined(trig.script_flag_false)) {
      level thread script_flag_false_trigger(trig);
    }
    if(isDefined(trig.script_trigger_group)) {
      trig thread trigger_group();
    }
    if(isDefined(trig.script_notify)) {
      level thread trigger_notify(trig, trig.script_notify);
    }
    if(isDefined(trig.script_fallback)) {
      level thread spawner::fallback_think(trig);
    }
    if(isDefined(trig.script_killspawner)) {
      level thread kill_spawner_trigger(trig);
    }
    if(isDefined(trig.targetname)) {
      if(isDefined(trigger_funcs[trig.targetname])) {
        level thread[[trigger_funcs[trig.targetname]]](trig);
      }
    }
  }
}

function check_spawnflags() {}

function trigger_unlock(trigger) {
  noteworthy = "not_set";
  if(isDefined(trigger.script_noteworthy)) {
    noteworthy = trigger.script_noteworthy;
  }
  target_triggers = getEntArray(trigger.target, "targetname");
  trigger thread trigger_unlock_death(trigger.target);
  while(true) {
    array::run_all(target_triggers, &triggerenable, 0);
    trigger waittill("trigger");
    array::run_all(target_triggers, &triggerenable, 1);
    wait_for_an_unlocked_trigger(target_triggers, noteworthy);
    array::notify_all(target_triggers, "relock");
  }
}

function trigger_unlock_death(target) {
  self waittill("death");
  target_triggers = getEntArray(target, "targetname");
  array::run_all(target_triggers, &triggerenable, 0);
}

function wait_for_an_unlocked_trigger(triggers, noteworthy) {
  level endon("unlocked_trigger_hit" + noteworthy);
  ent = spawnStruct();
  for(i = 0; i < triggers.size; i++) {
    triggers[i] thread report_trigger(ent, noteworthy);
  }
  ent waittill("trigger");
  level notify("unlocked_trigger_hit" + noteworthy);
}

function report_trigger(ent, noteworthy) {
  self endon("relock");
  level endon("unlocked_trigger_hit" + noteworthy);
  self waittill("trigger");
  ent notify("trigger");
}

function get_trigger_look_target() {
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
      assert(a_targets.size == 1, ("" + self.origin) + "");
      e_target = a_targets[0];
    }
  }
  if(!isDefined(e_target)) {
    e_target = self;
  }
  return e_target;
}

function trigger_look(trigger) {
  trigger endon("death");
  e_target = trigger get_trigger_look_target();
  if(isDefined(trigger.script_flag) && !isDefined(level.flag[trigger.script_flag])) {
    level flag::init(trigger.script_flag, undefined, 1);
  }
  a_parameters = [];
  if(isDefined(trigger.script_parameters)) {
    a_parameters = strtok(trigger.script_parameters, ",; ");
  }
  b_ads_check = isinarray(a_parameters, "check_ads");
  while(true) {
    trigger waittill("trigger", e_other);
    if(isplayer(e_other)) {
      while(isDefined(e_other) && e_other istouching(trigger)) {
        if(e_other util::is_looking_at(e_target, trigger.script_dot, isDefined(trigger.script_trace) && trigger.script_trace) && (!b_ads_check || !e_other util::is_ads())) {
          trigger notify("trigger_look", e_other);
          if(isDefined(trigger.script_flag)) {
            level flag::set(trigger.script_flag);
          }
        } else if(isDefined(trigger.script_flag)) {
          level flag::clear(trigger.script_flag);
        }
        wait(0.05);
      }
      if(isDefined(trigger.script_flag)) {
        level flag::clear(trigger.script_flag);
      }
    } else {
      assertmsg("");
    }
  }
}

function trigger_spawner(trigger) {
  a_spawners = getspawnerarray(trigger.target, "targetname");
  assert(a_spawners.size > 0, ("" + trigger.origin) + "");
  trigger endon("death");
  trigger wait_till();
  foreach(sp in a_spawners) {
    if(isDefined(sp)) {
      sp thread trigger_spawner_spawn();
    }
  }
}

function trigger_spawner_spawn() {
  self endon("death");
  self flag::script_flag_wait();
  self util::script_delay();
  self spawner::spawn();
}

function trigger_notify(trigger, msg) {
  trigger endon("death");
  other = trigger wait_till();
  if(isDefined(trigger.target)) {
    a_target_ents = getEntArray(trigger.target, "targetname");
    foreach(notify_ent in a_target_ents) {
      notify_ent notify(msg, other);
    }
  }
  level notify(msg, other);
}

function flag_set_trigger(trigger, str_flag) {
  trigger endon("death");
  if(!isDefined(str_flag)) {
    str_flag = trigger.script_flag;
  }
  if(!level flag::exists(str_flag)) {
    level flag::init(str_flag, undefined, 1);
  }
  while(true) {
    trigger wait_till();
    if(isDefined(trigger.targetname) && trigger.targetname == "flag_set") {
      trigger util::script_delay();
    }
    level flag::set(str_flag);
  }
}

function flag_clear_trigger(trigger, str_flag) {
  trigger endon("death");
  if(!isDefined(str_flag)) {
    str_flag = trigger.script_flag;
  }
  if(!level flag::exists(str_flag)) {
    level flag::init(str_flag, undefined, 1);
  }
  while(true) {
    trigger wait_till();
    if(isDefined(trigger.targetname) && trigger.targetname == "flag_clear") {
      trigger util::script_delay();
    }
    level flag::clear(str_flag);
  }
}

function add_tokens_to_trigger_flags(tokens) {
  for(i = 0; i < tokens.size; i++) {
    flag = tokens[i];
    if(!isDefined(level.trigger_flags[flag])) {
      level.trigger_flags[flag] = [];
    }
    level.trigger_flags[flag][level.trigger_flags[flag].size] = self;
  }
}

function script_flag_false_trigger(trigger) {
  tokens = util::create_flags_and_return_tokens(trigger.script_flag_false);
  trigger add_tokens_to_trigger_flags(tokens);
  trigger update_based_on_flags();
}

function script_flag_true_trigger(trigger) {
  tokens = util::create_flags_and_return_tokens(trigger.script_flag_true);
  trigger add_tokens_to_trigger_flags(tokens);
  trigger update_based_on_flags();
}

function friendly_respawn_trigger(trigger) {
  trigger endon("death");
  spawners = getEntArray(trigger.target, "targetname");
  assert(spawners.size == 1, ("" + trigger.target) + "");
  spawner = spawners[0];
  assert(!isDefined(spawner.script_forcecolor), ("" + spawner.origin) + "");
  spawners = undefined;
  spawner endon("death");
  while(true) {
    trigger waittill("trigger");
    if(isDefined(trigger.script_forcecolor)) {
      level.respawn_spawners_specific[trigger.script_forcecolor] = spawner;
    } else {
      level.respawn_spawner = spawner;
    }
    level flag::set("respawn_friendlies");
    wait(0.5);
  }
}

function friendly_respawn_clear(trigger) {
  trigger endon("death");
  while(true) {
    trigger waittill("trigger");
    level flag::clear("respawn_friendlies");
    wait(0.5);
  }
}

function trigger_turns_off(trigger) {
  trigger wait_till();
  trigger triggerenable(0);
  if(!isDefined(trigger.script_linkto)) {
    return;
  }
  tokens = strtok(trigger.script_linkto, " ");
  for(i = 0; i < tokens.size; i++) {
    array::run_all(getEntArray(tokens[i], "script_linkname"), &triggerenable, 0);
  }
}

function script_flag_set_touching(trigger) {
  trigger endon("death");
  if(isDefined(trigger.script_flag_set_on_touching)) {
    level flag::init(trigger.script_flag_set_on_touching, undefined, 1);
  }
  if(isDefined(trigger.script_flag_set_on_cleared)) {
    level flag::init(trigger.script_flag_set_on_cleared, undefined, 1);
  }
  trigger thread _detect_touched();
  while(true) {
    trigger.script_touched = 0;
    wait(0.05);
    waittillframeend();
    if(!trigger.script_touched) {
      wait(0.05);
      waittillframeend();
    }
    if(trigger.script_touched) {
      if(isDefined(trigger.script_flag_set_on_touching)) {
        level flag::set(trigger.script_flag_set_on_touching);
      }
      if(isDefined(trigger.script_flag_set_on_cleared)) {
        level flag::clear(trigger.script_flag_set_on_cleared);
      }
    } else {
      if(isDefined(trigger.script_flag_set_on_touching)) {
        level flag::clear(trigger.script_flag_set_on_touching);
      }
      if(isDefined(trigger.script_flag_set_on_cleared)) {
        level flag::set(trigger.script_flag_set_on_cleared);
      }
    }
  }
}

function _detect_touched() {
  self endon("death");
  while(true) {
    self waittill("trigger");
    self.script_touched = 1;
  }
}

function trigger_delete_on_touch(trigger) {
  while(true) {
    trigger waittill("trigger", other);
    if(isDefined(other)) {
      other delete();
    }
  }
}

function flag_set_touching(trigger) {
  str_flag = trigger.script_flag;
  if(!isDefined(level.flag[str_flag])) {
    level flag::init(str_flag, undefined, 1);
  }
  while(true) {
    trigger waittill("trigger", other);
    level flag::set(str_flag);
    while(isalive(other) && other istouching(trigger) && isDefined(trigger)) {
      wait(0.25);
    }
    level flag::clear(str_flag);
  }
}

function trigger_once(trig) {
  trig endon("death");
  if(is_look_trigger(trig)) {
    trig waittill("trigger_look");
  } else {
    trig waittill("trigger");
  }
  waittillframeend();
  waittillframeend();
  if(isDefined(trig)) {
    println("");
    println((("" + trig getentitynumber()) + "") + trig.origin);
    println("");
    trig delete();
  }
}

function trigger_hint(trigger) {
  assert(isDefined(trigger.script_hint), ("" + trigger.origin) + "");
  trigger endon("death");
  if(!isDefined(level.displayed_hints)) {
    level.displayed_hints = [];
  }
  waittillframeend();
  assert(isDefined(level.trigger_hint_string[trigger.script_hint]), ("" + trigger.script_hint) + "");
  trigger waittill("trigger", other);
  assert(isplayer(other), "");
  if(isDefined(level.displayed_hints[trigger.script_hint])) {
    return;
  }
  level.displayed_hints[trigger.script_hint] = 1;
  display_hint(trigger.script_hint);
}

function trigger_exploder(trigger) {
  trigger endon("death");
  while(true) {
    trigger waittill("trigger");
    if(isDefined(trigger.target)) {
      activateclientradiantexploder(trigger.target);
    }
  }
}

function display_hint(hint) {
  if(getdvarstring("chaplincheat") == "1") {
    return;
  }
  if(isDefined(level.trigger_hint_func[hint])) {
    if([[level.trigger_hint_func[hint]]]()) {
      return;
    }
    _hint_print(level.trigger_hint_string[hint], level.trigger_hint_func[hint]);
  } else {
    _hint_print(level.trigger_hint_string[hint]);
  }
}

function _hint_print(string, breakfunc) {
  level flag::wait_till_clear("global_hint_in_use");
  level flag::set("global_hint_in_use");
  hint = hud::createfontstring("objective", 2);
  hint.alpha = 0.9;
  hint.x = 0;
  hint.y = -68;
  hint.alignx = "center";
  hint.aligny = "middle";
  hint.horzalign = "center";
  hint.vertalign = "middle";
  hint.foreground = 0;
  hint.hidewhendead = 1;
  hint settext(string);
  hint.alpha = 0;
  hint fadeovertime(1);
  hint.alpha = 0.95;
  _hint_print_wait(1);
  if(isDefined(breakfunc)) {
    for(;;) {
      hint fadeovertime(0.75);
      hint.alpha = 0.4;
      _hint_print_wait(0.75, breakfunc);
      if([[breakfunc]]()) {
        break;
      }
      hint fadeovertime(0.75);
      hint.alpha = 0.95;
      _hint_print_wait(0.75);
      if([[breakfunc]]()) {
        break;
      }
    }
  } else {
    for(i = 0; i < 5; i++) {
      hint fadeovertime(0.75);
      hint.alpha = 0.4;
      _hint_print_wait(0.75);
      hint fadeovertime(0.75);
      hint.alpha = 0.95;
      _hint_print_wait(0.75);
    }
  }
  hint destroy();
  level flag::clear("global_hint_in_use");
}

function _hint_print_wait(length, breakfunc) {
  if(!isDefined(breakfunc)) {
    wait(length);
    return;
  }
  timer = length * 20;
  for(i = 0; i < timer; i++) {
    if([[breakfunc]]()) {
      break;
    }
    wait(0.05);
  }
}

function get_all(type1, type2, type3, type4, type5, type6, type7, type8, type9) {
  if(!isDefined(type1)) {
    type1 = "trigger_damage";
    type2 = "trigger_hurt";
    type3 = "trigger_lookat";
    type4 = "trigger_once";
    type5 = "trigger_radius";
    type6 = "trigger_use";
    type7 = "trigger_use_touch";
    type8 = "trigger_box";
    type9 = "trigger_multiple";
    type10 = "trigger_out_of_bounds";
  }
  assert(_is_valid_trigger_type(type1));
  trigs = getEntArray(type1, "classname");
  if(isDefined(type2)) {
    assert(_is_valid_trigger_type(type2));
    trigs = arraycombine(trigs, getEntArray(type2, "classname"), 1, 0);
  }
  if(isDefined(type3)) {
    assert(_is_valid_trigger_type(type3));
    trigs = arraycombine(trigs, getEntArray(type3, "classname"), 1, 0);
  }
  if(isDefined(type4)) {
    assert(_is_valid_trigger_type(type4));
    trigs = arraycombine(trigs, getEntArray(type4, "classname"), 1, 0);
  }
  if(isDefined(type5)) {
    assert(_is_valid_trigger_type(type5));
    trigs = arraycombine(trigs, getEntArray(type5, "classname"), 1, 0);
  }
  if(isDefined(type6)) {
    assert(_is_valid_trigger_type(type6));
    trigs = arraycombine(trigs, getEntArray(type6, "classname"), 1, 0);
  }
  if(isDefined(type7)) {
    assert(_is_valid_trigger_type(type7));
    trigs = arraycombine(trigs, getEntArray(type7, "classname"), 1, 0);
  }
  if(isDefined(type8)) {
    assert(_is_valid_trigger_type(type8));
    trigs = arraycombine(trigs, getEntArray(type8, "classname"), 1, 0);
  }
  if(isDefined(type9)) {
    assert(_is_valid_trigger_type(type9));
    trigs = arraycombine(trigs, getEntArray(type9, "classname"), 1, 0);
  }
  if(isDefined(type10)) {
    assert(_is_valid_trigger_type(type9));
    trigs = arraycombine(trigs, getEntArray(type10, "classname"), 1, 0);
  }
  return trigs;
}

function _is_valid_trigger_type(type) {
  switch (type) {
    case "trigger_box":
    case "trigger_damage":
    case "trigger_hurt":
    case "trigger_lookat":
    case "trigger_multiple":
    case "trigger_once":
    case "trigger_out_of_bounds":
    case "trigger_radius":
    case "trigger_use":
    case "trigger_use_touch": {
      return true;
      break;
    }
    default: {
      return false;
    }
  }
}

function wait_till(str_name, str_key = "targetname", e_entity, b_assert = 1) {
  if(isDefined(str_name)) {
    triggers = getEntArray(str_name, str_key);
    if(sessionmodeiscampaignzombiesgame()) {
      if(triggers.size <= 0) {
        return;
      }
    } else {
      assert(!b_assert || triggers.size > 0, (("" + str_name) + "") + str_key);
    }
    if(triggers.size > 0) {
      if(triggers.size == 1) {
        trigger_hit = triggers[0];
        trigger_hit _trigger_wait(e_entity);
      } else {
        s_tracker = spawnStruct();
        array::thread_all(triggers, &_trigger_wait_think, s_tracker, e_entity);
        s_tracker waittill("trigger", e_other, trigger_hit);
        trigger_hit.who = e_other;
      }
      return trigger_hit;
    }
  } else {
    if(sessionmodeiscampaignzombiesgame()) {
      if(!isDefined(self)) {
        return;
      }
    }
    return _trigger_wait(e_entity);
  }
}

function _trigger_wait(e_entity) {
  self endon("death");
  if(isDefined(e_entity)) {
    e_entity endon("death");
  }
  if(is_look_trigger(self)) {
    assert(!isarray(e_entity), "");
  } else if(self.classname === "") {
    assert(!isarray(e_entity), "");
  }
  while(true) {
    if(is_look_trigger(self)) {
      self waittill("trigger_look", e_other);
      if(isDefined(e_entity)) {
        if(e_other !== e_entity) {
          continue;
        }
      }
    } else {
      if(self.classname === "trigger_damage") {
        self waittill("trigger", e_other);
        if(isDefined(e_entity)) {
          if(e_other !== e_entity) {
            continue;
          }
        }
      } else {
        self waittill("trigger", e_other);
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
    }
    break;
  }
  self.who = e_other;
  return self;
}

function _trigger_wait_think(s_tracker, e_entity) {
  self endon("death");
  s_tracker endon("trigger");
  e_other = _trigger_wait(e_entity);
  s_tracker notify("trigger", e_other, self);
}

function use(str_name, str_key = "targetname", ent = getplayers()[0], b_assert = 1) {
  if(isDefined(str_name)) {
    e_trig = getent(str_name, str_key);
    if(!isDefined(e_trig)) {
      if(b_assert) {
        assertmsg((("" + str_name) + "") + str_key);
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
  if(is_look_trigger(e_trig)) {
    e_trig notify("trigger_look", ent);
  }
  return e_trig;
}

function set_flag_permissions(msg) {
  if(!isDefined(level.trigger_flags) || !isDefined(level.trigger_flags[msg])) {
    return;
  }
  level.trigger_flags[msg] = array::remove_undefined(level.trigger_flags[msg]);
  array::thread_all(level.trigger_flags[msg], &update_based_on_flags);
}

function update_based_on_flags() {
  true_on = 1;
  if(isDefined(self.script_flag_true)) {
    true_on = 0;
    tokens = util::create_flags_and_return_tokens(self.script_flag_true);
    for(i = 0; i < tokens.size; i++) {
      if(level flag::get(tokens[i])) {
        true_on = 1;
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
  b_enable = true_on && false_on;
  self triggerenable(b_enable);
}

function init_flags() {
  level.trigger_flags = [];
}

function is_look_trigger(trig) {
  return true;
}

function is_trigger_once(trig) {
  return true;
}

function wait_for_either(str_targetname1, str_targetname2) {
  ent = spawnStruct();
  array = [];
  array = arraycombine(array, getEntArray(str_targetname1, "targetname"), 1, 0);
  array = arraycombine(array, getEntArray(str_targetname2, "targetname"), 1, 0);
  for(i = 0; i < array.size; i++) {
    ent thread _ent_waits_for_trigger(array[i]);
  }
  ent waittill("done", t_hit);
  return t_hit;
}

function _ent_waits_for_trigger(trigger) {
  trigger wait_till();
  self notify("done", trigger);
}

function wait_or_timeout(n_time, str_name, str_key) {
  if(isDefined(n_time)) {
    __s = spawnStruct();
    __s endon("timeout");
    __s util::delay_notify(n_time, "timeout");
  }
  wait_till(str_name, str_key);
}

function trigger_on_timeout(n_time, b_cancel_on_triggered = 1, str_name, str_key = "targetname") {
  trig = self;
  if(isDefined(str_name)) {
    trig = getent(str_name, str_key);
  }
  if(b_cancel_on_triggered) {
    if(is_look_trigger(trig)) {
      trig endon("trigger_look");
    } else {
      trig endon("trigger");
    }
  }
  trig endon("death");
  wait(n_time);
  trig use();
}

function multiple_waits(str_trigger_name, str_trigger_notify) {
  foreach(trigger in getEntArray(str_trigger_name, "targetname")) {
    trigger thread multiple_wait(str_trigger_notify);
  }
}

function multiple_wait(str_trigger_notify) {
  level endon(str_trigger_notify);
  self waittill("trigger");
  level notify(str_trigger_notify);
}

function add_function(trigger, str_remove_on, func, param_1, param_2, param_3, param_4, param_5, param_6) {
  self thread _do_trigger_function(trigger, str_remove_on, func, param_1, param_2, param_3, param_4, param_5, param_6);
}

function _do_trigger_function(trigger, str_remove_on, func, param_1, param_2, param_3, param_4, param_5, param_6) {
  self endon("death");
  trigger endon("death");
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

function kill_spawner_trigger(trigger) {
  trigger wait_till();
  a_spawners = getspawnerarray(trigger.script_killspawner, "script_killspawner");
  foreach(sp in a_spawners) {
    sp delete();
  }
  a_ents = getEntArray(trigger.script_killspawner, "script_killspawner");
  foreach(ent in a_ents) {
    if(ent.classname === "spawn_manager" && ent != trigger) {
      ent delete();
    }
  }
}

function get_script_linkto_targets() {
  targets = [];
  if(!isDefined(self.script_linkto)) {
    return targets;
  }
  tokens = strtok(self.script_linkto, " ");
  for(i = 0; i < tokens.size; i++) {
    token = tokens[i];
    target = getent(token, "script_linkname");
    if(isDefined(target)) {
      targets[targets.size] = target;
    }
  }
  return targets;
}

function delete_link_chain(trigger) {
  trigger waittill("trigger");
  targets = trigger get_script_linkto_targets();
  array::thread_all(targets, &delete_links_then_self);
}

function delete_links_then_self() {
  targets = get_script_linkto_targets();
  array::thread_all(targets, &delete_links_then_self);
  self delete();
}

function no_crouch_or_prone_think(trigger) {
  while(true) {
    trigger waittill("trigger", other);
    if(!isplayer(other)) {
      continue;
    }
    while(other istouching(trigger)) {
      other allowprone(0);
      other allowcrouch(0);
      wait(0.05);
    }
    other allowprone(1);
    other allowcrouch(1);
  }
}

function no_prone_think(trigger) {
  while(true) {
    trigger waittill("trigger", other);
    if(!isplayer(other)) {
      continue;
    }
    while(other istouching(trigger)) {
      other allowprone(0);
      wait(0.05);
    }
    other allowprone(1);
  }
}

function trigger_group() {
  self thread trigger_group_remove();
  level endon("trigger_group_" + self.script_trigger_group);
  self waittill("trigger");
  level notify("trigger_group_" + self.script_trigger_group, self);
}

function trigger_group_remove() {
  level waittill("trigger_group_" + self.script_trigger_group, trigger);
  if(self != trigger) {
    self delete();
  }
}

function function_d1278be0(ent, on_enter_payload, on_exit_payload) {
  ent endon("entityshutdown");
  if(ent ent_already_in(self)) {
    return;
  }
  add_to_ent(ent, self);
  if(isDefined(on_enter_payload)) {
    [[on_enter_payload]](ent);
  }
  while(isDefined(ent) && ent istouching(self)) {
    wait(0.01);
  }
  if(isDefined(ent) && isDefined(on_exit_payload)) {
    [[on_exit_payload]](ent);
  }
  if(isDefined(ent)) {
    remove_from_ent(ent, self);
  }
}

function ent_already_in(trig) {
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

function add_to_ent(ent, trig) {
  if(!isDefined(ent._triggers)) {
    ent._triggers = [];
  }
  ent._triggers[trig getentitynumber()] = 1;
}

function remove_from_ent(ent, trig) {
  if(!isDefined(ent._triggers)) {
    return;
  }
  if(!isDefined(ent._triggers[trig getentitynumber()])) {
    return;
  }
  ent._triggers[trig getentitynumber()] = 0;
}