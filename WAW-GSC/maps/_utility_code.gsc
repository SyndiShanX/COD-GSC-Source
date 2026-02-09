/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_utility_code.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_hud_util;

linetime_proc(start, end, color, timer) {
  for(i = 0; i < timer * 20; i++) {
    line(start, end, color);
    wait(0.05);
  }
}

structarray_swap(object1, object2) {
  index1 = object1.struct_array_index;
  index2 = object2.struct_array_index;
  self.array[index2] = object1;
  self.array[index1] = object2;
  self.array[index1].struct_array_index = index1;
  self.array[index2].struct_array_index = index2;
}

waitSpread_code(start, end) {
  waittillframeend;

  assert(level.wait_spreaders >= 1);

  allotment = [];

  if(level.wait_spreaders == 1) {
    allotment[0] = randomfloatrange(start, end);
    level.wait_spreader_allotment = allotment;
    level.active_wait_spread = undefined;
    return;
  }

  allotment[0] = start;
  allotment[allotment.size] = end;

  for(i = 1; i < level.wait_spreaders - 1; i++) {
    allotment = waitSpread_insert(allotment);
  }

  level.wait_spreader_allotment = array_randomize(allotment);
  level.active_wait_spread = undefined;
}

waitSpread_insert(allotment) {
  gapIndex = -1;
  gap = 0;
  for(p = 0; p < allotment.size - 1; p++) {
    newgap = allotment[p + 1] - allotment[p];
    if(newgap <= gap) {
      continue;
    }
    gap = newgap;
    gapIndex = p;
  }

  assert(gap > 0);
  newAllotment = [];

  for(i = 0; i < allotment.size; i++) {
    if(gapIndex == i - 1) {
      newAllotment[newAllotment.size] = randomfloatrange(allotment[gapIndex], allotment[gapIndex + 1]);
    }
    newAllotment[newAllotment.size] = allotment[i];
  }

  return newAllotment;
}

waittill_objective_event_proc(requireTrigger) {
  while(level.deathSpawner[self.script_deathChain] > 0) {
    level waittill("spawner_expired" + self.script_deathChain);
  }

  if(requireTrigger) {
    self waittill("trigger");
  }

  flag = self get_trigger_flag();
  flag_set(flag);
}

wait_until_done_speaking() {
  self endon("death");
  while(self.isSpeaking) {
    wait(0.05);
  }
}

wait_for_trigger_think(ent) {
  self endon("death");
  ent endon("trigger");
  self waittill("trigger");

  ent notify("trigger");
}

wait_for_trigger(msg, type) {
  triggers = getEntArray(msg, type);
  ent = spawnStruct();

  array_thread(triggers, ::wait_for_trigger_think, ent);
  ent waittill("trigger");
}

ent_waits_for_level_notify(msg) {
  level waittill(msg);
  self notify("done");
}

ent_waits_for_trigger(trigger) {
  trigger waittill("trigger");
  self notify("done");
}

ent_times_out(timer) {
  wait(timer);
  self notify("done");
}

update_debug_friendlycolor_on_death() {
  self notify("debug_color_update");
  self endon("debug_color_update");
  num = self.ai_number;
  self waittill("death");
  level.debug_color_friendlies[num] = undefined;

  level notify("updated_color_friendlies");
}

update_debug_friendlycolor(num) {
  thread update_debug_friendlycolor_on_death();
  if(isDefined(self.script_forceColor)) {
    level.debug_color_friendlies[num] = self.script_forceColor;
  } else {
    level.debug_color_friendlies[num] = undefined;
  }
  level notify("updated_color_friendlies");
}

insure_player_does_not_set_forcecolor_twice_in_one_frame() {
  assertEx(!isDefined(self.setforcecolor), "Tried to set forceColor on an ai twice in one frame. Don't spam set_force_color.");
  self.setforcecolor = true;
  waittillframeend;
  if(!isalive(self)) {
    return;
  }
  self.setforcecolor = undefined;
}

new_color_being_set(color) {
  self notify("new_color_being_set");
  self.new_force_color_being_set = true;
  maps\_colors::left_color_node();

  self endon("new_color_being_set");
  self endon("death");

  waittillframeend;
  waittillframeend;

  if(isDefined(self.script_forceColor)) {
    self.currentColorCode = level.currentColorForced[self.team][self.script_forceColor];
    self thread maps\_colors::goto_current_ColorIndex();
  }

  self.new_force_color_being_set = undefined;
  self notify("done_setting_new_color");

  update_debug_friendlycolor(self.ai_number);
}

