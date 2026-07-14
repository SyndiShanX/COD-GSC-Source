/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\callbacks.gsc
****************************************/

#using scripts\engine\utility;
#namespace callback;

function callback(event, params = {}) {
  assert(isstruct(params), "<dev string:x24>");
  function_e019c346be830cd(level, event, params);

  if(self != level) {
    function_e019c346be830cd(self, event, params);

    if(isDefined(self.var_947e48b35db244d1)) {
      foreach(callback_template in self.var_947e48b35db244d1) {
        function_e019c346be830cd(callback_template, event, params);
      }
    }
  }
}

function response(type, event, params = {}) {
  assert(isstruct(params), "<dev string:x24>");
  eval = function_5f5d84cefece4c79(type, level, event, params);

  if(eval.done == 1) {
    return eval.val;
  }

  if(self != level) {
    eval = function_5f5d84cefece4c79(type, self, event, params);

    if(eval.done == 1) {
      return eval.val;
    }

    if(isDefined(self.var_947e48b35db244d1)) {
      foreach(callback_template in self.var_947e48b35db244d1) {
        eval = function_5f5d84cefece4c79(type, callback_template, event, params);

        if(eval.done == 1) {
          return eval.val;
        }
      }
    }
  }

  eval = function_9f857585dea1ad55(type, eval);
  return eval.val;
}

function call_on_all_ai(event, params) {
  ais = getaiarray();

  foreach(ai in ais) {
    ai function_e019c346be830cd(ai, event, params);
  }
}

function function_48f0827691e6e0ff(event, params) {
  players = level.players;

  foreach(player in players) {
    player function_e019c346be830cd(level, event, params);
    player function_e019c346be830cd(player, event, params);
  }
}

function private function_e019c346be830cd(ent, event, params) {
  callbacks = ent.callbacks[event];

  if(!isDefined(callbacks)) {
    return;
  }

  for(i = 0; i < callbacks.size; i++) {
    callback_fields = callbacks[i];
    callback = callback_fields[0];

    if(callback_fields.size > 1) {
      self thread[[callback]](params, callback_fields[1]);
      continue;
    }

    self thread[[callback]](params);
  }
}

function private function_331b35582ffb4f0a(type, value, prev_eval) {
  switch (type) {
    case 0:
      if(value == 1) {
        return {
          #val: 1, #done: 1
        };
      }

      break;
    case 1:
      if(value == 0) {
        return {
          #val: 1, #done: 1
        };
      }

      break;
    case 2:
      if(value == 0) {
        return {
          #val: 0, #done: 1
        };
      }

      break;
    case 3:
      if(value == 1) {
        return {
          #val: 0, #done: 1
        };
      }

      break;
    case 4:
      if(!isDefined(prev_eval.val) || value > prev_eval.val) {
        return {
          #val: value, #done: 0
        };
      }

      return prev_eval;
    case 5:
      if(!isDefined(prev_eval.val) || value < prev_eval.val) {
        return {
          #val: value, #done: 0
        };
      }

      return prev_eval;
  }

  return {
    #done: 0
  };
}

function private function_9f857585dea1ad55(type, eval) {
  ret = {
    #done: 0
  };

  switch (type) {
    case 4:
    case 5:
      ret.val = eval.val ?? 0;
      break;
    case 2:
    case 3:
      ret.val = 1;
      break;
    case 0:
    case 1:
      ret.val = 0;
      break;
    default:
      ret.val = 0;
      break;
  }

  return ret;
}

function private function_5f5d84cefece4c79(type, ent, event, params) {
  profilestart();
  callbacks = ent.callbacks[event];

  if(!isDefined(callbacks)) {
    profilestop();
    return;
  }

  eval = {
    #done: 0
  };

  for(i = 0; i < callbacks.size; i++) {
    callback_fields = callbacks[i];
    callback = callback_fields[0];

    if(callback_fields.size > 1) {
      ret = self[[callback]](params, callback_fields[1]);
    } else {
      ret = self[[callback]](params);
    }

    assert(isDefined(ret));
    eval = function_331b35582ffb4f0a(type, ret, eval);

    if(eval.done == 1) {
      profilestop();
      return eval;
    }
  }

  profilestop();
  return function_9f857585dea1ad55(type, eval);
}

