/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_58682e6578ce0515.gsc
*************************************************/

#using script_5a4a5d9ba343ff8f;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\engine\utility;
#namespace effect_slow;

function slow(var_3f84102752151e7c, var_561c4006f65fb505, n_durations, var_d4739501723a457c, endcallback, var_9142743ed938c8bb) {
  assertex(isstring(var_3f84102752151e7c), "<dev string:x1c>");
  assertex(isnumber(var_561c4006f65fb505), "<dev string:x40>");
  assertex(isnumber(n_durations), "<dev string:x62>");

  if(!istrue(var_9142743ed938c8bb)) {
    if(!isDefined(self.aisettings) || !istrue(self.aisettings.var_c9cbc4a3332e44c6)) {
      return 0;
    }
  }

  if(scripts\asm\asm_bb::bb_isanimScripted()) {
    return 0;
  }

  if(!function_8ce7894f1a52fb77("slow")) {
    self.var_8ad91e7d5175af88 = scripts\asm\asm::asm_getmoveplaybackrate();
  }

  effect = function_108973a907c11ca7("slow", n_durations, var_3f84102752151e7c, &start_slow, &end_slow);
  effect.var_d4739501723a457c = var_d4739501723a457c;
  effect.rate = var_561c4006f65fb505;
  effect.end_callback = endcallback;
  return start_effect(effect);
}

function private start_slow(effect) {
  n_time = gettime();
  var_3eab2eda9e5ce31 = undefined;
  var_9751e67c93627448 = undefined;

  foreach(effect in self.status_effects["slow"]) {
    if(!isDefined(var_9751e67c93627448) || effect.rate < var_9751e67c93627448.rate) {
      var_9751e67c93627448 = effect;
    }

    if(!isDefined(var_3eab2eda9e5ce31) || effect.end_time < var_3eab2eda9e5ce31) {
      var_3eab2eda9e5ce31 = effect.end_time;
    }
  }

  if(isDefined(var_9751e67c93627448) && n_time < var_3eab2eda9e5ce31) {
    function_3d9c0570527484dd(var_9751e67c93627448.rate);
  }
}

function private end_slow(effect) {
  current_time = gettime();
  return_rate = default_to(self.var_8ad91e7d5175af88, 1);

  foreach(active_effect in self.status_effects["slow"]) {
    if(isDefined(active_effect.unique_id) && effect.unique_id == active_effect.unique_id) {
      return;
    }

    if(active_effect.rate < return_rate && active_effect.end_time > current_time) {
      return_rate = active_effect.rate;
    }
  }

  function_3d9c0570527484dd(return_rate);

  if(isDefined(effect.end_callback)) {
    self[[effect.end_callback]]();
  }
}

function private function_3d9c0570527484dd(var_41e050c00dbd88ee) {
  if(!isagent(self)) {
    return;
  }

  if(scripts\asm\asm::function_4bb232c0fca955f6() == var_41e050c00dbd88ee) {
    return;
  }

  scripts\asm\asm::function_8d1655ae223d862a(var_41e050c00dbd88ee);

  if(!istrue(self.is_traversing) && !istrue(self.is_dying) && gettime() > self.birthtime) {
    function_6e9cb6cd0535fe65();
  }
}

function stop_slow(var_3f84102752151e7c) {
  assertex(isstring(var_3f84102752151e7c), "<dev string:x1c>");

  foreach(active_effect in self.status_effects["slow"]) {
    if(isDefined(active_effect.unique_id) && var_3f84102752151e7c == active_effect.unique_id) {
      active_effect.end_time = -1;
    }
  }
}

function function_778c51b997394ed8() {
  foreach(active_effect in self.status_effects["slow"]) {
    active_effect.end_time = -1;
  }
}

function is_slowed() {
  return function_8ce7894f1a52fb77("slow");
}

function has_slow(var_3f84102752151e7c) {
  assertex(isstring(var_3f84102752151e7c), "<dev string:x1c>");

  if(!function_8ce7894f1a52fb77("slow")) {
    return false;
  }

  foreach(active_effect in self.status_effects["slow"]) {
    if(isDefined(active_effect.unique_id) && var_3f84102752151e7c == active_effect.unique_id) {
      return true;
    }
  }

  return false;
}

function function_47062c0baf4e14bf(player, var_3f84102752151e7c) {
  assertex(isstring(var_3f84102752151e7c), "<dev string:x1c>");

  if(!function_8ce7894f1a52fb77("slow")) {
    return false;
  }

  foreach(active_effect in self.status_effects["slow"]) {
    if(isDefined(active_effect.unique_id) && var_3f84102752151e7c == active_effect.unique_id && isDefined(player) && isDefined(self.var_d76f87abeca1eaa3[var_3f84102752151e7c].var_d4739501723a457c)) {
      return (active_effect.var_d4739501723a457c == player);
    }
  }

  return false;
}