radio_queue_thread(msg) {
  queueTime = gettime();
  for(;;) {
    if(!isDefined(self._radio_queue)) {
      break;
    }

    self waittill("finished_radio");
    if(gettime() > queueTime + 7500) {
      return;
    }
  }

  self._radio_queue = true;

  wait_for_buffer_time_to_pass(level.last_mission_sound_time, 0.5);

  level.player play_sound_on_entity(level.scr_radio[msg]);
  self._radio_queue = undefined;
  level.last_mission_sound_time = gettime();

  self notify("finished_radio");
}

delayThread_proc(func, timer, param1, param2, param3, param4) {
  self endon("death");
  wait(timer);
  if(isDefined(param4)) {
    thread[[func]](param1, param2, param3, param4);
  } else {
  if(isDefined(param3)) {
    thread[[func]](param1, param2, param3);
  }
  } else {
  if(isDefined(param2)) {
    thread[[func]](param1, param2);
  }
  } else {
  if(isDefined(param1)) {
    thread[[func]](param1);
  }
  } else {
    thread[[func]]();
  }
}

wait_for_flag_or_time_elapses(flagname, timer) {
  level endon(flagname);
  wait(timer);
}

ent_wait_for_flag_or_time_elapses(flagname, timer) {
  self endon(flagname);
  wait(timer);
}

waittill_either_function_internal(ent, func, parm) {
  ent endon("done");
  [[func]](parm);
  ent notify("done");
}