function add(event, func, var_82a9e1b3da572654) {
  if(!isfunction(func)) {
    assertmsg("<dev string:x60>" + (isxhash(event) ? getxhashsourcename(event) : event) + "<dev string:x79>");
    return;
  }

  if(!isDefined(event)) {
    assertmsg("<dev string:x99>");
    return;
  }

  if(!isDefined(self.callbacks[event])) {
    self.callbacks[event] = [];
  }

  foreach(callback in self.callbacks[event]) {
    if(isarray(callback) && callback[0] == func) {
      if(!isDefined(callback[1]) && !isDefined(var_82a9e1b3da572654) || callback[1] == var_82a9e1b3da572654) {
        assertmsg("<dev string:xcc>" + (isxhash(event) ? getxhashsourcename(event) : event));
      }
    }
  }

  self.callbacks[event][self.callbacks[event].size] = [func, var_82a9e1b3da572654];
}

function remove(event, func, var_82a9e1b3da572654) {
  if(!isDefined(event)) {
    assertmsg("<dev string:xfd>");
    return;
  }

  thread remove_internal(event, func, var_82a9e1b3da572654);
}

function exists(event, func, var_82a9e1b3da572654) {
  if(!isfunction(func)) {
    assertmsg("<dev string:x60>" + (isxhash(event) ? getxhashsourcename(event) : event) + "<dev string:x79>");
    return false;
  }

  if(!isDefined(event)) {
    assertmsg("<dev string:x133>");
    return false;
  }

  if(isDefined(self.callbacks[event])) {
    foreach(callback in self.callbacks[event]) {
      if(callback[0] == func) {
        if(!isDefined(callback[1]) && !isDefined(var_82a9e1b3da572654) || callback[1] == var_82a9e1b3da572654) {
          return true;
        }
      }
    }
  }

  return false;
}

function get_template(template_name) {
  if(!isDefined(level.callback_templates)) {
    level.callback_templates = [];
  }

  if(!isDefined(level.callback_templates[template_name])) {
    level.callback_templates[template_name] = {};
  }

  return level.callback_templates[template_name];
}

function function_99edd620ee45cd95(template_name) {
  assert(self != level, "<dev string:x172>");

  if(!isDefined(self.var_947e48b35db244d1[template_name])) {
    self.var_947e48b35db244d1[template_name] = get_template(template_name);
  }
}

function function_494399dbf14431f0(template_name) {
  return isDefined(level.callback_templates[template_name]) && self != level && isDefined(self.var_947e48b35db244d1[template_name]) && self.var_947e48b35db244d1[template_name] == level.callback_templates[template_name];
}

function private function_f01298ee2b91ffee(event, func, var_82a9e1b3da572654) {
  removed_index = undefined;

  if(isDefined(var_82a9e1b3da572654)) {
    foreach(index, func_group in self.callbacks[event]) {
      if(func_group[0] == func && isDefined(func_group[1]) && func_group[1] == var_82a9e1b3da572654) {
        removed_index = index;
        break;
      }
    }
  } else {
    foreach(index, func_group in self.callbacks[event]) {
      if(func_group[0] == func) {
        removed_index = index;
        break;
      }
    }
  }

  return removed_index;
}

function private remove_internal(event, func, var_82a9e1b3da572654) {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.callbacks[event])) {
    return;
  }

  if(func === #"all") {
    self.callbacks[event] = [];
    return;
  }

  var_d4239310c8dded2f = function_f01298ee2b91ffee(event, func, var_82a9e1b3da572654);

  if(!isDefined(var_d4239310c8dded2f)) {
    return;
  }

  self.callbacks[event][var_d4239310c8dded2f][0] = &utility::empty_init_func;
  func = &utility::empty_init_func;
  waittillframeend();

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.callbacks[event])) {
    return;
  }

  var_d4239310c8dded2f = function_f01298ee2b91ffee(event, func, var_82a9e1b3da572654);

  if(isDefined(var_d4239310c8dded2f)) {
    self.callbacks[event][var_d4239310c8dded2f] = undefined;

    if(isint(var_d4239310c8dded2f)) {
      function_cdc669dbc8ea2101(self.callbacks[event]);
    }
  }
}

