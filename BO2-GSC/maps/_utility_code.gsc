/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_utility_code.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_hud_util;
#include maps\_colors;

structarray_swap(object1, object2) {
  index1 = object1.struct_array_index;
  index2 = object2.struct_array_index;
  self.array[index2] = object1;
  self.array[index1] = object2;
  self.array[index1].struct_array_index = index1;
  self.array[index2].struct_array_index = index2;
}

waitspread_insert(allotment) {
  gapindex = -1;
  gap = 0;

  for(p = 0; p < allotment.size - 1; p++) {
    newgap = allotment[p + 1] - allotment[p];

    if(newgap <= gap) {
      continue;
    }
    gap = newgap;
    gapindex = p;
  }

  assert(gap > 0);
  newallotment = [];

  for(i = 0; i < allotment.size; i++) {
    if(gapindex == i - 1)
      newallotment[newallotment.size] = randomfloatrange(allotment[gapindex], allotment[gapindex + 1]);

    newallotment[newallotment.size] = allotment[i];
  }

  return newallotment;
}

waittill_objective_event_proc(requiretrigger) {
  while(level.deathspawner[self.script_deathchain] > 0)
    level waittill("spawner_expired" + self.script_deathchain);

  if(requiretrigger)
    self waittill("trigger");

  flag = self get_trigger_flag();
  flag_set(flag);
}

wait_until_done_speaking() {
  self endon("death");

  while(self.isspeaking)
    wait 0.05;
}

ent_waits_for_level_notify(msg) {
  level waittill(msg);
  self notify("done");
}

ent_waits_for_trigger(trigger) {
  trigger trigger_wait();
  self notify("done", trigger);
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

  if(isDefined(self.script_forcecolor))
    level.debug_color_friendlies[num] = self.script_forcecolor;
  else
    level.debug_color_friendlies[num] = undefined;

  level notify("updated_color_friendlies");
}

insure_player_does_not_set_forcecolor_twice_in_one_frame() {
  assert(!isDefined(self.setforcecolor), "Tried to set forceColor on an ai twice in one frame. Don't spam set_force_color.");
  self.setforcecolor = 1;
  waittillframeend;

  if(!isalive(self)) {
    return;
  }
  self.setforcecolor = undefined;
}

