/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_dialog.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#include maps\_hud_util;
#include maps\_dialog;

main() {
  level.vo = spawnstruct();
  level.vo.nag_groups = [];
}

add_dialog(str_dialog_name, str_vox_file) {
  assert(isDefined(str_dialog_name), "Undefined - str_dialog_name, passed to add_dialog()");
  assert(isDefined(str_vox_file), "Undefined - str_vox_file, passed to add_dialog()");

  if(!isDefined(level.scr_sound))
    level.scr_sound = [];

  if(!isDefined(level.scr_sound["generic"]))
    level.scr_sound["generic"] = [];

  level.scr_sound["generic"][str_dialog_name] = str_vox_file;
}

say_dialog(str_vo_line, n_delay, b_fake_ent, b_cleanup) {
  if(!isDefined(b_fake_ent))
    b_fake_ent = 0;

  if(!isDefined(b_cleanup))
    b_cleanup = 0;

  self endon("death");
  self.is_about_to_talk = 1;
  self thread _on_kill_pending_dialog();
  level endon("kill_pending_dialog");
  self endon("kill_pending_dialog");
  _add_to_spoken_dialog(str_vo_line);

  if(isDefined(n_delay) && n_delay > 0)
    wait(n_delay);

  if(isDefined(self.classname) && self.classname == "script_origin")
    b_fake_ent = 1;

  if(!b_fake_ent) {
    if(!isDefined(self.health) || self.health <= 0) {
      self.is_about_to_talk = undefined;
      return;
    }
  }

  if(isDefined(level.scr_sound) && isDefined(level.scr_sound["generic"]))
    str_vox_file = level.scr_sound["generic"][str_vo_line];

  self.is_talking = 1;

  if(isDefined(str_vox_file)) {
    if(str_vox_file[0] == "v" && str_vox_file[1] == "o" && str_vox_file[2] == "x")
      self anim_generic(self, str_vo_line);
    else
      add_temp_dialog_line_internal("TEMP VO", str_vox_file, 0);
  } else
    add_temp_dialog_line_internal("MISSING VO", str_vo_line, 0);

  self.is_talking = undefined;
  self.is_about_to_talk = undefined;
  waittillframeend;

  if(b_cleanup) {
    if(isDefined(level.scr_sound) && isDefined(level.scr_sound["generic"]) && isDefined(level.scr_sound["generic"][str_vo_line]))
      level.scr_sound["generic"][str_vo_line] = undefined;
  }
}

_on_kill_pending_dialog() {
  self endon("death");
  waittill_any_ents_two(level, "kill_pending_dialog", self, "kill_pending_dialog");
  self.is_about_to_talk = undefined;
}

_add_to_spoken_dialog(str_line) {
  if(!isDefined(level._spoken_dialog))
    level._spoken_dialog = [];

  level._spoken_dialog = add_to_array(level._spoken_dialog, str_line);
}

was_dialog_said(str_line) {
  return isDefined(level._spoken_dialog) && isinarray(level._spoken_dialog, str_line);
}

say_dialog_targetname(targetname, str_vo_line, delay) {
  e_guy = getent(targetname, "targetname");
  assert(isDefined(e_guy), "say_dialog_targetname - no entity with targetname: " + targetname);
  e_guy say_dialog(str_vo_line, delay);
}

say_dialog_flag(fl_flag, str_vo_line, delay_after_flag) {
  self endon("death");
  level endon("kill_pending_dialog");
  self endon("kill_pending_dialog");

  if(!level flag_exists(fl_flag))
    assert(0, "flag: '" + fl_flag + "' does not exist");

  flag_wait(fl_flag);
  self say_dialog(str_vo_line, delay_after_flag);
}

say_dialog_trigger(str_trigger_targetname, str_vo_line, delay_after_trigger) {
  self endon("death");
  level endon("kill_pending_dialog");
  self endon("kill_pending_dialog");
  t_trig = getent(str_trigger_targetname, "targetname");
  assert(isDefined(t_trig), "Dialog trigger not found: " + str_trigger_targetname);
  t_trig waittill("trigger");
  self say_dialog(str_vo_line, delay_after_trigger);
}

say_dialog_health_lost(percentage_health_lost, e_target_ent, str_vo_line, delay_after_health_lost) {
  self endon("death");
  level endon("kill_pending_dialog");
  self endon("kill_pending_dialog");

  while(true) {
    if(!isDefined(e_target_ent))
      health_lost = 100;
    else
      health_lost = 100 - e_target_ent.health / e_target_ent.maxhealth * 100;

    if(health_lost >= percentage_health_lost) {
      break;
    }

    wait 0.01;
  }

  self say_dialog(str_vo_line, delay_after_health_lost);
}