HintPrintWait(length, breakfunc) {
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

HintPrint(string, breakfunc) {
  MYFADEINTIME = 1.0;
  MYFLASHTIME = 0.75;
  MYALPHAHIGH = 0.95;
  MYALPHALOW = 0.4;

  flag_waitopen("global_hint_in_use");
  flag_set("global_hint_in_use");

  Hint = createFontString("objective", 2);

  Hint.alpha = 0.9;
  Hint.x = 0;
  Hint.y = -68;
  Hint.alignx = "center";
  Hint.aligny = "middle";
  Hint.horzAlign = "center";
  Hint.vertAlign = "middle";
  Hint.foreground = false;
  Hint.hidewhendead = true;

  Hint setText(string);

  Hint.alpha = 0;
  Hint FadeOverTime(MYFADEINTIME);
  Hint.alpha = MYALPHAHIGH;
  HintPrintWait(MYFADEINTIME);

  if(isDefined(breakfunc)) {
    for(;;) {
      Hint FadeOverTime(MYFLASHTIME);
      Hint.alpha = MYALPHALOW;
      HintPrintWait(MYFLASHTIME, breakfunc);

      if([[breakfunc]]()) {
        break;
      }

      Hint FadeOverTime(MYFLASHTIME);
      Hint.alpha = MYALPHAHIGH;
      HintPrintWait(MYFLASHTIME);

      if([[breakfunc]]()) {
        break;
      }
    }
  } else {
    for(i = 0; i < 5; i++) {
      Hint FadeOverTime(MYFLASHTIME);
      Hint.alpha = MYALPHALOW;
      HintPrintWait(MYFLASHTIME);

      Hint FadeOverTime(MYFLASHTIME);
      Hint.alpha = MYALPHAHIGH;
      HintPrintWait(MYFLASHTIME);
    }
  }

  Hint Destroy();
  flag_clear("global_hint_in_use");
}

lerp_player_view_to_tag_internal(ent, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo) {
  if(isPlayer(self)) {
    self endon("disconnect");
  }

  if(isDefined(self.first_frame_time) && ent.first_frame_time == gettime()) {
    wait(0.10);
  }

  origin = ent gettagorigin(tag);
  angles = ent gettagangles(tag);
  self lerp_player_view_to_position(origin, angles, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo);

  if(hit_geo) {
    return;
  }
  self playerlinkto(ent, tag, fraction, right_arc, left_arc, top_arc, bottom_arc, false);
}

lerp_player_view_to_tag_oldstyle_internal(ent, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo) {
  if(isPlayer(self)) {
    self endon("disconnect");
  }

  if(isDefined(ent.first_frame_time) && ent.first_frame_time == gettime()) {
    wait(0.10);
  }

  origin = ent gettagorigin(tag);
  angles = ent gettagangles(tag);
  self lerp_player_view_to_position_oldstyle(origin, angles, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, true);

  if(hit_geo) {
    return;
  }
  self playerlinktodelta(ent, tag, fraction, right_arc, left_arc, top_arc, bottom_arc, false);
}

lerp_player_view_to_moving_tag_oldstyle_internal(ent, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo) {
  if(isPlayer(self)) {
    self endon("disconnect");
  }

  if(isDefined(ent.first_frame_time) && ent.first_frame_time == gettime()) {
    wait(0.10);
  }

  self lerp_player_view_to_position_oldstyle(ent, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, true);

  if(hit_geo) {
    return;
  }
  self playerlinkto(ent, tag, fraction, right_arc, left_arc, top_arc, bottom_arc, false);
}

function_stack_proc(caller, func, param1, param2, param3, param4) {
  if(!isDefined(caller.function_stack)) {
    caller.function_stack = [];
  }

  caller.function_stack[caller.function_stack.size] = self;

  function_stack_caller_waits_for_turn(caller);

  if(isDefined(caller)) {
    if(isDefined(param4)) {
      caller[[func]](param1, param2, param3, param4);
    } else {
    if(isDefined(param3)) {
      caller[[func]](param1, param2, param3);
    }
    } else {
    if(isDefined(param2)) {
      caller[[func]](param1, param2);
    }
    } else {
    if(isDefined(param1)) {
      caller[[func]](param1);
    }
    } else {
      caller[[func]]();
    }

    if(isDefined(caller)) {
      caller.function_stack = array_remove(caller.function_stack, self);
      caller notify("level_function_stack_ready");
    }
  }

  if(isDefined(self)) {
    self notify("function_done");
  }
}

function_stack_caller_waits_for_turn(caller) {
  caller endon("death");
  self endon("death");
  while(caller.function_stack[0] != self) {
    caller waittill("level_function_stack_ready");
  }
}

alphabet_compare(a, b) {
  list = [];
  val = 1;
  list["0"] = val;
  val++;
  list["1"] = val;
  val++;
  list["2"] = val;
  val++;
  list["3"] = val;
  val++;
  list["4"] = val;
  val++;
  list["5"] = val;
  val++;
  list["6"] = val;
  val++;
  list["7"] = val;
  val++;
  list["8"] = val;
  val++;
  list["9"] = val;
  val++;
  list["_"] = val;
  val++;
  list["a"] = val;
  val++;
  list["b"] = val;
  val++;
  list["c"] = val;
  val++;
  list["d"] = val;
  val++;
  list["e"] = val;
  val++;
  list["f"] = val;
  val++;
  list["g"] = val;
  val++;
  list["h"] = val;
  val++;
  list["i"] = val;
  val++;
  list["j"] = val;
  val++;
  list["k"] = val;
  val++;
  list["l"] = val;
  val++;
  list["m"] = val;
  val++;
  list["n"] = val;
  val++;
  list["o"] = val;
  val++;
  list["p"] = val;
  val++;
  list["q"] = val;
  val++;
  list["r"] = val;
  val++;
  list["s"] = val;
  val++;
  list["t"] = val;
  val++;
  list["u"] = val;
  val++;
  list["v"] = val;
  val++;
  list["w"] = val;
  val++;
  list["x"] = val;
  val++;
  list["y"] = val;
  val++;
  list["z"] = val;
  val++;

  a = tolower(a);
  b = tolower(b);
  val1 = 0;
  if(isDefined(list[a])) {
    val1 = list[a];
  }

  val2 = 0;
  if(isDefined(list[b])) {
    val2 = list[b];
  }

  if(val1 > val2) {
    return "1st";
  }
  if(val1 < val2) {
    return "2nd";
  }
  return "same";
}

is_later_in_alphabet(string1, string2) {
  count = string1.size;
  if(count >= string2.size) {
    count = string2.size;
  }

  for(i = 0; i < count; i++) {
    val = alphabet_compare(string1[i], string2[i]);
    if(val == "1st") {
      return true;
    }
    if(val == "2nd") {
      return false;
    }
  }

  return string1.size > string2.size;
}

unflash_flag(seconds) {
  level endon("player_flashed");
  wait(seconds);
  flag_clear("player_flashed");
}

wait_for_sounddone_or_death(org) {
  self endon("death");
  org waittill("sounddone");
}

sound_effect() {
  self effect_soundalias();
}

effect_soundalias() {
  origin = self.v["origin"];
  alias = self.v["soundalias"];
  self exploder_delay();
  play_sound_in_space(alias, origin);
}

cannon_effect() {
  if(isDefined(self.v["repeat"])) {
    for(i = 0; i < self.v["repeat"]; i++) {
      playFX(level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);
      self exploder_delay();
    }
    return;
  }
  self exploder_delay();
  if(isDefined(self.looper)) {
    self.looper delete();
  }

  self.looper = spawnFx(getfx(self.v["fxid"]), self.v["origin"], self.v["forward"], self.v["up"]);
  triggerFx(self.looper);
  exploder_playSound();
}

exploder_delay() {
  if(!isDefined(self.v["delay"])) {
    self.v["delay"] = 0;
  }

  min_delay = self.v["delay"];
  max_delay = self.v["delay"] + 0.001;
  if(isDefined(self.v["delay_min"])) {
    min_delay = self.v["delay_min"];
  }

  if(isDefined(self.v["delay_max"])) {
    max_delay = self.v["delay_max"];
  }

  if(min_delay > 0) {
    wait(randomfloatrange(min_delay, max_delay));
  }
}

exploder_earthquake() {
  self exploder_delay();
  eq = level.earthquake[self.v["earthquake"]];
  earthquake(eq["magnitude"], eq["duration"], self.v["origin"], eq["radius"]);
}

exploder_rumble() {
  self exploder_delay();
  level.player PlayRumbleonentity(self.v["rumble"]);
}

exploder_playSound() {
  if(!isDefined(self.v["soundalias"]) || self.v["soundalias"] == "nil") {
    return;
  }
  play_sound_in_space(self.v["soundalias"], self.v["origin"]);
}

fire_effect() {
  forward = self.v["forward"];
  up = self.v["up"];

  org = undefined;

  firefxSound = self.v["firefxsound"];
  origin = self.v["origin"];
  firefx = self.v["firefx"];
  ender = self.v["ender"];
  if(!isDefined(ender)) {
    ender = "createfx_effectStopper";
  }
  timeout = self.v["firefxtimeout"];

  fireFxDelay = 0.5;
  if(isDefined(self.v["firefxdelay"])) {
    fireFxDelay = self.v["firefxdelay"];
  }

  self exploder_delay();

  if(isDefined(firefxSound)) {
    level thread loop_fx_sound(firefxSound, origin, ender, timeout);
  }

  playFX(level._effect[firefx], self.v["origin"], forward, up);
}

trail_effect() {
  self exploder_delay();

  if(!isDefined(self.v["trailfxtag"])) {
    self.v["trailfxtag"] = "tag_origin";
  }

  temp_ent = undefined;

  if(self.v["trailfxtag"] == "tag_origin") {
    playFXOnTag(level._effect[self.v["trailfx"]], self.model, self.v["trailfxtag"]);
  } else {
    temp_ent = spawn("script_model", self.model.origin);
    temp_ent setModel("tag_origin");
    temp_ent LinkTo(self.model);
    playFXOnTag(level._effect[self.v["trailfx"]], temp_ent, self.v["trailfxtag"]);
  }

  if(isDefined(self.v["trailfxsound"])) {
    if(!isDefined(temp_ent)) {
      self.model playLoopSound(self.v["trailfxsound"]);
    } else {
      temp_ent playLoopSound(self.v["trailfxsound"]);
    }
  }

  if(isDefined(self.v["ender"])) {}

  if(!isDefined(self.v["trailfxtimeout"])) {
    return;
  }

  wait(self.v["trailfxtimeout"]);

  if(isDefined(temp_ent)) {
    temp_ent Delete();
  }
}

trail_effect_ender(ent, ender) {
  ent endon("death");
  self waittill(ender);
  ent Delete();
}

init_vision_set(visionset) {
  level.lvl_visionset = visionset;

  if(!isDefined(level.vision_cheat_enabled)) {
    level.vision_cheat_enabled = false;
  }

  return level.vision_cheat_enabled;
}

array_waitlogic1(ent, msg, timeout) {
  self array_waitlogic2(ent, msg, timeout);

  self._array_wait = false;
  self notify("_array_wait");
}

array_waitlogic2(ent, msg, timeout) {
  ent endon(msg);
  ent endon("death");

  if(isDefined(timeout)) {
    wait timeout;
  } else {
    ent waittill(msg);
  }
}

exec_func(func, endons) {
  for(i = 0; i < endons.size; i++) {
    endons[i].caller endon(endons[i].ender);
  }

  if(func.parms.size == 0) {
    func.caller[[func.func]]();
  } else
  if(func.parms.size == 1) {
    func.caller[[func.func]](func.parms[0]);
  } else
  if(func.parms.size == 2) {
    func.caller[[func.func]](func.parms[0], func.parms[1]);
  } else
  if(func.parms.size == 3) {
    func.caller[[func.func]](func.parms[0], func.parms[1], func.parms[2]);
  }
}

waittill_func_ends(func, endons) {
  self endon("all_funcs_ended");
  exec_func(func, endons);
  self.count--;
  self notify("func_ended");
}