new_color_being_set(color) {
  self notify("new_color_being_set");
  self.new_force_color_being_set = 1;
  maps\_colors::left_color_node();
  self endon("new_color_being_set");
  self endon("death");
  waittillframeend;
  waittillframeend;

  if(isDefined(self.script_forcecolor)) {
    self.currentcolorcode = level.currentcolorforced[self.team][self.script_forcecolor];
    self thread maps\_colors::goto_current_colorindex();
  }

  self.new_force_color_being_set = undefined;
  self notify("done_setting_new_color");

  update_debug_friendlycolor(self.ai_number);
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

hintprintwait(length, breakfunc) {
  if(!isDefined(breakfunc)) {
    wait(length);
    return;
  }

  timer = length * 20;

  for(i = 0; i < timer; i++) {
    if([
        [breakfunc]
      ]()) {
      break;
    }

    wait 0.05;
  }
}

hintprint(string, breakfunc) {
  flag_waitopen("global_hint_in_use");
  flag_set("global_hint_in_use");
  hint = createfontstring("objective", 2);
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
  hint fadeovertime(1.0);
  hint.alpha = 0.95;
  hintprintwait(1.0);

  if(isDefined(breakfunc)) {
    for(;;) {
      hint fadeovertime(0.75);
      hint.alpha = 0.4;
      hintprintwait(0.75, breakfunc);

      if([
          [breakfunc]
        ]()) {
        break;
      }

      hint fadeovertime(0.75);
      hint.alpha = 0.95;
      hintprintwait(0.75);

      if([
          [breakfunc]
        ]()) {
        break;
      }
    }
  } else {
    for(i = 0; i < 5; i++) {
      hint fadeovertime(0.75);
      hint.alpha = 0.4;
      hintprintwait(0.75);
      hint fadeovertime(0.75);
      hint.alpha = 0.95;
      hintprintwait(0.75);
    }
  }

  hint destroy();
  flag_clear("global_hint_in_use");
}

lerp_player_view_to_tag_internal(ent, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo) {
  if(isplayer(self))
    self endon("disconnect");

  if(isDefined(self.first_frame_time) && ent.first_frame_time == gettime())
    wait 0.1;

  origin = ent gettagorigin(tag);
  angles = ent gettagangles(tag);
  self lerp_player_view_to_position(origin, angles, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo);

  if(isDefined(hit_geo) && hit_geo) {
    return;
  }
  if(isDefined(right_arc))
    self playerlinkto(ent, tag, fraction, right_arc, left_arc, top_arc, bottom_arc);
  else if(isDefined(fraction))
    self playerlinkto(ent, tag, fraction);
  else
    self playerlinkto(ent);
}

lerp_player_view_to_tag_oldstyle_internal(ent, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo) {
  if(isplayer(self))
    self endon("disconnect");

  if(isDefined(ent.first_frame_time) && ent.first_frame_time == gettime())
    wait 0.1;

  origin = ent gettagorigin(tag);
  angles = ent gettagangles(tag);
  self lerp_player_view_to_position_oldstyle(origin, angles, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, 1);

  if(hit_geo) {
    return;
  }
  self playerlinktodelta(ent, tag, fraction, right_arc, left_arc, top_arc, bottom_arc, 0);
}

lerp_player_view_to_moving_tag_oldstyle_internal(ent, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo) {
  if(isplayer(self))
    self endon("disconnect");

  if(isDefined(ent.first_frame_time) && ent.first_frame_time == gettime())
    wait 0.1;

  self lerp_player_view_to_position_oldstyle(ent, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, 1);

  if(hit_geo) {
    return;
  }
  self playerlinkto(ent, tag, fraction, right_arc, left_arc, top_arc, bottom_arc, 0);
}

function_stack_proc(caller, func, param1, param2, param3, param4) {
  if(!isDefined(caller.function_stack))
    caller.function_stack = [];

  caller.function_stack[caller.function_stack.size] = self;
  function_stack_caller_waits_for_turn(caller);

  if(isDefined(caller)) {
    if(isDefined(param4))
      caller[[func]](param1, param2, param3, param4);
    else if(isDefined(param3))
      caller[[func]](param1, param2, param3);
    else if(isDefined(param2))
      caller[[func]](param1, param2);
    else if(isDefined(param1))
      caller[[func]](param1);
    else
      caller[[func]]();

    if(isDefined(caller)) {
      arrayremovevalue(caller.function_stack, self);
      caller notify("level_function_stack_ready");
    }
  }

  if(isDefined(self))
    self notify("function_done");
}

function_stack_caller_waits_for_turn(caller) {
  caller endon("death");
  self endon("death");

  while(caller.function_stack[0] != self)
    caller waittill("level_function_stack_ready");
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

  if(isDefined(list[a]))
    val1 = list[a];

  val2 = 0;

  if(isDefined(list[b]))
    val2 = list[b];

  if(val1 > val2)
    return "1st";

  if(val1 < val2)
    return "2nd";

  return "same";
}

is_later_in_alphabet(string1, string2) {
  count = string1.size;

  if(count >= string2.size)
    count = string2.size;

  for(i = 0; i < count; i++) {
    val = alphabet_compare(string1[i], string2[i]);

    if(val == "1st")
      return true;

    if(val == "2nd")
      return false;
  }

  return string1.size > string2.size;
}

alphabetize(array) {
  if(array.size <= 1)
    return array;

  count = 0;

  for(;;) {
    changed = 0;

    for(i = 0; i < array.size - 1; i++) {
      if(is_later_in_alphabet(array[i], array[i + 1])) {
        val = array[i];
        array[i] = array[i + 1];
        array[i + 1] = val;
        changed = 1;
        count++;

        if(count >= 10) {
          count = 0;
          wait 0.05;
        }
      }
    }

    if(!changed)
      return array;
  }

  return array;
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
      playfx(level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"], self.v["primlightfrac"], self.v["lightoriginoffs"]);
      self exploder_delay();
    }

    return;
  }

  self exploder_delay();

  if(isDefined(self.looper))
    self.looper delete();

  self.looper = spawnfx(getfx(self.v["fxid"]), self.v["origin"], self.v["forward"], self.v["up"], self.v["primlightfrac"], self.v["lightoriginoffs"]);
  triggerfx(self.looper);
  exploder_playsound();
}

exploder_delay() {
  if(!isDefined(self.v["delay"]))
    self.v["delay"] = 0;

  min_delay = self.v["delay"];
  max_delay = self.v["delay"] + 0.001;

  if(isDefined(self.v["delay_min"]))
    min_delay = self.v["delay_min"];

  if(isDefined(self.v["delay_max"]))
    max_delay = self.v["delay_max"];

  if(min_delay > 0)
    wait(randomfloatrange(min_delay, max_delay));
}

exploder_earthquake() {
  earthquake_name = self.v["earthquake"];
  assert(isDefined(level.earthquake) && isDefined(level.earthquake[earthquake_name]), "No earthquake '" + earthquake_name + "' defined for exploder - call add_earthquake() in your level script.");
  self exploder_delay();
  eq = level.earthquake[earthquake_name];
  earthquake(eq["magnitude"], eq["duration"], self.v["origin"], eq["radius"]);
}

exploder_rumble() {
  self exploder_delay();
  a_players = get_players();

  if(isDefined(self.v["damage_radius"]))
    n_rumble_threshold_squared = self.v["damage_radius"] * self.v["damage_radius"];
  else {
    println("exploder #" + self.v["exploder"] + " missing script_radius KVP, using default.");

    n_rumble_threshold_squared = 16384;
  }

  for(i = 0; i < a_players.size; i++) {
    n_player_dist_squared = distancesquared(a_players[i].origin, self.v["origin"]);

    if(n_player_dist_squared < n_rumble_threshold_squared)
      a_players[i] playrumbleonentity(self.v["rumble"]);
  }
}

