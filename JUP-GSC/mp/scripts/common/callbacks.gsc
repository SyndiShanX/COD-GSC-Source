/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\common\callbacks.gsc
***********************************************/

#using scripts\engine\utility;
#namespace callback;

function callback(event, params) {
  if(!isDefined(params)) {
    params = spawnStruct();
  }

  assertex(isstruct(params), "<dev string:x1c>");
  function_f3847410a67a3098(level, event, params);

  if(self != level) {
    function_f3847410a67a3098(self, event, params);

    if(isDefined(self.var_8d44c0f367e8d9c0)) {
      foreach(callback_template in self.var_8d44c0f367e8d9c0) {
        function_f3847410a67a3098(callback_template, event, params);
      }
    }
  }
}

function function_1ad95d714a56c8fa(event, params) {
  ais = getaiarray();

  foreach(ai in ais) {
    ai function_f3847410a67a3098(ai, event, params);
  }
}

function function_ca1462b402444dd6(event, params) {
  players = level.players;

  foreach(player in players) {
    player function_f3847410a67a3098(level, event, params);
    player function_f3847410a67a3098(player, event, params);
  }
}

function private function_f3847410a67a3098(ent, event, params) {
  callbacks = undefined;

  if(isDefined(ent.callbacks)) {
    callbacks = ent.callbacks[event];
  }

  if(isDefined(callbacks)) {
    for(i = 0; i < callbacks.size; i++) {
      callback_fields = callbacks[i];

      if(!isarray(callback_fields)) {
        continue;
      }

      callback = callback_fields[0];
      assert(isfunction(callback));

      if(!isfunction(callback)) {
        return;
      }

      var_732ad454c46f92fd = callback_fields[1];

      if(isDefined(var_732ad454c46f92fd)) {
        self thread[[callback]](params, var_732ad454c46f92fd);
        continue;
      }

      self thread[[callback]](params);
    }

    if(isDefined(ent.callbacks)) {
      if(isDefined(ent.var_fab0247ea0a3a375) && isDefined(ent.var_fab0247ea0a3a375[event])) {
        ent.callbacks[event] = function_816601f7d8ca5b92(ent.callbacks[event]);
        ent.var_fab0247ea0a3a375[event] = undefined;
      }

      assertex(function_c2791ffb5f62cc92(ent.callbacks[event]) == 0, "<dev string:x58>");
    }
  }
}

function add(event, func, var_732ad454c46f92fd) {
  assertex(isfunction(func), "<dev string:xa4>" + (isxhash(event) ? getxhashsourcename(event) : event) + "<dev string:xbd>");

  if(!isfunction(func)) {
    return;
  }

  assertex(isDefined(event), "<dev string:xdd>");

  if(!isDefined(self.callbacks) || !isDefined(self.callbacks[event])) {
    self.callbacks[event] = [];
  }

  foreach(callback in self.callbacks[event]) {
    if(isarray(callback) && callback[0] == func) {
      if(!isDefined(callback[1]) && !isDefined(var_732ad454c46f92fd) || is_equal(callback[1], var_732ad454c46f92fd)) {
        assertmsg("<dev string:x110>" + event);
      }
    }
  }

  self.callbacks[event][self.callbacks[event].size] = [func, var_732ad454c46f92fd];
}

function remove(event, func, instant) {
  if(!isDefined(self.callbacks)) {
    return;
  }

  assertex(isDefined(event), "<dev string:x141>");

  if(isDefined(func) && isxhash(func) && func == #"all") {
    self.callbacks[event] = [];

    if(isDefined(self.var_fab0247ea0a3a375)) {
      self.var_fab0247ea0a3a375[event] = undefined;
    }

    return;
  }

  if(!isDefined(self.callbacks[event])) {
    return;
  }

  foreach(index, func_group in self.callbacks[event]) {
    if(isarray(func_group) && func_group[0] == func) {
      self.callbacks[event][index] = 0;
      self.var_fab0247ea0a3a375[event] = 1;
      break;
    }
  }

  if(istrue(instant)) {
    if(isDefined(self.var_fab0247ea0a3a375) && isDefined(self.var_fab0247ea0a3a375[event])) {
      self.callbacks[event] = function_816601f7d8ca5b92(self.callbacks[event]);
      self.var_fab0247ea0a3a375[event] = undefined;
    }

    assertex(function_c2791ffb5f62cc92(self.callbacks[event]) == 0, "<dev string:x58>");
  }
}

function get_template(template_name) {
  if(!isDefined(level.callback_templates)) {
    level.callback_templates = [];
  }

  if(!isDefined(level.callback_templates[template_name])) {
    level.callback_templates[template_name] = spawnStruct();
  }

  return level.callback_templates[template_name];
}

function function_d4f1fdfa332469ec(template_name) {
  assertex(self != level, "<dev string:x177>");
  template_struct = get_template(template_name);

  if(!isDefined(self.var_8d44c0f367e8d9c0) || !isDefined(self.var_8d44c0f367e8d9c0[template_name])) {
    self.var_8d44c0f367e8d9c0[template_name] = template_struct;
  }
}

function function_75a459cce09d9f29(template_name) {
  return self != level && isDefined(template_name) && isDefined(level.callback_templates) && isDefined(level.callback_templates[template_name]) && isDefined(self.var_8d44c0f367e8d9c0) && isDefined(self.var_8d44c0f367e8d9c0[template_name]) && self.var_8d44c0f367e8d9c0[template_name] == level.callback_templates[template_name];
}

function private function_816601f7d8ca5b92(callbacks) {
  result = [];

  foreach(cb in callbacks) {
    if(isint(cb) && cb == 0) {
      continue;
    }

    result[result.size] = cb;
  }

  assertex(result.size < callbacks.size, "<dev string:x1b2>");
  return result;
}

function private function_c2791ffb5f62cc92(callbacks) {
  foreach(cb in callbacks) {
    if(isint(cb) && cb == 0) {
      return true;
    }
  }

  return false;
}