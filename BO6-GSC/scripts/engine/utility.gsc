/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\engine\utility.gsc
**************************************/

#using scripts\common\anim;
#using scripts\common\createfx;
#using scripts\common\exploder;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\engine\flags;
#using scripts\engine\trace;
#namespace utility;

function noself_func(func, ...) {
  if(!isDefined(level.func[func])) {
    return;
  }

  builtin[[level.func[func]]](flat_args(vararg, varargcount));
}

function noself_func_return(func, ...) {
  if(!isDefined(level.func[func])) {
    return undefined;
  }

  return builtin[[level.func[func]]](flat_args(vararg, varargcount));
}

function self_func(func, ...) {
  if(!isDefined(level.func[func])) {
    return;
  }

  return self builtin[[level.func[func]]](flat_args(vararg, varargcount));
}

function script_func(func, ...) {
  if(!isDefined(level.func[func])) {
    return;
  }

  return self[[level.func[func]]](flat_args(vararg, varargcount));
}

function randomvector(num) {
  return (randomfloat(num) - num * 0.5, randomfloat(num) - num * 0.5, randomfloat(num) - num * 0.5);
}

function randomvectorrange(num_min, num_max) {
  assert(isDefined(num_min));
  assert(isDefined(num_max));
  x = randomfloatrange(num_min, num_max);

  if(randomint(2) == 0) {
    x *= -1;
  }

  y = randomfloatrange(num_min, num_max);

  if(randomint(2) == 0) {
    y *= -1;
  }

  z = randomfloatrange(num_min, num_max);

  if(randomint(2) == 0) {
    z *= -1;
  }

  return (x, y, z);
}

function randomvectorrangeflat(num_min, num_max) {
  x = randomfloatrange(num_min, num_max);

  if(randomint(2) == 0) {
    x *= -1;
  }

  y = randomfloatrange(num_min, num_max);

  if(randomint(2) == 0) {
    y *= -1;
  }

  return (x, y, 0);
}

function sign(x) {
  return x >= 0 ? 1 : -1;
}

function vectorsign(vec) {
  return (sign(vec[0]), sign(vec[1]), sign(vec[2]));
}

function randomonunitsphere() {
  theta = randomfloat(180);
  phi = randomfloat(360);
  x = cos(phi) * cos(theta);
  y = cos(phi) * sin(theta);
  z = sin(phi);
  return (x, y, z);
}

function function_9e0df7b136ab833c() {
  angle = randomfloat(360);
  dist = randomfloat(1);
  x = cos(angle) * dist;
  y = sin(angle) * dist;
  return (x, y, 0);
}

function function_d8f5310928e6277f() {
  while(true) {
    x = randomfloatrange(-1, 1);
    y = randomfloatrange(-1, 1);

    if(x * x + y * y < 1) {
      return (x, y, 0);
    }
  }
}

function get_enemy_team(team) {
  assert(team != "<dev string:x24>", "<dev string:x2f>");
  teams = [];
  teams["axis"] = "allies";
  teams["allies"] = "axis";
  return teams[team];
}

function clear_exception(type) {
  assert(isDefined(self.exception[type]));
  self.exception[type] = anim.defaultexception;
}

function cointoss() {
  return randomint(100) >= 50;
}

function percent_chance(probability) {
  assert(isDefined(probability), "<dev string:x4e>");
  return randomfloat(100) < probability;
}

function choose_from_weighted_array(values, weights) {
  assert(values.size == weights.size);
  randomval = randomint(weights[weights.size - 1] + 1);

  for(i = 0; i < weights.size; i++) {
    if(randomval <= weights[i]) {
      return values[i];
    }
  }
}

function function_e7229273e829f2f9(minimums, maximums, weights) {
  assert(minimums.size == maximums.size);
  assert(minimums.size == weights.size);
  return {
    #weights: weights, #maximums: maximums, #minimums: minimums
  };
}

function function_6bc2a113a01b4ad3() {
  totalweight = array_sum(self.weights);
  pivotvalue = randomfloat(totalweight);
  pivotlowerbound = 0;
  pivotupperbound = 0;

  for(i = 0; i < self.weights.size; i++) {
    weight = self.weights[i];
    minimum = self.minimums[i];
    maximum = self.maximums[i];
    pivotupperbound += weight;

    if(pivotlowerbound <= pivotvalue && pivotvalue < pivotupperbound) {
      return randomfloatrange(minimum, maximum);
    }

    pivotlowerbound = pivotupperbound;
  }

  throw ("histogramSample() did not select any range. This should not be possible.");
  return randomfloatrange(self.minimums[self.minimums.size - 1], self.maximums[self.maximums.size - 1]);
}

function waittill_string(msg, ent) {
  if(msg != "death") {
    self endon("death");
  }

  ent endon("die");
  self waittill(msg);
  ent notify("returned", msg);
}

function waittill_string_no_endon_death(msg, ent) {
  ent endon("die");
  self waittill(msg);
  ent notify("returned", msg);
}

function function_cbd0402bd3cd13f1(string, ent) {
  ent endon("die");
  self waittill(string, msg);
  ent notify("returned", msg);
}

function waittill_multiple(...) {
  self endon("death");
  ent = spawnStruct();
  ent.threads = 0;

  foreach(varstring in vararg) {
    childthread waittill_string(varstring, ent);
    ent.threads++;
  }

  while(ent.threads) {
    ent waittill("returned");
    ent.threads--;
  }

  ent notify("die");
}

function waittillmatch_string(stringmatch, msg, ent) {
  if(stringmatch != "death" && msg != "death") {
    self endon("death");
  }

  ent endon("die");
  self waittillmatch(stringmatch, msg);
  ent notify("returned", msg);
}

function function_8037626f98cd5225(stringmatch, msg, ent) {
  ent endon("die");
  self waittillmatch(stringmatch, msg);
  ent notify("returned", msg);
}

function waittillmatch_notify(anim_name, match_msg, notify_str) {
  self endon("death");
  self waittillmatch(anim_name, match_msg);
  self notify(notify_str);
}