exploder_playsound() {
  if(!isDefined(self.v["soundalias"]) || self.v["soundalias"] == "nil") {
    return;
  }
  play_sound_in_space(self.v["soundalias"], self.v["origin"]);
}

fire_effect() {
  forward = self.v["forward"];
  up = self.v["up"];
  firefxsound = self.v["firefxsound"];
  origin = self.v["origin"];
  firefx = self.v["firefx"];
  ender = self.v["ender"];

  if(!isDefined(ender))
    ender = "createfx_effectStopper";

  timeout = self.v["firefxtimeout"];
  firefxdelay = 0.5;

  if(isDefined(self.v["firefxdelay"]))
    firefxdelay = self.v["firefxdelay"];

  self exploder_delay();

  if(isDefined(firefxsound))
    level thread loop_fx_sound(firefxsound, origin, ender, timeout);

  playfx(level._effect[firefx], self.v["origin"], forward, up, self.v["primlightfrac"], self.v["lightoriginoffs"]);
}

trail_effect() {
  self exploder_delay();

  if(!isDefined(self.v["trailfxtag"]))
    self.v["trailfxtag"] = "tag_origin";

  temp_ent = undefined;

  if(self.v["trailfxtag"] == "tag_origin")
    playfxontag(level._effect[self.v["trailfx"]], self.model, self.v["trailfxtag"]);
  else {
    temp_ent = spawn("script_model", self.model.origin);
    temp_ent setmodel("tag_origin");
    temp_ent linkto(self.model, self.v["trailfxtag"]);
    playfxontag(level._effect[self.v["trailfx"]], temp_ent, "tag_origin");
  }

  if(isDefined(self.v["trailfxsound"])) {
    if(!isDefined(temp_ent))
      self.model playloopsound(self.v["trailfxsound"]);
    else
      temp_ent playloopsound(self.v["trailfxsound"]);
  }

  if(isDefined(self.v["ender"]) && isDefined(temp_ent))
    level thread trail_effect_ender(temp_ent, self.v["ender"]);

  if(!isDefined(self.v["trailfxtimeout"])) {
    return;
  }
  wait(self.v["trailfxtimeout"]);

  if(isDefined(temp_ent))
    temp_ent delete();
}

trail_effect_ender(ent, ender) {
  ent endon("death");
  self waittill(ender);
  ent delete();
}

init_vision_set(visionset) {
  level.lvl_visionset = visionset;

  if(!isDefined(level.vision_cheat_enabled))
    level.vision_cheat_enabled = 0;

  return level.vision_cheat_enabled;
}

exec_func(func, endons) {
  for(i = 0; i < endons.size; i++)
    endons[i].caller endon(endons[i].ender);

  if(func.parms.size == 0)
    func.caller[[func.func]]();
  else if(func.parms.size == 1)
    func.caller[[func.func]](func.parms[0]);
  else if(func.parms.size == 2)
    func.caller[[func.func]](func.parms[0], func.parms[1]);
  else if(func.parms.size == 3)
    func.caller[[func.func]](func.parms[0], func.parms[1], func.parms[2]);
}

waittill_func_ends(func, endons) {
  self endon("all_funcs_ended");
  exec_func(func, endons);
  self.count--;
  self notify("func_ended");
}

mergesort(current_list, less_than, param) {
  if(!isDefined(param))
    param = undefined;

  if(current_list.size <= 1)
    return current_list;

  left = [];
  right = [];
  middle = current_list.size / 2;

  for(x = 0; x < middle; x++)
    left[left.size] = current_list[x];

  while(x < current_list.size) {
    right[right.size] = current_list[x];
    x++;
  }

  left = mergesort(left, less_than, param);
  right = mergesort(right, less_than, param);
  result = merge(left, right, less_than, param);
  return result;
}

merge(left, right, less_than, param) {
  result = [];
  li = 0;
  ri = 0;

  while(li < left.size && ri < right.size) {
    if([
        [less_than]
      ](left[li], right[ri], param)) {
      result[result.size] = left[li];
      li++;
    } else {
      result[result.size] = right[ri];
      ri++;
    }
  }

  while(li < left.size) {
    result[result.size] = left[li];
    li++;
  }

  while(ri < right.size) {
    result[result.size] = right[ri];
    ri++;
  }

  return result;
}

exchange_sort_by_handler(array, compare_func) {
  assert(isDefined(array), "Array not defined.");
  assert(isDefined(compare_func), "Compare function not defined.");

  for(i = 0; i < array.size - 1; i++) {
    for(j = i + 1; j < array.size; j++) {
      if(array[j][
          [compare_func]
        ]() < array[i][
          [compare_func]
        ]()) {
        ref = array[j];
        array[j] = array[i];
        array[i] = ref;
      }
    }
  }

  return array;
}

isheaddamage(hitloc) {
  return hitloc == "helmet" || hitloc == "head" || hitloc == "neck";
}

isprimarydamage(meansofdeath) {
  if(meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET")
    return true;

  return false;
}