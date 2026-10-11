/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\engine\utility.gsc
***********************************************/

#using scripts\common\anim;
#using scripts\common\createfx;
#using scripts\common\exploder;
#using scripts\common\utility;
#using scripts\engine\flags;
#using scripts\engine\trace;
#namespace utility;

function noself_func(func, parm1, parm2, parm3, parm4) {
  if(!isDefined(level.func)) {
    return;
  }

  if(!isDefined(level.func[func])) {
    return;
  }

  if(isDefined(parm4)) {
    builtin[[level.func[func]]](parm1, parm2, parm3, parm4);
    return;
  }

  if(isDefined(parm3)) {
    builtin[[level.func[func]]](parm1, parm2, parm3);
    return;
  }

  if(isDefined(parm2)) {
    builtin[[level.func[func]]](parm1, parm2);
    return;
  }

  if(isDefined(parm1)) {
    builtin[[level.func[func]]](parm1);
    return;
  }

  builtin[[level.func[func]]]();
}

function noself_func_return(func, parm1, parm2, parm3, parm4) {
  if(!isDefined(level.func)) {
    return undefined;
  }

  if(!isDefined(level.func[func])) {
    return undefined;
  }

  if(isDefined(parm4)) {
    return builtin[[level.func[func]]](parm1, parm2, parm3, parm4);
  }

  if(isDefined(parm3)) {
    return builtin[[level.func[func]]](parm1, parm2, parm3);
  }

  if(isDefined(parm2)) {
    return builtin[[level.func[func]]](parm1, parm2);
  }

  if(isDefined(parm1)) {
    return builtin[[level.func[func]]](parm1);
  }

  return builtin[[level.func[func]]]();
}

function self_func(func, parm1, parm2, parm3, parm4, var_77895a5b8a625552) {
  if(!isDefined(level.func[func])) {
    return;
  }

  if(isDefined(var_77895a5b8a625552)) {
    return self builtin[[level.func[func]]](parm1, parm2, parm3, parm4, var_77895a5b8a625552);
  }

  if(isDefined(parm4)) {
    return self builtin[[level.func[func]]](parm1, parm2, parm3, parm4);
  }

  if(isDefined(parm3)) {
    return self builtin[[level.func[func]]](parm1, parm2, parm3);
  }

  if(isDefined(parm2)) {
    return self builtin[[level.func[func]]](parm1, parm2);
  }

  if(isDefined(parm1)) {
    return self builtin[[level.func[func]]](parm1);
  }

  return self builtin[[level.func[func]]]();
}