function waittill_any_return(...) {
  assert(varargcount >= 1);

  if(!arraycontains(vararg, "death")) {
    self endon("death");
  }

  ent = spawnStruct();

  foreach(varstring in vararg) {
    childthread waittill_string(varstring, ent);
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittillmatch_any_return(stringmatch, ...) {
  if(stringmatch != "death") {
    self endon("death");
  }

  ent = spawnStruct();

  foreach(varstring in vararg) {
    childthread function_8037626f98cd5225(stringmatch, varstring, ent);
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_return_no_endon_death(...) {
  ent = spawnStruct();

  foreach(varstring in vararg) {
    childthread waittill_string_no_endon_death(varstring, ent);
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_in_array(string_array) {
  assert(string_array.size > 0, "<dev string:x75>");

  for(i = 0; i < string_array.size - 1; i++) {
    self endon(string_array[i]);
  }

  self waittill(string_array[string_array.size - 1]);
}

function function_86c5bdf01bdba64e(var_926e6a33547a89f5) {
  assert(isDefined(var_926e6a33547a89f5));
  assert(var_926e6a33547a89f5.size > 0);
  ent = spawnStruct();
  ent.threads = 0;

  for(i = 0; i < var_926e6a33547a89f5.size; i++) {
    pair = var_926e6a33547a89f5[i];
    pair.ent childthread waittill_any_in_array_notify_ent(pair.msg_array, ent);
    ent.threads++;
  }

  while(ent.threads) {
    ent waittill("returned");
    ent.threads--;
  }

  ent notify("die");
}

function waittill_any_in_array_notify_ent(msg_array, ent) {
  assert(isDefined(msg_array) && isDefined(ent));
  assert(msg_array.size > 0);
  self endon("die");
  waittill_any_in_array(msg_array);
  ent notify("returned");
}

function waittill_any_in_array_return(string_array) {
  ent = spawnStruct();
  hasdeath = 0;

  foreach(string in string_array) {
    childthread waittill_string(string, ent);

    if(string == "death") {
      hasdeath = 1;
    }
  }

  if(!hasdeath) {
    self endon("death");
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_in_array_return_no_endon_death(string_array) {
  ent = spawnStruct();

  foreach(string in string_array) {
    childthread waittill_string_no_endon_death(string, ent);
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_in_array_or_timeout(string_array, timeout) {
  ent = spawnStruct();
  hasdeath = 0;

  foreach(string in string_array) {
    childthread waittill_string(string, ent);

    if(string == "death") {
      hasdeath = 1;
    }
  }

  if(!hasdeath) {
    self endon("death");
  }

  ent childthread timeout_struct(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_in_array_or_timeout_no_endon_death(string_array, timeout) {
  ent = spawnStruct();

  foreach(string in string_array) {
    childthread waittill_string_no_endon_death(string, ent);
  }

  ent thread timeout_struct(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_all_in_array(string_array) {
  assert(isDefined(string_array));
  assert(isarray(string_array));

  while(string_array.size) {
    msg = waittill_any_in_array_return(string_array);
    string_array = arrayremove(string_array, msg);
  }
}

function waittill_any_timeout(timeout, ...) {
  if(!arraycontains(vararg, "death")) {
    self endon("death");
  }

  ent = spawnStruct();

  foreach(varstring in vararg) {
    childthread waittill_string(varstring, ent);
  }

  ent childthread timeout_struct(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function timeout_struct(delay) {
  self endon("die");

  if(delay > 0) {
    wait delay;
  } else {
    waitframe();
  }

  self notify("returned", "timeout");
}

function waittill_any_timeout_no_endon_death(timeout, ...) {
  ent = spawnStruct();

  foreach(varstring in vararg) {
    childthread waittill_string_no_endon_death(varstring, ent);
  }

  ent childthread timeout_struct(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any(string1, ...) {
  assert(isDefined(string1));

  foreach(otherstring in vararg) {
    self endon(otherstring);
  }

  self waittill(string1);
}

function waittill_any_ents(ent1, string1, ...) {
  assert(isDefined(ent1));
  assert(isDefined(string1));

  function_8ae6ad9600816017(flat_args(vararg, varargcount));

  i = 0;

  while(i < varargcount) {
    if(isDefined(vararg[i]) && isDefined(vararg[i + 1])) {
      vararg[i] endon(vararg[i + 1]);
    }

    i += 2;
  }

  ent1 waittill(string1);
}

function function_1e67f95b5bdb410(delay, ...) {
  assert(isDefined(delay));

  function_8ae6ad9600816017(flat_args(vararg, varargcount));

  i = 0;

  while(i < varargcount) {
    if(isDefined(vararg[i]) && isDefined(vararg[i + 1])) {
      vararg[i] endon(vararg[i + 1]);
    }

    i += 2;
  }

  wait delay;
}

function waittill_any_ents_return(...) {
  function_8ae6ad9600816017(flat_args(vararg, varargcount));

  self endon("death");
  ent = spawnStruct();
  i = 0;

  while(i < varargcount) {
    if(isDefined(vararg[i]) && isDefined(vararg[i + 1])) {
      vararg[i] childthread waittill_string(vararg[i + 1], ent);
    }

    i += 2;
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_ents_return_no_endon_death(...) {
  function_8ae6ad9600816017(flat_args(vararg, varargcount));

  self endon("death");
  ent = spawnStruct();
  i = 0;

  while(i < varargcount) {
    if(isDefined(vararg[i]) && isDefined(vararg[i + 1])) {
      vararg[i] childthread waittill_string_no_endon_death(vararg[i + 1], ent);
    }

    i += 2;
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function function_247f4cc1c6c325d1(ents, string) {
  assert(isDefined(ents));
  assert(isDefined(string));
  self endon("death");
  dummyent = spawnStruct();

  foreach(ent in ents) {
    ent childthread function_cbd0402bd3cd13f1(string, dummyent);
  }

  dummyent waittill("returned", msg);
  dummyent notify("die");
  return msg;
}

function waittill_any_ents_array(ents, string1, ...) {
  assert(isDefined(ents));
  assert(isarray(ents));
  assert(isDefined(ents[0]));
  assert(isDefined(string1));

  foreach(ent in ents) {
    if(ent != ents[0]) {
      ent endon(string1);
    }

    foreach(varstring in vararg) {
      ent endon(varstring);
    }
  }

  ents[0] waittill(string1);
}

function wait_time_in_ms(waittimems) {
  endtimems = gettime() + waittimems;

  while(gettime() < endtimems) {
    waitframe();
  }
}

function function_f87fb88f9c5add54(var_ab9ec058017ae13, var_2d0993b24a32cf26, time) {
  level endon("game_ended");
  ent = spawnStruct();
  ent.threads = 0;

  foreach(endonnotify in var_2d0993b24a32cf26) {
    self endon(endonnotify);
  }

  foreach(stringnotify in var_ab9ec058017ae13) {
    childthread waittill_string_no_endon_death(stringnotify, ent);
    ent.threads++;
  }

  while(ent.threads) {
    if(ent.threads == 1) {
      if(isDefined(time)) {
        ent childthread timeout_struct(time);
        ent waittill("returned", msg);

        if(msg == "timeout") {
          self notify("monitorNotify", "timeout");
          return "timeout";
        } else {
          self notify("monitorNotify", "success");
          return "success";
        }

        ent.threads--;
      }

      continue;
    }

    ent waittill("returned", message);
    ent.threads--;
  }

  ent notify("die");
  return "timeout";
}

function script_delay() {
  if(isDefined(self.script_delay)) {
    wait self.script_delay;
    return true;
  } else if(isDefined(self.script_delay_min) && isDefined(self.script_delay_max)) {
    wait randomfloatrange(self.script_delay_min, self.script_delay_max);
    return true;
  }

  return false;
}

function script_wait() {
  starttime = gettime();

  if(isDefined(self.script_wait)) {
    wait self.script_wait;

    if(isDefined(self.script_wait_add)) {
      self.script_wait += self.script_wait_add;
    }
  } else if(isDefined(self.script_wait_min) && isDefined(self.script_wait_max)) {
    wait randomfloatrange(self.script_wait_min, self.script_wait_max);

    if(isDefined(self.script_wait_add)) {
      self.script_wait_min += self.script_wait_add;
      self.script_wait_max += self.script_wait_add;
    }
  }

  return gettime() - starttime;
}

function ispointinwater(point) {
  excludearray = [];
  return physics_querypoint(point, 0, physics_createcontents(["physicscontents_water"]), excludearray, "physicsquery_any");
}

function isflashed() {
  if(!isDefined(self.flashendtime)) {
    return false;
  }

  return gettime() < self.flashendtime;
}

function isstunned() {
  if(!isDefined(self.stunendtime)) {
    return false;
  }

  return gettime() < self.stunendtime;
}

function flag_exist(message) {
  return isDefined(level.flag[message]);
}

function flag(message) {
  assert(isDefined(message), "<dev string:xa0>");
  return istrue(level.flag[message]);
}

function flag_init(message) {
  if(!isDefined(level.flag)) {
    flags::init_flags();
  }

  if(level.first_frame == -1) {
    assert(!isDefined(level.flag[message]), "<dev string:xd5>" + message);
  }

  level.flag[message] = 0;
  init_trigger_flags();

  if(!isDefined(level.trigger_flags[message])) {
    level.trigger_flags[message] = [];
  }
}

function empty_init_func(...) {}

function flag_set(message, setter) {
  if(!flag_exist(message)) {
    flag_init(message);
  }

  level.flag[message] = 1;
  set_trigger_flag_permissions(message);

  if(isDefined(setter)) {
    level notify(message, setter);
    return;
  }

  level notify(message);
}

function function_5085f5ebc9b25c97(flags, delay, condition, ...) {
  level endon("game_ended");

  while(![[condition]](flat_args(vararg, varargcount))) {
    wait delay;
  }

  if(isarray(flags)) {
    flag_set_array(flags);
    return;
  }

  flag_set(flags);
}

function flag_set_array(flag_array) {
  foreach(flg in flag_array) {
    flag_set(flg);
  }
}

function flag_wait(msg) {
  while(!flag(msg)) {
    level waittill(msg);
  }
}

function flag_clear(message) {
  if(!flag(message)) {
    return;
  }

  level.flag[message] = 0;
  set_trigger_flag_permissions(message);
  level notify(message);
}

function flag_waitopen(msg) {
  while(flag(msg)) {
    level waittill(msg);
  }
}

function function_3bac2711d6c0a58f(flags) {
  flags = function_5713d46873b29625(flags);

  foreach(f in flags) {
    if(!flag(f)) {
      return;
    }
  }

  while(true) {
    f = level waittill_any_in_array_return(flags);

    if(!flag(f)) {
      return;
    }
  }
}

function flag_waitopen_any(...) {
  function_3bac2711d6c0a58f(vararg);
}

function trigger_on(name, type) {
  if(isDefined(name) && isDefined(type)) {
    ents = getEntArray(name, type);
    array_thread(ents, &trigger_on_proc);
    vols = getnoentvolumearray(name, type);
    array_thread(vols, &trigger_on_proc);
    return;
  }

  trigger_on_proc();
}

function trigger_on_proc() {
  self triggerenable();
  self.trigger_off = undefined;
}

function trigger_off(name, type) {
  if(isDefined(name) && isDefined(type)) {
    ents = getEntArray(name, type);
    array_thread(ents, &trigger_off_proc);
    vols = getnoentvolumearray(name, type);
    array_thread(vols, &trigger_off_proc);
    return;
  }

  trigger_off_proc();
}

function trigger_off_proc() {
  if(issubstr(self.classname, "trigger")) {
    self triggerdisable();
  }

  self.trigger_off = 1;
  self notify("trigger_off");
}

function set_trigger_flag_permissions(msg) {
  if(!isDefined(level.trigger_flags)) {
    return;
  }

  level.trigger_flags[msg] = function_5713d46873b29625(level.trigger_flags[msg]);
  array_thread(level.trigger_flags[msg], &update_trigger_based_on_flags);
}

function update_trigger_based_on_flags() {
  true_on = 1;

  if(isDefined(self.script_flag_true)) {
    true_on = 0;
    tokens = create_flags_and_return_tokens(self.script_flag_true);

    foreach(token in tokens) {
      if(flag(token)) {
        true_on = 1;
        break;
      }
    }
  }

  false_on = 1;

  if(isDefined(self.script_flag_false)) {
    tokens = create_flags_and_return_tokens(self.script_flag_false);

    foreach(token in tokens) {
      if(flag(token)) {
        false_on = 0;
        break;
      }
    }
  }

  value = true_on && false_on ? 1 : 0;
  [[level.trigger_func[value]]]();
}

function create_flags_and_return_tokens(flags) {
  tokens = strtok(flags, " ");

  for(i = 0; i < tokens.size; i++) {
    if(!isDefined(level.flag[tokens[i]])) {
      flag_init(tokens[i]);
    }
  }

  return tokens;
}

function init_trigger_flags() {
  if(!add_init_script("trigger_flags", &init_trigger_flags)) {
    return;
  }

  level.trigger_flags = [];
  level.trigger_func[1] = &trigger_on;
  level.trigger_func[0] = &trigger_off;
}

function addstruct(struct) {
  assert(isDefined(level.struct_class_names), "<dev string:x100>");

  if(isDefined(struct.targetname)) {
    if(!isDefined(level.struct_class_names["targetname"][struct.targetname])) {
      level.struct_class_names["targetname"][struct.targetname] = [];
    }

    size = level.struct_class_names["targetname"][struct.targetname].size;
    level.struct_class_names["targetname"][struct.targetname][size] = struct;
  }

  if(isDefined(struct.target)) {
    if(!isDefined(level.struct_class_names["target"][struct.target])) {
      level.struct_class_names["target"][struct.target] = [];
    }

    size = level.struct_class_names["target"][struct.target].size;
    level.struct_class_names["target"][struct.target][size] = struct;
  }

  if(isDefined(struct.script_noteworthy)) {
    if(!isDefined(level.struct_class_names["script_noteworthy"][struct.script_noteworthy])) {
      level.struct_class_names["script_noteworthy"][struct.script_noteworthy] = [];
    }

    size = level.struct_class_names["script_noteworthy"][struct.script_noteworthy].size;
    level.struct_class_names["script_noteworthy"][struct.script_noteworthy][size] = struct;
  }

  if(isDefined(struct.script_linkname)) {
    if(!isDefined(level.struct_class_names["script_linkname"][struct.script_linkname])) {
      level.struct_class_names["script_linkname"][struct.script_linkname] = [];
    }

    size = level.struct_class_names["script_linkname"][struct.script_linkname].size;
    level.struct_class_names["script_linkname"][struct.script_linkname][size] = struct;
  }

  if(isDefined(struct.script_vehicleref)) {
    if(!isDefined(level.struct_class_names["script_vehicleref"][struct.script_vehicleref])) {
      level.struct_class_names["script_vehicleref"][struct.script_vehicleref] = [];
    }

    size = level.struct_class_names["script_vehicleref"][struct.script_vehicleref].size;
    level.struct_class_names["script_vehicleref"][struct.script_vehicleref][size] = struct;
  }

  if(isDefined(struct.script_vehiclebundle)) {
    if(!isDefined(level.struct_class_names["script_vehiclebundle"][struct.script_vehiclebundle])) {
      level.struct_class_names["script_vehiclebundle"][struct.script_vehiclebundle] = [];
    }

    size = level.struct_class_names["script_vehiclebundle"][struct.script_vehiclebundle].size;
    level.struct_class_names["script_vehiclebundle"][struct.script_vehiclebundle][size] = struct;
  }

  if(isDefined(struct.vehicletype)) {
    hash = getxhashasset(struct.vehicletype);
    struct.vehicletype = hash;

    if(!isDefined(level.struct_class_names["vehicletype"][hash])) {
      level.struct_class_names["vehicletype"][hash] = [];
    }

    size = level.struct_class_names["vehicletype"][hash].size;
    level.struct_class_names["vehicletype"][hash][size] = struct;
  }

  if(isDefined(struct.variantname)) {
    if(!isDefined(level.struct_class_names["variantname"][struct.variantname])) {
      level.struct_class_names["variantname"][struct.variantname] = [];
    }

    size = level.struct_class_names["variantname"][struct.variantname].size;
    level.struct_class_names["variantname"][struct.variantname][size] = struct;
  }

  if(isDefined(struct.agent_noteworthy)) {
    if(!isDefined(level.struct_class_names["script_agent_noteworthy"][struct.agent_noteworthy])) {
      level.struct_class_names["script_agent_noteworthy"][struct.agent_noteworthy] = [];
    }

    size = level.struct_class_names["script_agent_noteworthy"][struct.agent_noteworthy].size;
    level.struct_class_names["script_agent_noteworthy"][struct.agent_noteworthy][size] = struct;
  }

  if(isDefined(struct.script_agent_noteworthy)) {
    if(!isDefined(level.struct_class_names["script_agent_noteworthy"][struct.script_agent_noteworthy])) {
      level.struct_class_names["script_agent_noteworthy"][struct.script_agent_noteworthy] = [];
    }

    size = level.struct_class_names["script_agent_noteworthy"][struct.script_agent_noteworthy].size;
    level.struct_class_names["script_agent_noteworthy"][struct.script_agent_noteworthy][size] = struct;
  }
}

function function_a56cf359233cf85b() {
  level.var_13b70b3b5724494f = 1;
  level.struct_class_names = undefined;
}

function getStruct(name, type = "targetname") {
  assert(isDefined(name), "<dev string:x133>");

  if(!isDefined(level.struct_class_names)) {
    if(level.var_13b70b3b5724494f) {
      assertmsg("<dev string:x14b>");
    } else {
      assertmsg("<dev string:x17e>");
    }
  }

  array = level.struct_class_names[type][name];

  if(!isDefined(array)) {
    return undefined;
  }

  if(array.size > 1) {
    if(isDefined(array[0]) && isDefined(array[0].origin)) {
      originstr1 = "" + array[0].origin;
    } else {
      originstr1 = "<UNKNOWN>";
    }

    if(isDefined(array[1]) && isDefined(array[1].origin)) {
      originstr2 = "" + array[1].origin;
    } else {
      originstr2 = "<UNKNOWN>";
    }

    assertmsg("<dev string:x1b1>" + type + "<dev string:x1e6>" + name + "<dev string:x1f4>" + originstr1 + "<dev string:x22a>" + originstr2);
    return undefined;
  }

  return array[0];
}

function getStructArray(name, type = "targetname") {
  if(!isDefined(level.struct_class_names)) {
    if(level.var_13b70b3b5724494f) {
      assertmsg("<dev string:x14b>");
    } else {
      assertmsg("<dev string:x17e>");
    }
  }

  if(!isDefined(level.struct_class_names)) {
    return [];
  }

  if(!(isDefined(type) && isDefined(name))) {
    return [];
  }

  array = level.struct_class_names[type][name] ?? [];
  return array;
}

function function_b7f3d374aa10aa51(name, type, origin, radius) {
  assert(isDefined(name) && isDefined(type), "<dev string:x233>");
  assert(isDefined(origin) && isDefined(radius), "<dev string:x255>");

  if(!(isDefined(origin) && isDefined(radius))) {
    return [];
  }

  structarray = getStructArray(name, type);

  if(structarray.size == 0) {
    return [];
  }

  radiussquared = radius * radius;
  var_2f8bcafcfeb23a45 = [];

  foreach(struct in structarray) {
    if(distance2dsquared(origin, struct.origin) <= radiussquared) {
      var_2f8bcafcfeb23a45[var_2f8bcafcfeb23a45.size] = struct;
    }
  }

  return var_2f8bcafcfeb23a45;
}

function function_10d135e2ebebca29(name, type, origin, radius) {
  assert(isDefined(name) && isDefined(type), "<dev string:x233>");
  assert(isDefined(origin) && isDefined(radius), "<dev string:x255>");

  if(!(isDefined(origin) && isDefined(radius))) {
    return undefined;
  }

  structarray = getStructArray(name, type);

  if(structarray.size == 0) {
    return undefined;
  }

  bestdistance = radius * radius;
  beststruct = undefined;

  foreach(struct in structarray) {
    distancesquared = distancesquared(origin, struct.origin);

    if(distancesquared <= bestdistance) {
      bestdistance = distancesquared;
      beststruct = struct;
    }
  }

  return beststruct;
}

function function_d25424f1ac9f1290(struct) {
  if(!isDefined(struct.var_a86c7b90ea136b4)) {
    return;
  }

  if(!isDefined(level._fx)) {
    level._fx = {};
  }

  if(!isDefined(level._fx.ambientwar)) {
    level._fx.ambientwar = {};
  }

  if(!isDefined(level._fx.ambientwar.nodes)) {
    level._fx.ambientwar.nodes = [];
  }

  if(!isDefined(level._fx.ambientwar.nodes[struct.var_a86c7b90ea136b4])) {
    level._fx.ambientwar.nodes[struct.var_a86c7b90ea136b4] = [];
  }

  level._fx.ambientwar.nodes[struct.var_a86c7b90ea136b4][level._fx.ambientwar.nodes[struct.var_a86c7b90ea136b4].size] = struct;
}

function deletestructarray(value, key, delay) {
  structs = getStructArray(value, key);
  deletestructarray_ref(structs, delay);
}

function deletestruct_ref(struct) {
  if(!isDefined(struct)) {
    return;
  }

  value = struct.script_linkname;

  if(isDefined(level.struct_class_names["script_linkname"]) && isDefined(value) && isDefined(level.struct_class_names["script_linkname"][value])) {
    foreach(i, _struct in level.struct_class_names["script_linkname"][value]) {
      if(struct == _struct) {
        level.struct_class_names["script_linkname"][value][i] = undefined;
      }
    }

    if(level.struct_class_names["script_linkname"][value].size == 0) {
      level.struct_class_names["script_linkname"][value] = undefined;
    }
  }

  value = struct.script_noteworthy;

  if(isDefined(level.struct_class_names["script_noteworthy"]) && isDefined(value) && isDefined(level.struct_class_names["script_noteworthy"][value])) {
    foreach(i, _struct in level.struct_class_names["script_noteworthy"][value]) {
      if(struct == _struct) {
        level.struct_class_names["script_noteworthy"][value][i] = undefined;
      }
    }

    if(level.struct_class_names["script_noteworthy"][value].size == 0) {
      level.struct_class_names["script_noteworthy"][value] = undefined;
    }
  }

  value = struct.target;

  if(isDefined(level.struct_class_names["target"]) && isDefined(value) && isDefined(level.struct_class_names["target"][value])) {
    foreach(i, _struct in level.struct_class_names["target"][value]) {
      if(struct == _struct) {
        level.struct_class_names["target"][value][i] = undefined;
      }
    }

    if(level.struct_class_names["target"][value].size == 0) {
      level.struct_class_names["target"][value] = undefined;
    }
  }

  value = struct.targetname;

  if(isDefined(level.struct_class_names["targetname"]) && isDefined(value) && isDefined(level.struct_class_names["targetname"][value])) {
    foreach(i, _struct in level.struct_class_names["targetname"][value]) {
      if(struct == _struct) {
        level.struct_class_names["targetname"][value][i] = undefined;
      }
    }

    if(level.struct_class_names["targetname"][value].size == 0) {
      level.struct_class_names["targetname"][value] = undefined;
    }
  }
}

function deletestructarray_ref(structs, delay) {
  if(!isDefined(structs) || !isarray(structs) || structs.size == 0) {
    return;
  }

  if(!isDefined(delay)) {
    delay = 0;
  }

  delay = delay > 0 ? delay : 0;

  if(delay > 0) {
    foreach(struct in structs) {
      deletestruct_ref(struct);
      wait delay;
    }

    return;
  }

  foreach(struct in structs) {
    deletestruct_ref(struct);
  }
}

function getstructarray_delete(value, key, delay) {
  structs = getStructArray(value, key);
  deletestructarray_ref(structs, delay);
  return structs;
}

function getent_or_struct_array(name, key, ignore_spawners) {
  ents = getEntArray(name, key, ignore_spawners ?? 0);

  if(isDefined(level.struct_class_names)) {
    ents = arraycombine(ents, getStructArray(name, key));
  }

  return ents;
}

function getent_or_struct(name, key, ignore_spawners) {
  var_7237854e3be197ca = getEnt(name, key, ignore_spawners ?? 0);

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  return getStruct(name, key);
}

function fileprint_start(file) {
  filename = file;
  level.fileprint = 1;
  level.fileprintlinecount = 0;
  level.fileprint_filename = filename;
}

function fileprint_map_start() {
  level.fileprint_mapentcount = 0;
  fileprint_map_header(1);
}

function fileprint_map_header(binclude_blank_worldspawn = 0) {
  fileprint_launcher( "<dev string:x27d>" );
  fileprint_launcher( "<dev string:x288>" );
  fileprint_launcher( "<dev string:x2a6>" );

  if(!binclude_blank_worldspawn) {
    return;
  }

  fileprint_map_entity_start();
  fileprint_map_keypairprint("<dev string:x2b9>", "<dev string:x2c6>");
  fileprint_map_entity_end();
}

function fileprint_map_keypairprint(key1, key2) {
  fileprint_launcher( "<dev string:x2d4>" + key1 + "<dev string:x2d9>" + key2 + "<dev string:x2d4>" );
}

function fileprint_map_entity_start() {
  assert(isDefined(level.fileprint_mapentcount), "<dev string:x2e0>");
  assert(!isDefined(level.fileprint_entitystart));
  level.fileprint_entitystart = 1;
  fileprint_launcher( "<dev string:x318>" + level.fileprint_mapentcount );
  fileprint_launcher( "<dev string:x323>" );
  level.fileprint_mapentcount++;
}

function fileprint_map_entity_end() {
  fileprint_launcher( "<dev string:x328>" );
  level.fileprint_entitystart = undefined;
}

function fileprint_radiant_vec(vector) {
  string = "<dev string:x32d>" + vector[0] + "<dev string:x331>" + vector[1] + "<dev string:x331>" + vector[2] + "<dev string:x32d>";
  return string;
}

function call_on_notify_no_endon_death(notifystring, method, ...) {
  childthread call_on_notify_proc(notifystring, method, varargcount, vararg);
}

function call_on_notify(notifystring, method, ...) {
  self endon("death_or_disconnect");
  childthread call_on_notify_proc(notifystring, method, varargcount, vararg);
}

function call_on_notify_proc(notifystring, method, varargcount, vararg) {
  self waittill(notifystring);
  self builtin[[method]](flat_args(vararg, varargcount));
}

function thread_on_notify_no_endon_death(notifystring, function, ent, ...) {
  childthread thread_on_notify_proc(notifystring, function, ent, flat_args(vararg, varargcount));
}

function thread_on_notify(notifystring, function, ent, endonentities, endonmessages, ...) {
  self endon("death");

  if(isDefined(endonentities) && isDefined(endonmessages)) {
    if(!isarray(endonentities)) {
      endonentities = [endonentities];
    }

    if(!isarray(endonmessages)) {
      endonmessages = [endonmessages];
    }

    foreach(entity in endonentities) {
      foreach(message in endonmessages) {
        entity endon(message);
      }
    }
  }

  childthread thread_on_notify_proc(notifystring, function, ent, flat_args(vararg, varargcount));
}

function private thread_on_notify_proc(notifystring, function, ent, ...) {
  self waittill(notifystring);

  if(!isDefined(ent)) {
    ent = self;
  }

  ent thread[[function]](flat_args(vararg, varargcount));
}

function function_eaba0102563031d1(notifystring, function, params, ent, endonentities, endonmessages) {
  self endon("death");

  if(isDefined(endonentities) && isDefined(endonmessages)) {
    if(!isarray(endonentities)) {
      endonentities = [endonentities];
    }

    if(!isarray(endonmessages)) {
      endonmessages = [endonmessages];
    }

    foreach(entity in endonentities) {
      foreach(message in endonmessages) {
        entity endon(message);
      }
    }
  }

  childthread function_5f1fa003b5b6a326(notifystring, function, params, ent);
}

function function_5f1fa003b5b6a326(notifystring, function, params, ent) {
  self waittill(notifystring);

  if(!isDefined(ent)) {
    ent = self;
  }

  if(!isDefined(params)) {
    ent thread[[function]]();
    return;
  }

  ent thread[[function]](flat_args(params, params.size));
}

function delaycall(timer, func, ...) {
  thread delaycall_proc(func, undefined, timer, varargcount, vararg);
}

function delaycallendon(timer, endonevent, func, ...) {
  thread delaycall_proc(func, endonevent, timer, varargcount, vararg);
}

function private delaycall_proc(func, endonevent, timer, varargcount, vararg) {
  if(issp()) {
    self endon("death");
    self endon("stop_delay_call");
  }

  if(isDefined(endonevent)) {
    if(!isarray(endonevent)) {
      endonevent = [endonevent];
    }

    foreach(endonname in endonevent) {
      self endon(endonname);
    }
  }

  wait timer;

  if(isDefined(self) && isDefined(func)) {
    self builtin[[func]](flat_args(vararg, varargcount));
  }
}

function string_replace(string, find, replace, n = 1) {
  start_index = 0;

  for(i = 0; i < n; i++) {
    if(!issubstr(string, find)) {
      return string;
    }

    for(j = start_index; j < string.size; j++) {
      if(getsubstr(string, j, j + find.size) == find) {
        string = getsubstr(string, 0, j) + replace + getsubstr(string, j + find.size);
        start_index = replace.size - find.size + j + 1;
        break;
      }
    }
  }

  return string;
}

function plot_points(plotpoints, r, g, b, timer) {
  lastpoint = plotpoints[0];

  if(!isDefined(r)) {
    r = 1;
  }

  if(!isDefined(g)) {
    g = 1;
  }

  if(!isDefined(b)) {
    b = 1;
  }

  if(!isDefined(timer)) {
    timer = 0.05;
  }

  for(i = 1; i < plotpoints.size; i++) {
    thread draw_line_for_time(lastpoint, plotpoints[i], r, g, b, timer);
    lastpoint = plotpoints[i];
  }
}

function draw_line_for_time(org1, org2, r, g, b, timer, endonevent) {
  if(isDefined(endonevent)) {
    level endon(endonevent);
  }

  timer = gettime() + timer * 1000;

  while(gettime() < timer) {
    line(org1, org2, (r, g, b), 1);

    waitframe();
  }
}

function function_9f777c9a7fffb9fc(splineid, splinetotaltime, endonevent) {
  if(isDefined(endonevent)) {
    self endon(endonevent);
  }

  color = (1, 1, 0);
  lastposition = undefined;
  var_a0a1d7792d2fe4e2 = [];
  t = 0;
  t = 0;

  while(t <= splinetotaltime) {
    origin = function_2bf2352736fc6ac8(splineid, t);
    origin += (0, 0, 15);
    var_a0a1d7792d2fe4e2[var_a0a1d7792d2fe4e2.size] = origin;
    t += 0.2;
  }

  while(true) {
    lastposition = var_a0a1d7792d2fe4e2[0];

    for(i = 0; i <= var_a0a1d7792d2fe4e2.size - 1; i++) {
      if(lastposition != var_a0a1d7792d2fe4e2[0]) {
        line(lastposition, var_a0a1d7792d2fe4e2[i], color, 1, 0);
      }

      lastposition = var_a0a1d7792d2fe4e2[i];
    }

    waitframe();
  }
}

function function_95445a6684f51c52(text, origin, color, alpha, scale, duration, var_5bf65afe54040850, endonevent) {
  if(!isDefined(var_5bf65afe54040850)) {
    var_5bf65afe54040850 = 1;
  }

  if(isDefined(endonevent)) {
    level endon(endonevent);
  }

  endtime = gettime() + duration * 1000;

  while(gettime() < endtime) {
    print3d(origin, text, color, alpha, scale, var_5bf65afe54040850);
    timesec = var_5bf65afe54040850 * level.framedurationseconds;
    wait timesec;
  }
}

function draw_circle(center, radius, color, alpha, depthtest, duration) {
  circle_sides = 16;
  anglefrac = 360 / circle_sides;
  circlepoints = [];

  for(i = 0; i < circle_sides; i++) {
    angle = anglefrac * i;
    xadd = cos(angle) * radius;
    yadd = sin(angle) * radius;
    x = center[0] + xadd;
    y = center[1] + yadd;
    z = center[2];
    circlepoints[circlepoints.size] = (x, y, z);
  }

  for(i = 0; i < circlepoints.size; i++) {
    start = circlepoints[i];

    if(i + 1 >= circlepoints.size) {
      end = circlepoints[0];
    } else {
      end = circlepoints[i + 1];
    }

    line(start, end, color, alpha, depthtest, duration);
  }
}

function draw_cone(coneorigin, coneforward, conelen, coneang, color, alpha, depthtest, duration, var_d5eea15182c0d3fb = 0, var_4901db0fa1b73461 = 16, var_76315c3a3742278 = 10) {
  if(var_d5eea15182c0d3fb) {
    endpoint_center = coneorigin + coneforward * conelen;

    line(coneorigin, endpoint_center, color, alpha, depthtest, duration);
  }

  var_a14f1eefa11db062 = coneforward * conelen;
  x = var_a14f1eefa11db062[0];
  y = var_a14f1eefa11db062[1];
  z = var_a14f1eefa11db062[2];
  y = max(1e-06, y);
  radius = conelen * tan(coneang);
  xvec = vectorNormalize((y, x * -1, 0));
  yvec = vectorNormalize((x * z, y * z, squared(x) * -1 - squared(y)));
  anglefrac = 360 / var_4901db0fa1b73461;
  edgevecs = [];

  for(i = 0; i < var_4901db0fa1b73461; i++) {
    angle = anglefrac * i;
    xadd = cos(angle) * radius;
    yadd = sin(angle) * radius;
    vec = var_a14f1eefa11db062 + xvec * xadd + yvec * yadd;

    line(coneorigin, vec + coneorigin, color, alpha, depthtest, duration);

    edgevecs[i] = vec;
  }

  if(!isDefined(var_76315c3a3742278) || var_76315c3a3742278 < 1) {
    return;
  }

  for(i = 0; i < var_4901db0fa1b73461; i++) {
    var_b89dc0f8c8534128 = edgevecs[i];
    var_5a00f829c922b370 = undefined;

    if(i == edgevecs.size - 1) {
      var_5a00f829c922b370 = edgevecs[0];
    } else {
      var_5a00f829c922b370 = edgevecs[i + 1];
    }

    for(j = 0; j < var_76315c3a3742278; j++) {
      var_94cd0067430f6194 = coneorigin + var_b89dc0f8c8534128 - var_b89dc0f8c8534128 * j / var_76315c3a3742278;
      var_2c57358c698fe40c = coneorigin + var_5a00f829c922b370 - var_5a00f829c922b370 * j / var_76315c3a3742278;

      line(var_94cd0067430f6194, var_2c57358c698fe40c, color, alpha, depthtest, duration);
    }
  }
}

function array_delete(array) {
  foreach(ent in array) {
    if(isDefined(ent)) {
      ent delete();
    }
  }
}

function array_insert_array(array1, array2, index) {
  assert(index >= 0, "<dev string:x336>");

  for(i = array1.size + array2.size - 1; true; i--) {
    if(i < index + array2.size) {
      for(j = array2.size - 1; j >= 0; j--) {
        array1[i] = array2[j];
        i--;
      }

      return array1;
    }

    array1[i] = array1[i - array2.size];
  }
}

function array_combine_multiple(arr2d) {
  arr1d = [];

  foreach(arr in arr2d) {
    arr1d = arraycombine(arr1d, arr);
  }

  return arr1d;
}

function array_map(array, mapfunction) {
  assert(isarray(array), "<dev string:x361>");
  assert(isfunction(mapfunction), "<dev string:x38e>");
  newarray = [];

  foreach(arrayobject in array) {
    newarray[newarray.size] = self[[mapfunction]](arrayobject);
  }

  return newarray;
}

function array_random(array) {
  size = array.size;

  if(size > 0) {
    return array[getarraykey(array, randomint(size))];
  }
}

function array_random_slice(array, slicesize) {
  assert(array.size > slicesize, "<dev string:x3bf>");
  randomindices = [];
  returnarr = [];
  counter = 0;
  totalchecks = 0;
  maxchecks = slicesize * 10;

  while(counter < slicesize) {
    rndidx = randomint(array.size);
    totalchecks++;

    if(totalchecks == maxchecks) {
      break;
    }

    if(arraycontains(randomindices, rndidx)) {
      continue;
    }

    randomindices[randomindices.size] = rndidx;
    counter++;
  }

  if(randomindices.size < slicesize) {
    return undefined;
  }

  currindex = 0;

  foreach(object in array) {
    if(returnarr.size == slicesize) {
      break;
    }

    if(arraycontains(randomindices, currindex)) {
      returnarr[returnarr.size] = object;
    }

    currindex++;
  }

  return returnarr;
}

function array_randomize(array) {
  array = arraycopy(array);

  for(i = 0; i < array.size - 1; i++) {
    j = randomintrange(i, array.size);
    temp = array[i];
    array[i] = array[j];
    array[j] = temp;
  }

  return array;
}

function function_bf3235e60a7a3f60(array, seed, a, c, m) {
  if(!(isDefined(array) && isDefined(seed))) {
    assertmsg("<dev string:x3ff>");
    return [];
  }

  array = arraycopy(array);
  x = seed;

  if(!isDefined(a)) {
    a = 29;
  }

  if(!isDefined(c)) {
    c = 19;
  }

  if(!isDefined(m)) {
    m = int(max(array.size, 41));
  }

  for(i = 0; i < array.size; i++) {
    x = (x * a + c) % m;
    randval = x % array.size;
    tmp = array[i];
    array[i] = array[randval];
    array[randval] = tmp;
  }

  return array;
}

function array_randomize_objects(array) {
  randomarray = [];

  for(temparray = array; temparray.size > 0; temparray = newarray) {
    randomindex = randomintrange(0, temparray.size);
    newarray = [];
    arraycount = 0;

    foreach(key, object in temparray) {
      if(arraycount == randomindex) {
        randomarray[isstring(key) ? key : randomarray.size] = object;
      } else {
        newarray[isstring(key) ? key : newarray.size] = object;
      }

      arraycount++;
    }
  }

  return randomarray;
}

function array_reverse(array) {
  assert(isarray(array));
  array2 = [];

  for(i = array.size - 1; i >= 0; i--) {
    array2[array2.size] = array[i];
  }

  return array2;
}

function array_slice(array, startindex, endindex) {
  assert(isarray(array));
  assert(isDefined(startindex));

  if(array.size <= 0) {
    return [];
  }

  if(!isDefined(endindex) || endindex > array.size) {
    endindex = array.size;
  }

  if(startindex == 0 && endindex == array.size) {
    return array;
  }

  slicedarray = [];

  for(index = startindex; index < endindex; index++) {
    slicedarray[slicedarray.size] = array[index];
  }

  return slicedarray;
}

function array_slice_random(array, var_129d621c51f58393) {
  array = arraycopy(array);

  for(i = 0; i < var_129d621c51f58393; i++) {
    if(array.size > 0) {
      indextoremove = randomint(array.size);
      array[indextoremove] = array[array.size - 1];
      array[array.size - 1] = undefined;
    }
  }

  return array;
}

function function_5fdf0884f9b2d470(array, var_5de849e01abd2013) {
  assert(isarray(array), "<dev string:x361>");
  assert(isfunction(var_5de849e01abd2013), "<dev string:x38e>");
  result = [];

  foreach(test in array) {
    if(self[[var_5de849e01abd2013]](test)) {
      result[result.size] = test;
    }
  }

  return result;
}

function function_6ed29b1b786df49a(array, condition, keepkeys) {
  if(!array || !isDefined(condition)) {
    return;
  }

  newarray = [];

  foreach(key, val in array) {
    if(![[condition]](key, val)) {
      if(keepkeys) {
        newarray[key] = val;
        continue;
      }

      newarray[newarray.size] = val;
    }
  }

  return newarray;
}

function function_6ecd4587ed2bf80c(array, keepkeys) {
  newarray = [];

  if(keepkeys) {
    foreach(i, member in array) {
      if(!isDefined(member) || member.destroyed) {
        continue;
      }

      newarray[i] = member;
    }
  } else {
    foreach(i, member in array) {
      if(!isDefined(member) || member.destroyed) {
        continue;
      }

      newarray[newarray.size] = member;
    }
  }

  return newarray;
}

function function_8391781ea0784541(array, keepkeys) {
  newarray = [];

  if(keepkeys) {
    foreach(i, member in array) {
      if(!isDefined(member) || !isalive(member) || member.destroyed) {
        continue;
      }

      newarray[i] = member;
    }
  } else {
    foreach(i, member in array) {
      if(!isDefined(member) || !isalive(member) || member.destroyed) {
        continue;
      }

      newarray[newarray.size] = member;
    }
  }

  return newarray;
}

function array_get_first_item(array = []) {
  foreach(item in array) {
    return item;
  }

  return undefined;
}

function function_f1933af772476229(array = []) {
  last_item = undefined;

  foreach(item in array) {
    last_item = item;
  }

  return last_item;
}

function function_d751969553a4bddd(array, remover) {
  result = [];
  removed = 0;

  foreach(item in array_reverse(array)) {
    if(!removed && item == remover) {
      removed = 1;
      continue;
    }

    result[result.size] = item;
  }

  return array_reverse(result);
}

function array_levelthread(array, process, ...) {
  foreach(ent in array) {
    thread[[process]](ent, flat_args(vararg, varargcount));
  }
}

function array_sort_by_script_index(array) {
  sortedarray = [];

  for(index = 0; index < array.size; index++) {
    foreach(item in array) {
      if(item.script_index == index) {
        sortedarray[sortedarray.size] = item;
      }
    }
  }

  remainingitems = arrayremove(array, sortedarray);
  sortedarray = arraycombine(sortedarray, remainingitems);
  return sortedarray;
}

function array_average(array) {
  return array_sum(array) / array.size;
}

function array_sum(array) {
  sum = 0;

  foreach(item in array) {
    sum += item;
  }

  return sum;
}

function sum(...) {
  assert(varargcount >= 1);

  if(isarray(vararg[0])) {
    assert(varargcount == 1);
    return array_sum(vararg[0]);
  }

  return array_sum(vararg);
}

function array_max(array) {
  maximum = undefined;

  foreach(item in array) {
    if(isDefined(maximum)) {
      maximum = max(maximum, item);
      continue;
    }

    maximum = item;
  }

  return maximum;
}

function maximum(...) {
  assert(varargcount >= 1);

  if(isarray(vararg[0])) {
    assert(varargcount == 1);
    return array_max(vararg[0]);
  }

  return array_max(vararg);
}

function function_a38b3ca4783bca3b(array, var_88397eced8b3629c, var_8e0831c9133f47d9, var_297c33ed3c94cefd, iterationtimeinseconds = 5, shouldthread = 0) {
  assert(isarray(array), "<dev string:x361>");
  assert(isfunction(var_88397eced8b3629c), "<dev string:x38e>");
  var_bf7b7ad6fd69e36a = 0;

  if(isfunction(var_8e0831c9133f47d9)) {
    var_bf7b7ad6fd69e36a = 1;
  }

  var_49d4677a21b1ab3b = array.size;
  var_f1b01d788e6d3db4 = max(iterationtimeinseconds / level.framedurationseconds, 1);
  var_2397229ee106724a = max(var_49d4677a21b1ab3b / var_f1b01d788e6d3db4, 1);
  var_2397229ee106724a = ceil(var_2397229ee106724a);
  var_856c40ba487440b = 0;

  if(shouldthread) {
    foreach(arraykey, arrayobject in array) {
      var_c9255c447cc081c0 = !var_bf7b7ad6fd69e36a || var_bf7b7ad6fd69e36a && self[[var_8e0831c9133f47d9]](arrayobject);

      if(var_c9255c447cc081c0) {
        self thread[[var_88397eced8b3629c]](arrayobject, arraykey);
      }

      var_856c40ba487440b++;

      if(var_856c40ba487440b >= var_2397229ee106724a) {
        waitframe();
        var_856c40ba487440b = 0;
      }
    }
  } else {
    foreach(arraykey, arrayobject in array) {
      var_c9255c447cc081c0 = !var_bf7b7ad6fd69e36a || var_bf7b7ad6fd69e36a && self[[var_8e0831c9133f47d9]](arrayobject);

      if(var_c9255c447cc081c0) {
        self[[var_88397eced8b3629c]](arrayobject, arraykey);
      }

      var_856c40ba487440b++;

      if(var_856c40ba487440b >= var_2397229ee106724a) {
        waitframe();
        var_856c40ba487440b = 0;
      }
    }
  }

  if(isfunction(var_297c33ed3c94cefd)) {
    self[[var_297c33ed3c94cefd]]();
  }
}

function function_1048967191f5b394(a_ents, e_volume) {
  foreach(e_ent in a_ents) {
    if(!e_ent istouching(e_volume)) {
      return false;
    }
  }

  return true;
}

function function_1cb108307e3b6491(object) {
  return isPlayer(object);
}

function function_bf6b797c73abc9df(object) {
  return function_1cb108307e3b6491(object) && isalive(object);
}

function create_deck(item_array, autoshuffle, var_4a5b8543826fe61b, prevent_redraw) {
  if(!isDefined(item_array)) {
    item_array = [];
  } else if(!isarray(item_array)) {
    item_array = [item_array];
  }

  deck = spawnStruct();
  deck.items = [];
  deck.index = 0;
  deck.cycle = 0;
  deck.autoshuffle = !isDefined(autoshuffle) || autoshuffle;
  deck.prevent_redraw = !isDefined(prevent_redraw) || prevent_redraw;

  foreach(item in item_array) {
    deck.items[deck.items.size] = item;
  }

  if(var_4a5b8543826fe61b) {
    deck deck_shuffle();
  }

  return deck;
}

function deck_draw() {
  assert(isDefined(self.items) && isstruct(self) && isDefined(self.index), "<dev string:x444>");
  deck = self;
  drawn_item = deck deck_top();
  deck.index++;
  return drawn_item;
}

function deck_top() {
  assert(isDefined(self.items) && isstruct(self) && isDefined(self.index), "<dev string:x480>");
  deck = self;

  if(deck.items.size == 0) {
    return undefined;
  }

  if(deck.index >= deck.items.size) {
    if(deck.autoshuffle) {
      deck deck_shuffle();
    } else {
      deck.index = 0;
      deck.cycle++;
    }
  }

  return deck.items[deck.index];
}

function deck_shuffle() {
  assert(isDefined(self.items) && isstruct(self) && isDefined(self.index), "<dev string:x4bb>");
  deck = self;

  if(deck.index == 0 || !deck.prevent_redraw || deck.items.size <= 1) {
    deck.items = array_randomize(deck.items);
    deck.index = 0;
    deck.cycle++;
    return;
  }

  j = randomintrange(0, deck.items.size - 1);

  if(j == deck.index - 1) {
    j++;
  }

  temp = deck.items[0];
  deck.items[0] = deck.items[j];
  deck.items[j] = temp;

  for(i = 1; i < deck.items.size - 1; i++) {
    j = randomintrange(i, deck.items.size);
    temp = deck.items[i];
    deck.items[i] = deck.items[j];
    deck.items[j] = temp;
  }

  deck.index = 0;
  deck.cycle++;
}

function random(array) {
  return array_random(array);
}

function random_key(array) {
  size = array.size;

  if(size > 0) {
    return getarraykey(array, randomint(size));
  }
}

function random_weighted(array, weights) {
  assert(array.size == weights.size, "<dev string:x4fa>");
  totalweight = 0;

  foreach(value in weights) {
    totalweight += value;
  }

  if(totalweight == 0) {
    return undefined;
  }

  weight = randomint(totalweight);
  chosenvalue = undefined;

  foreach(i, value in array) {
    if(weight < weights[i]) {
      chosenvalue = value;
      break;
    }

    weight -= weights[i];
  }

  return chosenvalue;
}

function random_weighted_struct(struct_array) {
  totalweight = 0;

  foreach(struct in struct_array) {
    totalweight += struct.weight;
  }

  if(totalweight == 0) {
    return undefined;
  }

  choosenweight = randomint(totalweight);
  cumulativeweight = 0;
  selectedstruct = undefined;

  foreach(struct in struct_array) {
    cumulativeweight += struct.weight;

    if(cumulativeweight > choosenweight) {
      selectedstruct = struct;
      break;
    }
  }

  return selectedstruct;
}

function random_weight_sorted(array) {
  newarray = [];

  foreach(value in array) {
    newarray[newarray.size] = value;
  }

  if(!newarray.size) {
    return undefined;
  }

  var_d23377414f51df8b = randomint(newarray.size * newarray.size);
  return newarray[newarray.size - 1 - int(sqrt(var_d23377414f51df8b))];
}

function alphabetize(array) {
  if(array.size <= 1) {
    return array;
  }

  array = arraycopy(array);

  for(asize = array.size - 1; asize >= 1; asize--) {
    largest = array[asize];
    largestindex = asize;

    for(i = 0; i < asize; i++) {
      string1 = array[i];

      if(stricmp(string1, largest) > 0) {
        largest = string1;
        largestindex = i;
      }
    }

    if(largestindex != asize) {
      array[largestindex] = array[asize];
      array[asize] = largest;
    }
  }

  return array;
}

function array_thread_amortized(entities, process, var_b01eab2eb5e7d0ec, ...) {
  thread array_thread_amortized_proc(entities, process, var_b01eab2eb5e7d0ec, flat_args(vararg, varargcount));
}

function array_thread_amortized_proc(entities, process, var_b01eab2eb5e7d0ec, ...) {
  foreach(ent in entities) {
    if(isai(ent) && !isalive(ent) || !isDefined(ent)) {
      continue;
    }

    ent thread[[process]](flat_args(vararg, varargcount));
    wait var_b01eab2eb5e7d0ec;
  }
}

function array_thread(entities, process, ...) {
  foreach(ent in entities) {
    ent thread[[process]](flat_args(vararg, varargcount));
  }
}

function function_287100922a30cebe(entities, process, ...) {
  foreach(ent in entities) {
    ent childthread[[process]](flat_args(vararg, varargcount));
  }
}

function array_call(entities, process, ...) {
  foreach(ent in entities) {
    ent builtin[[process]](flat_args(vararg, varargcount));
  }
}

function function_835738fa8c7c4066(entities, process, ...) {
  entities = function_5713d46873b29625(entities);
  array_call(entities, process, flat_args(vararg, varargcount));
}

function function_bc06a8c564f539e5(job_funcs, arg_array) {
  assert(isarray(job_funcs));

  if(!isDefined(arg_array)) {
    arg_array = [];
  }

  jobpool = spawnStruct();
  jobpool.alldonenotify = "all_workers_done";
  jobpool.pendingcount = job_funcs.size;

  for(i = 0; i < job_funcs.size; i++) {
    assert(isfunction(job_funcs[i]));
    jobpool childthread function_f847fdaebc753c59(self, job_funcs[i], arg_array);
  }

  if(jobpool.pendingcount == 0) {
    return;
  }

  jobpool waittill(jobpool.alldonenotify);
}

function private function_f847fdaebc753c59(ent, func, arg_array) {
  single_func_argarray(ent, func, arg_array);
  self.pendingcount -= 1;

  if(self.pendingcount == 0) {
    self notify(self.alldonenotify);
  }
}

function function_bf6bc5af32465d3c(time_seconds, func, ...) {
  if(!isfunction(func)) {
    assertmsg("<dev string:x529>");
    return;
  }

  thread function_df28a485be61386e(time_seconds, func, flat_args(vararg, varargcount));
}

function private function_df28a485be61386e(time_seconds, func, ...) {
  level endon("game_ended");

  if(isPlayer(self)) {
    self endon("disconnect");
  }

  wait max(int(time_seconds), 0);
  self thread[[func]](flat_args(vararg, varargcount));
}

function flat_angle(angle) {
  rangle = (0, angle[1], 0);
  return rangle;
}

function flat_origin(org) {
  rorg = (org[0], org[1], 0);
  return rorg;
}

function flatten_vector(var_88d7b9388f725cee, up_vector = (0, 0, 1)) {
  flat_vec = vectorNormalize(var_88d7b9388f725cee - vectordot(up_vector, var_88d7b9388f725cee) * up_vector);
  return flat_vec;
}

function draw_arrow_time(start, end, color, duration, endonevent) {
  if(isDefined(endonevent)) {
    level endon(endonevent);
  }

  level endon("newpath");
  angles = vectortoangles(start - end);
  right = anglestoright(angles);
  forward = anglesToForward(angles);
  up = anglestoup(angles);
  dist = distance(start, end);
  arrow = [];
  range = 0.1;
  arrow[0] = start;
  arrow[1] = start + right * dist * range + forward * dist * -0.1;
  arrow[2] = end;
  arrow[3] = start + right * dist * -1 * range + forward * dist * -0.1;
  arrow[4] = start;
  arrow[5] = start + up * dist * range + forward * dist * -0.1;
  arrow[6] = end;
  arrow[7] = start + up * dist * -1 * range + forward * dist * -0.1;
  arrow[8] = start;
  r = color[0];
  g = color[1];
  b = color[2];
  plot_points(arrow, r, g, b, duration);
}

function draw_arrow(start, end, color, scale, depthtest, duration) {
  level endon("newpath");
  angles = vectortoangles(start - end);
  right = anglestoright(angles);
  forward = anglesToForward(angles);
  dist = distance(start, end);
  arrow = [];
  range = 0.05;
  arrow[0] = start;
  arrow[1] = start + right * dist * range + forward * dist * -0.2;
  arrow[2] = end;
  arrow[3] = start + right * dist * -1 * range + forward * dist * -0.2;

  for(p = 0; p < 4; p++) {
    nextpoint = p + 1;

    if(nextpoint >= 4) {
      nextpoint = 0;
    }

    line(arrow[p], arrow[nextpoint], color, scale ?? 1, istrue(depthtest), duration ?? 1);
  }
}

function function_f0123538526f6652(start, end, line_color = (0, 0, 1), arrow_color = line_color, arrow_angle = 45, arrow_length = 30, num_arrows = 2, connect_arrow = 1, alpha, depthtest, duration) {
  angles = vectortoangles(end - start);
  right = anglestoright(angles);
  forward = anglesToForward(angles);
  dist = distance(start, end);
  yadd = sin(arrow_angle) * forward;
  xadd = cos(arrow_angle) * right;
  displacement_right = vectorNormalize(xadd + yadd) * -1 * arrow_length;
  displacement_left = vectorNormalize(xadd * -1 + yadd) * -1 * arrow_length;
  var_d46ee22ae490d134 = num_arrows + 1;
  var_151a069d6f09add4 = dist / var_d46ee22ae490d134;

  for(i = 1; i < var_d46ee22ae490d134; i++) {
    var_d3810399a0556ac0 = var_151a069d6f09add4 * i;
    arrowhead_point = start + var_d3810399a0556ac0 * forward;
    arrow_end_right = arrowhead_point + displacement_right;
    arrow_end_left = arrowhead_point + displacement_left;

    line(arrowhead_point, arrow_end_right, arrow_color, alpha, depthtest, duration);
    line(arrowhead_point, arrow_end_left, arrow_color, alpha, depthtest, duration);

    if(connect_arrow) {
      line(arrow_end_left, arrow_end_right, arrow_color, alpha, depthtest, duration);
    }
  }

  line(start, end, line_color, alpha, depthtest, duration);
}

function draw_capsule(pos, radius, height, angles = (0, 0, 0), color, depthtest = 0, duration = 1) {
  forward = anglesToForward(angles);
  right = anglestoright(angles);
  up = anglestoup(angles);

  cap_base = pos + up * radius;
  sphere(cap_base, radius, color, depthtest, duration);
  cap_top = pos + up * height;
  cap_top -= up * radius;
  sphere(cap_top, radius, color, depthtest, duration);
  var_4cbbb83facf3df31 = cap_base + forward * radius;
  var_14aa1f435f1e37e7 = cap_top + forward * radius;
  line(var_4cbbb83facf3df31, var_14aa1f435f1e37e7, color, 1, depthtest, duration);
  var_b0909247cbb9a9fd = cap_base - forward * radius;
  var_724fe8e3ccb97753 = cap_top - forward * radius;
  line(var_b0909247cbb9a9fd, var_724fe8e3ccb97753, color, 1, depthtest, duration);
  var_dab792ab7bea104d = cap_base + right * radius;
  var_18230b6cd04fb063 = cap_top + right * radius;
  line(var_dab792ab7bea104d, var_18230b6cd04fb063, color, 1, depthtest, duration);
  var_6ba71c7d59bcd637 = cap_base - right * radius;
  var_235e3e9c39d3545d = cap_top - right * radius;
  line(var_6ba71c7d59bcd637, var_235e3e9c39d3545d, color, 1, depthtest, duration);
}

function draw_character_capsule(color, depthtest, duration) {
  capsule_data = self physics_getcharactercollisioncapsule();
  draw_capsule(self getorigin(), capsule_data["radius"], capsule_data["half_height"] * 2, self.angles, color, depthtest, duration);
}

function draw_player_capsule(color, depthtest, duration) {
  capsule_data = self physics_getcharactercollisioncapsule();
  draw_capsule(self getorigin(), capsule_data["radius"], capsule_data["half_height"] * 2, self getplayerangles(), color, depthtest, duration);
}

function draw_ent_bone_forever(bone_name, origin_color) {
  self endon("stop_drawing_axis");
  self endon("death");

  while(true) {
    bone_origin = self gettagorigin(bone_name);
    bone_angles = self gettagangles(bone_name);
    draw_angles(bone_angles, bone_origin, origin_color);
    waitframe();
  }
}

function draw_ent_axis_forever(origin_color, scale) {
  self endon("stop_drawing_axis");
  self endon("death");

  while(true) {
    draw_ent_axis(origin_color, undefined, scale);
    waitframe();
  }
}

function draw_tag_axis_forever(tag, origin_color, scale) {
  self endon("stop_drawing_axis");
  self endon("death");

  while(true) {
    draw_tag_axis(tag, origin_color, undefined, scale);
    waitframe();
  }
}

function draw_ent_axis(origin_color, duration, scale) {
  waittillframeend();
  angles = self.angles ?? (0, 0, 0);
  draw_angles(angles, self.origin, origin_color, duration, scale);
}

function draw_tag_axis(tag, origin_color, duration, scale) {
  waittillframeend();
  angles = self gettagangles(tag);
  origin = self gettagorigin(tag);
  draw_angles(angles, origin, origin_color, duration, scale);
}

function draw_angles(angles, origin, origin_color, duration, scale) {
  waittillframeend();
  forward = anglesToForward(angles);
  right = anglestoright(angles);
  up = anglestoup(angles);
  assert(vectordot(forward, right) == 0);
  assert(vectordot(forward, up) == 0);
  assert(vectordot(up, right) == 0);

  if(!isDefined(origin_color)) {
    origin_color = (1, 0, 1);
  }

  if(!isDefined(duration)) {
    duration = 1;
  }

  if(!isDefined(scale)) {
    scale = 10;
  }

  sphere(origin, 1, origin_color, 0, duration);
  line(origin, origin + forward * scale, (1, 0, 0), 1, 0, duration);
  line(origin, origin + right * scale, (0, 1, 0), 1, 0, duration);
  line(origin, origin + up * scale, (0, 0, 1), 1, 0, duration);
}

function draw_entity_bounds(ent, time_sec, color, dynamic, var_6a2940883cf7f705) {
  assert(isDefined(ent));
  assert(time_sec > 0);

  if(!isDefined(color)) {
    color = (0, 1, 0);
  }

  if(!isDefined(dynamic)) {
    dynamic = 0;
  }

  if(!isDefined(var_6a2940883cf7f705)) {
    var_6a2940883cf7f705 = level.framedurationseconds;
  }

  if(dynamic) {
    num_frames = int(var_6a2940883cf7f705 / level.framedurationseconds);
  } else {
    num_frames = int(time_sec / level.framedurationseconds);
  }

  var_b997226e65e9c8a1 = [];
  var_b9971f6e65e9c208 = [];
  current = gettime();
  end = current + time_sec * 1000;

  while(current < end && isDefined(ent)) {
    var_b997226e65e9c8a1[0] = ent getpointinbounds(1, 1, 1);
    var_b997226e65e9c8a1[1] = ent getpointinbounds(1, 1, -1);
    var_b997226e65e9c8a1[2] = ent getpointinbounds(-1, 1, -1);
    var_b997226e65e9c8a1[3] = ent getpointinbounds(-1, 1, 1);
    var_b9971f6e65e9c208[0] = ent getpointinbounds(1, -1, 1);
    var_b9971f6e65e9c208[1] = ent getpointinbounds(1, -1, -1);
    var_b9971f6e65e9c208[2] = ent getpointinbounds(-1, -1, -1);
    var_b9971f6e65e9c208[3] = ent getpointinbounds(-1, -1, 1);

    for(i = 0; i < 4; i++) {
      j = i + 1;

      if(j == 4) {
        j = 0;
      }

      line(var_b997226e65e9c8a1[i], var_b997226e65e9c8a1[j], color, 1, 0, num_frames);
      line(var_b9971f6e65e9c208[i], var_b9971f6e65e9c208[j], color, 1, 0, num_frames);
      line(var_b997226e65e9c8a1[i], var_b9971f6e65e9c208[i], color, 1, 0, num_frames);
    }

    if(!dynamic) {
      return;
    }

    wait var_6a2940883cf7f705;
    current = gettime();
  }
}

function getfx(fx) {
  if(!isDefined(level._effect[fx])) {
    assertmsg("<dev string:x54e>" + (isxhash(fx) ? getxhashsourcename(fx) : fx) + "<dev string:x555>");
  }

  return level._effect[fx];
}

function fxexists(fx) {
  return isDefined(level._effect[fx]);
}

function playerunlimitedammothread() {
  if(!isDefined(self) || self == level || isDefined(self.code_classname) && self.code_classname != "<dev string:x57a>") {
    player = level.player;
  } else {
    player = self;
  }

  assert(isDefined(player));

  while(true) {
    wait 0.5;

    if(getdvarint(@ "unlimitedammooff") == 1) {
      continue;
    }

    currentweapon = player getcurrentweapon();

    if(!isnullweapon(currentweapon)) {
      currentammo = player getfractionmaxammo(currentweapon);

      if(currentammo < 0.2) {
        player givemaxammo(currentweapon);
      }
    }

    currentoffhand = player getcurrentoffhand();

    if(!isnullweapon(currentoffhand)) {
      currentammo = player getfractionmaxammo(currentoffhand);

      if(currentammo < 0.4) {
        player givemaxammo(currentoffhand);
      }
    }
  }
}

function spawn_tag_origin(org, ang) {
  if(!isDefined(ang) && isDefined(self.angles)) {
    ang = self.angles;
  }

  if(!isDefined(org) && isDefined(self.origin)) {
    org = self.origin;
  }

  if(!isDefined(org)) {
    org = (0, 0, 0);
  }

  tag_origin = spawn("script_model", org);
  tag_origin setModel("tag_origin");
  tag_origin hide();

  if(isDefined(ang)) {
    tag_origin.angles = ang;
  }

  return tag_origin;
}

function function_1808878d1c511ce8(org, ang) {
  tag_origin = spawn_tag_origin(org, ang);
  tag_origin show();
  return tag_origin;
}

function waittill_notify_or_timeout(msg, timer) {
  self endon(msg);
  wait timer;
}

function function_7ce22801650d61d4(msg, timer) {
  level endon("game_ended");
  self endon(msg);
  wait timer;
}

function waittill_notify_or_timeout_return(notifymessage, timer) {
  notifystruct = spawnStruct();
  thread waittill_notify_proc(notifystruct, notifymessage);
  thread waittill_timeout_proc(notifystruct, timer);
  notifystruct waittill("waittill_proc", result);
  return result;
}

function waittill_notify_proc(notifystruct, notifymessage) {
  notifystruct endon("waittill_proc");
  self waittill(notifymessage);
  notifystruct notify("waittill_proc", notifymessage);
}

function waittill_timeout_proc(notifystruct, timeout) {
  notifystruct endon("waittill_proc");
  wait timeout;
  notifystruct notify("waittill_proc", "timeout");
}

function waittill_notify_and_time(msg, time) {
  starttime = gettime();
  self waittill(msg);
  endtime = starttime + time * 1000;
  timeleft = endtime - starttime;

  if(timeleft > 0) {
    waittime = timeleft / 1000;
    wait waittime;
  }
}

function function_3be250f0ba0da4f6(msg, time) {
  self waittill(msg);
  wait time;
}

function array_wait(array, message, timeout) {
  notifystruct = spawnStruct();

  if(timeout) {
    thread array_wait_timeout_proc(notifystruct, timeout);
    notifystruct endon("array_wait_timeout");
  }

  foreach(element in array) {
    thread array_wait_proc(notifystruct, element, message);
  }

  for(i = 0; i < array.size; i++) {
    notifystruct waittill("array_wait_proc");
  }

  notifystruct notify("array_wait_success");
}

function array_wait_proc(notifystruct, element, message) {
  notifystruct endon("array_wait_success");
  element waittill_any(message, "death");
  notifystruct notify("array_wait_proc");
}

function array_wait_timeout_proc(notifystruct, timeout) {
  notifystruct endon("array_wait_success");
  wait timeout;
  notifystruct notify("array_wait_timeout");
}

function array_any_wait(array, message) {
  notifystruct = spawnStruct();

  foreach(element in array) {
    thread array_any_wait_proc(notifystruct, element, message);
  }

  notifystruct waittill("array_wait_proc", result);
  return result;
}

function array_any_wait_timeout(array, message, timeout) {
  notifystruct = spawnStruct();
  thread array_any_wait_timeout_proc(notifystruct, timeout);

  foreach(element in array) {
    thread array_any_wait_proc(notifystruct, element, message);
  }

  notifystruct waittill("array_wait_proc", result);
  return result;
}

function array_any_wait_proc(notifystruct, element, message) {
  result = element waittill_any_return_no_endon_death(message, "death");
  notifystruct notify("array_wait_proc", result);
}

function array_any_wait_timeout_proc(notifystruct, timeout) {
  notifystruct endon("array_wait_proc");
  wait timeout;
  notifystruct notify("array_wait_proc", "timeout");
}

function array_any_wait_return(array, message) {
  notifystruct = spawnStruct();

  foreach(element in array) {
    thread array_any_wait_return_proc(notifystruct, element, message);
  }

  notifystruct waittill("array_wait_proc", element);
  return element;
}

function array_any_wait_return_proc(notifystruct, element, message) {
  result = element waittill_any_return(message, "death");
  notifystruct notify("array_wait_proc", element);
}

function fileprint_launcher_start_file()
{
  assert(!isDefined(level. fileprint_launcher ), "<dev string:x584>" );
        level.fileprintlauncher_linecount = 0; level. fileprint_launcher = 1;
        fileprint_launcher( "GAMEPRINTSTARTFILE:" );
      }

      function fileprint_launcher( string )
      {
        assert(isDefined(level.fileprintlauncher_linecount));
        level.fileprintlauncher_linecount++;

        if(level.fileprintlauncher_linecount > 200) {
          wait 0.05;
          level.fileprintlauncher_linecount = 0;
        }

        println("<dev string:x5ca>" + string);
      }

      function fileprint_launcher_end_file( var_5756f07f5c4d9982, var_390f5c13316351df = 0 )
      {
        setdevdvarifuninitialized(@ "launcher_print_fail", "<dev string:x5de>");
        setdevdvarifuninitialized(@ "hash_afbeda0efab5bd5e", "<dev string:x5de>");

        if(var_390f5c13316351df) {
          fileprint_launcher( "GAMEPRINTENDFILE:GAMEPRINTP4ENABLED:" + var_5756f07f5c4d9982 );
        } else {
          fileprint_launcher( "GAMEPRINTENDFILE:" + var_5756f07f5c4d9982 );
        }

        timeout = gettime() + 4000;

        while(getdvarint(@ "hash_afbeda0efab5bd5e") == 0 && getDvar(@ "launcher_print_fail") == "0" && gettime() < timeout) {
          wait 0.05;
        }

        if(!(gettime() < timeout)) {
          iprintlnbold("LAUNCHER_PRINT_FAIL:( TIMEOUT ): launcherconflict? restart launcher and try again? ");

          setdevdvar(@ "launcher_print_fail", "<dev string:x5de>");

          level. fileprint_launcher = undefined;
          return false;
        }

        failvar = getDvar(@ "launcher_print_fail");

        if(failvar != "0") {
          iprintlnbold("LAUNCHER_PRINT_FAIL:( " + failvar + " ): launcherconflict? restart launcher and try again? ");

          setdevdvar(@ "launcher_print_fail", "<dev string:x5de>");

          level. fileprint_launcher = undefined;
          return false;
        }

        setdevdvar(@ "launcher_print_fail", "<dev string:x5de>");
        setdevdvar(@ "hash_afbeda0efab5bd5e", "<dev string:x5de>");

        iprintlnbold("Launcher write to file successful!");
        level. fileprint_launcher = undefined;
        return true;
      }

      function launcher_write_clipboard(str) {
        level.fileprintlauncher_linecount = 0;
        fileprint_launcher( "LAUNCHER_CLIP:" + str );
      }

      function activate_individual_exploder() {
        exploder::activate_individual_exploder_proc();
      }

      function get_target_ent(target = self.target) {
        assert(isDefined(target), "<dev string:x5e3>");
        var_7237854e3be197ca = getEnt(target, #targetname);

        if(isDefined(var_7237854e3be197ca)) {
          return var_7237854e3be197ca;
        }

        if(issp()) {
          var_7237854e3be197ca = builtin[[level.getnodefunction]](target, "targetname");

          if(isDefined(var_7237854e3be197ca)) {
            return var_7237854e3be197ca;
          }

          var_7237854e3be197ca = builtin[[level.func["getspawner"]]](target, "targetname");

          if(isDefined(var_7237854e3be197ca)) {
            return var_7237854e3be197ca;
          }
        }

        var_7237854e3be197ca = getStruct(target, "targetname");

        if(isDefined(var_7237854e3be197ca)) {
          return var_7237854e3be197ca;
        }

        var_7237854e3be197ca = getvehiclenode(target, #targetname);

        if(isDefined(var_7237854e3be197ca)) {
          return var_7237854e3be197ca;
        }

        assertmsg("<dev string:x5fa>" + target + "<dev string:x60f>");
      }

      function get_links() {
        return strtok(self.script_linkto, " ");
      }

      function get_linked_ents() {
        array = [];

        if(isDefined(self.script_linkto)) {
          linknames = get_links();

          if(linknames.size == 1) {
            return getEntArray(linknames[0], #script_linkname);
          } else if(linknames.size > 1) {
            return function_92805cf2b0baa4ca(linknames, #script_linkname);
          }
        }

        return array;
      }

      function get_linked_ent() {
        array = get_linked_ents();
        assert(array.size == 1);
        assert(isDefined(array[0]));
        return array[0];
      }

      function get_linked_nodes() {
        if(isDefined(self.script_linkto)) {
          linknames = get_links();

          if(linknames.size == 1) {
            return getnodearray(linknames[0], #script_linkname);
          } else if(linknames.size > 1) {
            return getnodesfromvalues(linknames, #script_linkname);
          }
        }

        return [];
      }

      function function_3b7b402e203142e7() {
        array = get_linked_nodes();

        if(!array.size) {
          return undefined;
        }

        assert(array.size == 1);
        assert(isDefined(array[0]));
        return array[0];
      }

      function function_e1bb0bf82dab729e() {
        array = [];

        if(isDefined(self.script_linkto)) {
          linknames = get_links();

          for(i = 0; i < linknames.size; i++) {
            scriptables = getentitylessscriptablearray(linknames[i], "script_linkname");

            if(scriptables.size > 0) {
              array = arraycombine(array, scriptables);
            }
          }
        }

        return array;
      }

      function do_earthquake(name, origin) {
        eq = level.earthquake[name];
        earthquake(eq["magnitude"], eq["duration"], origin, eq["radius"]);

        if(isDefined(level.var_2d9450b396fc7d4d)) {
          level thread[[level.var_2d9450b396fc7d4d]](name, origin, eq["magnitude"], eq["duration"], eq["radius"]);
        }
      }

      function play_loopsound_in_space(alias, origin) {
        org = spawn("script_origin", (0, 0, 0));
        org.targetname = "play_loopsound_in_space";

        if(!isDefined(origin)) {
          origin = self.origin;
        }

        org.origin = origin;
        org playLoopSound(alias);
        return org;
      }

      function play_sound_in_space_with_angles(alias, origin, angles, parent) {
        org = spawn("script_origin", (0, 0, 1));
        org.targetname = "play_sound_in_space_with_angles";
        org.origin = origin ?? self.origin;
        org.angles = angles;

        if(isDefined(parent)) {
          org linkTo(parent);
        }

        if(isDefined(self.v)) {
          org.createfx_ent = 1;
        }

        if(issp()) {
          org playSound(alias, "sounddone");
          org waittill("sounddone");
        } else {
          org playSound(alias);
        }

        org delete();
      }

      function play_sound_in_space(alias, origin, parent) {
        play_sound_in_space_with_angles(alias, origin, (0, 0, 0), parent);
      }

      function play_loop_sound_on_tag(alias, tag, bstopsoundondeath, var_af7c308ffd7e030e, release_sound) {
        org = spawn("script_origin", (0, 0, 0));
        org.targetname = "play_loop_soun_on_tag";
        org endon("death");

        if(!isDefined(bstopsoundondeath)) {
          bstopsoundondeath = 1;
        }

        if(bstopsoundondeath) {
          thread delete_on_death(org);
        }

        if(!isDefined(var_af7c308ffd7e030e)) {
          var_af7c308ffd7e030e = 0;
        }

        if(var_af7c308ffd7e030e) {
          thread delete_on_removed(org);
        }

        if(isDefined(tag)) {
          org linkTo(self, tag, (0, 0, 0), (0, 0, 0));
        } else {
          org.origin = self.origin;
          org.angles = self.angles;
          org linkTo(self);
        }

        org playLoopSound(alias);
        self waittill("stop sound" + alias);

        if(isDefined(release_sound)) {
          org playSound(release_sound, "sounddone");
          org delaycall(0.15, &stoploopsound, alias);
          org waittill("sounddone");
          org delete();
          return;
        }

        org stoploopsound(alias);
        org delete();
      }

      function delete_on_removed(ent) {
        ent endon("death");

        while(isDefined(self)) {
          wait 0.05;
        }

        if(isDefined(ent)) {
          ent delete();
        }
      }

      function loop_fx_sound(alias, origin, culled, ender, createfx_ent) {
        loop_fx_sound_with_angles(alias, origin, (0, 0, 0), culled, ender, createfx_ent);
      }

      function loop_fx_sound_with_angles(alias, origin, angles, culled, ender, createfx_ent, shape) {
        if(culled) {
          if(!isDefined(level.first_frame) || level.first_frame == 1) {
            spawnloopingsound(alias, origin, angles);
          }

          return;
        }

        if(level.createfx_enabled && isDefined(createfx_ent.loopsound_ent)) {
          org = createfx_ent.loopsound_ent;
        } else {
          org = spawn("script_origin", (0, 0, 0));
          org.targetname = "loop_fx_sound_with_angles";
        }

        if(isDefined(self.v)) {
          org.createfx_ent = 1;
        }

        if(isDefined(ender)) {
          thread loop_sound_delete(ender, org);
          self endon(ender);
        }

        org.origin = origin;
        org.angles = angles;
        org playLoopSound(alias);

        if(level.createfx_enabled) {
          createfx_ent.loopsound_ent = org;
          return;
        }

        org willneverchange();
      }

      function loop_fx_sound_interval(alias, origin, ender, timeout, delay_min, delay_max) {
        loop_fx_sound_interval_with_angles(alias, origin, (0, 0, 0), ender, timeout, delay_min, delay_max);
      }

      function loop_fx_sound_interval_with_angles(alias, origin, angles, ender, timeout, delay_min, delay_max) {
        self.origin = origin;
        self.angles = angles;

        if(isDefined(ender)) {
          self endon(ender);
        }

        if(delay_min >= delay_max) {
          while(true) {
            print3d(origin, "<dev string:x62a>", (1, 0, 0), 1, 1);

            wait 0.05;
          }
        }

        if(!soundexists(alias)) {
          while(true) {
            print3d(origin, "<dev string:x644>" + alias, (1, 0, 0), 1, 1);

            wait 0.05;
          }
        }

        while(true) {
          wait randomfloatrange(delay_min, delay_max);
          lock("createfx_looper");
          thread play_sound_in_space_with_angles(alias, self.origin, self.angles, undefined);
          unlock("createfx_looper");
        }
      }

      function loop_sound_delete(ender, ent) {
        ent endon("death");
        self waittill(ender);
        ent delete();
      }

      function createloopeffect(fxid) {
        ent = createfx::createeffect("loopfx", fxid);
        ent.v["delay"] = createfx::getloopeffectdelaydefault();
        return ent;
      }

      function createoneshoteffect(fxid) {
        ent = createfx::createeffect("oneshotfx", fxid);
        ent.v["delay"] = createfx::getoneshoteffectdelaydefault();
        return ent;
      }

      function createexploder(fxid, islevelexploder) {
        ent = createfx::createeffect("exploder", fxid, islevelexploder);
        ent.v["delay"] = createfx::getexploderdelaydefault();
        ent.v["exploder_type"] = "normal";
        return ent;
      }

      function play_loop_sound_on_entity(alias, offset) {
        org = spawn("script_origin", (0, 0, 0));
        org.targetname = "loop_sound_on_entity";
        org endon("death");
        thread delete_on_death(org);

        if(isDefined(offset)) {
          org.origin = self.origin + offset;
          org.angles = self.angles;
          org linkTo(self);
        } else {
          org.origin = self.origin;
          org.angles = self.angles;
          org linkTo(self);
        }

        org playLoopSound(alias);
        self waittill("stop sound" + alias);
        org stoploopsound(alias);
        org delete();
      }

      function stop_loop_sound_on_entity(alias) {
        self notify("stop sound" + alias);
      }

      function delete_on_death(ent) {
        ent endon("death");
        self waittill("death");

        if(isDefined(ent)) {
          ent delete();
        }
      }

      function destroy_on_death(ent) {
        ent endon("death");
        self waittill("death");

        if(isDefined(ent)) {
          ent destroy();
        }
      }

      function delete_on_sounddone() {
        self waittill("sounddone");
        self delete();
      }

      function delete_on_notify(msg) {
        self waittill(msg);
        self delete();
      }

      function function_9a9165839779317f(ent, msg) {
        self waittill(msg);

        if(isDefined(ent)) {
          ent delete();
        }
      }

      function function_439f7faeb95d2028(delay) {
        wait delay;

        if(isDefined(self)) {
          self delete();
        }
      }

      function error(msg) {
        println("<dev string:x652>", msg);

        if(getdvarint(@ "scr_debug") != 1) {
          assertmsg("<dev string:x663>" + msg);
        }
      }

      function exploder(num, players, starttime, radius, origin) {
        if(level.var_630c046b7e8fcc54 == gettime()) {
          delaythread(level.framedurationseconds, level._fx.exploderfunction, num, players, starttime, radius, origin);
          return;
        }

        self[[level._fx.exploderfunction]](num, players, starttime, radius, origin);
      }

      function delete_exploder(num) {
        exploder::delete_exploder_proc(num);
      }

      function hide_exploder_models(num) {
        exploder::hide_exploder_models_proc(num);
      }

      function show_exploder_models(num) {
        exploder::show_exploder_models_proc(num);
      }

      function stop_exploder(num, players, radius, origin) {
        exploder::stop_exploder_proc(num, players, 0, radius, origin);
      }

      function kill_exploder(num, players, radius, origin) {
        exploder::stop_exploder_proc(num, players, 1, radius, origin);
      }

      function get_exploder_array(msg) {
        return exploder::get_exploder_array_proc(msg);
      }

      function function_e153375527829ec3(value, default_value, err_msg) {
        if(!isDefined(value)) {
          if(isDefined(err_msg)) {
            assertmsg(err_msg);
          }

          return default_value;
        }

        return value;
      }

      function create_lock(msg, count = 1) {
        assert(isDefined(msg));

        if(!isDefined(level.lock)) {
          level.lock = [];
        }

        lock_struct = spawnStruct();
        lock_struct.max_count = count;
        lock_struct.count = 0;
        level.lock[msg] = lock_struct;
      }

      function lock(msg) {
        assert(isDefined(level.lock));
        assert(isDefined(level.lock[msg]));
        lock = level.lock[msg];

        while(lock.count >= lock.max_count) {
          lock waittill("unlocked");
        }

        lock.count++;
      }

      function unlock(msg) {
        thread unlock_thread(msg);
      }

      function unlock_thread(msg) {
        wait 0.05;
        assert(isDefined(level.lock));
        assert(isDefined(level.lock[msg]));
        lock = level.lock[msg];
        lock.count--;
        assert(lock.count >= 0);
        lock notify("unlocked");
      }

      function unlock_wait(msg) {
        thread unlock_thread(msg);
        wait 0.05;
      }

      function is_player_gamepad_enabled() {
        var_cfeeac0e68c399bc = self usinggamepad();

        if(isDefined(var_cfeeac0e68c399bc)) {
          return var_cfeeac0e68c399bc;
        } else if(self ispcplayer()) {
          return 0;
        }

        return 1;
      }

      function player_prestream_camera(position, duration = 5, altposition = undefined) {
        thread player_prestream_camera_thread(position, duration, altposition);
      }

      function private player_prestream_camera_thread(position, duration = 5, altposition = undefined) {
        assert(isPlayer(self));
        player = self;
        player notify("player_prestream_camera");
        player endon("player_prestream_camera");
        player endon("death_or_disconnect");
        player clearadditionalstreampos();

        if(isDefined(altposition)) {
          player setadditionalstreamposuntilcleared(altposition);
        }

        player predictstreamposuntilcleared(position);

        if(duration > 0) {
          wait duration;
        } else if(duration < 0) {
          return;
        }

        player clearadditionalstreampos();
        player clearpredictedstreampos();
      }

      function player_prestream_camera_wait(position, timeoutsec = 2) {
        assert(isPlayer(self));
        player = self;
        player clearadditionalstreampos();
        player predictstreamposuntilcleared(position);
        endtime = gettime() + timeoutsec * 1000;

        while(isDefined(player) && gettime() < endtime) {
          waitframe();

          if(player ispredictedstreamposready()) {
            break;
          }
        }

        if(isDefined(player)) {
          player clearpredictedstreampos();
        }
      }

      function player_prestream_assets(assettype, assets, distances, duration = 5) {
        if(!isarray(assets)) {
          assets = [assets];
        }

        if(!isDefined(distances)) {
          distances = [];

          foreach(asset in assets) {
            distances[distances.size] = 50;
          }
        } else if(!isarray(distances)) {
          distances = [distances];
        }

        thread player_prestream_assets_thread(assettype, assets, distances, duration);
      }

      function private player_prestream_assets_thread(assettype, assets, distances, duration) {
        assert(isPlayer(self));
        player = self;
        player notify("player_prestream_assets_thread_" + assettype);
        player endon("player_prestream_assets_thread_" + assettype);
        player endon("disconnect");
        player prestreamclear(assettype);

        if(duration != 0) {
          foreach(idx, asset in assets) {
            if(self function_72b767355af09ad8() >= 32) {
              iprintln("<dev string:x696>" + 32);

              break;
            }

            if(isDefined(asset)) {
              player prestreamasset(assettype, asset, distances[idx]);
            }
          }

          if(duration < 0) {
            return;
          }

          wait duration;

          if(isPlayer(player)) {
            player prestreamclear(assettype);
          }
        }
      }

      function function_b616dec377c0b1c5(assettype, asset, dist = 50) {
        thread function_f23e597bf8ac79da(assettype, asset, dist);
      }

      function private function_f23e597bf8ac79da(assettype, asset, dist) {
        self notify("d7d1ba101bb6df3f");
        self endon("d7d1ba101bb6df3f");
        player = self;
        player endon("disconnect");

        if(!isDefined(player.prestreamtouch)) {
          player.prestreamtouch = [];
        }

        if(!isDefined(player.prestreamtouch[assettype])) {
          player.prestreamtouch[assettype] = [];
        }

        if(isDefined(player.prestreamtouch[assettype][asset])) {
          player.prestreamtouch[assettype][asset] = min(player.prestreamtouch[assettype][asset], dist);
        } else {
          player.prestreamtouch[assettype][asset] = dist;
        }

        waittillframeend();
        cleartypes = [];

        foreach(assettype, assets in player.prestreamtouch) {
          cleartypes[cleartypes.size] = assettype;
          player prestreamclear(assettype);

          foreach(asset, dist in assets) {
            player prestreamasset(assettype, asset, dist);
          }
        }

        player.prestreamtouch = undefined;
        waitframe();

        foreach(assettype in cleartypes) {
          player prestreamclear(assettype);
        }
      }

      function distance_2d_squared(a, b) {
        return length2dsquared(a - b);
      }

      function get_array_of_farthest(org, array, excluders, max, maxdist, mindist) {
        aarray = get_array_of_closest(org, array, excluders, max, maxdist, mindist);
        aarray = array_reverse(aarray);
        return aarray;
      }

      function get_array_of_closest(org, array, excluders = [], max = array.size, maxdist, mindist, reversesort = 0) {
        maxdist2rd = undefined;

        if(isDefined(maxdist)) {
          maxdist2rd = maxdist * maxdist;
        }

        mindist2rd = 0;

        if(isDefined(mindist)) {
          mindist2rd = mindist * mindist;
        }

        if(excluders.size == 0 && max >= array.size && mindist2rd == 0 && !isDefined(maxdist2rd)) {
          return sortbydistance(array, org);
        }

        newarray = [];

        foreach(ent in array) {
          excluded = 0;

          foreach(excluder in excluders) {
            if(ent == excluder) {
              excluded = 1;
              break;
            }
          }

          if(excluded) {
            continue;
          }

          dist2rd = distancesquared(org, ent.origin);

          if(dist2rd > maxdist2rd) {
            continue;
          }

          if(dist2rd < mindist2rd) {
            continue;
          }

          newarray[newarray.size] = ent;
        }

        newarray = sortbydistance(newarray, org, reversesort);

        if(max >= newarray.size) {
          return newarray;
        }

        finalarray = [];

        for(i = 0; i < max; i++) {
          finalarray[i] = newarray[i];
        }

        return finalarray;
      }

      function function_6827a4ce28e62b74(org, array, maxdist) {
        maxdistsquared = maxdist * maxdist;
        finalarray = [];

        foreach(ent in array) {
          if(distance2dsquared(org, ent.origin) < maxdistsquared) {
            finalarray[finalarray.size] = ent;
          }
        }

        return finalarray;
      }

      function drop_to_ground(pos, updist, downdist, upvector, contents, ignore, var_6349832b72dd54b0) {
        if(issharedfuncdefined(#"UTILITY", #"drop_to_ground")) {
          return callsharedfunc(#"UTILITY", #"drop_to_ground", pos, updist, downdist, upvector, contents);
        }

        assert(isDefined(pos), "<dev string:x6cd>");

        if(!isDefined(updist)) {
          updist = 1500;
        }

        if(!isDefined(downdist)) {
          downdist = -12000;
        }

        if(!isDefined(contents)) {
          contents = trace::create_solid_ai_contents(1);
        }

        if(isDefined(upvector)) {
          result = trace::ray_trace(pos + updist * upvector, pos + downdist * upvector, ignore, contents);
        } else {
          result = trace::ray_trace(pos + (0, 0, updist), pos + (0, 0, downdist), ignore, contents);
        }

        if(var_6349832b72dd54b0) {
          return [result["position"], result["normal"]];
        }

        return result["position"];
      }

      function player_drop_to_ground(pos, radius, updist = 1500, downdist = -12000, upvector) {
        contents = trace::create_solid_ai_contents(1);

        if(isDefined(upvector)) {
          return trace::sphere_trace(pos + updist * upvector, pos + downdist * upvector, radius, undefined, contents)["position"];
        }

        return trace::sphere_trace(pos + (0, 0, updist), pos + (0, 0, downdist), radius, undefined, contents)["position"];
      }

      function function_5918594658d3ffba(pos, up_dist, down_dist, z_tolerance = 32) {
        ground_pos = drop_to_ground(pos, up_dist, down_dist);
        navmesh_pos = getclosestpointonnavmesh(ground_pos, undefined, 0, 0, 0);

        if(isDefined(navmesh_pos)) {
          max_z = max(ground_pos[2], navmesh_pos[2]);
          min_z = min(ground_pos[2], navmesh_pos[2]);

          if(max_z - min_z <= z_tolerance) {
            final_pos = (navmesh_pos[0], navmesh_pos[1], max_z);
            return final_pos;
          }
        }

        return undefined;
      }

      function within_fov(start_origin, start_angles, end_origin, fov) {
        return withinfov(start_origin, start_angles, end_origin, fov);
      }

      function function_4325398d215ecda5(org, array, maxdist) {
        closestent = undefined;
        closestdistancesq = isDefined(maxdist) ? squared(maxdist) : undefined;

        foreach(ent in array) {
          if(isent(ent)) {
            point = ent.origin;
          } else if(isvector(ent)) {
            point = ent;
          }

          if(!isDefined(point)) {
            continue;
          }

          distancesq = distance2dsquared(point, org);

          if(!isDefined(closestdistancesq) || distancesq < closestdistancesq) {
            closestent = ent;
            closestdistancesq = distancesq;
          }
        }

        return closestent;
      }

      function function_c8d94894e1fd8fc8(org, array, max_dist, filter) {
        closest_ent = undefined;
        closest_dist_sqr = isDefined(max_dist) ? squared(max_dist) : undefined;

        foreach(ent in array) {
          if(!isDefined(ent.origin)) {
            continue;
          }

          if(isDefined(filter) && ![[filter]](ent)) {
            continue;
          }

          dist_sqr = distancesquared(ent.origin, org);

          if(!isDefined(closest_dist_sqr) || dist_sqr < closest_dist_sqr) {
            closest_ent = ent;
            closest_dist_sqr = dist_sqr;
          }
        }

        return closest_ent;
      }

      function get_closest_player(needenemyplayer = 0) {
        closestplayer = undefined;
        closestdistsq = undefined;

        foreach(player in level.players) {
          if(player == self || !isalive(player)) {
            continue;
          }

          if(needenemyplayer && !isenemyteam(self.team, player.team)) {
            continue;
          }

          distsq = distancesquared(self.origin, player.origin);

          if(!isDefined(closestdistsq) || distsq < closestdistsq) {
            closestdistsq = distsq;
            closestplayer = player;
          }
        }

        return closestplayer;
      }

      function function_6e6f301423539d40(needenemyplayer = 0) {
        farthestdistsq = 0;

        foreach(player in level.players) {
          if(player == self || !isalive(player)) {
            continue;
          }

          if(needenemyplayer && !isenemyteam(self.team, player.team)) {
            continue;
          }

          distsq = distancesquared(self.origin, player.origin);

          if(distsq > farthestdistsq) {
            farthestdistsq = distsq;
          }
        }

        return farthestdistsq;
      }

      function get_alive_players() {
        a_players = level.players;
        a_alive_players = [];

        foreach(player in a_players) {
          if(isalive(player)) {
            a_alive_players[a_alive_players.size] = player;
          }
        }

        return a_alive_players;
      }

      function missile_settargetandflightmode(target, mode, offset) {
        assert(isDefined(target));
        assert(isDefined(mode));

        if(!isDefined(offset)) {
          offset = (0, 0, 0);
        }

        self missile_settargetEnt(target, offset);

        switch (mode) {
          case #"hash_da8b50286ccc05fc":
            self missile_setflightmodedirect();
            break;
          case #"hash_6d308d6c437ce11c":
            self missile_setflightmodetop();
            break;
        }
      }

      function load_fx(effect) {
        if(isstartstr(effect, "vfx/")) {
          return loadfx(effect);
        }

        return loadfxasset(effect);
      }

      function add_fx(fx_id, fx_path) {
        if(!isDefined(level._effect)) {
          level._effect = [];
        }

        if(!isDefined(fx_id) || !isDefined(fx_path)) {
          str_fx_id = fx_id ? isxhash(fx_id) ? getxhashsourcename(fx_id) : fx_id : "<dev string:x707>";
          str_fx_path = fx_path ? isxhash(fx_path) ? getxhashsourcename(fx_path) : fx_path : "<dev string:x707>";
          println("<dev string:x714>" + str_fx_id + "<dev string:x72e>" + str_fx_path + "<dev string:x73e>");
          assert(isDefined(fx_id), "<dev string:x74f>" + str_fx_path);
          assert(isDefined(fx_path), "<dev string:x77a>" + str_fx_id);

          return;
        }

        level._effect[fx_id] = load_fx(fx_path);
      }

      function create_func_ref(name, func) {
        if(!isDefined(level.func)) {
          level.func = [];
        }

        level.func[name] = func;
      }

      function create_empty_func_ref(name) {
        if(!isDefined(level.func)) {
          level.func = [];
        }

        if(!isDefined(level.func[name])) {
          create_func_ref(name, &empty_init_func);
        }
      }

      function func_ref_exist(name) {
        return isDefined(level.func) && isDefined(level.func[name]);
      }

      function add_init_script(name, init_function) {
        if(!isDefined(level.init_script)) {
          level.init_script = [];
        }

        if(isDefined(level.init_script[name])) {
          return false;
        }

        level.init_script[name] = init_function;
        return true;
      }

      function add_frame_event(event) {
        if(!isDefined(self.frame_events)) {
          self.frame_events = [event];
          thread process_frame_events();
          return;
        }

        self.frame_events[self.frame_events.size] = event;
      }

      function process_frame_events() {
        while(true) {
          if(!isDefined(self)) {
            break;
          }

          foreach(event in self.frame_events) {
            self thread[[event]]();
          }

          waitframe();
        }
      }

      function delaythread(timer, func, ...) {
        thread delaythread_internal(timer, undefined, func, varargcount, vararg);
      }

      function delaythreadendon(timer, endonevent, func, ...) {
        thread delaythread_internal(timer, endonevent, func, varargcount, vararg);
      }

      function delaythread_internal(timer, endonevent, func, varargcount, vararg) {
        if(isDefined(self) && !isarray(self)) {
          self endon("stop_delay_thread");
          self endon("death_or_disconnect");

          if(isDefined(endonevent)) {
            if(!isarray(endonevent)) {
              endonevent = [endonevent];
            }

            foreach(endonname in endonevent) {
              self endon(endonname);
            }
          }
        }

        wait timer;
        thread[[func]](flat_args(vararg, varargcount));
      }

      function damagelocationisany(...) {
        if(isDefined(self.damagelocation)) {
          foreach(damagelocation in vararg) {
            if(self.damagelocation == damagelocation) {
              return 1;
            }
          }
        }

        return damagesubpartlocationisany(flat_args(vararg, varargcount));
      }

      function damagesubpartlocationisany(...) {
        if(!isDefined(self.damagedsubpart)) {
          return false;
        }

        foreach(damagelocation in vararg) {
          if(self.damagedsubpart == damagelocation) {
            return true;
          }
        }

        return false;
      }

      function isbulletdamage(meansofdeath) {
        if(!isDefined(meansofdeath)) {
          assertmsg("<dev string:x7a5>");
          return 0;
        }

        switch (meansofdeath) {
          case #"hash_590bdb04e515167b":
          case #"hash_5f1054c48d66fd1c":
          case #"hash_966768b3f0c94767":
            return 1;
          default:
            return 0;
        }
      }

      function isfiredamage(meansofdeath) {
        if(!isDefined(meansofdeath)) {
          assertmsg("<dev string:x7cd>");
          return false;
        }

        return meansofdeath == "MOD_FIRE";
      }

      function isimpactdamage(meansofdeath) {
        if(!isDefined(meansofdeath)) {
          assertmsg("<dev string:x7f3>");
          return false;
        }

        return meansofdeath == "MOD_IMPACT";
      }

      function ismeleedamage(meansofdeath) {
        if(!isDefined(meansofdeath)) {
          assertmsg("<dev string:x81b>");
          return false;
        }

        return meansofdeath == "MOD_MELEE";
      }

      function ismeatshielddamage(meansofdeath) {
        if(!isDefined(meansofdeath)) {
          assertmsg("<dev string:x81b>");
          return false;
        }

        return meansofdeath == "MOD_MEATSHIELD";
      }

      function isvehiclecrushdamage(inflictor, meansofdeath) {
        if(!(isDefined(inflictor) && isDefined(inflictor vehicle::get_ref()))) {
          return false;
        }

        return meansofdeath == "MOD_CRUSH";
      }

      function isvalidpeekoutdir(dir) {
        node = self;
        peekouts = node getvalidcoverpeekouts();

        foreach(peekout in peekouts) {
          if(peekout == dir) {
            return true;
          }
        }

        return false;
      }

      function getbestcovermultinodetype(node) {
        assert(isai(self));
        nodetypelist = node getvalidcovermultinodetypes();

        if(nodetypelist.size <= 0) {
          return undefined;
        }

        yaw_diff = 0;

        if(isDefined(self.enemy)) {
          enemy_pos = self.enemy.origin;

          if(issentient(self.enemy) && self lastknowntime(self.enemy) > 0) {
            enemy_pos = self lastknownpos(self.enemy);
          }

          var_a4ac6ca439b08589 = vectortoangles(enemy_pos - node.origin);
          yaw_diff = angleclamp180(var_a4ac6ca439b08589[1] - node.angles[1]);
        }

        foreach(nodetypeit in nodetypelist) {
          switch (nodetypeit) {
            case #"hash_78b110033ccb68b0":
            case #"hash_c3b74422dec48736":
              if(abs(yaw_diff) < 30) {
                return nodetypeit;
              }

              break;
            case #"hash_55ed607005f12d49":
            case #"hash_e1d8e1adebed5a61":
              if(yaw_diff > 30) {
                return "Cover Left";
              }

              break;
            case #"hash_667bc7e605903a6c":
            case #"hash_cd3ffe799551db82":
              if(yaw_diff < -30) {
                return "Cover Right";
              }

              break;
            default:
              assertmsg("<dev string:x842>");
              break;
          }
        }

        nodetype = nodetypelist[0];

        switch (nodetype) {
          case #"hash_55ed607005f12d49":
            return "Cover Left";
          case #"hash_667bc7e605903a6c":
            return "Cover Right";
        }

        return nodetype;
      }

      function isnodecoverleft(node) {
        assert(isDefined(node) && isDefined(node.type));
        return node.type == "Cover Left";
      }

      function isnodecoverright(node) {
        assert(isDefined(node) && isDefined(node.type));
        return node.type == "Cover Right";
      }

      function isnodecovercrouchtype(node, type) {
        assert(isDefined(node));

        if(node.type == "Cover Crouch" && isDefined(self._blackboard.croucharrivaltype)) {
          return (self._blackboard.croucharrivaltype == type);
        }

        return false;
      }

      function isnode3d(node) {
        return isnodecover3d(node) || isnodeexposed3d(node);
      }

      function isnodecover3d(node) {
        assert(isDefined(node) && isDefined(node.type));
        return node.type == "Cover Stand 3D" || node.type == "Cover 3D";
      }

      function isnodeexposed3d(node) {
        assert(isDefined(node) && isDefined(node.type));
        return node.type == "Exposed 3D" || node.type == "Path 3D";
      }

      function isnodecovercrouch(node) {
        assert(isDefined(node) && isDefined(node.type));
        return node.type == "Cover Crouch" || node.type == "Cover Crouch Window" || node.type == "Conceal Crouch";
      }

      function getaimyawtopoint(point) {
        yaw = getyawtospot(point);
        dist = distance(self.origin, point);

        if(dist > 3) {
          anglefudge = asin(-3 / dist);
          yaw -= anglefudge;
        }

        yaw = angleclamp180(yaw);
        return yaw;
      }

      function getyawtospot(spot) {
        if(actor_is3d()) {
          forward = anglesToForward(self.angles);
          rotatedpos = rotatepointaroundvector(forward, spot - self.origin, self.angles[2] * -1);
          spot = rotatedpos + self.origin;
        }

        yaw = getyaw(spot) - self.angles[1];
        yaw = angleclamp180(yaw);
        return yaw;
      }

      function getyaw(org) {
        return vectortoyaw(org - self.origin);
      }

      function getaimyawtopoint3d(point) {
        yaw = getyawtospot3d(point);
        dist = distance(self.origin, point);

        if(dist > 3) {
          anglefudge = asin(-3 / dist);
          yaw -= anglefudge;
        }

        yaw = angleclamp180(yaw);
        return yaw;
      }

      function getyawtospot3d(spot) {
        var_40b69a03e72b5bb9 = spot - self.origin;
        var_a96e0316adc12c5f = rotatevectorinverted(var_40b69a03e72b5bb9, self.angles);
        yaw = vectortoyaw(var_a96e0316adc12c5f);
        yaw_clamped = angleclamp180(yaw);
        return yaw_clamped;
      }

      function getaimpitchtopoint3d(point) {
        pitch = getpitchtospot3d(point);
        dist = distance(self.origin, point);

        if(dist > 3) {
          anglefudge = asin(-3 / dist);
          pitch -= anglefudge;
        }

        pitch = angleclamp180(pitch);
        return pitch;
      }

      function getpitchtospot3d(spot) {
        var_40b69a03e72b5bb9 = spot - self.origin;
        var_a96e0316adc12c5f = rotatevectorinverted(var_40b69a03e72b5bb9, self.angles);
        pitch = vectortopitch(var_a96e0316adc12c5f);
        pitch_clamped = angleclamp180(pitch);
        return pitch_clamped;
      }

      function getplayerpitch(player) {
        assert(isPlayer(player));
        playerangles = player getplayerangles();
        assert(isnumber(playerangles[0]));
        return (playerangles[0] + 360) % 360;
      }

      function getplayeryaw(player) {
        assert(isPlayer(player));
        playerangles = player getplayerangles();
        assert(isnumber(playerangles[1]));
        return (playerangles[1] + 360) % 360;
      }

      function actor_isspace() {
        return istrue(self.space);
      }

      function actor_is3d() {
        return actor_isspace();
      }

      function getpredictedaimyawtoshootentorpos(time, shootent, shootpos) {
        if(!isDefined(shootent)) {
          if(!isDefined(shootpos)) {
            return 0;
          }

          return getaimyawtopoint(shootpos);
        }

        v = (0, 0, 0);

        if(isPlayer(shootent)) {
          v = shootent getvelocity();
        } else if(isai(shootent)) {
          v = shootent.velocity;
        }

        predictedpos = shootent.origin + v * time;
        return getaimyawtopoint(predictedpos);
      }

      function getpredictedaimyawtoshootentorpos3d(time, shootent, shootpos) {
        if(!isDefined(shootent)) {
          if(!isDefined(shootpos)) {
            return 0;
          }

          return getaimyawtopoint3d(shootpos);
        }

        v = (0, 0, 0);

        if(isPlayer(shootent)) {
          v = shootent getvelocity();
        } else if(isai(shootent)) {
          v = shootent.velocity;
        }

        predictedpos = shootent.origin + v * time;
        return getaimyawtopoint3d(predictedpos);
      }

      function getpredictedaimpitchtoshootentorpos3d(time, shootent, shootpos) {
        if(!isDefined(shootent)) {
          if(!isDefined(shootpos)) {
            return 0;
          }

          return getaimpitchtopoint3d(shootpos);
        }

        v = (0, 0, 0);

        if(isPlayer(shootent)) {
          v = shootent getvelocity();
        } else if(isai(shootent)) {
          v = shootent.velocity;
        }

        predictedpos = shootent.origin + v * time;
        return getaimpitchtopoint3d(predictedpos);
      }

      function player_is_in_jackal() {
        return false;
      }

      function set_createfx_enabled() {
        if(!isDefined(level.createfx_enabled)) {
          level.createfx_enabled = getDvar(@ "createfx", "") != "";
        }
      }

      function flag_set_delayed(message, delay, setter) {
        wait delay;
        flag_set(message, setter);
      }

      function noself_array_call(entities, process, ...) {
        foreach(ent in entities) {
          builtin[[process]](ent, flat_args(vararg, varargcount));
        }
      }

      function flag_assert(msg) {
        assert(!flag(msg), "<dev string:x87b>" + msg + "<dev string:x884>");
      }

      function flag_wait_any_array(flags) {
        assert(isarray(flags), "<dev string:x896>");
        flags = function_5713d46873b29625(flags);

        for(;;) {
          for(i = 0; i < flags.size; i++) {
            if(flag(flags[i])) {
              return flags[i];
            }
          }

          level waittill_any_in_array(flags);
        }
      }

      function function_b50230bef1a7445a(flags) {
        return flag_wait_any_array(flags);
      }

      function flag_wait_any(...) {
        if(varargcount < 2) {
          assertmsg("<dev string:x8d5>");
          return;
        }

        for(;;) {
          foreach(varflag in vararg) {
            if(flag(varflag)) {
              return;
            }
          }

          level waittill_any(flat_args(vararg, varargcount));
        }
      }

      function flag_wait_any_timeout(timer, ...) {
        if(varargcount < 2) {
          assertmsg("<dev string:x90c>");
          return;
        }

        assert(timer > 0, "<dev string:x94b>");
        timerms = timer * 1000;
        start_time = gettime();

        for(;;) {
          foreach(varflag in vararg) {
            if(flag(varflag)) {
              return;
            }
          }

          curr_time = gettime();

          if(curr_time >= start_time + timerms) {
            break;
          }

          timeremaining = timerms - curr_time - start_time;
          timeremainingsecs = timeremaining / 1000;
          internal_wait_for_any_flag_or_time_elapses(vararg, timeremainingsecs);
        }
      }

      function internal_wait_for_any_flag_or_time_elapses(flag_arr, timer) {
        foreach(flag_msg in flag_arr) {
          level endon(flag_msg);
        }

        wait timer;
      }

      function flag_wait_any_return(...) {
        if(varargcount < 2) {
          assertmsg("<dev string:x999>");
          return;
        }

        foreach(varflag in vararg) {
          if(flag(varflag)) {
            return varflag;
          }
        }

        msg = level waittill_any_return(flat_args(vararg, varargcount));
        return msg;
      }

      function flag_wait_all(...) {
        foreach(varflag in vararg) {
          flag_wait(varflag);
        }
      }

      function flag_wait_all_array(flags) {
        flags = function_5713d46873b29625(flags);

        for(;;) {
          foreach(flagname in flags) {
            flag_wait(flagname);
          }

          flagsetcount = 0;

          foreach(flagname in flags) {
            if(flag(flagname)) {
              flagsetcount++;
            }
          }

          if(flagsetcount == flags.size) {
            break;
          }
        }
      }

      function flag_waitopen_all_array(flags) {
        flags = function_5713d46873b29625(flags);

        for(;;) {
          foreach(flagname in flags) {
            flag_waitopen(flagname);
          }

          var_9527b70f552d82a8 = 0;

          foreach(flagname in flags) {
            if(!flag(flagname)) {
              var_9527b70f552d82a8++;
            }
          }

          if(var_9527b70f552d82a8 == flags.size) {
            break;
          }
        }
      }

      function flag_wait_or_timeout(flagname, timer) {
        timerms = timer * 1000;
        start_time = gettime();

        for(;;) {
          if(flag(flagname)) {
            break;
          }

          if(gettime() >= start_time + timerms) {
            break;
          }

          timeremaining = timerms - gettime() - start_time;
          timeremainingsecs = timeremaining / 1000;
          wait_for_flag_or_time_elapses(flagname, timeremainingsecs);
        }
      }

      function flag_waitopen_or_timeout(flagname, timer) {
        start_time = gettime();

        for(;;) {
          if(!flag(flagname)) {
            break;
          }

          if(gettime() >= start_time + timer * 1000) {
            break;
          }

          wait_for_flag_or_time_elapses(flagname, timer);
        }
      }

      function wait_for_flag_or_time_elapses(flagname, timer) {
        level endon(flagname);
        wait timer;
      }

      function noself_delaycall(timer, func, ...) {
        thread noself_delaycall_proc(func, timer, varargcount, vararg);
      }

      function private noself_delaycall_proc(func, timer, varargcount, vararg) {
        wait timer;
        builtin[[func]](flat_args(vararg, varargcount));
      }

      function get_target_array(target = self.target) {
        assert(isDefined(target), "<dev string:x5e3>");
        ents = getEntArray(target, #targetname);

        if(ents.size > 0) {
          return ents;
        }

        if(issp()) {
          ents = builtin[[level.getnodearrayfunction]](target, #targetname);

          if(ents.size > 0) {
            return ents;
          }
        }

        if(isDefined(level.struct_class_names)) {
          ents = getStructArray(target, "targetname");

          if(ents.size > 0) {
            return ents;
          }
        }

        ents = getvehiclenodearray(target, #targetname);

        if(ents.size > 0) {
          return ents;
        }

        assertmsg("<dev string:x5fa>" + target + "<dev string:x9d7>");
      }

      function pauseeffect() {
        createfx::stop_fx_looper();
      }

      function spawn_script_origin(org, ang) {
        if(!isDefined(ang) && isDefined(self.angles)) {
          ang = self.angles;
        }

        if(!isDefined(org) && isDefined(self.origin)) {
          org = self.origin;
        }

        if(!isDefined(org)) {
          org = (0, 0, 0);
        }

        script_origin = spawn("script_origin", org);
        script_origin.targetname = "spawn_script_origin";

        if(isDefined(ang)) {
          script_origin.angles = ang;
        }

        return script_origin;
      }

      function get_noteworthy_array(noteworthy) {
        assert(isDefined(noteworthy), "<dev string:x9f3>");
        ents = getEntArray(noteworthy, #script_noteworthy);

        if(ents.size > 0) {
          return ents;
        }

        if(issp()) {
          ents = builtin[[level.getnodearrayfunction]](noteworthy, #script_noteworthy);

          if(ents.size > 0) {
            return ents;
          }
        }

        if(isDefined(level.struct_class_names)) {
          ents = getStructArray(noteworthy, "script_noteworthy");

          if(ents.size > 0) {
            return ents;
          }
        }

        ents = getvehiclenodearray(noteworthy, #script_noteworthy);

        if(ents.size > 0) {
          return ents;
        }

        assert("<dev string:xa15>" + noteworthy + "<dev string:xa3a>");
      }

      function get_cumulative_weights(weights) {
        cumulative_weights = [];
        sum = 0;

        for(i = 0; i < weights.size; i++) {
          sum += weights[i];
          cumulative_weights[i] = sum;
        }

        return cumulative_weights;
      }

      function getanim(anime) {
        assert(isDefined(self.animname), "<dev string:xa54>");
        assert(isDefined(level.scr_anim[self.animname][anime]), "<dev string:xa80>");
        return level.scr_anim[self.animname][anime];
      }

      function hasanim(anime) {
        assert(isDefined(self.animname), "<dev string:xaa8>");
        return isDefined(level.scr_anim[self.animname][anime]);
      }

      function getanim_from_animname(anime, animname) {
        assert(isDefined(animname), "<dev string:xad4>");
        assert(isDefined(level.scr_anim[animname][anime]), "<dev string:xaef>");
        return level.scr_anim[animname][anime];
      }

      function getanim_generic(anime) {
        assert(isDefined(level.scr_anim["<dev string:xb25>"][anime]), "<dev string:xb30>");
        return level.scr_anim["generic"][anime];
      }

      function hasanim_generic(anime) {
        return isDefined(level.scr_anim["generic"][anime]);
      }

      function getanim_starts(anime, ent) {
        startpositions = [];

        if(animation::function_b8e0e318104693fb(anime)) {
          foreach(animation in level.scr_anim[ent.animname][anime]) {
            newanime = animation::function_179fdcb8d53829fe(anime, ent.animname, animation);
            animation::anim_first_frame_solo(ent, newanime);
            startpositions[startpositions.size] = ent.origin;
          }
        } else {
          animation::anim_first_frame_solo(ent, anime);
          startpositions[startpositions.size] = ent.origin;
        }

        return startpositions;
      }

      function waittill_match_or_timeout(msg, match, timer) {
        ent = spawnStruct();
        ent endon("complete");
        ent delaythread(timer, &send_notify, "complete");
        self waittillmatch(msg, match);
      }

      function function_1c579064b3fda85d(msg, match, endonmsg) {
        self endon(endonmsg);
        self waittillmatch(msg, match);
      }

      function waittill_match_or_timeout_return(msg, match, timer) {
        ent = spawnStruct();
        ent endon("complete");
        ent delaythread(timer, &send_notify, "complete");
        self waittill(msg, match);
        return match;
      }

      function send_notify(msg, optional_param) {
        if(isDefined(optional_param)) {
          self notify(msg, optional_param);
          return;
        }

        self notify(msg);
      }

      function get_notetrack_time(animation, notetrack) {
        notetracktimes = getnotetracktimes(animation, notetrack);
        animlength = getanimlength(animation);
        return notetracktimes[0] * animlength;
      }

      function mph_to_ips(mph) {
        return mph * 17.6;
      }

      function mph_travel_time(speed, dist) {
        speed = mph_to_ips(speed);
        time = dist / speed;
        return time;
      }

      function wrap_text(text, line_limit) {
        tokenized = strtok(text, " ");
        checked_words = "";
        lines = [];
        i = 0;
        total_characters = 0;

        foreach(word in tokenized) {
          if(total_characters > line_limit) {
            lines[lines.size] = checked_words;
            checked_words = "";
            total_characters = 0;
          }

          total_characters += word.size;
          checked_words += word;

          if(i != tokenized.size - 1) {
            checked_words += " ";
          } else {
            lines[lines.size] = checked_words;
          }

          i++;
        }

        return lines;
      }

      function function_b104528d84ca3561(string, delim, var_a4f640302ae7e692) {
        strings = strtok(string, delim, var_a4f640302ae7e692);
        ints = [];

        for(i = 0; i < strings.size; i++) {
          ints[i] = int(strings[i]);
        }

        return ints;
      }

      function function_d2db822aceef856a(string, delim, var_a4f640302ae7e692) {
        strings = strtok(string, delim, var_a4f640302ae7e692);
        floats = [];

        for(i = 0; i < strings.size; i++) {
          floats[i] = float(strings[i]);
        }

        return floats;
      }

      function closestdistancebetweenlines(p1, p2, p3, p4) {
        p13 = p1 - p3;
        p43 = p4 - p3;

        if(abs(p43[0]) < 1e-06 && abs(p43[1]) < 1e-06 && abs(p43[2]) < 1e-06) {
          return undefined;
        }

        p21 = p2 - p1;

        if(abs(p21[0]) < 1e-06 && abs(p21[1]) < 1e-06 && abs(p21[2]) < 1e-06) {
          return undefined;
        }

        d1343 = p13[0] * p43[0] + p13[1] * p43[1] + p13[2] * p43[2];
        d4321 = p43[0] * p21[0] + p43[1] * p21[1] + p43[2] * p21[2];
        d1321 = p13[0] * p21[0] + p13[1] * p21[1] + p13[2] * p21[2];
        d4343 = p43[0] * p43[0] + p43[1] * p43[1] + p43[2] * p43[2];
        d2121 = p21[0] * p21[0] + p21[1] * p21[1] + p21[2] * p21[2];
        denom = d2121 * d4343 - d4321 * d4321;

        if(abs(denom) < 1e-06) {
          return undefined;
        }

        numer = d1343 * d4321 - d1321 * d4343;
        mua = numer / denom;
        mub = (d1343 + d4321 * mua) / d4343;
        pa = p1 + mua * p21;
        pb = p3 + mub * p43;
        var_152611eabe5a5256 = [pa, pb, distance(pa, pb)];
        return var_152611eabe5a5256;
      }

      function closestdistancebetweensegments(p1, p2, p3, p4) {
        pdir = p2 - p1;
        qdir = p4 - p3;
        segdelta = p1 - p3;
        pdp = vectordot(pdir, pdir);
        pdq = vectordot(pdir, qdir);
        qdq = vectordot(qdir, qdir);
        pdw = vectordot(pdir, segdelta);
        qdw = vectordot(qdir, segdelta);
        commondenominator = pdp * qdq - pdq * pdq;
        denominatorp = commondenominator;
        denominatorq = commondenominator;
        scalarp = 0;
        numeratorp = 0;
        scalarq = 0;
        numeratorq = 0;

        if(commondenominator < 1e-08) {
          numeratorp = 0;
          denominatorp = 1;
          numeratorq = qdw;
          denominatorq = qdq;
        } else {
          numeratorp = pdq * qdw - qdq * pdw;
          numeratorq = pdp * qdw - pdq * pdw;

          if(numeratorp < 0) {
            numeratorp = 0;
            numeratorq = qdw;
            denominatorq = qdq;
          } else if(numeratorp > denominatorp) {
            numeratorp = denominatorp;
            numeratorq = qdw + pdq;
            denominatorq = qdq;
          }
        }

        if(numeratorq < 0) {
          numeratorq = 0;

          if(pdw * -1 < 0) {
            numeratorp = 0;
          } else if(pdw * -1 > pdp) {
            numeratorp = denominatorp;
          } else {
            numeratorp = pdw * -1;
            denominatorp = pdp;
          }
        } else if(numeratorq > denominatorq) {
          numeratorq = denominatorq;

          if(pdq - pdw < 0) {
            numeratorp = 0;
          } else if(pdq - pdw > pdp) {
            numeratorp = denominatorp;
          } else {
            numeratorp = pdq - pdw;
            denominatorp = pdp;
          }
        }

        if(abs(numeratorp) > 1e-08) {
          scalarp = numeratorp / denominatorp;
        }

        if(abs(numeratorq) > 1e-08) {
          scalarq = numeratorq / denominatorq;
        }

        pa = p1 + scalarp * pdir;
        pb = p3 + scalarq * qdir;
        var_152611eabe5a5256 = [pa, pb, distance(pa, pb)];
        return var_152611eabe5a5256;
      }

      function is_dead_sentient() {
        return issentient(self) && !isalive(self);
      }

      function hastag(model, tag) {
        if(!isDefined(model) || model == "") {
          return 0;
        }

        if(!isDefined(level.has_tag)) {
          level.has_tag = [];
        }

        key = model + "_" + tag;

        if(isDefined(level.has_tag[key])) {
          return level.has_tag[key];
        }

        partcount = getnumparts(model);

        if(partcount > 0) {
          for(i = 0; i < partcount; i++) {
            partname = getpartname(model, i);

            if(partname == tolower(tag)) {
              level.has_tag[key] = 1;
              return 1;
            }
          }

          level.has_tag[key] = 0;
        }

        return 0;
      }

      function flashbanggettimeleftsec() {
        assert(isDefined(self));
        assert(isDefined(self.flashendtime));
        durationms = self.flashendtime - gettime();

        if(durationms < 0) {
          return 0;
        }

        return durationms * 0.001;
      }

      function flashbangisactive() {
        return flashbanggettimeleftsec() > 0;
      }

      function playsoundontag(alias, tag, ends_on_death, var_e70fce3b333b2ca9, radio_dialog) {
        assert(isDefined(level.fnplaysoundontag));
        [[level.fnplaysoundontag]](alias, tag, ends_on_death, var_e70fce3b333b2ca9, radio_dialog);
      }

      function playsoundonentity(alias, var_e70fce3b333b2ca9) {
        assert(isDefined(level.fnplaysoundonentity));
        [[level.fnplaysoundonentity]](alias, var_e70fce3b333b2ca9);
      }

      function set_movement_speed(desiredspeed) {
        self._blackboard.requestedspeed = desiredspeed;
        self aisetdesiredspeed(desiredspeed);
      }

      function set_cautious_navigation(enabled) {
        self.cautiousnavigation = enabled;
      }

      function doinglongdeath() {
        assert(isai(self));
        return istrue(self.doinglongdeath);
      }

      function is_dead_or_dying(guy) {
        if(!isDefined(guy)) {
          return true;
        }

        if(isai(guy)) {
          return (!isalive(guy) || guy doinglongdeath());
        } else if(issentient(guy)) {
          return !isalive(guy);
        }

        return false;
      }

      function motionwarpwithnotetracks(anime, targetpos, targetangles, notetrackstart, notetrackend, duration, updateanimrate) {
        if(isDefined(notetrackstart)) {
          animstartfrac = getnotetracktimes(anime, notetrackstart)[0];

          if(!isDefined(animstartfrac)) {
            assertmsg("<dev string:xb60>" + notetrackstart + "<dev string:xb76>");
            animstartfrac = 0;
          }
        } else {
          animstartfrac = 0;
        }

        if(isDefined(notetrackend)) {
          animendfrac = getnotetracktimes(anime, notetrackend)[0];

          if(!isDefined(animendfrac)) {
            assertmsg("<dev string:xb9b>" + notetrackend + "<dev string:xb76>");
            animendfrac = 1;
          }
        } else {
          animendfrac = 1;
        }

        motionwarpwithtimes(anime, targetpos, targetangles, animstartfrac, animendfrac, duration, updateanimrate);
      }

      function motionwarpwithtimes(anime, targetpos, targetangles, animstartfrac, animendfrac, duration, updateanimrate = 1) {
        animyawdelta = getangledelta(anime, animstartfrac, animendfrac);
        animtranslationdelta = getmovedelta(anime, animstartfrac, animendfrac);
        animtranslationdelta = rotatevector(animtranslationdelta, (0, targetangles[1] - animyawdelta, 0));
        animstartpos = targetpos - animtranslationdelta;
        animstartyaw = targetangles[1] - animyawdelta;
        animstartangles = (targetangles[0], animstartyaw, targetangles[2]);
        animrate = 1;
        var_620f711ebce0ce12 = length(targetpos - self.origin);

        if(updateanimrate && var_620f711ebce0ce12 > 0) {
          animrate = length(animtranslationdelta) / var_620f711ebce0ce12;
          animrate = clamp(animrate, 0.75, 1.25);
          self aisetanimrate(anime, animrate);
        }

        if(!isDefined(duration)) {
          animlength = getanimlength(anime) / animrate;
          duration = int((animendfrac - animstartfrac) * animlength * 1000);
        }

        if(duration < 50) {
          duration = 50;
        }

        self motionwarpwithanim(animstartpos, animstartangles, targetpos, targetangles, duration);
        return animrate;
      }

      function function_1e0fdc2ddb427044(anime, parentent, tag, localtargetpos, var_82b26273be843388, animstartfrac, animendfrac, duration, updateanimrate) {
        assert(isDefined(anime));
        assert(animstartfrac >= 0);
        assert(animendfrac <= 1);
        assert(isDefined(parentent));
        assert(isDefined(localtargetpos));
        assert(isDefined(var_82b26273be843388));

        if(!isDefined(updateanimrate)) {
          updateanimrate = 1;
        }

        if(isDefined(tag)) {
          linkpos = parentent gettagorigin(tag);
          linkang = parentent gettagangles(tag);
        } else {
          linkpos = parentent.origin;
          linkang = parentent.angles;
          tag = "";
        }

        worldtargetpos = linkpos + rotatevector(localtargetpos, linkang);
        var_6bf8560b5195147d = combineangles(var_82b26273be843388, linkang);
        var_67ba0a3949a64d89 = getangledelta3d(anime, animstartfrac, animendfrac);
        animposdelta = getmovedelta(anime, animstartfrac, animendfrac);
        var_2ab9898ceeb10a7a = invertangles(var_67ba0a3949a64d89);
        var_51e2c41e6b52bf9f = combineangles(var_6bf8560b5195147d, var_2ab9898ceeb10a7a);
        var_1ed21a6d35a9c58e = rotatevector(-1 * animposdelta, var_2ab9898ceeb10a7a);
        var_7401a6e768cf2cb1 = rotatevector(var_1ed21a6d35a9c58e, var_6bf8560b5195147d);
        worldanimstartpos = worldtargetpos + var_7401a6e768cf2cb1;
        var_ff32d80ea94a704a = self.origin - linkpos;
        invlinkang = invertangles(linkang);
        localtargetpos = rotatevector(var_ff32d80ea94a704a, invlinkang);
        var_82b26273be843388 = combineangles(self.angles, invlinkang);
        animrate = 1;
        var_620f711ebce0ce12 = length(worldtargetpos - self.origin);

        if(updateanimrate && var_620f711ebce0ce12 > 0) {
          animrate = length(animposdelta) / var_620f711ebce0ce12;
          animrate = clamp(animrate, 0.5, 2);
          self aisetanimrate(anime, animrate);
        }

        if(!isDefined(duration)) {
          animlength = getanimlength(anime) / animrate;
          duration = int((animendfrac - animstartfrac) * animlength * 1000);
        }

        if(duration < 50) {
          duration = 50;
        }

        self linktomoveoffset(parentent, tag, localtargetpos, var_82b26273be843388);
        self motionwarpwithanim(worldanimstartpos, var_51e2c41e6b52bf9f, worldtargetpos, var_6bf8560b5195147d, duration);
      }

      function waittill_any_ents_or_timeout_return(timeout, ...) {
        assert(isDefined(timeout));

        function_8ae6ad9600816017(flat_args(vararg, varargcount));

        self endon("death");
        ent = spawnStruct();
        i = 0;

        while(i < varargcount) {
          if(isDefined(vararg[i]) && isDefined(vararg[i + 1])) {
            vararg[i] childthread waittill_string(vararg[i + 1], ent);
          }

          i += 2;
        }

        ent childthread timeout_struct(timeout);
        ent waittill("returned", msg);
        ent notify("die");
        return msg;
      }

      function time_has_passed(timestamp, seconds) {
        if(!isDefined(timestamp)) {
          return false;
        }

        if(!isDefined(seconds) || seconds == 0) {
          return true;
        }

        return gettime() - timestamp >= seconds * 1000;
      }

      function reacttolightifpossible(lightorigin) {
        self.lightreaction_lightorigin = lightorigin;
        self.lightreaction_requesttime = gettime();
      }

      function setcovercrouchtype(covertype) {
        switch (covertype) {
          case #"hash_96815ce4f2a3dbc5":
            self.covercrouchtype = "Cover Right Crouch";
            break;
          case #"hash_c9b3133a17a3b2d0":
            self.covercrouchtype = "Cover Left Crouch";
            break;
          case #"hash_3fed0cbd303639eb":
          default:
            self.covercrouchtype = "Cover Crouch";
            break;
        }
      }

      function setcornerstepoutsdisabled(disabled) {
        self.cornerstepoutsdisabled = istrue(disabled);
      }

      function getcornerstepoutsdisabled() {
        return istrue(self.cornerstepoutsdisabled);
      }

      function can_trace_to_ai(start, ai, ignoreentarray, contentoverride) {
        if(isent(self) || isai(self)) {
          ignoregroup = [self, ai];
        } else {
          ignoregroup = [ai];
        }

        if(isDefined(ignoreentarray)) {
          ignoregroup = arraycombine(ignoregroup, ignoreentarray);
        }

        content = contentoverride ?? trace::create_default_contents();
        return cantracetoai(ai, start, ignoreentarray, content);
      }

      function array_removedead_or_dying(array, var_d617f2628e8fa9d3) {
        if(!isDefined(var_d617f2628e8fa9d3)) {
          var_d617f2628e8fa9d3 = 1;
        }

        newarray = [];

        foreach(member in array) {
          if(!isalive(member)) {
            continue;
          }

          if(isai(member) && var_d617f2628e8fa9d3 && (member doinglongdeath() || member ent_flag("death_engaged"))) {
            continue;
          }

          newarray[newarray.size] = member;
        }

        return newarray;
      }

      function disable_pain() {
        assert(isai(self), "<dev string:xbaf>");
        self.a.disablepain = 1;
        self.allowpain = 0;
      }

      function enable_pain() {
        assert(isai(self), "<dev string:xbd4>");
        self.a.disablepain = 0;
        self.allowpain = 1;
      }

      function get_ai_number() {
        if(!isDefined(self.unique_id)) {
          set_ai_number();
        }

        return self.unique_id;
      }

      function set_ai_number() {
        if(!isDefined(level.ai_number)) {
          level.ai_number = 0;
        }

        self.unique_id = "ai" + level.ai_number;
        level.ai_number++;
      }

      function function_15cfbb3a3522e14b() {
        self.persistent_unique_id = "ai" + getpersistentainumber();
        incrementpersistentainumber();
      }

      function ent_flag_wait(msg) {
        assert(isDefined(self), "<dev string:xbf8>");

        while(isDefined(self) && !ent_flag(msg)) {
          self waittill(msg);
        }
      }

      function array_ent_flag_wait(entities, flag) {
        notifystruct = spawnStruct();

        foreach(entity in entities) {
          if(entity ent_flag(flag)) {
            entities = arrayremove(entities, entity);
          }
        }

        array_thread(entities, &array_ent_flag_wait_proc, notifystruct, flag);

        for(i = 0; i < entities.size; i++) {
          notifystruct waittill("notify");
        }
      }

      function array_ent_flag_wait_proc(notifystruct, flag) {
        ent_flag_wait(flag);
        notifystruct notify("notify");
      }

      function ent_flag_wait_vehicle_node(msg) {
        assert(isDefined(self), "<dev string:xc2a>");

        while(isDefined(self) && !ent_flag(msg)) {
          self waittill(msg);
        }
      }

      function ent_flag_wait_any(...) {
        function_bcfbbdb86d349f29(vararg);
      }

      function function_c8aa9ca39ac53bd0(flags) {
        flags = function_5713d46873b29625(flags);

        for(;;) {
          foreach(flagname in flags) {
            ent_flag_wait(flagname);
          }

          flagsetcount = 0;

          foreach(flagname in flags) {
            if(ent_flag(flagname)) {
              flagsetcount++;
            }
          }

          if(flagsetcount == flags.size) {
            break;
          }
        }
      }

      function ent_flag_waitopen_all_array(flags) {
        flags = function_5713d46873b29625(flags);

        for(;;) {
          foreach(flagname in flags) {
            function_adae3a467e19ce3(flagname);
          }

          var_617a1ae12383b183 = 0;

          foreach(flagname in flags) {
            if(!ent_flag(flagname)) {
              var_617a1ae12383b183++;
            }
          }

          if(var_617a1ae12383b183 == flags.size) {
            break;
          }
        }
      }

      function function_bcfbbdb86d349f29(flags) {
        flags = function_5713d46873b29625(flags);
        assert(isDefined(self), "<dev string:xbf8>");

        while(isDefined(self)) {
          foreach(flagname in flags) {
            if(ent_flag(flagname)) {
              return flagname;
            }
          }

          waittill_any_in_array(flags);
        }
      }

      function function_e2baa5896d5756cc(flags) {
        return function_bcfbbdb86d349f29(flags);
      }

      function function_63726cf876765909(flags) {
        flags = function_5713d46873b29625(flags);
        assert(isDefined(self), "<dev string:xbf8>");

        while(isDefined(self)) {
          foreach(flagname in flags) {
            if(!ent_flag(flagname)) {
              return;
            }
          }

          waittill_any_in_array_return(flags);
        }
      }

      function ent_flag_waitopen_or_timeout(flagname, timer) {
        assert(isDefined(self), "<dev string:xbf8>");
        start_time = gettime();

        while(isDefined(self)) {
          if(!ent_flag(flagname)) {
            return flagname;
          }

          if(gettime() >= start_time + timer * 1000) {
            return "timeout";
          }

          ent_wait_for_flag_or_time_elapses(flagname, timer);
        }
      }

      function ent_flag_wait_or_timeout(flagname, timer) {
        assert(isDefined(self), "<dev string:xbf8>");
        start_time = gettime();

        while(isDefined(self)) {
          if(ent_flag(flagname)) {
            return flagname;
          }

          if(gettime() >= start_time + timer * 1000) {
            return "timeout";
          }

          ent_wait_for_flag_or_time_elapses(flagname, timer);
        }
      }

      function ent_wait_for_flag_or_time_elapses(flagname, timer) {
        self endon(flagname);
        wait timer;
      }

      function ent_flag_assert(msg) {
        assert(!ent_flag(msg), "<dev string:x87b>" + msg + "<dev string:xc64>");
      }

      function function_adae3a467e19ce3(...) {
        assert(isDefined(self), "<dev string:xbf8>");

        if(varargcount != vararg.size) {
          return;
        }

        while(isDefined(self)) {
          foreach(varflag in vararg) {
            if(!ent_flag(varflag)) {
              return;
            }
          }

          waittill_any(flat_args(vararg, varargcount));
        }
      }

      function ent_flag_init(message) {
        if(!isDefined(self.ent_flag)) {
          self.ent_flag = [];
          self.ent_flags_lock = [];
        }

        if(level.first_frame == -1) {
          assert(!ent_flag_exist(message), "<dev string:xd5>" + message + "<dev string:xc7f>");
        }

        self.ent_flag[message] = 0;

        self.ent_flags_lock[message] = 0;
      }

      function ent_flag_exist(message) {
        if(isDefined(self.ent_flag) && isDefined(self.ent_flag[message])) {
          return true;
        }

        return false;
      }

      function ent_flag_set_delayed(message, delay) {
        self endon("death");
        wait delay;
        ent_flag_set(message);
      }

      function ent_flag_set(message) {
        assert(isDefined(self), "<dev string:xc8e>");
        assert(isDefined(message), "<dev string:xa0>");

        if(!isDefined(self)) {
          return;
        }

        if(!ent_flag_exist(message)) {
          ent_flag_init(message);
        }

        assert(self.ent_flag[message] == self.ent_flags_lock[message]);
        self.ent_flags_lock[message] = 1;

        self.ent_flag[message] = 1;
        self notify(message);
      }

      function ent_flag_clear(message, remove) {
        assert(isDefined(self), "<dev string:xcc5>");

        if(ent_flag_exist(message)) {
          assert(self.ent_flag[message] == self.ent_flags_lock[message]);
        }

        self.ent_flags_lock[message] = 0;

        if(ent_flag(message)) {
          self.ent_flag[message] = 0;
          self notify(message);
        }

        if(ent_flag_exist(message) && remove) {
          self.ent_flag[message] = undefined;

          self.ent_flags_lock[message] = undefined;
        }
      }

      function ent_flag_clear_delayed(message, delay) {
        wait delay;

        if(isDefined(self)) {
          ent_flag_clear(message);
        }
      }

      function ent_flag(message) {
        assert(isDefined(message), "<dev string:xa0>");
        return ent_flag_exist(message) && self.ent_flag[message];
      }

      function get_linked_structs() {
        array = [];

        if(isDefined(self.script_linkto)) {
          linknames = get_links();

          for(i = 0; i < linknames.size; i++) {
            structs = getStructArray(linknames[i], "script_linkname");

            if(structs.size > 0) {
              array = arraycombine(array, structs);
            }
          }
        }

        return array;
      }

      function ispointinsidecircle(point, circlecenter, circleradius) {
        assert(isvector(point));
        assert(isvector(circlecenter));
        assert(isnumber(circleradius));

        if(squared(point[0] - circlecenter[0]) + squared(point[1] - circlecenter[1]) <= squared(circleradius)) {
          return true;
        }

        return false;
      }

      function requestgamerprofile(var_26cc343082007a73) {
        level endon("game_ended");
        self endon("disconnect");
        frameswaited = 0;
        var_1732b50a7ff34a5f = 1000;

        while(self.var_e8ea309192bf4aa0 && frameswaited < var_1732b50a7ff34a5f) {
          waitframe();
          frameswaited++;
        }

        self.var_e8ea309192bf4aa0 = 1;
        self sendrequestgamerprofilecmd(var_26cc343082007a73);

        while(true) {
          self waittill("luinotifyserver", channel, value);

          if(channel == "gamerprofile_request") {
            self.var_e8ea309192bf4aa0 = 0;
            return value;
          }
        }
      }

      function function_d43a7e1cc86b52b0() {
        sharedsettings = getscriptbundle(%"hash_5d2895ef18b1a537");
        self.pers["sharedGamerProfiles"] = [];

        foreach(gamerprofile in sharedsettings.optionslist) {
          ui::lui_registercallback(gamerprofile.gamerprofileref, &function_e181ee0008ac136f);
        }
      }

      function private function_e181ee0008ac136f(value) {
        if(isDefined(self.pers["sharedGamerProfiles"])) {
          gamerprofile = self.var_b458a7ace288c777;
          self.pers["sharedGamerProfiles"][gamerprofile] = value;
          ui::lui_notify_callback(gamerprofile + "_updated", value, undefined);
        }
      }

      function function_e16c621f95fe3acf(callback, gamerprofilearray) {
        foreach(gamerprofile in gamerprofilearray) {
          ui::lui_registercallback(gamerprofile + "_updated", callback);
        }
      }

      function ismountconfigenabled() {
        var_474e97b8c11833e3 = 1;
        mountconfig = 0;

        if(is_player_gamepad_enabled()) {
          mountconfig = requestgamerprofile("mountButtonConfig");
        } else {
          mountconfig = requestgamerprofile("mountButtonConfigKBM");
        }

        return mountconfig != var_474e97b8c11833e3;
      }

      function function_86834fb1defeac4e() {
        var_1a1c710637f9cd7f = 1;
        toggleTacticalADSConfig = 0;

        if(is_player_gamepad_enabled()) {
          toggleTacticalADSConfig = requestgamerprofile("toggleTacticalADSConfig");
        } else {
          toggleTacticalADSConfig = requestgamerprofile("toggleTacticalADSConfigKBM");
        }

        return toggleTacticalADSConfig != var_1a1c710637f9cd7f;
      }

      function function_c5f97a59345cc2a3(player) {
        if(!isDefined(player)) {
          assertmsg("<dev string:xcfe>");
          return false;
        }

        if(player usinggamepad()) {
          var_bc32b8612e4579a9 = player getcurrentusereloadconfig();
          return (var_bc32b8612e4579a9 == 0 || var_bc32b8612e4579a9 == 3);
        }

        return player getuseholdkbmprofile() == 1;
      }

      function stringtovec3(input) {
        output = (0, 0, 0);
        values = strtok(input, " ");

        if(values.size == 3) {
          output = (float(values[0]), float(values[1]), float(values[2]));
        }

        return output;
      }

      function queue_create(capacity) {
        queue = spawnStruct();
        queue.capacity = capacity;
        queue.array = [];
        queue.front = 0;
        queue.rear = -1;
        return queue;
      }

      function queue_enqueue(queue, object) {
        if(queue.array.size == queue.capacity) {
          assert(0, "<dev string:xd39>");
          return queue;
        }

        if(queue.array.size != queue.capacity && queue.rear + 1 >= queue.capacity) {
          queue.rear = 0;
        } else {
          queue.rear++;
        }

        queue.array[queue.rear] = object;
        return queue;
      }

      function function_6aa5e41ca11dd304(queue) {
        if(queue.array.size == 0) {
          assert(0, "<dev string:xd6d>");
          return queue;
        }

        queue.array[queue.front] = undefined;

        if(queue.array.size > 0 && queue.front + 1 >= queue.capacity) {
          queue.front = 0;
        } else {
          queue.front++;
        }

        if(queue.array.size == 0) {
          queue.front = 0;
          queue.rear = -1;
        }

        return queue;
      }

      function queue_peek(queue) {
        if(queue.array.size == 0) {
          assert(0, "<dev string:xda2>");
          return undefined;
        }

        return queue.array[queue.front];
      }

      function queue_size(queue) {
        return queue.array.size;
      }

      function queue_clear(queue) {
        queue.array = [];
        queue.front = 0;
        queue.rear = -1;
        return queue.array.size;
      }

      function queue_isfull(queue) {
        return queue.array.size == queue.capacity;
      }

      function queue_isempty(queue) {
        return queue.array.size == 0;
      }

      function function_9dac7ef683ed0e52(queue, object) {
        if(!(isDefined(queue) && isDefined(object))) {
          return false;
        }

        tempcount = 0;
        i = queue.front;

        while(tempcount < queue.array.size) {
          if(!isDefined(queue.array[i])) {} else {
            if(queue.array[i] == object) {
              return true;
            }

            if(i + 1 >= queue.capacity) {
              i = 0;
            } else {
              i++;
            }
          }

          tempcount++;
        }

        return false;
      }

      function function_6f5d2e1f1ff70482(milliseconds) {
        return milliseconds * 0.001;
      }

      function function_4b74c15943231980(seconds) {
        return seconds * 1000;
      }

      function single_thread(entity, func, ...) {
        if(!isfunction(func)) {
          assert(0, "<dev string:xdd3>");
          return;
        }

        entity thread[[func]](flat_args(vararg, varargcount));
      }

      function single_func_argarray(entity, func, a_vars) {
        return function_838764575b0dd877(entity, func, a_vars);
      }

      function private function_838764575b0dd877(entity, func, a_vars) {
        a_vars = function_5713d46873b29625(a_vars);
        return entity[[func]](flat_args(a_vars, a_vars.size));
      }

      function function_704b6016a179b4ab(func, ...) {
        if(!isDefined(func)) {
          return undefined;
        }

        return self[[func]](flat_args(vararg, varargcount));
      }

      function vtos(vector) {
        return "(" + int(vector[0]) + " " + int(vector[1]) + " " + int(vector[2]) + ")";
      }

      function create_partition(array, cell_size, optimized) {
        assert(isDefined(array), "<dev string:xe02>");
        assert(isarray(array), "<dev string:xe31>");
        assert(isDefined(cell_size), "<dev string:xe74>");
        assert(isfloat(cell_size) || isint(cell_size), "<dev string:xea7>");
        partition = {
          #coordinate_add: int(150000 / 2 * cell_size), #cell_size: cell_size, #array: []
        };

        if(!optimized || getdvarint(@ "hash_b2f246425a6afd15", 0) > 0) {
          create_partition_fallback(partition, array);
        } else {
          function_aa703f04592736d7(partition, array);
        }

        return partition;
      }

      function private create_partition_fallback(partition, array) {
        foreach(object in array) {
          partition add_to_partition(object);
        }

        return partition;
      }

      function clear_partition() {
        assert(is_partition(), "<dev string:xef3>");
        self.array = [];
      }

      function is_partition() {
        return isDefined(self.cell_size) && isDefined(self.array) && isDefined(self) && isDefined(self.coordinate_add);
      }

      function is_partition_empty() {
        return is_partition() && self.array.size == 0;
      }

      function add_to_partition(object) {
        assert(is_partition(), "<dev string:xf51>");
        assert(isDefined(object), "<dev string:xfb0>");
        assert(isDefined(object.origin), "<dev string:xfe0>");
        [x, y] = function_890559684b1ecb60(object.origin);
        var_d428faa5fdd41d4f = self.array[x];

        if(!isDefined(var_d428faa5fdd41d4f)) {
          self.array[x] = [];
          var_d428faa5fdd41d4f = [];
        }

        var_1e8357156b843e8b = var_d428faa5fdd41d4f[y];

        if(!isDefined(var_1e8357156b843e8b)) {
          self.array[x][y] = [];
          var_bcb2a3b8f4f86415 = 0;
        } else {
          var_bcb2a3b8f4f86415 = var_1e8357156b843e8b.size;
        }

        self.array[x][y][var_bcb2a3b8f4f86415] = object;
      }

      function function_890559684b1ecb60(vector) {
        assert(is_partition(), "<dev string:x1020>");
        assert(isDefined(vector), "<dev string:x108d>");
        assert(isvector(vector), "<dev string:x10cb>");
        cell_size = self.cell_size;
        coordinate_add = self.coordinate_add;
        x = int(vector[0] / cell_size) + coordinate_add;

        if(x < 0) {
          x = 0;
        }

        y = int(vector[1] / cell_size) + coordinate_add;

        if(y < 0) {
          y = 0;
        }

        return [x, y];
      }

      function function_a4a8a4c917fab476(object) {
        assert(is_partition(), "<dev string:x111c>");
        assert(isDefined(object), "<dev string:x1180>");
        assert(isDefined(object.origin), "<dev string:x11b5>");
        [x, y] = function_890559684b1ecb60(object.origin);
        var_d428faa5fdd41d4f = self.array[x];

        if(isDefined(var_d428faa5fdd41d4f) && isDefined(var_d428faa5fdd41d4f[y])) {
          self.array[x][y] = arrayremove(var_d428faa5fdd41d4f[y], object);

          if(self.array[x][y].size == 0) {
            self.array[x][y] = undefined;

            if(self.array[x].size == 0) {
              self.array[x] = undefined;
            }
          }
        }
      }

      function function_27490c47d34088c8(vector) {
        assert(is_partition(), "<dev string:x11fa>");
        assert(isDefined(vector), "<dev string:x1261>");
        assert(isvector(vector), "<dev string:x129a>");
        [x, y] = function_890559684b1ecb60(vector);
        var_d428faa5fdd41d4f = self.array[x];

        if(isDefined(var_d428faa5fdd41d4f)) {
          var_1e8357156b843e8b = var_d428faa5fdd41d4f[y];

          if(isDefined(var_1e8357156b843e8b)) {
            return var_1e8357156b843e8b;
          }
        }

        return [];
      }

      function function_92fef8fe5211a388(vector) {
        assert(is_partition(), "<dev string:x12e5>");
        assert(isDefined(vector), "<dev string:x1356>");
        assert(isvector(vector), "<dev string:x1398>");
        [x, y] = function_890559684b1ecb60(vector);
        adjacent_arrays = [];

        for(x_offset = -1; x_offset <= 1; x_offset++) {
          x_test = x + x_offset;

          if(x_test < 0) {
            continue;
          }

          var_d428faa5fdd41d4f = self.array[x_test];

          if(!isDefined(var_d428faa5fdd41d4f)) {
            continue;
          }

          for(y_offset = -1; y_offset <= 1; y_offset++) {
            y_test = y + y_offset;

            if(y_test < 0) {
              continue;
            }

            var_1e8357156b843e8b = var_d428faa5fdd41d4f[y_test];

            if(!isDefined(var_1e8357156b843e8b)) {
              continue;
            }

            adjacent_arrays[adjacent_arrays.size] = var_1e8357156b843e8b;
          }
        }

        return adjacent_arrays;
      }

      function function_93d8eea713f8560d(vector) {
        assert(is_partition(), "<dev string:x13ed>");
        assert(isDefined(vector), "<dev string:x1465>");
        assert(isvector(vector), "<dev string:x14ae>");
        [x, y] = function_890559684b1ecb60(vector);
        closest_object = undefined;
        closest_distance_squared = undefined;

        for(x_offset = -1; x_offset <= 1; x_offset++) {
          x_test = x + x_offset;

          if(x_test < 0) {
            continue;
          }

          var_d428faa5fdd41d4f = self.array[x_test];

          if(!isDefined(var_d428faa5fdd41d4f)) {
            continue;
          }

          for(y_offset = -1; y_offset <= 1; y_offset++) {
            y_test = y + y_offset;

            if(y_test < 0) {
              continue;
            }

            var_1e8357156b843e8b = var_d428faa5fdd41d4f[y_test];

            if(!isDefined(var_1e8357156b843e8b)) {
              continue;
            }

            foreach(object in var_1e8357156b843e8b) {
              if(!(isDefined(object) && isDefined(object.origin))) {
                continue;
              }

              distance_squared = distancesquared(object.origin, vector);

              if(!isDefined(closest_distance_squared) || distance_squared < closest_distance_squared) {
                closest_distance_squared = distance_squared;
                closest_object = object;
              }
            }
          }
        }

        return closest_object;
      }

      function function_822c5feaca90abc1(origin, radius) {
        assert(is_partition(), "<dev string:x150a>");
        assert(isDefined(origin), "<dev string:x1575>");
        assert(isvector(origin), "<dev string:x15b1>");
        assert(isDefined(radius), "<dev string:x160d>");
        assert(isnumber(radius), "<dev string:x1649>");
        var_25a0fba0031a1a69 = int(ceil(radius / self.cell_size));
        [x, y] = function_890559684b1ecb60(origin);
        radius_squared = radius * radius;
        returned = [];

        for(x_offset = var_25a0fba0031a1a69 * -1; x_offset <= var_25a0fba0031a1a69; x_offset++) {
          x_test = x + x_offset;

          if(x_test < 0) {
            continue;
          }

          x_array = self.array[x_test];

          if(!isDefined(x_array)) {
            continue;
          }

          for(y_offset = var_25a0fba0031a1a69 * -1; y_offset <= var_25a0fba0031a1a69; y_offset++) {
            y_test = y + y_offset;

            if(y_test < 0) {
              continue;
            }

            x_y_array = x_array[y_test];

            if(!isDefined(x_y_array)) {
              continue;
            }

            foreach(object in x_y_array) {
              if(distancesquared(object.origin, origin) < radius_squared) {
                returned[returned.size] = object;
              }
            }
          }
        }

        return returned;
      }

      function registersharedfunc(category, funcname, function, nooverride) {
        if(isstring(funcname)) {
          assertmsg("<dev string:x16a4>" + funcname + "<dev string:x16b1>");
        }

        if(isstring(category)) {
          category = getxhash(category);
        }

        if(nooverride && isDefined(level.sharedfuncs[category][funcname])) {
          return;
        }

        level.sharedfuncs[category][funcname] = function;
      }

      function issharedfuncdefined(category, funcname, shouldassert) {
        if(isstring(category)) {
          category = getxhash(category);
        }

        func = level.sharedfuncs[category][funcname];

        if(!isDefined(func)) {
          if(isstring(funcname)) {
            assertmsg("<dev string:x16a4>" + funcname + "<dev string:x16b1>");
          }

          if(shouldassert) {
            assertmsg(getxhashsourcename(category) + "<dev string:x16cb>" + getxhashsourcename(funcname) + "<dev string:x16d1>");
          }

          return false;
        }

        return true;
      }

      function getsharedfunc(category, funcname) {
        if(isstring(funcname)) {
          assertmsg("<dev string:x16a4>" + funcname + "<dev string:x16b1>");
        }

        if(isstring(category)) {
          category = getxhash(category);
        }

        return level.sharedfuncs[category][funcname];
      }

      function callsharedfunc(category, funcname, ...) {
        if(isstring(category)) {
          category = getxhash(category);
        }

        func = level.sharedfuncs[category][funcname];

        if(isfunction(func)) {
          return self[[func]](flat_args(vararg, varargcount));
        } else if(isbuiltinfunction(func)) {
          return builtin[[func]](flat_args(vararg, varargcount));
        } else if(isbuiltinmethod(func)) {
          return self builtin[[func]](flat_args(vararg, varargcount));
        }

        if(isstring(funcname)) {
          assertmsg("<dev string:x16a4>" + funcname + "<dev string:x16b1>");
        }

        return undefined;
      }

      function waittill_any_ents_return_always(...) {
        return function_543ee02cabf50e25(undefined, flat_args(vararg, varargcount));
      }

      function function_543ee02cabf50e25(timeout, ...) {
        assert(!isDefined(timeout) || timeout > 0);
        assert(varargcount >= 2);
        assert(varargcount % 2 == 0);
        self endon("death");
        context = spawnStruct();
        context.var_281430b4e3937048 = 0;
        context.var_f866e0b41edac98a = arraycontains(vararg, "death");
        i = 0;

        while(i < varargcount) {
          function_bd5f115c5b978f93(vararg[i], vararg[i + 1], context);
          i += 2;
        }

        if(isDefined(timeout)) {
          context childthread timeout_struct(timeout);
        }

        context waittill("returned", msg);
        context notify("die");
        return msg;
      }

      function function_bd5f115c5b978f93(entity, message, context) {
        entity childthread waittill_string(message, context);

        if(!context.var_f866e0b41edac98a) {
          context.var_281430b4e3937048++;
          childthread function_cae7240c7de68a7(entity, context);
        }
      }

      function function_cae7240c7de68a7(entity, context) {
        context endon("die");
        entity waittill("death");
        context.var_281430b4e3937048--;

        if(context.var_281430b4e3937048 == 0) {
          context notify("returned", undefined);
        }
      }

      function waittill_any_return_params(...) {
        return function_61754ffd8e0a4959(0, flat_args(vararg, varargcount));
      }

      function function_61754ffd8e0a4959(timeout, ...) {
        assert(varargcount >= 1);

        if(!isDefined(timeout) || !isnumber(timeout)) {
          assertmsg("<dev string:x16f4>");
        }

        if(!arraycontains(vararg, "death")) {
          self endon("death");
        }

        struct = spawnStruct();

        foreach(varstring in vararg) {
          childthread function_85c91016b4b45c34(varstring, struct);
        }

        if(timeout > 0) {
          childthread function_76c1b3b34ade2ea3(struct, "returned", timeout);
        }

        struct waittill("returned", results_array);
        struct notify("struct_delete");
        return results_array;
      }

      function waittill_any_ents_return_params(...) {
        function_8ae6ad9600816017(flat_args(vararg, varargcount));

        struct = spawnStruct();
        i = 0;

        while(i < varargcount) {
          if(isDefined(vararg[i]) && isDefined(vararg[i + 1])) {
            vararg[i] childthread function_85c91016b4b45c34(vararg[i + 1], struct);
          }

          i += 2;
        }

        struct waittill("returned", results_array);
        struct notify("struct_delete");
        return results_array;
      }

      function function_22939e0bc589604e(timeout, ...) {
        if(!isDefined(timeout) || !isnumber(timeout)) {
          assertmsg("<dev string:x16f4>");
        }

        function_8ae6ad9600816017(flat_args(vararg, varargcount));

        if(!arraycontains(vararg, "death")) {
          self endon("death");
        }

        struct = spawnStruct();
        i = 0;

        while(i < varargcount) {
          if(isDefined(vararg[i]) && isDefined(vararg[i + 1])) {
            vararg[i] childthread function_85c91016b4b45c34(vararg[i + 1], struct);
          }

          i += 2;
        }

        if(timeout > 0) {
          level childthread function_76c1b3b34ade2ea3(struct, "returned", timeout);
        }

        struct waittill("returned", results_array);
        struct notify("struct_delete");
        return results_array;
      }

      function private function_76c1b3b34ade2ea3(ent, msg, timeout) {
        self endon(msg);
        wait timeout;
        results = [];
        results["ent"] = undefined;
        results["message"] = "timeout";
        ent notify("returned", results);
      }

      function private function_85c91016b4b45c34(msg, struct) {
        if(msg != "death") {
          self endon("death");
        }

        struct endon("struct_delete");
        self waittill(msg, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10);
        result = [];

        if(isDefined(param1)) {
          result[0] = param1;
        }

        if(isDefined(param2)) {
          result[1] = param2;
        }

        if(isDefined(param3)) {
          result[2] = param3;
        }

        if(isDefined(param4)) {
          result[3] = param4;
        }

        if(isDefined(param5)) {
          result[4] = param5;
        }

        if(isDefined(param6)) {
          result[5] = param6;
        }

        if(isDefined(param7)) {
          result[6] = param7;
        }

        if(isDefined(param8)) {
          result[7] = param8;
        }

        if(isDefined(param9)) {
          result[8] = param9;
        }

        if(isDefined(param10)) {
          result[9] = param10;
        }

        result["ent"] = self;
        result["message"] = msg;
        struct notify("returned", result);
      }

      function string_to_bool(the_string) {
        retval = undefined;

        switch (the_string) {
          case #"hash_31100fbc01bd387c":
          case #"hash_8328fb6e4f43ba45":
            retval = 1;
            break;
          case #"hash_311010bc01bd3a0f":
          case #"hash_a9152f56f0c74738":
            retval = 0;
            break;
          default:
            assertmsg("<dev string:x1748>");
            break;
        }

        return retval;
      }

      function get_int_or_0(value) {
        if(!isDefined(value)) {
          return 0;
        }

        return int(value);
      }

      function function_dc226e1c2f06ea0b(bundlename) {
        if(!isxhashasset(bundlename)) {
          bundlename = getxhashasset(tolower(bundlename));
        }

        if(!isDefined(level.globalbundles)) {
          level.globalbundles = [];
        }

        if(!isDefined(level.globalbundles[bundlename])) {
          level.globalbundles[bundlename] = [];
          level.globalbundles[bundlename][0] = getscriptbundle(bundlename);

          if(isDefined(level.globalbundles[bundlename][0])) {
            assert(!isDefined(level.globalbundles[bundlename][0].var_5d185975a2bb0b35));
            level.globalbundles[bundlename][0].var_5d185975a2bb0b35 = bundlename;
            level.globalbundles[bundlename][1] = 0;
          } else {
            level.globalbundles[bundlename] = undefined;
            return undefined;
          }
        }

        level.globalbundles[bundlename][1] += 1;
        return level.globalbundles[bundlename][0];
      }

      function function_cacdd05a312a4bf0(bundlestruct) {
        if(!isDefined(bundlestruct)) {
          return;
        }

        if(!isDefined(level.globalbundles)) {
          return;
        }

        assert(isDefined(bundlestruct.var_5d185975a2bb0b35));
        bundlename = bundlestruct.var_5d185975a2bb0b35;

        if(!isDefined(level.globalbundles[bundlename])) {
          return;
        }

        level.globalbundles[bundlename][1] -= 1;

        if(level.globalbundles[bundlename][1] <= 0) {
          level.globalbundles[bundlename] = undefined;
        }
      }

      function function_123ab1b2aa3f4ff9(object) {
        queue = self;
        queueitem = spawnStruct();
        queueitem.object = object;

        if(isDefined(queue.tail)) {
          queue.tail.next = queueitem;
          queue.tail = queueitem;
          return;
        }

        queue.head = queueitem;
        queue.tail = queueitem;
      }

      function function_15c8b2fac9e406c1() {
        queue = self;

        while(isDefined(queue.head)) {
          object = queue.head.object;
          queue.head = queue.head.next;

          if(!isDefined(queue.head)) {
            queue.tail = undefined;
          }

          var_7237854e3be197ca = object;

          if(isDefined(var_7237854e3be197ca)) {
            return var_7237854e3be197ca;
          }
        }
      }

      function function_4113d68e8e0a401f(array) {
        assert(isDefined(self.origin) && isDefined(self.angles));
        closest_dot = -1;
        closest_object = undefined;

        if(isPlayer(self)) {
          forward = anglesToForward(self getplayerangles());

          foreach(object in array) {
            dir = vectorNormalize(object.origin - self getEye());
            dot = vectordot(forward, dir);

            if(dot >= closest_dot) {
              closest_dot = dot;
              closest_object = object;
            }
          }
        } else {
          forward = anglesToForward(self.angles);

          foreach(object in array) {
            dir = vectorNormalize(object.origin - self.origin);
            dot = vectordot(forward, dir);

            if(dot >= closest_dot) {
              closest_dot = dot;
              closest_object = object;
            }
          }
        }

        return closest_object;
      }

      function function_fb5b19421bb35e50(object, string) {
        object waittill(string);

        if(isDefined(self)) {
          self delete();
        }
      }

      function function_95db22f620602461(dvar, func, args) {
        if(getdvarint(dvar)) {
          if(isDefined(args)) {
            if(!isarray(args)) {
              args = [args];
            }

            return single_func_argarray(self, func, args);
          }

          return self[[func]]();
        }
      }

      function function_bef70f17de325bdb(dvar, func, args) {
        if(!isdvardefined(dvar) || !getdvarint(dvar)) {
          if(isDefined(args)) {
            if(!isarray(args)) {
              args = [args];
            }

            return single_func_argarray(self, func, args);
          }

          return self[[func]]();
        }
      }

      function function_9f84aa016f6d1297(dvar, value, func, args) {
        if(isDefined(value)) {
          if(getdvarint(dvar) == value) {
            if(isDefined(args)) {
              if(!isarray(args)) {
                args = [args];
              }

              return single_func_argarray(self, func, args);
            } else {
              return self[[func]]();
            }
          }

          return;
        }

        if(!isdvardefined(dvar)) {
          if(isDefined(args)) {
            if(!isarray(args)) {
              args = [args];
            }

            return single_func_argarray(self, func, args);
          }

          return self[[func]]();
        }
      }

      function function_445ecc08c54dd330(dvar, value, func, args) {
        if(isdvardefined(dvar) && getdvarint(dvar) < value) {
          if(isDefined(args)) {
            if(!isarray(args)) {
              args = [args];
            }

            return single_func_argarray(self, func, args);
          }

          return self[[func]]();
        }
      }

      function function_55dfc08395ae18d3(dvar, value, func, args) {
        if(isdvardefined(dvar) && getdvarint(dvar) > value) {
          if(isDefined(args)) {
            if(!isarray(args)) {
              args = [args];
            }

            return single_func_argarray(self, func, args);
          }

          return self[[func]]();
        }
      }

      function function_edc4cc03e9e60b3e(dvar_name, default_value, var_704edfac805ac331) {
        return function_aebf0fdab30eb618(getdvarint(dvar_name, default_value), default_value, var_704edfac805ac331);
      }

      function function_48f723fdc612ec65(dvar_name, default_value, var_704edfac805ac331) {
        return function_aebf0fdab30eb618(getdvarfloat(dvar_name, default_value), default_value, var_704edfac805ac331);
      }

      function function_5eb6ca497c84f302(dvar_name, default_value, var_704edfac805ac331) {
        return function_aebf0fdab30eb618(getdvarvector(dvar_name, default_value), default_value, var_704edfac805ac331);
      }

      function function_49a778e73bbb0f58(dvar_name, default_value, var_704edfac805ac331) {
        return function_aebf0fdab30eb618(getDvar(dvar_name, default_value), default_value, var_704edfac805ac331);
      }

      function private function_aebf0fdab30eb618(dvar_value, default_value, var_704edfac805ac331) {
        assert(isDefined(default_value));
        return_value = default_value;

        if(isDefined(dvar_value) && dvar_value != default_value) {
          return_value = dvar_value;
        } else {
          return_value = isDefined(var_704edfac805ac331) ? var_704edfac805ac331 : default_value;
        }

        return return_value;
      }

      function function_dc36010b2b55e552(center, radius, ang_perc, color = (1, 1, 1), alpha = 1, depthtest = 1, duration = 1) {
        if(!(isDefined(radius) && isDefined(center) && isDefined(ang_perc))) {
          return;
        }

        thread draw_circle(center, radius, color, alpha, depthtest, duration);
        start = function_41c078929be6e7fe(center, radius, ang_perc);
        end = function_41c078929be6e7fe(center, radius, ang_perc + 180);

        line(start, end, color, alpha, depthtest, duration);

        start = function_41c078929be6e7fe(center, radius, ang_perc * -1);
        end = function_41c078929be6e7fe(center, radius, ang_perc * -1 + 180);

        line(start, end, color, alpha, depthtest, duration);
      }

      function private function_41c078929be6e7fe(center, radius, ang_perc) {
        x = radius * cos(ang_perc) + center[0];
        y = radius * sin(ang_perc) + center[1];
        z = center[2];
        return (x, y, z);
      }

      function function_64003742d8f5c781(weapon) {
        if(isweapon(weapon)) {
          return weapon;
        }

        if(isstring(weapon)) {
          return (level.var_d53b344e2aeda06f[weapon] ?? function_c8852ed0b886c6bd(weapon));
        }

        if(isxhashasset(weapon)) {
          return (level.var_8a2f4f6d7534396a[weapon] ?? function_ea577e55c7daf2b2(weapon));
        }

        assert(isDefined(weapon), "<dev string:x1775>");
        return undefined;
      }

      function private function_c8852ed0b886c6bd(var_e3ee05786f18e2c3) {
        var_3c04a2b892cbba04 = level.sharedfuncs[#"weapons"][#"hash_591d84c60e3b7802"];

        if(!var_3c04a2b892cbba04) {
          assertmsg("<dev string:x17aa>");
          return undefined;
        }

        var_bea6ab4cd5df553c = level.weaponmapdata[var_e3ee05786f18e2c3].assetname ?? var_e3ee05786f18e2c3;

        if(issubstr(var_bea6ab4cd5df553c, "+")) {
          assertmsg("<dev string:x180a>");
          return undefined;
        }

        weaponobj = [[var_3c04a2b892cbba04]](var_bea6ab4cd5df553c);

        if(!isDefined(level.var_d53b344e2aeda06f)) {
          level.var_d53b344e2aeda06f = [];
        }

        level.var_d53b344e2aeda06f[var_e3ee05786f18e2c3] = weaponobj;

        if(!isDefined(level.weaponnone)) {
          level.weaponnone = makeweapon("<dev string:x32d>");
        }

        assert(weaponobj != level.weaponnone || var_e3ee05786f18e2c3 == "<dev string:x18ff>", "<dev string:x1907>" + var_e3ee05786f18e2c3);

        return weaponobj;
      }

      function private function_ea577e55c7daf2b2(var_8ef80df233884b8e) {
        var_3c04a2b892cbba04 = level.sharedfuncs[#"weapons"][#"hash_e2adafa41f9e4a45"];

        if(!var_3c04a2b892cbba04) {
          assertmsg("<dev string:x192c>");
          return undefined;
        }

        if(!isDefined(level.weaponnone)) {
          level.weaponnone = makeweapon("");
        }

        weaponobj = function_7508ecd9410f7dfa(var_8ef80df233884b8e, var_3c04a2b892cbba04);

        if(weaponobj == level.weaponnone) {
          weaponobj = function_7508ecd9410f7dfa(hashcat(var_8ef80df233884b8e, "_mp"), var_3c04a2b892cbba04);

          if(weaponobj == level.weaponnone) {
            weaponobj = function_7508ecd9410f7dfa(hashcat(var_8ef80df233884b8e, "_sp"), var_3c04a2b892cbba04);
          }
        }

        if(!isDefined(level.var_8a2f4f6d7534396a)) {
          level.var_8a2f4f6d7534396a = [];
        }

        level.var_8a2f4f6d7534396a[var_8ef80df233884b8e] = weaponobj;
        assert(weaponobj != level.weaponnone || var_8ef80df233884b8e == % "none", "<dev string:x1907>" + getxhashsourcename(var_8ef80df233884b8e));
        return weaponobj;
      }

      function private function_7508ecd9410f7dfa(var_8ef80df233884b8e, var_3c04a2b892cbba04) {
        if(weaponexists(var_8ef80df233884b8e)) {
          return [[var_3c04a2b892cbba04]](var_8ef80df233884b8e);
        }

        return level.weaponnone;
      }

      function function_5362640c80ccf9c5(storage_int, flag_index) {
        assert(flag_index >= 0 && flag_index <= 30, "<dev string:x198f>");
        storage_int |= 1 << flag_index;
        return storage_int;
      }

      function function_e98a690ce7443031(storage_int, flag_index) {
        assert(flag_index >= 0 && flag_index <= 30, "<dev string:x198f>");
        flag = (storage_int & 1 << flag_index) > 0 ? 1 : 0;
        return flag;
      }

      function function_911d2d3c6d773726(storage_int, flag_index) {
        assert(flag_index >= 0 && flag_index <= 30, "<dev string:x198f>");
        storage_int &= ~(1 << flag_index);
        return storage_int;
      }

      function function_9ab002313e87d84c(flag_index) {
        assert(isint(flag_index), "<dev string:x19b1>");
        var_4f583ee171a9fb16 = flag_index % 30 == 0;

        if(var_4f583ee171a9fb16) {
          storageindex = flag_index / 30;
        } else {
          storageindex = int(flag_index / 30);
        }

        return storageindex;
      }

      function function_c73b75a176f26cf6(flag_index) {
        assert(isint(flag_index), "<dev string:x19b1>");
        storageindex = function_9ab002313e87d84c(flag_index);

        if(!isDefined(storageindex)) {
          return undefined;
        }

        index = flag_index - 30 * storageindex;
        return int(index);
      }

      function wait_frames(framecount) {
        frames = framecount;

        while(frames > 0) {
          frames -= 1;
          waitframe();
        }
      }

      function always_false(...) {
        return false;
      }

      function always_true(...) {
        return true;
      }

      function function_645a77750f1850b5() {
        assert(flag("<dev string:x19d4>"), "<dev string:x19f4>");
        var_ef057d6ea73e1a53 = level.sharedfuncs[#"engine"][#"hash_ff8355771dcc2c20"];

        if(!isDefined(var_ef057d6ea73e1a53)) {
          assert(!issp(), "<dev string:x1a53>");
          level.var_f8f564d5b2b09e05 = 0;
          return 0;
        }

        level.var_f8f564d5b2b09e05 = builtin[[var_ef057d6ea73e1a53]]();
        return level.var_f8f564d5b2b09e05;
      }

      function private function_8ae6ad9600816017(...) {
        assert(varargcount % 2 == 0);
        assert(varargcount == vararg.size);
        i = 0;

        while(i < varargcount) {
          if(!isent(vararg[i]) && !isstruct(vararg[i])) {
            assertmsg("<dev string:x1a7b>" + i + 1 + "<dev string:x1a86>" + i / 2 + 1 + "<dev string:x1a8f>");
          }

          if(!isstring(vararg[i + 1])) {
            assertmsg("<dev string:x1a7b>" + i + 2 + "<dev string:x1ac1>" + (i + 1) / 2 + "<dev string:x1acd>");
          }

          i += 2;
        }
      }

      function function_b720276ae54a4d70(value, message) {
        if(!isDefined(value)) {
          assertmsg(message);
        }

        return value;
      }