say_dialog_func(func_pointer, str_vo_line, delay_after_func) {
  self endon("death");
  level endon("kill_pending_dialog");
  self endon("kill_pending_dialog");

  while(true) {
    if([
        [func_pointer]
      ]()) {
      break;
    }

    wait 0.01;
  }

  self say_dialog(str_vo_line, delay_after_func);
}

kill_all_pending_dialog(e_ent) {
  if(isDefined(e_ent))
    e_ent notify("kill_pending_dialog");
  else
    level notify("kill_pending_dialog");
}

add_vo_to_nag_group(group, character, vo_line) {
  assert(isDefined(character), "Character is missing in FN: add_vo_to_nag_groupg()");
  assert(isDefined(vo_line), "Vo Line is missing in FN: add_vo_to_nag_groupg()");

  if(!isDefined(level.vo.nag_groups[group])) {
    level.vo.nag_groups[group] = spawnstruct();
    level.vo.nag_groups[group].e_ent = [];
    level.vo.nag_groups[group].str_vo_line = [];
    level.vo.nag_groups[group].num_nags = 0;
  }

  level.vo.nag_groups[group].e_ent[level.vo.nag_groups[group].e_ent.size] = character;
  level.vo.nag_groups[group].str_vo_line[level.vo.nag_groups[group].str_vo_line.size] = vo_line;
  level.vo.nag_groups[group].num_nags++;
}

start_vo_nag_group_flag(str_group, str_end_nag_flag, vo_repeat_delay, start_delay, randomize_order, repeat_multiplier, func_filter) {
  assert(isDefined(str_end_nag_flag), "str_end_nag_flag is missing in FN: start_vo_nag_group_flag()");
  level thread _start_vo_nag_group(str_group, vo_repeat_delay, start_delay, randomize_order, repeat_multiplier, func_filter, str_end_nag_flag);
}

start_vo_nag_group_trigger(str_group, t_end_nag_trigger, vo_repeat_delay, start_delay, randomize_order, repeat_multiplier, func_filter) {
  assert(isDefined(t_end_nag_trigger), "t_end_nag_trigger is missing in FN: start_vo_nag_group_trigger()");
  str_flag_name = "vo_nag_trigger_flag_" + str_group;
  flag_init(str_flag_name);
  level thread _set_flag_when_trigger_hit(str_flag_name, t_end_nag_trigger);
  level thread _start_vo_nag_group(str_group, vo_repeat_delay, start_delay, randomize_order, repeat_multiplier, func_filter, str_flag_name);
}

_set_flag_when_trigger_hit(str_flag_name, t_end_nag_trigger) {
  t_end_nag_trigger waittill("trigger");
  flag_set(str_flag_name);
}

start_vo_nag_group_func(str_group, func_end_nag, vo_repeat_delay, start_delay, randomize_order, repeat_multiplier, func_filter) {
  str_flag_name = "vo_nag_func_flag_" + str_group;
  flag_init(str_flag_name);
  level thread _set_flag_when_func_true(str_flag_name, func_end_nag);
  level thread _start_vo_nag_group(str_group, vo_repeat_delay, start_delay, randomize_order, repeat_multiplier, func_filter, str_flag_name);
}

_set_flag_when_func_true(str_flag_name, func_end_nag) {
  while(true) {
    if([
        [func_end_nag]
      ]()) {
      break;
    }

    wait 0.01;
  }

  flag_set(str_flag_name);
}

delete_vo_nag_group(str_group) {
  level.vo.nag_groups[str_group] = undefined;
}

