/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\smart_bundle.gsc
***********************************************/

#using script_1162c195eb8dd834;
#using script_71527a5629b857da;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#namespace smart_bundle;

function private autoexec __init__system__() {
  system::register(#"smart_bundle", &preinit, &function_fcaaa05f, undefined, undefined);
}

function private preinit() {
  flag::init("smart_bundle_initialized");
}

function function_fcaaa05f() {
  if(isDefined(level.smart_bundle)) {
    return;
  }

  sb_flags();
  callback::function_f642faf2(&function_2264f2c4);
  level.smart_bundle = spawnStruct();
  level.smart_bundle.var_84410238 = [];
  level.smart_bundle.spawned_axis = [];
  level.smart_bundle.spawnq = [];
  level.smart_bundle.var_78371b11 = 0;
  level.smart_bundle.unique_id = 0;
  level.smart_bundle function_b904b36d();
  level.smart_bundle thread sb_tick();
  level.smart_bundle thread function_4e82b483();
  waitframe(3);
  flag::set("smart_bundle_initialized");
}

function function_8dcff833(var_8a673bc9) {
  ret = [];

  if(!isDefined(var_8a673bc9)) {
    var_8a673bc9 = [];
  } else if(!isarray(var_8a673bc9)) {
    var_8a673bc9 = array(var_8a673bc9);
  }

  foreach(tname in var_8a673bc9) {
    for(i = 0; i < level.smart_bundle.var_84410238.size; i++) {
      if(isDefined(level.smart_bundle.var_84410238[i].targetname) && level.smart_bundle.var_84410238[i].targetname == tname) {
        ret[ret.size] = level.smart_bundle.var_84410238[i];
      }
    }
  }

  return ret;
}

function function_6c12ff6(var_63fded14) {
  var_84410238 = function_8dcff833(var_63fded14);
  assert(var_84410238.size <= 1, "<dev string:x38>" + var_84410238.size + "<dev string:x46>" + var_63fded14 + "<dev string:x69>");

  if(var_84410238.size == 0) {
    return undefined;
  }

  return var_84410238[0];
}

function function_764d4b74() {
  if(isDefined(self.var_38a97b32) && level flag::get(self.var_38a97b32)) {
    level flag::clear(self.var_38a97b32);
  }
}

function function_d57734f6() {
  for(i = 0; i < level.smart_bundle.var_84410238.size; i++) {
    level.smart_bundle.var_84410238[i] function_764d4b74();
  }
}

function function_92da2014() {
  function_d57734f6();
}

function function_20ba1b43(var_63fded14, resume_flag) {
  var_84410238 = function_8dcff833(var_63fded14);

  foreach(smart_bundle in var_84410238) {
    smart_bundle function_69011beb(resume_flag);
  }
}

function function_69011beb(resume_flag) {
  if(!isDefined(self.variantname)) {
    assert(isDefined(self.script_noteworthy) && self.script_noteworthy == "<dev string:xb3>");
  } else {
    assert(self.variantname == "<dev string:xb3>");
  }

  self.var_38a97b32 = resume_flag;
}

function function_f029622c(var_268d3aa4) {
  self endon(#"death");
  self endon(#"hash_740faf03c1eeca5b");

  if(!(self.var_39a8d200 == "active" || self.var_39a8d200 == "wait_deactivate")) {
    self waittill(#"active");
  }

  if(!isDefined(var_268d3aa4) || var_268d3aa4 > self.var_f0a4c650.size) {
    var_268d3aa4 = self.var_f0a4c650.size;
  }

  while(self.var_fe336ab9 < var_268d3aa4) {
    self waittill(#"hash_7fafbdd20ef09362");
    waittillframeend();
  }

  self notify("smart_bundle_" + string(var_268d3aa4) + "_ai_killed");

  if(is_true(self.var_43db0d3e)) {
    self.var_2b96e535 = 0;
    self notify(#"hash_66e053d24034aa6f");
  }
}

function function_e47ac090() {
  self endon(#"death");
  self endon(#"hash_740faf03c1eeca5b");

  if(!(self.var_39a8d200 == "active" || self.var_39a8d200 == "wait_deactivate")) {
    self waittill(#"active");
  }

  while(self.dynamic_ents.size < self.var_f0a4c650.size) {
    self waittill(#"hash_544b598ad6fe9445");
  }
}

function function_ee872d21(var_17736c1e, var_268d3aa4, var_1cbf40f = 1) {
  assert(isarray(var_17736c1e), "<dev string:xc3>");
  max_guys = 0;
  var_455a5bec = function_58ca92b7();
  remover_array = [];

  foreach(smart_bundle in var_17736c1e) {
    smart_bundle endon(#"death");
    smart_bundle endon(#"hash_740faf03c1eeca5b");

    if(!(smart_bundle.var_39a8d200 == "active" || smart_bundle.var_39a8d200 == "wait_deactivate")) {
      if(!is_true(var_1cbf40f)) {
        remover_array[remover_array.size] = smart_bundle;
        continue;
      }

      smart_bundle waittill(#"active");
    }

    max_guys += smart_bundle.var_f0a4c650.size;
    smart_bundle thread function_ad087e3b(var_455a5bec);
  }

  if(remover_array.size > 0) {
    for(i = 0; i < remover_array.size; i++) {
      arrayremovevalue(var_17736c1e, remover_array[i]);
    }
  }

  if(!isDefined(var_268d3aa4) || var_268d3aa4 > max_guys) {
    var_268d3aa4 = max_guys;
  }

  while(function_97118cde(var_17736c1e) < var_268d3aa4) {
    level waittill(var_455a5bec);
    waittillframeend();
  }

  level notify(var_455a5bec + "all_done");
}

function function_ad087e3b(var_455a5bec) {
  level endon(var_455a5bec + "all_done");
  self endon(#"death");
  self endon(#"hash_740faf03c1eeca5b");

  while(true) {
    self waittill(#"hash_7fafbdd20ef09362");
    level notify(var_455a5bec);
  }
}

function function_97118cde(var_17736c1e) {
  tot = 0;

  for(i = 0; i < var_17736c1e.size; i++) {
    tot += var_17736c1e[i].var_fe336ab9;
  }

  return tot;
}

function function_f059be95(set_flag, deadcount, timeout) {
  self endon(#"death");
  self endon(#"hash_740faf03c1eeca5b");

  if(!(self.var_39a8d200 == "active" || self.var_39a8d200 == "wait_deactivate")) {
    self waittill(#"active");
  }

  if(isDefined(timeout)) {
    self thread function_a6169d61(timeout);
  }

  if(!isDefined(deadcount) || deadcount > self.var_f0a4c650.size) {
    deadcount = self.var_f0a4c650.size;
  }

  self thread function_f029622c(deadcount);
  wait_notify = "smart_bundle_" + string(deadcount) + "_ai_killed";
  self waittill(wait_notify, #"hash_1951ecd22ca82373");
  level flag::set(set_flag);
}

function function_5ce85259(var_84410238, set_flag, deadcount, timeout) {
  self endon(#"death");
  self endon(#"hash_740faf03c1eeca5b");

  if(isDefined(timeout)) {
    self thread function_a6169d61(timeout);
  }

  function_ee872d21(var_84410238, deadcount);
  level flag::set(set_flag);
}

function function_a6169d61(timeout) {
  wait timeout;
  self notify(#"hash_1951ecd22ca82373");
}

function function_1ca38b11(state, callback_function) {
  assert(array::contains(["<dev string:x11b>", "<dev string:x12c>", "<dev string:x13c>", "<dev string:x146>", "<dev string:x159>"], state), "<dev string:x168>" + state);
  self.fn_callbacks[state] = callback_function;
}

function function_44cbaa85() {
  function_1eaaceab(self.dynamic_ents);
  return self.dynamic_ents;
}

function function_942bcdf6(var_84410238) {
  guys = [];

  foreach(smart_bundle in var_84410238) {
    guys = arraycombine(guys, smart_bundle function_44cbaa85(), 1, 0);
  }

  return guys;
}

function function_97506362() {
  if(isDefined(self.var_fe336ab9)) {
    return self.var_fe336ab9;
  }

  return 0;
}

function function_39cfddef() {
  if(isDefined(self.var_f0a4c650)) {
    return self.var_f0a4c650.size;
  }

  return self.spawner_ents.size;
}

function function_92f17667(var_17736c1e) {
  total = 0;

  foreach(smart_bundle in var_17736c1e) {
    total += smart_bundle function_39cfddef();
  }

  return total;
}

function function_1f7aae9e() {
  total = self function_39cfddef();
  killed = self function_97506362();
  return total - killed;
}

function function_d96e9b9b(var_17736c1e) {
  total = 0;
  total_killed = 0;

  foreach(smart_bundle in var_17736c1e) {
    total += smart_bundle function_39cfddef();
    total_killed += smart_bundle function_97506362();
  }

  return total - total_killed;
}

function function_79e04d7f() {
  if(self.var_39a8d200 == "wait_deactivate" || self.var_39a8d200 == "active") {
    return true;
  }

  return false;
}