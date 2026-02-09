/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: common_scripts\utility.gsc
***************************************************/

noself_func(func, parm1, parm2, parm3, parm4) {
  if(!isDefined(level.func)) {
    return;
  }
  if(!isDefined(level.func[func])) {
    return;
  }

  if(!isDefined(parm1)) {
    call[[level.func[func]]]();
    return;
  }

  if(!isDefined(parm2)) {
    call[[level.func[func]]](parm1);
    return;
  }
  if(!isDefined(parm3)) {
    call[[level.func[func]]](parm1, parm2);
    return;
  }
  if(!isDefined(parm4)) {
    call[[level.func[func]]](parm1, parm2, parm3);
    return;
  }

  call[[level.func[func]]](parm1, parm2, parm3, parm4);
}

self_func(func, parm1, parm2, parm3, parm4) {
  if(!isDefined(level.func[func])) {
    return;
  }

  if(!isDefined(parm1)) {
    self call[[level.func[func]]]();
    return;
  }

  if(!isDefined(parm2)) {
    self call[[level.func[func]]](parm1);
    return;
  }
  if(!isDefined(parm3)) {
    self call[[level.func[func]]](parm1, parm2);
    return;
  }
  if(!isDefined(parm4)) {
    self call[[level.func[func]]](parm1, parm2, parm3);
    return;
  }

  self call[[level.func[func]]](parm1, parm2, parm3, parm4);
}

randomvector(num) {
  return (randomfloat(num) - num * 0.5, randomfloat(num) - num * 0.5, randomfloat(num) - num * 0.5);
}