_start_vo_nag_group(str_group, vo_repeat_delay, start_delay, randomize_order, repeat_multiplier, func_filter, end_nag_flag) {
  assert(isDefined(str_group), "Undefined 'Group' in nag call");
  assert(isDefined(vo_repeat_delay), "Undefined 'vo_repeat_delay' in nag call");
  assert(isDefined(level.vo.nag_groups[str_group]), str_group + " is not a valid VO NAG Group");

  if(isDefined(start_delay))
    wait(start_delay);

  s_vo_slot = level.vo.nag_groups[str_group];
  vo_indexes = [];

  for(i = 0; i < s_vo_slot.str_vo_line.size; i++)
    vo_indexes[i] = i;

  while(!flag(end_nag_flag)) {
    if(isDefined(randomize_order) && randomize_order == 1 && s_vo_slot.num_nags > 1) {
      last_index = vo_indexes[vo_indexes.size - 1];
      num_tries = 0;
      array_randomized = 0;

      while(!array_randomized) {
        vo_indexes = array_randomize(vo_indexes);

        if(vo_indexes[0] != last_index)
          array_randomized = 1;
        else {
          num_tries++;

          if(num_tries >= 20) {
            break;
          }
        }
      }
    }

    for(i = 0; i < s_vo_slot.num_nags; i++) {
      if(flag(end_nag_flag)) {
        continue;
      }
      index = vo_indexes[i];
      e_speaker = s_vo_slot.e_ent[index];
      str_vo_line = s_vo_slot.str_vo_line[index];
      b_play_line = 1;

      if(isDefined(func_filter) && !e_speaker[[func_filter]]())
        b_play_line = 0;

      if(b_play_line)
        e_speaker say_dialog(str_vo_line);

      next_play_delay = vo_repeat_delay;

      if(isDefined(repeat_multiplier))
        next_play_delay = next_play_delay + randomfloatrange(repeat_multiplier * -1.0, repeat_multiplier);

      if(next_play_delay > 0)
        wait(next_play_delay);
    }
  }

  level.vo.nag_groups[str_group] = undefined;
}

add_temp_dialog_line(name, msg, delay) {
  level thread add_temp_dialog_line_internal(name, msg, delay);
}

add_temp_dialog_line_internal(name, msg, delay) {
  if(isDefined(delay))
    wait(delay);

  if(!isDefined(level.dialog_huds))
    level.dialog_huds = [];

  index = 0;

  for(;;) {
    if(!isDefined(level.dialog_huds[index])) {
      break;
    }

    index++;
  }

  level.dialog_huds[index] = 1;
  hudelem = maps\_hud_util::createfontstring("default", 1.5);
  hudelem.location = 0;
  hudelem.alignx = "left";
  hudelem.aligny = "top";
  hudelem.foreground = 1;
  hudelem.sort = 20;
  hudelem.alpha = 0;

  hudelem fadeovertime(0.5);
  hudelem.alpha = 1;

  hudelem.x = 0;
  hudelem.y = 300 + index * 18;
  hudelem.label = "<" + name + "> " + msg;
  hudelem.color = (1, 1, 0);
  wait 2;

  hudelem fadeovertime(5);
  hudelem.alpha = 0;

  for(i = 0; i < 40; i++) {
    hudelem.color = (1, 1, 1 / (40 - i));

    wait 0.05;
  }

  wait 4;
  hudelem destroy();
  level.dialog_huds[index] = undefined;
  self notify("done speaking");
}

autoexec _queue_dialog_init() {
  flag_init("dialog_queue_paused");
  flag_init("dialog_convo_started");
}

queue_dialog(str_line, n_delay, start_flags, cancel_flags, b_only_once, b_priority, str_team, s_func_filter) {
  if(!isDefined(n_delay))
    n_delay = 0;

  if(!isDefined(b_only_once))
    b_only_once = 1;

  if(!isDefined(b_priority))
    b_priority = 0;

  if(!isDefined(level._dialog_queue_id))
    level._dialog_queue_id = 0;

  level._dialog_queue_id++;
  n_id = level._dialog_queue_id;

  if(!isDefined(self)) {
    return;
  }
  e_talker = self;

  if(!isDefined(level.talkers))
    level.talkers = [];

  if(!isDefined(str_team)) {
    _queue_dialog_add_talker(e_talker);
    e_talker endon("death");
    e_talker thread _queue_dialog_on_death(str_line, n_id, b_priority);
  }

  if(isDefined(cancel_flags)) {
    if(!isarray(cancel_flags))
      cancel_flags = array(cancel_flags);

    foreach(str_flag in cancel_flags) {
      if(flag(str_flag)) {
        _log_dialog(str_line, "canceled via flag set", str_flag);

        return;
      }

      level endon(str_flag);
    }

    e_talker thread _queue_dialog_on_cancel(str_line, n_id, cancel_flags, b_priority);
  }

  if(isDefined(start_flags)) {
    if(!isarray(start_flags))
      start_flags = array(start_flags);

    _log_dialog(str_line, "waiting for flag", start_flags);

    flag_wait_array(start_flags);
  }

  if(isDefined(str_team)) {
    if(n_delay > 0) {
      wait(n_delay);
      n_delay = 0;
    }

    excluders = [];
    a_talkers = getaiarray(str_team);

    if(isDefined(s_func_filter)) {
      for(i = 0; i < a_talkers.size; i++) {
        if(!a_talkers[i] call_func(s_func_filter))
          excluders[excluders.size] = a_talkers[i];
      }
    } else
      excluders = level.hero_list;

    e_talker = get_array_of_closest(level.player.origin, a_talkers, excluders)[0];

    if(isalive(e_talker)) {
      e_talker thread _queue_dialog_on_cancel(str_line, n_id, cancel_flags, b_priority);
      e_talker thread _queue_dialog_on_death(str_line, n_id, b_priority);
      e_talker endon("death");
      _queue_dialog_add_talker(e_talker);
    } else
      return;
  }

  if(b_priority)
    pause_dialog_queue(str_line, b_priority);

  _log_dialog(str_line, "waiting turn");

  _queue_dialog_wait_turn(str_line, b_priority);
  b_already_said = was_dialog_said(str_line);

  if(!b_only_once || !b_already_said) {
    _log_dialog(str_line, "playing with a " + string(n_delay) + " delay");

    if(b_priority)
      level._priority_dialog_playing = 1;

    e_talker notify("dialog_started:" + n_id);
    e_talker thread maps\_dialog::say_dialog(str_line, n_delay);
    e_talker thread _queue_dialog_on_finished(str_line, n_id, b_priority);
  } else {
    _log_dialog(str_line, "canceled because it was said already", str_flag);

    e_talker notify("_queue_dialog_on_cancel" + n_id);
    e_talker notify("dialog_canceled:" + n_id);

    if(b_priority)
      level thread unpause_dialog_queue(str_line, b_priority);
  }
}