function private event_handler[stance_changed] stance_changed_callback(params) {
  if(!isDefined(params) || !isDefined(self)) {
    return;
  }

  params.isalive = isalive(self);
  params.time = gettime();
  callback(#"stance_changed", params);
}

function private event_handler[stance_changed_post] function_27656f000f774ebe(params) {
  params.isalive = isalive(self);
  params.time = gettime();
  callback(#"stance_changed_post", params);
  self.laststancechangetime = params.time;
}

function private event_handler[mantle_begin] mantle_begin_callback(params) {
  callback(#"mantle_begin", params);
}

function private event_handler[mantle_end] mantle_end_callback(params) {
  callback(#"mantle_end", params);
}

function private event_handler[jump_begin] jump_begin_callback(params) {
  callback(#"jump_begin", params);
}

function private event_handler[jump_end] jump_end_callback(params) {
  callback(#"jump_end", params);
}

function private event_handler[dtp_begin] dtp_begin_callback(params) {
  callback(#"dtp_begin", params);
}

function private event_handler[dtp_end] dtp_end_callback(params = {}) {
  params.time = gettime();
  callback(#"dtp_end", params);
}

function private event_handler[event_35fdbb1a25e6bc2] function_c0a49e255eff5c00(params) {
  callback(#"hash_be5d6ef21120e023", params);
}

function private event_handler[event_e7b2909656c54d2e] function_1de5ac96dc1e9bfc(params) {
  callback(#"hash_da84f662d754013b", params);
}

function private event_handler[explode] explode_callback(params) {
  callback(#"explode", params);
}

function private event_handler[input_type_changed] input_type_changed_callback(params) {
  callback(#"input_type_changed", params);
}

function private event_handler[sprint_begin] sprint_begin_callback(params) {
  callback(#"sprint_begin", params);
}

function private event_handler[sprint_end] sprint_end_callback(params = {}) {
  params.time = gettime();
  callback(#"sprint_end", params);
}

function private event_handler[sprint_slide_begin] sprint_slide_begin_callback(params) {
  callback(#"sprint_slide_begin", params);
}

function private event_handler[sprint_slide_end] sprint_slide_end_callback(params = {}) {
  params.time = gettime();
  callback(#"sprint_slide_end", params);
}

function private event_handler[event_b70217d016f49960] function_5916270813189d5e(params = {}) {
  params.time = gettime();
  callback(#"hash_3f03a307b9f6e227", params);
}

function private event_handler[player_ads_end] player_ads_end_callback(params) {
  callback(#"player_ads_end", params);
}

function private event_handler[event_2e10fc85899f0d88] function_57cd1ac3b8465136(params) {
  callback(#"hash_884a4bf94d95eb67", params);
}

function private event_handler[event_761f161a3eab12c4] function_e5b623d7919406a2(params) {
  callback(#"hash_75eeb7e76060544f", params);
}

function private event_handler[event_bb6f8df1716434d4] function_7573185818218bb2(params) {
  callback(#"hash_1bf3199fda4b9841", params);
}

function private event_handler[event_8de4d4a7f21f4700] function_88b54ecc6d6bc1be(params) {
  callback(#"hash_48d4e39d6de3f7f1", params);
}

function private event_handler[event_1512c0cb63ead69] function_4e63c03587871f15(params) {
  callback(#"hash_bfe74b2130bdd498", params);
}

function private event_handler[noent_volume_trigger] noent_volume_trigger_callback(params) {
  callback(#"noent_volume_trigger", params);
}

function private event_handler[event_4fdd34de468d6c40] function_20ca138bfae1e2fe(params) {
  callback(#"hash_ed2b0e3798247d41", params);
}

function private event_handler[event_96aca87614d0130c] function_84ca91c635f1331a(params) {
  callback(#"hash_ad99e3d3c9ff54f1", params);
}

function private event_handler[wall_jump_begin] function_fb3740c03688e3d1(params) {
  callback(#"wall_jump_begin", params);
}

function private event_handler[wall_jump_end] function_4b529126a9adcc51(params) {
  callback(#"wall_jump_end", params);
}