randomvectorrange(num_min, num_max) {
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

randomvectorincone(coneDirection, coneAngleDegrees) {
  phi = RandomFloat(coneAngleDegrees);
  theta = RandomFloat(360);

  sinPhi = sin(phi);
  cosPhi = cos(phi);
  sinTheta = sin(theta);
  cosTheta = cos(theta);

  v = (cosPhi, cosTheta * sinPhi, sinTheta * sinPhi);

  return RotateVector(v, VectorToAngles(coneDirection));
}

sign(x) {
  if(x >= 0) {
    return 1;
  }
  return -1;
}

mod(dividend, divisor) {
  q = Int(dividend / divisor);
  if(dividend * divisor < 0) q -= 1;
  return dividend - (q * divisor);
}

toString(num) {
  return ("" + num);
}

track(spot_to_track) {
  if(isDefined(self.current_target)) {
    if(spot_to_track == self.current_target) {
      return;
    }
  }
  self.current_target = spot_to_track;
}

get_enemy_team(team) {
  assertEx(team != "neutral", "Team must be allies or axis");

  teams = [];
  teams["axis"] = "allies";
  teams["allies"] = "axis";

  return teams[team];
}

clear_exception(type) {
  assert(isDefined(self.exception[type]));
  self.exception[type] = anim.defaultException;
}

set_exception(type, func) {
  assert(isDefined(self.exception[type]));
  self.exception[type] = func;
}

set_all_exceptions(exceptionFunc) {
  keys = getArrayKeys(self.exception);
  for(i = 0; i < keys.size; i++) {
    self.exception[keys[i]] = exceptionFunc;
  }
}

cointoss() {
  return randomint(100) >= 50;
}

choose_from_weighted_array(values, weights) {
  assert(values.size == weights.size);

  randomval = randomint(weights[weights.size - 1] + 1);

  for(i = 0; i < weights.size; i++) {
    if(randomval <= weights[i]) {
      return values[i];
    }
  }
}

get_cumulative_weights(weights) {
  cumulative_weights = [];

  sum = 0;
  for(i = 0; i < weights.size; i++) {
    sum += weights[i];
    cumulative_weights[i] = sum;
  }

  return cumulative_weights;
}

waittill_string(msg, ent) {
  if(msg != "death") {
    self endon("death");
  }

  ent endon("die");
  self waittill(msg);
  ent notify("returned", msg);
}

waittill_string_parms(msg, ent) {
  if(msg != "death") {
    self endon("death");
  }

  ent endon("die");
  self waittill(msg, parm1, parm2, parm3, parm4, parm5, parm6, parm7, parm8, parm9, parm10);

  result = [];
  result[0] = msg;
  if(isDefined(parm1)) {
    result[1] = parm1;
  }
  if(isDefined(parm2)) {
    result[2] = parm2;
  }
  if(isDefined(parm3)) {
    result[3] = parm3;
  }
  if(isDefined(parm4)) {
    result[4] = parm4;
  }
  if(isDefined(parm5)) {
    result[5] = parm5;
  }
  if(isDefined(parm6)) {
    result[6] = parm6;
  }
  if(isDefined(parm7)) {
    result[7] = parm7;
  }
  if(isDefined(parm8)) {
    result[8] = parm8;
  }
  if(isDefined(parm9)) {
    result[9] = parm9;
  }
  if(isDefined(parm10)) {
    result[10] = parm10;
  }

  ent notify("returned", result);
}

waittill_string_no_endon_death(msg, ent) {
  ent endon("die");
  self waittill(msg);
  ent notify("returned", msg);
}

waittill_multiple(string1, string2, string3, string4, string5) {
  self endon("death");
  ent = spawnStruct();
  ent.threads = 0;

  if(isDefined(string1)) {
    self childthread waittill_string(string1, ent);
    ent.threads++;
  }
  if(isDefined(string2)) {
    self childthread waittill_string(string2, ent);
    ent.threads++;
  }
  if(isDefined(string3)) {
    self childthread waittill_string(string3, ent);
    ent.threads++;
  }
  if(isDefined(string4)) {
    self childthread waittill_string(string4, ent);
    ent.threads++;
  }
  if(isDefined(string5)) {
    self childthread waittill_string(string5, ent);
    ent.threads++;
  }

  while(ent.threads) {
    ent waittill("returned");
    ent.threads--;
  }

  ent notify("die");
}

waittill_multiple_ents(ent1, string1, ent2, string2, ent3, string3, ent4, string4) {
  self endon("death");
  ent = spawnStruct();
  ent.threads = 0;

  if(isDefined(ent1)) {
    assert(isDefined(string1));
    ent1 childthread waittill_string(string1, ent);
    ent.threads++;
  }
  if(isDefined(ent2)) {
    assert(isDefined(string2));
    ent2 childthread waittill_string(string2, ent);
    ent.threads++;
  }
  if(isDefined(ent3)) {
    assert(isDefined(string3));
    ent3 childthread waittill_string(string3, ent);
    ent.threads++;
  }
  if(isDefined(ent4)) {
    assert(isDefined(string4));
    ent4 childthread waittill_string(string4, ent);
    ent.threads++;
  }

  while(ent.threads) {
    ent waittill("returned");
    ent.threads--;
  }

  ent notify("die");
}

waittill_any_return(string1, string2, string3, string4, string5, string6, string7) {
  if((!isDefined(string1) || string1 != "death") &&
    (!isDefined(string2) || string2 != "death") &&
    (!isDefined(string3) || string3 != "death") &&
    (!isDefined(string4) || string4 != "death") &&
    (!isDefined(string5) || string5 != "death") &&
    (!isDefined(string6) || string6 != "death") &&
    (!isDefined(string7) || string7 != "death"))
    self endon("death");

  ent = spawnStruct();

  if(isDefined(string1)) {
    self childthread waittill_string(string1, ent);
  }

  if(isDefined(string2)) {
    self childthread waittill_string(string2, ent);
  }

  if(isDefined(string3)) {
    self childthread waittill_string(string3, ent);
  }

  if(isDefined(string4)) {
    self childthread waittill_string(string4, ent);
  }

  if(isDefined(string5)) {
    self childthread waittill_string(string5, ent);
  }

  if(isDefined(string6)) {
    self childthread waittill_string(string6, ent);
  }

  if(isDefined(string7)) {
    self childthread waittill_string(string7, ent);
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_return_parms(string1, string2, string3, string4, string5, string6, string7, string8) {
  if((!isDefined(string1) || string1 != "death") &&
    (!isDefined(string2) || string2 != "death") &&
    (!isDefined(string3) || string3 != "death") &&
    (!isDefined(string4) || string4 != "death") &&
    (!isDefined(string5) || string5 != "death") &&
    (!isDefined(string6) || string6 != "death") &&
    (!isDefined(string7) || string7 != "death") &&
    (!isDefined(string8) || string8 != "death"))
    self endon("death");

  ent = spawnStruct();

  if(isDefined(string1)) {
    self childthread waittill_string_parms(string1, ent);
  }

  if(isDefined(string2)) {
    self childthread waittill_string_parms(string2, ent);
  }

  if(isDefined(string3)) {
    self childthread waittill_string_parms(string3, ent);
  }

  if(isDefined(string4)) {
    self childthread waittill_string_parms(string4, ent);
  }

  if(isDefined(string5)) {
    self childthread waittill_string_parms(string5, ent);
  }

  if(isDefined(string6)) {
    self childthread waittill_string_parms(string6, ent);
  }

  if(isDefined(string7)) {
    self childthread waittill_string_parms(string7, ent);
  }

  if(isDefined(string8)) {
    self childthread waittill_string_parms(string8, ent);
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_return_no_endon_death(string1, string2, string3, string4, string5, string6) {
  ent = spawnStruct();

  if(isDefined(string1)) {
    self childthread waittill_string_no_endon_death(string1, ent);
  }

  if(isDefined(string2)) {
    self childthread waittill_string_no_endon_death(string2, ent);
  }

  if(isDefined(string3)) {
    self childthread waittill_string_no_endon_death(string3, ent);
  }

  if(isDefined(string4)) {
    self childthread waittill_string_no_endon_death(string4, ent);
  }

  if(isDefined(string5)) {
    self childthread waittill_string_no_endon_death(string5, ent);
  }

  if(isDefined(string6)) {
    self childthread waittill_string_no_endon_death(string6, ent);
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_in_array_return(string_array) {
  ent = spawnStruct();
  hasDeath = false;
  foreach(string in string_array) {
    self childthread waittill_string(string, ent);

    if(string == "death") {
      hasDeath = true;
    }
  }
  if(!hasDeath) {
    self endon("death");
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_in_array_return_no_endon_death(string_array) {
  ent = spawnStruct();
  foreach(string in string_array) {
    self childthread waittill_string_no_endon_death(string, ent);
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_in_array_or_timeout(string_array, timeOut) {
  ent = spawnStruct();
  hasDeath = false;
  foreach(string in string_array) {
    self childthread waittill_string(string, ent);

    if(string == "death") {
      hasDeath = true;
    }
  }
  if(!hasDeath) {
    self endon("death");
  }

  ent childthread _timeout(timeOut);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_in_array_or_timeout_no_endon_death(string_array, timeOut) {
  ent = spawnStruct();
  foreach(string in string_array) {
    self childthread waittill_string_no_endon_death(string, ent);
  }

  ent thread _timeout(timeOut);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_timeout(timeOut, string1, string2, string3, string4, string5, string6) {
  if((!isDefined(string1) || string1 != "death") &&
    (!isDefined(string2) || string2 != "death") &&
    (!isDefined(string3) || string3 != "death") &&
    (!isDefined(string4) || string4 != "death") &&
    (!isDefined(string5) || string5 != "death") &&
    (!isDefined(string6) || string6 != "death"))
    self endon("death");

  ent = spawnStruct();

  if(isDefined(string1)) {
    self childthread waittill_string(string1, ent);
  }

  if(isDefined(string2)) {
    self childthread waittill_string(string2, ent);
  }

  if(isDefined(string3)) {
    self childthread waittill_string(string3, ent);
  }

  if(isDefined(string4)) {
    self childthread waittill_string(string4, ent);
  }

  if(isDefined(string5)) {
    self childthread waittill_string(string5, ent);
  }

  if(isDefined(string6)) {
    self childthread waittill_string(string6, ent);
  }

  ent childthread _timeout(timeOut);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

_timeout(delay) {
  self endon("die");

  wait(delay);
  self notify("returned", "timeout");
}

waittill_any_timeout_no_endon_death(timeOut, string1, string2, string3, string4, string5) {
  ent = spawnStruct();

  if(isDefined(string1)) {
    self childthread waittill_string_no_endon_death(string1, ent);
  }

  if(isDefined(string2)) {
    self childthread waittill_string_no_endon_death(string2, ent);
  }

  if(isDefined(string3)) {
    self childthread waittill_string_no_endon_death(string3, ent);
  }

  if(isDefined(string4)) {
    self childthread waittill_string_no_endon_death(string4, ent);
  }

  if(isDefined(string5)) {
    self childthread waittill_string_no_endon_death(string5, ent);
  }

  ent childthread _timeout(timeOut);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any(string1, string2, string3, string4, string5, string6, string7, string8) {
  assert(isDefined(string1));

  if(isDefined(string2)) {
    self endon(string2);
  }

  if(isDefined(string3)) {
    self endon(string3);
  }

  if(isDefined(string4)) {
    self endon(string4);
  }

  if(isDefined(string5)) {
    self endon(string5);
  }

  if(isDefined(string6)) {
    self endon(string6);
  }

  if(isDefined(string7)) {
    self endon(string7);
  }

  if(isDefined(string8)) {
    self endon(string8);
  }

  self waittill(string1);
}

waittill_any_ents(ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7) {
  assert(isDefined(ent1));
  assert(isDefined(string1));

  if((isDefined(ent2)) && (isDefined(string2))) {
    ent2 endon(string2);
  }

  if((isDefined(ent3)) && (isDefined(string3))) {
    ent3 endon(string3);
  }

  if((isDefined(ent4)) && (isDefined(string4))) {
    ent4 endon(string4);
  }

  if((isDefined(ent5)) && (isDefined(string5))) {
    ent5 endon(string5);
  }

  if((isDefined(ent6)) && (isDefined(string6))) {
    ent6 endon(string6);
  }

  if((isDefined(ent7)) && (isDefined(string7))) {
    ent7 endon(string7);
  }

  ent1 waittill(string1);
}

isFlashed() {
  time = gettime();

  if(isDefined(self.flashEndTime) && (time < self.flashEndTime)) {
    return true;
  }

  if(isDefined(self.concussionEndTime) && (time < self.concussionEndTime)) {
    return true;
  }

  return false;
}

flag_exist(message) {
  return isDefined(level.flag[message]);
}

flag(message) {
  assertEx(isDefined(message), "Tried to check flag but the flag was not defined.");
  assertEx(isDefined(level.flag[message]), "Tried to check flag " + message + " but the flag was not initialized.");

  return level.flag[message];
}

init_flags() {
  level.flag = [];
  level.flags_lock = [];
  level.generic_index = 0;

  if(!isDefined(level.sp_stat_tracking_func)) {
    level.sp_stat_tracking_func = ::empty_init_func;
  }

  level.flag_struct = spawnStruct();
  level.flag_struct assign_unique_id();
}

flag_init(message) {
  if(!isDefined(level.flag)) {
    init_flags();
  }

  if(isDefined(level.first_frame) && level.first_frame == -1) {
    assertEx(!isDefined(level.flag[message]), "Attempt to reinitialize existing message: " + message);
  }

  level.flag[message] = false;

  if(!isDefined(level.trigger_flags)) {
    init_trigger_flags();
    level.trigger_flags[message] = [];
  } else {
    if(!isDefined(level.trigger_flags[message])) {}
    level.trigger_flags[message] = [];
  }

  if(issuffix(message, "aa_")) {
    thread[[level.sp_stat_tracking_func]](message);
  }
}

empty_init_func(empty) {}

issuffix(msg, suffix) {
  if(suffix.size > msg.size) {
    return false;
  }

  for(i = 0; i < suffix.size; i++) {
    if(msg[i] != suffix[i]) {
      return false;
    }
  }
  return true;
}

flag_set(message, setter) {
  assertEx(isDefined(level.flag[message]), "Attempt to set a flag before calling flag_init: " + message);

  level.flag[message] = true;
  set_trigger_flag_permissions(message);
  if(isDefined(setter)) {
    level notify(message, setter);
  } else {
    level notify(message);
  }
}

assign_unique_id() {
  self.unique_id = "generic" + level.generic_index;
  level.generic_index++;
}

flag_wait(msg) {
  other = undefined;
  while(!flag(msg)) {
    other = undefined;
    level waittill(msg, other);
  }
  if(isDefined(other)) {
    return other;
  }
}

flag_clear(message) {
  assertEx(isDefined(level.flag[message]), "Attempt to set a flag before calling flag_init: " + message);

  if(!flag(message)) {
    return;
  }

  level.flag[message] = false;

  set_trigger_flag_permissions(message);
  level notify(message);
}

flag_waitopen(msg) {
  while(flag(msg)) {
    level waittill(msg);
  }
}

waittill_either(msg1, msg2) {
  self endon(msg1);
  self waittill(msg2);
}

array_thread(entities, process, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(!isDefined(var1)) {
    foreach(ent in entities) {
      ent thread[[process]]();
    }
    return;
  }

  if(!isDefined(var2)) {
    foreach(ent in entities) {
      ent thread[[process]](var1);
    }
    return;
  }

  if(!isDefined(var3)) {
    foreach(ent in entities) {
      ent thread[[process]](var1, var2);
    }
    return;
  }

  if(!isDefined(var4)) {
    foreach(ent in entities) {
      ent thread[[process]](var1, var2, var3);
    }
    return;
  }

  if(!isDefined(var5)) {
    foreach(ent in entities) {
      ent thread[[process]](var1, var2, var3, var4);
    }
    return;
  }

  if(!isDefined(var6)) {
    foreach(ent in entities) {
      ent thread[[process]](var1, var2, var3, var4, var5);
    }
    return;
  }

  if(!isDefined(var7)) {
    foreach(ent in entities) {
      ent thread[[process]](var1, var2, var3, var4, var5, var6);
    }
    return;
  }

  if(!isDefined(var8)) {
    foreach(ent in entities) {
      ent thread[[process]](var1, var2, var3, var4, var5, var6, var7);
    }
    return;
  }

  if(!isDefined(var9)) {
    foreach(ent in entities) {
      ent thread[[process]](var1, var2, var3, var4, var5, var6, var7, var8);
    }
    return;
  }

  foreach(ent in entities) {
    ent thread[[process]](var1, var2, var3, var4, var5, var6, var7, var8, var9);
  }
  return;
}

array_call(entities, process, var1, var2, var3) {
  if(isDefined(var3)) {
    foreach(ent in entities) {
      ent call[[process]](var1, var2, var3);
    }

    return;
  }

  if(isDefined(var2)) {
    foreach(ent in entities) {
      ent call[[process]](var1, var2);
    }

    return;
  }

  if(isDefined(var1)) {
    foreach(ent in entities) {
      ent call[[process]](var1);
    }

    return;
  }

  foreach(ent in entities) {
    ent call[[process]]();
  }
}

noself_array_call(entities, process, var2, var3, var4) {
  if(isDefined(var4)) {
    foreach(ent in entities) {
      call[[process]](ent, var2, var3, var4);
    }

    return;
  }

  if(isDefined(var3)) {
    foreach(ent in entities) {
      call[[process]](ent, var2, var3);
    }

    return;
  }

  if(isDefined(var2)) {
    foreach(ent in entities) {
      call[[process]](ent, var2);
    }

    return;
  }

  foreach(ent in entities) {
    call[[process]](ent);
  }
}

array_thread4(entities, process, var1, var2, var3, var4) {
  array_thread(entities, process, var1, var2, var3, var4);
}

array_thread5(entities, process, var1, var2, var3, var4, var5) {
  array_thread(entities, process, var1, var2, var3, var4, var5);
}

trigger_on(name, type) {
  if(isDefined(name) && isDefined(type)) {
    ents = getEntArray(name, type);
    array_thread(ents, ::trigger_on_proc);
  } else {
    self trigger_on_proc();
  }
}

trigger_on_proc() {
  if(isDefined(self.realOrigin)) {
    self.origin = self.realOrigin;
  }
  self.trigger_off = undefined;
}

trigger_off(name, type) {
  if(isDefined(name) && isDefined(type)) {
    ents = getEntArray(name, type);
    array_thread(ents, ::trigger_off_proc);
  } else {
    self trigger_off_proc();
  }
}

trigger_off_proc() {
  if(!isDefined(self.realOrigin)) {
    self.realOrigin = self.origin;
  }

  if(self.origin == self.realorigin) {
    self.origin += (0, 0, -10000);
  }
  self.trigger_off = true;
}

set_trigger_flag_permissions(msg) {
  if(!isDefined(level.trigger_flags)) {
    return;
  }

  level.trigger_flags[msg] = array_removeUndefined(level.trigger_flags[msg]);
  array_thread(level.trigger_flags[msg], ::update_trigger_based_on_flags);
}

update_trigger_based_on_flags() {
  true_on = true;
  if(isDefined(self.script_flag_true)) {
    true_on = false;
    tokens = create_flags_and_return_tokens(self.script_flag_true);

    foreach(token in tokens) {
      if(flag(token)) {
        true_on = true;
        break;
      }
    }
  }

  false_on = true;
  if(isDefined(self.script_flag_false)) {
    tokens = create_flags_and_return_tokens(self.script_flag_false);

    foreach(token in tokens) {
      if(flag(token)) {
        false_on = false;
        break;
      }
    }
  }

  [[level.trigger_func[true_on && false_on]]]();
}

create_flags_and_return_tokens(flags) {
  tokens = strtok(flags, " ");

  for(i = 0; i < tokens.size; i++) {
    if(!isDefined(level.flag[tokens[i]])) {
      flag_init(tokens[i]);
    }
  }

  return tokens;
}

init_trigger_flags() {
  level.trigger_flags = [];
  level.trigger_func[true] = ::trigger_on;
  level.trigger_func[false] = ::trigger_off;
}

getstruct(name, type) {
  assertex(isDefined(name) && isDefined(type), "Did not fill in name and type");
  assertEx(isDefined(level.struct_class_names), "Tried to getstruct before the structs were init");

  array = level.struct_class_names[type][name];
  if(!isDefined(array)) {
    return undefined;
  }

  if(array.size > 1) {
    assertMsg("getstruct used for more than one struct of type " + type + " called " + name + ".");
    return undefined;
  }
  return array[0];
}

getstructarray(name, type) {
  assertEx(isDefined(level.struct_class_names), "Tried to getstruct before the structs were init");

  array = level.struct_class_names[type][name];
  if(!isDefined(array)) {
    return [];
  }
  return array;
}

struct_class_init() {
  assertEx(!isDefined(level.struct_class_names), "level.struct_class_names is being initialized in the wrong place! It shouldn't be initialized yet.");

  level.struct_class_names = [];
  level.struct_class_names["target"] = [];
  level.struct_class_names["targetname"] = [];
  level.struct_class_names["script_noteworthy"] = [];
  level.struct_class_names["script_linkname"] = [];

  foreach(struct in level.struct) {
    add_struct_to_global_array(struct);
  }
}

add_struct_to_global_array(struct) {
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
    level.struct_class_names["script_linkname"][struct.script_linkname][0] = struct;
  }
}

fileprint_start(file) {
  filename = file;
  level.fileprint = 1;
  level.fileprintlinecount = 0;
  level.fileprint_filename = filename;
}

fileprint_map_start() {
  level.fileprint_mapentcount = 0;
  fileprint_map_header(true);
}

fileprint_map_header(bInclude_blank_worldspawn) {
  if(!isDefined(bInclude_blank_worldspawn)) {
    bInclude_blank_worldspawn = false;
  }

  fileprint_launcher( "iwmap 6" );
  fileprint_launcher( "\"000_Global\" flagsactive" );
  fileprint_launcher( "\"The Map\" flags" );

  if(!bInclude_blank_worldspawn) {
    return;
  }

  fileprint_map_entity_start();
  fileprint_map_keypairprint("classname", "worldspawn");
  fileprint_map_entity_end();
}

fileprint_map_keypairprint(key1, key2) {
  fileprint_launcher( "\"" + key1 + "\" \"" + key2 + "\"" );
}

fileprint_map_entity_start() {
  assert(isDefined(level.fileprint_mapentcount), "need to start a map with fileprint_map_start() first");
  assert(!isDefined(level.fileprint_entitystart));
  level.fileprint_entitystart = true;
  fileprint_launcher("entity " + level.fileprint_mapentcount );
  fileprint_launcher( "{" );
  level.fileprint_mapentcount++;
}

fileprint_map_entity_end() {
  fileprint_launcher( "}" );
  level.fileprint_entitystart = undefined;
}

fileprint_radiant_vec(vector) {
  string = "" + vector[0] + " " + vector[1] + " " + vector[2] + "";
  return string;
}

array_remove(ents, remover) {
  newents = [];
  foreach(ent in ents) {
    if(ent != remover) {
      newents[newents.size] = ent;
    }
  }

  return newents;
}

array_remove_array(ents, remover_array) {
  foreach(remover in remover_array) {
    ents = array_remove(ents, remover);
  }

  return ents;
}

array_removeUndefined(array) {
  newArray = [];
  foreach(i, item in array) {
    if(!isDefined(item)) {
      continue;
    }
    newArray[newArray.size] = item;
  }
  return newArray;
}

array_remove_duplicates(array) {
  array_unique = [];

  foreach(item in array) {
    if(!isDefined(item)) {
      continue;
    }

    keep = true;

    foreach(_item in array_unique) {
      if(item == _item) {
        keep = false;
        break;
      }
    }

    if(keep) {
      array_unique[array_unique.size] = item;
    }
  }

  return array_unique;
}

array_levelthread(array, process, var1, var2, var3) {
  if(isDefined(var3)) {
    foreach(ent in array) {
      thread[[process]](ent, var1, var2, var3);
    }

    return;
  }

  if(isDefined(var2)) {
    foreach(ent in array) {
      thread[[process]](ent, var1, var2);
    }

    return;
  }

  if(isDefined(var1)) {
    foreach(ent in array) {
      thread[[process]](ent, var1);
    }

    return;
  }

  foreach(ent in array) {
    thread[[process]](ent);
  }
}

array_levelcall(array, process, var1, var2, var3) {
  if(isDefined(var3)) {
    foreach(ent in array) {
      call[[process]](ent, var1, var2, var3);
    }

    return;
  }

  if(isDefined(var2)) {
    foreach(ent in array) {
      call[[process]](ent, var1, var2);
    }

    return;
  }

  if(isDefined(var1)) {
    foreach(ent in array) {
      call[[process]](ent, var1);
    }

    return;
  }

  foreach(ent in array) {
    call[[process]](ent);
  }
}

add_to_array(array, ent) {
  if(!isDefined(ent)) {
    return array;
  }

  if(!isDefined(array)) {
    array[0] = ent;
  } else {
    array[array.size] = ent;
  }

  return array;
}

flag_assert(msg) {
  assertEx(!flag(msg), "Flag " + msg + " set too soon!");
}

flag_wait_either(flag1, flag2) {
  for(;;) {
    if(flag(flag1)) {
      return;
    }
    if(flag(flag2)) {
      return;
    }

    level waittill_either(flag1, flag2);
  }
}

flag_wait_either_return(flag1, flag2) {
  for(;;) {
    if(flag(flag1)) {
      return flag1;
    }
    if(flag(flag2)) {
      return flag2;
    }

    msg = level waittill_any_return(flag1, flag2);
    return msg;
  }
}

flag_waitopen_either(flag1, flag2) {
  Assert(isDefined(flag1));
  Assert(isDefined(flag2));
  while(true) {
    if(!flag(flag1)) {
      return flag1;
    }

    if(!flag(flag2)) {
      return flag2;
    }

    level waittill_either(flag1, flag2);
  }
}

flag_waitopen_either_return(flag1, flag2) {
  return flag_waitopen_either(flag1, flag2);
}

flag_wait_any(flag1, flag2, flag3, flag4, flag5, flag6) {
  array = [];
  if(isDefined(flag6)) {
    array[array.size] = flag1;
    array[array.size] = flag2;
    array[array.size] = flag3;
    array[array.size] = flag4;
    array[array.size] = flag5;
    array[array.size] = flag6;
  } else if(isDefined(flag5)) {
    array[array.size] = flag1;
    array[array.size] = flag2;
    array[array.size] = flag3;
    array[array.size] = flag4;
    array[array.size] = flag5;
  } else if(isDefined(flag4)) {
    array[array.size] = flag1;
    array[array.size] = flag2;
    array[array.size] = flag3;
    array[array.size] = flag4;
  } else if(isDefined(flag3)) {
    array[array.size] = flag1;
    array[array.size] = flag2;
    array[array.size] = flag3;
  } else if(isDefined(flag2)) {
    flag_wait_either(flag1, flag2);
    return;
  } else {
    assertmsg("flag_wait_any() needs at least 2 flags passed to it");
    return;
  }

  for(;;) {
    for(i = 0; i < array.size; i++) {
      if(flag(array[i])) {
        return;
      }
    }

    level waittill_any(flag1, flag2, flag3, flag4, flag5, flag6);
  }
}

flag_wait_any_return(flag1, flag2, flag3, flag4, flag5) {
  array = [];

  if(isDefined(flag5)) {
    array[array.size] = flag1;
    array[array.size] = flag2;
    array[array.size] = flag3;
    array[array.size] = flag4;
    array[array.size] = flag5;
  } else if(isDefined(flag4)) {
    array[array.size] = flag1;
    array[array.size] = flag2;
    array[array.size] = flag3;
    array[array.size] = flag4;
  } else if(isDefined(flag3)) {
    array[array.size] = flag1;
    array[array.size] = flag2;
    array[array.size] = flag3;
  } else if(isDefined(flag2)) {
    msg = flag_wait_either_return(flag1, flag2);
    return msg;
  } else {
    assertmsg("flag_wait_any_return() needs at least 2 flags passed to it");
    return;
  }

  for(;;) {
    for(i = 0; i < array.size; i++) {
      if(flag(array[i])) {
        return array[i];
      }
    }

    msg = level waittill_any_return(flag1, flag2, flag3, flag4, flag5);
    return msg;
  }
}

flag_wait_all(flag1, flag2, flag3, flag4) {
  if(isDefined(flag1)) {
    flag_wait(flag1);
  }

  if(isDefined(flag2)) {
    flag_wait(flag2);
  }

  if(isDefined(flag3)) {
    flag_wait(flag3);
  }

  if(isDefined(flag4)) {
    flag_wait(flag4);
  }
}

flag_wait_or_timeout(flagname, timer) {
  timerMS = timer * 1000;
  start_time = GetTime();

  for(;;) {
    if(flag(flagname)) {
      break;
    }

    if(GetTime() >= start_time + timerMS) {
      break;
    }

    timeRemaining = timerMS - (GetTime() - start_time);
    timeRemainingSecs = timeRemaining / 1000;
    wait_for_flag_or_time_elapses(flagname, timeRemainingSecs);
  }
}

flag_waitopen_or_timeout(flagname, timer) {
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

wait_for_flag_or_time_elapses(flagname, timer) {
  level endon(flagname);
  wait(timer);
}

delayCall(timer, func, param1, param2, param3, param4, param5, param6, param7, param8, param9) {
  thread delayCall_proc(func, timer, param1, param2, param3, param4, param5, param6, param7, param8, param9);
}

delayCall_proc(func, timer, param1, param2, param3, param4, param5, param6, param7, param8, param9) {
  if(isSP()) {
    self endon("death");
    self endon("stop_delay_call");
  }

  wait(timer);
  if(isDefined(param9)) {
    self call[[func]](param1, param2, param3, param4, param5, param6, param7, param8, param9);
  } else {
    if(isDefined(param8))
  }
  self call[[func]](param1, param2, param3, param4, param5, param6, param7, param8);
  else {
    if(isDefined(param7))
  }
  self call[[func]](param1, param2, param3, param4, param5, param6, param7);
  else {
    if(isDefined(param6))
  }
  self call[[func]](param1, param2, param3, param4, param5, param6);
  else {
    if(isDefined(param5))
  }
  self call[[func]](param1, param2, param3, param4, param5);
  else {
    if(isDefined(param4))
  }
  self call[[func]](param1, param2, param3, param4);
  else {
    if(isDefined(param3))
  }
  self call[[func]](param1, param2, param3);
  else {
    if(isDefined(param2))
  }
  self call[[func]](param1, param2);
  else {
    if(isDefined(param1))
  }
  self call[[func]](param1);
  else {
    self call[[func]]();
  }
}

delay_script_call(timer, func, param1, param2, param3, param4, param5, param6, param7, param8, param9) {
  thread delay_script_call_proc(func, timer, param1, param2, param3, param4, param5, param6, param7, param8, param9);
}

delay_script_call_proc(func, timer, param1, param2, param3, param4, param5, param6, param7, param8, param9) {
  wait(timer);
  if(isDefined(param9)) {
    self[[func]](param1, param2, param3, param4, param5, param6, param7, param8, param9);
  } else if(isDefined(param8)) {
    self[[func]](param1, param2, param3, param4, param5, param6, param7, param8);
  } else {
    if(isDefined(param7))
  }
  self[[func]](param1, param2, param3, param4, param5, param6, param7);
  else {
    if(isDefined(param6))
  }
  self[[func]](param1, param2, param3, param4, param5, param6);
  else {
    if(isDefined(param5))
  }
  self[[func]](param1, param2, param3, param4, param5);
  else {
    if(isDefined(param4))
  }
  self[[func]](param1, param2, param3, param4);
  else {
    if(isDefined(param3))
  }
  self[[func]](param1, param2, param3);
  else {
    if(isDefined(param2))
  }
  self[[func]](param1, param2);
  else {
    if(isDefined(param1))
  }
  self[[func]](param1);
  else {
    self[[func]]();
  }
}

noself_delayCall(timer, func, param1, param2, param3, param4) {
  thread noself_delayCall_proc(func, timer, param1, param2, param3, param4);
}

noself_delayCall_proc(func, timer, param1, param2, param3, param4) {
  wait(timer);
  if(isDefined(param4)) {
    call[[func]](param1, param2, param3, param4);
  } else {
    if(isDefined(param3))
  }
  call[[func]](param1, param2, param3);
  else {
    if(isDefined(param2))
  }
  call[[func]](param1, param2);
  else {
    if(isDefined(param1))
  }
  call[[func]](param1);
  else {
    call[[func]]();
  }
}

isSP() {
  if(!isDefined(level.isSP)) {
    level.isSP = !(string_starts_with(getDvar("mapname"), "mp_"));
  }

  return level.isSP;
}

isSP_TowerDefense() {
  if(!isDefined(level.isSP_TowerDefense)) {
    level.isSP_TowerDefense = string_starts_with(getDvar("mapname"), "so_td_");
  }

  return level.isSP_TowerDefense;
}

string_starts_with(string, start) {
  assert(isDefined(string));
  assert(isDefined(start));
  if(string.size < start.size) {
    return false;
  }

  for(i = 0; i < start.size; i++) {
    if(tolower(string[i]) != tolower(start[i])) {
      return false;
    }
  }

  return true;
}

string_find(string, strSearch) {
  assert(IsString(string));
  assert(IsString(strSearch));

  if(string.size < strSearch.size) {
    return -1;
  }

  if(strSearch.size == 0) {
    return 0;
  }

  i = 0;
  j = 0;

  while(i < string.size) {
    if(tolower(string[i]) == tolower(strSearch[j])) {
      j++;
    } else {
      j = 0;

      if(tolower(string[i]) == tolower(strSearch[j])) {
        j++;
      } else if(i > (string.size - strSearch.size)) {
        return -1;
      }
    }

    if(j >= strSearch.size) {
      return (i - j) + 1;
    }

    i++;
  }

  return -1;
}

plot_points(plotpoints, r, g, b, timer) {
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

draw_line_for_time(org1, org2, r, g, b, timer, depthTest) {
  if(!isDefined(depthTest)) {
    depthTest = false;
  }

  timer = gettime() + (timer * 1000);
  while(gettime() < timer) {
    line(org1, org2, (r, g, b), 1, depthTest);
    wait .05;
  }
}

table_combine(table1, table2) {
  table3 = [];

  foreach(key, item in table1) {
    table3[key] = item;
  }

  foreach(key, item in table2) {
    assert(table3[key] == undefined);
    table3[key] = item;
  }
  return table3;
}

array_combine(array1, array2) {
  array3 = [];
  foreach(item in array1) {
    if(isDefined(item)) {
      array3[array3.size] = item;
    }
  }
  foreach(item in array2) {
    if(isDefined(item)) {
      array3[array3.size] = item;
    }
  }
  return array3;
}

array_combine_non_integer_indices(array1, array2) {
  array3 = [];
  foreach(index, item in array1) {
    Assert(!isDefined(array3[index]));
    array3[index] = item;
  }
  foreach(index, item in array2) {
    Assert(!isDefined(array3[index]));
    array3[index] = item;
  }
  return array3;
}

array_randomize(array) {
  for(i = 0; i < array.size; i++) {
    j = RandomInt(array.size);
    temp = array[i];
    array[i] = array[j];
    array[j] = temp;
  }
  return array;
}

array_add(array, ent) {
  array[array.size] = ent;
  return array;
}

array_first(array) {
  first = undefined;
  foreach(value in array) {
    first = value;
    break;
  }
  return first;
}

array_insert(array, object, index) {
  if(index == array.size) {
    temp = array;
    temp[temp.size] = object;
    return temp;
  }
  temp = [];
  offset = 0;
  for(i = 0; i < array.size; i++) {
    if(i == index) {
      temp[i] = object;
      offset = 1;
    }
    temp[i + offset] = array[i];
  }

  return temp;
}

array_contains(array, compare) {
  if(array.size <= 0) {
    return false;
  }

  foreach(member in array) {
    if(member == compare) {
      return true;
    }
  }

  return false;
}

array_find(array, item) {
  foreach(idx, test in array) {
    if(test == item) {
      return idx;
    }
  }
  return undefined;
}

flat_angle(angle) {
  rangle = (0, angle[1], 0);
  return rangle;
}

flat_origin(org) {
  rorg = (org[0], org[1], 0);
  return rorg;
}

draw_arrow_time(start, end, color, duration) {
  level endon("newpath");
  pts = [];
  angles = vectortoangles(start - end);
  right = anglestoright(angles);
  forward = anglesToForward(angles);
  up = anglestoup(angles);

  dist = distance(start, end);
  arrow = [];
  range = 0.1;

  arrow[0] = start;
  arrow[1] = start + (right * (dist * range)) + (forward * (dist * -0.1));
  arrow[2] = end;
  arrow[3] = start + (right * (dist * (-1 * range))) + (forward * (dist * -0.1));

  arrow[4] = start;
  arrow[5] = start + (up * (dist * range)) + (forward * (dist * -0.1));
  arrow[6] = end;
  arrow[7] = start + (up * (dist * (-1 * range))) + (forward * (dist * -0.1));
  arrow[8] = start;

  r = color[0];
  g = color[1];
  b = color[2];

  plot_points(arrow, r, g, b, duration);
}

get_linked_ents() {
  array = [];

  if(isDefined(self.script_linkto)) {
    linknames = get_links();
    foreach(name in linknames) {
      entities = getEntArray(name, "script_linkname");
      if(entities.size > 0) {
        array = array_combine(array, entities);
      }
    }
  }

  return array;
}

get_linked_vehicle_nodes() {
  array = [];

  if(isDefined(self.script_linkto)) {
    linknames = get_links();
    foreach(name in linknames) {
      entities = GetVehicleNodeArray(name, "script_linkname");
      if(entities.size > 0) {
        array = array_combine(array, entities);
      }
    }
  }
  return array;
}

get_linked_ent() {
  array = get_linked_ents();
  assert(array.size == 1);
  assert(isDefined(array[0]));
  return array[0];
}

get_linked_vehicle_node() {
  array = get_linked_vehicle_nodes();
  assert(array.size == 1);
  assert(isDefined(array[0]));
  return array[0];
}

get_links() {
  return strtok(self.script_linkTo, " ");
}

run_thread_on_targetname(msg, func, param1, param2, param3) {
  array = getEntArray(msg, "targetname");
  array_thread(array, func, param1, param2, param3);

  array = getstructarray(msg, "targetname");
  array_thread(array, func, param1, param2, param3);

  array = call[[level.getNodeArrayFunction]](msg, "targetname");
  array_thread(array, func, param1, param2, param3);

  array = getvehiclenodearray(msg, "targetname");
  array_thread(array, func, param1, param2, param3);
}

run_thread_on_noteworthy(msg, func, param1, param2, param3) {
  array = getEntArray(msg, "script_noteworthy");
  array_thread(array, func, param1, param2, param3);

  array = getstructarray(msg, "script_noteworthy");
  array_thread(array, func, param1, param2, param3);

  array = call[[level.getNodeArrayFunction]](msg, "script_noteworthy");
  array_thread(array, func, param1, param2, param3);

  array = getvehiclenodearray(msg, "script_noteworthy");
  array_thread(array, func, param1, param2, param3);
}

draw_arrow(start, end, color) {
  level endon("newpath");
  pts = [];
  angles = vectortoangles(start - end);
  right = anglestoright(angles);
  forward = anglesToForward(angles);

  dist = distance(start, end);
  arrow = [];
  range = 0.05;
  arrow[0] = start;
  arrow[1] = start + (right * (dist * (range))) + (forward * (dist * -0.2));
  arrow[2] = end;
  arrow[3] = start + (right * (dist * (-1 * range))) + (forward * (dist * -0.2));

  for(p = 0; p < 4; p++) {
    nextpoint = p + 1;
    if(nextpoint >= 4) {
      nextpoint = 0;
    }
    line(arrow[p], arrow[nextpoint], color, 1.0);
  }
}

draw_entity_bounds(ent, time_sec, color, dynamic, dynamic_update_time_sec) {
  Assert(isDefined(ent));
  Assert(time_sec > 0);

  if(!isDefined(color)) {
    color = (0, 1, 0);
  }

  if(!isDefined(dynamic)) {
    dynamic = false;
  }

  if(!isDefined(dynamic_update_time_sec)) {
    dynamic_update_time_sec = 0.05;
  }

  if(dynamic) {
    num_frames = int(dynamic_update_time_sec / 0.05);
  } else {
    num_frames = int(time_sec / 0.05);
  }

  points_side_1 = [];
  points_side_2 = [];

  current = GetTime();
  end = current + (time_sec * 1000);
  while(current < end && isDefined(ent)) {
    points_side_1[0] = ent GetPointInBounds(1, 1, 1);
    points_side_1[1] = ent GetPointInBounds(1, 1, -1);
    points_side_1[2] = ent GetPointInBounds(-1, 1, -1);
    points_side_1[3] = ent GetPointInBounds(-1, 1, 1);

    points_side_2[0] = ent GetPointInBounds(1, -1, 1);
    points_side_2[1] = ent GetPointInBounds(1, -1, -1);
    points_side_2[2] = ent GetPointInBounds(-1, -1, -1);
    points_side_2[3] = ent GetPointInBounds(-1, -1, 1);

    for(i = 0; i < 4; i++) {
      j = i + 1;
      if(j == 4) {
        j = 0;
      }

      Line(points_side_1[i], points_side_1[j], color, 1, false, num_frames);
      Line(points_side_2[i], points_side_2[j], color, 1, false, num_frames);
      Line(points_side_1[i], points_side_2[i], color, 1, false, num_frames);
    }

    if(!dynamic) {
      return;
    }

    wait dynamic_update_time_sec;
    current = GetTime();
  }
}

draw_volume(volume, time_sec, color, dynamic, dynamic_update_time_sec) {
  draw_entity_bounds(volume, time_sec, color, dynamic, dynamic_update_time_sec);
}

draw_trigger(trigger, time_sec, color, dynamic, dynamic_update_time_sec) {
  draw_entity_bounds(trigger, time_sec, color, dynamic, dynamic_update_time_sec);
}

getfx(fx) {
  assertEx(isDefined(level._effect[fx]), "Fx " + fx + " is not defined in level._effect.");
  return level._effect[fx];
}

fxExists(fx) {
  return isDefined(level._effect[fx]);
}

print_csv_asset(asset, type) {
  fileline = type + "," + asset;
  if(isDefined(level.csv_lines[fileline])) {
    return;
  }
  level.csv_lines[fileline] = true;
}

fileprint_csv_start(file) {
  file = "scriptgen/" + file + ".csv";
  level.csv_lines = [];
}

getLastWeapon() {
  assert(isDefined(self.saved_lastWeapon));

  return self.saved_lastWeapon;
}

PlayerUnlimitedAmmoThread() {
  if(!isDefined(self) || self == level || self.code_classname != "player") {
    player = level.player;
  } else {
    player = self;
  }

  assert(isDefined(player));

  while(1) {
    wait .5;

    if(getDvar("UnlimitedAmmoOff") == "1") {
      continue;
    }

    currentWeapon = player getCurrentWeapon();
    if(currentWeapon != "none") {
      currentAmmo = player GetFractionMaxAmmo(currentWeapon);
      if(currentAmmo < 0.2) {
        player GiveMaxAmmo(currentWeapon);
      }
    }
    currentTactical = player GetTacticalWeapon();
    if(currentTactical != "none") {
      currentAmmo = player GetFractionMaxAmmo(currentTactical);
      if(currentAmmo < 0.4) {
        player GiveMaxAmmo(currentTactical);
      }
    }
    currentLethal = player GetLethalWeapon();
    if(currentLethal != "none") {
      currentAmmo = player GetFractionMaxAmmo(currentLethal);
      if(currentAmmo < 0.4) {
        player GiveMaxAmmo(currentLethal);
      }
    }
  }
}

isUsabilityEnabled() {
  return (!self.disabledUsability);
}

_disableUsability() {
  if(!isDefined(self.disabledUsability)) {
    self.disabledUsability = 0;
  }

  self.disabledUsability++;
  self DisableUsability();
}

_enableUsability() {
  if(!isDefined(self.disabledUsability)) {
    self.disabledUsability = 0;
  } else if(self.disabledUsability > 0) {
    self.disabledUsability--;

    if(self.disabledUsability == 0) {
      self EnableUsability();
    }
  }
}

resetUsability() {
  self.disabledUsability = 0;
  self EnableUsability();
}

_disableWeapon() {
  if(!isDefined(self.disabledWeapon)) {
    self.disabledWeapon = 0;
  }

  self.disabledWeapon++;
  self disableWeapons();
}

_enableWeapon() {
  if(!isDefined(self.disabledWeapon)) {
    self.disabledWeapon = 0;
  }

  self.disabledWeapon--;

  assert(self.disabledWeapon >= 0);

  if(!self.disabledWeapon) {
    self enableWeapons();
  }
}

isWeaponEnabled() {
  return (!self.disabledWeapon);
}

_disableWeaponSwitch() {
  if(!isDefined(self.disabledWeaponSwitch)) {
    self.disabledWeaponSwitch = 0;
  }

  self.disabledWeaponSwitch++;
  self disableWeaponSwitch();
}

_enableWeaponSwitch() {
  if(!isDefined(self.disabledWeaponSwitch)) {
    self.disabledWeaponSwitch = 0;
  }

  self.disabledWeaponSwitch--;

  assert(self.disabledWeaponSwitch >= 0);

  if(!self.disabledWeaponSwitch) {
    if(isDefined(level.HordeWeaponsJammed) && level.HordeWeaponsJammed == true) {
      return;
    } else {
      self enableWeaponSwitch();
    }
  }
}

isWeaponSwitchEnabled() {
  return (!self.disabledWeaponSwitch);
}

_disableOffhandWeapons() {
  if(!isDefined(self.disabledOffhandWeapons)) {
    self.disabledOffhandWeapons = 0;
  }

  self.disabledOffhandWeapons++;
  self DisableOffhandWeapons();
}

_enableOffhandWeapons() {
  if(!isDefined(self.disabledOffhandWeapons)) {
    self.disabledOffhandWeapons = 0;
  }

  self.disabledOffhandWeapons--;

  assert(self.disabledOffhandWeapons >= 0);

  if(!self.disabledOffhandWeapons) {
    self EnableOffhandWeapons();
  }
}

isOffhandWeaponEnabled() {
  return (!self.disabledOffhandWeapons);
}

_enableDetonate(weapon, enable) {
  if(!self HasWeapon(weapon)) {
    return;
  }

  if(self GetDetonateEnabled(weapon) == enable) {
    return;
  }

  self EnableDetonate(weapon, enable);

  if(enable) {
    self notify("WeaponDetonateEnabled", weapon);
  } else {
    self notify("WeaponDetonateDisabled", weapon);
  }
}

random(array) {
  newarray = [];
  foreach(index, value in array) {
    newarray[newarray.size] = value;
  }

  if(!newarray.size) {
    return undefined;
  }

  return newarray[randomint(newarray.size)];
}

random_weight_sorted(array) {
  newarray = [];
  foreach(index, value in array) {
    newarray[newarray.size] = value;
  }

  if(!newarray.size) {
    return undefined;
  }

  rndSizeSq = randomint(newarray.size * newarray.size);
  return newarray[(newarray.size - 1) - int(sqrt(rndSizeSq))];
}

spawn_tag_origin() {
  tag_origin = spawn("script_model", (0, 0, 0));
  tag_origin setModel("tag_origin");
  tag_origin hide();
  if(isDefined(self.origin)) {
    tag_origin.origin = self.origin;
  }
  if(isDefined(self.angles)) {
    tag_origin.angles = self.angles;
  }

  return tag_origin;
}

waittill_notify_or_timeout(msg, timer) {
  self endon(msg);
  wait(timer);
}

waittill_notify_or_timeout_return(msg, timer) {
  self endon(msg);
  wait(timer);
  return "timeout";
}

fileprint_launcher_start_file()
{
  AssertEx(!isDefined(level. fileprint_launcher ), "Can't open more than one file at a time to print through launcher." );
        level.fileprintlauncher_linecount = 0; level. fileprint_launcher = true;
        fileprint_launcher( "GAMEPRINTSTARTFILE:" );
      }

      fileprint_launcher( string )
      {
        assert(isDefined(level.fileprintlauncher_linecount));
        level.fileprintlauncher_linecount++;
        if(level.fileprintlauncher_linecount > 200) {
          wait .05;
          level.fileprintlauncher_linecount = 0;
        }
        println("LAUNCHERPRINTLN:" + string);
      }

      fileprint_launcher_end_file( file_relative_to_game, bIsPerforceEnabled )
      {
        if(!isDefined(bIsPerforceEnabled)) {
          bIsPerforceEnabled = false;
        }

        setDevDvarIfUninitialized("LAUNCHER_PRINT_FAIL", "0");
        setDevDvarIfUninitialized("LAUNCHER_PRINT_SUCCESS", "0");

        if(bIsPerforceEnabled) {
          fileprint_launcher( "GAMEPRINTENDFILE:GAMEPRINTP4ENABLED:"+file_relative_to_game );
        } else {
          fileprint_launcher( "GAMEPRINTENDFILE:"+file_relative_to_game );
        }

        TimeOut = gettime() + 4000;
        while(getdvarint("LAUNCHER_PRINT_SUCCESS") == 0 && getDvar("LAUNCHER_PRINT_FAIL") == "0" && gettime() < TimeOut) {
          wait .05;
        }

        if(!(gettime() < TimeOut)) {
          iprintlnbold("LAUNCHER_PRINT_FAIL:( TIMEOUT ): launcherconflict? restart launcher and try again? ");
          setdevdvar("LAUNCHER_PRINT_FAIL", "0");
          level. fileprint_launcher = undefined;
          return false;
        }

        failvar = getDvar("LAUNCHER_PRINT_FAIL");
        if(failvar != "0") {
          iprintlnbold("LAUNCHER_PRINT_FAIL:( " + failvar + " ): launcherconflict? restart launcher and try again? ");
          setdevdvar("LAUNCHER_PRINT_FAIL", "0");
          level. fileprint_launcher = undefined;
          return false;
        }

        setdevdvar("LAUNCHER_PRINT_FAIL", "0");
        setdevdvar("LAUNCHER_PRINT_SUCCESS", "0");

        level. fileprint_launcher = undefined;
        return true;
      }

      launcher_write_clipboard(str) {
        level.fileprintlauncher_linecount = 0;
        fileprint_launcher( "LAUNCHER_CLIP:" + str );
      }

      isDestructible() {
        if(!isDefined(self)) {
          return false;
        }
        return isDefined(self.destructible_type);
      }

      pauseEffect() {
        common_scripts\_createfx::stop_fx_looper();
      }

      activate_individual_exploder() {
        common_scripts\_exploder::activate_individual_exploder_proc();
      }

      get_target_ent(target) {
        if(!isDefined(target)) {
          target = self.target;
        }

        AssertEx(isDefined(target), "Self had no target!");

        ent = GetEnt(target, "targetname");
        if(isDefined(ent)) {
          return ent;
        }

        if(isSP()) {
          ent = call[[level.getNodeFunction]](target, "targetname");
          if(isDefined(ent)) {
            return ent;
          }
        }

        ent = getstruct(target, "targetname");
        if(isDefined(ent)) {
          return ent;
        }

        ent = GetVehicleNode(target, "targetname");
        if(isDefined(ent)) {
          return ent;
        }

        AssertMsg("Tried to get ent " + target + ", but there was no ent.");
      }

      get_noteworthy_ent(noteworthy) {
        AssertEx(isDefined(noteworthy), "No script_noteworthy provided!");

        ent = GetEnt(noteworthy, "script_noteworthy");
        if(isDefined(ent)) {
          return ent;
        }

        if(isSP()) {
          ent = call[[level.getNodeFunction]](noteworthy, "script_noteworthy");
          if(isDefined(ent)) {
            return ent;
          }
        }

        ent = getstruct(noteworthy, "script_noteworthy");
        if(isDefined(ent)) {
          return ent;
        }

        ent = GetVehicleNode(noteworthy, "script_noteworthy");
        if(isDefined(ent)) {
          return ent;
        }

        AssertEx("Tried to get ent, but there was no ent.");
      }

      do_earthquake(name, origin) {
        eq = level.earthquake[name];
        Earthquake(eq["magnitude"], eq["duration"], origin, eq["radius"]);
      }

      play_loopsound_in_space(alias, origin) {
        if(!SoundExists(alias)) {
          println("Warning: play_loopsound_in_space() alias doesn't exist: " + alias);
          return;
        }

        org = spawn("script_origin", (0, 0, 0));
        if(!isDefined(origin)) {
          origin = self.origin;
        }

        org.origin = origin;

        org playLoopSound(alias);
        return org;
      }

      play_sound_in_space_with_angles(alias, origin, angles, master) {
        if(!SoundExists(alias)) {
          iprintln("alias " + alias + " doesn't exist.");

          return;
        }

        org = spawn("script_origin", (0, 0, 1));
        if(!isDefined(origin)) {
          origin = self.origin;
        }
        org.origin = origin;
        org.angles = angles;
        if(isSP()) {
          if(isDefined(master) && master) {
            org PlaySoundAsMaster(alias, "sounddone");
          } else {
            org playSound(alias, "sounddone");
          }
          org waittill("sounddone");
        } else {
          if(isDefined(master) && master) {
            org PlaySoundAsMaster(alias);
          } else {
            org playSound(alias);
          }
        }
        org Delete();
      }

      play_sound_in_space(alias, origin, master) {
        play_sound_in_space_with_angles(alias, origin, (0, 0, 0), master);
      }

      loop_fx_sound(alias, origin, culled, ender, createfx_ent) {
        if(!SoundExists(alias)) {
          println("Warning: loop_fx_sound() alias doesn't exist: " + alias);
          return;
        }

        if(isDefined(ender)) {
          culled = undefined;
        }

        if(isDefined(culled) && culled && (!isDefined(level.first_frame) || level.first_frame == 1)) {
          SpawnLoopingSound(alias, origin, (0, 0, 0));
        } else {
          org = spawn("script_origin", (0, 0, 0));

          if(isDefined(ender)) {
            thread loop_sound_delete(ender, org);
            self endon(ender);
          }

          org.origin = origin;
          org playLoopSound(alias);
          org willNeverChange();
        }
      }

      loop_fx_sound_with_angles(alias, origin, angles, culled, ender, createfx_ent, shape) {
        if(!SoundExists(alias)) {
          println("Warning: loop_fx_sound_with_angles() alias doesn't exist: " + alias);
          return;
        }

        if(isDefined(culled) && culled) {
          if(!isDefined(level.first_frame) || level.first_frame == 1) {
            SpawnLoopingSound(alias, origin, angles);
          }
        } else {
          if(isDefined(level.createFX_enabled) && level.createFX_enabled && isDefined(createfx_ent.loopsound_ent)) {
            org = createfx_ent.loopsound_ent;
          } else {
            org = spawn("script_origin", (0, 0, 0));
          }

          if(isDefined(ender)) {
            thread loop_sound_delete(ender, org);
            self endon(ender);
          }

          org.origin = origin;
          org.angles = angles;
          org playLoopSound(alias);

          if(isDefined(level.createFX_enabled) && level.createFX_enabled) {
            createfx_ent.loopsound_ent = org;
          } else {
            org willNeverChange();
          }
        }
      }

      loop_fx_sound_interval(alias, origin, ender, timeout, delay_min, delay_max) {
        loop_fx_sound_interval_with_angles(alias, origin, (0, 0, 0), ender, timeout, delay_min, delay_max);
      }

      loop_fx_sound_interval_with_angles(alias, origin, angles, ender, timeout, delay_min, delay_max) {
        org = spawn("script_origin", (0, 0, 0));

        if(isDefined(ender)) {
          thread loop_sound_delete(ender, org);
          self endon(ender);
        }

        org.origin = origin;
        org.angles = angles;

        if(delay_min >= delay_max) {
          while(true) {
            Print3d(origin, "delay_min >= delay_max", (1, 0, 0), 1, 1);
            wait .05;
          }
        }

        if(!SoundExists(alias)) {
          while(true) {
            Print3d(origin, "no sound: " + alias, (1, 0, 0), 1, 1);
            wait .05;
          }
        }

        while(true) {
          wait RandomFloatRange(delay_min, delay_max);
          lock("createfx_looper");
          thread play_sound_in_space_with_angles(alias, org.origin, org.angles, undefined);
          unlock("createfx_looper");
        }
      }

      loop_sound_delete(ender, ent) {
        ent endon("death");
        self waittill(ender);
        ent Delete();
      }

      createLoopEffect(fxid) {
        ent = common_scripts\_createfx::createEffect("loopfx", fxid);
        ent.v["delay"] = common_scripts\_createfx::getLoopEffectDelayDefault();
        return ent;
      }

      createOneshotEffect(fxid) {
        ent = common_scripts\_createfx::createEffect("oneshotfx", fxid);
        ent.v["delay"] = common_scripts\_createfx::getOneshotEffectDelayDefault();
        return ent;
      }

      createExploder(fxid) {
        ent = common_scripts\_createfx::createEffect("exploder", fxid);
        ent.v["delay"] = common_scripts\_createfx::getExploderDelayDefault();
        ent.v["exploder_type"] = "normal";
        return ent;
      }

      alphabetize(array) {
        if(array.size <= 1) {
          return array;
        }

        count = 0;
        for(asize = array.size - 1; asize >= 1; asize--) {
          largest = array[asize];
          largestIndex = asize;
          for(i = 0; i < asize; i++) {
            string1 = array[i];

            if(StrICmp(string1, largest) > 0) {
              largest = string1;
              largestIndex = i;
            }
          }

          if(largestIndex != asize) {
            array[largestIndex] = array[asize];
            array[asize] = largest;
          }
        }

        return array;
      }

      is_later_in_alphabet(string1, string2) {
        return StrICmp(string1, string2) > 0;
      }

      play_loop_sound_on_entity(alias, offset) {
        if(!SoundExists(alias)) {
          println("Warning: play_loop_sound_on_entity() alias doesn't exist: " + alias);
          return;
        }

        org = spawn("script_origin", (0, 0, 0));
        org endon("death");
        thread delete_on_death(org);

        if(isDefined(offset)) {
          org.origin = self.origin + offset;
          org.angles = self.angles;
          org linktosynchronizedparent(self);
        } else {
          org.origin = self.origin;
          org.angles = self.angles;
          org linktosynchronizedparent(self);
        }

        org playLoopSound(alias);

        self waittill("stop sound" + alias);
        org StopLoopSound(alias);
        org Delete();
      }

      stop_loop_sound_on_entity(alias) {
        self notify("stop sound" + alias);
      }

      delete_on_death(ent) {
        ent endon("death");
        self waittill("death");
        if(isDefined(ent)) {
          ent Delete();
        }
      }

      error(msg) {
        PrintLn("^c * ERROR * ", msg);
        waitframe();

        if(getDvar("debug") != "1") {
          AssertMsg("This is a forced error - attach the log file. \n" + msg);
        }
      }

      create_dvar(var, val) {
        SetDvarIfUninitialized(var, val);
      }

      void(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13) {}

      tag_project(tagname, dist) {
        org = self GetTagOrigin(tagname);
        angle = self GetTagAngles(tagname);
        vector = anglesToForward(angle);
        vector = VectorNormalize(vector) * dist;
        return org + vector;
      }

      ter_op(statement, true_value, false_value) {
        if(statement) {
          return true_value;
        }
        return false_value;
      }

      create_lock(msg, count) {
        if(!isDefined(count)) {
          count = 1;
        }

        Assert(isDefined(msg));

        if(!isDefined(level.lock)) {
          level.lock = [];
        }

        lock_struct = spawnStruct();
        lock_struct.max_count = count;
        lock_struct.count = 0;
        level.lock[msg] = lock_struct;
      }

      lock_exists(msg) {
        if(!isDefined(level.lock)) {
          return false;
        }
        return isDefined(level.lock[msg]);
      }

      lock(msg) {
        Assert(isDefined(level.lock));
        Assert(isDefined(level.lock[msg]));
        lock = level.lock[msg];
        while(lock.count >= lock.max_count) {
          lock waittill("unlocked");
        }
        lock.count++;
      }

      is_locked(msg) {
        Assert(isDefined(level.lock));
        Assert(isDefined(level.lock[msg]));
        lock = level.lock[msg];
        return lock.count > lock.max_count;
      }

      unlock_wait(msg) {
        thread unlock_thread(msg);
        wait 0.05;
      }

      unlock(msg) {
        thread unlock_thread(msg);
      }

      unlock_thread(msg) {
        wait 0.05;
        Assert(isDefined(level.lock));
        Assert(isDefined(level.lock[msg]));
        lock = level.lock[msg];
        lock.count--;
        Assert(lock.count >= 0);
        lock notify("unlocked");
      }

      get_template_level() {
        script = level.script;
        if(isDefined(level.template_script)) {
          script = level.template_script;
        }
        return script;
      }

      array_reverse(array) {
        array2 = [];
        for(i = array.size - 1; i >= 0; i--) {
          array2[array2.size] = array[i];
        }
        return array2;
      }

      distance_2d_squared(a, b) {
        return Length2DSquared(a - b);
      }

      get_array_of_farthest(org, array, excluders, max, maxdist, mindist) {
        aArray = get_array_of_closest(org, array, excluders, max, maxdist, mindist);
        aArray = array_reverse(aArray);
        return aArray;
      }

      get_array_of_closest(org, array, excluders, max, maxdist, mindist) {
        if(!isDefined(max)) {
          max = array.size;
        }
        if(!isDefined(excluders)) {
          excluders = [];
        }

        maxdist2rd = undefined;
        if(isDefined(maxdist)) {
          maxdist2rd = maxdist * maxdist;
        }

        mindist2rd = 0;
        if(isDefined(mindist)) {
          mindist2rd = mindist * mindist;
        }

        if(excluders.size == 0 && max >= array.size && mindist2rd == 0 && !isDefined(maxdist2rd)) {
          return SortByDistance(array, org);
        }

        newArray = [];
        foreach(ent in array) {
          excluded = false;
          foreach(excluder in excluders) {
            if(ent == excluder) {
              excluded = true;
              break;
            }
          }
          if(excluded) {
            continue;
          }

          dist2rd = DistanceSquared(org, ent.origin);

          if(isDefined(maxdist2rd) && dist2rd > maxdist2rd) {
            continue;
          }

          if(dist2rd < mindist2rd) {
            continue;
          }

          newArray[newArray.size] = ent;
        }

        newArray = SortByDistance(newArray, org);

        if(max >= newArray.size) {
          return newArray;
        }

        finalArray = [];
        for(i = 0; i < max; i++) {
          finalArray[i] = newArray[i];
        }

        return finalArray;
      }

      is_player_gamepad_enabled() {
        if(!level.Console) {
          player_gpad_enabled = self UsingGamepad();
          if(isDefined(player_gpad_enabled)) {
            return player_gpad_enabled;
          } else {
            return false;
          }
        }

        return true;
      }

      drop_to_ground(pos, updist, downdist) {
        if(!isDefined(updist)) {
          updist = 1500;
        }
        if(!isDefined(downdist)) {
          downdist = -12000;
        }

        return PhysicsTrace(pos + (0, 0, updist), pos + (0, 0, downdist));
      }

      add_destructible_type_function(destructible_type, function) {
        if(!isDefined(level.destructible_functions)) {
          level.destructible_functions = [];
        }

        Assert(!isDefined(level.destructible_functions[destructible_type]));

        level.destructible_functions[destructible_type] = function;
      }

      add_destructible_type_transient(destructible_type, name) {
        AssertEx(!isDefined(level._loadStarted), "add_destructible_type_transient() must be set before _load::main()");

        if(!isDefined(level.destructible_transient)) {
          level.destructible_transient = [];
        }

        Assert(!isDefined(level.destructible_transient[destructible_type]));

        level.destructible_transient[destructible_type] = name;
      }

      within_fov(start_origin, start_angles, end_origin, fov) {
        normal = VectorNormalize(end_origin - start_origin);
        forward = anglesToForward(start_angles);
        dot = VectorDot(forward, normal);

        return dot >= fov;
      }

      entity_path_disconnect_thread(updateRate) {
        self notify("entity_path_disconnect_thread");
        self endon("entity_path_disconnect_thread");

        self endon("death");
        level endon("game_ended");

        disconnect = false;
        self.forceDisconnectUntil = 0;

        assert(updateRate >= 0.05);

        while(1) {
          lastPos = self.origin;

          event = waittill_any_timeout(updateRate, "path_disconnect");

          newDisconnect = false;
          moved = DistanceSquared(self.origin, lastPos) > 0;

          if(moved) {
            newDisconnect = true;
          }

          if(isDefined(event) && (event == "path_disconnect")) {
            newDisconnect = true;
          }

          if(GetTime() < self.forceDisconnectUntil) {
            newDisconnect = true;
          }

          foreach(character in level.characters) {
            if(IsAI(character) && DistanceSquared(self.origin, character.origin) < 500 * 500) {
              newDisconnect = true;
              self.forceDisconnectUntil = max(GetTime() + 30000, self.forceDisconnectUntil);
            }
          }

          if((newDisconnect != disconnect) || moved) {
            if(newDisconnect) {
              self DisconnectPaths();
            } else {
              self ConnectPaths();
            }

            disconnect = newDisconnect;
          }
        }
      }

      make_entity_sentient_mp(team, expendable) {
        if(level.gameType == "aliens" && isDefined(level.aliens_make_entity_sentient_func)) {
          return self[[level.aliens_make_entity_sentient_func]](team, expendable);
        }

        if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bots_make_entity_sentient"])) {
          return self[[level.bot_funcs["bots_make_entity_sentient"]]](team, expendable);
        }
      }

      ai_3d_sighting_model(associatedEnt) {
        assert(isAI(self));

        if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["ai_3d_sighting_model"])) {
          return self[[level.bot_funcs["ai_3d_sighting_model"]]](associatedEnt);
        }
      }

      set_basic_animated_model(model, anime, mpanimstring) {
        if(!isDefined(level.anim_prop_models)) {
          level.anim_prop_models = [];
        }

        mapname = tolower(getDvar("mapname"));
        SP = true;
        if(string_starts_with(mapname, "mp_")) {
          SP = false;
        }

        if(SP) {
          level.anim_prop_models[model]["basic"] = anime;
        } else {
          level.anim_prop_models[model]["basic"] = mpanimstring;
        }
      }

      getClosest(org, array, maxdist) {
        if(!isDefined(maxdist)) {
          maxdist = 500000;
        }

        ent = undefined;
        foreach(item in array) {
          if(!isDefined(item)) {
            continue;
          }
          newdist = Distance(item.origin, org);
          if(newdist >= maxdist) {
            continue;
          }
          maxdist = newdist;
          ent = item;
        }
        return ent;
      }

      getFarthest(org, array, maxdist) {
        if(!isDefined(maxdist)) {
          maxdist = 500000;
        }

        dist = 0;
        ent = undefined;
        foreach(item in array) {
          newdist = Distance(item.origin, org);
          if(newdist <= dist || newdist >= maxdist) {
            continue;
          }
          dist = newdist;
          ent = item;
        }
        return ent;
      }

      missile_setTargetAndFlightMode(target, mode, offset) {
        Assert(isDefined(target));
        Assert(isDefined(mode));

        offset = ter_op(isDefined(offset), offset, (0, 0, 0));

        self Missile_SetTargetEnt(target, offset);

        switch (mode) {
          case "direct":
            self Missile_SetFlightmodeDirect();
            break;
          case "top":
            self Missile_SetFlightModeTop();
            break;
        }
      }

      EvFromLuminanceNits(nits) {
        return log(nits + 0.000061) / log(2.0) + 2.84;
      }

      LinearToGamma_Srgb(f) {
        if(f <= 0.0031308) {
          return f * 12.92;
        } else {
          return pow(f, 1.0 / 2.4) * 1.055 - 0.055;
        }
      }

      ConvertLegacyFog(ent) {
        if(!isDefined(ent.HDRColorIntensity)) {
          if(IsUsingHDR()) {
            maxRGB = max(ent.red, max(ent.green, ent.blue));
            ev = EvFromLuminanceNits(maxRGB * GetRadiometricUnit());
            if(maxRGB > 0) {
              ent.red /= maxRGB;
              ent.green /= maxRGB;
              ent.blue /= maxRGB;
              ent.red = LinearToGamma_Srgb(ent.red);
              ent.green = LinearToGamma_Srgb(ent.green);
              ent.blue = LinearToGamma_Srgb(ent.blue);
              ent.HDRColorIntensity = ev;
            } else {
              ent.HDRColorIntensity = 0.0;
            }
          } else {
            ent.HDRColorIntensity = 1.0;
          }
        }
        if(isDefined(ent.sunFogEnabled) && ent.sunFogEnabled) {
          if(!isDefined(ent.HDRSunColorIntensity)) {
            if(IsUsingHDR()) {
              maxRGB = max(ent.red, ent.green, ent.blue);
              ev = EvFromLuminanceNits(maxRGB * GetRadiometricUnit());
              if(maxRGB > 0) {
                ent.sunRed /= maxRGB;
                ent.sunGreen /= maxRGB;
                ent.sunBlue /= maxRGB;
                ent.sunRed = LinearToGamma_Srgb(ent.red);
                ent.sunGreen = LinearToGamma_Srgb(ent.green);
                ent.sunBlue = LinearToGamma_Srgb(ent.blue);
                ent.HDRSunColorIntensity = ev;
              } else {
                ent.HDRSunColorIntensity = 0.0;
              }
            } else {
              ent.HDRSunColorIntensity = 1.0;
            }
          }
        }
      }

      ConvertFogTech(ent) {
        if(isDefined(level.exclusive_fog_tech)) {
          switch (level.exclusive_fog_tech) {
            case "dfog":
              if(level.exclusive_fog_tech == "dfog" && ent.sunFogEnabled == false) {
                ent.sunFogEnabled = true;
                ent.sunRed = 0;
                ent.sunGreen = 0;
                ent.sunBlue = 0;
                ent.HDRSunColorIntensity = 0;
                ent.sunDir = (0, 0, 0);
                ent.sunBeginFadeAngle = 0;
                ent.sunEndFageAngle = 0;
                ent.normalFogScale = 1;
              }
              break;

            case "normal_fog":
              if(ent.sunFogEnabled == true) {
                ent.sunFogEnabled = false;
              }
              break;

            default:
              AssertMsg("unhandled level.exclusive_fog_tech: " + level.exclusive_fog_tech);
          }
        }
      }

      set_fog_to_ent_values_dfog(ent, transition_time) {
        if(isDefined(ent.sunFogEnabled) && ent.sunFogEnabled) {
          if(!isPlayer(self)) {
            SetExpFogExt(
              ent.startDist, ent.halfwayDist, ent.red, ent.green, ent.blue, ent.HDRColorIntensity, ent.maxOpacity, transition_time, ent.sunRed, ent.sunGreen, ent.sunBlue, ent.HDRSunColorIntensity, ent.sunDir, ent.sunBeginFadeAngle, ent.sunEndFadeAngle, ent.normalFogScale, ent.skyFogIntensity, ent.skyFogMinAngle, ent.skyFogMaxAngle, ent.heightFogEnabled, ent.heightFogBaseHeight, ent.heightFogHalfPlaneDistance);
          } else {
            self PlayerSetExpFogExt(
              ent.startDist, ent.halfwayDist, ent.red, ent.green, ent.blue, ent.HDRColorIntensity, ent.maxOpacity, transition_time, ent.sunRed, ent.sunGreen, ent.sunBlue, ent.HDRSunColorIntensity, ent.sunDir, ent.sunBeginFadeAngle, ent.sunEndFadeAngle, ent.normalFogScale, ent.skyFogIntensity, ent.skyFogMinAngle, ent.skyFogMaxAngle, ent.heightFogEnabled, ent.heightFogBaseHeight, ent.heightFogHalfPlaneDistance);
          }
        } else {
          if(!isPlayer(self)) {
            SetExpFogExt(
              ent.startDist, ent.halfwayDist, ent.red, ent.green, ent.blue, ent.HDRColorIntensity, ent.maxOpacity, transition_time, ent.skyFogIntensity, ent.skyFogMinAngle, ent.skyFogMaxAngle, ent.heightFogEnabled, ent.heightFogBaseHeight, ent.heightFogHalfPlaneDistance);
          } else {
            self PlayerSetExpFogExt(
              ent.startDist, ent.halfwayDist, ent.red, ent.green, ent.blue, ent.HDRColorIntensity, ent.maxOpacity, transition_time, ent.skyFogIntensity, ent.skyFogMinAngle, ent.skyFogMaxAngle, ent.heightFogEnabled, ent.heightFogBaseHeight, ent.heightFogHalfPlaneDistance);
          }
        }
      }

      set_fog_to_ent_values(ent, transition_time) {
        if(!isDefined(transition_time)) {
          transition_time = 0;
        }

        if(!isDefined(ent.skyFogIntensity)) {
          ent.skyFogIntensity = 0;
          ent.skyFogMinAngle = 0;
          ent.skyFogMaxAngle = 0;
        }

        if(!isDefined(ent.heightFogEnabled)) {
          ent.heightFogEnabled = 0;
          ent.heightFogBaseHeight = 0;
          ent.heightFogHalfPlaneDistance = 1000;
        }

        ConvertLegacyFog(ent);
        ConvertFogTech(ent);

        if(isDefined(ent.atmosFogEnabled)) {
          AssertEx(isDefined(ent.atmosFogSunFogColor));
          AssertEx(isDefined(ent.atmosFogHazeColor));
          AssertEx(isDefined(ent.atmosFogHazeStrength));
          AssertEx(isDefined(ent.atmosFogHazeSpread));
          AssertEx(isDefined(ent.atmosFogExtinctionStrength));
          AssertEx(isDefined(ent.atmosFogInScatterStrength));
          AssertEx(isDefined(ent.atmosFogHalfPlaneDistance));
          AssertEx(isDefined(ent.atmosFogStartDistance));
          AssertEx(isDefined(ent.atmosFogDistanceScale));
          AssertEx(isDefined(ent.atmosFogSkyDistance));
          AssertEx(isDefined(ent.atmosFogSkyAngularFalloffEnabled));
          AssertEx(isDefined(ent.atmosFogSkyFalloffStartAngle));
          AssertEx(isDefined(ent.atmosFogSkyFalloffAngleRange));
          AssertEx(isDefined(ent.atmosFogSunDirection));
          AssertEx(isDefined(ent.atmosFogHeightFogEnabled));
          AssertEx(isDefined(ent.atmosFogHeightFogBaseHeight));
          AssertEx(isDefined(ent.atmosFogHeightFogHalfPlaneDistance));

          if(level.nextgen && ent.atmosFogEnabled) {
            if(isDefined(ent.sunFogEnabled) && ent.sunFogEnabled) {
              SetExpFogExtDvarsOnly(ent.startDist, ent.halfwayDist, ent.red, ent.green, ent.blue, ent.HDRColorIntensity, ent.maxOpacity, ent.sunRed, ent.sunGreen, ent.sunBlue, ent.HDRSunColorIntensity, ent.sunDir, ent.sunBeginFadeAngle, ent.sunEndFadeAngle, ent.normalFogScale, ent.skyFogIntensity, ent.skyFogMinAngle, ent.skyFogMaxAngle, ent.heightFogEnabled, ent.heightFogBaseHeight, ent.heightFogHalfPlaneDistance);
            } else {
              SetExpFogExtDvarsOnly(ent.startDist, ent.halfwayDist, ent.red, ent.green, ent.blue, ent.HDRColorIntensity, ent.maxOpacity, ent.skyFogIntensity, ent.skyFogMinAngle, ent.skyFogMaxAngle, ent.heightFogEnabled, ent.heightFogBaseHeight, ent.heightFogHalfPlaneDistance);
            }

            if(isPlayer(self)) {
              self PlayerSetAtmosFog(transition_time, ent.atmosFogSunFogColor, ent.atmosFogHazeColor, ent.atmosFogHazeStrength, ent.atmosFogHazeSpread, ent.atmosFogExtinctionStrength, ent.atmosFogInScatterStrength, ent.atmosFogHalfPlaneDistance, ent.atmosFogStartDistance, ent.atmosFogDistanceScale, int(ent.atmosFogSkyDistance), ent.atmosFogSkyAngularFalloffEnabled, ent.atmosFogSkyFalloffStartAngle, ent.atmosFogSkyFalloffAngleRange, ent.atmosFogSunDirection, ent.atmosFogHeightFogEnabled, ent.atmosFogHeightFogBaseHeight, ent.atmosFogHeightFogHalfPlaneDistance);
            } else {
              SetAtmosFog(transition_time, ent.atmosFogSunFogColor, ent.atmosFogHazeColor, ent.atmosFogHazeStrength, ent.atmosFogHazeSpread, ent.atmosFogExtinctionStrength, ent.atmosFogInScatterStrength, ent.atmosFogHalfPlaneDistance, ent.atmosFogStartDistance, ent.atmosFogDistanceScale, int(ent.atmosFogSkyDistance), ent.atmosFogSkyAngularFalloffEnabled, ent.atmosFogSkyFalloffStartAngle, ent.atmosFogSkyFalloffAngleRange, ent.atmosFogSunDirection, ent.atmosFogHeightFogEnabled, ent.atmosFogHeightFogBaseHeight, ent.atmosFogHeightFogHalfPlaneDistance);
            }
          } else {
            SetAtmosFogDvarsOnly(ent.atmosFogEnabled, ent.atmosFogSunFogColor, ent.atmosFogHazeColor, ent.atmosFogHazeStrength, ent.atmosFogHazeSpread, ent.atmosFogExtinctionStrength, ent.atmosFogInScatterStrength, ent.atmosFogHalfPlaneDistance, ent.atmosFogStartDistance, ent.atmosFogDistanceScale, int(ent.atmosFogSkyDistance), ent.atmosFogSkyAngularFalloffEnabled, ent.atmosFogSkyFalloffStartAngle, ent.atmosFogSkyFalloffAngleRange, ent.atmosFogSunDirection, ent.atmosFogHeightFogEnabled, ent.atmosFogHeightFogBaseHeight, ent.atmosFogHeightFogHalfPlaneDistance);

            set_fog_to_ent_values_dfog(ent, transition_time);
          }
        } else {
          set_fog_to_ent_values_dfog(ent, transition_time);
        }
      }

      add_fx(fx_id, fx_path) {
        if(!isDefined(level._effect)) {
          level._effect = [];
        }
        Assert(isDefined(fx_path));
        Assert(isDefined(fx_id));
        level._effect[fx_id] = LoadFX(fx_path);
      }

      array_sort_by_handler(array, compare_func) {
        AssertEx(isDefined(array), "Array not defined.");
        AssertEx(isDefined(compare_func), "Compare function not defined.");

        for(i = 0; i < array.size - 1; i++) {
          for(j = i + 1; j < array.size; j++) {
            if(array[j][[compare_func]]() < array[i][[compare_func]]()) {
              ref = array[j];
              array[j] = array[i];
              array[i] = ref;
            }
          }
        }

        return array;
      }

      array_sort_with_func(array, compare_func, sort_per_frame) {
        AssertEx(isDefined(array), "Array not defined.");
        AssertEx(isDefined(compare_func), "Compare function not defined.");

        if(!isDefined(sort_per_frame)) {
          sort_per_frame = -1;
        }

        prof_begin("Array_sort");

        for(j = 1; j < array.size; j++) {
          key = array[j];
          for(i = j - 1;
            (i >= 0) && ![[compare_func]](array[i], key); i--) {
            array[i + 1] = array[i];
          }
          array[i + 1] = key;

          if(sort_per_frame > 0 && (j % sort_per_frame) == 0) {
            wait(0.05);
          }
        }

        prof_end("Array_sort");

        return array;
      }

      hide_notsolid() {
        if(!isDefined(self.oldContents)) {
          self.oldContents = self SetContents(0);
        }

        self Hide();
      }

      show_solid() {
        if(!isai(self)) {
          self Solid();
        }

        if(isDefined(self.oldContents)) {
          self SetContents(self.oldContents);
        }

        self Show();
      }

      SetLightingState(lightingState) {
        allEnts = getEntArray();

        SetOmnvar("lighting_state", lightingState);

        if(!getdvarint("r_reflectionProbeGenerate")) {
          foreach(ent in allEnts) {
            if(isDefined(ent.lightingstate) && (ent.className == "script_brushmodel" || ent.className == "script_model")) {
              if(ent.lightingstate == 0) {} else if(ent.lightingstate == lightingState) {
                ent show_solid();
              } else {
                ent hide_notsolid();
              }
            }
          }
        }
      }