_queue_dialog_on_finished(str_line, n_id, b_priority) {
  self endon("death");
  self endon("dialog_canceled:" + n_id);
  self waittill_dialog_finished();
  self notify("dialog_finished:" + n_id);

  _log_dialog(str_line, "finished");

  if(b_priority)
    unpause_dialog_queue(str_line, b_priority);
}

_queue_dialog_on_death(str_line, n_id, b_priority) {
  self endon("dialog_canceled:" + n_id);
  self endon("dialog_finished:" + n_id);
  self waittill("death");

  _log_dialog(str_line, "died");

  if(b_priority)
    level thread unpause_dialog_queue(str_line, b_priority);
}

_queue_dialog_on_cancel(str_line, n_id, cancel_flags, b_priority) {
  if(!isDefined(cancel_flags)) {
    return;
  }
  level notify("_queue_dialog_on_cancel" + n_id);
  level endon("_queue_dialog_on_cancel" + n_id);

  if(self != level) {
    self endon("death");
    self endon("dialog_started:" + n_id);
  }

  str_flag = flag_wait_any_array(cancel_flags);

  _log_dialog(str_line, "canceled via flag set", str_flag);

  self notify("dialog_canceled:" + n_id);
  self notify("kill_pending_dialog");

  if(b_priority)
    unpause_dialog_queue(str_line, b_priority);
}

pause_dialog_queue(str_line, b_priority) {
  if(!isDefined(b_priority))
    b_priority = 1;

  if(!flag("dialog_queue_paused")) {
    _log_dialog(str_line, "PAUSING DIALOG QUEUE");

    flag_set("dialog_queue_paused");
  }

  _queue_dialog_wait_turn(str_line, b_priority);
}

dialog_start_convo(start_flags, false_flags) {
  if(!isDefined(start_flags))
    start_flags = [];

  if(!isDefined(false_flags))
    false_flags = [];

  if(!isarray(start_flags))
    start_flags = array(start_flags);

  if(!isarray(false_flags))
    false_flags = array(false_flags);

  false_flags[false_flags.size] = "dialog_convo_started";

  while(true) {
    _queue_dialog_wait_turn(undefined, 1);

    if(isDefined(start_flags)) {
      if(any_flags_false(start_flags)) {
        flag_wait_array(start_flags);
        continue;
      }
    }

    if(isDefined(false_flags)) {
      if(any_flags_true(false_flags)) {
        flag_waitopen_array(false_flags);
        continue;
      }
    }

    break;
  }

  flag_set("dialog_convo_started");

  _log_dialog(undefined, "DIALOG START CONVO");
}

any_flags_true(a_flags) {
  foreach(str_flag in a_flags) {
    if(flag(str_flag))
      return true;
  }

  return false;
}

any_flags_false(a_flags) {
  foreach(str_flag in a_flags) {
    if(!flag(str_flag))
      return true;
  }

  return false;
}

