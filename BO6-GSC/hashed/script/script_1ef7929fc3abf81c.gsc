/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_1ef7929fc3abf81c.gsc
*****************************************************/

#using script_16ea1b94f0f381b3;
#using script_5a4a5d9ba343ff8f;
#using script_686729055b66c6e4;
#namespace effect_stun;

function stun(var_268336382d8077b0, n_durations, var_b5ffc6114d6b2c61, stunscriptablestate, stunanimindex, element_type) {
  assert(isstring(var_268336382d8077b0), "<dev string:x24>");
  assert(isnumber(n_durations), "<dev string:x48>");
  effect = status_effects::function_1c3c4f0aa9a6109a("\xe2:\x9b:", n_durations, var_268336382d8077b0, &start_stun, &end_stun, element_type);
  effect.var_b5ffc6114d6b2c61 = var_b5ffc6114d6b2c61;
  effect.stunscriptablestate = stunscriptablestate;
  effect.stunanimindex = stunanimindex;

  if(isPlayer(var_b5ffc6114d6b2c61)) {
    if(!isDefined(var_268336382d8077b0) || !status_effects::function_94a7f44187606b85("\xe2:\x9b:", var_268336382d8077b0)) {
      if(element_type == "\xbd\xb5R\xcd\xf57\x8cA") {
        var_b5ffc6114d6b2c61 namespace_bc7cdace2d7445a5::doscoreeventsharedfunc(#"electrocuted");
      } else {
        var_b5ffc6114d6b2c61 namespace_bc7cdace2d7445a5::doscoreeventsharedfunc(#"stunned");
      }
    }
  }

  return status_effects::start_effect(effect);
}

function private start_stun(effect) {
  n_time = gettime();
  var_44d97b674dc25ff4 = undefined;
  zombie_stun::stun_ai(effect.durations, effect.stunscriptablestate, effect.stunanimindex);
}

function private end_stun(effect) {}

function stop_stun(var_268336382d8077b0) {
  assert(isstring(var_268336382d8077b0), "<dev string:x6b>");
  zombie_stun::clear_stun();
}

function function_81e41a09409a689b(entity, var_268336382d8077b0) {
  assert(isstring(var_268336382d8077b0), "<dev string:x6b>");

  if(!status_effects::function_49f84c53a7f39086("\xe2:\x9b:")) {
    return false;
  }

  foreach(active_effect in self.status_effects["\xe2:\x9b:"]) {
    if(isDefined(active_effect.unique_id) && var_268336382d8077b0 == active_effect.unique_id && entity === active_effect.var_b5ffc6114d6b2c61) {
      return (active_effect.var_b5ffc6114d6b2c61 == entity);
    }
  }

  return false;
}