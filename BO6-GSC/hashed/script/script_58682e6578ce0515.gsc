/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_58682e6578ce0515.gsc
*****************************************************/

#using script_16ea1b94f0f381b3;
#using script_5a4a5d9ba343ff8f;
#using script_a12e958c96b6c57;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\ai;
#namespace effect_slow;

function slow(var_a4b5ee637814f591, var_c1cd54e74827e214, n_durations, var_b5ffc6114d6b2c61, endcallback, var_c14879bf266c128a, element_type) {
  assert(isstring(var_a4b5ee637814f591), "<dev string:x24>");
  assert(isnumber(var_c1cd54e74827e214), "<dev string:x48>");
  assert(isnumber(n_durations), "<dev string:x6a>");

  if(!function_5763e417ba782b1d(var_c14879bf266c128a)) {
    return 0;
  }

  if(!status_effects::function_49f84c53a7f39086("\x88\x9b\x86{")) {
    self.cachedplaybackrate = asm::asm_getmoveplaybackrate();
  }

  effect = status_effects::function_1c3c4f0aa9a6109a("\x88\x9b\x86{", n_durations, var_a4b5ee637814f591, &start_slow, &end_slow, element_type);
  effect.var_b5ffc6114d6b2c61 = var_b5ffc6114d6b2c61;
  effect.rate = var_c1cd54e74827e214;
  effect.end_callback = endcallback;

  if(isPlayer(var_b5ffc6114d6b2c61) && element_type == "\xe3\xd2\xc4\xe9") {
    if(!isDefined(var_a4b5ee637814f591) || !status_effects::function_94a7f44187606b85("\x88\x9b\x86{", var_a4b5ee637814f591)) {
      var_b5ffc6114d6b2c61 namespace_bc7cdace2d7445a5::doscoreeventsharedfunc(#"frozen");
    }
  }

  return status_effects::start_effect(effect);
}

function function_5763e417ba782b1d(var_c14879bf266c128a) {
  return (istrue(var_c14879bf266c128a) || isDefined(self.aisettings) && istrue(self.aisettings.var_e3a54ded103e3ee3)) && !asm_bb::bb_isanimScripted() && !ai::function_ee346cd5492bbf05(self) && !istrue(self.is_traversing);
}

function private start_slow(effect) {
  n_time = gettime();
  var_44d97b674dc25ff4 = undefined;
  var_f708bd90d535fdb1 = undefined;

  foreach(effect in self.status_effects["\x88\x9b\x86{"]) {
    if(!isDefined(var_f708bd90d535fdb1) || effect.rate < var_f708bd90d535fdb1.rate) {
      var_f708bd90d535fdb1 = effect;
    }

    if(!isDefined(var_44d97b674dc25ff4) || effect.end_time < var_44d97b674dc25ff4) {
      var_44d97b674dc25ff4 = effect.end_time;
    }
  }

  if(zombie_emergence_spawning::function_76c8e0142e37a14a()) {
    self.var_b860e4d268c7ff26 = 1;
    zombie_emergence_spawning::disable_emergence_spawning();
  }

  if(isDefined(var_f708bd90d535fdb1) && n_time < var_44d97b674dc25ff4) {
    function_c91f6bf87acf6f1c(var_f708bd90d535fdb1.rate);
  }
}

function private end_slow(effect) {
  current_time = gettime();
  return_rate = self.cachedplaybackrate ?? 1;
  self.cachedplaybackrate = undefined;

  foreach(active_effect in self.status_effects["\x88\x9b\x86{"]) {
    if(isDefined(active_effect.unique_id) && effect.unique_id == active_effect.unique_id) {
      return;
    }

    if(active_effect.rate < return_rate && active_effect.end_time > current_time) {
      return_rate = active_effect.rate;
    }
  }

  function_c91f6bf87acf6f1c(return_rate);

  if(istrue(self.var_b860e4d268c7ff26)) {
    self.var_b860e4d268c7ff26 = undefined;
    zombie_emergence_spawning::function_724866f07f0c5061();
  }

  if(isDefined(effect.end_callback)) {
    self[[effect.end_callback]]();
  }
}

function private function_c91f6bf87acf6f1c(var_b5b552d0da8430f7) {
  if(!isagent(self)) {
    return;
  }

  if(asm::function_5d3276c039542533() == var_b5b552d0da8430f7) {
    return;
  }

  asm::function_b7fc23cad35ca27f(var_b5b552d0da8430f7);

  if(!istrue(self.is_dying) && gettime() > self.birthtime) {
    asm::function_6c52fc6549e982a0();
  }
}

function stop_slow(var_a4b5ee637814f591) {
  assert(isstring(var_a4b5ee637814f591), "<dev string:x24>");

  foreach(active_effect in self.status_effects["\x88\x9b\x86{"]) {
    if(isDefined(active_effect.unique_id) && var_a4b5ee637814f591 == active_effect.unique_id) {
      active_effect.end_time = -1;
    }
  }
}

function function_b08981453a82d3f5() {
  foreach(active_effect in self.status_effects["\x88\x9b\x86{"]) {
    active_effect.end_time = -1;
  }
}

function is_slowed() {
  return status_effects::function_49f84c53a7f39086("\x88\x9b\x86{");
}

function function_1d298a730f9df812(player, var_a4b5ee637814f591) {
  assert(isstring(var_a4b5ee637814f591), "<dev string:x24>");

  if(!status_effects::function_49f84c53a7f39086("\x88\x9b\x86{")) {
    return false;
  }

  foreach(active_effect in self.status_effects["\x88\x9b\x86{"]) {
    if(isDefined(active_effect.unique_id) && var_a4b5ee637814f591 == active_effect.unique_id && player === active_effect.var_b5ffc6114d6b2c61) {
      return (active_effect.var_b5ffc6114d6b2c61 == player);
    }
  }

  return false;
}