dialog_end_convo(str_kill_notify) {
  _log_dialog(undefined, "DIALOG END CONVO");

  if(isDefined(str_kill_notify))
    level notify(str_kill_notify);

  if(isDefined(level.talkers))
    waittill_dialog_finished_array(level.talkers);

  flag_clear("dialog_convo_started");
}

unpause_dialog_queue(str_line, b_priority) {
  level._priority_dialog_playing = undefined;
  _queue_dialog_wait_turn(str_line, b_priority);
  wait 0.05;

  if(!(isDefined(level._priority_dialog_playing) && level._priority_dialog_playing)) {
    _log_dialog(str_line, "UNPAUSING DIALOG QUEUE");

    flag_clear("dialog_queue_paused");
  }
}

queue_dialog_enemy(str_line, n_delay, start_flags, cancel_flags, b_only_once, s_func_filter) {
  queue_dialog(str_line, n_delay, start_flags, cancel_flags, b_only_once, 0, "axis", s_func_filter);
}

queue_dialog_ally(str_line, n_delay, start_flags, cancel_flags, b_only_once, s_func_filter) {
  queue_dialog(str_line, n_delay, start_flags, cancel_flags, b_only_once, 0, "allies", s_func_filter);
}

priority_dialog(str_line, n_delay, start_flags, cancel_flags, b_only_once, str_team, s_func_filter) {
  queue_dialog(str_line, n_delay, start_flags, cancel_flags, b_only_once, 1, str_team, s_func_filter);
}

priority_dialog_enemy(str_line, n_delay, start_flags, cancel_flags, b_only_once, s_func_filter) {
  queue_dialog(str_line, n_delay, start_flags, cancel_flags, b_only_once, 1, "axis", s_func_filter);
}

priority_dialog_ally(str_line, n_delay, start_flags, cancel_flags, b_only_once, s_func_filter) {
  queue_dialog(str_line, n_delay, start_flags, cancel_flags, b_only_once, 1, "allies", s_func_filter);
}

waittill_dialog_queue_finished() {
  _queue_dialog_wait_turn(undefined, 0);
}

_queue_dialog_add_talker(talker) {
  level.talkers = add_to_array(level.talkers, talker, 0);
}

_queue_dialog_wait_turn(str_line, b_priority) {
  waittillframeend;

  if(isDefined(level.talkers)) {
    __new = [];

    foreach(__key, __value in level.talkers) {
      if(isDefined(__value)) {
        if(isstring(__key)) {
          __new[__key] = __value;
          continue;
        }

        __new[__new.size] = __value;
      }
    }

    level.talkers = __new;
    waittill_dialog_finished_array(level.talkers);

    if(!b_priority) {
      waittillframeend;
      flag_waitopen_array(array("dialog_queue_paused", "dialog_convo_started"));
      __new = [];

      foreach(__key, __value in level.talkers) {
        if(isDefined(__value)) {
          if(isstring(__key)) {
            __new[__key] = __value;
            continue;
          }

          __new[__new.size] = __value;
        }
      }

      level.talkers = __new;
      waittill_dialog_finished_array(level.talkers);
    }
  }
}

_log_dialog(str_line, str_msg, a_flags) {
  if(isDefined(a_flags) && !isarray(a_flags))
    a_flags = array(a_flags);

  if(!isDefined(str_line))
    str_line = "";

  str_color = _log_dialog_get_color(str_line);
  str_log_string = "^0DIALOG: '" + str_color + str_line + "^0' " + str_msg;

  if(isDefined(a_flags))
    str_log_string = str_log_string + (": " + _dialog_array_to_string(a_flags));

  println(str_log_string);
}

_log_dialog_get_color(str_line) {
  if(!isDefined(str_line) || str_line == "")
    return "";

  if(!isDefined(level._log_dialog_colors))
    level._log_dialog_colors = [];

  a_lines = getarraykeys(level._log_dialog_colors);

  if(!isinarray(a_lines, str_line)) {
    a_colors = array("^1", "^2", "^3", "^4", "^5", "^6", "^7");

    if(!isDefined(level._log_dialog_get_color))
      level._log_dialog_get_color = 0;

    level._log_dialog_get_color++;

    if(level._log_dialog_get_color >= a_colors.size)
      level._log_dialog_get_color = 0;

    level._log_dialog_colors[str_line] = a_colors[level._log_dialog_get_color];
  }

  return level._log_dialog_colors[str_line];
}

_dialog_array_to_string(array) {
  str = "^0[";

  for(i = 0; i < array.size; i++) {
    if(i > 0)
      str = str + "^0,";

    str = str + " ^5" + array[i];
  }

  str = str + "^0 ]";
  return str;
}