function script_func(func, parm1, parm2, parm3, parm4) {
  if(!isDefined(level.func[func])) {
    return;
  }

  if(isDefined(parm4)) {
    return self[[level.func[func]]](parm1, parm2, parm3, parm4);
  }

  if(isDefined(parm3)) {
    return self[[level.func[func]]](parm1, parm2, parm3);
  }

  if(isDefined(parm2)) {
    return self[[level.func[func]]](parm1, parm2);
  }

  if(isDefined(parm1)) {
    return self[[level.func[func]]](parm1);
  }

  return self[[level.func[func]]]();
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

function sign(x) {
  if(x >= 0) {
    return 1;
  }

  return -1;
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

function function_6174330574a2a273() {
  angle = randomfloat(360);
  dist = randomfloat(1);
  x = cos(angle) * dist;
  y = sin(angle) * dist;
  return (x, y, 0);
}

function function_d553466cf817a4da() {
  while(true) {
    x = randomfloatrange(-1, 1);
    y = randomfloatrange(-1, 1);

    if(x * x + y * y < 1) {
      return (x, y, 0);
    }
  }
}

function mod(dividend, divisor) {
  q = int(dividend / divisor);

  if(dividend * divisor < 0) {
    q -= 1;
  }

  return dividend - q * divisor;
}

function get_enemy_team(team) {
  assertex(team != "<dev string:x1c>", "<dev string:x27>");
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
  assertex(isDefined(probability), "<dev string:x46>");
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

function waittill_string(msg, ent) {
  if(msg != "death") {
    self endon("death");
  }

  ent endon("die");
  self waittill(msg);
  ent notify("returned", msg);
}

function waittillmatch_string(anim_name, msg, ent) {
  if(msg != "death") {
    self endon("death");
  }

  ent endon("die");
  self waittillmatch(anim_name, msg);
  ent notify("returned", msg);
}

function waittill_string_no_endon_death(msg, ent) {
  ent endon("die");
  self waittill(msg);
  ent notify("returned", msg);
}

function function_67e5ee8add8aafae(string, ent) {
  ent endon("die");
  self waittill(string, msg);
  ent notify("returned", msg);
}

function waittill_multiple(string1, string2, string3, string4, string5) {
  assertex(issp(), "<dev string:x6d>");
  self endon("death");
  ent = spawnStruct();
  ent.threads = 0;

  if(isDefined(string1)) {
    childthread waittill_string(string1, ent);
    ent.threads++;
  }

  if(isDefined(string2)) {
    childthread waittill_string(string2, ent);
    ent.threads++;
  }

  if(isDefined(string3)) {
    childthread waittill_string(string3, ent);
    ent.threads++;
  }

  if(isDefined(string4)) {
    childthread waittill_string(string4, ent);
    ent.threads++;
  }

  if(isDefined(string5)) {
    childthread waittill_string(string5, ent);
    ent.threads++;
  }

  while(ent.threads) {
    ent waittill("returned");
    ent.threads--;
  }

  ent notify("die");
}

function waittill_2(string1, string2) {
  self endon("death");
  ent = spawnStruct();
  ent.threads = 0;

  if(isDefined(string1)) {
    childthread waittill_string(string1, ent);
    ent.threads++;
  }

  if(isDefined(string2)) {
    childthread waittill_string(string2, ent);
    ent.threads++;
  }

  while(ent.threads) {
    ent waittill("returned");
    ent.threads--;
  }

  ent notify("die");
}

function waittillmatch_notify(anim_name, match_msg, notify_str) {
  self endon("death");
  self waittillmatch(anim_name, match_msg);
  self notify(notify_str);
}

function waittill_any_return_1(string1) {
  if(!isDefined(string1) || string1 != "death") {
    self endon("death");
  }

  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittill_string(string1, ent);
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_return_2(string1, string2) {
  if((!isDefined(string1) || string1 != "death") && (!isDefined(string2) || string2 != "death")) {
    self endon("death");
  }

  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittill_string(string1, ent);
  }

  if(isDefined(string2)) {
    childthread waittill_string(string2, ent);
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_return_3(string1, string2, string3) {
  if((!isDefined(string1) || string1 != "death") && (!isDefined(string2) || string2 != "death") && (!isDefined(string3) || string3 != "death")) {
    self endon("death");
  }

  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittill_string(string1, ent);
  }

  if(isDefined(string2)) {
    childthread waittill_string(string2, ent);
  }

  if(isDefined(string3)) {
    childthread waittill_string(string3, ent);
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_return_4(string1, string2, string3, string4) {
  if((!isDefined(string1) || string1 != "death") && (!isDefined(string2) || string2 != "death") && (!isDefined(string3) || string3 != "death") && (!isDefined(string4) || string4 != "death")) {
    self endon("death");
  }

  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittill_string(string1, ent);
  }

  if(isDefined(string2)) {
    childthread waittill_string(string2, ent);
  }

  if(isDefined(string3)) {
    childthread waittill_string(string3, ent);
  }

  if(isDefined(string4)) {
    childthread waittill_string(string4, ent);
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_return_5(string1, string2, string3, string4, string5) {
  if((!isDefined(string1) || string1 != "death") && (!isDefined(string2) || string2 != "death") && (!isDefined(string3) || string3 != "death") && (!isDefined(string4) || string4 != "death") && (!isDefined(string5) || string5 != "death")) {
    self endon("death");
  }

  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittill_string(string1, ent);
  }

  if(isDefined(string2)) {
    childthread waittill_string(string2, ent);
  }

  if(isDefined(string3)) {
    childthread waittill_string(string3, ent);
  }

  if(isDefined(string4)) {
    childthread waittill_string(string4, ent);
  }

  if(isDefined(string5)) {
    childthread waittill_string(string5, ent);
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_return_6(string1, string2, string3, string4, string5, string6) {
  if((!isDefined(string1) || string1 != "death") && (!isDefined(string2) || string2 != "death") && (!isDefined(string3) || string3 != "death") && (!isDefined(string4) || string4 != "death") && (!isDefined(string5) || string5 != "death") && (!isDefined(string6) || string6 != "death")) {
    self endon("death");
  }

  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittill_string(string1, ent);
  }

  if(isDefined(string2)) {
    childthread waittill_string(string2, ent);
  }

  if(isDefined(string3)) {
    childthread waittill_string(string3, ent);
  }

  if(isDefined(string4)) {
    childthread waittill_string(string4, ent);
  }

  if(isDefined(string5)) {
    childthread waittill_string(string5, ent);
  }

  if(isDefined(string6)) {
    childthread waittill_string(string6, ent);
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_return_7(string1, string2, string3, string4, string5, string6, string7) {
  if((!isDefined(string1) || string1 != "death") && (!isDefined(string2) || string2 != "death") && (!isDefined(string3) || string3 != "death") && (!isDefined(string4) || string4 != "death") && (!isDefined(string5) || string5 != "death") && (!isDefined(string6) || string6 != "death") && (!isDefined(string7) || string7 != "death")) {
    self endon("death");
  }

  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittill_string(string1, ent);
  }

  if(isDefined(string2)) {
    childthread waittill_string(string2, ent);
  }

  if(isDefined(string3)) {
    childthread waittill_string(string3, ent);
  }

  if(isDefined(string4)) {
    childthread waittill_string(string4, ent);
  }

  if(isDefined(string5)) {
    childthread waittill_string(string5, ent);
  }

  if(isDefined(string6)) {
    childthread waittill_string(string6, ent);
  }

  if(isDefined(string7)) {
    childthread waittill_string(string7, ent);
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_return(string1, string2, string3, string4, string5, string6, string7, string8) {
  assertex(issp(), "<dev string:xd6>");

  if((!isDefined(string1) || string1 != "death") && (!isDefined(string2) || string2 != "death") && (!isDefined(string3) || string3 != "death") && (!isDefined(string4) || string4 != "death") && (!isDefined(string5) || string5 != "death") && (!isDefined(string6) || string6 != "death") && (!isDefined(string7) || string7 != "death") && (!isDefined(string8) || string8 != "death")) {
    self endon("death");
  }

  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittill_string(string1, ent);
  }

  if(isDefined(string2)) {
    childthread waittill_string(string2, ent);
  }

  if(isDefined(string3)) {
    childthread waittill_string(string3, ent);
  }

  if(isDefined(string4)) {
    childthread waittill_string(string4, ent);
  }

  if(isDefined(string5)) {
    childthread waittill_string(string5, ent);
  }

  if(isDefined(string6)) {
    childthread waittill_string(string6, ent);
  }

  if(isDefined(string7)) {
    childthread waittill_string(string7, ent);
  }

  if(isDefined(string8)) {
    childthread waittill_string(string8, ent);
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittillmatch_any_return(animstring, string1, string2, string3, string4, string5, string6) {
  if((!isDefined(string1) || string1 != "death") && (!isDefined(string2) || string2 != "death") && (!isDefined(string3) || string3 != "death") && (!isDefined(string4) || string4 != "death") && (!isDefined(string5) || string5 != "death") && (!isDefined(string6) || string6 != "death")) {
    self endon("death");
  }

  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittillmatch_string(animstring, string1, ent);
  }

  if(isDefined(string2)) {
    childthread waittillmatch_string(animstring, string2, ent);
  }

  if(isDefined(string3)) {
    childthread waittillmatch_string(animstring, string3, ent);
  }

  if(isDefined(string4)) {
    childthread waittillmatch_string(animstring, string4, ent);
  }

  if(isDefined(string5)) {
    childthread waittillmatch_string(animstring, string5, ent);
  }

  if(isDefined(string6)) {
    childthread waittillmatch_string(animstring, string6, ent);
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_return_no_endon_death_1(string1) {
  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittill_string_no_endon_death(string1, ent);
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_return_no_endon_death_2(string1, string2) {
  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittill_string_no_endon_death(string1, ent);
  }

  if(isDefined(string2)) {
    childthread waittill_string_no_endon_death(string2, ent);
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_return_no_endon_death_3(string1, string2, string3) {
  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittill_string_no_endon_death(string1, ent);
  }

  if(isDefined(string2)) {
    childthread waittill_string_no_endon_death(string2, ent);
  }

  if(isDefined(string3)) {
    childthread waittill_string_no_endon_death(string3, ent);
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_return_no_endon_death_4(string1, string2, string3, string4) {
  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittill_string_no_endon_death(string1, ent);
  }

  if(isDefined(string2)) {
    childthread waittill_string_no_endon_death(string2, ent);
  }

  if(isDefined(string3)) {
    childthread waittill_string_no_endon_death(string3, ent);
  }

  if(isDefined(string4)) {
    childthread waittill_string_no_endon_death(string4, ent);
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_return_no_endon_death_5(string1, string2, string3, string4, string5) {
  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittill_string_no_endon_death(string1, ent);
  }

  if(isDefined(string2)) {
    childthread waittill_string_no_endon_death(string2, ent);
  }

  if(isDefined(string3)) {
    childthread waittill_string_no_endon_death(string3, ent);
  }

  if(isDefined(string4)) {
    childthread waittill_string_no_endon_death(string4, ent);
  }

  if(isDefined(string5)) {
    childthread waittill_string_no_endon_death(string5, ent);
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_return_no_endon_death_6(string1, string2, string3, string4, string5, string6) {
  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittill_string_no_endon_death(string1, ent);
  }

  if(isDefined(string2)) {
    childthread waittill_string_no_endon_death(string2, ent);
  }

  if(isDefined(string3)) {
    childthread waittill_string_no_endon_death(string3, ent);
  }

  if(isDefined(string4)) {
    childthread waittill_string_no_endon_death(string4, ent);
  }

  if(isDefined(string5)) {
    childthread waittill_string_no_endon_death(string5, ent);
  }

  if(isDefined(string6)) {
    childthread waittill_string_no_endon_death(string6, ent);
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function function_efe4706df8361219(string1, string2, string3, string4, string5, string6, string7) {
  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittill_string_no_endon_death(string1, ent);
  }

  if(isDefined(string2)) {
    childthread waittill_string_no_endon_death(string2, ent);
  }

  if(isDefined(string3)) {
    childthread waittill_string_no_endon_death(string3, ent);
  }

  if(isDefined(string4)) {
    childthread waittill_string_no_endon_death(string4, ent);
  }

  if(isDefined(string5)) {
    childthread waittill_string_no_endon_death(string5, ent);
  }

  if(isDefined(string6)) {
    childthread waittill_string_no_endon_death(string6, ent);
  }

  if(isDefined(string7)) {
    childthread waittill_string_no_endon_death(string7, ent);
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_return_no_endon_death(string1, string2, string3, string4, string5, string6) {
  assertex(issp(), "<dev string:xd6>");
  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittill_string_no_endon_death(string1, ent);
  }

  if(isDefined(string2)) {
    childthread waittill_string_no_endon_death(string2, ent);
  }

  if(isDefined(string3)) {
    childthread waittill_string_no_endon_death(string3, ent);
  }

  if(isDefined(string4)) {
    childthread waittill_string_no_endon_death(string4, ent);
  }

  if(isDefined(string5)) {
    childthread waittill_string_no_endon_death(string5, ent);
  }

  if(isDefined(string6)) {
    childthread waittill_string_no_endon_death(string6, ent);
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_in_array(string_array) {
  assertex(string_array.size > 0, "<dev string:x141>");

  for(i = 0; i < string_array.size - 1; i++) {
    self endon(string_array[i]);
  }

  self waittill(string_array[string_array.size - 1]);
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
    string_array = array_remove(string_array, msg);
  }
}

function waittill_any_timeout_1(timeout, string1) {
  if(!isDefined(string1) || string1 != "death") {
    self endon("death");
  }

  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittill_string(string1, ent);
  }

  ent childthread timeout_struct(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_timeout_2(timeout, string1, string2) {
  if((!isDefined(string1) || string1 != "death") && (!isDefined(string2) || string2 != "death")) {
    self endon("death");
  }

  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittill_string(string1, ent);
  }

  if(isDefined(string2)) {
    childthread waittill_string(string2, ent);
  }

  ent childthread timeout_struct(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_timeout_3(timeout, string1, string2, string3) {
  if((!isDefined(string1) || string1 != "death") && (!isDefined(string2) || string2 != "death") && (!isDefined(string3) || string3 != "death")) {
    self endon("death");
  }

  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittill_string(string1, ent);
  }

  if(isDefined(string2)) {
    childthread waittill_string(string2, ent);
  }

  if(isDefined(string3)) {
    childthread waittill_string(string3, ent);
  }

  ent childthread timeout_struct(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_timeout_4(timeout, string1, string2, string3, string4) {
  if((!isDefined(string1) || string1 != "death") && (!isDefined(string2) || string2 != "death") && (!isDefined(string3) || string3 != "death") && (!isDefined(string4) || string4 != "death")) {
    self endon("death");
  }

  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittill_string(string1, ent);
  }

  if(isDefined(string2)) {
    childthread waittill_string(string2, ent);
  }

  if(isDefined(string3)) {
    childthread waittill_string(string3, ent);
  }

  if(isDefined(string4)) {
    childthread waittill_string(string4, ent);
  }

  ent childthread timeout_struct(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_timeout_5(timeout, string1, string2, string3, string4, string5) {
  if((!isDefined(string1) || string1 != "death") && (!isDefined(string2) || string2 != "death") && (!isDefined(string3) || string3 != "death") && (!isDefined(string4) || string4 != "death") && (!isDefined(string5) || string5 != "death")) {
    self endon("death");
  }

  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittill_string(string1, ent);
  }

  if(isDefined(string2)) {
    childthread waittill_string(string2, ent);
  }

  if(isDefined(string3)) {
    childthread waittill_string(string3, ent);
  }

  if(isDefined(string4)) {
    childthread waittill_string(string4, ent);
  }

  if(isDefined(string5)) {
    childthread waittill_string(string5, ent);
  }

  ent childthread timeout_struct(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_timeout_6(timeout, string1, string2, string3, string4, string5, string6) {
  if((!isDefined(string1) || string1 != "death") && (!isDefined(string2) || string2 != "death") && (!isDefined(string3) || string3 != "death") && (!isDefined(string4) || string4 != "death") && (!isDefined(string5) || string5 != "death") && (!isDefined(string6) || string6 != "death")) {
    self endon("death");
  }

  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittill_string(string1, ent);
  }

  if(isDefined(string2)) {
    childthread waittill_string(string2, ent);
  }

  if(isDefined(string3)) {
    childthread waittill_string(string3, ent);
  }

  if(isDefined(string4)) {
    childthread waittill_string(string4, ent);
  }

  if(isDefined(string5)) {
    childthread waittill_string(string5, ent);
  }

  if(isDefined(string6)) {
    childthread waittill_string(string6, ent);
  }

  ent childthread timeout_struct(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_timeout(timeout, string1, string2, string3, string4, string5, string6) {
  assertex(issp(), "<dev string:x16c>");

  if((!isDefined(string1) || string1 != "death") && (!isDefined(string2) || string2 != "death") && (!isDefined(string3) || string3 != "death") && (!isDefined(string4) || string4 != "death") && (!isDefined(string5) || string5 != "death") && (!isDefined(string6) || string6 != "death")) {
    self endon("death");
  }

  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittill_string(string1, ent);
  }

  if(isDefined(string2)) {
    childthread waittill_string(string2, ent);
  }

  if(isDefined(string3)) {
    childthread waittill_string(string3, ent);
  }

  if(isDefined(string4)) {
    childthread waittill_string(string4, ent);
  }

  if(isDefined(string5)) {
    childthread waittill_string(string5, ent);
  }

  if(isDefined(string6)) {
    childthread waittill_string(string6, ent);
  }

  ent childthread timeout_struct(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function timeout_struct(delay) {
  self endon("die");
  wait delay;
  self notify("returned", "timeout");
}

function waittill_any_timeout_no_endon_death_1(timeout, string1) {
  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittill_string_no_endon_death(string1, ent);
  }

  ent childthread timeout_struct(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_timeout_no_endon_death_2(timeout, string1, string2) {
  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittill_string_no_endon_death(string1, ent);
  }

  if(isDefined(string2)) {
    childthread waittill_string_no_endon_death(string2, ent);
  }

  ent childthread timeout_struct(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_timeout_no_endon_death_3(timeout, string1, string2, string3) {
  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittill_string_no_endon_death(string1, ent);
  }

  if(isDefined(string2)) {
    childthread waittill_string_no_endon_death(string2, ent);
  }

  if(isDefined(string3)) {
    childthread waittill_string_no_endon_death(string3, ent);
  }

  ent childthread timeout_struct(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_timeout_no_endon_death_4(timeout, string1, string2, string3, string4) {
  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittill_string_no_endon_death(string1, ent);
  }

  if(isDefined(string2)) {
    childthread waittill_string_no_endon_death(string2, ent);
  }

  if(isDefined(string3)) {
    childthread waittill_string_no_endon_death(string3, ent);
  }

  if(isDefined(string4)) {
    childthread waittill_string_no_endon_death(string4, ent);
  }

  ent childthread timeout_struct(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_timeout_no_endon_death_5(timeout, string1, string2, string3, string4, string5) {
  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittill_string_no_endon_death(string1, ent);
  }

  if(isDefined(string2)) {
    childthread waittill_string_no_endon_death(string2, ent);
  }

  if(isDefined(string3)) {
    childthread waittill_string_no_endon_death(string3, ent);
  }

  if(isDefined(string4)) {
    childthread waittill_string_no_endon_death(string4, ent);
  }

  if(isDefined(string5)) {
    childthread waittill_string_no_endon_death(string5, ent);
  }

  ent childthread timeout_struct(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_timeout_no_endon_death(timeout, string1, string2, string3, string4, string5) {
  assertex(issp(), "<dev string:x1d8>");
  ent = spawnStruct();

  if(isDefined(string1)) {
    childthread waittill_string_no_endon_death(string1, ent);
  }

  if(isDefined(string2)) {
    childthread waittill_string_no_endon_death(string2, ent);
  }

  if(isDefined(string3)) {
    childthread waittill_string_no_endon_death(string3, ent);
  }

  if(isDefined(string4)) {
    childthread waittill_string_no_endon_death(string4, ent);
  }

  if(isDefined(string5)) {
    childthread waittill_string_no_endon_death(string5, ent);
  }

  ent childthread timeout_struct(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_2(string1, string2) {
  assert(isDefined(string1));

  if(isDefined(string2)) {
    self endon(string2);
  }

  self waittill(string1);
}

function waittill_any_3(string1, string2, string3) {
  assert(isDefined(string1));

  if(isDefined(string2)) {
    self endon(string2);
  }

  if(isDefined(string3)) {
    self endon(string3);
  }

  self waittill(string1);
}

function waittill_any_4(string1, string2, string3, string4) {
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

  self waittill(string1);
}

function waittill_any_5(string1, string2, string3, string4, string5) {
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

  self waittill(string1);
}

function waittill_any_6(string1, string2, string3, string4, string5, string6) {
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

  self waittill(string1);
}

function waittill_any_7(string1, string2, string3, string4, string5, string6, string7) {
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

  self waittill(string1);
}

function waittill_any_8(string1, string2, string3, string4, string5, string6, string7, string8) {
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

function waittill_any(string1, string2, string3, string4, string5, string6, string7, string8) {
  assertex(issp(), "<dev string:xd6>");
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

function function_cf308f348d516c65(delay, ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7) {
  assert(isDefined(delay));
  assert(isDefined(ent1));
  assert(isDefined(string1));
  ent1 endon(string1);

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

  wait delay;
}

function waittill_any_ents_return(ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7) {
  assert(isDefined(ent1));
  assert(isDefined(string1));
  self endon("death");
  ent = spawnStruct();
  ent1 childthread waittill_string(string1, ent);

  if(isDefined(ent2) && isDefined(string2)) {
    ent2 childthread waittill_string(string2, ent);
  }

  if(isDefined(ent3) && isDefined(string3)) {
    ent3 childthread waittill_string(string3, ent);
  }

  if(isDefined(ent4) && isDefined(string4)) {
    ent4 childthread waittill_string(string4, ent);
  }

  if(isDefined(ent5) && isDefined(string5)) {
    ent5 childthread waittill_string(string5, ent);
  }

  if(isDefined(ent6) && isDefined(string6)) {
    ent6 childthread waittill_string(string6, ent);
  }

  if(isDefined(ent7) && isDefined(string7)) {
    ent7 childthread waittill_string(string7, ent);
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function function_7b9e0e7ca4b3b940(ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7) {
  assert(isDefined(ent1));
  assert(isDefined(string1));
  self endon("death");
  ent = spawnStruct();
  ent1 childthread waittill_string_no_endon_death(string1, ent);

  if(isDefined(ent2) && isDefined(string2)) {
    ent2 childthread waittill_string_no_endon_death(string2, ent);
  }

  if(isDefined(ent3) && isDefined(string3)) {
    ent3 childthread waittill_string_no_endon_death(string3, ent);
  }

  if(isDefined(ent4) && isDefined(string4)) {
    ent4 childthread waittill_string_no_endon_death(string4, ent);
  }

  if(isDefined(ent5) && isDefined(string5)) {
    ent5 childthread waittill_string_no_endon_death(string5, ent);
  }

  if(isDefined(ent6) && isDefined(string6)) {
    ent6 childthread waittill_string_no_endon_death(string6, ent);
  }

  if(isDefined(ent7) && isDefined(string7)) {
    ent7 childthread waittill_string_no_endon_death(string7, ent);
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function function_e6583be4abd3e438(ents, string) {
  assert(isDefined(ents));
  assert(isDefined(string));
  self endon("death");
  dummyent = spawnStruct();

  foreach(ent in ents) {
    ent childthread function_67e5ee8add8aafae(string, dummyent);
  }

  dummyent waittill("returned", msg);
  dummyent notify("die");
  return msg;
}

function waittill_any_ents_array(ents, string1, string2, string3, string4, string5, string6, string7) {
  assert(isDefined(ents));
  assert(isarray(ents));
  assert(isDefined(ents[0]));
  assert(isDefined(string1));

  foreach(ent in ents) {
    if(ent != ents[0]) {
      ent endon(string1);
    }

    if(isDefined(string2)) {
      ent endon(string2);
    }

    if(isDefined(string3)) {
      ent endon(string3);
    }

    if(isDefined(string4)) {
      ent endon(string4);
    }

    if(isDefined(string5)) {
      ent endon(string5);
    }

    if(isDefined(string6)) {
      ent endon(string6);
    }

    if(isDefined(string7)) {
      ent endon(string7);
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
  if(!isDefined(level.flag)) {
    return false;
  }

  return isDefined(level.flag[message]);
}

function flag(message) {
  assertex(isDefined(message), "<dev string:x253>");
  return flag_exist(message) && level.flag[message];
}

function flag_init(message) {
  if(!isDefined(level.flag)) {
    scripts\engine\flags::init_flags();
  }

  if(isDefined(level.first_frame) && level.first_frame == -1) {
    assertex(!isDefined(level.flag[message]), "<dev string:x288>" + message);
  }

  level.flag[message] = 0;
  init_trigger_flags();

  if(!isDefined(level.trigger_flags[message])) {
    level.trigger_flags[message] = [];
  }
}

function empty_init_func(empty) {}

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

function flag_wait(msg) {
  other = undefined;

  while(!flag(msg)) {
    other = undefined;
    level waittill(msg, other);
  }

  if(isDefined(other)) {
    return other;
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

function function_ef5098111fa4ae2c(flags) {
  flags = array_removeundefined(flags);

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

function flag_waitopen_any(flag1, flag2, flag3, flag4, flag5, flag6, flag7, flag8) {
  array = [flag1, flag2, flag3, flag4, flag5, flag6, flag7, flag8];
  function_ef5098111fa4ae2c(array);
}

function flag_waitopen_either(flag1, flag2) {
  while(true) {
    if(!flag(flag1) || !flag(flag2)) {
      return;
    }

    level waittill_any_2(flag1, flag2);
  }
}

function waittill_either(msg1, msg2) {
  self endon(msg1);
  self waittill(msg2);
  return msg2;
}

function trigger_on(name, type) {
  if(isDefined(name) && isDefined(type)) {
    ents = getEntArray(name, type);
    array_thread(ents, &trigger_on_proc);
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

  level.trigger_flags[msg] = array_removeundefined(level.trigger_flags[msg]);
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

  [[level.trigger_func[true_on && false_on]]]();
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
  assertex(isDefined(level.struct_class_names), "<dev string:x2b3>");

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

  if(isDefined(struct.variantname)) {
    if(!isDefined(level.struct_class_names["variantname"][struct.variantname])) {
      level.struct_class_names["variantname"][struct.variantname] = [];
    }

    size = level.struct_class_names["variantname"][struct.variantname].size;
    level.struct_class_names["variantname"][struct.variantname][size] = struct;
  }
}

function getStruct(name, type) {
  assertex(isDefined(name) && isDefined(type), "<dev string:x2e6>");
  assertex(isDefined(level.struct_class_names), "<dev string:x307>");
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

    assertmsg("<dev string:x33a>" + type + "<dev string:x36f>" + name + "<dev string:x37d>" + originstr1 + "<dev string:x3b3>" + originstr2);
    return undefined;
  }

  return array[0];
}

function getStructArray(name, type) {
  if(!isDefined(level.struct_class_names)) {
    assertex(isDefined(level.struct_class_names), "<dev string:x307>");
    return [];
  }

  if(!isDefined(type) || !isDefined(name)) {
    return [];
  }

  array = level.struct_class_names[type][name];

  if(!isDefined(array)) {
    return [];
  }

  return array;
}

function function_e89fc5f3b8084c2b(struct) {
  if(!isDefined(struct.var_88446e27ec9c8ed7)) {
    return;
  }

  if(!isDefined(level._fx)) {
    level._fx = spawnStruct();
  }

  if(!isDefined(level._fx.ambientwar)) {
    level._fx.ambientwar = spawnStruct();
  }

  if(!isDefined(level._fx.ambientwar.nodes)) {
    level._fx.ambientwar.nodes = [];
  }

  if(!isDefined(level._fx.ambientwar.nodes[struct.var_88446e27ec9c8ed7])) {
    level._fx.ambientwar.nodes[struct.var_88446e27ec9c8ed7] = [];
  }

  node = spawnStruct();
  node.origin = struct.origin;
  node.angles = struct.angles;

  if(isDefined(struct.var_9e2bbe262ca3c265)) {
    node.var_9e2bbe262ca3c265 = struct.var_9e2bbe262ca3c265;
  }

  if(isDefined(struct.var_975a876c9c8ced9d)) {
    node.var_975a876c9c8ced9d = struct.var_975a876c9c8ced9d;
  }

  if(isDefined(struct.var_48f95e175a12d9c4)) {
    node.var_48f95e175a12d9c4 = struct.var_48f95e175a12d9c4;
  }

  if(isDefined(struct.var_22ff57eef960b294)) {
    node.var_22ff57eef960b294 = struct.var_22ff57eef960b294;
  }

  level._fx.ambientwar.nodes[struct.var_88446e27ec9c8ed7][level._fx.ambientwar.nodes[struct.var_88446e27ec9c8ed7].size] = node;
}

function add_smartobject_point(struct) {
  if(!isDefined(anim.smartobjectpoints)) {
    anim.smartobjectpoints = [];
  }

  anim.smartobjectpoints[anim.smartobjectpoints.size] = struct;
  volumeidx = function_6bf2b684ed87ad5e(struct.origin);

  if(!isDefined(volumeidx)) {
    return;
  }

  if(!isDefined(anim.var_463c0093dff0f81c)) {
    anim.var_463c0093dff0f81c = [];
  }

  if(!isDefined(anim.var_463c0093dff0f81c[volumeidx])) {
    anim.var_463c0093dff0f81c[volumeidx] = [];
  }

  anim.var_463c0093dff0f81c[volumeidx][anim.var_463c0093dff0f81c[volumeidx].size] = struct;
}

function store_linked_smartobjects() {
  if(!isDefined(anim.smartobjectpoints)) {
    return;
  }

  foreach(obj in anim.smartobjectpoints) {
    if(isDefined(obj.script_linkto)) {
      structs = obj get_linked_structs();

      foreach(linkedstruct in structs) {
        if(linkedstruct == obj) {
          continue;
        }

        if(!isDefined(linkedstruct.script_smartobject)) {
          continue;
        }

        if(!isDefined(obj.linkedsmartobjects)) {
          obj.linkedsmartobjects = [];
        }

        obj.linkedsmartobjects[obj.linkedsmartobjects.size] = linkedstruct;
      }
    }
  }
}

function init_struct_class() {
  if(!add_init_script("struct_classes", &init_struct_class)) {
    return;
  }

  level.struct_class_names = [];
  level.struct_class_names["target"] = [];
  level.struct_class_names["targetname"] = [];
  level.struct_class_names["script_noteworthy"] = [];
  level.struct_class_names["script_linkname"] = [];
  level.struct_class_names["variantname"] = [];
  level.struct_exploders = [];
  level.struct_fakeactors = [];
  level.a_scene_names = [];
  level.var_a0b4eb1703be349a = [];
  filterfunc = level.struct_filter;
  hasfilterfunc = isDefined(filterfunc);

  foreach(index, struct in level.struct) {
    if(istrue(struct.var_d63b146db6138e15)) {
      continue;
    }

    if(isDefined(struct.script_smartobject)) {
      add_smartobject_point(struct);
    }

    if(hasfilterfunc && ![[filterfunc]](struct)) {
      continue;
    }

    if(isDefined(struct.targetname) && struct.targetname == "delete_on_load") {
      continue;
    }

    if(isDefined(struct.script_prefab_exploder) || isDefined(struct.script_exploder)) {
      level.struct_exploders[level.struct_exploders.size] = struct;
    }

    if(isDefined(struct.script_fakeactor_node)) {
      level.struct_fakeactors[level.struct_fakeactors.size] = struct;
    }

    if(isDefined(struct.script_scenescriptbundle)) {
      level.a_scene_names[level.a_scene_names.size] = struct.script_scenescriptbundle;
      level.var_a0b4eb1703be349a[level.var_a0b4eb1703be349a.size] = struct;
    }

    if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "vfx_ambientwar_node") {
      function_e89fc5f3b8084c2b(struct);
      continue;
    }

    addstruct(struct);
    level.struct[index] = undefined;
  }

  level.struct = undefined;

  if(isDefined(level.var_b32e30f2a469bc5c)) {
    level thread[[level.var_b32e30f2a469bc5c]]();
    level.var_b32e30f2a469bc5c = undefined;
  }

  store_linked_smartobjects();
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

  if(isDefined(value) && isDefined(level.struct_class_names["script_linkname"]) && isDefined(level.struct_class_names["script_linkname"][value])) {
    foreach(i, _struct in level.struct_class_names["script_linkname"][value]) {
      if(isDefined(_struct) && struct == _struct) {
        level.struct_class_names["script_linkname"][value][i] = undefined;
      }
    }

    if(level.struct_class_names["script_linkname"][value].size == 0) {
      level.struct_class_names["script_linkname"][value] = undefined;
    }
  }

  value = struct.script_noteworthy;

  if(isDefined(value) && isDefined(level.struct_class_names["script_noteworthy"]) && isDefined(level.struct_class_names["script_noteworthy"][value])) {
    foreach(i, _struct in level.struct_class_names["script_noteworthy"][value]) {
      if(isDefined(_struct) && struct == _struct) {
        level.struct_class_names["script_noteworthy"][value][i] = undefined;
      }
    }

    if(level.struct_class_names["script_noteworthy"][value].size == 0) {
      level.struct_class_names["script_noteworthy"][value] = undefined;
    }
  }

  value = struct.target;

  if(isDefined(value) && isDefined(level.struct_class_names["target"]) && isDefined(level.struct_class_names["target"][value])) {
    foreach(i, _struct in level.struct_class_names["target"][value]) {
      if(isDefined(_struct) && struct == _struct) {
        level.struct_class_names["target"][value][i] = undefined;
      }
    }

    if(level.struct_class_names["target"][value].size == 0) {
      level.struct_class_names["target"][value] = undefined;
    }
  }

  value = struct.targetname;

  if(isDefined(value) && isDefined(level.struct_class_names["targetname"]) && isDefined(level.struct_class_names["targetname"][value])) {
    foreach(i, _struct in level.struct_class_names["targetname"][value]) {
      if(isDefined(_struct) && struct == _struct) {
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

  delay = ter_op(isDefined(delay), delay, 0);
  delay = ter_op(delay > 0, delay, 0);

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

function function_a5079b5837467402(name, key, ignore_spawners) {
  ents = getEntArray(name, key, default_to(ignore_spawners, 0));

  if(isDefined(level.struct_class_names)) {
    ents = array_combine(ents, getStructArray(name, key));
  }

  return ents;
}

function getent_or_struct(name, key, ignore_spawners) {
  ent = getEnt(name, key, default_to(ignore_spawners, 0));

  if(isDefined(ent)) {
    return ent;
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

function fileprint_map_header(binclude_blank_worldspawn) {
  if(!isDefined(binclude_blank_worldspawn)) {
    binclude_blank_worldspawn = 0;
  }

  fileprint_launcher( "<dev string:x3bc>" );
  fileprint_launcher( "<dev string:x3c7>" );
  fileprint_launcher( "<dev string:x3e5>" );

  if(!binclude_blank_worldspawn) {
    return;
  }

  fileprint_map_entity_start();
  fileprint_map_keypairprint("<dev string:x3f8>", "<dev string:x405>");
  fileprint_map_entity_end();
}

function fileprint_map_keypairprint(key1, key2) {
  fileprint_launcher( "<dev string:x413>" + key1 + "<dev string:x418>" + key2 + "<dev string:x413>" );
}

function fileprint_map_entity_start() {
  assert(isDefined(level.fileprint_mapentcount), "<dev string:x41f>");
  assert(!isDefined(level.fileprint_entitystart));
  level.fileprint_entitystart = 1;
  fileprint_launcher( "<dev string:x457>" + level.fileprint_mapentcount );
  fileprint_launcher( "<dev string:x462>" );
  level.fileprint_mapentcount++;
}

function fileprint_map_entity_end() {
  fileprint_launcher( "<dev string:x467>" );
  level.fileprint_entitystart = undefined;
}

function fileprint_radiant_vec(vector) {
  string = "<dev string:x46c>" + vector[0] + "<dev string:x470>" + vector[1] + "<dev string:x470>" + vector[2] + "<dev string:x46c>";
  return string;
}

function call_on_notify_no_endon_death(notifystring, method, param1, param2) {
  childthread call_on_notify_proc(notifystring, method, param1, param2);
}

function call_on_notify(notifystring, method, param1, param2, param3) {
  self endon("death");
  childthread call_on_notify_proc(notifystring, method, param1, param2, param3);
}

function call_on_notify_proc(notifystring, method, param1, param2, param3) {
  self waittill(notifystring);

  if(isDefined(param3)) {
    self builtin[[method]](param1, param2, param3);
    return;
  }

  if(isDefined(param2)) {
    self builtin[[method]](param1, param2);
    return;
  }

  if(isDefined(param1)) {
    self builtin[[method]](param1);
    return;
  }

  self builtin[[method]]();
}

function thread_on_notify_no_endon_death(notifystring, function, param1, param2, ent) {
  childthread thread_on_notify_proc(notifystring, function, param1, param2, ent);
}

function thread_on_notify(notifystring, function, param1, param2, ent, endonentities, endonmessages) {
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

  childthread thread_on_notify_proc(notifystring, function, param1, param2, ent);
}

function thread_on_notify_proc(notifystring, function, param1, param2, ent) {
  self waittill(notifystring);

  if(!isDefined(ent)) {
    ent = self;
  }

  if(isDefined(param2)) {
    ent thread[[function]](param1, param2);
    return;
  }

  if(isDefined(param1)) {
    ent thread[[function]](param1);
    return;
  }

  ent thread[[function]]();
}

function function_fb7b452e8dd1dddc(notifystring, function, params, ent, endonentities, endonmessages) {
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

  childthread function_399a710b148277ad(notifystring, function, params, ent);
}

function function_399a710b148277ad(notifystring, function, params, ent) {
  self waittill(notifystring);

  if(!isDefined(ent)) {
    ent = self;
  }

  if(!isDefined(params)) {
    ent thread[[function]]();
  }

  switch (params.size) {
    case 0:
      ent thread[[function]]();
      break;
    case 1:
      ent thread[[function]](params[0]);
      break;
    case 2:
      ent thread[[function]](params[0], params[1]);
      break;
    case 3:
      ent thread[[function]](params[0], params[1], params[2]);
      break;
    case 4:
      ent thread[[function]](params[0], params[1], params[2], params[3]);
      break;
    case 5:
      ent thread[[function]](params[0], params[1], params[2], params[3], params[4]);
      break;
    case 6:
      ent thread[[function]](params[0], params[1], params[2], params[3], params[4], params[5]);
      break;
    case 7:
      ent thread[[function]](params[0], params[1], params[2], params[3], params[4], params[5], params[6]);
      break;
    default:
      assertmsg("<dev string:x475>" + params.size + "<dev string:x4b4>");
      break;
  }
}

function delaycall(timer, func, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12) {
  thread delaycall_proc(func, undefined, timer, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12);
}

function delaycallendon(timer, endonevent, func, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12) {
  thread delaycall_proc(func, endonevent, timer, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12);
}

function delaycall_proc(func, endonevent, timer, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12) {
  if(issp() || iscp()) {
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

  if(isDefined(param12)) {
    self builtin[[func]](param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12);
    return;
  }

  if(isDefined(param11)) {
    self builtin[[func]](param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
    return;
  }

  if(isDefined(param10)) {
    self builtin[[func]](param1, param2, param3, param4, param5, param6, param7, param8, param9, param10);
    return;
  }

  if(isDefined(param9)) {
    self builtin[[func]](param1, param2, param3, param4, param5, param6, param7, param8, param9);
    return;
  }

  if(isDefined(param8)) {
    self builtin[[func]](param1, param2, param3, param4, param5, param6, param7, param8);
    return;
  }

  if(isDefined(param7)) {
    self builtin[[func]](param1, param2, param3, param4, param5, param6, param7);
    return;
  }

  if(isDefined(param6)) {
    self builtin[[func]](param1, param2, param3, param4, param5, param6);
    return;
  }

  if(isDefined(param5)) {
    self builtin[[func]](param1, param2, param3, param4, param5);
    return;
  }

  if(isDefined(param4)) {
    self builtin[[func]](param1, param2, param3, param4);
    return;
  }

  if(isDefined(param3)) {
    self builtin[[func]](param1, param2, param3);
    return;
  }

  if(isDefined(param2)) {
    self builtin[[func]](param1, param2);
    return;
  }

  if(isDefined(param1)) {
    self builtin[[func]](param1);
    return;
  }

  self builtin[[func]]();
}

function string_starts_with(string, start) {
  return isstartstr(string, start);
}

function string_join(str_array, separator) {
  assertex(isDefined(str_array), "<dev string:x4e6>");
  assertex(isDefined(str_array.size > 0), "<dev string:x500>");
  separator = default_to(separator, "");
  str = "";

  for(i = 0; i < str_array.size - 1; i++) {
    str += str_array[i] + separator;
  }

  return str + str_array[str_array.size - 1];
}

function string_split(str, separator) {
  assertex(isDefined(str), "<dev string:x51f>");
  assertex(isDefined(separator), "<dev string:x536>");

  if(str.size == 0) {
    return [];
  }

  array = [];
  start_index = 0;

  for(i = 0; i < str.size; i++) {
    if(str[i] == separator) {
      array = array_add(array, getsubstr(str, start_index, i));
      start_index = i + 1;
    }
  }

  array = array_add(array, getsubstr(str, start_index, str.size));
  return array;
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

    wait 0.05;
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

function array_add(array, object) {
  array[array.size] = object;
  return array;
}

function array_add_safe(array, object) {
  if(!isDefined(object)) {
    return array;
  }

  if(!isDefined(array)) {
    array[0] = object;
  } else {
    array[array.size] = object;
  }

  return array;
}

function function_6d6af8144a5131f1(array, object) {
  array = default_to(array, []);

  if(!arraycontains(array, object)) {
    array[array.size] = object;
  }

  return array;
}

function array_delete(array) {
  foreach(ent in array) {
    if(isDefined(ent)) {
      ent delete();
    }
  }
}

function array_insert(array, object, index) {
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

function function_ef4b3df86351aa00(array1, array2, index) {
  assertex(index >= 0, "<dev string:x553>");

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

function array_combine(array1, array2, array3, array4, array5) {
  array = [];

  if(isDefined(array1)) {
    foreach(item in array1) {
      array[array.size] = item;
    }
  }

  if(isDefined(array2)) {
    foreach(item in array2) {
      array[array.size] = item;
    }
  }

  if(isDefined(array3)) {
    foreach(item in array3) {
      array[array.size] = item;
    }
  }

  if(isDefined(array4)) {
    foreach(item in array4) {
      array[array.size] = item;
    }
  }

  if(isDefined(array5)) {
    foreach(item in array5) {
      array[array.size] = item;
    }
  }

  return array;
}

function array_combine_multiple(arr2d) {
  arr1d = [];

  foreach(arr in arr2d) {
    foreach(item in arr) {
      arr1d[arr1d.size] = item;
    }
  }

  return arr1d;
}

function array_combine_unique(array1, array2) {
  array3 = [];

  foreach(item in array1) {
    array3[array3.size] = item;
  }

  foreach(item in array2) {
    if(arraycontains(array3, item)) {
      continue;
    }

    array3[array3.size] = item;
  }

  return array3;
}

function array_combine_unique_keys(array1, array2) {
  foreach(key, item in array2) {
    if(!isDefined(array1[key])) {
      array1[key] = item;
    }
  }

  return array1;
}

function array_combine_non_integer_indices(array1, array2) {
  array3 = [];

  foreach(index, item in array1) {
    assert(!isDefined(array3[index]));
    array3[index] = item;
  }

  foreach(index, item in array2) {
    assert(!isDefined(array3[index]));
    array3[index] = item;
  }

  return array3;
}

function array_intersection(array1, array2) {
  array3 = [];

  foreach(item in array1) {
    if(arraycontains(array2, item)) {
      array3[array3.size] = item;
    }
  }

  return array3;
}

function array_difference(array1, array2) {
  array3 = [];

  foreach(item in array1) {
    if(!arraycontains(array2, item)) {
      array3[array3.size] = item;
    }
  }

  return array3;
}

function array_convert_keys_to_ints(array) {
  intarray = [];

  foreach(item in array) {
    intarray[intarray.size] = item;
  }

  return intarray;
}

function array_random(array) {
  if(array.size > 0) {
    random_index = randomint(array.size);
    return array[random_index];
  }

  return undefined;
}

function array_randomize(array) {
  for(i = 0; i < array.size - 1; i++) {
    j = randomintrange(i, array.size);
    temp = array[i];
    array[i] = array[j];
    array[j] = temp;
  }

  return array;
}

function function_1bb9ae4b5f3e2ab(array, seed, a, c, m) {
  if(!isDefined(array) || !isDefined(seed)) {
    assertmsg("<dev string:x57e>");
    return [];
  }

  x = seed;
  a = default_to(a, 29);
  c = default_to(c, 19);
  m = default_to(m, int(max(array.size, 41)));

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
        randomarray[ter_op(isstring(key), key, randomarray.size)] = object;
      } else {
        newarray[ter_op(isstring(key), key, newarray.size)] = object;
      }

      arraycount++;
    }
  }

  return randomarray;
}

function array_reverse(array) {
  array2 = [];

  for(i = array.size - 1; i >= 0; i--) {
    array2[array2.size] = array[i];
  }

  return array2;
}

function array_slice(array, startindex, endindex) {
  assert(isDefined(array) && isarray(array));
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

function array_contains(array, compare) {
  return arraycontains(array, compare);
}

function array_contains_key(array, key) {
  assertex(isarray(array), "<dev string:x5c3>");
  assertex(isDefined(key), "<dev string:x5f1>");
  return isDefined(array[key]);
}

function array_find(array, item) {
  foreach(idx, test in array) {
    if(test == item) {
      return idx;
    }
  }

  return undefined;
}

function array_remove(ents, remover) {
  return arrayremove(ents, remover);
}

function array_exclude(array, arrayexclude) {
  newarray = array;

  for(i = 0; i < arrayexclude.size; i++) {
    if(arraycontains(array, arrayexclude[i])) {
      newarray = array_remove(newarray, arrayexclude[i]);
    }
  }

  return newarray;
}

function array_remove_array(ents, remover_array) {
  foreach(remover in remover_array) {
    ents = array_remove(ents, remover);
  }

  return ents;
}

function array_remove_index(array, index, var_ca8b90cd9c832fd9) {
  newarray = [];

  foreach(arrayindex, value in array) {
    if(arrayindex == index) {
      continue;
    }

    if(istrue(var_ca8b90cd9c832fd9)) {
      newarray_index = arrayindex;
    } else {
      newarray_index = newarray.size;
    }

    newarray[newarray_index] = value;
  }

  return newarray;
}

function array_removeundefined(array, keepkeys) {
  newarray = [];
  keepkeys = default_to(keepkeys, 0);

  foreach(i, member in array) {
    if(!isDefined(member)) {
      continue;
    }

    if(keepkeys) {
      newarray[i] = member;
      continue;
    }

    newarray[newarray.size] = member;
  }

  return newarray;
}

function function_fdc9d5557c53078e(array, keepkeys) {
  newarray = [];
  keepkeys = default_to(keepkeys, 0);

  foreach(i, member in array) {
    if(!isDefined(member) || !isalive(member)) {
      continue;
    }

    if(keepkeys) {
      newarray[i] = member;
      continue;
    }

    newarray[newarray.size] = member;
  }

  return newarray;
}

function array_removedead(array, keepkeys) {
  newarray = [];
  keepkeys = default_to(keepkeys, 0);

  foreach(i, member in array) {
    if(!isalive(member)) {
      continue;
    }

    if(keepkeys) {
      newarray[i] = member;
      continue;
    }

    newarray[newarray.size] = member;
  }

  return newarray;
}

function array_remove_key(array, var_b3e77f92460be011) {
  newarray = [];

  foreach(key, item in array) {
    if(var_b3e77f92460be011 == key) {
      continue;
    }

    newarray[key] = item;
  }

  return newarray;
}

function array_remove_duplicates(array) {
  array_unique = [];

  foreach(item in array) {
    if(!isDefined(item)) {
      continue;
    }

    if(arraycontains(array_unique, item)) {
      continue;
    }

    array_unique[array_unique.size] = item;
  }

  return array_unique;
}

function array_get_first_item(array) {
  foreach(item in array) {
    return item;
  }

  return undefined;
}

function function_350e192b13bea45c(array) {
  last_item = undefined;

  foreach(item in array) {
    last_item = item;
  }

  return last_item;
}

function function_57091b2d67654a14(array, remover) {
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

function array_levelthread(array, process, var1, var2, var3) {
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

function array_levelcall(array, process, var1, var2, var3) {
  if(isDefined(var3)) {
    foreach(ent in array) {
      builtin[[process]](ent, var1, var2, var3);
    }

    return;
  }

  if(isDefined(var2)) {
    foreach(ent in array) {
      builtin[[process]](ent, var1, var2);
    }

    return;
  }

  if(isDefined(var1)) {
    foreach(ent in array) {
      builtin[[process]](ent, var1);
    }

    return;
  }

  foreach(ent in array) {
    builtin[[process]](ent);
  }
}

function array_sort_with_func(array, compare_func) {
  assertex(isDefined(array), "<dev string:x61e>");
  assertex(isDefined(compare_func), "<dev string:x634>");

  for(j = 1; j < array.size; j++) {
    key = array[j];

    for(i = j - 1; i >= 0 && ![[compare_func]](array[i], key); i--) {
      array[i + 1] = array[i];
    }

    array[i + 1] = key;
  }

  return array;
}

function array_sort_by_script_index(array) {
  sortedarray = [];

  for(index = 0; index < array.size; index++) {
    foreach(item in array) {
      if(is_equal(item.script_index, index)) {
        sortedarray = array_add(sortedarray, item);
      }
    }
  }

  remainingitems = array_remove_array(array, sortedarray);
  sortedarray = array_combine(sortedarray, remainingitems);
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

function function_427c36d659d2f67(array, var_d1f4456463c5272d, shouldthread) {
  if(!isDefined(shouldthread)) {
    shouldthread = 0;
  }

  assertex(isDefined(array) && isarray(array), "<dev string:x655>");
  assertex(isDefined(var_d1f4456463c5272d) && isfunction(var_d1f4456463c5272d), "<dev string:x682>");

  if(istrue(shouldthread)) {
    foreach(arrayobject in array) {
      self thread[[var_d1f4456463c5272d]](arrayobject);
    }

    return;
  }

  foreach(arrayobject in array) {
    self[[var_d1f4456463c5272d]](arrayobject);
  }
}

function function_ec65095e6f342856(array, var_d1f4456463c5272d, var_818871783e92735e, var_6fd8f67384dda4d0, iterationtimeinseconds, shouldthread) {
  if(!isDefined(var_818871783e92735e)) {
    var_818871783e92735e = undefined;
  }

  if(!isDefined(var_6fd8f67384dda4d0)) {
    var_6fd8f67384dda4d0 = undefined;
  }

  if(!isDefined(iterationtimeinseconds)) {
    iterationtimeinseconds = 5;
  }

  if(!isDefined(shouldthread)) {
    shouldthread = 0;
  }

  assertex(isDefined(array) && isarray(array), "<dev string:x655>");
  assertex(isDefined(var_d1f4456463c5272d) && isfunction(var_d1f4456463c5272d), "<dev string:x682>");
  var_7a73fce97b998437 = 0;

  if(isDefined(var_818871783e92735e) && isfunction(var_818871783e92735e)) {
    var_7a73fce97b998437 = 1;
  }

  var_344b31701913dda0 = array.size;
  var_609bfd613f331f2b = max(iterationtimeinseconds / level.framedurationseconds, 1);
  var_9e5988ae3851a115 = max(var_344b31701913dda0 / var_609bfd613f331f2b, 1);
  var_9e5988ae3851a115 = ceil(var_9e5988ae3851a115);
  var_dce766d46ccbf3d4 = 0;

  if(istrue(shouldthread)) {
    foreach(arrayobject in array) {
      var_e295a391c3f9155d = !var_7a73fce97b998437 || var_7a73fce97b998437 && self[[var_818871783e92735e]](arrayobject);

      if(var_e295a391c3f9155d) {
        self thread[[var_d1f4456463c5272d]](arrayobject);
      }

      var_dce766d46ccbf3d4++;

      if(var_dce766d46ccbf3d4 >= var_9e5988ae3851a115) {
        waitframe();
        var_dce766d46ccbf3d4 = 0;
      }
    }
  } else {
    foreach(arrayobject in array) {
      var_e295a391c3f9155d = !var_7a73fce97b998437 || var_7a73fce97b998437 && self[[var_818871783e92735e]](arrayobject);

      if(var_e295a391c3f9155d) {
        self[[var_d1f4456463c5272d]](arrayobject);
      }

      var_dce766d46ccbf3d4++;

      if(var_dce766d46ccbf3d4 >= var_9e5988ae3851a115) {
        waitframe();
        var_dce766d46ccbf3d4 = 0;
      }
    }
  }

  if(isDefined(var_6fd8f67384dda4d0) && isfunction(var_6fd8f67384dda4d0)) {
    self[[var_6fd8f67384dda4d0]]();
  }
}

function function_e81fabd6ea651c21(array, var_d1f4456463c5272d, shouldthread) {
  if(!isDefined(shouldthread)) {
    shouldthread = 0;
  }

  assertex(isDefined(array) && isarray(array), "<dev string:x655>");
  assertex(isDefined(var_d1f4456463c5272d) && isfunction(var_d1f4456463c5272d), "<dev string:x682>");

  if(istrue(shouldthread)) {
    for(index = 0; index < array.size; index++) {
      arrayobject = array[index];
      self thread[[var_d1f4456463c5272d]](arrayobject);
    }

    return;
  }

  for(index = 0; index < array.size; index++) {
    arrayobject = array[index];
    self[[var_d1f4456463c5272d]](arrayobject);
  }
}

function array_divide(array, divisor) {
  for(i = 0; i < array.size; i++) {
    array[i] /= divisor;
  }

  return array;
}

function function_fcd0e0af8e1d238d(a_ents, e_volume) {
  foreach(e_ent in a_ents) {
    if(!e_ent istouching(e_volume)) {
      return false;
    }
  }

  return true;
}

function function_ef2b4cd10b36a1ae(object) {
  return isDefined(object) && isPlayer(object);
}

function function_5a522719a7ec12b8(object) {
  return function_ef2b4cd10b36a1ae(object) && isalive(object);
}

function create_deck(item_array, autoshuffle, var_85dd38782ccc953e, prevent_redraw) {
  if(!isDefined(item_array)) {
    item_array = [];
  } else if(!isarray(item_array)) {
    item_array = [item_array];
  }

  deck = spawnStruct();
  deck.items = [];
  deck.index = 0;
  deck.autoshuffle = !isDefined(autoshuffle) || autoshuffle;
  deck.prevent_redraw = !isDefined(prevent_redraw) || prevent_redraw;

  foreach(item in item_array) {
    deck.items[deck.items.size] = item;
  }

  if(istrue(var_85dd38782ccc953e)) {
    deck deck_shuffle();
  }

  return deck;
}

function deck_draw() {
  assertex(isstruct(self) && isDefined(self.items) && isDefined(self.index), "<dev string:x6b3>");
  deck = self;

  if(deck.items.size == 0) {
    return undefined;
  }

  if(deck.index >= deck.items.size) {
    if(deck.autoshuffle) {
      deck deck_shuffle();
    } else {
      deck.index = 0;
    }
  }

  drawn_item = deck.items[deck.index];
  deck.index++;
  return drawn_item;
}

function deck_shuffle() {
  assertex(isstruct(self) && isDefined(self.items) && isDefined(self.index), "<dev string:x6f4>");
  deck = self;

  if(deck.index == 0 || !deck.prevent_redraw || deck.items.size <= 1) {
    deck.items = array_randomize(deck.items);
    deck.index = 0;
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
}

function random(array) {
  newarray = [];

  foreach(value in array) {
    newarray[newarray.size] = value;
  }

  if(!newarray.size) {
    return undefined;
  }

  return newarray[randomint(newarray.size)];
}

function random_key(array) {
  keys = getarraykeys(array);
  return random(keys);
}

function random_weighted(array, weights) {
  assertex(array.size == weights.size, "<dev string:x733>");
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

function function_a656c6dfb7dcb33a(struct_array) {
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

  var_ddcccbf258180536 = randomint(newarray.size * newarray.size);
  return newarray[newarray.size - 1 - int(sqrt(var_ddcccbf258180536))];
}

function alphabetize(array) {
  if(array.size <= 1) {
    return array;
  }

  count = 0;

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

function array_thread_amortized(entities, process, var_b2f6e3841e5273bf, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  thread function_d049f2bd4e2b0918(entities, process, var_b2f6e3841e5273bf, var1, var2, var3, var4, var5, var6, var7, var8, var9);
}

function function_d049f2bd4e2b0918(entities, process, var_b2f6e3841e5273bf, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(!isDefined(var1)) {
    foreach(ent in entities) {
      if(isai(ent) && !isalive(ent) || !isDefined(ent)) {
        continue;
      }

      ent thread[[process]]();
      wait var_b2f6e3841e5273bf;
    }

    return;
  }

  if(!isDefined(var2)) {
    foreach(ent in entities) {
      if(isai(ent) && !isalive(ent) || !isDefined(ent)) {
        continue;
      }

      ent thread[[process]](var1);
      wait var_b2f6e3841e5273bf;
    }

    return;
  }

  if(!isDefined(var3)) {
    foreach(ent in entities) {
      if(isai(ent) && !isalive(ent) || !isDefined(ent)) {
        continue;
      }

      ent thread[[process]](var1, var2);
      wait var_b2f6e3841e5273bf;
    }

    return;
  }

  if(!isDefined(var4)) {
    foreach(ent in entities) {
      if(isai(ent) && !isalive(ent) || !isDefined(ent)) {
        continue;
      }

      ent thread[[process]](var1, var2, var3);
      wait var_b2f6e3841e5273bf;
    }

    return;
  }

  if(!isDefined(var5)) {
    foreach(ent in entities) {
      if(isai(ent) && !isalive(ent) || !isDefined(ent)) {
        continue;
      }

      ent thread[[process]](var1, var2, var3, var4);
      wait var_b2f6e3841e5273bf;
    }

    return;
  }

  if(!isDefined(var6)) {
    foreach(ent in entities) {
      if(isai(ent) && !isalive(ent) || !isDefined(ent)) {
        continue;
      }

      ent thread[[process]](var1, var2, var3, var4, var5);
      wait var_b2f6e3841e5273bf;
    }

    return;
  }

  if(!isDefined(var7)) {
    foreach(ent in entities) {
      if(isai(ent) && !isalive(ent) || !isDefined(ent)) {
        continue;
      }

      ent thread[[process]](var1, var2, var3, var4, var5, var6);
      wait var_b2f6e3841e5273bf;
    }

    return;
  }

  if(!isDefined(var8)) {
    foreach(ent in entities) {
      if(isai(ent) && !isalive(ent) || !isDefined(ent)) {
        continue;
      }

      ent thread[[process]](var1, var2, var3, var4, var5, var6, var7);
      wait var_b2f6e3841e5273bf;
    }

    return;
  }

  if(!isDefined(var9)) {
    foreach(ent in entities) {
      if(isai(ent) && !isalive(ent) || !isDefined(ent)) {
        continue;
      }

      ent thread[[process]](var1, var2, var3, var4, var5, var6, var7, var8);
      wait var_b2f6e3841e5273bf;
    }

    return;
  }

  foreach(ent in entities) {
    if(isai(ent) && !isalive(ent) || !isDefined(ent)) {
      continue;
    }

    ent thread[[process]](var1, var2, var3, var4, var5, var6, var7, var8, var9);
    wait var_b2f6e3841e5273bf;
  }
}

function array_thread(entities, process, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(isDefined(var9)) {
    foreach(ent in entities) {
      ent thread[[process]](var1, var2, var3, var4, var5, var6, var7, var8, var9);
    }

    return;
  }

  if(isDefined(var8)) {
    foreach(ent in entities) {
      ent thread[[process]](var1, var2, var3, var4, var5, var6, var7, var8);
    }

    return;
  }

  if(isDefined(var7)) {
    foreach(ent in entities) {
      ent thread[[process]](var1, var2, var3, var4, var5, var6, var7);
    }

    return;
  }

  if(isDefined(var6)) {
    foreach(ent in entities) {
      ent thread[[process]](var1, var2, var3, var4, var5, var6);
    }

    return;
  }

  if(isDefined(var5)) {
    foreach(ent in entities) {
      ent thread[[process]](var1, var2, var3, var4, var5);
    }

    return;
  }

  if(isDefined(var4)) {
    foreach(ent in entities) {
      ent thread[[process]](var1, var2, var3, var4);
    }

    return;
  }

  if(isDefined(var3)) {
    foreach(ent in entities) {
      ent thread[[process]](var1, var2, var3);
    }

    return;
  }

  if(isDefined(var2)) {
    foreach(ent in entities) {
      ent thread[[process]](var1, var2);
    }

    return;
  }

  if(isDefined(var1)) {
    foreach(ent in entities) {
      ent thread[[process]](var1);
    }

    return;
  }

  foreach(ent in entities) {
    ent thread[[process]]();
  }
}

function function_9b971e1bc95bc1df(entities, process, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(isDefined(var9)) {
    foreach(ent in entities) {
      ent childthread[[process]](var1, var2, var3, var4, var5, var6, var7, var8, var9);
    }

    return;
  }

  if(isDefined(var8)) {
    foreach(ent in entities) {
      ent childthread[[process]](var1, var2, var3, var4, var5, var6, var7, var8);
    }

    return;
  }

  if(isDefined(var7)) {
    foreach(ent in entities) {
      ent childthread[[process]](var1, var2, var3, var4, var5, var6, var7);
    }

    return;
  }

  if(isDefined(var6)) {
    foreach(ent in entities) {
      ent childthread[[process]](var1, var2, var3, var4, var5, var6);
    }

    return;
  }

  if(isDefined(var5)) {
    foreach(ent in entities) {
      ent childthread[[process]](var1, var2, var3, var4, var5);
    }

    return;
  }

  if(isDefined(var4)) {
    foreach(ent in entities) {
      ent childthread[[process]](var1, var2, var3, var4);
    }

    return;
  }

  if(isDefined(var3)) {
    foreach(ent in entities) {
      ent childthread[[process]](var1, var2, var3);
    }

    return;
  }

  if(isDefined(var2)) {
    foreach(ent in entities) {
      ent childthread[[process]](var1, var2);
    }

    return;
  }

  if(isDefined(var1)) {
    foreach(ent in entities) {
      ent childthread[[process]](var1);
    }

    return;
  }

  foreach(ent in entities) {
    ent childthread[[process]]();
  }
}

function array_call(entities, process, var1, var2, var3, var4, var5, var6, var7, var8) {
  if(isDefined(var8)) {
    foreach(ent in entities) {
      ent builtin[[process]](var1, var2, var3, var4, var5, var6, var7, var8);
    }

    return;
  }

  if(isDefined(var7)) {
    foreach(ent in entities) {
      ent builtin[[process]](var1, var2, var3, var4, var5, var6, var7);
    }

    return;
  }

  if(isDefined(var6)) {
    foreach(ent in entities) {
      ent builtin[[process]](var1, var2, var3, var4, var5, var6);
    }

    return;
  }

  if(isDefined(var5)) {
    foreach(ent in entities) {
      ent builtin[[process]](var1, var2, var3, var4, var5);
    }

    return;
  }

  if(isDefined(var4)) {
    foreach(ent in entities) {
      ent builtin[[process]](var1, var2, var3, var4);
    }

    return;
  }

  if(isDefined(var3)) {
    foreach(ent in entities) {
      ent builtin[[process]](var1, var2, var3);
    }

    return;
  }

  if(isDefined(var2)) {
    foreach(ent in entities) {
      ent builtin[[process]](var1, var2);
    }

    return;
  }

  if(isDefined(var1)) {
    foreach(ent in entities) {
      ent builtin[[process]](var1);
    }

    return;
  }

  foreach(ent in entities) {
    ent builtin[[process]]();
  }
}

function function_1f9d89277519b570(job_funcs, arg_array) {
  assert(isarray(job_funcs));
  arg_array = default_to(arg_array, []);
  jobpool = spawnStruct();
  jobpool.alldonenotify = "all_workers_done";
  jobpool.pendingcount = job_funcs.size;

  for(i = 0; i < job_funcs.size; i++) {
    assert(isfunction(job_funcs[i]));
    jobpool childthread function_917573e92ca19878(self, job_funcs[i], arg_array);
  }

  if(jobpool.pendingcount == 0) {
    return;
  }

  jobpool waittill(jobpool.alldonenotify);
}

function private function_917573e92ca19878(ent, func, arg_array) {
  single_func_argarray(ent, func, arg_array);
  self.pendingcount -= 1;

  if(self.pendingcount == 0) {
    self notify(self.alldonenotify);
  }
}

function flat_angle(angle) {
  rangle = (0, angle[1], 0);
  return rangle;
}

function flat_origin(org) {
  rorg = (org[0], org[1], 0);
  return rorg;
}

function flatten_vector(var_cc24231b0f3f7333, up_vector) {
  if(!isDefined(up_vector)) {
    up_vector = (0, 0, 1);
  }

  flat_vec = vectorNormalize(var_cc24231b0f3f7333 - vectordot(up_vector, var_cc24231b0f3f7333) * up_vector);
  return flat_vec;
}

function draw_arrow_time(start, end, color, duration, endonevent) {
  if(isDefined(endonevent)) {
    level endon(endonevent);
  }

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

function draw_arrow(start, end, color) {
  level endon("newpath");
  pts = [];
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

    line(arrow[p], arrow[nextpoint], color, 1);
  }
}

function draw_capsule(pos, radius, height, angles, color, depthtest, duration) {
  if(!isDefined(angles)) {
    angles = (0, 0, 0);
  }

  if(!isDefined(depthtest)) {
    depthtest = 0;
  }

  if(!isDefined(duration)) {
    duration = 1;
  }

  forward = anglesToForward(angles);
  right = anglestoright(angles);
  up = anglestoup(angles);

  cap_base = pos + up * radius;
  sphere(cap_base, radius, color, depthtest, duration);
  cap_top = pos + up * height;
  cap_top -= up * radius;
  sphere(cap_top, radius, color, depthtest, duration);
  var_e3e4708f2b15cdc = cap_base + forward * radius;
  var_c082cafefe1be9e0 = cap_top + forward * radius;
  line(var_e3e4708f2b15cdc, var_c082cafefe1be9e0, color, 1, depthtest, duration);
  var_35e9e473f5743470 = cap_base - forward * radius;
  var_f06f5503d572a834 = cap_top - forward * radius;
  line(var_35e9e473f5743470, var_f06f5503d572a834, color, 1, depthtest, duration);
  var_154fc976c8007720 = cap_base + right * radius;
  var_c826cf340204f3e4 = cap_top + right * radius;
  line(var_154fc976c8007720, var_c826cf340204f3e4, color, 1, depthtest, duration);
  var_29521623860703fa = cap_base - right * radius;
  var_2bc57f4bb1103296 = cap_top - right * radius;
  line(var_29521623860703fa, var_2bc57f4bb1103296, color, 1, depthtest, duration);
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

  if(isDefined(self.angles)) {
    angles = self.angles;
  } else {
    angles = (0, 0, 0);
  }

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

function draw_entity_bounds(ent, time_sec, color, dynamic, var_d88c48911f4bf6a0) {
  assert(isDefined(ent));
  assert(time_sec > 0);

  if(!isDefined(color)) {
    color = (0, 1, 0);
  }

  if(!isDefined(dynamic)) {
    dynamic = 0;
  }

  if(!isDefined(var_d88c48911f4bf6a0)) {
    var_d88c48911f4bf6a0 = level.framedurationseconds;
  }

  if(dynamic) {
    num_frames = int(var_d88c48911f4bf6a0 / level.framedurationseconds);
  } else {
    num_frames = int(time_sec / level.framedurationseconds);
  }

  var_1d29919376ad4830 = [];
  var_1d29949376ad4ec9 = [];
  current = gettime();
  end = current + time_sec * 1000;

  while(current < end && isDefined(ent)) {
    var_1d29919376ad4830[0] = ent getpointinbounds(1, 1, 1);
    var_1d29919376ad4830[1] = ent getpointinbounds(1, 1, -1);
    var_1d29919376ad4830[2] = ent getpointinbounds(-1, 1, -1);
    var_1d29919376ad4830[3] = ent getpointinbounds(-1, 1, 1);
    var_1d29949376ad4ec9[0] = ent getpointinbounds(1, -1, 1);
    var_1d29949376ad4ec9[1] = ent getpointinbounds(1, -1, -1);
    var_1d29949376ad4ec9[2] = ent getpointinbounds(-1, -1, -1);
    var_1d29949376ad4ec9[3] = ent getpointinbounds(-1, -1, 1);

    for(i = 0; i < 4; i++) {
      j = i + 1;

      if(j == 4) {
        j = 0;
      }

      line(var_1d29919376ad4830[i], var_1d29919376ad4830[j], color, 1, 0, num_frames);
      line(var_1d29949376ad4ec9[i], var_1d29949376ad4ec9[j], color, 1, 0, num_frames);
      line(var_1d29919376ad4830[i], var_1d29949376ad4ec9[i], color, 1, 0, num_frames);
    }

    if(!dynamic) {
      return;
    }

    wait var_d88c48911f4bf6a0;
    current = gettime();
  }
}

function getfx(fx) {
  assertex(isDefined(level._effect[fx]), "<dev string:x762>" + fx + "<dev string:x769>");
  return level._effect[fx];
}

function fxexists(fx) {
  return isDefined(level._effect[fx]);
}

function playerunlimitedammothread() {
  if(!isDefined(self) || self == level || isDefined(self.code_classname) && self.code_classname != "<dev string:x78e>") {
    player = level.player;
  } else {
    player = self;
  }

  assert(isDefined(player));

  while(true) {
    wait 0.5;

    if(getDvar(@ "unlimitedammooff") == "<dev string:x798>") {
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
  } else if(!isDefined(org)) {
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

function waittill_notify_or_timeout(msg, timer) {
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

function array_wait(array, message, timeout) {
  notifystruct = spawnStruct();

  if(istrue(timeout)) {
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
  element waittill_any_2(message, "death");
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
  result = element waittill_any_return_2(message, "death");
  notifystruct notify("array_wait_proc", element);
}

function fileprint_launcher_start_file()
{
  assertex(!isDefined(level. fileprint_launcher ), "<dev string:x79d>" );
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

        println("<dev string:x7e3>" + string);
      }

      function fileprint_launcher_end_file( var_82996f577af7f7f3, var_91a1926479dd5e50 )
      {
        if(!isDefined(var_91a1926479dd5e50)) {
          var_91a1926479dd5e50 = 0;
        }

        setdevdvarifuninitialized(@ "hash_d84b138e7aa2f2df", "<dev string:x7f7>");
        setdevdvarifuninitialized(@ "hash_afbeda0efab5bd5e", "<dev string:x7f7>");

        if(var_91a1926479dd5e50) {
          fileprint_launcher( "GAMEPRINTENDFILE:GAMEPRINTP4ENABLED:" + var_82996f577af7f7f3 );
        } else {
          fileprint_launcher( "GAMEPRINTENDFILE:" + var_82996f577af7f7f3 );
        }

        timeout = gettime() + 4000;

        while(getdvarint(@ "hash_afbeda0efab5bd5e") == 0 && getDvar(@ "hash_d84b138e7aa2f2df") == "0" && gettime() < timeout) {
          wait 0.05;
        }

        if(!(gettime() < timeout)) {
          iprintlnbold("LAUNCHER_PRINT_FAIL:( TIMEOUT ): launcherconflict? restart launcher and try again? ");

          setdevdvar(@ "hash_d84b138e7aa2f2df", "<dev string:x7f7>");

          level. fileprint_launcher = undefined;
          return false;
        }

        failvar = getDvar(@ "hash_d84b138e7aa2f2df");

        if(failvar != "0") {
          iprintlnbold("LAUNCHER_PRINT_FAIL:( " + failvar + " ): launcherconflict? restart launcher and try again? ");

          setdevdvar(@ "hash_d84b138e7aa2f2df", "<dev string:x7f7>");

          level. fileprint_launcher = undefined;
          return false;
        }

        setdevdvar(@ "hash_d84b138e7aa2f2df", "<dev string:x7f7>");
        setdevdvar(@ "hash_afbeda0efab5bd5e", "<dev string:x7f7>");

        iprintlnbold("Launcher write to file successful!");
        level. fileprint_launcher = undefined;
        return true;
      }

      function launcher_write_clipboard(str) {
        level.fileprintlauncher_linecount = 0;
        fileprint_launcher( "LAUNCHER_CLIP:" + str );
      }

      function activate_individual_exploder() {
        scripts\common\exploder::activate_individual_exploder_proc();
      }

      function get_target_ent(target) {
        if(!isDefined(target)) {
          target = self.target;
        }

        assertex(isDefined(target), "<dev string:x7fc>");
        ent = getEnt(target, "targetname");

        if(isDefined(ent)) {
          return ent;
        }

        if(issp()) {
          ent = builtin[[level.getnodefunction]](target, "targetname");

          if(isDefined(ent)) {
            return ent;
          }

          ent = builtin[[level.func["getspawner"]]](target, "targetname");

          if(isDefined(ent)) {
            return ent;
          }
        }

        ent = getStruct(target, "targetname");

        if(isDefined(ent)) {
          return ent;
        }

        ent = getvehiclenode(target, "targetname");

        if(isDefined(ent)) {
          return ent;
        }

        assertmsg("<dev string:x813>" + target + "<dev string:x828>");
      }

      function get_links() {
        return strtok(self.script_linkto, " ");
      }

      function get_linked_ents() {
        array = [];

        if(isDefined(self.script_linkto)) {
          linknames = get_links();

          if(linknames.size == 1) {
            return getEntArray(linknames[0], "script_linkname");
          } else if(linknames.size > 1) {
            return function_9f9ba8a4756db8c7(linknames, "script_linkname");
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
            return getnodearray(linknames[0], "script_linkname");
          } else if(linknames.size > 1) {
            return getnodesfromvalues(linknames, "script_linkname");
          }
        }

        return [];
      }

      function do_earthquake(name, origin) {
        eq = level.earthquake[name];
        earthquake(eq["magnitude"], eq["duration"], origin, eq["radius"]);

        if(isDefined(level.var_bc7733fa2bdf5ad0)) {
          level thread[[level.var_bc7733fa2bdf5ad0]](name, origin, eq["magnitude"], eq["duration"], eq["radius"]);
        }
      }

      function play_loopsound_in_space(alias, origin) {
        org = spawn("script_origin", (0, 0, 0));

        if(!isDefined(origin)) {
          origin = self.origin;
        }

        org.origin = origin;
        org playLoopSound(alias);
        return org;
      }

      function play_sound_in_space_with_angles(alias, origin, angles, parent) {
        org = spawn("script_origin", (0, 0, 1));

        if(!isDefined(origin)) {
          origin = self.origin;
        }

        org.origin = origin;
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

      function play_loop_sound_on_tag(alias, tag, bstopsoundondeath, var_627c155c7ac80247, release_sound) {
        org = spawn("script_origin", (0, 0, 0));
        org endon("death");

        if(!isDefined(bstopsoundondeath)) {
          bstopsoundondeath = 1;
        }

        if(bstopsoundondeath) {
          thread delete_on_death(org);
        }

        if(!isDefined(var_627c155c7ac80247)) {
          var_627c155c7ac80247 = 0;
        }

        if(var_627c155c7ac80247) {
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
        if(istrue(culled)) {
          if(!isDefined(level.first_frame) || level.first_frame == 1) {
            spawnloopingsound(alias, origin, angles);
          }

          return;
        }

        if(level.createfx_enabled && isDefined(createfx_ent.loopsound_ent)) {
          org = createfx_ent.loopsound_ent;
        } else {
          org = spawn("script_origin", (0, 0, 0));
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
            print3d(origin, "<dev string:x843>", (1, 0, 0), 1, 1);

            wait 0.05;
          }
        }

        if(!soundexists(alias)) {
          while(true) {
            print3d(origin, "<dev string:x85d>" + alias, (1, 0, 0), 1, 1);

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
        ent = scripts\common\createfx::createeffect("loopfx", fxid);
        ent.v["delay"] = scripts\common\createfx::getloopeffectdelaydefault();
        return ent;
      }

      function createoneshoteffect(fxid) {
        ent = scripts\common\createfx::createeffect("oneshotfx", fxid);
        ent.v["delay"] = scripts\common\createfx::getoneshoteffectdelaydefault();
        return ent;
      }

      function createexploder(fxid, islevelexploder) {
        ent = scripts\common\createfx::createeffect("exploder", fxid, islevelexploder);
        ent.v["delay"] = scripts\common\createfx::getexploderdelaydefault();
        ent.v["exploder_type"] = "normal";
        return ent;
      }

      function play_loop_sound_on_entity(alias, offset) {
        org = spawn("script_origin", (0, 0, 0));
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

      function delete_on_sounddone() {
        self waittill("sounddone");
        self delete();
      }

      function delete_on_notify(msg) {
        self waittill(msg);
        self delete();
      }

      function function_5ee1730c2e122134(ent, msg) {
        self waittill(msg);

        if(isDefined(ent)) {
          ent delete();
        }
      }

      function delete_after_delay(delay) {
        wait delay;

        if(isDefined(self)) {
          self delete();
        }
      }

      function error(msg) {
        println("<dev string:x86b>", msg);

        if(getDvar(@ "scr_debug") != "<dev string:x798>") {
          assertmsg("<dev string:x87c>" + msg);
        }
      }

      function exploder(num, players, starttime) {
        [[level._fx.exploderfunction]](num, players, starttime);
      }

      function delete_exploder(num) {
        scripts\common\exploder::delete_exploder_proc(num);
      }

      function hide_exploder_models(num) {
        scripts\common\exploder::hide_exploder_models_proc(num);
      }

      function show_exploder_models(num) {
        scripts\common\exploder::show_exploder_models_proc(num);
      }

      function stop_exploder(num, players) {
        scripts\common\exploder::stop_exploder_proc(num, players, 0);
      }

      function kill_exploder(num, players) {
        scripts\common\exploder::stop_exploder_proc(num, players, 1);
      }

      function get_exploder_array(msg) {
        return scripts\common\exploder::get_exploder_array_proc(msg);
      }

      function ter_op(statement, true_value, false_value) {
        if(statement) {
          return true_value;
        }

        return false_value;
      }

      function default_to(value, default_value) {
        if(!isDefined(value)) {
          return default_value;
        }

        return value;
      }

      function function_ce51e08dcc037220(value, default_value, err_msg) {
        if(!isDefined(value)) {
          if(isDefined(err_msg)) {
            assertmsg(err_msg);
          }

          return default_value;
        }

        return value;
      }

      function create_lock(msg, count) {
        if(!isDefined(count)) {
          count = 1;
        }

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
        var_ce09c6f6a7628f6d = self usinggamepad();

        if(isDefined(var_ce09c6f6a7628f6d)) {
          return var_ce09c6f6a7628f6d;
        }

        if(self ispcplayer()) {
          return 0;
        }

        return 1;
      }

      function player_prestream_camera(position, duration, altposition) {
        if(!isDefined(duration)) {
          duration = 5;
        }

        if(!isDefined(altposition)) {
          altposition = undefined;
        }

        thread function_d4192e0c7c79be61(position, duration, altposition);
      }

      function private function_d4192e0c7c79be61(position, duration, altposition) {
        if(!isDefined(duration)) {
          duration = 5;
        }

        if(!isDefined(altposition)) {
          altposition = undefined;
        }

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

      function player_prestream_entities(entities, distances, duration) {
        if(!isDefined(duration)) {
          duration = 5;
        }

        if(!isarray(entities)) {
          entities = [entities];
        }

        if(!isDefined(distances)) {
          distances = [];

          foreach(entity in entities) {
            distances[distances.size] = 50;
          }
        } else if(!isarray(distances)) {
          distances = [distances];
        }

        thread function_28548c8e56c0b115(entities, distances, duration);
      }

      function private function_28548c8e56c0b115(entities, distances, duration) {
        assert(isPlayer(self));
        player = self;
        player notify("player_prestream_entities");
        player endon("player_prestream_entities");
        player endon("disconnect");
        player function_bab9acc2cf205a62();

        foreach(idx, entity in entities) {
          if(isDefined(entity)) {
            entity function_af96f7c8819ae854(player, distances[idx]);
          }
        }

        if(duration > 0) {
          wait duration;
        } else if(duration < 0) {
          return;
        }

        if(isPlayer(player)) {
          player function_bab9acc2cf205a62();
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

      function get_array_of_closest(org, array, excluders, max, maxdist, mindist) {
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

          if(isDefined(maxdist2rd) && dist2rd > maxdist2rd) {
            continue;
          }

          if(dist2rd < mindist2rd) {
            continue;
          }

          newarray[newarray.size] = ent;
        }

        newarray = sortbydistance(newarray, org);

        if(max >= newarray.size) {
          return newarray;
        }

        finalarray = [];

        for(i = 0; i < max; i++) {
          finalarray[i] = newarray[i];
        }

        return finalarray;
      }

      function function_f7a98d43838654af(org, array, maxdist) {
        maxdistsquared = maxdist * maxdist;
        finalarray = [];

        foreach(ent in array) {
          if(distance2dsquared(org, ent.origin) < maxdistsquared) {
            finalarray[finalarray.size] = ent;
          }
        }

        return finalarray;
      }

      function drop_to_ground(pos, updist, downdist, upvector, contents) {
        assertex(isDefined(pos), "<dev string:x8af>");

        if(!isDefined(updist)) {
          updist = 1500;
        }

        if(!isDefined(downdist)) {
          downdist = -12000;
        }

        if(!isDefined(contents)) {
          contents = scripts\engine\trace::create_solid_ai_contents(1);
        }

        if(isDefined(upvector)) {
          return scripts\engine\trace::ray_trace(pos + updist * upvector, pos + downdist * upvector, undefined, contents)["position"];
        }

        return scripts\engine\trace::ray_trace(pos + (0, 0, updist), pos + (0, 0, downdist), undefined, contents)["position"];
      }

      function player_drop_to_ground(pos, radius, updist, downdist, upvector) {
        if(!isDefined(updist)) {
          updist = 1500;
        }

        if(!isDefined(downdist)) {
          downdist = -12000;
        }

        contents = scripts\engine\trace::create_solid_ai_contents(1);

        if(isDefined(upvector)) {
          return scripts\engine\trace::sphere_trace(pos + updist * upvector, pos + downdist * upvector, radius, undefined, contents)["position"];
        }

        return scripts\engine\trace::sphere_trace(pos + (0, 0, updist), pos + (0, 0, downdist), radius, undefined, contents)["position"];
      }

      function function_114e5c055b13dacf(pos, up_dist, down_dist, z_tolerance) {
        z_tolerance = default_to(z_tolerance, 32);
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
        normal = vectorNormalize(end_origin - start_origin);
        forward = anglesToForward(start_angles);
        dot = vectordot(forward, normal);
        return dot >= fov;
      }

      function ai_3d_sighting_model(associatedent) {
        assert(isai(self));

        if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["ai_3d_sighting_model"])) {
          return self[[level.bot_funcs["ai_3d_sighting_model"]]](associatedent);
        }
      }

      function getclosest(org, array, maxdist) {
        if(array.size == 0) {
          return undefined;
        }

        ent = sortbydistance(array, org)[0];

        if(isDefined(maxdist) && distancesquared(org, ent.origin) > squared(maxdist)) {
          return undefined;
        }

        return ent;
      }

      function function_4d046f33253e46e0(org, array, maxdist) {
        closestent = undefined;
        closestdistance = ter_op(isDefined(maxdist), maxdist, undefined);

        foreach(ent in array) {
          if(!isDefined(ent.origin)) {
            continue;
          }

          distancesq = distancesquared(ent.origin, org);

          if(!isDefined(closestdistance) || distancesq < closestdistance) {
            closestent = ent;
            closestdistance = distancesq;
          }
        }

        return closestent;
      }

      function missile_settargetandflightmode(target, mode, offset) {
        assert(isDefined(target));
        assert(isDefined(mode));
        offset = ter_op(isDefined(offset), offset, (0, 0, 0));
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

      function add_fx(fx_id, fx_path) {
        if(!isDefined(level._effect)) {
          level._effect = [];
        }

        assert(isDefined(fx_path));
        assert(isDefined(fx_id));
        level._effect[fx_id] = loadfx(fx_path);
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

      function delaythread(timer, func, param1, param2, param3, param4, param5, param6, param7) {
        thread delaythread_proc(func, undefined, timer, param1, param2, param3, param4, param5, param6, param7);
      }

      function delaythreadendon(timer, endonevent, func, param1, param2, param3, param4, param5, param6, param7) {
        thread delaythread_proc(func, endonevent, timer, param1, param2, param3, param4, param5, param6, param7);
      }

      function delaythread_proc(func, endonevent, timer, param1, param2, param3, param4, param5, param6, param7) {
        if(isDefined(self) && !isarray(self)) {
          self endon("stop_delay_thread");

          if(isent(self) && isPlayer(self)) {
            self endon("death_or_disconnect");
          } else {
            self endon("death");
          }

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

        if(isDefined(param7)) {
          thread[[func]](param1, param2, param3, param4, param5, param6, param7);
          return;
        }

        if(isDefined(param6)) {
          thread[[func]](param1, param2, param3, param4, param5, param6);
          return;
        }

        if(isDefined(param5)) {
          thread[[func]](param1, param2, param3, param4, param5);
          return;
        }

        if(isDefined(param4)) {
          thread[[func]](param1, param2, param3, param4);
          return;
        }

        if(isDefined(param3)) {
          thread[[func]](param1, param2, param3);
          return;
        }

        if(isDefined(param2)) {
          thread[[func]](param1, param2);
          return;
        }

        if(isDefined(param1)) {
          thread[[func]](param1);
          return;
        }

        thread[[func]]();
      }

      function damagelocationisany(a, b, c, d, e, f, g, h, i, j, k, ovr) {
        if(isDefined(self.damagelocation)) {
          if(!isDefined(a)) {
            return 0;
          }

          if(self.damagelocation == a) {
            return 1;
          }

          if(!isDefined(b)) {
            return 0;
          }

          if(self.damagelocation == b) {
            return 1;
          }

          if(!isDefined(c)) {
            return 0;
          }

          if(self.damagelocation == c) {
            return 1;
          }

          if(!isDefined(d)) {
            return 0;
          }

          if(self.damagelocation == d) {
            return 1;
          }

          if(!isDefined(e)) {
            return 0;
          }

          if(self.damagelocation == e) {
            return 1;
          }

          if(!isDefined(f)) {
            return 0;
          }

          if(self.damagelocation == f) {
            return 1;
          }

          if(!isDefined(g)) {
            return 0;
          }

          if(self.damagelocation == g) {
            return 1;
          }

          if(!isDefined(h)) {
            return 0;
          }

          if(self.damagelocation == h) {
            return 1;
          }

          if(!isDefined(i)) {
            return 0;
          }

          if(self.damagelocation == i) {
            return 1;
          }

          if(!isDefined(j)) {
            return 0;
          }

          if(self.damagelocation == j) {
            return 1;
          }

          if(!isDefined(k)) {
            return 0;
          }

          if(self.damagelocation == k) {
            return 1;
          }

          assert(!isDefined(ovr));
        }

        return damagesubpartlocationisany(a, b, c, d, e, f, g, h, i, j, k, ovr);
      }

      function damagesubpartlocationisany(a, b, c, d, e, f, g, h, i, j, k, ovr) {
        if(!isDefined(self.damagedsubpart)) {
          return false;
        }

        if(!isDefined(a)) {
          return false;
        }

        if(self.damagedsubpart == a) {
          return true;
        }

        if(!isDefined(b)) {
          return false;
        }

        if(self.damagedsubpart == b) {
          return true;
        }

        if(!isDefined(c)) {
          return false;
        }

        if(self.damagedsubpart == c) {
          return true;
        }

        if(!isDefined(d)) {
          return false;
        }

        if(self.damagedsubpart == d) {
          return true;
        }

        if(!isDefined(e)) {
          return false;
        }

        if(self.damagedsubpart == e) {
          return true;
        }

        if(!isDefined(f)) {
          return false;
        }

        if(self.damagedsubpart == f) {
          return true;
        }

        if(!isDefined(g)) {
          return false;
        }

        if(self.damagedsubpart == g) {
          return true;
        }

        if(!isDefined(h)) {
          return false;
        }

        if(self.damagedsubpart == h) {
          return true;
        }

        if(!isDefined(i)) {
          return false;
        }

        if(self.damagedsubpart == i) {
          return true;
        }

        if(!isDefined(j)) {
          return false;
        }

        if(self.damagedsubpart == j) {
          return true;
        }

        if(!isDefined(k)) {
          return false;
        }

        if(self.damagedsubpart == k) {
          return true;
        }

        assert(!isDefined(ovr));
        return false;
      }

      function isbulletdamage(meansofdeath) {
        if(!isDefined(meansofdeath)) {
          assertmsg("<dev string:x8e9>");
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
          assertmsg("<dev string:x911>");
          return false;
        }

        return meansofdeath == "MOD_FIRE";
      }

      function isimpactdamage(meansofdeath) {
        if(!isDefined(meansofdeath)) {
          assertmsg("<dev string:x911>");
          return false;
        }

        return meansofdeath == "MOD_IMPACT";
      }

      function ismeleedamage(meansofdeath) {
        if(!isDefined(meansofdeath)) {
          assertmsg("<dev string:x937>");
          return false;
        }

        return meansofdeath == "MOD_MELEE";
      }

      function isvehiclecrushdamage(inflictor, meansofdeath) {
        if(!isDefined(inflictor) || !isDefined(inflictor.vehiclename)) {
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

          var_72c1ba1a734c19e6 = vectortoangles(enemy_pos - node.origin);
          yaw_diff = angleclamp180(var_72c1ba1a734c19e6[1] - node.angles[1]);
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
              assertmsg("<dev string:x95e>");
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
        var_2f2845d474ecddd0 = spot - self.origin;
        var_11f7d776431edc42 = rotatevectorinverted(var_2f2845d474ecddd0, self.angles);
        yaw = vectortoyaw(var_11f7d776431edc42);
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
        var_2f2845d474ecddd0 = spot - self.origin;
        var_11f7d776431edc42 = rotatevectorinverted(var_2f2845d474ecddd0, self.angles);
        pitch = vectortopitch(var_11f7d776431edc42);
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

      function is_equal(arga, argb) {
        return isDefined(arga) && isDefined(argb) && arga == argb;
      }

      function function_5b7e9a4c946f3a13(arg, argarray) {
        assertex(isarray(argarray), "<dev string:x997>");

        if(!isDefined(arg)) {
          return false;
        }

        foreach(value in argarray) {
          if(isDefined(value) && arg == value) {
            return true;
          }
        }

        return false;
      }

      function player_is_in_jackal() {
        return false;
      }

      function set_createfx_enabled() {
        if(!isDefined(level.createfx_enabled)) {
          level.createfx_enabled = getDvar(@ "createfx") != "";
        }
      }

      function flag_set_delayed(message, delay, setter) {
        wait delay;
        flag_set(message, setter);
      }

      function noself_array_call(entities, process, var2, var3, var4) {
        if(isDefined(var4)) {
          foreach(ent in entities) {
            builtin[[process]](ent, var2, var3, var4);
          }

          return;
        }

        if(isDefined(var3)) {
          foreach(ent in entities) {
            builtin[[process]](ent, var2, var3);
          }

          return;
        }

        if(isDefined(var2)) {
          foreach(ent in entities) {
            builtin[[process]](ent, var2);
          }

          return;
        }

        foreach(ent in entities) {
          builtin[[process]](ent);
        }
      }

      function flag_assert(msg) {
        assertex(!flag(msg), "<dev string:x9b4>" + msg + "<dev string:x9bd>");
      }

      function flag_wait_either(flag1, flag2) {
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

      function flag_wait_either_return(flag1, flag2) {
        if(flag(flag1)) {
          return flag1;
        }

        if(flag(flag2)) {
          return flag2;
        }

        msg = level waittill_any_return_2(flag1, flag2);
        return msg;
      }

      function flag_wait_any_array(flags) {
        assertex(isarray(flags), "<dev string:x9cf>");
        flags = array_removeundefined(flags);

        for(;;) {
          for(i = 0; i < flags.size; i++) {
            if(flag(flags[i])) {
              return flags[i];
            }
          }

          level waittill_any_in_array(flags);
        }
      }

      function function_51ffc85dd7ebde09(flags) {
        return flag_wait_any_array(flags);
      }

      function flag_wait_any(flag1, flag2, flag3, flag4, flag5, flag6) {
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
          assertmsg("<dev string:xa0e>");
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

      function flag_wait_any_timeout(timer, flag1, flag2, flag3, flag4, flag5, flag6) {
        assertex(isDefined(timer) && timer > 0, "<dev string:xa45>");
        timerms = timer * 1000;
        start_time = gettime();
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
          array[array.size] = flag1;
          array[array.size] = flag2;
        } else {
          assertmsg("<dev string:xa93>");
          return;
        }

        for(;;) {
          foreach(flag_msg in array) {
            if(flag(flag_msg)) {
              return;
            }
          }

          curr_time = gettime();

          if(curr_time >= start_time + timerms) {
            break;
          }

          timeremaining = timerms - curr_time - start_time;
          timeremainingsecs = timeremaining / 1000;
          internal_wait_for_any_flag_or_time_elapses(array, timeremainingsecs);
        }
      }

      function internal_wait_for_any_flag_or_time_elapses(flag_arr, timer) {
        foreach(flag_msg in flag_arr) {
          level endon(flag_msg);
        }

        wait timer;
      }

      function flag_wait_any_return(flag1, flag2, flag3, flag4, flag5) {
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
          assertmsg("<dev string:xad2>");
          return;
        }

        for(i = 0; i < array.size; i++) {
          if(flag(array[i])) {
            return array[i];
          }
        }

        msg = level waittill_any_return_5(flag1, flag2, flag3, flag4, flag5);
        return msg;
      }

      function flag_wait_all(flag1, flag2, flag3, flag4) {
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

      function function_7a252abaaa15fcd7(flags) {
        flags = array_removeundefined(flags);

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
        flags = array_removeundefined(flags);

        for(;;) {
          foreach(flagname in flags) {
            flag_waitopen(flagname);
          }

          var_df8bbda6a16dd1cb = 0;

          foreach(flagname in flags) {
            if(!flag(flagname)) {
              var_df8bbda6a16dd1cb++;
            }
          }

          if(var_df8bbda6a16dd1cb == flags.size) {
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

      function noself_delaycall(timer, func, param1, param2, param3, param4, param5, param6, param7, param8) {
        thread noself_delaycall_proc(func, timer, param1, param2, param3, param4, param5, param6, param7, param8);
      }

      function noself_delaycall_proc(func, timer, param1, param2, param3, param4, param5, param6, param7, param8) {
        wait timer;

        if(isDefined(param8)) {
          builtin[[func]](param1, param2, param3, param4, param5, param6, param7, param8);
          return;
        }

        if(isDefined(param7)) {
          builtin[[func]](param1, param2, param3, param4, param5, param6, param7);
          return;
        }

        if(isDefined(param6)) {
          builtin[[func]](param1, param2, param3, param4, param5, param6);
          return;
        }

        if(isDefined(param5)) {
          builtin[[func]](param1, param2, param3, param4, param5);
          return;
        }

        if(isDefined(param4)) {
          builtin[[func]](param1, param2, param3, param4);
          return;
        }

        if(isDefined(param3)) {
          builtin[[func]](param1, param2, param3);
          return;
        }

        if(isDefined(param2)) {
          builtin[[func]](param1, param2);
          return;
        }

        if(isDefined(param1)) {
          builtin[[func]](param1);
          return;
        }

        builtin[[func]]();
      }

      function get_target_array(target) {
        if(!isDefined(target)) {
          target = self.target;
        }

        assertex(isDefined(target), "<dev string:x7fc>");
        ents = getEntArray(target, "targetname");

        if(ents.size > 0) {
          return ents;
        }

        if(issp()) {
          ents = builtin[[level.getnodearrayfunction]](target, "targetname");

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

        ents = getvehiclenodearray(target, "targetname");

        if(ents.size > 0) {
          return ents;
        }

        assertmsg("<dev string:x813>" + target + "<dev string:xb10>");
      }

      function pauseeffect() {
        scripts\common\createfx::stop_fx_looper();
      }

      function spawn_script_origin(org, ang) {
        if(!isDefined(ang) && isDefined(self.angles)) {
          ang = self.angles;
        }

        if(!isDefined(org) && isDefined(self.origin)) {
          org = self.origin;
        } else if(!isDefined(org)) {
          org = (0, 0, 0);
        }

        script_origin = spawn("script_origin", org);

        if(isDefined(ang)) {
          script_origin.angles = ang;
        }

        return script_origin;
      }

      function get_noteworthy_array(noteworthy) {
        assertex(isDefined(noteworthy), "<dev string:xb2c>");
        ents = getEntArray(noteworthy, "script_noteworthy");

        if(ents.size > 0) {
          return ents;
        }

        if(issp()) {
          ents = builtin[[level.getnodearrayfunction]](noteworthy, "script_noteworthy");

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

        ents = getvehiclenodearray(noteworthy, "script_noteworthy");

        if(ents.size > 0) {
          return ents;
        }

        assertex("<dev string:xb4e>" + noteworthy + "<dev string:xb73>");
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

      function void() {}

      function getanim(anime) {
        assertex(isDefined(self.animname), "<dev string:xb8d>");
        assertex(isDefined(level.scr_anim[self.animname][anime]), "<dev string:xbb9>");
        return level.scr_anim[self.animname][anime];
      }

      function hasanim(anime) {
        assertex(isDefined(self.animname), "<dev string:xbe1>");
        return isDefined(level.scr_anim[self.animname][anime]);
      }

      function getanim_from_animname(anime, animname) {
        assertex(isDefined(animname), "<dev string:xc0d>");
        assertex(isDefined(level.scr_anim[animname][anime]), "<dev string:xc28>");
        return level.scr_anim[animname][anime];
      }

      function getanim_generic(anime) {
        assertex(isDefined(level.scr_anim["<dev string:xc5e>"][anime]), "<dev string:xc69>");
        return level.scr_anim["generic"][anime];
      }

      function hasanim_generic(anime) {
        return isDefined(level.scr_anim["generic"][anime]);
      }

      function getanim_starts(anime, ent) {
        startpositions = [];

        if(scripts\common\anim::function_f1e7ee8ddeece062(anime)) {
          foreach(animation in level.scr_anim[ent.animname][anime]) {
            newanime = scripts\common\anim::function_56bd620e57a834af(anime, ent.animname, animation);
            scripts\common\anim::anim_first_frame_solo(ent, newanime);
            startpositions[startpositions.size] = ent.origin;
          }
        } else {
          scripts\common\anim::anim_first_frame_solo(ent, anime);
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

      function function_ee012c2dd711a8ce(msg, match, endonmsg) {
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

      function ips_to_mph(ips) {
        return ips * 0.056818;
      }

      function function_dd1c9564bbdda261(knots) {
        return knots * 20.2537;
      }

      function function_de54c0137bbb0d7f(ips) {
        return ips * 0.049374;
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
        var_770e3bedd2b80d9b = [pa, pb, distance(pa, pb)];
        return var_770e3bedd2b80d9b;
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
        var_770e3bedd2b80d9b = [pa, pb, distance(pa, pb)];
        return var_770e3bedd2b80d9b;
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

      function string(num) {
        return "" + num;
      }

      function playsoundontag(alias, tag, ends_on_death, var_b426f32755673ba6, radio_dialog) {
        assert(isDefined(level.fnplaysoundontag));
        [[level.fnplaysoundontag]](alias, tag, ends_on_death, var_b426f32755673ba6, radio_dialog);
      }

      function playsoundonentity(alias, var_b426f32755673ba6) {
        assert(isDefined(level.fnplaysoundonentity));
        [[level.fnplaysoundonentity]](alias, var_b426f32755673ba6);
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
            assertmsg("<dev string:xc99>" + notetrackstart + "<dev string:xcaf>");
            animstartfrac = 0;
          }
        } else {
          animstartfrac = 0;
        }

        if(isDefined(notetrackend)) {
          animendfrac = getnotetracktimes(anime, notetrackend)[0];

          if(!isDefined(animendfrac)) {
            assertmsg("<dev string:xcd4>" + notetrackend + "<dev string:xcaf>");
            animendfrac = 1;
          }
        } else {
          animendfrac = 1;
        }

        motionwarpwithtimes(anime, targetpos, targetangles, animstartfrac, animendfrac, duration, updateanimrate);
      }

      function motionwarpwithtimes(anime, targetpos, targetangles, animstartfrac, animendfrac, duration, updateanimrate) {
        if(!isDefined(updateanimrate)) {
          updateanimrate = 1;
        }

        animyawdelta = getangledelta(anime, animstartfrac, animendfrac);
        animtranslationdelta = getmovedelta(anime, animstartfrac, animendfrac);
        animtranslationdelta = rotatevector(animtranslationdelta, (0, targetangles[1] - animyawdelta, 0));
        animstartpos = targetpos - animtranslationdelta;
        animstartyaw = targetangles[1] - animyawdelta;
        animstartangles = (targetangles[0], animstartyaw, targetangles[2]);
        animrate = 1;
        var_94fbe2a18e7f59b3 = length(targetpos - self.origin);

        if(updateanimrate && var_94fbe2a18e7f59b3 > 0) {
          animrate = length(animtranslationdelta) / var_94fbe2a18e7f59b3;
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

        self motionwarpwithanim(animstartpos, animstartangles, targetpos, targetangles, duration);
        return animrate;
      }

      function function_df956d52bae0b61d(anime, parentent, tag, localtargetpos, var_b6c5de4898b7f63b, animstartfrac, animendfrac, duration, updateanimrate) {
        assert(isDefined(anime));
        assert(isDefined(animstartfrac) && animstartfrac >= 0);
        assert(isDefined(animendfrac) && animendfrac <= 1);
        assert(isDefined(parentent));
        assert(isDefined(localtargetpos));
        assert(isDefined(var_b6c5de4898b7f63b));

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
        var_8248003e7165c71e = combineangles(var_b6c5de4898b7f63b, linkang);
        var_5201fba058886642 = getangledelta3d(anime, animstartfrac, animendfrac);
        animposdelta = getmovedelta(anime, animstartfrac, animendfrac);
        var_f7bd065066febebf = invertangles(var_5201fba058886642);
        var_f03bd42b04ee3dca = combineangles(var_8248003e7165c71e, var_f7bd065066febebf);
        var_ca6be8926624acbf = rotatevector(-1 * animposdelta, var_f7bd065066febebf);
        var_ca86acbc27e4a31c = rotatevector(var_ca6be8926624acbf, var_8248003e7165c71e);
        worldanimstartpos = worldtargetpos + var_ca86acbc27e4a31c;
        var_7b1c8fcebb9c392d = self.origin - linkpos;
        invlinkang = invertangles(linkang);
        localtargetpos = rotatevector(var_7b1c8fcebb9c392d, invlinkang);
        var_b6c5de4898b7f63b = combineangles(self.angles, invlinkang);
        animrate = 1;
        var_94fbe2a18e7f59b3 = length(worldtargetpos - self.origin);

        if(updateanimrate && var_94fbe2a18e7f59b3 > 0) {
          animrate = length(animposdelta) / var_94fbe2a18e7f59b3;
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

        self linktomoveoffset(parentent, tag, localtargetpos, var_b6c5de4898b7f63b);
        self motionwarpwithanim(worldanimstartpos, var_f03bd42b04ee3dca, worldtargetpos, var_8248003e7165c71e, duration);
      }

      function waittill_any_ents_or_timeout_return(timeout, ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7) {
        assert(isDefined(timeout));
        assert(isDefined(ent1));
        assert(isDefined(string1));
        self endon("death");
        ent = spawnStruct();
        ent1 childthread waittill_string(string1, ent);

        if(isDefined(ent2) && isDefined(string2)) {
          ent2 childthread waittill_string(string2, ent);
        }

        if(isDefined(ent3) && isDefined(string3)) {
          ent3 childthread waittill_string(string3, ent);
        }

        if(isDefined(ent4) && isDefined(string4)) {
          ent4 childthread waittill_string(string4, ent);
        }

        if(isDefined(ent5) && isDefined(string5)) {
          ent5 childthread waittill_string(string5, ent);
        }

        if(isDefined(ent6) && isDefined(string6)) {
          ent6 childthread waittill_string(string6, ent);
        }

        if(isDefined(ent7) && isDefined(string7)) {
          ent7 childthread waittill_string(string7, ent);
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
          ignoregroup = array_combine(ignoregroup, ignoreentarray);
        }

        content = ter_op(isDefined(contentoverride), contentoverride, scripts\engine\trace::create_default_contents());
        return cantracetoai(ai, start, ignoreentarray, content);
      }

      function array_removedead_or_dying(array, var_5c3b6418c0ad64ae) {
        if(!isDefined(var_5c3b6418c0ad64ae)) {
          var_5c3b6418c0ad64ae = 1;
        }

        newarray = [];

        foreach(member in array) {
          if(!isalive(member)) {
            continue;
          }

          if(isai(member) && var_5c3b6418c0ad64ae && member doinglongdeath()) {
            continue;
          }

          newarray[newarray.size] = member;
        }

        return newarray;
      }

      function disable_pain() {
        assertex(isai(self), "<dev string:xce8>");
        self.a.disablepain = 1;
        self.allowpain = 0;
      }

      function enable_pain() {
        assertex(isai(self), "<dev string:xd0d>");
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

      function function_82581894f5a1c71c() {
        self.var_8aa9efe6383c1d5a = "ai" + getpersistentainumber();
        incrementpersistentainumber();
      }

      function ent_flag_wait(msg) {
        assertex(!issentient(self) && isDefined(self) || isalive(self), "<dev string:xd31>");

        while(isDefined(self) && !ent_flag(msg)) {
          self waittill(msg);
        }
      }

      function array_ent_flag_wait(entities, flag) {
        notifystruct = spawnStruct();

        foreach(entity in entities) {
          if(entity ent_flag(flag)) {
            entities = array_remove(entities, entity);
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
        assertex(isDefined(self), "<dev string:xd73>");

        while(isDefined(self) && !ent_flag(msg)) {
          self waittill(msg);
        }
      }

      function ent_flag_wait_either(flag1, flag2) {
        assertex(!issentient(self) && isDefined(self) || isalive(self), "<dev string:xd31>");

        while(isDefined(self)) {
          if(ent_flag(flag1)) {
            return;
          }

          if(ent_flag(flag2)) {
            return;
          }

          waittill_either(flag1, flag2);
        }
      }

      function function_243c46ee6332c45d(flags) {
        flags = array_removeundefined(flags);

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

      function function_cba0984334ba3279(flags) {
        flags = array_removeundefined(flags);

        for(;;) {
          foreach(flagname in flags) {
            ent_flag_waitopen(flagname);
          }

          var_e9edcc859df58c2e = 0;

          foreach(flagname in flags) {
            if(!ent_flag(flagname)) {
              var_e9edcc859df58c2e++;
            }
          }

          if(var_e9edcc859df58c2e == flags.size) {
            break;
          }
        }
      }

      function function_e205428b44d1a83c(flags) {
        flags = array_removeundefined(flags);
        assertex(!issentient(self) && isDefined(self) || isalive(self), "<dev string:xd31>");

        while(isDefined(self)) {
          foreach(flagname in flags) {
            if(!ent_flag(flagname)) {
              return;
            }
          }

          waittill_any_in_array_return(flags);
        }
      }

      function ent_flag_wait_or_timeout(flagname, timer) {
        assertex(!issentient(self) && isDefined(self) || isalive(self), "<dev string:xd31>");
        start_time = gettime();

        while(isDefined(self)) {
          if(ent_flag(flagname)) {
            break;
          }

          if(gettime() >= start_time + timer * 1000) {
            break;
          }

          ent_wait_for_flag_or_time_elapses(flagname, timer);
        }
      }

      function ent_wait_for_flag_or_time_elapses(flagname, timer) {
        self endon(flagname);
        wait timer;
      }

      function ent_flag_waitopen(msg) {
        assertex(!issentient(self) && isDefined(self) || isalive(self), "<dev string:xd31>");

        while(isDefined(self) && ent_flag(msg)) {
          self waittill(msg);
        }
      }

      function ent_flag_assert(msg) {
        assertex(!ent_flag(msg), "<dev string:x9b4>" + msg + "<dev string:xdad>");
      }

      function ent_flag_waitopen_either(flag1, flag2) {
        assertex(!issentient(self) && isDefined(self) || isalive(self), "<dev string:xd31>");

        while(isDefined(self)) {
          if(!ent_flag(flag1)) {
            return;
          }

          if(!ent_flag(flag2)) {
            return;
          }

          waittill_either(flag1, flag2);
        }
      }

      function ent_flag_init(message) {
        if(!isDefined(self.ent_flag)) {
          self.ent_flag = [];
          self.ent_flags_lock = [];
        }

        if(isDefined(level.first_frame) && level.first_frame == -1) {
          assertex(!ent_flag_exist(message), "<dev string:x288>" + message + "<dev string:xdc8>");
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
        assertex(isDefined(self), "<dev string:xdd7>");
        assertex(isDefined(message), "<dev string:x253>");

        if(!ent_flag_exist(message)) {
          ent_flag_init(message);
        }

        assert(self.ent_flag[message] == self.ent_flags_lock[message]);
        self.ent_flags_lock[message] = 1;

        self.ent_flag[message] = 1;
        self notify(message);
      }

      function ent_flag_clear(message, remove) {
        assertex(isDefined(self), "<dev string:xe0e>");

        if(ent_flag_exist(message)) {
          assert(self.ent_flag[message] == self.ent_flags_lock[message]);
        }

        self.ent_flags_lock[message] = 0;

        if(ent_flag(message)) {
          self.ent_flag[message] = 0;
          self notify(message);
        }

        if(ent_flag_exist(message) && istrue(remove)) {
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
        assertex(isDefined(message), "<dev string:x253>");
        return ent_flag_exist(message) && self.ent_flag[message];
      }

      function get_linked_structs() {
        array = [];

        if(isDefined(self.script_linkto)) {
          linknames = get_links();

          for(i = 0; i < linknames.size; i++) {
            structs = getStructArray(linknames[i], "script_linkname");

            if(structs.size > 0) {
              array = array_combine(array, structs);
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

      function requestgamerprofile(var_d40db77fec61d6a4) {
        level endon("game_ended");
        self endon("disconnect");
        self sendrequestgamerprofilecmd(var_d40db77fec61d6a4);

        while(true) {
          self waittill("luinotifyserver", channel, value);

          if(channel == "gamerprofile_request") {
            return value;
          }
        }
      }

      function ismountconfigenabled() {
        var_6c9fe414d3f3d966 = 1;
        mountconfig = 0;

        if(is_player_gamepad_enabled()) {
          mountconfig = requestgamerprofile("mountButtonConfig");
        } else {
          mountconfig = requestgamerprofile("mountButtonConfigKBM");
        }

        return mountconfig != var_6c9fe414d3f3d966;
      }

      function function_4319aef954ddbee5() {
        var_f9ac1524e38018a2 = 1;
        toggletacticaladsconfig = 0;

        if(is_player_gamepad_enabled()) {
          toggletacticaladsconfig = requestgamerprofile("toggleTacticalADSConfig");
        } else {
          toggletacticaladsconfig = requestgamerprofile("toggleTacticalADSConfigKBM");
        }

        return toggletacticaladsconfig != var_f9ac1524e38018a2;
      }

      function function_9ec2f480552af944(player) {
        if(!isDefined(player)) {
          assertmsg("<dev string:xe47>");
          return false;
        }

        if(player usinggamepad()) {
          var_43c445e16f561dce = player getcurrentusereloadconfig();
          return (var_43c445e16f561dce == 0 || var_43c445e16f561dce == 3);
        }

        return player getuseholdkbmprofile() == 1;
      }

      function getintorzero(value) {
        if(isnumber(value)) {
          return int(value);
        }

        return 0;
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

      function function_6cf786a6cf335cb9(queue, object) {
        if(queue.array.size == queue.capacity) {
          assertex(0, "<dev string:xe82>");
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

      function function_93def91a50927481(queue) {
        if(queue.array.size == 0) {
          assertex(0, "<dev string:xeb6>");
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
          assertex(0, "<dev string:xeeb>");
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

      function queue_isempty(queue) {
        return queue.array.size == 0;
      }

      function function_a6025442a4e1c649(queue, object) {
        if(!isDefined(queue) || !isDefined(object)) {
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

      function function_c89ed1840c8d0f0f(milliseconds) {
        return milliseconds * 0.001;
      }

      function function_a5b14435e3229bed(seconds) {
        return seconds * 1000;
      }

      function single_thread_argarray(entity, func, a_vars) {
        single_thread(entity, func, undefined, undefined, a_vars);
      }

      function function_8a68123e2bbb5ba4(entity, func, arg1, a_vars) {
        single_thread(entity, func, arg1, undefined, a_vars);
      }

      function function_8a68133e2bbb5dd7(entity, func, arg1, arg2, a_vars) {
        single_thread(entity, func, arg1, arg2, a_vars);
      }

      function private single_thread(entity, func, arg1, arg2, a_vars) {
        a_vars = function_d13634fdb31beeaf(a_vars);
        assert(isfunction(func));

        if(!isfunction(func)) {
          return;
        }

        if(isDefined(arg2)) {
          switch (a_vars.size) {
            case 8:
              entity thread[[func]](arg1, arg2, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6], a_vars[7]);
              break;
            case 7:
              entity thread[[func]](arg1, arg2, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6]);
              break;
            case 6:
              entity thread[[func]](arg1, arg2, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
              break;
            case 5:
              entity thread[[func]](arg1, arg2, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
              break;
            case 4:
              entity thread[[func]](arg1, arg2, a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
              break;
            case 3:
              entity thread[[func]](arg1, arg2, a_vars[0], a_vars[1], a_vars[2]);
              break;
            case 2:
              entity thread[[func]](arg1, arg2, a_vars[0], a_vars[1]);
              break;
            case 1:
              entity thread[[func]](arg1, arg2, a_vars[0]);
              break;
            case 0:
              entity thread[[func]](arg1, arg2);
              break;
            default:
              assertmsg("<dev string:xf1c>");
              break;
          }

          return;
        }

        if(isDefined(arg1)) {
          switch (a_vars.size) {
            case 8:
              entity thread[[func]](arg1, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6], a_vars[7]);
              break;
            case 7:
              entity thread[[func]](arg1, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6]);
              break;
            case 6:
              entity thread[[func]](arg1, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
              break;
            case 5:
              entity thread[[func]](arg1, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
              break;
            case 4:
              entity thread[[func]](arg1, a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
              break;
            case 3:
              entity thread[[func]](arg1, a_vars[0], a_vars[1], a_vars[2]);
              break;
            case 2:
              entity thread[[func]](arg1, a_vars[0], a_vars[1]);
              break;
            case 1:
              entity thread[[func]](arg1, a_vars[0]);
              break;
            case 0:
              entity thread[[func]](arg1);
              break;
            default:
              assertmsg("<dev string:xf1c>");
              break;
          }

          return;
        }

        switch (a_vars.size) {
          case 8:
            entity thread[[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6], a_vars[7]);
            break;
          case 7:
            entity thread[[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6]);
            break;
          case 6:
            entity thread[[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
            break;
          case 5:
            entity thread[[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
            break;
          case 4:
            entity thread[[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
            break;
          case 3:
            entity thread[[func]](a_vars[0], a_vars[1], a_vars[2]);
            break;
          case 2:
            entity thread[[func]](a_vars[0], a_vars[1]);
            break;
          case 1:
            entity thread[[func]](a_vars[0]);
            break;
          case 0:
            entity thread[[func]]();
            break;
          default:
            assertmsg("<dev string:xf1c>");
            break;
        }
      }

      function single_func_argarray(entity, func, a_vars) {
        return function_a057e1f7cf74f00(entity, func, a_vars);
      }

      function private function_a057e1f7cf74f00(entity, func, a_vars) {
        a_vars = function_d13634fdb31beeaf(a_vars);

        switch (a_vars.size) {
          case 8:
            if(isDefined(entity)) {
              return entity[[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6], a_vars[7]);
            } else {
              return [[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6], a_vars[7]);
            }

            break;
          case 7:
            if(isDefined(entity)) {
              return entity[[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6]);
            } else {
              return [[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6]);
            }

            break;
          case 6:
            if(isDefined(entity)) {
              return entity[[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
            } else {
              return [[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
            }

            break;
          case 5:
            if(isDefined(entity)) {
              return entity[[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
            } else {
              return [[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
            }

            break;
          case 4:
            if(isDefined(entity)) {
              return entity[[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
            } else {
              return [[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
            }

            break;
          case 3:
            if(isDefined(entity)) {
              return entity[[func]](a_vars[0], a_vars[1], a_vars[2]);
            } else {
              return [[func]](a_vars[0], a_vars[1], a_vars[2]);
            }

            break;
          case 2:
            if(isDefined(entity)) {
              return entity[[func]](a_vars[0], a_vars[1]);
            } else {
              return [[func]](a_vars[0], a_vars[1]);
            }

            break;
          case 1:
            if(isDefined(entity)) {
              return entity[[func]](a_vars[0]);
            } else {
              return [[func]](a_vars[0]);
            }

            break;
          case 0:
            if(isDefined(entity)) {
              return entity[[func]]();
            } else {
              return [[func]]();
            }

            break;
          default:
            assertmsg("<dev string:xf1c>");
            break;
        }
      }

      function private function_d13634fdb31beeaf(a_vars) {
        var_d9d0128c23712f95 = -1;

        for(i = a_vars.size - 1; i >= 0; i--) {
          if(!isDefined(a_vars[i])) {
            var_d9d0128c23712f95 = i;
            continue;
          }

          break;
        }

        if(var_d9d0128c23712f95 == -1) {
          return a_vars;
        }

        var_4c1b085372d0c223 = [];

        for(i = 0; i < var_d9d0128c23712f95; i++) {
          var_4c1b085372d0c223[i] = a_vars[i];
        }

        return var_4c1b085372d0c223;
      }

      function vtos(vector) {
        return "(" + int(vector[0]) + " " + int(vector[1]) + " " + int(vector[2]) + ")";
      }

      function absolutevalue(inputvalue) {
        if(inputvalue >= 0) {
          return inputvalue;
        }

        return -1 * inputvalue;
      }

      function create_partition(array, cell_size) {
        assert(isDefined(array), "<dev string:xf2e>");
        assert(isarray(array), "<dev string:xf5d>");
        assert(isDefined(cell_size), "<dev string:xfa0>");
        assert(isfloat(cell_size) || isint(cell_size), "<dev string:xfd3>");
        partition = spawnStruct();
        partition.array = [];
        partition.cell_size = cell_size;
        partition.coordinate_add = int(150000 / 2 * cell_size);

        foreach(object in array) {
          partition function_24bbefb4beda630d(object);
        }

        return partition;
      }

      function is_partition() {
        return isDefined(self) && isDefined(self.array) && isDefined(self.cell_size) && isDefined(self.coordinate_add);
      }

      function function_24bbefb4beda630d(object) {
        assert(is_partition(), "<dev string:x101f>");
        assert(isDefined(object), "<dev string:x107e>");
        assert(isDefined(object.origin), "<dev string:x10ae>");
        [x, y] = function_5b83b054e7f1c193(object.origin);
        var_56c8714742ff3c04 = self.array[x];

        if(!isDefined(var_56c8714742ff3c04)) {
          self.array[x] = [];
          var_56c8714742ff3c04 = [];
        }

        var_dd613b6808c13588 = var_56c8714742ff3c04[y];

        if(!isDefined(var_dd613b6808c13588)) {
          self.array[x][y] = [];
          var_f9ce76ad7118b7ec = 0;
        } else {
          var_f9ce76ad7118b7ec = var_dd613b6808c13588.size;
        }

        self.array[x][y][var_f9ce76ad7118b7ec] = object;
      }

      function function_5b83b054e7f1c193(vector) {
        assert(is_partition(), "<dev string:x10ee>");
        assert(isDefined(vector), "<dev string:x115b>");
        assert(isvector(vector), "<dev string:x1199>");
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

      function function_9cd3f5f067afea37(object) {
        assert(is_partition(), "<dev string:x11ea>");
        assert(isDefined(object), "<dev string:x124e>");
        assert(isDefined(object.origin), "<dev string:x1283>");
        [x, y] = function_5b83b054e7f1c193(object.origin);
        var_56c8714742ff3c04 = self.array[x];

        if(isDefined(var_56c8714742ff3c04) && isDefined(var_56c8714742ff3c04[y])) {
          self.array[x][y] = array_remove(var_56c8714742ff3c04[y], object);

          if(self.array[x][y].size == 0) {
            self.array[x][y] = undefined;

            if(self.array[x].size == 0) {
              self.array[x] = undefined;
            }
          }
        }
      }

      function function_99b7cb4906b8cb4f(vector) {
        assert(is_partition(), "<dev string:x12c8>");
        assert(isDefined(vector), "<dev string:x132f>");
        assert(isvector(vector), "<dev string:x1368>");
        [x, y] = function_5b83b054e7f1c193(vector);
        var_56c8714742ff3c04 = self.array[x];

        if(isDefined(var_56c8714742ff3c04)) {
          var_dd613b6808c13588 = var_56c8714742ff3c04[y];

          if(isDefined(var_dd613b6808c13588)) {
            return var_dd613b6808c13588;
          }
        }

        return [];
      }

      function function_df633f460888a47(vector) {
        assert(is_partition(), "<dev string:x13b3>");
        assert(isDefined(vector), "<dev string:x1424>");
        assert(isvector(vector), "<dev string:x1466>");
        [x, y] = function_5b83b054e7f1c193(vector);
        adjacent_arrays = [];

        for(x_offset = -1; x_offset <= 1; x_offset++) {
          x_test = x + x_offset;

          if(x_test < 0) {
            continue;
          }

          var_56c8714742ff3c04 = self.array[x_test];

          if(!isDefined(var_56c8714742ff3c04)) {
            continue;
          }

          for(y_offset = -1; y_offset <= 1; y_offset++) {
            y_test = y + y_offset;

            if(y_test < 0) {
              continue;
            }

            var_dd613b6808c13588 = var_56c8714742ff3c04[y_test];

            if(!isDefined(var_dd613b6808c13588)) {
              continue;
            }

            adjacent_arrays[adjacent_arrays.size] = var_dd613b6808c13588;
          }
        }

        return adjacent_arrays;
      }

      function function_60dbe20f8385f1b0(vector) {
        assert(is_partition(), "<dev string:x14bb>");
        assert(isDefined(vector), "<dev string:x1533>");
        assert(isvector(vector), "<dev string:x157c>");
        [x, y] = function_5b83b054e7f1c193(vector);
        closest_object = undefined;
        closest_distance_squared = undefined;

        for(x_offset = -1; x_offset <= 1; x_offset++) {
          x_test = x + x_offset;

          if(x_test < 0) {
            continue;
          }

          var_56c8714742ff3c04 = self.array[x_test];

          if(!isDefined(var_56c8714742ff3c04)) {
            continue;
          }

          for(y_offset = -1; y_offset <= 1; y_offset++) {
            y_test = y + y_offset;

            if(y_test < 0) {
              continue;
            }

            var_dd613b6808c13588 = var_56c8714742ff3c04[y_test];

            if(!isDefined(var_dd613b6808c13588)) {
              continue;
            }

            foreach(object in var_dd613b6808c13588) {
              if(!isDefined(object) || !isDefined(object.origin)) {
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

      function registersharedfunc(category, funcname, function, nooverride) {
        if(!isDefined(level.sharedfuncs)) {
          level.sharedfuncs = [];
        }

        if(!isDefined(level.sharedfuncs[category])) {
          level.sharedfuncs[category] = [];
        }

        if(isDefined(level.sharedfuncs[category][funcname]) && istrue(nooverride)) {
          return;
        }

        level.sharedfuncs[category][funcname] = function;
      }

      function function_3bd171ed299fd530(category, funcname, function, forceremove) {
        if(isDefined(level.sharedfuncs) && isDefined(level.sharedfuncs[category])) {
          if(isDefined(level.sharedfuncs[category][funcname])) {
            if(istrue(forceremove) || level.sharedfuncs[category][funcname] == function) {
              level.sharedfuncs[category] = array_remove_key(level.sharedfuncs[category], funcname);
            }
          }
        }
      }

      function function_7ae9075c73180af7(category) {
        if(!isDefined(level.sharedfuncs)) {
          level.sharedfuncs = [];
        }

        if(!isDefined(level.sharedfuncs[category])) {
          level.sharedfuncs[category] = [];
        }
      }

      function issharedfuncdefined(category, funcname, shouldassert) {
        if(!isDefined(level.sharedfuncs)) {
          return false;
        }

        if(!isDefined(level.sharedfuncs[category])) {
          return false;
        }

        func = getsharedfunc(category, funcname);

        if(!isDefined(func)) {
          if(istrue(shouldassert)) {
            assertmsg(category + "<dev string:x15d8>" + funcname + "<dev string:x15de>");
          }

          return false;
        }

        return true;
      }

      function function_6a11999c562cf4ab(category, funcname) {
        if(!isDefined(level.sharedfuncs[category])) {
          return undefined;
        }

        return level.sharedfuncs[category][funcname];
      }

      function getsharedfunc(category, funcname) {
        return level.sharedfuncs[category][funcname];
      }

      function callsharedfunc(category, funcname, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11) {
        return function_f6734d8246596c7f(category, funcname, 0, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
      }

      function function_6d1f056f62ed082a(category, funcname, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11) {
        return function_f6734d8246596c7f(category, funcname, 1, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
      }

      function private function_f6734d8246596c7f(category, funcname, required, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11) {
        if(issharedfuncdefined(category, funcname, required)) {
          func = level.sharedfuncs[category][funcname];
          return function_a97bcc1cab7d91ee(func, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
        }

        return 0;
      }

      function private function_38d3c10d2527cb3a(func) {
        if(isfunction(func)) {
          return self[[func]]();
        }

        if(isbuiltinfunction(func)) {
          return builtin[[func]]();
        }

        assert(isbuiltinmethod(func));
        return self builtin[[func]]();
      }

      function private function_38d3c20d2527cd6d(func, param1) {
        if(isfunction(func)) {
          return self[[func]](param1);
        }

        if(isbuiltinfunction(func)) {
          return builtin[[func]](param1);
        }

        assert(isbuiltinmethod(func));
        return self builtin[[func]](param1);
      }

      function private function_38d3bf0d2527c6d4(func, param1, param2) {
        if(isfunction(func)) {
          return self[[func]](param1, param2);
        }

        if(isbuiltinfunction(func)) {
          return builtin[[func]](param1, param2);
        }

        assert(isbuiltinmethod(func));
        return self builtin[[func]](param1, param2);
      }

      function private function_38d3c00d2527c907(func, param1, param2, param3) {
        if(isfunction(func)) {
          return self[[func]](param1, param2, param3);
        }

        if(isbuiltinfunction(func)) {
          return builtin[[func]](param1, param2, param3);
        }

        assert(isbuiltinmethod(func));
        return self builtin[[func]](param1, param2, param3);
      }

      function private function_38d3bd0d2527c26e(func, param1, param2, param3, param4) {
        if(isfunction(func)) {
          return self[[func]](param1, param2, param3, param4);
        }

        if(isbuiltinfunction(func)) {
          return builtin[[func]](param1, param2, param3, param4);
        }

        assert(isbuiltinmethod(func));
        return self builtin[[func]](param1, param2, param3, param4);
      }

      function private function_38d3be0d2527c4a1(func, param1, param2, param3, param4, param5) {
        if(isfunction(func)) {
          return self[[func]](param1, param2, param3, param4, param5);
        }

        if(isbuiltinfunction(func)) {
          return builtin[[func]](param1, param2, param3, param4, param5);
        }

        assert(isbuiltinmethod(func));
        return self builtin[[func]](param1, param2, param3, param4, param5);
      }

      function private function_38d3bb0d2527be08(func, param1, param2, param3, param4, param5, param6) {
        if(isfunction(func)) {
          return self[[func]](param1, param2, param3, param4, param5, param6);
        }

        if(isbuiltinfunction(func)) {
          return builtin[[func]](param1, param2, param3, param4, param5, param6);
        }

        assert(isbuiltinmethod(func));
        return self builtin[[func]](param1, param2, param3, param4, param5, param6);
      }

      function private function_38d3bc0d2527c03b(func, param1, param2, param3, param4, param5, param6, param7) {
        if(isfunction(func)) {
          return self[[func]](param1, param2, param3, param4, param5, param6, param7);
        }

        if(isbuiltinfunction(func)) {
          return builtin[[func]](param1, param2, param3, param4, param5, param6, param7);
        }

        assert(isbuiltinmethod(func));
        return self builtin[[func]](param1, param2, param3, param4, param5, param6, param7);
      }

      function private function_38d3b90d2527b9a2(func, param1, param2, param3, param4, param5, param6, param7, param8) {
        if(isfunction(func)) {
          return self[[func]](param1, param2, param3, param4, param5, param6, param7, param8);
        }

        if(isbuiltinfunction(func)) {
          return builtin[[func]](param1, param2, param3, param4, param5, param6, param7, param8);
        }

        assert(isbuiltinmethod(func));
        return self builtin[[func]](param1, param2, param3, param4, param5, param6, param7, param8);
      }

      function private function_38d3ba0d2527bbd5(func, param1, param2, param3, param4, param5, param6, param7, param8, param9) {
        if(isfunction(func)) {
          return self[[func]](param1, param2, param3, param4, param5, param6, param7, param8, param9);
        }

        if(isbuiltinfunction(func)) {
          return builtin[[func]](param1, param2, param3, param4, param5, param6, param7, param8, param9);
        }

        assert(isbuiltinmethod(func));
        return self builtin[[func]](param1, param2, param3, param4, param5, param6, param7, param8, param9);
      }

      function private function_21811fe8b688a387(func, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10) {
        if(isfunction(func)) {
          return self[[func]](param1, param2, param3, param4, param5, param6, param7, param8, param9, param10);
        }

        if(isbuiltinfunction(func)) {
          return builtin[[func]](param1, param2, param3, param4, param5, param6, param7, param8, param9, param10);
        }

        assert(isbuiltinmethod(func));
        return self builtin[[func]](param1, param2, param3, param4, param5, param6, param7, param8, param9, param10);
      }

      function private function_21811ee8b688a154(func, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11) {
        if(isfunction(func)) {
          return self[[func]](param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
        }

        if(isbuiltinfunction(func)) {
          return builtin[[func]](param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
        }

        assert(isbuiltinmethod(func));
        return self builtin[[func]](param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
      }

      function private function_a97bcc1cab7d91ee(func, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11) {
        if(isDefined(param11)) {
          return function_21811ee8b688a154(func, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
        } else if(isDefined(param10)) {
          return function_21811fe8b688a387(func, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10);
        } else if(isDefined(param9)) {
          return function_38d3ba0d2527bbd5(func, param1, param2, param3, param4, param5, param6, param7, param8, param9);
        } else if(isDefined(param8)) {
          return function_38d3b90d2527b9a2(func, param1, param2, param3, param4, param5, param6, param7, param8);
        } else if(isDefined(param7)) {
          return function_38d3bc0d2527c03b(func, param1, param2, param3, param4, param5, param6, param7);
        } else if(isDefined(param6)) {
          return function_38d3bb0d2527be08(func, param1, param2, param3, param4, param5, param6);
        } else if(isDefined(param5)) {
          return function_38d3be0d2527c4a1(func, param1, param2, param3, param4, param5);
        } else if(isDefined(param4)) {
          return function_38d3bd0d2527c26e(func, param1, param2, param3, param4);
        } else if(isDefined(param3)) {
          return function_38d3c00d2527c907(func, param1, param2, param3);
        } else if(isDefined(param2)) {
          return function_38d3bf0d2527c6d4(func, param1, param2);
        } else if(isDefined(param1)) {
          return function_38d3c20d2527cd6d(func, param1);
        } else {
          return function_38d3c10d2527cb3a(func);
        }

        return 0;
      }

      function function_a655374a990831d8(ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7) {
        return function_ac1863f0deb8a63e(undefined, ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7);
      }

      function function_ac1863f0deb8a63e(timeout, ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7) {
        assert(!isDefined(timeout) || timeout > 0);
        assert(isDefined(ent1));
        assert(isDefined(string1));
        self endon("death");
        context = spawnStruct();
        context.var_a83666b52ab41e0d = 0;
        context.var_9166fb2e27ecb4b1 = isDefined(ent1) && isDefined(string1) && string1 == "death" || isDefined(ent2) && isDefined(string2) && string2 == "death" || isDefined(ent3) && isDefined(string3) && string3 == "death" || isDefined(ent4) && isDefined(string4) && string4 == "death" || isDefined(ent5) && isDefined(string5) && string5 == "death" || isDefined(ent6) && isDefined(string6) && string6 == "death" || isDefined(ent7) && isDefined(string7) && string7 == "death";
        function_24b0694682c6934a(ent1, string1, context);

        if(isDefined(ent2) && isDefined(string2)) {
          function_24b0694682c6934a(ent2, string2, context);
        }

        if(isDefined(ent3) && isDefined(string3)) {
          function_24b0694682c6934a(ent3, string3, context);
        }

        if(isDefined(ent4) && isDefined(string4)) {
          function_24b0694682c6934a(ent4, string4, context);
        }

        if(isDefined(ent5) && isDefined(string5)) {
          function_24b0694682c6934a(ent5, string5, context);
        }

        if(isDefined(ent6) && isDefined(string6)) {
          function_24b0694682c6934a(ent6, string6, context);
        }

        if(isDefined(ent7) && isDefined(string7)) {
          function_24b0694682c6934a(ent7, string7, context);
        }

        if(isDefined(timeout)) {
          context childthread timeout_struct(timeout);
        }

        context waittill("returned", msg);
        context notify("die");
        return msg;
      }

      function function_24b0694682c6934a(entity, message, context) {
        entity childthread waittill_string(message, context);

        if(!context.var_9166fb2e27ecb4b1) {
          context.var_a83666b52ab41e0d++;
          childthread function_54258b3847b3bbca(entity, context);
        }
      }

      function function_54258b3847b3bbca(entity, context) {
        context endon("die");
        entity waittill("death");
        context.var_a83666b52ab41e0d--;

        if(context.var_a83666b52ab41e0d == 0) {
          context notify("returned", undefined);
        }
      }

      function function_28551e899093b138(string1, string2, string3, string4, string5, string6, string7, string8) {
        if((!isDefined(string1) || string1 != "death") && (!isDefined(string2) || string2 != "death") && (!isDefined(string3) || string3 != "death") && (!isDefined(string4) || string4 != "death") && (!isDefined(string5) || string5 != "death") && (!isDefined(string6) || string6 != "death") && (!isDefined(string7) || string7 != "death") && (!isDefined(string8) || string8 != "death")) {
          self endon("death");
        }

        struct = spawnStruct();

        if(isDefined(string1)) {
          childthread function_acb8d1f52b2223cb(string1, struct);
        }

        if(isDefined(string2)) {
          childthread function_acb8d1f52b2223cb(string2, struct);
        }

        if(isDefined(string3)) {
          childthread function_acb8d1f52b2223cb(string3, struct);
        }

        if(isDefined(string4)) {
          childthread function_acb8d1f52b2223cb(string4, struct);
        }

        if(isDefined(string5)) {
          childthread function_acb8d1f52b2223cb(string5, struct);
        }

        if(isDefined(string6)) {
          childthread function_acb8d1f52b2223cb(string6, struct);
        }

        if(isDefined(string7)) {
          childthread function_acb8d1f52b2223cb(string7, struct);
        }

        if(isDefined(string8)) {
          childthread function_acb8d1f52b2223cb(string8, struct);
        }

        struct waittill("returned", results_array);
        struct notify("struct_delete");
        return results_array;
      }

      function function_b90de82e759099dc(timeout, string1, string2, string3, string4, string5, string6, string7, string8) {
        if(!isDefined(timeout) || !isnumber(timeout)) {
          assertmsg("<dev string:x1601>");
        }

        if((!isDefined(string1) || string1 != "death") && (!isDefined(string2) || string2 != "death") && (!isDefined(string3) || string3 != "death") && (!isDefined(string4) || string4 != "death") && (!isDefined(string5) || string5 != "death") && (!isDefined(string6) || string6 != "death") && (!isDefined(string7) || string7 != "death") && (!isDefined(string8) || string8 != "death")) {
          self endon("death");
        }

        struct = spawnStruct();

        if(isDefined(string1)) {
          childthread function_acb8d1f52b2223cb(string1, struct);
        }

        if(isDefined(string2)) {
          childthread function_acb8d1f52b2223cb(string2, struct);
        }

        if(isDefined(string3)) {
          childthread function_acb8d1f52b2223cb(string3, struct);
        }

        if(isDefined(string4)) {
          childthread function_acb8d1f52b2223cb(string4, struct);
        }

        if(isDefined(string5)) {
          childthread function_acb8d1f52b2223cb(string5, struct);
        }

        if(isDefined(string6)) {
          childthread function_acb8d1f52b2223cb(string6, struct);
        }

        if(isDefined(string7)) {
          childthread function_acb8d1f52b2223cb(string7, struct);
        }

        if(isDefined(string8)) {
          childthread function_acb8d1f52b2223cb(string8, struct);
        }

        if(timeout > 0) {
          childthread function_cb4bda23f2687c64(struct, "returned", timeout);
        }

        struct waittill("returned", results_array);
        struct notify("struct_delete");
        return results_array;
      }

      function function_3c010dc06eabfe5f(ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7, ent8, string8) {
        params[0] = ent1;
        params[1] = string1;
        params[2] = ent2;
        params[3] = string2;
        params[4] = ent3;
        params[5] = string3;
        params[6] = ent4;
        params[7] = string4;
        params[8] = ent5;
        params[9] = string5;
        params[10] = ent6;
        params[11] = string6;
        params[12] = ent7;
        params[13] = string7;
        params[14] = ent8;
        params[15] = string8;

        for(i = 0; i < params.size; i++) {
          if(i % 2 == 0 && isDefined(params[i]) && !isent(params[i]) && !isstruct(params[i])) {
            assertmsg("<dev string:x1655>" + i + 1 + "<dev string:x168d>" + i / 2 + 1 + "<dev string:x1696>");
          }

          if(i % 2 == 1 && isDefined(params[i]) && !isstring(params[i])) {
            assertmsg("<dev string:x1655>" + i + 1 + "<dev string:x16db>" + (i + 1) / 2 + "<dev string:x16e7>");
          }
        }

        struct = spawnStruct();

        if(isDefined(ent1) && isDefined(string1)) {
          ent1 childthread function_acb8d1f52b2223cb(string1, struct);
        }

        if(isDefined(ent2) && isDefined(string2)) {
          ent2 childthread function_acb8d1f52b2223cb(string2, struct);
        }

        if(isDefined(ent3) && isDefined(string3)) {
          ent3 childthread function_acb8d1f52b2223cb(string3, struct);
        }

        if(isDefined(ent4) && isDefined(string4)) {
          ent4 childthread function_acb8d1f52b2223cb(string4, struct);
        }

        if(isDefined(ent5) && isDefined(string5)) {
          ent5 childthread function_acb8d1f52b2223cb(string5, struct);
        }

        if(isDefined(ent6) && isDefined(string6)) {
          ent6 childthread function_acb8d1f52b2223cb(string6, struct);
        }

        if(isDefined(ent7) && isDefined(string7)) {
          ent7 childthread function_acb8d1f52b2223cb(string7, struct);
        }

        if(isDefined(ent8) && isDefined(string8)) {
          ent8 childthread function_acb8d1f52b2223cb(string8, struct);
        }

        struct waittill("returned", results_array);
        struct notify("struct_delete");
        return results_array;
      }

      function function_ebad8f70ed282931(timeout, ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7, ent8, string8) {
        params[1] = ent1;
        params[2] = string1;
        params[3] = ent2;
        params[4] = string2;
        params[5] = ent3;
        params[6] = string3;
        params[7] = ent4;
        params[8] = string4;
        params[9] = ent5;
        params[10] = string5;
        params[11] = ent6;
        params[12] = string6;
        params[13] = ent7;
        params[14] = string7;
        params[15] = ent8;
        params[16] = string8;

        if(!isDefined(timeout) || !isnumber(timeout)) {
          assertmsg("<dev string:x1601>");
        }

        for(i = 1; i < params.size; i++) {
          if(i % 2 == 1 && isDefined(params[i]) && !isent(params[i])) {
            assertmsg("<dev string:x1655>" + i + 1 + "<dev string:x168d>" + (i + 1) / 2 + "<dev string:x1730>");
          }

          if(i % 2 == 0 && isDefined(params[i]) && !isstring(params[i])) {
            assertmsg("<dev string:x1655>" + i + 1 + "<dev string:x16db>" + i / 2 + "<dev string:x1777>");
          }
        }

        struct = spawnStruct();

        if((!isDefined(string1) || string1 != "death") && (!isDefined(string2) || string2 != "death") && (!isDefined(string3) || string3 != "death") && (!isDefined(string4) || string4 != "death") && (!isDefined(string5) || string5 != "death") && (!isDefined(string6) || string6 != "death") && (!isDefined(string7) || string7 != "death") && (!isDefined(string8) || string8 != "death")) {
          self endon("death");
        }

        if(isDefined(ent1) && isDefined(string1)) {
          ent1 childthread function_acb8d1f52b2223cb(string1, struct);
        }

        if(isDefined(ent2) && isDefined(string2)) {
          ent2 childthread function_acb8d1f52b2223cb(string2, struct);
        }

        if(isDefined(ent3) && isDefined(string3)) {
          ent3 childthread function_acb8d1f52b2223cb(string3, struct);
        }

        if(isDefined(ent4) && isDefined(string4)) {
          ent4 childthread function_acb8d1f52b2223cb(string4, struct);
        }

        if(isDefined(ent5) && isDefined(string5)) {
          ent5 childthread function_acb8d1f52b2223cb(string5, struct);
        }

        if(isDefined(ent6) && isDefined(string6)) {
          ent6 childthread function_acb8d1f52b2223cb(string6, struct);
        }

        if(isDefined(ent7) && isDefined(string7)) {
          ent7 childthread function_acb8d1f52b2223cb(string7, struct);
        }

        if(isDefined(ent8) && isDefined(string8)) {
          ent8 childthread function_acb8d1f52b2223cb(string8, struct);
        }

        if(timeout > 0) {
          level childthread function_cb4bda23f2687c64(struct, "returned", timeout);
        }

        struct waittill("returned", results_array);
        struct notify("struct_delete");
        return results_array;
      }

      function private function_cb4bda23f2687c64(ent, msg, timeout) {
        self endon(msg);
        wait timeout;
        results = [];
        results["ent"] = undefined;
        results["message"] = "timeout";
        ent notify("returned", results);
      }

      function private function_acb8d1f52b2223cb(msg, struct) {
        if(msg != "death") {
          self endon("death");
        }

        struct endon("struct_delete");
        self waittill(msg, parm1, parm2, parm3, parm4, var_77895a5b8a625552, var_7789595b8a62531f, var_7789585b8a6250ec, var_77895f5b8a626051, var_77895e5b8a625e1e, parm10);
        result = [];

        if(isDefined(parm1)) {
          result[0] = parm1;
        }

        if(isDefined(parm2)) {
          result[1] = parm2;
        }

        if(isDefined(parm3)) {
          result[2] = parm3;
        }

        if(isDefined(parm4)) {
          result[3] = parm4;
        }

        if(isDefined(var_77895a5b8a625552)) {
          result[4] = var_77895a5b8a625552;
        }

        if(isDefined(var_7789595b8a62531f)) {
          result[5] = var_7789595b8a62531f;
        }

        if(isDefined(var_7789585b8a6250ec)) {
          result[6] = var_7789585b8a6250ec;
        }

        if(isDefined(var_77895f5b8a626051)) {
          result[7] = var_77895f5b8a626051;
        }

        if(isDefined(var_77895e5b8a625e1e)) {
          result[8] = var_77895e5b8a625e1e;
        }

        if(isDefined(parm10)) {
          result[9] = parm10;
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
            assertmsg("<dev string:x17bd>");
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

      function function_5e9baece4185ee1e(bundlename) {
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
            assert(!isDefined(level.globalbundles[bundlename][0].var_ba90822709a29aa2));
            level.globalbundles[bundlename][0].var_ba90822709a29aa2 = bundlename;
            level.globalbundles[bundlename][1] = 0;
          } else {
            level.globalbundles[bundlename] = undefined;
            return undefined;
          }
        }

        level.globalbundles[bundlename][1] += 1;
        return level.globalbundles[bundlename][0];
      }

      function function_680ff86fdba6e483(bundlestruct) {
        if(!isDefined(bundlestruct)) {
          return;
        }

        if(!isDefined(level.globalbundles)) {
          return;
        }

        assert(isDefined(bundlestruct.var_ba90822709a29aa2));
        bundlename = bundlestruct.var_ba90822709a29aa2;

        if(!isDefined(level.globalbundles[bundlename])) {
          return;
        }

        level.globalbundles[bundlename][1] -= 1;

        if(level.globalbundles[bundlename][1] <= 0) {
          level.globalbundles[bundlename] = undefined;
        }
      }

      function function_eadd787ef68ba356(object) {
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

      function function_beed97b4da27070e() {
        queue = self;

        while(isDefined(queue.head)) {
          object = queue.head.object;
          queue.head = queue.head.next;

          if(!isDefined(queue.head)) {
            queue.tail = undefined;
          }

          if(isDefined(object)) {
            return object;
          }
        }

        return undefined;
      }

      function function_4676b0931a17998a(array) {
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

      function function_fe32d769b4bbd6a1(object, string) {
        object waittill(string);

        if(isDefined(self)) {
          self delete();
        }
      }

      function function_2bf8ec790b5a10f8(dvar, func, args) {
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

      function function_faefc2306b38a0b2(dvar, func, args) {
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

      function function_c306c2fab085ed0e(dvar, value, func, args) {
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

      function function_c71faf21f94673a3(dvar, value, func, args) {
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

      function function_2bf5388598cc6836(dvar, value, func, args) {
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

      function function_ee26a62ef3d1372d(dvar_name, default_value, var_5e073b266eeb0520) {
        return function_2155c1bc405429a3(getdvarint(dvar_name, default_value), default_value, var_5e073b266eeb0520);
      }

      function function_370c5539313daf66(dvar_name, default_value, var_5e073b266eeb0520) {
        return function_2155c1bc405429a3(getdvarfloat(dvar_name, default_value), default_value, var_5e073b266eeb0520);
      }

      function function_680811466c2e6053(dvar_name, default_value, var_5e073b266eeb0520) {
        return function_2155c1bc405429a3(getdvarvector(dvar_name, default_value), default_value, var_5e073b266eeb0520);
      }

      function function_ba70ea4e80f22895(dvar_name, default_value, var_5e073b266eeb0520) {
        return function_2155c1bc405429a3(getDvar(dvar_name, default_value), default_value, var_5e073b266eeb0520);
      }

      function private function_2155c1bc405429a3(dvar_value, default_value, var_5e073b266eeb0520) {
        assert(isDefined(default_value));
        return_value = default_value;

        if(isDefined(dvar_value) && dvar_value != default_value) {
          return_value = dvar_value;
        } else {
          return_value = ter_op(isDefined(var_5e073b266eeb0520), var_5e073b266eeb0520, default_value);
        }

        return return_value;
      }